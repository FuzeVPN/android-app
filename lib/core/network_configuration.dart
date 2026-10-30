import 'dart:io';

/// Validated tunnel payload, never endpoint transport or reachability telemetry.
class VpnNetworkConfiguration {
  VpnNetworkConfiguration._(List<String> addresses, this.dualStack)
    : addresses = List<String>.unmodifiable(addresses),
      ipFamilies = List<String>.unmodifiable(
        dualStack ? const ['ipv4', 'ipv6'] : const ['ipv4'],
      ),
      allowedIps = List<String>.unmodifiable(
        dualStack ? const ['0.0.0.0/0', '::/0'] : const ['0.0.0.0/0'],
      );

  final List<String> addresses;
  final List<String> ipFamilies;
  final List<String> allowedIps;
  final bool dualStack;

  factory VpnNetworkConfiguration.ipv4(
    String address, {
    List<String>? routes,
  }) => VpnNetworkConfiguration.fromJson({
    'address': address,
    'allowed_ips': routes ?? const ['0.0.0.0/0'],
  });

  factory VpnNetworkConfiguration.fromJson(
    Map<String, dynamic> json, {
    bool legacyOpenVpn = false,
  }) {
    final ipv4 = _address(json['address'], false);
    final hasFamilies = json.containsKey('ip_families');
    final hasAddresses = json.containsKey('addresses');
    if (hasFamilies != hasAddresses) _invalid();
    var dualStack = false;
    var addresses = <String>[ipv4];
    if (hasFamilies) {
      // Families, addresses and routes are sets: the server may list them in
      // its own order, as the catalogue hint does (C5-01). IPv4 is required,
      // nothing is duplicated and each address is matched to its family.
      final families = json['ip_families'];
      if (families is! List ||
          (!_sameSet(families, const ['ipv4']) &&
              !_sameSet(families, const ['ipv4', 'ipv6']))) {
        _invalid();
      }
      dualStack = families.length == 2;
      final raw = json['addresses'];
      if (raw is! List || raw.length != (dualStack ? 2 : 1)) _invalid();
      // An IPv6 address always contains ':', an IPv4 one never does.
      final Object? second = dualStack ? raw[1] : null;
      final ipv4At = second is String && !second.contains(':') ? 1 : 0;
      if (_address(raw[ipv4At], false) != ipv4) _invalid();
      addresses = [ipv4, if (dualStack) _address(raw[1 - ipv4At], true)];
    }
    final routes = json['allowed_ips'];
    if (!(legacyOpenVpn && !hasFamilies && !json.containsKey('allowed_ips'))) {
      final expected = dualStack
          ? const ['0.0.0.0/0', '::/0']
          : const ['0.0.0.0/0'];
      if (routes is! List || !_sameSet(routes, expected)) _invalid();
    }
    return VpnNetworkConfiguration._(addresses, dualStack);
  }

  Map<String, Object> toWire() => {
    'ip_families': ipFamilies,
    'addresses': addresses,
    'allowed_ips': allowedIps,
  };

  /// Catalogue `supported_ip_families` is a capability hint, not a tunnel
  /// payload: IPv6 is offered only when the value is a list containing both
  /// exact strings `ipv4` and `ipv6`, whatever the order. Any other item
  /// (duplicate, future or unknown family, other casing, non-string) is
  /// ignored. A list lacking either string, or any other shape (absent,
  /// string, map), leaves that location IPv4-only. No form invalidates the
  /// whole catalogue or device list (C5-01).
  static bool advertisedIpv6(Object? value) =>
      value is List && value.contains('ipv4') && value.contains('ipv6');

  /// Dotted-decimal IPv4 accepted by every native validator: the form of
  /// TunnelNetworkSpec.numericAddress, the strictest one, which
  /// OpenVpnController.requiredIpv4 also accepts unchanged. Four ASCII
  /// decimal octets 0-255, without sign, space or leading zero (C5-05).
  static bool isCanonicalIpv4Address(String value) {
    if (!_canonicalIpv4.hasMatch(value)) return false;
    return value.split('.').every((octet) => int.parse(octet) <= 255);
  }

  static final RegExp _canonicalIpv4 = RegExp(
    r'^(0|[1-9][0-9]{0,2})(\.(0|[1-9][0-9]{0,2})){3}$',
  );

  static String _address(Object? value, bool ipv6) {
    if (value is! String || value.length > 64 || value.contains('%')) {
      _invalid();
    }
    final parts = value.split('/');
    if (parts.length != 2 || parts[1] != (ipv6 ? '128' : '32')) _invalid();
    final ip = InternetAddress.tryParse(parts[0]);
    if (ip == null ||
        ip.type !=
            (ipv6 ? InternetAddressType.IPv6 : InternetAddressType.IPv4)) {
      _invalid();
    }
    if (ipv6) {
      if ((ip.rawAddress[0] & 0xfe) != 0xfc) _invalid();
    } else if (!isCanonicalIpv4Address(parts[0])) {
      _invalid();
    }
    return '${ip.address}/${parts[1]}';
  }

  /// Same distinct values in any order: with equal lengths, containing every
  /// distinct expected value excludes duplicates and any other value.
  static bool _sameSet(List<dynamic> actual, List<String> expected) =>
      actual.length == expected.length && expected.every(actual.contains);

  static Never _invalid() =>
      throw const FormatException('invalid_tunnel_network');

  @override
  String toString() =>
      'VpnNetworkConfiguration(dualStack: $dualStack, redacted: true)';
}
