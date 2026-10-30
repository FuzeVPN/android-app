@file:OptIn(kotlinx.coroutines.ExperimentalCoroutinesApi::class)
package com.fuzevpn.android

import java.util.Collections
import java.util.concurrent.ConcurrentLinkedDeque
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicLong
import java.util.concurrent.atomic.AtomicReference
import kotlin.coroutines.CoroutineContext
import kotlinx.coroutines.*
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.test.*
import org.junit.Assert.*
import org.junit.Test

// The runner extracts actual bridge methods and both connection admission
// prefixes. Only Android, durable registry, session and engine are fixtures.
internal class VpnNativeException(val code: String) : Exception(code)
internal class UserManager {
    @Volatile var unlocked = true
    val queried = CountDownLatch(1)
    val isUserUnlocked: Boolean get() { queried.countDown(); return unlocked }
}
internal class ContextFixture {
    val userManager = UserManager()
    fun <T> getSystemService(type: Class<T>): UserManager = userManager
    fun startActivity(intent: Any) {}
}
internal object SharedVpnHost {
    fun systemFlags(): Pair<Boolean?, Boolean?> = false to false
    fun settingsIntent(): Any = Any()
}
internal object WireGuardForegroundNotifier {
    fun startProtocol(context: Any, protocol: VpnProtocol?, status: VpnStatus,
        requiresAction: Boolean = false, isReconnecting: Boolean = false) {}
}
internal object NativeConnectionTiming {
    fun <T> span(timing: Any?, stage: String, block: () -> T): T = block()
}
internal data class VpnState(val status: VpnStatus = VpnStatus.IDLE, val protocol: VpnProtocol? = null, val messageCode: String? = null)
internal data class WireGuardRequest(val accountId: String = "synthetic-account", val deviceId: String = "synthetic-device")
internal data class QuickTileProfile(val protocol: VpnProtocol, val wireGuardRequest: WireGuardRequest? = WireGuardRequest())
internal data class ResumeFixture(val profile: QuickTileProfile,
    val isResumable: Boolean = true, val errorCode: String? = null, val recoveryConsumed: Boolean = false)
/** Durable record: READY, RESERVED by a system start, BLOCKED, or a tombstone. */
internal class RegistryFixture(var profile: QuickTileProfile) {
    @Volatile var missing = false
    @Volatile var blocked = false
    @Volatile var rejectReservation = false
    @Volatile var reserved = false
    var reserveHook: () -> Unit = {}
    val snapshotHook = AtomicReference<(() -> Unit)?>(null)
    val reservations = AtomicInteger()
    val blocks: MutableList<String> = Collections.synchronizedList(mutableListOf())
    fun snapshot(): ResumeFixture? {
        snapshotHook.getAndSet(null)?.invoke()
        return if (missing) null else ResumeFixture(profile, !blocked && !reserved)
    }
    fun reserve(session: String, identity: String): ResumeFixture? {
        reserveHook()
        if (rejectReservation || missing || blocked || reserved) return null
        reservations.incrementAndGet()
        reserved = true
        return ResumeFixture(profile)
    }
    fun block(code: String) {
        if (!missing) { blocked = true; reserved = false }
        blocks += code
    }
    fun invalidate() { missing = true; blocked = false; reserved = false }
    fun arm() { missing = false; blocked = false; reserved = false }
}
internal class SessionFixture {
    fun ticket(): Long = 0
    fun check(ticket: Long) { check(ticket == 0L) }
    fun isCurrent(ticket: Long) = ticket == 0L
}
internal class ProfileFixture(var profile: QuickTileProfile) { fun read(): QuickTileProfile? = profile }
internal class OpenVpnFixture {
    @Volatile var network = true
    val probed = CountDownLatch(1)
    fun cancelPendingConnection() {}
    fun hasUsableNetwork(): Boolean { probed.countDown(); return network }
}
internal class ManualDispatcher : CoroutineDispatcher() {
    private val tasks = ConcurrentLinkedDeque<Runnable>()
    val queued = CountDownLatch(1)
    override fun dispatch(context: CoroutineContext, block: Runnable) { tasks.add(block); queued.countDown() }
    fun runFirst() { checkNotNull(tasks.pollFirst()) { "No queued task" }.run() }
    fun runLast() { checkNotNull(tasks.pollLast()) { "No queued task" }.run() }
    fun drain() { while (true) (tasks.pollFirst() ?: break).run() }
}
internal class ObservedEpoch {
    private val value = AtomicLong()
    var observeRead: () -> Unit = {}
    fun get(): Long { observeRead(); return value.get() }
    fun incrementAndGet(): Long = value.incrementAndGet()
}

internal class SystemEpochBridge(private val operationScope: CoroutineScope, protocol: VpnProtocol) {
    val appContext = ContextFixture()
    private val sessionLifecycle = SessionFixture()
    val quickTileProfiles = ProfileFixture(QuickTileProfile(protocol))
    val resumeRegistry = RegistryFixture(quickTileProfiles.profile)
    val openVpn = OpenVpnFixture()
    private val systemStartLock = Any()
    private var systemStartJob: Job? = null
    private var systemStartInFlight = false
    private var resumeStorageFailure = false
    private var resumeState = "ready"
    private var resumeError: String? = null
    val tunnelRequestEpoch = ObservedEpoch()
    val systemStartPublicationEpoch = ObservedEpoch()
    val explicitAdmissionEpoch = AtomicLong()
    val releasedSystemStartEpoch = AtomicLong()
    private var explicitHoldOpen = false
    private var systemRestoreHoldOpen = false
    private var systemRestoreInstance = -1L
    private val publicationSequence = AtomicLong()
    private val tunnelInstanceEpoch = AtomicLong()
    @Volatile var activeProtocol: VpnProtocol? = null
    private val stateLock = Any()
    @Volatile private var currentState = VpnState()
    var status: VpnStatus
        get() = currentState.status
        set(value) { currentState = currentState.copy(status = value) }
    val lastCode: String? get() = currentState.messageCode
    val published: MutableList<String> = Collections.synchronizedList(mutableListOf())
    val identityCalls = AtomicInteger()
    val oldReadEntered = CountDownLatch(1)
    val releaseOldRead = CountDownLatch(1)
    val restored = CountDownLatch(1)
    val tileCompleted = CountDownLatch(1)
    val stopped = CountDownLatch(1)
    val explicitConnected = CountDownLatch(1)
    val explicitFailed = CountDownLatch(1)
    val systemFailed = CountDownLatch(1)
    val connections = AtomicInteger()
    val stopCalls = AtomicInteger()
    val autoStops = AtomicInteger()
    @Volatile var blockFirstIdentity = true
    @Volatile var failOldRead = true
    @Volatile var oldReadFailure = "secure_storage_read_failed"
    @Volatile var identityHook: (Int) -> Unit = {}
    @Volatile var connectHook: () -> Unit = {}
    @Volatile var restoreFailure: String? = null
    @Volatile var explicitFailure: String? = null
    @Volatile var callbackFailure: String? = null
    var observeEffect: (String) -> Unit = {}
    var afterTransition: () -> Unit = {}
    val beforeLock = AtomicReference<(() -> Unit)?>(null)
    private val transition = Mutex()
    fun holdsSystemStartLock(): Boolean = Thread.holdsLock(systemStartLock)
    fun systemJob(): Job? = synchronized(systemStartLock) { systemStartJob }
    private fun checkRequest(epoch: Long) {
        if (tunnelRequestEpoch.get() != epoch) throw VpnNativeException("session_operation_cancelled")
    }
    private suspend fun <T> withTunnelOperation(block: suspend () -> T): T {
        // Observation point only: the caller is about to queue on the real kotlinx Mutex.
        beforeLock.getAndSet(null)?.invoke()
        // Same hold boundary as production: closeTunnelHold runs before the
        // mutex can pass to the next waiter.
        val result = transition.withLock { try { block() } finally { closeTunnelHold() } }
        // Represents preemption after the real mutex has been released, before
        // the caller resumes. This never injects an event into a critical block.
        afterTransition()
        return result
    }
    private fun cancelRecovery() {}
    private fun ensureVpnAuthorized(publishFailure: Boolean = true) {}
    private fun localSession(profile: QuickTileProfile): String = "synthetic-session"
    /** Runs inside the admission of connectWireGuard, in the caller's mutex hold. */
    @Volatile var sessionHook: () -> Unit = {}
    private fun localSession(accountId: String, deviceId: String): String { sessionHook(); return "synthetic-session" }
    private fun quickTileProfileSnapshot(): QuickTileProfile? = quickTileProfiles.read()
    private fun localIdentity(profile: QuickTileProfile): String {
        val call = identityCalls.incrementAndGet()
        if (call == 1 && blockFirstIdentity) {
            oldReadEntered.countDown()
            requireSignal(releaseOldRead)
            if (failOldRead) throw VpnNativeException(oldReadFailure)
        }
        identityHook(call)
        return "synthetic-identity"
    }
    private fun emitState(value: VpnStatus, protocol: VpnProtocol?, code: String?) {
        observeEffect("state")
        synchronized(stateLock) { currentState = VpnState(value, protocol, code) }
        publicationSequence.incrementAndGet()
        published += "$value/$protocol/$code"
        if (code?.startsWith("system_vpn_resume_") == true && value == VpnStatus.ERROR) systemFailed.countDown()
    }
    private fun messageCode(error: Throwable, fallback: String): String = (error as? VpnNativeException)?.code ?: fallback
    private suspend fun connectWireGuard(request: WireGuardRequest, ticket: Long,
        requestEpoch: Long = tunnelRequestEpoch.get(), restoring: Boolean = false,
        localOnly: Boolean = false, expectedSystemStartEpoch: Long? = null,
        systemAuthority: Long? = null): Boolean = withTunnelOperation {
        val timing: Any? = null
/* PRODUCTION_WG_ADMISSION */
        connect(VpnProtocol.WIREGUARD, restoring)
    }
    private suspend fun reconnectOpenVpn(profile: QuickTileProfile, ticket: Long,
        requestEpoch: Long = tunnelRequestEpoch.get(), restoring: Boolean = false,
        recoveryConsumed: Boolean = false, expectedSystemStartEpoch: Long? = null,
        systemAuthority: Long? = null): Boolean = withTunnelOperation {
/* PRODUCTION_OVPN_ADMISSION */
        connect(VpnProtocol.OPENVPN, restoring)
    }
    /** Engine body after admission, in production order. */
    private fun connect(protocol: VpnProtocol, restoring: Boolean): Boolean {
        if (restoring) {
            systemRestoreHoldOpen = true
            if (!resumeRegistry.reserved) throw VpnNativeException("system_vpn_resume_identity_changed")
        } else invalidateSystemResume()
        connectHook()
        if (activeProtocol != null) disconnectLocked(userInitiated = false)
        tunnelInstanceEpoch.incrementAndGet()
        if (restoring) systemRestoreInstance = tunnelInstanceEpoch.get()
        activeProtocol = protocol
        (if (restoring) restoreFailure else explicitFailure)?.let { code ->
            // A confirmed engine stop clears the marker before ERROR (connectWireGuard).
            activeProtocol = null
            emitState(VpnStatus.ERROR, protocol, code)
            throw VpnNativeException(code)
        }
        connections.incrementAndGet()
        if (restoring) resumeRegistry.reserved = false else resumeRegistry.arm()
        emitState(VpnStatus.CONNECTED, protocol, null)
        if (restoring) { systemRestoreHoldOpen = false; restored.countDown() } else explicitConnected.countDown()
        return true
    }
    /** invalidateSystemResume: the explicit admission point of every command. */
    private fun invalidateSystemResume() {
        admitExplicitCommand()
        resumeRegistry.invalidate()
    }
    private suspend fun disconnect(userInitiated: Boolean, ticket: Long, stopHost: Boolean,
        requestEpoch: Long = tunnelRequestEpoch.get()): Boolean = withTunnelOperation {
        checkRequest(requestEpoch)
        sessionLifecycle.check(ticket)
        invalidateSystemResume()
        disconnectLocked(userInitiated)
    }
    private fun disconnectLocked(userInitiated: Boolean): Boolean {
        if (userInitiated) { stopCalls.incrementAndGet(); stopped.countDown() }
        val protocol = activeProtocol
        if (protocol == null) { emitState(VpnStatus.IDLE, null, null); return true }
        if (!userInitiated) autoStops.incrementAndGet()
        emitState(VpnStatus.DISCONNECTING, protocol, null)
        activeProtocol = null
        emitState(VpnStatus.IDLE, null, null)
        return true
    }
    fun receiveExplicitStop() {
        cancelSystemStart()
        val requestEpoch = tunnelRequestEpoch.get()
        operationScope.launch { disconnect(true, sessionLifecycle.ticket(), true, requestEpoch) }
    }
    /** onMethodCall("connectWireGuard") with launchTunnelResult's failure publication. */
    fun receiveExplicitConnect(preLock: () -> Unit = {}) {
        cancelSystemStart()
        val requestEpoch = tunnelRequestEpoch.get()
        val ticket = sessionLifecycle.ticket()
        operationScope.launch {
            preLock()
            try { connectWireGuard(WireGuardRequest(), ticket, requestEpoch) }
            catch (error: Exception) {
                if (sessionLifecycle.isCurrent(ticket) && tunnelRequestEpoch.get() == requestEpoch) {
                    emitState(VpnStatus.ERROR, activeProtocol ?: VpnProtocol.WIREGUARD, messageCode(error, "system_vpn_resume_failed"))
                }
                explicitFailed.countDown()
            }
        }
    }
    /** prepareTunnelRequest: cancels a system start and invalidates, without publishing. */
    fun receivePrepare() {
        cancelSystemStart()
        val requestEpoch = tunnelRequestEpoch.get()
        operationScope.launch { withTunnelOperation { checkRequest(requestEpoch); invalidateSystemResume() } }
    }
    fun clickTile() = toggleFromQuickTile {
        observeEffect("callback")
        callbackFailure = it
        tileCompleted.countDown()
    }
    fun startSystemAndCaptureJob(): Job? = synchronized(systemStartLock) {
        onSystemVpnStart()
        systemStartJob
    }

/* PRODUCTION_CANCEL */
/* PRODUCTION_SYSTEM */
/* PRODUCTION_TILE */
}

internal fun requireSignal(signal: CountDownLatch) {
    check(signal.await(5, TimeUnit.SECONDS)) { "test-barrier-timeout" }
}

internal fun SystemEpochBridge.noErrorOrRestoreAfterConnected(): Boolean {
    val list = synchronized(published) { published.toList() }
    val connected = list.indexOfLast { it.startsWith("CONNECTED/") }
    return connected >= 0 && list.drop(connected + 1).none { it.startsWith("ERROR/") || it.startsWith("CONNECTING/") || it.startsWith("IDLE/") }
}

class SystemVpnCommandEpochTest {
    private fun fixture(protocol: VpnProtocol = VpnProtocol.WIREGUARD,
        operationDispatcher: CoroutineDispatcher = Dispatchers.Default,
        main: CoroutineDispatcher = UnconfinedTestDispatcher(), body: (SystemEpochBridge) -> Unit) = runBlocking {
        Dispatchers.setMain(main)
        val scope = CoroutineScope(SupervisorJob() + operationDispatcher)
        val bridge = SystemEpochBridge(scope, protocol)
        try { body(bridge) }
        finally {
            bridge.releaseOldRead.countDown()
            val job = scope.coroutineContext[Job]!!
            job.cancel()
            (operationDispatcher as? ManualDispatcher)?.drain()
            (main as? ManualDispatcher)?.drain()
            job.join()
            Dispatchers.resetMain()
        }
    }

    private fun oldFailureIsDiscarded(protocol: VpnProtocol) = fixture(protocol) { bridge ->
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        val explicitEpoch = bridge.tunnelRequestEpoch.get()
        bridge.onSystemVpnStart()
        requireSignal(bridge.restored)
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(explicitEpoch, bridge.tunnelRequestEpoch.get())
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(protocol, bridge.activeProtocol)
        assertNull(bridge.callbackFailure)
        assertFalse(quickTileFailureOpensApplication(bridge.callbackFailure))
        assertEquals(1, bridge.connections.get())
        assertEquals(1L, bridge.systemStartPublicationEpoch.get())
    }
    @Test fun wireGuardSystemConnectedSurvivesOlderTileFailure() = oldFailureIsDiscarded(VpnProtocol.WIREGUARD)
    @Test fun openVpnSystemConnectedSurvivesOlderTileFailure() = oldFailureIsDiscarded(VpnProtocol.OPENVPN)

    @Test fun queuedMainFailureCannotOpenAppAfterSystemAdmission() {
        val main = ManualDispatcher()
        fixture(main = main) { bridge ->
            bridge.clickTile()
            requireSignal(bridge.oldReadEntered)
            bridge.releaseOldRead.countDown()
            requireSignal(main.queued)
            // A11-03: a local refusal opens the app; it publishes no global ERROR.
            assertEquals(VpnStatus.IDLE, bridge.status)
            bridge.onSystemVpnStart()
            requireSignal(bridge.restored)
            main.drain()
            requireSignal(bridge.tileCompleted)
            assertEquals(VpnStatus.CONNECTED, bridge.status)
            assertNull(bridge.callbackFailure)
        }
    }

    private fun successfulOldReadCannotRestartSystem(protocol: VpnProtocol) = fixture(protocol) { bridge ->
        bridge.failOldRead = false
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        bridge.onSystemVpnStart()
        requireSignal(bridge.restored)
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        assertEquals(1, bridge.connections.get())
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertNull(bridge.callbackFailure)
    }
    @Test fun wireGuardOlderSuccessfulTileCannotRestartNewerSystemTunnel() = successfulOldReadCannotRestartSystem(VpnProtocol.WIREGUARD)
    @Test fun openVpnOlderSuccessfulTileCannotRestartNewerSystemTunnel() = successfulOldReadCannotRestartSystem(VpnProtocol.OPENVPN)

    @Test fun missingBlockedAndRefusedReservationDoNotCancelAnExplicitTile() {
        for (refusal in listOf("missing", "blocked", "reserve")) fixture { bridge ->
            bridge.failOldRead = false
            bridge.clickTile()
            requireSignal(bridge.oldReadEntered)
            bridge.resumeRegistry.missing = refusal == "missing"
            bridge.resumeRegistry.blocked = refusal == "blocked"
            bridge.resumeRegistry.rejectReservation = refusal == "reserve"
            val epoch = bridge.tunnelRequestEpoch.get()
            bridge.onSystemVpnStart()
            requireSignal(bridge.systemFailed)
            assertEquals(0L, bridge.systemStartPublicationEpoch.get())
            assertEquals(epoch, bridge.tunnelRequestEpoch.get())
            bridge.releaseOldRead.countDown()
            requireSignal(bridge.tileCompleted)
            assertEquals(1, bridge.connections.get())
            assertEquals(VpnStatus.CONNECTED, bridge.status)
            assertNull(bridge.callbackFailure)
        }
    }

    @Test fun duplicateBeforeUnlockDoesNotTouchEitherEpochOrStorage() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        bridge.appContext.userManager.unlocked = false
        bridge.onSystemVpnStart()
        requireSignal(bridge.appContext.userManager.queried)
        bridge.onSystemVpnStart()
        assertEquals(0L, bridge.tunnelRequestEpoch.get())
        assertEquals(0L, bridge.systemStartPublicationEpoch.get())
        assertEquals(0, bridge.identityCalls.get())
        bridge.receiveExplicitStop()
        requireSignal(bridge.stopped)
        bridge.appContext.userManager.unlocked = true
        assertEquals(0, bridge.connections.get())
    }

    @Test fun duplicateAdmittedSystemWaitDoesNotCancelExplicitStopOrAutoReconnect() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        bridge.openVpn.network = false
        bridge.onSystemVpnStart()
        requireSignal(bridge.openVpn.probed)
        bridge.onSystemVpnStart()
        assertEquals(1L, bridge.systemStartPublicationEpoch.get())
        assertEquals(0L, bridge.tunnelRequestEpoch.get())
        assertEquals(1, bridge.resumeRegistry.reservations.get())
        bridge.receiveExplicitStop()
        requireSignal(bridge.stopped)
        bridge.openVpn.network = true
        assertEquals(VpnStatus.IDLE, bridge.status)
        assertEquals(0, bridge.connections.get())
    }

    @Test fun newerExplicitCommandDuringReservationPreventsSystemAdmission() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        val reserveEntered = CountDownLatch(1)
        val releaseReserve = CountDownLatch(1)
        bridge.resumeRegistry.reserveHook = { reserveEntered.countDown(); requireSignal(releaseReserve) }
        try {
            bridge.onSystemVpnStart()
            requireSignal(reserveEntered)
            bridge.receiveExplicitConnect()
            val explicitEpoch = bridge.tunnelRequestEpoch.get()
            releaseReserve.countDown()
            requireSignal(bridge.explicitConnected)
            assertEquals(explicitEpoch, bridge.tunnelRequestEpoch.get())
            assertEquals(0L, bridge.systemStartPublicationEpoch.get())
            assertEquals(1, bridge.connections.get())
        } finally { releaseReserve.countDown() }
    }

    @Test fun alreadyQueuedExplicitStopSurvivesLaterAutomaticAdmission() {
        val dispatcher = ManualDispatcher()
        fixture(operationDispatcher = dispatcher) { bridge ->
            bridge.blockFirstIdentity = false
            bridge.receiveExplicitStop()
            val stopEpoch = bridge.tunnelRequestEpoch.get()
            bridge.onSystemVpnStart()
            dispatcher.runLast() // Force automatic work ahead of the queued stop.
            assertEquals(VpnStatus.CONNECTED, bridge.status)
            assertEquals(1L, bridge.systemStartPublicationEpoch.get())
            assertEquals(stopEpoch, bridge.tunnelRequestEpoch.get())
            dispatcher.drain()
            assertEquals(1, bridge.stopCalls.get())
            assertEquals(VpnStatus.IDLE, bridge.status)
            assertNull(bridge.activeProtocol)
        }
    }

    @Test fun duplicateForConnectedEngineCannotCancelQueuedExplicitConnection() {
        val dispatcher = ManualDispatcher()
        fixture(operationDispatcher = dispatcher) { bridge ->
            bridge.blockFirstIdentity = false
            bridge.activeProtocol = VpnProtocol.OPENVPN
            bridge.status = VpnStatus.CONNECTED
            bridge.receiveExplicitConnect()
            val explicitEpoch = bridge.tunnelRequestEpoch.get()
            bridge.onSystemVpnStart()
            assertEquals(0L, bridge.systemStartPublicationEpoch.get())
            assertEquals(explicitEpoch, bridge.tunnelRequestEpoch.get())
            dispatcher.drain()
            assertEquals(VpnProtocol.WIREGUARD, bridge.activeProtocol)
            assertEquals(1, bridge.connections.get())
        }
    }

    @Test fun reservationRevalidationIsAtomicWithExplicitCancellation() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        var admissionCheckHeldLock: Boolean? = null
        bridge.resumeRegistry.reserveHook = {
            bridge.tunnelRequestEpoch.observeRead = {
                admissionCheckHeldLock = bridge.holdsSystemStartLock()
                bridge.tunnelRequestEpoch.observeRead = {}
            }
        }
        bridge.onSystemVpnStart()
        requireSignal(bridge.restored)
        assertEquals(true, admissionCheckHeldLock)
    }

    private fun tileFailureChecksRemainLocked(failure: String) = fixture { bridge ->
        bridge.oldReadFailure = failure
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        val checksHeldLock = mutableListOf<Boolean>()
        val effectsHeldLock = mutableListOf<Pair<String, Boolean>>()
        bridge.systemStartPublicationEpoch.observeRead = { checksHeldLock += bridge.holdsSystemStartLock() }
        bridge.observeEffect = { effectsHeldLock += it to bridge.holdsSystemStartLock() }
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        assertEquals(listOf(true, true), checksHeldLock)
        assertEquals(failure, bridge.callbackFailure)
        if (quickTileFailureOpensApplication(failure)) {
            // A11-03: a local refusal only opens the app.
            assertEquals(listOf("callback" to true), effectsHeldLock)
            assertEquals(VpnStatus.IDLE, bridge.status)
        } else {
            assertEquals(listOf("state" to true, "callback" to true), effectsHeldLock)
            assertEquals(VpnStatus.ERROR, bridge.status)
        }
    }
    @Test fun tileErrorAndCallbackChecksRemainLockedThroughTheirEffects() = tileFailureChecksRemainLocked("wireguard_start_failed")
    @Test fun tileLocalRefusalCheckRemainsLockedAndPublishesNothing() = tileFailureChecksRemainLocked("secure_storage_read_failed")

    @Test fun explicitConnectionAfterReservationCannotBeOverwrittenByOldSystemConnecting() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        val transitions = AtomicInteger()
        val oldSystemFinishedBoundary = CountDownLatch(1)
        bridge.afterTransition = {
            if (transitions.incrementAndGet() == 1) {
                bridge.receiveExplicitConnect()
                requireSignal(bridge.explicitConnected)
                oldSystemFinishedBoundary.countDown()
            }
        }
        val system = bridge.startSystemAndCaptureJob()
        requireSignal(oldSystemFinishedBoundary)
        // The old system must actually finish; checking only the explicit
        // connection latch would miss a later obsolete CONNECTING publication.
        runBlocking { system?.join() }
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(VpnProtocol.WIREGUARD, bridge.activeProtocol)
        assertEquals(1, bridge.connections.get())
    }

    // H-E22-N01-01: a refused system start holds the mutex while an explicit
    // command of the same request epoch queues behind it. Its catch must not
    // stop, block or overwrite the explicit result.
    private fun refusedSystemStartKeepsQueuedTile(protocol: VpnProtocol, refusal: String) = fixture(protocol) { bridge ->
        bridge.failOldRead = false
        val systemInside = CountDownLatch(1)
        val tileQueued = CountDownLatch(1)
        val holdThenRefuse: () -> Unit = { systemInside.countDown(); requireSignal(tileQueued); Thread.sleep(200) }
        when (refusal) {
            "blocked" -> { bridge.resumeRegistry.blocked = true; bridge.resumeRegistry.snapshotHook.set(holdThenRefuse) }
            "reserve" -> { bridge.resumeRegistry.rejectReservation = true; bridge.resumeRegistry.reserveHook = holdThenRefuse }
            "identity" -> bridge.identityHook = { call ->
                if (call == 2) { holdThenRefuse(); throw VpnNativeException("secure_storage_read_failed") }
            }
        }
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        val epoch = bridge.tunnelRequestEpoch.get()
        bridge.onSystemVpnStart()
        val system = bridge.systemJob()
        requireSignal(systemInside)
        bridge.beforeLock.set { tileQueued.countDown() }
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        runBlocking { withTimeout(5_000) { system?.join() } }
        assertEquals(epoch, bridge.tunnelRequestEpoch.get())
        assertEquals(0L, bridge.systemStartPublicationEpoch.get())
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(protocol, bridge.activeProtocol)
        assertEquals(0, bridge.autoStops.get())
        assertTrue(bridge.resumeRegistry.blocks.toString(), bridge.resumeRegistry.blocks.isEmpty())
        assertTrue(bridge.published.toString(), bridge.noErrorOrRestoreAfterConnected())
        assertNull(bridge.callbackFailure)
    }
    @Test fun blockedSystemResumeKeepsQueuedWireGuardTile() = refusedSystemStartKeepsQueuedTile(VpnProtocol.WIREGUARD, "blocked")
    @Test fun refusedReservationKeepsQueuedWireGuardTile() = refusedSystemStartKeepsQueuedTile(VpnProtocol.WIREGUARD, "reserve")
    @Test fun systemIdentityFailureKeepsQueuedWireGuardTile() = refusedSystemStartKeepsQueuedTile(VpnProtocol.WIREGUARD, "identity")
    @Test fun blockedSystemResumeKeepsQueuedOpenVpnTile() = refusedSystemStartKeepsQueuedTile(VpnProtocol.OPENVPN, "blocked")

    @Test fun refusedSystemStartKeepsQueuedFlutterConnection() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        bridge.resumeRegistry.blocked = true
        val systemInside = CountDownLatch(1)
        val explicitQueued = CountDownLatch(1)
        bridge.resumeRegistry.snapshotHook.set { systemInside.countDown(); requireSignal(explicitQueued); Thread.sleep(200) }
        bridge.receiveExplicitConnect(preLock = {
            requireSignal(systemInside)
            bridge.beforeLock.set { explicitQueued.countDown() }
        })
        bridge.onSystemVpnStart()
        val system = bridge.systemJob()
        requireSignal(bridge.explicitConnected)
        runBlocking { withTimeout(5_000) { system?.join() } }
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(0, bridge.autoStops.get())
        assertTrue(bridge.resumeRegistry.blocks.isEmpty())
        assertTrue(bridge.published.toString(), bridge.noErrorOrRestoreAfterConnected())
    }

    // A08-vpn-bridge-01, variant A: the system start is admitted first, then an
    // earlier Flutter connection of the same epoch takes the tunnel.
    @Test fun admittedSystemStartYieldsToAnEarlierFlutterConnection() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        val reserving = CountDownLatch(1)
        val explicitQueued = CountDownLatch(1)
        bridge.resumeRegistry.reserveHook = { reserving.countDown(); requireSignal(explicitQueued); Thread.sleep(200) }
        bridge.receiveExplicitConnect(preLock = {
            requireSignal(reserving)
            bridge.beforeLock.set { explicitQueued.countDown() }
        })
        bridge.onSystemVpnStart()
        val system = bridge.systemJob()
        requireSignal(bridge.explicitConnected)
        runBlocking { withTimeout(5_000) { system?.join() } }
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(1, bridge.connections.get())
        assertEquals(0, bridge.autoStops.get())
        assertTrue(bridge.resumeRegistry.blocks.isEmpty())
        assertFalse("explicit READY record replaced", bridge.resumeRegistry.missing || bridge.resumeRegistry.blocked)
        assertTrue(bridge.published.toString(), bridge.noErrorOrRestoreAfterConnected())
    }

    // A08-vpn-bridge-01, variant B: the callback arrives while an admitted
    // explicit connection holds the mutex; that connection then fails.
    @Test fun systemStartDuringAFailingFlutterConnectionKeepsItsError() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        bridge.explicitFailure = "wireguard_handshake_timeout"
        val systemQueued = CountDownLatch(1)
        bridge.connectHook = {
            bridge.connectHook = {}
            bridge.beforeLock.set { systemQueued.countDown() }
            bridge.onSystemVpnStart()
            requireSignal(systemQueued)
            Thread.sleep(100)
        }
        bridge.receiveExplicitConnect()
        requireSignal(bridge.explicitFailed)
        runBlocking { withTimeout(5_000) { bridge.systemJob()?.join() } }
        Thread.sleep(100)
        assertEquals(VpnStatus.ERROR, bridge.status)
        assertEquals("wireguard_handshake_timeout", bridge.lastCode)
        assertTrue(bridge.resumeRegistry.blocks.isEmpty())
        assertFalse(bridge.published.toString(), bridge.published.any { it.contains("system_vpn_resume_") || it.startsWith("IDLE/") })
    }

    // H-E22-N01-02: an older tile click runs once the newer admitted system
    // start no longer owns or attempts the engine.
    @Test fun olderTileConnectsAfterTheNewerSystemResumeFailed() = fixture { bridge ->
        bridge.failOldRead = false
        bridge.restoreFailure = "wireguard_handshake_timeout"
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        bridge.onSystemVpnStart()
        runBlocking { withTimeout(5_000) { bridge.systemJob()?.join() } }
        assertEquals(VpnStatus.ERROR, bridge.status)
        assertEquals(1L, bridge.systemStartPublicationEpoch.get())
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(1, bridge.connections.get())
        assertNull(bridge.callbackFailure)
    }

    @Test fun olderTileFailureIsReportedAfterTheNewerSystemResumeFailed() = fixture { bridge ->
        bridge.restoreFailure = "wireguard_handshake_timeout"
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        bridge.onSystemVpnStart()
        runBlocking { withTimeout(5_000) { bridge.systemJob()?.join() } }
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        assertEquals("secure_storage_read_failed", bridge.callbackFailure)
        assertTrue(quickTileFailureOpensApplication(bridge.callbackFailure))
    }

    @Test fun olderTileQueuedBehindTheFailingRestoreStillConnects() = fixture { bridge ->
        bridge.failOldRead = false
        bridge.restoreFailure = "wireguard_handshake_timeout"
        val restoreInside = CountDownLatch(1)
        val tileQueued = CountDownLatch(1)
        bridge.connectHook = {
            bridge.connectHook = {}
            restoreInside.countDown()
            requireSignal(tileQueued)
            Thread.sleep(200)
        }
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        bridge.onSystemVpnStart()
        val system = bridge.systemJob()
        requireSignal(restoreInside)
        bridge.beforeLock.set { tileQueued.countDown() }
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        runBlocking { withTimeout(5_000) { system?.join() } }
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(0, bridge.autoStops.get())
        assertTrue(bridge.resumeRegistry.blocks.isEmpty())
        assertTrue(bridge.published.toString(), bridge.noErrorOrRestoreAfterConnected())
        assertNull(bridge.callbackFailure)
    }

    // Final reaudit A4/B20: the restore fails in its own session check, inside its
    // mutex hold but before its engine body; the older tile queued behind it connects.
    @Test fun olderTileQueuedBehindARestoreFailingItsSessionCheckStillConnects() = fixture { bridge ->
        bridge.failOldRead = false
        val restoreInside = CountDownLatch(1)
        val tileQueued = CountDownLatch(1)
        bridge.sessionHook = {
            bridge.sessionHook = {}
            restoreInside.countDown()
            requireSignal(tileQueued)
            Thread.sleep(200)
            throw VpnNativeException("secure_storage_read_failed")
        }
        bridge.clickTile()
        requireSignal(bridge.oldReadEntered)
        bridge.onSystemVpnStart()
        val system = bridge.systemJob()
        requireSignal(restoreInside)
        bridge.beforeLock.set { tileQueued.countDown() }
        bridge.releaseOldRead.countDown()
        requireSignal(bridge.tileCompleted)
        runBlocking { withTimeout(5_000) { system?.join() } }
        assertEquals(VpnStatus.CONNECTED, bridge.status)
        assertEquals(1, bridge.connections.get())
        assertNull(bridge.callbackFailure)
    }

    // A08-vpn-bridge-02: a command that cancels an admitted restoration without
    // publishing must not leave CONNECTING/system_vpn_restoring behind.
    @Test fun restoreCancelledWithoutPublicationDoesNotStayConnecting() = fixture { bridge ->
        bridge.blockFirstIdentity = false
        bridge.openVpn.network = false
        bridge.onSystemVpnStart()
        val system = bridge.systemJob()
        requireSignal(bridge.openVpn.probed)
        assertEquals("system_vpn_restoring", bridge.lastCode)
        bridge.receivePrepare()
        runBlocking { withTimeout(5_000) { system?.join() } }
        bridge.openVpn.network = true
        Thread.sleep(300)
        assertNotEquals(bridge.published.toString(), VpnStatus.CONNECTING, bridge.status)
        assertNull(bridge.lastCode)
        assertEquals(0, bridge.connections.get())
    }
}
