import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('fuzevpn.storage.contract.test');
  late List<MethodCall> calls;
  late Map<String, Object?> responses;
  late NativeVpnBridge bridge;
  late NativeSecureStore store;

  setUp(() {
    calls = <MethodCall>[];
    responses = <String, Object?>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
          calls.add(call);
          return responses[call.method];
        });
    bridge = NativeVpnBridge(
      channel: channel,
      events: const EventChannel('fuzevpn.storage.contract.events.test'),
    );
    store = NativeSecureStore(bridge);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'favorites persist with typed IDs and no arbitrary storage keys',
    () async {
      expect(await store.readFavoriteLocations(), isEmpty);
      responses['storageReadFavoriteLocations'] = ['fr-01', 'de-02', 'fr-01'];
      expect(await store.readFavoriteLocations(), {'fr-01', 'de-02'});
      await store.writeFavoriteLocations({'fr-01', 'de-02'});
      expect(calls.last.method, 'storageWriteFavoriteLocations');
      expect(calls.last.arguments, {
        'value': ['de-02', 'fr-01'],
      });
      responses['storageReadFavoriteLocations'] = ['../invalid'];
      await expectLater(
        store.readFavoriteLocations(),
        throwsA(isA<NativeVpnException>()),
      );
    },
  );

  test(
    'diagnostic consent is a typed encrypted preference, disabled by default',
    () async {
      expect(await store.readAutomaticDiagnostics(), isFalse);
      responses['storageReadAutomaticDiagnostics'] = true;
      expect(await store.readAutomaticDiagnostics(), isTrue);
      responses['storageReadAutomaticDiagnostics'] = false;
      expect(await store.readAutomaticDiagnostics(), isFalse);
      await store.writeAutomaticDiagnostics(true);
      await store.writeAutomaticDiagnostics(false);
      expect(calls.map((call) => call.method), [
        'storageReadAutomaticDiagnostics',
        'storageReadAutomaticDiagnostics',
        'storageReadAutomaticDiagnostics',
        'storageWriteAutomaticDiagnostics',
        'storageWriteAutomaticDiagnostics',
      ]);
      expect(calls[3].arguments, {'value': true});
      expect(calls[4].arguments, {'value': false});
    },
  );

  test(
    'a malformed consent response cannot enable automatic diagnostics',
    () async {
      responses['storageReadAutomaticDiagnostics'] = 'true';
      await expectLater(
        store.readAutomaticDiagnostics(),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'secure_storage_corrupt',
          ),
        ),
      );
      expect(calls.single.method, 'storageReadAutomaticDiagnostics');
    },
  );

  test(
    'metadata uses its read-only method and keeps real version and build',
    () async {
      responses['getDiagnosticMetadata'] = <String, Object?>{
        'app_version': '1.2.3',
        'app_build': 123,
        'environment': <String, Object?>{
          'os_family': 'android',
          'os_major': 16,
          'android_sdk': 36,
          'architecture': 'arm64',
          'build_mode': 'release',
          'network_type': 'wifi',
        },
      };
      final DiagnosticPlatformGateway platform = bridge;
      expect(
        await platform.diagnosticMetadata(),
        responses['getDiagnosticMetadata'],
      );
      expect(calls.single.method, 'getDiagnosticMetadata');
      expect(calls.single.arguments, isNull);
    },
  );

  test(
    'diagnostic snapshot never invokes the ordinary state polling command',
    () async {
      responses['getDiagnosticSnapshot'] = <String, Object?>{
        'status': 'connected',
        'protocol': 'wireguard',
        'sent_bytes': 0,
        'received_bytes': 31,
        'system_protection': {'always_on': false},
      };
      final state = await bridge.diagnosticSnapshot();
      expect(state.phase, VpnRuntimePhase.connected);
      expect(state.sentBytes, 0);
      expect(state.receivedBytes, 31);
      expect(state.systemProtection.alwaysOn, isFalse);
      expect(state.systemProtection.lockdown, isNull);
      expect(state.locationId, isNull);
      expect(calls.single.method, 'getDiagnosticSnapshot');
      expect(calls.single.arguments, isNull);
    },
  );

  test(
    'absent diagnostic snapshot is not represented as observed idle',
    () async {
      await expectLater(
        bridge.diagnosticSnapshot(),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'diagnostic_snapshot_unavailable',
          ),
        ),
      );
    },
  );

  test(
    'missing metadata fails without inventing version information',
    () async {
      await expectLater(
        bridge.diagnosticMetadata(),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'diagnostic_metadata_unavailable',
          ),
        ),
      );
    },
  );

  test(
    'export passes one JSON object and distinguishes cancellation from success',
    () async {
      const json = '{"schema_version":1}';
      responses['exportDiagnosticReport'] = false;
      expect(await bridge.exportDiagnosticReport(json), isFalse);
      responses['exportDiagnosticReport'] = true;
      expect(await bridge.exportDiagnosticReport(json), isTrue);
      expect(calls.map((call) => call.method), [
        'exportDiagnosticReport',
        'exportDiagnosticReport',
      ]);
      expect(
        calls.every((call) => (call.arguments as Map)['json'] == json),
        isTrue,
      );
    },
  );

  test(
    'an absent export result is a failure, not a reported successful export',
    () async {
      await expectLater(
        bridge.exportDiagnosticReport('{}'),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'diagnostic_export_failed',
          ),
        ),
      );
    },
  );

  for (final malformed in [
    'not-json',
    '{}',
    '{"device_id":"another-device"}',
  ]) {
    test(
      'malformed migration is reported without automatic deletion ($malformed)',
      () async {
        responses['storageReadLocationMigration'] = malformed;
        await expectLater(
          store.readLocationMigration(userId: 'user-a', deviceId: 'device-a'),
          throwsA(isA<CorruptLocationMigration>()),
        );
        expect(calls.map((call) => call.method), [
          'storageReadLocationMigration',
        ]);
        expect(calls.single.arguments, {
          'account_id': 'user-a',
          'device_id': 'device-a',
        });
      },
    );
  }

  test(
    'valid persisted migration keeps the existing wire format and device binding',
    () async {
      const migration = DeviceLocationMigration(
        migrationId: 'migration-a',
        deviceId: 'device-a',
        sourceLocationId: 'frankfurt-01',
        targetLocationId: 'frankfurt-02',
        status: LocationMigrationStatus.blocked,
      );
      responses['storageReadLocationMigration'] = jsonEncode(
        migration.toStorageJson(),
      );
      final result = await store.readLocationMigration(
        userId: 'user-a',
        deviceId: 'device-a',
      );
      expect(result?.migrationId, 'migration-a');
      expect(result?.deviceId, 'device-a');
      expect(result?.status, LocationMigrationStatus.blocked);
      expect(calls, hasLength(1));
      expect(migration.toStorageJson().containsKey('user_id'), isFalse);
    },
  );

  test(
    'session operations never expose a caller-selected storage key',
    () async {
      final AuthSession session = AuthSession(
        accessToken: 'secret-token',
        expiresAt: DateTime.utc(2027, 1, 2, 3, 4, 5),
      );

      await store.writeSession(session);
      await store.writeSession(session, userId: 'user-a');
      responses['storageReadSession'] = jsonEncode(<String, String>{
        'access_token': session.accessToken,
        'expires_at': session.expiresAt.toIso8601String(),
      });
      final AuthSession? restored = await store.readSession();
      await store.clearSession();

      expect(restored?.accessToken, session.accessToken);
      expect(calls.map((MethodCall call) => call.method), <String>[
        'storageWritePendingSession',
        'storageWriteAccountSession',
        'storageReadSession',
        'storageClearSession',
      ]);
      _expectNoFreeStorageKeys(calls);
    },
  );

  test('device and migration use dedicated native operations', () async {
    const DeviceLocationMigration migration = DeviceLocationMigration(
      migrationId: 'migration-a',
      deviceId: 'device-a',
      sourceLocationId: 'frankfurt-01',
      targetLocationId: 'frankfurt-02',
      status: LocationMigrationStatus.draining,
      retryAfterSeconds: 4,
    );

    await store.writeCurrentDeviceId(userId: 'user-a', deviceId: 'device-a');
    await store.writeLocationMigration(userId: 'user-a', migration: migration);
    await store.clearLocationMigration(userId: 'user-a', deviceId: 'device-a');

    expect(calls.map((MethodCall call) => call.method), <String>[
      'storageWriteCurrentDevice',
      'storageWriteLocationMigration',
      'storageClearLocationMigration',
    ]);
    final Map<Object?, Object?> migrationArguments =
        calls[1].arguments as Map<Object?, Object?>;
    expect(migrationArguments['device_id'], 'device-a');
    expect(migrationArguments['payload'], contains('migration-a'));
    _expectNoFreeStorageKeys(calls);
  });

  test('application preferences are compile-time operations', () async {
    responses['storageReadThemeMode'] = 'dark';
    responses['storageReadVerificationNeeded'] = true;

    expect(await store.readThemeMode(), 'dark');
    await store.writeLocale('de');
    await store.writeLocale(null);
    await store.writeSelectedProtocol('openvpn');
    await store.writeSelectedLocation('frankfurt-02');
    expect(await store.readVerificationNeeded(userId: 'user-a'), isTrue);
    await store.writeVerificationNeeded(userId: 'user-a', value: false);

    expect(calls.map((MethodCall call) => call.method), <String>[
      'storageReadThemeMode',
      'storageWriteLocale',
      'storageWriteLocale',
      'storageWriteProtocol',
      'storageWriteLocation',
      'storageReadVerificationNeeded',
      'storageWriteVerificationNeeded',
    ]);
    _expectNoFreeStorageKeys(calls);
  });

  test('certificate lifetime exposes metadata only', () async {
    responses['getOpenVpnCertificateStatus'] = <String, Object?>{
      'status': 'expiring',
      'not_after': '2026-09-03T12:00:00Z',
      'renewal_pending': true,
    };

    final OpenVpnCertificateStatus status = await bridge
        .getOpenVpnCertificateStatus(accountId: 'user-a', deviceId: 'device-a');

    expect(status.phase, OpenVpnCertificatePhase.expiring);
    expect(status.notAfter, DateTime.utc(2026, 9, 3, 12));
    expect(status.renewalPending, isTrue);
    expect(status.requiresRenewal, isTrue);
    expect(calls.single.method, 'getOpenVpnCertificateStatus');
    expect(jsonEncode(calls.single.arguments), isNot(contains('certificate')));
    expect(jsonEncode(calls.single.arguments), isNot(contains('profile')));
  });

  test(
    'cleanup reports stop and erase independently and fails closed',
    () async {
      responses['storageClearSession'] = <String, Object?>{
        'tunnel_stopped': false,
        'session_cleared': true,
        'stop_error': 'openvpn_stop_timeout',
        'in_progress': false,
        'session_expired': true,
      };
      final result = await store.clearSession(expired: true);
      expect((calls.last.arguments as Map)['session_expired'], isTrue);
      expect(result.sessionExpired, isTrue);
      expect(result.isComplete, isFalse);
      expect(result.tunnelStopped, isFalse);
      expect(result.sessionCleared, isTrue);
      expect(result.stopError, 'openvpn_stop_timeout');
      responses['storageClearSession'] = null;
      expect((await store.clearSession()).isComplete, isFalse);
      responses['storageClearSession'] = <String, Object?>{
        'tunnel_stopped': true,
        'session_cleared': true,
      };
      expect((await store.clearSession()).isComplete, isTrue);
    },
  );

  test(
    'an unreadable session requests common termination in the controller',
    () async {
      responses['storageReadSession'] = 'invalid-json';
      await expectLater(
        store.readSession(),
        throwsA(isA<NativeVpnException>()),
      );
      expect(calls.map((call) => call.method), ['storageReadSession']);
    },
  );

  test(
    'pending cleanup survives a native snapshot and filters unsafe errors',
    () {
      final state = VpnRuntimeState.fromWire(<String, Object?>{
        'phase': 'error',
        'session_termination': <String, Object?>{
          'tunnel_stopped': true,
          'session_cleared': false,
          'storage_error': 'secure_storage_write_failed',
          'stop_error': 'secret detail!',
        },
      });
      expect(state.sessionTermination?.tunnelStopped, isTrue);
      expect(state.sessionTermination?.sessionCleared, isFalse);
      expect(
        state.sessionTermination?.storageError,
        'secure_storage_write_failed',
      );
      expect(state.sessionTermination?.stopError, isNull);
    },
  );

  test('system protection uses dedicated Android calls', () async {
    responses['getSystemVpnProtection'] = <String, Object?>{
      'always_on': true,
      'lockdown': true,
      'resume_state': 'restoring',
    };

    final SystemVpnProtection protection = await bridge
        .getSystemVpnProtection();
    await bridge.openVpnSettings();
    await bridge.disconnectByUser();
    await bridge.prepareTunnelRequest(accountId: 'user-a');

    expect(protection.isActive, isTrue);
    expect(protection.resumeState, SystemProtectionResumeState.restoring);
    expect(calls.map((MethodCall call) => call.method), <String>[
      'getSystemVpnProtection',
      'openVpnSettings',
      'disconnectByUser',
      'prepareTunnelRequest',
    ]);
    expect(calls.last.arguments, <String, Object?>{'account_id': 'user-a'});
  });
}

void _expectNoFreeStorageKeys(List<MethodCall> calls) {
  const List<String> forbidden = <String>[
    'session.pending',
    'session.current',
    'session.active_user',
    'device.current',
    'device.location_migration.',
    'preference.',
  ];
  for (final MethodCall call in calls) {
    final String encodedArguments = jsonEncode(call.arguments);
    final Object? arguments = call.arguments;
    expect(arguments is Map && arguments.containsKey('key'), isFalse);
    for (final String key in forbidden) {
      expect(encodedArguments, isNot(contains(key)));
    }
  }
}
