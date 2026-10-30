package android.service.quicksettings

import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import java.util.Collections
import java.util.concurrent.atomic.AtomicInteger

class Tile {
    var state: Int = STATE_INACTIVE
    var label: CharSequence? = null
    var subtitle: CharSequence? = null
    var stateDescription: CharSequence? = null
    fun updateTile() { TileService.updates += "${state}:${subtitle}" }
    companion object {
        const val STATE_UNAVAILABLE = 0
        const val STATE_INACTIVE = 1
        const val STATE_ACTIVE = 2
    }
}

open class TileService : Context() {
    val qsTile: Tile? get() = tile
    open fun onStartListening() {}
    open fun onStopListening() {}
    open fun onClick() {}
    open fun onDestroy() {}
    fun unlockAndRun(runnable: Runnable) = runnable.run()
    fun startActivityAndCollapse(pendingIntent: PendingIntent) {
        if (pendingIntent.intent.action == missingLaunch) throw android.content.ActivityNotFoundException(pendingIntent.intent.action)
        launches += "pending:" + pendingIntent.intent.action
    }
    @Deprecated("Android 14") fun startActivityAndCollapse(intent: Intent) {
        if (intent.action == missingLaunch) throw android.content.ActivityNotFoundException(intent.action)
        launches += "intent:" + intent.action
    }

    companion object {
        @Volatile var tile: Tile? = Tile()
        val launches: MutableList<String> = Collections.synchronizedList(mutableListOf())
        val updates: MutableList<String> = Collections.synchronizedList(mutableListOf())
        val listeningRequests = AtomicInteger()
        /**
         * StatusBarManagerService on android13-release, -qpr1 and -qpr2 throws
         * IllegalArgumentException for a process outside the current user
         * (REQUEST_LISTENING_MUST_MATCH_PACKAGE); qpr3 and Android 14+ ignore it.
         */
        @Volatile var listeningFailure: RuntimeException? = null
        @Volatile var onListeningRequest: (() -> Unit)? = null
        /** Models a device without the activity behind a tile launch. */
        @Volatile var missingLaunch: String? = null
        @JvmStatic fun requestListeningState(context: Context, component: ComponentName) {
            listeningRequests.incrementAndGet()
            onListeningRequest?.invoke()
            listeningFailure?.let { throw it }
        }
        fun reset() {
            tile = Tile(); launches.clear(); updates.clear(); listeningRequests.set(0); listeningFailure = null
            onListeningRequest = null; missingLaunch = null
        }
    }
}
