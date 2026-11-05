package com.fuzevpn.android

import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.delay
import kotlinx.coroutines.withTimeoutOrNull

/**
 * Waits only for a local, validated physical network before a system-originated
 * VPN start.  Each suspension and network probe is fenced by the caller's
 * request token, so a logout or a newer explicit connection cannot continue a
 * stale system callback.
 */
internal suspend fun awaitSystemVpnNetwork(
    isCurrent: () -> Boolean,
    hasNetwork: () -> Boolean,
) {
    val available = withTimeoutOrNull(SYSTEM_VPN_NETWORK_WAIT_TIMEOUT_MS) {
        while (true) {
            requireCurrentSystemVpnRequest(isCurrent)
            if (hasNetwork()) {
                requireCurrentSystemVpnRequest(isCurrent)
                return@withTimeoutOrNull true
            }
            requireCurrentSystemVpnRequest(isCurrent)
            delay(SYSTEM_VPN_NETWORK_WAIT_POLL_MS)
            requireCurrentSystemVpnRequest(isCurrent)
        }
    }
    if (available != true) throw VpnNativeException("system_vpn_resume_network_timeout")
}

/**
 * Android 11 fallback when the process's ConnectivityManager answers for package android: the
 * system default network, read without a package check. BLOCKED only means this uid is held back
 * (Doze, Battery Saver, Data Saver) until its VPN host runs in the foreground, not that it is gone.
 */
internal fun legacyDefaultNetworkUsable(present: Boolean, vpn: Boolean, connected: Boolean, blocked: Boolean): Boolean =
    present && !vpn && (connected || blocked)

/**
 * Android 11 without the physical network callback (same cause as above): follows the default
 * physical network through the legacy readings, which have no package check, and reports its
 * loss as the callback's onLost would. Not thread-safe; the bridge calls it under one lock.
 */
internal class LegacyDefaultNetworkTracker<N : Any> {
    /** A non-VPN network as its legacy NetworkInfo describes it to this app. */
    data class Reading(val type: Int, val extraInfo: String?, val state: State)

    /** FOLLOWED: connected or suspended. BLOCKED: held back for this app, which also clears extraInfo. */
    enum class State { FOLLOWED, BLOCKED, OTHER }

    private var key: Pair<Int, String?>? = null
    private var followed: Set<N>? = null

    fun reset() {
        key = null
        followed = null
    }

    /**
     * True when the default network followed so far is lost: the default moved to another type
     * or extra information (a cellular network's APN), or none of the followed networks still
     * matches it (gone, or no longer connected). The network left behind may stay listed: it
     * lingers, then runs in the background where traffic stops; this reports the move at once,
     * where the callback waits for the end of the linger (a default that comes back within it
     * costs a reconnect the callback would not make). Only networks matching the default are
     * followed, never an IMS or MMS network of the same type, and among several the ones already
     * followed are kept. A first look only records.
     */
    fun look(listed: Map<N, Reading>, default: Reading?): Boolean {
        val previous = followed
        val previousKey = key
        // A BLOCKED default has no extra information: that look sees only departures and types.
        val current = default?.takeIf { it.state != State.BLOCKED }?.let { it.type to it.extraInfo }
        val matches = if (current == null) emptySet() else listed.filterValues {
            it.state == State.FOLLOWED && (it.type to it.extraInfo) == current
        }.keys
        // Each reading is a separate call: a block can end between a network's reading and the
        // default's, so a BLOCKED network of the default's type may still be the one followed.
        val present = if (current == null) listed.keys else matches + listed.filterValues {
            it.state == State.BLOCKED && it.type == current.first
        }.keys
        val lost = previous != null && previousKey != null && (
            (default != null && default.type != previousKey.first) ||
                (current != null && current != previousKey) ||
                previous.none { it in present })
        when {
            current == null -> if (lost) reset()
            lost || previous == null -> if (matches.isEmpty()) reset() else {
                key = current
                followed = matches
            }
            else -> followed = previous.intersect(present)
        }
        return lost
    }
}

/** Pure policy shared by the UI and the Android host implementation. */
internal fun userStopRequiresSettings(alwaysOn: Boolean?): Boolean = alwaysOn != false

private fun requireCurrentSystemVpnRequest(isCurrent: () -> Boolean) {
    if (!isCurrent()) throw CancellationException("system_vpn_request_replaced")
}

internal const val SYSTEM_VPN_NETWORK_WAIT_POLL_MS = 250L
internal const val SYSTEM_VPN_NETWORK_WAIT_TIMEOUT_MS = 30_000L
