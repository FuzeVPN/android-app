package com.fuzevpn.android.openvpn

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.os.Build
import com.fuzevpn.android.VpnNativeException
import kotlinx.coroutines.delay
import java.io.ByteArrayOutputStream
import java.io.IOException
import java.io.InputStream
import java.net.SocketTimeoutException
import java.net.URL
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicReference
import javax.net.ssl.HttpsURLConnection
import kotlin.concurrent.thread

/**
 * Sends the renewal of [OpenVpnRenewalContract] over a physical network. While
 * a recovery holds the TUN interface, every packet routed through the VPN is
 * dropped, and this app's own traffic is routed through it: the request is
 * bound to a network instead, which Android allows the VPN's own app to do,
 * also with "Block connections without VPN".
 */
internal class OpenVpnRenewalApi(context: Context, private val baseUrl: String) {
    private val connectivity = context.applicationContext.getSystemService(ConnectivityManager::class.java)

    /**
     * One request, never repeated here: after a lost response the next
     * attempt presents the same pending CSR, which the server answers with
     * the certificate it already issued. [isCurrent] is polled so that a
     * command received meanwhile never waits for the server.
     */
    suspend fun renew(
        sessionPayload: String,
        deviceId: String,
        csrPem: String,
        isCurrent: () -> Boolean,
    ): Map<String, Any?> {
        val request = OpenVpnRenewalContract.request(baseUrl, sessionPayload, deviceId, csrPem)
        val network = physicalNetwork() ?: throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.NETWORK)
        val outcome = AtomicReference<Result<Map<String, Any?>>?>()
        val connection = AtomicReference<HttpsURLConnection?>()
        val abandoned = AtomicBoolean()
        // Blocking socket calls ignore coroutine cancellation: they run on their own thread.
        thread(name = "fuzevpn-openvpn-renewal", isDaemon = true) {
            outcome.set(runCatching { send(network, request, deviceId, connection, abandoned) })
        }
        try {
            val deadline = System.nanoTime() + REQUEST_TIMEOUT_MS * 1_000_000L
            while (outcome.get() == null) {
                if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
                if (System.nanoTime() >= deadline) throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.TIMEOUT)
                delay(POLL_MS)
            }
        } finally {
            if (outcome.get() == null) {
                // The worker closes a connection it opens after this point.
                abandoned.set(true)
                runCatching { connection.get()?.disconnect() }
            }
        }
        return outcome.get()!!.getOrElse { throw refusal(it) }
    }

    private fun send(
        network: Network,
        request: OpenVpnRenewalContract.Request,
        deviceId: String,
        holder: AtomicReference<HttpsURLConnection?>,
        abandoned: AtomicBoolean,
    ): Map<String, Any?> {
        val connection = network.openConnection(URL(request.url)) as? HttpsURLConnection
            ?: throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.REQUEST)
        holder.set(connection)
        try {
            if (abandoned.get()) throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.TIMEOUT)
            connection.requestMethod = "POST"
            // The token belongs to the API origin: no redirect may carry it elsewhere.
            connection.instanceFollowRedirects = false
            connection.useCaches = false
            connection.connectTimeout = CONNECT_TIMEOUT_MS
            connection.readTimeout = READ_TIMEOUT_MS
            connection.doOutput = true
            connection.setFixedLengthStreamingMode(request.body.size)
            request.headers.forEach { (name, value) -> connection.setRequestProperty(name, value) }
            connection.outputStream.use { it.write(request.body) }
            val status = connection.responseCode
            val body = if (status == 201) connection.inputStream.use(::readBounded) else ByteArray(0)
            return OpenVpnRenewalContract.activation(status, connection.getHeaderField("Cache-Control"), body, deviceId)
        } finally {
            connection.disconnect()
        }
    }

    private fun readBounded(input: InputStream): ByteArray {
        val output = ByteArrayOutputStream()
        val buffer = ByteArray(8 * 1024)
        while (true) {
            val read = input.read(buffer)
            if (read < 0) return output.toByteArray()
            if (output.size() + read > OpenVpnRenewalContract.MAX_RESPONSE_BYTES) {
                throw OpenVpnRenewalRefused(OpenVpnRenewalRefused.RESPONSE)
            }
            output.write(buffer, 0, read)
        }
    }

    private fun refusal(error: Throwable): OpenVpnRenewalRefused = when (error) {
        is OpenVpnRenewalRefused -> error
        is SocketTimeoutException -> OpenVpnRenewalRefused(OpenVpnRenewalRefused.TIMEOUT)
        is IOException, is SecurityException -> OpenVpnRenewalRefused(OpenVpnRenewalRefused.TRANSPORT)
        else -> OpenVpnRenewalRefused(OpenVpnRenewalRefused.REQUEST)
    }

    /**
     * A validated physical network this app may bind to. A network Android
     * only keeps up in the background (mobile data beside Wi-Fi) refuses the
     * socket of an ordinary app, so the system default physical network is
     * preferred: under our VPN, the legacy active network info describes it.
     * On Android 11 the process's ConnectivityManager can refuse every
     * capability read (see AndroidVpnBridge.physicalCallbackRegistered): that
     * default is then found through the legacy readings alone, which have no
     * package check.
     */
    @Suppress("DEPRECATION")
    private fun physicalNetwork(): Network? = try {
        val default = connectivity.activeNetworkInfo?.takeIf { it.type != ConnectivityManager.TYPE_VPN && it.isConnected }
        try {
            val usable = connectivity.allNetworks.filter { network ->
                connectivity.getNetworkCapabilities(network)?.let { capabilities ->
                    capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) &&
                        capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) &&
                        capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED) &&
                        capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED) &&
                        (Build.VERSION.SDK_INT < Build.VERSION_CODES.P ||
                            capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_FOREGROUND))
                } == true
            }
            usable.firstOrNull { default != null && connectivity.getNetworkInfo(it)?.type == default.type }
                ?: usable.firstOrNull()
        } catch (_: SecurityException) {
            if (default == null) null
            else connectivity.allNetworks.firstOrNull { network ->
                connectivity.getNetworkInfo(network)?.let { it.type == default.type && it.isConnected } == true
            }
        }
    } catch (_: Exception) {
        null
    }

    private companion object {
        const val CONNECT_TIMEOUT_MS = 10_000
        // The server waits up to 8 s for the VPN node to apply the new certificate.
        const val READ_TIMEOUT_MS = 20_000
        const val REQUEST_TIMEOUT_MS = 25_000L
        const val POLL_MS = 100L
    }
}
