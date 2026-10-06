package com.fuzevpn.android

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.android.billingclient.api.BillingClient
import com.android.billingclient.api.BillingClientStateListener
import com.android.billingclient.api.BillingFlowParams
import com.android.billingclient.api.BillingResult
import com.android.billingclient.api.PendingPurchasesParams
import com.android.billingclient.api.ProductDetails
import com.android.billingclient.api.Purchase
import com.android.billingclient.api.QueryProductDetailsParams
import com.android.billingclient.api.QueryPurchasesParams
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Google Play supplies purchase evidence; the server alone grants and acknowledges access. */
internal class PlayBillingBridge private constructor(
    private val activity: Activity,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private val main = Handler(Looper.getMainLooper())
    private val methods = MethodChannel(messenger, "com.fuzevpn/billing")
    private val events = EventChannel(messenger, "com.fuzevpn/billing/events")
    private val operations = linkedSetOf<Operation>()
    private val setupWaiters = linkedMapOf<Operation, (BillingClient) -> Unit>()
    private var eventSink: EventChannel.EventSink? = null
    private var billingClient: BillingClient? = null
    private var clientGeneration = 0
    private var connectionEstablished = false
    private var connecting = false
    private var setupTimeout: Runnable? = null
    private var closed = false
    private var hostResumed = false
    private var recoveringFlow: Long? = null
    private var accountGeneration = 0L
    private var preparingLaunch: Operation? = null

    init {
        methods.setMethodCallHandler(this)
        events.setStreamHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) = onMain {
        if (closed) {
            result.error("unavailable", "unavailable", null)
            return@onMain
        }
        if (call.method !in METHOD_NAMES) {
            result.notImplemented()
            return@onMain
        }
        if (call.method == "invalidateAccount") {
            if (call.arguments != null) {
                result.error("invalid_request", "invalid_request", null)
            } else {
                accountGeneration += 1
                if (flowGate.invalidatePreparation() != null) preparingLaunch?.fail("cancelled")
                result.success(null)
            }
            return@onMain
        }
        if (operations.size >= MAX_OPERATIONS) {
            result.error("busy", "busy", null)
            return@onMain
        }
        val operation = operation(
            success = { result.success(it) },
            failure = { result.error(it, it, null) },
        )
        safely(operation) {
            when (call.method) {
                "queryPremiumPlans" -> queryProducts(operation) { plans ->
                    operation.succeed(plans.map { it.plan.channelValue() })
                }
                "queryOwnedPurchases" -> queryPurchases(operation) { purchases ->
                    operation.succeed(purchases)
                }
                "launchSubscription" -> launchSubscription(call.arguments, operation)
                "openSubscriptionManagement" -> {
                    if (call.arguments != null || !usableActivity()) {
                        throw BillingException("invalid_request")
                    }
                    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(MANAGEMENT_URL)))
                    operation.succeed(null)
                }
            }
        }
    }

    override fun onListen(arguments: Any?, sink: EventChannel.EventSink) = onMain {
        if (!closed) eventSink = sink
    }

    override fun onCancel(arguments: Any?) = onMain { eventSink = null }

    fun onActivityPaused() = onMain {
        hostResumed = false
        flowGate.onHostPaused()
    }

    fun onActivityResumed() = onMain {
        if (closed) return@onMain
        hostResumed = true
        // Purchase updates normally arrive first. Query on return also recovers a lost
        // listener callback, including when Android has recreated the host Activity.
        val flowId = flowGate.returnedFlow() ?: return@onMain
        main.postDelayed({ recoverReturnedFlow(flowId) }, RECOVERY_DELAY_MS)
    }

    fun close() = onMain {
        if (closed) return@onMain
        closed = true
        hostResumed = false
        setupTimeout?.let(main::removeCallbacks)
        setupTimeout = null
        operations.toList().forEach { it.fail("unavailable") }
        setupWaiters.clear()
        eventSink = null
        methods.setMethodCallHandler(null)
        events.setStreamHandler(null)
        destroyClient()
        if (activeBridge === this) activeBridge = null
    }

    private fun launchSubscription(arguments: Any?, operation: Operation) {
        val selection = PlayBillingPolicy.selection(arguments)
        if (!usableActivity() || !hostResumed) throw BillingException("unavailable")
        val flowId = flowGate.reserve(selection.obfuscatedAccountId) ?: throw BillingException("busy")
        val generation = accountGeneration
        preparingLaunch = operation
        operation.onFinished = {
            if (preparingLaunch === operation) preparingLaunch = null
            if (!flowGate.isLaunched(flowId)) flowGate.release(flowId)
        }
        replaceClientForLaunch(operation)
        // Both purchased and pending premium evidence block duplicate checkout.
        // Ownership/access validation and acknowledgement still belong to the server.
        queryPurchases(operation) { owned ->
            if (owned.isNotEmpty()) throw BillingException("already_owned")
            queryProducts(operation) { plans ->
                launchFreshSelection(selection, flowId, generation, operation, plans)
            }
        }
    }

    private fun launchFreshSelection(
        selection: PlayBillingSelection,
        flowId: Long,
        generation: Long,
        operation: Operation,
        plans: List<NativePlan>,
    ) {
        if (!operation.active || generation != accountGeneration ||
            flowGate.currentFlowId() != flowId
        ) throw BillingException("cancelled")
        // ProductDetails are freshly fetched. Never substitute a new price or offer.
        val selected = plans.singleOrNull { selection.matches(it.plan) }
            ?: throw BillingException("price_changed")
        if (!usableActivity() || !hostResumed) throw BillingException("unavailable")
        val client = billingClient ?: throw BillingException("unavailable")
        val product = BillingFlowParams.ProductDetailsParams.newBuilder()
            .setProductDetails(selected.details)
            .setOfferToken(selected.plan.offerToken)
            .build()
        val params = BillingFlowParams.newBuilder()
            .setProductDetailsParamsList(listOf(product))
            .setObfuscatedAccountId(selection.obfuscatedAccountId)
            .build()
        flowGate.markLaunched(flowId)
        val response = try {
            client.launchBillingFlow(activity, params)
        } catch (_: Exception) {
            flowGate.release(flowId)
            throw BillingException("unavailable")
        }
        if (response.responseCode == BillingClient.BillingResponseCode.OK) {
            // This confirms only that the payment sheet opened, never payment/access.
            operation.succeed(null)
        } else {
            flowGate.release(flowId)
            operation.fail(safeCode(response.responseCode))
        }
    }

    private fun queryProducts(operation: Operation, completion: (List<NativePlan>) -> Unit) {
        withClient(operation) { client ->
            if (client.isFeatureSupported(BillingClient.FeatureType.SUBSCRIPTIONS).responseCode !=
                BillingClient.BillingResponseCode.OK ||
                client.isFeatureSupported(BillingClient.FeatureType.PRODUCT_DETAILS).responseCode !=
                BillingClient.BillingResponseCode.OK
            ) throw BillingException("unavailable")
            val query = QueryProductDetailsParams.newBuilder().setProductList(
                listOf(QueryProductDetailsParams.Product.newBuilder()
                    .setProductId(PlayBillingPolicy.PRODUCT_ID)
                    .setProductType(BillingClient.ProductType.SUBS)
                    .build()),
            ).build()
            client.queryProductDetailsAsync(query) { result, details -> onMain {
                if (!operation.active || billingClient !== client) return@onMain
                safely(operation) {
                    if (result.responseCode != BillingClient.BillingResponseCode.OK) {
                        operation.fail(safeCode(result.responseCode))
                    } else {
                        completion(normalPlans(details.productDetailsList))
                    }
                }
            } }
        }
    }

    private fun normalPlans(details: List<ProductDetails>): List<NativePlan> {
        val candidates = details.filter {
            it.productId == PlayBillingPolicy.PRODUCT_ID &&
                it.productType == BillingClient.ProductType.SUBS
        }.flatMap { product ->
            product.subscriptionOfferDetails.orEmpty().mapNotNull { offer ->
                val phases = offer.pricingPhases.pricingPhaseList.map { phase ->
                    PlayBillingPhase(
                        phase.billingPeriod, phase.formattedPrice, phase.priceCurrencyCode,
                        phase.priceAmountMicros,
                        phase.recurrenceMode == ProductDetails.RecurrenceMode.INFINITE_RECURRING,
                    )
                }
                if (!PlayBillingPolicy.isNormalBasePlan(
                        product.productId, offer.basePlanId, offer.offerId,
                        offer.installmentPlanDetails != null, phases,
                    ) || offer.offerToken.isBlank()
                ) null else NativePlan(
                    product, PlayBillingPlan(offer.basePlanId, offer.offerToken, phases.single()),
                )
            }
        }
        // An ambiguous configuration cannot silently choose between equivalent offers.
        val counts = candidates.groupingBy { it.plan.basePlanId }.eachCount()
        return candidates.filter { counts[it.plan.basePlanId] == 1 }
            .sortedBy { if (it.plan.basePlanId == "monthly") 0 else 1 }
    }

    private fun queryPurchases(
        operation: Operation,
        completion: (List<Map<String, Any?>>) -> Unit,
    ) {
        withClient(operation) { client ->
            val query = QueryPurchasesParams.newBuilder()
                .setProductType(BillingClient.ProductType.SUBS).build()
            client.queryPurchasesAsync(query) { result, purchases -> onMain {
                if (!operation.active || billingClient !== client) return@onMain
                safely(operation) {
                    if (result.responseCode != BillingClient.BillingResponseCode.OK) {
                        operation.fail(safeCode(result.responseCode))
                    } else completion(purchaseValues(purchases))
                }
            } }
        }
    }

    private fun purchaseValues(purchases: List<Purchase>): List<Map<String, Any?>> =
        purchases.mapNotNull { purchase ->
            if (PlayBillingPolicy.PRODUCT_ID !in purchase.products ||
                purchase.purchaseToken.isBlank()
            ) return@mapNotNull null
            val state = when (purchase.purchaseState) {
                Purchase.PurchaseState.PURCHASED -> "purchased"
                Purchase.PurchaseState.PENDING -> "pending"
                else -> return@mapNotNull null
            }
            mapOf(
                "productId" to PlayBillingPolicy.PRODUCT_ID,
                "purchaseToken" to purchase.purchaseToken,
                "state" to state,
                "obfuscatedAccountId" to purchase.accountIdentifiers?.obfuscatedAccountId,
                "acknowledged" to purchase.isAcknowledged,
            )
        }

    private fun onPurchaseUpdate(
        result: BillingResult,
        purchases: List<Purchase>?,
        listenerFlowId: Long?,
        listenerOwnerId: String?,
    ) {
        when (result.responseCode) {
            BillingClient.BillingResponseCode.OK -> {
                val values = purchaseValues(purchases.orEmpty())
                if (listenerFlowId != null && flowGate.isLaunched(listenerFlowId) &&
                    values.any { it["obfuscatedAccountId"] == listenerOwnerId }
                ) flowGate.release(listenerFlowId)
                emit(mapOf("type" to "purchases", "purchases" to values))
            }
            else -> {
                // A duplicate or late completion must not alter a subsequent launch.
                if (listenerFlowId != null && !flowGate.isLaunched(listenerFlowId)) return
                listenerFlowId?.let(flowGate::release)
                val event = linkedMapOf<String, Any?>(
                    "type" to if (result.responseCode == BillingClient.BillingResponseCode.USER_CANCELED)
                        "cancelled" else "error",
                    "code" to safeCode(result.responseCode),
                )
                if (listenerOwnerId != null) event["obfuscatedAccountId"] = listenerOwnerId
                emit(event)
            }
        }
    }

    private fun recoverReturnedFlow(flowId: Long) {
        if (closed || !hostResumed || !usableActivity() ||
            flowGate.returnedFlow() != flowId || recoveringFlow == flowId
        ) return
        recoveringFlow = flowId
        val ownerId = flowGate.ownerFor(flowId)
        var shouldEmit = false
        val recovery = operation(
            success = { purchases -> if (shouldEmit) emit(mapOf(
                "type" to "purchases", "purchases" to purchases,
                "obfuscatedAccountId" to ownerId,
            )) },
            failure = { code -> if (shouldEmit) emit(mapOf(
                "type" to "error", "code" to code, "obfuscatedAccountId" to ownerId,
            )) },
        )
        recovery.onFinished = {
            recoveringFlow = null
            // A closed Activity transfers recovery responsibility to its replacement.
            shouldEmit = !closed && flowGate.currentFlowId() == flowId
            if (shouldEmit) flowGate.release(flowId)
        }
        safely(recovery) { queryPurchases(recovery) { recovery.succeed(it) } }
    }

    private fun withClient(operation: Operation, action: (BillingClient) -> Unit) {
        if (!operation.active) return
        val client = billingClient ?: createClient()
        if (connectionEstablished || client.isReady) {
            // Subsequent disconnections are handled by SDK automatic reconnection.
            action(client)
            return
        }
        setupWaiters[operation] = action
        if (connecting) return
        connecting = true
        val generation = clientGeneration
        val timeout = Runnable {
            if (!closed && connecting && generation == clientGeneration) {
                failSetup("network")
            }
        }
        setupTimeout = timeout
        main.postDelayed(timeout, SETUP_TIMEOUT_MS)
        try {
            client.startConnection(object : BillingClientStateListener {
                override fun onBillingSetupFinished(result: BillingResult) = onMain {
                    if (closed || generation != clientGeneration || !connecting) return@onMain
                    setupTimeout?.let(main::removeCallbacks)
                    setupTimeout = null
                    if (result.responseCode != BillingClient.BillingResponseCode.OK) {
                        failSetup(safeCode(result.responseCode))
                        return@onMain
                    }
                    connecting = false
                    connectionEstablished = true
                    val waiting = setupWaiters.toMap()
                    setupWaiters.clear()
                    waiting.forEach { (request, work) ->
                        if (request.active) safely(request) { work(client) }
                    }
                }

                override fun onBillingServiceDisconnected() {
                    // enableAutoServiceReconnection handles the next request.
                }
            })
        } catch (_: Exception) {
            failSetup("unavailable")
        }
    }

    private fun createClient(): BillingClient {
        val generation = ++clientGeneration
        val listenerFlowId = flowGate.currentFlowId()
        val listenerOwnerId = listenerFlowId?.let(flowGate::ownerFor)
        return BillingClient.newBuilder(activity.applicationContext)
            .setListener { result, purchases -> onMain {
                if (!closed && generation == clientGeneration && activeBridge === this) {
                    onPurchaseUpdate(result, purchases, listenerFlowId, listenerOwnerId)
                }
            } }
            // Billing 9 requires this configuration even for subscription-only clients.
            .enablePendingPurchases(PendingPurchasesParams.newBuilder()
                .enableOneTimeProducts().build())
            .enableAutoServiceReconnection()
            .build().also { billingClient = it }
    }

    private fun replaceClientForLaunch(launch: Operation) {
        // Listener ownership is fixed for one launch. Closing the previous generation
        // prevents its late callbacks from being attributed to a new account/launch.
        setupTimeout?.let(main::removeCallbacks)
        setupTimeout = null
        setupWaiters.clear()
        destroyClient()
        operations.toList().filter { it !== launch }.forEach { it.fail("unavailable") }
    }

    private fun failSetup(code: String) {
        setupTimeout?.let(main::removeCallbacks)
        setupTimeout = null
        val waiting = setupWaiters.keys.toList()
        setupWaiters.clear()
        destroyClient()
        waiting.forEach { it.fail(code) }
    }

    private fun destroyClient() {
        clientGeneration += 1
        connectionEstablished = false
        connecting = false
        val oldClient = billingClient
        billingClient = null
        try { oldClient?.endConnection() } catch (_: Exception) { /* no SDK diagnostics */ }
    }

    private fun operation(success: (Any?) -> Unit, failure: (String) -> Unit): Operation =
        Operation(success, failure).also {
            operations.add(it)
            main.postDelayed(it.timeout, OPERATION_TIMEOUT_MS)
        }

    private inner class Operation(
        private val success: (Any?) -> Unit,
        private val failure: (String) -> Unit,
    ) {
        val active: Boolean get() = !closed && this in operations
        val timeout = Runnable { fail("network") }
        var onFinished: (() -> Unit)? = null

        fun succeed(value: Any?) = finish { success(value) }
        fun fail(code: String) = finish { failure(code) }

        private fun finish(completion: () -> Unit) {
            if (!operations.remove(this)) return
            main.removeCallbacks(timeout)
            setupWaiters.remove(this)
            onFinished?.invoke()
            // A destroyed Flutter engine can no longer receive its result; it must
            // still be completed locally and must not crash the replacement Activity.
            try { completion() } catch (_: Exception) { /* disposed messenger */ }
        }
    }

    private fun safely(operation: Operation, action: () -> Unit) {
        try { action() }
        catch (error: BillingException) { operation.fail(error.code) }
        catch (_: Exception) { operation.fail("unavailable") }
    }

    private fun emit(event: Map<String, Any?>) {
        if (!closed) {
            try { eventSink?.success(event) } catch (_: Exception) { /* disposed messenger */ }
        }
    }

    private fun usableActivity(): Boolean = !activity.isFinishing && !activity.isDestroyed

    private fun onMain(action: () -> Unit) {
        if (Looper.myLooper() == Looper.getMainLooper()) action() else main.post { action() }
    }

    private class NativePlan(val details: ProductDetails, val plan: PlayBillingPlan)

    companion object {
        private const val SETUP_TIMEOUT_MS = 12_000L
        private const val OPERATION_TIMEOUT_MS = 20_000L
        private const val RECOVERY_DELAY_MS = 500L
        private const val MAX_OPERATIONS = 16
        private const val MANAGEMENT_URL =
            "https://play.google.com/store/account/subscriptions?sku=premium&package=com.fuzevpn"
        private val METHOD_NAMES = setOf(
            "queryPremiumPlans", "launchSubscription", "queryOwnedPurchases", "openSubscriptionManagement",
            "invalidateAccount",
        )
        private var activeBridge: PlayBillingBridge? = null
        private val flowGate = PlayBillingFlowGate()

        fun attach(activity: Activity, messenger: BinaryMessenger): PlayBillingBridge {
            check(Looper.myLooper() == Looper.getMainLooper())
            activeBridge?.close()
            return PlayBillingBridge(activity, messenger).also { activeBridge = it }
        }

        private fun safeCode(code: Int): String = when (code) {
            BillingClient.BillingResponseCode.USER_CANCELED -> "cancelled"
            BillingClient.BillingResponseCode.ITEM_ALREADY_OWNED -> "already_owned"
            BillingClient.BillingResponseCode.NETWORK_ERROR,
            BillingClient.BillingResponseCode.SERVICE_DISCONNECTED,
            BillingClient.BillingResponseCode.SERVICE_UNAVAILABLE,
            BillingClient.BillingResponseCode.SERVICE_TIMEOUT -> "network"
            else -> "unavailable"
        }
    }
}
