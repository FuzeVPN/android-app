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
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel

internal data class QuickTileSnapshot(
    val state: VpnState,
    val profile: QuickTileProfile?,
    val canConnect: Boolean,
)

/** User-controlled reconnect/disconnect entry point with no API access. */
class VpnQuickTileService : TileService() {
    private val tileScope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var destroyed = false
    private val snapshotLoader by lazy {
        QuickTileSnapshotLoader(
            scope = tileScope,
            load = {
                val runtime = AndroidVpnBridge.obtain(applicationContext)
                try {
                    runtime.quickTileSnapshot()
                } catch (_: Exception) {
                    QuickTileSnapshot(runtime.quickTileState(), null, false)
                }
            },
            deliver = ::renderTile,
        )
    }

    override fun onStartListening() {
        super.onStartListening()
        snapshotLoader.startListening()
    }

    override fun onStopListening() {
        snapshotLoader.stopListening()
        super.onStopListening()
    }

    override fun onDestroy() {
        destroyed = true
        snapshotLoader.stopListening()
        tileScope.cancel()
        super.onDestroy()
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
                if (destroyed) return@toggleFromQuickTile
                when {
                    failureCode == QUICK_TILE_OPEN_SETTINGS -> openVpnSettings()
                    quickTileFailureOpensApplication(failureCode) -> openApplication()
                    else -> updateTile()
                }
            }
        }
    }

    private fun markBusy() {
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
        val tile = qsTile ?: return
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
        /** Never throws: a tile refresh must not break a VPN state publication. */
        internal fun requestUpdate(context: Context) {
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
