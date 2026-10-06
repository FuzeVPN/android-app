package com.fuzevpn.android.openvpn

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.fuzevpn.android.SecureKeystoreStore
import java.security.KeyStore
import java.security.MessageDigest
import java.util.UUID
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertFalse
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class OpenVpnIdentityReleaseInstrumentedTest {
    @Test
    fun unreadableRevocationMarkerIsRetainedAcrossRepeatedReads() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val account = "corrupt-${UUID.randomUUID()}"
        val device = "device-${UUID.randomUUID()}"
        val controller = OpenVpnController(context)
        val store = SecureKeystoreStore(context)
        val scope = SecureKeystoreStore.accountScope(account)
        val record = "v1:$scope:fuzevpn.openvpn.${sha256(device).take(40)}.revocation_pending"
        val preferences = context.getSharedPreferences("fuzevpn.secure.v1", Context.MODE_PRIVATE)
        try {
            assertTrue(preferences.edit().putString(record, "not-encrypted").commit())
            repeat(2) {
                assertTrue(controller.isRevocationBlocked(account, device))
                assertTrue(preferences.contains(record))
            }
        } finally { controller.clearAccountIdentity(account); store.deleteScope(scope) }
    }

    @Test
    fun confirmedRevocationRemovesBothGenerationsAndPreservesOtherMaterial() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val account = "revoked-${UUID.randomUUID()}"
        val device = "device-${UUID.randomUUID()}"
        val controller = OpenVpnController(context)
        val store = SecureKeystoreStore(context)
        val scope = SecureKeystoreStore.accountScope(account)
        val id = sha256(device).take(40)
        val alias = "fuzevpn.ovpn.${sha256(account).take(32)}.$id"
        try {
            val active = controller.getOrCreateCsr(account, device)
            val pending = controller.getOrCreateCsr(account, device, renewal = true)
            assertEquals("b", store.read(scope, "fuzevpn.openvpn.$id.renewal_pending"))
            store.write(scope, "wireguard.test_sentinel", "keep")
            store.write(scope, "fuzevpn.device.current", device)
            var observedPersistedRevocation = false
            val result = controller.cleanRevokedIdentity(RevokedOpenVpnIdentity(account, device, sha256(pending)),
                checkCurrent = {}, admitted = {}, clearTile = {}, publish = { state ->
                    if (state.tunnelStopped && !state.identityCleared) {
                        assertEquals(sha256(pending), store.read(scope, "fuzevpn.openvpn.$id.revocation_pending"))
                        observedPersistedRevocation = true
                    }
                })
            assertTrue(result.complete)
            assertTrue(observedPersistedRevocation)
            val keys = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
            assertFalse(keys.containsAlias(alias))
            assertFalse(keys.containsAlias("$alias.b"))
            assertNull(store.read(scope, "fuzevpn.openvpn.$id.renewal_pending"))
            assertNull(store.read(scope, "fuzevpn.openvpn.$id.revocation_pending"))
            assertEquals("keep", store.read(scope, "wireguard.test_sentinel"))
            assertEquals(device, store.read(scope, "fuzevpn.device.current"))
            val fresh = controller.getOrCreateCsr(account, device)
            assertNotEquals(active, fresh)
            assertNotEquals(pending, fresh)
        } finally { controller.clearAccountIdentity(account); store.deleteScope(scope) }
    }

    @Test
    fun persistedCleanupBlocksEnrollmentAfterRecreationAndCanFinishWithoutOldCsr() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val account = "pending-${UUID.randomUUID()}"
        val device = "device-${UUID.randomUUID()}"
        val first = OpenVpnController(context)
        val store = SecureKeystoreStore(context)
        val scope = SecureKeystoreStore.accountScope(account)
        try {
            val oldCsr = first.getOrCreateCsr(account, device)
            val target = RevokedOpenVpnIdentity(account, device, sha256(oldCsr))
            val incomplete = first.cleanRevokedIdentity(target, checkCurrent = {}, admitted = {},
                clearTile = { error("simulated tile storage failure") }, publish = {})
            assertTrue(incomplete.identityCleared)
            assertFalse(incomplete.complete)
            val restored = OpenVpnController(context)
            assertNotNull(restored.pendingRevocation(account, device))
            try { restored.getOrCreateCsr(account, device); org.junit.Assert.fail("revoked identity admitted") }
            catch (error: com.fuzevpn.android.VpnNativeException) { assertEquals("openvpn_identity_cleanup_pending", error.code) }
            assertTrue(restored.cleanRevokedIdentity(target, checkCurrent = {}, admitted = {}, clearTile = {}, publish = {}).complete)
            val fresh = restored.getOrCreateCsr(account, device)
            assertNotEquals(oldCsr, fresh)
            assertTrue(restored.cleanRevokedIdentity(target, checkCurrent = {}, admitted = { error("stale cleanup admitted") }, clearTile = {}, publish = {}).stale)
            restored.clearAccountIdentity(account)
        } finally { first.clearAccountIdentity(account); store.deleteScope(scope) }
    }

    @Test
    fun renewalKeepsCurrentIdentityAndReusesOnePendingCsr() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val accountId = "renew-account-${UUID.randomUUID()}"
        val deviceId = "renew-device-${UUID.randomUUID()}"
        val controller = OpenVpnController(context)
        val secureStore = SecureKeystoreStore(context)
        val scope = SecureKeystoreStore.accountScope(accountId)
        val identityId = sha256(deviceId).take(40)
        val aliasPrefix = "fuzevpn.ovpn.${sha256(accountId).take(32)}.$identityId"
        val currentAlias = aliasPrefix
        val pendingAlias = "$aliasPrefix.b"
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }

        try {
            val currentCsr = controller.getOrCreateCsr(accountId, deviceId)
            val pendingCsr = controller.getOrCreateCsr(accountId, deviceId, renewal = true)
            val retriedPendingCsr = controller.getOrCreateCsr(accountId, deviceId, renewal = true)

            assertNotEquals(currentCsr, pendingCsr)
            assertEquals(pendingCsr, retriedPendingCsr)
            assertEquals(currentCsr, secureStore.read(scope, "fuzevpn.openvpn.$identityId.csr"))
            assertEquals(pendingCsr, secureStore.read(scope, "fuzevpn.openvpn.$identityId.b.csr"))
            assertEquals("b", secureStore.read(scope, "fuzevpn.openvpn.$identityId.renewal_pending"))
            assertTrue(keyStore.containsAlias(currentAlias))
            assertTrue(keyStore.containsAlias(pendingAlias))
        } finally {
            controller.clearAccountIdentity(accountId)
            secureStore.deleteScope(scope)
        }
    }

    @Test
    fun removesOnlyTheRevokedOpenVpnIdentityAndAllowsFreshEnrollment() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val accountId = "release-account-${UUID.randomUUID()}"
        val deviceId = "release-device-${UUID.randomUUID()}"
        val controller = OpenVpnController(context)
        val secureStore = SecureKeystoreStore(context)
        val scope = SecureKeystoreStore.accountScope(accountId)
        val identityId = sha256(deviceId).take(40)
        val alias = "fuzevpn.ovpn.${sha256(accountId).take(32)}.$identityId"
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }

        try {
            val originalCsr = controller.getOrCreateCsr(accountId, deviceId)
            assertNotNull(keyStore.getKey(alias, null))
            secureStore.writeAtomically(
                scope,
                mapOf(
                    "fuzevpn.openvpn.$identityId.certificate" to "test-certificate",
                    "fuzevpn.openvpn.$identityId.ca" to "test-ca",
                    "fuzevpn.openvpn.$identityId.tls_crypt_v2" to "test-tls-key",
                    "fuzevpn.openvpn.$identityId.profile" to "test-profile",
                    "fuzevpn.openvpn.$identityId.network" to "test-network",
                    "fuzevpn.openvpn.$identityId.b.network" to "pending-test-network",
                    "fuzevpn.openvpn.$identityId.not_after" to "2099-01-01T00:00:00Z",
                ),
            )

            controller.clearIdentity(accountId, deviceId)

            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.csr"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.certificate"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.ca"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.tls_crypt_v2"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.profile"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.network"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.b.network"))
            assertNull(secureStore.read(scope, "fuzevpn.openvpn.$identityId.not_after"))
            assertFalse(keyStore.containsAlias(alias))

            val replacementCsr = controller.getOrCreateCsr(accountId, deviceId)
            assertNotEquals(originalCsr, replacementCsr)
            assertNotNull(keyStore.getKey(alias, null))
        } finally {
            controller.clearAccountIdentity(accountId)
            secureStore.deleteScope(scope)
        }
    }

    private fun sha256(value: String): String = MessageDigest.getInstance("SHA-256")
        .digest(value.toByteArray(Charsets.UTF_8))
        .joinToString("") { "%02x".format(it.toInt() and 0xff) }
}
