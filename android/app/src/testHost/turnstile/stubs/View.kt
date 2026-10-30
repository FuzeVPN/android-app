package android.view
open class View {
    var importantForAutofill = 0
    var parent: Any? = null
    var isAttachedToWindow = true
    companion object { const val IMPORTANT_FOR_AUTOFILL_NO_EXCLUDE_DESCENDANTS = 8 }
}
open class ViewGroup : View() {
    open fun removeView(view: View?) { view?.parent = null }
    class LayoutParams { companion object { const val MATCH_PARENT = -1 } }
}
