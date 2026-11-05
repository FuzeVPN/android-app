package com.fuzevpn.android

import com.fuzevpn.android.LegacyDefaultNetworkTracker.Reading
import com.fuzevpn.android.LegacyDefaultNetworkTracker.State.BLOCKED
import com.fuzevpn.android.LegacyDefaultNetworkTracker.State.FOLLOWED
import com.fuzevpn.android.LegacyDefaultNetworkTracker.State.OTHER
import org.junit.Assert.assertEquals
import org.junit.Test

/**
 * Android 11 process whose ConnectivityManager answers for package android: OpenVPN follows the
 * default physical network once a second through legacy readings (campaigns vm31j to vm31m).
 * Each case is a sequence of looks; the list holds the looks that report a loss.
 */
class LegacyDefaultNetworkTrackerTest {
    private val wifi = Reading(TYPE_WIFI, null, FOLLOWED)
    private fun cellular(apn: String, state: LegacyDefaultNetworkTracker.State = FOLLOWED) = Reading(TYPE_MOBILE, apn, state)

    private class Look(val listed: Map<String, Reading>, val default: Reading?)

    private fun losses(vararg looks: Look): List<Int> {
        val tracker = LegacyDefaultNetworkTracker<String>()
        return looks.withIndex().filter { (_, look) -> tracker.look(look.listed, look.default) }.map { it.index }
    }

    @Test fun aFirstLookOnlyRecordsAndAStableDefaultIsNeverLost() {
        val look = Look(mapOf("w" to wifi, "c" to cellular("internet")), wifi)
        assertEquals(emptyList<Int>(), losses(look, look, look))
    }

    @Test fun losingTheWiFiIsOneLoss() {
        assertEquals(listOf(1), losses(
            Look(mapOf("w" to wifi, "c" to cellular("internet")), wifi),
            Look(mapOf("c" to cellular("internet")), cellular("internet")),
            Look(mapOf("c" to cellular("internet")), cellular("internet")),
        ))
    }

    // vm31k: the cellular network stays listed and lingers; the callback reports it lost 30 s later.
    @Test fun theWiFiReturnOverALingeringCellularNetworkIsOneLoss() {
        assertEquals(listOf(1), losses(
            Look(mapOf("c" to cellular("internet")), cellular("internet")),
            Look(mapOf("c" to cellular("internet"), "w" to wifi), wifi),
            Look(mapOf("c" to cellular("internet"), "w" to wifi), wifi),
            Look(mapOf("w" to wifi), wifi),
        ))
    }

    @Test fun networksBehindTheDefaultNeverCount() {
        val default = cellular("internet")
        assertEquals(emptyList<Int>(), losses(
            Look(mapOf("c" to default), default),
            Look(mapOf("c" to default, "ims" to cellular("ims"), "mms" to cellular("mms")), default),
            Look(mapOf("c" to default, "w" to Reading(TYPE_WIFI, null, OTHER)), default),
            Look(mapOf("c" to default), default),
        ))
    }

    // Data off and on, or a data stall cleanup, while VoLTE keeps its IMS network listed.
    @Test fun theDataNetworkReplacedBesideAnImsNetworkIsOneLoss() {
        assertEquals(listOf(1), losses(
            Look(mapOf("c1" to cellular("internet"), "ims" to cellular("ims")), cellular("internet")),
            Look(mapOf("ims" to cellular("ims"), "c2" to cellular("internet")), cellular("internet")),
            Look(mapOf("ims" to cellular("ims"), "c2" to cellular("internet")), cellular("internet")),
        ))
    }

    @Test fun mobileDataMovingToTheOtherSimIsOneLoss() {
        assertEquals(listOf(2), losses(
            Look(mapOf("a" to cellular("a")), cellular("a")),
            Look(mapOf("a" to cellular("a"), "b" to cellular("b")), cellular("a")),
            Look(mapOf("a" to cellular("a"), "b" to cellular("b")), cellular("b")),
            Look(mapOf("b" to cellular("b")), cellular("b")),
        ))
    }

    // Two SIMs with the same APN name, or a data network set up before the old one goes: the
    // network already followed is kept, so its departure is the loss.
    @Test fun aReplacementWithTheSameApnIsLostWhenTheFollowedNetworkLeaves() {
        assertEquals(listOf(3), losses(
            Look(mapOf("x" to cellular("internet")), cellular("internet")),
            Look(mapOf("x" to cellular("internet"), "y" to cellular("internet")), cellular("internet")),
            Look(mapOf("x" to cellular("internet"), "y" to cellular("internet")), cellular("internet")),
            Look(mapOf("y" to cellular("internet")), cellular("internet")),
            Look(mapOf("y" to cellular("internet")), cellular("internet")),
        ))
    }

    @Test fun aFollowedNetworkNoLongerConnectedIsLostEvenWhileListed() {
        assertEquals(listOf(1), losses(
            Look(mapOf("x" to cellular("internet")), cellular("internet")),
            Look(mapOf("x" to cellular("internet", OTHER), "y" to cellular("internet")), cellular("internet")),
        ))
    }

    // Out of data service, or a call without concurrent voice and data: the default stays, SUSPENDED.
    @Test fun aSuspendedDefaultIsStillFollowedAndItsTeardownIsOneLoss() {
        val suspended = cellular("internet") // The bridge reads SUSPENDED as FOLLOWED.
        assertEquals(listOf(2), losses(
            Look(mapOf("x" to cellular("internet"), "ims2" to cellular("ims")), cellular("internet")),
            Look(mapOf("x" to suspended, "ims2" to cellular("ims")), suspended),
            Look(mapOf("ims2" to cellular("ims")), null),
            Look(mapOf("ims2" to cellular("ims"), "y" to cellular("internet")), cellular("internet")),
            Look(mapOf("ims2" to cellular("ims"), "y" to cellular("internet")), cellular("internet")),
        ))
    }

    // Android 11 reports BLOCKED for this app (Data Saver, power restrictions) and clears the APN.
    @Test fun aBlockedDefaultIsNoLossAndItsReplacementWhileBlockedIsOne() {
        val blocked = Reading(TYPE_MOBILE, null, BLOCKED)
        assertEquals(emptyList<Int>(), losses(
            Look(mapOf("x" to cellular("internet")), cellular("internet")),
            Look(mapOf("x" to blocked), blocked),
            Look(mapOf("x" to cellular("internet")), cellular("internet")),
        ))
        assertEquals(listOf(2), losses(
            Look(mapOf("x" to cellular("internet")), cellular("internet")),
            Look(mapOf("x" to blocked), blocked),
            Look(mapOf("y" to blocked), blocked),
            Look(mapOf("y" to cellular("internet")), cellular("internet")),
        ))
    }

    // The readings are separate calls: a block can end after the network's reading and before
    // the default's, or begin between them.
    @Test fun aBlockEndingOrBeginningBetweenTheReadingsIsNoLoss() {
        val blocked = Reading(TYPE_MOBILE, null, BLOCKED)
        assertEquals(emptyList<Int>(), losses(
            Look(mapOf("x" to cellular("internet"), "ims" to cellular("ims")), cellular("internet")),
            Look(mapOf("x" to blocked, "ims" to blocked), cellular("internet")),
            Look(mapOf("x" to cellular("internet"), "ims" to cellular("ims")), cellular("internet")),
            Look(mapOf("x" to cellular("internet"), "ims" to cellular("ims")), blocked),
            Look(mapOf("x" to cellular("internet"), "ims" to cellular("ims")), cellular("internet")),
        ))
        // Still followed: its later departure is the loss.
        assertEquals(listOf(2), losses(
            Look(mapOf("x" to cellular("internet")), cellular("internet")),
            Look(mapOf("x" to blocked), cellular("internet")),
            Look(mapOf("y" to cellular("internet")), cellular("internet")),
        ))
    }

    @Test fun aTypeChangeIsALossEvenWhileBlocked() {
        val blockedWifi = Reading(TYPE_WIFI, null, BLOCKED)
        assertEquals(listOf(1), losses(
            Look(mapOf("c" to cellular("internet")), cellular("internet")),
            Look(mapOf("c" to cellular("internet"), "w" to blockedWifi), blockedWifi),
            Look(mapOf("c" to cellular("internet"), "w" to wifi), wifi),
        ))
    }

    @Test fun theOnlyWiFiLostThenReplacedIsOneLoss() {
        assertEquals(listOf(1), losses(
            Look(mapOf("w1" to wifi), wifi),
            Look(emptyMap(), null),
            Look(mapOf("w2" to Reading(TYPE_WIFI, null, OTHER)), null),
            Look(mapOf("w2" to wifi), wifi),
            Look(mapOf("w2" to wifi), wifi),
        ))
    }

    @Test fun aWiFiStillConnectingIsNotFollowedUntilItIsTheDefault() {
        assertEquals(listOf(2), losses(
            Look(mapOf("w1" to wifi), wifi),
            Look(mapOf("w1" to wifi, "w2" to Reading(TYPE_WIFI, null, OTHER)), wifi),
            Look(mapOf("w2" to wifi), wifi),
            Look(mapOf("w2" to wifi), wifi),
        ))
    }

    @Test fun afterAResetAFirstLookOnlyRecordsAgain() {
        val tracker = LegacyDefaultNetworkTracker<String>()
        tracker.look(mapOf("w" to wifi), wifi)
        tracker.reset()
        assertEquals(false, tracker.look(mapOf("c" to cellular("internet")), cellular("internet")))
        assertEquals(true, tracker.look(mapOf("w" to wifi), wifi))
    }

    private companion object {
        const val TYPE_MOBILE = 0
        const val TYPE_WIFI = 1
    }
}
