import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/auth/auth_page.dart';
import 'package:fuzevpn_android/features/auth/welcome_page.dart';
import 'package:fuzevpn_android/features/billing/subscription_card.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

const _monthly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'onboarding-offer',
  formattedPrice: '4,99 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4990000,
);
const _inactive = BillingSubscription(status: 'inactive', hasAccess: false);
final _active = BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: 'google_play',
  expiresAt: DateTime.utc(2099),
);
const _pendingPurchase = PlayPurchase(
  productId: 'premium',
  purchaseToken: 'onboarding-purchase',
  state: 'pending',
  obfuscatedAccountId: 'onboarding-owner',
  acknowledged: false,
);
const _paidPurchase = PlayPurchase(
  productId: 'premium',
  purchaseToken: 'onboarding-purchase',
  state: 'purchased',
  obfuscatedAccountId: 'onboarding-owner',
  acknowledged: false,
);

void main() {
  testWidgets('Start then Back preserves the initial welcome and label', (
    tester,
  ) async {
    final h = _Harness();
    addTearDown(h.dispose);
    await h.mount(tester);
    await _tap(tester, 'welcome-start');
    expect(find.byType(SubscriptionPaywallPage), findsOneWidget);
    await _back(tester);
    _expectWelcome(tester);
    expect(h.api.createdCredentials, isEmpty);
    expect(h.store.credential, isNull);
  });

  testWidgets('Sign in then Back leaves Start unchanged and creates no guest', (
    tester,
  ) async {
    final h = _Harness();
    addTearDown(h.dispose);
    await h.mount(tester);
    await _tap(tester, 'welcome-sign-in');
    expect(find.byType(AuthenticationPage), findsOneWidget);
    await _back(tester);
    _expectWelcome(tester);
    expect(h.api.createdCredentials, isEmpty);
    expect(h.store.session, isNull);
    expect(h.api.loginCalls, 0);
  });

  testWidgets('empty restoration then Sign in and Back keeps Start unchanged', (
    tester,
  ) async {
    final h = _Harness();
    addTearDown(h.dispose);
    await h.mount(tester);
    await _tap(tester, 'welcome-restore');
    expect(h.controller.guestMessageKey, 'billing.restoreEmpty');
    _expectWelcome(tester);
    await _tap(tester, 'welcome-sign-in');
    await _back(tester);
    _expectWelcome(tester);
    expect(h.controller.guestMessageKey, 'billing.restoreEmpty');
    expect(h.api.loginCalls, 0);
  });

  testWidgets(
    'cancelled checkout and Back preserve welcome and resume the same guest on retry',
    (tester) async {
      final h = _Harness();
      addTearDown(h.dispose);
      await h.mount(tester);
      await _checkout(tester, h);
      final credential = h.store.credential;
      expect(credential, isNotNull);
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.profile?.userId, 'onboarding-guest');
      expect(h.controller.profile?.canUseVpn, isFalse);
      expect(h.controller.billing.subscription?.hasAccess, isFalse);
      h.gateway.emit(
        const PlayBillingEvent(
          type: 'cancelled',
          obfuscatedAccountId: 'onboarding-owner',
        ),
      );
      await tester.pumpAndSettle();
      expect(h.controller.billing.messageKey, 'billing.cancelled');
      await _back(tester);
      _expectWelcome(tester);
      expect(h.store.session?.accessToken, 'onboarding-token');
      expect(h.store.credential, credential);
      expect(h.store.clearCalls, 0);
      await _checkout(tester, h);
      expect(h.api.createdCredentials, <String>[credential!]);
      expect(h.gateway.openedOwners, <String>[
        'onboarding-owner',
        'onboarding-owner',
      ]);
      expect(h.controller.profile?.userId, 'onboarding-guest');
      h.gateway.emit(
        const PlayBillingEvent(
          type: 'cancelled',
          obfuscatedAccountId: 'onboarding-owner',
        ),
      );
      await tester.pumpAndSettle();
      await _back(tester);
      _expectWelcome(tester);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('a cancelled checkout remains at welcome after app restart', (
    tester,
  ) async {
    final h = _Harness();
    addTearDown(h.dispose);
    await h.mount(tester);
    await _checkout(tester, h);
    h.gateway.emit(
      const PlayBillingEvent(
        type: 'cancelled',
        obfuscatedAccountId: 'onboarding-owner',
      ),
    );
    await tester.pumpAndSettle();
    final credential = h.store.credential;
    await h.restart(tester);
    _expectWelcome(tester);
    expect(h.controller.isSignedIn, isTrue);
    expect(h.controller.profile?.userId, 'onboarding-guest');
    expect(h.store.credential, credential);
    expect(h.api.createdCredentials, hasLength(1));
  });

  testWidgets(
    'an older expired Play guest with no device or marker resumes Home and persists admission',
    (tester) async {
      final h = _Harness();
      addTearDown(h.dispose);
      h.store.session = AuthSession(
        accessToken: 'onboarding-token',
        expiresAt: DateTime.utc(2099),
      );
      h.api.subscription = BillingSubscription(
        status: 'expired',
        hasAccess: false,
        provider: 'google_play',
        expiresAt: DateTime.utc(2020),
      );
      expect(h.store.admittedUsers, isEmpty);
      await h.mount(tester);
      expect(h.controller.currentDeviceId, isNull);
      expect(h.controller.profile?.canUseVpn, isFalse);
      // The fixture does not auto-restore purchases. Read the authoritative
      // subscription explicitly to reconstruct a pre-marker installation.
      await h.controller.billing.loadPlans();
      await tester.pumpAndSettle();
      expect(find.byType(HomeShell), findsOneWidget);
      expect(find.byType(WelcomePage), findsNothing);
      expect(h.store.admittedUsers, contains('onboarding-guest'));
      expect(h.api.createdCredentials, isEmpty);
      h.api.subscription = _inactive;
      await h.restart(tester);
      expect(find.byType(HomeShell), findsOneWidget);
      expect(find.byType(WelcomePage), findsNothing);
      expect(h.controller.currentDeviceId, isNull);
      expect(h.controller.profile?.canUseVpn, isFalse);
      expect(h.store.clearCalls, 0);
      expect(h.gateway.openedOwners, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'VPN permission alone without an active subscription keeps an unactivated guest at welcome',
    (tester) async {
      final h = _Harness();
      addTearDown(h.dispose);
      h.api.canUseVpn = true;
      h.store.session = AuthSession(
        accessToken: 'onboarding-token',
        expiresAt: DateTime.utc(2099),
      );
      await h.mount(tester);
      expect(h.controller.isSignedIn, isTrue);
      expect(h.controller.profile?.canUseVpn, isTrue);
      _expectWelcome(tester);
      await h.controller.billing.loadPlans();
      await tester.pumpAndSettle();
      expect(h.controller.billing.subscription?.hasAccess, isFalse);
      _expectWelcome(tester);
      expect(h.store.admittedUsers, isEmpty);
      expect(h.api.createdCredentials, isEmpty);
      expect(h.gateway.openedOwners, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  for (final status in <String>['pending', 'processing']) {
    testWidgets(
      '$status checkout stays at welcome after Back and restart, and cannot launch a second checkout',
      (tester) async {
        final h = _Harness();
        addTearDown(h.dispose);
        await h.mount(tester);
        await _checkout(tester, h);
        h.api.purchaseStatus = status;
        final purchase = status == 'pending' ? _pendingPurchase : _paidPurchase;
        h.gateway.owned = <PlayPurchase>[purchase];
        h.gateway.emit(
          PlayBillingEvent(
            type: 'purchases',
            purchases: <PlayPurchase>[purchase],
          ),
        );
        await tester.pumpAndSettle();
        expect(h.controller.profile?.canUseVpn, isFalse);
        expect(h.controller.billing.subscription?.hasAccess, isFalse);
        await _back(tester);
        _expectWelcome(tester);
        final credential = h.store.credential;
        await h.restart(tester);
        _expectWelcome(tester);
        await _checkout(tester, h);
        expect(h.gateway.openedOwners, <String>['onboarding-owner']);
        expect(h.store.credential, credential);
        expect(h.api.createdCredentials, hasLength(1));
        await _back(tester);
        _expectWelcome(tester);
        expect(tester.takeException(), isNull);
        // End the foreground scenario before the test binding checks timers.
        // Processing deliberately keeps its retry timer while the app is open.
        h.controller.billing.onAppPaused();
      },
    );
  }

  testWidgets(
    'verified payment waits for VPN permission, then opens Home and keeps it after expiration',
    (tester) async {
      final h = _Harness();
      addTearDown(h.dispose);
      await h.mount(tester);
      await _checkout(tester, h);
      h.api.subscription = _active;
      h.gateway.owned = const <PlayPurchase>[_paidPurchase];
      h.gateway.emit(
        const PlayBillingEvent(
          type: 'purchases',
          purchases: <PlayPurchase>[_paidPurchase],
        ),
      );
      await tester.pumpAndSettle();
      expect(h.controller.billing.subscription?.hasAccess, isTrue);
      expect(h.controller.profile?.canUseVpn, isFalse);
      expect(find.byType(HomeShell, skipOffstage: false), findsNothing);
      expect(find.byKey(const ValueKey('guest-activation')), findsNothing);
      h.api.canUseVpn = true;
      await h.controller.refreshGuestAccount();
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('guest-activation')), findsOneWidget);
      await _tap(tester, 'guest-activation-use-vpn');
      expect(find.byType(HomeShell), findsOneWidget);
      expect(find.byType(WelcomePage), findsNothing);
      h.api.canUseVpn = false;
      h.api.subscription = BillingSubscription(
        status: 'expired',
        hasAccess: false,
        provider: 'google_play',
        expiresAt: DateTime.utc(2020),
      );
      await h.controller.refreshGuestAccount();
      await h.controller.billing.refreshSubscription();
      await tester.pumpAndSettle();
      expect(h.controller.profile?.canUseVpn, isFalse);
      expect(h.controller.billing.subscription?.hasAccess, isFalse);
      expect(find.byType(HomeShell), findsOneWidget);
      expect(find.byType(WelcomePage), findsNothing);
      expect(h.store.clearCalls, 0);
      expect(h.store.admittedUsers, contains('onboarding-guest'));
      // Inactive metadata may no longer expose historical subscription dates.
      // The per-identity admission record still preserves account management.
      h.api.subscription = _inactive;
      await h.restart(tester);
      expect(find.byType(HomeShell), findsOneWidget);
      expect(find.byType(WelcomePage), findsNothing);
      expect(h.controller.profile?.canUseVpn, isFalse);
      expect(tester.takeException(), isNull);
    },
  );
}

void _expectWelcome(WidgetTester tester) {
  expect(find.byType(WelcomePage), findsOneWidget);
  expect(find.byType(HomeShell), findsNothing);
  expect(find.byType(SubscriptionPaywallPage), findsNothing);
  final start = tester.widget<FilledButton>(
    find.byKey(const ValueKey('welcome-start')),
  );
  expect((start.child! as Text).data, 'Démarrer');
  expect(find.text('Voir les formules'), findsNothing);
}

Future<void> _tap(WidgetTester tester, String key) async {
  final target = find.byKey(ValueKey(key));
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
  await tester.tap(target);
  // The native Play sheet owns its own window; the Flutter route shows an
  // indeterminate progress indicator until a callback arrives. Do not wait for
  // that intentionally continuous animation to settle.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

Future<void> _back(WidgetTester tester) async {
  // Match Android's system Back independently of the custom app bar artwork.
  await tester.binding.handlePopRoute();
  await tester.pumpAndSettle();
}

Future<void> _checkout(WidgetTester tester, _Harness h) async {
  await _tap(tester, 'welcome-start');
  expect(find.byType(SubscriptionPaywallPage), findsOneWidget);
  await _tap(tester, 'subscription-plan-monthly');
  await _tap(tester, 'subscription-continue');
  expect(h.controller.isSignedIn, isTrue);
}

class _Harness {
  _Harness() {
    controller = _newController();
  }
  final api = _Api();
  final store = _Store();
  final gateway = _Gateway();
  late VpnAppController controller;
  VpnAppController _newController() => VpnAppController(
    api: api,
    sessionStore: store,
    preferences: _Preferences(),
    tunnel: _Tunnel(),
    billingApi: api,
    billingGateway: gateway,
  );
  Future<void> mount(WidgetTester tester) async {
    await controller.initialize();
    await tester.pumpWidget(
      FuzeVpnApp(controller: controller, autoInitialize: false),
    );
    await tester.pumpAndSettle();
  }

  Future<void> restart(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    controller.dispose();
    controller = _newController();
    await mount(tester);
  }

  void dispose() => controller.dispose();
}

class _Api extends Fake
    implements VpnApiRepository, GuestApiRepository, BillingApiRepository {
  final createdCredentials = <String>[];
  int loginCalls = 0;
  bool canUseVpn = false;
  String purchaseStatus = 'verified';
  BillingSubscription subscription = _inactive;
  @override
  Future<List<Location>> locations() async => const <Location>[];
  @override
  Future<UserProfile> me(String token) async => UserProfile(
    userId: 'onboarding-guest',
    identityKind: 'guest',
    hasSessionCapabilities: true,
    profileRedacted: true,
    canManageAccount: false,
    canClaimAccount: true,
    canUseVpn: canUseVpn,
  );
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: <VpnDevice>[]);
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    throw StateError('No login was expected');
  }

  @override
  Future<GuestSessionResult> createGuestSession({
    required String guestCredential,
    bool termsAccepted = false,
    bool privacyAccepted = false,
  }) async {
    createdCredentials.add(guestCredential);
    return GuestSessionResult(
      session: AuthSession(
        accessToken: 'onboarding-token',
        expiresAt: DateTime.utc(2099),
      ),
      userId: 'onboarding-guest',
    );
  }

  @override
  Future<BillingSubscription> getSubscription(String token) async =>
      subscription;
  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async =>
      BillingPurchaseContext(
        obfuscatedAccountId: 'onboarding-owner',
        purchaseAllowed: !subscription.hasAccess,
      );
  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async => BillingVerification(
    purchaseStatus: purchaseStatus,
    subscription: subscription,
  );
}

class _Store extends Fake
    implements SecureSessionStore, GuestCredentialStore, GuestOnboardingStore {
  AuthSession? session;
  String? credential, pendingCredential;
  bool autoResume = false;
  int clearCalls = 0;
  final admittedUsers = <String>{};
  @override
  Future<bool> readGuestOnboardingCompleted({required String userId}) async =>
      admittedUsers.contains(userId);
  @override
  Future<void> writeGuestOnboardingCompleted({required String userId}) async {
    admittedUsers.add(userId);
  }

  @override
  Future<AuthSession?> readSession() async => session;
  @override
  Future<void> writeSession(AuthSession value, {String? userId}) async {
    session = value;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async => null;
  @override
  Future<String?> readGuestCredential() async => credential;
  @override
  Future<void> writeGuestCredential(String value) async {
    credential = value;
    pendingCredential = null;
  }

  @override
  Future<String?> readPendingGuestCredential() async => pendingCredential;
  @override
  Future<void> writePendingGuestCredential(String value) async {
    pendingCredential = value;
  }

  @override
  Future<bool> readGuestAutoResume() async => autoResume;
  @override
  Future<void> writeGuestAutoResume(bool enabled) async {
    autoResume = enabled;
  }

  @override
  Future<void> clearGuestCredentials() async {
    credential = pendingCredential = null;
    autoResume = false;
  }

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    clearCalls++;
    session = null;
    return SessionTerminationResult(
      tunnelStopped: true,
      sessionCleared: true,
      sessionExpired: expired,
    );
  }
}

class _Preferences extends Fake implements AppPreferenceStore {
  @override
  Future<String?> readThemeMode() async => 'light';
  @override
  Future<String?> readLocale() async => 'fr';
  @override
  Future<String?> readSelectedProtocol() async => 'wireguard';
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {}
}

class _Tunnel extends Fake implements VpnTunnelGateway {
  @override
  Stream<VpnRuntimeState> get states => const Stream.empty();
  @override
  Future<VpnRuntimeState> getState() async =>
      const VpnRuntimeState(phase: VpnRuntimePhase.idle);
}

class _Gateway extends Fake implements PlayBillingGateway {
  final _events = StreamController<PlayBillingEvent>.broadcast();
  final openedOwners = <String>[];
  List<PlayPurchase> owned = const <PlayPurchase>[];
  @override
  Stream<PlayBillingEvent> get events => _events.stream;
  void emit(PlayBillingEvent event) => _events.add(event);
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => const [_monthly];
  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async => owned;
  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async => openedOwners.add(obfuscatedAccountId);
  @override
  void dispose() {}
}
