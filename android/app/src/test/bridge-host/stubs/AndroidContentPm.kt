package android.content.pm

import android.content.Intent

open class PackageManager {
    open fun getLaunchIntentForPackage(packageName: String): Intent? = Intent("launch:$packageName")
    companion object { const val PERMISSION_GRANTED = 0 }
}
