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
 * the transport's own message. [retryAfterSeconds] is the Retry-After of a 429.
 */
internal class OpenVpnRenewalRefused(val reason: String, val retryAfterSeconds: Int? = null) : Exception(reason) {
    companion object {
        const val SESSION = "session"
        const val REQUEST = "request"
        const val NETWORK = "network"
        const val TRANSPORT = "transport"
        const val TIMEOUT = "timeout"
        const val RESPONSE = "response"
        /** 409 openvpn_renewal_expired: the certificate this CSR obtained has expired; only a new key renews. */
        const val RENEWAL_EXPIRED = "openvpn_renewal_expired"
        fun status(code: Int, retryAfterSeconds: Int? = null) = OpenVpnRenewalRefused("http_$code", retryAfterSeconds)
    }
}

/**
 * When the API next accepts an OpenVPN profile creation or renewal for a device, after its 429:
 * it counts six an hour per device, and its Retry-After names the seconds left in that hour.
 * The bridge holds this one deadline, which its own renewals and Flutter's requests respect. It
 * is kept in memory on a monotonic clock: a process restart forgets it, and the API's next
 * refusal names the time left again.
 */
internal class OpenVpnRequestGate(private val nanoTime: () -> Long = System::nanoTime) {
    private val deadlines = HashMap<String, Long>()

    /** A shorter delay never shortens a deadline already known. */
    @Synchronized
    fun defer(accountId: String, deviceId: String, seconds: Int) {
        if (seconds <= 0) return
        val bounded = seconds.coerceAtMost(OpenVpnRenewalContract.MAX_RETRY_AFTER_SECONDS)
        val deadline = nanoTime() + bounded * NANOS_PER_SECOND
        val key = key(accountId, deviceId)
        val known = deadlines[key]
        if (known == null || deadline - known > 0) deadlines[key] = deadline
    }

    /** Whole seconds left, rounded up; null once a request may be sent. */
    @Synchronized
    fun remainingSeconds(accountId: String, deviceId: String): Int? {
        val key = key(accountId, deviceId)
        val left = (deadlines[key] ?: return null) - nanoTime()
        if (left <= 0) {
            deadlines.remove(key)
            return null
        }
        return ((left + NANOS_PER_SECOND - 1) / NANOS_PER_SECOND).toInt()
    }

    private fun key(accountId: String, deviceId: String) = "$accountId/$deviceId"

    private companion object {
        const val NANOS_PER_SECOND = 1_000_000_000L
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
    /** A longer Retry-After is bounded to a day, as the Dart client does. */
    const val MAX_RETRY_AFTER_SECONDS = 86_400

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
     * validator expects. A 429 keeps its [retryAfter]; of a 409 body, only
     * openvpn_renewal_expired is told apart, and no other code is kept.
     */
    fun activation(
        status: Int,
        cacheControl: String?,
        body: ByteArray,
        deviceId: String,
        retryAfter: String? = null,
    ): Map<String, Any?> {
        if (status == 429) throw OpenVpnRenewalRefused.status(status, retryAfterSeconds(retryAfter))
        if (status == 409 && errorCode(body) == OpenVpnRenewalRefused.RENEWAL_EXPIRED) {
            throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.RENEWAL_EXPIRED)
        }
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

    /**
     * Retry-After in delay-seconds, the API's form, bounded to a day. Repeated
     * fields joined by a comma keep the longest; an HTTP-date, zero or any
     * other text sets no delay.
     */
    fun retryAfterSeconds(value: String?): Int? {
        if (value == null || value.length > 512) return null
        return value.split(',').mapNotNull { member ->
            val digits = DELAY_SECONDS.matchEntire(member.trim())?.groupValues?.get(1)?.trimStart('0')
            when {
                digits.isNullOrEmpty() -> null
                digits.length > 9 -> MAX_RETRY_AFTER_SECONDS
                else -> digits.toInt().coerceAtMost(MAX_RETRY_AFTER_SECONDS)
            }
        }.maxOrNull()
    }

    /** The `error` of an API error envelope, or null. Never logged. */
    private fun errorCode(body: ByteArray): String? = try {
        val text = StandardCharsets.UTF_8.newDecoder()
            .onMalformedInput(CodingErrorAction.REPORT)
            .onUnmappableCharacter(CodingErrorAction.REPORT)
            .decode(ByteBuffer.wrap(body)).toString()
        JSONObject(text).opt("error") as? String
    } catch (_: Exception) {
        null
    }

    private fun sameSet(actual: List<String>, expected: List<String>) =
        actual.size == expected.size && expected.all { it in actual }

    private fun JSONObject.text(name: String): String = get(name) as String

    private fun JSONObject.texts(name: String): List<String> = (get(name) as JSONArray).let { array ->
        require(array.length() <= MAX_LIST_ITEMS)
        List(array.length()) { array.get(it) as String }
    }

    private val DELAY_SECONDS = Regex("""\+?([0-9]+)""")
    private const val MAX_TOKEN_CHARS = 4_096
    private const val MAX_LIST_ITEMS = 16
    private val DEVICE_ID = Regex("[A-Za-z0-9._-]{1,160}")
}
