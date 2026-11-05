import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_formats.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/language_settings.dart';

void main() {
  test('formatting retains regions without adding translation choices', () {
    expect(AppLanguages.all, hasLength(30));
    expect(AppLanguages.supportedLocales, hasLength(30));
    expect(
      AppLanguages.resolve([const Locale('en', 'GB')], []),
      const Locale('en'),
    );
    expect(
      AppLanguages.formattingLocale(const Locale('en'), const [
        Locale('he', 'IL'),
        Locale('en', 'GB'),
      ]),
      const Locale('en', 'GB'),
    );
    expect(
      AppLanguages.formattingLocale(const Locale('en', 'US'), const [
        Locale('en', 'GB'),
      ]),
      const Locale('en', 'US'),
    );
    expect(
      AppLanguages.formattingLocale(const Locale('fr'), const [
        Locale('fr', 'CA'),
      ]),
      const Locale('fr', 'CA'),
    );
    expect(
      AppLanguages.formattingLocale(const Locale('en'), const [
        Locale('fr', 'FR'),
      ]),
      const Locale('en'),
    );
    expect(
      AppLanguages.formattingLocale(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        const [Locale('zh', 'CN'), Locale('zh', 'TW')],
      ),
      const Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'TW',
      ),
    );
  });

  for (final (region, numeric, written) in [
    ('GB', '02/11/2026', '2 November 2026'),
    ('US', '11/2/2026', 'November 2, 2026'),
  ]) {
    testWidgets('system en-$region retains regional date conventions', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [Locale('en', region)];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLanguages.supportedLocales,
          localeListResolutionCallback: AppLanguages.resolve,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) => Text(
              '${AppFormats.date(context, DateTime(2026, 11, 2))}\n'
              '${AppFormats.longDate(context, DateTime(2026, 11, 2))}',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('$numeric\n$written'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final language in AppLanguages.all) {
    test(
      '${language.tag} retains names, generic quotas and Google guidance',
      () {
        final l = lookupAppLocalizations(language.locale);
        final generic = l.notice_api_title('device_limit');
        expect(l.notice_deviceLimit_title, generic);
        expect(
          l.notice_controller_title('revoked_identity_device_limit'),
          generic,
        );
        expect(generic, isNot(matches(RegExp(r'[0-9٠-٩۰-۹]'))));
        for (final name in ['Pixel {}', '{} {}', 'Côte d’Ivoire', 'جهاز {}']) {
          expect(
            AppCopy.resolve(l, 'dialog.removeOther', arguments: {'name': name}),
            l.dialog_removeOther(name),
          );
          expect(
            AppCopy.resolve(
              l,
              'locations.chooseCountry',
              arguments: {'name': name},
            ),
            l.locations_chooseCountry(name),
          );
        }
        for (final key in [
          'google.intentMismatch',
          'google.challengeBlocked',
          'google.solveChallenge',
          'google.challengeTitle',
          'google.challengeReady',
          'google.challengeExpired',
          'google.challengeCancelled',
          'google.challengeFailed',
        ]) {
          final text = AppCopy.resolve(l, key);
          expect(text.trim(), isNotEmpty);
          expect(text, isNot(key));
        }
      },
    );
  }

  test('Filipino diagnostic summaries retain every nonzero event count', () {
    final l = lookupAppLocalizations(const Locale('fil'));
    expect(
      l.diagnostics_eventCount(0),
      'Walang naka-attach na teknikal na event',
    );
    for (final count in [1, 2, 3, 4, 5, 6, 9, 11, 21, 100]) {
      expect(
        AppCopy.resolve(
          l,
          'diagnostics.eventCount',
          arguments: {'count': count},
        ),
        '$count naka-attach na teknikal na event',
      );
    }
  });

  for (final language in ['fr', 'ar', 'fa', 'ur']) {
    testWidgets('$language language chevron is mirrored only by Flutter', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(language),
          supportedLocales: AppLanguages.supportedLocales,
          localeListResolutionCallback: AppLanguages.resolve,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(
            body: LanguageSettings(locale: Locale(language), onChanged: (_) {}),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final icon = find.byIcon(Icons.chevron_right);
      expect(icon, findsOneWidget);
      expect(find.byIcon(Icons.chevron_left), findsNothing);
      final mirrors = find.descendant(
        of: icon,
        matching: find.byType(Transform),
      );
      if (language == 'fr') {
        expect(mirrors, findsNothing);
      } else {
        expect(tester.widget<Transform>(mirrors).transform.entry(0, 0), -1);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
