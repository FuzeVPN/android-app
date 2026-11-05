// SPDX-License-Identifier: MPL-2.0
#pragma once

#include <optional>
#include <string>
#include <string_view>
#include <vector>
#include "openvpn_network.h"

namespace fuzevpn::openvpn {

// Stable failure codes deliberately omit raw profile/server information.
enum class ProfileFailure {
  kNone,
  kTooLarge,
  kInvalidEncoding,
  kForbiddenDirective,
  kMissingRequiredDirective,
  kInvalidRemote,
  kInvalidVerificationName,
  kInvalidCipher,
  kInvalidDns,
  kInvalidCa,
  kInvalidTlsCryptV2,
  kInvalidIdentityAlias,
};

struct ValidatedProfile {
  NetworkPolicy network;
  std::string content;
  std::string remote_ipv4;
  std::string verification_name;
  std::vector<std::string> dns_servers;
  std::vector<std::string> data_ciphers;
};

class ProfileValidator final {
 public:
  static std::optional<ValidatedProfile> Validate(std::string_view profile,
                                                   std::string_view pki_alias,
                                                   ProfileFailure* failure,
                                                   bool dual_stack = false);
  static bool IsSafeIdentityAlias(std::string_view alias);
  static const char* FailureCode(ProfileFailure failure);
};

// Best-effort erasure of temporary native buffers.  It is intentionally kept
// out of log/error paths and is used for profile/PKI strings after use.
void SecureErase(std::string* value) noexcept;

// Owns no storage; erases the referenced temporary on every exit, including
// allocation failures and exceptions during native startup.
class ScopedStringErase final {
 public:
  explicit ScopedStringErase(std::string& value) noexcept : value_(value) {}
  ~ScopedStringErase() { SecureErase(&value_); }
  ScopedStringErase(const ScopedStringErase&) = delete;
  ScopedStringErase& operator=(const ScopedStringErase&) = delete;

 private:
  std::string& value_;
};

}  // namespace fuzevpn::openvpn
