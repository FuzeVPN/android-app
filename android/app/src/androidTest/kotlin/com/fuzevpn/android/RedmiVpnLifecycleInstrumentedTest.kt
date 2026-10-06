package com.fuzevpn.android

import android.app.ActivityManager
import android.app.Instrumentation
import android.app.KeyguardManager
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Bundle
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.UiObject2
import androidx.test.uiautomator.Until
import java.net.NetworkInterface
import java.util.Collections
import java.util.regex.Pattern
import org.junit.After
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * End-to-end lifecycle validation for a signed-in physical Android device.
 *
 * The test deliberately drives only public UI semantics. It never reads the
 * encrypted session, profiles, certificates, keys, API responses, or logcat.
 * Host-side execution is provided by tools/test_redmi_vpn_lifecycle.ps1.
 */
@RunWith(AndroidJUnit4::class)
class RedmiVpnLifecycleInstrumentedTest {
    private val instrumentation: Instrumentation = InstrumentationRegistry.getInstrumentation()
    private val targetContext: Context = instrumentation.targetContext
    private val device: UiDevice = UiDevice.getInstance(instrumentation)
    private val connectivity: ConnectivityManager =
        targetContext.getSystemService(ConnectivityManager::class.java)
    private val activityManager: ActivityManager =
        targetContext.getSystemService(ActivityManager::class.java)
    private val keyguardManager: KeyguardManager =
        targetContext.getSystemService(KeyguardManager::class.java)

    private val arguments: Bundle = InstrumentationRegistry.getArguments()
    private val cycles: Int = arguments.getString("cycles")?.toIntOrNull()?.coerceIn(1, 10) ?: 3
    private val sourceLocation: String = safeLocationArgument("source_location", "Frankfurt-01")
    private val targetLocation: String = safeLocationArgument("target_location", "Frankfurt-02")
    private val connectionTimeoutMs: Long =
        arguments.getString("connection_timeout_seconds")
            ?.toLongOrNull()
            ?.coerceIn(30, 300)
            ?.times(1_000) ?: 120_000
    private val migrationTimeoutMs: Long =
        arguments.getString("migration_timeout_seconds")
            ?.toLongOrNull()
            ?.coerceIn(60, 600)
            ?.times(1_000) ?: 300_000

    @Before
    fun launchSignedInApplication() {
        device.wakeUp()
        check(!keyguardManager.isKeyguardLocked) {
            "device_locked: unlock the phone before starting the Redmi lifecycle test"
        }
        stage("PRECHECK device unlocked; launching application")
        check(targetContext.packageName == PACKAGE_NAME) { "unexpected_target_package" }
        check(targetContext.packageManager.getLaunchIntentForPackage(PACKAGE_NAME) != null) {
            "application_not_installed"
        }
        val launchResult = device.executeShellCommand(
            "am start -W -n $PACKAGE_NAME/${MainActivity::class.java.name}",
        )
        check(!launchResult.contains("Error", ignoreCase = true)) { "application_launch_failed" }
        assertTrue(
            "app_not_visible",
            device.wait(Until.hasObject(By.pkg(PACKAGE_NAME)), UI_TIMEOUT_MS),
        )
        requireSignedInHome()
        forceFrenchUi()
        ensureIdle()
    }

    @After
    fun leaveDeviceWithoutVpn() {
        runCatching {
            navigateToConnection()
            if (hasVpnNetwork() || hasActiveVpnService() || hasTunnelInterface()) {
                clickAnyText(DISCONNECT_LABELS, 5_000)
                waitForStopped(STOP_TIMEOUT_MS)
            }
        }
        stage("FINAL VPN network=${hasVpnNetwork()} service=${hasActiveVpnService()} tun=${hasTunnelInterface()}")
    }

    @Test
    fun runsRequestedVpnLifecycleMatrix() {
        stage("MATRIX cycles=$cycles source=$sourceLocation target=$targetLocation")

        selectLocation(sourceLocation)
        repeat(cycles) { index ->
            connectAndDisconnect(Protocol.WIREGUARD, "WireGuard cycle ${index + 1}/$cycles")
        }

        repeat(cycles) { index ->
            connectAndDisconnect(Protocol.OPENVPN, "OpenVPN cycle ${index + 1}/$cycles")
        }

        stage("HANDOFF WireGuard -> OpenVPN -> WireGuard")
        connectAndDisconnect(Protocol.WIREGUARD, "handoff WireGuard")
        connectAndDisconnect(Protocol.OPENVPN, "handoff OpenVPN")
        connectAndDisconnect(Protocol.WIREGUARD, "handoff WireGuard return")

        stage("LOCATION $sourceLocation -> $targetLocation using OpenVPN")
        selectLocation(sourceLocation)
        connectAndDisconnect(Protocol.OPENVPN, "location source $sourceLocation", migrationTimeoutMs)
        selectLocation(targetLocation)
        connectAndDisconnect(Protocol.OPENVPN, "location target $targetLocation", migrationTimeoutMs)

        assertStopped("matrix completion")
        stage("PASS lifecycle matrix completed and VPN fully stopped")
    }

    @Test
    fun releasesOpenVpnProfileBeforeDirectWireGuardLocationSwitch() {
        stage(
            "ROOT FLOW OpenVPN $sourceLocation -> WireGuard $targetLocation " +
                "without device migration",
        )

        // Establishing OpenVPN first guarantees that the logical device owns an
        // OpenVPN profile. A subsequent WireGuard move must revoke only that
        // profile and retry the direct registration once; it must never start a
        // whole-device location migration.
        selectLocation(sourceLocation)
        connectAndDisconnect(
            Protocol.OPENVPN,
            "root-flow OpenVPN profile at $sourceLocation",
            migrationTimeoutMs,
        )

        selectLocation(targetLocation)
        navigateToConnection()
        selectProtocol(Protocol.WIREGUARD)
        val startedAt = System.currentTimeMillis()
        clickText("Se connecter")
        acceptVpnPermissionIfDisplayed()
        waitForConnected(
            Protocol.WIREGUARD,
            connectionTimeoutMs,
            forbidLocationMigration = true,
        )
        val elapsedMs = System.currentTimeMillis() - startedAt
        stage(
            "DIRECT WireGuard connected at $targetLocation in ${elapsedMs}ms " +
                "without migration UI",
        )

        clickText("Se déconnecter")
        waitForStopped(STOP_TIMEOUT_MS)
        assertStopped("root-flow completion")
        stage("PASS canonical OpenVPN release and direct WireGuard retry")
    }

    private fun connectAndDisconnect(
        protocol: Protocol,
        label: String,
        timeoutMs: Long = connectionTimeoutMs,
    ) {
        stage("START $label")
        navigateToConnection()
        selectProtocol(protocol)
        clickText("Se connecter")
        acceptVpnPermissionIfDisplayed()
        waitForConnected(protocol, timeoutMs)
        stage(
            "CONNECTED $label network=${hasVpnNetwork()} " +
                "service=${hasProtocolService(protocol)} tun=${hasTunnelInterface()}",
        )
        clickText("Se déconnecter")
        waitForStopped(STOP_TIMEOUT_MS)
        assertStopped(label)
        stage("STOPPED $label network=false service=false tun=false")
    }

    private fun waitForConnected(
        protocol: Protocol,
        timeoutMs: Long,
        forbidLocationMigration: Boolean = false,
    ) {
        val deadline = System.currentTimeMillis() + timeoutMs
        while (System.currentTimeMillis() < deadline) {
            acceptVpnPermissionIfDisplayed()
            if (forbidLocationMigration && MIGRATION_LABELS.any(::hasLabel)) {
                error("unexpected_device_location_migration_for_wireguard")
            }
            val uiConnected = hasLabel("Connecté")
            if (uiConnected && hasVpnNetwork() && hasProtocolService(protocol) && hasTunnelInterface()) return
            failIfVisibleNotice()
            Thread.sleep(POLL_MS)
        }
        error(
            "connection_timeout_${protocol.code}: ui=${hasLabel("Connecté")} " +
                "network=${hasVpnNetwork()} service=${hasProtocolService(protocol)} " +
                "tun=${hasTunnelInterface()} services=${runningVpnServices().joinToString()}",
        )
    }

    private fun waitForStopped(timeoutMs: Long) {
        val deadline = System.currentTimeMillis() + timeoutMs
        while (System.currentTimeMillis() < deadline) {
            val uiIdle = IDLE_LABELS.any(::hasLabel)
            if (uiIdle && !hasVpnNetwork() && !hasActiveVpnService() && !hasTunnelInterface()) return
            Thread.sleep(POLL_MS)
        }
        error(
            "vpn_stop_timeout: network=${hasVpnNetwork()} service=${hasActiveVpnService()} " +
                "tun=${hasTunnelInterface()} services=${runningVpnServices().joinToString()}",
        )
    }

    private fun assertStopped(stage: String) {
        assertFalse("$stage: VPN transport is still active", hasVpnNetwork())
        assertFalse("$stage: VPN foreground service is still active", hasActiveVpnService())
        assertFalse("$stage: TUN interface is still active", hasTunnelInterface())
    }

    private fun ensureIdle() {
        navigateToConnection()
        if (!hasVpnNetwork() && !hasActiveVpnService() && !hasTunnelInterface()) return
        check(clickAnyText(DISCONNECT_LABELS, 5_000)) {
            "preexisting_vpn_active: disconnect the other VPN before running this test"
        }
        waitForStopped(STOP_TIMEOUT_MS)
    }

    private fun requireSignedInHome() {
        val homeVisible = waitForAnyText(SETTINGS_LABELS, UI_TIMEOUT_MS) != null
        check(homeVisible) {
            "signed_in_session_required: sign in and load locations before running this test"
        }
    }

    private fun forceFrenchUi() {
        clickAnyText(SETTINGS_LABELS, UI_TIMEOUT_MS)
        val french = findTextWithScroll("Français", UI_TIMEOUT_MS)
            ?: error("language_selector_not_found")
        clickClickable(french)
        check(waitForLabel("Réglages", UI_TIMEOUT_MS) != null) { "french_locale_not_applied" }
        navigateToConnection()
    }

    private fun navigateToConnection() {
        if (hasLabel("Votre connexion")) return
        check(clickAnyText(CONNECTION_NAV_LABELS, UI_TIMEOUT_MS)) { "connection_tab_not_found" }
        check(waitForLabel("Votre connexion", UI_TIMEOUT_MS) != null) { "connection_page_not_visible" }
    }

    private fun selectProtocol(protocol: Protocol) {
        val node = findTextWithScroll(protocol.uiLabel, UI_TIMEOUT_MS)
            ?: error("protocol_not_available_${protocol.code}")
        check(node.isEnabled) { "protocol_disabled_${protocol.code}" }
        clickClickable(node)
        Thread.sleep(UI_SETTLE_MS)
    }

    private fun selectLocation(location: String) {
        require(SAFE_LOCATION.matches(location)) { "unsafe_location_argument" }
        navigateToConnection()
        val locationLabels = locationUiLabels(location)
        val displayed = locationLabels
            .asSequence()
            .flatMap { findLabelsContaining(it).asSequence() }
            .firstOrNull { labelValue(it).contains(" · ") }
        if (displayed != null) {
            stage("LOCATION selected=$location")
            return
        }

        val knownCurrent = listOf(sourceLocation, targetLocation)
            .asSequence()
            .flatMap(::locationUiLabels)
            .flatMap { findLabelsContaining(it).asSequence() }
            .firstOrNull {
                val value = labelValue(it)
                value.contains("Emplacement") || value.contains(" · ")
            }
            ?: findTextWithScroll("Emplacement", UI_TIMEOUT_MS)
            ?: error("location_dropdown_not_found")
        clickClickable(knownCurrent)
        Thread.sleep(UI_SETTLE_MS)

        val target = locationLabels.asSequence()
            .mapNotNull { waitForLabelContaining(it, UI_TIMEOUT_MS) }
            .firstOrNull()
            ?: error("location_not_available_$location")
        clickClickable(target)
        Thread.sleep(UI_SETTLE_MS)
        stage("LOCATION selected=$location")
    }

    private fun locationUiLabels(location: String): List<String> {
        val display = location.replace(Regex("-0?([0-9]+)$"), " $1")
        return listOf(location, display).distinct()
    }

    private fun acceptVpnPermissionIfDisplayed() {
        if (device.currentPackageName == PACKAGE_NAME) return
        val positive = device.findObject(By.res("android", "button1"))
            ?: device.findObject(By.text(Pattern.compile("(?i)autoriser|allow|accepter|ok")))
        positive?.let {
            clickClickable(it)
            Thread.sleep(UI_SETTLE_MS)
        }
    }

    private fun failIfVisibleNotice() {
        val diagnostic = findLabel("Code diagnostic")?.let(::labelValue)
        if (diagnostic != null) error("vpn_notice: $diagnostic")
    }

    private fun clickText(text: String) {
        val node = findTextWithScroll(text, UI_TIMEOUT_MS) ?: error("ui_action_not_found_$text")
        check(node.isEnabled) { "ui_action_disabled_$text" }
        clickClickable(node)
        Thread.sleep(UI_SETTLE_MS)
    }

    private fun clickAnyText(labels: List<String>, timeoutMs: Long): Boolean {
        val node = waitForAnyText(labels, timeoutMs) ?: return false
        clickClickable(node)
        Thread.sleep(UI_SETTLE_MS)
        return true
    }

    private fun waitForAnyText(labels: List<String>, timeoutMs: Long): UiObject2? {
        val deadline = System.currentTimeMillis() + timeoutMs
        while (System.currentTimeMillis() < deadline) {
            labels.forEach { label -> findLabel(label)?.let { return it } }
            Thread.sleep(POLL_MS)
        }
        return null
    }

    private fun labelValue(node: UiObject2): String =
        node.text ?: node.contentDescription ?: ""

    private fun hasLabel(label: String): Boolean = findLabel(label) != null

    private fun findLabel(label: String): UiObject2? =
        device.findObject(By.text(label))
            ?: device.findObject(By.desc(label))
            ?: device.findObject(By.textContains(label))
            ?: device.findObject(By.descContains(label))

    private fun findLabelsContaining(label: String): List<UiObject2> =
        (device.findObjects(By.textContains(label)) + device.findObjects(By.descContains(label)))
            .distinctBy { it.hashCode() }

    private fun waitForLabel(label: String, timeoutMs: Long): UiObject2? {
        val deadline = System.currentTimeMillis() + timeoutMs
        while (System.currentTimeMillis() < deadline) {
            findLabel(label)?.let { return it }
            Thread.sleep(POLL_MS)
        }
        return null
    }

    private fun waitForLabelContaining(label: String, timeoutMs: Long): UiObject2? {
        val deadline = System.currentTimeMillis() + timeoutMs
        while (System.currentTimeMillis() < deadline) {
            findLabelsContaining(label).firstOrNull()?.let { return it }
            Thread.sleep(POLL_MS)
        }
        return null
    }

    private fun findTextWithScroll(text: String, timeoutMs: Long): UiObject2? {
        val deadline = System.currentTimeMillis() + timeoutMs
        var directionUp = true
        while (System.currentTimeMillis() < deadline) {
            findLabel(text)?.let { return it }
            val x = device.displayWidth / 2
            if (directionUp) {
                device.swipe(x, device.displayHeight * 3 / 4, x, device.displayHeight / 3, 24)
            } else {
                device.swipe(x, device.displayHeight / 3, x, device.displayHeight * 3 / 4, 24)
            }
            directionUp = !directionUp
            Thread.sleep(UI_SETTLE_MS)
        }
        return null
    }

    private fun clickClickable(objectFound: UiObject2) {
        var current: UiObject2? = objectFound
        repeat(6) {
            val candidate = current ?: return@repeat
            if (candidate.isClickable && candidate.isEnabled) {
                candidate.click()
                return
            }
            current = candidate.parent
        }
        objectFound.click()
    }

    private fun hasVpnNetwork(): Boolean = connectivity.allNetworks.any { network ->
        connectivity.getNetworkCapabilities(network)?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true
    }

    private fun hasTunnelInterface(): Boolean = runCatching {
        Collections.list(NetworkInterface.getNetworkInterfaces()).any { networkInterface ->
            networkInterface.isUp && TUN_INTERFACE.matches(networkInterface.name)
        }
    }.getOrDefault(false)

    @Suppress("DEPRECATION")
    private fun runningVpnServices(): List<String> =
        activityManager.getRunningServices(256)
            .map { it.service.className }
            .filter { name -> VPN_SERVICE_NAMES.any { marker -> name.contains(marker) } }
            .sorted()

    private fun hasActiveVpnService(): Boolean = runningVpnServices().isNotEmpty()

    private fun hasProtocolService(protocol: Protocol): Boolean =
        runningVpnServices().any { service -> service.contains(protocol.serviceMarker) }

    private fun safeLocationArgument(key: String, fallback: String): String {
        val value = arguments.getString(key) ?: fallback
        require(SAFE_LOCATION.matches(value)) { "unsafe_$key" }
        return value
    }

    private fun stage(message: String) {
        val safe = message.replace(Regex("[^A-Za-z0-9 _./:=\\-]"), "?").take(300)
        instrumentation.sendStatus(
            2,
            Bundle().apply { putString(Instrumentation.REPORT_KEY_STREAMRESULT, "\n[FUZEVPN] $safe\n") },
        )
    }

    private enum class Protocol(
        val code: String,
        val uiLabel: String,
        val serviceMarker: String,
    ) {
        WIREGUARD("wireguard", "WireGuard", "GoBackend\$VpnService"),
        OPENVPN("openvpn", "OpenVPN", "OpenVpnService"),
    }

    private companion object {
        const val PACKAGE_NAME = "com.fuzevpn"
        const val UI_TIMEOUT_MS = 20_000L
        const val STOP_TIMEOUT_MS = 30_000L
        const val POLL_MS = 500L
        const val UI_SETTLE_MS = 800L

        val SAFE_LOCATION = Regex("^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$")
        val TUN_INTERFACE = Regex("^(tun|wg|vpn)[A-Za-z0-9._-]*$", RegexOption.IGNORE_CASE)
        val VPN_SERVICE_NAMES = listOf(
            "GoBackend\$VpnService",
            "OpenVpnService",
            "VpnForegroundService",
        )
        val SETTINGS_LABELS = listOf("Réglages", "Settings", "Ajustes", "Einstellungen")
        val CONNECTION_NAV_LABELS = listOf("Connexion", "Connection", "Conexión", "Verbindung")
        val DISCONNECT_LABELS = listOf("Se déconnecter", "Disconnect", "Desconectar", "Trennen")
        val IDLE_LABELS = listOf("Déconnecté", "Disconnected", "Desconectado", "Getrennt")
        val MIGRATION_LABELS = listOf(
            "Changement d’emplacement",
            "Location change",
            "Cambio de ubicación",
            "Standortwechsel",
        )
    }
}
