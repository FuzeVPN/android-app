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

    @Test fun writingStaysReportedFromTheFirstWriteWhateverHappensToTheRecipient() {
        val completed = DiagnosticExport(DiagnosticExport.payload("{}"), Any())
        assertFalse(completed.writing)
        assertTrue(completed.beginWrite())
        assertTrue(completed.writing)
        assertNotNull(completed.takeRecipient())
        assertTrue(completed.writing)
        assertFalse(completed.beginWrite())
        assertNull(completed.abandon())
        assertTrue(completed.writing)

        val detached = DiagnosticExport(DiagnosticExport.payload("{}"), Any())
        assertTrue(detached.beginWrite())
        assertNotNull(detached.abandon())
        assertTrue(detached.writing)
        assertFalse(detached.beginWrite())
        assertNull(detached.takeRecipient())

        val abandoned = DiagnosticExport(DiagnosticExport.payload("{}"), Any())
        assertNotNull(abandoned.abandon())
        assertFalse(abandoned.writing)
        assertNull(abandoned.abandon())
        assertFalse(abandoned.beginWrite())
        assertFalse(abandoned.writing)
    }

    @Test fun onlyAbandonErasesAndNeverUnderAWriter() {
        // Taking the recipient delivers a result; it erases nothing by itself.
        val payload = DiagnosticExport.payload("{\"schema_version\":1}")
        val copy = payload.copyOf()
        val taken = DiagnosticExport(payload, Any())
        assertNotNull(taken.takeRecipient())
        assertArrayEquals(copy, payload)
        assertFalse(taken.beginWrite())
        assertFalse(taken.writing)
        assertNull(taken.abandon())
        assertTrue(payload.all { it == 0.toByte() })

        val written = DiagnosticExport.payload("{\"schema_version\":1}")
        val delivered = DiagnosticExport(written, Any())
        assertTrue(delivered.beginWrite())
        assertNotNull(delivered.takeRecipient())
        assertNull(delivered.abandon())
        assertArrayEquals(copy, written)

        // Without a recipient there is nothing to write for and nothing to deliver.
        val orphan = DiagnosticExport<Any>(DiagnosticExport.payload("{}"), null)
        assertFalse(orphan.beginWrite())
        assertFalse(orphan.writing)
        assertNull(orphan.takeRecipient())
    }
}
