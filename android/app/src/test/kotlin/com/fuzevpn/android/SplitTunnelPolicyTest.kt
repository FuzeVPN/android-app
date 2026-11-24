package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Assert.fail
import org.junit.Test

/** Split tunneling: the saved list of apps kept out of the VPN, and what a new tunnel excludes. */
class SplitTunnelPolicyTest {
    private val own = "com.fuzevpn"

    @Test fun theSavedListIsSortedWithoutDuplicatesAndRoundTrips() {
        val encoded = SplitTunnelPolicy.encode(listOf("org.example.bank", "com.example.game", "org.example.bank"), own)
        assertEquals("[\"com.example.game\",\"org.example.bank\"]", encoded)
        assertEquals(listOf("com.example.game", "org.example.bank"), SplitTunnelPolicy.decode(encoded, own))
    }

    @Test fun thisAppAndAnythingElseThanAPackageNameAreRefused() {
        val refused = listOf<Any?>(listOf(own), listOf("bank"), listOf("org.example."), listOf(".org.example"),
            listOf("org.1example.bank"), listOf("org.example.bank;rm"), listOf("org.example bank"), listOf(""),
            listOf(null), listOf(1), "org.example.bank", null, List(SplitTunnelPolicy.MAX_APPS + 1) { "org.example.app$it" },
            listOf("org.example." + "a".repeat(250)))
        for (value in refused) {
            try {
                SplitTunnelPolicy.checked(value, own)
                fail("accepted $value")
            } catch (error: VpnNativeException) {
                assertEquals("invalid_arguments", error.code)
            }
        }
        assertEquals(listOf("org.example_1.Bank2"), SplitTunnelPolicy.checked(listOf("org.example_1.Bank2"), own))
        assertEquals(SplitTunnelPolicy.MAX_APPS,
            SplitTunnelPolicy.checked(List(SplitTunnelPolicy.MAX_APPS) { "org.example.app$it" }, own).size)
    }

    @Test fun nothingSavedOrUnreadableDataExcludesNothing() {
        for (raw in listOf(null, "", "{", "[1]", "[\"$own\"]", "[\"not a package\"]", "\"org.example.bank\"",
            "[\"" + "org.example.bank\",\"".repeat(30_000) + "x.y\"]")) {
            assertEquals("$raw", emptyList<String>(), SplitTunnelPolicy.decode(raw, own))
        }
    }

    // Android refuses to establish a VPN that excludes a package it does not know.
    @Test fun aNewTunnelExcludesOnlyTheSavedAppsStillInstalledAndNeverThisApp() {
        val installed = setOf("org.example.bank", "com.example.game", own)
        assertEquals(listOf("com.example.game", "org.example.bank"), SplitTunnelPolicy.forTunnel(
            listOf("org.example.bank", "org.example.removed", "com.example.game", own, "bad name"), own) { it in installed })
        assertEquals(emptyList<String>(), SplitTunnelPolicy.forTunnel(emptyList(), own) { true })
    }

    @Test fun packageNamesFollowAndroidsRule() {
        assertTrue(SplitTunnelPolicy.isPackageName("com.android.chrome"))
        assertTrue(SplitTunnelPolicy.isPackageName("a.b"))
        assertFalse(SplitTunnelPolicy.isPackageName("chrome"))
        assertFalse(SplitTunnelPolicy.isPackageName("com..chrome"))
        assertFalse(SplitTunnelPolicy.isPackageName("com.chrome/"))
        assertFalse(SplitTunnelPolicy.isPackageName("com.chrome\n"))
    }
}
