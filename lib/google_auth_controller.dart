import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'core/api_exception.dart';
import 'core/google_auth.dart';
import 'core/google_credentials.dart';

enum GoogleAuthPurpose { authenticate, claim, link }

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
  });

  final GoogleAuthStep step;
  final String? messageKey;
  final GoogleAuthContext? context;
  final bool emailRequested;
  final DateTime? retryAfter;
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
       _admitClaim = admitClaim ?? ((_, _) async => false);

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
  GoogleAuthState _state = const GoogleAuthState();
  GoogleAuthState get state => _state;
  _PendingGoogleIntent? _pending;
  GoogleIdentitySnapshot? _before;
  Future<void>? _action;
  Future<void> _storageWrites = Future<void>.value();
  bool _disposed = false;
  bool _cancelling = false;
  bool _admitted = false;
  int _epoch = 0;

  bool get isBusy => _action != null || _cancelling;
  bool get hasPendingIntent => _pending != null || isBusy;

  void _emit(GoogleAuthState value) {
    _state = value;
    if (!_disposed) notifyListeners();
  }

  bool _current(int epoch) => !_disposed && !_cancelling && epoch == _epoch;

  bool _anchored(int epoch) =>
      _current(epoch) && _before != null && _identityMatches(_before!);

  void _check(int epoch) {
    if (!_anchored(epoch)) throw const _GoogleIntentCancelled();
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
        if (_current(epoch)) _failure(error);
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
    if (_pending != null) {
      _emit(
        const GoogleAuthState(
          step: GoogleAuthStep.uncertain,
          messageKey: 'google.uncertain',
        ),
      );
      return;
    }
    if (!_canBegin(purpose)) return;
    _before = _identity();
    _admitted = false;
    _emit(const GoogleAuthState(step: GoogleAuthStep.selectingAccount));
    // Read before creating an intent: process death must never replace an
    // unresolved server intent with another account selection.
    final saved = await _store.readPendingAuthentication();
    _check(epoch);
    if (saved != null) {
      _pending = _PendingGoogleIntent.decode(saved);
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
    _emit(GoogleAuthState(step: step, context: context));
  }

  Future<void> resume() => _run((epoch) async {
    if (_api == null || _store == null) return;
    _before ??= _identity();
    if (_pending == null) {
      final saved = await _store.readPendingAuthentication();
      _check(epoch);
      if (saved == null) return;
      _pending = _PendingGoogleIntent.decode(saved);
    } else {
      // Memory may contain a rotated ticket whose atomic disk commit failed.
      // Never replace it with the superseded challenge ticket from disk.
      await _writePending(_pending!, epoch);
    }
    await _resume(epoch);
  });

  Future<void> _resume(int epoch) async {
    final pending = _pending!;
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
    if (pending.stage != 'continuation' ||
        !pending.expiresAt.isAfter(DateTime.now())) {
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
    if (_pending == null ||
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
    if (pending.purpose == GoogleAuthPurpose.claim) {
      Object? failure;
      try {
        final result = await _api!.claimGuestWithGoogle(
          browserContext: pending.browser,
          contextToken: pending.ticket,
          countryCode: countryCode,
          termsAccepted: termsAccepted,
          privacyAccepted: privacyAccepted,
        );
        _check(epoch);
        if (result.userId != _before!.userId ||
            result.identityKind != 'registered') {
          throw const _GooglePublicFailure('google.accountChanged');
        }
      } catch (error) {
        failure = error;
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
      );
      _check(epoch);
      await _accept(result, epoch);
    } catch (error) {
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
    if (_pending == null || _state.step != GoogleAuthStep.linkRequired) return;
    _check(epoch);
    final previous = _state;
    _emit(
      GoogleAuthState(
        step: GoogleAuthStep.verifying,
        context: previous.context,
      ),
    );
    try {
      final result = await action(_pending!);
      _check(epoch);
      await _accept(result, epoch);
    } catch (error) {
      _check(epoch);
      _emit(previous);
      _failure(error);
    }
  });

  Future<void> requestEmailLink() => _run((epoch) async {
    if (_pending == null ||
        _state.step != GoogleAuthStep.linkRequired ||
        (_state.retryAfter?.isAfter(DateTime.now()) ?? false)) {
      return;
    }
    _check(epoch);
    final previous = _state;
    await _api!.requestGoogleLinkEmail(
      browserContext: _pending!.browser,
      contextToken: _pending!.ticket,
    );
    _check(epoch);
    _emit(
      GoogleAuthState(
        step: GoogleAuthStep.linkRequired,
        context: previous.context,
        emailRequested: true,
        retryAfter: DateTime.now().add(const Duration(seconds: 60)),
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
    _emit(const GoogleAuthState(step: GoogleAuthStep.authenticated));
  }

  Future<bool> cancel() async {
    if (_disposed || _cancelling) return false;
    if (_admitted) return true;
    _cancelling = true;
    ++_epoch;
    if (!_disposed) notifyListeners();
    try {
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
      // If cancellation raced a committed guest claim, keep that same account.
      if (_pending?.purpose == GoogleAuthPurpose.claim &&
          _before != null &&
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
        if (error.code != 'google_context_expired') return false;
      } catch (_) {
        return false;
      }
    }
    await _store?.clearPendingAuthentication();
    _pending = null;
    return true;
  }

  void _failure(Object error) {
    final serverRetry = error is ApiFailure ? error.retryAfterSeconds : null;
    final retryAfter = serverRetry == null
        ? _state.retryAfter
        : DateTime.now().add(Duration(seconds: serverRetry.clamp(1, 3600)));
    final message = switch (error) {
      _GooglePublicFailure(:final key) => key,
      ApiFailure(code: 'google_identity_conflict') => 'google.conflict',
      ApiFailure(code: 'invalid_current_password') => 'google.invalidPassword',
      ApiFailure(code: 'google_invalid_email_code') => 'google.invalidCode',
      ApiFailure(code: 'google_context_expired') => 'google.expired',
      ApiFailure(code: 'account_context_changed') => 'google.accountChanged',
      ApiFailure(code: 'invalid_registration') => 'google.invalidRegistration',
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
          'google.challengeRequired',
          'google.challengeUnavailable',
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
        retryAfter: retryAfter,
      ),
    );
  }

  Future<void> clearCredentialState() async {
    try {
      await _gateway?.clearCredentialState();
    } catch (_) {}
  }

  @override
  void dispose() {
    _disposed = true;
    ++_epoch;
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
