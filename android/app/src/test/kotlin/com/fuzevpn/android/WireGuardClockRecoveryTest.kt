package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

/** Real policy/tracker with independent clocks; no host clock or tunnel changes. */
class WireGuardClockRecoveryTest {
    private class Fixture(initialHandshake: Long? = 5_000L, start: Long = 6_000L) {
        var wall = start
        var monotonic = start * 1_000_000L
        val tracker = PhysicalNetworkTracker<String>(monotonicNanos = { monotonic }) { wall }
        val policy = WireGuardRecoveryPolicy(monotonicNanos = { monotonic }) { wall }
        init {
            tracker.update("wifi", true)
            policy.start(1, tracker.snapshot(), initialHandshake?.let { TunnelStatistics(100, 200, it) })
        }
        fun at(wallMillis: Long, monotonicMillis: Long) {
            require(monotonicMillis * 1_000_000L >= monotonic)
            wall = wallMillis
            monotonic = monotonicMillis * 1_000_000L
        }
        fun change(available: Boolean, wallMillis: Long, monotonicMillis: Long, process: Boolean = true) {
            at(wallMillis, monotonicMillis)
            tracker.update("wifi", available)
            if (process) policy.updateNetwork(tracker.snapshot())
        }
        fun sample(handshake: Long?, rx: Long = 100, instance: Long = 1,
            generation: Long = tracker.snapshot().generation) {
            policy.observe(instance, generation, TunnelStatistics(rx, 200, handshake))
        }
        fun assertRecovering() = assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        fun assertConnected() = assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun firstFreshHandshakeStillProvesRecoveryBeforeAnyRecoveryRead() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000)
        f.at(7_001, 7_001)
        f.sample(7_001)
        f.assertConnected()
    }

    @Test fun delayedSchedulerKeepsTheCallbackTimeForTheFirstFreshHandshake() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000, process = false)
        f.at(10_000, 10_000)
        f.policy.updateNetwork(f.tracker.snapshot())
        f.sample(7_001)
        f.assertConnected()
    }

    @Test fun elapsedTimeIncludingLongSleepKeepsAFirstFreshHandshakeValid() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000)
        f.at(3_607_000, 3_607_000)
        f.policy.updateNetwork(f.tracker.snapshot())
        f.sample(7_001)
        f.assertConnected()
        assertEquals(0L, f.tracker.snapshot().clockGeneration)
    }

    @Test fun regressionOldHandshakeCannotProveRecoveryAfterRollbackThenCatchUp() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(6_001, 12_001)
        f.sample(5_000)
        repeat(60) { f.sample(5_000) }
        f.assertRecovering()
        println("R15_01_FIXED old=5000 loss=6000 return_wall=1000 first_wall=6001 rx=100 state=RECOVERING")
    }

    @Test fun regressionWithoutAnyPreLossStatisticsRemainsConservative() {
        val f = Fixture(initialHandshake = null)
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(6_001, 7_001)
        f.sample(5_000)
        f.assertRecovering()
        f.sample(5_000, rx = 101)
        f.assertConnected()
    }

    @Test fun missingPreLossProofRequiresDifferentialEvidenceEvenWithAContinuousClock() {
        val f = Fixture(initialHandshake = null)
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000)
        f.at(8_000, 8_000)
        f.sample(7_001)
        f.sample(7_001)
        f.assertRecovering()
        f.sample(7_002)
        f.assertConnected()
    }

    @Test fun coalescedCallbacksRetainTheIntermediateClockDiscontinuity() {
        val f = Fixture(initialHandshake = 100, start = 1_000)
        f.change(false, 6_000, 6_000, process = false)
        f.change(true, 1_000, 7_000, process = false)
        f.at(6_001, 12_001)
        f.policy.updateNetwork(f.tracker.snapshot())
        assertTrue(f.tracker.snapshot().clockGeneration > 0)
        f.sample(5_000)
        f.assertRecovering()
    }

    @Test fun forwardClockCorrectionCannotMakeAnOldFutureHandshakeFresh() {
        val f = Fixture(initialHandshake = 49_999)
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000)
        f.at(60_000, 8_000)
        f.sample(50_000)
        f.assertRecovering()
        repeat(60) { f.sample(50_000) }
        f.assertRecovering()
    }

    @Test fun knownPreLossFutureHandshakeIsRejectedAfterItStopsBeingFuture() {
        val f = Fixture(initialHandshake = 5_000, start = 1_000)
        f.change(false, 2_000, 2_000)
        f.change(true, 3_000, 3_000)
        f.at(6_001, 6_001)
        f.sample(5_000)
        f.assertRecovering()
    }

    @Test fun initiallyFutureBaselineCannotBeReinterpretedAfterClockCatchUp() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(2_000, 8_000)
        f.sample(5_000)
        f.at(6_001, 12_001)
        f.sample(5_000)
        f.assertRecovering()
    }

    @Test fun clockRollbackStillAllowsNewAuthenticatedReceivedBytes() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(2_000, 8_000)
        f.sample(5_000)
        f.sample(5_000, rx = 101)
        f.assertConnected()
    }

    @Test fun newHandshakeAfterAnAmbiguousReadCanProveRecovery() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(2_000, 8_000)
        f.sample(1_001)
        f.assertRecovering()
        f.sample(1_002)
        f.assertConnected()
    }

    @Test fun clockProofCannotBypassInstanceAndGenerationFences() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000)
        f.at(8_000, 8_000)
        f.sample(7_001, instance = 2)
        f.sample(7_001, generation = f.tracker.snapshot().generation - 1)
        f.assertRecovering()
        f.sample(7_001)
        f.assertConnected()
    }

    @Test fun absentPeerCannotBecomeAZeroBaselineBeforeOldPeerStatisticsReturn() {
        val f = Fixture()
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(6_001, 12_001)
        f.sample(null, rx = 0)
        f.sample(5_000)
        f.sample(5_000)
        f.assertRecovering()
        f.sample(5_000, rx = 101)
        f.assertConnected()
    }

    @Test fun emptyConnectedReadDoesNotDiscardTheActivationBaseline() {
        val f = Fixture()
        f.sample(null, rx = 0)
        f.change(false, 6_000, 6_000)
        f.change(true, 7_000, 7_000)
        f.at(8_000, 8_000)
        f.sample(7_001)
        f.assertConnected()
    }

    /** H-R15-01 O5, original numbers: the 5 s step precedes the loss and a non-blocking
     * change absorbs it while CONNECTED; the 5 000 rekey after activation was never read. */
    @Test fun originalNumbersWithTheStepBeforeATwoStepLossStayRecovering() {
        var wall = 4_000L
        var mono = 4_000L
        val tracker = PhysicalNetworkTracker<String>(monotonicNanos = { mono * 1_000_000L }) { wall }
        val policy = WireGuardRecoveryPolicy(monotonicNanos = { mono * 1_000_000L }) { wall }
        tracker.update("wifi", true); tracker.update("cellular", true)
        policy.start(1, tracker.snapshot(), TunnelStatistics(100, 200, 4_000))
        wall = 5_500; mono = 5_500; policy.updateNetwork(tracker.snapshot())
        wall = 1_000; mono = 6_000; policy.updateNetwork(tracker.snapshot())
        wall = 1_200; mono = 6_200
        tracker.update("wifi", false); policy.updateNetwork(tracker.snapshot())
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
        wall = 1_500; mono = 6_500
        tracker.update("cellular", false); policy.updateNetwork(tracker.snapshot())
        wall = 2_500; mono = 7_500
        tracker.update("wifi", true); policy.updateNetwork(tracker.snapshot())
        wall = 6_001; mono = 11_001
        policy.updateNetwork(tracker.snapshot())
        repeat(61) { policy.observe(1, tracker.snapshot().generation, TunnelStatistics(100, 200, 5_000)) }
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
    }

    @Test fun originalNumbersWithTheStepBeforeASingleLossStayRecovering() {
        val f = Fixture(initialHandshake = 4_000, start = 4_000)
        f.at(5_500, 5_500); f.policy.updateNetwork(f.tracker.snapshot())
        f.at(1_000, 6_000); f.policy.updateNetwork(f.tracker.snapshot())
        f.change(false, 1_500, 6_500)
        f.change(true, 2_500, 7_500)
        f.at(6_001, 11_001)
        repeat(61) { f.sample(5_000) }
        f.assertRecovering()
    }

    /** The flagship numbers with stale statistics (activation 4 000, rekey 5 000 never
     * read): the veto cannot apply, only clock continuity rejects the old rekey. */
    @Test fun regressionWithStalePreLossStatisticsReliesOnClockContinuity() {
        val f = Fixture(initialHandshake = 4_000, start = 4_000)
        f.change(false, 6_000, 6_000)
        f.change(true, 1_000, 7_000)
        f.at(6_001, 12_001)
        repeat(61) { f.sample(5_000) }
        f.assertRecovering()
    }

    /** Queued callbacks hide a forward round trip from the policy (the loss was stamped
     * during it): only the tracker clock generation reveals it before a late first read. */
    @Test fun coalescedCallbacksHidingAForwardRoundTripStayRecovering() {
        val f = Fixture(initialHandshake = 10_000, start = 10_000)
        // Wall clock 60 s ahead from monotonic 20 000: a rekey is stamped 80 100.
        f.change(false, 80_200, 20_200, process = false)
        f.change(true, 20_400, 20_400, process = false) // clock corrected back before the return
        f.at(20_500, 20_500)
        f.policy.updateNetwork(f.tracker.snapshot())
        f.assertRecovering()
        f.at(80_150, 80_150)                            // suspended CPU: first read a minute later
        f.sample(80_100)
        f.assertRecovering()
        f.sample(80_100, rx = 101)
        f.assertConnected()
    }

    /** A stamp later than the current wall time is never first-read proof, even on a
     * continuous clock (a step between the activation read and start() goes unseen). */
    @Test fun aHandshakeStampedAfterTheCurrentTimeIsNeverFirstReadProof() {
        val f = Fixture(initialHandshake = 4_999, start = 1_000)
        f.change(false, 2_000, 2_000)
        f.change(true, 3_000, 3_000)
        f.at(4_000, 4_000)
        f.sample(5_000)
        f.assertRecovering()
        f.at(6_000, 6_000)
        f.sample(5_000)
        f.assertRecovering()
    }

    /**
     * Tracker samples preempted for [preemptMillis] before their wall read cannot see
     * a shorter backward step; the policy's own reads still do. A statistics read
     * must not re-anchor the clock trust across a step it may predate.
     */
    private class PreemptedTracker(preemptMillis: Long = 2_000L) {
        var wall = 100_000L
        var mono = 100_000L
        private var reads = 0L
        val tracker = PhysicalNetworkTracker<String>(monotonicNanos = {
            (if (reads++ % 2L == 0L) mono - preemptMillis else mono) * 1_000_000L
        }) { wall }
        val policy = WireGuardRecoveryPolicy(monotonicNanos = { mono * 1_000_000L }) { wall }
        init {
            tracker.update("wifi", true)
            policy.start(1, tracker.snapshot(), TunnelStatistics(100, 200, 100_000))
        }
        fun at(wallMillis: Long, monotonicMillis: Long) { wall = wallMillis; mono = monotonicMillis }
        fun update() = policy.updateNetwork(tracker.snapshot())
        fun change(available: Boolean, wallMillis: Long, monotonicMillis: Long) {
            at(wallMillis, monotonicMillis)
            tracker.update("wifi", available)
            update()
        }
        fun observe(rx: Long, handshake: Long) =
            policy.observe(1, tracker.snapshot().generation, TunnelStatistics(rx, 200, handshake))
        val state get() = policy.state
    }

    @Test fun aStepDuringAStatisticsReadCannotReanchorTheClockTrust() {
        val p = PreemptedTracker()
        p.at(110_000, 110_000); p.update()              // updateNetwork(physical), then statistics()
        // The read returns handshake 100 000; a rekey at 110 100 and a 1.5 s step follow.
        p.at(108_800, 110_300); p.update()              // updateNetwork(after) sees the step
        p.observe(rx = 100, handshake = 100_000)
        p.change(false, 109_100, 110_600)               // the tracker misses the step
        p.change(true, 109_500, 111_000)                // return before the rekey stamp
        p.at(110_200, 111_700)
        p.observe(rx = 100, handshake = 110_100)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, p.state)
        p.observe(rx = 101, handshake = 110_100)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, p.state)
    }

    @Test fun aStepJustBeforeObserveCannotReanchorTheClockTrust() {
        val p = PreemptedTracker()
        p.at(110_000, 110_000); p.update()              // read: handshake 100 000; rekey at 110 100
        p.at(110_150, 110_150); p.update()              // updateNetwork(after): still continuous
        p.at(108_800, 110_300)                          // 1.5 s step before observe()
        p.observe(rx = 100, handshake = 100_000)
        p.change(false, 109_100, 110_600)
        p.change(true, 109_500, 111_000)
        p.at(110_200, 111_700)
        p.observe(rx = 100, handshake = 110_100)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, p.state)
    }

    @Test fun aStepDuringTheProofReadCannotReanchorTheClockTrust() {
        val p = PreemptedTracker()
        p.change(false, 105_000, 105_000)
        p.change(true, 106_000, 106_000)
        p.at(107_000, 107_000); p.observe(rx = 100, handshake = 100_000) // vetoed: baseline
        p.at(108_000, 108_000); p.update()              // read: new RX; rekey at 108 100, then a step
        p.at(106_800, 108_300); p.update()
        p.observe(rx = 150, handshake = 100_000)        // differential proof
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, p.state)
        p.change(false, 107_100, 108_600)               // the tracker misses the step
        p.change(true, 107_500, 109_000)
        p.at(108_200, 109_700)
        p.observe(rx = 150, handshake = 108_100)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, p.state)
    }
}
