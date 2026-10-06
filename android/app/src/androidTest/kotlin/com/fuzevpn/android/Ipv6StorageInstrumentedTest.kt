package com.fuzevpn.android

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.json.JSONObject
import org.junit.Assert.*
import org.junit.Test
import org.junit.runner.RunWith
import java.util.UUID

@RunWith(AndroidJUnit4::class)
class Ipv6StorageInstrumentedTest {
    @Test fun unreadableMetadataIsRetainedAcrossRepeatedReads() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val store = SecureKeystoreStore(context)
        val scope = SecureKeystoreStore.accountScope("corrupt-ipv6-${UUID.randomUUID()}")
        val key = "fuzevpn.openvpn.test.network"
        val prefs = context.getSharedPreferences("fuzevpn.secure.v1", Context.MODE_PRIVATE)
        val record = "v1:$scope:$key"
        try {
            assertTrue(prefs.edit().putString(record, "invalid-ciphertext").commit())
            repeat(2) { assertThrows(SecureStorageException::class.java) { store.read(scope, key, removeCorrupt = false) } }
            assertTrue(prefs.contains(record))
        } finally { store.deleteScope(scope) }
    }
    private fun dual() = TunnelNetworkSpec.from(mapOf(
        "address" to "10.20.0.3/32", "addresses" to listOf("10.20.0.3/32", "fd0d:295d:995b:2::3/128"),
        "ip_families" to listOf("ipv4", "ipv6"), "allowed_ips" to listOf("0.0.0.0/0", "::/0"),
    ))
    @Test fun optionalMetadataRoundTripsAndPresentInvalidMetadataNeverDowngrades() {
        val policy = dual()
        assertEquals(policy, TunnelNetworkSpec.decode(policy.encode()))
        assertFalse(TunnelNetworkSpec.decode(null).dualStack)
        for (raw in listOf("", "null", "{}", "bad-json", JSONObject(policy.encode()).put("allowed_ips", org.json.JSONArray(listOf("0.0.0.0/0"))).toString())) {
            assertThrows(Exception::class.java) { TunnelNetworkSpec.decode(raw) }
        }
    }
    @Test fun profileAndMetadataCommitTogetherInEncryptedAccountStorage() {
        val store = SecureKeystoreStore(ApplicationProvider.getApplicationContext<Context>())
        val scope = SecureKeystoreStore.accountScope("ipv6-test-${UUID.randomUUID()}")
        try {
            store.writeAtomically(scope, mapOf("openvpn.test.profile" to "ipv4-profile", "openvpn.test.network" to TunnelNetworkSpec.ipv4("10.20.0.3/32", listOf("0.0.0.0/0")).encode()))
            store.writeAtomically(scope, mapOf("openvpn.test.profile" to "dual-profile", "openvpn.test.network" to dual().encode()))
            assertEquals("dual-profile", store.read(scope, "openvpn.test.profile"))
            assertEquals(dual(), TunnelNetworkSpec.decode(store.read(scope, "openvpn.test.network", removeCorrupt = false)))
        } finally { store.deleteScope(scope) }
    }
    @Test fun tileSupportsOldAndNewWireGuardAndOpenVpnProfiles() {
        val policy = dual()
        val request = WireGuardRequest("a", "d", "frankfurt-01", "Frankfurt", "10.20.0.3/32", listOf("1.1.1.1"),
            "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=", "198.51.100.1:51820", policy.allowedIps, policy)
        val wg = QuickTileProfile(VpnProtocol.WIREGUARD, "a", "d", "frankfurt-01", "Frankfurt", request)
        assertEquals(wg, QuickTileProfile.decode(wg.encode()))
        val legacy = JSONObject(wg.encode())
        legacy.getJSONObject("wireguard").apply {
            remove("ip_families"); remove("addresses"); put("allowed_ips", org.json.JSONArray(listOf("0.0.0.0/0")))
        }
        assertFalse(QuickTileProfile.decode(legacy.toString())!!.wireGuardRequest!!.network.dualStack)
        val ovpn = QuickTileProfile(VpnProtocol.OPENVPN, "a", "d", "frankfurt-01", "Frankfurt", openVpnNetwork = policy)
        assertEquals(ovpn, QuickTileProfile.decode(ovpn.encode()))
        val old = JSONObject(ovpn.encode()).apply { remove("openvpn_network") }
        assertNull(QuickTileProfile.decode(old.toString())!!.openVpnNetwork)
        assertNull(QuickTileProfile.decode(JSONObject(ovpn.encode()).put("openvpn_network", "malformed").toString()))
    }
}
