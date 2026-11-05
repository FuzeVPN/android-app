package com.fuzevpn.android.openvpn

/**
 * Reconciles the JNI work the OpenVPN controller still owns after one of its
 * bounded waits gave up: a creation whose handle was never claimed, and the
 * destroy of a claimed handle. Each keeps its own completion proof
 * ([OwnedNativeHandleCreation], [OwnedNativeHandleDestruction]).
 *
 * A destroy can finish after its stop stopped waiting. Any check of whether a
 * native session may still be running therefore consumes both proofs first,
 * so a session JNI has already destroyed is never reported as in use (A09-01).
 * Reconciliation never stops or destroys a claimed handle by itself and
 * publishes no session state of its own: the owner's [Owner.released] hook
 * and the caller decide what to report.
 */
internal class OwnedNativeOperations(
    private val owner: Owner,
    private val waitMillis: Long,
) {
    /** The controller's own fields, read and written under its identity mutex. */
    interface Owner {
        var nativeHandle: Long
        var operationUncertain: Boolean
        var pendingCreation: OwnedNativeHandleCreation?
        var pendingDestruction: OwnedNativeHandleDestruction?

        /** No JNI session remains; [destroyed] is true when it was a claimed handle. */
        fun released(destroyed: Boolean)
    }

    enum class Destruction { NONE, DESTROYED, REFUSED, PENDING }

    /** Success is a proof that an abandoned creation left no JNI handle. */
    fun reconcileCreation(): Boolean {
        val creation = owner.pendingCreation ?: return true
        return try {
            if (!creation.awaitReleased(waitMillis)) {
                owner.operationUncertain = true
                false
            } else {
                owner.pendingCreation = null
                owner.operationUncertain = false
                owner.released(destroyed = false)
                true
            }
        } catch (error: Exception) {
            if (error is InterruptedException) Thread.currentThread().interrupt()
            owner.operationUncertain = true
            false
        }
    }

    /**
     * Consumes the destroy proof of the claimed handle, including a proof that
     * arrived after an earlier wait timed out. A refused destroy leaves the
     * handle owned until a confirmed Stop/Destroy retry; a destroy still
     * running keeps the same proof for the next caller.
     */
    fun reconcileDestruction(
        awaitCompleted: (OwnedNativeHandleDestruction) -> Boolean = { it.awaitCompleted(waitMillis) },
    ): Destruction {
        val destruction = owner.pendingDestruction ?: return Destruction.NONE
        return try {
            val destroyed = awaitCompleted(destruction)
            owner.pendingDestruction = null
            if (destroyed) {
                owner.nativeHandle = 0L
                owner.operationUncertain = false
                owner.released(destroyed = true)
                Destruction.DESTROYED
            } else {
                owner.operationUncertain = true
                Destruction.REFUSED
            }
        } catch (error: Exception) {
            if (error is InterruptedException) Thread.currentThread().interrupt()
            // Preserve the same future until it supplies an actual completion proof.
            owner.operationUncertain = true
            Destruction.PENDING
        }
    }

    /** True while a native session may still run, once every owned proof is consumed. */
    fun nativeSessionInUse(): Boolean {
        if (!reconcileCreation()) return true
        reconcileDestruction()
        return owner.nativeHandle != 0L || owner.operationUncertain
    }
}
