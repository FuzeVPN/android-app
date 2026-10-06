package com.fuzevpn.android

import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class GooglePendingAuthStorageTest {
    private val ticket = "private-server-ticket-fixture"
    private val context = "private-browser-context-fixture"
    private fun payload() = JSONObject(mapOf(
        "version" to 1, "request_id" to "request-fixture", "purpose" to "claim",
        "stage" to "continuation", "ticket" to ticket, "context" to context,
        "expires_at" to "2099-01-01T00:00:00Z", "generation" to 1,
        "user_id" to "guest-fixture", "challenge_id" to "challenge-fixture",
    )).toString()

    @Test fun storesOneFixedEncryptedSlotWithoutTouchingVpnOrGuestMaterial() {
        val values = linkedMapOf<SecureStorageSlot, String>()
        val unrelated = SecureStorageSlot("account_fixture", "fuzevpn.session.current")
        values[unrelated] = "session-fixture"
        val writes = mutableListOf<Set<SecureStorageSlot>>()
        val store = GooglePendingAuthStorage(read = values::get, update = { added, deleted ->
            writes.add(added.keys + deleted)
            values.putAll(added)
            deleted.forEach(values::remove)
        })
        assertNull(store.read())
        store.write(payload())
        assertEquals(payload(), store.read())
        val slot = writes.single().single()
        assertEquals("global", slot.scope)
        assertEquals("fuzevpn.google.pending_authentication", slot.key)
        store.clear()
        assertNull(store.read())
        assertEquals("session-fixture", values[unrelated])
        assertEquals(setOf(slot), writes.last())
    }

    @Test fun rejectedProfileAndTokenFieldsNeverReachEncryptedStorage() {
        var commits = 0
        val store = GooglePendingAuthStorage(read = { null }, update = { _, _ -> commits++ })
        for (key in listOf("idToken", "id_token", "credential", "jwt", "email", "name", "nonce")) {
            val invalid = JSONObject(payload()).put(key, "secret-fixture").toString()
            val error = assertThrows(GoogleAuthException::class.java) { store.write(invalid) }
            assertEquals("invalid_pending_authentication", error.code)
            assertFalse(error.toString().contains("secret-fixture"))
        }
        assertEquals(0, commits)
    }

    @Test fun schemaAndContextAreStrictAndDoNotPermitNestedPersonalData() {
        val invalidPayloads = listOf(
            JSONObject(payload()).put("context", JSONObject(mapOf("email" to "person@example.test"))).toString(),
            JSONObject(payload()).put("version", "1").toString(),
            JSONObject(payload()).put("generation", 0).toString(),
            JSONObject(payload()).put("generation", 1.5).toString(),
            JSONObject(payload()).put("stage", "authenticated").toString(),
            JSONObject(payload()).put("purpose", "purchase").toString(),
            JSONObject(payload()).put("expires_at", "2026-10-05").toString(),
            JSONObject(payload()).put("ticket", "$ticket\n").toString(),
            JSONObject(payload()).put("user_id", JSONObject.NULL).toString(),
            JSONObject(payload()).also { it.remove("context") }.toString(),
        )
        for (invalid in invalidPayloads) assertThrows(GoogleAuthException::class.java) { GooglePendingAuthPolicy.validate(invalid) }
    }

    @Test fun boundsTheWholeUtf8PayloadAndIndividualSecrets() {
        assertThrows(GoogleAuthException::class.java) { GooglePendingAuthPolicy.validate(JSONObject(payload()).put("ticket", "t".repeat(8193)).toString()) }
        val oversized = " ".repeat(GooglePendingAuthPolicy.MAX_PAYLOAD_BYTES) + payload()
        assertTrue(oversized.toByteArray(Charsets.UTF_8).size > GooglePendingAuthPolicy.MAX_PAYLOAD_BYTES)
        assertThrows(GoogleAuthException::class.java) { GooglePendingAuthPolicy.validate(oversized) }
    }

    @Test fun corruptReadIsDistinctFromAbsenceAndDoesNotEraseTheRecoveryRecord() {
        var commits = 0
        val store = GooglePendingAuthStorage(read = { "{private-corrupt-fixture}" }, update = { _, _ -> commits++ })
        val error = assertThrows(GoogleAuthException::class.java) { store.read() }
        assertEquals("secure_storage_corrupt", error.code)
        assertFalse(error.toString().contains("private-corrupt-fixture"))
        assertEquals(0, commits)
    }

    @Test fun failedRotationKeepsThePreviousContinuationAndExpungesUnderlyingErrors() {
        val saved = payload()
        val store = GooglePendingAuthStorage(read = { saved }, update = { _, _ ->
            throw IllegalStateException("write failed for $ticket $context")
        })
        val replacement = JSONObject(payload()).put("ticket", "replacement-private-ticket").put("stage", "uncertain").toString()
        val error = assertThrows(GoogleAuthException::class.java) { store.write(replacement) }
        assertEquals("secure_storage_failed", error.code)
        assertFalse(error.toString().contains(ticket))
        assertEquals(payload(), saved)
        assertEquals(payload(), store.read())
    }

    @Test fun expiryIsInterpretedByTheControllerWithoutDeletingAValidUncertainRecord() {
        val old = JSONObject(payload()).put("expires_at", "2020-01-01T00:00:00Z").put("stage", "uncertain").toString()
        var commits = 0
        val store = GooglePendingAuthStorage(read = { old }, update = { _, _ -> commits++ })
        assertEquals(old, store.read())
        assertEquals(0, commits)
    }
}
