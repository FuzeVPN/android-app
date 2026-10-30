// Corrections du 29/10/2026 — C5-…-02 et C5-…-04.
// Frontière réelle : ApiClient public + jsonDecode + modèles ; seul le
// transport HTTP est simulé. Un délai serveur est indicatif : une forme
// RFC 9110 valide (secondes ou HTTP-date) est convertie, une valeur excessive
// est bornée, une valeur illisible est ignorée ; elle ne fait jamais perdre une
// réponse par ailleurs valide.
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

class _Transport extends ApiHttpTransport {
  final Queue<ApiHttpResponse> replies = Queue<ApiHttpResponse>();
  final List<ApiHttpRequest> requests = <ApiHttpRequest>[];

  void reply(
    int status,
    Object? body, [
    Map<String, String> headers = const {},
  ]) => replies.add(
    ApiHttpResponse(
      statusCode: status,
      headers: headers,
      body: body == null ? '' : jsonEncode(body),
    ),
  );

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests.add(request);
    return replies.removeFirst();
  }
}

const _noStore = <String, String>{'cache-control': 'no-store'};

final DateTime _serverNow = DateTime.utc(2026, 10, 29, 12);

String _date(Duration offset) => HttpDate.format(_serverNow.add(offset));

Map<String, Object?> _migration({Object? retry, String status = 'draining'}) =>
    {
      'migration_id': 'migration-123',
      'device_id': 'device-123',
      'source_location_id': 'paris-01',
      'target_location_id': 'paris-02',
      'status': status,
      if (retry != null) 'retry_after_seconds': retry,
    };

Future<DeviceLocationMigration> _start(_Transport transport) =>
    ApiClient(transport: transport).startLocationMigration(
      token: 'session-fixture',
      deviceId: 'device-123',
      locationId: 'paris-02',
    );

Future<DeviceLocationMigration> _poll(_Transport transport) =>
    ApiClient(transport: transport).getLocationMigration(
      token: 'session-fixture',
      deviceId: 'device-123',
      migrationId: 'migration-123',
    );

/// Real error path: transport response -> ApiClient._request ->
/// ApiException.fromResponse, with the response `Date` when given.
Future<ApiException> _error({
  String? header,
  Object? body,
  String? date,
  int status = 429,
}) async {
  final transport = _Transport()
    ..reply(
      status,
      {'error': 'rate_limited', if (body != null) 'retry_after_seconds': body},
      {
        if (header != null) 'retry-after': header,
        if (date != null) 'date': date,
      },
    );
  try {
    await ApiClient(
      transport: transport,
    ).requestPasswordReset('synthetic@example.invalid');
  } on ApiException catch (error) {
    expect(error.statusCode, status);
    return error;
  }
  fail('the API failure was not raised');
}

void main() {
  group('C5-04 error Retry-After is converted or bounded', () {
    final serverDate = _date(Duration.zero);
    final cases = <String, (String?, Object?, int?)>{
      'IMF-fixdate +120 s': (_date(const Duration(seconds: 120)), null, 120),
      'IMF-fixdate +2 days is bounded': (
        _date(const Duration(days: 2)),
        null,
        86400,
      ),
      'IMF-fixdate in the past means now': (
        _date(const Duration(seconds: -30)),
        null,
        0,
      ),
      'RFC 850 date +60 s': ('Thursday, 29-Oct-26 12:01:00 GMT', null, 60),
      'asctime date +90 s': ('Thu Oct 29 12:01:30 2026', null, 90),
      'header 86401 is bounded': ('86401', null, 86400),
      'header 90000 is bounded': ('90000', null, 86400),
      'header beyond int64 is bounded': (
        '99999999999999999999999',
        null,
        86400,
      ),
      'zero-padded header keeps its value': ('0000000000120', null, 120),
      'duplicated header keeps the longest delay': ('120,120', null, 120),
      'joined header list keeps the longest delay': ('60, 120', null, 120),
      'joined HTTP-dates keep the longest delay': (
        '${_date(const Duration(seconds: 30))},'
            '${_date(const Duration(seconds: 90))}',
        null,
        90,
      ),
      'body 172800 is bounded': (null, 172800, 86400),
      'body 1e100 is bounded': (null, 1e100, 86400),
      'body string beyond the bound': (null, '172800', 86400),
      'witness header 120': ('120', null, 120),
      'witness boundary 86400': ('86400', null, 86400),
      'witness body 42': (null, 42, 42),
      'unreadable header falls back to the body': ('soon', 42, 42),
      'negative header falls back to the body': ('-1', 42, 42),
      'unreadable delays are ignored': ('soon', 'later', null),
      'fractional body is ignored': (null, 1.5, null),
    };
    for (final entry in cases.entries) {
      test(entry.key, () async {
        final (header, body, expected) = entry.value;
        final error = await _error(
          header: header,
          body: body,
          date: serverDate,
        );
        expect(error.retryAfterSeconds, expected);
        expect(error.code, 'rate_limited');
      });
    }

    test('non-finite JSON bodies are ignored without conversion', () async {
      for (final number in ['1e309', '-1e309']) {
        final transport = _Transport()
          ..replies.add(
            ApiHttpResponse(
              statusCode: 429,
              headers: const {},
              body: '{"error":"rate_limited","retry_after_seconds":$number}',
            ),
          );
        await expectLater(
          ApiClient(
            transport: transport,
          ).requestPasswordReset('synthetic@example.invalid'),
          throwsA(
            isA<ApiException>()
                .having((e) => e.code, 'code', 'rate_limited')
                .having((e) => e.retryAfterSeconds, 'Retry-After', isNull),
          ),
        );
      }
    });

    test('an HTTP-date without Date uses the local clock', () async {
      final retryAt = DateTime.now().toUtc().add(const Duration(minutes: 5));
      final error = await _error(header: HttpDate.format(retryAt));
      expect(error.retryAfterSeconds, inInclusiveRange(298, 301));
    });

    test('an invalid Date header falls back to the local clock', () async {
      final retryAt = DateTime.now().toUtc().add(const Duration(minutes: 5));
      final error = await _error(
        header: HttpDate.format(retryAt),
        date: 'not a date',
      );
      expect(error.retryAfterSeconds, inInclusiveRange(298, 301));
    });

    test('the error envelope parser accepts the response Date', () {
      // Direct constructor used by ApiClient; a missing Date stays optional.
      final error = ApiException.fromResponse(
        statusCode: 503,
        retryAfterHeader: '86401',
        body: '<html>unavailable</html>',
      );
      expect(error.code, 'api_error');
      expect(error.retryAfterSeconds, 86400);
    });

    test('ApiClient passes the response Date to the error parser', () async {
      final transport = _Transport()
        ..reply(
          429,
          {'error': 'rate_limited'},
          {
            'retry-after': _date(const Duration(seconds: 120)),
            'date': serverDate,
          },
        );
      await expectLater(
        ApiClient(
          transport: transport,
        ).requestPasswordReset('synthetic@example.invalid'),
        throwsA(
          isA<ApiException>()
              .having((e) => e.statusCode, 'status', 429)
              .having((e) => e.retryAfterSeconds, 'Retry-After', 120),
        ),
      );
    });

    test('Google routes keep the converted delay', () async {
      final transport = _Transport()
        ..reply(429, {'error': 'rate_limited', 'retry_after_seconds': 172800});
      await expectLater(
        ApiClient(transport: transport).registerGoogleAccount(
          browserContext: GoogleBrowserContext(
            browserContextToken: 'browser-fixture',
            authGeneration: 1,
            expiresAt: DateTime.utc(2099),
          ),
          contextToken: 'ticket-fixture',
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        ),
        throwsA(
          isA<ApiException>()
              .having((e) => e.code, 'code', 'rate_limited')
              .having((e) => e.retryAfterSeconds, 'Retry-After', 86400),
        ),
      );
    });
  });

  group('C5-02 accepted migrations are never lost because of a delay', () {
    final serverDate = _date(Duration.zero);
    final headers = <String, int?>{
      _date(const Duration(seconds: 120)): 120,
      _date(const Duration(hours: 1)): 300,
      _date(const Duration(seconds: -5)): 0,
      '301': 300,
      '600': 300,
      '120,120': 120,
      '99999999999999999999': 300,
      'soon': 2, // unreadable header: the body delay remains.
      '-1': 2,
    };
    for (final entry in headers.entries) {
      for (final status in [202, 200]) {
        test('POST $status Retry-After "${entry.key}"', () async {
          final transport = _Transport()
            ..reply(status, _migration(retry: 2), {
              ..._noStore,
              'retry-after': entry.key,
              'date': serverDate,
            });
          final migration = await _start(transport);
          expect(migration.migrationId, 'migration-123');
          expect(migration.targetLocationId, 'paris-02');
          expect(migration.status, LocationMigrationStatus.draining);
          expect(migration.retryAfterSeconds, entry.value);
          expect(transport.requests, hasLength(1));
        });
      }
      test('GET 200 Retry-After "${entry.key}"', () async {
        final transport = _Transport()
          ..reply(200, _migration(retry: 2), {
            ..._noStore,
            'retry-after': entry.key,
            'date': serverDate,
          });
        final migration = await _poll(transport);
        expect(migration.migrationId, 'migration-123');
        expect(migration.retryAfterSeconds, entry.value);
      });
    }

    final bodies = <Object, int?>{
      600: 300,
      301: 300,
      300: 300,
      0: 0,
      1e100: 300,
      -1: null,
      1.5: null,
      'soon': null,
      true: null,
    };
    for (final entry in bodies.entries) {
      test('body retry_after_seconds ${entry.key}', () async {
        final transport = _Transport()
          ..reply(202, _migration(retry: entry.key), _noStore);
        final migration = await _start(transport);
        expect(migration.migrationId, 'migration-123');
        expect(migration.retryAfterSeconds, entry.value);
      });
    }

    test(
      'non-finite JSON delays are ignored without integer conversion',
      () async {
        for (final number in ['1e309', '-1e309', '-1e100']) {
          final body = jsonEncode(_migration()).replaceFirst(
            '"status":"draining"',
            '"status":"draining","retry_after_seconds":$number',
          );
          final transport = _Transport()
            ..replies.add(
              ApiHttpResponse(statusCode: 202, headers: _noStore, body: body),
            );
          final migration = await _start(transport);
          expect(migration.migrationId, 'migration-123');
          expect(migration.retryAfterSeconds, isNull);
        }
      },
    );

    test('a readable header still wins over the body', () async {
      final transport = _Transport()
        ..reply(202, _migration(retry: 5), {..._noStore, 'retry-after': '120'});
      expect((await _start(transport)).retryAfterSeconds, 120);
    });

    test('the persisted form stays within the documented bound', () {
      final migration = DeviceLocationMigration.fromJson(
        _migration(retry: 86400),
        expectedDeviceId: 'device-123',
      );
      expect(migration.retryAfterSeconds, 300);
      expect(migration.toStorageJson()['retry_after_seconds'], 300);
    });

    test('invalid migration identity is still refused', () async {
      final transport = _Transport()
        ..reply(202, {..._migration(), 'device_id': 'other-device'}, _noStore);
      await expectLater(
        _start(transport),
        throwsA(isA<ApiProtocolException>()),
      );
    });
  });
}
