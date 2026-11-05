// Lot S, revue croisée de Helper2 (P1) : une fin abandonnée (mode b) ne doit
// jamais afficher « session expirée ». Le natif publie la terminaison en cours
// avant de répondre ; storageClearSession reçoit désormais sa cause (reason),
// et les demandes qui rejoignent une même fin sont fusionnées.
// Tests de Helper2 (revue croisée du lot S, point P1) et une combinaison par
// cause.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

const _idle = VpnRuntimeState(phase: VpnRuntimePhase.idle);

/// An older bridge reads only the expired flag and publishes it as the expiry
/// of the termination in progress (Helper2's model of the device).
void _publishLegacyFlag(SessionHarness h) {
  h.store.onClear = () async {
    h.tunnel.emit(
      VpnRuntimeState(
        phase: VpnRuntimePhase.disconnecting,
        messageCode: 'session_ending',
        sessionTermination: SessionTerminationResult(
          tunnelStopped: false,
          sessionCleared: false,
          inProgress: true,
          sessionExpired: h.store.clears.last,
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);
  };
}

/// No session, guest recovery on, a live orphan tunnel and no network: the
/// startup stops the orphan in abandoned mode (C4-02).
SessionHarness _orphanAtStartup() {
  final h = SessionHarness();
  h.store.credential = guestCredential;
  h.store.autoResume = true;
  h.tunnel.state = connectedAt(frankfurt);
  h.api.createFailures.add(const ApiNetworkException());
  return h;
}

/// A guest whose stored token is refused and whose renewal is refused too:
/// its end is an expiry.
SessionHarness _refusedGuest() {
  final h = SessionHarness.guest(session('token-a0'), tunnel: _idle);
  h.api.meScript['token-a0'] = <Object>[unauthorized];
  h.api.createFailures.add(unauthorized);
  return h;
}

void main() {
  group('P1 an older bridge publishing the expired flag (Helper2)', () {
    test('C4-02 a live orphan tunnel stopped at startup: no expiry notice', () async {
      final h = _orphanAtStartup();
      addTearDown(h.close);
      _publishLegacyFlag(h);
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('A14 a proven corruption erased at startup: no expiry notice', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      _publishLegacyFlag(h);
      h.store.readFailure = const NativeVpnException('secure_storage_corrupt');
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('control: a real expiry still shows the expiry notice', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      _publishLegacyFlag(h);
      h.store.activeUser = 'registered-b';
      h.store.accountSessions['registered-b'] = session('token-b', pastExpiry);
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.clears, [true], reason: observe(h));
      expect(
        h.controller.notice?.arguments['code'],
        'unauthorized',
        reason: observe(h),
      );
    });
  });

  group('P1 end causes sent to native storage, one test per combination', () {
    test('voluntary alone: recovery revoked, no notice', () async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _idle);
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      await h.controller.signOut();
      expect(h.store.causes, [SessionEndCause.voluntary], reason: observe(h));
      expect(h.store.autoResume, isFalse);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('expired alone: expiry notice, recovery kept', () async {
      final h = _refusedGuest();
      addTearDown(h.close);
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.expired], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(
        h.controller.notice?.arguments['code'],
        'unauthorized',
        reason: observe(h),
      );
    });

    test('abandoned alone: no notice, recovery kept', () async {
      final h = _orphanAtStartup();
      addTearDown(h.close);
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.abandoned], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('A14 corruption alone: abandoned, no notice, recovery kept', () async {
      final h = SessionHarness.guest(session('token-a0'), tunnel: _idle);
      addTearDown(h.close);
      h.store.readFailure = const NativeVpnException('secure_storage_corrupt');
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes.first, SessionEndCause.abandoned, reason: observe(h));
      expect(h.store.causes, isNot(contains(SessionEndCause.expired)));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('abandoned joined by voluntary: recovery revoked, no notice', () async {
      final h = _orphanAtStartup();
      addTearDown(h.close);
      final gate = Completer<void>();
      h.store.onClear = () => gate.future;
      unawaited(h.controller.initialize());
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.abandoned], reason: observe(h));
      final signedOut = h.controller.signOut();
      await pumpEventQueue();
      gate.complete();
      await signedOut;
      await pumpEventQueue();
      expect(h.store.causes, [
        SessionEndCause.abandoned,
        SessionEndCause.voluntary,
      ], reason: observe(h));
      expect(h.store.autoResume, isFalse);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('expired joined by voluntary: expiry notice, recovery revoked', () async {
      final h = _refusedGuest();
      addTearDown(h.close);
      final gate = Completer<void>();
      h.store.onClear = () => gate.future;
      unawaited(h.controller.initialize());
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.expired], reason: observe(h));
      final signedOut = h.controller.signOut();
      await pumpEventQueue();
      gate.complete();
      await signedOut;
      await pumpEventQueue();
      expect(h.store.causes, [
        SessionEndCause.expired,
        SessionEndCause.voluntary,
      ], reason: observe(h));
      expect(h.store.autoResume, isFalse);
      expect(
        h.controller.notice?.arguments['code'],
        'unauthorized',
        reason: observe(h),
      );
    });

    test('a native end in progress at startup is joined without intent', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      h.tunnel.state = const VpnRuntimeState(
        phase: VpnRuntimePhase.disconnecting,
        messageCode: 'session_ending',
        sessionTermination: SessionTerminationResult(
          tunnelStopped: false,
          sessionCleared: false,
          inProgress: true,
        ),
      );
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.abandoned], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('a native expiry in progress at startup stays an expiry', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      h.tunnel.state = const VpnRuntimeState(
        phase: VpnRuntimePhase.disconnecting,
        messageCode: 'session_ending',
        sessionTermination: SessionTerminationResult(
          tunnelStopped: false,
          sessionCleared: false,
          inProgress: true,
          sessionExpired: true,
        ),
      );
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.expired], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(
        h.controller.notice?.arguments['code'],
        'unauthorized',
        reason: observe(h),
      );
    });
  });
}
