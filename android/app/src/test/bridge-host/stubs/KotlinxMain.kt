@file:OptIn(kotlinx.coroutines.InternalCoroutinesApi::class)
package kotlinx.coroutines.android

// kotlinx.coroutines detects the android.os.Build double and loads this class
// by name (FastServiceLoader): Dispatchers.Main becomes one JVM thread.
import java.util.concurrent.Callable
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import kotlin.coroutines.CoroutineContext
import kotlinx.coroutines.MainCoroutineDispatcher
import kotlinx.coroutines.internal.MainDispatcherFactory

class AndroidDispatcherFactory : MainDispatcherFactory {
    override val loadPriority: Int get() = Int.MAX_VALUE
    override fun createDispatcher(allFactories: List<MainDispatcherFactory>): MainCoroutineDispatcher = HarnessMain
    override fun hintOnError(): String? = null
}

object HarnessMain : MainCoroutineDispatcher() {
    @Volatile private var thread: Thread? = null
    private val executor = Executors.newSingleThreadExecutor { runnable ->
        Thread(runnable, "harness-main").apply { isDaemon = true; thread = this }
    }
    override val immediate: MainCoroutineDispatcher get() = this
    override fun isDispatchNeeded(context: CoroutineContext): Boolean = Thread.currentThread() !== thread
    override fun dispatch(context: CoroutineContext, block: Runnable) { executor.execute(block) }
    fun post(block: Runnable) { executor.execute(block) }
    /** Runs one Android main-thread entry point and returns its value. */
    fun <T> run(block: () -> T): T = executor.submit(Callable { block() }).get(20, TimeUnit.SECONDS)
    /** Waits until every task already posted to the main thread has run. */
    fun drain() { run { } }
}
