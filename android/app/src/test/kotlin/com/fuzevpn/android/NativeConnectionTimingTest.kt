package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

class NativeConnectionTimingTest {
    @Test fun refusesMissingMalformedAndNonIntegralRpcContext() {
        val hooks = NativeConnectionTiming.installTestHooks({ 10L }, {}, enabled = true)
        try {
            assertNull(NativeConnectionTiming.fromRpc(null))
            assertNull(NativeConnectionTiming.fromRpc(mapOf("diagnostic_trace_id" to "wrong", "diagnostic_span_id" to 1)))
            assertNull(NativeConnectionTiming.fromRpc(mapOf("diagnostic_trace_id" to "c1", "diagnostic_span_id" to 1.0)))
            assertNull(NativeConnectionTiming.fromRpc(mapOf("diagnostic_trace_id" to "c1", "diagnostic_span_id" to -1)))
        } finally {
            hooks.close()
        }
        val disabled = NativeConnectionTiming.installTestHooks({ 10L }, {}, enabled = false)
        try {
            assertNull(NativeConnectionTiming.fromRpc(mapOf("diagnostic_trace_id" to "c1", "diagnostic_span_id" to 1)))
        } finally {
            disabled.close()
        }
    }

    @Test fun emitsOnlyMetadataAndClosesTimerAfterSpan() {
        var now = 100L
        val records = mutableListOf<String>()
        val hooks = NativeConnectionTiming.installTestHooks({ now }, records::add)
        try {
            val context = NativeConnectionTiming.fromRpc(mapOf("diagnostic_trace_id" to "c42", "diagnostic_span_id" to 7))!!
            now = 115L
            val span = NativeConnectionTiming.begin(context, "openvpn_native_start")!!
            now = 2_115L
            span.pulseWaiting()
            span.end()
            now = 4_115L
            span.pulseWaiting()
            assertEquals(0L, NativeConnectionTiming.activeTimerCountForTest())
        } finally {
            hooks.close()
        }
        assertTrue(records.any { it.contains("\"parent_span_id\":7") && it.contains("\"duration_ms\":2000") })
        assertEquals(1, records.count { it.contains("\"event\":\"waiting\"") })
        assertFalse(records.any { it.contains("endpoint") || it.contains("certificate") || it.contains("payload") })
    }

    @Test fun diagnosticFailuresAndNonLocalReturnDoNotLeakOrChangeTheOperation() {
        var now = 10L
        val hooks = NativeConnectionTiming.installTestHooks({ now }, { throw IllegalStateException("sink") })
        try {
            val context = NativeConnectionTiming.fromRpc(mapOf("diagnostic_trace_id" to "c9", "diagnostic_span_id" to 1))!!
            assertEquals(73, returningThroughSpan(context))
            now = 20L
            assertEquals(2, NativeConnectionTiming.span(context, "wireguard_native_start") { 2 })
            assertEquals(0L, NativeConnectionTiming.activeTimerCountForTest())
        } finally {
            hooks.close()
        }
    }

    private fun returningThroughSpan(context: NativeConnectionTiming.TraceContext): Int {
        NativeConnectionTiming.span(context, "rpc_execution") { return 73 }
        error("unreachable")
    }
}
