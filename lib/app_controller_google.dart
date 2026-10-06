part of 'app_controller.dart';

extension _GoogleAccountOperations on VpnAppController {
  GoogleIdentitySnapshot _googleIdentity() {
    if (_session == null &&
        !_sessionOperation.isCurrent &&
        sessionTermination == null &&
        !_disposed) {
      _sessionOperation = SessionOperation();
      _sessionExpired = false;
    }
    return GoogleIdentitySnapshot(
      userId: profile?.userId,
      accessToken: token,
      scope: _sessionOperation,
      isGuest: profile?.isGuest == true,
      canManageAccount:
          profile?.canManageAccount == true &&
          profile?.profileRedacted == false,
    );
  }

  bool _googleIdentityMatches(GoogleIdentitySnapshot before) =>
      !_disposed &&
      identical(before.scope, _sessionOperation) &&
      _sessionOperation.isCurrent &&
      before.userId == profile?.userId &&
      before.accessToken == token;

  bool _canBeginGoogle(GoogleAuthPurpose purpose) {
    if (_disposed ||
        _isAuthenticating ||
        sessionTermination != null ||
        isIdentityBusy ||
        isConnecting ||
        _guestActionOwner != null ||
        _guestRenewing ||
        _guestResuming ||
        _guestRetryTimer != null) {
      return false;
    }
    if (purpose == GoogleAuthPurpose.claim) {
      return profile?.isGuest == true && profile?.canClaimAccount == true;
    }
    // Association from the profile is a separate future screen. Authenticate
    // may deliberately replace a guest or restricted Play session after proof.
    return purpose == GoogleAuthPurpose.authenticate &&
        (_session == null ||
            profile?.isGuest == true ||
            profile?.profileRedacted == true);
  }

  void _googleChanged() {
    if (_disposed) return;
    if (_googleAuth.hasPendingIntent &&
        profile?.isGuest == true &&
        _guestActionOwner == null) {
      _googleGuestOwner = Object();
      _guestActionOwner = _googleGuestOwner;
    } else if (!_googleAuth.hasPendingIntent &&
        identical(_guestActionOwner, _googleGuestOwner)) {
      _guestActionOwner = null;
      _googleGuestOwner = null;
    }
    notifyListeners();
  }

  Future<bool> _admitGoogleSession(
    GoogleAuthenticatedResult result,
    GoogleIdentitySnapshot before,
    bool Function() isCurrent,
  ) async {
    if (!_googleIdentityMatches(before) || !isCurrent()) return false;
    final candidate = result.session;
    if (!candidate.expiresAt.isAfter(DateTime.now())) return false;
    final verified = await _api.me(candidate.accessToken);
    if (!_googleIdentityMatches(before) || !isCurrent()) return false;
    if (verified.isGuest ||
        verified.profileRedacted ||
        !verified.canManageAccount ||
        verified.authMethods?.contains('google') != true) {
      throw const ApiProtocolException();
    }
    if (_session != null) {
      // Only the explicit login screen reaches here; the guest is kept until
      // the candidate is proven. No subscription, device or key is transferred.
      final store = _guestStore;
      if (store != null) await store.writeGuestAutoResume(false);
      if (!_googleIdentityMatches(before) || !isCurrent()) return false;
      final oldToken = token;
      await _terminateSession();
      if (oldToken != null) unawaited(_logoutRemotely(oldToken));
      if (_disposed || sessionTermination != null || !isCurrent()) return false;
    }
    _sessionOperation.invalidate();
    _sessionOperation = SessionOperation();
    _sessionExpired = false;
    final operation = _sessionOperation;
    operation.check();
    if (!isCurrent()) return false;
    try {
      final restored = await _setSession(
        candidate,
        verificationNeeded: verified.emailVerified == false,
        authorizationCurrent: isCurrent,
      );
      if (!isCurrent()) {
        if (identical(_session, candidate) && operation.isCurrent) {
          await _terminateSession();
        }
        return false;
      }
      if (restored &&
          result.verificationEmailSent == false &&
          verified.emailVerified == false) {
        notice = _controllerNotice('account_created_email_unavailable');
      }
      // Profile/catalog restoration may need a retry after the candidate was
      // already verified and durably committed. That is an admitted session,
      // not a still-pending Google intent to revoke on Back.
      return restored ||
          (identical(_session, candidate) && hasPendingAccountRestoration);
    } on NativeVpnException catch (error) {
      if (operation.isCurrent) await _handleInitialSessionWriteFailure(error);
      return false;
    } on SessionOperationCancelled {
      if (operation.isCurrent && !isCurrent()) {
        await _terminateSession();
      }
      return false;
    }
  }

  Future<bool> _admitGoogleClaim(
    GoogleIdentitySnapshot before,
    bool Function() isCurrent,
  ) async {
    if (!_googleIdentityMatches(before) ||
        !isCurrent() ||
        before.userId == null ||
        before.accessToken == null) {
      return false;
    }
    final next = await _api.me(before.accessToken!);
    if (!_googleIdentityMatches(before) || !isCurrent()) return false;
    if (next.userId != before.userId) throw const ApiProtocolException();
    if (next.isGuest ||
        next.profileRedacted ||
        !next.canManageAccount ||
        next.authMethods?.contains('google') != true) {
      return false;
    }
    // Only the initiating session receives personal permissions. Conversion
    // changes profile metadata, never the bearer, logical device or live VPN.
    profile = next;
    mayNeedEmailVerification = next.emailVerified == false;
    await _safe<void>(
      _guestStore?.clearGuestCredentials() ?? Future<void>.value(),
    );
    if (!isCurrent() || !_googleIdentityMatches(before)) return false;
    _guestMessage = 'guest.claimSuccess';
    return true;
  }
}
