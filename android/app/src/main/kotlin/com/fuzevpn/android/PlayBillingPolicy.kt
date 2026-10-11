package com.fuzevpn.android

/** Values used at the billing boundary; none of these values grant VPN access. */
internal object PlayBillingPolicy {
    const val PRODUCT_ID = "premium"
    const val FREE_TRIAL_OFFER_ID = "freetest"
    const val INFINITE_RECURRING = 1
    const val FINITE_RECURRING = 2
    const val NON_RECURRING = 3
    val billingPeriods = mapOf("monthly" to "P1M", "yearly" to "P1Y")
    private val accountPattern = Regex("[A-Za-z0-9_-]{1,64}")
    private val selectionKeys = setOf(
        "basePlanId", "offerToken", "formattedPrice", "currencyCode",
        "billingPeriod", "obfuscatedAccountId",
        "offerId", "priceAmountMicros", "pricingPhases",
    )

    fun isOpaqueAccountId(value: String): Boolean = accountPattern.matches(value)

    fun selection(arguments: Any?): PlayBillingSelection {
        val values = arguments as? Map<*, *> ?: throw BillingException("invalid_request")
        if (values.keys != selectionKeys) throw BillingException("invalid_request")
        fun field(key: String, maximum: Int): String {
            val value = values[key] as? String ?: throw BillingException("invalid_request")
            if (value.isBlank() || value.length > maximum) throw BillingException("invalid_request")
            return value
        }
        val basePlanId = field("basePlanId", 32)
        val period = field("billingPeriod", 16)
        val accountId = field("obfuscatedAccountId", 64)
        val currency = field("currencyCode", 3)
        if (billingPeriods[basePlanId] != period || !isOpaqueAccountId(accountId) ||
            !Regex("[A-Z]{3}").matches(currency)
        ) throw BillingException("invalid_request")
        val rawOfferId = values["offerId"]
        if (rawOfferId != null && rawOfferId != FREE_TRIAL_OFFER_ID) throw BillingException("invalid_request")
        val offerId = rawOfferId as String?
        val price = integer(values["priceAmountMicros"]) ?: throw BillingException("invalid_request")
        val phaseValues = values["pricingPhases"] as? List<*> ?: throw BillingException("invalid_request")
        if (phaseValues.size !in 1..2) throw BillingException("invalid_request")
        val phases = phaseValues.map(::readPhase)
        if (!isSupportedOffer(PRODUCT_ID, basePlanId, offerId, false, phases)) {
            throw BillingException("invalid_request")
        }
        val paid = phases.last()
        val formattedPrice = field("formattedPrice", 128)
        if (paid.priceAmountMicros != price || paid.formattedPrice != formattedPrice ||
            paid.currencyCode != currency || paid.billingPeriod != period
        ) throw BillingException("invalid_request")
        return PlayBillingSelection(
            PlayBillingPlan(basePlanId, field("offerToken", 4096), offerId, phases), accountId,
        )
    }

    private fun integer(value: Any?): Long? = when (value) {
        is Int -> value.toLong()
        is Long -> value
        else -> null
    }

    private fun readPhase(raw: Any?): PlayBillingPhase {
        val values = raw as? Map<*, *> ?: throw BillingException("invalid_request")
        if (values.keys != setOf("billingPeriod", "formattedPrice", "currencyCode",
                "priceAmountMicros", "billingCycleCount", "recurrenceMode")) {
            throw BillingException("invalid_request")
        }
        fun text(key: String, maximum: Int): String {
            val value = values[key] as? String ?: throw BillingException("invalid_request")
            if (value.isBlank() || value.length > maximum) throw BillingException("invalid_request")
            return value
        }
        fun count(key: String): Int {
            val value = integer(values[key]) ?: throw BillingException("invalid_request")
            if (value < 0 || value > Int.MAX_VALUE) throw BillingException("invalid_request")
            return value.toInt()
        }
        return PlayBillingPhase(text("billingPeriod", 16), text("formattedPrice", 128),
            text("currencyCode", 3), integer(values["priceAmountMicros"])
                ?: throw BillingException("invalid_request"), count("billingCycleCount"), count("recurrenceMode"))
    }

    fun isNormalBasePlan(
        productId: String,
        basePlanId: String,
        offerId: String?,
        hasInstallmentPlan: Boolean,
        phases: List<PlayBillingPhase>,
    ): Boolean {
        val phase = phases.singleOrNull() ?: return false
        return productId == PRODUCT_ID && billingPeriods[basePlanId] == phase.billingPeriod &&
            offerId == null && !hasInstallmentPlan && phase.infiniteRecurring &&
            phase.billingCycleCount == 0 && phase.priceAmountMicros > 0 && validPhase(phase)
    }

    fun isSupportedOffer(
        productId: String,
        basePlanId: String,
        offerId: String?,
        hasInstallmentPlan: Boolean,
        phases: List<PlayBillingPhase>,
    ): Boolean {
        if (offerId == null) return isNormalBasePlan(
            productId, basePlanId, offerId, hasInstallmentPlan, phases,
        )
        if (productId != PRODUCT_ID || offerId != FREE_TRIAL_OFFER_ID ||
            hasInstallmentPlan || phases.size != 2 || !phases.all(::validPhase)
        ) return false
        val free = phases.first()
        val paid = phases.last()
        return free.priceAmountMicros == 0L && free.billingPeriod in setOf("P2W", "P14D") &&
            ((free.recurrenceMode == FINITE_RECURRING && free.billingCycleCount == 1) ||
                (free.recurrenceMode == NON_RECURRING && free.billingCycleCount == 0)) &&
            isNormalBasePlan(productId, basePlanId, null, false, listOf(paid)) &&
            free.currencyCode == paid.currencyCode
    }

    private fun validPhase(phase: PlayBillingPhase): Boolean =
        phase.priceAmountMicros >= 0 && phase.formattedPrice.isNotBlank() &&
            phase.formattedPrice.length <= 128 && Regex("[A-Z]{3}").matches(phase.currencyCode) &&
            Regex("P[1-9][0-9]*[DWMY]").matches(phase.billingPeriod) &&
            when (phase.recurrenceMode) {
                FINITE_RECURRING -> phase.billingCycleCount > 0
                INFINITE_RECURRING, NON_RECURRING -> phase.billingCycleCount == 0
                else -> false
            }

    /** Only queried offers are considered; absence never invents trial eligibility. */
    fun preferredPlans(plans: List<PlayBillingPlan>): List<PlayBillingPlan> =
        billingPeriods.keys.mapNotNull { basePlan ->
            val supported = plans.filter {
                it.basePlanId == basePlan && it.offerToken.isNotBlank() &&
                    isSupportedOffer(PRODUCT_ID, it.basePlanId, it.offerId, false, it.pricingPhases)
            }
            val trials = supported.filter { it.offerId == FREE_TRIAL_OFFER_ID }
            // Ambiguous trials cannot replace an unambiguous normal base plan.
            trials.singleOrNull() ?: supported.filter { it.offerId == null }.singleOrNull()
        }
}

internal class BillingException(val code: String) : RuntimeException(code)

internal data class PlayBillingPhase(
    val billingPeriod: String,
    val formattedPrice: String,
    val currencyCode: String,
    val priceAmountMicros: Long,
    val billingCycleCount: Int,
    val recurrenceMode: Int,
) {
    val infiniteRecurring: Boolean get() = recurrenceMode == PlayBillingPolicy.INFINITE_RECURRING

    fun channelValue(): Map<String, Any> = mapOf(
        "formattedPrice" to formattedPrice, "priceAmountMicros" to priceAmountMicros,
        "currencyCode" to currencyCode, "billingPeriod" to billingPeriod,
        "billingCycleCount" to billingCycleCount, "recurrenceMode" to recurrenceMode,
    )
}

internal class PlayBillingSelection(
    private val selected: PlayBillingPlan,
    val obfuscatedAccountId: String,
) {
    val basePlanId: String get() = selected.basePlanId
    fun matches(plan: PlayBillingPlan): Boolean = selected == plan
}

internal data class PlayBillingPlan(
    val basePlanId: String,
    val offerToken: String,
    val offerId: String?,
    val pricingPhases: List<PlayBillingPhase>,
) {
    val phase: PlayBillingPhase get() = pricingPhases.last()
    fun channelValue(): Map<String, Any?> = mapOf(
        "productId" to PlayBillingPolicy.PRODUCT_ID,
        "basePlanId" to basePlanId,
        "offerToken" to offerToken,
        "offerId" to offerId,
        "pricingPhases" to pricingPhases.map { it.channelValue() },
        "formattedPrice" to phase.formattedPrice,
        "currencyCode" to phase.currencyCode,
        "billingPeriod" to phase.billingPeriod,
        "priceAmountMicros" to phase.priceAmountMicros,
    )
}

/** A process-wide guard also covers an Activity being recreated while Play is open. */
internal class PlayBillingFlowGate {
    private var nextId = 0L
    private var activeId: Long? = null
    private var accountId: String? = null
    private var launched = false
    private var leftHost = false

    fun reserve(ownerId: String? = null): Long? {
        if (activeId != null) return null
        nextId += 1
        activeId = nextId
        accountId = ownerId
        launched = false
        leftHost = false
        return activeId
    }

    fun markLaunched(id: Long) {
        if (activeId == id) launched = true
    }

    fun isLaunched(id: Long): Boolean = activeId == id && launched

    fun currentFlowId(): Long? = activeId

    fun ownerFor(id: Long): String? = if (activeId == id) accountId else null

    fun invalidatePreparation(): Long? {
        val id = activeId ?: return null
        if (launched) return null
        release(id)
        return id
    }

    fun onHostPaused() {
        if (launched) leftHost = true
    }

    fun returnedFlow(): Long? = activeId?.takeIf { launched && leftHost }

    fun release(id: Long) {
        if (activeId != id) return
        activeId = null
        accountId = null
        launched = false
        leftHost = false
    }

    fun finishLaunched() {
        if (launched) activeId?.let(::release)
    }
}
