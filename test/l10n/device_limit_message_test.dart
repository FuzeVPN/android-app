import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/notice_card.dart';

void main() {
  for (final locale in AppLocalizations.supportedLocales) {
    test('device limit title needs no quota in ${locale.toLanguageTag()}', () {
      final l = lookupAppLocalizations(locale);
      final failure = ApiErrorMessages.fromFailure(
        const ApiException(statusCode: 409, errorCode: 'device_limit'),
      );
      final title = AppCopy.resolve(
        l,
        failure.titleKey,
        arguments: failure.arguments,
      );
      expect(title, l.notice_api_title('device_limit'));
      expect(title.trim(), isNotEmpty);
      expect(title, isNot(matches(RegExp(r'[0-9٠-٩۰-۹]'))));
      expect(failure.arguments.containsKey('limit'), isFalse);
      expect(failure.machineCode, 'device_limit');
      expect(failure.diagnosticCode, contains('device_limit'));
    });
  }

  testWidgets('French notice shows general title and safe reference', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: NoticeCard(
            notice: const AppNotice(
              titleKey: 'notice.api.title',
              messageKey: 'notice.api.message',
              arguments: {'code': 'device_limit'},
              diagnosticCode: 'HTTP 409 · device_limit',
            ),
            onDismiss: () {},
          ),
        ),
      ),
    );
    expect(find.text('Limite d’appareils atteinte'), findsOneWidget);
    expect(find.textContaining('HTTP 409 · device_limit'), findsOneWidget);
    expect(find.text('Limite de 2 appareils atteinte'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
