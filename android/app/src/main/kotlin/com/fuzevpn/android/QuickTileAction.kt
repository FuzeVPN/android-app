package com.fuzevpn.android

internal enum class QuickTileAction { CONNECT, DISCONNECT, OPEN_SETTINGS }

/** Unknown always-on flags restrict stopping an engine, never an idle start. */
internal fun quickTileAction(activeProtocol: VpnProtocol?, alwaysOn: Boolean?): QuickTileAction = when {
    activeProtocol == null -> QuickTileAction.CONNECT
    userStopRequiresSettings(alwaysOn) -> QuickTileAction.OPEN_SETTINGS
    else -> QuickTileAction.DISCONNECT
}

/** These local-only refusals require an explicit account or profile repair in the app. */
internal fun quickTileFailureOpensApplication(code: String?): Boolean = code in setOf(
    "quick_tile_profile_unavailable",
    "vpn_permission_required",
    "vpn_disclosure_required",
    "system_vpn_resume_session_invalid",
    "system_vpn_resume_identity_changed",
    "session_ending",
    "secure_storage_corrupt",
    "secure_storage_read_failed",
    "wireguard_identity_unavailable",
    "wireguard_identity_invalid",
    "wireguard_identity_store_failed",
    "openvpn_renewal_required",
    "openvpn_certificate_expired",
    "openvpn_csr_required",
    "openvpn_profile_unavailable",
    "openvpn_identity_unavailable",
    "openvpn_identity_store_failed",
    "openvpn_identity_cleanup_pending",
    "openvpn_certificate_identity_mismatch",
    "openvpn_certificate_expiry_mismatch",
    "openvpn_network_metadata_invalid",
)
