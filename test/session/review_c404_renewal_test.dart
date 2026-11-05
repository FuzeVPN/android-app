// Lot S, revue croisée de Helper2 (P2, C4-04) : une session délivrée dans ce
// processus et déjà échue selon l'horloge de l'appareil n'est plus renouvelée
// préventivement sur cette horloge ; seuls les 401 du serveur décident.
// Tests de Helper2 (revue croisée du lot S, point P2) et deux témoins.
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';

import 'support/session_harness.dart';

// Same model as session_bounds_test.dart: an expires_at already in the
// device's past stands for a clock ahead by more than the token lifetime.
DateTime _clockAhead() => DateTime.now().subtract(const Duration(seconds: 1));

Future<SessionHarness> _renewedUnderClockAhead() async {
  final h = SessionHarness.guest(
    session('token-a0', pastExpiry),
    tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
  );
  h.store.deviceIds['guest-a'] = 'device-a';
  h.api.createExpiry = _clockAhead();
  await h.controller.initialize();
  expect(h.store.replacements, ['token-a1'], reason: observe(h));
  expect(h.controller.isSignedIn, isTrue, reason: observe(h));
  return h;
}

void main() {
  group('P2 C4-04 a session delivered in this process, clock ahead', () {
    test('is not renewed again when the app returns to the foreground', () async {
      final h = await _renewedUnderClockAhead();
      addTearDown(h.close);
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.token, 'token-a1');
    });

    test('is not renewed again before a connection', () async {
      final h = await _renewedUnderClockAhead();
      addTearDown(h.close);
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.tunnel.connections, [frankfurt.id], reason: observe(h));
    });

    test('a failed needless renewal does not block the connection', () async {
      final h = await _renewedUnderClockAhead();
      addTearDown(h.close);
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.tunnel.connections, [frankfurt.id], reason: observe(h));
      expect(
        h.controller.notice?.messageKey,
        isNot('guest.serviceUnavailable'),
        reason: observe(h),
      );
    });

    test('a 401 still renews it', () async {
      final h = await _renewedUnderClockAhead();
      addTearDown(h.close);
      h.api.onDevices = (token) async {
        if (token == 'token-a1') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      await h.controller.refreshDevices();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(2), reason: observe(h));
      expect(h.controller.token, 'token-a2');
    });

    test('control: a session valid at delivery is still renewed near expiry', () async {
      final h = SessionHarness.guest(
        session('token-a0', DateTime.now().add(const Duration(minutes: 1))),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      expect(h.controller.token, 'token-a0', reason: observe(h));
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.token, 'token-a1');
      expect(h.tunnel.connections, [frankfurt.id], reason: observe(h));
    });
  });
}
