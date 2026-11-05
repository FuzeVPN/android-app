package com.fuzevpn.android.openvpn

import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.receiveAsFlow
import java.util.concurrent.atomic.AtomicBoolean

internal data class OpenVpnSessionEvent(val generation: Long, val state: OpenVpnNativeState)

/** One ordered consumer for control, and a separate snapshot/first outcome for startup. */
internal class OpenVpnSessionEvents {
    private val events = Channel<OpenVpnSessionEvent>(Channel.UNLIMITED)
    val flow = events.receiveAsFlow()
    @Volatile var generation = 0L
        private set
    @Volatile var snapshot = OpenVpnNativeState.idle()
        private set
    private var callbacksEnabled = false
    private var stopping = false
    private var finished = false
    private var interrupted = false
    private class ConnectionWait {
        val cancelled = AtomicBoolean(false)
        val outcome = CompletableDeferred<OpenVpnNativeState>()
    }
    @Volatile private var connectionWait = ConnectionWait()
    @Volatile var failureCode: String? = null
        private set

    @Synchronized fun begin(): Long {
        generation += 1
        callbacksEnabled = true
        stopping = false
        finished = false
        interrupted = false
        connectionWait = ConnectionWait()
        failureCode = null
        publish(generation, OpenVpnNativeState.connecting())
        return generation
    }

    @Synchronized fun requestStop() {
        callbacksEnabled = false
        stopping = true
        publish(generation, OpenVpnNativeState.disconnecting())
    }

    @Synchronized fun finish() {
        callbacksEnabled = false
        publish(generation, OpenVpnNativeState.idle())
        finished = true
    }

    @Synchronized fun interrupt(code: String, requireProof: Boolean = true) {
        if ((requireProof && !snapshot.isConnected()) || stopping || finished) return
        publish(generation, OpenVpnNativeState.error(code))
    }

    /** Called on command receipt: never wait for a PKI callback's monitor. */
    fun cancelPendingConnection() {
        val waiting = connectionWait
        waiting.cancelled.set(true)
        waiting.outcome.complete(OpenVpnNativeState.error("session_operation_cancelled"))
    }

    @Synchronized fun publish(id: Long, state: OpenVpnNativeState) {
        if (id != generation || finished || ((stopping || interrupted || connectionWait.cancelled.get()) && state.isConnected())) return
        snapshot = state
        if (state.toVpnStatus() == com.fuzevpn.android.VpnStatus.ERROR &&
            (failureCode == null || failureCode == "openvpn_reconnect_required")) {
            failureCode = state.messageCode()
        }
        if (state.toVpnStatus() == com.fuzevpn.android.VpnStatus.ERROR) {
            interrupted = true
            callbacksEnabled = false
        }
        if (state.isConnectionTerminal()) connectionWait.outcome.complete(state)
        check(events.trySend(OpenVpnSessionEvent(id, state)).isSuccess)
    }

    @Synchronized fun firstOutcome(id: Long): CompletableDeferred<OpenVpnNativeState> {
        check(id == generation)
        return connectionWait.outcome
    }

    @Synchronized fun confirmConnected(id: Long, publish: () -> Unit): Boolean {
        if (id != generation || !snapshot.isConnected() || stopping || finished || interrupted || connectionWait.cancelled.get()) return false
        publish()
        return true
    }

    // The guard covers the full callback, including signing, so session rollover
    // cannot occur between checking its generation and accessing its identity.
    @Synchronized fun <T> callback(id: Long, rejected: T, block: () -> T): T =
        if (id == generation && callbacksEnabled && !connectionWait.cancelled.get()) block() else rejected
}
