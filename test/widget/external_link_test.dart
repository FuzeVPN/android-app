import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/external_link.dart';

const _launcher = MethodChannel('plugins.flutter.io/url_launcher');
final _url = Uri.parse('https://fuzevpn.com/fr/privacy.html#rights-deletion');

void main() {
  for (final throws in [false, true]) {
    testWidgets('failed external link offers a copy (exception=$throws)', (
      tester,
    ) async {
      final launches = <Map<Object?, Object?>>[];
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        _launcher,
        (call) async {
          if (call.method != 'launch') return null;
          launches.add(call.arguments as Map<Object?, Object?>);
          if (throws) throw PlatformException(code: 'no_browser');
          return false;
        },
      );
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied =
                (call.arguments as Map<Object?, Object?>)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(() {
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          _launcher,
          null,
        );
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        );
      });
      await tester.pumpWidget(_testApp());
      await tester.tap(find.byKey(const ValueKey('open-link')));
      await tester.pumpAndSettle();
      expect(launches.single['url'], _url.toString());
      expect(launches.single['useWebView'], isFalse);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
        find.widgetWithText(SelectableText, _url.toString()),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const ValueKey('copy-external-link')));
      await tester.pumpAndSettle();
      expect(copied, _url.toString());
      expect(find.text('Lien copié'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('clipboard refusal keeps the address available at large text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      _launcher,
      (_) async => false,
    );
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          throw PlatformException(code: 'clipboard_unavailable');
        }
        return null;
      },
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        _launcher,
        null,
      );
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });
    await tester.pumpWidget(_testApp(locale: const Locale('ar')));
    await tester.tap(find.byKey(const ValueKey('open-link')));
    await tester.pumpAndSettle();
    expect(
      Directionality.of(tester.element(find.byType(AlertDialog))),
      TextDirection.rtl,
    );
    await tester.tap(find.byKey(const ValueKey('copy-external-link')));
    await tester.pumpAndSettle();
    final localizations = AppLocalizations.of(
      tester.element(find.byType(AlertDialog)),
    );
    expect(find.text(localizations.externalLink_copyFailed), findsOneWidget);
    expect(
      find.widgetWithText(SelectableText, _url.toString()),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('successful launch needs no fallback', (tester) async {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      _launcher,
      (_) async => true,
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        _launcher,
        null,
      ),
    );
    await tester.pumpWidget(_testApp());
    await tester.tap(find.byKey(const ValueKey('open-link')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a late launch refusal cannot reopen a disposed page', (
    tester,
  ) async {
    final result = Completer<bool>();
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      _launcher,
      (_) => result.future,
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        _launcher,
        null,
      ),
    );
    await tester.pumpWidget(_testApp());
    await tester.tap(find.byKey(const ValueKey('open-link')));
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    result.complete(false);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

Widget _testApp({Locale locale = const Locale('fr')}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLanguages.supportedLocales,
  localeListResolutionCallback: AppLanguages.resolve,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: FuzeVpnTheme.light(),
  home: Scaffold(
    body: Builder(
      builder: (context) => Center(
        child: TextButton(
          key: const ValueKey('open-link'),
          onPressed: () => openExternalLink(context, _url),
          child: const Text('Open'),
        ),
      ),
    ),
  ),
);
