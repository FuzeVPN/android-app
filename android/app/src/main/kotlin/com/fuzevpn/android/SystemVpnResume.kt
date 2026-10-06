package com.fuzevpn.android

import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.time.Instant
import org.json.JSONObject

/**
 * Durable, encrypted-at-rest resume intent for Android's system VPN lifecycle.
 *
 * The owner supplies storage functions so this class has no storage slot or
 * service dependency.  A reader returning null means the record is absent;
 * malformed data is never silently deleted because treating corruption as an
 * empty record could re-admit an unsafe restart.
 */
internal class SystemVpnResumeRegistry(
    private val readRaw: () -> String?,
    private val writeRaw: (String) -> Unit,
    private val now: () -> Instant = { Instant.now() },
) {
    /**
     * This is deliberately an instance-local write acknowledgement, not a
     * representation of the durable record.  It only avoids writing the same
     * tombstone twice while no operation in this instance has observed or
     * attempted to change that state.
     */
    private var confirmedInvalidation = false

    @Synchronized
    fun snapshot(): SystemVpnResumeRecord? {
        val raw = try {
            readRaw()
        } catch (error: Throwable) {
            confirmedInvalidation = false
            throw error
        }
        if (raw == invalidatedTombstone()) return null

        // A missing, replaced, or malformed value is not evidence that this
        // instance's previous tombstone still exists. Missing is fail-closed,
        // but must not authorize a later skipped tombstone write.
        confirmedInvalidation = false
        if (raw == null) return null
        return SystemVpnResumeRecord.decode(raw)
            ?: throw SystemVpnResumeException("system_vpn_resume_corrupt")
    }

    /** Publish a new restart intent only after a native CONNECTED proof. */
    @Synchronized
    fun arm(
        profile: QuickTileProfile,
        sessionPayload: String,
        identityFingerprint: String,
        recoveryConsumed: Boolean = false,
    ): SystemVpnResumeRecord {
        confirmedInvalidation = false
        val session = requireValidSession(sessionPayload)
        requireFingerprint(identityFingerprint, "system_vpn_resume_identity_invalid")
        val payload = profile.encode()
        val record = SystemVpnResumeRecord(
            profilePayload = payload,
            sessionFingerprint = session.fingerprint,
            profileFingerprint = sha256Hex(payload),
            identityFingerprint = identityFingerprint,
            recoveryConsumed = recoveryConsumed,
            status = SystemVpnResumeStatus.READY,
            errorCode = null,
        )
        writeRaw(record.encode())
        return record
    }

    /** Atomically claim READY before starting a system-originated tunnel. */
    @Synchronized
    fun reserve(sessionPayload: String, identityFingerprint: String): SystemVpnResumeRecord? {
        confirmedInvalidation = false
        val current = readRecord() ?: return null
        if (current.status != SystemVpnResumeStatus.READY ||
            !matchesCurrentSession(current, sessionPayload, identityFingerprint)
        ) return null
        val reserved = current.copy(status = SystemVpnResumeStatus.RESERVED, errorCode = null)
        writeRaw(reserved.encode())
        return reserved
    }

    /** Re-arm a successfully completed system start for a later process loss. */
    @Synchronized
    fun complete(sessionPayload: String, identityFingerprint: String): SystemVpnResumeRecord? {
        confirmedInvalidation = false
        val current = readRecord() ?: return null
        if (current.status != SystemVpnResumeStatus.RESERVED ||
            !matchesCurrentSession(current, sessionPayload, identityFingerprint)
        ) return null
        val ready = current.copy(status = SystemVpnResumeStatus.READY, errorCode = null)
        writeRaw(ready.encode())
        return ready
    }

    /** Replace only the session revision of a previously proven tunnel.
     * The owner commits the token and encoded record together; no storage
     * acknowledgement or new CONNECTED proof is invented by this registry. */
    @Synchronized
    fun renewSession(
        oldSessionPayload: String,
        newSessionPayload: String,
        provenProfile: QuickTileProfile?,
        provenIdentityFingerprint: String?,
        commit: (String) -> Unit,
    ): Boolean {
        confirmedInvalidation = false
        val renewedSession = requireValidSession(newSessionPayload)
        // An API renewal may arrive just after expiry. The previous payload
        // still has to be structurally valid and match the exact durable digest.
        val previousSession = validateSystemVpnSessionPayload(oldSessionPayload, Instant.MIN)
            ?: throw SystemVpnResumeException("system_vpn_resume_session_invalid")
        val current = readRecord()
        val renewed = current?.takeIf {
            it.status == SystemVpnResumeStatus.READY &&
                provenProfile != null && it.profile == provenProfile &&
                provenIdentityFingerprint == it.identityFingerprint &&
                previousSession.fingerprint == it.sessionFingerprint
        }?.copy(sessionFingerprint = renewedSession.fingerprint)
        commit(renewed?.encode() ?: invalidatedTombstone())
        confirmedInvalidation = renewed == null
        return renewed != null
    }

    /** A failed local start remains fail-closed until a new explicit connection arms it. */
    @Synchronized
    fun block(errorCode: String): SystemVpnResumeRecord? {
        confirmedInvalidation = false
        requireErrorCode(errorCode)
        val current = readRecord() ?: return null
        if (current.status == SystemVpnResumeStatus.INVALIDATED) return current
        val blocked = current.copy(status = SystemVpnResumeStatus.BLOCKED, errorCode = errorCode)
        writeRaw(blocked.encode())
        return blocked
    }

    /**
     * Persist the OpenVPN automatic-recovery budget before a restart begins.
     * It is deliberately never reset here: only [arm] after a new explicit,
     * proven connection may reset it.
     */
    @Synchronized
    fun consumeRecovery(sessionPayload: String, identityFingerprint: String): SystemVpnResumeRecord? {
        confirmedInvalidation = false
        val current = readRecord() ?: return null
        if (current.status !in setOf(SystemVpnResumeStatus.READY, SystemVpnResumeStatus.RESERVED) ||
            current.recoveryConsumed || !matchesCurrentSession(current, sessionPayload, identityFingerprint) ||
            current.profile.protocol != VpnProtocol.OPENVPN
        ) return null
        val consumed = current.copy(recoveryConsumed = true)
        writeRaw(consumed.encode())
        return consumed
    }

    /**
     * Write an unusable tombstone rather than deleting the record.  This makes
     * an interrupted logout/manual stop unable to look like an unconfigured
     * record to a later system service process.
     */
    @Synchronized
    fun invalidate() {
        if (confirmedInvalidation) return
        // Do not read first: a corrupt encrypted record must remain fail-closed
        // during restoration, but an explicit stop/logout still needs a way to
        // durably make it unusable and let a later explicit connection replace it.
        try {
            writeRaw(invalidatedTombstone())
            confirmedInvalidation = true
        } catch (error: Throwable) {
            confirmedInvalidation = false
            throw error
        }
    }

    private fun matchesCurrentSession(
        record: SystemVpnResumeRecord,
        sessionPayload: String,
        identityFingerprint: String,
    ): Boolean {
        val session = validateSystemVpnSessionPayload(sessionPayload, now()) ?: return false
        return session.fingerprint == record.sessionFingerprint &&
            identityFingerprint == record.identityFingerprint
    }

    private fun requireValidSession(sessionPayload: String): SystemVpnResumeSession =
        validateSystemVpnSessionPayload(sessionPayload, now())
            ?: throw SystemVpnResumeException("system_vpn_resume_session_invalid")

    private fun readRecord(): SystemVpnResumeRecord? {
        val raw = readRaw() ?: return null
        if (raw == invalidatedTombstone()) return null
        return SystemVpnResumeRecord.decode(raw)
            ?: throw SystemVpnResumeException("system_vpn_resume_corrupt")
    }

    private fun invalidatedTombstone(): String = JSONObject().apply {
        put("version", SystemVpnResumeRecord.FORMAT_VERSION)
        put("status", SystemVpnResumeStatus.INVALIDATED.wireValue)
    }.toString()

}

/** No raw token is returned: callers receive only an expiry and payload digest. */
internal data class SystemVpnResumeSession(
    val fingerprint: String,
    val expiresAt: Instant,
)

internal fun validateSystemVpnSessionPayload(
    payload: String,
    now: Instant = Instant.now(),
): SystemVpnResumeSession? = runCatching {
    require(payload.length in 2..MAX_SESSION_PAYLOAD_CHARS)
    val root = JSONObject(payload)
    require(root.length() == 2)
    require(root.has("access_token") && root.has("expires_at"))
    val token = root.get("access_token") as? String ?: error("invalid_token")
    require(token.isNotBlank() && token.length <= MAX_TOKEN_CHARS)
    require(token.none(Char::isISOControl))
    val expiryText = root.get("expires_at") as? String ?: error("invalid_expiry")
    require(expiryText.length in 1..MAX_EXPIRY_CHARS)
    val expiresAt = Instant.parse(expiryText)
    require(expiresAt.isAfter(now))
    SystemVpnResumeSession(sha256Hex(payload), expiresAt)
}.getOrNull()

internal enum class SystemVpnResumeStatus(internal val wireValue: String) {
    READY("ready"),
    RESERVED("reserved"),
    BLOCKED("blocked"),
    INVALIDATED("invalidated"),
    ;

    companion object {
        fun fromWireValue(value: String?): SystemVpnResumeStatus? =
            entries.firstOrNull { it.wireValue == value }
    }
}

/** Strictly decoded durable record.  `profilePayload` contains no token or private key. */
internal data class SystemVpnResumeRecord(
    val profilePayload: String,
    val sessionFingerprint: String,
    val profileFingerprint: String,
    val identityFingerprint: String,
    val recoveryConsumed: Boolean,
    val status: SystemVpnResumeStatus,
    val errorCode: String?,
    val version: Int = FORMAT_VERSION,
) {
    val profile: QuickTileProfile
        get() = QuickTileProfile.decode(profilePayload)
            ?: throw SystemVpnResumeException("system_vpn_resume_corrupt")

    val isResumable: Boolean get() = status == SystemVpnResumeStatus.READY

    fun encode(): String = JSONObject().apply {
        put("version", version)
        put("status", status.wireValue)
        put("profile_payload", profilePayload)
        put("session_fingerprint", sessionFingerprint)
        put("profile_fingerprint", profileFingerprint)
        put("identity_fingerprint", identityFingerprint)
        put("recovery_consumed", recoveryConsumed)
        put("error_code", errorCode ?: JSONObject.NULL)
    }.toString()

    companion object {
        const val FORMAT_VERSION = 1
        private val expectedFields = setOf(
            "version", "status", "profile_payload", "session_fingerprint",
            "profile_fingerprint", "identity_fingerprint", "recovery_consumed", "error_code",
        )

        fun decode(raw: String): SystemVpnResumeRecord? = runCatching {
            require(raw.length in 2..MAX_RECORD_CHARS)
            val root = JSONObject(raw)
            val fieldNames = buildSet {
                val iterator = root.keys()
                while (iterator.hasNext()) add(iterator.next())
            }
            require(root.length() == expectedFields.size && fieldNames == expectedFields)
            require(root.get("version") is Int && root.getInt("version") == FORMAT_VERSION)
            val status = SystemVpnResumeStatus.fromWireValue(root.get("status") as? String)
                ?: error("invalid_status")
            val profilePayload = root.get("profile_payload") as? String ?: error("invalid_profile")
            require(profilePayload.length in 2..MAX_PROFILE_PAYLOAD_CHARS)
            require(QuickTileProfile.decode(profilePayload) != null)
            val sessionFingerprint = root.get("session_fingerprint") as? String ?: error("invalid_session")
            val profileFingerprint = root.get("profile_fingerprint") as? String ?: error("invalid_profile")
            val identityFingerprint = root.get("identity_fingerprint") as? String ?: error("invalid_identity")
            requireFingerprint(sessionFingerprint, "system_vpn_resume_corrupt")
            requireFingerprint(profileFingerprint, "system_vpn_resume_corrupt")
            requireFingerprint(identityFingerprint, "system_vpn_resume_corrupt")
            require(sha256Hex(profilePayload) == profileFingerprint)
            val recoveryConsumed = root.get("recovery_consumed") as? Boolean
                ?: error("invalid_recovery")
            val rawError = root.get("error_code")
            val errorCode = when (rawError) {
                JSONObject.NULL -> null
                is String -> rawError.also(::requireErrorCode)
                else -> error("invalid_error")
            }
            when (status) {
                SystemVpnResumeStatus.READY, SystemVpnResumeStatus.RESERVED -> require(errorCode == null)
                SystemVpnResumeStatus.BLOCKED, SystemVpnResumeStatus.INVALIDATED -> require(errorCode != null)
            }
            SystemVpnResumeRecord(
                profilePayload = profilePayload,
                sessionFingerprint = sessionFingerprint,
                profileFingerprint = profileFingerprint,
                identityFingerprint = identityFingerprint,
                recoveryConsumed = recoveryConsumed,
                status = status,
                errorCode = errorCode,
            )
        }.getOrNull()
    }
}

internal class SystemVpnResumeException(val code: String) : IllegalStateException(code)

private fun sha256Hex(value: String): String = MessageDigest.getInstance("SHA-256")
    .digest(value.toByteArray(StandardCharsets.UTF_8))
    .joinToString("") { byte -> "%02x".format(byte) }

private fun requireFingerprint(value: String, errorCode: String) {
    if (!FINGERPRINT.matches(value)) throw SystemVpnResumeException(errorCode)
}

private fun requireErrorCode(value: String) {
    if (!ERROR_CODE.matches(value)) throw SystemVpnResumeException("system_vpn_resume_error_invalid")
}

private const val MAX_SESSION_PAYLOAD_CHARS = 8_192
private const val MAX_TOKEN_CHARS = 4_096
private const val MAX_EXPIRY_CHARS = 64
private const val MAX_PROFILE_PAYLOAD_CHARS = 16_384
private const val MAX_RECORD_CHARS = 32_768
private val FINGERPRINT = Regex("[a-f0-9]{64}")
private val ERROR_CODE = Regex("[a-z0-9_]{1,96}")
