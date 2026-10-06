import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/guest_claim_page.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/features/billing/subscription_card.dart';

import '../support/welcome_ui_fixture.dart';

const _previewExports = bool.fromEnvironment('FUZEVPN_ONBOARDING_PREVIEWS');

void main() {
  setUpAll(() async {
    if (!_previewExports) return;
    TestWidgetsFlutterBinding.ensureInitialized();
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader('IBM Plex Mono')
          ..addFont(rootBundle.load('assets/fonts/IBMPlexMono-Regular.ttf'))
          ..addFont(rootBundle.load('assets/fonts/IBMPlexMono-SemiBold.ttf')))
        .load();
    await (FontLoader(
      'Noto Sans Arabic',
    )..addFont(rootBundle.load('assets/fonts/NotoSansArabic.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });

  const sizes = [
    Size(320, 640),
    Size(411, 915),
    Size(800, 1280),
    Size(1920, 1080),
  ];
  for (final size in sizes) {
    for (final dark in [false, true]) {
      final locale = dark ? const Locale('ar') : const Locale('fr');
      for (final page in ['paywall', 'login', 'claim']) {
        testWidgets(
          '$page ${size.width}dp ${dark ? "dark RTL" : "light"} at 200% remains reachable with keyboard where relevant',
          (tester) async {
            _configure(tester, size, scale: 2, keyboard: page != 'paywall');
            final controller = WelcomeUiController()..locale = locale;
            if (page == 'claim') {
              controller.profile = guestUiProfile(canUseVpn: true);
            }
            addTearDown(controller.dispose);
            final Widget content = switch (page) {
              'paywall' => SubscriptionPaywallPage(controller: controller),
              'login' => AuthenticationPage(
                controller: controller,
                loginOnly: true,
              ),
              _ => GuestClaimPage(controller: controller),
            };
            await tester.pumpWidget(
              welcomeUiTestApp(controller, content, dark: dark),
            );
            await tester.pumpAndSettle();
            if (page == 'paywall') {
              await _reveal(
                tester,
                find.byKey(const ValueKey('subscription-plan-monthly')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('subscription-plan-yearly')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('subscription-continue')),
              );
              expect(
                tester
                    .widget<FilledButton>(
                      find.byKey(const ValueKey('subscription-continue')),
                    )
                    .onPressed,
                isNull,
              );
              expect(controller.purchaseRequests, isEmpty);
            } else if (page == 'login') {
              await _reveal(
                tester,
                find.byKey(const ValueKey('auth-login-email')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('auth-login-password')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('auth-login-submit')),
              );
              expect(find.byType(TabBar), findsNothing);
            } else {
              await _reveal(
                tester,
                find.byKey(const ValueKey('guest-claim-email')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('guest-claim-password')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('guest-claim-submit')),
              );
              await _reveal(
                tester,
                find.byKey(const ValueKey('guest-claim-skip')),
              );
              expect(controller.claims, 0);
            }
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }

  if (_previewExports) {
    const previews = <(String, Size, double, bool)>[
      ('welcome-mobile', Size(411, 915), 1, false),
      ('welcome-tablet', Size(800, 1280), 1, false),
      ('welcome-large', Size(1920, 1080), 1, false),
      ('welcome-small-200', Size(320, 640), 2, false),
      ('welcome-mobile-dark', Size(411, 915), 1, true),
      ('paywall-mobile-fixture', Size(411, 915), 1, false),
      ('claim-mobile', Size(411, 915), 1, false),
    ];
    for (final (name, size, scale, dark) in previews) {
      testWidgets('export $name preview', (tester) async {
        _configure(tester, size, scale: scale);
        final controller = WelcomeUiController();
        if (name.startsWith('claim')) {
          controller.profile = guestUiProfile(canUseVpn: true);
        }
        addTearDown(controller.dispose);
        final Widget content = name.startsWith('paywall')
            ? SubscriptionPaywallPage(controller: controller)
            : name.startsWith('claim')
            ? GuestClaimPage(controller: controller)
            : WelcomePage(controller: controller);
        final markedContent = name.startsWith('paywall')
            ? Stack(
                children: [
                  content,
                  Positioned(
                    right: 8,
                    bottom: 4,
                    child: Material(
                      color: FuzeVpnTheme.ink,
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          'REVUE UI · PRIX DE TEST',
                          textScaler: TextScaler.noScaling,
                          style: FuzeVpnTheme.mono(
                            fontSize: 10,
                            color: FuzeVpnTheme.paper,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : content;
        await tester.pumpWidget(
          welcomeUiTestApp(controller, markedContent, dark: dark),
        );
        await tester.pumpAndSettle();
        await _decodeImages(tester);
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            '../../build/reports/welcome-guest-2026-10-04/previews/$name.png',
          ),
        );
      }, tags: 'onboarding-preview');
    }
  }
}

void _configure(
  WidgetTester tester,
  Size size, {
  double scale = 1,
  bool keyboard = false,
}) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  if (keyboard) tester.view.viewInsets = const FakeViewPadding(bottom: 220);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetViewInsets);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final scrollable = find.byType(Scrollable).first;
  tester.state<ScrollableState>(scrollable).position.jumpTo(0);
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(target, 180, scrollable: scrollable);
  await tester.pumpAndSettle();
  expect(target.hitTestable(), findsOneWidget);
}

Future<void> _decodeImages(WidgetTester tester) async {
  final images = tester.widgetList<Image>(find.byType(Image)).toList();
  final context = tester.element(find.byType(Scaffold).first);
  await tester.runAsync(() async {
    await Future.wait(
      images.map((image) => precacheImage(image.image, context)),
    );
  });
  await tester.pumpAndSettle();
}
