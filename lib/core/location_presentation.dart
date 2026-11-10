import '../l10n/app_languages.dart';
import '../l10n/translated_countries.dart';
import 'country_data.dart';
import 'models.dart';

final localizedCountryNames = Map<String, Map<String, String>>.unmodifiable({
  ...countryNames,
  ...translatedCountryNames,
});

/// Canonical catalogue code shared by grouping, labels and local search.
String normalizeLocationCountryCode(String value) {
  final code = value.trim().toUpperCase();
  return code == 'UK' ? 'GB' : code;
}

String countryName(String countryCode, String languageCode) {
  final code = countryCode.trim().toUpperCase();
  final normalized = normalizeLocationCountryCode(code);
  final names =
      localizedCountryNames[languageCode] ??
      localizedCountryNames[AppLanguages.parse(languageCode)?.toLanguageTag()];
  return names?[normalized] ?? countryNames['en']?[normalized] ?? code;
}

String locationCountryName(Location location, String languageCode) =>
    countryName(location.countryCode, languageCode);

/// Search uses only the downloaded catalogue and bundled translations.
/// Multiple words can match both a city and its country, in any order.
bool locationMatchesQuery(
  Location location,
  String query,
  String languageCode,
) {
  final terms = normalizeLocationSearch(
    query,
  ).split(' ').where((s) => s.isNotEmpty);
  if (terms.isEmpty) return true;
  final countryCode = normalizeLocationCountryCode(location.countryCode);
  final ownText = normalizeLocationSearch(
    [
      location.city,
      location.displayName,
      location.countryCode,
      countryCode,
      locationCountryName(location, languageCode),
    ].join(' '),
  );
  final haystack = '$ownText ${_countrySearchText(countryCode)}';
  return terms.every(haystack.contains);
}

/// Country names in every bundled language, normalized once per country:
/// they do not depend on the location or the query.
final _countrySearchCache = <String, String>{};

String _countrySearchText(String countryCode) =>
    _countrySearchCache.putIfAbsent(
      countryCode,
      () => normalizeLocationSearch(
        [
          for (final language in localizedCountryNames.keys)
            countryName(countryCode, language),
          if (countryCode == 'GB') 'UK Britain',
          if (countryCode == 'US') 'USA United States America',
        ].join(' '),
      ),
    );

String normalizeLocationSearch(String value) {
  final buffer = StringBuffer();
  for (final rune in value.toLowerCase().runes) {
    final char = String.fromCharCode(rune);
    buffer.write(latinSearchReplacements[char] ?? char);
  }
  return buffer
      .toString()
      .replaceAll(RegExp(r'[\u0300-\u036f]'), '')
      // Vowel signs and tone marks are part of words in scripts such as
      // Devanagari and Thai; treating them as separators broadens searches.
      .replaceAll(RegExp(r'[^\p{L}\p{M}\p{N}]+', unicode: true), ' ')
      .trim();
}
