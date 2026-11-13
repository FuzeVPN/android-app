// A cause that joins a session end is sent to native storage without waiting
// for its answer. When it arrives once native code has settled that end (its
// answer still on its way to Dart), storageClearSession starts a second end,
// which Dart only observes through the tunnel states: the state that reports
// it complete must close the cleanup page.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/repositories.dart';

import 'support/session_harness.dart';

const _endInProgress = VpnRuntimeState(
  phase: VpnRuntimePhase.disconnecting,
  messageCode: 'session_ending',
  sessionTermination: SessionTerminationResult(
    tunnelStopped: false,
    sessionCleared: false,
    inProgress: true,
  ),
);
const _endComplete = VpnRuntimeState(
  phase: VpnRuntimePhase.idle,
  sessionTermination: SessionTerminationResult(
    tunnelStopped: true,
    sessionCleared: true,
  ),
);

/// The first end is settled natively at once, but answered to Dart only when
/// [answer] completes. A cause sent meanwhile is recorded: Dart never waits
/// for its answer.
class _SettledEndStore extends SessionStore {
  _SettledEndStore(super.tunnel) : super(nativeModel: true);

  final answer = Completer<void>();
  final joined = <SessionEndCause>[];
  bool _settled = false;

  @override
  Future<SessionTerminationResult> clearSessionFor(
    SessionEndCause cause,
  ) async {
    if (_settled) {
      joined.add(cause);
      return Completer<SessionTerminationResult>().future;
    }
    _settled = true;
    final result = await super.clearSessionFor(cause);
    await answer.future;
    return result;
  }
}

/// Holds the startup at its first preference read, before its tunnel snapshot.
class _GatedPreferences extends SessionPreferences {
  final read = Completer<void>();

  @override
  Future<String?> readThemeMode() async {
    await read.future;
    return null;
  }
}

void main() {
  test('an end native code runs for a cause that joined after the first end '
      'was settled leaves the cleanup page once it completes', () async {
    final tunnel = SessionTunnel();
    final api = SessionApi();
    final store = _SettledEndStore(tunnel)
      ..activeUser = accountB.userId
      ..accountSessions[accountB.userId] = session('token-b');
    final controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: SessionPreferences(),
      tunnel: tunnel,
    );
    addTearDown(() async {
      controller.dispose();
      await tunnel.close();
    });
    await controller.initialize();
    expect(controller.isSignedIn, isTrue);

    // The server refuses the token: the session ends as an expiry.
    api.onDevices = (_) async => throw unauthorized;
    unawaited(controller.refreshDevices());
    await pumpEventQueue();
    expect(store.causes, [SessionEndCause.expired]);
    expect(controller.sessionTermination?.inProgress, isTrue);

    // A sign-out joins that end before its answer reaches Dart.
    final signedOut = controller.signOut();
    await pumpEventQueue();
    expect(store.joined, [SessionEndCause.voluntary]);
    store.answer.complete();
    await signedOut;
    expect(controller.sessionTermination, isNull);

    // Native code runs the joined cause as a second end.
    tunnel.emit(_endInProgress);
    await pumpEventQueue();
    expect(controller.sessionTermination?.inProgress, isTrue);
    tunnel.emit(_endComplete);
    await pumpEventQueue();
    expect(controller.sessionTermination, isNull);
    expect(controller.tunnelState.phase, VpnRuntimePhase.idle);
    expect(controller.isSignedIn, isFalse);
  });

  test('an end still running when the app is reopened, and settled before '
      'the startup snapshot, does not keep the cleanup page', () async {
    final tunnel = SessionTunnel();
    final preferences = _GatedPreferences();
    final controller = VpnAppController(
      api: SessionApi(),
      sessionStore: SessionStore(tunnel, nativeModel: true),
      preferences: preferences,
      tunnel: tunnel,
    );
    addTearDown(() async {
      controller.dispose();
      await tunnel.close();
    });
    final starting = controller.initialize();
    // The end a previous engine asked for publishes its progress, then its
    // completion, while this startup still reads its preferences.
    tunnel.emit(_endInProgress);
    await pumpEventQueue();
    expect(controller.sessionTermination?.inProgress, isTrue);
    tunnel.emit(_endComplete);
    await pumpEventQueue();
    preferences.read.complete();
    await starting;
    expect(controller.isInitializing, isFalse);
    expect(controller.sessionTermination, isNull);
    expect(controller.tunnelState.phase, VpnRuntimePhase.idle);
  });

  test('control: a completed termination state does not close an end Dart '
      'is still waiting for', () async {
    final tunnel = SessionTunnel();
    final api = SessionApi();
    final store = _SettledEndStore(tunnel)
      ..activeUser = accountB.userId
      ..accountSessions[accountB.userId] = session('token-b');
    final controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: SessionPreferences(),
      tunnel: tunnel,
    );
    addTearDown(() async {
      controller.dispose();
      await tunnel.close();
    });
    await controller.initialize();
    final signedOut = controller.signOut();
    await pumpEventQueue();
    // settleEnd publishes the settled end before it answers the request.
    tunnel.emit(_endComplete);
    await pumpEventQueue();
    expect(controller.sessionTermination?.inProgress, isTrue);
    store.answer.complete();
    await signedOut;
    expect(controller.sessionTermination, isNull);
  });
}
