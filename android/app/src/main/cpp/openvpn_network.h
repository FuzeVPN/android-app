// SPDX-License-Identifier: MPL-2.0
#pragma once
#include <array>
#include <string>
#include <string_view>

namespace fuzevpn::openvpn {
struct NumericIp {
  std::array<unsigned char, 16> bytes{};
  bool valid = false;
  bool ipv6 = false;
  constexpr bool operator==(const NumericIp&) const = default;
};

// Numeric parsing only; no resolver, scope identifiers or embedded IPv4.
constexpr NumericIp ParseNumericIp(std::string_view text, bool ipv6) {
  NumericIp result{};
  result.ipv6 = ipv6;
  if (text.empty() || text.size() > 45) return result;
  if (!ipv6) {
    int part = 0, digits = 0, value = 0;
    for (const char c : text) {
      if (c == '.') {
        if (!digits || part >= 3) return result;
        result.bytes[part++] = static_cast<unsigned char>(value);
        digits = value = 0;
      } else {
        if (c < '0' || c > '9' || digits >= 3 || (digits && value == 0)) return result;
        value = value * 10 + c - '0';
        if (value > 255) return result;
        ++digits;
      }
    }
    if (part != 3 || !digits) return result;
    result.bytes[3] = static_cast<unsigned char>(value);
  } else {
    std::array<unsigned int, 8> groups{};
    int count = 0, compression = -1;
    size_t pos = 0;
    if (text[0] == ':') {
      if (text.size() < 2 || text[1] != ':') return result;
      compression = 0;
      pos = 2;
    }
    while (pos < text.size()) {
      if (count == 8) return result;
      unsigned int group = 0;
      int digits = 0;
      while (pos < text.size() && text[pos] != ':') {
        const char c = text[pos++];
        const int hex = c >= '0' && c <= '9' ? c - '0' : c >= 'a' && c <= 'f' ? c - 'a' + 10 : c >= 'A' && c <= 'F' ? c - 'A' + 10 : -1;
        if (hex < 0 || ++digits > 4) return result;
        group = (group << 4) | static_cast<unsigned int>(hex);
      }
      if (!digits) return result;
      groups[count++] = group;
      if (pos == text.size()) break;
      ++pos;
      if (pos < text.size() && text[pos] == ':') {
        if (compression >= 0) return result;
        compression = count;
        ++pos;
      } else if (pos == text.size()) return result;
    }
    if ((compression < 0 && count != 8) || (compression >= 0 && count >= 8)) return result;
    const int gap = compression < 0 ? 0 : 8 - count;
    for (int i = 0; i < count; ++i) {
      const int target = i + (compression >= 0 && i >= compression ? gap : 0);
      result.bytes[target * 2] = static_cast<unsigned char>(groups[i] >> 8);
      result.bytes[target * 2 + 1] = static_cast<unsigned char>(groups[i] & 255);
    }
  }
  result.valid = true;
  return result;
}

constexpr bool IsDefaultAddress(const NumericIp& ip) {
  if (!ip.valid) return false;
  for (auto byte : ip.bytes) if (byte != 0) return false;
  return true;
}
constexpr bool CompleteNetwork(bool dual, bool address4, bool address6, bool routes4,
                               bool routes6, bool matches, int mtu) {
  return address4 && address6 == dual && routes4 && routes6 == dual && matches &&
         mtu >= (dual ? 1280 : 576) && mtu <= 9000;
}
struct NetworkPolicy {
  std::string expected_ipv4;
  std::string expected_ipv6;
  bool dual_stack() const { return !expected_ipv6.empty(); }
  bool valid() const {
    const auto v4 = ParseNumericIp(expected_ipv4, false);
    const auto v6 = ParseNumericIp(expected_ipv6, true);
    return (expected_ipv4.empty() || v4.valid) &&
        (!dual_stack() || (v4.valid && v6.valid && (v6.bytes[0] & 0xfe) == 0xfc));
  }
};
constexpr bool ProfileIpv6Allowed(bool dual, bool block, bool filter) {
  return dual ? (!block && !filter) : block;
}
} // namespace fuzevpn::openvpn
