package com.fuzevpn.android

/** A pure projection of an already observed state, never a probe or repair. */
internal object DiagnosticSnapshot {
    private val safeCode = Regex("[a-z0-9_]{1,64}")
    private val resumeStates = setOf("unavailable", "ready", "waiting_network", "restoring", "blocked")

    fun fromState(state: VpnState): Map<String, Any?> = buildMap {
        put("status", state.status.wireValue)
        state.protocol?.let { put("protocol", it.wireValue) }
        state.messageCode?.takeIf(safeCode::matches)?.let { put("message_code", it) }
        state.connectedAtMillis?.takeIf { it > 0 }?.let { put("connected_at", it) }
        state.receivedBytes?.takeIf { it >= 0 }?.let { put("received_bytes", it) }
        state.sentBytes?.takeIf { it >= 0 }?.let { put("sent_bytes", it) }
        state.latestHandshakeMillis?.takeIf { it > 0 }?.let { put("latest_handshake", it) }
        val families = state.ipFamilies.distinct().filter { it == "ipv4" || it == "ipv6" }
        if (state.status == VpnStatus.CONNECTED && families.isNotEmpty()) put("ip_families", families)
        put("system_protection", buildMap<String, Any> {
            for (key in listOf("always_on", "lockdown")) {
                (state.systemProtection[key] as? Boolean)?.let { put(key, it) }
            }
            (state.systemProtection["resume_state"] as? String)?.takeIf { it in resumeStates }
                ?.let { put("resume_state", it) }
        })
        // No freshness estimate: the cached counters may predate the last state
        // publication. No locations, identities, revocation records or raw text.
    }
}
