package android.util

object Log {
    @JvmStatic fun i(tag: String, msg: String): Int = 0
    @JvmStatic fun w(tag: String, msg: String): Int = 0
    @JvmStatic fun w(tag: String, msg: String, error: Throwable?): Int = 0
    @JvmStatic fun e(tag: String, msg: String): Int = 0
    @JvmStatic fun e(tag: String, msg: String, error: Throwable?): Int = 0
}
