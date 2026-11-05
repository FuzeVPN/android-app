// Corrections du 29/10/2026, A16-ui-l10n-01 : franchir le seuil de 720 dp de
// HomeShell (rotation, multifenêtre, dépliage) ne doit ni recréer les pages ni
// annuler une confirmation de changement d'emplacement déjà ouverte.
// Porté de audit-complet-20261028/repros/A16-ui-l10n/a16_home_shell_threshold
// avec les assertions inversées, plus les variantes aller-retour.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';
import 'package:fuzevpn_android/widgets/notice_card.dart';

const _paris = Location(
  id: 'paris-01',
  city: 'Paris',
  countryCode: 'FR',
  displayName: 'Paris',
  supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
);
const _frankfurt = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 01',
  supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
);
const _frankfurtTwo = Location(
  id: 'frankfurt-02',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 02',
  supportedProtocols: {VpnProtocol.wireGuard},
);
const _catalog = [_paris, _frankfurt, _frankfurtTwo];
const _profile = UserProfile(
  userId: 'fixture-user',
  email: 'fixture@example.test',
  firstName: '',
  lastName: '',
  phone: '',
  addressLine1: '',
  addressLine2: '',
  postalCode: '',
  city: '',
  countryCode: 'FR',
);

const _narrow = Size(700, 1000); // barre de navigation (< 720 dp)
const _wide = Size(1000, 700); // rail (>= 720 dp), ex. rotation paysage

void main() {
  testWidgets(
    '700 -> 1000 dp : la recherche saisie et le State sont conservés',
    (tester) async {
      final h = await _mount(tester, _narrow);
      await _openLocations(tester);
      final search = find.byKey(const ValueKey('locations-search'));
      await tester.enterText(search, 'Frank');
      await tester.pumpAndSettle();
      final stateBefore = tester.state(find.byType(LocationsPage));

      await _resize(tester, _wide);
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(
        identical(tester.state(find.byType(LocationsPage)), stateBefore),
        isTrue,
      );
      expect(tester.widget<TextField>(search).controller!.text, 'Frank');
      await _dispose(tester, h);
    },
  );

  testWidgets('aller-retour 700 -> 1000 -> 700 dp : rien n est recréé', (
    tester,
  ) async {
    final h = await _mount(tester, _narrow);
    await _openLocations(tester);
    final search = find.byKey(const ValueKey('locations-search'));
    await tester.enterText(search, 'Par');
    await tester.pumpAndSettle();
    final locationsState = tester.state(find.byType(LocationsPage));
    final shellState = tester.state(find.byType(HomeShell));

    await _resize(tester, _wide);
    await _resize(tester, _narrow);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      identical(tester.state(find.byType(LocationsPage)), locationsState),
      isTrue,
    );
    expect(identical(tester.state(find.byType(HomeShell)), shellState), isTrue);
    expect(tester.widget<TextField>(search).controller!.text, 'Par');
    await _dispose(tester, h);
  });

  testWidgets(
    '1000 -> 700 dp : le pays ouvert dans Emplacements reste ouvert',
    (tester) async {
      final h = await _mount(tester, _wide);
      await _openLocations(tester);
      await _tapKey(tester, 'browse-country-DE');
      await tester.pumpAndSettle();
      final city = find.byKey(const ValueKey('browse-city-DE-frankfurt'));
      expect(city, findsOneWidget);

      await _resize(tester, _narrow);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(city, findsOneWidget);
      await _dispose(tester, h);
    },
  );

  for (final code in [
    'openvpn_recovery_exhausted',
    'openvpn_recovery_failed',
  ]) {
    testWidgets(
      'A16-ui-l10n-03 : $code émis par le tunnel a un titre spécifique',
      (tester) async {
        final h = await _mount(tester, _narrow);
        h.tunnel.events.add(
          VpnRuntimeState(
            phase: VpnRuntimePhase.error,
            protocol: VpnProtocol.openVpn,
            messageCode: code,
          ),
        );
        await tester.pumpAndSettle();
        expect(h.controller.notice?.titleKey, 'notice.native.title');
        final l = lookupAppLocalizations(const Locale('fr'));
        final generic = l.notice_native_title('__unknown__', 'OpenVPN');
        final title = l.notice_native_title(code, 'OpenVPN');
        final message = l.notice_native_message(code, 'OpenVPN');
        expect(title, isNot(generic));
        final card = find.byType(NoticeCard).first;
        expect(
          find.descendant(of: card, matching: find.text(title)),
          findsOneWidget,
        );
        expect(
          find.descendant(of: card, matching: find.text(message)),
          findsOneWidget,
        );
        expect(
          find.descendant(of: card, matching: find.text(generic)),
          findsNothing,
        );
        await _dispose(tester, h);
      },
    );
  }

  for (final (label, start, end) in [
    ('sans franchissement (témoin)', _narrow, _narrow),
    ('700 -> 1000 dp dialogue ouvert', _narrow, _wide),
    ('1000 -> 700 dp dialogue ouvert', _wide, _narrow),
  ]) {
    testWidgets('confirmation de changement d emplacement $label', (
      tester,
    ) async {
      final h = await _mount(tester, start);
      await _openLocations(tester);
      await _tapKey(tester, 'select-country-DE');
      await tester.pumpAndSettle();
      if (find
          .byKey(const ValueKey('location-change-dialog'))
          .evaluate()
          .isEmpty) {
        await _tapKey(tester, 'select-city-DE-frankfurt');
        await tester.pumpAndSettle();
      }
      final dialog = find.byKey(const ValueKey('location-change-dialog'));
      expect(dialog, findsOneWidget);
      if (end != start) {
        await _resize(tester, end);
        expect(
          find.byType(end == _wide ? NavigationRail : NavigationBar),
          findsOneWidget,
        );
        expect(dialog, findsOneWidget);
      }
      await tester.tap(find.byKey(const ValueKey('location-change-confirm')));
      await tester.pumpAndSettle();

      expect(dialog, findsNothing);
      expect(h.api.registeredLocations, ['frankfurt-01']);
      expect(h.tunnel.actions, ['permission', 'connect:frankfurt-01']);
      expect(h.controller.tunnelState.isConnected, isTrue);
      await _dispose(tester, h);
    });
  }
}

Future<_Harness> _mount(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final h = _Harness();
  await h.controller.initialize();
  await tester.pumpWidget(
    AnimatedBuilder(
      animation: h.controller,
      builder: (context, _) => MaterialApp(
        locale: const Locale('fr'),
        supportedLocales: AppLanguages.supportedLocales,
        localeListResolutionCallback: AppLanguages.resolve,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: FuzeVpnTheme.light(),
        home: HomeShell(controller: h.controller),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return h;
}

Future<void> _resize(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  await tester.pumpAndSettle();
}

Future<void> _dispose(WidgetTester tester, _Harness h) async {
  await tester.pumpWidget(const SizedBox.shrink());
  h.controller.dispose();
  await h.tunnel.dispose();
}

Future<void> _openLocations(WidgetTester tester) async {
  final copy = lookupAppLocalizations(const Locale('fr'));
  await tester.tap(find.text(copy.nav_locations).last);
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('locations-search')), findsOneWidget);
}

Future<void> _tapKey(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey(key));
  if (finder.evaluate().isEmpty) {
    final scrollable = find
        .descendant(
          of: find.byType(LocationsPage),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: scrollable,
      maxScrolls: 60,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

class _Harness {
  _Harness() {
    controller = VpnAppController(
      api: api,
      sessionStore: session,
      preferences: preferences,
      tunnel: tunnel,
    );
  }
  final api = _Api();
  final preferences = _Preferences();
  final tunnel = _Tunnel();
  final session = _Session();
  late final VpnAppController controller;
}

class _Api implements VpnApiRepository {
  final registeredLocations = <String>[];
  @override
  Future<List<Location>> locations() async => _catalog;
  @override
  Future<UserProfile> me(String token) async => _profile;
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: []);
  @override
  Future<void> logout(String token) async {}
  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    registeredLocations.add(locationId);
    return const DeviceConfiguration(
      deviceId: 'fixture-device',
      address: '10.0.0.2/32',
      dns: ['1.1.1.1'],
      serverPublicKey: 'fixture-public-key',
      endpoint: 'fixture.invalid:51820',
      allowedIps: ['0.0.0.0/0'],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Session implements SecureSessionStore {
  AuthSession? value = AuthSession(
    accessToken: 'fixture-token',
    expiresAt: DateTime.utc(2099),
  );
  @override
  Future<AuthSession?> readSession() async => value;
  @override
  Future<void> writeSession(AuthSession session, {String? userId}) async =>
      value = session;
  @override
  Future<String?> readCurrentDeviceId({required String userId}) async => null;
  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async {}
  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    value = null;
    return const SessionTerminationResult.complete();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Preferences implements AppPreferenceStore, FavoriteLocationStore {
  Set<String> favorites = {};
  @override
  Future<Set<String>> readFavoriteLocations() async => Set.of(favorites);
  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) async =>
      favorites = Set.of(locationIds);
  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => 'fr';
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {}
  @override
  Future<void> writeSelectedLocation(String value) async {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Tunnel implements VpnTunnelGateway {
  final events = StreamController<VpnRuntimeState>.broadcast();
  Future<void> dispose() => events.close();
  final actions = <String>[];
  VpnRuntimeState observed = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async => observed;
  @override
  Future<bool> requestVpnPermission() async {
    actions.add('permission');
    return true;
  }

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async => 'fixture-public-key';
  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async {
    actions.add('connect:${location.id}');
    observed = const VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: VpnProtocol.wireGuard,
    );
    events.add(observed);
  }

  @override
  Future<void> disconnect() async {
    actions.add('disconnect');
    observed = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
    events.add(observed);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
