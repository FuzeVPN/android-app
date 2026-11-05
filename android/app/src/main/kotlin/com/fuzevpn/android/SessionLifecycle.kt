package com.fuzevpn.android

internal data class SessionTermination(
    val tunnelStopped: Boolean = false,
    val sessionCleared: Boolean = false,
    val stopError: String? = null,
    val storageError: String? = null,
    val inProgress: Boolean = false,
    val sessionExpired: Boolean = false,
    /** Native only, never published: the end revokes automatic guest recovery. */
    val revokeGuestRecovery: Boolean = false,
) {
    val complete get() = tunnelStopped && sessionCleared && !inProgress
    fun toMap(): Map<String, Any?> = mapOf(
        "tunnel_stopped" to tunnelStopped, "session_cleared" to sessionCleared,
        "stop_error" to stopError, "storage_error" to storageError, "in_progress" to inProgress,
        "session_expired" to sessionExpired,
    )
}

/** Why Dart ends the session: the "reason" of storageClearSession (lot S review, P1). */
internal enum class SessionEndCause(val wireValue: String) {
    VOLUNTARY("voluntary"),
    EXPIRED("expired"),
    ABANDONED("abandoned"),
    ;

    companion object {
        /** Without a reason, the legacy session_expired flag decides; an unknown reason is null. */
        fun of(arguments: Any?): SessionEndCause? {
            val values = arguments as? Map<*, *>
            val reason = values?.get("reason") ?: return if (values?.get("session_expired") == true) EXPIRED else VOLUNTARY
            return entries.firstOrNull { it.wireValue == reason }
        }
    }
}

/** Process-retained admission fence; no token or identity is retained here. */
internal class SessionLifecycle {
    private var epoch = 0L
    private var accepting = true
    @Volatile var termination: SessionTermination? = null
        private set

    @Synchronized fun ticket() = epoch
    @Synchronized fun isCurrent(ticket: Long) = epoch == ticket && accepting
    @Synchronized fun check(ticket: Long) {
        if (!isCurrent(ticket)) throw VpnNativeException("session_operation_cancelled")
    }
    /** Publication and admission close are ordered without holding a JNI lock. */
    @Synchronized fun <T> current(ticket: Long, action: () -> T): T {
        check(ticket)
        return action()
    }
    @Synchronized private fun checkMutation(ticket: Long) {
        if (epoch != ticket || termination?.let { !it.complete } == true) {
            throw VpnNativeException("session_operation_cancelled")
        }
    }

    /**
     * Preparation may cancel bridge work and acquire its locks. It must run
     * outside this monitor: callbacks take those locks before reading a ticket.
     * Recheck after preparation so a concurrent logout cannot admit the write.
     */
    fun <T> mutate(ticket: Long, prepare: () -> Unit = {}, action: () -> T): T {
        checkMutation(ticket)
        prepare()
        return synchronized(this) {
            checkMutation(ticket)
            action()
        }
    }

    fun activate(ticket: Long, prepare: () -> Unit = {}, action: () -> Unit) = mutate(ticket, prepare) {
        action()
        accepting = true
        termination = null
    }
    fun beginEnd(expired: Boolean): Long = beginEnd(if (expired) SessionEndCause.EXPIRED else SessionEndCause.VOLUNTARY)

    @Synchronized fun beginEnd(cause: SessionEndCause = SessionEndCause.VOLUNTARY): Long {
        // Only an unfinished termination carries its causes into this request.
        // A completed one belongs to a previous session (A01-auth-02). Any
        // expired request reports an expiry; any voluntary one revokes recovery.
        val unfinished = termination?.takeIf { !it.complete }
        val sessionExpired = cause == SessionEndCause.EXPIRED || unfinished?.sessionExpired == true
        val revoke = cause == SessionEndCause.VOLUNTARY || unfinished?.revokeGuestRecovery == true
        if (termination?.inProgress == true) {
            termination = termination?.copy(sessionExpired = sessionExpired, revokeGuestRecovery = revoke)
            return epoch
        }
        epoch++
        accepting = false
        termination = SessionTermination(inProgress = true, sessionExpired = sessionExpired, revokeGuestRecovery = revoke)
        return epoch
    }
    @Synchronized fun finish(result: SessionTermination): SessionTermination {
        val completed = result.copy(sessionExpired = result.sessionExpired || termination?.sessionExpired == true,
            revokeGuestRecovery = result.revokeGuestRecovery || termination?.revokeGuestRecovery == true)
        termination = completed
        return completed
    }
}
