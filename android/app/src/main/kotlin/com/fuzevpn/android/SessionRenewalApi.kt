package com.fuzevpn.android

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import com.fuzevpn.android.openvpn.physicalApiNetwork
import kotlinx.coroutines.delay
import java.io.ByteArrayOutputStream
import java.io.InputStream
import java.net.URL
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicReference
import javax.net.ssl.HttpsURLConnection
import kotlin.concurrent.thread

/**
 * Sends the requests of [SessionRenewalContract]. As OpenVpnRenewalApi does, a request made
 * while a TUN may be held (every packet routed through the VPN is then dropped) is bound to a
 * physical network, which Android allows the VPN's own app to use, also with "Block connections
 * without VPN". Any other request follows the app's default route, as the Dart client's.
 */
internal class SessionRenewalApi(context: Context) : SessionRenewalTransport {
    private val connectivity = context.applicationContext.getSystemService(ConnectivityManager::class.java)

    override suspend fun send(
        request: SessionRenewalContract.Request,
        physical: Boolean,
        isCurrent: () -> Boolean,
    ): SessionRenewalContract.Response {
        val network = if (physical) connectivity.physicalApiNetwork() ?: throw SessionTransportFailure() else null
        val outcome = AtomicReference<Result<SessionRenewalContract.Response>?>()
        val connection = AtomicReference<HttpsURLConnection?>()
        val abandoned = AtomicBoolean()
        // Blocking socket calls ignore coroutine cancellation: they run on their own thread.
        thread(name = "fuzevpn-session-renewal", isDaemon = true) {
            outcome.set(runCatching { exchange(network, request, connection, abandoned) })
        }
        try {
            val deadline = System.nanoTime() + request.timeoutMillis * 1_000_000L
            while (outcome.get() == null) {
                if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
                if (System.nanoTime() >= deadline) throw SessionTransportFailure()
                delay(POLL_MS)
            }
        } finally {
            if (outcome.get() == null) {
                // The worker closes a connection it opens after this point.
                abandoned.set(true)
                runCatching { connection.get()?.disconnect() }
            }
        }
        // The transport's own message can name the URL: only the fixed failure leaves here.
        return outcome.get()!!.getOrElse { throw SessionTransportFailure() }
    }

    private fun exchange(
        network: Network?,
        request: SessionRenewalContract.Request,
        holder: AtomicReference<HttpsURLConnection?>,
        abandoned: AtomicBoolean,
    ): SessionRenewalContract.Response {
        val url = URL(request.url)
        val connection = (network?.openConnection(url) ?: url.openConnection()) as? HttpsURLConnection
            ?: throw SessionTransportFailure()
        holder.set(connection)
        try {
            if (abandoned.get()) throw SessionTransportFailure()
            connection.requestMethod = "POST"
            // The token belongs to the API origin: no redirect may carry it elsewhere.
            connection.instanceFollowRedirects = false
            connection.useCaches = false
            connection.connectTimeout = CONNECT_TIMEOUT_MS
            connection.readTimeout = READ_TIMEOUT_MS
            request.headers.forEach { (name, value) -> connection.setRequestProperty(name, value) }
            // A logout has no body: no output stream is opened for it.
            if (request.body.isNotEmpty()) {
                connection.doOutput = true
                connection.setFixedLengthStreamingMode(request.body.size)
                connection.outputStream.use { it.write(request.body) }
            }
            val status = connection.responseCode
            val body = (if (status in 200..299) connection.inputStream else connection.errorStream)
                ?.use(::readBounded) ?: ByteArray(0)
            return SessionRenewalContract.Response(status, connection.getHeaderField("Cache-Control"),
                connection.getHeaderField("Retry-After"), body, connection.getHeaderField("Date"))
        } finally {
            connection.disconnect()
        }
    }

    private fun readBounded(input: InputStream): ByteArray {
        val output = ByteArrayOutputStream()
        val buffer = ByteArray(4 * 1024)
        while (true) {
            val read = input.read(buffer)
            if (read < 0) return output.toByteArray()
            if (output.size() + read > SessionRenewalContract.MAX_RESPONSE_BYTES) throw SessionTransportFailure()
            output.write(buffer, 0, read)
        }
    }

    private companion object {
        const val CONNECT_TIMEOUT_MS = 10_000
        const val READ_TIMEOUT_MS = 15_000
        const val POLL_MS = 100L
    }
}
