#include <cassert>
#include <atomic>
#include <chrono>
#include <future>
#include <iostream>
#include <stdexcept>
#include "../../main/cpp/openvpn_core_adapter.cpp"

using namespace fuzevpn::openvpn;
using namespace std::chrono_literals;
namespace {
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
  {
    ::openvpn::Stop stop;
    AndroidCoreClient client(&callbacks, "offline.alias", {}, &stop);
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
