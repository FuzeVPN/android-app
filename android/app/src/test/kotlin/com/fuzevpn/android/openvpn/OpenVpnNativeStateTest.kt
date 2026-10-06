package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnStatus
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class OpenVpnNativeStateTest {
    @Test
    fun mapsRecognizedCoreStatesToTheFlutterStateContract() {
        assertEquals(VpnStatus.CONNECTING, OpenVpnNativeState.fromNative("connecting", "").toVpnStatus())
        assertEquals(VpnStatus.CONNECTED, OpenVpnNativeState.fromNative("connected", "").toVpnStatus())
        assertEquals(VpnStatus.DISCONNECTING, OpenVpnNativeState.fromNative("disconnecting", "").toVpnStatus())
        assertNull(OpenVpnNativeState.fromNative("connected", "").messageCode())
    }

    @Test
    fun normalizesUnexpectedOrSensitiveCoreReasons() {
        val unsafeReason = "TLS failure for 198.51.100.12; profile=private-material"

        val error = OpenVpnNativeState.fromNative("error", unsafeReason)
        val unknownState = OpenVpnNativeState.fromNative("backend_private_state", unsafeReason)

        assertEquals(VpnStatus.ERROR, error.toVpnStatus())
        assertEquals("connection_failed", error.messageCode())
        assertEquals("connection_failed", unknownState.messageCode())
    }

    @Test
    fun preservesOnlyKnownMachineReadableErrorCodes() {
        val error = OpenVpnNativeState.fromNative("error", "certificate_validation_failed")

        assertEquals("certificate_validation_failed", error.messageCode())
    }

    @Test
    fun rejectsCertificateReplacementDuringLocationMigration() {
        assertEquals(true, matchesStoredMigrationCertificate(null, "certificate-a"))
        assertEquals(
            true,
            matchesStoredMigrationCertificate("certificate-a", "certificate-a"),
        )
        assertEquals(
            false,
            matchesStoredMigrationCertificate("certificate-a", "certificate-b"),
        )
    }
}
