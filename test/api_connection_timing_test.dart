import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/connection_timing.dart';

class _RecordingTransport extends ApiHttpTransport {
  _RecordingTransport(this.response, {this.failure});

  final ApiHttpResponse response;
  final ApiFailure? failure;
  ApiHttpRequest? request;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest value) async {
    request = value;
    if (failure case final ApiFailure failure) throw failure;
    return response;
  }
}

Map<String, dynamic> _record(String line) =>
    jsonDecode(line.substring('FuzeVpnTiming '.length)) as Map<String, dynamic>;

void main() {
  test(
    'chronomètre une inscription d appareil sans exposer la requête',
    () async {
      const String token = 'token-secret';
      const String publicKey = 'public-key-secret';
      const String location = 'location-secret';
      final _RecordingTransport transport = _RecordingTransport(
        ApiHttpResponse(
          statusCode: 201,
          headers: const <String, String>{'cache-control': 'no-store'},
          body: jsonEncode(<String, Object>{
            'device_id': 'returned-device-secret',
            'address': '10.0.0.2/32',
            'dns': <String>['1.1.1.1'],
            'server_public_key': 'server-key-secret',
            'endpoint': '198.51.100.1:51820',
            'allowed_ips': <String>['0.0.0.0/0'],
          }),
        ),
      );
      final ApiClient client = ApiClient(transport: transport);
      final List<String> lines = <String>[];

      final DeviceConfiguration configuration = await ConnectionTiming.run(
        'connection',
        () => client.registerDevice(
          token: token,
          name: 'Private device name',
          publicKey: publicKey,
          locationId: location,
        ),
        sink: lines.add,
      );

      expect(configuration.deviceId, 'returned-device-secret');
      expect(transport.request!.headers['authorization'], 'Bearer $token');
      expect(
        jsonDecode(transport.request!.body!),
        <String, dynamic>{
          'name': 'Private device name',
          'public_key': publicKey,
          'location_id': location,
        },
      );
      final List<Map<String, dynamic>> records = lines.map(_record).toList();
      expect(
        records.where((record) => record['stage'] == 'api.device.register'),
        isNotEmpty,
      );
      expect(
        records
            .where((record) => record['stage'] == 'api.device.register')
            .map((record) => record['event']),
        containsAll(<String>['begin', 'end', 'event']),
      );
      final String diagnosticOutput = lines.join('\n');
      for (final String sensitive in <String>[
        token,
        publicKey,
        location,
        'Private device name',
        'returned-device-secret',
        'server-key-secret',
      ]) {
        expect(diagnosticOutput, isNot(contains(sensitive)));
      }
    },
  );

  group('restauration du compte', () {
    const String token = 'token-secret';
    final ApiHttpResponse profile = ApiHttpResponse(
      statusCode: 200,
      headers: const <String, String>{},
      body: jsonEncode(<String, Object>{
        'user_id': 'user-secret',
        'email': 'private@example.test',
        'first_name': 'Private',
        'last_name': 'Person',
        'phone': '+33600000000',
        'address_line1': '1 rue Exemple',
        'address_line2': '',
        'postal_code': '75001',
        'city': 'Paris',
        'country_code': 'FR',
      }),
    );

    List<Map<String, dynamic>> meRecords(List<String> lines) => lines
        .map(_record)
        .where((record) => record['stage'] == 'api.me')
        .toList();

    test('chronomètre GET v1/me sans exposer la session', () async {
      final ApiClient client = ApiClient(
        transport: _RecordingTransport(profile),
      );
      final List<String> lines = <String>[];

      final UserProfile restored = await ConnectionTiming.run(
        'restore',
        () => client.me(token),
        sink: lines.add,
      );

      expect(restored.userId, 'user-secret');
      expect(
        meRecords(lines).map((record) => record['event']),
        containsAll(<String>['begin', 'end', 'event']),
      );
      expect(
        meRecords(lines).firstWhere((record) => record['event'] == 'event'),
        containsPair('status', 200),
      );
      for (final String sensitive in <String>[
        token,
        'user-secret',
        'private@example.test',
      ]) {
        expect(lines.join('\n'), isNot(contains(sensitive)));
      }
    });

    test('un échec de GET v1/me garde sa durée dans la trace', () async {
      final ApiClient client = ApiClient(
        transport: _RecordingTransport(
          profile,
          failure: const ApiNetworkException(),
        ),
      );
      final List<String> lines = <String>[];

      await expectLater(
        ConnectionTiming.run(
          'restore',
          () => client.me(token),
          sink: lines.add,
        ),
        throwsA(isA<ApiNetworkException>()),
      );

      final List<Map<String, dynamic>> records = meRecords(lines);
      expect(records.map((record) => record['event']), <String>[
        'begin',
        'error',
      ]);
      expect(records.last['duration_ms'], isA<int>());
      expect(lines.join('\n'), isNot(contains(token)));
    });
  });
}
