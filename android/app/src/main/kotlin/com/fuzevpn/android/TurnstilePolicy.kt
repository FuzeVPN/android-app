package com.fuzevpn.android

import java.net.URI
import java.util.Locale
import org.json.JSONObject
import org.json.JSONTokener

/** Errors cross the channel as fixed codes, never provider text or token data. */
internal class TurnstileException(code: String) : RuntimeException(TurnstilePolicy.safeError(code)) {
    val code = TurnstilePolicy.safeError(code)
}

internal class TurnstileSelection(val requestId: String, val title: String, val cancelLabel: String) {
    override fun toString() = "TurnstileSelection(redacted: true)"
}

internal sealed interface TurnstilePollResult {
    data object Pending : TurnstilePollResult
    /** The provider script initialized; no outcome yet. */
    data object Ready : TurnstilePollResult
    data object ProviderError : TurnstilePollResult
    data object Expired : TurnstilePollResult
    class Token(val value: String) : TurnstilePollResult {
        override fun toString() = "TurnstileToken(redacted: true)"
    }
}

internal object TurnstilePolicy {
    const val BASE_URL = "https://app.fuzevpn.com/"
    const val SITE_KEY = "0x4AAAAAAE-cdqxPJMG4iuq4"
    const val ACTION = "signup"
    const val SCRIPT_URL = "https://challenges.cloudflare.com/turnstile/v0/api.js"
    const val TIMEOUT_MS = 240_000L
    /** From the first observation of the document until the provider reports readiness. */
    const val STARTUP_TIMEOUT_MS = 30_000L
    const val POLL_INTERVAL_MS = 250L
    const val MAX_TOKEN_CHARS = 2_048
    private const val MAX_POLL_CHARS = 16_384
    private val identifier = Regex("[A-Za-z0-9_-]{16,128}")
    private val safeErrors = setOf("cancelled", "interrupted", "unavailable", "busy",
        "invalid_request", "invalid_response", "provider_error")

    fun safeError(code: Any?): String = (code as? String)?.takeIf { it in safeErrors } ?: "provider_error"

    fun selection(arguments: Any?): TurnstileSelection {
        val values = arguments as? Map<*, *> ?: throw TurnstileException("invalid_request")
        if (values.keys != setOf("requestId", "title", "cancelLabel")) throw TurnstileException("invalid_request")
        return TurnstileSelection(requestId(values["requestId"]), label(values["title"], 120),
            label(values["cancelLabel"], 64))
    }

    fun cancellation(arguments: Any?): String {
        val values = arguments as? Map<*, *> ?: throw TurnstileException("invalid_request")
        if (values.keys != setOf("requestId")) throw TurnstileException("invalid_request")
        return requestId(values["requestId"])
    }

    private fun requestId(value: Any?): String = (value as? String)?.takeIf(identifier::matches)
        ?: throw TurnstileException("invalid_request")

    private fun label(value: Any?, maximum: Int): String = (value as? String)?.takeIf {
        it.isNotBlank() && it.length <= maximum && it.none(Char::isISOControl)
    } ?: throw TurnstileException("invalid_request")

    fun token(value: Any?): String = (value as? String)?.takeIf {
        it.isNotEmpty() && it.length <= MAX_TOKEN_CHARS && it.all { char -> char.code in 33..126 }
    } ?: throw TurnstileException("invalid_response")

    /** evaluateJavascript serializes the string returned by JSON.stringify. */
    fun pollResult(raw: String?): TurnstilePollResult {
        if (raw == null || raw.length > MAX_POLL_CHARS) throw TurnstileException("invalid_response")
        try {
            val outer = parseJson(raw)
            if (outer === JSONObject.NULL) return TurnstilePollResult.Pending
            val encoded = outer as? String ?: throw TurnstileException("invalid_response")
            if (encoded.length > MAX_POLL_CHARS) throw TurnstileException("invalid_response")
            val inner = parseJson(encoded)
            if (inner === JSONObject.NULL) return TurnstilePollResult.Pending
            val value = inner as? JSONObject ?: throw TurnstileException("invalid_response")
            val kind = value.get("kind") as? String ?: throw TurnstileException("invalid_response")
            val fields = value.keys().asSequence().toSet()
            return when (kind) {
                "token" -> {
                    if (fields != setOf("kind", "token")) throw TurnstileException("invalid_response")
                    TurnstilePollResult.Token(token(value.get("token")))
                }
                "error", "expired" -> {
                    if (fields != setOf("kind")) throw TurnstileException("invalid_response")
                    if (kind == "error") TurnstilePollResult.ProviderError else TurnstilePollResult.Expired
                }
                "ready" -> {
                    if (fields != setOf("kind")) throw TurnstileException("invalid_response")
                    TurnstilePollResult.Ready
                }
                else -> throw TurnstileException("invalid_response")
            }
        } catch (error: TurnstileException) {
            throw error
        } catch (_: Exception) {
            throw TurnstileException("invalid_response")
        }
    }

    private fun parseJson(raw: String): Any {
        val parser = JSONTokener(raw)
        val value = parser.nextValue()
        if (parser.nextClean() != '\u0000') throw TurnstileException("invalid_response")
        return value
    }

    /** This checks the embedded document identity, not permission to navigate. */
    fun isEmbeddedDocument(url: String?): Boolean = url == BASE_URL

    /** The initial HTML is local: no network request may replace its main frame. */
    fun allowsResource(url: String?, isMainFrame: Boolean): Boolean {
        if (isMainFrame || url == null || url.length > 4_096) return false
        if (url == "about:blank" || url == "about:srcdoc") return true
        return try {
            val uri = URI(url)
            uri.scheme?.lowercase(Locale.ROOT) == "https" &&
                uri.host?.lowercase(Locale.ROOT) == "challenges.cloudflare.com" &&
                uri.rawUserInfo == null && uri.port in setOf(-1, 443)
        } catch (_: Exception) { false }
    }
}

/** Main-thread operation identity. No token is stored in the gate or ticket. */
internal class TurnstileFlowGate(private val nowMillis: () -> Long) {
    class Ticket internal constructor(val requestId: String, val deadlineMillis: Long) {
        override fun toString() = "TurnstileTicket(redacted: true)"
    }
    private var active: Ticket? = null

    fun reserve(requestId: String): Ticket {
        if (active != null) throw TurnstileException("busy")
        val now = nowMillis()
        val deadline = if (now > Long.MAX_VALUE - TurnstilePolicy.TIMEOUT_MS) Long.MAX_VALUE
            else now + TurnstilePolicy.TIMEOUT_MS
        return Ticket(requestId, deadline).also { active = it }
    }

    fun owns(ticket: Ticket): Boolean = active === ticket
    fun isCurrent(ticket: Ticket): Boolean = owns(ticket) && nowMillis() < ticket.deadlineMillis

    /** Invalidate before any WebView/dialog teardown or result callback. */
    fun finish(ticket: Ticket): Boolean {
        if (!owns(ticket)) return false
        active = null
        return true
    }

    /** A vendor teardown failure must not discard an already terminal result. */
    fun finishWith(ticket: Ticket, cleanup: () -> Unit, deliver: () -> Unit): Boolean {
        if (!finish(ticket)) return false
        try {
            cleanup()
        } catch (_: Exception) {
            // There is deliberately no provider text in the terminal result.
        } finally {
            deliver()
        }
        return true
    }

    fun matching(requestId: String): Ticket? = active?.takeIf { it.requestId == requestId }
}
