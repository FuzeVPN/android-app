package com.fuzevpn.android.openvpn

import com.fuzevpn.android.VpnNativeException
import java.util.concurrent.Callable
import java.util.concurrent.ExecutionException
import java.util.concurrent.ExecutorService
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

/**
 * Runs one JNI step on the controller's single native executor and waits at
 * most [timeoutMillis]. Interrupting a Future cannot cancel JNI, so a timeout
 * or an interrupted caller reports the native state as uncertain.
 *
 * A [VpnNativeException] thrown by [block] is a decision the controller took
 * on the executor, such as a cancellation observed just before JNI starts: it
 * keeps its code (A11-openvpn-kotlin-01). Any other failure is reported as
 * `openvpn_native_failed`.
 */
internal fun <T> callBoundedNative(
    executor: ExecutorService,
    timeoutMillis: Long,
    markUncertain: () -> Unit,
    block: () -> T,
): T {
    val future = executor.submit(Callable { block() })
    return try {
        future.get(timeoutMillis, TimeUnit.MILLISECONDS)
    } catch (error: TimeoutException) {
        future.cancel(true)
        markUncertain()
        throw VpnNativeException("openvpn_operation_timeout", error)
    } catch (error: ExecutionException) {
        throw error.cause as? VpnNativeException
            ?: VpnNativeException("openvpn_native_failed", error.cause ?: error)
    } catch (error: InterruptedException) {
        Thread.currentThread().interrupt()
        markUncertain()
        throw VpnNativeException("openvpn_operation_timeout", error)
    }
}
