package com.fuzevpn.android

import com.android.billingclient.api.Purchase
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class PlayBillingPurchasesTest {
    @Test
    fun discoveryIncludesSuspendedSubscriptionsWithTheRealSdk() {
        assertTrue(PlayBillingPurchases.query().includeSuspendedSubscriptions)
    }

    @Test
    fun aSuspendedReceiptRetainsItsStateAndOriginalOwnerWithoutGrantingAccess() {
        val purchase = purchase(suspended = true, acknowledged = true)
        assertEquals(Purchase.PurchaseState.PURCHASED, purchase.purchaseState)
        assertTrue(purchase.isSuspended)

        val evidence = PlayBillingPurchases.channelValues(listOf(purchase)).single()
        assertEquals("purchased", evidence["state"])
        assertEquals(true, evidence["suspended"])
        assertEquals(true, evidence["acknowledged"])
        assertEquals("original-owner", evidence["obfuscatedAccountId"])
        assertEquals(setOf("productId", "purchaseToken", "state", "obfuscatedAccountId",
            "acknowledged", "suspended"), evidence.keys)
        assertFalse(evidence.containsKey("hasAccess"))
    }

    @Test
    fun pendingAndForeignReceiptsRemainEvidenceForTheirOwnOwner() {
        val pending = purchase(pending = true)
        val foreign = purchase(owner = "another-owner", suspended = true)
        assertEquals(Purchase.PurchaseState.PENDING, pending.purchaseState)
        val evidence = PlayBillingPurchases.channelValues(listOf(pending, foreign))
        assertEquals(listOf("pending", "purchased"), evidence.map { it["state"] })
        assertEquals(listOf(false, true), evidence.map { it["suspended"] })
        assertEquals(listOf("original-owner", "another-owner"),
            evidence.map { it["obfuscatedAccountId"] })
    }

    @Test
    fun suspensionDoesNotAdmitOtherProductsOrAnEmptyToken() {
        assertTrue(PlayBillingPurchases.channelValues(listOf(
            purchase(productId = "other", suspended = true),
            purchase(token = "", suspended = true),
        )).isEmpty())
    }

    @Test
    fun actualSdkAbsentAndEmptyOwnersBecomeNullWithoutDroppingMixedReceipts() {
        val absent = purchase(owner = null, suspended = true, token = "unbound-suspended")
        val empty = purchase(owner = "", token = "unbound-empty")
        // Exercise the actual Billing SDK's representation, not a nullable fake.
        assertEquals("", absent.accountIdentifiers?.obfuscatedAccountId)
        assertEquals("", empty.accountIdentifiers?.obfuscatedAccountId)
        val evidence = PlayBillingPurchases.channelValues(listOf(
            absent, empty,
            purchase(suspended = true),
            purchase(owner = "another-owner"),
        ))
        assertEquals(listOf(null, null, "original-owner", "another-owner"),
            evidence.map { it["obfuscatedAccountId"] })
        assertEquals(listOf(true, false, true, false), evidence.map { it["suspended"] })
        assertEquals(listOf("unbound-suspended", "unbound-empty",
            "synthetic-purchase-token", "synthetic-purchase-token"),
            evidence.map { it["purchaseToken"] })
        assertTrue(evidence.none { it.containsKey("hasAccess") })
    }

    @Test
    fun nonemptyMalformedOwnerIsNotSilentlyReplacedWithUnknownOrAnotherAccount() {
        val evidence = PlayBillingPurchases.channelValues(listOf(purchase(owner = "bad owner"))).single()
        assertEquals("bad owner", evidence["obfuscatedAccountId"])
    }

    private fun purchase(
        productId: String = "premium",
        token: String = "synthetic-purchase-token",
        owner: String? = "original-owner",
        pending: Boolean = false,
        suspended: Boolean = false,
        acknowledged: Boolean = false,
    ): Purchase = Purchase(JSONObject().apply {
        put("productId", productId)
        put("purchaseToken", token)
        if (owner != null) put("obfuscatedAccountId", owner)
        put("purchaseState", if (pending) 4 else 0)
        put("suspended", suspended)
        put("acknowledged", acknowledged)
    }.toString(), "synthetic-signature")
}
