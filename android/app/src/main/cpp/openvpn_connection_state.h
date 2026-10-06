// SPDX-License-Identifier: MPL-2.0
#pragma once

#include <optional>
#include <string>
#include <string_view>

namespace fuzevpn::openvpn {

struct ConnectionUpdate {
  std::string state;
  std::string reason;
};

// Serialized by the adapter. An interrupted handle can never regain a proof:
// recovery belongs to Android and requires a fresh, fully stopped session.
class ConnectionState {
 public:
  constexpr std::optional<ConnectionUpdate> Event(std::string_view name, bool error,
                                       std::string_view failure) {
    if (stopping_) {
      // A definitive security failure can race the external stop following
      // teardown. It must still veto recovery; ordinary shutdown events keep
      // the original cause, and a user-requested stop stays idle.
      if (error && recoverable_ &&
          (failure.starts_with("tls_") || failure == "certificate_validation_failed" ||
           failure == "openvpn_auth_failed" || failure == "tun_permission_revoked")) {
        return Interrupt(failure, false);
      }
      return std::nullopt;
    }
    if (name == "CONNECTED") {
      if (interrupted_ || complete_) return std::nullopt;
      connected_ = true;
      return ConnectionUpdate{"connected", "connected"};
    }
    if (name == "RECONNECTING" || name == "PAUSE" || name == "TUN_TEARDOWN") {
      if (name == "TUN_TEARDOWN" && !connected_) return std::nullopt;
      return Interrupt("openvpn_reconnect_required", true);
    }
    if (error) {
      const bool recoverable = failure == "transport_failed";
      return Interrupt(recoverable ? "openvpn_reconnect_required" : failure, recoverable);
    }
    if (name == "DISCONNECTED") {
      connected_ = false;
      interrupted_ = true;
      if (reason_.empty()) reason_ = "tunnel_disconnected";
      return ConnectionUpdate{"error", reason_};
    }
    return std::nullopt;
  }

  constexpr void RequestStop() { stopping_ = true; connected_ = false; }

  constexpr ConnectionUpdate Complete(bool error) {
    connected_ = false;
    complete_ = true;
    if (!reason_.empty()) return {"error", reason_};
    if (stopping_) return {"idle", "disconnected"};
    return {"error", error ? "openvpn_core_status_error" : "tunnel_disconnected"};
  }

  constexpr bool connected() const { return connected_; }

 private:
  constexpr ConnectionUpdate Interrupt(std::string_view reason, bool recoverable) {
    connected_ = false;
    interrupted_ = true;
    // A security/profile failure outranks a preceding transport interruption;
    // cleanup or another recoverable event must never erase that cause.
    if (reason_.empty() || (recoverable_ && !recoverable)) {
      reason_ = reason;
      recoverable_ = recoverable;
    }
    return {"error", reason_};
  }

  bool connected_ = false;
  bool interrupted_ = false;
  bool stopping_ = false;
  bool complete_ = false;
  bool recoverable_ = false;
  std::string reason_;
};
}  // namespace fuzevpn::openvpn
