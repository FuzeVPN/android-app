package com.fuzevpn.android

import org.junit.Assert.*
import org.junit.Test

class DiagnosticSnapshotTest {
    @Test fun projectsOnlyObservedCountersAndSafeStateWithoutIdentity() {
        val state = VpnState(
            status = VpnStatus.CONNECTED, protocol = VpnProtocol.WIREGUARD,
            connectedAtMillis = 1_000L, receivedBytes = 0L, sentBytes = 23L,
            latestHandshakeMillis = 2_000L, ipFamilies = listOf("ipv4", "ipv6"),
            locationId = "synthetic-location", locationName = "private-location-name",
            systemProtection = mapOf("always_on" to false, "lockdown" to true, "resume_state" to "ready",
                "account_id" to "synthetic-account", "resume_error" to "private-free-text"),
        )
        assertEquals(mapOf(
            "status" to "connected", "protocol" to "wireguard", "connected_at" to 1_000L,
            "received_bytes" to 0L, "sent_bytes" to 23L, "latest_handshake" to 2_000L,
            "ip_families" to listOf("ipv4", "ipv6"),
            "system_protection" to mapOf("always_on" to false, "lockdown" to true, "resume_state" to "ready"),
        ), DiagnosticSnapshot.fromState(state))
        assertEquals("private-location-name", state.locationName)
    }

    @Test fun absentProtectionAndMetricsStayUnknownRatherThanFalseOrZero() {
        val state = VpnState(status = VpnStatus.ERROR, messageCode = "unsafe exception path /private",
            receivedBytes = -1L, sentBytes = -2L, latestHandshakeMillis = -1L,
            systemProtection = mapOf("always_on" to "false", "lockdown" to null, "resume_state" to "private-text"))
        assertEquals(mapOf("status" to "error", "system_protection" to emptyMap<String, Any>()),
            DiagnosticSnapshot.fromState(state))
    }

    @Test fun machineErrorAndRecoveryRemainSafeEnums() {
        val state = VpnState(status = VpnStatus.CONNECTING, protocol = VpnProtocol.OPENVPN,
            messageCode = "openvpn_reconnecting", ipFamilies = listOf("ipv4"),
            systemProtection = mapOf("resume_state" to "restoring"))
        assertEquals(mapOf("status" to "connecting", "protocol" to "openvpn",
            "message_code" to "openvpn_reconnecting", "system_protection" to mapOf("resume_state" to "restoring")),
            DiagnosticSnapshot.fromState(state))
    }
}
