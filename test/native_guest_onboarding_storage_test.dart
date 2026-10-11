import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('fuzevpn.guest.onboarding.storage.test');
  late List<MethodCall> calls;
  late Map<String, Object?> responses;
  late NativeVpnBridge bridge;
  late NativeSecureStore store;

  setUp(() {
    calls = <MethodCall>[];
    responses = <String, Object?>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return responses[call.method];
        });
    bridge = NativeVpnBridge(channel: channel);
    store = NativeSecureStore(bridge);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'onboarding uses typed account-scoped RPCs with no caller-chosen value',
    () async {
      final GuestOnboardingStore onboarding = store;
      expect(
        await onboarding.readGuestOnboardingCompleted(userId: 'guest-a'),
        isFalse,
      );
      await onboarding.writeGuestOnboardingCompleted(userId: 'guest-a');
      responses['storageReadGuestOnboardingCompleted'] = true;
      expect(
        await bridge.readGuestOnboardingCompleted(userId: 'guest-a'),
        isTrue,
      );
      responses['storageReadGuestOnboardingCompleted'] = false;
      expect(
        await onboarding.readGuestOnboardingCompleted(userId: 'guest-b'),
        isFalse,
      );
      expect(calls.map((call) => call.method), <String>[
        'storageReadGuestOnboardingCompleted',
        'storageWriteGuestOnboardingCompleted',
        'storageReadGuestOnboardingCompleted',
        'storageReadGuestOnboardingCompleted',
      ]);
      for (final call in calls.take(3)) {
        expect(call.arguments, <String, Object>{'account_id': 'guest-a'});
      }
      expect(calls.last.arguments, <String, Object>{'account_id': 'guest-b'});
    },
  );

  test('unexpected native types cannot enable onboarding', () async {
    for (final value in <Object>[
      'true',
      1,
      <String, Object>{'value': true},
    ]) {
      responses['storageReadGuestOnboardingCompleted'] = value;
      await expectLater(
        store.readGuestOnboardingCompleted(userId: 'guest-a'),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'secure_storage_corrupt',
          ),
        ),
      );
    }
  });

  test(
    'invalid account identifiers fail before crossing the channel',
    () async {
      for (final userId in <String>[
        '',
        ' ',
        'guest/a',
        'guest-a\n',
        'guest-a\u0000',
        'invité',
        List.filled(129, 'a').join(),
      ]) {
        for (final GuestOnboardingStore onboarding in <GuestOnboardingStore>[
          bridge,
          store,
        ]) {
          await expectLater(
            onboarding.readGuestOnboardingCompleted(userId: userId),
            throwsA(
              isA<NativeVpnException>().having(
                (error) => error.code,
                'code',
                'invalid_account_id',
              ),
            ),
          );
          await expectLater(
            onboarding.writeGuestOnboardingCompleted(userId: userId),
            throwsA(
              isA<NativeVpnException>().having(
                (error) => error.code,
                'code',
                'invalid_account_id',
              ),
            ),
          );
        }
      }
      expect(calls, isEmpty);
    },
  );

  test('clearing a session does not write or reset guest onboarding', () async {
    responses['storageClearSession'] = <String, Object>{
      'tunnel_stopped': true,
      'session_cleared': true,
    };
    responses['storageReadGuestOnboardingCompleted'] = true;
    await store.writeGuestOnboardingCompleted(userId: 'guest-a');
    await store.clearSession(expired: true);
    await store.clearSession();
    final restarted = NativeSecureStore(NativeVpnBridge(channel: channel));
    expect(
      await restarted.readGuestOnboardingCompleted(userId: 'guest-a'),
      isTrue,
    );
    expect(calls.map((call) => call.method), <String>[
      'storageWriteGuestOnboardingCompleted',
      'storageClearSession',
      'storageClearSession',
      'storageReadGuestOnboardingCompleted',
    ]);
  });

  test('unsupported storage defaults off and rejects writes', () async {
    final accountOnly = NativeSecureStore(_AccountOnlyStorage());
    expect(
      await accountOnly.readGuestOnboardingCompleted(userId: 'guest-a'),
      isFalse,
    );
    await expectLater(
      accountOnly.writeGuestOnboardingCompleted(userId: 'guest-a'),
      throwsA(
        isA<NativeVpnException>().having(
          (error) => error.code,
          'code',
          'native_bridge_unavailable',
        ),
      ),
    );
    expect(calls, isEmpty);
  });

  test(
    'write failures remain visible instead of claiming persistence',
    () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
            throw PlatformException(code: 'secure_storage_write_failed');
          });
      await expectLater(
        store.writeGuestOnboardingCompleted(userId: 'guest-a'),
        throwsA(
          isA<NativeVpnException>().having(
            (error) => error.code,
            'code',
            'secure_storage_write_failed',
          ),
        ),
      );
    },
  );
}

class _AccountOnlyStorage extends Fake implements NativeStorageGateway {}
