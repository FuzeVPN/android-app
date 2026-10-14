package com.fuzevpn.android

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.fuzevpn.android.openvpn.OpenVpnController
import com.wireguard.android.backend.Backend
import com.wireguard.android.backend.Statistics
import com.wireguard.android.backend.Tunnel
import com.wireguard.config.Config
import com.wireguard.crypto.KeyPair
import java.io.File
import java.util.UUID
import java.util.concurrent.atomic.AtomicInteger
import org.junit.Assert.*
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith

/** No account/API or real tunnel. ARM fixtures exercise the app's startup
 * independently of the translator's ability to execute the WireGuard engine. */
@RunWith(AndroidJUnit4::class)
class WireGuardDeferredLoadingInstrumentedTest {
    private fun context(): Context = ApplicationProvider.getApplicationContext<Context>().also {
        assumeTrue("Requires isolated APK", it.packageName == "com.fuzevpn.recoverytest")
    }

    @Test fun idleAndIdentityOperationsDoNotConstructTheNativeBackend() {
        val context = context()
        val calls = AtomicInteger()
        val account = "loading-test-${UUID.randomUUID()}"
        val controller = WireGuardController(context, SecureKeystoreStore(context), {}, {
            calls.incrementAndGet()
            throw AssertionError("Idle path loaded the native backend")
        })
        try {
            assertFalse(controller.isConnected())
            assertEquals(TunnelStatistics(), controller.statistics())
            assertTrue(controller.disconnect())
            val publicKey = controller.getOrCreatePublicKey(account)
            assertEquals(publicKey, controller.getOrCreatePublicKey(account))
            assertTrue(controller.existingIdentityFingerprint(account).isNotBlank())
            assertEquals(0, calls.get())
        } finally {
            controller.clearAccountIdentity(account)
            controller.close()
        }
    }

    private fun refusedStart(cancelDuringInitialization: Boolean) {
        val context = context()
        val calls = AtomicInteger()
        val threads = mutableListOf<String>()
        var current = true
        var upCalls = 0
        val account = "loading-test-${UUID.randomUUID()}"
        val backend = object : Backend {
            override fun getRunningTunnelNames() = emptySet<String>()
            override fun getState(tunnel: Tunnel) = Tunnel.State.DOWN
            override fun getStatistics(tunnel: Tunnel): Statistics =
                throw AssertionError("Refused fixture has no active peer statistics")
            override fun getVersion() = "fixture"
            override fun isAlwaysOn() = false
            override fun isLockdownEnabled() = false
            override fun setState(tunnel: Tunnel, state: Tunnel.State, config: Config?): Tunnel.State {
                if (state == Tunnel.State.UP) {
                    upCalls++
                    throw IllegalStateException("fixture_start_refused")
                }
                return Tunnel.State.DOWN
            }
        }
        val controller = WireGuardController(context, SecureKeystoreStore(context), {}, {
            calls.incrementAndGet()
            threads.add(Thread.currentThread().name)
            if (cancelDuringInitialization) current = false
            backend
        })
        val request = WireGuardRequest(account, "fixture-device", "fixture-location", "Fixture",
            "192.0.2.1/32", listOf("192.0.2.53"), KeyPair().publicKey.toBase64(),
            "192.0.2.2:51820", listOf("0.0.0.0/0"))
        try {
            repeat(2) {
                try { controller.connect(request, isCurrent = { current }); fail("Fixture should refuse UP") }
                catch (error: IllegalStateException) { assertEquals("fixture_start_refused", error.message) }
                catch (error: VpnNativeException) {
                    assertTrue(cancelDuringInitialization)
                    assertEquals("session_operation_cancelled", error.code)
                }
                assertTrue(controller.disconnect())
            }
            assertEquals(1, calls.get())
            assertEquals(listOf("fuzevpn-wireguard"), threads)
            assertEquals(if (cancelDuringInitialization) 0 else 2, upCalls)
        } finally {
            controller.clearAccountIdentity(account)
            controller.close()
        }
    }

    @Test fun nativeBackendIsCreatedOnceOnTheWorkerWhenStartingWireGuard() = refusedStart(false)

    @Test fun cancellationDuringLoadingDoesNotStartATunnel() = refusedStart(true)

    @Test fun realBridgeAndOpenVpnCoreInitializeWithoutLoadingWireGuard() {
        val context = context()
        val bridge = AndroidVpnBridge.obtain(context)
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        assertTrue(OpenVpnController(context).isCoreAvailable())
        assertFalse("Startup/OpenVPN loaded WireGuard", File("/proc/self/maps").readText().contains("libwg-go.so"))
    }
}
