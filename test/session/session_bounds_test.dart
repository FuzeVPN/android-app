// Lot S, corrections 2026-10-29: a session end is bounded in time (C1-02) and
// a device clock running ahead never rejects a session the server just
// delivered, and is reported with the device_clock_ahead notice (C4-04).
// Ported from audit-complet-20261028/repros (C1, C4).
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

import 'support/session_harness.dart';

Future<SessionHarness> _signedInAccount() async {
  final h = SessionHarness();
  h.store.activeUser = 'registered-b';
  h.store.accountSessions['registered-b'] = session('token-b');
  await h.controller.initialize();
  expect(h.controller.isSignedIn, isTrue, reason: observe(h));
  return h;
}

void main() {
  group('C1-02 bounded Dart session end', () {
    testWidgets('a stuck submitted write cannot hold the native end', (
      tester,
    ) async {
      final h = SessionHarness.guest(
        session('guest-token'),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue);
      final never = Completer<void>();
      h.store.onReplace = () => never.future;
      h.api.onDevices = (token) async {
        if (token == 'guest-token') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      // A 401 starts a guest renewal whose native replacement never answers.
      unawaited(h.controller.refreshDevices());
      await tester.pump();
      expect(h.store.replacements, ['token-a1']);

      // Never awaited: before the correction this end never completed.
      unawaited(h.controller.signOut());
      await tester.pump(const Duration(seconds: 9));
      expect(h.store.clears, isEmpty);
      await tester.pump(const Duration(seconds: 2));
      expect(h.store.clears, [false], reason: observe(h));
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.token, isNull);
      expect(h.store.autoResume, isFalse);
      await h.close();
    });

    testWidgets('an unanswered native end becomes retryable, and a retry works', (
      tester,
    ) async {
      final h = await _signedInAccount();
      final stuck = Completer<void>();
      h.store.onClear = () => stuck.future;
      unawaited(h.controller.signOut());
      await tester.pump(const Duration(seconds: 29));
      expect(h.controller.sessionTermination?.inProgress, isTrue);
      await tester.pump(const Duration(seconds: 2));
      final unconfirmed = h.controller.sessionTermination;
      expect(unconfirmed?.inProgress, isFalse, reason: observe(h));
      expect(unconfirmed?.stopError, 'session_termination_unconfirmed');

      h.store.onClear = null;
      await h.controller.retrySessionTermination();
      expect(h.store.clears, [false, false]);
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
      // The first, late answer cannot reopen anything.
      stuck.complete();
      await tester.pump();
      expect(h.controller.sessionTermination, isNull);
      await h.close();
    });

    testWidgets('a late native answer still completes the end', (tester) async {
      final h = await _signedInAccount();
      final stuck = Completer<void>();
      h.store.onClear = () => stuck.future;
      unawaited(h.controller.signOut());
      await tester.pump(const Duration(seconds: 31));
      expect(h.controller.sessionTermination?.inProgress, isFalse);
      stuck.complete();
      await tester.pump();
      expect(h.controller.sessionTermination, isNull, reason: observe(h));
      expect(h.store.clears, [false]);
      await h.close();
    });
  });

  group('C4-04 device clock ahead of the server', () {
    // Equivalent model: an expires_at already one second in the device's
    // past is a clock ahead by more than the token lifetime.
    DateTime clockAhead() => DateTime.now().subtract(const Duration(seconds: 1));

    test('an e-mail sign-in is admitted, restored and kept', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.api.loginExpiry = clockAhead();
      expect(
        await h.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isTrue,
        reason: observe(h),
      );
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.profile?.userId, 'registered-b');
      expect(h.api.meTokens, ['token-b']);
      expect(h.store.clears, isEmpty);
    });

    test('a new guest session is admitted', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.api.createExpiry = clockAhead();
      await h.controller.initialize();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
      expect(h.controller.guestMessageKey, isNull);
    });

    test('an expired guest with a live tunnel is renewed, not ended', () async {
      final h = SessionHarness.guest(session('token-a0', pastExpiry));
      addTearDown(h.close);
      h.api.createExpiry = clockAhead();
      await h.controller.initialize();
      expect(h.store.replacements, ['token-a1'], reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.controller.token, 'token-a1');
      expect(h.controller.isSignedIn, isTrue);
    });

    test('the clock notice follows an e-mail sign-in', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.api.loginExpiry = clockAhead();
      expect(
        await h.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isTrue,
        reason: observe(h),
      );
      final notice = h.controller.notice;
      expect(notice?.arguments['code'], 'device_clock_ahead', reason: observe(h));
      final en = lookupAppLocalizations(const Locale('en'));
      expect(
        AppCopy.resolve(en, notice!.titleKey, arguments: notice.arguments),
        'Device clock ahead',
      );
      expect(
        AppCopy.resolve(en, notice.messageKey, arguments: notice.arguments),
        'This device’s clock seems to be ahead. Turn on automatic date and '
        'time to stay signed in.',
      );
    });

    test('a new guest session raises the clock notice', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.api.createExpiry = clockAhead();
      await h.controller.initialize();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
      expect(h.controller.notice?.arguments['code'], 'device_clock_ahead');
    });

    test('a guest renewed at startup raises the clock notice', () async {
      final h = SessionHarness.guest(session('token-a0', pastExpiry));
      addTearDown(h.close);
      h.api.createExpiry = clockAhead();
      await h.controller.initialize();
      expect(h.controller.token, 'token-a1', reason: observe(h));
      expect(h.controller.notice?.arguments['code'], 'device_clock_ahead');
    });

    test('a guest renewed in the background raises the clock notice', () async {
      final h = SessionHarness.guest(
        session('guest-token'),
        tunnel: const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.notice, isNull);
      h.api.createExpiry = clockAhead();
      h.api.onDevices = (token) async {
        if (token == 'guest-token') throw unauthorized;
        return const DeviceList(limit: 2, devices: <VpnDevice>[]);
      };
      await h.controller.refreshDevices();
      expect(h.controller.token, 'token-a1', reason: observe(h));
      expect(h.store.clears, isEmpty);
      expect(h.controller.notice?.arguments['code'], 'device_clock_ahead');
    });

    test('control: sessions within the device clock raise no notice', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      await h.controller.initialize();
      expect(h.controller.profile?.userId, 'guest-a', reason: observe(h));
      expect(h.controller.notice, isNull);

      final b = SessionHarness();
      addTearDown(b.close);
      await b.controller.initialize();
      expect(
        await b.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isTrue,
        reason: observe(b),
      );
      expect(b.controller.notice, isNull);
    });

    test('control: a stored session already past its expiry still ends', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.activeUser = 'registered-b';
      h.store.accountSessions['registered-b'] = session('token-b', pastExpiry);
      await h.controller.initialize();
      expect(h.store.clears, [true]);
      expect(h.api.meTokens, isEmpty);
      expect(h.controller.isSignedIn, isFalse);
    });
  });
}
