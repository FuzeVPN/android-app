package com.fuzevpn.android.openvpn

import java.time.Instant

/** In-memory evidence for one already-confirmed native OpenVPN connection. */
internal data class CurrentOpenVpnConnectionIdentity(
    val accountId: String,
    val deviceId: String,
    val identityAlias: String,
    val identityGeneration: String,
    val nativeGeneration: Long,
    val certificateNotAfter: Instant,
    val fingerprint: String,
    val persisted: Boolean = true,
    val confirmed: Boolean = false,
) {
    fun isUsable(
        accountId: String,
        deviceId: String,
        identityAlias: String,
        identityGeneration: String,
        nativeGeneration: Long,
        nativeHandlePresent: Boolean,
        operationUncertain: Boolean,
        now: Instant,
        renewalWindowSeconds: Long,
    ): Boolean = confirmed && persisted && nativeHandlePresent && !operationUncertain &&
        this.accountId == accountId && this.deviceId == deviceId &&
        this.identityAlias == identityAlias && this.identityGeneration == identityGeneration &&
        this.nativeGeneration == nativeGeneration &&
        certificateNotAfter.isAfter(now.plusSeconds(renewalWindowSeconds))
}
