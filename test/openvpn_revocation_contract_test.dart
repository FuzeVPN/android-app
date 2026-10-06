import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('fuzevpn.revocation.contract.test');
  final calls = <MethodCall>[];
  Object? response;
  late NativeVpnBridge bridge;
  final target = {
    'account_id': 'user-a',
    'device_id': 'device-a',
    'csr_sha256': 'a' * 64,
  };
  setUp(() {
    calls.clear();
    response = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return response;
        });
    bridge = NativeVpnBridge(
      channel: channel,
      events: const EventChannel('fuzevpn.revocation.events.test'),
    );
  });
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null),
  );

  test(
    'dedicated cleanup passes the rejected CSR fingerprint and requires every confirmation',
    () async {
      response = {
        ...target,
        'tunnel_stopped': true,
        'identity_cleared': true,
        'tile_cleared': true,
        'marker_cleared': true,
      };
      final result = await bridge.cleanRevokedOpenVpnIdentity(
        accountId: 'user-a',
        deviceId: 'device-a',
        csrSha256: 'a' * 64,
      );
      expect(result.isComplete, isTrue);
      expect(calls.single.method, 'cleanRevokedOpenVpnIdentity');
      expect(calls.single.arguments, target);
    },
  );

  test('pending and stale results cannot announce complete cleanup', () {
    for (final field in [
      'tunnel_stopped',
      'identity_cleared',
      'tile_cleared',
      'marker_cleared',
    ]) {
      final wire = <String, Object?>{
        ...target,
        'tunnel_stopped': true,
        'identity_cleared': true,
        'tile_cleared': true,
        'marker_cleared': true,
      }..remove(field);
      expect(OpenVpnRevocationResult.fromWire(wire).isComplete, isFalse);
    }
    expect(
      OpenVpnRevocationResult.fromWire({...target, 'stale': true}).stale,
      isTrue,
    );
  });

  test(
    'snapshot restores scoped cleanup without changing public VPN phases',
    () {
      final state = VpnRuntimeState.fromWire({
        'status': 'error',
        'protocol': 'openvpn',
        'openvpn_revocation': {...target, 'stop_error': 'openvpn_stop_timeout'},
      });
      expect(state.phase, VpnRuntimePhase.error);
      expect(state.openVpnRevocation?.deviceId, 'device-a');
      expect(state.openVpnRevocation?.stopError, 'openvpn_stop_timeout');
      expect(state.openVpnRevocation?.isComplete, isFalse);
    },
  );

  test(
    'malformed cleanup result is rejected instead of being accepted as success',
    () async {
      response = {...target, 'csr_sha256': 'invalid', 'tunnel_stopped': true};
      await expectLater(
        bridge.cleanRevokedOpenVpnIdentity(
          accountId: 'user-a',
          deviceId: 'device-a',
          csrSha256: 'a' * 64,
        ),
        throwsFormatException,
      );
    },
  );

  test(
    'no persisted revocation remains compatible with existing installations',
    () async {
      expect(
        await bridge.getOpenVpnRevocation(
          accountId: 'user-a',
          deviceId: 'device-a',
        ),
        isNull,
      );
      expect(calls.single.arguments, {
        'account_id': 'user-a',
        'device_id': 'device-a',
      });
    },
  );
}
