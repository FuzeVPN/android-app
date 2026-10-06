// SPDX-License-Identifier: MPL-2.0
//
// This adapter is compiled only after the exact OpenVPN 3 Core source and
// OpenSSL 3.5.9 Android archives have been imported and verified by
// openvpn3_core.cmake. External P-256 signing uses Core's upstream XKey
// provider and never exports the Android Keystore private key.

#include "openvpn_core.h"
#include "openvpn_connection_state.h"

#include <client/ovpncli.cpp>

#include <atomic>
#include <algorithm>
#include <chrono>
#include <condition_variable>
#include <mutex>
#include <thread>
#include <utility>

namespace fuzevpn::openvpn {
namespace {

// The Android v1 OpenVPN profile is explicitly IPv4-only.  Keep this local
// parser independent from Core's address abstractions so a server-pushed IPv6
// DNS address can never reach VpnService.Builder and silently re-enable IPv6.
bool IsIpv4Literal(const std::string& value) {
  if (value.empty() || value.size() > 15) return false;
  int components = 0;
  int digits = 0;
  int number = 0;
  for (const unsigned char character : value) {
    if (character == '.') {
      if (digits == 0 || components >= 3) return false;
      ++components;
      digits = 0;
      number = 0;
      continue;
    }
    if (character < '0' || character > '9') return false;
    ++digits;
    if (digits > 3) return false;
    number = number * 10 + (character - '0');
    if (number > 255) return false;
  }
  return components == 3 && digits > 0;
}

bool HasIpv4FullTunnel(const TunPlan& plan) {
  if (plan.route_ipv4_default) return true;

  bool has_default = false;
  bool has_lower_half = false;
  bool has_upper_half = false;
  for (const TunRoute& route : plan.routes) {
    has_default = has_default ||
                  (route.address == "0.0.0.0" && route.prefix_length == 0);
    has_lower_half = has_lower_half ||
                     (route.address == "0.0.0.0" && route.prefix_length == 1);
    has_upper_half = has_upper_half ||
                     (route.address == "128.0.0.0" && route.prefix_length == 1);
  }
  // OpenVPN's `redirect-gateway def1` is deliberately represented by two
  // non-overlapping /1 routes on some Core paths.  That pair covers exactly
  // the same IPv4 space as a /0 and is therefore a valid full-tunnel plan.
  return has_default || (has_lower_half && has_upper_half);
}

const char* FailureForEvent(const ::openvpn::ClientAPI::Event& event) {
  const std::string& name = event.name;
  if (name.find("EPKI") != std::string::npos) {
    // External PKI is the Android Keystore certificate/signature bridge.
    // Keep the category precise without surfacing Core's potentially
    // sensitive free-form reason text.
    return "openvpn_external_pki_failed";
  }
  if (name == "TLS_ALERT_UNKNOWN_CA") return "tls_alert_unknown_ca";
  if (name == "TLS_ALERT_BAD_CERTIFICATE") return "tls_alert_bad_certificate";
  if (name == "TLS_ALERT_UNSUPPORTED_CERTIFICATE") {
    return "tls_alert_unsupported_certificate";
  }
  if (name == "TLS_SIGALG_DISALLOWED_OR_UNSUPPORTED") {
    return "tls_signature_algorithm_rejected";
  }
  if (name == "TLS_ALERT_HANDSHAKE_FAILURE") return "tls_handshake_rejected";
  if (name == "TLS_ALERT_CERTIFICATE_REQUIRED") {
    return "tls_client_certificate_required";
  }
  if (name == "TLS_ALERT_MISC") return "tls_alert_misc";
  if (name == "TLS_VERSION_MIN" || name == "TLS_ALERT_PROTOCOL_VERSION") {
    return "tls_version_rejected";
  }
  if (name == "TLS_ALERT_CERTIFICATE_EXPIRED") return "tls_certificate_expired";
  if (name == "TLS_ALERT_CERTIFICATE_REVOKED") return "tls_certificate_revoked";
  if (name.find("CERT") != std::string::npos ||
      name.find("VERIFY") != std::string::npos) {
    return "certificate_validation_failed";
  }
  if (name == "AUTH_FAILED") return "openvpn_auth_failed";
  if (name.find("AUTH") != std::string::npos || name.find("TLS") != std::string::npos) {
    return "tls_handshake_failed";
  }
  if (name == "TUN_SETUP_FAILED") return "tun_setup_failed";
  if (name == "TUN_IFACE_CREATE") return "tun_interface_create_failed";
  if (name == "TUN_IFACE_DISABLED") return "tun_interface_disabled";
  if (name == "TUN_HALT") return "tun_halted";
  if (name.find("TUN") != std::string::npos) return "tun_failed";
  if (name == "ERR_INVALID_CONFIG" || name == "ERR_INVALID_OPTION_VAL" ||
      name == "UNUSED_OPTIONS_ERROR") {
    return "profile_rejected";
  }
  if (name == "TRANSPORT_ERROR" || name == "UDP_CONNECT_ERROR") {
    return "transport_failed";
  }
  if (name == "CONNECTION_TIMEOUT") return "openvpn_connection_timeout";
  if (name == "INACTIVE_TIMEOUT") return "openvpn_inactive_timeout";
  if (name == "CLIENT_RESTART") return "openvpn_client_restart";
  if (name == "CLIENT_SETUP") return "openvpn_client_setup_failed";
  if (name == "CLIENT_HALT") return "openvpn_client_halted";
  if (name == "SESSION_EXPIRED") return "openvpn_session_expired";
  if (name == "NEED_CREDS") return "openvpn_credentials_required";
  if (name == "DYNAMIC_CHALLENGE") return "openvpn_dynamic_challenge_required";
  if (name == "PROXY_NEED_CREDS") return "openvpn_proxy_credentials_required";
  if (name == "PROXY_ERROR") return "openvpn_proxy_failed";
  if (name == "RELAY_ERROR") return "openvpn_relay_failed";
  if (name == "COMPRESS_ERROR") return "openvpn_compression_failed";
  if (name == "NTLM_MISSING_CRYPTO") return "openvpn_ntlm_crypto_unavailable";
  if (name == "UNSUPPORTED_FEATURE") return "openvpn_feature_unsupported";
  return "connection_failed";
}

class AndroidCoreClient final : public ::openvpn::ClientAPI::OpenVPNClient {
 public:
  AndroidCoreClient(PlatformCallbacks* callbacks, std::string pki_alias, NetworkPolicy network)
      : callbacks_(callbacks), pki_alias_(std::move(pki_alias)), network_(std::move(network)) {}

  ~AndroidCoreClient() override { CloseTun(); }

  bool pause_on_connection_timeout() override { return false; }

  bool socket_protect(openvpn_io::detail::socket_type socket, std::string,
                      bool) override {
    // Android's VpnService.protect() is required before connecting each
    // transport socket.  There is no permissive fallback because it leaks the
    // OpenVPN control channel into the tunnel.
    return callbacks_ != nullptr && callbacks_->ProtectSocket(static_cast<int>(socket));
  }

  void event(const ::openvpn::ClientAPI::Event& event) override {
    std::string failure = FailureForEvent(event);
    if (event.name.find("TUN") != std::string::npos) {
      std::lock_guard<std::mutex> tun_lock(tun_mutex_);
      if (!tun_failure_reason_.empty()) failure = tun_failure_reason_;
    }
    std::lock_guard<std::mutex> lock(state_mutex_);
    const auto update = connection_state_.Event(event.name, event.error || event.fatal, failure);
    if (update) Emit(update->state, update->reason);
  }

  void acc_event(const ::openvpn::ClientAPI::AppCustomControlMessageEvent&) override {}

  void log(const ::openvpn::ClientAPI::LogInfo&) override {
    // Never retain or surface Core logs: they may contain endpoint or profile
    // material.  State is reported only through normalized event categories.
  }

  void external_pki_cert_request(
      ::openvpn::ClientAPI::ExternalPKICertRequest& request) override {
    if (callbacks_ == nullptr) {
      request.error = true;
      request.errorText = "platform_callback_failed";
      return;
    }
    const auto certificate = callbacks_->PkiCertificate(request.alias);
    if (!certificate || certificate->empty()) {
      request.error = true;
      request.errorText = "platform_identity_unavailable";
      return;
    }
    request.cert = *certificate;
  }

  void external_pki_sign_request(
      ::openvpn::ClientAPI::ExternalPKISignRequest& request) override {
    if (callbacks_ == nullptr) {
      request.error = true;
      request.errorText = "platform_callback_failed";
      return;
    }
    const auto signature = callbacks_->PkiSign(request.alias, request.data,
                                                request.algorithm, request.hashalg,
                                                request.saltlen);
    if (!signature || signature->empty()) {
      request.error = true;
      request.errorText = "platform_signature_failed";
      return;
    }
    request.sig = *signature;
  }

  bool tun_builder_new() override {
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_ = TunPlan{};
    tun_failure_reason_.clear();
    plan_.block_ipv6 = !network_.dual_stack();
    return true;
  }

  bool tun_builder_set_layer(int layer) override { return layer == 3; }

  bool tun_builder_set_remote_address(const std::string&, bool) override {
    // The remote peer's exclusion routing is handled by VpnService.protect(),
    // not by a user-controlled route in the tunnel plan.
    return true;
  }

  bool tun_builder_add_address(const std::string& address, int prefix_length,
                               const std::string&, bool ipv6, bool) override {
    if ((ipv6 && !network_.dual_stack()) || prefix_length < 0 || prefix_length > (ipv6 ? 128 : 32) ||
        !ParseNumericIp(address, ipv6).valid) return false;
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_.addresses.push_back({address, prefix_length});
    return true;
  }

  bool tun_builder_reroute_gw(bool ipv4, bool ipv6, unsigned int) override {
    if (ipv6 && !network_.dual_stack()) return false;
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_.route_ipv4_default = ipv4;
    plan_.route_ipv6_default = ipv6;
    return true;
  }

  bool tun_builder_add_route(const std::string& address, int prefix_length,
                             int, bool ipv6) override {
    if ((ipv6 && !network_.dual_stack()) || prefix_length < 0 || prefix_length > (ipv6 ? 128 : 32) ||
        !ParseNumericIp(address, ipv6).valid) return false;
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_.routes.push_back({address, prefix_length});
    return true;
  }

  bool tun_builder_exclude_route(const std::string&, int, int, bool) override {
    // Android route exclusion semantics vary across supported releases.  The
    // service relies on protect() for the remote socket and rejects further
    // arbitrary exclusions rather than accidentally split-tunnelling.
    return false;
  }

  bool tun_builder_set_dns_options(const ::openvpn::DnsOptions& options) override {
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_.dns_servers.clear();
    for (const auto& [priority, server] : options.servers) {
      (void)priority;
      for (const auto& address : server.addresses) {
        if (address.port != 0 || !IsIpv4Literal(address.address)) return false;
        plan_.dns_servers.push_back(address.address);
      }
    }
    for (const auto& domain : options.search_domains) {
      plan_.search_domains.push_back(domain.domain);
    }
    return !plan_.dns_servers.empty();
  }

  bool tun_builder_set_mtu(int mtu) override {
    if (mtu < (network_.dual_stack() ? 1280 : 576) || mtu > 9000) return false;
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_.mtu = mtu;
    return true;
  }

  bool tun_builder_set_session_name(const std::string& name) override {
    if (name.empty() || name.size() > 80) return false;
    std::lock_guard<std::mutex> lock(tun_mutex_);
    plan_.session_name = name;
    return true;
  }

  bool tun_builder_set_allow_family(int af, bool) override {
    // Never translate this callback into Builder.allowFamily: the complete
    // locally authorized plan decides which families are routed or blocked.
    return af == 2 || af == 10;
  }

  bool tun_builder_set_allow_local_dns(bool allow) override { return !allow; }

  int tun_builder_establish() override {
    std::lock_guard<std::mutex> lock(tun_mutex_);
    // Preserve a precise, non-sensitive failure category.  This lets the
    // Android UI distinguish an incomplete server-pushed plan without ever
    // logging or surfacing the actual address, route, DNS, or profile.
    if (callbacks_ == nullptr) {
      return FailTun("tun_establish_failed");
    }
    if (plan_.addresses.empty()) {
      return FailTun("tun_addresses_missing");
    }
    if (plan_.dns_servers.empty()) {
      return FailTun("tun_dns_missing");
    }
    if (!HasIpv4FullTunnel(plan_)) {
      return FailTun("tun_routes_missing");
    }
    int addresses4 = 0, addresses6 = 0;
    bool matches = true;
    for (const auto& address : plan_.addresses) {
      const bool ipv6 = address.address.find(':') != std::string::npos;
      const auto parsed = ParseNumericIp(address.address, ipv6);
      if (ipv6) ++addresses6; else ++addresses4;
      const auto& expected = ipv6 ? network_.expected_ipv6 : network_.expected_ipv4;
      matches = matches && parsed.valid && (expected.empty() || parsed == ParseNumericIp(expected, ipv6));
    }
    bool full6 = plan_.route_ipv6_default;
    for (const auto& route : plan_.routes) {
      full6 = full6 || (route.prefix_length == 0 && IsDefaultAddress(ParseNumericIp(route.address, true)));
    }
    if (addresses4 != 1 || addresses6 > 1 ||
        !CompleteNetwork(network_.dual_stack(), addresses4 == 1, addresses6 == 1,
                         HasIpv4FullTunnel(plan_), full6, matches, plan_.mtu == 0 ? 1500 : plan_.mtu)) {
      return FailTun("tun_network_mismatch");
    }
    const int result = callbacks_->EstablishTun(plan_);
    if (result >= 0) return result;
    const char* failure = "tun_establish_failed";
    switch (result) {
      case -2: failure = "tun_already_established"; break;
      case -3: failure = "tun_plan_rejected"; break;
      case -4: failure = "tun_addresses_missing"; break;
      case -5: failure = "tun_routes_missing"; break;
      case -6: failure = "tun_dns_missing"; break;
      case -7: failure = "tun_permission_revoked"; break;
      case -8: failure = "tun_establish_returned_null"; break;
      case -9: failure = "tun_establish_exception"; break;
      default: break;
    }
    return FailTun(failure);
  }

  bool tun_builder_persist() override { return false; }

  void tun_builder_teardown(bool) override { CloseTun(); }

  void RequestStop() {
    std::lock_guard<std::mutex> lock(state_mutex_);
    connection_state_.RequestStop();
  }

  void Complete(const ::openvpn::ClientAPI::Status& status) {
    std::lock_guard<std::mutex> lock(state_mutex_);
    const auto update = connection_state_.Complete(status.error);
    Emit(update.state, update.reason);
  }

  bool IsConnected() const {
    std::lock_guard<std::mutex> lock(state_mutex_);
    return connection_state_.connected();
  }

  void Emit(std::string_view state, std::string_view reason) const {
    if (callbacks_ != nullptr) callbacks_->OnCoreState(state, reason);
  }

 private:
  // Called with tun_mutex_ held, in the same lock order as event().
  int FailTun(const char* reason) {
    tun_failure_reason_ = reason;
    std::lock_guard<std::mutex> lock(state_mutex_);
    const auto update = connection_state_.Event("TUN_SETUP_FAILED", true, reason);
    if (update) Emit(update->state, update->reason);
    return -1;
  }

  void CloseTun() {
    // Ownership of the fd transfers to Core after establish().  Core invokes
    // teardown before destroying it; no duplicate close is issued here.
    std::lock_guard<std::mutex> lock(state_mutex_);
    const auto update = connection_state_.Event("TUN_TEARDOWN", false, "");
    if (update) Emit(update->state, update->reason);
  }

  PlatformCallbacks* callbacks_ = nullptr;
  std::string pki_alias_;
  mutable std::mutex state_mutex_;
  ConnectionState connection_state_;
  std::mutex tun_mutex_;
  TunPlan plan_;
  const NetworkPolicy network_;
  std::string tun_failure_reason_;
};

class OpenVpn3CoreSession final : public CoreSession {
 public:
  ~OpenVpn3CoreSession() override { Stop(); }

  bool Start(ValidatedProfile profile, std::string_view pki_alias,
             PlatformCallbacks* callbacks) override {
    Stop();
    if (callbacks == nullptr || !ProfileValidator::IsSafeIdentityAlias(pki_alias)) {
      if (callbacks != nullptr) callbacks->OnCoreState("error", "invalid_identity_alias");
      SecureErase(&profile.content);
      return false;
    }
    client_ = std::make_unique<AndroidCoreClient>(callbacks, std::string(pki_alias), std::move(profile.network));
    ::openvpn::ClientAPI::Config config;
    config.content = std::move(profile.content);
    config.protoVersionOverride = 4;
    config.compressionMode = "no";
    config.externalPkiAlias = std::string(pki_alias);
    config.connTimeout = 30;
    const auto evaluation = client_->eval_config(config);
    if (evaluation.error || !evaluation.externalPki || !evaluation.autologin) {
      SecureErase(&config.content);
      client_->Emit("error", "profile_rejected");
      client_.reset();
      return false;
    }
    callbacks->OnCoreState("connecting", "connecting");
    client_thread_ = std::thread([this, config = std::move(config)]() mutable {
      ::openvpn::ClientAPI::Status status;
      try {
        status = client_->connect();
      } catch (...) {
        // Always publish worker termination, without exporting exception text.
        status.error = true;
      }
      client_->Complete(status);
      SecureErase(&config.content);
    });
    return true;
  }

  void Stop() override {
    if (client_ != nullptr) {
      client_->RequestStop();
      client_->stop();
    }
    if (client_thread_.joinable()) client_thread_.join();
    client_.reset();
  }

  bool IsConnected() const override {
    return client_ != nullptr && client_->IsConnected();
  }

  CoreStatistics Statistics() const override {
    if (client_ == nullptr) return {};
    const auto stats = client_->transport_stats();
    return {
        std::max<long long>(0, stats.bytesIn),
        std::max<long long>(0, stats.bytesOut),
    };
  }

 private:
  std::unique_ptr<AndroidCoreClient> client_;
  std::thread client_thread_;
};

}  // namespace

bool IsCoreAvailable() { return true; }

std::unique_ptr<CoreSession> CreateCoreSession() {
  return std::make_unique<OpenVpn3CoreSession>();
}

}  // namespace fuzevpn::openvpn
