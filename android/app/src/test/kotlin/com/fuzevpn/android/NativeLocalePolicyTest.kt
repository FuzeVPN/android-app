package com.fuzevpn.android

import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class NativeLocalePolicyTest {
    @Test fun allThirtyRequestedTagsRoundTripWithoutLosingChineseScripts() {
        val expected = setOf(
            "en", "es", "pt", "de", "fr", "ar", "tr", "ja", "id", "ru",
            "it", "ko", "pl", "nl", "hi", "vi", "uk", "th", "zh-Hans", "zh-Hant",
            "fa", "ur", "fil", "ms", "ro", "cs", "sv", "da", "nb", "el",
        )
        assertEquals(30, NativeLocalePolicy.supportedTags.size)
        assertEquals(expected, NativeLocalePolicy.supportedTags)
        for (tag in expected) {
            assertEquals(tag, NativeLocalePolicy.canonicalTag(tag))
            assertEquals(tag, NativeLocalePolicy.resolve(tag, listOf("fr-FR")))
        }
    }

    @Test fun regionalSystemLocalesResolveToTheirSupportedLanguage() {
        val regional = mapOf(
            "en-AU" to "en", "es-419" to "es", "pt-BR" to "pt", "pt-PT" to "pt",
            "de-AT" to "de", "fr-CA" to "fr", "ar-EG" to "ar", "tr-TR" to "tr",
            "ja-JP" to "ja", "id-ID" to "id", "ru-RU" to "ru", "it-IT" to "it",
            "ko-KR" to "ko", "pl-PL" to "pl", "nl-BE" to "nl", "hi-IN" to "hi",
            "vi-VN" to "vi", "uk-UA" to "uk", "th-TH" to "th", "fa-IR" to "fa",
            "ur-PK" to "ur", "fil-PH" to "fil", "ms-MY" to "ms", "ro-RO" to "ro",
            "cs-CZ" to "cs", "sv-SE" to "sv", "da-DK" to "da", "nb-NO" to "nb",
            "el-GR" to "el",
        )
        for ((tag, expected) in regional) {
            assertEquals(tag, expected, NativeLocalePolicy.canonicalTag(tag))
            assertEquals(tag, expected, NativeLocalePolicy.resolve(null, listOf(tag)))
        }
    }

    @Test fun legacyAndroidAliasesUseCanonicalSupportedTags() {
        for ((legacy, canonical) in mapOf("in-ID" to "id", "tl-PH" to "fil", "no-NO" to "nb")) {
            assertEquals(canonical, NativeLocalePolicy.canonicalTag(legacy))
        }
    }

    @Test fun ChineseRegionsAreResolvedWithoutFlatteningTheScripts() {
        for (tag in listOf("zh", "zh-CN", "zh-SG", "zh-Hans", "zh-Hans-CN")) {
            assertEquals(tag, "zh-Hans", NativeLocalePolicy.canonicalTag(tag))
        }
        for (tag in listOf("zh-TW", "zh-HK", "zh-MO", "zh-Hant", "zh-Hant-TW")) {
            assertEquals(tag, "zh-Hant", NativeLocalePolicy.canonicalTag(tag))
        }
    }

    @Test fun explicitChineseScriptWinsOverContradictoryRegion() {
        assertEquals("zh-Hant", NativeLocalePolicy.canonicalTag("zh-Hant-CN"))
        assertEquals("zh-Hans", NativeLocalePolicy.canonicalTag("zh-Hans-TW"))
    }

    @Test fun validExtensionsCaseAndHistoricalUnderscoresAreNormalized() {
        assertEquals("zh-Hant", NativeLocalePolicy.canonicalTag(" ZH_hant_TW "))
        assertEquals("pt", NativeLocalePolicy.canonicalTag("pt_BR"))
        assertEquals("ar", NativeLocalePolicy.canonicalTag("ar-EG-u-nu-arab"))
        assertEquals("en", NativeLocalePolicy.canonicalTag("en-US-u-nu-latn"))
    }

    @Test fun malformedAndUnsupportedValuesAreRejectedInsteadOfPersisted() {
        for (tag in listOf("", " ", "xx", "en--US", "en/US", "en-a", "en-!", "e", "en-US-", "a".repeat(64))) {
            assertNull(tag, NativeLocalePolicy.canonicalTag(tag))
        }
        assertNull(NativeLocalePolicy.canonicalTag(null))
    }

    @Test fun explicitPreferenceWinsOverEverySystemLocale() {
        assertEquals("fa", NativeLocalePolicy.resolve("fa-IR", listOf("en-US", "fr-FR")))
        assertEquals("zh-Hant", NativeLocalePolicy.resolve("zh-Hant", listOf("zh-CN", "en-US")))
    }

    @Test fun firstSupportedSystemLocaleWinsWhenFollowingTheSystem() {
        assertEquals("ja", NativeLocalePolicy.resolve(null, listOf("xx", "ja-JP", "en-US")))
        assertEquals("ur", NativeLocalePolicy.resolve(null, listOf("ur-PK", "ar-EG")))
        assertEquals("zh-Hans", NativeLocalePolicy.resolve(null, listOf("zh-CN", "zh-TW")))
    }

    @Test fun unsupportedStoredValueDoesNotHideSupportedSystemLocale() {
        assertEquals("ko", NativeLocalePolicy.resolve("unsupported", listOf("ko-KR", "fr-FR")))
        assertEquals("nb", NativeLocalePolicy.resolve("en--US", listOf("no-NO")))
    }

    @Test fun FrenchRemainsTheFinalFallback() {
        assertEquals("fr", NativeLocalePolicy.resolve(null, emptyList()))
        assertEquals("fr", NativeLocalePolicy.resolve("xx", listOf("fi-FI", "he-IL")))
    }

    @Test fun parsingNeverDependsOnTheHostDefaultLanguage() {
        val previous = Locale.getDefault()
        try {
            Locale.setDefault(Locale.forLanguageTag("tr-TR"))
            assertEquals("id", NativeLocalePolicy.canonicalTag("ID-id"))
            assertEquals("zh-Hant", NativeLocalePolicy.canonicalTag("ZH-HANT"))
            assertEquals("fil", NativeLocalePolicy.canonicalTag("FIL-PH"))
        } finally {
            Locale.setDefault(previous)
        }
    }
}
