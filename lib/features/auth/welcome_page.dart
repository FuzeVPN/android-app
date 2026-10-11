import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app_controller.dart';
import '../../app_theme.dart';
import '../../google_auth_controller.dart';
import '../../l10n/app_copy.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../../widgets/language_settings.dart';
import '../../widgets/notice_card.dart';
import '../billing/subscription_card.dart';
import 'auth_page.dart';
import 'google_auth_page.dart';
import 'guest_claim_page.dart';

/// The three entry points share the same honest, account-optional welcome.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: Listenable.merge([controller, controller.googleAuth]),
    builder: (context, _) => Scaffold(
      key: const ValueKey('welcome-page'),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.3;
            final wide = constraints.maxWidth >= 840 && !largeText;
            final short = constraints.maxHeight < 700 || largeText;
            final maximumWidth = wide
                ? 1120.0
                : largeText
                ? 560.0
                : 520.0;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maximumWidth),
                child: CustomScrollView(
                  key: const ValueKey('welcome-scroll'),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          runSpacing: 12,
                          children: [
                            const FuzeBrand(emblemSize: 32),
                            LanguageSettings(
                              key: const ValueKey('welcome-language-settings'),
                              locale: controller.locale,
                              onChanged: controller.setLocale,
                              compact: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (controller.notice != null)
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: NoticeCard(
                            notice: controller.notice,
                            onDismiss: controller.clearNotice,
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24, short ? 24 : 40, 24, 20),
                      sliver: SliverFillRemaining(
                        hasScrollBody: false,
                        child: wide
                            ? Row(
                                children: [
                                  const Expanded(
                                    child: FuzeWelcomeArtwork(size: 360),
                                  ),
                                  const SizedBox(width: 64),
                                  Expanded(
                                    child: _content(context, wide: true),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _introduction(context, short: short),
                                  const SizedBox(height: 28),
                                  _actions(context),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );

  Widget _content(BuildContext context, {required bool wide}) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _heading(context, wide: wide),
      const SizedBox(height: 20),
      _description(context, wide: wide),
      const SizedBox(height: 40),
      _actions(context),
    ],
  );

  Widget _heading(BuildContext context, {bool wide = false}) => Semantics(
    header: true,
    child: Text(
      context.copy('welcome.title'),
      textAlign: wide ? TextAlign.start : TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: wide ? 40 : 32,
        height: 1.15,
      ),
    ),
  );

  Widget _description(BuildContext context, {bool wide = false}) => Text(
    context.copy('welcome.description'),
    textAlign: wide ? TextAlign.start : TextAlign.center,
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    ),
  );

  Widget _introduction(BuildContext context, {required bool short}) => Column(
    children: [
      _heading(context),
      SizedBox(height: short ? 16 : 28),
      FuzeWelcomeArtwork(size: short ? 160 : 240),
      SizedBox(height: short ? 16 : 28),
      _description(context),
    ],
  );

  Widget _actions(BuildContext context) {
    final google = controller.googleAuth;
    final guestBusy = controller.isGuestActionBusy;
    final busy = guestBusy || google.hasPendingIntent;
    final restoreFailed = const {
      'billing.restoreEmpty',
      'guest.restoreError',
    }.contains(controller.guestMessageKey);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (google.hasPendingIntent) ...[
          FuzePanel(
            key: const ValueKey('welcome-google-recovery'),
            tone: FuzePanelTone.wash,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  liveRegion: true,
                  child: Text(
                    context.copy(google.state.messageKey ?? 'google.uncertain'),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  key: const ValueKey('welcome-google-resume'),
                  onPressed: google.isBusy
                      ? null
                      : () => openGoogleAuthentication(
                          context,
                          controller,
                          GoogleAuthPurpose.authenticate,
                        ),
                  child: Text(
                    context.copy('google.resume'),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  key: const ValueKey('welcome-google-cancel'),
                  onPressed: google.isBusy ? null : google.cancel,
                  child: Text(
                    context.copy('action.cancel'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (controller.guestMessageKey != null) ...[
          GuestActionMessage(messageKey: controller.guestMessageKey!),
          const SizedBox(height: 16),
        ],
        FilledButton(
          key: const ValueKey('welcome-start'),
          onPressed: busy
              ? null
              : () => Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        SubscriptionPaywallPage(controller: controller),
                  ),
                ),
          child: Text(
            context.copy('welcome.start'),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          key: const ValueKey('welcome-sign-in'),
          onPressed: busy ? null : () => openFuzeSignIn(context, controller),
          child: Text(
            context.copy('action.login'),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 4),
        TextButton(
          key: const ValueKey('welcome-restore'),
          onPressed: busy ? null : controller.restoreGuestPurchases,
          child: Text(
            context.copy(
              guestBusy
                  ? 'billing.restoring'
                  : restoreFailed
                  ? 'action.retry'
                  : 'welcome.alreadyPurchased',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.copy('welcome.noAccountRequired'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        const OnboardingLegalLinks(showAcceptance: false, centered: true),
      ],
    );
  }
}

Future<void> openFuzeSignIn(
  BuildContext context,
  VpnAppController controller,
) => Navigator.of(context).push<void>(
  MaterialPageRoute<void>(
    builder: (_) => AuthenticationPage(controller: controller, loginOnly: true),
  ),
);

class GuestActionMessage extends StatelessWidget {
  const GuestActionMessage({super.key, required this.messageKey});
  final String messageKey;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: FuzePanel(
      tone: FuzePanelTone.wash,
      padding: const EdgeInsets.all(16),
      child: Text(context.copy(messageKey)),
    ),
  );
}

/// A decorative tunnel diagram built from the existing Fuze shield emblem.
class FuzeWelcomeArtwork extends StatelessWidget {
  const FuzeWelcomeArtwork({super.key, this.size = 240});
  final double size;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox(
      width: size,
      height: size * .9,
      child: CustomPaint(
        painter: _WelcomeTunnelPainter(
          outline: Theme.of(context).colorScheme.outlineVariant,
          surface: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Center(
          child: Container(
            width: size * .59,
            height: size * .59,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: FuzeVpnTheme.signal,
              shape: BoxShape.circle,
            ),
            child: FuzeEmblem(size: size * .36, color: FuzeVpnTheme.ink),
          ),
        ),
      ),
    ),
  );
}

class _WelcomeTunnelPainter extends CustomPainter {
  const _WelcomeTunnelPainter({required this.outline, required this.surface});
  final Color outline, surface;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.drawCircle(center, size.width * .43, Paint()..color = surface);
    final pathPaint = Paint()
      ..color = outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final direction in [-1.0, 1.0]) {
      final path = Path()
        ..moveTo(
          center.dx + direction * size.width * .19,
          center.dy - size.height * .28,
        )
        ..cubicTo(
          center.dx + direction * size.width * .54,
          center.dy - size.height * .28,
          center.dx + direction * size.width * .54,
          center.dy + size.height * .28,
          center.dx + direction * size.width * .19,
          center.dy + size.height * .28,
        );
      canvas.drawPath(path, pathPaint);
    }
    for (final angle in [
      -math.pi * .78,
      -math.pi * .12,
      math.pi * .23,
      math.pi * .9,
    ]) {
      final node =
          center +
          Offset(math.cos(angle), math.sin(angle)) * (size.width * .39);
      canvas.drawCircle(
        node,
        size.width * .025,
        Paint()..color = FuzeVpnTheme.signal,
      );
      canvas.drawCircle(node, size.width * .025, pathPaint);
    }
  }

  @override
  bool shouldRepaint(_WelcomeTunnelPainter oldDelegate) =>
      oldDelegate.outline != outline || oldDelegate.surface != surface;
}
