package com.fuzevpn.android

import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.Collections
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

/** One deterministic stop point inside a fake engine or store. */
internal class Gate(val name: String) {
    private val reached = CountDownLatch(1)
    private val release = CountDownLatch(1)
    fun hold() {
        reached.countDown()
        check(release.await(20, TimeUnit.SECONDS)) { "gate $name never released" }
    }
    fun awaitReached() = check(reached.await(20, TimeUnit.SECONDS)) { "gate $name never reached" }
    fun open() = release.countDown()
}

/** Shared journal of the fakes; reset before every test. */
internal object HarnessControl {
    val notifications: MutableList<String> = Collections.synchronizedList(mutableListOf())
    val locales: MutableList<String?> = Collections.synchronizedList(mutableListOf())
    val purges: MutableList<Boolean> = Collections.synchronizedList(mutableListOf())
    @Volatile var identityGate: Gate? = null
    @Volatile var identityFailure: String? = null
    @Volatile var resumeReadGate: Gate? = null
    /** Every store read throws this code, as an unavailable Keystore would. */
    @Volatile var readFailure: String? = null
    /** Every store read fails as SecureKeystoreStore does once its Keystore key is gone. */
    @Volatile var readKeyMissing = false
    /** Only the next store read throws this code, as a transient Keystore failure. */
    @Volatile var readFailureOnce: String? = null
    /** Every store write throws this code, as a Keystore that cannot encrypt would; a purge still succeeds. */
    @Volatile var writeFailure: String? = null
    /** getOrCreatePublicKey throws this code, as the real engine does while a stop is uncertain. */
    @Volatile var publicKeyFailure: String? = null
    /** Holds getOrCreateWireGuardPublicKey inside the tunnel mutex. */
    @Volatile var publicKeyGate: Gate? = null
    /** Holds a session purge once it has erased the session slots. */
    @Volatile var purgeGate: Gate? = null
    @Volatile var wireGuardConnect: (isCurrent: () -> Boolean) -> Boolean = { true }
    @Volatile var wireGuardConnectGate: Gate? = null
    @Volatile var wireGuardConnects = 0
    @Volatile var wireGuardStops = 0
    @Volatile var wireGuardUp = false
    @Volatile var wireGuardStopResult = true
    /** Holds the next engine stop, after the bridge published DISCONNECTING. */
    @Volatile var wireGuardStopGate: Gate? = null
    /** Holds the next read of the tile profile, as a slow Keystore decrypt would. */
    @Volatile var tileProfileReadGate: Gate? = null
    /** Makes an ERROR notification refresh throw, as a missing patched AAR would. */
    @Volatile var errorNotificationFailure: String? = null
    @Volatile var openVpnConnects = 0
    @Volatile var openVpnReconnects = 0
    @Volatile var openVpnStops = 0
    /** False makes an OpenVPN stop time out, as a Core worker that cannot end would. */
    @Volatile var openVpnStopResult = true
    @Volatile var openVpnNetworkLosses = 0
    /** False makes a local OpenVPN restart end without CONNECTED, as a handshake timeout would. */
    @Volatile var openVpnReconnect: () -> Boolean = { true }
    /** Holds the next OpenVPN start once Core began, before its CONNECTED. */
    @Volatile var openVpnStartGate: Gate? = null
    /** OpenVpnService calls: "start(reconnecting=…)" and "stop" (the TUN hold release). */
    val openVpnService: MutableList<String> = Collections.synchronizedList(mutableListOf())
    /** The stored certificate as certificateStatus reports it: "valid", "expiring", "expired" or "missing". */
    @Volatile var openVpnCertificate = "valid"
    /** A renewal CSR is stored and not yet activated, as after getOrCreateCsr(renewal = true). */
    @Volatile var openVpnRenewalPending = false
    /** Fingerprint of the active OpenVPN identity; a renewed activation replaces it. */
    @Volatile var openVpnIdentity = WireGuardController.IDENTITY
    @Volatile var openVpnCsrRequests = 0
    /** False makes Core end a start from an activation without CONNECTED. */
    @Volatile var openVpnConnect: () -> Boolean = { true }
    /** Renewal requests the bridge sent: "url authorization". */
    val renewalRequests: MutableList<String> = Collections.synchronizedList(mutableListOf())
    /** The server's answer to a renewal (status, body); may throw what the transport would. */
    @Volatile var renewalResponse: (deviceId: String) -> Pair<Int, String> = { renewedActivation(it) }
    /** Keeps a renewal request unanswered, as a slow server would, while it stays current. */
    @Volatile var renewalHold = false
    /** Session-renewal requests the bridge sent: "path authorization [request_id]". */
    val sessionRequests: MutableList<String> = Collections.synchronizedList(mutableListOf())
    /** Whether each of them was bound to a physical network. */
    val sessionPhysical: MutableList<Boolean> = Collections.synchronizedList(mutableListOf())
    /** The API's answer to a session request (its path); may throw what the transport would. */
    @Volatile var sessionResponse: (path: String) -> SessionRenewalContract.Response = ::defaultSessionResponse
    /** Keeps a session request unanswered, as a slow server would, while it stays current. */
    @Volatile var sessionHold = false

    const val RENEWED_ACCESS = "renewed-access-token"
    const val RENEWED_REFRESH = "fr1.renewed-refresh-token"

    /** A 200 of upgrade or refresh as the API returns it: a one-hour access, a one-year grant. */
    fun sessionPair(access: String = RENEWED_ACCESS, refresh: String = RENEWED_REFRESH,
        accessExpiry: Instant = Instant.now().plusSeconds(3_600)): SessionRenewalContract.Response {
        fun utc(at: Instant) = at.truncatedTo(ChronoUnit.SECONDS).toString()
        return SessionRenewalContract.Response(200, "no-store", null, ("""{"access_token":"$access",""" +
            """"expires_at":"${utc(accessExpiry)}","refresh_token":"$refresh",""" +
            """"refresh_expires_at":"${utc(Instant.now().plus(365, ChronoUnit.DAYS))}"}""").toByteArray())
    }

    /** An error as the API writes it. */
    fun sessionAnswer(status: Int, error: String = "", retryAfter: String? = null) =
        SessionRenewalContract.Response(status, "no-store", retryAfter, """{"error":"$error","message":"m"}""".toByteArray())

    private fun defaultSessionResponse(path: String) = if (path == "v1/auth/logout") sessionAnswer(204) else sessionPair()

    const val RENEWED_OPENVPN_IDENTITY = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
    private const val PEM = "-----BEGIN CERTIFICATE-----\\ntest\\n-----END CERTIFICATE-----"

    /** A 201 as the API returns it for an IPv4 device. */
    fun renewedActivation(deviceId: String, address: String = "10.9.0.2/32"): Pair<Int, String> = 201 to """{"device_id":"$deviceId",
        "protocol":"openvpn","address":"$address","dns":["10.9.0.1"],"endpoint":"203.0.113.10",
        "server_name":"paris-01.openvpn.test","remote_cert_tls_server":true,"ca_certificate_pem":"$PEM",
        "certificate_pem":"$PEM","certificate_serial":"0b","not_after":"2099-01-01T00:00:00Z",
        "ciphers":["AES-256-GCM"],"tls_crypt_v2_client_key":"client-key"}"""
    /** SystemVpnResumeSentinel.sync decisions, in order (true = armed). */
    val sentinel: MutableList<Boolean> = Collections.synchronizedList(mutableListOf())
    /** VPN host starts the bridge itself requested (a process-restart restore). */
    @Volatile var hostStarts = 0
    /** SharedVpnHost.start throws this code, as a refused foreground start would. */
    @Volatile var hostStartFailure: String? = null

    fun reset() {
        notifications.clear(); locales.clear(); purges.clear()
        identityGate = null; identityFailure = null; resumeReadGate = null; publicKeyGate = null; readFailure = null
        purgeGate = null; readKeyMissing = false; readFailureOnce = null; writeFailure = null; publicKeyFailure = null
        wireGuardConnect = { true }; wireGuardConnectGate = null
        wireGuardConnects = 0; wireGuardStops = 0; wireGuardUp = false
        wireGuardStopResult = true; errorNotificationFailure = null
        wireGuardStopGate = null; tileProfileReadGate = null
        openVpnConnects = 0; openVpnReconnects = 0; openVpnStops = 0; openVpnNetworkLosses = 0
        openVpnStopResult = true
        openVpnReconnect = { true }; openVpnStartGate = null; openVpnService.clear()
        openVpnCertificate = "valid"; openVpnRenewalPending = false; openVpnIdentity = WireGuardController.IDENTITY
        openVpnCsrRequests = 0; openVpnConnect = { true }
        renewalRequests.clear(); renewalResponse = { renewedActivation(it) }; renewalHold = false
        sessionRequests.clear(); sessionPhysical.clear(); sessionResponse = ::defaultSessionResponse; sessionHold = false
        sentinel.clear(); hostStarts = 0; hostStartFailure = null
    }
}
