part of '../app_controller_test.dart';

void googleControllerTests() {
  group('Google account admission preserves Fuze identity and VPN ownership', () {
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
      'Turnstile rejection preserves the guest and continuation without retrying',
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
        expect(
          h.controller.googleAuth.state.step,
          GoogleAuthStep.guestClaimRequired,
        );
        expect(
          h.controller.googleAuth.state.messageKey,
          'google.challengeRequired',
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
  Future<String?> readPendingAuthentication() async => pending;
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
  int cancelCalls = 0;

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
  }) async =>
      GoogleAuthenticatedResult(session: _session('candidate-google-token'));
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
  }

  @override
  Future<AuthSession> loginWithAuthContext({
    required GoogleBrowserContext browserContext,
    required String email,
    required String password,
  }) => login(email: email, password: password);
}
