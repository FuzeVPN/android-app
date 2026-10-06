import 'dart:async';
import 'package:flutter/foundation.dart';
import 'core/play_billing.dart';

class BillingAccount {
  const BillingAccount({
    required this.userId,
    required this.accessToken,
    required this.scope,
    this.allowAutoRestore = true,
  });
  final String userId, accessToken;
  final Object scope;
  final bool allowAutoRestore;
}

/// Purchase tokens stay in memory. Only the authenticated API grants access.
class BillingController extends ChangeNotifier {
  BillingController({
    required this._gateway,
    required this._api,
    required this._currentAccount,
    this._autoRestore = false,
    List<Duration> processingRetryDelays = const [
      Duration(seconds: 2),
      Duration(seconds: 4),
      Duration(seconds: 8),
      Duration(seconds: 12),
      Duration(seconds: 16),
    ],
  }) : _processingRetryDelays = List.unmodifiable(processingRetryDelays) {
    if (processingRetryDelays.length > 5 ||
        processingRetryDelays.any((delay) => delay.isNegative)) {
      throw ArgumentError('invalid_processing_retry_delays');
    }
    syncAccount();
    _events = _gateway.events.listen(
      (event) {
        syncAccount();
        final revision = accountRevision;
        _eventQueue = _eventQueue
            .then((_) async {
              if (_current(revision)) await _handleEvent(event);
            })
            .catchError((Object _) {});
      },
      onError: (Object _) {
        if (!_disposed && _waitingOwner != null) {
          _waitingOwner = null;
          messageKey = 'billing.purchaseError';
          _emit();
        }
      },
    );
  }
  final PlayBillingGateway _gateway;
  final BillingApiRepository _api;
  final BillingAccount? Function() _currentAccount;
  final bool _autoRestore;
  final List<Duration> _processingRetryDelays;
  late final StreamSubscription<PlayBillingEvent> _events;
  Future<void> _eventQueue = Future.value();
  BillingAccount? _account;
  BillingPurchaseContext? _context;
  BillingSubscription? subscription;
  List<PlaySubscriptionPlan> plans = const [];
  int accountRevision = 0;
  bool catalogLoaded = false;
  bool isLoadingCatalog = false;
  bool isRestoring = false;
  bool isCheckingAccess = false;
  bool _working = false;
  bool _eventWorking = false;
  final Set<String> _unsettledTokens = {};
  final Map<String, PlayPurchase> _processingPurchases = {};
  Duration? _serverRetryDelay;
  Timer? _retryTimer;
  int _retryEpoch = 0;
  int _retryAttempts = 0;
  Object? _retryOwner;
  bool _foreground = true;
  bool get _unsettledPurchase => _unsettledTokens.isNotEmpty;
  bool _disposed = false;
  bool _activated = false;
  String? _waitingOwner;
  String? messageKey;
  final Map<String, Future<BillingVerification>> _verificationInFlight = {};
  final Map<String, String> _verificationStates = {};
  bool get isBusy =>
      _working ||
      _eventWorking ||
      isLoadingCatalog ||
      isRestoring ||
      isCheckingAccess ||
      _retryOwner != null ||
      _waitingOwner != null;
  bool get purchaseAllowed =>
      !_unsettledPurchase &&
      _account != null &&
      _context?.purchaseAllowed == true &&
      subscription?.hasAccess == false;

  void syncAccount() {
    if (_disposed) return;
    final next = _currentAccount();
    if (next?.userId == _account?.userId &&
        identical(next?.scope, _account?.scope)) {
      _account = next;
      return;
    }
    _account = next;
    accountRevision++;
    final gateway = _gateway;
    if (gateway is BillingSessionGateway) {
      unawaited(
        (gateway as BillingSessionGateway).invalidateAccount().catchError(
          (Object _) {},
        ),
      );
    }
    _context = null;
    subscription = null;
    plans = const [];
    catalogLoaded = false;
    isLoadingCatalog = isRestoring = isCheckingAccess = _working = false;
    _eventWorking = false;
    _cancelProcessingTimer();
    _retryOwner = null;
    _retryAttempts = 0;
    _serverRetryDelay = null;
    _processingPurchases.clear();
    _unsettledTokens.clear();
    _activated = false;
    _waitingOwner = null;
    messageKey = null;
    _verificationInFlight.clear();
    _verificationStates.clear();
    _emit();
    if (_autoRestore && next != null && next.allowAutoRestore) {
      final revision = accountRevision;
      scheduleMicrotask(() {
        if (_current(revision)) unawaited(restorePurchases());
      });
    }
  }

  bool _current(int revision) {
    syncAccount();
    return !_disposed && revision == accountRevision && _account != null;
  }

  bool _catalogCurrent(int revision) {
    syncAccount();
    return !_disposed && revision == accountRevision;
  }

  /// Anonymous recovery only discovers receipts. The guest endpoint verifies
  /// ownership before the application adopts a session or grants any access.
  Future<List<PlayPurchase>> queryRecoveryPurchases() async {
    final purchases = await _gateway.queryOwnedPurchases();
    return purchases.where((p) => p.productId == 'premium').toList();
  }

  void acceptRecoveredSubscription({
    required BillingSubscription recovered,
    required String purchaseStatus,
    required PlayPurchase purchase,
  }) {
    syncAccount();
    if (_disposed || _account == null) return;
    subscription = recovered;
    _activated = true;
    if (purchaseStatus == 'pending') {
      _unsettledTokens.add(purchase.purchaseToken);
      messageKey = 'billing.pending';
    } else {
      messageKey = recovered.hasAccess
          ? 'billing.restored'
          : 'billing.inactive';
    }
    _emit();
  }

  void _emit() {
    if (!_disposed) notifyListeners();
  }

  void _cancelProcessingTimer() {
    _retryTimer?.cancel();
    _retryTimer = null;
    _retryEpoch++;
  }

  void _scheduleProcessingRetry(int revision) {
    if (!_current(revision) ||
        !_foreground ||
        _processingPurchases.isEmpty ||
        _retryTimer != null ||
        _retryOwner != null ||
        _retryAttempts >= _processingRetryDelays.length) {
      return;
    }
    final epoch = _retryEpoch;
    _retryTimer = Timer(
      _serverRetryDelay ?? _processingRetryDelays[_retryAttempts],
      () {
        _retryTimer = null;
        if (_current(revision) && _foreground && epoch == _retryEpoch) {
          unawaited(_retryProcessing(revision));
        }
      },
    );
  }

  Future<void> _retryProcessing(int revision) async {
    if (!_current(revision) || !_foreground) return;
    if (isBusy) {
      _scheduleProcessingRetry(revision);
      return;
    }
    if (_processingPurchases.isEmpty ||
        _retryAttempts >= _processingRetryDelays.length) {
      return;
    }
    final owner = Object();
    _retryOwner = owner;
    _retryAttempts++;
    _emit();
    try {
      await _verify(
        _processingPurchases.values.toList(),
        revision,
        restoring: false,
      );
    } finally {
      if (_current(revision) && identical(_retryOwner, owner)) {
        _retryOwner = null;
        _emit();
        _scheduleProcessingRetry(revision);
      }
    }
  }

  Future<bool> _refreshContext(int revision) async {
    _context = null;
    try {
      final subscriptionResult = await _api.getSubscription(
        _account!.accessToken,
      );
      if (!_current(revision)) return false;
      subscription = subscriptionResult;
      final contextResult = await _api.getPurchaseContext(
        _account!.accessToken,
      );
      if (!_current(revision)) return false;
      if (!validBillingAccountId(contextResult.obfuscatedAccountId)) {
        return false;
      }
      _context = contextResult;
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> loadPlans() async {
    syncAccount();
    if (isBusy) return;
    _activated = true;
    final revision = accountRevision;
    isLoadingCatalog = true;
    messageKey = null;
    _emit();
    try {
      final result = await _gateway.queryPlans();
      if (!_catalogCurrent(revision)) return;
      // Validate even injected gateways; keep the SDK's exact display text.
      if (result.any(
            (p) =>
                p.productId != 'premium' ||
                !const ['monthly', 'yearly'].contains(p.basePlanId),
          ) ||
          result.map((p) => p.basePlanId).toSet().length != result.length) {
        throw const PlayBillingException('invalid_response');
      }
      plans = List.unmodifiable(result);
      catalogLoaded = true;
      if (_account != null && !await _refreshContext(revision)) {
        if (_current(revision)) messageKey = 'billing.comingSoon';
      }
      if (_catalogCurrent(revision) && plans.isEmpty) {
        messageKey = 'billing.unavailable';
      }
    } catch (_) {
      if (_catalogCurrent(revision)) {
        plans = const [];
        catalogLoaded = true;
        messageKey = 'billing.storeUnavailable';
      }
    } finally {
      if (_catalogCurrent(revision)) {
        isLoadingCatalog = false;
        _emit();
      }
    }
  }

  Future<void> refreshSubscription() async {
    syncAccount();
    if (isBusy || _account == null) return;
    _activated = true;
    final revision = accountRevision;
    isCheckingAccess = true;
    messageKey = null;
    _emit();
    final available = await _refreshContext(revision);
    if (!_current(revision)) return;
    isCheckingAccess = false;
    if (!available) messageKey = 'billing.comingSoon';
    _emit();
  }

  Future<void> purchase(PlaySubscriptionPlan plan) async {
    syncAccount();
    if (isBusy || _account == null || !plans.any((p) => p.sameOffer(plan))) {
      return;
    }
    final revision = accountRevision;
    _working = true;
    messageKey = null;
    _emit();
    try {
      if (!await _refreshContext(revision) || !_current(revision)) {
        if (_current(revision)) messageKey = 'billing.comingSoon';
        return;
      }
      if (!purchaseAllowed) {
        messageKey = _unsettledPurchase
            ? 'billing.pending'
            : subscription?.hasAccess == true
            ? subscription?.provider == 'google_play'
                  ? 'billing.playManaged'
                  : 'billing.webManaged'
            : 'billing.comingSoon';
        return;
      }
      _waitingOwner = _context!.obfuscatedAccountId;
      await _gateway.launchSubscription(
        plan: plan,
        obfuscatedAccountId: _waitingOwner!,
      );
      // Acceptance of the Play sheet does not prove payment or entitlement.
    } on PlayBillingException catch (error) {
      if (!_current(revision)) return;
      _waitingOwner = null;
      messageKey = error.code == 'cancelled'
          ? 'billing.cancelled'
          : 'billing.purchaseError';
      if (error.code == 'price_changed') {
        plans = const [];
        catalogLoaded = false;
      }
      if (error.code == 'already_owned') {
        _working = false;
        await restorePurchases();
      }
    } catch (_) {
      if (_current(revision)) {
        _waitingOwner = null;
        messageKey = 'billing.purchaseError';
      }
    } finally {
      if (_current(revision)) {
        _working = false;
        _emit();
      }
    }
  }

  Future<void> _handleEvent(PlayBillingEvent event) async {
    syncAccount();
    if (_disposed || _account == null) return;
    final revision = accountRevision;
    if (event.type != 'purchases') {
      if (_waitingOwner == null || event.obfuscatedAccountId != _waitingOwner) {
        return;
      }
      _waitingOwner = null;
      messageKey = event.type == 'cancelled'
          ? 'billing.cancelled'
          : 'billing.purchaseError';
      _emit();
      return;
    }
    if (_context == null && !await _refreshContext(revision)) return;
    if (!_current(revision)) return;
    final owned = event.purchases
        .where(
          (p) =>
              p.obfuscatedAccountId == _context!.obfuscatedAccountId &&
              !_processingPurchases.containsKey(p.purchaseToken),
        )
        .toList();
    if (owned.isEmpty) {
      if (event.purchases.isEmpty &&
          event.obfuscatedAccountId == _waitingOwner) {
        _waitingOwner = null;
        _emit();
      }
      return;
    }
    _waitingOwner = null;
    _eventWorking = true;
    messageKey = 'billing.verifying';
    _emit();
    try {
      await _verify(owned, revision, restoring: false);
    } finally {
      if (_current(revision)) {
        _eventWorking = false;
        _emit();
      }
    }
  }

  Future<void> _verify(
    List<PlayPurchase> purchases,
    int revision, {
    required bool restoring,
  }) async {
    for (final purchase in purchases) {
      if (!_current(revision)) return;
      // A failed context refresh must not discard the account binding already
      // established for a processing token in this session's memory.
      final expectedOwner =
          _context?.obfuscatedAccountId ??
          _processingPurchases[purchase.purchaseToken]?.obfuscatedAccountId;
      if (purchase.productId != 'premium' ||
          expectedOwner == null ||
          purchase.obfuscatedAccountId != expectedOwner) {
        continue;
      }
      Future<BillingVerification>? verification;
      try {
        final initialState = _verificationStates.putIfAbsent(
          purchase.purchaseToken,
          () => purchase.state,
        );
        verification = _verificationInFlight.putIfAbsent(
          purchase.purchaseToken,
          () => _api.verifyPurchase(
            token: _account!.accessToken,
            purchaseToken: purchase.purchaseToken,
          ),
        );
        var result = await verification;
        if (!_current(revision)) return;
        // A purchased callback must not be consumed by an older pending lookup.
        // Start one fresh lookup after the shared request, never concurrently.
        if (initialState == 'pending' &&
            purchase.state == 'purchased' &&
            result.purchaseStatus == 'pending') {
          if (identical(
            _verificationInFlight[purchase.purchaseToken],
            verification,
          )) {
            _verificationInFlight.remove(purchase.purchaseToken)?.ignore();
            _verificationStates.remove(purchase.purchaseToken);
          }
          _verificationStates.putIfAbsent(
            purchase.purchaseToken,
            () => purchase.state,
          );
          verification = _verificationInFlight.putIfAbsent(
            purchase.purchaseToken,
            () => _api.verifyPurchase(
              token: _account!.accessToken,
              purchaseToken: purchase.purchaseToken,
            ),
          );
          result = await verification;
        }
        if (!_current(revision)) return;
        if (!const [
          'verified',
          'pending',
          'processing',
        ].contains(result.purchaseStatus)) {
          throw const FormatException('invalid_verification');
        }
        // has_access is the common server entitlement, including a preexisting web subscription.
        subscription = result.subscription;
        if (result.purchaseStatus == 'verified') {
          _processingPurchases.remove(purchase.purchaseToken);
          _unsettledTokens.remove(purchase.purchaseToken);
          messageKey = result.subscription.hasAccess
              ? restoring
                    ? 'billing.restored'
                    : 'billing.success'
              : 'billing.inactive';
        } else {
          _unsettledTokens.add(purchase.purchaseToken);
          if (result.purchaseStatus == 'processing') {
            _cancelProcessingTimer();
            _processingPurchases[purchase.purchaseToken] = purchase;
            final delay = result.retryAfter;
            _serverRetryDelay =
                delay != null &&
                    delay >= const Duration(seconds: 1) &&
                    delay <= const Duration(seconds: 60)
                ? delay
                : null;
          } else {
            _processingPurchases.remove(purchase.purchaseToken);
          }
          messageKey = result.purchaseStatus == 'pending'
              ? 'billing.pending'
              : 'billing.verifying';
        }
      } catch (_) {
        if (_current(revision)) {
          _processingPurchases.remove(purchase.purchaseToken);
          _unsettledTokens.add(purchase.purchaseToken);
          messageKey = 'billing.verificationError';
        }
      } finally {
        if (_current(revision) &&
            identical(
              _verificationInFlight[purchase.purchaseToken],
              verification,
            )) {
          _verificationInFlight.remove(purchase.purchaseToken)?.ignore();
          _verificationStates.remove(purchase.purchaseToken);
        }
      }
    }
    _scheduleProcessingRetry(revision);
  }

  Future<void> restorePurchases() async {
    syncAccount();
    if (isBusy || _account == null) return;
    _activated = true;
    final revision = accountRevision;
    _cancelProcessingTimer();
    _retryAttempts = 0;
    _serverRetryDelay = null;
    isRestoring = true;
    messageKey = null;
    _emit();
    try {
      if (!await _refreshContext(revision)) {
        if (_current(revision)) messageKey = 'billing.comingSoon';
        return;
      }
      if (!_current(revision)) return;
      final purchases = await _gateway.queryOwnedPurchases();
      if (!_current(revision)) return;
      final owned = purchases
          .where((p) => p.obfuscatedAccountId == _context!.obfuscatedAccountId)
          .toList();
      _processingPurchases.clear();
      _unsettledTokens.retainAll(owned.map((p) => p.purchaseToken));
      if (owned.isEmpty) {
        _unsettledTokens.clear();
        messageKey = 'billing.restoreEmpty';
      } else {
        // Revalidate rather than trusting acknowledgement or a cached entitlement.
        await _verify(owned, revision, restoring: true);
      }
    } catch (_) {
      if (_current(revision)) messageKey = 'billing.restoreError';
    } finally {
      if (_current(revision)) {
        isRestoring = false;
        _emit();
      }
    }
  }

  Future<void> openManagement() async {
    syncAccount();
    if (isBusy || _account == null || subscription?.provider != 'google_play') {
      return;
    }
    final revision = accountRevision;
    try {
      await _gateway.openSubscriptionManagement();
    } catch (_) {
      if (_current(revision)) {
        messageKey = 'billing.managementError';
        _emit();
      }
    }
  }

  Future<void> onAppResumed() async {
    syncAccount();
    _foreground = true;
    _scheduleProcessingRetry(accountRevision);
    if (_processingPurchases.isNotEmpty) return;
    if (!_activated || _account == null || isBusy) return;
    await restorePurchases();
  }

  void onAppPaused() {
    _foreground = false;
    _cancelProcessingTimer();
  }

  @override
  void dispose() {
    _disposed = true;
    _cancelProcessingTimer();
    _events.cancel();
    _gateway.dispose();
    _verificationInFlight.clear();
    _verificationStates.clear();
    _processingPurchases.clear();
    _unsettledTokens.clear();
    super.dispose();
  }
}
