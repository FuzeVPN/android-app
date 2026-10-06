import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/google_auth.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';
import 'package:fuzevpn_android/core/models.dart';
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
    'Turnstile refusal preserves profile form, context and guest access',
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
      expect(h.controller.state.step, GoogleAuthStep.registrationRequired);
      expect(h.controller.state.messageKey, 'google.challengeRequired');
      expect(h.store.payload, isNotNull);
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
}

Future<void> _until(bool Function() ready) async {
  for (var i = 0; i < 30 && !ready(); i++) {
    await Future<void>.delayed(Duration.zero);
  }
  expect(ready(), isTrue);
}

class _Harness {
  _Harness({bool guest = false}) {
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
      identity: () => identity,
      identityMatches: (_) => true,
      admitSession: (result, before, isCurrent) async {
        expect(isCurrent(), isTrue);
        expect(result.session.accessToken, 'final-fuze-fixture');
        admissions++;
        return true;
      },
      admitClaim: (before, isCurrent) async {
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
  late final GoogleAuthController controller;
  bool claimed = false;
  Object? claimReadFailure;
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
  String? challengeToken;
  String? cancelChallengeId;
  String? inspectedTicket;
  final credentials = <String>[];
  Object? verifyFailure;
  Object? registrationFailure;
  Object? claimFailure;
  Object? cancelFailure;
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
          status: purpose == 'claim'
              ? 'guest_claim_required'
              : 'registration_required',
          contextToken: 'rotated-ticket-fixture',
          expiresAt: _expiry,
        );
  }

  @override
  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    inspectedTicket = contextToken;
    return GoogleAuthContext(
      status: purpose == 'claim'
          ? 'guest_claim_required'
          : 'registration_required',
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
  }) async {
    registrations++;
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
  }) async {
    claims++;
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
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
