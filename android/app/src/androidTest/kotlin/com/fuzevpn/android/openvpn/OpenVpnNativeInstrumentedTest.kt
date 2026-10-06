package com.fuzevpn.android.openvpn

import android.os.ParcelFileDescriptor
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class OpenVpnNativeInstrumentedTest {
    @Test
    fun nativeSessionCanBeCreatedAndDestroyedRepeatedlyWithoutAStaleHandle() {
        if (!OpenVpnNative.isCoreAvailable()) return

        repeat(3) {
            val handle = OpenVpnNative.create(RecordingCallback())
            assertTrue("Each cycle must allocate a fresh native session", handle != 0L)
            assertTrue("Destroy must confirm removal from the native registry", OpenVpnNative.destroy(handle))
            assertFalse("A destroyed handle must no longer exist", OpenVpnNative.destroy(handle))
        }
    }

    @Test
    fun unavailableCoreCannotCreateASessionAndInvalidProfilesFailClosedWithoutLeakingProfileText() {
        val callback = RecordingCallback()
        val coreAvailable = OpenVpnNative.isCoreAvailable()
        val handle = OpenVpnNative.create(callback)
        val profileSecret = "fuzevpn-test-profile-${System.nanoTime()}"

        if (!coreAvailable) {
            try {
                // The JNI fallback may allocate a sentinel session, but it
                // must never establish a tunnel when the reviewed Core is absent.
                assertFalse(
                    "A Core-unavailable native library must fail closed",
                    OpenVpnNative.start(handle, "client\n$profileSecret\n", "fuzevpn.test.invalid"),
                )
                assertFalse(OpenVpnNative.isConnected(handle) == true)
            } finally {
                if (handle != 0L) assertTrue(OpenVpnNative.destroy(handle))
            }
        } else {
            try {
                assertTrue("An available Core must create a native session", handle != 0L)
                assertFalse(
                    "A malformed profile must never create a tunnel",
                    OpenVpnNative.start(handle, "client\n$profileSecret\n", "fuzevpn.test.invalid"),
                )
            } finally {
                if (handle != 0L) assertTrue(OpenVpnNative.destroy(handle))
            }
        }
        assertFalse(
            "Raw profile text must not cross the native state callback boundary",
            callback.states.any { it.contains(profileSecret) },
        )
        assertFalse("Raw profile text must not be written to logcat", logcatContains(profileSecret))
    }

    private fun logcatContains(value: String): Boolean {
        val descriptor = InstrumentationRegistry.getInstrumentation()
            .uiAutomation
            .executeShellCommand("logcat -d -v raw")
        return ParcelFileDescriptor.AutoCloseInputStream(descriptor).bufferedReader().useLines { lines ->
            lines.any { it.contains(value) }
        }
    }

    private class RecordingCallback : OpenVpnNative.Callback {
        val states = mutableListOf<String>()

        override fun onNativeState(state: String, reason: String) {
            states += "$state:$reason"
        }

        override fun onTunConfiguration(planJson: String): Int = -1

        override fun onProtectSocket(fd: Int): Boolean = false

        override fun onPkiCertificate(alias: String): String? = null

        override fun onPkiSign(
            alias: String,
            dataBase64: String,
            algorithm: String,
            hashAlg: String,
            saltLen: String,
        ): String? = null
    }
}
