package com.fuzevpn.android

import android.content.Context
import android.content.SharedPreferences
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Base64
import androidx.core.content.edit
import java.nio.ByteBuffer
import java.nio.charset.StandardCharsets
import java.security.KeyStore
import java.security.MessageDigest
import javax.crypto.AEADBadTagException
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import javax.crypto.spec.GCMParameterSpec

/**
 * Small encrypted key/value store for data that must not be held in Flutter
 * preferences. Values are AES-GCM encrypted with an app-only Android Keystore
 * key and authenticated with their storage slot as additional data, preventing
 * ciphertext swapping between accounts or keys.
 *
 * WireGuard/OpenVPN private material is only ever read by native code. The
 * typed method-channel contract in [AndroidVpnBridge] exposes only dedicated
 * business operations; native slot names are never accepted from Dart.
 */
internal class SecureKeystoreStore(context: Context) {
    private val preferences: SharedPreferences = context.getSharedPreferences(
        PREFERENCES_NAME,
        Context.MODE_PRIVATE,
    )

    @Synchronized
    fun read(scope: String, key: String, removeCorrupt: Boolean = true): String? {
        val storageKey = storageKey(scope, key)
        val encoded = preferences.getString(storageKey, null) ?: return null
        return try {
            decrypt(storageKey, encoded)
        } catch (error: SecureStorageException) {
            // A corrupt or invalidated record must not be treated as a secret
            // belonging to another account. Remove only this record and make
            // the caller present an actionable storage error.
            // Admission markers must survive a failed read: absence would unlock enrollment.
            if (removeCorrupt) preferences.edit { remove(storageKey) }
            throw error
        }
    }

    @Synchronized
    fun write(scope: String, key: String, value: String) {
        require(value.length <= MAX_VALUE_CHARS) { "storage_value_too_large" }
        val storageKey = storageKey(scope, key)
        preferences.edit().putString(storageKey, encrypt(storageKey, value)).commitOrThrow()
    }

    /**
     * Encrypts every value before touching preferences, then commits their
     * replacement in one editor transaction. This is used for a recovered
     * OpenVPN activation so a process failure cannot leave a mixture of old
     * and new node material visible to the next connection attempt.
     */
    @Synchronized
    fun writeAtomically(scope: String, values: Map<String, String>) {
        require(values.isNotEmpty()) { "storage_values_empty" }
        val encrypted = values.map { (key, value) ->
            require(value.length <= MAX_VALUE_CHARS) { "storage_value_too_large" }
            val storageKey = storageKey(scope, key)
            storageKey to encrypt(storageKey, value)
        }
        val editor = preferences.edit()
        encrypted.forEach { (storageKey, value) -> editor.putString(storageKey, value) }
        editor.commitOrThrow()
    }

    /**
     * Commits a related replacement and cleanup as one durable operation.
     * OpenVPN renewal uses this to publish the new Keystore generation and
     * remove its pending marker without exposing an intermediate state.
     */
    @Synchronized
    fun updateAtomically(
        scope: String,
        values: Map<String, String>,
        deletedKeys: Set<String>,
    ) {
        require(values.isNotEmpty() || deletedKeys.isNotEmpty()) { "storage_update_empty" }
        require(values.keys.intersect(deletedKeys).isEmpty()) { "storage_update_conflict" }
        val encrypted = values.map { (key, value) ->
            require(value.length <= MAX_VALUE_CHARS) { "storage_value_too_large" }
            val storageKey = storageKey(scope, key)
            storageKey to encrypt(storageKey, value)
        }
        val deletedStorageKeys = deletedKeys.map { key -> storageKey(scope, key) }
        val editor = preferences.edit()
        encrypted.forEach { (storageKey, value) -> editor.putString(storageKey, value) }
        deletedStorageKeys.forEach(editor::remove)
        editor.commitOrThrow()
    }

    @Synchronized
    fun delete(scope: String, key: String) {
        preferences.edit().remove(storageKey(scope, key)).commitOrThrow()
    }

    /** Erase tokens even when the active-account pointer cannot be decrypted. */
    @Synchronized
    fun clearSessionMaterial(disableGuestAutoResume: Boolean = false) {
        val editor = preferences.edit()
        if (disableGuestAutoResume) {
            val slot = SecureStorageKeyPolicy.guestAutoResume()
            val storageKey = storageKey(slot.scope, slot.key)
            editor.putString(storageKey, encrypt(storageKey, "false"))
        }
        preferences.all.keys.forEach { record ->
            val parts = record.split(':', limit = 3)
            if (parts.size == 3 && parts[0] == FORMAT_VERSION &&
                SecureStorageKeyPolicy.isSessionSlot(parts[1], parts[2])) editor.remove(record)
        }
        editor.commitOrThrow()
    }

    /** One durable commit across native-owned slots, including account and
     * global resume metadata. Values are encrypted before any record changes. */
    @Synchronized
    fun updateSlotsAtomically(
        values: Map<SecureStorageSlot, String>,
        deletedSlots: Set<SecureStorageSlot> = emptySet(),
    ) {
        require(values.isNotEmpty() || deletedSlots.isNotEmpty()) { "storage_update_empty" }
        require(values.keys.intersect(deletedSlots).isEmpty()) { "storage_update_conflict" }
        val encrypted = values.map { (slot, value) ->
            require(value.length <= MAX_VALUE_CHARS) { "storage_value_too_large" }
            val storageKey = storageKey(slot.scope, slot.key)
            storageKey to encrypt(storageKey, value)
        }
        val deletedKeys = deletedSlots.map { storageKey(it.scope, it.key) }
        val editor = preferences.edit()
        encrypted.forEach { (storageKey, value) -> editor.putString(storageKey, value) }
        deletedKeys.forEach(editor::remove)
        editor.commitOrThrow()
    }

    /** Removes one related record set in a single committed transaction. */
    @Synchronized
    fun deleteAtomically(scope: String, keys: Set<String>) {
        require(keys.isNotEmpty()) { "storage_keys_empty" }
        val storageKeys = keys.map { key -> storageKey(scope, key) }
        val editor = preferences.edit()
        storageKeys.forEach(editor::remove)
        editor.commitOrThrow()
    }

    @Synchronized
    fun deleteScope(scope: String) {
        val prefix = "$FORMAT_VERSION:$scope:"
        val editor = preferences.edit()
        preferences.all.keys.filter { it.startsWith(prefix) }.forEach(editor::remove)
        editor.commitOrThrow()
    }

    /**
     * Deletes only a native-owned family of records from an account scope.
     * This is deliberately narrower than [deleteScope]: Flutter's account
     * session/device envelope must survive an OpenVPN identity reset.
     */
    @Synchronized
    fun deleteByKeyPrefix(scope: String, keyPrefix: String) {
        require(SCOPE_PATTERN.matches(scope)) { "invalid_storage_scope" }
        require(KEY_PATTERN.matches(keyPrefix)) { "invalid_storage_key" }
        val storagePrefix = "$FORMAT_VERSION:$scope:$keyPrefix"
        val editor = preferences.edit()
        preferences.all.keys.filter { it.startsWith(storagePrefix) }.forEach(editor::remove)
        editor.commitOrThrow()
    }

    private fun storageKey(scope: String, key: String): String {
        require(SCOPE_PATTERN.matches(scope)) { "invalid_storage_scope" }
        require(KEY_PATTERN.matches(key)) { "invalid_storage_key" }
        return "$FORMAT_VERSION:$scope:$key"
    }

    private fun encrypt(storageKey: String, value: String): String = try {
        val cipher = Cipher.getInstance(CIPHER_TRANSFORMATION)
        cipher.init(Cipher.ENCRYPT_MODE, getOrCreateKey())
        cipher.updateAAD(storageKey.toByteArray(StandardCharsets.UTF_8))
        val iv = cipher.iv
        val ciphertext = cipher.doFinal(value.toByteArray(StandardCharsets.UTF_8))
        val packed = ByteBuffer.allocate(1 + iv.size + ciphertext.size)
            .put(iv.size.toByte())
            .put(iv)
            .put(ciphertext)
            .array()
        Base64.encodeToString(packed, Base64.NO_WRAP)
    } catch (error: Exception) {
        throw SecureStorageException("secure_storage_write_failed", error)
    }

    private fun decrypt(storageKey: String, encoded: String): String = try {
        val packed = Base64.decode(encoded, Base64.NO_WRAP)
        if (packed.size < 1 + GCM_TAG_BYTES) {
            throw SecureStorageException("secure_storage_corrupt")
        }
        val buffer = ByteBuffer.wrap(packed)
        val ivLength = buffer.get().toInt() and 0xff
        if (ivLength !in 12..16 || buffer.remaining() <= GCM_TAG_BYTES) {
            throw SecureStorageException("secure_storage_corrupt")
        }
        val iv = ByteArray(ivLength)
        buffer.get(iv)
        val ciphertext = ByteArray(buffer.remaining())
        buffer.get(ciphertext)
        val cipher = Cipher.getInstance(CIPHER_TRANSFORMATION)
        cipher.init(Cipher.DECRYPT_MODE, getOrCreateKey(), GCMParameterSpec(GCM_TAG_BITS, iv))
        cipher.updateAAD(storageKey.toByteArray(StandardCharsets.UTF_8))
        String(cipher.doFinal(ciphertext), StandardCharsets.UTF_8)
    } catch (error: SecureStorageException) {
        throw error
    } catch (error: AEADBadTagException) {
        throw SecureStorageException("secure_storage_corrupt", error)
    } catch (error: Exception) {
        throw SecureStorageException("secure_storage_read_failed", error)
    }

    private fun getOrCreateKey(): SecretKey = synchronized(keyCreationLock) {
        // OpenVPN and the Flutter session store intentionally use separate
        // SecureKeystoreStore instances, so this lock must be process-wide.
        val keyStore = KeyStore.getInstance(ANDROID_KEYSTORE).apply { load(null) }
        val existing = keyStore.getKey(KEY_ALIAS, null) as? SecretKey
        if (existing != null) return@synchronized existing

        val generator = KeyGenerator.getInstance(KeyProperties.KEY_ALGORITHM_AES, ANDROID_KEYSTORE)
        generator.init(
            KeyGenParameterSpec.Builder(
                KEY_ALIAS,
                KeyProperties.PURPOSE_ENCRYPT or KeyProperties.PURPOSE_DECRYPT,
            )
                .setKeySize(256)
                .setBlockModes(KeyProperties.BLOCK_MODE_GCM)
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                .setRandomizedEncryptionRequired(true)
                .setUserAuthenticationRequired(false)
                .build(),
        )
        generator.generateKey()
    }

    private fun SharedPreferences.Editor.commitOrThrow() {
        if (!commit()) throw SecureStorageException("secure_storage_write_failed")
    }

    companion object {
        private const val PREFERENCES_NAME = "fuzevpn.secure.v1"
        private const val FORMAT_VERSION = "v1"
        private const val KEY_ALIAS = "fuzevpn.android.aesgcm.v1"
        private const val ANDROID_KEYSTORE = "AndroidKeyStore"
        private const val CIPHER_TRANSFORMATION = "AES/GCM/NoPadding"
        private const val GCM_TAG_BITS = 128
        private const val GCM_TAG_BYTES = 16
        private const val MAX_VALUE_CHARS = 256 * 1024
        private val SCOPE_PATTERN = Regex("[a-z0-9_-]{1,80}")
        private val KEY_PATTERN = Regex("[A-Za-z0-9_.-]{1,192}")
        private val keyCreationLock = Any()

        const val GLOBAL_SCOPE = "global"

        /** A stable opaque scope, so account identifiers are not preference keys. */
        fun accountScope(accountId: String): String {
            require(
                accountId.isNotBlank() && accountId.length <= 128 &&
                    accountId.none { it == '\u0000' || it.isISOControl() },
            ) { "invalid_account_id" }
            val digest = MessageDigest.getInstance("SHA-256")
                .digest(accountId.toByteArray(StandardCharsets.UTF_8))
                .joinToString(separator = "") { "%02x".format(it.toInt() and 0xff) }
            return "account_${digest.take(48)}"
        }
    }
}

internal class SecureStorageException(
    val code: String,
    cause: Throwable? = null,
) : Exception(code, cause)
