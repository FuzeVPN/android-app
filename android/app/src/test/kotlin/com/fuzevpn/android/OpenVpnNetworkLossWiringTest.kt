package com.fuzevpn.android

import java.io.File
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * OpenVPN network loss (Android 16 VM). The bridge-host suite fakes
 * OpenVpnService and the callback's network query, so this wiring is pinned in
 * the source: onLost never asks getAllNetworks, the recovery stop keeps the
 * TUN interface, and the retained duplicate is released by OpenVpnService.stop
 * or by an engine stop that was not confirmed.
 */
class OpenVpnNetworkLossWiringTest {
    private fun source(name: String): String = listOf("src/main/kotlin", "android/app/src/main/kotlin")
        .map { File(it, "com/fuzevpn/android/$name") }
        .first { it.isFile }
        .readText()

    private val bridge = source("AndroidVpnBridge.kt")
    private val service = source("OpenVpnService.kt")
    private val controller = source("openvpn/OpenVpnController.kt")

    @Test fun onLostDecidesWithoutQueryingTheNetworkInventory() {
        val onLost = block(bridge, "override fun onLost(network: Network) {")
        assertFalse(onLost, onLost.contains("hasUsableNetwork"))
        assertTrue(onLost, onLost.contains("signalOpenVpnNetworkLoss()"))
        val signal = block(bridge, "private fun signalOpenVpnNetworkLoss()")
        assertFalse(signal, signal.contains("hasUsableNetwork"))
    }

    @Test fun theRecoveryStopKeepsTheTunInterface() {
        val stopOld = block(bridge, "stopOld = {")
        assertTrue(stopOld, stopOld.contains("openVpn.disconnect()"))
        assertFalse(stopOld, stopOld.contains("OpenVpnService.stop"))
    }

    @Test fun establishRetainsADuplicateBeforeDetachingCoresDescriptor() {
        val establish = block(service, "internal fun establishFromPlan(")
        val dup = establish.indexOf(".dup()")
        val replace = establish.indexOf("retainedTun.replace(")
        val detach = establish.indexOf(".detachFd()")
        assertTrue(establish, dup >= 0 && replace > dup && detach > replace)
    }

    @Test fun onlyStopReleasesTheRetainedTun() {
        assertTrue(block(service, "internal fun stop(context: Context) {").contains("retainedTun.release()"))
        assertFalse(block(service, "internal fun start(context: Context").contains("retainedTun"))
    }

    // After a stop timeout Core still holds its own fd (fail-closed); keeping the duplicate
    // too would leave a dead interface up once Core exits late.
    @Test fun anUnconfirmedEngineStopReleasesTheRetainedTun() {
        val stop = controller.substring(controller.indexOf("private fun stopCurrentLocked("),
            controller.indexOf("private fun stopNativeLocked("))
        assertTrue(stop, stop.contains("if (!stopped) OpenVpnService.releaseRetainedTun()"))
        assertTrue(service.contains("internal fun releaseRetainedTun() = retainedTun.release()"))
    }

    // Reusing the retained interface keeps TCP connections across a recovery (netd aborts them
    // when establish() puts the same address on a new tunN). Only the recovery restart may do it.
    @Test fun onlyARecoveryRestartMayReuseTheRetainedTun() {
        val establish = block(service, "internal fun establishFromPlan(")
        val reuse = establish.indexOf("if (recoveryMayReuse) reuseRetainedTun(validated, service)")
        assertTrue(establish, reuse >= 0 && reuse < establish.indexOf(".establish()"))
        assertTrue(block(service, "internal fun start(context: Context").contains("recoveryMayReuse = reconnecting"))
        assertTrue(block(service, "internal fun stop(context: Context) {").contains("recoveryMayReuse = false"))
        val recoveryStart = "OpenVpnService.start(appContext, reconnecting = true)"
        assertEquals(bridge, 1, bridge.split(recoveryStart).size - 1)
        assertTrue(block(bridge, "restartLocal = {").contains(recoveryStart))
        assertFalse(bridge.contains("OpenVpnService.start(appContext, true)"))
        val helper = block(service, "private fun reuseRetainedTun(")
        assertTrue(helper, helper.contains("val routed = routedVpnInterfaces(service)") &&
            helper.contains("retainedTun.reuse(plan, service)") &&
            helper.contains("if (name == null || name !in routed)") &&
            helper.contains("OpenVPN TUN not reused: "))
        // getOwnerUid() exists only from Android 11 (NoSuchMethodError on 10): the routed
        // interface name identifies the retained tun on every supported release.
        assertFalse(service, service.contains("ownerUid"))
        val routed = service.substring(service.indexOf("private fun routedVpnInterfaces("),
            service.indexOf("private fun tunInterfaceName("))
        assertTrue(routed, routed.contains("catch (_: Throwable)"))
    }

    // minSdk is 26: Os.fcntlInt and NetworkCapabilities.getOwnerUid exist only from API 30, and
    // the Error they throw below it escapes every catch on this path (tun_establish_failed).
    @Test fun reuseCallsNoApiAboveMinSdk() {
        assertFalse(service, service.contains("fcntl"))
        assertFalse(service, service.contains("android.system.Os"))
        val helper = block(service, "private fun reuseRetainedTun(")
        assertTrue(helper, helper.contains("held.dup().detachFd()"))
        assertFalse(helper, helper.contains("held.detachFd()"))
    }

    // Android resets the interface before it reports a revocation: the retained TUN is released
    // on that binder callback, before a recovery could reuse it.
    @Test fun aHostLossReleasesTheRetainedTunAtOnce() {
        val host = source("SharedVpnHost.kt")
        for (event in listOf("\"onHostRevoked\" -> {", "\"onHostDestroyed\" -> {")) {
            val body = block(host, event)
            val release = body.indexOf("OpenVpnService.releaseRetainedTun()")
            assertTrue(body, release >= 0 && release < body.indexOf("callbackHandler.post"))
        }
    }

    // A release build is not dumpable: on Android 11 its own /proc/self/fdinfo is unreadable
    // (vm31h: "interface unreadable"), so the interface is read by ioctl first, fdinfo after.
    @Test fun theInterfaceNameIsReadByIoctlBeforeFdinfo() {
        val lookup = service.substring(service.indexOf("private fun tunInterfaceName("),
            service.indexOf("internal fun establishForCore("))
        val native = lookup.indexOf("OpenVpnNative.tunInterfaceName(fd)")
        assertTrue(lookup, native >= 0 && native < lookup.indexOf("/proc/self/fdinfo/"))
    }

    /** The braces-balanced body that follows [start]; these bodies hold no brace in a string. */
    private fun block(source: String, start: String): String {
        val at = source.indexOf(start)
        assertTrue("missing: $start", at >= 0)
        val open = source.indexOf('{', at)
        var depth = 0
        for (index in open until source.length) {
            when (source[index]) {
                '{' -> depth += 1
                '}' -> if (--depth == 0) return source.substring(at, index + 1)
            }
        }
        throw AssertionError("unbalanced: $start")
    }
}
