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

/// The verification in flight for one purchase token, shared by every caller
/// that asks for that token meanwhile.
class _BillingVerificationRequest {
  _BillingVerificationRequest(this.purchaseState);

  /// Play state of the purchase whose verification started this request.
  final String purchaseState;
  int? sequence;
  late final Future<BillingVerification> result;
}

/// The purchase context of the current account, with when it was read and the
/// entitlement applied at that time.
class _PurchaseContextRead {
  const _PurchaseContextRead(
    this.context,
    this.readAt,
    this.entitlementSequence,
  );
  final BillingPurchaseContext context;
  final DateTime readAt;
  final int entitlementSequence;
}

/// An operation started by the application or the user. Each one starts only
/// while the controller is not busy, so at most one runs at a time. The
/// verification of a Play event is not one of them: it may overlap any.
enum _BillingOperation {
  loadingCatalog,
  checkingAccess,
  purchasing,
  restoring,
  retryingProcessing,
}

/// Why Google Play refuses a new checkout for the current account.
enum PlayCheckoutBlock {
  none,

  /// The account's Play subscription is on hold or paused (payment issue).
  paymentIssue,

  /// A premium receipt exists on the device's Play account but gives this
  /// FuzeVPN account no access: unknown owner, another owner, or inactive.
  existingReceipt,
}

/// The server entitlement observed together with a Play receipt read.
typedef _EntitlementBasis = (String, bool, String?, DateTime?);

/// What the latest read of the device's Play receipts found for this scope.
sealed class _PlayReceipts {
  const _PlayReceipts();
}

/// No read yet, or the linked receipt it found has lapsed since.
final class _UnknownReceipts extends _PlayReceipts {
  const _UnknownReceipts();
}

final class _NoReceipts extends _PlayReceipts {
  const _NoReceipts();
}

/// Only receipts that give this account no access.
final class _UnlinkedReceipts extends _PlayReceipts {
  const _UnlinkedReceipts();
}

/// A receipt of this account.
final class _LinkedReceipt extends _PlayReceipts {
  const _LinkedReceipt({
    required this.suspended,
    required this.foreign,
    required this.basis,
  });

  /// On hold or paused in Play.
  final bool suspended;

  /// A receipt of another owner was seen in the same read.
  final bool foreign;

  /// The server entitlement observed with that read.
  final _EntitlementBasis? basis;
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
  Future<void> _entitlementQueue = Future.value();
  int _entitlementSequence = 0;
  int _appliedEntitlementSequence = 0;
  BillingAccount? _account;
  // The purchase context last read successfully for this account. A new read
  // or an account change drops it, so it never describes another account.
  _PurchaseContextRead? _contextRead;
  BillingPurchaseContext? get _context => _contextRead?.context;
  BillingSubscription? subscription;
  List<PlaySubscriptionPlan> plans = const [];
  int accountRevision = 0;
  int _entitlementRevision = 0;
  int _subscriptionReadRevision = 0;
  int _appliedSubscriptionReadRevision = 0;
  bool catalogLoaded = false;
  _BillingOperation? _operation;
  bool _eventWorking = false;
  final Set<String> _unsettledTokens = {};
  final Map<String, PlayPurchase> _processingPurchases = {};
  Duration? _serverRetryDelay;
  Timer? _retryTimer;
  int _retryEpoch = 0;
  int _retryAttempts = 0;
  bool _foreground = true;
  bool get _unsettledPurchase => _unsettledTokens.isNotEmpty;
  bool _disposed = false;
  bool _activated = false;
  String? _waitingOwner;
  String? _messageKey;
  int _messageRevision = 0;
  _PlayReceipts _playReceipts = const _UnknownReceipts();
  final Map<String, _BillingVerificationRequest> _verificationInFlight = {};

  static const playPaymentIssueMessageKey = 'billing.playOnHold';
  static const playExistingReceiptMessageKey = 'billing.playReceiptUnlinked';

  String? get messageKey => _messageKey;
  set messageKey(String? value) {
    _messageKey = value;
    _messageRevision++;
  }

  bool get isLoadingCatalog => _operation == _BillingOperation.loadingCatalog;
  bool get isRestoring => _operation == _BillingOperation.restoring;
  bool get isCheckingAccess => _operation == _BillingOperation.checkingAccess;

  bool get isBusy =>
      _operation != null || _eventWorking || _waitingOwner != null;

  /// Ends [operation] if it is the one running: an operation never ends
  /// another one.
  void _endOperation(_BillingOperation operation) {
    if (_operation == operation) _operation = null;
  }

  /// Whether the UI may offer a purchase. Play itself still decides.
  bool get purchaseAllowed => _purchaseAllowedByServer && !playCheckoutBlocked;

  bool get _purchaseAllowedByServer =>
      !_unsettledPurchase &&
      _account != null &&
      _context?.purchaseAllowed == true &&
      subscription?.hasAccess == false;

  /// Play refuses a new checkout while any premium receipt exists on the
  /// device's Play account (`already_owned`), whatever its owner or
  /// suspension. The latest receipt read of this scope decides; before any
  /// read, a server-side Play hold is the only evidence.
  PlayCheckoutBlock get playCheckoutBlock {
    final current = subscription;
    final receipts = _playReceipts;
    if (_account == null ||
        current?.hasAccess == true ||
        _unsettledPurchase ||
        receipts is _NoReceipts) {
      return PlayCheckoutBlock.none;
    }
    final serverHold =
        current?.provider == 'google_play' && current?.status == 'past_due';
    if (serverHold || (receipts is _LinkedReceipt && receipts.suspended)) {
      return PlayCheckoutBlock.paymentIssue;
    }
    return receipts is _UnknownReceipts
        ? PlayCheckoutBlock.none
        : PlayCheckoutBlock.existingReceipt;
  }

  bool get playCheckoutBlocked => playCheckoutBlock != PlayCheckoutBlock.none;

  String? get playCheckoutBlockedMessageKey => switch (playCheckoutBlock) {
    PlayCheckoutBlock.none => null,
    PlayCheckoutBlock.paymentIssue => playPaymentIssueMessageKey,
    PlayCheckoutBlock.existingReceipt => playExistingReceiptMessageKey,
  };

  /// Play management resolves a hold or shows the receipt that blocks
  /// checkout, even without access.
  bool get canManagePlaySubscription =>
      _account != null &&
      (subscription?.provider == 'google_play' || playCheckoutBlocked);

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
    // New-session events must not wait for an old session's network request.
    // The abandoned queue still checks accountRevision before applying results.
    _eventQueue = Future.value();
    _entitlementQueue = Future.value();
    _entitlementSequence = 0;
    _appliedEntitlementSequence = 0;
    _entitlementRevision = 0;
    _subscriptionReadRevision = 0;
    _appliedSubscriptionReadRevision = 0;
    final gateway = _gateway;
    if (gateway is BillingSessionGateway) {
      unawaited(
        (gateway as BillingSessionGateway).invalidateAccount().catchError(
          (Object _) {},
        ),
      );
    }
    _contextRead = null;
    subscription = null;
    plans = const [];
    catalogLoaded = false;
    _operation = null;
    _eventWorking = false;
    _cancelProcessingTimer();
    _retryAttempts = 0;
    _serverRetryDelay = null;
    _processingPurchases.clear();
    _unsettledTokens.clear();
    _playReceipts = const _UnknownReceipts();
    _activated = false;
    _waitingOwner = null;
    messageKey = null;
    _verificationInFlight.clear();
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
    // This response was already verified by the recovery endpoint. Older
    // requests admitted in this scope must not undo that server snapshot.
    _appliedEntitlementSequence = ++_entitlementSequence;
    _entitlementRevision++;
    subscription = recovered;
    _rememberLinkedReceipt(suspended: purchase.suspended, foreign: false);
    _activated = true;
    if (purchaseStatus == 'pending') {
      _unsettledTokens.add(purchase.purchaseToken);
      messageKey = 'billing.pending';
    } else {
      messageKey = recovered.hasAccess
          ? 'billing.restored'
          : purchase.suspended
          ? playPaymentIssueMessageKey
          : 'billing.inactive';
    }
    _emit();
  }

  void _emit() {
    if (!_disposed) notifyListeners();
  }

  static _EntitlementBasis? _basisOf(BillingSubscription? value) =>
      value == null
      ? null
      : (value.status, value.hasAccess, value.provider, value.expiresAt);

  /// Remembers a receipt of this account with the entitlement now applied.
  void _rememberLinkedReceipt({
    required bool suspended,
    required bool foreign,
  }) {
    _playReceipts = _LinkedReceipt(
      suspended: suspended,
      foreign: foreign,
      basis: _basisOf(subscription),
    );
  }

  /// A linked receipt is this account's own subscription. Once a newer server
  /// entitlement differs from the one observed with that read (expiry, refund,
  /// end of a hold), Play may no longer hold it: forget it until the next
  /// read. A receipt of another owner seen in the same read still blocks.
  void _forgetLapsedLinkedReceipt() {
    final receipts = _playReceipts;
    if (receipts is! _LinkedReceipt ||
        _basisOf(subscription) == receipts.basis) {
      return;
    }
    _playReceipts = receipts.foreign
        ? const _UnlinkedReceipts()
        : const _UnknownReceipts();
  }

  /// H-R11-01-01: an operation's late outcome never replaces a message
  /// published after it started, such as a newer Play event verification.
  /// Returns the revision to compare for the same operation's next outcome.
  int _publishOutcome(int since, String key) {
    if (since != _messageRevision) return -1;
    messageKey = key;
    return _messageRevision;
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
        _operation == _BillingOperation.retryingProcessing ||
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
    _operation = _BillingOperation.retryingProcessing;
    _retryAttempts++;
    _emit();
    try {
      await _verify(
        _processingPurchases.values.toList(),
        revision,
        restoring: false,
      );
    } finally {
      if (_current(revision) &&
          _operation == _BillingOperation.retryingProcessing) {
        _operation = null;
        _emit();
        _scheduleProcessingRetry(revision);
      }
    }
  }

  Future<bool> _refreshContext(int revision) async {
    _contextRead = null;
    final readRevision = ++_subscriptionReadRevision;
    try {
      final read = _queueEntitlement(revision, () async {
        final sequence = ++_entitlementSequence;
        final entitlementRevision = _entitlementRevision;
        final subscriptionResult = await _api.getSubscription(
          _account!.accessToken,
        );
        if (!_current(revision)) return false;
        // Recovery can publish an already verified snapshot outside this queue.
        if (entitlementRevision == _entitlementRevision &&
            readRevision > _appliedSubscriptionReadRevision) {
          subscription = subscriptionResult;
          _appliedSubscriptionReadRevision = readRevision;
          _appliedEntitlementSequence = sequence;
          _forgetLapsedLinkedReceipt();
        }
        return true;
      });
      if (!await read) return false;
      final contextResult = await _api.getPurchaseContext(
        _account!.accessToken,
      );
      if (!_current(revision)) return false;
      if (!validBillingAccountId(contextResult.obfuscatedAccountId)) {
        return false;
      }
      _contextRead = _PurchaseContextRead(
        contextResult,
        DateTime.now(),
        _appliedEntitlementSequence,
      );
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
    _operation = _BillingOperation.loadingCatalog;
    messageKey = null;
    var messageRevision = _messageRevision;
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
        if (_current(revision)) {
          messageRevision = _publishOutcome(
            messageRevision,
            'billing.comingSoon',
          );
        }
      }
      if (_catalogCurrent(revision) && plans.isEmpty) {
        _publishOutcome(messageRevision, 'billing.unavailable');
      }
    } catch (_) {
      if (_catalogCurrent(revision)) {
        plans = const [];
        catalogLoaded = true;
        _publishOutcome(messageRevision, 'billing.storeUnavailable');
      }
    } finally {
      if (_catalogCurrent(revision)) {
        _endOperation(_BillingOperation.loadingCatalog);
        _emit();
      }
    }
  }

  /// For a visit of the account tab: a subscription read in the last minute
  /// for this account is kept, so the tab does not show its check every time,
  /// unless an entitlement change (purchase, recovery) was applied since: only
  /// a fresh server context may then allow checkout again. The refresh button
  /// still reads it every time.
  Future<void> refreshSubscriptionIfStale() {
    syncAccount();
    final read = _contextRead;
    if (read != null &&
        read.entitlementSequence == _appliedEntitlementSequence &&
        DateTime.now().difference(read.readAt) < const Duration(minutes: 1)) {
      // Only the read is skipped: a visit still clears the previous message,
      // as a refresh does (an automatic restore may have published one).
      if (!isBusy) {
        messageKey = null;
        _emit();
      }
      return Future<void>.value();
    }
    return refreshSubscription();
  }

  Future<void> refreshSubscription() async {
    syncAccount();
    if (isBusy || _account == null) return;
    _activated = true;
    final revision = accountRevision;
    _operation = _BillingOperation.checkingAccess;
    messageKey = null;
    final messageRevision = _messageRevision;
    _emit();
    final available = await _refreshContext(revision);
    if (!_current(revision)) return;
    _endOperation(_BillingOperation.checkingAccess);
    if (!available) _publishOutcome(messageRevision, 'billing.comingSoon');
    _emit();
  }

  Future<void> purchase(PlaySubscriptionPlan plan) async {
    syncAccount();
    if (isBusy || _account == null || !plans.any((p) => p.sameOffer(plan))) {
      return;
    }
    final revision = accountRevision;
    _operation = _BillingOperation.purchasing;
    messageKey = null;
    final messageRevision = _messageRevision;
    _emit();
    try {
      if (!await _refreshContext(revision) || !_current(revision)) {
        if (_current(revision)) {
          _publishOutcome(messageRevision, 'billing.comingSoon');
        }
        return;
      }
      // A known Play receipt does not refuse locally: it may be stale, and
      // the native pre-check reads the receipts again before any payment.
      if (!_purchaseAllowedByServer) {
        _publishOutcome(
          messageRevision,
          _unsettledPurchase
              ? 'billing.pending'
              : subscription?.hasAccess == true
              ? subscription?.provider == 'google_play'
                    ? 'billing.playManaged'
                    : 'billing.webManaged'
              : 'billing.comingSoon',
        );
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
      _publishOutcome(messageRevision, switch (error.code) {
        'cancelled' => 'billing.cancelled',
        'price_changed' => 'billing.offerChanged',
        _ => 'billing.purchaseError',
      });
      if (error.code == 'price_changed') {
        plans = const [];
        catalogLoaded = false;
      }
      if (error.code == 'already_owned') {
        // The purchase ends here and hands over to a restore, which only
        // starts while the controller is not busy.
        _endOperation(_BillingOperation.purchasing);
        await restorePurchases();
      }
    } catch (_) {
      if (_current(revision)) {
        _waitingOwner = null;
        _publishOutcome(messageRevision, 'billing.purchaseError');
      }
    } finally {
      if (_current(revision)) {
        _endOperation(_BillingOperation.purchasing);
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
      // Recovery identifies the completed flow independently of receipts held
      // by other accounts. Those receipts remain excluded from verification.
      if (_waitingOwner != null && event.obfuscatedAccountId == _waitingOwner) {
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

  Future<T> _queueEntitlement<T>(int revision, Future<T> Function() operation) {
    // Reads and every purchase token share one server entitlement. Keep both
    // request execution and snapshot application in this scope's queue.
    final result = _entitlementQueue.then((_) {
      if (!_current(revision)) {
        throw const PlayBillingException('cancelled');
      }
      return operation();
    });
    _entitlementQueue = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  _BillingVerificationRequest _queueVerification(
    PlayPurchase purchase,
    int revision,
  ) {
    final request = _BillingVerificationRequest(purchase.state);
    request.result = _queueEntitlement(revision, () async {
      // Order by actual server invocation, including a queued request emitted
      // after an accepted recovery response.
      request.sequence = ++_entitlementSequence;
      final result = await _api.verifyPurchase(
        token: _account!.accessToken,
        purchaseToken: purchase.purchaseToken,
      );
      if (!_current(revision)) return result;
      if (!const [
        'verified',
        'pending',
        'processing',
      ].contains(result.purchaseStatus)) {
        throw const FormatException('invalid_verification');
      }
      final sequence = request.sequence!;
      if (sequence >= _appliedEntitlementSequence) {
        _appliedEntitlementSequence = sequence;
        // Apply before resolving this future or admitting a later read/write.
        // A shared waiter must never reapply this snapshot after a newer one.
        _entitlementRevision++;
        subscription = result.subscription;
        _forgetLapsedLinkedReceipt();
      }
      return result;
    });
    return request;
  }

  /// The verification in flight for this purchase token, started if there is
  /// none.
  _BillingVerificationRequest _sharedVerification(
    PlayPurchase purchase,
    int revision,
  ) => _verificationInFlight.putIfAbsent(
    purchase.purchaseToken,
    () => _queueVerification(purchase, revision),
  );

  /// Forgets [verification] if it is still the one in flight for its token.
  void _releaseVerification(
    String purchaseToken,
    _BillingVerificationRequest? verification,
  ) {
    if (!identical(_verificationInFlight[purchaseToken], verification)) return;
    _verificationInFlight.remove(purchaseToken)?.result.ignore();
  }

  Future<void> _verify(
    List<PlayPurchase> purchases,
    int revision, {
    required bool restoring,
  }) async {
    // A concurrent catalog refresh can temporarily clear _context while this
    // batch waits for the server. Its admitted owner still belongs to the scope.
    final batchOwner = _context?.obfuscatedAccountId;
    for (final purchase in purchases) {
      if (!_current(revision)) return;
      // A failed context refresh must not discard the account binding already
      // established for a processing token in this session's memory.
      final expectedOwner =
          batchOwner ??
          _processingPurchases[purchase.purchaseToken]?.obfuscatedAccountId;
      if (purchase.productId != 'premium' ||
          expectedOwner == null ||
          purchase.obfuscatedAccountId != expectedOwner) {
        continue;
      }
      _BillingVerificationRequest? verification;
      try {
        verification = _sharedVerification(purchase, revision);
        final initialState = verification.purchaseState;
        var result = await verification.result;
        if (!_current(revision)) return;
        // A purchased callback must not be consumed by an older pending lookup.
        // Start one fresh lookup after the shared request, never concurrently.
        if (initialState == 'pending' &&
            purchase.state == 'purchased' &&
            result.purchaseStatus == 'pending') {
          _releaseVerification(purchase.purchaseToken, verification);
          verification = _sharedVerification(purchase, revision);
          result = await verification.result;
        }
        if (!_current(revision)) return;
        // A shared same-token waiter can resume after another token's result.
        // Keep its token bookkeeping without rolling back the common entitlement.
        final sequence = verification.sequence!;
        final latestResult = sequence >= _appliedEntitlementSequence;
        if (result.purchaseStatus == 'verified') {
          _processingPurchases.remove(purchase.purchaseToken);
          _unsettledTokens.remove(purchase.purchaseToken);
          if (latestResult) {
            messageKey = result.subscription.hasAccess
                ? restoring
                      ? 'billing.restored'
                      : 'billing.success'
                : purchase.suspended
                ? playPaymentIssueMessageKey
                : 'billing.inactive';
          }
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
          if (latestResult) {
            messageKey = result.purchaseStatus == 'pending'
                ? 'billing.pending'
                : 'billing.verifying';
          }
        }
      } catch (_) {
        if (_current(revision)) {
          _processingPurchases.remove(purchase.purchaseToken);
          _unsettledTokens.add(purchase.purchaseToken);
          final sequence = verification?.sequence;
          if (sequence == null || sequence >= _appliedEntitlementSequence) {
            if (sequence != null) {
              _appliedEntitlementSequence = sequence;
            }
            messageKey = 'billing.verificationError';
          }
        }
      } finally {
        if (_current(revision)) {
          _releaseVerification(purchase.purchaseToken, verification);
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
    _operation = _BillingOperation.restoring;
    messageKey = null;
    final messageRevision = _messageRevision;
    _emit();
    try {
      if (!await _refreshContext(revision)) {
        if (_current(revision)) {
          _publishOutcome(messageRevision, 'billing.comingSoon');
        }
        return;
      }
      if (!_current(revision)) return;
      final purchases = await _gateway.queryOwnedPurchases();
      if (!_current(revision)) return;
      final premium = purchases.where((p) => p.productId == 'premium').toList();
      final owned = premium
          .where((p) => p.obfuscatedAccountId == _context!.obfuscatedAccountId)
          .toList();
      final suspended = owned.any((p) => p.suspended);
      final foreign = premium.length > owned.length;
      _processingPurchases.clear();
      _unsettledTokens.retainAll(owned.map((p) => p.purchaseToken));
      if (owned.isEmpty) {
        _unsettledTokens.clear();
        // Any premium receipt makes the native pre-check refuse a checkout.
        _playReceipts = premium.isNotEmpty
            ? const _UnlinkedReceipts()
            : const _NoReceipts();
        // A receipt of another owner that blocks checkout is explained with
        // the card's own reason, never as "none". With access, it blocks
        // nothing this account would buy: the baseline result stays.
        _publishOutcome(
          messageRevision,
          playCheckoutBlockedMessageKey ?? 'billing.restoreEmpty',
        );
      } else {
        // Revalidate rather than trusting acknowledgement or a cached entitlement.
        await _verify(owned, revision, restoring: true);
        // The read is remembered with the entitlement its verification set.
        if (_current(revision)) {
          _rememberLinkedReceipt(suspended: suspended, foreign: foreign);
        }
      }
    } catch (_) {
      if (_current(revision)) {
        _publishOutcome(messageRevision, 'billing.restoreError');
      }
    } finally {
      if (_current(revision)) {
        _endOperation(_BillingOperation.restoring);
        _emit();
      }
    }
  }

  Future<void> openManagement() async {
    syncAccount();
    if (isBusy || !canManagePlaySubscription) return;
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
    _processingPurchases.clear();
    _unsettledTokens.clear();
    super.dispose();
  }
}
