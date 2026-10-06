package com.fuzevpn.android

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class QuickTileProfileInstrumentedTest {
    private lateinit var secureStore: SecureKeystoreStore
    private lateinit var profileStore: QuickTileProfileStore

    @Before
    fun setUp() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        secureStore = SecureKeystoreStore(context)
        profileStore = QuickTileProfileStore(secureStore)
        profileStore.clear()
    }

    @After
    fun tearDown() {
        profileStore.clear()
    }

    @Test
    fun storesOnlyAValidatedReconnectProfileAndClearsItByDevice() {
        val request = WireGuardRequest(
            accountId = "account-test",
            deviceId = "device-test",
            locationId = "frankfurt-01",
            locationName = "Frankfurt 01",
            address = "10.0.0.2/32",
            dns = listOf("10.0.0.1"),
            serverPublicKey = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=",
            endpoint = "198.51.100.10:51820",
            allowedIps = listOf("0.0.0.0/0"),
        )
        val expected = QuickTileProfile(
            protocol = VpnProtocol.WIREGUARD,
            accountId = request.accountId,
            deviceId = request.deviceId,
            locationId = request.locationId,
            locationName = request.locationName,
            wireGuardRequest = request,
        )

        profileStore.write(expected)
        assertEquals(expected, profileStore.read())

        profileStore.clearIf("account-test", "device-test", VpnProtocol.OPENVPN)
        assertEquals(expected, profileStore.read())
        profileStore.clearIf("account-test", "other-device")
        assertEquals(expected, profileStore.read())
        profileStore.clearIf("account-test", "device-test")
        assertNull(profileStore.read())
    }

    @Test
    fun deletesAnInvalidEncryptedRecordInsteadOfUsingIt() {
        val slot = SecureStorageKeyPolicy.quickTileProfile()
        secureStore.write(slot.scope, slot.key, "not-json")

        assertNull(profileStore.read())
        assertNull(secureStore.read(slot.scope, slot.key))
    }
}
