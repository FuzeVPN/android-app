// H-R13-01-01 and A07-billing-02: the reason a Play receipt blocks checkout
// is exposed to the UI, which shows a specific message and the Play
// management action instead of a purchase.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/play_billing.dart';

const _owner = 'opaque-account-a';
const _plan = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'synthetic-offer',
  formattedPrice: '4,99 EUR',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4990000,
);
const _none = BillingSubscription(status: 'inactive', hasAccess: false);
const _hold = BillingSubscription(
  status: 'past_due',
  hasAccess: false,
  provider: 'google_play',
);
const _playInactive = BillingSubscription(
  status: 'inactive',
  hasAccess: false,
  provider: 'google_play',
);
const _web = BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: 'sumup',
);

PlayPurchase _receipt(String token, {String? owner = _owner, bool? hold}) =>
    PlayPurchase(
      productId: 'premium',
      purchaseToken: token,
      state: 'purchased',
      obfuscatedAccountId: owner,
      acknowledged: true,
      suspended: hold ?? false,
    );

void main() {
  test(
    'H-R13-01-01 unlinked receipt: existing receipt reason and message',
    () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      f.gateway.launchError = const PlayBillingException('already_owned');
      f.gateway.owned = [_receipt('unbound', owner: null)];
      await f.controller.purchase(_plan);
      expect(f.controller.playCheckoutBlock, PlayCheckoutBlock.existingReceipt);
      expect(f.controller.playCheckoutBlocked, isTrue);
      expect(
        f.controller.messageKey,
        BillingController.playExistingReceiptMessageKey,
      );
      expect(
        f.controller.playCheckoutBlockedMessageKey,
        BillingController.playExistingReceiptMessageKey,
      );
      expect(f.controller.canManagePlaySubscription, isTrue);
      // A later operation clears the transient message; the reason persists.
      await f.controller.loadPlans();
      expect(f.controller.messageKey, isNull);
      expect(
        f.controller.playCheckoutBlockedMessageKey,
        BillingController.playExistingReceiptMessageKey,
      );
    },
  );

  test(
    'A07-billing-02 suspended receipt and server hold: payment issue',
    () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      f.api.verifyEffects['held'] = _hold;
      f.gateway.owned = [_receipt('held', hold: true)];
      await f.controller.restorePurchases();
      expect(f.controller.playCheckoutBlock, PlayCheckoutBlock.paymentIssue);
      expect(
        f.controller.messageKey,
        BillingController.playPaymentIssueMessageKey,
      );
      expect(
        f.controller.playCheckoutBlockedMessageKey,
        BillingController.playPaymentIssueMessageKey,
      );
      expect(f.controller.canManagePlaySubscription, isTrue);

      final server = _Fixture(_hold);
      addTearDown(server.dispose);
      await server.controller.refreshSubscription();
      expect(
        server.controller.playCheckoutBlock,
        PlayCheckoutBlock.paymentIssue,
      );
    },
  );

  test(
    'A07-billing-02 linked inactive receipt: existing receipt reason',
    () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      f.api.verifyEffects['mine'] = _playInactive;
      f.gateway.owned = [_receipt('mine')];
      await f.controller.restorePurchases();
      expect(f.controller.playCheckoutBlock, PlayCheckoutBlock.existingReceipt);
    },
  );

  test('A07-billing-02 review: a lapse of the linked subscription clears a '
      'block read before it', () async {
    const active = BillingSubscription(
      status: 'active',
      hasAccess: true,
      provider: 'google_play',
    );
    const expired = BillingSubscription(
      status: 'expired',
      hasAccess: false,
      provider: 'google_play',
    );
    // Linked active receipt, then expiry or refund in the session.
    final lapsed = _Fixture(_none);
    addTearDown(lapsed.dispose);
    lapsed.api.verifyEffects['mine'] = active;
    lapsed.gateway.owned = [_receipt('mine')];
    await lapsed.controller.restorePurchases();
    lapsed.gateway.owned = const [];
    lapsed.api.server = expired;
    await lapsed.controller.refreshSubscription();
    expect(lapsed.controller.playCheckoutBlock, PlayCheckoutBlock.none);
    expect(lapsed.controller.playCheckoutBlockedMessageKey, isNull);
    expect(lapsed.controller.purchaseAllowed, isTrue);

    // Linked inactive receipt whose entitlement later changes.
    final inactive = _Fixture(_none);
    addTearDown(inactive.dispose);
    inactive.api.verifyEffects['mine'] = _playInactive;
    inactive.gateway.owned = [_receipt('mine')];
    await inactive.controller.restorePurchases();
    expect(
      inactive.controller.playCheckoutBlock,
      PlayCheckoutBlock.existingReceipt,
    );
    inactive.api.server = expired;
    await inactive.controller.refreshSubscription();
    expect(inactive.controller.playCheckoutBlock, PlayCheckoutBlock.none);

    // A hold that ends: the server's own hold signal still decides first.
    final held = _Fixture(_none);
    addTearDown(held.dispose);
    held.api.verifyEffects['held'] = _hold;
    held.gateway.owned = [_receipt('held', hold: true)];
    await held.controller.restorePurchases();
    expect(held.controller.playCheckoutBlock, PlayCheckoutBlock.paymentIssue);
    held.api.server = BillingSubscription(
      status: 'past_due',
      hasAccess: false,
      provider: 'google_play',
      expiresAt: DateTime.utc(2026, 11, 2),
    );
    await held.controller.refreshSubscription();
    expect(held.controller.playCheckoutBlock, PlayCheckoutBlock.paymentIssue);
    held.api.server = expired;
    await held.controller.refreshSubscription();
    expect(held.controller.playCheckoutBlock, PlayCheckoutBlock.none);

    // A foreign receipt seen in the same read keeps its own reason.
    final both = _Fixture(_none);
    addTearDown(both.dispose);
    both.api.verifyEffects['mine'] = active;
    both.gateway.owned = [_receipt('mine'), _receipt('unbound', owner: null)];
    await both.controller.restorePurchases();
    both.api.server = expired;
    await both.controller.refreshSubscription();
    expect(
      both.controller.playCheckoutBlock,
      PlayCheckoutBlock.existingReceipt,
    );
    expect(
      both.controller.playCheckoutBlockedMessageKey,
      BillingController.playExistingReceiptMessageKey,
    );

    // A newer read restores the block if Play still holds the receipt.
    lapsed.gateway.owned = [_receipt('mine')];
    lapsed.api.verifyEffects['mine'] = _playInactive;
    await lapsed.controller.restorePurchases();
    expect(
      lapsed.controller.playCheckoutBlock,
      PlayCheckoutBlock.existingReceipt,
    );
  });

  test('review round 2: the restore message of an unlinked receipt is the '
      'reason the card shows, or none with access', () async {
    // Active web access: no block, so no Play reason without its action.
    final web = _Fixture(_web);
    addTearDown(web.dispose);
    web.gateway.owned = [_receipt('foreign', owner: 'opaque-account-b')];
    await web.controller.restorePurchases();
    expect(web.controller.playCheckoutBlockedMessageKey, isNull);
    expect(web.controller.canManagePlaySubscription, isFalse);
    expect(web.controller.messageKey, 'billing.restoreEmpty');
    expect(
      web.controller.messageKey,
      isNot(BillingController.playExistingReceiptMessageKey),
    );

    // Server hold with only a receipt of another owner: payment issue.
    final held = _Fixture(_hold);
    addTearDown(held.dispose);
    held.gateway.owned = [_receipt('unbound', owner: null)];
    await held.controller.restorePurchases();
    expect(held.controller.playCheckoutBlock, PlayCheckoutBlock.paymentIssue);
    expect(
      held.controller.messageKey,
      held.controller.playCheckoutBlockedMessageKey,
    );

    // No access: the existing receipt reason, as on the card.
    final none = _Fixture(_none);
    addTearDown(none.dispose);
    none.gateway.owned = [_receipt('unbound', owner: null)];
    await none.controller.restorePurchases();
    expect(
      none.controller.playCheckoutBlock,
      PlayCheckoutBlock.existingReceipt,
    );
    expect(
      none.controller.messageKey,
      BillingController.playExistingReceiptMessageKey,
    );
    expect(
      none.controller.messageKey,
      none.controller.playCheckoutBlockedMessageKey,
    );
  });

  test('witnesses: no receipt, active web access and scope change clear the '
      'block', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    await f.controller.restorePurchases();
    expect(f.controller.playCheckoutBlock, PlayCheckoutBlock.none);
    expect(f.controller.playCheckoutBlockedMessageKey, isNull);
    expect(f.controller.canManagePlaySubscription, isFalse);

    final web = _Fixture(_web);
    addTearDown(web.dispose);
    web.gateway.owned = [_receipt('unbound', owner: null)];
    await web.controller.restorePurchases();
    expect(web.controller.subscription?.hasAccess, isTrue);
    expect(web.controller.playCheckoutBlock, PlayCheckoutBlock.none);
    expect(web.controller.canManagePlaySubscription, isFalse);

    final scoped = _Fixture(_none);
    addTearDown(scoped.dispose);
    scoped.gateway.owned = [_receipt('unbound', owner: null)];
    await scoped.controller.restorePurchases();
    expect(scoped.controller.playCheckoutBlocked, isTrue);
    scoped.account = BillingAccount(
      userId: 'user-b',
      accessToken: 'session-b',
      scope: Object(),
    );
    scoped.controller.syncAccount();
    expect(scoped.controller.playCheckoutBlock, PlayCheckoutBlock.none);
    scoped.account = null;
    scoped.controller.syncAccount();
    expect(scoped.controller.playCheckoutBlocked, isFalse);
    expect(scoped.controller.canManagePlaySubscription, isFalse);
  });
}

class _Fixture {
  _Fixture(BillingSubscription server) {
    api.server = server;
    controller = BillingController(
      gateway: gateway,
      api: api,
      currentAccount: () => account,
    );
  }

  final api = _Api();
  final gateway = _Gateway();
  BillingAccount? account = BillingAccount(
    userId: 'user-a',
    accessToken: 'session-a',
    scope: Object(),
  );
  late final BillingController controller;
  void dispose() => controller.dispose();
}

class _Api implements BillingApiRepository {
  BillingSubscription server = _none;
  final verifyEffects = <String, BillingSubscription>{};

  @override
  Future<BillingSubscription> getSubscription(String token) async => server;

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async =>
      const BillingPurchaseContext(
        obfuscatedAccountId: _owner,
        purchaseAllowed: true,
      );

  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async {
    server = verifyEffects[purchaseToken] ?? server;
    return BillingVerification(
      purchaseStatus: 'verified',
      subscription: server,
    );
  }
}

class _Gateway implements PlayBillingGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast(sync: true);
  List<PlayPurchase> owned = const [];
  PlayBillingException? launchError;

  @override
  Stream<PlayBillingEvent> get events => _events.stream;

  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => const [_plan];

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async {
    final error = launchError;
    if (error != null) throw error;
  }

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async => List.of(owned);

  @override
  Future<void> openSubscriptionManagement() async {}

  @override
  void dispose() => unawaited(_events.close());
}
