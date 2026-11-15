import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/core/security_challenge.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

// Renewable app sessions, Dart half (renouvellement-session/PLAN.md): native
// code alone holds the refresh token; the controller asks it for the current
// access and keeps the session's identity across renewals.
void main() {
  group('startup', () {
    test('an expired access is renewed before its expiry is judged', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native
        ..renewable = true
        ..stored = _session('access-old', const Duration(minutes: -10));

      await h.controller.initialize();

      expect(h.native.calls, contains('ensure:null'));
      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.token, 'access-r1');
      expect(h.api.calls, contains('me:access-r1'));
      expect(h.api.calls, isNot(contains('me:access-old')));
      // Native code owns the renewed access: Dart never writes it back.
      expect(h.native.calls, isNot(contains(startsWith('write:'))));
      // Already renewable: nothing is converted again.
      await pumpEventQueue();
      expect(
        h.native.calls.where((call) => call.startsWith('upgrade')),
        isEmpty,
      );
    });

    test('a classic expired session still ends as an expiry', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native.stored = _session('access-old', const Duration(minutes: -10));

      await h.controller.initialize();

      expect(h.native.calls, containsAllInOrder(['ensure:null', 'clear']));
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
      expect(h.api.calls.where((call) => call.startsWith('me:')), isEmpty);
    });

    for (final error in [
      SessionRenewalError.unauthorized,
      SessionRenewalError.refreshExpired,
    ]) {
      test(
        'a refused renewal ($error) ends the session as an expiry',
        () async {
          final h = _Harness();
          addTearDown(h.close);
          h.native
            ..renewable = true
            ..stored = _session('access-old', const Duration(minutes: 2))
            ..ensureFailure = SessionRenewalFailure(error);

          await h.controller.initialize();

          expect(h.native.calls, containsAllInOrder(['ensure:null', 'clear']));
          expect(h.controller.isSignedIn, isFalse);
          expect(h.controller.notice?.arguments['code'], 'unauthorized');
        },
      );
    }

    test('a temporary renewal failure keeps the expired session pending, then '
        'a retry renews it', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native
        ..renewable = true
        ..stored = _session('access-old', const Duration(minutes: -10))
        ..ensureFailure = const SessionRenewalFailure(
          SessionRenewalError.unavailable,
          retryAfterSeconds: 30,
        );

      await h.controller.initialize();

      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.notice?.arguments['code'], 'network_unavailable');
      expect(h.api.calls.where((call) => call.startsWith('me:')), isEmpty);

      h.native.ensureFailure = null;
      await h.controller.retryAccountRestoration();

      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.token, 'access-r1');
      expect(h.native.calls, isNot(contains('clear')));
    });

    test('a valid stored session is restored first, then converted', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native.stored = _session('access-old', const Duration(days: 20));

      await h.controller.initialize();
      await pumpEventQueue();

      expect(h.native.calls, isNot(contains('ensure:null')));
      expect(h.api.calls.first, 'me:access-old');
      expect(h.native.calls, contains('upgrade:user-1'));
      expect(
        h.native.calls.indexOf('upgrade:user-1'),
        greaterThan(h.native.calls.indexOf('write:access-old:user-1')),
      );
      expect(h.controller.token, 'access-r1');
    });

    test(
      'a device clock ahead never ends a session native code renewed',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        // The renewed access is valid for the server, already past on a device
        // clock running more than an hour ahead.
        h.native
          ..renewable = true
          ..accessLifetime = const Duration(minutes: -30)
          ..stored = _session('access-old', const Duration(minutes: -90));

        await h.controller.initialize();
        await h.controller.onAppResumed();
        await h.controller.refreshDevices();
        await pumpEventQueue();

        expect(h.native.calls, isNot(contains('clear')));
        expect(h.controller.isSignedIn, isTrue);
        expect(h.controller.canChangeLocation, isTrue);
        expect(h.api.calls, contains('me:access-r1'));
        expect(h.controller.sessionTermination, isNull);
      },
    );

    test('a failed native write keeps an expired session pending', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native
        ..renewable = true
        ..stored = _session('access-old', const Duration(minutes: -10))
        ..ensureFailure = const NativeVpnException(
          'secure_storage_write_failed',
        );

      await h.controller.initialize();

      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.notice?.arguments['code'], 'network_unavailable');
    });

    test('a bridge without renewal keeps the historical end of an expired '
        'session', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native
        ..stored = _session('access-old', const Duration(minutes: -10))
        ..ensureFailure = const NativeVpnException('native_bridge_unavailable');

      await h.controller.initialize();

      expect(h.native.calls, containsAllInOrder(['ensure:null', 'clear']));
      expect(h.controller.isSignedIn, isFalse);
    });

    testWidgets('a native renewal that never answers keeps the session after '
        '25 s', (tester) async {
      final h = _Harness();
      addTearDown(h.close);
      final gate = Completer<void>();
      addTearDown(gate.complete);
      h.native
        ..renewable = true
        ..stored = _session('access-old', const Duration(minutes: -10))
        ..ensureGate = gate;

      var started = false;
      unawaited(h.controller.initialize().then((_) => started = true));
      await tester.pump(const Duration(seconds: 24));
      expect(h.controller.isInitializing, isTrue);
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();

      expect(started, isTrue);
      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.notice?.arguments['code'], 'network_unavailable');
    });
  });

  group('conversion', () {
    for (final register in [false, true]) {
      test('a personal session is converted once /me confirmed it '
          '(register: $register)', () async {
        final h = await _Harness.ready();
        addTearDown(h.close);
        final admitted = register
            ? await h.controller.register(_registration)
            : await h.controller.signIn(email: 'a@example.test', password: 'x');
        expect(admitted, isTrue);
        await pumpEventQueue();

        expect(
          h.native.calls,
          containsAllInOrder([
            'write:access-login:null',
            'write:access-login:user-1',
            'upgrade:user-1',
          ]),
        );
        expect(h.api.calls, contains('me:access-login'));
        expect(h.controller.token, 'access-r1');
        expect(h.controller.isSignedIn, isTrue);
        // A converted access is never written back by Dart.
        expect(h.native.calls, isNot(contains(startsWith('write:access-r1'))));
      });
    }

    test('a rotated access reaches billing and diagnostics', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      final revision = h.controller.billing.accountRevision;
      await h.controller.billing.refreshSubscription();
      expect(h.billing.tokens.last, 'access-r1');
      expect(h.diagnostics.tokens.last, 'access-r1');

      h.native.rotate();
      await h.controller.onAppResumed();
      await pumpEventQueue();

      expect(h.controller.token, 'access-r2');
      expect(h.diagnostics.tokens.last, 'access-r2');
      // The same account session: billing keeps its state and requests.
      expect(h.controller.billing.accountRevision, revision);
      await h.controller.billing.refreshSubscription();
      expect(h.billing.tokens.last, 'access-r2');
    });

    test('a server without the contract keeps the classic session', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn(upgrade: false);

      await h.controller.onAppResumed();
      await h.controller.refreshDevices();

      expect(h.controller.token, 'access-login');
      // Answered classic: neither converted again nor renewed in this process.
      expect(h.native.calls.where((call) => call.startsWith('upgrade')), [
        'upgrade:user-1',
      ]);
      expect(
        h.native.calls.where((call) => call.startsWith('ensure')),
        isEmpty,
      );
    });

    test('a conversion owed after a temporary failure is asked again when '
        'the app returns to the foreground', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.upgradeFailure = const SessionRenewalFailure(
        SessionRenewalError.unavailable,
      );
      await h.signIn();
      expect(h.controller.token, 'access-login');
      expect(h.controller.isSignedIn, isTrue);

      h.native.upgradeFailure = null;
      await h.controller.onAppResumed();
      await pumpEventQueue();

      expect(h.native.calls.where((call) => call.startsWith('upgrade')), [
        'upgrade:user-1',
        'upgrade:user-1',
      ]);
      expect(h.controller.token, 'access-r1');
    });

    test('a conversion whose answer was lost is resumed by the 401 of its '
        'previous access', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.loseUpgradeAnswer = true;
      await h.signIn();
      expect(h.controller.token, 'access-login');
      h.api.refused.add('access-login');
      h.api.calls.clear();

      await h.controller.refreshDevices();

      expect(h.api.calls.where((call) => call.startsWith('devices')).toList(), [
        'devices:access-login',
        'devices:access-r1',
      ]);
      expect(h.controller.token, 'access-r1');
      expect(h.controller.isSignedIn, isTrue);
      expect(h.native.calls, isNot(contains('clear')));
    });
  });

  group('renewal', () {
    test('returning to the foreground takes the access native code renewed '
        'in the background', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.native.rotate();

      await h.controller.onAppResumed();
      await h.controller.refreshDevices();

      expect(h.native.calls, contains('ensure:user-1'));
      expect(h.controller.token, 'access-r2');
      expect(h.api.calls.last, 'devices:access-r2');
      expect(h.controller.profile?.userId, 'user-1');
    });

    test('an operation renews an access that expires within five minutes '
        'first', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.accessLifetime = const Duration(minutes: 2);
      await h.signIn();
      h.native.accessLifetime = const Duration(hours: 1);
      h.api.calls.clear();

      await h.controller.refreshDevices();

      expect(h.native.calls.last, 'ensure:user-1');
      expect(h.api.calls, ['devices:access-r2']);
    });

    test('a 401 forces one renewal whatever the device clock says (clock '
        'behind), and the request is sent again', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      // Valid for another hour on the device clock, expired for the server.
      h.api.refused.add('access-r1');
      h.api.calls.clear();

      await h.controller.refreshDevices();

      expect(h.native.calls.last, 'force:user-1');
      expect(h.api.calls, ['devices:access-r1', 'devices:access-r2']);
      expect(h.controller.token, 'access-r2');
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.notice, isNull);
      expect(h.native.calls, isNot(contains('clear')));
    });

    test('a 401 that another renewal already answered is sent again with '
        'that access', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      final gate = Completer<void>();
      h.api.devicesGate = gate;
      h.api.refused.add('access-r1');
      h.api.calls.clear();

      final refreshing = h.controller.refreshDevices();
      await pumpEventQueue();
      h.native.rotate();
      await h.controller.onAppResumed();
      gate.complete();
      await refreshing;

      expect(h.api.calls, ['devices:access-r1', 'devices:access-r2']);
      expect(h.native.calls, isNot(contains(startsWith('force'))));
      expect(h.controller.isSignedIn, isTrue);
    });

    test('a 401 whose forced renewal returns the same access ends the '
        'session as before', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.native.forceKeepsAccess = true;
      h.api.refused.add('access-r1');
      h.api.calls.clear();

      await h.controller.refreshDevices();
      await pumpEventQueue();

      expect(h.api.calls, ['devices:access-r1']);
      expect(h.native.calls, containsAllInOrder(['force:user-1', 'clear']));
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
    });

    test('a 401 whose forced renewal is refused (session_unauthorized) ends '
        'the session', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.native.ensureFailure = const SessionRenewalFailure(
        SessionRenewalError.unauthorized,
      );
      h.api.refused.add('access-r1');
      h.api.calls.clear();

      await h.controller.refreshDevices();
      await pumpEventQueue();

      expect(h.api.calls, ['devices:access-r1']);
      expect(h.native.calls, containsAllInOrder(['force:user-1', 'clear']));
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
    });

    test('the request is sent again only once', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.api.refused.addAll(['access-r1', 'access-r2']);
      h.api.calls.clear();

      await h.controller.refreshDevices();
      await pumpEventQueue();

      expect(h.api.calls, ['devices:access-r1', 'devices:access-r2']);
      expect(
        h.native.calls.where((call) => call.startsWith('force')),
        hasLength(1),
      );
      expect(h.controller.isSignedIn, isFalse);
    });

    for (final failure in <Object>[
      const NativeVpnException('secure_storage_write_failed'),
      const NativeVpnException('session_operation_cancelled'),
      const NativeVpnException('native_operation_failed'),
      const NativeVpnException('native_bridge_unavailable'),
      const SessionRenewalFailure(SessionRenewalError.invalid),
      StateError('unknown'),
    ]) {
      test(
        'only a refusal ends a renewable session: $failure keeps it',
        () async {
          final h = await _Harness.ready();
          addTearDown(h.close);
          await h.signIn();
          h.native.ensureFailure = failure;
          h.api.refused.add('access-r1');

          await h.controller.refreshDevices();
          await h.controller.onAppResumed();
          await pumpEventQueue();

          expect(h.native.calls, isNot(contains('clear')));
          expect(h.controller.isSignedIn, isTrue);
          expect(h.controller.token, 'access-r1');
          expect(h.controller.notice?.arguments['code'], 'network_unavailable');
        },
      );
    }

    test('a temporary renewal failure after a 401 keeps the session', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.api.refused.add('access-r1');
      h.native.ensureFailure = const SessionRenewalFailure(
        SessionRenewalError.unavailable,
      );

      await h.controller.refreshDevices();
      await pumpEventQueue();

      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.token, 'access-r1');
      expect(h.controller.notice?.arguments['code'], 'network_unavailable');
    });

    test('a temporary failure keeps a session whose access expired; the '
        'server, not the device clock, judges that access', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.accessLifetime = const Duration(minutes: -1);
      await h.signIn();
      h.native.ensureFailure = const SessionRenewalFailure(
        SessionRenewalError.unavailable,
      );
      h.api.refused.add('access-r1');
      h.api.calls.clear();

      await h.controller.refreshDevices();
      await h.controller.onAppResumed();

      expect(h.api.calls, ['devices:access-r1']);
      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.notice?.arguments['code'], 'network_unavailable');
    });

    testWidgets('a resume renewal that never answers keeps the session after '
        '25 s', (tester) async {
      final h = _Harness();
      addTearDown(h.close);
      final gate = Completer<void>();
      addTearDown(gate.complete);
      h.native
        ..renewable = true
        ..stored = _session('access-old', const Duration(days: 1));
      final starting = h.controller.initialize();
      await tester.pump();
      await starting;
      await tester.pump();
      expect(h.controller.isSignedIn, isTrue);
      h.native.ensureGate = gate;

      var resumed = false;
      unawaited(h.controller.onAppResumed().then((_) => resumed = true));
      await tester.pump(const Duration(seconds: 26));
      await tester.pump();

      expect(resumed, isTrue);
      expect(h.native.calls.last, 'ensure:user-1');
      expect(h.native.calls, isNot(contains('clear')));
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.token, 'access-old');
    });

    test('a renewal refused in the foreground ends the session as an '
        'expiry', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.native.ensureFailure = const SessionRenewalFailure(
        SessionRenewalError.unauthorized,
      );

      await h.controller.onAppResumed();
      await pumpEventQueue();

      expect(h.native.calls, containsAllInOrder(['ensure:user-1', 'clear']));
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.notice?.arguments['code'], 'unauthorized');
    });

    test('a renewal during a connection keeps that connection alive with the '
        'new access', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      final gate = Completer<void>();
      h.api.devicesGate = gate;
      h.api.calls.clear();

      final identity = h.controller.sessionIdentity;
      final connecting = h.controller.connect();
      await pumpEventQueue();
      expect(h.api.calls.last, 'devices:access-r1');
      h.native.rotate();
      await h.controller.onAppResumed();
      expect(h.controller.token, 'access-r2');
      expect(h.controller.sessionIdentity, same(identity));
      gate.complete();
      await connecting;

      expect(h.api.calls, contains(startsWith('register:access-r2')));
      expect(h.api.calls, isNot(contains(startsWith('register:access-r1'))));
      expect(h.tunnel.connected, ['device-1']);
      expect(h.controller.currentDeviceId, 'device-1');
      expect(h.controller.isConnecting, isFalse);
    });

    test(
      'a new session with an equal token is still another session',
      () async {
        final h = await _Harness.ready();
        addTearDown(h.close);
        await h.signIn(upgrade: false);
        final gate = Completer<void>();
        h.api.devicesGate = gate;
        final identity = h.controller.sessionIdentity;

        final connecting = h.controller.connect();
        await pumpEventQueue();
        await h.controller.signOut();
        expect(
          await h.controller.signIn(email: 'a@example.test', password: 'x'),
          isTrue,
        );
        expect(h.controller.token, 'access-login');
        expect(h.controller.sessionIdentity, isNot(same(identity)));
        gate.complete();
        await connecting;

        expect(h.api.calls, isNot(contains(startsWith('register:'))));
        expect(h.tunnel.connected, isEmpty);
        expect(h.controller.isSignedIn, isTrue);
      },
    );
  });

  group('interactive security flow', () {
    test('no rotation while a Google intent is pending and the access is '
        'still valid', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.accessLifetime = const Duration(minutes: 2);
      await h.signIn();
      h.google.setPending(true);
      h.api.calls.clear();

      await h.controller.refreshDevices();
      expect(
        h.native.calls.where((call) => call.startsWith('ensure')),
        isEmpty,
      );
      expect(h.api.calls, ['devices:access-r1']);

      h.google.setPending(false);
      await h.controller.refreshDevices();
      expect(h.native.calls.last, 'ensure:user-1');
      expect(h.api.calls.last, 'devices:access-r2');
    });

    test('an expired access is renewed even behind a pending intent', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.accessLifetime = const Duration(minutes: -1);
      await h.signIn();
      h.native.accessLifetime = const Duration(hours: 1);
      h.google.setPending(true);
      h.api.calls.clear();

      await h.controller.refreshDevices();

      expect(h.native.calls.last, 'ensure:user-1');
      expect(h.api.calls, ['devices:access-r2']);
    });

    test('the conversion waits for the pending intent to end', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.native.stored = _session('access-old', const Duration(days: 20));
      h.google.setPending(true);

      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.profile?.userId, 'user-1');
      expect(
        h.native.calls.where((call) => call.startsWith('upgrade')),
        isEmpty,
      );
      expect(h.controller.token, 'access-old');

      h.google.setPending(false);
      await pumpEventQueue();

      expect(h.native.calls, contains('upgrade:user-1'));
      expect(h.controller.token, 'access-r1');
    });
  });

  group('guests', () {
    test('a guest session is never converted, renewed or logged out by '
        'native code', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.api.guest = true;
      h.native.stored = _session('guest-token', const Duration(days: 1));

      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.profile?.isGuest, isTrue);
      await h.controller.onAppResumed();
      await h.controller.refreshDevices();
      await h.controller.signOut();
      await pumpEventQueue();

      expect(
        h.native.calls.where(
          (call) =>
              call.startsWith('upgrade') ||
              call.startsWith('ensure') ||
              call.startsWith('logout'),
        ),
        isEmpty,
      );
      expect(h.api.calls, contains('logout:guest-token'));
    });

    test('a guest 401 keeps its own path', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.api.guest = true;
      h.native.stored = _session('guest-token', const Duration(days: 1));
      await h.controller.initialize();
      h.api.refused.add('guest-token');
      h.api.calls.clear();

      await h.controller.refreshDevices();
      await pumpEventQueue();

      expect(h.api.calls, ['devices:guest-token']);
      expect(
        h.native.calls.where((call) => call.startsWith('ensure')),
        isEmpty,
      );
      expect(h.native.calls, contains('clear'));
    });
  });

  group('logout', () {
    test('a renewable session is logged out by native code before it is '
        'cleared', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();

      await h.controller.signOut();
      await pumpEventQueue();

      expect(h.native.calls, containsAllInOrder(['logout:user-1', 'clear']));
      expect(h.api.calls, isNot(contains(startsWith('logout:'))));
      expect(h.controller.isSignedIn, isFalse);
    });

    test('a classic session keeps the access-token logout', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn(upgrade: false);

      await h.controller.signOut();
      await pumpEventQueue();

      expect(h.native.calls, containsAllInOrder(['logout:user-1', 'clear']));
      expect(h.api.calls, contains('logout:access-login'));
    });

    test(
      'a failed native logout falls back to the access-token logout',
      () async {
        final h = await _Harness.ready();
        addTearDown(h.close);
        await h.signIn();
        h.native.logoutFailure = const NativeVpnException(
          'native_bridge_unavailable',
        );

        await h.controller.signOut();
        await pumpEventQueue();

        expect(h.native.calls, contains('clear'));
        expect(h.api.calls, contains('logout:access-r1'));
        expect(h.controller.sessionTermination, isNull);
      },
    );

    testWidgets('storage is never cleared before the native logout '
        'answered', (tester) async {
      final h = _Harness();
      addTearDown(h.close);
      h.native
        ..renewable = true
        ..stored = _session('access-old', const Duration(days: 1));
      final starting = h.controller.initialize();
      await tester.pump();
      await starting;
      await tester.pump();
      expect(h.controller.isSignedIn, isTrue);
      final gate = Completer<void>();
      h.native.logoutGate = gate;

      final ending = h.controller.signOut();
      await tester.pump(const Duration(seconds: 11));
      expect(h.native.calls, contains('logout:user-1'));
      expect(h.native.calls, isNot(contains('clear')));
      gate.complete();
      await tester.pump();
      await tester.pump();
      await ending;

      expect(h.native.calls, containsAllInOrder(['logout:user-1', 'clear']));
      expect(h.api.calls, isNot(contains(startsWith('logout:'))));
    });
  });

  group('billing and diagnostics', () {
    test('billing renews an access that expired while the app stayed '
        'open', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      h.native.accessLifetime = const Duration(minutes: -1);
      await h.signIn();
      h.native.accessLifetime = const Duration(hours: 1);
      h.billing.tokens.clear();

      await h.controller.billing.refreshSubscription();

      expect(h.native.calls.last, 'ensure:user-1');
      expect(h.billing.tokens, ['access-r2', 'access-r2']);
      expect(h.controller.token, 'access-r2');
    });

    test('a billing 401 forces one renewal and is sent again', () async {
      final h = await _Harness.ready();
      addTearDown(h.close);
      await h.signIn();
      h.billing
        ..tokens.clear()
        ..refused.add('access-r1');

      await h.controller.billing.refreshSubscription();

      expect(h.native.calls.last, 'force:user-1');
      expect(h.billing.tokens, ['access-r1', 'access-r2', 'access-r2']);
      expect(h.controller.isSignedIn, isTrue);
    });

    test('a guest billing request is sent as it is', () async {
      final h = _Harness();
      addTearDown(h.close);
      h.api.guest = true;
      h.native.stored = _session('guest-token', const Duration(days: 1));
      await h.controller.initialize();
      h.billing.tokens.clear();

      await h.controller.billing.refreshSubscription();

      expect(h.billing.tokens, ['guest-token', 'guest-token']);
      expect(h.native.calls, isNot(contains(startsWith('ensure'))));
    });

    test('a manual diagnostic is sent with a renewed access after an hour in '
        'the foreground', () async {
      final transport = _ReceiptTransport();
      final h = await _Harness.ready(diagnosticsTransport: transport);
      addTearDown(h.close);
      h.diagnostics.setMetadata({'app_version': '1.2.3'});
      h.native.accessLifetime = const Duration(minutes: -1);
      await h.signIn();
      h.native.accessLifetime = const Duration(hours: 1);

      await h.controller.runDiagnostics(sendReport: true);
      await pumpEventQueue();

      expect(transport.authorizations, ['Bearer access-r2']);
      expect(h.controller.diagnosticStatus, DiagnosticSendStatus.sent);
      expect(h.controller.isSignedIn, isTrue);
    });

    test('an automatic diagnostic is not dropped after an hour in the '
        'foreground', () async {
      final transport = _ReceiptTransport();
      final h = await _Harness.ready(diagnosticsTransport: transport);
      addTearDown(h.close);
      h.diagnostics.setMetadata({'app_version': '1.2.3'});
      h.native.accessLifetime = const Duration(minutes: -1);
      await h.signIn();
      h.native.accessLifetime = const Duration(hours: 1);
      h.diagnostics.setAutomaticConsent(true);

      h.tunnel.events.add(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          protocol: VpnProtocol.openVpn,
          messageCode: 'certificate_validation_failed',
        ),
      );
      await pumpEventQueue();

      expect(transport.authorizations, ['Bearer access-r2']);
    });
  });
}

const _registration = RegisterAccountRequest(
  email: 'a@example.test',
  password: 'synthetic-password',
  firstName: 'A',
  lastName: 'B',
  phone: '+33100000000',
  addressLine1: '1 rue',
  postalCode: '75001',
  city: 'Paris',
  countryCode: 'FR',
  termsAccepted: true,
  privacyAccepted: true,
);

const _location = Location(
  id: 'fr-par',
  city: 'Paris',
  countryCode: 'FR',
  displayName: 'Paris',
  supportedProtocols: {VpnProtocol.wireGuard},
);

AuthSession _session(String token, Duration validFor) => AuthSession(
  accessToken: token,
  expiresAt: DateTime.now().toUtc().add(validFor),
);

class _Harness {
  _Harness({ApiHttpTransport? diagnosticsTransport})
    : diagnostics = _Diagnostics(diagnosticsTransport) {
    controller = VpnAppController(
      api: api,
      sessionStore: native,
      preferences: _Preferences(),
      tunnel: tunnel,
      diagnostics: diagnostics,
      billingApi: billing,
      googleAuthOverride: google,
    );
  }

  static Future<_Harness> ready({
    ApiHttpTransport? diagnosticsTransport,
  }) async {
    final h = _Harness(diagnosticsTransport: diagnosticsTransport);
    await h.controller.initialize();
    return h;
  }

  final api = _Api();
  final native = _Native();
  final tunnel = _Tunnel();
  final _Diagnostics diagnostics;
  final billing = _BillingApi();
  final google = _Google();
  late final VpnAppController controller;

  /// Signs in; [upgrade] false keeps the session classic (a server that does
  /// not know the contract yet answers 404 to the conversion).
  Future<void> signIn({bool upgrade = true}) async {
    native.serverKnowsContract = upgrade;
    expect(
      await controller.signIn(email: 'a@example.test', password: 'x'),
      isTrue,
    );
    await pumpEventQueue();
  }

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _Native extends Fake implements SecureSessionStore, SessionRenewalStore {
  AuthSession? stored;
  String? deviceId;
  bool renewable = false;
  bool serverKnowsContract = true;
  bool loseUpgradeAnswer = false;
  Duration accessLifetime = const Duration(hours: 1);
  Object? ensureFailure;
  Object? upgradeFailure;
  Object? logoutFailure;
  // A forced renewal that answers with the stored access unchanged.
  bool forceKeepsAccess = false;
  Completer<void>? ensureGate;
  Completer<void>? logoutGate;
  final List<String> calls = <String>[];
  int _rotations = 0;

  /// A renewal by native code alone (the tile, a background reconnection).
  AuthSession rotate() =>
      stored = _session('access-r${++_rotations}', accessLifetime);

  @override
  Future<AuthSession?> readSession() async => stored;

  @override
  Future<void> writeSession(AuthSession session, {String? userId}) async {
    calls.add('write:${session.accessToken}:$userId');
    stored = session;
  }

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    calls.add('clear');
    stored = null;
    renewable = false;
    return const SessionTerminationResult.complete();
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async =>
      deviceId;

  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async => this.deviceId = deviceId;

  @override
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  }) async => null;

  @override
  Future<SessionRenewal> upgradeSession({required String userId}) async {
    calls.add('upgrade:$userId');
    if (upgradeFailure != null) throw upgradeFailure!;
    if (!renewable && serverKnowsContract) {
      renewable = true;
      rotate();
      if (loseUpgradeAnswer) {
        loseUpgradeAnswer = false;
        throw const SessionRenewalFailure(SessionRenewalError.unavailable);
      }
    }
    return SessionRenewal(renewable: renewable, session: stored!);
  }

  @override
  Future<SessionRenewal> ensureFreshSession({
    String? userId,
    bool force = false,
  }) async {
    calls.add('${force ? 'force' : 'ensure'}:$userId');
    await ensureGate?.future;
    if (ensureFailure != null) throw ensureFailure!;
    if (renewable &&
        ((force && !forceKeepsAccess) ||
            !stored!.expiresAt.isAfter(
              DateTime.now().add(const Duration(minutes: 5)),
            ))) {
      rotate();
    }
    return SessionRenewal(renewable: renewable, session: stored!);
  }

  @override
  Future<bool> logoutSession({String? userId}) async {
    calls.add('logout:$userId');
    await logoutGate?.future;
    if (logoutFailure != null) throw logoutFailure!;
    return renewable;
  }
}

class _Api extends Fake implements VpnApiRepository {
  final List<String> calls = <String>[];
  final Set<String> refused = <String>{};
  bool guest = false;
  Completer<void>? devicesGate;

  void _send(String name, String token) {
    calls.add('$name:$token');
    _authorize(token);
  }

  void _authorize(String token) {
    if (refused.contains(token)) {
      throw const ApiException(statusCode: 401, errorCode: 'unauthorized');
    }
  }

  AuthSession _login() => _session('access-login', const Duration(days: 30));

  @override
  Future<List<Location>> locations() async => const [_location];

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async => _login();

  @override
  Future<RegistrationResult> register(RegisterAccountRequest request) async {
    final session = _login();
    return RegistrationResult(
      accessToken: session.accessToken,
      expiresAt: session.expiresAt,
      verificationEmailSent: true,
    );
  }

  @override
  Future<UserProfile> me(String token) async {
    _send('me', token);
    return UserProfile(
      userId: 'user-1',
      identityKind: guest ? 'guest' : 'registered',
    );
  }

  @override
  Future<DeviceList> listDevices(String token) async {
    calls.add('devices:$token');
    final gate = devicesGate;
    devicesGate = null;
    await gate?.future;
    _authorize(token);
    return const DeviceList(limit: 2, devices: []);
  }

  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    _send('register', token);
    return const DeviceConfiguration(
      deviceId: 'device-1',
      address: '10.10.0.2/32',
      dns: <String>['1.1.1.1'],
      serverPublicKey: 'server-public-key',
      endpoint: '198.51.100.10:51820',
      allowedIps: <String>['0.0.0.0/0'],
    );
  }

  @override
  Future<void> logout(String token) async => calls.add('logout:$token');
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
  Future<void> writeSelectedLocation(String value) async {}
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
  final List<String> connected = <String>[];

  Future<void> close() => events.close();

  @override
  Stream<VpnRuntimeState> get states => events.stream;

  @override
  Future<VpnRuntimeState> getState() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);

  @override
  Future<void> disconnect() async {}

  @override
  Future<bool> requestVpnPermission() async => true;

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async => 'public-key';

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async => connected.add(configuration.deviceId);

  @override
  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  }) async => null;
}

class _Diagnostics extends DiagnosticService {
  _Diagnostics([ApiHttpTransport? transport])
    : super(
        transport: transport ?? _NoTransport(),
        baseUri: Uri.parse('https://synthetic.invalid'),
        scheduleRetries: false,
      );

  final List<String?> tokens = <String?>[];

  @override
  void setSession({String? accountId, String? token, DateTime? expiresAt}) {
    tokens.add(token);
    super.setSession(accountId: accountId, token: token, expiresAt: expiresAt);
  }
}

class _NoTransport extends ApiHttpTransport {
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async =>
      throw StateError('No diagnostic is sent');
}

/// Accepts every report and keeps the access it was sent with.
class _ReceiptTransport extends ApiHttpTransport {
  final List<String?> authorizations = <String?>[];

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    authorizations.add(request.headers['Authorization']);
    final body = jsonDecode(request.body!) as Map<String, dynamic>;
    return ApiHttpResponse(
      statusCode: 201,
      headers: const {},
      body: jsonEncode({
        'status': 'received',
        'duplicate': false,
        'report_id': 'a1000000-0000-4000-8000-000000000099',
        'client_report_id': body['report_id'],
        'received_at': '2026-09-23T00:00:00Z',
        'expires_at': '2026-10-23T00:00:00Z',
      }),
    );
  }
}

class _BillingApi extends Fake implements BillingApiRepository {
  final List<String> tokens = <String>[];
  final Set<String> refused = <String>{};

  void _authorize(String token) {
    tokens.add(token);
    if (refused.contains(token)) {
      throw const ApiException(statusCode: 401, errorCode: 'unauthorized');
    }
  }

  @override
  Future<BillingSubscription> getSubscription(String token) async {
    _authorize(token);
    return const BillingSubscription(status: 'inactive', hasAccess: false);
  }

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async {
    _authorize(token);
    return const BillingPurchaseContext(
      obfuscatedAccountId: 'billing-account-1',
      purchaseAllowed: true,
    );
  }
}

/// A Google intent the test opens and closes (with its Turnstile challenge).
class _Google extends GoogleAuthController {
  _Google() : super(challengeGateway: _NoChallenge());

  bool _pending = false;

  @override
  bool get hasPendingIntent => _pending;

  void setPending(bool value) {
    _pending = value;
    notifyListeners();
  }
}

class _NoChallenge extends Fake implements SecurityChallengeGateway {}
