package com.fuzevpn.android

import android.content.Context
import com.wireguard.android.backend.Backend
import com.wireguard.android.backend.GoBackend
import com.wireguard.android.backend.Tunnel
import com.wireguard.config.Config
import com.wireguard.crypto.Key
import com.wireguard.crypto.KeyPair
import java.io.ByteArrayInputStream
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.util.concurrent.CancellationException
import java.util.concurrent.Executors
import java.util.concurrent.ExecutionException
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException
import java.util.concurrent.atomic.AtomicInteger

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
    backendFactory: (() -> Backend)? = null,
    private val timeouts: Timeouts = Timeouts(),
) {
    /** Upper bound of each call on the engine worker; tests may shorten them. */
    internal data class Timeouts(
        val connectMillis: Long = CONNECT_TIMEOUT_MS,
        val stopMillis: Long = STOP_TIMEOUT_MS,
        val statisticsMillis: Long = STATISTICS_TIMEOUT_MS,
        val identityMillis: Long = IDENTITY_TIMEOUT_MS,
    )

    private val appContext = context.applicationContext
    // GoBackend loads libwg-go, whose Go runtime probes the CPU immediately.
    // Keep idle/startup/OpenVPN paths independent of that native engine. The
    // first UP operation evaluates this thread-safe lazy value on our worker.
    private val backend: Backend by lazy { backendFactory?.invoke() ?: GoBackend(appContext) }
    private val backendExecutor = Executors.newSingleThreadExecutor { runnable ->
        Thread(runnable, "fuzevpn-wireguard").apply { isDaemon = true }
    }
    @Volatile
    private var activeTunnel: ManagedTunnel? = null

    @Volatile
    private var activePeerKey: Key? = null

    @Volatile
    private var activationStatistics: TunnelStatistics? = null

    @Volatile
    private var connectedIdentity: Pair<String, String>? = null

    @Volatile
    private var stopping = false

    /** A start or stop that did not confirm DOWN may still own the Go backend/TUN. */
    @Volatile
    private var operationUncertain = false

    /** The call now executing on the engine worker, if any. */
    @Volatile
    private var runningCall: WorkerCall? = null

    /** Bounded, and refused at once behind an abandoned start or stop. */
    fun getOrCreatePublicKey(accountId: String): String = runBackend(timeouts.identityMillis, expiredCode = "wireguard_operation_pending") {
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
     * A storage read on the caller thread: it never waits for the engine.
     */
    fun existingIdentityFingerprint(accountId: String): String = run {
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

    /** Evidence from the key actually loaded into this proven tunnel; never waits for the engine. */
    fun currentConnectionIdentityFingerprint(accountId: String): String = run {
        val identity = connectedIdentity
        if (isOperationUncertain() || !isConnected() || identity?.first != accountId) {
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
    ): Boolean = runBackend(timeouts.connectMillis, ownsTunnel = true) {
        if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
        if (operationUncertain) throw VpnNativeException("wireguard_operation_pending")
        // Refuse before touching the active tunnel's proof.
        activeTunnel?.let {
            throw VpnNativeException("tunnel_already_active")
        }
        connectedIdentity = null
        activationStatistics = null
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
        try {
            NativeConnectionTiming.span(timing, "wireguard_native_start") {
                activateBackend(tunnel, configuration, isCurrent)
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

        val peerKey = try {
            Key.fromBase64(request.serverPublicKey)
        } catch (error: Exception) {
            safeStop(tunnel)
            throw VpnNativeException("wireguard_configuration_invalid", error)
        }
        val connected = NativeConnectionTiming.span(timing, "wireguard_handshake_wait") {
            waitForHandshake(tunnel, peerKey, isCurrent)
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
        val tunnel = activeTunnel ?: return !isOperationUncertain()
        return try {
            NativeConnectionTiming.span(timing, "wireguard_stop_worker") { runBackend(timeouts.stopMillis, ownsTunnel = true) {
                connectedIdentity = null
                stopping = true
                try {
                    backend.setState(tunnel, Tunnel.State.DOWN, null)
                    val stopped = backend.getState(tunnel) == Tunnel.State.DOWN
                    if (stopped) {
                        releaseTunnel()
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
        } catch (_: Exception) {
            // Refused, expired or failed: unconfirmed unless released since.
            markStopUnconfirmed(tunnel)
            false
        }
    }

    fun isConnected(): Boolean = activeTunnel?.let { backend.getState(it) == Tunnel.State.UP } == true

    /** The successful activation read, scoped to the active instance/peer. */
    fun recoveryBaseline(): TunnelStatistics? = activationStatistics.takeIf {
        activeTunnel != null && activePeerKey != null && !isOperationUncertain()
    }

    /** A read never owns the TUN: its expiry leaves the tunnel's proof intact. */
    fun statistics(): TunnelStatistics {
        val tunnel = activeTunnel ?: return TunnelStatistics()
        val peerKey = activePeerKey ?: return TunnelStatistics()
        return runBackend(timeouts.statisticsMillis) {
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
        if (activeTunnel != null || isOperationUncertain()) {
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

    private fun activateBackend(tunnel: ManagedTunnel, configuration: Config, isCurrent: () -> Boolean) {
        val initializedBackend = backend
        // The first library load can take time. A request cancelled during
        // initialization must never start its prepared tunnel.
        if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
        initializedBackend.setState(tunnel, Tunnel.State.UP, configuration)
    }

    private fun waitForHandshake(tunnel: ManagedTunnel, peerKey: Key, isCurrent: () -> Boolean): Boolean {
        val deadline = System.nanoTime() + TimeUnit.MILLISECONDS.toNanos(HANDSHAKE_TIMEOUT_MS)
        while (System.nanoTime() < deadline) {
            if (!isCurrent()) return false
            val stats = backend.getStatistics(tunnel).peer(peerKey)
            val latestHandshake = stats?.latestHandshakeEpochMillis() ?: 0L
            // connect rejects an active/uncertain tunnel before activation, so
            // this new native instance cannot contain an earlier handshake.
            // Its statistics are scoped to this tunnel and the requested peer.
            // Any positive handshake proves this instance even if the local
            // wall clock moved or activation returned long after negotiation.
            if (latestHandshake > 0L) {
                activationStatistics = TunnelStatistics(
                    receivedBytes = stats!!.rxBytes().coerceAtLeast(0L),
                    sentBytes = stats.txBytes().coerceAtLeast(0L),
                    latestHandshakeMillis = latestHandshake,
                )
                return true
            }
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
            releaseTunnel()
        } else {
            activeTunnel = tunnel
            operationUncertain = true
        }
    }

    /** Positive DOWN confirmation; atomic with [markStopUnconfirmed]. */
    private fun releaseTunnel() = synchronized(this) {
        activeTunnel = null
        activePeerKey = null
        activationStatistics = null
        operationUncertain = false
    }

    private fun markStopUnconfirmed(tunnel: ManagedTunnel) = synchronized(this) {
        if (activeTunnel === tunnel) operationUncertain = true
    }

    /** An unconfirmed start or stop, or an abandoned one still on the worker. */
    private fun isOperationUncertain(): Boolean =
        operationUncertain || runningCall?.blocksWorker() == true

    /**
     * Runs [block] on the single engine worker for at most [timeoutMillis].
     * GoBackend's JNI calls ignore interruption, so an abandoned call may keep
     * the worker busy. Only a start or stop can own the TUN: while an expired
     * one runs, the instance is uncertain and new calls are refused at once
     * instead of queueing behind it. An expired read or key operation is only
     * slow: later calls wait for it within their own bound. A call that never
     * started is withdrawn and never runs.
     */
    private fun <T> runBackend(
        timeoutMillis: Long,
        ownsTunnel: Boolean = false,
        expiredCode: String? = null,
        block: () -> T,
    ): T {
        if (runningCall?.blocksWorker() == true) throw VpnNativeException("wireguard_operation_pending")
        val call = WorkerCall(ownsTunnel)
        val future = backendExecutor.submit<T> {
            if (!call.start()) throw CancellationException("wireguard_call_withdrawn")
            runningCall = call
            try {
                block()
            } finally {
                runningCall = null
                call.finish()
            }
        }
        return try {
            try {
                future.get(timeoutMillis, TimeUnit.MILLISECONDS)
            } catch (error: TimeoutException) {
                if (call.withdraw()) {
                    future.cancel(false)
                    throw VpnNativeException("wireguard_operation_pending", error)
                }
                // It finished exactly at the deadline: report its own outcome.
                if (!call.expire()) return future.get()
                future.cancel(true)
                throw if (expiredCode == null) error else VpnNativeException(expiredCode, error)
            }
        } catch (error: ExecutionException) {
            val cause = error.cause
            if (cause is Exception) throw cause
            throw VpnNativeException("wireguard_start_failed", cause)
        }
    }

    /** One worker call, shared by its caller and the worker thread. */
    private class WorkerCall(private val ownsTunnel: Boolean) {
        private val state = AtomicInteger(QUEUED)

        fun start() = state.compareAndSet(QUEUED, RUNNING)
        fun finish() = state.set(FINISHED)
        fun withdraw() = state.compareAndSet(QUEUED, WITHDRAWN)
        fun expire() = state.compareAndSet(RUNNING, EXPIRED)

        /** An abandoned start or stop may still own the TUN. */
        fun blocksWorker() = ownsTunnel && state.get() == EXPIRED

        private companion object {
            const val QUEUED = 0
            const val RUNNING = 1
            const val EXPIRED = 2
            const val FINISHED = 3
            const val WITHDRAWN = 4
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
        private const val IDENTITY_TIMEOUT_MS = 10_000L
    }
}

internal class VpnNativeException(
    val code: String,
    cause: Throwable? = null,
) : Exception(code, cause)
