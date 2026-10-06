package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class PlayBillingPolicyTest {
    @Test
    fun acceptsOnlyTheFixedMonthlyAndYearlyRecurringBasePlans() {
        assertTrue(normal("monthly", phase("P1M")))
        assertTrue(normal("yearly", phase("P1Y")))
        assertFalse(normal("monthly", phase("P1Y")))
        assertFalse(normal("weekly", phase("P1W")))
        assertFalse(PlayBillingPolicy.isNormalBasePlan(
            "other-product", "monthly", null, false, listOf(phase("P1M")),
        ))
    }

    @Test
    fun rejectsTrialPromotionalPrepaidAndInstallmentOffers() {
        val recurring = phase("P1M")
        assertFalse(PlayBillingPolicy.isNormalBasePlan(
            "premium", "monthly", "trial", false, listOf(recurring),
        ))
        assertFalse(PlayBillingPolicy.isNormalBasePlan(
            "premium", "monthly", null, false, listOf(phase("P1M", price = 0), recurring),
        ))
        assertFalse(normal("monthly", phase("P1M", infinite = false)))
        assertFalse(normal("monthly", phase("P1M", price = 0)))
        assertFalse(PlayBillingPolicy.isNormalBasePlan(
            "premium", "monthly", null, true, listOf(recurring),
        ))
    }

    @Test
    fun requiresOpaqueAccountAndAllowlistedSelection() {
        val valid = arguments()
        assertEquals("monthly", PlayBillingPolicy.selection(valid).basePlanId)
        for (invalid in listOf(
            valid + ("basePlanId" to "arbitrary"),
            valid + ("billingPeriod" to "P1Y"),
            valid + ("obfuscatedAccountId" to "person@example.com"),
            valid + ("obfuscatedAccountId" to "a".repeat(65)),
            valid + ("obfuscatedAccountId" to ""),
            valid + ("currencyCode" to "eur"),
            valid + ("offerToken" to ""),
            valid + ("productId" to "another-product"),
            valid - "formattedPrice",
        )) {
            val error = assertThrows(BillingException::class.java) {
                PlayBillingPolicy.selection(invalid)
            }
            assertEquals("invalid_request", error.code)
            assertEquals("invalid_request", error.message)
        }
    }

    @Test
    fun aFreshOfferMustMatchEveryDisplayedSelectionField() {
        val plan = PlayBillingPlan("monthly", "selected-offer", phase("P1M"))
        val valid = arguments()
        assertTrue(PlayBillingPolicy.selection(valid).matches(plan))
        for (changed in listOf(
            valid + ("offerToken" to "replacement-offer"),
            valid + ("formattedPrice" to "€9.99"),
            valid + ("currencyCode" to "USD"),
            valid + ("basePlanId" to "yearly") + ("billingPeriod" to "P1Y"),
        )) {
            assertFalse(PlayBillingPolicy.selection(changed).matches(plan))
        }
    }

    @Test
    fun aPaymentBlocksAnotherLaunchUntilCompletionAcrossHostRecreation() {
        val gate = PlayBillingFlowGate()
        val first = gate.reserve()!!
        assertNull(gate.reserve())
        assertNull(gate.returnedFlow())
        gate.markLaunched(first)
        assertTrue(gate.isLaunched(first))
        assertNull(gate.returnedFlow())
        gate.onHostPaused()
        assertEquals(first, gate.returnedFlow())
        // Pausing/destroying the Activity does not open a second payment slot.
        assertNull(gate.reserve())
        gate.finishLaunched()
        assertNull(gate.returnedFlow())
        val second = gate.reserve()!!
        assertFalse(first == second)
        // A late callback belonging to a previous operation cannot release a new one.
        gate.release(first)
        assertNull(gate.reserve())
        gate.release(second)
        assertTrue(gate.reserve() != null)
    }

    @Test
    fun unrelatedPurchaseUpdatesCannotReleaseAnUnlaunchedSelection() {
        val gate = PlayBillingFlowGate()
        val selection = gate.reserve()!!
        gate.finishLaunched()
        assertNull(gate.reserve())
        gate.release(selection)
        assertTrue(gate.reserve() != null)
    }

    @Test
    fun eachLaunchRetainsItsOpaqueOwnerAndRejectsPreviousFlowIdentity() {
        val gate = PlayBillingFlowGate()
        val first = gate.reserve("opaque-account-a")!!
        gate.markLaunched(first)
        assertEquals("opaque-account-a", gate.ownerFor(first))
        gate.release(first)
        val second = gate.reserve("opaque-account-b")!!
        gate.markLaunched(second)
        assertNull(gate.ownerFor(first))
        assertFalse(gate.isLaunched(first))
        assertEquals("opaque-account-b", gate.ownerFor(second))
        gate.release(first)
        assertTrue(gate.isLaunched(second))
    }

    @Test
    fun anAccountChangeCancelsPreparationButPreservesAnAlreadyOpenPayment() {
        val gate = PlayBillingFlowGate()
        val preparing = gate.reserve("opaque-account-a")!!
        assertEquals(preparing, gate.invalidatePreparation())
        assertNull(gate.currentFlowId())
        assertNull(gate.ownerFor(preparing))
        val opened = gate.reserve("opaque-account-b")!!
        gate.markLaunched(opened)
        assertNull(gate.invalidatePreparation())
        assertTrue(gate.isLaunched(opened))
        assertEquals("opaque-account-b", gate.ownerFor(opened))
        assertNull(gate.reserve("opaque-account-c"))
    }

    private fun normal(basePlanId: String, phase: PlayBillingPhase): Boolean =
        PlayBillingPolicy.isNormalBasePlan("premium", basePlanId, null, false, listOf(phase))

    private fun phase(period: String, price: Long = 4_990_000, infinite: Boolean = true) =
        PlayBillingPhase(period, "€4.99", "EUR", price, infinite)

    private fun arguments(): Map<String, String> = mapOf(
        "basePlanId" to "monthly",
        "offerToken" to "selected-offer",
        "formattedPrice" to "€4.99",
        "currencyCode" to "EUR",
        "billingPeriod" to "P1M",
        "obfuscatedAccountId" to "a".repeat(64),
    )
}
