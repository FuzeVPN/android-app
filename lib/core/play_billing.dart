/// Google supplies display prices; the server alone supplies entitlement.
class PlayPricingPhase {
  const PlayPricingPhase({
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.currencyCode,
    required this.billingPeriod,
    required this.billingCycleCount,
    required this.recurrenceMode,
  });

  final String formattedPrice, currencyCode, billingPeriod;
  final int priceAmountMicros, billingCycleCount, recurrenceMode;

  factory PlayPricingPhase.fromJson(Map<dynamic, dynamic> json) {
    final micros = json['priceAmountMicros'];
    final cycles = json['billingCycleCount'];
    final recurrence = json['recurrenceMode'];
    final currency = _text(json, 'currencyCode');
    final period = _text(json, 'billingPeriod');
    if (micros is! int ||
        micros < 0 ||
        cycles is! int ||
        cycles < 0 ||
        !const [1, 2, 3].contains(recurrence) ||
        (recurrence == 2 ? cycles <= 0 : cycles != 0) ||
        !RegExp(r'^[A-Z]{3}$').hasMatch(currency) ||
        !RegExp(r'^P[1-9][0-9]*[DWMY]$').hasMatch(period)) {
      throw const FormatException('invalid_play_phase');
    }
    return PlayPricingPhase(
      formattedPrice: _text(json, 'formattedPrice'),
      priceAmountMicros: micros,
      currencyCode: currency,
      billingPeriod: period,
      billingCycleCount: cycles,
      recurrenceMode: recurrence as int,
    );
  }

  Map<String, Object> toJson() => {
    'formattedPrice': formattedPrice,
    'priceAmountMicros': priceAmountMicros,
    'currencyCode': currencyCode,
    'billingPeriod': billingPeriod,
    'billingCycleCount': billingCycleCount,
    'recurrenceMode': recurrenceMode,
  };

  bool samePhase(PlayPricingPhase other) =>
      formattedPrice == other.formattedPrice &&
      priceAmountMicros == other.priceAmountMicros &&
      currencyCode == other.currencyCode &&
      billingPeriod == other.billingPeriod &&
      billingCycleCount == other.billingCycleCount &&
      recurrenceMode == other.recurrenceMode;
}

class PlaySubscriptionPlan {
  const PlaySubscriptionPlan({
    required this.productId,
    required this.basePlanId,
    required this.offerToken,
    required this.formattedPrice,
    required this.currencyCode,
    required this.billingPeriod,
    required this.priceAmountMicros,
    this.offerId,
    List<PlayPricingPhase>? pricingPhases,
    // Keep the public named argument while exposing an immutable projection.
    // ignore: prefer_initializing_formals
  }) : _pricingPhases = pricingPhases;
  final String productId,
      basePlanId,
      offerToken,
      formattedPrice,
      currencyCode,
      billingPeriod;
  final int priceAmountMicros;
  final String? offerId;
  final List<PlayPricingPhase>? _pricingPhases;

  /// The complete Google schedule. The legacy constructor is a normal base plan.
  List<PlayPricingPhase> get pricingPhases => List.unmodifiable(
    _pricingPhases ??
        [
          PlayPricingPhase(
            formattedPrice: formattedPrice,
            priceAmountMicros: priceAmountMicros,
            currencyCode: currencyCode,
            billingPeriod: billingPeriod,
            billingCycleCount: 0,
            recurrenceMode: 1,
          ),
        ],
  );

  /// Only the supported, unambiguous two-week offer can advertise a free trial.
  int? get freeTrialDays {
    final phases = pricingPhases;
    if (productId != 'premium' ||
        !const ['monthly', 'yearly'].contains(basePlanId) ||
        billingPeriod != (basePlanId == 'monthly' ? 'P1M' : 'P1Y') ||
        !_supportedFreeTrial(offerId, phases)) {
      return null;
    }
    final paid = phases.last;
    return paid.billingPeriod == billingPeriod &&
            paid.currencyCode == currencyCode &&
            paid.priceAmountMicros == priceAmountMicros &&
            paid.formattedPrice == formattedPrice
        ? 14
        : null;
  }

  factory PlaySubscriptionPlan.fromJson(Map<dynamic, dynamic> json) {
    final product = _text(json, 'productId');
    final plan = _text(json, 'basePlanId');
    final period = _text(json, 'billingPeriod');
    final micros = json['priceAmountMicros'];
    final offerId = json['offerId'];
    final currency = _text(json, 'currencyCode');
    final price = _text(json, 'formattedPrice');
    if (product != 'premium' ||
        !const ['monthly', 'yearly'].contains(plan) ||
        period != (plan == 'monthly' ? 'P1M' : 'P1Y') ||
        micros is! int ||
        micros <= 0 ||
        !RegExp(r'^[A-Z]{3}$').hasMatch(currency) ||
        (offerId != null && offerId != 'freetest')) {
      throw const FormatException('invalid_play_plan');
    }
    final rawPhases = json['pricingPhases'];
    final List<PlayPricingPhase> phases;
    if (rawPhases == null && offerId == null) {
      // Compatibility with existing normal-plan projections, never a trial.
      phases = [
        PlayPricingPhase(
          formattedPrice: price,
          priceAmountMicros: micros,
          currencyCode: currency,
          billingPeriod: period,
          billingCycleCount: 0,
          recurrenceMode: 1,
        ),
      ];
    } else if (rawPhases is List &&
        rawPhases.isNotEmpty &&
        rawPhases.length <= 2) {
      phases = rawPhases
          .map((value) {
            if (value is! Map) {
              throw const FormatException('invalid_play_phase');
            }
            return PlayPricingPhase.fromJson(value);
          })
          .toList(growable: false);
    } else {
      throw const FormatException('invalid_play_plan');
    }
    final recurring = phases.last;
    if (recurring.recurrenceMode != 1 ||
        recurring.billingCycleCount != 0 ||
        recurring.priceAmountMicros != micros ||
        recurring.formattedPrice != price ||
        recurring.currencyCode != currency ||
        recurring.billingPeriod != period ||
        (offerId == null
            ? phases.length != 1
            : !_supportedFreeTrial(offerId as String, phases))) {
      throw const FormatException('invalid_play_plan');
    }
    return PlaySubscriptionPlan(
      productId: product,
      basePlanId: plan,
      offerToken: _text(json, 'offerToken'),
      formattedPrice: price,
      currencyCode: currency,
      billingPeriod: period,
      priceAmountMicros: micros,
      offerId: offerId as String?,
      pricingPhases: List.unmodifiable(phases),
    );
  }
  bool sameOffer(PlaySubscriptionPlan other) =>
      productId == other.productId &&
      basePlanId == other.basePlanId &&
      offerId == other.offerId &&
      offerToken == other.offerToken &&
      formattedPrice == other.formattedPrice &&
      currencyCode == other.currencyCode &&
      billingPeriod == other.billingPeriod &&
      priceAmountMicros == other.priceAmountMicros &&
      pricingPhases.length == other.pricingPhases.length &&
      List.generate(
        pricingPhases.length,
        (index) => pricingPhases[index].samePhase(other.pricingPhases[index]),
      ).every((same) => same);
}

bool _supportedFreeTrial(String? offerId, List<PlayPricingPhase> phases) {
  if (offerId != 'freetest' || phases.length != 2) return false;
  final trial = phases.first;
  final paid = phases.last;
  return trial.priceAmountMicros == 0 &&
      const ['P2W', 'P14D'].contains(trial.billingPeriod) &&
      ((trial.recurrenceMode == 2 && trial.billingCycleCount == 1) ||
          (trial.recurrenceMode == 3 && trial.billingCycleCount == 0)) &&
      paid.priceAmountMicros > 0 &&
      paid.recurrenceMode == 1 &&
      paid.billingCycleCount == 0 &&
      trial.currencyCode == paid.currencyCode &&
      trial.formattedPrice.trim().isNotEmpty &&
      paid.formattedPrice.trim().isNotEmpty;
}

class PlayPurchase {
  const PlayPurchase({
    required this.productId,
    required this.purchaseToken,
    required this.state,
    required this.obfuscatedAccountId,
    required this.acknowledged,
  });
  final String productId, purchaseToken, state;
  final String? obfuscatedAccountId;
  final bool acknowledged;
  factory PlayPurchase.fromJson(Map<dynamic, dynamic> json) {
    if (json['productId'] != 'premium' ||
        !const ['purchased', 'pending'].contains(json['state']) ||
        json['acknowledged'] is! bool) {
      throw const FormatException('invalid_play_purchase');
    }
    final owner = json['obfuscatedAccountId'];
    if (owner != null && (owner is! String || !validBillingAccountId(owner))) {
      throw const FormatException('invalid_purchase_owner');
    }
    return PlayPurchase(
      productId: 'premium',
      purchaseToken: _text(json, 'purchaseToken'),
      state: json['state'] as String,
      obfuscatedAccountId: owner as String?,
      acknowledged: json['acknowledged'] as bool,
    );
  }
}

class PlayBillingEvent {
  const PlayBillingEvent({
    required this.type,
    this.purchases = const [],
    this.code,
    this.obfuscatedAccountId,
  });
  final String type;
  final List<PlayPurchase> purchases;
  final String? code, obfuscatedAccountId;
}

class PlayBillingException implements Exception {
  const PlayBillingException(this.code);
  final String code;
  @override
  String toString() => 'PlayBillingException';
}

bool validBillingAccountId(String value) =>
    RegExp(r'^[A-Za-z0-9_-]{1,64}$').hasMatch(value);

class BillingSubscription {
  const BillingSubscription({
    required this.status,
    required this.hasAccess,
    this.provider,
    this.expiresAt,
  });
  final String status;
  final bool hasAccess;
  final String? provider;
  final DateTime? expiresAt;
  factory BillingSubscription.fromJson(Map<String, dynamic> json) {
    final status = _text(json, 'status');
    final access = json['has_access'];
    final provider = json['provider'];
    final expiry = json['expires_at'];
    if (!const [
          'inactive',
          'active',
          'past_due',
          'expired',
          'canceled',
          'withdrawn',
        ].contains(status) ||
        access is! bool ||
        (provider != null && provider is! String) ||
        (expiry != null &&
            (expiry is! String || DateTime.tryParse(expiry) == null))) {
      throw const FormatException('invalid_subscription');
    }
    return BillingSubscription(
      status: status,
      hasAccess: access,
      provider: provider as String?,
      expiresAt: expiry == null ? null : DateTime.parse(expiry as String),
    );
  }
}

class BillingPurchaseContext {
  const BillingPurchaseContext({
    required this.obfuscatedAccountId,
    required this.purchaseAllowed,
  });
  final String obfuscatedAccountId;
  final bool purchaseAllowed;
  factory BillingPurchaseContext.fromJson(Map<String, dynamic> json) {
    final owner = _text(json, 'obfuscated_account_id');
    if (!validBillingAccountId(owner) || json['purchase_allowed'] is! bool) {
      throw const FormatException('invalid_purchase_context');
    }
    return BillingPurchaseContext(
      obfuscatedAccountId: owner,
      purchaseAllowed: json['purchase_allowed'] as bool,
    );
  }
}

class BillingVerification {
  const BillingVerification({
    required this.purchaseStatus,
    required this.subscription,
    this.retryAfter,
  });
  final String purchaseStatus;
  final BillingSubscription subscription;

  /// Bounded processing delay from the HTTP header, never from purchase data.
  final Duration? retryAfter;
  factory BillingVerification.fromJson(Map<String, dynamic> json) {
    final status = json['purchase_status'];
    final subscription = json['subscription'];
    if (!const ['verified', 'pending', 'processing'].contains(status) ||
        subscription is! Map<String, dynamic>) {
      throw const FormatException('invalid_verification');
    }
    return BillingVerification(
      purchaseStatus: status as String,
      subscription: BillingSubscription.fromJson(subscription),
    );
  }
}

abstract interface class PlayBillingGateway {
  Stream<PlayBillingEvent> get events;
  Future<List<PlaySubscriptionPlan>> queryPlans();
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  });
  Future<List<PlayPurchase>> queryOwnedPurchases();
  Future<void> openSubscriptionManagement();
  void dispose();
}

/// Invalidates preparation before checkout when the Fuze account changes.
abstract interface class BillingSessionGateway {
  Future<void> invalidateAccount();
}

abstract interface class BillingApiRepository {
  Future<BillingSubscription> getSubscription(String token);
  Future<BillingPurchaseContext> getPurchaseContext(String token);
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  });
}

class UnavailablePlayBillingGateway implements PlayBillingGateway {
  const UnavailablePlayBillingGateway();
  @override
  Stream<PlayBillingEvent> get events => const Stream.empty();
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async =>
      throw const PlayBillingException('unavailable');
  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async => throw const PlayBillingException('unavailable');
  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async =>
      throw const PlayBillingException('unavailable');
  @override
  Future<void> openSubscriptionManagement() async =>
      throw const PlayBillingException('unavailable');
  @override
  void dispose() {}
}

class UnavailableBillingApi implements BillingApiRepository {
  const UnavailableBillingApi();
  @override
  Future<BillingSubscription> getSubscription(String token) async =>
      throw const PlayBillingException('unavailable');
  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async =>
      throw const PlayBillingException('unavailable');
  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async => throw const PlayBillingException('unavailable');
}

String _text(Map<dynamic, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.trim().isEmpty) {
    throw const FormatException('invalid_billing_field');
  }
  return value;
}
