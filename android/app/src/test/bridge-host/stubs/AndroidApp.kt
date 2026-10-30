package android.app

import android.content.Context
import android.content.Intent
import kotlinx.coroutines.android.HarnessMain

open class Activity : Context() {
    /** Android posts to the UI looper; the harness looper is HarnessMain. */
    open fun runOnUiThread(action: Runnable) { HarnessMain.post(action) }
    open fun requestPermissions(permissions: Array<String>, requestCode: Int) {}
    open fun startActivityForResult(intent: Intent, requestCode: Int) { startedActivities += intent }
    companion object { const val RESULT_OK = -1 }
}

class PendingIntent private constructor(val intent: Intent, val requestCode: Int) {
    companion object {
        const val FLAG_UPDATE_CURRENT = 0x08000000
        const val FLAG_IMMUTABLE = 0x04000000
        @JvmStatic fun getActivity(context: Context, requestCode: Int, intent: Intent, flags: Int): PendingIntent =
            PendingIntent(intent, requestCode)
    }
}
