package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnNativeException

internal data class RevokedOpenVpnIdentity(val accountId: String, val deviceId: String, val csrSha256: String)

internal data class OpenVpnRevocationState(
    val identity: RevokedOpenVpnIdentity,
    val tunnelStopped: Boolean = false,
    val identityCleared: Boolean = false,
    val tileCleared: Boolean = false,
    val markerCleared: Boolean = false,
    val inProgress: Boolean = false,
    val stale: Boolean = false,
    val stopError: String? = null,
    val storageError: String? = null,
) {
    val complete get() = tunnelStopped && identityCleared && tileCleared && markerCleared && !inProgress && !stale
    fun toMap(): Map<String, Any?> = mapOf(
        "account_id" to identity.accountId, "device_id" to identity.deviceId,
        "csr_sha256" to identity.csrSha256, "tunnel_stopped" to tunnelStopped,
        "identity_cleared" to identityCleared, "tile_cleared" to tileCleared,
        "marker_cleared" to markerCleared, "in_progress" to inProgress,
        "stale" to stale, "stop_error" to stopError, "storage_error" to storageError,
    )
}

/** Access is serialized by OpenVpnController's identity mutex, including enrollment. */
internal class OpenVpnRevocation(
    private val readMarker: (String, String) -> String?,
    private val writeMarker: (RevokedOpenVpnIdentity) -> Unit,
    private val removeMarker: (RevokedOpenVpnIdentity) -> Unit,
) {
    private val pending = java.util.concurrent.ConcurrentHashMap<Pair<String, String>, OpenVpnRevocationState>()

    fun pending(accountId: String, deviceId: String): OpenVpnRevocationState? {
        val key = accountId to deviceId
        pending[key]?.let { return it.copy(inProgress = false) }
        val digest = readMarker(accountId, deviceId) ?: return null
        if (!Regex("[a-f0-9]{64}").matches(digest)) throw VpnNativeException("openvpn_identity_clear_failed")
        return OpenVpnRevocationState(RevokedOpenVpnIdentity(accountId, deviceId, digest)).also { pending[key] = it }
    }

    fun requireUsable(accountId: String, deviceId: String) {
        if (pending(accountId, deviceId) != null) throw VpnNativeException("openvpn_identity_cleanup_pending")
    }

    fun isBlocked(accountId: String, deviceId: String): Boolean =
        pending.containsKey(accountId to deviceId) || readMarker(accountId, deviceId) != null

    suspend fun clean(
        identity: RevokedOpenVpnIdentity,
        checkCurrent: () -> Unit,
        matchesCsr: () -> Boolean,
        admitted: () -> Unit,
        stop: suspend () -> Boolean,
        clearIdentity: () -> Unit,
        clearTile: () -> Unit,
        publish: (OpenVpnRevocationState) -> Unit = {},
    ): OpenVpnRevocationState {
        checkCurrent()
        require(Regex("[a-f0-9]{64}").matches(identity.csrSha256))
        val key = identity.accountId to identity.deviceId
        val previous = pending(identity.accountId, identity.deviceId)
        if ((previous != null && previous.identity != identity) || (previous == null && !matchesCsr())) {
            return OpenVpnRevocationState(identity, stale = true)
        }
        var result = (previous ?: OpenVpnRevocationState(identity)).copy(inProgress = true, stopError = null, storageError = null)
        fun update(value: OpenVpnRevocationState) {
            checkCurrent()
            result = value
            pending[key] = value
            publish(value)
        }
        // Retain an in-memory fence even when persistence is unavailable.
        update(result)
        admitted()
        var persisted = false
        try {
            checkCurrent()
            writeMarker(identity)
            persisted = true
        } catch (error: Exception) {
            checkCurrent()
            update(result.copy(storageError = "openvpn_identity_clear_failed"))
        }
        try {
            checkCurrent()
            val stopped = stop()
            checkCurrent()
            update(result.copy(tunnelStopped = stopped, stopError = if (stopped) null else "openvpn_stop_timeout"))
        } catch (error: Exception) {
            checkCurrent()
            update(result.copy(tunnelStopped = false, stopError = "openvpn_stop_timeout"))
        }
        // The tile must be invalidated even if stop or key deletion fails.
        try {
            checkCurrent()
            clearTile()
            update(result.copy(tileCleared = true))
        } catch (error: Exception) {
            checkCurrent()
            update(result.copy(tileCleared = false, storageError = "openvpn_identity_clear_failed"))
        }
        if (persisted && result.tunnelStopped && !result.identityCleared) {
            try {
                checkCurrent()
                clearIdentity()
                update(result.copy(identityCleared = true))
            } catch (error: Exception) {
                checkCurrent()
                update(result.copy(storageError = "openvpn_identity_clear_failed"))
            }
        }
        if (persisted && result.tunnelStopped && result.identityCleared && result.tileCleared) {
            try {
                checkCurrent()
                removeMarker(identity)
                update(result.copy(markerCleared = true, storageError = null))
            } catch (error: Exception) {
                checkCurrent()
                update(result.copy(storageError = "openvpn_identity_clear_failed"))
            }
        }
        update(result.copy(inProgress = false))
        if (result.complete) pending.remove(key)
        return result
    }
}
