package com.fuzevpn.android

/** Explicit null means that no device existed when the caller began its work. */
internal class ExpectedDeviceIdentity private constructor(private val deviceId: String?) {
    fun requireCurrent(actualDeviceId: String?) {
        if (actualDeviceId != deviceId) throw VpnNativeException("session_operation_cancelled")
    }

    companion object {
        fun fromArguments(arguments: Map<String, Any?>): ExpectedDeviceIdentity {
            if (!arguments.containsKey("expected_device_id")) throw VpnNativeException("invalid_arguments")
            val value = arguments["expected_device_id"]
            if (value != null && (value !is String || value.isBlank() || value.length > 160 ||
                    value.any(Char::isISOControl))) throw VpnNativeException("invalid_arguments")
            return ExpectedDeviceIdentity(value)
        }
    }
}
