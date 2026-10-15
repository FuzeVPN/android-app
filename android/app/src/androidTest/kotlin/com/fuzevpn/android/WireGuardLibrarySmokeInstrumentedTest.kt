package com.fuzevpn.android

import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wireguard.android.backend.GoBackend
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith

/** Loads the approved ARM engine without requesting a tunnel or contacting a server. */
@RunWith(AndroidJUnit4::class)
class WireGuardLibrarySmokeInstrumentedTest {
    @Test
    fun approvedLibraryLoadsAndReportsVersionWithoutStartingATunnel() {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        assumeTrue("Requires the isolated qualification APK", context.packageName == "com.fuzevpn.recoverytest")
        val executor = Executors.newSingleThreadExecutor()
        try {
            val version = executor.submit<String> { GoBackend(context).version }.get(30, TimeUnit.SECONDS)
            assertTrue("WireGuard returned no version", version.isNotBlank())
        } finally {
            executor.shutdownNow()
        }
    }
}
