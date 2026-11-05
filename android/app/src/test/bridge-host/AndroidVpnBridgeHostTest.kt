package com.fuzevpn.android

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.CellularNetwork
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkInfo
import android.net.SystemPackageConnectivityManager
import android.net.VpnService
import android.os.UserManager
import android.service.quicksettings.TileService
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.Collections
import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.CountDownLatch
import java.util.concurrent.ExecutionException
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.android.HarnessMain
import kotlinx.coroutines.cancel
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test

internal class HostContext : Context()

internal class ResultProbe : MethodChannel.Result {
    private val done = CountDownLatch(1)
    @Volatile var value: Any? = null
    @Volatile var error: String? = null
    override fun success(value: Any?) { this.value = value; done.countDown() }
    override fun error(code: String, message: String?, details: Any?) { error = code; done.countDown() }
    override fun notImplemented() { error = "not_implemented"; done.countDown() }
    fun await(): ResultProbe { check(done.await(20, TimeUnit.SECONDS)) { "method result never delivered" }; return this }
    val pending: Boolean get() = done.count > 0
}

/** Read by the test thread while the main thread delivers: iterations take a snapshot. */
internal class EventProbe : EventChannel.EventSink {
    val events: MutableList<String> = CopyOnWriteArrayList()
    val terminations: MutableList<Map<*, *>> = CopyOnWriteArrayList()
    override fun success(event: Any?) {
        val map = event as Map<*, *>
        events += "${map["status"]}/${map["protocol"]}/${map["message_code"]}"
        (map["session_termination"] as? Map<*, *>)?.let { terminations += it }
    }
    override fun error(code: String, message: String?, details: Any?) {}
    override fun endOfStream() {}
}

/**
 * Compiles the real AndroidVpnBridge, VpnQuickTileService and their policies
 * with Android, Flutter, storage and engine doubles (run.ps1). Each test states
 * the corrected behaviour of one audit finding.
 */
class AndroidVpnBridgeHostTest {
    private val context = HostContext()
    private val activity = object : Activity() {}
    private val sink = EventProbe()
    private lateinit var bridge: AndroidVpnBridge
    private val tileCallbacks: MutableList<String?> = Collections.synchronizedList(mutableListOf())
    private val profile = QuickTileProfile(VpnProtocol.WIREGUARD, ACCOUNT, DEVICE, "location-1", "Paris",
        wireGuardRequest = WireGuardRequest(ACCOUNT, DEVICE, "location-1", "Paris", "10.8.0.2/32",
            listOf("10.8.0.1"), "server-public-key", "203.0.113.10:51820", listOf("0.0.0.0/0")))

    @Before fun setUp() {
        HarnessControl.reset()
        SecureKeystoreStore.clearAll()
        VpnService.reset()
        TileService.reset()
        SharedVpnHost.flags = false to false
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        android.os.Build.VERSION.SDK_INT = 34
        context.services[ConnectivityManager::class.java] = ConnectivityManager()
        ConnectivityManager.reset()
        android.provider.Settings.Secure.reset()
        context.services[UserManager::class.java] = UserManager()
        retained(null)
        bridge = AndroidVpnBridge.obtain(context)
        HarnessMain.run { AndroidVpnBridge.obtain(context, activity, object : BinaryMessenger {}) }
        HarnessMain.run { bridge.onListen(null, sink) }
    }

    @After fun tearDown() {
        for (name in listOf("operationScope", "observerScope")) {
            (AndroidVpnBridge::class.java.getDeclaredField(name).apply { isAccessible = true }.get(bridge) as CoroutineScope).cancel()
        }
        HarnessMain.drain()
        retained(null)
    }

    // C2-R-gles-d-ex-cution-Android-12--01: a tile refresh must never call
    // VpnService.prepare, which revokes another app's non-permanent VPN.
    @Test fun tileSnapshotNeverPreparesTheVpnService() {
        signIn()
        storeTileProfile()
        val ready = bridge.quickTileSnapshot()
        assertEquals("quickTileSnapshot probed VpnService.prepare", 0, VpnService.prepareCalls.get())
        assertTrue(ready.canConnect)
        SecureKeystoreStore.remove(SecureStorageKeyPolicy.quickTileProfile())
        assertFalse(bridge.quickTileSnapshot().canConnect)
        storeTileProfile()
        SecureKeystoreStore.remove(SecureStorageKeyPolicy.preference(SecureAppPreference.VPN_DISCLOSURE_VERSION))
        assertFalse(bridge.quickTileSnapshot().canConnect)
        assertEquals(0, VpnService.prepareCalls.get())
    }

    @Test fun activeTileRefreshNeverPreparesTheVpnServiceButAClickStillChecksIt() {
        signIn()
        storeTileProfile()
        val service = VpnQuickTileService()
        HarnessMain.run { service.onStartListening() }
        eventually("tile rendered") { TileService.updates.isNotEmpty() }
        assertEquals(0, VpnService.prepareCalls.get())
        // An explicit connection still verifies Android's consent before any engine.
        VpnService.consentIntent = Intent("android.net.vpn.CONSENT")
        val done = clickTile()
        await(done, "tile callback")
        assertTrue(VpnService.prepareCalls.get() >= 1)
        assertEquals(0, HarnessControl.wireGuardConnects)
        assertEquals(listOf<String?>("vpn_permission_required"), tileCallbacks.toList())
    }

    @Test fun tileShowsSetupWhenAnExplicitCheckFoundNoAndroidConsent() {
        signIn()
        storeTileProfile()
        VpnService.consentIntent = Intent("android.net.vpn.CONSENT")
        val status = call("getVpnDisclosureStatus").await()
        assertEquals(false, (status.value as Map<*, *>)["android_permission"])
        val before = VpnService.prepareCalls.get()
        assertFalse(bridge.quickTileSnapshot().canConnect)
        assertEquals(before, VpnService.prepareCalls.get())
    }

    // C2-R-gles-d-ex-cution-Android-12--02: Android 13 before QPR3 rejects
    // requestListeningState for a process outside the current user.
    @Test fun vpnPermissionRequestSurvivesTileListeningFailure() {
        signIn()
        TileService.listeningFailure = IllegalArgumentException("User 10 is not the current user")
        VpnService.consentIntent = Intent("android.net.vpn.CONSENT")
        val first = call("requestVpnPermission", mapOf("disclosure_accepted" to true))
        eventually("consent activity") { activity.startedActivities.any { it.action == "android.net.vpn.CONSENT" } }
        assertTrue("permission RPC must wait for the consent result", first.pending)
        VpnService.consentIntent = null
        HarnessMain.run { bridge.onActivityResult(9811, Activity.RESULT_OK) }
        assertNull(first.await().error)
        assertEquals(true, first.value)
        val second = call("requestVpnPermission", mapOf("disclosure_accepted" to true)).await()
        assertEquals(true, second.value)
    }

    @Test fun connectionAndStateEventsSurviveTileListeningFailure() {
        signIn()
        TileService.listeningFailure = IllegalArgumentException("User 10 is not the current user")
        val connected = call("connectWireGuard", wireGuardArguments()).await()
        assertNull(connected.error)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        HarnessMain.run { bridge.onRequestPermissionsResult(9812, emptyArray<String>(), intArrayOf(-1)) }
        assertEquals("notifications_denied", bridge.quickTileState().messageCode)
        assertNull(call("setNotificationLocale", mapOf("language_code" to "de")).await().error)
        assertEquals(listOf<String?>("de"), HarnessControl.locales.toList())
    }

    @Test fun accountSignOutCompletesDespiteTileListeningFailure() {
        signIn()
        TileService.listeningFailure = IllegalArgumentException("User 10 is not the current user")
        val ending = try { call("storageClearSession", mapOf("session_expired" to false)) }
            catch (error: ExecutionException) { throw AssertionError("storageClearSession threw on the main thread", error.cause) }
        val termination = ending.await().value as Map<*, *>
        assertEquals(true, termination["tunnel_stopped"])
        assertEquals(true, termination["session_cleared"])
        assertEquals(listOf(true), HarnessControl.purges.toList())
        val retry = call("storageClearSession", mapOf("session_expired" to false)).await()
        assertNotNull(retry.value)
    }

    @Test fun backgroundFailureNeverReachesTheProcessUncaughtHandler() {
        signIn()
        storeTileProfile()
        HarnessControl.wireGuardConnect = { false }
        HarnessControl.errorNotificationFailure = "wireguard_foreground_service_unavailable"
        val uncaught = Collections.synchronizedList(mutableListOf<Throwable>())
        val previous = Thread.getDefaultUncaughtExceptionHandler()
        Thread.setDefaultUncaughtExceptionHandler { _, error -> uncaught += error }
        try {
            await(clickTile(), "tile callback")
            Thread.sleep(300)
            assertTrue("uncaught: $uncaught", uncaught.isEmpty())
        } finally {
            Thread.setDefaultUncaughtExceptionHandler(previous)
        }
    }

    // C3-Contrat-des-canaux-Dart-Kotlin-01: Dart sends {} (or only trace ids)
    // for "system language"; the native preference must follow it.
    @Test fun systemLanguageReachesTheNativeNotificationLocale() {
        assertNull(call("setNotificationLocale", mapOf("language_code" to "de")).await().error)
        assertNull(call("setNotificationLocale", emptyMap<String, Any?>()).await().error)
        assertNull(call("setNotificationLocale", mapOf("diagnostic_trace_id" to "0123456789abcdef0123456789abcdef",
            "diagnostic_span_id" to "0123456789abcdef")).await().error)
        assertNull(call("setNotificationLocale", mapOf("language_code" to null)).await().error)
        assertEquals(listOf("de", null, null, null), HarnessControl.locales.toList())
        assertEquals("invalid_arguments", call("setNotificationLocale", mapOf("language_code" to 42)).await().error)
        assertEquals("invalid_arguments", call("setNotificationLocale", mapOf("language_code" to "xx-unknown")).await().error)
        assertEquals(4, HarnessControl.locales.size)
    }

    // A08-vpn-bridge-03: a user cancellation during the WireGuard handshake is
    // not a handshake timeout.
    @Test fun cancelledWireGuardHandshakeIsNotReportedAsTimeout() {
        signIn()
        HarnessControl.wireGuardConnect = { isCurrent ->
            val deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(10)
            while (isCurrent() && System.nanoTime() < deadline) Thread.sleep(5)
            false
        }
        val connecting = call("connectWireGuard", wireGuardArguments())
        eventually("handshake wait") { HarnessControl.wireGuardConnects == 1 }
        val stop = call("disconnect").await()
        assertNull(stop.error)
        assertEquals("session_operation_cancelled", connecting.await().error)
        HarnessMain.drain()
        assertFalse(sink.events.toString(), sink.events.any { it.endsWith("/wireguard_handshake_timeout") })
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        assertNull(bridge.quickTileState().messageCode)
    }

    @Test fun realWireGuardHandshakeTimeoutIsStillReported() {
        signIn()
        HarnessControl.wireGuardConnect = { false }
        assertEquals("wireguard_handshake_timeout", call("connectWireGuard", wireGuardArguments()).await().error)
        assertEquals(VpnStatus.ERROR, bridge.quickTileState().status)
        assertEquals("wireguard_handshake_timeout", bridge.quickTileState().messageCode)
    }

    // A09-services-01: an active tile is refreshed only when asked; clearing
    // its profile without a state publication must ask for that refresh.
    @Test fun clearingTheTileProfileRefreshesTheActiveTile() {
        signIn()
        storeTileProfile()
        val profilePresentAtRefresh = Collections.synchronizedList(mutableListOf<Boolean>())
        TileService.onListeningRequest = {
            profilePresentAtRefresh += SecureKeystoreStore.raw(SecureStorageKeyPolicy.quickTileProfile()) != null
        }
        assertNull(call("clearAccountIdentity", mapOf("account_id" to ACCOUNT, "expected_device_id" to DEVICE)).await().error)
        assertNull(SecureKeystoreStore.raw(SecureStorageKeyPolicy.quickTileProfile()))
        assertEquals("no tile refresh after the profile was cleared", false, profilePresentAtRefresh.lastOrNull())
    }

    @Test fun clearingTheOpenVpnTileProfileRefreshesTheActiveTile() {
        signIn()
        SecureKeystoreStore.put(SecureStorageKeyPolicy.quickTileProfile(),
            QuickTileProfile(VpnProtocol.OPENVPN, ACCOUNT, DEVICE, "location-2", "Lyon").encode())
        val profilePresentAtRefresh = Collections.synchronizedList(mutableListOf<Boolean>())
        TileService.onListeningRequest = {
            profilePresentAtRefresh += SecureKeystoreStore.raw(SecureStorageKeyPolicy.quickTileProfile()) != null
        }
        assertNull(call("clearOpenVpnIdentity", mapOf("account_id" to ACCOUNT, "device_id" to DEVICE)).await().error)
        assertNull(SecureKeystoreStore.raw(SecureStorageKeyPolicy.quickTileProfile()))
        assertEquals(false, profilePresentAtRefresh.lastOrNull())
    }

    // A11-03: outside a session, "open the app first" must open the app; local
    // refusals open it without publishing a global ERROR state.
    @Test fun signedOutTileClickOpensTheApplication() {
        signIn()
        storeTileProfile()
        assertNotNull(call("storageClearSession", mapOf("session_expired" to false)).await().value)
        val eventsBefore = settledEvents()
        val service = VpnQuickTileService()
        HarnessMain.run { service.onClick() }
        eventually("application opened") { TileService.launches.isNotEmpty() }
        assertEquals(listOf("pending:launch:com.fuzevpn.android"), TileService.launches.toList())
        assertEquals(eventsBefore, settledEvents())
    }

    @Test fun localTileRefusalOpensTheApplicationWithoutAGlobalError() {
        signIn()
        val eventsBefore = settledEvents()
        val notificationsBefore = HarnessControl.notifications.toList()
        val service = VpnQuickTileService()
        HarnessMain.run { service.onClick() }
        eventually("application opened") { TileService.launches.isNotEmpty() }
        assertEquals(listOf("pending:launch:com.fuzevpn.android"), TileService.launches.toList())
        assertEquals(eventsBefore, settledEvents())
        assertEquals(notificationsBefore, HarnessControl.notifications.toList())
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        // QT-REVOKE-OVPN-01 precondition: VpnService.prepare would revoke another app's VPN.
        assertEquals(0, VpnService.prepareCalls.get())
    }

    @Test fun tileEngineFailureStillPublishesItsError() {
        signIn()
        storeTileProfile()
        HarnessControl.wireGuardConnect = { false }
        await(clickTile(), "tile callback")
        HarnessMain.drain()
        assertEquals(VpnStatus.ERROR, bridge.quickTileState().status)
        assertEquals("wireguard_handshake_timeout", bridge.quickTileState().messageCode)
        assertTrue(HarnessControl.notifications.contains("startProtocol(WIREGUARD,ERROR,reconnecting=false,action=true)"))
    }

    // C2-R-gles-d-ex-cution-Android-12--03: the settings branch must use the
    // tile's own launcher (BAL) and tolerate a missing settings activity.
    @Test fun tileSettingsBranchUsesTheTileLauncher() {
        retainedEngineAfterStopTimeout()
        SharedVpnHost.flags = true to false
        val service = VpnQuickTileService()
        HarnessMain.run { service.onClick() }
        HarnessMain.drain()
        assertEquals(listOf("pending:android.settings.VPN_SETTINGS"), TileService.launches.toList())
        assertTrue(context.startedActivities.none { it.action == "android.settings.VPN_SETTINGS" })
    }

    @Test fun missingVpnSettingsActivityDoesNotCrashTheTile() {
        retainedEngineAfterStopTimeout()
        SharedVpnHost.flags = true to false
        context.missingActivity = "android.settings.VPN_SETTINGS"
        TileService.missingLaunch = "android.settings.VPN_SETTINGS"
        val service = VpnQuickTileService()
        try { HarnessMain.run { service.onClick() } }
        catch (error: ExecutionException) { throw AssertionError("tile click threw", error.cause) }
        HarnessMain.drain()
        assertTrue(TileService.launches.isEmpty())
    }

    // H-E22-N01-01 (with A08-vpn-bridge-01): a refused system resume must not
    // stop, block or overwrite an explicit tile connection queued behind it.
    private fun refusedSystemStartLeavesQueuedTileConnected(refusal: String) {
        signIn()
        storeTileProfile()
        armResume()
        if (refusal == "blocked") registry().block("tunnel_disconnected")
        val tileReads = Gate("tile identity")
        HarnessControl.identityGate = tileReads
        val tile = clickTile()
        tileReads.awaitReached()
        val systemHoldsMutex = Gate("system resume read")
        HarnessControl.resumeReadGate = systemHoldsMutex
        systemStart()
        systemHoldsMutex.awaitReached()
        tileReads.open()
        Thread.sleep(300) // the tile worker is now queued on the transition mutex
        if (refusal == "identity") HarnessControl.identityFailure = "secure_storage_read_failed"
        systemHoldsMutex.open()
        await(tile, "tile callback")
        settleSystemJob()
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(VpnProtocol.WIREGUARD, bridge.quickTileState().protocol)
        assertEquals("the refused system job stopped the explicit tunnel", 0, HarnessControl.wireGuardStops)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()?.status)
        assertEquals(listOf<String?>(null), tileCallbacks.toList())
        val events = settledEvents()
        val connected = events.indexOfLast { it.startsWith("connected/") }
        assertTrue(events.toString(), connected >= 0 && events.drop(connected + 1).none { it.startsWith("error/") || it.startsWith("idle/") })
    }
    @Test fun blockedSystemResumeDoesNotStopTheQueuedTile() = refusedSystemStartLeavesQueuedTileConnected("blocked")
    @Test fun identityFailureOfSystemResumeDoesNotStopTheQueuedTile() = refusedSystemStartLeavesQueuedTileConnected("identity")

    @Test fun refusedSystemStartFinishedFirstStillReportsAndTheTileConnects() {
        signIn()
        storeTileProfile()
        armResume()
        registry().block("tunnel_disconnected")
        val tileReads = Gate("tile identity")
        HarnessControl.identityGate = tileReads
        val tile = clickTile()
        tileReads.awaitReached()
        systemStart()
        settleSystemJob()
        assertEquals(VpnStatus.ERROR, bridge.quickTileState().status)
        tileReads.open()
        await(tile, "tile callback")
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(0, HarnessControl.wireGuardStops)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()?.status)
    }

    // H-E22-N01-02: an older tile click is attempted once the newer admitted
    // system resume has failed and no longer owns the engine.
    @Test fun tileConnectsAfterTheNewerAdmittedSystemResumeFailed() {
        signIn()
        storeTileProfile()
        armResume()
        var attempts = 0
        HarnessControl.wireGuardConnect = { ++attempts > 1 }
        val tileReads = Gate("tile identity")
        HarnessControl.identityGate = tileReads
        val tile = clickTile()
        tileReads.awaitReached()
        systemStart()
        settleSystemJob()
        assertEquals(VpnStatus.ERROR, bridge.quickTileState().status)
        tileReads.open()
        await(tile, "tile callback")
        assertEquals(2, HarnessControl.wireGuardConnects)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(listOf<String?>(null), tileCallbacks.toList())
    }

    @Test fun tileQueuedDuringTheSystemFailureStillConnects() {
        signIn()
        storeTileProfile()
        armResume()
        var attempts = 0
        HarnessControl.wireGuardConnect = { ++attempts > 1 }
        val tileReads = Gate("tile identity")
        HarnessControl.identityGate = tileReads
        val tile = clickTile()
        tileReads.awaitReached()
        val systemEngine = Gate("system engine")
        HarnessControl.wireGuardConnectGate = systemEngine
        systemStart()
        systemEngine.awaitReached()
        tileReads.open()
        Thread.sleep(300) // the tile worker is queued on the mutex held by the failing system start
        systemEngine.open()
        await(tile, "tile callback")
        settleSystemJob()
        assertEquals(2, HarnessControl.wireGuardConnects)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()?.status)
        assertEquals(listOf<String?>(null), tileCallbacks.toList())
    }

    @Test fun newerSuccessfulSystemResumeStillWinsOverAnOlderFailingTile() {
        signIn()
        storeTileProfile()
        armResume()
        val tileReads = Gate("tile identity")
        HarnessControl.identityGate = tileReads
        val tile = clickTile()
        tileReads.awaitReached()
        systemStart()
        settleSystemJob()
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        HarnessControl.identityFailure = "secure_storage_read_failed"
        tileReads.open()
        await(tile, "tile callback")
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(1, HarnessControl.wireGuardConnects)
        assertEquals(listOf<String?>(null), tileCallbacks.toList())
    }

    // A08-vpn-bridge-02: a command that cancels an admitted system resume
    // without publishing must not leave CONNECTING/system_vpn_restoring.
    @Test fun cancelledRestoreDuringNetworkWaitIsNotLeftConnecting() {
        signIn()
        storeTileProfile()
        armResume()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        systemStart()
        eventually("restoring published") { bridge.quickTileState().messageCode == "system_vpn_restoring" }
        assertNull(call("prepareTunnelRequest", mapOf("account_id" to ACCOUNT)).await().error)
        settleSystemJob()
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        Thread.sleep(400)
        val state = bridge.quickTileState()
        assertFalse("orphan restoring state: $state", state.status == VpnStatus.CONNECTING)
        assertNull(state.messageCode)
        assertEquals(0, HarnessControl.wireGuardConnects)
    }

    @Test fun cancelledRestoreWaitingForTheMutexIsNotLeftConnecting() {
        signIn()
        storeTileProfile()
        armResume()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        systemStart()
        eventually("restoring published") { bridge.quickTileState().messageCode == "system_vpn_restoring" }
        val keyHoldsMutex = Gate("public key")
        HarnessControl.publicKeyGate = keyHoldsMutex
        val key = call("getOrCreateWireGuardPublicKey", mapOf("account_id" to ACCOUNT))
        keyHoldsMutex.awaitReached()
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        Thread.sleep(700) // the restoring connection leaves its network wait and queues on the mutex
        val prepare = call("prepareTunnelRequest", mapOf("account_id" to ACCOUNT))
        keyHoldsMutex.open()
        assertNull(key.await().error)
        assertNull(prepare.await().error)
        settleSystemJob()
        Thread.sleep(200)
        val state = bridge.quickTileState()
        assertFalse("orphan restoring state: $state", state.status == VpnStatus.CONNECTING)
        assertEquals(0, HarnessControl.wireGuardConnects)
    }

    // C4-03 (Helper1 request): Dart must know whether the stored session is a
    // signed-in account or a pending registered admission; a strict read never erases.
    @Test fun storedSessionBindingNamesItsSlotWithoutErasingIt() {
        assertNull(call("storageReadSessionBinding").await().error)
        assertNull(call("storageReadSessionBinding").await().value)
        SecureKeystoreStore.put(SecureStorageKeyPolicy.pendingSession(), SESSION)
        assertEquals("pending", call("storageReadSessionBinding").await().value)
        signIn()
        assertEquals("account", call("storageReadSessionBinding").await().value)
        HarnessControl.readFailure = "secure_storage_read_failed"
        assertEquals("secure_storage_read_failed", call("storageReadSessionBinding").await().error)
        HarnessControl.readFailure = null
        assertEquals(ACCOUNT, SecureKeystoreStore.raw(SecureStorageKeyPolicy.activeUser()))
        assertEquals(SESSION, SecureKeystoreStore.raw(SecureStorageKeyPolicy.pendingSession()))
        assertEquals("account", call("storageReadSessionBinding").await().value)
    }

    // A05-models-01 / C5-05 (R1 request): the bridge refuses, before any engine,
    // the labels the Dart catalogue drops, and the tile profile keeps an
    // accepted one unchanged (vectors of NativeInputContractTest).
    @Test fun bridgeLabelBoundsMatchTheDartCatalogue() {
        signIn()
        for ((name, label) in REFUSED_LABELS) {
            assertEquals(name, "invalid_arguments", call("connectWireGuard", wireGuardArguments(label)).await().error)
            assertEquals(name, "invalid_arguments", call("connectOpenVpn", mapOf("account_id" to ACCOUNT,
                "device_id" to DEVICE, "location_id" to "location-2", "location_name" to label)).await().error)
        }
        assertEquals(0, HarnessControl.wireGuardConnects)
        for ((name, label) in ACCEPTED_LABELS) {
            assertNull(name, call("connectWireGuard", wireGuardArguments(label)).await().error)
            val stored = SecureKeystoreStore.raw(SecureStorageKeyPolicy.quickTileProfile())
            assertEquals(name, label, stored?.let(QuickTileProfile::decode)?.locationName)
            assertNull(name, call("disconnect").await().error)
        }
    }

    // P1 of the lot S review (root decision, option 2): storageClearSession takes
    // an explicit cause. Only "expired" is published as an expiry; only
    // "voluntary" revokes automatic guest recovery.
    @Test fun clearSessionReasonDecidesRecoveryAndExpiry() {
        for ((reason, revoke, expired) in listOf(Triple("voluntary", true, false),
            Triple("expired", false, true), Triple("abandoned", false, false))) {
            for (legacy in listOf(false, true)) {
                val case = "$reason legacy=$legacy"
                signIn()
                HarnessControl.purges.clear()
                sink.terminations.clear()
                val arguments = if (legacy) mapOf("reason" to reason, "session_expired" to (reason != "voluntary"))
                    else mapOf("reason" to reason)
                val result = call("storageClearSession", arguments).await().value as Map<*, *>
                HarnessMain.drain()
                assertEquals(case, listOf(revoke), HarnessControl.purges.toList())
                assertEquals(case, expired, result["session_expired"])
                assertTrue(case, sink.terminations.isNotEmpty())
                assertTrue("$case ${sink.terminations}", sink.terminations.all { it["session_expired"] == expired })
            }
        }
    }

    @Test fun clearSessionRequestsJoiningOneEndMergeTheirCauses() {
        for ((reasons, revoke, expired) in listOf(
            Triple(listOf("voluntary", "expired"), true, true),
            Triple(listOf("expired", "voluntary"), true, true),
            Triple(listOf("abandoned", "voluntary"), true, false),
            Triple(listOf("expired", "abandoned"), false, true),
            Triple(listOf("abandoned", "expired", "voluntary"), true, true),
        )) {
            val case = reasons.joinToString("+")
            signIn()
            // A new session admits tunnel commands again after the previous end.
            assertNull(case, call("storageWriteAccountSession", mapOf("account_id" to ACCOUNT, "payload" to SESSION)).await().error)
            HarnessControl.purges.clear()
            // A connection holds the tunnel mutex: every request joins the same end.
            val gate = Gate("connect").also { HarnessControl.wireGuardConnectGate = it }
            val connecting = call("connectWireGuard", wireGuardArguments())
            gate.awaitReached()
            val ends = reasons.map { call("storageClearSession", mapOf("reason" to it)) }
            gate.open()
            connecting.await()
            val results = ends.map { it.await().value as Map<*, *> }
            assertEquals(case, listOf(revoke), HarnessControl.purges.toList())
            assertTrue("$case $results", results.all { it["session_expired"] == expired })
        }
    }

    @Test fun voluntaryJoiningAnAbandonedEndAfterItsEraseStillRevokes() {
        signIn()
        val purge = Gate("purge").also { HarnessControl.purgeGate = it }
        val abandoned = call("storageClearSession", mapOf("reason" to "abandoned"))
        purge.awaitReached()
        val voluntary = call("storageClearSession", mapOf("reason" to "voluntary"))
        purge.open()
        val first = abandoned.await().value as Map<*, *>
        val second = voluntary.await().value as Map<*, *>
        assertEquals(listOf(false, true), HarnessControl.purges.toList())
        assertEquals(true, first["session_cleared"])
        assertEquals(false, first["session_expired"])
        assertEquals(false, second["session_expired"])
    }

    @Test fun clearSessionWithoutReasonKeepsTheLegacyFlag() {
        for ((arguments, revoke, expired) in listOf(Triple(mapOf("session_expired" to true), false, true),
            Triple(mapOf("session_expired" to false), true, false), Triple(emptyMap<String, Any?>(), true, false))) {
            signIn()
            HarnessControl.purges.clear()
            val result = call("storageClearSession", arguments).await().value as Map<*, *>
            assertEquals("$arguments", listOf(revoke), HarnessControl.purges.toList())
            assertEquals("$arguments", expired, result["session_expired"])
        }
    }

    @Test fun unknownClearSessionReasonIsRefusedBeforeAnyEnd() {
        signIn()
        for (reason in listOf<Any>("logout", 42, "")) {
            assertEquals("$reason", "invalid_arguments",
                call("storageClearSession", mapOf("reason" to reason)).await().error)
        }
        assertTrue(HarnessControl.purges.isEmpty())
        assertEquals(SESSION, SecureKeystoreStore.raw(SecureStorageKeyPolicy.accountSession(ACCOUNT)))
    }

    // P6 of the lot S review (root decision): a Keystore key that is gone leaves
    // the stored session permanently undecryptable. Session reads report it as
    // corrupt, as for the Google slot (C5-03); an unavailable Keystore stays transient.
    @Test fun sessionReadsReportAMissingKeystoreKeyAsCorrupt() {
        signIn()
        HarnessControl.readKeyMissing = true
        for ((method, arguments) in listOf("storageReadSession" to null, "storageReadSessionBinding" to null,
            "storageReadCurrentDevice" to mapOf("account_id" to ACCOUNT))) {
            assertEquals(method, "secure_storage_corrupt", call(method, arguments).await().error)
        }
        HarnessControl.readKeyMissing = false
        HarnessControl.readFailure = "secure_storage_read_failed"
        assertEquals("secure_storage_read_failed", call("storageReadSession").await().error)
        HarnessControl.readFailure = null
        assertEquals(SESSION, call("storageReadSession").await().value)
        assertEquals(SESSION, SecureKeystoreStore.raw(SecureStorageKeyPolicy.accountSession(ACCOUNT)))
    }

    // Final reaudit A2/B11 (A08-vpn-bridge-02 variant): a command that publishes
    // nothing cancels the restore inside connectWireGuard, after its PREPARING and
    // CONNECTING, where the real engine throws session_operation_cancelled.
    @Test fun restoreCancelledBeforeItsHandshakeWaitEndsIdle() {
        signIn()
        storeTileProfile()
        armResume()
        val backend = Gate("backend").also { HarnessControl.wireGuardConnectGate = it }
        HarnessControl.wireGuardConnect = { isCurrent ->
            if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
            true
        }
        systemStart()
        backend.awaitReached()
        val prepare = call("prepareTunnelRequest", mapOf("account_id" to ACCOUNT))
        backend.open()
        assertNull(prepare.await().error)
        settleSystemJob()
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        assertTrue(settledEvents().toString(), settledEvents().last().startsWith("idle/"))
    }

    // Same finding: cancelled while connectWireGuard still checks the restore's
    // identity, before PREPARING, by clearOpenVpnIdentity (no OpenVPN engine).
    @Test fun restoreCancelledInsideConnectBeforePreparingEndsIdle() {
        signIn()
        storeTileProfile()
        armResume()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        systemStart()
        eventually("restoring published") { bridge.quickTileState().messageCode == "system_vpn_restoring" }
        val identity = Gate("restore identity").also { HarnessControl.identityGate = it }
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        identity.awaitReached()
        val clear = call("clearOpenVpnIdentity", mapOf("account_id" to ACCOUNT, "device_id" to DEVICE))
        identity.open()
        assertNull(clear.await().error)
        settleSystemJob()
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        assertEquals(0, HarnessControl.wireGuardConnects)
    }

    // Same window, but a host loss publishes its ERROR first: it is kept, not replaced by IDLE.
    @Test fun hostLossInsideACancelledRestoreKeepsItsError() {
        signIn()
        storeTileProfile()
        armResume()
        val backend = Gate("backend").also { HarnessControl.wireGuardConnectGate = it }
        HarnessControl.wireGuardConnect = { isCurrent ->
            if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
            true
        }
        systemStart()
        backend.awaitReached()
        bridge.onVpnHostLost("vpn_permission_revoked", bridge.captureHostLoss().first)
        backend.open()
        settleSystemJob()
        Thread.sleep(300)
        val state = bridge.quickTileState()
        assertEquals(VpnStatus.ERROR, state.status)
        assertEquals("vpn_permission_revoked", state.messageCode)
    }

    // Final reaudit A3/B16 (A11-03 variant): signed out with an engine retained
    // after a stop timeout, the tile reads "Open the app first"; a click opens it
    // without any state change, notification or stop attempt from the tile.
    @Test fun signedOutTileWithRetainedEngineOpensTheApplication() {
        retainedEngineAfterStopTimeout()
        val end = call("storageClearSession", mapOf("reason" to "voluntary")).await().value as Map<*, *>
        assertEquals(false, end["tunnel_stopped"])
        assertEquals(true, end["session_cleared"])
        assertNull(SecureKeystoreStore.raw(SecureStorageKeyPolicy.quickTileProfile()))
        val eventsBefore = settledEvents()
        val notificationsBefore = HarnessControl.notifications.toList()
        val stopsBefore = HarnessControl.wireGuardStops
        val service = VpnQuickTileService()
        HarnessMain.run { service.onClick() }
        eventually("application opened") { TileService.launches.isNotEmpty() }
        assertEquals(listOf("pending:launch:com.fuzevpn.android"), TileService.launches.toList())
        assertEquals(eventsBefore, settledEvents())
        assertEquals(notificationsBefore, HarnessControl.notifications.toList())
        assertEquals(stopsBefore, HarnessControl.wireGuardStops)
    }

    // Final reaudit A4/B20 (H-E22-N01-02 variant B): the admitted restore fails in
    // its own session check, inside its mutex hold, while an older tile click
    // waits behind it. A one-shot Keystore failure is consumed by the restore.
    @Test fun restoreFailingInItsSessionCheckLetsTheQueuedTileConnect() {
        val (tile, key) = queueTileBehindARestoreHeldByAKeyRequest()
        HarnessControl.readFailureOnce = "secure_storage_read_failed"
        releaseKeyRequest()
        assertNull(key.await().error)
        await(tile, "tile callback")
        settleSystemJob()
        assertNull("one-shot failure not consumed", HarnessControl.readFailureOnce)
        assertEquals(1, HarnessControl.wireGuardConnects)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(listOf<String?>(null), tileCallbacks.toList())
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()?.status)
    }

    // Same order, but the tile's own reads fail as well: its failure is reported.
    @Test fun restoreFailingInItsSessionCheckReportsTheQueuedTileFailure() {
        val (tile, key) = queueTileBehindARestoreHeldByAKeyRequest()
        HarnessControl.readFailure = "secure_storage_read_failed"
        releaseKeyRequest()
        key.await()
        await(tile, "tile callback")
        settleSystemJob()
        HarnessControl.readFailure = null
        assertEquals(0, HarnessControl.wireGuardConnects)
        assertEquals(listOf<String?>("secure_storage_read_failed"), tileCallbacks.toList())
    }

    // Final reaudit B15 (A09-services-01 variant): the active tile reads
    // vpnPermissionMissing, so any VpnService.prepare call that changes it refreshes the tile.
    @Test fun vpnPermissionChangeRefreshesTheActiveTile() {
        signIn()
        val before = TileService.listeningRequests.get()
        VpnService.consentIntent = Intent()
        assertEquals(false, (call("getVpnDisclosureStatus").await().value as Map<*, *>)["android_permission"])
        assertEquals(before + 1, TileService.listeningRequests.get())
        call("getVpnDisclosureStatus").await()
        assertEquals("unchanged permission", before + 1, TileService.listeningRequests.get())
        VpnService.consentIntent = null
        assertEquals(true, (call("getVpnDisclosureStatus").await().value as Map<*, *>)["android_permission"])
        assertEquals(before + 2, TileService.listeningRequests.get())
    }

    // Final reaudit B31: a refused clear-session request (unknown reason) cancels nothing.
    @Test fun unknownClearSessionReasonLeavesASystemStartRunning() {
        signIn()
        storeTileProfile()
        armResume()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        systemStart()
        eventually("restoring published") { bridge.quickTileState().messageCode == "system_vpn_restoring" }
        assertEquals("invalid_arguments", call("storageClearSession", mapOf("reason" to "logout")).await().error)
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        settleSystemJob()
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(1, HarnessControl.wireGuardConnects)
    }

    // Final reaudit B33: guest reads map a missing Keystore key to
    // secure_storage_corrupt, as session reads do (P6); an unavailable Keystore stays transient.
    @Test fun guestReadsReportAMissingKeystoreKeyAsCorrupt() {
        signIn()
        HarnessControl.readKeyMissing = true
        for (method in listOf("storageReadGuestCredential", "storageReadGuestAutoResume")) {
            assertEquals(method, "secure_storage_corrupt", call(method).await().error)
        }
        HarnessControl.readKeyMissing = false
        HarnessControl.readFailure = "secure_storage_read_failed"
        assertEquals("secure_storage_read_failed", call("storageReadGuestAutoResume").await().error)
    }

    // Final reaudit B19 (A10-wireguard-02, composition C1-01): an engine whose stop
    // timed out refuses its key, as the real controller does while uncertain;
    // signing out must still purge the session.
    @Test fun signOutWithAnUncertainEngineStillPurgesTheSession() {
        retainedEngineAfterStopTimeout()
        HarnessControl.publicKeyFailure = "wireguard_operation_pending"
        assertEquals("wireguard_operation_pending",
            call("getOrCreateWireGuardPublicKey", mapOf("account_id" to ACCOUNT)).await().error)
        val end = call("storageClearSession", mapOf("reason" to "voluntary")).await().value as Map<*, *>
        assertEquals(false, end["tunnel_stopped"])
        assertEquals(true, end["session_cleared"])
        assertEquals(listOf(true), HarnessControl.purges.toList())
        assertNull(SecureKeystoreStore.raw(SecureStorageKeyPolicy.accountSession(ACCOUNT)))
    }

    // QT-REVOKE-OVPN-01 (VM campaign of bc30a13): the active tile re-reads the
    // bridge only in onStartListening. SystemUI drops a START while the tile
    // listens and stops it after each updateTile, so a host-loss burst froze it
    // on "Disconnecting..." (UNAVAILABLE: SystemUI drops its clicks).
    @Test fun hostLossBurstWhileTheTileListensStillReachesTheTile() {
        signIn()
        storeTileProfile()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        TileService.systemUi = true
        TileService.holdStops = true
        val service = VpnQuickTileService()
        val stop = Gate("engine stop").also { HarnessControl.wireGuardStopGate = it }
        try {
            HarnessMain.run { bridge.onVpnHostLost("tun_permission_revoked", bridge.captureHostLoss().first) }
            stop.awaitReached()
            assertEquals(VpnStatus.DISCONNECTING, bridge.quickTileState().status)
            // The tile reads the bridge inside the DISCONNECTING window and stays listening.
            TileService.bound = service
            HarnessMain.run { service.dispatchStartListening() }
            eventually("disconnecting tile") { TileService.updates.lastOrNull() == TILE_DISCONNECTING }
        } finally { stop.open() }
        eventually("final host-loss error") { bridge.quickTileState().status == VpnStatus.ERROR }
        HarnessMain.drain()
        TileService.holdStops = false
        TileService.releaseStops()
        eventually("tile shows the interruption") { TileService.updates.lastOrNull() == TILE_INTERRUPTED }
        settleTile()
        assertEquals(TILE_INTERRUPTED, TileService.updates.last())
        assertEquals(VpnStatus.ERROR, bridge.quickTileState().status)
    }

    // Same race on a tile disconnect (api31): the IDLE request is dropped while
    // the tile still listens, then SystemUI stops it before the click completes.
    @Test fun tileDisconnectClickReachesTheFinalStateAfterTheStop() {
        signIn()
        storeTileProfile()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        val service = listeningTile(TILE_CONNECTED)
        TileService.holdStopAfterUpdate = TILE_DISCONNECTING
        TileService.afterListeningRequest = {
            if (bridge.quickTileState().status == VpnStatus.IDLE) {
                TileService.holdStopAfterUpdate = null
                TileService.releaseStops()
            }
        }
        val stop = Gate("engine stop").also { HarnessControl.wireGuardStopGate = it }
        try {
            HarnessMain.run { service.dispatchClick() }
            eventually("disconnecting tile") { TileService.updates.lastOrNull() == TILE_DISCONNECTING }
        } finally { stop.open() }
        eventually("tile shows ready") { TileService.updates.lastOrNull() == TILE_READY }
        settleTile()
        assertEquals(TILE_READY, TileService.updates.last())
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        assertEquals(1, HarnessControl.wireGuardStops)
    }

    // A refused click publishes nothing: its busy render must not stay on the
    // tile once SystemUI has stopped it (the read started before the click is discarded).
    @Test fun refusedTileClickDoesNotLeaveTheBusyTile() {
        signIn()
        val service = VpnQuickTileService()
        TileService.systemUi = true
        TileService.bound = service
        val read = Gate("tile profile read").also { HarnessControl.tileProfileReadGate = it }
        try {
            HarnessMain.run { service.dispatchStartListening() }
            read.awaitReached()
            HarnessMain.run { service.onClick() }
            eventually("application opened") { TileService.launches.isNotEmpty() }
            assertEquals(listOf("pending:launch:com.fuzevpn.android"), TileService.launches.toList())
        } finally { read.open() }
        eventually("tile leaves the busy state") { TileService.updates.lastOrNull() == TILE_SETUP }
        settleTile()
        assertEquals(TILE_SETUP, TileService.updates.last())
    }

    // QT-REVOKE-OVPN-01 precondition: a click that can only open the app must
    // not call VpnService.prepare, which revokes another app's VPN (C2-01).
    @Test fun refusedTileClickNeverCallsVpnServicePrepare() {
        signIn()
        await(clickTile(), "tile callback")
        assertEquals(listOf<String?>("quick_tile_profile_unavailable"), tileCallbacks.toList())
        assertEquals("a click without profile prepared the VPN service", 0, VpnService.prepareCalls.get())
        storeTileProfile()
        HarnessControl.identityFailure = "wireguard_identity_unavailable"
        await(clickTile(), "tile callback")
        assertEquals(listOf<String?>("quick_tile_profile_unavailable", "wireguard_identity_unavailable"),
            tileCallbacks.toList())
        assertEquals("a click without identity prepared the VPN service", 0, VpnService.prepareCalls.get())
        assertEquals(0, HarnessControl.wireGuardConnects)
    }

    // A STOP (shade closed) that discards the tile's read must not lose the update.
    @Test fun stopThatDiscardsTheTileReadIsReconciled() {
        signIn()
        storeTileProfile()
        val service = listeningTile(TILE_READY)
        val read = Gate("tile profile read").also { HarnessControl.tileProfileReadGate = it }
        try {
            SecureKeystoreStore.remove(SecureStorageKeyPolicy.quickTileProfile())
            VpnQuickTileService.requestUpdate(context)
            read.awaitReached()
            HarnessMain.run { service.dispatchStopListening() }
        } finally { read.open() }
        eventually("tile shows the missing profile") { TileService.updates.lastOrNull() == TILE_SETUP }
        settleTile()
        assertEquals(TILE_SETUP, TileService.updates.last())
    }

    // Android 17 Compose QS or an OEM SystemUI may never stop the tile after an
    // update: every later START is dropped, so the listening instance must refresh itself.
    @Test fun tileThatSystemUiNeverStopsStillReceivesTheUpdates() {
        signIn()
        storeTileProfile()
        TileService.noStopAfterUpdate = true
        val service = listeningTile(TILE_READY)
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        eventually("tile shows connected") { TileService.updates.lastOrNull() == TILE_CONNECTED }
        settleTile()
        assertEquals(TILE_CONNECTED, TileService.updates.last())
        assertTrue(TileService.swallowedStarts.get() > 0)
        // A destroyed instance is never reloaded.
        TileService.bound = null
        HarnessMain.run { service.onDestroy() }
        val rendered = TileService.updates.toList()
        assertNull(call("disconnect").await().error)
        settleTile()
        assertEquals(rendered, TileService.updates.toList())
    }

    // Double-tap guard: until the first publication of a click the tile stays
    // busy (UNAVAILABLE), so SystemUI drops a second click.
    @Test fun busyTileDropsASecondClickBeforeTheFirstPublication() {
        signIn()
        storeTileProfile()
        val service = listeningTile(TILE_READY)
        // Connect: the first click waits in its identity read.
        val reads = Gate("tile identity").also { HarnessControl.identityGate = it }
        try {
            HarnessMain.run { service.dispatchClick() }
            reads.awaitReached()
            settleTile()
            assertEquals(TILE_BUSY, TileService.updates.last())
            HarnessMain.run { service.dispatchClick() }
        } finally { reads.open() }
        eventually("tile shows connected") { TileService.updates.lastOrNull() == TILE_CONNECTED }
        settleTile()
        assertEquals(1, TileService.droppedClicks.get())
        assertEquals(1, TileService.updates.count { it == TILE_BUSY })
        assertEquals(1, HarnessControl.wireGuardConnects)
        // Disconnect: the first click waits for the tunnel mutex held by a key request.
        val key = Gate("public key").also { HarnessControl.publicKeyGate = it }
        val keyRequest = call("getOrCreateWireGuardPublicKey", mapOf("account_id" to ACCOUNT))
        try {
            key.awaitReached()
            HarnessMain.run { service.dispatchClick() }
            settleTile()
            assertEquals(TILE_BUSY, TileService.updates.last())
            HarnessMain.run { service.dispatchClick() }
        } finally { key.open() }
        assertNull(keyRequest.await().error)
        eventually("tile shows ready") { TileService.updates.lastOrNull() == TILE_READY }
        settleTile()
        assertEquals(2, TileService.droppedClicks.get())
        assertEquals(2, TileService.updates.count { it == TILE_BUSY })
        assertEquals(1, HarnessControl.wireGuardStops)
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
    }

    // No loop: each publication costs at most one reconciling request, and the
    // requests stop once the tile shows the bridge state.
    @Test fun continuousPublicationsKeepTheTileRequestsBounded() {
        signIn()
        storeTileProfile()
        val service = listeningTile(TILE_READY)
        val before = TileService.listeningRequests.get()
        repeat(PUBLICATIONS) { VpnQuickTileService.requestUpdate(context) }
        settleTile()
        val requests = TileService.listeningRequests.get() - before
        assertTrue("listening requests: $requests", requests in PUBLICATIONS..2 * PUBLICATIONS)
        assertEquals(TILE_READY, TileService.updates.last())
        // Without a Tile object nothing renders; a STOP must not restart the cycle.
        TileService.tile = null
        val withoutTile = TileService.listeningRequests.get()
        repeat(PUBLICATIONS) { VpnQuickTileService.requestUpdate(context) }
        HarnessMain.run { service.dispatchStopListening() }
        settleTile()
        val settled = TileService.listeningRequests.get()
        assertTrue("listening requests: ${settled - withoutTile}", settled - withoutTile in PUBLICATIONS..2 * PUBLICATIONS + 1)
        Thread.sleep(500)
        HarnessMain.drain()
        assertEquals("tile requests kept growing", settled, TileService.listeningRequests.get())
    }

    // Busy guard: the read that the click's own START began completes while
    // SystemUI still holds the STOP after the busy render; it must not make
    // the tile clickable again before the click's first publication.
    @Test fun busyTileIgnoresTheReadItsOwnClickStarted() {
        signIn()
        storeTileProfile()
        val service = listeningTile(TILE_READY)
        TileService.holdStopAfterUpdate = TILE_BUSY
        val identity = Gate("tile identity").also { HarnessControl.identityGate = it }
        try {
            val read = HarnessMain.run { service.dispatchClick(); pendingTileRead(service) }
            identity.awaitReached()
            kotlinx.coroutines.runBlocking { kotlinx.coroutines.withTimeout(20_000) { read.join() } }
            assertFalse("the click's own read was cancelled", read.isCancelled)
            settleTile()
            assertEquals(TILE_BUSY, TileService.updates.last())
            HarnessMain.run { service.dispatchClick() }
            assertEquals(1, TileService.droppedClicks.get())
        } finally { identity.open() }
        eventually("tile shows connected") { TileService.updates.lastOrNull() == TILE_CONNECTED }
        settleTile()
        assertEquals(1, TileService.updates.count { it == TILE_BUSY })
        assertEquals(1, HarnessControl.wireGuardConnects)
    }

    // SystemUI unbinds the listening tile without a STOP: the publication it
    // missed while its read was held reaches the instance bound after it.
    @Test fun destroyedTileHandsAMissedPublicationToTheNextInstance() {
        signIn()
        storeTileProfile()
        val old = listeningTile(TILE_READY)
        val next = VpnQuickTileService()
        val before = TileService.listeningRequests.get()
        val read = Gate("tile profile read").also { HarnessControl.tileProfileReadGate = it }
        try {
            HarnessMain.run { old.dispatchStartListening() }
            read.awaitReached()
            SecureKeystoreStore.remove(SecureStorageKeyPolicy.quickTileProfile())
            // One main-thread turn: no read of the old tile can deliver before its destroy.
            HarnessMain.run {
                VpnQuickTileService.requestUpdate(context)
                TileService.bound = next
                old.onDestroy()
            }
        } finally { read.open() }
        eventually("next tile shows the missing profile") { TileService.updates.lastOrNull() == TILE_SETUP }
        settleTile()
        assertEquals(TILE_SETUP, TileService.updates.last())
        assertEquals("SystemUI dropped the publication's START", 1, TileService.swallowedStarts.get())
        assertEquals("the publication plus one request from the destroy", before + 2, TileService.listeningRequests.get())
    }

    // Without a Tile object, a read begun before the click must not move the
    // rendered revision back: the next STOP would request listening in vain.
    @Test fun staleReadWithoutATileRequestsNoListeningAgain() {
        signIn()
        storeTileProfile()
        val service = listeningTile(TILE_READY)
        TileService.tile = null
        val read = Gate("tile profile read").also { HarnessControl.tileProfileReadGate = it }
        val identity = Gate("tile identity").also { HarnessControl.identityGate = it }
        try {
            val stale = HarnessMain.run { service.dispatchStartListening(); pendingTileRead(service) }
            read.awaitReached()
            // A publication after that read began, then a click before the tile refreshes itself.
            TileService.afterListeningRequest = {
                TileService.afterListeningRequest = null
                HarnessMain.post { service.onClick() }
            }
            VpnQuickTileService.requestUpdate(context)
            identity.awaitReached()
            read.open()
            kotlinx.coroutines.runBlocking { kotlinx.coroutines.withTimeout(20_000) { stale.join() } }
            assertFalse("the stale read was cancelled", stale.isCancelled)
            val requests = TileService.listeningRequests.get()
            HarnessMain.run { service.dispatchStopListening() }
            settleTile()
            assertEquals("a STOP requested listening again", requests, TileService.listeningRequests.get())
        } finally { read.open(); identity.open() }
        eventually("click connected") { bridge.quickTileState().status == VpnStatus.CONNECTED }
        settleTile()
    }

    // OpenVPN network loss (Android 16 VM): onLost decides alone. getAllNetworks
    // can still list the departing network as VALIDATED while the callback runs.
    @Test fun openVpnLossIsHandledWhileTheFrameworkStillListsTheLostNetwork() {
        connectOpenVpn()
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        loseNetwork()
        loseNetwork()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        eventually("reconnecting published") { sink.events.contains(RECONNECTING) }
        Thread.sleep(2_500) // past the 2 s delay, inside the network wait
        assertEquals(sink.events.toString(), 1, settledEvents().count { it == RECONNECTING })
        assertEquals(0, HarnessControl.openVpnReconnects)
        assertFalse("the TUN hold was released during the wait", "stop" in HarnessControl.openVpnService)
        assertNull(call("disconnect").await().error)
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
        assertEquals("stop", HarnessControl.openVpnService.lastOrNull())
        assertEquals(0, HarnessControl.openVpnReconnects)
    }

    // Wi-Fi to cellular handover: another validated network remains, but Core's
    // socket was connected through the lost one. The restart keeps the TUN held.
    @Test fun openVpnReconnectsWhenWifiIsLostAndCellularRemains() {
        connectOpenVpn()
        loseNetwork()
        eventually("reconnected") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        val events = settledEvents()
        assertEquals(events.toString(), listOf(RECONNECTING, OPENVPN_CONNECTED), events.takeLast(2))
        assertEquals(1, HarnessControl.openVpnReconnects)
        assertFalse(registry().snapshot()!!.recoveryConsumed)
        assertEquals(listOf("start(reconnecting=false)", "start(reconnecting=true)"),
            HarnessControl.openVpnService.toList())
    }

    // Repeated outages: each proven reconnect makes the next network change possible.
    @Test fun repeatedNetworkChangesNeverExhaustOpenVpnRecovery() {
        connectOpenVpn()
        for (cycle in 1..3) {
            loseNetwork()
            eventually("reconnect $cycle") { sink.events.count { it == OPENVPN_CONNECTED } == cycle + 1 }
        }
        assertEquals(3, HarnessControl.openVpnReconnects)
        val events = settledEvents()
        assertFalse(events.toString(), events.any { it.endsWith("/openvpn_recovery_exhausted") })
        assertFalse(registry().snapshot()!!.recoveryConsumed)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
    }

    // A network change never re-arms Core's own failure retry: one per explicit connection.
    @Test fun coreInterruptionsKeepASingleRetryAfterNetworkChanges() {
        connectOpenVpn()
        loseNetwork()
        eventually("network reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertFalse(registry().snapshot()!!.recoveryConsumed)
        engine().coreReconnectRequired()
        eventually("failure retry") { sink.events.count { it == OPENVPN_CONNECTED } == 3 }
        assertTrue(registry().snapshot()!!.recoveryConsumed)
        engine().coreReconnectRequired()
        eventually("exhausted recovery stopped") { HarnessControl.openVpnService.lastOrNull() == "stop" }
        eventually("exhausted recovery published") { bridge.quickTileState().status == VpnStatus.ERROR }
        val events = settledEvents()
        assertEquals(events.toString(), "error/openvpn/openvpn_recovery_exhausted", events.last())
        assertEquals(2, HarnessControl.openVpnReconnects)
    }

    // A loss between Core's start and the published CONNECTED is acted on at the proof.
    @Test fun lossDuringOpenVpnStartIsDeliveredOnceProven() {
        signIn()
        val start = Gate("openvpn start").also { HarnessControl.openVpnStartGate = it }
        val connecting = call("connectOpenVpn", openVpnArguments())
        start.awaitReached()
        loseNetwork()
        start.open()
        assertNull(connecting.await().error)
        eventually("reconnected after the proof") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        val events = settledEvents()
        assertEquals(events.toString(), listOf(OPENVPN_CONNECTED, RECONNECTING, OPENVPN_CONNECTED),
            events.filter { it == OPENVPN_CONNECTED || it == RECONNECTING })
        assertEquals(1, HarnessControl.openVpnReconnects)
    }

    // Test plan 8.6 is kept: 2 s, then 30 s without a validated network end the
    // session with a notice, and only then is the TUN released (about 33 s).
    @Test fun openVpnOutageWithoutNetworkStillEndsInNetworkUnavailable() {
        connectOpenVpn()
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        loseNetwork()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        eventually("reconnecting published") { sink.events.contains(RECONNECTING) }
        eventually("network wait expired", seconds = 40) { HarnessControl.openVpnService.lastOrNull() == "stop" }
        eventually("error published") { bridge.quickTileState().messageCode == "network_unavailable" }
        val events = settledEvents()
        assertEquals(events.toString(), "error/openvpn/network_unavailable", events.last())
        assertTrue(HarnessControl.notifications.toString(),
            HarnessControl.notifications.contains("startProtocol(OPENVPN,ERROR,reconnecting=false,action=true)"))
        assertEquals(0, HarnessControl.openVpnReconnects)
        val record = registry().snapshot()!!
        assertEquals(SystemVpnResumeStatus.BLOCKED, record.status)
        assertEquals("network_unavailable", record.errorCode)
    }

    @Test fun wireGuardSessionNeverTriggersOpenVpnLoss() {
        signIn()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        loseNetwork()
        Thread.sleep(300)
        HarnessMain.drain()
        assertEquals(0, HarnessControl.openVpnNetworkLosses)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(VpnProtocol.WIREGUARD, bridge.quickTileState().protocol)
    }

    /**
     * A tile click waits in its reads while a restore is admitted and waits for
     * the network; a key request then holds the mutex, the network returns, the
     * restore queues on the mutex and the tile queues behind it.
     */
    // Campaign 74018 (P2): the permanent VPN came back neither after a SIGKILL nor after
    // am crash. Android unbinds the dead VPN host and then never restarts it; an unbound
    // sticky service is restarted instead, and it restores only what Android would.
    @Test fun alwaysOnEnabledAfterConnectArmsTheRestartAnchor() {
        signIn()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        eventually("connected delivered") { sink.events.contains(WIREGUARD_CONNECTED) }
        Thread.sleep(300)
        assertFalse(HarnessControl.sentinel.toString(), HarnessControl.sentinel.contains(true))
        // Android sends no event when the permanent VPN is enabled for a connected app.
        SharedVpnHost.flags = true to false
        eventually("armed after the late enable", seconds = 6) { HarnessControl.sentinel.lastOrNull() == true }
    }

    @Test fun processRestartRestoresTheReadyWireGuardTunnel() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        // Android answers isAlwaysOn() again once the restored VPN is established.
        SharedVpnHost.flags = true to false
        processRestart()
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        val restoring = sink.events.indexOf("connecting/wireguard/system_vpn_restoring")
        assertTrue(sink.events.toString(), restoring >= 0 && restoring < sink.events.indexOf(WIREGUARD_CONNECTED))
        assertEquals(2, HarnessControl.wireGuardConnects)
        assertEquals(1, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        eventually("re-armed once Android reports the permanent VPN", seconds = 6) {
            HarnessControl.sentinel.lastOrNull() == true
        }
    }

    @Test fun processRestartRestoresTheReadyOpenVpnTunnel() {
        armed { connectOpenVpn(); OPENVPN_CONNECTED }
        processDeath()
        processRestart()
        eventually("restored", seconds = 10) { sink.events.contains(OPENVPN_CONNECTED) }
        assertEquals(1, HarnessControl.openVpnReconnects)
        assertEquals(1, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
    }

    @Test fun userDisconnectDisarmsAtReceiptAndTheRestartRestoresNothing() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        val keyHoldsMutex = Gate("public key").also { HarnessControl.publicKeyGate = it }
        val key = call("getOrCreateWireGuardPublicKey", mapOf("account_id" to ACCOUNT))
        keyHoldsMutex.awaitReached()
        val stop = call("disconnect")
        // Disarmed at receipt while the stop still waits for the mutex.
        assertEquals(false, HarnessControl.sentinel.lastOrNull())
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        keyHoldsMutex.open()
        key.await()
        assertNull(stop.await().error)
        assertNull("tombstone", registry().snapshot())
        assertEquals(false, HarnessControl.sentinel.lastOrNull())
        processDeath()
        processRestart()
        settleSystemJob()
        assertEquals(0, HarnessControl.hostStarts)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
    }

    @Test fun nothingReArmsWhileAStopIsPending() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        val keyHoldsMutex = Gate("public key").also { HarnessControl.publicKeyGate = it }
        val key = call("getOrCreateWireGuardPublicKey", mapOf("account_id" to ACCOUNT))
        keyHoldsMutex.awaitReached()
        val stop = call("disconnect")
        val atReceipt = HarnessControl.sentinel.size
        // The tunnel is still CONNECTED behind the mutex: new samples must not re-arm.
        SharedVpnHost.flags = false to false
        Thread.sleep(2_500)
        SharedVpnHost.flags = true to false
        Thread.sleep(2_500)
        val duringStop = HarnessControl.sentinel.subList(atReceipt, HarnessControl.sentinel.size).toList()
        assertFalse(duringStop.toString(), duringStop.contains(true))
        keyHoldsMutex.open()
        key.await()
        assertNull(stop.await().error)
        assertEquals(false, HarnessControl.sentinel.lastOrNull())
        assertNull("tombstone", registry().snapshot())
    }

    @Test fun revokedHostDisarmsAndTheRestartRestoresNothing() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        bridge.onVpnHostLost("tun_permission_revoked", bridge.captureHostLoss().first)
        eventually("blocked") { registry().snapshot()?.status == SystemVpnResumeStatus.BLOCKED }
        eventually("disarmed") { HarnessControl.sentinel.lastOrNull() == false }
        processDeath()
        processRestart()
        settleSystemJob()
        assertEquals(0, HarnessControl.hostStarts)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
    }

    @Test fun restoreInterruptedByDeathIsNotRetried() {
        signIn()
        armResume()
        assertNotNull(registry().reserve(SESSION, WireGuardController.IDENTITY))
        processDeath()
        processRestart()
        settleSystemJob()
        assertEquals(0, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.RESERVED, registry().snapshot()!!.status)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        assertEquals(false, HarnessControl.sentinel.lastOrNull())
    }

    @Test fun refusedHostStartKeepsTheRecordReadyAndShowsNothing() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        HarnessControl.hostStartFailure = "vpn_host_unavailable"
        processRestart()
        settleSystemJob()
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertEquals(0, HarnessControl.hostStarts)
        assertEquals(1, HarnessControl.wireGuardConnects)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        assertFalse(HarnessControl.notifications.toString(), HarnessControl.notifications.any { it.contains(",ERROR,") })
    }

    @Test fun foreignVpnOrMissingConsentSkipsWithoutSideEffects() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        // prepare() would take the VPN over from the app the user chose meanwhile.
        ConnectivityManager.vpn = Network()
        VpnService.reset()
        processRestart()
        settleSystemJob()
        assertEquals(0, VpnService.prepareCalls.get())
        assertEquals(0, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        ConnectivityManager.vpn = null
        VpnService.consentIntent = Intent()
        processRestart()
        settleSystemJob()
        assertEquals(1, VpnService.prepareCalls.get())
        assertEquals(0, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertFalse(settledEvents().toString(), settledEvents().any { it.startsWith("error/") })
    }

    @Test fun noNetworkAtRestartLeavesTheRecordReadyAndStartsNothing() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        processRestart()
        Thread.sleep(1_000)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        assertTrue(HarnessControl.notifications.toString(), HarnessControl.notifications.isEmpty())
        settleSystemJob(timeoutMillis = 40_000)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertEquals(0, HarnessControl.hostStarts)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        assertEquals(false, HarnessControl.sentinel.lastOrNull())
    }

    @Test fun handshakeFailureAfterTheHostStartBlocksLikeTheBootPath() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        HarnessControl.wireGuardConnect = { false }
        processRestart()
        settleSystemJob()
        assertEquals(SystemVpnResumeStatus.BLOCKED, registry().snapshot()!!.status)
        assertTrue(settledEvents().toString(), settledEvents().contains("error/wireguard/wireguard_handshake_timeout"))
        assertTrue(HarnessControl.notifications.toString(),
            HarnessControl.notifications.contains("startProtocol(WIREGUARD,ERROR,reconnecting=false,action=true)"))
        assertEquals(1, HarnessControl.hostStarts)
    }

    @Test fun androidSystemStartSupersedesAPendingProcessRestart() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        processRestart()
        Thread.sleep(500)
        systemStart()
        Thread.sleep(500)
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        settleSystemJob()
        assertEquals(settledEvents().toString(), 1, settledEvents().count { it == WIREGUARD_CONNECTED })
        assertEquals(2, HarnessControl.wireGuardConnects)
        assertEquals(0, HarnessControl.hostStarts)
    }

    @Test fun processRestartDefersToARunningSystemStart() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        systemStart()
        eventually("restoring published") { bridge.quickTileState().messageCode == "system_vpn_restoring" }
        processRestart()
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        settleSystemJob()
        assertEquals(settledEvents().toString(), 1, settledEvents().count { it == WIREGUARD_CONNECTED })
        assertEquals(2, HarnessControl.wireGuardConnects)
        assertEquals(0, HarnessControl.hostStarts)
    }

    @Test fun alwaysOnOffNeverArms() {
        signIn()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        eventually("connected delivered") { sink.events.contains(WIREGUARD_CONNECTED) }
        Thread.sleep(2_500)
        assertFalse(HarnessControl.sentinel.toString(), HarnessControl.sentinel.contains(true))
    }

    @Test fun android9NeverArms() {
        android.os.Build.VERSION.SDK_INT = 28
        SharedVpnHost.flags = null to null
        signIn()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        eventually("connected delivered") { sink.events.contains(WIREGUARD_CONNECTED) }
        Thread.sleep(2_500)
        assertFalse(HarnessControl.sentinel.toString(), HarnessControl.sentinel.contains(true))
    }

    @Test fun aVpnOfAnotherProfileDoesNotBlockTheRestore() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        ConnectivityManager.vpn = Network()
        ConnectivityManager.vpnCoversApp = false
        SharedVpnHost.flags = true to false
        processRestart()
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        assertEquals(1, HarnessControl.hostStarts)
    }

    @Test fun aPermanentVpnMovedToAnotherAppIsNotTakenOverWhereAndroidSaysSo() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        android.provider.Settings.Secure.readable = true
        android.provider.Settings.Secure.alwaysOnVpnApp = "com.example.othervpn"
        VpnService.reset()
        processRestart()
        settleSystemJob()
        assertEquals(0, VpnService.prepareCalls.get())
        assertEquals(0, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        android.provider.Settings.Secure.alwaysOnVpnApp = context.packageName
        SharedVpnHost.flags = true to false
        processRestart()
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        assertEquals(1, HarnessControl.hostStarts)
    }

    @Test fun androidStartDuringTheRestartReservationRestoresOnce() {
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        processDeath()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        processRestart()
        Thread.sleep(500) // the read-only checks passed; the restart waits for a network
        val identity = Gate("restart identity").also { HarnessControl.identityGate = it }
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        identity.awaitReached() // inside the reservation step, holding the tunnel mutex
        systemStart()
        identity.open()
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        settleSystemJob()
        assertEquals(settledEvents().toString(), 1, settledEvents().count { it == WIREGUARD_CONNECTED })
        assertFalse(settledEvents().toString(), settledEvents().any { it.startsWith("error/") })
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertEquals(0, HarnessControl.hostStarts)
    }

    // Campaign vm31i (Android 11 VM, release build: 10 crashes in 40 cold starts): a proxy
    // update left the process-wide ConnectivityManager on package android. The bridge is built
    // in Application.onCreate, and no decision may wait for a network the process cannot observe.
    @Test fun systemPackageManagerStillBuildsTheBridgeAndKeepsWireGuardConnected() {
        poisonedProcessDeath()
        signIn()
        storeTileProfile()
        val tile = bridge.quickTileSnapshot()
        assertEquals(VpnStatus.IDLE, tile.state.status)
        assertTrue(tile.canConnect)
        assertEquals("idle", (call("getState").await().value as Map<*, *>)["status"])
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        Thread.sleep(2_500) // past two runs of the 1 Hz recovery observer
        val events = settledEvents()
        assertFalse(events.toString(), events.any { it.endsWith("/wireguard_waiting_network") })
        assertEquals(events.toString(), WIREGUARD_CONNECTED, events.last())
        assertEquals("connected", (call("getState").await().value as Map<*, *>)["status"])
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileSnapshot().state.status)
        assertNull(call("disconnect").await().error)
        assertEquals(VpnStatus.IDLE, bridge.quickTileState().status)
    }

    @Test fun processRestartIntoASystemPackageManagerRestoresThePermanentVpn() {
        android.os.Build.VERSION.SDK_INT = 30
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        poisonedProcessDeath()
        // Android 11 still lets the app read which app is the permanent VPN.
        android.provider.Settings.Secure.readable = true
        android.provider.Settings.Secure.alwaysOnVpnApp = context.packageName
        SharedVpnHost.flags = true to false
        processRestart()
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        settleSystemJob()
        assertEquals(1, HarnessControl.hostStarts)
        assertEquals(2, HarnessControl.wireGuardConnects)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        Thread.sleep(1_500) // past the 1 Hz recovery observer
        assertFalse(settledEvents().toString(), settledEvents().any { it.endsWith("/wireguard_waiting_network") })
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
    }

    @Test fun systemPackageManagerStillRefusesAnotherAppsVpnAtRestart() {
        android.os.Build.VERSION.SDK_INT = 30
        armed { assertNull(call("connectWireGuard", wireGuardArguments()).await().error); WIREGUARD_CONNECTED }
        poisonedProcessDeath()
        // Capabilities throw here; the legacy type of the default network still names the VPN.
        // Settings stay unreadable, so only that network check can refuse.
        ConnectivityManager.vpn = Network()
        VpnService.reset()
        processRestart()
        settleSystemJob()
        assertEquals(0, VpnService.prepareCalls.get())
        assertEquals(0, HarnessControl.hostStarts)
        assertEquals(SystemVpnResumeStatus.READY, registry().snapshot()!!.status)
        assertTrue(settledEvents().toString(), settledEvents().isEmpty())
        // A VPN of another profile does not carry this app: its default network is physical again.
        ConnectivityManager.vpnCoversApp = false
        SharedVpnHost.flags = true to false
        processRestart()
        eventually("restored", seconds = 10) { sink.events.contains(WIREGUARD_CONNECTED) }
        assertEquals(1, HarnessControl.hostStarts)
    }

    // Campaign vm31j (Android 11 VM: OpenVPN downloads timed out on Wi-Fi loss and return, Core
    // noticing only at its keepalive). Without the callback, the default physical network read with
    // no package check shows the loss: when its network vanishes, it is followed within a look as
    // onLost would be, by a reconnect that leaves the failure retry unused, each time.
    @Test fun systemPackageManagerFollowsEachVanishedPhysicalNetwork() {
        poisonedProcessDeath()
        ConnectivityManager.physicalNetworks += ConnectivityManager.cellular
        connectOpenVpn()
        awaitNetworkLook()
        val departures = listOf<() -> Unit>(
            // Wi-Fi lost: the cellular network remains, as the default.
            { ConnectivityManager.change { physicalNetworks -= physical; defaultNetwork = cellular } },
            // The cellular network is lost in turn, a new Wi-Fi network taking its place in one change.
            { val wifi = Network(); ConnectivityManager.change { physicalNetworks.replaceAll { wifi }; defaultNetwork = wifi } },
        )
        for ((index, departure) in departures.withIndex()) {
            val cycle = index + 1
            departure()
            eventually("loss $cycle signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == cycle }
            eventually("reconnect $cycle") { sink.events.count { it == OPENVPN_CONNECTED } == cycle + 1 }
            assertFalse("loss $cycle consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        }
        val events = settledEvents()
        assertFalse(events.toString(), events.any { it.endsWith("/openvpn_recovery_exhausted") })
        assertEquals(events.toString(), listOf(OPENVPN_CONNECTED, RECONNECTING, OPENVPN_CONNECTED, RECONNECTING, OPENVPN_CONNECTED),
            events.filter { it == OPENVPN_CONNECTED || it == RECONNECTING })
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
        assertEquals(2, HarnessControl.openVpnReconnects)
        assertEquals(listOf("start(reconnecting=false)", "start(reconnecting=true)", "start(reconnecting=true)"),
            HarnessControl.openVpnService.toList())
    }

    // Campaign vm31k (Android 11 VM: downloads timed out once the Wi-Fi returned). The returning
    // Wi-Fi becomes the default while the cellular network stays listed: it lingers, then runs in the
    // background where Core's traffic stops (the callback's onLost, about 30 s later). That change of
    // the default is the loss, followed within a look by a reconnect that keeps the failure retry;
    // the lingering network's later teardown is no second loss.
    @Test fun systemPackageManagerFollowsTheWiFiReturnOverALingeringCellularNetwork() {
        poisonedProcessDeath()
        listNetworks(ConnectivityManager.cellular)
        connectOpenVpn()
        awaitNetworkLook()
        val wifi = Network()
        ConnectivityManager.change { physicalNetworks += wifi; defaultNetwork = wifi }
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertFalse("the loss consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        ConnectivityManager.physicalNetworks -= ConnectivityManager.cellular
        awaitNetworkLook(3) // one began without it; the next began after that one's signal, if any
        val events = settledEvents()
        assertEquals(events.toString(), listOf(OPENVPN_CONNECTED, RECONNECTING, OPENVPN_CONNECTED),
            events.filter { it == OPENVPN_CONNECTED || it == RECONNECTING })
        assertEquals(1, HarnessControl.openVpnNetworkLosses)
        assertEquals(1, HarnessControl.openVpnReconnects)
        assertEquals(listOf("start(reconnecting=false)", "start(reconnecting=true)"), HarnessControl.openVpnService.toList())
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
    }

    // VoLTE (Android 11): an IMS network of the cellular type, with its own APN, stays listed beside
    // the cellular data network. That data network replaced by a new one of the same APN (mobile data
    // off and on, data stall recovery: a gap shorter than the poll's second goes unseen) is a loss,
    // which the IMS network never hides, followed within a look by a reconnect that keeps the failure
    // retry.
    @Test fun systemPackageManagerFollowsTheCellularDataNetworkReplacedBesideAnImsNetwork() {
        poisonedProcessDeath()
        listNetworks(ConnectivityManager.cellular, CellularNetwork("ims"))
        connectOpenVpn()
        awaitNetworkLook()
        val replacement = CellularNetwork()
        ConnectivityManager.change { physicalNetworks -= cellular; physicalNetworks += replacement; defaultNetwork = replacement }
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertFalse("the loss consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        awaitNetworkLook(3) // the replacement stays the default, the IMS network listed beside it
        assertFollowedNetworkLosses(1)
    }

    // Dual SIM (Android 11): mobile data moves to the other SIM, whose cellular network has another
    // APN. It comes up behind the default, then becomes the default while the first SIM's network
    // stays listed, lingering: that change of the default is the loss; the lingering network's later
    // teardown is no second loss.
    @Test fun systemPackageManagerFollowsMobileDataMovingToTheOtherSim() {
        poisonedProcessDeath()
        val first = CellularNetwork("a")
        val second = CellularNetwork("b")
        listNetworks(first)
        connectOpenVpn()
        ConnectivityManager.physicalNetworks += second
        awaitNetworkLook(2) // one began with it listed behind the default
        assertEquals("a network listed behind the default was a loss", 0, HarnessControl.openVpnNetworkLosses)
        ConnectivityManager.defaultNetwork = second
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertFalse("the loss consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        ConnectivityManager.physicalNetworks -= first
        awaitNetworkLook(3) // one began without it; the next began after that one's signal, if any
        assertFollowedNetworkLosses(1)
    }

    // Dual SIM (Android 11): the default cellular data network is SUSPENDED (out of data service, a
    // call without concurrent voice and data), its APN kept, while the other SIM's IMS network stays
    // connected beside it. Still the default, it is no loss, and the IMS network never stands in for
    // it: its teardown, leaving no default network for a moment, is the one loss; the reconnect waits
    // for the new data network that becomes the default.
    @Test fun systemPackageManagerFollowsASuspendedDefaultNetworkUntilItsTeardown() {
        poisonedProcessDeath()
        val data = CellularNetwork()
        listNetworks(data, CellularNetwork("ims"))
        connectOpenVpn()
        awaitNetworkLook()
        ConnectivityManager.states[data] = NetworkInfo.DetailedState.SUSPENDED
        awaitNetworkLook(3) // one began with it suspended; the next began after that one's signal, if any
        assertEquals("a suspended default network was a loss", 0, HarnessControl.openVpnNetworkLosses)
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        ConnectivityManager.change { physicalNetworks -= data; states -= data; defaultNetwork = null }
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        val next = CellularNetwork()
        ConnectivityManager.change { physicalNetworks += next; defaultNetwork = next }
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        awaitNetworkLook(3) // the new default stays, the IMS network listed beside it
        assertFollowedNetworkLosses(1)
    }

    // Data Saver or a power restriction (Android 11): the default network reads BLOCKED for this app,
    // which clears its APN in both readings, then connected again. It never left: no loss, no reconnect.
    @Test fun systemPackageManagerKeepsTheDefaultNetworkWhileItIsBlockedForThisApp() {
        poisonedProcessDeath()
        listNetworks(ConnectivityManager.cellular)
        connectOpenVpn()
        awaitNetworkLook()
        ConnectivityManager.states[ConnectivityManager.cellular] = NetworkInfo.DetailedState.BLOCKED
        awaitNetworkLook(2) // one began with it blocked
        ConnectivityManager.states -= ConnectivityManager.cellular
        awaitNetworkLook(3) // one began with it connected again; the next began after that one's signal, if any
        assertFollowedNetworkLosses(0)
    }

    // Same APN, make before break (Android 11): a new data network of the default's APN comes up,
    // connected, behind it, then becomes the default while the old one stays listed. Core's traffic
    // stays on the network it was followed on: the move of the default is no loss, the old network's
    // departure is the one loss.
    @Test fun systemPackageManagerFollowsTheOldNetworkUntilItLeavesAfterASameApnReplacement() {
        poisonedProcessDeath()
        val old = CellularNetwork()
        val replacement = CellularNetwork()
        listNetworks(old)
        connectOpenVpn()
        awaitNetworkLook()
        ConnectivityManager.physicalNetworks += replacement
        awaitNetworkLook(2) // one began with it listed behind the default
        ConnectivityManager.defaultNetwork = replacement
        awaitNetworkLook(3) // one began with it as the default; the next began after that one's signal, if any
        assertEquals("a replacement of the same APN was a loss while the old network stayed", 0,
            HarnessControl.openVpnNetworkLosses)
        ConnectivityManager.physicalNetworks -= old
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertFalse("the loss consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        awaitNetworkLook(3) // the replacement stays the default
        assertFollowedNetworkLosses(1)
    }

    // Wi-Fi only: the Wi-Fi network is lost, leaving no default network for a moment, then a new
    // Wi-Fi network is listed while it obtains its address, then becomes the default. The departure is
    // the one loss: the reconnect waits for a network, and the new default is no second loss.
    @Test fun systemPackageManagerFollowsAWiFiNetworkLostThenReplaced() {
        poisonedProcessDeath()
        connectOpenVpn()
        awaitNetworkLook()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        ConnectivityManager.change { physicalNetworks -= physical; defaultNetwork = null }
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        val wifi = Network()
        ConnectivityManager.change { states[wifi] = NetworkInfo.DetailedState.CONNECTING; physicalNetworks += wifi }
        awaitNetworkLook(2) // one began with it listed, still without an address
        ConnectivityManager.change { states -= wifi; defaultNetwork = wifi }
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        awaitNetworkLook(3) // the new default stays
        assertFollowedNetworkLosses(1)
    }

    // Only a connected (or suspended) network stands for the default: a Wi-Fi network listed behind the
    // default Wi-Fi while it still obtains its address, with its type and extra information, does not
    // hide the default's departure when it takes its place, connected, in one change.
    @Test fun systemPackageManagerFollowsTheDefaultReplacedByANetworkThatWasStillConnecting() {
        poisonedProcessDeath()
        val next = Network()
        ConnectivityManager.change { states[next] = NetworkInfo.DetailedState.CONNECTING; physicalNetworks += next }
        connectOpenVpn()
        awaitNetworkLook()
        ConnectivityManager.change { physicalNetworks -= physical; states -= next; defaultNetwork = next }
        eventually("loss signalled", seconds = 3) { HarnessControl.openVpnNetworkLosses == 1 }
        eventually("reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        awaitNetworkLook(3) // the new default stays
        assertFollowedNetworkLosses(1)
    }

    // Only the default physical network carries Core's traffic, as only it reaches the callback's
    // request: a network listed behind it (an IMS or MMS network of its type, with its own APN, a
    // Wi-Fi still without an address) comes and goes with no loss and no reconnect.
    @Test fun systemPackageManagerIgnoresNetworksListedBehindTheDefault() {
        poisonedProcessDeath()
        listNetworks(ConnectivityManager.cellular)
        connectOpenVpn()
        val connecting = Network().also { ConnectivityManager.states[it] = NetworkInfo.DetailedState.CONNECTING }
        for (behind in listOf(CellularNetwork("ims"), CellularNetwork("mms"), connecting)) {
            ConnectivityManager.physicalNetworks += behind
            awaitNetworkLook(2) // one began with it listed
            ConnectivityManager.physicalNetworks -= behind
            awaitNetworkLook(3) // one began without it; the next began after that one's signal, if any
        }
        val events = settledEvents()
        assertEquals(events.toString(), listOf(OPENVPN_CONNECTED), events.filter { it == OPENVPN_CONNECTED || it == RECONNECTING })
        assertEquals(0, HarnessControl.openVpnNetworkLosses)
        assertEquals(0, HarnessControl.openVpnReconnects)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
    }

    // A server failing after its handshake interrupts while the default network stays listed (one
    // listed behind it that came and went is no loss, even for the interruption's own look): as with
    // the callback, one failure retry, then openvpn_recovery_exhausted.
    @Test fun systemPackageManagerKeepsTheSingleRetryForCoreInterruptions() {
        poisonedProcessDeath()
        connectOpenVpn()
        ConnectivityManager.physicalNetworks += ConnectivityManager.cellular
        awaitNetworkLook(2) // one began with it listed; the next look is a second away
        ConnectivityManager.physicalNetworks -= ConnectivityManager.cellular
        engine().coreReconnectRequired()
        eventually("failure retry") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertTrue("the interruption was followed as a network change", registry().snapshot()!!.recoveryConsumed)
        engine().coreReconnectRequired()
        eventually("exhausted recovery stopped") { HarnessControl.openVpnService.lastOrNull() == "stop" }
        eventually("exhausted recovery published") { bridge.quickTileState().status == VpnStatus.ERROR }
        val events = settledEvents()
        assertEquals(events.toString(), "error/openvpn/openvpn_recovery_exhausted", events.last())
        assertEquals(1, HarnessControl.openVpnReconnects)
        assertEquals(0, HarnessControl.openVpnNetworkLosses)
    }

    // Core can notice the loss before the poll's next look: a default network that vanished since
    // the previous look still makes that interruption the network change, counted once.
    @Test fun systemPackageManagerTakesACoreInterruptionAfterAVanishedNetworkAsANetworkChange() {
        poisonedProcessDeath()
        ConnectivityManager.physicalNetworks += ConnectivityManager.cellular
        connectOpenVpn()
        awaitNetworkLook() // the next look is a second away
        ConnectivityManager.change { physicalNetworks -= physical; defaultNetwork = cellular }
        engine().coreReconnectRequired()
        eventually("network reconnect") { sink.events.count { it == OPENVPN_CONNECTED } == 2 }
        assertFalse("the interruption consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        awaitNetworkLook(3) // past the poll's next looks, which must not follow the same loss again
        val events = settledEvents()
        assertEquals(events.toString(), listOf(OPENVPN_CONNECTED, RECONNECTING, OPENVPN_CONNECTED),
            events.filter { it == OPENVPN_CONNECTED || it == RECONNECTING })
        assertEquals(1, HarnessControl.openVpnReconnects)
        assertEquals("the poll signalled the loss before Core", 0, HarnessControl.openVpnNetworkLosses)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
    }

    /** Connected through [connect] with the permanent VPN off, then on: the restart is armed. */
    private fun armed(connect: () -> String) {
        signIn()
        val connected = connect()
        eventually("connected delivered") { sink.events.contains(connected) }
        SharedVpnHost.flags = true to false
        eventually("restart armed", seconds = 6) { HarnessControl.sentinel.lastOrNull() == true }
    }

    /** The process dies: its scopes and engines go, the stored records stay. */
    private fun processDeath() {
        for (name in listOf("operationScope", "observerScope")) {
            (AndroidVpnBridge::class.java.getDeclaredField(name).apply { isAccessible = true }.get(bridge) as CoroutineScope).cancel()
        }
        HarnessMain.drain()
        HarnessControl.wireGuardUp = false
        SharedVpnHost.flags = null to null
        retained(null)
        bridge = AndroidVpnBridge.obtain(context)
        HarnessMain.run { AndroidVpnBridge.obtain(context, activity, object : BinaryMessenger {}) }
        HarnessMain.run { bridge.onListen(null, sink) }
        HarnessMain.drain()
        sink.events.clear()
        HarnessControl.notifications.clear()
        HarnessControl.sentinel.clear()
    }

    /** Android 11: the next process starts with its ConnectivityManager on package android. */
    private fun poisonedProcessDeath() {
        android.os.Build.VERSION.SDK_INT = 30
        context.services[ConnectivityManager::class.java] = SystemPackageConnectivityManager()
        try { processDeath() }
        catch (error: SecurityException) { throw AssertionError("building the bridge threw in Application.onCreate", error) }
    }

    /** ActivityManager's sticky restart of the anchor. Reflective: the entry point is new. */
    private fun processRestart() {
        val entry = AndroidVpnBridge::class.java.declaredMethods.firstOrNull {
            it.name == "onProcessRestart" || it.name.startsWith("onProcessRestart$")
        } ?: throw AssertionError("no process-restart entry point")
        HarnessMain.run { entry.invoke(bridge) }
    }

    private fun queueTileBehindARestoreHeldByAKeyRequest(): Pair<CountDownLatch, ResultProbe> {
        signIn()
        storeTileProfile()
        armResume()
        com.fuzevpn.android.openvpn.OpenVpnController.network = false
        val tileReads = Gate("tile identity").also { HarnessControl.identityGate = it }
        val tile = clickTile()
        tileReads.awaitReached()
        systemStart()
        eventually("restoring published") { bridge.quickTileState().messageCode == "system_vpn_restoring" }
        keyHold = Gate("public key").also { HarnessControl.publicKeyGate = it }
        val key = call("getOrCreateWireGuardPublicKey", mapOf("account_id" to ACCOUNT))
        keyHold!!.awaitReached()
        com.fuzevpn.android.openvpn.OpenVpnController.network = true
        Thread.sleep(700) // the restore leaves its network wait and queues on the mutex
        tileReads.open()
        Thread.sleep(300) // the tile worker queues behind the restore
        return tile to key
    }

    private var keyHold: Gate? = null

    private fun releaseKeyRequest() { keyHold?.open() }

    private fun retainedEngineAfterStopTimeout() {
        signIn()
        assertNull(call("connectWireGuard", wireGuardArguments()).await().error)
        HarnessControl.wireGuardStopResult = false
        assertEquals("wireguard_stop_timeout", call("disconnect").await().error)
        assertEquals(VpnStatus.ERROR, bridge.quickTileState().status)
    }

    private fun settledEvents(): List<String> { HarnessMain.drain(); return sink.events.toList() }

    /** An active tile bound in the SystemUI model, rendered once and quiet. */
    private fun listeningTile(expected: String): VpnQuickTileService {
        val service = VpnQuickTileService()
        TileService.systemUi = true
        TileService.bound = service
        HarnessMain.run { service.dispatchStartListening() }
        eventually("tile rendered $expected") { TileService.updates.lastOrNull() == expected }
        settleTile()
        return service
    }

    /** Waits until no render and no listening request happened for 200 ms. */
    private fun settleTile() {
        val deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(8)
        var previous: Pair<Int, Int>? = null
        while (true) {
            HarnessMain.drain()
            val current = TileService.updates.size to TileService.listeningRequests.get()
            if (current == previous) return
            check(System.nanoTime() < deadline) { "tile never settled: ${TileService.updates}" }
            previous = current
            Thread.sleep(200)
        }
    }

    /** The tile's latest snapshot read (main thread only): its completion includes its delivery. */
    private fun pendingTileRead(service: VpnQuickTileService): kotlinx.coroutines.Job {
        val loader = (VpnQuickTileService::class.java.getDeclaredField("snapshotLoader\$delegate")
            .apply { isAccessible = true }.get(service) as Lazy<*>).value
        return QuickTileSnapshotLoader::class.java.getDeclaredField("pending").apply { isAccessible = true }
            .get(loader) as kotlinx.coroutines.Job
    }

    private fun settleSystemJob(timeoutMillis: Long = 20_000) {
        val job = AndroidVpnBridge::class.java.getDeclaredField("systemStartJob").apply { isAccessible = true }
            .get(bridge) as kotlinx.coroutines.Job?
        if (job != null) kotlinx.coroutines.runBlocking { kotlinx.coroutines.withTimeout(timeoutMillis) { job.join() } }
        Thread.sleep(100)
        HarnessMain.drain()
    }

    private fun retained(value: AndroidVpnBridge?) {
        AndroidVpnBridge::class.java.getDeclaredField("retainedRuntime").apply { isAccessible = true }.set(null, value)
    }

    private fun call(method: String, arguments: Any? = null): ResultProbe {
        val probe = ResultProbe()
        HarnessMain.run { bridge.onMethodCall(MethodCall(method, arguments), probe) }
        return probe
    }

    private fun clickTile(): CountDownLatch {
        val done = CountDownLatch(1)
        HarnessMain.run { bridge.toggleFromQuickTile { code -> tileCallbacks += code; done.countDown() } }
        return done
    }

    private fun systemStart() = HarnessMain.run { bridge.onSystemVpnStart() }

    private fun await(latch: CountDownLatch, what: String) =
        check(latch.await(20, TimeUnit.SECONDS)) { "$what never happened" }

    private fun eventually(what: String, seconds: Long = 8, condition: () -> Boolean) {
        val deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(seconds)
        while (!condition()) {
            check(System.nanoTime() < deadline) { "timeout: $what" }
            Thread.sleep(10)
        }
    }

    private fun signIn() {
        SecureKeystoreStore.put(SecureStorageKeyPolicy.activeUser(), ACCOUNT)
        SecureKeystoreStore.put(SecureStorageKeyPolicy.accountSession(ACCOUNT), SESSION)
        SecureKeystoreStore.put(SecureStorageKeyPolicy.currentDevice(ACCOUNT), DEVICE)
        SecureKeystoreStore.put(SecureStorageKeyPolicy.preference(SecureAppPreference.VPN_DISCLOSURE_VERSION),
            VpnDisclosurePolicy.CURRENT_VERSION)
    }

    private fun storeTileProfile() = SecureKeystoreStore.put(SecureStorageKeyPolicy.quickTileProfile(), profile.encode())

    private fun registry() = SystemVpnResumeRegistry(
        readRaw = { SecureKeystoreStore.raw(SecureStorageKeyPolicy.systemVpnResume()) },
        writeRaw = { SecureKeystoreStore.put(SecureStorageKeyPolicy.systemVpnResume(), it) },
    )

    private fun armResume() { registry().arm(profile, SESSION, WireGuardController.IDENTITY) }

    private fun wireGuardArguments(locationName: String = "Paris") = mapOf(
        "account_id" to ACCOUNT, "device_id" to DEVICE, "location_id" to "location-1", "location_name" to locationName,
        "address" to "10.8.0.2/32", "dns" to listOf("10.8.0.1"), "server_public_key" to "server-public-key",
        "endpoint" to "203.0.113.10:51820", "allowed_ips" to listOf("0.0.0.0/0"),
    )

    private fun openVpnArguments() = mapOf(
        "account_id" to ACCOUNT, "device_id" to DEVICE, "location_id" to "location-1", "location_name" to "Paris",
        "address" to "10.9.0.2/32",
    )

    /** An explicit OpenVPN connection whose CONNECTED reached Flutter. */
    private fun connectOpenVpn() {
        signIn()
        assertNull(call("connectOpenVpn", openVpnArguments()).await().error)
        eventually("connected delivered") { sink.events.contains(OPENVPN_CONNECTED) }
    }

    /** Every registered physical-network callback sees one network leave. */
    private fun loseNetwork() {
        (context.services[ConnectivityManager::class.java] as ConnectivityManager).callbacks.forEach { it.onLost(Network()) }
    }

    /** Lists [default] as the system default physical network and [behind] behind it, in one change. */
    private fun listNetworks(default: Network, vararg behind: Network) = ConnectivityManager.change {
        physicalNetworks.apply { clear(); add(default); addAll(behind) }
        defaultNetwork = default
    }

    /** Settled after [losses] signalled losses, each followed by a reconnect that kept the failure retry. */
    private fun assertFollowedNetworkLosses(losses: Int) {
        val events = settledEvents()
        assertEquals(events.toString(), listOf(OPENVPN_CONNECTED) + List(losses) { listOf(RECONNECTING, OPENVPN_CONNECTED) }.flatten(),
            events.filter { it == OPENVPN_CONNECTED || it == RECONNECTING })
        assertEquals(losses, HarnessControl.openVpnNetworkLosses)
        assertEquals(losses, HarnessControl.openVpnReconnects)
        assertFalse("a loss consumed the failure retry", registry().snapshot()!!.recoveryConsumed)
        assertEquals(VpnStatus.CONNECTED, bridge.quickTileState().status)
    }

    /**
     * Without the callback: up to 3 s for each of [completed] looks of the bridge (its poll while
     * OpenVPN is active, an interruption's own) to end. A look reads activeNetworkInfo last and holds
     * recoveryLock throughout: a change made after one wait is compared with that look, never read
     * inside it, and the look awaited by a second wait began after a change made before the first.
     * Not asserted here: a bridge that never looks fails on the loss it never follows.
     */
    private fun awaitNetworkLook(completed: Int = 1) = repeat(completed) {
        val answered = ConnectivityManager.defaultReads.get()
        val deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(3)
        while (ConnectivityManager.defaultReads.get() == answered && System.nanoTime() < deadline) Thread.sleep(10)
    }

    private fun engine() = com.fuzevpn.android.openvpn.OpenVpnController.current!!

    private companion object {
        const val ACCOUNT = "account-1"
        const val DEVICE = "device-1"
        const val SESSION = """{"access_token":"host-test-token","expires_at":"2099-01-01T00:00:00Z"}"""
        const val EMOJI = "\uD83C\uDF0D"
        const val PUBLICATIONS = 20
        const val OPENVPN_CONNECTED = "connected/openvpn/null"
        const val WIREGUARD_CONNECTED = "connected/wireguard/null"
        const val RECONNECTING = "connecting/openvpn/openvpn_reconnecting"
        // Tile renders are "state:subtitle" (string ids of fakes/BuildConfig.kt).
        const val TILE_BUSY = "0:string#3"
        const val TILE_CONNECTED = "2:string#4[WireGuard, Paris]"
        const val TILE_DISCONNECTING = "0:string#8"
        const val TILE_SETUP = "1:string#9"
        const val TILE_INTERRUPTED = "1:string#10[WireGuard]"
        const val TILE_READY = "1:string#11[WireGuard, Paris]"
        val ACCEPTED_LABELS = mapOf(
            "96 characters" to "P".repeat(96), "48 emoji" to EMOJI.repeat(48), "no-break space" to "Paris\u00A01",
            "accents" to "S\u00E3o Paulo \u2014 Z\u00FCrich", "zero-width space" to "Paris\u00A0\u200B\u00AD",
        )
        val REFUSED_LABELS = mapOf(
            "97 characters" to "P".repeat(97), "16 384 characters" to "P".repeat(16_384), "tab" to "Paris\t02",
            "line feed" to "Paris\n03", "NEL" to "Paris\u008504", "DEL" to "Paris\u007F05", "C1" to "Paris\u009F06",
            "NUL" to "Paris\u000007", "49 emoji" to EMOJI.repeat(49), "empty" to "", "spaces" to "   ",
            "tab only" to "\t", "line feed only" to "\n", "NEL only" to "\u0085", "ideographic space" to "\u3000",
            "no-break space only" to "\u00A0", "spaces around NEL" to " \u0085 ",
        )
    }
}
