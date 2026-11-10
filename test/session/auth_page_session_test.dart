// Lot S, corrections 2026-10-29: the authentication UI never hides a pending
// restoration (A01-auth-04) and never silently refuses a login, a reset or a
// Google start while background guest work owns the session (A01-auth-03,
// H-RA-A06-01-02). Ported from audit-complet-20261028/repros/A01-auth.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/app_localization_delegates.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';
import 'package:fuzevpn_android/widgets/google_sign_in_button.dart';
import 'package:fuzevpn_android/widgets/notice_card.dart';

import 'support/session_harness.dart';

void _tallView(WidgetTester tester) {
  tester.view.physicalSize = const Size(420, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _enterLogin(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const ValueKey('auth-login-email')),
    'b@example.test',
  );
  await tester.enterText(
    find.byKey(const ValueKey('auth-login-password')),
    'fixture password',
  );
}

ButtonStyleButton _button(WidgetTester tester, String key) =>
    tester.widget<ButtonStyleButton>(find.byKey(ValueKey(key)));

void main() {
  testWidgets('A01-auth-04 an accepted login with a failed restoration '
      'reveals the restoration page', (tester) async {
    _tallView(tester);
    final h = SessionHarness();
    await h.controller.initialize();
    h.api.meScript['token-b'] = <Object>[const ApiNetworkException()];
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('welcome-sign-in')));
    await tester.pumpAndSettle();
    expect(find.byType(AuthenticationPage), findsOneWidget);

    await _enterLogin(tester);
    await tester.tap(find.byKey(const ValueKey('auth-login-submit')));
    await tester.pumpAndSettle();
    expect(h.api.loginCalls, 1);
    expect(h.controller.hasPendingAccountRestoration, isTrue);
    expect(find.byType(AuthenticationPage), findsNothing);
    final retry = find.byKey(const ValueKey('retry-account-restoration'));
    expect(retry.hitTestable(), findsOneWidget);

    await tester.tap(retry);
    await tester.pumpAndSettle();
    expect(h.controller.profile?.userId, 'registered-b');

    await tester.pumpWidget(const SizedBox());
    await h.close();
  });

  testWidgets('A01-auth-03 background guest work disables and explains '
      'the authentication actions', (tester) async {
    _tallView(tester);
    final h = SessionHarness();
    await h.controller.initialize();
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        supportedLocales: AppLanguages.supportedLocales,
        localeListResolutionCallback: AppLanguages.resolve,
        localizationsDelegates: AppLocalizationDelegates.all,
        theme: FuzeVpnTheme.light(),
        home: AuthenticationPage(controller: h.controller, loginOnly: true),
      ),
    );
    h.api.loginFailure = const ApiException(
      statusCode: 401,
      errorCode: 'invalid_credentials',
    );
    await _enterLogin(tester);
    await tester.tap(find.byKey(const ValueKey('auth-login-submit')));
    await tester.pumpAndSettle();
    final AppNotice? loginNotice = h.controller.notice;
    expect(loginNotice?.arguments['code'], 'invalid_credentials');

    // The reset sheet is open when a guest resume gets a 503 Retry-After.
    await tester.tap(find.text('Mot de passe oublié ?'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(TextFormField),
      ),
      'b@example.test',
    );
    h.store.credential = guestCredential;
    h.store.autoResume = true;
    h.api.createFailures.add(
      const ApiException(
        statusCode: 503,
        errorCode: 'service_unavailable',
        retryAfterSeconds: 60,
      ),
    );
    await h.controller.onAppResumed();
    await tester.pump();
    expect(h.controller.isGuestActionBusy, isTrue);

    // Explicit pumps: the guest Retry-After timer must not elapse here.
    await tester.tap(find.text('Envoyer le lien'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(h.api.resetCalls, 0);
    final sheetNotice = tester.widget<NoticeCard>(
      find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(NoticeCard),
      ),
    );
    expect(identical(sheetNotice.notice, loginNotice), isFalse);
    expect(sheetNotice.notice?.messageKey, 'guest.serviceUnavailable');

    Navigator.of(tester.element(find.byType(BottomSheet))).pop();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(h.controller.isGuestActionBusy, isTrue);
    expect(_button(tester, 'auth-login-submit').onPressed, isNull);
    expect(
      find.byKey(const ValueKey('auth-guest-busy-message')),
      findsOneWidget,
    );
    // H-RA-A06-01-02: no Google start (and no Back race) during guest work.
    expect(
      tester
          .widget<GoogleSignInButton>(
            find.byKey(const ValueKey('auth-google')),
          )
          .onPressed,
      isNull,
    );
    // The page itself is never trapped by background guest work.
    final pageScope = find.descendant(
      of: find.byType(AuthenticationPage),
      matching: find.byWidgetPredicate((widget) => widget is PopScope),
    );
    expect(tester.widget<PopScope<dynamic>>(pageScope.first).canPop, isTrue);

    await tester.pumpWidget(const SizedBox());
    await h.close();
  });

  testWidgets('P9 background guest work without a message still explains '
      'the disabled actions', (tester) async {
    _tallView(tester);
    final h = SessionHarness();
    await h.controller.initialize();
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        supportedLocales: AppLanguages.supportedLocales,
        localeListResolutionCallback: AppLanguages.resolve,
        localizationsDelegates: AppLocalizationDelegates.all,
        theme: FuzeVpnTheme.light(),
        home: AuthenticationPage(controller: h.controller, loginOnly: true),
      ),
    );
    final created = Completer<void>();
    h.store.credential = guestCredential;
    h.store.autoResume = true;
    h.api.onCreate = () => created.future;
    unawaited(h.controller.onAppResumed());
    await tester.pump();
    expect(h.controller.isGuestActionBusy, isTrue);
    expect(h.controller.guestMessageKey, isNull);
    expect(_button(tester, 'auth-login-submit').onPressed, isNull);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('auth-guest-busy-message')),
        matching: find.text('Réessayez dans quelques instants.'),
      ),
      findsOneWidget,
    );
    created.complete();
    await tester.pump();
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await h.close();
  });

  // Réaudit S1 : la restauration en attente peut aussi venir d'une admission
  // invitée automatique, au retour au premier plan, sans authentification.
  for (final (label, arm) in <(String, void Function(SessionHarness))>[
    (
      'its second /me fails',
      (h) => h.api.meScript['token-a2'] = <Object>[
        guestA,
        const ApiNetworkException(),
      ],
    ),
    (
      'a transient device read fails',
      (h) => h.store.deviceReadFailure = const NativeVpnException(
        'secure_storage_read_failed',
      ),
    ),
  ]) {
    testWidgets('A01-auth-04 an automatic guest admission whose restoration '
        'fails reveals the restoration page ($label)', (tester) async {
      _tallView(tester);
      final h = SessionHarness();
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.controller.token, isNull);
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('welcome-sign-in')));
      await tester.pumpAndSettle();
      expect(find.byType(AuthenticationPage), findsOneWidget);

      arm(h);
      // The binding dispatches a real lifecycle resume to FuzeVpnApp.
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(h.controller.hasPendingAccountRestoration, isTrue, reason: observe(h));
      expect(find.byType(AuthenticationPage), findsNothing);
      final retry = find.byKey(const ValueKey('retry-account-restoration'));
      expect(retry.hitTestable(), findsOneWidget);

      await tester.tap(retry);
      await tester.pumpAndSettle();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));

      await tester.pumpWidget(const SizedBox());
      await h.close();
    });
  }

  // Réaudit S1 (B3) : le dialogue de connexion séparée d'un invité explique
  // ses actions désactivées, et n'accepte pas une connexion refusée d'avance.
  Future<SessionHarness> guestDialog(WidgetTester tester) async {
    _tallView(tester);
    final h = SessionHarness.guest(
      session('guest-token'),
      tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
    );
    await h.controller.initialize();
    expect(h.controller.profile?.isGuest, isTrue, reason: observe(h));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        supportedLocales: AppLanguages.supportedLocales,
        localeListResolutionCallback: AppLanguages.resolve,
        localizationsDelegates: AppLocalizationDelegates.all,
        theme: FuzeVpnTheme.light(),
        home: Scaffold(body: AuthenticationDialog(controller: h.controller)),
      ),
    );
    return h;
  }

  Finder dialogMessage() => find.descendant(
    of: find.byKey(const ValueKey('guest-login-busy-message')),
    matching: find.text('Réessayez dans quelques instants.'),
  );

  testWidgets('A01-auth-03 the guest login dialog explains background '
      'guest work', (tester) async {
    final h = await guestDialog(tester);
    expect(_button(tester, 'auth-login-submit').onPressed, isNotNull);
    expect(dialogMessage(), findsNothing);
    // A background renewal runs without a message yet.
    final created = Completer<void>();
    h.api.onCreate = () => created.future;
    h.api.onDevices = (token) async {
      if (token == 'guest-token') throw unauthorized;
      return const DeviceList(limit: 2, devices: <VpnDevice>[]);
    };
    unawaited(h.controller.refreshDevices());
    await tester.pump();
    expect(h.controller.isGuestActionBusy, isTrue);
    expect(h.controller.guestMessageKey, isNull);
    expect(_button(tester, 'auth-login-submit').onPressed, isNull);
    expect(dialogMessage(), findsOneWidget);
    created.complete();
    await tester.pump();
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await h.close();
  });

  testWidgets('A01-auth-03 the guest login dialog is disabled, with a '
      'message, while a connection runs', (tester) async {
    final h = await guestDialog(tester);
    final registering = Completer<DeviceConfiguration>();
    h.api.onRegister = (_, _) => registering.future;
    unawaited(h.controller.connect());
    await tester.pump();
    expect(h.controller.isConnecting, isTrue);
    expect(h.controller.isGuestActionBusy, isFalse);
    expect(_button(tester, 'auth-login-submit').onPressed, isNull);
    expect(dialogMessage(), findsOneWidget);
    registering.complete(deviceConfiguration);
    await tester.pump();
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await h.close();
  });
}
