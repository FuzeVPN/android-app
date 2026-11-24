package com.fuzevpn.android

import org.json.JSONArray

/**
 * The apps the user keeps out of the VPN (split tunneling), as package names.
 *
 * Saved in the native encrypted preferences and read by the bridge when a new connection starts, whichever
 * component starts it (the app, the tile, the permanent VPN), so that the tunnel applies the list saved then.
 * FuzeVPN itself is never excluded.
 */
internal object SplitTunnelPolicy {
    const val MAX_APPS = 256
    private const val MAX_BYTES = 100_000
    // Android's own rule for a package name: two segments or more, each starting with a letter.
    private val packageName = Regex("[A-Za-z][A-Za-z0-9_]*(\\.[A-Za-z][A-Za-z0-9_]*)+")

    fun isPackageName(value: String): Boolean = value.length <= 255 && packageName.matches(value)

    /** The list to save, sorted and without duplicates. Refuses FuzeVPN itself and anything else than a package name. */
    fun checked(value: Any?, ownPackage: String): List<String> {
        if (value !is List<*> || value.size > MAX_APPS) throw VpnNativeException("invalid_arguments")
        return value.map {
            if (it !is String || !isPackageName(it) || it == ownPackage) throw VpnNativeException("invalid_arguments")
            it
        }.distinct().sorted()
    }

    fun encode(value: Any?, ownPackage: String): String = JSONArray(checked(value, ownPackage)).toString()

    /**
     * The saved list. Nothing saved excludes nothing. Unreadable data excludes nothing either: every app
     * then stays in the VPN, which is what the screen shows.
     */
    fun decode(value: String?, ownPackage: String): List<String> {
        if (value == null) return emptyList()
        return try {
            if (value.toByteArray(Charsets.UTF_8).size > MAX_BYTES) return emptyList()
            val array = JSONArray(value)
            checked((0 until array.length()).map { array.get(it) }, ownPackage)
        } catch (_: Exception) {
            emptyList()
        }
    }

    /**
     * What a new tunnel excludes: the saved apps still installed. Android refuses to establish a VPN that
     * excludes a package it does not know, so an app removed since it was chosen is left out.
     */
    fun forTunnel(saved: List<String>, ownPackage: String, installed: (String) -> Boolean): List<String> =
        saved.filter { it != ownPackage && isPackageName(it) && installed(it) }.distinct().sorted()
}
