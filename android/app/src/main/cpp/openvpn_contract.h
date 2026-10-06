// SPDX-License-Identifier: MPL-2.0
#pragma once

#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace fuzevpn::openvpn {

// This is the narrow, non-secret boundary between OpenVPN Core and Android.
// The platform service owns VpnService.Builder and Android Keystore.  Core
// receives only a detached TUN file descriptor and PKI callback results.
struct TunAddress {
  std::string address;
  int prefix_length = 0;
};

struct TunRoute {
  std::string address;
  int prefix_length = 0;
};

struct TunPlan {
  std::string session_name;
  int mtu = 0;
  std::vector<TunAddress> addresses;
  std::vector<TunRoute> routes;
  std::vector<std::string> dns_servers;
  std::vector<std::string> search_domains;
  bool route_ipv4_default = false;
  bool route_ipv6_default = false;
  bool block_ipv6 = true;
};

// Implemented by the JNI layer.  Every method must fail closed: a false,
// empty optional, or -1 results in a stopped OpenVPN session.
class PlatformCallbacks {
 public:
  virtual ~PlatformCallbacks() = default;

  // State and reason are stable, non-sensitive categories only.  They are
  // safe to display but must never include profile text, peer names, keys,
  // certificates, server responses, or raw OpenVPN log lines.
  virtual void OnCoreState(std::string_view state,
                           std::string_view reason) = 0;

  // The service must build and establish its VpnService.Builder synchronously
  // and return ParcelFileDescriptor.detachFd(), or -1 on any failure.
  virtual int EstablishTun(const TunPlan& plan) = 0;

  // Calls VpnService.protect(fd).  The transport must not start if it fails.
  virtual bool ProtectSocket(int fd) = 0;

  // External PKI protects the non-exportable P-256 key.  The certificate is
  // PEM; the signature request and result are both base64 text.
  virtual std::optional<std::string> PkiCertificate(
      std::string_view alias) = 0;
  virtual std::optional<std::string> PkiSign(
      std::string_view alias, std::string_view data_base64,
      std::string_view algorithm, std::string_view hash_algorithm,
      std::string_view salt_length) = 0;
};

}  // namespace fuzevpn::openvpn
