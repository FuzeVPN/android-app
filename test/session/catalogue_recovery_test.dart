// VM campaign of 2026-10-31, lot C:
//  * OFFLINE-RESTORE-CATALOGUE-01 (D2): a public catalogue missing after a
//    deferred account restoration is loaded again by the restoration, a
//    resume or a stopped tunnel, quietly: the shared notice slot is kept;
//  * D1 phase 1a: the startup catalogue no longer waits ahead of /me, and is
//    still published on every startup path.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart'
    show ApiHttpRequest, ApiHttpResponse, ApiHttpTransport;
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

import 'support/session_harness.dart';

const _startFailed = VpnRuntimeState(
  phase: VpnRuntimePhase.error,
  protocol: VpnProtocol.wireGuard,
  messageCode: 'wireguard_start_failed',
);

/// Registered account B, stored and active, that saved Paris. The startup
/// catalogue fails, like /me when [meFails], as in the offline reopen.
SessionHarness _offlineRegistered({
  VpnRuntimeState? tunnel,
  bool meFails = true,
  DiagnosticService? diagnostics,
}) {
  final h = SessionHarness(diagnostics: diagnostics);
  h.store.activeUser = accountB.userId;
  h.store.accountSessions[accountB.userId] = session('token-b');
  h.tunnel.state = tunnel ?? connectedAt(paris);
  h.preferences.location = paris.id;
  h.api.locationsFailure = const ApiNetworkException();
  if (meFails) {
    h.api.meScript['token-b'] = <Object>[const ApiNetworkException()];
  }
  return h;
}

bool _isNative(SessionHarness h) =>
    h.controller.notice?.titleKey == 'notice.native.title';

class _SilentTransport extends ApiHttpTransport {
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) =>
      Completer<ApiHttpResponse>().future;
}

/// Its pending reports never finish, or fail, when the app is resumed.
class _ResumeDiagnostics extends DiagnosticService {
  _ResumeDiagnostics(this._retry)
    : super(
        transport: _SilentTransport(),
        baseUri: Uri.parse('https://api.example.test/'),
        scheduleRetries: false,
      );
  final Future<void> Function() _retry;
  @override
  Future<void> retryPending() => _retry();
}

void main() {
  group('OFFLINE-RESTORE-CATALOGUE-01 the catalogue missing after a deferred '
      'restoration', () {
    test('Retry with the tunnel still connected publishes the saved location, '
        'kept once the tunnel stops', () async {
      final h = _offlineRegistered();
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.locations, isEmpty);
      h.api.locationsFailure = null;
      await h.controller.retryAccountRestoration();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.isConnected, isTrue);
      // The protocol choices read this selection even while connected.
      expect(h.controller.selectedLocation?.id, paris.id);
      expect(
        h.controller.selectedLocation!.supports(VpnProtocol.wireGuard),
        isTrue,
      );
      await h.controller.requestUserDisconnect();
      await pumpEventQueue();
      expect(h.controller.isTunnelActive, isFalse);
      expect(h.controller.selectedLocation?.id, paris.id);
      expect(h.api.locationCalls, 2);
    });

    test('a reload that fails while the tunnel is active is made again when '
        'the tunnel stops', () async {
      final h = _offlineRegistered();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.retryAccountRestoration();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.locations, isEmpty);
      // The background failure leaves the notice slot alone.
      expect(h.controller.notice, isNull, reason: observe(h));
      h.api.locationsFailure = null;
      await h.controller.requestUserDisconnect();
      await pumpEventQueue();
      expect(h.controller.isTunnelActive, isFalse);
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
    });

    test('an unexpected error of the background reload is contained, and the '
        'next resume loads the catalogue', () async {
      final h = _offlineRegistered();
      addTearDown(h.close);
      await h.controller.initialize();
      h.api.locationsFailure = StateError('fixture catalogue parser');
      await h.controller.retryAccountRestoration();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.api.locationCalls, 2);
      expect(h.controller.locations, isEmpty);
      expect(h.controller.isLoadingLocations, isFalse);
      h.api.locationsFailure = null;
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
    });

    test('a background reload failure never replaces a native error notice',
        () async {
      final h = _offlineRegistered(tunnel: _startFailed);
      addTearDown(h.close);
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      final answer = Completer<void>();
      h.api.onLocations = () => answer.future;
      await h.controller.retryAccountRestoration();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.api.locationCalls, 2);
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(_isNative(h), isTrue, reason: observe(h));
      answer.complete();
      await pumpEventQueue();
      expect(h.controller.locations, isEmpty);
      expect(_isNative(h), isTrue, reason: observe(h));
    });

    test('after an offline start on the welcome page, a sign-in loads the '
        'catalogue once', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.preferences.location = paris.id;
      h.api.locationsFailure = const ApiNetworkException();
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.locations, isEmpty);
      h.api.locationsFailure = null;
      expect(
        await h.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isTrue,
        reason: observe(h),
      );
      await pumpEventQueue();
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
      expect(h.api.locationCalls, 2);
    });

    test('after an offline start, a later guest admission loads the catalogue '
        'once', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      h.preferences.location = paris.id;
      h.api.locationsFailure = const ApiNetworkException();
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.controller.isSignedIn, isFalse, reason: observe(h));
      expect(h.controller.locations, isEmpty);
      h.api.locationsFailure = null;
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
      expect(h.api.locationCalls, 2);
    });

    test('after a startup stopped on an unconfirmed session end, a sign-in '
        'loads the catalogue with the saved location', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.preferences.location = paris.id;
      h.tunnel.state = const VpnRuntimeState(
        phase: VpnRuntimePhase.error,
        messageCode: 'session_termination_unconfirmed',
        sessionTermination: SessionTerminationResult(
          tunnelStopped: false,
          sessionCleared: false,
          stopError: 'session_termination_unconfirmed',
        ),
      );
      await h.controller.initialize();
      expect(h.controller.sessionTermination, isNotNull);
      expect(h.api.locationCalls, 0);
      await h.controller.retrySessionTermination();
      await pumpEventQueue();
      expect(h.controller.sessionTermination, isNull, reason: observe(h));
      expect(
        await h.controller.signIn(
          email: 'b@example.test',
          password: 'fixture-password',
        ),
        isTrue,
        reason: observe(h),
      );
      await pumpEventQueue();
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
      expect(h.api.locationCalls, 1);
    });

    for (final stalled in [true, false]) {
      test('a resume loads the catalogue ahead of a diagnostics retry that '
          '${stalled ? 'never ends' : 'fails'}', () async {
        final never = Completer<void>();
        final h = _offlineRegistered(
          meFails: false,
          diagnostics: _ResumeDiagnostics(
            () => stalled
                ? never.future
                : Future<void>.error(StateError('fixture diagnostics')),
          ),
        );
        addTearDown(h.close);
        await h.controller.initialize();
        await pumpEventQueue();
        expect(h.controller.isSignedIn, isTrue, reason: observe(h));
        expect(h.controller.locations, isEmpty);
        h.api.locationsFailure = null;
        final resumed = h.controller.onAppResumed();
        if (stalled) {
          unawaited(resumed);
        } else {
          await expectLater(resumed, throwsStateError);
        }
        await pumpEventQueue();
        expect(h.controller.locations, isNotEmpty, reason: observe(h));
        expect(h.controller.selectedLocation?.id, paris.id);
      });
    }

    test('an empty server answer is not a loaded catalogue: the next resume '
        'asks again', () async {
      final h = _offlineRegistered(meFails: false);
      addTearDown(h.close);
      h.api.locationsFailure = null;
      h.api.catalogue = const <Location>[];
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.locations, isEmpty);
      h.api.catalogue = const <Location>[frankfurt, paris];
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
    });

    test('Retry after an unreadable stored session loads a missing catalogue',
        () async {
      final h = _offlineRegistered(meFails: false);
      addTearDown(h.close);
      h.store.readFailure = const NativeVpnException(
        'secure_storage_read_failed',
      );
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.locations, isEmpty);
      // The restoration notice wins over the catalogue failure.
      expect(_isNative(h), isTrue, reason: observe(h));
      h.api.locationsFailure = null;
      await h.controller.retryAccountRestoration();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.locations, isNotEmpty);
      expect(h.controller.selectedLocation?.id, paris.id);
    });

    test('Retry of a deferred guest recovery loads a missing catalogue',
        () async {
      final h = SessionHarness.guest(
        session('guest-token', pastExpiry),
        tunnel: connectedAt(paris),
      );
      addTearDown(h.close);
      h.preferences.location = paris.id;
      h.api.locationsFailure = const ApiNetworkException();
      h.api.createFailures.add(const ApiNetworkException());
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.locations, isEmpty);
      h.api.locationsFailure = null;
      await h.controller.retryAccountRestoration();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.locations, isNotEmpty);
      expect(h.controller.selectedLocation?.id, paris.id);
    });

    test('a catalogue loaded at startup is not requested again by a resume or '
        'a stopped tunnel', () async {
      final h = _offlineRegistered(meFails: false);
      addTearDown(h.close);
      h.api.locationsFailure = null;
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.selectedLocation?.id, paris.id);
      await h.controller.onAppResumed();
      await h.controller.requestUserDisconnect();
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.isTunnelActive, isFalse);
      expect(h.api.locationCalls, 1);

      final guest = SessionHarness.guest(session('guest-token'));
      addTearDown(guest.close);
      await guest.controller.initialize();
      await guest.controller.onAppResumed();
      await pumpEventQueue();
      expect(guest.controller.isSignedIn, isTrue, reason: observe(guest));
      expect(guest.api.locationCalls, 1);
    });
  });

  group('D1 phase 1a the startup catalogue beside the restoration', () {
    test('an expired registered session ended during startup keeps the public '
        'catalogue that answers after the end', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.pending = session('token-b', pastExpiry);
      final answer = Completer<void>();
      h.api.onLocations = () => answer.future;
      final starting = h.controller.initialize();
      await pumpEventQueue();
      answer.complete();
      await starting;
      await pumpEventQueue();
      expect(h.store.clears, [true], reason: observe(h));
      expect(h.controller.token, isNull);
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(h.controller.selectedLocation?.id, frankfurt.id);
    });

    test('when the catalogue and the account both fail, the restoration '
        'notice wins', () async {
      final h = _offlineRegistered();
      addTearDown(h.close);
      h.api.locationsFailure = const ApiException(
        statusCode: 503,
        errorCode: 'target_unavailable',
      );
      await h.controller.initialize();
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(
        h.controller.notice?.arguments['code'],
        'network_unavailable',
        reason: observe(h),
      );
    });
  });

  group('D1 phase 1a review: the late startup catalogue on screen', () {
    test('a startup catalogue answering after a guest admitted meanwhile '
        'repaints that home', () async {
      final h = SessionHarness();
      addTearDown(h.close);
      h.store.credential = guestCredential;
      h.store.autoResume = true;
      // An orphan tunnel ended at startup: the welcome page is shown while
      // the catalogue is still pending.
      h.tunnel.state = connectedAt(paris);
      h.preferences.location = paris.id;
      h.api.createFailures.add(const ApiNetworkException());
      final answer = Completer<void>();
      h.api.onLocations = () => answer.future;
      final starting = h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.isInitializing, isFalse, reason: observe(h));
      expect(h.controller.isSignedIn, isFalse, reason: observe(h));
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.controller.locations, isEmpty);
      final painted = <String?>[];
      h.controller.addListener(
        () => painted.add(
          h.controller.isLoadingLocations
              ? 'loading'
              : h.controller.selectedLocation?.id,
        ),
      );
      answer.complete();
      await starting;
      await pumpEventQueue();
      expect(h.controller.selectedLocation?.id, paris.id, reason: observe(h));
      expect(h.controller.isLoadingLocations, isFalse);
      expect(painted, isNotEmpty);
      expect(painted.last, paris.id);
      expect(h.api.locationCalls, 1);
    });

    test('a startup network notice is cleared once the reload after the '
        'restoration loads the catalogue', () async {
      final h = _offlineRegistered(meFails: false);
      addTearDown(h.close);
      h.api.onLocations = () async {
        if (h.api.locationCalls == 2) h.api.locationsFailure = null;
      };
      final painted = <Object?>[];
      h.controller.addListener(
        () => painted.add(h.controller.notice?.arguments['code']),
      );
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.api.locationCalls, 2);
      expect(h.controller.locations, isNotEmpty);
      expect(h.controller.selectedLocation?.id, paris.id);
      expect(h.controller.notice, isNull, reason: observe(h));
      expect(painted.last, isNull);
    });

    for (final empty in [false, true]) {
      test('a reload after the restoration that '
          '${empty ? 'comes back empty' : 'fails'} keeps the startup network '
          'notice', () async {
        final h = _offlineRegistered(meFails: false);
        addTearDown(h.close);
        h.api.onLocations = () async {
          if (h.api.locationCalls == 2 && empty) {
            h.api.locationsFailure = null;
            h.api.catalogue = const <Location>[];
          }
        };
        await h.controller.initialize();
        await pumpEventQueue();
        expect(h.controller.isSignedIn, isTrue, reason: observe(h));
        expect(h.api.locationCalls, 2);
        expect(h.controller.locations, isEmpty);
        expect(h.controller.notice?.titleKey, 'notice.api.title');
        expect(
          h.controller.notice?.arguments['code'],
          'network_unavailable',
          reason: observe(h),
        );
      });
    }

    test('a reload after the restoration never clears a notice that replaced '
        'the startup one, even with the same text', () async {
      final h = _offlineRegistered(meFails: false);
      addTearDown(h.close);
      final answer = Completer<void>();
      h.api.onLocations = () async {
        if (h.api.locationCalls != 2) return;
        await answer.future;
        h.api.locationsFailure = null;
      };
      await h.controller.initialize();
      await pumpEventQueue();
      expect(h.controller.isSignedIn, isTrue, reason: observe(h));
      expect(h.api.locationCalls, 2);
      final startup = h.controller.notice;
      expect(startup?.arguments['code'], 'network_unavailable');
      h.api.onDevices = (_) async => throw const ApiNetworkException();
      await h.controller.refreshDevices();
      final devices = h.controller.notice;
      expect(identical(devices, startup), isFalse);
      expect(devices?.arguments['code'], 'network_unavailable');
      answer.complete();
      await pumpEventQueue();
      expect(h.controller.locations, isNotEmpty, reason: observe(h));
      expect(
        identical(h.controller.notice, devices),
        isTrue,
        reason: observe(h),
      );
    });
  });
}
