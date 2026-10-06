# OpenVPN registers this exact class and these JVM descriptors in JNI_OnLoad.
# Only the native boundary is kept; Java/Kotlin helpers remain eligible for R8.
-keep,includedescriptorclasses class com.fuzevpn.android.openvpn.OpenVpnNative {
    public native boolean nativeIsCoreAvailable();
    public native long nativeCreate(com.fuzevpn.android.openvpn.OpenVpnNative$Callback);
    public native boolean nativeDestroy(long);
    public native boolean nativeStart(long, java.lang.String, java.lang.String, java.lang.String, java.lang.String);
    public native boolean nativeStop(long);
    public native boolean nativeIsConnected(long);
    public native long[] nativeStatistics(long);
}

# nativeCreate's descriptor names the interface. C++ resolves its callbacks on
# the actual instance with GetMethodID, so keep the implementation methods too.
-keep interface com.fuzevpn.android.openvpn.OpenVpnNative$Callback {
    public void onNativeState(java.lang.String, java.lang.String);
    public int onTunConfiguration(java.lang.String);
    public boolean onProtectSocket(int);
    public java.lang.String onPkiCertificate(java.lang.String);
    public java.lang.String onPkiSign(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String);
}

-keepclassmembers class * implements com.fuzevpn.android.openvpn.OpenVpnNative$Callback {
    public void onNativeState(java.lang.String, java.lang.String);
    public int onTunConfiguration(java.lang.String);
    public boolean onProtectSocket(int);
    public java.lang.String onPkiCertificate(java.lang.String);
    public java.lang.String onPkiSign(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String);
}

# WireGuard uses Java_com_wireguard_android_backend_GoBackend_wg* JNI exports.
# The patched host API is also resolved by Class.forName/getMethod in the app.
-keep,includedescriptorclasses class com.wireguard.android.backend.GoBackend {
    private static native java.lang.String wgGetConfig(int);
    private static native int wgGetSocketV4(int);
    private static native int wgGetSocketV6(int);
    private static native void wgTurnOff(int);
    private static native int wgTurnOn(java.lang.String, int, java.lang.String);
    private static native int wgSetConfig(int, java.lang.String);
    private static native java.lang.String wgVersion();
    public static void setHostLifecycleListener(com.wireguard.android.backend.GoBackend$HostLifecycleListener);
    public static com.wireguard.android.backend.GoBackend$VpnService getActiveHost();
    public static boolean startHost(android.content.Context);
    public static void stopHost();
    public static void setForegroundNotificationFactory(com.wireguard.android.backend.GoBackend$ForegroundNotificationFactory);
}

# Proxy invocation handlers dispatch by Method.getName(); those names must stay.
-keep interface com.wireguard.android.backend.GoBackend$HostLifecycleListener {
    public void onSystemStart();
    public void onHostRevoked();
    public void onHostDestroyed();
}

-keep interface com.wireguard.android.backend.GoBackend$ForegroundNotificationFactory {
    public android.app.Notification create(android.content.Context);
}

# This service is both a manifest component and a reflection target.
-keep class com.wireguard.android.backend.GoBackend$VpnService {
    public static void refreshForegroundNotification();
}

# Android manifest entry points, Flutter embedding/plugins and library consumer
# rules are supplied by AGP/Flutter. Do not add application-wide package keeps.
