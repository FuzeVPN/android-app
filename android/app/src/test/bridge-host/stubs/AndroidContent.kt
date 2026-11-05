package android.content

import android.content.pm.PackageManager
import android.net.Uri
import java.io.OutputStream
import java.util.Collections

open class Context {
    open val applicationContext: Context get() = this
    open val packageName: String get() = "com.fuzevpn.android"
    open val packageManager: PackageManager get() = PackageManager()
    open val contentResolver: ContentResolver get() = ContentResolver()
    val services: MutableMap<Class<*>, Any> = Collections.synchronizedMap(mutableMapOf())
    val startedActivities: MutableList<Intent> = Collections.synchronizedList(mutableListOf())
    /** Models a device without the requested activity (Settings.ACTION_VPN_SETTINGS may be absent). */
    @Volatile var missingActivity: String? = null

    @Suppress("UNCHECKED_CAST")
    open fun <T> getSystemService(serviceClass: Class<T>): T =
        (services[serviceClass] ?: error("service double missing: ${serviceClass.name}")) as T

    open fun startActivity(intent: Intent) {
        if (intent.action != null && intent.action == missingActivity) throw ActivityNotFoundException(intent.action)
        startedActivities += intent
    }

    open fun getString(id: Int, vararg formatArgs: Any?): String =
        if (formatArgs.isEmpty()) "string#$id" else "string#$id${formatArgs.toList()}"

    companion object { const val MODE_PRIVATE = 0 }
}

open class ContentResolver { open fun openOutputStream(uri: Uri, mode: String): OutputStream? = null }

class ActivityNotFoundException(message: String?) : RuntimeException(message)

open class Intent(val action: String? = null) {
    var type: String? = null
    var data: Uri? = null
    var flags: Int = 0
        private set
    fun addCategory(category: String): Intent = this
    fun putExtra(name: String, value: String?): Intent = this
    fun putExtra(name: String, value: Boolean): Intent = this
    fun addFlags(value: Int): Intent { flags = flags or value; return this }
    companion object {
        const val ACTION_CREATE_DOCUMENT = "android.intent.action.CREATE_DOCUMENT"
        const val CATEGORY_OPENABLE = "android.intent.category.OPENABLE"
        const val EXTRA_TITLE = "android.intent.extra.TITLE"
        const val EXTRA_LOCAL_ONLY = "android.intent.extra.LOCAL_ONLY"
        const val FLAG_GRANT_READ_URI_PERMISSION = 1
        const val FLAG_GRANT_WRITE_URI_PERMISSION = 2
        const val FLAG_ACTIVITY_NEW_TASK = 0x10000000
        const val FLAG_ACTIVITY_SINGLE_TOP = 0x20000000
    }
}

class ComponentName(val context: Context, val cls: Class<*>)
