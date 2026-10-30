// Lot S, revue croisée de Helper2 : variantes P3 (C1-02), P8 (A13-dart-vpn-04)
// et P10 (A13-dart-vpn-02), plus un cas d'A01-auth-01 où l'opt-out de B ne
// peut pas être écrit. Tests de Helper2 pour P3, P8 et P10b ; P10a, c, d et le
// cas d'A01-auth-01 ajoutés par Helper1. Passe finale du réaudit : erreur
// native masquée par un autre avis (P8, B5, B35).
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

const _idle = VpnRuntimeState(phase: VpnRuntimePhase.idle);
const _startFailed = VpnRuntimeState(
  phase: VpnRuntimePhase.error,
  protocol: VpnProtocol.wireGuard,
  messageCode: 'wireguard_start_failed',
);

Future<SessionHarness> _signedInGuest({VpnRuntimeState tunnel = _idle}) async {
  final h = SessionHarness.guest(session('guest-token'), tunnel: tunnel);
  h.store.deviceIds['guest-a'] = 'device-a';
  await h.controller.initialize();
  expect(h.controller.isSignedIn, isTrue, reason: observe(h));
  return h;
}

void main() {
  group('P3 C1-02 after a bounded end', () {
    testWidgets('the app accepts a new sign-in', (tester) async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _idle);
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue);
      final never = Completer<void>();
      h.store.onReplace = () => never.future;
      h.api.onDevices = (token) async {
        if (token == 'guest-token') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      // Same start as session_bounds_test: a renewal whose write never answers.
      unawaited(h.controller.refreshDevices());
      await tester.pump();
      expect(h.store.replacements, ['token-a1']);
      unawaited(h.controller.signOut());
      await tester.pump(const Duration(seconds: 11));
      expect(h.store.clears, [false], reason: observe(h));
      expect(h.controller.isGuestActionBusy, isFalse, reason: observe(h));
      bool? signedIn;
      unawaited(
        h.controller
            .signIn(email: 'b@example.test', password: 'fixture-password')
            .then((value) => signedIn = value),
      );
      await tester.pump(const Duration(seconds: 15));
      expect(signedIn, isTrue, reason: observe(h));
      await h.close();
    });
  });

  group('P8 A13-dart-vpn-04 a native error present at startup', () {
    test('is reported once, at startup', () async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _startFailed);
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      expect(h.controller.notice?.arguments['code'], isNotNull, reason: observe(h));
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.notice, isNotNull, reason: observe(h));
    });

    test('is reported after a resume, and not again once dismissed', () async {
      final h = await _signedInGuest(tunnel: _startFailed);
      addTearDown(h.close);
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.notice, isNotNull, reason: observe(h));
      h.controller.clearNotice();
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.notice, isNull, reason: observe(h));
    });
  });

  group('P8 A13-dart-vpn-04 a native error hidden by another notice', () {
    bool isNative(SessionHarness h) =>
        h.controller.notice?.titleKey == 'notice.native.title';

    Future<void> dismissAndResume(SessionHarness h) async {
      h.controller.clearNotice();
      await h.controller.onAppResumed();
      await pumpEventQueue();
    }

    test('at startup, behind a catalogue failure, is shown once that notice '
        'is dismissed', () async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _startFailed);
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      h.api.locationsFailure = const ApiNetworkException();
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.notice, isNotNull, reason: observe(h));
      expect(isNative(h), isFalse, reason: observe(h));
      h.api.locationsFailure = null;
      await dismissAndResume(h);
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.error);
      expect(isNative(h), isTrue, reason: observe(h));
      await dismissAndResume(h);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('raised behind a catalogue notice, is shown once that notice is '
        'dismissed, then never again', () async {
      final h = await _signedInGuest(tunnel: connectedAt(frankfurt));
      addTearDown(h.close);
      h.api.locationsFailure = const ApiNetworkException();
      await h.controller.refreshLocations();
      expect(h.controller.notice, isNotNull, reason: observe(h));
      h.tunnel.emit(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: VpnProtocol.wireGuard,
          messageCode: 'tunnel_disconnected',
        ),
      );
      await pumpEventQueue();
      expect(isNative(h), isFalse, reason: observe(h));
      h.api.locationsFailure = null;
      await dismissAndResume(h);
      expect(isNative(h), isTrue, reason: observe(h));
      expect(h.controller.notice?.arguments['code'], isNotNull);
      await dismissAndResume(h);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('raised behind a protocol notice of a location change, is shown '
        'once that notice is dismissed', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.activeUser = 'registered-b';
      h.store.accountSessions['registered-b'] = session('token-b');
      h.store.deviceIds['registered-b'] = 'device-a';
      await h.controller.initialize();
      await h.controller.selectProtocol(VpnProtocol.openVpn);
      await h.controller.changeLocationAndConnect(paris);
      expect(
        h.controller.notice?.arguments['code'],
        'protocol_unavailable_at_location',
      );
      h.tunnel.emit(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: VpnProtocol.wireGuard,
          messageCode: 'wireguard_handshake_timeout',
        ),
      );
      await pumpEventQueue();
      expect(isNative(h), isFalse, reason: observe(h));
      await dismissAndResume(h);
      expect(isNative(h), isTrue, reason: observe(h));
    });

    test('control: the same native error is not shown twice', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.tunnel.emit(_startFailed);
      await pumpEventQueue();
      expect(isNative(h), isTrue, reason: observe(h));
      final shown = h.controller.notice;
      h.tunnel.emit(_startFailed);
      await pumpEventQueue();
      expect(identical(h.controller.notice, shown), isTrue);
      await dismissAndResume(h);
      expect(h.controller.notice, isNull, reason: observe(h));
    });
  });

  group('P10 A13-dart-vpn-02 remaining cases', () {
    test('P10a a renewal that cannot run now tells the user', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final release = Completer<void>();
      h.api.onReset = () => release.future;
      final resetting = h.controller.requestPasswordReset('b@example.test');
      h.api.onRegister = (token, _) async => throw unauthorized;
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.tunnel.connections, isEmpty);
      expect(
        h.controller.notice?.messageKey,
        'guest.serviceUnavailable',
        reason: observe(h),
      );
      release.complete();
      expect(await resetting, isTrue);
    });

    test('P10b the renewed token is refused too: one renewal only, and the '
        'user is told', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onRegister = (token, _) async => throw unauthorized;
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.notice, isNotNull, reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.controller.isConnecting, isFalse);
    });

    test('P10c a renewal from another origin does not leave the connection '
        'busy', () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final created = Completer<void>();
      final registered = Completer<void>();
      h.api.onCreate = () => created.future;
      h.api.onDevices = (token) async {
        if (token == 'guest-token') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      h.api.onRegister = (token, _) async {
        await registered.future;
        return deviceConfiguration;
      };
      final refreshing = h.controller.refreshDevices();
      await pumpEventQueue();
      final connecting = h.controller.connect();
      await pumpEventQueue();
      expect(h.controller.isConnecting, isTrue, reason: observe(h));
      created.complete();
      await refreshing;
      await pumpEventQueue();
      registered.complete();
      await connecting;
      await pumpEventQueue();
      expect(h.controller.token, 'token-a1', reason: observe(h));
      expect(h.controller.isConnecting, isFalse, reason: observe(h));
      h.api.onRegister = null;
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.tunnel.connections, contains(frankfurt.id), reason: observe(h));
    });

    testWidgets('P10d a connection 401 during a Retry-After delay creates '
        'no session before the delay', (tester) async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _idle);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      h.api.onRegister = (token, _) async {
        if (token == 'guest-token') throw unauthorized;
        return deviceConfiguration;
      };
      h.api.createFailures.add(
        const ApiException(
          statusCode: 503,
          errorCode: 'service_unavailable',
          retryAfterSeconds: 30,
        ),
      );
      await h.controller.connect();
      await tester.pump();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.notice?.messageKey, 'guest.serviceUnavailable');
      await h.controller.connect();
      await tester.pump();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.notice?.messageKey, 'guest.serviceUnavailable');
      expect(h.store.clears, isEmpty);
      await tester.pump(const Duration(seconds: 31));
      await h.controller.connect();
      await tester.pump();
      expect(h.api.createdCredentials, hasLength(2), reason: observe(h));
      expect(h.tunnel.connections, [frankfurt.id], reason: observe(h));
      await h.close();
    });
  });

  group('A01-auth-01 with the opt-out of B unwritable, the stale deferral '
      'never reaches B', () {
    test('keeps guest A out when the opt-out of B cannot be written', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.controller.token, isNull);
      // The opt-out write fails: only the sign-in reset of the deferral
      // (_setSession) or its identity binding keeps A out. The test fails only
      // without both; guest_controller_test.dart pins the binding alone.
      h.store.autoResumeWriteFailure = const NativeVpnException(
        'secure_storage_write_failed',
      );
      h.api.meScript['token-b'] = <Object>[const ApiNetworkException()];
      await h.controller.signIn(
        email: 'b@example.test',
        password: 'fixture-password',
      );
      expect(h.controller.token, 'token-b', reason: observe(h));
      expect(h.store.autoResume, isTrue);
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
      expect(h.controller.token, 'token-b');
    });
  });
}
