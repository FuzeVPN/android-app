package com.fuzevpn.android.openvpn

import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException
import java.util.concurrent.atomic.AtomicInteger
import org.junit.After
import org.junit.Assert.*
import org.junit.Test

/**
 * A09-01: once `disconnect()` stopped waiting for a JNI destroy that then
 * completed, every `getOrCreateCsr` was refused with `openvpn_identity_in_use`
 * although JNI had already removed the session. A check of whether a native
 * session may still run must consume that late proof first, never issue a
 * second destroy, and keep refusing while a session may really run.
 */
class OwnedNativeOperationsTest {
    private val executor = Executors.newSingleThreadExecutor { Thread(it, "owned-native-test").apply { isDaemon = true } }
    private val registry = ConcurrentHashMap.newKeySet<Long>()
    private val destroys = AtomicInteger()

    private class Controller(handle: Long = 0L) : OwnedNativeOperations.Owner {
        override var nativeHandle = handle
        override var operationUncertain = false
        override var pendingCreation: OwnedNativeHandleCreation? = null
        override var pendingDestruction: OwnedNativeHandleDestruction? = null
        val released = mutableListOf<Boolean>()
        override fun released(destroyed: Boolean) { released += destroyed }
    }

    @After fun shutdown() { executor.shutdownNow() }

    /** A connected session: JNI registered the handle and the controller claimed it. */
    private fun connected(handle: Long = 42L) = Controller(handle).also { registry += handle }

    /** stopCurrentLocked() after an accepted Stop: the controller owns this destroy. */
    private fun Controller.destroy(
        release: CountDownLatch? = null,
        accepted: () -> Boolean = { true },
    ): OwnedNativeHandleDestruction {
        val handle = nativeHandle
        return OwnedNativeHandleDestruction(executor, handle) {
            destroys.incrementAndGet()
            if (release != null) assertTrue("destroy barrier timed out", release.await(5, TimeUnit.SECONDS))
            accepted() && registry.remove(handle)
        }.also { pendingDestruction = it }
    }

    @Test fun destroyCompletedAfterTheStopGaveUpNoLongerKeepsTheIdentityInUse() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        val release = CountDownLatch(1)
        val proof = controller.destroy(release)
        // disconnect() returns false: the stop's bounded wait expired first.
        assertEquals(OwnedNativeOperations.Destruction.PENDING, operations.reconcileDestruction())
        assertSame(proof, controller.pendingDestruction)
        assertEquals(42L, controller.nativeHandle)
        assertTrue(controller.operationUncertain)
        release.countDown()
        assertTrue(proof.awaitCompleted(2_000))
        assertTrue("JNI destroyed the session", registry.isEmpty())

        repeat(3) { attempt -> assertFalse("identity check $attempt", operations.nativeSessionInUse()) }
        assertEquals(0L, controller.nativeHandle)
        assertNull(controller.pendingDestruction)
        assertFalse(controller.operationUncertain)
        assertEquals(listOf(true), controller.released)
        assertEquals(1, destroys.get())
    }

    @Test fun liveSessionStaysInUseWithoutAnyNativeCall() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        repeat(3) { assertTrue(operations.nativeSessionInUse()) }
        assertEquals(42L, controller.nativeHandle)
        assertFalse(controller.operationUncertain)
        assertTrue(registry.contains(42L))
        assertEquals(0, destroys.get())
        assertTrue(controller.released.isEmpty())
    }

    @Test fun destroyStillRunningKeepsTheSameProofForTheNextCheck() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        val release = CountDownLatch(1)
        val proof = controller.destroy(release)
        assertTrue(operations.nativeSessionInUse())
        assertSame(proof, controller.pendingDestruction)
        assertEquals(42L, controller.nativeHandle)
        assertTrue(controller.operationUncertain)
        assertTrue(registry.contains(42L))
        assertTrue(controller.released.isEmpty())
        release.countDown()
        assertTrue(proof.awaitCompleted(2_000))
        assertFalse(operations.nativeSessionInUse())
        assertEquals(listOf(true), controller.released)
        assertEquals(1, destroys.get())
    }

    @Test fun destroyFinishingDuringTheBoundedWaitIsConsumedByThatSameCheck() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 5_000)
        val release = CountDownLatch(1)
        controller.destroy(release)
        val releaser = Thread { Thread.sleep(100); release.countDown() }.apply { isDaemon = true; start() }
        assertFalse(operations.nativeSessionInUse())
        releaser.join(2_000)
        assertEquals(0L, controller.nativeHandle)
        assertTrue(registry.isEmpty())
        assertEquals(1, destroys.get())
    }

    @Test fun refusedOrThrowingDestroyKeepsTheHandleOwnedUntilAConfirmedRetry() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 2_000)
        controller.destroy(accepted = { false })
        assertEquals(OwnedNativeOperations.Destruction.REFUSED, operations.reconcileDestruction())
        assertNull(controller.pendingDestruction)
        assertTrue(operations.nativeSessionInUse())
        controller.pendingDestruction = OwnedNativeHandleDestruction(executor, 42L) {
            destroys.incrementAndGet()
            error("native failure")
        }
        assertTrue(operations.nativeSessionInUse())
        assertNull(controller.pendingDestruction)
        assertEquals(42L, controller.nativeHandle)
        assertTrue(controller.operationUncertain)
        assertTrue(registry.contains(42L))
        assertTrue(controller.released.isEmpty())
        // A later stopCurrentLocked() retries Stop and owns a fresh destroy.
        controller.destroy()
        assertFalse(operations.nativeSessionInUse())
        assertTrue(registry.isEmpty())
        assertEquals(listOf(true), controller.released)
        assertEquals(3, destroys.get())
    }

    @Test fun interruptedCheckKeepsTheProofAndTheInterruptFlag() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 5_000)
        val release = CountDownLatch(1)
        val proof = controller.destroy(release)
        Thread.currentThread().interrupt()
        val inUse = try {
            operations.nativeSessionInUse().also { assertTrue(Thread.currentThread().isInterrupted) }
        } finally {
            Thread.interrupted()
        }
        assertTrue(inUse)
        assertSame(proof, controller.pendingDestruction)
        release.countDown()
        assertTrue(proof.awaitCompleted(2_000))
        assertFalse(operations.nativeSessionInUse())
        assertEquals(1, destroys.get())
    }

    @Test fun abandonedCreationKeepsTheIdentityInUseUntilItsLateHandleIsDestroyed() {
        val controller = Controller()
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        val entered = CountDownLatch(1)
        val returnHandle = CountDownLatch(1)
        val creation = OwnedNativeHandleCreation(executor, create = {
            entered.countDown()
            assertTrue(returnHandle.await(5, TimeUnit.SECONDS))
            registry += 11L
            11L
        }, destroy = { handle -> destroys.incrementAndGet(); registry.remove(handle) })
        assertTrue(entered.await(2, TimeUnit.SECONDS))
        // createNativeHandleLocked(): its bounded wait expired, ownership stays pending.
        assertThrows(TimeoutException::class.java) { creation.awaitCreated(1) }
        controller.pendingCreation = creation
        controller.operationUncertain = true
        assertTrue(operations.nativeSessionInUse())
        assertSame(creation, controller.pendingCreation)
        returnHandle.countDown()
        assertTrue(creation.awaitReleased(2_000))
        assertFalse(operations.nativeSessionInUse())
        assertNull(controller.pendingCreation)
        assertFalse(controller.operationUncertain)
        assertEquals(listOf(false), controller.released)
        assertTrue(registry.isEmpty())
        assertEquals(1, destroys.get())
    }

    @Test fun unconfirmedStopWithoutAnOwnedProofStaysInUse() {
        // Stop itself timed out: no destroy is owned, only a later explicit stop can tell.
        val controller = connected().apply { operationUncertain = true }
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        assertTrue(operations.nativeSessionInUse())
        assertEquals(42L, controller.nativeHandle)
        assertEquals(0, destroys.get())
        assertTrue(controller.released.isEmpty())
    }

    @Test fun idleControllerIsFreeAndReconcilesNothing() {
        val controller = Controller()
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        assertFalse(operations.nativeSessionInUse())
        assertTrue(operations.reconcileCreation())
        assertEquals(OwnedNativeOperations.Destruction.NONE, operations.reconcileDestruction())
        assertTrue(controller.released.isEmpty())
    }

    @Test fun stopPathAwaitIsUsedAndItsTimeoutKeepsTheProof() {
        val controller = connected()
        val operations = OwnedNativeOperations(controller, waitMillis = 50)
        val proof = controller.destroy()
        assertEquals(OwnedNativeOperations.Destruction.PENDING, operations.reconcileDestruction { throw TimeoutException() })
        assertSame(proof, controller.pendingDestruction)
        assertTrue(controller.operationUncertain)
        val awaited = mutableListOf<OwnedNativeHandleDestruction>()
        assertEquals(OwnedNativeOperations.Destruction.DESTROYED,
            operations.reconcileDestruction { awaited += it; it.awaitCompleted(2_000) })
        assertEquals(listOf(proof), awaited)
        assertEquals(0L, controller.nativeHandle)
        assertFalse(controller.operationUncertain)
    }
}
