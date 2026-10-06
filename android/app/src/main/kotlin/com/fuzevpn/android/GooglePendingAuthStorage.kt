package com.fuzevpn.android

import java.nio.charset.StandardCharsets
import java.time.Instant
import org.json.JSONObject

/** One encrypted global continuation, containing no Google ID token or profile. */
internal object GooglePendingAuthPolicy {
    const val MAX_PAYLOAD_BYTES = 16384
    private val required = setOf(
        "version", "request_id", "purpose", "stage", "ticket", "context", "expires_at", "generation",
    )
    private val optional = setOf("challenge_id", "user_id")
    private val identifier = Regex("[A-Za-z0-9._-]{1,160}")

    fun validate(payload: String) {
        try {
            if (payload.toByteArray(StandardCharsets.UTF_8).size !in 1..MAX_PAYLOAD_BYTES) invalid()
            val json = JSONObject(payload)
            val keys = json.keys().asSequence().toSet()
            if (!keys.containsAll(required) || keys.any { it !in required && it !in optional }) invalid()
            if (json.get("version") != 1) invalid()
            if (!identifier.matches(string(json, "request_id", 128))) invalid()
            if (string(json, "purpose", 16) !in setOf("authenticate", "claim", "link")) invalid()
            if (string(json, "stage", 16) !in setOf("challenge", "continuation", "uncertain")) invalid()
            opaque(string(json, "ticket", 8192))
            opaque(string(json, "context", 8192))
            Instant.parse(string(json, "expires_at", 64))
            val generation = json.get("generation")
            if ((generation !is Int && generation !is Long) ||
                (generation as Number).toLong() !in 1..9007199254740991L) invalid()
            for (key in optional) {
                if (json.has(key) && !identifier.matches(string(json, key, 160))) invalid()
            }
        } catch (_: Exception) {
            // JSONObject/Instant exceptions may contain the original private value.
            throw GoogleAuthException("invalid_pending_authentication")
        }
    }

    private fun string(json: JSONObject, key: String, limit: Int): String {
        val value = json.get(key) as? String ?: invalid()
        if (value.isEmpty() || value.length > limit) invalid()
        return value
    }
    private fun opaque(value: String) { if (value.any { it.code !in 33..126 }) invalid() }
    private fun invalid(): Nothing = throw GoogleAuthException("invalid_pending_authentication")
}

internal class GooglePendingAuthStorage(
    private val read: (SecureStorageSlot) -> String?,
    private val update: (Map<SecureStorageSlot, String>, Set<SecureStorageSlot>) -> Unit,
) {
    // This slot is independent of VPN account/session cleanup and is never
    // supplied by Flutter or interpreted as an account identifier.
    private val slot = SecureStorageSlot(SecureKeystoreStore.GLOBAL_SCOPE, "fuzevpn.google.pending_authentication")

    fun read(): String? {
        val payload = try { read(slot) } catch (_: Exception) { throw GoogleAuthException("secure_storage_failed") }
            ?: return null
        try { GooglePendingAuthPolicy.validate(payload) }
        catch (_: GoogleAuthException) { throw GoogleAuthException("secure_storage_corrupt") }
        return payload
    }

    fun write(payload: String) {
        GooglePendingAuthPolicy.validate(payload)
        try { update(mapOf(slot to payload), emptySet()) }
        catch (_: Exception) { throw GoogleAuthException("secure_storage_failed") }
    }

    fun clear() {
        try { update(emptyMap(), setOf(slot)) }
        catch (_: Exception) { throw GoogleAuthException("secure_storage_failed") }
    }
}
