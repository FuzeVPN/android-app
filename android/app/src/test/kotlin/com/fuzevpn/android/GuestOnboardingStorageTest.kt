package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class GuestOnboardingStorageTest {
    @Test fun completionIsAccountScopedAndNeverWritesAuthorizationMaterial() {
        val memory = Memory()
        val storage = memory.storage()
        assertFalse(storage.readCompleted("guest-a"))
        storage.complete("guest-a")
        assertTrue(storage.readCompleted("guest-a"))
        assertFalse(storage.readCompleted("guest-b"))
        storage.complete("guest-a")
        val slot = SecureStorageKeyPolicy.guestOnboardingCompleted("guest-a")
        assertEquals(SecureKeystoreStore.accountScope("guest-a"), slot.scope)
        assertEquals("fuzevpn.preference.guest.onboarding_completed", slot.key)
        assertEquals(mapOf(slot to "true"), memory.values)
        assertEquals(listOf(slot to "true", slot to "true"), memory.writes)
        assertFalse(SecureStorageKeyPolicy.isSessionSlot(slot.scope, slot.key))
    }

    @Test fun absentOrUnrecognizedHistoryNeverSkipsWelcome() {
        val memory = Memory()
        val storage = memory.storage()
        val slot = SecureStorageKeyPolicy.guestOnboardingCompleted("guest-a")
        for (value in listOf("", "false", "TRUE", "1", " true ", "yes", "corrupt")) {
            memory.values[slot] = value
            assertFalse(storage.readCompleted("guest-a"))
        }
        memory.values.remove(slot)
        assertFalse(storage.readCompleted("guest-a"))
        assertTrue(memory.writes.isEmpty())
    }

    @Test fun sessionErasureKeepsHistoryAcrossExpirationLogoutAndNewStore() {
        val memory = Memory()
        val storage = memory.storage()
        storage.complete("guest-a")
        val history = SecureStorageKeyPolicy.guestOnboardingCompleted("guest-a")
        val tokens = listOf(SecureStorageKeyPolicy.pendingSession(),
            SecureStorageKeyPolicy.accountSession("guest-a"),
            SecureStorageKeyPolicy.activeUser(), SecureStorageKeyPolicy.systemVpnResume())
        for (expired in listOf(true, false)) {
            tokens.forEach { memory.values[it] = "session-fixture" }
            // Same slot selection used by SecureKeystoreStore.clearSessionMaterial.
            memory.values.keys.removeAll { SecureStorageKeyPolicy.isSessionSlot(it.scope, it.key) }
            if (!expired) memory.values[SecureStorageKeyPolicy.guestAutoResume()] = "false"
            assertEquals("true", memory.values[history])
            assertTrue(tokens.none(memory.values::containsKey))
            assertTrue(memory.storage().readCompleted("guest-a"))
            assertFalse(memory.storage().readCompleted("guest-b"))
        }
    }

    @Test fun invalidIdentifiersDoNotTouchStorage() {
        val memory = Memory()
        val storage = memory.storage()
        for (account in listOf("", " ", "guest/a", "guest-a\n", "guest-a\u0000", "invité", "a".repeat(129))) {
            val readError = assertThrows(VpnNativeException::class.java) { storage.readCompleted(account) }
            assertEquals("invalid_account_id", readError.code)
            val writeError = assertThrows(VpnNativeException::class.java) { storage.complete(account) }
            assertEquals("invalid_account_id", writeError.code)
        }
        assertTrue(memory.values.isEmpty())
        assertTrue(memory.writes.isEmpty())
        assertTrue(memory.reads.isEmpty())
    }

    @Test fun failedDurableWriteDoesNotChangeHistoryOrHideTheError() {
        val memory = Memory()
        val storage = GuestOnboardingStorage(read = { memory.values[it] },
            write = { _, _ -> throw SecureStorageException("secure_storage_write_failed") })
        val error = assertThrows(SecureStorageException::class.java) { storage.complete("guest-a") }
        assertEquals("secure_storage_write_failed", error.code)
        assertFalse(storage.readCompleted("guest-a"))
        assertTrue(memory.values.isEmpty())
    }

    private class Memory {
        val values = mutableMapOf<SecureStorageSlot, String>()
        val writes = mutableListOf<Pair<SecureStorageSlot, String>>()
        val reads = mutableListOf<SecureStorageSlot>()
        fun storage() = GuestOnboardingStorage(read = { reads.add(it); values[it] }, write = { slot, value ->
            writes.add(slot to value)
            values[slot] = value
        })
    }
}
