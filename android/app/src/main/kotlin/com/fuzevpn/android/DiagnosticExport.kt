package com.fuzevpn.android

import org.json.JSONObject
import org.json.JSONTokener

/** Memory-only payload owned by one explicit Storage Access Framework export. */
internal class DiagnosticExport<T>(val bytes: ByteArray, private var recipient: T?) {
    // Lifecycle and completions use the main thread. The IO writer only reads bytes.
    var writing: Boolean = false
        private set

    fun beginWrite(): Boolean {
        if (recipient == null || writing) return false
        writing = true
        return true
    }

    fun takeRecipient(): T? = recipient.also { recipient = null }

    fun abandon(): T? {
        val old = takeRecipient()
        if (!writing) erase()
        return old
    }

    fun erase() { bytes.fill(0) }

    companion object {
        const val MAX_BYTES = 524_288

        fun payload(json: String): ByteArray {
            if (json.length > MAX_BYTES) throw VpnNativeException("diagnostic_export_invalid")
            val bytes = json.toByteArray(Charsets.UTF_8)
            try {
                if (bytes.size > MAX_BYTES) throw IllegalArgumentException()
                val tokenizer = JSONTokener(json)
                if (tokenizer.nextValue() !is JSONObject || tokenizer.nextClean() != '\u0000') {
                    throw IllegalArgumentException()
                }
                return bytes
            } catch (_: Exception) {
                bytes.fill(0)
                throw VpnNativeException("diagnostic_export_invalid")
            }
        }
    }
}
