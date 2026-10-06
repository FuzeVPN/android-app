package com.fuzevpn.android.openvpn

import org.junit.Assert.*
import org.junit.Test

class OpenVpnNetworkProfileTest {
    private fun activation(dual: Boolean) = mutableMapOf<String, Any?>(
        "device_id" to "device", "certificate_pem" to "-----BEGIN CERTIFICATE-----\ntest\n-----END CERTIFICATE-----",
        "ca_certificate_pem" to "-----BEGIN CERTIFICATE-----\ntest\n-----END CERTIFICATE-----",
        "tls_crypt_v2_client_key" to "test", "endpoint" to "198.51.100.1", "address" to "10.20.0.3/32",
        "dns" to listOf("1.1.1.1"), "server_name" to "frankfurt-01.openvpn.fuzevpn.internal",
        "remote_cert_tls_server" to true, "ciphers" to listOf("AES-256-GCM"), "not_after" to "2099-01-01T00:00:00Z",
    ).apply {
        if (dual) putAll(mapOf("ip_families" to listOf("ipv4", "ipv6"), "addresses" to listOf("10.20.0.3/32", "fd00::3/128"),
            "allowed_ips" to listOf("0.0.0.0/0", "::/0")))
    }
    private fun canonical(dual: Boolean) = OpenVpnController.OpenVpnActivation.from(activation(dual), "account", "device").toCanonicalProfile()
    @Test fun legacyCanonicalProfileKeepsIpv6Blocking() {
        val profile = canonical(false)
        assertFalse(profile.network.dualStack)
        for (directive in listOf("block-ipv6", "pull-filter ignore route-ipv6", "pull-filter ignore ifconfig-ipv6")) assertTrue(profile.canonical.contains(directive))
    }
    @Test fun dualCanonicalProfileRemovesOnlyIpv6Blocking() {
        val profile = canonical(true)
        assertTrue(profile.network.dualStack)
        assertFalse(profile.canonical.contains("block-ipv6"))
        assertFalse(profile.canonical.contains("pull-filter"))
        val legacy = canonical(false).canonical.lines().filterNot { it == "block-ipv6" || it.startsWith("pull-filter ") }
        assertEquals(legacy, profile.canonical.lines())
    }
    @Test fun dualKeepsIpv4TransportAndTlsVerification() {
        val text = canonical(true).canonical
        for (directive in listOf("proto udp4", "remote 198.51.100.1 1194", "remote-cert-tls server", "verify-x509-name", "auth-nocache", "allow-compression no", "data-ciphers AES-256-GCM", "EXTERNAL_PKI true")) assertTrue(text.contains(directive))
    }
    @Test fun incompleteDualActivationNeverCreatesIpv4Profile() {
        for (missing in listOf("ip_families", "addresses", "allowed_ips")) {
            assertThrows(Exception::class.java) { OpenVpnController.OpenVpnActivation.from(activation(true).apply { remove(missing) }, "account", "device") }
        }
    }
    @Test fun foreignDeviceOrDisabledTlsCannotUseDualActivation() {
        assertThrows(Exception::class.java) { OpenVpnController.OpenVpnActivation.from(activation(true), "account", "other") }
        assertThrows(Exception::class.java) { OpenVpnController.OpenVpnActivation.from(activation(true).apply { put("remote_cert_tls_server", false) }, "account", "device") }
    }
}
