package com.fuzevpn.android

import java.util.concurrent.CountDownLatch
import java.util.concurrent.ExecutionException
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicBoolean
import org.junit.Assert.*
import org.junit.Test

class SessionLifecycleConcurrencyTest {
    @Test fun authenticationPreparationDoesNotDeadlockSystemStartTicketRead() {
        assertPreparationAllowsCallback(activate = true) { gate, ticket -> assertEquals(ticket, gate.ticket()) }
    }

    @Test fun deviceMutationPreparationDoesNotDeadlockRecoveryAdmissionRead() {
        assertPreparationAllowsCallback(activate = false) { gate, ticket -> assertTrue(gate.isCurrent(ticket)) }
    }

    @Test fun logoutDuringPreparationRejectsTheWriteAndDoesNotReactivateTheSession() {
        val gate = SessionLifecycle()
        val ticket = gate.ticket()
        val preparing = CountDownLatch(1)
        val release = CountDownLatch(1)
        val wrote = AtomicBoolean(false)
        val executor = Executors.newSingleThreadExecutor { Thread(it).apply { isDaemon = true } }
        try {
            val write = executor.submit {
                gate.activate(ticket, prepare = { preparing.countDown(); await(release) }) { wrote.set(true) }
            }
            await(preparing)
            gate.beginEnd()
            release.countDown()
            val error = assertThrows(ExecutionException::class.java) { write.get(2, TimeUnit.SECONDS) }
            assertEquals("session_operation_cancelled", (error.cause as VpnNativeException).code)
            assertFalse(wrote.get())
            assertFalse(gate.isCurrent(ticket))
            assertTrue(gate.termination!!.inProgress)
        } finally {
            release.countDown()
            executor.shutdownNow()
        }
    }

    @Test fun staleMutationDoesNotCancelNewSessionWorkDuringPreparation() {
        val gate = SessionLifecycle()
        val old = gate.ticket()
        gate.beginEnd()
        gate.finish(SessionTermination(tunnelStopped = true, sessionCleared = true))
        gate.activate(gate.ticket()) { }
        var prepared = false
        assertThrows(VpnNativeException::class.java) {
            gate.mutate(old, prepare = { prepared = true }) { fail("stale write") }
        }
        assertFalse(prepared)
    }

    private fun assertPreparationAllowsCallback(
        activate: Boolean,
        readSession: (SessionLifecycle, Long) -> Unit,
    ) {
        val gate = SessionLifecycle()
        val ticket = gate.ticket()
        val bridgeLock = Any()
        val preparing = CountDownLatch(1)
        val callbackLocked = CountDownLatch(1)
        val wrote = AtomicBoolean(false)
        val executor = Executors.newFixedThreadPool(2) { Thread(it).apply { isDaemon = true } }
        try {
            val write = executor.submit {
                val prepare = {
                    preparing.countDown()
                    await(callbackLocked)
                    synchronized(bridgeLock) { Unit }
                }
                if (activate) gate.activate(ticket, prepare) { wrote.set(true) }
                else gate.mutate(ticket, prepare) { wrote.set(true) }
            }
            val callback = executor.submit {
                await(preparing)
                synchronized(bridgeLock) {
                    callbackLocked.countDown()
                    readSession(gate, ticket)
                }
            }
            callback.get(2, TimeUnit.SECONDS)
            write.get(2, TimeUnit.SECONDS)
            assertTrue(wrote.get())
            assertTrue(gate.isCurrent(ticket))
        } finally {
            callbackLocked.countDown()
            executor.shutdownNow()
        }
    }

    private fun await(latch: CountDownLatch) {
        assertTrue("concurrency barrier timed out", latch.await(2, TimeUnit.SECONDS))
    }
}
