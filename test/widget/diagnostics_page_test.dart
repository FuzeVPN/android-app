import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';
import 'package:fuzevpn_android/widgets/country_flag.dart';

void main() {
  _diagnosticsTest(
    'manual diagnostics are local by default even when automatic sharing is enabled',
    (tester, h) async {
      await h.controller.setAutomaticDiagnostics(true);
      await h.mount(tester);
      expect(
        tester
            .widget<CheckboxListTile>(
              find.byKey(const ValueKey('diagnostics-send-report')),
            )
            .value,
        isFalse,
      );
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      expect(h.controller.diagnosticReport, isNotNull);
      expect(h.transport.requests, isEmpty);
      expect(h.tunnel.destructiveCalls, 0);
      expect(h.tunnel.businessReads, 1);
      expect(h.tunnel.snapshotReads, 1);
      expect(
        find.byKey(const ValueKey('diagnostic-report-preview')),
        findsOneWidget,
      );
      expect(find.text('État du tunnel'), findsOneWidget);
      expect(find.text('Protection Android'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('diagnostic-report-json')),
        findsNothing,
      );
      await _tapDiagnostic(tester, 'diagnostic-technical-details');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('diagnostic-report-json')),
        findsOneWidget,
      );
      expect(h.controller.automaticDiagnostics, isTrue);
    },
  );

  _diagnosticsTest('checked report shows progress and a server receipt', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    final response = Completer<ApiHttpResponse>();
    h.transport.pending = response.future;
    await _tapDiagnostic(tester, 'diagnostics-send-report');
    await _tapDiagnostic(tester, 'run-diagnostics');
    await tester.pump();
    expect(h.transport.requests, hasLength(1));
    expect(find.text('Envoi du rapport…'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const ValueKey('run-diagnostics')))
          .onPressed,
      isNull,
    );
    response.complete(h.transport.accepted(h.transport.requests.single));
    await tester.pumpAndSettle();
    expect(h.controller.diagnosticStatus, DiagnosticStatus.sent);
    expect(find.byKey(const ValueKey('diagnostics-receipt')), findsOneWidget);
    expect(h.controller.automaticDiagnostics, isFalse);
    expect(h.tunnel.destructiveCalls, 0);
  });

  _diagnosticsTest('unchecking during collection prevents a manual send', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    final observed = Completer<VpnRuntimeState>();
    h.tunnel.pendingState = observed.future;
    await _tapDiagnostic(tester, 'diagnostics-send-report');
    await _tapDiagnostic(tester, 'run-diagnostics');
    await tester.pump();
    expect(h.controller.diagnosticsBusy, isTrue);
    await _tapDiagnostic(tester, 'diagnostics-send-report');
    await tester.pump();
    expect(
      tester
          .widget<CheckboxListTile>(
            find.byKey(const ValueKey('diagnostics-send-report')),
          )
          .value,
      isFalse,
    );
    observed.complete(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
    await tester.pumpAndSettle();
    expect(h.transport.requests, isEmpty);
    expect(h.controller.diagnosticReport, isNotNull);
    expect(h.controller.automaticDiagnostics, isFalse);
  });

  _diagnosticsTest(
    'failed sending keeps the report and permits an explicit retry',
    (tester, h) async {
      await h.mount(tester);
      h.transport.failureStatus = 503;
      await _tapDiagnostic(tester, 'diagnostics-send-report');
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      expect(h.controller.diagnosticReport, isNotNull);
      h.milliseconds += 61000;
      await h.controller.refreshSystemProtection();
      await tester.pumpAndSettle();
      expect(h.controller.diagnosticCanRetry, isTrue);
      expect(
        find.byKey(const ValueKey('retry-diagnostic-report')),
        findsOneWidget,
      );
      h.transport.failureStatus = null;
      await _tapDiagnostic(tester, 'retry-diagnostic-report');
      await tester.pumpAndSettle();
      expect(h.transport.requests, hasLength(2));
      expect(h.controller.diagnosticStatus, DiagnosticStatus.sent);
      expect(find.byKey(const ValueKey('diagnostics-receipt')), findsOneWidget);
    },
  );

  _diagnosticsTest(
    'revoking manual consent removes queued sending without disabling automatic sharing',
    (tester, h) async {
      await h.controller.setAutomaticDiagnostics(true);
      await h.mount(tester);
      h.transport.failureStatus = 503;
      await _tapDiagnostic(tester, 'diagnostics-send-report');
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      await _tapDiagnostic(tester, 'diagnostics-send-report');
      await tester.pumpAndSettle();
      expect(h.controller.automaticDiagnostics, isTrue);
      expect(h.controller.diagnosticCanRetry, isFalse);
      expect(h.controller.diagnosticReport, isNotNull);
      final requests = h.transport.requests.length;
      await h.controller.onAppResumed();
      await tester.pump();
      expect(h.transport.requests, hasLength(requests));
    },
  );

  _diagnosticsTest('export uses the local report without sending it', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    await _tapDiagnostic(tester, 'run-diagnostics');
    await tester.pumpAndSettle();
    await _tapDiagnostic(tester, 'export-diagnostic-report');
    await tester.pumpAndSettle();
    expect(h.tunnel.exports, [h.controller.diagnosticReport!.json]);
    expect(h.transport.requests, isEmpty);
    h.tunnel.exportFails = true;
    await _tapDiagnostic(tester, 'export-diagnostic-report');
    await tester.pumpAndSettle();
    expect(
      find.text('L’export a échoué. Réessayez depuis le rapport local.'),
      findsOneWidget,
    );
    expect(h.controller.diagnosticReport, isNotNull);
  });

  _diagnosticsTest('preparation errors are visible without a report', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    h.tunnel.metadataFails = true;
    await _tapDiagnostic(tester, 'run-diagnostics');
    await tester.pumpAndSettle();
    expect(h.controller.diagnosticReport, isNull);
    expect(
      find.text('Le diagnostic n’a pas pu être préparé. Réessayez.'),
      findsOneWidget,
    );
    expect(h.transport.requests, isEmpty);
  });

  _diagnosticsTest('local diagnostics remain available while signed out', (
    tester,
    h,
  ) async {
    await h.controller.signOut();
    h.tunnel.destructiveCalls = 0;
    await h.mount(tester);
    expect(
      tester
          .widget<CheckboxListTile>(
            find.byKey(const ValueKey('diagnostics-send-report')),
          )
          .onChanged,
      isNull,
    );
    await _tapDiagnostic(tester, 'run-diagnostics');
    await tester.pumpAndSettle();
    expect(h.controller.diagnosticReport, isNotNull);
    expect(h.transport.requests, isEmpty);
    expect(h.tunnel.destructiveCalls, 0);
  });

  _diagnosticsTest(
    'account settings expose independent consent and reset the manual checkbox when reopened',
    (tester, h) async {
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Compte'));
      await tester.pumpAndSettle();
      final automatic = find.byKey(
        const ValueKey('automatic-diagnostics-toggle'),
      );
      await _ensureDiagnosticVisible(tester, automatic);
      await tester.pumpAndSettle();
      expect(tester.widget<SwitchListTile>(automatic).value, isFalse);
      await tester.tap(automatic);
      await tester.pumpAndSettle();
      expect(h.preferences.automatic, isTrue);
      await _tapDiagnostic(tester, 'open-diagnostics');
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<CheckboxListTile>(
              find.byKey(const ValueKey('diagnostics-send-report')),
            )
            .value,
        isFalse,
      );
      await _tapDiagnostic(tester, 'diagnostics-send-report');
      h.transport.failureStatus = 503;
      await _tapDiagnostic(tester, 'run-diagnostics');
      await tester.pumpAndSettle();
      final report = h.controller.diagnosticReport;
      expect(report, isNotNull);
      expect(h.transport.requests, hasLength(1));
      Navigator.of(tester.element(find.byType(DiagnosticsPage))).pop();
      await tester.pumpAndSettle();
      await _tapDiagnostic(tester, 'open-diagnostics');
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<CheckboxListTile>(
              find.byKey(const ValueKey('diagnostics-send-report')),
            )
            .value,
        isFalse,
      );
      expect(h.controller.automaticDiagnostics, isTrue);
      expect(h.controller.diagnosticReport, same(report));
      h.milliseconds += 61000;
      h.transport.failureStatus = null;
      await h.controller.onAppResumed();
      await tester.pumpAndSettle();
      expect(h.controller.diagnosticCanRetry, isFalse);
      expect(h.transport.requests, hasLength(1));
    },
  );

  _diagnosticsTest(
    'a failed automatic preference write stays off and explains the failure',
    (tester, h) async {
      h.preferences.failWrite = true;
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Compte'));
      await tester.pumpAndSettle();
      await _tapDiagnostic(tester, 'automatic-diagnostics-toggle');
      await tester.pumpAndSettle();
      expect(h.controller.automaticDiagnostics, isFalse);
      expect(
        find.text('Ce réglage n’a pas pu être enregistré. Réessayez.'),
        findsOneWidget,
      );
      expect(h.transport.requests, isEmpty);
    },
  );

  _diagnosticsTest('device management appears before personalization', (
    tester,
    h,
  ) async {
    tester.view.physicalSize = const Size(600, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      FuzeVpnApp(controller: h.controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Compte'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('account-devices'))).dy,
      lessThan(tester.getTopLeft(find.text('À votre goût')).dy),
    );
  });

  for (final (protection, message) in <(SystemVpnProtection, String)>[
    (const SystemVpnProtection(), 'Protection système à vérifier'),
    (
      const SystemVpnProtection(alwaysOn: false, lockdown: false),
      'Protection système inactive',
    ),
    (
      const SystemVpnProtection(alwaysOn: true, lockdown: false),
      'VPN permanent activé, blocage hors VPN à activer',
    ),
    (
      const SystemVpnProtection(alwaysOn: true, lockdown: true),
      'Protection système active',
    ),
  ]) {
    _diagnosticsTest('Android protection keeps the observed status: $message', (
      tester,
      h,
    ) async {
      h.controller.tunnelState = h.controller.tunnelState.copyWith(
        systemProtection: protection,
      );
      await tester.pumpWidget(
        FuzeVpnApp(controller: h.controller, autoInitialize: false),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Compte'));
      await tester.pumpAndSettle();
      await _ensureDiagnosticVisible(
        tester,
        find.byKey(const ValueKey('protection-guide-info')),
      );
      expect(find.text(message), findsOneWidget);
      await _tapDiagnostic(tester, 'protection-guide-info');
      await tester.pumpAndSettle();
      expect(h.controller.systemProtection.alwaysOn, protection.alwaysOn);
      expect(h.controller.systemProtection.lockdown, protection.lockdown);
      expect(h.tunnel.settingsOpens, 0);
      expect(h.tunnel.destructiveCalls, 0);
      await _tapDiagnostic(tester, 'protection-guide-close');
      await tester.pumpAndSettle();
      await _tapDiagnostic(tester, 'protection-open-settings');
      await tester.pumpAndSettle();
      expect(h.tunnel.settingsOpens, 1);
      expect(h.tunnel.destructiveCalls, 0);
    });
  }

  for (final language in ['fr', 'en', 'es', 'de']) {
    _diagnosticsTest(
      'protection guide stays readable at 320dp and 200% ($language)',
      (tester, h) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await h.controller.setLocale(Locale(language));
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        final copy = AppLocalizations.of(
          tester.element(find.byType(HomeShell)),
        );
        await tester.tap(find.text(copy.nav_account));
        await tester.pumpAndSettle();
        await _tapDiagnostic(tester, 'protection-guide-info');
        await tester.pumpAndSettle();
        expect(find.byType(BottomSheet), findsOneWidget);
        expect(h.tunnel.settingsOpens, 0);
        for (final text in [
          copy.protection_guideWarning,
          copy.protection_guideStep3,
          copy.protection_guideDisable,
          copy.protection_guideManual,
        ]) {
          await tester.ensureVisible(find.text(text));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
        await _tapDiagnostic(tester, 'protection-guide-open-settings');
        await tester.pumpAndSettle();
        expect(find.byType(BottomSheet), findsNothing);
        expect(h.tunnel.settingsOpens, 1);
        expect(h.tunnel.destructiveCalls, 0);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final language in ['fr', 'en', 'es', 'de']) {
    _diagnosticsTest(
      'account preferences and language flags fit 320dp at 200% ($language)',
      (tester, h) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await h.controller.setLocale(Locale(language));
        await tester.pumpWidget(
          FuzeVpnApp(controller: h.controller, autoInitialize: false),
        );
        await tester.pumpAndSettle();
        final copy = AppLocalizations.of(
          tester.element(find.byType(HomeShell)),
        );
        await tester.tap(find.text(copy.nav_account));
        await tester.pumpAndSettle();
        await _tapDiagnostic(tester, 'language-settings');
        await tester.pumpAndSettle();
        final flags = tester
            .widgetList<CountryFlag>(
              find.descendant(
                of: find.byType(BottomSheet),
                matching: find.byType(CountryFlag),
              ),
            )
            .map((flag) => flag.countryCode)
            .toSet();
        expect(
          flags,
          AppLanguages.all.map((language) => language.flag).toSet(),
        );
        final german = find.byKey(const ValueKey('language-de'));
        await tester.ensureVisible(german);
        await tester.pumpAndSettle();
        await tester.tap(german);
        await tester.pumpAndSettle();
        expect(h.controller.locale, const Locale('de'));
        expect(find.byType(BottomSheet), findsNothing);
        await _tapDiagnostic(tester, 'appearance-settings');
        await tester.pumpAndSettle();
        final dark = find.byKey(const ValueKey('theme-dark'));
        await tester.ensureVisible(dark);
        await tester.pumpAndSettle();
        await tester.tap(dark);
        await tester.pumpAndSettle();
        expect(h.controller.themeMode, ThemeMode.dark);
        expect(find.byType(BottomSheet), findsNothing);
        await _tapDiagnostic(tester, 'language-settings');
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.byKey(const ValueKey('language-system')),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('language-system')));
        await tester.pumpAndSettle();
        expect(h.controller.locale, isNull);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final language in AppLanguages.all) {
    for (final theme in [ThemeMode.light, ThemeMode.dark]) {
      _diagnosticsTest(
        'diagnostics fit 320dp and 200% text (${language.tag}, ${theme.name})',
        (tester, h) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.view.devicePixelRatio = 1;
          tester.platformDispatcher.textScaleFactorTestValue = 2;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          await h.mount(tester, locale: language.locale, theme: theme);
          await _tapDiagnostic(tester, 'run-diagnostics');
          await tester.pumpAndSettle();
          await _tapDiagnostic(tester, 'diagnostic-technical-details');
          await tester.pumpAndSettle();
          for (final key in [
            'diagnostics-send-report',
            'run-diagnostics',
            'export-diagnostic-report',
          ]) {
            final control = find.byKey(ValueKey(key));
            await _ensureDiagnosticVisible(tester, control);
            await tester.pumpAndSettle();
            expect(control.hitTestable(), findsOneWidget);
          }
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
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
  final finder = find.byKey(ValueKey(key));
  await _ensureDiagnosticVisible(tester, finder);
  await tester.tap(finder);
}

Future<void> _ensureDiagnosticVisible(
  WidgetTester tester,
  Finder finder,
) async {
  if (finder.evaluate().isEmpty) {
    final scrollable = find.byType(Scrollable).first;
    tester.state<ScrollableState>(scrollable).position.jumpTo(0);
    await tester.pump();
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
      sessionStore: store,
      preferences: preferences,
      tunnel: tunnel,
      diagnostics: service,
    );
  }
  final transport = _DiagnosticTransport();
  final preferences = _DiagnosticPreferences();
  final store = _DiagnosticStore();
  final tunnel = _DiagnosticTunnel();
  int milliseconds = 0;
  late final DiagnosticService service;
  late final VpnAppController controller;
  Future<void> mount(
    WidgetTester tester, {
    Locale locale = const Locale('fr'),
    ThemeMode theme = ThemeMode.light,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        theme: FuzeVpnTheme.light(),
        darkTheme: FuzeVpnTheme.dark(),
        themeMode: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DiagnosticsPage(controller: controller),
      ),
    );
    await tester.pumpAndSettle();
  }
}

class _DiagnosticTransport extends ApiHttpTransport {
  final requests = <ApiHttpRequest>[];
  Future<ApiHttpResponse>? pending;
  int? failureStatus;
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests.add(request);
    if (pending != null) return pending!;
    if (failureStatus != null) {
      return ApiHttpResponse(
        statusCode: failureStatus!,
        headers: const {},
        body: '{"error":"server_error"}',
      );
    }
    return accepted(request);
  }

  ApiHttpResponse accepted(ApiHttpRequest request) {
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
  bool automatic = false;
  bool failWrite = false;
  @override
  Future<bool> readAutomaticDiagnostics() async => automatic;
  @override
  Future<void> writeAutomaticDiagnostics(bool enabled) async {
    if (failWrite) {
      throw const NativeVpnException('secure_storage_write_failed');
    }
    automatic = enabled;
  }

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
  Future<VpnRuntimeState>? pendingState;
  bool metadataFails = false;
  bool exportFails = false;
  int destructiveCalls = 0;
  int settingsOpens = 0;
  int businessReads = 0;
  int snapshotReads = 0;
  Future<void> dispose() => events.close();

  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async {
    businessReads++;
    return const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  }

  @override
  Future<VpnRuntimeState> diagnosticSnapshot() async {
    snapshotReads++;
    return pendingState == null
        ? const VpnRuntimeState(phase: VpnRuntimePhase.idle)
        : await pendingState!;
  }

  @override
  Future<SystemVpnProtection> getSystemVpnProtection() async =>
      const SystemVpnProtection(alwaysOn: false, lockdown: false);
  @override
  Future<Map<String, Object?>> diagnosticMetadata() async {
    if (metadataFails) {
      throw const NativeVpnException('diagnostic_metadata_unavailable');
    }
    return {
      'app_version': '1.0.0',
      'app_build': 1,
      'environment': {
        'os_family': 'android',
        'architecture': 'arm64',
        'android_sdk': 35,
        'network_type': 'wifi',
        'build_mode': 'debug',
      },
    };
  }

  @override
  Future<bool> exportDiagnosticReport(String json) async {
    if (exportFails) throw const NativeVpnException('diagnostic_export_failed');
    exports.add(json);
    return true;
  }

  @override
  Future<void> disconnect() async {
    destructiveCalls++;
  }

  @override
  Future<void> disconnectByUser() async {
    destructiveCalls++;
  }

  @override
  Future<void> openVpnSettings() async {
    settingsOpens++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
