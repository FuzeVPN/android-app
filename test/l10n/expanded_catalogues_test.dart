import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/location_presentation.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

void main() {
  const location = Location(
    id: 'germany',
    city: 'Frankfurt',
    countryCode: 'DE',
    displayName: 'Frankfurt 01',
    supportedProtocols: {VpnProtocol.wireGuard},
  );
  final source =
      jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
          as Map<String, dynamic>;
  final sourceKeys = source.keys.where((key) => !key.startsWith('@')).toSet();
  for (final language in AppLanguages.all) {
    test(
      '${language.tag} has every message, valid dynamic copy and country search',
      () {
        final arb = File(
          'lib/l10n/app_${language.tag.replaceAll('-', '_')}.arb',
        );
        final data = jsonDecode(arb.readAsStringSync()) as Map<String, dynamic>;
        expect(
          data.keys.where((key) => !key.startsWith('@')).toSet(),
          sourceKeys,
        );
        final l = lookupAppLocalizations(language.locale);
        expect(l.localeName.replaceAll('_', '-'), language.tag);
        for (final key in [
          'locations.countryCount',
          'locations.cityCount',
          'locations.serverCount',
        ]) {
          for (final count in [0, 1, 2, 3, 5, 11, 21, 100]) {
            final text = AppCopy.resolve(l, key, arguments: {'count': count});
            expect(text, contains('$count'));
            expect(text, isNot(contains('{count}')));
          }
        }
        for (final code in [
          'server_full',
          'capacity_unavailable',
          'network_unavailable',
          'unknown',
        ]) {
          final text = AppCopy.resolve(
            l,
            'notice.api.message',
            arguments: {'code': code},
          );
          expect(text, isNotEmpty);
          expect(text, isNot(contains('{code')));
          expect(text, isNot('notice.api.message'));
        }
        final translatedCountry = countryName('DE', language.tag);
        expect(translatedCountry, isNot('DE'));
        expect(
          locationMatchesQuery(location, translatedCountry, language.tag),
          isTrue,
        );
        expect(
          locationMatchesQuery(location, 'Germany Frankfurt', language.tag),
          isTrue,
        );
        expect(
          locationMatchesQuery(location, '不存在 definitelymissing', language.tag),
          isFalse,
        );
      },
    );
  }
}
