package com.fuzevpn.android

/** No provider message, nonce or token may become a presentation error. */
internal class GoogleAuthException(code: String) : RuntimeException(GoogleAuthPolicy.safeError(code)) {
    val code = GoogleAuthPolicy.safeError(code)
}

internal class GoogleSignInSelection(
    val requestId: String,
    val serverClientId: String,
    val nonce: String,
) {
    override fun toString(): String = "GoogleSignInSelection(redacted: true)"
}

internal object GoogleAuthPolicy {
    private val requestIdentifier = Regex("[A-Za-z0-9._-]{1,128}")
    private val clientIdentifier = Regex("[0-9]+-[A-Za-z0-9_-]+\\.apps\\.googleusercontent\\.com")
    private val errorCodes = setOf(
        "cancelled", "busy", "unavailable", "interrupted", "no_credential",
        "invalid_request", "invalid_response", "provider_error",
        "invalid_pending_authentication", "secure_storage_failed", "secure_storage_corrupt",
    )

    fun safeError(code: Any?): String = (code as? String)?.takeIf { it in errorCodes } ?: "provider_error"

    fun signIn(arguments: Any?): GoogleSignInSelection {
        val values = arguments as? Map<*, *> ?: throw GoogleAuthException("invalid_request")
        if (values.keys != setOf("requestId", "serverClientId", "nonce")) {
            throw GoogleAuthException("invalid_request")
        }
        val requestId = identifier(values["requestId"])
        val clientId = values["serverClientId"] as? String ?: throw GoogleAuthException("invalid_request")
        val nonce = values["nonce"] as? String ?: throw GoogleAuthException("invalid_request")
        if (clientId.length > 256 || !clientIdentifier.matches(clientId) ||
            nonce.isEmpty() || nonce.length > 1024 || nonce.any { it.code !in 33..126 }) {
            throw GoogleAuthException("invalid_request")
        }
        return GoogleSignInSelection(requestId, clientId, nonce)
    }

    fun cancellation(arguments: Any?): String {
        val values = arguments as? Map<*, *> ?: throw GoogleAuthException("invalid_request")
        if (values.keys != setOf("requestId")) throw GoogleAuthException("invalid_request")
        return identifier(values["requestId"])
    }

    fun noArguments(arguments: Any?) {
        if (arguments != null) throw GoogleAuthException("invalid_request")
    }

    fun token(value: String): String {
        if (value.isEmpty() || value.length > 65536 || value.any { it.code !in 33..126 }) {
            throw GoogleAuthException("invalid_response")
        }
        return value
    }

    private fun identifier(value: Any?): String = (value as? String)
        ?.takeIf { requestIdentifier.matches(it) } ?: throw GoogleAuthException("invalid_request")
}

/** Identity, rather than requestId alone, prevents an old callback winning a retry. */
internal class GoogleAuthFlowGate {
    internal class Ticket internal constructor(val requestId: String?)
    private var current: Ticket? = null
    private var closed = false

    @Synchronized fun reserve(requestId: String?): Ticket {
        if (closed) throw GoogleAuthException("unavailable")
        if (current != null) throw GoogleAuthException("busy")
        return Ticket(requestId).also { current = it }
    }

    @Synchronized fun finish(ticket: Ticket): Boolean {
        if (closed || current !== ticket) return false
        current = null
        return true
    }

    @Synchronized fun isCurrent(ticket: Ticket): Boolean = !closed && current === ticket

    @Synchronized fun cancel(requestId: String): Ticket? {
        val ticket = current?.takeIf { it.requestId == requestId } ?: return null
        current = null
        return ticket
    }

    @Synchronized fun close(): Ticket? {
        if (closed) return null
        closed = true
        return current.also { current = null }
    }
}
