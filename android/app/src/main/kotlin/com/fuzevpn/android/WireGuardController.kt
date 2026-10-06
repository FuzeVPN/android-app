package com.fuzevpn.android

import android.content.Context
import com.wireguard.android.backend.GoBackend
import com.wireguard.android.backend.Tunnel
import com.wireguard.config.Config
import com.wireguard.crypto.Key
import com.wireguard.crypto.KeyPair
import java.io.ByteArrayInputStream
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.util.concurrent.Executors
import java.util.concurrent.ExecutionException
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

/** Remote configuration passed by Flutter only for the duration of a connect. */
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

/**
 * Thin adapter over WireGuard's official Android tunnel library. It owns no
 * credentials itself: the only private key is encrypted in [SecureKeystoreStore]
 * and is passed directly into the WireGuard parser on the worker thread.
 */
internal class WireGuardController(
    context: Context,
    private val secureStore: SecureKeystoreStore,
    private val onUnexpectedTunnelDown: () -> Unit,
) {
    private val appContext = context.applicationContext
    private val backend = GoBackend(appContext)
    private val backendExecutor = Executors.newSingleThreadExecutor { runnable ->
        Thread(runnable, "fuzevpn-wireguard").apply { isDaemon = true }
    }
    @Volatile
    private var activeTunnel: ManagedTunnel? = null

    @Volatile
    private var activePeerKey: Key? = null

    private var connectedIdentity: Pair<String, String>? = null

    @Volatile
    private var stopping = false

    /** A cancelled worker call may still own the Go backend/TUN. */
    @Volatile
    private var operationUncertain = false

    fun getOrCreatePublicKey(accountId: String): String = runBackend(NO_TIMEOUT_MS) {
        val scope = SecureKeystoreStore.accountScope(accountId)
        val saved = secureStore.read(scope, PRIVATE_KEY_SLOT)
        val pair = if (saved == null) {
            KeyPair().also { secureStore.write(scope, PRIVATE_KEY_SLOT, it.privateKey.toBase64()) }
        } else {
            try {
                KeyPair(Key.fromBase64(saved))
            } catch (error: Exception) {
                secureStore.delete(scope, PRIVATE_KEY_SLOT)
                throw VpnNativeException("wireguard_identity_invalid", error)
            }
        }
        pair.publicKey.toBase64()
    }

    /**
     * Fingerprint an already enrolled WireGuard identity without creating,
     * deleting, or repairing any local material.  System resume uses this to
     * reject a snapshot when its account key changed after it was armed.
     */
    fun existingIdentityFingerprint(accountId: String): String = runBackend(NO_TIMEOUT_MS) {
        val scope = try {
            SecureKeystoreStore.accountScope(accountId)
        } catch (error: Exception) {
            throw VpnNativeException("invalid_account_id", error)
        }
        val saved = try {
            secureStore.read(scope, PRIVATE_KEY_SLOT, removeCorrupt = false)
        } catch (error: Exception) {
            throw VpnNativeException("wireguard_identity_store_failed", error)
        } ?: throw VpnNativeException("wireguard_identity_unavailable")
        val publicKey = try {
            KeyPair(Key.fromBase64(saved)).publicKey.toBase64()
        } catch (error: Exception) {
            throw VpnNativeException("wireguard_identity_invalid", error)
        }
        fingerprint(publicKey)
    }

    /** Evidence from the key actually loaded into this proven tunnel. */
    fun currentConnectionIdentityFingerprint(accountId: String): String = runBackend(NO_TIMEOUT_MS) {
        val identity = connectedIdentity
        if (operationUncertain || !isConnected() || identity?.first != accountId) {
            throw VpnNativeException("wireguard_identity_unavailable")
        }
        identity.second
    }

    /**
     * Brings WireGuard up and returns only after a fresh handshake is observed.
     * A merely established Android TUN interface is never reported as connected.
     */
    fun connect(
        request: WireGuardRequest,
        isCurrent: () -> Boolean = { true },
        requireExistingIdentity: Boolean = false,
        timing: NativeConnectionTiming.TraceContext? = null,
    ): Boolean = runBackend(CONNECT_TIMEOUT_MS) {
        if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
        if (operationUncertain) throw VpnNativeException("wireguard_operation_pending")
        connectedIdentity = null
        val privateKey = NativeConnectionTiming.span(timing, "wireguard_identity_config") {
            privateKeyFor(request.accountId, requireExistingIdentity)
        }
        val configuration = NativeConnectionTiming.span(timing, "wireguard_identity_config") {
            buildConfiguration(request, privateKey)
        }
        val identityFingerprint = fingerprint(KeyPair(Key.fromBase64(privateKey)).publicKey.toBase64())
        val tunnel = ManagedTunnel(TUNNEL_NAME) {
            if (!stopping && isCurrent()) onUnexpectedTunnelDown()
        }
        activeTunnel?.let {
            throw VpnNativeException("tunnel_already_active")
        }
        try {
            NativeConnectionTiming.span(timing, "wireguard_native_start") {
                backend.setState(tunnel, Tunnel.State.UP, configuration)
            }
            activeTunnel = tunnel
        } catch (error: Exception) {
            // GoBackend may have allocated its VpnService before surfacing a
            // failure. Confirm a DOWN transition before reporting the start
            // failure; otherwise retain the marker for a later explicit stop.
            val stopped = try {
                backend.setState(tunnel, Tunnel.State.DOWN, null)
                backend.getState(tunnel) == Tunnel.State.DOWN
            } catch (_: Exception) {
                false
            }
            activeTunnel = if (stopped) null else tunnel
            operationUncertain = !stopped
            throw error
        }

        val afterStart = System.currentTimeMillis()
        val peerKey = try {
            Key.fromBase64(request.serverPublicKey)
        } catch (error: Exception) {
            safeStop(tunnel)
            throw VpnNativeException("wireguard_configuration_invalid", error)
        }
        val connected = NativeConnectionTiming.span(timing, "wireguard_handshake_wait") {
            waitForHandshake(tunnel, peerKey, afterStart, isCurrent)
        }
        if (!connected) {
            safeStop(tunnel)
            false
        } else {
            activePeerKey = peerKey
            connectedIdentity = request.accountId to identityFingerprint
            operationUncertain = false
            true
        }
    }

    /** Does not start a second tunnel when the existing backend cannot stop. */
    fun disconnect(timing: NativeConnectionTiming.TraceContext? = null): Boolean {
        val tunnel = activeTunnel ?: return !operationUncertain
        return try {
            NativeConnectionTiming.span(timing, "wireguard_stop_worker") { runBackend(STOP_TIMEOUT_MS) {
                connectedIdentity = null
                stopping = true
                try {
                    backend.setState(tunnel, Tunnel.State.DOWN, null)
                    val stopped = backend.getState(tunnel) == Tunnel.State.DOWN
                    if (stopped) {
                        activeTunnel = null
                        activePeerKey = null
                        operationUncertain = false
                    } else {
                        // Never permit a different VPN to start unless the
                        // GoBackend has positively confirmed TUN teardown.
                        operationUncertain = true
                    }
                    stopped
                } finally {
                    stopping = false
                }
            } }
        } catch (_: TimeoutException) {
            operationUncertain = true
            false
        } catch (_: Exception) {
            operationUncertain = true
            false
        }
    }

    fun isConnected(): Boolean = activeTunnel?.let { backend.getState(it) == Tunnel.State.UP } == true

    fun statistics(): TunnelStatistics {
        val tunnel = activeTunnel ?: return TunnelStatistics()
        val peerKey = activePeerKey ?: return TunnelStatistics()
        return runBackend(STATISTICS_TIMEOUT_MS) {
            val peer = backend.getStatistics(tunnel).peer(peerKey)
                ?: return@runBackend TunnelStatistics()
            TunnelStatistics(
                receivedBytes = peer.rxBytes().coerceAtLeast(0L),
                sentBytes = peer.txBytes().coerceAtLeast(0L),
                latestHandshakeMillis = peer.latestHandshakeEpochMillis().takeIf { it > 0L },
            )
        }
    }

    fun clearAccountIdentity(accountId: String) {
        if (activeTunnel != null || operationUncertain) {
            throw VpnNativeException("wireguard_identity_in_use")
        }
        val scope = SecureKeystoreStore.accountScope(accountId)
        secureStore.delete(scope, PRIVATE_KEY_SLOT)
    }

    fun close() {
        backendExecutor.shutdownNow()
    }

    private fun privateKeyFor(accountId: String, requireExistingIdentity: Boolean): String {
        val scope = SecureKeystoreStore.accountScope(accountId)
        val saved = try {
            secureStore.read(scope, PRIVATE_KEY_SLOT, removeCorrupt = !requireExistingIdentity)
        } catch (error: Exception) {
            if (requireExistingIdentity) {
                throw VpnNativeException("wireguard_identity_store_failed", error)
            }
            throw error
        }
        if (saved != null) {
            if (requireExistingIdentity) {
                try {
                    KeyPair(Key.fromBase64(saved))
                } catch (error: Exception) {
                    throw VpnNativeException("wireguard_identity_invalid", error)
                }
            }
            return saved
        }
        if (requireExistingIdentity) throw VpnNativeException("wireguard_identity_unavailable")
        val pair = KeyPair()
        val privateKey = pair.privateKey.toBase64()
        secureStore.write(scope, PRIVATE_KEY_SLOT, privateKey)
        return privateKey
    }

    private fun fingerprint(value: String): String = MessageDigest.getInstance("SHA-256")
        .digest(value.toByteArray(StandardCharsets.UTF_8))
        .joinToString("") { byte -> "%02x".format(byte.toInt() and 0xff) }

    private fun buildConfiguration(request: WireGuardRequest, privateKey: String): Config {
        fun clean(value: String, field: String): String {
            if (value.isBlank() || value.length > MAX_CONFIGURATION_FIELD || value.any { it == '\n' || it == '\r' || it == '\u0000' }) {
                throw VpnNativeException("wireguard_configuration_invalid", IllegalArgumentException(field))
            }
            return value.trim()
        }

        if (request.dns.isEmpty() || request.allowedIps.isEmpty()) {
            throw VpnNativeException("wireguard_configuration_invalid")
        }

        // Parse with the official WireGuard config implementation rather than
        // hand-assembling socket/routing configuration. Inputs are sanitized
        // first so no remote field can inject another wg-quick directive.
        val text = buildString {
            appendLine("[Interface]")
            append("PrivateKey = ").append(clean(privateKey, "private_key")).appendLine()
            append("Address = ").append(request.network.addresses.joinToString(", ")).appendLine()
            append("DNS = ").append(request.dns.joinToString(", ") { clean(it, "dns") }).appendLine()
            appendLine()
            appendLine("[Peer]")
            append("PublicKey = ").append(clean(request.serverPublicKey, "server_public_key")).appendLine()
            append("Endpoint = ").append(clean(request.endpoint, "endpoint")).appendLine()
            append("AllowedIPs = ").append(request.allowedIps.joinToString(", ") { clean(it, "allowed_ips") }).appendLine()
            appendLine("PersistentKeepalive = 25")
        }
        return try {
            ByteArrayInputStream(text.toByteArray(StandardCharsets.UTF_8)).use(Config::parse)
        } catch (error: Exception) {
            throw VpnNativeException("wireguard_configuration_invalid", error)
        }
    }

    private fun waitForHandshake(tunnel: ManagedTunnel, peerKey: Key, afterStartMillis: Long, isCurrent: () -> Boolean): Boolean {
        val deadline = System.nanoTime() + TimeUnit.MILLISECONDS.toNanos(HANDSHAKE_TIMEOUT_MS)
        while (System.nanoTime() < deadline) {
            if (!isCurrent()) return false
            val stats = backend.getStatistics(tunnel).peer(peerKey)
            val latestHandshake = stats?.latestHandshakeEpochMillis() ?: 0L
            // A newly-created GoBackend tunnel cannot reuse an old peer
            // handshake. The small skew grace avoids rejecting a valid server
            // timestamp that is just behind the device clock.
            if (latestHandshake >= afterStartMillis - HANDSHAKE_CLOCK_SKEW_MS) return true
            try {
                Thread.sleep(HANDSHAKE_POLL_MS)
            } catch (_: InterruptedException) {
                Thread.currentThread().interrupt()
                return false
            }
        }
        return false
    }

    /**
     * Cleans up a failed WireGuard start without losing the active marker.
     * `setState(DOWN)` alone is not evidence that the backend released the
     * Android TUN: preserve the marker and block later connects on failure.
     */
    private fun safeStop(tunnel: ManagedTunnel) {
        connectedIdentity = null
        stopping = true
        val stopped = try {
            backend.setState(tunnel, Tunnel.State.DOWN, null)
            backend.getState(tunnel) == Tunnel.State.DOWN
        } catch (_: Exception) {
            // The state machine will surface the original connect failure. Do
            // not log a configuration or key while attempting cleanup.
            false
        } finally {
            stopping = false
        }
        if (stopped) {
            activeTunnel = null
            activePeerKey = null
            operationUncertain = false
        } else {
            activeTunnel = tunnel
            operationUncertain = true
        }
    }

    private fun <T> runBackend(timeoutMillis: Long, block: () -> T): T {
        val future = backendExecutor.submit<T> { block() }
        return try {
            if (timeoutMillis == NO_TIMEOUT_MS) {
                future.get()
            } else {
                future.get(timeoutMillis, TimeUnit.MILLISECONDS)
            }
        } catch (error: TimeoutException) {
            future.cancel(true)
            operationUncertain = true
            throw error
        } catch (error: ExecutionException) {
            val cause = error.cause
            if (cause is Exception) throw cause
            throw VpnNativeException("wireguard_start_failed", cause)
        }
    }

    private class ManagedTunnel(
        private val name: String,
        private val onUnexpectedDown: () -> Unit,
    ) : Tunnel {
        @Volatile
        private var state = Tunnel.State.DOWN

        override fun getName(): String = name

        override fun onStateChange(newState: Tunnel.State) {
            val wasUp = state == Tunnel.State.UP
            state = newState
            if (wasUp && newState == Tunnel.State.DOWN) onUnexpectedDown()
        }
    }

    companion object {
        private const val TUNNEL_NAME = "fuzevpn"
        private const val PRIVATE_KEY_SLOT = "fuzevpn.wireguard.private"
        private const val MAX_CONFIGURATION_FIELD = 512
        private const val STOP_TIMEOUT_MS = 10_000L
        private const val STATISTICS_TIMEOUT_MS = 2_000L
        private const val CONNECT_TIMEOUT_MS = 45_000L
        private const val HANDSHAKE_TIMEOUT_MS = 30_000L
        private const val HANDSHAKE_POLL_MS = 100L
        private const val HANDSHAKE_CLOCK_SKEW_MS = 2_000L
        private const val NO_TIMEOUT_MS = -1L
    }
}

internal class VpnNativeException(
    val code: String,
    cause: Throwable? = null,
) : Exception(code, cause)
