package android.net

import android.content.Context
import android.content.Intent
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.atomic.AtomicInteger

class Uri(val scheme: String?)
/** A physical network is Wi-Fi in its legacy info, without extra information, unless it is cellular. */
open class Network
/**
 * A cellular network: TYPE_MOBILE in its legacy info, with its APN as extra information (Android 11
 * DataConnection): "internet" for a data network, "ims", "mms" or "supl" for a restricted one.
 */
class CellularNetwork(val apn: String = "internet") : Network()

open class NetworkCapabilities {
    open fun hasCapability(capability: Int): Boolean = true
    open fun hasTransport(transport: Int): Boolean = false
    companion object {
        const val TRANSPORT_VPN = 4
        const val NET_CAPABILITY_INTERNET = 12
        const val NET_CAPABILITY_NOT_RESTRICTED = 13
        const val NET_CAPABILITY_TRUSTED = 14
        const val NET_CAPABILITY_NOT_VPN = 15
    }
}

class NetworkRequest {
    class Builder {
        fun addCapability(capability: Int): Builder = this
        fun setIncludeOtherUidNetworks(include: Boolean): Builder = this
        fun build(): NetworkRequest = NetworkRequest()
    }
}

/**
 * Legacy description of a network for this app. Only CONNECTED is connected: neither SUSPENDED (out
 * of data service, a call without concurrent voice and data), BLOCKED (Doze, Data Saver) nor
 * CONNECTING (a Wi-Fi network listed while it still obtains its address).
 */
open class NetworkInfo(
    val type: Int,
    val detailedState: DetailedState = DetailedState.CONNECTED,
    val extraInfo: String? = null,
) {
    val isConnected: Boolean get() = detailedState == DetailedState.CONNECTED
    enum class DetailedState { CONNECTING, CONNECTED, SUSPENDED, BLOCKED, DISCONNECTED }
}

open class ConnectivityManager {
    open class NetworkCallback {
        open fun onAvailable(network: Network) {}
        open fun onCapabilitiesChanged(network: Network, capabilities: NetworkCapabilities) {}
        open fun onLost(network: Network) {}
    }
    val callbacks: MutableList<NetworkCallback> = mutableListOf()
    open fun registerNetworkCallback(request: NetworkRequest, callback: NetworkCallback) { callbacks += callback }
    open fun getNetworkCapabilities(network: Network?): NetworkCapabilities? =
        if (network != null && network === vpn) vpnCapabilities else NetworkCapabilities()
    /**
     * Legacy info of a listed network: the VPN reports TYPE_VPN, a [CellularNetwork] TYPE_MOBILE with
     * its APN, any other physical one Wi-Fi; a physical one has its state in [states], its APN cleared
     * while BLOCKED. A network no longer listed has no info, as after its teardown.
     */
    open fun getNetworkInfo(network: Network?): NetworkInfo? = synchronized(lock) {
        when {
            network == null -> null
            network === vpn -> NetworkInfo(TYPE_VPN)
            network !in physicalNetworks -> null
            else -> physicalInfo(network)
        }
    }
    /**
     * Android 11 (ConnectivityService.getUnfilteredActiveNetworkState): the system default network,
     * or the underlying one a VPN declares, never the VPN itself. Here [defaultNetwork] while it is
     * listed, else none; each read is counted in [defaultReads] once answered.
     */
    open val activeNetworkInfo: NetworkInfo? get() =
        synchronized(lock) { listedDefault()?.let { physicalInfo(it) } }.also { defaultReads.incrementAndGet() }
    /** Every listed network. */
    open val allNetworks: Array<Network> get() = synchronized(lock) { (physicalNetworks + listOfNotNull(vpn)).toTypedArray() }
    /** The default network of this app: a VPN that covers it, otherwise the physical default one. */
    open val activeNetwork: Network? get() = synchronized(lock) { listedDefault().let { if (vpnCoversApp) vpn ?: it else it } }
    companion object {
        const val TYPE_MOBILE = 0
        const val TYPE_WIFI = 1
        const val TYPE_VPN = 17
        /** The Wi-Fi network listed alone, as the system default, after [reset]. */
        val physical = Network()
        /** A cellular data network (APN "internet"), listed once a test adds it to [physicalNetworks]. */
        val cellular: Network = CellularNetwork()
        /** Physical networks listed, in no meaningful order: a test removes one to make it vanish. */
        val physicalNetworks: MutableList<Network> = CopyOnWriteArrayList(listOf(physical))
        /**
         * The system default physical network, named by the test. Android never makes a restricted
         * network (IMS, MMS, SUPL) or one still without an address the default: removing the default
         * from [physicalNetworks] leaves none until the test names the next one.
         */
        @Volatile var defaultNetwork: Network? = physical
        /** State of a physical network for this app (CONNECTING, SUSPENDED, BLOCKED); CONNECTED when absent. */
        val states: MutableMap<Network, NetworkInfo.DetailedState> = ConcurrentHashMap()
        /**
         * Answered reads of activeNetworkInfo. The bridge's look at the networks reads it last: a
         * test waits for one more to know that a look completed.
         */
        val defaultReads = AtomicInteger()
        /** Another app's VPN network, listed while set. */
        @Volatile var vpn: Network? = null
        /** False: that VPN belongs to another profile or user and does not carry this app. */
        @Volatile var vpnCoversApp = true
        private val lock = Any()
        /** Applies [block] as one change of ConnectivityService: no read of the manager sees part of it. */
        fun change(block: Companion.() -> Unit) = synchronized(lock) { block() }
        fun reset() = change {
            physicalNetworks.clear()
            physicalNetworks += physical
            defaultNetwork = physical
            states.clear()
            defaultReads.set(0)
            vpn = null
            vpnCoversApp = true
        }
        private fun listedDefault() = defaultNetwork?.takeIf { it in physicalNetworks }
        /**
         * Android 11 (AOSP android-11.0.0_r48 ConnectivityService): both readings pass
         * filterNetworkStateForUid, which reports a network blocked for this app as
         * setDetailedState(BLOCKED, null, null), its APN cleared; mixInInfo keeps it while SUSPENDED.
         */
        private fun physicalInfo(network: Network): NetworkInfo {
            val state = states[network] ?: NetworkInfo.DetailedState.CONNECTED
            return NetworkInfo(
                if (network is CellularNetwork) TYPE_MOBILE else TYPE_WIFI,
                state,
                (network as? CellularNetwork)?.apn?.takeIf { state != NetworkInfo.DetailedState.BLOCKED },
            )
        }
        private val vpnCapabilities = object : NetworkCapabilities() {
            override fun hasCapability(capability: Int) = capability != NET_CAPABILITY_NOT_VPN
            override fun hasTransport(transport: Int) = transport == TRANSPORT_VPN
        }
    }
}

/**
 * Android 11 (AOSP android-11.0.0_r48): the manager is one per process. A proxy update
 * that reached the process before its Application was bound created it on the system
 * context: every call that sends the package fails its uid check for the life of the
 * process, while the calls without a package (networks, legacy info) still answer.
 */
class SystemPackageConnectivityManager : ConnectivityManager() {
    override fun registerNetworkCallback(request: NetworkRequest, callback: NetworkCallback): Unit = refused()
    override fun getNetworkCapabilities(network: Network?): NetworkCapabilities? = refused()
    private fun refused(): Nothing = throw SecurityException("Package android does not belong to 10156")
}

/**
 * Vpn.prepare model: a call by an app that holds prior consent makes it the
 * prepared VPN and revokes any other non-permanent VPN (AOSP Vpn.java
 * prepareInternal). Every call is counted so tests can forbid background probes.
 */
open class VpnService {
    companion object {
        val prepareCalls = AtomicInteger()
        @Volatile var consentIntent: Intent? = null
        @JvmStatic fun prepare(context: Context): Intent? {
            prepareCalls.incrementAndGet()
            return consentIntent
        }
        fun reset() { prepareCalls.set(0); consentIntent = null }
    }
}
