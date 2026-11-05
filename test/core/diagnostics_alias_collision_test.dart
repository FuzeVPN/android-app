// A13-03 (review round 1): diagnosticCodeAliases is one global table. It is
// applied to every recorded code, including the API machine codes that
// VpnAppController._setNotice records (domain 'api') and the controller codes
// that _controllerNotice records (domain 'client'). A native alias must never
// requalify an API code, and a controller code shares an alias only when the
// meaning is the same, as written here.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostic_codes.dart';
import 'package:fuzevpn_android/core/diagnostic_schema.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

// Controller codes that deliberately share an alias, with the category the
// controller's own diagnostic reference or meaning requires.
const _sharedControllerAliases = <String, String>{
  // Same refusal as the native one: the user declined the VPN permission.
  'vpn_permission_denied': 'permission_denied',
  // The notice shows the reference APP-OVPN-RENEW · renewal_unexpected.
  'openvpn_renewal_unexpected': 'renewal_unexpected',
};

Map<String, dynamic> _arb() =>
    (jsonDecode(File('lib/l10n/translations/en.json').readAsStringSync())
            as Map<String, dynamic>)['arb']
        as Map<String, dynamic>;

Set<String> _selectorCodes(String key) {
  final text = _arb()[key] as String;
  final body = text.substring(text.indexOf('select,') + 'select,'.length);
  return RegExp(r'(?:^|\})\s*([a-z][a-z0-9_]*)\s*\{')
      .allMatches(body)
      .map((match) => match[1]!)
      .where((code) => code != 'other')
      .toSet();
}

/// Every API machine code the client knows: localized selectors, the codes
/// ApiErrorMessages translates or delays, and client-built API exceptions.
Set<String> _apiCodes() {
  final source = File('lib/core/api_exception.dart').readAsStringSync();
  final messages = source.substring(
    source.indexOf('abstract final class ApiErrorMessages'),
    source.indexOf('bool _isStableCode'),
  );
  final retry = messages.substring(
    messages.indexOf('_retryCodes = <String>{'),
    messages.indexOf('};'),
  );
  final codes = <String>{
    ..._selectorCodes('notice_api_title'),
    ..._selectorCodes('notice_api_message'),
    for (final match in RegExp(
      r"'([a-z][a-z0-9_]*)'\s*(?:=>|\|\|)",
    ).allMatches(messages))
      match[1]!,
    for (final match in RegExp(r"'([a-z][a-z0-9_]*)'").allMatches(retry))
      match[1]!,
  };
  for (final entity in Directory('lib').listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    for (final match in RegExp(
      r"errorCode:\s*'([a-z][a-z0-9_]*)'",
    ).allMatches(entity.readAsStringSync())) {
      codes.add(match[1]!);
    }
  }
  return codes;
}

String _controllerSources() => [
  for (final entity in Directory('lib').listSync())
    if (entity is File &&
        RegExp(r'app_controller[a-z_]*\.dart$').hasMatch(entity.path))
      entity.readAsStringSync(),
].join('\n');

Set<String> _controllerCodes() {
  final source = _controllerSources();
  return <String>{
    ..._selectorCodes('notice_controller_title'),
    ..._selectorCodes('notice_controller_message'),
    for (final match in RegExp(
      r"(?:_controllerNotice|_ControllerFailure)\(\s*'([a-z][a-z0-9_]*)'",
    ).allMatches(source))
      match[1]!,
  };
}

void main() {
  test('A13-03 the API code inventory is read from the real sources', () {
    final api = _apiCodes();
    // Known API codes, including the review's counterexamples.
    for (final code in [
      'invalid_profile',
      'invalid_token',
      'invalid_registration',
      'invalid_or_expired_token',
      'openvpn_state_signer_unavailable',
      'verification_email_cooldown',
      'unauthorized',
    ]) {
      expect(api, contains(code));
    }
    expect(api, isNot(contains('other')));
    final controller = _controllerCodes();
    for (final code in [
      'vpn_permission_denied',
      'openvpn_renewal_unexpected',
      'identity_renewal_unexpected',
      'tunnel_start_unexpected',
    ]) {
      expect(controller, contains(code));
    }
  });

  test('A13-03 no alias key is an API machine code', () {
    final collisions = diagnosticCodeAliases.keys.toSet().intersection(
      _apiCodes(),
    );
    expect(collisions, isEmpty, reason: 'aliases that requalify API codes');
  });

  test('A13-03 an alias key is a controller code only with the same '
      'meaning', () {
    final controller = _controllerCodes();
    for (final code in diagnosticCodeAliases.keys) {
      if (!controller.contains(code)) continue;
      expect(_sharedControllerAliases, contains(code), reason: code);
    }
    for (final entry in _sharedControllerAliases.entries) {
      expect(controller, contains(entry.key));
      expect(diagnosticCodes, contains(entry.value));
      expect(diagnosticCode(entry.key), entry.value, reason: entry.key);
    }
  });

  test('A13-03 every controller diagnostic reference is the recorded '
      'category', () {
    final source = _controllerSources();
    // _controllerNotice records its own code when it carries a reference.
    expect(
      source,
      matches(
        RegExp(
          r"AppNotice _controllerNotice\([^)]*\)\s*\{\s*"
          r"if \(diagnosticCode != null\) "
          r"_recordDiagnosticError\(code, domain: 'client'\);",
        ),
      ),
    );
    final references = <String, String>{
      for (final match in RegExp(
        r"_controllerNotice\(\s*'([a-z][a-z0-9_]*)',\s*"
        r"diagnosticCode:\s*'[^'$]*·\s*([a-z][a-z0-9_]*)',?\s*\)",
      ).allMatches(source))
        match[1]!: match[2]!,
    };
    expect(
      references,
      containsPair('openvpn_renewal_unexpected', 'renewal_unexpected'),
    );
    expect(references.length, greaterThanOrEqualTo(6));
    for (final entry in references.entries) {
      expect(diagnosticCodes, contains(entry.value), reason: entry.key);
      expect(diagnosticCode(entry.key), entry.value, reason: entry.key);
    }
  });

  test('A13-03 openvpn_renewal_unexpected is reported as renewal_unexpected '
      'without a new automatic report', () async {
    final transport = _RecordingTransport();
    final service = _service(transport, automatic: true);
    addTearDown(service.dispose);
    service.recordError(
      'openvpn_renewal_unexpected',
      domain: 'client',
      stage: 'certificate_renewal',
      operation: 'renew',
    );
    await service.retryPending();
    expect(transport.bodies, isEmpty);
    final report = service
        .prepareFull(
          snapshot: const {},
          state: 'error',
          protocol: 'openvpn',
          checks: const [],
        )
        .toJson();
    expect((report['error'] as Map)['code'], 'renewal_unexpected');
    expect(jsonEncode(report), isNot(contains('openvpn_renewal_unexpected')));
  });

  test('A13-03 the real controller records every API failure code without '
      'native requalification', () async {
    final codes = _apiCodes().toList()..sort();
    final wrong = <String>[];
    for (final code in codes) {
      final fixture = _ControllerFixture(code);
      try {
        await fixture.controller.refreshLocations();
        final expected = diagnosticCodes.contains(code)
            ? code
            : 'unknown_error';
        final report = fixture.service
            .prepareFull(
              snapshot: const {},
              state: 'error',
              protocol: 'openvpn',
              checks: const [],
            )
            .toJson();
        final recorded = (report['error'] as Map)['code'];
        final events = (report['events'] as List)
            .where((event) => (event as Map)['source'] == 'api')
            .map((event) => (event as Map)['code'])
            .toList();
        if (recorded != expected || events.any((c) => c != expected)) {
          wrong.add('$code -> $recorded $events');
        }
        expect(fixture.transport.requests, 0);
      } finally {
        await fixture.dispose();
      }
    }
    expect(wrong, isEmpty);
  });

  for (final code in ['invalid_profile', 'invalid_token']) {
    test('A13-03 review counterexample: API $code through _setNotice stays '
        'unknown_error', () async {
      final fixture = _ControllerFixture(code);
      addTearDown(fixture.dispose);
      await fixture.controller.refreshLocations();
      expect(fixture.controller.notice?.arguments['code'], code);
      final report = fixture.service
          .prepareFull(
            snapshot: const {},
            state: 'error',
            protocol: 'openvpn',
            checks: const [],
          )
          .toJson();
      expect((report['error'] as Map)['code'], 'unknown_error');
      expect(jsonEncode(report), isNot(contains('system_vpn_resume')));
    });
  }

  test('A13-03 API failures that are not v1 codes never trigger an automatic '
      'report', () async {
    final triggered = <String>[];
    for (final code in _apiCodes()) {
      if (diagnosticCodes.contains(code)) continue;
      final transport = _RecordingTransport();
      final service = _service(transport, automatic: true);
      try {
        service.recordError(
          code,
          domain: 'api',
          stage: 'api',
          operation: 'refresh',
          httpStatus: 422,
        );
        await service.retryPending();
        if (transport.bodies.isNotEmpty) {
          triggered.add(
            '$code -> ${(transport.bodies.single['error'] as Map)['code']}',
          );
        }
      } finally {
        service.dispose();
      }
    }
    expect(triggered, isEmpty);
    // Witness: an important v1 API code still reports automatically.
    final transport = _RecordingTransport();
    final service = _service(transport, automatic: true);
    addTearDown(service.dispose);
    service.recordError(
      'invalid_api_response',
      domain: 'api',
      stage: 'api',
      operation: 'refresh',
      httpStatus: 502,
    );
    await service.retryPending();
    expect(transport.bodies, hasLength(1));
  });
}

DiagnosticService _service(
  ApiHttpTransport transport, {
  bool automatic = false,
}) {
  final service = DiagnosticService(
    transport: transport,
    baseUri: Uri.parse('https://synthetic.invalid'),
    scheduleRetries: false,
  );
  service.setMetadata({'app_version': '1.2.3'});
  if (automatic) {
    service.setSession(
      accountId: 'synthetic-account',
      token: 'synthetic-token',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
    );
    service.setAutomaticConsent(true);
  }
  return service;
}

class _ControllerFixture {
  _ControllerFixture(String code) {
    service = DiagnosticService(
      transport: transport,
      baseUri: Uri.parse('https://synthetic.invalid'),
      scheduleRetries: false,
    );
    service.setMetadata({'app_version': '1.2.3'});
    controller = VpnAppController(
      api: _FailingApi(code),
      sessionStore: _NoData(),
      preferences: _NoData(),
      tunnel: tunnel,
      diagnostics: service,
    );
  }

  final transport = _OfflineTransport();
  final tunnel = _Tunnel();
  late final DiagnosticService service;
  late final VpnAppController controller;

  Future<void> dispose() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _RecordingTransport extends ApiHttpTransport {
  final bodies = <Map<String, dynamic>>[];

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    final body = jsonDecode(request.body!) as Map<String, dynamic>;
    bodies.add(body);
    return ApiHttpResponse(
      statusCode: 201,
      headers: const {},
      body: jsonEncode({
        'status': 'received',
        'duplicate': false,
        'report_id': 'a1000000-0000-4000-8000-000000000099',
        'client_report_id': body['report_id'],
        'received_at': '2026-09-23T00:00:00Z',
        'expires_at': '2026-10-23T00:00:00Z',
      }),
    );
  }
}

class _OfflineTransport extends ApiHttpTransport {
  int requests = 0;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests++;
    throw StateError('No diagnostic must be submitted');
  }
}

class _FailingApi implements VpnApiRepository {
  _FailingApi(this.code);
  final String code;

  @override
  Future<List<Location>> locations() => Future<List<Location>>.error(
    ApiException(statusCode: 422, errorCode: code),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Tunnel implements VpnTunnelGateway {
  final events = StreamController<VpnRuntimeState>.broadcast(sync: true);

  Future<void> close() => events.close();

  @override
  Stream<VpnRuntimeState> get states => events.stream;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _NoData implements SecureSessionStore, AppPreferenceStore {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
