package android.os
class Message
class Looper { companion object {
    private val main = Looper()
    fun getMainLooper() = main
    fun myLooper() = main
} }
object SystemClock { var now = 0L; fun elapsedRealtime() = now }
class Handler(looper: Looper) {
    data class Event(val runnable: Runnable, val whenMs: Long)
    val queue = mutableListOf<Event>()
    init { latest = this }
    fun post(value: Runnable): Boolean { queue += Event(value, SystemClock.now); return true }
    fun postDelayed(value: Runnable, delay: Long): Boolean {
        queue += Event(value, SystemClock.now + delay); return true
    }
    fun removeCallbacks(value: Runnable) { queue.removeAll { it.runnable === value } }
    fun advance(milliseconds: Long) {
        SystemClock.now += milliseconds
        val due = queue.filter { it.whenMs <= SystemClock.now }.sortedBy { it.whenMs }
        queue.removeAll(due.toSet())
        due.forEach { it.runnable.run() }
    }
    companion object { lateinit var latest: Handler }
}
