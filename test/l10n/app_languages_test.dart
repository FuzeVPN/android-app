import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';

void main() {
  test(
    'offers the 30 requested languages without duplicate Chinese choices',
    () {
      expect(AppLanguages.all, hasLength(30));
      expect(AppLanguages.all.map((e) => e.tag).toSet(), hasLength(30));
      expect(AppLanguages.supportedLocales.first, const Locale('fr'));
      for (final language in AppLanguages.all) {
        expect(AppLanguages.parse(language.tag), language.locale);
        expect(AppLanguages.find(language.locale), language);
      }
    },
  );

  test(
    'keeps Chinese writing systems and resolves regional system locales',
    () {
      for (final tag in ['zh', 'zh-CN', 'zh-SG', 'zh-Hans-TW']) {
        expect(AppLanguages.parse(tag)?.toLanguageTag(), 'zh-Hans');
      }
      for (final tag in ['zh-TW', 'zh-HK', 'zh-MO', 'zh_Hant', 'zh-Hant-CN']) {
        expect(AppLanguages.parse(tag)?.toLanguageTag(), 'zh-Hant');
      }
      expect(AppLanguages.parse('pt-BR'), const Locale('pt'));
      expect(AppLanguages.parse('no-NO'), const Locale('nb'));
      expect(AppLanguages.parse('in-ID'), const Locale('id'));
      expect(AppLanguages.parse('tl-PH'), const Locale('fil'));
    },
  );

  test('checks all system preferences before choosing the French fallback', () {
    expect(
      AppLanguages.resolve([const Locale('he'), const Locale('tr')], []),
      const Locale('tr'),
    );
    expect(AppLanguages.resolve([const Locale('he')], []), const Locale('fr'));
    expect(AppLanguages.resolve(null, []), const Locale('fr'));
    for (final tag in [
      null,
      '',
      'xx',
      'ar--EG',
      'fr/../../',
      'fr invalid',
      'x' * 64,
    ]) {
      expect(AppLanguages.parse(tag), isNull, reason: '$tag');
    }
  });

  test(
    'sorts displayed Latin language names alphabetically ignoring accents',
    () {
      final latin = AppLanguages.sorted
          .where((e) => RegExp(r'^[A-Za-zČ]').hasMatch(e.name))
          .map((e) => e.tag)
          .toList();
      expect(latin, [
        'id',
        'ms',
        'cs',
        'da',
        'de',
        'en',
        'es',
        'fil',
        'fr',
        'it',
        'nl',
        'nb',
        'pl',
        'pt',
        'ro',
        'sv',
        'vi',
        'tr',
      ]);
    },
  );
}
