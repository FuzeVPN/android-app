package com.fuzevpn.android

/** A native-only, fully resolved encrypted-storage slot. */
internal data class SecureStorageSlot(
    val scope: String,
    val key: String,
)

internal enum class SecureAppPreference(internal val storageKey: String) {
    THEME_MODE("fuzevpn.preference.ui.theme_mode"),
    LOCALE("fuzevpn.preference.ui.locale"),
    SELECTED_PROTOCOL("fuzevpn.preference.ui.selected_protocol"),
    SELECTED_LOCATION("fuzevpn.preference.ui.selected_location"),
    FAVORITE_LOCATIONS("fuzevpn.preference.ui.favorite_locations"),
    DIAGNOSTICS_AUTOMATIC_OPT_IN("fuzevpn.preference.diagnostics.automatic_opt_in"),
    VPN_DISCLOSURE_VERSION("fuzevpn.preference.vpn.disclosure_version"),
}

/**
 * Typed storage contract used only by native business operations.
 *
 * This clean FuzeVPN identity deliberately uses a new key namespace. There is
 * no compatibility path for records created by an earlier product identity,
 * and no function accepts an arbitrary key from Flutter.
 */
internal object SecureStorageKeyPolicy {
    private const val SESSION_PENDING = "fuzevpn.session.pending"
    private const val SESSION_ACTIVE_USER = "fuzevpn.session.active_user"
    private const val SESSION_CURRENT = "fuzevpn.session.current"
    private const val DEVICE_CURRENT = "fuzevpn.device.current"
    private const val DEVICE_LOCATION_MIGRATION_PREFIX = "fuzevpn.device.location_migration."
    private const val VERIFICATION_NEEDED_PREFIX = "fuzevpn.preference.account.verification_needed."
    private const val QUICK_TILE_PROFILE = "fuzevpn.vpn.quick_tile.last_validated_profile"
    private const val SYSTEM_VPN_RESUME = "fuzevpn.vpn.system_resume"
    private const val GUEST_CREDENTIAL = "fuzevpn.guest.credential"
    private const val GUEST_PENDING_CREDENTIAL = "fuzevpn.guest.pending_credential"
    private const val GUEST_AUTO_RESUME = "fuzevpn.guest.auto_resume"
    private const val GUEST_ONBOARDING_COMPLETED = "fuzevpn.preference.guest.onboarding_completed"
    private val safeIdentifier = Regex("[A-Za-z0-9._-]{1,160}")

    fun pendingSession() = global(SESSION_PENDING)

    fun activeUser() = global(SESSION_ACTIVE_USER)

    // Recovery credentials survive an expired API session and are never part
    // of an account identity scope or the session-token cleanup family.
    fun guestCredential() = global(GUEST_CREDENTIAL)
    fun pendingGuestCredential() = global(GUEST_PENDING_CREDENTIAL)
    fun guestAutoResume() = global(GUEST_AUTO_RESUME)

    /** UI history only, retained when session tokens are erased. */
    fun guestOnboardingCompleted(accountId: String): SecureStorageSlot {
        val checked = checkedIdentifier(accountId, "invalid_account_id")
        if (checked.length > 128) throw VpnNativeException("invalid_account_id")
        return account(checked, GUEST_ONBOARDING_COMPLETED)
    }

    fun accountSession(accountId: String) = account(accountId, SESSION_CURRENT)

    fun isSessionSlot(scope: String, key: String): Boolean =
        if (scope == SecureKeystoreStore.GLOBAL_SCOPE) {
            key in setOf(SESSION_PENDING, SESSION_ACTIVE_USER, QUICK_TILE_PROFILE, SYSTEM_VPN_RESUME)
        } else {
            Regex("account_[a-f0-9]{48}").matches(scope) && key == SESSION_CURRENT
        }

    fun currentDevice(accountId: String) = account(accountId, DEVICE_CURRENT)

    fun locationMigration(accountId: String, deviceId: String): SecureStorageSlot = account(
        accountId,
        DEVICE_LOCATION_MIGRATION_PREFIX + checkedIdentifier(deviceId, "invalid_device_id"),
    )

    fun preference(preference: SecureAppPreference) = global(preference.storageKey)

    /** Missing or unrecognized data never enables automatic reporting. */
    fun automaticDiagnosticsEnabled(value: String?): Boolean = value == "true"

    fun quickTileProfile() = global(QUICK_TILE_PROFILE)
    fun systemVpnResume() = global(SYSTEM_VPN_RESUME)

    fun verificationNeeded(accountId: String): SecureStorageSlot {
        // Validating the account scope ensures the identifier obeys the same
        // contract as account-scoped encrypted records.
        SecureKeystoreStore.accountScope(accountId)
        return global(
            VERIFICATION_NEEDED_PREFIX + checkedIdentifier(accountId, "invalid_account_id"),
        )
    }

    private fun global(key: String) = SecureStorageSlot(SecureKeystoreStore.GLOBAL_SCOPE, key)

    private fun account(accountId: String, key: String) = SecureStorageSlot(
        SecureKeystoreStore.accountScope(accountId),
        key,
    )

    private fun checkedIdentifier(value: String, errorCode: String): String {
        if (!safeIdentifier.matches(value)) throw VpnNativeException(errorCode)
        return value
    }
}
