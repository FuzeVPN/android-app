package com.fuzevpn.android

import android.app.Activity
import android.os.Handler
import android.os.SystemClock
import android.webkit.*
import io.flutter.plugin.common.*
import org.json.JSONObject
import org.junit.Assert.*
import org.junit.Test

/** The unchanged Android-facing bridge runs with deterministic host API doubles.
 * This source belongs to testHost, never to an Android application source set. */
class NativeTurnstileBridgeHostTest {
    private class ResultRecorder : MethodChannel.Result {
        val errors = mutableListOf<String>()
        val successes = mutableListOf<Any?>()
        override fun success(value: Any?) { successes += value }
        override fun error(code: String, message: String?, details: Any?) {
            assertNull(message); assertNull(details)
            errors += code
        }
        override fun notImplemented() { fail("Unexpected method") }
    }
    private data class Fixture(val bridge: NativeTurnstileBridge, val result: ResultRecorder, val view: WebView)
    private val id = "0123456789abcdef0123456789abcdef"
    private fun solve(bridge: NativeTurnstileBridge): ResultRecorder = ResultRecorder().also {
        bridge.onMethodCall(MethodCall("solve", mapOf("requestId" to id, "title" to "Security", "cancelLabel" to "Cancel")), it)
    }
    private fun instance(start: Boolean = true, commit: Boolean = false, oldUrl: String? = null): Fixture {
        SystemClock.now = 0
        WebView.sendPageStarted = start
        WebView.commitImmediately = commit
        WebView.initialUrl = oldUrl
        WebView.throwOnDestroy = false
        val bridge = NativeTurnstileBridge(Activity(), object : BinaryMessenger {})
        bridge.onActivityResumed()
        val result = solve(bridge)
        return Fixture(bridge, result, WebView.latest)
    }
    private fun tokenRaw() = JSONObject.quote(JSONObject().put("kind", "token").put("token", "synthetic-token").toString())
    private fun finishToken(fixture: Fixture) {
        val callback = fixture.view.pendingEvaluation!!
        callback(tokenRaw())
        callback(tokenRaw())
        assertEquals(1, fixture.result.successes.size)
        assertTrue(fixture.result.errors.isEmpty())
        assertEquals(mapOf("requestId" to id, "token" to "synthetic-token"), fixture.result.successes.single())
        assertTrue(fixture.view.destroyed)
        assertTrue(Handler.latest.queue.isEmpty())
    }

    @Test fun startedLoadWaitsForItsPreviousUrlBeforeCommitWithoutEvaluatingIt() {
        for (oldUrl in listOf(null, "about:blank", "https://challenges.cloudflare.com/previous")) {
            val fixture = instance(oldUrl = oldUrl)
            repeat(3) {
                Handler.latest.advance(250)
                assertTrue("old=$oldUrl", fixture.result.errors.isEmpty())
                assertFalse(fixture.view.destroyed)
                assertEquals(0, fixture.view.evaluationCount)
            }
            fixture.view.url = TurnstilePolicy.BASE_URL
            fixture.view.webViewClient.onPageCommitVisible(fixture.view, TurnstilePolicy.BASE_URL)
            Handler.latest.advance(250)
            assertEquals(1, fixture.view.evaluationCount)
            finishToken(fixture)
        }
    }

    @Test fun initialLoadWaitsBeforePageStartedEvenIfTheExpectedUrlIsAlreadyReported() {
        for (oldUrl in listOf(null, "about:blank", TurnstilePolicy.BASE_URL)) {
            val fixture = instance(start = false, oldUrl = oldUrl)
            Handler.latest.advance(250)
            assertTrue(fixture.result.errors.isEmpty())
            assertEquals(0, fixture.view.evaluationCount)
            fixture.view.webViewClient.onPageStarted(fixture.view, TurnstilePolicy.BASE_URL, null)
            fixture.view.url = TurnstilePolicy.BASE_URL
            Handler.latest.advance(250)
            finishToken(fixture)
        }
    }

    @Test fun aCommittedCurrentUrlDoesNotRequireACommitVisibleNotification() {
        val fixture = instance(commit = true)
        Handler.latest.advance(250)
        assertEquals(1, fixture.view.evaluationCount)
        finishToken(fixture)
    }

    @Test fun initialUrlEqualToTheExpectedDocumentDoesNotPreventEvaluation() {
        val fixture = instance(oldUrl = TurnstilePolicy.BASE_URL)
        Handler.latest.advance(250)
        assertEquals(1, fixture.view.evaluationCount)
        finishToken(fixture)
    }

    @Test fun neverCommittedDocumentExpiresAtTheOriginalMonotonicDeadline() {
        for (oldUrl in listOf(null, "about:blank")) {
            val fixture = instance(oldUrl = oldUrl)
            val client = fixture.view.webViewClient
            Handler.latest.advance(TurnstilePolicy.TIMEOUT_MS - 250)
            assertTrue(fixture.result.errors.isEmpty())
            assertEquals(0, fixture.view.evaluationCount)
            Handler.latest.advance(249)
            assertTrue(fixture.result.errors.isEmpty())
            Handler.latest.advance(1)
            assertEquals(listOf("unavailable"), fixture.result.errors)
            assertEquals(0, fixture.view.evaluationCount)
            assertTrue(fixture.view.destroyed)
            client.onPageCommitVisible(fixture.view, TurnstilePolicy.BASE_URL)
            Handler.latest.advance(250)
            assertEquals(listOf("unavailable"), fixture.result.errors)
            assertTrue(Handler.latest.queue.isEmpty())
        }
    }

    @Test fun committingNearTheDeadlineDoesNotExtendItForTheTokenCallback() {
        val fixture = instance()
        Handler.latest.advance(TurnstilePolicy.TIMEOUT_MS - 500)
        fixture.view.url = TurnstilePolicy.BASE_URL
        Handler.latest.advance(250)
        assertEquals(1, fixture.view.evaluationCount)
        val callback = fixture.view.pendingEvaluation!!
        Handler.latest.advance(250)
        callback(tokenRaw())
        assertEquals(listOf("unavailable"), fixture.result.errors)
        assertTrue(fixture.result.successes.isEmpty())
    }

    @Test fun secondMainFrameStartIsRejectedEvenOnTheExpectedOrigin() {
        for (url in listOf(TurnstilePolicy.BASE_URL, "https://app.fuzevpn.com/other", "https://evil.test/")) {
            val fixture = instance()
            fixture.view.webViewClient.onPageStarted(fixture.view, url, null)
            assertEquals(listOf("invalid_response"), fixture.result.errors)
            assertEquals(0, fixture.view.evaluationCount)
            assertTrue(fixture.view.destroyed)
        }
    }

    @Test fun unexpectedFirstStartIsRejected() {
        val fixture = instance(start = false)
        fixture.view.webViewClient.onPageStarted(fixture.view, "https://evil.test/", null)
        assertEquals(listOf("invalid_response"), fixture.result.errors)
        assertTrue(fixture.view.destroyed)
    }

    @Test fun actualCommitOfTheOldOrAnUnexpectedDocumentIsRejectedInsteadOfWaitedFor() {
        for (url in listOf("about:blank", "https://challenges.cloudflare.com/previous", "https://evil.test/")) {
            val fixture = instance(oldUrl = url)
            fixture.view.webViewClient.onPageCommitVisible(fixture.view, url)
            assertEquals(listOf("invalid_response"), fixture.result.errors)
            assertEquals(0, fixture.view.evaluationCount)
            assertTrue(fixture.view.destroyed)
        }
    }

    @Test fun finishedUnexpectedMainDocumentIsRejected() {
        val fixture = instance(oldUrl = "about:blank")
        fixture.view.webViewClient.onPageFinished(fixture.view, "about:blank")
        assertEquals(listOf("invalid_response"), fixture.result.errors)
        assertTrue(fixture.view.destroyed)
    }

    @Test fun committedDocumentMustHaveTheExpectedStart() {
        val fixture = instance(start = false)
        fixture.view.webViewClient.onPageCommitVisible(fixture.view, TurnstilePolicy.BASE_URL)
        assertEquals(listOf("invalid_response"), fixture.result.errors)
    }

    @Test fun waitingForCommitDoesNotAuthorizeAnyNetworkMainFrame() {
        val fixture = instance(oldUrl = "about:blank")
        for (url in listOf(TurnstilePolicy.BASE_URL, TurnstilePolicy.SCRIPT_URL, "https://evil.test/")) {
            val request = object : WebResourceRequest { override val url = Url(url); override val isForMainFrame = true }
            assertTrue(fixture.view.webViewClient.shouldOverrideUrlLoading(fixture.view, request))
            assertNotNull(fixture.view.webViewClient.shouldInterceptRequest(fixture.view, request))
        }
        val provider = object : WebResourceRequest { override val url = Url(TurnstilePolicy.SCRIPT_URL); override val isForMainFrame = false }
        assertFalse(fixture.view.webViewClient.shouldOverrideUrlLoading(fixture.view, provider))
        assertNull(fixture.view.webViewClient.shouldInterceptRequest(fixture.view, provider))
        fixture.bridge.close()
    }

    @Test fun anUnexpectedCurrentUrlIsNotTreatedAsTheCapturedPreviousDocument() {
        val fixture = instance()
        fixture.view.url = "https://evil.test/"
        Handler.latest.advance(250)
        assertEquals(listOf("invalid_response"), fixture.result.errors)
        assertEquals(0, fixture.view.evaluationCount)
    }

    @Test fun observedEmbeddedDocumentCannotFallBackToWaitingOnItsPredecessor() {
        val fixture = instance(commit = true, oldUrl = "about:blank")
        Handler.latest.advance(250)
        fixture.view.pendingEvaluation!!("null")
        fixture.view.url = "about:blank"
        Handler.latest.advance(250)
        assertEquals(listOf("invalid_response"), fixture.result.errors)
        assertEquals(1, fixture.view.evaluationCount)
    }

    @Test fun aTokenCallbackCannotWinAfterTheCurrentMainDocumentChanged() {
        for (url in listOf(null, "about:blank", "https://evil.test/")) {
            val fixture = instance(commit = true)
            Handler.latest.advance(250)
            fixture.view.url = url
            fixture.view.pendingEvaluation!!(tokenRaw())
            assertEquals(listOf("invalid_response"), fixture.result.errors)
            assertTrue(fixture.result.successes.isEmpty())
            assertTrue(fixture.view.destroyed)
        }
    }

    @Test fun pauseDuringCommitWaitTerminatesAndRemovesAllQueuedWork() {
        val fixture = instance()
        Handler.latest.advance(250)
        fixture.bridge.onActivityPaused()
        assertEquals(listOf("interrupted"), fixture.result.errors)
        assertTrue(fixture.view.destroyed)
        assertTrue(Handler.latest.queue.isEmpty())
    }

    @Test fun pauseAndRetryWithTheSameIdRejectsAnOldTokenCallback() {
        val fixture = instance(commit = true)
        Handler.latest.advance(250)
        val oldCallback = fixture.view.pendingEvaluation!!
        fixture.bridge.onActivityPaused()
        fixture.bridge.onActivityResumed()
        val retried = solve(fixture.bridge)
        val nextView = WebView.latest
        oldCallback(tokenRaw())
        assertEquals(listOf("interrupted"), fixture.result.errors)
        assertTrue(retried.errors.isEmpty() && retried.successes.isEmpty())
        Handler.latest.advance(250)
        finishToken(Fixture(fixture.bridge, retried, nextView))
    }

    @Test fun cancellationDuringCommitWaitIsExactAndRemovesAllQueuedWork() {
        val fixture = instance()
        val wrong = ResultRecorder()
        fixture.bridge.onMethodCall(MethodCall("cancel", mapOf("requestId" to "another-request-id")), wrong)
        assertTrue(fixture.result.errors.isEmpty())
        val cancel = ResultRecorder()
        fixture.bridge.onMethodCall(MethodCall("cancel", mapOf("requestId" to id)), cancel)
        assertEquals(listOf("cancelled"), fixture.result.errors)
        assertEquals(listOf<Any?>(null), cancel.successes)
        assertTrue(fixture.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun closeDuringEvaluationInvalidatesLateCallbacksAndFutureSolves() {
        val fixture = instance(commit = true)
        Handler.latest.advance(250)
        val callback = fixture.view.pendingEvaluation!!
        fixture.bridge.close(); fixture.bridge.close()
        callback(tokenRaw())
        assertEquals(listOf("interrupted"), fixture.result.errors)
        assertTrue(fixture.result.successes.isEmpty())
        assertEquals(listOf("unavailable"), solve(fixture.bridge).errors)
        assertTrue(Handler.latest.queue.isEmpty())
    }

    @Test fun sslAndRendererFailuresStillTearDownTheChallenge() {
        val sslFixture = instance()
        val ssl = SslErrorHandler()
        sslFixture.view.webViewClient.onReceivedSslError(sslFixture.view, ssl, null)
        assertTrue(ssl.cancelled)
        assertEquals(listOf("unavailable"), sslFixture.result.errors)
        assertTrue(sslFixture.view.destroyed)
        val rendererFixture = instance()
        assertTrue(rendererFixture.view.webViewClient.onRenderProcessGone(rendererFixture.view, null))
        assertEquals(listOf("unavailable"), rendererFixture.result.errors)
        assertTrue(rendererFixture.view.destroyed)
    }

    @Test fun vendorTeardownFailureCannotDiscardTheTerminalToken() {
        val fixture = instance(commit = true)
        Handler.latest.advance(250)
        WebView.throwOnDestroy = true
        try { finishToken(fixture) } finally { WebView.throwOnDestroy = false }
    }

    @Test fun detachedViewDuringCommitWaitInterruptsBeforeAnyEvaluation() {
        val fixture = instance()
        fixture.view.isAttachedToWindow = false
        Handler.latest.advance(250)
        assertEquals(listOf("interrupted"), fixture.result.errors)
        assertEquals(0, fixture.view.evaluationCount)
    }

    @Test fun webViewSecuritySettingsRemainRestrictedWhileTheDocumentIsPending() {
        val fixture = instance()
        fixture.view.settings.apply {
            assertTrue(javaScriptEnabled && domStorageEnabled)
            assertFalse(allowFileAccess || allowContentAccess || allowFileAccessFromFileURLs || allowUniversalAccessFromFileURLs)
            assertFalse(javaScriptCanOpenWindowsAutomatically || multipleWindows || saveFormData)
            assertTrue(mediaPlaybackRequiresUserGesture)
            assertEquals(WebSettings.MIXED_CONTENT_NEVER_ALLOW, mixedContentMode)
        }
        fixture.bridge.close()
    }

    // A06-turnstile-01. Until the document reports {kind:'ready'} (provider onload), a null poll
    // means the provider script is still loading, failed silently or will never initialize.
    private val startupBound = 30_000L // TurnstilePolicy.STARTUP_TIMEOUT_MS, pinned by TurnstilePolicyTest
    private val loading = JSONObject.quote("null")
    private val ready = JSONObject.quote("{\"kind\":\"ready\"}")
    private val failed = JSONObject.quote("{\"kind\":\"error\"}")

    /** Answers each evaluation with [raw] at poll pace until [untilMs] or a terminal result. */
    private fun answerPolls(fixture: Fixture, untilMs: Long, raw: String): Int {
        var answered = 0
        while (SystemClock.now < untilMs && fixture.result.errors.isEmpty() && fixture.result.successes.isEmpty()) {
            Handler.latest.advance(TurnstilePolicy.POLL_INTERVAL_MS)
            val callback = fixture.view.pendingEvaluation ?: continue
            fixture.view.pendingEvaluation = null
            callback(raw)
            answered++
        }
        return answered
    }

    @Test fun providerScriptThatNeverInitializesEndsAtTheStartupBoundNotTheGlobalDeadline() {
        val fixture = instance(commit = true)
        val answered = answerPolls(fixture, TurnstilePolicy.TIMEOUT_MS + 1_000, loading)
        assertEquals(listOf("provider_error"), fixture.result.errors)
        assertEquals(250 + startupBound, SystemClock.now)
        assertEquals((startupBound / 250).toInt(), answered)
        assertTrue(fixture.result.successes.isEmpty())
        assertTrue(fixture.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun startupBoundIsExactAndStartsWhenTheDocumentIsFirstObserved() {
        val fixture = instance()
        repeat(8) { Handler.latest.advance(250) }
        assertEquals(0, fixture.view.evaluationCount)
        fixture.view.url = TurnstilePolicy.BASE_URL
        val observedAt = SystemClock.now + 250
        answerPolls(fixture, observedAt + startupBound - 250, loading)
        Handler.latest.advance(249)
        assertTrue(fixture.result.errors.isEmpty())
        Handler.latest.advance(1)
        assertEquals(listOf("provider_error"), fixture.result.errors)
        assertEquals(observedAt + startupBound, SystemClock.now)
        assertTrue(fixture.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun readinessObservedBeforeTheStartupBoundLiftsItForTheUser() {
        val fixture = instance(commit = true)
        answerPolls(fixture, startupBound - 250, loading)
        answerPolls(fixture, startupBound, ready)
        answerPolls(fixture, 4 * startupBound, ready)
        assertTrue(fixture.result.errors.isEmpty())
        Handler.latest.advance(250)
        finishToken(fixture)
    }

    @Test fun aReadyProviderKeepsTheOriginalGlobalDeadline() {
        val fixture = instance(commit = true)
        answerPolls(fixture, TurnstilePolicy.TIMEOUT_MS - 250, ready)
        Handler.latest.advance(249)
        assertTrue(fixture.result.errors.isEmpty())
        Handler.latest.advance(1)
        assertEquals(listOf("unavailable"), fixture.result.errors)
        assertTrue(fixture.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun scriptFailureReportedByTheDocumentEndsAtThatPollAndIgnoresLateResults() {
        val fixture = instance(commit = true)
        answerPolls(fixture, 1_000, loading)
        Handler.latest.advance(250)
        val callback = fixture.view.pendingEvaluation!!
        callback(failed)
        callback(ready)
        callback(tokenRaw())
        assertEquals(listOf("provider_error"), fixture.result.errors)
        assertEquals(1_250L, SystemClock.now)
        assertTrue(fixture.result.successes.isEmpty())
        assertTrue(fixture.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun lateReadinessOrTokenAfterTheStartupFailureIsIgnored() {
        val fixture = instance(commit = true)
        answerPolls(fixture, startupBound - 250, loading)
        Handler.latest.advance(250)
        val inFlight = fixture.view.pendingEvaluation!!
        Handler.latest.advance(250)
        assertEquals(listOf("provider_error"), fixture.result.errors)
        inFlight(ready)
        inFlight(tokenRaw())
        assertEquals(listOf("provider_error"), fixture.result.errors)
        assertTrue(fixture.result.successes.isEmpty())
        assertTrue(fixture.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun cancellationOrPauseWhileTheProviderLoadsLeavesNoStartupTimer() {
        val cancelled = instance(commit = true)
        answerPolls(cancelled, 10_000, loading)
        val cancel = ResultRecorder()
        cancelled.bridge.onMethodCall(MethodCall("cancel", mapOf("requestId" to id)), cancel)
        assertEquals(listOf("cancelled"), cancelled.result.errors)
        assertEquals(listOf<Any?>(null), cancel.successes)
        assertTrue(cancelled.view.destroyed && Handler.latest.queue.isEmpty())
        val paused = instance(commit = true)
        answerPolls(paused, 10_000, loading)
        paused.bridge.onActivityPaused()
        assertEquals(listOf("interrupted"), paused.result.errors)
        assertTrue(paused.view.destroyed && Handler.latest.queue.isEmpty())
    }

    @Test fun retryAfterAStartupFailureHasItsOwnBound() {
        val fixture = instance(commit = true)
        answerPolls(fixture, TurnstilePolicy.TIMEOUT_MS, loading)
        assertEquals(listOf("provider_error"), fixture.result.errors)
        val retriedAt = SystemClock.now
        val retried = Fixture(fixture.bridge, solve(fixture.bridge), WebView.latest)
        answerPolls(retried, retriedAt + startupBound - 250, loading)
        answerPolls(retried, retriedAt + startupBound, ready)
        answerPolls(retried, retriedAt + 2 * startupBound, ready)
        assertTrue(retried.result.errors.isEmpty())
        Handler.latest.advance(250)
        finishToken(retried)
        assertEquals(listOf("provider_error"), fixture.result.errors)
    }
}
