package com.fuzevpn.android.openvpn

import android.content.Context
import com.fuzevpn.android.HarnessControl
import com.fuzevpn.android.NativeConnectionTiming
import com.fuzevpn.android.TunnelNetworkSpec
import com.fuzevpn.android.TunnelStatistics
import com.fuzevpn.android.WireGuardController
import kotlinx.coroutines.flow.Flow

/**
 * OpenVPN engine double with the API used by AndroidVpnBridge. Its sessions
 * are the real OpenVpnSessionEvents: a start reaches Core's CONNECTED, a loss
 * or a Core failure interrupts it. run.ps1 appends the real result/state data
 * classes extracted from OpenVpnController.kt.
 */
internal class OpenVpnController(@Suppress("UNUSED_PARAMETER") context: Context) {
    private val events = OpenVpnSessionEvents()
    init { current = this }

    val sessionGeneration: Long get() = events.generation
    val sessionFailure: String? get() = events.failureCode
    var provenNetworkFamilies: List<String> = emptyList()
    suspend fun disconnect(timing: NativeConnectionTiming.TraceContext? = null): Boolean {
        HarnessControl.openVpnStops++
        if (events.generation > 0) { events.requestStop(); events.finish() }
        return true
    }
    fun cancelPendingConnection() {}
    fun isRevocationBlocked(accountId: String, deviceId: String): Boolean = false
    fun isConnected(): Boolean = events.snapshot.isConnected()
    fun hasUsableNetwork(): Boolean = network
    suspend fun certificateStatus(accountId: String, deviceId: String): OpenVpnCertificateStatus =
        OpenVpnCertificateStatus(HarnessControl.openVpnCertificate, null, HarnessControl.openVpnRenewalPending)
    suspend fun reconnectLocal(accountId: String, deviceId: String, expectedNetwork: TunnelNetworkSpec? = null,
        isCurrent: () -> Boolean = { true }): OpenVpnStartResult {
        HarnessControl.openVpnReconnects++
        return start(HarnessControl.openVpnReconnect())
    }
    suspend fun pendingRevocation(accountId: String, deviceId: String): OpenVpnRevocationState? = null
    fun currentConnectionIdentityFingerprint(accountId: String, deviceId: String): String = HarnessControl.openVpnIdentity
    suspend fun statistics(): TunnelStatistics = TunnelStatistics()
    fun permissionRevoked() {}
    fun observeStates(): Flow<OpenVpnSessionEvent> = events.flow
    fun networkLost() {
        HarnessControl.openVpnNetworkLosses++
        events.interrupt("openvpn_reconnect_required")
    }
    /** Core's own transport failure (keepalive expiry, server restart). */
    fun coreReconnectRequired() = events.publish(events.generation, OpenVpnNativeState.error("openvpn_reconnect_required"))
    /** As the real engine: one pending renewal CSR, kept and returned again until an activation uses it. */
    suspend fun getOrCreateCsr(accountId: String, deviceId: String, renewal: Boolean = false): String {
        if (!renewal) error("openvpn not used")
        if (events.snapshot.isConnected()) throw com.fuzevpn.android.VpnNativeException("openvpn_identity_in_use")
        HarnessControl.openVpnCsrRequests++
        HarnessControl.openVpnRenewalPending = true
        return RENEWAL_CSR
    }
    fun existingIdentityFingerprint(accountId: String, deviceId: String): String = HarnessControl.openVpnIdentity
    suspend fun connect(accountId: String, deviceId: String, activation: Map<String, Any?>,
        timing: NativeConnectionTiming.TraceContext? = null, isCurrent: () -> Boolean = { true }): OpenVpnStartResult {
        HarnessControl.openVpnConnects++
        if (activation["renewal"] == true) {
            if (!HarnessControl.openVpnRenewalPending) return OpenVpnStartResult(false, "openvpn_renewal_not_prepared")
            // The real engine publishes the new generation with the validated activation, before Core starts.
            HarnessControl.openVpnRenewalPending = false
            HarnessControl.openVpnCertificate = "valid"
            HarnessControl.openVpnIdentity = HarnessControl.RENEWED_OPENVPN_IDENTITY
        }
        return start(HarnessControl.openVpnConnect())
    }
    fun confirmConnected(publish: () -> Unit): Boolean = isConnected() && events.confirmConnected(events.generation, publish)
    suspend fun clearIdentity(accountId: String, deviceId: String) {}
    suspend fun clearAccountIdentity(accountId: String) {}
    suspend fun cleanRevokedIdentity(
        target: RevokedOpenVpnIdentity,
        checkCurrent: () -> Unit,
        admitted: () -> Unit,
        clearTile: () -> Unit,
        publish: (OpenVpnRevocationState) -> Unit,
    ): OpenVpnRevocationState = error("openvpn not used")

    /** Core began; it reaches CONNECTED unless the harness makes this start time out. */
    private fun start(reachesConnected: Boolean): OpenVpnStartResult {
        val generation = events.begin()
        HarnessControl.openVpnStartGate?.let { gate -> HarnessControl.openVpnStartGate = null; gate.hold() }
        if (!reachesConnected) return OpenVpnStartResult(false, "openvpn_connection_timeout")
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        return OpenVpnStartResult.connected()
    }

    companion object {
        /** Physical network seen by the system-start and recovery waits (hasUsableNetwork). */
        @Volatile var network = true
        /** The bridge's engine, for tests that raise Core's own failures. */
        @Volatile var current: OpenVpnController? = null
        const val RENEWAL_CSR = "-----BEGIN CERTIFICATE REQUEST-----\nhost\n-----END CERTIFICATE REQUEST-----\n"
    }
}
