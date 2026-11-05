package com.fuzevpn.android

import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Test

/**
 * Pins the native bounds that the Dart models mirror (A05-models-01, C5-05).
 * The vectors are those of test/core/corrections_20261029_models_test.dart:
 * a label is not blank, has at most 96 UTF-16 units (Location.maximumDisplayNameLength)
 * and no Char.isISOControl; an IPv4 address has four canonical decimal octets.
 * Changing a bound here means changing lib/core/models.dart or
 * lib/core/network_configuration.dart as well. The bridge's own label check
 * is pinned with the same vectors in src/test/bridge-host.
 */
class NativeInputContractTest {
    @Test fun tileProfileKeepsEveryLabelTheDartCatalogueOffers() {
        for ((name, label) in ACCEPTED_LABELS) {
            assertEquals(name, label, QuickTileProfile.decode(profile(label).encode())?.locationName)
        }
    }

    @Test fun tileProfileRefusesEveryLabelTheDartCatalogueDrops() {
        val stored = JSONObject(profile("Paris").encode())
        for ((name, label) in REFUSED_LABELS) {
            assertThrows(name, IllegalArgumentException::class.java) { profile(label) }
            assertNull(name, QuickTileProfile.decode(stored.put("location_name", label).toString()))
        }
    }

    @Test fun numericAddressAcceptsOnlyTheCanonicalDottedDecimalForm() {
        for (value in REFUSED_IPV4) {
            assertThrows(value, IllegalArgumentException::class.java) { TunnelNetworkSpec.numericAddress(value) }
        }
        for (value in listOf("1.1.1.1", "0.0.0.0", "255.255.255.255", "10.0.0.53")) {
            assertEquals(value, TunnelNetworkSpec.numericAddress(value).hostAddress)
        }
    }

    @Test fun tunnelAddressPrefixIsStrictAsWell() {
        for (value in listOf("10.20.0.2/+32", "10.20.0.2/ 32", "10.20.0.2/032")) {
            assertThrows(value, IllegalArgumentException::class.java) { TunnelNetworkSpec.cidr(value) }
        }
        assertEquals(32, TunnelNetworkSpec.cidr("10.20.0.2/32").prefix)
    }

    private fun profile(label: String) =
        QuickTileProfile(VpnProtocol.OPENVPN, "account-1", "device-1", "paris-01", label)

    private companion object {
        const val EMOJI = "\uD83C\uDF0D" // U+1F30D: two UTF-16 units, as in Dart.

        val ACCEPTED_LABELS = mapOf(
            "96 characters" to "P".repeat(96),
            "48 emoji (96 UTF-16 units)" to EMOJI.repeat(48),
            "no-break space U+00A0" to "Paris\u00A01",
            "accents" to "S\u00E3o Paulo \u2014 Z\u00FCrich",
            "no-break space, zero-width space, soft hyphen" to "Paris\u00A0\u200B\u00AD",
        )

        val REFUSED_LABELS = mapOf(
            "97 characters" to "P".repeat(97),
            "16 384 characters" to "P".repeat(16_384),
            "tab" to "Paris\t02",
            "line feed" to "Paris\n03",
            "NEL U+0085" to "Paris\u008504",
            "DEL U+007F" to "Paris\u007F05",
            "C1 U+009F" to "Paris\u009F06",
            "NUL" to "Paris\u000007",
            "49 emoji (98 UTF-16 units)" to EMOJI.repeat(49),
            "empty" to "",
            "spaces" to "   ",
            "tab only" to "\t",
            "line feed only" to "\n",
            "NEL only" to "\u0085",
            "ideographic space only" to "\u3000",
            "no-break space only" to "\u00A0",
            "spaces around NEL" to " \u0085 ",
        )

        val REFUSED_IPV4 = listOf(
            "+1.1.1.1", "1.1.1.+1", "-0.1.1.1",
            "1.1.1. 1", "1.1.1.1 ", " 1.1.1.1",
            "1.1.1.\u00A01", "1.1.1.1\u2003", "\u20031.1.1.1", "1.1.1.\t1",
            "\u0661.\u0661.\u0661.\u0661", "1.1.1.01", "1.1.1.256", "1.1.1.1.", "1.1.1",
            "0x1.1.1.1", "1.1.1.1/32",
        )
    }
}
