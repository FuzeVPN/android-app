package com.fuzevpn.android

/** Values used at the billing boundary; none of these values grant VPN access. */
internal object PlayBillingPolicy {
    const val PRODUCT_ID = "premium"
    val billingPeriods = mapOf("monthly" to "P1M", "yearly" to "P1Y")
    private val accountPattern = Regex("[A-Za-z0-9_-]{1,64}")
    private val selectionKeys = setOf(
        "basePlanId", "offerToken", "formattedPrice", "currencyCode",
        "billingPeriod", "obfuscatedAccountId",
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
        return PlayBillingSelection(
            basePlanId, field("offerToken", 4096), field("formattedPrice", 128),
            currency, period, accountId,
        )
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
            phase.priceAmountMicros > 0 && phase.formattedPrice.isNotBlank() &&
            Regex("[A-Z]{3}").matches(phase.currencyCode)
    }
}

internal class BillingException(val code: String) : RuntimeException(code)

internal class PlayBillingPhase(
    val billingPeriod: String,
    val formattedPrice: String,
    val currencyCode: String,
    val priceAmountMicros: Long,
    val infiniteRecurring: Boolean,
)

internal class PlayBillingSelection(
    val basePlanId: String,
    val offerToken: String,
    val formattedPrice: String,
    val currencyCode: String,
    val billingPeriod: String,
    val obfuscatedAccountId: String,
) {
    fun matches(plan: PlayBillingPlan): Boolean =
        basePlanId == plan.basePlanId && offerToken == plan.offerToken &&
            formattedPrice == plan.phase.formattedPrice && currencyCode == plan.phase.currencyCode &&
            billingPeriod == plan.phase.billingPeriod
}

internal class PlayBillingPlan(
    val basePlanId: String,
    val offerToken: String,
    val phase: PlayBillingPhase,
) {
    fun channelValue(): Map<String, Any> = mapOf(
        "productId" to PlayBillingPolicy.PRODUCT_ID,
        "basePlanId" to basePlanId,
        "offerToken" to offerToken,
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
