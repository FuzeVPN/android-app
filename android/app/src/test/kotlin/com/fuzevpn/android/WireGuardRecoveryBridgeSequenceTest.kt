package com.fuzevpn.android

import com.fuzevpn.android.WireGuardRecoveryPolicy.State.CONNECTED
import com.fuzevpn.android.WireGuardRecoveryPolicy.State.RECOVERING
import com.fuzevpn.android.WireGuardRecoveryPolicy.State.WAITING_NETWORK
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * R15-01 (with A10-wireguard-01): a handshake from before the loss must never
 * confirm WireGuard recovery, whether the wall clock stepped while CONNECTED
 * (before the loss) or during the outage.
 *
 * The real tracker and policy are driven in AndroidVpnBridge's call order:
 * - start: start(instance, reconcilePhysicalNetworksLocked(), recoveryBaseline()), then refresh(false);
 * - refresh = refreshWireGuardRecoveryLocked: reconcile, updateNetwork(physical), statistics only
 *   when sampling with a network, reconcile, updateNetwork(after), observe on the same generation;
 * - tick = the 1 s observer, sampling only in a recovery state: without the UI, statistics are
 *   never read while CONNECTED, so a rekey made then stays unknown to the policy;
 * - uiPoll = getState from a live Flutter engine; callback = physicalNetworkChanged.
 * The monotonic clock includes sleep (elapsedRealtimeNanos); only the wall clock steps.
 */
class WireGuardRecoveryBridgeSequenceTest {
    private class Bridge(startWall: Long, activationHandshake: Long?, networks: List<String>) {
        var wall = startWall
        var mono = startWall
        val tracker = PhysicalNetworkTracker<String>(monotonicNanos = { mono * 1_000_000L }) { wall }
        val policy = WireGuardRecoveryPolicy(monotonicNanos = { mono * 1_000_000L }) { wall }
        private val inventory = linkedSetOf<String>()
        /** What the backend reports: wall-clock stamp of the last handshake, received bytes. */
        var peerHandshake = activationHandshake
        var peerRx = 5_000L
        var statisticsReads = 0

        init {
            networks.forEach { inventory += it; tracker.update(it, true) }
            policy.start(1, reconcile(), activationHandshake?.let { TunnelStatistics(peerRx, 2_000L, it) })
            refresh(sample = false)
        }

        val hasNetwork get() = inventory.isNotEmpty()
        val state get() = policy.state

        private fun reconcile(): PhysicalNetworkSnapshot {
            tracker.reconcile(tracker.snapshot().generation, inventory.toSet())
            return tracker.snapshot()
        }

        fun refresh(sample: Boolean) {
            val physical = reconcile()
            policy.updateNetwork(physical)
            val statistics = if (sample && physical.available) {
                statisticsReads++
                TunnelStatistics(peerRx, 2_000L, peerHandshake)
            } else null
            val after = reconcile()
            policy.updateNetwork(after)
            if (physical.generation == after.generation) policy.observe(1, after.generation, statistics)
        }

        fun tick() = refresh(sample = state != CONNECTED)
        fun uiPoll() = refresh(sample = true)
        fun callback(network: String, usable: Boolean) {
            if (usable) inventory += network else inventory -= network
            tracker.update(network, usable)
            refresh(sample = false)
        }
        /** A change only getAllNetworks shows; reconcile repairs it on the next refresh. */
        fun inventoryOnly(network: String, usable: Boolean) {
            if (usable) inventory += network else inventory -= network
        }
        fun advance(ms: Long) { wall += ms; mono += ms }
        fun stepWall(deltaMs: Long) { wall += deltaMs }
        fun seconds(count: Int, ui: Boolean = false) = repeat(count) {
            advance(1_000L)
            tick()
            if (ui) uiPoll()
        }
    }

    /**
     * H-R15-01 V1: activation handshake 100 000, rekey stamped 220 000 and never
     * read, a 60 s backward step seen while CONNECTED, Wi-Fi lost while cellular
     * remains (the tracker absorbs the step there), then the cellular loss at
     * wall 171 500. The peer stays silent afterwards.
     */
    private fun rekeyStepThenTwoStepLoss(ui: Boolean = false, twoNetworks: Boolean = true): Bridge {
        val b = Bridge(100_000L, 100_000L, if (twoNetworks) listOf("wifi", "cellular") else listOf("wifi"))
        b.seconds(120, ui)                              // wall 220 000
        b.peerHandshake = 220_000L; b.peerRx += 300     // rekey and traffic
        b.seconds(1, ui)                                // wall 221 000
        b.advance(500); b.stepWall(-60_000L)            // wall 161 500, monotonic 221 500
        b.seconds(5, ui)
        assertEquals(CONNECTED, b.state)
        if (twoNetworks) {
            b.callback("wifi", false)                   // not blocking: cellular remains
            assertEquals(CONNECTED, b.state)
            b.seconds(5, ui)
            b.callback("cellular", false)               // last network lost at wall 171 500
        } else {
            b.seconds(5, ui)
            b.callback("wifi", false)
        }
        assertEquals(WAITING_NETWORK, b.state)
        return b
    }

    // ---- Residual R15-01: the step precedes the loss ----

    @Test fun oldRekeyCannotProveRecoveryWhenTheStepPrecededTheLoss() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(48)                                   // wall 219 500, no network yet
        b.advance(100); b.callback("wifi", true)        // return at 219 600, before the old rekey
        assertEquals(RECOVERING, b.state)
        b.advance(900); b.tick()                        // first read at 220 500, after it
        assertEquals(RECOVERING, b.state)
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun sleepDelayingTheFirstReadCannotTurnTheOldRekeyIntoProof() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(20)                                   // wall 191 500
        b.advance(8_500); b.callback("wifi", true)      // return at 200 000
        b.advance(25_000); b.tick()                     // CPU suspended: first read at 225 000
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun aSecondNetworkResettingTheBaselineCannotReopenTheOldRekeyProof() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(18)                                   // wall 189 500
        b.advance(500); b.callback("wifi", true)        // return at 190 000
        b.seconds(29)                                   // the old rekey reads as future: baseline
        assertEquals(RECOVERING, b.state)
        b.advance(700); b.callback("cellular", true)    // a new generation drops it at 219 700
        b.advance(300); b.tick()                        // first read again, at 220 000
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun anInventoryRepairAbsorbingTheStepCannotHideIt() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi"))
        b.seconds(120); b.peerHandshake = 220_000L; b.peerRx += 300
        b.seconds(1); b.advance(500); b.stepWall(-60_000L) // wall 161 500
        b.seconds(5)
        b.inventoryOnly("ethernet", true); b.seconds(1)    // added without a callback
        assertEquals(CONNECTED, b.state)
        b.seconds(4)
        b.inventoryOnly("ethernet", false); b.callback("wifi", false) // everything lost at 171 500
        assertEquals(WAITING_NETWORK, b.state)
        b.seconds(48)
        b.advance(100); b.callback("wifi", true)           // return at 219 600
        b.advance(900); b.tick()                           // first read at 220 500
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun aFirstReadAtExactlyTheOldRekeyMillisecondStaysRecovering() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(48)
        b.advance(499); b.callback("wifi", true)        // return at 219 999
        b.advance(1); b.tick()                          // first read at 220 000 == old rekey
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    /** A10-wireguard-01: rekey at 125 000, a 2 s step, cellular then Wi-Fi lost, return at wall 124 600. */
    @Test fun aTwoSecondStepBeforeTheCellularLossCannotProveRecovery() {
        val b = Bridge(2_000L, 1_900L, listOf("wifi", "cellular"))
        b.seconds(122)                                  // wall 124 000
        b.advance(1_000); b.peerHandshake = 125_000L; b.peerRx = 9_000L; b.tick()
        b.advance(500); b.stepWall(-2_000L)             // wall 123 500, monotonic 125 500
        b.advance(500); b.tick()                        // wall 124 000
        b.advance(200); b.callback("cellular", false)   // not blocking: Wi-Fi remains
        b.advance(200); b.callback("wifi", false)
        assertEquals(WAITING_NETWORK, b.state)
        b.advance(200); b.callback("wifi", true)        // return at wall 124 600
        b.advance(400); b.tick()                        // first read at wall 125 000
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    /** vb-H-R15-01: observer reads tens of seconds apart, a long outage. */
    @Test fun theIndependentVoteSequenceStaysRecovering() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi", "cellular"))
        b.advance(50_000L); b.tick()
        b.advance(70_000L); b.peerHandshake = 220_000L; b.tick() // rekey, never read
        b.advance(10_000L); b.stepWall(-60_000L); b.tick()     // wall 170 000, monotonic 230 000
        b.advance(1_000L); b.callback("wifi", false)
        assertEquals(CONNECTED, b.state)
        b.advance(39_000L); b.callback("cellular", false)
        b.advance(9_600L); b.callback("wifi", true)            // return at wall 219 600
        b.advance(900L); b.tick()                              // first read at 220 500
        assertEquals(RECOVERING, b.state)
    }

    // ---- Controls: a defence that already applied keeps applying ----

    @Test fun aStepAfterTheNonBlockingChangeIsSeenAtTheLoss() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi", "cellular"))
        b.seconds(120); b.peerHandshake = 220_000L; b.peerRx += 300
        b.seconds(1)
        b.callback("wifi", false)                       // not blocking, clock still continuous
        b.advance(500); b.stepWall(-60_000L); b.seconds(5)
        b.callback("cellular", false)                   // the tracker sees the step here
        b.seconds(53)                                   // wall 219 500
        b.advance(100); b.callback("wifi", true)
        b.advance(900); b.tick()
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun aReturnAtExactlyTheOldRekeyMillisecondStaysRecovering() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(48); b.advance(500); b.callback("wifi", true) // return at 220 000 == old rekey
        b.advance(500); b.tick()
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun aSingleNetworkLossRevealsTheStepThroughTheTracker() {
        val b = rekeyStepThenTwoStepLoss(twoNetworks = false)
        b.seconds(48); b.advance(100); b.callback("wifi", true)
        b.advance(900); b.tick()
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun uiReadsAfterTheStepVetoTheOldRekey() {
        val b = rekeyStepThenTwoStepLoss(ui = true)
        b.seconds(48, ui = true); b.advance(100); b.callback("wifi", true)
        b.advance(900); b.tick()
        b.seconds(30, ui = true)
        assertEquals(RECOVERING, b.state)
        assertTrue(b.statisticsReads > 0)
    }

    @Test fun aStepDuringTheOutageWithStaleStatisticsStaysRecovering() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi"))
        b.seconds(120); b.peerHandshake = 220_000L; b.peerRx += 300
        b.seconds(1)                                    // wall 221 000
        b.callback("wifi", false)                       // loss on a continuous clock
        b.seconds(1); b.stepWall(-60_000L)              // step during the outage
        b.seconds(57)                                   // wall 219 000
        b.advance(600); b.callback("wifi", true)        // return at 219 600
        b.advance(900); b.tick()
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    @Test fun coalescedLossAndReturnAroundAStepStayRecovering() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi"))
        b.seconds(120); b.peerHandshake = 220_000L
        b.seconds(1)                                    // wall 221 000
        b.tracker.update("wifi", false)                 // callbacks queued behind the worker
        b.advance(1_000); b.stepWall(-5_000L)           // wall 217 000
        b.tracker.update("wifi", true)
        b.advance(3_500)                                // wall 220 500
        b.refresh(sample = false); b.refresh(sample = false)
        b.tick()
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
    }

    // ---- Normal witnesses ----

    private fun stableLoss(): Bridge {
        val b = Bridge(100_000L, 100_000L, listOf("wifi"))
        b.seconds(120); b.peerHandshake = 220_000L; b.peerRx += 300
        b.seconds(5)                                    // wall 225 000
        b.callback("wifi", false)
        b.seconds(5)                                    // wall 230 000
        return b
    }

    @Test fun aFreshHandshakeBeforeTheFirstReadConnectsWithoutAStep() {
        val b = stableLoss()
        b.advance(300); b.callback("wifi", true)        // return at 230 300
        b.advance(200); b.peerHandshake = b.wall        // handshake at 230 500
        b.advance(500); b.tick()                        // first read at 231 000
        assertEquals(CONNECTED, b.state)
    }

    @Test fun anOldHandshakeWaitsThenNewReceivedBytesConnect() {
        val b = stableLoss()
        b.advance(300); b.callback("wifi", true)
        b.seconds(30)
        assertEquals(RECOVERING, b.state)
        b.peerRx += 1; b.seconds(1)
        assertEquals(CONNECTED, b.state)
    }

    @Test fun aFreshHandshakeConnectsWithTheUiAttached() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi"))
        b.seconds(120, ui = true); b.peerHandshake = 220_000L; b.peerRx += 300
        b.seconds(5, ui = true)
        b.callback("wifi", false); b.seconds(5, ui = true)
        b.advance(300); b.callback("wifi", true)
        b.advance(200); b.peerHandshake = b.wall
        b.advance(500); b.uiPoll()
        assertEquals(CONNECTED, b.state)
    }

    @Test fun aSecondCycleCannotReuseTheProvenHandshake() {
        val b = stableLoss()
        b.advance(300); b.callback("wifi", true)
        b.advance(200); b.peerHandshake = b.wall
        b.advance(500); b.tick()
        assertEquals(CONNECTED, b.state)
        b.seconds(10)
        b.callback("wifi", false); b.seconds(3)
        b.advance(100); b.callback("wifi", true)
        b.seconds(20)
        assertEquals(RECOVERING, b.state)
    }

    /** No statistics were read since the step: a fresh handshake looks like the unread rekey. */
    @Test fun aFreshHandshakeAfterAnUnanchoredStepNeedsDifferentialProof() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(10)                                   // wall 181 500
        b.advance(300); b.callback("wifi", true)        // return at 181 800
        b.advance(200); b.peerHandshake = b.wall        // genuinely fresh, at 182 000
        b.advance(500); b.tick()
        assertEquals(RECOVERING, b.state)
        b.peerRx += 148; b.seconds(1)                   // authenticated data after the return
        assertEquals(CONNECTED, b.state)
    }

    @Test fun aProofReadAfterTheStepReanchorsTheNextFirstReadProof() {
        val b = rekeyStepThenTwoStepLoss()
        b.seconds(10); b.advance(300); b.callback("wifi", true)
        b.advance(200); b.peerHandshake = b.wall
        b.advance(500); b.tick()
        assertEquals(RECOVERING, b.state)               // first cycle after the step: conservative
        b.peerRx += 148; b.seconds(1)
        assertEquals(CONNECTED, b.state)                // proof read on a continuous clock
        b.seconds(30)
        b.callback("wifi", false); b.seconds(5)
        b.advance(300); b.callback("wifi", true)
        b.advance(200); b.peerHandshake = b.wall        // next cycle: fresh before the first read
        b.advance(500); b.tick()
        assertEquals(CONNECTED, b.state)
    }

    @Test fun aUiReadAfterTheTrackerCaughtUpReanchorsTheFirstReadProof() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi", "cellular"))
        b.seconds(30); b.advance(500); b.stepWall(-60_000L)
        b.seconds(3)                                    // step seen while CONNECTED
        b.callback("wifi", false)                       // the tracker counts it too
        b.seconds(3, ui = true)                         // the app is opened: reads after the step
        b.callback("cellular", false)
        assertEquals(WAITING_NETWORK, b.state)
        b.seconds(5)
        b.advance(300); b.callback("wifi", true)
        b.advance(200); b.peerHandshake = b.wall
        b.advance(500); b.tick()
        assertEquals(CONNECTED, b.state)
    }

    @Test fun aLongSleepWhileWaitingKeepsTheFirstReadProof() {
        val b = stableLoss()
        b.advance(3_600_000L)                           // an hour asleep: both clocks advance
        b.seconds(2)
        b.advance(300); b.callback("wifi", true)
        b.advance(200); b.peerHandshake = b.wall
        b.advance(500); b.tick()
        assertEquals(CONNECTED, b.state)
    }

    @Test fun aForwardStepCannotProveWithTheOldRekeyAndTrafficStillRecovers() {
        val b = Bridge(100_000L, 100_000L, listOf("wifi", "cellular"))
        b.seconds(120); b.peerHandshake = 220_000L; b.peerRx += 300
        b.seconds(1); b.advance(500); b.stepWall(60_000L) // wall 281 500
        b.seconds(5)
        b.callback("wifi", false); b.seconds(5); b.callback("cellular", false)
        b.seconds(10); b.advance(300); b.callback("wifi", true)
        b.advance(700); b.tick()
        b.seconds(10)
        assertEquals(RECOVERING, b.state)               // 220 000 predates the return
        b.peerRx += 148; b.seconds(1)
        assertEquals(CONNECTED, b.state)
    }

    @Test fun waitingForANetworkReadsNothingAndAcceptsNothing() {
        val b = stableLoss()
        val reads = b.statisticsReads
        b.seconds(30, ui = true)
        assertEquals(WAITING_NETWORK, b.state)
        assertEquals(reads, b.statisticsReads)
        b.advance(300); b.callback("wifi", true)
        b.advance(700); b.tick()
        assertEquals(RECOVERING, b.state)
        b.advance(300); b.peerHandshake = b.wall        // fresh after the first read
        b.advance(700); b.tick()
        assertEquals(CONNECTED, b.state)
    }

    // ---- Sweeps: the audit's numbers are not the only ones ----

    /**
     * wireguard-go-like peer: handshakes stamped with the wall clock, a rekey
     * 120 s after the last one and authenticated data every second while
     * reachable; the observer ticks at x500 ms, the UI (if any) every second.
     */
    private class Simulation(networks: List<String>, private val ui: Boolean = false) {
        val bridge = Bridge(215_000L, 100_000L, networks)
        private var handshakeMono = 100_000L
        private var nextTick = 215_500L
        var peerReachable = true
        private var silentSinceLoss = false
        var connectedWithoutProof = false
            private set

        private fun watch() {
            if (silentSinceLoss && bridge.state == CONNECTED) connectedWithoutProof = true
        }

        fun runUntil(targetMono: Long) {
            while (bridge.mono < targetMono) {
                bridge.advance(100L)
                if (bridge.hasNetwork && peerReachable) {
                    if (bridge.mono - handshakeMono >= 120_000L) {
                        bridge.peerHandshake = bridge.wall
                        handshakeMono = bridge.mono
                    }
                    if (bridge.mono % 1_000L == 0L) bridge.peerRx += 148L
                }
                if (bridge.mono >= nextTick) {
                    nextTick += 1_000L
                    bridge.tick()
                    if (ui) bridge.uiPoll()
                    watch()
                }
            }
        }

        fun runFor(ms: Long) = runUntil(bridge.mono + ms)
        fun callback(network: String, usable: Boolean) { bridge.callback(network, usable); watch() }
        /** The peer goes silent as the last network disappears: no post-loss proof can exist. */
        fun loseLastNetworkWithSilentPeer(network: String) {
            peerReachable = false
            bridge.callback(network, false)
            assertEquals(WAITING_NETWORK, bridge.state)
            silentSinceLoss = true
        }
        /** Suspended CPU: both clocks advance, the observer's delay() does not. */
        fun sleepCpu(ms: Long) { bridge.advance(ms); nextTick += ms }
    }

    /** Rekey stamped 220 000, a 60 s step while CONNECTED, Wi-Fi then cellular lost. */
    private fun stepThenTwoStepLoss(ui: Boolean = false): Simulation {
        val s = Simulation(listOf("wifi", "cellular"), ui)
        s.runUntil(221_500L)
        assertEquals(220_000L, s.bridge.peerHandshake)
        s.bridge.stepWall(-60_000L)                     // wall 161 500
        s.runUntil(226_500L)
        s.callback("wifi", false)
        s.runUntil(231_500L)
        s.loseLastNetworkWithSilentPeer("cellular")     // wall 171 500
        return s
    }

    @Test fun noReturnTimeLetsTheOldRekeyProveRecovery() {
        val falseProofs = mutableListOf<Long>()
        for (returnMono in 231_600L..301_500L step 100L) {
            val s = stepThenTwoStepLoss()
            s.runUntil(returnMono)
            s.callback("wifi", true)
            s.runFor(30_000L)
            if (s.connectedWithoutProof) falseProofs += returnMono - 60_000L
        }
        assertEquals("return walls accepted as proof", emptyList<Long>(), falseProofs)
    }

    @Test fun noReturnTimeLetsTheOldRekeyProveRecoveryAfterASuspendedFirstRead() {
        val falseProofs = mutableListOf<Long>()
        for (returnMono in 231_600L..301_500L step 100L) {
            val s = stepThenTwoStepLoss()
            s.runUntil(returnMono)
            s.callback("wifi", true)
            s.sleepCpu(25_000L)
            s.runFor(30_000L)
            if (s.connectedWithoutProof) falseProofs += returnMono - 60_000L
        }
        assertEquals("return walls accepted as proof", emptyList<Long>(), falseProofs)
    }

    @Test fun aShortStepWithTheWholeChainInsideItCannotProveRecovery() {
        val falseProofs = mutableListOf<String>()
        for (stepAt in listOf(220_100L, 220_500L, 221_000L)) {
            for (returnAt in (stepAt + 300L)..(stepAt + 6_000L) step 100L) {
                val s = Simulation(listOf("wifi", "cellular"))
                s.runUntil(stepAt)
                s.bridge.stepWall(-3_000L)
                s.runFor(100L); s.callback("wifi", false)
                s.runFor(100L); s.loseLastNetworkWithSilentPeer("cellular")
                s.runUntil(returnAt)
                s.callback("wifi", true)
                s.runFor(30_000L)
                if (s.connectedWithoutProof) falseProofs += "step@$stepAt return@$returnAt"
            }
        }
        assertEquals(emptyList<String>(), falseProofs)
    }

    @Test fun aReachablePeerRecoversWithinTwoReadsWhateverTheReturnTime() {
        for (returnMono in 231_600L..301_500L step 100L) {
            val s = stepThenTwoStepLoss()
            s.runUntil(returnMono)
            s.peerReachable = true
            s.callback("wifi", true)
            s.runFor(2_100L)
            assertEquals("return at monotonic $returnMono", CONNECTED, s.bridge.state)
        }
    }
}
