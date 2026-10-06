import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

import 'api_client_test.dart' show RecordingTransport;

Map<String, Object> _location(String id) => {
  'id': id,
  'display_name': id,
  'city': 'Paris',
  'country_code': 'FR',
  'supported_protocols': ['wireguard', 'openvpn'],
};

void main() {
  test(
    'public catalogue uses returned locations without availability requests',
    () async {
      final transport = RecordingTransport()
        ..respond(
          200,
          body: {
            'locations': [_location('paris-01'), _location('paris-02')],
          },
        )
        ..respond(
          200,
          body: {
            'locations': [_location('paris-02')],
          },
        );
      final client = ApiClient(transport: transport);

      expect((await client.locations()).map((value) => value.id), [
        'paris-01',
        'paris-02',
      ]);
      expect((await client.locations()).map((value) => value.id), ['paris-02']);
      expect(transport.requests, hasLength(2));
      for (final request in transport.requests) {
        expect(request.method, 'GET');
        expect(request.uri.path, '/v1/locations');
        expect(request.headers['authorization'], isNull);
      }
    },
  );

  test(
    'filtered public catalogue may be empty without synthetic destinations',
    () async {
      final transport = RecordingTransport()
      ..respond(200, body: {'locations': <Object>[]});
      final client = ApiClient(transport: transport);
      expect(await client.locations(), isEmpty);
      expect(transport.requests, hasLength(1));
    },
  );

  final operations = <String, Future<Object?> Function(ApiClient)>{
    'device registration': (client) => client.registerDevice(
      token: 'test-token',
      name: 'Test device',
      publicKey: 'public-test-key',
      locationId: 'paris-01',
    ),
    'location migration': (client) => client.startLocationMigration(
      token: 'test-token',
      deviceId: 'device-test',
      locationId: 'paris-01',
    ),
    'migration follow-up': (client) => client.getLocationMigration(
      token: 'test-token',
      deviceId: 'device-test',
      migrationId: 'migration-test',
    ),
    'OpenVPN profile': (client) => client.createOpenVpnProfile(
      token: 'test-token',
      deviceId: 'device-test',
      csrPem: 'test-public-csr',
    ),
    'OpenVPN renewal': (client) => client.renewOpenVpnProfile(
      token: 'test-token',
      deviceId: 'device-test',
      csrPem: 'test-public-csr',
    ),
  };
  for (final rejection in {
    'server_full': 409,
    'capacity_unavailable': 503,
  }.entries) {
    for (final operation in operations.entries) {
      test(
        '${operation.key} preserves ${rejection.key} without retrying',
        () async {
          final transport = RecordingTransport()
            ..respond(
              rejection.value,
              body: {
                'error': rejection.key,
                'detail': 'private-response-detail',
              },
            );
          final client = ApiClient(transport: transport);
          await expectLater(
            operation.value(client),
            throwsA(
              isA<ApiException>()
                  .having((error) => error.code, 'code', rejection.key)
                  .having(
                    (error) => error.statusCode,
                    'status',
                    rejection.value,
                  )
                  .having(
                    (error) => error.toString(),
                    'safe diagnostic',
                    isNot(contains('private-response-detail')),
                  ),
            ),
          );
          expect(transport.requests, hasLength(1));
          expect(
            transport.requests.single.uri.path,
            isNot(contains('/availability')),
          );
        },
      );
    }
  }
}
