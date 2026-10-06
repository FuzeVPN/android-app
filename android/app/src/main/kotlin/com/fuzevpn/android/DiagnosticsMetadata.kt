package com.fuzevpn.android

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.os.Process

/** Read-only observations: no identity, address, device model or free text. */
internal object DiagnosticsMetadata {
    @Suppress("DEPRECATION")
    fun collect(context: Context): Map<String, Any> {
        val packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
        val versionName = packageInfo.versionName
        if (!DiagnosticsMetadataPolicy.isAppVersion(versionName)) {
            throw VpnNativeException("diagnostic_metadata_unavailable")
        }
        val versionCode = if (Build.VERSION.SDK_INT >= 28) packageInfo.longVersionCode
            else packageInfo.versionCode.toLong()
        return DiagnosticsMetadataPolicy.snapshot(
            requireNotNull(versionName), versionCode, Build.VERSION.SDK_INT,
            Build.VERSION.RELEASE, context.applicationInfo.nativeLibraryDir,
            Process.is64Bit(), BuildConfig.BUILD_TYPE, networkType(context),
        )
    }

    private fun networkType(context: Context): String = try {
        val manager = context.getSystemService(ConnectivityManager::class.java)
        val network = manager?.activeNetwork
        if (manager == null) "unknown"
        else if (network == null) "none"
        else {
            val capabilities = manager.getNetworkCapabilities(network)
            if (capabilities == null) "unknown" else DiagnosticsMetadataPolicy.networkType(
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI),
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR),
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET),
            )
        }
    } catch (_: Exception) { "unknown" }
}

internal object DiagnosticsMetadataPolicy {
    private val appVersion = Regex("(?:0|[1-9][0-9]{0,4})(?:\\.(?:0|[1-9][0-9]{0,4})){2,3}(?:[-+](?:dev|beta|rc)(?:\\.[0-9]{1,5})?|\\+[0-9]{1,10})?")

    fun isAppVersion(value: String?): Boolean = value != null && appVersion.matches(value)

    fun osMajor(release: String?): Int? {
        if (release == null || !Regex("[0-9]{1,3}(?:\\.[0-9]+)*").matches(release)) return null
        return release.substringBefore('.').toIntOrNull()?.takeIf { it in 1..100 }
    }

    fun architecture(nativeLibraryDirectory: String?, is64Bit: Boolean): String {
        // PackageManager selects the application's ABI for this directory.
        // SUPPORTED_ABIS describes the device and can mislabel a 32-bit process.
        return when (nativeLibraryDirectory?.substringAfterLast('/')) {
            "arm64", "arm64-v8a" -> if (is64Bit) "arm64" else "unknown"
            "arm", "armeabi-v7a" -> if (!is64Bit) "armv7" else "unknown"
            "x86_64" -> if (is64Bit) "x64" else "unknown"
            "x86" -> if (!is64Bit) "x86" else "unknown"
            else -> "unknown"
        }
    }

    fun networkType(wifi: Boolean, cellular: Boolean, ethernet: Boolean): String {
        val observed = listOfNotNull(
            "wifi".takeIf { wifi }, "cellular".takeIf { cellular }, "ethernet".takeIf { ethernet },
        )
        // VPN-only or ambiguous capabilities do not prove a physical transport.
        return observed.singleOrNull() ?: "unknown"
    }

    fun snapshot(
        versionName: String, versionCode: Long, sdk: Int, release: String?,
        nativeLibraryDirectory: String?, is64Bit: Boolean, buildType: String, networkType: String,
    ): Map<String, Any> {
        if (!isAppVersion(versionName)) throw VpnNativeException("diagnostic_metadata_unavailable")
        val environment = mutableMapOf<String, Any>(
            "os_family" to "android",
            "architecture" to architecture(nativeLibraryDirectory, is64Bit),
            "build_mode" to buildType.takeIf { it == "debug" || it == "release" }.orUnknown(),
            "network_type" to networkType.takeIf { it in setOf("wifi", "cellular", "ethernet", "none", "unknown") }.orUnknown(),
        )
        osMajor(release)?.let { environment["os_major"] = it }
        if (sdk in 1..100) environment["android_sdk"] = sdk
        return mutableMapOf<String, Any>("app_version" to versionName, "environment" to environment).apply {
            if (versionCode in 0..Int.MAX_VALUE.toLong()) put("app_build", versionCode)
        }
    }

    private fun String?.orUnknown() = this ?: "unknown"
}
