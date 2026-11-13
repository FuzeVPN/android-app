package com.fuzevpn.android

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

/** Flutter entry point; all platform communication is deliberately centralized. */
class MainActivity : FlutterActivity() {
    private var vpnBridge: AndroidVpnBridge? = null
    private var billingBridge: PlayBillingBridge? = null
    private var googleAuthBridge: GoogleAuthBridge? = null
    private var turnstileBridge: NativeTurnstileBridge? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        vpnBridge = AndroidVpnBridge.obtain(
            applicationContext,
            this,
            flutterEngine.dartExecutor.binaryMessenger,
        )
        billingBridge = PlayBillingBridge.attach(
            this,
            flutterEngine.dartExecutor.binaryMessenger,
        )
        googleAuthBridge = GoogleAuthBridge(this, flutterEngine.dartExecutor.binaryMessenger)
        turnstileBridge = NativeTurnstileBridge(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onResume() {
        super.onResume()
        billingBridge?.onActivityResumed()
        googleAuthBridge?.onActivityResumed()
        turnstileBridge?.onActivityResumed()
    }

    override fun onPause() {
        turnstileBridge?.onActivityPaused()
        googleAuthBridge?.onActivityPaused()
        billingBridge?.onActivityPaused()
        super.onPause()
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        closeEngineBridges()
        super.cleanUpFlutterEngine(flutterEngine)
    }

    /** The bridges of one Flutter engine, closed once: by its cleanup or by onDestroy. */
    private fun closeEngineBridges() {
        turnstileBridge?.close()
        turnstileBridge = null
        googleAuthBridge?.close()
        googleAuthBridge = null
        billingBridge?.close()
        billingBridge = null
    }

    @Deprecated("Deprecated in Android SDK")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (vpnBridge?.onActivityResult(requestCode, resultCode, data) == true) return
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        if (vpnBridge?.onRequestPermissionsResult(requestCode, permissions, grantResults) == true) return
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onDestroy() {
        closeEngineBridges()
        vpnBridge?.detachFromActivity(this)
        vpnBridge = null
        super.onDestroy()
    }
}
