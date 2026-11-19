package com.fuzevpn.android

import android.app.Activity

/** Google Play's review flow double: records each launch; the answer comes from HarnessControl. */
internal object InAppReviewLauncher {
    fun launch(@Suppress("UNUSED_PARAMETER") activity: Activity, onDone: (launched: Boolean) -> Unit) {
        HarnessControl.reviewLaunches++
        onDone(HarnessControl.reviewLaunched)
    }
}
