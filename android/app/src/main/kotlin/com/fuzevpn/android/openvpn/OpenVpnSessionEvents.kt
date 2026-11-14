package com.fuzevpn.android.openvpn

import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.receiveAsFlow
import java.util.concurrent.atomic.AtomicBoolean

/** [afterStopRequest]: published once the app requested this session's stop, which owns its outcome. */
internal data class OpenVpnSessionEvent(
    val generation: Long,
    val state: OpenVpnNativeState,
    val afterStopRequest: Boolean = false,
)

/** One ordered consumer for control, and a separate snapshot/first outcome for startup. */
internal class OpenVpnSessionEvents {
    private val events = Channel<OpenVpnSessionEvent>(Channel.UNLIMITED)
    val flow = events.receiveAsFlow()
    @Volatile var generation = 0L
        private set
    @Volatile var snapshot = OpenVpnNativeState.idle()
        private set
    /** What the current generation still admits; from OPEN on, each state refuses one thing more. */
    private enum class Gate {
        /** Before the first session: there is no callback to serve yet. */
        UNSTARTED,
        /** Core is starting or running: its callbacks are served. */
        OPEN,
        /** An error was published: no callback and no CONNECTED any more. */
        INTERRUPTED,
        /** A stop was requested: an interruption is not published either. */
        STOPPING,
        /** The session ended: nothing is published. */
        FINISHED,
    }
    private var gate = Gate.UNSTARTED
    private class ConnectionWait {
        val cancelled = AtomicBoolean(false)
        val outcome = CompletableDeferred<OpenVpnNativeState>()
    }
    @Volatile private var connectionWait = ConnectionWait()
    @Volatile var failureCode: String? = null
        private set

    @Synchronized fun begin(): Long {
        generation += 1
        gate = Gate.OPEN
        connectionWait = ConnectionWait()
        failureCode = null
        publish(generation, OpenVpnNativeState.connecting())
        return generation
    }

    /**
     * A new start was admitted. A refusal before [begin] publishes nothing into a finished
     * session, so [failureCode] must stop naming what ended that session.
     */
    @Synchronized fun startRequested() {
        if (gate == Gate.FINISHED) failureCode = null
    }

    @Synchronized fun requestStop() {
        if (gate != Gate.FINISHED) gate = Gate.STOPPING
        publish(generation, OpenVpnNativeState.disconnecting())
    }

    @Synchronized fun finish() {
        publish(generation, OpenVpnNativeState.idle())
        gate = Gate.FINISHED
    }

    @Synchronized fun interrupt(code: String, requireProof: Boolean = true) {
        if ((requireProof && !snapshot.isConnected()) || gate == Gate.STOPPING || gate == Gate.FINISHED) return
        publish(generation, OpenVpnNativeState.error(code))
    }

    /** Called on command receipt: never wait for a PKI callback's monitor. */
    fun cancelPendingConnection() {
        val waiting = connectionWait
        waiting.cancelled.set(true)
        waiting.outcome.complete(OpenVpnNativeState.error("session_operation_cancelled"))
    }

    @Synchronized fun publish(id: Long, state: OpenVpnNativeState) {
        if (id != generation || gate == Gate.FINISHED || (connectedRefused() && state.isConnected())) return
        val afterStopRequest = gate == Gate.STOPPING
        snapshot = state
        if (state.toVpnStatus() == com.fuzevpn.android.VpnStatus.ERROR &&
            (failureCode == null || failureCode == "openvpn_reconnect_required")) {
            failureCode = state.messageCode()
        }
        if (state.toVpnStatus() == com.fuzevpn.android.VpnStatus.ERROR &&
            (gate == Gate.UNSTARTED || gate == Gate.OPEN)) {
            gate = Gate.INTERRUPTED
        }
        if (state.isConnectionTerminal()) connectionWait.outcome.complete(state)
        check(events.trySend(OpenVpnSessionEvent(id, state, afterStopRequest)).isSuccess)
    }

    @Synchronized fun firstOutcome(id: Long): CompletableDeferred<OpenVpnNativeState> {
        check(id == generation)
        return connectionWait.outcome
    }

    @Synchronized fun confirmConnected(id: Long, publish: () -> Unit): Boolean {
        if (id != generation || !snapshot.isConnected() || connectedRefused()) return false
        publish()
        return true
    }

    // The guard covers the full callback, including signing, so session rollover
    // cannot occur between checking its generation and accessing its identity.
    @Synchronized fun <T> callback(id: Long, rejected: T, block: () -> T): T =
        if (id == generation && gate == Gate.OPEN && !connectionWait.cancelled.get()) block() else rejected

    /** Called under the monitor; the cancellation itself is set outside it. */
    private fun connectedRefused(): Boolean =
        gate == Gate.INTERRUPTED || gate == Gate.STOPPING || gate == Gate.FINISHED || connectionWait.cancelled.get()
}
