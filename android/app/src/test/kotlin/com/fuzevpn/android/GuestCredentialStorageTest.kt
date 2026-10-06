package com.fuzevpn.android

import java.util.Base64
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class GuestCredentialStorageTest {
    private val credential = Base64.getUrlEncoder().withoutPadding().encodeToString(ByteArray(32) { it.toByte() })
    private val pending = Base64.getUrlEncoder().withoutPadding().encodeToString(ByteArray(32) { (it + 32).toByte() })

    @Test fun acceptsOnlyCanonicalUnpadded32ByteCredentials() {
        assertTrue(GuestCredentialPolicy.isValid(credential))
        // Last six-bit group contains only four data bits. Non-zero padding
        // bits must not create a second textual identity for the same secret.
        val nonCanonical = "A".repeat(42) + "B"
        for (value in listOf("", credential + "=", credential.dropLast(1),
                " $credential", "$credential\n", nonCanonical, "é".repeat(43))) {
            assertFalse(GuestCredentialPolicy.isValid(value))
            val error = assertThrows(VpnNativeException::class.java) { GuestCredentialPolicy.checked(value) }
            assertEquals("invalid_guest_credential", error.code)
            assertEquals("invalid_guest_credential", error.message)
        }
    }

    @Test fun pendingWriteCannotReplaceEstablishedCredentialAndPromotionIsOneCommit() {
        val memory = Memory()
        val store = memory.store()
        store.writeCredential(credential)
        store.writeAutoResume(true)
        memory.updates.clear()

        store.writeCredential(pending, pending = true)
        assertEquals(credential, store.readCredential())
        assertEquals(pending, store.readCredential(pending = true))
        assertTrue(store.readAutoResume())
        assertEquals(1, memory.updates.size)
        assertEquals(emptySet<SecureStorageSlot>(), memory.updates.single().second)

        memory.updates.clear()
        store.writeCredential(pending)
        assertEquals(pending, store.readCredential())
        assertNull(store.readCredential(pending = true))
        assertEquals(1, memory.updates.size)
        assertEquals(mapOf(SecureStorageKeyPolicy.guestCredential() to pending), memory.updates.single().first)
        assertEquals(setOf(SecureStorageKeyPolicy.pendingGuestCredential()), memory.updates.single().second)
    }

    @Test fun corruptRecoveryDataCannotBeMistakenForAnAbsentCredential() {
        val memory = Memory()
        memory.values[SecureStorageKeyPolicy.guestCredential()] = "not-a-secret"
        val error = assertThrows(SecureStorageException::class.java) { memory.store().readCredential() }
        assertEquals("secure_storage_corrupt", error.code)
        assertEquals("secure_storage_corrupt", error.message)
        assertTrue(memory.updates.isEmpty())
        assertEquals("not-a-secret", memory.values[SecureStorageKeyPolicy.guestCredential()])
    }

    @Test fun autoResumeRequiresExplicitBooleanStorageAndCanBeDisabledWithoutLosingRecovery() {
        val memory = Memory()
        val store = memory.store()
        assertFalse(store.readAutoResume())
        store.writeCredential(credential)
        store.writeAutoResume(true)
        assertTrue(store.readAutoResume())
        store.writeAutoResume(false)
        assertFalse(store.readAutoResume())
        assertEquals(credential, store.readCredential())
        for (invalid in listOf("TRUE", "1", " true ", "yes")) {
            memory.values[SecureStorageKeyPolicy.guestAutoResume()] = invalid
            assertThrows(SecureStorageException::class.java) { store.readAutoResume() }
        }
    }

    @Test fun expiredSessionCleanupDoesNotClassifyGuestRecoveryOrVpnIdentityAsTokens() {
        val guestSlots = listOf(SecureStorageKeyPolicy.guestCredential(),
            SecureStorageKeyPolicy.pendingGuestCredential(), SecureStorageKeyPolicy.guestAutoResume())
        val vpnIdentity = SecureStorageSlot(SecureKeystoreStore.accountScope("guest-a"), "wireguard.private_key")
        val sessionSlots = listOf(SecureStorageKeyPolicy.pendingSession(), SecureStorageKeyPolicy.activeUser(),
            SecureStorageKeyPolicy.accountSession("guest-a"), SecureStorageKeyPolicy.systemVpnResume())
        for (slot in guestSlots + vpnIdentity) {
            assertFalse(SecureStorageKeyPolicy.isSessionSlot(slot.scope, slot.key))
        }
        for (slot in sessionSlots) assertTrue(SecureStorageKeyPolicy.isSessionSlot(slot.scope, slot.key))
        assertEquals(3, guestSlots.toSet().size)
        assertTrue(guestSlots.all { it.scope == SecureKeystoreStore.GLOBAL_SCOPE })
    }

    @Test fun clearingRecoveryIsAtomicAndDoesNotEraseSessionDeviceOrVpnMaterial() {
        val memory = Memory()
        val store = memory.store()
        store.writeCredential(credential)
        store.writeCredential(pending, pending = true)
        store.writeAutoResume(true)
        val unrelated = mapOf(SecureStorageKeyPolicy.accountSession("guest-a") to "session-envelope",
            SecureStorageKeyPolicy.currentDevice("guest-a") to "device-a",
            SecureStorageSlot(SecureKeystoreStore.accountScope("guest-a"), "wireguard.private_key") to "native-key")
        memory.values.putAll(unrelated)
        memory.updates.clear()

        store.clear()
        assertEquals(1, memory.updates.size)
        assertEquals(unrelated, memory.values)
        assertNull(store.readCredential())
        assertNull(store.readCredential(pending = true))
        assertFalse(store.readAutoResume())
    }

    @Test fun failedDurablePromotionDoesNotReportSuccessOrDeletePendingRecovery() {
        val memory = Memory()
        memory.values[SecureStorageKeyPolicy.pendingGuestCredential()] = pending
        val store = GuestCredentialStorage(read = { memory.values[it] },
            update = { _, _ -> throw SecureStorageException("secure_storage_write_failed") })
        val error = assertThrows(SecureStorageException::class.java) { store.writeCredential(pending) }
        assertEquals("secure_storage_write_failed", error.code)
        assertNull(memory.values[SecureStorageKeyPolicy.guestCredential()])
        assertEquals(pending, store.readCredential(pending = true))
    }

    private class Memory {
        val values = mutableMapOf<SecureStorageSlot, String>()
        val updates = mutableListOf<Pair<Map<SecureStorageSlot, String>, Set<SecureStorageSlot>>>()
        fun store() = GuestCredentialStorage(read = { values[it] }, update = { added, removed ->
            updates.add(added to removed)
            removed.forEach(values::remove)
            values.putAll(added)
        })
    }
}
