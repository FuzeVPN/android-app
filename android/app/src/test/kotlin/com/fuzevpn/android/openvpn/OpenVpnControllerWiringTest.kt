package com.fuzevpn.android.openvpn

import java.io.File
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Final reaudit B13 and B18: OwnedNativeOperationsTest and BoundedNativeCallTest
 * prove the extracted parts only. The real controller needs Keystore and JNI and
 * has no JVM double, so its wiring is pinned in its source: callNative delegates
 * to callBoundedNative, and every native identity guard asks OwnedNativeOperations
 * whether a native session is still in use.
 */
class OpenVpnControllerWiringTest {
    private val source: String = listOf("src/main/kotlin", "android/app/src/main/kotlin")
        .map { File(it, "com/fuzevpn/android/openvpn/OpenVpnController.kt") }
        .first { it.isFile }
        .readText()

    @Test fun callNativeDelegatesToTheBoundedCall() {
        assertTrue(Regex("""private fun <T> callNative\(timeoutMillis: Long, block: \(\) -> T\): T =\s+""" +
            """callBoundedNative\(nativeExecutor, timeoutMillis, \{ operationUncertain = true \}, block\)""")
            .containsMatchIn(source))
    }

    @Test fun identityGuardsAskWhetherANativeSessionIsInUse() {
        val guards = Regex("""if \((.+?)\) \{\s+throw VpnNativeException\("openvpn_identity_in_use"\)""")
            .findAll(source).map { it.groupValues[1] }.toList()
        assertEquals(guards.toString(), 3, guards.size)
        assertTrue(guards.toString(), guards.all { it == "ownedNative.nativeSessionInUse()" })
    }
}
