#include <cassert>
#include <algorithm>
#include <atomic>
#include <chrono>
#include <condition_variable>
#include <future>
#include <iostream>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>
#include "../../main/cpp/openvpn_core_adapter.cpp"

// Offline stand-ins for the descriptor calls: numbers only, observed by the
// fixture. A duplicate is the protected number plus 1000.
namespace fuzevpn::openvpn::socket_ops {
int Duplicate(int fd) noexcept {
  std::lock_guard<std::mutex> lock(native_fixture::mutex);
  ++native_fixture::duplicates_open;
  return fd + 1000;
}
void Shutdown(int fd) noexcept {
  std::lock_guard<std::mutex> lock(native_fixture::mutex);
  if (fd == native_fixture::protected_socket + 1000) native_fixture::transport_shutdown = true;
  native_fixture::changed.notify_all();
}
void Close(int) noexcept {
  std::lock_guard<std::mutex> lock(native_fixture::mutex);
  --native_fixture::duplicates_open;
}
}  // namespace fuzevpn::openvpn::socket_ops

using namespace fuzevpn::openvpn;
using namespace std::chrono_literals;
namespace {
// Records every reported state as "state/reason".
class Recorder final : public PlatformCallbacks {
 public:
  void OnCoreState(std::string_view state, std::string_view reason) override {
    std::lock_guard<std::mutex> lock(mutex_);
    states_.push_back(std::string(state) + "/" + std::string(reason));
    changed_.notify_all();
  }
  bool WaitFor(const std::string& entry, std::chrono::milliseconds timeout) {
    std::unique_lock<std::mutex> lock(mutex_);
    return changed_.wait_for(lock, timeout, [&] { return Has(entry); });
  }
  bool Seen(const std::string& entry) {
    std::lock_guard<std::mutex> lock(mutex_);
    return Has(entry);
  }
  int EstablishTun(const TunPlan&) override { return -1; }
  bool ProtectSocket(int) override { return true; }
  std::optional<std::string> PkiCertificate(std::string_view) override { return std::nullopt; }
  std::optional<std::string> PkiSign(std::string_view, std::string_view, std::string_view,
                                    std::string_view, std::string_view) override { return std::nullopt; }

 private:
  bool Has(const std::string& entry) const {
    return std::find(states_.begin(), states_.end(), entry) != states_.end();
  }
  std::mutex mutex_;
  std::condition_variable changed_;
  std::vector<std::string> states_;
};
class Callbacks final : public PlatformCallbacks {
 public:
  std::atomic<bool> throw_state{false};
  int tun_calls = 0;
  void OnCoreState(std::string_view, std::string_view) override {
    if (throw_state) throw std::runtime_error("injected state allocation failure");
  }
  int EstablishTun(const TunPlan&) override { ++tun_calls; return -1; }
  bool ProtectSocket(int) override { return true; }
  std::optional<std::string> PkiCertificate(std::string_view) override { return std::nullopt; }
  std::optional<std::string> PkiSign(std::string_view, std::string_view, std::string_view,
                                    std::string_view, std::string_view) override { return std::nullopt; }
};
ValidatedProfile Profile() { ValidatedProfile p; p.content = "offline synthetic profile"; return p; }
::openvpn::DnsOptions Dns() {
  ::openvpn::DnsOptions options;
  options.servers[0].addresses.push_back({"192.0.2.53", 0});
  return options;
}
}
int main() {
  int cases = 0;
  Callbacks callbacks;
  // The actual adapter requests stop while the fake Core is held before scope
  // registration. Actual pinned Stop::Scope must replay that early request.
  {
    native_fixture::Reset(true);
    OpenVpn3CoreSession session;
    assert(session.Start(Profile(), "offline.alias", &callbacks));
    {
      std::unique_lock<std::mutex> lock(native_fixture::mutex);
      assert(native_fixture::changed.wait_for(lock, 2s, [] { return native_fixture::setup_entered; }));
    }
    auto stopped = std::async(std::launch::async, [&] { session.Stop(); });
    {
      std::unique_lock<std::mutex> lock(native_fixture::mutex);
      assert(native_fixture::changed.wait_for(lock, 2s, [] { return native_fixture::stop_requested; }));
      assert(stopped.wait_for(0ms) == std::future_status::timeout);
      native_fixture::release_setup = true;
      native_fixture::changed.notify_all();
    }
    assert(stopped.wait_for(2s) == std::future_status::ready);
    stopped.get();
    assert(native_fixture::stop_observed && native_fixture::stopped_before_run);
    assert(!session.IsConnected());
    session.Stop(); // repeated stop remains safe
    ++cases;
  }
  // Stop can also win before the worker has entered connect at all.
  for (int iteration = 0; iteration < 50; ++iteration) {
    native_fixture::Reset();
    OpenVpn3CoreSession session;
    assert(session.Start(Profile(), "offline.alias", &callbacks));
    session.Stop();
    assert(native_fixture::stop_observed);
    ++cases;
  }
  {
    native_fixture::Reset();
    native_fixture::throw_connect = true;
    callbacks.throw_state = false;
    OpenVpn3CoreSession session;
    assert(session.Start(Profile(), "offline.alias", &callbacks));
    callbacks.throw_state = true;
    session.Stop(); // reporting failures cannot escape the worker
    callbacks.throw_state = false;
    assert(!session.IsConnected());
    ++cases;
  }
  {
    native_fixture::Reset();
    native_fixture::throw_eval = true;
    OpenVpn3CoreSession session;
    try { session.Start(Profile(), "offline.alias", &callbacks); assert(false); }
    catch (const std::runtime_error&) {}
    session.Stop(); // partially initialized client remains cleanable
    ++cases;
  }
  // A rejected evaluation keeps the stop token without a client: neither Stop
  // nor the next Start may look for a client behind it.
  {
    native_fixture::Reset();
    native_fixture::reject_eval = true;
    OpenVpn3CoreSession session;
    assert(!session.Start(Profile(), "offline.alias", &callbacks));
    assert(!session.IsConnected());
    session.Stop();
    assert(!session.Start(Profile(), "offline.alias", &callbacks));
    native_fixture::reject_eval = false;
    assert(session.Start(Profile(), "offline.alias", &callbacks));
    session.Stop();
    assert(native_fixture::stop_observed && !session.IsConnected());
    ++cases;
  }
  // Start itself cleans what a failed Start left, and stops a running worker.
  {
    native_fixture::Reset();
    native_fixture::throw_eval = true;
    OpenVpn3CoreSession session;
    try { session.Start(Profile(), "offline.alias", &callbacks); assert(false); }
    catch (const std::runtime_error&) {}
    native_fixture::throw_eval = false;
    assert(session.Start(Profile(), "offline.alias", &callbacks));
    assert(session.Start(Profile(), "offline.alias", &callbacks));
    session.Stop();
    assert(native_fixture::stop_observed && !session.IsConnected());
    ++cases;
  }
  // The production pacing: Core ticks every second, 15 silent seconds while
  // connected make a stall, and a stop gets 3 s on its own before the
  // transport is shut down, well inside the 10 s Android waits for it.
  {
    const CoreTimings timings;
    assert(timings.tick == 1000ms && timings.stall_checks == 15 && timings.stop_grace == 3000ms);
    ++cases;
  }
  // The 13 November freeze: a connected worker blocked in a synchronous send
  // whose socket never drains ignores the stop token. Stop must shut the
  // protected transport down to wake it, join it, and close its duplicate.
  {
    native_fixture::Reset();
    native_fixture::hold_send = true;
    Recorder recorder;
    CoreTimings timings;
    timings.stall_checks = 1000;  // Keep stall reports out of this case.
    timings.stop_grace = 100ms;
    OpenVpn3CoreSession session(timings);
    assert(session.Start(Profile(), "offline.alias", &recorder));
    assert(recorder.WaitFor("connected/connected", 2s));
    assert(session.IsConnected());
    {
      // The replaced transport's duplicate is already closed: only the current one is kept.
      std::lock_guard<std::mutex> lock(native_fixture::mutex);
      assert(native_fixture::duplicates_open == 1);
    }
    auto stopped = std::async(std::launch::async, [&] { session.Stop(); });
    // Without the shutdown, Stop waits on the worker forever.
    assert(stopped.wait_for(5s) == std::future_status::ready);
    stopped.get();
    assert(native_fixture::transport_shutdown);
    assert(native_fixture::duplicates_open == 0);
    assert(!session.IsConnected());
    ++cases;
  }
  // The same worker, left alone while connected: it stops ticking, and the
  // session reports a recoverable interruption once instead of staying
  // "connected" with a tunnel that carries nothing.
  {
    native_fixture::Reset();
    native_fixture::hold_send = true;
    Recorder recorder;
    CoreTimings timings;
    timings.tick = 10ms;
    timings.stall_checks = 50;
    timings.stop_grace = 100ms;
    OpenVpn3CoreSession session(timings);
    assert(session.Start(Profile(), "offline.alias", &recorder));
    assert(recorder.WaitFor("connected/connected", 2s));
    assert(recorder.WaitFor("error/openvpn_reconnect_required", 5s));
    assert(!session.IsConnected());
    session.Stop();
    assert(native_fixture::transport_shutdown && native_fixture::duplicates_open == 0);
    ++cases;
  }
  // A handshake longer than the stall limit, without a tick, is not a stall,
  // and it must not end the watch: the stall that follows is still reported.
  {
    native_fixture::Reset();
    native_fixture::hold_send = true;
    native_fixture::connect_delay_ms = 800;
    Recorder recorder;
    CoreTimings timings;
    timings.tick = 10ms;
    timings.stall_checks = 50;
    timings.stop_grace = 100ms;
    OpenVpn3CoreSession session(timings);
    assert(session.Start(Profile(), "offline.alias", &recorder));
    assert(recorder.WaitFor("connected/connected", 3s));
    assert(recorder.WaitFor("error/openvpn_reconnect_required", 5s));
    session.Stop();
    assert(native_fixture::transport_shutdown && native_fixture::duplicates_open == 0);
    ++cases;
  }
  // A healthy worker ticks at the period the session asked Core for: never
  // reported as stalled, and stopped by the token without any shutdown.
  {
    native_fixture::Reset();
    native_fixture::tick = true;
    Recorder recorder;
    CoreTimings timings;
    timings.tick = 10ms;
    timings.stall_checks = 50;
    timings.stop_grace = 2s;
    OpenVpn3CoreSession session(timings);
    assert(session.Start(Profile(), "offline.alias", &recorder));
    assert(native_fixture::clock_tick_ms == 10);
    assert(recorder.WaitFor("connected/connected", 2s));
    std::this_thread::sleep_for(800ms);
    assert(!recorder.Seen("error/openvpn_reconnect_required"));
    assert(session.IsConnected());
    session.Stop();
    assert(native_fixture::stop_observed && !native_fixture::transport_shutdown);
    assert(native_fixture::duplicates_open == 0);
    ++cases;
  }
  {
    ::openvpn::Stop stop;
    AndroidCoreClient client(&callbacks, {}, &stop);
    assert(client.tun_builder_new());
    auto options = Dns();
    assert(client.tun_builder_set_dns_options(options)); ++cases;
    options.servers[0].transport = ::openvpn::DnsServer::Transport::Plain;
    options.servers[0].dnssec = ::openvpn::DnsServer::Security::No;
    assert(client.tun_builder_set_dns_options(options)); ++cases;
    for (const auto transport : {::openvpn::DnsServer::Transport::TLS, ::openvpn::DnsServer::Transport::HTTPS}) {
      options = Dns(); options.servers[0].transport = transport;
      assert(!client.tun_builder_set_dns_options(options)); ++cases;
    }
    for (const auto security : {::openvpn::DnsServer::Security::Yes, ::openvpn::DnsServer::Security::Optional}) {
      options = Dns(); options.servers[0].dnssec = security;
      assert(!client.tun_builder_set_dns_options(options)); ++cases;
    }
    options = Dns(); options.search_domains.push_back({"example.test"});
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    options = Dns(); options.servers[0].domains.push_back({"example.test"});
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    options = Dns(); options.servers[0].sni = "resolver.example.test";
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    options = Dns(); options.servers[0].addresses[0].port = 853;
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    options = Dns(); options.servers[0].addresses[0].address = "2001:db8::53";
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    options = Dns(); options.servers[0].addresses.assign(33, {"192.0.2.53", 0});
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    options = Dns(); options.servers[0].addresses.clear();
    assert(!client.tun_builder_set_dns_options(options)); ++cases;
    // Even a caller that ignores a rejected DNS policy cannot establish a
    // complete plan using the DNS values from a preceding accepted callback.
    assert(client.tun_builder_add_address("10.0.0.2", 32, "", false, false));
    assert(client.tun_builder_reroute_gw(true, false, 0));
    assert(client.tun_builder_establish() == -1); ++cases;
    assert(callbacks.tun_calls == 0);
  }
  std::cout << cases << " original-adapter offline cases passed\n";
}
