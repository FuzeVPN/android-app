// H-R11-01-01: the late failure of an older billing operation must not
// replace a message published after it started, typically the verification
// of a Play event. Ported from audit-complet-20261028/repros/H-R11-01
// (h_r11_01_variants_test.dart:806-844) with the assertion inverted.
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
const _active = BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: 'google_play',
);
const _inactive = BillingSubscription(status: 'inactive', hasAccess: false);
const _expired = BillingSubscription(
  status: 'expired',
  hasAccess: false,
  provider: 'google_play',
);

PlayPurchase _receipt(String token) => PlayPurchase(
  productId: 'premium',
  purchaseToken: token,
  state: 'purchased',
  obfuscatedAccountId: _owner,
  acknowledged: true,
);

Future<void> _until(bool Function() ready, {int turns = 300}) async {
  for (var i = 0; i < turns; i++) {
    if (ready()) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Controlled boundary not reached.');
}

Future<void> _drain([int turns = 20]) async {
  for (var i = 0; i < turns; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

String _verifiedMessage(BillingSubscription current) =>
    current.hasAccess ? 'billing.success' : 'billing.inactive';

void main() {
  for (final newAccess in [true, false]) {
    final old = newAccess ? _inactive : _active;
    final current = newAccess ? _active : _expired;

    test('H-R11-01-01 refresh context failure after a newer verification '
        'keeps its message (access=$newAccess)', () async {
      final f = _Fixture(old);
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      f.api.verifyEffects['new-token'] = current;
      final gate = f.api.holdContext(2, fail: true);
      final refreshing = f.controller.refreshSubscription();
      await _until(() => f.api.contextCalls == 2);
      f.gateway.emit([_receipt('new-token')]);
      await _until(() => f.api.verified.contains('new-token'));
      await _drain();
      expect(f.controller.messageKey, _verifiedMessage(current));
      gate.complete();
      await refreshing;
      await _until(() => !f.controller.isBusy);
      expect(f.controller.subscription, same(current));
      expect(f.api.trace, [
        'get', 'context', // loadPlans
        'get', 'context', // refreshSubscription, answered last with 503
        'get', 'context', 'verify:new-token', // Play event
      ]);
      expect(f.controller.messageKey, _verifiedMessage(current));
    });

    test('H-R11-01-01 catalog context failure after a newer verification '
        'keeps its message (access=$newAccess)', () async {
      final f = _Fixture(old);
      addTearDown(f.dispose);
      f.api.verifyEffects['new-token'] = current;
      final gate = f.api.holdContext(1, fail: true);
      final loading = f.controller.loadPlans();
      await _until(() => f.api.contextCalls == 1);
      f.gateway.emit([_receipt('new-token')]);
      await _until(() => f.api.verified.contains('new-token'));
      await _drain();
      expect(f.controller.messageKey, _verifiedMessage(current));
      gate.complete();
      await loading;
      await _until(() => !f.controller.isBusy);
      expect(f.controller.plans, isNotEmpty);
      expect(f.controller.messageKey, _verifiedMessage(current));
    });

    test('H-R11-01-01 restore context failure after a newer verification '
        'keeps its message (access=$newAccess)', () async {
      final f = _Fixture(old);
      addTearDown(f.dispose);
      f.api.verifyEffects['new-token'] = current;
      final gate = f.api.holdContext(1, fail: true);
      final restoring = f.controller.restorePurchases();
      await _until(() => f.api.contextCalls == 1);
      f.gateway.emit([_receipt('new-token')]);
      await _until(() => f.api.verified.contains('new-token'));
      await _drain();
      gate.complete();
      await restoring;
      await _until(() => !f.controller.isBusy);
      expect(f.controller.subscription, same(current));
      expect(f.controller.messageKey, _verifiedMessage(current));
    });

    test('H-R11-01-01 empty restore read after a newer verification keeps '
        'its message (access=$newAccess)', () async {
      final f = _Fixture(old);
      addTearDown(f.dispose);
      f.api.verifyEffects['new-token'] = current;
      final owned = f.gateway.holdOwned();
      final restoring = f.controller.restorePurchases();
      await _until(() => f.gateway.ownedQueries == 1);
      f.gateway.emit([_receipt('new-token')]);
      await _until(() => f.api.verified.contains('new-token'));
      await _drain();
      owned.complete(const <PlayPurchase>[]);
      await restoring;
      await _until(() => !f.controller.isBusy);
      expect(f.controller.messageKey, _verifiedMessage(current));
    });

    test('H-R11-01-01 purchase context failure after a newer verification '
        'keeps its message (access=$newAccess)', () async {
      final f = _Fixture(old);
      addTearDown(f.dispose);
      await f.controller.loadPlans();
      f.api.verifyEffects['new-token'] = current;
      final gate = f.api.holdContext(2, fail: true);
      final buying = f.controller.purchase(_plan);
      await _until(() => f.api.contextCalls == 2);
      f.gateway.emit([_receipt('new-token')]);
      await _until(() => f.api.verified.contains('new-token'));
      await _drain();
      gate.complete();
      await buying;
      await _until(() => !f.controller.isBusy);
      expect(f.gateway.launches, isEmpty);
      expect(f.controller.messageKey, _verifiedMessage(current));
    });
  }

  test('H-R11-01-01 witnesses: an operation alone still reports its own '
      'failure', () async {
    final f = _Fixture(_inactive);
    addTearDown(f.dispose);
    await f.controller.loadPlans();
    f.api.failingContexts.add(2);
    await f.controller.refreshSubscription();
    expect(f.controller.messageKey, 'billing.comingSoon');
    f.api.failingContexts.add(3);
    await f.controller.loadPlans();
    expect(f.controller.messageKey, 'billing.comingSoon');
    f.api.failingContexts.add(4);
    await f.controller.restorePurchases();
    expect(f.controller.messageKey, 'billing.comingSoon');
    await f.controller.restorePurchases();
    expect(f.controller.messageKey, 'billing.restoreEmpty');
    f.gateway.plans = const [];
    await f.controller.loadPlans();
    expect(f.controller.messageKey, 'billing.unavailable');
  });

  test('H-R11-01-01 a failure that starts after the verification is still '
      'shown', () async {
    final f = _Fixture(_inactive);
    addTearDown(f.dispose);
    await f.controller.loadPlans();
    f.api.verifyEffects['new-token'] = _active;
    f.gateway.emit([_receipt('new-token')]);
    await _until(
      () => !f.controller.isBusy && f.api.verified.contains('new-token'),
    );
    expect(f.controller.messageKey, 'billing.success');
    f.api.failingContexts.add(f.api.contextCalls + 1);
    await f.controller.refreshSubscription();
    expect(f.controller.messageKey, 'billing.comingSoon');
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
  final account = BillingAccount(
    userId: 'user-a',
    accessToken: 'session-a',
    scope: Object(),
  );
  late final BillingController controller;
  void dispose() => controller.dispose();
}

class _Api implements BillingApiRepository {
  BillingSubscription server = _inactive;
  final verifyEffects = <String, BillingSubscription>{};
  final verified = <String>[];
  final trace = <String>[];
  final failingContexts = <int>{};
  final _contextHolds = <int, Completer<void>>{};
  int contextCalls = 0;

  Completer<void> holdContext(int call, {bool fail = false}) {
    if (fail) failingContexts.add(call);
    return _contextHolds[call] = Completer<void>();
  }

  @override
  Future<BillingSubscription> getSubscription(String token) async {
    trace.add('get');
    return server;
  }

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async {
    final call = ++contextCalls;
    trace.add('context');
    await _contextHolds[call]?.future;
    if (failingContexts.contains(call)) {
      throw const PlayBillingException('unavailable');
    }
    return const BillingPurchaseContext(
      obfuscatedAccountId: _owner,
      purchaseAllowed: true,
    );
  }

  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async {
    trace.add('verify:$purchaseToken');
    server = verifyEffects[purchaseToken] ?? server;
    verified.add(purchaseToken);
    return BillingVerification(
      purchaseStatus: 'verified',
      subscription: server,
    );
  }
}

class _Gateway implements PlayBillingGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast(sync: true);
  List<PlaySubscriptionPlan> plans = const [_plan];
  final launches = <String>[];
  int ownedQueries = 0;
  Completer<List<PlayPurchase>>? _owned;

  Completer<List<PlayPurchase>> holdOwned() =>
      _owned = Completer<List<PlayPurchase>>();

  void emit(List<PlayPurchase> purchases) =>
      _events.add(PlayBillingEvent(type: 'purchases', purchases: purchases));

  @override
  Stream<PlayBillingEvent> get events => _events.stream;

  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => plans;

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async => launches.add(obfuscatedAccountId);

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async {
    ownedQueries++;
    final held = _owned;
    _owned = null;
    return held == null ? const <PlayPurchase>[] : await held.future;
  }

  @override
  Future<void> openSubscriptionManagement() async {}

  @override
  void dispose() => unawaited(_events.close());
}
