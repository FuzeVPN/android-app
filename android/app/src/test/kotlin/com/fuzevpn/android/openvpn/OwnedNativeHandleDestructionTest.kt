package com.fuzevpn.android.openvpn

import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference
import org.junit.Assert.*
import org.junit.Test

class OwnedNativeHandleDestructionTest {
    @Test fun timeoutPreservesTheSameLatePositiveProofWithoutDestroyingTwice() {
        val executor = Executors.newSingleThreadExecutor()
        val entered = CountDownLatch(1)
        val complete = CountDownLatch(1)
        val destroys = AtomicInteger()
        try {
            val destruction = OwnedNativeHandleDestruction(executor, 42L) {
                destroys.incrementAndGet()
                entered.countDown()
                assertTrue(complete.await(2, TimeUnit.SECONDS))
                true
            }
            assertTrue(entered.await(2, TimeUnit.SECONDS))
            assertThrows(TimeoutException::class.java) { destruction.awaitCompleted(1) }
            assertThrows(TimeoutException::class.java) { destruction.awaitCompleted(1) }
            complete.countDown()
            assertTrue(destruction.awaitCompleted(2_000))
            assertTrue(destruction.awaitCompleted(2_000))
            assertEquals(1, destroys.get())
        } finally {
            complete.countDown()
            executor.shutdownNow()
        }
    }

    @Test fun interruptionOfTheWaiterDoesNotDiscardDestructionCompletion() {
        val executor = Executors.newSingleThreadExecutor()
        val entered = CountDownLatch(1)
        val complete = CountDownLatch(1)
        val failure = AtomicReference<Throwable>()
        try {
            val destruction = OwnedNativeHandleDestruction(executor, 43L) {
                entered.countDown()
                assertTrue(complete.await(2, TimeUnit.SECONDS))
                true
            }
            val waiter = Thread {
                try { destruction.awaitCompleted(10_000) }
                catch (error: Throwable) { failure.set(error) }
            }.apply { start() }
            assertTrue(entered.await(2, TimeUnit.SECONDS))
            waiter.interrupt()
            waiter.join(2_000)
            assertFalse(waiter.isAlive)
            assertTrue(failure.get() is InterruptedException)
            complete.countDown()
            assertTrue(destruction.awaitCompleted(2_000))
        } finally {
            complete.countDown()
            executor.shutdownNow()
        }
    }

    @Test fun failedOrThrowingDestroyNeverSuppliesAStopProof() {
        val executor = Executors.newSingleThreadExecutor()
        try {
            assertFalse(OwnedNativeHandleDestruction(executor, 44L) { false }.awaitCompleted(2_000))
            assertFalse(OwnedNativeHandleDestruction(executor, 45L) { error("native failure") }.awaitCompleted(2_000))
        } finally { executor.shutdownNow() }
    }
}
