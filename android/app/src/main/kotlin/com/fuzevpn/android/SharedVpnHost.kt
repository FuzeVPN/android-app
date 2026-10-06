package com.fuzevpn.android

import android.app.Application
import android.content.Context
import android.content.Intent
import android.net.VpnService
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import java.lang.reflect.Proxy

/** One Android TUN owner for both engines. No engine work runs in its callbacks. */
internal object SharedVpnHost {
    private const val BACKEND = "com.wireguard.android.backend.GoBackend"
    private const val LISTENER = "$BACKEND\$HostLifecycleListener"
    @Volatile private var initialized = false
    private var listener: Any? = null
    private val callbackHandler = Handler(Looper.getMainLooper())

    @Synchronized fun initialize(context: Context) {
        if (initialized) return
        if (!BuildConfig.USE_PATCHED_WIREGUARD_AAR) return
        WireGuardForegroundNotifier.initialize()
        val callbackType = Class.forName(LISTENER)
        listener = Proxy.newProxyInstance(callbackType.classLoader, arrayOf(callbackType)) { proxy, method, args ->
            when (method.name) {
                // VpnService invokes these on an Android callback thread. Posting makes the
                // notification non-blocking even if constructing the retained bridge registers
                // system observers for the first time.
                "onSystemStart" -> {
                    val eventHost = current()
                    callbackHandler.post {
                        if (current() === eventHost) AndroidVpnBridge.obtain(context).onSystemVpnStart()
                    }
                    null
                }
                "onHostRevoked" -> {
                    val runtime = AndroidVpnBridge.obtain(context)
                    val event = runtime.captureHostLoss()
                    callbackHandler.post {
                        if (event.second) runtime.onVpnHostLost("tun_permission_revoked", event.first)
                    }
                    null
                }
                "onHostDestroyed" -> {
                    // Fence the engine request when the loss is signalled. A newly created
                    // Android service does not prove that the old engine has been stopped.
                    val runtime = AndroidVpnBridge.obtain(context)
                    val event = runtime.captureHostLoss()
                    callbackHandler.post {
                        if (event.second) runtime.onVpnHostLost("vpn_host_destroyed", event.first)
                    }
                    null
                }
                "toString" -> "FuzeVPN shared VPN host listener"
                "hashCode" -> System.identityHashCode(proxy)
                "equals" -> proxy === args?.firstOrNull()
                else -> null
            }
        }
        Class.forName(BACKEND).getMethod("setHostLifecycleListener", callbackType).invoke(null, listener)
        initialized = true
    }

    fun current(): VpnService? = if (!initialized) null else
        Class.forName(BACKEND).getMethod("getActiveHost").invoke(null) as? VpnService

    fun start(context: Context) {
        initialize(context.applicationContext)
        if (!initialized || Class.forName(BACKEND).getMethod("startHost", Context::class.java)
                .invoke(null, context.applicationContext) != true) throw VpnNativeException("vpn_host_unavailable")
    }

    fun stopIfNotPermanent() {
        val service = current() ?: return
        // On Android 8–9 an active system policy cannot be read reliably.
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q || service.isAlwaysOn) return
        Class.forName(BACKEND).getMethod("stopHost").invoke(null)
    }

    fun systemFlags(): Pair<Boolean?, Boolean?> {
        val service = current()
        return if (service != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            service.isAlwaysOn to service.isLockdownEnabled
        } else null to null
    }

    fun userStopOpensSettings(): Boolean = userStopRequiresSettings(systemFlags().first)

    fun settingsIntent() = Intent(Settings.ACTION_VPN_SETTINGS).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
}

/** Installed before Android creates a VPN service; never starts Flutter. */
class FuzeVpnApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        SharedVpnHost.initialize(this)
        // Build the process-retained controller before Android can start the
        // permanent VPN service. Its constructor registers observers only.
        AndroidVpnBridge.obtain(this)
    }
}
