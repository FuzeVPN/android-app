package com.fuzevpn.android.openvpn

import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import java.time.Instant

class CurrentOpenVpnConnectionIdentityTest {
    private val now = Instant.parse("2026-09-09T12:00:00Z")
    private val identity = CurrentOpenVpnConnectionIdentity(
        accountId = "account",
        deviceId = "device",
        identityAlias = "alias",
        identityGeneration = "a",
        nativeGeneration = 7L,
        certificateNotAfter = now.plusSeconds(3_600),
        fingerprint = "fingerprint",
        confirmed = true,
    )

    @Test fun usableOnlyForTheConfirmedActiveIdentity() {
        assertTrue(identity.isUsable(
            "account", "device", "alias", "a", 7L, true, false, now, 60,
        ))
    }

    @Test fun rejectsStaleOrUnprovenContexts() {
        val contexts = listOf(
            arrayOf<Any>("other", "device", "alias", "a", 7L, true, false),
            arrayOf<Any>("account", "other", "alias", "a", 7L, true, false),
            arrayOf<Any>("account", "device", "other", "a", 7L, true, false),
            arrayOf<Any>("account", "device", "alias", "b", 7L, true, false),
            arrayOf<Any>("account", "device", "alias", "a", 8L, true, false),
            arrayOf<Any>("account", "device", "alias", "a", 7L, false, false),
            arrayOf<Any>("account", "device", "alias", "a", 7L, true, true),
        )
        contexts.forEach { context ->
            assertFalse(identity.isUsable(
                context[0] as String, context[1] as String, context[2] as String, context[3] as String,
                context[4] as Long, context[5] as Boolean, context[6] as Boolean, now, 60,
            ))
        }
        assertFalse(identity.copy(confirmed = false).isUsable(
            "account", "device", "alias", "a", 7L, true, false, now, 60,
        ))
        assertFalse(identity.copy(persisted = false).isUsable(
            "account", "device", "alias", "a", 7L, true, false, now, 60,
        ))
    }

    @Test fun rejectsExpiredAndRenewalWindowCertificates() {
        assertFalse(identity.copy(certificateNotAfter = now).isUsable(
            "account", "device", "alias", "a", 7L, true, false, now, 60,
        ))
        assertFalse(identity.copy(certificateNotAfter = now.plusSeconds(60)).isUsable(
            "account", "device", "alias", "a", 7L, true, false, now, 60,
        ))
    }
}
