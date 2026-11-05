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
import com.android.billingclient.api.PurchasesResponseListener
import com.android.billingclient.api.PurchasesUpdatedListener
import com.android.billingclient.api.QueryProductDetailsParams
import com.android.billingclient.api.QueryPurchasesParams
import com.fuzevpn.android.PlayBillingBridge.NativePlan
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Google Play supplies purchase evidence; the server alone grants and acknowledges access. */
internal class PlayBillingBridge private constructor(
    private val host: PlayBillingHost,
    messenger: BinaryMessenger,
    private val flowGate: PlayBillingFlowGate,
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private val methods = MethodChannel(messenger, "com.fuzevpn/billing")
    private val events = EventChannel(messenger, "com.fuzevpn/billing/events")
    private val operations = linkedSetOf<Operation>()
    private val setupWaiters = linkedMapOf<Operation, (PlayBillingClient) -> Unit>()
    private var eventSink: EventChannel.EventSink? = null
    private var billingClient: PlayBillingClient? = null
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
                    host.openSubscriptionManagement(MANAGEMENT_URL)
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
        host.postDelayed({ recoverReturnedFlow(flowId) }, RECOVERY_DELAY_MS)
    }

    fun close() = onMain {
        if (closed) return@onMain
        closed = true
        hostResumed = false
        setupTimeout?.let(host::removeCallbacks)
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
        // Existing premium evidence, including pending and suspended, blocks duplicate checkout.
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
        val launch = client.billingFlow(selected, selection.obfuscatedAccountId)
        flowGate.markLaunched(flowId)
        val response = try {
            launch()
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
            client.queryProductDetailsAsync(query) { result, plans -> onMain {
                if (!operation.active || billingClient !== client) return@onMain
                safely(operation) {
                    if (result.responseCode != BillingClient.BillingResponseCode.OK) {
                        operation.fail(safeCode(result.responseCode))
                    } else {
                        completion(plans())
                    }
                }
            } }
        }
    }

    private fun queryPurchases(
        operation: Operation,
        completion: (List<Map<String, Any?>>) -> Unit,
    ) {
        withClient(operation) { client ->
            val query = PlayBillingPurchases.query()
            client.queryPurchasesAsync(query) { result, purchases -> onMain {
                if (!operation.active || billingClient !== client) return@onMain
                safely(operation) {
                    if (result.responseCode != BillingClient.BillingResponseCode.OK) {
                        operation.fail(safeCode(result.responseCode))
                    } else completion(PlayBillingPurchases.channelValues(purchases))
                }
            } }
        }
    }

    private fun onPurchaseUpdate(
        result: BillingResult,
        purchases: List<Purchase>?,
        listenerFlowId: Long?,
        listenerOwnerId: String?,
    ) {
        when (result.responseCode) {
            BillingClient.BillingResponseCode.OK -> {
                val values = PlayBillingPurchases.channelValues(purchases.orEmpty())
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

    private fun withClient(operation: Operation, action: (PlayBillingClient) -> Unit) {
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
        host.postDelayed(timeout, SETUP_TIMEOUT_MS)
        try {
            client.startConnection(object : BillingClientStateListener {
                override fun onBillingSetupFinished(result: BillingResult) = onMain {
                    if (closed || generation != clientGeneration || !connecting) return@onMain
                    setupTimeout?.let(host::removeCallbacks)
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

    private fun createClient(): PlayBillingClient {
        val generation = ++clientGeneration
        val listenerFlowId = flowGate.currentFlowId()
        val listenerOwnerId = listenerFlowId?.let(flowGate::ownerFor)
        return host.newClient { result, purchases -> onMain {
            if (!closed && generation == clientGeneration && activeBridge === this) {
                onPurchaseUpdate(result, purchases, listenerFlowId, listenerOwnerId)
            }
        } }.also { billingClient = it }
    }

    private fun replaceClientForLaunch(launch: Operation) {
        // Listener ownership is fixed for one launch. Closing the previous generation
        // prevents its late callbacks from being attributed to a new account/launch.
        setupTimeout?.let(host::removeCallbacks)
        setupTimeout = null
        setupWaiters.clear()
        destroyClient()
        operations.toList().filter { it !== launch }.forEach { it.fail("unavailable") }
    }

    private fun failSetup(code: String) {
        setupTimeout?.let(host::removeCallbacks)
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
            host.postDelayed(it.timeout, OPERATION_TIMEOUT_MS)
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
            host.removeCallbacks(timeout)
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

    private fun usableActivity(): Boolean = host.isUsable

    private fun onMain(action: () -> Unit) {
        if (host.isMainThread) action() else host.post { action() }
    }

    /** [details] is the SDK product, opaque outside the client that returned it. */
    internal class NativePlan(val details: Any, val plan: PlayBillingPlan)

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
        private val processFlowGate = PlayBillingFlowGate()

        fun attach(activity: Activity, messenger: BinaryMessenger): PlayBillingBridge =
            attach(ActivityBillingHost(activity), messenger, processFlowGate)

        /** Production passes the process-wide gate; JVM tests pass their own. */
        internal fun attach(
            host: PlayBillingHost,
            messenger: BinaryMessenger,
            gate: PlayBillingFlowGate,
        ): PlayBillingBridge {
            check(host.isMainThread)
            activeBridge?.close()
            return PlayBillingBridge(host, messenger, gate).also { activeBridge = it }
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

/** Effects of [PlayBillingBridge] outside its decisions; JVM tests substitute doubles. */
internal interface PlayBillingHost {
    val isMainThread: Boolean
    val isUsable: Boolean
    fun post(action: Runnable)
    fun postDelayed(action: Runnable, delayMillis: Long)
    fun removeCallbacks(action: Runnable)
    fun openSubscriptionManagement(url: String)
    fun newClient(updates: PurchasesUpdatedListener): PlayBillingClient
}

/** Play Billing calls of [PlayBillingBridge]; SDK products and the Activity stay in the host. */
internal interface PlayBillingClient {
    val isReady: Boolean
    fun startConnection(listener: BillingClientStateListener)
    fun isFeatureSupported(feature: String): BillingResult
    /** The listener receives the normalisation to run itself, on the main thread. */
    fun queryProductDetailsAsync(
        params: QueryProductDetailsParams,
        listener: (BillingResult, () -> List<NativePlan>) -> Unit,
    )
    fun queryPurchasesAsync(params: QueryPurchasesParams, listener: PurchasesResponseListener)
    /** Builds Play's request for exactly [plan] and [obfuscatedAccountId]; invoking it opens Play. */
    fun billingFlow(plan: NativePlan, obfuscatedAccountId: String): () -> BillingResult
    fun endConnection()
}

/** The Activity, its main Looper and the Play Billing SDK client. */
private class ActivityBillingHost(private val activity: Activity) : PlayBillingHost {
    private val main = Handler(Looper.getMainLooper())
    override val isMainThread: Boolean get() = Looper.myLooper() == Looper.getMainLooper()
    override val isUsable: Boolean get() = !activity.isFinishing && !activity.isDestroyed
    override fun post(action: Runnable) { main.post(action) }
    override fun postDelayed(action: Runnable, delayMillis: Long) { main.postDelayed(action, delayMillis) }
    override fun removeCallbacks(action: Runnable) = main.removeCallbacks(action)
    override fun openSubscriptionManagement(url: String) =
        activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))

    override fun newClient(updates: PurchasesUpdatedListener): PlayBillingClient {
        val client = BillingClient.newBuilder(activity.applicationContext)
            .setListener(updates)
            // Billing 9 requires this configuration even for subscription-only clients.
            .enablePendingPurchases(PendingPurchasesParams.newBuilder()
                .enableOneTimeProducts().build())
            .enableAutoServiceReconnection()
            .build()
        return object : PlayBillingClient {
            override val isReady: Boolean get() = client.isReady
            override fun startConnection(listener: BillingClientStateListener) =
                client.startConnection(listener)
            override fun isFeatureSupported(feature: String): BillingResult =
                client.isFeatureSupported(feature)
            override fun queryProductDetailsAsync(
                params: QueryProductDetailsParams,
                listener: (BillingResult, () -> List<NativePlan>) -> Unit,
            ) = client.queryProductDetailsAsync(params) { result, details ->
                listener(result) { normalPlans(details.productDetailsList) }
            }
            override fun queryPurchasesAsync(params: QueryPurchasesParams, listener: PurchasesResponseListener) =
                client.queryPurchasesAsync(params, listener)
            override fun billingFlow(plan: NativePlan, obfuscatedAccountId: String): () -> BillingResult {
                val product = BillingFlowParams.ProductDetailsParams.newBuilder()
                    .setProductDetails(plan.details as ProductDetails)
                    .setOfferToken(plan.plan.offerToken)
                    .build()
                val params = BillingFlowParams.newBuilder()
                    .setProductDetailsParamsList(listOf(product))
                    .setObfuscatedAccountId(obfuscatedAccountId)
                    .build()
                return { client.launchBillingFlow(activity, params) }
            }
            override fun endConnection() = client.endConnection()
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
                        phase.billingCycleCount, phase.recurrenceMode,
                    )
                }
                if (!PlayBillingPolicy.isSupportedOffer(
                        product.productId, offer.basePlanId, offer.offerId,
                        offer.installmentPlanDetails != null, phases,
                    ) || offer.offerToken.isBlank()
                ) null else NativePlan(
                    product, PlayBillingPlan(offer.basePlanId, offer.offerToken, offer.offerId, phases),
                )
            }
        }
        val preferred = PlayBillingPolicy.preferredPlans(candidates.map { it.plan })
        return preferred.map { selected -> candidates.single { it.plan === selected } }
    }
}
