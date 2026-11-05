package android.util
object Base64 {
    const val NO_WRAP = 1
    const val URL_SAFE = 2
    const val NO_PADDING = 4
    fun encodeToString(bytes: ByteArray, flags: Int) = java.util.Base64.getUrlEncoder().withoutPadding().encodeToString(bytes)
}
