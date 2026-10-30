// Corrections du 29/10/2026, sous-lot interface et localisation :
// A16-ui-l10n-02 (vérification), -03, -04, -07, A05-models-02 et
// A17-supply-chain-05 côté textes, sur les 30 langues livrées.
// Les contre-exemples viennent de audit-complet-20261028/repros/A16-ui-l10n/
// (a16_l10n_counterexamples_test, a16_retry_after_plural_test,
// a16_country_picker_order_test), assertions inversées.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/l10n/translated_countries.dart';

Map<String, Object?> _sourceArb() =>
    (jsonDecode(File('lib/l10n/translations/en.json').readAsStringSync())
            as Map<String, Object?>)['arb']!
        as Map<String, Object?>;

/// Top-level cases of an ICU `select` message, without its nested messages.
Set<String> _selectCases(String message) {
  final start = message.indexOf('select,') + 'select,'.length;
  final cases = <String>{};
  var depth = 0;
  final key = StringBuffer();
  for (var i = start; i < message.length - 1; i++) {
    final char = message[i];
    if (char == '{') {
      if (depth == 0) cases.add(key.toString().trim());
      key.clear();
      depth++;
    } else if (char == '}') {
      depth--;
    } else if (depth == 0) {
      key.write(char);
    }
  }
  return cases;
}

String _retry(AppLocalizations l, Object? seconds) =>
    AppCopy.resolve(l, 'notice.retryAfter', arguments: {'seconds': seconds});

void main() {
  test('les 30 langues livrées sont couvertes', () {
    expect(AppLanguages.all, hasLength(30));
  });

  group('A16-ui-l10n-03 titres natifs', () {
    test('openvpn_recovery_exhausted et openvpn_recovery_failed ont un titre '
        'spécifique (30 langues)', () {
      for (final language in AppLanguages.all) {
        final l = lookupAppLocalizations(language.locale);
        final generic = l.notice_native_title('__unknown__', 'OpenVPN');
        for (final code in [
          'openvpn_recovery_exhausted',
          'openvpn_recovery_failed',
        ]) {
          final title = AppCopy.resolve(
            l,
            'notice.native.title',
            arguments: {'code': code, 'protocol': 'OpenVPN'},
          );
          expect(title, isNot(generic), reason: '${language.tag} $code');
          expect(title.trim(), isNotEmpty, reason: '${language.tag} $code');
        }
      }
    });

    test('chaque cas de message natif a son propre titre (30 langues)', () {
      final source = _sourceArb();
      final messages = _selectCases(source['notice_native_message']! as String)
        ..remove('other');
      final titles = _selectCases(source['notice_native_title']! as String)
        ..remove('other');
      expect(messages.difference(titles), isEmpty);
      expect(messages, contains('openvpn_recovery_exhausted'));
      for (final language in AppLanguages.all) {
        final l = lookupAppLocalizations(language.locale);
        final generic = l.notice_native_title('__unknown__', 'VPN');
        final missing = [
          for (final code in messages)
            if (AppCopy.resolve(
                  l,
                  'notice.native.title',
                  arguments: {'code': code, 'protocol': 'VPN'},
                ) ==
                generic)
              code,
        ];
        expect(missing, isEmpty, reason: language.tag);
      }
    });
  });

  group('A16-ui-l10n-04 pluriel de notice.retryAfter', () {
    test('formes grammaticales selon le nombre', () {
      const expected = <String, Map<int, String>>{
        'en': {1: 'in 1 second.', 2: 'in 2 seconds.', 21: 'in 21 seconds.'},
        'fr': {1: 'dans 1 seconde.', 2: 'dans 2 secondes.'},
        'de': {1: 'in 1 Sekunde erneut', 2: 'in 2 Sekunden erneut'},
        'es': {1: '1 segundo.', 2: '2 segundos.'},
        'it': {1: '1 secondo.', 2: '2 secondi.'},
        'pt': {1: '1 segundo.', 2: '2 segundos.'},
        'nl': {1: '1 seconde opnieuw', 2: '2 seconden opnieuw'},
        'sv': {1: '1 sekund.', 2: '2 sekunder.'},
        'da': {1: '1 sekund.', 2: '2 sekunder.'},
        'nb': {1: '1 sekund.', 2: '2 sekunder.'},
        'el': {1: '1 δευτερόλεπτο.', 2: '2 δευτερόλεπτα.'},
        'ru': {
          1: 'через 1 секунду.',
          2: 'через 2 секунды.',
          5: 'через 5 секунд.',
          11: 'через 11 секунд.',
          21: 'через 21 секунду.',
          22: 'через 22 секунды.',
        },
        'uk': {
          1: 'через 1 секунду.',
          2: 'через 2 секунди.',
          5: 'через 5 секунд.',
          21: 'через 21 секунду.',
        },
        'pl': {
          1: 'za 1 sekundę.',
          2: 'za 2 sekundy.',
          5: 'za 5 sekund.',
          12: 'za 12 sekund.',
          22: 'za 22 sekundy.',
        },
        'cs': {1: 'za 1 sekundu.', 2: 'za 2 sekundy.', 5: 'za 5 sekund.'},
        'ro': {1: '1 secundă.', 2: '2 secunde.', 20: '20 de secunde.'},
        'ar': {2: '2 ثانيتين', 3: '3 ثوانٍ', 11: '11 ثانية'},
      };
      expected.forEach((tag, cases) {
        final l = lookupAppLocalizations(Locale(tag));
        cases.forEach((seconds, fragment) {
          expect(
            _retry(l, seconds),
            contains(fragment),
            reason: '$tag $seconds',
          );
        });
      });
    });

    test(
      'le nombre est conservé et rien ne reste non résolu (30 langues, 0..120)',
      () {
        for (final language in AppLanguages.all) {
          final l = lookupAppLocalizations(language.locale);
          for (var seconds = 0; seconds <= 120; seconds++) {
            final text = _retry(l, seconds);
            expect(
              text,
              contains('$seconds'),
              reason: '${language.tag} $seconds',
            );
            expect(
              text,
              isNot(contains('{')),
              reason: '${language.tag} $seconds',
            );
          }
        }
      },
    );

    test(
      'le chemin réel ApiErrorMessages.fromFailure (429) utilise le pluriel',
      () {
        final notice = ApiErrorMessages.fromFailure(
          const ApiException(
            statusCode: 429,
            errorCode: 'rate_limited',
            retryAfterSeconds: 1,
          ),
        );
        expect(notice.messageKey, 'notice.retryAfter');
        final en = lookupAppLocalizations(const Locale('en'));
        expect(
          AppCopy.resolve(en, notice.messageKey, arguments: notice.arguments),
          'Try again in 1 second.',
        );
      },
    );

    test('un argument non entier reste lisible', () {
      final en = lookupAppLocalizations(const Locale('en'));
      expect(_retry(en, '3'), 'Try again in 3 seconds.');
      expect(_retry(en, 2.0), 'Try again in 2 seconds.');
    });
  });

  group('A16-ui-l10n-07 noms de pays', () {
    test('MF et SX distincts en néerlandais et en ourdou', () {
      for (final tag in ['nl', 'ur']) {
        final names = translatedCountryNames[tag]!;
        expect(names['MF'], isNot(names['SX']), reason: tag);
      }
    });

    test('aucun nom de pays en double dans une langue (30 langues)', () {
      expect(translatedCountryNames, hasLength(30));
      translatedCountryNames.forEach((tag, names) {
        final seen = <String, String>{};
        final duplicates = <String>[];
        names.forEach((code, name) {
          final key = name.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
          final previous = seen[key];
          if (previous != null) duplicates.add('$previous/$code "$name"');
          seen[key] = code;
        });
        expect(duplicates, isEmpty, reason: tag);
      });
    });
  });

  test(
    'A05-models-02 : libellé localisé pour un appareil sans nom (30 langues)',
    () {
      final labels = <String, String>{};
      for (final language in AppLanguages.all) {
        final l = lookupAppLocalizations(language.locale);
        final label = AppCopy.resolve(l, 'devices.unnamed');
        expect(label, isNot('devices.unnamed'), reason: language.tag);
        expect(label.trim(), isNotEmpty, reason: language.tag);
        labels[language.tag] = label;
      }
      expect(labels['fr'], 'Appareil sans nom');
      expect(labels['en'], 'Unnamed device');
      for (final tag in ['en', 'de', 'es', 'ar', 'ja']) {
        expect(labels[tag], isNot(labels['fr']), reason: tag);
      }
    },
  );

  test('A17-supply-chain-05 : indication des sources dans l écran de licences '
      '(30 langues)', () {
    const url = 'https://github.com/FuzeVPN/android-app';
    for (final language in AppLanguages.all) {
      final l = lookupAppLocalizations(language.locale);
      final text = AppCopy.resolve(
        l,
        'settings.licensesLegalese',
        arguments: {'url': url},
      );
      expect(url.allMatches(text), hasLength(1), reason: language.tag);
      expect(text, contains('MPL-2.0'), reason: language.tag);
      // libwg.so / libwg-quick.so are excluded from the package: no GPL-2.0
      // component is shipped any more.
      expect(text, isNot(contains('GPL-2.0')), reason: language.tag);
      expect(text, isNot(contains('{')), reason: language.tag);
    }
  });

  test('A16-ui-l10n-02 : location_migration_slow interpole la destination '
      '(30 langues)', () {
    const target = 'Frankfurt 02';
    for (final language in AppLanguages.all) {
      final l = lookupAppLocalizations(language.locale);
      final text = AppCopy.resolve(
        l,
        'notice.controller.message',
        arguments: {'code': 'location_migration_slow', 'target': target},
      );
      expect(target.allMatches(text), hasLength(1), reason: language.tag);
      expect(
        AppCopy.resolve(
          l,
          'notice.controller.message',
          arguments: {'code': 'location_migration_slow'},
        ),
        isNot(contains(target)),
        reason: language.tag,
      );
    }
  });
}
