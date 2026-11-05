import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  group('session correction regressions', () {
    for (final protocol in VpnProtocol.values) {
      test(
        'logout starts without a guest marker write for $protocol',
        () async {
          final h = await _Harness.create(signedIn: true);
          addTearDown(h.close);
          h.tunnel.emit(
            VpnRuntimeState(
              phase: VpnRuntimePhase.connected,
              protocol: protocol,
            ),
          );
          await Future<void>.delayed(Duration.zero);
          final previousWrites = h.store.autoResumeWrites;
          h.store.autoResumeWrite = () async {
            throw const NativeVpnException('secure_storage_write_failed');
          };
          final release = Completer<void>();
          h.store.clearRelease = release.future;

          final logout = h.controller.signOut();
          expect(h.controller.token, isNull);
          expect(h.controller.isSignedIn, isFalse);
          expect(h.controller.sessionTermination?.inProgress, isTrue);
          expect(h.store.autoResumeWrites, previousWrites);
          await Future<void>.delayed(Duration.zero);
          expect(h.store.clearCalls, 1);
          release.complete();
          await logout;

          expect(h.tunnel.stopCalls, 1);
          expect(h.store.session, isNull);
          expect(h.store.autoResume, isFalse);
          expect(h.controller.sessionTermination, isNull);
          expect(h.api.logoutCalls, 1);
        },
      );
    }

    for (final fail in [false, true]) {
      test(
        'obsolete reset cannot release another login (error=$fail)',
        () async {
          final h = await _Harness.create();
          addTearDown(h.close);
          final resetRelease = Completer<void>();
          h.api.reset = () => resetRelease.future;
          final reset = h.controller.requestPasswordReset('first@example.test');
          await h.controller.signOut();
          final loginRelease = Completer<void>();
          h.api.loginWait = () => loginRelease.future;
          final login = h.controller.signIn(
            email: 'second@example.test',
            password: 'fixture',
          );
          expect(h.controller.isAuthenticating, isTrue);

          if (fail) {
            resetRelease.completeError(const ApiNetworkException());
          } else {
            resetRelease.complete();
          }
          expect(await reset, isFalse);
          expect(h.controller.isAuthenticating, isTrue);
          expect(h.controller.notice, isNull);
          expect(
            await h.controller.signIn(
              email: 'third@example.test',
              password: 'fixture',
            ),
            isFalse,
          );
          loginRelease.complete();
          expect(await login, isTrue);
          expect(h.controller.isAuthenticating, isFalse);
        },
      );
    }

    test('reset completion after disposal cannot publish a notice', () async {
      final h = await _Harness.create();
      final release = Completer<void>();
      h.api.reset = () => release.future;
      final reset = h.controller.requestPasswordReset('first@example.test');
      h.controller.dispose();
      release.complete();
      expect(await reset, isFalse);
      expect(h.controller.notice, isNull);
      expect(h.controller.isAuthenticating, isFalse);
      await h.tunnel.close();
    });

    test('reset remains usable after an ordinary logout', () async {
      final h = await _Harness.create(signedIn: true);
      addTearDown(h.close);
      await h.controller.signOut();
      expect(
        await h.controller.requestPasswordReset('first@example.test'),
        isTrue,
      );
      expect(h.controller.notice?.arguments['code'], 'password_reset_sent');
      expect(h.controller.isAuthenticating, isFalse);
    });

    for (final initiallyConnected in [false, true]) {
      test(
        'resume reconciles a missed tunnel transition ($initiallyConnected)',
        () async {
          final h = await _Harness.create();
          addTearDown(h.close);
          h.controller.tunnelState = VpnRuntimeState(
            phase: initiallyConnected
                ? VpnRuntimePhase.connected
                : VpnRuntimePhase.idle,
            protocol: initiallyConnected ? VpnProtocol.wireGuard : null,
          );
          h.tunnel.state = VpnRuntimeState(
            phase: initiallyConnected
                ? VpnRuntimePhase.idle
                : VpnRuntimePhase.connected,
            protocol: initiallyConnected ? null : VpnProtocol.wireGuard,
          );
          await h.controller.onAppResumed();
          expect(h.controller.isConnected, !initiallyConnected);
        },
      );
    }

    test('a resume snapshot cannot overwrite a newer native event', () async {
      final h = await _Harness.create();
      addTearDown(h.close);
      final reply = Completer<VpnRuntimeState>();
      h.tunnel.snapshot = () => reply.future;
      final resume = h.controller.onAppResumed();
      h.tunnel.emit(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.openVpn,
        ),
      );
      await Future<void>.delayed(Duration.zero);
      reply.complete(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await resume;
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.tunnelState.protocol, VpnProtocol.openVpn);
    });

    test('a resume snapshot cannot overwrite a newer snapshot', () async {
      final h = await _Harness.create();
      addTearDown(h.close);
      final old = Completer<VpnRuntimeState>();
      final latest = Completer<VpnRuntimeState>();
      var calls = 0;
      h.tunnel.snapshot = () => calls++ == 0 ? old.future : latest.future;
      final oldResume = h.controller.onAppResumed();
      final newResume = h.controller.onAppResumed();
      latest.complete(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
        ),
      );
      await newResume;
      old.complete(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await oldResume;
      expect(h.controller.isConnected, isTrue);
    });

    test(
      'a resume snapshot from the logged-out account stays obsolete',
      () async {
        final h = await _Harness.create(signedIn: true);
        addTearDown(h.close);
        final reply = Completer<VpnRuntimeState>();
        h.tunnel.snapshot = () => reply.future;
        final resume = h.controller.onAppResumed();
        await h.controller.signOut();
        expect(
          await h.controller.signIn(
            email: 'next@example.test',
            password: 'fixture',
          ),
          isTrue,
        );
        reply.complete(
          const VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
            protocol: VpnProtocol.openVpn,
          ),
        );
        await resume;
        expect(h.controller.isConnected, isFalse);
        expect(h.controller.isSignedIn, isTrue);
      },
    );

    test('a failed resume snapshot preserves the current tunnel', () async {
      final h = await _Harness.create();
      addTearDown(h.close);
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      h.tunnel.snapshot = () async =>
          throw const NativeVpnException('native_bridge_unavailable');
      await h.controller.onAppResumed();
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.notice, isNull);
    });

    testWidgets('a stalled resume snapshot has a bounded wait', (tester) async {
      final h = await _Harness.create();
      addTearDown(h.close);
      final reply = Completer<VpnRuntimeState>();
      h.tunnel.snapshot = () => reply.future;
      final resume = h.controller.onAppResumed();
      await tester.pump(const Duration(seconds: 5));
      await resume;
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
      reply.complete(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
        ),
      );
      await tester.pump();
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
    });
  });
}

class _Harness {
  _Harness(this.controller, this.api, this.store, this.tunnel);
  final VpnAppController controller;
  final _Api api;
  final _Store store;
  final _Tunnel tunnel;

  static Future<_Harness> create({bool signedIn = false}) async {
    final api = _Api();
    final tunnel = _Tunnel();
    final store = _Store(tunnel);
    final controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: _Preferences(),
      tunnel: tunnel,
    );
    await controller.initialize();
    if (signedIn) {
      expect(
        await controller.signIn(
          email: 'fixture@example.test',
          password: 'fixture',
        ),
        isTrue,
      );
    }
    return _Harness(controller, api, store, tunnel);
  }

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _Api extends Fake implements VpnApiRepository {
  Future<void> Function()? loginWait;
  Future<void> Function()? reset;
  int logoutCalls = 0;
  @override
  Future<List<Location>> locations() async => const [];
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    await loginWait?.call();
    return AuthSession(accessToken: 'fixture', expiresAt: DateTime.utc(2099));
  }

  @override
  Future<UserProfile> me(String token) async =>
      const UserProfile(userId: 'user-fixture');
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: []);
  @override
  Future<void> logout(String token) async {
    logoutCalls++;
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await reset?.call();
  }
}

class _Store extends Fake implements SecureSessionStore, GuestCredentialStore {
  _Store(this.tunnel);
  final _Tunnel tunnel;
  AuthSession? session;
  bool autoResume = false;
  int clearCalls = 0;
  int autoResumeWrites = 0;
  Future<void>? clearRelease;
  Future<void> Function()? autoResumeWrite;
  @override
  Future<AuthSession?> readSession() async => session;
  @override
  Future<void> writeSession(AuthSession value, {String? userId}) async {
    session = value;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async => null;
  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    clearCalls++;
    await clearRelease;
    await tunnel.disconnect();
    session = null;
    if (!expired) autoResume = false;
    return const SessionTerminationResult.complete();
  }

  @override
  Future<bool> readGuestAutoResume() async => autoResume;
  @override
  Future<void> writeGuestAutoResume(bool enabled) async {
    autoResumeWrites++;
    await autoResumeWrite?.call();
    autoResume = enabled;
  }

  @override
  Future<String?> readGuestCredential() async => null;
  @override
  Future<String?> readPendingGuestCredential() async => null;
}

class _Preferences extends Fake implements AppPreferenceStore {
  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => null;
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {}
}

class _Tunnel extends Fake implements VpnTunnelGateway {
  final events = StreamController<VpnRuntimeState>.broadcast();
  VpnRuntimeState state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  Future<VpnRuntimeState> Function()? snapshot;
  int stopCalls = 0;
  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async =>
      snapshot == null ? state : await snapshot!();
  @override
  Future<void> disconnect() async {
    stopCalls++;
    state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  }

  void emit(VpnRuntimeState value) {
    state = value;
    events.add(value);
  }

  Future<void> close() => events.close();
}
