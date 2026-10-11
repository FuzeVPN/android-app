// SPDX-License-Identifier: MPL-2.0
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app_theme.dart';
import '../../core/play_billing.dart';
import '../../l10n/app_copy.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../auth/guest_claim_page.dart';

/// Identity and purchase details share one scrollable column on small screens.
/// A larger font also keeps this reading order, even on a wide display.
class PremiumOfferLayout extends StatelessWidget {
  const PremiumOfferLayout({
    super.key,
    required this.introduction,
    required this.checkout,
  });

  final Widget introduction;
  final Widget checkout;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide =
          constraints.maxWidth >= 920 &&
          MediaQuery.textScalerOf(context).scale(16) <= 20;
      if (!wide) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [introduction, const SizedBox(height: 24), checkout],
        );
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: introduction),
          const SizedBox(width: 40),
          Expanded(child: checkout),
        ],
      );
    },
  );
}

class PremiumIntroduction extends StatelessWidget {
  const PremiumIntroduction({
    super.key,
    required this.hasTrial,
    this.showNoAccount = false,
    this.active = false,
    this.compact = false,
  });

  final bool hasTrial;
  final bool showNoAccount;
  final bool active;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = active
        ? 'billing.active'
        : hasTrial
        ? 'billing.trialTitle'
        : 'billing.premiumTitle';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          key: const ValueKey('premium-introduction'),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: FuzeVpnTheme.ink,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF3C4951)),
          ),
          child: FuzeNetworkGrid(
            child: Padding(
              padding: EdgeInsets.all(compact ? 20 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FuzeEyebrow(
                          'Fuze Premium',
                          color: FuzeVpnTheme.signal,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: FuzeVpnTheme.signal,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const FuzeEmblem(
                          size: 30,
                          color: FuzeVpnTheme.ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Semantics(
                    header: true,
                    child: Text(
                      context.copy(title),
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: compact ? 28 : 34,
                        color: FuzeVpnTheme.paper,
                        height: 1.13,
                      ),
                    ),
                  ),
                  if (!active) ...[
                    const SizedBox(height: 12),
                    Text(
                      context.copy(
                        hasTrial
                            ? 'billing.trialSubtitle'
                            : 'billing.premiumSubtitle',
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFDCD5C9),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            _Benefit(
              icon: Icons.lock_outline,
              label: context.copy('billing.benefitConnection'),
            ),
            _Benefit(
              icon: Icons.shield_outlined,
              label: context.copy('billing.benefitPrivacy'),
            ),
            if (showNoAccount)
              _Benefit(
                icon: Icons.person_outline,
                label: context.copy('billing.benefitNoAccount'),
              ),
          ],
        ),
      ],
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: 18,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Text(label, style: Theme.of(context).textTheme.bodySmall),
      ),
    ],
  );
}

class PremiumPlanChoices extends StatelessWidget {
  const PremiumPlanChoices({
    super.key,
    required this.plans,
    required this.selected,
    required this.onSelected,
  });

  final List<PlaySubscriptionPlan> plans;
  final PlaySubscriptionPlan? selected;
  final ValueChanged<PlaySubscriptionPlan>? onSelected;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Semantics(
        header: true,
        child: Text(
          context.copy('billing.choosePeriod'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      const SizedBox(height: 14),
      LayoutBuilder(
        builder: (context, constraints) {
          final horizontal =
              constraints.maxWidth >= 350 &&
              MediaQuery.textScalerOf(context).scale(16) <= 19.2;
          final options = plans.map(
            (plan) => PremiumPlanOption(
              plan: plan,
              selected: selected?.sameOffer(plan) == true,
              onSelected: onSelected == null ? null : () => onSelected!(plan),
            ),
          );
          if (horizontal && plans.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: options.first),
                const SizedBox(width: 12),
                Expanded(child: options.last),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final option in options)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: option,
                ),
            ],
          );
        },
      ),
    ],
  );
}

class PremiumPlanOption extends StatelessWidget {
  const PremiumPlanOption({
    super.key,
    required this.plan,
    required this.selected,
    required this.onSelected,
  });

  final PlaySubscriptionPlan plan;
  final bool selected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      button: true,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: selected ? scheme.secondary : scheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: ValueKey('subscription-plan-${plan.basePlanId}'),
          onTap: onSelected,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        context.copy(
                          plan.basePlanId == 'yearly'
                              ? 'billing.yearly'
                              : 'billing.monthly',
                        ),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 22,
                      color: scheme.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  plan.formattedPrice,
                  key: ValueKey('subscription-price-${plan.basePlanId}'),
                  style: theme.textTheme.headlineSmall,
                ),
                Text(
                  context.copy(
                    plan.basePlanId == 'yearly'
                        ? 'billing.priceYearly'
                        : 'billing.priceMonthly',
                  ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (plan.freeTrialDays != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    key: ValueKey('subscription-trial-${plan.basePlanId}'),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _trialLabel(context, plan.freeTrialDays!),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A preview is deliberately dated from the local calendar. Google Play owns
/// the actual start and charge dates and confirms them in its purchase sheet.
DateTime previewTrialChargeDate(DateTime today, int days) =>
    DateTime(today.year, today.month, today.day + days);

class PremiumCheckoutSummary extends StatefulWidget {
  const PremiumCheckoutSummary({super.key, required this.plan, this.clock});

  final PlaySubscriptionPlan? plan;
  final DateTime Function()? clock;

  @override
  State<PremiumCheckoutSummary> createState() => _PremiumCheckoutSummaryState();
}

class _PremiumCheckoutSummaryState extends State<PremiumCheckoutSummary>
    with WidgetsBindingObserver {
  Timer? _midnightTimer;
  late DateTime _today;
  bool _foreground = true;

  DateTime _now() => (widget.clock?.call() ?? DateTime.now()).toLocal();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final now = _now();
    _today = DateTime(now.year, now.month, now.day);
    _scheduleMidnight(now);
  }

  void _scheduleMidnight(DateTime now) {
    _midnightTimer?.cancel();
    _midnightTimer = null;
    if (!_foreground || widget.plan?.freeTrialDays == null) return;
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(nextMidnight.difference(now), _refreshDate);
  }

  void _refreshDate() {
    if (!mounted) return;
    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    if (today != _today) setState(() => _today = today);
    _scheduleMidnight(now);
  }

  @override
  void didUpdateWidget(PremiumCheckoutSummary oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clock != widget.clock ||
        oldWidget.plan?.freeTrialDays != widget.plan?.freeTrialDays) {
      _refreshDate();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    if (_foreground) {
      _refreshDate();
    } else {
      _midnightTimer?.cancel();
      _midnightTimer = null;
    }
  }

  @override
  void dispose() {
    _midnightTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selection = widget.plan;
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final days = selection?.freeTrialDays;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (selection == null)
          Text(
            context.copy('billing.selectionHint'),
            key: const ValueKey('subscription-selection-hint'),
            style: theme.textTheme.bodyMedium,
          )
        else if (days != null) ...[
          FuzePanel(
            key: const ValueKey('subscription-trial-summary'),
            padding: const EdgeInsets.all(16),
            tone: FuzePanelTone.wash,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.copy('billing.trialToday'),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  _trialLabel(context, days),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                const SizedBox(height: 12),
                Text(
                  context.copy(
                    selection.basePlanId == 'yearly'
                        ? 'billing.trialThenYearly'
                        : 'billing.trialThenMonthly',
                    arguments: {'price': selection.formattedPrice},
                  ),
                  key: const ValueKey('subscription-recurring-price'),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  context.copy(
                    'billing.trialFirstCharge',
                    arguments: {
                      'date': DateFormat.yMd(
                        Localizations.localeOf(context).toString(),
                      ).format(previewTrialChargeDate(_today, days)),
                    },
                  ),
                  key: const ValueKey('subscription-first-charge'),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(context.copy('billing.trialTerms'), style: muted),
          const SizedBox(height: 8),
          Text(context.copy('billing.trialConfirmation'), style: muted),
        ] else ...[
          Text(
            context.copy(
              selection.basePlanId == 'yearly'
                  ? 'billing.renewalYearly'
                  : 'billing.renewalMonthly',
            ),
            style: muted,
          ),
          const SizedBox(height: 8),
          Text(context.copy('billing.cancellation'), style: muted),
        ],
        if (days == null) ...[
          const SizedBox(height: 10),
          Text(context.copy('billing.priceDisclosure'), style: muted),
        ],
      ],
    );
  }
}

String _trialLabel(BuildContext context, int days) => days == 14
    ? context.copy('billing.trialWeeks')
    : context.copy('billing.trialDays', arguments: {'days': '$days'});

/// The acceptance sentence and both links stay separate and discoverable.
/// Reduced margins let normal text fit on one row without shrinking targets.
class PremiumLegalLinks extends StatelessWidget {
  const PremiumLegalLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = (theme.textButtonTheme.style ?? const ButtonStyle()).copyWith(
      minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      ),
      textStyle: WidgetStatePropertyAll(theme.textTheme.labelMedium),
    );
    return Theme(
      data: theme.copyWith(textButtonTheme: TextButtonThemeData(style: style)),
      child: const OnboardingLegalLinks(),
    );
  }
}
