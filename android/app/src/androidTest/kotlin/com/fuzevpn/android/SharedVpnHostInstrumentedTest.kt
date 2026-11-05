package com.fuzevpn.android

import android.content.ComponentName
import android.content.Context
import android.content.pm.PackageManager
import android.net.VpnService
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertSame
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Covers the common VPN host only. It never asks VpnService to establish a TUN,
 * and never creates a key, profile, account session, or Flutter activity.
 */
@RunWith(AndroidJUnit4::class)
class SharedVpnHostInstrumentedTest {
    private val context = ApplicationProvider.getApplicationContext<Context>()
    private var testStartedHost = false

    @After
    fun stopTestHost() {
        if (BuildConfig.USE_PATCHED_WIREGUARD_AAR && testStartedHost) {
            // On the main thread, like SharedVpnHost (Android 8 to 11 kill a host stopped before
            // its startForeground(), campaign vm31n).
            InstrumentationRegistry.getInstrumentation().runOnMainSync {
                runCatching { Class.forName(BACKEND).getMethod("stopHost").invoke(null) }
            }
            waitForHost(expectedPresent = false)
        }
    }

    @Test
    fun manifestDeclaresExactlyOneSharedSystemVpnHost() {
        val packageInfo = context.packageManager.getPackageInfo(context.packageName, PackageManager.GET_SERVICES)
        val vpnServices = packageInfo.services.orEmpty().filter {
            it.permission == "android.permission.BIND_VPN_SERVICE"
        }
        assertEquals("one manifest VPN host service", 1, vpnServices.size)
        assertEquals(HOST_SERVICE, vpnServices.single().name)

        val info = context.packageManager.getServiceInfo(
            ComponentName(context.packageName, HOST_SERVICE),
            PackageManager.GET_META_DATA,
        )
        assertFalse(info.exported)
        assertEquals("android.permission.BIND_VPN_SERVICE", info.permission)
        assertEquals(
            BuildConfig.USE_PATCHED_WIREGUARD_AAR,
            info.metaData?.getBoolean("android.net.VpnService.SUPPORTS_ALWAYS_ON") ?: false,
        )
    }

    @Test
    fun quickTileCanReceiveRuntimeRequestedStateUpdates() {
        val info = context.packageManager.getServiceInfo(
            ComponentName(context, VpnQuickTileService::class.java),
            PackageManager.GET_META_DATA,
        )
        assertTrue(info.metaData?.getBoolean("android.service.quicksettings.ACTIVE_TILE") == true)
        assertTrue(info.exported)
        assertEquals("android.permission.BIND_QUICK_SETTINGS_TILE", info.permission)
    }

    @Test
    fun patchedHostStartsWithoutFlutterAndExposesTheSameVpnService() {
        // The official debug fallback deliberately lacks this API. Release and
        // explicitly patched debug instrumented runs execute the host contract.
        assumeTrue(BuildConfig.USE_PATCHED_WIREGUARD_AAR)
        SharedVpnHost.initialize(context)

        val backend = Class.forName(BACKEND)
        if (hostNow() == null) {
            assertTrue(backend.getMethod("startHost", Context::class.java).invoke(null, context) as Boolean)
            testStartedHost = true
        }
        val host = waitForHost(expectedPresent = true)
        assertNotNull(host)
        assertSame(host, backend.getMethod("getActiveHost").invoke(null))
        assertSame(host, SharedVpnHost.current())

        // API access only: do not call establish(), and therefore create no TUN.
        assertNotNull(host!!.javaClass.getMethod("getBuilder").invoke(host) as VpnService.Builder)
    }

    // The host publishes itself in onCreate() just before startForeground(). Stopped in between,
    // Android 8 to 11 kill the process (campaign vm31n): SharedVpnHost stops it on the main thread.
    // A stop from a worker thread the moment the host appears must never kill the process.
    @Test
    fun aHostStoppedAsSoonAsItAppearsNeverKillsTheProcess() {
        assumeTrue(BuildConfig.USE_PATCHED_WIREGUARD_AAR)
        // Below Android 10 the permanent-VPN policy is unreadable, so the host is never stopped.
        assumeTrue(android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q)
        assumeTrue("needs a host this test starts", hostNow() == null)
        SharedVpnHost.initialize(context)
        repeat(20) {
            SharedVpnHost.start(context)
            testStartedHost = true
            val deadline = android.os.SystemClock.elapsedRealtime() + HOST_WAIT_MS
            while (hostNow() == null && android.os.SystemClock.elapsedRealtime() < deadline) Thread.yield()
            assertNotNull("host never appeared", hostNow())
            SharedVpnHost.stopIfNotPermanent()
            waitForHost(expectedPresent = false)
        }
    }

    private fun waitForHost(expectedPresent: Boolean): VpnService? {
        val deadline = android.os.SystemClock.elapsedRealtime() + HOST_WAIT_MS
        var host: VpnService?
        do {
            host = hostNow()
            if ((host != null) == expectedPresent) return host
            Thread.sleep(POLL_MS)
        } while (android.os.SystemClock.elapsedRealtime() < deadline)
        assertEquals("shared host presence", expectedPresent, host != null)
        return host
    }

    private fun hostNow(): VpnService? = runCatching {
        Class.forName(BACKEND).getMethod("getActiveHost").invoke(null) as? VpnService
    }.getOrNull()

    private companion object {
        const val BACKEND = "com.wireguard.android.backend.GoBackend"
        const val HOST_SERVICE = "com.wireguard.android.backend.GoBackend\$VpnService"
        const val HOST_WAIT_MS = 2_000L
        const val POLL_MS = 25L
    }
}
