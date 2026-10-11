import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/play_billing.dart';

const _monthly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'play-offer-test',
  formattedPrice: '4,99 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4990000,
);
const _inactive = BillingSubscription(status: 'inactive', hasAccess: false);
const _ownerA = 'opaque-account-a';
const _ownerB = 'opaque-account-b';
const _processing = BillingVerification(
  purchaseStatus: 'processing',
  subscription: _inactive,
);
const _shortRetryDelays = <Duration>[
  Duration(seconds: 1),
  Duration(seconds: 1),
  Duration(seconds: 1),
  Duration(seconds: 1),
  Duration(seconds: 1),
];

BillingSubscription _active({
  DateTime? expiresAt,
  String provider = 'google_play',
}) => BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: provider,
  expiresAt: expiresAt ?? DateTime.utc(2099, 1, 1),
);

PlayPurchase _purchase({
  String owner = _ownerA,
  String token = 'purchase-token-test',
  String state = 'purchased',
  bool acknowledged = false,
}) => PlayPurchase(
  productId: 'premium',
  purchaseToken: token,
  state: state,
  obfuscatedAccountId: owner,
  acknowledged: acknowledged,
);

Future<void> _drainEvents() => Future<void>.delayed(Duration.zero);

Future<void> _until(bool Function() ready) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    if (ready()) return;
    await _drainEvents();
  }
  fail('The controlled billing operation did not reach its expected boundary.');
}

void main() {
  test(
    'changed Play offer clears catalogue and requires a new choice',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      await fixture.controller.loadPlans();
      fixture.gateway.onLaunch = (_, _) async =>
          throw const PlayBillingException('price_changed');

      await fixture.controller.purchase(_monthly);

      expect(fixture.controller.messageKey, 'billing.offerChanged');
      expect(fixture.controller.plans, isEmpty);
      expect(fixture.controller.catalogLoaded, isFalse);
      expect(fixture.controller.isBusy, isFalse);
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.gateway.openedOwners, isEmpty);
      expect(fixture.api.verifications, isEmpty);

      await fixture.controller.purchase(_monthly);
      expect(fixture.gateway.launchRequests, hasLength(1));
      fixture.gateway.onLaunch = null;
      await fixture.controller.loadPlans();
      expect(fixture.controller.messageKey, isNull);
      await fixture.controller.purchase(_monthly);
      expect(fixture.gateway.openedOwners, <String>[_ownerA]);
    },
  );

  test(
    'Play acceptance and acknowledgement do not grant access before verification',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      final verification = Completer<BillingVerification>();
      fixture.api.onVerify = (_, _) => verification.future;
      await fixture.controller.loadPlans();
      await fixture.controller.purchase(_monthly);

      expect(fixture.gateway.openedOwners, <String>[_ownerA]);
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.isBusy, isTrue);

      fixture.gateway.emitPurchase(_purchase(acknowledged: true));
      await _until(() => fixture.api.verifications.length == 1);
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.messageKey, 'billing.verifying');
      expect(fixture.controller.isBusy, isTrue);

      verification.complete(
        BillingVerification(
          purchaseStatus: 'verified',
          subscription: _active(),
        ),
      );
      await _until(() => fixture.controller.subscription?.hasAccess == true);
      expect(fixture.controller.messageKey, 'billing.success');
      expect(fixture.controller.isBusy, isFalse);
      expect(fixture.api.verifications.single.accessToken, 'session-a');
      expect(
        fixture.api.verifications.single.purchaseToken,
        'purchase-token-test',
      );
    },
  );

  for (final status in <String>['pending', 'processing']) {
    test(
      '$status grants no new access and prevents a second checkout',
      () async {
        final fixture = _Fixture();
        addTearDown(fixture.dispose);
        fixture.api.verification = BillingVerification(
          purchaseStatus: status,
          subscription: _inactive,
        );
        await fixture.controller.loadPlans();
        await fixture.controller.purchase(_monthly);
        fixture.gateway.emitPurchase(_purchase(state: 'pending'));
        await _until(
          () =>
              fixture.api.verifications.length == 1 &&
              !fixture.controller.isBusy,
        );

        expect(fixture.controller.subscription?.hasAccess, isFalse);
        expect(fixture.controller.purchaseAllowed, isFalse);
        await fixture.controller.purchase(_monthly);
        expect(fixture.gateway.launchRequests, hasLength(1));
        expect(fixture.controller.isBusy, isFalse);
      },
    );
  }

  test(
    'pending preserves independent web access confirmed by the server',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.api.verification = BillingVerification(
        purchaseStatus: 'pending',
        subscription: _active(provider: 'sumup'),
      );
      await fixture.controller.loadPlans();
      fixture.gateway.emitPurchase(_purchase(state: 'pending'));
      await _until(() => fixture.controller.messageKey == 'billing.pending');

      expect(fixture.controller.subscription?.hasAccess, isTrue);
      expect(fixture.controller.subscription?.provider, 'sumup');
      expect(fixture.controller.purchaseAllowed, isFalse);
    },
  );

  test(
    'an absent purchase-context route blocks launch even with cached plans',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      await fixture.controller.loadPlans();
      expect(fixture.controller.purchaseAllowed, isTrue);
      fixture.api.onContext = (_) async =>
          throw const ApiException(statusCode: 404, errorCode: 'not_found');

      await fixture.controller.purchase(_monthly);
      expect(fixture.gateway.launchRequests, isEmpty);
      expect(fixture.controller.purchaseAllowed, isFalse);
      expect(fixture.controller.messageKey, 'billing.comingSoon');
      expect(fixture.controller.isBusy, isFalse);
    },
  );

  test(
    'web access blocks checkout even when a context incorrectly allows it',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.api.subscriptions['session-a'] = _active(provider: 'sumup');
      await fixture.controller.loadPlans();
      await fixture.controller.purchase(_monthly);

      expect(fixture.gateway.launchRequests, isEmpty);
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      expect(fixture.controller.messageKey, 'billing.webManaged');
    },
  );

  test(
    'a late context for the previous account cannot start checkout',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      await fixture.controller.loadPlans();
      final oldContext = Completer<BillingPurchaseContext>();
      fixture.api.onContext = (token) => token == 'session-a'
          ? oldContext.future
          : Future.value(fixture.api.contexts[token]!);
      final purchasing = fixture.controller.purchase(_monthly);
      await _until(() => fixture.api.contextReads.length == 2);

      fixture.switchToB();
      await fixture.controller.loadPlans();
      final currentRevision = fixture.controller.accountRevision;
      oldContext.complete(
        const BillingPurchaseContext(
          obfuscatedAccountId: _ownerA,
          purchaseAllowed: true,
        ),
      );
      await purchasing;

      expect(fixture.gateway.launchRequests, isEmpty);
      expect(fixture.controller.accountRevision, currentRevision);
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.purchaseAllowed, isTrue);
      expect(fixture.controller.messageKey, isNull);
    },
  );

  for (final sameUser in <bool>[false, true]) {
    test(
      'late verification is ignored after ${sameUser ? 'a new session for the same user' : 'an account change'}',
      () async {
        final fixture = _Fixture();
        addTearDown(fixture.dispose);
        final verification = Completer<BillingVerification>();
        fixture.api.onVerify = (_, _) => verification.future;
        await fixture.controller.loadPlans();
        fixture.gateway.emitPurchase(_purchase());
        await _until(() => fixture.api.verifications.length == 1);

        fixture.account = BillingAccount(
          userId: sameUser ? 'user-a' : 'user-b',
          accessToken: 'session-b',
          scope: Object(),
        );
        if (sameUser) {
          fixture.api.contexts['session-b'] = const BillingPurchaseContext(
            obfuscatedAccountId: _ownerA,
            purchaseAllowed: true,
          );
        }
        fixture.controller.syncAccount();
        await fixture.controller.loadPlans();
        verification.complete(
          BillingVerification(
            purchaseStatus: 'verified',
            subscription: _active(),
          ),
        );
        await _drainEvents();

        expect(fixture.controller.subscription?.hasAccess, isFalse);
        expect(fixture.controller.purchaseAllowed, isTrue);
        expect(fixture.controller.messageKey, isNull);
        expect(fixture.controller.isBusy, isFalse);
        expect(fixture.gateway.invalidations, 2);
      },
    );
  }

  test(
    'changing account cancels native preparation before the payment sheet opens',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      final preparation = Completer<void>();
      fixture.gateway.onLaunch = (_, _) => preparation.future;
      await fixture.controller.loadPlans();
      final purchasing = fixture.controller.purchase(_monthly);
      await _until(() => fixture.gateway.launchRequests.length == 1);

      fixture.switchToB();
      preparation.complete();
      await purchasing;
      expect(fixture.gateway.invalidations, 2);
      expect(fixture.gateway.openedOwners, isEmpty);
      expect(fixture.controller.subscription, isNull);
      expect(fixture.controller.isBusy, isFalse);
      expect(fixture.controller.messageKey, isNull);
    },
  );

  test(
    'foreign purchases and foreign cancellation never affect a checkout',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      await fixture.controller.loadPlans();
      await fixture.controller.purchase(_monthly);
      fixture.gateway.emitPurchase(_purchase(owner: _ownerB));
      fixture.gateway.emit(
        const PlayBillingEvent(type: 'cancelled', obfuscatedAccountId: _ownerB),
      );
      await _drainEvents();

      expect(fixture.api.verifications, isEmpty);
      expect(fixture.controller.isBusy, isTrue);
      expect(fixture.controller.subscription?.hasAccess, isFalse);

      fixture.gateway.emit(
        const PlayBillingEvent(type: 'cancelled', obfuscatedAccountId: _ownerA),
      );
      await _until(() => !fixture.controller.isBusy);
      fixture.gateway.owned = <PlayPurchase>[_purchase(owner: _ownerB)];
      await fixture.controller.restorePurchases();
      expect(fixture.api.verifications, isEmpty);
      expect(fixture.controller.messageKey, 'billing.restoreEmpty');
    },
  );

  test(
    'empty recovery with the checkout owner releases the waiting state',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      await fixture.controller.loadPlans();
      await fixture.controller.purchase(_monthly);
      expect(fixture.controller.isBusy, isTrue);

      fixture.gateway.emit(
        const PlayBillingEvent(type: 'purchases', obfuscatedAccountId: _ownerA),
      );
      await _until(() => !fixture.controller.isBusy);
      expect(fixture.api.verifications, isEmpty);
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      await fixture.controller.restorePurchases();
      expect(fixture.gateway.ownedQueries, 1);
    },
  );

  test(
    'a queued cancellation from an earlier session cannot clear a new checkout for the same owner',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      final delayed = Completer<BillingVerification>();
      fixture.api.onVerify = (_, _) => delayed.future;
      await fixture.controller.loadPlans();
      fixture.gateway.emitPurchase(_purchase());
      await _until(() => fixture.api.verifications.isNotEmpty);
      fixture.gateway.emit(
        const PlayBillingEvent(type: 'cancelled', obfuscatedAccountId: _ownerA),
      );
      fixture.account = BillingAccount(
        userId: fixture.account!.userId,
        accessToken: fixture.account!.accessToken,
        scope: Object(),
      );
      fixture.controller.syncAccount();
      await fixture.controller.loadPlans();
      await fixture.controller.purchase(_monthly);
      expect(fixture.controller.isBusy, isTrue);
      delayed.complete(
        BillingVerification(
          purchaseStatus: 'verified',
          subscription: _active(),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(fixture.controller.isBusy, isTrue);
      expect(fixture.controller.messageKey, isNot('billing.cancelled'));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
    },
  );

  test('a repeated subscription token is reverified after renewal', () async {
    final fixture = _Fixture();
    addTearDown(fixture.dispose);
    final firstExpiry = DateTime.utc(2099, 1, 1);
    final renewedExpiry = DateTime.utc(2099, 2, 1);
    fixture.api.onVerify = (_, _) async => BillingVerification(
      purchaseStatus: 'verified',
      subscription: _active(
        expiresAt: fixture.api.verifications.length == 1
            ? firstExpiry
            : renewedExpiry,
      ),
    );
    await fixture.controller.loadPlans();
    fixture.gateway.emitPurchase(_purchase());
    await _until(
      () => fixture.controller.subscription?.expiresAt == firstExpiry,
    );

    fixture.gateway.emitPurchase(_purchase(acknowledged: true));
    await _until(
      () => fixture.controller.subscription?.expiresAt == renewedExpiry,
    );
    expect(fixture.api.verifications, hasLength(2));
    expect(
      fixture.api.verifications.map((request) => request.purchaseToken).toSet(),
      hasLength(1),
    );
  });

  test(
    'a Play callback before launch completion remains busy until verification finishes',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      final launch = Completer<void>();
      final verification = Completer<BillingVerification>();
      fixture.api.onVerify = (_, _) => verification.future;
      fixture.gateway.onLaunch = (_, _) {
        fixture.gateway.emitPurchase(_purchase());
        return launch.future;
      };
      await fixture.controller.loadPlans();
      final purchasing = fixture.controller.purchase(_monthly);
      await _until(() => fixture.api.verifications.length == 1);

      launch.complete();
      await purchasing;
      expect(fixture.controller.isBusy, isTrue);
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      await fixture.controller.purchase(_monthly);
      expect(fixture.gateway.launchRequests, hasLength(1));

      verification.complete(
        BillingVerification(
          purchaseStatus: 'verified',
          subscription: _active(),
        ),
      );
      await _until(() => !fixture.controller.isBusy);
      expect(fixture.controller.subscription?.hasAccess, isTrue);
    },
  );

  test(
    'an event and restoration share an in-flight verification of the same token',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      final verification = Completer<BillingVerification>();
      fixture.api.onVerify = (_, _) => verification.future;
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      final restoring = fixture.controller.restorePurchases();
      await _until(() => fixture.api.verifications.length == 1);

      fixture.gateway.emitPurchase(_purchase());
      await _drainEvents();
      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.isBusy, isTrue);

      verification.complete(
        BillingVerification(
          purchaseStatus: 'verified',
          subscription: _active(),
        ),
      );
      await restoring;
      await _until(() => !fixture.controller.isBusy);
      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.subscription?.hasAccess, isTrue);
    },
  );

  test(
    'restoration revalidates acknowledged purchases and never trusts their local state',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.gateway.owned = <PlayPurchase>[_purchase(acknowledged: true)];
      fixture.api.verification = const BillingVerification(
        purchaseStatus: 'verified',
        subscription: _inactive,
      );

      await fixture.controller.restorePurchases();
      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.messageKey, 'billing.inactive');
    },
  );

  test(
    'an unknown verification status cannot grant access through an injected API',
    () async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.api.verification = BillingVerification(
        purchaseStatus: 'unexpected',
        subscription: _active(),
      );
      await fixture.controller.loadPlans();
      fixture.gateway.emitPurchase(_purchase());
      await _until(
        () => fixture.controller.messageKey == 'billing.verificationError',
      );

      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.purchaseAllowed, isFalse);
    },
  );

  testWidgets(
    'processing retries use the default delays and stop after five attempts',
    (tester) async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.api.verification = _processing;
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      await fixture.controller.restorePurchases();
      expect(fixture.api.verifications, hasLength(1));

      const delays = <Duration>[
        Duration(seconds: 2),
        Duration(seconds: 4),
        Duration(seconds: 8),
        Duration(seconds: 12),
        Duration(seconds: 16),
      ];
      for (var index = 0; index < delays.length; index++) {
        await tester.pump(delays[index] - const Duration(milliseconds: 1));
        expect(fixture.api.verifications, hasLength(index + 1));
        await tester.pump(const Duration(milliseconds: 1));
        expect(fixture.api.verifications, hasLength(index + 2));
      }
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(6));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.purchaseAllowed, isFalse);
      fixture.dispose();
    },
  );

  testWidgets(
    'a processing retry grants only verified server access and then stops',
    (tester) async {
      final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
      addTearDown(fixture.dispose);
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      fixture.api.onVerify = (_, _) async =>
          fixture.api.verifications.length == 1
          ? _processing
          : BillingVerification(
              purchaseStatus: 'verified',
              subscription: _active(),
            );
      await fixture.controller.restorePurchases();
      expect(fixture.controller.subscription?.hasAccess, isFalse);

      await tester.pump(const Duration(seconds: 1));
      expect(fixture.api.verifications, hasLength(2));
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      expect(fixture.controller.subscription?.provider, 'google_play');
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(2));
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      fixture.dispose();
    },
  );

  for (final (serverDelay, expectedDelay) in const <(Duration, Duration)>[
    (Duration(seconds: 5), Duration(seconds: 5)),
    (Duration.zero, Duration(seconds: 2)),
    (Duration(seconds: 61), Duration(seconds: 2)),
  ]) {
    testWidgets(
      'processing Retry-After ${serverDelay.inSeconds}s uses a ${expectedDelay.inSeconds}s delay',
      (tester) async {
        final fixture = _Fixture();
        addTearDown(fixture.dispose);
        fixture.api.verification = BillingVerification(
          purchaseStatus: 'processing',
          subscription: _inactive,
          retryAfter: serverDelay,
        );
        fixture.gateway.owned = <PlayPurchase>[_purchase()];
        await fixture.controller.restorePurchases();
        expect(fixture.api.verifications, hasLength(1));

        await tester.pump(expectedDelay - const Duration(milliseconds: 1));
        expect(fixture.api.verifications, hasLength(1));
        await tester.pump(const Duration(milliseconds: 1));
        expect(fixture.api.verifications, hasLength(2));
        expect(fixture.controller.subscription?.hasAccess, isFalse);
        fixture.dispose();
      },
    );
  }

  testWidgets(
    'processing verification survives a failed context refresh for the same account',
    (tester) async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      await fixture.controller.loadPlans();
      fixture.api.verification = _processing;
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      await fixture.controller.restorePurchases();
      expect(fixture.api.verifications, hasLength(1));

      fixture.api.onContext = (_) async => throw const ApiException(
        statusCode: 503,
        errorCode: 'google_play_unavailable',
      );
      await fixture.controller.refreshSubscription();
      expect(fixture.controller.purchaseAllowed, isFalse);
      expect(fixture.controller.messageKey, 'billing.comingSoon');
      fixture.api.verification = BillingVerification(
        purchaseStatus: 'verified',
        subscription: _active(),
      );

      await tester.pump(const Duration(seconds: 2));
      expect(fixture.api.verifications, hasLength(2));
      expect(fixture.api.verifications.last.accessToken, 'session-a');
      expect(
        fixture.api.verifications.last.purchaseToken,
        'purchase-token-test',
      );
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      expect(fixture.controller.purchaseAllowed, isFalse);

      fixture.api.subscriptions['session-a'] = _active();
      await fixture.controller.purchase(_monthly);
      expect(fixture.gateway.launchRequests, isEmpty);
      expect(fixture.controller.purchaseAllowed, isFalse);
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(2));
      fixture.dispose();
    },
  );

  for (final outcome in <String>['pending', 'error']) {
    testWidgets('$outcome does not start processing retries', (tester) async {
      final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
      addTearDown(fixture.dispose);
      fixture.gateway.owned = <PlayPurchase>[_purchase(state: 'pending')];
      if (outcome == 'pending') {
        fixture.api.verification = const BillingVerification(
          purchaseStatus: 'pending',
          subscription: _inactive,
        );
      } else {
        fixture.api.onVerify = (_, _) async => throw const ApiException(
          statusCode: 503,
          errorCode: 'google_play_unavailable',
        );
      }
      await fixture.controller.restorePurchases();
      await tester.pump(const Duration(minutes: 2));

      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.purchaseAllowed, isFalse);
      fixture.dispose();
    });
  }

  testWidgets('a processing retry that becomes pending stops retrying', (
    tester,
  ) async {
    final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
    addTearDown(fixture.dispose);
    fixture.gateway.owned = <PlayPurchase>[_purchase()];
    fixture.api.onVerify = (_, _) async => fixture.api.verifications.length == 1
        ? _processing
        : const BillingVerification(
            purchaseStatus: 'pending',
            subscription: _inactive,
          );
    await fixture.controller.restorePurchases();
    await tester.pump(const Duration(seconds: 1));
    expect(fixture.api.verifications, hasLength(2));
    expect(fixture.controller.messageKey, 'billing.pending');

    await tester.pump(const Duration(minutes: 2));
    expect(fixture.api.verifications, hasLength(2));
    expect(fixture.controller.purchaseAllowed, isFalse);
    fixture.dispose();
  });

  testWidgets('a processing retry that fails stops retrying', (tester) async {
    final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
    addTearDown(fixture.dispose);
    fixture.gateway.owned = <PlayPurchase>[_purchase()];
    fixture.api.onVerify = (_, _) async {
      if (fixture.api.verifications.length == 1) return _processing;
      throw const ApiException(
        statusCode: 503,
        errorCode: 'google_play_unavailable',
      );
    };
    await fixture.controller.restorePurchases();
    await tester.pump(const Duration(seconds: 1));
    expect(fixture.api.verifications, hasLength(2));
    expect(fixture.controller.messageKey, 'billing.verificationError');

    await tester.pump(const Duration(minutes: 2));
    expect(fixture.api.verifications, hasLength(2));
    expect(fixture.controller.purchaseAllowed, isFalse);
    fixture.dispose();
  });

  testWidgets('account change cancels scheduled processing retries', (
    tester,
  ) async {
    final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
    addTearDown(fixture.dispose);
    fixture.api.verification = _processing;
    fixture.gateway.owned = <PlayPurchase>[_purchase()];
    await fixture.controller.restorePurchases();
    expect(fixture.api.verifications, hasLength(1));

    fixture.switchToB();
    await tester.pump(const Duration(minutes: 2));
    expect(fixture.api.verifications, hasLength(1));
    expect(fixture.controller.subscription, isNull);
    expect(fixture.controller.messageKey, isNull);
    fixture.dispose();
  });

  testWidgets('disposal cancels scheduled processing retries', (tester) async {
    final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
    addTearDown(fixture.dispose);
    fixture.api.verification = _processing;
    fixture.gateway.owned = <PlayPurchase>[_purchase()];
    await fixture.controller.restorePurchases();
    fixture.dispose();

    await tester.pump(const Duration(minutes: 2));
    expect(fixture.api.verifications, hasLength(1));
  });

  testWidgets(
    'foreground restores fresh SDK purchases for a pending transaction',
    (tester) async {
      final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
      addTearDown(fixture.dispose);
      fixture.api.verification = const BillingVerification(
        purchaseStatus: 'pending',
        subscription: _inactive,
      );
      fixture.gateway.owned = <PlayPurchase>[
        _purchase(token: 'before-background'),
      ];
      await fixture.controller.restorePurchases();
      expect(fixture.gateway.ownedQueries, 1);

      fixture.controller.onAppPaused();
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(1));
      fixture.gateway.owned = <PlayPurchase>[_purchase(token: 'after-resume')];
      fixture.api.verification = BillingVerification(
        purchaseStatus: 'verified',
        subscription: _active(),
      );
      await fixture.controller.onAppResumed();

      expect(fixture.gateway.ownedQueries, 2);
      expect(fixture.api.verifications, hasLength(2));
      expect(fixture.api.verifications.last.purchaseToken, 'after-resume');
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(2));
      fixture.dispose();
    },
  );

  testWidgets(
    'processing resume preserves Retry-After and the five-retry budget despite SDK callbacks',
    (tester) async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.api.verification = const BillingVerification(
        purchaseStatus: 'processing',
        subscription: _inactive,
        retryAfter: Duration(seconds: 5),
      );
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      await fixture.controller.restorePurchases();
      fixture.gateway.emitPurchase(_purchase());
      await tester.pump();
      expect(fixture.api.verifications, hasLength(1));

      await tester.pump(const Duration(seconds: 5));
      expect(fixture.api.verifications, hasLength(2));
      fixture.controller.onAppPaused();
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(2));

      await fixture.controller.onAppResumed();
      expect(fixture.gateway.ownedQueries, 1);
      expect(fixture.api.verifications, hasLength(2));
      await tester.pump(const Duration(milliseconds: 4999));
      expect(fixture.api.verifications, hasLength(2));
      await tester.pump(const Duration(milliseconds: 1));
      expect(fixture.api.verifications, hasLength(3));
      for (var calls = 4; calls <= 6; calls++) {
        await tester.pump(const Duration(seconds: 5));
        expect(fixture.api.verifications, hasLength(calls));
      }
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(6));

      fixture.gateway.emitPurchase(_purchase(acknowledged: true));
      await tester.pump();
      fixture.controller.onAppPaused();
      await fixture.controller.onAppResumed();
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.gateway.ownedQueries, 1);
      expect(fixture.api.verifications, hasLength(6));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.purchaseAllowed, isFalse);

      fixture.api.verification = BillingVerification(
        purchaseStatus: 'verified',
        subscription: _active(),
      );
      await fixture.controller.restorePurchases();
      expect(fixture.gateway.ownedQueries, 2);
      expect(fixture.api.verifications, hasLength(7));
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(7));
      fixture.dispose();
    },
  );

  testWidgets(
    'SDK pending-to-purchased progression waits for in-flight verification then verifies once',
    (tester) async {
      final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
      addTearDown(fixture.dispose);
      final initialVerification = Completer<BillingVerification>();
      fixture.gateway.owned = <PlayPurchase>[_purchase(state: 'pending')];
      fixture.api.onVerify = (_, _) => fixture.api.verifications.length == 1
          ? initialVerification.future
          : Future.value(
              BillingVerification(
                purchaseStatus: 'verified',
                subscription: _active(),
              ),
            );
      final restoring = fixture.controller.restorePurchases();
      await tester.pump();
      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.subscription?.hasAccess, isFalse);

      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      fixture.gateway.emitPurchase(_purchase());
      await tester.pump();
      expect(fixture.api.verifications, hasLength(1));
      initialVerification.complete(
        const BillingVerification(
          purchaseStatus: 'pending',
          subscription: _inactive,
        ),
      );
      await restoring;
      await tester.pump();

      expect(fixture.api.verifications, hasLength(2));
      expect(
        fixture.api.verifications
            .map((request) => request.purchaseToken)
            .toSet(),
        <String>{'purchase-token-test'},
      );
      expect(fixture.controller.subscription?.hasAccess, isTrue);
      expect(fixture.controller.isBusy, isFalse);
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(2));
      fixture.dispose();
    },
  );

  testWidgets(
    'resuming during a blocked catalog load restarts processing retries after loading',
    (tester) async {
      final fixture = _Fixture();
      addTearDown(fixture.dispose);
      fixture.api.verification = _processing;
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      await fixture.controller.restorePurchases();
      expect(fixture.api.verifications, hasLength(1));

      final catalog = Completer<List<PlaySubscriptionPlan>>();
      fixture.gateway.onQueryPlans = () => catalog.future;
      final loading = fixture.controller.loadPlans();
      await tester.pump();
      expect(fixture.controller.isLoadingCatalog, isTrue);
      expect(fixture.controller.isBusy, isTrue);

      fixture.controller.onAppPaused();
      await tester.pump(const Duration(seconds: 10));
      expect(fixture.api.verifications, hasLength(1));
      await fixture.controller.onAppResumed();
      await tester.pump(const Duration(seconds: 2));
      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.isLoadingCatalog, isTrue);

      catalog.complete(const <PlaySubscriptionPlan>[_monthly]);
      await loading;
      expect(fixture.controller.isLoadingCatalog, isFalse);
      await tester.pump(const Duration(seconds: 2));
      expect(fixture.api.verifications, hasLength(2));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      expect(fixture.controller.purchaseAllowed, isFalse);
      fixture.dispose();
    },
  );

  testWidgets(
    'a processing response arriving in background does not schedule retries',
    (tester) async {
      final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
      addTearDown(fixture.dispose);
      final verification = Completer<BillingVerification>();
      fixture.api.onVerify = (_, _) => verification.future;
      fixture.gateway.owned = <PlayPurchase>[_purchase()];
      final restoring = fixture.controller.restorePurchases();
      await tester.pump();
      expect(fixture.api.verifications, hasLength(1));

      fixture.controller.onAppPaused();
      verification.complete(_processing);
      await restoring;
      await tester.pump(const Duration(minutes: 2));
      expect(fixture.api.verifications, hasLength(1));
      expect(fixture.controller.subscription?.hasAccess, isFalse);
      fixture.dispose();
    },
  );

  for (final unsettledStatus in <String>['pending', 'processing']) {
    testWidgets(
      'a verified second token does not clear an earlier $unsettledStatus purchase',
      (tester) async {
        final fixture = _Fixture(processingRetryDelays: _shortRetryDelays);
        addTearDown(fixture.dispose);
        await fixture.controller.loadPlans();
        fixture.gateway.owned = <PlayPurchase>[
          _purchase(token: 'unsettled-token', state: 'pending'),
          _purchase(token: 'verified-token'),
        ];
        fixture.api.onVerify = (_, token) async => BillingVerification(
          purchaseStatus: token == 'unsettled-token'
              ? unsettledStatus
              : 'verified',
          subscription: _inactive,
        );
        await fixture.controller.restorePurchases();

        expect(fixture.api.verifications, hasLength(2));
        expect(fixture.controller.subscription?.hasAccess, isFalse);
        expect(fixture.controller.purchaseAllowed, isFalse);
        await fixture.controller.purchase(_monthly);
        expect(fixture.gateway.launchRequests, isEmpty);
        fixture.dispose();
      },
    );
  }
}

class _Fixture {
  _Fixture({List<Duration>? processingRetryDelays}) {
    controller = processingRetryDelays == null
        ? BillingController(
            gateway: gateway,
            api: api,
            currentAccount: () => account,
          )
        : BillingController(
            gateway: gateway,
            api: api,
            currentAccount: () => account,
            processingRetryDelays: processingRetryDelays,
          );
  }

  BillingAccount? account = BillingAccount(
    userId: 'user-a',
    accessToken: 'session-a',
    scope: Object(),
  );
  final gateway = _FakeGateway();
  final api = _FakeApi();
  late final BillingController controller;
  bool _disposed = false;

  void switchToB() {
    account = BillingAccount(
      userId: 'user-b',
      accessToken: 'session-b',
      scope: Object(),
    );
    controller.syncAccount();
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    controller.dispose();
  }
}

class _VerificationRequest {
  const _VerificationRequest(this.accessToken, this.purchaseToken);
  final String accessToken;
  final String purchaseToken;
}

class _FakeApi implements BillingApiRepository {
  final subscriptions = <String, BillingSubscription>{
    'session-a': _inactive,
    'session-b': _inactive,
  };
  final contexts = <String, BillingPurchaseContext>{
    'session-a': const BillingPurchaseContext(
      obfuscatedAccountId: _ownerA,
      purchaseAllowed: true,
    ),
    'session-b': const BillingPurchaseContext(
      obfuscatedAccountId: _ownerB,
      purchaseAllowed: true,
    ),
  };
  final contextReads = <String>[];
  final verifications = <_VerificationRequest>[];
  BillingVerification verification = BillingVerification(
    purchaseStatus: 'verified',
    subscription: _active(),
  );
  Future<BillingPurchaseContext> Function(String)? onContext;
  Future<BillingVerification> Function(String, String)? onVerify;

  @override
  Future<BillingSubscription> getSubscription(String token) async =>
      subscriptions[token]!;

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async {
    contextReads.add(token);
    return onContext == null ? contexts[token]! : await onContext!(token);
  }

  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async {
    verifications.add(_VerificationRequest(token, purchaseToken));
    return onVerify == null
        ? verification
        : await onVerify!(token, purchaseToken);
  }
}

class _FakeGateway implements PlayBillingGateway, BillingSessionGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast(sync: true);
  final launchRequests = <String>[];
  final openedOwners = <String>[];
  List<PlayPurchase> owned = <PlayPurchase>[];
  Future<List<PlaySubscriptionPlan>> Function()? onQueryPlans;
  Future<void> Function(PlaySubscriptionPlan, String)? onLaunch;
  int invalidations = 0;
  int ownedQueries = 0;

  void emit(PlayBillingEvent event) => _events.add(event);

  void emitPurchase(PlayPurchase purchase) => emit(
    PlayBillingEvent(type: 'purchases', purchases: <PlayPurchase>[purchase]),
  );

  @override
  Stream<PlayBillingEvent> get events => _events.stream;

  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => onQueryPlans == null
      ? const <PlaySubscriptionPlan>[_monthly]
      : await onQueryPlans!();

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async {
    final generation = invalidations;
    launchRequests.add(obfuscatedAccountId);
    if (onLaunch != null) await onLaunch!(plan, obfuscatedAccountId);
    if (generation != invalidations) {
      throw const PlayBillingException('cancelled');
    }
    openedOwners.add(obfuscatedAccountId);
  }

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async {
    ownedQueries++;
    return List<PlayPurchase>.of(owned);
  }

  @override
  Future<void> invalidateAccount() async {
    invalidations++;
  }

  @override
  Future<void> openSubscriptionManagement() async {}

  @override
  void dispose() {
    unawaited(_events.close());
  }
}
