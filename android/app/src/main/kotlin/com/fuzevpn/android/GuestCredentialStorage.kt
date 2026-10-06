package com.fuzevpn.android

import java.util.Base64

/** Recovery material uses dedicated encrypted slots and stable, secret-free errors. */
internal object GuestCredentialPolicy {
    private val encodedCredential = Regex("[A-Za-z0-9_-]{43}")

    fun isValid(value: String): Boolean {
        if (!encodedCredential.matches(value)) return false
        return runCatching {
            val bytes = Base64.getUrlDecoder().decode(value)
            bytes.size == 32 && Base64.getUrlEncoder().withoutPadding().encodeToString(bytes) == value
        }.getOrDefault(false)
    }

    fun checked(value: String): String {
        if (!isValid(value)) throw VpnNativeException("invalid_guest_credential")
        return value
    }

    fun autoResumeEnabled(value: String?): Boolean = when (value) {
        null, "false" -> false
        "true" -> true
        else -> throw SecureStorageException("secure_storage_corrupt")
    }
}

/** The bridge supplies Keystore-backed functions. A pending credential is
 * durable before HTTP and promoted only after the server accepts the session. */
internal class GuestCredentialStorage(
    private val read: (SecureStorageSlot) -> String?,
    private val update: (Map<SecureStorageSlot, String>, Set<SecureStorageSlot>) -> Unit,
) {
    @Synchronized
    fun readCredential(pending: Boolean = false): String? {
        val slot = if (pending) SecureStorageKeyPolicy.pendingGuestCredential()
            else SecureStorageKeyPolicy.guestCredential()
        val value = read(slot) ?: return null
        if (!GuestCredentialPolicy.isValid(value)) throw SecureStorageException("secure_storage_corrupt")
        return value
    }

    @Synchronized
    fun writeCredential(value: String, pending: Boolean = false) {
        val checked = GuestCredentialPolicy.checked(value)
        val slot = if (pending) SecureStorageKeyPolicy.pendingGuestCredential()
            else SecureStorageKeyPolicy.guestCredential()
        update(mapOf(slot to checked), if (pending) emptySet() else setOf(SecureStorageKeyPolicy.pendingGuestCredential()))
    }

    @Synchronized
    fun readAutoResume(): Boolean = GuestCredentialPolicy.autoResumeEnabled(read(SecureStorageKeyPolicy.guestAutoResume()))

    @Synchronized
    fun writeAutoResume(enabled: Boolean) = update(mapOf(SecureStorageKeyPolicy.guestAutoResume() to enabled.toString()), emptySet())

    @Synchronized
    fun clear() = update(emptyMap(), setOf(SecureStorageKeyPolicy.guestCredential(),
        SecureStorageKeyPolicy.pendingGuestCredential(), SecureStorageKeyPolicy.guestAutoResume()))
}
