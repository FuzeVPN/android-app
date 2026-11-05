import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

const _monthly = PlaySubscriptionPlan(
  productId: 'premium',
  basePlanId: 'monthly',
  offerToken: 'offer-fixture',
  formattedPrice: '4,99 €',
  currencyCode: 'EUR',
  billingPeriod: 'P1M',
  priceAmountMicros: 4990000,
);
const _inactive = BillingSubscription(status: 'inactive', hasAccess: false);
const _active = BillingSubscription(
  status: 'active',
  hasAccess: true,
  provider: 'google_play',
);
const _purchase = PlayPurchase(
  productId: 'premium',
  purchaseToken: 'purchase-fixture',
  state: 'purchased',
  obfuscatedAccountId: 'owner-fixture',
  acknowledged: false,
);
const _location = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 1',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard},
);
const _wireGuardPublicKey = 'AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE=';
const _device = VpnDevice(
  deviceId: 'device-fixture',
  name: 'FuzeVPN Android',
  location: _location,
  createdAt: null,
);
const _deviceConfiguration = DeviceConfiguration(
  deviceId: 'device-fixture',
  address: '10.8.0.2/32',
  dns: <String>['1.1.1.1'],
  serverPublicKey: 'AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI=',
  endpoint: '192.0.2.1:51820',
  allowedIps: <String>['0.0.0.0/0'],
);

final _credential = base64Url
    .encode(List<int>.generate(32, (i) => i))
    .replaceAll('=', '');
AuthSession _session(String token) =>
    AuthSession(accessToken: token, expiresAt: DateTime.utc(2099));
UserProfile _guest({String userId = 'guest-fixture'}) => UserProfile(
  userId: userId,
  identityKind: 'guest',
  profileRedacted: true,
  canManageAccount: false,
  canClaimAccount: true,
  canUseVpn: true,
);
UserProfile _claimed({bool redacted = false}) => UserProfile(
  userId: 'guest-fixture',
  identityKind: 'registered',
  email: redacted ? '' : 'new@example.test',
  profileRedacted: redacted,
  canManageAccount: !redacted,
  canClaimAccount: false,
  canUseVpn: true,
  emailVerified: redacted ? null : false,
);
const _separateAccount = UserProfile(
  userId: 'registered-fixture',
  email: 'existing@example.test',
  emailVerified: true,
);

void main() {
  _guestAdmissionCorrectionTests();
  _reauditFinalGuestTests();
  test(
    'anonymous catalogue inspection creates no guest or recovery credential',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.billing.loadPlans();
      expect(h.controller.billing.plans, <PlaySubscriptionPlan>[_monthly]);
      expect(h.api.createdCredentials, isEmpty);
      expect(h.api.billingContextTokens, isEmpty);
      expect(h.store.credential, isNull);
      expect(h.store.pendingCredential, isNull);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.gateway.openedOwners, isEmpty);
      expect(h.controller.isSignedIn, isFalse);
    },
  );

  test(
    'the recovery credential is durable before guest HTTP and payment acceptance grants no local access',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.billing.loadPlans();
      h.api.onCreate = (credential) async {
        expect(h.store.credential, credential);
        expect(h.store.pendingCredential, isNull);
        expect(
          h.events.indexOf('store.promote'),
          lessThan(h.events.indexOf('api.create')),
        );
        return GuestSessionResult(
          session: _session('guest-token'),
          userId: 'guest-fixture',
        );
      };
      await h.controller.beginGuestPurchase(_monthly);
      expect(h.api.createdCredentials, hasLength(1));
      final created = h.api.createdCredentials.single;
      expect(base64Url.decode('$created='), hasLength(32));
      expect(h.store.credential, created);
      expect(h.store.pendingCredential, isNull);
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.profile?.email, isEmpty);
      expect(h.controller.billing.subscription?.hasAccess, isFalse);
      expect(h.gateway.openedOwners, <String>['owner-fixture']);
      expect(h.gateway.ownedQueries, 1);
      expect(h.gateway.accountInvalidations, 1);
      expect(h.api.createConsents.single, (true, true));
    },
  );

  test(
    'a lost creation response reuses the same durable credential on retry',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.billing.loadPlans();
      h.api.onCreate = (_) async => throw const ApiNetworkException();
      await h.controller.beginGuestPurchase(_monthly);
      final credential = h.store.credential;
      expect(credential, isNotNull);
      expect(h.controller.isSignedIn, isFalse);
      expect(h.gateway.openedOwners, isEmpty);
      h.api.onCreate = (_) async => GuestSessionResult(
        session: _session('guest-token'),
        userId: 'guest-fixture',
      );
      await h.controller.beginGuestPurchase(_monthly);
      expect(h.api.createdCredentials, <String>[credential!, credential]);
      expect(h.store.credential, credential);
      expect(h.store.pendingCredential, isNull);
      expect(h.gateway.openedOwners, hasLength(1));
    },
  );

  test(
    'email_exists preserves the guest token, premium access, device and connected VPN',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onClaim = (_, _, _) async =>
          throw const ApiException(statusCode: 409, errorCode: 'email_exists');
      expect(
        await h.controller.claimGuestAccount(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.controller.billing.subscription?.hasAccess, isTrue);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.replacements, isEmpty);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      expect(h.controller.guestMessageKey, 'guest.emailExists');
    },
  );

  test(
    'claim success adopts personal permissions without changing the token or native session',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onClaim = (_, _, _) async {
        h.api.profiles['guest-token'] = _claimed();
        return const GuestClaimResult(
          emailVerified: false,
          verificationEmailSent: true,
        );
      };
      expect(
        await h.controller.claimGuestAccount(
          email: 'new@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.controller.profile?.isGuest, isFalse);
      expect(h.controller.profile?.profileRedacted, isFalse);
      expect(h.controller.profile?.canManageAccount, isTrue);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.replacements, isEmpty);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
    },
  );

  test(
    'another guest session observing a claim keeps redacted permissions and VPN access',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.profiles['guest-token'] = _claimed(redacted: true);
      await h.controller.refreshGuestAccount();
      expect(h.controller.profile?.isGuest, isFalse);
      expect(h.controller.profile?.profileRedacted, isTrue);
      expect(h.controller.profile?.canManageAccount, isFalse);
      expect(h.controller.profile?.canClaimAccount, isFalse);
      expect(h.controller.profile?.email, isEmpty);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.replacements, isEmpty);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
    },
  );

  test(
    'GET me reconciles a successful claim when the HTTP response was lost',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onClaim = (_, _, _) async {
        h.api.profiles['guest-token'] = _claimed();
        throw const ApiNetworkException();
      };
      final beforeMe = h.api.meTokens.length;
      expect(
        await h.controller.claimGuestAccount(
          email: 'new@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.api.claimCalls, 1);
      expect(h.api.meTokens.length, greaterThan(beforeMe));
      expect(h.controller.profile?.isGuest, isFalse);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.replacements, isEmpty);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
    },
  );

  test(
    'a pending restored receipt never unlocks premium or opens another checkout',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.gateway.owned = <PlayPurchase>[
        const PlayPurchase(
          productId: 'premium',
          purchaseToken: 'pending-fixture',
          state: 'pending',
          obfuscatedAccountId: 'owner-fixture',
          acknowledged: false,
        ),
      ];
      h.api.onRestore = (_, credential) async {
        expect(h.store.pendingCredential, credential);
        return GuestRestoreResult(
          session: _session('guest-token'),
          userId: 'guest-fixture',
          purchaseStatus: 'pending',
          subscription: _inactive,
        );
      };
      await h.controller.initialize();
      await h.controller.restoreGuestPurchases();
      expect(h.api.restoredTokens, <String>['pending-fixture']);
      expect(h.controller.billing.subscription?.hasAccess, isFalse);
      expect(h.controller.billing.purchaseAllowed, isFalse);
      expect(h.gateway.openedOwners, isEmpty);
      expect(h.controller.profile?.isGuest, isTrue);
    },
  );

  test(
    'registered-owner restoration refusal preserves the cached session and credentials without fallback',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      final cachedSession = _session('cached-token');
      h.store.storedSession = cachedSession;
      h.store.credential = _credential;
      h.store.deviceIds['guest-fixture'] = 'device-fixture';
      h.tunnel.state = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      h.api.onMe = (_) async => throw const ApiNetworkException();
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.onRestore = (_, credential) async {
        expect(h.store.pendingCredential, _credential);
        expect(credential, _credential);
        throw const ApiException(
          statusCode: 409,
          errorCode: 'account_login_required',
        );
      };
      await h.controller.initialize();
      h.store.sessionWrites.clear();
      await h.controller.restoreGuestPurchases();
      expect(h.api.restoredTokens, <String>['purchase-fixture']);
      expect(h.api.restoredCredentials, <String>[_credential]);
      expect(h.controller.token, 'cached-token');
      expect(h.store.storedSession, same(cachedSession));
      expect(h.controller.isSignedIn, isFalse);
      expect(h.store.credential, _credential);
      expect(h.store.pendingCredential, _credential);
      expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      expect(h.tunnel.state.phase, VpnRuntimePhase.connected);
      expect(h.tunnel.wireGuardKeys['guest-fixture'], _wireGuardPublicKey);
      expect(h.gateway.openedOwners, isEmpty);
      expect(h.controller.guestMessageKey, 'guest.loginRequired');
    },
  );

  test(
    'signed-in receipt verification conflict does not wipe premium rights or the connected guest',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.verifyFailure = const ApiException(
        statusCode: 409,
        errorCode: 'google_play_account_mismatch',
      );
      await h.controller.restoreGuestPurchases();
      expect(h.api.verifiedTokens, <String>['purchase-fixture']);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.controller.billing.subscription?.hasAccess, isTrue);
      expect(h.store.credential, _credential);
      expect(h.store.clearCalls, 0);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      expect(h.gateway.openedOwners, isEmpty);
    },
  );

  test(
    'confirmed voluntary logout disables automatic guest recovery and retains its credential',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.events.clear();
      await h.controller.signOut();
      expect(h.events, contains('store.clearSession'));
      expect(h.store.autoResume, isFalse);
      expect(h.store.credential, _credential);
      expect(h.controller.isSignedIn, isFalse);
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, isEmpty);
      expect(h.controller.isSignedIn, isFalse);
    },
  );

  test(
    'a rejected separate login preserves the subscribed guest and connected VPN',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onLogin = (_, _) async => throw const ApiException(
        statusCode: 401,
        errorCode: 'invalid_credentials',
      );
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'incorrect-fixture',
        ),
        isFalse,
      );
      _expectSeparateLoginPreservedGuest(h);
      expect(h.api.loginCalls, 1);
      expect(h.api.meTokens, isNot(contains('registered-token')));
      expect(h.controller.notice, isNotNull);
      expect(h.controller.isAuthenticating, isFalse);
    },
  );

  test(
    'a refused candidate profile preserves the subscribed guest and connected VPN',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.api.onMe = (token) async {
        if (token == 'registered-token') {
          throw const ApiException(statusCode: 403, errorCode: 'forbidden');
        }
        return h.api.profiles[token]!;
      };
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      _expectSeparateLoginPreservedGuest(h);
      expect(h.api.meTokens, contains('registered-token'));
      expect(h.controller.notice, isNotNull);
    },
  );

  for (final candidate in <UserProfile>[
    _guest(userId: 'registered-fixture'),
    const UserProfile(
      userId: 'registered-fixture',
      profileRedacted: true,
      canManageAccount: false,
    ),
    const UserProfile(userId: 'registered-fixture', canManageAccount: false),
  ]) {
    test(
      'a restricted separate profile preserves the guest (${candidate.identityKind}/${candidate.profileRedacted}/${candidate.canManageAccount})',
      () async {
        final h = await _signedInGuest();
        addTearDown(h.close);
        h.api.profiles['registered-token'] = candidate;
        expect(
          await h.controller.signIn(
            email: 'existing@example.test',
            password: 'fixture-password',
          ),
          isFalse,
        );
        _expectSeparateLoginPreservedGuest(h);
      },
    );
  }

  test(
    'a proven separate account replaces the guest without claiming or transferring its purchase and device',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final ownedQueries = h.gateway.ownedQueries;
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.controller.profile?.userId, 'registered-fixture');
      expect(h.controller.profile?.isGuest, isFalse);
      expect(h.controller.token, 'registered-token');
      expect(h.store.storedSession?.accessToken, 'registered-token');
      expect(h.controller.currentDeviceId, isNull);
      expect(h.store.sessionWrites, <String?>[null, 'registered-fixture']);
      expect(h.store.autoResume, isFalse);
      expect(h.store.clearCalls, 1);
      expect(h.tunnel.disconnectCalls, 1);
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
      expect(h.api.logoutTokens, <String>['guest-token']);
      expect(
        h.events.indexOf('api.me:registered-token'),
        lessThan(h.events.indexOf('store.clearSession')),
      );
      expect(h.store.credential, _credential);
      expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
      expect(h.store.deviceIds.containsKey('registered-fixture'), isFalse);
      expect(h.tunnel.wireGuardKeys['guest-fixture'], _wireGuardPublicKey);
      expect(h.tunnel.wireGuardKeys.containsKey('registered-fixture'), isFalse);
      expect(h.tunnel.clearedIdentities, isEmpty);
      expect(h.api.claimCalls, 0);
      expect(h.api.restoredTokens, isEmpty);
      expect(h.api.verifiedTokens, isEmpty);
      expect(h.api.registeredKeys, isEmpty);
      expect(h.store.replacements, isEmpty);
      expect(h.gateway.ownedQueries, ownedQueries);
      expect(h.gateway.openedOwners, isEmpty);
      expect(h.controller.isAuthenticating, isFalse);
    },
  );

  test(
    'separate login remains locked while its candidate session write is pending',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final entered = Completer<void>();
      final reply = Completer<void>();
      h.store.onWrite = (_, userId) async {
        if (userId == null && !entered.isCompleted) {
          entered.complete();
          await reply.future;
        }
      };
      final switching = h.controller.signIn(
        email: 'existing@example.test',
        password: 'fixture-password',
      );
      await entered.future;
      expect(h.controller.isAuthenticating, isTrue);
      expect(h.controller.token, isNull);
      expect(
        await h.controller.signIn(
          email: 'third@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      expect(h.api.loginCalls, 1);
      expect(h.controller.isAuthenticating, isTrue);
      reply.complete();
      expect(await switching, isTrue);
      expect(h.controller.profile?.userId, 'registered-fixture');
      expect(h.store.storedSession?.accessToken, 'registered-token');
      expect(h.controller.isAuthenticating, isFalse);
    },
  );

  test(
    'logout drains a cancelled separate session write before admitting another account',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final entered = Completer<void>();
      final reply = Completer<void>();
      h.store.onWrite = (_, _) {
        entered.complete();
        return reply.future;
      };
      final switching = h.controller.signIn(
        email: 'existing@example.test',
        password: 'fixture-password',
      );
      await entered.future;
      final leaving = h.controller.signOut();
      await Future<void>.value();
      expect(h.controller.sessionTermination?.inProgress, isTrue);
      expect(
        await h.controller.signIn(
          email: 'third@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      reply.complete();
      expect(await switching, isFalse);
      await leaving;
      expect(h.store.storedSession, isNull);
      expect(h.controller.token, isNull);
      expect(h.controller.profile, isNull);
      expect(h.store.clearCalls, 2);
      expect(h.controller.isAuthenticating, isFalse);
      h.store.onWrite = null;
      expect(
        await h.controller.signIn(
          email: 'third@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.store.clearCalls, 2);
      expect(h.controller.isAuthenticating, isFalse);
    },
  );

  test(
    'a reentrant login at guest termination cannot replace the pending candidate',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      Future<bool>? reentrant;
      var triggered = false;
      h.controller.addListener(() {
        if (!triggered &&
            h.controller.token == null &&
            h.controller.sessionTermination == null) {
          triggered = true;
          expect(h.controller.isAuthenticating, isTrue);
          reentrant = h.controller.signIn(
            email: 'third@example.test',
            password: 'fixture-password',
          );
        }
      });
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(triggered, isTrue);
      expect(await reentrant!, isFalse);
      expect(h.api.loginCalls, 1);
      expect(h.controller.profile?.userId, 'registered-fixture');
      expect(h.api.logoutTokens, <String>['guest-token']);
      expect(h.store.clearCalls, 1);
      expect(h.controller.isAuthenticating, isFalse);
    },
  );

  test(
    'registered email login disables retained guest recovery across expiration and restart',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.billing.loadPlans();
      h.api.onCreate = (_) async => throw const ApiNetworkException();
      expect(await h.controller.beginGuestPurchase(_monthly), isFalse);
      expect(h.controller.token, isNull);
      expect(h.store.autoResume, isTrue);
      final retainedCredential = h.store.credential;
      expect(retainedCredential, isNotNull);
      h.api.onCreate = null;
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.controller.profile?.userId, 'registered-fixture');
      expect(h.store.autoResume, isFalse);
      expect(h.store.credential, retainedCredential);

      final expired = _Harness();
      addTearDown(expired.close);
      expired.store.credential = h.store.credential;
      expired.store.autoResume = h.store.autoResume;
      expired.store.storedSession = AuthSession(
        accessToken: 'registered-token',
        expiresAt: DateTime.utc(2000),
      );
      await expired.controller.initialize();
      expect(expired.controller.isSignedIn, isFalse);
      expect(expired.store.storedSession, isNull);
      expect(expired.api.createdCredentials, isEmpty);
      expect(expired.store.autoResume, isFalse);

      final restarted = _Harness();
      addTearDown(restarted.close);
      restarted.store.credential = expired.store.credential;
      restarted.store.autoResume = expired.store.autoResume;
      await restarted.controller.initialize();
      expect(restarted.controller.isSignedIn, isFalse);
      expect(restarted.api.createdCredentials, isEmpty);
      expect(restarted.store.credential, retainedCredential);
    },
  );

  test(
    'registered admission waits for durable guest recovery opt-out and can retry its failure',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = _credential;
      h.store.autoResume = true;
      h.store.autoResumeWriteFailure = const NativeVpnException(
        'secure_storage_write_failed',
      );
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      expect(h.controller.profile, isNull);
      expect(h.controller.canShowHome, isFalse);
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.store.autoResume, isTrue);
      expect(h.store.credential, _credential);
      h.store.autoResumeWriteFailure = null;
      await h.controller.retryAccountRestoration();
      expect(h.controller.profile?.userId, 'registered-fixture');
      expect(h.controller.canShowHome, isTrue);
      expect(h.store.autoResume, isFalse);
      expect(h.store.credential, _credential);
    },
  );

  test(
    'email and registration cannot overlap an automatic guest recovery already in flight',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = _credential;
      h.store.autoResume = true;
      final entered = Completer<void>();
      final reply = Completer<UserProfile>();
      h.api.onMe = (_) async {
        if (!entered.isCompleted) {
          entered.complete();
          return reply.future;
        }
        return _guest();
      };
      final resuming = h.controller.onAppResumed();
      await entered.future;
      expect(h.controller.isGuestActionBusy, isTrue);
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      expect(
        await h.controller.register(
          const RegisterAccountRequest(
            email: 'new@example.test',
            password: 'fixture-password',
            firstName: '',
            lastName: '',
            phone: '',
            addressLine1: '',
            postalCode: '',
            city: '',
            countryCode: 'FR',
            termsAccepted: true,
            privacyAccepted: true,
          ),
        ),
        isFalse,
      );
      expect(h.api.loginCalls, 0);
      expect(h.store.sessionWrites, isEmpty);
      reply.complete(_guest());
      await resuming;
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.isGuestActionBusy, isFalse);
    },
  );

  for (final loginSucceeds in <bool>[true, false]) {
    test(
      'foreground resume during email authentication cannot recover a guest when login succeeds=$loginSucceeds',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        await h.controller.initialize();
        h.store.credential = _credential;
        h.store.autoResume = true;
        final reply = Completer<AuthSession>();
        h.api.onLogin = (_, _) => reply.future;
        final signingIn = h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        );
        await h.controller.onAppResumed();
        expect(h.controller.isAuthenticating, isTrue);
        expect(h.api.createdCredentials, isEmpty);
        if (loginSucceeds) {
          reply.complete(_session('registered-token'));
        } else {
          reply.completeError(const ApiNetworkException());
        }
        expect(await signingIn, loginSucceeds);
        expect(
          h.controller.profile?.userId,
          loginSucceeds ? 'registered-fixture' : null,
        );
        expect(h.api.createdCredentials, isEmpty);
        expect(h.store.credential, _credential);
      },
    );

    for (final resumeBeforeLogin in <bool>[true, false]) {
      test(
        'delayed resume snapshot cannot recover an old guest after email authentication (resume first=$resumeBeforeLogin, succeeds=$loginSucceeds)',
        () async {
          final h = _Harness();
          addTearDown(h.close);
          await h.controller.initialize();
          h.store.credential = _credential;
          h.store.autoResume = true;
          final snapshot = Completer<VpnRuntimeState>();
          final snapshotEntered = Completer<void>();
          h.tunnel.onGetState = () {
            snapshotEntered.complete();
            return snapshot.future;
          };
          final loginReply = Completer<AuthSession>();
          h.api.onLogin = (_, _) => loginReply.future;
          Future<bool> signIn() => h.controller.signIn(
            email: 'existing@example.test',
            password: 'fixture-password',
          );
          final Future<void> resuming;
          final Future<bool> signingIn;
          if (resumeBeforeLogin) {
            resuming = h.controller.onAppResumed();
            await snapshotEntered.future;
            signingIn = signIn();
          } else {
            signingIn = signIn();
            resuming = h.controller.onAppResumed();
            await snapshotEntered.future;
          }
          if (loginSucceeds) {
            loginReply.complete(_session('registered-token'));
          } else {
            loginReply.completeError(const ApiNetworkException());
          }
          expect(await signingIn, loginSucceeds);
          snapshot.complete(h.tunnel.state);
          await resuming;
          expect(h.api.createdCredentials, isEmpty);
          expect(
            h.controller.profile?.userId,
            loginSucceeds ? 'registered-fixture' : null,
          );
          expect(h.store.credential, _credential);
          expect(h.controller.isAuthenticating, isFalse);
        },
      );
    }
  }

  test(
    'a completed password reset invalidates automatic guest recovery from an older resume snapshot',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = _credential;
      h.store.autoResume = true;
      final snapshot = Completer<VpnRuntimeState>();
      final entered = Completer<void>();
      h.tunnel.onGetState = () {
        entered.complete();
        return snapshot.future;
      };
      final resuming = h.controller.onAppResumed();
      await entered.future;
      expect(
        await h.controller.requestPasswordReset('existing@example.test'),
        isTrue,
      );
      expect(h.controller.isAuthenticating, isFalse);
      snapshot.complete(h.tunnel.state);
      await resuming;
      expect(h.api.createdCredentials, isEmpty);
      expect(h.controller.profile, isNull);
      expect(h.controller.notice?.arguments['code'], 'password_reset_sent');
    },
  );

  test(
    'logout detaches an old guest lookup and its late result cannot replace a new email session',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      h.store.credential = _credential;
      h.store.autoResume = true;
      final entered = Completer<void>();
      final reply = Completer<UserProfile>();
      h.api.onMe = (token) async {
        if (token == 'guest-token') {
          entered.complete();
          return reply.future;
        }
        return _separateAccount;
      };
      final resuming = h.controller.onAppResumed();
      await entered.future;
      await h.controller.signOut();
      expect(h.controller.isGuestActionBusy, isFalse);
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      final admittedWrites = h.store.sessionWrites.length;
      reply.complete(_guest());
      await resuming;
      expect(h.controller.profile?.userId, 'registered-fixture');
      expect(h.store.storedSession?.accessToken, 'registered-token');
      expect(h.store.sessionWrites, hasLength(admittedWrites));
      expect(h.store.clearCalls, 1);
      expect(h.controller.isGuestActionBusy, isFalse);
    },
  );

  test(
    'an interrupted first separate-account write clears candidate material and permits another login',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      h.store.onWrite = (session, userId) async {
        expect(session.accessToken, 'registered-token');
        expect(userId, isNull);
        expect(h.store.storedSession, same(session));
        throw const NativeVpnException('secure_storage_write_failed');
      };
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isFalse,
      );
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.token, isNull);
      expect(h.controller.profile, isNull);
      expect(h.store.storedSession, isNull);
      expect(h.store.clearCalls, 2);
      expect(h.tunnel.disconnectCalls, 2);
      expect(h.controller.sessionTermination, isNull);
      expect(h.controller.isAuthenticating, isFalse);
      expect(
        h.controller.notice?.arguments['code'],
        'secure_storage_write_failed',
      );
      expect(h.store.autoResume, isFalse);
      expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
      expect(h.api.claimCalls, 0);
      expect(h.api.restoredTokens, isEmpty);
      h.store.onWrite = null;
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.controller.token, 'registered-token');
      expect(h.controller.profile?.userId, 'registered-fixture');
    },
  );

  test(
    'a late native failure cannot start another cleanup after separate admission loses its session scope',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final entered = Completer<void>();
      final reply = Completer<void>();
      h.store.onWrite = (_, _) {
        entered.complete();
        return reply.future;
      };
      final switching = h.controller.signIn(
        email: 'existing@example.test',
        password: 'fixture-password',
      );
      await entered.future;
      final leaving = h.controller.signOut();
      await Future<void>.value();
      expect(h.controller.sessionTermination?.inProgress, isTrue);
      reply.completeError(
        const NativeVpnException('secure_storage_write_failed'),
      );
      expect(await switching, isFalse);
      await leaving;
      // One cleanup ends the guest; the explicit logout owns the second.
      // The late failed admission must not create a third cleanup.
      expect(h.store.clearCalls, 2);
      expect(h.tunnel.disconnectCalls, 2);
      expect(h.store.storedSession, isNull);
      expect(h.controller.token, isNull);
      expect(h.controller.profile, isNull);
      expect(h.controller.notice, isNull);
      expect(h.controller.sessionTermination, isNull);
      h.store.onWrite = null;
      expect(
        await h.controller.signIn(
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        isTrue,
      );
      expect(h.controller.token, 'registered-token');
      expect(h.store.clearCalls, 2);
    },
  );

  test(
    'an expired guest session resumes with its credential without wiping the device',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.storedSession = AuthSession(
        accessToken: 'expired-token',
        expiresAt: DateTime.utc(2020),
      );
      h.store.credential = _credential;
      h.store.autoResume = true;
      h.store.deviceIds['guest-fixture'] = 'device-fixture';
      await h.controller.initialize();
      expect(h.api.createdCredentials, <String>[_credential]);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      expect(h.tunnel.disconnectCalls, 0);
    },
  );

  test(
    'automatic recovery remains disabled across restart after voluntary logout',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.credential = _credential;
      h.store.autoResume = false;
      await h.controller.initialize();
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, isEmpty);
      expect(h.controller.isSignedIn, isFalse);
      expect(h.store.credential, _credential);
    },
  );

  test(
    'a late 401 from the old token cannot terminate the renewed guest session',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final oldEntered = Completer<void>();
      final oldResult = Completer<DeviceList>();
      h.api.onDevices = (token) {
        if (token == 'guest-token') {
          if (!oldEntered.isCompleted) oldEntered.complete();
          return oldResult.future;
        }
        return Future<DeviceList>.value(
          const DeviceList(limit: 2, devices: <VpnDevice>[]),
        );
      };
      final oldRefresh = h.controller.refreshDevices();
      await oldEntered.future;
      h.api.onMe = (token) async {
        if (token == 'guest-token') {
          throw const ApiException(statusCode: 401, errorCode: 'unauthorized');
        }
        return _guest();
      };
      h.api.onCreate = (_) async => GuestSessionResult(
        session: _session('renewed-token'),
        userId: 'guest-fixture',
      );
      await h.controller.refreshGuestAccount();
      expect(h.controller.token, 'renewed-token');
      oldResult.completeError(
        const ApiException(statusCode: 401, errorCode: 'unauthorized'),
      );
      await oldRefresh;
      expect(h.controller.token, 'renewed-token');
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.store.replacements, <String>['renewed-token']);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
    },
  );

  test(
    'concurrent 401 responses share one renewal and preserve the live guest tunnel',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      final requests = <Completer<DeviceList>>[];
      final bothEntered = Completer<void>();
      h.api.onDevices = (token) {
        expect(token, 'guest-token');
        final response = Completer<DeviceList>();
        requests.add(response);
        if (requests.length == 2) bothEntered.complete();
        return response.future;
      };
      final first = h.controller.refreshDevices();
      final second = h.controller.refreshDevices();
      await bothEntered.future;
      final renewalEntered = Completer<void>();
      final renewalResponse = Completer<GuestSessionResult>();
      h.api.onCreate = (_) {
        if (!renewalEntered.isCompleted) renewalEntered.complete();
        return renewalResponse.future;
      };
      for (final request in requests) {
        request.completeError(
          const ApiException(statusCode: 401, errorCode: 'unauthorized'),
        );
      }
      await renewalEntered.future;
      // Keep HTTP pending long enough for both independent API failures to join
      // the same renewal, rather than letting a fast first response hide a race.
      await Future<void>.delayed(Duration.zero);
      expect(h.api.createdCredentials, <String>[_credential]);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
      renewalResponse.complete(
        GuestSessionResult(
          session: _session('renewed-token'),
          userId: 'guest-fixture',
        ),
      );
      await Future.wait(<Future<void>>[first, second]);
      expect(h.controller.token, 'renewed-token');
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
      expect(h.store.replacements, <String>['renewed-token']);
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
    },
  );

  test(
    'explicit Continue can reopen the retained guest after voluntary logout',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      await h.controller.signOut();
      expect(h.store.autoResume, isFalse);
      expect(h.controller.isSignedIn, isFalse);
      h.api.subscription = _inactive;
      await h.controller.billing.loadPlans();
      expect(await h.controller.beginGuestPurchase(_monthly), isTrue);
      expect(h.api.createdCredentials, <String>[_credential]);
      expect(h.store.credential, _credential);
      expect(h.store.autoResume, isTrue);
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.token, 'guest-token');
      expect(h.gateway.openedOwners, <String>['owner-fixture']);
      expect(h.store.clearCalls, 1);
      expect(h.tunnel.clearedIdentities, isEmpty);
    },
  );

  test(
    'restoration after logout reuses the same guest credential device and WireGuard key',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      await h.controller.signOut();
      expect(h.store.pendingCredential, isNull);
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.subscription = _active;
      String? recoveredCredential;
      h.api.onRestore = (_, credential) async {
        recoveredCredential = credential;
        expect(h.store.pendingCredential, credential);
        expect(credential, _credential);
        expect(h.store.credential, _credential);
        expect(
          h.events.indexOf('store.pending'),
          lessThan(h.events.indexOf('api.restore')),
        );
        return GuestRestoreResult(
          session: _session('restored-token'),
          userId: 'guest-fixture',
          purchaseStatus: 'verified',
          subscription: _active,
        );
      };
      h.api.onDevices = (_) async =>
          const DeviceList(limit: 2, devices: <VpnDevice>[_device]);
      h.api.onRegister = (token, publicKey) async {
        expect(token, 'restored-token');
        expect(recoveredCredential, _credential);
        expect(publicKey, _wireGuardPublicKey);
        return _deviceConfiguration;
      };
      expect(await h.controller.restoreGuestPurchases(), isTrue);
      expect(recoveredCredential, _credential);
      expect(h.api.restoredCredentials, <String>[_credential]);
      expect(h.store.credential, _credential);
      expect(h.store.pendingCredential, isNull);
      expect(h.store.autoResume, isTrue);
      expect(h.controller.token, 'restored-token');
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.controller.billing.subscription?.hasAccess, isTrue);
      expect(h.store.clearCalls, 1);
      expect(h.gateway.openedOwners, isEmpty);
      expect(h.tunnel.clearedIdentities, isEmpty);
      await h.controller.connect();
      expect(h.api.registeredKeys, <String>[_wireGuardPublicKey]);
      expect(h.tunnel.connectedDeviceIds, <String>['device-fixture']);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.tunnel.wireGuardKeys['guest-fixture'], _wireGuardPublicKey);
      expect(h.tunnel.keyCreations, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
    },
  );

  test(
    'an explicit credential ownership conflict persists a fresh pending value before its one retry',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.credential = _credential;
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.profiles['other-guest-token'] = _guest(
        userId: 'other-guest-fixture',
      );
      String? retryCredential;
      h.api.onRestore = (_, credential) async {
        expect(h.store.credential, _credential);
        expect(h.store.pendingCredential, credential);
        if (h.api.restoredCredentials.length == 1) {
          expect(credential, _credential);
          throw const ApiException(
            statusCode: 409,
            errorCode: 'guest_credential_conflict',
          );
        }
        retryCredential = credential;
        expect(credential, isNot(_credential));
        expect(base64Url.decode('$credential='), hasLength(32));
        expect(
          h.events.lastIndexOf('store.pending'),
          lessThan(h.events.lastIndexOf('api.restore')),
        );
        expect(h.store.sessionWrites, isEmpty);
        return GuestRestoreResult(
          session: _session('other-guest-token'),
          userId: 'other-guest-fixture',
          purchaseStatus: 'verified',
          subscription: _active,
        );
      };
      await h.controller.initialize();
      expect(await h.controller.restoreGuestPurchases(), isTrue);
      expect(h.api.restoredTokens, <String>[
        'purchase-fixture',
        'purchase-fixture',
      ]);
      expect(h.api.restoredCredentials, <String>[
        _credential,
        retryCredential!,
      ]);
      expect(h.store.credential, retryCredential);
      expect(h.store.pendingCredential, isNull);
      expect(h.controller.profile?.userId, 'other-guest-fixture');
      expect(h.controller.token, 'other-guest-token');
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      expect(h.tunnel.wireGuardKeys['guest-fixture'], _wireGuardPublicKey);
    },
  );

  test(
    'a second credential conflict does not rotate again or loop restoration',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.credential = _credential;
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.onRestore = (_, credential) async {
        expect(h.store.pendingCredential, credential);
        expect(h.store.credential, _credential);
        throw const ApiException(
          statusCode: 409,
          errorCode: 'guest_credential_conflict',
        );
      };
      await h.controller.initialize();
      expect(await h.controller.restoreGuestPurchases(), isFalse);
      expect(h.api.restoredCredentials, hasLength(2));
      expect(h.api.restoredCredentials.first, _credential);
      expect(h.api.restoredCredentials.last, isNot(_credential));
      expect(h.store.pendingCredential, h.api.restoredCredentials.last);
      expect(h.store.credential, _credential);
      expect(h.events.where((event) => event == 'store.pending'), hasLength(2));
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.clearCalls, 0);
      expect(h.controller.profile, isNull);
      expect(h.controller.guestMessageKey, 'guest.restoreError');
    },
  );

  testWidgets(
    'a restore 503 keeps the credential pair and retries the same owner after its delay',
    (tester) async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.credential = _credential;
      h.store.deviceIds['guest-fixture'] = 'device-fixture';
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.onRestore = (_, credential) async {
        expect(credential, _credential);
        expect(h.store.credential, _credential);
        expect(h.store.pendingCredential, _credential);
        if (h.api.restoredCredentials.length == 1) {
          throw const ApiException(
            statusCode: 503,
            errorCode: 'google_play_unavailable',
            retryAfterSeconds: 1,
          );
        }
        return GuestRestoreResult(
          session: _session('restored-token'),
          userId: 'guest-fixture',
          purchaseStatus: 'verified',
          subscription: _active,
        );
      };
      await h.controller.initialize();
      expect(await h.controller.restoreGuestPurchases(), isFalse);
      expect(h.api.restoredCredentials, <String>[_credential]);
      expect(h.store.pendingCredential, _credential);
      expect(h.store.credential, _credential);
      expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
      expect(h.tunnel.wireGuardKeys['guest-fixture'], _wireGuardPublicKey);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.clearCalls, 0);
      expect(h.controller.guestMessageKey, 'guest.serviceUnavailable');
      expect(await h.controller.restoreGuestPurchases(), isFalse);
      expect(h.api.restoredCredentials, hasLength(1));
      await tester.pump(const Duration(seconds: 1));
      expect(await h.controller.restoreGuestPurchases(), isTrue);
      expect(h.api.restoredCredentials, <String>[_credential, _credential]);
      expect(h.events.where((event) => event == 'store.pending'), hasLength(1));
      expect(h.store.credential, _credential);
      expect(h.store.pendingCredential, isNull);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      await h.close();
    },
  );

  test(
    'an existing pending restore credential is reused instead of the active credential',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      final pending = base64Url
          .encode(List<int>.filled(32, 7))
          .replaceAll('=', '');
      h.store.credential = _credential;
      h.store.pendingCredential = pending;
      h.gateway.owned = <PlayPurchase>[_purchase];
      h.api.onRestore = (_, credential) async {
        expect(credential, pending);
        expect(h.store.pendingCredential, pending);
        expect(h.store.credential, _credential);
        throw const ApiNetworkException();
      };
      await h.controller.initialize();
      expect(await h.controller.restoreGuestPurchases(), isFalse);
      expect(await h.controller.restoreGuestPurchases(), isFalse);
      expect(h.api.restoredCredentials, <String>[pending, pending]);
      expect(h.store.pendingCredential, pending);
      expect(h.store.credential, _credential);
      expect(h.events.where((event) => event == 'store.pending'), isEmpty);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.store.clearCalls, 0);
    },
  );

  testWidgets(
    'startup 503 retains recovery and device material while withholding a usable account until retry',
    (tester) async {
      final h = _Harness();
      addTearDown(h.close);
      final expired = AuthSession(
        accessToken: 'expired-token',
        expiresAt: DateTime.utc(2020),
      );
      h.store.storedSession = expired;
      h.store.credential = _credential;
      h.store.autoResume = true;
      h.store.deviceIds['guest-fixture'] = 'device-fixture';
      h.tunnel.state = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      h.api.onCreate = (_) async => throw const ApiException(
        statusCode: 503,
        errorCode: 'google_play_unavailable',
        retryAfterSeconds: 1,
      );
      await h.controller.initialize();
      expect(h.store.storedSession, same(expired));
      expect(h.store.credential, _credential);
      expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.store.replacements, isEmpty);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.controller.profile, isNull);
      expect(h.controller.isSignedIn, isFalse);
      expect(h.controller.billing.subscription?.hasAccess == true, isFalse);
      expect(h.controller.guestMessageKey, 'guest.serviceUnavailable');
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, hasLength(1));
      await tester.pump(const Duration(seconds: 1));
      h.api.onCreate = (_) async => GuestSessionResult(
        session: _session('recovered-token'),
        userId: 'guest-fixture',
      );
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, <String>[_credential, _credential]);
      expect(h.controller.token, 'recovered-token');
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.store.replacements, <String>['recovered-token']);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      await h.close();
    },
  );

  testWidgets(
    'startup 503 api_error with Retry-After defers resume and keeps session, device and tunnel',
    (tester) async {
      // A04-transport-01: ApiClient keeps the status and Retry-After of a 5xx
      // whose body is not UTF-8, not valid gzip or above 1 MiB, as this
      // generic api_error. It is a temporary unavailability, never an end.
      final h = _Harness();
      addTearDown(h.close);
      final expired = AuthSession(
        accessToken: 'expired-token',
        expiresAt: DateTime.utc(2020),
      );
      h.store.storedSession = expired;
      h.store.credential = _credential;
      h.store.autoResume = true;
      h.store.deviceIds['guest-fixture'] = 'device-fixture';
      h.tunnel.state = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      h.api.onCreate = (_) async => throw const ApiException(
        statusCode: 503,
        errorCode: 'api_error',
        retryAfterSeconds: 30,
      );
      await h.controller.initialize();
      expect(h.store.storedSession, same(expired));
      expect(h.store.credential, _credential);
      expect(h.store.autoResume, isTrue);
      expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.store.replacements, isEmpty);
      expect(h.store.sessionWrites, isEmpty);
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      expect(h.controller.guestMessageKey, 'guest.serviceUnavailable');
      expect(h.controller.isGuestActionBusy, isTrue);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);

      // The server's delay is honoured: no new request before 30 seconds.
      await tester.pump(const Duration(seconds: 29));
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, hasLength(1));
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      await tester.pump(const Duration(seconds: 1));
      expect(h.controller.isGuestActionBusy, isFalse);
      h.api.onCreate = (_) async => GuestSessionResult(
        session: _session('recovered-token'),
        userId: 'guest-fixture',
      );
      await h.controller.onAppResumed();
      expect(h.api.createdCredentials, <String>[_credential, _credential]);
      expect(h.controller.token, 'recovered-token');
      expect(h.controller.profile?.isGuest, isTrue);
      expect(h.controller.currentDeviceId, 'device-fixture');
      expect(h.store.clearCalls, 0);
      expect(h.store.replacements, <String>['recovered-token']);
      expect(h.tunnel.disconnectCalls, 0);
      expect(h.tunnel.clearedIdentities, isEmpty);
      await h.close();
    },
  );

  testWidgets(
    'disposing during provider Retry-After cancels its pending timer',
    (tester) async {
      final h = _Harness();
      addTearDown(h.close);
      await h.controller.initialize();
      await h.controller.billing.loadPlans();
      h.api.onCreate = (_) async => throw const ApiException(
        statusCode: 503,
        errorCode: 'google_play_unavailable',
        retryAfterSeconds: 60,
      );
      await h.controller.beginGuestPurchase(_monthly);
      expect(h.controller.isGuestActionBusy, isTrue);
      expect(h.controller.guestMessageKey, 'guest.serviceUnavailable');
      expect(h.api.createdCredentials, hasLength(1));
      await h.close();
      await tester.pump();
      expect(tester.takeException(), isNull);
      // Flutter's test binding additionally rejects any uncancelled timer at
      // test completion, before the sixty-second deadline can hide the leak.
    },
  );
}

Future<_Harness> _signedInGuest() async {
  final h = _Harness();
  h.store.storedSession = _session('guest-token');
  h.store.credential = _credential;
  h.store.autoResume = true;
  h.store.deviceIds['guest-fixture'] = 'device-fixture';
  h.tunnel.state = const VpnRuntimeState(
    phase: VpnRuntimePhase.connected,
    protocol: VpnProtocol.wireGuard,
  );
  h.api.subscription = _active;
  await h.controller.initialize();
  await h.controller.billing.refreshSubscription();
  expect(h.controller.isSignedIn, isTrue);
  h.store.sessionWrites.clear();
  h.events.clear();
  return h;
}

void _expectSeparateLoginPreservedGuest(_Harness h) {
  expect(h.controller.profile?.isGuest, isTrue);
  expect(h.controller.profile?.userId, 'guest-fixture');
  expect(h.controller.token, 'guest-token');
  expect(h.store.storedSession?.accessToken, 'guest-token');
  expect(h.controller.currentDeviceId, 'device-fixture');
  expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
  expect(h.controller.billing.subscription?.hasAccess, isTrue);
  expect(h.store.autoResume, isTrue);
  expect(h.store.credential, _credential);
  expect(h.store.deviceIds['guest-fixture'], 'device-fixture');
  expect(h.tunnel.wireGuardKeys['guest-fixture'], _wireGuardPublicKey);
  expect(h.store.sessionWrites, isEmpty);
  expect(h.store.replacements, isEmpty);
  expect(h.store.clearCalls, 0);
  expect(h.tunnel.disconnectCalls, 0);
  expect(h.tunnel.clearedIdentities, isEmpty);
  expect(h.api.logoutTokens, isEmpty);
  expect(h.api.claimCalls, 0);
  expect(h.api.restoredTokens, isEmpty);
  expect(h.api.verifiedTokens, isEmpty);
  expect(h.gateway.openedOwners, isEmpty);
}

class _Harness {
  _Harness() {
    store = _Store(events, tunnel);
    api = _Api(events);
    controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: _Preferences(),
      tunnel: tunnel,
      billingGateway: gateway,
      billingApi: api,
    );
  }
  final events = <String>[];
  final tunnel = _Tunnel();
  final gateway = _Gateway();
  late final _Store store;
  late final _Api api;
  late final VpnAppController controller;
  bool _closed = false;
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    controller.dispose();
    await tunnel.close();
  }
}

class _Api extends Fake
    implements VpnApiRepository, GuestApiRepository, BillingApiRepository {
  _Api(this.events);
  final List<String> events;
  final createdCredentials = <String>[];
  final restoredTokens = <String>[];
  final restoredCredentials = <String>[];
  final registeredKeys = <String>[];
  final createConsents = <(bool, bool)>[];
  final billingContextTokens = <String>[];
  final meTokens = <String>[];
  final verifiedTokens = <String>[];
  final logoutTokens = <String>[];
  final profiles = <String, UserProfile>{
    'guest-token': _guest(),
    'registered-token': _separateAccount,
  };
  int resetCalls = 0;
  Future<void> Function()? onReset;
  int loginCalls = 0;
  int claimCalls = 0;
  BillingSubscription subscription = _inactive;
  Future<GuestSessionResult> Function(String)? onCreate;
  Future<GuestRestoreResult> Function(String, String)? onRestore;
  Future<GuestClaimResult> Function(String, String, String)? onClaim;
  Future<UserProfile> Function(String)? onMe;
  Future<DeviceList> Function(String)? onDevices;
  Future<DeviceConfiguration> Function(String, String)? onRegister;
  Future<AuthSession> Function(String, String)? onLogin;
  Object? verifyFailure;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    return onLogin != null
        ? await onLogin!(email, password)
        : _session('registered-token');
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    resetCalls++;
    if (onReset != null) await onReset!();
  }

  @override
  Future<GuestSessionResult> createGuestSession({
    required String guestCredential,
    bool termsAccepted = false,
    bool privacyAccepted = false,
  }) async {
    events.add('api.create');
    createdCredentials.add(guestCredential);
    createConsents.add((termsAccepted, privacyAccepted));
    return onCreate != null
        ? await onCreate!(guestCredential)
        : GuestSessionResult(
            session: _session('guest-token'),
            userId: 'guest-fixture',
          );
  }

  @override
  Future<GuestRestoreResult> restoreGuestSession({
    required String purchaseToken,
    required String guestCredential,
  }) async {
    events.add('api.restore');
    restoredTokens.add(purchaseToken);
    restoredCredentials.add(guestCredential);
    return onRestore != null
        ? await onRestore!(purchaseToken, guestCredential)
        : GuestRestoreResult(
            session: _session('guest-token'),
            userId: 'guest-fixture',
            purchaseStatus: 'verified',
            subscription: subscription,
          );
  }

  @override
  Future<GuestClaimResult> claimGuestAccount({
    required String token,
    required String email,
    required String password,
  }) async {
    claimCalls++;
    return onClaim != null
        ? await onClaim!(token, email, password)
        : const GuestClaimResult(
            emailVerified: false,
            verificationEmailSent: true,
          );
  }

  @override
  Future<UserProfile> me(String token) async {
    events.add('api.me:$token');
    meTokens.add(token);
    return onMe != null ? await onMe!(token) : profiles[token] ?? _guest();
  }

  @override
  Future<List<Location>> locations() async => const <Location>[_location];
  @override
  Future<DeviceList> listDevices(String token) async => onDevices != null
      ? await onDevices!(token)
      : const DeviceList(limit: 2, devices: <VpnDevice>[]);
  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    registeredKeys.add(publicKey);
    return onRegister != null
        ? await onRegister!(token, publicKey)
        : _deviceConfiguration;
  }

  @override
  Future<void> logout(String token) async {
    logoutTokens.add(token);
    events.add('api.logout');
  }

  @override
  Future<BillingSubscription> getSubscription(String token) async =>
      subscription;
  @override
  Future<BillingPurchaseContext> getPurchaseContext(String token) async {
    billingContextTokens.add(token);
    return BillingPurchaseContext(
      obfuscatedAccountId: 'owner-fixture',
      purchaseAllowed: !subscription.hasAccess,
    );
  }

  @override
  Future<BillingVerification> verifyPurchase({
    required String token,
    required String purchaseToken,
  }) async {
    verifiedTokens.add(purchaseToken);
    if (verifyFailure != null) throw verifyFailure!;
    return BillingVerification(
      purchaseStatus: 'verified',
      subscription: subscription,
    );
  }
}

class _Store extends Fake
    implements
        SecureSessionStore,
        GuestCredentialStore,
        GuestSessionRenewalStore {
  _Store(this.events, this.tunnel);
  final List<String> events;
  final _Tunnel tunnel;
  AuthSession? storedSession;
  String? credential, pendingCredential;
  bool autoResume = false;
  int clearCalls = 0;
  final deviceIds = <String, String>{};
  final sessionWrites = <String?>[];
  final replacements = <String>[];
  Future<void> Function(AuthSession, String?)? onWrite;
  Future<void> Function()? onReplace;
  Object? autoResumeWriteFailure;
  @override
  Future<AuthSession?> readSession() async => storedSession;
  @override
  Future<void> writeSession(AuthSession session, {String? userId}) async {
    storedSession = session;
    sessionWrites.add(userId);
    if (onWrite != null) await onWrite!(session, userId);
  }

  @override
  Future<void> replaceGuestSession(
    AuthSession session, {
    required String userId,
  }) async {
    replacements.add(session.accessToken);
    storedSession = session;
    if (onReplace != null) await onReplace!();
  }

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    events.add('store.clearSession');
    clearCalls++;
    storedSession = null;
    if (!expired) autoResume = false;
    await tunnel.disconnect();
    return SessionTerminationResult(
      tunnelStopped: true,
      sessionCleared: true,
      sessionExpired: expired,
    );
  }

  @override
  Future<String?> readGuestCredential() async => credential;
  @override
  Future<void> writeGuestCredential(String value) async {
    events.add('store.promote');
    credential = value;
    pendingCredential = null;
  }

  @override
  Future<String?> readPendingGuestCredential() async => pendingCredential;
  @override
  Future<void> writePendingGuestCredential(String value) async {
    events.add('store.pending');
    pendingCredential = value;
  }

  @override
  Future<void> clearGuestCredentials() async {
    credential = pendingCredential = null;
    autoResume = false;
  }

  @override
  Future<bool> readGuestAutoResume() async => autoResume;
  @override
  Future<void> writeGuestAutoResume(bool enabled) async {
    events.add('store.auto:$enabled');
    if (autoResumeWriteFailure != null) throw autoResumeWriteFailure!;
    autoResume = enabled;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async =>
      deviceIds[userId];
  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async => deviceIds[userId] = deviceId;
  @override
  Future<void> clearCurrentDeviceId({required String userId}) async =>
      deviceIds.remove(userId);
  @override
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  }) async => null;
}

class _Tunnel extends Fake implements VpnTunnelGateway {
  final _states = StreamController<VpnRuntimeState>.broadcast();
  VpnRuntimeState state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  int disconnectCalls = 0;
  final clearedIdentities = <String>[];
  final wireGuardKeys = <String, String>{'guest-fixture': _wireGuardPublicKey};
  final connectedDeviceIds = <String>[];
  int keyCreations = 0;
  Future<VpnRuntimeState> Function()? onGetState;
  @override
  Stream<VpnRuntimeState> get states => _states.stream;
  @override
  Future<VpnRuntimeState> getState() async =>
      onGetState == null ? state : await onGetState!();
  @override
  Future<bool> requestVpnPermission() async => true;
  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async {
    return wireGuardKeys.putIfAbsent(accountId, () {
      keyCreations++;
      return 'AwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM=';
    });
  }

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async {
    connectedDeviceIds.add(configuration.deviceId);
    state = const VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: VpnProtocol.wireGuard,
    );
    _states.add(state);
  }

  @override
  Future<void> disconnect() async {
    disconnectCalls++;
    state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  }

  @override
  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  }) async => null;
  @override
  Future<void> clearAccountIdentity({
    required String accountId,
    required String? expectedDeviceId,
  }) async {
    clearedIdentities.add(accountId);
    wireGuardKeys.remove(accountId);
  }

  Future<void> close() => _states.close();
}

class _Preferences extends Fake implements AppPreferenceStore {
  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => null;
  @override
  Future<String?> readSelectedProtocol() async => 'wireguard';
  @override
  Future<String?> readSelectedLocation() async => _location.id;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {}
}

class _Gateway extends Fake
    implements PlayBillingGateway, BillingSessionGateway {
  List<PlayPurchase> owned = const <PlayPurchase>[];
  final openedOwners = <String>[];
  int ownedQueries = 0;
  int accountInvalidations = 0;
  @override
  Future<void> invalidateAccount() async {
    accountInvalidations++;
  }

  @override
  Stream<PlayBillingEvent> get events => const Stream<PlayBillingEvent>.empty();
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async =>
      const <PlaySubscriptionPlan>[_monthly];
  @override
  Future<List<PlayPurchase>> queryOwnedPurchases() async {
    ownedQueries++;
    return owned;
  }

  @override
  Future<void> launchSubscription({
    required PlaySubscriptionPlan plan,
    required String obfuscatedAccountId,
  }) async => openedOwners.add(obfuscatedAccountId);
  @override
  void dispose() {}
}

// Regressions adapted from reaudit-20261028/checks/06; real controller imports.
void _guestAdmissionCorrectionTests() {
  group('guest admission correction 2026-10-28', () {
    test(
      'a partial native write failure is reconciled while authorization is still current',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        await h.controller.initialize();
        h.store.credential = _credential;
        h.store.autoResume = true;
        h.store.onWrite = (_, __) async =>
            throw const NativeVpnException('secure_storage_write_failed');
        await h.controller.onAppResumed();
        expect(h.store.storedSession, isNull);
        expect(h.controller.token, isNull);
        expect(h.controller.profile, isNull);
        expect(h.controller.hasPendingAccountRestoration, isFalse);
        expect(h.store.clearCalls, 1);
        expect(h.store.credential, _credential);
        expect(h.controller.sessionTermination, isNull);
        // Recovery and its message survive the purge (A02-guest-01).
        expect(h.store.autoResume, isTrue);
        expect(h.controller.guestMessageKey, 'guest.secureStorageError');
        h.store.onWrite = null;
        expect(
          await h.controller.signIn(
            email: 'existing@example.test',
            password: 'fixture',
          ),
          isTrue,
        );
        expect(h.controller.token, 'registered-token');
        expect(h.store.storedSession?.accessToken, 'registered-token');
      },
    );

    test(
      'logout owns cleanup of a late failed guest write before a newer admission',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        await h.controller.initialize();
        h.store.credential = _credential;
        h.store.autoResume = true;
        final entered = Completer<void>();
        final release = Completer<void>();
        h.store.onWrite = (_, __) async {
          entered.complete();
          await release.future;
          throw const NativeVpnException('secure_storage_write_failed');
        };
        final resuming = h.controller.onAppResumed();
        await entered.future;
        final leaving = h.controller.signOut();
        release.complete();
        await leaving;
        await resuming;
        expect(h.store.clearCalls, 1);
        expect(h.store.credential, _credential);
        h.store.onWrite = null;
        expect(
          await h.controller.signIn(
            email: 'existing@example.test',
            password: 'fixture',
          ),
          isTrue,
        );
        expect(h.controller.token, 'registered-token');
        expect(h.store.storedSession?.accessToken, 'registered-token');
        expect(h.store.clearCalls, 1);
      },
    );

    for (final replacingExpired in [false, true]) {
      test(
        'late native write failure after authorization revocation is reconciled (expired=$replacingExpired)',
        () async {
          final h = _Harness();
          addTearDown(h.close);
          if (!replacingExpired) await h.controller.initialize();
          h.store.credential = _credential;
          h.store.autoResume = true;
          final entered = Completer<void>();
          final release = Completer<void>();
          Future<void> lateFailure() async {
            entered.complete();
            await release.future;
            throw const NativeVpnException('secure_storage_write_failed');
          }

          if (replacingExpired) {
            h.store.storedSession = AuthSession(
              accessToken: 'expired-token',
              expiresAt: DateTime.utc(2000),
            );
            h.store.onReplace = lateFailure;
          } else {
            h.store.onWrite = (_, __) => lateFailure();
          }
          final recovering = replacingExpired
              ? h.controller.initialize()
              : h.controller.onAppResumed();
          await entered.future;
          h.controller.isAuthenticating = true;
          release.complete();
          await recovering;
          expect(h.store.storedSession, isNull);
          expect(h.controller.token, isNull);
          expect(h.controller.profile, isNull);
          expect(h.controller.hasPendingAccountRestoration, isFalse);
          expect(h.store.clearCalls, 1);
          expect(h.store.credential, _credential);
          // An abandoned automatic admission is not a logout (A02-guest-01).
          expect(h.store.autoResume, isTrue);
          expect(h.controller.sessionTermination, isNull);
        },
      );
    }

    test(
      'an in-flight reset excludes renewal of a near-expiry guest',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        h.store.credential = _credential;
        h.store.autoResume = true;
        h.store.storedSession = AuthSession(
          accessToken: 'guest-token',
          expiresAt: DateTime.now().add(const Duration(minutes: 1)),
        );
        await h.controller.initialize();
        final release = Completer<void>();
        h.api.onReset = () => release.future;
        final resetting = h.controller.requestPasswordReset(
          'existing@example.test',
        );
        await h.controller.connect();
        expect(h.api.createdCredentials, isEmpty);
        expect(h.store.replacements, isEmpty);
        expect(h.controller.isAuthenticating, isTrue);
        release.complete();
        expect(await resetting, isTrue);
        await h.controller.connect();
        expect(h.store.replacements, ['guest-token']);
        expect(h.controller.token, h.store.storedSession?.accessToken);
      },
    );

    test(
      'a reset cannot interrupt an already submitted guest renewal',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        h.store.credential = _credential;
        h.store.autoResume = true;
        h.store.storedSession = AuthSession(
          accessToken: 'guest-token',
          expiresAt: DateTime.now().add(const Duration(minutes: 1)),
        );
        await h.controller.initialize();
        final entered = Completer<void>();
        final release = Completer<void>();
        h.store.onReplace = () {
          entered.complete();
          return release.future;
        };
        final connecting = h.controller.connect();
        await entered.future;
        final reset = await h.controller.requestPasswordReset(
          'existing@example.test',
        );
        release.complete();
        await connecting;
        expect(reset, isFalse);
        expect(h.api.resetCalls, 0);
        expect(h.controller.token, h.store.storedSession?.accessToken);
        expect(h.controller.profile?.userId, 'guest-fixture');
        expect(h.store.clearCalls, 0);
      },
    );

    test(
      'cancelled expired-session replacement clears partial state but preserves recovery',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        h.store.credential = _credential;
        h.store.autoResume = true;
        h.store.storedSession = AuthSession(
          accessToken: 'expired-token',
          expiresAt: DateTime.utc(2000),
        );
        final entered = Completer<void>();
        final release = Completer<void>();
        h.store.onReplace = () {
          entered.complete();
          return release.future;
        };
        final initializing = h.controller.initialize();
        await entered.future;
        h.controller.isAuthenticating = true;
        release.complete();
        await initializing;
        expect(h.store.clearCalls, 1);
        expect(h.store.storedSession, isNull);
        expect(h.controller.token, isNull);
        expect(h.controller.profile, isNull);
        expect(h.controller.hasPendingAccountRestoration, isFalse);
        expect(h.controller.sessionTermination, isNull);
        expect(h.store.credential, _credential);
        expect(h.store.autoResume, isTrue);
      },
    );

    for (final boundary in ['first native write', 'profile restoration']) {
      test(
        'reset is refused during $boundary and guest admission stays coherent',
        () async {
          final h = _Harness();
          addTearDown(h.close);
          await h.controller.initialize();
          h.store.credential = _credential;
          h.store.autoResume = true;
          final entered = Completer<void>();
          final release = Completer<void>();
          if (boundary == 'first native write') {
            h.store.onWrite = (_, __) async {
              if (!entered.isCompleted) {
                entered.complete();
                await release.future;
              }
            };
          } else {
            var reads = 0;
            h.api.onMe = (_) async {
              if (++reads == 2) {
                entered.complete();
                await release.future;
              }
              return _guest();
            };
          }
          final resuming = h.controller.onAppResumed();
          await entered.future;
          final busy = h.controller.isGuestActionBusy;
          final reset = await h.controller.requestPasswordReset(
            'existing@example.test',
          );
          release.complete();
          await resuming;
          expect(busy, isTrue);
          expect(reset, isFalse);
          expect(h.api.resetCalls, 0);
          expect(h.controller.token, 'guest-token');
          expect(h.controller.profile?.userId, 'guest-fixture');
          expect(h.store.storedSession?.accessToken, h.controller.token);
          expect(h.controller.hasPendingAccountRestoration, isFalse);
          expect(h.controller.isGuestActionBusy, isFalse);
          expect(h.controller.isAuthenticating, isFalse);
          expect(h.store.clearCalls, 0);
          expect(
            await h.controller.requestPasswordReset('existing@example.test'),
            isTrue,
          );
          expect(h.api.resetCalls, 1);
        },
      );

      test(
        'revoked authorization after $boundary reconciles its own committed candidate',
        () async {
          final h = _Harness();
          addTearDown(h.close);
          await h.controller.initialize();
          h.store.credential = _credential;
          h.store.autoResume = true;
          final entered = Completer<void>();
          final release = Completer<void>();
          if (boundary == 'first native write') {
            h.store.onWrite = (_, __) async {
              if (!entered.isCompleted) {
                entered.complete();
                await release.future;
              }
            };
          } else {
            var reads = 0;
            h.api.onMe = (_) async {
              if (++reads == 2) {
                entered.complete();
                await release.future;
              }
              return _guest();
            };
          }
          final resuming = h.controller.onAppResumed();
          await entered.future;
          // Revoke admission through the controller's public busy state. This
          // exercises rollback independently of the reset entry guard.
          h.controller.isAuthenticating = true;
          release.complete();
          await resuming;
          expect(h.controller.token, isNull);
          expect(h.controller.profile, isNull);
          expect(h.store.storedSession, isNull);
          expect(h.store.clearCalls, 1);
          expect(h.controller.sessionTermination, isNull);
          expect(h.controller.hasPendingAccountRestoration, isFalse);
          expect(h.controller.isGuestActionBusy, isFalse);
          expect(h.controller.isAuthenticating, isFalse);
          expect(h.store.credential, _credential);
          // Reconciliation purges the candidate but keeps automatic recovery
          // (A02-guest-01, H-RA-A06-01-02).
          expect(h.store.autoResume, isTrue);
          expect(
            await h.controller.signIn(
              email: 'existing@example.test',
              password: 'fixture',
            ),
            isTrue,
          );
          expect(h.controller.token, 'registered-token');
        },
      );
    }

    test(
      'reset already in flight excludes guest recovery until a new resume',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        await h.controller.initialize();
        h.store.credential = _credential;
        h.store.autoResume = true;
        final release = Completer<void>();
        h.api.onReset = () => release.future;
        final resetting = h.controller.requestPasswordReset(
          'existing@example.test',
        );
        await h.controller.onAppResumed();
        expect(h.controller.isAuthenticating, isTrue);
        expect(h.api.createdCredentials, isEmpty);
        expect(h.store.sessionWrites, isEmpty);
        release.complete();
        expect(await resetting, isTrue);
        await h.controller.onAppResumed();
        expect(h.controller.profile?.userId, 'guest-fixture');
        expect(h.store.storedSession?.accessToken, h.controller.token);
      },
    );

    test(
      'logout during a submitted guest write drains before admitting a newer account',
      () async {
        final h = _Harness();
        addTearDown(h.close);
        await h.controller.initialize();
        h.store.credential = _credential;
        h.store.autoResume = true;
        final entered = Completer<void>();
        final release = Completer<void>();
        h.store.onWrite = (_, __) async {
          if (!entered.isCompleted) {
            entered.complete();
            await release.future;
          }
        };
        final resuming = h.controller.onAppResumed();
        await entered.future;
        final leaving = h.controller.signOut();
        expect(h.controller.sessionTermination?.inProgress, isTrue);
        expect(
          await h.controller.signIn(
            email: 'existing@example.test',
            password: 'fixture',
          ),
          isFalse,
        );
        release.complete();
        await leaving;
        await resuming;
        expect(h.store.storedSession, isNull);
        expect(h.store.clearCalls, 1);
        h.store.onWrite = null;
        expect(
          await h.controller.signIn(
            email: 'existing@example.test',
            password: 'fixture',
          ),
          isTrue,
        );
        expect(h.controller.token, 'registered-token');
        expect(h.store.storedSession?.accessToken, 'registered-token');
      },
    );
  });
}

// Passe finale du réaudit (30/10/2026), avec le vrai VpnAppController.
void _reauditFinalGuestTests() {
  test(
    'A01-auth-01 a deferral for the absence of a session never resumes a '
    'guest admitted since without signIn',
    () async {
      final h = _Harness();
      addTearDown(h.close);
      h.store.credential = _credential;
      h.store.autoResume = true;
      var creations = 0;
      h.api.onCreate = (_) async {
        if (++creations == 1) throw const ApiNetworkException();
        return GuestSessionResult(
          session: _session('guest-token'),
          userId: 'guest-fixture',
        );
      };
      var guestReads = 0;
      h.api.onMe = (token) async {
        if (token == 'guest-token' && ++guestReads == 2) {
          throw const ApiNetworkException();
        }
        return h.api.profiles[token] ?? _guest();
      };
      // The startup resume is deferred for the absence of a session.
      await h.controller.initialize();
      expect(h.controller.token, isNull);
      // An explicit purchase admits G without _setSession, so nothing resets
      // that deferral: only its identity binding keeps it away from G.
      await h.controller.beginGuestPurchase(_monthly);
      expect(h.controller.token, 'guest-token');
      expect(h.controller.hasPendingAccountRestoration, isTrue);
      await h.controller.onAppResumed();
      await pumpEventQueue();
      expect(h.api.createdCredentials, hasLength(2));
      expect(h.store.replacements, isEmpty);
      expect(h.controller.token, 'guest-token');
    },
  );

  test(
    'H-R13-01-01 G5 a signed-in guest checkout blocked by an ownerless Play '
    'receipt relays the billing message',
    () async {
      final h = await _signedInGuest();
      addTearDown(h.close);
      expect(h.controller.profile?.isGuest, isTrue);
      // The paywall state when the plan is tapped: no access, plans loaded.
      h.api.subscription = _inactive;
      await h.controller.billing.refreshSubscription();
      await h.controller.billing.loadPlans();
      h.gateway.owned = const <PlayPurchase>[
        PlayPurchase(
          productId: 'premium',
          purchaseToken: 'ownerless-fixture',
          state: 'purchased',
          obfuscatedAccountId: null,
          acknowledged: true,
        ),
      ];
      final launched = await h.controller.beginGuestPurchase(_monthly);
      expect(launched, isFalse);
      expect(
        h.controller.guestMessageKey,
        BillingController.playExistingReceiptMessageKey,
      );
      expect(h.api.verifiedTokens, isEmpty);
      expect(h.api.restoredTokens, isEmpty);
      expect(h.gateway.openedOwners, isEmpty);
      expect(h.controller.billing.canManagePlaySubscription, isTrue);
    },
  );
}
