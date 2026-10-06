import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/models.dart';

Map<String, dynamic> openVpnActivation({
  String endpoint = '198.51.100.10',
  Object? remoteCertTlsServer = true,
  Object? dns = const <String>['10.20.0.1'],
  Object? ciphers = const <String>['AES-256-GCM'],
  String address = '10.20.0.2/32',
}) => <String, dynamic>{
  'device_id': 'device-123',
  'protocol': 'openvpn',
  'certificate_pem': 'certificate-response-only',
  'ca_certificate_pem': 'ca-response-only',
  'tls_crypt_v2_client_key': 'tls-crypt-response-only',
  'endpoint': endpoint,
  'dns': dns,
  'address': address,
  'server_name': 'frankfurt-01.openvpn.fuzevpn.internal',
  'remote_cert_tls_server': remoteCertTlsServer,
  'ciphers': ciphers,
  'not_after': '2027-01-01T12:00:00Z',
};

void main() {
  group('Location', () {
    test('respecte uniquement les protocoles annoncés par le serveur', () {
      final Location location = Location.fromJson(<String, dynamic>{
        'id': 'frankfurt-01',
        'display_name': 'Frankfurt 1',
        'city': 'Frankfurt',
        'country_code': 'DE',
        'supported_protocols': <String>['openvpn', 'wireguard', 'future-vpn'],
      });

      expect(location.supportedProtocols, <VpnProtocol>{
        VpnProtocol.wireGuard,
        VpnProtocol.openVpn,
      });
    });

    test('ne fabrique pas WireGuard lorsqu aucun protocole est annoncé', () {
      final Location location = Location.fromJson(<String, dynamic>{
        'id': 'frankfurt-01',
        'display_name': 'Frankfurt 1',
        'city': 'Frankfurt',
        'country_code': 'DE',
      });

      expect(location.supportedProtocols, isEmpty);
    });
  });

  group('OpenVpnActivation', () {
    test('valide le contrat réel et masque les secrets dans toString', () {
      final OpenVpnActivation activation = OpenVpnActivation.fromJson(
        openVpnActivation(),
        expectedDeviceId: 'device-123',
      );

      expect(activation.endpoint, '198.51.100.10');
      expect(activation.address, '10.20.0.2/32');
      expect(activation.notAfter, DateTime.utc(2027, 1, 1, 12));
      expect(activation.toString(), isNot(contains('tls-crypt-response-only')));
      expect(
        activation.toString(),
        isNot(contains('certificate-response-only')),
      );
      expect(activation.toString(), isNot(contains('ca-response-only')));
    });

    test('refuse les réponses OpenVPN incomplètes ou dangereuses', () {
      final List<Map<String, dynamic>> invalid = <Map<String, dynamic>>[
        openVpnActivation(endpoint: 'vpn.example.test'),
        openVpnActivation(endpoint: '198.51.100.10:1194'),
        openVpnActivation(remoteCertTlsServer: false),
        openVpnActivation(dns: const <String>['2001:db8::1']),
        openVpnActivation(ciphers: const <String>[]),
        openVpnActivation(address: '10.20.0.2/24'),
        <String, dynamic>{...openVpnActivation(), 'device_id': 'other-device'},
        <String, dynamic>{...openVpnActivation(), 'protocol': 'wireguard'},
      ];

      for (final Map<String, dynamic> json in invalid) {
        expect(
          () =>
              OpenVpnActivation.fromJson(json, expectedDeviceId: 'device-123'),
          throwsFormatException,
        );
      }
    });
  });

  group('DeviceLocationMigration', () {
    Map<String, dynamic> migrationJson({
      String status = 'draining',
      Object? retryAfterSeconds = 2,
    }) => <String, dynamic>{
      'migration_id': 'migration-123',
      'device_id': 'device-123',
      'source_location_id': 'frankfurt-01',
      'target_location_id': 'frankfurt-02',
      'status': status,
      if (retryAfterSeconds != null) 'retry_after_seconds': retryAfterSeconds,
    };

    test('accepte strictement les quatre états documentés', () {
      for (final String status in <String>[
        'draining',
        'activating',
        'ready',
        'blocked',
      ]) {
        final DeviceLocationMigration migration =
            DeviceLocationMigration.fromJson(
              migrationJson(status: status),
              expectedDeviceId: 'device-123',
            );
        expect(migration.status.name, status);
      }
    });

    test('refuse les statuts, identifiants et délais incohérents', () {
      final List<Map<String, dynamic>> invalid = <Map<String, dynamic>>[
        migrationJson(status: 'moving'),
        <String, dynamic>{...migrationJson(), 'device_id': 'other-device'},
        migrationJson(retryAfterSeconds: -1),
        migrationJson(retryAfterSeconds: 301),
        migrationJson(retryAfterSeconds: 1.5),
        <String, dynamic>{...migrationJson()}..remove('migration_id'),
      ];
      for (final Map<String, dynamic> json in invalid) {
        expect(
          () => DeviceLocationMigration.fromJson(
            json,
            expectedDeviceId: 'device-123',
          ),
          throwsFormatException,
        );
      }
    });
  });

  test('représente un statut de vérification e-mail absent comme inconnu', () {
    final UserProfile profile = UserProfile.fromJson(<String, dynamic>{
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
    });

    expect(profile.emailVerified, isNull);
    expect(profile.hasVerifiedEmail, isFalse);
    expect(profile.toString(), isNot(contains('client@example.test')));
  });

  group('UserProfile identity and session capabilities', () {
    Map<String, dynamic> guestJson() => <String, dynamic>{
      'user_id': 'guest-123',
      'identity_kind': 'guest',
      'profile_redacted': false,
      'can_manage_account': false,
      'can_claim_account': true,
      'can_use_vpn': true,
    };

    test('legacy registered profiles need no name or new permissions', () {
      final profile = UserProfile.fromJson(<String, dynamic>{
        'user_id': 'user-123',
        'email': 'client@example.test',
      });
      expect(profile.identityKind, 'registered');
      expect(profile.hasSessionCapabilities, isFalse);
      expect(profile.isGuest, isFalse);
      expect(profile.profileRedacted, isFalse);
      expect(profile.canManageAccount, isTrue);
      expect(profile.canClaimAccount, isFalse);
      expect(profile.canUseVpn, isTrue);
      expect(profile.firstName, isEmpty);
      expect(profile.lastName, isEmpty);
      expect(profile.authMethods, isNull);
      expect(profile.hasPassword, isNull);
    });

    test('guest identity needs no invented personal information', () {
      final profile = UserProfile.fromJson(guestJson());
      expect(profile.isGuest, isTrue);
      expect(profile.hasSessionCapabilities, isTrue);
      expect(profile.email, isEmpty);
      expect(profile.firstName, isEmpty);
      expect(profile.lastName, isEmpty);
      expect(profile.emailVerified, isNull);
      expect(profile.canManageAccount, isFalse);
      expect(profile.canClaimAccount, isTrue);
      expect(profile.canUseVpn, isTrue);
    });

    test('registered redacted session retains only declared capabilities', () {
      final profile = UserProfile.fromJson(<String, dynamic>{
        ...guestJson(),
        'identity_kind': 'registered',
        'profile_redacted': true,
        'can_claim_account': false,
      });
      expect(profile.isGuest, isFalse);
      expect(profile.hasSessionCapabilities, isTrue);
      expect(profile.profileRedacted, isTrue);
      expect(profile.canManageAccount, isFalse);
      expect(profile.canClaimAccount, isFalse);
      expect(profile.canUseVpn, isTrue);
      expect(profile.email, isEmpty);
      expect(profile.emailVerified, isNull);
      expect(profile.hasVerifiedEmail, isFalse);
    });

    test(
      'explicit identity cannot inherit missing or malformed permissions',
      () {
        for (final field in <String>[
          'profile_redacted',
          'can_manage_account',
          'can_claim_account',
          'can_use_vpn',
        ]) {
          expect(
            () => UserProfile.fromJson(guestJson()..remove(field)),
            throwsFormatException,
          );
          expect(
            () => UserProfile.fromJson(<String, dynamic>{
              ...guestJson(),
              field: 'true',
            }),
            throwsFormatException,
          );
        }
        expect(
          () => UserProfile.fromJson(<String, dynamic>{
            ...guestJson(),
            'identity_kind': 'future',
          }),
          throwsFormatException,
        );
        expect(
          () => UserProfile.fromJson(guestJson()..remove('identity_kind')),
          throwsFormatException,
        );
      },
    );

    test('redacted projection rejects personal data or verification state', () {
      for (final field in <String>[
        'email',
        'first_name',
        'last_name',
        'phone',
        'address_line1',
        'address_line2',
        'postal_code',
        'city',
        'country_code',
        'email_verified',
        'auth_methods',
        'has_password',
      ]) {
        expect(
          () => UserProfile.fromJson(<String, dynamic>{
            ...guestJson(),
            'profile_redacted': true,
            field: field == 'email_verified' ? false : 'fixture-private',
          }),
          throwsFormatException,
        );
      }
    });

    test(
      'new registered profile accepts email-only identity and empty names',
      () {
        final profile = UserProfile.fromJson(<String, dynamic>{
          ...guestJson(),
          'identity_kind': 'registered',
          'email': 'client@example.test',
          'first_name': '',
          'can_manage_account': true,
          'can_claim_account': false,
          'email_verified': false,
        });
        expect(profile.firstName, isEmpty);
        expect(profile.lastName, isEmpty);
        expect(profile.emailVerified, isFalse);
        expect(profile.hasSessionCapabilities, isTrue);
        expect(profile.canUseVpn, isTrue);
      },
    );

    test('passwordless and dual-method full profiles expose explicit metadata', () {
      for (final fixture in <(List<String>, bool)>[
        (['google'], false),
        (['password'], true),
        (['password', 'google'], true),
      ]) {
        final profile = UserProfile.fromJson(<String, dynamic>{
          'user_id': 'user-google',
          'email': 'client@example.test',
          'auth_methods': fixture.$1,
          'has_password': fixture.$2,
        });
        expect(profile.authMethods, fixture.$1);
        expect(profile.hasPassword, fixture.$2);
        expect(() => profile.authMethods!.add('password'), throwsUnsupportedError);
      }
    });

    test('malformed authentication metadata does not imply a passwordless account', () {
      for (final metadata in <Map<String, dynamic>>[
        {'auth_methods': null},
        {'auth_methods': 'google'},
        {'auth_methods': <String>[]},
        {'auth_methods': ['google', 'google']},
        {'auth_methods': ['unknown']},
        {'auth_methods': ['google', false]},
        {'has_password': null},
        {'has_password': 'false'},
        {'auth_methods': ['google'], 'has_password': true},
        {'auth_methods': ['password'], 'has_password': false},
      ]) {
        expect(() => UserProfile.fromJson(<String, dynamic>{
          'user_id': 'user-google', 'email': 'client@example.test', ...metadata,
        }), throwsFormatException);
      }
      expect(() => UserProfile.fromJson(<String, dynamic>{
        ...guestJson(), 'auth_methods': ['google'], 'has_password': false,
      }), throwsFormatException);
      for (final field in ['auth_methods', 'has_password']) {
        expect(() => UserProfile.fromJson(<String, dynamic>{
          ...guestJson(), 'identity_kind': 'registered', 'profile_redacted': true,
          field: null,
        }), throwsFormatException);
      }
    });
  });

  test('conserve les métadonnées de profils dans la liste des appareils', () {
    final DeviceList devices = DeviceList.fromJson(<String, dynamic>{
      'limit': 2,
      'devices': <Map<String, dynamic>>[
        <String, dynamic>{
          'device_id': 'device-123',
          'name': 'Téléphone Android',
          'location': <String, dynamic>{
            'id': 'frankfurt-01',
            'display_name': 'Frankfurt 1',
            'city': 'Frankfurt',
            'country_code': 'DE',
            'supported_protocols': <String>['wireguard', 'openvpn'],
          },
          'created_at': '2026-08-10T12:00:00Z',
          'profiles': <Map<String, dynamic>>[
            <String, dynamic>{
              'protocol': 'openvpn',
              'status': 'active',
              'created_at': '2026-08-10T12:00:00Z',
              'expires_at': '2027-08-10T12:00:00Z',
            },
          ],
        },
      ],
    });

    expect(devices.limit, 2);
    expect(
      devices.devices.single.profiles.single.protocol,
      VpnProtocol.openVpn,
    );
    expect(devices.devices.single.toString(), isNot(contains('Android')));
    expect(
      devices.devices.single.profiles.single.expiresAt,
      DateTime.utc(2027, 8, 10, 12),
    );
  });

  test('lit une liste mixte VPN et navigateur sans fausse localisation', () {
    final DeviceList devices = DeviceList.fromJson(<String, dynamic>{
      'limit': 2,
      'devices': <Map<String, dynamic>>[
        <String, dynamic>{
          'device_id': 'device-android',
          'name': 'Téléphone Android',
          'location': <String, dynamic>{
            'id': 'frankfurt-01',
            'display_name': 'Frankfurt 1',
            'city': 'Frankfurt',
            'country_code': 'DE',
          },
          'created_at': '2026-08-10T12:00:00Z',
          'profiles': <Object>[],
        },
        <String, dynamic>{
          'device_id': 'device-chrome',
          'name': 'Chrome',
          'kind': 'browser_extension',
          'location': null,
          'created_at': '2026-08-11T12:00:00Z',
          'profiles': <Map<String, dynamic>>[
            <String, dynamic>{
              'protocol': 'browser_proxy',
              'status': 'active',
              'created_at': '2026-08-11T12:00:00Z',
            },
          ],
        },
      ],
    });

    expect(devices.devices, hasLength(2));
    expect(devices.devices.first.location?.id, 'frankfurt-01');
    expect(devices.devices.last.name, 'Chrome');
    expect(devices.devices.last.location, isNull);
    expect(devices.devices.last.profiles, isEmpty);
  });
}
