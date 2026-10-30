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

class EventChannel(messenger: BinaryMessenger, name: String) {
    interface EventSink {
        fun success(event: Any?)
        fun error(code: String, message: String?, details: Any?)
        fun endOfStream()
    }
    interface StreamHandler {
        fun onListen(arguments: Any?, events: EventSink)
        fun onCancel(arguments: Any?)
    }
    fun setStreamHandler(value: StreamHandler?) {}
}
