// Offline host fixture for the original adapter. No socket or VPN is opened.
// Stop/Scope comes from the unmodified pinned Core, including its replay of an
// early stop when the reactor registers its scope.
#pragma once
#include <openvpn/common/stop.hpp>
#include <chrono>
#include <condition_variable>
#include <map>
#include <memory>
#include <mutex>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>

namespace native_fixture {
inline std::mutex mutex;
inline std::condition_variable changed;
inline bool setup_entered = false;
inline bool release_setup = true;
inline bool stop_observed = false;
inline bool stop_requested = false;
inline bool throw_connect = false;
inline bool throw_eval = false;
inline bool reject_eval = false;
inline bool stopped_before_run = false;
// Connected Core whose worker is blocked in a synchronous send that never
// drains: the stop token cannot wake it, only a shutdown of its transport.
inline bool hold_send = false;
// Connected Core whose worker calls clock_tick() at Config::clockTickMS.
inline bool tick = false;
inline unsigned int clock_tick_ms = 0;
// A slow handshake: CONNECTED comes this late, without any clock tick before.
inline int connect_delay_ms = 0;
// The transport is opened twice (a replaced remote): only the second is current.
inline const int replaced_socket = 40;
inline const int protected_socket = 41;
inline bool transport_shutdown = false;
inline int duplicates_open = 0;
inline void Reset(bool hold_setup = false) {
  std::lock_guard<std::mutex> lock(mutex);
  setup_entered = stop_observed = stop_requested = throw_connect = throw_eval = reject_eval = stopped_before_run = false;
  hold_send = tick = transport_shutdown = false;
  clock_tick_ms = 0;
  connect_delay_ms = 0;
  duplicates_open = 0;
  release_setup = !hold_setup;
}
}
namespace openvpn_io::detail { using socket_type = int; }
namespace openvpn {
struct DnsAddress { std::string address; int port = 0; };
struct DnsDomain { std::string domain; };
struct DnsServer {
  enum class Transport { Unset, Plain, HTTPS, TLS };
  enum class Security { Unset, No, Yes, Optional };
  std::vector<DnsAddress> addresses;
  std::vector<DnsDomain> domains;
  Transport transport = Transport::Unset;
  Security dnssec = Security::Unset;
  std::string sni;
};
struct DnsOptions { std::map<int, DnsServer> servers; std::vector<DnsDomain> search_domains; };
namespace ClientAPI {
struct Event { std::string name; bool error = false; bool fatal = false; };
struct AppCustomControlMessageEvent {};
struct LogInfo {};
struct ExternalPKICertRequest { std::string alias, errorText, cert; bool error = false; };
struct ExternalPKISignRequest { std::string alias, data, algorithm, hashalg, saltlen, errorText, sig; bool error = false; };
struct Config {
  std::string content, compressionMode, externalPkiAlias;
  int protoVersionOverride = 0, connTimeout = 0;
  unsigned int clockTickMS = 0;
};
struct EvalConfig { bool error = false, externalPki = true, autologin = true; };
struct Status { bool error = false; };
struct TransportStats { long long bytesIn = 0, bytesOut = 0; };
class OpenVPNClient {
 public:
  virtual ~OpenVPNClient() = default;
  EvalConfig eval_config(const Config& config) {
    if (native_fixture::throw_eval) throw std::runtime_error("injected evaluation failure");
    {
      std::lock_guard<std::mutex> lock(native_fixture::mutex);
      native_fixture::clock_tick_ms = config.clockTickMS;
    }
    EvalConfig evaluation;
    evaluation.error = native_fixture::reject_eval;
    return evaluation;
  }
  Status connect() {
    if (native_fixture::throw_connect) throw std::runtime_error("injected connect failure");
    if (native_fixture::hold_send || native_fixture::tick) return ConnectedSession();
    Stop* const token = get_async_stop();
    Stop::Scope observe_request(token, [] {
      std::lock_guard<std::mutex> lock(native_fixture::mutex);
      native_fixture::stop_requested = true;
      native_fixture::changed.notify_all();
    });
    {
      std::unique_lock<std::mutex> lock(native_fixture::mutex);
      native_fixture::setup_entered = true;
      native_fixture::changed.notify_all();
      native_fixture::changed.wait(lock, [] { return native_fixture::release_setup; });
    }
    Stop::Scope scope(token, [] {
      std::lock_guard<std::mutex> lock(native_fixture::mutex);
      native_fixture::stop_observed = true;
      native_fixture::changed.notify_all();
    });
    std::unique_lock<std::mutex> lock(native_fixture::mutex);
    native_fixture::stopped_before_run = native_fixture::stop_observed;
    native_fixture::changed.wait(lock, [] { return native_fixture::stop_observed; });
    return {};
  }
  // The adapter must use the persistent external token. Calling this fixture
  // method is a regression: it intentionally loses a request before readiness.
  void stop() { throw std::logic_error("nonpersistent stop API must not be used"); }
  TransportStats transport_stats() const { return {}; }
  virtual bool pause_on_connection_timeout() = 0;
  virtual bool socket_protect(openvpn_io::detail::socket_type, std::string, bool) = 0;
  virtual void event(const Event&) = 0;
  virtual void acc_event(const AppCustomControlMessageEvent&) = 0;
  virtual void log(const LogInfo&) = 0;
  virtual void external_pki_cert_request(ExternalPKICertRequest&) = 0;
  virtual void external_pki_sign_request(ExternalPKISignRequest&) = 0;
  virtual bool tun_builder_new() = 0;
  virtual bool tun_builder_set_layer(int) = 0;
  virtual bool tun_builder_set_remote_address(const std::string&, bool) = 0;
  virtual bool tun_builder_add_address(const std::string&, int, const std::string&, bool, bool) = 0;
  virtual bool tun_builder_reroute_gw(bool, bool, unsigned int) = 0;
  virtual bool tun_builder_add_route(const std::string&, int, int, bool) = 0;
  virtual bool tun_builder_exclude_route(const std::string&, int, int, bool) = 0;
  virtual bool tun_builder_set_dns_options(const DnsOptions&) = 0;
  virtual bool tun_builder_set_mtu(int) = 0;
  virtual bool tun_builder_set_session_name(const std::string&) = 0;
  virtual bool tun_builder_set_allow_family(int, bool) = 0;
  virtual bool tun_builder_set_allow_local_dns(bool) = 0;
  virtual int tun_builder_establish() = 0;
  virtual bool tun_builder_persist() = 0;
  virtual void tun_builder_teardown(bool) = 0;
  virtual void clock_tick() {}
 protected:
  virtual Stop* get_async_stop() { return nullptr; }

 private:
  // Protects a transport socket, reports CONNECTED, then either ticks until
  // the stop token fires (a healthy worker) or blocks as a synchronous send
  // whose socket never drains, deaf to the stop token (hold_send).
  Status ConnectedSession() {
    Stop::Scope scope(get_async_stop(), [] {
      std::lock_guard<std::mutex> lock(native_fixture::mutex);
      native_fixture::stop_observed = true;
      native_fixture::changed.notify_all();
    });
    if (!socket_protect(native_fixture::replaced_socket, "", false) ||
        !socket_protect(native_fixture::protected_socket, "", false)) return {true};
    std::this_thread::sleep_for(std::chrono::milliseconds(native_fixture::connect_delay_ms));
    event(Event{"CONNECTED"});
    std::unique_lock<std::mutex> lock(native_fixture::mutex);
    native_fixture::setup_entered = true;
    native_fixture::changed.notify_all();
    if (native_fixture::hold_send) {
      native_fixture::changed.wait(lock, [] { return native_fixture::transport_shutdown; });
      return {};
    }
    const auto period = std::chrono::milliseconds(native_fixture::clock_tick_ms);
    while (!native_fixture::changed.wait_for(lock, period, [] { return native_fixture::stop_observed; })) {
      lock.unlock();
      clock_tick();
      lock.lock();
    }
    return {};
  }
};
}
}
