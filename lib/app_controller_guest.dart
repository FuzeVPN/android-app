part of 'app_controller.dart';

/// Outcome of an automatic guest admission (resume or token renewal).
enum _GuestRecovery {
  /// The guest session is adopted and its account restored.
  admitted,

  /// A new session is committed; only its account restoration is pending.
  pending,

  /// A temporary failure (network, 429/5xx, Keystore): nothing was adopted or
  /// revoked, and a later attempt may succeed.
  deferred,

  /// Another reset, purchase, connection or renewal owns this moment.
  busy,

  /// Not applicable, definitively refused, or abandoned.
  refused,
}

/// Guest credentials never enter preferences, diagnostics or presentation.
extension GuestAccountsController on VpnAppController {
  bool _syncGuestHomeAdmission() {
    final value = profile;
    if (!isSignedIn ||
        value == null ||
        !value.isGuest ||
        _guestHomeUserId == value.userId) {
      return false;
    }
    final subscription = _billing.subscription;
    final verifiedAccess = value.canUseVpn && subscription?.hasAccess == true;
    // Older installs have no UI marker. An existing VPN identity or an expired
    // server-confirmed Play subscription also proves a previous activation.
    final previousSubscription =
        subscription?.provider == 'google_play' &&
        subscription?.expiresAt != null &&
        const {
          'expired',
          'canceled',
          'past_due',
          'withdrawn',
        }.contains(subscription?.status);
    if (!verifiedAccess && currentDeviceId == null && !previousSubscription) {
      return false;
    }
    _guestHomeUserId = value.userId;
    final store = _sessionStore;
    if (store is GuestOnboardingStore) {
      final operation = _sessionOperation;
      unawaited(() async {
        try {
          operation.check();
          await (store as GuestOnboardingStore).writeGuestOnboardingCompleted(
            userId: value.userId,
          );
        } catch (_) {
          // This UI marker grants no VPN rights. A valid subscription can
          // reconstruct it on the next launch even if local persistence fails.
        }
      }());
    }
    return true;
  }

  GuestApiRepository? get _guestApi =>
      _api is GuestApiRepository ? _api as GuestApiRepository : null;
  GuestCredentialStore? get _guestStore => _sessionStore is GuestCredentialStore
      ? _sessionStore as GuestCredentialStore
      : null;

  String _newGuestCredential() {
    final random = Random.secure();
    return base64Url
        .encode(List<int>.generate(32, (_) => random.nextInt(256)))
        .replaceAll('=', '');
  }

  void _ensureAnonymousGuestScope() {
    if (_session == null &&
        sessionTermination == null &&
        _terminationTask == null &&
        !_sessionOperation.isCurrent) {
      _sessionOperation = SessionOperation();
      _sessionExpired = false;
    }
  }

  void _guestFailure(Object error, {required String fallback}) {
    _guestMessage = switch (error) {
      ApiFailure(code: 'account_login_required') => 'guest.loginRequired',
      ApiFailure(code: 'email_exists') => 'guest.emailExists',
      NativeVpnException() => 'guest.secureStorageError',
      ApiFailure(statusCode: 503) => 'guest.serviceUnavailable',
      _ => fallback,
    };
    if (error is ApiFailure &&
        error.statusCode != null &&
        _isTransientFailure(error)) {
      _guestRetryTimer?.cancel();
      final seconds = (error.retryAfterSeconds ?? 5).clamp(1, 60);
      _guestRetryAfter = DateTime.now().add(Duration(seconds: seconds));
      _guestRetryTimer = Timer(Duration(seconds: seconds), () {
        _guestRetryTimer = null;
        _guestRetryAfter = null;
        if (!_disposed) notifyListeners();
      });
    }
  }

  bool _guestCurrent(Object owner, SessionOperation operation) =>
      !_disposed &&
      operation.isCurrent &&
      identical(operation, _sessionOperation) &&
      identical(owner, _guestActionOwner);

  Future<bool> _beginGuestPurchase(PlaySubscriptionPlan plan) async {
    if (_disposed ||
        isGuestActionBusy ||
        isAuthenticating ||
        isInitializing ||
        sessionTermination != null ||
        _billing.isBusy) {
      return false;
    }
    final owner = Object();
    _ensureAnonymousGuestScope();
    _guestActionOwner = owner;
    final operation = _sessionOperation;
    _guestMessage = null;
    notifyListeners();
    try {
      // Discover existing/pending purchases before creating a new principal.
      // The receipt can recover its original guest, never transfer ownership.
      final purchases = await _billing.queryRecoveryPurchases();
      if (!_guestCurrent(owner, operation)) return false;
      if (purchases.isNotEmpty) {
        if (isSignedIn) {
          await _billing.restorePurchases();
          await refreshGuestAccount();
          _guestMessage = _billing.messageKey;
          return false;
        }
        return await _recoverGuestPurchase(purchases, owner, operation);
      }
      if (!isSignedIn) {
        final store = _guestStore;
        final api = _guestApi;
        if (store == null || api == null) {
          _guestMessage = 'guest.serviceUnavailable';
          return false;
        }
        var credential = await store.readGuestCredential();
        if (!_guestCurrent(owner, operation)) return false;
        if (credential == null) {
          credential = _newGuestCredential();
          await store.writeGuestCredential(credential);
        }
        if (!_guestCurrent(owner, operation)) return false;
        // Written before HTTP: a lost response resumes the same owner later.
        await store.writeGuestAutoResume(true);
        if (!_guestCurrent(owner, operation)) return false;
        final result = await api.createGuestSession(
          guestCredential: credential,
          termsAccepted: true,
          privacyAccepted: true,
        );
        if (!_guestCurrent(owner, operation)) return false;
        if (!await _adoptGuestSession(result, operation)) return false;
      }
      if (!_guestCurrent(owner, operation)) return false;
      // Adopting an account invalidates the anonymous catalogue. Requery and
      // require exactly the price/offer the user selected before launching.
      await _billing.loadPlans();
      if (!_guestCurrent(owner, operation)) return false;
      final matches = _billing.plans.where((p) => p.sameOffer(plan));
      if (matches.isEmpty) {
        _guestMessage = 'billing.storeUnavailable';
        return false;
      }
      await _billing.purchase(matches.first);
      return _guestCurrent(owner, operation);
    } on SessionOperationCancelled {
      return false;
    } catch (error) {
      if (_guestCurrent(owner, operation)) {
        _guestFailure(error, fallback: 'billing.purchaseError');
      }
      return false;
    } finally {
      if (identical(_guestActionOwner, owner)) {
        _guestActionOwner = null;
        if (!_disposed) notifyListeners();
      }
    }
  }

  Future<bool> _restoreGuestPurchases() async {
    if (_disposed ||
        isGuestActionBusy ||
        isAuthenticating ||
        isInitializing ||
        sessionTermination != null ||
        _billing.isBusy) {
      return false;
    }
    final owner = Object();
    _ensureAnonymousGuestScope();
    final operation = _sessionOperation;
    _guestActionOwner = owner;
    _guestMessage = 'billing.verifying';
    notifyListeners();
    try {
      if (isSignedIn) {
        await _billing.restorePurchases();
        if (!_guestCurrent(owner, operation)) return false;
        await refreshGuestAccount();
        _guestMessage = _billing.messageKey;
        return profile?.canUseVpn == true &&
            _billing.subscription?.hasAccess == true;
      }
      final purchases = await _billing.queryRecoveryPurchases();
      if (!_guestCurrent(owner, operation)) return false;
      return await _recoverGuestPurchase(purchases, owner, operation);
    } on SessionOperationCancelled {
      return false;
    } catch (error) {
      if (_guestCurrent(owner, operation)) {
        _guestFailure(error, fallback: 'guest.restoreError');
      }
      return false;
    } finally {
      if (identical(_guestActionOwner, owner)) {
        _guestActionOwner = null;
        if (!_disposed) notifyListeners();
      }
    }
  }

  Future<bool> _recoverGuestPurchase(
    List<PlayPurchase> purchases,
    Object owner,
    SessionOperation operation,
  ) async {
    if (purchases.isEmpty) {
      _guestMessage = 'billing.restoreEmpty';
      return false;
    }
    final store = _guestStore;
    final api = _guestApi;
    if (store == null || api == null) {
      _guestMessage = 'guest.serviceUnavailable';
      return false;
    }
    // Refuse an ambiguous set of unrelated active owners. Never pick a
    // different owner's receipt silently or bind an existing credential to it.
    final owners = purchases.map((p) => p.obfuscatedAccountId).toSet();
    if (owners.length != 1 || purchases.length != 1) {
      _guestMessage = 'guest.restoreError';
      return false;
    }
    final purchase = purchases.single;
    var pending = await store.readPendingGuestCredential();
    if (!_guestCurrent(owner, operation)) return false;
    if (pending == null) {
      // An explicit restore may resume this device's retained credential.
      // Only the server, after checking the receipt, may confirm its owner.
      // Keep a separate pending slot so a lost reply retries the same pair.
      pending = await store.readGuestCredential();
      if (!_guestCurrent(owner, operation)) return false;
      pending ??= _newGuestCredential();
      await store.writePendingGuestCredential(pending);
    }
    if (!_guestCurrent(owner, operation)) return false;
    GuestRestoreResult result;
    try {
      result = await api.restoreGuestSession(
        purchaseToken: purchase.purchaseToken,
        guestCredential: pending,
      );
    } on ApiFailure catch (error) {
      if (error.statusCode != 409 ||
          error.code != 'guest_credential_conflict') {
        rethrow;
      }
      if (!_guestCurrent(owner, operation)) return false;
      // A certain owner conflict never reassigns the retained credential.
      // Persist a fresh recovery credential before the single retry. A 503,
      // lost reply or registered owner leaves the original pending pair intact.
      pending = _newGuestCredential();
      await store.writePendingGuestCredential(pending);
      if (!_guestCurrent(owner, operation)) return false;
      result = await api.restoreGuestSession(
        purchaseToken: purchase.purchaseToken,
        guestCredential: pending,
      );
    }
    if (!_guestCurrent(owner, operation)) return false;
    // Native storage promotes active and removes pending atomically.
    await store.writeGuestCredential(pending);
    if (!_guestCurrent(owner, operation)) return false;
    await store.writeGuestAutoResume(true);
    if (!_guestCurrent(owner, operation)) return false;
    if (!await _adoptGuestSession(result, operation)) return false;
    if (!_guestCurrent(owner, operation)) return false;
    _billing.acceptRecoveredSubscription(
      recovered: result.subscription,
      purchaseStatus: result.purchaseStatus,
      purchase: purchase,
    );
    _guestMessage = result.purchaseStatus == 'pending'
        ? 'billing.pending'
        : _billing.messageKey;
    if (!result.subscription.hasAccess) {
      await _billing.loadPlans();
      if (!_guestCurrent(owner, operation)) return false;
    }
    return result.purchaseStatus == 'verified' &&
        result.subscription.hasAccess &&
        profile?.canUseVpn == true;
  }

  Future<bool> _adoptGuestSession(
    GuestSessionResult result,
    SessionOperation operation, {
    bool Function()? authorizationCurrent,
    void Function()? onSessionWriteSubmitted,
  }) async {
    void check() {
      operation.check();
      if (authorizationCurrent?.call() == false) {
        throw const SessionOperationCancelled();
      }
    }

    check();
    // The server owns the expiry of the session it just delivered: a device
    // clock running ahead must not reject it (its later 401s still count).
    if (!result.isGuest) throw const ApiProtocolException();
    _issuedSession = result.session;
    final verified = await _api.me(result.session.accessToken);
    check();
    if (verified.userId != result.userId || !verified.isGuest) {
      throw const ApiProtocolException();
    }
    await _sessionWrite(operation, () {
      check();
      onSessionWriteSubmitted?.call();
      return _sessionStore.writeSession(result.session, userId: result.userId);
    });
    check();
    // Automatic recovery is blocked, so only an explicit guest action admits
    // a guest now: that choice supersedes the earlier registered intent.
    _guestRecoveryBlocked = false;
    _session = result.session;
    final restored = await _restoreAccount(
      verificationNeeded: false,
      notify: false,
      expectedUserId: result.userId,
      authorizationCurrent: authorizationCurrent,
    );
    check();
    notifyListeners();
    return restored;
  }

  Future<bool> _refreshGuestAccount() {
    final existing = _guestRefreshTask;
    if (existing != null) {
      _guestRefreshQueued = true;
      return existing;
    }
    final done = Completer<bool>();
    _guestRefreshTask = done.future;
    unawaited(() async {
      var refreshed = false;
      try {
        do {
          _guestRefreshQueued = false;
          refreshed = await _performGuestProfileRefresh();
        } while (_guestRefreshQueued && !_disposed && profile != null);
        done.complete(refreshed);
      } catch (_) {
        done.complete(false);
      } finally {
        if (identical(_guestRefreshTask, done.future)) {
          _guestRefreshTask = null;
          _guestRefreshQueued = false;
        }
      }
    }());
    return done.future;
  }

  Future<bool> _performGuestProfileRefresh() async {
    final before = profile;
    final activeToken = token;
    if (_guestRefreshing) {
      _guestRefreshQueued = true;
      return false;
    }
    if (_disposed || before == null || activeToken == null || _guestRenewing) {
      return false;
    }
    final operation = _sessionOperation;
    _guestRefreshing = true;
    try {
      final next = await _api.me(activeToken);
      operation.check();
      if (token != activeToken ||
          profile?.userId != before.userId ||
          next.userId != before.userId) {
        return false;
      }
      profile = next;
      if (next.profileRedacted) mayNeedEmailVerification = false;
      notifyListeners();
      return true;
    } on SessionOperationCancelled {
      return false;
    } on ApiFailure catch (error) {
      if (operation.isCurrent) await _handleSessionFailure(error, operation);
      return false;
    } finally {
      _guestRefreshing = false;
    }
  }

  Future<bool> _claimGuestAccount({
    required String email,
    required String password,
  }) async {
    final before = profile;
    final activeToken = token;
    final api = _guestApi;
    if (_disposed ||
        api == null ||
        before == null ||
        activeToken == null ||
        !before.canClaimAccount ||
        isGuestActionBusy ||
        isAuthenticating) {
      return false;
    }
    final owner = Object();
    final operation = _sessionOperation;
    _guestActionOwner = owner;
    _guestMessage = null;
    notifyListeners();
    Object? failure;
    try {
      try {
        await api.claimGuestAccount(
          token: activeToken,
          email: email.trim(),
          password: password,
        );
      } catch (error) {
        failure = error;
      }
      if (!_guestCurrent(owner, operation)) return false;
      // A lost response may follow an already committed conversion. The
      // initiator's unchanged token is the sole source of personal permissions.
      final next = await _api.me(activeToken);
      if (!_guestCurrent(owner, operation)) return false;
      if (next.userId != before.userId) throw const ApiProtocolException();
      profile = next;
      if (!next.isGuest &&
          next.canManageAccount &&
          !next.profileRedacted &&
          next.email.trim().toLowerCase() == email.trim().toLowerCase()) {
        mayNeedEmailVerification = next.emailVerified != true;
        // Claim never rewrites the session or touches keys/device/tunnel.
        // A cleanup failure cannot undo an already committed conversion.
        await _safe<void>(
          _guestStore?.clearGuestCredentials() ?? Future<void>.value(),
        );
        if (!_guestCurrent(owner, operation)) return false;
        _guestMessage = 'guest.claimSuccess';
        return true;
      }
      if (!next.isGuest || !next.canClaimAccount) {
        _guestMessage = 'guest.loginRequired';
      } else {
        _guestFailure(
          failure ?? const ApiProtocolException(),
          fallback: 'guest.claimError',
        );
      }
      return false;
    } on SessionOperationCancelled {
      return false;
    } catch (error) {
      if (_guestCurrent(owner, operation)) {
        _guestFailure(failure ?? error, fallback: 'guest.claimError');
      }
      return false;
    } finally {
      if (identical(_guestActionOwner, owner)) {
        _guestActionOwner = null;
        if (!_disposed) notifyListeners();
      }
    }
  }

  void _guestBillingChanged() {
    if (_disposed) return;
    if (_syncGuestHomeAdmission()) {
      scheduleMicrotask(() {
        if (!_disposed) notifyListeners();
      });
    }
    final value = profile;
    if (value == null ||
        (!value.isGuest &&
            !value.profileRedacted &&
            value.canUseVpn &&
            _billing.subscription?.provider != 'google_play')) {
      _guestObservedAccess = null;
      return;
    }
    final access = _billing.subscription?.hasAccess;
    if (access == null || access == _guestObservedAccess) return;
    _guestObservedAccess = access;
    scheduleMicrotask(() {
      if (!_disposed) unawaited(refreshGuestAccount());
    });
  }

  void _invalidateGuestResume() {
    // Termination invalidates the session scope first. A new login must not
    // wait for the abandoned lookup; its old callback still owns that scope.
    _guestResumeTask = null;
    _guestResuming = false;
  }

  Future<_GuestRecovery> _resumeGuestSession(
    SessionOperation operation, {
    AuthSession? previous,
  }) {
    // A registered intent whose opt-out could not be committed yet.
    if (_guestRecoveryBlocked) return Future.value(_GuestRecovery.refused);
    if (isAuthenticating) return Future.value(_GuestRecovery.busy);
    final existing = _guestResumeTask;
    if (existing != null) return existing;
    if (profile?.isGuest == false) return Future.value(_GuestRecovery.refused);
    if (_guestActionOwner != null) return Future.value(_GuestRecovery.busy);
    final done = Completer<_GuestRecovery>();
    _guestResumeTask = done.future;
    _guestResuming = true;
    _ensureAnonymousGuestScope();
    final activeOperation = operation.isCurrent ? operation : _sessionOperation;
    unawaited(() async {
      try {
        done.complete(
          await _performGuestResume(activeOperation, previous: previous),
        );
      } on SessionOperationCancelled {
        done.complete(_GuestRecovery.refused);
      } catch (_) {
        done.complete(_GuestRecovery.refused);
      } finally {
        if (identical(_guestResumeTask, done.future)) {
          _guestResumeTask = null;
          _guestResuming = false;
          if (!_disposed) notifyListeners();
        }
      }
    }());
    return done.future;
  }

  Future<_GuestRecovery> _performGuestResume(
    SessionOperation operation, {
    AuthSession? previous,
  }) async {
    final api = _guestApi;
    final store = _guestStore;
    if (api == null || store == null || _disposed || sessionTermination != null) {
      return _GuestRecovery.refused;
    }
    if (isAuthenticating || _guestRenewing) return _GuestRecovery.busy;
    final originalSession = _session;
    final originalUserId = profile?.userId;
    final authenticationGeneration = _authenticationGeneration;
    AuthSession? candidateSession;
    String? candidateUserId;
    var sessionWriteSubmitted = false;
    bool authorizationCurrent() {
      final currentUserId = profile?.userId;
      // Admission may replace its own session and profile, never another one.
      return !_disposed &&
          !isAuthenticating &&
          authenticationGeneration == _authenticationGeneration &&
          sessionTermination == null &&
          identical(operation, _sessionOperation) &&
          operation.isCurrent &&
          (identical(_session, originalSession) ||
              (candidateSession != null &&
                  identical(_session, candidateSession))) &&
          (currentUserId == null ||
              currentUserId == originalUserId ||
              currentUserId == candidateUserId);
    }

    void check() {
      operation.check();
      if (!authorizationCurrent()) throw const SessionOperationCancelled();
    }

    Future<void> reconcileSubmittedWrite() async {
      // A submitted write can commit before cancellation or a late exception.
      // A logout or a newer account owns its own cleanup; never purge it.
      // This abandoned automatic admission only erases what it may have
      // committed: it is neither an expiry nor a logout, so automatic
      // recovery, its message and any Retry-After delay are kept.
      final currentUserId = profile?.userId;
      if (sessionWriteSubmitted &&
          !_disposed &&
          operation.isCurrent &&
          identical(operation, _sessionOperation) &&
          sessionTermination == null &&
          (identical(_session, originalSession) ||
              identical(_session, candidateSession)) &&
          (currentUserId == null ||
              currentUserId == originalUserId ||
              currentUserId == candidateUserId)) {
        await _terminateSession(abandoned: true);
      }
    }

    // A committed candidate whose restoration failed stays pending; anything
    // else (a 401 already ended it) is refused.
    _GuestRecovery restorationOutcome(bool restored) => restored
        ? _GuestRecovery.admitted
        : candidateSession != null &&
              identical(_session, candidateSession) &&
              sessionTermination == null
        ? _GuestRecovery.pending
        : _GuestRecovery.refused;

    check();
    _guestRecoveryDeferred = false;
    try {
      if (!await store.readGuestAutoResume()) return _GuestRecovery.refused;
      check();
      final credential = await store.readGuestCredential();
      check();
      if (credential == null) return _GuestRecovery.refused;
      final result = await api.createGuestSession(guestCredential: credential);
      check();
      candidateSession = result.session;
      candidateUserId = result.userId;
      _issuedSession = result.session;
      if (previous != null && _sessionStore is GuestSessionRenewalStore) {
        final next = await _api.me(result.session.accessToken);
        check();
        if (!next.isGuest || next.userId != result.userId) {
          throw const ApiProtocolException();
        }
        await _sessionWrite(operation, () {
          check();
          sessionWriteSubmitted = true;
          return (_sessionStore as GuestSessionRenewalStore)
              .replaceGuestSession(result.session, userId: result.userId);
        });
        check();
        _session = result.session;
        return restorationOutcome(
          await _restoreAccount(
            notify: false,
            expectedUserId: result.userId,
            authorizationCurrent: authorizationCurrent,
          ),
        );
      }
      return restorationOutcome(
        await _adoptGuestSession(
          result,
          operation,
          authorizationCurrent: authorizationCurrent,
          onSessionWriteSubmitted: () => sessionWriteSubmitted = true,
        ),
      );
    } on SessionOperationCancelled {
      await reconcileSubmittedWrite();
      rethrow;
    } catch (error) {
      if (!authorizationCurrent()) {
        await reconcileSubmittedWrite();
        return _GuestRecovery.refused;
      }
      // Published first: an abandoned admission's purge keeps this message.
      _guestFailure(error, fallback: 'guest.serviceUnavailable');
      if (!sessionWriteSubmitted && _isTransientFailure(error)) {
        _guestRecoveryDeferred = true;
        _guestRecoveryTarget = previous;
        return _GuestRecovery.deferred;
      }
      await reconcileSubmittedWrite();
      return _GuestRecovery.refused;
    }
  }

  /// [owner] is the connection or identity work whose request was refused: it
  /// hands its session over to the renewal and is released if it succeeds.
  Future<_GuestRecovery> _renewGuestSession({Object? owner}) {
    final existing = _guestRenewalTask;
    if (existing != null) return existing;
    final done = Completer<_GuestRecovery>();
    _guestRenewalTask = done.future;
    unawaited(() async {
      try {
        done.complete(await _performGuestSessionRenewal(owner));
      } catch (_) {
        done.complete(_GuestRecovery.refused);
      } finally {
        if (identical(_guestRenewalTask, done.future)) {
          _guestRenewalTask = null;
        }
      }
    }());
    return done.future;
  }

  Future<_GuestRecovery> _performGuestSessionRenewal(Object? owner) async {
    final before = profile;
    final api = _guestApi;
    final store = _guestStore;
    final renewal = _sessionStore;
    if (_disposed ||
        before?.isGuest != true ||
        api == null ||
        store == null ||
        renewal is! GuestSessionRenewalStore) {
      return _GuestRecovery.refused;
    }
    bool ownedByOther(Object? current) =>
        current != null && !identical(current, owner);
    if (isAuthenticating ||
        _guestRenewing ||
        _guestActionOwner != null ||
        ownedByOther(_connectionOwner) ||
        ownedByOther(_identityMutationOwner) ||
        (isConnecting && _connectionOwner == null)) {
      return _GuestRecovery.busy;
    }
    // The server's Retry-After delay owns the next attempt (A13-dart-vpn-02).
    if (_guestRetryTimer != null) return _GuestRecovery.deferred;
    final oldOperation = _sessionOperation;
    final renewalOwner = Object();
    _guestRenewalOwner = renewalOwner;
    _guestRenewing = true;
    try {
      if (!await store.readGuestAutoResume()) return _GuestRecovery.refused;
      oldOperation.check();
      final credential = await store.readGuestCredential();
      oldOperation.check();
      if (credential == null) return _GuestRecovery.refused;
      final result = await api.createGuestSession(guestCredential: credential);
      oldOperation.check();
      final next = await _api.me(result.session.accessToken);
      oldOperation.check();
      // The server owns the expiry of the session it just delivered.
      if (!next.isGuest ||
          next.userId != before!.userId ||
          result.userId != before.userId) {
        throw const ApiProtocolException();
      }
      _issuedSession = result.session;
      final migration = locationMigration;
      // Retire old authorizations before committing the new token. Late 401
      // responses and old writes can no longer end this renewed session. The
      // connection or identity work of the retired operation is released with
      // them: the owner that handed its session over, and any work started
      // meanwhile, which can no longer release itself.
      oldOperation.invalidate();
      _invalidateListRefreshes();
      _resetMigration();
      if (_connectionOwner != null) {
        _connectionOwner = null;
        isConnecting = false;
      }
      if (_identityMutationOwner != null) {
        _identityMutationOwner = null;
        isRevoking = false;
      }
      _sessionOperation = SessionOperation(lineage: oldOperation.lineage);
      final operation = _sessionOperation;
      await _sessionWrite(
        operation,
        () => (renewal as GuestSessionRenewalStore).replaceGuestSession(
          result.session,
          userId: before.userId,
        ),
      );
      operation.check();
      _session = result.session;
      profile = next;
      _noticeClockAhead(result.session);
      _revocationOperation = _identityScope(currentDeviceId);
      _revocationTask = null;
      final context = _migrationScope();
      context.value = migration;
      if (migration?.status.isPending == true) {
        unawaited(_followLocationMigration(context, refreshFirst: true));
      }
      notifyListeners();
      return _GuestRecovery.admitted;
    } on SessionOperationCancelled {
      return _GuestRecovery.refused;
    } catch (error) {
      if (!_disposed) {
        _guestFailure(error, fallback: 'guest.serviceUnavailable');
      }
      if (!oldOperation.isCurrent &&
          !_disposed &&
          _session != null &&
          profile?.userId == before?.userId) {
        await _terminateSession(expired: true);
        return _GuestRecovery.refused;
      }
      // Before the commit point nothing changed: a temporary failure keeps
      // the session, which a later request renews.
      return oldOperation.isCurrent && _isTransientFailure(error)
          ? _GuestRecovery.deferred
          : _GuestRecovery.refused;
    } finally {
      if (identical(_guestRenewalOwner, renewalOwner)) {
        _guestRenewalOwner = null;
        _guestRenewing = false;
      }
      if (!_disposed) notifyListeners();
    }
  }

  Future<bool> _signInSeparately({
    required String email,
    required String password,
  }) async {
    if (_disposed ||
        isAuthenticating ||
        isGuestActionBusy ||
        sessionTermination != null ||
        isIdentityBusy ||
        isConnecting) {
      return false;
    }
    final operation = _sessionOperation;
    final owner = _beginAuthentication();
    notice = null;
    notifyListeners();
    try {
      final candidate = await _api.login(email: email, password: password);
      operation.check();
      if (!_ownsAuthentication(owner)) return false;
      final candidateProfile = await _api.me(candidate.accessToken);
      operation.check();
      if (!_ownsAuthentication(owner)) return false;
      if (candidateProfile.isGuest ||
          candidateProfile.profileRedacted ||
          !candidateProfile.canManageAccount) {
        throw const ApiProtocolException();
      }
      // Explicit separate login. Validate first so an invalid password never
      // discards the usable guest's purchase or live VPN session.
      await _signOut(authenticationOwner: owner);
      if (!_ownsAuthentication(owner) || sessionTermination != null) {
        return false;
      }
      _sessionOperation.invalidate();
      _sessionOperation = SessionOperation();
      _sessionExpired = false;
      final admissionOperation = _sessionOperation;
      try {
        final restored = await _setSession(
          candidate,
          verificationNeeded: false,
          authorizationCurrent: () => _ownsAuthentication(owner),
        );
        if (!_ownsAuthentication(owner) ||
            !admissionOperation.isCurrent ||
            !identical(admissionOperation, _sessionOperation)) {
          return false;
        }
        notifyListeners();
        return restored;
      } on NativeVpnException catch (error) {
        // An interrupted first write can leave candidate material in native
        // storage. Clean it only while this admission still owns the session.
        if (_ownsAuthentication(owner) &&
            admissionOperation.isCurrent &&
            identical(admissionOperation, _sessionOperation)) {
          await _handleInitialSessionWriteFailure(error);
        }
        return false;
      }
    } on SessionOperationCancelled {
      return false;
    } on ApiFailure catch (error) {
      if (_ownsAuthentication(owner)) {
        _setNotice(ApiErrorMessages.fromFailure(error));
      }
      return false;
    } catch (error) {
      if (_ownsAuthentication(owner)) {
        _guestFailure(error, fallback: 'guest.serviceUnavailable');
      }
      return false;
    } finally {
      if (_ownsAuthentication(owner)) {
        _finishAuthentication(owner);
        notifyListeners();
      }
    }
  }
}
