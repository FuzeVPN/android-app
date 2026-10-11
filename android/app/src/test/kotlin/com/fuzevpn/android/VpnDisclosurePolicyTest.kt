// SPDX-License-Identifier: MPL-2.0
package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class VpnDisclosurePolicyTest {
    @Test fun upgradingAnAlreadyAuthorizedInstallDoesNotAdoptAppConsent() {
        assertFalse(VpnDisclosurePolicy.mayRequest(false, true, false))
        assertFalse(VpnDisclosurePolicy.mayStart(false, true))
        assertTrue(VpnDisclosurePolicy.mayRequest(false, true, true))
    }
    @Test fun unknownVersionsAndMalformedValuesAreNotConsent() {
        listOf(null, "", "true", "0", "2", "01", "1 ").forEach {
            assertFalse(VpnDisclosurePolicy.accepted(it))
        }
        assertTrue(VpnDisclosurePolicy.accepted(VpnDisclosurePolicy.CURRENT_VERSION))
    }
    @Test fun revokedAndroidAuthorizationRequiresAnotherUserDecision() {
        assertFalse(VpnDisclosurePolicy.mayStart(true, false))
        assertFalse(VpnDisclosurePolicy.mayRequest(true, false, false))
        assertTrue(VpnDisclosurePolicy.mayRequest(true, false, true))
    }
    @Test fun consentPreferenceIsGlobalAndNotSessionOrIdentityMaterial() {
        val consent = SecureStorageKeyPolicy.preference(SecureAppPreference.VPN_DISCLOSURE_VERSION)
        assertEquals(SecureKeystoreStore.GLOBAL_SCOPE, consent.scope)
        assertFalse(SecureStorageKeyPolicy.isSessionSlot(consent.scope, consent.key))
        assertTrue(quickTileFailureOpensApplication("vpn_disclosure_required"))
        assertEquals(QuickTileAction.DISCONNECT, quickTileAction(VpnProtocol.WIREGUARD, false))
    }
}
