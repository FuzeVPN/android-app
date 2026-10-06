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

/** Pure policy shared by the UI and the Android host implementation. */
internal fun userStopRequiresSettings(alwaysOn: Boolean?): Boolean = alwaysOn != false

private fun requireCurrentSystemVpnRequest(isCurrent: () -> Boolean) {
    if (!isCurrent()) throw CancellationException("system_vpn_request_replaced")
}

internal const val SYSTEM_VPN_NETWORK_WAIT_POLL_MS = 250L
internal const val SYSTEM_VPN_NETWORK_WAIT_TIMEOUT_MS = 30_000L
