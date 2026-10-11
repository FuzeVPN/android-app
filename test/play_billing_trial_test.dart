// SPDX-License-Identifier: MPL-2.0
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/play_billing_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('normal base plan never invents a free trial', () {
    final plan = PlaySubscriptionPlan.fromJson(_plan(trial: false));
    expect(plan.offerId, isNull);
    expect(plan.freeTrialDays, isNull);
    expect(plan.pricingPhases.single.recurrenceMode, 1);
    expect(plan.formattedPrice, '4,99\u00a0€');
  });

  for (final base in ['monthly', 'yearly']) {
    for (final period in ['P2W', 'P14D']) {
      test('$base $period trial retains exact free and recurring prices', () {
        final plan = PlaySubscriptionPlan.fromJson(
          _plan(base: base, freePeriod: period),
        );
        expect(plan.offerId, 'freetest');
        expect(plan.freeTrialDays, 14);
        expect(plan.pricingPhases, hasLength(2));
        expect(plan.pricingPhases.first.priceAmountMicros, 0);
        expect(plan.formattedPrice, '4,99\u00a0€');
        expect(plan.priceAmountMicros, 4990000);
        expect(plan.billingPeriod, base == 'monthly' ? 'P1M' : 'P1Y');
        expect(plan.pricingPhases.last.billingCycleCount, 0);
        expect(() => plan.pricingPhases.clear(), throwsUnsupportedError);
      });
    }
  }

  test('non-recurring free phase has one supported two-week duration', () {
    final json = _plan();
    final phases = json['pricingPhases'] as List<Map<String, Object?>>;
    phases.first['recurrenceMode'] = 3;
    phases.first['billingCycleCount'] = 0;
    expect(PlaySubscriptionPlan.fromJson(json).freeTrialDays, 14);
  });

  test(
    'malformed schedules and inconsistent recurring projection are rejected',
    () {
      for (final change in <Map<String, Object?>>[
        {'offerId': 'other-offer'},
        {'offerId': ''},
        {'pricingPhases': null},
        {'pricingPhases': []},
        {'priceAmountMicros': 0},
        {'formattedPrice': '0,00 €'},
        {'currencyCode': 'USD'},
        {'billingPeriod': 'P1Y'},
      ]) {
        expect(
          () => PlaySubscriptionPlan.fromJson({..._plan(), ...change}),
          throwsFormatException,
        );
      }
      for (final change in <Map<String, Object?>>[
        {'priceAmountMicros': -1},
        {'priceAmountMicros': 1},
        {'billingPeriod': 'P1W'},
        {'billingCycleCount': 2},
        {'billingCycleCount': 1.0},
        {'recurrenceMode': 1},
        {'recurrenceMode': 4},
        {'currencyCode': 'USD'},
        {'formattedPrice': ''},
      ]) {
        final json = _plan();
        final phases = json['pricingPhases'] as List<Map<String, Object?>>;
        phases[0] = {...phases.first, ...change};
        expect(
          () => PlaySubscriptionPlan.fromJson(json),
          throwsFormatException,
        );
      }
      final reversed = _plan();
      reversed['pricingPhases'] = (reversed['pricingPhases'] as List).reversed
          .toList();
      expect(
        () => PlaySubscriptionPlan.fromJson(reversed),
        throwsFormatException,
      );
    },
  );

  test(
    'same token cannot conceal an offer, phase, or recurring-price change',
    () {
      final original = PlaySubscriptionPlan.fromJson(_plan());
      expect(
        original.sameOffer(PlaySubscriptionPlan.fromJson(_plan())),
        isTrue,
      );
      expect(
        original.sameOffer(PlaySubscriptionPlan.fromJson(_plan(trial: false))),
        isFalse,
      );
      expect(
        original.sameOffer(
          PlaySubscriptionPlan.fromJson(_plan(freePeriod: 'P14D')),
        ),
        isFalse,
      );
      final priceChanged = _plan();
      priceChanged['formattedPrice'] = '6,99\u00a0€';
      priceChanged['priceAmountMicros'] = 6990000;
      final phases =
          priceChanged['pricingPhases'] as List<Map<String, Object?>>;
      phases.last['formattedPrice'] = '6,99\u00a0€';
      phases.last['priceAmountMicros'] = 6990000;
      expect(
        original.sameOffer(PlaySubscriptionPlan.fromJson(priceChanged)),
        isFalse,
      );
      final tokenChanged = _plan()..['offerToken'] = 'new-token';
      expect(
        original.sameOffer(PlaySubscriptionPlan.fromJson(tokenChanged)),
        isFalse,
      );
    },
  );

  const channel = MethodChannel('com.fuzevpn/billing');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test(
    'native checkout transmits every displayed pricing phase and exact offer',
    () async {
      MethodCall? received;
      messenger.setMockMethodCallHandler(channel, (call) async {
        received = call;
        return null;
      });
      final gateway = NativePlayBillingGateway();
      final plan = PlaySubscriptionPlan.fromJson(_plan());
      await gateway.launchSubscription(
        plan: plan,
        obfuscatedAccountId: 'opaque-account',
      );
      expect(received!.method, 'launchSubscription');
      expect(received!.arguments, {
        'basePlanId': 'monthly',
        'offerId': 'freetest',
        'offerToken': 'fixture-token',
        'formattedPrice': '4,99\u00a0€',
        'currencyCode': 'EUR',
        'billingPeriod': 'P1M',
        'priceAmountMicros': 4990000,
        'pricingPhases': plan.pricingPhases.map((p) => p.toJson()).toList(),
        'obfuscatedAccountId': 'opaque-account',
      });
    },
  );

  test(
    'native catalogue preserves trials and rejects duplicate or invalid offers',
    () async {
      var response = <Object?>[_plan()];
      messenger.setMockMethodCallHandler(channel, (call) async => response);
      final gateway = NativePlayBillingGateway();
      expect((await gateway.queryPlans()).single.freeTrialDays, 14);
      response = [_plan(), _plan(trial: false)];
      await expectLater(
        gateway.queryPlans(),
        throwsA(isA<PlayBillingException>()),
      );
      response = [_plan()..['pricingPhases'] = []];
      await expectLater(
        gateway.queryPlans(),
        throwsA(isA<PlayBillingException>()),
      );
      response = [_plan(trial: false)];
      expect((await gateway.queryPlans()).single.freeTrialDays, isNull);
      response = [];
      expect(await gateway.queryPlans(), isEmpty);
    },
  );
}

Map<String, Object?> _plan({
  String base = 'monthly',
  bool trial = true,
  String freePeriod = 'P2W',
}) => {
  'productId': 'premium',
  'basePlanId': base,
  'offerToken': 'fixture-token',
  'offerId': trial ? 'freetest' : null,
  'formattedPrice': '4,99\u00a0€',
  'currencyCode': 'EUR',
  'billingPeriod': base == 'monthly' ? 'P1M' : 'P1Y',
  'priceAmountMicros': 4990000,
  'pricingPhases': <Map<String, Object?>>[
    if (trial)
      {
        'formattedPrice': '0,00\u00a0€',
        'currencyCode': 'EUR',
        'priceAmountMicros': 0,
        'billingPeriod': freePeriod,
        'billingCycleCount': 1,
        'recurrenceMode': 2,
      },
    {
      'formattedPrice': '4,99\u00a0€',
      'currencyCode': 'EUR',
      'priceAmountMicros': 4990000,
      'billingPeriod': base == 'monthly' ? 'P1M' : 'P1Y',
      'billingCycleCount': 0,
      'recurrenceMode': 1,
    },
  ],
};
