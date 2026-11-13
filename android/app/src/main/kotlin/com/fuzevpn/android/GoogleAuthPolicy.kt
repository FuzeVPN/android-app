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
    /** One reserved operation; its kind is its type. */
    internal sealed class Ticket {
        /** The explicit picker, the only kind a request id can cancel. */
        class SignIn internal constructor(val requestId: String) : Ticket()
        class ClearState internal constructor() : Ticket()
    }

    private sealed interface State {
        data object Idle : State
        class Active(val ticket: Ticket) : State
        /** Terminal: nothing is reserved or finished any more. */
        data object Closed : State
    }

    private var state: State = State.Idle

    @Synchronized fun reserve(requestId: String): Ticket = activate(Ticket.SignIn(requestId))

    @Synchronized fun reserveClearState(): Ticket = activate(Ticket.ClearState())

    private fun activate(ticket: Ticket): Ticket {
        when (state) {
            State.Closed -> throw GoogleAuthException("unavailable")
            is State.Active -> throw GoogleAuthException("busy")
            State.Idle -> state = State.Active(ticket)
        }
        return ticket
    }

    @Synchronized fun finish(ticket: Ticket): Boolean {
        if (!isCurrent(ticket)) return false
        state = State.Idle
        return true
    }

    @Synchronized fun isCurrent(ticket: Ticket): Boolean = (state as? State.Active)?.ticket === ticket

    @Synchronized fun cancel(requestId: String): Ticket? {
        val ticket = (state as? State.Active)?.ticket as? Ticket.SignIn ?: return null
        if (ticket.requestId != requestId) return null
        state = State.Idle
        return ticket
    }

    @Synchronized fun close(): Ticket? {
        val ticket = (state as? State.Active)?.ticket
        state = State.Closed
        return ticket
    }
}
