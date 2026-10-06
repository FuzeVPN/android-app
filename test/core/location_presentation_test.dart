import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/country_data.dart';
import 'package:fuzevpn_android/core/location_presentation.dart';
import 'package:fuzevpn_android/core/models.dart';

void main() {
  const zurich = Location(
    id: 'ch-1',
    city: 'Zürich',
    countryCode: 'CH',
    displayName: 'Zürich 01',
  );
  test(
    'search combines city and translated country without accents or case',
    () {
      for (final query in [
        'Zurich',
        'ZÜRICH',
        'suisse zurich',
        'zurich switzerland',
        'CH Zurich',
        'sWiTzErLaNd',
        '  Zürich   01 ',
      ]) {
        expect(
          locationMatchesQuery(zurich, query, 'fr'),
          isTrue,
          reason: query,
        );
      }
      expect(locationMatchesQuery(zurich, 'Berlin Suisse', 'fr'), isFalse);
      expect(locationMatchesQuery(zurich, '   ', 'fr'), isTrue);
    },
  );
  test('country names localize and unknown codes stay honest', () {
    expect(locationCountryName(zurich, 'fr'), 'Suisse');
    expect(locationCountryName(zurich, 'de'), 'Schweiz');
    expect(countryName('DE', 'fr'), 'Allemagne');
    expect(countryName(' uk ', 'en'), 'United Kingdom');
    expect(countryName('XY', 'fr'), 'XY');
    expect(countryName('FR', 'unsupported'), 'France');
  });
  test('Latin ligatures and composed or decomposed accents match', () {
    expect(
      normalizeLocationSearch('São-Paulo, ŁÓDŹ / œ Æ Straße'),
      'sao paulo lodz oe ae strasse',
    );
    expect(normalizeLocationSearch('Mu\u0308nchen'), 'munchen');
    expect(normalizeLocationSearch('東京'), '東京');
  });
  test('every declared flag exists locally including all language flags', () {
    expect(
      bundledCountryFlags,
      containsAll(['FR', 'GB', 'DE', 'ES', 'CH', 'US']),
    );
    expect(bundledCountryFlags.length, greaterThanOrEqualTo(249));
    for (final code in bundledCountryFlags) {
      final bytes = File(
        'assets/flags/${code.toLowerCase()}.png',
      ).readAsBytesSync();
      expect(bytes.take(8), [137, 80, 78, 71, 13, 10, 26, 10], reason: code);
    }
  });
  test('search preserves vowel signs and tone marks inside words', () {
    for (final word in ['\u0915\u093f\u0928', '\u0e01\u0e34\u0e48']) {
      expect(normalizeLocationSearch(word), word);
    }
    const vowelSensitive = Location(
      id: 'script-fixture',
      city: '\u0915\u0940\u0928',
      countryCode: 'XY',
      displayName: '01',
    );
    expect(
      locationMatchesQuery(vowelSensitive, '\u0915\u0940\u0928', 'hi'),
      isTrue,
    );
    expect(
      locationMatchesQuery(vowelSensitive, '\u0915\u093f\u0928', 'hi'),
      isFalse,
    );
  });
}
