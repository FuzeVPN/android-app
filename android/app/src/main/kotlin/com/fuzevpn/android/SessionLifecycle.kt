package com.fuzevpn.android

internal data class SessionTermination(
    val tunnelStopped: Boolean = false,
    val sessionCleared: Boolean = false,
    val stopError: String? = null,
    val storageError: String? = null,
    val inProgress: Boolean = false,
    val sessionExpired: Boolean = false,
) {
    val complete get() = tunnelStopped && sessionCleared && !inProgress
    fun toMap(): Map<String, Any?> = mapOf(
        "tunnel_stopped" to tunnelStopped, "session_cleared" to sessionCleared,
        "stop_error" to stopError, "storage_error" to storageError, "in_progress" to inProgress,
        "session_expired" to sessionExpired,
    )
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
    @Synchronized fun beginEnd(expired: Boolean = false): Long {
        val sessionExpired = expired || termination?.sessionExpired == true
        if (termination?.inProgress == true) {
            if (sessionExpired) termination = termination?.copy(sessionExpired = true)
            return epoch
        }
        epoch++
        accepting = false
        termination = SessionTermination(inProgress = true, sessionExpired = sessionExpired)
        return epoch
    }
    @Synchronized fun finish(result: SessionTermination): SessionTermination {
        val completed = result.copy(sessionExpired = result.sessionExpired || termination?.sessionExpired == true)
        termination = completed
        return completed
    }
}
