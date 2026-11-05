package com.fuzevpn.android

import java.io.File
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Android 11 bind race (campaign vm31i: the release app crashed in 10 of 40 cold starts). On API
 * 30 the ConnectivityManager is one per process: a proxy update that ActivityManager pushes on
 * every VPN teardown and that reaches a new process before its Application is bound creates it
 * for package android. Every package-checked call (registerNetworkCallback, requestNetwork,
 * getNetworkCapabilities) then throws SecurityException until the process dies, while calls
 * without a package check (activeNetwork, allNetworks, getNetworkInfo, activeNetworkInfo,
 * getLinkProperties) keep answering. No JVM double can build that manager and the bridge-host
 * suite fakes the controller and the service, so each fallback is pinned in the source.
 */
class ConnectivityBindRaceWiringTest {
    private fun source(name: String): String = listOf("src/main/kotlin", "android/app/src/main/kotlin")
        .map { File(it, "com/fuzevpn/android/$name") }
        .first { it.isFile }
        .readText()

    private val bridge = source("AndroidVpnBridge.kt")
    private val service = source("OpenVpnService.kt")
    private val controller = source("openvpn/OpenVpnController.kt")

    // The registration runs in Application.onCreate, where the exception killed the start. No
    // public API rebuilds the manager: a refusal is final for the process, never retried.
    @Test fun aRefusedPhysicalCallbackIsRecordedInsteadOfThrown() {
        assertTrue(bridge.contains("private val physicalCallbackRegistered: Boolean"))
        assertEquals(bridge, 1, count(bridge, "physicalCallbackRegistered = "))
        assertEquals(bridge, 1, count(bridge, "registerNetworkCallback("))
        val init = block(bridge, "init {")
        val register = block(init, "physicalCallbackRegistered = try {")
        assertTrue(register, register.contains("connectivity.registerNetworkCallback("))
        assertTrue(register, register.removeSuffix("}").trimEnd().endsWith("true"))
        // Exactly SecurityException, and nothing broader after it: any other failure still surfaces.
        val rest = after(init, register)
        assertTrue(rest, rest.startsWith("catch (_: SecurityException) {"))
        val refused = block(rest, "catch (_: SecurityException) {")
        assertTrue(refused, refused.contains("Log.w(LOG_TAG, \"Physical network callback refused by Android: "))
        assertTrue(refused, refused.removeSuffix("}").trimEnd().endsWith("false"))
        assertFalse(refused, refused.contains("registerNetworkCallback"))
        // No other catch follows: the next statement launches the watcher of an affected process.
        assertTrue(rest, after(rest, refused).startsWith(
            "if (!physicalCallbackRegistered) watchPhysicalNetworksWithoutCallback()"))
    }

    // Without the callback the tracker never learns a network and its inventory read throws too:
    // the recovery would show a network wait for the whole session. CONNECTED is published anyway.
    @Test fun wireGuardRecoveryStartsOnlyWithThePhysicalCallback() {
        val postProof = block(bridge,
            "NativeConnectionTiming.span(timing, \"postproof_notification\") { sessionLifecycle.current(ticket) {")
        val guarded = block(postProof, "if (physicalCallbackRegistered) {")
        val outside = postProof.replace(guarded, "")
        for (line in listOf(
            "wireGuardRecoveryInstance = tunnelInstanceEpoch.get()",
            "wireGuardRecovery.start(wireGuardRecoveryInstance, reconcilePhysicalNetworksLocked(), wireGuard.recoveryBaseline())",
            "refreshWireGuardRecoveryLocked(sample = false)",
            "startWireGuardRecoveryObserverLocked()",
        )) {
            assertTrue(guarded, guarded.contains(line))
            assertFalse(outside, outside.contains(line))
        }
        assertEquals(bridge, 1, count(bridge, "wireGuardRecovery.start("))
        assertEquals(bridge, 1, count(bridge, "wireGuardRecoveryInstance = tunnelInstanceEpoch.get()"))
        val connected = postProof.indexOf("emitState(VpnStatus.CONNECTED, VpnProtocol.WIREGUARD, null)")
        assertTrue(postProof, connected >= 0 && connected < postProof.indexOf(guarded))
    }

    // No onLost ever arrives without the callback, and Core can report the interruption before
    // the watcher's next look: only a physical network that really vanished makes it the network
    // change onLost would have marked (admitNetworkRecovery, once per proof). The former blanket
    // substitute took every interruption for a network change and retried forever against a
    // server failing after the handshake; any other interruption keeps the single durable retry,
    // as in a healthy process.
    @Test fun anUnobservedLossIsMarkedBeforeTheNetworkClaim() {
        val failure = block(bridge, "private fun handleOpenVpnFailure(")
        assertFalse(failure, failure.contains(
            "if (reconnect && !physicalCallbackRegistered) recoveryPolicy.networkLost(generation)"))
        val reconnect = failure.indexOf("val reconnect = code == \"openvpn_reconnect_required\"")
        val guard = block(failure, "if (reconnect && !physicalCallbackRegistered && physicalNetworkVanished()) {")
        val guardAt = failure.indexOf(guard)
        val claim = failure.indexOf("recoveryPolicy.claimNetworkChange(generation)")
        assertTrue(failure, reconnect >= 0 && guardAt > reconnect && guardAt + guard.length < claim)
        assertTrue(guard, guard.contains("physicalLosses.incrementAndGet()"))
        assertTrue(guard, guard.contains("recoveryPolicy.networkLost(generation)"))
        assertEquals(failure, 1, count(failure, "recoveryPolicy.networkLost("))
        assertEquals(failure, 1, count(failure, "physicalLosses.incrementAndGet()"))
    }

    // Without the callback, Core alone noticed the lost Wi-Fi, at its keepalive: OpenVPN downloads
    // timed out on every loss and return (campaign vm31j). The watcher stands in for onLost in an
    // affected process only; a healthy process keeps the callback alone.
    @Test fun anAffectedProcessWatchesThePhysicalNetworksInstead() {
        val init = block(bridge, "init {")
        assertTrue(init, init.contains("if (!physicalCallbackRegistered) watchPhysicalNetworksWithoutCallback()"))
        assertFalse(init, block(init, "physicalCallbackRegistered = try {").contains("watchPhysicalNetworksWithoutCallback"))
        // The definition and that single call.
        assertEquals(bridge, 2, count(bridge, "watchPhysicalNetworksWithoutCallback()"))
    }

    // The watcher acts as onLost does, and only for OpenVPN (the WireGuard recovery is off without
    // the callback). The count comes before the signal: a signal refused during an engine start
    // is then acted on by the proof's read. Outside OpenVPN the tracker drops the default it
    // followed, or a network lost before a session would be reported at its first look. One look
    // a second.
    @Test fun theWatcherSignalsAVanishedNetworkOnlyDuringOpenVpn() {
        val watcher = block(bridge, "private fun watchPhysicalNetworksWithoutCallback() = observerScope.launch {")
        val tick = block(block(watcher, "while (true) {"), "synchronized(recoveryLock) {")
        val active = block(tick, "if (activeProtocol == VpnProtocol.OPENVPN) {")
        val vanished = block(active, "if (physicalNetworkVanished()) {")
        val counted = vanished.indexOf("physicalLosses.incrementAndGet()")
        assertTrue(vanished, counted >= 0 && counted < vanished.indexOf("signalOpenVpnNetworkLoss()"))
        val outside = watcher.replace(active, "")
        for (call in listOf("physicalNetworkVanished()", "physicalLosses", "signalOpenVpnNetworkLoss()", "networkLost(")) {
            assertFalse(outside, outside.contains(call))
        }
        val rest = after(tick, active)
        assertTrue(rest, rest.startsWith("else {"))
        val idle = block(rest, "else {")
        assertEquals(idle, "legacyDefaultNetwork.reset()", flat(idle.removePrefix("else {").removeSuffix("}")).trim())
    }

    // Race (review): the watcher's look and the handler's look consume the same previous default,
    // and the handler looks under recoveryLock. With the watcher's look alone serialized, it could
    // take a loss, then the handler (Core's own report of that loss) find none and spend the single
    // retry on an interruption, and the watcher's signal come once the session was no longer
    // CONNECTED: neither marked the network change. The whole tick, from the look to the signal,
    // and the reset outside OpenVPN now hold recoveryLock; the delay waits outside it.
    @Test fun theWatcherTickRunsUnderTheHandlersRecoveryLock() {
        assertTrue(bridge.contains(
            "private fun handleOpenVpnFailure(generation: Long, code: String) = synchronized(recoveryLock) {"))
        val loop = block(block(bridge, "private fun watchPhysicalNetworksWithoutCallback() = observerScope.launch {"),
            "while (true) {")
        val tick = block(loop, "synchronized(recoveryLock) {")
        // Nothing else in the loop: the tick, then the delay.
        assertEquals(loop, "while (true) { ${flat(tick)} delay(1_000L) }", flat(loop))
        assertFalse(tick, tick.contains("delay("))
        assertTrue(tick, after(tick, "synchronized(recoveryLock) {").startsWith("if (activeProtocol == VpnProtocol.OPENVPN) {"))
        for (part in listOf("physicalNetworkVanished()", "physicalLosses.incrementAndGet()", "signalOpenVpnNetworkLoss()",
            "legacyDefaultNetwork.reset()")) {
            assertTrue(tick, tick.contains(part))
        }
        // The definition, this tick and the handler: another look would consume the previous
        // default and hide a loss from both. The look holds no lock of its own; only the look and
        // this tick's reset use the tracker, a single one the bridge never replaces.
        assertEquals(bridge, 3, count(bridge, "physicalNetworkVanished()"))
        assertEquals(tick, 1, count(tick, "physicalNetworkVanished()"))
        assertEquals(1, count(block(bridge, "private fun handleOpenVpnFailure("), "physicalNetworkVanished()"))
        val look = block(bridge, "private fun physicalNetworkVanished(): Boolean {")
        assertFalse(look, look.contains("synchronized"))
        assertEquals(bridge, 1, count(bridge, "private val legacyDefaultNetwork = LegacyDefaultNetworkTracker<Network>()"))
        assertEquals(bridge, 1, count(bridge, "LegacyDefaultNetworkTracker<"))
        assertEquals(look, 1, count(look, "legacyDefaultNetwork.look("))
        assertEquals(tick, 1, count(tick, "legacyDefaultNetwork.reset()"))
        assertEquals(bridge, 2, count(bridge, "legacyDefaultNetwork."))
        // The earlier rounds' separate lock, their list of every physical network, the default
        // kept by its type alone, then by the bridge's own key and networks, are gone.
        for (name in listOf("legacyNetworksLock", "legacyPhysicalNetworks", "legacyDefaultType", "legacyDefaultKey",
            "legacyDefaultNetworks")) {
            assertFalse(name, bridge.contains(name))
        }
    }

    // Only calls without a package check: the capabilities throw in this very process. Every
    // listed network and the default go through the same reading, which drops the VPN's own
    // network (not physical, so its teardown is no loss); on Android 11 this app's active network
    // info describes the VPN's underlying, physical default. The default is read last, after the
    // list: a default that moved during the listing is already another default at this look.
    @Test fun theLegacyLookReadsTheDefaultPhysicalNetworkWithoutAPackageCheck() {
        val look = block(bridge, "private fun physicalNetworkVanished(): Boolean {")
        assertTrue(look, look.contains("val listed: Map<Network, LegacyDefaultNetworkTracker.Reading>"))
        assertTrue(look, look.contains("val default: LegacyDefaultNetworkTracker.Reading?"))
        assertTrue(look, flat(look).contains("listed = connectivity.allNetworks.mapNotNull { network -> " +
            "connectivity.getNetworkInfo(network)?.let(::legacyReading)?.let { network to it } }.toMap()"))
        val listing = look.indexOf("connectivity.allNetworks.mapNotNull { network ->")
        val infos = look.indexOf("connectivity.getNetworkInfo(network)?.let(::legacyReading)")
        val defaulted = look.indexOf("default = connectivity.activeNetworkInfo?.let(::legacyReading)")
        assertTrue(look, listing >= 0 && infos > listing && defaulted > infos)
        // Last: no read of the manager follows the default's.
        assertEquals(look, defaulted + "default = ".length, look.lastIndexOf("connectivity."))
        assertEquals(look, 3, count(look, "connectivity."))
        // The definition and these two readings.
        assertEquals(look, 2, count(look, "legacyReading"))
        assertEquals(bridge, 3, count(bridge, "legacyReading"))
        for (call in listOf("getNetworkCapabilities", "registerNetworkCallback", "requestNetwork")) {
            assertFalse(look, look.contains(call))
        }
        val refused = block(look, "catch (_: Exception) {")
        assertEquals(refused, "return false", refused.removePrefix("catch (_: Exception) {").removeSuffix("}").trim())
        // A look only answers: its callers count the loss and signal it.
        for (call in listOf("physicalLosses", "signalOpenVpnNetworkLoss", "networkLost")) {
            assertFalse(look, look.contains(call))
        }
    }

    // Which networks stand for the default, when it is lost and what a BLOCKED look may change
    // are LegacyDefaultNetworkTracker's to decide (LegacyDefaultNetworkTrackerTest): the look
    // hands both readings over as read, and a refused read answers false without touching the
    // tracker. The bridge's own rules it replaces (review) let another SIM's IMS network stand in
    // for a SUSPENDED default through a match by type alone, took the extra information a BLOCKED
    // report clears for another default, and hid a loss behind a new network of the same APN.
    @Test fun theLookLeavesTheDecisionToTheTracker() {
        val look = block(bridge, "private fun physicalNetworkVanished(): Boolean {")
        assertTrue(look, flat(look).endsWith(
            "} catch (_: Exception) { return false } return legacyDefaultNetwork.look(listed, default) }"))
        assertEquals(look, 1, count(look, "legacyDefaultNetwork."))
        // No rule of its own: no filter, no match by type, no fallback to the type alone.
        for (part in listOf(".type", "extraInfo", "detailedState", "isConnected", "filter", "ifEmpty", "State.")) {
            assertFalse(part, look.contains(part))
        }
        assertFalse(bridge, bridge.contains("sameType"))
    }

    // A reading is the legacy type, the extra information (a cellular network's APN) and the
    // state the tracker follows. CONNECTED and SUSPENDED (out of data service, a call without
    // concurrent voice and data) are followed: read as not connected, a suspended default let
    // another network of its type stand in for it (review). BLOCKED holds the network back for
    // this app alone and clears its extra information. Any other state (a network still without
    // an address, one disconnecting) is no default's. The bridge reads no state anywhere else.
    @Test fun eachNetworkInfoIsReadByItsTypeExtraInfoAndState() {
        val reading = block(bridge, "private fun legacyReading(info: NetworkInfo): LegacyDefaultNetworkTracker.Reading? =")
        assertEquals(reading, "private fun legacyReading(info: NetworkInfo): LegacyDefaultNetworkTracker.Reading? = " +
            "if (info.type == ConnectivityManager.TYPE_VPN) null else LegacyDefaultNetworkTracker.Reading( " +
            "info.type, info.extraInfo, when (info.detailedState) { " +
            "NetworkInfo.DetailedState.CONNECTED, NetworkInfo.DetailedState.SUSPENDED -> LegacyDefaultNetworkTracker.State.FOLLOWED " +
            "NetworkInfo.DetailedState.BLOCKED -> LegacyDefaultNetworkTracker.State.BLOCKED " +
            "else -> LegacyDefaultNetworkTracker.State.OTHER }", flat(reading))
        // The state is the reading's last argument.
        val rest = flat(after(bridge, reading))
        assertTrue(rest.take(80), rest.startsWith(", ) "))
        assertEquals(bridge, 3, count(bridge, "LegacyDefaultNetworkTracker.State."))
        assertEquals(bridge, 1, count(bridge, "info.detailedState"))
    }

    // Only the default network's info answers: a legacy info per network would also count a
    // restricted network (IMS) or one the system does not route, and validation is not visible.
    @Test fun theOpenVpnNetworkCheckFallsBackToTheDefaultNetworkInfo() {
        val check = block(controller, "fun hasUsableNetwork(): Boolean = try {")
        assertTrue(check, check.contains("connectivityManager.getNetworkCapabilities(network)"))
        val rest = after(controller, check)
        assertTrue(rest, rest.startsWith("catch (_: SecurityException) {"))
        val fallback = block(rest, "catch (_: SecurityException) {")
        assertTrue(fallback, fallback.contains("val info = connectivityManager.activeNetworkInfo"))
        assertTrue(fallback, fallback.contains("legacyDefaultNetworkUsable(present = info != null"))
        assertTrue(fallback, fallback.contains("vpn = info?.type == ConnectivityManager.TYPE_VPN"))
        assertTrue(fallback, fallback.contains("blocked = info?.detailedState == NetworkInfo.DetailedState.BLOCKED"))
        assertFalse(fallback, fallback.contains("getNetworkInfo("))
        assertFalse(fallback, fallback.contains("allNetworks"))
        assertTrue(controller.contains("import com.fuzevpn.android.legacyDefaultNetworkUsable"))
    }

    // The TUN reuse compares the retained interface with the routed VPN interfaces: an empty set
    // in an affected process would establish a new interface and abort open TCP connections.
    @Test fun theRoutedVpnInterfacesReadTheLegacyTypeWhenCapabilitiesAreRefused() {
        val start = service.indexOf("private fun routedVpnInterfaces(")
        val probeStart = service.indexOf("private fun isVpnNetwork(")
        assertTrue(service, start >= 0 && probeStart > start)
        val routed = service.substring(start, probeStart)
        assertTrue(routed, routed.contains(
            "if (isVpnNetwork(connectivity, network)) connectivity.getLinkProperties(network)?.interfaceName"))
        assertFalse(routed, routed.contains("getNetworkCapabilities"))
        val probe = block(service, "private fun isVpnNetwork(connectivity: ConnectivityManager, network: Network): Boolean = try {")
        assertTrue(probe, probe.contains(
            "connectivity.getNetworkCapabilities(network)?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true"))
        val rest = after(service, probe)
        assertTrue(rest, rest.startsWith("catch (_: SecurityException) {"))
        val legacy = block(rest, "catch (_: SecurityException) {")
        assertTrue(legacy, legacy.contains("connectivity.getNetworkInfo(network)?.type == ConnectivityManager.TYPE_VPN"))
        assertEquals(service, 1, count(service, "getNetworkCapabilities("))
    }

    // prepare() would revoke another app's VPN: only the refused capability read falls back to the
    // legacy type, any other failure still fails closed and skips the restart.
    @Test fun theForeignVpnCheckFallsBackAndStillFailsClosed() {
        val check = block(bridge, "private fun foreignVpnPresent(): Boolean = try {")
        assertTrue(check, check.contains("val active = connectivity.activeNetwork"))
        val legacy = block(check, "catch (_: SecurityException) {")
        assertTrue(legacy, legacy.contains("connectivity.getNetworkInfo(active)?.type == ConnectivityManager.TYPE_VPN"))
        val rest = after(bridge, check)
        assertTrue(rest, rest.startsWith("catch (_: Exception) {"))
        val closed = block(rest, "catch (_: Exception) {")
        assertEquals(closed, "true", closed.removePrefix("catch (_: Exception) {").removeSuffix("}").trim())
    }

    private fun count(text: String, part: String) = text.split(part).size - 1

    /** [text] with each run of whitespace, line breaks included, as one space. */
    private fun flat(text: String): String = text.replace(Regex("\\s+"), " ")

    /** What follows [part] in [text], leading whitespace removed. */
    private fun after(text: String, part: String): String = text.substring(text.indexOf(part) + part.length).trimStart()

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
