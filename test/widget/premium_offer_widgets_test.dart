// SPDX-License-Identifier: MPL-2.0
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/features/billing/premium_offer_widgets.dart';
import 'package:fuzevpn_android/features/billing/subscription_card.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

const _preview = bool.fromEnvironment('FUZEVPN_TRIAL_PREVIEWS');
const _monthly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerId: 'freetest',
  offerToken: 'fixture-free-monthly',
  formattedPrice: '4,79 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4790000,
  pricingPhases: [
    PlayPricingPhase(
      formattedPrice: '0,00 €',
      priceAmountMicros: 0,
      currencyCode: 'EUR',
      billingPeriod: 'P2W',
      billingCycleCount: 1,
      recurrenceMode: 2,
    ),
    PlayPricingPhase(
      formattedPrice: '4,79 €',
      priceAmountMicros: 4790000,
      currencyCode: 'EUR',
      billingPeriod: 'P1M',
      billingCycleCount: 0,
      recurrenceMode: 1,
    ),
  ],
);
const _yearly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'yearly',
  offerId: 'freetest',
  offerToken: 'fixture-free-yearly',
  formattedPrice: '37,99 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1Y',
  priceAmountMicros: 37990000,
  pricingPhases: [
    PlayPricingPhase(
      formattedPrice: '0,00 €',
      priceAmountMicros: 0,
      currencyCode: 'EUR',
      billingPeriod: 'P14D',
      billingCycleCount: 1,
      recurrenceMode: 2,
    ),
    PlayPricingPhase(
      formattedPrice: '37,99 €',
      priceAmountMicros: 37990000,
      currencyCode: 'EUR',
      billingPeriod: 'P1Y',
      billingCycleCount: 0,
      recurrenceMode: 1,
    ),
  ],
);
const _standardYearly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'yearly',
  offerToken: 'fixture-standard-yearly',
  formattedPrice: '37,99 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1Y',
  priceAmountMicros: 37990000,
);

void main() {
  setUpAll(() async {
    if (!_preview) return;
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

  test('first charge preview follows calendar days across month and year', () {
    expect(
      previewTrialChargeDate(DateTime(2026, 10, 20, 23), 14),
      DateTime(2026, 11, 3),
    );
    expect(
      previewTrialChargeDate(DateTime(2026, 12, 25), 14),
      DateTime(2027, 1, 8),
    );
    expect(
      previewTrialChargeDate(DateTime(2028, 2, 20), 14),
      DateTime(2028, 3, 5),
    );
  });

  testWidgets(
    'date preview describes today and Google confirmation before action',
    (tester) async {
      await tester.pumpWidget(
        _localized(
          const Scaffold(body: PremiumCheckoutSummary(plan: _monthly)),
        ),
      );
      await tester.pumpAndSettle();
      final copy = AppLocalizations.of(
        tester.element(find.byType(PremiumCheckoutSummary)),
      );
      expect(
        find.text(copy.billing_trialThenMonthly(_monthly.formattedPrice)),
        findsOneWidget,
      );
      expect(find.text(copy.billing_trialConfirmation), findsOneWidget);
      expect(find.textContaining('premier débit prévu'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('trial date refreshes at local midnight', (tester) async {
    var now = DateTime(2026, 10, 11, 23, 59, 59);
    await tester.pumpWidget(
      _localized(
        Scaffold(
          body: PremiumCheckoutSummary(plan: _monthly, clock: () => now),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('25/10/2026'), findsOneWidget);
    now = DateTime(2026, 10, 12);
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('26/10/2026'), findsOneWidget);
    expect(find.textContaining('25/10/2026'), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    expect(tester.takeException(), isNull);
  });

  testWidgets('trial date refreshes after background and disposes clock work', (
    tester,
  ) async {
    var now = DateTime(2026, 10, 11, 12);
    var reads = 0;
    await tester.pumpWidget(
      _localized(
        Scaffold(
          body: PremiumCheckoutSummary(
            plan: _monthly,
            clock: () {
              reads++;
              return now;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    now = DateTime(2026, 10, 15, 12);
    await tester.pump(const Duration(hours: 24));
    expect(find.textContaining('25/10/2026'), findsOneWidget);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(find.textContaining('29/10/2026'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    final readsAfterDispose = reads;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(days: 2));
    expect(reads, readsAfterDispose);
    expect(tester.takeException(), isNull);
  });

  testWidgets('page hero follows the selected paid plan in a mixed catalog', (
    tester,
  ) async {
    _configure(tester, const Size(411, 915));
    final controller = _UiController(plans: const [_monthly, _standardYearly]);
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _localized(SubscriptionPaywallPage(controller: controller)),
    );
    await tester.pumpAndSettle();
    final copy = AppLocalizations.of(
      tester.element(find.byType(PremiumIntroduction)),
    );
    expect(find.text(copy.billing_trialTitle), findsOneWidget);
    await tester.ensureVisible(
      find.byKey(const ValueKey('subscription-plan-yearly')),
    );
    await tester.tap(find.byKey(const ValueKey('subscription-plan-yearly')));
    await tester.pumpAndSettle();
    expect(find.text(copy.billing_trialTitle), findsNothing);
    expect(find.text(copy.billing_premiumTitle), findsOneWidget);
    expect(find.text(copy.billing_trialStart), findsNothing);
    expect(_continue(tester).onPressed, isNotNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'page requires a new choice after price_changed and identical reload',
    (tester) async {
      _configure(tester, const Size(411, 915));
      final controller = _UiController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _localized(SubscriptionPaywallPage(controller: controller)),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const ValueKey('subscription-plan-monthly')),
      );
      await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
      await tester.pumpAndSettle();
      expect(_continue(tester).onPressed, isNotNull);
      controller.invalidateOffer();
      await tester.pumpAndSettle();
      expect(controller.billing.messageKey, 'billing.offerChanged');
      expect(find.byKey(const ValueKey('subscription-continue')), findsNothing);
      await tester.ensureVisible(
        find.byKey(const ValueKey('subscription-retry-plans')),
      );
      await tester.tap(find.byKey(const ValueKey('subscription-retry-plans')));
      await tester.pumpAndSettle();
      expect(controller.billing.plans.first.sameOffer(_monthly), isTrue);
      expect(_continue(tester).onPressed, isNull);
      expect(
        find.byKey(const ValueKey('subscription-trial-summary')),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    },
  );

  const sizes = [
    Size(320, 640),
    Size(411, 915),
    Size(800, 1280),
    Size(1920, 1080),
  ];
  for (final size in sizes) {
    for (final dark in [false, true]) {
      for (final scale in [1.0, 2.0]) {
        testWidgets(
          'trial paywall ${size.width}dp ${dark ? "dark RTL" : "light"} scale $scale',
          (tester) async {
            _configure(tester, size, scale: scale);
            final controller = _UiController();
            addTearDown(controller.dispose);
            await tester.pumpWidget(
              _localized(
                SubscriptionPaywallPage(controller: controller),
                locale: dark ? const Locale('ar') : const Locale('fr'),
                dark: dark,
              ),
            );
            await tester.pumpAndSettle();
            expect(_continue(tester).onPressed, isNull);
            await tester.ensureVisible(
              find.byKey(const ValueKey('subscription-plan-yearly')),
            );
            await tester.tap(
              find.byKey(const ValueKey('subscription-plan-yearly')),
            );
            await tester.pumpAndSettle();
            await tester.ensureVisible(
              find.byKey(const ValueKey('subscription-first-charge')),
            );
            expect(
              find.byKey(const ValueKey('subscription-trial-summary')),
              findsOneWidget,
            );
            await tester.ensureVisible(
              find.byKey(const ValueKey('onboarding-terms')),
            );
            await tester.ensureVisible(
              find.byKey(const ValueKey('onboarding-privacy')),
            );
            for (final link in ['onboarding-terms', 'onboarding-privacy']) {
              final target = tester.getSize(find.byKey(ValueKey(link)));
              expect(target.width, greaterThanOrEqualTo(48));
              expect(target.height, greaterThanOrEqualTo(48));
            }
            await tester.ensureVisible(
              find.byKey(const ValueKey('subscription-continue')),
            );
            expect(_continue(tester).onPressed, isNotNull);
            expect(controller.purchaseRequests, isEmpty);
            await tester.ensureVisible(
              find.byKey(const ValueKey('subscription-selection-restore')),
            );
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }

  for (final language in AppLanguages.all) {
    testWidgets('eligible trial translated at 320dp 200% ${language.tag}', (
      tester,
    ) async {
      _configure(tester, const Size(320, 915), scale: 2);
      final controller = _UiController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _localized(
          SubscriptionPaywallPage(controller: controller),
          locale: language.locale,
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const ValueKey('subscription-plan-monthly')),
      );
      await tester.tap(find.byKey(const ValueKey('subscription-plan-monthly')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const ValueKey('subscription-first-charge')),
      );
      await tester.ensureVisible(
        find.byKey(const ValueKey('subscription-continue')),
      );
      expect(_continue(tester).onPressed, isNotNull);
      expect(tester.takeException(), isNull);
    });
  }

  if (_preview) {
    const previews = <(String, Size, bool, double, bool)>[
      ('fr-mobile-initial', Size(411, 915), false, 1, false),
      ('fr-mobile-trial', Size(411, 915), false, 1, true),
      ('fr-tablet-trial', Size(800, 1280), false, 1, true),
      ('fr-large-trial', Size(1920, 1080), false, 1, true),
      ('fr-mobile-dark-trial', Size(411, 915), true, 1, true),
      ('ar-mobile-dark-trial', Size(411, 915), true, 1, true),
      ('fr-small-200-trial', Size(320, 640), false, 2, true),
    ];
    for (final (name, size, dark, scale, select) in previews) {
      testWidgets('export $name with actual fonts and fixture prices', (
        tester,
      ) async {
        _configure(tester, size, scale: scale);
        final controller = _UiController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          _localized(
            Stack(
              children: [
                SubscriptionPaywallPage(controller: controller),
                Positioned(
                  bottom: 4,
                  right: 8,
                  child: Material(
                    color: FuzeVpnTheme.ink,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        'REVUE UI · PRIX DE TEST',
                        textScaler: TextScaler.noScaling,
                        style: FuzeVpnTheme.mono(
                          fontSize: 10,
                          color: FuzeVpnTheme.paper,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            locale: name.startsWith('ar')
                ? const Locale('ar')
                : const Locale('fr'),
            dark: dark,
          ),
        );
        await tester.pumpAndSettle();
        if (select) {
          await tester.ensureVisible(
            find.byKey(const ValueKey('subscription-plan-monthly')),
          );
          await tester.tap(
            find.byKey(const ValueKey('subscription-plan-monthly')),
          );
          await tester.pumpAndSettle();
          if (size.width < 800) {
            await tester.ensureVisible(
              find.byKey(const ValueKey('subscription-continue')),
            );
            await tester.pumpAndSettle();
          }
        }
        await _decodeImages(tester);
        if (size.width == 411 && scale == 1 && !name.startsWith('ar')) {
          expect(
            tester
                .getTopLeft(find.byKey(const ValueKey('onboarding-terms')))
                .dy,
            tester
                .getTopLeft(find.byKey(const ValueKey('onboarding-privacy')))
                .dy,
            reason:
                'Normal-sized legal links share a compact row with actual fonts.',
          );
        }
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile(
            '../../../FuzeVPN/build/reports/freetest-2026-10-11/ui/$name.png',
          ),
        );
      }, tags: 'trial-preview');
    }
  }
}

FilledButton _continue(WidgetTester tester) => tester.widget<FilledButton>(
  find.byKey(const ValueKey('subscription-continue')),
);

void _configure(WidgetTester tester, Size size, {double scale = 1}) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPadding);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  addTearDown(() async => tester.pumpWidget(const SizedBox.shrink()));
}

Widget _localized(
  Widget home, {
  Locale locale = const Locale('fr'),
  bool dark = false,
}) => MaterialApp(
  debugShowCheckedModeBanner: false,
  locale: locale,
  supportedLocales: AppLanguages.supportedLocales,
  localeListResolutionCallback: AppLanguages.resolve,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: dark ? FuzeVpnTheme.dark() : FuzeVpnTheme.light(),
  home: home,
);

Future<void> _decodeImages(WidgetTester tester) async {
  await tester.runAsync(() async {
    final pending = <Future<void>>[];
    for (final image in tester.widgetList<Image>(find.byType(Image))) {
      final completer = Completer<void>();
      final stream = image.image.resolve(const ImageConfiguration());
      late ImageStreamListener listener;
      listener = ImageStreamListener((_, _) {
        stream.removeListener(listener);
        if (!completer.isCompleted) completer.complete();
      });
      stream.addListener(listener);
      pending.add(completer.future);
    }
    await Future.wait(pending);
  });
  await tester.pumpAndSettle();
}

class _UiController extends ChangeNotifier implements VpnAppController {
  _UiController({
    List<PlaySubscriptionPlan> plans = const [_monthly, _yearly],
  }) {
    billing = _UiBilling(plans);
  }
  void invalidateOffer() => (billing as _UiBilling).invalidateOffer();
  @override
  late final BillingController billing;
  @override
  bool get isSignedIn => false;
  @override
  UserProfile? get profile => null;
  @override
  bool get isGuestActionBusy => false;
  @override
  String? get guestMessageKey => null;
  final purchaseRequests = <PlaySubscriptionPlan>[];
  @override
  Future<bool> beginGuestPurchase(PlaySubscriptionPlan plan) async {
    purchaseRequests.add(plan);
    return false;
  }

  @override
  void dispose() {
    billing.dispose();
    super.dispose();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Catalog implements PlayBillingGateway {
  _Catalog(this.plans);
  final List<PlaySubscriptionPlan> plans;
  @override
  Stream<PlayBillingEvent> get events => const Stream.empty();
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => plans;
  @override
  void dispose() {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UiBilling extends BillingController {
  _UiBilling(List<PlaySubscriptionPlan> plans)
    : super(
        gateway: _Catalog(plans),
        api: const UnavailableBillingApi(),
        currentAccount: () => null,
      );

  void invalidateOffer() {
    plans = const [];
    catalogLoaded = false;
    messageKey = 'billing.offerChanged';
    notifyListeners();
  }
}
