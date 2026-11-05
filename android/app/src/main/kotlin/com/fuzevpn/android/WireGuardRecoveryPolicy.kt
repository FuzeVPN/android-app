package com.fuzevpn.android

internal data class PhysicalNetworkSnapshot(
    val available: Boolean, val generation: Long, val outageGeneration: Long = 0,
    val changedAtMillis: Long? = null,
    val clockSample: WireGuardClockSample? = null,
    val clockGeneration: Long = 0,
)

/** A wall-clock read bracketed by the same monotonic clock in tracker/policy. */
internal data class WireGuardClockSample(val millis: Long, val beforeNanos: Long, val afterNanos: Long)

/**
 * Intersect the possible wall/monotonic offsets, including millisecond rounding
 * and time spent reading the clocks. A disjoint interval is a clock change;
 * keep its generation even if queued network callbacks hide the intermediate
 * loss or the wall clock has caught up before the worker reads statistics.
 */
internal class WireGuardClockContinuity {
    private var anchor: WireGuardClockSample? = null
    private var lower = 0L
    private var upper = 0L
    var generation = 0L
        private set

    fun observe(sample: WireGuardClockSample) {
        val origin = anchor
        val interval = try {
            if (sample.afterNanos - sample.beforeNanos < 0L) null else {
                val elapsedMillis = Math.subtractExact(sample.millis, origin?.millis ?: sample.millis)
                val elapsedNanos = Math.multiplyExact(elapsedMillis, 1_000_000L)
                val start = origin?.beforeNanos ?: sample.beforeNanos
                Math.subtractExact(elapsedNanos, sample.afterNanos - start) to
                    Math.subtractExact(Math.addExact(elapsedNanos, 1_000_000L), sample.beforeNanos - start)
            }
        } catch (_: ArithmeticException) { null }
        if (origin == null || interval == null || maxOf(lower, interval.first) >= minOf(upper, interval.second)) {
            if (origin != null) generation++
            anchor = sample
            lower = -(sample.afterNanos - sample.beforeNanos).coerceAtLeast(0L)
            upper = 1_000_000L
        } else {
            lower = maxOf(lower, interval.first)
            upper = minOf(upper, interval.second)
        }
    }
}

private fun clockSample(clockMillis: () -> Long, monotonicNanos: () -> Long): WireGuardClockSample {
    val before = monotonicNanos()
    val millis = clockMillis()
    return WireGuardClockSample(millis, before, monotonicNanos())
}

/** Tracks every matching physical network, rather than mistaking one lost
 * Wi-Fi network for the loss of an available mobile/ethernet alternative. */
internal class PhysicalNetworkTracker<T>(
    private val monotonicNanos: () -> Long = android.os.SystemClock::elapsedRealtimeNanos,
    private val clockMillis: () -> Long = System::currentTimeMillis,
) {
    private val usable = mutableSetOf<T>()
    private var generation = 0L
    private var outageGeneration = 0L
    private var changedAtMillis: Long? = null
    private var changedAtClock: WireGuardClockSample? = null
    private val clockContinuity = WireGuardClockContinuity()

    private fun recordChange() {
        generation++
        changedAtClock = clockSample(clockMillis, monotonicNanos).also { clockContinuity.observe(it) }
        changedAtMillis = changedAtClock?.millis
    }

    @Synchronized fun update(network: T, available: Boolean) {
        val changed = if (available) usable.add(network) else usable.remove(network)
        if (changed) {
            recordChange()
            if (usable.isEmpty()) outageGeneration++
        }
    }

    @Synchronized fun snapshot() = PhysicalNetworkSnapshot(usable.isNotEmpty(), generation, outageGeneration,
        changedAtMillis, changedAtClock, clockContinuity.generation)

    /** A worker inventory repairs a missed callback, without overwriting a
     * newer callback that arrived while the framework snapshot was read. */
    @Synchronized fun reconcile(expectedGeneration: Long, networks: Set<T>): Boolean {
        if (generation != expectedGeneration) return false
        if (usable == networks) return true
        val wasAvailable = usable.isNotEmpty()
        usable.clear()
        usable.addAll(networks)
        recordChange()
        if (wasAvailable && usable.isEmpty()) outageGeneration++
        return true
    }
}

/** Connectivity observations do not recreate a tunnel or invent peer proof. */
internal class WireGuardRecoveryPolicy(
    private val monotonicNanos: () -> Long = android.os.SystemClock::elapsedRealtimeNanos,
    private val clockMillis: () -> Long = System::currentTimeMillis,
) {
    enum class State(val messageCode: String?) {
        CONNECTED(null),
        WAITING_NETWORK("wireguard_waiting_network"),
        RECOVERING("wireguard_recovering"),
    }

    private var instance: Long? = null
    private var network = PhysicalNetworkSnapshot(false, 0)
    private var baseline: TunnelStatistics? = null
    private var connectedStatistics: TunnelStatistics? = null
    private var preLossHandshake: Long? = null
    private var recoveryNotBeforeMillis: Long? = null
    // No clock step since the sample preceding the read of connectedStatistics
    // (R15-01): only such a read re-anchors it; a loss never does.
    private var recoveryClockTrusted = false
    private var lastClockUpdateContinuous = false
    private var clockContinuity = WireGuardClockContinuity()
    var state = State.CONNECTED
        private set

    fun start(tunnelInstance: Long, physical: PhysicalNetworkSnapshot, statistics: TunnelStatistics? = null) {
        instance = tunnelInstance
        network = physical
        baseline = null
        connectedStatistics = statistics
        preLossHandshake = statistics?.latestHandshakeMillis
        recoveryNotBeforeMillis = physical.changedAtMillis
        clockContinuity = WireGuardClockContinuity()
        physical.clockSample?.let { clockContinuity.observe(it) }
        clockContinuity.observe(clockSample(clockMillis, monotonicNanos))
        recoveryClockTrusted = clockContinuity.generation == 0L
        lastClockUpdateContinuous = recoveryClockTrusted
        state = if (physical.available) State.CONNECTED else State.WAITING_NETWORK
    }

    fun stop() { instance = null; baseline = null; connectedStatistics = null; preLossHandshake = null }

    private fun updateClock(physical: PhysicalNetworkSnapshot? = null): Pair<WireGuardClockSample, Boolean> {
        val generation = clockContinuity.generation
        physical?.clockSample?.let { clockContinuity.observe(it) }
        val now = clockSample(clockMillis, monotonicNanos)
        clockContinuity.observe(now)
        val continuous = generation == clockContinuity.generation &&
            (physical == null || physical.clockGeneration == network.clockGeneration)
        // Every state, CONNECTED included: a step seen while connected, or
        // absorbed there by a tracker snapshot, must survive the later loss.
        recoveryClockTrusted = recoveryClockTrusted && continuous
        lastClockUpdateContinuous = continuous
        return now to continuous
    }

    private fun retainNetworkTime(physical: PhysicalNetworkSnapshot) {
        physical.changedAtMillis?.let { recoveryNotBeforeMillis = maxOf(recoveryNotBeforeMillis ?: it, it) }
    }

    fun updateNetwork(physical: PhysicalNetworkSnapshot) {
        if (instance == null) return
        updateClock(physical.takeIf { it.generation != network.generation })
        val newOutage = state == State.CONNECTED &&
            (!physical.available || physical.outageGeneration != network.outageGeneration)
        if (newOutage) {
            preLossHandshake = connectedStatistics?.latestHandshakeMillis
            recoveryNotBeforeMillis = network.changedAtMillis
        }
        if (!physical.available) {
            state = State.WAITING_NETWORK
            baseline = null
        } else if (state == State.WAITING_NETWORK || physical.outageGeneration != network.outageGeneration) {
            state = State.RECOVERING
            baseline = null
        } else if (physical.generation != network.generation && state == State.RECOVERING) {
            baseline = null
        }
        if (state != State.CONNECTED) retainNetworkTime(physical)
        network = physical
    }

    fun observe(tunnelInstance: Long, networkGeneration: Long, statistics: TunnelStatistics?) {
        if (instance != tunnelInstance || network.generation != networkGeneration ||
            !network.available || statistics == null) return
        // statistics() returns an empty value while the requested peer is
        // absent. It must not lower a known baseline to zero and make the
        // unchanged old peer look like new authenticated RX when it returns.
        if ((statistics.latestHandshakeMillis ?: 0L) <= 0L && statistics.receivedBytes == 0L) return
        // The bridge reads statistics between two updateNetwork() calls: the
        // previous clock update and this one span that read.
        val continuousSinceRead = lastClockUpdateContinuous
        val (now, continuous) = updateClock()
        // A read re-anchors the trust: later handshakes are newer than it, and
        // the value read here is vetoed after a loss whatever clock stamped it.
        val readClockTrusted = continuousSinceRead && continuous
        if (state == State.CONNECTED) {
            connectedStatistics = statistics
            recoveryClockTrusted = readClockTrusted
            return
        }
        if (state != State.RECOVERING) return
        val before = baseline
        if (before == null) {
            // A known pre-loss handshake is a veto against reinterpreting old
            // peer state after clock rollback/catch-up. With no such sample,
            // the first read is ambiguous and remains a baseline. The tracker
            // clocks also cover loss/return callbacks coalesced by the worker.
            val freshAfterNetworkChange = recoveryClockTrusted && network.clockSample != null &&
                preLossHandshake?.let { it > 0L } == true && recoveryNotBeforeMillis?.let { changedAt ->
                statistics.latestHandshakeMillis?.let {
                    // Equality remains ambiguous at millisecond precision.
                    it > 0L && it != preLossHandshake && it > changedAt && it <= now.millis
                } == true
            } == true
            if (freshAfterNetworkChange) {
                state = State.CONNECTED
                connectedStatistics = statistics
                return
            }
            baseline = statistics
            return
        }
        val freshHandshake = statistics.latestHandshakeMillis?.let {
            it > (before.latestHandshakeMillis ?: 0L)
        } == true
        if (freshHandshake || statistics.receivedBytes > before.receivedBytes) {
            state = State.CONNECTED
            baseline = null
            connectedStatistics = statistics
            recoveryClockTrusted = readClockTrusted
        }
    }
}
