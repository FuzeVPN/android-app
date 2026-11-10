// Corrections du 29/10/2026, A15-diagnostics-01 : un double appui sur
// « Enregistrer le rapport » ne doit pas afficher d'échec alors que l'export
// natif a réussi. Porté de audit-complet-20261028/repros/A15-diagnostics/
// a15_diagnostics_export_ui_test.dart avec les assertions inversées, plus les
// variantes contrôleur (appel concurrent, refus natif « en cours », échec
// tardif d'un rapport remplacé) et le témoin d'un vrai échec.
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_localization_delegates.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  final exportFailed = lookupAppLocalizations(
    const Locale('fr'),
  ).diagnostics_exportFailed;
  final exportButton = find.byKey(const ValueKey('export-diagnostic-report'));

  _diagnosticsTest(
    'double appui : un seul export natif, aucun échec affiché après succès',
    (tester, h) async {
      await h.mount(tester);
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      expect(h.controller.diagnosticReport, isNotNull);
      final first = Completer<bool>();
      h.tunnel.nextExport = first;
      await _tapDiagnostic(tester, 'export-diagnostic-report');
      await tester.pump();
      // Le bouton est désactivé tant que l'export natif est en cours.
      expect(tester.widget<OutlinedButton>(exportButton).onPressed, isNull);
      await tester.tap(exportButton, warnIfMissed: false);
      await tester.pump();
      expect(h.tunnel.calls, 1);
      expect(h.tunnel.rejectedConcurrent, 0);
      first.complete(true);
      await tester.pumpAndSettle();
      expect(h.tunnel.exports, hasLength(1));
      expect(h.controller.diagnosticExportFailed, isFalse);
      expect(find.text(exportFailed), findsNothing);
      expect(tester.widget<OutlinedButton>(exportButton).onPressed, isNotNull);
    },
  );

  _diagnosticsTest(
    'appels concurrents du contrôleur : le second est ignoré, pas de faux échec',
    (tester, h) async {
      await h.mount(tester);
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      final first = Completer<bool>();
      h.tunnel.nextExport = first;
      final a = h.controller.exportDiagnosticReport();
      final b = h.controller.exportDiagnosticReport();
      await tester.pump();
      first.complete(true);
      await Future.wait([a, b]);
      await tester.pumpAndSettle();
      expect(h.tunnel.calls, 1);
      expect(h.tunnel.rejectedConcurrent, 0);
      expect(h.tunnel.exports, hasLength(1));
      expect(h.controller.diagnosticExportFailed, isFalse);
      expect(find.text(exportFailed), findsNothing);
      // Un nouvel export reste possible après la fin du premier.
      await h.controller.exportDiagnosticReport();
      await tester.pumpAndSettle();
      expect(h.tunnel.exports, hasLength(2));
    },
  );

  _diagnosticsTest(
    'refus natif diagnostic_export_in_progress : pas présenté comme un échec',
    (tester, h) async {
      await h.mount(tester);
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      // Un export lancé ailleurs (écran précédent, activité recréée) occupe
      // encore le sélecteur Android.
      h.tunnel.inFlightElsewhere = true;
      await _tapDiagnostic(tester, 'export-diagnostic-report');
      await tester.pumpAndSettle();
      expect(h.tunnel.rejectedConcurrent, 1);
      expect(h.controller.diagnosticExportFailed, isFalse);
      expect(find.text(exportFailed), findsNothing);
    },
  );

  _diagnosticsTest('témoin : un vrai échec natif reste affiché', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    await _tapDiagnostic(tester, 'run-diagnostics');
    await tester.pumpAndSettle();
    h.tunnel.failure = const NativeVpnException('diagnostic_export_failed');
    await _tapDiagnostic(tester, 'export-diagnostic-report');
    await tester.pumpAndSettle();
    expect(h.controller.diagnosticExportFailed, isTrue);
    expect(find.text(exportFailed), findsOneWidget);
    expect(tester.widget<OutlinedButton>(exportButton).onPressed, isNotNull);
  });

  _diagnosticsTest(
    'échec tardif d un export du rapport remplacé : sans effet sur le nouveau',
    (tester, h) async {
      await h.mount(tester);
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      final first = Completer<bool>();
      h.tunnel.nextExport = first;
      await _tapDiagnostic(tester, 'export-diagnostic-report');
      await tester.pump();
      // Nouveau diagnostic pendant que le sélecteur de l'ancien est ouvert.
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      expect(h.controller.diagnosticReport, isNotNull);
      first.completeError(const NativeVpnException('diagnostic_export_failed'));
      await tester.pumpAndSettle();
      await _reveal(tester, 'export-diagnostic-report');
      expect(h.controller.diagnosticExportFailed, isFalse);
      expect(find.text(exportFailed), findsNothing);
      expect(tester.widget<OutlinedButton>(exportButton).onPressed, isNotNull);
    },
  );
}

void _diagnosticsTest(
  String name,
  Future<void> Function(WidgetTester, _DiagnosticHarness) body,
) {
  testWidgets(name, (tester) async {
    final h = _DiagnosticHarness();
    try {
      await h.controller.initialize();
      await body(tester, h);
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      h.controller.dispose();
      await h.tunnel.dispose();
    }
  });
}

Future<void> _tapDiagnostic(WidgetTester tester, String key) async {
  await _reveal(tester, key);
  await tester.tap(find.byKey(ValueKey(key)));
}

Future<void> _reveal(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey(key));
  final scrollable = find.byType(Scrollable).first;
  if (finder.evaluate().isEmpty) {
    tester.state<ScrollableState>(scrollable).position.jumpTo(0);
    await tester.pump();
  }
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      300,
      scrollable: scrollable,
      maxScrolls: 60,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pump();
}

class _DiagnosticHarness {
  _DiagnosticHarness() {
    service = DiagnosticService(
      transport: transport,
      baseUri: Uri.parse('https://fixture.invalid'),
      scheduleRetries: false,
      monotonicMilliseconds: () => milliseconds,
    );
    controller = VpnAppController(
      api: _DiagnosticApi(),
      sessionStore: _DiagnosticStore(),
      preferences: _DiagnosticPreferences(),
      tunnel: tunnel,
      diagnostics: service,
    );
  }
  final transport = _DiagnosticTransport();
  final tunnel = _DiagnosticTunnel();
  int milliseconds = 0;
  late final DiagnosticService service;
  late final VpnAppController controller;
  Future<void> mount(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: FuzeVpnTheme.light(),
        localizationsDelegates: AppLocalizationDelegates.all,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DiagnosticsPage(controller: controller),
      ),
    );
    await tester.pumpAndSettle();
  }
}

class _DiagnosticTransport extends ApiHttpTransport {
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    final body = jsonDecode(request.body!) as Map<String, dynamic>;
    final now = DateTime.now().toUtc();
    return ApiHttpResponse(
      statusCode: 201,
      headers: const {},
      body: jsonEncode({
        'report_id': '00000000-0000-4000-8000-000000000001',
        'client_report_id': body['report_id'],
        'received_at': now.toIso8601String(),
        'expires_at': now.add(const Duration(days: 30)).toIso8601String(),
        'duplicate': false,
        'status': 'received',
      }),
    );
  }
}

class _DiagnosticApi implements VpnApiRepository {
  @override
  Future<List<Location>> locations() async => const [
    Location(
      id: 'fixture-location',
      city: 'Paris',
      countryCode: 'FR',
      displayName: 'Paris',
      supportedProtocols: {VpnProtocol.wireGuard},
    ),
  ];
  @override
  Future<UserProfile> me(String token) async => const UserProfile(
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
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: []);
  @override
  Future<void> logout(String token) async {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _DiagnosticStore implements SecureSessionStore {
  AuthSession? session = AuthSession(
    accessToken: 'fixture-token',
    expiresAt: DateTime.utc(2099),
  );
  @override
  Future<AuthSession?> readSession() async => session;
  @override
  Future<void> writeSession(AuthSession value, {String? userId}) async {
    session = value;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async => null;
  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    session = null;
    return const SessionTerminationResult.complete();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _DiagnosticPreferences
    implements AppPreferenceStore, DiagnosticPreferenceStore {
  @override
  Future<bool> readAutomaticDiagnostics() async => false;
  @override
  Future<void> writeAutomaticDiagnostics(bool enabled) async {}
  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => 'fr';
  @override
  Future<void> writeLocale(String? languageCode) async {}
  @override
  Future<void> writeThemeMode(String value) async {}
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _DiagnosticTunnel
    implements
        VpnTunnelGateway,
        VpnSystemProtectionGateway,
        DiagnosticPlatformGateway {
  final events = StreamController<VpnRuntimeState>.broadcast();
  final exports = <String>[];
  Completer<bool>? nextExport;
  NativeVpnException? failure;
  bool inFlightElsewhere = false;
  bool _inFlight = false;
  int calls = 0;
  int rejectedConcurrent = 0;
  Future<void> dispose() => events.close();

  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  Future<VpnRuntimeState> diagnosticSnapshot() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  Future<SystemVpnProtection> getSystemVpnProtection() async =>
      const SystemVpnProtection(alwaysOn: false, lockdown: false);
  @override
  Future<Map<String, Object?>> diagnosticMetadata() async => {
    'app_version': '1.0.0',
    'app_build': 1,
  };

  @override
  Future<bool> exportDiagnosticReport(String json) async {
    calls++;
    // Modèle d'AndroidVpnBridge.exportDiagnosticReport : un export déjà en
    // cours fait échouer immédiatement l'appel concurrent.
    if (_inFlight || inFlightElsewhere) {
      rejectedConcurrent++;
      throw const NativeVpnException('diagnostic_export_in_progress');
    }
    final error = failure;
    if (error != null) throw error;
    _inFlight = true;
    try {
      final pending = nextExport;
      nextExport = null;
      final written = pending == null ? true : await pending.future;
      if (written) exports.add(json);
      return written;
    } finally {
      _inFlight = false;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
