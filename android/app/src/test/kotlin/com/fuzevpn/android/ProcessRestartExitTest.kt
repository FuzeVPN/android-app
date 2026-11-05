package com.fuzevpn.android

import android.app.ApplicationExitInfo
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Which past exit lets a process start restore the permanent VPN (defect 9). Only deaths that
 * ActivityManager follows with a sticky restart do, a moment ago, of the main process
 * (reviews vm31p and vm31r).
 */
class ProcessRestartExitTest {
    private val main = "com.fuzevpn"
    private val renderer = "com.google.android.webview:sandboxed_process0:org.chromium.content.app.SandboxedProcessService0:0"
    private val now = 1_800_000_000_000L

    private fun restores(vararg exits: PastExit) = mainProcessDiedUnintendedly(exits.toList(), main, now)

    // Every reason Android defines, by name, with whether a restart follows it.
    private val reasons = mapOf(
        "REASON_UNKNOWN" to (ApplicationExitInfo.REASON_UNKNOWN to false),
        "REASON_EXIT_SELF" to (ApplicationExitInfo.REASON_EXIT_SELF to false),
        "REASON_SIGNALED" to (ApplicationExitInfo.REASON_SIGNALED to true),
        "REASON_LOW_MEMORY" to (ApplicationExitInfo.REASON_LOW_MEMORY to true),
        "REASON_CRASH" to (ApplicationExitInfo.REASON_CRASH to true),
        "REASON_CRASH_NATIVE" to (ApplicationExitInfo.REASON_CRASH_NATIVE to true),
        "REASON_ANR" to (ApplicationExitInfo.REASON_ANR to true),
        "REASON_INITIALIZATION_FAILURE" to (ApplicationExitInfo.REASON_INITIALIZATION_FAILURE to false),
        "REASON_PERMISSION_CHANGE" to (ApplicationExitInfo.REASON_PERMISSION_CHANGE to true),
        "REASON_EXCESSIVE_RESOURCE_USAGE" to (ApplicationExitInfo.REASON_EXCESSIVE_RESOURCE_USAGE to true),
        "REASON_USER_REQUESTED" to (ApplicationExitInfo.REASON_USER_REQUESTED to false),
        "REASON_USER_STOPPED" to (ApplicationExitInfo.REASON_USER_STOPPED to false),
        "REASON_DEPENDENCY_DIED" to (ApplicationExitInfo.REASON_DEPENDENCY_DIED to true),
        "REASON_OTHER" to (ApplicationExitInfo.REASON_OTHER to false),
        "REASON_FREEZER" to (ApplicationExitInfo.REASON_FREEZER to false),
        "REASON_PACKAGE_STATE_CHANGE" to (ApplicationExitInfo.REASON_PACKAGE_STATE_CHANGE to false),
        "REASON_PACKAGE_UPDATED" to (ApplicationExitInfo.REASON_PACKAGE_UPDATED to false),
    )

    @Test fun eachExitReasonIsDecided() {
        // A reason added by a later SDK must be decided here before it can be compiled against.
        val defined = ApplicationExitInfo::class.java.fields.map { it.name }.filter { it.startsWith("REASON_") }.toSet()
        assertEquals(defined, reasons.keys)
        for ((name, reason) in reasons) {
            assertEquals(name, reason.second, restores(PastExit(main, reason.first, now - 1_000)))
        }
    }

    @Test fun aRendererThatDiesAfterTheMainProcessIsSkipped() {
        val crash = PastExit(main, ApplicationExitInfo.REASON_CRASH_NATIVE, now - 5_000)
        assertTrue(restores(PastExit(renderer, ApplicationExitInfo.REASON_OTHER, now - 4_990), crash))
        assertTrue(restores(PastExit(renderer, ApplicationExitInfo.REASON_EXIT_SELF, now - 4_990), crash))
        val stopped = PastExit(main, ApplicationExitInfo.REASON_USER_REQUESTED, now - 5_000)
        assertFalse(restores(PastExit(renderer, ApplicationExitInfo.REASON_CRASH, now - 4_990), stopped))
        assertFalse(restores(PastExit(renderer, ApplicationExitInfo.REASON_SIGNALED, now - 4_990)))
        assertFalse(restores())
    }

    @Test fun onlyTheNewestExitOfTheMainProcessCounts() {
        assertFalse(restores(
            PastExit(main, ApplicationExitInfo.REASON_USER_REQUESTED, now - 2_000),
            PastExit(main, ApplicationExitInfo.REASON_CRASH, now - 60_000),
        ))
        assertFalse(restores(
            PastExit(main, ApplicationExitInfo.REASON_CRASH, now - 60_000),
            PastExit(main, ApplicationExitInfo.REASON_USER_REQUESTED, now - 2_000),
        ))
    }

    // Review vm31r: Android 11 sorts with (int) (b.timestamp - a.timestamp), so a gap of 2^31 to
    // 2^32 ms (25 to 50 days) puts the older record first. The newest is chosen by time.
    @Test fun theNewestIsChosenByTimeWhateverTheListOrder() {
        val crash = PastExit(main, ApplicationExitInfo.REASON_LOW_MEMORY, now - 3_000)
        val update = PastExit(main, ApplicationExitInfo.REASON_USER_REQUESTED, now - 3_000 - 30L * 86_400_000)
        val renderer = PastExit(renderer, ApplicationExitInfo.REASON_OTHER, now - 2_990)
        assertTrue(restores(update, crash))
        assertTrue(restores(update, renderer, crash))
        assertTrue(restores(renderer, crash, update))
    }

    @Test fun onlyADeathAMomentAgoRestores() {
        val crash = ApplicationExitInfo.REASON_CRASH
        assertTrue(restores(PastExit(main, crash, now)))
        assertTrue(restores(PastExit(main, crash, now - 120_000)))
        assertFalse(restores(PastExit(main, crash, now - 120_001)))
        // A record from the future (the clock was set back) is no proof of a recent death.
        assertFalse(restores(PastExit(main, crash, now + 1)))
    }
}
