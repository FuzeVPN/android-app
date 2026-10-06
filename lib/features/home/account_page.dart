part of 'home_shell.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) => _PageBody(
    onRefresh: controller.refreshDevices,
    children: <Widget>[
      FuzePageHeader(
        title: context.copy('settings.title'),
        description: context.copy('settings.subtitle'),
      ),
      NoticeCard(notice: controller.notice, onDismiss: controller.clearNotice),
      if (controller.notice != null) const SizedBox(height: 12),
      _AccountProfileCard(controller: controller),
      const SizedBox(height: 20),
      SubscriptionCard(
        controller: controller.billing,
        appController: controller,
      ),
      const SizedBox(height: 28),
      _AccountSectionLabel(
        label: context.copy('devices.title'),
        icon: Icons.devices_outlined,
      ),
      Card(
        key: const ValueKey('account-devices'),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          key: const PageStorageKey('account-devices-expansion'),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: MediaQuery.textScalerOf(context).scale(16) > 24
              ? null
              : const _AccountIcon(icon: Icons.devices_outlined),
          title: Text(context.copy('devices.manage')),
          subtitle: Text(
            context.copy(
              'devices.used',
              arguments: <String, Object?>{
                'count': controller.deviceList.devices.length,
                'limit': controller.deviceList.limit,
              },
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          children: <Widget>[
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                ),
                onPressed: controller.isLoadingDevices
                    ? null
                    : controller.refreshDevices,
                icon: MediaQuery.textScalerOf(context).scale(16) > 24
                    ? null
                    : const Icon(Icons.refresh),
                label: Text(
                  context.copy('devices.refresh'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (controller.isLoadingDevices)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (controller.deviceList.devices.isEmpty)
              const EmptyDevicesCard()
            else
              ...controller.deviceList.devices.map(
                (VpnDevice device) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DeviceRow(device: device, controller: controller),
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 28),
      _AccountSectionLabel(
        label: context.copy('settings.personalization'),
        icon: Icons.tune,
      ),
      Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            _AppearanceCard(controller: controller),
            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            LanguageSettings(
              key: const ValueKey('language-settings'),
              locale: controller.locale,
              onChanged: controller.setLocale,
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      _AccountSectionLabel(
        label: context.copy('settings.safety'),
        icon: Icons.shield_outlined,
      ),
      _NetworkProtectionCard(controller: controller),
      const SizedBox(height: 24),
      _AccountSectionLabel(
        label: context.copy('settings.help'),
        icon: Icons.support_agent,
      ),
      _DiagnosticsSettingsCard(controller: controller),
      const SizedBox(height: 24),
      _AccountSectionLabel(
        label: context.copy('settings.about'),
        icon: Icons.info_outline,
      ),
      _LegalCard(controller: controller),
      const SizedBox(height: 16),
      const _BackgroundNote(),
    ],
  );
}

class _AccountProfileCard extends StatelessWidget {
  const _AccountProfileCard({required this.controller});
  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final foreground = FuzeVpnTheme.paper;
    final profile = controller.profile;
    final hiddenIdentity =
        profile?.isGuest == true || profile?.profileRedacted == true;
    final nameParts = [
      hiddenIdentity ? '' : profile?.firstName.trim() ?? '',
      hiddenIdentity ? '' : profile?.lastName.trim() ?? '',
    ].where((part) => part.isNotEmpty).toList(growable: false);
    final name = nameParts.join(' ');
    final email = hiddenIdentity ? '' : profile?.email ?? '';
    final initial = nameParts.isNotEmpty
        ? nameParts.map((part) => part.characters.first.toUpperCase()).join()
        : email.isNotEmpty
        ? email.characters.first.toUpperCase()
        : null;
    return Card(
      key: const ValueKey('account-profile'),
      color: FuzeVpnTheme.ink,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExcludeSemantics(
                  child: Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: FuzeVpnTheme.signal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: initial == null
                        ? Icon(
                            Icons.person_outline,
                            color: FuzeVpnTheme.ink,
                            size: 26,
                          )
                        : Text(
                            initial,
                            textScaler: TextScaler.noScaling,
                            style: FuzeVpnTheme.mono(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: FuzeVpnTheme.ink,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FuzeEyebrow(
                        context.copy('settings.account'),
                        color: foreground.withValues(alpha: .75),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        hiddenIdentity
                            ? context.copy(
                                profile?.isGuest == true
                                    ? 'guest.accountTitle'
                                    : 'settings.account',
                              )
                            : name.isEmpty
                            ? email
                            : name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: foreground),
                      ),
                      if (name.isNotEmpty && email.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: foreground.withValues(alpha: .8),
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (hiddenIdentity) ...[
              const SizedBox(height: 16),
              Text(
                context.copy(
                  profile?.isGuest == true
                      ? 'guest.accountDescription'
                      : 'guest.profileUnavailable',
                ),
                key: const ValueKey('guest-profile-description'),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: foreground.withValues(alpha: .85),
                ),
              ),
              if (profile?.isGuest == true) ...[
                if (profile?.canClaimAccount == true) ...[
                  const SizedBox(height: 20),
                  FilledButton(
                    key: const ValueKey('guest-create-account'),
                    onPressed: controller.isGuestActionBusy
                        ? null
                        : () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  GuestClaimPage(controller: controller),
                            ),
                          ),
                    child: Text(
                      context.copy('action.createMyAccount'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                SizedBox(height: profile?.canClaimAccount == true ? 8 : 20),
                TextButton(
                  key: const ValueKey('guest-existing-subscriber-sign-in'),
                  style: TextButton.styleFrom(foregroundColor: foreground),
                  onPressed:
                      controller.isGuestActionBusy ||
                          controller.isAuthenticating ||
                          controller.isIdentityBusy ||
                          controller.isConnecting
                      ? null
                      : () => showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              AuthenticationDialog(controller: controller),
                        ),
                  child: Text(
                    context.copy('guest.existingSubscriberSignIn'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ] else if (profile?.profileRedacted == true &&
                  profile?.isGuest != true) ...[
                const SizedBox(height: 20),
                FilledButton(
                  key: const ValueKey('redacted-sign-in'),
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => AuthenticationPage(
                        controller: controller,
                        loginOnly: true,
                      ),
                    ),
                  ),
                  child: Text(
                    context.copy('action.login'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
            if (profile?.isGuest != true) ...[
              const SizedBox(height: 18),
              Divider(height: 1, color: foreground.withValues(alpha: .16)),
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  key: const ValueKey('account-sign-out'),
                  style: TextButton.styleFrom(
                    foregroundColor: foreground,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onPressed: controller.isGuestActionBusy
                      ? null
                      : () => _confirmSignOut(context, controller),
                  icon: const Icon(Icons.logout, size: 18),
                  label: Text(context.copy('settings.signOut')),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyDevicesCard extends StatelessWidget {
  const EmptyDevicesCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: <Widget>[
          const _AccountIcon(icon: Icons.devices_other_outlined, size: 48),
          const SizedBox(height: 14),
          Text(
            context.copy('devices.empty'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Text(
            context.copy('devices.firstConnection'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}

class DeviceRow extends StatelessWidget {
  const DeviceRow({super.key, required this.device, required this.controller});

  final VpnDevice device;
  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final bool current = controller.currentDeviceId == device.deviceId;
    final bool largeText = MediaQuery.textScalerOf(context).scale(16) > 24;
    final ThemeData theme = Theme.of(context);
    final Widget icon = _AccountIcon(
      icon: current ? Icons.phone_android : Icons.devices_other,
      size: 36,
    );
    final Widget name = Text(device.name, style: theme.textTheme.titleMedium);
    final Widget? currentLabel = current
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.copy('devices.thisDevice'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          )
        : null;
    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (largeText) ...<Widget>[
              Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  icon,
                  if (currentLabel != null) currentLabel,
                ],
              ),
              const SizedBox(height: 12),
              name,
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  icon,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        name,
                        if (currentLabel != null) ...<Widget>[
                          const SizedBox(height: 8),
                          currentLabel,
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            if (device.createdAt != null) ...<Widget>[
              const SizedBox(height: 10),
              Text(
                context.copy(
                  'devices.added',
                  arguments: <String, Object?>{
                    'date': _formatDate(context, device.createdAt!),
                  },
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            Divider(height: 24, color: theme.colorScheme.outlineVariant),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                width: largeText ? double.infinity : null,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                  ),
                  onPressed: controller.isRevoking
                      ? null
                      : () => _confirmRevocation(context, controller, device),
                  icon: largeText ? null : const Icon(Icons.delete_outline),
                  label: Text(
                    context.copy('action.remove'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountSectionLabel extends StatelessWidget {
  const _AccountSectionLabel({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 4, bottom: 12),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 10),
        Expanded(
          child: Semantics(
            header: true,
            child: Text(label, style: Theme.of(context).textTheme.titleSmall),
          ),
        ),
      ],
    ),
  );
}

class _AccountIcon extends StatelessWidget {
  const _AccountIcon({required this.icon, this.size = 40});
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: FuzeVpnTheme.signal,
        borderRadius: BorderRadius.circular(size * .2),
      ),
      child: Icon(icon, size: size * .5, color: FuzeVpnTheme.ink),
    ),
  );
}

class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard({required this.controller});
  final VpnAppController controller;

  @override
  Widget build(BuildContext context) => ListTile(
    key: const ValueKey('appearance-settings'),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    minVerticalPadding: 16,
    leading: const _AccountIcon(icon: Icons.palette_outlined),
    title: Text(context.copy('settings.appearance')),
    subtitle: Text(_themeLabel(context, controller.themeMode)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => _showPreferenceSheet(
      context,
      title: context.copy('settings.appearance'),
      children: ThemeMode.values
          .map(
            (mode) => ListTile(
              key: ValueKey('theme-${mode.name}'),
              minVerticalPadding: 14,
              leading: Icon(switch (mode) {
                ThemeMode.light => Icons.light_mode_outlined,
                ThemeMode.dark => Icons.dark_mode_outlined,
                ThemeMode.system => Icons.brightness_auto_outlined,
              }),
              title: Text(_themeLabel(context, mode)),
              trailing: controller.themeMode == mode
                  ? const Icon(Icons.check_circle)
                  : null,
              selected: controller.themeMode == mode,
              onTap: () {
                Navigator.of(context).pop();
                controller.setThemeMode(mode);
              },
            ),
          )
          .toList(growable: false),
    ),
  );
}

Future<void> _showPreferenceSheet(
  BuildContext context, {
  required String title,
  String? description,
  required List<Widget> children,
}) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (sheetContext) => SafeArea(
    top: false,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(sheetContext).height * .8,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                title,
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
            ),
            ...children,
            if (description != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  description,
                  style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                    color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  ),
);

class _NetworkProtectionCard extends StatelessWidget {
  const _NetworkProtectionCard({required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final SystemVpnProtection protection = controller.systemProtection;
    final String statusKey = protection.isActive
        ? 'protection.active'
        : protection.alwaysOn == true && protection.lockdown == false
        ? 'protection.alwaysOnOnly'
        : protection.alwaysOn == false || protection.lockdown == false
        ? 'protection.inactive'
        : 'protection.unknown';
    final IconData icon = protection.isActive
        ? Icons.verified_user_outlined
        : Icons.shield_outlined;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const _AccountIcon(icon: Icons.shield_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.copy('protection.title'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  key: const ValueKey('protection-guide-info'),
                  tooltip: context.copy('protection.learnMore'),
                  onPressed: () => _showSystemProtectionHelp(context),
                  icon: const Icon(Icons.info_outline),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(context.copy('protection.subtitle')),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(context.copy(statusKey))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                key: const ValueKey('protection-open-settings'),
                onPressed: controller.openSystemVpnSettings,
                icon: const Icon(Icons.open_in_new),
                label: Text(context.copy('protection.openSettings')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSystemProtectionHelp(BuildContext context) async {
    final bool? open = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * .85,
          ),
          child: SingleChildScrollView(
            key: const ValueKey('protection-guide-scroll'),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          sheetContext.copy('protection.dialogTitle'),
                          style: Theme.of(sheetContext).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    IconButton(
                      key: const ValueKey('protection-guide-close'),
                      tooltip: MaterialLocalizations.of(
                        sheetContext,
                      ).closeButtonTooltip,
                      onPressed: () => Navigator.of(sheetContext).pop(false),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(sheetContext.copy('protection.guideWhy')),
                const SizedBox(height: 24),
                _ProtectionGuideSection(
                  title: sheetContext.copy('protection.guideAlwaysOnTitle'),
                  body: sheetContext.copy('protection.guideAlwaysOn'),
                ),
                _ProtectionGuideSection(
                  title: sheetContext.copy('protection.guideBlockTitle'),
                  body: sheetContext.copy('protection.guideBlock'),
                ),
                Container(
                  key: const ValueKey('protection-guide-warning'),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      sheetContext,
                    ).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    sheetContext.copy('protection.guideWarning'),
                    style: TextStyle(
                      color: Theme.of(
                        sheetContext,
                      ).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  sheetContext.copy('protection.guideStepsTitle'),
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                for (var step = 1; step <= 3; step++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$step.',
                          style: Theme.of(sheetContext).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            sheetContext.copy('protection.guideStep$step'),
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  sheetContext.copy('protection.guideManufacturers'),
                  style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                    color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                _ProtectionGuideSection(
                  title: sheetContext.copy('protection.guideDisableTitle'),
                  body: sheetContext.copy('protection.guideDisable'),
                ),
                Text(
                  sheetContext.copy('protection.guideManual'),
                  style: Theme.of(sheetContext).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  key: const ValueKey('protection-guide-open-settings'),
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                  icon: const Icon(Icons.open_in_new),
                  label: Text(
                    sheetContext.copy('protection.dialogOpen'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (open == true) await controller.openSystemVpnSettings();
  }
}

class _ProtectionGuideSection extends StatelessWidget {
  const _ProtectionGuideSection({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(body),
      ],
    ),
  );
}

class _LegalCard extends StatelessWidget {
  const _LegalCard({required this.controller});
  final VpnAppController controller;

  @override
  Widget build(BuildContext context) => Card(
    key: const ValueKey('account-legal'),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: <Widget>[
        ListTile(
          leading: const _AccountIcon(
            icon: Icons.privacy_tip_outlined,
            size: 36,
          ),
          title: Text(context.copy('settings.privacy')),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => openExternalLink(
            context,
            PublicLinks.privacy(Localizations.localeOf(context)),
          ),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const _AccountIcon(icon: Icons.article_outlined, size: 36),
          title: Text(context.copy('settings.terms')),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => openExternalLink(
            context,
            PublicLinks.terms(Localizations.localeOf(context)),
          ),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const _AccountIcon(icon: Icons.security_outlined, size: 36),
          title: Text(context.copy('settings.security')),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => openExternalLink(
            context,
            PublicLinks.security(Localizations.localeOf(context)),
          ),
        ),
        const Divider(height: 1),
        if (controller.profile?.canManageAccount == true &&
            controller.profile?.isGuest != true &&
            controller.profile?.profileRedacted != true) ...[
          ListTile(
            key: const ValueKey('delete-account'),
            leading: const _AccountIcon(
              icon: Icons.person_remove_outlined,
              size: 36,
            ),
            title: Text(context.copy('settings.deleteAccount')),
            subtitle: Text(context.copy('settings.deleteAccountDetail')),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _showAccountDeletionRequest(context),
          ),
          const Divider(height: 1),
        ],
        ListTile(
          leading: const _AccountIcon(icon: Icons.info_outline, size: 36),
          title: Text(context.copy('settings.licenses')),
          subtitle: Text(context.copy('settings.licensesDetail')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () =>
              showLicensePage(context: context, applicationName: 'FuzeVPN'),
        ),
      ],
    ),
  );
}

Future<void> _showAccountDeletionRequest(BuildContext context) async {
  final bool? proceed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      key: const ValueKey('delete-account-warning'),
      constraints: const BoxConstraints(maxWidth: 560),
      scrollable: true,
      title: Text(dialogContext.copy('settings.deleteAccount')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(dialogContext.copy('billing.deleteAccountWarning')),
          const SizedBox(height: 20),
          OutlinedButton(
            key: const ValueKey('delete-account-manage-play'),
            onPressed: () =>
                openExternalLink(dialogContext, PublicLinks.playSubscriptions),
            child: Text(
              dialogContext.copy('billing.manage'),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            key: const ValueKey('delete-account-continue'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              dialogContext.copy('billing.deleteAccountContinue'),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            key: const ValueKey('delete-account-cancel'),
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              dialogContext.copy('action.cancel'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
  if (proceed != true || !context.mounted) return;
  await openExternalLink(
    context,
    PublicLinks.deleteAccount(Localizations.localeOf(context)),
  );
}

class _BackgroundNote extends StatelessWidget {
  const _BackgroundNote();

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.surfaceContainerHigh,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.copy('settings.background'),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
