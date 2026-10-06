part of 'home_shell.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({
    super.key,
    required this.controller,
    required this.onBrowseLocations,
    this.scrollController,
  });

  final VpnAppController controller;
  final VoidCallback onBrowseLocations;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final bool compact = _compactConnectionLayout(context);
    return _PageBody(
      controller: scrollController,
      children: <Widget>[
        FuzePageHeader(
          title: context.copy('connection.title'),
          description: compact ? null : context.copy('connection.subtitle'),
          compact: compact,
        ),
        TunnelHero(
          controller: controller,
          onBrowseLocations: onBrowseLocations,
        ),
        const SizedBox(height: 20),
        NoticeCard(
          notice: controller.notice,
          onDismiss: controller.clearNotice,
        ),
        if (controller.notice != null) const SizedBox(height: 12),
        if (controller.mayNeedEmailVerification) ...<Widget>[
          if (controller.profile?.hasSessionCapabilities == true &&
              controller.profile?.canUseVpn == true &&
              controller.profile?.canManageAccount == true &&
              controller.profile?.isGuest == false)
            FuzePanel(
              tone: FuzePanelTone.wash,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(context.copy('guest.verifyEmailReminder')),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: controller.resendVerification,
                    child: Text(context.copy('verification.resend')),
                  ),
                ],
              ),
            )
          else
            VerificationBanner(controller: controller),
          const SizedBox(height: 12),
        ],
        if (controller.locationMigration != null) ...<Widget>[
          LocationMigrationBanner(controller: controller),
          const SizedBox(height: 12),
        ],
        if (controller.isConnected) ...<Widget>[
          TunnelMetricsCard(controller: controller),
          const SizedBox(height: 12),
        ],
        ProtocolOptions(controller: controller),
        const SizedBox(height: 12),
        const TunnelTrustNote(),
      ],
    );
  }
}

// Keep the connection and stop controls in the first viewport of short phones.
// Large accessibility text retains its full scale and a scrollable composition.
bool _compactConnectionLayout(BuildContext context) =>
    MediaQuery.sizeOf(context).height <= 700 &&
    MediaQuery.textScalerOf(context).scale(14) <= 18.2;
