import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'api_exception.dart';
import 'connection_timing.dart';
import 'google_auth.dart';
import 'guest_accounts.dart';
import 'hedged_http_open.dart';
import 'models.dart';
import 'play_billing.dart';
import 'repositories.dart';

export 'api_exception.dart';
export 'google_auth.dart';
export 'guest_accounts.dart';
export 'models.dart';
export 'repositories.dart';

/// A small injectable HTTP request type so API tests do not need a live server
/// or an additional package.
class ApiHttpRequest {
  ApiHttpRequest({
    required this.method,
    required this.uri,
    required Map<String, String> headers,
    this.body,
  }) : headers = Map<String, String>.unmodifiable(headers);

  final String method;
  final Uri uri;
  final Map<String, String> headers;
  final String? body;
}

/// A fully read HTTP response. Its body must only be used by [ApiClient] while
/// parsing a documented public response shape; it is never placed in errors.
class ApiHttpResponse {
  ApiHttpResponse({
    required this.statusCode,
    required Map<String, String> headers,
    required this.body,
  }) : headers = Map<String, String>.unmodifiable(
         headers.map(
           (String key, String value) =>
               MapEntry<String, String>(key.toLowerCase(), value),
         ),
       );

  final int statusCode;
  final Map<String, String> headers;
  final String body;

  String? header(String name) => headers[name.toLowerCase()];
}

/// Injectable transport. Its implementation must never log request bodies or
/// response bodies because they can carry sessions and VPN activation material.
abstract class ApiHttpTransport {
  Future<ApiHttpResponse> send(ApiHttpRequest request);

  void close() {}
}

/// Dart IO transport used on Android. No third-party HTTP library is required.
class IoApiHttpTransport extends ApiHttpTransport {
  IoApiHttpTransport({
    HttpClient? client,
    this.requestTimeout = const Duration(seconds: 20),
    HedgedHttpOpen? opener,
  }) : _client = client ?? HttpClient(),
       _opener = opener ?? const HedgedHttpOpen();

  static const int _maximumResponseBytes = 1024 * 1024;

  final HttpClient _client;
  final HedgedHttpOpen _opener;
  final Duration requestTimeout;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    final Stopwatch elapsed = Stopwatch()..start();
    HttpClientRequest? selectedRequest;
    StreamIterator<List<int>>? responseBody;
    var expired = false;

    bool deadlineReached() => expired || elapsed.elapsed >= requestTimeout;

    void checkDeadline() {
      if (deadlineReached()) {
        expired = true;
        throw TimeoutException('HTTP request deadline exceeded');
      }
    }

    void cancelPending() {
      try {
        selectedRequest?.abort();
      } catch (_) {
        // Cleanup must not replace the public failure.
      }
      final StreamIterator<List<int>>? iterator = responseBody;
      responseBody = null;
      if (iterator != null) {
        // abort() cannot stop a body once the response headers have arrived.
        // Observe cleanup errors without extending the request deadline.
        unawaited(iterator.cancel().then<void>((_) {}, onError: (Object _) {}));
      }
    }

    Future<ApiHttpResponse> perform() async {
      var succeeded = false;
      try {
        checkDeadline();
        final HttpClientRequest outgoing = await ConnectionTiming.measure(
          'http.open',
          () => _opener.open<HttpClientRequest>(
            primary: () => _client.openUrl(request.method, request.uri),
            alternate: () => _client.openUrl(request.method, request.uri),
            abort: (HttpClientRequest pending) => pending.abort(),
            timeout: requestTimeout - elapsed.elapsed,
          ),
        );
        selectedRequest = outgoing;
        // A late connection must never send headers or a business request.
        checkDeadline();
        request.headers.forEach((String name, String value) {
          outgoing.headers.set(name, value);
        });
        final String? body = request.body;
        if (body != null) {
          outgoing.add(utf8.encode(body));
        }
        checkDeadline();
        final HttpClientResponse incoming = await ConnectionTiming.measure(
          'http.response',
          outgoing.close,
        );
        ConnectionTiming.event('http.response', status: incoming.statusCode);
        final List<int> bytes = await ConnectionTiming.measure(
          'http.body',
          () async {
            final StreamIterator<List<int>> iterator = StreamIterator(incoming);
            responseBody = iterator;
            // Start listening even if headers arrive after expiration so cancel
            // also releases that late response stream.
            final Future<bool> firstChunk = iterator.moveNext();
            if (deadlineReached()) {
              expired = true;
              cancelPending();
            }
            final List<int> received = <int>[];
            var length = 0;
            var hasChunk = await firstChunk;
            while (hasChunk) {
              checkDeadline();
              final List<int> chunk = iterator.current;
              length += chunk.length;
              if (length > _maximumResponseBytes) {
                throw const ApiProtocolException(code: 'invalid_api_response');
              }
              received.addAll(chunk);
              hasChunk = await iterator.moveNext();
            }
            checkDeadline();
            return received;
          },
        );
        final Map<String, String> headers = <String, String>{};
        incoming.headers.forEach((String name, List<String> values) {
          headers[name] = values.join(',');
        });
        final ApiHttpResponse response = ApiHttpResponse(
          statusCode: incoming.statusCode,
          headers: headers,
          body: utf8.decode(bytes),
        );
        checkDeadline();
        succeeded = true;
        return response;
      } finally {
        if (!succeeded) cancelPending();
      }
    }

    try {
      return await perform().timeout(
        requestTimeout - elapsed.elapsed,
        onTimeout: () {
          expired = true;
          cancelPending();
          throw TimeoutException('HTTP request deadline exceeded');
        },
      );
    } on ApiFailure {
      rethrow;
    } on TimeoutException {
      throw const ApiNetworkException(code: 'network_timeout');
    } on SocketException {
      throw const ApiNetworkException();
    } on HttpException {
      throw const ApiNetworkException();
    } on IOException {
      throw const ApiNetworkException();
    } on FormatException {
      throw const ApiProtocolException();
    } catch (_) {
      throw const ApiNetworkException();
    }
  }

  @override
  void close() => _client.close(force: true);
}

/// Public control-plane client. It is intentionally state-free: callers own
/// the session token and pass it only to the one request that needs it.
class ApiClient
    implements
        VpnApiRepository,
        BillingApiRepository,
        GuestApiRepository,
        GoogleAuthApiRepository {
  ApiClient({Uri? baseUri, ApiHttpTransport? transport})
    : baseUri = _normalizedBaseUri(baseUri ?? productionBaseUri),
      _transport = transport ?? IoApiHttpTransport();

  static final Uri productionBaseUri = Uri.parse('https://api.fuzevpn.com/');

  final Uri baseUri;
  final ApiHttpTransport _transport;

  @override
  Future<GoogleBrowserContext> createGoogleBrowserContext({
    String? token,
    String? browserContextToken,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/browser/context',
      token: token,
      extraHeaders: browserContextToken == null
          ? null
          : <String, String>{
              'x-fuze-browser-context': _googleHeaderValue(browserContextToken),
            },
      body: const <String, Object?>{},
      expectedStatusCodes: const {200},
    );
    return _parseObject(response, GoogleBrowserContext.fromJson);
  }

  @override
  Future<GoogleAuthChallenge> createGoogleChallenge({
    required GoogleBrowserContext browserContext,
    required String purpose,
    String? token,
  }) async {
    if (!googleAuthPurposes.contains(purpose) ||
        (purpose == 'authenticate' ? token != null : token == null)) {
      throw const ApiProtocolException(code: 'invalid_google_auth_request');
    }
    final response = await _googleRequest(
      'POST',
      'v1/auth/google/challenge',
      token: token,
      extraHeaders: _googleContextHeaders(browserContext),
      body: <String, Object?>{'purpose': purpose},
      expectedStatusCodes: const {201},
    );
    return _parseObject(response, GoogleAuthChallenge.fromJson);
  }

  @override
  Future<GoogleAuthResult> verifyGoogleCredential({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String challengeId,
    required String credential,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/google/verify',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: <String, Object?>{
        'challenge_id': challengeId,
        'credential': credential,
      },
      expectedStatusCodes: const {200, 201},
    );
    return _parseObject(
      response,
      (json) => GoogleAuthResult.fromJson(json, statusCode: response.statusCode),
    );
  }

  @override
  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    final response = await _googleRequest(
      'GET',
      'v1/auth/google/context',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      expectedStatusCodes: const {200},
    );
    return _parseObject(response, GoogleAuthContext.fromJson);
  }

  @override
  Future<GoogleAuthenticatedResult> registerGoogleAccount({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/google/register',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: _googleRegistrationBody(
        countryCode: countryCode,
        termsAccepted: termsAccepted,
        privacyAccepted: privacyAccepted,
      ),
      expectedStatusCodes: const {201},
    );
    return _parseObject(response, GoogleAuthenticatedResult.fromJson);
  }

  @override
  Future<GoogleGuestClaimResult> claimGuestWithGoogle({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/google/claim',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: _googleRegistrationBody(
        countryCode: countryCode,
        termsAccepted: termsAccepted,
        privacyAccepted: privacyAccepted,
      ),
      expectedStatusCodes: const {200},
    );
    return _parseObject(response, GoogleGuestClaimResult.fromJson);
  }

  @override
  Future<GoogleAuthenticatedResult> linkGoogleWithPassword({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String currentPassword,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/google/link',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: <String, Object?>{'current_password': currentPassword},
      expectedStatusCodes: const {201},
    );
    return _parseObject(response, GoogleAuthenticatedResult.fromJson);
  }

  @override
  Future<void> requestGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    await _googleRequest(
      'POST',
      'v1/auth/google/link/email/request',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: const <String, Object?>{},
      expectedStatusCodes: const {202},
    );
  }

  @override
  Future<GoogleAuthenticatedResult> confirmGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String code,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/google/link/email/confirm',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: <String, Object?>{'code': code},
      expectedStatusCodes: const {201},
    );
    return _parseObject(response, GoogleAuthenticatedResult.fromJson);
  }

  @override
  Future<void> cancelGoogleAuth({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    String? challengeId,
  }) async {
    await _googleRequest(
      'POST',
      'v1/auth/google/cancel',
      token: contextToken,
      extraHeaders: _googleContextHeaders(browserContext),
      body: <String, Object?>{
        if (challengeId != null) 'challenge_id': challengeId,
      },
      expectedStatusCodes: const {204},
    );
  }

  @override
  Future<AuthSession> loginWithAuthContext({
    required GoogleBrowserContext browserContext,
    required String email,
    required String password,
  }) async {
    final response = await _googleRequest(
      'POST',
      'v1/auth/login',
      extraHeaders: _googleContextHeaders(browserContext),
      body: <String, Object?>{'email': email, 'password': password},
      expectedStatusCodes: const {201},
    );
    return _parseObject(response, AuthSession.fromJson);
  }

  Future<ApiHttpResponse> _googleRequest(
    String method,
    String path, {
    String? token,
    Map<String, String>? extraHeaders,
    Map<String, Object?>? body,
    required Set<int> expectedStatusCodes,
  }) async {
    if (token != null) _googleHeaderValue(token);
    try {
      return await _request(
        method,
        path,
        token: token,
        extraHeaders: extraHeaders,
        body: body,
        expectedStatusCodes: expectedStatusCodes,
        requireNoStore: true,
      );
    } on ApiException catch (failure) {
      const knownErrors = <String>{
        'google_invalid_identity',
        'google_context_expired',
        'google_context_consumed',
        'account_context_changed',
        'google_identity_conflict',
        'google_unavailable',
        'rate_limited',
        'invalid_registration',
        'invalid_current_password',
        'google_invalid_email_code',
        'google_auth_disabled',
        'account_login_required',
        'email_exists',
        'unauthorized',
        'invalid_credentials',
        'turnstile_required',
        'turnstile_invalid',
        'turnstile_unavailable',
      };
      if (knownErrors.contains(failure.code)) rethrow;
      throw ApiException(
        statusCode: failure.statusCode,
        errorCode: 'api_error',
        retryAfterSeconds: failure.retryAfterSeconds,
      );
    }
  }

  static Map<String, String> _googleContextHeaders(
    GoogleBrowserContext context,
  ) {
    if (context.authGeneration < 1) {
      throw const ApiProtocolException(code: 'invalid_google_auth_request');
    }
    return <String, String>{
      'x-fuze-browser-context': _googleHeaderValue(context.browserContextToken),
      'x-fuze-auth-generation': context.authGeneration.toString(),
    };
  }

  static String _googleHeaderValue(String value) {
    if (!RegExp(r'^[\x21-\x7E]{1,8192}$').hasMatch(value)) {
      throw const ApiProtocolException(code: 'invalid_google_auth_request');
    }
    return value;
  }

  static Map<String, Object?> _googleRegistrationBody({
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) {
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(countryCode)) {
      throw const ApiProtocolException(code: 'invalid_google_auth_request');
    }
    return <String, Object?>{
      'country_code': countryCode,
      'terms_accepted': termsAccepted,
      'privacy_accepted': privacyAccepted,
    };
  }

  @override
  Future<GuestSessionResult> createGuestSession({
    required String guestCredential,
    bool termsAccepted = false,
    bool privacyAccepted = false,
  }) async {
    final response = await _request(
      'POST',
      'v1/auth/guest',
      body: <String, Object?>{
        'guest_credential': guestCredential,
        'terms_accepted': termsAccepted,
        'privacy_accepted': privacyAccepted,
      },
      expectedStatusCodes: const <int>{201},
      requireNoStore: true,
    );
    return _parseObject(response, GuestSessionResult.fromJson);
  }

  @override
  Future<GuestRestoreResult> restoreGuestSession({
    required String purchaseToken,
    required String guestCredential,
  }) async {
    final response = await _request(
      'POST',
      'v1/auth/guest/google-play/restore',
      body: <String, Object?>{
        'purchase_token': purchaseToken,
        'guest_credential': guestCredential,
      },
      expectedStatusCodes: const <int>{201},
      requireNoStore: true,
    );
    return _parseObject(response, GuestRestoreResult.fromJson);
  }

  @override
  Future<GuestClaimResult> claimGuestAccount({
    required String token,
    required String email,
    required String password,
  }) async {
    final response = await _request(
      'POST',
      'v1/auth/guest/claim',
      token: token,
      body: <String, Object?>{'email': email, 'password': password},
      expectedStatusCodes: const <int>{200},
      requireNoStore: true,
    );
    return _parseObject(response, GuestClaimResult.fromJson);
  }

  @override
  Future<BillingSubscription> getSubscription(String token) async {
    final response = await _request(
      'GET',
      'v1/billing/subscription',
      token: token,
      expectedStatusCodes: const {200},
      requireNoStore: true,
    );
    return _parseObject(response, BillingSubscription.fromJson);
  }

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async {
    final response = await _request(
      'GET',
      'v1/billing/providers/google-play/purchase-context',
      token: token,
      expectedStatusCodes: const {200},
      requireNoStore: true,
    );
    return _parseObject(response, BillingPurchaseContext.fromJson);
  }

  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async {
    final response = await _request(
      'POST',
      'v1/billing/providers/google-play/purchases/verify',
      token: token,
      body: <String, Object?>{'purchase_token': purchaseToken},
      expectedStatusCodes: const {200, 202},
      requireNoStore: true,
    );
    final result = _parseObject(response, BillingVerification.fromJson);
    if ((response.statusCode == 202) !=
        (result.purchaseStatus == 'processing')) {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
    final retryAfterSeconds = int.tryParse(
      response.header('retry-after')?.trim() ?? '',
    );
    return BillingVerification(
      purchaseStatus: result.purchaseStatus,
      subscription: result.subscription,
      retryAfter:
          result.purchaseStatus == 'processing' &&
              retryAfterSeconds != null &&
              retryAfterSeconds >= 1 &&
              retryAfterSeconds <= 60
          ? Duration(seconds: retryAfterSeconds)
          : null,
    );
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final ApiHttpResponse response = await _request(
      'POST',
      'v1/auth/login',
      body: <String, Object?>{'email': email, 'password': password},
      expectedStatusCodes: const <int>{201},
    );
    return _parseObject(response, AuthSession.fromJson);
  }

  @override
  Future<RegistrationResult> register(RegisterAccountRequest request) async {
    final ApiHttpResponse response = await _request(
      'POST',
      'v1/auth/register',
      body: request.toJson(),
      expectedStatusCodes: const <int>{201},
    );
    return _parseObject(response, RegistrationResult.fromJson);
  }

  @override
  Future<void> logout(String token) async {
    await _request(
      'POST',
      'v1/auth/logout',
      token: token,
      expectedStatusCodes: const <int>{204},
    );
  }

  @override
  Future<void> resendVerification(String token) async {
    await _request(
      'POST',
      'v1/auth/email/resend',
      token: token,
      expectedStatusCodes: const <int>{204},
    );
  }

  @override
  Future<bool> verifyEmail(String token) async {
    final ApiHttpResponse response = await _request(
      'POST',
      'v1/auth/email/verify',
      body: <String, Object?>{'token': token},
      expectedStatusCodes: const <int>{200},
    );
    final Map<String, dynamic> json = _jsonObject(response);
    if (json['email_verified'] != true) {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
    return true;
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await _request(
      'POST',
      'v1/auth/password/reset/request',
      body: <String, Object?>{'email': email},
      expectedStatusCodes: const <int>{202},
    );
  }

  @override
  Future<void> confirmPasswordReset({
    required String token,
    required String password,
  }) async {
    await _request(
      'POST',
      'v1/auth/password/reset/confirm',
      body: <String, Object?>{'token': token, 'password': password},
      expectedStatusCodes: const <int>{204},
    );
  }

  @override
  Future<UserProfile> me(String token) async {
    final ApiHttpResponse response = await _request(
      'GET',
      'v1/me',
      token: token,
      expectedStatusCodes: const <int>{200},
    );
    return _parseObject(response, UserProfile.fromJson);
  }

  @override
  Future<UserProfile> updateMe({
    required String token,
    required UpdateProfileRequest request,
  }) async {
    final ApiHttpResponse response = await _request(
      'PUT',
      'v1/me',
      token: token,
      body: request.toJson(),
      expectedStatusCodes: const <int>{200},
    );
    return _parseObject(response, UserProfile.fromJson);
  }

  @override
  Future<List<Location>> locations() async {
    final ApiHttpResponse response = await _request(
      'GET',
      'v1/locations',
      expectedStatusCodes: const <int>{200},
    );
    final Object? rawLocations = _jsonObject(response)['locations'];
    if (rawLocations is! List) {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
    final List<Location> locations = <Location>[];
    try {
      for (final Object? item in rawLocations) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException('Emplacement VPN invalide.');
        }
        locations.add(Location.fromJson(item));
      }
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
    return List<Location>.unmodifiable(locations);
  }

  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    final ApiHttpResponse response = await _request(
      'POST',
      'v1/devices',
      token: token,
      body: <String, Object?>{
        'name': name,
        'public_key': publicKey,
        'location_id': locationId,
        if (requestIpv6) 'ip_families': const ['ipv4', 'ipv6'],
      },
      expectedStatusCodes: const <int>{201},
      requireNoStore: true,
    );
    try {
      return DeviceConfiguration.fromJson(_jsonObject(response));
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  @override
  Future<DeviceList> listDevices(String token) async {
    final ApiHttpResponse response = await _request(
      'GET',
      'v1/devices',
      token: token,
      expectedStatusCodes: const <int>{200},
      requireNoStore: true,
    );
    try {
      return DeviceList.fromJson(_jsonObject(response));
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  /// Compatibility alias for code ported from the Windows application.
  Future<DeviceList> devices(String token) => listDevices(token);

  @override
  Future<DeviceLocationMigration> startLocationMigration({
    required String token,
    required String deviceId,
    required String locationId,
  }) async {
    final ApiHttpResponse response = await _request(
      'POST',
      'v1/devices/${Uri.encodeComponent(deviceId)}/location-migrations',
      token: token,
      body: <String, Object?>{'location_id': locationId},
      expectedStatusCodes: const <int>{200, 202},
      requireNoStore: true,
    );
    return _parseLocationMigration(response, expectedDeviceId: deviceId);
  }

  @override
  Future<DeviceLocationMigration> getLocationMigration({
    required String token,
    required String deviceId,
    required String migrationId,
  }) async {
    final ApiHttpResponse response = await _request(
      'GET',
      'v1/devices/${Uri.encodeComponent(deviceId)}/location-migrations/${Uri.encodeComponent(migrationId)}',
      token: token,
      expectedStatusCodes: const <int>{200},
      requireNoStore: true,
    );
    final DeviceLocationMigration migration = _parseLocationMigration(
      response,
      expectedDeviceId: deviceId,
    );
    if (migration.migrationId != migrationId) {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
    return migration;
  }

  @override
  Future<void> revokeDevice({
    required String token,
    required String deviceId,
  }) async {
    await _request(
      'DELETE',
      'v1/devices/${Uri.encodeComponent(deviceId)}',
      token: token,
      expectedStatusCodes: const <int>{204},
      requireNoStore: true,
    );
  }

  @override
  Future<DeviceProfiles> deviceProfiles({
    required String token,
    required String deviceId,
  }) async {
    final ApiHttpResponse response = await _request(
      'GET',
      'v1/devices/${Uri.encodeComponent(deviceId)}/profiles',
      token: token,
      expectedStatusCodes: const <int>{200},
      requireNoStore: true,
    );
    try {
      final DeviceProfiles profiles = DeviceProfiles.fromJson(
        _jsonObject(response),
      );
      if (profiles.deviceId != deviceId) {
        throw ApiProtocolException(statusCode: response.statusCode);
      }
      return profiles;
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  @override
  Future<OpenVpnActivation> createOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) => _openVpnActivation(
    path: 'v1/devices/${Uri.encodeComponent(deviceId)}/profiles/openvpn',
    token: token,
    deviceId: deviceId,
    csrPem: csrPem,
    requestIpv6: requestIpv6,
  );

  @override
  Future<OpenVpnActivation> renewOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) => _openVpnActivation(
    path: 'v1/devices/${Uri.encodeComponent(deviceId)}/profiles/openvpn/renew',
    token: token,
    deviceId: deviceId,
    csrPem: csrPem,
    requestIpv6: requestIpv6,
  );

  @override
  Future<void> revokeOpenVpnProfile({
    required String token,
    required String deviceId,
  }) async {
    await _request(
      'DELETE',
      'v1/devices/${Uri.encodeComponent(deviceId)}/profiles/openvpn',
      token: token,
      expectedStatusCodes: const <int>{204},
      requireNoStore: true,
    );
  }

  Future<OpenVpnActivation> _openVpnActivation({
    required String path,
    required String token,
    required String deviceId,
    required String csrPem,
    required bool requestIpv6,
  }) async {
    final ApiHttpResponse response = await _request(
      'POST',
      path,
      token: token,
      body: <String, Object?>{
        'csr_pem': csrPem,
        if (requestIpv6) 'ip_families': const ['ipv4', 'ipv6'],
      },
      expectedStatusCodes: const <int>{201},
      requireNoStore: true,
    );
    try {
      return OpenVpnActivation.fromJson(
        _jsonObject(response),
        expectedDeviceId: deviceId,
      );
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  DeviceLocationMigration _parseLocationMigration(
    ApiHttpResponse response, {
    required String expectedDeviceId,
  }) {
    try {
      final DeviceLocationMigration migration =
          DeviceLocationMigration.fromJson(
            _jsonObject(response),
            expectedDeviceId: expectedDeviceId,
          );
      final int? headerRetryAfter = _migrationRetryAfter(
        response.header('retry-after'),
      );
      return headerRetryAfter == null
          ? migration
          : migration.withRetryAfterSeconds(headerRetryAfter);
    } on ApiProtocolException {
      rethrow;
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  Future<ApiHttpResponse> _request(
    String method,
    String relativePath, {
    String? token,
    Map<String, String>? extraHeaders,
    Map<String, Object?>? body,
    required Set<int> expectedStatusCodes,
    bool requireNoStore = false,
  }) async {
    final Map<String, String> headers = <String, String>{
      'accept': 'application/json',
      'cache-control': 'no-store',
    };
    if (token != null) headers['authorization'] = 'Bearer $token';
    if (extraHeaders != null) headers.addAll(extraHeaders);
    final String? encodedBody;
    if (body == null) {
      encodedBody = null;
    } else {
      headers['content-type'] = 'application/json; charset=utf-8';
      encodedBody = jsonEncode(body);
    }
    final String? timingStage = _connectionApiTimingStage(method, relativePath);
    final ApiHttpResponse response;
    try {
      Future<ApiHttpResponse> send() => _transport.send(
        ApiHttpRequest(
          method: method,
          uri: baseUri.resolve(relativePath),
          headers: headers,
          body: encodedBody,
        ),
      );
      response = timingStage == null
          ? await send()
          : await ConnectionTiming.measure(timingStage, send);
    } on ApiFailure {
      rethrow;
    } catch (_) {
      throw const ApiNetworkException();
    }
    if (timingStage != null) {
      ConnectionTiming.event(timingStage, status: response.statusCode);
    }
    if (!expectedStatusCodes.contains(response.statusCode)) {
      throw ApiException.fromResponse(
        statusCode: response.statusCode,
        body: response.body,
        retryAfterHeader: response.header('retry-after'),
      );
    }
    if (requireNoStore && !_hasNoStore(response.header('cache-control'))) {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
    return response;
  }

  Map<String, dynamic> _jsonObject(ApiHttpResponse response) {
    try {
      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Expected JSON object.');
      }
      return decoded;
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  T _parseObject<T>(
    ApiHttpResponse response,
    T Function(Map<String, dynamic> json) parser,
  ) {
    try {
      return parser(_jsonObject(response));
    } on ApiProtocolException {
      rethrow;
    } on FormatException {
      throw ApiProtocolException(statusCode: response.statusCode);
    }
  }

  static Uri _normalizedBaseUri(Uri value) {
    if (!value.hasScheme || value.host.isEmpty) {
      throw ArgumentError('Une URL API absolue est requise.');
    }
    final String path = value.path.endsWith('/')
        ? value.path
        : '${value.path}/';
    return value.replace(path: path, query: null, fragment: null);
  }

  static bool _hasNoStore(String? cacheControl) =>
      cacheControl
          ?.toLowerCase()
          .split(',')
          .map((String item) => item.trim())
          .contains('no-store') ??
      false;

  static int? _migrationRetryAfter(String? value) {
    if (value == null) return null;
    final int? seconds = int.tryParse(value.trim());
    if (seconds == null || seconds < 0 || seconds > 300) {
      throw const FormatException('Migration d’emplacement invalide.');
    }
    return seconds;
  }

  /// Releases a transport owned by this API client. It is safe to call when
  /// the application exits; individual requests should not call it.
  void close() => _transport.close();
}

/// Returns only fixed, non-sensitive names. Dynamic paths, identifiers and
/// query parameters are deliberately never passed to connection timing.
String? _connectionApiTimingStage(String method, String relativePath) {
  final List<String> parts = relativePath.split('/');
  if (method == 'GET' && _sameParts(parts, const <String>['v1', 'locations'])) {
    return 'api.locations';
  }
  if (method == 'GET' && _sameParts(parts, const <String>['v1', 'devices'])) {
    return 'api.devices.list';
  }
  if (method == 'POST' && _sameParts(parts, const <String>['v1', 'devices'])) {
    return 'api.device.register';
  }
  if (parts.length >= 4 &&
      parts[0] == 'v1' &&
      parts[1] == 'devices' &&
      parts[2].isNotEmpty &&
      parts[3] == 'location-migrations') {
    if (method == 'POST' && parts.length == 4) return 'api.migration.start';
    if (method == 'GET' && parts.length == 5 && parts[4].isNotEmpty) {
      return 'api.migration.poll';
    }
  }
  if (parts.length >= 5 &&
      parts[0] == 'v1' &&
      parts[1] == 'devices' &&
      parts[2].isNotEmpty &&
      parts[3] == 'profiles' &&
      parts[4] == 'openvpn' &&
      method == 'POST') {
    if (parts.length == 5) return 'api.openvpn.create';
    if (parts.length == 6 && parts[5] == 'renew') return 'api.openvpn.renew';
  }
  return null;
}

bool _sameParts(List<String> actual, List<String> expected) {
  if (actual.length != expected.length) return false;
  for (var index = 0; index < expected.length; index++) {
    if (actual[index] != expected[index]) return false;
  }
  return true;
}
