package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Test

class FavoriteLocationsTest {
    @Test fun roundTripsUniqueOpaqueIds() {
        assertEquals(listOf("fr-01", "us_2"), FavoriteLocations.decode(
            FavoriteLocations.encode(listOf("us_2", "fr-01", "fr-01"))))
        assertEquals(emptyList<String>(), FavoriteLocations.decode(null))
    }

    @Test fun rejectsMalformedOrExcessiveWrites() {
        for (value in listOf(null, "fr-01", listOf("../other"), listOf(1), listOf(""),
                List(501) { "location-$it" }, listOf("x".repeat(161)))) {
            val error = assertThrows(VpnNativeException::class.java) { FavoriteLocations.encode(value) }
            assertEquals("invalid_arguments", error.code)
        }
    }

    @Test fun corruptStorageCannotInventFavorites() {
        for (value in listOf("{}", "[null]", "[true]", "[\"../other\"]", "bad", " ".repeat(100001))) {
            val error = assertThrows(VpnNativeException::class.java) { FavoriteLocations.decode(value) }
            assertEquals("secure_storage_corrupt", error.code)
        }
    }

    @Test fun favoritesUseOwnEncryptedPreferenceNotSessionSlot() {
        val slot = SecureStorageKeyPolicy.preference(SecureAppPreference.FAVORITE_LOCATIONS)
        assertEquals("fuzevpn.preference.ui.favorite_locations", slot.key)
        assertEquals(SecureKeystoreStore.GLOBAL_SCOPE, slot.scope)
        assertEquals(false, SecureStorageKeyPolicy.isSessionSlot(slot.scope, slot.key))
    }
}
