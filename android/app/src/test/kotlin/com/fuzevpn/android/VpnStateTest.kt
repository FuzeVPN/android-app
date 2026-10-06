package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Test

class VpnStateTest {
    @Test
    fun serializesTheCompleteChannelContract() {
        val state = VpnState(
            status = VpnStatus.ERROR,
            protocol = VpnProtocol.OPENVPN,
            messageCode = "certificate_validation_failed",
            connectedAtMillis = 1_726_000_000L,
            locationId = "frankfurt-01",
            locationName = "Frankfurt 01",
            receivedBytes = 1_024L,
            sentBytes = 2_048L,
            latestHandshakeMillis = 1_726_000_100L,
            timestampMillis = 1_726_000_123L,
        )

        assertEquals(
            mapOf(
                "status" to "error",
                "protocol" to "openvpn",
                "message_code" to "certificate_validation_failed",
                "connected_at" to 1_726_000_000L,
                "location_id" to "frankfurt-01",
                "location_name" to "Frankfurt 01",
                "received_bytes" to 1_024L,
                "sent_bytes" to 2_048L,
                "latest_handshake" to 1_726_000_100L,
                "timestamp" to 1_726_000_123L,
                "system_protection" to emptyMap<String, Any?>(),
            ),
            state.toChannelMap(),
        )
    }

    @Test
    fun omitsOptionalFieldsWithoutSerializingNulls() {
        val values = VpnState(timestampMillis = 42L).toChannelMap()

        assertEquals("idle", values["status"])
        assertEquals(42L, values["timestamp"])
        assertFalse(values.containsKey("protocol"))
        assertFalse(values.containsKey("message_code"))
        assertFalse(values.containsKey("connected_at"))
        assertFalse(values.containsKey("received_bytes"))
        assertNull(VpnProtocol.fromWireValue("unknown"))
        assertEquals(VpnProtocol.WIREGUARD, VpnProtocol.fromWireValue("wireguard"))
    }

    @Test fun firstFailedStatisticsReadDoesNotPublishInventedZeroCounters() {
        val state = VpnState(status = VpnStatus.CONNECTED).withTunnelStatistics(null)
        assertNull(state.receivedBytes)
        assertNull(state.sentBytes)
        assertFalse(state.toChannelMap().containsKey("received_bytes"))
        assertFalse(state.toChannelMap().containsKey("sent_bytes"))
    }

    @Test fun failedStatisticsReadRetainsTheLastSuccessfulSample() {
        val state = VpnState(status = VpnStatus.CONNECTED)
            .withTunnelStatistics(TunnelStatistics(1024L, 2048L, 100L))
            .withTunnelStatistics(null)
        assertEquals(1024L, state.receivedBytes)
        assertEquals(2048L, state.sentBytes)
        assertEquals(100L, state.latestHandshakeMillis)
    }

    @Test fun validZeroCountersRemainDistinctFromMissingStatistics() {
        val state = VpnState(status = VpnStatus.CONNECTED)
            .withTunnelStatistics(TunnelStatistics(1024L, 2048L, 100L))
            .withTunnelStatistics(TunnelStatistics())
        assertEquals(0L, state.toChannelMap()["received_bytes"])
        assertEquals(0L, state.toChannelMap()["sent_bytes"])
        assertNull(state.latestHandshakeMillis)
    }
}
