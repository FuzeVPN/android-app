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
