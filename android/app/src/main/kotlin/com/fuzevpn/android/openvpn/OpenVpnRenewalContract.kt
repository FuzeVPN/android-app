package com.fuzevpn.android.openvpn

import org.json.JSONArray
import org.json.JSONObject
import java.net.URI
import java.nio.ByteBuffer
import java.nio.charset.CodingErrorAction
import java.nio.charset.StandardCharsets
import java.time.OffsetDateTime

/**
 * Why an automatic renewal did not produce a certificate. Only these fixed
 * reasons and an HTTP status ever reach a log: never a body, a URL, a token or
 * the transport's own message.
 */
internal class OpenVpnRenewalRefused(val reason: String) : Exception(reason) {
    companion object {
        const val SESSION = "session"
        const val REQUEST = "request"
        const val NETWORK = "network"
        const val TRANSPORT = "transport"
        const val TIMEOUT = "timeout"
        const val RESPONSE = "response"
        fun status(code: Int) = OpenVpnRenewalRefused("http_$code")
    }
}

/**
 * The one control-plane request made without Flutter: the renewal of an
 * OpenVPN certificate that is due, `POST v1/devices/{id}/profiles/openvpn/renew`.
 * Pure: it builds the request from the stored session and turns the response
 * into the activation [OpenVpnController.connect] validates, as the Dart client
 * does for a connection started in the application.
 */
internal object OpenVpnRenewalContract {
    const val PRODUCTION_BASE_URL = "https://api.fuzevpn.com/"
    const val MAX_RESPONSE_BYTES = 1024 * 1024

    /** [headers] carries the session token: a request is sent once and never kept or logged. */
    class Request(val url: String, val headers: Map<String, String>, val body: ByteArray)

    /**
     * Debug builds follow the Dart client's FUZEVPN_API_BASE_URL override, over
     * HTTPS only; release and profile builds always use the production API.
     */
    fun baseUrl(debug: Boolean, debugOverride: String): String {
        if (!debug || debugOverride.isEmpty()) return PRODUCTION_BASE_URL
        return try {
            val uri = URI(debugOverride)
            require(uri.scheme == "https" && !uri.host.isNullOrEmpty() && uri.userInfo == null)
            val path = uri.path.orEmpty().let { if (it.endsWith("/")) it else "$it/" }
            URI("https", null, uri.host, uri.port, path, null, null).toString()
        } catch (_: Exception) {
            PRODUCTION_BASE_URL
        }
    }

    /** No `ip_families`: the server then keeps the address families the device already has. */
    fun request(baseUrl: String, sessionPayload: String, deviceId: String, csrPem: String): Request {
        val token = try {
            (JSONObject(sessionPayload).get("access_token") as String).also {
                require(it.isNotBlank() && it.length <= MAX_TOKEN_CHARS && it.none(Char::isISOControl))
            }
        } catch (_: Exception) {
            throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.SESSION)
        }
        // These characters need no escaping in a path segment; a dot segment would leave it.
        if (!DEVICE_ID.matches(deviceId) || deviceId.all { it == '.' } ||
            !csrPem.trim().startsWith("-----BEGIN CERTIFICATE REQUEST-----")) {
            throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.REQUEST)
        }
        return Request(
            url = "${baseUrl}v1/devices/$deviceId/profiles/openvpn/renew",
            headers = mapOf(
                "accept" to "application/json",
                "cache-control" to "no-store",
                "authorization" to "Bearer $token",
                "content-type" to "application/json; charset=utf-8",
            ),
            body = JSONObject().put("csr_pem", csrPem).toString().toByteArray(StandardCharsets.UTF_8),
        )
    }

    /**
     * Only a 201 that forbids caching carries an activation. The values are
     * handed over as received: [OpenVpnController.connect] validates each one
     * and binds the certificate to the pending key. Families, addresses and
     * routes are sets in the API contract and are put in the order that
     * validator expects.
     */
    fun activation(status: Int, cacheControl: String?, body: ByteArray, deviceId: String): Map<String, Any?> {
        if (status != 201) throw OpenVpnRenewalRefused.status(status)
        try {
            require(cacheControl?.lowercase()?.split(',')?.any { it.trim() == "no-store" } == true)
            require(body.size <= MAX_RESPONSE_BYTES)
            val text = StandardCharsets.UTF_8.newDecoder()
                .onMalformedInput(CodingErrorAction.REPORT)
                .onUnmappableCharacter(CodingErrorAction.REPORT)
                .decode(ByteBuffer.wrap(body)).toString()
            val json = JSONObject(text)
            require(json.text("device_id") == deviceId && json.text("protocol") == "openvpn")
            require(json.get("remote_cert_tls_server") == true)
            val address = json.text("address")
            return mapOf(
                "device_id" to deviceId,
                "certificate_pem" to json.text("certificate_pem"),
                "ca_certificate_pem" to json.text("ca_certificate_pem"),
                "tls_crypt_v2_client_key" to json.text("tls_crypt_v2_client_key"),
                "endpoint" to json.text("endpoint"),
                "dns" to json.texts("dns"),
                "address" to address,
                "server_name" to json.text("server_name"),
                "remote_cert_tls_server" to true,
                "ciphers" to json.texts("ciphers"),
                "not_after" to OffsetDateTime.parse(json.text("not_after")).toInstant().toString(),
                "renewal" to true,
            ) + network(json, address)
        } catch (_: Exception) {
            throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.RESPONSE)
        }
    }

    private fun network(json: JSONObject, address: String): Map<String, Any?> {
        val extended = json.has("ip_families")
        require(extended == json.has("addresses"))
        var dual = false
        var addresses = listOf(address)
        if (extended) {
            val families = json.texts("ip_families")
            dual = sameSet(families, listOf("ipv4", "ipv6"))
            require(dual || families == listOf("ipv4"))
            val supplied = json.texts("addresses")
            require(supplied.size == if (dual) 2 else 1)
            // An IPv6 address always contains ':', an IPv4 one never does.
            val ipv4At = if (dual && ':' !in supplied[1]) 1 else 0
            addresses = listOf(supplied[ipv4At]) + if (dual) listOf(supplied[1 - ipv4At]) else emptyList()
        }
        val routes = if (dual) listOf("0.0.0.0/0", "::/0") else listOf("0.0.0.0/0")
        if (extended || json.has("allowed_ips")) require(sameSet(json.texts("allowed_ips"), routes))
        return mapOf(
            "ip_families" to if (dual) listOf("ipv4", "ipv6") else listOf("ipv4"),
            "addresses" to addresses,
            "allowed_ips" to routes,
        )
    }

    private fun sameSet(actual: List<String>, expected: List<String>) =
        actual.size == expected.size && expected.all { it in actual }

    private fun JSONObject.text(name: String): String = get(name) as String

    private fun JSONObject.texts(name: String): List<String> = (get(name) as JSONArray).let { array ->
        require(array.length() <= MAX_LIST_ITEMS)
        List(array.length()) { array.get(it) as String }
    }

    private const val MAX_TOKEN_CHARS = 4_096
    private const val MAX_LIST_ITEMS = 16
    private val DEVICE_ID = Regex("[A-Za-z0-9._-]{1,160}")
}
