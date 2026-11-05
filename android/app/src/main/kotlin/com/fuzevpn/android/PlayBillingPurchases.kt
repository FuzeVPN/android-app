package com.fuzevpn.android

import com.android.billingclient.api.BillingClient
import com.android.billingclient.api.Purchase
import com.android.billingclient.api.QueryPurchasesParams

/** Purchase evidence also recovers inactive owners; only the server grants access. */
internal object PlayBillingPurchases {
    fun query(): QueryPurchasesParams = QueryPurchasesParams.newBuilder()
        .setProductType(BillingClient.ProductType.SUBS)
        .includeSuspendedSubscriptions(true)
        .build()

    fun channelValues(purchases: List<Purchase>): List<Map<String, Any?>> =
        purchases.mapNotNull { purchase ->
            if (PlayBillingPolicy.PRODUCT_ID !in purchase.products ||
                purchase.purchaseToken.isBlank()
            ) return@mapNotNull null
            val state = when (purchase.purchaseState) {
                Purchase.PurchaseState.PURCHASED -> "purchased"
                Purchase.PurchaseState.PENDING -> "pending"
                else -> return@mapNotNull null
            }
            // The SDK returns "" when no account identifier was supplied.
            // Keep it unknown rather than inventing a current owner.
            val owner = purchase.accountIdentifiers?.obfuscatedAccountId?.takeUnless { it.isEmpty() }
            mapOf(
                "productId" to PlayBillingPolicy.PRODUCT_ID,
                "purchaseToken" to purchase.purchaseToken,
                "state" to state,
                "obfuscatedAccountId" to owner,
                "acknowledged" to purchase.isAcknowledged,
                "suspended" to purchase.isSuspended,
            )
        }
}
