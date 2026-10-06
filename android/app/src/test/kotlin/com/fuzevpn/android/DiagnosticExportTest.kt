package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class DiagnosticExportTest {
    @Test fun validatesUtf8ByteLimitAndSingleObject() {
        val exact = "{\"x\":\"" + "x".repeat(DiagnosticExport.MAX_BYTES - 8) + "\"}"
        assertEquals(DiagnosticExport.MAX_BYTES, DiagnosticExport.payload(exact).size)
        for (invalid in listOf(exact + " ", "{\"x\":\"" + "é".repeat(DiagnosticExport.MAX_BYTES / 2) + "\"}",
            "[]", "null", "{}{}", "{} private", "{", "")) {
            val error = assertThrows(VpnNativeException::class.java) { DiagnosticExport.payload(invalid) }
            assertEquals("diagnostic_export_invalid", error.code)
        }
    }

    @Test fun abandonedPickerClearsRecipientAndPayload() {
        val recipient = Any()
        val payload = DiagnosticExport.payload("{}")
        val export = DiagnosticExport(payload, recipient)
        assertSame(recipient, export.abandon())
        assertTrue(payload.all { it == 0.toByte() })
        assertFalse(export.beginWrite())
        assertNull(export.takeRecipient())
    }

    @Test fun detachWhileWritingDoesNotCorruptWriteOrRetainRecipient() {
        val recipient = Any()
        val payload = DiagnosticExport.payload("{\"schema_version\":1}")
        val copy = payload.copyOf()
        val export = DiagnosticExport(payload, recipient)
        assertTrue(export.beginWrite())
        assertFalse(export.beginWrite())
        assertSame(recipient, export.abandon())
        assertArrayEquals(copy, payload)
        assertNull(export.takeRecipient())
        export.erase()
        assertTrue(payload.all { it == 0.toByte() })
    }

    @Test fun completionIsDeliveredAtMostOnce() {
        val recipient = Any()
        val export = DiagnosticExport(DiagnosticExport.payload("{}"), recipient)
        assertTrue(export.beginWrite())
        export.erase()
        assertSame(recipient, export.takeRecipient())
        assertNull(export.takeRecipient())
    }
}
