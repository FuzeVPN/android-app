package com.fuzevpn.android

// Gradle generates BuildConfig and R in the application build.
object BuildConfig {
    const val DEBUG = false
    const val BUILD_TYPE = "release"
    const val USE_PATCHED_WIREGUARD_AAR = true
}

object R {
    object string {
        const val vpn_notification_title = 1
        const val vpn_tile_label = 2
        const val vpn_tile_working = 3
        const val vpn_tile_connected = 4
        const val vpn_tile_waiting_network = 5
        const val vpn_tile_reconnecting = 6
        const val vpn_tile_connecting = 7
        const val vpn_tile_disconnecting = 8
        const val vpn_tile_setup_required = 9
        const val vpn_tile_interrupted = 10
        const val vpn_tile_ready = 11
    }
}
