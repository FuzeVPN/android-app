package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnNativeException
import kotlinx.coroutines.runBlocking
import org.junit.Assert.*
import org.junit.Test

class OpenVpnRevocationTest {
    private class Fixture {
        val target = RevokedOpenVpnIdentity("account-a", "device-a", "a".repeat(64))
        val markers = mutableMapOf<Pair<String, String>, String>()
        val calls = mutableListOf<String>()
        var failure: String? = null
        var stopped = true
        var matches = true
        var current = true
        fun step(name: String) {
            calls += name
            if (failure == name) throw IllegalStateException("fixture failure")
        }
        fun registry() = OpenVpnRevocation(
            { a, d -> markers[a to d] },
            { t -> step("persist"); markers[t.accountId to t.deviceId] = t.csrSha256 },
            { t -> step("finish"); markers.remove(t.accountId to t.deviceId) },
        )
        val registry = registry()
        suspend fun clean(registry: OpenVpnRevocation = this.registry, target: RevokedOpenVpnIdentity = this.target) = registry.clean(
            target, checkCurrent = { if (!current) throw VpnNativeException("session_operation_cancelled") },
            matchesCsr = { matches }, admitted = { calls += "cancel-recovery" },
            stop = { step("stop"); stopped }, clearIdentity = { step("identity"); matches = false },
            clearTile = { step("tile") },
        )
    }

    @Test fun matchingRevocationStopsBeforeDeletingAndClearsAdmissionFence() = runBlocking {
        val f = Fixture()
        val result = f.clean()
        assertTrue(result.complete)
        assertEquals(listOf("cancel-recovery", "persist", "stop", "tile", "identity", "finish"), f.calls)
        assertNull(f.registry.pending("account-a", "device-a"))
        f.registry.requireUsable("account-a", "device-a")
    }

    @Test fun staleCsrDoesNotCancelRecoveryStopOrDelete() = runBlocking {
        val f = Fixture()
        f.matches = false
        assertTrue(f.clean().stale)
        assertTrue(f.calls.isEmpty())
    }

    @Test fun duplicateAfterCompletionCannotDeleteReplacementIdentity() = runBlocking {
        val f = Fixture()
        assertTrue(f.clean().complete)
        f.calls.clear()
        assertTrue(f.clean().stale)
        assertTrue(f.calls.isEmpty())
    }

    @Test fun unconfirmedStopKeepsIdentityButInvalidatesTileUntilRetry() = runBlocking {
        val f = Fixture()
        f.stopped = false
        val result = f.clean()
        assertFalse(result.complete)
        assertTrue(result.tileCleared)
        assertEquals("openvpn_stop_timeout", result.stopError)
        assertFalse(f.calls.contains("identity"))
        assertThrows(VpnNativeException::class.java) { f.registry.requireUsable("account-a", "device-a") }
        f.stopped = true
        assertTrue(f.clean().complete)
    }

    @Test fun persistenceFailureStillStopsAndClearsTileButCannotClaimCleanup() = runBlocking {
        val f = Fixture()
        f.failure = "persist"
        val result = f.clean()
        assertTrue(result.tunnelStopped)
        assertTrue(result.tileCleared)
        assertFalse(result.identityCleared)
        assertFalse(result.complete)
        assertTrue(f.registry.isBlocked("account-a", "device-a"))
        f.failure = null
        assertTrue(f.clean().complete)
    }

    @Test fun partialDeletionCanResumeAfterProcessRecreationWithoutCsr() = runBlocking {
        val f = Fixture()
        f.failure = "identity"
        assertFalse(f.clean().complete)
        f.matches = false // The first deletion already removed the encrypted CSR.
        f.failure = null
        val recreated = f.registry()
        assertNotNull(recreated.pending("account-a", "device-a"))
        assertTrue(f.clean(recreated).complete)
    }

    @Test fun tileFailurePreservesMarkerAndRetryDoesNotDeleteIdentityTwice() = runBlocking {
        val f = Fixture()
        f.failure = "tile"
        val result = f.clean()
        assertTrue(result.identityCleared)
        assertFalse(result.complete)
        f.failure = null
        assertTrue(f.clean().complete)
        assertEquals(1, f.calls.count { it == "identity" })
    }

    @Test fun finalMarkerFailureCannotUnlockEnrollmentPrematurely() = runBlocking {
        val f = Fixture()
        f.failure = "finish"
        assertFalse(f.clean().complete)
        assertTrue(f.registry.isBlocked("account-a", "device-a"))
        f.failure = null
        assertTrue(f.clean().complete)
    }

    @Test fun anotherAccountDeviceOrCsrCannotConsumePendingCleanup() = runBlocking {
        val f = Fixture()
        f.stopped = false
        f.clean()
        f.registry.requireUsable("account-b", "device-a")
        f.registry.requireUsable("account-a", "device-b")
        f.calls.clear()
        assertTrue(f.clean(target = f.target.copy(csrSha256 = "b".repeat(64))).stale)
        assertTrue(f.calls.isEmpty())
        assertNotNull(f.registry.pending("account-a", "device-a"))
    }

    @Test fun invalidSessionDoesNotWriteStopOrErase() = runBlocking {
        val f = Fixture()
        f.current = false
        try { f.clean(); fail("stale session accepted") } catch (_: VpnNativeException) { }
        assertTrue(f.calls.isEmpty())
    }

    @Test fun sessionReplacementDuringStopCannotDeleteOrPublishForNewSession() = runBlocking {
        val f = Fixture()
        val publications = mutableListOf<OpenVpnRevocationState>()
        try {
            f.registry.clean(f.target,
                checkCurrent = { if (!f.current) throw VpnNativeException("session_operation_cancelled") },
                matchesCsr = { true }, admitted = {},
                stop = { f.current = false; true },
                clearIdentity = { fail("identity deleted after session replacement") },
                clearTile = { fail("tile cleared after session replacement") },
                publish = { publications += it },
            )
            fail("old session accepted")
        } catch (_: VpnNativeException) { }
        assertEquals(1, publications.size)
        assertNotNull(f.registry.pending("account-a", "device-a"))
        assertFalse(f.registry.pending("account-a", "device-a")!!.inProgress)
    }

    @Test fun unreadableMarkerNeverBecomesAnAbsentRevocation() {
        val f = Fixture()
        f.markers["account-a" to "device-a"] = "malformed"
        repeat(2) {
            assertThrows(VpnNativeException::class.java) { f.registry.requireUsable("account-a", "device-a") }
            assertTrue(f.registry.isBlocked("account-a", "device-a"))
        }
    }
}
