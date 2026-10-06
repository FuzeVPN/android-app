package com.fuzevpn.android.openvpn

/**
 * The intentionally small JNI boundary for the reviewed OpenVPN 3 Core
 * integration. Loading failure is represented as core-unavailable; it never
 * falls back to another OpenVPN implementation or an insecure Java tunnel.
 */
object OpenVpnNative {
    interface Callback {
        fun onNativeState(state: String, reason: String)
        fun onTunConfiguration(planJson: String): Int
        fun onProtectSocket(fd: Int): Boolean
        fun onPkiCertificate(alias: String): String?
        fun onPkiSign(
            alias: String,
            dataBase64: String,
            algorithm: String,
            hashAlg: String,
            saltLen: String,
        ): String?
    }

    @Volatile
    private var loadAttempted = false

    @Volatile
    private var libraryLoaded = false

    /** The Core build itself can be absent even when this fail-closed JNI .so exists. */
    fun isCoreAvailable(): Boolean = ensureLibraryLoaded() && runCatching {
        nativeIsCoreAvailable()
    }.getOrDefault(false)

    fun create(callback: Callback): Long = if (ensureLibraryLoaded()) {
        runCatching { nativeCreate(callback) }.getOrDefault(0L)
    } else {
        0L
    }

    fun start(handle: Long, profile: String, identityAlias: String, expectedIpv4: String = "", expectedIpv6: String = ""): Boolean =
        ensureLibraryLoaded() && runCatching {
            nativeStart(handle, profile, identityAlias, expectedIpv4, expectedIpv6)
        }.getOrDefault(false)

    fun stop(handle: Long): Boolean = ensureLibraryLoaded() && runCatching {
        nativeStop(handle)
    }.getOrDefault(false)

    fun destroy(handle: Long): Boolean = ensureLibraryLoaded() && runCatching {
        nativeDestroy(handle)
    }.getOrDefault(false)

    /** `null` is an unreadable native state, never evidence that it stopped. */
    fun isConnected(handle: Long): Boolean? {
        if (!ensureLibraryLoaded()) return null
        return runCatching { nativeIsConnected(handle) }.getOrNull()
    }

    fun statistics(handle: Long): LongArray? {
        if (!ensureLibraryLoaded()) return null
        return runCatching { nativeStatistics(handle) }
            .getOrNull()
            ?.takeIf { it.size == 2 && it.all { value -> value >= 0L } }
    }

    @Synchronized
    private fun ensureLibraryLoaded(): Boolean {
        if (loadAttempted) return libraryLoaded
        loadAttempted = true
        libraryLoaded = try {
            System.loadLibrary("fuzevpn_openvpn")
            true
        } catch (_: UnsatisfiedLinkError) {
            false
        } catch (_: SecurityException) {
            false
        }
        return libraryLoaded
    }

    // These public JVM names are registered explicitly by JNI_OnLoad. Do not
    // change them without updating openvpn_jni.cpp as well.
    external fun nativeIsCoreAvailable(): Boolean
    external fun nativeCreate(callback: Callback): Long
    external fun nativeDestroy(handle: Long): Boolean
    external fun nativeStart(handle: Long, profile: String, identityAlias: String, expectedIpv4: String, expectedIpv6: String): Boolean
    external fun nativeStop(handle: Long): Boolean
    external fun nativeIsConnected(handle: Long): Boolean
    external fun nativeStatistics(handle: Long): LongArray
}
