// Corrections du 29/10/2026 — C5-…-04 au niveau GoogleAuthController.
// Frontières réelles : GoogleAuthController, ApiClient (jsonDecode,
// ApiException.fromResponse, erreurs Google connues). Seuls le transport HTTP,
// Credential Manager et le stockage chiffré sont simulés. Un 429 de
// finalisation dont Retry-After est une HTTP-date ou dépasse 86 400 s doit
// poser la garde A04-02 : aucune seconde finalisation à horloge inchangée.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';
import 'package:fuzevpn_android/core/security_challenge.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';

const _expiry = '2099-01-01T00:00:00Z';
const _noStore = <String, String>{'cache-control': 'no-store'};

ApiHttpResponse _json(
  int status,
  Object body, [
  Map<String, String> headers = _noStore,
]) => ApiHttpResponse(
  statusCode: status,
  headers: headers,
  body: jsonEncode(body),
);

class _GoogleTransport extends ApiHttpTransport {
  _GoogleTransport(this.registerReply);

  final ApiHttpResponse Function() registerReply;
  final List<String> calls = <String>[];

  int count(String call) => calls.where((value) => value == call).length;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    final path = request.uri.path;
    calls.add('${request.method} $path');
    return switch (path) {
      '/v1/auth/browser/context' => _json(200, {
        'browser_context_token': 'browser-fixture',
        'auth_generation': 1,
        'expires_at': _expiry,
      }),
      '/v1/auth/google/challenge' => _json(201, {
        'challenge_id': 'challenge-fixture',
        'nonce': 'nonce-fixture',
        'context_token': 'challenge-ticket',
        'expires_at': _expiry,
      }),
      '/v1/auth/google/verify' => _json(200, {
        'status': 'registration_required',
        'context_token': 'continuation-ticket',
        'expires_at': _expiry,
      }),
      '/v1/auth/google/context' => _json(200, {
        'status': 'registration_required',
        'purpose': 'authenticate',
        'expires_at': _expiry,
        'email': 'fixture@example.invalid',
      }),
      '/v1/auth/google/register' => registerReply(),
      '/v1/auth/google/cancel' => ApiHttpResponse(
        statusCode: 204,
        headers: _noStore,
        body: '',
      ),
      _ => throw StateError('unexpected route'),
    };
  }
}

class _Gateway implements GoogleCredentialGateway, GooglePendingAuthStore {
  String? payload;

  @override
  Future<GoogleCredentialCapabilities> getCapabilities() async =>
      const GoogleCredentialCapabilities(supported: true);

  @override
  Future<GoogleCredentialResult> signIn({
    required String requestId,
    required String serverClientId,
    required String nonce,
  }) async =>
      GoogleCredentialResult(requestId: requestId, idToken: 'id-fixture');

  @override
  Future<void> cancelSignIn({required String requestId}) async {}

  @override
  Future<void> clearCredentialState() async {}

  @override
  Future<String?> readPendingAuthentication() async => payload;

  @override
  Future<void> writePendingAuthentication(String value) async =>
      payload = value;

  @override
  Future<void> clearPendingAuthentication() async => payload = null;
}

class _NoChallenge implements SecurityChallengeGateway {
  @override
  Future<SecurityChallengeResult> solve({
    required String requestId,
    required String title,
    required String cancelLabel,
  }) async => throw SecurityChallengeException('unavailable');

  @override
  Future<void> cancel({required String requestId}) async {}
}

void main() {
  final serverNow = DateTime.utc(2026, 10, 29, 12);
  final serverDate = HttpDate.format(serverNow);
  // Device clock deliberately differs from the server Date by three hours.
  var now = DateTime.utc(2026, 10, 29, 15);

  final cases = <String, (Map<String, String>, Object?, Duration)>{
    'IMF-fixdate Retry-After (+120 s)': (
      {
        'retry-after': HttpDate.format(
          serverNow.add(const Duration(seconds: 120)),
        ),
        'date': serverDate,
      },
      null,
      const Duration(seconds: 120),
    ),
    'Retry-After 86401': ({'retry-after': '86401'}, null, Duration(days: 1)),
    'Retry-After 999999': ({'retry-after': '999999'}, null, Duration(days: 1)),
    'body retry_after_seconds 172800': (
      const {},
      172800,
      const Duration(days: 1),
    ),
    'duplicated Retry-After 120,120': (
      {'retry-after': '120,120'},
      null,
      const Duration(seconds: 120),
    ),
    'witness Retry-After 120': (
      {'retry-after': '120'},
      null,
      const Duration(seconds: 120),
    ),
  };

  for (final entry in cases.entries) {
    test('429 register with ${entry.key} blocks finalization', () async {
      now = DateTime.utc(2026, 10, 29, 15);
      final (headers, body, guard) = entry.value;
      final transport = _GoogleTransport(
        () => _json(429, {
          'error': 'rate_limited',
          if (body != null) 'retry_after_seconds': body,
        }, headers),
      );
      final gateway = _Gateway();
      final auth = GoogleAuthController(
        api: ApiClient(
          baseUri: Uri.parse('https://api.example.invalid/'),
          transport: transport,
        ),
        gateway: gateway,
        pendingStore: gateway,
        identity: () => const GoogleIdentitySnapshot(),
        identityMatches: (_) => true,
        canBegin: (_) => true,
        admitSession: (_, _, _) async => false,
        now: () => now,
        challengeGateway: _NoChallenge(),
      );
      addTearDown(auth.dispose);

      await auth.begin(GoogleAuthPurpose.authenticate);
      expect(auth.state.step, GoogleAuthStep.registrationRequired);
      Future<void> submit() => auth.completeProfile(
        countryCode: 'FR',
        termsAccepted: true,
        privacyAccepted: true,
      );

      await submit();
      expect(auth.state.retryAfter, now.add(guard));
      expect(auth.state.messageKey, 'google.rateLimited');
      await submit(); // Same clock: the guard must hold.
      expect(transport.count('POST /v1/auth/google/register'), 1);

      now = now.add(guard - const Duration(seconds: 1));
      await submit();
      expect(transport.count('POST /v1/auth/google/register'), 1);

      now = now.add(const Duration(seconds: 1));
      await submit(); // The guard expires exactly at the server deadline.
      expect(transport.count('POST /v1/auth/google/register'), 2);
    });
  }

  // Review round 2: without a Date header, an HTTP-date is measured against
  // the device clock, which is also the controller clock in production.
  test('429 register with an IMF-fixdate and no Date header blocks '
      'finalization on the production clock', () async {
    final transport = _GoogleTransport(
      () => _json(
        429,
        {'error': 'rate_limited'},
        {
          'retry-after': HttpDate.format(
            DateTime.now().toUtc().add(const Duration(seconds: 120)),
          ),
        },
      ),
    );
    final gateway = _Gateway();
    final auth = GoogleAuthController(
      api: ApiClient(
        baseUri: Uri.parse('https://api.example.invalid/'),
        transport: transport,
      ),
      gateway: gateway,
      pendingStore: gateway,
      identity: () => const GoogleIdentitySnapshot(),
      identityMatches: (_) => true,
      canBegin: (_) => true,
      admitSession: (_, _, _) async => false,
      challengeGateway: _NoChallenge(),
    );
    addTearDown(auth.dispose);

    await auth.begin(GoogleAuthPurpose.authenticate);
    expect(auth.state.step, GoogleAuthStep.registrationRequired);
    Future<void> submit() => auth.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );

    final before = DateTime.now();
    await submit();
    final retryAfter = auth.state.retryAfter;
    expect(retryAfter, isNotNull);
    expect(
      retryAfter!.difference(before).inSeconds,
      inInclusiveRange(118, 121),
    );
    expect(auth.state.messageKey, 'google.rateLimited');
    await submit();
    expect(transport.count('POST /v1/auth/google/register'), 1);
  });
}
