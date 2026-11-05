// Lot S follow-ups requested by the root session (2026-10-29):
//  * C4-03: a stored registered session, even expired or never restored, is an
//    explicit intent to leave the guest; its end never resumes the guest;
//  * A02-guest-05: the restoration page shows the guest Retry-After countdown;
//  * A13-dart-vpn-02: the OpenVPN profile path renews a refused guest token.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

const _writeFailure = NativeVpnException('secure_storage_write_failed');

/// The storage left by an e-mail login B that was never restored while an
/// older guest A still had automatic recovery (a failed opt-out, or an
/// installation that predates the correction).
SessionHarness _pendingRegisteredB(AuthSession b) {
  final h = SessionHarness();
  h.store.pending = b;
  h.store.credential = guestCredential;
  h.store.autoResume = true;
  return h;
}

void main() {
  group('C4-03 a stored registered session never resumes the guest', () {
    test('expired B with recovery still on: no guest, opt-out retried', () async {
      final h = _pendingRegisteredB(session('token-b', pastExpiry));
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));
      expect(h.store.autoResumeWrites, [false]);
      expect(h.store.autoResume, isFalse);
      expect(h.store.clears, [true]);
      expect(h.controller.isSignedIn, isFalse);
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));
      expect(h.controller.profile, isNull);
    });

    test('the retried opt-out fails again: still no guest and no purge', () async {
      final h = _pendingRegisteredB(session('token-b', pastExpiry));
      addTearDown(h.close);
      h.store.autoResumeWriteFailure = _writeFailure;
      await h.controller.initialize();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));
      expect(h.store.autoResumeWrites, [false]);
      expect(h.store.clears, isEmpty);
      expect(h.store.stored?.accessToken, 'token-b');
      expect(h.controller.notice?.arguments['code'], _writeFailure.code);
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));

      // Next launch: B is still there, and this time the opt-out commits.
      final next = h.nextProcess();
      addTearDown(next.close);
      await next.controller.initialize();
      await next.controller.onAppResumed();
      expect(next.api.createdCredentials, isEmpty, reason: observe(next));
      expect(next.store.autoResume, isFalse);
      expect(next.store.clears, [true]);
    });

    test('a stored B refused by 401: no guest, opt-out retried, then ended', () async {
      final h = _pendingRegisteredB(session('token-b'));
      addTearDown(h.close);
      h.api.meScript['token-b'] = <Object>[unauthorized];
      await h.controller.initialize();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));
      expect(h.store.autoResume, isFalse);
      expect(h.store.clears, [true]);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, isEmpty);
    });

    test('a 401 with a failing opt-out keeps B pending, never the guest', () async {
      final h = _pendingRegisteredB(session('token-b'));
      addTearDown(h.close);
      h.api.meScript['token-b'] = <Object>[unauthorized, unauthorized];
      h.store.autoResumeWriteFailure = _writeFailure;
      await h.controller.initialize();
      expect(h.api.createdCredentials, isEmpty, reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.notice?.arguments['code'], _writeFailure.code);
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, isEmpty);

      // Retry once the disk accepts the opt-out: B ends as expired.
      h.store.autoResumeWriteFailure = null;
      await h.controller.retryAccountRestoration();
      expect(h.store.autoResume, isFalse, reason: observe(h));
      expect(h.store.clears, [true]);
      expect(h.api.createdCredentials, isEmpty);
    });

    test('control: a guest alone still resumes normally', () async {
      final h = SessionHarness.guest(session('token-a0', pastExpiry));
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.store.replacements, ['token-a1'], reason: observe(h));
      expect(h.controller.profile?.userId, 'guest-a');
      expect(h.store.autoResume, isTrue);
    });
  });

  group('A02-guest-05 restoration countdown', () {
    testWidgets('the guest Retry-After delay is shown and owns the retry', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(420, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final h = SessionHarness.guest(
        session('token-a0', pastExpiry),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      h.api.createFailures.add(
        const ApiException(
          statusCode: 503,
          errorCode: 'service_unavailable',
          retryAfterSeconds: 60,
        ),
      );
      await tester.pumpWidget(FuzeVpnApp(controller: h.controller));
      await tester.pump();
      await tester.pump();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      final countdown = find.byKey(const ValueKey('restoration-retry-countdown'));
      expect(countdown, findsOneWidget);
      expect(tester.widget<Text>(countdown).data, contains('60'));
      final retry = find.byKey(const ValueKey('retry-account-restoration'));
      expect(tester.widget<ButtonStyleButton>(retry).onPressed, isNull);

      await tester.pump(const Duration(seconds: 61));
      expect(countdown, findsNothing);
      expect(tester.widget<ButtonStyleButton>(retry).onPressed, isNotNull);
      await tester.tap(retry);
      await tester.pump();
      await tester.pump();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));

      await tester.pumpWidget(const SizedBox());
      await h.close();
    });
  });

  group('A13-dart-vpn-02 OpenVPN profile path', () {
    test('createOpenVpnProfile 401: renewed, tunnel kept, connection continues', () async {
      final h = SessionHarness.guest(
        session('guest-token'),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      addTearDown(h.close);
      h.preferences.protocol = 'openvpn';
      h.store.deviceIds['guest-a'] = 'device-a';
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue);
      h.api.onOpenVpnProfile = (token) async {
        if (token == 'guest-token') throw unauthorized;
      };
      await h.controller.connect();
      await pumpEventQueue();
      expect(h.api.openVpnProfiles, [
        ('guest-token', 'device-a'),
        ('token-a1', 'device-a'),
      ], reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.openVpnConnections, 1);
      expect(h.controller.token, 'token-a1');
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.isConnecting, isFalse);
    });
  });
}
