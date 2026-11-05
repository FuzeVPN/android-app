package android.app
import android.view.View
open class Activity {
    var isFinishing = false
    var isDestroyed = false
    val resources = Resources()
}
class Resources { val displayMetrics = DisplayMetrics() }
class DisplayMetrics { var density = 1f }
class AlertDialog {
    private var cancel: ((Any?) -> Unit)? = null
    private var dismiss: ((Any?) -> Unit)? = null
    fun setCanceledOnTouchOutside(value: Boolean) {}
    fun setOnCancelListener(value: ((Any?) -> Unit)?) { cancel = value }
    fun setOnDismissListener(value: ((Any?) -> Unit)?) { dismiss = value }
    fun show() {}
    fun dismiss() { dismiss?.invoke(this) }
    class Builder(activity: Activity) {
        fun setTitle(value: String) = this
        fun setView(value: View) = this
        fun setNegativeButton(value: String, callback: (Any?, Int) -> Unit) = this
        fun create() = AlertDialog()
    }
}
