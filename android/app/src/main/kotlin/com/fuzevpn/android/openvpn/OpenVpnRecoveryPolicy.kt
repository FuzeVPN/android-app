package com.fuzevpn.android.openvpn

/**
 * The failure retry belongs to a user request, never to a successful automatic
 * restart. A physical network change is followed at most once per proven
 * session; the next CONNECTED proof makes the next one possible.
 */
internal class OpenVpnRecoveryPolicy {
    private var request = 0L
    private var provenGeneration = 0L
    private var used = true
    private var lostGeneration = 0L
    private var networkClaimGeneration = 0L

    @Synchronized fun newRequest(recoveryConsumed: Boolean = false): Long {
        request += 1
        provenGeneration = 0L
        used = recoveryConsumed
        lostGeneration = 0L
        networkClaimGeneration = 0L
        return request
    }

    @Synchronized fun cancel() {
        request += 1
        provenGeneration = 0L
        used = true
        lostGeneration = 0L
        networkClaimGeneration = 0L
    }

    @Synchronized fun currentRequest() = request
    @Synchronized fun isCurrent(ticket: Long) = request == ticket

    @Synchronized fun connected(generation: Long) {
        provenGeneration = generation
    }

    @Synchronized fun claim(generation: Long): Long? {
        if (used || generation == 0L || generation != provenGeneration) return null
        used = true
        return request
    }

    /** Marks an OS network loss for the proven session; false once a command cancelled it. */
    @Synchronized fun networkLost(generation: Long): Boolean {
        if (generation == 0L || generation != provenGeneration) return false
        lostGeneration = generation
        return true
    }

    /** One claim per proven generation that lost a network; [claim]'s retry is untouched. */
    @Synchronized fun claimNetworkChange(generation: Long): Long? {
        if (generation == 0L || generation != provenGeneration || lostGeneration != generation ||
            networkClaimGeneration == generation) return null
        networkClaimGeneration = generation
        return request
    }
}
