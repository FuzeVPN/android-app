package com.fuzevpn.android

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/** Main-thread lifecycle owner; storage is always evaluated on the IO dispatcher. */
internal class QuickTileSnapshotLoader<T>(
    private val scope: CoroutineScope,
    private val load: suspend () -> T,
    private val deliver: (T) -> Unit,
    private val ioDispatcher: CoroutineDispatcher = Dispatchers.IO,
) {
    private var listening = false
    private var revision = 0L
    private var pending: Job? = null

    fun startListening() {
        listening = true
        refresh()
    }

    fun stopListening() {
        listening = false
        revision++
        pending?.cancel()
        pending = null
    }

    fun refresh() {
        if (!listening) return
        val requestedRevision = ++revision
        pending?.cancel()
        pending = scope.launch {
            val snapshot = withContext(ioDispatcher) { load() }
            if (listening && revision == requestedRevision) deliver(snapshot)
        }
    }
}
