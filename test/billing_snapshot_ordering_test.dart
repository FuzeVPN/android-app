import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/play_billing.dart';

const _inactive = BillingSubscription(status: 'inactive', hasAccess: false);
const _active = BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: 'google_play',
);
const _owner = 'review-owner';
const _plan = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'review-offer',
  formattedPrice: '4,99 EUR',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4990000,
);
const _purchase = PlayPurchase(
  productId: 'premium',
  purchaseToken: 'review-token',
  state: 'purchased',
  obfuscatedAccountId: _owner,
  acknowledged: true,
);

Future<void> _until(bool Function() condition) async {
  for (var i = 0; i < 40; i++) {
    if (condition()) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Controlled boundary not reached.');
}

void main() {
  for (final currentAccess in [false, true]) {
    test(
      'L global snapshot: GET after held verify stays current access=$currentAccess',
      () async {
        final f = _Fixture();
        addTearDown(f.dispose);
        await f.controller.loadPlans();
        final old = currentAccess ? _inactive : _active;
        final current = currentAccess ? _active : _inactive;
        final oldVerify = Completer<BillingVerification>();
        final catalog = Completer<List<PlaySubscriptionPlan>>();
        f.api.current = old;
        f.api.verification = () => oldVerify.future;
        f.gateway.catalog = catalog.future;
        final loading = f.controller.loadPlans();
        f.gateway.emit(_purchase);
        await _until(() => f.api.verificationCalls == 1);
        // The first server operation has captured old; a later read sees current.
        // A correct implementation can also delay this read until verify settles.
        f.api.current = current;
        final readsBefore = f.api.reads;
        catalog.complete(const [_plan]);
        for (var i = 0; i < 5; i++) {
          await Future<void>.delayed(Duration.zero);
        }
        expect(f.api.reads, readsBefore);
        oldVerify.complete(
          BillingVerification(purchaseStatus: 'verified', subscription: old),
        );
        await loading;
        await _until(() => !f.controller.isBusy);
        expect(
          f.controller.subscription,
          same(current),
          reason:
              'The older verify snapshot must not roll back a later server read.',
        );
        expect(f.api.current, same(current));
      },
    );

    test(
      'L global snapshot: recovered entitlement supersedes held verify access=$currentAccess',
      () async {
        final f = _Fixture();
        addTearDown(f.dispose);
        await f.controller.loadPlans();
        final old = currentAccess ? _inactive : _active;
        final current = currentAccess ? _active : _inactive;
        final oldVerify = Completer<BillingVerification>();
        f.api.verification = () => oldVerify.future;
        f.gateway.emit(_purchase);
        await _until(() => f.api.verificationCalls == 1);
        f.api.current = current;
        f.controller.acceptRecoveredSubscription(
          recovered: current,
          purchaseStatus: 'verified',
          purchase: _purchase,
        );
        expect(f.controller.subscription, same(current));
        oldVerify.complete(
          BillingVerification(purchaseStatus: 'verified', subscription: old),
        );
        await _until(() => !f.controller.isBusy);
        expect(
          f.controller.subscription,
          same(current),
          reason:
              'An outstanding older verify must not replace accepted server recovery.',
        );
        expect(
          f.controller.messageKey,
          currentAccess ? 'billing.restored' : 'billing.inactive',
        );
        expect(f.api.current, same(current));
      },
    );
  }

  test(
    'L recovery fence admits a queued verify actually emitted after recovery',
    () async {
      final f = _Fixture();
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      final first = Completer<BillingVerification>();
      const secondPurchase = PlayPurchase(
        productId: 'premium',
        purchaseToken: 'queued-after-first',
        state: 'purchased',
        obfuscatedAccountId: _owner,
        acknowledged: true,
      );
      f.gateway.owned = const [_purchase];
      f.api.byToken = (token) => token == _purchase.purchaseToken
          ? first.future
          : Future.value(
              const BillingVerification(
                purchaseStatus: 'verified',
                subscription: _inactive,
              ),
            );
      final restoring = f.controller.restorePurchases();
      await _until(() => f.api.verificationCalls == 1);
      f.gateway.emit(secondPurchase);
      for (var i = 0; i < 5; i++) {
        await Future<void>.delayed(Duration.zero);
      }
      expect(
        f.api.verificationCalls,
        1,
        reason: 'The second verify is queued behind the first network request.',
      );
      f.controller.acceptRecoveredSubscription(
        recovered: _active,
        purchaseStatus: 'verified',
        purchase: _purchase,
      );
      // Recovery was authoritative when accepted. Before the second request is
      // emitted the server changes; that subsequent response is authoritative too.
      f.api.current = _inactive;
      first.complete(
        const BillingVerification(
          purchaseStatus: 'verified',
          subscription: _inactive,
        ),
      );
      await restoring;
      await _until(() => !f.controller.isBusy);
      expect(f.api.verificationCalls, 2);
      expect(f.controller.subscription, same(_inactive));
      expect(f.controller.messageKey, 'billing.inactive');
    },
  );

  test(
    'L catalog refresh waiting for verify preserves the owner of every receipt in a batch',
    () async {
      final f = _Fixture();
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      final first = Completer<BillingVerification>();
      final catalog = Completer<List<PlaySubscriptionPlan>>();
      const secondPurchase = PlayPurchase(
        productId: 'premium',
        purchaseToken: 'second-valid-receipt',
        state: 'purchased',
        obfuscatedAccountId: _owner,
        acknowledged: true,
      );
      f.api.byToken = (token) => token == _purchase.purchaseToken
          ? first.future
          : Future.value(
              const BillingVerification(
                purchaseStatus: 'verified',
                subscription: _active,
              ),
            );
      f.gateway.catalog = catalog.future;
      final loading = f.controller.loadPlans();
      f.gateway.emitBatch(const [_purchase, secondPurchase]);
      await _until(() => f.api.verificationCalls == 1);
      catalog.complete(const [_plan]);
      for (var i = 0; i < 5; i++) {
        await Future<void>.delayed(Duration.zero);
      }
      first.complete(
        const BillingVerification(
          purchaseStatus: 'verified',
          subscription: _active,
        ),
      );
      await loading;
      await _until(() => !f.controller.isBusy);
      expect(
        f.api.verificationCalls,
        2,
        reason:
            'Refreshing context must not discard the validated binding for the rest of a receipt batch.',
      );
    },
  );
}

class _Fixture {
  _Fixture() {
    controller = BillingController(
      gateway: gateway,
      api: api,
      currentAccount: () => account,
    );
  }
  final account = BillingAccount(
    userId: 'review-user',
    accessToken: 'review-session',
    scope: Object(),
  );
  final api = _Api();
  final gateway = _Gateway();
  late final BillingController controller;
  void dispose() => controller.dispose();
}

class _Api implements BillingApiRepository {
  BillingSubscription current = _inactive;
  Future<BillingVerification> Function()? verification;
  Future<BillingVerification> Function(String)? byToken;
  int reads = 0;
  int verificationCalls = 0;
  @override
  Future<BillingSubscription> getSubscription(String token) async {
    reads++;
    return current;
  }

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async =>
      BillingPurchaseContext(
        obfuscatedAccountId: _owner,
        purchaseAllowed: !current.hasAccess,
      );
  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) {
    verificationCalls++;
    return byToken?.call(purchaseToken) ??
        verification?.call() ??
        Future.value(
          BillingVerification(
            purchaseStatus: 'verified',
            subscription: current,
          ),
        );
  }
}

class _Gateway implements PlayBillingGateway {
  final source = StreamController<PlayBillingEvent>.broadcast(sync: true);
  Future<List<PlaySubscriptionPlan>>? catalog;
  List<PlayPurchase> owned = const [];
  void emit(PlayPurchase purchase) =>
      source.add(PlayBillingEvent(type: 'purchases', purchases: [purchase]));
  void emitBatch(List<PlayPurchase> purchases) =>
      source.add(PlayBillingEvent(type: 'purchases', purchases: purchases));
  @override
  Stream<PlayBillingEvent> get events => source.stream;
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() =>
      catalog ?? Future.value(const [_plan]);
  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async => owned;
  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async {}
  @override
  Future<void> openSubscriptionManagement() async {}
  @override
  void dispose() => unawaited(source.close());
}
