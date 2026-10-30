package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnNativeException
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger
import org.junit.After
import org.junit.Assert.*
import org.junit.Test

/**
 * A11-openvpn-kotlin-01: the start Callable observes a user cancellation that
 * arrived after the controller's last check but before the native executor ran
 * it. That decision must reach the bridge as `session_operation_cancelled`, not
 * as an unexpected `openvpn_native_failed`.
 */
class BoundedNativeCallTest {
    private val executor = Executors.newSingleThreadExecutor { Thread(it, "bounded-native-test").apply { isDaemon = true } }
    private val uncertain = AtomicInteger()

    @After fun shutdown() { executor.shutdownNow() }

    private fun <T> call(timeoutMillis: Long = 2_000, block: () -> T): T =
        callBoundedNative(executor, timeoutMillis, { uncertain.incrementAndGet() }, block)

    private fun failure(timeoutMillis: Long = 2_000, block: () -> Any?): VpnNativeException =
        assertThrows(VpnNativeException::class.java) { call(timeoutMillis, block) }

    @Test fun cancellationObservedOnTheNativeExecutorKeepsItsCode() {
        val current = AtomicBoolean(true)
        val starts = AtomicInteger()
        // As in the audit, a task queued ahead of the start Callable widens the window.
        val queued = CountDownLatch(1)
        val releaseQueue = CountDownLatch(1)
        executor.execute { queued.countDown(); releaseQueue.await(5, TimeUnit.SECONDS) }
        assertTrue(queued.await(2, TimeUnit.SECONDS))
        assertTrue("the controller's own check before callNative passed", current.get())
        val canceller = Thread { Thread.sleep(100); current.set(false); releaseQueue.countDown() }
            .apply { isDaemon = true; start() }
        val error = failure {
            if (!current.get()) throw VpnNativeException("session_operation_cancelled")
            starts.incrementAndGet()
            true
        }
        canceller.join(2_000)
        assertEquals("session_operation_cancelled", error.code)
        assertEquals(0, starts.get())
        assertEquals(0, uncertain.get())
    }

    @Test fun anyControllerCodeRaisedInsideTheCallIsPreserved() {
        val cause = VpnNativeException("openvpn_core_unavailable")
        val error = failure { throw cause }
        assertSame(cause, error)
        assertEquals(0, uncertain.get())
    }

    @Test fun unexpectedFailureIsStillANativeFailureWithItsCause() {
        val cause = IllegalStateException("jni wrapper")
        val error = failure { throw cause }
        assertEquals("openvpn_native_failed", error.code)
        assertSame(cause, error.cause)
        // A JVM Error escaping JNI is unexpected as well.
        assertEquals("openvpn_native_failed", failure { throw UnsatisfiedLinkError("fuzevpn_openvpn") }.code)
        assertEquals(0, uncertain.get())
    }

    @Test fun nativeResultIsReturnedWithoutUncertainty() {
        assertTrue(call { true })
        assertFalse(call { false })
        assertEquals(0, uncertain.get())
    }

    @Test fun timeoutMarksTheNativeStateUncertainAndInterruptsTheWorker() {
        val interrupted = CountDownLatch(1)
        val error = failure(timeoutMillis = 50) {
            try { Thread.sleep(5_000) } catch (_: InterruptedException) { interrupted.countDown() }
            true
        }
        assertEquals("openvpn_operation_timeout", error.code)
        assertTrue(error.cause is TimeoutException)
        assertEquals(1, uncertain.get())
        assertTrue(interrupted.await(2, TimeUnit.SECONDS))
    }

    @Test fun cancellationObservedAfterTheTimeoutCannotReplaceTheTimeout() {
        // The caller already reported an uncertain native state; a late decision
        // taken by the queued Callable is not a second answer.
        val releaseQueue = CountDownLatch(1)
        executor.execute { releaseQueue.await(5, TimeUnit.SECONDS) }
        val ran = CountDownLatch(1)
        val error = failure(timeoutMillis = 50) {
            ran.countDown()
            throw VpnNativeException("session_operation_cancelled")
        }
        releaseQueue.countDown()
        assertEquals("openvpn_operation_timeout", error.code)
        assertEquals(1, uncertain.get())
        assertFalse("a cancelled Future never runs its Callable", ran.await(200, TimeUnit.MILLISECONDS))
    }

    @Test fun interruptedCallerMarksUncertainAndKeepsItsInterruptFlag() {
        val release = CountDownLatch(1)
        Thread.currentThread().interrupt()
        val error = try {
            failure { release.await(5, TimeUnit.SECONDS) }.also { assertTrue(Thread.currentThread().isInterrupted) }
        } finally {
            Thread.interrupted()
            release.countDown()
        }
        assertEquals("openvpn_operation_timeout", error.code)
        assertTrue(error.cause is InterruptedException)
        assertEquals(1, uncertain.get())
    }
}
