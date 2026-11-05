package com.fuzevpn.android

import android.content.Context
import android.content.ContextWrapper
import android.content.SharedPreferences
import com.wireguard.android.backend.Backend
import com.wireguard.android.backend.Statistics
import com.wireguard.android.backend.Tunnel
import com.wireguard.config.Config
import com.wireguard.crypto.Key
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey

/**
 * A10-wireguard-02 (with C1-01) and A10-wireguard-03 with the production
 * bounds: the real controller and SecureKeystoreStore around a fake engine
 * whose blocked calls ignore interruption, as GoBackend's JNI calls do.
 */
class WireGuardControllerTimeoutTest {
    private val fixture = WireGuardWorkerFixture()

    @After fun releaseEngine() = fixture.close()

    @Test fun identityCallsAnswerWhileATimedOutNativeStopStillHoldsTheWorker() {
        val controller = fixture.controller()
        val publicKey = controller.getOrCreatePublicKey(fixture.account)
        assertTrue(controller.connect(fixture.request()))
        val identity = controller.existingIdentityFingerprint(fixture.account)
        assertEquals(fixture.fingerprint(publicKey), identity)
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
        val wgTurnOff = fixture.gate()
        fixture.engine.downGate = wgTurnOff

        // The bridge reports wireguard_stop_timeout; the worker stays inside wgTurnOff.
        val stop = fixture.call { controller.disconnect() }.await(STOP_BOUND_MS + 5_000)
        val calls = listOf(
            fixture.call { controller.getOrCreatePublicKey(fixture.account) },
            fixture.call { controller.existingIdentityFingerprint(fixture.account) },
            fixture.call { controller.currentConnectionIdentityFingerprint(fixture.account) },
            fixture.call { controller.disconnect() },
            fixture.call { controller.connect(fixture.request()) },
            fixture.call { controller.statistics() },
        )
        val outcomes = calls.map { it.await(PROMPT_MS) }
        assertEquals("false", stop)
        assertEquals("wireguard_operation_pending", outcomes[0])
        assertEquals(identity, outcomes[1])
        assertEquals("wireguard_identity_unavailable", outcomes[2])
        assertEquals("false", outcomes[3])
        assertEquals("wireguard_operation_pending", outcomes[4])
        assertEquals("wireguard_operation_pending", outcomes[5])
        assertNull(controller.recoveryBaseline())

        // Late return: wgTurnOff finally returns and the worker confirms DOWN.
        wgTurnOff.countDown()
        assertTrue(fixture.eventually { controller.disconnect() })
        assertFalse(controller.isConnected())
        assertEquals(1, fixture.engine.stopCalls.get()) // refused calls never ran later
        assertEquals(publicKey, controller.getOrCreatePublicKey(fixture.account))
        assertTrue(controller.connect(fixture.request()))
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
    }

    @Test fun aSlowStatisticsReadLeavesTheLiveTunnelProofAndRecoveryBaselineIntact() {
        val controller = fixture.controller()
        assertTrue(controller.connect(fixture.request()))
        val identity = controller.currentConnectionIdentityFingerprint(fixture.account)
        val baseline = controller.recoveryBaseline()
        assertNotNull(baseline)
        val wgGetConfig = fixture.gate()
        fixture.engine.statisticsGate = wgGetConfig

        val read = fixture.call { controller.statistics() }.await(STATISTICS_BOUND_MS + 5_000)
        // wgGetConfig is still blocked on the worker: neither proof waits for it.
        val proofs = listOf(
            fixture.call { controller.currentConnectionIdentityFingerprint(fixture.account) },
            fixture.call { controller.existingIdentityFingerprint(fixture.account) },
        ).map { it.await(PROMPT_MS) }
        val baselineWhileBlocked = controller.recoveryBaseline()
        fixture.engine.statisticsGate = null
        wgGetConfig.countDown()
        val after = controller.statistics()
        assertEquals("TimeoutException", read)
        assertEquals(identity, proofs[0])
        assertEquals(identity, proofs[1])
        assertEquals(baseline, baselineWhileBlocked)
        assertEquals(5_000L, after.latestHandshakeMillis)
        assertTrue(controller.isConnected())
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
        assertEquals(baseline, controller.recoveryBaseline())

        // Only a start or a stop can own the TUN. A second start is refused
        // as such and does not erase the live tunnel's proof.
        assertEquals("tunnel_already_active", fixture.call { controller.connect(fixture.request()) }.await(PROMPT_MS))
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
        assertEquals(baseline, controller.recoveryBaseline())
        assertTrue(controller.disconnect())
        assertTrue(controller.connect(fixture.request()))
        assertEquals(identity, controller.currentConnectionIdentityFingerprint(fixture.account))
    }

    private companion object {
        // Production bounds of WireGuardController (stop and statistics).
        const val STOP_BOUND_MS = 10_000L
        const val STATISTICS_BOUND_MS = 2_000L
        const val PROMPT_MS = 1_500L
    }
}

/**
 * Shared by the WireGuard worker tests; no Android service, TUN or peer.
 * Every helper is nested here so the test package gains a single name.
 */
internal class WireGuardWorkerFixture : AutoCloseable {
    val account = "worker-test-account"
    val peer: Key = Key.fromBytes(ByteArray(32) { (it + 65).toByte() })
    val engine = Engine(peer)
    val keys = SecretKeys()
    private val gates = mutableListOf<CountDownLatch>()
    private val controllers = mutableListOf<WireGuardController>()

    fun context(): Context = TestContext()

    fun store() = SecureKeystoreStore(Preferences(), Preferences(), keys::get)

    fun track(controller: WireGuardController): WireGuardController = controller.also {
        synchronized(controllers) { controllers += it }
    }

    fun controller(): WireGuardController = track(WireGuardController(context(), store(), {}, { engine }))

    fun request() = WireGuardRequest(
        accountId = account,
        deviceId = "worker-test-device",
        locationId = "frankfurt-01",
        locationName = "Frankfurt 1",
        address = "10.10.0.6/32",
        dns = listOf("1.1.1.1"),
        serverPublicKey = peer.toBase64(),
        endpoint = "198.51.100.1:51820",
        allowedIps = listOf("0.0.0.0/0"),
    )

    fun gate(): CountDownLatch = CountDownLatch(1).also { synchronized(gates) { gates += it } }

    fun call(block: () -> Any?) = Call(block)

    fun releaseAfter(gate: CountDownLatch, millis: Long) {
        Thread({
            Thread.sleep(millis)
            gate.countDown()
        }, "wireguard-worker-test-release").apply { isDaemon = true }.start()
    }

    fun eventually(millis: Long = 5_000, condition: () -> Boolean): Boolean {
        val deadline = System.nanoTime() + TimeUnit.MILLISECONDS.toNanos(millis)
        while (!condition()) {
            if (System.nanoTime() > deadline) return false
            Thread.sleep(20)
        }
        return true
    }

    /** The controller's identity fingerprint of a public key (SHA-256, hex). */
    fun fingerprint(publicKey: String): String = MessageDigest.getInstance("SHA-256")
        .digest(publicKey.toByteArray(StandardCharsets.UTF_8))
        .joinToString("") { "%02x".format(it.toInt() and 0xff) }

    /** Never leaves a worker blocked for the next test. */
    override fun close() {
        synchronized(gates) { gates.forEach { it.countDown() } }
        synchronized(controllers) { controllers.forEach { it.close() } }
    }

    /** Runs one controller call on its own thread, so a blocked call cannot hang the test. */
    class Call(block: () -> Any?) {
        private val startedAt = System.nanoTime()
        private val done = CountDownLatch(1)
        private val outcome = AtomicReference("blocked")

        init {
            Thread({
                outcome.set(
                    try {
                        block().toString()
                    } catch (error: VpnNativeException) {
                        error.code
                    } catch (error: Throwable) {
                        error.javaClass.simpleName
                    },
                )
                done.countDown()
            }, "wireguard-worker-test-call").apply { isDaemon = true }.start()
        }

        /** The outcome, or "blocked" when the call has not returned [millis] after it started. */
        fun await(millis: Long): String {
            val remaining = startedAt + TimeUnit.MILLISECONDS.toNanos(millis) - System.nanoTime()
            done.await(remaining.coerceAtLeast(0L), TimeUnit.NANOSECONDS)
            return outcome.get()
        }
    }

    /** A fake GoBackend: a gated call ignores interruption, like wgTurnOff/wgGetConfig in JNI. */
    class Engine(private val peer: Key) : Backend {
        @Volatile var up = false
        @Volatile var startGate: CountDownLatch? = null
        @Volatile var downGate: CountDownLatch? = null
        @Volatile var statisticsGate: CountDownLatch? = null

        /** False: setState(DOWN) returns while the interface stays up. */
        @Volatile var confirmsDown = true
        val startCalls = AtomicInteger()
        val stopCalls = AtomicInteger()

        override fun getRunningTunnelNames(): Set<String> = if (up) setOf("fuzevpn") else emptySet()
        override fun getState(tunnel: Tunnel): Tunnel.State = if (up) Tunnel.State.UP else Tunnel.State.DOWN
        override fun getStatistics(tunnel: Tunnel): Statistics {
            holdUninterruptibly(statisticsGate)
            return peerStatistics(peer, 100, 200, 5_000)
        }
        override fun getVersion() = "worker-test"
        override fun isAlwaysOn() = false
        override fun isLockdownEnabled() = false
        override fun setState(tunnel: Tunnel, state: Tunnel.State, config: Config?): Tunnel.State {
            if (state == Tunnel.State.UP) {
                startCalls.incrementAndGet()
                holdUninterruptibly(startGate)
                up = true
                tunnel.onStateChange(Tunnel.State.UP)
            } else {
                stopCalls.incrementAndGet()
                holdUninterruptibly(downGate)
                if (confirmsDown && up) {
                    up = false
                    tunnel.onStateChange(Tunnel.State.DOWN)
                }
            }
            return getState(tunnel)
        }
    }

    /** Synthetic AES key for the real SecureKeystoreStore; may block like a stalled Keystore. */
    class SecretKeys {
        private val key: SecretKey = KeyGenerator.getInstance("AES").apply { init(256) }.generateKey()
        @Volatile var gate: CountDownLatch? = null

        @Suppress("UNUSED_PARAMETER")
        fun get(createIfAbsent: Boolean): SecretKey {
            holdUninterruptibly(gate)
            return key
        }
    }

    class TestContext : ContextWrapper(null) {
        override fun getApplicationContext(): Context = this
    }

    class Preferences : SharedPreferences {
        private val values = mutableMapOf<String, Any?>()

        override fun getAll(): MutableMap<String, *> = synchronized(values) { values.toMutableMap() }
        override fun getString(key: String, defValue: String?): String? = synchronized(values) { values[key] as String? ?: defValue }
        @Suppress("UNCHECKED_CAST")
        override fun getStringSet(key: String, defValues: MutableSet<String>?): MutableSet<String>? =
            synchronized(values) { (values[key] as Set<String>?)?.toMutableSet() ?: defValues }
        override fun getInt(key: String, defValue: Int): Int = synchronized(values) { values[key] as Int? ?: defValue }
        override fun getLong(key: String, defValue: Long): Long = synchronized(values) { values[key] as Long? ?: defValue }
        override fun getFloat(key: String, defValue: Float): Float = synchronized(values) { values[key] as Float? ?: defValue }
        override fun getBoolean(key: String, defValue: Boolean): Boolean = synchronized(values) { values[key] as Boolean? ?: defValue }
        override fun contains(key: String): Boolean = synchronized(values) { values.containsKey(key) }
        override fun registerOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener?) = Unit
        override fun unregisterOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener?) = Unit
        override fun edit(): SharedPreferences.Editor = Editor()

        private inner class Editor : SharedPreferences.Editor {
            private val changes = linkedMapOf<String, Any?>()
            override fun putString(key: String, value: String?): SharedPreferences.Editor = apply { changes[key] = value }
            override fun putStringSet(key: String, values: MutableSet<String>?): SharedPreferences.Editor =
                apply { changes[key] = values?.toSet() }
            override fun putInt(key: String, value: Int): SharedPreferences.Editor = apply { changes[key] = value }
            override fun putLong(key: String, value: Long): SharedPreferences.Editor = apply { changes[key] = value }
            override fun putFloat(key: String, value: Float): SharedPreferences.Editor = apply { changes[key] = value }
            override fun putBoolean(key: String, value: Boolean): SharedPreferences.Editor = apply { changes[key] = value }
            override fun remove(key: String): SharedPreferences.Editor = apply { changes[key] = null }
            override fun clear(): SharedPreferences.Editor = apply {
                synchronized(values) { values.keys.forEach { changes[it] = null } }
            }
            override fun commit(): Boolean {
                synchronized(values) {
                    changes.forEach { (key, value) -> if (value == null) values.remove(key) else values[key] = value }
                }
                return true
            }
            override fun apply() {
                commit()
            }
        }
    }

    private companion object {
        fun holdUninterruptibly(gate: CountDownLatch?) {
            var interrupted = false
            while (gate != null && gate.count > 0) {
                try {
                    gate.await()
                } catch (_: InterruptedException) {
                    interrupted = true
                }
            }
            if (interrupted) Thread.currentThread().interrupt()
        }

        /** Statistics() is not public and reads SystemClock: allocate it as WireGuardHandshakeTest does. */
        fun peerStatistics(peer: Key, received: Long, sent: Long, handshake: Long): Statistics {
            val unsafeClass = Class.forName("sun.misc.Unsafe")
            val unsafe = unsafeClass.getDeclaredField("theUnsafe").apply { isAccessible = true }.get(null)
            val statistics = unsafeClass.getMethod("allocateInstance", Class::class.java)
                .invoke(unsafe, Statistics::class.java) as Statistics
            Statistics::class.java.getDeclaredField("stats").apply { isAccessible = true }
                .set(statistics, hashMapOf(peer to Statistics.PeerStats(received, sent, handshake)))
            return statistics
        }
    }
}
