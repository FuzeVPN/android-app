package com.fuzevpn.android

import java.io.Closeable
import java.io.IOException
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Test

/** The TUN duplicate OpenVpnService keeps while Core is stopped for a recovery. */
class RetainedTunTest {
    private val host = Any()

    private class Handle(val name: String, private val failure: Boolean = false) : Closeable {
        var closes = 0
        var onClose: () -> Unit = {}
        override fun close() {
            closes += 1
            onClose()
            if (failure) throw IOException("close failed: $name")
        }
    }

    @Test fun theNewHandleIsHeldBeforeTheOldOneCloses() {
        val retained = RetainedTun<Handle, String>()
        val old = Handle("old")
        val next = Handle("next")
        var heldAtClose: Handle? = null
        old.onClose = { heldAtClose = held(retained) }
        retained.replace(old, "plan", host)
        retained.replace(next, "plan", host)
        assertSame(next, heldAtClose)
        assertEquals(1, old.closes)
        assertEquals(0, next.closes)
        // The same handle again is not a replacement: it stays open.
        retained.replace(next, "plan", host)
        assertEquals(0, next.closes)
        assertSame(next, held(retained))
    }

    @Test fun releaseClosesExactlyOnce() {
        val retained = RetainedTun<Handle, String>()
        val handle = Handle("tun")
        retained.release() // Nothing held: no effect.
        retained.replace(handle, "plan", host)
        retained.release()
        retained.release()
        assertEquals(1, handle.closes)
        assertNull(held(retained))
    }

    @Test fun aCloseFailureIsSwallowedAndNothingStaysHeld() {
        val retained = RetainedTun<Handle, String>()
        val failing = Handle("failing", failure = true)
        val next = Handle("next")
        retained.replace(failing, "plan", host)
        retained.replace(next, "plan", host)
        assertEquals(1, failing.closes)
        assertSame(next, held(retained))
        val failingAgain = Handle("failing again", failure = true)
        retained.replace(failingAgain, "plan", host)
        retained.release()
        assertEquals(1, failingAgain.closes)
        assertNull(held(retained))
        retained.release()
        assertEquals(1, failingAgain.closes)
    }

    @Test fun aCopyIsGivenOnlyForTheSamePlanFromTheSameHost() {
        val retained = RetainedTun<Handle, String>()
        val handle = Handle("tun")
        val copies = mutableListOf<String>()
        val copy: (Handle) -> String = { held -> "copy of ${held.name}".also(copies::add) }
        assertNull("nothing held", retained.reuse("plan", host, copy))
        retained.replace(handle, "plan", host)
        assertEquals("copy of tun", retained.reuse("plan", host, copy))
        assertNull("another plan establishes", retained.reuse("other plan", host, copy))
        assertNull("another host establishes", retained.reuse("plan", Any(), copy))
        assertEquals(listOf("copy of tun"), copies)
        // Copying never gives the held handle away or closes it.
        assertSame(handle, held(retained))
        assertEquals(0, handle.closes)
        retained.release()
        assertNull("released", retained.reuse("plan", host, copy))
        assertEquals(1, handle.closes)
    }

    @Test fun aFailedCopyIsNoReuseAndKeepsTheHandle() {
        val retained = RetainedTun<Handle, String>()
        val handle = Handle("tun")
        retained.replace(handle, "plan", host)
        assertNull(retained.reuse("plan", host) { throw IOException("dup failed") })
        assertSame(handle, held(retained))
        assertEquals(0, handle.closes)
    }

    @Test fun aReplacementTakesThePlanAndHostOfTheNewHandle() {
        val retained = RetainedTun<Handle, String>()
        val newHost = Any()
        retained.replace(Handle("old"), "old plan", host)
        retained.replace(Handle("new"), "new plan", newHost)
        assertNull(retained.reuse("old plan", host) { it.name })
        assertNull(retained.reuse("new plan", host) { it.name })
        assertEquals("new", retained.reuse("new plan", newHost) { it.name })
    }

    @Test fun aRefusalNamesWhyTheHandleWouldNotBeCopied() {
        val retained = RetainedTun<Handle, String>()
        assertEquals("none retained", retained.refusal("plan", host))
        retained.replace(Handle("tun"), "plan", host)
        assertNull(retained.refusal("plan", host))
        assertEquals("another network plan", retained.refusal("other plan", host))
        assertEquals("another VPN host", retained.refusal("plan", Any()))
    }

    @Test fun aDeclinedHandleIsNoReuseAndStaysHeld() {
        val retained = RetainedTun<Handle, String>()
        val handle = Handle("tun")
        retained.replace(handle, "plan", host)
        assertNull(retained.reuse("plan", host) { null })
        assertSame(handle, held(retained))
        assertEquals(0, handle.closes)
    }

    @Test fun theTunInterfaceIsReadFromFdinfo() {
        assertEquals("tun0", tunInterfaceFromFdinfo("pos:\t0\nflags:\t0104002\nmnt_id:\t20\nino:\t1063\niff:\ttun0\n"))
        assertEquals("tun12", tunInterfaceFromFdinfo("iff: tun12"))
        assertNull(tunInterfaceFromFdinfo("pos:\t0\nflags:\t02\n"))
        assertNull(tunInterfaceFromFdinfo("iff:\t\n"))
    }

    @Test fun releaseWaitsForACopyInProgress() {
        val retained = RetainedTun<Handle, String>()
        val handle = Handle("tun")
        retained.replace(handle, "plan", host)
        val copying = java.util.concurrent.CountDownLatch(1)
        val proceed = java.util.concurrent.CountDownLatch(1)
        var copy: String? = null
        val reuser = Thread {
            copy = retained.reuse("plan", host) { held ->
                copying.countDown()
                proceed.await()
                "copy of ${held.name}"
            }
        }.apply { start() }
        copying.await()
        val releaser = Thread { retained.release() }.apply { start() }
        Thread.sleep(100)
        assertEquals("release must wait for the copy", 0, handle.closes)
        proceed.countDown()
        reuser.join(5_000)
        releaser.join(5_000)
        assertEquals("copy of tun", copy)
        assertEquals(1, handle.closes)
        assertNull(held(retained))
    }

    private fun held(retained: RetainedTun<Handle, String>): Handle? =
        RetainedTun::class.java.getDeclaredField("current").apply { isAccessible = true }.get(retained) as Handle?
}
