import 'package:flutter/material.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/billing_controller.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/play_billing.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

Widget welcomeUiTestApp(
  WelcomeUiController controller,
  Widget page, {
  bool dark = false,
}) => MaterialApp(
  debugShowCheckedModeBanner: false,
  locale: controller.locale,
  supportedLocales: AppLanguages.supportedLocales,
  localeListResolutionCallback: AppLanguages.resolve,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: dark ? FuzeVpnTheme.dark() : FuzeVpnTheme.light(),
  home: page,
);

UserProfile guestUiProfile({required bool canUseVpn}) => UserProfile(
  userId: 'guest-fixture',
  identityKind: 'guest',
  profileRedacted: true,
  canManageAccount: false,
  canClaimAccount: true,
  canUseVpn: canUseVpn,
  email: 'hidden@example.invalid',
  firstName: 'Hidden',
);

/// This fake drives only public UI states; controller/API behavior has its own tests.
class WelcomeUiController extends ChangeNotifier implements VpnAppController {
  WelcomeUiController({GoogleAuthController? googleAuth}) {
    this.googleAuth = googleAuth ?? GoogleAuthController();
    billing = BillingController(
      gateway: _CatalogGateway(),
      api: const UnavailableBillingApi(),
      currentAccount: () => null,
    );
  }
  @override
  late final BillingController billing;
  @override
  late final GoogleAuthController googleAuth;
  @override
  UserProfile? profile;
  @override
  Locale? locale = const Locale('fr');
  @override
  AppNotice? notice;
  @override
  bool isGuestActionBusy = false;
  @override
  String? guestMessageKey;
  @override
  bool get isSignedIn => profile != null;
  @override
  bool get isAuthenticating => false;
  int restores = 0, claims = 0;
  bool restoreSucceeds = false;
  String purchaseResultKey = 'billing.success';
  final purchaseRequests = <PlaySubscriptionPlan>[];
  @override
  Future<bool> restoreGuestPurchases() async {
    restores++;
    if (restoreSucceeds) {
      profile = guestUiProfile(canUseVpn: true);
      billing.subscription = const BillingSubscription(
        status: 'active',
        hasAccess: true,
        provider: 'google_play',
      );
      billing.messageKey = 'billing.restored';
      notifyListeners();
      return true;
    }
    guestMessageKey = 'billing.restoreEmpty';
    notifyListeners();
    return false;
  }

  @override
  Future<bool> beginGuestPurchase(PlaySubscriptionPlan plan) async {
    purchaseRequests.add(plan);
    profile = guestUiProfile(canUseVpn: false);
    billing.subscription = const BillingSubscription(
      status: 'active',
      hasAccess: true,
      provider: 'google_play',
    );
    billing.messageKey = purchaseResultKey;
    notifyListeners();
    return true;
  }

  void confirmVpnAccess() {
    profile = guestUiProfile(canUseVpn: true);
    notifyListeners();
  }

  @override
  Future<bool> refreshGuestAccount() async => false;
  @override
  Future<bool> claimGuestAccount({
    required String email,
    required String password,
  }) async {
    claims++;
    guestMessageKey = 'guest.emailExists';
    notifyListeners();
    return false;
  }

  @override
  Future<void> setLocale(Locale? value) async {
    locale = value;
    notifyListeners();
  }

  @override
  void clearNotice() {
    notice = null;
    notifyListeners();
  }

  @override
  void dispose() {
    googleAuth.dispose();
    billing.dispose();
    super.dispose();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CatalogGateway implements PlayBillingGateway {
  @override
  Stream<PlayBillingEvent> get events => const Stream.empty();
  @override
  Future<List<PlaySubscriptionPlan>> queryPlans() async => [
    const PlaySubscriptionPlan(
      productId: 'premium',
      basePlanId: 'monthly',
      offerToken: 'fixture-monthly',
      formattedPrice: '4,79 €',
      currencyCode: 'EUR',
      billingPeriod: 'P1M',
      priceAmountMicros: 4790000,
    ),
    const PlaySubscriptionPlan(
      productId: 'premium',
      basePlanId: 'yearly',
      offerToken: 'fixture-yearly',
      formattedPrice: '37,99 €',
      currencyCode: 'EUR',
      billingPeriod: 'P1Y',
      priceAmountMicros: 37990000,
    ),
  ];
  @override
  void dispose() {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
