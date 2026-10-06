import 'package:flutter/services.dart';
import 'core/play_billing.dart';

class NativePlayBillingGateway
    implements PlayBillingGateway, BillingSessionGateway {
  static const _methods = MethodChannel('com.fuzevpn/billing');
  static const _events = EventChannel('com.fuzevpn/billing/events');
  late final Stream<PlayBillingEvent> _stream = _events
      .receiveBroadcastStream()
      .map((event) {
        if (event is! Map) throw const PlayBillingException('invalid_response');
        final type = event['type'];
        if (!const ['purchases', 'cancelled', 'error'].contains(type)) {
          throw const PlayBillingException('invalid_response');
        }
        return PlayBillingEvent(
          type: type as String,
          purchases: type == 'purchases'
              ? _purchases(event['purchases'])
              : const [],
          code: _safeCode(event['code']),
          obfuscatedAccountId: event['obfuscatedAccountId'] as String?,
        );
      });
  @override
  Stream<PlayBillingEvent> get events => _stream;
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async {
    final raw = await _invoke('queryPremiumPlans');
    if (raw is! List) throw const PlayBillingException('invalid_response');
    try {
      final plans = raw
          .map((value) => PlaySubscriptionPlan.fromJson(value as Map))
          .toList();
      if (plans.map((p) => p.basePlanId).toSet().length != plans.length) {
        throw const FormatException('duplicate_plan');
      }
      plans.sort((a, b) => a.basePlanId.compareTo(b.basePlanId));
      return List.unmodifiable(plans);
    } catch (_) {
      throw const PlayBillingException('invalid_response');
    }
  }

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async {
    await _invoke('launchSubscription', <String, Object?>{
      'basePlanId': plan.basePlanId,
      'offerToken': plan.offerToken,
      'formattedPrice': plan.formattedPrice,
      'currencyCode': plan.currencyCode,
      'billingPeriod': plan.billingPeriod,
      'obfuscatedAccountId': obfuscatedAccountId,
    });
  }

  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async =>
      _purchases(await _invoke('queryOwnedPurchases'));
  @override
  Future<void> openSubscriptionManagement() async {
    await _invoke('openSubscriptionManagement');
  }

  @override
  void dispose() {}

  @override
  Future<void> invalidateAccount() async {
    try {
      await _invoke('invalidateAccount');
    } catch (_) {
      /* Fail closed in native preparation. */
    }
  }

  Future<dynamic> _invoke(
    String method, [
    Map<String, Object?>? arguments,
  ]) async {
    try {
      return await _methods.invokeMethod<dynamic>(method, arguments);
    } on PlatformException catch (error) {
      throw PlayBillingException(_safeCode(error.code));
    } on MissingPluginException {
      throw const PlayBillingException('unavailable');
    }
  }

  static List<PlayPurchase> _purchases(dynamic value) {
    try {
      if (value is! List) throw const FormatException('invalid_purchases');
      return List.unmodifiable(
        value.map((row) => PlayPurchase.fromJson(row as Map)),
      );
    } catch (_) {
      throw const PlayBillingException('invalid_response');
    }
  }

  static String _safeCode(dynamic code) =>
      const [
        'unavailable',
        'network',
        'price_changed',
        'already_owned',
        'busy',
        'invalid_request',
        'cancelled',
      ].contains(code)
      ? code as String
      : 'unavailable';
}
