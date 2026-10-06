package com.fuzevpn.android.openvpn

import com.fuzevpn.android.TunnelNetworkSpec

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Base64
import com.fuzevpn.android.OpenVpnService
import com.fuzevpn.android.NativeConnectionTiming
import com.fuzevpn.android.SecureKeystoreStore
import com.fuzevpn.android.TunnelStatistics
import com.fuzevpn.android.VpnNativeException
import com.fuzevpn.android.VpnStatus
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withTimeoutOrNull
import java.nio.charset.StandardCharsets
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.MessageDigest
import java.security.PrivateKey
import java.security.Signature
import java.security.cert.Certificate
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate
import java.security.spec.ECGenParameterSpec
import java.time.Instant
import java.util.Locale
import java.util.concurrent.Callable
import java.util.concurrent.ExecutionException
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

/**
 * Android-specific OpenVPN 3 Core host. It retains no private key outside the
 * Android Keystore and makes the Core ask synchronously for every certificate
 * or P-256 signature through [OpenVpnNative.Callback].
 */
internal class OpenVpnController(context: Context) {
    private val appContext = context.applicationContext
    private val secureStore = SecureKeystoreStore(appContext)
    private val operationMutex = Mutex()
    private val revocations = OpenVpnRevocation(
        readMarker = { account, device ->
            val identity = identityForGeneration(account, device, IdentityGeneration.LEGACY)
            secureStore.read(identity.scope, revocationSlot(identity.baseIdentityId), removeCorrupt = false)
        },
        writeMarker = { target ->
            val identity = identityForGeneration(target.accountId, target.deviceId, IdentityGeneration.LEGACY)
            secureStore.write(identity.scope, revocationSlot(identity.baseIdentityId), target.csrSha256)
        },
        removeMarker = { target ->
            val identity = identityForGeneration(target.accountId, target.deviceId, IdentityGeneration.LEGACY)
            secureStore.delete(identity.scope, revocationSlot(identity.baseIdentityId))
        },
    )
    private val nativeExecutor = Executors.newSingleThreadExecutor { runnable ->
        Thread(runnable, "fuzevpn-openvpn").apply { isDaemon = true }
    }
    private val sessionEvents = OpenVpnSessionEvents()
    val sessionGeneration: Long get() = sessionEvents.generation
    val sessionFailure: String? get() = sessionEvents.failureCode
    private val connectivityManager = appContext.getSystemService(ConnectivityManager::class.java)
    @Volatile
    private var nativeHandle: Long = 0L

    // Retained even after a timeout so the native executor can dispose of a
    // late-created handle before another session or identity edit is admitted.
    private var pendingCreation: OwnedNativeHandleCreation? = null

    @Volatile
    private var activeSession: ActiveSession? = null

    /** Last locally validated profile eligible for one no-API reconnect. */
    @Volatile
    private var lastValidatedSession: ActiveSession? = null

    /**
     * Connection-scoped evidence assembled while Core is started.  It is never
     * restored from storage: a process restart must use the strict resume
     * admission path instead.
     */
    @Volatile
    private var connectionIdentity: CurrentOpenVpnConnectionIdentity? = null

    /** A timed-out native call means a later call must not start another TUN. */
    @Volatile
    private var operationUncertain = false

    @Volatile
    var provenNetworkFamilies: List<String> = emptyList()
        private set

    private fun nativeCallback(generation: Long, identity: ActiveSession, network: TunnelNetworkSpec) = object : OpenVpnNative.Callback {
        override fun onNativeState(state: String, reason: String) {
            if ((state == "error" || state == "idle") && sessionGeneration == generation) {
                clearConnectionIdentity()
            }
            sessionEvents.publish(generation, OpenVpnNativeState.fromNative(state, reason))
        }

        override fun onTunConfiguration(planJson: String): Int =
            sessionEvents.callback(generation, -1) {
                OpenVpnService.establishForCore(planJson, network).also { fd ->
                    if (fd >= 0) provenNetworkFamilies = network.ipFamilies
                }
            }

        override fun onProtectSocket(fd: Int): Boolean =
            sessionEvents.callback(generation, false) { OpenVpnService.protectForCore(fd) }

        override fun onPkiCertificate(alias: String): String? = sessionEvents.callback(generation, null) {
            if (alias != identity.identityAlias) return@callback null
            try {
                secureStore.read(identity.scope, certificateSlot(identity.identityId))
                    ?.takeIf { isCertificatePem(it) }
            } catch (_: Exception) {
                null
            }
        }

        override fun onPkiSign(
            alias: String,
            dataBase64: String,
            algorithm: String,
            hashAlg: String,
            saltLen: String,
        ): String? = sessionEvents.callback(generation, null) {
            if (alias != identity.identityAlias) null
            else signForCore(alias, dataBase64, algorithm, hashAlg, saltLen)
        }
    }

    fun observeStates(): Flow<OpenVpnSessionEvent> = sessionEvents.flow

    fun isConnected(): Boolean = nativeHandle != 0L && sessionEvents.snapshot.isConnected() &&
        OpenVpnNative.isConnected(nativeHandle) == true

    fun networkLost() {
        clearConnectionIdentity()
        sessionEvents.interrupt("openvpn_reconnect_required")
    }

    fun permissionRevoked() {
        clearConnectionIdentity()
        sessionEvents.interrupt("tun_permission_revoked", requireProof = false)
    }

    fun cancelPendingConnection() {
        clearConnectionIdentity()
        sessionEvents.interrupt("session_operation_cancelled", requireProof = false)
    }

    fun isCoreAvailable(): Boolean = OpenVpnNative.isCoreAvailable()

    /**
     * Returns a stable digest of the already active OpenVPN identity.  This
     * path is strictly read-only: it never creates a CSR/key, clears a corrupt
     * record, or resolves a pending renewal/revocation cleanup.
     */
    fun existingIdentityFingerprint(accountId: String, deviceId: String): String {
        revocations.requireUsable(accountId, deviceId)
        val identity = identityFor(accountId, deviceId, removeCorrupt = false)
        if (pendingGeneration(identity, removeCorrupt = false) != null) {
            throw VpnNativeException("openvpn_renewal_required")
        }
        val csr = readResumeIdentityValue(identity, csrSlot(identity.identityId), "openvpn_csr_required")
        if (!isCsrPem(csr)) throw VpnNativeException("openvpn_csr_required")
        val existing = try {
            requireExistingIdentity(identity, removeCorrupt = false)
        } catch (error: VpnNativeException) {
            throw error
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_unavailable", error)
        }
        val certificate = readResumeIdentityValue(
            identity,
            certificateSlot(identity.identityId),
            "openvpn_profile_unavailable",
        )
        if (!isCertificatePem(certificate)) {
            throw VpnNativeException("openvpn_certificate_identity_mismatch")
        }
        val certificateNotAfter = certificateIdentityNotAfter(certificate, existing.keyMaterial)
            ?: throw VpnNativeException("openvpn_certificate_identity_mismatch")
        val storedNotAfter = try {
            readResumeIdentityValue(identity, notAfterSlot(identity.identityId), "openvpn_certificate_expiry_mismatch")
                .let(Instant::parse)
        } catch (error: VpnNativeException) {
            throw error
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_certificate_expiry_mismatch", error)
        }
        if (!sameCertificateInstant(storedNotAfter, certificateNotAfter)) {
            throw VpnNativeException("openvpn_certificate_expiry_mismatch")
        }
        val now = Instant.now()
        when {
            !certificateNotAfter.isAfter(now) -> throw VpnNativeException("openvpn_certificate_expired")
            !certificateNotAfter.isAfter(now.plusSeconds(RENEWAL_WINDOW_SECONDS)) ->
                throw VpnNativeException("openvpn_renewal_required")
        }
        val profile = readResumeIdentityValue(
            identity,
            profileSlot(identity.identityId),
            "openvpn_profile_unavailable",
        )
        if (profile.isBlank() || profile.toByteArray(StandardCharsets.UTF_8).size > MAX_PROFILE_LENGTH) {
            throw VpnNativeException("openvpn_profile_unavailable")
        }
        val networkFingerprint = try {
            secureStore.read(identity.scope, networkSlot(identity.identityId), removeCorrupt = false)
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_store_failed", error)
        }?.let { network ->
            try {
                TunnelNetworkSpec.decode(network)
            } catch (error: Exception) {
                throw VpnNativeException("openvpn_network_metadata_invalid", error)
            }
            network
        } ?: LEGACY_IPV4_NETWORK_FINGERPRINT
        return fingerprintIdentity(
            identity.generation.wireValue,
            csr,
            certificate,
            profile,
            networkFingerprint,
        )
    }

    /**
     * Returns evidence only while [confirmConnected] is publishing the proven
     * active tunnel. This deliberately never reads storage or calls JNI while
     * the session callback monitor is held; bootstrap, tile, and restart
     * admission continue to use [existingIdentityFingerprint].
     */
    fun currentConnectionIdentityFingerprint(accountId: String, deviceId: String): String {
        val connection = connectionIdentity
            ?: throw VpnNativeException("openvpn_connection_proof_missing")
        val now = Instant.now()
        if (!connection.certificateNotAfter.isAfter(now)) throw VpnNativeException("openvpn_certificate_expired")
        if (!connection.certificateNotAfter.isAfter(now.plusSeconds(RENEWAL_WINDOW_SECONDS))) {
            throw VpnNativeException("openvpn_renewal_required")
        }
        val active = activeSession
        if (active == null || active.accountId != accountId || active.deviceId != deviceId || !connection.isUsable(
                accountId = accountId,
                deviceId = deviceId,
                identityAlias = active.identityAlias,
                identityGeneration = active.generation.wireValue,
                nativeGeneration = sessionGeneration,
                nativeHandlePresent = nativeHandle != 0L,
                operationUncertain = operationUncertain,
                now = now,
                renewalWindowSeconds = RENEWAL_WINDOW_SECONDS,
            )) {
            throw VpnNativeException("openvpn_connection_proof_missing")
        }
        return connection.fingerprint
    }

    fun confirmConnected(publish: () -> Unit): Boolean {
        val generation = sessionGeneration
        // Query JNI outside the callback monitor: Core may be publishing an
        // interruption while holding its own state mutex.
        if (!isConnected()) return false
        var published = false
        val confirmed = sessionEvents.confirmConnected(generation) {
            val connection = connectionIdentity
            val active = activeSession
            if (connection != null && active != null && connection.nativeGeneration == generation &&
                connection.identityAlias == active.identityAlias &&
                connection.identityGeneration == active.generation.wireValue && connection.persisted) {
                connectionIdentity = connection.copy(confirmed = true)
                published = true
                publish()
            }
        }
        return confirmed && published
    }

    fun hasUsableNetwork(): Boolean = connectivityManager.allNetworks.any { network ->
        connectivityManager.getNetworkCapabilities(network)?.let { capabilities ->
            capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) &&
                capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) &&
                capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED)
        } == true
    }

    /**
     * Reuses the encrypted CSR and Keystore key for idempotent profile
     * creation. A caller that explicitly renews a profile gets a fresh P-256
     * identity only after the active tunnel has been stopped.
     */
    suspend fun getOrCreateCsr(accountId: String, deviceId: String, renewal: Boolean = false): String =
        operationMutex.withLock {
            clearConnectionIdentity()
            revocations.requireUsable(accountId, deviceId)
            if (!reconcilePendingCreationLocked() || nativeHandle != 0L || operationUncertain) {
                throw VpnNativeException("openvpn_identity_in_use")
            }
            val identity = if (renewal) {
                pendingRenewalIdentityFor(accountId, deviceId)
            } else {
                identityFor(accountId, deviceId)
            }
            val existing = try {
                secureStore.read(identity.scope, csrSlot(identity.identityId))
            } catch (error: Exception) {
                throw VpnNativeException("openvpn_identity_store_failed", error)
            }
            if (existing != null && isCsrPem(existing)) {
                try {
                    requireExistingIdentity(identity)
                    return@withLock existing
                } catch (error: VpnNativeException) {
                    if (!renewal) throw error
                    deleteIdentity(identity)
                }
            }
            if (existing != null) secureStore.delete(identity.scope, csrSlot(identity.identityId))

            val keyMaterial = try {
                getOrCreateP256Key(identity.identityAlias)
            } catch (error: Exception) {
                throw VpnNativeException("openvpn_key_generation_failed", error)
            }
            val csr = try {
                Pkcs10Csr.create(keyMaterial.certificate.publicKey, keyMaterial.privateKey)
            } catch (error: Exception) {
                throw VpnNativeException("openvpn_csr_generation_failed", error)
            }
            try {
                if (renewal) {
                    secureStore.writeAtomically(
                        identity.scope,
                        mapOf(
                            csrSlot(identity.identityId) to csr,
                            renewalPendingSlot(identity.baseIdentityId) to identity.generation.wireValue,
                        ),
                    )
                } else {
                    secureStore.write(identity.scope, csrSlot(identity.identityId), csr)
                }
            } catch (error: Exception) {
                if (renewal) runCatching { deleteIdentity(identity) }
                throw VpnNativeException("openvpn_identity_store_failed", error)
            }
            csr
        }

    /**
     * Reads only native encrypted metadata and the certificate itself. No
     * token, private key or profile crosses the Flutter boundary.
     */
    suspend fun certificateStatus(accountId: String, deviceId: String): OpenVpnCertificateStatus =
        operationMutex.withLock { certificateStatusLocked(accountId, deviceId) }

    private fun certificateStatusLocked(accountId: String, deviceId: String): OpenVpnCertificateStatus {
            val identity = identityFor(accountId, deviceId)
            val pending = pendingGeneration(identity)
            val certificate = try {
                secureStore.read(identity.scope, certificateSlot(identity.identityId))
            } catch (error: Exception) {
                throw VpnNativeException("openvpn_identity_store_failed", error)
            }
            if (certificate == null) {
                return OpenVpnCertificateStatus("missing", null, pending != null)
            }
            val notAfter = certificateNotAfter(certificate)
                ?: throw VpnNativeException("openvpn_profile_unavailable")
            val storedNotAfter = try {
                secureStore.read(identity.scope, notAfterSlot(identity.identityId))?.let(Instant::parse)
            } catch (error: Exception) {
                throw VpnNativeException("openvpn_profile_unavailable", error)
            }
            if (storedNotAfter == null || !sameCertificateInstant(storedNotAfter, notAfter)) {
                throw VpnNativeException("openvpn_certificate_expiry_mismatch")
            }
            val now = Instant.now()
            val status = when {
                !notAfter.isAfter(now) -> "expired"
                !notAfter.isAfter(now.plusSeconds(RENEWAL_WINDOW_SECONDS)) -> "expiring"
                else -> "valid"
            }
            return OpenVpnCertificateStatus(status, notAfter, pending != null)
        }

    /** Starts only after the Android service is ready and Core proves CONNECTED. */
    suspend fun connect(
        accountId: String,
        deviceId: String,
        activation: Map<String, Any?>,
        timing: NativeConnectionTiming.TraceContext? = null,
        isCurrent: () -> Boolean = { true },
    ): OpenVpnStartResult = operationMutex.withLock {
        clearConnectionIdentity()
        if (!isCurrent()) return@withLock failed("session_operation_cancelled")
        revocations.requireUsable(accountId, deviceId)
        val renewal = activation["renewal"] as? Boolean ?: false
        val previousIdentity = try {
            NativeConnectionTiming.span(timing, "openvpn_identity_load") { identityFor(accountId, deviceId) }
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        }
        val identity = try {
            NativeConnectionTiming.span(timing, "openvpn_identity_load") {
                if (renewal) requirePendingRenewalIdentity(previousIdentity) else previousIdentity
            }
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        }
        val pendingRenewal = try {
            NativeConnectionTiming.span(timing, "openvpn_identity_load") { pendingGeneration(previousIdentity) }
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        }
        if (!renewal && pendingRenewal != null) {
            return@withLock failed("openvpn_renewal_required")
        }
        if (nativeHandle != 0L || operationUncertain) {
            // A timed-out JNI call is not necessarily still running forever:
            // interruption cannot cancel native Core shutdown.  A later
            // explicit connect must therefore retry/finalize that same handle
            // instead of preserving operationUncertain until process death.
            if (!stopCurrentLocked(timing)) return@withLock failed("openvpn_operation_pending")
        }
        if (!OpenVpnNative.isCoreAvailable()) {
            return@withLock failed("openvpn_core_unavailable")
        }

        val profile = try {
            NativeConnectionTiming.span(timing, "openvpn_profile_validate") {
                OpenVpnActivation.from(activation, accountId, deviceId).toCanonicalProfile()
            }
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        } catch (_: Exception) {
            return@withLock failed("openvpn_activation_invalid")
        }

        val connection: CurrentOpenVpnConnectionIdentity
        try {
            // A server-issued certificate is valid only for the CSR/key pair
            // that created it. Never silently generate a replacement key here:
            // doing so would make an idempotent profile point to the wrong
            // non-exportable identity.
            val existing = NativeConnectionTiming.span(timing, "openvpn_key_csr_load") { requireExistingIdentity(identity) }
            val certificateNotAfter = NativeConnectionTiming.span(timing, "openvpn_certificate_validate") {
                validatedCertificateNotAfter(profile.certificatePem, existing.keyMaterial)
            }
            if (certificateNotAfter == null) {
                return@withLock failed("openvpn_certificate_identity_mismatch")
            }
            if (!sameCertificateInstant(profile.notAfter, certificateNotAfter)) {
                return@withLock failed("openvpn_certificate_expiry_mismatch")
            }
            val validatedProfile = profile.copy(notAfter = certificateNotAfter)
            val existingCertificate = NativeConnectionTiming.span(timing, "openvpn_certificate_read") {
                secureStore.read(previousIdentity.scope, certificateSlot(previousIdentity.identityId))
            }
            // A completed location migration may change only the node-specific
            // material. Never overwrite a locally stored client certificate
            // with a different PEM during that recovery path.
            val preserveExistingCertificate = activation["preserve_existing_certificate"] as? Boolean ?: false
            if (!renewal && preserveExistingCertificate &&
                !matchesStoredMigrationCertificate(
                    existingCertificate,
                    profile.certificatePem,
                )
            ) {
                return@withLock failed("openvpn_migration_certificate_mismatch")
            }
            if (!isCurrent()) return@withLock failed("session_operation_cancelled")
            NativeConnectionTiming.span(timing, "openvpn_identity_profile_persist") {
                persistActivation(identity, validatedProfile, renewal)
            }
            // This validates the persisted identity alongside the activation
            // material; it is not the strict resume re-read performed after a
            // connection in older builds.
            connection = newConnectionIdentity(
                identity = identity,
                csr = existing.csr,
                certificate = validatedProfile.certificatePem,
                canonicalProfile = validatedProfile.canonical,
                networkFingerprint = validatedProfile.network.encode(),
                certificateNotAfter = certificateNotAfter,
            )
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        } catch (_: Exception) {
            return@withLock failed("openvpn_identity_store_failed")
        }

        // A successful activation response now means that the target agent has
        // acknowledged the exact OpenVPN generation containing this profile.
        // The former fixed 35-second propagation grace only delayed an already
        // ready profile and is intentionally no longer used.
        if (!hasUsableNetwork()) return@withLock failed("network_unavailable")

        val started = startValidatedProfileLocked(identity, profile.canonical, profile.network, isCurrent, timing)
        if (started.isConnected()) {
            lastValidatedSession = identity
            if (renewal && previousIdentity.identityAlias != identity.identityAlias) {
                runCatching { deleteIdentity(previousIdentity) }
            }
            connectionIdentity = connection.copy(nativeGeneration = sessionGeneration)
        }
        started
    }

    /**
     * Performs the single automatic recovery allowed after a physical-network
     * loss. It uses only the authenticated local profile/identity; no API
     * request, CSR regeneration, or new certificate is attempted here.
     */
    suspend fun reconnectLocal(accountId: String, deviceId: String, expectedNetwork: TunnelNetworkSpec? = null, isCurrent: () -> Boolean = { true }): OpenVpnStartResult =
        operationMutex.withLock {
        clearConnectionIdentity()
        if (!isCurrent()) return@withLock failed("session_operation_cancelled")
        revocations.requireUsable(accountId, deviceId)
        // Recheck under the identity mutex: renewal can begin after the bridge
        // preflight while it is preparing the foreground service.
        val certificate = certificateStatusLocked(accountId, deviceId)
        OpenVpnRecoveryAttempt.profileFailure(certificate.status, certificate.renewalPending)?.let {
            return@withLock failed(it)
        }
        if (nativeHandle != 0L || operationUncertain) {
            if (!stopCurrentLocked()) return@withLock failed("openvpn_operation_pending")
        }
        if (!OpenVpnNative.isCoreAvailable()) return@withLock failed("openvpn_core_unavailable")
        val identity = try {
            identityFor(accountId, deviceId)
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        }
        val canonicalProfile = try {
            secureStore.read(identity.scope, profileSlot(identity.identityId))
                ?.takeIf { it.isNotBlank() && it.length <= MAX_PROFILE_LENGTH }
                ?: return@withLock failed("openvpn_profile_unavailable")
        } catch (_: Exception) {
            return@withLock failed("openvpn_profile_unavailable")
        }
        val certificateNotAfter: Instant
        val certificatePem: String
        val csr: String
        try {
            val notAfter = secureStore.read(identity.scope, notAfterSlot(identity.identityId))
                ?.let(Instant::parse)
                ?: return@withLock failed("openvpn_profile_unavailable")
            val now = Instant.now()
            if (!notAfter.isAfter(now)) return@withLock failed("openvpn_certificate_expired")
            if (!notAfter.isAfter(now.plusSeconds(RENEWAL_WINDOW_SECONDS))) {
                return@withLock failed("openvpn_renewal_required")
            }
            certificateNotAfter = notAfter
        } catch (_: Exception) {
            return@withLock failed("openvpn_profile_unavailable")
        }
        try {
            val existing = requireExistingIdentity(identity)
            val certificate = secureStore.read(identity.scope, certificateSlot(identity.identityId))
                ?: return@withLock failed("openvpn_profile_unavailable")
            val validatedNotAfter = validatedCertificateNotAfter(certificate, existing.keyMaterial)
                ?: return@withLock failed("openvpn_certificate_identity_mismatch")
            if (!sameCertificateInstant(certificateNotAfter, validatedNotAfter)) {
                return@withLock failed("openvpn_certificate_expiry_mismatch")
            }
            if (!validatedNotAfter.isAfter(Instant.now().plusSeconds(RENEWAL_WINDOW_SECONDS))) {
                return@withLock failed("openvpn_renewal_required")
            }
            certificatePem = certificate
            csr = existing.csr
        } catch (error: VpnNativeException) {
            return@withLock failed(error.code)
        } catch (_: Exception) {
            return@withLock failed("openvpn_profile_unavailable")
        }
        val networkFingerprint: String
        val network = try {
            val rawNetwork = secureStore.read(identity.scope, networkSlot(identity.identityId), removeCorrupt = false)
            networkFingerprint = rawNetwork ?: LEGACY_IPV4_NETWORK_FINGERPRINT
            TunnelNetworkSpec.decode(rawNetwork)
        } catch (_: Exception) {
            return@withLock failed("openvpn_network_metadata_invalid")
        }
        if (expectedNetwork != null && expectedNetwork != network) return@withLock failed("openvpn_network_metadata_invalid")
        val started = startValidatedProfileLocked(identity, canonicalProfile, network, isCurrent)
        if (started.isConnected()) {
            connectionIdentity = newConnectionIdentity(
                identity = identity,
                csr = csr,
                certificate = certificatePem,
                canonicalProfile = canonicalProfile,
                networkFingerprint = networkFingerprint,
                certificateNotAfter = certificateNotAfter,
                nativeGeneration = sessionGeneration,
            )
        }
        started
    }

    /**
     * A false result deliberately retains the native handle. The bridge then
     * refuses any replacement tunnel until the original stop is confirmed.
     */
    suspend fun disconnect(timing: NativeConnectionTiming.TraceContext? = null): Boolean = operationMutex.withLock { stopCurrentLocked(timing) }

    suspend fun statistics(): TunnelStatistics = operationMutex.withLock {
        val handle = nativeHandle
        if (handle == 0L) return@withLock TunnelStatistics()
        val values = OpenVpnNative.statistics(handle) ?: return@withLock TunnelStatistics()
        TunnelStatistics(receivedBytes = values[0], sentBytes = values[1])
    }

    /**
     * Removes one revoked OpenVPN identity while preserving the logical device,
     * account session and WireGuard material. A future OpenVPN enrollment must
     * create a fresh P-256 key and CSR, as required by the server CRL contract.
     */
    suspend fun pendingRevocation(accountId: String, deviceId: String): OpenVpnRevocationState? =
        operationMutex.withLock { revocations.pending(accountId, deviceId) }

    fun isRevocationBlocked(accountId: String, deviceId: String): Boolean = try {
        revocations.isBlocked(accountId, deviceId)
    } catch (_: Exception) { true }

    suspend fun cleanRevokedIdentity(
        target: RevokedOpenVpnIdentity,
        checkCurrent: () -> Unit,
        admitted: () -> Unit,
        clearTile: () -> Unit,
        publish: (OpenVpnRevocationState) -> Unit,
    ): OpenVpnRevocationState = operationMutex.withLock {
        clearConnectionIdentity()
        revocations.clean(target, checkCurrent,
            matchesCsr = {
                // Only the active CSR and the current pending renewal may authorize cleanup.
                val active = identityFor(target.accountId, target.deviceId)
                val candidates = listOfNotNull(active, pendingGeneration(active)?.let {
                    identityForGeneration(target.accountId, target.deviceId, it)
                })
                candidates.any { identity ->
                    secureStore.read(identity.scope, csrSlot(identity.identityId))?.let(::sha256) == target.csrSha256
                }
            },
            admitted = admitted,
            stop = {
                val active = activeSession
                if ((nativeHandle != 0L || operationUncertain) &&
                    (active?.accountId != target.accountId || active.deviceId != target.deviceId)) false
                else stopCurrentLocked()
            },
            clearIdentity = { clearIdentityLocked(target.accountId, target.deviceId) },
            clearTile = clearTile,
            publish = publish,
        )
    }

    suspend fun clearIdentity(accountId: String, deviceId: String) = operationMutex.withLock {
        clearConnectionIdentity()
        clearIdentityLocked(accountId, deviceId)
    }

    private fun clearIdentityLocked(accountId: String, deviceId: String) {
        if (!reconcilePendingCreationLocked() || nativeHandle != 0L || operationUncertain) {
            throw VpnNativeException("openvpn_identity_in_use")
        }
        try {
            val legacy = identityForGeneration(accountId, deviceId, IdentityGeneration.LEGACY)
            val alternate = identityForGeneration(accountId, deviceId, IdentityGeneration.ALTERNATE)
            deleteIdentity(legacy)
            deleteIdentity(alternate)
            secureStore.deleteAtomically(
                legacy.scope,
                setOf(
                    activeGenerationSlot(legacy.baseIdentityId),
                    renewalPendingSlot(legacy.baseIdentityId),
                ),
            )
            if (activeSession?.baseIdentityId == legacy.baseIdentityId) activeSession = null
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_clear_failed", error)
        }
    }

    suspend fun clearAccountIdentity(accountId: String) = operationMutex.withLock {
        clearConnectionIdentity()
        val scope = try {
            SecureKeystoreStore.accountScope(accountId)
        } catch (error: Exception) {
            throw VpnNativeException("invalid_account_id", error)
        }
        if (!reconcilePendingCreationLocked() || nativeHandle != 0L || operationUncertain) {
            throw VpnNativeException("openvpn_identity_in_use")
        }
        try {
            secureStore.deleteByKeyPrefix(scope, OPENVPN_SLOT_PREFIX)
            deleteKeyStoreAliases(accountAliasPrefix(accountId))
            if (lastValidatedSession?.accountId == accountId) lastValidatedSession = null
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_clear_failed", error)
        }
    }

    private fun failAndStopLocked(code: String): OpenVpnStartResult {
        clearConnectionIdentity()
        if (!operationUncertain && nativeHandle != 0L) stopCurrentLocked()
        return failed(code)
    }

    private fun stopCurrentLocked(timing: NativeConnectionTiming.TraceContext? = null): Boolean {
        clearConnectionIdentity()
        if (!reconcilePendingCreationLocked()) {
            publish(OpenVpnNativeState.error("openvpn_stop_timeout"))
            return false
        }
        val handle = nativeHandle
        if (handle == 0L) {
            activeSession = null
            if (!operationUncertain) publish(OpenVpnNativeState.idle())
            return !operationUncertain
        }
        sessionEvents.requestStop()
        return try {
            val stopAccepted = NativeConnectionTiming.span(timing, "openvpn_stop_worker") {
                callNative(STOP_TIMEOUT_MS) { OpenVpnNative.stop(handle) }
            }
            if (!stopAccepted || OpenVpnNative.isConnected(handle) != false) {
                operationUncertain = true
                publish(OpenVpnNativeState.error("openvpn_stop_timeout"))
                false
            } else {
                val destroyed = NativeConnectionTiming.span(timing, "openvpn_stop_worker") {
                    callNative(DESTROY_TIMEOUT_MS) { OpenVpnNative.destroy(handle) }
                }
                if (!destroyed) {
                    operationUncertain = true
                    publish(OpenVpnNativeState.error("openvpn_stop_timeout"))
                    return false
                }
                nativeHandle = 0L
                activeSession = null
                operationUncertain = false
                sessionEvents.finish()
                true
            }
        } catch (error: VpnNativeException) {
            publish(OpenVpnNativeState.error(error.code))
            false
        }
    }

    private suspend fun startValidatedProfileLocked(
        identity: ActiveSession,
        canonicalProfile: String,
        network: TunnelNetworkSpec,
        isCurrent: () -> Boolean,
        timing: NativeConnectionTiming.TraceContext? = null,
    ): OpenVpnStartResult {
        clearConnectionIdentity()
        if (!isCurrent()) return failed("session_operation_cancelled")
        activeSession = identity
        provenNetworkFamilies = emptyList()
        val generation = sessionEvents.begin()
        val handle = try {
            NativeConnectionTiming.span(timing, "openvpn_native_create") {
                createNativeHandleLocked(nativeCallback(generation, identity, network))
            }
        } catch (error: VpnNativeException) {
            activeSession = null
            return failed(error.code)
        }
        if (handle == 0L) {
            activeSession = null
            return failed("openvpn_core_unavailable")
        }
        nativeHandle = handle
        if (!isCurrent()) return failAndStopLocked("session_operation_cancelled")

        val started = try {
            NativeConnectionTiming.span(timing, "openvpn_native_start") { callNative(START_TIMEOUT_MS) {
                if (!isCurrent()) throw VpnNativeException("session_operation_cancelled")
                OpenVpnNative.start(handle, canonicalProfile, identity.identityAlias, network.expectedIpv4, network.expectedIpv6)
            } }
        } catch (error: VpnNativeException) {
            return failAndStopLocked(error.code)
        }
        if (!started) {
            return failAndStopLocked(sessionEvents.snapshot.messageCode() ?: "openvpn_start_failed")
        }

        val terminal = try {
            NativeConnectionTiming.spanSuspend(timing, "openvpn_handshake_wait") { withTimeoutOrNull(CONNECTION_TIMEOUT_MS) {
                sessionEvents.firstOutcome(generation).await()
            } }
        } catch (cancelled: CancellationException) {
            // No coroutine suspension here: the external executor stops and
            // joins Core before this operation releases its session mutex.
            stopCurrentLocked()
            throw cancelled
        }
        if (terminal?.isConnected() == true && isConnected()) {
            return OpenVpnStartResult.connected()
        }
        val code = terminal?.messageCode()
            ?: if (terminal?.isConnected() == true) "openvpn_connection_proof_missing"
            else "openvpn_connection_timeout"
        return failAndStopLocked(code)
    }

    private fun persistActivation(
        identity: ActiveSession,
        profile: CanonicalProfile,
        activateGeneration: Boolean,
    ) {
        clearConnectionIdentity()
        val values = mutableMapOf(
            certificateSlot(identity.identityId) to profile.certificatePem,
            caSlot(identity.identityId) to profile.caCertificatePem,
            tlsCryptSlot(identity.identityId) to profile.tlsCryptV2ClientKey,
            profileSlot(identity.identityId) to profile.canonical,
            networkSlot(identity.identityId) to profile.network.encode(),
            notAfterSlot(identity.identityId) to profile.notAfter.toString(),
        )
        if (activateGeneration) {
            values[activeGenerationSlot(identity.baseIdentityId)] = identity.generation.wireValue
        }
        secureStore.updateAtomically(
            identity.scope,
            values,
            if (activateGeneration) setOf(renewalPendingSlot(identity.baseIdentityId)) else emptySet(),
        )
    }

    private fun deleteIdentity(identity: ActiveSession) {
        connectionIdentity?.takeIf { it.identityAlias == identity.identityAlias }?.let {
            clearConnectionIdentity()
        }
        secureStore.deleteAtomically(
            identity.scope,
            setOf(
                csrSlot(identity.identityId),
                certificateSlot(identity.identityId),
                caSlot(identity.identityId),
                tlsCryptSlot(identity.identityId),
                profileSlot(identity.identityId),
                networkSlot(identity.identityId),
                notAfterSlot(identity.identityId),
            ),
        )
        keyStore().takeIf { it.containsAlias(identity.identityAlias) }?.deleteEntry(identity.identityAlias)
        if (lastValidatedSession?.identityAlias == identity.identityAlias) lastValidatedSession = null
    }

    private fun getOrCreateP256Key(alias: String): KeyMaterial {
        val store = keyStore()
        val existingPrivate = store.getKey(alias, null) as? PrivateKey
        val existingCertificate = store.getCertificate(alias)
        if (existingPrivate != null && existingCertificate != null &&
            existingCertificate.publicKey.algorithm.equals("EC", ignoreCase = true)
        ) {
            return KeyMaterial(existingPrivate, existingCertificate)
        }
        if (store.containsAlias(alias)) store.deleteEntry(alias)
        val generator = KeyPairGenerator.getInstance(KeyProperties.KEY_ALGORITHM_EC, ANDROID_KEYSTORE)
        generator.initialize(
            KeyGenParameterSpec.Builder(
                alias,
                KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY,
            )
                .setAlgorithmParameterSpec(ECGenParameterSpec("secp256r1"))
                // TLS External PKI commonly supplies the already-hashed
                // CertificateVerify input, so the non-exportable key must be
                // authorized for the explicit raw-digest path as well.
                .setDigests(
                    KeyProperties.DIGEST_NONE,
                    KeyProperties.DIGEST_SHA256,
                    KeyProperties.DIGEST_SHA384,
                    KeyProperties.DIGEST_SHA512,
                )
                .setUserAuthenticationRequired(false)
                .build(),
        )
        generator.generateKeyPair()
        val privateKey = store.getKey(alias, null) as? PrivateKey
            ?: throw VpnNativeException("openvpn_key_generation_failed")
        val certificate = store.getCertificate(alias)
            ?: throw VpnNativeException("openvpn_key_generation_failed")
        return KeyMaterial(privateKey, certificate)
    }

    private fun requireExistingIdentity(
        identity: ActiveSession,
        removeCorrupt: Boolean = true,
    ): ExistingIdentity {
        val csr = try {
            secureStore.read(identity.scope, csrSlot(identity.identityId), removeCorrupt)
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_store_failed", error)
        }
        if (csr == null || !isCsrPem(csr)) {
            throw VpnNativeException("openvpn_csr_required")
        }
        val store = keyStore()
        val privateKey = store.getKey(identity.identityAlias, null) as? PrivateKey
            ?: throw VpnNativeException("openvpn_identity_unavailable")
        val certificate = store.getCertificate(identity.identityAlias)
            ?: throw VpnNativeException("openvpn_identity_unavailable")
        if (!privateKey.algorithm.equals("EC", ignoreCase = true) ||
            !certificate.publicKey.algorithm.equals("EC", ignoreCase = true)
        ) {
            throw VpnNativeException("openvpn_identity_unavailable")
        }
        return ExistingIdentity(KeyMaterial(privateKey, certificate), csr)
    }

    private fun certificateNotAfter(certificatePem: String): Instant? = try {
        val certificates = CertificateFactory.getInstance("X.509")
            .generateCertificates(certificatePem.byteInputStream(StandardCharsets.US_ASCII))
        val leaf = certificates.firstOrNull() as? X509Certificate
        leaf?.notAfter?.toInstant()
    } catch (_: Exception) {
        null
    }

    private fun certificateIdentityNotAfter(
        certificatePem: String,
        keyMaterial: KeyMaterial,
    ): Instant? = try {
        val certificates = CertificateFactory.getInstance("X.509")
            .generateCertificates(certificatePem.byteInputStream(StandardCharsets.US_ASCII))
        val leaf = certificates.firstOrNull() as? X509Certificate ?: return null
        if (!MessageDigest.isEqual(leaf.publicKey.encoded, keyMaterial.certificate.publicKey.encoded)) {
            null
        } else {
            leaf.notAfter.toInstant()
        }
    } catch (_: Exception) {
        null
    }

    private fun validatedCertificateNotAfter(
        certificatePem: String,
        keyMaterial: KeyMaterial,
    ): Instant? = try {
        val notAfter = certificateIdentityNotAfter(certificatePem, keyMaterial) ?: return null
        CertificateFactory.getInstance("X.509")
            .generateCertificates(certificatePem.byteInputStream(StandardCharsets.US_ASCII))
            .firstOrNull()
            .let { it as? X509Certificate }
            ?.checkValidity()
        notAfter
    } catch (_: Exception) {
        null
    }

    private fun certificateMatchesKey(certificatePem: String, keyMaterial: KeyMaterial): Boolean =
        validatedCertificateNotAfter(certificatePem, keyMaterial) != null

    private fun sameCertificateInstant(left: Instant, right: Instant): Boolean =
        kotlin.math.abs(left.epochSecond - right.epochSecond) <= 1L

    private fun signForCore(
        alias: String,
        dataBase64: String,
        algorithm: String,
        hashAlg: String,
        saltLen: String,
    ): String? {
        val session = activeSession ?: return null
        if (alias != session.identityAlias || dataBase64.length !in 1..MAX_PKI_REQUEST_BASE64) return null
        val signatureAlgorithm = signatureAlgorithm(algorithm, hashAlg, saltLen) ?: return null
        val payload = try {
            Base64.decode(dataBase64, Base64.DEFAULT)
        } catch (_: IllegalArgumentException) {
            return null
        }
        return try {
            val key = keyStore().getKey(alias, null) as? PrivateKey ?: return null
            val signature = Signature.getInstance(signatureAlgorithm).run {
                initSign(key)
                update(payload)
                sign()
            }
            Base64.encodeToString(signature, Base64.NO_WRAP)
        } catch (_: Exception) {
            null
        } finally {
            payload.fill(0)
        }
    }

    private fun signatureAlgorithm(algorithm: String, hashAlg: String, saltLen: String): String? {
        if (!SAFE_NATIVE_TOKEN.matches(algorithm) ||
            (hashAlg.isNotEmpty() && !SAFE_NATIVE_TOKEN.matches(hashAlg)) ||
            (saltLen.isNotEmpty() && !SAFE_NATIVE_TOKEN.matches(saltLen))
        ) return null
        if (algorithm.lowercase(Locale.ROOT) !in setOf("ecdsa", "ec")) return null
        // OpenVPN 3's upstream OpenSSL XKey provider uses an empty hashalg for
        // a Sign request whose payload is already a TLS digest. DigestSign
        // supplies the hash name and the original message instead. Keep both
        // official contracts distinct so Android Keystore never re-hashes a
        // digest and never signs an unhashed message by mistake.
        if (hashAlg.isEmpty()) return "NONEwithECDSA"
        return when (hashAlg.lowercase(Locale.ROOT).replace("_", "")) {
            "sha256" -> "SHA256withECDSA"
            "sha384" -> "SHA384withECDSA"
            "sha512" -> "SHA512withECDSA"
            else -> null
        }
    }

    private fun createNativeHandleLocked(callback: OpenVpnNative.Callback): Long {
        try {
            val creation = OwnedNativeHandleCreation(
                nativeExecutor,
                create = { OpenVpnNative.create(callback) },
                destroy = OpenVpnNative::destroy,
            )
            pendingCreation = creation
            val handle = creation.awaitCreated(CREATE_TIMEOUT_MS)
            pendingCreation = null // Ownership transferred to nativeHandle by the caller.
            return handle
        } catch (error: Exception) {
            pendingCreation?.abandon()
            operationUncertain = pendingCreation != null
            if (error is InterruptedException) Thread.currentThread().interrupt()
            val code = if (error is TimeoutException || error is InterruptedException) {
                "openvpn_operation_timeout"
            } else "openvpn_native_failed"
            throw VpnNativeException(code, error)
        }
    }

    /** Called with the identity mutex held; success is a proof of destruction. */
    private fun reconcilePendingCreationLocked(): Boolean {
        val creation = pendingCreation ?: return true
        return try {
            if (!creation.awaitReleased(DESTROY_TIMEOUT_MS)) {
                operationUncertain = true
                false
            } else {
                pendingCreation = null
                operationUncertain = false
                activeSession = null
                true
            }
        } catch (error: Exception) {
            if (error is InterruptedException) Thread.currentThread().interrupt()
            operationUncertain = true
            false
        }
    }

    private fun <T> callNative(timeoutMillis: Long, block: () -> T): T {
        val future = nativeExecutor.submit(Callable { block() })
        return try {
            future.get(timeoutMillis, TimeUnit.MILLISECONDS)
        } catch (error: TimeoutException) {
            future.cancel(true)
            operationUncertain = true
            throw VpnNativeException("openvpn_operation_timeout", error)
        } catch (error: ExecutionException) {
            throw VpnNativeException("openvpn_native_failed", error.cause ?: error)
        } catch (error: InterruptedException) {
            Thread.currentThread().interrupt()
            operationUncertain = true
            throw VpnNativeException("openvpn_operation_timeout", error)
        }
    }

    private fun publish(state: OpenVpnNativeState) {
        sessionEvents.publish(sessionGeneration, state)
    }

    private fun failed(code: String): OpenVpnStartResult {
        clearConnectionIdentity()
        publish(OpenVpnNativeState.error(code))
        return OpenVpnStartResult(false, code)
    }

    private fun clearConnectionIdentity() {
        connectionIdentity = null
    }

    private fun newConnectionIdentity(
        identity: ActiveSession,
        csr: String,
        certificate: String,
        canonicalProfile: String,
        networkFingerprint: String,
        certificateNotAfter: Instant,
        nativeGeneration: Long = -1L,
    ): CurrentOpenVpnConnectionIdentity = CurrentOpenVpnConnectionIdentity(
        accountId = identity.accountId,
        deviceId = identity.deviceId,
        identityAlias = identity.identityAlias,
        identityGeneration = identity.generation.wireValue,
        nativeGeneration = nativeGeneration,
        certificateNotAfter = certificateNotAfter,
        fingerprint = fingerprintIdentity(
            identity.generation.wireValue,
            csr,
            certificate,
            canonicalProfile,
            networkFingerprint,
        ),
    )

    private fun identityFor(
        accountId: String,
        deviceId: String,
        removeCorrupt: Boolean = true,
    ): ActiveSession {
        val legacy = identityForGeneration(accountId, deviceId, IdentityGeneration.LEGACY)
        val generation = try {
            secureStore.read(
                legacy.scope,
                activeGenerationSlot(legacy.baseIdentityId),
                removeCorrupt,
            )
                ?.let(IdentityGeneration::fromWireValue)
                ?: IdentityGeneration.LEGACY
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_store_failed", error)
        }
        return identityForGeneration(accountId, deviceId, generation)
    }

    private fun pendingRenewalIdentityFor(accountId: String, deviceId: String): ActiveSession {
        val active = identityFor(accountId, deviceId)
        val recordedPending = pendingGeneration(active)
        if (recordedPending != null) {
            if (recordedPending == active.generation) {
                throw VpnNativeException("openvpn_renewal_state_invalid")
            }
            return identityForGeneration(accountId, deviceId, recordedPending)
        }
        val target = identityForGeneration(accountId, deviceId, active.generation.other())
        try {
            deleteIdentity(target)
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_clear_failed", error)
        }
        return target
    }

    private fun requirePendingRenewalIdentity(active: ActiveSession): ActiveSession {
        val pending = pendingGeneration(active)
            ?: throw VpnNativeException("openvpn_renewal_not_prepared")
        if (pending == active.generation) throw VpnNativeException("openvpn_renewal_state_invalid")
        return identityForGeneration(active.accountId, active.deviceId, pending)
    }

    private fun pendingGeneration(
        identity: ActiveSession,
        removeCorrupt: Boolean = true,
    ): IdentityGeneration? = try {
        secureStore.read(
            identity.scope,
            renewalPendingSlot(identity.baseIdentityId),
            removeCorrupt,
        )
            ?.let(IdentityGeneration::fromWireValue)
    } catch (error: Exception) {
        throw VpnNativeException("openvpn_identity_store_failed", error)
    }

    private fun identityForGeneration(
        accountId: String,
        deviceId: String,
        generation: IdentityGeneration,
    ): ActiveSession {
        try {
            SecureKeystoreStore.accountScope(accountId)
        } catch (error: Exception) {
            throw VpnNativeException("invalid_account_id", error)
        }
        if (!isSafeIdentifier(deviceId)) throw VpnNativeException("invalid_device_id")
        val scope = SecureKeystoreStore.accountScope(accountId)
        val baseId = sha256(deviceId).take(40)
        val id = if (generation == IdentityGeneration.LEGACY) baseId else "$baseId.b"
        val aliasSuffix = if (generation == IdentityGeneration.LEGACY) baseId else "$baseId.b"
        return ActiveSession(
            accountId = accountId,
            deviceId = deviceId,
            scope = scope,
            baseIdentityId = baseId,
            identityId = id,
            identityAlias = "${accountAliasPrefix(accountId)}$aliasSuffix",
            generation = generation,
        )
    }

    private fun accountAliasPrefix(accountId: String): String =
        "fuzevpn.ovpn.${sha256(accountId).take(32)}."

    private fun deleteKeyStoreAliases(prefix: String) {
        val store = keyStore()
        val aliases = store.aliases()
        while (aliases.hasMoreElements()) {
            val alias = aliases.nextElement()
            if (alias.startsWith(prefix)) store.deleteEntry(alias)
        }
    }

    private fun keyStore(): KeyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply { load(null) }

    private fun isSafeIdentifier(value: String): Boolean =
        value.isNotBlank() && value.length <= MAX_IDENTIFIER_LENGTH && value.none { it == '\u0000' || it == '\n' || it == '\r' }

    private fun sha256(value: String): String = MessageDigest.getInstance("SHA-256")
        .digest(value.toByteArray(StandardCharsets.UTF_8))
        .joinToString("") { "%02x".format(it.toInt() and 0xff) }

    private fun readResumeIdentityValue(
        identity: ActiveSession,
        slot: String,
        missingCode: String,
    ): String = try {
        secureStore.read(identity.scope, slot, removeCorrupt = false)
            ?: throw VpnNativeException(missingCode)
    } catch (error: VpnNativeException) {
        throw error
    } catch (error: Exception) {
        throw VpnNativeException("openvpn_identity_store_failed", error)
    }

    private fun fingerprintIdentity(vararg components: String): String {
        val digest = MessageDigest.getInstance("SHA-256")
        components.forEach { component ->
            digest.update(component.toByteArray(StandardCharsets.UTF_8))
            digest.update(0.toByte())
        }
        return digest.digest().joinToString("") { "%02x".format(it.toInt() and 0xff) }
    }

    private data class KeyMaterial(val privateKey: PrivateKey, val certificate: Certificate)

    private data class ExistingIdentity(val keyMaterial: KeyMaterial, val csr: String)

    private data class ActiveSession(
        val accountId: String,
        val deviceId: String,
        val scope: String,
        val baseIdentityId: String,
        val identityId: String,
        val identityAlias: String,
        val generation: IdentityGeneration,
    )

    private enum class IdentityGeneration(val wireValue: String) {
        LEGACY("a"),
        ALTERNATE("b");

        fun other(): IdentityGeneration = if (this == LEGACY) ALTERNATE else LEGACY

        companion object {
            fun fromWireValue(value: String): IdentityGeneration = entries.firstOrNull {
                it.wireValue == value
            } ?: throw VpnNativeException("openvpn_renewal_state_invalid")
        }
    }

    internal data class CanonicalProfile(
        val canonical: String,
        val certificatePem: String,
        val caCertificatePem: String,
        val tlsCryptV2ClientKey: String,
        val notAfter: Instant,
        val network: TunnelNetworkSpec,
    )

    internal data class OpenVpnActivation(
        val certificatePem: String,
        val caCertificatePem: String,
        val tlsCryptV2ClientKey: String,
        val endpoint: String,
        val dns: List<String>,
        val address: String,
        val serverName: String,
        val ciphers: List<String>,
        val notAfter: Instant,
        val network: TunnelNetworkSpec,
    ) {
        fun toCanonicalProfile(): CanonicalProfile {
            val canonical = buildString {
                appendLine("client")
                appendLine("dev tun")
                appendLine("proto udp4")
                // The documented endpoint has no port. The Android contract
                // fixes UDP/1194 and rejects every non-numeric endpoint.
                appendLine("remote $endpoint 1194")
                appendLine("nobind")
                appendLine("remote-cert-tls server")
                appendLine("verify-x509-name $serverName name")
                appendLine("EXTERNAL_PKI true")
                appendLine("AUTOLOGIN true")
                appendLine("auth-nocache")
                appendLine("allow-compression no")
                if (!network.dualStack) {
                    appendLine("block-ipv6")
                    appendLine("pull-filter ignore route-ipv6")
                    appendLine("pull-filter ignore ifconfig-ipv6")
                }
                appendLine("data-ciphers ${ciphers.joinToString(":")}")
                dns.forEach { appendLine("dhcp-option DNS $it") }
                appendLine("<ca>")
                appendLine(caCertificatePem.trim())
                appendLine("</ca>")
                appendLine("<tls-crypt-v2>")
                appendLine(tlsCryptV2ClientKey.trim())
                appendLine("</tls-crypt-v2>")
            }
            // Keep this byte limit identical to the JNI profile validator.
            // Character count is not sufficient because PEM/profile text is
            // passed to native as UTF-8.
            if (canonical.toByteArray(StandardCharsets.UTF_8).size > MAX_PROFILE_LENGTH) {
                throw VpnNativeException("profile_too_large")
            }
            return CanonicalProfile(canonical, certificatePem, caCertificatePem, tlsCryptV2ClientKey, notAfter, network)
        }

        companion object {
            fun from(values: Map<String, Any?>, accountId: String, deviceId: String): OpenVpnActivation {
                if (!isSafeIdentifierStatic(accountId)) throw VpnNativeException("invalid_account_id")
                val suppliedDeviceId = requiredText(values, "device_id", MAX_IDENTIFIER_LENGTH)
                if (suppliedDeviceId != deviceId || !isSafeIdentifierStatic(deviceId)) {
                    throw VpnNativeException("invalid_device_id")
                }
                val certificate = requiredPem(values, "certificate_pem", MAX_CERTIFICATE_LENGTH)
                val ca = requiredPem(values, "ca_certificate_pem", MAX_CERTIFICATE_LENGTH)
                val tlsCrypt = requiredPrintable(values, "tls_crypt_v2_client_key", MAX_TLS_CRYPT_LENGTH)
                val endpoint = requiredIpv4(requiredText(values, "endpoint", MAX_IPV4_LENGTH))
                val address = requiredAddress32(requiredText(values, "address", MAX_ADDRESS_LENGTH))
                val serverName = requiredText(values, "server_name", MAX_SERVER_NAME_LENGTH)
                if (!SERVER_NAME_PATTERN.matches(serverName)) throw VpnNativeException("openvpn_activation_invalid")
                if (values["remote_cert_tls_server"] != true) throw VpnNativeException("openvpn_tls_verification_required")
                val dns = requiredStringList(values, "dns", 1, MAX_DNS_SERVERS).map(::requiredIpv4)
                val ciphers = requiredStringList(values, "ciphers", 1, MAX_CIPHERS)
                if (ciphers.any { it !in MODERN_CIPHERS } || ciphers.distinct().size != ciphers.size) {
                    throw VpnNativeException("openvpn_cipher_invalid")
                }
                val notAfter = try {
                    Instant.parse(requiredText(values, "not_after", MAX_DATE_LENGTH))
                } catch (_: Exception) {
                    throw VpnNativeException("openvpn_activation_invalid")
                }
                if (!notAfter.isAfter(Instant.now())) throw VpnNativeException("openvpn_certificate_expired")
                return OpenVpnActivation(certificate, ca, tlsCrypt, endpoint, dns, address, serverName, ciphers, notAfter,
                    TunnelNetworkSpec.from(values, legacyOpenVpn = true))
            }

            private fun requiredText(values: Map<String, Any?>, name: String, maximum: Int): String =
                (values[name] as? String)?.trim()?.takeIf { it.isNotEmpty() && it.length <= maximum }
                    ?: throw VpnNativeException("openvpn_activation_invalid")

            private fun requiredPrintable(values: Map<String, Any?>, name: String, maximum: Int): String {
                val value = requiredText(values, name, maximum)
                if (value.any { it == '\u0000' || (it.code < 0x20 && it !in "\n\r\t") || it.code == 0x7f }) {
                    throw VpnNativeException("openvpn_activation_invalid")
                }
                return value
            }

            private fun requiredPem(values: Map<String, Any?>, name: String, maximum: Int): String {
                val value = requiredPrintable(values, name, maximum)
                if (!isCertificatePem(value)) throw VpnNativeException("openvpn_activation_invalid")
                return value
            }

            private fun requiredStringList(values: Map<String, Any?>, name: String, minimum: Int, maximum: Int): List<String> {
                val list = values[name] as? List<*> ?: throw VpnNativeException("openvpn_activation_invalid")
                if (list.size !in minimum..maximum) throw VpnNativeException("openvpn_activation_invalid")
                return list.map { value ->
                    (value as? String)?.trim()?.takeIf { it.isNotEmpty() && it.length <= MAX_LIST_ITEM_LENGTH }
                        ?: throw VpnNativeException("openvpn_activation_invalid")
                }
            }

            private fun requiredIpv4(value: String): String {
                val octets = value.split('.')
                if (octets.size != 4) throw VpnNativeException("openvpn_activation_invalid")
                val parsed = octets.map { octet ->
                    if (octet.isEmpty() || octet.length > 3 || octet.any { !it.isDigit() }) {
                        throw VpnNativeException("openvpn_activation_invalid")
                    }
                    octet.toIntOrNull()?.takeIf { it in 0..255 }
                        ?: throw VpnNativeException("openvpn_activation_invalid")
                }
                return parsed.joinToString(".")
            }

            private fun requiredAddress32(value: String): String {
                val separator = value.lastIndexOf('/')
                if (separator <= 0 || value.substring(separator + 1) != "32") {
                    throw VpnNativeException("openvpn_activation_invalid")
                }
                return "${requiredIpv4(value.substring(0, separator))}/32"
            }

            private fun isSafeIdentifierStatic(value: String): Boolean =
                value.isNotBlank() && value.length <= MAX_IDENTIFIER_LENGTH && value.none { it == '\u0000' || it == '\n' || it == '\r' }
        }
    }

    companion object {
        private const val ANDROID_KEYSTORE = "AndroidKeyStore"
        private const val OPENVPN_SLOT_PREFIX = "fuzevpn.openvpn."
        private const val MAX_IDENTIFIER_LENGTH = 128
        private const val MAX_PKI_REQUEST_BASE64 = 16 * 1024
        // Must stay synchronized with kMaxProfileBytes in openvpn_profile.cpp.
        private const val MAX_PROFILE_LENGTH = 64 * 1024
        private const val MAX_CERTIFICATE_LENGTH = 64 * 1024
        private const val MAX_TLS_CRYPT_LENGTH = 8 * 1024
        private const val MAX_IPV4_LENGTH = 15
        private const val MAX_ADDRESS_LENGTH = 18
        private const val MAX_SERVER_NAME_LENGTH = 253
        private const val MAX_DATE_LENGTH = 64
        private const val MAX_DNS_SERVERS = 8
        private const val MAX_CIPHERS = 3
        private const val MAX_LIST_ITEM_LENGTH = 64
        private const val CREATE_TIMEOUT_MS = 5_000L
        private const val START_TIMEOUT_MS = 10_000L
        private const val CONNECTION_TIMEOUT_MS = 30_000L
        private const val RENEWAL_WINDOW_SECONDS = 7L * 24L * 60L * 60L
        private const val LEGACY_IPV4_NETWORK_FINGERPRINT = "legacy_ipv4_network_v1"
        private const val STOP_TIMEOUT_MS = 10_000L
        private const val DESTROY_TIMEOUT_MS = 10_000L
        private val SERVER_NAME_PATTERN = Regex("^[A-Za-z0-9][A-Za-z0-9._-]{0,252}$")
        private val SAFE_NATIVE_TOKEN = Regex("^[A-Za-z0-9_]{1,32}$")
        private val MODERN_CIPHERS = setOf("AES-256-GCM", "AES-128-GCM", "CHACHA20-POLY1305")

        private fun csrSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.csr"
        private fun certificateSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.certificate"
        private fun caSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.ca"
        private fun tlsCryptSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.tls_crypt_v2"
        private fun profileSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.profile"
        private fun networkSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.network"
        private fun notAfterSlot(id: String) = "$OPENVPN_SLOT_PREFIX$id.not_after"
        private fun activeGenerationSlot(baseId: String) = "$OPENVPN_SLOT_PREFIX$baseId.active_generation"
        private fun renewalPendingSlot(baseId: String) = "$OPENVPN_SLOT_PREFIX$baseId.renewal_pending"
        private fun revocationSlot(baseId: String) = "$OPENVPN_SLOT_PREFIX$baseId.revocation_pending"

        private fun isCsrPem(value: String): Boolean =
            value.length <= MAX_CERTIFICATE_LENGTH &&
                value.trim().startsWith("-----BEGIN CERTIFICATE REQUEST-----") &&
                value.trim().endsWith("-----END CERTIFICATE REQUEST-----") &&
                value.none { it == '\u0000' }

        private fun isCertificatePem(value: String): Boolean =
            value.length <= MAX_CERTIFICATE_LENGTH &&
                value.trim().startsWith("-----BEGIN CERTIFICATE-----") &&
                value.trim().endsWith("-----END CERTIFICATE-----") &&
                value.none { it == '\u0000' }
    }
}

internal data class OpenVpnCertificateStatus(
    val status: String,
    val notAfter: Instant?,
    val renewalPending: Boolean,
) {
    fun toMap(): Map<String, Any?> = mapOf(
        "status" to status,
        "not_after" to notAfter?.toString(),
        "renewal_pending" to renewalPending,
    )
}

/**
 * A migration may replace node material but never a client certificate already
 * stored for the same Keystore-bound identity. A missing local certificate is
 * allowed for a first OpenVPN profile on an already migrated WireGuard device.
 */
internal fun matchesStoredMigrationCertificate(
    existingCertificate: String?,
    incomingCertificate: String,
): Boolean = existingCertificate == null || MessageDigest.isEqual(
    existingCertificate.toByteArray(StandardCharsets.UTF_8),
    incomingCertificate.toByteArray(StandardCharsets.UTF_8),
)

/** Normalized Core state: no endpoint, profile, certificate, or Core log text. */
internal data class OpenVpnNativeState private constructor(
    private val phase: Phase,
    private val code: String?,
) {
    enum class Phase { IDLE, CONNECTING, CONNECTED, DISCONNECTING, ERROR }

    fun toVpnStatus(): VpnStatus? = when (phase) {
        Phase.IDLE -> VpnStatus.IDLE
        Phase.CONNECTING -> VpnStatus.CONNECTING
        Phase.CONNECTED -> VpnStatus.CONNECTED
        Phase.DISCONNECTING -> VpnStatus.DISCONNECTING
        Phase.ERROR -> VpnStatus.ERROR
    }

    fun messageCode(): String? = code

    internal fun isConnectionTerminal(): Boolean = phase in setOf(Phase.CONNECTED, Phase.IDLE, Phase.ERROR)

    internal fun isConnected(): Boolean = phase == Phase.CONNECTED

    companion object {
        fun idle() = OpenVpnNativeState(Phase.IDLE, null)
        fun connecting(code: String? = null) = OpenVpnNativeState(
            Phase.CONNECTING,
            code?.let(::normalizedCode),
        )
        fun disconnecting() = OpenVpnNativeState(Phase.DISCONNECTING, null)
        fun error(code: String) = OpenVpnNativeState(Phase.ERROR, normalizedCode(code))

        fun fromNative(state: String, reason: String): OpenVpnNativeState = when (state) {
            "idle" -> idle()
            "connecting" -> connecting()
            "connected" -> OpenVpnNativeState(Phase.CONNECTED, null)
            "disconnecting" -> disconnecting()
            "error" -> error(reason)
            else -> error("connection_failed")
        }

        private fun normalizedCode(value: String): String =
            value.takeIf { it.matches(Regex("^[a-z0-9_]{1,96}$")) } ?: "connection_failed"
    }
}

internal data class OpenVpnStartResult(
    private val connected: Boolean,
    private val code: String?,
) {
    fun isConnected(): Boolean = connected
    fun messageCode(): String = code ?: "openvpn_start_failed"

    companion object {
        fun connected() = OpenVpnStartResult(true, null)
    }
}
