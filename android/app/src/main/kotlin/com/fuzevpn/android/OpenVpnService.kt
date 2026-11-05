package com.fuzevpn.android

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.VpnService
import android.os.Build
import android.os.ParcelFileDescriptor
import android.util.Log
import com.fuzevpn.android.openvpn.OpenVpnNative
import org.json.JSONObject
import java.io.File
import java.util.concurrent.atomic.AtomicBoolean

/** OpenVPN TUN adapter. The shared WireGuard service is the sole VpnService. */
internal object OpenVpnService {
    private val tunEstablishmentClaimed = AtomicBoolean(false)
    private val retainedTun = RetainedTun<ParcelFileDescriptor, ValidatedTun>()
    // Set by a recovery restart only: an explicit connect or a restore always establishes.
    @Volatile private var recoveryMayReuse = false
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
                tunMtu(plan.optInt("mtu", DEFAULT_MTU)),
            )
            val service = SharedVpnHost.current() ?: return TUN_PERMISSION_REVOKED
            service.setUnderlyingNetworks(null)
            if (recoveryMayReuse) reuseRetainedTun(validated, service)?.let { return it }
            val builder = service.Builder().setSession(session).setMtu(validated.mtu).setBlocking(true)
            validated.addresses.forEach { builder.addAddress(it.host, it.prefix) }
            validated.routes.forEach { builder.addRoute(it.host, it.prefix) }
            validated.dns.forEach { builder.addDnsServer(it) }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) builder.setMetered(false)
            val tun = builder.establish() ?: return TUN_ESTABLISH_RETURNED_NULL
            // Core owns and closes the fd it receives. This duplicate keeps the interface, routes
            // and DNS while Core is stopped for a recovery, so packets are dropped, never sent
            // outside the tunnel. establish() has already replaced the previous interface, so
            // the older duplicate closes now.
            val kept = try { tun.dup() } catch (_: Exception) { null }
            // A failed duplicate keeps the previous behaviour: no interface while Core is stopped.
            if (kept != null) retainedTun.replace(kept, validated, service) else retainedTun.release()
            tun.detachFd()
        } catch (_: SecurityException) {
            TUN_PERMISSION_REVOKED
        } catch (_: IllegalArgumentException) {
            TUN_PLAN_REJECTED
        } catch (_: Exception) {
            TUN_ESTABLISH_EXCEPTION
        }
    }


    // Keeps the retained TUN: a recovery restarts here before its establish() replaces or reuses it.
    internal fun start(context: Context, reconnecting: Boolean = false) {
        tunEstablishmentClaimed.set(false)
        recoveryMayReuse = reconnecting
        WireGuardForegroundNotifier.startProtocol(context, VpnProtocol.OPENVPN, VpnStatus.CONNECTING, reconnecting)
        SharedVpnHost.start(context)
    }

    internal fun update(context: Context, status: VpnStatus, reconnecting: Boolean = false) =
        WireGuardForegroundNotifier.startProtocol(context, VpnProtocol.OPENVPN, status, reconnecting)

    // The engine stop was not confirmed: see OpenVpnController.stopCurrentLocked.
    internal fun releaseRetainedTun() = retainedTun.release()

    // Releasing an engine must never destroy a service now used by its successor.
    internal fun stop(context: Context) {
        tunEstablishmentClaimed.set(false)
        recoveryMayReuse = false
        retainedTun.release()
    }

    // On Android 11 to 16, every establish() removes VPN addresses (the netmask change on the new
    // tunN, then the old tunN going away) and netd aborts each TCP connection bound to them
    // (ECONNABORTED): a download dies when a recovery restarts Core. With an unchanged plan on
    // the same host, Core gets a copy of the interface Android still routes instead; anything
    // else establishes as before.
    private fun reuseRetainedTun(plan: ValidatedTun, service: VpnService): Int? {
        val routed = routedVpnInterfaces(service)
        var declined = if (routed.isEmpty()) "no VPN network listed" else retainedTun.refusal(plan, service)
        val fd = if (declined != null) null else retainedTun.reuse(plan, service) { held ->
            // Only the very interface Android still routes as the VPN: one it reset or replaced
            // (a revocation during the recovery) is never handed to Core. The held copy keeps
            // that device, and so its name, to this app.
            val name = tunInterfaceName(held.fd)
            if (name == null || name !in routed) {
                declined = "interface ${name ?: "unreadable"} not among ${routed.sorted()}"
                return@reuse null
            }
            // Core gets its own descriptor and closes it; the held one is never given away. No
            // flag to restore: Core's asio makes the descriptor non-blocking on its first read.
            held.dup().detachFd()
        }
        // Fixed text and interface names only: the device proof of this path.
        Log.i("FuzeVpnBridge", if (fd != null) "OpenVPN TUN reused" else "OpenVPN TUN not reused: ${declined ?: "copy failed"}")
        return fd
    }

    // Interfaces of the VPN networks Android routes now; empty when none can be read.
    @Suppress("DEPRECATION")
    private fun routedVpnInterfaces(service: VpnService): Set<String> = try {
        val connectivity = service.getSystemService(ConnectivityManager::class.java)
        connectivity.allNetworks.mapNotNullTo(mutableSetOf()) { network ->
            if (isVpnNetwork(connectivity, network)) connectivity.getLinkProperties(network)?.interfaceName else null
        }
    } catch (_: Throwable) {
        emptySet()
    }

    // Android 11 can leave this process's ConnectivityManager on package android (see
    // AndroidVpnBridge.physicalCallbackRegistered): capabilities then throw, the legacy type does not.
    @Suppress("DEPRECATION")
    private fun isVpnNetwork(connectivity: ConnectivityManager, network: Network): Boolean = try {
        connectivity.getNetworkCapabilities(network)?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true
    } catch (_: SecurityException) {
        connectivity.getNetworkInfo(network)?.type == ConnectivityManager.TYPE_VPN
    }

    // The ioctl first: a release build is not dumpable, and on Android 11 its own
    // /proc/self/fdinfo is then unreadable (campaign vm31h). fdinfo stays the fallback.
    private fun tunInterfaceName(fd: Int): String? = OpenVpnNative.tunInterfaceName(fd)
        ?: try { tunInterfaceFromFdinfo(File("/proc/self/fdinfo/$fd").readText()) } catch (_: Throwable) { null }

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

    // OpenVPN over UDP adds at least 52 bytes per packet, more on reduced-MTU
    // links. With a 1500-byte TUN, TCP sent packets that vanished inside the
    // tunnel without any ICMP reply (1432 bytes and above, COLD-RESTORE-ONLINE-06GB).
    // Cap the TUN so TCP segments fit; a lower server-pushed MTU is kept.
    internal fun tunMtu(requested: Int): Int = minOf(requested, MAX_TUN_MTU)

    private const val DEFAULT_MTU = 1500
    private const val MAX_TUN_MTU = 1400
    private const val TUN_ALREADY_ESTABLISHED = -2
    private const val TUN_PLAN_REJECTED = -3
    private const val TUN_PERMISSION_REVOKED = -7
    private const val TUN_ESTABLISH_RETURNED_NULL = -8
    private const val TUN_ESTABLISH_EXCEPTION = -9
}
