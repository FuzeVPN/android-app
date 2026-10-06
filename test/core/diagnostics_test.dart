import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';

class _Clock {
  int milliseconds = 0;
  DateTime now() =>
      DateTime.utc(2026, 9, 23).add(Duration(milliseconds: milliseconds));
  void advance(Duration duration) => milliseconds += duration.inMilliseconds;
}

class _Transport extends ApiHttpTransport {
  final requests = <ApiHttpRequest>[];
  FutureOr<ApiHttpResponse> Function(ApiHttpRequest)? respond;
  bool closed = false;
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests.add(request);
    return await (respond?.call(request) ?? _received(request));
  }

  @override
  void close() => closed = true;
}

ApiHttpResponse _received(ApiHttpRequest request, {bool duplicate = false}) {
  final body = jsonDecode(request.body!) as Map<String, dynamic>;
  return ApiHttpResponse(
    statusCode: duplicate ? 200 : 201,
    headers: const {},
    body: jsonEncode({
      'status': 'received',
      'duplicate': duplicate,
      'report_id': 'a1000000-0000-4000-8000-000000000099',
      'client_report_id': body['report_id'],
      'received_at': '2026-09-23T00:00:00Z',
      'expires_at': '2026-10-23T00:00:00Z',
    }),
  );
}

ApiHttpResponse _failure(int status, String code, {String? retryAfter}) =>
    ApiHttpResponse(
      statusCode: status,
      headers: {if (retryAfter != null) 'Retry-After': retryAfter},
      body: jsonEncode({
        'error': code,
        'message': 'private raw exception and token',
      }),
    );

DiagnosticService _service(
  _Transport transport,
  _Clock clock, {
  bool session = true,
}) {
  final service = DiagnosticService(
    transport: transport,
    baseUri: Uri.parse('https://api.example.test/'),
    now: clock.now,
    monotonicMilliseconds: () => clock.milliseconds,
    scheduleRetries: false,
  );
  addTearDown(service.dispose);
  service.setMetadata({
    'app_version': '1.2.3-beta.2',
    'app_build': 98765,
    'environment': {
      'os_family': 'android',
      'android_sdk': 36,
      'architecture': 'arm64',
      'build_mode': 'release',
      'network_type': 'wifi',
    },
  });
  if (session) {
    service.setSession(
      accountId: 'private-account-a',
      token: 'private-token-a',
      expiresAt: clock.now().add(const Duration(days: 2)),
    );
  }
  return service;
}

DiagnosticReport _full(DiagnosticService service) => service.prepareFull(
  snapshot: const {'always_on': false, 'bytes_sent': 0},
  state: 'error',
  protocol: 'openvpn',
);

void main() {
  test(
    'allowlist drops raw private input and preserves unknown versus false',
    () {
      final service = _service(_Transport(), _Clock());
      service.recordError(
        'secret-user@example.test',
        operation: 'https://private.test',
        stage: '/private/path',
        domain: 'private-domain',
        httpStatus: 999,
      );
      service.recordEvent(
        source: 'private-host',
        stage: 'raw-stack',
        event: 'raw-message',
        code: 'secret-token',
        spanId: 50000,
      );
      final report = service.prepareFull(
        state: 'raw-state',
        protocol: 'private-host',
        snapshot: {
          'always_on': false,
          'lockdown': null,
          'bytes_sent': 0,
          'bytes_received': -1,
          'ip_families': ['ipv4', 'private-ip'],
          'email': 'secret-user@example.test',
          'url': 'https://private.test',
        },
        checks: [
          {
            'id': 'private-check',
            'result': 'raw-result',
            'message': 'secret-token',
            'code': 'secret-token',
            'duration_ms': -1,
          },
        ],
      );
      final json = report.toJson();
      final snapshot = json['snapshot']! as Map<String, dynamic>;
      expect(snapshot, {'always_on': false, 'bytes_sent': 0});
      expect(json['app_version'], '1.2.3-beta.2');
      expect(json['app_build'], 98765);
      expect((json['error']! as Map)['code'], 'unknown_error');
      expect(json['state'], 'unknown');
      for (final secret in [
        'secret-',
        'private-',
        'raw-',
        'https://',
        '@example',
      ]) {
        expect(report.json, isNot(contains(secret)));
      }
      expect(
        report.reportId,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
      final frozen = report.json;
      snapshot['always_on'] = true;
      expect(report.json, frozen);
    },
  );

  test(
    'full collection works offline but cannot send or transfer after login',
    () async {
      final transport = _Transport();
      final service = _service(transport, _Clock(), session: false);
      final report = _full(service);
      await service.sendManual(report);
      expect(service.lastFailure?.code, 'session_required');
      expect(service.status, DiagnosticStatus.authenticationRequired);
      expect(transport.requests, isEmpty);
      service.setSession(
        accountId: 'private-account-a',
        token: 'private-token-a',
      );
      expect(service.preparedReport, isNull);
      await service.sendManual(report);
      expect(service.lastFailure?.code, 'report_account_changed');
      expect(transport.requests, isEmpty);
    },
  );

  test(
    'missing or invalid real app metadata is not replaced with a fake version',
    () {
      final service = _service(_Transport(), _Clock());
      for (final version in [
        null,
        'Product 1.2.3',
        '1.2.3\n',
        '1.02.3',
        'user@example.test',
      ]) {
        service.setMetadata({'app_version': version});
        expect(
          () => _full(service),
          throwsA(
            isA<DiagnosticFailure>().having(
              (error) => error.code,
              'code',
              'metadata_unavailable',
            ),
          ),
        );
      }
    },
  );

  test(
    'opt out still records manual observations without any automatic request',
    () async {
      final transport = _Transport();
      final service = _service(transport, _Clock());
      service.recordError(
        'openvpn_core_unavailable',
        domain: 'tunnel',
        operation: 'connect',
      );
      await service.retryPending();
      expect(transport.requests, isEmpty);
      expect(
        (_full(service).toJson()['error']! as Map)['code'],
        'openvpn_core_unavailable',
      );
    },
  );

  test(
    'only important auto errors send and never overwrite the manual UI',
    () async {
      final transport = _Transport();
      final clock = _Clock();
      final service = _service(transport, clock);
      final manual = _full(service);
      service.setAutomaticConsent(true);
      for (final code in [
        'network_unavailable',
        'network_timeout',
        'unauthorized',
        'invalid_credentials',
        'permission_denied',
        'openvpn_operation_pending',
      ]) {
        service.recordError(code);
      }
      await service.retryPending();
      expect(transport.requests, isEmpty);
      service.recordError(
        'tls_handshake_failed',
        operation: 'connect',
        domain: 'tunnel',
      );
      await service.retryPending();
      expect(transport.requests, hasLength(1));
      final body =
          jsonDecode(transport.requests.single.body!) as Map<String, dynamic>;
      expect(body['report_type'], 'simple');
      expect(body['consent'], {
        'mode': 'automatic_opt_in',
        'notice_version': 1,
      });
      expect(
        (body['environment']! as Map).containsKey('network_type'),
        isFalse,
      );
      expect(body.containsKey('events'), isFalse);
      expect(body['truncated'], isFalse);
      expect(body['dropped_events'], 0);
      expect(service.preparedReport, same(manual));
      expect(service.status, DiagnosticStatus.prepared);
      expect(service.lastReceipt, isNull);
    },
  );

  test(
    'retry preserves exact frozen report and duplicate success validates both IDs',
    () async {
      final transport = _Transport();
      final clock = _Clock();
      final service = _service(transport, clock);
      transport.respond = (_) =>
          throw StateError('private transport credentials');
      final report = _full(service);
      await service.sendManual(report);
      expect(service.status, DiagnosticStatus.queued);
      expect(service.lastFailure.toString(), isNot(contains('private')));
      clock.advance(const Duration(minutes: 2));
      transport.respond = (request) => _received(request, duplicate: true);
      await service.retryManual();
      expect(transport.requests, hasLength(2));
      expect(transport.requests[0].body, transport.requests[1].body);
      expect(service.lastReceipt?.clientReportId, report.reportId);
      expect(service.lastReceipt?.serverReportId, isNot(report.reportId));
      expect(service.lastReceipt?.duplicate, isTrue);
      expect(service.status, DiagnosticStatus.sent);
      expect(
        transport.requests
            .singleWhere((request) => request == transport.requests.first)
            .uri,
        Uri.parse('https://api.example.test/v1/diagnostics'),
      );
      expect(
        transport.requests.first.headers['Authorization'],
        'Bearer private-token-a',
      );
      expect(report.json, isNot(contains('private-account')));
      expect(report.json, isNot(contains('private-token')));
    },
  );

  test('Retry-After is enforced across manual retry clicks', () async {
    final transport = _Transport()
      ..respond = (_) => _failure(429, 'rate_limited', retryAfter: '3600');
    final clock = _Clock();
    final service = _service(transport, clock);
    await service.sendManual(_full(service));
    expect(service.lastFailure?.retryAfterSeconds, 3600);
    await service.retryManual();
    clock.advance(const Duration(seconds: 3599));
    await service.retryManual();
    expect(transport.requests, hasLength(1));
    clock.advance(const Duration(seconds: 1));
    transport.respond = _received;
    await service.retryManual();
    expect(transport.requests, hasLength(2));
  });

  test(
    '401 is isolated and waits for a new token of the same account',
    () async {
      final transport = _Transport()
        ..respond = (_) => _failure(401, 'unauthorized');
      final clock = _Clock();
      final service = _service(transport, clock);
      final report = _full(service);
      await service.sendManual(report);
      expect(service.status, DiagnosticStatus.authenticationRequired);
      expect(transport.closed, isFalse);
      clock.advance(const Duration(minutes: 5));
      await service.retryPending();
      service.setSession(
        accountId: 'private-account-a',
        token: 'private-token-a',
      );
      await service.retryPending();
      expect(transport.requests, hasLength(1));
      expect(service.preparedReport, same(report));
      transport.respond = _received;
      service.setSession(
        accountId: 'private-account-a',
        token: 'refreshed-token',
      );
      await service.retryPending();
      expect(transport.requests, hasLength(2));
      expect(transport.requests[1].body, transport.requests[0].body);
      expect(service.status, DiagnosticStatus.sent);
    },
  );

  for (final entry in {
    400: 'invalid_diagnostic',
    404: 'not_found',
    409: 'diagnostic_conflict',
    413: 'diagnostic_too_large',
    415: 'invalid_diagnostic',
    503: 'diagnostic_content_unavailable',
  }.entries) {
    test(
      '${entry.key}/${entry.value} is terminal without changing report ID',
      () async {
        final transport = _Transport()
          ..respond = (_) => _failure(entry.key, entry.value);
        final clock = _Clock();
        final service = _service(transport, clock);
        final report = _full(service);
        await service.sendManual(report);
        clock.advance(const Duration(hours: 2));
        await service.sendManual(report);
        await service.retryPending();
        expect(transport.requests, hasLength(1));
        expect(service.pendingCount, 0);
        expect(service.canRetry, isFalse);
        expect(service.lastFailure?.code, entry.value);
        expect(service.lastReceipt, isNull);
      },
    );
  }

  test(
    'account switch rejects late results and drops old observations and content',
    () async {
      final reply = Completer<ApiHttpResponse>();
      final transport = _Transport()..respond = (_) => reply.future;
      final service = _service(transport, _Clock());
      service.recordError('secure_storage_corrupt');
      final report = _full(service);
      final sending = service.sendManual(report);
      await Future<void>.delayed(Duration.zero);
      service.setSession(
        accountId: 'private-account-b',
        token: 'private-token-b',
      );
      reply.complete(_received(transport.requests.single));
      await sending;
      expect(service.lastReceipt, isNull);
      expect(service.pendingCount, 0);
      expect(service.preparedReport, isNull);
      await service.sendManual(report);
      expect(service.lastFailure?.code, 'report_account_changed');
      expect(transport.requests, hasLength(1));
      final fresh = _full(service).toJson();
      expect(fresh.containsKey('error'), isFalse);
      expect(fresh.containsKey('events'), isFalse);
    },
  );

  test(
    'revoking automatic consent drops queued auto reports and ignores late results',
    () async {
      final reply = Completer<ApiHttpResponse>();
      final transport = _Transport()..respond = (_) => reply.future;
      final clock = _Clock();
      final service = _service(transport, clock);
      service.setAutomaticConsent(true);
      service.recordError('secure_storage_corrupt');
      final sending = service.retryPending();
      await Future<void>.delayed(Duration.zero);
      service.setAutomaticConsent(false);
      reply.complete(_failure(503, 'diagnostics_unavailable'));
      await sending;
      clock.advance(const Duration(hours: 1));
      await service.retryPending();
      expect(service.pendingCount, 0);
      expect(transport.requests, hasLength(1));
      expect(service.status, DiagnosticStatus.idle);
      expect(service.lastFailure, isNull);
      expect((_full(service).toJson()['events']), isNull);
    },
  );

  test(
    'manual consent withdrawn synchronously before transport sends nothing',
    () async {
      final transport = _Transport();
      final service = _service(transport, _Clock());
      final report = _full(service);
      service.addListener(() {
        if (service.status == DiagnosticStatus.sending) service.cancelManual();
      });
      await service.sendManual(report);
      expect(transport.requests, isEmpty);
      expect(service.pendingCount, 0);
      expect(service.preparedReport, same(report));
    },
  );

  test(
    'three attempts maximum and 24 hour TTL cannot be reset by manual retry',
    () async {
      final transport = _Transport()
        ..respond = (_) => _failure(503, 'diagnostics_unavailable');
      final clock = _Clock();
      final service = _service(transport, clock);
      final report = _full(service);
      await service.sendManual(report);
      for (var i = 0; i < 4; i++) {
        clock.advance(const Duration(minutes: 3));
        await service.sendManual(report);
      }
      expect(transport.requests, hasLength(3));
      expect(service.pendingCount, 0);
      final next = _full(service);
      transport.respond = (_) =>
          _failure(429, 'rate_limited', retryAfter: '9999999');
      await service.sendManual(next);
      expect(service.lastFailure?.retryAfterSeconds, 86400);
      final count = transport.requests.length;
      var expiryNotifications = 0;
      service.addListener(() {
        if (service.lastFailure?.code == 'report_expired') {
          expiryNotifications++;
        }
      });
      clock.advance(const Duration(hours: 24));
      await service.retryPending();
      expect(service.status, DiagnosticStatus.failed);
      expect(service.lastFailure?.code, 'report_expired');
      expect(expiryNotifications, 1);
      await service.sendManual(next);
      expect(transport.requests, hasLength(count));
      expect(service.lastFailure?.code, 'report_expired');
      expect(service.pendingCount, 0);
    },
  );

  test('ring is capped at 1000 events and ten monotonic minutes', () {
    final clock = _Clock();
    final service = _service(_Transport(), clock);
    for (var i = 0; i < 1005; i++) {
      clock.advance(const Duration(milliseconds: 1));
      service.recordEvent(stage: 'handshake', event: 'waiting');
    }
    final first = _full(service);
    expect(first.eventCount, 1000);
    expect(first.toJson()['dropped_events'], 5);
    expect(first.toJson()['truncated'], isTrue);
    final events = first.toJson()['events']! as List<dynamic>;
    expect((events.first as Map)['offset_ms'], 6);
    service.recordError('tls_handshake_failed');
    clock.advance(const Duration(minutes: 10, milliseconds: 1));
    final expired = _full(service);
    expect(expired.eventCount, 0);
    expect(expired.toJson().containsKey('error'), isFalse);
    expect(expired.byteLength, lessThanOrEqualTo(524288));
  });

  test('a session expired while queued cannot send via retry', () async {
    final clock = _Clock();
    final transport = _Transport()
      ..respond = (_) => _failure(503, 'diagnostics_unavailable');
    final service = _service(transport, clock);
    service.setSession(
      accountId: 'private-account-a',
      token: 'private-token-a',
      expiresAt: clock.now().add(const Duration(seconds: 20)),
    );
    await service.sendManual(_full(service));
    clock.advance(const Duration(minutes: 1));
    await service.retryPending();
    expect(transport.requests, hasLength(1));
    expect(service.status, DiagnosticStatus.authenticationRequired);
    expect(service.lastFailure?.code, 'session_required');
  });

  test('incompatible success response is never reported as received', () async {
    final transport = _Transport()
      ..respond = (_) => ApiHttpResponse(
        statusCode: 201,
        headers: const {},
        body: jsonEncode({
          'status': 'received',
          'duplicate': false,
          'report_id': 'a1000000-0000-4000-8000-000000000099',
          'client_report_id': 'foreign-report',
          'received_at': '2026-02-30T00:00:00Z',
          'expires_at': '2026-03-30T00:00:00Z',
        }),
      );
    final service = _service(transport, _Clock());
    await service.sendManual(_full(service));
    expect(service.lastReceipt, isNull);
    expect(service.lastFailure?.code, 'invalid_diagnostic_response');
  });
}
