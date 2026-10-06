package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class TunnelNetworkSpecTest {
    private fun values() = mutableMapOf<String, Any?>(
        "address" to "10.20.0.3/32", "addresses" to listOf("10.20.0.3/32", "fd0d:295d:995b:2::3/128"),
        "ip_families" to listOf("ipv4", "ipv6"), "allowed_ips" to listOf("0.0.0.0/0", "::/0"),
    )
    private val addresses = listOf("10.20.0.3/24", "fd0d:295d:995b:2:0:0:0:3/64")
    private val routes = listOf("0.0.0.0/0", "::/0")
    private val dns = listOf("1.1.1.1", "1.0.0.1")
    private fun dual() = TunnelNetworkSpec.from(values())
    private fun rejects(block: () -> Unit) { assertThrows(Exception::class.java) { block() } }

    @Test fun api128MatchesServer64ByNumericAddress() {
        val plan = dual().validateTun(addresses, routes, dns, 1280)
        assertEquals(64, plan.addresses.last().prefix)
        assertTrue(plan.routes.any { it.isDefault(true) })
    }
    @Test fun legacyIpv4HasNoIpv6AndDoesNotRequireUnknownExpectedAddress() {
        val policy = TunnelNetworkSpec.decode(null)
        assertFalse(policy.dualStack)
        assertEquals(listOf("ipv4"), policy.ipFamilies)
        policy.validateTun(listOf("10.20.0.8/24"), listOf("0.0.0.0/0"), dns, 1200)
    }
    @Test fun familyListsCannotBeModified() {
        rejects { (dual().ipFamilies as MutableList).clear() }
        rejects { (dual().addresses as MutableList).clear() }
        rejects { (dual().allowedIps as MutableList).clear() }
    }
    @Test fun ipv4WithoutExtendedFieldsRemainsCompatible() {
        assertFalse(TunnelNetworkSpec.from(mapOf("address" to "10.20.0.3/32"), legacyOpenVpn = true).dualStack)
    }
    @Test fun partialOrContradictoryActivationFailsClosed() {
        for (key in listOf("ip_families", "addresses", "allowed_ips")) {
            rejects { TunnelNetworkSpec.from(values().apply { remove(key) }) }
        }
        rejects { TunnelNetworkSpec.from(values().apply { put("ip_families", listOf("ipv4")) }) }
        rejects { TunnelNetworkSpec.from(values().apply { put("allowed_ips", listOf("0.0.0.0/0")) }) }
    }
    @Test fun activationRequiresUla128() {
        for (address in listOf("fd00::3/64", "2001:db8::3/128", "fd00::3%wlan0/128", "fd00:::3/128", "::ffff:10.0.0.3/128")) {
            rejects { TunnelNetworkSpec.from(values().apply { put("addresses", listOf("10.20.0.3/32", address)) }) }
        }
    }
    @Test fun wrongPushedAddressStopsAttempt() {
        rejects { dual().validateTun(listOf(addresses[0], "fd0d:295d:995b:2::4/64"), routes, dns, 1500) }
        rejects { dual().validateTun(listOf("10.20.0.4/24", addresses[1]), routes, dns, 1500) }
    }
    @Test fun bothAddressesAreMandatory() {
        rejects { dual().validateTun(listOf(addresses[0]), routes, dns, 1500) }
        rejects { dual().validateTun(listOf(addresses[1]), routes, dns, 1500) }
    }
    @Test fun bothDefaultRoutesAreMandatory() {
        rejects { dual().validateTun(addresses, listOf(routes[0]), dns, 1500) }
        rejects { dual().validateTun(addresses, listOf(routes[1]), dns, 1500) }
        rejects { dual().validateTun(addresses, listOf(routes[0], "fd00::/8"), dns, 1500) }
    }
    @Test fun splitIpv4DefaultIsAcceptedAlongsideIpv6Default() {
        dual().validateTun(addresses, listOf("0.0.0.0/1", "128.0.0.0/1", "::/0"), dns, 1500)
        rejects { dual().validateTun(addresses, listOf("0.0.0.0/1", "::/0"), dns, 1500) }
    }
    @Test fun dualMtuMustBeAtLeast1280() {
        rejects { dual().validateTun(addresses, routes, dns, 1279) }
        rejects { dual().validateTun(addresses, routes, dns, 9001) }
        dual().validateTun(addresses, routes, dns, 1280)
    }
    @Test fun ipv4CannotAddIpv6AddressRouteOrDns() {
        val ipv4 = TunnelNetworkSpec.legacyIpv4()
        rejects { ipv4.validateTun(addresses, listOf(routes[0]), dns, 1500) }
        rejects { ipv4.validateTun(listOf(addresses[0]), routes, dns, 1500) }
        rejects { ipv4.validateTun(listOf(addresses[0]), listOf(routes[0]), listOf("2606:4700:4700::1111"), 1500) }
    }
    @Test fun routeRemainsInValidatedPlanWhenIPv6InternetAvailabilityChanges() {
        val plan = dual().validateTun(addresses, routes, dns, 1500)
        assertEquals(2, plan.routes.size) // Local plan never depends on an Internet reachability probe.
        assertTrue(plan.routes[1].isDefault(true))
    }
    @Test fun malformedDnsDoesNotInvokeResolver() {
        for (value in listOf("dns.example.test", "127.1", "012.0.0.1", "1.1.1.999")) {
            rejects { TunnelNetworkSpec.numericAddress(value) }
        }
    }
    @Test fun wireGuardKeepsBothAddressesAndRoutes() {
        val request = WireGuardRequest("account", "device", "frankfurt-01", "Frankfurt", "10.20.0.3/32", dns,
            "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=", "198.51.100.1:51820", routes, dual())
        assertEquals(2, request.network.addresses.size)
        assertEquals(routes, request.allowedIps)
        assertEquals(request, request.copy(network = dual()))
    }
    @Test fun wireGuardRejectsPartialRoutesAndIpv6Transport() {
        rejects { WireGuardRequest("a", "d", "l", "L", "10.20.0.3/32", dns, "key", "198.51.100.1:51820", listOf(routes[0]), dual()) }
        rejects { WireGuardRequest("a", "d", "l", "L", "10.20.0.3/32", dns, "key", "[2001:db8::1]:51820", routes, dual()) }
    }
}
