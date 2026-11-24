package com.fuzevpn.android

import java.io.File
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * Split tunneling where Android itself applies it. VpnService.Builder and PackageManager are not
 * available to JVM tests and the bridge-host suite fakes OpenVpnService, so this wiring is pinned
 * in the source.
 */
class SplitTunnelWiringTest {
    private fun source(path: String): String = listOf("src/main", "android/app/src/main")
        .map { File(it, path) }
        .first { it.isFile }
        .readText()

    private fun kotlin(name: String) = source("kotlin/com/fuzevpn/android/$name")

    // Google Play reserves QUERY_ALL_PACKAGES to apps whose core purpose needs it: the launcher's
    // apps are visible through this one intent instead.
    @Test fun theManifestSeesOnlyTheLaunchersApps() {
        val manifest = source("AndroidManifest.xml").replace(Regex("<!--.*?-->", RegexOption.DOT_MATCHES_ALL), "")
        assertFalse(manifest.contains("QUERY_ALL_PACKAGES"))
        val queries = Regex("<queries>(.*?)</queries>", RegexOption.DOT_MATCHES_ALL).findAll(manifest).toList()
        assertEquals(1, queries.size)
        val declared = queries.single().groupValues[1]
        assertEquals(listOf("android.intent.action.MAIN", "android.intent.category.LAUNCHER"),
            Regex("android:name=\"([^\"]+)\"").findAll(declared).map { it.groupValues[1] }.toList())
        assertFalse(declared.contains("<package"))
        assertFalse(declared.contains("<provider"))
    }

    // Each OpenVPN establish() excludes the apps of its connection, and a retained TUN is reused
    // only for a plan with the same apps.
    @Test fun eachOpenVpnInterfaceExcludesTheAppsOfItsConnection() {
        val establish = block(kotlin("OpenVpnService.kt"), "internal fun establishFromPlan(")
        val plan = establish.indexOf(".copy(excludedApplications = excludedApplications)")
        val reuse = establish.indexOf("reuseRetainedTun(validated, service)")
        val excluded = establish.indexOf("validated.excludedApplications.forEach")
        val disallowed = establish.indexOf("builder.addDisallowedApplication(it)")
        val established = establish.indexOf("builder.establish()")
        assertTrue(establish, plan in 0 until reuse)
        assertTrue(establish, excluded in 0 until disallowed)
        assertTrue(establish, disallowed in 0 until established)
        assertFalse(establish, establish.contains("addAllowedApplication"))
    }

    @Test fun theBridgeSetsTheListBeforeEachNewOpenVpnService() {
        val bridge = kotlin("AndroidVpnBridge.kt")
        for (start in listOf("private suspend fun connectOpenVpn(", "private suspend fun reconnectOpenVpn(")) {
            val body = block(bridge, start)
            val excluded = body.indexOf("OpenVpnService.excludeApplications(beginTunnelExclusions())")
            val service = body.indexOf("OpenVpnService.start(appContext)")
            assertTrue(start, excluded in 0 until service)
        }
        val wireGuard = block(bridge, "private suspend fun connectWireGuard(")
        assertTrue(wireGuard.indexOf("val excludedApps = beginTunnelExclusions()") in 0 until
            wireGuard.indexOf("wireGuard.connect(request, excludedApps,"))
    }

    private fun block(source: String, start: String): String {
        val at = source.indexOf(start)
        assertTrue("missing: $start", at >= 0)
        val open = source.indexOf('{', source.indexOf(')', at))
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
