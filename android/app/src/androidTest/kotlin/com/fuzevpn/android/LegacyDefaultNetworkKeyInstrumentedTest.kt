package com.fuzevpn.android

import android.content.Context
import android.net.ConnectivityManager
import android.util.Log
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertEquals
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith

/** Without its network callback (the Android 11 bind race, campaign vm31i), the OpenVPN watcher
 * knows the default physical network by the legacy type and extra information of
 * activeNetworkInfo (a cellular network's APN), matched against the connected or suspended
 * networks allNetworks lists (AndroidVpnBridge.physicalNetworkVanished and legacyReading,
 * LegacyDefaultNetworkTracker). On Android 11 an IMS, MMS or SUPL network is TYPE_MOBILE too: this
 * checks on a real device, with no VPN started here, that the key singles out the default network.
 * Framework calls only, nothing of the app under test or its data, so it runs alike in the
 * isolated recovery test APK. */
@RunWith(AndroidJUnit4::class)
class LegacyDefaultNetworkKeyInstrumentedTest {
    @Suppress("DEPRECATION")
    @Test fun theDefaultNetworkInfoMatchesExactlyOneListedNetwork() {
        val connectivity = ApplicationProvider.getApplicationContext<Context>()
            .getSystemService(ConnectivityManager::class.java)
        // The reads are no snapshot: a default that moved while they ran is read again.
        repeat(5) {
            val routed = connectivity.activeNetwork
            val listed = connectivity.allNetworks.mapNotNull { network ->
                connectivity.getNetworkInfo(network)?.takeIf { it.type != ConnectivityManager.TYPE_VPN }
                    ?.let { network to it }
            }.toMap()
            // Read last, as the watcher does.
            val default = connectivity.activeNetworkInfo
            if (connectivity.activeNetwork != routed) {
                Thread.sleep(1_000)
                return@repeat
            }
            assumeTrue("No default network", default != null)
            assumeTrue("The default network info describes a VPN", default!!.type != ConnectivityManager.TYPE_VPN)
            // BLOCKED clears the extra information: the watcher takes no key from such a look.
            assumeTrue("The default network is blocked for this app",
                default.detailedState != android.net.NetworkInfo.DetailedState.BLOCKED)
            // Followed as the watcher follows them: connected or suspended.
            val followed = listOf(android.net.NetworkInfo.DetailedState.CONNECTED, android.net.NetworkInfo.DetailedState.SUSPENDED)
            val matching = listed.filterValues { info ->
                info.type == default.type && info.extraInfo == default.extraInfo && info.detailedState in followed
            }
            // Types and states only: the extra information can name the Wi-Fi or the carrier.
            val described = "default type ${default.type}; listed: " + listed.values.joinToString { info ->
                "type ${info.type} ${info.detailedState}" + if (info.extraInfo == default.extraInfo) " same extra" else ""
            }
            Log.i("LegacyDefaultNetworkKey", described)
            assertEquals(described, 1, matching.size)
            // Unless a VPN routes this process, that network is the active network itself.
            if (routed != null && connectivity.getNetworkInfo(routed)?.type != ConnectivityManager.TYPE_VPN) {
                assertEquals(described, routed, matching.keys.single())
            }
            return
        }
        assumeTrue("The default network kept changing", false)
    }
}
