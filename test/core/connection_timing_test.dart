import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/connection_timing.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

Map<String, dynamic> decode(String line) =>
    jsonDecode(line.substring('FuzeVpnTiming '.length)) as Map<String, dynamic>;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('collector requests never inherit the VPN timing context', () async {
    final lines = <String>[];
    await ConnectionTiming.run('connection', () async {
      await ConnectionTiming.unobserved(() async {
        expect(ConnectionTiming.currentId, isNull);
        await ConnectionTiming.measure('http.response', () async {});
        ConnectionTiming.event('http.response', status: 401);
      });
      expect(ConnectionTiming.currentId, isNotNull);
    }, sink: lines.add);
    expect(
      lines.map(decode).where((value) => value['stage'] == 'http.response'),
      isEmpty,
    );
  });

  test('nested spans correlate without logging results or failures', () async {
    final lines = <String>[];
    final failure = StateError('private-token-and-profile');
    await ConnectionTiming.run('connection', () async {
      expect(
        await ConnectionTiming.measure('prepare', () async => 'private-key'),
        'private-key',
      );
      await expectLater(
        ConnectionTiming.measure<void>('failure', () async => throw failure),
        throwsA(same(failure)),
      );
      ConnectionTiming.event('http.response', status: 503);
    }, sink: lines.add);
    final records = lines.map(decode).toList();
    expect(records.map((r) => r['trace_id']).toSet(), hasLength(1));
    expect(records.first['trace_id'], matches(r'^c[0-9]{1,31}$'));
    final parent = records.first['span_id'];
    expect(records.first['event'], 'begin');
    expect(records.last['event'], 'end');
    expect(
      records
          .where((r) => r['stage'] == 'prepare')
          .every((r) => r['parent_span_id'] == parent),
      isTrue,
    );
    expect(
      records.where((r) => r['stage'] == 'failure').last['event'],
      'error',
    );
    expect(
      records.where((r) => r['stage'] == 'http.response').single['status'],
      503,
    );
    expect(lines.join(), isNot(contains('private')));
    expect(ConnectionTiming.currentId, isNull);
  });

  test(
    'overlapping attempts and awaits keep independent trace contexts',
    () async {
      final first = Completer<void>();
      final second = Completer<void>();
      final a = <String>[];
      final b = <String>[];
      final fa = ConnectionTiming.run('connection', () async {
        await first.future;
        await ConnectionTiming.measure('after.wait', () async {});
      }, sink: a.add);
      final fb = ConnectionTiming.run('connection', () async {
        await second.future;
        ConnectionTiming.event('after.wait');
      }, sink: b.add);
      second.complete();
      await fb;
      first.complete();
      await fa;
      final idsA = a.map(decode).map((r) => r['trace_id']).toSet();
      final idsB = b.map(decode).map((r) => r['trace_id']).toSet();
      expect(idsA, hasLength(1));
      expect(idsB, hasLength(1));
      expect(idsA.intersection(idsB), isEmpty);
    },
  );

  testWidgets('pending spans emit waiting and cancel timers after failure', (
    tester,
  ) async {
    final gate = Completer<void>();
    final lines = <String>[];
    final failure = StateError('secret');
    final task = ConnectionTiming.run(
      'connection',
      () => ConnectionTiming.measure('native.wait', () => gate.future),
      sink: lines.add,
    );
    final expectation = expectLater(task, throwsA(same(failure)));
    await tester.pump(const Duration(seconds: 4));
    expect(
      lines
          .map(decode)
          .where((r) => r['stage'] == 'native.wait' && r['event'] == 'waiting'),
      hasLength(2),
    );
    gate.completeError(failure);
    await tester.pump();
    await expectation;
    final count = lines.length;
    await tester.pump(const Duration(seconds: 6));
    expect(lines, hasLength(count));
    expect(lines.map(decode).where((r) => r['event'] == 'error'), hasLength(2));
  });

  testWidgets('closing a trace cancels diagnostics for abandoned children', (
    tester,
  ) async {
    final gate = Completer<void>();
    final lines = <String>[];
    await ConnectionTiming.run('connection', () async {
      unawaited(ConnectionTiming.measure('abandoned', () => gate.future));
    }, sink: lines.add);
    final count = lines.length;
    await tester.pump(const Duration(seconds: 4));
    expect(lines, hasLength(count));
    gate.complete();
    await tester.pump();
    expect(lines, hasLength(count));
  });

  test('a failing diagnostic sink cannot change business outcomes', () async {
    expect(
      await ConnectionTiming.run(
        'connection',
        () async => 42,
        sink: (_) => throw StateError('logger failed'),
      ),
      42,
    );
    final failure = StateError('business failure');
    await expectLater(
      ConnectionTiming.run<void>(
        'connection',
        () async => throw failure,
        sink: (_) => throw StateError('logger failed'),
      ),
      throwsA(same(failure)),
    );
  });

  test('measure without a trace does not create diagnostics', () async {
    expect(
      await ConnectionTiming.measure('outside', () async {
        expect(ConnectionTiming.currentId, isNull);
        expect(ConnectionTiming.currentSpanId, isNull);
        return 42;
      }),
      42,
    );
  });

  test(
    'callbacks inherited from a finished attempt have no stale RPC context',
    () async {
      final gate = Completer<void>();
      final checked = Completer<void>();
      final lines = <String>[];
      await ConnectionTiming.run('connection', () async {
        unawaited(
          gate.future.then((_) async {
            expect(ConnectionTiming.currentId, isNull);
            expect(ConnectionTiming.currentSpanId, isNull);
            await ConnectionTiming.run('connection', () async {
              expect(ConnectionTiming.currentId, isNotNull);
            }, sink: lines.add);
            checked.complete();
          }),
        );
      }, sink: lines.add);
      gate.complete();
      await checked.future;
      expect(lines.map(decode).map((r) => r['trace_id']).toSet(), hasLength(2));
    },
  );

  const channel = MethodChannel('test.connection_timing');
  late List<MethodCall> calls;
  late NativeVpnBridge bridge;
  setUp(() {
    calls = [];
    bridge = NativeVpnBridge(channel: channel);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          if (call.method == 'requestVpnPermission') return true;
          return null;
        });
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'RPC attaches the current child span without changing business fields',
    () async {
      final lines = <String>[];
      await ConnectionTiming.run(
        'connection',
        () => bridge.prepareTunnelRequest(accountId: 'private-account'),
        sink: lines.add,
      );
      final args = calls.single.arguments as Map;
      final rpc = lines
          .map(decode)
          .firstWhere((r) => r['stage'] == 'rpc.prepareTunnelRequest');
      expect(args['account_id'], 'private-account');
      expect(args['diagnostic_trace_id'], rpc['trace_id']);
      expect(args['diagnostic_span_id'], rpc['span_id']);
      expect(lines.join(), isNot(contains('private-account')));
    },
  );

  test(
    'RPC supports null arguments and leaves untraced arguments untouched',
    () async {
      final lines = <String>[];
      expect(
        await ConnectionTiming.run(
          'connection',
          bridge.requestVpnPermission,
          sink: lines.add,
        ),
        isTrue,
      );
      expect((calls.removeLast().arguments as Map).keys.toSet(), {
        'diagnostic_trace_id',
        'diagnostic_span_id',
      });
      await bridge.prepareTunnelRequest(accountId: 'account');
      expect(calls.removeLast().arguments, {'account_id': 'account'});
      await bridge.requestVpnPermission();
      expect(calls.removeLast().arguments, isNull);
    },
  );
}
