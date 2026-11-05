package com.fuzevpn.android

import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Engine worker bounds with shortened limits (same code paths as production):
 * only a start or stop that may still own the TUN makes the instance uncertain
 * and refuses later calls; reads and key operations are bounded and leave the
 * tunnel's proof intact; abandoned calls return late without side effects.
 */
class WireGuardControllerBoundsTest {
    private val fixture = WireGuardWorkerFixture()

    @After fun releaseEngine() = fixture.close()

    private fun controller(timeouts: WireGuardController.Timeouts = BOUNDS) = fixture.track(
        WireGuardController(fixture.context(), fixture.store(), {}, { fixture.engine }, timeouts),
    )

    private fun code(block: () -> Any?): String = try {
        block().toString()
    } catch (error: VpnNativeException) {
        error.code
    }

    @Test fun anExpiredStopStaysUncertainAndBlocksASecondTunnelUntilItReturns() {
        val controller = controller()
        assertTrue(controller.connect(fixture.request()))
        val identity = controller.currentConnectionIdentityFingerprint(fixture.account)
        val wgTurnOff = fixture.gate()
        fixture.engine.downGate = wgTurnOff
        val stop = fixture.call { controller.disconnect() }
        assertEquals("blocked", stop.await(BOUNDS.stopMillis - 500))
        assertEquals("false", stop.await(BOUNDS.stopMillis + SETTLE_MS))

        // The abandoned stop may still own the TUN: refuse at once, never queue.
        val refused = listOf(
            fixture.call { controller.connect(fixture.request()) },
            fixture.call { controller.disconnect() },
            fixture.call { controller.getOrCreatePublicKey(fixture.account) },
            fixture.call { controller.statistics() },
            fixture.call { controller.clearAccountIdentity(fixture.account) },
            fixture.call { controller.currentConnectionIdentityFingerprint(fixture.account) },
        ).map { it.await(PROMPT_MS) }
        assertEquals(listOf("wireguard_operation_pending", "false", "wireguard_operation_pending",
            "wireguard_operation_pending", "wireguard_identity_in_use", "wireguard_identity_unavailable"), refused)
        assertNull(controller.recoveryBaseline())
        assertEquals(identity, fixture.call { controller.existingIdentityFingerprint(fixture.account) }.await(PROMPT_MS))

        // Late return: DOWN is confirmed by the abandoned stop; nothing refused runs afterwards.
        wgTurnOff.countDown()
        assertTrue(fixture.eventually { controller.disconnect() })
        assertFalse(controller.isConnected())
        assertEquals(1, fixture.engine.stopCalls.get())
        assertEquals(1, fixture.engine.startCalls.get())
        assertTrue(controller.connect(fixture.request()))
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
    }

    @Test fun aStopThatReturnsWithoutConfirmingDownStillBlocksASecondTunnel() {
        val controller = controller()
        assertTrue(controller.connect(fixture.request()))
        fixture.engine.confirmsDown = false
        assertFalse(controller.disconnect())
        assertTrue(controller.isConnected())
        assertEquals("wireguard_operation_pending", code { controller.connect(fixture.request()) })
        assertNull(controller.recoveryBaseline())
        assertEquals("wireguard_identity_unavailable", code { controller.currentConnectionIdentityFingerprint(fixture.account) })
        assertEquals(1, fixture.engine.startCalls.get())
        fixture.engine.confirmsDown = true
        assertTrue(controller.disconnect())
        assertTrue(controller.connect(fixture.request()))
    }

    @Test fun anExpiredStartStaysUncertainUntilItsLateReturn() {
        val controller = controller()
        val publicKey = controller.getOrCreatePublicKey(fixture.account)
        val wgTurnOn = fixture.gate()
        fixture.engine.startGate = wgTurnOn
        assertEquals("TimeoutException", fixture.call { controller.connect(fixture.request()) }
            .await(BOUNDS.connectMillis + SETTLE_MS))

        // No active marker yet, but the abandoned start may still create the TUN.
        val whileStarting = listOf(
            fixture.call { controller.disconnect() },
            fixture.call { controller.connect(fixture.request()) },
            fixture.call { controller.getOrCreatePublicKey(fixture.account) },
            fixture.call { controller.clearAccountIdentity(fixture.account) },
            fixture.call { controller.currentConnectionIdentityFingerprint(fixture.account) },
        ).map { it.await(PROMPT_MS) }
        assertEquals(listOf("false", "wireguard_operation_pending", "wireguard_operation_pending",
            "wireguard_identity_in_use", "wireguard_identity_unavailable"), whileStarting)
        assertNull(controller.recoveryBaseline())
        assertEquals(fixture.fingerprint(publicKey), controller.existingIdentityFingerprint(fixture.account))

        // Late return: the start completes alone; only a confirmed stop clears it.
        wgTurnOn.countDown()
        assertTrue(fixture.eventually { controller.isConnected() && controller.recoveryBaseline() != null })
        assertEquals(1, fixture.engine.startCalls.get())
        assertTrue(controller.disconnect())
        assertFalse(controller.isConnected())
        assertTrue(controller.connect(fixture.request()))
        assertEquals(fixture.fingerprint(publicKey), controller.currentConnectionIdentityFingerprint(fixture.account))
    }

    @Test fun aStalledKeyOperationIsBoundedAndNeverMakesTheEngineUncertain() {
        val controller = controller()
        val keystore = fixture.gate()
        fixture.keys.gate = keystore
        val key = fixture.call { controller.getOrCreatePublicKey(fixture.account) }
        assertEquals("blocked", key.await(BOUNDS.identityMillis - 500))
        assertEquals("wireguard_operation_pending", key.await(BOUNDS.identityMillis + SETTLE_MS))

        // A key operation never owns the TUN: no tunnel to confirm, nothing uncertain.
        assertEquals("true", fixture.call { controller.disconnect() }.await(PROMPT_MS))
        // A start queued behind it is withdrawn at its own bound and never runs.
        assertEquals("wireguard_operation_pending", fixture.call { controller.connect(fixture.request()) }
            .await(BOUNDS.connectMillis + SETTLE_MS))
        assertEquals("true", fixture.call { controller.disconnect() }.await(PROMPT_MS))

        // Late return: the key it persisted is the one later calls and the tunnel use.
        fixture.keys.gate = null
        keystore.countDown()
        val publicKey = controller.getOrCreatePublicKey(fixture.account)
        assertEquals(fixture.fingerprint(publicKey), controller.existingIdentityFingerprint(fixture.account))
        assertEquals(0, fixture.engine.startCalls.get())
        assertTrue(controller.connect(fixture.request()))
        assertEquals(fixture.fingerprint(publicKey), controller.currentConnectionIdentityFingerprint(fixture.account))
    }

    @Test fun aStopQueuedBehindAnExpiredReadWaitsForItAndSucceeds() {
        val controller = controller()
        assertTrue(controller.connect(fixture.request()))
        val identity = controller.currentConnectionIdentityFingerprint(fixture.account)
        val wgGetConfig = fixture.gate()
        fixture.engine.statisticsGate = wgGetConfig
        assertEquals("TimeoutException", fixture.call { controller.statistics() }
            .await(BOUNDS.statisticsMillis + SETTLE_MS))
        // A read queued behind it is withdrawn at its bound; the tunnel stays proven.
        assertEquals("wireguard_operation_pending", fixture.call { controller.statistics() }
            .await(BOUNDS.statisticsMillis + SETTLE_MS))
        assertNotNull(controller.recoveryBaseline())
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))

        // A stop is not refused behind a mere read: it waits within its own bound.
        val stop = fixture.call { controller.disconnect() }
        assertEquals("blocked", stop.await(300))
        fixture.engine.statisticsGate = null
        wgGetConfig.countDown()
        assertEquals("true", stop.await(BOUNDS.stopMillis + SETTLE_MS))
        assertNull(controller.recoveryBaseline())
        assertTrue(controller.connect(fixture.request()))
    }

    @Test fun callsThatFinishWithinTheirBoundsAreNeitherAbandonedNorUncertain() {
        val controller = controller(BOUNDS.copy(statisticsMillis = 2_000))
        val keystore = fixture.gate()
        fixture.keys.gate = keystore
        val key = fixture.call { controller.getOrCreatePublicKey(fixture.account) }
        fixture.releaseAfter(keystore, 200)
        val publicKey = key.await(BOUNDS.identityMillis + SETTLE_MS)
        assertEquals(fixture.fingerprint(publicKey), controller.existingIdentityFingerprint(fixture.account))

        val wgTurnOn = fixture.gate()
        fixture.engine.startGate = wgTurnOn
        val start = fixture.call { controller.connect(fixture.request()) }
        fixture.releaseAfter(wgTurnOn, 200)
        assertEquals("true", start.await(BOUNDS.connectMillis + SETTLE_MS))

        val wgGetConfig = fixture.gate()
        fixture.engine.statisticsGate = wgGetConfig
        val read = fixture.call { controller.statistics() }
        fixture.releaseAfter(wgGetConfig, 200)
        assertEquals(TunnelStatistics(100, 200, 5_000).toString(), read.await(2_000 + SETTLE_MS))
        assertEquals(TunnelStatistics(100, 200, 5_000), controller.recoveryBaseline())
        assertEquals(fixture.fingerprint(publicKey), controller.currentConnectionIdentityFingerprint(fixture.account))

        val wgTurnOff = fixture.gate()
        fixture.engine.downGate = wgTurnOff
        val stop = fixture.call { controller.disconnect() }
        fixture.releaseAfter(wgTurnOff, 200)
        assertEquals("true", stop.await(BOUNDS.stopMillis + SETTLE_MS))
        assertTrue(controller.connect(fixture.request()))
    }

    @Test fun theNominalIdentityStartAndStopPathIsUnchanged() {
        val controller = controller()
        assertEquals("wireguard_identity_unavailable", code { controller.existingIdentityFingerprint(fixture.account) })
        val publicKey = controller.getOrCreatePublicKey(fixture.account)
        assertEquals(publicKey, controller.getOrCreatePublicKey(fixture.account))
        val identity = controller.existingIdentityFingerprint(fixture.account)
        assertEquals(fixture.fingerprint(publicKey), identity)
        assertTrue(controller.disconnect())
        assertTrue(controller.connect(fixture.request(), requireExistingIdentity = true))
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
        assertEquals("wireguard_identity_unavailable", code { controller.currentConnectionIdentityFingerprint("another-account") })
        assertEquals(TunnelStatistics(100, 200, 5_000), controller.recoveryBaseline())
        assertEquals(TunnelStatistics(100, 200, 5_000), controller.statistics())
        assertEquals("wireguard_identity_in_use", code { controller.clearAccountIdentity(fixture.account) })
        assertTrue(controller.disconnect())
        assertFalse(controller.isConnected())
        assertNull(controller.recoveryBaseline())
        assertEquals(TunnelStatistics(), controller.statistics())
        assertEquals("wireguard_identity_unavailable", code { controller.currentConnectionIdentityFingerprint(fixture.account) })
        controller.clearAccountIdentity(fixture.account)
        assertEquals("wireguard_identity_unavailable", code { controller.existingIdentityFingerprint(fixture.account) })
        assertEquals("wireguard_identity_unavailable", code {
            controller.connect(fixture.request(), requireExistingIdentity = true)
        })
        assertEquals(1, fixture.engine.startCalls.get())
        assertEquals(1, fixture.engine.stopCalls.get())
    }

    private companion object {
        val BOUNDS = WireGuardController.Timeouts(
            connectMillis = 2_500,
            stopMillis = 2_000,
            statisticsMillis = 400,
            identityMillis = 2_000,
        )
        const val PROMPT_MS = 1_000L
        const val SETTLE_MS = 5_000L
    }
}
