import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/repositories.dart';

void main() {
  test('lit le statut natif publié par le canal Android', () {
    final VpnRuntimeState state = VpnRuntimeState.fromWire(<Object?, Object?>{
      'status': 'connected',
      'protocol': 'wireguard',
      'message_code': 'connected',
      'connected_at': 1726000000000,
      'location_id': 'frankfurt-01',
      'location_name': 'Frankfurt 01',
      'received_bytes': 1024,
      'sent_bytes': 2048,
      'latest_handshake': 1726000005000,
    });

    expect(state.phase, VpnRuntimePhase.connected);
    expect(state.isConnected, isTrue);
    expect(state.protocol?.apiValue, 'wireguard');
    expect(state.messageCode, 'connected');
    expect(state.connectedAt?.millisecondsSinceEpoch, 1726000000000);
    expect(state.locationId, 'frankfurt-01');
    expect(state.locationName, 'Frankfurt 01');
    expect(state.receivedBytes, 1024);
    expect(state.sentBytes, 2048);
    expect(state.latestHandshake?.millisecondsSinceEpoch, 1726000005000);
  });

  test('ne relaie pas de détail natif non stable comme message', () {
    final VpnRuntimeState state = VpnRuntimeState.fromWire(<Object?, Object?>{
      'phase': 'error',
      'messageCode': 'tls-key=secret endpoint=198.51.100.10',
    });

    expect(state.phase, VpnRuntimePhase.error);
    expect(state.messageCode, isNull);
    expect(state.toString(), isNot(contains('tls-key')));
  });

  test('rejette les métriques et emplacements natifs mal formés', () {
    final VpnRuntimeState state = VpnRuntimeState.fromWire(<Object?, Object?>{
      'status': 'connected',
      'location_id': '../secret',
      'location_name': 'Frankfurt\nsecret',
      'received_bytes': -1,
      'sent_bytes': '2048',
      'latest_handshake': 0,
    });

    expect(state.locationId, isNull);
    expect(state.locationName, isNull);
    expect(state.receivedBytes, isNull);
    expect(state.sentBytes, isNull);
    expect(state.latestHandshake, isNull);
  });

  test('lit la protection système sans confondre inconnu et inactif', () {
    final VpnRuntimeState protected = VpnRuntimeState.fromWire(
      <Object?, Object?>{
        'phase': 'connected',
        'system_protection': <Object?, Object?>{
          'always_on': true,
          'lockdown': true,
          'resume_state': 'ready',
        },
      },
    );
    final VpnRuntimeState unknown = VpnRuntimeState.fromWire(<Object?, Object?>{
      'phase': 'idle',
      'system_protection': <Object?, Object?>{},
    });

    expect(protected.systemProtection.isActive, isTrue);
    expect(
      protected.systemProtection.resumeState,
      SystemProtectionResumeState.ready,
    );
    expect(unknown.systemProtection.alwaysOn, isNull);
    expect(unknown.systemProtection.lockdown, isNull);
    expect(unknown.systemProtection.isActive, isFalse);
  });

  test('traite la reprise système comme une reconnexion visible', () {
    final VpnRuntimeState state = VpnRuntimeState.fromWire(<Object?, Object?>{
      'phase': 'connecting',
      'message_code': 'system_vpn_restoring',
    });

    expect(state.isReconnecting, isTrue);
  });
}
