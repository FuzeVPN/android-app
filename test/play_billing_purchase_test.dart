import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/play_billing_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const methods = MethodChannel('com.fuzevpn/billing');
  const events = EventChannel('com.fuzevpn/billing/events');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(methods, null);
    messenger.setMockStreamHandler(events, null);
  });

  test(
    'suspended purchase keeps its owner without implying an entitlement',
    () {
      final purchase = PlayPurchase.fromJson(_purchase(suspended: true));
      expect(purchase.state, 'purchased');
      expect(purchase.suspended, isTrue);
      expect(purchase.obfuscatedAccountId, 'original-owner');
      expect(purchase.acknowledged, isTrue);
      expect(purchase.toString(), isNot(contains(purchase.purchaseToken)));
    },
  );

  test('an older native receipt without the flag remains readable', () {
    final json = _purchase()..remove('suspended');
    expect(PlayPurchase.fromJson(json).suspended, isFalse);
  });

  for (final representation in ['absent', 'null', 'empty']) {
    test('R13-01 $representation account identifier remains unknown', () {
      for (final suspended in [false, true]) {
        final value = _purchase(suspended: suspended);
        if (representation == 'absent') {
          value.remove('obfuscatedAccountId');
        } else {
          value['obfuscatedAccountId'] = representation == 'empty' ? '' : null;
        }
        final purchase = PlayPurchase.fromJson(value);
        expect(purchase.obfuscatedAccountId, isNull);
        expect(purchase.suspended, suspended);
        expect(purchase.purchaseToken, 'synthetic-purchase-token');
      }
    });
  }

  test('R13-01 nonempty malformed account identifiers remain refused', () {
    for (final owner in <Object>[
      ' ',
      'owner with spaces',
      'a' * 65,
      0,
      false,
    ]) {
      expect(
        () => PlayPurchase.fromJson({
          ..._purchase(),
          'obfuscatedAccountId': owner,
        }),
        throwsFormatException,
      );
    }
  });

  test(
    'R13-01 mixed restore keeps unknown, original and suspended owners',
    () async {
      messenger.setMockMethodCallHandler(methods, (call) async {
        expect(call.method, 'queryOwnedPurchases');
        return _mixedOwners();
      });
      final purchases = await NativePlayBillingGateway().queryOwnedPurchases();
      expect(purchases.map((p) => p.obfuscatedAccountId), [
        null,
        null,
        null,
        'original-owner',
        'another-owner',
      ]);
      expect(purchases.map((p) => p.suspended), [
        true,
        false,
        true,
        true,
        false,
      ]);
    },
  );

  test(
    'R13-01 mixed purchase events preserve unknown owners without transfer',
    () async {
      messenger.setMockStreamHandler(
        events,
        MockStreamHandler.inline(
          onListen: (arguments, sink) => sink.success({
            'type': 'purchases',
            'purchases': _mixedOwners(),
            'obfuscatedAccountId': 'checkout-owner',
          }),
        ),
      );
      final event = await NativePlayBillingGateway().events.first;
      expect(event.obfuscatedAccountId, 'checkout-owner');
      expect(event.purchases.map((p) => p.obfuscatedAccountId), [
        null,
        null,
        null,
        'original-owner',
        'another-owner',
      ]);
      expect(event.purchases.map((p) => p.suspended), [
        true,
        false,
        true,
        true,
        false,
      ]);
    },
  );

  test('malformed suspension flags and suspended pending are rejected', () {
    for (final flag in <Object?>[null, 0, 1, 'true']) {
      expect(
        () => PlayPurchase.fromJson({..._purchase(), 'suspended': flag}),
        throwsFormatException,
      );
    }
    expect(
      () => PlayPurchase.fromJson({
        ..._purchase(suspended: true),
        'state': 'pending',
      }),
      throwsFormatException,
    );
  });

  test(
    'native restore preserves suspended receipts and distinct owners',
    () async {
      messenger.setMockMethodCallHandler(methods, (call) async {
        expect(call.method, 'queryOwnedPurchases');
        return [_purchase(suspended: true), _purchase(owner: 'another-owner')];
      });
      final purchases = await NativePlayBillingGateway().queryOwnedPurchases();
      expect(purchases.map((p) => p.suspended), [true, false]);
      expect(purchases.map((p) => p.obfuscatedAccountId), [
        'original-owner',
        'another-owner',
      ]);
      expect(() => purchases.clear(), throwsUnsupportedError);
    },
  );

  test('purchase events carry suspension through the native channel', () async {
    var cancelled = false;
    messenger.setMockStreamHandler(
      events,
      MockStreamHandler.inline(
        onListen: (arguments, sink) {
          sink.success({
            'type': 'purchases',
            'purchases': [_purchase(suspended: true)],
            'obfuscatedAccountId': 'original-owner',
          });
        },
        onCancel: (arguments) => cancelled = true,
      ),
    );
    final event = await NativePlayBillingGateway().events.first;
    expect(event.purchases.single.suspended, isTrue);
    expect(event.purchases.single.obfuscatedAccountId, 'original-owner');
    expect(event.obfuscatedAccountId, 'original-owner');
    await Future<void>.delayed(Duration.zero);
    expect(cancelled, isTrue);
  });
}

Map<String, Object?> _purchase({
  bool suspended = false,
  String owner = 'original-owner',
}) => {
  'productId': 'premium',
  'purchaseToken': 'synthetic-purchase-token',
  'state': 'purchased',
  'obfuscatedAccountId': owner,
  'acknowledged': true,
  'suspended': suspended,
};

List<Map<String, Object?>> _mixedOwners() => [
  _purchase(suspended: true)..remove('obfuscatedAccountId'),
  _purchase(owner: ''),
  {..._purchase(suspended: true), 'obfuscatedAccountId': null},
  _purchase(suspended: true),
  _purchase(owner: 'another-owner'),
];
