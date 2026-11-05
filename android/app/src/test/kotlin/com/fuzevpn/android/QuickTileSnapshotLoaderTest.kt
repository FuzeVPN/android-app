package com.fuzevpn.android

import kotlin.coroutines.ContinuationInterceptor
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.NonCancellable
import kotlinx.coroutines.currentCoroutineContext
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.runCurrent
import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.withContext
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class QuickTileSnapshotLoaderTest {
    @Test fun storageRunsOnIoAndDeliveryReturnsToTheUiScope() = runTest {
        val io = StandardTestDispatcher(testScheduler, "tile-storage")
        val ui = currentCoroutineContext()[ContinuationInterceptor]
        var read = false
        var delivered = false
        val loader = QuickTileSnapshotLoader(
            scope = this,
            ioDispatcher = io,
            load = {
                assertEquals(io, currentCoroutineContext()[ContinuationInterceptor])
                read = true
                "snapshot"
            },
            deliver = {
                // Delivery is a scope callback; it is not running inside the
                // storage dispatcher used above.
                assertTrue(read)
                assertEquals("snapshot", it)
                delivered = true
            },
        )
        assertTrue(ui != io)
        loader.startListening()
        assertFalse(read)
        assertFalse(delivered)
        runCurrent()
        assertTrue(delivered)
        loader.stopListening()
    }

    @Test fun stopListeningDiscardsAnAlreadyRunningStorageResult() = runTest {
        val releaseRead = CompletableDeferred<Unit>()
        var reads = 0
        val delivered = mutableListOf<String>()
        val loader = QuickTileSnapshotLoader(
            scope = this,
            ioDispatcher = StandardTestDispatcher(testScheduler),
            load = {
                reads++
                // Android Keystore may finish after coroutine cancellation.
                withContext(NonCancellable) { releaseRead.await() }
                "obsolete"
            },
            deliver = delivered::add,
        )
        loader.startListening()
        runCurrent()
        assertEquals(1, reads)
        loader.stopListening()
        releaseRead.complete(Unit)
        runCurrent()
        assertTrue(delivered.isEmpty())
    }

    @Test fun newerStateWinsWhenAnOlderReadFinishesLast() = runTest {
        val oldRead = CompletableDeferred<Unit>()
        var reads = 0
        val delivered = mutableListOf<String>()
        val loader = QuickTileSnapshotLoader(
            scope = this,
            ioDispatcher = StandardTestDispatcher(testScheduler),
            load = {
                if (++reads == 1) {
                    withContext(NonCancellable) { oldRead.await() }
                    "old-connected"
                } else "new-disconnected"
            },
            deliver = delivered::add,
        )
        loader.startListening()
        runCurrent()
        loader.refresh()
        runCurrent()
        assertEquals(listOf("new-disconnected"), delivered)
        oldRead.complete(Unit)
        runCurrent()
        assertEquals(listOf("new-disconnected"), delivered)
        loader.stopListening()
    }

    @Test fun stoppedServiceDoesNotReadAndCanListenAgain() = runTest {
        var reads = 0
        val delivered = mutableListOf<Int>()
        val loader = QuickTileSnapshotLoader(
            scope = this,
            ioDispatcher = StandardTestDispatcher(testScheduler),
            load = { ++reads },
            deliver = delivered::add,
        )
        loader.refresh()
        runCurrent()
        assertEquals(0, reads)
        loader.startListening()
        runCurrent()
        loader.stopListening()
        loader.refresh()
        runCurrent()
        assertEquals(listOf(1), delivered)
        loader.startListening()
        runCurrent()
        assertEquals(listOf(1, 2), delivered)
        loader.stopListening()
    }
}
