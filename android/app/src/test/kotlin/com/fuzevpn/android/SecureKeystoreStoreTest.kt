package com.fuzevpn.android

import android.content.SharedPreferences
import java.io.InputStream
import java.io.OutputStream
import java.lang.reflect.InvocationTargetException
import java.security.Key
import java.security.KeyStoreSpi
import java.security.Provider
import java.security.Security
import java.security.UnrecoverableKeyException
import java.security.cert.Certificate
import java.util.Collections
import java.util.Date
import java.util.Enumeration
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import org.junit.Assert.*
import org.junit.Test

/** Real AES-GCM with a synthetic key provider; no device/user Keystore access. */
class SecureKeystoreStoreTest {
    private val account = "storage-fixture-account"
    private val scope = SecureKeystoreStore.accountScope(account)
    private val googleRecord = "v1:global:fuzevpn.google.pending_authentication"
    private val googlePending = """{"version":1,"request_id":"request-fixture","purpose":"claim","stage":"continuation",""" +
        """"ticket":"ticket-fixture","context":"context-fixture","expires_at":"2099-01-01T00:00:00Z","generation":1}"""

    @Test fun transientKeyReadFailurePreservesValidIdentityUntilProviderRecovers() {
        val fixture = Fixture()
        fixture.store.write(scope, "wireguard.private_key", "fixture-identity")
        val committed = fixture.encrypted.commits
        fixture.keys.unavailable = true
        assertCode("secure_storage_read_failed") { fixture.store.read(scope, "wireguard.private_key") }
        assertEquals(committed, fixture.encrypted.commits)
        fixture.keys.unavailable = false
        assertEquals("fixture-identity", fixture.store.read(scope, "wireguard.private_key"))
    }

    @Test fun decryptionRequestsExistingKeyAndDoesNotCreateOneWhenItIsMissing() {
        val fixture = Fixture()
        fixture.store.write(scope, "identity", "fixture-identity")
        fixture.keys.missing = true
        assertCode("secure_storage_read_failed") { fixture.store.read(scope, "identity") }
        assertEquals(false, fixture.keys.requests.last())
        assertEquals(0, fixture.keys.replacements)
        fixture.keys.missing = false
        assertEquals("fixture-identity", fixture.store.read(scope, "identity"))
    }

    @Test fun authenticatedCorruptionIsRemovedButStrictReaderPreservesItsMarker() {
        val fixture = Fixture()
        val other = SecureKeystoreStore.accountScope("second-fixture-account")
        fixture.store.write(scope, "identity", "first")
        fixture.store.write(other, "identity", "second")
        fixture.encrypted.putRaw("v1:$other:identity", fixture.encrypted.getString("v1:$scope:identity", null)!!)
        assertCode("secure_storage_corrupt") { fixture.store.read(other, "identity", removeCorrupt = false) }
        assertTrue(fixture.encrypted.contains("v1:$other:identity"))
        assertCode("secure_storage_corrupt") { fixture.store.read(other, "identity") }
        assertFalse(fixture.encrypted.contains("v1:$other:identity"))
        assertEquals("first", fixture.store.read(scope, "identity"))
    }

    @Test fun malformedCiphertextIsClassifiedAsCorruptAndCleanupIsDurable() {
        val fixture = Fixture()
        for (raw in listOf("not base64!", "AA==", "DBERERERERERERERERERERERERER")) {
            fixture.encrypted.putRaw("v1:$scope:identity", raw)
            assertCode("secure_storage_corrupt") { fixture.store.read(scope, "identity") }
            assertFalse(fixture.encrypted.reopen().contains("v1:$scope:identity"))
        }
    }

    @Test fun sessionPurgeDisablesGuestResumeInOneCommitWithoutUsingAnyKey() {
        val fixture = Fixture()
        val tokens = listOf(SecureStorageKeyPolicy.pendingSession(), SecureStorageKeyPolicy.activeUser(),
            SecureStorageKeyPolicy.accountSession(account), SecureStorageKeyPolicy.quickTileProfile(),
            SecureStorageKeyPolicy.systemVpnResume())
        val autoResume = SecureStorageKeyPolicy.guestAutoResume()
        val credential = SecureStorageKeyPolicy.guestCredential()
        fixture.store.updateSlotsAtomically((tokens + autoResume + credential).associateWith { "fixture" })
        fixture.store.write(scope, "wireguard.private_key", "fixture-identity")
        val committed = fixture.encrypted.commits
        val keyRequests = fixture.keys.requests.size
        fixture.keys.unavailable = true

        fixture.store.clearSessionMaterial(disableGuestAutoResume = true)

        assertEquals(committed + 1, fixture.encrypted.commits)
        assertEquals(keyRequests, fixture.keys.requests.size)
        val reopened = fixture.reopen()
        (tokens + autoResume).forEach { assertNull(reopened.read(it.scope, it.key)) }
        fixture.keys.unavailable = false
        assertEquals("fixture", reopened.read(credential.scope, credential.key))
        assertEquals("fixture-identity", reopened.read(scope, "wireguard.private_key"))
    }

    @Test fun expiryPurgeRetainsGuestResumeAndRecovery() {
        val fixture = Fixture()
        val autoResume = SecureStorageKeyPolicy.guestAutoResume()
        fixture.store.updateSlotsAtomically(mapOf(autoResume to "true",
            SecureStorageKeyPolicy.accountSession(account) to "fixture-session"))
        fixture.keys.unavailable = true
        fixture.store.clearSessionMaterial(disableGuestAutoResume = false)
        fixture.keys.unavailable = false
        assertEquals("true", fixture.store.read(autoResume.scope, autoResume.key))
    }

    @Test fun explicitGuestResumeRefusalUsesDeletionEvenWhenKeystoreIsUnavailable() {
        val fixture = Fixture()
        val guests = GuestCredentialStorage(
            read = { fixture.store.read(it.scope, it.key, removeCorrupt = false) },
            update = fixture.store::updateSlotsAtomically,
        )
        guests.writeAutoResume(true)
        val requests = fixture.keys.requests.size
        fixture.keys.unavailable = true
        guests.writeAutoResume(false)
        assertEquals(requests, fixture.keys.requests.size)
        assertFalse(guests.readAutoResume())
    }

    @Test fun allSupportedMigrationIdentifiersKeepTheirExistingSlotNamesAndRoundTrip() {
        val fixture = Fixture()
        for (length in listOf(1, 158, 159, 160)) {
            val deviceId = "d".repeat(length)
            val slot = SecureStorageKeyPolicy.locationMigration(account, deviceId)
            assertEquals("fuzevpn.device.location_migration.$deviceId", slot.key)
            fixture.store.write(slot.scope, slot.key, "fixture-migration")
            assertEquals("fixture-migration", fixture.store.read(slot.scope, slot.key))
        }
        assertThrows(VpnNativeException::class.java) {
            SecureStorageKeyPolicy.locationMigration(account, "d".repeat(161))
        }
    }

    @Test fun failedEncryptionNeverPartiallyPublishesAnAtomicReplacement() {
        val fixture = Fixture()
        fixture.store.writeAtomically(scope, mapOf("profile" to "old-profile", "certificate" to "old-cert"))
        fixture.keys.failOnRequest = fixture.keys.requests.size + 2
        assertCode("secure_storage_write_failed") {
            fixture.store.writeAtomically(scope, mapOf("profile" to "new-profile", "certificate" to "new-cert"))
        }
        fixture.keys.failOnRequest = -1
        assertEquals("old-profile", fixture.store.read(scope, "profile"))
        assertEquals("old-cert", fixture.store.read(scope, "certificate"))
    }

    @Test fun diagnosticsRefusalSurvivesProviderFailureCleanupFailureAndRecreation() {
        val fixture = Fixture()
        fixture.store.writeAutomaticDiagnosticsConsent(true)
        assertTrue(fixture.store.readAutomaticDiagnosticsConsent())
        fixture.keys.unavailable = true
        fixture.encrypted.failNextCommit = true
        fixture.store.writeAutomaticDiagnosticsConsent(false)
        assertFalse(fixture.reopen().readAutomaticDiagnosticsConsent())
        fixture.keys.unavailable = false
        assertFalse(fixture.reopen().readAutomaticDiagnosticsConsent())
        val consent = SecureStorageKeyPolicy.preference(SecureAppPreference.DIAGNOSTICS_AUTOMATIC_OPT_IN)
        assertEquals("true", fixture.reopen().read(consent.scope, consent.key))
    }

    @Test fun existingEncryptedDiagnosticsConsentRemainsReadableWithoutAMigration() {
        val fixture = Fixture()
        val slot = SecureStorageKeyPolicy.preference(SecureAppPreference.DIAGNOSTICS_AUTOMATIC_OPT_IN)
        fixture.store.write(slot.scope, slot.key, "true")
        assertTrue(fixture.reopen().readAutomaticDiagnosticsConsent())
        fixture.store.writeAutomaticDiagnosticsConsent(false)
        assertFalse(fixture.reopen().readAutomaticDiagnosticsConsent())
    }

    @Test fun failedOptInCannotRemoveDurableRefusalButExplicitSuccessfulOptInCan() {
        val fixture = Fixture()
        fixture.store.writeAutomaticDiagnosticsConsent(false)
        fixture.keys.unavailable = true
        assertCode("secure_storage_write_failed") { fixture.store.writeAutomaticDiagnosticsConsent(true) }
        assertFalse(fixture.reopen().readAutomaticDiagnosticsConsent())
        fixture.keys.unavailable = false
        fixture.store.writeAutomaticDiagnosticsConsent(true)
        assertTrue(fixture.reopen().readAutomaticDiagnosticsConsent())
    }

    @Test fun failedRefusalCommitReportsFailureAndStillDeniesCurrentProcess() {
        val fixture = Fixture()
        fixture.store.writeAutomaticDiagnosticsConsent(true)
        fixture.privacy.failNextCommit = true
        assertCode("secure_storage_write_failed") { fixture.store.writeAutomaticDiagnosticsConsent(false) }
        assertFalse(fixture.store.readAutomaticDiagnosticsConsent())
        // Total disk failure cannot promise a durable refusal. The caller is
        // told persistence failed, rather than receiving a false acknowledgement.
        assertTrue(fixture.reopen().readAutomaticDiagnosticsConsent())
    }

    @Test fun failedOptInMarkerRemovalRestoresRefusalInMemoryAndOnDisk() {
        val fixture = Fixture()
        fixture.store.writeAutomaticDiagnosticsConsent(false)
        fixture.privacy.failOnCommit = fixture.privacy.commits + 2
        assertCode("secure_storage_write_failed") { fixture.store.writeAutomaticDiagnosticsConsent(true) }
        assertFalse(fixture.store.readAutomaticDiagnosticsConsent())
        assertFalse(fixture.reopen().readAutomaticDiagnosticsConsent())
        fixture.store.writeAutomaticDiagnosticsConsent(true)
        assertTrue(fixture.reopen().readAutomaticDiagnosticsConsent())
    }

    @Test fun failedFirstOptInEncryptedCommitCannotPublishConsentInMemoryOrAfterRecreation() {
        val fixture = Fixture()
        fixture.encrypted.failNextCommit = true
        assertCode("secure_storage_write_failed") { fixture.store.writeAutomaticDiagnosticsConsent(true) }
        assertFalse(fixture.store.readAutomaticDiagnosticsConsent())
        assertFalse(fixture.reopen().readAutomaticDiagnosticsConsent())
    }

    @Test fun malformedRefusalMarkerDeniesInsteadOfConsenting() {
        val fixture = Fixture()
        fixture.store.writeAutomaticDiagnosticsConsent(true)
        fixture.privacy.putRaw("automatic_diagnostics_denied", "wrong-type")
        assertFalse(fixture.store.readAutomaticDiagnosticsConsent())
    }

    // C5-03: the Google continuation, read as GoogleAuthBridge reads it, is
    // corrupt when it can never be decrypted again, so Dart may drop it; an
    // unavailable Keystore stays a recoverable failure.
    @Test fun undecryptableGoogleContinuationIsCorruptButAnUnavailableKeystoreIsNot() {
        val fixture = Fixture()
        val pending = googleContinuation(fixture.store)
        pending.write(googlePending)
        fixture.keys.unavailable = true
        assertGoogleCode("secure_storage_failed") { pending.read() }
        fixture.keys.unavailable = false
        assertEquals(googlePending, pending.read())
        fixture.store.write(scope, "identity", "fixture-identity")
        for (raw in listOf(fixture.encrypted.getString("v1:$scope:identity", null)!!, "not base64!", "AA==")) {
            fixture.encrypted.putRaw(googleRecord, raw)
            assertGoogleCode("secure_storage_corrupt") { pending.read() }
            assertEquals(raw, fixture.encrypted.getString(googleRecord, null))
        }
    }

    @Test fun googleContinuationWhoseKeystoreKeyIsGoneIsCorruptAndDroppedWithoutAKey() {
        val fixture = Fixture()
        googleContinuation(fixture.store).write(googlePending)
        val keyless = googleContinuation(SecureKeystoreStore(fixture.encrypted, fixture.privacy, ::keyFromEmptyAndroidKeyStore))
        assertGoogleCode("secure_storage_corrupt") { keyless.read() }
        assertTrue(fixture.encrypted.contains(googleRecord))
        keyless.clear()
        assertFalse(fixture.encrypted.contains(googleRecord))
    }

    private fun assertCode(code: String, block: () -> Unit) {
        assertEquals(code, assertThrows(SecureStorageException::class.java, block).code)
    }

    private fun assertGoogleCode(code: String, block: () -> Unit) {
        assertEquals(code, assertThrows(GoogleAuthException::class.java, block).code)
    }

    private fun googleContinuation(store: SecureKeystoreStore) = GooglePendingAuthStorage(
        read = { slot -> store.read(slot.scope, slot.key, removeCorrupt = false) },
        update = store::updateSlotsAtomically,
    )

    /** The production key lookup, against an AndroidKeyStore that no longer holds the key. */
    private fun keyFromEmptyAndroidKeyStore(createIfAbsent: Boolean): SecretKey {
        val provider = object : Provider("AndroidKeyStore", 1.0, "empty test keystore") {
            init {
                putService(object : Provider.Service(this, "KeyStore", "AndroidKeyStore", EmptyKeyStore::class.java.name, null, null) {
                    override fun newInstance(constructorParameter: Any?): Any = EmptyKeyStore()
                })
            }
        }
        Security.insertProviderAt(provider, 1)
        try {
            return SecureKeystoreStore.Companion::class.java.getDeclaredMethod("getKey", Boolean::class.javaPrimitiveType)
                .apply { isAccessible = true }.invoke(SecureKeystoreStore.Companion, createIfAbsent) as SecretKey
        } catch (error: InvocationTargetException) {
            throw error.targetException
        } finally {
            Security.removeProvider("AndroidKeyStore")
        }
    }

    private class EmptyKeyStore : KeyStoreSpi() {
        override fun engineGetKey(alias: String?, password: CharArray?): Key? = null
        override fun engineGetCertificateChain(alias: String?): Array<Certificate>? = null
        override fun engineGetCertificate(alias: String?): Certificate? = null
        override fun engineGetCreationDate(alias: String?): Date? = null
        override fun engineSetKeyEntry(alias: String?, key: Key?, password: CharArray?, chain: Array<out Certificate>?) = Unit
        override fun engineSetKeyEntry(alias: String?, key: ByteArray?, chain: Array<out Certificate>?) = Unit
        override fun engineSetCertificateEntry(alias: String?, cert: Certificate?) = Unit
        override fun engineDeleteEntry(alias: String?) = Unit
        override fun engineAliases(): Enumeration<String> = Collections.emptyEnumeration()
        override fun engineContainsAlias(alias: String?) = false
        override fun engineSize() = 0
        override fun engineIsKeyEntry(alias: String?) = false
        override fun engineIsCertificateEntry(alias: String?) = false
        override fun engineGetCertificateAlias(cert: Certificate?): String? = null
        override fun engineStore(stream: OutputStream?, password: CharArray?) = Unit
        override fun engineLoad(stream: InputStream?, password: CharArray?) = Unit
    }

    private class Fixture {
        val encrypted = MemoryPreferences()
        val privacy = MemoryPreferences()
        val keys = SyntheticKeyProvider()
        val store = SecureKeystoreStore(encrypted, privacy, keys::get)
        fun reopen() = SecureKeystoreStore(encrypted.reopen(), privacy.reopen(), keys::get)
    }

    private class SyntheticKeyProvider {
        private val key: SecretKey = KeyGenerator.getInstance("AES").apply { init(256) }.generateKey()
        var unavailable = false
        var missing = false
        var replacements = 0
        var failOnRequest = -1
        val requests = mutableListOf<Boolean>()
        fun get(createIfAbsent: Boolean): SecretKey {
            requests += createIfAbsent
            if (unavailable || requests.size == failOnRequest || (missing && !createIfAbsent)) {
                throw UnrecoverableKeyException("synthetic-provider-unavailable")
            }
            if (missing) { replacements++; missing = false }
            return key
        }
    }

    /** Models Android's memory update before commit acknowledgement. */
    private class MemoryPreferences(private val disk: MutableMap<String, Any?> = mutableMapOf()) : SharedPreferences {
        private val memory = disk.toMutableMap()
        var commits = 0
        var failNextCommit = false
        var failOnCommit = -1
        fun reopen() = MemoryPreferences(disk)
        fun putRaw(key: String, value: Any) { memory[key] = value; disk[key] = value }
        override fun getAll(): MutableMap<String, *> = memory.toMutableMap()
        override fun contains(key: String) = memory.containsKey(key)
        override fun getString(key: String, defValue: String?): String? = if (contains(key)) memory[key] as String? else defValue
        @Suppress("UNCHECKED_CAST")
        override fun getStringSet(key: String, defValues: MutableSet<String>?): MutableSet<String>? =
            if (contains(key)) (memory[key] as Set<String>?)?.toMutableSet() else defValues
        override fun getInt(key: String, defValue: Int) = if (contains(key)) memory[key] as Int else defValue
        override fun getLong(key: String, defValue: Long) = if (contains(key)) memory[key] as Long else defValue
        override fun getFloat(key: String, defValue: Float) = if (contains(key)) memory[key] as Float else defValue
        override fun getBoolean(key: String, defValue: Boolean) = if (contains(key)) memory[key] as Boolean else defValue
        override fun registerOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener?) = Unit
        override fun unregisterOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener?) = Unit
        override fun edit(): SharedPreferences.Editor = object : SharedPreferences.Editor {
            private val changes = mutableMapOf<String, Any?>()
            private var clear = false
            override fun putString(key: String, value: String?) = apply { changes[key] = value }
            override fun putStringSet(key: String, values: MutableSet<String>?) = apply { changes[key] = values?.toSet() }
            override fun putInt(key: String, value: Int) = apply { changes[key] = value }
            override fun putLong(key: String, value: Long) = apply { changes[key] = value }
            override fun putFloat(key: String, value: Float) = apply { changes[key] = value }
            override fun putBoolean(key: String, value: Boolean) = apply { changes[key] = value }
            override fun remove(key: String) = apply { changes[key] = null }
            override fun clear() = apply { clear = true }
            override fun apply() { commit() }
            override fun commit(): Boolean {
                commits++
                if (clear) memory.clear()
                changes.forEach { (key, value) -> if (value == null) memory.remove(key) else memory[key] = value }
                if (failNextCommit || commits == failOnCommit) { failNextCommit = false; return false }
                disk.clear(); disk.putAll(memory)
                return true
            }
        }
    }
}
