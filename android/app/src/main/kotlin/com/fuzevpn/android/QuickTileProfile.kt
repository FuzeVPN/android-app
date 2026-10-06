package com.fuzevpn.android

import org.json.JSONArray
import org.json.JSONObject

/**
 * The last tunnel that reached a native connected proof. It is encrypted by
 * [SecureKeystoreStore] and is the only profile the Quick Settings tile may
 * reconnect. No token, private key, OpenVPN certificate, CSR, or canonical
 * OpenVPN profile is duplicated into this record.
 */
internal data class QuickTileProfile(
    val protocol: VpnProtocol,
    val accountId: String,
    val deviceId: String,
    val locationId: String,
    val locationName: String,
    val wireGuardRequest: WireGuardRequest? = null,
    val openVpnNetwork: TunnelNetworkSpec? = null,
) {
    init {
        requireIdentifier(accountId)
        requireIdentifier(deviceId)
        requireIdentifier(locationId)
        requireDisplayName(locationName)
        require((protocol == VpnProtocol.WIREGUARD) == (wireGuardRequest != null))
        require(protocol == VpnProtocol.OPENVPN || openVpnNetwork == null)
        wireGuardRequest?.let {
            require(it.accountId == accountId && it.deviceId == deviceId)
            require(it.locationId == locationId && it.locationName == locationName)
        }
    }

    fun encode(): String = JSONObject().apply {
        put("version", FORMAT_VERSION)
        put("protocol", protocol.wireValue)
        put("account_id", accountId)
        put("device_id", deviceId)
        put("location_id", locationId)
        put("location_name", locationName)
        openVpnNetwork?.let { put("openvpn_network", JSONObject(it.encode())) }
        wireGuardRequest?.let { request ->
            put("wireguard", JSONObject().apply {
                put("address", request.address)
                put("dns", JSONArray(request.dns))
                put("server_public_key", request.serverPublicKey)
                put("endpoint", request.endpoint)
                put("allowed_ips", JSONArray(request.allowedIps))
                put("addresses", JSONArray(request.network.addresses))
                put("ip_families", JSONArray(request.network.ipFamilies))
            })
        }
    }.toString()

    companion object {
        private const val FORMAT_VERSION = 1
        private val identifier = Regex("[A-Za-z0-9._-]{1,160}")

        fun decode(value: String): QuickTileProfile? = runCatching {
            require(value.length in 2..MAX_ENCODED_LENGTH)
            val root = JSONObject(value)
            require(root.getInt("version") == FORMAT_VERSION)
            val protocol = VpnProtocol.fromWireValue(root.getString("protocol"))
                ?: error("invalid_protocol")
            val accountId = root.getString("account_id").also(::requireIdentifier)
            val deviceId = root.getString("device_id").also(::requireIdentifier)
            val locationId = root.getString("location_id").also(::requireIdentifier)
            val locationName = root.getString("location_name").also(::requireDisplayName)
            val request = if (protocol == VpnProtocol.WIREGUARD) {
                val wireGuard = root.getJSONObject("wireguard")
                WireGuardRequest(
                    accountId = accountId,
                    deviceId = deviceId,
                    locationId = locationId,
                    locationName = locationName,
                    address = wireGuard.requiredText("address"),
                    dns = wireGuard.requiredList("dns", 8),
                    serverPublicKey = wireGuard.requiredText("server_public_key"),
                    endpoint = wireGuard.requiredText("endpoint"),
                    allowedIps = wireGuard.requiredList("allowed_ips", 16),
                    network = TunnelNetworkSpec.from(buildMap {
                        put("address", wireGuard.requiredText("address"))
                        put("allowed_ips", wireGuard.requiredList("allowed_ips", 16))
                        if (wireGuard.has("addresses")) put("addresses", wireGuard.requiredList("addresses", 2))
                        if (wireGuard.has("ip_families")) put("ip_families", wireGuard.requiredList("ip_families", 2))
                    }),
                )
            } else {
                require(!root.has("wireguard"))
                null
            }
            QuickTileProfile(
                protocol = protocol,
                accountId = accountId,
                deviceId = deviceId,
                locationId = locationId,
                locationName = locationName,
                wireGuardRequest = request,
                openVpnNetwork = if (root.has("openvpn_network")) TunnelNetworkSpec.decode(root.getJSONObject("openvpn_network").toString()) else null,
            )
        }.getOrNull()

        private fun JSONObject.requiredText(key: String): String = getString(key).also { value ->
            require(value.isNotBlank() && value.length <= MAX_FIELD_LENGTH)
            require(value.none { it == '\n' || it == '\r' || it == '\u0000' })
        }

        private fun JSONObject.requiredList(key: String, maximum: Int): List<String> {
            val values = getJSONArray(key)
            require(values.length() in 1..maximum)
            return List(values.length()) { index ->
                values.getString(index).also { value ->
                    require(value.isNotBlank() && value.length <= MAX_FIELD_LENGTH)
                    require(value.none { it == '\n' || it == '\r' || it == '\u0000' })
                }
            }
        }

        private fun requireIdentifier(value: String) {
            require(identifier.matches(value))
        }

        private fun requireDisplayName(value: String) {
            require(value.isNotBlank() && value.length <= 96)
            require(value.none(Char::isISOControl))
        }

        private const val MAX_FIELD_LENGTH = 2_048
        private const val MAX_ENCODED_LENGTH = 16_384
    }
}

internal class QuickTileProfileStore(private val secureStore: SecureKeystoreStore) {
    private val slot = SecureStorageKeyPolicy.quickTileProfile()

    fun read(): QuickTileProfile? {
        val raw = secureStore.read(slot.scope, slot.key) ?: return null
        return QuickTileProfile.decode(raw) ?: run {
            secureStore.delete(slot.scope, slot.key)
            null
        }
    }

    fun write(profile: QuickTileProfile) {
        secureStore.write(slot.scope, slot.key, profile.encode())
    }

    fun clear() {
        secureStore.delete(slot.scope, slot.key)
    }

    fun clearIf(
        accountId: String,
        deviceId: String? = null,
        protocol: VpnProtocol? = null,
    ) {
        val profile = read() ?: return
        if (profile.accountId == accountId &&
            (deviceId == null || profile.deviceId == deviceId) &&
            (protocol == null || profile.protocol == protocol)
        ) clear()
    }
}
