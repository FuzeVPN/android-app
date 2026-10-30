package com.fuzevpn.android.openvpn

import java.util.concurrent.CompletableFuture
import java.util.concurrent.Executor
import java.util.concurrent.TimeUnit

/** Keeps the completion proof when a caller stops waiting for a JNI destroy. */
internal class OwnedNativeHandleDestruction(
    executor: Executor,
    handle: Long,
    destroy: (Long) -> Boolean,
) {
    private val completed = CompletableFuture<Boolean>()

    init {
        require(handle != 0L)
        executor.execute {
            completed.complete(runCatching { destroy(handle) }.getOrDefault(false))
        }
    }

    // Timeout/interruption must not cancel JNI or discard a later positive proof.
    fun awaitCompleted(timeoutMillis: Long): Boolean =
        completed.get(timeoutMillis, TimeUnit.MILLISECONDS)
}
