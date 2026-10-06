package com.fuzevpn.android.openvpn

import java.util.concurrent.CompletableFuture
import java.util.concurrent.ExecutionException
import java.util.concurrent.Executor
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

/**
 * Owns an asynchronous JNI creation until its caller claims the handle or its
 * abandoned result has been destroyed. Interrupting a Future cannot cancel JNI.
 * Creation and destruction both run on the controller's native executor.
 */
internal class OwnedNativeHandleCreation(
    private val executor: Executor,
    create: () -> Long,
    private val destroy: (Long) -> Boolean,
) {
    private val lock = Any()
    private val created = CompletableFuture<Long>()
    private var released = CompletableFuture<Boolean>()
    private var abandoned = false
    private var claimed = false
    private var cleanupScheduled = false
    private var ownedHandle: Long? = null

    init {
        executor.execute {
            // A queued request abandoned before execution needs no JNI session.
            if (synchronized(lock) { abandoned }) completeCreation(0L)
            else {
                val handle = try { create() } catch (error: Throwable) {
                    completeCreation(0L, error)
                    return@execute
                }
                completeCreation(handle)
            }
        }
    }

    fun awaitCreated(timeoutMillis: Long): Long {
        try {
            val handle = created.get(timeoutMillis, TimeUnit.MILLISECONDS)
            synchronized(lock) {
                check(!abandoned && !claimed) { "native_creation_not_claimable" }
                claimed = true
                ownedHandle = null
                released.complete(true)
            }
            return handle
        } catch (error: TimeoutException) {
            abandon()
            throw error
        } catch (error: InterruptedException) {
            abandon()
            throw error
        } catch (error: ExecutionException) {
            abandon()
            throw error
        }
    }

    fun abandon() {
        val schedule = synchronized(lock) {
            if (claimed) false else {
                abandoned = true
                scheduleCleanupLocked()
            }
        }
        if (schedule) executor.execute(::cleanup)
    }

    /** A false destroy retains ownership and may be retried by a later command. */
    fun awaitReleased(timeoutMillis: Long): Boolean {
        abandon()
        val (future, schedule) = synchronized(lock) {
            if (released.isDone && !released.getNow(false)) released = CompletableFuture()
            released to scheduleCleanupLocked()
        }
        if (schedule) executor.execute(::cleanup)
        return future.get(timeoutMillis, TimeUnit.MILLISECONDS)
    }

    private fun completeCreation(handle: Long, error: Throwable? = null) {
        synchronized(lock) { ownedHandle = handle }
        if (error == null) created.complete(handle) else created.completeExceptionally(error)
        if (synchronized(lock) { scheduleCleanupLocked() }) cleanup()
    }

    // Called only under lock. Marking before enqueue prevents duplicate destroys
    // when a timeout races the native return or a subsequent recovery command.
    private fun scheduleCleanupLocked(): Boolean {
        if (!abandoned || claimed || ownedHandle == null || cleanupScheduled || released.isDone) return false
        cleanupScheduled = true
        return true
    }

    private fun cleanup() {
        val (handle, outcome) = synchronized(lock) { requireNotNull(ownedHandle) to released }
        val confirmed = handle == 0L || runCatching { destroy(handle) }.getOrDefault(false)
        synchronized(lock) {
            if (confirmed) ownedHandle = null
            cleanupScheduled = false
            outcome.complete(confirmed)
        }
    }
}
