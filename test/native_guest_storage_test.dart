import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/connection_timing.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('fuzevpn.guest.storage.test');
  final credential = base64Url
      .encode(List<int>.generate(32, (i) => i))
      .replaceAll('=', '');
  final pending = base64Url
      .encode(List<int>.generate(32, (i) => i + 32))
      .replaceAll('=', '');
  late List<MethodCall> calls;
  late Map<String, Object?> responses;
  late NativeSecureStore store;

  setUp(() {
    calls = <MethodCall>[];
    responses = <String, Object?>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return responses[call.method];
        });
    store = NativeSecureStore(NativeVpnBridge(channel: channel));
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'guest capabilities use distinct typed native operations, never free storage keys',
    () async {
      final GuestCredentialStore guest = store;
      responses['storageReadGuestCredential'] = credential;
      responses['storageReadPendingGuestCredential'] = pending;
      expect(await guest.readGuestCredential(), credential);
      expect(await guest.readPendingGuestCredential(), pending);
      await guest.writePendingGuestCredential(pending);
      await guest.writeGuestCredential(pending);
      await guest.clearGuestCredentials();
      expect(calls.map((call) => call.method), <String>[
        'storageReadGuestCredential',
        'storageReadPendingGuestCredential',
        'storageWritePendingGuestCredential',
        'storageWriteGuestCredential',
        'storageClearGuestCredentials',
      ]);
      expect(calls[2].arguments, <String, Object>{'credential': pending});
      expect(calls[3].arguments, <String, Object>{'credential': pending});
      expect(calls.last.arguments, isNull);
      for (final call in calls) {
        expect(
          call.arguments is Map && (call.arguments as Map).containsKey('key'),
          isFalse,
        );
        expect(jsonEncode(call.arguments), isNot(contains('fuzevpn.guest.')));
      }
    },
  );

  test('invalid credentials fail before crossing the method channel', () async {
    for (final invalid in <String>[
      '',
      '$credential=',
      credential.substring(1),
      '$credential\n',
      ' $credential',
      '${List.filled(42, 'A').join()}B',
    ]) {
      await expectLater(
        store.writeGuestCredential(invalid),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'invalid_guest_credential',
          ),
        ),
      );
      await expectLater(
        store.writePendingGuestCredential(invalid),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'invalid_guest_credential',
          ),
        ),
      );
    }
    expect(calls, isEmpty);
  });

  test(
    'corrupt guest storage does not become an absent recoverable credential',
    () async {
      for (final invalid in <Object>[
        'not-a-credential',
        true,
        '$credential=',
      ]) {
        responses['storageReadGuestCredential'] = invalid;
        await expectLater(
          store.readGuestCredential(),
          throwsA(
            isA<NativeVpnException>().having(
              (error) => error.code,
              'code',
              'secure_storage_corrupt',
            ),
          ),
        );
      }
      expect(
        calls.every((call) => call.method == 'storageReadGuestCredential'),
        isTrue,
      );
    },
  );

  test(
    'automatic guest recovery defaults off and accepts only native booleans',
    () async {
      expect(await store.readGuestAutoResume(), isFalse);
      responses['storageReadGuestAutoResume'] = true;
      expect(await store.readGuestAutoResume(), isTrue);
      await store.writeGuestAutoResume(false);
      expect(calls.last.arguments, <String, Object>{'enabled': false});
      responses['storageReadGuestAutoResume'] = 'true';
      await expectLater(
        store.readGuestAutoResume(),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'secure_storage_corrupt',
          ),
        ),
      );
    },
  );

  test(
    'expired cleanup preserves recovery capability; voluntary logout disables it first',
    () async {
      responses['storageClearSession'] = <String, Object>{
        'tunnel_stopped': true,
        'session_cleared': true,
      };
      await store.clearSession(expired: true);
      expect(calls.single.method, 'storageClearSession');
      expect(calls.single.arguments, <String, Object>{'session_expired': true});
      calls.clear();
      await store.writeGuestAutoResume(false);
      await store.clearSession();
      expect(calls.map((call) => call.method), <String>[
        'storageWriteGuestAutoResume',
        'storageClearSession',
      ]);
      expect(calls[0].arguments, <String, Object>{'enabled': false});
      expect(calls[1].arguments, <String, Object>{'session_expired': false});
      expect(
        calls.any((call) => call.method == 'storageClearGuestCredentials'),
        isFalse,
      );
    },
  );

  test(
    'renewal is a single same-owner operation without erasing identities or devices',
    () async {
      final GuestSessionRenewalStore renewal = store;
      final session = AuthSession(
        accessToken: 'renewal-token-fixture',
        expiresAt: DateTime.utc(2027, 1, 2),
      );
      await renewal.replaceGuestSession(session, userId: 'guest-a');
      expect(calls.single.method, 'storageReplaceGuestSession');
      final arguments = calls.single.arguments as Map;
      expect(arguments['account_id'], 'guest-a');
      expect(jsonDecode(arguments['payload'] as String), <String, String>{
        'access_token': session.accessToken,
        'expires_at': session.expiresAt.toIso8601String(),
      });
      expect(arguments.containsKey('credential'), isFalse);
      expect(arguments.containsKey('device_id'), isFalse);
    },
  );

  test(
    'credential and token values never enter timing records or exception messages',
    () async {
      final logs = <String>[];
      await ConnectionTiming.run('test.guest_storage', () async {
        await store.writePendingGuestCredential(credential);
        await store.writeGuestCredential(credential);
        await store.replaceGuestSession(
          AuthSession(
            accessToken: 'renewal-token-fixture',
            expiresAt: DateTime.utc(2027),
          ),
          userId: 'guest-a',
        );
      }, sink: logs.add);
      expect(logs, isNotEmpty);
      final encodedLogs = logs.join('\n');
      expect(encodedLogs, isNot(contains(credential)));
      expect(encodedLogs, isNot(contains('renewal-token-fixture')));
      expect(encodedLogs, isNot(contains('guest-a')));

      final lowercaseCredential = '${List.filled(42, 'a').join()}c';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
            throw PlatformException(
              code: lowercaseCredential,
              message: lowercaseCredential,
              details: lowercaseCredential,
            );
          });
      await expectLater(
        store.writeGuestCredential(lowercaseCredential),
        throwsA(
          isA<NativeVpnException>()
              .having((error) => error.code, 'code', 'native_operation_failed')
              .having(
                (error) => error.toString(),
                'message',
                isNot(contains(lowercaseCredential)),
              ),
        ),
      );
    },
  );

  test(
    'an account-only adapter cannot silently opt in to guest recovery',
    () async {
      final accountOnly = NativeSecureStore(_AccountOnlyStorage());
      expect(await accountOnly.readGuestAutoResume(), isFalse);
      await expectLater(
        accountOnly.writeGuestCredential(credential),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'native_bridge_unavailable',
          ),
        ),
      );
      await expectLater(
        accountOnly.replaceGuestSession(
          AuthSession(
            accessToken: 'renewal-token-fixture',
            expiresAt: DateTime.utc(2027),
          ),
          userId: 'guest-a',
        ),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'native_bridge_unavailable',
          ),
        ),
      );
    },
  );
}

class _AccountOnlyStorage extends Fake implements NativeStorageGateway {}
