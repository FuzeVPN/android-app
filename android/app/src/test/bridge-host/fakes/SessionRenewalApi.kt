package com.fuzevpn.android

import android.content.Context
import java.nio.charset.StandardCharsets
import org.json.JSONObject

/**
 * Transport double of the session renewal: the real SessionRenewal builds each request and reads
 * the answer HarnessControl gives for it, so only the network binding and the socket are replaced.
 */
internal class SessionRenewalApi(@Suppress("UNUSED_PARAMETER") context: Context) : SessionRenewalTransport {
    override suspend fun send(
        request: SessionRenewalContract.Request,
        physical: Boolean,
        isCurrent: () -> Boolean,
    ): SessionRenewalContract.Response {
        val path = request.url.removePrefix("https://api.fuzevpn.com/")
        val requestId = runCatching { JSONObject(String(request.body, StandardCharsets.UTF_8)).getString("request_id") }.getOrNull()
        HarnessControl.sessionRequests += listOfNotNull(path, request.headers["authorization"], requestId).joinToString(" ")
        HarnessControl.sessionPhysical += physical
        // As the real transport: a request abandoned by its caller never waits for the server.
        // The hold models a slow rotation; a logout is answered.
        while (HarnessControl.sessionHold && path != "v1/auth/logout") {
            if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
            Thread.sleep(5)
        }
        return HarnessControl.sessionResponse(path)
    }
}
