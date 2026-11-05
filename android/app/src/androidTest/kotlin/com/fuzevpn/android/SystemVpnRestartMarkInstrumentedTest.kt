package com.fuzevpn.android

import android.app.job.JobScheduler
import android.content.Context
import android.os.SystemClock
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.After
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The restart mark is a real pending job (review vm31r): JobScheduler rejects a misdeclared job
 * service only at schedule time, and the bridge swallows that refusal. Never connects a VPN.
 */
@RunWith(AndroidJUnit4::class)
class SystemVpnRestartMarkInstrumentedTest {
    private val context = ApplicationProvider.getApplicationContext<Context>()
    private val jobs = context.getSystemService(JobScheduler::class.java)

    @After
    fun disarm() {
        SystemVpnResumeSentinel.sync(context, false)
        waitFor { jobs.getPendingJob(SystemVpnResumeSentinel.ARMED_JOB) == null }
    }

    @Test fun armingSchedulesTheMarkAndDisarmingCancelsIt() {
        SystemVpnResumeSentinel.sync(context, true)
        assertTrue("mark not scheduled", waitFor {
            jobs.getPendingJob(SystemVpnResumeSentinel.ARMED_JOB)?.service?.className == SystemVpnRestartMark::class.java.name
        })
        SystemVpnResumeSentinel.sync(context, false)
        assertTrue("mark not cancelled", waitFor { jobs.getPendingJob(SystemVpnResumeSentinel.ARMED_JOB) == null })
    }

    private fun waitFor(condition: () -> Boolean): Boolean {
        val deadline = SystemClock.elapsedRealtime() + 5_000
        while (SystemClock.elapsedRealtime() < deadline) {
            if (condition()) return true
            SystemClock.sleep(50)
        }
        return condition()
    }
}
