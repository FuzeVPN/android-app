package com.fuzevpn.android

import java.io.Closeable
import java.lang.ref.WeakReference

/**
 * The one TUN handle kept beside Core's own descriptor, with the plan it was
 * established for and the VPN host that established it. Pure Kotlin so the
 * ordering is unit-tested: a replacement is held before the previous handle
 * closes, and a failed close never leaves a handle held.
 */
internal class RetainedTun<T : Closeable, K : Any> {
    private var current: T? = null
    private var plan: K? = null
    private var host: WeakReference<Any>? = null

    @Synchronized fun replace(next: T, nextPlan: K, nextHost: Any) {
        val old = current
        current = next
        plan = nextPlan
        host = WeakReference(nextHost)
        if (old !== next) runCatching { old?.close() }
    }

    @Synchronized fun release() {
        val old = current
        current = null
        plan = null
        host = null
        runCatching { old?.close() }
    }

    /** Why [reuse] would refuse [wanted] from [requester] before looking at the handle; null if it would not. */
    @Synchronized fun refusal(wanted: K, requester: Any): String? = when {
        current == null -> "none retained"
        host?.get() !== requester -> "another VPN host"
        plan != wanted -> "another network plan"
        else -> null
    }

    /**
     * A copy of the held handle when it was established for an equal [wanted]
     * plan by the same [requester] host; null otherwise, when [copy] declines
     * the handle, or when the copy fails. The held handle itself stays held.
     * Under the monitor, so release() never closes the handle while it is
     * being copied.
     */
    @Synchronized fun <R : Any> reuse(wanted: K, requester: Any, copy: (T) -> R?): R? {
        val held = current ?: return null
        if (host?.get() !== requester || plan != wanted) return null
        return try { copy(held) } catch (_: Exception) { null }
    }
}

/** The interface a TUN descriptor is attached to, from its /proc fdinfo line "iff: tun0". */
internal fun tunInterfaceFromFdinfo(fdinfo: String): String? = fdinfo.lineSequence()
    .firstOrNull { it.startsWith("iff:") }
    ?.substringAfter(':')?.trim()
    ?.takeIf { it.isNotEmpty() }
