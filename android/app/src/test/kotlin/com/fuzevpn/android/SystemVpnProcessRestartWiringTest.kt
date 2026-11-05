package com.fuzevpn.android

import java.io.File
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Permanent VPN after a process death (campaign 74018, P2). ActivityManager restarts an
 * unbound sticky service, never the VPN host Android unbound first. The bridge-host suite
 * fakes that service and SharedVpnHost, so the Android wiring is pinned in the source here.
 */
class SystemVpnProcessRestartWiringTest {
    private fun source(path: String): String = listOf("src/main", "android/app/src/main")
        .map { File(it, path) }
        .first { it.isFile }
        .readText()

    private fun kotlin(name: String) = source("kotlin/com/fuzevpn/android/$name")
    private val bridge = kotlin("AndroidVpnBridge.kt")
    private val sentinel = kotlin("SystemVpnResumeSentinel.kt")
    private val host = kotlin("SharedVpnHost.kt")

    @Test fun theSentinelIsAPrivateUnboundBackgroundService() {
        val manifest = source("AndroidManifest.xml")
        val at = manifest.indexOf("android:name=\"com.fuzevpn.android.SystemVpnResumeSentinel\"")
        assertTrue(manifest, at >= 0)
        val entry = manifest.substring(manifest.lastIndexOf("<service", at), manifest.indexOf("/>", at) + 2)
        assertTrue(entry, entry.contains("android:exported=\"false\""))
        assertTrue(entry, entry.contains("android:stopWithTask=\"false\""))
        assertFalse(entry, entry.contains("foregroundServiceType"))
        assertFalse(entry, entry.contains("permission"))
        assertFalse(entry, entry.contains("intent-filter"))
    }

    @Test fun onlyARestartThisProcessDidNotRequestRestores() {
        val start = block(sentinel, "override fun onStartCommand(")
        assertTrue(start, start.contains("return START_STICKY"))
        assertTrue(start, start.contains("if (intent == null) requestRestore(applicationContext)"))
        // Android 10-13 may drop the null start of a restarted service; onCreate still runs.
        assertTrue(block(sentinel, "override fun onCreate()").contains("if (desired == null) requestRestore(applicationContext)"))
        val request = block(sentinel, "private fun requestRestore(context: Context)")
        val once = request.indexOf("restoreRequested.compareAndSet(false, true)")
        assertTrue(request, once >= 0 && once < request.indexOf(".onProcessRestart()"))
        assertFalse(sentinel, sentinel.contains("startForeground"))
    }

    // Campaign vm31o, Android 12: after a death, ActivityManager restarted the quick settings tile
    // first, then dropped the idle uid's pending restart of the sentinel ("Stopping service due to
    // app idle"), which was never created: no restore in 2 deaths of 3. Any process start of a
    // process that died armed restores, through the same once-per-process request.
    @Test fun aProcessThatDiedArmedRestoresWhicheverComponentStartsIt() {
        val application = block(host, "    override fun onCreate() {")
        val obtain = application.indexOf("AndroidVpnBridge.obtain(this)")
        assertTrue(application, obtain >= 0 && application.indexOf("SystemVpnResumeSentinel.restoreAfterDeath(this)") > obtain)
        val after = block(sentinel, "fun restoreAfterDeath(context: Context)")
        val consumed = after.indexOf("forgetArmed(context)")
        val decided = after.indexOf("val restore = diedUnintendedlyMomentsAgo(context)")
        assertTrue(after, after.indexOf("if (!wasArmed(context)) return") in 0 until consumed && decided > consumed &&
            after.indexOf("if (restore) requestRestore(context)") > decided)
        // Review vm31p: a force stop, a user stop or an update is never followed by a restart:
        // only an unintended death of the main process a moment ago (ProcessRestartExitTest).
        // Review vm31r: the WebView renderer's exit is filed under the package too, so every
        // record is read and the main process's newest one decides.
        val died = block(sentinel, "private fun diedUnintendedlyMomentsAgo(context: Context): Boolean")
        assertTrue(died, died.contains("if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return false") &&
            died.contains("getHistoricalProcessExitReasons(context.packageName, 0, 0)") &&
            died.contains("mainProcessDiedUnintendedly(exits, context.applicationInfo.processName, System.currentTimeMillis())"))
        // The marker follows exactly what the worker applied, armed or disarmed.
        val sync = block(sentinel, "fun sync(context: Context, armed: Boolean)")
        val applied = sync.indexOf("applied = target")
        assertTrue(sync, applied >= 0 && sync.indexOf("rememberArmed(app, target)") > applied)
        assertTrue(block(sentinel, "fun renewArmed(context: Context)").contains("worker.execute { if (applied == true) rememberArmed(app, true) }"))
        assertTrue(sentinel, sentinel.split("rememberArmed(").size == 4)
        // Unreadable: not armed, never a crash in Application.onCreate.
        val read = sentinel.substring(sentinel.indexOf("private fun wasArmed(context: Context)"), sentinel.indexOf("private fun rememberArmed("))
        assertTrue(read, read.contains("} catch (_: Exception) {") && read.contains("false"))
    }

    // Review vm31r: a force stop made while the process is already dead records no exit, and a
    // file marker survived it. The mark is a pending job instead: a force stop cancels every job
    // of the package, so no later start restores.
    @Test fun theMarkIsAJobThatAForceStopCancels() {
        val read = block(sentinel, "private fun wasArmed(context: Context): Boolean")
        assertTrue(read, read.contains("getPendingJob(ARMED_JOB)") && read.contains("?.service?.className == SystemVpnRestartMark::class.java.name"))
        assertTrue(block(sentinel, "private fun forgetArmed(context: Context)").contains(".cancel(ARMED_JOB)"))
        val remember = block(sentinel, "private fun rememberArmed(context: Context, armed: Boolean)")
        assertTrue(remember, remember.contains("jobs.cancel(ARMED_JOB)") && remember.contains(".setMinimumLatency(ARMED_JOB_DELAY_MS)"))
        // Never persisted: a boot forgets it, as Android's own permanent VPN start covers the boot.
        assertFalse(sentinel, sentinel.contains("setPersisted") || sentinel.contains("getSharedPreferences"))
        val job = block(sentinel, "override fun onStartJob(params: JobParameters?): Boolean")
        assertTrue(job, job.contains("SystemVpnResumeSentinel.renewArmed(applicationContext)") && job.contains("return false"))
        val manifest = source("AndroidManifest.xml")
        val at = manifest.indexOf("android:name=\"com.fuzevpn.android.SystemVpnRestartMark\"")
        assertTrue(manifest, at >= 0)
        val entry = manifest.substring(manifest.lastIndexOf("<service", at), manifest.indexOf("/>", at) + 2)
        assertTrue(entry, entry.contains("android:exported=\"false\"") && entry.contains("android:permission=\"android.permission.BIND_JOB_SERVICE\""))
        assertFalse(entry, entry.contains("intent-filter"))
    }

    @Test fun activityManagerIsCalledOnlyFromTheWorker() {
        val sync = block(sentinel, "fun sync(context: Context, armed: Boolean)")
        val worker = sync.indexOf("worker.execute {")
        assertTrue(sync, worker >= 0)
        assertTrue(sync, sync.indexOf("startService(") > worker && sync.indexOf("stopService(") > worker)
        assertTrue(sentinel, sentinel.split("startService(").size == 2 && sentinel.split("stopService(").size == 2)
    }

    @Test fun everyDurableResumeWriteUpdatesTheArming() {
        assertTrue(bridge.contains("writeRaw = { writeSlot(SecureStorageKeyPolicy.systemVpnResume(), it); noteDurableResume(it) }"))
        val renewal = bridge.substring(bridge.indexOf("resumeRegistry.renewSession("), bridge.indexOf("resumeState = if (ready)"))
        assertTrue(renewal, renewal.contains("noteDurableResume(encodedResume)"))
    }

    @Test fun aHostLossDisarmsBeforeAnythingIsPosted() {
        for (event in listOf("\"onHostRevoked\" -> {", "\"onHostDestroyed\" -> {")) {
            val body = block(host, event)
            val hold = body.indexOf("holdProcessRestart()")
            assertTrue(body, hold >= 0 && hold < body.indexOf("callbackHandler.post"))
            assertTrue(body, body.contains("else release()"))
        }
    }

    @Test fun commandsDisarmAtReceiptAndTheRestoreChecksBeforeActing() {
        val call = block(bridge, "override fun onMethodCall(call: MethodCall, result: MethodChannel.Result)")
        val hold = call.indexOf("ReleasingResult(result, holdProcessRestart())")
        assertTrue(call, hold >= 0 && hold < call.indexOf("cancelSystemStart()"))
        val byUser = call.substring(call.indexOf("\"disconnectByUser\" ->"))
        assertTrue(byUser, byUser.indexOf("holdProcessRestart()") in 0 until byUser.indexOf("cancelSystemStart()"))
        val tile = block(bridge, "internal fun toggleFromQuickTile(")
        assertTrue(tile, tile.indexOf("holdProcessRestart()") in 0 until tile.indexOf("cancelSystemStart()"))
        assertTrue(tile, tile.contains(".invokeOnCompletion { release() }"))
        val restore = block(bridge, "private fun startSystemRestore(selfStarted: Boolean)")
        val reserve = restore.indexOf("resumeRegistry.reserve(")
        assertTrue(restore, reserve >= 0 && reserve < restore.indexOf("SharedVpnHost.start(appContext)"))
        val ours = restore.indexOf("if (selfStarted) checkPermanentVpnStillOurs()")
        val prepare = restore.indexOf("ensureVpnAuthorized(publishFailure = !selfStarted)")
        assertTrue(restore, ours >= 0 && ours < prepare)
        // The supersede check and the end of "unreserved" are one step, right before reserving.
        val handOver = restore.indexOf("if (systemStartJob !== job) throw CancellationException")
        assertTrue(restore, handOver in prepare until reserve)
        assertTrue(restore, restore.indexOf("processRestartUnreserved = false", handOver) in handOver until reserve)
        val eligible = restore.indexOf("checkProcessRestartEligible(")
        assertTrue(restore, eligible >= 0 && eligible < reserve)
        // A VPN of another profile is listed by allNetworks but never revoked by prepare().
        assertTrue(block(bridge, "private fun foreignVpnPresent()").contains("connectivity.activeNetwork"))
        assertTrue(bridge.contains("private fun syncProcessRestart() = synchronized(processRestartSyncLock)"))
        // NetworkCapabilities.getOwnerUid exists only from Android 11; the restart runs from 10.
        assertFalse(bridge, bridge.contains("ownerUid"))
    }

    /** The braces-balanced body that follows [start]; these bodies hold no brace in a string. */
    private fun block(source: String, start: String): String {
        val at = source.indexOf(start)
        assertTrue("missing: $start", at >= 0)
        val open = source.indexOf('{', at)
        var depth = 0
        for (index in open until source.length) {
            when (source[index]) {
                '{' -> depth += 1
                '}' -> if (--depth == 0) return source.substring(at, index + 1)
            }
        }
        throw AssertionError("unbalanced: $start")
    }
}
