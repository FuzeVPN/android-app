import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

final _browser = GoogleBrowserContext(
  browserContextToken: 'bct-fixture-private',
  authGeneration: 7,
  expiresAt: DateTime.utc(2099),
);
const _ticket = 'gct-fixture-private';
const _authenticated = <String, Object?>{
  'status': 'authenticated',
  'access_token': 'fuze-fixture-private',
  'expires_at': '2099-01-01T00:00:00Z',
};
const _browserJson = <String, Object?>{
  'browser_context_token': 'bct-fixture-private',
  'auth_generation': 7,
  'expires_at': '2099-01-01T00:00:00Z',
};
const _challenge = <String, Object?>{
  'challenge_id': 'challenge-fixture',
  'nonce': 'nonce-fixture',
  'context_token': _ticket,
  'expires_at': '2099-01-01T00:00:00Z',
};
const _claim = <String, Object?>{
  'status': 'authenticated',
  'user_id': 'guest-fixture',
  'identity_kind': 'registered',
  'email_verified': true,
  'verification_email_sent': false,
};
const _context = <String, Object?>{
  'status': 'link_required',
  'purpose': 'authenticate',
  'email': 'fixture@example.test',
  'expires_at': '2099-01-01T00:00:00Z',
};

class _Transport extends ApiHttpTransport {
  int statusCode = 201;
  Object response = _authenticated;
  Map<String, String> headers = <String, String>{
    'cache-control': 'private, no-store',
  };
  final requests = <ApiHttpRequest>[];
  ApiHttpRequest get request => requests.last;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest value) async {
    requests.add(value);
    return ApiHttpResponse(
      statusCode: statusCode,
      headers: headers,
      body: statusCode == 204 ? '' : jsonEncode(response),
    );
  }
}

Future<dynamic> _call(String name, ApiClient api) => switch (name) {
  'browser' => api.createGoogleBrowserContext(),
  'challenge' => api.createGoogleChallenge(
    browserContext: _browser,
    purpose: 'authenticate',
  ),
  'verify' => api.verifyGoogleCredential(
    browserContext: _browser,
    contextToken: _ticket,
    challengeId: 'challenge-fixture',
    credential: 'jwt-fixture-private',
  ),
  'context' => api.getGoogleContext(
    browserContext: _browser,
    contextToken: _ticket,
  ),
  'register' => api.registerGoogleAccount(
    browserContext: _browser,
    contextToken: _ticket,
    countryCode: 'BE',
    termsAccepted: true,
    privacyAccepted: true,
  ),
  'claim' => api.claimGuestWithGoogle(
    browserContext: _browser,
    contextToken: _ticket,
    countryCode: 'BE',
    termsAccepted: true,
    privacyAccepted: true,
  ),
  'link' => api.linkGoogleWithPassword(
    browserContext: _browser,
    contextToken: _ticket,
    currentPassword: 'password-fixture-private',
  ),
  'email-request' => api.requestGoogleLinkEmail(
    browserContext: _browser,
    contextToken: _ticket,
  ),
  'email-confirm' => api.confirmGoogleLinkEmail(
    browserContext: _browser,
    contextToken: _ticket,
    code: 'ABCD-EFGH-IJKL-MNOP',
  ),
  'cancel' => api.cancelGoogleAuth(
    browserContext: _browser,
    contextToken: _ticket,
  ),
  'login' => api.loginWithAuthContext(
    browserContext: _browser,
    email: 'fixture@example.test',
    password: 'password-fixture-private',
  ),
  _ => throw StateError('unknown_fixture_route'),
};

void main() {
  test('browser context reserves an anonymous or bound attempt with no secret URL',
      () async {
    final transport = _Transport()
      ..statusCode = 200
      ..response = _browserJson;
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    final result = await api.createGoogleBrowserContext();
    expect(result.authGeneration, 7);
    expect(transport.request.uri.path, '/v1/auth/browser/context');
    expect(transport.request.uri.query, isEmpty);
    expect(jsonDecode(transport.request.body!), isEmpty);
    expect(transport.request.headers['authorization'], isNull);
    expect(transport.request.headers['x-fuze-browser-context'], isNull);

    await api.createGoogleBrowserContext(
      token: 'guest-fixture-private',
      browserContextToken: _browser.browserContextToken,
    );
    expect(transport.request.headers['authorization'], 'Bearer guest-fixture-private');
    expect(transport.request.headers['x-fuze-browser-context'], 'bct-fixture-private');
    expect(transport.request.headers['x-fuze-auth-generation'], isNull);
  });

  test('challenge purpose controls bearer and carries the reserved generation',
      () async {
    final transport = _Transport()..response = _challenge;
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    for (final purpose in googleAuthPurposes) {
      final result = await api.createGoogleChallenge(
        browserContext: _browser,
        purpose: purpose,
        token: purpose == 'authenticate' ? null : 'principal-fixture-private',
      );
      expect(result.nonce, 'nonce-fixture');
      expect(jsonDecode(transport.request.body!), {'purpose': purpose});
      expect(transport.request.headers['x-fuze-auth-generation'], '7');
      expect(transport.request.headers['x-fuze-browser-context'], _browser.browserContextToken);
      expect(transport.request.headers['authorization'],
          purpose == 'authenticate' ? null : 'Bearer principal-fixture-private');
    }
    final count = transport.requests.length;
    for (final purpose in ['delete', 'claim', 'link']) {
      await expectLater(
        api.createGoogleChallenge(browserContext: _browser, purpose: purpose),
        throwsA(isA<ApiProtocolException>()),
      );
    }
    expect(transport.requests, hasLength(count));
  });

  test('verify keeps challenge and native credential in POST and separates tickets',
      () async {
    final transport = _Transport();
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    final authenticated = await _call('verify', api);
    expect(authenticated, isA<GoogleAuthenticatedResult>());
    expect((authenticated as GoogleAuthenticatedResult).session.accessToken,
        'fuze-fixture-private');
    expect(transport.request.headers['authorization'], 'Bearer $_ticket');
    expect(transport.request.uri.query, isEmpty);
    expect(jsonDecode(transport.request.body!), {
      'challenge_id': 'challenge-fixture',
      'credential': 'jwt-fixture-private',
    });
    for (final status in [
      'registration_required', 'link_required', 'guest_claim_required',
    ]) {
      transport.statusCode = 200;
      transport.response = {
        'status': status,
        'context_token': 'replacement-fixture-private',
        'expires_at': '2099-01-01T00:00:00Z',
      };
      final continuation = await _call('verify', api) as GoogleContinuationResult;
      expect(continuation.status, status);
      expect(continuation.contextToken, 'replacement-fixture-private');
      expect(continuation, isNot(isA<GoogleAuthenticatedResult>()));
    }
  });

  test('verify refuses a success status paired with another HTTP outcome', () async {
    final transport = _Transport();
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    for (final fixture in [
      (200, _authenticated),
      (201, <String, Object?>{
        'status': 'registration_required', 'context_token': _ticket,
        'expires_at': '2099-01-01T00:00:00Z',
      }),
      (200, <String, Object?>{
        'status': 'reauthenticated', 'reauth_token': 'proof-fixture-private',
        'expires_at': '2099-01-01T00:00:00Z',
      }),
    ]) {
      transport.statusCode = fixture.$1;
      transport.response = fixture.$2;
      await expectLater(_call('verify', api), throwsA(isA<ApiProtocolException>()));
    }
  });

  test('Google finalization sends country and deliberate consent, never a password',
      () async {
    final transport = _Transport();
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    await _call('register', api);
    expect(transport.request.uri.path, '/v1/auth/google/register');
    expect(jsonDecode(transport.request.body!), {
      'country_code': 'BE', 'terms_accepted': true, 'privacy_accepted': true,
    });
    transport.statusCode = 200;
    transport.response = _claim;
    final claimed = await _call('claim', api) as GoogleGuestClaimResult;
    expect(claimed.userId, 'guest-fixture');
    expect(claimed.identityKind, 'registered');
    expect(claimed.emailVerified, isTrue);
    expect(transport.request.uri.path, '/v1/auth/google/claim');
    expect(transport.request.headers['authorization'], 'Bearer $_ticket');
    expect(jsonDecode(transport.request.body!), {
      'country_code': 'BE', 'terms_accepted': true, 'privacy_accepted': true,
    });
    for (final key in ['access_token', 'expires_at']) {
      transport.response = {..._claim, key: 'unexpected-fixture-private'};
      await expectLater(_call('claim', api), throwsA(isA<ApiProtocolException>()));
    }
    transport.response = Map<String, Object?>.from(_claim)
      ..remove('verification_email_sent');
    final optionalEmail = await _call('claim', api) as GoogleGuestClaimResult;
    expect(optionalEmail.emailVerified, isTrue);
    expect(optionalEmail.verificationEmailSent, isNull);
  });

  test('context resumes the screen without replaying a credential', () async {
    final transport = _Transport()
      ..statusCode = 200
      ..response = _context;
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    final result = await _call('context', api) as GoogleAuthContext;
    expect(result.email, 'fixture@example.test');
    expect(result.firstName, isEmpty);
    expect(result.lastName, isEmpty);
    expect(result.emailVerified, isNull);
    transport.response = {..._context, 'email_verified': true};
    final verified = await _call('context', api) as GoogleAuthContext;
    expect(verified.emailVerified, isTrue);
    expect(transport.request.method, 'GET');
    expect(transport.request.body, isNull);
    expect(transport.request.uri.query, isEmpty);
  });

  test('explicit linking proofs and cancellation stay scoped to the same ticket',
      () async {
    final transport = _Transport();
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    await _call('link', api);
    expect(jsonDecode(transport.request.body!), {'current_password': 'password-fixture-private'});
    transport.statusCode = 202;
    await _call('email-request', api);
    expect(jsonDecode(transport.request.body!), isEmpty);
    transport.statusCode = 201;
    await _call('email-confirm', api);
    expect(jsonDecode(transport.request.body!), {'code': 'ABCD-EFGH-IJKL-MNOP'});
    transport.statusCode = 204;
    await _call('cancel', api);
    expect(jsonDecode(transport.request.body!), isEmpty);
    await api.cancelGoogleAuth(
      browserContext: _browser,
      contextToken: _ticket,
      challengeId: 'challenge-fixture',
    );
    expect(jsonDecode(transport.request.body!), {'challenge_id': 'challenge-fixture'});
    expect(transport.request.headers['authorization'], 'Bearer $_ticket');
    expect(transport.request.headers['x-fuze-auth-generation'], '7');
  });

  test('classical contextual login leaves the old repository contract unchanged',
      () async {
    final transport = _Transport();
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    await _call('login', api);
    expect(transport.request.uri.path, '/v1/auth/login');
    expect(transport.request.headers['x-fuze-auth-generation'], '7');
    expect(jsonDecode(transport.request.body!), {
      'email': 'fixture@example.test', 'password': 'password-fixture-private',
    });
    await api.login(email: 'fixture@example.test', password: 'fixture');
    expect(transport.request.headers['x-fuze-auth-generation'], isNull);
    expect(transport.request.headers['x-fuze-browser-context'], isNull);
  });

  for (final endpoint in <(String, int, Object)>[
    ('browser', 200, _browserJson), ('challenge', 201, _challenge),
    ('verify', 201, _authenticated), ('context', 200, _context),
    ('register', 201, _authenticated), ('claim', 200, _claim),
    ('link', 201, _authenticated), ('email-request', 202, <String, Object?>{}),
    ('email-confirm', 201, _authenticated), ('cancel', 204, <String, Object?>{}),
    ('login', 201, _authenticated),
  ]) {
    test('${endpoint.$1} enforces its exact HTTP outcome and response no-store',
        () async {
      final transport = _Transport()
        ..statusCode = endpoint.$2
        ..response = endpoint.$3;
      final api = ApiClient(transport: transport);
      addTearDown(api.close);
      await _call(endpoint.$1, api);
      transport.headers = {'cache-control': 'public, max-age=600'};
      await expectLater(_call(endpoint.$1, api), throwsA(isA<ApiProtocolException>()));
      transport.headers = {'cache-control': 'no-store'};
      transport.statusCode = 203;
      await expectLater(_call(endpoint.$1, api), throwsA(isA<ApiException>()));
    });
  }

  test('closed public errors preserve retries and never expose provider details',
      () async {
    final transport = _Transport()..statusCode = 503
      ..response = {'error': 'google_unavailable', 'detail': 'private-provider-detail'}
      ..headers = {'retry-after': '60'};
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    await expectLater(_call('verify', api), throwsA(isA<ApiException>()
      .having((e) => e.code, 'code', 'google_unavailable')
      .having((e) => e.retryAfterSeconds, 'retry', 60)
      .having((e) => e.toString(), 'redacted', isNot(contains('private-provider-detail')))));
    transport.response = {'error': 'provider_private_secret'};
    await expectLater(_call('verify', api), throwsA(isA<ApiException>()
      .having((e) => e.code, 'unknown closed error', 'api_error')));
    for (final error in ['turnstile_required', 'turnstile_invalid', 'turnstile_unavailable']) {
      transport.statusCode = error == 'turnstile_unavailable' ? 503 : 403;
      transport.response = {'error': error};
      await expectLater(_call('claim', api), throwsA(isA<ApiException>()
        .having((e) => e.code, 'anti-abuse error retained', error)));
    }
  });

  test('untrusted context headers are rejected before transport', () async {
    final transport = _Transport()..response = _challenge;
    final api = ApiClient(transport: transport);
    addTearDown(api.close);
    await expectLater(api.createGoogleChallenge(
      browserContext: GoogleBrowserContext(
        browserContextToken: 'fixture\r\nInjected: private', authGeneration: 1,
        expiresAt: DateTime.utc(2099),
      ),
      purpose: 'authenticate',
    ), throwsA(isA<ApiProtocolException>()));
    expect(transport.requests, isEmpty);
  });

  test('all Google DTO diagnostics omit tickets, sessions, proofs and identity', () {
    final values = <Object>[
      GoogleBrowserContext.fromJson(Map<String, dynamic>.from(_browserJson)),
      GoogleAuthChallenge.fromJson(Map<String, dynamic>.from(_challenge)),
      GoogleAuthenticatedResult.fromJson(Map<String, dynamic>.from(_authenticated)),
      GoogleContinuationResult.fromJson({
        'status': 'registration_required', 'context_token': _ticket,
        'expires_at': '2099-01-01T00:00:00Z',
      }),
      GoogleAuthContext.fromJson(Map<String, dynamic>.from(_context)),
      GoogleGuestClaimResult.fromJson(Map<String, dynamic>.from(_claim)),
    ];
    for (final value in values) {
      final diagnostic = value.toString();
      expect(diagnostic, contains('redacted: true'));
      for (final secret in [
        _ticket, 'bct-fixture-private', 'fuze-fixture-private',
        'fixture@example.test', 'guest-fixture',
      ]) {
        expect(diagnostic, isNot(contains(secret)));
      }
    }
  });

  test('malformed and combined Google outcomes cannot become sessions', () {
    for (final invalid in <Map<String, dynamic>>[
      {..._authenticated, 'context_token': _ticket},
      {..._authenticated, 'email_verified': 'true'},
      {..._authenticated, 'verification_email_sent': null},
      {..._authenticated, 'identity_kind': 'guest'},
      {..._authenticated, 'expires_at': 'invalid'},
    ]) {
      expect(() => GoogleAuthenticatedResult.fromJson(invalid), throwsFormatException);
    }
    for (final generation in <Object?>[null, '1', 1.5, 0, -1]) {
      expect(() => GoogleBrowserContext.fromJson({
        ..._browserJson, 'auth_generation': generation,
      }), throwsFormatException);
    }
    expect(() => GoogleContinuationResult.fromJson({
      'status': 'guest_claim_required', 'context_token': _ticket,
      'expires_at': '2099-01-01T00:00:00Z', 'access_token': 'unsafe',
    }), throwsFormatException);
    expect(() => GoogleAuthContext.fromJson({..._context, 'purpose': 'delete'}),
        throwsFormatException);
    expect(() => GoogleAuthContext.fromJson({..._context, 'email_verified': 'true'}),
        throwsFormatException);
    expect(() => GoogleGuestClaimResult.fromJson({..._claim, 'email_verified': null}),
        throwsFormatException);
  });
}
