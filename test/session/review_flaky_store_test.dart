// Lot S, revue croisée de Helper2 : lectures Keystore transitoires (P4 pour
// C4-03, P5 pour la classe A14) et clé Keystore définitivement absente (P6 :
// le natif remonte secure_storage_corrupt pour la session, sa liaison et
// l'appareil courant). Tests P4 et P5 de Helper2 (revue croisée du lot S) ;
// P6 ajouté par Helper1.
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

const _readFailed = NativeVpnException('secure_storage_read_failed');
const _corrupt = NativeVpnException('secure_storage_corrupt');

class _FlakyStore extends SessionStore {
  _FlakyStore(super.tunnel) : super(nativeModel: true);
  Object? autoResumeReadFailure;
  Object? bindingReadFailure;

  @override
  Future<bool> readGuestAutoResume() async {
    final failure = autoResumeReadFailure;
    if (failure != null) {
      autoResumeReadFailure = null;
      throw failure;
    }
    return super.readGuestAutoResume();
  }

  @override
  Future<bool> readStoredSessionIsPendingAdmission() async {
    final failure = bindingReadFailure;
    if (failure != null) {
      bindingReadFailure = null;
      throw failure;
    }
    return super.readStoredSessionIsPendingAdmission();
  }
}

class _Rig {
  _Rig() {
    store = _FlakyStore(tunnel);
    controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: preferences,
      tunnel: tunnel,
    );
  }

  final api = SessionApi();
  final tunnel = SessionTunnel();
  final preferences = SessionPreferences();
  late final _FlakyStore store;
  late final VpnAppController controller;

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }

  String get observed =>
      'token=${controller.token} profile=${controller.profile?.userId} '
      'pending=${controller.hasPendingAccountRestoration} '
      'stored=${store.stored?.accessToken} clears=${store.clears} '
      'causes=${store.causes} created=${api.createdCredentials.length} '
      'refused=${store.refusedReplacements} replacements=${store.replacements} '
      'disconnects=${tunnel.disconnectCalls} '
      'notice=${controller.notice?.messageKey}/${controller.notice?.arguments['code']}';
}

void main() {
  test('P5 a startup 401 with a transient auto-resume read keeps the '
      'guest and its tunnel', () async {
    final r = _Rig();
    addTearDown(r.close);
    r.store.activeUser = 'guest-a';
    r.store.accountSessions['guest-a'] = session('token-a0');
    r.store.credential = guestCredential;
    r.store.autoResume = true;
    r.tunnel.state = connectedAt(frankfurt);
    r.api.meScript['token-a0'] = <Object>[unauthorized];
    r.store.autoResumeReadFailure = _readFailed;
    await r.controller.initialize();
    await pumpEventQueue();
    expect(r.store.clears, isEmpty, reason: r.observed);
    expect(r.tunnel.disconnectCalls, 0, reason: r.observed);
    expect(r.controller.hasPendingAccountRestoration, isTrue, reason: r.observed);

    // The retry restores the guest session that was kept.
    await r.controller.retryAccountRestoration();
    await pumpEventQueue();
    expect(r.controller.profile?.userId, 'guest-a', reason: r.observed);
    expect(r.store.clears, isEmpty);
  });

  test('P4 an expired stored registered B whose binding read fails '
      'once still never resumes guest A', () async {
    final r = _Rig();
    addTearDown(r.close);
    r.store.pending = session('token-b', pastExpiry);
    r.store.credential = guestCredential;
    r.store.autoResume = true;
    r.store.bindingReadFailure = _readFailed;
    await r.controller.initialize();
    await pumpEventQueue();
    await r.controller.onAppResumed();
    await pumpEventQueue();
    expect(r.api.createdCredentials, isEmpty, reason: r.observed);
    expect(r.controller.profile?.userId, isNot('guest-a'), reason: r.observed);
    expect(r.store.clears, isEmpty, reason: r.observed);
    expect(r.controller.hasPendingAccountRestoration, isTrue);

    // The retry reads the binding again: B ends as an expiry, A stays out.
    await r.controller.retryAccountRestoration();
    await pumpEventQueue();
    expect(r.store.causes, [SessionEndCause.expired], reason: r.observed);
    expect(r.store.autoResume, isFalse);
    expect(r.api.createdCredentials, isEmpty);
  });

  group('P6 a Keystore key gone for good (secure_storage_corrupt)', () {
    test('an unreadable session binding never resumes guest A', () async {
      final r = _Rig();
      addTearDown(r.close);
      r.store.pending = session('token-b', pastExpiry);
      r.store.credential = guestCredential;
      r.store.autoResume = true;
      r.store.bindingReadFailure = _corrupt;
      await r.controller.initialize();
      await r.controller.onAppResumed();
      await pumpEventQueue();
      expect(r.api.createdCredentials, isEmpty, reason: r.observed);
      expect(r.store.causes, [SessionEndCause.expired], reason: r.observed);
      expect(r.store.autoResume, isFalse);
    });

    test('an unreadable current device is forgotten, the session is kept', () async {
      final h = SessionHarness.guest(
        session('token-a0'),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      h.store.deviceReadFailure = _corrupt;
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.profile?.userId, 'guest-a');
      expect(h.controller.currentDeviceId, isNull);
      expect(h.store.deviceIds, isNot(contains('guest-a')));
      expect(h.store.clears, isEmpty);
    });

    test('control: a transient device read keeps the restoration pending', () async {
      final h = SessionHarness.guest(
        session('token-a0'),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      addTearDown(h.close);
      h.store.deviceIds['guest-a'] = 'device-a';
      h.store.deviceReadFailure = _readFailed;
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.hasPendingAccountRestoration, isTrue, reason: observe(h));
      expect(h.store.deviceIds['guest-a'], 'device-a');
      expect(h.store.clears, isEmpty);
    });
  });
}
