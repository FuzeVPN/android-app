package com.fuzevpn.android

import org.json.JSONObject
import org.junit.Assert.*
import org.junit.Test

class TurnstilePolicyTest {
    private val id = "0123456789abcdef0123456789abcdef"
    private fun arguments() = mapOf("requestId" to id, "title" to "Vérification de sécurité", "cancelLabel" to "Annuler")
    private fun poll(kind: String, token: Any? = null): String {
        val payload = JSONObject().put("kind", kind)
        if (token != null) payload.put("token", token)
        return JSONObject.quote(payload.toString())
    }

    @Test fun solveAcceptsOnlyTheLocalOperationAndNativeUiLabels() {
        val selected = TurnstilePolicy.selection(arguments())
        assertEquals(id, selected.requestId)
        assertEquals("Vérification de sécurité", selected.title)
        assertEquals("Annuler", selected.cancelLabel)
        assertFalse(selected.toString().contains(id))
        assertFalse(selected.toString().contains(selected.title))
        for (invalid in listOf(
            null, emptyMap<String, String>(), arguments() - "title", arguments() + ("url" to "https://example.test"),
            arguments() + ("sitekey" to "other"), arguments() + ("bearer" to "credential-fixture"),
            arguments() + ("requestId" to "short"), arguments() + ("requestId" to "x".repeat(129)),
            arguments() + ("requestId" to "person@example.test"), arguments() + ("title" to " "),
            arguments() + ("title" to "x".repeat(121)), arguments() + ("cancelLabel" to "x".repeat(65)),
            arguments() + ("title" to "title\nsecond line"),
        )) assertEquals("invalid_request", assertThrows(TurnstileException::class.java) { TurnstilePolicy.selection(invalid) }.code)
    }

    @Test fun cancellationIsExactAndCarriesNoOtherContext() {
        assertEquals(id, TurnstilePolicy.cancellation(mapOf("requestId" to id)))
        for (invalid in listOf(null, mapOf("requestId" to id, "token" to "fixture"), mapOf("requestId" to ""))) {
            assertEquals("invalid_request", assertThrows(TurnstileException::class.java) { TurnstilePolicy.cancellation(invalid) }.code)
        }
    }

    @Test fun tokenIsBoundedPrintableAsciiAndRedactedInDiagnostics() {
        assertEquals("a".repeat(2048), TurnstilePolicy.token("a".repeat(2048)))
        for (invalid in listOf(null, 12, "", "a".repeat(2049), "token value", "token\n", "é", "token\u007f")) {
            val error = assertThrows(TurnstileException::class.java) { TurnstilePolicy.token(invalid) }
            assertEquals("invalid_response", error.code)
            assertEquals("invalid_response", error.message)
        }
        val result = TurnstilePolicy.pollResult(poll("token", "private-token-fixture")) as TurnstilePollResult.Token
        assertEquals("private-token-fixture", result.value)
        assertFalse(result.toString().contains(result.value))
    }

    @Test fun pollAcceptsOnlyBoundedCompleteJsonAndKnownShapes() {
        assertSame(TurnstilePollResult.Pending, TurnstilePolicy.pollResult("null"))
        assertSame(TurnstilePollResult.Pending, TurnstilePolicy.pollResult(JSONObject.quote("null")))
        assertSame(TurnstilePollResult.ProviderError, TurnstilePolicy.pollResult(poll("error")))
        assertSame(TurnstilePollResult.Expired, TurnstilePolicy.pollResult(poll("expired")))
        assertSame(TurnstilePollResult.Ready, TurnstilePolicy.pollResult(poll("ready")))
        for (invalid in listOf(
            poll("ready", "unexpected"), JSONObject.quote("{\"kind\":\"ready\",\"detail\":true}"),
            null, "x".repeat(16385), "{}", "[]", "true", JSONObject.quote("{}"),
            JSONObject.quote("{\"kind\":\"token\",\"token\":7}"), poll("token", "a".repeat(2049)),
            JSONObject.quote("{\"kind\":\"error\",\"message\":\"provider-secret-fixture\"}"),
            JSONObject.quote("{\"kind\":\"token\",\"token\":\"fixture\"} trailing"),
            poll("unknown"), poll("error", "unexpected"), poll("token", "valid") + " trailing",
        )) assertEquals("invalid_response", assertThrows(TurnstileException::class.java) { TurnstilePolicy.pollResult(invalid) }.code)
    }

    @Test fun errorsNeverReturnProviderTextOrUnknownCodes() {
        for (value in listOf("token-fixture", "provider-secret-fixture", "https://example.test", null, 42)) {
            assertEquals("provider_error", TurnstilePolicy.safeError(value))
        }
        for (code in listOf("cancelled", "interrupted", "unavailable", "busy", "invalid_request", "invalid_response", "provider_error")) {
            assertEquals(code, TurnstilePolicy.safeError(code))
        }
        assertEquals("provider_error", TurnstileException("secret-fixture").message)
    }

    @Test fun embeddedIdentityNeverAuthorizesANetworkMainFrame() {
        assertTrue(TurnstilePolicy.isEmbeddedDocument("https://app.fuzevpn.com/"))
        for (url in listOf(null, "about:blank", "https://app.fuzevpn.com/?token=fixture", "https://app.fuzevpn.com/other",
            "https://app.fuzevpn.com/#fragment", "https://app.fuzevpn.com.evil.test/")) {
            assertFalse(TurnstilePolicy.isEmbeddedDocument(url))
        }
        for (url in listOf(TurnstilePolicy.BASE_URL, TurnstilePolicy.SCRIPT_URL, "about:blank", "about:srcdoc")) {
            assertFalse(TurnstilePolicy.allowsResource(url, true))
        }
    }

    @Test fun subresourcesHaveExactHttpsProviderOriginOnly() {
        for (url in listOf(TurnstilePolicy.SCRIPT_URL, "https://challenges.cloudflare.com:443/path?q=public", "about:blank", "about:srcdoc")) {
            assertTrue(url, TurnstilePolicy.allowsResource(url, false))
        }
        for (url in listOf(null, "http://challenges.cloudflare.com/", "https://challenges.cloudflare.com.evil.test/",
            "https://challenges.cloudflare.com@evil.test/", "https://user@challenges.cloudflare.com/", "https://challenges.cloudflare.com:444/",
            "https://app.fuzevpn.com/", "javascript:alert(1)", "file:///tmp/fixture", "content://fixture", "data:text/html,fixture",
            "intent://fixture", "https://challenges.cloudflare.com/" + "x".repeat(4097))) {
            assertFalse(url, TurnstilePolicy.allowsResource(url, false))
        }
    }

    @Test fun documentUsesFixedContractNonceCspAndReadOnceClosure() {
        val nonce = "aB_012345678901234567890123456789"
        val html = TurnstileDocument.html(nonce)
        assertTrue(html.contains("sitekey: '0x4AAAAAAE-cdqxPJMG4iuq4', action: 'signup'"))
        assertTrue(html.contains("https://challenges.cloudflare.com/turnstile/v0/api.js?onload="))
        assertTrue(html.contains("script-src 'nonce-$nonce' 'strict-dynamic'"))
        assertTrue(html.contains("frame-src 'self' about: https://challenges.cloudflare.com"))
        assertTrue(html.contains("form-action 'none'"))
        assertTrue(html.contains("base-uri 'none'"))
        assertFalse(html.contains("'unsafe-eval'"))
        assertFalse(html.contains("addJavascriptInterface"))
        assertTrue(html.contains("var value = outcome; outcome = null; return value;"))
        assertTrue(html.contains("'response-field': false"))
        assertTrue(html.contains("size: 'compact'"))
        assertTrue(html.indexOf("<div id=\"challenge\">") < html.indexOf("src=\"https://challenges.cloudflare.com/turnstile/v0/api.js"))
        assertTrue(html.contains("window.addEventListener('error', function(event) {"))
        assertTrue(html.contains("source.src.indexOf('https://challenges.cloudflare.com/turnstile/v0/api.js?') === 0"))
        assertTrue(html.contains("}, true);"))
        assertTrue(html.contains("return ready && !settled ? {kind:'ready'} : null;"))
        assertFalse(Regex("<script[^>]*\\son[a-z]+\\s*=").containsMatchIn(html))
        assertTrue(TurnstileDocument.takeResultScript.contains("window !== window.top"))
        assertTrue(TurnstileDocument.takeResultScript.contains("window.location.href !== 'https://app.fuzevpn.com/'"))
        assertThrows(IllegalArgumentException::class.java) { TurnstileDocument.html("x\" onload=\"fixture") }
    }

    @Test fun providerStartupIsBoundedWellBeforeTheGlobalDeadline() {
        assertEquals(30_000L, TurnstilePolicy.STARTUP_TIMEOUT_MS)
        assertTrue(TurnstilePolicy.STARTUP_TIMEOUT_MS + TurnstilePolicy.POLL_INTERVAL_MS < TurnstilePolicy.TIMEOUT_MS)
    }

    @Test fun gateIsSingleOwnerAndLateCallbacksCannotCompleteARetryWithTheSameId() {
        val gate = TurnstileFlowGate { 100L }
        val first = gate.reserve(id)
        assertEquals("busy", assertThrows(TurnstileException::class.java) { gate.reserve("another-request-id") }.code)
        assertNull(gate.matching("another-request-id"))
        assertSame(first, gate.matching(id))
        assertTrue(gate.finish(first))
        val second = gate.reserve(id)
        assertFalse(gate.owns(first))
        assertFalse(gate.isCurrent(first))
        assertFalse(gate.finish(first))
        assertTrue(gate.isCurrent(second))
        assertTrue(gate.finish(second))
        assertFalse(gate.finish(second))
    }

    @Test fun deadlineRejectsAResultAtFourMinutesAndAllowsExplicitCleanup() {
        var now = 1_000L
        val gate = TurnstileFlowGate { now }
        val ticket = gate.reserve(id)
        assertEquals(241_000L, ticket.deadlineMillis)
        now = 240_999L
        assertTrue(gate.isCurrent(ticket))
        now++
        assertFalse(gate.isCurrent(ticket))
        assertTrue(gate.owns(ticket))
        assertTrue(gate.finish(ticket))
        assertNull(gate.matching(id))
    }

    @Test fun terminalResultSurvivesTeardownFailureAndLateCallbacksAreIgnored() {
        val gate = TurnstileFlowGate { 0L }
        val ticket = gate.reserve(id)
        var deliveries = 0
        assertTrue(gate.finishWith(ticket, cleanup = {
            assertFalse(gate.owns(ticket))
            assertEquals(0, deliveries)
            throw IllegalStateException("vendor-teardown-fixture")
        }, deliver = { deliveries++ }))
        assertEquals(1, deliveries)
        assertFalse(gate.finishWith(ticket, cleanup = { fail("late cleanup") }, deliver = { deliveries++ }))
        assertEquals(1, deliveries)
    }

    @Test fun teardownCannotReenterTheFinishedOperationBeforeItsResultIsDelivered() {
        val gate = TurnstileFlowGate { 0L }
        val ticket = gate.reserve(id)
        var deliveries = 0
        gate.finishWith(ticket, cleanup = {
            assertFalse(gate.finishWith(ticket, cleanup = {}, deliver = { deliveries++ }))
        }, deliver = { deliveries++ })
        assertEquals(1, deliveries)
    }
}
