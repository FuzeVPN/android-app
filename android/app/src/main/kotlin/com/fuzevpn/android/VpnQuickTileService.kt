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

/** User-controlled reconnect/disconnect entry point with no API access. */
class VpnQuickTileService : TileService() {
    override fun onStartListening() {
        super.onStartListening()
        updateTile()
    }

    override fun onClick() {
        super.onClick()
        unlockAndRun {
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
            if (transitional) {
                updateTile()
                return@unlockAndRun
            }
            if (state.status != VpnStatus.CONNECTED && !runtime.canQuickTileConnect()) {
                openApplication()
                return@unlockAndRun
            }
            markBusy()
            runtime.toggleFromQuickTile { failureCode ->
                if (quickTileFailureOpensApplication(failureCode)) {
                    openApplication()
                } else {
                    updateTile()
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

    private fun updateTile() {
        val tile = qsTile ?: return
        val runtime = AndroidVpnBridge.obtain(applicationContext)
        val state = runtime.quickTileState()
        val profile = runtime.quickTileProfileSnapshot()
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
                    if (state.messageCode in setOf("openvpn_reconnecting", "system_vpn_restoring")) R.string.vpn_tile_reconnecting
                    else R.string.vpn_tile_connecting,
                    protocolLabel,
                )
            VpnStatus.DISCONNECTING -> localized.getString(R.string.vpn_tile_disconnecting)
            VpnStatus.ERROR -> if (profile == null) {
                localized.getString(R.string.vpn_tile_setup_required)
            } else {
                localized.getString(R.string.vpn_tile_interrupted, protocolLabel)
            }
            VpnStatus.IDLE -> if (profile == null || !runtime.canQuickTileConnect()) {
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
            VpnStatus.CONNECTING, VpnStatus.DISCONNECTING -> Tile.STATE_UNAVAILABLE
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
    }

    @SuppressLint("StartActivityAndCollapseDeprecated")
    private fun openVpnSettings() {
        val settings = Intent(Settings.ACTION_VPN_SETTINGS)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
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
    }

    companion object {
        internal fun requestUpdate(context: Context) {
            requestListeningState(
                context.applicationContext,
                ComponentName(context, VpnQuickTileService::class.java),
            )
        }
    }
}
