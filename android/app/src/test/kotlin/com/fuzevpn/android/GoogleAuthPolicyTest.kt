package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class GoogleAuthPolicyTest {
    private val clientId = "123456789-fixture.apps.googleusercontent.com"
    private val nonce = "nonce-fixture-private-value"
    private fun selection() = mapOf("requestId" to "request-fixture", "serverClientId" to clientId, "nonce" to nonce)

    @Test fun requiresOnlyTheExplicitSelectionAndBackendAudience() {
        val selected = GoogleAuthPolicy.signIn(selection())
        assertEquals("request-fixture", selected.requestId)
        assertEquals(clientId, selected.serverClientId)
        assertEquals(nonce, selected.nonce)
        assertFalse(selected.toString().contains(nonce))
        assertFalse(selected.toString().contains(clientId))
        for (invalid in listOf(
            selection() + ("autoSelect" to true),
            selection() + ("idToken" to "private-token-fixture"),
            selection() - "nonce",
            selection() + ("serverClientId" to "123-fixture.android.googleusercontent.com"),
            selection() + ("requestId" to "person@example.test"),
            selection() + ("nonce" to ""),
            selection() + ("nonce" to "private\nnonce"),
            selection() + ("nonce" to "n".repeat(1025)),
        )) {
            val error = assertThrows(GoogleAuthException::class.java) { GoogleAuthPolicy.signIn(invalid) }
            assertEquals("invalid_request", error.code)
            assertEquals("invalid_request", error.message)
        }
    }

    @Test fun cancellationCannotCarryAccountDataOrOtherArguments() {
        assertEquals("request-fixture", GoogleAuthPolicy.cancellation(mapOf("requestId" to "request-fixture")))
        assertThrows(GoogleAuthException::class.java) { GoogleAuthPolicy.cancellation(mapOf("requestId" to "request-fixture", "email" to "person@example.test")) }
        assertThrows(GoogleAuthException::class.java) { GoogleAuthPolicy.cancellation(mapOf("requestId" to "")) }
        assertThrows(GoogleAuthException::class.java) { GoogleAuthPolicy.noArguments(emptyMap<String, String>()) }
        GoogleAuthPolicy.noArguments(null)
    }

    @Test fun providerErrorsAndMalformedTokenErrorsNeverExposeTheirInput() {
        val secret = "lowercaseprivatetokenfixture"
        val error = GoogleAuthException(secret)
        assertEquals("provider_error", error.code)
        assertEquals("provider_error", error.message)
        assertFalse(error.toString().contains(secret))
        for (token in listOf("", "$secret\n", "t".repeat(65537))) {
            val invalid = assertThrows(GoogleAuthException::class.java) { GoogleAuthPolicy.token(token) }
            assertEquals("invalid_response", invalid.message)
        }
        assertEquals(secret, GoogleAuthPolicy.token(secret))
    }

    @Test fun onlyOnePickerCanOwnTheFlow() {
        val gate = GoogleAuthFlowGate()
        val first = gate.reserve("one")
        assertEquals("busy", assertThrows(GoogleAuthException::class.java) { gate.reserve("two") }.code)
        assertNull(gate.cancel("two"))
        assertTrue(gate.isCurrent(first))
        assertTrue(gate.finish(first))
        assertFalse(gate.finish(first))
        assertTrue(gate.isCurrent(gate.reserve("two")))
    }

    @Test fun oldCallbackCannotCompleteARetryWithTheSameRequestId() {
        val gate = GoogleAuthFlowGate()
        val first = gate.reserve("same")
        assertSame(first, gate.cancel("same"))
        val second = gate.reserve("same")
        assertFalse(gate.isCurrent(first))
        assertFalse(gate.finish(first))
        assertTrue(gate.isCurrent(second))
        assertTrue(gate.finish(second))
    }

    @Test fun closePermanentlyInvalidatesPendingCallbacksAndLaunches() {
        val gate = GoogleAuthFlowGate()
        val ticket = gate.reserve("one")
        assertSame(ticket, gate.close())
        assertFalse(gate.finish(ticket))
        assertNull(gate.close())
        assertEquals("unavailable", assertThrows(GoogleAuthException::class.java) { gate.reserve("two") }.code)
    }

    @Test fun credentialStateClearCannotBeCancelledByAPickerRequestId() {
        val gate = GoogleAuthFlowGate()
        val clear = gate.reserve(null)
        assertNull(gate.cancel("previous-request"))
        assertEquals("busy", assertThrows(GoogleAuthException::class.java) { gate.reserve("one") }.code)
        assertTrue(gate.finish(clear))
    }
}
