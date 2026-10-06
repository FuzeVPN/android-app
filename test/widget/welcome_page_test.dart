import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/guest_claim_page.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/features/billing/subscription_card.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

import '../support/welcome_ui_fixture.dart';

void main() {
  for (final language in AppLanguages.all) {
    testWidgets(
      'welcome ${language.tag} keeps every entry action reachable at 320dp and 200% text',
      (tester) async {
        _screen(tester, const Size(320, 640), scale: 2);
        final controller = WelcomeUiController()..locale = language.locale;
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          welcomeUiTestApp(controller, WelcomePage(controller: controller)),
        );
        await tester.pumpAndSettle();
        expect(find.byType(TextFormField), findsNothing);
        for (final key in [
          'welcome-start',
          'welcome-sign-in',
          'welcome-restore',
          'onboarding-terms',
          'onboarding-privacy',
        ]) {
          final action = find.byKey(ValueKey(key));
          await _reveal(tester, action);
          await tester.pumpAndSettle();
          expect(action.hitTestable(), findsOneWidget);
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final size in [
    const Size(411, 915),
    const Size(800, 1280),
    const Size(1920, 1080),
  ]) {
    for (final dark in [false, true]) {
      testWidgets(
        'welcome ${size.width}dp ${dark ? "dark" : "light"} stays within the viewport',
        (tester) async {
          _screen(tester, size);
          final controller = WelcomeUiController();
          addTearDown(controller.dispose);
          await tester.pumpWidget(
            welcomeUiTestApp(
              controller,
              WelcomePage(controller: controller),
              dark: dark,
            ),
          );
          await tester.pumpAndSettle();
          final start = find.byKey(const ValueKey('welcome-start'));
          await _reveal(tester, start);
          await tester.pumpAndSettle();
          expect(start.hitTestable(), findsOneWidget);
          expect(tester.getSize(start).width, lessThanOrEqualTo(520));
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets('welcome sign in opens only the identification form', (
    tester,
  ) async {
    final controller = WelcomeUiController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      welcomeUiTestApp(controller, WelcomePage(controller: controller)),
    );
    await _reveal(tester, find.byKey(const ValueKey('welcome-sign-in')));
    await tester.tap(find.byKey(const ValueKey('welcome-sign-in')));
    await tester.pumpAndSettle();
    expect(find.byType(AuthenticationPage), findsOneWidget);
    expect(find.byType(TabBar), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Créer un compte'), findsNothing);
    expect(controller.restores, 0);
    expect(controller.purchaseRequests, isEmpty);
  });

  testWidgets(
    'already purchased invokes restoration directly without a registration form',
    (tester) async {
      final controller = WelcomeUiController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      final restore = find.byKey(const ValueKey('welcome-restore'));
      await _reveal(tester, restore);
      await tester.tap(restore);
      await tester.pumpAndSettle();
      expect(controller.restores, 1);
      expect(find.text('Voir les formules'), findsOneWidget);
      expect(find.text('Réessayer'), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
      expect(controller.purchaseRequests, isEmpty);
    },
  );

  testWidgets(
    'welcome can display an API notice without requiring intrinsic layout of its banner',
    (tester) async {
      _screen(tester, const Size(320, 640), scale: 2);
      final controller = WelcomeUiController()
        ..notice = const AppNotice(
          titleKey: 'accountRestoration.title',
          messageKey: 'accountRestoration.message',
        );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      await tester.pumpAndSettle();
      await _reveal(tester, find.byKey(const ValueKey('welcome-start')));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'paywall shows exact SDK prices with no selected plan and requires an explicit choice',
    (tester) async {
      final controller = WelcomeUiController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      await _reveal(tester, find.byKey(const ValueKey('welcome-start')));
      await tester.tap(find.byKey(const ValueKey('welcome-start')));
      await tester.pumpAndSettle();
      expect(find.byType(SubscriptionPaywallPage), findsOneWidget);
      expect(find.text('4,79 €'), findsOneWidget);
      expect(find.text('37,99 €'), findsOneWidget);
      final proceed = find.byKey(const ValueKey('subscription-continue'));
      await _reveal(tester, proceed);
      expect(tester.widget<FilledButton>(proceed).onPressed, isNull);
      expect(controller.purchaseRequests, isEmpty);
      await _reveal(
        tester,
        find.byKey(const ValueKey('subscription-plan-yearly')),
      );
      await tester.tap(find.byKey(const ValueKey('subscription-plan-yearly')));
      await tester.pumpAndSettle();
      await _reveal(tester, proceed);
      expect(tester.widget<FilledButton>(proceed).onPressed, isNotNull);
      expect(controller.purchaseRequests, isEmpty);
    },
  );

  testWidgets(
    'paid entitlement waits for fresh VPN permission before optional account activation',
    (tester) async {
      final controller = WelcomeUiController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      await _reveal(tester, find.byKey(const ValueKey('welcome-start')));
      await tester.tap(find.byKey(const ValueKey('welcome-start')));
      await tester.pumpAndSettle();
      await _reveal(
        tester,
        find.byKey(const ValueKey('subscription-plan-monthly')),
      );
      await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
      await tester.pumpAndSettle();
      final proceed = find.byKey(const ValueKey('subscription-continue'));
      await _reveal(tester, proceed);
      await tester.tap(proceed);
      await tester.pumpAndSettle();
      expect(controller.purchaseRequests.single.basePlanId, 'monthly');
      expect(find.byKey(const ValueKey('guest-activation')), findsNothing);
      expect(
        find.byKey(const ValueKey('subscription-access-refresh')),
        findsOneWidget,
      );
      controller.confirmVpnAccess();
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('guest-activation')), findsOneWidget);
      expect(controller.claims, 0);
      final use = find.byKey(const ValueKey('guest-activation-use-vpn'));
      await _reveal(tester, use);
      await tester.tap(use);
      await tester.pumpAndSettle();
      expect(find.byType(SubscriptionPaywallPage), findsNothing);
      expect(controller.claims, 0);
    },
  );

  testWidgets(
    'successful paywall restoration returns to the application without an account invitation',
    (tester) async {
      final controller = WelcomeUiController()..restoreSucceeds = true;
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      final start = find.byKey(const ValueKey('welcome-start'));
      await _reveal(tester, start);
      await tester.tap(start);
      await tester.pumpAndSettle();
      final restore = find.byKey(
        const ValueKey('subscription-selection-restore'),
      );
      await _reveal(tester, restore);
      await tester.tap(restore);
      await tester.pumpAndSettle();
      expect(controller.restores, 1);
      expect(controller.profile?.canUseVpn, isTrue);
      expect(find.byType(SubscriptionPaywallPage), findsNothing);
      expect(find.byKey(const ValueKey('guest-activation')), findsNothing);
      expect(find.byType(GuestClaimPage), findsNothing);
      expect(controller.claims, 0);
    },
  );

  testWidgets(
    'an already owned purchase restored during Continue does not show the new-purchase account invitation',
    (tester) async {
      final controller = WelcomeUiController()
        ..purchaseResultKey = 'billing.restored';
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      final start = find.byKey(const ValueKey('welcome-start'));
      await _reveal(tester, start);
      await tester.tap(start);
      await tester.pumpAndSettle();
      final monthly = find.byKey(const ValueKey('subscription-plan-monthly'));
      await _reveal(tester, monthly);
      await tester.tap(monthly);
      await tester.pumpAndSettle();
      final proceed = find.byKey(const ValueKey('subscription-continue'));
      await _reveal(tester, proceed);
      await tester.tap(proceed);
      await tester.pumpAndSettle();
      controller.confirmVpnAccess();
      await tester.pumpAndSettle();
      expect(controller.purchaseRequests, hasLength(1));
      expect(controller.profile?.canUseVpn, isTrue);
      expect(find.byKey(const ValueKey('guest-activation')), findsNothing);
      expect(find.byType(GuestClaimPage), findsNothing);
      expect(controller.claims, 0);
      final useVpn = find.byKey(const ValueKey('subscription-use-vpn'));
      await _reveal(tester, useVpn);
      await tester.tap(useVpn);
      await tester.pumpAndSettle();
      expect(find.byType(SubscriptionPaywallPage), findsNothing);
    },
  );

  testWidgets(
    'claim uses only email and password and remains skippable at 200% text',
    (tester) async {
      _screen(tester, const Size(320, 640), scale: 2);
      final controller = WelcomeUiController()
        ..profile = guestUiProfile(canUseVpn: true);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, WelcomePage(controller: controller)),
      );
      unawaited(
        Navigator.of(tester.element(find.byType(WelcomePage))).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => GuestClaimPage(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await _reveal(tester, find.byKey(const ValueKey('guest-claim-email')));
      expect(find.byType(TextFormField), findsNWidgets(2));
      final skip = find.byKey(const ValueKey('guest-claim-skip'));
      await _reveal(tester, skip);
      await tester.pumpAndSettle();
      expect(skip.hitTestable(), findsOneWidget);
      await tester.tap(skip);
      await tester.pumpAndSettle();
      expect(find.byType(GuestClaimPage), findsNothing);
      expect(controller.profile?.userId, 'guest-fixture');
      expect(controller.claims, 0);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'claim validates malformed email and short password without submitting',
    (tester) async {
      final controller = WelcomeUiController()
        ..profile = guestUiProfile(canUseVpn: true);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, GuestClaimPage(controller: controller)),
      );
      await tester.enterText(
        find.byKey(const ValueKey('guest-claim-email')),
        'invalid',
      );
      await tester.enterText(
        find.byKey(const ValueKey('guest-claim-password')),
        'short',
      );
      final submit = find.byKey(const ValueKey('guest-claim-submit'));
      await _reveal(tester, submit);
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(controller.claims, 0);
      final localizations = AppLocalizations.of(
        tester.element(find.byType(GuestClaimPage)),
      );
      await _reveal(tester, find.byKey(const ValueKey('guest-claim-email')));
      expect(find.text(localizations.validation_email), findsOneWidget);
      expect(find.text(localizations.validation_password), findsOneWidget);
    },
  );

  testWidgets(
    'an existing email preserves the guest and lets the user edit the address or sign in separately',
    (tester) async {
      final controller = WelcomeUiController()
        ..profile = guestUiProfile(canUseVpn: true);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(controller, GuestClaimPage(controller: controller)),
      );
      final email = find.byKey(const ValueKey('guest-claim-email'));
      final password = find.byKey(const ValueKey('guest-claim-password'));
      await _reveal(tester, email);
      await tester.enterText(email, 'fixture@example.invalid');
      await _reveal(tester, password);
      await tester.enterText(password, 'fixture-password');
      final submit = find.byKey(const ValueKey('guest-claim-submit'));
      await _reveal(tester, submit);
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(controller.claims, 1);
      expect(controller.profile?.isGuest, isTrue);
      expect(controller.profile?.userId, 'guest-fixture');
      await _reveal(tester, email);
      expect(
        tester.widget<TextFormField>(email).controller?.text,
        'fixture@example.invalid',
      );
      await tester.enterText(email, 'another@example.invalid');
      final signIn = find.byKey(const ValueKey('guest-claim-sign-in'));
      await _reveal(tester, signIn);
      await tester.tap(signIn);
      await tester.pumpAndSettle();
      expect(find.byType(AuthenticationPage), findsOneWidget);
      expect(controller.profile?.isGuest, isTrue);
      expect(controller.profile?.userId, 'guest-fixture');
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final scrollable = find.byType(Scrollable).first;
  tester.state<ScrollableState>(scrollable).position.jumpTo(0);
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(target, 240, scrollable: scrollable);
  await tester.pumpAndSettle();
  expect(target.hitTestable(), findsOneWidget);
}

void _screen(WidgetTester tester, Size size, {double scale = 1}) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}
