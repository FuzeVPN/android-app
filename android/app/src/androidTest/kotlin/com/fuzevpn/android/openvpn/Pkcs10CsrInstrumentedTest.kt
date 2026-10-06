package com.fuzevpn.android.openvpn

import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Base64
import androidx.test.ext.junit.runners.AndroidJUnit4
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.PrivateKey
import java.security.Signature
import java.security.interfaces.ECPublicKey
import java.security.spec.ECGenParameterSpec
import java.util.UUID
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class Pkcs10CsrInstrumentedTest {
    @Test
    fun createsVerifiableCnOnlyCsrWithANonExportableAndroidKeystoreKey() {
        val alias = "fuzevpn.test.csr.${UUID.randomUUID()}"
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        try {
            KeyPairGenerator.getInstance(
                KeyProperties.KEY_ALGORITHM_EC,
                "AndroidKeyStore",
            ).apply {
                initialize(
                    KeyGenParameterSpec.Builder(
                        alias,
                        KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY,
                    )
                        .setAlgorithmParameterSpec(ECGenParameterSpec("secp256r1"))
                        .setDigests(KeyProperties.DIGEST_SHA256)
                        .setUserAuthenticationRequired(false)
                        .build(),
                )
            }.generateKeyPair()
            val privateKey = keyStore.getKey(alias, null) as? PrivateKey
            val certificate = keyStore.getCertificate(alias)

            assertNotNull(privateKey)
            assertNotNull(certificate)
            val usablePrivateKey = requireNotNull(privateKey)
            val publicKey = requireNotNull(certificate).publicKey
            assertNull("Android Keystore private keys must not be exportable", usablePrivateKey.encoded)
            assertTrue(publicKey is ECPublicKey)

            val pem = Pkcs10Csr.create(publicKey, usablePrivateKey)
            assertTrue(pem.startsWith("-----BEGIN CERTIFICATE REQUEST-----\n"))
            assertTrue(pem.endsWith("-----END CERTIFICATE REQUEST-----\n"))

            val der = Base64.decode(
                pem.lineSequence().filterNot { it.startsWith("-----") }.joinToString(""),
                Base64.NO_WRAP,
            )
            val request = readDerElement(der, 0)
            assertEquals(0x30, request.tag)
            assertEquals(der.size, request.nextOffset)

            val certificationRequestInfo = readDerElement(request.content, 0)
            val algorithm = readDerElement(request.content, certificationRequestInfo.nextOffset)
            val signatureBits = readDerElement(request.content, algorithm.nextOffset)
            assertEquals(0x30, certificationRequestInfo.tag)
            assertEquals(0x30, algorithm.tag)
            assertEquals(0x03, signatureBits.tag)
            assertEquals(request.content.size, signatureBits.nextOffset)
            assertEquals(0, signatureBits.content.first().toInt())
            assertTrue(certificationRequestInfo.content.decodeToString().contains("FuzeVPN Android"))
            assertFalse(contains(der, SAN_EXTENSION_OID))

            val verifier = Signature.getInstance("SHA256withECDSA")
            verifier.initVerify(publicKey)
            verifier.update(certificationRequestInfo.encoded)
            assertTrue(verifier.verify(signatureBits.content.copyOfRange(1, signatureBits.content.size)))
        } finally {
            keyStore.deleteEntry(alias)
        }
    }

    private data class DerElement(
        val tag: Int,
        val content: ByteArray,
        val encoded: ByteArray,
        val nextOffset: Int,
    )

    private fun readDerElement(input: ByteArray, offset: Int): DerElement {
        require(offset + 2 <= input.size) { "truncated DER element" }
        val tag = input[offset].toInt() and 0xff
        var cursor = offset + 1
        val firstLengthByte = input[cursor++].toInt() and 0xff
        val contentLength = if (firstLengthByte and 0x80 == 0) {
            firstLengthByte
        } else {
            val lengthBytes = firstLengthByte and 0x7f
            require(lengthBytes in 1..4 && cursor + lengthBytes <= input.size) { "invalid DER length" }
            var value = 0
            repeat(lengthBytes) { value = (value shl 8) or (input[cursor++].toInt() and 0xff) }
            value
        }
        val contentStart = cursor
        val end = contentStart + contentLength
        require(end <= input.size) { "truncated DER content" }
        return DerElement(
            tag = tag,
            content = input.copyOfRange(contentStart, end),
            encoded = input.copyOfRange(offset, end),
            nextOffset = end,
        )
    }

    private fun contains(input: ByteArray, expected: ByteArray): Boolean =
        input.indices.any { start ->
            start + expected.size <= input.size && expected.indices.all { index ->
                input[start + index] == expected[index]
            }
        }

    private companion object {
        val SAN_EXTENSION_OID = byteArrayOf(0x06, 0x03, 0x55, 0x1d, 0x11)
    }
}
