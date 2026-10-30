package android.os

// Its presence also makes kotlinx.coroutines load
// kotlinx.coroutines.android.AndroidDispatcherFactory (see KotlinxMain.kt).
object Build {
    object VERSION { @JvmField var SDK_INT: Int = 34 }
    object VERSION_CODES {
        const val Q = 29
        const val R = 30
        const val S = 31
        const val TIRAMISU = 33
        const val UPSIDE_DOWN_CAKE = 34
    }
}

open class UserManager { @Volatile var unlocked = true; open val isUserUnlocked: Boolean get() = unlocked }

object SystemClock {
    @JvmStatic fun elapsedRealtime(): Long = System.nanoTime() / 1_000_000L
    @JvmStatic fun elapsedRealtimeNanos(): Long = System.nanoTime()
}
