// Réaudit final du 30/10/2026, B9 (C1-Vivacité de bout en bout-02) : pendant
// une fin de session en cours (jusqu'à 40 s : drainage, puis attente du
// natif), _SessionTerminationPage (lib/app.dart) affiche session_ending tant
// que result.inProgress est vrai, avant toute confirmation native. Le texte
// décrit donc l'opération en cours (arrêt du VPN et nettoyage) sans affirmer
// que la session est déjà invalidée ; l'issue réelle vient ensuite de
// session_stopFailed ou de session_cleanupFailed.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

/// Per pack, the stems with which the former wording stated that the session
/// was already invalidated. None of them may come back in session_ending.
const Map<String, List<String>> _invalidationClaims = {
  'ar': ['أُبطلت', 'أبطلت', 'باطل'],
  'cs': ['neplatn'],
  'da': ['ugyldig'],
  'de': ['ungültig'],
  'el': ['ακυρω', 'ακυρώ', 'άκυρ', 'ακύρ'],
  'en': ['invalid'],
  'es': ['invalid'],
  'fa': ['باطل'],
  'fil': ['pinawalang-bisa', 'walang bisa'],
  'fr': ['invalid'],
  'hi': ['अमान्य'],
  'id': ['dibatalkan', 'tidak valid'],
  'it': ['invalid'],
  'ja': ['無効'],
  'ko': ['무효'],
  'ms': ['dibatalkan', 'tidak sah'],
  'nb': ['ugyldig'],
  'nl': ['ongeldig'],
  'pl': ['unieważni', 'nieważn'],
  'pt': ['invalid'],
  'ro': ['invalid'],
  'ru': ['недействительн'],
  'sv': ['ogiltig'],
  'th': ['ถูกยกเลิก', 'ไม่ถูกต้อง'],
  'tr': ['geçersiz'],
  'uk': ['недійсн'],
  'ur': ['غیر مؤثر', 'کالعدم'],
  'vi': ['vô hiệu'],
  'zh-Hans': ['失效', '无效'],
  'zh-Hant': ['失效', '無效'],
};

void main() {
  test('chaque langue livrée a sa liste de formulations interdites', () {
    expect(
      _invalidationClaims.keys.toSet(),
      AppLanguages.all.map((language) => language.tag).toSet(),
    );
  });

  test('FR et EN : la fin en cours décrit l’arrêt sans affirmer '
      'l’invalidation', () {
    final fr = AppCopy.resolve(
      lookupAppLocalizations(const Locale('fr')),
      'session.ending',
    );
    final en = AppCopy.resolve(
      lookupAppLocalizations(const Locale('en')),
      'session.ending',
    );
    expect(fr.toLowerCase(), isNot(contains('invalid')));
    expect(fr, isNot(contains('Votre session est')));
    expect(fr, contains('arrêt du VPN'));
    expect(en.toLowerCase(), isNot(contains('invalid')));
    expect(en, isNot(contains('Your session is')));
    expect(en, contains('stopping the VPN'));
  });

  test('30 langues : session_ending ne dit pas que la session est déjà '
      'invalidée et reste une opération en cours', () {
    for (final language in AppLanguages.all) {
      final l = lookupAppLocalizations(language.locale);
      final ending = AppCopy.resolve(l, 'session.ending');
      final folded = ending.toLowerCase();
      for (final claim in _invalidationClaims[language.tag]!) {
        expect(
          folded,
          isNot(contains(claim.toLowerCase())),
          reason: '${language.tag}: $ending',
        );
      }
      // Still an operation in progress, distinct from its unconfirmed outcomes.
      expect(ending.trimRight(), endsWith('…'), reason: language.tag);
      expect(ending, isNot(AppCopy.resolve(l, 'session.stopFailed')));
      expect(ending, isNot(AppCopy.resolve(l, 'session.cleanupFailed')));
    }
  });
}
