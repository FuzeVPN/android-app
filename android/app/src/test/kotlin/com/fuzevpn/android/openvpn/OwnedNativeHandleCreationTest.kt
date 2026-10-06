package com.fuzevpn.android.openvpn

import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference
import org.junit.Assert.*
import org.junit.Test

class OwnedNativeHandleCreationTest {
    @Test fun lateResultIsDestroyedBeforeReleaseAndAnotherCreationCanSucceed() {
        val executor = nativeExecutor()
        val entered = CountDownLatch(1)
        val returnHandle = CountDownLatch(1)
        val registry = ConcurrentHashMap.newKeySet<Long>()
        val destroys = AtomicInteger()
        val nativeThread = AtomicReference<Thread>()
        try {
            val creation = OwnedNativeHandleCreation(executor, create = {
                nativeThread.set(Thread.currentThread())
                entered.countDown()
                await(returnHandle)
                registry.add(11L)
                11L
            }, destroy = { handle ->
                assertSame(nativeThread.get(), Thread.currentThread())
                destroys.incrementAndGet()
                registry.remove(handle)
            })
            await(entered)
            assertThrows(TimeoutException::class.java) { creation.awaitCreated(1) }
            assertThrows(TimeoutException::class.java) { creation.awaitReleased(1) }
            assertEquals(0, destroys.get())
            returnHandle.countDown()
            assertTrue(creation.awaitReleased(2_000))
            assertTrue(registry.isEmpty())
            assertEquals(1, destroys.get())
            // Re-reading the release proof must not issue a second destroy.
            assertTrue(creation.awaitReleased(2_000))
            assertEquals(1, destroys.get())

            val next = OwnedNativeHandleCreation(executor,
                create = { registry.add(12L); 12L }, destroy = { destroys.incrementAndGet(); registry.remove(it) })
            val claimed = next.awaitCreated(2_000)
            assertEquals(12L, claimed)
            assertTrue(registry.contains(claimed))
            next.abandon() // Ownership is already the controller's, never destroyed twice.
            assertEquals(1, destroys.get())
            assertTrue(registry.remove(claimed))
        } finally {
            returnHandle.countDown()
            executor.shutdownNow()
        }
    }

    @Test fun abandonedQueuedCreationDoesNotCallJni() {
        val executor = nativeExecutor()
        val blockExecutor = CountDownLatch(1)
        val executorBlocked = CountDownLatch(1)
        val creates = AtomicInteger()
        val destroys = AtomicInteger()
        try {
            executor.execute { executorBlocked.countDown(); await(blockExecutor) }
            await(executorBlocked)
            val creation = OwnedNativeHandleCreation(executor,
                create = { creates.incrementAndGet(); 21L }, destroy = { destroys.incrementAndGet(); true })
            assertThrows(TimeoutException::class.java) { creation.awaitCreated(1) }
            blockExecutor.countDown()
            assertTrue(creation.awaitReleased(2_000))
            assertEquals(0, creates.get())
            assertEquals(0, destroys.get())
        } finally {
            blockExecutor.countDown()
            executor.shutdownNow()
        }
    }

    @Test fun failedDestructionRetainsTheHandleUntilAConfirmedRetry() {
        val executor = nativeExecutor()
        val entered = CountDownLatch(1)
        val returnHandle = CountDownLatch(1)
        val canDestroy = AtomicBoolean(false)
        val registry = ConcurrentHashMap.newKeySet<Long>()
        val destroys = AtomicInteger()
        try {
            val creation = OwnedNativeHandleCreation(executor, create = {
                entered.countDown(); await(returnHandle); registry.add(31L); 31L
            }, destroy = { handle ->
                destroys.incrementAndGet()
                canDestroy.get() && registry.remove(handle)
            })
            await(entered)
            assertThrows(TimeoutException::class.java) { creation.awaitCreated(1) }
            returnHandle.countDown()
            assertFalse(creation.awaitReleased(2_000))
            assertTrue(registry.contains(31L))
            canDestroy.set(true)
            assertTrue(creation.awaitReleased(2_000))
            assertTrue(registry.isEmpty())
            assertTrue(destroys.get() >= 2)
        } finally {
            returnHandle.countDown()
            executor.shutdownNow()
        }
    }

    @Test fun interruptingTheCallerDoesNotAbandonTheNativeResult() {
        val executor = nativeExecutor()
        val entered = CountDownLatch(1)
        val returnHandle = CountDownLatch(1)
        val failure = AtomicReference<Throwable>()
        val destroyed = AtomicInteger()
        try {
            val creation = OwnedNativeHandleCreation(executor, create = {
                entered.countDown(); await(returnHandle); 41L
            }, destroy = { assertEquals(41L, it); destroyed.incrementAndGet(); true })
            val waiter = Thread {
                try { creation.awaitCreated(10_000) }
                catch (error: Throwable) { failure.set(error) }
            }.apply { isDaemon = true; start() }
            await(entered)
            waiter.interrupt()
            waiter.join(2_000)
            assertFalse(waiter.isAlive)
            assertTrue(failure.get() is InterruptedException)
            returnHandle.countDown()
            assertTrue(creation.awaitReleased(2_000))
            assertEquals(1, destroyed.get())
        } finally {
            returnHandle.countDown()
            executor.shutdownNow()
        }
    }

    private fun nativeExecutor() = Executors.newSingleThreadExecutor {
        Thread(it, "native-handle-test").apply { isDaemon = true }
    }

    private fun await(latch: CountDownLatch) {
        assertTrue("native test barrier timed out", latch.await(2, TimeUnit.SECONDS))
    }
}
