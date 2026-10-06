package com.fuzevpn.android

/** The one public state contract delivered through the EventChannel. */
internal enum class VpnStatus(val wireValue: String) {
    IDLE("idle"),
    AUTHORIZING("authorizing"),
    PREPARING("preparing"),
    CONNECTING("connecting"),
    CONNECTED("connected"),
    DISCONNECTING("disconnecting"),
    ERROR("error"),
}

internal enum class VpnProtocol(val wireValue: String) {
    WIREGUARD("wireguard"),
    OPENVPN("openvpn"),
    ;

    companion object {
        fun fromWireValue(value: String?): VpnProtocol? = entries.firstOrNull { it.wireValue == value }
    }
}

internal data class VpnState(
    val status: VpnStatus = VpnStatus.IDLE,
    val ipFamilies: List<String> = emptyList(),
    val protocol: VpnProtocol? = null,
    val messageCode: String? = null,
    val connectedAtMillis: Long? = null,
    val locationId: String? = null,
    val locationName: String? = null,
    val receivedBytes: Long? = null,
    val sentBytes: Long? = null,
    val latestHandshakeMillis: Long? = null,
    val timestampMillis: Long = System.currentTimeMillis(),
    val sessionTermination: SessionTermination? = null,
    val openVpnRevocation: com.fuzevpn.android.openvpn.OpenVpnRevocationState? = null,
    val systemProtection: Map<String, Any?> = emptyMap(),
) {
    /** A failed read preserves an unknown first sample or the last successful one. */
    fun withTunnelStatistics(statistics: TunnelStatistics?): VpnState = statistics?.let {
        copy(
            receivedBytes = it.receivedBytes,
            sentBytes = it.sentBytes,
            latestHandshakeMillis = it.latestHandshakeMillis,
        )
    } ?: this

    fun toChannelMap(): Map<String, Any?> = buildMap {
        put("status", status.wireValue)
        if (status == VpnStatus.CONNECTED && ipFamilies.isNotEmpty()) put("ip_families", ipFamilies)
        protocol?.let { put("protocol", it.wireValue) }
        messageCode?.let { put("message_code", it) }
        connectedAtMillis?.takeIf { it > 0 }?.let { put("connected_at", it) }
        locationId?.let { put("location_id", it) }
        locationName?.let { put("location_name", it) }
        receivedBytes?.takeIf { it >= 0 }?.let { put("received_bytes", it) }
        sentBytes?.takeIf { it >= 0 }?.let { put("sent_bytes", it) }
        latestHandshakeMillis?.takeIf { it > 0 }?.let { put("latest_handshake", it) }
        put("timestamp", timestampMillis)
        put("system_protection", systemProtection)
        sessionTermination?.let { put("session_termination", it.toMap()) }
        openVpnRevocation?.let { put("openvpn_revocation", it.toMap()) }
    }
}

internal data class TunnelStatistics(
    val receivedBytes: Long = 0L,
    val sentBytes: Long = 0L,
    val latestHandshakeMillis: Long? = null,
)
