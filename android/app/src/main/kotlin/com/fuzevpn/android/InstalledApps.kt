package com.fuzevpn.android

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.os.Build
import androidx.core.graphics.createBitmap
import java.io.ByteArrayOutputStream

/**
 * The installed apps that split tunneling can exclude: those with an icon in the launcher. The manifest
 * declares only that intent in its queries, so this app never needs the broad package visibility permission.
 * Never called on the main thread.
 */
internal class InstalledApps(context: Context) {
    private val appContext = context.applicationContext
    private val packages: PackageManager get() = appContext.packageManager

    /** Package name and label of each launchable app, FuzeVPN left out. */
    fun launchable(): List<Map<String, Any?>> {
        val launcher = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
        val activities = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            packages.queryIntentActivities(launcher, PackageManager.ResolveInfoFlags.of(0))
        } else {
            @Suppress("DEPRECATION") packages.queryIntentActivities(launcher, 0)
        }
        val own = appContext.packageName
        val apps = linkedMapOf<String, ApplicationInfo>()
        for (activity in activities) {
            val application = activity.activityInfo?.applicationInfo ?: continue
            val name = application.packageName ?: continue
            if (name != own && SplitTunnelPolicy.isPackageName(name)) apps.putIfAbsent(name, application)
        }
        return apps.map { (name, application) ->
            val label = try { application.loadLabel(packages).toString().trim() } catch (_: Exception) { "" }
            mapOf("package" to name, "label" to label.ifEmpty { name }.take(MAX_LABEL))
        }
    }

    /** The app's icon as a square PNG of [sizePx] pixels; null when the app or its icon cannot be read. */
    fun icon(packageName: String, sizePx: Int): ByteArray? {
        if (!SplitTunnelPolicy.isPackageName(packageName) || sizePx !in MIN_ICON_PX..MAX_ICON_PX) {
            throw VpnNativeException("invalid_arguments")
        }
        return try {
            val drawable = packages.getApplicationIcon(packageName)
            val bitmap = createBitmap(sizePx, sizePx, Bitmap.Config.ARGB_8888)
            drawable.setBounds(0, 0, sizePx, sizePx)
            drawable.draw(Canvas(bitmap))
            ByteArrayOutputStream().use { output ->
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, output)
                bitmap.recycle()
                output.toByteArray()
            }
        } catch (_: PackageManager.NameNotFoundException) {
            null
        } catch (_: RuntimeException) {
            null
        }
    }

    /** Whether Android still knows [packageName]: VpnService.Builder refuses to exclude an unknown one. */
    fun isInstalled(packageName: String): Boolean = try {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            packages.getApplicationInfo(packageName, PackageManager.ApplicationInfoFlags.of(0))
        } else {
            @Suppress("DEPRECATION") packages.getApplicationInfo(packageName, 0)
        }
        true
    } catch (_: PackageManager.NameNotFoundException) {
        false
    }

    private companion object {
        const val MAX_LABEL = 120
        const val MIN_ICON_PX = 16
        const val MAX_ICON_PX = 256
    }
}
