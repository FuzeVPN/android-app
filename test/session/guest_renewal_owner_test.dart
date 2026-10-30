// Lot S, corrections 2026-10-29: a guest 401 renews the token instead of
// ending the session, whoever owns the failing work; location changes survive
// that renewal; restoration retries respect running guest work and Retry-After.
// Counterexamples ported from audit-complet-20261028/repros (A13, A02).
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';

import 'support/session_harness.dart';

const _idle = VpnRuntimeState(phase: VpnRuntimePhase.idle);

Future<SessionHarness> _signedInGuest({
  Duration? remaining,
  VpnRuntimeState tunnel = _idle,
}) async {
  final h = SessionHarness.guest(
    session(
      'guest-token',
      remaining == null ? farExpiry : DateTime.now().add(remaining),
    ),
    tunnel: tunnel,
  );
  h.store.deviceIds['guest-a'] = 'device-a';
  await h.controller.initialize();
  expect(h.controller.isSignedIn, isTrue, reason: observe(h));
  return h;
}

Future<SessionHarness> _signedInAccount() async {
  final h = SessionHarness();
  h.store.activeUser = 'registered-b';
  h.store.accountSessions['registered-b'] = session('token-b');
  h.store.deviceIds['registered-b'] = 'device-a';
  await h.controller.initialize();
  expect(h.controller.isSignedIn, isTrue, reason: observe(h));
  return h;
}

Future<DeviceConfiguration> _refuseGuestToken(String token, String _) async {
  if (token == 'guest-token') throw unauthorized;
  return deviceConfiguration;
}

void main() {
  group('A13-dart-vpn-02 a guest 401 during a connection renews the token', () {
    test('registerDevice 401: renewed, then the same Connect completes', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onRegister = _refuseGuestToken;
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.createdCredentials, [guestCredential], reason: observe(h));
      expect(h.store.replacements, ['token-a1']);
      expect(h.store.clears, isEmpty);
      expect(h.controller.token, 'token-a1');
      expect(h.api.registered, [
        ('guest-token', frankfurt.id),
        ('token-a1', frankfurt.id),
      ]);
      expect(h.tunnel.connections, [frankfurt.id]);
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.isConnecting, isFalse);
      expect(h.controller.isIdentityBusy, isFalse);
      expect(h.controller.notice, isNull);
    });

    test('listDevices 401 before any tunnel change: renewed and connected', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onDevices = (token) async {
        if (token == 'guest-token') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.store.clears, isEmpty, reason: observe(h));
      expect(h.controller.token, 'token-a1');
      expect(h.tunnel.connections, [frankfurt.id]);
    });

    test('a location change keeps its destination across the renewal', () async {
      final h = await _signedInGuest(tunnel: connectedAt(frankfurt));
      addTearDown(h.close);
      h.api.onRegister = _refuseGuestToken;
      await h.controller.changeLocationAndConnect(paris);
      await pumpEventQueue();
      expect(h.store.clears, isEmpty, reason: observe(h));
      expect(h.controller.token, 'token-a1');
      expect(h.api.registered.last, ('token-a1', paris.id));
      expect(h.tunnel.connections, [paris.id]);
      expect(h.controller.isChangingLocation, isFalse);
      expect(h.controller.isConnecting, isFalse);
    });

    test('a temporary renewal failure keeps the session and says so', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onRegister = _refuseGuestToken;
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.store.clears, isEmpty, reason: observe(h));
      expect(h.controller.token, 'guest-token');
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.isConnecting, isFalse);
      expect(h.controller.notice?.messageKey, 'guest.serviceUnavailable');
    });

    test('control: without recovery the 401 still ends the session', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.store.autoResume = false;
      h.api.onRegister = _refuseGuestToken;
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.store.clears, [true]);
      expect(h.controller.token, isNull);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
    });
  });

  group('A02-guest-02 a guest 401 during an in-flight reset', () {
    test('the session and tunnel are kept, and renewed after the reset', () async {
      final h = await _signedInGuest(tunnel: connectedAt(frankfurt));
      addTearDown(h.close);
      final release = Completer<void>();
      h.api.onReset = () => release.future;
      final resetting = h.controller.requestPasswordReset('b@example.test');
      h.api.onDevices = (token) async {
        if (token == 'guest-token') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      await h.controller.refreshDevices();
      expect(h.store.clears, isEmpty, reason: observe(h));
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.controller.token, 'guest-token');
      expect(h.api.createdCredentials, isEmpty);
      release.complete();
      expect(await resetting, isTrue);
      await h.controller.refreshDevices();
      expect(h.controller.token, 'token-a1', reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.controller.isConnected, isTrue);
    });
  });

  group('A13-dart-vpn-01 guest near expiry during a location change', () {
    test('renewed first, then the confirmed destination is connected', () async {
      final h = await _signedInGuest(
        remaining: const Duration(seconds: 90),
        tunnel: connectedAt(frankfurt),
      );
      addTearDown(h.close);
      await h.controller.changeLocationAndConnect(paris);
      await pumpEventQueue();
      expect(h.api.createdCredentials, [guestCredential], reason: observe(h));
      expect(h.controller.token, 'token-a1');
      expect(h.tunnel.disconnectCalls, 1);
      expect(h.api.registered, [('token-a1', paris.id)]);
      expect(h.tunnel.connections, [paris.id]);
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.isChangingLocation, isFalse);
    });

    test('a refused renewal leaves the current tunnel untouched, with a notice', () async {
      final h = await _signedInGuest(
        remaining: const Duration(seconds: 90),
        tunnel: connectedAt(frankfurt),
      );
      addTearDown(h.close);
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.changeLocationAndConnect(paris);
      await pumpEventQueue();
      expect(h.tunnel.disconnectCalls, 0, reason: observe(h));
      expect(h.controller.isConnected, isTrue);
      expect(h.api.registered, isEmpty);
      expect(h.controller.notice?.messageKey, 'guest.serviceUnavailable');
      expect(h.controller.isChangingLocation, isFalse);
    });

    test('control: a far expiry changes location without renewal', () async {
      final h = await _signedInGuest(tunnel: connectedAt(frankfurt));
      addTearDown(h.close);
      await h.controller.changeLocationAndConnect(paris);
      await pumpEventQueue();
      expect(h.api.createdCredentials, isEmpty);
      expect(h.tunnel.connections, [paris.id]);
    });
  });

  group('A13-dart-vpn-03 cancelling a location change', () {
    test('releases every control immediately', () async {
      final h = await _signedInAccount();
      addTearDown(h.close);
      final entered = Completer<void>();
      final release = Completer<DeviceConfiguration>();
      h.api.onRegister = (_, __) {
        if (entered.isCompleted) return Future.value(deviceConfiguration);
        entered.complete();
        return release.future;
      };
      final changing = h.controller.changeLocationAndConnect(paris);
      await entered.future;
      expect(h.controller.isChangingLocation, isTrue);

      await h.controller.cancelConnectionAttempt();
      await pumpEventQueue();
      expect(h.controller.isChangingLocation, isFalse);
      expect(h.controller.isConnecting, isFalse);
      expect(h.controller.canCancelConnectionAttempt, isFalse);
      expect(h.controller.canChangeLocation, isTrue);
      expect(h.controller.canSelectProtocol, isTrue);

      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.registered, hasLength(2));
      expect(h.tunnel.connections, [paris.id]);

      // The abandoned request returns late: it changes nothing.
      release.complete(deviceConfiguration);
      await changing;
      await pumpEventQueue();
      expect(h.tunnel.connections, [paris.id]);
      expect(h.controller.isChangingLocation, isFalse);
    });
  });

  group('A13-dart-vpn-04 a dismissed native error notice', () {
    test('does not come back on resume, a new error still shows', () async {
      final h = await _signedInAccount();
      addTearDown(h.close);
      h.tunnel.emit(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: VpnProtocol.wireGuard,
          messageCode: 'wireguard_handshake_timeout',
        ),
      );
      await pumpEventQueue();
      expect(h.controller.notice?.messageKey, 'notice.native.message');
      final snapshotsBefore = h.tunnel.snapshots;
      for (var resume = 1; resume <= 3; resume++) {
        h.controller.clearNotice();
        await h.controller.onAppResumed();
        expect(h.controller.notice, isNull, reason: 'resume #$resume');
      }
      expect(h.tunnel.snapshots - snapshotsBefore, 3);
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.error);

      h.tunnel.emit(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: VpnProtocol.wireGuard,
          messageCode: 'wireguard_start_failed',
        ),
      );
      await pumpEventQueue();
      expect(h.controller.notice?.messageKey, 'notice.native.message');
    });
  });

  group('A02-guest-04 restoration retry while a guest recovery runs', () {
    test('a second tap neither restarts /me nor ends the session', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      h.api.meScript['token-a0'] = <Object>[
        const ApiNetworkException(),
        unauthorized,
        unauthorized,
      ];
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      final gate = Completer<void>();
      h.api.onCreate = () => gate.future;
      final first = h.controller.retryAccountRestoration();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(1));
      expect(h.controller.isGuestActionBusy, isTrue);

      await h.controller.retryAccountRestoration();
      expect(
        h.api.meTokens.where((token) => token == 'token-a0'),
        hasLength(2),
        reason: observe(h),
      );
      expect(h.store.clears, isEmpty);
      gate.complete();
      await first;
      await pumpEventQueue();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
      expect(h.controller.token, 'token-a1');
      expect(h.store.clears, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
    });
  });

  group('A02-guest-05 restoration retry and a 503 Retry-After', () {
    testWidgets('no new guest session before the delay ends', (tester) async {
      final h = SessionHarness.guest(session('token-a0', pastExpiry));
      addTearDown(h.close);
      h.api.createFailures.add(
        const ApiException(
          statusCode: 503,
          errorCode: 'service_unavailable',
          retryAfterSeconds: 60,
        ),
      );
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.api.createdCredentials, hasLength(1));
      await h.controller.retryAccountRestoration();
      await h.controller.retryAccountRestoration();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.isGuestActionBusy, isTrue);

      await tester.pump(const Duration(seconds: 61));
      expect(h.controller.isGuestActionBusy, isFalse);
      await h.controller.retryAccountRestoration();
      expect(h.api.createdCredentials, hasLength(2));
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
      // The live tunnel's metrics timer must stop inside the fake clock.
      await h.close();
    });
  });
}
