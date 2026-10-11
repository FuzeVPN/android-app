// SPDX-License-Identifier: MPL-2.0
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('test.vpn_disclosure');
  late List<MethodCall> calls;
  late Object? status;
  late bool permission;
  setUp(() {
    calls = [];
    status = {'accepted': false, 'android_permission': false};
    permission = true;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          if (call.method == 'getVpnDisclosureStatus') return status;
          if (call.method == 'requestVpnPermission') return permission;
          throw StateError('Unexpected native operation');
        });
  });
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null),
  );
  for (final androidPermission in [false, true]) {
    test(
      'old Android permission $androidPermission never substitutes for disclosure',
      () async {
        status = {'accepted': false, 'android_permission': androidPermission};
        var prompts = 0;
        final bridge = NativeVpnBridge(
          channel: channel,
          confirmVpnUse: () async {
            prompts++;
            return false;
          },
        );
        await expectLater(
          bridge.requestVpnPermission(),
          throwsA(isA<VpnDisclosureCancelled>()),
        );
        expect(prompts, 1);
        expect(calls.map((c) => c.method), ['getVpnDisclosureStatus']);
      },
    );
  }
  test('explicit acceptance precedes Android request', () async {
    final bridge = NativeVpnBridge(
      channel: channel,
      confirmVpnUse: () async {
        expect(calls.map((c) => c.method), ['getVpnDisclosureStatus']);
        return true;
      },
    );
    expect(await bridge.requestVpnPermission(), isTrue);
    expect(calls.last.arguments, {'disclosure_accepted': true});
  });
  test(
    'Android refusal does not grant a tunnel and next attempt discloses again',
    () async {
      permission = false;
      var prompts = 0;
      final bridge = NativeVpnBridge(
        channel: channel,
        confirmVpnUse: () async {
          prompts++;
          return true;
        },
      );
      expect(await bridge.requestVpnPermission(), isFalse);
      permission = true;
      expect(await bridge.requestVpnPermission(), isTrue);
      expect(prompts, 2);
    },
  );
  test(
    'current acceptance and Android authorization reuse the approved flow',
    () async {
      status = {'accepted': true, 'android_permission': true};
      final bridge = NativeVpnBridge(
        channel: channel,
        confirmVpnUse: () async => throw StateError('Should not prompt'),
      );
      expect(await bridge.requestVpnPermission(), isTrue);
      expect(calls.last.arguments, isNull);
    },
  );
  test(
    'revoked Android permission requires another affirmative choice',
    () async {
      status = {'accepted': true, 'android_permission': false};
      final bridge = NativeVpnBridge(
        channel: channel,
        confirmVpnUse: () async => false,
      );
      await expectLater(
        bridge.requestVpnPermission(),
        throwsA(isA<VpnDisclosureCancelled>()),
      );
      expect(calls, hasLength(1));
    },
  );
  test('missing UI cannot silently consent', () async {
    await expectLater(
      NativeVpnBridge(channel: channel).requestVpnPermission(),
      throwsA(isA<VpnDisclosureCancelled>()),
    );
    expect(calls, hasLength(1));
  });
  for (final malformed in [
    null,
    {'accepted': 'true', 'android_permission': true},
    {'accepted': true},
  ]) {
    test('invalid native disclosure status fails closed: $malformed', () async {
      status = malformed;
      final bridge = NativeVpnBridge(
        channel: channel,
        confirmVpnUse: () async =>
            throw StateError('No prompt on corrupt data'),
      );
      await expectLater(
        bridge.requestVpnPermission(),
        throwsA(isA<NativeVpnException>()),
      );
      expect(calls, hasLength(1));
    });
  }
  test(
    'concurrent attempts share one disclosure and one Android request',
    () async {
      final decision = Completer<bool>();
      var prompts = 0;
      final bridge = NativeVpnBridge(
        channel: channel,
        confirmVpnUse: () {
          prompts++;
          return decision.future;
        },
      );
      final first = bridge.requestVpnPermission();
      final second = bridge.requestVpnPermission();
      await Future<void>.delayed(Duration.zero);
      expect(prompts, 1);
      decision.complete(true);
      expect(await Future.wait([first, second]), [true, true]);
      expect(
        calls.where((c) => c.method == 'requestVpnPermission'),
        hasLength(1),
      );
    },
  );
}
