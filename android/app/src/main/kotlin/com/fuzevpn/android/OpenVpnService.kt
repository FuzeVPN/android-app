package com.fuzevpn.android

import android.content.Context
import android.os.Build
import org.json.JSONObject
import java.util.concurrent.atomic.AtomicBoolean

/** OpenVPN TUN adapter. The shared WireGuard service is the sole VpnService. */
internal object OpenVpnService {
    private val tunEstablishmentClaimed = AtomicBoolean(false)
    internal fun establishFromPlan(planJson: String, network: TunnelNetworkSpec = TunnelNetworkSpec.legacyIpv4()): Int {
        if (!tunEstablishmentClaimed.compareAndSet(false, true)) return TUN_ALREADY_ESTABLISHED
        return try {
            val plan = JSONObject(planJson)
            // Core's session label is server-controlled. Keep system UI and
            // diagnostics free of remote profile text by using a fixed local
            // name instead of displaying that value.
            val session = "FuzeVPN OpenVPN"
            val validated = network.validateTun(
                plan.tunStrings("addresses"), plan.tunStrings("routes"), plan.tunStrings("dns"),
                plan.optInt("mtu", DEFAULT_MTU),
            )
            val service = SharedVpnHost.current() ?: return TUN_PERMISSION_REVOKED
            val builder = service.Builder().setSession(session).setMtu(validated.mtu).setBlocking(true)
            validated.addresses.forEach { builder.addAddress(it.host, it.prefix) }
            validated.routes.forEach { builder.addRoute(it.host, it.prefix) }
            validated.dns.forEach { builder.addDnsServer(it) }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) builder.setMetered(false)
            service.setUnderlyingNetworks(null)
            builder.establish()?.detachFd() ?: TUN_ESTABLISH_RETURNED_NULL
        } catch (_: SecurityException) {
            TUN_PERMISSION_REVOKED
        } catch (_: IllegalArgumentException) {
            TUN_PLAN_REJECTED
        } catch (_: Exception) {
            TUN_ESTABLISH_EXCEPTION
        }
    }


    internal fun start(context: Context, reconnecting: Boolean = false) {
        tunEstablishmentClaimed.set(false)
        WireGuardForegroundNotifier.startProtocol(context, VpnProtocol.OPENVPN, VpnStatus.CONNECTING, reconnecting)
        SharedVpnHost.start(context)
    }

    internal fun update(context: Context, status: VpnStatus, reconnecting: Boolean = false) =
        WireGuardForegroundNotifier.startProtocol(context, VpnProtocol.OPENVPN, status, reconnecting)

    // Releasing an engine must never destroy a service now used by its successor.
    internal fun stop(context: Context) {
        tunEstablishmentClaimed.set(false)
    }

    internal fun establishForCore(planJson: String, network: TunnelNetworkSpec = TunnelNetworkSpec.legacyIpv4()): Int =
        establishFromPlan(planJson, network)

    internal fun protectForCore(socketFd: Int): Boolean =
        socketFd >= 0 && SharedVpnHost.current()?.protect(socketFd) == true

    internal fun awaitReady(timeoutMillis: Long): Boolean {
        val end = android.os.SystemClock.elapsedRealtime() + timeoutMillis
        while (SharedVpnHost.current() == null && android.os.SystemClock.elapsedRealtime() < end) {
            Thread.sleep(10)
        }
        return SharedVpnHost.current() != null
    }

    private fun JSONObject.tunStrings(key: String): List<String> {
        val values = getJSONArray(key)
        require(values.length() in 1..32)
        return List(values.length()) { values.getString(it) }
    }

    private const val DEFAULT_MTU = 1500
    private const val TUN_ALREADY_ESTABLISHED = -2
    private const val TUN_PLAN_REJECTED = -3
    private const val TUN_PERMISSION_REVOKED = -7
    private const val TUN_ESTABLISH_RETURNED_NULL = -8
    private const val TUN_ESTABLISH_EXCEPTION = -9
}
