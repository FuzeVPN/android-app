import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  setUpAll(() async {
    if (!const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')) return;
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

  for (final (size, scale, image) in <(Size, double, String)>[
    (const Size(412, 915), 1, 'account_restoration.png'),
    (const Size(320, 640), 2, 'account_restoration_actions_200.png'),
  ]) {
    _restorationTest(
      'golden offline restoration preserves local VPN actions ($scale)',
      (tester, h) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await h.controller.initialize();
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        await _settleRestorationImages(tester);
        expect(h.controller.isSignedIn, isFalse);
        expect(h.controller.isConnected, isTrue);
        expect(h.controller.hasPendingAccountRestoration, isTrue);
        final status = find.byKey(const ValueKey('restoration-vpn-status'));
        expect(
          tester.widget<Text>(status).data,
          AppLocalizations.of(tester.element(status)).status_connected,
        );
        if (scale > 1) {
          await Scrollable.ensureVisible(tester.element(status), alignment: .1);
          await tester.pumpAndSettle();
        }
        expect(
          tester
              .widget<FilledButton>(
                find.byKey(const ValueKey('retry-account-restoration')),
              )
              .onPressed,
          isNotNull,
        );
        expect(
          tester
              .widget<OutlinedButton>(
                find.byKey(const ValueKey('restoration-disconnect-vpn')),
              )
              .onPressed,
          isNotNull,
        );
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile(_goldenPath(image)),
        );
        await _tapVisible(
          tester,
          find.byKey(const ValueKey('restoration-disconnect-vpn')),
        );
        await tester.pumpAndSettle();
        expect(h.tunnel.userStops, 1);
        expect(h.controller.isConnected, isFalse);
        expect(h.controller.hasPendingAccountRestoration, isTrue);
        expect(h.store.session, isNotNull);
        expect(tester.takeException(), isNull);
      },
      tags: 'golden',
    );
  }

  _restorationTest('language remains selectable during account restoration', (
    tester,
    h,
  ) async {
    await h.controller.initialize();
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('restoration-language-settings')),
    );
    await tester.pumpAndSettle();
    final english = find.byKey(const ValueKey('language-en'));
    await tester.ensureVisible(english);
    await tester.pumpAndSettle();
    await tester.tap(english);
    await tester.pumpAndSettle();
    expect(h.preferences.language, 'en');
    expect(h.controller.locale, const Locale('en'));
    expect(h.controller.hasPendingAccountRestoration, isTrue);
    h.api.failure = null;
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('retry-account-restoration')),
    );
    await tester.pumpAndSettle();
    expect(h.controller.isSignedIn, isTrue);
    expect(h.controller.locale, const Locale('en'));
    expect(h.preferences.language, 'en');
    expect(tester.takeException(), isNull);
  });

  _restorationTest(
    'offline account exposes local VPN stop without claiming sign-in',
    (tester, h) async {
      await h.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('account-restoration-page')),
        findsOneWidget,
      );
      expect(find.byType(WelcomePage), findsNothing);
      expect(find.byType(HomeShell), findsNothing);
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.isConnected, isTrue);
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('restoration-disconnect-vpn')),
      );
      await tester.pumpAndSettle();
      expect(h.tunnel.userStops, 1);
      expect(h.controller.isConnected, isFalse);
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.store.session, isNotNull);
      expect(tester.takeException(), isNull);
    },
  );

  _restorationTest('retry restores the same session and opens the account', (
    tester,
    h,
  ) async {
    await h.controller.initialize();
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    h.api.failure = null;
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('retry-account-restoration')),
    );
    await tester.pumpAndSettle();
    expect(h.api.meCalls, 2);
    expect(h.api.loginCalls, 0);
    expect(h.controller.isSignedIn, isTrue);
    expect(find.byType(HomeShell), findsOneWidget);
    expect(
      find.byKey(const ValueKey('account-restoration-page')),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });

  _restorationTest(
    'a pending retry keeps VPN stop available and is not submitted twice',
    (tester, h) async {
      await h.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      h.api.failure = null;
      final response = Completer<UserProfile>();
      h.api.pendingProfile = response.future;
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('retry-account-restoration')),
      );
      await tester.pump();
      final retry = tester.widget<FilledButton>(
        find.byKey(const ValueKey('retry-account-restoration')),
      );
      expect(retry.onPressed, isNull);
      await h.controller.retryAccountRestoration();
      expect(h.api.meCalls, 2);
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('restoration-disconnect-vpn')),
      );
      await tester.pump();
      expect(h.tunnel.userStops, 1);
      expect(h.controller.isRestoringAccount, isTrue);
      response.complete(_restoredProfile);
      await tester.pumpAndSettle();
      expect(h.controller.isSignedIn, isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  _restorationTest(
    'secure account binding failure leaves a retryable unpublished account',
    (tester, h) async {
      h.api.failure = null;
      h.store.failAccountWrite = true;
      await h.controller.initialize();
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      expect(h.controller.profile, isNull);
      expect(find.byType(HomeShell), findsNothing);
      expect(
        find.byKey(const ValueKey('restoration-disconnect-vpn')),
        findsOneWidget,
      );
      h.store.failAccountWrite = false;
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('retry-account-restoration')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomeShell), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  _restorationTest('logout invalidates a late retry response', (
    tester,
    h,
  ) async {
    await h.controller.initialize();
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    h.api.failure = null;
    final response = Completer<UserProfile>();
    h.api.pendingProfile = response.future;
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('retry-account-restoration')),
    );
    await tester.pump();
    await tester.ensureVisible(
      find.byKey(const ValueKey('restoration-sign-out')),
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('restoration-sign-out')),
    );
    await tester.pumpAndSettle();
    response.complete(_restoredProfile);
    await tester.pumpAndSettle();
    expect(h.controller.profile, isNull);
    expect(h.store.session, isNull);
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.byType(HomeShell), findsNothing);
    expect(tester.takeException(), isNull);
  });

  _restorationTest('unauthorized retry clears the saved session', (
    tester,
    h,
  ) async {
    await h.controller.initialize();
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    h.api.failure = const ApiException(
      statusCode: 401,
      errorCode: 'unauthorized',
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('retry-account-restoration')),
    );
    await tester.pumpAndSettle();
    expect(h.store.session, isNull);
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final locale in ['fr', 'en', 'es', 'de']) {
    for (final theme in [ThemeMode.light, ThemeMode.dark]) {
      _restorationTest(
        'restoration controls fit 320dp at 200% text ($locale, ${theme.name})',
        (tester, h) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.view.devicePixelRatio = 1;
          tester.platformDispatcher.textScaleFactorTestValue = 2;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          h.preferences.language = locale;
          h.preferences.theme = theme.name;
          await h.controller.initialize();
          await tester.pumpWidget(
            FuzeVpnApp(controller: h.controller, autoInitialize: false),
          );
          await tester.pumpAndSettle();
          for (final key in [
            'retry-account-restoration',
            'restoration-disconnect-vpn',
            'restoration-sign-out',
          ]) {
            final control = find.byKey(ValueKey(key));
            await tester.ensureVisible(control);
            await tester.pumpAndSettle();
            expect(control.hitTestable(), findsOneWidget);
          }
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
}

void _restorationTest(
  String description,
  Future<void> Function(WidgetTester tester, _RestorationFixture fixture)
  body, {
  String? tags,
}) {
  testWidgets(description, (tester) async {
    final fixture = _RestorationFixture();
    try {
      await body(tester, fixture);
    } finally {
      // A connected controller owns periodic metrics timers. Close it before
      // testWidgets checks for pending timers, after unmounting its listeners.
      await tester.pumpWidget(const SizedBox.shrink());
      await fixture.dispose();
    }
  }, tags: tags);
}

String _goldenPath(String file) =>
    const bool.fromEnvironment('FUZEVPN_REVIEW_FONTS')
    ? '../../build/reports/ui-previews/$file'
    : 'goldens/$file';

Future<void> _settleRestorationImages(WidgetTester tester) async {
  final images = tester.widgetList<Image>(find.byType(Image)).toList();
  final context = tester.element(find.byType(Scaffold));
  await tester.runAsync(() async {
    await Future.wait(
      images.map((image) => precacheImage(image.image, context)),
    );
  });
  await tester.pumpAndSettle();
}

const _restoredProfile = UserProfile(
  userId: 'restoration-user',
  email: 'user@example.test',
  firstName: 'Test',
  lastName: '',
  phone: '',
  addressLine1: '',
  addressLine2: '',
  postalCode: '',
  city: '',
  countryCode: 'FR',
);

class _RestorationFixture {
  _RestorationFixture() {
    store = _RestorationStore(tunnel);
    controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: preferences,
      tunnel: tunnel,
    );
  }
  final api = _RestorationApi();
  final preferences = _RestorationPreferences();
  final tunnel = _RestorationTunnel();
  late final _RestorationStore store;
  late final VpnAppController controller;
  Future<void> dispose() async {
    controller.dispose();
    await tunnel.events.close();
  }
}

class _RestorationApi implements VpnApiRepository {
  ApiFailure? failure = const ApiNetworkException();
  Future<UserProfile>? pendingProfile;
  int meCalls = 0;
  int loginCalls = 0;
  @override
  Future<UserProfile> me(String token) async {
    meCalls++;
    if (failure != null) throw failure!;
    return pendingProfile == null ? _restoredProfile : await pendingProfile!;
  }

  @override
  Future<List<Location>> locations() async => const [
    Location(
      id: 'test-location',
      city: 'Paris',
      countryCode: 'FR',
      displayName: 'Paris',
      supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
    ),
  ];
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: []);
  @override
  Future<void> logout(String token) async {}
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    throw StateError('Restoration must not request a new login');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RestorationStore implements SecureSessionStore {
  _RestorationStore(this.tunnel);
  final _RestorationTunnel tunnel;
  AuthSession? session = AuthSession(
    accessToken: 'fixture-session',
    expiresAt: DateTime.utc(2099),
  );
  bool failAccountWrite = false;
  @override
  Future<AuthSession?> readSession() async => session;
  @override
  Future<void> writeSession(AuthSession value, {String? userId}) async {
    if (userId != null && failAccountWrite) {
      throw const NativeVpnException('secure_storage_write_failed');
    }
    session = value;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async => null;
  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    await tunnel.disconnect();
    session = null;
    return const SessionTerminationResult.complete();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RestorationPreferences implements AppPreferenceStore {
  String? theme;
  String? language = 'fr';
  @override
  Future<String?> readThemeMode() async => theme;
  @override
  Future<String?> readLocale() async => language;
  @override
  Future<void> writeLocale(String? value) async => language = value;
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RestorationTunnel
    implements VpnTunnelGateway, VpnSystemProtectionGateway {
  final events = StreamController<VpnRuntimeState>.broadcast();
  VpnRuntimeState state = const VpnRuntimeState(
    phase: VpnRuntimePhase.connected,
    protocol: VpnProtocol.wireGuard,
  );
  int userStops = 0;
  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async => state;
  @override
  Future<SystemVpnProtection> getSystemVpnProtection() async =>
      const SystemVpnProtection(alwaysOn: false, lockdown: false);
  @override
  Future<void> openVpnSettings() async {}
  @override
  Future<void> disconnectByUser() async {
    userStops++;
    await disconnect();
  }

  @override
  Future<void> disconnect() async {
    state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
    events.add(state);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
