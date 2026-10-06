package com.fuzevpn.android

import android.os.SystemClock
import android.util.Log
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledFuture
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicLong

/**
 * Debug-only, value-free timing records for an explicit Flutter connection
 * request.  Context is passed explicitly across the Core executors: coroutine
 * thread locals must not be relied on for a VPN transition.
 */
internal object NativeConnectionTiming {
    private const val TAG = "FuzeVpnTiming"
    private val TRACE_ID = Regex("c[0-9]{1,31}")
    private val nextSpanId = AtomicLong(1)
    private val activeTimers = AtomicLong()
    @Volatile private var clock: () -> Long = { SystemClock.elapsedRealtime() }
    @Volatile private var sink: (String) -> Unit = { Log.i(TAG, it) }
    @Volatile private var debugEnabled: () -> Boolean = { BuildConfig.DEBUG }
    private val scheduler by lazy { Executors.newSingleThreadScheduledExecutor { runnable ->
        Thread(runnable, "fuzevpn-timing").apply { isDaemon = true }
    } }

    internal data class TraceContext(
        val traceId: String,
        val parentSpanId: Long,
        val receivedAt: Long,
    )

    internal fun fromRpc(arguments: Any?): TraceContext? {
        if (!debugEnabled()) return null
        val values = arguments as? Map<*, *> ?: return null
        val traceId = values["diagnostic_trace_id"] as? String ?: return null
        val parent = when (val value = values["diagnostic_span_id"]) {
            is Int -> value.toLong()
            is Long -> value
            else -> return null
        }
        if (!TRACE_ID.matches(traceId) || parent < 0) return null
        return TraceContext(traceId, parent, runCatching { clock() }.getOrElse { 0L })
    }

    internal fun mark(context: TraceContext?, stage: String) {
        if (context != null) {
            val id = nextSpanId.getAndIncrement()
            emit(context, id, stage, "begin", context.receivedAt, 0L)
            emit(context, id, stage, "end", context.receivedAt, 0L)
        }
    }

    internal fun begin(context: TraceContext?, stage: String): Span? {
        if (context == null) return null
        val startedAt = runCatching { clock() }.getOrElse { return null }
        val span = Span(context, nextSpanId.getAndIncrement(), stage, startedAt)
        emit(context, span.id, stage, "begin", startedAt, 0L)
        span.scheduleWaiting()
        return span
    }

    internal inline fun <T> span(context: TraceContext?, stage: String, block: () -> T): T {
        val span = begin(context, stage)
        var failed = false
        return try {
            block()
        } catch (error: Throwable) {
            failed = true
            throw error
        } finally {
            if (failed) span?.error() else span?.end()
        }
    }

    internal suspend inline fun <T> spanSuspend(context: TraceContext?, stage: String, crossinline block: suspend () -> T): T {
        val span = begin(context, stage)
        var failed = false
        return try {
            block()
        } catch (error: Throwable) {
            failed = true
            throw error
        } finally {
            if (failed) span?.error() else span?.end()
        }
    }

    internal fun installTestHooks(
        testClock: () -> Long,
        testSink: (String) -> Unit,
        enabled: Boolean = true,
    ): AutoCloseable {
        val oldClock = clock
        val oldSink = sink
        val oldEnabled = debugEnabled
        clock = testClock
        sink = testSink
        debugEnabled = { enabled }
        return AutoCloseable { clock = oldClock; sink = oldSink; debugEnabled = oldEnabled }
    }

    internal fun activeTimerCountForTest(): Long = activeTimers.get()

    internal class Span internal constructor(
        private val context: TraceContext,
        internal val id: Long,
        private val stage: String,
        private val startedAt: Long,
    ) {
        private val closed = AtomicBoolean(false)
        private var waiting: ScheduledFuture<*>? = null

        internal fun scheduleWaiting() {
            waiting = runCatching {
                scheduler.scheduleWithFixedDelay({
                    pulseWaiting()
                }, 2, 2, TimeUnit.SECONDS)
            }.getOrNull()?.also { activeTimers.incrementAndGet() }
        }

        internal fun end() = finish("end")
        internal fun error() = finish("error")

        @Synchronized
        internal fun pulseWaiting() {
            if (!closed.get()) {
                val now = runCatching { clock() }.getOrDefault(startedAt)
                emit(context, id, stage, "waiting", now, now - startedAt)
            }
        }

        @Synchronized
        private fun finish(event: String) {
            if (closed.compareAndSet(false, true)) {
                waiting?.cancel(false)
                if (waiting != null) activeTimers.decrementAndGet()
                val now = runCatching { clock() }.getOrDefault(startedAt)
                emit(context, id, stage, event, now, now - startedAt)
            }
        }

    }

    private fun emit(context: TraceContext, spanId: Long, stage: String, event: String, elapsed: Long, duration: Long) {
        // Values are validated or compile-time constants.  Do not add request,
        // profile, certificate, endpoint, Core log, or Throwable content here.
        val relativeElapsed = (elapsed - context.receivedAt).coerceAtLeast(0L)
        runCatching {
            sink("{\"source\":\"native\",\"trace_id\":\"${context.traceId}\",\"parent_span_id\":${context.parentSpanId},\"span_id\":\"n$spanId\",\"stage\":\"$stage\",\"event\":\"$event\",\"elapsed_ms\":$relativeElapsed,\"duration_ms\":$duration}")
        }
    }
}
