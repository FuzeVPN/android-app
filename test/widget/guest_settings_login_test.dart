import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/guest_claim_page.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

import '../support/welcome_ui_fixture.dart';

const _entryKey = ValueKey('guest-existing-subscriber-sign-in');
const _dialogKey = ValueKey('guest-login-dialog');
const _closeKey = ValueKey('guest-login-close');
const _emailKey = ValueKey('auth-login-email');
const _passwordKey = ValueKey('auth-login-password');
const _submitKey = ValueKey('auth-login-submit');

void main() {
  testWidgets('guest settings place separate login below account creation', (
    tester,
  ) async {
    final controller = _SettingsLoginController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_settingsApp(controller));
    await _revealSettings(tester, find.byKey(_entryKey));

    final create = find.byKey(const ValueKey('guest-create-account'));
    final entry = find.byKey(_entryKey);
    expect(create, findsOneWidget);
    expect(entry, findsOneWidget);
    expect(
      tester.getTopLeft(entry).dy,
      greaterThan(tester.getBottomLeft(create).dy),
    );
    expect(find.text('Déjà abonné ? Se connecter'), findsOneWidget);
    expect(find.byKey(const ValueKey('account-sign-out')), findsNothing);
    expect(controller.claims, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'a guest without claim permission can still log into a separate account',
    (tester) async {
      final controller = _SettingsLoginController()
        ..profile = const UserProfile(
          userId: 'guest-no-claim-fixture',
          identityKind: 'guest',
          profileRedacted: true,
          canManageAccount: false,
          canClaimAccount: false,
          canUseVpn: true,
        );
      final guest = controller.profile;
      addTearDown(controller.dispose);
      await _openLogin(tester, controller);
      expect(find.byKey(const ValueKey('guest-create-account')), findsNothing);
      expect(find.byKey(_dialogKey), findsOneWidget);
      await tester.tap(find.byKey(_closeKey));
      await tester.pumpAndSettle();
      expect(controller.profile, same(guest));
      expect(controller.signIns, isEmpty);
      expect(controller.claims, 0);
      expect(tester.takeException(), isNull);
    },
  );

  for (final redacted in [false, true]) {
    testWidgets(
      'registered ${redacted ? 'redacted' : 'personal'} settings do not show guest login',
      (tester) async {
        final controller = _SettingsLoginController()
          ..profile = UserProfile(
            userId: 'registered-fixture',
            identityKind: 'registered',
            profileRedacted: redacted,
            canManageAccount: !redacted,
            canClaimAccount: false,
            email: redacted ? '' : 'member@example.invalid',
          );
        addTearDown(controller.dispose);
        await tester.pumpWidget(_settingsApp(controller));
        await tester.pumpAndSettle();
        expect(find.byKey(_entryKey), findsNothing);
        expect(
          find.byKey(const ValueKey('guest-create-account')),
          findsNothing,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'guest login opens a dialog with existing authentication methods',
    (tester) async {
      final controller = _SettingsLoginController();
      addTearDown(controller.dispose);
      await _openLogin(tester, controller);

      final dialog = find.byKey(_dialogKey);
      expect(dialog, findsOneWidget);
      expect(find.byType(AuthenticationDialog), findsOneWidget);
      expect(find.byType(AuthenticationPage), findsNothing);
      expect(find.byType(GuestClaimPage), findsNothing);
      expect(
        find.descendant(of: dialog, matching: find.byType(TabBar)),
        findsNothing,
      );
      expect(
        find.descendant(of: dialog, matching: find.byKey(_emailKey)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.byKey(_passwordKey)),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: dialog,
          matching: find.byKey(const ValueKey('auth-google')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: dialog,
          matching: find.text('Mot de passe oublié ?'),
        ),
        findsOneWidget,
      );
      expect(controller.signIns, isEmpty);
      expect(controller.claims, 0);
      expect(tester.takeException(), isNull);
    },
  );

  for (final dismissal in ['close button', 'Android back']) {
    testWidgets('idle $dismissal preserves the guest identity', (tester) async {
      final controller = _SettingsLoginController();
      final guest = controller.profile;
      addTearDown(controller.dispose);
      await _openLogin(tester, controller);

      // The barrier is deliberately not a silent cancellation surface.
      await tester.tapAt(const Offset(4, 4));
      await tester.pumpAndSettle();
      expect(find.byKey(_dialogKey), findsOneWidget);
      if (dismissal == 'close button') {
        await tester.tap(find.byKey(_closeKey));
      } else {
        await tester.binding.handlePopRoute();
      }
      await tester.pumpAndSettle();

      expect(find.byKey(_dialogKey), findsNothing);
      expect(controller.profile, same(guest));
      expect(controller.signIns, isEmpty);
      expect(controller.claims, 0);
      expect(controller.signOuts, 0);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('wrong credentials keep the dialog and guest session available', (
    tester,
  ) async {
    final controller = _SettingsLoginController();
    final guest = controller.profile;
    addTearDown(controller.dispose);
    await _openLogin(tester, controller);
    await _fillLogin(tester);
    await _revealDialog(tester, find.byKey(_submitKey));
    await tester.tap(find.byKey(_submitKey));
    await tester.pumpAndSettle();

    expect(controller.signIns, [
      ('member@example.invalid', 'fixture password'),
    ]);
    expect(controller.claims, 0);
    expect(controller.profile, same(guest));
    expect(find.byKey(_dialogKey), findsOneWidget);
    expect(controller.notice?.messageKey, 'notice.invalidCredentials.message');
    expect(
      tester.widget<IconButton>(find.byKey(_closeKey)).onPressed,
      isNotNull,
    );
    await tester.tap(find.byKey(_closeKey));
    await tester.pumpAndSettle();
    expect(find.byKey(_dialogKey), findsNothing);
    expect(controller.profile, same(guest));
    expect(tester.takeException(), isNull);
  });

  testWidgets('in-flight login blocks dismissal and unlocks after a failure', (
    tester,
  ) async {
    final controller = _SettingsLoginController()
      ..loginResult = Completer<bool>();
    final guest = controller.profile;
    addTearDown(controller.dispose);
    await _openLogin(tester, controller);
    await _fillLogin(tester);
    await _revealDialog(tester, find.byKey(_submitKey));
    await tester.tap(find.byKey(_submitKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(controller.isAuthenticating, isTrue);
    expect(tester.widget<IconButton>(find.byKey(_closeKey)).onPressed, isNull);
    expect(
      tester.widget<FilledButton>(find.byKey(_submitKey)).onPressed,
      isNull,
    );
    expect(
      tester.widget<TextFormField>(find.byKey(_emailKey)).enabled,
      isFalse,
    );
    await tester.binding.handlePopRoute();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tapAt(const Offset(4, 4));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byKey(_dialogKey), findsOneWidget);
    expect(controller.profile, same(guest));
    expect(controller.signIns, hasLength(1));

    controller.loginResult!.complete(false);
    await tester.pumpAndSettle();
    expect(controller.isAuthenticating, isFalse);
    expect(
      tester.widget<IconButton>(find.byKey(_closeKey)).onPressed,
      isNotNull,
    );
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byKey(_dialogKey), findsNothing);
    expect(controller.profile, same(guest));
    expect(controller.claims, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'successful separate login closes the modal without guest claim',
    (tester) async {
      final controller = _SettingsLoginController()
        ..loginResult = Completer<bool>();
      addTearDown(controller.dispose);
      await _openLogin(tester, controller);
      await _fillLogin(tester);
      await _revealDialog(tester, find.byKey(_submitKey));
      await tester.tap(find.byKey(_submitKey));
      await tester.pump();

      controller.loginResult!.complete(true);
      await tester.pumpAndSettle();
      expect(find.byKey(_dialogKey), findsNothing);
      expect(find.byKey(_entryKey), findsNothing);
      expect(controller.profile?.userId, 'existing-member-fixture');
      expect(controller.profile?.isGuest, isFalse);
      expect(controller.signIns, [
        ('member@example.invalid', 'fixture password'),
      ]);
      expect(controller.claims, 0);
      expect(controller.restores, 0);
      expect(controller.purchaseRequests, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  for (final locale in [const Locale('fr'), const Locale('ar')]) {
    testWidgets(
      'guest login ${locale.languageCode} remains usable at 320dp and 200 percent with keyboard',
      (tester) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetViewInsets);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final controller = _SettingsLoginController()..locale = locale;
        addTearDown(controller.dispose);
        await _openLogin(tester, controller);
        tester.view.viewInsets = const FakeViewPadding(bottom: 180);
        await tester.pumpAndSettle();

        expect(
          Directionality.of(tester.element(find.byKey(_dialogKey))),
          locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        );
        for (final key in [_emailKey, _passwordKey, _submitKey]) {
          await _revealDialog(tester, find.byKey(key));
          expect(find.byKey(key).hitTestable(), findsOneWidget);
          expect(tester.takeException(), isNull);
        }
        await tester.tap(find.byKey(_submitKey));
        await tester.pumpAndSettle();
        // Required-field validation must still work in the constrained viewport.
        expect(controller.signIns, isEmpty);
        expect(find.byKey(_dialogKey), findsOneWidget);
        expect(tester.takeException(), isNull);
        tester.view.resetViewInsets();
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_closeKey));
        await tester.pumpAndSettle();
        expect(controller.profile?.isGuest, isTrue);
      },
    );
  }
}

Widget _settingsApp(_SettingsLoginController controller) => AnimatedBuilder(
  animation: controller,
  builder: (_, _) => MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: controller.locale,
    supportedLocales: AppLanguages.supportedLocales,
    localeListResolutionCallback: AppLanguages.resolve,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: FuzeVpnTheme.light(),
    home: Scaffold(body: AccountPage(controller: controller)),
  ),
);

Future<void> _openLogin(
  WidgetTester tester,
  _SettingsLoginController controller,
) async {
  await tester.pumpWidget(_settingsApp(controller));
  await _revealSettings(tester, find.byKey(_entryKey));
  await tester.tap(find.byKey(_entryKey));
  await tester.pumpAndSettle();
  expect(find.byKey(_dialogKey), findsOneWidget);
}

Future<void> _revealSettings(WidgetTester tester, Finder target) async {
  await tester.scrollUntilVisible(
    target,
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

Future<void> _revealDialog(WidgetTester tester, Finder target) async {
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
}

Future<void> _fillLogin(WidgetTester tester) async {
  await _revealDialog(tester, find.byKey(_emailKey));
  await tester.enterText(find.byKey(_emailKey), ' member@example.invalid ');
  await _revealDialog(tester, find.byKey(_passwordKey));
  await tester.enterText(find.byKey(_passwordKey), 'fixture password');
}

/// Records the public login action; authorization and session cleanup are tested
/// separately against the real controller and its repositories.
class _SettingsLoginController extends WelcomeUiController {
  _SettingsLoginController() {
    profile = guestUiProfile(canUseVpn: true);
  }

  final signIns = <(String, String)>[];
  Completer<bool>? loginResult;
  bool _authenticating = false;
  int signOuts = 0;

  @override
  bool get isAuthenticating => _authenticating;
  @override
  bool get isIdentityBusy => false;
  @override
  bool get isConnecting => false;
  @override
  bool get isLoadingDevices => false;
  @override
  bool get isRevoking => false;
  @override
  DeviceList get deviceList => const DeviceList(limit: 2, devices: []);
  @override
  ThemeMode get themeMode => ThemeMode.light;
  @override
  SystemVpnProtection get systemProtection => const SystemVpnProtection();
  @override
  bool get diagnosticsPreferenceFailed => false;

  @override
  Future<bool> signIn({required String email, required String password}) async {
    signIns.add((email, password));
    _authenticating = true;
    notifyListeners();
    final success = loginResult == null ? false : await loginResult!.future;
    if (success) {
      profile = const UserProfile(
        userId: 'existing-member-fixture',
        email: 'member@example.invalid',
        identityKind: 'registered',
        profileRedacted: false,
        canManageAccount: true,
        canClaimAccount: false,
        canUseVpn: true,
      );
      notice = null;
    } else {
      notice = const AppNotice(
        titleKey: 'notice.connectionFailed.title',
        messageKey: 'notice.invalidCredentials.message',
      );
    }
    _authenticating = false;
    notifyListeners();
    return success;
  }

  @override
  Future<void> signOut() async {
    signOuts++;
    profile = null;
    notifyListeners();
  }
}
