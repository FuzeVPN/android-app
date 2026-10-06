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

// These assertions exercise the production state machine during compilation
// on every Android ABI, even when no phone is attached. NDEBUG must stay off.
static_assert(LifecycleCases() == 11);

int main() {
  std::cout << LifecycleCases() << " native connection lifecycle cases passed\n";
}
