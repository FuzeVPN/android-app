// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/vpn_disclosure_dialog.dart';

void main() {
  testWidgets('only explicit acceptance grants disclosure consent', (
    tester,
  ) async {
    final result = _Decision();
    await _mount(tester, result);
    await _open(tester);
    expect(result.accepted, isNull);
    expect(result.completed, 0);
    await tester.tap(find.byKey(const ValueKey('vpn-disclosure-accept')));
    await tester.pumpAndSettle();
    expect(result.accepted, isTrue);
    expect(result.completed, 1);
    expect(find.byType(VpnDisclosureDialog), findsNothing);
  });

  for (final dismissal in <String>['decline', 'back', 'outside']) {
    testWidgets('$dismissal refuses and a new attempt shows the mention', (
      tester,
    ) async {
      final result = _Decision();
      await _mount(tester, result);
      await _open(tester);
      switch (dismissal) {
        case 'decline':
          await tester.tap(
            find.byKey(const ValueKey('vpn-disclosure-decline')),
          );
        case 'back':
          await tester.binding.handlePopRoute();
        case 'outside':
          await tester.tapAt(const Offset(1, 1));
      }
      await tester.pumpAndSettle();
      expect(result.accepted, isFalse);
      expect(result.completed, 1);
      expect(find.byType(VpnDisclosureDialog), findsNothing);
      await _open(tester);
      expect(find.byType(VpnDisclosureDialog), findsOneWidget);
      // Reopening itself is not a second consent decision.
      expect(result.completed, 1);
      await tester.tap(find.byKey(const ValueKey('vpn-disclosure-decline')));
      await tester.pumpAndSettle();
      expect(result.accepted, isFalse);
      expect(result.completed, 2);
    });
  }

  testWidgets('opening the privacy notice does not grant consent', (
    tester,
  ) async {
    const launcher = MethodChannel('plugins.flutter.io/url_launcher');
    final opened = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(launcher, (
      call,
    ) async {
      if (call.method == 'launch') {
        opened.add((call.arguments as Map)['url'] as String);
        return true;
      }
      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        launcher,
        null,
      ),
    );
    final result = _Decision();
    await _mount(tester, result);
    await _open(tester);
    final privacy = find.byKey(const ValueKey('vpn-disclosure-privacy'));
    await tester.ensureVisible(privacy);
    await tester.pumpAndSettle();
    await tester.tap(privacy);
    await tester.pumpAndSettle();
    expect(opened, <String>['https://fuzevpn.com/fr/privacy.html']);
    expect(result.accepted, isNull);
    expect(result.completed, 0);
    expect(find.byType(VpnDisclosureDialog), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('vpn-disclosure-decline')));
    await tester.pumpAndSettle();
    expect(result.accepted, isFalse);
    expect(tester.takeException(), isNull);
  });

  for (final size in const <Size>[
    Size(320, 640),
    Size(411, 915),
    Size(800, 1280),
    Size(1920, 1080),
    Size(800, 400),
  ]) {
    for (final dark in <bool>[false, true]) {
      for (final scale in <double>[1, 2]) {
        testWidgets('disclosure ${size.width}x${size.height}dp '
            '${dark ? "dark RTL" : "light LTR"} at ${scale * 100}%', (
          tester,
        ) async {
          _configure(tester, size);
          final result = _Decision();
          await _mount(
            tester,
            result,
            dark: dark,
            scale: scale,
            locale: dark ? const Locale('ar') : const Locale('fr'),
          );
          await _open(tester);
          final dialog = find.byType(VpnDisclosureDialog);
          final context = tester.element(dialog);
          expect(
            Directionality.of(context),
            dark ? TextDirection.rtl : TextDirection.ltr,
          );
          expect(MediaQuery.textScalerOf(context).scale(1), scale);
          final safe = Rect.fromLTRB(8, 24, size.width - 8, size.height - 24);
          final panel = tester.getRect(
            find.byKey(const ValueKey('vpn-disclosure-panel')),
          );
          expect(panel.width, lessThanOrEqualTo(480));
          _expectInside(panel, safe);
          for (final key in <String>[
            'vpn-disclosure-accept',
            'vpn-disclosure-decline',
          ]) {
            final action = find.byKey(ValueKey(key));
            _expectInside(tester.getRect(action), safe);
            expect(action.hitTestable(), findsOneWidget);
            expect(tester.getSize(action).height, greaterThanOrEqualTo(48));
          }
          final scroll = find.byKey(const ValueKey('vpn-disclosure-scroll'));
          for (final key in <String>[
            'vpn-disclosure-data',
            'vpn-disclosure-status',
            'vpn-disclosure-privacy',
          ]) {
            final item = find.byKey(ValueKey(key));
            await tester.ensureVisible(item);
            await tester.pumpAndSettle();
            final viewport = tester.getRect(scroll);
            expect(tester.getRect(item).overlaps(viewport), isTrue);
          }
          expect(result.completed, 0);
          expect(tester.takeException(), isNull);
          await tester.tap(
            find.byKey(const ValueKey('vpn-disclosure-decline')),
          );
          await tester.pumpAndSettle();
          expect(result.accepted, isFalse);
        });
      }
    }
  }

  for (final language in AppLanguages.all) {
    testWidgets(
      'translated disclosure actions fit at 320dp 200% in ${language.tag}',
      (tester) async {
        _configure(tester, const Size(320, 640));
        final result = _Decision();
        await _mount(tester, result, scale: 2, locale: language.locale);
        await _open(tester);
        final copy = AppLocalizations.of(
          tester.element(find.byType(VpnDisclosureDialog)),
        );
        expect(copy.vpnDisclosure_title.trim(), isNotEmpty);
        expect(copy.vpnDisclosure_body.trim(), isNotEmpty);
        expect(copy.vpnDisclosure_dataBody.trim(), isNotEmpty);
        expect(copy.vpnDisclosure_statusBody.trim(), isNotEmpty);
        for (final label in <String>[
          copy.vpnDisclosure_accept,
          copy.vpnDisclosure_decline,
        ]) {
          final action = find.text(label);
          expect(action.hitTestable(), findsOneWidget);
          _expectInside(
            tester.getRect(action),
            const Rect.fromLTRB(8, 24, 312, 616),
          );
        }
        expect(tester.takeException(), isNull);
        await tester.tap(find.byKey(const ValueKey('vpn-disclosure-decline')));
        await tester.pumpAndSettle();
        expect(result.accepted, isFalse);
      },
    );
  }
}

class _Decision {
  bool? accepted;
  int completed = 0;
}

Future<void> _mount(
  WidgetTester tester,
  _Decision result, {
  bool dark = false,
  double scale = 1,
  Locale locale = const Locale('fr'),
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: dark ? FuzeVpnTheme.dark() : FuzeVpnTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLanguages.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: TextButton(
              key: const ValueKey('open-vpn-disclosure'),
              onPressed: () async {
                result.accepted = await showVpnDisclosureDialog(context);
                result.completed += 1;
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('open-vpn-disclosure')));
  await tester.pumpAndSettle();
  expect(find.byType(VpnDisclosureDialog), findsOneWidget);
}

void _configure(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.view.viewPadding = const FakeViewPadding(
    left: 8,
    top: 24,
    right: 8,
    bottom: 24,
  );
  tester.view.padding = const FakeViewPadding(
    left: 8,
    top: 24,
    right: 8,
    bottom: 24,
  );
  addTearDown(tester.view.reset);
}

void _expectInside(Rect rect, Rect bounds) {
  expect(rect.left, greaterThanOrEqualTo(bounds.left));
  expect(rect.top, greaterThanOrEqualTo(bounds.top));
  expect(rect.right, lessThanOrEqualTo(bounds.right));
  expect(rect.bottom, lessThanOrEqualTo(bounds.bottom));
}
