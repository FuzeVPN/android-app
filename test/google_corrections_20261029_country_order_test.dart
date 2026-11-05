// Corrections du 29/10/2026, sous-lot R2-google : A03-google-04 et
// A16-ui-l10n-06. Ordre alphabétique propre à chaque langue, partagé par le
// sélecteur de pays Google et les Emplacements (lib/core/location_grouping.dart).
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/location_grouping.dart';
import 'package:fuzevpn_android/l10n/translated_countries.dart';

void main() {
  group('sortedByLocalizedLabel', () {
    test('no displayed country follows the last letter of its alphabet', () {
      for (final language in ['fr', 'en', 'de', 'es', 'it', 'pt', 'nl']) {
        final names = translatedCountryNames[language]!;
        final sorted = sortedByLocalizedLabel(
          names.keys.where((code) => RegExp(r'^[A-Z]{2}$').hasMatch(code)),
          (code) => names[code]!,
          languageCode: language,
        );
        final initials = sorted
            .map(
              (code) =>
                  String.fromCharCode(names[code]!.runes.first).toLowerCase(),
            )
            .toList();
        expect(initials.last, 'z', reason: language);
        expect(
          initials.where((initial) => initial == 'z'),
          hasLength(initials.length - initials.indexOf('z')),
          reason: language,
        );
      }
    });

    test('ar: hamza alef forms are ordered as alef, madda alef first', () {
      final names = translatedCountryNames['ar']!;
      final sorted = sortedByLocalizedLabel(
        names.keys.where((code) => RegExp(r'^[A-Z]{2}$').hasMatch(code)),
        (code) => names[code]!,
        languageCode: 'ar',
      ).map((code) => names[code]!).toList();
      const alef = {'ا', 'آ', 'أ', 'إ'};
      final initials = [for (final name in sorted) name[0]];
      final alefNames = initials.where(alef.contains).length;
      expect(initials.take(alefNames).every(alef.contains), isTrue);
      // As in CLDR (ICU 78.3), آ precedes the block, where ا, أ and إ
      // interleave by the next letters.
      final block = sorted.take(alefNames).toList();
      expect(block.first, 'آيسلندا');
      expect(
        block,
        containsAll(['إثيوبيا', 'الأرجنتين', 'ألبانيا', 'آيسلندا']),
      );
      for (final (before, after) in [
        ('آيسلندا', 'إثيوبيا'),
        ('إثيوبيا', 'أفغانستان'),
        ('أفغانستان', 'الأرجنتين'),
        ('الأرجنتين', 'ألبانيا'),
        ('ألبانيا', 'أوغندا'),
      ]) {
        expect(
          block.indexOf(before),
          lessThan(block.indexOf(after)),
          reason: '$before < $after',
        );
      }
      expect(
        sortedByLocalizedLabel(
          ['اتیوپی', 'آلمان'],
          (label) => label,
          languageCode: 'fa',
        ),
        ['آلمان', 'اتیوپی'],
      );
    });

    test('every language keeps a complete, deterministic order', () {
      for (final MapEntry(key: language, value: names)
          in translatedCountryNames.entries) {
        final codes = names.keys.toList();
        final sorted = sortedByLocalizedLabel(
          codes,
          (code) => names[code]!,
          languageCode: language,
          tieBreak: (a, b) => a.compareTo(b),
        );
        expect(sorted.toSet(), codes.toSet(), reason: language);
        expect(
          sortedByLocalizedLabel(
            codes.reversed,
            (code) => names[code]!,
            languageCode: language,
            tieBreak: (a, b) => a.compareTo(b),
          ),
          sorted,
          reason: language,
        );
      }
    });

    test('ties are deterministic; case, accents and spacing are secondary', () {
      expect(
        sortedByLocalizedLabel(
          ['b', 'Éa', 'ea', 'Ea', 'e-a', 'Zz'],
          (label) => label,
          languageCode: 'fr',
        ),
        ['b', 'e-a', 'Ea', 'ea', 'Éa', 'Zz'],
      );
      expect(
        sortedByLocalizedLabel(
          [('x', 'Same'), ('a', 'Same')],
          (item) => item.$2,
          languageCode: 'nl',
          tieBreak: (a, b) => a.$1.compareTo(b.$1),
        ).map((item) => item.$1),
        ['a', 'x'],
      );
      expect(
        sortedByLocalizedLabel(
          ['Server 10', 'Server 2'],
          (label) => label,
          languageCode: 'en',
        ),
        ['Server 2', 'Server 10'],
      );
    });

    test('language tailorings only apply to their own language', () {
      List<String> sort(String language, List<String> labels) =>
          sortedByLocalizedLabel(
            labels,
            (label) => label,
            languageCode: language,
          );
      expect(sort('sv', ['Österrike', 'Zimbabwe']), ['Zimbabwe', 'Österrike']);
      expect(sort('de', ['Österreich', 'Zypern']), ['Österreich', 'Zypern']);
      expect(sort('cs', ['Chile', 'Honduras']), ['Honduras', 'Chile']);
      expect(sort('fr', ['Chili', 'Honduras']), ['Chili', 'Honduras']);
      expect(sort('tr', ['İran', 'Irak', 'Hindistan']), [
        'Hindistan',
        'Irak',
        'İran',
      ]);
      expect(sort('en', ['Iran', 'Iraq']), ['Iran', 'Iraq']);
      // Orders checked with ICU 78.3 / CLDR 48 (review round 2).
      expect(sort('tr', ['Dominika', 'Çad', 'Cezayir']), [
        'Cezayir',
        'Çad',
        'Dominika',
      ]);
      expect(sort('tr', ['Japonya', 'İngiltere', 'Irak', 'Hindistan']), [
        'Hindistan',
        'Irak',
        'İngiltere',
        'Japonya',
      ]);
      expect(sort('tr', ['Şili', 'Suudi Arabistan', 'Tanzanya']), [
        'Suudi Arabistan',
        'Şili',
        'Tanzanya',
      ]);
      expect(sort('cs', ['Dánsko', 'Čad', 'Cookovy ostrovy']), [
        'Cookovy ostrovy',
        'Čad',
        'Dánsko',
      ]);
      expect(sort('cs', ['Španělsko', 'Sýrie', 'Řecko', 'Rwanda']), [
        'Rwanda',
        'Řecko',
        'Sýrie',
        'Španělsko',
      ]);
      expect(sort('fr', ['Cezayir', 'Çad']), ['Çad', 'Cezayir']);
      expect(sort('en', ['Irak', 'İngiltere']), ['İngiltere', 'Irak']);
      expect(sort('es', ['Ñu', 'Nz', 'Oa']), ['Nz', 'Ñu', 'Oa']);
      expect(sort('fr', ['Ña', 'Nb']), ['Ña', 'Nb']);
    });
  });
}
