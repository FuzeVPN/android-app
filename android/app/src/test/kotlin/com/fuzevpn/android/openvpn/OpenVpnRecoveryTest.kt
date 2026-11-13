package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnNativeException
import com.fuzevpn.android.VpnStatus
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.async
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.flow.take
import kotlinx.coroutines.flow.toList
import kotlinx.coroutines.launch
import kotlinx.coroutines.test.advanceTimeBy
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.currentTime
import kotlinx.coroutines.test.runCurrent
import kotlinx.coroutines.test.runTest
import org.junit.Assert.*
import org.junit.Test
import java.time.Instant
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

@OptIn(ExperimentalCoroutinesApi::class)
class OpenVpnRecoveryTest {
    @Test fun commandCancellationWakesStartupWithoutWaitingForAnInFlightPkiCallback() = runTest {
        val events = OpenVpnSessionEvents()
        val generation = events.begin()
        val waiting = events.firstOutcome(generation)
        val signing = CountDownLatch(1)
        val releaseSigning = CountDownLatch(1)
        val callback = Thread {
            events.callback(generation, false) {
                signing.countDown()
                assertTrue(releaseSigning.await(2, TimeUnit.SECONDS))
                true
            }
        }.apply { isDaemon = true; start() }
        try {
            assertTrue(signing.await(2, TimeUnit.SECONDS))
            // The monitor is held by signing. Cancellation must still complete here.
            events.cancelPendingConnection()
            assertTrue(waiting.isCompleted)
            assertEquals("session_operation_cancelled", waiting.await().messageCode())
        } finally {
            releaseSigning.countDown()
            callback.join(2_000)
        }
        assertFalse(callback.isAlive)
        assertEquals(-1, events.callback(generation, -1) { fail("TUN created after cancellation"); 0 })
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        assertFalse(events.confirmConnected(generation) { fail("Cancelled startup published protection") })
        events.requestStop()
        events.finish()
        val fresh = events.begin()
        assertFalse(events.firstOutcome(fresh).isCompleted)
        assertEquals(7, events.callback(fresh, -1) { 7 })
    }

    @Test fun permissionRevocationDuringStartupCannotPublishConnected() {
        val events = OpenVpnSessionEvents()
        val generation = events.begin()
        events.interrupt("tun_permission_revoked", requireProof = false)
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        assertFalse(events.confirmConnected(generation) { fail("Revoked permission published protection") })
        assertEquals("tun_permission_revoked", events.failureCode)
        assertEquals(-1, events.callback(generation, -1) { fail("TUN created after revocation"); 0 })
    }

    @Test fun onlyAnExplicitRequestRearmsRecovery() {
        val policy = OpenVpnRecoveryPolicy()
        policy.newRequest()
        assertNull(policy.claim(1)) // No initial native proof.
        policy.connected(1)
        assertNull(policy.claim(2)) // Stale or unrelated session.
        val ticket = policy.claim(1)!!
        assertTrue(policy.isCurrent(ticket))
        assertNull(policy.claim(1)) // Duplicate interruption.
        policy.connected(2) // Automatic recovery succeeded.
        assertNull(policy.claim(2)) // Second interruption stays terminal.
        policy.newRequest()
        policy.connected(3)
        assertNotNull(policy.claim(3))
    }

    @Test fun cancellationInvalidatesTheAccountDeviceLocationRequest() {
        val policy = OpenVpnRecoveryPolicy()
        val request = policy.newRequest()
        policy.connected(1)
        policy.cancel()
        assertFalse(policy.isCurrent(request))
        assertNull(policy.claim(1))
    }

    @Test fun restoredConsumedBudgetDoesNotRearmRecovery() {
        val policy = OpenVpnRecoveryPolicy()
        val request = policy.newRequest(recoveryConsumed = true)
        policy.connected(7)
        assertTrue(policy.isCurrent(request))
        assertNull(policy.claim(7))
    }

    @Test fun networkChangeIsFollowedOncePerProvenSessionAndKeepsTheFailureRetry() {
        val policy = OpenVpnRecoveryPolicy()
        val request = policy.newRequest()
        assertFalse(policy.networkLost(1)) // No native proof yet.
        assertNull(policy.claimNetworkChange(1))
        policy.connected(1)
        assertNull(policy.claimNetworkChange(1)) // No OS loss for this session.
        assertFalse(policy.networkLost(2)) // Stale or unrelated session.
        assertNull(policy.claimNetworkChange(2))
        assertTrue(policy.networkLost(1))
        assertEquals(request, policy.claimNetworkChange(1))
        assertTrue(policy.networkLost(1)) // A second callback for the same session...
        assertNull(policy.claimNetworkChange(1)) // ...claims nothing more.
        policy.connected(2) // The network recovery was proven.
        assertNull(policy.claimNetworkChange(2))
        assertTrue(policy.networkLost(2))
        assertEquals(request, policy.claimNetworkChange(2))
        assertNull(policy.claimNetworkChange(2))
        assertEquals(request, policy.claim(2)) // The failure retry was never spent.
        assertNull(policy.claim(2))
        assertTrue(policy.isCurrent(request))
    }

    @Test fun aRestoredConsumedBudgetStillFollowsANetworkChange() {
        val policy = OpenVpnRecoveryPolicy()
        val request = policy.newRequest(recoveryConsumed = true)
        policy.connected(7)
        assertTrue(policy.networkLost(7))
        assertEquals(request, policy.claimNetworkChange(7))
        policy.connected(8)
        assertNull(policy.claim(8))
    }

    @Test fun cancellationRefusesNetworkLossAndClaim() {
        val policy = OpenVpnRecoveryPolicy()
        policy.newRequest()
        policy.connected(1)
        assertTrue(policy.networkLost(1))
        policy.cancel()
        assertFalse(policy.networkLost(1))
        assertNull(policy.claimNetworkChange(1))
        assertNull(policy.claim(1))
        // A new request starts without the cancelled session's loss.
        policy.newRequest()
        policy.connected(1)
        assertNull(policy.claimNetworkChange(1))
    }

    @Test fun rapidControlEventsAreOrderedAndCannotRestoreOldProof() = runTest {
        val events = OpenVpnSessionEvents()
        val generation = events.begin()
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        events.interrupt("openvpn_reconnect_required")
        assertFalse(events.confirmConnected(generation) { fail("Interrupted proof was published") })
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        assertFalse(events.snapshot.isConnected())
        events.requestStop()
        events.finish()
        val received = events.flow.take(5).toList()
        assertEquals(listOf(VpnStatus.CONNECTING, VpnStatus.CONNECTED, VpnStatus.ERROR,
            VpnStatus.DISCONNECTING, VpnStatus.IDLE), received.map { it.state.toVpnStatus() })
        assertEquals("openvpn_reconnect_required", events.failureCode)
    }

    @Test fun staleStatesTunAndIdentityCallbacksAreRejected() = runTest {
        val events = OpenVpnSessionEvents()
        val old = events.begin()
        events.requestStop()
        events.finish()
        val fresh = events.begin()
        var operations = 0
        events.publish(old, OpenVpnNativeState.fromNative("connected", ""))
        events.publish(old, OpenVpnNativeState.error("tls_certificate_revoked"))
        assertEquals(-1, events.callback(old, -1) { ++operations })
        assertNull(events.callback<String?>(old, null) { operations++; "signature" })
        assertEquals(0, operations)
        assertNull(events.failureCode)
        assertFalse(events.firstOutcome(fresh).isCompleted)
        events.publish(fresh, OpenVpnNativeState.fromNative("connected", ""))
        assertFalse(events.confirmConnected(old) { fail("Old generation was published") })
        var published = false
        assertTrue(events.confirmConnected(fresh) { published = true })
        assertTrue(published)
        assertTrue(events.firstOutcome(fresh).await().isConnected())
        events.finish()
        events.publish(fresh, OpenVpnNativeState.fromNative("connected", ""))
        assertFalse(events.snapshot.isConnected())
    }

    @Test fun fatalCauseSurvivesTechnicalShutdownAndRecoverableDuplicates() {
        val events = OpenVpnSessionEvents()
        val id = events.begin()
        events.publish(id, OpenVpnNativeState.error("openvpn_reconnect_required"))
        events.publish(id, OpenVpnNativeState.error("tls_certificate_revoked"))
        events.requestStop()
        events.publish(id, OpenVpnNativeState.error("openvpn_reconnect_required"))
        events.finish()
        assertEquals("tls_certificate_revoked", events.failureCode)
    }

    // A recovery stops the interrupted session, then restarts. A restart refused before it began a
    // session (no usable network, an unreadable profile) publishes nothing into the finished one:
    // the bridge reads sessionFailure before the start's own code, and reported the stopped
    // session's openvpn_reconnect_required as the cause of the failed recovery.
    @Test fun aStartRefusedBeforeItsSessionDoesNotInheritTheFinishedSessionsFailure() = runTest {
        val events = OpenVpnSessionEvents()
        val generation = events.begin()
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        events.interrupt("openvpn_reconnect_required")
        events.requestStop()
        events.finish()
        // The recovery's stop still reads what interrupted that session.
        assertEquals("openvpn_reconnect_required", events.failureCode)

        events.startRequested()
        events.publish(events.generation, OpenVpnNativeState.error("network_unavailable"))
        assertNull(events.failureCode)
        assertEquals(generation, events.generation)
        // Nothing of the refusal reaches the consumer of the finished session.
        assertEquals(listOf(VpnStatus.CONNECTING, VpnStatus.CONNECTED, VpnStatus.ERROR,
            VpnStatus.DISCONNECTING, VpnStatus.IDLE), events.flow.take(5).toList().map { it.state.toVpnStatus() })
        events.begin()
        assertEquals(VpnStatus.CONNECTING, events.flow.take(1).toList().single().state.toVpnStatus())
    }

    @Test fun aStartRequestLeavesTheFailureOfASessionThatIsNotFinished() {
        val events = OpenVpnSessionEvents()
        events.startRequested()
        assertNull(events.failureCode)
        val generation = events.begin()
        events.publish(generation, OpenVpnNativeState.error("tls_certificate_revoked"))
        events.startRequested()
        assertEquals("tls_certificate_revoked", events.failureCode)
        events.requestStop()
        events.startRequested()
        assertEquals("tls_certificate_revoked", events.failureCode)
    }

    @Test fun beforeTheFirstSessionNoCallbackIsServedAndAnErrorClosesTheGate() {
        // Generation 0 has no gate of its own yet: only its callbacks are refused.
        OpenVpnSessionEvents().let { unstarted ->
            unstarted.publish(0L, OpenVpnNativeState.fromNative("connected", ""))
            assertTrue(unstarted.confirmConnected(0L) {})
        }
        val events = OpenVpnSessionEvents()
        assertEquals(-1, events.callback(0L, -1) { fail("No session began"); 0 })
        events.interrupt("openvpn_reconnect_required") // No proof to interrupt.
        assertNull(events.failureCode)
        events.interrupt("tun_permission_revoked", requireProof = false)
        assertEquals("tun_permission_revoked", events.failureCode)
        events.publish(0L, OpenVpnNativeState.fromNative("connected", ""))
        assertFalse(events.snapshot.isConnected())
        assertFalse(events.confirmConnected(0L) { fail("An interrupted gate published protection") })
    }

    @Test fun aStopRequestedAfterTheEndPublishesNothing() = runTest {
        val events = OpenVpnSessionEvents()
        val generation = events.begin()
        events.finish()
        events.requestStop()
        events.publish(generation, OpenVpnNativeState.error("tls_certificate_revoked"))
        events.interrupt("tun_permission_revoked", requireProof = false)
        assertNull(events.failureCode)
        assertEquals(VpnStatus.IDLE, events.snapshot.toVpnStatus())
        val fresh = events.begin()
        assertEquals(listOf(generation to VpnStatus.CONNECTING, generation to VpnStatus.IDLE, fresh to VpnStatus.CONNECTING),
            events.flow.take(3).toList().map { it.generation to it.state.toVpnStatus() })
    }

    @Test fun anInterruptedSessionStillStopsAndIgnoresLaterInterruptions() = runTest {
        val events = OpenVpnSessionEvents()
        val generation = events.begin()
        events.publish(generation, OpenVpnNativeState.error("openvpn_reconnect_required"))
        // Interrupted, not stopping: a revoked permission is still published and becomes the cause.
        events.interrupt("tun_permission_revoked", requireProof = false)
        assertEquals("tun_permission_revoked", events.failureCode)
        events.requestStop()
        events.interrupt("vpn_host_destroyed", requireProof = false)
        assertEquals(-1, events.callback(generation, -1) { fail("Callback served while stopping"); 0 })
        events.publish(generation, OpenVpnNativeState.fromNative("connected", ""))
        events.finish()
        assertEquals(listOf(VpnStatus.CONNECTING, VpnStatus.ERROR, VpnStatus.ERROR, VpnStatus.DISCONNECTING, VpnStatus.IDLE),
            events.flow.take(5).toList().map { it.state.toVpnStatus() })
        assertEquals("tun_permission_revoked", events.failureCode)
    }

    @Test fun networkReturnWaitsTwoSecondsAndStopsBeforeRestart() = runTest {
        val order = mutableListOf<String>()
        var network = false
        val job = launch {
            OpenVpnRecoveryAttempt().run(true, "unused", { true },
                { order += "stopped"; true }, { network }, { order += "restart" })
        }
        runCurrent()
        assertEquals(listOf("stopped"), order)
        advanceTimeBy(1_999)
        network = true
        runCurrent()
        assertEquals(listOf("stopped"), order)
        advanceUntilIdle()
        job.join()
        assertEquals(2_000L, currentTime)
        assertEquals(listOf("stopped", "restart"), order)
    }

    @Test fun noNetworkExpiresAfterThirtySecondsWithoutStarting() = runTest {
        val result = async { runCatching {
            OpenVpnRecoveryAttempt().run(true, "unused", { true }, { true }, { false },
                { fail("Must not start without a usable network") })
        }.exceptionOrNull() }
        advanceUntilIdle()
        assertEquals(32_000L, currentTime)
        assertEquals("network_unavailable", (result.await() as VpnNativeException).code)
    }

    @Test fun cancellationDuringDelayAndNetworkWaitCannotRestart() = runTest {
        for (elapsed in listOf(1_000L, 5_000L)) {
            var network = false
            val job = launch {
                OpenVpnRecoveryAttempt().run(true, "unused", { true }, { true }, { network },
                    { fail("Cancelled request restarted") })
            }
            advanceTimeBy(elapsed)
            job.cancelAndJoin()
            network = true
            advanceUntilIdle()
        }
    }

    @Test fun replacedRequestAndUnconfirmedStopCannotPrepareAnotherTunnel() = runTest {
        val stopped = runCatching {
            OpenVpnRecoveryAttempt().run(true, "unused", { true }, { false }, { true },
                { fail("A second tunnel must not be created") })
        }.exceptionOrNull() as VpnNativeException
        assertEquals("openvpn_stop_timeout", stopped.code)
        var current = true
        OpenVpnRecoveryAttempt().run(true, "unused", { current }, { current = false; true }, { true },
            { fail("A replaced request must not restart") })
    }

    @Test fun fatalAndSecondInterruptionsStopWithoutRecovery() = runTest {
        for (code in listOf("tls_certificate_revoked", "vpn_permission_denied", "openvpn_recovery_exhausted")) {
            var stopped = false
            val failure = runCatching {
                OpenVpnRecoveryAttempt().run(false, code, { true }, { stopped = true; true }, { true },
                    { fail("Terminal failures cannot restart") })
            }.exceptionOrNull() as VpnNativeException
            assertTrue(stopped)
            assertEquals(code, failure.code)
        }
        assertEquals(0L, currentTime)
    }

    @Test fun unusableCertificateNeverAuthorizesLocalRecovery() {
        assertNull(OpenVpnRecoveryAttempt.profileFailure("valid", false))
        for (status in listOf("expired", "expiring", "valid")) {
            assertEquals("openvpn_renewal_required", OpenVpnRecoveryAttempt.profileFailure(status, true))
        }
        for (status in listOf("expired", "expiring")) {
            assertEquals("openvpn_renewal_required", OpenVpnRecoveryAttempt.profileFailure(status, false))
        }
        assertEquals("openvpn_profile_unavailable", OpenVpnRecoveryAttempt.profileFailure("missing", false))
    }

    // The bridge renews exactly the certificates a local restart refuses as due. A certificate
    // that is simply missing is never renewed: there is no profile to replace.
    @Test fun renewalIsDueExactlyWhenTheLocalRestartRefusesTheCertificateAsDue() {
        for (status in listOf("valid", "expiring", "expired", "missing")) for (pending in listOf(false, true)) {
            assertEquals("$status pending=$pending",
                OpenVpnRecoveryAttempt.profileFailure(status, pending) == "openvpn_renewal_required",
                OpenVpnCertificateStatus(status, null, pending).renewalDue)
        }
        assertFalse(OpenVpnCertificateStatus("valid", null, false).renewalDue)
        assertFalse(OpenVpnCertificateStatus("missing", null, false).renewalDue)
    }

    // One rule for the reported status, the local restart's refusals and the bridge's renewal.
    @Test fun theCertificateLifetimeNamesTheReportedStatusAndDecidesTheRenewal() {
        val now = Instant.parse("2026-11-12T08:00:00Z")
        val window = 7L * 24L * 60L * 60L
        fun lifetime(secondsLeft: Long) = OpenVpnCertificateLifetime.at(now, now.plusSeconds(secondsLeft))
        assertEquals(OpenVpnCertificateLifetime.EXPIRED, lifetime(-1))
        assertEquals(OpenVpnCertificateLifetime.EXPIRED, lifetime(0))
        assertEquals(OpenVpnCertificateLifetime.EXPIRING, lifetime(1))
        assertEquals(OpenVpnCertificateLifetime.EXPIRING, lifetime(window))
        assertEquals(OpenVpnCertificateLifetime.VALID, lifetime(window + 1))
        assertEquals(listOf("expired", "expiring", "valid"), OpenVpnCertificateLifetime.entries.map { it.status })
        for (entry in OpenVpnCertificateLifetime.entries) {
            assertEquals(entry.name, entry != OpenVpnCertificateLifetime.VALID, entry.renewalDue)
            assertEquals(entry.name, entry.renewalDue, OpenVpnCertificateStatus(entry.status, null, false).renewalDue)
            assertEquals(entry.name, entry.renewalDue, OpenVpnCertificateLifetime.renewalDue(entry.status, false))
            assertTrue(entry.name, OpenVpnCertificateLifetime.renewalDue(entry.status, true))
        }
        assertFalse(OpenVpnCertificateLifetime.renewalDue("missing", false))
        assertTrue(OpenVpnCertificateLifetime.renewalDue("missing", true))
    }
}
