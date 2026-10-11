// SPDX-License-Identifier: MPL-2.0
package com.fuzevpn.android

/** App disclosure and Android authorization are separate, explicit decisions. */
internal object VpnDisclosurePolicy {
    const val CURRENT_VERSION = "1"
    fun accepted(value: String?): Boolean = value == CURRENT_VERSION
    fun mayRequest(accepted: Boolean, androidPermission: Boolean, explicitAcceptance: Boolean): Boolean =
        explicitAcceptance || mayStart(accepted, androidPermission)
    fun mayStart(accepted: Boolean, androidPermission: Boolean): Boolean = accepted && androidPermission
}
