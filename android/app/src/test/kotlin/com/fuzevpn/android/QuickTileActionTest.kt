package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class QuickTileActionTest {
    @Test fun idleCanConnectWithoutAServiceEvenWhenAlwaysOnFlagsAreUnknown() {
        for (alwaysOn in listOf(null, true, false)) {
            assertEquals(QuickTileAction.CONNECT, quickTileAction(null, alwaysOn))
        }
    }

    @Test fun anActiveEngineStillRequiresSettingsForPermanentOrUnknownPolicy() {
        for (protocol in VpnProtocol.entries) {
            assertEquals(QuickTileAction.OPEN_SETTINGS, quickTileAction(protocol, null))
            assertEquals(QuickTileAction.OPEN_SETTINGS, quickTileAction(protocol, true))
            assertEquals(QuickTileAction.DISCONNECT, quickTileAction(protocol, false))
        }
    }

    @Test fun expiredSessionAndUnusableLocalIdentitiesLeadToTheApplication() {
        for (code in listOf(
            "system_vpn_resume_session_invalid", "system_vpn_resume_identity_changed",
            "quick_tile_profile_unavailable", "vpn_permission_required", "session_ending",
            "secure_storage_corrupt", "secure_storage_read_failed",
            "wireguard_identity_unavailable", "wireguard_identity_invalid", "wireguard_identity_store_failed",
            "openvpn_identity_unavailable", "openvpn_identity_store_failed", "openvpn_csr_required",
            "openvpn_profile_unavailable", "openvpn_identity_cleanup_pending", "openvpn_renewal_required",
            "openvpn_certificate_expired", "openvpn_certificate_identity_mismatch",
            "openvpn_certificate_expiry_mismatch", "openvpn_network_metadata_invalid",
        )) {
            assertTrue(code, quickTileFailureOpensApplication(code))
        }
    }

    @Test fun successfulClicksAndTransportFailuresKeepTheTileVisible() {
        for (code in listOf(null, "tunnel_disconnected", "openvpn_connect_timeout", "wireguard_stop_timeout",
            "quick_tile_operation_failed", "unknown_failure")) {
            assertFalse(code, quickTileFailureOpensApplication(code))
        }
    }
}
