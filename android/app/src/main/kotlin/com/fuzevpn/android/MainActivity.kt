package com.fuzevpn.android

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

/** Flutter entry point; all platform communication is deliberately centralized. */
class MainActivity : FlutterActivity() {
    private var vpnBridge: AndroidVpnBridge? = null
    private var billingBridge: PlayBillingBridge? = null
    private var googleAuthBridge: GoogleAuthBridge? = null

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
    }

    override fun onResume() {
        super.onResume()
        billingBridge?.onActivityResumed()
        googleAuthBridge?.onActivityResumed()
    }

    override fun onPause() {
        googleAuthBridge?.onActivityPaused()
        billingBridge?.onActivityPaused()
        super.onPause()
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        googleAuthBridge?.close()
        googleAuthBridge = null
        billingBridge?.close()
        billingBridge = null
        super.cleanUpFlutterEngine(flutterEngine)
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
        googleAuthBridge?.close()
        googleAuthBridge = null
        billingBridge?.close()
        billingBridge = null
        vpnBridge?.detachFromActivity(this)
        vpnBridge = null
        super.onDestroy()
    }
}
