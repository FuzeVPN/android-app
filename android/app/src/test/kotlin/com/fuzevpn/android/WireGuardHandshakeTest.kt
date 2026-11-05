package com.fuzevpn.android

import com.wireguard.android.backend.Backend
import com.wireguard.android.backend.Statistics
import com.wireguard.android.backend.Tunnel
import com.wireguard.config.Config
import com.wireguard.crypto.Key
import org.junit.Assert.*
import org.junit.Test
import java.lang.reflect.InvocationTargetException

/** Exercises the production activation/wait boundary with no Android TUN or peer. */
class WireGuardHandshakeTest {
    private val unsafeClass = Class.forName("sun.misc.Unsafe")
    private val unsafe = unsafeClass.getDeclaredField("theUnsafe").apply { isAccessible = true }.get(null)
    private val peerKey = Key.fromBytes(ByteArray(32) { (it + 1).toByte() })
    private val managedTunnelClass = Class.forName("com.fuzevpn.android.WireGuardController\$ManagedTunnel")
    private val tunnel = managedTunnelClass.getDeclaredConstructor(String::class.java, kotlin.jvm.functions.Function0::class.java)
        .apply { isAccessible = true }.newInstance("test", { Unit }) as Tunnel

    private fun <T> allocate(type: Class<T>): T = type.cast(
        unsafeClass.getMethod("allocateInstance", Class::class.java).invoke(unsafe, type),
    )

    private fun statistics(handshake: Long, key: Key = peerKey): Statistics = allocate(Statistics::class.java).also {
        Statistics::class.java.getDeclaredField("stats").apply { isAccessible = true }.set(
            it, hashMapOf(key to Statistics.PeerStats(100, 200, handshake)),
        )
    }

    private fun controller(backend: Backend) = allocate(WireGuardController::class.java).also {
        WireGuardController::class.java.getDeclaredField("backend\$delegate").apply { isAccessible = true }
            .set(it, lazyOf(backend))
    }

    private class FakeBackend : Backend {
        var handshake = 0L
        var sampleCount = 0
        var onStart: () -> Unit = {}
        var readStatistics: () -> Statistics = { error("statistics not configured") }
        override fun getRunningTunnelNames() = setOf("test")
        override fun getState(tunnel: Tunnel) = Tunnel.State.UP
        override fun getStatistics(tunnel: Tunnel): Statistics { sampleCount++; return readStatistics() }
        override fun getVersion() = "test"
        override fun isAlwaysOn() = false
        override fun isLockdownEnabled() = false
        override fun setState(tunnel: Tunnel, state: Tunnel.State, config: Config?): Tunnel.State {
            onStart()
            return state
        }
    }

    private fun waitForHandshake(controller: WireGuardController, isCurrent: () -> Boolean): Boolean =
        WireGuardController::class.java.getDeclaredMethod(
            "waitForHandshake", managedTunnelClass, Key::class.java,
            kotlin.jvm.functions.Function0::class.java,
        ).apply { isAccessible = true }.invoke(controller, tunnel, peerKey, isCurrent) as Boolean

    @Test fun handshakeCompletedDuringActivationSurvivesADelayedBackendReturn() {
        val backend = FakeBackend()
        backend.readStatistics = { statistics(backend.handshake) }
        backend.onStart = {
            backend.handshake = System.currentTimeMillis()
            Thread.sleep(2_100) // exceeds the old post-activation skew allowance
        }
        val controller = controller(backend)
        val activate = WireGuardController::class.java.getDeclaredMethod(
            "activateBackend", managedTunnelClass, Config::class.java, kotlin.jvm.functions.Function0::class.java,
        ).apply { isAccessible = true }
        activate.invoke(controller, tunnel, allocate(Config::class.java), { true })
        assertTrue(System.currentTimeMillis() - backend.handshake >= 2_000)
        assertTrue(waitForHandshake(controller) { backend.sampleCount == 0 })
    }

    @Test fun noHandshakeIsRejected() {
        val backend = FakeBackend().apply { readStatistics = { statistics(0) } }
        assertFalse(waitForHandshake(controller(backend)) { backend.sampleCount == 0 })
        assertEquals(1, backend.sampleCount)
    }

    @Test fun aFreshInstanceHandshakeSurvivesDrasticWallClockChanges() {
        // Simulate the timestamp generated on either side of a clock correction;
        // never change the host's clock. The fresh native instance is the fence.
        for (timestamp in listOf(1L, System.currentTimeMillis() - 31_536_000_000L, Long.MAX_VALUE)) {
            val backend = FakeBackend().apply { readStatistics = { statistics(timestamp) } }
            assertTrue(waitForHandshake(controller(backend)) { backend.sampleCount == 0 })
            assertEquals(1, backend.sampleCount)
        }
    }

    @Test fun anotherPeerCannotProveTheRequestedPeerHandshake() {
        val otherPeer = Key.fromBytes(ByteArray(32) { (it + 65).toByte() })
        val backend = FakeBackend().apply { readStatistics = { statistics(1, otherPeer) } }
        val controller = controller(backend)
        assertFalse(waitForHandshake(controller) { backend.sampleCount == 0 })
        backend.sampleCount = 0
        backend.readStatistics = { statistics(1, peerKey) }
        assertTrue(waitForHandshake(controller) { backend.sampleCount == 0 })
    }

    @Test fun recoveryBaselineRetainsTheActivationProofOnlyForAnActiveInstance() {
        val backend = FakeBackend().apply { readStatistics = { statistics(5_000) } }
        val controller = controller(backend)
        assertTrue(waitForHandshake(controller) { backend.sampleCount == 0 })
        assertNull(controller.recoveryBaseline())
        WireGuardController::class.java.getDeclaredField("activeTunnel").apply { isAccessible = true }
            .set(controller, tunnel)
        WireGuardController::class.java.getDeclaredField("activePeerKey").apply { isAccessible = true }
            .set(controller, peerKey)
        assertEquals(TunnelStatistics(100, 200, 5_000), controller.recoveryBaseline())
        WireGuardController::class.java.getDeclaredField("operationUncertain").apply { isAccessible = true }
            .setBoolean(controller, true)
        assertNull(controller.recoveryBaseline())
    }

    @Test fun cancellationDoesNotReadOrAcceptPeerStatistics() {
        val backend = FakeBackend().apply { readStatistics = { statistics(System.currentTimeMillis()) } }
        assertFalse(waitForHandshake(controller(backend)) { false })
        assertEquals(0, backend.sampleCount)
    }

    @Test fun cancellationAfterBackendLoadingNeverActivatesATunnel() {
        val backend = FakeBackend().apply { onStart = { fail("cancelled activation") } }
        val controller = controller(backend)
        val activate = WireGuardController::class.java.getDeclaredMethod(
            "activateBackend", managedTunnelClass, Config::class.java, kotlin.jvm.functions.Function0::class.java,
        ).apply { isAccessible = true }
        val error = assertThrows(InvocationTargetException::class.java) {
            activate.invoke(controller, tunnel, allocate(Config::class.java), { false })
        }
        assertEquals("session_operation_cancelled", (error.cause as VpnNativeException).code)
    }
}
