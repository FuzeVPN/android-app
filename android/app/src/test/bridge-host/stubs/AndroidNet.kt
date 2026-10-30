package android.net

import android.content.Context
import android.content.Intent
import java.util.concurrent.atomic.AtomicInteger

class Uri(val scheme: String?)
open class Network

open class NetworkCapabilities {
    open fun hasCapability(capability: Int): Boolean = true
    companion object {
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

open class ConnectivityManager {
    open class NetworkCallback {
        open fun onAvailable(network: Network) {}
        open fun onCapabilitiesChanged(network: Network, capabilities: NetworkCapabilities) {}
        open fun onLost(network: Network) {}
    }
    val callbacks: MutableList<NetworkCallback> = mutableListOf()
    open fun registerNetworkCallback(request: NetworkRequest, callback: NetworkCallback) { callbacks += callback }
    open fun getNetworkCapabilities(network: Network?): NetworkCapabilities? = NetworkCapabilities()
    open val allNetworks: Array<Network> get() = arrayOf(physical)
    companion object { val physical = Network() }
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
