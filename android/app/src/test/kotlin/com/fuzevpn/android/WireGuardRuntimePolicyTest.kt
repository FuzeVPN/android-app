package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class WireGuardRuntimePolicyTest {
    @Test fun debugMayUseOfficialDevelopmentRuntime() {
        assertTrue(WireGuardRuntimePolicy.useCompanionService("debug", false))
    }

    @Test fun patchedRuntimeNeverStartsTheCompanionService() {
        for (type in listOf("debug", "profile", "release", "staging")) {
            assertFalse(WireGuardRuntimePolicy.useCompanionService(type, true))
        }
    }

    @Test fun releaseCannotFallBackToCompanionService() = rejects("release")
    @Test fun profileCannotInheritDebugFallback() = rejects("profile")
    @Test fun futureBuildTypesFailClosed() = rejects("staging")

    private fun rejects(type: String) {
        val error = assertThrows(VpnNativeException::class.java) {
            WireGuardRuntimePolicy.useCompanionService(type, false)
        }
        assertEquals("wireguard_foreground_service_unavailable", error.code)
    }
}
