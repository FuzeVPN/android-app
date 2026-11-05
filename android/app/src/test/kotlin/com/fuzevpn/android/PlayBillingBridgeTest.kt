package com.fuzevpn.android

import com.android.billingclient.api.BillingClient.BillingResponseCode
import com.android.billingclient.api.BillingClientStateListener
import com.android.billingclient.api.BillingResult
import com.android.billingclient.api.Purchase
import com.android.billingclient.api.PurchasesResponseListener
import com.android.billingclient.api.PurchasesUpdatedListener
import com.android.billingclient.api.QueryProductDetailsParams
import com.android.billingclient.api.QueryPurchasesParams
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.reflect.Proxy
import org.json.JSONObject
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Decisions of the real [PlayBillingBridge]: A05-01 recovery, pre-payment check, listener
 * attribution, account invalidation and client replacement. Play answers, the host clock and
 * the Flutter messenger are deterministic doubles; no Activity, Play service or account is used.
 */
class PlayBillingBridgeTest {
    private val gate = PlayBillingFlowGate()
    private val host = FakeHost()
    private val events = RecordingSink()
    private val messengers = linkedMapOf<PlayBillingBridge, FakeMessenger>()
    private val bridge = attach()

    @After
    fun closeBridges() = messengers.keys.forEach { it.close() }

    @Test
    fun aReturnFromPlayIsRecoveredWithTheLaunchOwnerEvenWithOnlyAForeignReceipt() {
        val client = openSheet("owner-a")
        val flow = gate.currentFlowId()!!
        bridge.onActivityPaused()
        bridge.onActivityResumed()
        host.advance(RECOVERY_DELAY - 1)
        assertEquals(0, client.pendingPurchaseQueries)
        host.advance(1)
        assertEquals(1, client.pendingPurchaseQueries)
        assertTrue(gate.isLaunched(flow))

        client.answerPurchases(receipt("token-b", "owner-b", suspended = true))

        // Dart releases its wait on this top-level owner (A05-01); the foreign receipt stays
        // evidence for its own owner only.
        assertEquals(listOf(mapOf(
            "type" to "purchases",
            "purchases" to listOf(evidence("token-b", "owner-b", suspended = true)),
            "obfuscatedAccountId" to "owner-a",
        )), events.received)
        assertNull(gate.currentFlowId())
        assertEquals(1, host.clients.size)
        host.advance(OPERATION_TIMEOUT)
        assertEquals(1, events.received.size)
    }

    @Test
    fun aFailedRecoveryStillReportsTheLaunchOwnerAndReleasesThePayment() {
        val client = openSheet("owner-a")
        bridge.onActivityPaused()
        bridge.onActivityResumed()
        host.advance(RECOVERY_DELAY)
        client.answerPurchases(code = BillingResponseCode.SERVICE_UNAVAILABLE)
        assertEquals(listOf(mapOf(
            "type" to "error", "code" to "network", "obfuscatedAccountId" to "owner-a",
        )), events.received)
        assertNull(gate.currentFlowId())
    }

    @Test
    fun recoveryNeedsALeftHostAndRunsOncePerFlow() {
        val client = openSheet("owner-a")
        // Resuming without having left the host is not a return from Play.
        bridge.onActivityResumed()
        host.advance(10_000)
        assertEquals(0, client.pendingPurchaseQueries)
        // Two quick returns schedule two checks; the second sees the first one running.
        bridge.onActivityPaused()
        bridge.onActivityResumed()
        bridge.onActivityPaused()
        bridge.onActivityResumed()
        host.advance(RECOVERY_DELAY)
        assertEquals(1, client.pendingPurchaseQueries)
        client.answerPurchases(receipt("token-a", "owner-a"))
        host.advance(OPERATION_TIMEOUT)
        assertEquals(0, client.pendingPurchaseQueries)
        assertEquals(1, events.received.size)
        assertNull(gate.currentFlowId())
    }

    @Test
    fun aListenerAnswerMakesTheReturnCheckUnnecessary() {
        val first = openSheet("owner-a")
        bridge.onActivityPaused()
        first.update(BillingResponseCode.OK, receipt("token-a", "owner-a"))
        bridge.onActivityResumed()
        host.advance(10_000)
        assertEquals(0, first.pendingPurchaseQueries)

        // Also when the listener arrives between the return and the delayed check.
        val second = openSheet("owner-a")
        bridge.onActivityPaused()
        bridge.onActivityResumed()
        second.update(BillingResponseCode.OK, receipt("token-c", "owner-a"))
        host.advance(10_000)
        assertEquals(0, second.pendingPurchaseQueries)

        assertEquals(listOf(
            mapOf("type" to "purchases", "purchases" to listOf(evidence("token-a", "owner-a"))),
            mapOf("type" to "purchases", "purchases" to listOf(evidence("token-c", "owner-a"))),
        ), events.received)
        assertNull(gate.currentFlowId())
    }

    @Test
    fun aDestroyedActivityTransfersAnInFlightRecoveryToItsReplacement() {
        val first = openSheet("owner-a")
        val flow = gate.currentFlowId()!!
        bridge.onActivityPaused()
        bridge.onActivityResumed()
        host.advance(RECOVERY_DELAY)
        assertEquals(1, first.pendingPurchaseQueries)

        // Android recreates the Activity while Play's answer is still pending.
        val replacementHost = FakeHost()
        val replacementEvents = RecordingSink()
        val replacement = attach(replacementHost, replacementEvents)
        assertTrue(first.ended)
        // Late answer and late listener of the detached bridge.
        first.answerPurchases(receipt("token-a", "owner-a"))
        first.update(BillingResponseCode.OK, receipt("token-a", "owner-a"))
        assertTrue(events.received.isEmpty())
        assertTrue(replacementEvents.received.isEmpty())
        assertTrue(gate.isLaunched(flow))
        assertEquals("owner-a", gate.ownerFor(flow))

        replacement.onActivityResumed()
        replacementHost.advance(RECOVERY_DELAY)
        val client = replacementHost.clients.single()
        client.finishSetup()
        client.answerPurchases(receipt("token-a", "owner-a"))
        assertEquals(listOf(mapOf(
            "type" to "purchases",
            "purchases" to listOf(evidence("token-a", "owner-a")),
            "obfuscatedAccountId" to "owner-a",
        )), replacementEvents.received)
        assertTrue(events.received.isEmpty())
        assertNull(gate.currentFlowId())
    }

    @Test
    fun existingPremiumEvidenceBlocksCheckoutBeforeAnyOfferIsQueried() {
        bridge.onActivityResumed()
        for (existing in listOf(
            receipt("own", "owner-a"),
            receipt("pending", "owner-a", pending = true),
            receipt("suspended", "owner-a", suspended = true),
            receipt("foreign", "owner-b"),
            receipt("unbound", null),
        )) {
            val launch = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
            val client = host.clients.last()
            client.finishSetup()
            client.answerPurchases(existing)
            assertEquals(existing.purchaseToken, listOf("error" to "already_owned"), launch.outcomes)
            assertEquals(existing.purchaseToken, 0, client.pendingProductQueries)
            assertTrue(existing.purchaseToken, client.prepared.isEmpty())
            assertNull(existing.purchaseToken, gate.currentFlowId())
        }
        assertEquals(5, host.clients.size)
        assertTrue(host.clients.dropLast(1).all { it.ended })
        assertTrue(events.received.isEmpty())
    }

    @Test
    fun anEmptyPreCheckOpensOnlyTheFreshSelectedOfferForTheSelectedOwner() {
        val client = openSheet("owner-a")
        val flow = gate.currentFlowId()!!
        assertTrue(gate.isLaunched(flow))
        assertEquals("owner-a", gate.ownerFor(flow))
        // The open payment sheet holds the only payment slot, for any account.
        val second = call(bridge, "launchSubscription", selection(YEARLY, "owner-b"))
        assertEquals(listOf("error" to "busy"), second.outcomes)
        assertEquals(1, host.clients.size)
        assertFalse(client.ended)
        assertEquals(1, client.launches)
        assertTrue(events.received.isEmpty())
    }

    @Test
    fun aChangedOfferIsNeverSubstituted() {
        bridge.onActivityResumed()
        val launch = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        val client = host.clients.single()
        client.finishSetup()
        client.answerPurchases()
        client.answerPlans(MONTHLY.copy(offerToken = "replacement-offer"), YEARLY)
        assertEquals(listOf("error" to "price_changed"), launch.outcomes)
        assertTrue(client.prepared.isEmpty())
        assertNull(gate.currentFlowId())
    }

    @Test
    fun failedPreChecksAndRefusedSheetsReleaseTheReservation() {
        bridge.onActivityResumed()
        val unreadable = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        host.clients.last().apply {
            finishSetup()
            answerPurchases(code = BillingResponseCode.NETWORK_ERROR)
        }
        assertEquals(listOf("error" to "network"), unreadable.outcomes)
        assertNull(gate.currentFlowId())

        val refused = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        val refusing = host.clients.last().apply {
            launchCode = BillingResponseCode.ITEM_ALREADY_OWNED
            finishSetup()
            answerPurchases()
            answerPlans(MONTHLY)
        }
        assertEquals(1, refusing.launches)
        assertEquals(listOf("error" to "already_owned"), refused.outcomes)
        assertNull(gate.currentFlowId())

        val crashed = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        host.clients.last().apply {
            launchFailure = IllegalStateException("sheet")
            finishSetup()
            answerPurchases()
            answerPlans(MONTHLY)
        }
        assertEquals(listOf("error" to "unavailable"), crashed.outcomes)
        assertNull(gate.currentFlowId())

        // Play never answers the pre-check: the call times out and frees the slot.
        val silent = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        val mute = host.clients.last().apply { finishSetup() }
        host.advance(OPERATION_TIMEOUT - 1)
        assertTrue(silent.outcomes.isEmpty())
        host.advance(1)
        assertEquals(listOf("error" to "network"), silent.outcomes)
        assertNull(gate.currentFlowId())
        mute.answerPurchases()
        assertEquals(0, mute.pendingProductQueries)
        assertTrue(events.received.isEmpty())
    }

    @Test
    fun checkoutRequiresAResumedUsableHostAndAValidSelection() {
        val paused = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        assertEquals(listOf("error" to "unavailable"), paused.outcomes)
        bridge.onActivityResumed()
        host.usable = false
        val finishing = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        assertEquals(listOf("error" to "unavailable"), finishing.outcomes)
        assertEquals(listOf("error" to "invalid_request"),
            call(bridge, "launchSubscription", selection(MONTHLY, "person@example.com")).outcomes)
        assertEquals(listOf("error" to "invalid_request"),
            call(bridge, "openSubscriptionManagement").outcomes)
        assertTrue(host.clients.isEmpty())
        assertTrue(host.managementUrls.isEmpty())
        assertNull(gate.currentFlowId())
    }

    @Test
    fun theLaunchListenerReleasesOnlyOnAReceiptOfTheLaunchOwner() {
        val client = openSheet("owner-a")
        val flow = gate.currentFlowId()!!
        client.update(BillingResponseCode.OK, receipt("token-b", "owner-b"))
        assertTrue(gate.isLaunched(flow))
        client.update(BillingResponseCode.OK, receipt("token-a", "owner-a"), receipt("token-b", "owner-b"))
        assertNull(gate.currentFlowId())
        assertEquals(listOf(
            mapOf("type" to "purchases", "purchases" to listOf(evidence("token-b", "owner-b"))),
            mapOf("type" to "purchases", "purchases" to listOf(
                evidence("token-a", "owner-a"), evidence("token-b", "owner-b"),
            )),
        ), events.received)
    }

    @Test
    fun cancellationAndErrorsReachDartOnceWithTheirLaunchOwner() {
        val first = openSheet("owner-a")
        first.update(BillingResponseCode.USER_CANCELED)
        assertNull(gate.currentFlowId())
        // A duplicate completion of the finished flow is ignored.
        first.update(BillingResponseCode.ERROR)
        assertEquals(listOf(mapOf(
            "type" to "cancelled", "code" to "cancelled", "obfuscatedAccountId" to "owner-a",
        )), events.received)

        val second = openSheet("owner-b")
        assertTrue(first.ended)
        val flow = gate.currentFlowId()!!
        // Late callbacks of the previous client generation are not attributed to this launch.
        first.update(BillingResponseCode.USER_CANCELED)
        first.update(BillingResponseCode.OK, receipt("token-a", "owner-a"))
        assertTrue(gate.isLaunched(flow))
        assertEquals(1, events.received.size)

        second.update(BillingResponseCode.NETWORK_ERROR)
        assertEquals(mapOf(
            "type" to "error", "code" to "network", "obfuscatedAccountId" to "owner-b",
        ), events.received.last())
        assertEquals(2, events.received.size)
        assertNull(gate.currentFlowId())
    }

    @Test
    fun aDetachedBridgeNeitherReleasesNorReportsAnything() {
        val client = openSheet("owner-a")
        val flow = gate.currentFlowId()!!
        val first = messengers.getValue(bridge)
        assertTrue(first.handlers[METHODS] != null && first.handlers[EVENTS] != null)
        val replacementEvents = RecordingSink()
        attach(FakeHost(), replacementEvents)
        assertTrue(client.ended)
        assertNull(first.handlers[METHODS])
        assertNull(first.handlers[EVENTS])

        client.update(BillingResponseCode.OK, receipt("token-a", "owner-a"))
        client.update(BillingResponseCode.USER_CANCELED)
        assertTrue(gate.isLaunched(flow))
        assertTrue(events.received.isEmpty())
        assertTrue(replacementEvents.received.isEmpty())
        assertEquals(listOf("error" to "unavailable"), call(bridge, "queryOwnedPurchases").outcomes)
    }

    @Test
    fun invalidationDuringThePreCheckCancelsAtOnceAndIgnoresLateAnswers() {
        bridge.onActivityResumed()
        val launch = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        val client = host.clients.single()
        client.finishSetup()
        assertEquals(1, client.pendingPurchaseQueries)

        assertEquals(listOf("success" to null), call(bridge, "invalidateAccount").outcomes)
        assertEquals(listOf("error" to "cancelled"), launch.outcomes)
        assertNull(gate.currentFlowId())

        client.answerPurchases()
        assertEquals(0, client.pendingProductQueries)
        assertTrue(client.prepared.isEmpty())
        host.advance(OPERATION_TIMEOUT)
        assertEquals(1, launch.outcomes.size)
        assertTrue(events.received.isEmpty())
    }

    @Test
    fun invalidationWhileOffersAreFetchedNeverOpensTheSheet() {
        bridge.onActivityResumed()
        val launch = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        val client = host.clients.single()
        client.finishSetup()
        client.answerPurchases()
        assertEquals(1, client.pendingProductQueries)

        call(bridge, "invalidateAccount")
        assertEquals(listOf("error" to "cancelled"), launch.outcomes)
        client.answerPlans(MONTHLY)
        assertTrue(client.prepared.isEmpty())
        assertEquals(0, client.launches)
        assertEquals(1, launch.outcomes.size)
        // The released slot is immediately available to the next account.
        openSheet("owner-b")
    }

    @Test
    fun invalidationAfterTheSheetOpenedKeepsThePaymentAndItsOwner() {
        val client = openSheet("owner-a")
        val flow = gate.currentFlowId()!!
        assertEquals(listOf("success" to null), call(bridge, "invalidateAccount").outcomes)
        assertTrue(gate.isLaunched(flow))
        assertEquals("owner-a", gate.ownerFor(flow))
        assertEquals(listOf("error" to "invalid_request"),
            call(bridge, "invalidateAccount", mapOf("unexpected" to true)).outcomes)
        assertTrue(gate.isLaunched(flow))

        client.update(BillingResponseCode.USER_CANCELED)
        assertEquals(listOf(mapOf(
            "type" to "cancelled", "code" to "cancelled", "obfuscatedAccountId" to "owner-a",
        )), events.received)
        assertNull(gate.currentFlowId())
    }

    @Test
    fun aLaunchReplacesTheClientAndFailsItsPendingWorkOnce() {
        val restore = call(bridge, "queryOwnedPurchases")
        val old = host.clients.single()
        old.finishSetup()
        assertEquals(1, old.pendingPurchaseQueries)

        val client = openSheet("owner-a")
        assertTrue(old.ended)
        assertEquals(listOf("error" to "unavailable"), restore.outcomes)
        old.answerPurchases(receipt("token-a", "owner-a"))
        old.update(BillingResponseCode.OK, receipt("token-a", "owner-a"))
        assertEquals(1, restore.outcomes.size)
        assertTrue(events.received.isEmpty())
        assertFalse(client.ended)
        assertTrue(gate.isLaunched(gate.currentFlowId()!!))
    }

    @Test
    fun closingFailsPendingCallsAndIgnoresEveryLateAnswer() {
        bridge.onActivityResumed()
        val launch = call(bridge, "launchSubscription", selection(MONTHLY, "owner-a"))
        val client = host.clients.single()
        client.finishSetup()

        bridge.close()
        assertEquals(listOf("error" to "unavailable"), launch.outcomes)
        assertTrue(client.ended)
        assertNull(messengers.getValue(bridge).handlers[METHODS])
        assertNull(gate.currentFlowId())

        client.answerPurchases()
        client.update(BillingResponseCode.OK, receipt("token-a", "owner-a"))
        assertEquals(1, launch.outcomes.size)
        assertEquals(0, client.pendingProductQueries)
        assertTrue(events.received.isEmpty())
        assertEquals(listOf("error" to "unavailable"), call(bridge, "queryPremiumPlans").outcomes)
        assertEquals(1, host.clients.size)
    }

    @Test
    fun aRefusedOrSilentSetupFailsWaitingCallsAndTheNextCallStartsAFreshClient() {
        val plans = call(bridge, "queryPremiumPlans")
        val refused = host.clients.single()
        refused.finishSetup(BillingResponseCode.BILLING_UNAVAILABLE)
        assertEquals(listOf("error" to "unavailable"), plans.outcomes)
        assertTrue(refused.ended)

        val owned = call(bridge, "queryOwnedPurchases")
        assertEquals(2, host.clients.size)
        host.advance(SETUP_TIMEOUT - 1)
        assertTrue(owned.outcomes.isEmpty())
        host.advance(1)
        assertEquals(listOf("error" to "network"), owned.outcomes)
        assertTrue(host.clients[1].ended)
    }

    @Test
    fun catalogueRestorationAndManagementKeepTheirNominalResults() {
        val plans = call(bridge, "queryPremiumPlans")
        val client = host.clients.single()
        client.finishSetup()
        client.answerPlans(MONTHLY, YEARLY)
        assertEquals(listOf("success" to listOf(MONTHLY.channelValue(), YEARLY.channelValue())), plans.outcomes)

        val owned = call(bridge, "queryOwnedPurchases")
        client.answerPurchases(receipt("token-a", "owner-a"), receipt("token-p", "owner-a", pending = true))
        assertEquals(listOf("success" to listOf(
            evidence("token-a", "owner-a"), evidence("token-p", "owner-a", state = "pending"),
        )), owned.outcomes)

        bridge.onActivityResumed()
        assertEquals(listOf("success" to null), call(bridge, "openSubscriptionManagement").outcomes)
        assertEquals(listOf(MANAGEMENT_URL), host.managementUrls)

        client.featureCode = BillingResponseCode.FEATURE_NOT_SUPPORTED
        assertEquals(listOf("error" to "unavailable"), call(bridge, "queryPremiumPlans").outcomes)
        assertEquals(listOf("notImplemented" to null), call(bridge, "acknowledgePurchase").outcomes)
        assertEquals(1, host.clients.size)
        assertTrue(events.received.isEmpty())
        assertNull(gate.currentFlowId())
    }

    /** Opens Play's sheet through the real pre-payment sequence and returns its client. */
    private fun openSheet(
        owner: String,
        target: PlayBillingBridge = bridge,
        targetHost: FakeHost = host,
    ): FakeClient {
        target.onActivityResumed()
        val launch = call(target, "launchSubscription", selection(MONTHLY, owner))
        val client = targetHost.clients.last()
        client.finishSetup()
        assertEquals(1, client.pendingPurchaseQueries)
        client.answerPurchases()
        assertEquals(1, client.pendingProductQueries)
        client.answerPlans(MONTHLY, YEARLY)
        assertEquals(listOf("success" to null), launch.outcomes)
        assertEquals(listOf(MONTHLY to owner), client.prepared)
        assertEquals(1, client.launches)
        assertTrue(gate.isLaunched(gate.currentFlowId()!!))
        return client
    }

    private fun attach(target: FakeHost = host, sink: RecordingSink = events): PlayBillingBridge {
        val messenger = FakeMessenger()
        return PlayBillingBridge.attach(target, messenger.proxy, gate).also {
            messengers[it] = messenger
            it.onListen(null, sink)
        }
    }

    private fun call(target: PlayBillingBridge, method: String, arguments: Any? = null) =
        RecordingResult().also { target.onMethodCall(MethodCall(method, arguments), it) }

    /** Main-thread host with a manual clock: delayed work runs only when a test advances it. */
    private class FakeHost : PlayBillingHost {
        var usable = true
        val clients = mutableListOf<FakeClient>()
        val managementUrls = mutableListOf<String>()
        private var now = 0L
        private val scheduled = mutableListOf<Pair<Long, Runnable>>()

        override val isMainThread: Boolean get() = true
        override val isUsable: Boolean get() = usable
        override fun post(action: Runnable) = postDelayed(action, 0)
        override fun postDelayed(action: Runnable, delayMillis: Long) {
            scheduled += now + delayMillis to action
        }
        override fun removeCallbacks(action: Runnable) {
            scheduled.removeAll { it.second === action }
        }
        override fun openSubscriptionManagement(url: String) {
            managementUrls += url
        }
        override fun newClient(updates: PurchasesUpdatedListener): PlayBillingClient =
            FakeClient(updates).also { clients += it }

        fun advance(millis: Long) {
            val until = now + millis
            while (true) {
                val next = scheduled.filter { it.first <= until }.minByOrNull { it.first } ?: break
                scheduled.remove(next)
                now = next.first
                next.second.run()
            }
            now = until
        }
    }

    /** One Play client generation; each SDK answer is delivered when the test decides. */
    private class FakeClient(private val updates: PurchasesUpdatedListener) : PlayBillingClient {
        var ended = false
        var featureCode = BillingResponseCode.OK
        var launchCode = BillingResponseCode.OK
        var launchFailure: Exception? = null
        var launches = 0
        val prepared = mutableListOf<Pair<PlayBillingPlan, String>>()
        private var setup: BillingClientStateListener? = null
        private val purchaseQueries = ArrayDeque<PurchasesResponseListener>()
        private val productQueries =
            ArrayDeque<(BillingResult, () -> List<PlayBillingBridge.NativePlan>) -> Unit>()
        val pendingPurchaseQueries: Int get() = purchaseQueries.size
        val pendingProductQueries: Int get() = productQueries.size

        override val isReady: Boolean get() = false
        override fun startConnection(listener: BillingClientStateListener) {
            setup = listener
        }
        override fun isFeatureSupported(feature: String): BillingResult = result(featureCode)
        override fun queryProductDetailsAsync(
            params: QueryProductDetailsParams,
            listener: (BillingResult, () -> List<PlayBillingBridge.NativePlan>) -> Unit,
        ) {
            productQueries += listener
        }
        override fun queryPurchasesAsync(params: QueryPurchasesParams, listener: PurchasesResponseListener) {
            purchaseQueries += listener
        }
        override fun billingFlow(plan: PlayBillingBridge.NativePlan, obfuscatedAccountId: String): () -> BillingResult {
            prepared += plan.plan to obfuscatedAccountId
            return {
                launches += 1
                launchFailure?.let { throw it }
                result(launchCode)
            }
        }
        override fun endConnection() {
            ended = true
        }

        fun finishSetup(code: Int = BillingResponseCode.OK) =
            checkNotNull(setup).onBillingSetupFinished(result(code))

        fun answerPurchases(vararg purchases: Purchase, code: Int = BillingResponseCode.OK) =
            purchaseQueries.removeFirst().onQueryPurchasesResponse(result(code), purchases.toList())

        fun answerPlans(vararg plans: PlayBillingPlan, code: Int = BillingResponseCode.OK) {
            val reply = productQueries.removeFirst()
            reply(result(code)) { plans.map { PlayBillingBridge.NativePlan("sdk:${it.offerToken}", it) } }
        }

        fun update(code: Int, vararg purchases: Purchase) =
            updates.onPurchasesUpdated(result(code), purchases.toList().ifEmpty { null })
    }

    private class RecordingResult : MethodChannel.Result {
        val outcomes = mutableListOf<Pair<String, Any?>>()
        override fun success(result: Any?) {
            outcomes += "success" to result
        }
        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
            outcomes += "error" to errorCode
        }
        override fun notImplemented() {
            outcomes += "notImplemented" to null
        }
    }

    private class RecordingSink : EventChannel.EventSink {
        val received = mutableListOf<Any?>()
        override fun success(event: Any?) {
            received += event
        }
        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
            received += "error:$errorCode"
        }
        override fun endOfStream() {
            received += "endOfStream"
        }
    }

    /** Records channel registration; the bridge never sends platform messages itself. */
    private class FakeMessenger {
        val handlers = mutableMapOf<String, Any?>()
        val proxy = Proxy.newProxyInstance(
            BinaryMessenger::class.java.classLoader,
            arrayOf(BinaryMessenger::class.java),
        ) { self, method, args ->
            when (method.name) {
                "setMessageHandler" -> {
                    handlers[args!![0] as String] = args[1]
                    null
                }
                "hashCode" -> System.identityHashCode(self)
                "equals" -> self === args!![0]
                "toString" -> "FakeMessenger"
                else -> null
            }
        } as BinaryMessenger
    }

    private companion object {
        const val RECOVERY_DELAY = 500L
        const val SETUP_TIMEOUT = 12_000L
        const val OPERATION_TIMEOUT = 20_000L
        const val METHODS = "com.fuzevpn/billing"
        const val EVENTS = "com.fuzevpn/billing/events"
        const val MANAGEMENT_URL =
            "https://play.google.com/store/account/subscriptions?sku=premium&package=com.fuzevpn"
        val MONTHLY = PlayBillingPlan("monthly", "offer-monthly", null,
            listOf(PlayBillingPhase("P1M", "€4.99", "EUR", 4_990_000, 0, 1)))
        val YEARLY = PlayBillingPlan("yearly", "offer-yearly", null,
            listOf(PlayBillingPhase("P1Y", "€39.99", "EUR", 39_990_000, 0, 1)))

        fun result(code: Int): BillingResult = BillingResult.newBuilder().setResponseCode(code).build()

        fun selection(plan: PlayBillingPlan, owner: String): Map<String, Any?> =
            plan.channelValue().filterKeys { it != "productId" } + ("obfuscatedAccountId" to owner)

        fun receipt(
            token: String,
            owner: String?,
            pending: Boolean = false,
            suspended: Boolean = false,
        ): Purchase = Purchase(JSONObject().apply {
            put("productId", "premium")
            put("purchaseToken", token)
            if (owner != null) put("obfuscatedAccountId", owner)
            put("purchaseState", if (pending) 4 else 0)
            put("suspended", suspended)
            put("acknowledged", false)
        }.toString(), "synthetic-signature")

        fun evidence(
            token: String,
            owner: String?,
            state: String = "purchased",
            suspended: Boolean = false,
        ): Map<String, Any?> = mapOf(
            "productId" to "premium", "purchaseToken" to token, "state" to state,
            "obfuscatedAccountId" to owner, "acknowledged" to false, "suspended" to suspended,
        )
    }
}
