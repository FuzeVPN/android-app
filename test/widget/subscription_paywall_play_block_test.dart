// H-R13-01-01 and A07-billing-02 on the Premium page: a signed-in account
// whose Play account holds a blocking receipt gets one explanation and the
// Play management action, never an enabled purchase that Play refuses.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/features/billing/subscription_card.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

const _owner = 'opaque-owner';
const _plan = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'fixture-monthly',
  formattedPrice: '4,79 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4790000,
);

PlayPurchase _receipt({String? owner, bool suspended = false}) => PlayPurchase(
  productId: 'premium',
  purchaseToken: 'blocking-token',
  state: 'purchased',
  obfuscatedAccountId: owner,
  acknowledged: true,
  suspended: suspended,
);

void main() {
  for (final (label, server, receipt)
      in <(String, BillingSubscription, PlayPurchase)>[
        (
          'H-R13-01-01 receipt without owner',
          const BillingSubscription(status: 'inactive', hasAccess: false),
          _receipt(),
        ),
        (
          'A07-billing-02 suspended Play subscription',
          const BillingSubscription(
            status: 'past_due',
            hasAccess: false,
            provider: 'google_play',
          ),
          _receipt(owner: _owner, suspended: true),
        ),
      ]) {
    testWidgets('$label: Premium page explains once and offers management', (
      tester,
    ) async {
      final store = _Store()..owned = [receipt];
      final billing = BillingController(
        gateway: store,
        api: _Api(server),
        currentAccount: () => _account,
      );
      final app = _PaywallController(billing);
      addTearDown(app.dispose);
      await tester.pumpWidget(_page(app));
      await tester.pumpAndSettle();
      await billing.restorePurchases();
      // The guest flow relays the billing message (app_controller_guest).
      app.guestMessageKey = billing.messageKey;
      app.notify();
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(SubscriptionPaywallPage));
      final message = billing.messageKey!;
      expect(message, isNot('billing.restoreEmpty'));
      expect(message, isNot('billing.inactive'));
      expect(find.text(context.copy(message)), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
      await tester.pumpAndSettle();
      final proceed = tester.widget<FilledButton>(
        find.byKey(const ValueKey('subscription-continue')),
      );
      expect(proceed.onPressed, isNull);
      final manage = find.byKey(const ValueKey('subscription-paywall-manage'));
      await tester.ensureVisible(manage);
      await tester.tap(manage);
      await tester.pumpAndSettle();
      expect(store.managementRequests, 1);
      expect(store.launches, isEmpty);
      // Without the relayed guest message, the block reason stays visible.
      app.guestMessageKey = null;
      await billing.loadPlans();
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('subscription-play-block')),
          matching: find.text(context.copy(message)),
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('witness: without a receipt the signed-in purchase stays '
      'available', (tester) async {
    final store = _Store();
    final billing = BillingController(
      gateway: store,
      api: _Api(
        const BillingSubscription(status: 'inactive', hasAccess: false),
      ),
      currentAccount: () => _account,
    );
    final app = _PaywallController(billing);
    addTearDown(app.dispose);
    await tester.pumpWidget(_page(app));
    await tester.pumpAndSettle();
    await billing.restorePurchases();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
    await tester.pumpAndSettle();
    final proceed = tester.widget<FilledButton>(
      find.byKey(const ValueKey('subscription-continue')),
    );
    expect(proceed.onPressed, isNotNull);
    expect(
      find.byKey(const ValueKey('subscription-paywall-manage')),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('subscription-play-block')), findsNothing);
  });
}

final _account = BillingAccount(
  userId: 'registered-fixture',
  accessToken: 'session-fixture',
  scope: Object(),
);

Widget _page(VpnAppController controller) => MaterialApp(
  debugShowCheckedModeBanner: false,
  locale: const Locale('fr'),
  supportedLocales: AppLanguages.supportedLocales,
  localeListResolutionCallback: AppLanguages.resolve,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: SubscriptionPaywallPage(controller: controller),
);

class _PaywallController extends ChangeNotifier implements VpnAppController {
  _PaywallController(this.billing);

  @override
  final BillingController billing;
  @override
  UserProfile? profile = UserProfile(
    userId: 'registered-fixture',
    identityKind: 'registered',
    profileRedacted: false,
    canManageAccount: true,
    canClaimAccount: false,
    canUseVpn: false,
    email: 'registered@example.invalid',
    firstName: 'Fixture',
  );
  @override
  bool isGuestActionBusy = false;
  @override
  String? guestMessageKey;
  @override
  bool get isSignedIn => true;

  void notify() => notifyListeners();

  @override
  void dispose() {
    billing.dispose();
    super.dispose();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Api implements BillingApiRepository {
  _Api(this.server);
  BillingSubscription server;

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
  }) async =>
      BillingVerification(purchaseStatus: 'verified', subscription: server);
}

class _Store implements PlayBillingGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast();
  List<PlayPurchase> owned = const <PlayPurchase>[];
  final launches = <String>[];
  int managementRequests = 0;

  @override
  Stream<PlayBillingEvent> get events => _events.stream;

  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => const [_plan];

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async => launches.add(obfuscatedAccountId);

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async => List.of(owned);

  @override
  Future<void> openSubscriptionManagement() async => managementRequests++;

  @override
  void dispose() => unawaited(_events.close());
}
