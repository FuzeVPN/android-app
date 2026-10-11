import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app_controller.dart';
import '../../app_theme.dart';
import '../../billing_controller.dart';
import '../../core/play_billing.dart';
import '../../l10n/app_copy.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../auth/auth_page.dart';
import '../auth/guest_claim_page.dart';
import 'premium_offer_widgets.dart';

/// Billing listens to its own state, independently of tunnel traffic updates.
class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.controller,
    this.appController,
  });

  final BillingController controller;
  final VpnAppController? appController;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) {
      final subscription = controller.subscription;
      final hasAccess = subscription?.hasAccess ?? false;
      final scheme = Theme.of(context).colorScheme;
      return Card(
        key: const ValueKey('account-subscription'),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const FuzeEyebrow('FuzeVPN'),
              const SizedBox(height: 12),
              Text(
                context.copy(hasAccess ? 'billing.active' : 'billing.title'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                context.copy(
                  controller.isCheckingAccess
                      ? 'billing.checkingAccess'
                      : hasAccess
                      ? _subscriptionManagerKey(subscription)
                      : 'billing.subtitle',
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              if (hasAccess && subscription?.expiresAt != null) ...<Widget>[
                const SizedBox(height: 8),
                Text(
                  context.copy(
                    'billing.accessUntil',
                    arguments: <String, Object?>{
                      'date': _subscriptionDate(
                        context,
                        subscription!.expiresAt!,
                      ),
                    },
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (controller.messageKey != null) ...<Widget>[
                const SizedBox(height: 16),
                _BillingMessage(messageKey: controller.messageKey!),
              ],
              const SizedBox(height: 20),
              if (!hasAccess)
                FilledButton.icon(
                  key: const ValueKey('subscription-open'),
                  onPressed: controller.isBusy
                      ? null
                      : () => appController == null
                            ? _showSubscriptionSelection(context, controller)
                            : Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) => SubscriptionPaywallPage(
                                    controller: appController!,
                                  ),
                                ),
                              ),
                  icon: const Icon(Icons.workspace_premium_outlined),
                  label: Text(
                    context.copy('billing.subscribe'),
                    textAlign: TextAlign.center,
                  ),
                )
              else if (_isGooglePlay(subscription))
                FilledButton.icon(
                  key: const ValueKey('subscription-manage'),
                  onPressed: controller.isBusy
                      ? null
                      : controller.openManagement,
                  icon: const Icon(Icons.open_in_new),
                  label: Text(
                    context.copy('billing.manage'),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  TextButton(
                    key: const ValueKey('subscription-restore'),
                    onPressed: controller.isBusy
                        ? null
                        : controller.restorePurchases,
                    child: Text(
                      context.copy(
                        controller.isRestoring
                            ? 'billing.restoring'
                            : 'billing.restore',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    key: const ValueKey('subscription-refresh'),
                    onPressed: controller.isBusy
                        ? null
                        : controller.refreshSubscription,
                    child: Text(
                      context.copy('billing.refresh'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// A real page can present Play plans before a Fuze identity exists.
class SubscriptionPaywallPage extends StatefulWidget {
  const SubscriptionPaywallPage({super.key, required this.controller});
  final VpnAppController controller;

  @override
  State<SubscriptionPaywallPage> createState() =>
      _SubscriptionPaywallPageState();
}

class _SubscriptionPaywallPageState extends State<SubscriptionPaywallPage> {
  PlaySubscriptionPlan? _selectedOffer;
  bool _purchaseRequested = false;

  @override
  void initState() {
    super.initState();
    widget.controller.billing.addListener(_onBillingChanged);
    unawaited(widget.controller.billing.loadPlans());
  }

  void _onBillingChanged() {
    final billing = widget.controller.billing;
    if (billing.plans.isEmpty ||
        billing.messageKey == 'billing.offerChanged' ||
        !billing.plans.any((plan) => _selectedOffer?.sameOffer(plan) == true)) {
      _selectedOffer = null;
    }
  }

  @override
  void didUpdateWidget(SubscriptionPaywallPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.billing.removeListener(_onBillingChanged);
      widget.controller.billing.addListener(_onBillingChanged);
      _selectedOffer = null;
    }
  }

  @override
  void dispose() {
    widget.controller.billing.removeListener(_onBillingChanged);
    super.dispose();
  }

  Future<void> _purchase(PlaySubscriptionPlan plan) async {
    setState(() => _purchaseRequested = true);
    if (!widget.controller.isSignedIn ||
        widget.controller.profile?.isGuest == true) {
      await widget.controller.beginGuestPurchase(plan);
    } else {
      await widget.controller.billing.purchase(plan);
    }
  }

  Future<void> _restorePurchases() async {
    final controller = widget.controller;
    if (controller.isSignedIn) {
      await controller.billing.restorePurchases();
      return;
    }
    setState(() => _purchaseRequested = false);
    final restored = await controller.restoreGuestPurchases();
    if (!mounted || !restored || controller.profile?.canUseVpn != true) {
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _signIn() => Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) =>
          AuthenticationPage(controller: widget.controller, loginOnly: true),
    ),
  );

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: Listenable.merge([widget.controller, widget.controller.billing]),
    builder: (context, _) {
      final controller = widget.controller;
      final billing = controller.billing;
      final profile = controller.profile;
      final hasAccess = billing.subscription?.hasAccess == true;
      final activated =
          _purchaseRequested &&
          billing.messageKey == 'billing.success' &&
          profile?.isGuest == true &&
          profile?.canUseVpn == true &&
          hasAccess;
      final busy = controller.isGuestActionBusy || billing.isBusy;
      final selected = billing.plans
          .where((plan) => _selectedOffer?.sameOffer(plan) == true)
          .firstOrNull;
      final canPurchase =
          !busy &&
          !hasAccess &&
          selected != null &&
          (!controller.isSignedIn || billing.purchaseAllowed);
      return Scaffold(
        key: const ValueKey('subscription-paywall-page'),
        appBar: AppBar(title: const FuzeBrand(emblemSize: 28)),
        body: SafeArea(
          child: SingleChildScrollView(
            key: const ValueKey('subscription-selection'),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: activated ? 560 : 1120),
                child: activated
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _activation(context),
                      )
                    : PremiumOfferLayout(
                        introduction: PremiumIntroduction(
                          hasTrial: selected != null
                              ? selected.freeTrialDays != null
                              : billing.plans.any(
                                  (plan) => plan.freeTrialDays != null,
                                ),
                          active: hasAccess,
                          showNoAccount:
                              !controller.isSignedIn ||
                              profile?.isGuest == true,
                        ),
                        checkout: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (billing.isLoadingCatalog)
                              _BillingProgress(
                                label: context.copy('billing.loadingPlans'),
                              )
                            else if (!hasAccess)
                              PremiumPlanChoices(
                                plans: billing.plans,
                                selected: selected,
                                onSelected: busy
                                    ? null
                                    : (plan) =>
                                          setState(() => _selectedOffer = plan),
                              ),
                            if (hasAccess && profile?.canUseVpn != true) ...[
                              _BillingMessage(
                                messageKey: 'billing.checkingAccess',
                              ),
                              const SizedBox(height: 12),
                              OutlinedButton.icon(
                                key: const ValueKey(
                                  'subscription-access-refresh',
                                ),
                                onPressed: busy
                                    ? null
                                    : controller.refreshGuestAccount,
                                icon: const Icon(Icons.refresh),
                                label: Text(context.copy('billing.refresh')),
                              ),
                            ],
                            if (controller.guestMessageKey != null) ...[
                              const SizedBox(height: 12),
                              _BillingMessage(
                                messageKey: controller.guestMessageKey!,
                              ),
                            ],
                            if (billing.messageKey != null) ...[
                              const SizedBox(height: 12),
                              _BillingMessage(messageKey: billing.messageKey!),
                            ] else if (!billing.isLoadingCatalog &&
                                !hasAccess &&
                                billing.plans.isEmpty)
                              const _BillingMessage(
                                messageKey: 'billing.unavailable',
                              ),
                            if (!billing.isLoadingCatalog &&
                                !hasAccess &&
                                billing.plans.isEmpty) ...[
                              const SizedBox(height: 12),
                              OutlinedButton.icon(
                                key: const ValueKey('subscription-retry-plans'),
                                onPressed: busy ? null : billing.loadPlans,
                                icon: const Icon(Icons.refresh),
                                label: Text(context.copy('action.retry')),
                              ),
                            ],
                            if (busy && !billing.isLoadingCatalog) ...[
                              const SizedBox(height: 16),
                              _BillingProgress(
                                label: context.copy(
                                  billing.isRestoring
                                      ? 'billing.restoring'
                                      : 'billing.verifying',
                                ),
                              ),
                            ],
                            if (!hasAccess && billing.plans.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              PremiumCheckoutSummary(plan: selected),
                              const SizedBox(height: 16),
                              const PremiumLegalLinks(),
                              const SizedBox(height: 20),
                              FilledButton(
                                key: const ValueKey('subscription-continue'),
                                onPressed: canPurchase
                                    ? () => _purchase(selected)
                                    : null,
                                child: Text(
                                  context.copy(
                                    selected?.freeTrialDays != null
                                        ? 'billing.trialStart'
                                        : 'billing.continue',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            if (hasAccess && profile?.canUseVpn == true) ...[
                              const SizedBox(height: 16),
                              FilledButton(
                                key: const ValueKey('subscription-use-vpn'),
                                onPressed: busy
                                    ? null
                                    : () => Navigator.of(
                                        context,
                                      ).popUntil((route) => route.isFirst),
                                child: Text(
                                  context.copy('guest.useVpn'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            TextButton(
                              key: const ValueKey(
                                'subscription-selection-restore',
                              ),
                              onPressed: busy ? null : _restorePurchases,
                              child: Text(
                                context.copy('billing.restore'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (controller.guestMessageKey ==
                                'guest.loginRequired')
                              OutlinedButton(
                                key: const ValueKey('subscription-sign-in'),
                                onPressed: busy ? null : _signIn,
                                child: Text(
                                  context.copy('action.login'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (hasAccess &&
                                _isGooglePlay(billing.subscription))
                              OutlinedButton(
                                onPressed: busy ? null : billing.openManagement,
                                child: Text(
                                  context.copy('billing.manage'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
    },
  );

  List<Widget> _activation(BuildContext context) => [
    const SizedBox(height: 24),
    Center(
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          color: FuzeVpnTheme.signal,
          shape: BoxShape.circle,
        ),
        child: const FuzeEmblem(size: 72, color: FuzeVpnTheme.ink),
      ),
    ),
    const SizedBox(height: 32),
    FuzePageHeader(
      key: const ValueKey('guest-activation'),
      title: context.copy('guest.activationTitle'),
      description: context.copy('guest.activationDescription'),
    ),
    FilledButton(
      key: const ValueKey('guest-activation-use-vpn'),
      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      child: Text(context.copy('guest.useVpn'), textAlign: TextAlign.center),
    ),
    if (widget.controller.profile?.canClaimAccount == true) ...[
      const SizedBox(height: 12),
      OutlinedButton(
        key: const ValueKey('guest-activation-create-account'),
        onPressed: () => Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => GuestClaimPage(controller: widget.controller),
          ),
        ),
        child: Text(
          context.copy('action.createMyAccount'),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ];
}

bool _isGooglePlay(BillingSubscription? subscription) =>
    subscription?.provider == 'google_play';

String _subscriptionManagerKey(BillingSubscription? subscription) =>
    switch (subscription?.provider) {
      'google_play' => 'billing.playManaged',
      'sumup' => 'billing.webManaged',
      _ => 'billing.active',
    };

String _subscriptionDate(BuildContext context, DateTime date) => DateFormat.yMd(
  Localizations.localeOf(context).toString(),
).format(date.toLocal());

Future<void> _showSubscriptionSelection(
  BuildContext context,
  BillingController controller,
) async {
  controller.syncAccount();
  final revision = controller.accountRevision;
  unawaited(controller.loadPlans());
  final content = _SubscriptionSelection(
    controller: controller,
    accountRevision: revision,
  );
  if (MediaQuery.sizeOf(context).width >= 600) {
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        clipBehavior: Clip.antiAlias,
        insetPadding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 560,
            maxHeight: MediaQuery.sizeOf(context).height * .88,
          ),
          child: content,
        ),
      ),
    );
  } else {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * .9,
        ),
        child: content,
      ),
    );
  }
}

class _SubscriptionSelection extends StatefulWidget {
  const _SubscriptionSelection({
    required this.controller,
    required this.accountRevision,
  });

  final BillingController controller;
  final int accountRevision;

  @override
  State<_SubscriptionSelection> createState() => _SubscriptionSelectionState();
}

class _SubscriptionSelectionState extends State<_SubscriptionSelection> {
  PlaySubscriptionPlan? _selectedOffer;
  bool _closing = false;

  bool get _currentAccount =>
      widget.accountRevision == widget.controller.accountRevision;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onBillingChanged);
  }

  void _onBillingChanged() {
    final controller = widget.controller;
    if (controller.plans.isEmpty ||
        controller.messageKey == 'billing.offerChanged' ||
        !controller.plans.any(
          (plan) => _selectedOffer?.sameOffer(plan) == true,
        )) {
      _selectedOffer = null;
    }
    if (_currentAccount || _closing || !mounted) return;
    _closing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final route = ModalRoute.of(context);
      if (route != null && route.isActive) {
        Navigator.of(context).removeRoute(route);
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onBillingChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final controller = widget.controller;
      final hasAccess = controller.subscription?.hasAccess ?? false;
      final plans = controller.plans;
      final selected = plans
          .where((plan) => _selectedOffer?.sameOffer(plan) == true)
          .firstOrNull;
      final canPurchase =
          _currentAccount &&
          controller.purchaseAllowed &&
          !controller.isBusy &&
          !hasAccess &&
          selected != null;
      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          key: const ValueKey('subscription-selection'),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      context.copy('billing.title'),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    tooltip: context.copy('action.cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              PremiumIntroduction(
                hasTrial: selected != null
                    ? selected.freeTrialDays != null
                    : plans.any((plan) => plan.freeTrialDays != null),
                active: hasAccess,
                compact: true,
              ),
              const SizedBox(height: 20),
              if (controller.isLoadingCatalog)
                _BillingProgress(label: context.copy('billing.loadingPlans'))
              else if (hasAccess)
                _BillingMessage(
                  messageKey: _subscriptionManagerKey(controller.subscription),
                )
              else if (plans.isEmpty && controller.messageKey == null)
                _BillingMessage(
                  messageKey: controller.purchaseAllowed
                      ? 'billing.unavailable'
                      : 'billing.comingSoon',
                )
              else
                PremiumPlanChoices(
                  plans: plans,
                  selected: selected,
                  onSelected: controller.isBusy || !_currentAccount
                      ? null
                      : (plan) => setState(() => _selectedOffer = plan),
                ),
              if (!hasAccess &&
                  !controller.isLoadingCatalog &&
                  plans.isNotEmpty &&
                  !controller.purchaseAllowed &&
                  controller.messageKey == null) ...<Widget>[
                const SizedBox(height: 8),
                const _BillingMessage(messageKey: 'billing.comingSoon'),
              ],
              if (controller.messageKey != null) ...<Widget>[
                const SizedBox(height: 8),
                _BillingMessage(messageKey: controller.messageKey!),
              ],
              if (!controller.isLoadingCatalog &&
                  !hasAccess &&
                  plans.isEmpty &&
                  (controller.catalogLoaded || controller.messageKey != null))
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: OutlinedButton.icon(
                    key: const ValueKey('subscription-retry-plans'),
                    onPressed: controller.isBusy || !_currentAccount
                        ? null
                        : controller.loadPlans,
                    icon: const Icon(Icons.refresh),
                    label: Text(context.copy('action.retry')),
                  ),
                ),
              if (controller.isBusy &&
                  !controller.isLoadingCatalog) ...<Widget>[
                const SizedBox(height: 16),
                _BillingProgress(
                  label: context.copy(
                    controller.isRestoring
                        ? 'billing.restoring'
                        : controller.isCheckingAccess
                        ? 'billing.checkingAccess'
                        : 'billing.verifying',
                  ),
                ),
              ],
              if (!hasAccess && plans.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                PremiumCheckoutSummary(plan: selected),
                const SizedBox(height: 16),
                const PremiumLegalLinks(),
                const SizedBox(height: 20),
                FilledButton(
                  key: const ValueKey('subscription-continue'),
                  onPressed: canPurchase
                      ? () {
                          if (_currentAccount) controller.purchase(selected);
                        }
                      : null,
                  child: Text(
                    context.copy(
                      selected?.freeTrialDays != null
                          ? 'billing.trialStart'
                          : 'billing.continue',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              TextButton(
                key: const ValueKey('subscription-selection-restore'),
                onPressed: controller.isBusy || !_currentAccount
                    ? null
                    : controller.restorePurchases,
                child: Text(
                  context.copy('billing.restore'),
                  textAlign: TextAlign.center,
                ),
              ),
              if (hasAccess && _isGooglePlay(controller.subscription))
                OutlinedButton(
                  onPressed: controller.isBusy || !_currentAccount
                      ? null
                      : controller.openManagement,
                  child: Text(
                    context.copy('billing.manage'),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

class _BillingMessage extends StatelessWidget {
  const _BillingMessage({required this.messageKey});
  final String messageKey;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: FuzePanel(
      tone: FuzePanelTone.wash,
      padding: const EdgeInsets.all(14),
      child: Text(
        context.copy(messageKey),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}

class _BillingProgress extends StatelessWidget {
  const _BillingProgress({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
      ],
    ),
  );
}
