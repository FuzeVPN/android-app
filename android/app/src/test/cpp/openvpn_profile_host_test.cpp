// SPDX-License-Identifier: MPL-2.0
//
// A12-openvpn-native-01 regression: differential host test of the original
// native profile validator against the unmodified pinned OpenVPN 3 Core parser.
//
// ProfileValidator::Validate (openvpn_profile.cpp, compiled unchanged) decides
// which profile text reaches Core. The adapter hands that exact text to
// eval_config, which parses it with ParseClientConfig::parse
// (client/ovpncli.cpp:620). CoreParse() below makes the same OptionList calls
// with the same limits (cliopthelper.hpp:346-354; the adapter sets no
// contentList).
//
// Property checked for every case, including a deterministic mutation corpus:
// when the validator accepts a profile, Core parses it and sees only the
// allowlisted directives, each with the value the validator returned, plus the
// two inline PEM blocks, and no meta option. Offline: synthetic PEM,
// documentation addresses (RFC 5737), no network and no secret.
#include <openvpn/io/io.hpp>
#include <openvpn/log/logsimple.hpp>
#include <openvpn/common/options.hpp>
#include <openvpn/client/cliconstants.hpp>

#include <algorithm>
#include <cstddef>
#include <exception>
#include <initializer_list>
#include <iostream>
#include <map>
#include <optional>
#include <random>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "../../main/cpp/openvpn_profile.h"

using fuzevpn::openvpn::ProfileFailure;
using fuzevpn::openvpn::ProfileValidator;
using fuzevpn::openvpn::ValidatedProfile;

namespace {

const std::string kCaBegin = "-----BEGIN CERTIFICATE-----";
const std::string kCaEnd = "-----END CERTIFICATE-----";
const std::string kKeyBegin = "-----BEGIN OpenVPN tls-crypt-v2 client key-----";
const std::string kKeyEnd = "-----END OpenVPN tls-crypt-v2 client key-----";
// Synthetic placeholders of the audit reproduction (base64 of ASCII text).
const std::string kCaBody = "QUExMi1jYS1wbGFjZWhvbGRlcg==";
const std::string kKeyBody = "QUExMi10bHMtcGxhY2Vob2xkZXI=";
const std::string kCa = kCaBegin + "\n" + kCaBody + "\n" + kCaEnd;
const std::string kKey = kKeyBegin + "\n" + kKeyBody + "\n" + kKeyEnd;
constexpr std::string_view kAlias = "fuzevpn.openvpn.a12";

// Exact profiles written by the production Kotlin builder during the audit
// (audit-complet-20261028/checks/A12-openvpn-native/kotlin-profiles/*.ovpn).
const std::string kAuditHead = R"(client
dev tun
proto udp4
remote 192.0.2.10 1194
nobind
remote-cert-tls server
verify-x509-name vpn.example.test name
EXTERNAL_PKI true
AUTOLOGIN true
auth-nocache
allow-compression no
block-ipv6
pull-filter ignore route-ipv6
pull-filter ignore ifconfig-ipv6
data-ciphers AES-256-GCM
dhcp-option DNS 192.0.2.53
)";
const std::string kAuditHonest = kAuditHead + R"(<ca>
-----BEGIN CERTIFICATE-----
QUExMi1jYS1wbGFjZWhvbGRlcg==
-----END CERTIFICATE-----
</ca>
<tls-crypt-v2>
-----BEGIN OpenVPN tls-crypt-v2 client key-----
QUExMi10bHMtcGxhY2Vob2xkZXI=
-----END OpenVPN tls-crypt-v2 client key-----
</tls-crypt-v2>
)";
const std::string kAuditCaInjection = kAuditHead + R"(<ca>
-----BEGIN CERTIFICATE-----
QUExMi1jYS1wbGFjZWhvbGRlcg==
-----END CERTIFICATE-----
 </ca>
<tls-crypt-v2>
</ca>
http-proxy 203.0.113.80 8080
remote 203.0.113.9 443 tcp
allow-compression yes
tls-cert-profile insecure
<tls-crypt-v2>
-----END CERTIFICATE-----
</ca>
<tls-crypt-v2>
-----BEGIN OpenVPN tls-crypt-v2 client key-----
QUExMi10bHMtcGxhY2Vob2xkZXI=
-----END OpenVPN tls-crypt-v2 client key-----
</tls-crypt-v2>
)";
const std::string kAuditTlsMetaInjection = kAuditHead + R"(<ca>
-----BEGIN CERTIFICATE-----
QUExMi1jYS1wbGFjZWhvbGRlcg==
-----END CERTIFICATE-----
</ca>
<tls-crypt-v2>
# OVPN_ACCESS_SERVER_tls-cert-profile=insecure
-----BEGIN OpenVPN tls-crypt-v2 client key-----
QUExMi10bHMtcGxhY2Vob2xkZXI=
-----END OpenVPN tls-crypt-v2 client key-----
</tls-crypt-v2>
)";

int checks = 0;
int failures = 0;

std::string Printable(std::string_view text, size_t limit = 600) {
  static constexpr char kHex[] = "0123456789abcdef";
  std::string out;
  for (const char c : text.substr(0, limit)) {
    const unsigned char byte = static_cast<unsigned char>(c);
    if (byte == '\n') {
      out += "\\n";
    } else if (byte == '\r') {
      out += "\\r";
    } else if (byte == '\t') {
      out += "\\t";
    } else if (byte < 0x20 || byte >= 0x7f) {
      out += "\\x";
      out += kHex[byte >> 4];
      out += kHex[byte & 15];
    } else {
      out += c;
    }
  }
  if (text.size() > limit) out += "...";
  return out;
}

void Check(bool condition, const std::string& label) {
  ++checks;
  if (condition) return;
  ++failures;
  std::cout << "FAIL " << label << "\n";
}

std::string Join(const std::vector<std::string>& parts, std::string_view separator) {
  std::string text;
  for (size_t index = 0; index < parts.size(); ++index) {
    if (index != 0) text += separator;
    text += parts[index];
  }
  return text;
}

std::vector<std::string> SplitLines(const std::string& text) {
  std::vector<std::string> lines;
  size_t start = 0;
  while (start < text.size()) {
    const size_t end = text.find('\n', start);
    if (end == std::string::npos) {
      lines.push_back(text.substr(start));
      break;
    }
    lines.push_back(text.substr(start, end - start));
    start = end + 1;
  }
  return lines;
}

std::string Replace(std::string text, std::string_view from, std::string_view to) {
  for (size_t at = text.find(from); at != std::string::npos; at = text.find(from, at + to.size())) {
    text.replace(at, from.size(), to);
  }
  return text;
}

const char* Code(ProfileFailure failure) { return ProfileValidator::FailureCode(failure); }

// Kotlin's String.trim() as OpenVpnActivation applies it to both PEM fields.
std::string KotlinTrim(std::string text) {
  const auto space = [](char c) {
    return c == ' ' || c == '\t' || c == '\r' || c == '\n' || c == '\v' || c == '\f';
  };
  while (!text.empty() && space(text.back())) text.pop_back();
  size_t start = 0;
  while (start < text.size() && space(text[start])) ++start;
  return text.substr(start);
}

struct Spec {
  std::string endpoint = "192.0.2.10";
  std::string server_name = "vpn.example.test";
  std::vector<std::string> dns{"192.0.2.53"};
  std::vector<std::string> ciphers{"AES-256-GCM"};
  bool dual_stack = false;
  std::string ca = kCa;
  std::string key = kKey;
};

// Same lines, order and separators as OpenVpnActivation.toCanonicalProfile()
// (OpenVpnController.kt:1323-1351).
std::string Build(const Spec& spec) {
  std::string profile;
  const auto add = [&profile](const std::string& text) {
    profile += text;
    profile += '\n';
  };
  add("client");
  add("dev tun");
  add("proto udp4");
  add("remote " + spec.endpoint + " 1194");
  add("nobind");
  add("remote-cert-tls server");
  add("verify-x509-name " + spec.server_name + " name");
  add("EXTERNAL_PKI true");
  add("AUTOLOGIN true");
  add("auth-nocache");
  add("allow-compression no");
  if (!spec.dual_stack) {
    add("block-ipv6");
    add("pull-filter ignore route-ipv6");
    add("pull-filter ignore ifconfig-ipv6");
  }
  add("data-ciphers " + Join(spec.ciphers, ":"));
  for (const auto& server : spec.dns) add("dhcp-option DNS " + server);
  add("<ca>");
  add(KotlinTrim(spec.ca));
  add("</ca>");
  add("<tls-crypt-v2>");
  add(KotlinTrim(spec.key));
  add("</tls-crypt-v2>");
  return profile;
}

std::string Certificate(char fill, size_t body_chars) {
  std::string pem = kCaBegin + "\n";
  for (size_t done = 0; done < body_chars; done += 64) {
    pem.append(std::min<size_t>(64, body_chars - done), fill);
    pem += '\n';
  }
  return pem + kCaEnd;
}

// A tls-crypt-v2 PEM whose block content (each line plus its newline, as the
// validator counts it) is exactly `container_bytes` long.
std::string KeyWithContainerBytes(size_t container_bytes) {
  size_t left = container_bytes - (kKeyBegin.size() + 1) - (kKeyEnd.size() + 1);
  std::string pem = kKeyBegin + "\n";
  while (left > 0) {
    const size_t take = left == 66 ? 63 : std::min<size_t>(64, left - 1);
    pem.append(take, 'A');
    pem += '\n';
    left -= take + 1;
  }
  return pem + kKeyEnd;
}

struct CoreView {
  bool parsed = false;
  std::string error;
  openvpn::OptionList options;
};

CoreView CoreParse(const std::string& profile) {
  namespace limits = openvpn::ProfileParseLimits;
  CoreView view;
  try {
    openvpn::OptionList::Limits budget("profile is too large", limits::MAX_PROFILE_SIZE,
                                       limits::OPT_OVERHEAD, limits::TERM_OVERHEAD,
                                       limits::MAX_LINE_SIZE, limits::MAX_DIRECTIVE_SIZE);
    view.options.parse_from_config(profile, &budget);
    view.options.parse_meta_from_config(profile, "OVPN_ACCESS_SERVER", &budget);
    view.options.update_map();
    view.parsed = true;
  } catch (const std::exception& error) {
    view.error = error.what();
  }
  return view;
}

// "name arg...", prefixed with "meta " when Core flagged the option as a meta
// option (inline blocks are flagged too).
std::string RenderOption(const openvpn::Option& option) {
  std::string entry = option.meta() ? "meta " : "";
  for (size_t index = 0; index < option.size(); ++index) {
    if (index != 0) entry += ' ';
    entry += option.ref(index);
  }
  return entry;
}

std::vector<std::string> Render(const openvpn::OptionList& options) {
  std::vector<std::string> rendered;
  for (const auto& option : options) rendered.push_back(RenderOption(option));
  return rendered;
}

// What Core stores for an inline block: every line without its CR/LF end,
// each followed by '\n'.
std::string BlockBody(const std::string& pem) {
  std::string body;
  for (std::string line : SplitLines(pem)) {
    while (!line.empty() && line.back() == '\r') line.pop_back();
    body += line;
    body += '\n';
  }
  return body;
}

std::vector<std::string> Expected(const Spec& spec) {
  std::vector<std::string> expected{"client",
                                    "dev tun",
                                    "proto udp4",
                                    "remote " + spec.endpoint + " 1194",
                                    "nobind",
                                    "remote-cert-tls server",
                                    "verify-x509-name " + spec.server_name + " name",
                                    "EXTERNAL_PKI true",
                                    "AUTOLOGIN true",
                                    "auth-nocache",
                                    "allow-compression no"};
  if (!spec.dual_stack) {
    expected.insert(expected.end(), {"block-ipv6", "pull-filter ignore route-ipv6",
                                     "pull-filter ignore ifconfig-ipv6"});
  }
  expected.push_back("data-ciphers " + Join(spec.ciphers, ":"));
  for (const auto& server : spec.dns) expected.push_back("dhcp-option DNS " + server);
  expected.push_back("meta ca " + BlockBody(KotlinTrim(spec.ca)));
  expected.push_back("meta tls-crypt-v2 " + BlockBody(KotlinTrim(spec.key)));
  return expected;
}

bool IsBase64Text(std::string_view line) {
  if (line.empty()) return false;
  for (const char c : line) {
    if (!((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') ||
          c == '+' || c == '/' || c == '=')) {
      return false;
    }
  }
  return true;
}

// Independent check of a block as Core stored it: PEM armour and base64 only,
// so Core closed the block exactly where the validator did.
bool IsPemBody(const std::string& body, const std::string& begin, const std::string& end,
               bool single) {
  if (body.empty() || body.back() != '\n') return false;
  size_t blocks = 0;
  bool inside = false;
  bool has_data = false;
  for (const auto& line : SplitLines(body)) {
    if (!inside) {
      if (line == begin) {
        inside = true;
        has_data = false;
        ++blocks;
      } else if (!(line.empty() && !single && blocks > 0)) {
        return false;
      }
    } else if (line == end) {
      if (!has_data) return false;
      inside = false;
    } else if (IsBase64Text(line)) {
      has_data = true;
    } else {
      return false;
    }
  }
  return !inside && blocks >= 1 && (!single || blocks == 1);
}

struct Findings {
  // Core refuses the profile the validator accepted (fails closed).
  std::string parse_error;
  // Directives, meta options or counts Core would act on outside the
  // allowlist: the A12 property itself.
  std::vector<std::string> directives;
  // Inline blocks whose content, as Core stored it, is not PEM only.
  std::vector<std::string> blocks;
  bool empty() const { return parse_error.empty() && directives.empty() && blocks.empty(); }
};

// Empty when Core sees exactly what the validator accepted.
Findings Violation(const CoreView& core, const ValidatedProfile& native, bool dual_stack) {
  Findings findings;
  std::vector<std::string>& problems = findings.directives;
  if (!core.parsed) {
    findings.parse_error = core.error.empty() ? "unknown error" : core.error;
    return findings;
  }
  std::map<std::string, int> counts;
  std::vector<std::string> dns;
  for (const auto& option : core.options) {
    if (option.size() == 0) {
      problems.push_back("an empty option");
      continue;
    }
    const std::string& name = option.ref(0);
    std::vector<std::string> args;
    for (size_t index = 1; index < option.size(); ++index) args.push_back(option.ref(index));
    ++counts[name];
    const bool block = name == "ca" || name == "tls-crypt-v2";
    const auto is = [&args](std::initializer_list<std::string_view> expected) {
      return args.size() == expected.size() && std::equal(args.begin(), args.end(), expected.begin());
    };
    bool allowed = false;
    if (option.meta() && !block) {
      allowed = false;
    } else if (name == "client" || name == "nobind" || name == "auth-nocache" ||
               name == "block-ipv6") {
      allowed = args.empty();
    } else if (name == "dev") {
      allowed = is({"tun"});
    } else if (name == "proto") {
      allowed = is({"udp4"});
    } else if (name == "remote") {
      allowed = is({native.remote_ipv4, "1194"});
    } else if (name == "remote-cert-tls") {
      allowed = is({"server"});
    } else if (name == "verify-x509-name") {
      allowed = is({native.verification_name, "name"});
    } else if (name == "EXTERNAL_PKI" || name == "AUTOLOGIN") {
      allowed = is({"true"});
    } else if (name == "allow-compression") {
      allowed = is({"no"});
    } else if (name == "pull-filter") {
      allowed = !dual_stack && (is({"ignore", "route-ipv6"}) || is({"ignore", "ifconfig-ipv6"}));
    } else if (name == "data-ciphers") {
      allowed = is({Join(native.data_ciphers, ":")});
    } else if (name == "dhcp-option") {
      allowed = args.size() == 2 && args[0] == "DNS";
      if (allowed) dns.push_back(args[1]);
    } else if (block) {
      allowed = option.meta() && args.size() == 1;
      const bool pem = allowed && (name == "ca" ? IsPemBody(args[0], kCaBegin, kCaEnd, false)
                                                : IsPemBody(args[0], kKeyBegin, kKeyEnd, true));
      if (allowed && !pem) findings.blocks.push_back("'" + Printable(RenderOption(option), 120) + "'");
    }
    if (!allowed) problems.push_back("'" + Printable(RenderOption(option), 120) + "'");
  }
  for (const char* name : {"client", "dev", "proto", "remote", "nobind", "remote-cert-tls",
                           "verify-x509-name", "EXTERNAL_PKI", "AUTOLOGIN", "auth-nocache",
                           "allow-compression", "data-ciphers", "ca", "tls-crypt-v2"}) {
    if (counts[name] != 1) {
      problems.push_back(std::string(name) + " " + std::to_string(counts[name]) + " times");
    }
  }
  if (counts["block-ipv6"] != (dual_stack ? 0 : 1)) {
    problems.push_back("block-ipv6 " + std::to_string(counts["block-ipv6"]) + " times");
  }
  if (dns.empty() || dns != native.dns_servers) {
    problems.push_back("DNS servers other than the validated ones");
  }
  return findings;
}

ValidatedProfile HonestView() {
  ValidatedProfile view;
  view.remote_ipv4 = "192.0.2.10";
  view.verification_name = "vpn.example.test";
  view.dns_servers = {"192.0.2.53"};
  view.data_ciphers = {"AES-256-GCM"};
  return view;
}

struct Verdict {
  std::optional<ValidatedProfile> validated;
  ProfileFailure failure = ProfileFailure::kNone;
  Findings findings;  // Core view of an accepted profile
};

Verdict Evaluate(const std::string& profile, bool dual_stack) {
  Verdict verdict;
  verdict.validated = ProfileValidator::Validate(profile, kAlias, &verdict.failure, dual_stack);
  if (verdict.validated) {
    verdict.findings = Violation(CoreParse(profile), *verdict.validated, dual_stack);
  }
  return verdict;
}

// [divergence]: Core would act on something outside the allowlist (the A12
// property). [block-content]: an inline block Core keeps is not PEM only.
// [core-refuses]: Core rejects what the validator accepted (fails closed).
// [canonical]: any accepted counter-example, even one Core reads harmlessly.
void ReportFindings(const std::string& label, const Findings& findings) {
  Check(findings.parse_error.empty(),
        "[core-refuses] " + label + ": accepted natively, Core refuses it (" + findings.parse_error + ")");
  Check(findings.directives.empty(),
        "[divergence] " + label + ": accepted natively, Core acts on " + Join(findings.directives, "; "));
  Check(findings.blocks.empty(),
        "[block-content] " + label + ": accepted natively, Core keeps " + Join(findings.blocks, "; "));
}

void ExpectRejected(const std::string& label, const std::string& profile, bool dual_stack = false,
                    std::optional<ProfileFailure> code = std::nullopt) {
  const Verdict verdict = Evaluate(profile, dual_stack);
  if (verdict.validated) {
    ReportFindings(label, verdict.findings);
    Check(false, "[canonical] " + label + ": accepted natively");
    return;
  }
  Check(true, label);
  if (code) {
    Check(verdict.failure == *code, label + ": failure " + Code(verdict.failure) +
                                        " instead of " + Code(*code));
  }
}

void ExpectLegitimate(const std::string& label, const Spec& spec, const std::string& profile) {
  const Verdict verdict = Evaluate(profile, spec.dual_stack);
  Check(verdict.validated.has_value(), label + ": rejected (" + Code(verdict.failure) + ")");
  if (!verdict.validated) return;
  ReportFindings(label, verdict.findings);
  const ValidatedProfile& native = *verdict.validated;
  Check(native.content == profile, label + ": validated content differs from the input");
  Check(native.remote_ipv4 == spec.endpoint && native.verification_name == spec.server_name &&
            native.dns_servers == spec.dns && native.data_ciphers == spec.ciphers,
        label + ": validated values differ from the profile");
  const CoreView core = CoreParse(profile);
  Check(core.parsed && Render(core.options) == Expected(spec),
        label + ": Core options differ from the canonical profile");
}

void LegitimateProfiles() {
  Check(Build(Spec{}) == kAuditHonest, "builder reproduces the audited honest.ovpn bytes");
  ExpectLegitimate("witness single-stack (audit honest.ovpn)", Spec{}, kAuditHonest);

  Spec dual;
  dual.dual_stack = true;
  ExpectLegitimate("witness dual-stack", dual, Build(dual));

  Spec wide;
  wide.dns = {"192.0.2.53", "192.0.2.54", "192.0.2.55", "192.0.2.56",
              "198.51.100.1", "198.51.100.2", "203.0.113.53", "203.0.113.54"};
  wide.ciphers = {"AES-256-GCM", "AES-128-GCM", "CHACHA20-POLY1305"};
  ExpectLegitimate("witness 8 DNS servers and 3 ciphers", wide, Build(wide));

  Spec chain;
  chain.ca = Certificate('A', 700) + "\n" + Certificate('B', 300);
  ExpectLegitimate("witness two-certificate CA chain", chain, Build(chain));
  chain.ca = Certificate('A', 700) + "\n\n" + Certificate('B', 300);
  ExpectLegitimate("witness CA chain with a blank separator line", chain, Build(chain));

  Spec crlf;
  crlf.ca = Replace(Certificate('C', 200), "\n", "\r\n");
  crlf.key = Replace(kKey, "\n", "\r\n");
  ExpectLegitimate("witness CRLF PEM fields", crlf, Build(crlf));
  ExpectLegitimate("witness CRLF profile", Spec{}, Replace(Build(Spec{}), "\n", "\r\n"));

  // Core removes the quotes of these two legacy filter words itself.
  std::string quoted = Replace(Build(Spec{}), "ignore route-ipv6", "ignore \"route-ipv6\"");
  quoted = Replace(quoted, "ignore ifconfig-ipv6", "ignore \"ifconfig-ipv6\"");
  ExpectLegitimate("witness quoted pull-filter words", Spec{}, quoted);
}

std::string CaBreakout(const std::string& near_close, const std::vector<std::string>& directives) {
  std::vector<std::string> lines{kCaBegin, kCaBody, kCaEnd, near_close, "<tls-crypt-v2>", "</ca>"};
  lines.insert(lines.end(), directives.begin(), directives.end());
  lines.insert(lines.end(), {"<tls-crypt-v2>", kCaEnd});
  return Join(lines, "\n");
}

void AuditCounterExamples() {
  const std::vector<std::string> insecure{"http-proxy 203.0.113.80 8080", "remote 203.0.113.9 443 tcp",
                                          "allow-compression yes", "tls-cert-profile insecure"};
  const std::vector<std::string> proxy{"http-proxy 203.0.113.80 8080", "remote 203.0.113.9 443 tcp"};
  Spec ca_injection;
  ca_injection.ca = CaBreakout(" </ca>", insecure);
  Spec tls_meta;
  tls_meta.key = Join({"# OVPN_ACCESS_SERVER_tls-cert-profile=insecure", kKeyBegin, kKeyBody, kKeyEnd}, "\n");
  Check(Build(ca_injection) == kAuditCaInjection, "builder reproduces the audited ca-injection.ovpn");
  Check(Build(tls_meta) == kAuditTlsMetaInjection,
        "builder reproduces the audited tls-meta-injection.ovpn");

  Spec tab_proxy;
  tab_proxy.ca = CaBreakout("\t</ca>", proxy);
  Spec meta_remote;
  meta_remote.key = Join({"# OVPN_ACCESS_SERVER_remote=203.0.113.9", kKeyBegin,
                          "VkItdGxzLXBsYWNlaG9sZGVy", kKeyEnd}, "\n");
  const std::vector<std::pair<std::string, std::pair<std::string, ProfileFailure>>> cases{
      {"A12 ca-injection.ovpn", {kAuditCaInjection, ProfileFailure::kInvalidCa}},
      {"A12 tls-meta-injection.ovpn", {kAuditTlsMetaInjection, ProfileFailure::kInvalidTlsCryptV2}},
      {"vb ca-tab-proxy", {Build(tab_proxy), ProfileFailure::kInvalidCa}},
      {"vb tls-meta-remote", {Build(meta_remote), ProfileFailure::kInvalidTlsCryptV2}},
  };
  for (const auto& [label, item] : cases) {
    // The counter-example must still be live for the unmodified Core.
    const Findings core_sees = Violation(CoreParse(item.first), HonestView(), false);
    Check(!core_sees.directives.empty(), label + ": Core no longer reads an injected directive");
    std::cout << "  " << label << ": unmodified Core acts on " << Join(core_sees.directives, "; ") << "\n";
    ExpectRejected(label, item.first, false, item.second);
  }
  // Already refused before the fix: an exact "</ca>" followed by a directive.
  Spec exact_close;
  exact_close.ca = Join({kCaBegin, kCaBody, kCaEnd, "</ca>", "http-proxy 203.0.113.80 8080", "<ca>", kCaEnd},
                        "\n");
  ExpectRejected("vb ca-exact-close", Build(exact_close), false, ProfileFailure::kForbiddenDirective);
}

void DivergenceForms() {
  const std::vector<std::string> proxy{"http-proxy 203.0.113.80 8080", "remote 203.0.113.9 443 tcp"};
  // Lines that an earlier trimming validator could take for "</ca>".
  for (const std::string near_close :
       {" </ca>", "\t</ca>", "  </ca>", "</ca> ", "</ca>\t", "\xC2\xA0</ca>", "</ca>\xC2\xA0", "</CA>",
        "</ca >", "< /ca>", "</ ca>", "</ca>;", "</ca>#", "\"</ca>\"", "<\\/ca>", "</ca>\r\r",
        "</ca>\x0b", "\x0c</ca>"}) {
    Spec spec;
    spec.ca = CaBreakout(near_close, proxy);
    ExpectRejected("near close tag '" + Printable(near_close) + "' in <ca>", Build(spec));
  }

  // The same breakout through the key block when it comes first.
  for (const std::string near_close : {" </tls-crypt-v2>", "\t</tls-crypt-v2>", "</tls-crypt-v2> "}) {
    const std::string profile =
        kAuditHead + Join({"<tls-crypt-v2>", kKeyBegin, kKeyBody, kKeyEnd, near_close, "<ca>", kCaBegin,
                     "</tls-crypt-v2>", "http-proxy 203.0.113.80 8080", "<ca>", kCaBody, kCaEnd, "</ca>"},
                    "\n") +
        "\n";
    ExpectRejected("key-first breakout '" + Printable(near_close) + "'", profile);
  }

  // Core reads "# OVPN_ACCESS_SERVER_..." lines as meta options, inline
  // blocks included (options.hpp:1045-1107).
  for (const std::string meta :
       {"# OVPN_ACCESS_SERVER_remote=203.0.113.9", "# OVPN_ACCESS_SERVER_http-proxy=203.0.113.80 8080",
        "# OVPN_ACCESS_SERVER_tls-cert-profile=insecure", "# OVPN_ACCESS_SERVER_allow-compression=yes",
        "# OVPN_ACCESS_SERVER_WEB_CA_BUNDLE_START\n# QUExMg==\n# OVPN_ACCESS_SERVER_WEB_CA_BUNDLE_STOP",
        "#OVPN_ACCESS_SERVER_remote=203.0.113.9", "# comment", ";comment", "#", ";"}) {
    const std::vector<std::pair<std::string, Spec>> placements = [&meta]() {
      std::vector<std::pair<std::string, Spec>> result(7);
      result[0].first = "after CA BEGIN";
      result[0].second.ca = Join({kCaBegin, meta, kCaBody, kCaEnd}, "\n");
      result[1].first = "before CA END";
      result[1].second.ca = Join({kCaBegin, kCaBody, meta, kCaEnd}, "\n");
      result[2].first = "between certificates";
      result[2].second.ca = Join({kCa, meta, kCa}, "\n");
      result[3].first = "before key BEGIN";
      result[3].second.key = Join({meta, kKey}, "\n");
      result[4].first = "after key BEGIN";
      result[4].second.key = Join({kKeyBegin, meta, kKeyBody, kKeyEnd}, "\n");
      result[5].first = "before key END";
      result[5].second.key = Join({kKeyBegin, kKeyBody, meta, kKeyEnd}, "\n");
      result[6].first = "after key END";
      result[6].second.key = Join({kKey, meta}, "\n");
      return result;
    }();
    for (const auto& [where, spec] : placements) {
      ExpectRejected("comment/meta '" + Printable(meta, 60) + "' " + where, Build(spec));
    }
  }

  // Directive lines: Core's lexer honours quotes, backslashes, ';'/'#'
  // comments and every isspace byte; the validator must not read them apart.
  const std::string honest = Build(Spec{});
  for (const std::string form :
       {"dev\ttun", "dev  tun", " dev tun", "dev tun ", "\"dev\" tun", "dev \"tun\"", "'dev' tun",
        "dev t\\un", "dev tun\\", "dev tun # comment", "dev tun ;comment", "dev\xC2\xA0tun", "dev\rtun",
        "dev tun\r\r", "dev tun\x0b"}) {
    ExpectRejected("directive form '" + Printable(form) + "'", Replace(honest, "dev tun\n", form + "\n"));
  }
  for (const std::string extra :
       {"http-proxy 203.0.113.80 8080", "setenv opt http-proxy 203.0.113.80 8080", "remote 203.0.113.9 1194",
        "remote 203.0.113.9 443 tcp", "tls-cert-profile insecure", "allow-compression yes",
        "allow-compression no", "\"http-proxy\" 203.0.113.80 8080", "http\\-proxy 203.0.113.80 8080",
        "<connection>\nremote 203.0.113.9 443 tcp\n</connection>", "<http-proxy-user-pass>",
        "# OVPN_ACCESS_SERVER_remote=203.0.113.9", "client\rhttp-proxy 203.0.113.80 8080",
        "pull-filter ignore route-ipv6", "pull-filter ignore 'route-ipv6'", "pull-filter ignore \"route-ipv6",
        "pull-filter ignore \"route\"-ipv6", "pull-filter ignore \"route-ipv6\" x", " ", "\t"}) {
    ExpectRejected("extra line '" + Printable(extra) + "'", Replace(honest, "<ca>\n", extra + "\n<ca>\n"));
  }
  for (const std::string open : {" <ca>", "<ca> ", "\t<ca>", "\"<ca>\"", "<c\\a>", "<ca> # x", "<CA>"}) {
    ExpectRejected("open tag form '" + Printable(open) + "'", Replace(honest, "<ca>\n", open + "\n"));
  }
  // Only LF or CRLF line ends: Core strips every trailing CR, so a CR
  // anywhere else would be read differently.
  ExpectRejected("CR CR LF line ends", Replace(honest, "\n", "\r\r\n"), false, ProfileFailure::kInvalidEncoding);
  ExpectRejected("final lone CR", honest + "\r", false, ProfileFailure::kInvalidEncoding);
  ExpectRejected("LF CR line ends", Replace(honest, "\n", "\n\r"), false, ProfileFailure::kInvalidEncoding);
}

void Bounds() {
  Spec nine;
  nine.dns = {"192.0.2.53", "192.0.2.54", "192.0.2.55", "192.0.2.56", "198.51.100.1",
              "198.51.100.2", "203.0.113.53", "203.0.113.54", "203.0.113.55"};
  ExpectRejected("9 DNS servers", Build(nine), false, ProfileFailure::kInvalidDns);

  Spec key;
  key.key = KeyWithContainerBytes(8 * 1024);
  ExpectLegitimate("tls-crypt-v2 container of exactly 8192 bytes", key, Build(key));
  key.key = KeyWithContainerBytes(8 * 1024 + 1);
  ExpectRejected("tls-crypt-v2 container of 8193 bytes", Build(key), false, ProfileFailure::kInvalidTlsCryptV2);

  // Core reads at most 512 bytes per line, newline included.
  Spec line;
  line.ca = kCaBegin + "\n" + std::string(511, 'A') + "\n" + kCaEnd;
  ExpectLegitimate("CA line of 511 bytes", line, Build(line));
  line.ca = kCaBegin + "\n" + std::string(512, 'A') + "\n" + kCaEnd;
  Check(!CoreParse(Build(line)).parsed, "Core refuses a 512-byte line");
  ExpectRejected("CA line of 512 bytes", Build(line), false, ProfileFailure::kInvalidCa);

  // Whole-profile bound: 64 KiB, a two-certificate chain tunes the size.
  const auto sized = [](size_t target) {
    Spec spec;
    size_t first = 64;
    const auto size = [&spec, &first]() {
      spec.ca = Certificate('A', first) + "\n" + Certificate('B', 8);
      return Build(spec).size();
    };
    while (size() + 56 + 65 < target) first += 64;
    while (size() + 56 < target) ++first;
    // The second certificate body stays on one line: one byte per character.
    spec.ca = Certificate('A', first) + "\n" + Certificate('B', 8 + target - Build(spec).size());
    return spec;
  };
  const Spec largest = sized(64 * 1024);
  Check(Build(largest).size() == 64 * 1024, "64 KiB profile builder");
  ExpectLegitimate("profile of exactly 64 KiB", largest, Build(largest));
  const Spec too_large = sized(64 * 1024 + 1);
  Check(Build(too_large).size() == 64 * 1024 + 1, "64 KiB + 1 profile builder");
  ExpectRejected("profile of 64 KiB + 1", Build(too_large), false, ProfileFailure::kTooLarge);

  // Repeated allowlisted lines must not make Core's option budget overflow:
  // each directive is accepted once (DNS servers up to 8).
  std::string flood = Build(Spec{});
  std::string filters;
  while (flood.size() + filters.size() + 30 < 64 * 1024) filters += "pull-filter ignore route-ipv6\n";
  flood = Replace(flood, "<ca>\n", filters + "<ca>\n");
  ExpectRejected("pull-filter repeated to 64 KiB", flood, false, ProfileFailure::kForbiddenDirective);
}

// Deterministic mutation corpus around two legitimate profiles. Every
// mutation the validator accepts must keep Core's view on the allowlist.
void MutationCorpus() {
  const std::vector<std::string> fragments{
      " </ca>", "\t</ca>", "</ca>", "</ca> ", "<ca>", " <ca>", "<tls-crypt-v2>", "</tls-crypt-v2>",
      " </tls-crypt-v2>", "\t</tls-crypt-v2>", "<connection>", "</connection>", "<http-proxy-user-pass>",
      "http-proxy 203.0.113.80 8080", "remote 203.0.113.9 443 tcp", "remote 203.0.113.9 1194",
      "allow-compression yes", "tls-cert-profile insecure", "setenv opt http-proxy 203.0.113.80 8080",
      "socks-proxy 203.0.113.81 1080", "route 0.0.0.0 0.0.0.0", "script-security 2",
      "# OVPN_ACCESS_SERVER_remote=203.0.113.9", "# OVPN_ACCESS_SERVER_tls-cert-profile=insecure",
      "# OVPN_ACCESS_SERVER_http-proxy=203.0.113.80 8080", "# OVPN_ACCESS_SERVER_WEB_CA_BUNDLE_START",
      "# OVPN_ACCESS_SERVER_WEB_CA_BUNDLE_STOP", "#", "# ", ";", "; comment",
      "pull-filter ignore route-ipv6", "pull-filter ignore \"ifconfig-ipv6\"", "dhcp-option DNS 192.0.2.54",
      "dhcp-option DNS 192.0.2.53", "block-ipv6", "client", "", "", kCaBegin, kCaEnd, kCaBody, kKeyBegin,
      kKeyEnd, kKeyBody, "\"remote\" 203.0.113.9 1194", "remote 203.0.113.9 1194 # c", "dev\ttun",
      " dev tun", "dev tun ", "dev\\ tun", "'dev' tun",
      " </ca>\n<tls-crypt-v2>\n</ca>\nhttp-proxy 203.0.113.80 8080\nremote 203.0.113.9 443 tcp\n<tls-crypt-v2>",
      "</tls-crypt-v2>\nhttp-proxy 203.0.113.80 8080\n<tls-crypt-v2>"};
  const std::vector<std::string> decorations{"", "", "", "", " ", "\t", "\r", "\xC2\xA0", "\"", "'", "\\",
                                             "#", ";", "  "};
  const std::string special = std::string(" \t\r\"'\\#;<>/=:") + "\x0b\x0c\xC2\xA0";
  Spec dual;
  dual.dual_stack = true;
  dual.dns = {"192.0.2.53", "192.0.2.54"};
  dual.ciphers = {"AES-256-GCM", "CHACHA20-POLY1305"};
  dual.ca = Certificate('A', 150) + "\n" + Certificate('B', 70);
  const std::vector<std::pair<Spec, std::vector<std::string>>> bases{
      {Spec{}, SplitLines(Build(Spec{}))}, {dual, SplitLines(Build(dual))}};

  std::mt19937 random(0xA12u);
  const auto pick = [&random](size_t count) { return static_cast<size_t>(random() % count); };
  const auto at = [](std::vector<std::string>& lines, size_t index) {
    return lines.begin() + static_cast<std::ptrdiff_t>(index);
  };
  constexpr size_t kCases = 40000;
  size_t accepted = 0;
  size_t directive_violations = 0;
  size_t block_violations = 0;
  size_t core_refusals = 0;
  for (size_t index = 0; index < kCases; ++index) {
    const Spec& spec = bases[index % 2].first;
    std::vector<std::string> lines = bases[index % 2].second;
    const size_t operations = 1 + pick(3);
    for (size_t operation = 0; operation < operations; ++operation) {
      const std::string fragment = decorations[pick(decorations.size())] +
                                   fragments[pick(fragments.size())] +
                                   decorations[pick(decorations.size())];
      switch (pick(8)) {
        case 0:
          lines.insert(at(lines, pick(lines.size() + 1)), fragment);
          break;
        case 1:
          lines[pick(lines.size())] = fragment;
          break;
        case 2: {
          const std::string copy = lines[pick(lines.size())];
          lines.insert(at(lines, pick(lines.size() + 1)), copy);
          break;
        }
        case 3:
          if (lines.size() > 1) lines.erase(at(lines, pick(lines.size())));
          break;
        case 4: {
          std::string& target = lines[pick(lines.size())];
          target.insert(pick(target.size() + 1), 1, special[pick(special.size())]);
          break;
        }
        case 5:
          std::swap(lines[pick(lines.size())], lines[pick(lines.size())]);
          break;
        case 6:
          lines[pick(lines.size())] += '\r';
          break;
        default: {
          // Inside one of the inline blocks, where the audit found the gap.
          const auto open = std::find(lines.begin(), lines.end(), pick(2) == 0 ? "<ca>" : "<tls-crypt-v2>");
          if (open == lines.end()) break;
          const size_t first = static_cast<size_t>(open - lines.begin()) + 1;
          lines.insert(at(lines, std::min(lines.size(), first + pick(4))), fragment);
          break;
        }
      }
    }
    const std::string profile = Join(lines, "\n") + "\n";
    const Verdict verdict = Evaluate(profile, spec.dual_stack);
    if (!verdict.validated) continue;
    ++accepted;
    const Findings& findings = verdict.findings;
    if (!findings.parse_error.empty()) {
      if (++core_refusals <= 2) {
        std::cout << "  mutation " << index << " accepted natively, Core refuses it (" << findings.parse_error
                  << ")\n";
      }
    } else if (!findings.directives.empty()) {
      if (++directive_violations <= 6) {
        std::cout << "  mutation " << index << " accepted natively, Core acts on "
                  << Join(findings.directives, "; ") << "\n    profile: " << Printable(profile, 1600) << "\n";
      }
    } else if (!findings.blocks.empty()) {
      if (++block_violations <= 3) {
        std::cout << "  mutation " << index << " accepted natively, Core keeps " << Join(findings.blocks, "; ")
                  << "\n";
      }
    }
  }
  std::cout << "  mutation corpus: " << kCases << " cases, " << accepted << " accepted natively; of these "
            << directive_violations << " make Core act outside the allowlist, " << block_violations
            << " keep non-PEM block content, " << core_refusals << " are refused by Core\n";
  Check(directive_violations == 0, "[divergence] mutation corpus: " + std::to_string(directive_violations) +
                                       " accepted profiles make Core act outside the allowlist");
  Check(block_violations == 0, "[block-content] mutation corpus: " + std::to_string(block_violations) +
                                   " accepted profiles keep non-PEM block content");
  Check(core_refusals == 0, "[core-refuses] mutation corpus: " + std::to_string(core_refusals) +
                                " accepted profiles are refused by Core");
  Check(accepted >= 200, "mutation corpus exercises accepted profiles");
}

}  // namespace

int main() {
  LegitimateProfiles();
  AuditCounterExamples();
  DivergenceForms();
  Bounds();
  MutationCorpus();
  if (failures != 0) {
    std::cout << failures << " of " << checks << " profile/Core differential checks FAILED\n";
    return 1;
  }
  std::cout << checks << " profile/Core differential checks passed against the pinned Core OptionList\n";
  return 0;
}
