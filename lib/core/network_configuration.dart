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
      final families = json['ip_families'];
      if (families is! List ||
          (!_same(families, const ['ipv4']) &&
              !_same(families, const ['ipv4', 'ipv6']))) {
        _invalid();
      }
      dualStack = families.length == 2;
      final raw = json['addresses'];
      if (raw is! List || raw.length != (dualStack ? 2 : 1)) _invalid();
      if (_address(raw[0], false) != ipv4) _invalid();
      addresses = [ipv4, if (dualStack) _address(raw[1], true)];
    }
    final routes = json['allowed_ips'];
    if (!(legacyOpenVpn && !hasFamilies && !json.containsKey('allowed_ips'))) {
      final expected = dualStack
          ? const ['0.0.0.0/0', '::/0']
          : const ['0.0.0.0/0'];
      if (routes is! List || !_same(routes, expected)) _invalid();
    }
    return VpnNetworkConfiguration._(addresses, dualStack);
  }

  Map<String, Object> toWire() => {
    'ip_families': ipFamilies,
    'addresses': addresses,
    'allowed_ips': allowedIps,
  };

  static bool advertisedIpv6(Object? value) {
    if (value == null) return false;
    if (value is! List) _invalid();
    if (_same(value, const ['ipv4'])) return false;
    if (_same(value, const ['ipv4', 'ipv6'])) return true;
    _invalid();
  }

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
    } else if (!RegExp(
      r'^(0|[1-9]\d{0,2})(\.(0|[1-9]\d{0,2})){3}$',
    ).hasMatch(parts[0])) {
      _invalid();
    }
    return '${ip.address}/${parts[1]}';
  }

  static bool _same(List<dynamic> actual, List<String> expected) =>
      actual.length == expected.length &&
      List.generate(
        expected.length,
        (i) => actual[i] == expected[i],
      ).every((v) => v);

  static Never _invalid() =>
      throw const FormatException('invalid_tunnel_network');

  @override
  String toString() =>
      'VpnNetworkConfiguration(dualStack: $dualStack, redacted: true)';
}
