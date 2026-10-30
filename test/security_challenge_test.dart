import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/security_challenge.dart';

const _id = 'request_fixture_0001';
const _otherId = 'request_fixture_0002';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('security.challenge.fixture');
  late NativeSecurityChallengeGateway gateway;
  late Future<Object?> Function(MethodCall) handler;
  late List<MethodCall> calls;
  setUp(() {
    gateway = NativeSecurityChallengeGateway(channel: channel);
    calls = [];
    handler = (call) async => call.method == 'solve'
        ? {
            'requestId': (call.arguments as Map)['requestId'],
            'token': 'proof-fixture',
          }
        : null;
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
  Future<SecurityChallengeResult> solve([String id = _id]) => gateway.solve(
    requestId: id,
    title: 'Security check',
    cancelLabel: 'Cancel',
  );
  Matcher fails(String code) => throwsA(
    isA<SecurityChallengeException>().having(
      (error) => error.code,
      'code',
      code,
    ),
  );

  test(
    'explicit widget channel contains public labels and no account data',
    () async {
      final result = await solve();
      expect(calls.single.method, 'solve');
      expect(calls.single.arguments, {
        'requestId': _id,
        'title': 'Security check',
        'cancelLabel': 'Cancel',
      });
      expect(result.token, 'proof-fixture');
      expect(result.toString(), isNot(contains('proof-fixture')));
    },
  );

  test('malformed or cross-request callbacks cannot deliver a token', () async {
    for (final raw in [
      {'requestId': _otherId, 'token': 'proof-fixture'},
      {'requestId': _id, 'token': ''},
      {'requestId': _id, 'token': 'proof-fixture\n'},
      {'requestId': _id, 'token': 'a' * 2049},
      {
        'requestId': _id,
        'token': 'proof-fixture',
        'email': 'synthetic@example.invalid',
      },
      'provider-message-fixture',
    ]) {
      handler = (_) async => raw;
      await expectLater(solve(), fails('invalid_response'));
    }
  });

  test(
    'invalid ids and presentation arguments never reach native code',
    () async {
      for (final id in ['', 'short', '$_id\n', 'a' * 129]) {
        await expectLater(solve(id), fails('invalid_request'));
      }
      await expectLater(
        gateway.solve(
          requestId: _id,
          title: 'private\nlabel',
          cancelLabel: 'Cancel',
        ),
        fails('invalid_request'),
      );
      expect(calls, isEmpty);
    },
  );

  test('label bounds and ISO controls match the native policy', () async {
    for (final (title, cancelLabel) in [
      ('a' * 121, 'Cancel'),
      ('Security', 'a' * 65),
      ('Security\u0085', 'Cancel'),
      ('Security', 'Cancel\u009f'),
    ]) {
      await expectLater(
        gateway.solve(requestId: _id, title: title, cancelLabel: cancelLabel),
        fails('invalid_request'),
      );
    }
    expect(calls, isEmpty);
    await gateway.solve(
      requestId: _id,
      title: 'a' * 120,
      cancelLabel: 'b' * 64,
    );
    expect(calls, hasLength(1));
  });

  test('native provider details are sanitized', () async {
    handler = (_) async => throw PlatformException(
      code: 'private-provider-value',
      message: 'private-provider-value',
      details: {'token': 'private-provider-value'},
    );
    await expectLater(solve(), fails('provider_error'));
    expect(
      SecurityChallengeException('private-provider-value').toString(),
      isNot(contains('private-provider-value')),
    );
  });

  test(
    'one solver owns the channel and cancel rejects without waiting for its callback',
    () async {
      final old = Completer<Object?>();
      handler = (call) =>
          call.method == 'solve' ? old.future : Future.value(null);
      final pending = solve();
      final expectedCancellation = expectLater(pending, fails('cancelled'));
      await Future<void>.delayed(Duration.zero);
      await expectLater(solve(_otherId), fails('busy'));
      await gateway.cancel(requestId: _id);
      await expectedCancellation;
      expect(calls.last.method, 'cancel');
      expect(calls.last.arguments, {'requestId': _id});
      handler = (_) async => {'requestId': _id, 'token': 'new-proof-fixture'};
      final retry = await solve();
      old.complete({'requestId': _id, 'token': 'late-proof-fixture'});
      await Future<void>.delayed(Duration.zero);
      expect(retry.token, 'new-proof-fixture');
    },
  );

  test(
    'the Dart guard outlives the native Turnstile deadline it backs up',
    () {
      final policy = File(
        'android/app/src/main/kotlin/com/fuzevpn/android/TurnstilePolicy.kt',
      ).readAsStringSync();
      final nativeMillis = int.parse(
        RegExp(
          r'const val TIMEOUT_MS = ([0-9_]+)L',
        ).firstMatch(policy)!.group(1)!.replaceAll('_', ''),
      );
      expect(
        NativeSecurityChallengeGateway.defaultSolveTimeout,
        greaterThan(Duration(milliseconds: nativeMillis)),
      );
    },
  );

  test(
    'a solver that never answers fails as a provider error, not a cancellation',
    () async {
      gateway = NativeSecurityChallengeGateway(
        channel: channel,
        solveTimeout: const Duration(milliseconds: 20),
      );
      handler = (call) => call.method == 'solve'
          ? Completer<Object?>().future
          : Future.value(null);
      await expectLater(solve(), fails('provider_error'));
      await Future<void>.delayed(Duration.zero);
      expect(calls.last.method, 'cancel');
      expect(calls.last.arguments, {'requestId': _id});
    },
  );

  test('cancelling another request leaves the active solver intact', () async {
    final response = Completer<Object?>();
    handler = (call) =>
        call.method == 'solve' ? response.future : Future.value(null);
    final pending = solve();
    await Future<void>.delayed(Duration.zero);
    await gateway.cancel(requestId: _otherId);
    response.complete({'requestId': _id, 'token': 'current-proof-fixture'});
    expect((await pending).token, 'current-proof-fixture');
  });
}
