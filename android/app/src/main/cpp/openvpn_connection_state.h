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
    if (phase_ == Phase::kStopping) {
      // A definitive security failure can race the external stop following
      // teardown. It must still veto recovery; ordinary shutdown events keep
      // the original cause, and a user-requested stop stays idle.
      if (error && recoverable_ &&
          (failure.starts_with("tls_") || failure == "certificate_validation_failed" ||
           failure == "openvpn_auth_failed" || failure == "tun_permission_revoked")) {
        return RecordCause(failure, false);
      }
      return std::nullopt;
    }
    if (name == "CONNECTED") {
      if (phase_ == Phase::kEnded) return std::nullopt;
      phase_ = Phase::kConnected;
      return ConnectionUpdate{"connected", "connected"};
    }
    if (name == "RECONNECTING" || name == "PAUSE" || name == "TUN_TEARDOWN") {
      if (name == "TUN_TEARDOWN" && !connected()) return std::nullopt;
      return Interrupt("openvpn_reconnect_required", true);
    }
    if (error) {
      const bool recoverable = failure == "transport_failed";
      return Interrupt(recoverable ? "openvpn_reconnect_required" : failure, recoverable);
    }
    if (name == "DISCONNECTED") {
      // Not Interrupt(): Core's last event never replaces an earlier cause,
      // not even a recoverable one, and alone it is definitive.
      phase_ = Phase::kEnded;
      if (reason_.empty()) reason_ = "tunnel_disconnected";
      return ConnectionUpdate{"error", reason_};
    }
    return std::nullopt;
  }

  constexpr void RequestStop() { phase_ = Phase::kStopping; }

  constexpr ConnectionUpdate Complete(bool error) {
    if (phase_ != Phase::kStopping) phase_ = Phase::kEnded;
    if (!reason_.empty()) return {"error", reason_};
    if (phase_ == Phase::kStopping) return {"idle", "disconnected"};
    return {"error", error ? "openvpn_core_status_error" : "tunnel_disconnected"};
  }

  constexpr bool connected() const { return phase_ == Phase::kConnected; }

 private:
  // Forward only: kConnecting -> kConnected -> kEnded (kConnected may be
  // skipped), and kStopping from any of them. kEnded is an interruption or the
  // end of the worker: the proof is gone for good. kStopping is the external
  // stop request; it outlives the end of the worker because it still filters
  // events and decides the final report.
  enum class Phase { kConnecting, kConnected, kEnded, kStopping };

  constexpr ConnectionUpdate Interrupt(std::string_view reason, bool recoverable) {
    phase_ = Phase::kEnded;
    return RecordCause(reason, recoverable);
  }

  constexpr ConnectionUpdate RecordCause(std::string_view reason, bool recoverable) {
    // A security/profile failure outranks a preceding transport interruption;
    // cleanup or another recoverable event must never erase that cause.
    if (reason_.empty() || (recoverable_ && !recoverable)) {
      reason_ = reason;
      recoverable_ = recoverable;
    }
    return {"error", reason_};
  }

  Phase phase_ = Phase::kConnecting;
  // The cause is not a phase: it survives the stop request and the end of the
  // worker. recoverable_ qualifies reason_ and is false while it is empty.
  bool recoverable_ = false;
  std::string reason_;
};
}  // namespace fuzevpn::openvpn
