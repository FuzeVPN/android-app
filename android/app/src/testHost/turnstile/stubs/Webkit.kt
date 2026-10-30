package android.webkit
import android.app.Activity
import android.graphics.Bitmap
import android.net.http.SslError
import android.os.Message
import android.view.ViewGroup
import java.io.InputStream
class ConsoleMessage
class SslErrorHandler { var cancelled = false; fun cancel() { cancelled = true } }
class RenderProcessGoneDetail
class PermissionRequest { fun deny() {} }
class GeolocationPermissions { interface Callback { fun invoke(origin: String?, allow: Boolean, retain: Boolean) } }
class CookieManager {
    fun setAcceptThirdPartyCookies(view: WebView, value: Boolean) {}
    companion object { fun getInstance() = CookieManager() }
}
class WebSettings {
    var javaScriptEnabled = false
    var domStorageEnabled = false
    var allowFileAccess = true
    var allowContentAccess = true
    var allowFileAccessFromFileURLs = true
    var allowUniversalAccessFromFileURLs = true
    var mixedContentMode = 0
    var javaScriptCanOpenWindowsAutomatically = true
    var mediaPlaybackRequiresUserGesture = false
    var saveFormData = true
    var multipleWindows = true
    fun setSupportMultipleWindows(value: Boolean) { multipleWindows = value }
    companion object { const val MIXED_CONTENT_NEVER_ALLOW = 1 }
}
open class WebChromeClient {
    open fun onConsoleMessage(consoleMessage: ConsoleMessage?): Boolean = false
    open fun onCreateWindow(view: WebView?, isDialog: Boolean, isUserGesture: Boolean, resultMsg: Message?): Boolean = false
    open fun onPermissionRequest(request: PermissionRequest?) {}
    open fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback?) {}
}
class Url(private val value: String) { override fun toString() = value }
interface WebResourceRequest { val url: Url; val isForMainFrame: Boolean }
class WebResourceResponse(mime: String, encoding: String, code: Int, reason: String, headers: Map<String,String>, stream: InputStream)
open class WebViewClient {
    open fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean = false
    open fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean = false
    open fun shouldInterceptRequest(view: WebView?, request: WebResourceRequest?): WebResourceResponse? = null
    open fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {}
    open fun onPageCommitVisible(view: WebView?, url: String?) {}
    open fun onPageFinished(view: WebView?, url: String?) {}
    open fun onReceivedSslError(view: WebView?, handler: SslErrorHandler?, error: SslError?) {}
    open fun onRenderProcessGone(view: WebView?, detail: RenderProcessGoneDetail?): Boolean = false
}
class WebView(activity: Activity): ViewGroup() {
    val settings = WebSettings()
    var webChromeClient: WebChromeClient? = null
    var webViewClient = WebViewClient()
    var url: String? = initialUrl
    var destroyed = false
    var evaluationCount = 0
    var pendingEvaluation: ((String?) -> Unit)? = null
    var baseUrl: String? = null
    init { latest = this }
    fun setDownloadListener(callback: (String?,String?,String?,String?,Long) -> Unit) {}
    fun loadDataWithBaseURL(base: String, data: String, mime: String, encoding: String, history: String) {
        baseUrl = base
        // Deliberate documented ordering: start notification precedes commit/getUrl change.
        if (sendPageStarted) webViewClient.onPageStarted(this, base, null)
        if (commitImmediately) url = base
    }
    fun evaluateJavascript(script: String, callback: (String?) -> Unit) {
        evaluationCount++
        pendingEvaluation = callback
    }
    fun stopLoading() {}
    fun removeAllViews() {}
    fun destroy() {
        destroyed = true
        isAttachedToWindow = false
        if (throwOnDestroy) error("synthetic vendor teardown failure")
    }
    companion object {
        lateinit var latest: WebView
        var initialUrl: String? = null
        var sendPageStarted = true
        var commitImmediately = false
        var throwOnDestroy = false
    }
}
