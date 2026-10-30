package com.fuzevpn.android

import android.annotation.SuppressLint
import android.app.Activity
import android.app.AlertDialog
import android.graphics.Bitmap
import android.net.http.SslError
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.os.SystemClock
import android.util.Base64
import android.view.View
import android.view.ViewGroup
import android.webkit.ConsoleMessage
import android.webkit.CookieManager
import android.webkit.GeolocationPermissions
import android.webkit.PermissionRequest
import android.webkit.RenderProcessGoneDetail
import android.webkit.SslErrorHandler
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayInputStream
import java.security.SecureRandom

/** Activity-owned challenge. It receives no account, bearer or continuation ticket. */
internal class NativeTurnstileBridge(
    private val activity: Activity,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, "com.fuzevpn/security_challenge")
    private val main = Handler(Looper.getMainLooper())
    private val gate = TurnstileFlowGate(SystemClock::elapsedRealtime)
    private var operation: Operation? = null
    private var resumed = false
    private var closed = false

    private inner class Operation(val ticket: TurnstileFlowGate.Ticket, val result: MethodChannel.Result) {
        var webView: WebView? = null
        var dialog: AlertDialog? = null
        var pageStarted = false
        var initialDocumentUrl: String? = null
        var embeddedDocumentObserved = false
        var providerReady = false
        val poll = Runnable { poll(this) }
        val timeout = Runnable { finishError(this, "unavailable") }
        // A provider script that fails silently or never initializes must not hold the dialog.
        val startup = Runnable { if (!providerReady) finishError(this, "provider_error") }
    }

    init { channel.setMethodCallHandler(this) }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) = onMain {
        if (closed) {
            result.error("unavailable", null, null)
            return@onMain
        }
        try {
            when (call.method) {
                "solve" -> solve(TurnstilePolicy.selection(call.arguments), result)
                "cancel" -> {
                    val requestId = TurnstilePolicy.cancellation(call.arguments)
                    operation?.takeIf { it.ticket.requestId == requestId }?.let { finishError(it, "cancelled") }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        } catch (error: TurnstileException) {
            result.error(error.code, null, null)
        } catch (_: Exception) {
            result.error("provider_error", null, null)
        }
    }

    fun onActivityResumed() = onMain { if (!closed) resumed = true }

    fun onActivityPaused() = onMain {
        resumed = false
        operation?.let { finishError(it, "interrupted") }
    }

    fun close() = onMain {
        if (closed) return@onMain
        closed = true
        resumed = false
        operation?.let { finishError(it, "interrupted") }
        channel.setMethodCallHandler(null)
    }

    private fun solve(selection: TurnstileSelection, result: MethodChannel.Result) {
        if (!resumed || activity.isFinishing || activity.isDestroyed) throw TurnstileException("interrupted")
        val current = Operation(gate.reserve(selection.requestId), result)
        operation = current
        try {
            val webView = WebView(activity)
            current.webView = webView
            current.initialDocumentUrl = webView.url
            configureWebView(current, webView)
            val density = activity.resources.displayMetrics.density
            val content = FrameLayout(activity).apply {
                addView(webView, FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, (300 * density).toInt()))
            }
            val dialog = AlertDialog.Builder(activity)
                .setTitle(selection.title)
                .setView(content)
                .setNegativeButton(selection.cancelLabel) { _, _ -> finishError(current, "cancelled") }
                .create()
            current.dialog = dialog
            dialog.setCanceledOnTouchOutside(false)
            dialog.setOnCancelListener { finishError(current, "cancelled") }
            dialog.setOnDismissListener { finishError(current, "cancelled") }
            dialog.show()
            val nonce = ByteArray(24).also { SecureRandom().nextBytes(it) }.let {
                Base64.encodeToString(it, Base64.NO_WRAP or Base64.URL_SAFE or Base64.NO_PADDING)
            }
            webView.loadDataWithBaseURL(TurnstilePolicy.BASE_URL, TurnstileDocument.html(nonce),
                "text/html", "UTF-8", TurnstilePolicy.BASE_URL)
            main.postDelayed(current.timeout, (current.ticket.deadlineMillis - SystemClock.elapsedRealtime()).coerceAtLeast(0L))
            main.postDelayed(current.poll, TurnstilePolicy.POLL_INTERVAL_MS)
        } catch (_: Exception) {
            finishError(current, "unavailable")
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    @Suppress("DEPRECATION")
    private fun configureWebView(current: Operation, webView: WebView) {
        webView.importantForAutofill = View.IMPORTANT_FOR_AUTOFILL_NO_EXCLUDE_DESCENDANTS
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            allowFileAccess = false
            allowContentAccess = false
            allowFileAccessFromFileURLs = false
            allowUniversalAccessFromFileURLs = false
            mixedContentMode = WebSettings.MIXED_CONTENT_NEVER_ALLOW
            javaScriptCanOpenWindowsAutomatically = false
            setSupportMultipleWindows(false)
            mediaPlaybackRequiresUserGesture = true
            saveFormData = false
        }
        // Per-view compatibility with the documented mobile widget. No app
        // credentials/cookies are injected, and UA/TLS defaults remain intact.
        CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true)
        webView.setDownloadListener { _, _, _, _, _ -> }
        webView.webChromeClient = object : WebChromeClient() {
            override fun onConsoleMessage(consoleMessage: ConsoleMessage?): Boolean = true
            override fun onCreateWindow(view: WebView?, isDialog: Boolean, isUserGesture: Boolean, resultMsg: Message?): Boolean = false
            override fun onPermissionRequest(request: PermissionRequest?) { request?.deny() }
            override fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback?) {
                callback?.invoke(origin, false, false)
            }
        }
        webView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                // Initial HTML is loaded by the app. A page must never replace
                // that document, even with a URL on the same trusted origin.
                if (request == null || request.isForMainFrame) return true
                return !TurnstilePolicy.allowsResource(request.url.toString(), false)
            }

            @Deprecated("Legacy WebView callback")
            override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean = true

            override fun shouldInterceptRequest(view: WebView?, request: WebResourceRequest?): WebResourceResponse? {
                return if (request != null && TurnstilePolicy.allowsResource(request.url.toString(), request.isForMainFrame)) null
                else WebResourceResponse("text/plain", "UTF-8", 403, "Forbidden", emptyMap(), ByteArrayInputStream(ByteArray(0)))
            }

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                if (!owns(current)) return
                if (current.pageStarted || !TurnstilePolicy.isEmbeddedDocument(url)) {
                    finishError(current, "invalid_response")
                } else current.pageStarted = true
            }

            override fun onPageCommitVisible(view: WebView?, url: String?) {
                if (!owns(current)) return
                if (!current.pageStarted || !TurnstilePolicy.isEmbeddedDocument(url)) {
                    finishError(current, "invalid_response")
                }
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                if (!owns(current)) return
                if (!current.pageStarted || !TurnstilePolicy.isEmbeddedDocument(url)) {
                    finishError(current, "invalid_response")
                }
            }

            override fun onReceivedSslError(view: WebView?, handler: SslErrorHandler?, error: SslError?) {
                handler?.cancel()
                finishError(current, "unavailable")
            }

            override fun onRenderProcessGone(view: WebView?, detail: RenderProcessGoneDetail?): Boolean {
                finishError(current, "unavailable")
                return true
            }
        }
    }

    private fun poll(current: Operation) {
        if (!owns(current)) return
        if (!gate.isCurrent(current.ticket)) {
            finishError(current, "unavailable")
            return
        }
        val webView = current.webView
        if (!resumed || webView == null || !webView.isAttachedToWindow) {
            finishError(current, "interrupted")
            return
        }
        val documentUrl = webView.url
        val isEmbeddedDocument = TurnstilePolicy.isEmbeddedDocument(documentUrl)
        // onPageStarted announces a load, while getUrl may still describe its
        // predecessor until commit. Waiting here never authorizes navigation
        // or evaluates that previous document, and never renews the deadline.
        if (!current.embeddedDocumentObserved &&
            ((!current.pageStarted && isEmbeddedDocument) ||
                (!isEmbeddedDocument && (documentUrl == null || documentUrl == "about:blank" ||
                    documentUrl == current.initialDocumentUrl)))) {
            main.postDelayed(current.poll, TurnstilePolicy.POLL_INTERVAL_MS)
            return
        }
        if (!current.pageStarted || !isEmbeddedDocument) {
            finishError(current, "invalid_response")
            return
        }
        if (!current.embeddedDocumentObserved) {
            current.embeddedDocumentObserved = true
            main.postDelayed(current.startup, TurnstilePolicy.STARTUP_TIMEOUT_MS)
        }
        try {
            webView.evaluateJavascript(TurnstileDocument.takeResultScript) { raw ->
                if (!owns(current)) return@evaluateJavascript
                if (!gate.isCurrent(current.ticket) || !resumed) {
                    finishError(current, "interrupted")
                    return@evaluateJavascript
                }
                if (!TurnstilePolicy.isEmbeddedDocument(webView.url)) {
                    finishError(current, "invalid_response")
                    return@evaluateJavascript
                }
                try {
                    when (val response = TurnstilePolicy.pollResult(raw)) {
                        TurnstilePollResult.Pending -> main.postDelayed(current.poll, TurnstilePolicy.POLL_INTERVAL_MS)
                        TurnstilePollResult.Ready -> {
                            current.providerReady = true
                            main.removeCallbacks(current.startup)
                            main.postDelayed(current.poll, TurnstilePolicy.POLL_INTERVAL_MS)
                        }
                        TurnstilePollResult.ProviderError -> finishError(current, "provider_error")
                        TurnstilePollResult.Expired -> finishError(current, "unavailable")
                        is TurnstilePollResult.Token -> finishSuccess(current, response.value)
                    }
                } catch (error: TurnstileException) {
                    finishError(current, error.code)
                }
            }
        } catch (_: Exception) { finishError(current, "unavailable") }
    }

    private fun owns(current: Operation): Boolean = operation === current && gate.owns(current.ticket)

    private fun finishSuccess(current: Operation, token: String) {
        if (!owns(current) || !gate.isCurrent(current.ticket)) return
        gate.finishWith(current.ticket, cleanup = {
            operation = null
            dispose(current)
        }, deliver = {
            current.result.success(mapOf("requestId" to current.ticket.requestId, "token" to token))
        })
    }

    private fun finishError(current: Operation, code: String) {
        if (!owns(current)) return
        gate.finishWith(current.ticket, cleanup = {
            operation = null
            dispose(current)
        }, deliver = { current.result.error(TurnstilePolicy.safeError(code), null, null) })
    }

    private fun dispose(current: Operation) {
        main.removeCallbacks(current.poll)
        main.removeCallbacks(current.timeout)
        main.removeCallbacks(current.startup)
        val dialog = current.dialog
        current.dialog = null
        runCatching { dialog?.setOnCancelListener(null); dialog?.setOnDismissListener(null) }
        val webView = current.webView
        current.webView = null
        runCatching { (webView?.parent as? ViewGroup)?.removeView(webView) }
        runCatching { dialog?.dismiss() }
        webView?.let { view ->
            runCatching { view.stopLoading() }
            runCatching { view.webChromeClient = null; view.webViewClient = WebViewClient() }
            runCatching { view.settings.javaScriptEnabled = false }
            runCatching { view.removeAllViews(); view.destroy() }
        }
    }

    private inline fun onMain(crossinline action: () -> Unit) {
        if (Looper.myLooper() == Looper.getMainLooper()) action() else main.post { action() }
    }
}
