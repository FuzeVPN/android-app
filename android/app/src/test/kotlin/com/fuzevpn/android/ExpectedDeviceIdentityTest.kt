package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Test

class ExpectedDeviceIdentityTest {
    @Test fun missingTargetCannotAuthorizeClearingTheCurrentIdentity() {
        val error = assertThrows(VpnNativeException::class.java) { ExpectedDeviceIdentity.fromArguments(emptyMap()) }
        assertEquals("invalid_arguments", error.code)
    }

    @Test fun explicitNoDeviceOnlyMatchesAnUnenrolledAccount() {
        val target = ExpectedDeviceIdentity.fromArguments(mapOf("expected_device_id" to null))
        target.requireCurrent(null)
        val error = assertThrows(VpnNativeException::class.java) { target.requireCurrent("new-device") }
        assertEquals("session_operation_cancelled", error.code)
    }

    @Test fun anOldDeviceResponseCannotClearItsReplacement() {
        val target = ExpectedDeviceIdentity.fromArguments(mapOf("expected_device_id" to "old-device"))
        target.requireCurrent("old-device")
        assertThrows(VpnNativeException::class.java) { target.requireCurrent("new-device") }
        assertThrows(VpnNativeException::class.java) { target.requireCurrent(null) }
    }

    @Test fun invalidRpcTargetIsRejected() {
        for (value in listOf(1, true, "", " ", "device\n", "a".repeat(161))) {
            assertThrows(VpnNativeException::class.java) {
                ExpectedDeviceIdentity.fromArguments(mapOf("expected_device_id" to value))
            }
        }
    }
}
