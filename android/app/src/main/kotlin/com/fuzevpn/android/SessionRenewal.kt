package com.fuzevpn.android

import java.nio.ByteBuffer
import java.nio.charset.CodingErrorAction
import java.nio.charset.StandardCharsets
import java.security.SecureRandom
import java.time.Duration
import java.time.Instant
import java.time.OffsetDateTime
import java.time.ZoneOffset
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit
import java.util.Base64
import java.util.Locale
import kotlinx.coroutines.delay
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import org.json.JSONObject

/** Kind of an account session, as the channel names it. */
internal enum class SessionKind(val wireValue: String) {
    RENEWABLE("renewable"),
    CLASSIC("classic"),
}

/** A channel answer: the kind of session and its stored access payload (storageReadSession's format). */
internal data class SessionAccess(val kind: SessionKind, val payload: String) {
    fun toMap(): Map<String, Any?> = mapOf("state" to kind.wireValue, "payload" to payload)
}

/**
 * A renewal that produced no usable access, with its channel error code. Only an unavailable
 * renewal carries [retryAfterSeconds], when the server's Retry-After or the backoff names it.
 */
internal class SessionRenewalException(val code: String, val retryAfterSeconds: Long? = null) : Exception(code) {
    companion object {
        const val UNAUTHORIZED = "session_unauthorized"
        const val UNAVAILABLE = "session_renewal_unavailable"
        const val INVALID = "session_renewal_invalid"
        const val REFRESH_EXPIRED = "session_refresh_expired"
    }
}

/** No HTTP status was received: no network, a timeout, a lost or unreadable answer. */
internal class SessionTransportFailure : Exception("session_transport_failed")

/** One HTTP exchange. The Android transport binds it to a physical network when asked. */
internal interface SessionRenewalTransport {
    /**
     * Sends [request] once. Throws [SessionTransportFailure] when no status was received, and
     * VpnNativeException("session_operation_cancelled") as soon as [isCurrent] turns false.
     */
    suspend fun send(
        request: SessionRenewalContract.Request,
        physical: Boolean,
        isCurrent: () -> Boolean,
    ): SessionRenewalContract.Response
}

/** The account slots of one session: its access, its renewal grant and its pending request. */
internal data class SessionRenewalSlots(
    val access: SecureStorageSlot,
    val refresh: SecureStorageSlot,
    val pending: SecureStorageSlot,
)

/** A rotation for the owner to commit in one write, with the system-resume record that follows the access. */
internal class SessionRotation(
    val accountId: String,
    val slots: SessionRenewalSlots,
    val previousAccess: String,
    val access: String,
    val refresh: String,
)

/** What one renewal call may do, provided by its caller. */
internal interface SessionRenewalHost {
    /** Runs [block] under the tunnel mutex: taken for a channel call, already held otherwise. */
    suspend fun <T> locked(block: () -> T): T
    /** Throws when the account session this call belongs to is no longer current. */
    fun checkCurrent()
    /** Inside [locked]: replaces the pair, removes the pending request and moves the resume record, in one commit. */
    fun commit(rotation: SessionRotation)
    /** The request leaves through a physical network (a TUN may be held). */
    val physical: Boolean
    fun isCurrent(): Boolean
}

/** The stored access payload `{access_token, expires_at}`. */
internal data class AccessGrant(val token: String, val expiresAt: Instant) {
    /** Exactly as Dart writes it (jsonEncode, DateTime.toIso8601String in UTC): a rewrite by Dart is no change. */
    fun encode(): String = dartJson("access_token" to token, "expires_at" to dartTimestamp(expiresAt))

    companion object {
        fun decode(payload: String): AccessGrant? {
            val session = validateSystemVpnSessionPayload(payload, Instant.MIN) ?: return null
            val token = runCatching { JSONObject(payload).get("access_token") as String }.getOrNull() ?: return null
            return AccessGrant(token, session.expiresAt)
        }
    }
}

/** The native-only renewal grant `{refresh_token, refresh_expires_at}` of a converted session. */
internal data class RefreshGrant(val token: String, val expiresAt: Instant) {
    fun encode(): String = dartJson("refresh_token" to token, "refresh_expires_at" to dartTimestamp(expiresAt))

    companion object {
        fun decode(raw: String): RefreshGrant? = runCatching {
            val json = JSONObject(raw)
            require(json.fieldNames() == setOf("refresh_token", "refresh_expires_at"))
            val token = json.get("refresh_token") as String
            require(SessionRenewalContract.isStoredToken(token))
            RefreshGrant(token, Instant.parse(json.get("refresh_expires_at") as String))
        }.getOrNull()
    }
}

/** A request written before it is sent, and sent again identically until it is answered. */
internal data class PendingRenewal(val route: String, val presentedToken: String, val requestId: String) {
    fun encode(): String = dartJson("route" to route, "presented_token" to presentedToken, "request_id" to requestId)

    /** It names the credential this session still holds: otherwise it belongs to a session that is gone. */
    fun matches(access: AccessGrant, refresh: RefreshGrant?): Boolean = when (route) {
        SessionRenewalContract.UPGRADE -> refresh == null && presentedToken == access.token
        else -> refresh != null && presentedToken == refresh.token
    }

    companion object {
        fun decode(raw: String): PendingRenewal? = runCatching {
            val json = JSONObject(raw)
            require(json.fieldNames() == setOf("route", "presented_token", "request_id"))
            val route = json.get("route") as String
            require(route == SessionRenewalContract.UPGRADE || route == SessionRenewalContract.REFRESH)
            val token = json.get("presented_token") as String
            val requestId = json.get("request_id") as String
            require(SessionRenewalContract.isStoredToken(token) && SessionRenewalContract.isRequestId(requestId))
            PendingRenewal(route, token, requestId)
        }.getOrNull()
    }
}

/** A returned pair, with the lifetimes the server stated for it (see [SessionRenewalContract.pair]). */
internal class RenewedPair(
    val access: AccessGrant,
    val refresh: RefreshGrant,
    val accessLifetime: Duration,
    val refreshLifetime: Duration,
)

/**
 * The session-renewal routes of the API (docs/session-renewal-api.md of the control plane).
 * Pure: it builds requests and reads answers; values are never logged.
 */
internal object SessionRenewalContract {
    const val UPGRADE = "upgrade"
    const val REFRESH = "refresh"
    const val MAX_RESPONSE_BYTES = 16 * 1024
    /** Renew when the access expires within this margin. */
    val FRESHNESS_MARGIN: Duration = Duration.ofMinutes(5)
    private const val REQUEST_ID_BYTES = 32
    private const val MAX_TOKEN_CHARS = 4_096
    private const val ROTATION_TIMEOUT_MS = 20_000L
    private const val LOGOUT_TIMEOUT_MS = 10_000L
    private const val MAX_RETRY_AFTER_SECONDS = 24 * 60 * 60L
    private val MAX_LIFETIME: Duration = Duration.ofDays(3_650)
    // Tokens the API issues are printable ASCII, which Dart's jsonEncode writes as they are.
    private val ISSUED_TOKEN = Regex("[!-~]{1,$MAX_TOKEN_CHARS}")
    private val REQUEST_ID = Regex("[A-Za-z0-9_-]{43}")

    /** [headers] carries a token: a request is never kept or logged. */
    class Request(val route: String, val url: String, val headers: Map<String, String>, val body: ByteArray,
        val timeoutMillis: Long)

    /** [date] is the response's Date header: the server's own clock. */
    class Response(val status: Int, val cacheControl: String?, val retryAfter: String?, val body: ByteArray,
        val date: String? = null)

    /** 32 bytes of a cryptographic generator, canonical base64url without padding (43 characters). */
    fun newRequestId(random: SecureRandom): String {
        val bytes = ByteArray(REQUEST_ID_BYTES)
        random.nextBytes(bytes)
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes)
    }

    fun isRequestId(value: String): Boolean = REQUEST_ID.matches(value) && runCatching {
        val bytes = Base64.getUrlDecoder().decode(value)
        bytes.size == REQUEST_ID_BYTES && Base64.getUrlEncoder().withoutPadding().encodeToString(bytes) == value
    }.getOrDefault(false)

    /** As validateSystemVpnSessionPayload accepts an access token. */
    fun isStoredToken(value: String): Boolean =
        value.isNotBlank() && value.length <= MAX_TOKEN_CHARS && value.none(Char::isISOControl)

    fun rotation(baseUrl: String, pending: PendingRenewal): Request = Request(
        route = pending.route,
        url = "${baseUrl}v1/auth/session/${pending.route}",
        headers = mapOf(
            "accept" to "application/json",
            "cache-control" to "no-store",
            "authorization" to "Bearer ${pending.presentedToken}",
            "content-type" to "application/json; charset=utf-8",
        ),
        body = dartJson("request_id" to pending.requestId).toByteArray(StandardCharsets.UTF_8),
        timeoutMillis = ROTATION_TIMEOUT_MS,
    )

    /** Without a body and without a browser-context header, as the contract asks. */
    fun logout(baseUrl: String, refreshToken: String): Request = Request(
        route = "logout",
        url = "${baseUrl}v1/auth/logout",
        headers = mapOf(
            "accept" to "application/json",
            "cache-control" to "no-store",
            "authorization" to "Bearer $refreshToken",
        ),
        body = ByteArray(0),
        timeoutMillis = LOGOUT_TIMEOUT_MS,
    )

    /**
     * The pair of a 200 that forbids caching; null for anything else. Its lifetimes are the server's:
     * each expiry minus the response's Date, or minus [receivedAt] (the device clock) without one.
     */
    fun pair(response: Response, receivedAt: Instant): RenewedPair? = runCatching {
        require(response.status == 200)
        require(response.cacheControl?.lowercase(Locale.ROOT)?.split(',')?.any { it.trim() == "no-store" } == true)
        val json = JSONObject(utf8(response.body))
        val issuedAt = serverDate(response.date) ?: receivedAt
        val access = AccessGrant(json.issuedToken("access_token"), json.issuedInstant("expires_at"))
        val refresh = RefreshGrant(json.issuedToken("refresh_token"), json.issuedInstant("refresh_expires_at"))
        RenewedPair(access, refresh, lifetime(issuedAt, access.expiresAt), lifetime(issuedAt, refresh.expiresAt)).also {
            // Both values must have the stored form Dart and this class read back.
            dartTimestamp(it.access.expiresAt)
            dartTimestamp(it.refresh.expiresAt)
        }
    }.getOrNull()

    /** The API's error code ("error"), only when the contract names it. */
    fun errorCode(response: Response): String? = runCatching {
        JSONObject(utf8(response.body)).get("error") as String
    }.getOrNull()?.takeIf { it in setOf("session_upgrade_conflict", "session_transition",
        "invalid_session_request_id", "invalid_json", "unauthorized") }

    /** An HTTP date (RFC 1123), as the Date header carries it. */
    fun serverDate(value: String?): Instant? = value?.trim()?.takeIf { it.isNotEmpty() }?.let {
        runCatching { ZonedDateTime.parse(it, DateTimeFormatter.RFC_1123_DATE_TIME).toInstant() }.getOrNull()
    }

    // Bounded, so that a monotonic deadline computed from it cannot overflow.
    private fun lifetime(from: Instant, to: Instant): Duration =
        Duration.between(from, to).coerceIn(MAX_LIFETIME.negated(), MAX_LIFETIME)

    /** Delta-seconds or an HTTP date; bounded to one day. */
    fun retryAfterSeconds(value: String?, now: Instant): Long? {
        val text = value?.trim()?.takeIf { it.isNotEmpty() } ?: return null
        val seconds = text.toLongOrNull() ?: runCatching {
            Duration.between(now, ZonedDateTime.parse(text, DateTimeFormatter.RFC_1123_DATE_TIME).toInstant()).seconds
        }.getOrNull() ?: return null
        return seconds.coerceIn(0L, MAX_RETRY_AFTER_SECONDS)
    }

    private fun JSONObject.issuedToken(name: String): String =
        (get(name) as String).also { require(ISSUED_TOKEN.matches(it)) }

    private fun JSONObject.issuedInstant(name: String): Instant =
        OffsetDateTime.parse(get(name) as String).toInstant().truncatedTo(ChronoUnit.MICROS)

    private fun utf8(body: ByteArray): String = StandardCharsets.UTF_8.newDecoder()
        .onMalformedInput(CodingErrorAction.REPORT)
        .onUnmappableCharacter(CodingErrorAction.REPORT)
        .decode(ByteBuffer.wrap(body)).toString()
}

/**
 * Sole owner of the upgrade, refresh and logout of renewable account sessions, in this process.
 *
 * Lock order: R (this class's [mutex]) before T (the bridge's tunnel mutex). An upgrade or a
 * refresh requested by Flutter waits for R, then takes T only around storage reads and writes
 * ([SessionRenewalHost.locked]), never across the HTTP exchange. A path that already holds T only
 * tries R ([accessHoldingTunnel]), and a logout never takes it: no wait can close a cycle.
 *
 * A request is written to the pending slot before it leaves, and sent again identically (same
 * credential, same request id) after a timeout, a lost answer, a server-side refusal to retry or
 * a process restart, until it is answered. The new pair and the removal of that request are
 * committed together. Only fixed texts, routes and HTTP statuses reach [log].
 *
 * Expiry decisions do not trust the device clock more than needed: after a rotation, this process
 * keeps the lifetimes the server stated and the monotonic instant they were received, and judges
 * that pair by them. Only a pair this process did not receive is judged on the wall clock.
 */
internal class SessionRenewal(
    private val transport: SessionRenewalTransport,
    private val baseUrl: String,
    private val slots: (accountId: String) -> SessionRenewalSlots,
    private val read: (SecureStorageSlot) -> String?,
    private val write: (SecureStorageSlot, String) -> Unit,
    private val delete: (SecureStorageSlot) -> Unit,
    /** Runs a logout after its channel call has answered; it must run even if never resumed. */
    private val background: (suspend () -> Unit) -> Unit,
    private val log: (String) -> Unit,
    private val now: () -> Instant = { Instant.now() },
    private val random: SecureRandom = SecureRandom(),
    private val pause: suspend (Long) -> Unit = { delay(it) },
    private val monotonicNanos: () -> Long = System::nanoTime,
) {
    private val mutex = Mutex()
    /** Per account, under [mutex]: no request leaves before [RetryGate.notBefore] after a server-side refusal. */
    private val gates = HashMap<String, RetryGate>()
    /** Per account, the last pair this process received, with its deadlines on [monotonicNanos]. */
    private val clocks = HashMap<String, RotationClock>()

    private class RetryGate(val notBefore: Instant, val failures: Int)

    private class RotationClock(val accessToken: String, val refreshToken: String, val accessDeadline: Long,
        val refreshDeadline: Long)

    private enum class Intent { UPGRADE, FRESH }

    private sealed interface Plan {
        class Done(val access: SessionAccess) : Plan
        /** [created]: written by this call, never sent yet; otherwise read back (a resend). */
        class Send(val pending: PendingRenewal, val pendingRaw: String, val created: Boolean) : Plan
    }

    private sealed interface Outcome {
        /** [replayed]: the answer to a resent request, which may restore an older pair. */
        class Renewed(val pair: RenewedPair, val replayed: Boolean, val receivedAt: Long) : Outcome
        /** 404 to the first send of a new upgrade: the server does not know the contract yet. */
        object Unknown : Outcome
        /** 409 session_upgrade_conflict. */
        object Conflict : Outcome
        object Unauthorized : Outcome
        object Invalid : Outcome
        /** Kept pending: no answer, 409 session_transition, 429, 5xx or an unusable 200. */
        class Transient(val status: Int?, val retryAfterSeconds: Long?) : Outcome
        class Unavailable(val retryAfterSeconds: Long?) : Outcome
    }

    /** Resumes a pending request first; converts a classic session; a converted one is returned as it is. */
    suspend fun upgrade(accountId: String, host: SessionRenewalHost): SessionAccess =
        mutex.withLock { renew(accountId, host, Intent.UPGRADE, CHANNEL_ATTEMPTS) }

    /**
     * Resumes a pending request first; renews a converted session whose access expires within the
     * margin, or whatever its expiry when [force] (Dart received a 401: the server's dates prevail).
     */
    suspend fun ensureFresh(accountId: String, host: SessionRenewalHost, force: Boolean = false): SessionAccess =
        mutex.withLock { renew(accountId, host, Intent.FRESH, CHANNEL_ATTEMPTS, force) }

    /**
     * Under the tunnel mutex ([host] runs its blocks in place): the access payload to present to an
     * API route without Flutter. Never waits for R: while another renewal holds it, and when a
     * renewal attempted here stays unavailable, the stored access is kept while it is valid.
     * Throws [SessionRenewalException] (UNAVAILABLE when that access has expired).
     */
    suspend fun accessHoldingTunnel(accountId: String, host: SessionRenewalHost): String {
        if (!mutex.tryLock()) {
            log("Session renewal: busy elsewhere, stored access kept")
            return storedAccessWhileValid(accountId)
        }
        try {
            return renew(accountId, host, Intent.FRESH, attempts = 1).payload
        } catch (refused: SessionRenewalException) {
            if (refused.code != SessionRenewalException.UNAVAILABLE) throw refused
            return storedAccessWhileValid(accountId)
        } finally {
            mutex.unlock()
        }
    }

    /**
     * Never waits for R: a rotation in progress may hold it longer than Dart waits before it erases
     * the session. The stored refresh token is sent to the logout route after this call has answered.
     * During a rotation it may be the previous generation, which the server also revokes.
     */
    suspend fun logout(accountId: String, host: SessionRenewalHost): SessionKind {
        val raw = host.locked { read(slots(accountId).refresh) } ?: return SessionKind.CLASSIC
        val refresh = RefreshGrant.decode(raw) ?: run {
            // Unusable: the access logout Dart keeps for a classic session is the only one left.
            log("Session renewal: unreadable renewal grant, classic logout")
            return SessionKind.CLASSIC
        }
        val request = SessionRenewalContract.logout(baseUrl, refresh.token)
        val physical = host.physical
        background {
            try {
                log("Session renewal: logout answered ${transport.send(request, physical) { true }.status}")
            } catch (_: Exception) {
                log("Session renewal: logout not answered")
            }
        }
        return SessionKind.RENEWABLE
    }

    private suspend fun renew(accountId: String, host: SessionRenewalHost, intent: Intent, attempts: Int,
        force: Boolean = false): SessionAccess {
        val slots = slots(accountId)
        var followedUp = false
        var restarted = false
        while (true) {
            val plan = host.locked { host.checkCurrent(); plan(accountId, slots, intent, refreshNow = force || followedUp,
                serverDecides = force && !followedUp) }
            val send = when (plan) {
                is Plan.Done -> return plan.access
                is Plan.Send -> plan
            }
            val route = send.pending.route
            when (val outcome = exchange(accountId, send, host, attempts)) {
                is Outcome.Renewed -> {
                    val access = host.locked { host.checkCurrent(); commitIfCurrent(accountId, slots, send, outcome.pair, host) }
                    if (access == null) {
                        // The stored session moved on meanwhile (a new session, an end): never written over.
                        log("Session renewal: $route answer discarded, the session changed")
                        if (restarted) throw VpnNativeException(CANCELLED)
                        restarted = true
                        continue
                    }
                    log("Session renewal: $route renewed")
                    remember(accountId, outcome.pair, outcome.receivedAt)
                    if (outcome.replayed && !followedUp && outcome.pair.accessLifetime <= Duration.ZERO) {
                        // A resent request restores its pair with its original expiry, which the server
                        // says is already over: renew once more at once (never after a first send).
                        followedUp = true
                        continue
                    }
                    return SessionAccess(SessionKind.RENEWABLE, access)
                }
                Outcome.Unknown -> {
                    log("Session renewal: upgrade unknown to the server, session kept classic")
                    val access = host.locked { host.checkCurrent(); dropPending(slots, send); read(slots.access) }
                        ?: throw VpnNativeException(CANCELLED)
                    return SessionAccess(SessionKind.CLASSIC, access)
                }
                Outcome.Conflict -> {
                    log("Session renewal: upgrade already consumed, storage read again")
                    return host.locked {
                        host.checkCurrent()
                        dropPending(slots, send)
                        val access = read(slots.access) ?: throw VpnNativeException(CANCELLED)
                        SessionAccess(if (read(slots.refresh) != null) SessionKind.RENEWABLE else SessionKind.CLASSIC, access)
                    }
                }
                Outcome.Unauthorized -> {
                    val changed = host.locked {
                        host.checkCurrent()
                        stateChanged(slots, send).also { if (!it) dropPending(slots, send) }
                    }
                    if (changed && !restarted) {
                        log("Session renewal: $route refused, storage changed meanwhile")
                        restarted = true
                        continue
                    }
                    log("Session renewal: $route refused with 401")
                    throw SessionRenewalException(SessionRenewalException.UNAUTHORIZED)
                }
                Outcome.Invalid -> {
                    // A defect of this client: the same request would be refused again.
                    log("Session renewal: $route refused as invalid (400)")
                    host.locked { host.checkCurrent(); dropPending(slots, send) }
                    throw SessionRenewalException(SessionRenewalException.INVALID)
                }
                is Outcome.Unavailable -> throw SessionRenewalException(SessionRenewalException.UNAVAILABLE,
                    outcome.retryAfterSeconds)
                is Outcome.Transient -> error("transient outcome escaped exchange")
            }
        }
    }

    /** Under T: what to do with the stored session; a new request is written before it is returned. */
    private fun plan(accountId: String, slots: SessionRenewalSlots, intent: Intent, refreshNow: Boolean,
        serverDecides: Boolean): Plan {
        val accessRaw = read(slots.access) ?: throw VpnNativeException(CANCELLED)
        val access = AccessGrant.decode(accessRaw) ?: throw SessionRenewalException(SessionRenewalException.INVALID)
        val refresh = read(slots.refresh)?.let {
            RefreshGrant.decode(it) ?: throw SessionRenewalException(SessionRenewalException.INVALID)
        }
        val pendingRaw = read(slots.pending)
        if (pendingRaw != null) {
            // An unreadable request cannot be repeated identically, and a new one could be a replay.
            val pending = PendingRenewal.decode(pendingRaw) ?: throw SessionRenewalException(SessionRenewalException.INVALID)
            if (pending.matches(access, refresh)) {
                if (pending.route == SessionRenewalContract.REFRESH && !serverDecides) requireRenewable(accountId, refresh!!)
                log("Session renewal: resuming the pending ${pending.route}")
                return Plan.Send(pending, pendingRaw, created = false)
            }
            // It presents a credential this session no longer holds: never sent again.
            delete(slots.pending)
            log("Session renewal: stale pending request dropped")
        }
        if (refresh == null) {
            if (intent != Intent.UPGRADE) return Plan.Done(SessionAccess(SessionKind.CLASSIC, accessRaw))
            return send(slots, PendingRenewal(SessionRenewalContract.UPGRADE, access.token, newRequestId()))
        }
        if (intent == Intent.UPGRADE && !refreshNow) return Plan.Done(SessionAccess(SessionKind.RENEWABLE, accessRaw))
        if (!serverDecides) requireRenewable(accountId, refresh)
        if (!refreshNow && !expiresWithin(accountId, access, SessionRenewalContract.FRESHNESS_MARGIN)) {
            return Plan.Done(SessionAccess(SessionKind.RENEWABLE, accessRaw))
        }
        return send(slots, PendingRenewal(SessionRenewalContract.REFRESH, refresh.token, newRequestId()))
    }

    private fun send(slots: SessionRenewalSlots, pending: PendingRenewal): Plan.Send {
        val raw = pending.encode()
        write(slots.pending, raw)
        return Plan.Send(pending, raw, created = true)
    }

    private fun requireRenewable(accountId: String, refresh: RefreshGrant) {
        val clock = clock(accountId)?.takeIf { it.refreshToken == refresh.token }
        val over = if (clock != null) monotonicNanos() - clock.refreshDeadline >= 0 else !refresh.expiresAt.isAfter(now())
        if (over) throw SessionRenewalException(SessionRenewalException.REFRESH_EXPIRED)
    }

    /** [access] expires within [margin]: on the lifetime the server stated when this process received it. */
    private fun expiresWithin(accountId: String, access: AccessGrant, margin: Duration): Boolean {
        val clock = clock(accountId)?.takeIf { it.accessToken == access.token }
            ?: return !access.expiresAt.isAfter(now().plus(margin))
        return monotonicNanos() - clock.accessDeadline >= -margin.toNanos()
    }

    private fun clock(accountId: String): RotationClock? = synchronized(clocks) { clocks[accountId] }

    private fun remember(accountId: String, pair: RenewedPair, receivedAt: Long) = synchronized(clocks) {
        clocks[accountId] = RotationClock(pair.access.token, pair.refresh.token,
            receivedAt + pair.accessLifetime.toNanos(), receivedAt + pair.refreshLifetime.toNanos())
    }

    private fun newRequestId(): String = SessionRenewalContract.newRequestId(random)

    /** Under T: commits only while the request sent is still this session's pending one. */
    private fun commitIfCurrent(accountId: String, slots: SessionRenewalSlots, send: Plan.Send, pair: RenewedPair,
        host: SessionRenewalHost): String? {
        if (stateChanged(slots, send)) return null
        val previous = read(slots.access) ?: return null
        val access = pair.access.encode()
        host.commit(SessionRotation(accountId, slots, previous, access, pair.refresh.encode()))
        return access
    }

    private fun stateChanged(slots: SessionRenewalSlots, send: Plan.Send): Boolean {
        if (read(slots.pending) != send.pendingRaw) return true
        val access = read(slots.access)?.let(AccessGrant::decode) ?: return true
        val refresh = read(slots.refresh)?.let { RefreshGrant.decode(it) ?: return true }
        return !send.pending.matches(access, refresh)
    }

    private fun dropPending(slots: SessionRenewalSlots, send: Plan.Send) {
        if (read(slots.pending) == send.pendingRaw) delete(slots.pending)
    }

    private fun storedAccessWhileValid(accountId: String): String {
        val raw = read(slots(accountId).access) ?: throw VpnNativeException("system_vpn_resume_session_invalid")
        val access = AccessGrant.decode(raw) ?: throw VpnNativeException("system_vpn_resume_session_invalid")
        if (expiresWithin(accountId, access, Duration.ZERO)) throw SessionRenewalException(SessionRenewalException.UNAVAILABLE)
        return raw
    }

    /** Under R: one request, sent again identically within [attempts] while it stays transient. */
    private suspend fun exchange(accountId: String, send: Plan.Send, host: SessionRenewalHost, attempts: Int): Outcome {
        blockedFor(accountId)?.let { return Outcome.Unavailable(it) }
        val pending = send.pending
        val request = SessionRenewalContract.rotation(baseUrl, pending)
        var attempt = 1
        while (true) {
            val response = try {
                transport.send(request, host.physical, host::isCurrent)
            } catch (_: SessionTransportFailure) {
                null
            }
            val outcome = classify(pending.route, response, firstSend = send.created && attempt == 1, monotonicNanos())
            if (outcome !is Outcome.Transient) {
                gates.remove(accountId)
                return outcome
            }
            log("Session renewal: ${pending.route} ${outcome.status?.let { "answered $it" } ?: "not answered"}, request kept")
            if (outcome.status != null) backOff(accountId, outcome.retryAfterSeconds)
            val wait = blockedFor(accountId) ?: 0L
            if (attempt >= attempts || wait > IN_CALL_WAIT_SECONDS) return Outcome.Unavailable(blockedFor(accountId))
            attempt++
            pause(maxOf(wait, 1L) * 1_000L)
        }
    }

    /**
     * A 404 means "unknown contract" only for the very first send of an upgrade this process just
     * created: a resent request may already have converted the session, so it stays pending.
     */
    private fun classify(route: String, response: SessionRenewalContract.Response?, firstSend: Boolean,
        receivedAt: Long): Outcome {
        if (response == null) return Outcome.Transient(null, null)
        val retryAfter = SessionRenewalContract.retryAfterSeconds(response.retryAfter, now())
        return when (response.status) {
            200 -> SessionRenewalContract.pair(response, now())?.let { Outcome.Renewed(it, !firstSend, receivedAt) }
                ?: Outcome.Transient(200, retryAfter)
            400 -> Outcome.Invalid
            401 -> Outcome.Unauthorized
            404 -> if (route == SessionRenewalContract.UPGRADE && firstSend) Outcome.Unknown else Outcome.Transient(404, retryAfter)
            409 -> if (route == SessionRenewalContract.UPGRADE &&
                SessionRenewalContract.errorCode(response) == "session_upgrade_conflict") Outcome.Conflict
                else Outcome.Transient(409, retryAfter)
            else -> Outcome.Transient(response.status, retryAfter)
        }
    }

    /** Retry-After when given, otherwise 1, 2, 4 … 60 s after consecutive server-side refusals. */
    private fun backOff(accountId: String, retryAfterSeconds: Long?) {
        val failures = (gates[accountId]?.failures ?: 0) + 1
        val seconds = retryAfterSeconds ?: minOf(MAX_BACKOFF_SECONDS, 1L shl minOf(failures - 1, 6))
        gates[accountId] = RetryGate(now().plusSeconds(seconds), failures)
    }

    private fun blockedFor(accountId: String): Long? {
        val gate = gates[accountId] ?: return null
        val millis = Duration.between(now(), gate.notBefore).toMillis()
        return if (millis <= 0) null else (millis + 999) / 1_000
    }

    private companion object {
        const val CANCELLED = "session_operation_cancelled"
        /** A channel call sends at most twice; a path holding the tunnel mutex once. */
        const val CHANNEL_ATTEMPTS = 2
        /** A channel call waits in place for at most this before its second attempt. */
        const val IN_CALL_WAIT_SECONDS = 3L
        const val MAX_BACKOFF_SECONDS = 60L
    }
}

private fun JSONObject.fieldNames(): Set<String> = buildSet {
    val iterator = keys()
    while (iterator.hasNext()) add(iterator.next())
}

/** A JSON object of strings, written as Dart's jsonEncode writes it. */
internal fun dartJson(vararg fields: Pair<String, String>): String = fields.joinToString(",", "{", "}") { (name, value) ->
    "${dartString(name)}:${dartString(value)}"
}

private fun dartString(value: String): String = buildString {
    append('"')
    for (character in value) {
        when {
            character == '"' -> append("\\\"")
            character == '\\' -> append("\\\\")
            character < ' ' -> append("\\u%04x".format(Locale.ROOT, character.code))
            else -> append(character)
        }
    }
    append('"')
}

/** As Dart's DateTime.toIso8601String() for a UTC time: milliseconds always, microseconds when set. */
internal fun dartTimestamp(instant: Instant): String {
    val time = instant.atOffset(ZoneOffset.UTC)
    require(time.year in 0..9999 && instant.nano % 1_000 == 0) { "timestamp_out_of_range" }
    val micros = instant.nano / 1_000
    val extra = if (micros % 1_000 == 0) "" else "%03d".format(Locale.ROOT, micros % 1_000)
    return "%04d-%02d-%02dT%02d:%02d:%02d.%03d%sZ".format(Locale.ROOT, time.year, time.monthValue, time.dayOfMonth,
        time.hour, time.minute, time.second, micros / 1_000, extra)
}
