package com.fuzevpn.android

import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.launch
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.test.runCurrent
import kotlinx.coroutines.CompletableDeferred
import com.fuzevpn.android.openvpn.OpenVpnRecoveryAttempt
import org.junit.Assert.*
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class SessionLifecycleTest {
    @Test fun refusedSessionCauseSurvivesCleanupFailureAndActivityRetry() {
        val gate = SessionLifecycle()
        gate.beginEnd(expired = true)
        gate.finish(SessionTermination(false, true, "openvpn_stop_timeout"))
        val snapshot = VpnState(sessionTermination = gate.termination).toChannelMap()
        assertEquals(true, (snapshot["session_termination"] as Map<*, *>)["session_expired"])
        gate.beginEnd()
        val confirmed = gate.finish(SessionTermination(true, true))
        assertTrue(confirmed.sessionExpired)
        gate.activate(gate.ticket()) { }
        assertNull(gate.termination)
    }
    // A01-auth-02: a pending session is never activated, so the completed
    // expiry stays in memory when the user then signs out voluntarily.
    @Test fun completedExpiryDoesNotTurnTheNextVoluntaryLogoutIntoAnExpiry() {
        val gate = SessionLifecycle()
        gate.beginEnd(expired = true)
        assertTrue(gate.finish(SessionTermination(true, true)).sessionExpired)
        gate.beginEnd(expired = false)
        assertFalse(gate.termination!!.sessionExpired)
        // The bridge's purge reads revokeGuestRecovery: a voluntary logout disables guest resume.
        assertTrue(gate.termination!!.revokeGuestRecovery)
        val confirmed = gate.finish(SessionTermination(true, true))
        assertTrue(confirmed.revokeGuestRecovery)
        assertFalse(confirmed.sessionExpired)
        assertEquals(false, confirmed.toMap()["session_expired"])
    }
    @Test fun expiryJoinsAnUnfinishedEndButNeverOutlivesACompletedOne() {
        val gate = SessionLifecycle()
        gate.beginEnd(expired = false)
        gate.beginEnd(expired = true)
        assertTrue(gate.termination!!.sessionExpired)
        gate.beginEnd(expired = false)
        assertTrue(gate.termination!!.sessionExpired)
        gate.finish(SessionTermination(true, false, storageError = "secure_storage_write_failed"))
        gate.beginEnd(expired = false)
        assertTrue("An unfinished expiry cleanup keeps its cause", gate.termination!!.sessionExpired)
        assertTrue(gate.finish(SessionTermination(true, true)).sessionExpired)
        gate.beginEnd(expired = false)
        assertFalse(gate.termination!!.sessionExpired)
        gate.finish(SessionTermination(true, true))
        gate.beginEnd(expired = true)
        assertTrue(gate.termination!!.sessionExpired)
    }
    // P1 of the lot S review (root decision of 29/10): the causes of one end
    // merge. An expiry is reported when any request said so; automatic guest
    // recovery is revoked when any request was voluntary, across retries too.
    @Test fun endCausesMergeWithinOneEnd() {
        for ((causes, revoke, expired) in listOf(
            Triple(listOf(SessionEndCause.VOLUNTARY), true, false),
            Triple(listOf(SessionEndCause.EXPIRED), false, true),
            Triple(listOf(SessionEndCause.ABANDONED), false, false),
            Triple(listOf(SessionEndCause.VOLUNTARY, SessionEndCause.EXPIRED), true, true),
            Triple(listOf(SessionEndCause.EXPIRED, SessionEndCause.VOLUNTARY), true, true),
            Triple(listOf(SessionEndCause.ABANDONED, SessionEndCause.VOLUNTARY), true, false),
            Triple(listOf(SessionEndCause.EXPIRED, SessionEndCause.ABANDONED), false, true),
        )) {
            val gate = SessionLifecycle()
            causes.forEach { gate.beginEnd(it) }
            val confirmed = gate.finish(SessionTermination(true, true))
            assertEquals("$causes", revoke, confirmed.revokeGuestRecovery)
            assertEquals("$causes", expired, confirmed.sessionExpired)
            assertEquals("$causes", expired, confirmed.toMap()["session_expired"])
            assertFalse("$causes", confirmed.toMap().containsKey("revoke_guest_recovery"))
        }
        val gate = SessionLifecycle()
        gate.beginEnd(SessionEndCause.ABANDONED)
        gate.finish(SessionTermination(true, false, storageError = "secure_storage_write_failed"))
        gate.beginEnd(SessionEndCause.VOLUNTARY)
        assertTrue("a voluntary retry of an unfinished end revokes", gate.termination!!.revokeGuestRecovery)
        gate.finish(SessionTermination(true, true))
        gate.beginEnd(SessionEndCause.ABANDONED)
        assertFalse("a completed voluntary end does not outlive its session", gate.termination!!.revokeGuestRecovery)
    }

    @Test fun clearSessionReasonIsReadStrictlyWithTheLegacyFlagAsFallback() {
        assertEquals(SessionEndCause.VOLUNTARY, SessionEndCause.of(null))
        assertEquals(SessionEndCause.VOLUNTARY, SessionEndCause.of(emptyMap<String, Any?>()))
        assertEquals(SessionEndCause.EXPIRED, SessionEndCause.of(mapOf("session_expired" to true)))
        assertEquals(SessionEndCause.VOLUNTARY, SessionEndCause.of(mapOf("reason" to null, "session_expired" to false)))
        assertEquals(SessionEndCause.ABANDONED, SessionEndCause.of(mapOf("reason" to "abandoned", "session_expired" to true)))
        assertEquals(SessionEndCause.VOLUNTARY, SessionEndCause.of(mapOf("reason" to "voluntary", "session_expired" to true)))
        assertEquals(SessionEndCause.EXPIRED, SessionEndCause.of(mapOf("reason" to "expired")))
        assertNull(SessionEndCause.of(mapOf("reason" to "logout")))
        assertNull(SessionEndCause.of(mapOf("reason" to 42)))
        assertNull(SessionEndCause.of(mapOf("reason" to "")))
    }

    @Test fun queuedTunnelCommandsAndPublicationsAreRejectedForBothProtocols() = runTest {
        for (protocol in VpnProtocol.entries) {
            val gate = SessionLifecycle()
            val old = gate.ticket()
            val release = CompletableDeferred<Unit>()
            val queued = launch {
                release.await()
                assertThrows(VpnNativeException::class.java) {
                    gate.current(old) { fail("Old $protocol start/publication admitted") }
                }
            }
            gate.beginEnd()
            gate.finish(SessionTermination(true, true))
            gate.activate(gate.ticket()) { }
            release.complete(Unit)
            queued.join()
        }
    }

    @Test fun sessionEndCancelsTheValidatedOpenVpnRecoveryDuringNetworkWait() = runTest {
        val gate = SessionLifecycle()
        val ticket = gate.ticket()
        var stopped = 0
        var restarted = false
        val recovery = launch {
            OpenVpnRecoveryAttempt().run(true, "openvpn_reconnect_required",
                { gate.isCurrent(ticket) }, { stopped++; true }, { false }, { restarted = true })
        }
        runCurrent()
        gate.beginEnd()
        recovery.cancelAndJoin()
        val ending = endSessionAttempt({ stopped++; true }, {})
        gate.finish(ending)
        assertTrue(ending.complete)
        assertEquals(2, stopped)
        assertFalse(restarted)
        assertFalse(gate.isCurrent(ticket))
    }

    @Test fun sessionErasureSelectionKeepsVpnIdentitiesAndAccountDeviceRecords() {
        val scope = SecureKeystoreStore.accountScope("fixture-account")
        assertTrue(SecureStorageKeyPolicy.isSessionSlot(scope, "fuzevpn.session.current"))
        assertTrue(SecureStorageKeyPolicy.isSessionSlot("global", "fuzevpn.session.active_user"))
        assertTrue(SecureStorageKeyPolicy.isSessionSlot("global", "fuzevpn.session.pending"))
        assertTrue(SecureStorageKeyPolicy.isSessionSlot("global", "fuzevpn.vpn.quick_tile.last_validated_profile"))
        for (key in listOf("openvpn.identity.key", "openvpn.profile", "wireguard.private_key",
            "fuzevpn.device.current", "fuzevpn.device.location_migration.fixture")) {
            assertFalse(SecureStorageKeyPolicy.isSessionSlot(scope, key))
        }
    }
    @Test fun staleCommandsCannotRunAfterLogoutOrNewLogin() {
        val gate = SessionLifecycle()
        val old = gate.ticket()
        gate.beginEnd()
        assertFalse(gate.isCurrent(old))
        assertThrows(VpnNativeException::class.java) { gate.mutate(old) { fail("Stale write") } }
        gate.finish(SessionTermination(true, true))
        val current = gate.ticket()
        assertFalse(gate.isCurrent(current)) // Cleared session cannot use quick tile.
        gate.activate(current) { }
        assertTrue(gate.isCurrent(current))
        assertThrows(VpnNativeException::class.java) { gate.check(old) }
    }

    @Test fun incompleteShutdownBlocksAuthenticationAndSurvivesSnapshot() {
        val gate = SessionLifecycle()
        gate.beginEnd()
        gate.finish(SessionTermination(false, true, "openvpn_stop_timeout"))
        assertThrows(VpnNativeException::class.java) { gate.activate(gate.ticket()) { fail("Login admitted") } }
        val snapshot = VpnState(sessionTermination = gate.termination).toChannelMap()
        assertEquals(false, (snapshot["session_termination"] as Map<*, *>)["tunnel_stopped"])
        assertEquals(true, (snapshot["session_termination"] as Map<*, *>)["session_cleared"])
        gate.beginEnd()
        gate.finish(SessionTermination(true, true))
        gate.activate(gate.ticket()) { }
        assertNull(gate.termination)
    }

    @Test fun repeatedEndRequestsShareTheSameFenceWhileRunning() {
        val gate = SessionLifecycle()
        val first = gate.beginEnd()
        assertEquals(first, gate.beginEnd())
        assertTrue(gate.termination!!.inProgress)
        assertThrows(VpnNativeException::class.java) { gate.mutate(first) { fail("Write during cleanup") } }
    }

    @Test fun stopFailureStillErasesTokens() = runTest {
        var erased = false
        val result = endSessionAttempt(
            { throw VpnNativeException("openvpn_stop_timeout") }, { erased = true })
        assertTrue(erased)
        assertFalse(result.tunnelStopped)
        assertTrue(result.sessionCleared)
        assertEquals("openvpn_stop_timeout", result.stopError)
    }

    @Test fun storageFailurePreservesConfirmedStopAndBlocksLogin() = runTest {
        var stopped = false
        val result = endSessionAttempt({ stopped = true; true }, { throw IllegalStateException("secret") })
        assertTrue(stopped)
        assertTrue(result.tunnelStopped)
        assertFalse(result.sessionCleared)
        assertEquals("secure_storage_write_failed", result.storageError)
        assertFalse(result.toMap().toString().contains("secret"))
    }

    @Test fun bothFailuresRemainActionableAndRetryCanFinish() = runTest {
        val failed = endSessionAttempt({ false }, { throw IllegalStateException() })
        assertFalse(failed.complete)
        assertNotNull(failed.stopError)
        assertNotNull(failed.storageError)
        assertTrue(endSessionAttempt({ true }, { }).complete)
    }
}
