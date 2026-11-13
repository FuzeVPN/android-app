package androidx.core.content

import android.content.Context

object ContextCompat {
    /** False models a runtime permission (POST_NOTIFICATIONS) the user has not granted. */
    @Volatile var granted = true
    fun checkSelfPermission(context: Context, permission: String): Int = if (granted) 0 else -1
}
