import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/guest_claim_page.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/app_localization_delegates.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

// Regressions reproduced by audit A15, with bundled fonts and no real services.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
  });
  testWidgets('email validation remains complete at 320dp and 200%', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = _UiController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_app(controller, const TextScaler.linear(2)));
    final submit = find.byKey(const ValueKey('auth-login-submit'));
    await tester.scrollUntilVisible(
      submit,
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pumpAndSettle();
    final copy = AppLocalizations.of(
      tester.element(find.byType(AuthenticationPage)),
    );
    final error = find.text(copy.validation_email);
    expect(error, findsOneWidget);
    final paragraph = tester.renderObject<RenderParagraph>(error);
    expect(paragraph.didExceedMaxLines, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('phone and country correction instructions wrap at 200%', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = _UiController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _app(
        controller,
        const TextScaler.linear(2),
        home: AuthenticationPage(controller: controller),
      ),
    );
    Future<void> reveal(Finder finder) async {
      if (finder.evaluate().isEmpty) {
        await tester.scrollUntilVisible(
          finder,
          200,
          scrollable: find.byType(Scrollable).first,
        );
      } else {
        await tester.ensureVisible(finder);
      }
      await tester.pumpAndSettle();
    }

    Future<void> enter(int index, String text) async {
      final field = find.byType(TextFormField).at(index);
      await reveal(field);
      await tester.enterText(field, text);
    }

    Future<void> next() async {
      final button = find.text('Continuer');
      await reveal(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
    }

    await reveal(find.text('Inscription'));
    await tester.tap(find.text('Inscription'));
    await tester.pumpAndSettle();
    await enter(0, 'audit@example.invalid');
    await enter(1, 'audit-password');
    await next();
    await enter(0, 'Audit');
    await enter(1, 'Fixture');
    await enter(2, '123');
    await next();
    final copy = AppLocalizations.of(
      tester.element(find.byType(AuthenticationPage)),
    );
    final phone = tester.renderObject<RenderParagraph>(
      find.text(copy.validation_phone),
    );
    expect(phone.didExceedMaxLines, isFalse);
    await enter(2, '+33123456789');
    await next();
    await enter(0, 'audit fixture');
    await enter(2, '00000');
    await enter(3, 'audit');
    await enter(4, 'France');
    final submit = find.widgetWithText(
      FilledButton,
      copy.action_createMyAccount,
    );
    await reveal(submit);
    await tester.tap(submit);
    await tester.pumpAndSettle();
    final country = tester.renderObject<RenderParagraph>(
      find.text(copy.validation_country),
    );
    expect(country.didExceedMaxLines, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Back is blocked until email login ends and can leave after failure',
    (tester) async {
      final controller = _UiController();
      addTearDown(controller.dispose);
      final navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        _app(
          controller,
          TextScaler.noScaling,
          navigator: navigator,
          home: const Scaffold(body: Text('audit root')),
        ),
      );
      unawaited(
        navigator.currentState!.push<void>(
          MaterialPageRoute<void>(
            builder: (_) =>
                AuthenticationPage(controller: controller, loginOnly: true),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('auth-login-email')),
        'audit@example.invalid',
      );
      await tester.enterText(
        find.byKey(const ValueKey('auth-login-password')),
        'audit-only',
      );
      final submit = find.byKey(const ValueKey('auth-login-submit'));
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pump();
      expect(controller.isAuthenticating, isTrue);
      final back = find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      );
      expect(tester.widget<IconButton>(back).onPressed, isNull);
      final route = ModalRoute.of(
        tester.element(find.byType(AuthenticationPage)),
      )!;
      expect(route.popDisposition, RoutePopDisposition.doNotPop);
      expect(await navigator.currentState!.maybePop(), isTrue);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(route.isActive, isTrue);
      expect(controller.isAuthenticating, isTrue);
      controller.login.complete(false);
      await tester.pumpAndSettle();
      expect(find.byType(AuthenticationPage), findsOneWidget);
      expect(controller.isSignedIn, isFalse);
      expect(route.popDisposition, RoutePopDisposition.pop);
      expect(await navigator.currentState!.maybePop(), isTrue);
      await tester.pumpAndSettle();
      expect(find.byType(AuthenticationPage), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  for (final initialWidth in [600.0, 1000.0]) {
    testWidgets(
      'login keeps controllers and values across 840dp from $initialWidth',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(initialWidth, 1000);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final controller = _UiController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(_app(controller, TextScaler.noScaling));
        final email = find.byKey(const ValueKey('auth-login-email'));
        final password = find.byKey(const ValueKey('auth-login-password'));
        await tester.ensureVisible(email);
        await tester.enterText(email, 'audit@example.invalid');
        await tester.ensureVisible(password);
        await tester.enterText(password, 'audit-password');
        final emailController = tester.widget<TextFormField>(email).controller;
        final passwordController = tester
            .widget<TextFormField>(password)
            .controller;
        tester.view.physicalSize = Size(initialWidth == 600 ? 1000 : 600, 600);
        await tester.pumpAndSettle();
        expect(
          tester.widget<TextFormField>(email).controller,
          same(emailController),
        );
        expect(
          tester.widget<TextFormField>(password).controller,
          same(passwordController),
        );
        expect(emailController!.text, 'audit@example.invalid');
        expect(passwordController!.text, 'audit-password');
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'registration keeps all steps and consents across resize from $initialWidth',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(initialWidth, 1000);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final controller = _UiController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          _app(
            controller,
            TextScaler.noScaling,
            home: AuthenticationPage(controller: controller),
          ),
        );
        final copy = AppLocalizations.of(
          tester.element(find.byType(AuthenticationPage)),
        );
        Future<void> tapText(String text) async {
          final target = find.text(text);
          await _reveal(tester, target);
          await tester.tap(target);
          await tester.pumpAndSettle();
        }

        Future<void> enter(int index, String text) async {
          final field = find.byType(TextFormField).at(index);
          await _reveal(tester, field);
          await tester.enterText(field, text);
        }

        Future<void> resize(double width) async {
          tester.view.physicalSize = Size(width, 600);
          await tester.pumpAndSettle();
          expect(
            tester.getSize(find.byType(ListView)).width,
            closeTo(width >= 840 ? width / 2 : width, .01),
          );
          expect(tester.takeException(), isNull);
        }

        void expectFields(List<String> expected) {
          expect(find.byType(TextFormField), findsNWidgets(expected.length));
          for (var index = 0; index < expected.length; index++) {
            expect(
              tester
                  .widget<TextFormField>(find.byType(TextFormField).at(index))
                  .controller!
                  .text,
              expected[index],
            );
          }
        }

        await tapText(copy.auth_tab_register);
        await enter(0, 'audit@example.invalid');
        await enter(1, 'audit-password');
        final accountControllers = find
            .byType(TextFormField)
            .evaluate()
            .map((element) => (element.widget as TextFormField).controller)
            .toList();
        final oppositeWidth = initialWidth == 600 ? 1000.0 : 600.0;
        await resize(oppositeWidth);
        expectFields(['audit@example.invalid', 'audit-password']);
        await tapText(copy.action_next);
        await enter(0, 'Audit');
        await enter(1, 'Fixture');
        await enter(2, '+33123456789');
        await resize(initialWidth);
        expectFields(['Audit', 'Fixture', '+33123456789']);
        await tapText(copy.action_next);
        final address = [
          'audit street',
          'audit suite',
          '00000',
          'audit city',
          'FR',
        ];
        for (var index = 0; index < address.length; index++) {
          await enter(index, address[index]);
        }
        for (final id in ['terms', 'privacy']) {
          final consent = find.byKey(ValueKey('registration-$id-consent'));
          await _reveal(tester, consent);
          await tester.tap(consent);
          await tester.pump();
        }
        await resize(oppositeWidth);
        expectFields(address);
        for (final id in ['terms', 'privacy']) {
          expect(
            tester
                .widget<Checkbox>(
                  find.byKey(ValueKey('registration-$id-consent')),
                )
                .value,
            isTrue,
          );
        }
        final submit = find.widgetWithText(
          FilledButton,
          copy.action_createMyAccount,
        );
        await _reveal(tester, submit);
        await tester.tap(submit);
        await tester.pump();
        expect(controller.isAuthenticating, isTrue);
        await tester.binding.handlePopRoute();
        await tester.pump();
        expectFields(address);
        controller.registration.complete(false);
        await tester.pumpAndSettle();
        await tapText(copy.action_previous);
        expectFields(['Audit', 'Fixture', '+33123456789']);
        await tapText(copy.action_previous);
        expectFields(['audit@example.invalid', 'audit-password']);
        for (var index = 0; index < accountControllers.length; index++) {
          expect(
            tester
                .widget<TextFormField>(find.byType(TextFormField).at(index))
                .controller,
            same(accountControllers[index]),
          );
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('login waits for final admission before closing its route', (
    tester,
  ) async {
    final controller = _UiController();
    addTearDown(controller.dispose);
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      _app(
        controller,
        TextScaler.noScaling,
        navigator: navigator,
        home: const Scaffold(body: Text('audit root')),
      ),
    );
    unawaited(
      navigator.currentState!.push<void>(
        MaterialPageRoute<void>(
          builder: (_) =>
              AuthenticationPage(controller: controller, loginOnly: true),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('auth-login-email')),
      'audit@example.invalid',
    );
    await tester.enterText(
      find.byKey(const ValueKey('auth-login-password')),
      'audit-password',
    );
    final submit = find.byKey(const ValueKey('auth-login-submit'));
    await _reveal(tester, submit);
    await tester.tap(submit);
    await tester.pump();
    controller.publishProfileWhileBusy();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(AuthenticationPage), findsOneWidget);
    expect(controller.isAuthenticating, isTrue);
    controller.login.complete(true);
    await tester.pumpAndSettle();
    expect(find.byType(AuthenticationPage), findsNothing);
    expect(controller.isSignedIn, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('password recovery error wraps at 320dp and 200%', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = _UiController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_app(controller, const TextScaler.linear(2)));
    final copy = AppLocalizations.of(
      tester.element(find.byType(AuthenticationPage)),
    );
    final forgot = find.text(copy.action_forgotPassword);
    await _reveal(tester, forgot);
    await tester.tap(forgot);
    await tester.pumpAndSettle();
    final send = find.text(copy.passwordReset_send);
    await _reveal(tester, send);
    await tester.tap(send);
    await tester.pumpAndSettle();
    expect(
      tester
          .renderObject<RenderParagraph>(find.text(copy.validation_email))
          .didExceedMaxLines,
      isFalse,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('guest claim email and password errors wrap at 200%', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = _UiController()
      .._profile = const UserProfile(
        userId: 'audit-guest',
        identityKind: 'guest',
        canClaimAccount: true,
      );
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _app(
        controller,
        const TextScaler.linear(2),
        home: GuestClaimPage(controller: controller),
      ),
    );
    final submit = find.byKey(const ValueKey('guest-claim-submit'));
    await _reveal(tester, submit);
    await tester.tap(submit);
    await tester.pumpAndSettle();
    final copy = AppLocalizations.of(
      tester.element(find.byType(GuestClaimPage)),
    );
    for (final message in [copy.validation_email, copy.validation_password]) {
      expect(
        tester
            .renderObject<RenderParagraph>(find.text(message))
            .didExceedMaxLines,
        isFalse,
      );
    }
    expect(tester.takeException(), isNull);
  });
}

Future<void> _reveal(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).last,
    );
  } else {
    await tester.ensureVisible(finder);
  }
  await tester.pumpAndSettle();
}

Widget _app(
  _UiController controller,
  TextScaler scaler, {
  GlobalKey<NavigatorState>? navigator,
  Widget? home,
}) => MaterialApp(
  navigatorKey: navigator,
  locale: const Locale('fr'),
  supportedLocales: AppLanguages.supportedLocales,
  localizationsDelegates: AppLocalizationDelegates.all,
  theme: FuzeVpnTheme.light(),
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: scaler),
    child: child!,
  ),
  home: home ?? AuthenticationPage(controller: controller, loginOnly: true),
);

class _UiController extends ChangeNotifier implements VpnAppController {
  final login = Completer<bool>();
  final registration = Completer<bool>();
  @override
  final googleAuth = GoogleAuthController();
  bool _busy = false;
  bool _signedIn = false;
  UserProfile? _profile;
  @override
  bool get isAuthenticating => _busy;
  @override
  bool get isSignedIn => _signedIn;
  @override
  UserProfile? get profile => _profile;
  @override
  bool get isGuestActionBusy => false;
  @override
  String? get guestMessageKey => null;
  @override
  Locale? get locale => const Locale('fr');
  @override
  AppNotice? get notice => null;
  @override
  void clearNotice() {}
  void publishProfileWhileBusy() {
    _profile = const UserProfile(
      userId: 'audit-member',
      identityKind: 'registered',
      canManageAccount: true,
    );
    _signedIn = true;
    notifyListeners();
  }

  @override
  Future<bool> signIn({required String email, required String password}) async {
    _busy = true;
    notifyListeners();
    final result = await login.future;
    _busy = false;
    _signedIn = result;
    notifyListeners();
    return result;
  }

  @override
  Future<bool> register(RegisterAccountRequest request) async {
    _busy = true;
    notifyListeners();
    final result = await registration.future;
    _busy = false;
    notifyListeners();
    return result;
  }

  @override
  void dispose() {
    googleAuth.dispose();
    super.dispose();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
