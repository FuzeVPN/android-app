import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/google_auth.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/security_challenge.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';

final _expiry = DateTime.utc(2099);
final _browser = GoogleBrowserContext(
  browserContextToken: 'browser-fixture',
  authGeneration: 3,
  expiresAt: _expiry,
);
final _challenge = GoogleAuthChallenge(
  challengeId: 'challenge-fixture',
  nonce: 'exact-server-nonce',
  contextToken: 'initial-ticket-fixture',
  expiresAt: _expiry,
);
final _authenticated = GoogleAuthenticatedResult(
  session: AuthSession(accessToken: 'final-fuze-fixture', expiresAt: _expiry),
);

void main() {
  _claimRetryCorrectionTests();
  test(
    'constructing Google controller does not read accounts or create intent',
    () {
      final h = _Harness();
      addTearDown(h.close);
      expect(h.api.created, 0);
      expect(h.gateway.capabilityCalls, 0);
      expect(h.gateway.selections, 0);
      expect(h.store.writes, isEmpty);
    },
  );

  test(
    'only explicit picker uses exact nonce after encrypted ticket commit',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.gateway.beforeSelection = () {
        expect(h.store.payload, isNotNull);
        final saved = jsonDecode(h.store.payload!) as Map<String, dynamic>;
        expect(saved['ticket'], 'initial-ticket-fixture');
        expect(saved['context'], 'browser-fixture');
        expect(saved.keys, isNot(contains('credential')));
        expect(saved.keys, isNot(contains('nonce')));
      };
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      expect(h.gateway.nonce, 'exact-server-nonce');
      expect(h.gateway.clientId, GoogleAuthController.serverClientId);
      expect(h.api.credentials, ['google-jwt-fixture']);
      expect(h.admissions, 0);
      expect(h.controller.state.step, GoogleAuthStep.registrationRequired);
      expect(h.store.payload, isNot(contains('google-jwt-fixture')));
    },
  );

  test('unavailable Google stops before server or storage intent', () async {
    final h = _Harness();
    addTearDown(h.close);
    h.gateway.supported = false;
    await h.controller.begin(GoogleAuthPurpose.authenticate);
    expect(h.api.created, 0);
    expect(h.store.payload, isNull);
    expect(h.controller.state.messageKey, 'google.unavailable');
  });

  test(
    'failure to persist private challenge prevents native selection',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.failWrite = true;
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      expect(h.gateway.selections, 0);
      expect(h.admissions, 0);
      expect(h.controller.hasPendingIntent, isTrue);
      expect(await h.controller.cancel(), isTrue);
      expect(h.api.cancellations, 1);
    },
  );

  test('registration needs explicit country and both consents', () async {
    final h = _Harness();
    addTearDown(h.close);
    await h.controller.begin(GoogleAuthPurpose.authenticate);
    await h.controller.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: false,
    );
    expect(h.api.registrations, 0);
    expect(h.controller.state.step, GoogleAuthStep.registrationRequired);
    expect(h.controller.state.messageKey, 'google.consentRequired');
    await h.controller.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    expect(h.api.registrations, 1);
    expect(h.admissions, 1);
    expect(h.controller.state.step, GoogleAuthStep.authenticated);
    expect(h.store.payload, isNull);
  });

  test(
    'Turnstile refusal blocks unchanged payload retries and preserves context',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.api.registrationFailure = const ApiException(
        statusCode: 403,
        errorCode: 'turnstile_required',
      );
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      await h.controller.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );
      expect(h.admissions, 0);
      expect(h.controller.state.step, GoogleAuthStep.uncertain);
      expect(h.controller.state.block, GoogleAuthBlock.securityChallenge);
      expect(h.controller.state.messageKey, 'google.challengeRequired');
      expect(h.controller.state.context, isNotNull);
      expect(h.store.payload, isNotNull);
      final saved = h.store.payload;
      await h.controller.resume();
      await h.controller.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );
      expect(h.api.registrations, 1);
      expect(h.controller.state.block, GoogleAuthBlock.securityChallenge);
      expect(h.store.payload, saved);
      expect(await h.controller.cancel(), isTrue);
    },
  );

  test(
    'guest flow never registers a new identity and admits unchanged bearer',
    () async {
      final h = _Harness(guest: true);
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.claim);
      expect(h.api.challengeToken, 'guest-bearer-fixture');
      expect(h.controller.state.step, GoogleAuthStep.guestClaimRequired);
      h.claimed = true;
      await h.controller.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );
      expect(h.api.registrations, 0);
      expect(h.api.claims, 1);
      expect(h.admissions, 0);
      expect(h.controller.state.step, GoogleAuthStep.authenticated);
    },
  );

  test('lost claim response recovers only from initiating profile', () async {
    final h = _Harness(guest: true);
    addTearDown(h.close);
    await h.controller.begin(GoogleAuthPurpose.claim);
    h.api.claimFailure = const ApiNetworkException(code: 'network_timeout');
    h.claimed = true;
    await h.controller.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    expect(h.controller.state.step, GoogleAuthStep.authenticated);
    expect(h.admissions, 0);
    expect(h.store.payload, isNull);
  });

  test(
    'Google identity conflict keeps guest conversion form and private intent',
    () async {
      final h = _Harness(guest: true);
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.claim);
      h.api.claimFailure = const ApiException(
        statusCode: 409,
        errorCode: 'google_identity_conflict',
      );
      await h.controller.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );
      expect(h.controller.state.step, GoogleAuthStep.guestClaimRequired);
      expect(h.controller.state.messageKey, 'google.conflict');
      expect(h.store.payload, isNotNull);
      expect(h.api.registrations, 0);
      expect(h.admissions, 0);
    },
  );

  test(
    'process restart resumes continuation without selecting Google again',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      final saved = h.store.payload;
      final other = _Harness();
      addTearDown(other.close);
      other.store.payload = saved;
      await other.controller.begin(GoogleAuthPurpose.authenticate);
      expect(other.gateway.selections, 0);
      expect(other.api.created, 0);
      expect(other.controller.state.step, GoogleAuthStep.registrationRequired);
    },
  );

  test(
    'uncertain verify response cannot begin a concurrent purchase or identity',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.api.verifyFailure = const ApiNetworkException();
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      expect(h.controller.state.step, GoogleAuthStep.uncertain);
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      expect(h.gateway.selections, 1);
      expect(h.api.created, 1);
      expect(h.admissions, 0);
      expect(await h.controller.cancel(), isTrue);
      expect(h.api.cancelChallengeId, 'challenge-fixture');
    },
  );

  test(
    'Back during selection rejects late Google token before API exchange',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      final selected = Completer<GoogleCredentialResult>();
      h.gateway.selection = selected.future;
      final begin = h.controller.begin(GoogleAuthPurpose.authenticate);
      await _until(() => h.gateway.selections == 1);
      final cancelled = h.controller.cancel();
      selected.complete(
        const GoogleCredentialResult(
          requestId: 'late-fixture',
          idToken: 'late-google-fixture',
        ),
      );
      await begin;
      expect(await cancelled, isTrue);
      expect(h.api.credentials, isEmpty);
      expect(h.admissions, 0);
      expect(h.store.payload, isNull);
    },
  );

  test(
    'Back during challenge cancels returned intent without opening picker',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      final response = Completer<GoogleAuthChallenge>();
      h.api.challengeResponse = response.future;
      final begin = h.controller.begin(GoogleAuthPurpose.authenticate);
      await _until(() => h.api.created == 1);
      final cancelled = h.controller.cancel();
      response.complete(_challenge);
      await begin;
      expect(await cancelled, isTrue);
      expect(h.api.cancellations, 1);
      expect(h.gateway.selections, 0);
    },
  );

  test(
    'late final verification never admits after explicit cancellation',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      final response = Completer<GoogleAuthResult>();
      h.api.verifyResponse = response.future;
      final begin = h.controller.begin(GoogleAuthPurpose.authenticate);
      await _until(() => h.api.credentials.isNotEmpty);
      final cancelled = h.controller.cancel();
      response.complete(_authenticated);
      await begin;
      expect(await cancelled, isTrue);
      expect(h.admissions, 0);
      expect(h.api.cancellations, 1);
    },
  );

  test(
    'cancellation outage retains encrypted ticket and reports retry',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      h.api.cancelFailure = const ApiNetworkException();
      expect(await h.controller.cancel(), isFalse);
      expect(h.store.payload, isNotNull);
      expect(h.controller.state.messageKey, 'google.cancelFailed');
      h.api.cancelFailure = null;
      expect(await h.controller.cancel(), isTrue);
      expect(h.store.payload, isNull);
    },
  );

  test(
    'successful claim recovery on Back never revokes promoted guest',
    () async {
      final h = _Harness(guest: true);
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.claim);
      h.claimed = true;
      expect(await h.controller.cancel(), isTrue);
      expect(h.api.cancellations, 0);
      expect(h.controller.state.step, GoogleAuthStep.authenticated);
    },
  );

  test(
    'cleanup failure cannot revoke the authenticated account on Back',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.api.verifyResult = _authenticated;
      h.store.failClear = true;
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      expect(h.admissions, 1);
      expect(h.controller.state.step, GoogleAuthStep.authenticated);
      expect(await h.controller.cancel(), isTrue);
      expect(h.api.cancellations, 0);
    },
  );
  test('resume keeps rotated memory ticket after failed disk commit', () async {
    final h = _Harness();
    addTearDown(h.close);
    h.store.failWriteNumber = 2;
    await h.controller.begin(GoogleAuthPurpose.authenticate);
    expect(h.controller.state.step, GoogleAuthStep.uncertain);
    expect(h.store.payload, contains('initial-ticket-fixture'));
    h.store.failWriteNumber = null;
    await h.controller.resume();
    expect(h.store.payload, contains('rotated-ticket-fixture'));
    expect(h.api.inspectedTicket, 'rotated-ticket-fixture');
    expect(h.controller.state.step, GoogleAuthStep.registrationRequired);
    expect(h.gateway.selections, 1);
  });
  test(
    'claim Back still cancels if initiating profile is unavailable',
    () async {
      final h = _Harness(guest: true);
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.claim);
      h.claimReadFailure = const ApiException(
        statusCode: 503,
        errorCode: 'api_error',
      );
      expect(await h.controller.cancel(), isTrue);
      expect(h.api.cancellations, 1);
      expect(h.store.payload, isNull);
      expect(h.admissions, 0);
    },
  );
  test(
    'claim context remains inspectable when old bearer has expired',
    () async {
      final h = _Harness(guest: true);
      addTearDown(h.close);
      await h.controller.begin(GoogleAuthPurpose.claim);
      h.claimReadFailure = const ApiException(
        statusCode: 401,
        errorCode: 'unauthorized',
      );
      await h.controller.resume();
      expect(h.controller.state.step, GoogleAuthStep.guestClaimRequired);
      expect(h.api.inspectedTicket, 'rotated-ticket-fixture');
      expect(h.admissions, 0);
    },
  );

  for (final previousPurpose in [
    GoogleAuthPurpose.authenticate,
    GoogleAuthPurpose.claim,
  ]) {
    test(
      'persisted ${previousPurpose.name} cannot resume as another guest intent',
      () async {
        final first = _Harness(guest: true);
        first.api.purpose = previousPurpose.name;
        await first.controller.begin(previousPurpose);
        final saved = first.store.payload;
        first.close();

        final restored = _Harness(guest: true);
        addTearDown(restored.close);
        restored.api.purpose = previousPurpose.name;
        restored.store.payload = saved;
        final requested = previousPurpose == GoogleAuthPurpose.claim
            ? GoogleAuthPurpose.authenticate
            : GoogleAuthPurpose.claim;
        await restored.controller.begin(requested);
        expect(restored.controller.state.block, GoogleAuthBlock.intentMismatch);
        expect(restored.controller.state.messageKey, 'google.intentMismatch');
        expect(restored.controller.state.context, isNull);
        expect(restored.controller.hasPendingIntent, isTrue);
        await restored.controller.resume();
        await restored.controller.completeProfile(
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );
        await restored.controller.linkWithPassword('fixture-password');
        await restored.controller.confirmEmailLink('fixture-code');
        await restored.controller.requestEmailLink();
        expect(restored.api.contextReads, 0);
        expect(restored.api.created, 0);
        expect(restored.api.registrations, 0);
        expect(restored.api.claims, 0);
        expect(restored.admissions, 0);
        expect(restored.gateway.selections, 0);
        expect(restored.store.payload, saved);

        restored.api.cancelFailure = const ApiNetworkException();
        expect(await restored.controller.cancel(), isFalse);
        expect(restored.store.payload, saved);
        expect(restored.controller.state.block, GoogleAuthBlock.intentMismatch);
        restored.api.cancelFailure = null;
        expect(await restored.controller.cancel(), isTrue);
        expect(restored.store.payload, isNull);
        restored.api.purpose = requested.name;
        await restored.controller.begin(requested);
        expect(restored.controller.state.block, isNull);
        expect(restored.gateway.selections, 1);
        expect(restored.controller.state.context?.purpose, requested.name);
      },
    );
  }

  test(
    'an in-memory intent cannot be reopened under another purpose',
    () async {
      final h = _Harness(guest: true);
      addTearDown(h.close);
      h.api.purpose = 'authenticate';
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      final saved = h.store.payload;
      await h.controller.begin(GoogleAuthPurpose.claim);
      await h.controller.resume();
      expect(h.controller.state.block, GoogleAuthBlock.intentMismatch);
      expect(h.store.payload, saved);
      expect(h.gateway.selections, 1);
      expect(h.api.contextReads, 1);
    },
  );

  for (final guest in [false, true]) {
    test(
      'Retry-After blocks ${guest ? 'claim' : 'register'} through resume until expiry',
      () async {
        var now = DateTime.utc(2026, 10, 19);
        final h = _Harness(guest: guest, now: () => now);
        addTearDown(h.close);
        await h.controller.begin(
          guest ? GoogleAuthPurpose.claim : GoogleAuthPurpose.authenticate,
        );
        const limited = ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 120,
        );
        if (guest) {
          h.api.claimFailure = limited;
        } else {
          h.api.registrationFailure = limited;
        }
        Future<void> submit() => h.controller.completeProfile(
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );
        await submit();
        final deadline = now.add(const Duration(seconds: 120));
        expect(h.controller.state.retryAfter, deadline);
        await h.controller.resume();
        expect(h.controller.state.retryAfter, deadline);
        await submit();
        expect(guest ? h.api.claims : h.api.registrations, 1);
        now = deadline.subtract(const Duration(microseconds: 1));
        await submit();
        expect(guest ? h.api.claims : h.api.registrations, 1);
        now = deadline;
        await submit();
        expect(guest ? h.api.claims : h.api.registrations, 2);
      },
    );
  }

  test('Retry-After longer than one hour is preserved in full', () async {
    final now = DateTime.utc(2026, 10, 19);
    final h = _Harness(now: () => now);
    addTearDown(h.close);
    await h.controller.begin(GoogleAuthPurpose.authenticate);
    h.api.registrationFailure = const ApiException(
      statusCode: 429,
      errorCode: 'rate_limited',
      retryAfterSeconds: 7200,
    );
    await h.controller.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    expect(h.controller.state.retryAfter, now.add(const Duration(hours: 2)));
  });

  for (final proof in ['password', 'email']) {
    test('Retry-After blocks $proof proof and resend until expiry', () async {
      var now = DateTime.utc(2026, 10, 19);
      final h = _Harness(now: () => now);
      addTearDown(h.close);
      h.api.continuationStatus = 'link_required';
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      h.api.linkFailure = const ApiException(
        statusCode: 429,
        errorCode: 'rate_limited',
        retryAfterSeconds: 120,
      );
      Future<void> submit() => proof == 'password'
          ? h.controller.linkWithPassword('fixture-password')
          : h.controller.confirmEmailLink('fixture-code');
      await submit();
      final deadline = now.add(const Duration(seconds: 120));
      await h.controller.resume();
      await submit();
      await h.controller.requestEmailLink();
      expect(h.api.linkCalls, 1);
      expect(h.api.emailRequests, 0);
      expect(h.controller.state.retryAfter, deadline);
      now = deadline;
      await submit();
      expect(h.api.linkCalls, 2);
    });
  }

  test(
    'email resend cooldown allows immediate confirmation and survives resume',
    () async {
      var now = DateTime.utc(2026, 10, 19);
      final h = _Harness(now: () => now);
      addTearDown(h.close);
      h.api.continuationStatus = 'link_required';
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      await h.controller.requestEmailLink();
      final deadline = now.add(const Duration(seconds: 60));
      expect(h.controller.state.retryAfter, isNull);
      expect(h.controller.state.emailRetryAfter, deadline);
      await h.controller.resume();
      expect(h.controller.state.emailRequested, isTrue);
      expect(h.controller.state.emailRetryAfter, deadline);
      await h.controller.requestEmailLink();
      expect(h.api.emailRequests, 1);
      h.api.linkFailure = const ApiException(
        statusCode: 400,
        errorCode: 'google_invalid_email_code',
      );
      await h.controller.confirmEmailLink('fixture-code');
      expect(h.api.linkCalls, 1);
      now = deadline;
      await h.controller.requestEmailLink();
      expect(h.api.emailRequests, 2);
    },
  );
  for (final guest in [false, true]) {
    test(
      'security proof for ${guest ? 'claim' : 'register'} needs a second manual submit',
      () async {
        final h = await _challengeHarness(guest: guest);
        addTearDown(h.close);
        final saved = h.store.payload;
        await h.controller.solveSecurityChallenge(
          title: 'Security',
          cancelLabel: 'Cancel',
        );
        expect(h.securityGateway.requestIds, hasLength(1));
        expect(h.controller.state.challengeExpiresAt, isNotNull);
        expect(h.controller.state.block, isNull);
        expect(h.controller.state.messageKey, 'google.challengeReady');
        expect(h.api.challengeTokens, [null]);
        expect(h.admissions, 0);
        expect(h.store.payload, saved);
        expect(
          h.store.writes.join(),
          isNot(contains('security-proof-fixture')),
        );
        h.claimed = guest;
        await h.controller.completeProfile(
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );
        expect(h.api.challengeTokens, [null, 'security-proof-fixture']);
        expect(h.controller.state.step, GoogleAuthStep.authenticated);
        expect(h.controller.state.challengeExpiresAt, isNull);
        expect(h.controller.state.securityChallengeRequired, isFalse);
      },
    );

    test(
      'a ${guest ? 'claim' : 'register'} proof is consumed on error and cannot be replayed',
      () async {
        final h = await _challengeHarness(guest: guest);
        addTearDown(h.close);
        await h.controller.solveSecurityChallenge(
          title: 'Security',
          cancelLabel: 'Cancel',
        );
        if (guest) {
          h.api.claimFailure = const ApiNetworkException();
        } else {
          h.api.registrationFailure = const ApiNetworkException();
        }
        Future<void> submit() => h.controller.completeProfile(
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );
        await submit();
        expect(h.controller.state.challengeExpiresAt, isNull);
        expect(h.controller.state.block, GoogleAuthBlock.securityChallenge);
        await submit();
        expect(h.api.challengeTokens, [null, 'security-proof-fixture']);
        await h.controller.solveSecurityChallenge(
          title: 'Security',
          cancelLabel: 'Cancel',
        );
        expect(h.securityGateway.requestIds.toSet(), hasLength(2));
        await submit();
        expect(h.api.challengeTokens, [
          null,
          'security-proof-fixture',
          'security-proof-fixture',
        ]);
      },
    );
  }

  test(
    'security proof expires four minutes from start, including time in the native view',
    () async {
      var now = DateTime.utc(2026, 10, 19);
      final h = await _challengeHarness(now: () => now);
      addTearDown(h.close);
      h.securityGateway.action = (id) async {
        now = now.add(const Duration(minutes: 4));
        return SecurityChallengeResult(
          requestId: id,
          token: 'slow-proof-fixture',
        );
      };
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.controller.state.messageKey, 'google.challengeExpired');
      expect(h.controller.state.challengeExpiresAt, isNull);
      h.securityGateway.action = null;
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(
        h.controller.state.challengeExpiresAt,
        now.add(const Duration(minutes: 4)),
      );
      now = now.add(const Duration(minutes: 4));
      h.controller.expireSecurityChallenge();
      await h.controller.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );
      expect(h.controller.state.messageKey, 'google.challengeExpired');
      expect(h.controller.state.challengeExpiresAt, isNull);
      expect(h.api.challengeTokens, [null]);
    },
  );

  test('late security callback cannot authorize after cancellation', () async {
    final h = await _challengeHarness();
    addTearDown(h.close);
    final response = Completer<SecurityChallengeResult>();
    h.securityGateway.action = (_) => response.future;
    final solving = h.controller.solveSecurityChallenge(
      title: 'Security',
      cancelLabel: 'Cancel',
    );
    await _until(() => h.securityGateway.requestIds.isNotEmpty);
    final id = h.securityGateway.requestIds.single;
    final cancelling = h.controller.cancel();
    response.complete(
      SecurityChallengeResult(requestId: id, token: 'late-proof-fixture'),
    );
    await solving;
    expect(await cancelling, isTrue);
    expect(h.securityGateway.cancelled, [id]);
    expect(h.controller.state.challengeExpiresAt, isNull);
    expect(h.api.challengeTokens, [null]);
    expect(h.store.payload, isNull);
    expect(h.admissions, 0);
  });

  test(
    'mismatched request and changed identity cannot admit security callbacks',
    () async {
      final h = await _challengeHarness();
      addTearDown(h.close);
      h.securityGateway.action = (_) async => const SecurityChallengeResult(
        requestId: 'other-request-fixture',
        token: 'wrong-owner-proof',
      );
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.controller.state.messageKey, 'google.challengeFailed');
      expect(h.controller.state.challengeExpiresAt, isNull);
      h.securityGateway.action = (id) async {
        h.identityCurrent = false;
        return SecurityChallengeResult(
          requestId: id,
          token: 'changed-identity-proof',
        );
      };
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.controller.state.messageKey, 'google.accountChanged');
      expect(h.controller.state.challengeExpiresAt, isNull);
      expect(h.api.challengeTokens, [null]);
    },
  );

  for (final code in ['cancelled', 'unavailable', 'provider_error']) {
    test('security $code keeps the same intent without submitting', () async {
      final h = await _challengeHarness();
      addTearDown(h.close);
      final saved = h.store.payload;
      h.securityGateway.action = (_) async =>
          throw SecurityChallengeException(code);
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.controller.state.block, GoogleAuthBlock.securityChallenge);
      expect(h.controller.state.challengeExpiresAt, isNull);
      expect(h.store.payload, saved);
      expect(h.api.challengeTokens, [null]);
      expect(h.admissions, 0);
    });
  }

  test(
    'security resolution respects server Retry-After and intent mismatch',
    () async {
      var now = DateTime.utc(2026, 10, 19);
      final h = await _challengeHarness(guest: true, now: () => now);
      addTearDown(h.close);
      h.api.claimFailure = const ApiException(
        statusCode: 503,
        errorCode: 'turnstile_unavailable',
        retryAfterSeconds: 30,
      );
      // Existing required challenge prevents unchanged finalization; simulate its
      // resolution before a provider outage on the next manual submission.
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      await h.controller.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.securityGateway.requestIds, hasLength(1));
      now = now.add(const Duration(seconds: 30));
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.securityGateway.requestIds, hasLength(2));
      await h.controller.begin(GoogleAuthPurpose.authenticate);
      await h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      expect(h.securityGateway.requestIds, hasLength(2));
      expect(h.controller.state.block, GoogleAuthBlock.intentMismatch);
    },
  );
  test('unexpected Turnstile on linking never becomes registration', () async {
    final h = _Harness();
    addTearDown(h.close);
    h.api.continuationStatus = 'link_required';
    await h.controller.begin(GoogleAuthPurpose.authenticate);
    h.api.linkFailure = const ApiException(
      statusCode: 403,
      errorCode: 'turnstile_required',
    );
    await h.controller.linkWithPassword('fixture-password');
    await h.controller.solveSecurityChallenge(
      title: 'Security',
      cancelLabel: 'Cancel',
    );
    await h.controller.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    expect(h.controller.state.messageKey, 'google.invalidResponse');
    expect(h.securityGateway.requestIds, isEmpty);
    expect(h.api.registrations, 0);
    expect(h.api.claims, 0);
    expect(h.admissions, 0);
  });

  test(
    'disposal invalidates a pending security result without persisting its token',
    () async {
      final h = await _challengeHarness();
      final response = Completer<SecurityChallengeResult>();
      h.securityGateway.action = (_) => response.future;
      final solving = h.controller.solveSecurityChallenge(
        title: 'Security',
        cancelLabel: 'Cancel',
      );
      await _until(() => h.securityGateway.requestIds.isNotEmpty);
      final id = h.securityGateway.requestIds.single;
      h.close();
      response.complete(
        SecurityChallengeResult(requestId: id, token: 'disposed-proof-fixture'),
      );
      await solving;
      expect(h.securityGateway.cancelled, [id]);
      expect(h.controller.state.challengeExpiresAt, isNull);
      expect(h.store.writes.join(), isNot(contains('disposed-proof-fixture')));
      expect(h.api.challengeTokens, [null]);
    },
  );
}

Future<_Harness> _challengeHarness({
  bool guest = false,
  DateTime Function()? now,
}) async {
  final h = _Harness(guest: guest, now: now);
  await h.controller.begin(
    guest ? GoogleAuthPurpose.claim : GoogleAuthPurpose.authenticate,
  );
  const required = ApiException(
    statusCode: 403,
    errorCode: 'turnstile_required',
  );
  if (guest) {
    h.api.claimFailure = required;
  } else {
    h.api.registrationFailure = required;
  }
  await h.controller.completeProfile(
    countryCode: 'FR',
    termsAccepted: true,
    privacyAccepted: true,
  );
  h.api.claimFailure = null;
  h.api.registrationFailure = null;
  return h;
}

Future<void> _until(bool Function() ready) async {
  for (var i = 0; i < 30 && !ready(); i++) {
    await Future<void>.delayed(Duration.zero);
  }
  expect(ready(), isTrue);
}

class _Harness {
  _Harness({bool guest = false, DateTime Function()? now}) {
    final identity = GoogleIdentitySnapshot(
      userId: guest ? 'guest-fixture' : null,
      accessToken: guest ? 'guest-bearer-fixture' : null,
      isGuest: guest,
    );
    api.purpose = guest ? 'claim' : 'authenticate';
    controller = GoogleAuthController(
      api: api,
      gateway: gateway,
      pendingStore: store,
      challengeGateway: securityGateway,
      now: now,
      identity: () => identity,
      identityMatches: (_) => identityCurrent,
      admitSession: (result, before, isCurrent) async {
        expect(isCurrent(), isTrue);
        expect(result.session.accessToken, 'final-fuze-fixture');
        admissions++;
        return true;
      },
      admitClaim: (before, isCurrent) async {
        if (claimRead != null) return claimRead!();
        if (claimReadFailure != null) throw claimReadFailure!;
        expect(before.userId, 'guest-fixture');
        expect(before.accessToken, 'guest-bearer-fixture');
        return isCurrent() && claimed;
      },
    );
  }
  final api = _Api();
  final gateway = _Gateway();
  final store = _Store();
  final securityGateway = _SecurityGateway();
  late final GoogleAuthController controller;
  bool claimed = false;
  bool identityCurrent = true;
  Object? claimReadFailure;
  Future<bool> Function()? claimRead;
  int admissions = 0;
  void close() => controller.dispose();
}

class _Store implements GooglePendingAuthStore {
  String? payload;
  bool failWrite = false;
  int? failWriteNumber;
  int writeCalls = 0;
  bool failClear = false;
  final writes = <String>[];
  @override
  Future<String?> readPendingAuthentication() async => payload;
  @override
  Future<void> writePendingAuthentication(String value) async {
    writeCalls++;
    if (failWrite || writeCalls == failWriteNumber) {
      throw GoogleCredentialException('secure_storage_failed');
    }
    writes.add(value);
    payload = value;
  }

  @override
  Future<void> clearPendingAuthentication() async {
    if (failClear) throw GoogleCredentialException('secure_storage_failed');
    payload = null;
  }
}

class _Gateway implements GoogleCredentialGateway {
  bool supported = true;
  int capabilityCalls = 0;
  int selections = 0;
  String? nonce;
  String? clientId;
  void Function()? beforeSelection;
  Future<GoogleCredentialResult>? selection;
  @override
  Future<GoogleCredentialCapabilities> getCapabilities() async {
    capabilityCalls++;
    return GoogleCredentialCapabilities(supported: supported);
  }

  @override
  Future<GoogleCredentialResult> signIn({
    required String requestId,
    required String serverClientId,
    required String nonce,
  }) async {
    this.nonce = nonce;
    clientId = serverClientId;
    beforeSelection?.call();
    selections++;
    return selection ??
        GoogleCredentialResult(
          requestId: requestId,
          idToken: 'google-jwt-fixture',
        );
  }

  @override
  Future<void> cancelSignIn({required String requestId}) async {}
  @override
  Future<void> clearCredentialState() async {}
}

class _Api implements GoogleAuthApiRepository {
  String purpose = 'authenticate';
  int created = 0;
  int registrations = 0;
  int claims = 0;
  int cancellations = 0;
  int contextReads = 0;
  int linkCalls = 0;
  int emailRequests = 0;
  String? continuationStatus;
  String? challengeToken;
  String? cancelChallengeId;
  String? inspectedTicket;
  final credentials = <String>[];
  final challengeTokens = <String?>[];
  Object? verifyFailure;
  Object? registrationFailure;
  Object? claimFailure;
  Object? cancelFailure;
  Object? linkFailure;
  GoogleAuthResult? verifyResult;
  Future<GoogleAuthResult>? verifyResponse;
  Future<GoogleAuthChallenge>? challengeResponse;
  @override
  Future<GoogleBrowserContext> createGoogleBrowserContext({
    String? token,
    String? browserContextToken,
  }) async => _browser;
  @override
  Future<GoogleAuthChallenge> createGoogleChallenge({
    required GoogleBrowserContext browserContext,
    required String purpose,
    String? token,
  }) async {
    created++;
    challengeToken = token;
    return challengeResponse ?? _challenge;
  }

  @override
  Future<GoogleAuthResult> verifyGoogleCredential({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String challengeId,
    required String credential,
  }) async {
    credentials.add(credential);
    if (verifyFailure != null) throw verifyFailure!;
    return verifyResponse ??
        verifyResult ??
        GoogleContinuationResult(
          status:
              continuationStatus ??
              (purpose == 'claim'
                  ? 'guest_claim_required'
                  : 'registration_required'),
          contextToken: 'rotated-ticket-fixture',
          expiresAt: _expiry,
        );
  }

  @override
  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    contextReads++;
    inspectedTicket = contextToken;
    return GoogleAuthContext(
      status:
          continuationStatus ??
          (purpose == 'claim'
              ? 'guest_claim_required'
              : 'registration_required'),
      purpose: purpose,
      expiresAt: _expiry,
      email: 'identity@example.test',
    );
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
    registrations++;
    challengeTokens.add(turnstileToken);
    if (registrationFailure != null) throw registrationFailure!;
    return _authenticated;
  }

  @override
  Future<GoogleGuestClaimResult> claimGuestWithGoogle({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
    String? turnstileToken,
  }) async {
    claims++;
    challengeTokens.add(turnstileToken);
    if (claimFailure != null) throw claimFailure!;
    return const GoogleGuestClaimResult(
      userId: 'guest-fixture',
      identityKind: 'registered',
      emailVerified: true,
      verificationEmailSent: false,
    );
  }

  @override
  Future<void> cancelGoogleAuth({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    String? challengeId,
  }) async {
    cancellations++;
    cancelChallengeId = challengeId;
    if (cancelFailure != null) throw cancelFailure!;
  }

  @override
  Future<GoogleAuthenticatedResult> linkGoogleWithPassword({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String currentPassword,
  }) async {
    linkCalls++;
    if (linkFailure != null) throw linkFailure!;
    return _authenticated;
  }

  @override
  Future<GoogleAuthenticatedResult> confirmGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String code,
  }) async {
    linkCalls++;
    if (linkFailure != null) throw linkFailure!;
    return _authenticated;
  }

  @override
  Future<void> requestGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    emailRequests++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _SecurityGateway implements SecurityChallengeGateway {
  final requestIds = <String>[];
  final cancelled = <String>[];
  Future<SecurityChallengeResult> Function(String)? action;
  @override
  Future<SecurityChallengeResult> solve({
    required String requestId,
    required String title,
    required String cancelLabel,
  }) async {
    requestIds.add(requestId);
    return action != null
        ? action!(requestId)
        : SecurityChallengeResult(
            requestId: requestId,
            token: 'security-proof-fixture',
          );
  }

  @override
  Future<void> cancel({required String requestId}) async {
    cancelled.add(requestId);
  }
}

// Regressions adapted from reaudit-20261028/checks/08; no live provider.
void _claimRetryCorrectionTests() {
  group('claim retry correction 2026-10-28', () {
    for (final readFailure in <ApiFailure>[
      const ApiNetworkException(code: 'network_timeout'),
      const ApiException(statusCode: 401, errorCode: 'unauthorized'),
    ]) {
      test(
        'claim429 survives ${readFailure.code} reconciliation and blocks until exact expiry',
        () async {
          var now = DateTime.utc(2026, 10, 28, 12);
          final h = _Harness(guest: true, now: () => now);
          addTearDown(h.close);
          await h.controller.begin(GoogleAuthPurpose.claim);
          h.api.claimFailure = const ApiException(
            statusCode: 429,
            errorCode: 'rate_limited',
            retryAfterSeconds: 120,
          );
          h.claimReadFailure = readFailure;
          Future<void> submit() => h.controller.completeProfile(
            countryCode: 'FR',
            termsAccepted: true,
            privacyAccepted: true,
          );
          await submit();
          final deadline = now.add(const Duration(seconds: 120));
          expect(h.controller.state.retryAfter, deadline);
          expect(h.controller.state.step, GoogleAuthStep.uncertain);
          expect(h.controller.state.messageKey, 'google.uncertain');
          h.claimReadFailure = null;
          await h.controller.resume();
          expect(h.controller.state.step, GoogleAuthStep.guestClaimRequired);
          await submit();
          expect(h.api.claims, 1);
          now = deadline.subtract(const Duration(microseconds: 1));
          await submit();
          expect(h.api.claims, 1);
          now = deadline;
          h.claimed = true;
          h.api.claimFailure = null;
          await submit();
          expect(h.api.claims, 2);
          expect(h.controller.state.step, GoogleAuthStep.authenticated);
          expect(h.controller.state.retryAfter, isNull);
          expect(h.store.payload, isNull);
        },
      );
    }

    for (final readThrows in [false, true]) {
      test(
        'claim429 deadline starts before a delayed reconciliation throws=$readThrows',
        () async {
          var now = DateTime.utc(2026, 10, 28, 12);
          final deadline = now.add(const Duration(seconds: 120));
          final h = _Harness(guest: true, now: () => now);
          addTearDown(h.close);
          await h.controller.begin(GoogleAuthPurpose.claim);
          h.api.claimFailure = const ApiException(
            statusCode: 429,
            errorCode: 'rate_limited',
            retryAfterSeconds: 120,
          );
          final entered = Completer<void>();
          final reply = Completer<bool>();
          h.claimRead = () {
            entered.complete();
            return reply.future;
          };
          final submitting = h.controller.completeProfile(
            countryCode: 'FR',
            termsAccepted: true,
            privacyAccepted: true,
          );
          await entered.future;
          now = now.add(const Duration(seconds: 30));
          if (readThrows) {
            reply.completeError(
              const ApiNetworkException(code: 'network_timeout'),
            );
          } else {
            reply.complete(false);
          }
          await submitting;
          expect(h.controller.state.retryAfter, deadline);
          expect(
            h.controller.state.messageKey,
            readThrows ? 'google.uncertain' : 'google.rateLimited',
          );
          expect(h.api.claims, 1);
        },
      );
    }

    // H-RA-A08-01-03: each order is pinned, so a "last deadline wins" rule
    // fails at least one of these cases.
    for (final (first, second) in [(120, 10), (10, 120), (120, 120)]) {
      test(
        'claim429 $first s then reconciliation 429 $second s keeps the longest deadline',
        () async {
          var now = DateTime.utc(2026, 10, 28, 12);
          final h = _Harness(guest: true, now: () => now);
          addTearDown(h.close);
          await h.controller.begin(GoogleAuthPurpose.claim);
          h.api.claimFailure = ApiException(
            statusCode: 429,
            errorCode: 'rate_limited',
            retryAfterSeconds: first,
          );
          h.claimReadFailure = ApiException(
            statusCode: 429,
            errorCode: 'rate_limited',
            retryAfterSeconds: second,
          );
          Future<void> submit() => h.controller.completeProfile(
            countryCode: 'FR',
            termsAccepted: true,
            privacyAccepted: true,
          );
          await submit();
          final shorter = now.add(Duration(seconds: min(first, second)));
          final longest = now.add(Duration(seconds: max(first, second)));
          expect(h.controller.state.retryAfter, longest);
          h.claimReadFailure = null;
          await h.controller.resume();
          expect(h.controller.state.retryAfter, longest);
          now = shorter;
          if (shorter != longest) {
            await submit();
            expect(h.api.claims, 1);
            now = longest.subtract(const Duration(microseconds: 1));
            await submit();
            expect(h.api.claims, 1);
          }
          now = longest;
          h.claimed = true;
          h.api.claimFailure = null;
          await submit();
          expect(h.api.claims, 2);
          expect(h.controller.state.step, GoogleAuthStep.authenticated);
        },
      );
    }

    test(
      'a longer reconciliation RetryAfter extends the original deadline',
      () async {
        final now = DateTime.utc(2026, 10, 28, 12);
        final h = _Harness(guest: true, now: () => now);
        addTearDown(h.close);
        await h.controller.begin(GoogleAuthPurpose.claim);
        h.api.claimFailure = const ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 120,
        );
        h.claimReadFailure = const ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 300,
        );
        await h.controller.completeProfile(
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );
        expect(
          h.controller.state.retryAfter,
          now.add(const Duration(seconds: 300)),
        );
      },
    );

    test(
      'successful reconciliation still recovers a claim despite its failed response',
      () async {
        final now = DateTime.utc(2026, 10, 28, 12);
        final h = _Harness(guest: true, now: () => now);
        addTearDown(h.close);
        await h.controller.begin(GoogleAuthPurpose.claim);
        h.api.claimFailure = const ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 120,
        );
        h.claimed = true;
        await h.controller.completeProfile(
          countryCode: 'FR',
          termsAccepted: true,
          privacyAccepted: true,
        );
        expect(h.api.claims, 1);
        expect(h.controller.state.step, GoogleAuthStep.authenticated);
        expect(h.controller.state.retryAfter, isNull);
        expect(h.store.payload, isNull);
        expect(h.admissions, 0);
      },
    );
  });
}
