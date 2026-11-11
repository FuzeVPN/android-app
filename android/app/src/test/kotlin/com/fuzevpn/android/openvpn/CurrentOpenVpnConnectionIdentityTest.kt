package com.fuzevpn.android.openvpn

import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.File

class CurrentOpenVpnConnectionIdentityTest {
    private val identity = CurrentOpenVpnConnectionIdentity(
        accountId = "account",
        deviceId = "device",
        identityAlias = "alias",
        identityGeneration = "a",
        nativeGeneration = 7L,
        fingerprint = "fingerprint",
        confirmed = true,
    )

    @Test fun usableOnlyForTheConfirmedActiveIdentity() {
        assertTrue(identity.isUsable(
            "account", "device", "alias", "a", 7L, true, false,
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
                context[4] as Long, context[5] as Boolean, context[6] as Boolean,
            ))
        }
        assertFalse(identity.copy(confirmed = false).isUsable(
            "account", "device", "alias", "a", 7L, true, false,
        ))
        assertFalse(identity.copy(persisted = false).isUsable(
            "account", "device", "alias", "a", 7L, true, false,
        ))
    }

    // A certificate inside its renewal window, or expired while its tunnel stays up, still proves
    // the connected identity: refusing it here dropped the system resume record (and with it the
    // recovery that now renews) as soon as a guest session was replaced. The controller cannot be
    // built on the JVM (Android Keystore), so the two identity proofs are pinned in its source.
    @Test fun theIdentityProofsNoLongerDependOnTheCertificateLifetime() {
        val controller = listOf("src/main/kotlin", "android/app/src/main/kotlin")
            .map { File(it, "com/fuzevpn/android/openvpn/OpenVpnController.kt") }
            .first { it.isFile }
            .readText().replace("\r\n", "\n")
        for (proof in listOf("fun existingIdentityFingerprint(", "fun currentConnectionIdentityFingerprint(")) {
            val start = controller.indexOf(proof)
            val body = controller.substring(start, controller.indexOf("\n    }\n", start))
            assertTrue(proof, start >= 0)
            for (refusal in listOf("openvpn_renewal_required", "openvpn_certificate_expired", "RENEWAL_WINDOW_SECONDS",
                "pendingGeneration(")) {
                assertFalse("$proof still refuses with $refusal", body.contains(refusal))
            }
        }
        // The local restart itself still refuses a certificate that is due: its callers renew first.
        val restart = controller.substring(controller.indexOf("suspend fun reconnectLocal("),
            controller.indexOf("suspend fun disconnect("))
        assertTrue(restart.contains("OpenVpnRecoveryAttempt.profileFailure(certificate.status, certificate.renewalPending)"))
        assertTrue(restart.contains("failed(\"openvpn_renewal_required\")"))
    }
}
