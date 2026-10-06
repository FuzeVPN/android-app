package com.fuzevpn.android

import android.app.Activity
import android.os.CancellationSignal
import android.os.Handler
import android.os.Looper
import androidx.core.content.ContextCompat
import androidx.credentials.ClearCredentialStateRequest
import androidx.credentials.CredentialManager
import androidx.credentials.CredentialManagerCallback
import androidx.credentials.CustomCredential
import androidx.credentials.GetCredentialRequest
import androidx.credentials.GetCredentialResponse
import androidx.credentials.exceptions.ClearCredentialException
import androidx.credentials.exceptions.GetCredentialCancellationException
import androidx.credentials.exceptions.GetCredentialException
import androidx.credentials.exceptions.GetCredentialInterruptedException
import androidx.credentials.exceptions.GetCredentialProviderConfigurationException
import androidx.credentials.exceptions.GetCredentialUnsupportedException
import androidx.credentials.exceptions.NoCredentialException
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailabilityLight
import com.google.android.libraries.identity.googleid.GetSignInWithGoogleOption
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Activity-owned, explicit Google picker. It never admits or changes a VPN session. */
internal class GoogleAuthBridge(
    private val activity: Activity,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler {
    private val appContext = activity.applicationContext
    private val channel = MethodChannel(messenger, "com.fuzevpn/google_auth")
    private val main = Handler(Looper.getMainLooper())
    private val executor = ContextCompat.getMainExecutor(appContext)
    private val manager = CredentialManager.create(appContext)
    private val gate = GoogleAuthFlowGate()
    private val secureStore = SecureKeystoreStore(appContext)
    private val pendingAuthentication = GooglePendingAuthStorage(
        read = { slot -> secureStore.read(slot.scope, slot.key, removeCorrupt = false) },
        update = { values, deleted -> secureStore.updateSlotsAtomically(values, deleted) },
    )
    private var operation: Operation? = null
    private var hostResumed = false
    private var closed = false

    init { channel.setMethodCallHandler(this) }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) = onMain {
        if (closed) {
            result.error("unavailable", "unavailable", null)
            return@onMain
        }
        try {
            when (call.method) {
                "getCapabilities" -> {
                    GoogleAuthPolicy.noArguments(call.arguments)
                    val available = providerAvailable()
                    result.success(mapOf("supported" to available, "reason" to if (available) null else "unavailable"))
                }
                "signIn" -> signIn(GoogleAuthPolicy.signIn(call.arguments), result)
                "cancelSignIn" -> {
                    cancel(GoogleAuthPolicy.cancellation(call.arguments))
                    result.success(null)
                }
                "clearCredentialState" -> {
                    GoogleAuthPolicy.noArguments(call.arguments)
                    clearState(result)
                }
                "readPendingAuthentication" -> {
                    GoogleAuthPolicy.noArguments(call.arguments)
                    result.success(pendingAuthentication.read())
                }
                "writePendingAuthentication" -> {
                    val values = call.arguments as? Map<*, *> ?: throw GoogleAuthException("invalid_request")
                    if (values.keys != setOf("payload") || values["payload"] !is String) {
                        throw GoogleAuthException("invalid_request")
                    }
                    pendingAuthentication.write(values["payload"] as String)
                    result.success(null)
                }
                "clearPendingAuthentication" -> {
                    GoogleAuthPolicy.noArguments(call.arguments)
                    pendingAuthentication.clear()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        } catch (error: GoogleAuthException) {
            result.error(error.code, error.code, null)
        } catch (_: Exception) {
            result.error("provider_error", "provider_error", null)
        }
    }

    fun onActivityResumed() = onMain { if (!closed) hostResumed = true }

    // Google owns another Activity while its selector is visible. Pausing the
    // host stops new launches without revoking the user's pending selection.
    fun onActivityPaused() = onMain { hostResumed = false }

    fun close() = onMain {
        if (closed) return@onMain
        closed = true
        hostResumed = false
        gate.close()
        operation?.let { runCatching { it.signal.cancel() }; it.fail("unavailable") }
        operation = null
        channel.setMethodCallHandler(null)
    }

    private fun signIn(selection: GoogleSignInSelection, result: MethodChannel.Result) {
        if (!hostResumed || !usableActivity() || !providerAvailable()) throw GoogleAuthException("unavailable")
        val active = Operation(gate.reserve(selection.requestId), result)
        operation = active
        try {
            val option = GetSignInWithGoogleOption.Builder(selection.serverClientId)
                .setNonce(selection.nonce).build()
            val request = GetCredentialRequest.Builder().addCredentialOption(option).build()
            manager.getCredentialAsync(activity, request, active.signal, executor,
                object : CredentialManagerCallback<GetCredentialResponse, GetCredentialException> {
                    override fun onResult(result: GetCredentialResponse) = onMain {
                        if (!gate.isCurrent(active.ticket)) return@onMain
                        try {
                            val credential = result.credential as? CustomCredential
                                ?: throw GoogleAuthException("invalid_response")
                            if (credential.type != GoogleIdTokenCredential.TYPE_GOOGLE_ID_TOKEN_CREDENTIAL) {
                                throw GoogleAuthException("invalid_response")
                            }
                            val token = try {
                                GoogleIdTokenCredential.createFrom(credential.data).idToken
                            } catch (_: Exception) {
                                throw GoogleAuthException("invalid_response")
                            }
                            val value = GoogleAuthPolicy.token(token)
                            succeed(active, mapOf("requestId" to selection.requestId, "idToken" to value))
                        } catch (error: GoogleAuthException) {
                            fail(active, error.code)
                        } catch (_: Exception) {
                            fail(active, "provider_error")
                        }
                    }

                    override fun onError(e: GetCredentialException) = onMain {
                        fail(active, when (e) {
                            is GetCredentialCancellationException -> "cancelled"
                            is GetCredentialInterruptedException -> "interrupted"
                            is NoCredentialException -> "no_credential"
                            is GetCredentialUnsupportedException, is GetCredentialProviderConfigurationException -> "unavailable"
                            else -> "provider_error"
                        })
                    }
                },
            )
        } catch (_: Exception) {
            fail(active, "provider_error")
        }
    }

    private fun clearState(result: MethodChannel.Result) {
        operation?.ticket?.requestId?.let(::cancel)
        val active = Operation(gate.reserve(null), result)
        operation = active
        try {
            manager.clearCredentialStateAsync(ClearCredentialStateRequest(), active.signal, executor,
                object : CredentialManagerCallback<Void?, ClearCredentialException> {
                    override fun onResult(result: Void?) = onMain { succeed(active, null) }
                    override fun onError(e: ClearCredentialException) = onMain { fail(active, "provider_error") }
                },
            )
        } catch (_: Exception) { fail(active, "provider_error") }
    }

    private fun cancel(requestId: String) {
        val ticket = gate.cancel(requestId) ?: return
        val active = operation?.takeIf { it.ticket === ticket } ?: return
        operation = null
        runCatching { active.signal.cancel() }
        active.fail("cancelled")
    }

    private fun succeed(active: Operation, value: Any?) {
        if (!gate.finish(active.ticket)) return
        if (operation === active) operation = null
        active.succeed(value)
    }

    private fun fail(active: Operation, code: String) {
        if (!gate.finish(active.ticket)) return
        if (operation === active) operation = null
        active.fail(code)
    }

    private fun providerAvailable(): Boolean = try {
        GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(appContext) == ConnectionResult.SUCCESS
    } catch (_: Exception) { false }

    private fun usableActivity(): Boolean = !activity.isFinishing && !activity.isDestroyed

    private fun onMain(block: () -> Unit) {
        if (Looper.myLooper() == Looper.getMainLooper()) block() else main.post(block)
    }

    private class Operation(val ticket: GoogleAuthFlowGate.Ticket, private val result: MethodChannel.Result) {
        val signal = CancellationSignal()
        private var completed = false
        fun succeed(value: Any?) {
            if (completed) return
            completed = true
            result.success(value)
        }
        fun fail(code: String) {
            if (completed) return
            completed = true
            val safeCode = GoogleAuthPolicy.safeError(code)
            result.error(safeCode, safeCode, null)
        }
    }
}
