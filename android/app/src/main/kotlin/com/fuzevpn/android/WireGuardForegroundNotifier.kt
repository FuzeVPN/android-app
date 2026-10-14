package com.fuzevpn.android

import android.content.Context
import java.lang.reflect.InvocationHandler
import java.lang.reflect.Method
import java.lang.reflect.Proxy

/**
 * Connects the audited WireGuard AAR's real VpnService to the application's
 * localized notification. Reflection keeps debug builds compatible with the
 * untouched official Maven AAR; release builds fail closed if the audited AAR
 * does not expose the reviewed foreground-service API.
 */
internal object WireGuardForegroundNotifier {
    @Volatile
    private var status = VpnStatus.PREPARING
    @Volatile private var protocol: VpnProtocol? = null
    @Volatile private var reconnecting = false
    @Volatile private var actionRequired = false
    @Volatile private var waitingForNetwork = false

    @Volatile
    private var patchedApi: PatchedApi? = null

    // Keep the proxy reachable independently of the third-party static field.
    // This also makes its lifecycle explicit for security review.
    @Volatile
    private var notificationFactory: Any? = null

    fun initialize() = installPatchedApi()

    fun startProtocol(context: Context, selected: VpnProtocol?, newStatus: VpnStatus,
                      isReconnecting: Boolean = false, requiresAction: Boolean = false) {
        protocol = selected
        status = newStatus
        reconnecting = isReconnecting
        actionRequired = requiresAction
        waitingForNetwork = false
        if (BuildConfig.USE_PATCHED_WIREGUARD_AAR) {
            installPatchedApi()
            refreshPatchedNotification()
        }
    }

    fun start(context: Context, initialStatus: VpnStatus) {
        protocol = VpnProtocol.WIREGUARD
        reconnecting = false
        actionRequired = false
        waitingForNetwork = false
        status = initialStatus
        if (useCompanionService()) {
            VpnForegroundService.start(context, VpnProtocol.WIREGUARD, initialStatus)
            return
        }
        installPatchedApi()
        refreshPatchedNotification()
    }

    fun update(context: Context, newStatus: VpnStatus,
               isReconnecting: Boolean = false, isWaitingForNetwork: Boolean = false) {
        status = newStatus
        reconnecting = isReconnecting
        waitingForNetwork = isWaitingForNetwork
        if (useCompanionService()) {
            VpnForegroundService.update(context, VpnProtocol.WIREGUARD, newStatus,
                isReconnecting, isWaitingForNetwork)
            return
        }
        refreshPatchedNotification()
    }

    fun stop(context: Context) {
        if (useCompanionService()) {
            VpnForegroundService.stop(context)
        }
        // The common host is released only by the bridge after confirmed stop.
    }

    fun relocalize() {
        // A language can be chosen before the first connection. In that case
        // no WireGuard service exists yet; its initial notification will read
        // the stored locale when the user later connects.
        if (BuildConfig.USE_PATCHED_WIREGUARD_AAR && patchedApi != null) {
            refreshPatchedNotification()
        }
    }

    private fun useCompanionService() = WireGuardRuntimePolicy.useCompanionService(
        BuildConfig.BUILD_TYPE,
        BuildConfig.USE_PATCHED_WIREGUARD_AAR,
    )

    private fun installPatchedApi() {
        if (patchedApi != null) return
        synchronized(this) {
            if (patchedApi != null) return
            try {
                val backend = Class.forName(GO_BACKEND_CLASS)
                val factoryType = Class.forName(FACTORY_CLASS)
                val vpnService = Class.forName(VPN_SERVICE_CLASS)
                val factory = Proxy.newProxyInstance(
                    factoryType.classLoader,
                    arrayOf(factoryType),
                    NotificationFactoryInvocationHandler,
                )
                backend.getMethod("setForegroundNotificationFactory", factoryType)
                    .invoke(null, factory)
                notificationFactory = factory
                patchedApi = PatchedApi(vpnService.getMethod("refreshForegroundNotification"))
            } catch (error: Exception) {
                throw VpnNativeException("wireguard_foreground_service_unavailable", error)
            }
        }
    }

    private fun refreshPatchedNotification() {
        val api = patchedApi
            ?: throw VpnNativeException("wireguard_foreground_service_unavailable")
        try {
            api.refresh.invoke(null)
        } catch (error: Exception) {
            throw VpnNativeException("wireguard_foreground_service_unavailable", error)
        }
    }

    private data class PatchedApi(val refresh: Method)

    private object NotificationFactoryInvocationHandler : InvocationHandler {
        override fun invoke(proxy: Any, method: Method, arguments: Array<out Any?>?): Any? = when (method.name) {
            "create" -> (arguments?.firstOrNull() as? Context)?.let { context ->
                VpnForegroundService.notificationFor(context, protocol, status, reconnecting, actionRequired, waitingForNetwork)
            }
            "toString" -> "FuzeVPN WireGuard foreground notification factory"
            "hashCode" -> System.identityHashCode(proxy)
            "equals" -> proxy === arguments?.firstOrNull()
            else -> null
        }
    }

    private const val GO_BACKEND_CLASS = "com.wireguard.android.backend.GoBackend"
    private const val FACTORY_CLASS = "com.wireguard.android.backend.GoBackend\$ForegroundNotificationFactory"
    private const val VPN_SERVICE_CLASS = "com.wireguard.android.backend.GoBackend\$VpnService"
}
