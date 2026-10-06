package com.fuzevpn.android

import java.util.IllformedLocaleException
import java.util.Locale

/** Pure locale policy shared by encrypted preferences and Android VPN surfaces. */
internal object NativeLocalePolicy {
    const val FALLBACK_TAG = "fr"

    val supportedTags: Set<String> = setOf(
        "en", "es", "pt", "de", "fr", "ar", "tr", "ja", "id", "ru",
        "it", "ko", "pl", "nl", "hi", "vi", "uk", "th", "zh-Hans", "zh-Hant",
        "fa", "ur", "fil", "ms", "ro", "cs", "sv", "da", "nb", "el",
    )

    /**
     * Returns one supported storage/resource tag, or null for unsupported or
     * malformed input. Region variants share their supported language; explicit
     * Chinese scripts take precedence over region inference.
     */
    fun canonicalTag(raw: String?): String? {
        if (raw == null || raw.length > 63) return null
        val tag = raw.trim().replace('_', '-')
        if (!TAG.matches(tag)) return null
        val locale = try {
            Locale.Builder().setLanguageTag(tag).build()
        } catch (_: IllformedLocaleException) {
            return null
        }
        val language = when (locale.language.lowercase(Locale.ROOT)) {
            "in" -> "id"
            "tl" -> "fil"
            "no" -> "nb"
            else -> locale.language.lowercase(Locale.ROOT)
        }
        if (language == "zh") {
            return when (locale.script.lowercase(Locale.ROOT)) {
                "hans" -> "zh-Hans"
                "hant" -> "zh-Hant"
                else -> if (locale.country.uppercase(Locale.ROOT) in TRADITIONAL_REGIONS) {
                    "zh-Hant"
                } else {
                    "zh-Hans"
                }
            }
        }
        return language.takeIf(supportedTags::contains)
    }

    /** Unsupported stored values do not prevent following a supported system locale. */
    fun resolve(storedTag: String?, systemTags: Iterable<String>): String =
        canonicalTag(storedTag)
            ?: systemTags.firstNotNullOfOrNull(::canonicalTag)
            ?: FALLBACK_TAG

    private val TAG = Regex("[A-Za-z]{2,3}(?:-[A-Za-z0-9]{1,8})*")
    private val TRADITIONAL_REGIONS = setOf("TW", "HK", "MO")
}
