package com.fuzevpn.android.openvpn

import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.receiveAsFlow

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
    private var outcome = CompletableDeferred<OpenVpnNativeState>()
    @Volatile var failureCode: String? = null
        private set

    @Synchronized fun begin(): Long {
        generation += 1
        callbacksEnabled = true
        stopping = false
        finished = false
        interrupted = false
        outcome = CompletableDeferred()
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

    @Synchronized fun publish(id: Long, state: OpenVpnNativeState) {
        if (id != generation || finished || ((stopping || interrupted) && state.isConnected())) return
        snapshot = state
        if (state.toVpnStatus() == com.fuzevpn.android.VpnStatus.ERROR &&
            (failureCode == null || failureCode == "openvpn_reconnect_required")) {
            failureCode = state.messageCode()
        }
        if (state.toVpnStatus() == com.fuzevpn.android.VpnStatus.ERROR) {
            interrupted = true
            callbacksEnabled = false
        }
        if (state.isConnectionTerminal()) outcome.complete(state)
        check(events.trySend(OpenVpnSessionEvent(id, state)).isSuccess)
    }

    @Synchronized fun firstOutcome(id: Long): CompletableDeferred<OpenVpnNativeState> {
        check(id == generation)
        return outcome
    }

    @Synchronized fun confirmConnected(id: Long, publish: () -> Unit): Boolean {
        if (id != generation || !snapshot.isConnected() || stopping || finished || interrupted) return false
        publish()
        return true
    }

    // The guard covers the full callback, including signing, so session rollover
    // cannot occur between checking its generation and accessing its identity.
    @Synchronized fun <T> callback(id: Long, rejected: T, block: () -> T): T =
        if (id == generation && callbacksEnabled) block() else rejected
}
