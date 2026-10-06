import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';

const _clientId = '123456789-fixture.apps.googleusercontent.com';
const _nonce = 'nonce-fixture-private';
const _token = 'fixture.header.signature';
String _repeat(String value, int count) =>
    List<String>.filled(count, value).join();
Map<String, Object> _pending({String stage = 'challenge'}) => <String, Object>{
  'version': 1,
  'request_id': 'request-fixture',
  'purpose': 'claim',
  'stage': stage,
  'ticket': 'private-api-ticket-fixture',
  'context': 'private-browser-context-fixture',
  'expires_at': '2099-01-01T00:00:00Z',
  'generation': 1,
  'challenge_id': 'challenge-fixture',
  'user_id': 'guest-fixture',
};
Matcher _failure(String code) => throwsA(
  isA<GoogleCredentialException>().having((error) => error.code, 'code', code),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('fuzevpn.google.auth.test');
  late NativeGoogleCredentialGateway gateway;
  late List<MethodCall> calls;
  late Future<Object?> Function(MethodCall) handler;

  setUp(() {
    calls = <MethodCall>[];
    gateway = NativeGoogleCredentialGateway(channel: channel);
    handler = (call) async => switch (call.method) {
      'getCapabilities' => <String, Object?>{'supported': true, 'reason': null},
      'signIn' => <String, Object>{
        'requestId': (call.arguments as Map)['requestId'] as String,
        'idToken': _token,
      },
      _ => null,
    };
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return handler(call);
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  Future<GoogleCredentialResult> signIn([
    String requestId = 'request-fixture',
  ]) => gateway.signIn(
    requestId: requestId,
    serverClientId: _clientId,
    nonce: _nonce,
  );

  test(
    'capability inspection requests no accounts or credentials and launches no picker',
    () async {
      expect((await gateway.getCapabilities()).supported, isTrue);
      expect(calls.map((call) => call.method), <String>['getCapabilities']);
      expect(calls.single.arguments, isNull);
      handler = (_) async => <String, Object?>{
        'supported': false,
        'reason': 'unavailable',
      };
      final capability = await gateway.getCapabilities();
      expect(capability.supported, isFalse);
      expect(capability.reason, 'unavailable');
    },
  );

  test(
    'capabilities reject provider messages and undocumented values',
    () async {
      for (final raw in <Object>[
        <String, Object>{
          'supported': false,
          'reason': 'private-provider-message',
        },
        <String, Object>{'supported': true, 'reason': 'unavailable'},
        <String, Object>{'supported': true, 'email': 'person@example.test'},
        <String, Object>{'supported': 'true'},
        <Object>[],
      ]) {
        handler = (_) async => raw;
        await expectLater(
          gateway.getCapabilities(),
          _failure('invalid_response'),
        );
      }
    },
  );

  test(
    'Google ID token crosses only the explicit typed request and has a redacted representation',
    () async {
      final credential = await signIn();
      expect(calls.single.method, 'signIn');
      expect(calls.single.arguments, <String, Object>{
        'requestId': 'request-fixture',
        'serverClientId': _clientId,
        'nonce': _nonce,
      });
      expect(credential.idToken, _token);
      expect(credential.requestId, 'request-fixture');
      expect(credential.toString(), isNot(contains(_token)));
      expect(calls.where((call) => call.method.contains('Pending')), isEmpty);
    },
  );

  test(
    'invalid audience nonce and request ID are rejected before native calls',
    () async {
      for (final values in <(String, String, String)>[
        ('', _clientId, _nonce),
        ('person@example.test', _clientId, _nonce),
        ('request-fixture\n', _clientId, _nonce),
        ('request-fixture', 'https://accounts.google.com', _nonce),
        ('request-fixture', '$_clientId\n', _nonce),
        ('request-fixture', _clientId, ''),
        ('request-fixture', _clientId, 'private nonce'),
        ('request-fixture', _clientId, _repeat('n', 1025)),
      ]) {
        await expectLater(
          gateway.signIn(
            requestId: values.$1,
            serverClientId: values.$2,
            nonce: values.$3,
          ),
          _failure('invalid_request'),
        );
      }
      await expectLater(
        gateway.cancelSignIn(requestId: ''),
        _failure('invalid_request'),
      );
      expect(calls, isEmpty);
    },
  );

  test(
    'a second picker is refused while the first future is pending',
    () async {
      final entered = Completer<void>();
      final response = Completer<Object?>();
      handler = (_) {
        entered.complete();
        return response.future;
      };
      final first = signIn('one');
      await entered.future;
      await expectLater(signIn('two'), _failure('busy'));
      expect(calls, hasLength(1));
      response.complete(<String, Object>{
        'requestId': 'one',
        'idToken': _token,
      });
      expect((await first).requestId, 'one');
      handler = (call) async => <String, Object>{
        'requestId': 'two',
        'idToken': _token,
      };
      expect((await signIn('two')).requestId, 'two');
    },
  );

  test(
    'a cancelled late callback cannot adopt or clear a retry with the same request ID',
    () async {
      final replies = <Completer<Object?>>[];
      final entered = <Completer<void>>[Completer<void>(), Completer<void>()];
      handler = (call) async {
        if (call.method != 'signIn') return null;
        final reply = Completer<Object?>();
        replies.add(reply);
        entered[replies.length - 1].complete();
        return reply.future;
      };
      final first = signIn();
      await entered.first.future;
      await gateway.cancelSignIn(requestId: 'request-fixture');
      final rejected = expectLater(first, _failure('cancelled'));
      final second = signIn();
      await entered.last.future;
      replies.first.complete(<String, Object>{
        'requestId': 'request-fixture',
        'idToken': 'old.fixture.token',
      });
      await rejected;
      replies.last.complete(<String, Object>{
        'requestId': 'request-fixture',
        'idToken': _token,
      });
      expect((await second).idToken, _token);
      expect(calls.map((call) => call.method), <String>[
        'signIn',
        'cancelSignIn',
        'signIn',
      ]);
    },
  );

  test(
    'cancelling another request leaves the current picker correlation intact',
    () async {
      final entered = Completer<void>();
      final response = Completer<Object?>();
      handler = (call) {
        if (call.method != 'signIn') return Future<Object?>.value();
        entered.complete();
        return response.future;
      };
      final pending = signIn('one');
      await entered.future;
      await gateway.cancelSignIn(requestId: 'two');
      response.complete(<String, Object>{
        'requestId': 'one',
        'idToken': _token,
      });
      expect((await pending).requestId, 'one');
    },
  );

  test(
    'credential-state clearing invalidates the old picker without exposing its late token',
    () async {
      final entered = Completer<void>();
      final response = Completer<Object?>();
      handler = (call) {
        if (call.method != 'signIn') return Future<Object?>.value();
        entered.complete();
        return response.future;
      };
      final pending = signIn();
      await entered.future;
      await gateway.clearCredentialState();
      final rejected = expectLater(pending, _failure('cancelled'));
      response.complete(<String, Object>{
        'requestId': 'request-fixture',
        'idToken': _token,
      });
      await rejected;
      expect(calls.map((call) => call.method), <String>[
        'signIn',
        'clearCredentialState',
      ]);
    },
  );

  test(
    'provider exception code message and details are restricted to closed errors',
    () async {
      const secret = 'lowercaseprivatetokenfixture';
      handler = (_) async => throw PlatformException(
        code: secret,
        message: secret,
        details: <String, Object>{'idToken': _token},
      );
      try {
        await signIn();
        fail('expected provider failure');
      } on GoogleCredentialException catch (error) {
        expect(error.code, 'provider_error');
        expect(error.toString(), isNot(contains(secret)));
        expect(error.toString(), isNot(contains(_token)));
      }
      handler = (_) async => throw PlatformException(
        code: 'cancelled',
        message: secret,
        details: secret,
      );
      await expectLater(signIn(), _failure('cancelled'));
      handler = (_) async => throw MissingPluginException(secret);
      await expectLater(signIn(), _failure('unavailable'));
    },
  );

  test('mismatched or malformed token responses cannot be adopted', () async {
    for (final raw in <Object?>[
      null,
      <String, Object>{'requestId': 'other-request', 'idToken': _token},
      <String, Object>{'requestId': 'request-fixture', 'idToken': ''},
      <String, Object>{
        'requestId': 'request-fixture',
        'idToken': 'private\ntoken',
      },
      <String, Object>{
        'requestId': 'request-fixture',
        'idToken': _repeat('t', 65537),
      },
      <String, Object>{
        'requestId': 'request-fixture',
        'idToken': _token,
        'email': 'person@example.test',
      },
    ]) {
      handler = (_) async => raw;
      await expectLater(signIn(), _failure('invalid_response'));
    }
  });

  test(
    'private API continuation uses only the dedicated typed pending operations',
    () async {
      final payload = jsonEncode(_pending());
      String? saved;
      handler = (call) async {
        if (call.method == 'writePendingAuthentication') {
          saved = (call.arguments as Map)['payload'] as String;
        }
        if (call.method == 'clearPendingAuthentication') saved = null;
        return call.method == 'readPendingAuthentication' ? saved : null;
      };
      final GooglePendingAuthStore store = gateway;
      expect(await store.readPendingAuthentication(), isNull);
      await store.writePendingAuthentication(payload);
      expect(await store.readPendingAuthentication(), payload);
      await store.clearPendingAuthentication();
      expect(await store.readPendingAuthentication(), isNull);
      expect(calls.map((call) => call.method), <String>[
        'readPendingAuthentication',
        'writePendingAuthentication',
        'readPendingAuthentication',
        'clearPendingAuthentication',
        'readPendingAuthentication',
      ]);
      expect(calls[1].arguments, <String, Object>{'payload': payload});
      expect((calls[1].arguments as Map).containsKey('key'), isFalse);
    },
  );

  test(
    'Google JWT credentials and personal fields are rejected before persisting',
    () async {
      for (final key in <String>[
        'idToken',
        'id_token',
        'credential',
        'jwt',
        'email',
        'name',
        'nonce',
      ]) {
        await expectLater(
          gateway.writePendingAuthentication(
            jsonEncode(<String, Object>{..._pending(), key: _token}),
          ),
          _failure('invalid_pending_authentication'),
        );
      }
      expect(calls, isEmpty);
    },
  );

  test(
    'pending schema sizes purpose stage and generations are validated before native storage',
    () async {
      for (final overrides in <Map<String, Object?>>[
        <String, Object?>{
          'context': <String, Object>{'email': 'person@example.test'},
        },
        <String, Object?>{'version': '1'},
        <String, Object?>{'purpose': 'purchase'},
        <String, Object?>{'stage': 'authenticated'},
        <String, Object?>{'generation': 0},
        <String, Object?>{'generation': 1.5},
        <String, Object?>{'generation': 9007199254740992},
        <String, Object?>{'expires_at': '2099-01-01'},
        <String, Object?>{'expires_at': '2099-02-30T00:00:00Z'},
        <String, Object?>{'expires_at': '2099-01-01T00:00:00+18:01'},
        <String, Object?>{'ticket': _repeat('t', 8193)},
        <String, Object?>{'ticket': 'private\nticket'},
        <String, Object?>{'user_id': null},
      ]) {
        await expectLater(
          gateway.writePendingAuthentication(
            jsonEncode(<String, Object?>{..._pending(), ...overrides}),
          ),
          _failure('invalid_pending_authentication'),
        );
      }
      await expectLater(
        gateway.writePendingAuthentication(
          '${_repeat(' ', 16384)}${jsonEncode(_pending())}',
        ),
        _failure('invalid_pending_authentication'),
      );
      expect(calls, isEmpty);
    },
  );

  test(
    'corrupt continuation is distinguished from missing data and never cleared automatically',
    () async {
      handler = (_) async => '{private-corrupt-fixture}';
      await expectLater(
        gateway.readPendingAuthentication(),
        _failure('secure_storage_corrupt'),
      );
      expect(calls.map((call) => call.method), <String>[
        'readPendingAuthentication',
      ]);
      handler = (_) async => jsonEncode(<String, Object>{
        ..._pending(stage: 'uncertain'),
        'expires_at': '2020-01-01T00:00:00Z',
      });
      expect(await gateway.readPendingAuthentication(), isNotNull);
      expect(calls.any((call) => call.method.startsWith('clear')), isFalse);
    },
  );
}
