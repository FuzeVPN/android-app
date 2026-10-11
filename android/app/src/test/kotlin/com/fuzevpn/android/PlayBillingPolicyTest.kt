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
        val plan = PlayBillingPlan("monthly", "selected-offer", null, listOf(phase("P1M")))
        val valid = arguments()
        val selection = PlayBillingPolicy.selection(valid)
        assertTrue(selection.matches(plan))
        for (changed in listOf(
            plan.copy(offerToken = "replacement-offer"),
            plan.copy(pricingPhases = listOf(plan.phase.copy(formattedPrice = "€9.99"))),
            plan.copy(pricingPhases = listOf(plan.phase.copy(currencyCode = "USD"))),
            plan.copy(basePlanId = "yearly", pricingPhases = listOf(plan.phase.copy(billingPeriod = "P1Y"))),
        )) {
            assertFalse(selection.matches(changed))
        }
    }

    @Test
    fun twoWeekFreeTrialsKeepTheirCompleteScheduleAndPaidPrice() {
        for ((base, period) in listOf("monthly" to "P1M", "yearly" to "P1Y")) {
            for (freePeriod in listOf("P2W", "P14D")) {
                val plan = trial(base, period, freePeriod)
                assertTrue(PlayBillingPolicy.isSupportedOffer(
                    "premium", base, "freetest", false, plan.pricingPhases,
                ))
                assertEquals(4_990_000L, plan.channelValue()["priceAmountMicros"])
                assertEquals("€4.99", plan.channelValue()["formattedPrice"])
                assertEquals(2, (plan.channelValue()["pricingPhases"] as List<*>).size)
                assertTrue(PlayBillingPolicy.selection(plan.channelValue()
                    .filterKeys { it != "productId" } + ("obfuscatedAccountId" to "opaque"))
                    .matches(plan))
            }
        }
    }

    @Test
    fun normalPlanIsFallbackWhenPlayDoesNotReturnAnEligibleTrial() {
        val normal = PlayBillingPlan("monthly", "normal", null, listOf(phase("P1M")))
        val trial = trial()
        assertEquals(listOf(trial), PlayBillingPolicy.preferredPlans(listOf(normal, trial)))
        assertEquals(listOf(normal), PlayBillingPolicy.preferredPlans(listOf(normal)))
        assertTrue(PlayBillingPolicy.preferredPlans(emptyList()).isEmpty())
        val unsupported = trial.copy(offerId = "other-offer")
        assertEquals(listOf(normal), PlayBillingPolicy.preferredPlans(listOf(normal, unsupported)))
    }

    @Test
    fun ambiguousTrialFallsBackWithoutChoosingAnArbitraryOffer() {
        val normal = PlayBillingPlan("monthly", "normal", null, listOf(phase("P1M")))
        val trial = trial()
        assertEquals(listOf(normal), PlayBillingPolicy.preferredPlans(listOf(
            normal, trial, trial.copy(offerToken = "other-trial"),
        )))
        assertTrue(PlayBillingPolicy.preferredPlans(listOf(
            trial, trial.copy(offerToken = "other-trial"),
        )).isEmpty())
        assertTrue(PlayBillingPolicy.preferredPlans(listOf(normal, normal)).isEmpty())
    }

    @Test
    fun malformedTrialSchedulesCannotAdvertiseFreeAccess() {
        val plan = trial()
        val free = plan.pricingPhases.first()
        val paid = plan.pricingPhases.last()
        for (phases in listOf(
            listOf(free.copy(priceAmountMicros = 1), paid),
            listOf(free.copy(billingPeriod = "P1W"), paid),
            listOf(free.copy(billingCycleCount = 2), paid),
            listOf(free.copy(recurrenceMode = 1), paid),
            listOf(free.copy(currencyCode = "USD"), paid),
            listOf(free, paid.copy(priceAmountMicros = 0)),
            listOf(free, paid.copy(billingPeriod = "P1Y")),
            listOf(free, paid.copy(billingCycleCount = 1)),
            listOf(free, paid.copy(recurrenceMode = 3)),
            listOf(paid, free),
            listOf(free, paid, paid),
        )) {
            assertFalse(PlayBillingPolicy.isSupportedOffer(
                "premium", "monthly", "freetest", false, phases,
            ))
            assertTrue(PlayBillingPolicy.preferredPlans(listOf(plan.copy(pricingPhases = phases))).isEmpty())
        }
        assertFalse(PlayBillingPolicy.isSupportedOffer(
            "premium", "monthly", "freetest", true, plan.pricingPhases,
        ))
    }

    @Test
    fun staleTokenOrChangedScheduleCannotSubstituteCheckout() {
        val original = trial()
        val selected = PlayBillingPolicy.selection(original.channelValue()
            .filterKeys { it != "productId" } + ("obfuscatedAccountId" to "opaque"))
        val free = original.pricingPhases.first()
        val paid = original.pricingPhases.last()
        for (fresh in listOf(
            original.copy(offerToken = "new-token"),
            original.copy(offerId = null, pricingPhases = listOf(paid)),
            original.copy(pricingPhases = listOf(free.copy(billingPeriod = "P14D"), paid)),
            original.copy(pricingPhases = listOf(free.copy(billingCycleCount = 2), paid)),
            original.copy(pricingPhases = listOf(free.copy(recurrenceMode = 3, billingCycleCount = 0), paid)),
            original.copy(pricingPhases = listOf(free, paid.copy(formattedPrice = "€8.99", priceAmountMicros = 8_990_000))),
        )) assertFalse(selected.matches(fresh))
    }

    @Test
    fun trialSelectionRejectsAlteredProjectionAndMalformedPhaseValues() {
        val plan = trial()
        val valid = plan.channelValue().filterKeys { it != "productId" } +
            ("obfuscatedAccountId" to "opaque")
        for (change in listOf(
            mapOf("priceAmountMicros" to 0L),
            mapOf("offerId" to "unsupported"),
            mapOf("pricingPhases" to emptyList<Any>()),
            mapOf("pricingPhases" to listOf(plan.pricingPhases.first().channelValue()
                + ("billingCycleCount" to 1.0), plan.pricingPhases.last().channelValue())),
            mapOf("pricingPhases" to listOf(plan.pricingPhases.first().channelValue()
                + ("recurrenceMode" to 4), plan.pricingPhases.last().channelValue())),
        )) {
            assertEquals("invalid_request", assertThrows(BillingException::class.java) {
                PlayBillingPolicy.selection(valid + change)
            }.code)
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
        PlayBillingPhase(period, "€4.99", "EUR", price,
            if (infinite) 0 else 1, if (infinite) 1 else 2)

    private fun trial(base: String = "monthly", period: String = "P1M", freePeriod: String = "P2W") =
        PlayBillingPlan(base, "trial-token", "freetest", listOf(
            PlayBillingPhase(freePeriod, "€0.00", "EUR", 0, 1, 2), phase(period),
        ))

    private fun arguments(): Map<String, Any?> = mapOf(
        "basePlanId" to "monthly",
        "offerToken" to "selected-offer",
        "formattedPrice" to "€4.99",
        "currencyCode" to "EUR",
        "billingPeriod" to "P1M",
        "offerId" to null,
        "priceAmountMicros" to 4_990_000L,
        "pricingPhases" to listOf(phase("P1M").channelValue()),
        "obfuscatedAccountId" to "a".repeat(64),
    )
}
