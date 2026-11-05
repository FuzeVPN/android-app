// H-R13-01-01 and A07-billing-02: a premium receipt on the device's Play
// account blocks a new checkout natively (PlayBillingBridge `already_owned`).
// The controller must explain it and offer Play management instead of
// "no purchase to restore" or a purchase that can only fail again.
// Ported from audit-complet-20261028/repros/H-R13-01 (V8) and
// repros/A07-billing (suspended Play receipt) with assertions inverted.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/play_billing.dart';

const _owner = 'opaque-account-a';
const _other = 'opaque-account-b';
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
const _active = BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: 'google_play',
);
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
const _expired = BillingSubscription(
  status: 'expired',
  hasAccess: false,
  provider: 'google_play',
);

PlayPurchase _receipt(
  String token, {
  String? owner = _owner,
  bool suspended = false,
  String state = 'purchased',
}) => PlayPurchase(
  productId: 'premium',
  purchaseToken: token,
  state: state,
  obfuscatedAccountId: owner,
  acknowledged: true,
  suspended: suspended,
);

void main() {
  for (final (label, owner) in <(String, String?)>[
    ('without owner', null),
    ('of another FuzeVPN account', _other),
  ]) {
    test('H-R13-01-01 checkout refused by a receipt $label explains it and '
        'offers Play management', () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      expect(f.controller.purchaseAllowed, isTrue);
      f.gateway.launchError = const PlayBillingException('already_owned');
      f.gateway.owned = [_receipt('unbound', owner: owner)];
      await f.controller.purchase(_plan);
      expect(f.gateway.ownedQueries, 1);
      expect(f.api.verified, isEmpty, reason: 'never bound to this account');
      expect(f.controller.subscription?.hasAccess, isFalse);
      expect(f.controller.messageKey, isNot('billing.restoreEmpty'));
      expect(f.controller.messageKey, isNot('billing.purchaseError'));
      expect(f.controller.messageKey, isNotNull);
      expect(f.controller.purchaseAllowed, isFalse);
      await f.controller.openManagement();
      expect(f.gateway.managementOpened, 1);
    });

    test('H-R13-01-01 restore with only a receipt $label is not reported '
        'as empty', () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      f.gateway.owned = [_receipt('unbound', owner: owner)];
      await f.controller.restorePurchases();
      expect(f.api.verified, isEmpty);
      expect(f.controller.messageKey, isNot('billing.restoreEmpty'));
      expect(f.controller.messageKey, isNotNull);
      await f.controller.loadPlans();
      expect(f.controller.purchaseAllowed, isFalse);
      await f.controller.openManagement();
      expect(f.gateway.managementOpened, 1);
    });
  }

  // Review round 2 (probes P1, P2 and W1): with access already granted, a
  // receipt of another owner blocks nothing this account would buy. Its
  // restore result stays the baseline's, never a Google Play reason that a
  // web subscriber's screen cannot act on.
  for (final (label, access) in <(String, BillingSubscription)>[
    (
      'web',
      const BillingSubscription(
        status: 'active',
        hasAccess: true,
        provider: 'sumup',
      ),
    ),
    ('Google Play', _active),
  ]) {
    for (final owner in <String?>[null, _other]) {
      test('H-R13-01-01 with $label access, a receipt of '
          '${owner ?? 'no'} owner restores as before', () async {
        final f = _Fixture(access);
        addTearDown(f.dispose);
        f.gateway.owned = [_receipt('unbound', owner: owner)];
        await f.controller.restorePurchases();
        expect(f.api.verified, isEmpty);
        expect(f.controller.subscription?.hasAccess, isTrue);
        expect(f.controller.messageKey, 'billing.restoreEmpty');
        expect(f.controller.purchaseAllowed, isFalse);
      });
    }
  }

  test('H-R13-01-01 web access that ends after a foreign receipt read '
      'blocks the purchase it would refuse', () async {
    final f = _Fixture(
      const BillingSubscription(
        status: 'active',
        hasAccess: true,
        provider: 'sumup',
      ),
    );
    addTearDown(f.dispose);
    f.gateway.owned = [_receipt('unbound', owner: _other)];
    await f.controller.restorePurchases();
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 0, reason: 'web access, no block');
    f.api.server = _none;
    await f.controller.loadPlans();
    expect(f.controller.purchaseAllowed, isFalse);
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 1);
  });

  test('H-R13-01-01 a linked receipt next to an unknown one is verified '
      'normally', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    f.api.verifyEffects['mine'] = _active;
    f.gateway.owned = [
      _receipt('unbound', owner: null),
      _receipt('mine'),
      _receipt('foreign', owner: _other),
    ];
    await f.controller.restorePurchases();
    expect(f.api.verified, ['mine']);
    expect(f.controller.messageKey, 'billing.restored');
    expect(f.controller.subscription?.hasAccess, isTrue);
  });

  test('H-R13-01-01 witness: no receipt at all still says nothing to '
      'restore and keeps the purchase', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    await f.controller.loadPlans();
    await f.controller.restorePurchases();
    expect(f.controller.messageKey, 'billing.restoreEmpty');
    expect(f.controller.purchaseAllowed, isTrue);
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 0);
  });

  test('A07-billing-02 suspended Play subscription offers management, not a '
      'purchase that Play refuses', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    await f.controller.loadPlans();
    f.api.verifyEffects['held'] = _hold;
    f.gateway.launchError = const PlayBillingException('already_owned');
    f.gateway.owned = [_receipt('held', suspended: true)];
    await f.controller.purchase(_plan);
    expect(f.api.verified, ['held']);
    expect(f.controller.subscription, same(_hold));
    expect(f.controller.messageKey, isNot('billing.inactive'));
    expect(f.controller.messageKey, isNot('billing.restoreEmpty'));
    expect(f.controller.messageKey, isNotNull);
    expect(f.controller.purchaseAllowed, isFalse);
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 1);
    // Back from Play with the payment fixed: access returns, block clears.
    f.api.verifyEffects['held'] = _active;
    f.gateway.owned = [_receipt('held')];
    await f.controller.onAppResumed();
    expect(f.controller.subscription?.hasAccess, isTrue);
    expect(f.controller.messageKey, 'billing.restored');
    expect(f.controller.purchaseAllowed, isFalse);
  });

  test(
    'A07-billing-02 the server hold alone already offers management',
    () async {
      final f = _Fixture(_hold);
      addTearDown(f.dispose);
      await f.controller.refreshSubscription();
      expect(f.controller.purchaseAllowed, isFalse);
      await f.controller.openManagement();
      expect(f.gateway.managementOpened, 1);
      // A fresh Play read without any receipt is authoritative for checkout.
      await f.controller.restorePurchases();
      expect(f.controller.purchaseAllowed, isTrue);
    },
  );

  test('A07-billing-02 a linked receipt the server reports inactive still '
      'blocks checkout', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    f.api.verifyEffects['mine'] = _playInactive;
    f.gateway.owned = [_receipt('mine')];
    await f.controller.restorePurchases();
    expect(f.controller.messageKey, 'billing.inactive');
    expect(f.controller.purchaseAllowed, isFalse);
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 1);
  });

  test('A07-billing-02 witnesses: pending and expired keep their own '
      'paths', () async {
    final pending = _Fixture(_none);
    addTearDown(pending.dispose);
    pending.api.status['wait'] = 'pending';
    pending.gateway.owned = [_receipt('wait', state: 'pending')];
    await pending.controller.restorePurchases();
    expect(pending.controller.messageKey, 'billing.pending');
    expect(pending.controller.purchaseAllowed, isFalse);

    final expired = _Fixture(_expired);
    addTearDown(expired.dispose);
    await expired.controller.loadPlans();
    expect(expired.controller.purchaseAllowed, isTrue);
    await expired.controller.openManagement();
    expect(expired.gateway.managementOpened, 1);
    await expired.controller.purchase(_plan);
    expect(expired.gateway.launches, [_owner]);
  });

  test(
    'A07-billing-02 a stale block never refuses locally: Play decides',
    () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      f.gateway.owned = [_receipt('unbound', owner: null)];
      await f.controller.restorePurchases();
      expect(f.controller.purchaseAllowed, isFalse);
      f.gateway.owned = const [];
      await f.controller.purchase(_plan);
      expect(f.gateway.launches, [_owner]);
    },
  );

  test('A07-billing-02 the block belongs to its account scope', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    await f.controller.loadPlans();
    f.gateway.owned = [_receipt('unbound', owner: null)];
    await f.controller.restorePurchases();
    expect(f.controller.purchaseAllowed, isFalse);
    f.account = BillingAccount(
      userId: 'user-b',
      accessToken: 'session-b',
      scope: Object(),
    );
    f.gateway.owned = const [];
    await f.controller.loadPlans();
    expect(f.controller.purchaseAllowed, isTrue);
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 0);
  });

  // Review round 1 (regression of the first correction): the receipt read is
  // a snapshot. When this account's own subscription lapses during the
  // session (expiry, refund, end of a hold), the Account tab refresh
  // (home_shell.dart) must offer a new subscription again, as the baseline
  // did, instead of "Manage subscription" for a receipt Play no longer holds.
  for (final lapse in const <BillingSubscription>[
    _expired,
    BillingSubscription(
      status: 'canceled',
      hasAccess: false,
      provider: 'google_play',
    ),
    BillingSubscription(
      status: 'withdrawn',
      hasAccess: false,
      provider: 'google_play',
    ),
  ]) {
    test('A07-billing-02 a linked receipt read before a ${lapse.status} lapse '
        'no longer hides the purchase', () async {
      final f = _Fixture(_none);
      addTearDown(f.dispose);
      f.api.verifyEffects['mine'] = _active;
      f.gateway.owned = [_receipt('mine')];
      await f.controller.restorePurchases();
      expect(f.controller.subscription?.hasAccess, isTrue);
      f.gateway.owned = const [];
      f.api.server = lapse;
      await f.controller.refreshSubscription();
      expect(f.controller.subscription, same(lapse));
      expect(f.controller.purchaseAllowed, isTrue);
      await f.controller.loadPlans();
      expect(f.controller.purchaseAllowed, isTrue);
      await f.controller.purchase(_plan);
      expect(f.gateway.launches, [_owner]);
      expect(f.gateway.ownedQueries, 1, reason: 'no extra Play read needed');
    });
  }

  test('A07-billing-02 the catalog refresh alone also forgets a lapsed '
      'linked receipt', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    f.api.verifyEffects['mine'] = _active;
    f.gateway.owned = [_receipt('mine')];
    await f.controller.restorePurchases();
    f.gateway.owned = const [];
    f.api.server = _expired;
    await f.controller.loadPlans();
    expect(f.controller.purchaseAllowed, isTrue);
  });

  test('A07-billing-02 a recovered subscription that lapses offers the '
      'purchase again', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    f.controller.acceptRecoveredSubscription(
      recovered: _active,
      purchaseStatus: 'verified',
      purchase: _receipt('mine'),
    );
    f.api.server = _expired;
    await f.controller.refreshSubscription();
    await f.controller.loadPlans();
    expect(f.controller.purchaseAllowed, isTrue);
  });

  test('A07-billing-02 a hold that ends without payment offers the purchase '
      'again', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    f.api.verifyEffects['held'] = _hold;
    f.gateway.owned = [_receipt('held', suspended: true)];
    await f.controller.restorePurchases();
    await f.controller.loadPlans();
    expect(f.controller.purchaseAllowed, isFalse);
    f.gateway.owned = const [];
    f.api.server = _expired;
    await f.controller.refreshSubscription();
    expect(f.controller.purchaseAllowed, isTrue);
  });

  test('A07-billing-02 witnesses: an unchanged server snapshot keeps the '
      'block', () async {
    // Linked receipt the server reports inactive.
    final inactive = _Fixture(_none);
    addTearDown(inactive.dispose);
    inactive.api.verifyEffects['mine'] = _playInactive;
    inactive.gateway.owned = [_receipt('mine')];
    await inactive.controller.restorePurchases();
    await inactive.controller.refreshSubscription();
    await inactive.controller.loadPlans();
    expect(inactive.controller.purchaseAllowed, isFalse);

    // Suspended receipt and server hold.
    final held = _Fixture(_none);
    addTearDown(held.dispose);
    held.api.verifyEffects['held'] = _hold;
    held.gateway.owned = [_receipt('held', suspended: true)];
    await held.controller.restorePurchases();
    await held.controller.refreshSubscription();
    await held.controller.loadPlans();
    expect(held.controller.purchaseAllowed, isFalse);
    await held.controller.openManagement();
    expect(held.gateway.managementOpened, 1);
  });

  test('H-R13-01-01 witnesses: a receipt of another owner is not this '
      "account's subscription and keeps blocking", () async {
    // Its owner's lapse is not visible on this account's entitlement.
    final unlinked = _Fixture(_none);
    addTearDown(unlinked.dispose);
    unlinked.gateway.owned = [_receipt('unbound', owner: null)];
    await unlinked.controller.restorePurchases();
    unlinked.api.server = _expired;
    await unlinked.controller.refreshSubscription();
    await unlinked.controller.loadPlans();
    expect(unlinked.controller.purchaseAllowed, isFalse);

    // Seen next to this account's lapsed receipt, it still blocks.
    final both = _Fixture(_none);
    addTearDown(both.dispose);
    both.api.verifyEffects['mine'] = _active;
    both.gateway.owned = [_receipt('mine'), _receipt('foreign', owner: _other)];
    await both.controller.restorePurchases();
    expect(both.api.verified, ['mine']);
    both.api.server = _expired;
    await both.controller.refreshSubscription();
    await both.controller.loadPlans();
    expect(both.controller.purchaseAllowed, isFalse);
    await both.controller.openManagement();
    expect(both.gateway.managementOpened, 1);
  });

  test('A07-billing-02 a recovered suspended subscription asks to fix '
      'payment', () async {
    final f = _Fixture(_none);
    addTearDown(f.dispose);
    f.controller.acceptRecoveredSubscription(
      recovered: _hold,
      purchaseStatus: 'verified',
      purchase: _receipt('held', suspended: true),
    );
    expect(f.controller.messageKey, isNot('billing.inactive'));
    expect(f.controller.messageKey, isNotNull);
    await f.controller.openManagement();
    expect(f.gateway.managementOpened, 1);
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
  final status = <String, String>{};
  final verified = <String>[];

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
    verified.add(purchaseToken);
    server = verifyEffects[purchaseToken] ?? server;
    return BillingVerification(
      purchaseStatus: status[purchaseToken] ?? 'verified',
      subscription: server,
    );
  }
}

class _Gateway implements PlayBillingGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast(sync: true);
  List<PlayPurchase> owned = const [];
  PlayBillingException? launchError;
  final launches = <String>[];
  int ownedQueries = 0;
  int managementOpened = 0;

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
    launches.add(obfuscatedAccountId);
  }

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async {
    ownedQueries++;
    return List.of(owned);
  }

  @override
  Future<void> openSubscriptionManagement() async => managementOpened++;

  @override
  void dispose() => unawaited(_events.close());
}
