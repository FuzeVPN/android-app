#include "../../main/cpp/openvpn_connection_state.h"
#include <cassert>
#include <iostream>

using fuzevpn::openvpn::ConnectionState;

constexpr int LifecycleCases() {
  int cases = 0;
  for (const auto* interruption : {"RECONNECTING", "PAUSE", "TUN_TEARDOWN"}) {
    ConnectionState state;
    assert(state.Event("CONNECTED", false, "")->state == "connected");
    assert(state.connected());
    assert(state.Event(interruption, false, "")->reason == "openvpn_reconnect_required");
    assert(!state.connected());
    assert(!state.Event("CONNECTED", false, ""));
    state.RequestStop();
    assert(state.Complete(false).reason == "openvpn_reconnect_required");
    assert(!state.connected());
    ConnectionState replacement;
    assert(!replacement.connected());
    replacement.Event("CONNECTED", false, "");
    assert(replacement.connected());
    ++cases;
  }
  {
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    assert(state.Complete(false).reason == "tunnel_disconnected");
    assert(!state.connected());
    assert(!state.Event("CONNECTED", false, ""));
    ++cases;
  }
  {
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    assert(state.Event("DISCONNECTED", false, "")->reason == "tunnel_disconnected");
    assert(!state.connected());
    assert(state.Complete(false).state == "error");
    ++cases;
  }
  for (const auto* failure : {"tls_certificate_revoked", "tls_handshake_failed", "tun_permission_revoked"}) {
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    state.Event("RECONNECTING", false, "");
    assert(state.Event("FATAL", true, failure)->reason == failure);
    assert(!state.connected());
    assert(state.Event("TUN_TEARDOWN", false, "") == std::nullopt);
    assert(state.Event("RECONNECTING", false, "")->reason == failure);
    state.RequestStop();
    assert(state.Complete(true).reason == failure);
    ++cases;
  }
  {
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    state.Event("TUN_TEARDOWN", false, "");
    state.RequestStop();
    assert(state.Event("FATAL", true, "tls_certificate_revoked")->reason == "tls_certificate_revoked");
    assert(state.Complete(true).reason == "tls_certificate_revoked");
    assert(!state.connected());
    ++cases;
  }
  {
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    state.RequestStop();
    assert(!state.connected());
    assert(!state.Event("DISCONNECTED", false, ""));
    assert(state.Complete(false).state == "idle");
    ++cases;
  }
  {
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    assert(state.Event("TRANSPORT_ERROR", true, "transport_failed")->reason == "openvpn_reconnect_required");
    assert(!state.connected());
    ++cases;
  }
  return cases;
}

// Orders of cause, stop request and completion that the cases above do not
// reach. Counted apart so that the 11 lifecycle cases stay as they are.
constexpr int CauseAndStopCases() {
  int cases = 0;
  {
    // Without a cause or a stop request, the worker's own status decides.
    ConnectionState state;
    assert(state.Complete(true).reason == "openvpn_core_status_error");
    assert(!state.Event("CONNECTED", false, ""));
    assert(!state.connected());
    ++cases;
  }
  {
    // A stop request outlives completion: nothing is recorded afterwards and
    // a repeated report stays idle.
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    state.RequestStop();
    assert(!state.Event("FATAL", true, "tls_handshake_failed"));
    assert(state.Complete(true).state == "idle");
    assert(!state.Event("RECONNECTING", false, ""));
    assert(!state.Event("CONNECTED", false, ""));
    assert(state.Complete(false).state == "idle");
    assert(!state.connected());
    ++cases;
  }
  {
    // The first definitive cause is kept, before and during a stop.
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    assert(state.Event("FATAL", true, "profile_rejected")->reason == "profile_rejected");
    assert(state.Event("FATAL", true, "tls_handshake_failed")->reason == "profile_rejected");
    state.RequestStop();
    assert(!state.Event("FATAL", true, "tls_handshake_failed"));
    assert(state.Complete(false).reason == "profile_rejected");
    assert(state.Complete(true).reason == "profile_rejected");
    ++cases;
  }
  {
    // DISCONNECTED after a recoverable interruption leaves it recoverable: a
    // security failure racing the stop still replaces it.
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    state.Event("PAUSE", false, "");
    assert(state.Event("DISCONNECTED", false, "")->reason == "openvpn_reconnect_required");
    state.RequestStop();
    assert(state.Event("FATAL", true, "openvpn_auth_failed")->reason == "openvpn_auth_failed");
    assert(state.Complete(false).reason == "openvpn_auth_failed");
    ++cases;
  }
  {
    // Alone, DISCONNECTED records a definitive cause: no later event replaces it.
    ConnectionState state;
    state.Event("CONNECTED", false, "");
    state.Event("DISCONNECTED", false, "");
    assert(state.Event("RECONNECTING", false, "")->reason == "tunnel_disconnected");
    assert(state.Event("FATAL", true, "tls_handshake_failed")->reason == "tunnel_disconnected");
    state.RequestStop();
    assert(!state.Event("FATAL", true, "tls_handshake_failed"));
    assert(state.Complete(true).reason == "tunnel_disconnected");
    ++cases;
  }
  return cases;
}

// These assertions exercise the production state machine during compilation
// on every Android ABI, even when no phone is attached. NDEBUG must stay off.
static_assert(LifecycleCases() == 11);
static_assert(CauseAndStopCases() == 5);

int main() {
  std::cout << LifecycleCases() << " native connection lifecycle cases passed\n";
}
