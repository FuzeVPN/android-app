// Corrections du 29/10/2026, A17-supply-chain-05 (partie écran) : l'écran
// « Licences des composants » doit indiquer où obtenir les sources des
// composants MPL-2.0 livrés (applicationLegalese). Depuis l'exclusion de
// libwg.so et libwg-quick.so, aucun composant GPL-2.0 n'est livré. Contre-exemple
// de l'audit (repros/A17-supply-chain/supply_chain_consistency.py, bloc 05) :
// aucune offre ni URL de sources à l'écran de licences.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

const _repository = 'https://github.com/FuzeVPN/android-app';
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

void main() {
  for (final tag in ['fr', 'en', 'ar']) {
    testWidgets('écran de licences : sources MPL indiquées ($tag)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(700, 1400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final h = _Harness(tag);
      await h.controller.initialize();
      final copy = lookupAppLocalizations(Locale(tag));
      try {
        await tester.pumpWidget(
          AnimatedBuilder(
            animation: h.controller,
            builder: (context, _) => MaterialApp(
              locale: Locale(tag),
              supportedLocales: AppLanguages.supportedLocales,
              localeListResolutionCallback: AppLanguages.resolve,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              theme: FuzeVpnTheme.light(),
              home: HomeShell(controller: h.controller),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text(copy.nav_account).last);
        await tester.pumpAndSettle();
        final tile = find.text(copy.settings_licenses);
        await tester.scrollUntilVisible(
          tile,
          300,
          scrollable: find
              .descendant(
                of: find.byType(AccountPage),
                matching: find.byType(Scrollable),
              )
              .first,
          maxScrolls: 80,
        );
        await tester.pumpAndSettle();
        await tester.tap(tile);
        // La page de licences anime un indicateur tant que le registre se
        // charge : avancer de quelques images au lieu d'attendre l'arrêt.
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(find.byType(LicensePage), findsOneWidget);
        expect(find.textContaining(_repository), findsWidgets);
        final legalese = AppCopy.resolve(
          copy,
          'settings.licensesLegalese',
          arguments: {'url': _repository},
        );
        expect(find.text(legalese), findsWidgets);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        h.controller.dispose();
        await h.tunnel.dispose();
      }
    });
  }
}

class _Harness {
  _Harness(String locale) : preferences = _Preferences(locale) {
    controller = VpnAppController(
      api: _Api(),
      sessionStore: _Session(),
      preferences: preferences,
      tunnel: tunnel,
    );
  }
  final _Preferences preferences;
  final tunnel = _Tunnel();
  late final VpnAppController controller;
}

class _Api implements VpnApiRepository {
  @override
  Future<List<Location>> locations() async => const [];
  @override
  Future<UserProfile> me(String token) async => _profile;
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: []);
  @override
  Future<void> logout(String token) async {}
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
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    value = null;
    return const SessionTerminationResult.complete();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Preferences implements AppPreferenceStore, FavoriteLocationStore {
  _Preferences(this.locale);
  final String locale;
  @override
  Future<Set<String>> readFavoriteLocations() async => <String>{};
  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) async {}
  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => locale;
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Tunnel implements VpnTunnelGateway {
  final events = StreamController<VpnRuntimeState>.broadcast();
  Future<void> dispose() => events.close();
  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
