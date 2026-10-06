package com.fuzevpn.android

import org.json.JSONArray
import org.json.JSONObject
import java.net.InetAddress
import java.util.Collections

/** Validated, immutable full-tunnel policy. No DNS resolution is performed here. */
internal class TunnelNetworkSpec private constructor(addresses: List<String>, val dualStack: Boolean) {
    val addresses: List<String> = Collections.unmodifiableList(addresses.toList())
    val ipFamilies: List<String> = Collections.unmodifiableList(if (dualStack) listOf("ipv4", "ipv6") else listOf("ipv4"))
    val allowedIps: List<String> = Collections.unmodifiableList(if (dualStack) listOf("0.0.0.0/0", "::/0") else listOf("0.0.0.0/0"))
    val expectedIpv4: String get() = addresses.firstOrNull()?.substringBefore('/') ?: ""
    val expectedIpv6: String get() = if (dualStack) addresses[1].substringBefore('/') else ""

    fun encode(): String = JSONObject().apply {
        put("version", 1)
        put("addresses", JSONArray(addresses))
        put("ip_families", JSONArray(ipFamilies))
        put("allowed_ips", JSONArray(allowedIps))
    }.toString()

    fun validateTun(addresses: List<String>, routes: List<String>, dns: List<String>, mtu: Int): ValidatedTun {
        require(addresses.size in 1..32 && routes.size in 1..32 && dns.size in 1..8)
        require(mtu in (if (dualStack) 1280 else 576)..9000)
        val parsedAddresses = addresses.map(::cidr).distinctBy { it.host.hostAddress to it.prefix }
        val v4 = parsedAddresses.filter { it.host.address.size == 4 }
        val v6 = parsedAddresses.filter { it.host.address.size == 16 }
        require(v4.size == 1 && v6.size == if (dualStack) 1 else 0)
        if (expectedIpv4.isNotEmpty()) require(v4.single().host == numericAddress(expectedIpv4))
        if (dualStack) require(v6.single().host == numericAddress(expectedIpv6))
        val parsedRoutes = routes.map(::cidr).distinctBy { it.host.hostAddress to it.prefix }
        require(parsedRoutes.none { !dualStack && it.host.address.size == 16 })
        val default4 = parsedRoutes.any { it.isDefault(false) }
        val halves4 = parsedRoutes.any { it.isHalf(false) } && parsedRoutes.any { it.isHalf(true) }
        require(default4 || halves4)
        if (dualStack) require(parsedRoutes.any { it.isDefault(true) })
        val normalizedRoutes = parsedRoutes.filterNot { (default4 && (it.isHalf(false) || it.isHalf(true))) }
        val parsedDns = dns.map(::numericAddress).distinct()
        require(parsedDns.all { it.address.size == 4 })
        return ValidatedTun(parsedAddresses, normalizedRoutes, parsedDns, mtu)
    }

    override fun toString() = "TunnelNetworkSpec(dualStack=$dualStack, redacted=true)"
    override fun equals(other: Any?) = other is TunnelNetworkSpec && dualStack == other.dualStack && addresses == other.addresses
    override fun hashCode() = 31 * addresses.hashCode() + dualStack.hashCode()

    companion object {
        fun legacyIpv4() = TunnelNetworkSpec(emptyList(), false)

        fun ipv4(address: String, routes: List<String>) = from(mapOf("address" to address, "allowed_ips" to routes))

        fun from(values: Map<String, Any?>, legacyOpenVpn: Boolean = false): TunnelNetworkSpec {
            val primary = assignedAddress(values["address"], false)
            val families = values["ip_families"]
            val suppliedAddresses = values["addresses"]
            val extended = values.containsKey("ip_families") || values.containsKey("addresses")
            val dual = extended && families == listOf("ipv4", "ipv6")
            if (extended) {
                require(families == listOf("ipv4") || dual)
                require(suppliedAddresses is List<*> && suppliedAddresses.size == if (dual) 2 else 1)
                require(assignedAddress(suppliedAddresses[0], false) == primary)
            }
            val expectedRoutes = if (dual) listOf("0.0.0.0/0", "::/0") else listOf("0.0.0.0/0")
            if (!(legacyOpenVpn && !extended && !values.containsKey("allowed_ips"))) {
                require(values["allowed_ips"] == expectedRoutes)
            }
            return TunnelNetworkSpec(listOf(primary) + if (dual) {
                listOf(assignedAddress((suppliedAddresses as List<*>)[1], true))
            } else emptyList(), dual)
        }

        fun decode(raw: String?): TunnelNetworkSpec {
            if (raw == null) return legacyIpv4()
            require(raw.length in 2..2048)
            val json = JSONObject(raw)
            require(json.getInt("version") == 1)
            fun list(name: String): List<String> = json.getJSONArray(name).let { array ->
                require(array.length() in 1..2)
                List(array.length()) { array.getString(it) }
            }
            val addresses = list("addresses")
            return from(mapOf("address" to addresses[0], "addresses" to addresses,
                "ip_families" to list("ip_families"), "allowed_ips" to list("allowed_ips")))
        }

        private fun assignedAddress(value: Any?, ipv6: Boolean): String {
            require(value is String)
            val cidr = cidr(value)
            require(cidr.prefix == if (ipv6) 128 else 32)
            require(cidr.host.address.size == if (ipv6) 16 else 4)
            if (ipv6) require((cidr.host.address[0].toInt() and 0xfe) == 0xfc)
            return "${cidr.host.hostAddress}/${cidr.prefix}"
        }

        fun cidr(value: String): NetworkCidr {
            require(value.length in 3..64 && value.count { it == '/' } == 1)
            val host = numericAddress(value.substringBefore('/'))
            val rawPrefix = value.substringAfter('/')
            require(rawPrefix.matches(Regex("0|[1-9][0-9]{0,2}")))
            val prefix = rawPrefix.toInt()
            require(prefix in 0..if (host.address.size == 4) 32 else 128)
            return NetworkCidr(host, prefix)
        }

        fun numericAddress(value: String): InetAddress {
            require(value.length in 2..45 && value.all { it in "0123456789abcdefABCDEF:." })
            if (':' in value) {
                val address = InetAddress.getByName(value)
                require(address.address.size == 16)
                return address
            }
            val parts = value.split('.')
            require(parts.size == 4)
            val bytes = parts.map {
                require(it.matches(Regex("0|[1-9][0-9]{0,2}")))
                val octet = it.toInt()
                require(octet in 0..255)
                octet.toByte()
            }.toByteArray()
            return InetAddress.getByAddress(bytes)
        }
    }
}

internal data class NetworkCidr(val host: InetAddress, val prefix: Int) {
    fun isDefault(ipv6: Boolean) = prefix == 0 && host.address.size == (if (ipv6) 16 else 4) && host.address.all { it == 0.toByte() }
    fun isHalf(upper: Boolean) = prefix == 1 && host.address.size == 4 &&
        (host.address[0].toInt() and 255) == (if (upper) 128 else 0) && host.address.drop(1).all { it == 0.toByte() }
}

internal data class ValidatedTun(val addresses: List<NetworkCidr>, val routes: List<NetworkCidr>, val dns: List<InetAddress>, val mtu: Int)
