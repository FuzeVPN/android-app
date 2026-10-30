package com.fuzevpn.android

import java.util.Collections
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

/** One deterministic stop point inside a fake engine or store. */
internal class Gate(val name: String) {
    private val reached = CountDownLatch(1)
    private val release = CountDownLatch(1)
    fun hold() {
        reached.countDown()
        check(release.await(20, TimeUnit.SECONDS)) { "gate $name never released" }
    }
    fun awaitReached() = check(reached.await(20, TimeUnit.SECONDS)) { "gate $name never reached" }
    fun open() = release.countDown()
}

/** Shared journal of the fakes; reset before every test. */
internal object HarnessControl {
    val notifications: MutableList<String> = Collections.synchronizedList(mutableListOf())
    val locales: MutableList<String?> = Collections.synchronizedList(mutableListOf())
    val purges: MutableList<Boolean> = Collections.synchronizedList(mutableListOf())
    @Volatile var identityGate: Gate? = null
    @Volatile var identityFailure: String? = null
    @Volatile var resumeReadGate: Gate? = null
    /** Every store read throws this code, as an unavailable Keystore would. */
    @Volatile var readFailure: String? = null
    /** Every store read fails as SecureKeystoreStore does once its Keystore key is gone. */
    @Volatile var readKeyMissing = false
    /** Only the next store read throws this code, as a transient Keystore failure. */
    @Volatile var readFailureOnce: String? = null
    /** getOrCreatePublicKey throws this code, as the real engine does while a stop is uncertain. */
    @Volatile var publicKeyFailure: String? = null
    /** Holds getOrCreateWireGuardPublicKey inside the tunnel mutex. */
    @Volatile var publicKeyGate: Gate? = null
    /** Holds a session purge once it has erased the session slots. */
    @Volatile var purgeGate: Gate? = null
    @Volatile var wireGuardConnect: (isCurrent: () -> Boolean) -> Boolean = { true }
    @Volatile var wireGuardConnectGate: Gate? = null
    @Volatile var wireGuardConnects = 0
    @Volatile var wireGuardStops = 0
    @Volatile var wireGuardUp = false
    @Volatile var wireGuardStopResult = true
    /** Makes an ERROR notification refresh throw, as a missing patched AAR would. */
    @Volatile var errorNotificationFailure: String? = null

    fun reset() {
        notifications.clear(); locales.clear(); purges.clear()
        identityGate = null; identityFailure = null; resumeReadGate = null; publicKeyGate = null; readFailure = null
        purgeGate = null; readKeyMissing = false; readFailureOnce = null; publicKeyFailure = null
        wireGuardConnect = { true }; wireGuardConnectGate = null
        wireGuardConnects = 0; wireGuardStops = 0; wireGuardUp = false
        wireGuardStopResult = true; errorNotificationFailure = null
    }
}
