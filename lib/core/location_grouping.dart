import 'location_presentation.dart';
import 'models.dart';

/// A view of the current catalogue. Groups never invent or retain servers.
class LocationCountryGroup {
  LocationCountryGroup({
    required this.countryCode,
    required this.name,
    required Iterable<LocationCityGroup> cities,
  }) : cities = List<LocationCityGroup>.unmodifiable(cities);

  final String countryCode;
  final String name;
  final List<LocationCityGroup> cities;

  List<Location> get servers =>
      List<Location>.unmodifiable(cities.expand((city) => city.servers));
}

class LocationCityGroup {
  LocationCityGroup({
    required this.key,
    required this.countryCode,
    required this.name,
    required Iterable<Location> servers,
  }) : servers = List<Location>.unmodifiable(servers);

  /// Stable within its country, across UI languages and catalogue response order.
  final String key;
  final String countryCode;
  final String name;
  final List<Location> servers;
}

/// Countries use bundled names in the UI language; city names come from the API.
/// Case, accents and repeated spaces do not create duplicate city groups within
/// a country. The same city name in different countries always stays separate.
List<LocationCountryGroup> groupLocations(
  Iterable<Location> locations, {
  required String languageCode,
}) {
  final countries = <String, Map<String, List<Location>>>{};
  for (final location in locations) {
    final countryCode = _normalizedCountryCode(location.countryCode);
    final cityKey = normalizeLocationSearch(location.city);
    final cities = countries.putIfAbsent(countryCode, () => {});
    cities.putIfAbsent(cityKey, () => []).add(location);
  }
  final result = <LocationCountryGroup>[];
  for (final country in countries.entries) {
    final cities = <LocationCityGroup>[];
    for (final city in country.value.entries) {
      final servers = city.value.toList()..sort(_compareServers);
      // Pick an actual API spelling deterministically, preserving accents when
      // another row spells the same city without them.
      final names =
          servers.map((server) => _cleanLabel(server.city)).toSet().toList()
            ..sort(_compareCitySpellings);
      cities.add(
        LocationCityGroup(
          key: city.key,
          countryCode: country.key,
          name: names.first,
          servers: servers,
        ),
      );
    }
    cities.sort((a, b) {
      final byName = _compareLabels(a.name, b.name);
      return byName != 0 ? byName : a.key.compareTo(b.key);
    });
    result.add(
      LocationCountryGroup(
        countryCode: country.key,
        name: countryName(country.key, languageCode),
        cities: cities,
      ),
    );
  }
  result.sort((a, b) {
    final byName = _compareLabels(a.name, b.name);
    return byName != 0 ? byName : a.countryCode.compareTo(b.countryCode);
  });
  return List<LocationCountryGroup>.unmodifiable(result);
}

/// Selects only from the supplied current group. This is a deterministic choice,
/// not a latency/load ranking, and makes no network requests.
///
/// Supply [activeProtocol] only while a tunnel is active, so country/city choices
/// retain the running tunnel's actual protocol. A compatible active server wins,
/// followed by a compatible saved selection, then the first readable label.
Location? chooseLocationServer(
  Iterable<Location> servers, {
  required VpnProtocol selectedProtocol,
  VpnProtocol? activeProtocol,
  String? activeLocationId,
  String? selectedLocationId,
}) {
  final protocol = activeProtocol ?? selectedProtocol;
  final candidates =
      servers.where((server) => server.supports(protocol)).toList()
        ..sort(_compareServers);
  for (final preferred in [activeLocationId, selectedLocationId]) {
    if (preferred == null) continue;
    for (final candidate in candidates) {
      if (candidate.id == preferred) return candidate;
    }
  }
  return candidates.firstOrNull;
}

String _normalizedCountryCode(String value) {
  final code = value.trim().toUpperCase();
  return code == 'UK' ? 'GB' : code;
}

String _cleanLabel(String value) =>
    value.trim().replaceAll(RegExp(r'\s+'), ' ');

int _compareServers(Location a, Location b) {
  final byName = _compareLabels(a.displayName, b.displayName);
  return byName != 0 ? byName : a.id.compareTo(b.id);
}

int _compareCitySpellings(String a, String b) {
  bool accented(String value) => value.toLowerCase().runes.any(
    (rune) =>
        normalizeLocationSearch(String.fromCharCode(rune)) !=
        String.fromCharCode(rune).trim(),
  );
  final byAccents = (accented(a) ? 0 : 1).compareTo(accented(b) ? 0 : 1);
  if (byAccents != 0) return byAccents;
  bool mixedCase(String value) =>
      value != value.toLowerCase() && value != value.toUpperCase();
  final byCase = (mixedCase(a) ? 0 : 1).compareTo(mixedCase(b) ? 0 : 1);
  return byCase != 0 ? byCase : a.compareTo(b);
}

int _compareLabels(String a, String b) {
  final left = normalizeLocationSearch(a);
  final right = normalizeLocationSearch(b);
  // Natural numeric order keeps Server 2 ahead of Server 10 without making any
  // claim about capacity or quality. Lengths avoid parsing unbounded integers.
  final parts = RegExp(r'\d+|\D+');
  final leftParts = parts
      .allMatches(left)
      .map((match) => match.group(0)!)
      .toList();
  final rightParts = parts
      .allMatches(right)
      .map((match) => match.group(0)!)
      .toList();
  for (var i = 0; i < leftParts.length && i < rightParts.length; i++) {
    final l = leftParts[i];
    final r = rightParts[i];
    var comparison = 0;
    if (RegExp(r'^\d').hasMatch(l) && RegExp(r'^\d').hasMatch(r)) {
      final ln = l.replaceFirst(RegExp(r'^0+'), '');
      final rn = r.replaceFirst(RegExp(r'^0+'), '');
      comparison = ln.length.compareTo(rn.length);
      if (comparison == 0) comparison = ln.compareTo(rn);
    } else {
      comparison = l.compareTo(r);
    }
    if (comparison != 0) return comparison;
  }
  return leftParts.length.compareTo(rightParts.length);
}
