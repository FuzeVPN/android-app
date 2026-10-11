import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import '../support/welcome_ui_fixture.dart';

// Physical display obstructions are intentionally asymmetric. The side cutout
// must stay on the same physical side when the application changes to RTL.
const _systemInsets = EdgeInsets.fromLTRB(28, 48, 8, 24);

void main() {
  for (final size in const [
    Size(320, 640),
    Size(411, 915),
    Size(800, 1280),
    Size(1920, 1080),
  ]) {
    for (final accessible in [false, true]) {
      final dark = accessible;
      final locale = accessible ? const Locale('ar') : const Locale('fr');
      final scale = accessible ? 2.0 : 1.0;

      testWidgets(
        'welcome ${size.width}dp ${dark ? "dark RTL 200%" : "light"} respects each system inset once',
        (tester) async {
          _configure(tester, size, scale: scale);
          final controller = WelcomeUiController()..locale = locale;
          addTearDown(controller.dispose);
          await tester.pumpWidget(
            welcomeUiTestApp(
              controller,
              WelcomePage(controller: controller),
              dark: dark,
            ),
          );
          await tester.pumpAndSettle();

          final viewport = tester.getRect(
            find.byKey(const ValueKey('welcome-scroll')),
          );
          final safe = _safeRect(size);
          // A second application of status/navigation padding would shrink
          // this real scrolling viewport and reduce usable content space.
          expect(viewport.top, closeTo(safe.top, .01));
          expect(viewport.bottom, closeTo(safe.bottom, .01));
          expect(viewport.left, greaterThanOrEqualTo(safe.left));
          expect(viewport.right, lessThanOrEqualTo(safe.right));
          expect(
            Directionality.of(tester.element(find.byType(WelcomePage))),
            accessible ? TextDirection.rtl : TextDirection.ltr,
          );
          for (final name in [
            'welcome-start',
            'welcome-sign-in',
            'welcome-restore',
            'onboarding-terms',
            'onboarding-privacy',
          ]) {
            final action = find.byKey(ValueKey(name));
            await _reveal(tester, action);
            _expectContained(tester, action, safe);
          }
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  for (final scenario in const [
    (Size(915, 411), true),
    (Size(800, 400), false),
  ]) {
    final (size, dark) = scenario;
    testWidgets(
      'landscape navigation ${size.width}x${size.height}dp ${dark ? "RTL dark" : "LTR light"} remains reachable at 200% with side system bars',
      (tester) async {
        // In landscape a display cutout and Android navigation buttons can
        // consume opposite sides. There is no bottom gesture inset here.
        const insets = EdgeInsets.fromLTRB(36, 24, 24, 0);
        _configure(tester, size, scale: 2, insets: insets);
        final controller = _localController(dark: dark);
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          _testApp(controller, HomeShell(controller: controller)),
        );
        await tester.pumpAndSettle();

        final safe = _safeRect(size, insets: insets);
        final navigation = find.byWidgetPredicate(
          (widget) => widget is NavigationRail || widget is NavigationBar,
          description: 'the active landscape navigation',
        );
        expect(navigation, findsOneWidget);
        final copy = AppLocalizations.of(
          tester.element(find.byType(HomeShell)),
        );
        final connection = tester.getRect(find.byType(ConnectionPage));
        final vpnAction = find.byType(PrimaryVpnAction);
        await _reveal(tester, vpnAction);
        _expectContained(tester, vpnAction, connection.intersect(safe));
        for (final label in [
          copy.nav_connection,
          copy.nav_locations,
          copy.nav_account,
        ]) {
          final destination = find.descendant(
            of: navigation,
            matching: find.text(label),
          );
          await _reveal(tester, destination);
          _expectContained(tester, destination, safe);
          await tester.tap(destination);
          await tester.pumpAndSettle();
        }
        expect(find.byType(AccountPage), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final dark in [false, true]) {
    testWidgets(
      'login ${dark ? "dark RTL" : "light"} preserves the usable viewport above the keyboard at 200%',
      (tester) async {
        const size = Size(320, 640);
        _configure(tester, size, scale: 2);
        final controller = WelcomeUiController()
          ..locale = dark ? const Locale('ar') : const Locale('fr');
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          welcomeUiTestApp(
            controller,
            AuthenticationPage(controller: controller, loginOnly: true),
            dark: dark,
          ),
        );
        await tester.pumpAndSettle();

        final viewport = find.byType(ListView);
        final appBar = find.byType(AppBar);
        expect(viewport, findsOneWidget);
        expect(
          tester.getRect(viewport).top,
          closeTo(tester.getRect(appBar).bottom, .01),
        );
        expect(
          tester.getRect(viewport).bottom,
          closeTo(size.height - _systemInsets.bottom, .01),
        );

        const keyboard = 220.0;
        _setKeyboard(tester, keyboard);
        await tester.pumpAndSettle();
        expect(
          tester.getRect(viewport).bottom,
          closeTo(size.height - keyboard, .01),
        );
        final safe = _safeRect(size, keyboard: keyboard);
        for (final name in [
          'auth-login-email',
          'auth-login-password',
          'auth-login-submit',
        ]) {
          final action = find.byKey(ValueKey(name));
          await _reveal(tester, action);
          _expectContained(tester, action, safe);
        }
        // Hiding the IME restores the navigation inset, without keeping an
        // extra keyboard-sized gap or adding another status-bar inset.
        _setKeyboard(tester, 0);
        await tester.pumpAndSettle();
        expect(
          tester.getRect(viewport).top,
          closeTo(tester.getRect(appBar).bottom, .01),
        );
        expect(
          tester.getRect(viewport).bottom,
          closeTo(size.height - _systemInsets.bottom, .01),
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final size in const [
    Size(320, 640),
    Size(411, 915),
    Size(800, 1280),
    Size(1920, 1080),
  ]) {
    for (final dark in [false, true]) {
      testWidgets(
        'home navigation ${size.width}dp ${dark ? "dark RTL 200%" : "light"} keeps controls outside the physical cutout',
        (tester) async {
          _configure(tester, size, scale: dark ? 2 : 1);
          final controller = _localController(dark: dark);
          addTearDown(controller.dispose);
          await tester.pumpWidget(
            _testApp(controller, HomeShell(controller: controller)),
          );
          await tester.pumpAndSettle();

          final safe = _safeRect(size);
          final useRail = size.width >= 720;
          final navigation = useRail
              ? find.byType(NavigationRail)
              : find.byType(NavigationBar);
          final copy = AppLocalizations.of(
            tester.element(find.byType(HomeShell)),
          );
          final appBar = tester.getRect(find.byType(AppBar));
          final connection = tester.getRect(find.byType(ConnectionPage));
          // The AppBar already owns the status inset. The page must not add it
          // again. Likewise a mobile bottom bar already owns the gesture area.
          expect(connection.top, closeTo(appBar.bottom, .01));
          if (useRail) {
            expect(connection.bottom, closeTo(safe.bottom, .01));
          } else {
            final bar = tester.getRect(navigation);
            expect(connection.bottom, closeTo(bar.top, .01));
            expect(bar.bottom, closeTo(size.height, .01));
            expect(
              bar.height,
              closeTo((dark ? 96 : 78) + _systemInsets.bottom, .01),
            );
          }
          final vpnAction = find.byType(PrimaryVpnAction);
          await _reveal(tester, vpnAction);
          _expectContained(tester, vpnAction, connection.intersect(safe));
          for (final label in [
            copy.nav_connection,
            copy.nav_locations,
            copy.nav_account,
          ]) {
            final destination = find.descendant(
              of: navigation,
              matching: find.text(label),
            );
            _expectContained(tester, destination, safe);
            await tester.tap(destination);
            await tester.pumpAndSettle();
          }
          // Actual settings actions must remain reachable after navigation;
          // tapping navigation labels alone would miss page clipping bugs.
          final create = find.byKey(const ValueKey('guest-create-account'));
          await _reveal(tester, create);
          _expectContained(tester, create, safe);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  for (final dark in [false, true]) {
    testWidgets(
      'guest login dialog ${dark ? "dark RTL" : "light"} stays inside cutouts and keyboard at 200%',
      (tester) async {
        const size = Size(320, 640);
        _configure(tester, size, scale: 2);
        final controller = _localController(dark: dark);
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          _testApp(controller, HomeShell(controller: controller)),
        );
        await tester.pumpAndSettle();
        final copy = AppLocalizations.of(
          tester.element(find.byType(HomeShell)),
        );
        await tester.tap(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(copy.nav_account),
          ),
        );
        await tester.pumpAndSettle();
        final entry = find.byKey(
          const ValueKey('guest-existing-subscriber-sign-in'),
        );
        await _reveal(tester, entry);
        await tester.tap(entry);
        await tester.pumpAndSettle();

        final email = find.byKey(const ValueKey('auth-login-email'));
        final password = find.byKey(const ValueKey('auth-login-password'));
        const enteredEmail = 'edge-insets@example.invalid';
        const enteredPassword = 'fixture password';
        await _reveal(tester, email);
        await tester.enterText(email, enteredEmail);
        await _reveal(tester, password);
        await tester.enterText(password, enteredPassword);

        const keyboard = 180.0;
        _setKeyboard(tester, keyboard);
        await tester.pumpAndSettle();
        expect(
          tester.widget<TextFormField>(email).controller?.text,
          enteredEmail,
        );
        expect(
          tester.widget<TextFormField>(password).controller?.text,
          enteredPassword,
        );
        final dialog = find.byKey(const ValueKey('guest-login-dialog'));
        final safe = _safeRect(size, keyboard: keyboard);
        // Dialog's outer animated padding fills the route. Measure the actual
        // material surface that contains the form, rather than that wrapper.
        final surface = find
            .descendant(of: dialog, matching: find.byType(Material))
            .first;
        _expectContained(tester, surface, safe, hitTestable: false);
        _expectContained(
          tester,
          find.byKey(const ValueKey('guest-login-close')),
          safe,
        );
        for (final name in [
          'auth-login-email',
          'auth-login-password',
          'auth-login-submit',
        ]) {
          final action = find.byKey(ValueKey(name));
          await _reveal(tester, action);
          _expectContained(tester, action, safe);
        }
        _setKeyboard(tester, 0);
        await tester.pumpAndSettle();
        expect(
          tester.widget<TextFormField>(email).controller?.text,
          enteredEmail,
        );
        expect(
          tester.widget<TextFormField>(password).controller?.text,
          enteredPassword,
        );
        await tester.tap(find.byKey(const ValueKey('guest-login-close')));
        await tester.pumpAndSettle();
        expect(dialog, findsNothing);
        expect(controller.profile?.isGuest, isTrue);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'password recovery sheet ${dark ? "dark RTL" : "light"} avoids status bar and IME at 200%',
      (tester) async {
        const size = Size(320, 640);
        _configure(tester, size, scale: 2);
        final controller = WelcomeUiController()
          ..locale = dark ? const Locale('ar') : const Locale('fr');
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          welcomeUiTestApp(
            controller,
            AuthenticationPage(controller: controller, loginOnly: true),
            dark: dark,
          ),
        );
        await tester.pumpAndSettle();
        final copy = AppLocalizations.of(
          tester.element(find.byType(AuthenticationPage)),
        );
        final forgot = find.text(copy.action_forgotPassword);
        await _reveal(tester, forgot);
        await tester.tap(forgot);
        await tester.pumpAndSettle();
        _setKeyboard(tester, 220);
        await tester.pumpAndSettle();

        final sheet = find.byType(BottomSheet);
        expect(sheet, findsOneWidget);
        final scroll = find.descendant(
          of: sheet,
          matching: find.byType(SingleChildScrollView),
        );
        final viewport = tester.getRect(scroll);
        expect(viewport.top, greaterThanOrEqualTo(_systemInsets.top));
        expect(viewport.left, greaterThanOrEqualTo(_systemInsets.left));
        expect(
          viewport.right,
          lessThanOrEqualTo(size.width - _systemInsets.right),
        );
        final safe = _safeRect(size, keyboard: 220);
        for (final control in [
          find.descendant(of: sheet, matching: find.byType(TextFormField)),
          find.descendant(of: sheet, matching: find.byType(FilledButton)),
        ]) {
          await _reveal(tester, control);
          _expectContained(tester, control, safe);
        }
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'welcome without AppBar advertises ${dark ? "light" : "dark"} system icons for its theme',
      (tester) async {
        _configure(tester, const Size(411, 915));
        final controller = _localController(dark: dark)..profile = null;
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          FuzeVpnApp(controller: controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        expect(find.byType(AppBar), findsNothing);
        final region = find.ancestor(
          of: find.byType(WelcomePage),
          matching: find.byType(AnnotatedRegion<SystemUiOverlayStyle>),
        );
        expect(region, findsOneWidget);
        final style = tester
            .widget<AnnotatedRegion<SystemUiOverlayStyle>>(region)
            .value;
        expect(
          style.statusBarIconBrightness,
          dark ? Brightness.light : Brightness.dark,
        );
        expect(
          style.systemNavigationBarIconBrightness,
          dark ? Brightness.light : Brightness.dark,
        );
        expect(style.statusBarColor, Colors.transparent);
        expect(style.systemNavigationBarColor, Colors.transparent);
        expect(tester.takeException(), isNull);
      },
    );
  }
}

void _configure(
  WidgetTester tester,
  Size size, {
  double scale = 1,
  EdgeInsets insets = _systemInsets,
}) {
  // Insets exposed by the platform are physical pixels, whereas layout uses dp.
  const ratio = 2.0;
  tester.view.devicePixelRatio = ratio;
  tester.view.physicalSize = size * ratio;
  tester.view.viewPadding = FakeViewPadding(
    left: insets.left * ratio,
    top: insets.top * ratio,
    right: insets.right * ratio,
    bottom: insets.bottom * ratio,
  );
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  _setKeyboard(tester, 0);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetViewPadding);
  addTearDown(tester.view.resetPadding);
  addTearDown(tester.view.resetViewInsets);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

void _setKeyboard(WidgetTester tester, double keyboard) {
  final ratio = tester.view.devicePixelRatio;
  final viewPadding = tester.view.viewPadding;
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard * ratio);
  // FakeFlutterView does not derive padding from viewPadding/viewInsets. Mirror
  // the platform relation so an open keyboard consumes the bottom system inset.
  tester.view.padding = FakeViewPadding(
    left: viewPadding.left,
    top: viewPadding.top,
    right: viewPadding.right,
    bottom: (viewPadding.bottom - keyboard * ratio).clamp(
      0,
      viewPadding.bottom,
    ),
  );
}

Rect _safeRect(
  Size size, {
  double keyboard = 0,
  EdgeInsets insets = _systemInsets,
}) => Rect.fromLTRB(
  insets.left,
  insets.top,
  size.width - insets.right,
  size.height - (keyboard > 0 ? keyboard : insets.bottom),
);

void _expectContained(
  WidgetTester tester,
  Finder control,
  Rect safe, {
  bool hitTestable = true,
}) {
  expect(control, findsOneWidget);
  if (hitTestable) expect(control.hitTestable(), findsOneWidget);
  final rect = tester.getRect(control);
  final scrollable = find.ancestor(
    of: control,
    matching: find.byType(Scrollable),
  );
  final viewport = scrollable.evaluate().isEmpty
      ? 'none'
      : '${tester.getRect(scrollable.first)}';
  final reason =
      '$control: rect=$rect, safe=$safe, '
      'scroll viewport=$viewport';
  expect(rect.left, greaterThanOrEqualTo(safe.left - .01), reason: reason);
  expect(rect.top, greaterThanOrEqualTo(safe.top - .01), reason: reason);
  expect(rect.right, lessThanOrEqualTo(safe.right + .01), reason: reason);
  expect(rect.bottom, lessThanOrEqualTo(safe.bottom + .01), reason: reason);
}

Future<void> _reveal(WidgetTester tester, Finder control) async {
  final ancestor = find.ancestor(
    of: control,
    matching: find.byType(Scrollable),
  );
  if (ancestor.evaluate().isNotEmpty) {
    await tester.ensureVisible(control);
  } else {
    await tester.scrollUntilVisible(
      control,
      160,
      scrollable: find.byType(Scrollable).last,
    );
  }
  await tester.pumpAndSettle();
}

Widget _testApp(VpnAppController controller, Widget home) => MaterialApp(
  locale: controller.locale,
  supportedLocales: AppLanguages.supportedLocales,
  localeListResolutionCallback: AppLanguages.resolve,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: FuzeVpnTheme.light(),
  darkTheme: FuzeVpnTheme.dark(),
  themeMode: controller.themeMode,
  home: home,
);

VpnAppController _localController({required bool dark}) =>
    VpnAppController(
        api: _NoApi(),
        sessionStore: _NoSessionStore(),
        preferences: _NoPreferences(),
        tunnel: _IdleTunnel(),
      )
      ..isInitializing = false
      ..themeMode = dark ? ThemeMode.dark : ThemeMode.light
      ..locale = dark ? const Locale('ar') : const Locale('fr')
      ..profile = guestUiProfile(canUseVpn: true);

// These tests exercise layout only. An accidental network/storage/tunnel
// operation fails immediately rather than reaching Android or a real account.
class _NoApi implements VpnApiRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnsupportedError(
    'Unexpected API operation: ${invocation.memberName}',
  );
}

class _NoSessionStore implements SecureSessionStore {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnsupportedError(
    'Unexpected session operation: ${invocation.memberName}',
  );
}

class _NoPreferences implements AppPreferenceStore {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnsupportedError(
    'Unexpected preferences operation: ${invocation.memberName}',
  );
}

class _IdleTunnel implements VpnTunnelGateway {
  @override
  Stream<VpnRuntimeState> get states => const Stream.empty();

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnsupportedError(
    'Unexpected tunnel operation: ${invocation.memberName}',
  );
}
