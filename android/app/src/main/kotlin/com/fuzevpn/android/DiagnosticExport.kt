package com.fuzevpn.android

import org.json.JSONObject
import org.json.JSONTokener

/** Memory-only payload owned by one explicit Storage Access Framework export. */
internal class DiagnosticExport<T>(val bytes: ByteArray, recipient: T?) {
    private sealed interface State<out T> {
        /** The picker is open: nothing reads [bytes] yet. */
        class AwaitingPicker<out T>(val recipient: T) : State<T>
        /** The writer reads [bytes] and erases them itself; its result is still owed. */
        class Writing<out T>(val recipient: T) : State<T>
        /** The host left during the write: the writer still owns [bytes]. */
        data object WritingAbandoned : State<Nothing>
        /** The recipient left before any write. */
        data object Abandoned : State<Nothing>
        /** The recipient was taken to receive the writer's result. */
        data object Completed : State<Nothing>
    }

    // Lifecycle and completions use the main thread. The IO writer only reads bytes.
    private var state: State<T> =
        if (recipient == null) State.Abandoned else State.AwaitingPicker(recipient)

    /** True from the first write on, including after its completion or abandonment. */
    val writing: Boolean
        get() = when (state) {
            is State.AwaitingPicker, State.Abandoned -> false
            is State.Writing, State.WritingAbandoned, State.Completed -> true
        }

    fun beginWrite(): Boolean {
        val current = state as? State.AwaitingPicker ?: return false
        state = State.Writing(current.recipient)
        return true
    }

    fun takeRecipient(): T? = when (val current = state) {
        is State.AwaitingPicker -> current.recipient.also { state = State.Abandoned }
        is State.Writing -> current.recipient.also { state = State.Completed }
        State.WritingAbandoned, State.Abandoned, State.Completed -> null
    }

    fun abandon(): T? = when (val current = state) {
        is State.AwaitingPicker -> current.recipient.also {
            state = State.Abandoned
            erase()
        }
        is State.Writing -> current.recipient.also { state = State.WritingAbandoned }
        State.Abandoned -> {
            erase()
            null
        }
        State.WritingAbandoned, State.Completed -> null
    }

    /** Also called by the IO writer, so it touches [bytes] only and never the state. */
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
