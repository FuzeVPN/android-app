package com.fuzevpn.android

import org.junit.Assert.assertEquals
import org.junit.Test

class OpenVpnTunMtuTest {
    // COLD-RESTORE-ONLINE-06GB: through the OpenVPN tunnel, packets of 1432
    // bytes and above vanished without any ICMP reply. With a 1500-byte TUN,
    // TCP sent 1400-byte segments, so Dart's 1474-byte TLS ClientHello never
    // reached the API and every in-tunnel request failed after about 16 s.
    @Test fun defaultAndLargePushedMtuAreCappedSoTcpSegmentsFitTheTunnel() {
        assertEquals(1400, OpenVpnService.tunMtu(1500))
        assertEquals(1400, OpenVpnService.tunMtu(9000))
    }

    @Test fun smallerPushedMtuIsKept() {
        assertEquals(1380, OpenVpnService.tunMtu(1380))
        assertEquals(1280, OpenVpnService.tunMtu(1280))
        assertEquals(576, OpenVpnService.tunMtu(576))
    }
}
