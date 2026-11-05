// Passe finale du réaudit (30/10/2026), B27 (A17-supply-chain-05) : LICENSING.md
// promet un tag `v<version>` par version distribuée, nommé d'après la version
// affichée par l'écran de licences. L'écran affiche donc la version installée,
// lue dans la métadonnée native de diagnostic (versionName, versionCode), et
// renvoie aux sources de ce tag ; sans version connue, à la racine du dépôt.
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
  for (final locale in const <Locale>[Locale('fr'), Locale('en')]) {
    for (final (label, metadata, version, url)
        in <(String, Object, String?, String)>[
          (
            'version installée connue',
            <String, Object?>{'app_version': '0.2.10', 'app_build': 74016},
            '0.2.10 (74016)',
            '$_repository/tree/v0.2.10',
          ),
          (
            'version sans numéro de build',
            <String, Object?>{'app_version': '0.2.10'},
            '0.2.10',
            '$_repository/tree/v0.2.10',
          ),
          (
            'témoin : métadonnée sans version',
            <String, Object?>{},
            null,
            _repository,
          ),
          (
            'témoin : métadonnée illisible',
            StateError('unavailable'),
            null,
            _repository,
          ),
        ]) {
      testWidgets(
        'écran de licences : version et sources ($label, ${locale.languageCode})',
        (tester) async {
          tester.view.physicalSize = const Size(700, 1400);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final h = _Harness(metadata);
          await h.controller.initialize();
          final copy = lookupAppLocalizations(locale);
          try {
            await tester.pumpWidget(
              AnimatedBuilder(
                animation: h.controller,
                builder: (context, _) => MaterialApp(
                  locale: locale,
                  supportedLocales: AppLanguages.supportedLocales,
                  localeListResolutionCallback: AppLanguages.resolve,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
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
            // The license registry animates while it loads: advance a few frames.
            for (var i = 0; i < 10; i++) {
              await tester.pump(const Duration(milliseconds: 100));
            }
            expect(find.byType(LicensePage), findsOneWidget);
            // The page bears the menu entry's title ("Component licenses"), not
            // Flutter's own "Licenses"; every other Material text is unchanged.
            expect(
              find.descendant(
                of: find.byType(AppBar),
                matching: find.text(copy.settings_licenses),
              ),
              findsOneWidget,
            );
            final page = MaterialLocalizations.of(
              tester.element(find.byType(LicensePage)),
            );
            final app = MaterialLocalizations.of(
              tester.element(find.byType(HomeShell, skipOffstage: false)),
            );
            expect(page.licensesPageTitle, copy.settings_licenses);
            expect(app.licensesPageTitle, isNot(copy.settings_licenses));
            expect(page.backButtonTooltip, app.backButtonTooltip);
            expect(
              page.licensesPackageDetailText(2),
              app.licensesPackageDetailText(2),
            );
            if (version != null) {
              expect(h.tunnel.metadataReads, 1);
              expect(find.text(version), findsWidgets);
            } else {
              expect(find.textContaining('0.2.10'), findsNothing);
            }
            final legalese = AppCopy.resolve(
              copy,
              'settings.licensesLegalese',
              arguments: {'url': url},
            );
            expect(find.text(legalese), findsWidgets);
          } finally {
            await tester.pumpWidget(const SizedBox.shrink());
            h.controller.dispose();
            await h.tunnel.dispose();
          }
        },
      );
    }
  }
}

class _Harness {
  _Harness(Object metadata) : tunnel = _Tunnel(metadata) {
    controller = VpnAppController(
      api: _Api(),
      sessionStore: _Session(),
      preferences: _Preferences(),
      tunnel: tunnel,
    );
  }
  final _Tunnel tunnel;
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
  @override
  Future<Set<String>> readFavoriteLocations() async => <String>{};
  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) async {}
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
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// The native bridge also serves diagnostic metadata: versionName and
/// versionCode of the installed package.
class _Tunnel implements VpnTunnelGateway, DiagnosticPlatformGateway {
  _Tunnel(this.metadata);
  final Object metadata;
  int metadataReads = 0;
  final events = StreamController<VpnRuntimeState>.broadcast();
  Future<void> dispose() => events.close();
  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  Future<Map<String, Object?>> diagnosticMetadata() async {
    metadataReads++;
    final value = metadata;
    if (value is Map<String, Object?>) return value;
    throw value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
