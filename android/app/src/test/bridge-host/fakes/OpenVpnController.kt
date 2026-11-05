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
        OpenVpnCertificateStatus("valid", null, false)
    suspend fun reconnectLocal(accountId: String, deviceId: String, expectedNetwork: TunnelNetworkSpec? = null,
        isCurrent: () -> Boolean = { true }): OpenVpnStartResult {
        HarnessControl.openVpnReconnects++
        return start(HarnessControl.openVpnReconnect())
    }
    suspend fun pendingRevocation(accountId: String, deviceId: String): OpenVpnRevocationState? = null
    fun currentConnectionIdentityFingerprint(accountId: String, deviceId: String): String = WireGuardController.IDENTITY
    suspend fun statistics(): TunnelStatistics = TunnelStatistics()
    fun permissionRevoked() {}
    fun observeStates(): Flow<OpenVpnSessionEvent> = events.flow
    fun networkLost() {
        HarnessControl.openVpnNetworkLosses++
        events.interrupt("openvpn_reconnect_required")
    }
    /** Core's own transport failure (keepalive expiry, server restart). */
    fun coreReconnectRequired() = events.publish(events.generation, OpenVpnNativeState.error("openvpn_reconnect_required"))
    suspend fun getOrCreateCsr(accountId: String, deviceId: String, renewal: Boolean = false): String = error("openvpn not used")
    fun existingIdentityFingerprint(accountId: String, deviceId: String): String = WireGuardController.IDENTITY
    suspend fun connect(accountId: String, deviceId: String, activation: Map<String, Any?>,
        timing: NativeConnectionTiming.TraceContext? = null, isCurrent: () -> Boolean = { true }): OpenVpnStartResult {
        HarnessControl.openVpnConnects++
        return start(true)
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
    }
}
