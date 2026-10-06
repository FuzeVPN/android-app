package com.fuzevpn.android.openvpn

/** The retry belongs to a user request, never to a successful automatic restart. */
internal class OpenVpnRecoveryPolicy {
    private var request = 0L
    private var provenGeneration = 0L
    private var used = true

    @Synchronized fun newRequest(recoveryConsumed: Boolean = false): Long {
        request += 1
        provenGeneration = 0L
        used = recoveryConsumed
        return request
    }

    @Synchronized fun cancel() {
        request += 1
        provenGeneration = 0L
        used = true
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
}
