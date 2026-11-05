package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class WireGuardRecoveryPolicyTest {
    private var monotonicNanos = 1_000_000_000L
    private var nowMillis = 1_000L
        set(value) {
            monotonicNanos += (value - field).coerceAtLeast(1L) * 1_000_000L
            field = value
        }
    private val policy = WireGuardRecoveryPolicy(monotonicNanos = { monotonicNanos }) { nowMillis }
    private val networks = PhysicalNetworkTracker<String>(monotonicNanos = { monotonicNanos }) { nowMillis }
    private fun sample(rx: Long = 10, tx: Long = 20, handshake: Long? = 100) =
        policy.observe(1, networks.snapshot().generation, TunnelStatistics(rx, tx, handshake))
    private fun start() {
        networks.update("wifi", true)
        policy.start(1, networks.snapshot(), TunnelStatistics(10, 20, 100))
    }
    private fun outage() { networks.update("wifi", false); policy.updateNetwork(networks.snapshot()) }
    private fun restore() { networks.update("wifi", true); policy.updateNetwork(networks.snapshot()) }

    @Test fun lastPhysicalNetworkLossWaitsWithoutPeerProof() {
        start(); outage()
        assertEquals(WireGuardRecoveryPolicy.State.WAITING_NETWORK, policy.state)
        sample(rx = 100, handshake = 200)
        assertEquals(WireGuardRecoveryPolicy.State.WAITING_NETWORK, policy.state)
    }

    @Test fun losingWifiWithCellularAvailableDoesNotInterrupt() {
        start(); networks.update("cellular", true); outage()
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun oldHandshakeAndOutgoingTrafficCannotConfirmRecovery() {
        start(); outage(); restore(); sample(); sample(tx = 1_000)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        policy.observe(1, networks.snapshot().generation, null)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
    }

    @Test fun freshHandshakeConfirmsExistingTunnel() {
        start(); outage(); restore(); sample(); sample(handshake = 101)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun newAuthenticatedReceivedBytesConfirmExistingTunnel() {
        start(); outage(); restore(); sample(); sample(rx = 11)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun repeatedOutageRequiresANewBaseline() {
        start(); outage(); restore(); sample(); outage(); restore(); sample(rx = 50)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        sample(rx = 51)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun fastLossAndReturnAreNotHiddenByQueuedCallbacks() {
        start(); networks.update("wifi", false); networks.update("wifi", true)
        policy.updateNetwork(networks.snapshot())
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
    }

    @Test fun samplesFromStoppedOrReplacedTunnelCannotRestoreConnection() {
        start(); outage(); restore(); sample(); policy.stop(); sample(rx = 100)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        policy.start(2, networks.snapshot()); outage(); restore(); sample(rx = 200)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
    }

    @Test fun networkChangeDuringSamplingRejectsOldProof() {
        start(); outage(); restore(); sample()
        val before = networks.snapshot().generation
        networks.update("wifi", false); networks.update("wifi", true)
        policy.updateNetwork(networks.snapshot())
        policy.observe(1, before, TunnelStatistics(999, 999, 999))
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
    }

    @Test fun inventoryRemovesAnUnobservedStartupNetwork() {
        start(); networks.update("startup-outside-callback-scope", true)
        networks.update("wifi", false)
        assertTrue(networks.snapshot().available)
        assertTrue(networks.reconcile(networks.snapshot().generation, emptySet()))
        policy.updateNetwork(networks.snapshot())
        assertEquals(WireGuardRecoveryPolicy.State.WAITING_NETWORK, policy.state)
    }

    @Test fun inventoryCannotOverwriteANewerNetworkCallback() {
        start()
        val before = networks.snapshot().generation
        networks.update("cellular", true)
        assertFalse(networks.reconcile(before, emptySet()))
        assertTrue(networks.snapshot().available)
        outage()
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun inventoryDetectsLossAndReturnWithoutCallbacks() {
        start()
        networks.reconcile(networks.snapshot().generation, emptySet())
        policy.updateNetwork(networks.snapshot())
        assertEquals(WireGuardRecoveryPolicy.State.WAITING_NETWORK, policy.state)
        networks.reconcile(networks.snapshot().generation, setOf("wifi-returned"))
        policy.updateNetwork(networks.snapshot())
        sample(); sample(tx = 50)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        sample(rx = 11)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun unchangedInventoryDoesNotInvalidateRecoveryBaseline() {
        start(); outage(); restore(); sample()
        val before = networks.snapshot().generation
        networks.reconcile(before, setOf("wifi"))
        assertEquals(before, networks.snapshot().generation)
        sample(rx = 11)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun handshakeCompletedBeforeFirstRecoverySampleIsAccepted() {
        start(); outage(); restore()
        nowMillis++
        sample(handshake = nowMillis)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun firstRecoverySampleRejectsTheHandshakeFromBeforeTheNetworkReturn() {
        start(); outage()
        nowMillis = 2_000
        restore()
        sample(rx = 100, handshake = 1_999)
        sample(rx = 100, tx = 10_000, handshake = 1_999)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
    }

    @Test fun delayedBridgeWorkUsesTheCallbackTimeRatherThanTheSampleTime() {
        start(); outage()
        nowMillis = 2_000
        networks.update("wifi", true)
        nowMillis = 10_000 // bridge processing was queued after the callback
        policy.updateNetwork(networks.snapshot())
        sample(handshake = 2_001)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun aNewGenerationCannotUseThePreviousReturnHandshakeOnItsFirstSample() {
        start(); outage(); restore()
        nowMillis = 2_000
        networks.update("cellular", true)
        policy.updateNetwork(networks.snapshot())
        sample(handshake = 1_500)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        nowMillis++
        sample(handshake = 2_001)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun firstRecoverySampleWithNoTimestampStillNeedsDifferentialProof() {
        policy.start(1, PhysicalNetworkSnapshot(true, 1))
        policy.updateNetwork(PhysicalNetworkSnapshot(false, 2, 1))
        policy.updateNetwork(PhysicalNetworkSnapshot(true, 3, 1))
        policy.observe(1, 3, TunnelStatistics(100, 200, Long.MAX_VALUE))
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        policy.observe(1, 3, TunnelStatistics(101, 200, Long.MAX_VALUE))
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun noOpInventoryAndCallbacksPreserveTheNetworkTimestamp() {
        start()
        val before = networks.snapshot()
        nowMillis = 2_000
        networks.update("wifi", true)
        assertTrue(networks.reconcile(before.generation, setOf("wifi")))
        assertEquals(before, networks.snapshot())
        networks.reconcile(before.generation, emptySet())
        assertEquals(2_000L, networks.snapshot().changedAtMillis)
    }

    @Test fun inventoryReturnCanProveAnAlreadyCompletedHandshakeOnItsFirstRead() {
        start()
        networks.reconcile(networks.snapshot().generation, emptySet())
        policy.updateNetwork(networks.snapshot())
        nowMillis = 2_000
        networks.reconcile(networks.snapshot().generation, setOf("cellular"))
        policy.updateNetwork(networks.snapshot())
        nowMillis++
        sample(handshake = 2_001)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun aPreviousHandshakeInTheFutureAfterClockRollbackCannotProveTheFirstReturnSample() {
        start(); outage()
        nowMillis = 100
        restore()
        nowMillis = 200
        sample(handshake = 1_000)
        sample(tx = 1_000, handshake = 1_000)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        sample(rx = 11, handshake = 1_000)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun handshakeInTheSameMillisecondAsTheReturnIsAmbiguousAndNeedsMoreProof() {
        start(); outage(); restore()
        sample(handshake = nowMillis)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        sample(rx = 11, handshake = nowMillis)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun firstFreshHandshakeStillRequiresTheCurrentInstanceAndNetworkGeneration() {
        start(); outage(); restore()
        nowMillis++
        val physical = networks.snapshot()
        val fresh = TunnelStatistics(100, 200, nowMillis)
        policy.observe(2, physical.generation, fresh)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        policy.observe(1, physical.generation - 1, fresh)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        policy.observe(1, physical.generation, fresh)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun aConnectedReadReplacesStaleActivationStatisticsAsThePreLossVeto() {
        start()                                         // activation handshake 100
        sample(rx = 50, handshake = 5_000)              // UI read: a stamp ahead of this clock
        outage()
        nowMillis = 2_000
        restore()
        nowMillis = 6_001
        sample(rx = 50, handshake = 5_000)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        sample(rx = 51, handshake = 5_000)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun aConnectedReadRightAfterStartKeepsTheFirstReadProof() {
        start()
        sample(rx = 50, handshake = 150)                // read before any network update
        outage()
        nowMillis = 2_000
        restore()
        nowMillis++
        sample(rx = 50, handshake = nowMillis)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }

    @Test fun staleActivationStatisticsAndAStepWhileConnectedCannotProveTheFirstRead() {
        start()                                         // activation handshake 100 at 1 000
        networks.update("cellular", true); policy.updateNetwork(networks.snapshot())
        nowMillis = 5_000                               // a rekey stamped 5 000 is never read
        policy.updateNetwork(networks.snapshot())
        nowMillis = 3_000                               // 2 s backward step while CONNECTED
        policy.updateNetwork(networks.snapshot())
        networks.update("wifi", false); policy.updateNetwork(networks.snapshot())
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
        networks.update("cellular", false); policy.updateNetwork(networks.snapshot())
        nowMillis = 4_000
        restore()
        nowMillis = 5_500
        sample(handshake = 5_000)
        assertEquals(WireGuardRecoveryPolicy.State.RECOVERING, policy.state)
        sample(rx = 11, handshake = 5_000)
        assertEquals(WireGuardRecoveryPolicy.State.CONNECTED, policy.state)
    }
}
