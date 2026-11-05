// Lot S, corrections 2026-10-29: one distinction between a voluntary logout,
// an abandoned automatic admission and a temporary unavailability.
// Counterexamples ported from audit-complet-20261028/repros (A14, C4, A01,
// A02, H-RA-A06-01) with their assertions inverted.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

void main() {
  group('A14-storage-platform-01 transient Keystore read at startup', () {
    for (final code in ['secure_storage_read_failed', 'native_bridge_unavailable']) {
      test('$code keeps the stored session pending, then a retry restores it', () async {
        final h = SessionHarness.guest(session('token-a0'));
        addTearDown(h.close);
        h.store.readFailure = NativeVpnException(code);
        await h.controller.initialize();
        expect(h.store.clears, isEmpty, reason: observe(h));
        expect(h.store.autoResume, isTrue);
        expect(h.store.stored?.accessToken, 'token-a0');
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.controller.hasPendingAccountRestoration, isTrue);
        expect(h.controller.notice?.arguments['code'], code);
        // No new guest principal while the stored one is only unreadable.
        await h.controller.onAppResumed();
        expect(h.api.createdCredentials, isEmpty);

        await h.controller.retryAccountRestoration();
        expect(h.controller.isSignedIn, isTrue, reason: observe(h));
        expect(h.controller.profile?.userId, 'guest-a');
        expect(h.controller.token, 'token-a0');
        expect(h.store.clears, isEmpty);
        expect(h.api.createdCredentials, isEmpty);
      });
    }

    test('a proven corruption is erased without revoking guest recovery', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      h.store.readFailure = const NativeVpnException('secure_storage_corrupt');
      await h.controller.initialize();
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.store.stored, isNull);
      expect(h.tunnel.disconnectCalls, 1);
      expect(h.store.autoResume, isTrue);
      expect(h.controller.notice, isNull);
      // Recovery stays automatic in the next process.
      final next = h.nextProcess();
      addTearDown(next.close);
      await next.controller.initialize();
      expect(next.controller.profile?.userId, 'guest-a', reason: observe(next));
    });
  });

  group('C4-01 renewed guest session kept when only its restoration fails', () {
    for (final failure in <Object>[
      const ApiNetworkException(),
      const ApiException(statusCode: 503, errorCode: 'service_unavailable'),
      const NativeVpnException('secure_storage_read_failed'),
    ]) {
      test('expired stored guest, second stage throws $failure', () async {
        final h = SessionHarness.guest(session('token-a0', pastExpiry));
        addTearDown(h.close);
        if (failure is NativeVpnException) {
          h.store.deviceReadFailure = failure;
        } else {
          h.api.meScript['token-a1'] = <Object>[guestA, failure];
        }
        await h.controller.initialize();
        expect(h.store.replacements, ['token-a1'], reason: observe(h));
        expect(h.store.clears, isEmpty);
        expect(h.store.stored?.accessToken, 'token-a1');
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.controller.token, 'token-a1');
        expect(h.controller.hasPendingAccountRestoration, isTrue);
        // The notice names the temporary failure itself, never an expiry.
        expect(h.controller.notice?.arguments['code'], switch (failure) {
          ApiFailure(:final code) => code,
          NativeVpnException(:final code) => code,
          _ => fail('unexpected failure $failure'),
        }, reason: observe(h));
        expect(h.store.autoResume, isTrue);

        await h.controller.retryAccountRestoration();
        expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
        expect(h.controller.isSignedIn, isTrue);
        // The retry restores the committed session: no second principal.
        expect(h.api.createdCredentials, hasLength(1));
        expect(h.tunnel.disconnectCalls, 0);
      });
    }

    test('cached token refused by 401, renewal committed, second /me fails', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      h.api.meScript['token-a0'] = <Object>[unauthorized];
      h.api.meScript['token-a1'] = <Object>[guestA, const ApiNetworkException()];
      await h.controller.initialize();
      expect(h.store.replacements, ['token-a1'], reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.controller.token, 'token-a1');
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      await h.controller.retryAccountRestoration();
      expect(h.controller.profile?.userId, 'guest-a');
    });

    test('control: a renewal that fails before its write stays deferred', () async {
      final h = SessionHarness.guest(session('token-a0', pastExpiry));
      addTearDown(h.close);
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.store.clears, isEmpty);
      expect(h.controller.token, 'token-a0');
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.notice?.messageKey, 'guest.serviceUnavailable');
    });
  });

  group('A01-auth-01 deferred guest recovery bound to its own session', () {
    Future<SessionHarness> deferredAnonymousResume(bool nativeModel) async {
      final h = SessionHarness(nativeModel: nativeModel);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.controller.token, isNull);
      expect(h.controller.isGuestActionBusy, isFalse);
      return h;
    }

    for (final nativeModel in [false, true]) {
      for (final trigger in ['onAppResumed', 'retryAccountRestoration']) {
        test('pending e-mail login B is never replaced by guest A '
            '($trigger, nativeModel=$nativeModel)', () async {
          final h = await deferredAnonymousResume(nativeModel);
          addTearDown(h.close);
          h.api.meScript['token-b'] = <Object>[const ApiNetworkException()];
          expect(
            await h.controller.signIn(
              email: 'b@example.test',
              password: 'fixture-password',
            ),
            isFalse,
          );
          expect(h.controller.token, 'token-b');
          expect(h.controller.hasPendingAccountRestoration, isTrue);

          if (trigger == 'onAppResumed') {
            await h.controller.onAppResumed();
          } else {
            await h.controller.retryAccountRestoration();
          }
          await Future<void>.delayed(Duration.zero);
          expect(h.api.createdCredentials, hasLength(1), reason: observe(h));
          expect(h.store.replacements, isEmpty);
          expect(h.store.refusedReplacements, isEmpty);
          expect(h.store.clears, isEmpty);
          expect(h.controller.token, 'token-b');

          await h.controller.retryAccountRestoration();
          expect(h.controller.profile?.userId, 'registered-b', reason: observe(h));
          expect(h.controller.isSignedIn, isTrue);
          expect(h.store.autoResume, isFalse);
          expect(h.api.createdCredentials, hasLength(1));
        });
      }
    }
  });

  group('C4-03 an explicit sign-in revokes guest recovery before its write', () {
    test('B whose restoration never succeeded expires: guest A stays out', () async {
      final first = SessionHarness();
      addTearDown(first.close);
      await first.controller.initialize();
      first.store.credential = guestCredential;
      first.store.autoResume = true;
      first.api.meScript['token-b'] = <Object>[const ApiNetworkException()];
      expect(
        await first.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      expect(first.controller.hasPendingAccountRestoration, isTrue);
      expect(first.store.pending?.accessToken, 'token-b');
      expect(first.store.autoResume, isFalse, reason: observe(first));

      final second = first.nextProcess();
      addTearDown(second.close);
      second.store.pending = session('token-b', pastExpiry);
      await second.controller.initialize();
      await second.controller.onAppResumed();
      await Future<void>.delayed(Duration.zero);
      expect(second.api.createdCredentials, isEmpty, reason: observe(second));
      expect(second.controller.isSignedIn, isFalse);
      expect(second.controller.profile, isNull);
      expect(second.store.clears, [true]);
    });

    test('the recovery opt-out is durable before B is first written', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      final markerAtWrite = <bool>[];
      h.store.onWrite = () async => markerAtWrite.add(h.store.autoResume);
      expect(
        await h.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      // The pending write of B, then its account binding.
      expect(markerAtWrite, [false, false], reason: observe(h));
      expect(h.controller.profile?.userId, 'registered-b');
    });
  });

  group('C4-02 startup without session and a non-idle native state', () {
    const errorState = VpnRuntimeState(
      phase: VpnRuntimePhase.error,
      messageCode: 'system_vpn_resume_unavailable',
    );

    test('ERROR state without tunnel: a transient failure revokes nothing', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.tunnel.state = errorState;
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.store.clears, isEmpty, reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.guestMessageKey, 'guest.serviceUnavailable');
      await h.controller.onAppResumed();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
    });

    test('ERROR state: a committed guest whose second /me fails stays pending', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.tunnel.state = errorState;
      h.api.meScript['token-a1'] = <Object>[guestA, const ApiNetworkException()];
      await h.controller.initialize();
      expect(h.store.clears, isEmpty, reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.token, 'token-a1');
      expect(h.controller.hasPendingAccountRestoration, isTrue);
    });

    test('a live orphan tunnel is stopped without revoking recovery', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.tunnel.state = connectedAt(frankfurt);
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.tunnel.disconnectCalls, 1);
      expect(h.store.autoResume, isTrue);
      expect(h.controller.guestMessageKey, 'guest.serviceUnavailable');
      expect(h.controller.notice, isNull);
      final next = h.nextProcess();
      addTearDown(next.close);
      await next.controller.initialize();
      expect(next.controller.profile?.userId, 'guest-a', reason: observe(next));
    });

    test('control: an idle native state defers and resumes later', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.store.clears, isEmpty);
      await h.controller.onAppResumed();
      expect(h.controller.profile?.userId, 'guest-a');
    });
  });

  group('A02-guest-01 an abandoned admission keeps automatic recovery', () {
    test('fresh resume, native write fails after its commit', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.store.writeFailure = const NativeVpnException(
        'secure_storage_write_failed',
      );
      await h.controller.onAppResumed();
      await Future<void>.delayed(Duration.zero);
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.store.stored, isNull);
      expect(h.store.autoResume, isTrue);
      expect(h.controller.guestMessageKey, 'guest.secureStorageError');
      expect(h.controller.sessionTermination, isNull);
      await h.controller.onAppResumed();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
    });

    test('401 on a cached valid token, the replacement write fails', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      h.api.meScript['token-a0'] = <Object>[unauthorized];
      h.store.replaceFailure = const NativeVpnException(
        'secure_storage_write_failed',
      );
      await h.controller.initialize();
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.guestMessageKey, 'guest.secureStorageError');
      final next = h.nextProcess();
      addTearDown(next.close);
      await next.controller.initialize();
      expect(next.controller.profile?.userId, 'guest-a', reason: observe(next));
    });

    test('control: a voluntary logout still revokes automatic recovery', () async {
      final h = SessionHarness.guest(session('token-a0'));
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue);
      await h.controller.signOut();
      expect(h.store.clears, [false]);
      expect(h.store.autoResume, isFalse);
    });
  });

  group('H-RA-A06-01-02 Google Back during an automatic guest resume', () {
    test('the cancelled admission is purged without revoking recovery', () async {
      final google = _CancellingGoogle();
      final h = SessionHarness(google: google);
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      final entered = Completer<void>();
      final release = Completer<void>();
      h.store.onWrite = () async {
        if (entered.isCompleted) return;
        entered.complete();
        await release.future;
      };
      final resuming = h.controller.onAppResumed();
      await entered.future;
      // GoogleAuthController.cancel() keeps an intent pending while its
      // native call runs: the resume loses its authorization after its write.
      google.cancelling = true;
      release.complete();
      await resuming;
      google.cancelling = false;
      await Future<void>.delayed(Duration.zero);
      expect(h.store.clears, [true], reason: observe(h));
      // An abandoned end, not an expiry: same flag, but no expiry notice.
      expect(h.store.causes, [SessionEndCause.abandoned], reason: observe(h));
      expect(h.controller.notice, isNull, reason: observe(h));
      expect(h.store.autoResume, isTrue);
      expect(h.controller.token, isNull);
      expect(h.controller.sessionTermination, isNull);
      await h.controller.onAppResumed();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
    });
  });
}

class _CancellingGoogle extends GoogleAuthController {
  bool cancelling = false;
  @override
  bool get hasPendingIntent => cancelling || super.hasPendingIntent;
}
