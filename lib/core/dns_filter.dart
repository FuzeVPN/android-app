/// The account's ad blocker (DNS filter contract v1). The nodes' resolver
/// answers known ad and tracking domains with an unroutable address on every
/// device of the account: nothing changes in the tunnel configuration.
class DnsFilterSettings {
  const DnsFilterSettings({required this.adBlocking, required this.available});

  factory DnsFilterSettings.fromJson(Map<String, dynamic> json) {
    final Object? adBlocking = json['ad_blocking'];
    final Object? available = json['available'];
    final Object? updatedAt = json['updated_at'];
    if (adBlocking is! bool ||
        available is! bool ||
        (updatedAt != null && updatedAt is! String)) {
      throw const FormatException('invalid_dns_filter');
    }
    return DnsFilterSettings(adBlocking: adBlocking, available: available);
  }

  /// The account's choice.
  final bool adBlocking;

  /// False while the service has turned the blocker off for everyone: the
  /// choice stays saved and can change, but nothing is filtered.
  final bool available;

  @override
  bool operator ==(Object other) =>
      other is DnsFilterSettings &&
      other.adBlocking == adBlocking &&
      other.available == available;

  @override
  int get hashCode => Object.hash(adBlocking, available);
}

/// `GET` and `PUT /v1/me/dns-filter`, with the session's access token.
abstract interface class DnsFilterApiRepository {
  Future<DnsFilterSettings> dnsFilter(String token);

  Future<DnsFilterSettings> updateDnsFilter({
    required String token,
    required bool adBlocking,
  });
}
