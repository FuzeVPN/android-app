package android.widget
import android.app.Activity
import android.view.View
import android.view.ViewGroup
class FrameLayout(activity: Activity): ViewGroup() {
    class LayoutParams(width: Int, height: Int)
    fun addView(view: View, params: LayoutParams) { view.parent = this }
}
