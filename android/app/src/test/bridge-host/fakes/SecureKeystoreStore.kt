package com.fuzevpn.android

import android.content.Context
import java.nio.charset.StandardCharsets
import java.security.MessageDigest

/** In-memory store with the API used by the bridge; the real one needs Android Keystore. */
internal class SecureKeystoreStore(@Suppress("UNUSED_PARAMETER") context: Context) {
    fun read(scope: String, key: String, removeCorrupt: Boolean = true): String? {
        HarnessControl.readFailure?.let { throw SecureStorageException(it) }
        if (HarnessControl.readKeyMissing) throw SecureStorageException("secure_storage_read_failed", keyMissing = true)
        synchronized(HarnessControl) { HarnessControl.readFailureOnce.also { HarnessControl.readFailureOnce = null } }
            ?.let { throw SecureStorageException(it) }
        val resume = SecureStorageKeyPolicy.systemVpnResume()
        if (scope == resume.scope && key == resume.key) {
            HarnessControl.resumeReadGate?.let { gate -> HarnessControl.resumeReadGate = null; gate.hold() }
        }
        return synchronized(VALUES) { VALUES[scope to key] }
    }
    fun write(scope: String, key: String, value: String) { synchronized(VALUES) { VALUES[scope to key] = value } }
    fun delete(scope: String, key: String) { synchronized(VALUES) { VALUES.remove(scope to key) } }
    fun updateSlotsAtomically(values: Map<SecureStorageSlot, String>, deletedSlots: Set<SecureStorageSlot> = emptySet()) =
        synchronized(VALUES) {
            values.forEach { (slot, value) -> VALUES[slot.scope to slot.key] = value }
            deletedSlots.forEach { VALUES.remove(it.scope to it.key) }
        }
    fun clearSessionMaterial(disableGuestAutoResume: Boolean = false) {
        HarnessControl.purges += disableGuestAutoResume
        synchronized(VALUES) {
            VALUES.keys.removeAll { (scope, key) -> SecureStorageKeyPolicy.isSessionSlot(scope, key) }
        }
        HarnessControl.purgeGate?.let { gate -> HarnessControl.purgeGate = null; gate.hold() }
    }
    fun readAutomaticDiagnosticsConsent(): Boolean = false
    fun writeAutomaticDiagnosticsConsent(enabled: Boolean) {}

    companion object {
        private val VALUES = HashMap<Pair<String, String>, String>()
        fun raw(slot: SecureStorageSlot): String? = synchronized(VALUES) { VALUES[slot.scope to slot.key] }
        fun put(slot: SecureStorageSlot, value: String) { synchronized(VALUES) { VALUES[slot.scope to slot.key] = value } }
        fun remove(slot: SecureStorageSlot) { synchronized(VALUES) { VALUES.remove(slot.scope to slot.key) } }
        fun clearAll() { synchronized(VALUES) { VALUES.clear() } }

        const val GLOBAL_SCOPE = "global"
        fun accountScope(accountId: String): String {
            require(accountId.isNotBlank() && accountId.length <= 128 &&
                accountId.none { it == '\u0000' || it.isISOControl() }) { "invalid_account_id" }
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
    val keyMissing: Boolean = false,
) : Exception(code, cause)
