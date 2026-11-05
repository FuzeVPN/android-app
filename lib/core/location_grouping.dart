import 'country_data.dart';
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
    final countryCode = normalizeLocationCountryCode(location.countryCode);
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
  return List<LocationCountryGroup>.unmodifiable(
    sortedByLocalizedLabel<LocationCountryGroup>(
      result,
      (country) => country.name,
      languageCode: languageCode,
      tieBreak: (a, b) => a.countryCode.compareTo(b.countryCode),
    ),
  );
}

/// Orders [items] by their translated [label] in the alphabet of
/// [languageCode], without depending on a platform collator: identical
/// offline and on every Android version. Case, accents and punctuation are
/// secondary, numbers are natural, and letters which a language sorts
/// separately keep their place (sv `Ö` after `Z`, cs `Ch` after `H`, uk `І`
/// after `И`, fa `گ` after `ک`, ur `آ` after the `ا` block, Thai pre-vowels
/// by their consonant). Equal
/// labels use [tieBreak], so the result never depends on the input order.
List<T> sortedByLocalizedLabel<T>(
  Iterable<T> items,
  String Function(T item) label, {
  required String languageCode,
  int Function(T a, T b)? tieBreak,
}) {
  final language = languageCode.split(RegExp('[-_]')).first.toLowerCase();
  final keyed = [
    for (final item in items)
      (item: item, label: label(item), key: _sortKey(label(item), language)),
  ];
  keyed.sort((a, b) {
    var order = _compareKeys(a.key, b.key);
    if (order == 0) {
      order = a.label.toLowerCase().compareTo(b.label.toLowerCase());
    }
    if (order == 0) order = a.label.compareTo(b.label);
    if (order == 0 && tieBreak != null) order = tieBreak(a.item, b.item);
    return order;
  });
  return [for (final entry in keyed) entry.item];
}

// A letter sorted after [base] as a separate letter becomes base + marker.
// Markers are above every code unit a key can otherwise contain.
const _after1 = '￱', _after2 = '￲', _after3 = '￳';

/// Script-wide primary equivalences (CLDR root order).
const _scriptOrder = <String, String>{
  // Greek tonos, dialytika and final sigma are secondary.
  'ά': 'α', 'έ': 'ε', 'ή': 'η', 'ί': 'ι', 'ό': 'ο', 'ύ': 'υ', 'ώ': 'ω',
  'ϊ': 'ι', 'ϋ': 'υ', 'ΐ': 'ι', 'ΰ': 'υ', 'ς': 'σ',
  // Cyrillic: ё is е; ґ, є, і, ї follow г, е, и.
  'ё': 'е', 'ґ': 'г$_after1', 'є': 'е$_after1', 'і': 'и$_after1',
  'ї': 'и$_after2',
  // Persian and Urdu letters follow their Arabic base letters.
  'پ': 'ب$_after1', 'ٹ': 'ت$_after1', 'چ': 'ج$_after1', 'ڈ': 'د$_after1',
  'ڑ': 'ر$_after1', 'ژ': 'ز$_after1', 'ک': 'ك', 'گ': 'ك$_after1',
  'ں': 'ن$_after1', 'ہ': 'ه', 'ۀ': 'ه', 'ھ': 'ه$_after1', 'ی': 'ي',
  'ے': 'ي$_after1',
};

const _nordic = <String, String>{
  'æ': 'z$_after1',
  'ä': 'z$_after1',
  'ø': 'z$_after2',
  'ö': 'z$_after2',
  'å': 'z$_after3',
};
const _persoArabic = <String, String>{
  // و precedes ه in the Persian and Urdu alphabets.
  'ه': 'و$_after1', 'ہ': 'و$_after1', 'ۀ': 'و$_after1', 'ھ': 'و$_after2',
};
const _urdu = <String, String>{
  // CLDR ur, unlike fa: آ is a letter after the whole ا block.
  'آ': 'ا$_after1',
  // ؤ, ئ and ۓ are و, ی and ے plus a secondary mark.
  'ؤ': 'و', 'ئ': 'ي', 'ۓ': 'ي$_after1',
  // و precedes ہ, as in Persian.
  'ه': 'و$_after1', 'ہ': 'و$_after1', 'ۀ': 'و$_after1',
  // An aspirate (consonant + ھ) follows every other word of its consonant:
  // ھ sorts after the last letter (ی, ے) and before the next consonant.
  'ھ': 'ي$_after3',
  // Kasra (U+0650) is a secondary mark.
  '\u0650': '',
};

/// Letters that the language sorts as separate letters (CLDR tailorings).
const _languageOrder = <String, Map<String, String>>{
  'sv': {
    'å': 'z$_after1',
    'ä': 'z$_after2',
    'æ': 'z$_after2',
    'ö': 'z$_after3',
    'ø': 'z$_after3',
  },
  'da': _nordic,
  'nb': _nordic,
  'tr': {
    'ç': 'c$_after1',
    'ğ': 'g$_after1',
    'ı': 'h$_after1',
    'ö': 'o$_after1',
    'ş': 's$_after1',
    'ü': 'u$_after1',
  },
  'cs': {
    'č': 'c$_after1',
    'ř': 'r$_after1',
    'š': 's$_after1',
    'ž': 'z$_after1',
  },
  'pl': {
    'ą': 'a$_after1',
    'ć': 'c$_after1',
    'ę': 'e$_after1',
    'ł': 'l$_after1',
    'ń': 'n$_after1',
    'ó': 'o$_after1',
    'ś': 's$_after1',
    'ź': 'z$_after1',
    'ż': 'z$_after2',
  },
  'ro': {
    'ă': 'a$_after1',
    'â': 'a$_after2',
    'î': 'i$_after1',
    'ș': 's$_after1',
    'ş': 's$_after1',
    'ț': 't$_after1',
    'ţ': 't$_after1',
  },
  'es': {'ñ': 'n$_after1'},
  'vi': {
    'ă': 'a$_after1',
    'ằ': 'a$_after1',
    'ắ': 'a$_after1',
    'ẳ': 'a$_after1',
    'ẵ': 'a$_after1',
    'ặ': 'a$_after1',
    'â': 'a$_after2',
    'ầ': 'a$_after2',
    'ấ': 'a$_after2',
    'ẩ': 'a$_after2',
    'ẫ': 'a$_after2',
    'ậ': 'a$_after2',
    'đ': 'd$_after1',
    'ê': 'e$_after1',
    'ề': 'e$_after1',
    'ế': 'e$_after1',
    'ể': 'e$_after1',
    'ễ': 'e$_after1',
    'ệ': 'e$_after1',
    'ô': 'o$_after1',
    'ồ': 'o$_after1',
    'ố': 'o$_after1',
    'ổ': 'o$_after1',
    'ỗ': 'o$_after1',
    'ộ': 'o$_after1',
    'ơ': 'o$_after2',
    'ờ': 'o$_after2',
    'ớ': 'o$_after2',
    'ở': 'o$_after2',
    'ỡ': 'o$_after2',
    'ợ': 'o$_after2',
    'ư': 'u$_after1',
    'ừ': 'u$_after1',
    'ứ': 'u$_after1',
    'ử': 'u$_after1',
    'ữ': 'u$_after1',
    'ự': 'u$_after1',
  },
  // Alef with hamza is alef plus a secondary mark in Arabic (CLDR). Alef with
  // madda, ؤ and ئ keep their code unit order, which matches CLDR for every
  // bundled name: آ sorts ahead of the alef words, as in Persian.
  'ar': {'أ': 'ا', 'إ': 'ا'},
  'fa': _persoArabic,
  'ur': _urdu,
};

final _thaiPreVowel = RegExp('([เ-ไ])([ก-ฮ])');
final _combiningMarks = RegExp(r'[̀-ͯ]');
final _separators = RegExp(r'[^\p{L}\p{M}\p{N}￱-￳]+', unicode: true);

String _sortKey(String value, String language) {
  var text = value;
  // Turkish keeps dotless and dotted I distinct.
  if (language == 'tr') text = text.replaceAll('I', 'ı').replaceAll('İ', 'i');
  text = text.toLowerCase();
  if (language == 'cs') text = text.replaceAll('ch', 'h$_after1');
  // Thai pre-vowels are written first but sorted after their consonant.
  if (language == 'th') {
    text = text.replaceAllMapped(_thaiPreVowel, (m) => '${m[2]}${m[1]}');
  }
  final tailoring = _languageOrder[language] ?? const <String, String>{};
  final buffer = StringBuffer();
  for (final rune in text.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(
      tailoring[char] ??
          _scriptOrder[char] ??
          latinSearchReplacements[char] ??
          char,
    );
  }
  return buffer
      .toString()
      .replaceAll(_combiningMarks, '')
      .replaceAll(_separators, ' ')
      .trim();
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

int _compareLabels(String a, String b) =>
    _compareKeys(normalizeLocationSearch(a), normalizeLocationSearch(b));

int _compareKeys(String left, String right) {
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
