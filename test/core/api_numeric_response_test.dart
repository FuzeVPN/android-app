import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

class _ResponseTransport extends ApiHttpTransport {
  _ResponseTransport(this.status, this.body);
  final int status;
  final String body;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async => ApiHttpResponse(
    statusCode: status,
    headers: const {'cache-control': 'no-store'},
    body: body,
  );
}

Map<String, dynamic> _migration(Object? retry) => {
  'migration_id': 'migration-01',
  'device_id': 'device-01',
  'source_location_id': 'source-01',
  'target_location_id': 'target-01',
  'status': 'draining',
  if (retry != null) 'retry_after_seconds': retry,
};

void main() {
  for (final value in [1, 1.0, 100, 100.0]) {
    test('device limit accepts boundary $value', () {
      expect(
        DeviceList.fromJson({'limit': value, 'devices': <Object?>[]}).limit,
        value.toInt(),
      );
    });
  }
  for (final value in [
    0,
    -0.0,
    101,
    1.5,
    double.nan,
    double.infinity,
    double.negativeInfinity,
    double.maxFinite,
    -double.maxFinite,
  ]) {
    test('device limit rejects $value before integer conversion', () {
      expect(
        () => DeviceList.fromJson({'limit': value, 'devices': <Object?>[]}),
        throwsFormatException,
      );
    });
  }
  for (final value in [null, 0, -0.0, 0.0, 300, 300.0]) {
    test('migration retry accepts boundary $value', () {
      final result = DeviceLocationMigration.fromJson(
        _migration(value),
        expectedDeviceId: 'device-01',
      );
      expect(result.retryAfterSeconds, value?.toInt());
    });
  }
  // C5-02: an advisory delay never discards an accepted migration. Values are
  // still checked (finite, integral, non-negative) before any toInt(); too
  // large ones are bounded and unreadable ones ignored.
  for (final (value, expected) in <(num, int?)>[
    (-1, null),
    (301, 300),
    (0.5, null),
    (double.nan, null),
    (double.infinity, null),
    (double.negativeInfinity, null),
    (double.maxFinite, 300),
    (-double.maxFinite, null),
  ]) {
    test('migration retry bounds or ignores $value before conversion', () {
      final result = DeviceLocationMigration.fromJson(
        _migration(value),
        expectedDeviceId: 'device-01',
      );
      expect(result.migrationId, 'migration-01');
      expect(result.retryAfterSeconds, expected);
    });
  }
  for (final number in ['1e309', '-1e309', '1e100', '-1e100', '1.5']) {
    test(
      'API device list converts malformed $number to protocol failure',
      () async {
        final api = ApiClient(
          transport: _ResponseTransport(200, '{"limit":$number,"devices":[]}'),
        );
        await expectLater(
          api.listDevices('synthetic-session'),
          throwsA(
            isA<ApiProtocolException>().having(
              (error) => error.statusCode,
              'status',
              200,
            ),
          ),
        );
      },
    );
    for (final start in [true, false]) {
      test(
        'API migration ${start ? 'start' : 'get'} keeps the migration with delay $number',
        () async {
          final status = start ? 202 : 200;
          final body = jsonEncode(_migration(null)).replaceFirst(
            '"status":"draining"',
            '"status":"draining","retry_after_seconds":$number',
          );
          final api = ApiClient(transport: _ResponseTransport(status, body));
          final future = start
              ? api.startLocationMigration(
                  token: 'synthetic-session',
                  deviceId: 'device-01',
                  locationId: 'target-01',
                )
              : api.getLocationMigration(
                  token: 'synthetic-session',
                  deviceId: 'device-01',
                  migrationId: 'migration-01',
                );
          final migration = await future;
          expect(migration.migrationId, 'migration-01');
          expect(migration.status, LocationMigrationStatus.draining);
          expect(migration.retryAfterSeconds, number == '1e100' ? 300 : null);
        },
      );
    }
  }
  test('valid API success responses keep their model values', () async {
    final devices = ApiClient(
      transport: _ResponseTransport(200, '{"limit":100.0,"devices":[]}'),
    );
    expect((await devices.listDevices('synthetic-session')).limit, 100);
    final migration = ApiClient(
      transport: _ResponseTransport(202, jsonEncode(_migration(300.0))),
    );
    expect(
      (await migration.startLocationMigration(
        token: 'synthetic-session',
        deviceId: 'device-01',
        locationId: 'target-01',
      )).retryAfterSeconds,
      300,
    );
  });
}
