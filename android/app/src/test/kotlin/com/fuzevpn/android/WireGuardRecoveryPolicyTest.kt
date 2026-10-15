package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class WireGuardRecoveryPolicyTest {
    private val policy = WireGuardRecoveryPolicy()
    private val networks = PhysicalNetworkTracker<String>()
    private fun sample(rx: Long = 10, tx: Long = 20, handshake: Long? = 100) =
        policy.observe(1, networks.snapshot().generation, TunnelStatistics(rx, tx, handshake))
    private fun start() { networks.update("wifi", true); policy.start(1, networks.snapshot()) }
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
}
