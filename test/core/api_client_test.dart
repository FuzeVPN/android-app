import 'dart:collection';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

class RecordingTransport extends ApiHttpTransport {
  final Queue<ApiHttpResponse> _responses = Queue<ApiHttpResponse>();
  final List<ApiHttpRequest> requests = <ApiHttpRequest>[];

  void respond(
    int statusCode, {
    Object? body,
    Map<String, String> headers = const <String, String>{},
  }) {
    _responses.add(
      ApiHttpResponse(
        statusCode: statusCode,
        headers: headers,
        body: body == null ? '' : jsonEncode(body),
      ),
    );
  }

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests.add(request);
    if (_responses.isEmpty) {
      throw StateError('Réponse de test manquante.');
    }
    return _responses.removeFirst();
  }
}

Map<String, dynamic> sessionJson() => <String, dynamic>{
  'access_token': 'session-response-only',
  'expires_at': '2027-01-01T12:00:00Z',
};

Map<String, dynamic> profileJson() => <String, dynamic>{
  'user_id': 'user-123',
  'email': 'client@example.test',
  'first_name': 'Client',
  'last_name': 'Example',
  'phone': '+33600000000',
  'address_line1': '1 rue Exemple',
  'address_line2': '',
  'postal_code': '75001',
  'city': 'Paris',
  'country_code': 'FR',
};

Map<String, dynamic> wireGuardJson() => <String, dynamic>{
  'device_id': 'device-123',
  'address': '10.10.0.2/32',
  'dns': <String>['1.1.1.1'],
  'server_public_key': 'server-public-key',
  'endpoint': '198.51.100.10:51820',
  'allowed_ips': <String>['0.0.0.0/0'],
};

Map<String, dynamic> openVpnJson() => <String, dynamic>{
  'device_id': 'device-123',
  'protocol': 'openvpn',
  'address': '10.20.0.2/32',
  'dns': <String>['1.1.1.1'],
  'endpoint': '198.51.100.10',
  'server_name': 'frankfurt-01.openvpn.fuzevpn.internal',
  'remote_cert_tls_server': true,
  'ciphers': <String>['AES-256-GCM'],
  'ca_certificate_pem': 'ca-response-only',
  'certificate_pem': 'certificate-response-only',
  'not_after': '2027-01-01T12:00:00Z',
  'tls_crypt_v2_client_key': 'tls-crypt-response-only',
};

Map<String, dynamic> devicesJson() => <String, dynamic>{
  'limit': 2,
  'devices': <Map<String, dynamic>>[
    <String, dynamic>{
      'device_id': 'device-123',
      'name': 'FuzeVPN — Android',
      'location': <String, dynamic>{
        'id': 'frankfurt-01',
        'display_name': 'Frankfurt 1',
        'city': 'Frankfurt',
        'country_code': 'DE',
        'supported_protocols': <String>['wireguard', 'openvpn'],
      },
      'created_at': '2026-08-10T12:00:00Z',
      'profiles': <Map<String, dynamic>>[
        <String, dynamic>{'protocol': 'wireguard', 'status': 'active'},
      ],
    },
  ],
};

Map<String, dynamic> migrationJson({
  String status = 'draining',
  int retryAfterSeconds = 2,
}) => <String, dynamic>{
  'migration_id': 'migration-123',
  'device_id': 'device-123',
  'source_location_id': 'frankfurt-01',
  'target_location_id': 'frankfurt-02',
  'status': status,
  'retry_after_seconds': retryAfterSeconds,
};

const Map<String, String> noStoreHeaders = <String, String>{
  'cache-control': 'private, no-store',
};

void main() {
  group('ApiClient auth contracts', () {
    test(
      'envoie login avec URL injectable et ne place pas le jeton dans la requête',
      () async {
        final RecordingTransport transport = RecordingTransport()
          ..respond(201, body: sessionJson());
        final ApiClient client = ApiClient(
          baseUri: Uri.parse('http://localhost:8080/debug/'),
          transport: transport,
        );

        final AuthSession session = await client.login(
          email: 'client@example.test',
          password: 'mot-de-passe-secret',
        );

        expect(session.accessToken, 'session-response-only');
        expect(transport.requests.single.uri.path, '/debug/v1/auth/login');
        expect(transport.requests.single.method, 'POST');
        expect(transport.requests.single.headers['authorization'], isNull);
        expect(jsonDecode(transport.requests.single.body!), <String, dynamic>{
          'email': 'client@example.test',
          'password': 'mot-de-passe-secret',
        });
      },
    );

    test(
      'couvre inscription, session, vérification et réinitialisation',
      () async {
        final RecordingTransport transport = RecordingTransport()
          ..respond(
            201,
            body: <String, dynamic>{
              ...sessionJson(),
              'verification_email_sent': false,
            },
          )
          ..respond(204)
          ..respond(204)
          ..respond(202)
          ..respond(204)
          ..respond(200, body: <String, dynamic>{'email_verified': true})
          ..respond(200, body: profileJson())
          ..respond(200, body: profileJson());
        final ApiClient client = ApiClient(transport: transport);
        const RegisterAccountRequest registration = RegisterAccountRequest(
          email: 'client@example.test',
          password: 'mot-de-passe-secret',
          firstName: 'Client',
          lastName: 'Example',
          phone: '+33600000000',
          addressLine1: '1 rue Exemple',
          postalCode: '75001',
          city: 'Paris',
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );

        final RegistrationResult result = await client.register(registration);
        await client.logout('session-token');
        await client.resendVerification('session-token');
        await client.requestPasswordReset('client@example.test');
        await client.confirmPasswordReset(
          token: 'reset-token',
          password: 'nouveau-mot-de-passe',
        );
        expect(await client.verifyEmail('verification-token'), isTrue);
        expect((await client.me('session-token')).userId, 'user-123');
        expect(
          (await client.updateMe(
            token: 'session-token',
            request: const UpdateProfileRequest(
              firstName: 'Client',
              lastName: 'Example',
              phone: '+33600000000',
              addressLine1: '1 rue Exemple',
              postalCode: '75001',
              city: 'Paris',
              countryCode: 'FR',
            ),
          )).email,
          'client@example.test',
        );

        expect(result.verificationEmailSent, isFalse);
        expect(
          transport.requests.map((ApiHttpRequest request) => request.uri.path),
          <String>[
            '/v1/auth/register',
            '/v1/auth/logout',
            '/v1/auth/email/resend',
            '/v1/auth/password/reset/request',
            '/v1/auth/password/reset/confirm',
            '/v1/auth/email/verify',
            '/v1/me',
            '/v1/me',
          ],
        );
        expect(
          transport.requests[1].headers['authorization'],
          'Bearer session-token',
        );
        expect(
          transport.requests[2].headers['authorization'],
          'Bearer session-token',
        );
        expect(transport.requests[6].method, 'GET');
        expect(transport.requests[7].method, 'PUT');
      },
    );
  });

  group('ApiClient VPN contracts', () {
    test(
      'utilise uniquement les routes documentées et vérifie no-store',
      () async {
        final RecordingTransport transport = RecordingTransport()
          ..respond(
            200,
            body: <String, dynamic>{
              'locations': <Map<String, dynamic>>[
                <String, dynamic>{
                  'id': 'frankfurt-01',
                  'display_name': 'Frankfurt 1',
                  'city': 'Frankfurt',
                  'country_code': 'DE',
                  'supported_protocols': <String>['wireguard', 'openvpn'],
                },
              ],
            },
          )
          ..respond(201, body: wireGuardJson(), headers: noStoreHeaders)
          ..respond(200, body: devicesJson(), headers: noStoreHeaders)
          ..respond(
            200,
            headers: noStoreHeaders,
            body: <String, dynamic>{
              'device_id': 'device-123',
              'profiles': <Map<String, dynamic>>[
                <String, dynamic>{'protocol': 'openvpn', 'status': 'active'},
              ],
            },
          )
          ..respond(201, body: openVpnJson(), headers: noStoreHeaders)
          ..respond(201, body: openVpnJson(), headers: noStoreHeaders)
          ..respond(204, headers: noStoreHeaders)
          ..respond(204, headers: noStoreHeaders);
        final ApiClient client = ApiClient(transport: transport);

        expect((await client.locations()).single.supportedProtocols.length, 2);
        expect(
          (await client.registerDevice(
            token: 'session-token',
            name: 'FuzeVPN — Android',
            publicKey: 'public-key-only',
            locationId: 'frankfurt-01',
          )).deviceId,
          'device-123',
        );
        expect((await client.listDevices('session-token')).devices.length, 1);
        expect(
          (await client.deviceProfiles(
            token: 'session-token',
            deviceId: 'device-123',
          )).profiles.single.protocol,
          VpnProtocol.openVpn,
        );
        expect(
          (await client.createOpenVpnProfile(
            token: 'session-token',
            deviceId: 'device-123',
            csrPem: 'csr-public-only',
          )).endpoint,
          '198.51.100.10',
        );
        await client.renewOpenVpnProfile(
          token: 'session-token',
          deviceId: 'device-123',
          csrPem: 'replacement-csr-public-only',
        );
        await client.revokeOpenVpnProfile(
          token: 'session-token',
          deviceId: 'device-123',
        );
        await client.revokeDevice(
          token: 'session-token',
          deviceId: 'device-123',
        );

        expect(
          transport.requests.map((ApiHttpRequest request) => request.uri.path),
          <String>[
            '/v1/locations',
            '/v1/devices',
            '/v1/devices',
            '/v1/devices/device-123/profiles',
            '/v1/devices/device-123/profiles/openvpn',
            '/v1/devices/device-123/profiles/openvpn/renew',
            '/v1/devices/device-123/profiles/openvpn',
            '/v1/devices/device-123',
          ],
        );
        expect(
          transport.requests[1].headers['authorization'],
          'Bearer session-token',
        );
        expect(jsonDecode(transport.requests[1].body!), <String, dynamic>{
          'name': 'FuzeVPN — Android',
          'public_key': 'public-key-only',
          'location_id': 'frankfurt-01',
        });
        expect(jsonDecode(transport.requests[4].body!), <String, dynamic>{
          'csr_pem': 'csr-public-only',
        });
        expect(transport.requests[6].method, 'DELETE');
        expect(transport.requests[6].body, isNull);
      },
    );

    test(
      'échoue fermement lorsqu une réponse sensible oublie no-store',
      () async {
        final RecordingTransport transport = RecordingTransport()
          ..respond(201, body: wireGuardJson());
        final ApiClient client = ApiClient(transport: transport);

        await expectLater(
          client.registerDevice(
            token: 'session-token',
            name: 'FuzeVPN — Android',
            publicKey: 'public-key-only',
            locationId: 'frankfurt-01',
          ),
          throwsA(isA<ApiProtocolException>()),
        );
      },
    );

    test(
      'refuse une liste de profils qui ne correspond pas au chemin demandé',
      () async {
        final RecordingTransport transport = RecordingTransport()
          ..respond(
            200,
            headers: noStoreHeaders,
            body: <String, dynamic>{
              'device_id': 'other-device',
              'profiles': <Object>[],
            },
          );
        final ApiClient client = ApiClient(transport: transport);

        await expectLater(
          client.deviceProfiles(token: 'session-token', deviceId: 'device-123'),
          throwsA(isA<ApiProtocolException>()),
        );
      },
    );

    test(
      'démarre et suit une migration avec no-store et Retry-After',
      () async {
        final RecordingTransport transport = RecordingTransport()
          ..respond(
            202,
            headers: const <String, String>{
              'cache-control': 'no-store',
              'retry-after': '4',
            },
            body: migrationJson(),
          )
          ..respond(
            200,
            headers: noStoreHeaders,
            body: migrationJson(status: 'ready'),
          );
        final ApiClient client = ApiClient(transport: transport);

        final DeviceLocationMigration started = await client
            .startLocationMigration(
              token: 'session-token',
              deviceId: 'device-123',
              locationId: 'frankfurt-02',
            );
        final DeviceLocationMigration ready = await client.getLocationMigration(
          token: 'session-token',
          deviceId: 'device-123',
          migrationId: 'migration-123',
        );

        expect(started.retryAfterSeconds, 4);
        expect(ready.status, LocationMigrationStatus.ready);
        expect(
          transport.requests.map((ApiHttpRequest request) => request.uri.path),
          <String>[
            '/v1/devices/device-123/location-migrations',
            '/v1/devices/device-123/location-migrations/migration-123',
          ],
        );
        expect(jsonDecode(transport.requests.first.body!), <String, dynamic>{
          'location_id': 'frankfurt-02',
        });
        expect(
          transport.requests.first.headers['authorization'],
          'Bearer session-token',
        );
      },
    );

    test(
      'refuse une migration sans no-store, avec statut inattendu ou identifiant incohérent',
      () async {
        final RecordingTransport missingNoStore = RecordingTransport()
          ..respond(202, body: migrationJson());
        await expectLater(
          ApiClient(transport: missingNoStore).startLocationMigration(
            token: 'session-token',
            deviceId: 'device-123',
            locationId: 'frankfurt-02',
          ),
          throwsA(isA<ApiProtocolException>()),
        );

        final RecordingTransport badStatus = RecordingTransport()
          ..respond(201, headers: noStoreHeaders, body: migrationJson());
        await expectLater(
          ApiClient(transport: badStatus).startLocationMigration(
            token: 'session-token',
            deviceId: 'device-123',
            locationId: 'frankfurt-02',
          ),
          throwsA(isA<ApiException>()),
        );

        final RecordingTransport mismatched = RecordingTransport()
          ..respond(
            200,
            headers: noStoreHeaders,
            body: <String, dynamic>{
              ...migrationJson(status: 'ready'),
              'migration_id': 'different-migration',
            },
          );
        await expectLater(
          ApiClient(transport: mismatched).getLocationMigration(
            token: 'session-token',
            deviceId: 'device-123',
            migrationId: 'migration-123',
          ),
          throwsA(isA<ApiProtocolException>()),
        );
      },
    );
  });

  test(
    'transforme une erreur serveur en ApiException sans corps brut',
    () async {
      final RecordingTransport transport = RecordingTransport()
        ..respond(
          429,
          headers: const <String, String>{'Retry-After': '9'},
          body: <String, dynamic>{
            'error': 'rate_limited',
            'detail': 'session-token and endpoint must never be exposed',
          },
        );
      final ApiClient client = ApiClient(transport: transport);

      try {
        await client.login(email: 'client@example.test', password: 'secret');
        fail('Une erreur API était attendue.');
      } on ApiException catch (error) {
        expect(error.statusCode, 429);
        expect(error.errorCode, 'rate_limited');
        expect(error.retryAfterSeconds, 9);
        expect(error.toString(), isNot(contains('session-token')));
        expect(error.toString(), isNot(contains('endpoint')));
      }
    },
  );

  test(
    'convertit une reponse de succes malformee en erreur de protocole',
    () async {
      final RecordingTransport transport = RecordingTransport()
        ..respond(
          201,
          body: <String, dynamic>{'access_token': 'missing-expiry'},
        );
      final ApiClient client = ApiClient(transport: transport);

      await expectLater(
        client.login(email: 'client@example.test', password: 'secret'),
        throwsA(
          isA<ApiProtocolException>().having(
            (ApiProtocolException error) => error.statusCode,
            'statusCode',
            201,
          ),
        ),
      );
    },
  );
}
