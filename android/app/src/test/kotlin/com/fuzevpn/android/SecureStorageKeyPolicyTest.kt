package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Test

class SecureStorageKeyPolicyTest {
    @Test
    fun automaticDiagnosticsRequiresExplicitConsentInOwnEncryptedPreference() {
        val slot = SecureStorageKeyPolicy.preference(SecureAppPreference.DIAGNOSTICS_AUTOMATIC_OPT_IN)
        assertEquals(SecureStorageSlot(SecureKeystoreStore.GLOBAL_SCOPE,
            "fuzevpn.preference.diagnostics.automatic_opt_in"), slot)
        assertEquals(false, SecureStorageKeyPolicy.isSessionSlot(slot.scope, slot.key))
        assertEquals(true, SecureStorageKeyPolicy.automaticDiagnosticsEnabled("true"))
        for (value in listOf(null, "", "false", "TRUE", "1", " true ", "corrupt")) {
            assertEquals(false, SecureStorageKeyPolicy.automaticDiagnosticsEnabled(value))
        }
    }

    @Test
    fun resolvesAccountScopedSlotsWithoutAcceptingStorageKeys() {
        assertEquals(
            SecureStorageSlot(
                SecureKeystoreStore.accountScope("user-a"),
                "fuzevpn.device.location_migration.device-android",
            ),
            SecureStorageKeyPolicy.locationMigration("user-a", "device-android"),
        )
        assertEquals(
            SecureStorageSlot(
                SecureKeystoreStore.accountScope("user-a"),
                "fuzevpn.device.current",
            ),
            SecureStorageKeyPolicy.currentDevice("user-a"),
        )
    }

    @Test
    fun usesFuzeVpnNamespacedEncryptedSlots() {
        assertEquals(
            SecureStorageSlot(SecureKeystoreStore.GLOBAL_SCOPE, "fuzevpn.session.pending"),
            SecureStorageKeyPolicy.pendingSession(),
        )
        assertEquals(
            SecureStorageSlot(SecureKeystoreStore.GLOBAL_SCOPE, "fuzevpn.session.active_user"),
            SecureStorageKeyPolicy.activeUser(),
        )
        assertEquals(
            SecureStorageSlot(
                SecureKeystoreStore.accountScope("user-a"),
                "fuzevpn.session.current",
            ),
            SecureStorageKeyPolicy.accountSession("user-a"),
        )
        assertEquals(
            SecureStorageSlot(SecureKeystoreStore.GLOBAL_SCOPE, "fuzevpn.preference.ui.locale"),
            SecureStorageKeyPolicy.preference(SecureAppPreference.LOCALE),
        )
        assertEquals(
            SecureStorageSlot(
                SecureKeystoreStore.GLOBAL_SCOPE,
                "fuzevpn.preference.account.verification_needed.user-a",
            ),
            SecureStorageKeyPolicy.verificationNeeded("user-a"),
        )
    }

    @Test
    fun rejectsMalformedDynamicIdentifiers() {
        assertCode("invalid_device_id") {
            SecureStorageKeyPolicy.locationMigration("user-a", "")
        }
        assertCode("invalid_account_id") {
            SecureStorageKeyPolicy.verificationNeeded("user/a")
        }
    }

    private fun assertCode(expected: String, block: () -> Unit) {
        val error = assertThrows(VpnNativeException::class.java, block)
        assertEquals(expected, error.code)
    }
}
