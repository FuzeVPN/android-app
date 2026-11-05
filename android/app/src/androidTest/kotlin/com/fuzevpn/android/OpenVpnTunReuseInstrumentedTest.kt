package com.fuzevpn.android

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.os.SystemClock
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.fuzevpn.android.openvpn.OpenVpnNative
import java.io.File
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * OpenVPN recovery on a real Android (campaigns 74018 and vm31g): a restart with an unchanged
 * plan hands Core a copy of the interface Android still routes, so open TCP connections are not
 * aborted. Establishes a real TUN in the isolated package; no account, server or Core involved.
 * Needs `adb shell appops set <package> ACTIVATE_VPN allow` beforehand.
 */
@RunWith(AndroidJUnit4::class)
class OpenVpnTunReuseInstrumentedTest {
    private val context = ApplicationProvider.getApplicationContext<Context>()
    private val opened = mutableListOf<Int>()
    private val spec = TunnelNetworkSpec.from(mapOf(
        "address" to "10.111.0.2/32",
        "addresses" to listOf("10.111.0.2/32", "fd11:2233:4455::2/128"),
        "ip_families" to listOf("ipv4", "ipv6"),
        "allowed_ips" to listOf("0.0.0.0/0", "::/0"),
    ))

    @Before
    fun requireHost() {
        assumeTrue(BuildConfig.USE_PATCHED_WIREGUARD_AAR)
        assumeTrue("grant ACTIVATE_VPN with appops first", VpnService.prepare(context) == null)
        SharedVpnHost.initialize(context)
    }

    @After
    fun cleanUp() {
        shell("svc wifi enable")
        opened.forEach { runCatching { ParcelFileDescriptor.adoptFd(it).close() } }
        OpenVpnService.stop(context)
        // On the main thread, like SharedVpnHost: stopped between its onCreate() publication and
        // startForeground(), the host makes Android 8 to 11 kill the process (campaign vm31n).
        InstrumentationRegistry.getInstrumentation().runOnMainSync {
            runCatching { Class.forName(BACKEND).getMethod("stopHost").invoke(null) }
        }
        val end = SystemClock.elapsedRealtime() + 5_000
        while (SharedVpnHost.current() != null && SystemClock.elapsedRealtime() < end) Thread.sleep(20)
        // The next test's interface must not meet this one's teardown in netd.
        while (routedVpnInterfaces().isNotEmpty() && SystemClock.elapsedRealtime() < end + 5_000) Thread.sleep(50)
    }

    @Test
    fun aRecoveryWithTheSamePlanKeepsTheInterface() {
        val first = establish(reconnecting = false)
        val name = interfaceOf(first)
        awaitRouted(name)
        close(first) // Core stops: its descriptor closes, the retained copy keeps the interface.
        val second = establish(reconnecting = true)
        assertEquals("routed VPN interfaces: ${routedVpnInterfaces()}", name, interfaceOf(second))
    }

    // The real recovery runs about 2 s after the physical network was lost, while Android
    // switches its default network (Wi-Fi to mobile, then back).
    @Test
    fun aRecoveryAcrossWifiChangesKeepsTheInterface() {
        val first = establish(reconnecting = false)
        val name = interfaceOf(first)
        awaitRouted(name)
        close(first)
        shell("svc data enable")
        shell("svc wifi disable")
        Thread.sleep(2_000)
        val second = establish(reconnecting = true)
        assertEquals("after Wi-Fi loss; routed: ${routedVpnInterfaces()}", name, interfaceOf(second))
        close(second)
        shell("svc wifi enable")
        Thread.sleep(2_000)
        val third = establish(reconnecting = true)
        assertEquals("after Wi-Fi return; routed: ${routedVpnInterfaces()}", name, interfaceOf(third))
    }

    // Release builds read the name with the ioctl: their own fdinfo can be unreadable (Android
    // 11, campaign vm31h). This debug process can read both, so they must agree.
    @Test
    fun theNativeLookupNamesTheInterfaceFdinfoShows() {
        val first = establish(reconnecting = false)
        assertEquals(interfaceOf(first), OpenVpnNative.tunInterfaceName(first))
        assertNull("no descriptor, no interface", OpenVpnNative.tunInterfaceName(-1))
    }

    @Test
    fun anExplicitStartEstablishesANewInterface() {
        val first = establish(reconnecting = false)
        val name = interfaceOf(first)
        awaitRouted(name)
        val second = establish(reconnecting = false)
        assertNotEquals(name, interfaceOf(second))
    }

    @Test
    fun aChangedPlanEstablishesANewInterface() {
        val first = establish(reconnecting = false)
        val name = interfaceOf(first)
        awaitRouted(name)
        val second = establish(reconnecting = true, dns = "10.111.0.9")
        assertNotEquals(name, interfaceOf(second))
    }

    @Test
    fun aReleasedRetainedTunIsNeverReused() {
        val first = establish(reconnecting = false)
        val name = interfaceOf(first)
        awaitRouted(name)
        OpenVpnService.releaseRetainedTun() // What a revocation does before anything else.
        val second = establish(reconnecting = true)
        assertNotEquals(name, interfaceOf(second))
    }

    private fun establish(reconnecting: Boolean, dns: String = "10.111.0.1"): Int {
        OpenVpnService.start(context, reconnecting)
        assertTrue("VPN host never started", OpenVpnService.awaitReady(5_000))
        val plan = """{"addresses":["10.111.0.2/24","fd11:2233:4455::2/64"],"routes":["0.0.0.0/0","::/0"],""" +
            """"dns":["$dns"],"mtu":1400}"""
        val fd = OpenVpnService.establishForCore(plan, spec)
        assertTrue("establish returned $fd", fd >= 0)
        opened += fd
        return fd
    }

    private fun shell(command: String) {
        InstrumentationRegistry.getInstrumentation().uiAutomation.executeShellCommand(command).close()
    }

    private fun close(fd: Int) {
        opened.remove(fd)
        ParcelFileDescriptor.adoptFd(fd).close()
    }

    private fun interfaceOf(fd: Int): String {
        val fdinfo = File("/proc/self/fdinfo/$fd").readText()
        return assertNotNullValue("no iff line in /proc/self/fdinfo/$fd: $fdinfo", tunInterfaceFromFdinfo(fdinfo))
    }

    private fun awaitRouted(name: String) {
        val end = SystemClock.elapsedRealtime() + 5_000
        while (name !in routedVpnInterfaces() && SystemClock.elapsedRealtime() < end) Thread.sleep(50)
        assertTrue("$name not routed as a VPN; listed: ${routedVpnInterfaces()}", name in routedVpnInterfaces())
    }

    // The same reading as OpenVpnService.routedVpnInterfaces, which is private. `am instrument`
    // right after a VPN teardown can hit the Android 11 bind race (campaign vm31i): this process's
    // ConnectivityManager then refuses capabilities, and the legacy type answers as in isVpnNetwork.
    @Suppress("DEPRECATION")
    private fun routedVpnInterfaces(): Set<String> {
        val connectivity = context.getSystemService(ConnectivityManager::class.java)
        return connectivity.allNetworks.mapNotNullTo(mutableSetOf()) { network ->
            val vpn = try {
                connectivity.getNetworkCapabilities(network)?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true
            } catch (_: SecurityException) {
                connectivity.getNetworkInfo(network)?.type == ConnectivityManager.TYPE_VPN
            }
            if (vpn) connectivity.getLinkProperties(network)?.interfaceName else null
        }
    }

    private fun <T : Any> assertNotNullValue(message: String, value: T?): T {
        assertNotNull(message, value)
        return value!!
    }

    private companion object {
        const val BACKEND = "com.wireguard.android.backend.GoBackend"
    }
}
