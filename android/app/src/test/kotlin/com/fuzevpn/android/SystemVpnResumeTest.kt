package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test
import java.time.Instant

class SystemVpnResumeTest {
    private val now = Instant.parse("2026-09-09T12:00:00Z")
    private val identity = "a".repeat(64)
    private val otherIdentity = "b".repeat(64)

    @Test fun rejectsMalformedRecordAndDoesNotTreatItAsMissing() {
        val registry = registryWithRaw("{bad")
        val error = assertThrows(SystemVpnResumeException::class.java) { registry.snapshot() }
        assertEquals("system_vpn_resume_corrupt", error.code)
        assertNull(SystemVpnResumeRecord.decode("{}"))
        assertNull(validateSystemVpnSessionPayload("{}", now))
    }

    @Test fun reserveIsOneDurableClaimAcrossProcessRecreation() {
        val memory = Memory()
        val first = registry(memory)
        first.arm(profile(), session(), identity)
        val reserved = notNull(first.reserve(session(), identity))
        assertEquals(SystemVpnResumeStatus.RESERVED, reserved.status)

        val recreated = registry(memory)
        assertEquals(SystemVpnResumeStatus.RESERVED, recreated.snapshot()!!.status)
        assertNull(recreated.reserve(session(), identity))
    }

    @Test fun mismatchedSessionOrIdentityCannotClaimRecord() {
        val registry = registry()
        registry.arm(profile(), session(), identity)
        assertNull(registry.reserve(otherSession(), identity))
        assertNull(registry.reserve(session(), otherIdentity))
        assertEquals(SystemVpnResumeStatus.READY, registry.snapshot()!!.status)
    }

    @Test fun completionRequiresCurrentUnexpiredSessionAndRearmsFutureRestart() {
        val registry = registry()
        registry.arm(profile(), session(), identity)
        registry.reserve(session(), identity)
        assertNull(registry.complete(expiredSession(), identity))
        assertEquals(SystemVpnResumeStatus.RESERVED, registry.snapshot()!!.status)
        val ready = notNull(registry.complete(session(), identity))
        assertEquals(SystemVpnResumeStatus.READY, ready.status)
        assertTrue(ready.isResumable)
    }

    @Test fun logoutBeforeAReservedStartCompletesCannotRearmIt() {
        val lifecycle = SessionLifecycle()
        val ticket = lifecycle.ticket()
        val registry = registry()
        registry.arm(profile(), session(), identity)
        registry.reserve(session(), identity)

        lifecycle.beginEnd(expired = true)
        registry.invalidate() // The independently committed tombstone survives a later erase failure.

        assertThrows(VpnNativeException::class.java) { lifecycle.check(ticket) }
        assertNull(registry.complete(session(), identity))
        assertNull(registry.snapshot())
    }

    @Test fun oldSessionResponseCannotCompleteANewExplicitSession() {
        val registry = registry()
        registry.arm(profile(), session(), identity)
        registry.reserve(session(), identity)

        // A new proven explicit connection replaces the old reservation.
        registry.arm(profile(), otherSession(), identity)

        assertNull(registry.complete(session(), identity))
        assertEquals(SystemVpnResumeStatus.READY, registry.snapshot()!!.status)
        assertNull(registry.reserve(session(), identity))
        assertNotNull(registry.reserve(otherSession(), identity))
    }

    @Test fun blockPersistsUntilANewExplicitArm() {
        val registry = registry()
        registry.arm(profile(), session(), identity)
        val blocked = notNull(registry.block("openvpn_profile_unavailable"))
        assertEquals(SystemVpnResumeStatus.BLOCKED, blocked.status)
        assertEquals("openvpn_profile_unavailable", blocked.errorCode)
        assertNull(registry.reserve(session(), identity))

        val armed = registry.arm(profile(), session(), identity)
        assertEquals(SystemVpnResumeStatus.READY, armed.status)
        assertFalse(armed.recoveryConsumed)
    }

    @Test fun openVpnRecoveryBudgetIsPersistedAndNeverResetByCompletion() {
        val registry = registry()
        registry.arm(openVpnProfile(), session(), identity)
        val consumed = notNull(registry.consumeRecovery(session(), identity))
        assertTrue(consumed.recoveryConsumed)
        assertNull(registry.consumeRecovery(session(), identity))
        registry.reserve(session(), identity)
        val completed = notNull(registry.complete(session(), identity))
        assertTrue(completed.recoveryConsumed)
    }

    @Test fun networkRecoveryAdmissionNeitherNeedsNorSpendsTheFailureBudget() {
        val memory = Memory()
        var writes = 0
        val registry = countedRegistry(memory) { writes += 1 }
        registry.arm(openVpnProfile(), session(), identity)
        assertFalse(notNull(registry.admitNetworkRecovery(session(), identity)).recoveryConsumed)
        notNull(registry.consumeRecovery(session(), identity))
        val raw = memory.value
        val before = writes
        val admitted = notNull(registry.admitNetworkRecovery(session(), identity))
        assertTrue(admitted.recoveryConsumed)
        assertEquals(raw, memory.value)
        assertEquals(before, writes)
        // A restored session (RESERVED) is admitted too, and still without a write.
        notNull(registry.reserve(session(), identity))
        val reserved = memory.value
        assertEquals(SystemVpnResumeStatus.RESERVED, notNull(registry.admitNetworkRecovery(session(), identity)).status)
        assertEquals(reserved, memory.value)
    }

    @Test fun networkRecoveryAdmissionRefusesBlockedInvalidatedOtherExpiredOrWireGuard() {
        val registry = registry()
        assertNull(registry.admitNetworkRecovery(session(), identity)) // No record.
        registry.arm(openVpnProfile(), session(), identity)
        assertNull(registry.admitNetworkRecovery(expiredSession(), identity))
        assertNull(registry.admitNetworkRecovery(otherSession(), identity))
        assertNull(registry.admitNetworkRecovery(session(), otherIdentity))
        registry.block("network_unavailable")
        assertNull(registry.admitNetworkRecovery(session(), identity))
        registry.arm(openVpnProfile(), session(), identity)
        registry.invalidate()
        assertNull(registry.admitNetworkRecovery(session(), identity))
        registry.arm(profile(), session(), identity)
        assertNull(registry.admitNetworkRecovery(session(), identity))
        registry.arm(openVpnProfile(), session(), identity)
        assertNotNull(registry.admitNetworkRecovery(session(), identity))
    }

    @Test fun invalidateWritesAnUnusableDurableRecord() {
        val memory = Memory()
        val registry = registry(memory)
        registry.arm(profile(), session(), identity)
        registry.invalidate()
        assertNull(registry.snapshot())
        assertNull(registry.reserve(session(), identity))

        val corrupt = Memory("{bad")
        registry(corrupt).invalidate()
        assertNotNull(corrupt.value)
        assertNull(registry(corrupt).snapshot())
    }

    @Test fun repeatedInvalidationInOneInstanceUsesItsConfirmedTombstone() {
        val memory = Memory()
        var writes = 0
        val registry = countedRegistry(memory) { writes += 1 }

        registry.invalidate()
        registry.invalidate()

        assertEquals(1, writes)
        assertNull(registry.snapshot())
    }

    @Test fun rearmingClearsConfirmedInvalidationBeforeTheNextInvalidation() {
        val memory = Memory()
        var writes = 0
        val registry = countedRegistry(memory) { writes += 1 }

        registry.invalidate()
        registry.arm(profile(), session(), identity)
        registry.invalidate()

        assertEquals(3, writes)
        assertNull(registry.snapshot())
    }

    @Test fun admissionsClearConfirmedInvalidationEvenWhenTheyDoNotWrite() {
        val memory = Memory()
        var writes = 0
        val registry = countedRegistry(memory) { writes += 1 }
        val external = registry(memory)

        fun replaceWithReady() = external.arm(profile(), session(), identity)

        registry.invalidate()
        assertNull(registry.reserve(session(), identity))
        replaceWithReady()
        registry.invalidate()

        assertNull(registry.complete(session(), identity))
        replaceWithReady()
        registry.invalidate()

        assertNull(registry.block("manual_stop"))
        replaceWithReady()
        registry.invalidate()

        assertNull(registry.consumeRecovery(session(), identity))
        replaceWithReady()
        registry.invalidate()

        assertNull(registry.admitNetworkRecovery(session(), identity))
        replaceWithReady()
        registry.invalidate()

        // One initial tombstone and one new tombstone after each admission.
        assertEquals(6, writes)
        assertNull(registry.snapshot())
    }

    @Test fun observingMissingOrCorruptStorageRevokesTheWriteAcknowledgement() {
        val memory = Memory()
        var writes = 0
        val registry = countedRegistry(memory) { writes += 1 }

        registry.invalidate()
        memory.value = null // External session-material cleanup: absent remains non-resumable.
        assertNull(registry.snapshot())
        registry.invalidate()

        memory.value = "{bad"
        val error = assertThrows(SystemVpnResumeException::class.java) { registry.snapshot() }
        assertEquals("system_vpn_resume_corrupt", error.code)
        registry.invalidate()

        assertEquals(3, writes)
        assertNull(registry.snapshot())
    }

    @Test fun recreatedRegistryDoesNotTrustAnotherInstancesAcknowledgement() {
        val memory = Memory()
        var writes = 0
        val first = countedRegistry(memory) { writes += 1 }
        first.invalidate()

        countedRegistry(memory) { writes += 1 }.invalidate()

        assertEquals(2, writes)
    }

    @Test fun failedInvalidationWriteNeverArmsTheSkip() {
        val memory = Memory()
        var attempts = 0
        var shouldFail = true
        val registry = SystemVpnResumeRegistry(
            readRaw = { memory.value },
            writeRaw = {
                attempts += 1
                if (shouldFail) throw IllegalStateException("write failed")
                memory.value = it
            },
            now = { now },
        )

        assertThrows(IllegalStateException::class.java) { registry.invalidate() }
        shouldFail = false
        registry.invalidate()
        registry.invalidate()

        assertEquals(2, attempts)
        assertNull(registry.snapshot())
    }

    @Test fun failedSnapshotReadRevokesTheWriteAcknowledgement() {
        val memory = Memory()
        var writes = 0
        var readFails = false
        val registry = SystemVpnResumeRegistry(
            readRaw = {
                if (readFails) throw IllegalStateException("read failed")
                memory.value
            },
            writeRaw = { value ->
                writes += 1
                memory.value = value
            },
            now = { now },
        )

        registry.invalidate()
        readFails = true
        assertThrows(IllegalStateException::class.java) { registry.snapshot() }
        readFails = false
        registry.invalidate()

        assertEquals(2, writes)
    }

    @Test fun storageFaultsPropagateWithoutFalseSuccess() {
        val error = assertThrows(IllegalStateException::class.java) {
            SystemVpnResumeRegistry(
                readRaw = { null },
                writeRaw = { throw IllegalStateException("write failed") },
                now = { now },
            ).arm(profile(), session(), identity)
        }
        assertEquals("write failed", error.message)
    }

    @Test fun guestRenewalRebasesOnlyTheSessionFingerprintAndKeepsTheProvenTunnelAndRecoveryBudget() {
        val memory = Memory()
        val registry = registry(memory)
        val proven = openVpnProfile()
        registry.arm(proven, session(), identity)
        registry.consumeRecovery(session(), identity)
        val previous = notNull(registry.snapshot())
        var durableCommits = 0
        assertTrue(registry.renewSession(session(), otherSession(), proven, identity) { encoded ->
            durableCommits++
            memory.value = encoded
        })
        val renewed = notNull(registry.snapshot())
        assertEquals(1, durableCommits)
        assertEquals(previous.profilePayload, renewed.profilePayload)
        assertEquals(previous.profileFingerprint, renewed.profileFingerprint)
        assertEquals(previous.identityFingerprint, renewed.identityFingerprint)
        assertTrue(renewed.recoveryConsumed)
        assertEquals(validateSystemVpnSessionPayload(otherSession(), now)!!.fingerprint, renewed.sessionFingerprint)
        assertNull(registry.reserve(session(), identity))
        assertNotNull(registry.reserve(otherSession(), identity))
    }

    @Test fun aRenewalWithoutMatchingNativeProofCannotArmAResume() {
        for ((proven, provenIdentity) in listOf(null to identity, profile() to null,
                profile() to otherIdentity, profile().copy(locationId = "frankfurt-02",
                    wireGuardRequest = profile().wireGuardRequest!!.copy(locationId = "frankfurt-02")) to identity,
                profile().copy(deviceId = "device-b", wireGuardRequest =
                    profile().wireGuardRequest!!.copy(deviceId = "device-b")) to identity,
                profile().copy(accountId = "account-b", wireGuardRequest =
                    profile().wireGuardRequest!!.copy(accountId = "account-b")) to identity,
                profile().copy(wireGuardRequest = profile().wireGuardRequest!!.copy(endpoint = "203.0.113.11:51820")) to identity)) {
            val memory = Memory()
            val registry = registry(memory)
            registry.arm(profile(), session(), identity)
            assertFalse(registry.renewSession(session(), otherSession(), proven, provenIdentity) { memory.value = it })
            assertNull(registry.snapshot())
            assertNull(registry.reserve(otherSession(), identity))
        }
    }

    @Test fun blockedReservedOrStaleSessionRecordsAreNotRearmedByTokenRenewal() {
        for (state in listOf("blocked", "reserved", "different-session", "invalidated")) {
            val memory = Memory()
            val registry = registry(memory)
            registry.arm(profile(), session(), identity)
            when (state) {
                "blocked" -> registry.block("manual_stop")
                "reserved" -> registry.reserve(session(), identity)
                "different-session" -> registry.arm(profile(), otherSession(), identity)
                "invalidated" -> registry.invalidate()
            }
            assertFalse(registry.renewSession(session(), otherSession(), profile(), identity) { memory.value = it })
            assertNull(registry.snapshot())
        }
    }

    @Test fun justExpiredPreviousTokenCanBeRebasedOnlyWithExactProvenProfileAndValidReplacement() {
        val memory = Memory()
        var clock = now
        val registry = SystemVpnResumeRegistry(readRaw = { memory.value },
            writeRaw = { memory.value = it }, now = { clock })
        val soonExpired = "{\"access_token\":\"token-old\",\"expires_at\":\"2026-09-09T12:00:01Z\"}"
        registry.arm(profile(), soonExpired, identity)
        clock = now.plusSeconds(2)
        assertTrue(registry.renewSession(soonExpired, otherSession(), profile(), identity) { memory.value = it })
        assertNotNull(registry.reserve(otherSession(), identity))
    }

    @Test fun failedAtomicSessionRenewalCannotInventADurableAcknowledgement() {
        val memory = Memory()
        val registry = registry(memory)
        registry.arm(profile(), session(), identity)
        val before = memory.value
        assertThrows(IllegalStateException::class.java) {
            registry.renewSession(session(), otherSession(), profile(), identity) {
                throw IllegalStateException("write failed")
            }
        }
        assertEquals(before, memory.value)
        assertEquals(validateSystemVpnSessionPayload(session(), now)!!.fingerprint, registry.snapshot()!!.sessionFingerprint)
    }

    @Test fun invalidReplacementSessionNeverInvokesTheDurableCommit() {
        val registry = registry()
        registry.arm(profile(), session(), identity)
        var committed = false
        for (replacement in listOf(expiredSession(), "{}", "{bad")) {
            assertThrows(SystemVpnResumeException::class.java) {
                registry.renewSession(session(), replacement, profile(), identity) { committed = true }
            }
        }
        assertFalse(committed)
        assertEquals(SystemVpnResumeStatus.READY, registry.snapshot()!!.status)
    }

    // Campaign 74018 (P2): a process death is followed by a restore only from a READY record.
    @Test fun processRestartIsKeptOnlyForAReadyRecord() {
        val memory = Memory()
        val registry = registry(memory)
        registry.arm(profile(), session(), identity)
        assertTrue(systemVpnResumeKeepsProcessRestart(memory.value))
        registry.reserve(session(), identity)
        assertFalse("an interrupted restore is never retried", systemVpnResumeKeepsProcessRestart(memory.value))
        registry.complete(session(), identity)
        assertTrue(systemVpnResumeKeepsProcessRestart(memory.value))
        registry.block("system_vpn_resume_failed")
        assertFalse(systemVpnResumeKeepsProcessRestart(memory.value))
        registry.arm(profile(), session(), identity)
        registry.invalidate()
        assertFalse("tombstone", systemVpnResumeKeepsProcessRestart(memory.value))
        assertFalse(systemVpnResumeKeepsProcessRestart(null))
        assertFalse(systemVpnResumeKeepsProcessRestart("{}"))
        assertFalse(systemVpnResumeKeepsProcessRestart("not json"))
    }

    @Test fun processRestartArmedTruthTable() {
        var armed = 0
        for (sdk in listOf(28, 29, 36)) for (patched in listOf(false, true)) for (holds in listOf(0, 1, 2))
            for (resumable in listOf(false, true)) for (alwaysOn in listOf(null, false, true)) {
                val expected = sdk >= 29 && patched && holds == 0 && resumable && alwaysOn == true
                assertEquals("$sdk $patched $holds $resumable $alwaysOn", expected,
                    processRestartArmed(sdk, patched, holds, resumable, alwaysOn))
                if (expected) armed += 1
            }
        assertEquals(2, armed)
    }

    private fun registryWithRaw(raw: String): SystemVpnResumeRegistry =
        SystemVpnResumeRegistry(readRaw = { raw }, writeRaw = { }, now = { now })

    private fun registry(memory: Memory = Memory()): SystemVpnResumeRegistry =
        SystemVpnResumeRegistry(readRaw = { memory.value }, writeRaw = { memory.value = it }, now = { now })

    private fun countedRegistry(memory: Memory, onWrite: () -> Unit): SystemVpnResumeRegistry =
        SystemVpnResumeRegistry(
            readRaw = { memory.value },
            writeRaw = { value ->
                onWrite()
                memory.value = value
            },
            now = { now },
        )

    private fun session() = "{\"access_token\":\"token-a\",\"expires_at\":\"2027-01-02T03:04:05Z\"}"
    private fun otherSession() = "{\"access_token\":\"token-b\",\"expires_at\":\"2027-01-02T03:04:05Z\"}"
    private fun expiredSession() = "{\"access_token\":\"token-a\",\"expires_at\":\"2020-01-02T03:04:05Z\"}"

    private fun profile(): QuickTileProfile = QuickTileProfile(
        protocol = VpnProtocol.WIREGUARD,
        accountId = "account-a",
        deviceId = "device-a",
        locationId = "frankfurt-01",
        locationName = "Frankfurt",
        wireGuardRequest = WireGuardRequest(
            accountId = "account-a",
            deviceId = "device-a",
            locationId = "frankfurt-01",
            locationName = "Frankfurt",
            address = "10.0.0.2/32",
            dns = listOf("1.1.1.1"),
            serverPublicKey = "server-key",
            endpoint = "203.0.113.10:51820",
            allowedIps = listOf("0.0.0.0/0"),
        ),
    )

    private fun openVpnProfile(): QuickTileProfile = QuickTileProfile(
        protocol = VpnProtocol.OPENVPN,
        accountId = "account-a",
        deviceId = "device-a",
        locationId = "frankfurt-01",
        locationName = "Frankfurt",
        openVpnNetwork = TunnelNetworkSpec.ipv4("10.8.0.2/32", listOf("0.0.0.0/0")),
    )

    private fun <T : Any> notNull(value: T?): T {
        assertNotNull(value)
        return value!!
    }

    private class Memory(var value: String? = null)
}
