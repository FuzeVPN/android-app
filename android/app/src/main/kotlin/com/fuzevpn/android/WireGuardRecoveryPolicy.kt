package com.fuzevpn.android

internal data class PhysicalNetworkSnapshot(
    val available: Boolean, val generation: Long, val outageGeneration: Long = 0,
)

/** Tracks every matching physical network, rather than mistaking one lost
 * Wi-Fi network for the loss of an available mobile/ethernet alternative. */
internal class PhysicalNetworkTracker<T> {
    private val usable = mutableSetOf<T>()
    private var generation = 0L
    private var outageGeneration = 0L

    @Synchronized fun update(network: T, available: Boolean) {
        val changed = if (available) usable.add(network) else usable.remove(network)
        if (changed) {
            generation++
            if (usable.isEmpty()) outageGeneration++
        }
    }

    @Synchronized fun snapshot() = PhysicalNetworkSnapshot(usable.isNotEmpty(), generation, outageGeneration)

    /** A worker inventory repairs a missed callback, without overwriting a
     * newer callback that arrived while the framework snapshot was read. */
    @Synchronized fun reconcile(expectedGeneration: Long, networks: Set<T>): Boolean {
        if (generation != expectedGeneration) return false
        if (usable == networks) return true
        val wasAvailable = usable.isNotEmpty()
        usable.clear()
        usable.addAll(networks)
        generation++
        if (wasAvailable && usable.isEmpty()) outageGeneration++
        return true
    }
}

/** Connectivity observations do not recreate a tunnel or invent peer proof. */
internal class WireGuardRecoveryPolicy {
    enum class State(val messageCode: String?) {
        CONNECTED(null),
        WAITING_NETWORK("wireguard_waiting_network"),
        RECOVERING("wireguard_recovering"),
    }

    private var instance: Long? = null
    private var network = PhysicalNetworkSnapshot(false, 0)
    private var baseline: TunnelStatistics? = null
    var state = State.CONNECTED
        private set

    fun start(tunnelInstance: Long, physical: PhysicalNetworkSnapshot) {
        instance = tunnelInstance
        network = physical
        baseline = null
        state = if (physical.available) State.CONNECTED else State.WAITING_NETWORK
    }

    fun stop() { instance = null; baseline = null }

    fun updateNetwork(physical: PhysicalNetworkSnapshot) {
        if (instance == null) return
        if (!physical.available) {
            state = State.WAITING_NETWORK
            baseline = null
        } else if (state == State.WAITING_NETWORK || physical.outageGeneration != network.outageGeneration) {
            state = State.RECOVERING
            baseline = null
        } else if (physical.generation != network.generation && state == State.RECOVERING) {
            baseline = null
        }
        network = physical
    }

    fun observe(tunnelInstance: Long, networkGeneration: Long, statistics: TunnelStatistics?) {
        if (instance != tunnelInstance || network.generation != networkGeneration ||
            !network.available || state != State.RECOVERING || statistics == null) return
        val before = baseline
        if (before == null) {
            baseline = statistics
            return
        }
        val freshHandshake = statistics.latestHandshakeMillis?.let {
            it > (before.latestHandshakeMillis ?: 0L)
        } == true
        if (freshHandshake || statistics.receivedBytes > before.receivedBytes) {
            state = State.CONNECTED
            baseline = null
        }
    }
}
