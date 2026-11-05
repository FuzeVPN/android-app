package com.fuzevpn.android

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.ApplicationExitInfo
import android.app.Service
import android.app.job.JobInfo
import android.app.job.JobParameters
import android.app.job.JobScheduler
import android.app.job.JobService
import android.content.ComponentName
import android.content.Context
import android.os.Build
import android.content.Intent
import android.os.IBinder
import android.util.Log
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicBoolean

// ActivityManager restarts a crashed sticky service within about a minute (backoff).
private const val RESTART_HORIZON_MS = 120_000L

// Deaths ActivityManager follows with a sticky restart. A force stop, a user stop, an update or an
// exit of the app's own are never followed by one (review vm31p). A revoked permission (on Android
// 13+, turning the app's notifications off) and a dead provider host are (review vm31r).
// Plain ints inlined at compile time, and only consulted on Android 11+.
@SuppressLint("InlinedApi")
private val UNINTENDED_EXITS = setOf(
    ApplicationExitInfo.REASON_CRASH, ApplicationExitInfo.REASON_CRASH_NATIVE,
    ApplicationExitInfo.REASON_SIGNALED, ApplicationExitInfo.REASON_LOW_MEMORY,
    ApplicationExitInfo.REASON_ANR, ApplicationExitInfo.REASON_EXCESSIVE_RESOURCE_USAGE,
    ApplicationExitInfo.REASON_PERMISSION_CHANGE, ApplicationExitInfo.REASON_DEPENDENCY_DIED,
)

/** A past exit of a process of this package, as ActivityManager records them. */
internal data class PastExit(val processName: String?, val reason: Int, val timestampMs: Long)

/**
 * Whether the main process died a moment ago in a way ActivityManager follows with a restart.
 * Other processes are filed under the package too (the WebView renderer of the Turnstile
 * challenge) and die right after the main one for their own reasons: they are skipped. The
 * newest is picked by time: Android 11 sorts the list with an int-cast comparator that puts a
 * record 25 to 50 days older first (review vm31r).
 */
internal fun mainProcessDiedUnintendedly(exits: List<PastExit>, mainProcess: String, nowMs: Long): Boolean {
    val exit = exits.filter { it.processName == mainProcess }.maxByOrNull { it.timestampMs } ?: return false
    return exit.reason in UNINTENDED_EXITS && nowMs - exit.timestampMs in 0..RESTART_HORIZON_MS
}

/**
 * Never does any work: its pending job is the durable mark that the process is armed. Unlike a
 * file, a force stop cancels it even when the process is already dead (review vm31r).
 */
class SystemVpnRestartMark : JobService() {
    override fun onStartJob(params: JobParameters?): Boolean {
        // Ran after its long delay: renewed while this process is still armed.
        SystemVpnResumeSentinel.renewArmed(applicationContext)
        return false
    }

    override fun onStopJob(params: JobParameters?): Boolean = false
}

/**
 * ActivityManager restart point for Android's permanent VPN after a process death.
 * When the process dies, Android's Vpn unbinds the dead VPN host first and the host's
 * record is then not restarted, even when it is sticky. This unbound, never-foreground
 * START_STICKY service is restarted instead. It does no work itself and runs only while a
 * death would be followed by a restore.
 */
class SystemVpnResumeSentinel : Service() {
    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        running = true
        // Android 10 to 13 can stop the sticky restart of a just-started (idle) uid before its
        // null start command; onCreate still runs. A creation this process never asked for is
        // ActivityManager's restart after a death.
        if (desired == null) requestRestore(applicationContext)
    }

    override fun onDestroy() {
        running = false
        super.onDestroy()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // A null intent is ActivityManager's sticky restart after a process death. The arming
        // start carries an intent and does nothing.
        if (intent == null) requestRestore(applicationContext)
        return START_STICKY
    }

    companion object {
        private const val LOG_TAG = "FuzeVpnBridge"
        private const val ACTION_ARM = "com.fuzevpn.android.action.ARM_PROCESS_RESTART"
        // The mark's job; its service is checked too, as a library may draw any job id.
        internal const val ARMED_JOB = 0x46555a45
        private val ARMED_JOB_DELAY_MS = TimeUnit.DAYS.toMillis(30)
        // One worker: ActivityManager is never called on a caller's thread or under a bridge
        // lock, and a later decision can never be overtaken by an earlier one.
        private val worker = Executors.newSingleThreadExecutor { task ->
            Thread(task, "fuzevpn-restart-anchor").apply { isDaemon = true }
        }
        private val restoreRequested = AtomicBoolean()
        @Volatile private var desired: Boolean? = null
        @Volatile private var applied: Boolean? = null
        @Volatile private var running = false

        /**
         * Called when the process starts, for whichever component. After a death, Android 10 to
         * 13 restart this service and the quick settings tile 10 s apart; when the tile comes
         * first, the idle uid's pending restart of this service is dropped ("Stopping service
         * due to app idle") and it is never created (campaign vm31o, Android 12, 2 deaths of 3).
         * Armed when the previous process died, the restore starts from here instead, but only
         * after an unintended death a moment ago: never after a force stop, a user stop or an
         * update, which ActivityManager itself never follows with a restart (review vm31p). A
         * force stop made after the death leaves no exit record, but cancels the mark (vm31r).
         */
        fun restoreAfterDeath(context: Context) {
            if (!wasArmed(context)) return
            // Consumed once: a later process start never acts on this death again.
            forgetArmed(context)
            val restore = diedUnintendedlyMomentsAgo(context)
            Log.i(LOG_TAG, if (restore) "Permanent VPN restart mark: unintended exit" else "Permanent VPN restart mark: not after this exit")
            if (restore) requestRestore(context)
        }

        // Android 11 records why the previous process ended. Android 10 does not: there, only the
        // sentinel's own restart restores, as before.
        private fun diedUnintendedlyMomentsAgo(context: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return false
            val exits = try {
                context.getSystemService(ActivityManager::class.java)
                    ?.getHistoricalProcessExitReasons(context.packageName, 0, 0)
                    ?.map { PastExit(it.processName, it.reason, it.timestamp) }
            } catch (_: Exception) {
                null
            } ?: return false
            return mainProcessDiedUnintendedly(exits, context.applicationInfo.processName, System.currentTimeMillis())
        }

        /** At most once per process: the process start, onCreate and the null start may all report it. */
        private fun requestRestore(context: Context) {
            if (!restoreRequested.compareAndSet(false, true)) return
            Log.i(LOG_TAG, "Permanent VPN process restart")
            AndroidVpnBridge.obtain(context.applicationContext).onProcessRestart()
        }

        // The mark is a pending job: a force stop cancels every job of the package, and a boot
        // forgets it, as Android's own permanent VPN start covers the boot.
        private fun wasArmed(context: Context): Boolean = try {
            context.getSystemService(JobScheduler::class.java)?.getPendingJob(ARMED_JOB)
                ?.service?.className == SystemVpnRestartMark::class.java.name
        } catch (_: Exception) {
            false
        }

        private fun forgetArmed(context: Context) {
            try {
                context.getSystemService(JobScheduler::class.java)?.cancel(ARMED_JOB)
            } catch (_: Exception) {
                // Nothing was armed either.
            }
        }

        private fun rememberArmed(context: Context, armed: Boolean) {
            try {
                val jobs = context.getSystemService(JobScheduler::class.java) ?: return
                if (!armed) {
                    jobs.cancel(ARMED_JOB)
                } else {
                    val mark = JobInfo.Builder(ARMED_JOB, ComponentName(context, SystemVpnRestartMark::class.java))
                        .setMinimumLatency(ARMED_JOB_DELAY_MS).build()
                    if (jobs.schedule(mark) != JobScheduler.RESULT_SUCCESS) Log.w(LOG_TAG, "Permanent VPN restart mark refused")
                }
            } catch (_: Exception) {
                // The sentinel still covers a restart that does create it.
                Log.w(LOG_TAG, "Permanent VPN restart mark refused")
            }
        }

        /** The mark's job ran after its long delay: renewed while this process is still armed. */
        fun renewArmed(context: Context) {
            val app = context.applicationContext
            worker.execute { if (applied == true) rememberArmed(app, true) }
        }

        /** Records the wanted state; the worker applies the latest one. */
        fun sync(context: Context, armed: Boolean) {
            val app = context.applicationContext
            desired = armed
            worker.execute {
                val target = desired ?: return@execute
                // Running is checked too: ActivityManager may have stopped the service itself.
                if (target == applied && target == running) return@execute
                val intent = Intent(app, SystemVpnResumeSentinel::class.java)
                try {
                    if (target) app.startService(intent.setAction(ACTION_ARM)) else app.stopService(intent)
                    applied = target
                    rememberArmed(app, target)
                    Log.i(LOG_TAG, if (target) "Permanent VPN restart armed" else "Permanent VPN restart disarmed")
                } catch (_: IllegalStateException) {
                    applied = null
                    Log.w(LOG_TAG, "Permanent VPN restart anchor refused")
                } catch (_: SecurityException) {
                    applied = null
                    Log.w(LOG_TAG, "Permanent VPN restart anchor refused")
                }
            }
        }
    }
}
