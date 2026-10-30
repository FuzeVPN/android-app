package com.fuzevpn.android

import android.content.Context

// Data types copied from WireGuardController.kt: the engine itself needs GoBackend.
internal data class WireGuardRequest(
    val accountId: String,
    val deviceId: String,
    val locationId: String,
    val locationName: String,
    val address: String,
    val dns: List<String>,
    val serverPublicKey: String,
    val endpoint: String,
    val allowedIps: List<String>,
    val network: TunnelNetworkSpec = TunnelNetworkSpec.ipv4(address, allowedIps),
) {
    init {
        require(TunnelNetworkSpec.numericAddress(address.substringBefore('/')).address.size == 4)
        require(network.addresses.first() == TunnelNetworkSpec.ipv4(address, listOf("0.0.0.0/0")).addresses.first())
        require(allowedIps == network.allowedIps)
        require(dns.isNotEmpty() && dns.size <= 8 && dns.all { TunnelNetworkSpec.numericAddress(it).address.size == 4 })
        require(endpoint.endsWith(":51820") && TunnelNetworkSpec.numericAddress(endpoint.removeSuffix(":51820")).address.size == 4)
    }
}

internal class VpnNativeException(val code: String, cause: Throwable? = null) : Exception(code, cause)

/** Engine double with the API used by AndroidVpnBridge; behaviour comes from HarnessControl. */
internal class WireGuardController(
    @Suppress("UNUSED_PARAMETER") context: Context,
    @Suppress("UNUSED_PARAMETER") secureStore: SecureKeystoreStore,
    @Suppress("UNUSED_PARAMETER") onUnexpectedTunnelDown: () -> Unit,
) {
    fun getOrCreatePublicKey(accountId: String): String {
        HarnessControl.publicKeyGate?.let { gate -> HarnessControl.publicKeyGate = null; gate.hold() }
        HarnessControl.publicKeyFailure?.let { throw VpnNativeException(it) }
        return "fake-public-key"
    }
    fun existingIdentityFingerprint(accountId: String): String {
        HarnessControl.identityGate?.let { gate -> HarnessControl.identityGate = null; gate.hold() }
        HarnessControl.identityFailure?.let { throw VpnNativeException(it) }
        return IDENTITY
    }
    fun currentConnectionIdentityFingerprint(accountId: String): String = IDENTITY
    fun connect(
        request: WireGuardRequest,
        isCurrent: () -> Boolean = { true },
        requireExistingIdentity: Boolean = false,
        timing: NativeConnectionTiming.TraceContext? = null,
    ): Boolean {
        if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
        HarnessControl.wireGuardConnects++
        HarnessControl.wireGuardUp = true
        HarnessControl.wireGuardConnectGate?.let { gate -> HarnessControl.wireGuardConnectGate = null; gate.hold() }
        val connected = HarnessControl.wireGuardConnect(isCurrent)
        if (!connected) HarnessControl.wireGuardUp = false
        return connected
    }
    fun disconnect(timing: NativeConnectionTiming.TraceContext? = null): Boolean {
        HarnessControl.wireGuardStops++
        if (!HarnessControl.wireGuardStopResult) return false
        HarnessControl.wireGuardUp = false
        return true
    }
    fun isConnected(): Boolean = HarnessControl.wireGuardUp
    fun recoveryBaseline(): TunnelStatistics? = null
    fun statistics(): TunnelStatistics = TunnelStatistics()
    fun clearAccountIdentity(accountId: String) {}
    fun close() {}

    companion object { const val IDENTITY = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
}
