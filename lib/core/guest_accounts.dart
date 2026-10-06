import 'models.dart';
import 'play_billing.dart';

/// The credential stays in encrypted native storage, separate from the session.
abstract interface class GuestCredentialStore {
  Future<String?> readGuestCredential();
  Future<void> writeGuestCredential(String credential);
  Future<String?> readPendingGuestCredential();
  Future<void> writePendingGuestCredential(String credential);
  Future<void> clearGuestCredentials();
  Future<bool> readGuestAutoResume();
  Future<void> writeGuestAutoResume(bool enabled);
}

/// Renews the same guest principal without erasing its live VPN identity.
abstract interface class GuestSessionRenewalStore {
  Future<void> replaceGuestSession(
    AuthSession session, {
    required String userId,
  });
}

abstract interface class GuestApiRepository {
  Future<GuestSessionResult> createGuestSession({
    required String guestCredential,
    bool termsAccepted = false,
    bool privacyAccepted = false,
  });

  Future<GuestRestoreResult> restoreGuestSession({
    required String purchaseToken,
    required String guestCredential,
  });

  Future<GuestClaimResult> claimGuestAccount({
    required String token,
    required String email,
    required String password,
  });
}

class GuestSessionResult {
  const GuestSessionResult({
    required this.session,
    required this.userId,
    this.identityKind = 'guest',
  });

  final AuthSession session;
  final String userId;
  final String identityKind;

  bool get isGuest => identityKind == 'guest';

  factory GuestSessionResult.fromJson(Map<String, dynamic> json) {
    final session = AuthSession.fromJson(json);
    final userId = json['user_id'];
    if (userId is! String ||
        !RegExp(r'^[A-Za-z0-9_-]{3,128}$').hasMatch(userId) ||
        json['identity_kind'] != 'guest') {
      throw const FormatException('invalid_guest_session');
    }
    return GuestSessionResult(session: session, userId: userId);
  }

  @override
  String toString() => 'GuestSessionResult(redacted: true)';
}

class GuestRestoreResult extends GuestSessionResult {
  const GuestRestoreResult({
    required super.session,
    required super.userId,
    super.identityKind = 'guest',
    required this.purchaseStatus,
    required this.subscription,
  });

  final String purchaseStatus;
  final BillingSubscription subscription;

  factory GuestRestoreResult.fromJson(Map<String, dynamic> json) {
    final guest = GuestSessionResult.fromJson(json);
    final purchaseStatus = json['purchase_status'];
    final subscription = json['subscription'];
    if (!const <String>['verified', 'pending'].contains(purchaseStatus) ||
        subscription is! Map<String, dynamic>) {
      throw const FormatException('invalid_guest_restore');
    }
    return GuestRestoreResult(
      session: guest.session,
      userId: guest.userId,
      purchaseStatus: purchaseStatus as String,
      subscription: BillingSubscription.fromJson(subscription),
    );
  }

  @override
  String toString() => 'GuestRestoreResult(redacted: true)';
}

/// Claim preserves the current session; no replacement token is accepted here.
class GuestClaimResult {
  const GuestClaimResult({
    this.identityKind = 'registered',
    required this.emailVerified,
    required this.verificationEmailSent,
  });

  final String identityKind;
  final bool emailVerified;
  final bool verificationEmailSent;

  factory GuestClaimResult.fromJson(Map<String, dynamic> json) {
    final verified = json['email_verified'];
    final emailSent = json['verification_email_sent'];
    if (json['identity_kind'] != 'registered' ||
        verified is! bool ||
        emailSent is! bool ||
        json.containsKey('access_token') ||
        json.containsKey('expires_at')) {
      throw const FormatException('invalid_guest_claim');
    }
    return GuestClaimResult(
      emailVerified: verified,
      verificationEmailSent: emailSent,
    );
  }

  @override
  String toString() => 'GuestClaimResult(redacted: true)';
}
