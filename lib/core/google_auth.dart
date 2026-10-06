import 'models.dart';

/// Temporary Google tickets are not FuzeVPN sessions and grant no VPN access.
abstract interface class GoogleAuthApiRepository {
  Future<GoogleBrowserContext> createGoogleBrowserContext({
    String? token,
    String? browserContextToken,
  });

  Future<GoogleAuthChallenge> createGoogleChallenge({
    required GoogleBrowserContext browserContext,
    required String purpose,
    String? token,
  });

  Future<GoogleAuthResult> verifyGoogleCredential({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String challengeId,
    required String credential,
  });

  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  });

  Future<GoogleAuthenticatedResult> registerGoogleAccount({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  });

  Future<GoogleGuestClaimResult> claimGuestWithGoogle({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  });

  Future<GoogleAuthenticatedResult> linkGoogleWithPassword({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String currentPassword,
  });

  Future<void> requestGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  });

  Future<GoogleAuthenticatedResult> confirmGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String code,
  });

  Future<void> cancelGoogleAuth({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    String? challengeId,
  });

  /// Reserves the same server generation for an explicit classical login.
  Future<AuthSession> loginWithAuthContext({
    required GoogleBrowserContext browserContext,
    required String email,
    required String password,
  });
}

class GoogleBrowserContext {
  const GoogleBrowserContext({
    required this.browserContextToken,
    required this.authGeneration,
    required this.expiresAt,
  });

  final String browserContextToken;
  final int authGeneration;
  final DateTime expiresAt;

  factory GoogleBrowserContext.fromJson(Map<String, dynamic> json) {
    final generation = json['auth_generation'];
    if (generation is! int || generation < 1) {
      throw const FormatException('invalid_google_browser_context');
    }
    return GoogleBrowserContext(
      browserContextToken: _googleText(json, 'browser_context_token'),
      authGeneration: generation,
      expiresAt: _googleExpiry(json),
    );
  }

  @override
  String toString() => 'GoogleBrowserContext(redacted: true)';
}

class GoogleAuthChallenge {
  const GoogleAuthChallenge({
    required this.challengeId,
    required this.nonce,
    required this.contextToken,
    required this.expiresAt,
  });

  final String challengeId;
  final String nonce;
  final String contextToken;
  final DateTime expiresAt;

  factory GoogleAuthChallenge.fromJson(Map<String, dynamic> json) =>
      GoogleAuthChallenge(
        challengeId: _googleText(json, 'challenge_id'),
        nonce: _googleText(json, 'nonce'),
        contextToken: _googleText(json, 'context_token'),
        expiresAt: _googleExpiry(json),
      );

  @override
  String toString() => 'GoogleAuthChallenge(redacted: true)';
}

sealed class GoogleAuthResult {
  const GoogleAuthResult();

  String get status;
  DateTime get expiresAt;

  factory GoogleAuthResult.fromJson(
    Map<String, dynamic> json, {
    required int statusCode,
  }) {
    if (statusCode == 201 && json['status'] == 'authenticated') {
      return GoogleAuthenticatedResult.fromJson(json);
    }
    if (statusCode == 200) return GoogleContinuationResult.fromJson(json);
    throw const FormatException('invalid_google_auth_result');
  }
}

class GoogleAuthenticatedResult extends GoogleAuthResult {
  const GoogleAuthenticatedResult({
    required this.session,
    this.emailVerified,
    this.verificationEmailSent,
  });

  final AuthSession session;
  final bool? emailVerified;
  final bool? verificationEmailSent;

  @override
  String get status => 'authenticated';
  @override
  DateTime get expiresAt => session.expiresAt;

  factory GoogleAuthenticatedResult.fromJson(Map<String, dynamic> json) {
    if (json['status'] != 'authenticated' ||
        json.containsKey('context_token') ||
        json.containsKey('reauth_token') ||
        (json.containsKey('identity_kind') &&
            json['identity_kind'] != 'registered')) {
      throw const FormatException('invalid_google_authenticated_result');
    }
    return GoogleAuthenticatedResult(
      session: AuthSession.fromJson(json),
      emailVerified: _googleOptionalBool(json, 'email_verified'),
      verificationEmailSent: _googleOptionalBool(
        json,
        'verification_email_sent',
      ),
    );
  }

  @override
  String toString() => 'GoogleAuthenticatedResult(redacted: true)';
}

class GoogleContinuationResult extends GoogleAuthResult {
  const GoogleContinuationResult({
    required this.status,
    required this.contextToken,
    required this.expiresAt,
  });

  @override
  final String status;
  final String contextToken;
  @override
  final DateTime expiresAt;

  factory GoogleContinuationResult.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    if (!_googleContinuationStatuses.contains(status) ||
        json.containsKey('access_token') ||
        json.containsKey('reauth_token')) {
      throw const FormatException('invalid_google_continuation');
    }
    return GoogleContinuationResult(
      status: status as String,
      contextToken: _googleText(json, 'context_token'),
      expiresAt: _googleExpiry(json),
    );
  }

  @override
  String toString() => 'GoogleContinuationResult(redacted: true)';
}

class GoogleAuthContext {
  const GoogleAuthContext({
    required this.status,
    required this.purpose,
    required this.expiresAt,
    required this.email,
    this.emailVerified,
    this.firstName = '',
    this.lastName = '',
  });

  final String status;
  final String purpose;
  final DateTime expiresAt;
  final String email;
  final bool? emailVerified;
  final String firstName;
  final String lastName;

  factory GoogleAuthContext.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final purpose = json['purpose'];
    if (!_googleContinuationStatuses.contains(status) ||
        !googleAuthPurposes.contains(purpose) ||
        json.containsKey('access_token') ||
        json.containsKey('context_token') ||
        json.containsKey('reauth_token')) {
      throw const FormatException('invalid_google_context');
    }
    return GoogleAuthContext(
      status: status as String,
      purpose: purpose as String,
      expiresAt: _googleExpiry(json),
      email: _googleText(json, 'email'),
      emailVerified: _googleOptionalBool(json, 'email_verified'),
      firstName: _googleOptionalName(json, 'first_name'),
      lastName: _googleOptionalName(json, 'last_name'),
    );
  }

  @override
  String toString() => 'GoogleAuthContext(redacted: true)';
}

/// A successful guest conversion leaves its initiating FuzeVPN token intact.
class GoogleGuestClaimResult {
  const GoogleGuestClaimResult({
    required this.userId,
    this.identityKind = 'registered',
    required this.emailVerified,
    this.verificationEmailSent,
  });

  final String userId;
  final String identityKind;
  final bool emailVerified;
  final bool? verificationEmailSent;
  String get status => 'authenticated';

  factory GoogleGuestClaimResult.fromJson(Map<String, dynamic> json) {
    final userId = json['user_id'];
    final emailVerified = json['email_verified'];
    if (json['status'] != 'authenticated' ||
        json['identity_kind'] != 'registered' ||
        userId is! String ||
        !RegExp(r'^[A-Za-z0-9_-]{3,128}$').hasMatch(userId) ||
        emailVerified is! bool ||
        const ['access_token', 'expires_at', 'context_token', 'reauth_token']
            .any(json.containsKey)) {
      throw const FormatException('invalid_google_guest_claim');
    }
    return GoogleGuestClaimResult(
      userId: userId,
      emailVerified: emailVerified,
      verificationEmailSent: _googleOptionalBool(
        json,
        'verification_email_sent',
      ),
    );
  }

  @override
  String toString() => 'GoogleGuestClaimResult(redacted: true)';
}

const googleAuthPurposes = <String>{'authenticate', 'claim', 'link'};
const _googleContinuationStatuses = <String>{
  'registration_required',
  'link_required',
  'guest_claim_required',
};

String _googleText(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.trim().isEmpty || value.length > 8192) {
    throw const FormatException('invalid_google_auth_response');
  }
  return value;
}

DateTime _googleExpiry(Map<String, dynamic> json) {
  final expiry = DateTime.tryParse(_googleText(json, 'expires_at'));
  if (expiry == null) {
    throw const FormatException('invalid_google_auth_expiry');
  }
  return expiry;
}

bool? _googleOptionalBool(Map<String, dynamic> json, String key) {
  if (!json.containsKey(key)) return null;
  final value = json[key];
  if (value is! bool) {
    throw const FormatException('invalid_google_auth_response');
  }
  return value;
}

String _googleOptionalName(Map<String, dynamic> json, String key) {
  if (!json.containsKey(key)) return '';
  final value = json[key];
  if (value is! String || value.length > 512) {
    throw const FormatException('invalid_google_auth_response');
  }
  return value;
}
