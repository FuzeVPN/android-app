import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/features/billing/subscription_card.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

const _billingReview = bool.fromEnvironment('FUZEVPN_BILLING_REVIEW');

const _monthly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'monthly-offer',
  formattedPrice: 'CA\$7.39',
  currencyCode: 'CAD',
  billingPeriod: 'P1M',
  priceAmountMicros: 7390000,
);
const _yearly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'yearly',
  offerToken: 'yearly-offer',
  formattedPrice: '₹1,499.00',
  currencyCode: 'INR',
  billingPeriod: 'P1Y',
  priceAmountMicros: 1499000000,
);

void main() {
  setUpAll(() async {
    if (!_billingReview) return;
    TestWidgetsFlutterBinding.ensureInitialized();
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader('IBM Plex Mono')
          ..addFont(rootBundle.load('assets/fonts/IBMPlexMono-Regular.ttf'))
          ..addFont(rootBundle.load('assets/fonts/IBMPlexMono-SemiBold.ttf')))
        .load();
    await (FontLoader(
      'Noto Sans Arabic',
    )..addFont(rootBundle.load('assets/fonts/NotoSansArabic.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });

  if (_billingReview) {
    for (final review in <(String, Size)>[
      ('mobile', const Size(412, 915)),
      ('tablet', const Size(800, 1280)),
      ('desktop', const Size(1280, 800)),
    ]) {
      testWidgets(
        'billing review with fixture prices on ${review.$1}',
        (tester) async {
          tester.view.physicalSize = review.$2;
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final fixture = _BillingFixture();
          addTearDown(fixture.controller.dispose);
          await tester.pumpWidget(
            RepaintBoundary(
              key: const ValueKey('billing-review-screen'),
              child: _app(fixture.controller, review: true),
            ),
          );
          await _openPlans(tester);
          await tester.tap(
            find.byKey(const ValueKey('subscription-plan-yearly')),
          );
          await tester.pumpAndSettle();
          expect(fixture.gateway.launchedPlans, isEmpty);
          expect(find.text('REVUE UI · PRIX DE TEST'), findsOneWidget);
          expect(tester.takeException(), isNull);
          await expectLater(
            find.byKey(const ValueKey('billing-review-screen')),
            matchesGoldenFile(
              '../../build/reports/play-billing-integration-2026-10-03/ui/'
              'subscription_${review.$1}_test_prices.png',
            ),
          );
        },
        tags: <String>['billing-review'],
      );
    }
  }

  testWidgets('card build never queries the store or account API', (
    tester,
  ) async {
    final fixture = _BillingFixture();
    addTearDown(fixture.controller.dispose);
    await tester.pumpWidget(_app(fixture.controller));
    await tester.pumpAndSettle();
    expect(fixture.gateway.catalogRequests, 0);
    expect(fixture.api.subscriptionRequests, 0);
    expect(fixture.api.contextRequests, 0);
    expect(find.byKey(const ValueKey('subscription-open')), findsOneWidget);
  });

  testWidgets(
    'exact store prices require selection then a separate payment tap',
    (tester) async {
      final fixture = _BillingFixture();
      addTearDown(fixture.controller.dispose);
      await tester.pumpWidget(_app(fixture.controller));
      await _openPlans(tester);
      expect(find.text(_monthly.formattedPrice), findsOneWidget);
      expect(find.text(_yearly.formattedPrice), findsOneWidget);
      expect(_continueButton(tester).onPressed, isNull);
      expect(fixture.gateway.launchedPlans, isEmpty);

      await tester.tap(find.byKey(const ValueKey('subscription-plan-yearly')));
      await tester.pumpAndSettle();
      expect(_continueButton(tester).onPressed, isNotNull);
      expect(fixture.gateway.launchedPlans, isEmpty);
      final copy = AppLocalizations.of(
        tester.element(find.byKey(const ValueKey('subscription-selection'))),
      );
      expect(find.text(copy.billing_renewalYearly), findsOneWidget);
      expect(find.text(copy.billing_priceDisclosure), findsOneWidget);

      await tester.ensureVisible(
        find.byKey(const ValueKey('subscription-continue')),
      );
      await tester.tap(find.byKey(const ValueKey('subscription-continue')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      expect(fixture.gateway.launchedPlans, <PlaySubscriptionPlan>[_yearly]);
      expect(fixture.gateway.launchedOwners, <String>['opaque-owner']);
      expect(fixture.controller.subscription?.hasAccess, false);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'available Google prices stay visible when purchase API is gated',
    (tester) async {
      final fixture = _BillingFixture()..api.contextUnavailable = true;
      addTearDown(fixture.controller.dispose);
      await tester.pumpWidget(_app(fixture.controller));
      await _openPlans(tester);
      expect(find.text(_monthly.formattedPrice), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
      await tester.pumpAndSettle();
      expect(_continueButton(tester).onPressed, isNull);
      final copy = AppLocalizations.of(
        tester.element(find.byKey(const ValueKey('subscription-selection'))),
      );
      expect(find.text(copy.billing_comingSoon), findsWidgets);
      expect(fixture.gateway.launchedPlans, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('store failure has a retry without inventing prices', (
    tester,
  ) async {
    final fixture = _BillingFixture()..gateway.catalogUnavailable = true;
    addTearDown(fixture.controller.dispose);
    await tester.pumpWidget(_app(fixture.controller));
    await _openPlans(tester);
    expect(find.text(_monthly.formattedPrice), findsNothing);
    expect(find.byKey(const ValueKey('subscription-continue')), findsNothing);
    expect(
      find.byKey(const ValueKey('subscription-retry-plans')),
      findsOneWidget,
    );
    fixture.gateway.catalogUnavailable = false;
    await tester.tap(find.byKey(const ValueKey('subscription-retry-plans')));
    await tester.pumpAndSettle();
    expect(find.text(_monthly.formattedPrice), findsOneWidget);
    expect(fixture.gateway.catalogRequests, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'changing accounts closes the old selection before another action',
    (tester) async {
      final fixture = _BillingFixture();
      addTearDown(fixture.controller.dispose);
      await tester.pumpWidget(_app(fixture.controller));
      await _openPlans(tester);
      await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
      await tester.pumpAndSettle();
      fixture.account = BillingAccount(
        userId: 'second-user',
        accessToken: 'second-session',
        scope: Object(),
      );
      fixture.controller.syncAccount();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('subscription-selection')),
        findsNothing,
      );
      expect(fixture.gateway.launchedPlans, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('active web access hides purchase and Google management', (
    tester,
  ) async {
    final fixture = _BillingFixture()
      ..api.subscription = const BillingSubscription(
        status: 'active',
        hasAccess: true,
        provider: 'sumup',
      );
    addTearDown(fixture.controller.dispose);
    await tester.pumpWidget(_app(fixture.controller));
    await tester.tap(find.byKey(const ValueKey('subscription-refresh')));
    await tester.pumpAndSettle();
    final copy = AppLocalizations.of(
      tester.element(find.byType(SubscriptionCard)),
    );
    expect(find.text(copy.billing_webManaged), findsOneWidget);
    expect(find.byKey(const ValueKey('subscription-open')), findsNothing);
    expect(find.byKey(const ValueKey('subscription-manage')), findsNothing);
    expect(fixture.gateway.launchedPlans, isEmpty);
  });

  testWidgets('Google subscribers can open management and restore purchases', (
    tester,
  ) async {
    final fixture = _BillingFixture()
      ..api.subscription = const BillingSubscription(
        status: 'active',
        hasAccess: true,
        provider: 'google_play',
      );
    addTearDown(fixture.controller.dispose);
    await tester.pumpWidget(_app(fixture.controller));
    await tester.tap(find.byKey(const ValueKey('subscription-refresh')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('subscription-manage')));
    await tester.pumpAndSettle();
    expect(fixture.gateway.managementRequests, 1);
    await tester.tap(find.byKey(const ValueKey('subscription-restore')));
    await tester.pumpAndSettle();
    expect(fixture.gateway.restoreRequests, 1);
    final copy = AppLocalizations.of(
      tester.element(find.byType(SubscriptionCard)),
    );
    expect(find.text(copy.billing_restoreEmpty), findsOneWidget);
  });

  for (final language in AppLanguages.all) {
    testWidgets(
      'subscription is readable at 320dp and 200% in ${language.tag}',
      (tester) async {
        tester.view.physicalSize = const Size(320, 915);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final fixture = _BillingFixture();
        addTearDown(fixture.controller.dispose);
        await tester.pumpWidget(
          _app(fixture.controller, locale: language.locale),
        );
        await tester.ensureVisible(
          find.byKey(const ValueKey('subscription-open')),
        );
        await _openPlans(tester);
        expect(find.text(_monthly.formattedPrice), findsOneWidget);
        expect(
          tester
              .getSize(find.byKey(const ValueKey('subscription-price-monthly')))
              .width,
          greaterThan(180),
        );
        await tester.ensureVisible(
          find.byKey(const ValueKey('subscription-plan-yearly')),
        );
        await tester.tap(
          find.byKey(const ValueKey('subscription-plan-yearly')),
        );
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.byKey(const ValueKey('subscription-continue')),
        );
        expect(_continueButton(tester).onPressed, isNotNull);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('wide dark display uses a bounded dialog', (tester) async {
    tester.view.physicalSize = const Size(1024, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final fixture = _BillingFixture();
    addTearDown(fixture.controller.dispose);
    await tester.pumpWidget(_app(fixture.controller, dark: true));
    await _openPlans(tester);
    expect(find.byType(Dialog), findsOneWidget);
    expect(
      tester
          .getSize(find.byKey(const ValueKey('subscription-selection')))
          .width,
      lessThanOrEqualTo(560),
    );
    expect(tester.takeException(), isNull);
  });
}

Future<void> _openPlans(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('subscription-open')));
  await tester.pumpAndSettle();
}

FilledButton _continueButton(WidgetTester tester) => tester
    .widget<FilledButton>(find.byKey(const ValueKey('subscription-continue')));

Widget _app(
  BillingController controller, {
  Locale locale = const Locale('fr'),
  bool dark = false,
  bool review = false,
}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: dark ? FuzeVpnTheme.dark() : FuzeVpnTheme.light(),
  builder: review
      ? (context, child) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            child!,
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: FuzeVpnTheme.signal,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        'REVUE UI · PRIX DE TEST',
                        style: FuzeVpnTheme.mono(
                          fontSize: 11,
                          color: FuzeVpnTheme.ink,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      : null,
  home: Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SubscriptionCard(controller: controller),
    ),
  ),
);

class _BillingFixture {
  _BillingFixture() {
    controller = BillingController(
      gateway: gateway,
      api: api,
      currentAccount: () => account,
    );
  }
  final gateway = _Store();
  final api = _BillingApi();
  BillingAccount? account = BillingAccount(
    userId: 'first-user',
    accessToken: 'first-session',
    scope: Object(),
  );
  late final BillingController controller;
}

class _Store implements PlayBillingGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast();
  int catalogRequests = 0;
  int restoreRequests = 0;
  int managementRequests = 0;
  bool catalogUnavailable = false;
  final launchedPlans = <PlaySubscriptionPlan>[];
  final launchedOwners = <String>[];
  @override
  Stream<PlayBillingEvent> get events => _events.stream;
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async {
    catalogRequests++;
    if (catalogUnavailable) throw const PlayBillingException('unavailable');
    return const <PlaySubscriptionPlan>[_monthly, _yearly];
  }

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async {
    launchedPlans.add(plan);
    launchedOwners.add(obfuscatedAccountId);
  }

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async {
    restoreRequests++;
    return const <PlayPurchase>[];
  }

  @override
  Future<void> openSubscriptionManagement() async => managementRequests++;
  @override
  void dispose() => unawaited(_events.close());
}

class _BillingApi implements BillingApiRepository {
  bool contextUnavailable = false;
  int subscriptionRequests = 0;
  int contextRequests = 0;
  BillingSubscription subscription = const BillingSubscription(
    status: 'none',
    hasAccess: false,
  );
  @override
  Future<BillingSubscription> getSubscription(String token) async {
    subscriptionRequests++;
    return subscription;
  }

  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async {
    contextRequests++;
    if (contextUnavailable) throw const PlayBillingException('unavailable');
    return const BillingPurchaseContext(
      obfuscatedAccountId: 'opaque-owner',
      purchaseAllowed: true,
    );
  }

  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async => BillingVerification(
    purchaseStatus: 'verified',
    subscription: subscription,
  );
}
