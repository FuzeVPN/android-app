package com.fuzevpn.android

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.util.Log
import java.lang.ref.WeakReference
import java.util.concurrent.atomic.AtomicLong
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

internal data class QuickTileSnapshot(
    val state: VpnState,
    val profile: QuickTileProfile?,
    val canConnect: Boolean,
    /** Tile revision requested before this snapshot read any state. */
    val revision: Long = 0L,
)

/** Debug builds only: tile states and revisions, never account or location data. */
private inline fun tileDebug(message: () -> String) {
    if (BuildConfig.DEBUG) Log.d("FuzeVpnTile", message())
}

/** User-controlled reconnect/disconnect entry point with no API access. */
class VpnQuickTileService : TileService() {
    private val tileScope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var destroyed = false
    // Main thread only. SystemUI drops a START while this active tile listens
    // and stops it after each updateTile, so a publication can miss every read
    // (QT-REVOKE-OVPN-01): each STOP compares the rendered and requested revisions.
    private var renderedRevision = -1L
    // A busy render stands for the requests made before its click; a snapshot
    // read before it would bring back the clickable pre-click state (double tap).
    private var busyRevision = -1L
    private val snapshotLoader by lazy {
        QuickTileSnapshotLoader(
            scope = tileScope,
            load = {
                // Captured before any read: a later publication is newer than this snapshot.
                val requested = requestedRevision.get()
                val runtime = AndroidVpnBridge.obtain(applicationContext)
                val snapshot = try {
                    runtime.quickTileSnapshot()
                } catch (_: Exception) {
                    QuickTileSnapshot(runtime.quickTileState(), null, false)
                }
                snapshot.copy(revision = requested)
            },
            deliver = ::renderTile,
        )
    }

    override fun onStartListening() {
        super.onStartListening()
        listeningInstance = WeakReference(this)
        tileDebug { "start listening" }
        snapshotLoader.startListening()
    }

    override fun onStopListening() {
        snapshotLoader.stopListening()
        if (listeningInstance?.get() === this) listeningInstance = null
        tileDebug { "stop listening rendered=$renderedRevision requested=${requestedRevision.get()}" }
        if (!destroyed) reconcile()
        super.onStopListening()
    }

    override fun onDestroy() {
        destroyed = true
        snapshotLoader.stopListening()
        if (listeningInstance?.get() === this) listeningInstance = null
        reconcile()
        tileScope.cancel()
        super.onDestroy()
    }

    /**
     * Never throws. A request this instance missed opens a new listening
     * window; it cannot loop, since each START reads the latest revision.
     */
    private fun reconcile() {
        if (renderedRevision < requestedRevision.get()) requestListening(applicationContext)
    }

    /** Any thread: reloads on the main thread, never on a destroyed or stopped instance. */
    private fun refreshWhileListening() {
        tileScope.launch(Dispatchers.Main) {
            if (!destroyed && listeningInstance?.get() === this@VpnQuickTileService &&
                renderedRevision < requestedRevision.get()) updateTile()
        }
    }

    override fun onClick() {
        super.onClick()
        unlockAndRun {
            if (destroyed) return@unlockAndRun
            val runtime = AndroidVpnBridge.obtain(applicationContext)
            val state = runtime.quickTileState()
            // An active (or Android 8–9 unverifiable) permanent VPN cannot be stopped by
            // the app. Check before the transition guard so the user can cancel an in-flight
            // connection through Android's own VPN settings.
            if (state.status in setOf(
                    VpnStatus.CONNECTED,
                    VpnStatus.AUTHORIZING,
                    VpnStatus.PREPARING,
                    VpnStatus.CONNECTING,
                    VpnStatus.DISCONNECTING,
                ) && SharedVpnHost.userStopOpensSettings()) {
                openVpnSettings()
                return@unlockAndRun
            }
            val transitional = state.status in setOf(
                VpnStatus.AUTHORIZING,
                VpnStatus.PREPARING,
                VpnStatus.CONNECTING,
                VpnStatus.DISCONNECTING,
            )
            if (transitional && !state.isWireGuardRecovery) {
                updateTile()
                return@unlockAndRun
            }
            markBusy()
            // The bridge captures this click's request epoch before dispatching
            // its storage checks; those checks must never block the UI thread.
            runtime.toggleFromQuickTile { failureCode ->
                if (!destroyed) when {
                    failureCode == QUICK_TILE_OPEN_SETTINGS -> openVpnSettings()
                    quickTileFailureOpensApplication(failureCode) -> openApplication()
                }
                // SystemUI stopped the tile after the busy render, so updateTile()
                // would do nothing: every outcome, also a refusal that published
                // nothing, requests the bridge state in place of the busy render.
                requestUpdate(applicationContext)
            }
        }
    }

    private fun markBusy() {
        // Takes the current revision instead of resetting it: the STOP after
        // this render re-requests only for a later publication, never the
        // clickable pre-click state while the click is being processed.
        busyRevision = requestedRevision.get()
        renderedRevision = busyRevision
        val localized = VpnForegroundService.localizedContext(this)
        qsTile?.apply {
            state = Tile.STATE_UNAVAILABLE
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                subtitle = localized.getString(R.string.vpn_tile_working)
            }
            updateTile()
        }
    }

    private fun updateTile() = snapshotLoader.refresh()

    private fun renderTile(snapshot: QuickTileSnapshot) {
        // Read before the click: the busy render stays until a later request,
        // and the rendered revision never moves back to it, even without a tile.
        if (snapshot.revision <= busyRevision) return
        // Without a tile nothing can be drawn, and another START would not change that.
        val tile = qsTile ?: run { renderedRevision = snapshot.revision; return }
        val state = snapshot.state
        val profile = snapshot.profile
        val localized = VpnForegroundService.localizedContext(this)
        val protocol = state.protocol ?: profile?.protocol
        val location = state.locationName ?: profile?.locationName
        val protocolLabel = when (protocol) {
            VpnProtocol.WIREGUARD -> "WireGuard"
            VpnProtocol.OPENVPN -> "OpenVPN"
            null -> localized.getString(R.string.vpn_notification_title)
        }
        val detail = when (state.status) {
            VpnStatus.CONNECTED -> localized.getString(
                R.string.vpn_tile_connected,
                protocolLabel,
                location.orEmpty(),
            )
            VpnStatus.AUTHORIZING, VpnStatus.PREPARING, VpnStatus.CONNECTING ->
                localized.getString(
                    if (state.messageCode == "wireguard_waiting_network") R.string.vpn_tile_waiting_network
                    else if (state.isWireGuardRecovery || state.messageCode in setOf("openvpn_reconnecting", "system_vpn_restoring")) R.string.vpn_tile_reconnecting
                    else R.string.vpn_tile_connecting,
                    protocolLabel,
                )
            VpnStatus.DISCONNECTING -> localized.getString(R.string.vpn_tile_disconnecting)
            VpnStatus.ERROR -> if (profile == null) {
                localized.getString(R.string.vpn_tile_setup_required)
            } else {
                localized.getString(R.string.vpn_tile_interrupted, protocolLabel)
            }
            VpnStatus.IDLE -> if (profile == null || !snapshot.canConnect) {
                localized.getString(R.string.vpn_tile_setup_required)
            } else {
                localized.getString(
                    R.string.vpn_tile_ready,
                    protocolLabel,
                    location.orEmpty(),
                )
            }
        }
        tile.label = localized.getString(R.string.vpn_tile_label)
        tile.state = when (state.status) {
            VpnStatus.CONNECTED -> Tile.STATE_ACTIVE
            VpnStatus.AUTHORIZING, VpnStatus.PREPARING,
            VpnStatus.CONNECTING, VpnStatus.DISCONNECTING ->
                if (state.isWireGuardRecovery) Tile.STATE_ACTIVE else Tile.STATE_UNAVAILABLE
            VpnStatus.IDLE, VpnStatus.ERROR -> Tile.STATE_INACTIVE
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) tile.subtitle = detail
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) tile.stateDescription = detail
        tile.updateTile()
        renderedRevision = snapshot.revision
        tileDebug { "render status=${state.status} revision=${snapshot.revision}" }
    }

    @SuppressLint("StartActivityAndCollapseDeprecated")
    private fun openApplication() {
        val launch = packageManager.getLaunchIntentForPackage(packageName)
            ?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
            ?: return
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                val pending = PendingIntent.getActivity(
                    this,
                    41,
                    launch,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                )
                startActivityAndCollapse(pending)
            } else {
                @Suppress("DEPRECATION")
                startActivityAndCollapse(launch)
            }
        } catch (_: RuntimeException) {
            updateTile()
        }
    }

    @SuppressLint("StartActivityAndCollapseDeprecated")
    private fun openVpnSettings() {
        val settings = Intent(Settings.ACTION_VPN_SETTINGS)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        // Some devices have no VPN settings activity (Settings.ACTION_VPN_SETTINGS).
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                val pending = PendingIntent.getActivity(
                    this,
                    42,
                    settings,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                )
                startActivityAndCollapse(pending)
            } else {
                @Suppress("DEPRECATION")
                startActivityAndCollapse(settings)
            }
        } catch (_: RuntimeException) {
            updateTile()
        }
    }

    companion object {
        private val requestedRevision = AtomicLong()
        // Set and cleared on the main thread; weak, a service must not leak.
        @Volatile private var listeningInstance: WeakReference<VpnQuickTileService>? = null

        /** Never throws: a tile refresh must not break a VPN state publication. */
        internal fun requestUpdate(context: Context) {
            // Every caller changed its state first, so a load that captures
            // this revision reads that state.
            val revision = requestedRevision.incrementAndGet()
            tileDebug { "request update revision=$revision" }
            requestListening(context)
            // SystemUI drops this START while the tile listens, and some
            // SystemUIs (Android 17 Compose QS, OEMs) never send the STOP that
            // reconciles it: the listening instance reads the update itself.
            listeningInstance?.get()?.refreshWhileListening()
        }

        private fun requestListening(context: Context) {
            try {
                requestListeningState(
                    context.applicationContext,
                    ComponentName(context, VpnQuickTileService::class.java),
                )
            } catch (_: RuntimeException) {
                // Android 13 before QPR3 throws IllegalArgumentException for a
                // process outside the current user (C2-02); the tile then
                // refreshes on its next onStartListening.
            }
        }
    }
}
