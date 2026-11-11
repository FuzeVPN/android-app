package com.fuzevpn.android.openvpn

import android.content.Context
import com.fuzevpn.android.HarnessControl
import com.fuzevpn.android.VpnNativeException
import java.nio.charset.StandardCharsets

/**
 * Transport double: the real OpenVpnRenewalContract builds the request and reads the answer
 * HarnessControl gives for it, so only the Android network binding and the socket are replaced.
 */
internal class OpenVpnRenewalApi(@Suppress("UNUSED_PARAMETER") context: Context, private val baseUrl: String) {
    suspend fun renew(sessionPayload: String, deviceId: String, csrPem: String, isCurrent: () -> Boolean): Map<String, Any?> {
        val request = OpenVpnRenewalContract.request(baseUrl, sessionPayload, deviceId, csrPem)
        HarnessControl.renewalRequests += "${request.url} ${request.headers["authorization"]}"
        // As the real transport: a command received meanwhile never waits for the server.
        while (HarnessControl.renewalHold) {
            if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
            Thread.sleep(5)
        }
        val (status, body) = HarnessControl.renewalResponse(deviceId)
        return OpenVpnRenewalContract.activation(status, "no-store", body.toByteArray(StandardCharsets.UTF_8), deviceId)
    }
}
