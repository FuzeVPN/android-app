package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class DiagnosticsMetadataTest {
    @Test fun snapshotContainsOnlySafeObservedFields() {
        val actual = DiagnosticsMetadataPolicy.snapshot(
            "1.2.3+456", 456L, 36, "16.0", "/data/app/synthetic/lib/arm64", true, "release", "wifi",
        )
        assertEquals(setOf("app_version", "app_build", "environment"), actual.keys)
        assertEquals("1.2.3+456", actual["app_version"])
        assertEquals(456L, actual["app_build"])
        assertEquals(mapOf(
            "os_family" to "android", "os_major" to 16, "android_sdk" to 36,
            "architecture" to "arm64", "build_mode" to "release", "network_type" to "wifi",
        ), actual["environment"])
    }

    @Test fun unknownAndOutOfRangeMeasurementsAreNotInvented() {
        val actual = DiagnosticsMetadataPolicy.snapshot(
            "1.2.3", Long.MAX_VALUE, 101, "PreviewVendor", "/unrecognized", false, "profile", "private-ssid",
        )
        assertFalse(actual.containsKey("app_build"))
        assertEquals(mapOf(
            "os_family" to "android", "architecture" to "unknown", "build_mode" to "unknown",
            "network_type" to "unknown",
        ), actual["environment"])
    }

    @Test fun processArchitectureRequiresSelectedAbiAndMatchingBitness() {
        for ((directory, is64, expected) in listOf(
            Triple("arm64", true, "arm64"), Triple("arm", false, "armv7"),
            Triple("x86_64", true, "x64"), Triple("x86", false, "x86"),
            Triple("arm64", false, "unknown"), Triple("arm", true, "unknown"),
            Triple("not-an-abi", true, "unknown"),
        )) assertEquals(expected, DiagnosticsMetadataPolicy.architecture("/lib/$directory", is64))
    }

    @Test fun osMajorIsNumericAndBounded() {
        assertEquals(16, DiagnosticsMetadataPolicy.osMajor("16.0.1"))
        assertEquals(100, DiagnosticsMetadataPolicy.osMajor("100"))
        for (value in listOf(null, "0", "101", "16-preview", "Vendor", "16.0 private")) {
            assertNull(DiagnosticsMetadataPolicy.osMajor(value))
        }
    }

    @Test fun appVersionCannotContainBuildDescriptions() {
        for (value in listOf("1.2.3", "1.2.3.4", "1.2.3-rc.2", "1.2.3+123")) {
            assertTrue(DiagnosticsMetadataPolicy.isAppVersion(value))
        }
        for (value in listOf(null, "", "01.2.3", "1.2", "1.2.3 my-phone", "private@example.test")) {
            assertFalse(DiagnosticsMetadataPolicy.isAppVersion(value))
        }
    }

    @Test fun ambiguousOrVpnOnlyTransportIsUnknown() {
        assertEquals("wifi", DiagnosticsMetadataPolicy.networkType(true, false, false))
        assertEquals("cellular", DiagnosticsMetadataPolicy.networkType(false, true, false))
        assertEquals("ethernet", DiagnosticsMetadataPolicy.networkType(false, false, true))
        assertEquals("unknown", DiagnosticsMetadataPolicy.networkType(false, false, false))
        assertEquals("unknown", DiagnosticsMetadataPolicy.networkType(true, true, false))
    }
}
