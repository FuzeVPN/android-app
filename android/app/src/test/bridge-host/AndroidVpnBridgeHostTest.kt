package com.fuzevpn.android

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.VpnService
import android.os.UserManager
import android.service.quicksettings.TileService
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.Collections
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

internal class EventProbe : EventChannel.EventSink {
    val events: MutableList<String> = Collections.synchronizedList(mutableListOf())
    val terminations: MutableList<Map<*, *>> = Collections.synchronizedList(mutableListOf())
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

    /**
     * A tile click waits in its reads while a restore is admitted and waits for
     * the network; a key request then holds the mutex, the network returns, the
     * restore queues on the mutex and the tile queues behind it.
     */
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

    private fun settleSystemJob() {
        val job = AndroidVpnBridge::class.java.getDeclaredField("systemStartJob").apply { isAccessible = true }
            .get(bridge) as kotlinx.coroutines.Job?
        if (job != null) kotlinx.coroutines.runBlocking { kotlinx.coroutines.withTimeout(20_000) { job.join() } }
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

    private fun eventually(what: String, condition: () -> Boolean) {
        val deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(8)
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

    private companion object {
        const val ACCOUNT = "account-1"
        const val DEVICE = "device-1"
        const val SESSION = """{"access_token":"host-test-token","expires_at":"2099-01-01T00:00:00Z"}"""
        const val EMOJI = "\uD83C\uDF0D"
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
