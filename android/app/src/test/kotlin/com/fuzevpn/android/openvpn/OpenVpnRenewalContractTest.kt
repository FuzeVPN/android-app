package com.fuzevpn.android.openvpn

import org.json.JSONArray
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test
import java.nio.charset.StandardCharsets

/**
 * The renewal a recovery, a tile click or a system restore sends without Flutter. The Dart
 * client's contract (test/core/api_client_test.dart) is repeated here: same route, same
 * headers, same refusals, and an activation the native validator accepts.
 */
class OpenVpnRenewalContractTest {
    private val session = """{"access_token":"token-123","expires_at":"2099-01-01T00:00:00Z"}"""
    private val csr = "-----BEGIN CERTIFICATE REQUEST-----\nMIIB/+a=\n-----END CERTIFICATE REQUEST-----\n"
    private val pem = "-----BEGIN CERTIFICATE-----\ntest\n-----END CERTIFICATE-----"

    private fun response(change: JSONObject.() -> Unit = {}): ByteArray = JSONObject().apply {
        put("device_id", "device-1")
        put("protocol", "openvpn")
        put("address", "10.20.0.3/32")
        put("dns", JSONArray(listOf("1.1.1.1")))
        put("endpoint", "198.51.100.1")
        put("server_name", "frankfurt-01.openvpn.fuzevpn.internal")
        put("remote_cert_tls_server", true)
        put("ca_certificate_pem", pem)
        put("certificate_pem", pem)
        put("certificate_serial", "0a")
        put("not_after", "2099-01-01T00:00:00Z")
        put("ciphers", JSONArray(listOf("AES-256-GCM", "CHACHA20-POLY1305", "AES-128-GCM")))
        put("tls_crypt_v2_client_key", "client-key")
        change()
    }.toString().toByteArray(StandardCharsets.UTF_8)

    private fun activation(body: ByteArray = response(), status: Int = 201, cacheControl: String? = "no-store") =
        OpenVpnRenewalContract.activation(status, cacheControl, body, "device-1")

    private fun refused(block: () -> Unit): String = assertThrows(OpenVpnRenewalRefused::class.java) { block() }.reason

    @Test fun theRequestIsTheDartClientsRenewal() {
        val request = OpenVpnRenewalContract.request(OpenVpnRenewalContract.PRODUCTION_BASE_URL, session, "device-1", csr)
        assertEquals("https://api.fuzevpn.com/v1/devices/device-1/profiles/openvpn/renew", request.url)
        assertEquals(mapOf(
            "accept" to "application/json",
            "cache-control" to "no-store",
            "authorization" to "Bearer token-123",
            "content-type" to "application/json; charset=utf-8",
        ), request.headers)
        val body = JSONObject(String(request.body, StandardCharsets.UTF_8))
        // No ip_families: the server keeps the families the device already has.
        assertEquals(setOf("csr_pem"), body.keys().asSequence().toSet())
        assertEquals(csr, body.getString("csr_pem"))
    }

    @Test fun anUnusableSessionDeviceOrCsrSendsNothing() {
        val base = OpenVpnRenewalContract.PRODUCTION_BASE_URL
        for (payload in listOf("", "{}", """{"access_token":""}""", """{"access_token":42}""",
            """{"access_token":"a\r\nx-injected: 1"}""", "not json")) {
            assertEquals(payload, OpenVpnRenewalRefused.SESSION,
                refused { OpenVpnRenewalContract.request(base, payload, "device-1", csr) })
        }
        for (device in listOf("", ".", "..", "a/b", "a b", "a?b", "a#b", "a%2Fb", "é", "x".repeat(161))) {
            assertEquals(device, OpenVpnRenewalRefused.REQUEST,
                refused { OpenVpnRenewalContract.request(base, session, device, csr) })
        }
        assertEquals(OpenVpnRenewalRefused.REQUEST,
            refused { OpenVpnRenewalContract.request(base, session, "device-1", pem) })
    }

    @Test fun onlyADebugBuildFollowsAnHttpsOverride() {
        val production = OpenVpnRenewalContract.PRODUCTION_BASE_URL
        assertEquals(production, OpenVpnRenewalContract.baseUrl(false, "https://lab.example.test/"))
        assertEquals(production, OpenVpnRenewalContract.baseUrl(true, ""))
        assertEquals("https://lab.example.test/", OpenVpnRenewalContract.baseUrl(true, "https://lab.example.test"))
        assertEquals("https://lab.example.test:8443/api/", OpenVpnRenewalContract.baseUrl(true, "https://lab.example.test:8443/api"))
        assertEquals("https://lab.example.test/api/", OpenVpnRenewalContract.baseUrl(true, "https://lab.example.test/api/?x=1#y"))
        for (refusedOverride in listOf("http://lab.example.test/", "https://user:secret@lab.example.test/", "https:///path",
            "lab.example.test", "ftp://lab.example.test/", "https://lab example.test/")) {
            assertEquals(refusedOverride, production, OpenVpnRenewalContract.baseUrl(true, refusedOverride))
        }
        val request = OpenVpnRenewalContract.request(
            OpenVpnRenewalContract.baseUrl(true, "https://lab.example.test/api"), session, "device-1", csr)
        assertEquals("https://lab.example.test/api/v1/devices/device-1/profiles/openvpn/renew", request.url)
    }

    @Test fun anIpv4ActivationReachesTheNativeValidatorInItsCanonicalForm() {
        val values = activation()
        assertEquals(true, values["renewal"])
        assertEquals(listOf("ipv4"), values["ip_families"])
        assertEquals(listOf("10.20.0.3/32"), values["addresses"])
        assertEquals(listOf("0.0.0.0/0"), values["allowed_ips"])
        assertEquals("2099-01-01T00:00:00Z", values["not_after"])
        val validated = OpenVpnController.OpenVpnActivation.from(values, "account", "device-1")
        assertFalse(validated.network.dualStack)
        assertEquals(listOf("AES-256-GCM", "CHACHA20-POLY1305", "AES-128-GCM"), validated.ciphers)
        // The certificate serial and anything else the validator does not read are dropped.
        assertFalse(values.containsKey("certificate_serial"))
        assertFalse(values.containsKey("protocol"))
    }

    // Families, addresses and routes are sets in the API contract (C5-01): the Dart client
    // reorders them before the native validator, which takes IPv4 first.
    @Test fun aDualStackActivationIsReorderedLikeTheDartClientDoes() {
        val canonical = activation(response {
            put("ip_families", JSONArray(listOf("ipv4", "ipv6")))
            put("addresses", JSONArray(listOf("10.20.0.3/32", "fd00::3/128")))
            put("allowed_ips", JSONArray(listOf("0.0.0.0/0", "::/0")))
        })
        val reversed = activation(response {
            put("ip_families", JSONArray(listOf("ipv6", "ipv4")))
            put("addresses", JSONArray(listOf("fd00::3/128", "10.20.0.3/32")))
            put("allowed_ips", JSONArray(listOf("::/0", "0.0.0.0/0")))
        })
        assertEquals(canonical, reversed)
        assertEquals(listOf("ipv4", "ipv6"), reversed["ip_families"])
        assertEquals(listOf("10.20.0.3/32", "fd00::3/128"), reversed["addresses"])
        assertEquals(listOf("0.0.0.0/0", "::/0"), reversed["allowed_ips"])
        assertTrue(OpenVpnController.OpenVpnActivation.from(reversed, "account", "device-1").network.dualStack)
        val explicitIpv4 = activation(response {
            put("ip_families", JSONArray(listOf("ipv4")))
            put("addresses", JSONArray(listOf("10.20.0.3/32")))
            put("allowed_ips", JSONArray(listOf("0.0.0.0/0")))
        })
        assertEquals(activation(), explicitIpv4)
    }

    @Test fun anOffsetExpiryIsHandedOverAsAnInstant() {
        val values = activation(response { put("not_after", "2099-01-01T02:00:00.5+02:00") })
        assertEquals("2099-01-01T00:00:00.500Z", values["not_after"])
        OpenVpnController.OpenVpnActivation.from(values, "account", "device-1")
    }

    @Test fun onlyAnUncachedCreatedResponseCarriesAnActivation() {
        for (status in listOf(200, 204, 301, 401, 403, 409, 429, 500, 503)) {
            assertEquals("http_$status", refused { activation(status = status) })
        }
        for (header in listOf(null, "", "private", "max-age=0", "no-storey")) {
            assertEquals("$header", OpenVpnRenewalRefused.RESPONSE, refused { activation(cacheControl = header) })
        }
        assertEquals(activation(), activation(cacheControl = "Private, NO-STORE"))
    }

    @Test fun aMalformedActivationIsRefusedBeforeTheEngine() {
        val malformed: List<Pair<String, ByteArray>> = listOf(
            "other device" to response { put("device_id", "device-2") },
            "other protocol" to response { put("protocol", "wireguard") },
            "no protocol" to response { remove("protocol") },
            "tls verification off" to response { put("remote_cert_tls_server", false) },
            "tls verification as text" to response { put("remote_cert_tls_server", "true") },
            "null certificate" to response { put("certificate_pem", JSONObject.NULL) },
            "numeric endpoint" to response { put("endpoint", 42) },
            "dns as text" to response { put("dns", "1.1.1.1") },
            "numeric dns item" to response { put("dns", JSONArray(listOf(1))) },
            "seventeen ciphers" to response { put("ciphers", JSONArray(List(17) { "AES-256-GCM" })) },
            "no expiry" to response { remove("not_after") },
            "unreadable expiry" to response { put("not_after", "tomorrow") },
            "expiry without offset" to response { put("not_after", "2099-01-01T00:00:00") },
            "families without addresses" to response { put("ip_families", JSONArray(listOf("ipv4"))) },
            "addresses without families" to response { put("addresses", JSONArray(listOf("10.20.0.3/32"))) },
            "unknown family" to response {
                put("ip_families", JSONArray(listOf("ipv4", "ipv5")))
                put("addresses", JSONArray(listOf("10.20.0.3/32", "fd00::3/128")))
                put("allowed_ips", JSONArray(listOf("0.0.0.0/0", "::/0")))
            },
            "ipv6 alone" to response {
                put("ip_families", JSONArray(listOf("ipv6")))
                put("addresses", JSONArray(listOf("fd00::3/128")))
                put("allowed_ips", JSONArray(listOf("::/0")))
            },
            "one address for two families" to response {
                put("ip_families", JSONArray(listOf("ipv4", "ipv6")))
                put("addresses", JSONArray(listOf("10.20.0.3/32")))
                put("allowed_ips", JSONArray(listOf("0.0.0.0/0", "::/0")))
            },
            "extended without routes" to response {
                put("ip_families", JSONArray(listOf("ipv4")))
                put("addresses", JSONArray(listOf("10.20.0.3/32")))
            },
            "split routes" to response { put("allowed_ips", JSONArray(listOf("0.0.0.0/1", "128.0.0.0/1"))) },
            "array" to "[]".toByteArray(),
            "empty" to ByteArray(0),
            "invalid UTF-8" to byteArrayOf(0x7b, 0xc3.toByte(), 0x28, 0x7d),
            "oversized" to ByteArray(OpenVpnRenewalContract.MAX_RESPONSE_BYTES + 1) { ' '.code.toByte() },
        )
        for ((name, body) in malformed) {
            assertEquals(name, OpenVpnRenewalRefused.RESPONSE, refused { activation(body) })
        }
    }

    // What the converter lets through as text is still judged by the engine's own validator.
    @Test fun valuesAreJudgedByTheNativeValidator() {
        for ((key, value) in listOf("endpoint" to "vpn.example.test", "address" to "10.20.0.3/24",
            "server_name" to "bad name", "certificate_pem" to "not a certificate")) {
            val values = activation(response { put(key, value) })
            assertThrows(key, Exception::class.java) { OpenVpnController.OpenVpnActivation.from(values, "account", "device-1") }
        }
        val mismatch = activation(response {
            put("ip_families", JSONArray(listOf("ipv4")))
            put("addresses", JSONArray(listOf("10.20.0.9/32")))
            put("allowed_ips", JSONArray(listOf("0.0.0.0/0")))
        })
        assertThrows(Exception::class.java) { OpenVpnController.OpenVpnActivation.from(mismatch, "account", "device-1") }
    }

    // A reason is a fixed word or an HTTP status: nothing of the response reaches a log.
    @Test fun aRefusalNeverCarriesResponseText() {
        val secret = response { put("device_id", "leaked-device-identifier") }
        assertEquals("response", refused { activation(secret) })
        assertEquals("http_409", refused { activation("""{"error":"openvpn_profile_revoked"}""".toByteArray(), status = 409) })
        assertEquals("http_409", OpenVpnRenewalRefused.status(409).message)
    }
}
