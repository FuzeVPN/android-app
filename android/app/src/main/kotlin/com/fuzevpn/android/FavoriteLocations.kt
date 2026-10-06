package com.fuzevpn.android

import org.json.JSONArray

/** Bounded, typed UI preference. It contains only catalogue identifiers. */
internal object FavoriteLocations {
    private const val MAX_COUNT = 500
    private const val MAX_BYTES = 100_000
    private val identifier = Regex("[A-Za-z0-9._-]{1,160}")

    fun checked(value: Any?): List<String> {
        if (value !is List<*> || value.size > MAX_COUNT) {
            throw VpnNativeException("invalid_arguments")
        }
        return value.map {
            if (it !is String || !identifier.matches(it)) throw VpnNativeException("invalid_arguments")
            it
        }.distinct().sorted()
    }

    fun encode(value: Any?): String = JSONArray(checked(value)).toString()

    fun decode(value: String?): List<String> {
        if (value == null) return emptyList()
        try {
            if (value.toByteArray(Charsets.UTF_8).size > MAX_BYTES) throw IllegalArgumentException()
            val array = JSONArray(value)
            if (array.length() > MAX_COUNT) throw IllegalArgumentException()
            return checked((0 until array.length()).map { array.get(it) })
        } catch (_: Exception) {
            throw VpnNativeException("secure_storage_corrupt")
        }
    }
}
