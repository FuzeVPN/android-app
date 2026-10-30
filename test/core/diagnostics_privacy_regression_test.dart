import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostic_codes.dart';
import 'package:fuzevpn_android/core/diagnostic_schema.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

class _OfflineTransport extends ApiHttpTransport {
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async =>
      throw StateError('This test must not submit a diagnostic');
}

class _Api implements VpnApiRepository {
  @override
  Future<List<Location>> locations() async => [];
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Store implements SecureSessionStore {
  @override
  Future<AuthSession?> readSession() async => null;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Tunnel implements VpnTunnelGateway, DiagnosticPlatformGateway {
  final exports = <String>[];
  @override
  Stream<VpnRuntimeState> get states => const Stream.empty();
  @override
  Future<VpnRuntimeState> getState() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  Future<VpnRuntimeState> diagnosticSnapshot() => getState();
  @override
  Future<Map<String, Object?>> diagnosticMetadata() async => {
    'app_version': '1.2.3',
  };
  @override
  Future<bool> exportDiagnosticReport(String json) async {
    exports.add(json);
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Models the native privacy gate, separately durable from encrypted cleanup.
/// Native persistence and failed-commit behavior are covered by JVM tests.
class _Preferences implements AppPreferenceStore, DiagnosticPreferenceStore {
  bool encryptedConsent = true;
  bool denied = false;
  bool failEncryptedWrite = false;
  @override
  Future<bool> readAutomaticDiagnostics() async => !denied && encryptedConsent;
  @override
  Future<void> writeAutomaticDiagnostics(bool value) async {
    if (!value) {
      denied = true;
      // Revocation remains effective even if the old ciphertext cannot clear.
      if (!failEncryptedWrite) encryptedConsent = false;
      return;
    }
    if (failEncryptedWrite) {
      throw StateError('synthetic encrypted write failure');
    }
    encryptedConsent = true;
    denied = false;
  }

  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => null;
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

DiagnosticService _service({int Function()? tick}) => DiagnosticService(
  transport: _OfflineTransport(),
  baseUri: Uri.parse('https://synthetic.invalid'),
  monotonicMilliseconds: tick,
);

void main() {
  test(
    'expired local-only report disappears on direct access without a queue',
    () {
      var tick = 0;
      final service = _service(tick: () => tick);
      addTearDown(service.dispose);
      service.setMetadata({'app_version': '1.2.3'});
      final report = service.prepareFull(
        snapshot: const {},
        state: 'disconnected',
      );
      tick = DiagnosticService.queueTtlMs - 1;
      expect(service.preparedReport, same(report));
      tick++;
      expect(service.preparedReport, isNull);
    expect(service.status, DiagnosticStatus.idle);
    },
  );

  test('controller cannot export a report after its local lifetime', () async {
    var tick = 0;
    final tunnel = _Tunnel();
    final controller = VpnAppController(
      api: _Api(),
      sessionStore: _Store(),
      preferences: _Preferences(),
      tunnel: tunnel,
      diagnostics: _service(tick: () => tick),
    );
    addTearDown(controller.dispose);
    await controller.runDiagnostics(sendReport: false);
    expect(controller.canExportDiagnosticReport, isTrue);
    tick = DiagnosticService.queueTtlMs;
    await controller.exportDiagnosticReport();
    expect(tunnel.exports, isEmpty);
    expect(controller.diagnosticReport, isNull);
    expect(controller.canExportDiagnosticReport, isFalse);
  });

  test(
    'durable refusal survives cleanup failure and controller restart',
    () async {
      final preferences = _Preferences();
      VpnAppController controller() => VpnAppController(
        api: _Api(),
        sessionStore: _Store(),
        preferences: preferences,
        tunnel: _Tunnel(),
        diagnostics: _service(),
      );
      final first = controller();
      await first.initialize();
      await Future<void>.delayed(Duration.zero);
      expect(first.automaticDiagnostics, isTrue);
      preferences.failEncryptedWrite = true;
      await first.setAutomaticDiagnostics(false);
      expect(first.automaticDiagnostics, isFalse);
      expect(preferences.encryptedConsent, isTrue);
      first.dispose();

      final second = controller();
      addTearDown(second.dispose);
      await second.initialize();
      await Future<void>.delayed(Duration.zero);
      expect(second.automaticDiagnostics, isFalse);
      await second.setAutomaticDiagnostics(true);
      expect(second.diagnosticsPreferenceFailed, isTrue);
      expect(second.automaticDiagnostics, isFalse);
      expect(await preferences.readAutomaticDiagnostics(), isFalse);
      preferences.failEncryptedWrite = false;
      await second.setAutomaticDiagnostics(true);
      expect(second.automaticDiagnostics, isTrue);
      expect(await preferences.readAutomaticDiagnostics(), isTrue);
    },
  );

  test(
    'native aliases retain useful categories within the v1 wire registry',
    () {
      final service = _service();
      addTearDown(service.dispose);
      service.setMetadata({'app_version': '1.2.3'});
      for (final entry in diagnosticCodeAliases.entries) {
        expect(diagnosticCodes, contains(entry.value));
        service.recordError(entry.key, domain: 'tunnel', protocol: 'openvpn');
        final report = service.prepareFull(
          snapshot: const {},
          state: 'error',
          protocol: 'openvpn',
          checks: [
            {'id': 'tunnel_connection', 'result': 'failed', 'code': entry.key},
          ],
        );
        expect((report.toJson()['error'] as Map)['code'], entry.value);
        expect(
          ((report.toJson()['checks'] as List).single as Map)['code'],
          entry.value,
        );
        expect(
          ((report.toJson()['events'] as List).last as Map)['code'],
          entry.value,
        );
      }
      for (final privateValue in [
        'private_key_synthetic_0123456789',
        'user@example.invalid',
        'https://private.invalid',
        'openvpn_credentials_required_secret',
        'OPENVPN_CREDENTIALS_REQUIRED',
        '',
        null,
      ]) {
        expect(diagnosticCode(privateValue), 'unknown_error');
      }
    },
  );
}
