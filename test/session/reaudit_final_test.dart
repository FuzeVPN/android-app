// Lot S, passe finale du réaudit (30/10/2026), côté Dart :
//  * B2 (A13-dart-vpn-02) : un 401 invité pendant une révocation d'appareil
//    renouvelle le jeton puis relance la révocation une fois, sans boucle ;
//  * B6 (A13-dart-vpn-01) : un jeton inscrit qui expire pendant un changement
//    de lieu termine la session en expirée, jamais en silence ;
//  * B8 et B36 (C4-04) : une session délivrée sous une horloge en avance garde
//    son compte et son jeton côté diagnostics, et l'avis horloge survit au
//    début d'une connexion ;
//  * B30 (X1-RETRY-JOIN-VOLUNTARY) et B32 (X1-TEST-GAPS) : un réessai garde les
//    causes de la fin qu'il rejoint ou complète ;
//  * B17 (A11-openvpn-kotlin-01) : une annulation interne publiée en erreur
//    n'est pas montrée comme une erreur native ;
//  * B12 (A09-01) : un OpenVPN retenu en erreur est arrêté avant le CSR.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

const _idle = VpnRuntimeState(phase: VpnRuntimePhase.idle);
const _otherDevice = VpnDevice(
  deviceId: 'device-other',
  name: 'Autre',
  location: null,
  createdAt: null,
);

// Same model as session_bounds_test.dart: an expires_at already in the
// device's past stands for a clock ahead by more than the token lifetime.
DateTime _clockAhead() => DateTime.now().subtract(const Duration(seconds: 1));

/// A guest whose stored token is refused and whose renewal is refused too:
/// its end is an expiry.
SessionHarness _refusedGuest() {
  final h = SessionHarness.guest(session('token-a0'), tunnel: _idle);
  h.api.meScript['token-a0'] = <Object>[unauthorized];
  h.api.createFailures.add(unauthorized);
  return h;
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

/// The first end request fails once; later ones succeed.
void _failFirstClear(SessionHarness h) {
  var first = true;
  h.store.onClear = () async {
    if (!first) return;
    first = false;
    throw const NativeVpnException('secure_storage_write_failed');
  };
}

/// What the native end publishes for an end whose erase failed, before it
/// answers the storageClearSession request.
VpnRuntimeState _failedEnd({required bool expired}) => VpnRuntimeState(
  phase: VpnRuntimePhase.idle,
  messageCode: 'secure_storage_write_failed',
  sessionTermination: SessionTerminationResult(
    tunnelStopped: true,
    sessionCleared: false,
    storageError: 'secure_storage_write_failed',
    sessionExpired: expired,
  ),
);

class _NoTransport extends ApiHttpTransport {
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) =>
      throw StateError('no diagnostics upload in this test');
}

class _RecordingDiagnostics extends DiagnosticService {
  _RecordingDiagnostics()
    : super(
        transport: _NoTransport(),
        baseUri: Uri.parse('https://diagnostics.invalid'),
        scheduleRetries: false,
      );

  final sessions = <(String?, String?, DateTime?)>[];

  @override
  void setSession({String? accountId, String? token, DateTime? expiresAt}) {
    sessions.add((accountId, token, expiresAt));
    super.setSession(accountId: accountId, token: token, expiresAt: expiresAt);
  }
}

void main() {
  group('B2 A13-dart-vpn-02 a 401 during a device revocation', () {
    Future<SessionHarness> signedInGuest() async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _idle);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      return h;
    }

    test('renews the guest token and revokes once more with it', () async {
      final h = await signedInGuest();
      addTearDown(h.close);
      h.api.onRevoke = (token, _) async {
        if (token == 'guest-token') throw unauthorized;
      };
      final revoked = await h.controller.revokeDevice(_otherDevice);
      await pumpEventQueue();
      expect(revoked, isTrue, reason: observe(h));
      expect(h.api.revokedDevices, [
        ('guest-token', 'device-other'),
        ('token-a1', 'device-other'),
      ]);
      expect(h.api.createdCredentials, hasLength(1));
      expect(h.store.clears, isEmpty);
      expect(h.controller.token, 'token-a1');
      expect(h.controller.notice?.arguments['code'], 'device_revoked');
      expect(h.controller.isRevoking, isFalse);
      expect(h.controller.isIdentityBusy, isFalse);
    });

    test('a renewed token refused too stops with a notice, without a loop', () async {
      final h = await signedInGuest();
      addTearDown(h.close);
      h.api.onRevoke = (_, _) async => throw unauthorized;
      final revoked = await h.controller.revokeDevice(_otherDevice);
      await pumpEventQueue();
      expect(revoked, isFalse, reason: observe(h));
      expect(h.api.revokedDevices, hasLength(2));
      expect(h.api.createdCredentials, hasLength(1));
      expect(h.store.clears, isEmpty);
      expect(h.controller.token, 'token-a1');
      expect(h.controller.notice?.messageKey, 'guest.serviceUnavailable');
      expect(h.controller.isRevoking, isFalse);
    });
  });

  group('B6 A13-dart-vpn-01 a registered token expiring during a change', () {
    test('ends the session as an expiry instead of a silent stop', () async {
      final expiry = DateTime.now().add(const Duration(seconds: 1));
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.activeUser = 'registered-b';
      h.store.accountSessions['registered-b'] = session('token-b', expiry);
      h.store.deviceIds['registered-b'] = 'device-a';
      h.tunnel.state = connectedAt(frankfurt);
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      // The stored token expires while the server registers the new location.
      h.api.onRegister = (_, _) async {
        while (!DateTime.now().isAfter(expiry)) {
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
        return deviceConfiguration;
      };
      await h.controller.changeLocationAndConnect(paris);
      await pumpEventQueue();
      expect(h.api.registered, [('token-b', paris.id)], reason: observe(h));
      expect(h.tunnel.connections, isEmpty);
      expect(h.store.causes, [SessionEndCause.expired], reason: observe(h));
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
    });

    test('control: a live registered token completes the change', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.activeUser = 'registered-b';
      h.store.accountSessions['registered-b'] = session('token-b');
      h.store.deviceIds['registered-b'] = 'device-a';
      h.tunnel.state = connectedAt(frankfurt);
      await h.controller.initialize();
      await h.controller.changeLocationAndConnect(paris);
      await pumpEventQueue();
      expect(h.tunnel.connections, [paris.id], reason: observe(h));
      expect(h.store.causes, isEmpty);
    });
  });

  group('B8 B36 C4-04 a session delivered under a clock ahead', () {
    test('keeps its account and token for diagnostics', () async {
      final diagnostics = _RecordingDiagnostics();
      final h = SessionHarness.guest(
        session('token-a0', pastExpiry),
        tunnel: _idle,
        diagnostics: diagnostics,
      );
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      h.api.createExpiry = _clockAhead();
      await h.controller.initialize();
      expect(h.controller.token, 'token-a1', reason: observe(h));
      await h.controller.onAppResumed();
      await pumpEventQueue();
      final (account, token, expiresAt) = diagnostics.sessions.last;
      expect(account, 'guest-a');
      expect(token, 'token-a1');
      // The device clock cannot judge that session: no expiry is handed over.
      expect(expiresAt, isNull);
    });

    test('control: a session valid on the device clock keeps its expiry', () async {
      final diagnostics = _RecordingDiagnostics();
      final h = SessionHarness.guest(
        session('guest-token'),
        tunnel: _idle,
        diagnostics: diagnostics,
      );
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      final (account, token, expiresAt) = diagnostics.sessions.last;
      expect(account, 'guest-a');
      expect(token, 'guest-token');
      expect(expiresAt, farExpiry);
    });

    test('the clock notice survives the start of a connection', () async {
      final h = SessionHarness.guest(session('token-a0', pastExpiry), tunnel: _idle);
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      h.api.createExpiry = _clockAhead();
      await h.controller.initialize();
      expect(h.controller.notice?.arguments['code'], 'device_clock_ahead');
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.tunnel.connections, [frankfurt.id], reason: observe(h));
      expect(h.controller.notice?.arguments['code'], 'device_clock_ahead');
    });
  });

  group('B30 X1-RETRY-JOIN-VOLUNTARY a retry joining an end in progress', () {
    test('keeps an expiry non-voluntary', () async {
      final h = _refusedGuest();
      addTearDown(h.close);
      final gate = Completer<void>();
      var first = true;
      h.store.onClear = () async {
        if (!first) return;
        first = false;
        // settleEnd publishes the failed end before answering the request.
        h.tunnel.emit(_failedEnd(expired: true));
        await gate.future;
        throw const NativeVpnException('secure_storage_write_failed');
      };
      unawaited(h.controller.initialize());
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.expired], reason: observe(h));
      // The cleanup page already offers its retry button (not in progress).
      expect(h.controller.sessionTermination?.inProgress, isFalse);
      final retried = h.controller.retrySessionTermination();
      await pumpEventQueue();
      gate.complete();
      await retried;
      await pumpEventQueue();
      expect(
        h.store.causes,
        isNot(contains(SessionEndCause.voluntary)),
        reason: 'causes=${h.store.causes} ${observe(h)}',
      );
      expect(h.store.autoResume, isTrue, reason: observe(h));
    });
  });

  group('B32 X1-TEST-GAPS a retry keeps the causes of the end it completes', () {
    test('a retry after a failed expiry keeps the expiry', () async {
      final h = _refusedGuest();
      addTearDown(h.close);
      _failFirstClear(h);
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.expired], reason: observe(h));
      expect(h.controller.sessionTermination?.inProgress, isFalse);
      await h.controller.retrySessionTermination();
      await pumpEventQueue();
      expect(h.store.causes, [
        SessionEndCause.expired,
        SessionEndCause.expired,
      ], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
    });

    test('a retry after a failed abandoned end stays abandoned', () async {
      final h = _orphanAtStartup();
      addTearDown(h.close);
      _failFirstClear(h);
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.store.causes, [SessionEndCause.abandoned], reason: observe(h));
      expect(h.controller.sessionTermination?.inProgress, isFalse);
      await h.controller.retrySessionTermination();
      await pumpEventQueue();
      expect(h.store.causes, [
        SessionEndCause.abandoned,
        SessionEndCause.abandoned,
      ], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.notice, isNull);
    });

    for (final expired in <bool>[false, true]) {
      test('a failed native end found at startup is retried without intent '
          '(expired: $expired)', () async {
        final h = SessionHarness();
        addTearDown(h.close);
        h.store.credential = guestCredential;
        h.store.autoResume = true;
        h.tunnel.state = _failedEnd(expired: expired);
        await h.controller.initialize();
        expect(h.controller.sessionTermination?.inProgress, isFalse);
        expect(h.store.causes, isEmpty);
        await h.controller.retrySessionTermination();
        await pumpEventQueue();
        // Only native storage knows whether the failed end was voluntary: the
        // retry adds no intent of its own and keeps an expiry an expiry.
        expect(h.store.causes, [
          expired ? SessionEndCause.expired : SessionEndCause.abandoned,
        ], reason: observe(h));
        expect(h.controller.sessionTermination, isNull);
        expect(
          h.controller.notice?.arguments['code'],
          expired ? 'unauthorized' : isNull,
        );
      });
    }
  });

  group('B17 A11-openvpn-kotlin-01 an internal cancellation published as an '
      'error', () {
    const cancelled = VpnRuntimeState(
      phase: VpnRuntimePhase.error,
      protocol: VpnProtocol.openVpn,
      messageCode: 'session_operation_cancelled',
    );

    test('is never shown as a native error, now or on resume', () async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _idle);
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      h.tunnel.emit(cancelled);
      await pumpEventQueue();
      expect(h.controller.notice, isNull, reason: observe(h));
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('control: a real native error that follows it is shown', () async {
      final h = SessionHarness.guest(session('guest-token'), tunnel: _idle);
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      h.tunnel.emit(cancelled);
      await pumpEventQueue();
      h.tunnel.emit(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: VpnProtocol.openVpn,
          messageCode: 'tunnel_disconnected',
        ),
      );
      await pumpEventQueue();
      expect(
        h.controller.notice?.titleKey,
        'notice.native.title',
        reason: observe(h),
      );
    });
  });

  group('B12 A09-01 a connection after an engine retained in error', () {
    Future<SessionHarness> retained(VpnProtocol protocol) async {
      final h = SessionHarness.guest(
        session('guest-token'),
        tunnel: VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: protocol,
          messageCode: 'tunnel_stop_failed',
        ),
      );
      h.store.deviceIds['guest-a'] = 'device-a';
      h.preferences.protocol = VpnProtocol.openVpn.apiValue;
      // The engine's stop never completed: the CSR route refuses it in use.
      h.tunnel.openVpnRetained = protocol == VpnProtocol.openVpn;
      await h.controller.initialize();
      expect(h.controller.selectedProtocol, VpnProtocol.openVpn);
      h.controller.clearNotice();
      return h;
    }

    test('stops a retained OpenVPN engine natively before the CSR', () async {
      final h = await retained(VpnProtocol.openVpn);
      addTearDown(h.close);
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.tunnel.disconnectCalls, 1, reason: observe(h));
      expect(h.tunnel.openVpnConnections, 1, reason: observe(h));
      expect(h.controller.isConnected, isTrue, reason: observe(h));
      expect(h.controller.notice, isNull, reason: observe(h));
    });

    test('control: a WireGuard error keeps the direct connection', () async {
      final h = await retained(VpnProtocol.wireGuard);
      addTearDown(h.close);
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.tunnel.disconnectCalls, 0, reason: observe(h));
      expect(h.tunnel.openVpnConnections, 1, reason: observe(h));
    });
  });
}
