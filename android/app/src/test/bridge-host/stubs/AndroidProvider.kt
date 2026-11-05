package android.provider

import android.content.ContentResolver

object Settings {
    const val ACTION_VPN_SETTINGS = "android.settings.VPN_SETTINGS"

    object Secure {
        /** False refuses every read, as Android 12+ do for hidden keys; true models Android 10-11. */
        @Volatile var readable = false
        @Volatile var alwaysOnVpnApp: String? = null
        @JvmStatic fun getString(resolver: ContentResolver?, name: String): String? {
            if (!readable) throw SecurityException("Settings key: <$name> is not readable")
            return if (name == "always_on_vpn_app") alwaysOnVpnApp else null
        }
        fun reset() { readable = false; alwaysOnVpnApp = null }
    }
}
