package com.fuzevpn.android

/** Always attempt both parts; the admission fence stays closed on any failure. */
internal suspend fun endSessionAttempt(
    stop: suspend () -> Boolean,
    erase: () -> Unit,
): SessionTermination {
    var stopError: String? = null
    var storageError: String? = null
    val stopped = try {
        stop().also { if (!it) stopError = "tunnel_stop_timeout" }
    } catch (error: Exception) {
        stopError = (error as? VpnNativeException)?.code ?: "tunnel_stop_timeout"
        false
    }
    val cleared = try { erase(); true } catch (error: Exception) {
        storageError = (error as? SecureStorageException)?.code ?: "secure_storage_write_failed"
        false
    }
    return SessionTermination(stopped, cleared, stopError, storageError)
}
