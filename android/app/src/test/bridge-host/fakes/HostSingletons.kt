package com.fuzevpn.android

import android.content.Context
import android.content.Intent

/** Notification and VPN host singletons: they only record what the bridge asks. */
internal object WireGuardForegroundNotifier {
    fun initialize() {}
    fun startProtocol(context: Context, selected: VpnProtocol?, newStatus: VpnStatus,
                      isReconnecting: Boolean = false, requiresAction: Boolean = false) {
        HarnessControl.notifications += "startProtocol($selected,$newStatus,reconnecting=$isReconnecting,action=$requiresAction)"
        if (newStatus == VpnStatus.ERROR) HarnessControl.errorNotificationFailure?.let { throw VpnNativeException(it) }
    }
    fun start(context: Context, initialStatus: VpnStatus) { HarnessControl.notifications += "start($initialStatus)" }
    fun update(context: Context, newStatus: VpnStatus, isReconnecting: Boolean = false, isWaitingForNetwork: Boolean = false) {
        HarnessControl.notifications += "update($newStatus)"
    }
    fun stop(context: Context) { HarnessControl.notifications += "stop" }
    fun relocalize() { HarnessControl.notifications += "relocalize" }
}

internal object SharedVpnHost {
    @Volatile var flags: Pair<Boolean?, Boolean?> = false to false
    fun systemFlags(): Pair<Boolean?, Boolean?> = flags
    fun userStopOpensSettings(): Boolean = userStopRequiresSettings(systemFlags().first)
    fun settingsIntent() = Intent(android.provider.Settings.ACTION_VPN_SETTINGS)
    fun stopIfNotPermanent() {}
    fun start(context: Context) {}
}

internal object OpenVpnService {
    internal fun start(context: Context, reconnecting: Boolean = false) {}
    internal fun update(context: Context, status: VpnStatus, reconnecting: Boolean = false) {}
    internal fun stop(context: Context) {}
    internal fun awaitReady(timeoutMillis: Long): Boolean = true
}

/** Same tile contract as the real setLocale: persist, then request a tile refresh. */
class VpnForegroundService {
    companion object {
        internal fun setLocale(context: Context, languageCode: String?) {
            if (languageCode != null && NativeLocalePolicy.canonicalTag(languageCode) == null) {
                throw VpnNativeException("invalid_arguments")
            }
            HarnessControl.locales += languageCode
            VpnQuickTileService.requestUpdate(context)
        }
        internal fun localizedContext(context: Context): Context = context
    }
}

internal object DiagnosticsMetadata {
    fun collect(context: Context): Map<String, Any> = emptyMap()
}
