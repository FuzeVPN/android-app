package com.fuzevpn.android

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import java.util.UUID
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotEquals
import org.junit.Assert.fail
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class SecureKeystoreStoreInstrumentedTest {
    private lateinit var context: Context
    private lateinit var store: SecureKeystoreStore
    private lateinit var firstScope: String
    private lateinit var secondScope: String

    @Before
    fun setUp() {
        context = ApplicationProvider.getApplicationContext()
        store = SecureKeystoreStore(context)
        firstScope = SecureKeystoreStore.accountScope("instrumentation-a-${UUID.randomUUID()}")
        secondScope = SecureKeystoreStore.accountScope("instrumentation-b-${UUID.randomUUID()}")
    }

    @After
    fun tearDown() {
        if (::store.isInitialized) {
            if (::firstScope.isInitialized) store.deleteScope(firstScope)
            if (::secondScope.isInitialized) store.deleteScope(secondScope)
        }
    }

    @Test
    fun encryptsRoundTripsAndIsolatesPerAccountScope() {
        val firstSecret = "test-token-${UUID.randomUUID()}"
        val secondSecret = "test-token-${UUID.randomUUID()}"
        val key = "session.current"

        store.write(firstScope, key, firstSecret)
        store.write(secondScope, key, secondSecret)

        assertEquals(firstSecret, store.read(firstScope, key))
        assertEquals(secondSecret, store.read(secondScope, key))
        assertNotEquals(firstSecret, store.read(secondScope, key))

        val rawValues = context.getSharedPreferences("fuzevpn.secure.v1", Context.MODE_PRIVATE)
            .all
            .values
            .filterIsInstance<String>()
        assertFalse(rawValues.contains(firstSecret))
        assertFalse(rawValues.contains(secondSecret))
    }

    @Test
    fun deletingOneAccountDoesNotDeleteAnotherAccountsEncryptedRecord() {
        store.write(firstScope, "session.current", "first")
        store.write(secondScope, "session.current", "second")

        store.deleteScope(firstScope)

        assertEquals(null, store.read(firstScope, "session.current"))
        assertEquals("second", store.read(secondScope, "session.current"))
    }

    @Test
    fun atomicallyReplacesAllProfileMaterialInOneEncryptedCommit() {
        store.write(firstScope, "openvpn.profile", "old-profile")
        store.write(firstScope, "openvpn.certificate", "old-certificate")

        store.writeAtomically(
            firstScope,
            mapOf(
                "openvpn.profile" to "new-profile",
                "openvpn.certificate" to "new-certificate",
                "openvpn.tls_crypt_v2" to "new-tls-key",
            ),
        )

        assertEquals("new-profile", store.read(firstScope, "openvpn.profile"))
        assertEquals("new-certificate", store.read(firstScope, "openvpn.certificate"))
        assertEquals("new-tls-key", store.read(firstScope, "openvpn.tls_crypt_v2"))
    }

    @Test
    fun atomicallyPromotesRenewalAndRemovesPendingMarker() {
        store.write(firstScope, "openvpn.identity.renewal_pending", "b")

        store.updateAtomically(
            firstScope,
            values = mapOf(
                "openvpn.identity.active_generation" to "b",
                "openvpn.identity.b.profile" to "new-profile",
            ),
            deletedKeys = setOf("openvpn.identity.renewal_pending"),
        )

        assertEquals("b", store.read(firstScope, "openvpn.identity.active_generation"))
        assertEquals("new-profile", store.read(firstScope, "openvpn.identity.b.profile"))
        assertEquals(null, store.read(firstScope, "openvpn.identity.renewal_pending"))
    }

    @Test
    fun rejectsInvalidAccountIdentifiersBeforeCreatingAStorageScope() {
        assertInvalidAccountId("")
        assertInvalidAccountId("line\nbreak")
        assertInvalidAccountId("\u0000")
    }

    private fun assertInvalidAccountId(accountId: String) {
        try {
            SecureKeystoreStore.accountScope(accountId)
            fail("Expected invalid account id to be rejected")
        } catch (_: IllegalArgumentException) {
            // Expected: account identifiers must never become untrusted preference keys.
        }
    }
}
