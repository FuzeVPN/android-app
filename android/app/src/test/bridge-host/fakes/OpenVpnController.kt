package com.fuzevpn.android.openvpn

import android.content.Context
import com.fuzevpn.android.NativeConnectionTiming
import com.fuzevpn.android.TunnelNetworkSpec
import com.fuzevpn.android.TunnelStatistics
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.emptyFlow

/**
 * Inert OpenVPN engine with the API used by AndroidVpnBridge. run.ps1 appends
 * the real result/state data classes extracted from OpenVpnController.kt.
 */
internal class OpenVpnController(@Suppress("UNUSED_PARAMETER") context: Context) {
    val sessionGeneration: Long get() = 0L
    val sessionFailure: String? get() = null
    var provenNetworkFamilies: List<String> = emptyList()
    suspend fun disconnect(timing: NativeConnectionTiming.TraceContext? = null): Boolean = true
    fun cancelPendingConnection() {}
    fun isRevocationBlocked(accountId: String, deviceId: String): Boolean = false
    fun isConnected(): Boolean = false
    fun hasUsableNetwork(): Boolean = network
    suspend fun certificateStatus(accountId: String, deviceId: String): OpenVpnCertificateStatus =
        OpenVpnCertificateStatus("valid", null, false)
    suspend fun reconnectLocal(accountId: String, deviceId: String, expectedNetwork: TunnelNetworkSpec? = null,
        isCurrent: () -> Boolean = { true }): OpenVpnStartResult = error("openvpn not used")
    suspend fun pendingRevocation(accountId: String, deviceId: String): OpenVpnRevocationState? = null
    fun currentConnectionIdentityFingerprint(accountId: String, deviceId: String): String = error("openvpn not used")
    suspend fun statistics(): TunnelStatistics = TunnelStatistics()
    fun permissionRevoked() {}
    fun observeStates(): Flow<OpenVpnSessionEvent> = emptyFlow()
    fun networkLost() {}
    suspend fun getOrCreateCsr(accountId: String, deviceId: String, renewal: Boolean = false): String = error("openvpn not used")
    fun existingIdentityFingerprint(accountId: String, deviceId: String): String = error("openvpn not used")
    suspend fun connect(accountId: String, deviceId: String, activation: Map<String, Any?>,
        timing: NativeConnectionTiming.TraceContext? = null, isCurrent: () -> Boolean = { true }): OpenVpnStartResult =
        error("openvpn not used")
    fun confirmConnected(publish: () -> Unit): Boolean = error("openvpn not used")
    suspend fun clearIdentity(accountId: String, deviceId: String) {}
    suspend fun clearAccountIdentity(accountId: String) {}
    suspend fun cleanRevokedIdentity(
        target: RevokedOpenVpnIdentity,
        checkCurrent: () -> Unit,
        admitted: () -> Unit,
        clearTile: () -> Unit,
        publish: (OpenVpnRevocationState) -> Unit,
    ): OpenVpnRevocationState = error("openvpn not used")

    companion object {
        /** Physical network seen by the system-start wait (SystemVpnNetworkWait). */
        @Volatile var network = true
    }
}
