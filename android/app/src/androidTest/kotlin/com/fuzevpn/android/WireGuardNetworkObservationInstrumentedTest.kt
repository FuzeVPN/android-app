package com.fuzevpn.android

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import java.util.concurrent.atomic.AtomicLong
import org.junit.Assert.*
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith

/** Real Android network changes exercise the process-retained bridge without
 * Flutter, API requests, keys, or a real VPN. Only an isolated test package may
 * inject a synthetic established tunnel; installed FuzeVPN data is untouched. */
@RunWith(AndroidJUnit4::class)
class WireGuardNetworkObservationInstrumentedTest {
    private val instrumentation = InstrumentationRegistry.getInstrumentation()
    private fun shell(command: String): String = instrumentation.uiAutomation
        .executeShellCommand(command).use { descriptor ->
            android.os.ParcelFileDescriptor.AutoCloseInputStream(descriptor).bufferedReader().readText().trim()
        }
    private fun field(bridge: AndroidVpnBridge, name: String): Any? =
        AndroidVpnBridge::class.java.getDeclaredField(name).apply { isAccessible = true }.get(bridge)
    private fun set(bridge: AndroidVpnBridge, name: String, value: Any?) =
        AndroidVpnBridge::class.java.getDeclaredField(name).apply { isAccessible = true }.set(bridge, value)
    private fun invoke(bridge: AndroidVpnBridge, name: String) =
        AndroidVpnBridge::class.java.getDeclaredMethod(name).apply { isAccessible = true }.invoke(bridge)
    private fun await(label: String, timeout: Long = 15_000, predicate: () -> Boolean) {
        val deadline = android.os.SystemClock.elapsedRealtime() + timeout
        while (android.os.SystemClock.elapsedRealtime() < deadline) {
            if (predicate()) return
            Thread.sleep(100)
        }
        fail(label)
    }
    @Suppress("DEPRECATION")
    @Test fun physicalOutageIsObservedWithoutFlutterOrAnActiveCommand() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        assumeTrue("Requires the isolated recovery test APK", context.packageName == "com.fuzevpn.recoverytest")
        val connectivity = context.getSystemService(ConnectivityManager::class.java)
        fun hasPhysical() = connectivity.allNetworks.any { network ->
            connectivity.getNetworkCapabilities(network)?.let {
                it.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) &&
                    it.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) &&
                    it.hasCapability(NetworkCapabilities.NET_CAPABILITY_TRUSTED) &&
                    it.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED)
            } == true
        }
        val wifi = shell("settings get global wifi_on")
        val data = shell("settings get global mobile_data")
        val bridge = AndroidVpnBridge.obtain(context)
        try {
            shell("svc wifi enable"); shell("svc data enable")
            await("No initial physical network", 30_000) { hasPhysical() }
            @Suppress("UNCHECKED_CAST")
            val tracker = field(bridge, "physicalNetworks") as PhysicalNetworkTracker<Network>
            val parcel = android.os.Parcel.obtain()
            val phantom = try {
                parcel.writeInt(999_999)
                parcel.setDataPosition(0)
                Network.CREATOR.createFromParcel(parcel)
            } finally { parcel.recycle() }
            tracker.update(phantom, true) // entry with no possible matching callback
            val instance = field(bridge, "tunnelInstanceEpoch") as AtomicLong
            instance.set(100)
            set(bridge, "wireGuardRecoveryInstance", 100L)
            set(bridge, "activeSessionEpoch", (field(bridge, "sessionLifecycle") as SessionLifecycle).ticket())
            set(bridge, "activeProtocol", VpnProtocol.WIREGUARD)
            set(bridge, "currentState", VpnState(status = VpnStatus.CONNECTED, protocol = VpnProtocol.WIREGUARD))
            (field(bridge, "wireGuardRecovery") as WireGuardRecoveryPolicy).start(100, tracker.snapshot())
            invoke(bridge, "startWireGuardRecoveryObserverLocked")
            // A preparation command changes this counter without ending the
            // established tunnel. Its connectivity observer must keep running.
            (field(bridge, "tunnelRequestEpoch") as AtomicLong).incrementAndGet()
            Thread.sleep(1_500)
            assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
            shell("svc wifi disable"); shell("svc data disable")
            await("Physical networks still present") { !hasPhysical() }
            await("Bridge stayed connected without a network") {
                bridge.quickTileState().messageCode == "wireguard_waiting_network"
            }
            Thread.sleep(31_000)
            assertEquals(VpnStatus.CONNECTING, bridge.quickTileState().status)
            assertEquals("wireguard_waiting_network", bridge.quickTileState().messageCode)
            shell("svc wifi enable"); shell("svc data enable")
            await("Physical network did not return", 30_000) { hasPhysical() }
            await("Bridge did not start verification") {
                bridge.quickTileState().messageCode == "wireguard_recovering"
            }
            Thread.sleep(2_000)
            assertEquals("Network availability alone is not peer proof", "wireguard_recovering",
                bridge.quickTileState().messageCode)
        } finally {
            invoke(bridge, "stopWireGuardRecoveryLocked")
            set(bridge, "activeProtocol", null)
            set(bridge, "currentState", VpnState())
            shell("svc wifi ${if (wifi == "1") "enable" else "disable"}")
            shell("svc data ${if (data == "1") "enable" else "disable"}")
        }
    }
}
