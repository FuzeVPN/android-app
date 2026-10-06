import '../l10n/app_languages.dart';
import '../l10n/translated_countries.dart';
import 'country_data.dart';
import 'models.dart';

final localizedCountryNames = Map<String, Map<String, String>>.unmodifiable({
  ...countryNames,
  ...translatedCountryNames,
});

String countryName(String countryCode, String languageCode) {
  final code = countryCode.trim().toUpperCase();
  final normalized = code == 'UK' ? 'GB' : code;
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
  final haystack = normalizeLocationSearch(
    [
      location.city,
      location.displayName,
      location.countryCode,
      locationCountryName(location, languageCode),
      for (final language in localizedCountryNames.keys)
        locationCountryName(location, language),
      if (location.countryCode.toUpperCase() == 'GB') 'UK Britain',
      if (location.countryCode.toUpperCase() == 'US')
        'USA United States America',
    ].join(' '),
  );
  return terms.every(haystack.contains);
}

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
