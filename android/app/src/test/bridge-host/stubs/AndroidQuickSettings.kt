package android.service.quicksettings

import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import java.util.Collections
import java.util.concurrent.atomic.AtomicInteger
import kotlinx.coroutines.android.HarnessMain

class Tile {
    var state: Int = STATE_INACTIVE
    var label: CharSequence? = null
    var subtitle: CharSequence? = null
    var stateDescription: CharSequence? = null
    fun updateTile() {
        val update = "${state}:${subtitle}"
        TileService.updates += update
        TileService.afterTileUpdate(update)
    }
    companion object {
        const val STATE_UNAVAILABLE = 0
        const val STATE_INACTIVE = 1
        const val STATE_ACTIVE = 2
    }
}

open class TileService : Context() {
    init { instances += this }
    val qsTile: Tile? get() = tile
    /** SystemUI model only: TileService.H's listening flag for this instance (main thread). */
    @Volatile var harnessListening = false
        private set
    open fun onStartListening() {}
    open fun onStopListening() {}
    open fun onClick() {}
    open fun onDestroy() {}
    /** TileService.H drops MSG_START_LISTENING while this instance already listens. */
    fun dispatchStartListening() {
        if (harnessListening) { swallowedStarts.incrementAndGet(); return }
        harnessListening = true
        onStartListening()
    }
    fun dispatchStopListening() {
        if (!harnessListening) return
        harnessListening = false
        onStopListening()
    }
    /** CustomTile.handleClick: no click on STATE_UNAVAILABLE; an active tile listens before its click. */
    fun dispatchClick() {
        if (qsTile?.state == Tile.STATE_UNAVAILABLE) { droppedClicks.incrementAndGet(); return }
        dispatchStartListening()
        onClick()
    }
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
            if (systemUi) {
                bound?.let { service -> HarnessMain.post { service.dispatchStartListening() } }
                afterListeningRequest?.invoke()
            }
        }

        /*
         * Opt-in model of SystemUI for an ACTIVE tile (off by default: the
         * tests above only count requests). A listening request posts a START
         * to the bound instance, which TileService.H drops while it listens.
         * TileServiceManager.setLastUpdate stops an active tile after each
         * updateTile; noStopAfterUpdate models a SystemUI that never does.
         */
        @Volatile var systemUi = false
        /** The instance SystemUI is bound to; null drops the request (tile not bound yet). */
        @Volatile var bound: TileService? = null
        /** Holds every STOP that follows an update until releaseStops(). */
        @Volatile var holdStops = false
        /** Holds only the STOP that follows this exact update, once. */
        @Volatile var holdStopAfterUpdate: String? = null
        @Volatile var noStopAfterUpdate = false
        /** Runs on the requesting thread after the START was posted. */
        @Volatile var afterListeningRequest: (() -> Unit)? = null
        val swallowedStarts = AtomicInteger()
        val droppedClicks = AtomicInteger()
        private val heldStops: MutableList<TileService> = mutableListOf()
        private val instances: MutableList<TileService> = Collections.synchronizedList(mutableListOf())

        fun releaseStops() {
            val stops = synchronized(heldStops) { heldStops.toList().also { heldStops.clear() } }
            stops.forEach { service -> HarnessMain.post { service.dispatchStopListening() } }
        }

        internal fun afterTileUpdate(update: String) {
            if (!systemUi || noStopAfterUpdate) return
            val service = bound ?: return
            val holdThis = synchronized(heldStops) {
                (holdStopAfterUpdate == update).also { if (it) holdStopAfterUpdate = null }
            }
            if (holdStops || holdThis) synchronized(heldStops) { heldStops += service }
            else HarnessMain.post { service.dispatchStopListening() }
        }

        fun reset() {
            systemUi = false; bound = null; holdStops = false; holdStopAfterUpdate = null; noStopAfterUpdate = false
            afterListeningRequest = null; onListeningRequest = null; listeningFailure = null
            // A tile service of an earlier test must not render into this one.
            val previous = synchronized(instances) { instances.toList().also { instances.clear() } }
            if (previous.isNotEmpty()) HarnessMain.run { previous.forEach { it.onDestroy() } }
            synchronized(heldStops) { heldStops.clear() }
            tile = Tile(); launches.clear(); updates.clear(); listeningRequests.set(0)
            swallowedStarts.set(0); droppedClicks.set(0); missingLaunch = null
        }
    }
}
