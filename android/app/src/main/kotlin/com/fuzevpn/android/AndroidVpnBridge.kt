package com.fuzevpn.android

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.VpnService
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkInfo
import android.net.NetworkRequest
import android.os.Build
import android.os.UserManager
import android.provider.Settings
import android.util.Log
import androidx.core.content.ContextCompat
import com.fuzevpn.android.openvpn.OpenVpnController
import com.fuzevpn.android.openvpn.OpenVpnRecoveryPolicy
import com.fuzevpn.android.openvpn.OpenVpnRecoveryAttempt
import com.fuzevpn.android.openvpn.OpenVpnRevocationState
import com.fuzevpn.android.openvpn.RevokedOpenVpnIdentity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.NonCancellable
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext
import kotlinx.coroutines.delay
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicLong
import java.lang.ref.WeakReference

/**
 * The sole native API exposed to Flutter. It serializes all tunnel transitions
 * on one coroutine so a failed stop can never race a second protocol startup.
 */
internal class AndroidVpnBridge(
    context: Context,
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private val appContext = context.applicationContext
    @Volatile
    // The process-retained bridge must never keep a destroyed FlutterActivity
    // alive while a user-owned VPN continues in the background.
    private var activityReference: WeakReference<Activity>? = null

    private var methodChannel: MethodChannel? = null
    private var eventChannel: EventChannel? = null
    // Last resort (C2-02): an escaped failure is logged by type only and never
    // reaches the process handler, which would also take a running tunnel down.
    private val lastResortHandler = CoroutineExceptionHandler { _, error ->
        Log.w(LOG_TAG, "Unhandled bridge operation failure: ${error.javaClass.simpleName}")
    }
    private val operationScope = CoroutineScope(SupervisorJob() + Dispatchers.IO + lastResortHandler)
    private val observerScope = CoroutineScope(SupervisorJob() + Dispatchers.IO + lastResortHandler)
    private val tunnelOperationMutex = Mutex()
    private val store = SecureKeystoreStore(appContext)
    private val guestCredentials = GuestCredentialStorage(
        read = { readStrict(it) },
        update = { values, deleted -> store.updateSlotsAtomically(values, deleted) },
    )
    private val guestOnboarding = GuestOnboardingStorage(
        read = { readStrict(it) },
        write = { slot, value -> writeSlot(slot, value) },
    )
    private val quickTileProfiles = QuickTileProfileStore(store) { VpnQuickTileService.requestUpdate(appContext) }
    private val resumeRegistry = SystemVpnResumeRegistry(
        readRaw = { SecureStorageKeyPolicy.systemVpnResume().let { store.read(it.scope, it.key, removeCorrupt = false) } },
        writeRaw = { writeSlot(SecureStorageKeyPolicy.systemVpnResume(), it); noteDurableResume(it) },
    )
    private val tunnelRequestEpoch = AtomicLong()
    // Automatic restoration owns publications without cancelling explicit commands.
    private val systemStartPublicationEpoch = AtomicLong()
    // Advanced under systemStartLock when an explicit command takes the tunnel
    // (invalidateSystemResume) and again when that mutex hold ends. A system
    // start that saw another value owns neither the engine, the durable record
    // nor the published state, even with the same request epoch (H-E22-N01-01).
    private val explicitAdmissionEpoch = AtomicLong()
    // Publication epoch of the last admitted system start that no longer owns
    // or attempts an engine: an older tile click may then run (H-E22-N01-02).
    private val releasedSystemStartEpoch = AtomicLong()
    // Tunnel-mutex hold state, read by closeTunnelHold at the end of each hold.
    private var explicitHoldOpen = false
    private var systemRestoreHoldOpen = false
    private var systemRestoreInstance = -1L
    private val publicationSequence = AtomicLong()
    private val tunnelInstanceEpoch = AtomicLong()
    private val physicalNetworks = PhysicalNetworkTracker<Network>()
    private val connectivity = appContext.getSystemService(ConnectivityManager::class.java)
    private val physicalNetworkRequest = NetworkRequest.Builder()
        .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
        .addCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN)
        .apply {
            // A VPN owner must observe physical networks even when its UID is
            // routed through the VPN. getAllNetworks and UID-filtered callbacks
            // otherwise describe different sets, leaving stale startup entries.
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) setIncludeOtherUidNetworks(true)
        }.build()
    private val wireGuardRecovery = WireGuardRecoveryPolicy()
    private var wireGuardRecoveryJob: Job? = null
    private var wireGuardRecoveryInstance = -1L
    private val systemStartLock = Any()
    @Volatile private var systemStartJob: Job? = null
    @Volatile private var resumeState = "unavailable"
    @Volatile private var resumeError: String? = null
    @Volatile private var resumeStorageFailure = false
    @Volatile private var systemStartInFlight = false
    // Restore after a process death (SystemVpnResumeSentinel). A restart that has not reserved
    // the record yet gives way to Android's own start (guarded by systemStartLock).
    private var processRestartUnreserved = false
    @Volatile private var resumeArmedInStorage = false
    // Sampled only while our tunnel is CONNECTED: isAlwaysOn() answers for an established VPN.
    @Volatile private var alwaysOnWhileEstablished: Boolean? = null
    // Explicit commands and host losses in progress: none of them may leave the restart armed.
    private val processRestartHolds = AtomicInteger()
    // The arming decision is computed and handed to the sentinel in one step, so a decision
    // computed before a stop's hold can never land after it.
    private val processRestartSyncLock = Any()
    @Volatile private var alwaysOnSampler: Job? = null
    private val stateLock = Any()
    private val sessionLifecycle = SessionLifecycle()
    private val sessionEndLock = Any()
    private var sessionEndTask: CompletableDeferred<SessionTermination>? = null
    @Volatile private var activeSessionEpoch = 0L
    // The callbacks below refer back to this bridge.  State the type explicitly
    // so Kotlin does not try to infer the property's type through that cycle.
    private val wireGuard: WireGuardController = WireGuardController(
        appContext,
        store,
        onUnexpectedTunnelDown = { dispatchAsync { ticket ->
            tunnelEndedUnexpectedly(VpnProtocol.WIREGUARD, ticket = ticket)
        } },
    )
    // This callback also reaches the bridge.  Avoid recursive inference from
    // the lazy delegate when compiling with Kotlin 2.3.
    private val openVpn: OpenVpnController by lazy {
        OpenVpnController(appContext)
    }

    @Volatile
    private var eventSink: EventChannel.EventSink? = null

    @Volatile
    private var currentState = VpnState()

    @Volatile
    private var activeProtocol: VpnProtocol? = null

    @Volatile
    private var activeAccountId: String? = null

    @Volatile
    private var activeDeviceId: String? = null

    @Volatile
    private var activeLocationId: String? = null

    @Volatile
    private var activeLocationName: String? = null
    private var wireGuardIpFamilies: List<String> = emptyList()

    @Volatile
    private var connectedAtMillis: Long? = null
    @Volatile private var provenConnectionProfile: QuickTileProfile? = null

    @Volatile
    private var permissionResult: MethodChannel.Result? = null
    private var permissionSessionEpoch = 0L
    @Volatile private var permissionDisclosureAccepted = false
    // Last answer of VpnService.prepare during an explicit user action. The
    // tile never probes it, and a tile click calls it only after its local
    // checks: prepare revokes another app's VPN (C2-01, QT-REVOKE-OVPN-01).
    @Volatile private var vpnPermissionMissing = false

    // Main-thread lifecycle state; never retains the Activity or a file path.
    private var diagnosticExport: DiagnosticExport<MethodChannel.Result>? = null
    private var diagnosticExportRequestCode: Int? = null
    private var nextDiagnosticExportRequestCode = DIAGNOSTIC_EXPORT_REQUEST_CODE_START

    @Volatile
    private var notificationPermissionPending = false

    private var openVpnEventsJob: Job? = null
    private val recoveryPolicy = OpenVpnRecoveryPolicy()
    private val recoveryLock = Any()
    @Volatile private var recoveryJob: Job? = null
    @Volatile private var recoveryOwnsSession = false
    @Volatile private var openVpnTransition = false
    private var handledFailureGeneration = 0L
    // Physical onLost count (callback thread) and its value when the current OpenVPN
    // engine start began. A loss in between saw status != CONNECTED; it is acted on at the proof.
    private val physicalLosses = AtomicLong()
    @Volatile private var openVpnStartLosses = 0L
    @Volatile private var revocationState: OpenVpnRevocationState? = null
    // False when Android refused the physical network callback. On Android 11 a proxy broadcast
    // (sent on every VPN network teardown) that reaches this process while it binds leaves the
    // process-wide ConnectivityManager on package android until the process dies: callbacks and
    // capabilities then throw SecurityException, calls without a package check still answer.
    private val physicalCallbackRegistered: Boolean
    // Without that callback: the default physical network followed through legacy readings (see
    // physicalNetworkVanished). Under recoveryLock; reset while OpenVPN is inactive.
    private val legacyDefaultNetwork = LegacyDefaultNetworkTracker<Network>()

    private data class RecoveryTarget(
        val request: Long,
        val generation: Long,
        val accountId: String,
        val deviceId: String,
        val locationId: String,
        val locationName: String,
        val networkChange: Boolean = false,
    )

    init {
        observeOpenVpnStates()
        // Observe physical network loss even before Core's keepalive expires.
        // A VPN's own disappearance must not trigger another recovery.
        physicalCallbackRegistered = try {
            connectivity.registerNetworkCallback(
                physicalNetworkRequest,
                object : ConnectivityManager.NetworkCallback() {
                    override fun onAvailable(network: Network) {
                        physicalNetworkChanged(network, false)
                    }

                    override fun onCapabilitiesChanged(network: Network, capabilities: NetworkCapabilities) {
                        physicalNetworkChanged(network, physicalNetworkUsable(capabilities))
                    }

                    override fun onLost(network: Network) {
                        physicalNetworkChanged(network, false)
                        physicalLosses.incrementAndGet()
                        // Decide from the callback alone: getAllNetworks() can still list the departing
                        // network as VALIDATED (run C), and a remaining network does not carry Core's
                        // already-connected socket (handover).
                        signalOpenVpnNetworkLoss()
                    }
                },
            )
            true
        } catch (_: SecurityException) {
            // This runs in Application.onCreate: throwing would kill every start of the process
            // (campaign vm31i, 10 of 40 cold starts). Never retried: no public API rebuilds that
            // manager, only a new process does.
            Log.w(LOG_TAG, "Physical network callback refused by Android: network changes are not observed in this process")
            false
        }
        if (!physicalCallbackRegistered) watchPhysicalNetworksWithoutCallback()
    }

    // Without the physical callback, Core alone notices a lost network only at its keepalive,
    // after a transfer has timed out (campaign vm31j). While OpenVPN is the active protocol, the
    // default physical network is read once a second without a package check, and its loss is
    // reported as onLost would have. Under recoveryLock, like handleOpenVpnFailure's own look.
    private fun watchPhysicalNetworksWithoutCallback() = observerScope.launch {
        while (true) {
            synchronized(recoveryLock) {
                if (activeProtocol == VpnProtocol.OPENVPN) {
                    if (physicalNetworkVanished()) {
                        physicalLosses.incrementAndGet()
                        signalOpenVpnNetworkLoss()
                    }
                } else {
                    legacyDefaultNetwork.reset()
                }
            }
            delay(1_000L)
        }
    }

    /**
     * Called under recoveryLock. True when the default physical network followed so far is lost
     * (see LegacyDefaultNetworkTracker.look): on a Wi-Fi return the cellular network stays listed,
     * lingers, then runs in the background where Core's traffic stops, which the callback reports
     * as onLost about 30 s later (campaign vm31k). Both readings go through the same per-app filter
     * in Android 11, but as separate calls: the tracker allows for a block changing in between.
     */
    @Suppress("DEPRECATION")
    private fun physicalNetworkVanished(): Boolean {
        val listed: Map<Network, LegacyDefaultNetworkTracker.Reading>
        val default: LegacyDefaultNetworkTracker.Reading?
        try {
            listed = connectivity.allNetworks.mapNotNull { network ->
                connectivity.getNetworkInfo(network)?.let(::legacyReading)?.let { network to it }
            }.toMap()
            // Our VPN's underlying networks are null: this describes the physical default network.
            default = connectivity.activeNetworkInfo?.let(::legacyReading)
        } catch (_: Exception) {
            return false
        }
        return legacyDefaultNetwork.look(listed, default)
    }

    @Suppress("DEPRECATION")
    private fun legacyReading(info: NetworkInfo): LegacyDefaultNetworkTracker.Reading? =
        if (info.type == ConnectivityManager.TYPE_VPN) null else LegacyDefaultNetworkTracker.Reading(
            info.type, info.extraInfo, when (info.detailedState) {
                NetworkInfo.DetailedState.CONNECTED, NetworkInfo.DetailedState.SUSPENDED -> LegacyDefaultNetworkTracker.State.FOLLOWED
                NetworkInfo.DetailedState.BLOCKED -> LegacyDefaultNetworkTracker.State.BLOCKED
                else -> LegacyDefaultNetworkTracker.State.OTHER
            },
        )

    private fun physicalNetworkUsable(capabilities: NetworkCapabilities?): Boolean = capabilities?.let {
        it.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) &&
            it.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) &&
            it.hasCapability(NetworkCapabilities.NET_CAPABILITY_TRUSTED) &&
            it.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED)
    } == true

    private fun physicalNetworkChanged(network: Network, usable: Boolean) {
        physicalNetworks.update(network, usable)
        operationScope.launch {
            withTunnelOperation {
                refreshWireGuardRecoveryLocked(sample = false)
                startWireGuardRecoveryObserverLocked()
            }
        }
    }

    private fun wireGuardRecoveryIsCurrent(): Boolean = activeProtocol == VpnProtocol.WIREGUARD &&
        wireGuardRecoveryInstance == tunnelInstanceEpoch.get() &&
        // Request epochs cancel command preparation, not a still-live tunnel.
        // Session and tunnel-instance fences remain authoritative until stop.
        sessionLifecycle.isCurrent(activeSessionEpoch) &&
        (currentState.status == VpnStatus.CONNECTED || currentState.isWireGuardRecovery)

    /** Called under the tunnel mutex; network generations reject a sample
     * that raced loss/return even while the backend worker was blocked. */
    private fun refreshWireGuardRecoveryLocked(sample: Boolean): TunnelStatistics? {
        if (!wireGuardRecoveryIsCurrent()) return null
        val physical = reconcilePhysicalNetworksLocked()
        wireGuardRecovery.updateNetwork(physical)
        val statistics = if (sample && physical.available) try {
            wireGuard.statistics()
        } catch (_: Exception) { null } else null
        val after = reconcilePhysicalNetworksLocked()
        wireGuardRecovery.updateNetwork(after)
        if (!wireGuardRecoveryIsCurrent()) return null
        if (physical.generation == after.generation) {
            wireGuardRecovery.observe(wireGuardRecoveryInstance, after.generation, statistics)
        }
        val status = if (wireGuardRecovery.state == WireGuardRecoveryPolicy.State.CONNECTED)
            VpnStatus.CONNECTED else VpnStatus.CONNECTING
        val code = wireGuardRecovery.state.messageCode
        if (currentState.status != status || currentState.messageCode != code) {
            synchronized(sessionLifecycle) {
                if (wireGuardRecoveryIsCurrent()) {
                    emitState(status, VpnProtocol.WIREGUARD, code)
                    try {
                        WireGuardForegroundNotifier.update(appContext, status,
                            isReconnecting = status == VpnStatus.CONNECTING,
                            isWaitingForNetwork = wireGuardRecovery.state == WireGuardRecoveryPolicy.State.WAITING_NETWORK)
                    } catch (_: Exception) { /* Keep peer proof independent of notification refresh. */ }
                }
            }
        }
        return statistics.takeIf { physical.generation == after.generation }
    }

    @Suppress("DEPRECATION")
    private fun reconcilePhysicalNetworksLocked(): PhysicalNetworkSnapshot {
        val before = physicalNetworks.snapshot()
        // Runs on the IO worker, never in NetworkCallback. This bounded local
        // fallback also covers Android 8–11, where include-other-UID is absent.
        val inventory = try {
            connectivity.allNetworks.filterTo(mutableSetOf()) {
                physicalNetworkUsable(connectivity.getNetworkCapabilities(it))
            }
        } catch (_: Exception) { null }
        if (inventory != null) physicalNetworks.reconcile(before.generation, inventory)
        return physicalNetworks.snapshot()
    }

    private fun startWireGuardRecoveryObserverLocked() {
        if (!wireGuardRecoveryIsCurrent() ||
            wireGuardRecoveryJob?.isActive == true) return
        val instance = wireGuardRecoveryInstance
        wireGuardRecoveryJob = observerScope.launch {
            while (true) {
                delay(1_000L)
                val pending = withTunnelOperation {
                    if (wireGuardRecoveryInstance != instance || !wireGuardRecoveryIsCurrent()) false
                    else {
                        refreshWireGuardRecoveryLocked(sample = currentState.isWireGuardRecovery)
                        wireGuardRecoveryIsCurrent()
                    }
                }
                if (!pending) break
            }
        }
    }

    private fun stopWireGuardRecoveryLocked() {
        wireGuardRecoveryJob?.cancel()
        wireGuardRecoveryJob = null
        wireGuardRecovery.stop()
        wireGuardRecoveryInstance = -1L
    }

    private fun checkRequest(epoch: Long) {
        if (tunnelRequestEpoch.get() != epoch) throw VpnNativeException("session_operation_cancelled")
    }

    private fun cancelSystemStart() = synchronized(systemStartLock) {
        tunnelRequestEpoch.incrementAndGet()
        systemStartJob?.cancel()
        systemStartJob = null
        systemStartInFlight = false
        processRestartUnreserved = false
    }

    /** Every caller is an explicit command holding the tunnel mutex. */
    private fun admitExplicitCommand() = synchronized(systemStartLock) {
        explicitHoldOpen = true
        explicitAdmissionEpoch.incrementAndGet()
    }

    /** Ends one tunnel-mutex hold, before another waiter can take the mutex. */
    private fun closeTunnelHold() = synchronized(systemStartLock) {
        if (explicitHoldOpen) {
            explicitHoldOpen = false
            explicitAdmissionEpoch.incrementAndGet()
        }
        if (systemRestoreHoldOpen) {
            // The admitted system start failed inside this hold: an older
            // tile click queued behind it may now connect.
            systemRestoreHoldOpen = false
            releasedSystemStartEpoch.set(systemStartPublicationEpoch.get())
        }
    }

    /** No newer admitted system start still owns or attempts the engine. */
    private fun systemStartAllows(publicationEpoch: Long): Boolean {
        val current = systemStartPublicationEpoch.get()
        return current == publicationEpoch || current == releasedSystemStartEpoch.get()
    }

    private fun invalidateSystemResume() {
        admitExplicitCommand()
        try { resumeRegistry.invalidate() }
        catch (error: Exception) {
            resumeStorageFailure = true
            resumeState = "blocked"
            resumeError = messageCode(error, "system_vpn_resume_storage_failed")
            throw error
        }
        resumeStorageFailure = false
        resumeState = "unavailable"
        resumeError = null
    }

    private fun readStrict(slot: SecureStorageSlot): String? = store.read(slot.scope, slot.key, removeCorrupt = false)

    private fun localSession(profile: QuickTileProfile): String = localSession(profile.accountId, profile.deviceId)

    private fun localSession(accountId: String, deviceId: String): String {
        if (readStrict(SecureStorageKeyPolicy.activeUser()) != accountId ||
            readStrict(SecureStorageKeyPolicy.currentDevice(accountId)) != deviceId) {
            throw VpnNativeException("system_vpn_resume_identity_changed")
        }
        val payload = readStrict(SecureStorageKeyPolicy.accountSession(accountId))
            ?: throw VpnNativeException("system_vpn_resume_session_invalid")
        if (validateSystemVpnSessionPayload(payload) == null) throw VpnNativeException("system_vpn_resume_session_invalid")
        if (sessionLifecycle.termination?.let { !it.complete } == true) throw VpnNativeException("session_ending")
        return payload
    }

    private fun localIdentity(profile: QuickTileProfile): String = when (profile.protocol) {
        VpnProtocol.WIREGUARD -> wireGuard.existingIdentityFingerprint(profile.accountId)
        VpnProtocol.OPENVPN -> openVpn.existingIdentityFingerprint(profile.accountId, profile.deviceId)
    }

    private fun recordProvenConnection(profile: QuickTileProfile, restoring: Boolean, sessionPayload: String? = null) {
        // Explicit starts retain their validated session only while holding the
        // operation mutex. Publication still checks the live session ticket,
        // request epoch and expiry. System restoration keeps its strict reads.
        val session = sessionPayload ?: localSession(profile)
        if (validateSystemVpnSessionPayload(session) == null) throw VpnNativeException("system_vpn_resume_session_invalid")
        val identity = if (restoring) localIdentity(profile) else when (profile.protocol) {
            VpnProtocol.WIREGUARD -> wireGuard.currentConnectionIdentityFingerprint(profile.accountId)
            VpnProtocol.OPENVPN -> openVpn.currentConnectionIdentityFingerprint(profile.accountId, profile.deviceId)
        }
        try {
            if (restoring) {
                if (resumeRegistry.complete(session, identity) == null) throw VpnNativeException("system_vpn_resume_identity_changed")
            } else {
                // Write the tile first: a failed durable resume write never arms a restart.
                quickTileProfiles.write(profile)
                resumeRegistry.arm(profile, session, identity)
            }
            resumeState = "ready"
            resumeError = null
            resumeStorageFailure = false
            provenConnectionProfile = profile
        } catch (error: Exception) {
            resumeStorageFailure = true
            resumeState = "blocked"
            resumeError = messageCode(error, "system_vpn_resume_storage_failed")
            throw error
        }
    }

    private fun systemProtectionSnapshot(refresh: Boolean = false): Map<String, Any?> {
        if (refresh && !systemStartInFlight && !resumeStorageFailure) {
            try {
                val record = resumeRegistry.snapshot()
                resumeState = when (record?.status) {
                    SystemVpnResumeStatus.READY -> "ready"
                    SystemVpnResumeStatus.RESERVED, SystemVpnResumeStatus.BLOCKED -> "blocked"
                    else -> "unavailable"
                }
                resumeError = record?.errorCode ?: if (record?.status == SystemVpnResumeStatus.RESERVED) "system_vpn_resume_blocked" else null
            } catch (error: Exception) {
                resumeState = "blocked"
                resumeError = messageCode(error, "system_vpn_resume_corrupt")
            }
        }
        val flags = runCatching { SharedVpnHost.systemFlags() }.getOrDefault(null to null)
        return mapOf("always_on" to flags.first, "lockdown" to flags.second,
            "resume_state" to resumeState, "resume_error" to resumeError)
    }

    /** Android callbacks only enqueue work. No worker join or storage access here. */
    internal fun onSystemVpnStart() { startSystemRestore(selfStarted = false) }

    /**
     * Sticky restart of SystemVpnResumeSentinel after a process death with Android's permanent
     * VPN on. Enqueues only: the restore shows nothing, writes nothing and starts no host before
     * every read-only check has passed.
     */
    internal fun onProcessRestart() { if (!startSystemRestore(selfStarted = true)) syncProcessRestart() }

    private fun startSystemRestore(selfStarted: Boolean): Boolean = synchronized(systemStartLock) {
        if (activeProtocol != null) return@synchronized false
        val running = systemStartJob
        if (running?.isActive == true) {
            // Android's own start supersedes a process restart that has not reserved the
            // record: the host Android started is the one that restore needs.
            if (selfStarted || !processRestartUnreserved) return@synchronized false
            running.cancel()
        }
        val epoch = tunnelRequestEpoch.get()
        val ticket = sessionLifecycle.ticket()
        // An explicit command may share this request epoch. Its admission, or
        // the end of a hold already admitted, ends this start's authority.
        val authority = explicitAdmissionEpoch.get()
        processRestartUnreserved = selfStarted
        systemStartInFlight = true
        systemStartJob = operationScope.launch(start = CoroutineStart.LAZY) {
            val job = coroutineContext[Job]
            var profile: QuickTileProfile? = null
            var admitted: Long? = null
            var restored = false
            var restoring: VpnState? = null
            // Android started the boot path's host; a process restart starts its own.
            var hostStarted = !selfStarted
            var outcome = "superseded"
            try {
                // Credential-encrypted storage is never read before first unlock.
                awaitUserUnlock(epoch)
                if (selfStarted) {
                    // Read-only: no write, no state, no notification, no prepare and no host
                    // until the record, the account, the consent and a network allow a restore.
                    try {
                        withTunnelOperation { checkProcessRestartEligible(epoch, ticket, authority) }
                        awaitSystemVpnNetwork(
                            isCurrent = { tunnelRequestEpoch.get() == epoch && sessionLifecycle.isCurrent(ticket) },
                            hasNetwork = { openVpn.hasUsableNetwork() },
                        )
                    } catch (cancelled: CancellationException) {
                        throw cancelled
                    } catch (skip: ProcessRestartSkip) {
                        throw skip
                    } catch (error: Exception) {
                        throw ProcessRestartSkip(messageCode(error, "system_vpn_resume_failed"))
                    }
                }
                val reserved = withTunnelOperation {
                    checkRequest(epoch)
                    sessionLifecycle.check(ticket)
                    // A queued system start may arrive behind a successful
                    // explicit start. It does not own that engine's cleanup.
                    if (activeProtocol != null || explicitAdmissionEpoch.get() != authority) {
                        throw CancellationException("system_vpn_start_superseded")
                    }
                    systemRestoreInstance = -1L
                    val saved = resumeRegistry.snapshot() ?: throw VpnNativeException("system_vpn_resume_unavailable")
                    if (!saved.isResumable) throw VpnNativeException(saved.errorCode ?: "system_vpn_resume_blocked")
                    profile = saved.profile
                    val session = localSession(saved.profile)
                    val identity = localIdentity(saved.profile)
                    // prepare() revokes another app's VPN: a process restart never takes one over.
                    if (selfStarted) checkPermanentVpnStillOurs()
                    ensureVpnAuthorized(publishFailure = !selfStarted)
                    if (selfStarted) synchronized(systemStartLock) {
                        // One step: before it, Android's own start supersedes this restart with
                        // nothing written; after it, that start finds this restart reserving.
                        if (systemStartJob !== job) throw CancellationException("system_vpn_start_superseded")
                        processRestartUnreserved = false
                    }
                    val reservation = resumeRegistry.reserve(session, identity)
                        ?: throw VpnNativeException("system_vpn_resume_identity_changed")
                    if (selfStarted) {
                        // Reserved before the host: a death from here on leaves RESERVED, which
                        // is never retried. A refused host start gives the record back.
                        try {
                            WireGuardForegroundNotifier.startProtocol(appContext, saved.profile.protocol,
                                VpnStatus.CONNECTING, isReconnecting = true)
                            SharedVpnHost.start(appContext)
                        } catch (error: Exception) {
                            runCatching { resumeRegistry.complete(session, identity) }
                            // A skipped restart shows nothing: no host ever gets this reconnecting text.
                            runCatching { WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE) }
                            throw ProcessRestartSkip(messageCode(error, "vpn_host_unavailable"))
                        }
                        hostStarted = true
                        Log.i(LOG_TAG, "Permanent VPN process restart: restoring")
                    }
                    // A rejected or superseded callback must not invalidate tile
                    // publications. Keep explicit command epochs untouched: a
                    // queued user stop must still stop an automatic connection.
                    synchronized(systemStartLock) {
                        checkRequest(epoch)
                        sessionLifecycle.check(ticket)
                        admitted = systemStartPublicationEpoch.incrementAndGet()
                    }
                    reservation
                }
                val target = reserved.profile
                synchronized(systemStartLock) {
                    checkRequest(epoch)
                    sessionLifecycle.check(ticket)
                    if (explicitAdmissionEpoch.get() != authority) throw CancellationException("system_vpn_start_superseded")
                    resumeState = "waiting_network"
                    emitState(VpnStatus.CONNECTING, target.protocol, "system_vpn_restoring")
                    restoring = synchronized(stateLock) { currentState }
                    WireGuardForegroundNotifier.startProtocol(appContext, target.protocol, VpnStatus.CONNECTING, isReconnecting = true)
                }
                awaitSystemVpnNetwork(
                    isCurrent = { tunnelRequestEpoch.get() == epoch && sessionLifecycle.isCurrent(ticket) },
                    hasNetwork = { openVpn.hasUsableNetwork() },
                )
                checkRequest(epoch)
                sessionLifecycle.check(ticket)
                resumeState = "restoring"
                when (target.protocol) {
                    VpnProtocol.WIREGUARD -> connectWireGuard(target.wireGuardRequest
                        ?: throw VpnNativeException("system_vpn_resume_corrupt"), ticket, epoch, restoring = true,
                        systemAuthority = authority)
                    VpnProtocol.OPENVPN -> reconnectOpenVpn(target, ticket, epoch, restoring = true,
                        recoveryConsumed = reserved.recoveryConsumed, systemAuthority = authority)
                }
                restored = true
                outcome = "restored"
            } catch (skip: ProcessRestartSkip) {
                outcome = "skipped " + skip.code
            } catch (_: CancellationException) {
                // A replacing operation owns shutdown and durable invalidation.
            } catch (error: Exception) {
                // Before its own host, a process restart blocks nothing and shows nothing: the
                // record stays READY for a reboot or an explicit connect.
                if (!hostStarted) {
                    outcome = "skipped " + messageCode(error, "system_vpn_resume_failed")
                } else withContext(NonCancellable) { withTunnelOperation {
                    outcome = "failed"
                    if (tunnelRequestEpoch.get() != epoch || !sessionLifecycle.isCurrent(ticket) ||
                        explicitAdmissionEpoch.get() != authority) return@withTunnelOperation
                    var code = messageCode(error, "system_vpn_resume_failed")
                    // Stop only an engine this restoration started.
                    if (activeProtocol != null && tunnelInstanceEpoch.get() == systemRestoreInstance) {
                        try { disconnectLocked(userInitiated = false) }
                        catch (stopError: Exception) { code = messageCode(stopError, code) }
                    }
                    try { resumeRegistry.block(code) }
                    catch (storageError: Exception) {
                        resumeStorageFailure = true
                        code = messageCode(storageError, "system_vpn_resume_storage_failed")
                    }
                    resumeState = "blocked"
                    resumeError = code
                    emitState(VpnStatus.ERROR, activeProtocol ?: profile?.protocol, code)
                    WireGuardForegroundNotifier.startProtocol(appContext, activeProtocol ?: profile?.protocol,
                        VpnStatus.ERROR, requiresAction = true)
                } }
            } finally {
                val orphan = synchronized(systemStartLock) {
                    if (tunnelRequestEpoch.get() == epoch && systemStartJob === job) {
                        systemStartInFlight = false
                        processRestartUnreserved = false
                    }
                    admitted?.let { if (!restored && systemStartPublicationEpoch.get() == it) releasedSystemStartEpoch.set(it) }
                    restoring.takeIf { !restored }
                }
                // A command may cancel this start without publishing (prepare,
                // storage or identity work): never leave its CONNECTING
                // "system_vpn_restoring" as the final state (A08-vpn-bridge-02).
                if (orphan != null) withContext(NonCancellable) { withTunnelOperation {
                    if (activeProtocol == null && synchronized(stateLock) { currentState } === orphan) {
                        disconnectLocked(userInitiated = false)
                    }
                } }
                if (selfStarted) {
                    // Fixed text and native codes only: the device proof of this path.
                    Log.i(LOG_TAG, "Permanent VPN process restart: $outcome")
                    if (!restored) syncProcessRestart()
                }
            }
        }.also { it.start() }
        true
    }

    private suspend fun awaitUserUnlock(epoch: Long) {
        while (!appContext.getSystemService(UserManager::class.java).isUserUnlocked) {
            checkRequest(epoch)
            delay(250)
        }
    }

    /** Read-only, under the tunnel mutex: a process restart may restore only from here. */
    private fun checkProcessRestartEligible(epoch: Long, ticket: Long, authority: Long) {
        checkRequest(epoch)
        sessionLifecycle.check(ticket)
        if (activeProtocol != null || explicitAdmissionEpoch.get() != authority) {
            throw CancellationException("system_vpn_start_superseded")
        }
        val saved = resumeRegistry.snapshot()?.takeIf { it.isResumable }
            ?: throw VpnNativeException("system_vpn_resume_unavailable")
        localSession(saved.profile)
        localIdentity(saved.profile)
        if (!vpnDisclosureAccepted()) throw VpnNativeException("vpn_disclosure_required")
        checkPermanentVpnStillOurs()
    }

    /** prepare() would take over the VPN of another app in this user: never after a death. */
    private fun checkPermanentVpnStillOurs() {
        if (foreignVpnPresent()) throw ProcessRestartSkip(ANOTHER_VPN_ACTIVE)
        // Best effort: Android 10 and 11 let the app read which app is the permanent VPN;
        // Android 12+ refuse the read, and the restore then relies on the check above.
        val permanent = try {
            Settings.Secure.getString(appContext.contentResolver, ALWAYS_ON_VPN_APP_SETTING)
        } catch (_: Throwable) {
            return
        }
        if (permanent != appContext.packageName) throw ProcessRestartSkip(NOT_PERMANENT_VPN)
    }

    // Our own VPN ended with the process: a VPN carrying this app's traffic now belongs to
    // another app of this user, which prepare() could revoke. A VPN of another profile or user
    // (work profile, Private Space) is listed by allNetworks but cannot be touched: ignore it.
    @Suppress("DEPRECATION")
    private fun foreignVpnPresent(): Boolean = try {
        val active = connectivity.activeNetwork
        active != null && try {
            connectivity.getNetworkCapabilities(active)?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true
        } catch (_: SecurityException) {
            // Android 11 system-package manager (see physicalCallbackRegistered): the legacy
            // type of the default network has no package check.
            connectivity.getNetworkInfo(active)?.type == ConnectivityManager.TYPE_VPN
        }
    } catch (_: Exception) {
        true
    }

    // Only logged: a skipped process restart shows and stores nothing.
    private class ProcessRestartSkip(val code: String) : Exception(code)

    internal fun captureHostLoss(): Pair<Long, Boolean> =
        tunnelInstanceEpoch.get() to (activeProtocol != null || systemStartInFlight)

    internal fun onVpnHostLost(cause: String, eventEpoch: Long, release: () -> Unit = {}) {
        if (tunnelInstanceEpoch.get() != eventEpoch) { release(); return }
        val protocol = activeProtocol
        val interruptedRestore = systemStartInFlight
        if (protocol == null && !interruptedRestore) { release(); return }
        cancelRecovery()
        cancelSystemStart()
        val epoch = tunnelRequestEpoch.get()
        connectedAtMillis = null
        if (protocol == VpnProtocol.OPENVPN) openVpn.permissionRevoked()
        emitState(VpnStatus.ERROR, protocol, cause)
        operationScope.launch { withTunnelOperation {
            if (tunnelRequestEpoch.get() != epoch || activeProtocol != protocol) return@withTunnelOperation
            var failure = cause
            try { disconnectLocked(userInitiated = false) }
            catch (error: Exception) { failure = messageCode(error, cause) }
            try { resumeRegistry.block(failure) }
            catch (error: Exception) {
                resumeStorageFailure = true
                failure = messageCode(error, "system_vpn_resume_storage_failed")
            }
            resumeState = "blocked"
            resumeError = failure
            emitState(VpnStatus.ERROR, protocol, failure)
        } }.invokeOnCompletion { release() }
    }

    private fun noteDurableResume(raw: String?) {
        resumeArmedInStorage = systemVpnResumeKeepsProcessRestart(raw)
        syncProcessRestart()
    }

    /** Null is no information (no host, or Android 8-9). */
    private fun noteAlwaysOn(value: Boolean?) {
        if (value == null || value == alwaysOnWhileEstablished) return
        alwaysOnWhileEstablished = value
        syncProcessRestart()
    }

    private fun syncProcessRestart() = synchronized(processRestartSyncLock) {
        SystemVpnResumeSentinel.sync(appContext, processRestartArmed(
            Build.VERSION.SDK_INT, BuildConfig.USE_PATCHED_WIREGUARD_AAR, processRestartHolds.get(),
            resumeArmedInStorage, alwaysOnWhileEstablished))
    }

    /** Until the returned release runs, nothing can re-arm the restart. The release is idempotent. */
    internal fun holdProcessRestart(): () -> Unit {
        processRestartHolds.incrementAndGet()
        syncProcessRestart()
        val released = AtomicBoolean()
        return {
            if (released.compareAndSet(false, true)) {
                processRestartHolds.decrementAndGet()
                syncProcessRestart()
            }
        }
    }

    private class ReleasingResult(private val target: MethodChannel.Result, private val release: () -> Unit) :
        MethodChannel.Result {
        override fun success(result: Any?) { release(); target.success(result) }
        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
            release(); target.error(errorCode, errorMessage, errorDetails)
        }
        override fun notImplemented() { release(); target.notImplemented() }
    }

    // Android sends no event when the permanent VPN is enabled for an app that is already
    // connected: sample it while CONNECTED so a later process death can be restored.
    private fun startAlwaysOnSampler() = synchronized(stateLock) {
        if (alwaysOnSampler?.isActive == true) return@synchronized
        alwaysOnSampler = observerScope.launch {
            while (true) {
                delay(ALWAYS_ON_SAMPLE_MS)
                if (currentState.status != VpnStatus.CONNECTED) break
                noteAlwaysOn(runCatching { SharedVpnHost.systemFlags().first }.getOrNull())
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val timing = NativeConnectionTiming.fromRpc(call.arguments)
        NativeConnectionTiming.mark(timing, "rpc_arrival")
        val sessionTicket = sessionLifecycle.ticket()
        // A clear-session request naming no known cause is refused before it
        // cancels anything (final reaudit B31).
        val endCause = if (call.method == "storageClearSession") SessionEndCause.of(call.arguments) else null
        // Cancel waits at command receipt, before a command waits for the native
        // transition mutex. A background retry must not outlive user intent.
        val holdsRestart = call.method in setOf("prepareTunnelRequest", "connectWireGuard", "connectOpenVpn", "disconnect",
            "clearOpenVpnIdentity", "storageClearSession") && (call.method != "storageClearSession" || endCause != null)
        // At receipt, before anything is queued: the restart after a process death is disarmed
        // until this command has answered, so no write in flight can re-arm it.
        val reply = if (holdsRestart) ReleasingResult(result, holdProcessRestart()) else result
        if (holdsRestart) {
            cancelRecovery()
            cancelSystemStart()
            // A connection can hold the transition mutex while awaiting its
            // native handshake. Wake that wait before queuing the stop behind it.
            if (call.method == "disconnect" && activeProtocol == VpnProtocol.OPENVPN) {
                openVpn.cancelPendingConnection()
            }
        }
        val requestEpoch = tunnelRequestEpoch.get()
        when (call.method) {
            "getState" -> launchResult(result) { stateSnapshotWithMetrics() }
            "getSystemVpnProtection" -> launchResult(result) { systemProtectionSnapshot(refresh = true) }
            "getDiagnosticMetadata" -> launchResult(result) { DiagnosticsMetadata.collect(appContext) }
            "getDiagnosticSnapshot" -> launchResult(result) {
                synchronized(stateLock) { DiagnosticSnapshot.fromState(currentState) }
            }
            "exportDiagnosticReport" -> exportDiagnosticReport(call, result)
            "openVpnSettings" -> {
                try { appContext.startActivity(SharedVpnHost.settingsIntent()); result.success(null) }
                catch (_: Exception) { result.error("vpn_settings_unavailable", "vpn_settings_unavailable", null) }
            }
            "prepareTunnelRequest" -> launchVoidResult(reply) { withTunnelOperation {
                requireAccountSession(sessionTicket, call.requireAccountId())
                checkRequest(requestEpoch)
                invalidateSystemResume()
            } }
            "getVpnDisclosureStatus" -> launchResult(result) {
                mapOf("accepted" to vpnDisclosureAccepted(),
                    "android_permission" to (prepareVpnService() == null))
            }
            "requestVpnPermission" -> requestVpnPermission(result, sessionTicket,
                (call.arguments as? Map<*, *>)?.get("disclosure_accepted") == true)
            "connectWireGuard" -> launchTunnelResult(reply, sessionTicket, requestEpoch, VpnProtocol.WIREGUARD, timing) {
                connectWireGuard(call.requireMap().toWireGuardRequest(), sessionTicket, requestEpoch = requestEpoch, timing = timing)
            }
            "connectOpenVpn" -> launchTunnelResult(reply, sessionTicket, requestEpoch, VpnProtocol.OPENVPN, timing) {
                connectOpenVpn(call.requireMap(), sessionTicket, requestEpoch, timing)
            }
            "disconnect" -> launchVoidResult(reply) { disconnect(userInitiated = true, ticket = sessionTicket, requestEpoch = requestEpoch, timing = timing) }
            "disconnectByUser" -> {
                if (SharedVpnHost.userStopOpensSettings()) {
                    try { appContext.startActivity(SharedVpnHost.settingsIntent()); result.success(null) }
                    catch (_: Exception) { result.error("vpn_settings_unavailable", "vpn_settings_unavailable", null) }
                } else {
                    val release = holdProcessRestart()
                    cancelSystemStart()
                    cancelRecovery()
                    if (activeProtocol == VpnProtocol.OPENVPN) openVpn.cancelPendingConnection()
                    val stopEpoch = tunnelRequestEpoch.get()
                    launchVoidResult(ReleasingResult(result, release)) { disconnect(userInitiated = true, ticket = sessionTicket, stopHost = true, requestEpoch = stopEpoch, timing = timing) }
                }
            }
            "getOrCreateWireGuardPublicKey" -> launchResult(result) {
                val accountId = call.requireAccountId()
                withTunnelOperation {
                    requireAccountSession(sessionTicket, accountId)
                    wireGuard.getOrCreatePublicKey(accountId)
                }
            }
            "getOrCreateOpenVpnCsr" -> launchResult(result) {
                val args = call.requireMap()
                val renewal = args["renewal"] as? Boolean ?: false
                withTunnelOperation {
                    requireAccountSession(sessionTicket, args.requiredString(ACCOUNT_ID))
                    openVpn.getOrCreateCsr(
                    args.requiredString(ACCOUNT_ID),
                    args.requiredString(DEVICE_ID),
                    renewal,
                )
                }
            }
            "getOpenVpnCertificateStatus" -> launchResult(result) {
                val args = call.requireMap()
                openVpn.certificateStatus(
                    args.requiredString(ACCOUNT_ID),
                    args.requiredString(DEVICE_ID),
                ).toMap()
            }
            "clearOpenVpnIdentity" -> launchVoidResult(reply) {
                val args = call.requireMap()
                clearOpenVpnIdentity(
                    args.requiredString(ACCOUNT_ID),
                    args.requiredString(DEVICE_ID),
                    sessionTicket,
                )
            }
            "getOpenVpnRevocation" -> launchResult(result) {
                val args = call.requireMap()
                withTunnelOperation {
                    val account = args.requiredString(ACCOUNT_ID)
                    requireAccountSession(sessionTicket, account)
                    openVpn.pendingRevocation(account, args.requiredString(DEVICE_ID))?.toMap()
                }
            }
            "cleanRevokedOpenVpnIdentity" -> launchResult(result) {
                val args = call.requireMap()
                cleanRevokedOpenVpnIdentity(RevokedOpenVpnIdentity(
                    args.requiredString(ACCOUNT_ID), args.requiredString(DEVICE_ID),
                    args.requiredString("csr_sha256"),
                ), sessionTicket).toMap()
            }
            "clearAccountIdentity" -> launchVoidResult(result) {
                val args = call.requireMap()
                clearAccountIdentity(args.requiredString(ACCOUNT_ID), ExpectedDeviceIdentity.fromArguments(args), sessionTicket)
            }
            "setNotificationLocale" -> {
                // A null language_code is "system language": Dart always sends the
                // key, null for the system language (C3-01); an absent key reads the same.
                val args = call.arguments as? Map<*, *>
                val rawLanguage = args?.get("language_code")
                val languageCode = NativeLocalePolicy.canonicalTag(rawLanguage as? String)
                if ((call.arguments != null && args == null) ||
                    (rawLanguage != null && (rawLanguage !is String || languageCode == null))) {
                    result.error("invalid_arguments", nativeErrorMessage("invalid_arguments"), null)
                } else {
                    VpnForegroundService.setLocale(appContext, languageCode)
                    WireGuardForegroundNotifier.relocalize()
                    result.success(null)
                }
            }
            "storageReadSession" -> launchResult(result) { sessionRead { readStoredSession() } }
            "storageReadSessionBinding" -> launchResult(result) { sessionRead { readStoredSessionBinding() } }
            "storageWritePendingSession" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) {
                    writeSlot(SecureStorageKeyPolicy.pendingSession(), call.requireMap().requiredString(PAYLOAD))
                }
            }
            "storageWriteAccountSession" -> launchVoidResult(result) {
                val args = call.requireMap()
                withTunnelOperation {
                    sessionLifecycle.activate(sessionTicket, prepare = { prepareStoredAccountSession(args) }) {
                        writeStoredAccountSession(args)
                    }
                }
                // A new session can make the tile's profile connectable again.
                VpnQuickTileService.requestUpdate(appContext)
            }
            "storageReadGuestCredential" -> launchResult(result) { sessionRead { guestCredentials.readCredential() } }
            "storageWriteGuestCredential" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) { guestCredentials.writeCredential(call.requireMap().requiredString("credential")) }
            }
            "storageReadPendingGuestCredential" -> launchResult(result) { guestCredentials.readCredential(pending = true) }
            "storageWritePendingGuestCredential" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) { guestCredentials.writeCredential(call.requireMap().requiredString("credential"), pending = true) }
            }
            "storageClearGuestCredentials" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) { guestCredentials.clear() }
            }
            "storageReadGuestAutoResume" -> launchResult(result) { sessionRead { guestCredentials.readAutoResume() } }
            "storageWriteGuestAutoResume" -> launchVoidResult(result) {
                val enabled = call.requireMap()["enabled"] as? Boolean ?: throw VpnNativeException("invalid_arguments")
                sessionLifecycle.mutate(sessionTicket) { guestCredentials.writeAutoResume(enabled) }
            }
            "storageReadGuestOnboardingCompleted" -> launchResult(result) {
                guestOnboarding.readCompleted(call.requireAccountId())
            }
            "storageWriteGuestOnboardingCompleted" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) {
                    guestOnboarding.complete(call.requireAccountId())
                }
            }
            "storageReplaceGuestSession" -> launchVoidResult(result) {
                val args = call.requireMap()
                withTunnelOperation { replaceStoredGuestSession(args, sessionTicket) }
            }
            "storageClearSession" -> {
                // Dart names the cause of the end; an unknown cause starts nothing (lot S review, P1).
                if (endCause == null) {
                    launchResult(result) { throw VpnNativeException("invalid_arguments") }
                } else {
                    val ending = endSession(endCause)
                    launchResult(reply) { ending.await().toMap() }
                }
            }
            "storageReadCurrentDevice" -> launchResult(result) {
                sessionRead { readSlot(SecureStorageKeyPolicy.currentDevice(call.requireAccountId())) }
            }
            "storageWriteCurrentDevice" -> launchVoidResult(result) {
                val args = call.requireMap()
                withTunnelOperation {
                    val slot = SecureStorageKeyPolicy.currentDevice(args.requiredString(ACCOUNT_ID))
                    val deviceId = args.requiredString(DEVICE_ID)
                    sessionLifecycle.mutate(sessionTicket, prepare = {
                        if (readStrict(slot) != deviceId) {
                            cancelSystemStart(); cancelRecovery(); invalidateSystemResume()
                        }
                    }) { writeSlot(slot, deviceId) }
                }
            }
            "storageClearCurrentDevice" -> launchVoidResult(result) {
                withTunnelOperation {
                    sessionLifecycle.mutate(sessionTicket, prepare = {
                        cancelSystemStart(); cancelRecovery(); invalidateSystemResume()
                    }) { deleteSlot(SecureStorageKeyPolicy.currentDevice(call.requireAccountId())) }
                }
            }
            "storageReadLocationMigration" -> launchResult(result) {
                readSlot(call.requireMap().locationMigrationSlot())
            }
            "storageWriteLocationMigration" -> launchVoidResult(result) {
                val args = call.requireMap()
                sessionLifecycle.mutate(sessionTicket) { writeSlot(args.locationMigrationSlot(), args.requiredString(PAYLOAD)) }
            }
            "storageClearLocationMigration" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) { deleteSlot(call.requireMap().locationMigrationSlot()) }
            }
            "storageReadThemeMode" -> launchResult(result) {
                readPreference(SecureAppPreference.THEME_MODE)
            }
            "storageWriteThemeMode" -> launchVoidResult(result) {
                writePreference(SecureAppPreference.THEME_MODE, call.requireMap().requiredString(VALUE))
            }
            "storageReadLocale" -> launchResult(result) {
                NativeLocalePolicy.canonicalTag(readPreference(SecureAppPreference.LOCALE))
            }
            "storageWriteLocale" -> launchVoidResult(result) { writeStoredLocale(call) }
            "storageReadProtocol" -> launchResult(result) {
                readPreference(SecureAppPreference.SELECTED_PROTOCOL)
            }
            "storageWriteProtocol" -> launchVoidResult(result) {
                writePreference(SecureAppPreference.SELECTED_PROTOCOL, call.requireMap().requiredString(VALUE))
            }
            "storageReadLocation" -> launchResult(result) {
                readPreference(SecureAppPreference.SELECTED_LOCATION)
            }
            "storageWriteLocation" -> launchVoidResult(result) {
                writePreference(SecureAppPreference.SELECTED_LOCATION, call.requireMap().requiredString(VALUE))
            }
            "storageReadFavoriteLocations" -> launchResult(result) {
                FavoriteLocations.decode(readPreference(SecureAppPreference.FAVORITE_LOCATIONS))
            }
            "storageWriteFavoriteLocations" -> launchVoidResult(result) {
                writePreference(SecureAppPreference.FAVORITE_LOCATIONS,
                    FavoriteLocations.encode(call.requireMap()[VALUE]))
            }
            "storageReadAutomaticDiagnostics" -> launchResult(result) {
                store.readAutomaticDiagnosticsConsent()
            }
            "storageWriteAutomaticDiagnostics" -> launchVoidResult(result) {
                val enabled = call.requireMap()[VALUE] as? Boolean ?: throw VpnNativeException("invalid_arguments")
                store.writeAutomaticDiagnosticsConsent(enabled)
            }
            "storageReadVerificationNeeded" -> launchResult(result) {
                readStoredVerificationNeeded(call.requireAccountId())
            }
            "storageWriteVerificationNeeded" -> launchVoidResult(result) {
                sessionLifecycle.mutate(sessionTicket) { writeStoredVerificationNeeded(call.requireMap()) }
            }
            else -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        eventSink = events
        events.success(stateSnapshot())
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    /** Called by [MainActivity] for VPN consent and the user-selected export. */
    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent? = null): Boolean {
        if (requestCode in DIAGNOSTIC_EXPORT_REQUEST_CODE_START..DIAGNOSTIC_EXPORT_REQUEST_CODE_END) {
            // A picker launched by a destroyed Activity must not finish a new export.
            if (requestCode == diagnosticExportRequestCode) finishDiagnosticExport(resultCode, data)
            return true
        }
        if (requestCode != VPN_PERMISSION_REQUEST_CODE) return false
        val result = permissionResult ?: return true
        val ticket = permissionSessionEpoch
        val disclosed = permissionDisclosureAccepted
        permissionResult = null
        permissionDisclosureAccepted = false
        completeVpnPermission(result, ticket, disclosed && resultCode == Activity.RESULT_OK)
        return true
    }

    /** Called by [MainActivity] for the optional notification permission only. */
    fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        if (requestCode != NOTIFICATION_PERMISSION_REQUEST_CODE) return false
        notificationPermissionPending = false
        if (grantResults.firstOrNull() != PackageManager.PERMISSION_GRANTED) {
            // This does not block a tunnel; Android still retains the required
            // system disclosure for active VPNs.
            emitState(currentState.status, currentState.protocol, "notifications_denied")
        }
        return true
    }

    /**
     * Releases one Flutter engine/activity without tearing down a user-owned
     * foreground tunnel. The retained runtime is attached again by the next
     * [MainActivity], preserving background VPN control after task recreation.
     */
    fun detachFromActivity(leavingActivity: Activity) {
        if (currentActivity() !== leavingActivity) return
        methodChannel?.setMethodCallHandler(null)
        eventChannel?.setStreamHandler(null)
        methodChannel = null
        eventChannel = null
        eventSink = null
        activityReference = null
        permissionResult?.error("activity_destroyed", "activity_destroyed", null)
        permissionResult = null
        permissionDisclosureAccepted = false
        abandonDiagnosticExport()
    }

    private fun attach(newActivity: Activity, messenger: BinaryMessenger) {
        if (currentActivity() !== newActivity) abandonDiagnosticExport()
        methodChannel?.setMethodCallHandler(null)
        eventChannel?.setStreamHandler(null)
        activityReference = WeakReference(newActivity)
        methodChannel = MethodChannel(messenger, METHOD_CHANNEL).also { it.setMethodCallHandler(this) }
        eventChannel = EventChannel(messenger, EVENT_CHANNEL).also { it.setStreamHandler(this) }
    }

    private fun exportDiagnosticReport(call: MethodCall, result: MethodChannel.Result) {
        if (diagnosticExport != null) {
            result.error("diagnostic_export_in_progress", "diagnostic_export_in_progress", null)
            return
        }
        try {
            val host = currentActivity() ?: throw VpnNativeException("activity_destroyed")
            if (nextDiagnosticExportRequestCode > DIAGNOSTIC_EXPORT_REQUEST_CODE_END) {
                throw VpnNativeException("diagnostic_export_failed")
            }
            val json = (call.arguments as? Map<*, *>)?.get("json") as? String
                ?: throw VpnNativeException("diagnostic_export_invalid")
            val export = DiagnosticExport(DiagnosticExport.payload(json), result)
            diagnosticExport = export
            val requestCode = nextDiagnosticExportRequestCode++
            diagnosticExportRequestCode = requestCode
            val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                addCategory(Intent.CATEGORY_OPENABLE)
                type = "application/json"
                putExtra(Intent.EXTRA_TITLE, "fuzevpn-diagnostic.json")
                putExtra(Intent.EXTRA_LOCAL_ONLY, true)
                addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            host.startActivityForResult(intent, requestCode)
        } catch (error: Exception) {
            diagnosticExport?.abandon()
            diagnosticExport = null
            diagnosticExportRequestCode = null
            val code = messageCode(error, "diagnostic_export_failed")
            result.error(code, code, null)
        }
    }

    private fun finishDiagnosticExport(resultCode: Int, data: Intent?) {
        val export = diagnosticExport ?: return
        if (export.writing) return
        if (resultCode != Activity.RESULT_OK) {
            diagnosticExport = null
            diagnosticExportRequestCode = null
            export.abandon()?.success(false)
            return
        }
        val uri = data?.data
        if (uri?.scheme != "content") {
            diagnosticExport = null
            diagnosticExportRequestCode = null
            export.abandon()?.error("diagnostic_export_failed", "diagnostic_export_failed", null)
            return
        }
        if (!export.beginWrite()) return
        operationScope.launch {
            val succeeded = try {
                appContext.contentResolver.openOutputStream(uri, "wt")?.use { it.write(export.bytes) }
                    ?: throw IllegalStateException()
                true
            } catch (_: Exception) { false }
            finally { export.erase() }
            withContext(Dispatchers.Main) {
                if (diagnosticExport === export) {
                    diagnosticExport = null
                    diagnosticExportRequestCode = null
                }
                export.takeRecipient()?.let { result ->
                    if (succeeded) result.success(true)
                    else result.error("diagnostic_export_failed", "diagnostic_export_failed", null)
                }
            }
        }
    }

    private fun abandonDiagnosticExport() {
        diagnosticExport?.abandon()?.error("activity_destroyed", "activity_destroyed", null)
        diagnosticExport = null
        diagnosticExportRequestCode = null
    }

    private fun requestVpnPermission(result: MethodChannel.Result, ticket: Long, disclosed: Boolean) {
        // Keystore reads remain off the main thread. No disclosure state is
        // adopted merely because an older installation has Android permission.
        operationScope.launch {
            try {
                val accepted = vpnDisclosureAccepted()
                withContext(Dispatchers.Main) { beginVpnPermission(result, ticket, disclosed, accepted) }
            } catch (error: Throwable) {
                val code = messageCode(error, "secure_storage_read_failed")
                withContext(Dispatchers.Main) { result.error(code, code, null) }
            }
        }
    }

    private fun beginVpnPermission(result: MethodChannel.Result, ticket: Long, disclosed: Boolean, accepted: Boolean) {
        if (!sessionLifecycle.isCurrent(ticket)) {
            result.error("session_operation_cancelled", "session_operation_cancelled", null)
            return
        }
        if (permissionResult != null) {
            result.error("permission_request_in_progress", "permission_request_in_progress", null)
            return
        }
        val intent = prepareVpnService()
        if (!VpnDisclosurePolicy.mayRequest(accepted, intent == null, disclosed)) {
            result.error("vpn_disclosure_required", "vpn_disclosure_required", null)
            return
        }
        if (intent == null) {
            completeVpnPermission(result, ticket, disclosed || accepted, alreadyAccepted = accepted)
            return
        }
        permissionResult = result
        permissionSessionEpoch = ticket
        permissionDisclosureAccepted = disclosed
        emitState(VpnStatus.AUTHORIZING, null, null)
        try {
            val host = currentActivity() ?: throw IllegalStateException("activity_not_available")
            host.startActivityForResult(intent, VPN_PERMISSION_REQUEST_CODE)
        } catch (error: Exception) {
            permissionResult = null
            permissionDisclosureAccepted = false
            emitState(VpnStatus.ERROR, null, "vpn_permission_request_failed")
            result.error("vpn_permission_request_failed", "vpn_permission_request_failed", null)
        }
    }

    private fun completeVpnPermission(
        result: MethodChannel.Result,
        ticket: Long,
        disclosed: Boolean,
        alreadyAccepted: Boolean = false,
    ) {
        operationScope.launch {
            try {
                sessionLifecycle.check(ticket)
                val granted = disclosed && prepareVpnService() == null
                // A consent stored for this disclosure version is not rewritten on every connect.
                if (granted && !alreadyAccepted) {
                    // Durable consent must succeed before Dart can start a tunnel.
                    sessionLifecycle.mutate(ticket) {
                        writePreference(SecureAppPreference.VPN_DISCLOSURE_VERSION, VpnDisclosurePolicy.CURRENT_VERSION)
                    }
                }
                withContext(Dispatchers.Main) {
                    if (!sessionLifecycle.isCurrent(ticket)) {
                        result.error("session_operation_cancelled", "session_operation_cancelled", null)
                    } else {
                        if (granted) {
                            requestNotificationPermissionIfNeeded()
                            if (activeProtocol == null) emitState(VpnStatus.IDLE, null, null)
                        } else emitState(VpnStatus.ERROR, null, "vpn_permission_denied")
                        result.success(granted)
                    }
                }
            } catch (error: Throwable) {
                val code = messageCode(error, "secure_storage_write_failed")
                withContext(Dispatchers.Main) { result.error(code, code, null) }
            }
        }
    }

    private fun vpnDisclosureAccepted(): Boolean = VpnDisclosurePolicy.accepted(
        readStrict(SecureStorageKeyPolicy.preference(SecureAppPreference.VPN_DISCLOSURE_VERSION)),
    )

    private suspend fun connectWireGuard(request: WireGuardRequest, ticket: Long,
        requestEpoch: Long = tunnelRequestEpoch.get(), restoring: Boolean = false,
        localOnly: Boolean = false, timing: NativeConnectionTiming.TraceContext? = null,
        expectedSystemStartEpoch: Long? = null, systemAuthority: Long? = null): Boolean = withTunnelOperation(timing) {
        val connectionSession = NativeConnectionTiming.span(timing, "session_validation") {
            checkRequest(requestEpoch)
            if (expectedSystemStartEpoch != null && !systemStartAllows(expectedSystemStartEpoch)) {
                throw VpnNativeException("session_operation_cancelled")
            }
            if (systemAuthority != null && explicitAdmissionEpoch.get() != systemAuthority) {
                throw CancellationException("system_vpn_start_superseded")
            }
            // Until CONNECTED, a restore failing inside this hold, its session
            // checks included, releases older tile clicks (final reaudit A4).
            if (restoring) systemRestoreHoldOpen = true
            sessionLifecycle.check(ticket)
            localSession(request.accountId, request.deviceId)
        }
        activeSessionEpoch = ticket
        if (!restoring) NativeConnectionTiming.span(timing, "resume_invalidation") { invalidateSystemResume(); beginExplicitConnection() }
        else {
            val saved = resumeRegistry.snapshot() ?: throw VpnNativeException("system_vpn_resume_unavailable")
            val session = localSession(saved.profile)
            if (saved.status != SystemVpnResumeStatus.RESERVED || saved.profile.wireGuardRequest != request ||
                validateSystemVpnSessionPayload(session)?.fingerprint != saved.sessionFingerprint ||
                localIdentity(saved.profile) != saved.identityFingerprint) throw VpnNativeException("system_vpn_resume_identity_changed")
        }
        ensureVpnAuthorized()
        ensureNoCrossAccountTunnel(request.accountId)
        // A previous stop may have timed out while Android was still finishing
        // the same service teardown.  The active marker is deliberately kept
        // in that case; retry its stop now instead of leaving the process
        // permanently locked until the application is restarted.
        if (activeProtocol != null) NativeConnectionTiming.spanSuspend(timing, "stop_worker") { disconnectLocked(userInitiated = false, timing = timing) }
        setActiveMetadata(
            accountId = request.accountId,
            deviceId = request.deviceId,
            locationId = request.locationId,
            locationName = request.locationName,
        )
        if (restoring) systemRestoreInstance = tunnelInstanceEpoch.get()
        emitState(VpnStatus.PREPARING, VpnProtocol.WIREGUARD, null)
        wireGuardIpFamilies = request.network.ipFamilies
        NativeConnectionTiming.span(timing, "notification") { WireGuardForegroundNotifier.start(appContext, VpnStatus.CONNECTING) }
        emitState(VpnStatus.CONNECTING, VpnProtocol.WIREGUARD, null)
        val ownConnecting = synchronized(stateLock) { currentState }
        // Mark the transition active before calling the backend. A timed-out
        // backend call can still own a TUN later, and must block any second
        // protocol until disconnect has positively completed.
        activeProtocol = VpnProtocol.WIREGUARD
        val connected = try {
            wireGuard.connect(request, requireExistingIdentity = restoring || localOnly, timing = timing, isCurrent = {
                sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch
            })
        } catch (error: VpnNativeException) {
            val stopped = wireGuard.disconnect(timing)
            if (stopped) clearWireGuardActiveLocked()
            else emitState(VpnStatus.ERROR, VpnProtocol.WIREGUARD, "wireguard_stop_timeout")
            if (stopped && endCancelledConnection(ticket, requestEpoch, ownConnecting)) throw VpnNativeException("session_operation_cancelled")
            throw if (stopped) error else VpnNativeException("wireguard_stop_timeout", error)
        } catch (error: Exception) {
            val stopped = wireGuard.disconnect(timing)
            if (stopped) clearWireGuardActiveLocked()
            else emitState(VpnStatus.ERROR, VpnProtocol.WIREGUARD, "wireguard_stop_timeout")
            if (stopped && endCancelledConnection(ticket, requestEpoch, ownConnecting)) throw VpnNativeException("session_operation_cancelled")
            throw if (stopped) VpnNativeException("wireguard_start_failed", error)
            else VpnNativeException("wireguard_stop_timeout", error)
        }
        if (!connected) {
            val stopped = wireGuard.disconnect(timing)
            if (stopped) {
                clearWireGuardActiveLocked()
                // The handshake wait also returns early for a newer command or
                // session end: that is a cancellation, not a timeout (A08-03).
                if (!sessionLifecycle.isCurrent(ticket) || tunnelRequestEpoch.get() != requestEpoch) {
                    emitState(VpnStatus.IDLE, null, null)
                    WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE)
                    throw VpnNativeException("session_operation_cancelled")
                }
                emitState(VpnStatus.ERROR, VpnProtocol.WIREGUARD, "wireguard_handshake_timeout")
                throw VpnNativeException("wireguard_handshake_timeout")
            }
            emitState(VpnStatus.ERROR, VpnProtocol.WIREGUARD, "wireguard_stop_timeout")
            throw VpnNativeException("wireguard_stop_timeout")
        }
        try {
            NativeConnectionTiming.span(timing, "postproof_notification") { sessionLifecycle.current(ticket) {
                checkRequest(requestEpoch)
                recordProvenConnection(QuickTileProfile(VpnProtocol.WIREGUARD, request.accountId,
                    request.deviceId, request.locationId, request.locationName, wireGuardRequest = request), restoring,
                    if (restoring) null else connectionSession)
                connectedAtMillis = System.currentTimeMillis()
                emitState(VpnStatus.CONNECTED, VpnProtocol.WIREGUARD, null)
                WireGuardForegroundNotifier.update(appContext, VpnStatus.CONNECTED)
                // Without the physical callback the inventory is unreadable too (see
                // physicalCallbackRegistered): an empty tracker would show a network wait all along.
                if (physicalCallbackRegistered) {
                    wireGuardRecoveryInstance = tunnelInstanceEpoch.get()
                    wireGuardRecovery.start(wireGuardRecoveryInstance, reconcilePhysicalNetworksLocked(), wireGuard.recoveryBaseline())
                    refreshWireGuardRecoveryLocked(sample = false)
                    startWireGuardRecoveryObserverLocked()
                }
            } }
        } catch (error: Exception) {
            val stopped = wireGuard.disconnect(timing)
            if (stopped) clearWireGuardActiveLocked()
            if (stopped && endCancelledConnection(ticket, requestEpoch, ownConnecting)) throw VpnNativeException("session_operation_cancelled")
            throw if (stopped) error else VpnNativeException("wireguard_stop_timeout", error)
        }
        systemRestoreHoldOpen = false
        true
    }

    /**
     * A connection whose engine stopped after its request or session stopped
     * being current was cancelled, not failed: publish IDLE as the handshake
     * wait does (A08-03), unless another operation has published since this
     * connection's own CONNECTING (final reaudit A2/B11).
     */
    private fun endCancelledConnection(ticket: Long, requestEpoch: Long, ownConnecting: VpnState): Boolean {
        if (sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch) return false
        if (synchronized(stateLock) { currentState } !== ownConnecting) return false
        emitState(VpnStatus.IDLE, null, null)
        WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE)
        return true
    }

    private suspend fun connectOpenVpn(args: Map<String, Any?>, ticket: Long, requestEpoch: Long,
        timing: NativeConnectionTiming.TraceContext? = null): Boolean = withTunnelOperation(timing) {
        val connectionSession = NativeConnectionTiming.span(timing, "session_validation") {
            checkRequest(requestEpoch)
            sessionLifecycle.check(ticket)
            localSession(args.requiredString(ACCOUNT_ID), args.requiredString(DEVICE_ID))
        }
        if (openVpn.isRevocationBlocked(args.requiredString(ACCOUNT_ID), args.requiredString(DEVICE_ID))) {
            throw VpnNativeException("openvpn_identity_cleanup_pending")
        }
        activeSessionEpoch = ticket
        NativeConnectionTiming.span(timing, "resume_invalidation") { invalidateSystemResume(); beginExplicitConnection() }
        ensureVpnAuthorized()
        val accountId = args.requiredString(ACCOUNT_ID)
        val deviceId = args.requiredString(DEVICE_ID)
        val locationId = args.requiredString(LOCATION_ID)
        val locationName = args.requiredDisplayName(LOCATION_NAME)
        ensureNoCrossAccountTunnel(accountId)
        // OpenSSL shutdown can complete just after the first bounded wait.
        // Reconcile the retained handle/service before creating a replacement
        // session, while still refusing to run two VPNs concurrently.
        if (activeProtocol != null) NativeConnectionTiming.spanSuspend(timing, "stop_worker") { disconnectLocked(userInitiated = false, timing = timing) }
        setActiveMetadata(accountId, deviceId, locationId, locationName)
        emitState(VpnStatus.PREPARING, VpnProtocol.OPENVPN, null)
        NativeConnectionTiming.span(timing, "vpn_service_start") { OpenVpnService.start(appContext) }
        if (!NativeConnectionTiming.span(timing, "vpn_service_await") { OpenVpnService.awaitReady(OPENVPN_SERVICE_START_TIMEOUT_MS) }) {
            OpenVpnService.stop(appContext)
            clearActiveMetadata()
            emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN, "openvpn_service_start_failed")
            throw VpnNativeException("openvpn_service_start_failed")
        }
        emitState(VpnStatus.CONNECTING, VpnProtocol.OPENVPN, null)
        // As with WireGuard, the active marker begins before native start so
        // an unconfirmed stop can never be followed by a competing tunnel.
        activeProtocol = VpnProtocol.OPENVPN
        markOpenVpnStart()
        val started = try {
            openVpn.connect(accountId, deviceId, args, timing = timing) {
                sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch
            }
        } catch (error: VpnNativeException) {
            val stopped = openVpn.disconnect(timing)
            if (stopped) clearOpenVpnActiveLocked()
            if (!stopped) emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN, "openvpn_stop_timeout")
            throw if (stopped) error else VpnNativeException("openvpn_stop_timeout", error)
        } catch (error: Exception) {
            val stopped = openVpn.disconnect()
            if (stopped) clearOpenVpnActiveLocked()
            if (!stopped) emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN, "openvpn_stop_timeout")
            throw if (stopped) VpnNativeException("openvpn_start_failed", error)
            else VpnNativeException("openvpn_stop_timeout", error)
        }
        if (!started.isConnected()) {
            val stopped = openVpn.disconnect(timing)
            if (stopped) clearOpenVpnActiveLocked()
            if (stopped) {
                emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN, started.messageCode())
                throw VpnNativeException(started.messageCode())
            }
            emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN, "openvpn_stop_timeout")
            throw VpnNativeException("openvpn_stop_timeout")
        }
        try {
            checkRequest(requestEpoch)
            NativeConnectionTiming.span(timing, "postproof_notification") { publishOpenVpnConnection(QuickTileProfile(VpnProtocol.OPENVPN, accountId, deviceId, locationId,
                locationName, openVpnNetwork = TunnelNetworkSpec.from(args, legacyOpenVpn = true)), sessionPayload = connectionSession) }
        } catch (error: Exception) {
            val stopped = openVpn.disconnect(timing)
            if (stopped) clearOpenVpnActiveLocked()
            throw if (stopped) error else VpnNativeException("openvpn_stop_timeout", error)
        }
        true
    }

    private fun clearWireGuardActiveLocked() {
        stopWireGuardRecoveryLocked()
        WireGuardForegroundNotifier.stop(appContext)
        activeProtocol = null
        clearActiveMetadata()
    }

    private fun clearOpenVpnActiveLocked() {
        OpenVpnService.stop(appContext)
        recoveryOwnsSession = false
        activeProtocol = null
        clearActiveMetadata()
    }

    /**
     * Stop must complete before an identity is removed or another protocol is
     * started. A timeout is surfaced to Flutter rather than risking two TUNs.
     */
    private suspend fun disconnect(userInitiated: Boolean, ticket: Long, stopHost: Boolean = false,
        requestEpoch: Long = tunnelRequestEpoch.get(), timing: NativeConnectionTiming.TraceContext? = null): Boolean {
        if (userInitiated) cancelRecovery()
        return withTunnelOperation(timing) {
            checkRequest(requestEpoch)
            sessionLifecycle.check(ticket)
            invalidateSystemResume()
            NativeConnectionTiming.spanSuspend(timing, "stop_worker") { disconnectLocked(userInitiated, timing) }.also {
                if (stopHost) {
                    WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE, requiresAction = true)
                    SharedVpnHost.stopIfNotPermanent()
                }
            }
        }
    }

    private suspend fun disconnectLocked(userInitiated: Boolean, timing: NativeConnectionTiming.TraceContext? = null): Boolean {
        stopWireGuardRecoveryLocked()
        val protocol = activeProtocol
        if (protocol == null) {
            clearActiveMetadata()
            emitState(VpnStatus.IDLE, null, null)
            WireGuardForegroundNotifier.stop(appContext)
            WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE)
            return true
        }
        emitState(VpnStatus.DISCONNECTING, protocol, null)
        if (protocol == VpnProtocol.OPENVPN) {
            OpenVpnService.update(appContext, VpnStatus.DISCONNECTING)
        } else {
            WireGuardForegroundNotifier.update(appContext, VpnStatus.DISCONNECTING)
        }
        var stopped = when (protocol) {
            VpnProtocol.WIREGUARD -> wireGuard.disconnect(timing)
            VpnProtocol.OPENVPN -> try {
                openVpnTransition = true
                openVpn.disconnect(timing)
            } catch (_: Exception) {
                false
            } finally {
                openVpnTransition = false
            }
        }
        if (stopped && protocol == VpnProtocol.OPENVPN) OpenVpnService.stop(appContext)
        if (!stopped) {
            val stopCode = when (protocol) {
                VpnProtocol.WIREGUARD -> "wireguard_stop_timeout"
                VpnProtocol.OPENVPN -> "openvpn_stop_timeout"
            }
            emitState(VpnStatus.ERROR, protocol, stopCode)
            throw VpnNativeException(stopCode)
        }
        if (protocol == VpnProtocol.WIREGUARD) WireGuardForegroundNotifier.stop(appContext)
        activeProtocol = null
        clearActiveMetadata()
        emitState(VpnStatus.IDLE, null, null)
        WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE)
        return true
    }

    private suspend fun clearAccountIdentity(accountId: String, expectedDevice: ExpectedDeviceIdentity, ticket: Long): Boolean = withTunnelOperation {
        requireAccountSession(ticket, accountId)
        // Device writes use this same tunnel mutex. An old server response must
        // never erase the replacement device's local keys or resume records.
        expectedDevice.requireCurrent(readStrict(SecureStorageKeyPolicy.currentDevice(accountId)))
        cancelRecovery()
        cancelSystemStart()
        invalidateSystemResume()
        if (activeAccountId == accountId && activeProtocol != null) disconnectLocked(userInitiated = true)
        sessionLifecycle.check(ticket)
        wireGuard.clearAccountIdentity(accountId)
        sessionLifecycle.check(ticket)
        try {
            openVpn.clearAccountIdentity(accountId)
        } catch (error: Exception) {
            throw VpnNativeException("openvpn_identity_clear_failed", error)
        }
        quickTileProfiles.clearIf(accountId)
        true
    }

    private suspend fun clearOpenVpnIdentity(accountId: String, deviceId: String, ticket: Long): Boolean =
        withTunnelOperation {
            requireAccountSession(ticket, accountId)
            invalidateSystemResume()
            if (activeAccountId == accountId && activeProtocol == VpnProtocol.OPENVPN) {
                disconnectLocked(userInitiated = true)
            }
            sessionLifecycle.check(ticket)
            openVpn.clearIdentity(accountId, deviceId)
            quickTileProfiles.clearIf(accountId, deviceId, VpnProtocol.OPENVPN)
            true
        }

    private suspend fun cleanRevokedOpenVpnIdentity(target: RevokedOpenVpnIdentity, ticket: Long): OpenVpnRevocationState =
        withTunnelOperation {
            fun checkCurrent() {
                requireAccountSession(ticket, target.accountId)
                if (readSlot(SecureStorageKeyPolicy.currentDevice(target.accountId)) != target.deviceId) {
                    throw VpnNativeException("session_operation_cancelled")
                }
            }
            checkCurrent()
            val result = try { openVpn.cleanRevokedIdentity(target,
                checkCurrent = ::checkCurrent,
                admitted = {
                    cancelRecovery()
                    cancelSystemStart()
                    val resume = resumeRegistry.snapshot()
                    if (resume?.profile?.let { it.accountId == target.accountId && it.deviceId == target.deviceId &&
                            it.protocol == VpnProtocol.OPENVPN } == true) invalidateSystemResume()
                    if (activeProtocol == VpnProtocol.OPENVPN && activeAccountId == target.accountId && activeDeviceId == target.deviceId) {
                        openVpnTransition = true
                    }
                },
                clearTile = { quickTileProfiles.clearIf(target.accountId, target.deviceId, VpnProtocol.OPENVPN) },
                publish = { state ->
                    checkCurrent()
                    revocationState = state
                    // Preserve a WireGuard tunnel or an unrelated device's metadata.
                    if (activeProtocol == VpnProtocol.OPENVPN && activeAccountId == target.accountId &&
                        activeDeviceId == target.deviceId) {
                        if (state.tunnelStopped) clearOpenVpnActiveLocked()
                        else connectedAtMillis = null
                    }
                    if (activeProtocol == null || (activeProtocol == VpnProtocol.OPENVPN &&
                            activeAccountId == target.accountId && activeDeviceId == target.deviceId)) {
                        emitState(if (state.inProgress) VpnStatus.DISCONNECTING else VpnStatus.ERROR,
                            VpnProtocol.OPENVPN, if (state.complete) "openvpn_profile_revoked_cleaned"
                            else state.stopError ?: state.storageError ?: "openvpn_identity_cleanup_pending")
                    } else {
                        val snapshot = synchronized(stateLock) { currentState }
                        emitState(snapshot.status, snapshot.protocol, snapshot.messageCode)
                    }
                },
            ) } finally { openVpnTransition = false }
            checkCurrent()
            if (result.complete) revocationState = null
            result
        }

    /**
     * Handles one explicit Quick Settings click. A connect is permitted only
     * for a profile that previously reached native CONNECTED and only when the
     * Android VPN permission is already granted. No API call or permission UI
     * can originate from this background entry point. The permission is
     * checked after every local check, as VpnService.prepare revokes another
     * app's VPN: a click refused locally never calls it.
     */
    internal fun toggleFromQuickTile(onComplete: (String?) -> Unit) {
        // Preserve the user's action before cancelling a pending connection:
        // its cleanup may clear activeProtocol before this worker can run.
        val action = quickTileAction(activeProtocol, SharedVpnHost.systemFlags().first)
        if (action == QuickTileAction.OPEN_SETTINGS) {
            // Only the tile service may launch with startActivityAndCollapse:
            // a bridge start is blocked in the background on Android 14+ (C2-03).
            onComplete(QUICK_TILE_OPEN_SETTINGS)
            return
        }
        if (!sessionLifecycle.isCurrent(sessionLifecycle.ticket())) {
            // Signed out, whatever the action (an engine may still be retained):
            // the tile asks to open the app first (A11-03; final reaudit A3).
            onComplete(QUICK_TILE_SESSION_REQUIRED)
            return
        }
        val release = holdProcessRestart()
        cancelSystemStart()
        cancelRecovery()
        val ticket = sessionLifecycle.ticket()
        val requestEpoch = tunnelRequestEpoch.get()
        val publicationEpoch = systemStartPublicationEpoch.get()
        val publications = publicationSequence.get()
        if (activeProtocol == VpnProtocol.OPENVPN) openVpn.cancelPendingConnection()
        operationScope.launch {
            var failureCode: String? = null
            var selectedProtocol: VpnProtocol? = null
            try {
                sessionLifecycle.check(ticket)
                checkRequest(requestEpoch)
                if (action == QuickTileAction.DISCONNECT) {
                    disconnect(userInitiated = true, ticket = ticket, stopHost = true, requestEpoch = requestEpoch)
                } else {
                    val profile = quickTileProfiles.read()
                        ?: throw VpnNativeException("quick_tile_profile_unavailable")
                    selectedProtocol = profile.protocol
                    localSession(profile)
                    localIdentity(profile)
                    checkRequest(requestEpoch)
                    sessionLifecycle.check(ticket)
                    // Last, right before the engine: prepare revokes another
                    // app's VPN, so a click that can only open the app never
                    // calls it. A missing consent stays a local refusal.
                    ensureVpnAuthorized(publishFailure = false)
                    when (profile.protocol) {
                        VpnProtocol.WIREGUARD -> connectWireGuard(
                            profile.wireGuardRequest
                                ?: throw VpnNativeException("quick_tile_profile_unavailable"),
                            ticket,
                            requestEpoch = requestEpoch,
                            localOnly = true,
                            expectedSystemStartEpoch = publicationEpoch,
                        )
                        VpnProtocol.OPENVPN -> reconnectOpenVpn(profile, ticket, requestEpoch = requestEpoch,
                            expectedSystemStartEpoch = publicationEpoch)
                    }
                }
            } catch (error: Throwable) {
                synchronized(systemStartLock) {
                    if (sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch &&
                        systemStartAllows(publicationEpoch)) {
                        val code = messageCode(error, "quick_tile_operation_failed")
                        failureCode = code
                        // A local refusal that changed no state only opens the
                        // app; it is not a global VPN error (A11-03).
                        if (!quickTileFailureOpensApplication(code) || publicationSequence.get() != publications) {
                            val protocol = activeProtocol ?: selectedProtocol
                            emitState(VpnStatus.ERROR, protocol, code)
                            WireGuardForegroundNotifier.startProtocol(appContext, protocol, VpnStatus.ERROR, requiresAction = true)
                        }
                    }
                }
            } finally {
                withContext(Dispatchers.Main) {
                    // A late callback may refresh the current tile, but must
                    // never open the app because an obsolete command failed.
                    synchronized(systemStartLock) {
                        onComplete(failureCode.takeIf {
                            sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch &&
                                systemStartAllows(publicationEpoch)
                        })
                    }
                }
            }
        }.invokeOnCompletion { release() }
    }

    internal fun quickTileState(): VpnState = synchronized(stateLock) { currentState }

    private fun quickTileProfileSnapshot(): QuickTileProfile? = runCatching {
        quickTileProfiles.read()
    }.getOrNull()

    /** Never probes VpnService.prepare: a tile refresh is not a connection (C2-01). */
    private fun canQuickTileConnect(profile: QuickTileProfile?): Boolean {
        if (!sessionLifecycle.isCurrent(sessionLifecycle.ticket()) ||
            !runCatching { VpnDisclosurePolicy.mayStart(vpnDisclosureAccepted(), !vpnPermissionMissing) }.getOrDefault(false)) return false
        if (profile == null) return false
        return profile.protocol != VpnProtocol.OPENVPN ||
            !openVpn.isRevocationBlocked(profile.accountId, profile.deviceId)
    }

    /** Storage and Keystore reads belong to the tile's IO snapshot loader. */
    internal fun quickTileSnapshot(): QuickTileSnapshot {
        val profile = quickTileProfileSnapshot()
        val canConnect = canQuickTileConnect(profile)
        return QuickTileSnapshot(quickTileState(), profile, canConnect)
    }

    private suspend fun reconnectOpenVpn(profile: QuickTileProfile, ticket: Long,
        requestEpoch: Long = tunnelRequestEpoch.get(), restoring: Boolean = false,
        recoveryConsumed: Boolean = false, expectedSystemStartEpoch: Long? = null,
        systemAuthority: Long? = null): Boolean = withTunnelOperation {
        checkRequest(requestEpoch)
        if (expectedSystemStartEpoch != null && !systemStartAllows(expectedSystemStartEpoch)) {
            throw VpnNativeException("session_operation_cancelled")
        }
        if (systemAuthority != null && explicitAdmissionEpoch.get() != systemAuthority) {
            throw CancellationException("system_vpn_start_superseded")
        }
        // Until CONNECTED, a restore failing inside this hold, its session
        // checks included, releases older tile clicks (final reaudit A4).
        if (restoring) systemRestoreHoldOpen = true
        sessionLifecycle.check(ticket)
        val connectionSession = localSession(profile)
        if (openVpn.isRevocationBlocked(profile.accountId, profile.deviceId)) {
            throw VpnNativeException("openvpn_identity_cleanup_pending")
        }
        activeSessionEpoch = ticket
        if (!restoring) { invalidateSystemResume(); beginExplicitConnection() }
        else {
            val saved = resumeRegistry.snapshot() ?: throw VpnNativeException("system_vpn_resume_unavailable")
            if (saved.status != SystemVpnResumeStatus.RESERVED || saved.profile != profile ||
                validateSystemVpnSessionPayload(localSession(profile))?.fingerprint != saved.sessionFingerprint ||
                localIdentity(profile) != saved.identityFingerprint) throw VpnNativeException("system_vpn_resume_identity_changed")
            cancelRecovery()
            recoveryPolicy.newRequest(recoveryConsumed)
        }
        ensureVpnAuthorized()
        ensureNoCrossAccountTunnel(profile.accountId)
        if (activeProtocol != null) disconnectLocked(userInitiated = false)
        val certificateStatus = openVpn.certificateStatus(profile.accountId, profile.deviceId)
        if (certificateStatus.renewalPending ||
            certificateStatus.status == "expired" ||
            certificateStatus.status == "expiring"
        ) {
            throw VpnNativeException("openvpn_renewal_required")
        }
        setActiveMetadata(
            profile.accountId,
            profile.deviceId,
            profile.locationId,
            profile.locationName,
        )
        if (restoring) systemRestoreInstance = tunnelInstanceEpoch.get()
        emitState(VpnStatus.PREPARING, VpnProtocol.OPENVPN, null)
        OpenVpnService.start(appContext)
        if (!OpenVpnService.awaitReady(OPENVPN_SERVICE_START_TIMEOUT_MS)) {
            OpenVpnService.stop(appContext)
            clearActiveMetadata()
            throw VpnNativeException("openvpn_service_start_failed")
        }
        emitState(VpnStatus.CONNECTING, VpnProtocol.OPENVPN, null)
        activeProtocol = VpnProtocol.OPENVPN
        markOpenVpnStart()
        val started = try {
            openVpn.reconnectLocal(profile.accountId, profile.deviceId, profile.openVpnNetwork) {
                sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch
            }
        } catch (error: Throwable) {
            val stopped = runCatching { openVpn.disconnect() }.getOrDefault(false)
            if (stopped) clearOpenVpnActiveLocked()
            throw if (stopped) error else VpnNativeException("openvpn_stop_timeout", error)
        }
        if (!started.isConnected()) {
            val stopped = runCatching { openVpn.disconnect() }.getOrDefault(false)
            if (stopped) clearOpenVpnActiveLocked()
            throw if (stopped) VpnNativeException(started.messageCode())
            else VpnNativeException("openvpn_stop_timeout")
        }
        try {
            checkRequest(requestEpoch)
            publishOpenVpnConnection(profile, restoring, if (restoring) null else connectionSession)
        } catch (error: Exception) {
            val stopped = openVpn.disconnect()
            if (stopped) clearOpenVpnActiveLocked()
            throw if (stopped) error else VpnNativeException("openvpn_stop_timeout", error)
        }
        systemRestoreHoldOpen = false
        true
    }

    /**
     * Session reads (lot S review, P6): a Keystore key that is gone leaves the
     * stored session permanently undecryptable, so it is reported as corrupt,
     * as for the Google slot (C5-03). An unavailable Keystore stays transient.
     * Guest credential and auto-resume reads follow the same rule (final reaudit B33).
     */
    private inline fun <T> sessionRead(read: () -> T): T = try {
        read()
    } catch (error: SecureStorageException) {
        throw if (error.keyMissing) SecureStorageException("secure_storage_corrupt", error) else error
    }

    private fun readStoredSession(): String? {
        val activeUserId = readSlot(SecureStorageKeyPolicy.activeUser())
        return if (activeUserId == null) {
            readSlot(SecureStorageKeyPolicy.pendingSession())
        } else {
            readSlot(SecureStorageKeyPolicy.accountSession(activeUserId))
        }
    }

    /**
     * Which slot holds the stored session: "account" (active user), "pending"
     * (a registered admission never restored) or null. Strict: a failed read
     * is reported and nothing is erased (C4-03).
     */
    private fun readStoredSessionBinding(): String? = when {
        readStrict(SecureStorageKeyPolicy.activeUser()) != null -> "account"
        readStrict(SecureStorageKeyPolicy.pendingSession()) != null -> "pending"
        else -> null
    }

    private fun prepareStoredAccountSession(args: Map<String, Any?>) {
        val accountId = args.requiredString(ACCOUNT_ID)
        if (readStrict(SecureStorageKeyPolicy.activeUser()) != accountId ||
            readStrict(SecureStorageKeyPolicy.accountSession(accountId)) != args.requiredString(PAYLOAD)) {
            cancelSystemStart()
            cancelRecovery()
            invalidateSystemResume()
        }
    }

    private fun writeStoredAccountSession(args: Map<String, Any?>) {
        val accountId = args.requiredString(ACCOUNT_ID)
        writeSlot(
            SecureStorageKeyPolicy.accountSession(accountId),
            args.requiredString(PAYLOAD),
        )
        writeSlot(SecureStorageKeyPolicy.activeUser(), accountId)
        deleteSlot(SecureStorageKeyPolicy.pendingSession())
    }

    private fun replaceStoredGuestSession(args: Map<String, Any?>, ticket: Long) {
        val accountId = args.requiredString(ACCOUNT_ID)
        requireAccountSession(ticket, accountId)
        val sessionSlot = SecureStorageKeyPolicy.accountSession(accountId)
        val previousPayload = readStrict(sessionSlot)
            ?: throw VpnNativeException("system_vpn_resume_session_invalid")
        val payload = args.requiredString(PAYLOAD)
        if (validateSystemVpnSessionPayload(payload) == null) {
            throw VpnNativeException("system_vpn_resume_session_invalid")
        }
        val profile = provenConnectionProfile?.takeIf {
            it.accountId == accountId && currentState.status == VpnStatus.CONNECTED &&
                activeProtocol == it.protocol && activeAccountId == it.accountId &&
                activeDeviceId == it.deviceId && activeLocationId == it.locationId &&
                readStrict(SecureStorageKeyPolicy.currentDevice(accountId)) == it.deviceId
        }
        val identity = profile?.let {
            runCatching {
                val proven = when (it.protocol) {
                    VpnProtocol.WIREGUARD -> wireGuard.currentConnectionIdentityFingerprint(accountId)
                    VpnProtocol.OPENVPN -> {
                        if (!openVpn.isConnected()) throw VpnNativeException("openvpn_connection_proof_missing")
                        openVpn.currentConnectionIdentityFingerprint(accountId, it.deviceId)
                    }
                }
                proven.takeIf { fingerprint -> fingerprint == localIdentity(it) }
            }.getOrNull()
        }
        try {
            sessionLifecycle.mutate(ticket) {
                val ready = resumeRegistry.renewSession(previousPayload, payload, profile, identity) { encodedResume ->
                    store.updateSlotsAtomically(
                        mapOf(sessionSlot to payload, SecureStorageKeyPolicy.systemVpnResume() to encodedResume),
                        setOf(SecureStorageKeyPolicy.pendingSession()),
                    )
                    noteDurableResume(encodedResume)
                }
                resumeState = if (ready) "ready" else "unavailable"
                resumeError = null
                resumeStorageFailure = false
            }
        } catch (error: Exception) {
            resumeState = "blocked"
            resumeError = messageCode(error, "system_vpn_resume_storage_failed")
            resumeStorageFailure = true
            throw error
        }
    }

    private fun endSession(cause: SessionEndCause): CompletableDeferred<SessionTermination> = synchronized(sessionEndLock) {
        sessionLifecycle.beginEnd(cause)
        permissionDisclosureAccepted = false
        sessionEndTask?.takeIf { !it.isCompleted }?.let { return@synchronized it }
        cancelRecovery()
        cancelSystemStart()
        if (activeProtocol == VpnProtocol.OPENVPN) openVpn.cancelPendingConnection()
        val done = CompletableDeferred<SessionTermination>()
        sessionEndTask = done
        // A failed early notice must never leave this shared result pending:
        // every later logout would wait on it (C2-02).
        try {
            emitState(VpnStatus.DISCONNECTING, activeProtocol, "session_ending")
            when (activeProtocol) {
                VpnProtocol.OPENVPN -> OpenVpnService.update(appContext, VpnStatus.DISCONNECTING)
                VpnProtocol.WIREGUARD -> WireGuardForegroundNotifier.update(appContext, VpnStatus.DISCONNECTING)
                null -> Unit
            }
        } catch (_: Exception) { /* The termination below still runs and reports. */ }
        operationScope.launch {
            var confirmed: SessionTermination? = null
            try {
                var revoked = false
                val ended = withTunnelOperation {
                    // If erasing tokens later fails, a separately committed tombstone
                    // still prevents the previous valid session from being resumed.
                    runCatching { invalidateSystemResume() }
                    endSessionAttempt(stop = { disconnectLocked(userInitiated = true).also {
                        WireGuardForegroundNotifier.startProtocol(appContext, null, VpnStatus.IDLE, requiresAction = true)
                        SharedVpnHost.stopIfNotPermanent()
                    } },
                        erase = {
                            // Only a voluntary end revokes automatic guest recovery.
                            revoked = sessionLifecycle.termination?.revokeGuestRecovery == true
                            store.clearSessionMaterial(disableGuestAutoResume = revoked)
                        })
                }
                confirmed = settleEnd(done, ended, revoked) { settled ->
                    resumeState = if (settled.sessionCleared) "unavailable" else "blocked"
                    resumeError = settled.storageError
                    emitState(if (settled.tunnelStopped) VpnStatus.IDLE else VpnStatus.ERROR,
                        activeProtocol, settled.stopError ?: settled.storageError)
                }
            } finally {
                // An unexpected failure is reported as an unfinished, retryable end.
                if (confirmed == null) {
                    settleEnd(done, SessionTermination(stopError = "native_operation_failed"), revoked = false)
                }
            }
        }
        done
    }

    /**
     * Settles an end under [sessionEndLock]: a request either joins it before this
     * point or starts a new end. A voluntary request that joined after the erase
     * still revokes automatic guest recovery before any caller is answered (P1).
     */
    private fun settleEnd(done: CompletableDeferred<SessionTermination>, ended: SessionTermination,
        revoked: Boolean, publish: (SessionTermination) -> Unit = {}): SessionTermination = synchronized(sessionEndLock) {
        val result = if (ended.sessionCleared && !revoked && sessionLifecycle.termination?.revokeGuestRecovery == true) {
            try {
                store.clearSessionMaterial(disableGuestAutoResume = true)
                ended
            } catch (error: Exception) {
                ended.copy(sessionCleared = false,
                    storageError = (error as? SecureStorageException)?.code ?: "secure_storage_write_failed")
            }
        } else ended
        sessionLifecycle.finish(result).also { settled ->
            // A failed publication never keeps the callers waiting (C2-02).
            runCatching { publish(settled) }
            done.complete(settled)
        }
    }

    private fun requireAccountSession(ticket: Long, accountId: String) {
        sessionLifecycle.check(ticket)
        if (readSlot(SecureStorageKeyPolicy.activeUser()) != accountId ||
            readSlot(SecureStorageKeyPolicy.accountSession(accountId)) == null) {
            throw VpnNativeException("session_operation_cancelled")
        }
    }

    private fun Map<String, Any?>.locationMigrationSlot(): SecureStorageSlot =
        SecureStorageKeyPolicy.locationMigration(
            requiredString(ACCOUNT_ID),
            requiredString(DEVICE_ID),
        )

    private fun readPreference(preference: SecureAppPreference): String? =
        readSlot(SecureStorageKeyPolicy.preference(preference))

    private fun writePreference(preference: SecureAppPreference, value: String) {
        writeSlot(SecureStorageKeyPolicy.preference(preference), value)
    }

    private fun writeStoredLocale(call: MethodCall) {
        val args = call.requireMap()
        val rawValue = args[VALUE]
        val slot = SecureStorageKeyPolicy.preference(SecureAppPreference.LOCALE)
        when (rawValue) {
            null -> deleteSlot(slot)
            is String -> writeSlot(slot, NativeLocalePolicy.canonicalTag(rawValue)
                ?: throw VpnNativeException("invalid_arguments"))
            else -> throw VpnNativeException("invalid_arguments")
        }
    }

    private fun readStoredVerificationNeeded(accountId: String): Boolean? =
        readSlot(SecureStorageKeyPolicy.verificationNeeded(accountId))?.let { value ->
            when (value) {
                "true" -> true
                "false" -> false
                else -> throw SecureStorageException("secure_storage_corrupt")
            }
        }

    private fun writeStoredVerificationNeeded(args: Map<String, Any?>) {
        val accountId = args.requiredString(ACCOUNT_ID)
        val value = args[VALUE] as? Boolean ?: throw VpnNativeException("invalid_arguments")
        writeSlot(SecureStorageKeyPolicy.verificationNeeded(accountId), value.toString())
    }

    private fun readSlot(slot: SecureStorageSlot): String? = store.read(slot.scope, slot.key)

    private fun writeSlot(slot: SecureStorageSlot, value: String) {
        store.write(slot.scope, slot.key, value)
    }

    private fun deleteSlot(slot: SecureStorageSlot) {
        store.delete(slot.scope, slot.key)
    }

    private fun ensureVpnAuthorized(publishFailure: Boolean = true) {
        if (!vpnDisclosureAccepted()) {
            throw VpnNativeException("vpn_disclosure_required")
        }
        if (prepareVpnService() != null) {
            if (publishFailure) emitState(VpnStatus.ERROR, null, "vpn_permission_required")
            throw VpnNativeException("vpn_permission_required")
        }
    }

    /** Only for an explicit user action: prepare revokes another app's VPN. */
    private fun prepareVpnService(): Intent? = VpnService.prepare(appContext).also { intent ->
        val missing = intent != null
        if (vpnPermissionMissing != missing) {
            vpnPermissionMissing = missing
            // The active tile reads this flag (A09-services-01; final reaudit B15).
            VpnQuickTileService.requestUpdate(appContext)
        }
    }

    private fun ensureNoCrossAccountTunnel(accountId: String) {
        val existingAccount = activeAccountId
        if (activeProtocol != null && existingAccount != null && existingAccount != accountId) {
            throw VpnNativeException("tunnel_active_for_another_account")
        }
        // A same-account marker may represent a stop that completed just after
        // the caller's bounded wait. The connect paths reconcile it before
        // starting another tunnel. Only a different account is rejected here.
    }

    private suspend fun tunnelEndedUnexpectedly(
        protocol: VpnProtocol,
        cause: String = "tunnel_disconnected",
        ticket: Long,
    ) = withTunnelOperation {
        if (!sessionLifecycle.isCurrent(ticket)) return@withTunnelOperation
        if (activeProtocol != protocol) return@withTunnelOperation
        try { resumeRegistry.block(cause) }
        catch (error: Exception) {
            resumeStorageFailure = true
            resumeError = messageCode(error, "system_vpn_resume_storage_failed")
        }
        resumeState = "blocked"
        if (!resumeStorageFailure) resumeError = cause
        // A framework revocation/down callback is not proof that the native
        // engine has released its descriptor. Confirm its stop before another
        // protocol can be considered, otherwise retain the active marker.
        val stopped = when (protocol) {
            VpnProtocol.WIREGUARD -> wireGuard.disconnect()
            VpnProtocol.OPENVPN -> openVpn.disconnect()
        }
        if (!stopped) {
            val stopCode = when (protocol) {
                VpnProtocol.WIREGUARD -> "wireguard_stop_timeout"
                VpnProtocol.OPENVPN -> "openvpn_stop_timeout"
            }
            emitState(VpnStatus.ERROR, protocol, stopCode)
            return@withTunnelOperation
        }
        if (protocol == VpnProtocol.OPENVPN) OpenVpnService.stop(appContext)
        if (protocol == VpnProtocol.WIREGUARD) WireGuardForegroundNotifier.stop(appContext)
        activeProtocol = null
        clearActiveMetadata()
        emitState(VpnStatus.ERROR, protocol, cause)
        WireGuardForegroundNotifier.startProtocol(appContext, protocol, VpnStatus.ERROR, requiresAction = true)
    }

    private fun observeOpenVpnStates() {
        openVpnEventsJob = observerScope.launch {
            openVpn.observeStates().collect { event ->
                // Startup publishes CONNECTED only after both callback and JNI
                // proof have been checked. Control failures are never conflated.
                if (event.generation != openVpn.sessionGeneration ||
                    activeProtocol != VpnProtocol.OPENVPN ||
                    (openVpnTransition && currentState.status != VpnStatus.CONNECTED)) return@collect
                if (event.state.toVpnStatus() == VpnStatus.ERROR) {
                    handleOpenVpnFailure(event.generation, event.state.messageCode() ?: "openvpn_connection_failed")
                }
            }
        }
    }

    private fun cancelRecovery() = synchronized(recoveryLock) {
        recoveryPolicy.cancel()
        recoveryJob?.cancel()
        recoveryJob = null
    }

    private fun beginExplicitConnection() = synchronized(recoveryLock) {
        cancelRecovery()
        recoveryPolicy.newRequest()
    }

    // Under recoveryLock so a command's cancelRecovery() cannot slip between the mark and the
    // interruption and turn this loss into openvpn_recovery_exhausted.
    private fun signalOpenVpnNetworkLoss() = synchronized(recoveryLock) {
        if (activeProtocol != VpnProtocol.OPENVPN || currentState.status != VpnStatus.CONNECTED) return@synchronized
        // Marked before the interruption so the collector and the 1 Hz poll both see it;
        // refused after cancelRecovery() (provenGeneration = 0): the pending command owns the tunnel.
        if (!recoveryPolicy.networkLost(openVpn.sessionGeneration)) return@synchronized
        Log.i(LOG_TAG, "OpenVPN physical network lost") // Fixed text, no identifiers: the device proof of this path.
        openVpn.networkLost()
    }

    private fun markOpenVpnStart() { openVpnStartLosses = physicalLosses.get() }

    private fun handleOpenVpnFailure(generation: Long, code: String) = synchronized(recoveryLock) {
        if (!sessionLifecycle.isCurrent(activeSessionEpoch)) return@synchronized
        if (activeProtocol != VpnProtocol.OPENVPN || generation != openVpn.sessionGeneration ||
            generation == handledFailureGeneration ||
            (openVpnTransition && currentState.status != VpnStatus.CONNECTED)) return@synchronized
        handledFailureGeneration = generation
        recoveryOwnsSession = true
        val request = recoveryPolicy.currentRequest()
        val reconnect = code == "openvpn_reconnect_required"
        // Without the physical callback, Core can notice a lost network before the next look:
        // a network that vanished since then makes this the network change onLost would mark.
        // Any other interruption keeps the single retry, as with the callback.
        if (reconnect && !physicalCallbackRegistered && physicalNetworkVanished()) {
            physicalLosses.incrementAndGet()
            recoveryPolicy.networkLost(generation)
        }
        val networkTicket = if (reconnect) recoveryPolicy.claimNetworkChange(generation) else null
        val ticket = networkTicket ?: if (reconnect) recoveryPolicy.claim(generation) else null
        // Fixed text and native codes only: the device trace of every OpenVPN recovery.
        Log.i(LOG_TAG, when {
            networkTicket != null -> "OpenVPN recovery: network change"
            ticket != null -> "OpenVPN recovery: interruption, single retry"
            else -> "OpenVPN recovery: none left after $code"
        })
        val target = RecoveryTarget(request, generation, activeAccountId ?: return@synchronized,
            activeDeviceId ?: return@synchronized, activeLocationId ?: return@synchronized,
            activeLocationName ?: return@synchronized, networkChange = networkTicket != null)
        connectedAtMillis = null
        if (ticket != null) {
            emitState(VpnStatus.CONNECTING, VpnProtocol.OPENVPN, OPENVPN_RECONNECTING)
            OpenVpnService.update(appContext, VpnStatus.CONNECTING, reconnecting = true)
        } else {
            emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN,
                if (code == "openvpn_reconnect_required") "openvpn_recovery_exhausted" else code)
            OpenVpnService.update(appContext, VpnStatus.ERROR)
        }
        recoveryJob = operationScope.launch(start = CoroutineStart.LAZY) {
            recoverOpenVpn(target, retry = ticket != null, failure = code)
        }.also { it.start() }
    }

    private fun isRecoveryCurrent(target: RecoveryTarget): Boolean =
        sessionLifecycle.isCurrent(activeSessionEpoch) &&
        recoveryPolicy.isCurrent(target.request) && activeProtocol == VpnProtocol.OPENVPN &&
            activeAccountId == target.accountId && activeDeviceId == target.deviceId &&
            activeLocationId == target.locationId

    private suspend fun recoverOpenVpn(target: RecoveryTarget, retry: Boolean, failure: String) {
        var finalFailure = if (failure == "openvpn_reconnect_required") "openvpn_recovery_exhausted" else failure
        try {
            withTunnelOperation {
                if (!isRecoveryCurrent(target)) throw CancellationException()
                if (retry) {
                    val saved = resumeRegistry.snapshot() ?: throw VpnNativeException("system_vpn_resume_unavailable")
                    if (saved.profile.accountId != target.accountId || saved.profile.deviceId != target.deviceId ||
                        saved.profile.locationId != target.locationId ||
                        (if (target.networkChange) resumeRegistry.admitNetworkRecovery(localSession(saved.profile), localIdentity(saved.profile))
                         else resumeRegistry.consumeRecovery(localSession(saved.profile), localIdentity(saved.profile))) == null) {
                        throw VpnNativeException("openvpn_recovery_exhausted")
                    }
                } else {
                    resumeRegistry.block(finalFailure)
                    resumeState = "blocked"
                    resumeError = finalFailure
                }
            }
            OpenVpnRecoveryAttempt().run(
                retry = retry,
                failure = finalFailure,
                isCurrent = { isRecoveryCurrent(target) },
                stopOld = { withTunnelOperation {
                    if (!isRecoveryCurrent(target) || openVpn.sessionGeneration != target.generation) return@withTunnelOperation false
                    openVpnTransition = true
                    try {
                        if (!openVpn.disconnect()) throw VpnNativeException("openvpn_stop_timeout")
                        // Core's worker and handle are gone. OpenVpnService holds the TUN
                        // interface until restartLocal reuses it (same plan, same host) or its
                        // establish() replaces it, or clearOpenVpnActiveLocked releases it: the
                        // wait drops traffic.
                        // A TLS/profile failure delivered during shutdown takes
                        // precedence over the initial transport interruption.
                        val nativeFailure = openVpn.sessionFailure
                        if (nativeFailure != null && nativeFailure != "openvpn_reconnect_required") {
                            throw VpnNativeException(nativeFailure)
                        }
                        true
                    } finally { openVpnTransition = false }
                } },
                hasNetwork = { openVpn.hasUsableNetwork() },
                restartLocal = { withTunnelOperation {
                    if (!isRecoveryCurrent(target)) return@withTunnelOperation
                    openVpnTransition = true
                    try {
                        ensureVpnAuthorized()
                        val certificate = openVpn.certificateStatus(target.accountId, target.deviceId)
                        OpenVpnRecoveryAttempt.profileFailure(certificate.status, certificate.renewalPending)?.let {
                            throw VpnNativeException(it)
                        }
                        OpenVpnService.start(appContext, reconnecting = true)
                        if (!OpenVpnService.awaitReady(OPENVPN_SERVICE_START_TIMEOUT_MS)) {
                            throw VpnNativeException("openvpn_service_start_failed")
                        }
                        markOpenVpnStart()
                        val started = openVpn.reconnectLocal(target.accountId, target.deviceId) {
                            isRecoveryCurrent(target)
                        }
                        if (!started.isConnected() || !openVpn.isConnected()) {
                            throw VpnNativeException(openVpn.sessionFailure ?: started.messageCode())
                        }
                        if (!isRecoveryCurrent(target)) {
                            if (!openVpn.disconnect()) throw VpnNativeException("openvpn_stop_timeout")
                            clearOpenVpnActiveLocked()
                            return@withTunnelOperation
                        }
                        publishOpenVpnConnection()
                        Log.i(LOG_TAG, "OpenVPN recovery: connected")
                    } finally { openVpnTransition = false }
                } },
            )
        } catch (_: CancellationException) {
            // The replacing command owns cleanup; a startup already underway
            // checks its ticket and stops before releasing the native mutex.
            Log.i(LOG_TAG, "OpenVPN recovery: superseded")
        } catch (error: Exception) {
            finalFailure = messageCode(error, "openvpn_recovery_failed")
            Log.i(LOG_TAG, "OpenVPN recovery: failed with $finalFailure")
            withContext(NonCancellable) {
                withTunnelOperation {
                    if (!isRecoveryCurrent(target)) return@withTunnelOperation
                    openVpnTransition = true
                    try {
                        val stopped = runCatching { openVpn.disconnect() }.getOrDefault(false)
                        if (stopped) clearOpenVpnActiveLocked()
                        else {
                            finalFailure = "openvpn_stop_timeout"
                            OpenVpnService.update(appContext, VpnStatus.ERROR)
                        }
                        try { resumeRegistry.block(finalFailure) }
                        catch (storageError: Exception) {
                            resumeStorageFailure = true
                            finalFailure = messageCode(storageError, "system_vpn_resume_storage_failed")
                        }
                        resumeState = "blocked"
                        resumeError = finalFailure
                        emitState(VpnStatus.ERROR, VpnProtocol.OPENVPN, finalFailure)
                        WireGuardForegroundNotifier.startProtocol(appContext, VpnProtocol.OPENVPN, VpnStatus.ERROR, requiresAction = true)
                    } finally { openVpnTransition = false }
                }
            }
        }
    }

    private fun publishOpenVpnConnection(profile: QuickTileProfile? = null, restoring: Boolean = false, sessionPayload: String? = null) {
        sessionLifecycle.check(activeSessionEpoch)
        if (!openVpn.confirmConnected {
            sessionLifecycle.current(activeSessionEpoch) {
                if (profile != null) recordProvenConnection(profile, restoring, sessionPayload)
                recoveryPolicy.connected(openVpn.sessionGeneration)
                recoveryOwnsSession = false
                connectedAtMillis = System.currentTimeMillis()
                emitState(VpnStatus.CONNECTED, VpnProtocol.OPENVPN, null)
                OpenVpnService.update(appContext, VpnStatus.CONNECTED)
            }
        }) {
            val failure = openVpn.sessionFailure ?: "openvpn_connection_proof_missing"
            handleOpenVpnFailure(openVpn.sessionGeneration, failure)
            throw VpnNativeException(failure)
        }
        // CONNECTED is now published (volatile). Either this read or the onLost callback acts.
        if (physicalLosses.get() != openVpnStartLosses) signalOpenVpnNetworkLoss()
    }

    private fun requestNotificationPermissionIfNeeded() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
            ContextCompat.checkSelfPermission(appContext, Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED ||
            notificationPermissionPending
        ) return
        notificationPermissionPending = true
        val host = currentActivity() ?: run {
            notificationPermissionPending = false
            return
        }
        host.runOnUiThread {
            host.requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), NOTIFICATION_PERMISSION_REQUEST_CODE)
        }
    }

    private fun emitState(status: VpnStatus, protocol: VpnProtocol?, messageCode: String?) {
        if (status == VpnStatus.CONNECTED) {
            synchronized(sessionLifecycle) {
                if (sessionLifecycle.isCurrent(activeSessionEpoch)) publishState(status, protocol, messageCode)
            }
        } else {
            publishState(status, protocol, messageCode)
        }
    }

    private fun publishState(status: VpnStatus, protocol: VpnProtocol?, messageCode: String?) {
        val previous = synchronized(stateLock) { currentState }
        val sameTunnel = status == VpnStatus.CONNECTED && previous.status == VpnStatus.CONNECTED &&
            protocol != null && previous.protocol == protocol && activeProtocol == protocol
        val state = VpnState(
            systemProtection = systemProtectionSnapshot(),
            sessionTermination = sessionLifecycle.termination,
            openVpnRevocation = revocationState,
            status = status,
            protocol = protocol,
            messageCode = messageCode,
            connectedAtMillis = connectedAtMillis.takeIf { activeProtocol == protocol },
            locationId = activeLocationId.takeIf { activeProtocol == protocol },
            locationName = activeLocationName.takeIf { activeProtocol == protocol },
            receivedBytes = previous.receivedBytes.takeIf { sameTunnel },
            sentBytes = previous.sentBytes.takeIf { sameTunnel },
            latestHandshakeMillis = previous.latestHandshakeMillis.takeIf { sameTunnel },
            ipFamilies = if (status == VpnStatus.CONNECTED) {
                when (protocol) {
                    VpnProtocol.WIREGUARD -> wireGuardIpFamilies
                    VpnProtocol.OPENVPN -> openVpn.provenNetworkFamilies
                    else -> emptyList()
                }
            } else emptyList(),
        )
        synchronized(stateLock) { currentState = state }
        if (status == VpnStatus.CONNECTED) {
            noteAlwaysOn(state.systemProtection["always_on"] as? Boolean)
            startAlwaysOnSampler()
        }
        publicationSequence.incrementAndGet()
        val epoch = sessionLifecycle.ticket()
        // Publication never throws into a connection, permission or logout
        // step: the state above is already the native truth (C2-02).
        try {
            currentActivity()?.runOnUiThread {
                // A queued UI delivery must not resurrect a session or an older
                // cleanup step after a new account/termination result is active.
                if (epoch == sessionLifecycle.ticket() && state.sessionTermination === sessionLifecycle.termination) {
                    eventSink?.success(state.toChannelMap())
                }
            }
        } catch (_: RuntimeException) { /* Flutter reads getState on its next attach. */ }
        VpnQuickTileService.requestUpdate(appContext)
    }

    private fun stateSnapshot(): Map<String, Any?> = synchronized(stateLock) {
        currentState.copy(sessionTermination = sessionLifecycle.termination, openVpnRevocation = revocationState,
            systemProtection = systemProtectionSnapshot()).toChannelMap()
    }

    private suspend fun stateSnapshotWithMetrics(): Map<String, Any?> = withTunnelOperation {
        // A live tunnel has already published the durable resume result. The
        // once-per-second counters need no additional encrypted-record read.
        // Idle/activity restoration and the settings command still read it.
        val protection = systemProtectionSnapshot(refresh = activeProtocol == null)
        val account = readSlot(SecureStorageKeyPolicy.activeUser())
        val device = account?.let { readSlot(SecureStorageKeyPolicy.currentDevice(it)) }
        revocationState = if (account != null && device != null) openVpn.pendingRevocation(account, device) else null
        val snapshot = synchronized(stateLock) { currentState }
        if (activeProtocol == VpnProtocol.WIREGUARD && wireGuardRecoveryIsCurrent()) {
            val statistics = refreshWireGuardRecoveryLocked(sample = true)
            startWireGuardRecoveryObserverLocked()
            return@withTunnelOperation synchronized(stateLock) {
                currentState = currentState.withTunnelStatistics(statistics).copy(
                    systemProtection = protection, timestampMillis = System.currentTimeMillis())
                currentState.toChannelMap()
            }
        }
        if (snapshot.status != VpnStatus.CONNECTED || activeProtocol == null) {
            return@withTunnelOperation snapshot.copy(sessionTermination = sessionLifecycle.termination, openVpnRevocation = revocationState,
                systemProtection = protection).toChannelMap()
        }
        if (activeProtocol == VpnProtocol.OPENVPN && !openVpn.isConnected()) {
            handleOpenVpnFailure(openVpn.sessionGeneration, openVpn.sessionFailure ?: "tunnel_disconnected")
            return@withTunnelOperation stateSnapshot()
        }
        val statistics = try {
            when (activeProtocol) {
                VpnProtocol.WIREGUARD -> wireGuard.statistics()
                VpnProtocol.OPENVPN -> openVpn.statistics()
                null -> null
            }
        } catch (_: Exception) {
            null
        }
        val refreshed = snapshot.withTunnelStatistics(statistics).copy(
            systemProtection = protection,
            openVpnRevocation = revocationState,
            timestampMillis = System.currentTimeMillis(),
        )
        synchronized(stateLock) {
            // An interruption can arrive while statistics are being sampled.
            // Never let that older sample restore CONNECTED.
            if (currentState === snapshot) currentState = refreshed
            currentState.toChannelMap()
        }
    }

    private fun setActiveMetadata(
        accountId: String,
        deviceId: String,
        locationId: String,
        locationName: String,
    ) {
        tunnelInstanceEpoch.incrementAndGet()
        activeAccountId = accountId
        activeDeviceId = deviceId
        activeLocationId = locationId
        activeLocationName = locationName
        connectedAtMillis = null
    }

    private fun clearActiveMetadata() {
        stopWireGuardRecoveryLocked()
        provenConnectionProfile = null
        recoveryOwnsSession = false
        activeAccountId = null
        activeDeviceId = null
        activeLocationId = null
        activeLocationName = null
        connectedAtMillis = null
    }

    private fun currentActivity(): Activity? = activityReference?.get()

    private fun dispatchAsync(block: suspend (Long) -> Unit) {
        val ticket = activeSessionEpoch
        operationScope.launch { block(ticket) }
    }

    private fun launchResult(result: MethodChannel.Result, block: suspend () -> Any?) {
        operationScope.launch {
            try {
                val value = block()
                withContext(Dispatchers.Main) { result.success(value) }
            } catch (error: Throwable) {
                val code = messageCode(error, "native_operation_failed")
                withContext(Dispatchers.Main) {
                    result.error(code, nativeErrorMessage(code), null)
                }
            }
        }
    }

    private fun launchVoidResult(result: MethodChannel.Result, block: suspend () -> Any?) =
        operationScope.launch {
            try {
                block()
                withContext(Dispatchers.Main) { result.success(null) }
            } catch (error: Throwable) {
                val code = messageCode(error, "native_operation_failed")
                withContext(Dispatchers.Main) {
                    result.error(code, nativeErrorMessage(code), null)
                }
            }
        }

    private fun launchTunnelResult(result: MethodChannel.Result, ticket: Long, epoch: Long,
        protocol: VpnProtocol, timing: NativeConnectionTiming.TraceContext?, block: suspend () -> Any?) {
        val queued = NativeConnectionTiming.begin(timing, "rpc_execution_queue")
        launchVoidResult(result) {
            queued?.end()
            try {
                NativeConnectionTiming.spanSuspend(timing, "rpc_execution") { block() }
            }
            catch (error: Throwable) {
                if (sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == epoch) {
                    val failure = messageCode(error, "system_vpn_resume_failed")
                    emitState(VpnStatus.ERROR, activeProtocol ?: protocol, failure)
                    WireGuardForegroundNotifier.startProtocol(appContext, activeProtocol ?: protocol,
                        VpnStatus.ERROR, requiresAction = true)
                }
                throw error
            }
        }.invokeOnCompletion { queued?.end() }
    }

    private suspend fun <T> withTunnelOperation(timing: NativeConnectionTiming.TraceContext? = null, block: suspend () -> T): T {
        val waiting = NativeConnectionTiming.begin(timing, "tunnel_mutex_wait")
        return try {
            tunnelOperationMutex.withLock {
                waiting?.end()
                try { NativeConnectionTiming.spanSuspend(timing, "tunnel_mutex_execution") { block() } }
                finally { closeTunnelHold() }
            }
        } catch (error: Throwable) {
            waiting?.error()
            throw error
        }
    }

    private fun messageCode(error: Throwable, fallback: String): String =
        (error as? VpnNativeException)?.code
            ?: (error as? SecureStorageException)?.code
            ?: (error as? SystemVpnResumeException)?.code
            ?: fallback

    private fun nativeErrorMessage(code: String): String = code

    private fun MethodCall.requireMap(): Map<String, Any?> =
        (arguments as? Map<*, *>)?.entries?.associate { (key, value) -> key as String to value }
            ?: throw VpnNativeException("invalid_arguments")

    private fun MethodCall.requireAccountId(): String = requireMap().requiredString(ACCOUNT_ID)

    private fun Map<String, Any?>.requiredString(key: String): String =
        (this[key] as? String)?.takeIf { it.isNotBlank() }
            ?: throw VpnNativeException("invalid_arguments")

    private fun Map<String, Any?>.requiredStringList(key: String): List<String> =
        (this[key] as? List<*>)?.map { it as? String ?: throw VpnNativeException("invalid_arguments") }
            ?.takeIf { it.isNotEmpty() }
            ?: throw VpnNativeException("invalid_arguments")

    private fun Map<String, Any?>.requiredDisplayName(key: String): String =
        requiredString(key).takeIf { value ->
            value.length <= 96 && value.none(Char::isISOControl)
        } ?: throw VpnNativeException("invalid_arguments")

    private fun Map<String, Any?>.toWireGuardRequest(): WireGuardRequest = WireGuardRequest(
        accountId = requiredString(ACCOUNT_ID),
        deviceId = requiredString(DEVICE_ID),
        locationId = requiredString(LOCATION_ID),
        locationName = requiredDisplayName(LOCATION_NAME),
        address = requiredString("address"),
        dns = requiredStringList("dns"),
        serverPublicKey = requiredString("server_public_key"),
        endpoint = requiredString("endpoint"),
        allowedIps = requiredStringList("allowed_ips"),
        network = TunnelNetworkSpec.from(this),
    )

    companion object {
        const val METHOD_CHANNEL = "com.fuzevpn/android_vpn"
        const val EVENT_CHANNEL = "com.fuzevpn/android_vpn/events"
        private const val VPN_PERMISSION_REQUEST_CODE = 9811
        private const val NOTIFICATION_PERMISSION_REQUEST_CODE = 9812
        private const val DIAGNOSTIC_EXPORT_REQUEST_CODE_START = 20_000
        private const val DIAGNOSTIC_EXPORT_REQUEST_CODE_END = 65_535
        private const val OPENVPN_SERVICE_START_TIMEOUT_MS = 5_000L
        private const val ALWAYS_ON_SAMPLE_MS = 2_000L
        private const val ANOTHER_VPN_ACTIVE = "another VPN is active"
        private const val NOT_PERMANENT_VPN = "the permanent VPN is no longer this app"
        private const val ALWAYS_ON_VPN_APP_SETTING = "always_on_vpn_app"
        private const val OPENVPN_RECONNECTING = "openvpn_reconnecting"
        private const val LOG_TAG = "FuzeVpnBridge"
        private const val ACCOUNT_ID = "account_id"
        private const val DEVICE_ID = "device_id"
        private const val LOCATION_ID = "location_id"
        private const val LOCATION_NAME = "location_name"
        private const val PAYLOAD = "payload"
        private const val VALUE = "value"
        @Volatile
        private var retainedRuntime: AndroidVpnBridge? = null

        /** One process-level runtime survives activity recreation and backgrounding. */
        @Synchronized
        fun obtain(context: Context, activity: Activity, messenger: BinaryMessenger): AndroidVpnBridge {
            return obtain(context).also { it.attach(activity, messenger) }
        }

        /** Runtime entry point for the Quick Settings tile without Flutter. */
        @Synchronized
        fun obtain(context: Context): AndroidVpnBridge {
            return retainedRuntime ?: AndroidVpnBridge(context.applicationContext).also {
                retainedRuntime = it
            }
        }
    }
}
