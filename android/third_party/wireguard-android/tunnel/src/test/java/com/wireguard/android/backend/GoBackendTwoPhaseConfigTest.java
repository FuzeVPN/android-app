package com.wireguard.android.backend;

import com.wireguard.config.Config;

import org.junit.Test;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class GoBackendTwoPhaseConfigTest {
    @Test
    public void peerPhaseCannotRebindProtectedSockets() throws Exception {
        final Config config;
        try (final InputStream input = Objects.requireNonNull(
                getClass().getClassLoader()).getResourceAsStream("working.conf")) {
            config = Config.parse(input);
        }
        final String bootstrap = config.getInterface().toWgUserspaceString();
        final String peers = GoBackend.peerConfig(config);

        assertFalse(bootstrap.contains("public_key="));
        assertFalse(peers.contains("private_key="));
        assertFalse(peers.contains("listen_port="));
        assertTrue(peers.startsWith("replace_peers=true\n"));
        assertTrue(peers.contains("public_key="));
    }

    @Test
    public void protectsBothSocketsBeforeInstallingPeers() {
        final Operations operations = new Operations(4, 6, true, true, false);
        final GoBackend.TwoPhaseResult result = GoBackend.activatePeersAfterProtection(9, "replace_peers=true\n", operations);

        assertTrue(result.activated);
        assertFalse(result.handleReleased);
        assertEquals(Arrays.asList("v4", "protect:4", "v6", "protect:6", "peers"), operations.calls);
    }

    @Test
    public void absentIpv6DoesNotBlockPeerInstallation() {
        final Operations operations = new Operations(4, -1, true, true, false);
        final GoBackend.TwoPhaseResult result = GoBackend.activatePeersAfterProtection(9, "peers", operations);

        assertTrue(result.activated);
        assertEquals(Arrays.asList("v4", "protect:4", "v6", "peers"), operations.calls);
    }

    @Test
    public void absentIpv4OrRejectedProtectionNeverInstallsPeers() {
        final Operations absentV4 = new Operations(-1, 6, true, true, false);
        final GoBackend.TwoPhaseResult absentResult = GoBackend.activatePeersAfterProtection(9, "peers", absentV4);
        assertFalse(absentResult.activated);
        assertTrue(absentResult.handleReleased);
        assertEquals(Arrays.asList("v4", "off"), absentV4.calls);

        final Operations rejectedV4 = new Operations(4, 6, false, true, false);
        final GoBackend.TwoPhaseResult rejectedResult = GoBackend.activatePeersAfterProtection(9, "peers", rejectedV4);
        assertFalse(rejectedResult.activated);
        assertTrue(rejectedResult.handleReleased);
        assertEquals(Arrays.asList("v4", "protect:4", "off"), rejectedV4.calls);
    }

    @Test
    public void failedCleanupRetainsHandleForConfirmedDownRetry() {
        final Operations operations = new Operations(4, 6, false, true, true);
        final GoBackend.TwoPhaseResult result = GoBackend.activatePeersAfterProtection(9, "peers", operations);

        assertFalse(result.activated);
        assertFalse(result.handleReleased);
        assertEquals(Arrays.asList("v4", "protect:4", "off"), operations.calls);
    }

    private static final class Operations implements GoBackend.TwoPhaseOperations {
        final List<String> calls = new ArrayList<>();
        final int v4;
        final int v6;
        final boolean protectV4;
        final boolean protectV6;
        final boolean throwOnStop;

        Operations(final int v4, final int v6, final boolean protectV4, final boolean protectV6,
                   final boolean throwOnStop) {
            this.v4 = v4;
            this.v6 = v6;
            this.protectV4 = protectV4;
            this.protectV6 = protectV6;
            this.throwOnStop = throwOnStop;
        }

        @Override public int socketV4(final int handle) { calls.add("v4"); return v4; }
        @Override public int socketV6(final int handle) { calls.add("v6"); return v6; }
        @Override public boolean protect(final int socket) {
            calls.add("protect:" + socket);
            return socket == v4 ? protectV4 : protectV6;
        }
        @Override public int applyPeerConfig(final int handle, final String settings) { calls.add("peers"); return 0; }
        @Override public void turnOff(final int handle) {
            calls.add("off");
            if (throwOnStop) throw new IllegalStateException("stop");
        }
    }
}
