package com.fuzevpn.android

import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.async
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.launch
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.currentTime
import kotlinx.coroutines.test.runCurrent
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class SystemVpnNetworkWaitTest {
    @Test fun initialNetworkReturnsWithoutDelay() = runTest {
        var probes = 0
        awaitSystemVpnNetwork(isCurrent = { true }, hasNetwork = { ++probes; true })
        assertEquals(1, probes)
        assertEquals(0L, currentTime)
    }

    @Test fun networkReturningOnPollThresholdStartsAtThatThreshold() = runTest {
        val result = async {
            awaitSystemVpnNetwork(
                isCurrent = { true },
                hasNetwork = { currentTime >= 29_750L },
            )
        }
        advanceUntilIdle()
        result.await()
        assertEquals(29_750L, currentTime)
    }

    @Test fun absentNetworkTimesOutAfterThirtySeconds() = runTest {
        val result = async {
            runCatching { awaitSystemVpnNetwork(isCurrent = { true }, hasNetwork = { false }) }
                .exceptionOrNull()
        }
        advanceUntilIdle()
        val failure = result.await() as VpnNativeException
        assertEquals("system_vpn_resume_network_timeout", failure.code)
        assertEquals(SYSTEM_VPN_NETWORK_WAIT_TIMEOUT_MS, currentTime)
    }

    @Test fun cancellingWaitingJobDoesNotContinuePolling() = runTest {
        var probes = 0
        val job = launch {
            awaitSystemVpnNetwork(isCurrent = { true }, hasNetwork = { ++probes; false })
        }
        runCurrent()
        assertEquals(1, probes)
        job.cancelAndJoin()
        advanceUntilIdle()
        assertTrue(job.isCancelled)
        assertEquals(1, probes)
    }

    @Test fun staleRequestBeforeStartDoesNotProbeNetwork() = runTest {
        var probes = 0
        val failure = runCatching {
            awaitSystemVpnNetwork(isCurrent = { false }, hasNetwork = { ++probes; true })
        }.exceptionOrNull()
        assertTrue(failure is CancellationException)
        assertEquals(0, probes)
    }

    @Test fun replacedContextDuringWaitDoesNotProbeOrStartAgain() = runTest {
        var current = true
        var probes = 0
        val result = async {
            runCatching {
                awaitSystemVpnNetwork(isCurrent = { current }, hasNetwork = { ++probes; false })
            }.exceptionOrNull()
        }
        runCurrent()
        current = false
        advanceUntilIdle()
        assertTrue(result.await() is CancellationException)
        assertEquals(1, probes)
        assertEquals(SYSTEM_VPN_NETWORK_WAIT_POLL_MS, currentTime)
    }

    @Test fun replacementDuringNetworkProbeCannotStart() = runTest {
        var current = true
        var probes = 0
        val failure = runCatching {
            awaitSystemVpnNetwork(
                isCurrent = { current },
                hasNetwork = { ++probes; current = false; true },
            )
        }.exceptionOrNull()
        assertTrue(failure is CancellationException)
        assertEquals(1, probes)
    }

    @Test fun userStopRequiresSettingsForAlwaysOnAndUnknownOnly() {
        assertTrue(userStopRequiresSettings(true))
        assertTrue(userStopRequiresSettings(null))
        assertFalse(userStopRequiresSettings(false))
    }
}
