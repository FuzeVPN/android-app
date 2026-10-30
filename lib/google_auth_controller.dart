import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'core/api_exception.dart';
import 'core/google_auth.dart';
import 'core/google_credentials.dart';
import 'core/security_challenge.dart';

enum GoogleAuthPurpose { authenticate, claim, link }

enum GoogleAuthBlock { intentMismatch, securityChallenge }

enum GoogleAuthStep {
  idle,
  selectingAccount,
  verifying,
  registrationRequired,
  guestClaimRequired,
  linkRequired,
  authenticated,
  uncertain,
  failure,
}

class GoogleAuthState {
  const GoogleAuthState({
    this.step = GoogleAuthStep.idle,
    this.messageKey,
    this.context,
    this.emailRequested = false,
    this.retryAfter,
    this.emailRetryAfter,
    this.block,
    this.securityChallengeRequired = false,
    this.challengeExpiresAt,
  });

  final GoogleAuthStep step;
  final String? messageKey;
  final GoogleAuthContext? context;
  final bool emailRequested;

  /// A server-imposed delay shared by finalization operations for this intent,
  /// published only while it was still in force: an expired or zero delay is
  /// null, so a later refusal without delay is never mistaken for a stale one.
  final DateTime? retryAfter;

  /// Resending an email waits locally; entering its code remains permitted.
  final DateTime? emailRetryAfter;
  final GoogleAuthBlock? block;
  final bool securityChallengeRequired;
  final DateTime? challengeExpiresAt;
}

/// An opaque anchor to the locally known Fuze session, never a Google identity.
class GoogleIdentitySnapshot {
  const GoogleIdentitySnapshot({
    this.userId,
    this.accessToken,
    this.scope,
    this.isGuest = false,
    this.canManageAccount = false,
  });

  final String? userId;
  final String? accessToken;
  final Object? scope;
  final bool isGuest;
  final bool canManageAccount;

  @override
  String toString() => 'GoogleIdentitySnapshot(redacted: true)';
}

typedef GoogleSessionAdmission =
    Future<bool> Function(
      GoogleAuthenticatedResult result,
      GoogleIdentitySnapshot before,
      bool Function() isCurrent,
    );
typedef GoogleClaimAdmission =
    Future<bool> Function(
      GoogleIdentitySnapshot before,
      bool Function() isCurrent,
    );

/// Owns one explicit Google intent. Pending tickets are encrypted by Android;
/// Google ID tokens only exist while the native result is exchanged with API.
class GoogleAuthController extends ChangeNotifier {
  GoogleAuthController({
    GoogleAuthApiRepository? api,
    GoogleCredentialGateway? gateway,
    GooglePendingAuthStore? pendingStore,
    GoogleIdentitySnapshot Function()? identity,
    bool Function(GoogleIdentitySnapshot)? identityMatches,
    bool Function(GoogleAuthPurpose)? canBegin,
    GoogleSessionAdmission? admitSession,
    GoogleClaimAdmission? admitClaim,
    DateTime Function()? now,
    SecurityChallengeGateway? challengeGateway,
  }) : // Public named injection deliberately keeps implementation fields private.
       // ignore: prefer_initializing_formals
       _api = api,
       // ignore: prefer_initializing_formals
       _gateway = gateway,
       _store = pendingStore,
       _identity = identity ?? (() => const GoogleIdentitySnapshot()),
       _identityMatches = identityMatches ?? ((_) => true),
       _canBegin = canBegin ?? ((_) => true),
       _admitSession = admitSession ?? ((_, _, _) async => false),
       _admitClaim = admitClaim ?? ((_, _) async => false),
       _now = now ?? DateTime.now,
       _challengeGateway = challengeGateway ?? NativeSecurityChallengeGateway();

  static const serverClientId =
      '77017033563-bs6rpo2dro8mi19guaoq4ppdb9khqj6q.apps.googleusercontent.com';

  final GoogleAuthApiRepository? _api;
  final GoogleCredentialGateway? _gateway;
  final GooglePendingAuthStore? _store;
  final GoogleIdentitySnapshot Function() _identity;
  final bool Function(GoogleIdentitySnapshot) _identityMatches;
  final bool Function(GoogleAuthPurpose) _canBegin;
  final GoogleSessionAdmission _admitSession;
  final GoogleClaimAdmission _admitClaim;
  final DateTime Function() _now;
  final SecurityChallengeGateway _challengeGateway;
  DateTime get now => _now();
  GoogleAuthState _state = const GoogleAuthState();
  GoogleAuthState get state => _state;
  _PendingGoogleIntent? _pending;
  GoogleAuthPurpose? _requestedPurpose;
  DateTime? _retryAfter;
  DateTime? _emailRetryAfter;
  bool _securityChallengeBlocked = false;
  String? _securityRequestId;
  _SecurityProof? _securityProof;
  Timer? _securityExpiryTimer;
  GoogleIdentitySnapshot? _before;
  Future<void>? _action;
  Future<void> _storageWrites = Future<void>.value();
  bool _disposed = false;
  bool _cancelling = false;
  bool _admitted = false;
  int _epoch = 0;

  /// Server intents (browser context, ticket) whose cancellation the API
  /// confirmed in this process while the local removal failed. The reply to a
  /// second cancellation of the same ticket is unspecified, so a stale copy
  /// read again is never presented to the API: only its removal is retried.
  /// Emptied once the slot is cleared or overwritten; a new process starts
  /// empty (docs/GOOGLE_AUTH.md).
  final Set<(String, String)> _confirmedCancellations = <(String, String)>{};

  bool get isBusy => _action != null || _cancelling;
  bool get hasPendingIntent => _pending != null || isBusy;

  bool get _hasIntentMismatch =>
      _pending != null &&
      _requestedPurpose != null &&
      _pending!.purpose != _requestedPurpose;

  bool get _retryBlocked => _retryAfter?.isAfter(now) ?? false;

  bool get _finalizationBlocked =>
      _hasIntentMismatch ||
      (_securityChallengeBlocked && !_hasSecurityProof) ||
      _retryBlocked;

  bool get _hasSecurityProof => _securityProof?.expiresAt.isAfter(now) == true;

  bool get _registrationContextMatches =>
      switch ((_pending?.purpose, _state.context?.status)) {
        (GoogleAuthPurpose.authenticate, 'registration_required') ||
        (GoogleAuthPurpose.claim, 'guest_claim_required') => true,
        _ => false,
      };

  void _emit(GoogleAuthState value) {
    _state = GoogleAuthState(
      step:
          _hasIntentMismatch ||
              (_securityChallengeBlocked && !_hasSecurityProof)
          ? GoogleAuthStep.uncertain
          : value.step,
      messageKey: _hasIntentMismatch
          ? 'google.intentMismatch'
          : value.messageKey,
      context: _hasIntentMismatch ? null : value.context,
      emailRequested: value.emailRequested,
      retryAfter: _retryBlocked ? _retryAfter : null,
      emailRetryAfter: _emailRetryAfter,
      block: _hasIntentMismatch
          ? GoogleAuthBlock.intentMismatch
          : _securityChallengeBlocked && !_hasSecurityProof
          ? GoogleAuthBlock.securityChallenge
          : null,
      securityChallengeRequired: _securityChallengeBlocked,
      challengeExpiresAt: _securityProof?.expiresAt,
    );
    if (!_disposed) notifyListeners();
  }

  bool _current(int epoch) => !_disposed && !_cancelling && epoch == _epoch;

  bool _anchored(int epoch) =>
      _current(epoch) && _before != null && _identityMatches(_before!);

  void _check(int epoch) {
    if (!_anchored(epoch)) throw const _GoogleIntentCancelled();
    if (_hasIntentMismatch) {
      throw const _GooglePublicFailure('google.intentMismatch');
    }
  }

  Future<void> _run(Future<void> Function(int epoch) action) {
    if (isBusy || _disposed) return Future<void>.value();
    final done = Completer<void>();
    _action = done.future;
    final epoch = ++_epoch;
    unawaited(() async {
      try {
        await action(epoch);
      } on _GoogleIntentCancelled {
        _discardSecurityProof();
        // A deliberate cancellation or changed Fuze session owns the UI now.
        if (_current(epoch)) {
          _emit(
            const GoogleAuthState(
              step: GoogleAuthStep.uncertain,
              messageKey: 'google.accountChanged',
            ),
          );
        }
      } catch (error) {
        if (_current(epoch)) {
          _failure(error);
        } else if (!_disposed) {
          // A reply raced by Back still binds this intent if its cancellation
          // fails; a confirmed cancellation clears these blocks.
          _rememberFailureBlocks(error);
        }
      } finally {
        if (identical(_action, done.future)) _action = null;
        done.complete();
        if (!_disposed) notifyListeners();
      }
    }());
    return done.future;
  }

  Future<void> _writePending(_PendingGoogleIntent pending, int epoch) {
    final future = _storageWrites.then((_) async {
      _check(epoch);
      await _store!.writePendingAuthentication(pending.encode());
      // The slot now holds this intent: no stale cancelled copy remains.
      _confirmedCancellations.clear();
      _check(epoch);
    });
    _storageWrites = future.then<void>((_) {}, onError: (Object _) {});
    return future;
  }

  Future<void> begin(GoogleAuthPurpose purpose) => _run((epoch) async {
    if (_api == null || _gateway == null || _store == null) {
      _emit(
        const GoogleAuthState(
          step: GoogleAuthStep.failure,
          messageKey: 'google.unavailable',
        ),
      );
      return;
    }
    if (_requestedPurpose != null && _requestedPurpose != purpose) {
      _discardSecurityProof();
    }
    _requestedPurpose = purpose;
    if (_pending != null) {
      _emit(
        const GoogleAuthState(
          step: GoogleAuthStep.uncertain,
          messageKey: 'google.uncertain',
        ),
      );
      return;
    }
    if (!_canBegin(purpose)) {
      // Another account, VPN or guest operation owns the session. A persisted
      // ticket stays unread here; cancel() still cancels it on the server.
      _emit(const GoogleAuthState(messageKey: 'google.busy'));
      return;
    }
    _retryAfter = null;
    _emailRetryAfter = null;
    _securityChallengeBlocked = false;
    _before = _identity();
    _admitted = false;
    _emit(const GoogleAuthState(step: GoogleAuthStep.selectingAccount));
    // Read before creating an intent: process death must never replace an
    // unresolved server intent with another account selection.
    final saved = await _readPersistedTicket();
    _check(epoch);
    if (saved != null) {
      _pending = saved;
      await _resume(epoch);
      return;
    }
    final capabilities = await _gateway.getCapabilities();
    _check(epoch);
    if (!capabilities.supported) {
      _emit(
        const GoogleAuthState(
          step: GoogleAuthStep.failure,
          messageKey: 'google.unavailable',
        ),
      );
      return;
    }
    final anchor = _before!;
    if ((purpose == GoogleAuthPurpose.claim &&
            (!anchor.isGuest || anchor.accessToken == null)) ||
        (purpose == GoogleAuthPurpose.link &&
            (!anchor.canManageAccount || anchor.accessToken == null))) {
      throw const _GooglePublicFailure('google.accountChanged');
    }
    final browser = await _api.createGoogleBrowserContext(
      token: purpose == GoogleAuthPurpose.authenticate
          ? null
          : anchor.accessToken,
    );
    _check(epoch);
    final challenge = await _api.createGoogleChallenge(
      browserContext: browser,
      purpose: purpose.name,
      token: purpose == GoogleAuthPurpose.authenticate
          ? null
          : anchor.accessToken,
    );
    // Retain a returned challenge even if Back was pressed during HTTP. cancel()
    // waits for this action and can invalidate that exact intent server-side.
    _pending = _PendingGoogleIntent(
      requestId: _requestId(),
      purpose: purpose,
      stage: 'challenge',
      ticket: challenge.contextToken,
      browser: browser,
      expiresAt: challenge.expiresAt,
      challengeId: challenge.challengeId,
      userId: anchor.userId,
    );
    _check(epoch);
    await _writePending(_pending!, epoch);
    _check(epoch);
    try {
      final credential = await _gateway.signIn(
        requestId: _pending!.requestId,
        serverClientId: serverClientId,
        nonce: challenge.nonce,
      );
      _check(epoch);
      _emit(const GoogleAuthState(step: GoogleAuthStep.verifying));
      final result = await _api.verifyGoogleCredential(
        browserContext: browser,
        contextToken: _pending!.ticket,
        challengeId: challenge.challengeId,
        credential: credential.idToken,
      );
      _check(epoch);
      await _accept(result, epoch);
    } on GoogleCredentialException catch (error) {
      _check(epoch);
      if (error.code == 'cancelled' || error.code == 'interrupted') {
        if (await _cancelServer()) {
          _emit(const GoogleAuthState());
        } else {
          _emit(
            const GoogleAuthState(
              step: GoogleAuthStep.uncertain,
              messageKey: 'google.cancelFailed',
            ),
          );
        }
      } else {
        _failure(error);
      }
    }
  });

  Future<void> _accept(GoogleAuthResult result, int epoch) async {
    _check(epoch);
    if (result is GoogleAuthenticatedResult) {
      if (_pending!.purpose == GoogleAuthPurpose.claim) {
        throw const _GooglePublicFailure('google.accountChanged');
      }
      final admitted = await _admitSession(
        result,
        _before!,
        () => _current(epoch),
      );
      if (!_current(epoch)) return;
      if (!admitted) throw const _GooglePublicFailure('google.accountChanged');
      await _complete();
      return;
    }
    if (result is! GoogleContinuationResult) {
      throw const _GooglePublicFailure('google.invalidResponse');
    }
    final expectedClaim = _pending!.purpose == GoogleAuthPurpose.claim;
    if ((result.status == 'guest_claim_required') != expectedClaim) {
      throw const _GooglePublicFailure('google.accountChanged');
    }
    _pending = _pending!.continuation(result.contextToken, result.expiresAt);
    await _writePending(_pending!, epoch);
    await _loadContext(epoch);
  }

  Future<void> _loadContext(int epoch) async {
    final pending = _pending!;
    final context = await _api!.getGoogleContext(
      browserContext: pending.browser,
      contextToken: pending.ticket,
    );
    _check(epoch);
    if (context.purpose != pending.purpose.name ||
        (context.status == 'guest_claim_required') !=
            (pending.purpose == GoogleAuthPurpose.claim)) {
      throw const _GooglePublicFailure('google.accountChanged');
    }
    final step = switch (context.status) {
      'registration_required' => GoogleAuthStep.registrationRequired,
      'guest_claim_required' => GoogleAuthStep.guestClaimRequired,
      'link_required' => GoogleAuthStep.linkRequired,
      _ => throw const _GooglePublicFailure('google.invalidResponse'),
    };
    _emit(
      GoogleAuthState(
        step: step,
        // A reopened form must say why finalization is still unavailable.
        messageKey: _retryBlocked
            ? 'google.rateLimited'
            : _securityChallengeBlocked && !_hasSecurityProof
            ? 'google.challengeRequired'
            : null,
        context: context,
        emailRequested: _state.emailRequested,
      ),
    );
  }

  Future<void> resume() => _run((epoch) async {
    if (_api == null || _store == null) return;
    _before ??= _identity();
    if (_pending == null) {
      final saved = await _readPersistedTicket();
      _check(epoch);
      if (saved == null) return;
      _pending = saved;
    } else {
      // Memory may contain a rotated ticket whose atomic disk commit failed.
      // Never replace it with the superseded challenge ticket from disk.
      await _writePending(_pending!, epoch);
    }
    await _resume(epoch);
  });

  Future<void> _resume(int epoch) async {
    _check(epoch);
    expireSecurityChallenge();
    final pending = _pending!;
    if (_securityChallengeBlocked && !_hasSecurityProof) {
      // A failed cancellation does not keep the form context; reload it so
      // the required challenge remains solvable instead of only cancellable.
      if (_state.context == null && pending.stage == 'continuation') {
        // An expired ticket is reported, as by solveSecurityChallenge.
        if (!pending.expiresAt.isAfter(now)) {
          throw const _GooglePublicFailure('google.expired');
        }
        await _loadContext(epoch);
      } else {
        _emit(_state);
      }
      return;
    }
    if (pending.userId != _before?.userId) {
      throw const _GooglePublicFailure('google.accountChanged');
    }
    if (pending.purpose == GoogleAuthPurpose.claim) {
      try {
        if (await _admitClaim(_before!, () => _anchored(epoch))) {
          _check(epoch);
          await _complete();
          return;
        }
      } on ApiFailure {
        // The private context can still be inspected or cancelled even if
        // the initiating bearer is expired or /me is temporarily unavailable.
      }
    }
    if (pending.stage != 'continuation' || !pending.expiresAt.isAfter(now)) {
      _emit(
        const GoogleAuthState(
          step: GoogleAuthStep.uncertain,
          messageKey: 'google.uncertain',
        ),
      );
      return;
    }
    await _loadContext(epoch);
  }

  Future<void> completeProfile({
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) => _run((epoch) async {
    expireSecurityChallenge();
    if (_pending == null ||
        _finalizationBlocked ||
        !_registrationContextMatches ||
        !const <GoogleAuthStep>{
          GoogleAuthStep.registrationRequired,
          GoogleAuthStep.guestClaimRequired,
        }.contains(_state.step)) {
      return;
    }
    _check(epoch);
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(countryCode) ||
        !termsAccepted ||
        !privacyAccepted) {
      throw const _GooglePublicFailure('google.consentRequired');
    }
    final previous = _state;
    _emit(
      GoogleAuthState(
        step: GoogleAuthStep.verifying,
        context: previous.context,
      ),
    );
    final pending = _pending!;
    // Move the token out before any await: one proof authorizes one attempt.
    final turnstileToken = _consumeSecurityProof();
    if (pending.purpose == GoogleAuthPurpose.claim) {
      Object? failure;
      try {
        final result = await _api!.claimGuestWithGoogle(
          browserContext: pending.browser,
          contextToken: pending.ticket,
          countryCode: countryCode,
          termsAccepted: termsAccepted,
          privacyAccepted: privacyAccepted,
          turnstileToken: turnstileToken,
        );
        _check(epoch);
        if (result.userId != _before!.userId ||
            result.identityKind != 'registered') {
          throw const _GooglePublicFailure('google.accountChanged');
        }
      } catch (error) {
        failure = error;
      }
      // Capture the original response's deadline and challenge requirement
      // before Back or a slow/failing /me can replace its error. Successful
      // reconciliation still completes the claim and clears both.
      if (failure != null && identical(_pending, pending)) {
        _rememberFailureBlocks(failure);
      }
      _check(epoch);
      // Re-read with the unchanged initiating bearer even after a lost reply.
      if (await _admitClaim(_before!, () => _anchored(epoch))) {
        _check(epoch);
        await _complete();
      } else {
        _check(epoch);
        _emit(previous);
        _failure(
          failure ?? const _GooglePublicFailure('google.invalidResponse'),
          rememberRetryAfter: false,
        );
      }
      return;
    }
    try {
      final result = await _api!.registerGoogleAccount(
        browserContext: pending.browser,
        contextToken: pending.ticket,
        countryCode: countryCode,
        termsAccepted: termsAccepted,
        privacyAccepted: privacyAccepted,
        turnstileToken: turnstileToken,
      );
      _check(epoch);
      await _accept(result, epoch);
    } catch (error) {
      if (identical(_pending, pending)) _rememberFailureBlocks(error);
      _check(epoch);
      _emit(previous);
      _failure(error);
    }
  });

  Future<void> linkWithPassword(String password) => _link(
    (pending) => _api!.linkGoogleWithPassword(
      browserContext: pending.browser,
      contextToken: pending.ticket,
      currentPassword: password,
    ),
  );

  Future<void> confirmEmailLink(String code) => _link(
    (pending) => _api!.confirmGoogleLinkEmail(
      browserContext: pending.browser,
      contextToken: pending.ticket,
      code: code,
    ),
  );

  Future<void> _link(
    Future<GoogleAuthenticatedResult> Function(_PendingGoogleIntent) action,
  ) => _run((epoch) async {
    if (_pending == null ||
        _finalizationBlocked ||
        _state.step != GoogleAuthStep.linkRequired) {
      return;
    }
    _check(epoch);
    final previous = _state;
    final pending = _pending!;
    _emit(
      GoogleAuthState(
        step: GoogleAuthStep.verifying,
        context: previous.context,
      ),
    );
    try {
      final result = await action(pending);
      _check(epoch);
      await _accept(result, epoch);
    } catch (error) {
      if (identical(_pending, pending)) _rememberFailureBlocks(error);
      _check(epoch);
      _emit(previous);
      _failure(error);
    }
  });

  Future<void> requestEmailLink() => _run((epoch) async {
    if (_pending == null ||
        _finalizationBlocked ||
        _state.step != GoogleAuthStep.linkRequired ||
        (_emailRetryAfter?.isAfter(now) ?? false)) {
      return;
    }
    _check(epoch);
    final previous = _state;
    await _api!.requestGoogleLinkEmail(
      browserContext: _pending!.browser,
      contextToken: _pending!.ticket,
    );
    _check(epoch);
    _emailRetryAfter = now.add(const Duration(seconds: 60));
    _emit(
      GoogleAuthState(
        step: GoogleAuthStep.linkRequired,
        context: previous.context,
        emailRequested: true,
      ),
    );
  });

  Future<void> _complete() async {
    _admitted = true;
    // A storage cleanup error cannot undo a verified Fuze session or turn Back
    // into a cancellation that revokes the account just admitted.
    try {
      await _store!.clearPendingAuthentication();
    } catch (_) {
      // Only encrypted short-lived tickets may remain, never a Google ID token.
    }
    _pending = null;
    _clearBlocks();
    _emit(const GoogleAuthState(step: GoogleAuthStep.authenticated));
  }

  Future<bool> cancel() async {
    if (_disposed || _cancelling) return false;
    if (_admitted) return true;
    _cancelling = true;
    ++_epoch;
    if (!_disposed) notifyListeners();
    try {
      final securityRequestId = _securityRequestId;
      _securityRequestId = null;
      _discardSecurityProof();
      if (securityRequestId != null) {
        try {
          await _challengeGateway.cancel(requestId: securityRequestId);
        } catch (_) {}
      }
      final pending = _pending;
      if (pending != null && _gateway != null) {
        try {
          await _gateway.cancelSignIn(requestId: pending.requestId);
        } catch (_) {
          /* Server cancellation remains authoritative. */
        }
      }
      await _action;
      await _storageWrites;
      // A ticket persisted by an earlier process may never have been loaded
      // (begin refused, or its read failed). Load it so that it gets the same
      // /me reconciliation and exact server cancellation as a loaded one.
      if (_pending == null && !await _loadPersistedTicket()) {
        // Nothing is loaded and nothing can be: leaving cannot be trapped.
        _clearBlocks();
        _emit(const GoogleAuthState());
        return true;
      }
      final claim = _pending?.purpose == GoogleAuthPurpose.claim;
      if (claim) _before ??= _identity();
      // If cancellation raced a committed guest claim, or a persisted claim
      // lost its reply, keep that same account; another user's ticket is
      // only cancelled.
      if (claim &&
          _before != null &&
          _pending!.userId == _before!.userId &&
          _identityMatches(_before!)) {
        try {
          if (await _admitClaim(
            _before!,
            () => !_disposed && _identityMatches(_before!),
          )) {
            await _complete();
            return true;
          }
        } on ApiFailure {
          // API cancellation of a claim never revokes the initiating bearer
          // or an already committed conversion. Do not trap Back on /me.
        }
      }
      if (!await _cancelServer()) {
        _emit(
          const GoogleAuthState(
            step: GoogleAuthStep.uncertain,
            messageKey: 'google.cancelFailed',
          ),
        );
        return false;
      }
      _emit(const GoogleAuthState());
      return true;
    } catch (_) {
      _emit(
        const GoogleAuthState(
          step: GoogleAuthStep.uncertain,
          messageKey: 'google.cancelFailed',
        ),
      );
      return false;
    } finally {
      _cancelling = false;
      if (!_disposed) notifyListeners();
    }
  }

  /// Loads the ticket persisted by an earlier process into [_pending] and
  /// returns whether an intent is now loaded. An unreadable store confirms
  /// nothing: its ticket stays on disk for a later read and server
  /// cancellation, while begin() keeps refusing to replace it. Only a ticket
  /// that no server call can cancel or resume is removed.
  Future<bool> _loadPersistedTicket() async {
    if (_store == null) return false;
    try {
      // Keep it loaded: an unconfirmed cancellation leaves an explicit,
      // recoverable intent that begin() never replaces with a new choice.
      _pending = await _readPersistedTicket();
    } catch (_) {
      return false;
    }
    return _pending != null;
  }

  /// Reads the ticket persisted by an earlier process, or null if there is
  /// none. A temporarily unreadable store (secure_storage_failed, or any other
  /// error) rethrows and keeps the ticket for a later read. A ticket that can
  /// never be read again (secure_storage_corrupt: failed AES-GCM
  /// authentication, invalid format or lost Keystore key) or decoded is
  /// unusable: no API call can cancel or resume it, so it is removed without
  /// one and reported as a failed attempt that may be started again. A stale
  /// copy of a cancellation that the API confirmed in this process counts as
  /// none: only its removal is retried, without any API call.
  Future<_PendingGoogleIntent?> _readPersistedTicket() async {
    final String? saved;
    try {
      saved = await _store!.readPendingAuthentication();
    } on GoogleCredentialException catch (error) {
      if (error.code != 'secure_storage_corrupt') rethrow;
      await _dropUnusableTicket();
      throw const _GooglePublicFailure('google.error');
    }
    if (saved == null) return null;
    final _PendingGoogleIntent intent;
    try {
      intent = _PendingGoogleIntent.decode(saved);
    } on _GooglePublicFailure {
      await _dropUnusableTicket();
      throw const _GooglePublicFailure('google.error');
    }
    if (_confirmedCancellations.contains(intent.serverIntent)) {
      await _removeCancelledTicket(intent);
      return null;
    }
    return intent;
  }

  Future<void> _dropUnusableTicket() async {
    try {
      await _clearPending();
    } catch (_) {
      // Nothing is loaded: a failed removal is retried by the next cancel.
    }
  }

  Future<bool> _cancelServer() async {
    final pending = _pending;
    if (pending != null) {
      try {
        await _api!.cancelGoogleAuth(
          browserContext: pending.browser,
          contextToken: pending.ticket,
          challengeId: pending.stage == 'challenge'
              ? pending.challengeId
              : null,
        );
      } on ApiFailure catch (error) {
        // Expired or already consumed by a finalization: the server holds no
        // pending intent for this ticket, so nothing is left to cancel. A
        // claim was reconciled through /me before this call.
        if (error.code != 'google_context_expired' &&
            error.code != 'google_context_consumed') {
          return false;
        }
      } catch (_) {
        return false;
      }
    }
    // The server holds no pending intent for this ticket any more. As in
    // _complete(), a failed local removal cannot trap Back. A stale copy read
    // later in this process only has its removal retried; a new process,
    // which no longer knows this confirmation, cancels it again on the server.
    await _removeCancelledTicket(pending);
    _pending = null;
    _clearBlocks();
    return true;
  }

  /// Best-effort removal of a ticket that the server no longer holds. While
  /// it fails, [cancelled] is remembered so that this process never asks the
  /// API about it again.
  Future<void> _removeCancelledTicket(_PendingGoogleIntent? cancelled) async {
    try {
      await _store?.clearPendingAuthentication();
      _confirmedCancellations.clear();
    } catch (_) {
      // Only an encrypted ticket that the server no longer holds may remain.
      if (cancelled != null) {
        _confirmedCancellations.add(cancelled.serverIntent);
      }
    }
  }

  Future<bool> _clearPending() async {
    await _store?.clearPendingAuthentication();
    _pending = null;
    _clearBlocks();
    return true;
  }

  void _clearBlocks() {
    _retryAfter = null;
    _emailRetryAfter = null;
    _securityChallengeBlocked = false;
    _discardSecurityProof();
  }

  void _rememberRetryAfter(Object error) {
    final serverRetry = error is ApiFailure ? error.retryAfterSeconds : null;
    if (serverRetry != null) {
      final next = now.add(Duration(seconds: serverRetry.clamp(0, 86400)));
      if (_retryAfter == null || next.isAfter(_retryAfter!)) _retryAfter = next;
    }
  }

  static bool _isTurnstileFailure(Object error) =>
      error is ApiFailure &&
      const {
        'turnstile_required',
        'turnstile_invalid',
        'turnstile_unavailable',
      }.contains(error.code);

  /// Server decisions about the current intent (Retry-After, required
  /// challenge) outlive a Back press, a failed cancellation or a failing /me.
  void _rememberFailureBlocks(Object error) {
    _rememberRetryAfter(error);
    if (_isTurnstileFailure(error) && _registrationContextMatches) {
      _securityChallengeBlocked = true;
    }
  }

  void _failure(Object error, {bool rememberRetryAfter = true}) {
    _discardSecurityProof();
    if (rememberRetryAfter) _rememberRetryAfter(error);
    final isTurnstileFailure = _isTurnstileFailure(error);
    if (isTurnstileFailure && _registrationContextMatches) {
      _securityChallengeBlocked = true;
    }
    final message = isTurnstileFailure && !_registrationContextMatches
        ? 'google.invalidResponse'
        : switch (error) {
            _GooglePublicFailure(:final key) => key,
            ApiFailure(code: 'google_identity_conflict') => 'google.conflict',
            ApiFailure(code: 'invalid_current_password') =>
              'google.invalidPassword',
            ApiFailure(code: 'google_invalid_email_code') =>
              'google.invalidCode',
            ApiFailure(code: 'google_context_expired') => 'google.expired',
            ApiFailure(code: 'account_context_changed') =>
              'google.accountChanged',
            ApiFailure(code: 'invalid_registration') =>
              'google.invalidRegistration',
            ApiFailure(code: 'rate_limited') => 'google.rateLimited',
            ApiFailure(code: 'google_auth_disabled') => 'google.unavailable',
            ApiFailure(code: 'google_unavailable') => 'google.unavailable',
            ApiFailure(code: 'turnstile_required') ||
            ApiFailure(code: 'turnstile_invalid') => 'google.challengeRequired',
            ApiFailure(code: 'turnstile_unavailable') =>
              'google.challengeUnavailable',
            GoogleCredentialException() => 'google.unavailable',
            _ => _pending != null ? 'google.uncertain' : 'google.unavailable',
          };
    final recoverableForm =
        const <String>{
          'google.invalidPassword',
          'google.invalidCode',
          'google.invalidRegistration',
          'google.consentRequired',
          'google.rateLimited',
          'google.conflict',
        }.contains(message) &&
        _state.context != null;
    _emit(
      GoogleAuthState(
        step: recoverableForm
            ? switch (_state.context!.status) {
                'registration_required' => GoogleAuthStep.registrationRequired,
                'guest_claim_required' => GoogleAuthStep.guestClaimRequired,
                _ => GoogleAuthStep.linkRequired,
              }
            : _pending != null
            ? GoogleAuthStep.uncertain
            : GoogleAuthStep.failure,
        messageKey: message,
        context: _state.context,
        emailRequested: _state.emailRequested,
      ),
    );
  }

  Future<void> clearCredentialState() async {
    try {
      await _gateway?.clearCredentialState();
    } catch (_) {}
  }

  Future<void> solveSecurityChallenge({
    required String title,
    required String cancelLabel,
  }) => _run((epoch) async {
    if (_pending == null ||
        !_securityChallengeBlocked ||
        _hasIntentMismatch ||
        _retryBlocked) {
      return;
    }
    _check(epoch);
    final pending = _pending!;
    if (_state.context == null) {
      // A failed cancellation publishes no form context. Reload it so the
      // challenge action shown for this intent proceeds instead of no-op.
      if (pending.stage != 'continuation') return;
      if (!pending.expiresAt.isAfter(now)) {
        throw const _GooglePublicFailure('google.expired');
      }
      await _loadContext(epoch);
    }
    if (!_registrationContextMatches || _state.context == null) return;
    final context = _state.context!;
    final requestId = _requestId();
    _securityRequestId = requestId;
    _discardSecurityProof();
    final expiresAt = now.add(const Duration(minutes: 4));
    try {
      _emit(
        GoogleAuthState(
          step: GoogleAuthStep.verifying,
          context: context,
          messageKey: 'google.verifying',
        ),
      );
      _check(epoch);
      final proof = await _challengeGateway.solve(
        requestId: requestId,
        title: title,
        cancelLabel: cancelLabel,
      );
      _check(epoch);
      if (_securityRequestId != requestId ||
          !identical(_pending, pending) ||
          proof.requestId != requestId ||
          proof.token.isEmpty ||
          proof.token.length > 2048 ||
          !RegExp(r'^[\x21-\x7e]+$').hasMatch(proof.token) ||
          proof.token.contains('\n')) {
        throw SecurityChallengeException('invalid_response');
      }
      if (!expiresAt.isAfter(now)) {
        _emit(
          GoogleAuthState(
            step: GoogleAuthStep.uncertain,
            context: context,
            messageKey: 'google.challengeExpired',
          ),
        );
        return;
      }
      _securityProof = _SecurityProof(proof.token, expiresAt);
      _securityExpiryTimer = Timer(
        expiresAt.difference(now),
        expireSecurityChallenge,
      );
      _emit(
        GoogleAuthState(
          step: context.status == 'guest_claim_required'
              ? GoogleAuthStep.guestClaimRequired
              : GoogleAuthStep.registrationRequired,
          context: context,
          messageKey: 'google.challengeReady',
        ),
      );
    } on SecurityChallengeException catch (error) {
      _check(epoch);
      _emit(
        GoogleAuthState(
          step: GoogleAuthStep.uncertain,
          context: context,
          messageKey: error.code == 'cancelled' || error.code == 'interrupted'
              ? 'google.challengeCancelled'
              : error.code == 'unavailable'
              ? 'google.challengeBlocked'
              : 'google.challengeFailed',
        ),
      );
    } finally {
      if (_securityRequestId == requestId) _securityRequestId = null;
    }
  });

  void expireSecurityChallenge() {
    final proof = _securityProof;
    if (proof == null || proof.expiresAt.isAfter(now)) return;
    _discardSecurityProof();
    _emit(
      GoogleAuthState(
        step: GoogleAuthStep.uncertain,
        context: _state.context,
        messageKey: 'google.challengeExpired',
      ),
    );
  }

  String? _consumeSecurityProof() {
    final proof = _securityProof;
    _discardSecurityProof();
    return proof?.token;
  }

  void _discardSecurityProof() {
    _securityProof = null;
    _securityExpiryTimer?.cancel();
    _securityExpiryTimer = null;
  }

  @override
  void dispose() {
    _disposed = true;
    ++_epoch;
    _discardSecurityProof();
    final securityRequestId = _securityRequestId;
    _securityRequestId = null;
    if (securityRequestId != null) {
      unawaited(
        _challengeGateway
            .cancel(requestId: securityRequestId)
            .catchError((Object _) {}),
      );
    }
    final pending = _pending;
    if (pending != null) {
      unawaited(
        _gateway
                ?.cancelSignIn(requestId: pending.requestId)
                .catchError((Object _) {}) ??
            Future<void>.value(),
      );
    }
    // Persisted server intent is intentionally retained for explicit recovery.
    super.dispose();
  }

  static String _requestId() {
    final random = Random.secure();
    return base64UrlEncode(
      List<int>.generate(24, (_) => random.nextInt(256)),
    ).replaceAll('=', '');
  }
}

class _SecurityProof {
  const _SecurityProof(this.token, this.expiresAt);
  final String token;
  final DateTime expiresAt;
  @override
  String toString() => '_SecurityProof(redacted: true)';
}

class _PendingGoogleIntent {
  const _PendingGoogleIntent({
    required this.requestId,
    required this.purpose,
    required this.stage,
    required this.ticket,
    required this.browser,
    required this.expiresAt,
    this.challengeId,
    this.userId,
  });
  final String requestId;
  final GoogleAuthPurpose purpose;
  final String stage;
  final String ticket;
  final GoogleBrowserContext browser;
  final DateTime expiresAt;
  final String? challengeId;
  final String? userId;

  /// The server intent that a cancellation of this ticket targets.
  (String, String) get serverIntent => (browser.browserContextToken, ticket);

  _PendingGoogleIntent continuation(String token, DateTime expiry) =>
      _PendingGoogleIntent(
        requestId: requestId,
        purpose: purpose,
        stage: 'continuation',
        ticket: token,
        browser: browser,
        expiresAt: expiry,
        challengeId: challengeId,
        userId: userId,
      );

  String encode() => jsonEncode(<String, Object?>{
    'version': 1,
    'request_id': requestId,
    'purpose': purpose.name,
    'stage': stage,
    'ticket': ticket,
    'context': browser.browserContextToken,
    'expires_at': expiresAt.toUtc().toIso8601String(),
    'generation': browser.authGeneration,
    if (challengeId != null) 'challenge_id': challengeId,
    if (userId != null) 'user_id': userId,
  });

  factory _PendingGoogleIntent.decode(String payload) {
    try {
      if (payload.length > 16384) throw const FormatException();
      final raw = jsonDecode(payload);
      if (raw is! Map<String, dynamic> ||
          raw['version'] != 1 ||
          raw.keys.any(
            (key) => !const <String>{
              'version',
              'request_id',
              'purpose',
              'stage',
              'ticket',
              'context',
              'expires_at',
              'challenge_id',
              'user_id',
              'generation',
            }.contains(key),
          )) {
        throw const FormatException();
      }
      String text(String key) {
        final value = raw[key];
        if (value is! String ||
            value.isEmpty ||
            value.length > 8192 ||
            value.contains(RegExp(r'[\x00-\x1f]'))) {
          throw const FormatException();
        }
        return value;
      }

      final purpose = GoogleAuthPurpose.values.byName(text('purpose'));
      final stage = text('stage');
      if (!const <String>{
            'challenge',
            'continuation',
            'uncertain',
          }.contains(stage) ||
          raw['generation'] is! int ||
          (raw['generation'] as int) < 1) {
        throw const FormatException();
      }
      final expiry = DateTime.parse(text('expires_at'));
      return _PendingGoogleIntent(
        requestId: text('request_id'),
        purpose: purpose,
        stage: stage,
        ticket: text('ticket'),
        expiresAt: expiry,
        browser: GoogleBrowserContext(
          browserContextToken: text('context'),
          authGeneration: raw['generation'] as int,
          expiresAt: expiry,
        ),
        challengeId: raw.containsKey('challenge_id')
            ? text('challenge_id')
            : null,
        userId: raw.containsKey('user_id') ? text('user_id') : null,
      );
    } catch (_) {
      throw const _GooglePublicFailure('google.invalidResponse');
    }
  }

  @override
  String toString() => '_PendingGoogleIntent(redacted: true)';
}

class _GoogleIntentCancelled implements Exception {
  const _GoogleIntentCancelled();
}

class _GooglePublicFailure implements Exception {
  const _GooglePublicFailure(this.key);
  final String key;
}
