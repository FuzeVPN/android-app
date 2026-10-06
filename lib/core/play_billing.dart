/// Google supplies display prices; the server alone supplies entitlement.
class PlaySubscriptionPlan {
  const PlaySubscriptionPlan({
    required this.productId,
    required this.basePlanId,
    required this.offerToken,
    required this.formattedPrice,
    required this.currencyCode,
    required this.billingPeriod,
    required this.priceAmountMicros,
  });
  final String productId,
      basePlanId,
      offerToken,
      formattedPrice,
      currencyCode,
      billingPeriod;
  final int priceAmountMicros;
  factory PlaySubscriptionPlan.fromJson(Map<dynamic, dynamic> json) {
    final product = _text(json, 'productId');
    final plan = _text(json, 'basePlanId');
    final period = _text(json, 'billingPeriod');
    final micros = json['priceAmountMicros'];
    if (product != 'premium' ||
        !const ['monthly', 'yearly'].contains(plan) ||
        period != (plan == 'monthly' ? 'P1M' : 'P1Y') ||
        micros is! int ||
        micros <= 0) {
      throw const FormatException('invalid_play_plan');
    }
    return PlaySubscriptionPlan(
      productId: product,
      basePlanId: plan,
      offerToken: _text(json, 'offerToken'),
      formattedPrice: _text(json, 'formattedPrice'),
      currencyCode: _text(json, 'currencyCode'),
      billingPeriod: period,
      priceAmountMicros: micros,
    );
  }
  bool sameOffer(PlaySubscriptionPlan other) =>
      productId == other.productId &&
      basePlanId == other.basePlanId &&
      offerToken == other.offerToken &&
      formattedPrice == other.formattedPrice &&
      currencyCode == other.currencyCode &&
      billingPeriod == other.billingPeriod &&
      priceAmountMicros == other.priceAmountMicros;
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
