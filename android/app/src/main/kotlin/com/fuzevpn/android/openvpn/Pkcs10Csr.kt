package com.fuzevpn.android.openvpn

import android.util.Base64
import java.io.ByteArrayOutputStream
import java.nio.charset.StandardCharsets
import java.security.PrivateKey
import java.security.PublicKey
import java.security.Signature

/** Minimal PKCS#10 DER writer: P-256 / SHA-256, CN only, and never a SAN. */
internal object Pkcs10Csr {
    private const val COMMON_NAME = "FuzeVPN Android"

    fun create(publicKey: PublicKey, privateKey: PrivateKey): String {
        val certificationRequestInfo = sequence(
            integerZero(),
            subject(COMMON_NAME),
            publicKey.encoded,
            tagged(0xa0, byteArrayOf()), // [0] IMPLICIT Attributes, empty.
        )
        val signature = Signature.getInstance("SHA256withECDSA").run {
            initSign(privateKey)
            update(certificationRequestInfo)
            sign()
        }
        val certificationRequest = sequence(
            certificationRequestInfo,
            sequence(objectIdentifier("1.2.840.10045.4.3.2")),
            bitString(signature),
        )
        val base64 = Base64.encodeToString(certificationRequest, Base64.NO_WRAP)
        return buildString(base64.length + 96) {
            append("-----BEGIN CERTIFICATE REQUEST-----\n")
            base64.chunked(64).forEach { append(it).append('\n') }
            append("-----END CERTIFICATE REQUEST-----\n")
        }
    }

    private fun subject(commonName: String): ByteArray = sequence(
        set(sequence(objectIdentifier("2.5.4.3"), utf8String(commonName))),
    )

    private fun integerZero(): ByteArray = byteArrayOf(0x02, 0x01, 0x00)

    private fun utf8String(value: String): ByteArray = tagged(0x0c, value.toByteArray(StandardCharsets.UTF_8))

    private fun bitString(value: ByteArray): ByteArray = tagged(0x03, byteArrayOf(0) + value)

    private fun set(value: ByteArray): ByteArray = tagged(0x31, value)

    private fun sequence(vararg values: ByteArray): ByteArray = tagged(0x30, values.fold(ByteArrayOutputStream()) { output, value ->
        output.write(value)
        output
    }.toByteArray())

    private fun tagged(tag: Int, content: ByteArray): ByteArray = ByteArrayOutputStream(content.size + 6).use { output ->
        output.write(tag)
        writeLength(output, content.size)
        output.write(content)
        output.toByteArray()
    }

    private fun writeLength(output: ByteArrayOutputStream, length: Int) {
        require(length >= 0)
        when {
            length < 0x80 -> output.write(length)
            length <= 0xff -> {
                output.write(0x81)
                output.write(length)
            }
            length <= 0xffff -> {
                output.write(0x82)
                output.write(length ushr 8)
                output.write(length)
            }
            else -> throw IllegalArgumentException("der_too_large")
        }
    }

    private fun objectIdentifier(value: String): ByteArray {
        val parts = value.split('.').map { it.toLongOrNull() ?: throw IllegalArgumentException("invalid_oid") }
        require(parts.size >= 2 && parts[0] in 0L..2L && (parts[0] == 2L || parts[1] in 0L..39L))
        val body = ByteArrayOutputStream()
        fun writeBase128(arc: Long) {
            require(arc >= 0)
            val encoded = ArrayDeque<Int>()
            var remaining = arc
            encoded.addFirst((remaining and 0x7f).toInt())
            remaining = remaining ushr 7
            while (remaining > 0) {
                encoded.addFirst(((remaining and 0x7f) or 0x80).toInt())
                remaining = remaining ushr 7
            }
            encoded.forEach(body::write)
        }
        writeBase128(parts[0] * 40 + parts[1])
        parts.drop(2).forEach(::writeBase128)
        return tagged(0x06, body.toByteArray())
    }
}
