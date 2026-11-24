package com.fuzevpn.android

import android.content.Context

/** The launcher's apps as HarnessControl.installedApps lists them; the real one reads PackageManager. */
internal class InstalledApps(@Suppress("UNUSED_PARAMETER") context: Context) {
    fun launchable(): List<Map<String, Any?>> =
        HarnessControl.installedApps.toList().map { mapOf("package" to it, "label" to "Label of $it") }

    fun icon(packageName: String, sizePx: Int): ByteArray? {
        if (!SplitTunnelPolicy.isPackageName(packageName) || sizePx !in 16..256) {
            throw VpnNativeException("invalid_arguments")
        }
        return if (packageName in HarnessControl.installedApps) byteArrayOf(sizePx.toByte()) else null
    }

    fun isInstalled(packageName: String): Boolean = packageName in HarnessControl.installedApps
}
