package com.fuzevpn.android

internal object WireGuardRuntimePolicy {
    fun useCompanionService(buildType: String, patchedRuntime: Boolean): Boolean {
        if (patchedRuntime) return false
        // Profile can inherit DEBUG=true from Flutter; only the named debug
        // build type is allowed to run the official development AAR.
        if (buildType == "debug") return true
        throw VpnNativeException("wireguard_foreground_service_unavailable")
    }
}
