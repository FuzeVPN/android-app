package com.fuzevpn.android

import java.nio.charset.StandardCharsets
import java.security.SecureRandom
import java.time.Duration
import java.time.Instant
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter
import java.util.Base64
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.async
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.yield
import org.json.JSONObject
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

/**
 * The native owner of renewable sessions (docs/session-renewal-api.md of the API) against a
 * scripted server: every row of the contract's response table, the request written before it
 * leaves and repeated identically, the resume after a restart, the absence of any replay, the
 * single atomic commit and logs without values.
 */
class SessionRenewalTest {
    /** True time: the server's clock (its Date header) and the monotonic clock follow it. */
    private var clock = START
    /** How far the device's wall clock is from true time. */
    private var skew: Duration = Duration.ZERO
    /** When set, a request waits for it before its answer, holding R. */
    private var hold: CompletableDeferred<Unit>? = null
    private val memory = LinkedHashMap<SecureStorageSlot, String>()
    private val logs = mutableListOf<String>()
    private val sent = mutableListOf<Sent>()
    private val answers = ArrayDeque<(SessionRenewalContract.Request) -> SessionRenewalContract.Response>()
    private val pauses = mutableListOf<Long>()
    private val commits = mutableListOf<SessionRotation>()
    private val background = mutableListOf<suspend () -> Unit>()
    private var current = true
    private val slots = SessionRenewalSlots(
        SecureStorageKeyPolicy.accountSession(ACCOUNT),
        SecureStorageKeyPolicy.accountSessionRefresh(ACCOUNT),
        SecureStorageKeyPolicy.accountSessionRenewalPending(ACCOUNT),
    )

    private class Sent(val request: SessionRenewalContract.Request, val physical: Boolean, val pendingAtSend: String?) {
        val authorization get() = request.headers["authorization"]
        val requestId get() = JSONObject(String(request.body, StandardCharsets.UTF_8)).getString("request_id")
        val path get() = request.url.removePrefix(BASE)
    }

    private val transport = object : SessionRenewalTransport {
        override suspend fun send(request: SessionRenewalContract.Request, physical: Boolean,
            isCurrent: () -> Boolean): SessionRenewalContract.Response {
            sent += Sent(request, physical, memory[slots.pending])
            if (request.route != "logout") hold?.await()
            val answer = answers.removeFirstOrNull() ?: throw AssertionError("unexpected request to ${request.url}")
            return answer(request)
        }
    }

    private val host = object : SessionRenewalHost {
        override suspend fun <T> locked(block: () -> T): T = block()
        override fun checkCurrent() { if (!current) throw VpnNativeException("session_operation_cancelled") }
        override fun commit(rotation: SessionRotation) {
            commits += rotation
            memory[rotation.slots.access] = rotation.access
            memory[rotation.slots.refresh] = rotation.refresh
            memory.remove(rotation.slots.pending)
        }
        override val physical: Boolean get() = false
        override fun isCurrent(): Boolean = true
    }

    private fun renewal(random: SecureRandom = SecureRandom()) = SessionRenewal(
        transport = transport,
        baseUrl = BASE,
        slots = { assertEquals(ACCOUNT, it); slots },
        read = { memory[it] },
        write = { slot, value -> memory[slot] = value },
        delete = { memory.remove(it) },
        background = { background += it },
        log = { logs += it },
        now = { clock.plus(skew) },
        random = random,
        pause = { pauses += it; clock = clock.plusMillis(it) },
        monotonicNanos = { Duration.between(START, clock).toNanos() },
    )

    @After fun noValueReachesTheLog() {
        val secrets = sent.flatMap { listOfNotNull(it.authorization?.removePrefix("Bearer "), it.request.url) } +
            sent.mapNotNull { runCatching { it.requestId }.getOrNull() } +
            listOf(LEGACY, ACCESS_2, REFRESH_1, REFRESH_2, REFRESH_3)
        for (line in logs) for (secret in secrets) assertFalse("$line names a value", line.contains(secret))
    }

    @Test fun requestIdsAreThirtyTwoRandomBytesInCanonicalBase64UrlWithoutPadding() {
        val ids = List(200) { SessionRenewalContract.newRequestId(SecureRandom()) }
        assertEquals(200, ids.toSet().size)
        for (id in ids) {
            assertEquals(43, id.length)
            assertTrue(id, Regex("[A-Za-z0-9_-]{43}").matches(id))
            assertEquals(32, Base64.getUrlDecoder().decode(id).size)
            assertTrue(SessionRenewalContract.isRequestId(id))
        }
        val canonical = Base64.getUrlEncoder().withoutPadding().encodeToString(ByteArray(32))
        assertTrue(SessionRenewalContract.isRequestId(canonical))
        // The last character carries 2 bits: any other low bit set is a non-canonical spelling.
        assertFalse(SessionRenewalContract.isRequestId(canonical.dropLast(1) + "B"))
        assertFalse(SessionRenewalContract.isRequestId("$canonical="))
        assertFalse(SessionRenewalContract.isRequestId(canonical.dropLast(1)))
        assertFalse(SessionRenewalContract.isRequestId(canonical.dropLast(1) + "+"))
    }

    @Test fun theRequestsAreTheContractRoutes() {
        val pending = PendingRenewal(SessionRenewalContract.UPGRADE, LEGACY, ID)
        val upgrade = SessionRenewalContract.rotation(BASE, pending)
        assertEquals("${BASE}v1/auth/session/upgrade", upgrade.url)
        assertEquals(mapOf("accept" to "application/json", "cache-control" to "no-store",
            "authorization" to "Bearer $LEGACY", "content-type" to "application/json; charset=utf-8"), upgrade.headers)
        assertEquals("""{"request_id":"$ID"}""", String(upgrade.body, StandardCharsets.UTF_8))
        val refresh = SessionRenewalContract.rotation(BASE, PendingRenewal(SessionRenewalContract.REFRESH, REFRESH_1, ID))
        assertEquals("${BASE}v1/auth/session/refresh", refresh.url)
        assertEquals("Bearer $REFRESH_1", refresh.headers["authorization"])
        // Logout: the refresh token, no body, no content type and no browser-context header.
        val logout = SessionRenewalContract.logout(BASE, REFRESH_1)
        assertEquals("${BASE}v1/auth/logout", logout.url)
        assertEquals(mapOf("accept" to "application/json", "cache-control" to "no-store",
            "authorization" to "Bearer $REFRESH_1"), logout.headers)
        assertEquals(0, logout.body.size)
    }

    @Test fun storedValuesHaveTheFormatDartWritesAndReads() {
        val access = AccessGrant(ACCESS_2, Instant.parse("2026-11-08T14:00:00Z"))
        assertEquals("""{"access_token":"$ACCESS_2","expires_at":"2026-11-08T14:00:00.000Z"}""", access.encode())
        assertEquals("2026-11-08T14:00:00.123456Z", dartTimestamp(Instant.parse("2026-11-08T14:00:00.123456Z")))
        assertEquals("2026-11-08T14:00:00.120Z", dartTimestamp(Instant.parse("2026-11-08T14:00:00.12Z")))
        assertEquals(access, AccessGrant.decode(access.encode()))
        // The two-key access format of the system resume and of storageReadSession.
        assertEquals(Instant.parse("2026-11-08T14:00:00Z"),
            validateSystemVpnSessionPayload(access.encode(), Instant.MIN)!!.expiresAt)
        val refresh = RefreshGrant(REFRESH_1, Instant.parse("2027-11-08T13:00:00Z"))
        assertEquals("""{"refresh_token":"$REFRESH_1","refresh_expires_at":"2027-11-08T13:00:00.000Z"}""", refresh.encode())
        assertEquals(refresh, RefreshGrant.decode(refresh.encode()))
        val pending = PendingRenewal(SessionRenewalContract.REFRESH, REFRESH_1, ID)
        assertEquals("""{"route":"refresh","presented_token":"$REFRESH_1","request_id":"$ID"}""", pending.encode())
        assertEquals(pending, PendingRenewal.decode(pending.encode()))
        assertNull(PendingRenewal.decode("""{"route":"logout","presented_token":"$REFRESH_1","request_id":"$ID"}"""))
        assertNull(PendingRenewal.decode("""{"route":"refresh","presented_token":"$REFRESH_1","request_id":"short"}"""))
        assertNull(RefreshGrant.decode("""{"refresh_token":"$REFRESH_1","refresh_expires_at":"2027-11-08T13:00:00Z","x":"y"}"""))
    }

    @Test fun anUpgradeIsWrittenBeforeItLeavesAndItsPairIsCommittedOnce() = runBlocking {
        classic()
        answers += { request ->
            // Durable before the request leaves: route, presented token and request id together.
            val pending = PendingRenewal.decode(memory.getValue(slots.pending))!!
            assertEquals(PendingRenewal(SessionRenewalContract.UPGRADE, LEGACY, sent.last().requestId), pending)
            assertTrue(commits.isEmpty())
            pair(request)
        }
        val result = renewal().upgrade(ACCOUNT, host)
        assertEquals(SessionKind.RENEWABLE, result.kind)
        assertEquals(newAccess().encode(), result.payload)
        assertEquals("v1/auth/session/upgrade", sent.single().path)
        assertEquals("Bearer $LEGACY", sent.single().authorization)
        assertTrue(SessionRenewalContract.isRequestId(sent.single().requestId))
        val rotation = commits.single()
        assertEquals(classicPayload(), rotation.previousAccess)
        assertEquals(newAccess().encode(), memory[slots.access])
        assertEquals(RefreshGrant(REFRESH_2, clock.plus(YEAR)).encode(), memory[slots.refresh])
        assertNull(memory[slots.pending])
        // Converted: a second upgrade returns it without a request.
        assertEquals(SessionAccess(SessionKind.RENEWABLE, newAccess().encode()), renewal().upgrade(ACCOUNT, host))
        assertEquals(1, sent.size)
    }

    @Test fun eachRowOfTheResponseTableHasItsOutcome() = runBlocking {
        data class Row(val name: String, val route: String, val status: Int?, val error: String? = null,
            val retryAfter: String? = null)
        val rows = listOf(
            Row("400 invalid id", SessionRenewalContract.REFRESH, 400, "invalid_session_request_id"),
            Row("400 invalid json", SessionRenewalContract.UPGRADE, 400, "invalid_json"),
            Row("401", SessionRenewalContract.REFRESH, 401, "unauthorized"),
            Row("401 upgrade", SessionRenewalContract.UPGRADE, 401, "unauthorized"),
            Row("404 upgrade", SessionRenewalContract.UPGRADE, 404),
            Row("404 refresh", SessionRenewalContract.REFRESH, 404),
            Row("409 conflict", SessionRenewalContract.UPGRADE, 409, "session_upgrade_conflict"),
            Row("409 transition", SessionRenewalContract.REFRESH, 409, "session_transition"),
            Row("409 conflict on refresh", SessionRenewalContract.REFRESH, 409, "session_upgrade_conflict"),
            Row("429", SessionRenewalContract.REFRESH, 429, "rate_limited", "30"),
            Row("500", SessionRenewalContract.REFRESH, 500, "server_error"),
            Row("503", SessionRenewalContract.UPGRADE, 503, "session_renewal_unavailable"),
            Row("network", SessionRenewalContract.REFRESH, null),
        )
        for (row in rows) {
            reset()
            if (row.route == SessionRenewalContract.UPGRADE) classic() else renewable(accessIn = Duration.ofMinutes(2))
            val stored = memory.toMap()
            repeat(2) {
                answers += { _ ->
                    row.status?.let { status -> response(status, """{"error":"${row.error}","message":"m"}""", row.retryAfter) }
                        ?: throw SessionTransportFailure()
                }
            }
            val outcome = runCatching {
                if (row.route == SessionRenewalContract.UPGRADE) renewal().upgrade(ACCOUNT, host)
                else renewal().ensureFresh(ACCOUNT, host)
            }
            val error = outcome.exceptionOrNull() as? SessionRenewalException
            val pendingKept = memory[slots.pending] != null
            when (row.name) {
                "400 invalid id", "400 invalid json" -> {
                    assertEquals(row.name, SessionRenewalException.INVALID, error?.code)
                    assertFalse(row.name, pendingKept)
                    assertEquals(row.name, 1, sent.size)
                }
                "401", "401 upgrade" -> {
                    assertEquals(row.name, SessionRenewalException.UNAUTHORIZED, error?.code)
                    assertFalse(row.name, pendingKept)
                    assertEquals(row.name, 1, sent.size)
                }
                "404 upgrade" -> {
                    // The server does not know the contract yet: the classic session goes on, nothing written.
                    assertEquals(row.name, SessionAccess(SessionKind.CLASSIC, classicPayload()), outcome.getOrNull())
                    assertEquals(row.name, stored, memory.toMap())
                    assertEquals(row.name, 1, sent.size)
                }
                "409 conflict" -> {
                    assertEquals(row.name, SessionAccess(SessionKind.CLASSIC, classicPayload()), outcome.getOrNull())
                    assertFalse(row.name, pendingKept)
                    assertEquals(row.name, 1, sent.size)
                }
                "429" -> {
                    assertEquals(row.name, SessionRenewalException.UNAVAILABLE, error?.code)
                    assertEquals(row.name, 30L, error?.retryAfterSeconds)
                    assertTrue(row.name, pendingKept)
                    assertEquals(row.name, 1, sent.size)
                }
                else -> {
                    // Kept and sent again identically, once, after a pause.
                    assertEquals(row.name, SessionRenewalException.UNAVAILABLE, error?.code)
                    assertTrue(row.name, pendingKept)
                    assertEquals(row.name, 2, sent.size)
                    assertEquals(row.name, sent[0].requestId, sent[1].requestId)
                    assertEquals(row.name, sent[0].authorization, sent[1].authorization)
                    assertEquals(row.name, listOf(1_000L), pauses)
                    assertEquals(row.name, if (row.status == null) null else 2L, error?.retryAfterSeconds)
                }
            }
            assertTrue(row.name, commits.isEmpty())
            if (!pendingKept && row.name != "404 upgrade") {
                assertEquals(row.name, stored, memory.toMap())
            }
        }
    }

    @Test fun anUnusableSuccessIsKeptPendingLikeALostAnswer() = runBlocking {
        for (bad in listOf(response(200, pairBody(), cacheControl = null), response(200, "{not json"),
                response(200, pairBody().replace(REFRESH_2, "")), response(200, pairBody().replace("Z\"", "\"")))) {
            reset()
            renewable(accessIn = Duration.ofMinutes(1))
            answers += { bad }
            answers += { bad }
            val error = assertThrows(SessionRenewalException::class.java) { runBlocking { renewal().ensureFresh(ACCOUNT, host) } }
            assertEquals(SessionRenewalException.UNAVAILABLE, error.code)
            assertTrue(commits.isEmpty())
            assertEquals(sent[0].requestId, sent[1].requestId)
            assertTrue(memory[slots.pending] != null)
        }
    }

    @Test fun aLostAnswerIsSentAgainIdenticallyAndItsPairCommitted() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(4))
        answers += { throw SessionTransportFailure() }
        answers += { pair(it) }
        val result = renewal().ensureFresh(ACCOUNT, host)
        assertEquals(newAccess().encode(), result.payload)
        assertEquals(2, sent.size)
        assertEquals(sent[0].requestId, sent[1].requestId)
        assertEquals(listOf("Bearer $REFRESH_1", "Bearer $REFRESH_1"), sent.map { it.authorization })
        assertEquals(sent[0].pendingAtSend, sent[1].pendingAtSend)
        assertEquals(1, commits.size)
    }

    @Test fun aPendingRequestIsResumedIdenticallyAfterARestart() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(3))
        repeat(2) { answers += { response(503, """{"error":"server_error"}""") } }
        assertThrows(SessionRenewalException::class.java) { runBlocking { renewal().ensureFresh(ACCOUNT, host) } }
        val stored = memory.getValue(slots.pending)
        // A new process: nothing kept in memory, the request is read back and sent as it was.
        clock = clock.plus(Duration.ofHours(3))
        answers += { pair(it) }
        val restarted = renewal(random = FixedRandom()).ensureFresh(ACCOUNT, host)
        assertEquals(newAccess().encode(), restarted.payload)
        assertEquals(3, sent.size)
        assertEquals(1, sent.map { it.requestId }.toSet().size)
        assertEquals(stored, sent.last().pendingAtSend)
        assertNull(memory[slots.pending])
    }

    @Test fun anUpgradeLeftPendingIsResumedBeforeAnythingElse() = runBlocking {
        classic()
        repeat(2) { answers += { throw SessionTransportFailure() } }
        assertThrows(SessionRenewalException::class.java) { runBlocking { renewal().upgrade(ACCOUNT, host) } }
        // The legacy access may already be retired by the server: ensureFresh resumes the upgrade.
        answers += { pair(it) }
        assertEquals(SessionKind.RENEWABLE, renewal().ensureFresh(ACCOUNT, host).kind)
        assertEquals(1, sent.map { it.requestId }.toSet().size)
        assertEquals(listOf("v1/auth/session/upgrade"), sent.map { it.path }.distinct())
    }

    @Test fun noRetiredRefreshTokenIsEverPresentedAgain() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { pair(it) }
        renewal().ensureFresh(ACCOUNT, host)
        clock = clock.plus(Duration.ofMinutes(58))
        answers += { pair(it, access = "access-3", refresh = REFRESH_3) }
        renewal().ensureFresh(ACCOUNT, host)
        assertEquals(listOf("Bearer $REFRESH_1", "Bearer $REFRESH_2"), sent.map { it.authorization })
        assertNotEquals(sent[0].requestId, sent[1].requestId)
        // A request naming a credential the session no longer holds is dropped, never sent.
        memory[slots.pending] = PendingRenewal(SessionRenewalContract.REFRESH, REFRESH_1, ID).encode()
        clock = clock.plus(Duration.ofMinutes(58))
        answers += { pair(it, access = "access-4", refresh = "fr1.refresh-4") }
        renewal().ensureFresh(ACCOUNT, host)
        assertEquals("Bearer $REFRESH_3", sent.last().authorization)
        assertNotEquals(ID, sent.last().requestId)
        assertTrue(sent.none { it.authorization == "Bearer $REFRESH_1" && it.requestId == ID })
    }

    @Test fun anUnreadablePendingRequestIsNeitherReplacedNorSent() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        memory[slots.pending] = """{"route":"refresh"}"""
        val error = assertThrows(SessionRenewalException::class.java) { runBlocking { renewal().ensureFresh(ACCOUNT, host) } }
        assertEquals(SessionRenewalException.INVALID, error.code)
        assertTrue(sent.isEmpty())
        assertEquals("""{"route":"refresh"}""", memory[slots.pending])
    }

    @Test fun aResentRequestRestoringAnAccessAlreadyOverIsRenewedOnceMoreAtOnce() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(-90))
        // The answer to the first send is lost; the identical resend restores the pair with its
        // original expiry, which the server's own Date says is over.
        answers += { throw SessionTransportFailure() }
        answers += { pair(it, accessExpiry = clock.minusSeconds(1)) }
        answers += { pair(it, access = "access-3", refresh = REFRESH_3, accessExpiry = clock.minusSeconds(1)) }
        val result = renewal().ensureFresh(ACCOUNT, host)
        assertEquals(listOf("Bearer $REFRESH_1", "Bearer $REFRESH_1", "Bearer $REFRESH_2"), sent.map { it.authorization })
        assertEquals(sent[0].requestId, sent[1].requestId)
        assertNotEquals(sent[1].requestId, sent[2].requestId)
        assertEquals(2, commits.size)
        // At most one follow-up: the second expired access is returned as it is.
        assertEquals(AccessGrant("access-3", clock.minusSeconds(1)).encode(), result.payload)
        assertEquals(RefreshGrant(REFRESH_3, clock.plus(YEAR)).encode(), memory[slots.refresh])
        // A request read back after a restart is a resend too.
        reset()
        renewable(accessIn = Duration.ofMinutes(-90))
        memory[slots.pending] = PendingRenewal(SessionRenewalContract.REFRESH, REFRESH_1, ID).encode()
        answers += { pair(it, accessExpiry = clock.minusSeconds(1)) }
        answers += { pair(it, access = "access-3", refresh = REFRESH_3) }
        assertEquals(AccessGrant("access-3", clock.plus(Duration.ofHours(1))).encode(), renewal().ensureFresh(ACCOUNT, host).payload)
        assertEquals(listOf(ID), sent.take(1).map { it.requestId })
        assertEquals(2, sent.size)
    }

    // Review of 15/11: with the device clock one hour ahead, every pair looked expired on receipt:
    // two rotations per call, and the access returned still looked expired.
    @Test fun aDeviceClockAheadNeverChurnsRotations() = runBlocking {
        skew = Duration.ofHours(1)
        renewable(accessIn = Duration.ofMinutes(50))
        val renewal = renewal()
        answers += { pair(it) }
        assertEquals(newAccess().encode(), renewal.ensureFresh(ACCOUNT, host).payload)
        assertEquals("a first send is never followed up", 1, sent.size)
        // Judged on the lifetime the server stated (one hour from its Date), not on the device clock.
        assertEquals(newAccess().encode(), renewal.ensureFresh(ACCOUNT, host).payload)
        assertEquals(newAccess().encode(), renewal.accessHoldingTunnel(ACCOUNT, host))
        clock = clock.plus(Duration.ofMinutes(54))
        renewal.ensureFresh(ACCOUNT, host)
        assertEquals(1, sent.size)
        clock = clock.plus(Duration.ofMinutes(2))
        answers += { pair(it, access = "access-3", refresh = REFRESH_3) }
        assertEquals(AccessGrant("access-3", clock.plus(Duration.ofHours(1))).encode(), renewal.ensureFresh(ACCOUNT, host).payload)
        assertEquals(listOf("Bearer $REFRESH_1", "Bearer $REFRESH_2"), sent.map { it.authorization })
    }

    @Test fun aDeviceClockBehindStillRenewsInTime() = runBlocking {
        skew = Duration.ofHours(-1)
        renewable(accessIn = Duration.ofMinutes(-10))
        val renewal = renewal()
        // On the device clock the stored access still has 50 minutes: no request yet.
        assertEquals(SessionKind.RENEWABLE, renewal.ensureFresh(ACCOUNT, host).kind)
        assertTrue(sent.isEmpty())
        // Dart then received a 401 and forces the refresh: the server's dates prevail.
        answers += { pair(it) }
        assertEquals(newAccess().encode(), renewal.ensureFresh(ACCOUNT, host, force = true).payload)
        // The new pair is judged on the server's lifetime: renewed 4 minutes before its end, although
        // the device clock still gives it more than an hour.
        clock = clock.plus(Duration.ofMinutes(54))
        renewal.ensureFresh(ACCOUNT, host)
        assertEquals(1, sent.size)
        clock = clock.plus(Duration.ofMinutes(2))
        answers += { pair(it, access = "access-3", refresh = REFRESH_3) }
        renewal.ensureFresh(ACCOUNT, host)
        assertEquals(listOf("Bearer $REFRESH_1", "Bearer $REFRESH_2"), sent.map { it.authorization })
    }

    @Test fun aForcedRefreshRenewsWhateverTheDeviceClockSays() = runBlocking {
        classic()
        assertEquals(SessionAccess(SessionKind.CLASSIC, classicPayload()), renewal().ensureFresh(ACCOUNT, host, force = true))
        assertTrue(sent.isEmpty())
        reset()
        renewable(accessIn = Duration.ofHours(1))
        answers += { pair(it) }
        assertEquals(newAccess().encode(), renewal().ensureFresh(ACCOUNT, host, force = true).payload)
        assertEquals("Bearer $REFRESH_1", sent.single().authorization)
        // A grant that looks over on the device clock is still presented: the server answers.
        reset()
        renewable(accessIn = Duration.ofHours(1), refreshIn = Duration.ofSeconds(-1))
        answers += { response(401, """{"error":"unauthorized"}""") }
        assertEquals(SessionRenewalException.UNAUTHORIZED, assertThrows(SessionRenewalException::class.java) {
            runBlocking { renewal().ensureFresh(ACCOUNT, host, force = true) } }.code)
        assertEquals(1, sent.size)
    }

    // Review of 15/11: only the first send of an upgrade just created may learn that the server does
    // not know the contract. A resent one may already have converted the session.
    @Test fun a404ToAResentUpgradeKeepsItPending() = runBlocking {
        classic()
        val legacy = memory.getValue(slots.access)
        answers += { throw SessionTransportFailure() }
        answers += { response(404, """{"error":"not_found"}""") }
        val resent = assertThrows(SessionRenewalException::class.java) { runBlocking { renewal().upgrade(ACCOUNT, host) } }
        assertEquals(SessionRenewalException.UNAVAILABLE, resent.code)
        val pending = memory.getValue(slots.pending)
        assertEquals(sent[0].requestId, sent[1].requestId)
        // Read back by a new process: still a resend.
        clock = clock.plus(Duration.ofMinutes(5))
        repeat(2) { answers += { response(404, """{"error":"not_found"}""") } }
        assertEquals(SessionRenewalException.UNAVAILABLE, assertThrows(SessionRenewalException::class.java) {
            runBlocking { renewal().ensureFresh(ACCOUNT, host) } }.code)
        assertEquals(pending, memory[slots.pending])
        assertEquals(legacy, memory[slots.access])
        assertEquals(4, sent.size)
        assertEquals(1, sent.map { it.requestId }.toSet().size)
    }

    @Test fun aRefusalAsInvalidAfterTheSessionEndedLeavesItsCleanupToThePurge() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { current = false; response(400, """{"error":"invalid_session_request_id"}""") }
        assertEquals("session_operation_cancelled", assertThrows(VpnNativeException::class.java) {
            runBlocking { renewal().ensureFresh(ACCOUNT, host) } }.code)
        assertTrue(memory[slots.pending] != null)
    }

    @Test fun retryAfterIsHonouredAcrossCalls() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { response(429, """{"error":"rate_limited"}""", "120") }
        val renewal = renewal()
        assertEquals(120L, assertThrows(SessionRenewalException::class.java) {
            runBlocking { renewal.ensureFresh(ACCOUNT, host) } }.retryAfterSeconds)
        clock = clock.plusSeconds(30)
        val waiting = assertThrows(SessionRenewalException::class.java) { runBlocking { renewal.ensureFresh(ACCOUNT, host) } }
        assertEquals(SessionRenewalException.UNAVAILABLE, waiting.code)
        assertEquals(90L, waiting.retryAfterSeconds)
        assertEquals(1, sent.size)
        clock = clock.plusSeconds(91)
        answers += { pair(it) }
        assertEquals(newAccess().encode(), renewal.ensureFresh(ACCOUNT, host).payload)
        assertEquals(sent[0].requestId, sent[1].requestId)
        assertEquals(120L, SessionRenewalContract.retryAfterSeconds("Sat, 14 Nov 2026 12:02:00 GMT",
            Instant.parse("2026-11-14T12:00:00Z")))
        assertNull(SessionRenewalContract.retryAfterSeconds("soon", clock))
    }

    @Test fun onlyAnExpiringRenewableSessionIsRenewed() = runBlocking {
        classic()
        assertEquals(SessionAccess(SessionKind.CLASSIC, classicPayload()), renewal().ensureFresh(ACCOUNT, host))
        reset()
        renewable(accessIn = Duration.ofMinutes(5).plusSeconds(1))
        assertEquals(SessionKind.RENEWABLE, renewal().ensureFresh(ACCOUNT, host).kind)
        assertTrue(sent.isEmpty())
        clock = clock.plusSeconds(2)
        answers += { pair(it) }
        assertEquals(newAccess().encode(), renewal().ensureFresh(ACCOUNT, host).payload)
        assertEquals(1, sent.size)
        // An upgrade of a converted session sends nothing, even with its access over.
        reset()
        renewable(accessIn = Duration.ofMinutes(-30))
        assertEquals(SessionKind.RENEWABLE, renewal().upgrade(ACCOUNT, host).kind)
        assertTrue(sent.isEmpty())
    }

    @Test fun aRenewalGrantOverNeedsANewAuthentication() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(-30), refreshIn = Duration.ofSeconds(-1))
        val error = assertThrows(SessionRenewalException::class.java) { runBlocking { renewal().ensureFresh(ACCOUNT, host) } }
        assertEquals(SessionRenewalException.REFRESH_EXPIRED, error.code)
        assertTrue(sent.isEmpty())
        assertNull(memory[slots.pending])
    }

    @Test fun anAnswerForASessionThatChangedMeanwhileIsNeverCommitted() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        val replacement = AccessGrant("new-login", clock.plus(Duration.ofDays(30))).encode()
        answers += { request ->
            // Dart stored another session meanwhile, which removed the renewal state.
            memory[slots.access] = replacement
            memory.remove(slots.refresh)
            memory.remove(slots.pending)
            pair(request)
        }
        assertEquals(SessionAccess(SessionKind.CLASSIC, replacement), renewal().ensureFresh(ACCOUNT, host))
        assertTrue(commits.isEmpty())
        assertEquals(replacement, memory[slots.access])
        assertNull(memory[slots.refresh])
    }

    @Test fun aRefusalAfterAnotherRotationReadsTheStorageAgain() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { _ ->
            // Another renewal committed first: this request's credential is retired.
            memory[slots.access] = newAccess().encode()
            memory[slots.refresh] = RefreshGrant(REFRESH_2, clock.plus(YEAR)).encode()
            memory.remove(slots.pending)
            response(401, """{"error":"unauthorized"}""")
        }
        assertEquals(SessionAccess(SessionKind.RENEWABLE, newAccess().encode()), renewal().ensureFresh(ACCOUNT, host))
        assertEquals(1, sent.size)
    }

    @Test fun aSessionThatEndedStopsTheRenewalAndKeepsItsRequest() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { throw VpnNativeException("session_operation_cancelled") }
        val error = assertThrows(VpnNativeException::class.java) { runBlocking { renewal().ensureFresh(ACCOUNT, host) } }
        assertEquals("session_operation_cancelled", error.code)
        assertTrue(memory[slots.pending] != null)
        current = false
        assertThrows(VpnNativeException::class.java) { runBlocking { renewal().ensureFresh(ACCOUNT, host) } }
        assertEquals(1, sent.size)
    }

    @Test fun logoutPresentsTheRefreshTokenAfterAnswering() = runBlocking {
        classic()
        assertEquals(SessionKind.CLASSIC, renewal().logout(ACCOUNT, host))
        assertTrue(background.isEmpty())
        reset()
        renewable(accessIn = Duration.ofMinutes(1))
        val renewal = renewal()
        assertEquals(SessionKind.RENEWABLE, renewal.logout(ACCOUNT, host))
        assertTrue("sent before the call answered", sent.isEmpty())
        answers += { response(204, "") }
        background.single().invoke()
        assertEquals("v1/auth/logout", sent.single().path)
        assertEquals("Bearer $REFRESH_1", sent.single().authorization)
        assertEquals(0, sent.single().request.body.size)
        assertNull(sent.single().request.headers["content-type"])
        // R was never taken: the next renewal runs at once.
        answers += { pair(it) }
        assertEquals(newAccess().encode(), renewal.accessHoldingTunnel(ACCOUNT, host))
    }

    // Review of 15/11: a rotation can hold R for tens of seconds while Dart, ending the session,
    // waits about 10 s for the logout. The logout no longer waits for R.
    @Test fun logoutNeverWaitsForARotationHoldingTheLock() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        val renewal = renewal()
        hold = CompletableDeferred()
        val rotation = async { renewal.ensureFresh(ACCOUNT, host) }
        while (sent.isEmpty()) yield()
        assertEquals("v1/auth/session/refresh", sent.single().path)
        // The pending refresh still presents the stored token: the logout uses it, as the server revokes it too.
        assertEquals(SessionKind.RENEWABLE, renewal.logout(ACCOUNT, host))
        answers += { response(204, "") }
        background.single().invoke()
        assertEquals(listOf("v1/auth/session/refresh", "v1/auth/logout"), sent.map { it.path })
        assertEquals("Bearer $REFRESH_1", sent.last().authorization)
        assertTrue("the rotation was still in progress", rotation.isActive)
        answers.addFirst { pair(it) }
        hold!!.complete(Unit)
        assertEquals(newAccess().encode(), rotation.await().payload)
    }

    @Test fun thePathHoldingTheTunnelNeverWaitsAndKeepsAValidAccess() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(2))
        val renewal = renewal()
        answers += { response(503, """{"error":"server_error"}""") }
        // One attempt, no pause: the valid access is kept.
        assertEquals(renewablePayload(Duration.ofMinutes(2)), renewal.accessHoldingTunnel(ACCOUNT, host))
        assertEquals(1, sent.size)
        assertTrue(pauses.isEmpty())
        // Expired: unavailable, which the bridge treats as the absence of network.
        clock = clock.plus(Duration.ofMinutes(3))
        answers += { throw SessionTransportFailure() }
        assertEquals(SessionRenewalException.UNAVAILABLE, assertThrows(SessionRenewalException::class.java) {
            runBlocking { renewal.accessHoldingTunnel(ACCOUNT, host) } }.code)
        assertEquals(sent[0].requestId, sent[1].requestId)
        // Busy elsewhere (a rotation in progress holds R): never awaited.
        reset()
        renewable(accessIn = Duration.ofMinutes(-1))
        val busy = renewal()
        hold = CompletableDeferred()
        val rotation = async { busy.ensureFresh(ACCOUNT, host) }
        while (sent.isEmpty()) yield()
        assertEquals(SessionRenewalException.UNAVAILABLE, assertThrows(SessionRenewalException::class.java) {
            runBlocking { busy.accessHoldingTunnel(ACCOUNT, host) } }.code)
        assertEquals(1, sent.size)
        answers += { pair(it) }
        hold!!.complete(Unit)
        rotation.await()
        hold = null
        // A refused session is not hidden.
        reset()
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { response(401, """{"error":"unauthorized"}""") }
        assertEquals(SessionRenewalException.UNAUTHORIZED, assertThrows(SessionRenewalException::class.java) {
            runBlocking { renewal().accessHoldingTunnel(ACCOUNT, host) } }.code)
    }

    @Test fun logsNameOnlyRoutesAndStatuses() = runBlocking {
        renewable(accessIn = Duration.ofMinutes(1))
        answers += { response(503, """{"error":"server_error"}""") }
        answers += { throw SessionTransportFailure() }
        runCatching { renewal().ensureFresh(ACCOUNT, host) }
        clock = clock.plusSeconds(10)
        answers += { pair(it) }
        renewal().ensureFresh(ACCOUNT, host)
        assertTrue(logs.isNotEmpty())
        for (line in logs) assertTrue(line, line.startsWith("Session renewal: "))
        for (line in logs) assertFalse(line, line.contains("{") || line.contains("Bearer") || line.contains("http"))
    }

    private fun reset() {
        memory.clear(); sent.clear(); answers.clear(); pauses.clear(); commits.clear(); background.clear()
        current = true
        hold = null
    }

    private fun classic() {
        memory[slots.access] = classicPayload()
    }

    private fun classicPayload() = AccessGrant(LEGACY, clock.plus(Duration.ofDays(20))).encode()

    private fun renewablePayload(accessIn: Duration) = AccessGrant("access-1", clock.plus(accessIn)).encode()

    private fun renewable(accessIn: Duration, refreshIn: Duration = YEAR) {
        memory[slots.access] = renewablePayload(accessIn)
        memory[slots.refresh] = RefreshGrant(REFRESH_1, clock.plus(refreshIn)).encode()
    }

    private fun newAccess() = AccessGrant(ACCESS_2, clock.plus(Duration.ofHours(1)))

    private fun pairBody(access: String = ACCESS_2, refresh: String = REFRESH_2, accessExpiry: Instant = clock.plus(Duration.ofHours(1))) =
        """{"access_token":"$access","expires_at":"$accessExpiry","refresh_token":"$refresh",""" +
            """"refresh_expires_at":"${clock.plus(YEAR)}"}"""

    @Suppress("UNUSED_PARAMETER")
    private fun pair(request: SessionRenewalContract.Request, access: String = ACCESS_2, refresh: String = REFRESH_2,
        accessExpiry: Instant = clock.plus(Duration.ofHours(1))) = response(200, pairBody(access, refresh, accessExpiry))

    /** Dated by the server's clock, which is true time. */
    private fun response(status: Int, body: String, retryAfter: String? = null, cacheControl: String? = "no-store") =
        SessionRenewalContract.Response(status, cacheControl, retryAfter, body.toByteArray(StandardCharsets.UTF_8),
            DateTimeFormatter.RFC_1123_DATE_TIME.format(clock.atOffset(ZoneOffset.UTC)))

    /** The generator of a fresh process; any reuse of its output would show as a second id. */
    private class FixedRandom : SecureRandom() {
        override fun nextBytes(bytes: ByteArray) = bytes.fill(7)
    }

    private companion object {
        const val ACCOUNT = "account-1"
        const val BASE = "https://api.fuzevpn.test/"
        const val LEGACY = "legacy-access-token-43-characters-long-abcd"
        const val ACCESS_2 = "access-2"
        const val REFRESH_1 = "fr1.refresh-1"
        const val REFRESH_2 = "fr1.refresh-2"
        const val REFRESH_3 = "fr1.refresh-3"
        const val ID = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        val START: Instant = Instant.parse("2026-11-14T12:00:00Z")
        val YEAR: Duration = Duration.ofDays(365)
    }
}
