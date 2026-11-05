package com.fuzevpn.android

import java.io.File
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * The shared host's onCreate() publishes it just before startForeground(), and its onDestroy()
 * clears it before resetting the readiness GoBackend.startHost() reads. Stopped in the first gap,
 * Android 8 to 11 kill the app; started in the second, nothing starts (campaign vm31n). The bridge
 * starts and stops the host from worker threads, so both run on the main thread, where those
 * callbacks run whole, and a stop waits for onDestroy() to end. Host-side suites fake
 * SharedVpnHost, so the wiring is pinned in the source.
 */
class SharedVpnHostStopWiringTest {
    private val host = listOf("src/main/kotlin", "android/app/src/main/kotlin")
        .map { File(it, "com/fuzevpn/android/SharedVpnHost.kt") }
        .first { it.isFile }
        .readText()

    @Test fun theHostIsStartedAndStoppedOnlyOnTheMainThread() {
        assertEquals(1, host.split("getMethod(\"startHost\"").size - 1)
        assertEquals(1, host.split("getMethod(\"stopHost\")").size - 1)
        val start = block("    fun start(context: Context) {")
        assertTrue(start, start.contains("onMainThread(HOST_START_WAIT_MS) {") &&
            start.indexOf("getMethod(\"startHost\"") > start.indexOf("onMainThread(HOST_START_WAIT_MS) {"))
        val stop = block("    fun stopIfNotPermanent() {")
        assertTrue(stop, stop.contains("onMainThread(HOST_STOP_WAIT_MS) { stopIfNotPermanentNow() }"))
        assertTrue(block("    private fun stopIfNotPermanentNow(): CountDownLatch? {").contains("getMethod(\"stopHost\")"))
        val main = block("    private fun <T> onMainThread(timeoutMillis: Long, block: () -> T): T? {")
        assertTrue(main, main.contains("if (Looper.myLooper() == Looper.getMainLooper()) return block()") &&
            main.contains("callbackHandler.post {") && main.contains("runCatching(block)"))
        // Review: a timed-out hop must not start or stop the host after the caller gave up.
        assertTrue(main, main.contains("if (state.compareAndSet(PENDING, RUNNING)) {") &&
            main.contains("if (state.compareAndSet(PENDING, CANCELLED)) return null") &&
            main.indexOf("done.await()") > main.indexOf("compareAndSet(PENDING, CANCELLED)"))
        // A running host this app is not stopping is used as it is, without a main-thread hop.
        assertTrue(start, start.indexOf("if (current() != null && stopping.let { it == null || it.count == 0L }) return") in
            0 until start.indexOf("onMainThread(HOST_START_WAIT_MS)"))
    }

    @Test fun aStopWaitsForTheEndOfOnDestroy() {
        val now = block("    private fun stopIfNotPermanentNow(): CountDownLatch? {")
        assertTrue(now, now.indexOf("stopping = it") in 0 until now.indexOf("getMethod(\"stopHost\")"))
        val stop = block("    fun stopIfNotPermanent() {")
        assertTrue(stop, stop.contains("if (Looper.myLooper() != Looper.getMainLooper()) destroyed?.await(HOST_STOP_WAIT_MS, TimeUnit.MILLISECONDS)"))
        // GoBackend notifies onHostDestroyed at the end of onDestroy(), after the readiness reset;
        // the stopper resumes only after this host's loss is captured (review).
        val destroyed = block("                \"onHostDestroyed\" -> {")
        assertTrue(destroyed, destroyed.indexOf("stopping?.countDown()") > destroyed.indexOf("runtime.captureHostLoss()") &&
            destroyed.indexOf("stopping?.countDown()") > destroyed.indexOf("callbackHandler.post {"))
    }

    /** The braces-balanced body that follows [start]; these bodies hold no brace in a string. */
    private fun block(start: String): String {
        val at = host.indexOf(start)
        assertTrue("missing: $start", at >= 0)
        val open = host.indexOf('{', at)
        var depth = 0
        for (index in open until host.length) {
            when (host[index]) {
                '{' -> depth += 1
                '}' -> if (--depth == 0) return host.substring(at, index + 1)
            }
        }
        throw AssertionError("unbalanced: $start")
    }
}
