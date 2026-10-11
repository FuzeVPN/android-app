package com.fuzevpn.android

/** Account-scoped UI history, with no relationship to VPN authorization. */
internal class GuestOnboardingStorage(
    private val read: (SecureStorageSlot) -> String?,
    private val write: (SecureStorageSlot, String) -> Unit,
) {
    fun readCompleted(accountId: String): Boolean =
        read(SecureStorageKeyPolicy.guestOnboardingCompleted(accountId)) == "true"

    // There is deliberately no false/reset operation: expiry and logout must
    // not forget that this principal previously completed the welcome flow.
    fun complete(accountId: String) {
        write(SecureStorageKeyPolicy.guestOnboardingCompleted(accountId), "true")
    }
}
