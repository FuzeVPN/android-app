import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

// The Dart half of the session-renewal channel contract
// (renouvellement-session/PLAN.md): sessionUpgrade, sessionEnsureFresh and
// sessionLogout on com.fuzevpn/android_vpn. The refresh token never crosses.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('fuzevpn.renewal.contract.test');
  late List<MethodCall> calls;
  late Future<Object?> Function(MethodCall call) handler;
  late NativeSecureStore store;

  final String payload = jsonEncode(<String, String>{
    'access_token': 'synthetic-access-2',
    'expires_at': '2099-01-01T01:00:00.000Z',
  });

  setUp(() {
    calls = <MethodCall>[];
    handler = (_) async => null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
          calls.add(call);
          return handler(call);
        });
    store = NativeSecureStore(
      NativeVpnBridge(
        channel: channel,
        events: const EventChannel('fuzevpn.renewal.contract.events.test'),
      ),
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'sessionUpgrade names the account and adopts a renewable access',
    () async {
      handler = (_) async => <String, Object?>{
        'state': 'renewable',
        'payload': payload,
      };
      final SessionRenewal renewal = await store.upgradeSession(
        userId: 'account-1',
      );
      expect(calls.single.method, 'sessionUpgrade');
      expect(calls.single.arguments, {'account_id': 'account-1'});
      expect(renewal.renewable, isTrue);
      expect(renewal.session.accessToken, 'synthetic-access-2');
      expect(renewal.session.expiresAt, DateTime.utc(2099, 1, 1, 1));
      expect(renewal.toString(), isNot(contains('synthetic-access-2')));
    },
  );

  test('sessionEnsureFresh returns a classic access as it is, and leaves out '
      'an account still unknown', () async {
    handler = (_) async => <String, Object?>{
      'state': 'classic',
      'payload': payload,
    };
    final SessionRenewal known = await store.ensureFreshSession(
      userId: 'account-1',
    );
    final SessionRenewal unknown = await store.ensureFreshSession();
    expect(calls.map((call) => call.method), [
      'sessionEnsureFresh',
      'sessionEnsureFresh',
    ]);
    expect(calls[0].arguments, {'account_id': 'account-1'});
    expect(calls[1].arguments, isEmpty);
    expect(known.renewable, isFalse);
    expect(unknown.session.accessToken, 'synthetic-access-2');
  });

  test('a forced renewal (after a 401) says so; others never do', () async {
    handler = (_) async => <String, Object?>{
      'state': 'renewable',
      'payload': payload,
    };
    await store.ensureFreshSession(userId: 'account-1', force: true);
    await store.ensureFreshSession(force: true);
    await store.ensureFreshSession(userId: 'account-1');
    expect(calls[0].arguments, {'account_id': 'account-1', 'force': true});
    expect(calls[1].arguments, {'force': true});
    expect(calls[2].arguments, {'account_id': 'account-1'});
  });

  test('sessionLogout tells a renewable logout from a classic one', () async {
    handler = (_) async => <String, Object?>{'state': 'renewable'};
    expect(await store.logoutSession(userId: 'account-1'), isTrue);
    handler = (_) async => <String, Object?>{'state': 'classic'};
    expect(await store.logoutSession(), isFalse);
    expect(calls.map((call) => call.method), [
      'sessionLogout',
      'sessionLogout',
    ]);
    expect(calls[0].arguments, {'account_id': 'account-1'});
    expect(calls[1].arguments, isEmpty);
  });

  for (final entry in <String, SessionRenewalError>{
    'session_unauthorized': SessionRenewalError.unauthorized,
    'session_renewal_unavailable': SessionRenewalError.unavailable,
    'session_renewal_invalid': SessionRenewalError.invalid,
    'session_refresh_expired': SessionRenewalError.refreshExpired,
  }.entries) {
    test('${entry.key} keeps its meaning for each session method', () async {
      handler = (_) async => throw PlatformException(code: entry.key);
      final Map<String, Future<Object?> Function()> methods = {
        'sessionUpgrade': () => store.upgradeSession(userId: 'account-1'),
        'sessionEnsureFresh': () => store.ensureFreshSession(),
        'sessionLogout': () => store.logoutSession(),
      };
      for (final method in methods.entries) {
        await expectLater(
          method.value(),
          throwsA(
            isA<SessionRenewalFailure>()
                .having((failure) => failure.error, 'error', entry.value)
                .having(
                  (failure) => failure.retryAfterSeconds,
                  'retryAfterSeconds',
                  isNull,
                ),
          ),
          reason: method.key,
        );
      }
    });
  }

  test('a known Retry-After comes with an unavailable renewal', () async {
    Future<int?> retryAfter(Object? details) async {
      handler = (_) async => throw PlatformException(
        code: 'session_renewal_unavailable',
        details: details,
      );
      try {
        await store.ensureFreshSession(userId: 'account-1');
      } on SessionRenewalFailure catch (failure) {
        expect(failure.error, SessionRenewalError.unavailable);
        return failure.retryAfterSeconds;
      }
      fail('no failure');
    }

    expect(await retryAfter({'retry_after_seconds': 30}), 30);
    expect(await retryAfter({'retry_after_seconds': 999999}), 86400);
    for (final Object? malformed in <Object?>[
      null,
      'retry_after_seconds',
      {'retry_after_seconds': 0},
      {'retry_after_seconds': -5},
      {'retry_after_seconds': '30'},
      {'retry_after_seconds': 1.5},
    ]) {
      expect(await retryAfter(malformed), isNull, reason: '$malformed');
    }
  });

  test('other native failures stay native codes, renewal codes only come '
      'from the session methods', () async {
    handler = (_) async =>
        throw PlatformException(code: 'secure_storage_read_failed');
    await expectLater(
      store.ensureFreshSession(),
      throwsA(
        isA<NativeVpnException>().having(
          (error) => error.code,
          'code',
          'secure_storage_read_failed',
        ),
      ),
    );
    handler = (_) async => throw PlatformException(code: 'Session Expired!');
    await expectLater(
      store.upgradeSession(userId: 'account-1'),
      throwsA(
        isA<NativeVpnException>().having(
          (error) => error.code,
          'code',
          'native_operation_failed',
        ),
      ),
    );
    handler = (_) async =>
        throw PlatformException(code: 'session_unauthorized');
    await expectLater(
      store.readSession(),
      throwsA(
        isA<NativeVpnException>().having(
          (error) => error.code,
          'code',
          'session_unauthorized',
        ),
      ),
    );
    handler = (_) async => throw MissingPluginException();
    await expectLater(
      store.logoutSession(userId: 'account-1'),
      throwsA(
        isA<NativeVpnException>().having(
          (error) => error.code,
          'code',
          'native_bridge_unavailable',
        ),
      ),
    );
  });

  test('a malformed answer is never adopted as a session', () async {
    for (final Object? answer in <Object?>[
      null,
      'renewable',
      <String, Object?>{'state': 'renewable'},
      <String, Object?>{'state': 'unknown', 'payload': payload},
      <String, Object?>{'state': 'renewable', 'payload': 'not json'},
      <String, Object?>{'state': 'classic', 'payload': '[]'},
      <String, Object?>{
        'state': 'renewable',
        'payload': jsonEncode({'access_token': '', 'expires_at': 'never'}),
      },
      <String, Object?>{
        'state': 'renewable',
        'payload': <String, String>{'access_token': 'synthetic'},
      },
    ]) {
      handler = (_) async => answer;
      await expectLater(
        store.ensureFreshSession(userId: 'account-1'),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'native_operation_failed',
          ),
        ),
        reason: '$answer',
      );
    }
    for (final Object? answer in <Object?>[
      null,
      <String, Object?>{'state': 'renewed'},
      <String, Object?>{'payload': payload},
    ]) {
      handler = (_) async => answer;
      await expectLater(
        store.logoutSession(userId: 'account-1'),
        throwsA(isA<NativeVpnException>()),
        reason: '$answer',
      );
    }
  });

  test(
    'a storage bridge without these methods reports itself unavailable',
    () async {
      final SessionRenewalStore unsupported = NativeSecureStore(
        _PlainGateway(),
      );
      for (final Future<Object?> Function() call
          in <Future<Object?> Function()>[
            () => unsupported.upgradeSession(userId: 'account-1'),
            () => unsupported.ensureFreshSession(),
            () => unsupported.logoutSession(),
          ]) {
        await expectLater(
          call(),
          throwsA(
            isA<NativeVpnException>().having(
              (error) => error.code,
              'code',
              'native_bridge_unavailable',
            ),
          ),
        );
      }
    },
  );
}

class _PlainGateway extends Fake implements NativeStorageGateway {}
