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
    /** A handle with the plan and the host it was established for: held and dropped as one. */
    private class Held<T, K>(val handle: T, val plan: K, val host: WeakReference<Any>)

    private var current: Held<T, K>? = null

    @Synchronized fun replace(next: T, nextPlan: K, nextHost: Any) {
        val old = current?.handle
        current = Held(next, nextPlan, WeakReference(nextHost))
        if (old !== next) runCatching { old?.close() }
    }

    @Synchronized fun release() {
        val old = current?.handle
        current = null
        runCatching { old?.close() }
    }

    /** Why [reuse] would refuse [wanted] from [requester] before looking at the handle; null if it would not. */
    @Synchronized fun refusal(wanted: K, requester: Any): String? = when {
        current == null -> "none retained"
        current?.host?.get() !== requester -> "another VPN host"
        current?.plan != wanted -> "another network plan"
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
        if (held.host.get() !== requester || held.plan != wanted) return null
        return try { copy(held.handle) } catch (_: Exception) { null }
    }
}

/** The interface a TUN descriptor is attached to, from its /proc fdinfo line "iff: tun0". */
internal fun tunInterfaceFromFdinfo(fdinfo: String): String? = fdinfo.lineSequence()
    .firstOrNull { it.startsWith("iff:") }
    ?.substringAfter(':')?.trim()
    ?.takeIf { it.isNotEmpty() }
