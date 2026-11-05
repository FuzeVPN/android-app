part of '../app_controller_test.dart';

void googleControllerTests() {
  _googleCorrections20261029();
  group('Google account admission preserves Fuze identity and VPN ownership', () {
    for (final protocol in VpnProtocol.values) {
      test(
        'claim retry correction 2026-10-28 reconciles real admission after429 on ${protocol.name}',
        () async {
          final h = await _googleHarness(protocol: protocol);
          addTearDown(h.close);
          final originalSession = h.store.storedSession;
          final originalWrites = h.store.sessionWriteUsers.length;
          await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
          h.api.claimAction = () async {
            h.api.profilesByToken['guest-google-token'] =
                _googleRegisteredProfile('guest-google-user');
            throw const ApiException(
              statusCode: 429,
              errorCode: 'rate_limited',
              retryAfterSeconds: 120,
            );
          };
          await h.controller.googleAuth.completeProfile(
            countryCode: 'BE',
            termsAccepted: true,
            privacyAccepted: true,
          );
          expect(
            h.controller.googleAuth.state.step,
            GoogleAuthStep.authenticated,
          );
          expect(h.controller.googleAuth.state.retryAfter, isNull);
          expect(h.controller.profile?.userId, 'guest-google-user');
          expect(h.controller.profile?.authMethods, ['google']);
          expect(h.controller.token, 'guest-google-token');
          expect(h.store.storedSession, same(originalSession));
          expect(h.store.sessionWriteUsers, hasLength(originalWrites));
          expect(h.controller.currentDeviceId, 'guest-google-device');
          expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
          expect(h.controller.tunnelState.protocol, protocol);
          expect(h.tunnel.disconnectCalls, 0);
          expect(h.tunnel.clearedAccountIds, isEmpty);
          expect(h.store.guestClearCalls, 1);
          expect(h.gateway.pending, isNull);
          expect(h.api.claimCalls, 1);
          expect(h.api.meTokens.toSet(), {'guest-google-token'});
        },
      );
    }

    for (final readFailure in <ApiFailure>[
      const ApiNetworkException(code: 'network_timeout'),
      const ApiException(statusCode: 401, errorCode: 'unauthorized'),
    ]) {
      test(
        'claim retry correction 2026-10-28 preserves429 through real /me ${readFailure.code}',
        () async {
          final h = await _googleHarness();
          addTearDown(h.close);
          await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
          h.api.claimAction = () async => throw const ApiException(
            statusCode: 429,
            errorCode: 'rate_limited',
            retryAfterSeconds: 120,
          );
          h.api.meAction = (_) async => throw readFailure;
          final earliestDeadline = DateTime.now().add(
            const Duration(seconds: 120),
          );
          await h.controller.googleAuth.completeProfile(
            countryCode: 'BE',
            termsAccepted: true,
            privacyAccepted: true,
          );
          final latestDeadline = DateTime.now().add(
            const Duration(seconds: 120),
          );
          final deadline = h.controller.googleAuth.state.retryAfter;
          expect(deadline, isNotNull);
          expect(deadline!.isBefore(earliestDeadline), isFalse);
          expect(deadline.isAfter(latestDeadline), isFalse);
          expect(h.controller.googleAuth.state.step, GoogleAuthStep.uncertain);
          expect(h.controller.googleAuth.state.messageKey, 'google.uncertain');
          h.api.meAction = null;
          await h.controller.googleAuth.resume();
          await h.controller.googleAuth.completeProfile(
            countryCode: 'BE',
            termsAccepted: true,
            privacyAccepted: true,
          );
          expect(h.api.claimCalls, 1);
          expect(h.controller.googleAuth.state.retryAfter, deadline);
          expect(h.controller.token, 'guest-google-token');
          expect(h.controller.currentDeviceId, 'guest-google-device');
          expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
          expect(h.tunnel.disconnectCalls, 0);
          expect(h.store.guestClearCalls, 0);
        },
      );
    }

    for (final protocol in VpnProtocol.values) {
      test(
        'guest Google claim preserves bearer, device and live ${protocol.name}',
        () async {
          final h = await _googleHarness(protocol: protocol);
          addTearDown(h.close);
          final originalSession = h.store.storedSession;
          final originalWrites = h.store.sessionWriteUsers.length;
          final originalKey = h.tunnel.wireGuardPublicKey;
          final originalCsr = h.tunnel.openVpnCsr;

          await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
          expect(
            h.controller.googleAuth.state.step,
            GoogleAuthStep.guestClaimRequired,
          );
          expect(h.api.browserTokens.single, 'guest-google-token');
          expect(h.api.challengeTokens.single, 'guest-google-token');
          expect(h.gateway.pending, isNotNull);
          expect(
            h.gateway.writes.every(
              (value) => !value.contains('native-jwt-fixture'),
            ),
            isTrue,
          );

          await h.controller.googleAuth.completeProfile(
            countryCode: 'BE',
            termsAccepted: true,
            privacyAccepted: true,
          );

          expect(
            h.controller.googleAuth.state.step,
            GoogleAuthStep.authenticated,
          );
          expect(h.controller.profile?.userId, 'guest-google-user');
          expect(h.controller.profile?.isGuest, isFalse);
          expect(h.controller.profile?.authMethods, ['google']);
          expect(h.controller.profile?.hasPassword, isFalse);
          expect(h.controller.token, 'guest-google-token');
          expect(h.store.storedSession, same(originalSession));
          expect(h.store.sessionWriteUsers, hasLength(originalWrites));
          expect(h.controller.currentDeviceId, 'guest-google-device');
          expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
          expect(h.controller.tunnelState.protocol, protocol);
          expect(h.tunnel.disconnectCalls, 0);
          expect(h.tunnel.clearedAccountIds, isEmpty);
          expect(h.tunnel.wireGuardPublicKey, originalKey);
          expect(h.tunnel.openVpnCsr, originalCsr);
          expect(h.api.registerDeviceCalls, isEmpty);
          expect(h.store.guestClearCalls, 1);
          expect(h.gateway.pending, isNull);
          expect(h.api.meTokens.toSet(), {'guest-google-token'});
        },
      );
    }

    test(
      'a lost claim response is reconciled with the unchanged initiating bearer',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
        h.api.claimAction = () async {
          h.api.profilesByToken['guest-google-token'] =
              _googleRegisteredProfile('guest-google-user');
          throw const ApiNetworkException(code: 'network_timeout');
        };

        await h.controller.googleAuth.completeProfile(
          countryCode: 'BE',
          termsAccepted: true,
          privacyAccepted: true,
        );
        expect(
          h.controller.googleAuth.state.step,
          GoogleAuthStep.authenticated,
        );
        expect(h.controller.token, 'guest-google-token');
        expect(h.controller.currentDeviceId, 'guest-google-device');
        expect(h.controller.profile?.authMethods, ['google']);
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.store.clearSessionCalls, 0);
        expect(h.api.claimCalls, 1);
        expect(h.gateway.pending, isNull);
      },
    );

    test(
      'a redacted result cannot turn a restored session into a full Google account',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
        h.api.claimAction = () async {
          h.api.profilesByToken['guest-google-token'] = const UserProfile(
            userId: 'guest-google-user',
            identityKind: 'registered',
            profileRedacted: true,
            canManageAccount: false,
            canClaimAccount: false,
            canUseVpn: true,
          );
          return _googleClaimResult;
        };
        await h.controller.googleAuth.completeProfile(
          countryCode: 'BE',
          termsAccepted: true,
          privacyAccepted: true,
        );
        expect(h.controller.googleAuth.state.step, GoogleAuthStep.uncertain);
        expect(h.controller.profile?.isGuest, isTrue);
        expect(h.controller.token, 'guest-google-token');
        expect(h.store.guestClearCalls, 0);
        expect(h.gateway.pending, isNotNull);
        expect(h.tunnel.disconnectCalls, 0);
      },
    );

    test(
      'Turnstile rejection blocks the native journey and preserves the guest',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
        final pending = h.gateway.pending;
        h.api.claimAction = () async => throw const ApiException(
          statusCode: 403,
          errorCode: 'turnstile_required',
        );
        await h.controller.googleAuth.completeProfile(
          countryCode: 'BE',
          termsAccepted: true,
          privacyAccepted: true,
        );
        expect(h.controller.googleAuth.state.step, GoogleAuthStep.uncertain);
        expect(
          h.controller.googleAuth.state.messageKey,
          'google.challengeRequired',
        );
        expect(
          h.controller.googleAuth.state.block,
          GoogleAuthBlock.securityChallenge,
        );
        expect(h.controller.token, 'guest-google-token');
        expect(h.controller.profile?.isGuest, isTrue);
        expect(h.gateway.pending, pending);
        expect(h.api.claimCalls, 1);
        expect(h.store.guestClearCalls, 0);
        expect(h.tunnel.disconnectCalls, 0);
      },
    );

    for (final candidate in <UserProfile>[
      const UserProfile(userId: 'candidate-google', identityKind: 'guest'),
      const UserProfile(
        userId: 'candidate-google',
        profileRedacted: true,
        canManageAccount: false,
        authMethods: ['google'],
        hasPassword: false,
      ),
      const UserProfile(
        userId: 'candidate-google',
        email: 'candidate@example.test',
        authMethods: ['password'],
        hasPassword: true,
      ),
    ]) {
      test(
        'unproven Google candidate preserves the subscribed guest (${candidate.identityKind}/${candidate.profileRedacted}/${candidate.authMethods})',
        () async {
          final h = await _googleHarness();
          addTearDown(h.close);
          h.api.profilesByToken['candidate-google-token'] = candidate;
          h.api.verification = GoogleAuthenticatedResult(
            session: _session('candidate-google-token'),
          );
          final writes = h.store.sessionWriteUsers.length;
          await h.controller.googleAuth.begin(GoogleAuthPurpose.authenticate);
          expect(h.controller.googleAuth.state.step, GoogleAuthStep.uncertain);
          expect(h.controller.profile?.isGuest, isTrue);
          expect(h.controller.profile?.userId, 'guest-google-user');
          expect(h.controller.token, 'guest-google-token');
          expect(h.controller.currentDeviceId, 'guest-google-device');
          expect(h.store.autoResume, isTrue);
          expect(h.store.sessionWriteUsers, hasLength(writes));
          expect(h.store.clearSessionCalls, 0);
          expect(h.tunnel.disconnectCalls, 0);
          expect(h.api.logoutTokens, isEmpty);
        },
      );
    }

    test(
      'a proven separate Google account is admitted without transferring guest devices',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        h.api.profilesByToken['candidate-google-token'] =
            _googleRegisteredProfile('candidate-google-user');
        h.api.verification = GoogleAuthenticatedResult(
          session: _session('candidate-google-token'),
        );
        await h.controller.googleAuth.begin(GoogleAuthPurpose.authenticate);
        expect(
          h.controller.googleAuth.state.step,
          GoogleAuthStep.authenticated,
        );
        expect(h.controller.token, 'candidate-google-token');
        expect(h.controller.profile?.userId, 'candidate-google-user');
        expect(h.controller.currentDeviceId, isNull);
        expect(h.store.deviceIds['guest-google-user'], 'guest-google-device');
        expect(h.store.deviceIds.containsKey('candidate-google-user'), isFalse);
        expect(h.store.clearSessionCalls, 1);
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.store.autoResume, isFalse);
        expect(h.tunnel.clearedAccountIds, isEmpty);
        expect(h.api.registerDeviceCalls, isEmpty);
        expect(h.api.logoutTokens, ['guest-google-token']);
      },
    );

    test(
      'a lost verify response retains the original guest and encrypted cancellation ticket',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        h.api.verifyAction = () async => throw const ApiNetworkException();
        await h.controller.googleAuth.begin(GoogleAuthPurpose.authenticate);
        expect(h.controller.googleAuth.state.step, GoogleAuthStep.uncertain);
        expect(h.controller.profile?.isGuest, isTrue);
        expect(h.controller.token, 'guest-google-token');
        expect(h.gateway.pending, isNotNull);
        expect(h.gateway.pending, isNot(contains('native-jwt-fixture')));
        expect(h.store.clearSessionCalls, 0);
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.api.browserTokens, hasLength(1));
        await h.controller.googleAuth.begin(GoogleAuthPurpose.authenticate);
        expect(h.api.browserTokens, hasLength(1));
        expect(await h.controller.googleAuth.cancel(), isTrue);
        expect(h.api.cancelCalls, 1);
        expect(h.gateway.pending, isNull);
        expect(h.controller.token, 'guest-google-token');
      },
    );

    test(
      'a verify result arriving during voluntary logout cannot admit another account',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        final entered = Completer<void>();
        final reply = Completer<GoogleAuthResult>();
        h.api.verifyAction = () {
          entered.complete();
          return reply.future;
        };
        final beginning = h.controller.googleAuth.begin(
          GoogleAuthPurpose.authenticate,
        );
        await entered.future;
        final leaving = h.controller.signOut();
        reply.complete(
          GoogleAuthenticatedResult(
            session: _session('candidate-google-token'),
          ),
        );
        await Future.wait([beginning, leaving]);
        expect(h.controller.token, isNull);
        expect(h.controller.profile, isNull);
        expect(h.store.storedSession, isNull);
        expect(h.store.autoResume, isFalse);
        expect(h.api.meTokens, isNot(contains('candidate-google-token')));
        expect(h.api.cancelCalls, 1);
        expect(h.gateway.clearStateCalls, 1);
        expect(h.gateway.pending, isNull);
        expect(h.tunnel.disconnectCalls, 1);
      },
    );

    test(
      'a late candidate profile cannot bypass a cancellation and logout snapshot',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        final entered = Completer<void>();
        final reply = Completer<UserProfile>();
        h.api.verification = GoogleAuthenticatedResult(
          session: _session('candidate-google-token'),
        );
        h.api.meAction = (token) async {
          if (token == 'candidate-google-token') {
            entered.complete();
            return reply.future;
          }
          return h.api.profilesByToken[token]!;
        };
        final beginning = h.controller.googleAuth.begin(
          GoogleAuthPurpose.authenticate,
        );
        await entered.future;
        final leaving = h.controller.signOut();
        reply.complete(_googleRegisteredProfile('candidate-google-user'));
        await Future.wait([beginning, leaving]);
        expect(h.controller.profile, isNull);
        expect(h.controller.token, isNull);
        expect(h.store.storedSession, isNull);
        expect(
          h.store.sessionWriteUsers.where(
            (value) => value == 'candidate-google-user',
          ),
          isEmpty,
        );
        expect(h.api.cancelCalls, 1);
      },
    );

    test(
      'Back racing a committed guest claim preserves that account and live VPN',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
        final entered = Completer<void>();
        final reply = Completer<GoogleGuestClaimResult>();
        h.api.claimAction = () {
          entered.complete();
          return reply.future;
        };
        final claiming = h.controller.googleAuth.completeProfile(
          countryCode: 'BE',
          termsAccepted: true,
          privacyAccepted: true,
        );
        await entered.future;
        final cancel = h.controller.googleAuth.cancel();
        h.api.profilesByToken['guest-google-token'] = _googleRegisteredProfile(
          'guest-google-user',
        );
        reply.complete(_googleClaimResult);
        await claiming;
        expect(await cancel, isTrue);
        expect(h.controller.profile?.authMethods, ['google']);
        expect(h.controller.token, 'guest-google-token');
        expect(h.controller.currentDeviceId, 'guest-google-device');
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.api.cancelCalls, 0);
        expect(h.gateway.pending, isNull);
      },
    );

    test(
      'cancellation during a durable candidate write leaves no second native session',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        h.api.profilesByToken['candidate-google-token'] =
            _googleRegisteredProfile('candidate-google-user');
        h.api.verification = GoogleAuthenticatedResult(
          session: _session('candidate-google-token'),
        );
        final entered = Completer<void>();
        final release = Completer<void>();
        var paused = false;
        h.store.beforeWrite = () async {
          if (!paused) {
            paused = true;
            entered.complete();
            await release.future;
          }
        };
        final beginning = h.controller.googleAuth.begin(
          GoogleAuthPurpose.authenticate,
        );
        await entered.future;
        final cancelling = h.controller.googleAuth.cancel();
        release.complete();
        await beginning;
        expect(await cancelling, isTrue);
        expect(h.controller.profile, isNull);
        expect(h.controller.token, isNull);
        expect(h.store.storedSession, isNull);
        expect(h.controller.sessionTermination, isNull);
        expect(h.gateway.pending, isNull);
        expect(h.api.cancelCalls, 1);
      },
    );

    for (final failedWrite in [false, true]) {
      test(
        'Google cancellation unlocks login after native ${failedWrite ? 'session write' : 'cleanup'} recovery',
        () async {
          final h = await _googleHarness();
          addTearDown(h.close);
          h.api.profilesByToken['candidate-google-token'] =
              _googleRegisteredProfile('candidate-google-user');
          h.api.verification = GoogleAuthenticatedResult(
            session: _session('candidate-google-token'),
          );
          if (failedWrite) {
            h.store.beforeWrite = () async =>
                throw const NativeVpnException('secure_storage_write_failed');
          } else {
            h.store.failClear = true;
          }
          await h.controller.googleAuth.begin(GoogleAuthPurpose.authenticate);
          expect(h.controller.token, isNull);
          expect(h.controller.googleAuth.hasPendingIntent, isTrue);
          expect(h.controller.googleAuth.isBusy, isFalse);
          expect(h.gateway.pending, isNotNull);
          if (!failedWrite) {
            expect(h.controller.sessionTermination, isNotNull);
            h.store.failClear = false;
            await h.controller.retrySessionTermination();
          }
          expect(h.controller.sessionTermination, isNull);
          expect(await h.controller.googleAuth.cancel(), isTrue);
          expect(h.controller.googleAuth.hasPendingIntent, isFalse);
          expect(h.controller.isAuthenticating, isFalse);
          expect(h.gateway.pending, isNull);
          expect(h.api.cancelCalls, 1);
          expect(h.gateway.signInCalls, 1);
          expect(h.store.storedSession, isNull);
        },
      );
    }

    test(
      'restart reconciles an already committed claim without a new Google selection',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
        final savedPending = h.gateway.pending;
        h.controller.dispose();
        h.api.profilesByToken['guest-google-token'] = _googleRegisteredProfile(
          'guest-google-user',
        );
        h.controller = h.newController();
        await h.controller.initialize();
        expect(h.gateway.pending, savedPending);
        await h.controller.googleAuth.resume();
        expect(
          h.controller.googleAuth.state.step,
          GoogleAuthStep.authenticated,
        );
        expect(h.controller.token, 'guest-google-token');
        expect(h.controller.currentDeviceId, 'guest-google-device');
        expect(h.gateway.signInCalls, 1);
        expect(h.api.claimCalls, 0);
        expect(h.store.guestClearCalls, 1);
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.gateway.pending, isNull);
      },
    );

    for (final previous in [
      GoogleAuthPurpose.authenticate,
      GoogleAuthPurpose.claim,
    ]) {
      test(
        'restart rejects ${previous.name} as another guest purpose without replacing its session',
        () async {
          final h = await _googleHarness();
          addTearDown(h.close);
          await h.controller.googleAuth.begin(previous);
          final saved = h.gateway.pending;
          h.controller.dispose();
          h.controller = h.newController();
          await h.controller.initialize();
          final writes = h.store.sessionWriteUsers.length;
          final requested = previous == GoogleAuthPurpose.claim
              ? GoogleAuthPurpose.authenticate
              : GoogleAuthPurpose.claim;
          await h.controller.googleAuth.begin(requested);
          await h.controller.googleAuth.resume();
          await h.controller.googleAuth.completeProfile(
            countryCode: 'BE',
            termsAccepted: true,
            privacyAccepted: true,
          );
          expect(
            h.controller.googleAuth.state.block,
            GoogleAuthBlock.intentMismatch,
          );
          expect(h.controller.profile?.isGuest, isTrue);
          expect(h.controller.profile?.userId, 'guest-google-user');
          expect(h.controller.token, 'guest-google-token');
          expect(h.controller.currentDeviceId, 'guest-google-device');
          expect(h.store.autoResume, isTrue);
          expect(h.store.sessionWriteUsers, hasLength(writes));
          expect(h.store.clearSessionCalls, 0);
          expect(h.tunnel.disconnectCalls, 0);
          expect(h.gateway.signInCalls, 1);
          expect(h.api.claimCalls, 0);
          expect(h.api.registrationCalls, 0);
          expect(h.gateway.pending, saved);
          expect(await h.controller.googleAuth.cancel(), isTrue);
          expect(h.api.cancelCalls, 1);
          expect(h.gateway.pending, isNull);
          expect(h.controller.token, 'guest-google-token');
        },
      );
    }

    test(
      'logout after a successful claim disables guest resumption and clears SDK state',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        await h.controller.googleAuth.begin(GoogleAuthPurpose.claim);
        await h.controller.googleAuth.completeProfile(
          countryCode: 'BE',
          termsAccepted: true,
          privacyAccepted: true,
        );
        await h.controller.signOut();
        expect(h.controller.profile, isNull);
        expect(h.controller.token, isNull);
        expect(h.store.storedSession, isNull);
        expect(h.store.autoResume, isFalse);
        expect(h.gateway.clearStateCalls, 1);
        expect(h.gateway.pending, isNull);
        expect(h.api.cancelCalls, 0);
      },
    );
  });
}

// Corrections 2026-10-29 (R2-google): the audit's real-controller variants
// I1/I2 (repros/H-RA-A08-01) and C5-03 (repros/C5-...), assertions inverted.
void _googleCorrections20261029() {
  group('Google corrections 2026-10-29 with the real VpnAppController', () {
    const limited = ApiException(
      statusCode: 429,
      errorCode: 'rate_limited',
      retryAfterSeconds: 120,
    );
    Future<void> submit(_GoogleControllerHarness h) =>
        h.controller.googleAuth.completeProfile(
          countryCode: 'BE',
          termsAccepted: true,
          privacyAccepted: true,
        );

    test(
      'A03-google-01 Back during a real claim429 with failed cancellation keeps its deadline',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        final google = h.controller.googleAuth;
        await google.begin(GoogleAuthPurpose.claim);
        final entered = Completer<void>();
        final reply = Completer<GoogleGuestClaimResult>();
        h.api.claimAction = () {
          entered.complete();
          return reply.future;
        };
        final earliest = DateTime.now().add(const Duration(seconds: 120));
        final claiming = submit(h);
        await entered.future;
        h.api.cancelFailure = const ApiNetworkException(
          code: 'network_timeout',
        );
        final cancelling = google.cancel();
        reply.completeError(limited);
        await claiming;
        expect(await cancelling, isFalse);
        final deadline = google.state.retryAfter;
        expect(google.state.messageKey, 'google.cancelFailed');
        expect(deadline, isNotNull);
        expect(deadline!.isBefore(earliest), isFalse);
        h.api.cancelFailure = null;
        h.api.claimAction = () async => throw limited;
        await google.resume();
        expect(google.state.step, GoogleAuthStep.guestClaimRequired);
        expect(google.state.messageKey, 'google.rateLimited');
        expect(google.state.retryAfter, deadline);
        await submit(h);
        expect(h.api.claimCalls, 1);
        expect(h.controller.token, 'guest-google-token');
        expect(h.controller.profile?.isGuest, isTrue);
        expect(h.tunnel.disconnectCalls, 0);
      },
    );

    test(
      'A03-google-02 a claim Turnstile refusal survives a failing real /me',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        final google = h.controller.googleAuth;
        await google.begin(GoogleAuthPurpose.claim);
        h.api.claimAction = () async => throw const ApiException(
          statusCode: 403,
          errorCode: 'turnstile_required',
        );
        h.api.meAction = (_) async =>
            throw const ApiNetworkException(code: 'network_timeout');
        await submit(h);
        expect(google.state.block, GoogleAuthBlock.securityChallenge);
        expect(google.state.securityChallengeRequired, isTrue);
        h.api.meAction = null;
        await google.resume();
        expect(google.state.block, GoogleAuthBlock.securityChallenge);
        await submit(h);
        expect(h.api.claimCalls, 1);
        expect(h.controller.token, 'guest-google-token');
        expect(h.controller.profile?.isGuest, isTrue);
        expect(h.tunnel.disconnectCalls, 0);
      },
    );

    test(
      'C5-03 a refused begin during a connection never erases an uncancelled ticket',
      () async {
        final h = await _googleHarness();
        addTearDown(h.close);
        final saved = jsonEncode(<String, Object?>{
          'version': 1,
          'request_id': 'request-fixture-0001',
          'purpose': 'claim',
          'stage': 'continuation',
          'ticket': 'stored-claim-ticket',
          'context': 'bct-google-fixture',
          'expires_at': '2099-01-01T00:00:00.000Z',
          'generation': 1,
          'user_id': 'guest-google-user',
        });
        h.gateway.pending = saved;
        h.controller.isConnecting = true;
        final google = h.controller.googleAuth;
        await google.begin(GoogleAuthPurpose.claim);
        expect(google.state.step, GoogleAuthStep.idle);
        expect(google.state.messageKey, isNotNull);
        expect(h.gateway.pending, saved);
        h.api.cancelFailure = const ApiNetworkException(
          code: 'network_timeout',
        );
        expect(await google.cancel(), isFalse);
        expect(h.gateway.pending, saved);
        expect(h.controller.isAuthenticating, isTrue);
        h.api.cancelFailure = null;
        expect(await google.cancel(), isTrue);
        expect(h.api.cancelledTickets, [
          'stored-claim-ticket',
          'stored-claim-ticket',
        ]);
        expect(h.gateway.pending, isNull);
        expect(h.gateway.signInCalls, 0);
        h.controller.isConnecting = false;
        await google.begin(GoogleAuthPurpose.claim);
        expect(h.gateway.signInCalls, 1);
        expect(google.state.step, GoogleAuthStep.guestClaimRequired);
        expect(h.controller.token, 'guest-google-token');
      },
    );

    test('review V7 a persisted committed claim is recognised by the real /me '
        'before any server cancellation', () async {
      final h = await _googleHarness();
      addTearDown(h.close);
      h.gateway.pending = _persistedClaimTicket;
      h.controller.isConnecting = true;
      final google = h.controller.googleAuth;
      await google.begin(GoogleAuthPurpose.claim);
      expect(google.state.step, GoogleAuthStep.idle);
      // The lost claim reply had already committed the conversion.
      h.api.profilesByToken['guest-google-token'] = _googleRegisteredProfile(
        'guest-google-user',
      );
      expect(await google.cancel(), isTrue);
      expect(h.api.cancelledTickets, isEmpty);
      expect(google.state.step, GoogleAuthStep.authenticated);
      expect(h.gateway.pending, isNull);
      expect(h.controller.profile?.isGuest, isFalse);
      expect(h.controller.token, 'guest-google-token');
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.controller.isAuthenticating, isFalse);
    });

    test('review P1 an unreadable persisted ticket never keeps the real '
        'controller authenticating', () async {
      final h = await _googleHarness();
      addTearDown(h.close);
      h.gateway.pending = _persistedClaimTicket;
      h.gateway.readFailure = GoogleCredentialException(
        'secure_storage_failed',
      );
      final google = h.controller.googleAuth;
      await google.begin(GoogleAuthPurpose.claim);
      expect(google.state.messageKey, 'google.unavailable');
      expect(await google.cancel(), isTrue);
      expect(await google.cancel(), isTrue);
      expect(h.controller.isAuthenticating, isFalse);
      expect(h.gateway.pending, _persistedClaimTicket);
      expect(h.gateway.signInCalls, 0);
      expect(h.api.cancelledTickets, isEmpty);
      expect(h.controller.token, 'guest-google-token');
      expect(h.tunnel.disconnectCalls, 0);
    });
  });
}

final _persistedClaimTicket = jsonEncode(<String, Object?>{
  'version': 1,
  'request_id': 'request-fixture-0001',
  'purpose': 'claim',
  'stage': 'continuation',
  'ticket': 'stored-claim-ticket',
  'context': 'bct-google-fixture',
  'expires_at': '2099-01-01T00:00:00.000Z',
  'generation': 1,
  'user_id': 'guest-google-user',
});

const _googleClaimResult = GoogleGuestClaimResult(
  userId: 'guest-google-user',
  emailVerified: true,
  verificationEmailSent: false,
);

UserProfile _googleRegisteredProfile(String userId) => UserProfile(
  userId: userId,
  email: 'google@example.test',
  emailVerified: true,
  authMethods: const ['google'],
  hasPassword: false,
  hasSessionCapabilities: true,
  canManageAccount: true,
  canClaimAccount: false,
  canUseVpn: true,
);

Future<_GoogleControllerHarness> _googleHarness({
  VpnProtocol protocol = VpnProtocol.wireGuard,
}) async {
  final api = _GoogleControllerApi()
    ..profilesByToken['guest-google-token'] = const UserProfile(
      userId: 'guest-google-user',
      identityKind: 'guest',
      profileRedacted: true,
      hasSessionCapabilities: true,
      canManageAccount: false,
      canClaimAccount: true,
      canUseVpn: true,
    )
    ..deviceListResult = _devices('guest-google-device');
  final tunnel = _FakeTunnel()
    ..state = VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: protocol,
    );
  final store = _GoogleGuestSessionStore()
    ..storedSession = _session('guest-google-token')
    ..deviceIds['guest-google-user'] = 'guest-google-device'
    ..tunnel = tunnel;
  final h = _GoogleControllerHarness(
    api,
    store,
    tunnel,
    _GoogleControllerGateway(),
  );
  h.controller = h.newController();
  await h.controller.initialize();
  return h;
}

class _GoogleControllerHarness {
  _GoogleControllerHarness(this.api, this.store, this.tunnel, this.gateway);
  final _GoogleControllerApi api;
  final _GoogleGuestSessionStore store;
  final _FakeTunnel tunnel;
  final _GoogleControllerGateway gateway;
  late VpnAppController controller;

  VpnAppController newController() => VpnAppController(
    api: api,
    sessionStore: store,
    preferences: _FakePreferences(),
    tunnel: tunnel,
    googleGateway: gateway,
    googlePendingStore: gateway,
  );

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _GoogleGuestSessionStore extends _FakeSessionStore
    implements GuestCredentialStore {
  String? credential = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
  String? pendingCredential;
  bool autoResume = true;
  int guestClearCalls = 0;

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    final result = await super.clearSession(expired: expired);
    if (result.sessionCleared && !expired) autoResume = false;
    return result;
  }

  @override
  Future<String?> readGuestCredential() async => credential;
  @override
  Future<void> writeGuestCredential(String value) async {
    credential = value;
    pendingCredential = null;
  }

  @override
  Future<String?> readPendingGuestCredential() async => pendingCredential;
  @override
  Future<void> writePendingGuestCredential(String value) async {
    pendingCredential = value;
  }

  @override
  Future<void> clearGuestCredentials() async {
    guestClearCalls++;
    credential = pendingCredential = null;
    autoResume = false;
  }

  @override
  Future<bool> readGuestAutoResume() async => autoResume;
  @override
  Future<void> writeGuestAutoResume(bool enabled) async {
    autoResume = enabled;
  }
}

class _GoogleControllerGateway
    implements GoogleCredentialGateway, GooglePendingAuthStore {
  String? pending;
  Object? readFailure;
  final writes = <String>[];
  int signInCalls = 0;
  int clearStateCalls = 0;

  @override
  Future<GoogleCredentialCapabilities> getCapabilities() async =>
      const GoogleCredentialCapabilities(supported: true);
  @override
  Future<GoogleCredentialResult> signIn({
    required String requestId,
    required String serverClientId,
    required String nonce,
  }) async {
    signInCalls++;
    return GoogleCredentialResult(
      requestId: requestId,
      idToken: 'native-jwt-fixture',
    );
  }

  @override
  Future<void> cancelSignIn({required String requestId}) async {}
  @override
  Future<void> clearCredentialState() async {
    clearStateCalls++;
  }

  @override
  Future<String?> readPendingAuthentication() async {
    final failure = readFailure;
    if (failure != null) throw failure;
    return pending;
  }

  @override
  Future<void> writePendingAuthentication(String payload) async {
    writes.add(payload);
    pending = payload;
  }

  @override
  Future<void> clearPendingAuthentication() async {
    pending = null;
  }
}

class _GoogleControllerApi extends _FakeApi implements GoogleAuthApiRepository {
  String purpose = 'claim';
  GoogleAuthResult? verification;
  Future<GoogleAuthResult> Function()? verifyAction;
  Future<GoogleGuestClaimResult> Function()? claimAction;
  Future<UserProfile> Function(String)? meAction;
  final browserTokens = <String?>[];
  final challengeTokens = <String?>[];
  int claimCalls = 0;
  int registrationCalls = 0;
  int cancelCalls = 0;
  Object? cancelFailure;
  final cancelledTickets = <String>[];

  @override
  Future<UserProfile> me(String token) async {
    if (meAction == null) return super.me(token);
    meTokens.add(token);
    return meAction!(token);
  }

  @override
  Future<GoogleBrowserContext> createGoogleBrowserContext({
    String? token,
    String? browserContextToken,
  }) async {
    browserTokens.add(token);
    return GoogleBrowserContext(
      browserContextToken: 'bct-google-fixture',
      authGeneration: 1,
      expiresAt: DateTime.utc(2099),
    );
  }

  @override
  Future<GoogleAuthChallenge> createGoogleChallenge({
    required GoogleBrowserContext browserContext,
    required String purpose,
    String? token,
  }) async {
    this.purpose = purpose;
    challengeTokens.add(token);
    return GoogleAuthChallenge(
      challengeId: 'google-challenge-fixture',
      nonce: 'google-nonce-fixture',
      contextToken: 'gct-google-fixture',
      expiresAt: DateTime.utc(2099),
    );
  }

  @override
  Future<GoogleAuthResult> verifyGoogleCredential({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String challengeId,
    required String credential,
  }) async => verifyAction != null
      ? await verifyAction!()
      : verification ??
            GoogleContinuationResult(
              status: purpose == 'claim'
                  ? 'guest_claim_required'
                  : 'registration_required',
              contextToken: 'gct-google-continuation',
              expiresAt: DateTime.utc(2099),
            );
  @override
  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async => GoogleAuthContext(
    status: purpose == 'claim'
        ? 'guest_claim_required'
        : 'registration_required',
    purpose: purpose,
    expiresAt: DateTime.utc(2099),
    email: 'google@example.test',
    emailVerified: true,
  );
  @override
  Future<GoogleGuestClaimResult> claimGuestWithGoogle({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
    String? turnstileToken,
  }) async {
    claimCalls++;
    if (claimAction != null) return claimAction!();
    profilesByToken['guest-google-token'] = _googleRegisteredProfile(
      'guest-google-user',
    );
    return _googleClaimResult;
  }

  @override
  Future<GoogleAuthenticatedResult> registerGoogleAccount({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
    String? turnstileToken,
  }) async {
    registrationCalls++;
    return GoogleAuthenticatedResult(
      session: _session('candidate-google-token'),
    );
  }

  @override
  Future<GoogleAuthenticatedResult> linkGoogleWithPassword({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String currentPassword,
  }) async =>
      GoogleAuthenticatedResult(session: _session('candidate-google-token'));
  @override
  Future<void> requestGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {}
  @override
  Future<GoogleAuthenticatedResult> confirmGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String code,
  }) async =>
      GoogleAuthenticatedResult(session: _session('candidate-google-token'));
  @override
  Future<void> cancelGoogleAuth({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    String? challengeId,
  }) async {
    cancelCalls++;
    cancelledTickets.add(contextToken);
    final failure = cancelFailure;
    if (failure != null) throw failure;
  }

  @override
  Future<AuthSession> loginWithAuthContext({
    required GoogleBrowserContext browserContext,
    required String email,
    required String password,
  }) => login(email: email, password: password);
}
