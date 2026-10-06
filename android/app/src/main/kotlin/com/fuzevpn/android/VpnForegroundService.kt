package com.fuzevpn.android

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.res.Configuration
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import androidx.core.content.edit
import java.util.Locale

/**
 * Foreground notification service for OpenVPN and the unpatched WireGuard
 * development AAR. The release WireGuard AAR owns the notification directly
 * from GoBackend$VpnService, which also owns the TUN descriptor.
 */
class VpnForegroundService : Service() {
    private var protocol: VpnProtocol? = null
    private var status: VpnStatus = VpnStatus.CONNECTING

    override fun onCreate() {
        super.onCreate()
        running = true
    }

    override fun onDestroy() {
        running = false
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> stopForegroundAndSelf()
            ACTION_START, ACTION_UPDATE, null -> {
                protocol = VpnProtocol.fromWireValue(intent?.getStringExtra(EXTRA_PROTOCOL))
                status = VpnStatus.entries.firstOrNull { it.wireValue == intent?.getStringExtra(EXTRA_STATUS) }
                    ?: VpnStatus.CONNECTING
                showForeground(protocol, status)
            }
            ACTION_RELOCALIZE -> showForeground(protocol, status)
        }
        // Do not restart a tunnel after a process kill: v1 explicitly does
        // not implement always-on/lockdown behavior.
        return START_NOT_STICKY
    }

    private fun showForeground(protocol: VpnProtocol?, status: VpnStatus) {
        ensureChannel(this)
        val notification = notificationFor(this, protocol, status)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE)
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    private fun stopForegroundAndSelf() {
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    companion object {
        const val NOTIFICATION_ID = 10101
        private const val CHANNEL_ID = "fuzevpn_connection"
        private const val ACTION_START = "com.fuzevpn.android.vpn.START"
        private const val ACTION_UPDATE = "com.fuzevpn.android.vpn.UPDATE"
        private const val ACTION_STOP = "com.fuzevpn.android.vpn.STOP"
        private const val ACTION_RELOCALIZE = "com.fuzevpn.android.vpn.RELOCALIZE"
        private const val EXTRA_PROTOCOL = "protocol"
        private const val EXTRA_STATUS = "status"
        private const val LOCALE_PREFERENCES = "fuzevpn.ui"
        private const val LOCALE_PREFERENCE = "notification_language"

        @Volatile
        private var running = false

        internal fun start(context: Context, protocol: VpnProtocol, status: VpnStatus) {
            dispatch(context, ACTION_START, protocol, status)
        }

        internal fun update(context: Context, protocol: VpnProtocol?, status: VpnStatus) {
            dispatch(context, ACTION_UPDATE, protocol, status)
        }

        internal fun stop(context: Context) {
            context.stopService(Intent(context, VpnForegroundService::class.java))
        }

        internal fun setLocale(context: Context, languageCode: String?) {
            val valid = NativeLocalePolicy.canonicalTag(languageCode)
            if (languageCode != null && valid == null) throw VpnNativeException("invalid_arguments")
            context.getSharedPreferences(LOCALE_PREFERENCES, Context.MODE_PRIVATE)
                .edit { putString(LOCALE_PREFERENCE, valid) }
            VpnQuickTileService.requestUpdate(context)
            if (running) {
                context.startService(Intent(context, VpnForegroundService::class.java).setAction(ACTION_RELOCALIZE))
            }
        }

        private fun dispatch(
            context: Context,
            action: String,
            protocol: VpnProtocol?,
            status: VpnStatus,
        ) {
            val intent = Intent(context, VpnForegroundService::class.java)
                .setAction(action)
                .putExtra(EXTRA_PROTOCOL, protocol?.wireValue)
                .putExtra(EXTRA_STATUS, status.wireValue)
            context.startForegroundService(intent)
        }

        internal fun notificationFor(
            context: Context,
            protocol: VpnProtocol?,
            status: VpnStatus,
            reconnecting: Boolean = false,
            actionRequired: Boolean = false,
        ): Notification {
            val localized = localizedContext(context)
            ensureChannel(localized)
            val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
                ?.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            val pendingIntent = launchIntent?.let {
                PendingIntent.getActivity(
                    context,
                    0,
                    it,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                )
            }
            val protocolLabel = when (protocol) {
                VpnProtocol.WIREGUARD -> "WireGuard"
                VpnProtocol.OPENVPN -> "OpenVPN"
                null -> "VPN"
            }
            val detail = if (actionRequired) localized.getString(R.string.vpn_system_action_required) else when (status) {
                VpnStatus.CONNECTED -> localized.getString(R.string.vpn_notification_connected, protocolLabel)
                VpnStatus.CONNECTING, VpnStatus.PREPARING, VpnStatus.AUTHORIZING -> localized.getString(
                    if (reconnecting) R.string.vpn_notification_reconnecting else R.string.vpn_notification_connecting,
                    protocolLabel,
                )
                VpnStatus.DISCONNECTING -> localized.getString(R.string.vpn_notification_disconnecting, protocolLabel)
                VpnStatus.ERROR -> localized.getString(R.string.vpn_notification_interrupted, protocolLabel)
                VpnStatus.IDLE -> localized.getString(R.string.vpn_notification_title)
            }
            return Notification.Builder(context, CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_fuzevpn_notification)
                .setContentTitle(localized.getString(R.string.vpn_notification_title))
                .setContentText(detail)
                .setContentIntent(pendingIntent)
                .setCategory(Notification.CATEGORY_SERVICE)
                .setOngoing(status != VpnStatus.IDLE && status != VpnStatus.ERROR)
                .setShowWhen(false)
                .build()
        }

        private fun ensureChannel(context: Context) {
            val manager = context.getSystemService(NotificationManager::class.java)
            val channel = NotificationChannel(
                CHANNEL_ID,
                context.getString(R.string.vpn_notification_channel),
                NotificationManager.IMPORTANCE_LOW,
            ).apply {
                description = context.getString(R.string.vpn_notification_channel_description)
                setShowBadge(false)
            }
            manager.createNotificationChannel(channel)
        }

        internal fun localizedContext(context: Context): Context {
            val stored = context.getSharedPreferences(LOCALE_PREFERENCES, Context.MODE_PRIVATE)
                .getString(LOCALE_PREFERENCE, null)
            val systemLocales = context.resources.configuration.locales
            val language = NativeLocalePolicy.resolve(
                stored,
                (0 until systemLocales.size()).map { systemLocales[it].toLanguageTag() },
            )
            val configuration = Configuration(context.resources.configuration)
            configuration.setLocale(Locale.forLanguageTag(language))
            return context.createConfigurationContext(configuration)
        }
    }
}
