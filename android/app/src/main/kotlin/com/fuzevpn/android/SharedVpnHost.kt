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
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference

/** One Android TUN owner for both engines. No engine work runs in its callbacks. */
internal object SharedVpnHost {
    private const val BACKEND = "com.wireguard.android.backend.GoBackend"
    private const val LISTENER = "$BACKEND\$HostLifecycleListener"
    @Volatile private var initialized = false
    private var listener: Any? = null
    private val callbackHandler = Handler(Looper.getMainLooper())
    // The host this app last asked to stop, until its onDestroy() ends (see start).
    @Volatile private var stopping: CountDownLatch? = null

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
                    // Android has reset the interface: before anything is posted, a recovery
                    // under way must no longer find a retained TUN to hand to Core.
                    OpenVpnService.releaseRetainedTun()
                    val runtime = AndroidVpnBridge.obtain(context)
                    // A revoked VPN is never restored after a process death: disarm now.
                    val release = runtime.holdProcessRestart()
                    val event = runtime.captureHostLoss()
                    callbackHandler.post {
                        if (event.second) runtime.onVpnHostLost("tun_permission_revoked", event.first, release)
                        else release()
                    }
                    null
                }
                "onHostDestroyed" -> {
                    // Fence the engine request when the loss is signalled. A newly created
                    // Android service does not prove that the old engine has been stopped.
                    OpenVpnService.releaseRetainedTun()
                    val runtime = AndroidVpnBridge.obtain(context)
                    val release = runtime.holdProcessRestart()
                    val event = runtime.captureHostLoss()
                    callbackHandler.post {
                        if (event.second) runtime.onVpnHostLost("vpn_host_destroyed", event.first, release)
                        else release()
                    }
                    // Called at the end of onDestroy(), the readiness already reset: a stop waiting
                    // for it resumes only once this host's loss is captured for its own session.
                    stopping?.countDown()
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

    // The host's onCreate() and onDestroy() run on the main thread and each updates two things in
    // turn: the host it publishes and startForeground() (Android 8 to 11 kill the app when a host
    // is stopped in between), then the host and its readiness, which GoBackend.startHost() reads to
    // start nothing (a start in between is lost). Campaign vm31n met both. So the host is started
    // and stopped on the main thread, where neither runs half-way.
    fun start(context: Context) {
        initialize(context.applicationContext)
        if (!initialized) throw VpnNativeException("vpn_host_unavailable")
        // A running host that this app is not stopping needs no start, as before.
        if (current() != null && stopping.let { it == null || it.count == 0L }) return
        val started = onMainThread(HOST_START_WAIT_MS) {
            Class.forName(BACKEND).getMethod("startHost", Context::class.java).invoke(null, context.applicationContext) == true
        } == true
        if (!started) throw VpnNativeException("vpn_host_unavailable")
    }

    fun stopIfNotPermanent() {
        val destroyed = onMainThread(HOST_STOP_WAIT_MS) { stopIfNotPermanentNow() }
        // A start must not reach the stopping host either: wait for its onDestroy() to end, which
        // then notifies onHostDestroyed. The main thread itself could not see it end.
        if (Looper.myLooper() != Looper.getMainLooper()) destroyed?.await(HOST_STOP_WAIT_MS, TimeUnit.MILLISECONDS)
    }

    private fun stopIfNotPermanentNow(): CountDownLatch? {
        val service = current() ?: return null
        // On Android 8–9 an active system policy cannot be read reliably.
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q || service.isAlwaysOn) return null
        return CountDownLatch(1).also {
            stopping = it
            Class.forName(BACKEND).getMethod("stopHost").invoke(null)
        }
    }

    /**
     * [block] on the main thread; `null` when it threw, or when it had not begun within
     * [timeoutMillis]: it is then cancelled and never runs, so no host is started or stopped after
     * the caller gave up. A block already running is waited for to its end.
     */
    private fun <T> onMainThread(timeoutMillis: Long, block: () -> T): T? {
        if (Looper.myLooper() == Looper.getMainLooper()) return block()
        val state = AtomicInteger(PENDING)
        val result = AtomicReference<Result<T>>()
        val done = CountDownLatch(1)
        callbackHandler.post {
            if (state.compareAndSet(PENDING, RUNNING)) {
                try { result.set(runCatching(block)) } finally { done.countDown() }
            }
        }
        if (!done.await(timeoutMillis, TimeUnit.MILLISECONDS)) {
            if (state.compareAndSet(PENDING, CANCELLED)) return null
            done.await()
        }
        return result.get()?.getOrNull()
    }

    private const val PENDING = 0
    private const val RUNNING = 1
    private const val CANCELLED = 2

    private const val HOST_START_WAIT_MS = 5_000L
    private const val HOST_STOP_WAIT_MS = 2_000L

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
        // A process that a death while armed left to another component (the tile) restores too.
        SystemVpnResumeSentinel.restoreAfterDeath(this)
    }
}
