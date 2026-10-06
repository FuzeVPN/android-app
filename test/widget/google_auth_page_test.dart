import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/google_auth.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/google_auth_page.dart';
import 'package:fuzevpn_android/features/auth/guest_claim_page.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';

import '../support/welcome_ui_fixture.dart';

const _previewExports = bool.fromEnvironment('FUZEVPN_GOOGLE_PREVIEWS');

void main() {
  setUpAll(() async {
    if (!_previewExports) {
      return;
    }
    TestWidgetsFlutterBinding.ensureInitialized();
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader(
      'Google Sans',
    )..addFont(rootBundle.load('assets/fonts/GoogleSans-Variable.ttf'))).load();
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
  testWidgets(
    'Google selection only starts after the explicit sign-in button',
    (tester) async {
      final auth = _GoogleUiFake();
      final app = WelcomeUiController(googleAuth: auth);
      addTearDown(app.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(
          app,
          AuthenticationPage(controller: app, loginOnly: true),
        ),
      );
      await tester.pumpAndSettle();
      expect(auth.begins, 0);
      final button = find.byKey(const ValueKey('auth-google'));
      await _reveal(tester, button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(auth.begins, 1);
      expect(auth.purpose, GoogleAuthPurpose.authenticate);
      expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    },
  );

  testWidgets(
    'welcome explicitly recovers a Google intent after its route was removed by cleanup',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 640);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final auth = _GoogleUiFake();
      final app = WelcomeUiController(googleAuth: auth)
        ..profile = guestUiProfile(canUseVpn: true);
      addTearDown(app.dispose);
      await _open(tester, app);
      expect(auth.pickerRequests, 1);
      auth.pending = true;
      auth.current = const GoogleAuthState(
        step: GoogleAuthStep.uncertain,
        messageKey: 'google.uncertain',
      );
      app.profile = null;
      // Session cleanup replaces the navigation tree, but not its controller.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        welcomeUiTestApp(app, WelcomePage(controller: app)),
      );
      await tester.pumpAndSettle();
      expect(auth.begins, 1);
      expect(auth.resumes, 0);
      expect(
        find.byKey(const ValueKey('welcome-google-recovery')),
        findsOneWidget,
      );
      for (final key in [
        'welcome-start',
        'welcome-sign-in',
        'welcome-restore',
      ]) {
        final button = tester.widget<ButtonStyleButton>(
          find.byKey(ValueKey(key)),
        );
        expect(button.onPressed, isNull);
      }
      final resume = find.byKey(const ValueKey('welcome-google-resume'));
      await _reveal(tester, resume);
      await tester.tap(resume);
      await tester.pumpAndSettle();
      expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
      expect(auth.begins, 2);
      expect(auth.pickerRequests, 1);
      expect(auth.purpose, GoogleAuthPurpose.authenticate);
      expect(auth.resumes, 0);
      final confirmResume = find.byKey(const ValueKey('google-resume'));
      await _reveal(tester, confirmResume);
      await tester.tap(confirmResume);
      await tester.pumpAndSettle();
      expect(auth.resumes, 1);
      expect(auth.pickerRequests, 1);
      expect(app.purchaseRequests, isEmpty);
      expect(app.restores, 0);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'failed welcome cancellation preserves explicit recovery until cancellation succeeds',
    (tester) async {
      final auth = _GoogleUiFake(step: GoogleAuthStep.uncertain)
        ..pending = true
        ..cancelSucceeds = false;
      final app = WelcomeUiController(googleAuth: auth);
      addTearDown(app.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(app, WelcomePage(controller: app)),
      );
      await tester.pumpAndSettle();
      expect(auth.begins, 0);
      final cancel = find.byKey(const ValueKey('welcome-google-cancel'));
      await _reveal(tester, cancel);
      await tester.tap(cancel);
      await tester.pumpAndSettle();
      expect(auth.cancels, 1);
      expect(auth.hasPendingIntent, isTrue);
      expect(
        find.byKey(const ValueKey('welcome-google-recovery')),
        findsOneWidget,
      );
      final resume = find.byKey(const ValueKey('welcome-google-resume'));
      await _reveal(tester, resume);
      expect(tester.widget<FilledButton>(resume).onPressed, isNotNull);
      expect(auth.state.messageKey, 'google.cancelFailed');
      auth.providerBusy = true;
      auth.notifyListeners();
      await tester.pumpAndSettle();
      expect(tester.widget<FilledButton>(resume).onPressed, isNull);
      expect(tester.widget<TextButton>(cancel).onPressed, isNull);
      auth.providerBusy = false;
      auth.cancelSucceeds = true;
      auth.notifyListeners();
      await _reveal(tester, cancel);
      await tester.tap(cancel);
      await tester.pumpAndSettle();
      expect(auth.cancels, 2);
      expect(auth.hasPendingIntent, isFalse);
      expect(
        find.byKey(const ValueKey('welcome-google-recovery')),
        findsNothing,
      );
      await _reveal(tester, find.byKey(const ValueKey('welcome-start')));
      expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('welcome-start')))
            .onPressed,
        isNotNull,
      );
      expect(app.purchaseRequests, isEmpty);
      expect(auth.begins, 0);
      expect(auth.resumes, 0);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Google guest conversion remains voluntary and keeps the guest until verified',
    (tester) async {
      final auth = _GoogleUiFake(step: GoogleAuthStep.guestClaimRequired);
      final app = WelcomeUiController(googleAuth: auth)
        ..profile = guestUiProfile(canUseVpn: true);
      addTearDown(app.dispose);
      await tester.pumpWidget(
        welcomeUiTestApp(app, GuestClaimPage(controller: app)),
      );
      await tester.pumpAndSettle();
      expect(auth.begins, 0);
      final google = find.byKey(const ValueKey('guest-claim-google'));
      await _reveal(tester, google);
      await tester.tap(google);
      await tester.pumpAndSettle();
      expect(auth.purpose, GoogleAuthPurpose.claim);
      expect(app.profile?.isGuest, isTrue);
      expect(app.profile?.canUseVpn, isTrue);
      expect(app.purchaseRequests, isEmpty);
      final skip = find.byKey(const ValueKey('google-cancel'));
      await _reveal(tester, skip);
      await tester.tap(skip);
      await tester.pumpAndSettle();
      expect(find.byType(GoogleAuthenticationPage), findsNothing);
      expect(find.byType(GuestClaimPage), findsOneWidget);
      expect(app.profile?.userId, 'guest-fixture');
    },
  );

  testWidgets(
    'registration requires a selected country and two independent unchecked consents',
    (tester) async {
      final auth = _GoogleUiFake();
      final app = WelcomeUiController(googleAuth: auth);
      addTearDown(app.dispose);
      await _open(tester, app);
      for (final key in ['google-terms-consent', 'google-privacy-consent']) {
        expect(
          tester.widget<Checkbox>(find.byKey(ValueKey(key))).value,
          isFalse,
        );
      }
      final submit = find.byKey(const ValueKey('google-profile-submit'));
      await _reveal(tester, submit);
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(auth.profileCalls, 0);
      final country = find.byKey(const ValueKey('google-country'));
      await _reveal(tester, country);
      await tester.tap(country);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('France'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('France').last);
      await tester.pumpAndSettle();
      final terms = find.byKey(const ValueKey('google-terms-consent'));
      await _reveal(tester, terms);
      await tester.tap(terms);
      await tester.pumpAndSettle();
      await _reveal(tester, submit);
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(auth.profileCalls, 0);
      final privacy = find.byKey(const ValueKey('google-privacy-consent'));
      await _reveal(tester, privacy);
      await tester.tap(privacy);
      await tester.pumpAndSettle();
      await _reveal(tester, submit);
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(auth.profileCalls, 1);
      expect(auth.country, 'FR');
      expect(auth.terms, isTrue);
      expect(auth.privacy, isTrue);
      expect(find.byKey(const ValueKey('google-terms-link')), findsOneWidget);
      expect(find.byKey(const ValueKey('google-privacy-link')), findsOneWidget);
    },
  );

  testWidgets('invalid Fuze password preserves the input and guest identity', (
    tester,
  ) async {
    final auth = _GoogleUiFake(step: GoogleAuthStep.linkRequired);
    final app = WelcomeUiController(googleAuth: auth)
      ..profile = guestUiProfile(canUseVpn: true);
    addTearDown(app.dispose);
    await _open(tester, app);
    final password = find.byKey(const ValueKey('google-fuze-password'));
    await _reveal(tester, password);
    expect(find.text('Mot de passe FuzeVPN'), findsOneWidget);
    await tester.enterText(password, 'fixture-fuze-password');
    final confirm = find.byKey(const ValueKey('google-password-confirm'));
    await _reveal(tester, confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(auth.password, 'fixture-fuze-password');
    await _reveal(tester, password);
    expect(
      tester.widget<TextFormField>(password).controller?.text,
      'fixture-fuze-password',
    );
    expect(app.profile?.isGuest, isTrue);
    expect(app.profile?.canUseVpn, isTrue);
  });

  testWidgets(
    'email proof needs an explicit confirm and preserves grouped codes on an error',
    (tester) async {
      final auth = _GoogleUiFake(
        step: GoogleAuthStep.linkRequired,
        emailRequested: true,
      );
      final app = WelcomeUiController(googleAuth: auth);
      addTearDown(app.dispose);
      await _open(tester, app);
      expect(auth.emailConfirms, 0);
      final code = find.byKey(const ValueKey('google-email-code'));
      await _reveal(tester, code);
      await tester.enterText(code, 'ABCD EFGH IJKL MNOP');
      expect(auth.emailConfirms, 0);
      final confirm = find.byKey(const ValueKey('google-email-confirm'));
      await _reveal(tester, confirm);
      await tester.tap(confirm);
      await tester.pumpAndSettle();
      expect(auth.emailConfirms, 1);
      expect(auth.code, 'ABCD EFGH IJKL MNOP');
      await _reveal(tester, code);
      expect(
        tester.widget<TextFormField>(code).controller?.text,
        'ABCD EFGH IJKL MNOP',
      );
    },
  );

  testWidgets(
    'failed cancellation keeps the Google route until a confirmed retry',
    (tester) async {
      final auth = _GoogleUiFake()..cancelSucceeds = false;
      final app = WelcomeUiController(googleAuth: auth);
      addTearDown(app.dispose);
      await _open(tester, app);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(auth.cancels, 1);
      expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
      auth.cancelSucceeds = true;
      final cancel = find.byKey(const ValueKey('google-cancel'));
      await _reveal(tester, cancel);
      await tester.tap(cancel);
      await tester.pumpAndSettle();
      expect(auth.cancels, 2);
      expect(find.byType(GoogleAuthenticationPage), findsNothing);
      expect(find.byKey(const ValueKey('google-parent')), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'a claim committed during cancellation has one navigation owner',
    (tester) async {
      final auth = _GoogleUiFake(step: GoogleAuthStep.guestClaimRequired)
        ..completeDuringCancel = true;
      final app = WelcomeUiController(googleAuth: auth)
        ..profile = guestUiProfile(canUseVpn: true);
      addTearDown(app.dispose);
      await _open(tester, app, purpose: GoogleAuthPurpose.claim);
      final cancel = find.byKey(const ValueKey('google-cancel'));
      await _reveal(tester, cancel);
      await tester.tap(cancel);
      await tester.pumpAndSettle();
      expect(auth.cancels, 1);
      expect(find.byType(GoogleAuthenticationPage), findsNothing);
      expect(find.byKey(const ValueKey('google-parent')), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  for (final language in AppLanguages.all) {
    for (final state in [
      GoogleAuthStep.registrationRequired,
      GoogleAuthStep.guestClaimRequired,
      GoogleAuthStep.linkRequired,
    ]) {
      testWidgets(
        'Google ${state.name} ${language.tag} stays reachable at 320dp/200% with keyboard',
        (tester) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.view.devicePixelRatio = 1;
          tester.view.viewInsets = const FakeViewPadding(bottom: 180);
          tester.platformDispatcher.textScaleFactorTestValue = 2;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetViewInsets);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          final auth = _GoogleUiFake(
            step: state,
            emailRequested: state == GoogleAuthStep.linkRequired,
          );
          final app = WelcomeUiController(googleAuth: auth)
            ..locale = language.locale;
          addTearDown(app.dispose);
          await _open(
            tester,
            app,
            purpose: state == GoogleAuthStep.guestClaimRequired
                ? GoogleAuthPurpose.claim
                : GoogleAuthPurpose.authenticate,
            dark: language.locale.languageCode == 'ar',
          );
          final keys = state == GoogleAuthStep.linkRequired
              ? [
                  'google-email-code',
                  'google-email-confirm',
                  'google-email-request',
                  'google-cancel',
                ]
              : [
                  'google-country',
                  'google-terms-consent',
                  'google-terms-link',
                  'google-privacy-consent',
                  'google-privacy-link',
                  'google-profile-submit',
                  'google-cancel',
                ];
          for (final key in keys) {
            await _reveal(tester, find.byKey(ValueKey(key)));
          }
          expect(auth.profileCalls, 0);
          expect(auth.emailConfirms, 0);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  if (_previewExports) {
    const previews =
        <(String, Size, double, bool, String, GoogleAuthStep, bool)>[
          (
            'register-phone',
            Size(411, 915),
            1,
            false,
            'fr',
            GoogleAuthStep.registrationRequired,
            false,
          ),
          (
            'register-phone-dark',
            Size(411, 915),
            1,
            true,
            'fr',
            GoogleAuthStep.registrationRequired,
            false,
          ),
          (
            'register-small-200',
            Size(320, 640),
            2,
            false,
            'fr',
            GoogleAuthStep.registrationRequired,
            false,
          ),
          (
            'register-tablet',
            Size(800, 1280),
            1,
            false,
            'fr',
            GoogleAuthStep.registrationRequired,
            false,
          ),
          (
            'register-large',
            Size(1920, 1080),
            1,
            false,
            'fr',
            GoogleAuthStep.registrationRequired,
            false,
          ),
          (
            'register-rtl',
            Size(411, 915),
            1,
            true,
            'ar',
            GoogleAuthStep.registrationRequired,
            false,
          ),
          (
            'link-password',
            Size(411, 915),
            1,
            false,
            'fr',
            GoogleAuthStep.linkRequired,
            false,
          ),
          (
            'link-email',
            Size(411, 915),
            1,
            false,
            'fr',
            GoogleAuthStep.linkRequired,
            true,
          ),
          (
            'uncertain',
            Size(411, 915),
            1,
            false,
            'fr',
            GoogleAuthStep.uncertain,
            false,
          ),
          (
            'unavailable',
            Size(411, 915),
            1,
            false,
            'fr',
            GoogleAuthStep.failure,
            false,
          ),
        ];
    for (final (name, size, scale, dark, locale, step, emailRequested)
        in previews) {
      testWidgets('export Google $name preview', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final auth = _GoogleUiFake(step: step, emailRequested: emailRequested);
        if (step == GoogleAuthStep.uncertain ||
            step == GoogleAuthStep.failure) {
          auth.current = GoogleAuthState(
            step: step,
            messageKey: step == GoogleAuthStep.uncertain
                ? 'google.uncertain'
                : 'google.unavailable',
          );
        }
        final app = WelcomeUiController(googleAuth: auth)
          ..locale = Locale(locale);
        addTearDown(app.dispose);
        await _open(tester, app, dark: dark);
        final images = tester.widgetList<Image>(find.byType(Image)).toList();
        final context = tester.element(find.byType(Scaffold).last);
        await tester.runAsync(() async {
          await Future.wait(
            images.map((image) => precacheImage(image.image, context)),
          );
        });
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            '../../build/reports/google-auth-2026-10-05/previews/$name.png',
          ),
        );
      }, tags: 'google-preview');
    }
  }
}

Future<void> _open(
  WidgetTester tester,
  WelcomeUiController app, {
  GoogleAuthPurpose purpose = GoogleAuthPurpose.authenticate,
  bool dark = false,
}) async {
  await tester.pumpWidget(
    welcomeUiTestApp(
      app,
      Builder(
        builder: (context) => Scaffold(
          key: const ValueKey('google-parent'),
          body: FilledButton(
            key: const ValueKey('google-open'),
            onPressed: () =>
                unawaited(openGoogleAuthentication(context, app, purpose)),
            child: const Text('Open provider fixture'),
          ),
        ),
      ),
      dark: dark,
    ),
  );
  await tester.tap(find.byKey(const ValueKey('google-open')));
  await tester.pumpAndSettle();
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final scrollable = find.byType(Scrollable).first;
  tester.state<ScrollableState>(scrollable).position.jumpTo(0);
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(target, 180, scrollable: scrollable);
  await tester.pumpAndSettle();
  expect(target.hitTestable(), findsOneWidget);
}

class _GoogleUiFake extends GoogleAuthController {
  _GoogleUiFake({
    GoogleAuthStep step = GoogleAuthStep.registrationRequired,
    bool emailRequested = false,
  }) : current = GoogleAuthState(
         step: step,
         context: _context(step),
         emailRequested: emailRequested,
       );
  GoogleAuthState current;
  int begins = 0, cancels = 0, profileCalls = 0, emailConfirms = 0;
  int pickerRequests = 0, resumes = 0;
  bool cancelSucceeds = true, completeDuringCancel = false;
  bool pending = false, providerBusy = false;
  GoogleAuthPurpose? purpose;
  String? country, password, code;
  bool? terms, privacy;
  @override
  GoogleAuthState get state => current;
  @override
  bool get isBusy => providerBusy;
  @override
  bool get hasPendingIntent => pending || isBusy;
  @override
  Future<void> begin(GoogleAuthPurpose purpose) async {
    begins++;
    this.purpose = purpose;
    if (!pending) {
      pickerRequests++;
    }
    notifyListeners();
  }

  @override
  Future<void> resume() async {
    resumes++;
    notifyListeners();
  }

  @override
  Future<void> completeProfile({
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    profileCalls++;
    country = countryCode;
    terms = termsAccepted;
    privacy = privacyAccepted;
  }

  @override
  Future<void> linkWithPassword(String value) async {
    password = value;
    current = GoogleAuthState(
      step: GoogleAuthStep.linkRequired,
      context: current.context,
      messageKey: 'google.invalidPassword',
    );
    notifyListeners();
  }

  @override
  Future<void> confirmEmailLink(String value) async {
    emailConfirms++;
    code = value;
    current = GoogleAuthState(
      step: GoogleAuthStep.linkRequired,
      context: current.context,
      emailRequested: true,
      messageKey: 'google.invalidCode',
    );
    notifyListeners();
  }

  @override
  Future<bool> cancel() async {
    cancels++;
    if (completeDuringCancel) {
      current = const GoogleAuthState(step: GoogleAuthStep.authenticated);
      notifyListeners();
      notifyListeners();
    }
    if (pending) {
      if (cancelSucceeds) {
        pending = false;
        current = const GoogleAuthState();
      } else {
        current = const GoogleAuthState(
          step: GoogleAuthStep.uncertain,
          messageKey: 'google.cancelFailed',
        );
      }
      notifyListeners();
    }
    return cancelSucceeds;
  }

  static GoogleAuthContext _context(GoogleAuthStep step) => GoogleAuthContext(
    status: step == GoogleAuthStep.linkRequired
        ? 'link_required'
        : step == GoogleAuthStep.guestClaimRequired
        ? 'guest_claim_required'
        : 'registration_required',
    purpose: step == GoogleAuthStep.guestClaimRequired
        ? 'claim'
        : 'authenticate',
    expiresAt: DateTime.utc(2099),
    email: 'fixture@example.invalid',
  );
}
