package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnNativeException
import kotlinx.coroutines.NonCancellable
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeoutOrNull

/** Timing and ordering of one attempt. Callers lock only stop/start operations. */
internal class OpenVpnRecoveryAttempt {
    suspend fun run(
        retry: Boolean,
        failure: String,
        isCurrent: () -> Boolean,
        stopOld: suspend () -> Boolean,
        hasNetwork: () -> Boolean,
        restartLocal: suspend () -> Unit,
    ) {
        if (!isCurrent()) return
        val stopped = withContext(NonCancellable) { stopOld() }
        if (!isCurrent()) return
        if (!stopped) throw VpnNativeException("openvpn_stop_timeout")
        if (!retry) throw VpnNativeException(failure)
        delay(2_000L)
        val ready = withTimeoutOrNull(30_000L) {
            while (!hasNetwork()) delay(250L)
            true
        } ?: false
        if (!isCurrent()) return
        if (!ready) throw VpnNativeException("network_unavailable")
        restartLocal()
    }

    companion object {
        fun profileFailure(status: String, renewalPending: Boolean): String? = when {
            renewalPending || status == "expired" || status == "expiring" -> "openvpn_renewal_required"
            status != "valid" -> "openvpn_profile_unavailable"
            else -> null
        }
    }
}
