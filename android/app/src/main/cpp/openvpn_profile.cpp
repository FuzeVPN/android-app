// SPDX-License-Identifier: MPL-2.0

#include "openvpn_profile.h"

#include <arpa/inet.h>

#include <algorithm>
#include <array>
#include <cctype>
#include <cstring>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

namespace fuzevpn::openvpn {
namespace {

constexpr size_t kMaxProfileBytes = 64 * 1024;
constexpr size_t kMaxTlsCryptBytes = 8 * 1024;
constexpr size_t kMaxDnsServers = 8;
// Core reads at most 512 bytes per line, newline included
// (ProfileParseLimits::MAX_LINE_SIZE); a longer line fails eval_config.
constexpr size_t kMaxLineBytes = 512;
// Like the former CA length check: a shorter body is no certificate.
constexpr size_t kMinCertificateBodyBytes = 8;
constexpr std::string_view kCaBegin = "-----BEGIN CERTIFICATE-----";
constexpr std::string_view kCaEnd = "-----END CERTIFICATE-----";
constexpr std::string_view kTlsCryptV2Begin = "-----BEGIN OpenVPN tls-crypt-v2 client key-----";
constexpr std::string_view kTlsCryptV2End = "-----END OpenVPN tls-crypt-v2 client key-----";

// Position inside the PEM content of an inline block.
enum class Pem { kExpectBegin, kExpectBody, kInBody, kAfterEnd };

std::string_view Trim(std::string_view value) {
  while (!value.empty() &&
         std::isspace(static_cast<unsigned char>(value.front()))) {
    value.remove_prefix(1);
  }
  while (!value.empty() &&
         std::isspace(static_cast<unsigned char>(value.back()))) {
    value.remove_suffix(1);
  }
  return value;
}

std::vector<std::string_view> Words(std::string_view value) {
  std::vector<std::string_view> words;
  while (!(value = Trim(value)).empty()) {
    const size_t end = value.find_first_of(" \t");
    words.push_back(value.substr(0, end));
    value = end == std::string_view::npos ? std::string_view{} : value.substr(end);
  }
  return words;
}

bool IsIpv4(std::string_view value) {
  if (value.empty() || value.size() > INET_ADDRSTRLEN - 1) return false;
  std::array<char, INET_ADDRSTRLEN> address{};
  std::memcpy(address.data(), value.data(), value.size());
  in_addr parsed{};
  return inet_pton(AF_INET, address.data(), &parsed) == 1;
}

bool IsName(std::string_view value) {
  if (value.empty() || value.size() > 253 || value.front() == '.' ||
      value.back() == '.') {
    return false;
  }
  for (const unsigned char character : value) {
    if (!(std::isalnum(character) || character == '.' || character == '-' ||
          character == '_')) {
      return false;
    }
  }
  return true;
}

// ASCII only: unlike std::isalnum, independent of the process locale.
bool IsAsciiAlnum(unsigned char character) {
  return (character >= 'A' && character <= 'Z') || (character >= 'a' && character <= 'z') ||
         (character >= '0' && character <= '9');
}

bool IsBase64Line(std::string_view line) {
  if (line.empty()) return false;
  for (const unsigned char character : line) {
    if (!(IsAsciiAlnum(character) || character == '+' || character == '/' || character == '=')) {
      return false;
    }
  }
  return true;
}

// Core tokenizes directive lines itself: quotes, backslashes, '#'/';'
// comments, every isspace byte and "<tag>" openers change its reading
// (options.hpp:972-1042). Accept only lines on which that reading is plain
// splitting: words of [A-Za-z0-9._:-] separated by exactly one space. The two
// fully quoted legacy filter words stay accepted; Core only drops the quotes.
bool IsCanonicalDirective(std::string_view line) {
  for (size_t start = 0;;) {
    const size_t space = line.find(' ', start);
    const std::string_view word = line.substr(
        start, space == std::string_view::npos ? std::string_view::npos : space - start);
    if (word.empty()) return false;
    if (word != "\"route-ipv6\"" && word != "\"ifconfig-ipv6\"") {
      for (const unsigned char character : word) {
        if (!(IsAsciiAlnum(character) || character == '.' || character == '-' ||
              character == '_' || character == ':')) {
          return false;
        }
      }
    }
    if (space == std::string_view::npos) return true;
    start = space + 1;
  }
}

bool IsModernCipher(std::string_view cipher) {
  return cipher == "AES-256-GCM" || cipher == "AES-128-GCM" ||
         cipher == "CHACHA20-POLY1305";
}

bool ParseCipherList(std::string_view value, std::vector<std::string>* output) {
  if (value.empty() || value.size() > 256) return false;
  std::set<std::string_view> unique;
  while (!value.empty()) {
    const size_t colon = value.find(':');
    const std::string_view cipher = value.substr(0, colon);
    if (!IsModernCipher(cipher) || !unique.insert(cipher).second) return false;
    output->emplace_back(cipher);
    if (colon == std::string_view::npos) break;
    value.remove_prefix(colon + 1);
  }
  return !output->empty();
}

bool IsPrintableProfileText(std::string_view text) {
  for (size_t index = 0; index < text.size(); ++index) {
    const unsigned char byte = static_cast<unsigned char>(text[index]);
    if (byte == '\0') return false;
    // PEM is ASCII.  Reject control bytes other than the textual line format.
    if (byte < 0x20 && byte != '\n' && byte != '\r' && byte != '\t') return false;
    if (byte >= 0x7f) return false;
    // Core drops every CR that ends a line and splits words on any other CR,
    // so a CR is only unambiguous as part of a CRLF line end.
    if (byte == '\r' && (index + 1 == text.size() || text[index + 1] != '\n')) return false;
  }
  return true;
}

bool IsExact(std::vector<std::string_view> words,
             std::initializer_list<std::string_view> expected) {
  return words.size() == expected.size() &&
         std::equal(words.begin(), words.end(), expected.begin());
}

}  // namespace

void SecureErase(std::string* value) noexcept {
  if (value == nullptr || value->empty()) return;
  volatile char* bytes = value->data();
  for (size_t index = 0; index < value->size(); ++index) bytes[index] = 0;
  value->clear();
}

bool ProfileValidator::IsSafeIdentityAlias(std::string_view alias) {
  if (alias.empty() || alias.size() > 128) return false;
  for (const unsigned char character : alias) {
    if (!(std::isalnum(character) || character == '-' || character == '_' ||
          character == '.')) {
      return false;
    }
  }
  return true;
}

const char* ProfileValidator::FailureCode(ProfileFailure failure) {
  switch (failure) {
    case ProfileFailure::kNone:
      return "none";
    case ProfileFailure::kTooLarge:
      return "profile_too_large";
    case ProfileFailure::kInvalidEncoding:
      return "profile_invalid_encoding";
    case ProfileFailure::kForbiddenDirective:
      return "profile_forbidden_directive";
    case ProfileFailure::kMissingRequiredDirective:
      return "profile_missing_required_directive";
    case ProfileFailure::kInvalidRemote:
      return "profile_invalid_remote";
    case ProfileFailure::kInvalidVerificationName:
      return "profile_invalid_verification_name";
    case ProfileFailure::kInvalidCipher:
      return "profile_invalid_cipher";
    case ProfileFailure::kInvalidDns:
      return "profile_invalid_dns";
    case ProfileFailure::kInvalidCa:
      return "profile_invalid_ca";
    case ProfileFailure::kInvalidTlsCryptV2:
      return "profile_invalid_tls_crypt_v2";
    case ProfileFailure::kInvalidIdentityAlias:
      return "profile_invalid_identity_alias";
  }
  return "profile_rejected";
}

std::optional<ValidatedProfile> ProfileValidator::Validate(
    std::string_view profile, std::string_view pki_alias,
    ProfileFailure* failure, bool dual_stack) {
  auto reject = [failure](ProfileFailure code) -> std::optional<ValidatedProfile> {
    if (failure != nullptr) *failure = code;
    return std::nullopt;
  };
  if (failure != nullptr) *failure = ProfileFailure::kNone;
  if (profile.empty() || profile.size() > kMaxProfileBytes) {
    return reject(ProfileFailure::kTooLarge);
  }
  if (!IsPrintableProfileText(profile)) return reject(ProfileFailure::kInvalidEncoding);
  if (!IsSafeIdentityAlias(pki_alias)) {
    return reject(ProfileFailure::kInvalidIdentityAlias);
  }

  bool has_client = false;
  bool has_dev_tun = false;
  bool has_proto = false;
  bool has_remote = false;
  bool has_nobind = false;
  bool has_remote_cert_tls = false;
  bool has_verify_name = false;
  bool has_auth_nocache = false;
  bool has_no_compression = false;
  bool has_block_ipv6 = false;
  bool has_ipv6_filter = false;
  bool has_data_ciphers = false;
  bool has_external_pki = false;
  bool has_autologin = false;
  bool has_ca = false;
  bool has_tls_crypt_v2 = false;
  bool has_route_ipv6_filter = false;
  bool has_ifconfig_ipv6_filter = false;
  bool in_ca = false;
  bool in_tls_crypt_v2 = false;
  Pem pem = Pem::kExpectBegin;
  size_t certificate_body_bytes = 0;
  size_t tls_crypt_v2_size = 0;
  ValidatedProfile result;

  size_t cursor = 0;
  while (cursor <= profile.size()) {
    const size_t end = profile.find('\n', cursor);
    const size_t count = end == std::string_view::npos ? profile.size() - cursor : end - cursor;
    std::string_view line = profile.substr(cursor, count);
    if (!line.empty() && line.back() == '\r') line.remove_suffix(1);
    cursor = end == std::string_view::npos ? profile.size() + 1 : end + 1;
    // Compare exactly the bytes Core keeps: the line without its LF or CRLF.
    // Trimming more let " </ca>" close <ca> here but not in Core, and the
    // following lines then reached Core as directives.
    if (count + 1 > kMaxLineBytes) {
      return reject(in_ca ? ProfileFailure::kInvalidCa
                    : in_tls_crypt_v2 ? ProfileFailure::kInvalidTlsCryptV2
                                      : ProfileFailure::kForbiddenDirective);
    }

    if (in_ca) {
      if (line == "</ca>") {
        if (pem != Pem::kAfterEnd) return reject(ProfileFailure::kInvalidCa);
        in_ca = false;
        continue;
      }
      // CERTIFICATE PEM blocks only, optionally separated by empty lines: no
      // line Core could read as a tag, a comment or a meta option.
      if (line == kCaBegin && (pem == Pem::kExpectBegin || pem == Pem::kAfterEnd)) {
        pem = Pem::kExpectBody;
        certificate_body_bytes = 0;
      } else if (IsBase64Line(line) && (pem == Pem::kExpectBody || pem == Pem::kInBody)) {
        pem = Pem::kInBody;
        certificate_body_bytes += line.size();
      } else if (line == kCaEnd && pem == Pem::kInBody &&
                 certificate_body_bytes >= kMinCertificateBodyBytes) {
        pem = Pem::kAfterEnd;
      } else if (!(line.empty() && pem == Pem::kAfterEnd)) {
        return reject(ProfileFailure::kInvalidCa);
      }
      continue;
    }
    if (in_tls_crypt_v2) {
      if (line == "</tls-crypt-v2>") {
        if (pem != Pem::kAfterEnd) return reject(ProfileFailure::kInvalidTlsCryptV2);
        in_tls_crypt_v2 = false;
        continue;
      }
      if (tls_crypt_v2_size + line.size() + 1 > kMaxTlsCryptBytes) {
        return reject(ProfileFailure::kInvalidTlsCryptV2);
      }
      // Only presence and size are needed here. Do not duplicate this secret
      // into a second heap allocation just to validate its container.
      tls_crypt_v2_size += line.size() + 1;
      // Exactly one client-key PEM block, nothing else.
      if (line == kTlsCryptV2Begin && pem == Pem::kExpectBegin) {
        pem = Pem::kExpectBody;
      } else if (IsBase64Line(line) && (pem == Pem::kExpectBody || pem == Pem::kInBody)) {
        pem = Pem::kInBody;
      } else if (line == kTlsCryptV2End && pem == Pem::kInBody) {
        pem = Pem::kAfterEnd;
      } else {
        return reject(ProfileFailure::kInvalidTlsCryptV2);
      }
      continue;
    }

    if (line.empty()) continue;
    // Comments make canonical validation ambiguous; native profiles are
    // generated programmatically, so comments are not part of this contract.
    if (line.starts_with('#') || line.starts_with(';')) {
      return reject(ProfileFailure::kForbiddenDirective);
    }
    if (line == "<ca>") {
      if (has_ca) return reject(ProfileFailure::kForbiddenDirective);
      has_ca = true;
      in_ca = true;
      pem = Pem::kExpectBegin;
      continue;
    }
    if (line == "<tls-crypt-v2>") {
      if (has_tls_crypt_v2) return reject(ProfileFailure::kForbiddenDirective);
      has_tls_crypt_v2 = true;
      in_tls_crypt_v2 = true;
      pem = Pem::kExpectBegin;
      continue;
    }
    // Inline certificate/key material is deliberately forbidden.  The client
    // certificate and P-256 private key are supplied by External PKI instead.
    if (line.starts_with('<') || line.starts_with("key ") ||
        line.starts_with("cert ") || line.starts_with("ca ") || !IsCanonicalDirective(line)) {
      return reject(ProfileFailure::kForbiddenDirective);
    }

    const std::vector<std::string_view> words = Words(line);
    if (words.empty()) continue;
    if (IsExact(words, {"client"})) {
      if (has_client) return reject(ProfileFailure::kForbiddenDirective);
      has_client = true;
    } else if (IsExact(words, {"dev", "tun"})) {
      if (has_dev_tun) return reject(ProfileFailure::kForbiddenDirective);
      has_dev_tun = true;
    } else if (IsExact(words, {"proto", "udp4"})) {
      if (has_proto) return reject(ProfileFailure::kForbiddenDirective);
      has_proto = true;
    } else if (words[0] == "remote") {
      if (has_remote || words.size() != 3 || !IsIpv4(words[1]) || words[2] != "1194") {
        return reject(ProfileFailure::kInvalidRemote);
      }
      has_remote = true;
      result.remote_ipv4.assign(words[1]);
    } else if (IsExact(words, {"nobind"})) {
      if (has_nobind) return reject(ProfileFailure::kForbiddenDirective);
      has_nobind = true;
    } else if (IsExact(words, {"remote-cert-tls", "server"})) {
      if (has_remote_cert_tls) return reject(ProfileFailure::kForbiddenDirective);
      has_remote_cert_tls = true;
    } else if (words[0] == "verify-x509-name") {
      if (has_verify_name || words.size() != 3 || words[2] != "name" ||
          !IsName(words[1])) {
        return reject(ProfileFailure::kInvalidVerificationName);
      }
      has_verify_name = true;
      result.verification_name.assign(words[1]);
    } else if (IsExact(words, {"EXTERNAL_PKI", "true"})) {
      if (has_external_pki) return reject(ProfileFailure::kForbiddenDirective);
      has_external_pki = true;
    } else if (IsExact(words, {"AUTOLOGIN", "true"})) {
      if (has_autologin) return reject(ProfileFailure::kForbiddenDirective);
      has_autologin = true;
    } else if (IsExact(words, {"auth-nocache"})) {
      if (has_auth_nocache) return reject(ProfileFailure::kForbiddenDirective);
      has_auth_nocache = true;
    } else if (IsExact(words, {"allow-compression", "no"})) {
      if (has_no_compression) return reject(ProfileFailure::kForbiddenDirective);
      has_no_compression = true;
    } else if (IsExact(words, {"block-ipv6"})) {
      if (has_block_ipv6) return reject(ProfileFailure::kForbiddenDirective);
      has_block_ipv6 = true;
    } else if (words[0] == "data-ciphers") {
      if (has_data_ciphers || words.size() != 2 ||
          !ParseCipherList(words[1], &result.data_ciphers)) {
        return reject(ProfileFailure::kInvalidCipher);
      }
      has_data_ciphers = true;
    } else if (words[0] == "dhcp-option") {
      if (words.size() != 3 || words[1] != "DNS" || !IsIpv4(words[2]) ||
          result.dns_servers.size() >= kMaxDnsServers) {
        return reject(ProfileFailure::kInvalidDns);
      }
      result.dns_servers.emplace_back(words[2]);
    } else if (IsExact(words, {"pull-filter", "ignore", "route-ipv6"}) ||
               IsExact(words, {"pull-filter", "ignore", "\"route-ipv6\""})) {
      // Each filter once: repeated lines could overflow Core's option budget.
      if (has_route_ipv6_filter) return reject(ProfileFailure::kForbiddenDirective);
      has_route_ipv6_filter = true;
      has_ipv6_filter = true;
    } else if (IsExact(words, {"pull-filter", "ignore", "ifconfig-ipv6"}) ||
               IsExact(words, {"pull-filter", "ignore", "\"ifconfig-ipv6\""})) {
      if (has_ifconfig_ipv6_filter) return reject(ProfileFailure::kForbiddenDirective);
      has_ifconfig_ipv6_filter = true;
      has_ipv6_filter = true;
    } else {
      // This excludes scripts, management, proxy, username/password auth,
      // compression, arbitrary files, static routes and unknown directives.
      return reject(ProfileFailure::kForbiddenDirective);
    }
  }

  if (in_ca || in_tls_crypt_v2) return reject(ProfileFailure::kForbiddenDirective);
  if (!(has_client && has_dev_tun && has_proto && has_remote && has_nobind &&
        has_remote_cert_tls && has_verify_name && has_auth_nocache &&
        has_no_compression && ProfileIpv6Allowed(dual_stack, has_block_ipv6, has_ipv6_filter) && has_data_ciphers &&
        has_external_pki && has_autologin && has_ca && has_tls_crypt_v2 &&
        !result.dns_servers.empty())) {
    return reject(ProfileFailure::kMissingRequiredDirective);
  }

  result.content.assign(profile);
  return result;
}

}  // namespace fuzevpn::openvpn
