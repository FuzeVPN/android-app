package com.fuzevpn.android

import android.app.Activity
import com.google.android.play.core.review.ReviewManagerFactory

/**
 * Google Play's own review card (In-App Review API). Play alone decides whether the card is
 * shown and never says what the user did: [onDone] only tells whether the flow was launched.
 * Called on the main thread, with an activity on screen.
 */
internal object InAppReviewLauncher {
    fun launch(activity: Activity, onDone: (launched: Boolean) -> Unit) {
        val manager = try {
            ReviewManagerFactory.create(activity)
        } catch (_: RuntimeException) {
            onDone(false)
            return
        }
        manager.requestReviewFlow().addOnCompleteListener { request ->
            if (!request.isSuccessful || activity.isFinishing || activity.isDestroyed) {
                onDone(false)
                return@addOnCompleteListener
            }
            manager.launchReviewFlow(activity, request.result).addOnCompleteListener { onDone(true) }
        }
    }
}
