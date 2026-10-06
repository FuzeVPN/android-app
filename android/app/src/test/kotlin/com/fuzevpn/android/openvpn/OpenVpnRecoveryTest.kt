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

@OptIn(ExperimentalCoroutinesApi::class)
class OpenVpnRecoveryTest {
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
}
