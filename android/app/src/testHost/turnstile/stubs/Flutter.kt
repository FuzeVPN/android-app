package io.flutter.plugin.common
interface BinaryMessenger
class MethodCall(val method: String, val arguments: Any?)
class MethodChannel(messenger: BinaryMessenger, name: String) {
    interface MethodCallHandler { fun onMethodCall(call: MethodCall, result: Result) }
    interface Result {
        fun success(value: Any?)
        fun error(code: String, message: String?, details: Any?)
        fun notImplemented()
    }
    fun setMethodCallHandler(value: MethodCallHandler?) {}
}
