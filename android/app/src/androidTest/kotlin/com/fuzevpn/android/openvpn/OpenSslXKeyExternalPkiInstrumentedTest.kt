package com.fuzevpn.android.openvpn

import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import androidx.test.ext.junit.runners.AndroidJUnit4
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.MessageDigest
import java.security.Signature
import java.security.spec.ECGenParameterSpec
import java.util.UUID
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Exercises both official OpenVPN 3 OpenSSL XKey callback contracts with a
 * real, non-exportable Android Keystore P-256 key.
 */
@RunWith(AndroidJUnit4::class)
class OpenSslXKeyExternalPkiInstrumentedTest {
    @Test
    fun signsPrecomputedDigestForXKeySign() = withTestKey { entry ->
        val digest = MessageDigest.getInstance("SHA-256")
            .digest("fuzevpn-xkey-sign".toByteArray())
        try {
            assertSignature(
                algorithm = "NONEwithECDSA",
                payload = digest,
                entry = entry,
            )
        } finally {
            digest.fill(0)
        }
    }

    @Test
    fun hashesAndSignsMessageForXKeyDigestSign() = withTestKey { entry ->
        val message = "fuzevpn-xkey-digest-sign".toByteArray()
        try {
            assertSignature(
                algorithm = "SHA256withECDSA",
                payload = message,
                entry = entry,
            )
        } finally {
            message.fill(0)
        }
    }

    private fun withTestKey(block: (KeyStore.PrivateKeyEntry) -> Unit) {
        val alias = "fuzevpn-openssl-xkey-test-${UUID.randomUUID()}"
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        try {
            val generator = KeyPairGenerator.getInstance(
                KeyProperties.KEY_ALGORITHM_EC,
                "AndroidKeyStore",
            )
            generator.initialize(
                KeyGenParameterSpec.Builder(
                    alias,
                    KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY,
                )
                    .setAlgorithmParameterSpec(ECGenParameterSpec("secp256r1"))
                    .setDigests(
                        KeyProperties.DIGEST_NONE,
                        KeyProperties.DIGEST_SHA256,
                        KeyProperties.DIGEST_SHA384,
                        KeyProperties.DIGEST_SHA512,
                    )
                    .setUserAuthenticationRequired(false)
                    .build(),
            )
            generator.generateKeyPair()

            val entry = keyStore.getEntry(alias, null) as KeyStore.PrivateKeyEntry
            assertNotNull(entry.certificate.publicKey)
            assertNull("The P-256 private key must remain non-exportable", entry.privateKey.encoded)
            block(entry)
        } finally {
            keyStore.deleteEntry(alias)
        }
    }

    private fun assertSignature(
        algorithm: String,
        payload: ByteArray,
        entry: KeyStore.PrivateKeyEntry,
    ) {
        val signer = Signature.getInstance(algorithm)
        signer.initSign(entry.privateKey)
        signer.update(payload)
        val signature = signer.sign()
        assertTrue("Android must return an ASN.1 DER ECDSA signature", signature.size > 8)
        assertTrue("DER ECDSA signatures are ASN.1 sequences", signature[0].toInt() == 0x30)

        val verifier = Signature.getInstance(algorithm)
        verifier.initVerify(entry.certificate.publicKey)
        verifier.update(payload)
        assertTrue("The Keystore signature must verify", verifier.verify(signature))

        signature[signature.lastIndex] = (signature.last().toInt() xor 0x01).toByte()
        verifier.initVerify(entry.certificate.publicKey)
        verifier.update(payload)
        assertFalse("A modified signature must be rejected", verifier.verify(signature))
    }
}
