import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/play_billing.dart';

void main() {
  const inactive = <String, Object?>{
    'status': 'inactive',
    'has_access': false,
    'provider': null,
    'expires_at': null,
  };
  test(
    'localized Google price is preserved exactly and unsupported plan rejected',
    () {
      final json = <String, Object?>{
        'productId': 'premium',
        'basePlanId': 'monthly',
        'offerToken': 'fixture-offer',
        'formattedPrice': '1,99\u00a0€',
        'currencyCode': 'EUR',
        'billingPeriod': 'P1M',
        'priceAmountMicros': 1990000,
      };
      expect(PlaySubscriptionPlan.fromJson(json).formattedPrice, '1,99\u00a0€');
      for (final change in <Map<String, Object?>>[
        {'productId': 'other'},
        {'basePlanId': 'weekly'},
        {'billingPeriod': 'P1Y'},
        {'priceAmountMicros': 0},
      ]) {
        expect(
          () => PlaySubscriptionPlan.fromJson({...json, ...change}),
          throwsFormatException,
        );
      }
    },
  );
  test('purchase context rejects raw identifiers and malformed permission', () {
    for (final id in ['user@example.invalid', 'id with spaces', 'x' * 65, '']) {
      expect(
        () => BillingPurchaseContext.fromJson({
          'obfuscated_account_id': id,
          'purchase_allowed': true,
        }),
        throwsFormatException,
      );
    }
    expect(
      () => BillingPurchaseContext.fromJson({
        'obfuscated_account_id': 'opaque',
        'purchase_allowed': 'true',
      }),
      throwsFormatException,
    );
  });
  test(
    'API uses bearer context and token-only verify without client prices',
    () async {
      final transport = _Transport();
      final api = ApiClient(transport: transport);
      addTearDown(api.close);
      transport.response = {
        'obfuscated_account_id': 'opaque_account',
        'purchase_allowed': true,
      };
      expect(
        (await api.getPurchaseContext('fixture-session')).purchaseAllowed,
        isTrue,
      );
      expect(
        transport.request!.uri.path,
        '/v1/billing/providers/google-play/purchase-context',
      );
      expect(
        transport.request!.headers['Authorization'] ??
            transport.request!.headers['authorization'],
        'Bearer fixture-session',
      );
      transport.response = {
        'purchase_status': 'verified',
        'subscription': inactive,
      };
      expect(
        (await api.verifyPurchase(
          token: 'fixture-session',
          purchaseToken: 'fixture-purchase',
        )).subscription.hasAccess,
        isFalse,
      );
      expect(jsonDecode(transport.request!.body!), {
        'purchase_token': 'fixture-purchase',
      });
      expect(transport.request!.method, 'POST');
      expect(
        transport.request!.uri.path,
        '/v1/billing/providers/google-play/purchases/verify',
      );
      expect(
        transport.request!.headers['authorization'],
        'Bearer fixture-session',
      );
      expect(transport.request!.headers['cache-control'], 'no-store');
    },
  );
  test(
    'no-store, known verification state and 202 semantics are required',
    () async {
      final transport = _Transport();
      final api = ApiClient(transport: transport);
      addTearDown(api.close);
      transport.response = inactive;
      transport.noStore = false;
      await expectLater(
        api.getSubscription('fixture-session'),
        throwsA(isA<ApiProtocolException>()),
      );
      transport.noStore = true;
      transport.response = {
        'purchase_status': 'unknown',
        'subscription': inactive,
      };
      await expectLater(
        api.verifyPurchase(
          token: 'fixture-session',
          purchaseToken: 'fixture-purchase',
        ),
        throwsA(isA<ApiProtocolException>()),
      );
      transport.status = 202;
      transport.response = {
        'purchase_status': 'verified',
        'subscription': inactive,
      };
      await expectLater(
        api.verifyPurchase(
          token: 'fixture-session',
          purchaseToken: 'fixture-purchase',
        ),
        throwsA(isA<ApiProtocolException>()),
      );
      transport.response = {
        'purchase_status': 'processing',
        'subscription': inactive,
      };
      expect(
        (await api.verifyPurchase(
          token: 'fixture-session',
          purchaseToken: 'fixture-purchase',
        )).purchaseStatus,
        'processing',
      );
    },
  );

  for (final (httpStatus, purchaseStatus) in const <(int, String)>[
    (200, 'processing'),
    (202, 'pending'),
    (202, 'verified'),
  ]) {
    test('HTTP $httpStatus with $purchaseStatus is a protocol error', () async {
      final transport = _Transport()
        ..status = httpStatus
        ..response = {
          'purchase_status': purchaseStatus,
          'subscription': inactive,
        };
      final api = ApiClient(transport: transport);
      addTearDown(api.close);

      await expectLater(
        api.verifyPurchase(
          token: 'fixture-session',
          purchaseToken: 'fixture-purchase',
        ),
        throwsA(
          isA<ApiProtocolException>().having(
            (failure) => failure.statusCode,
            'HTTP status',
            httpStatus,
          ),
        ),
      );
    });
  }

  test(
    'HTTP 200 verified preserves access while acknowledgement is processing',
    () async {
      final transport = _Transport()
        ..response = {
          'purchase_status': 'verified',
          'acknowledgement_status': 'processing',
          'subscription': {
            'status': 'active',
            'has_access': true,
            'provider': 'google_play',
            'expires_at': '2099-01-01T00:00:00Z',
          },
        };
      final api = ApiClient(transport: transport);
      addTearDown(api.close);

      final verification = await api.verifyPurchase(
        token: 'fixture-session',
        purchaseToken: 'fixture-purchase',
      );
      expect(verification.purchaseStatus, 'verified');
      expect(verification.subscription.hasAccess, isTrue);
      expect(verification.subscription.provider, 'google_play');
      expect(verification.subscription.expiresAt, DateTime.utc(2099, 1, 1));
    },
  );

  test(
    'HTTP 200 pending preserves independent web access from the common subscription',
    () async {
      final transport = _Transport()
        ..response = {
          'purchase_status': 'pending',
          'subscription': {
            'status': 'active',
            'has_access': true,
            'provider': 'sumup',
            'expires_at': '2099-02-01T00:00:00Z',
          },
        };
      final api = ApiClient(transport: transport);
      addTearDown(api.close);

      final verification = await api.verifyPurchase(
        token: 'fixture-session',
        purchaseToken: 'fixture-purchase',
      );
      expect(verification.purchaseStatus, 'pending');
      expect(verification.subscription.hasAccess, isTrue);
      expect(verification.subscription.provider, 'sumup');
      expect(verification.subscription.expiresAt, DateTime.utc(2099, 2, 1));
    },
  );

  for (final (httpStatus, errorCode) in const <(int, String)>[
    (503, 'google_play_unavailable'),
    (400, 'google_play_purchase_invalid'),
    (409, 'google_play_account_mismatch'),
    (409, 'google_play_purchase_unsupported'),
    (409, 'google_play_test_purchase_not_allowed'),
  ]) {
    test(
      '$errorCode exposes safe metadata without the response body',
      () async {
        final transport = _Transport()
          ..status = httpStatus
          ..response = {
            'error': errorCode,
            'message': 'body-only-private-diagnostic',
            'details': {
              'purchase_token': 'body-only-purchase-token',
              'account': 'body-only-account-reference',
            },
          };
        final api = ApiClient(transport: transport);
        addTearDown(api.close);

        await expectLater(
          api.verifyPurchase(
            token: 'fixture-session',
            purchaseToken: 'fixture-purchase',
          ),
          throwsA(
            isA<ApiException>()
                .having(
                  (failure) => failure.statusCode,
                  'HTTP status',
                  httpStatus,
                )
                .having((failure) => failure.code, 'stable code', errorCode)
                .having(
                  (failure) => failure.errorCode,
                  'public error code',
                  errorCode,
                )
                .having(
                  (failure) => failure.toString(),
                  'redacted public representation',
                  allOf(
                    isNot(contains('body-only-private-diagnostic')),
                    isNot(contains('body-only-purchase-token')),
                    isNot(contains('body-only-account-reference')),
                    isNot(contains('fixture-session')),
                    isNot(contains('fixture-purchase')),
                  ),
                ),
          ),
        );
      },
    );
  }
  for (final (header, expected) in <(String?, Duration?)>[
    ('5', const Duration(seconds: 5)),
    (' 60 ', const Duration(seconds: 60)),
    (null, null),
    ('0', null),
    ('-1', null),
    ('61', null),
    ('invalid', null),
  ]) {
    test('processing Retry-After $header is bounded', () async {
      final transport = _Transport()
        ..status = 202
        ..retryAfter = header
        ..response = {
          'purchase_status': 'processing',
          'subscription': {'status': 'inactive', 'has_access': false},
        };
      final api = ApiClient(transport: transport);
      addTearDown(api.close);
      final result = await api.verifyPurchase(
        token: 'fixture-session',
        purchaseToken: 'fixture-purchase',
      );
      expect(result.retryAfter, expected);
    });
  }
}

class _Transport extends ApiHttpTransport {
  ApiHttpRequest? request;
  Map<String, Object?> response = {};
  int status = 200;
  bool noStore = true;
  String? retryAfter;
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest value) async {
    request = value;
    return ApiHttpResponse(
      statusCode: status,
      headers: {
        'cache-control': noStore ? 'private, no-store' : 'private',
        if (retryAfter != null) 'Retry-After': retryAfter!,
      },
      body: jsonEncode(response),
    );
  }
}
