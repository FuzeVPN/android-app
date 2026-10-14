part of 'home_shell.dart';

class _HomeDestination {
  const _HomeDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class _PageBody extends StatelessWidget {
  const _PageBody({required this.children, this.onRefresh, this.controller});

  final List<Widget> children;
  final Future<void> Function()? onRefresh;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double horizontal = constraints.maxWidth > 768
          ? (constraints.maxWidth - 720) / 2
          : constraints.maxWidth < 360
          ? 16
          : 24;
      final Widget list = ListView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 32),
        children: children,
      );
      if (onRefresh == null) return list;
      return RefreshIndicator(onRefresh: onRefresh!, child: list);
    },
  );
}

class _StatusPresentation {
  const _StatusPresentation({
    required this.label,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final String label;
  final String detail;
  final IconData icon;
  final _SchemeColor color;
}

enum _SchemeColor {
  primary,
  error,
  secondary,
  outline;

  Color resolve(ColorScheme scheme) => switch (this) {
    _SchemeColor.primary => scheme.primary,
    _SchemeColor.error => scheme.error,
    _SchemeColor.secondary => scheme.secondary,
    _SchemeColor.outline => scheme.outline,
  };
}

_StatusPresentation _statusPresentation(
  BuildContext context,
  VpnRuntimeState state,
) {
  return switch (state.phase) {
    VpnRuntimePhase.authorizing => _StatusPresentation(
      label: context.copy('status.authorizing'),
      detail: context.copy('status.authorizingDetail'),
      icon: Icons.admin_panel_settings_outlined,
      color: _SchemeColor.secondary,
    ),
    VpnRuntimePhase.preparing => _StatusPresentation(
      label: context.copy('status.preparing'),
      detail: context.copy('status.preparingDetail'),
      icon: Icons.settings_suggest_outlined,
      color: _SchemeColor.secondary,
    ),
    VpnRuntimePhase.connecting => _StatusPresentation(
      label: context.copy(
        state.isWaitingForNetwork
            ? 'status.waitingNetwork'
            : state.isReconnecting
            ? 'status.reconnecting'
            : 'status.connecting',
      ),
      detail: context.copy(
        state.isWaitingForNetwork
            ? 'status.waitingNetworkDetail'
            : state.isReconnecting
            ? 'status.reconnectingDetail'
            : 'status.connectingDetail',
      ),
      icon: Icons.sync,
      color: _SchemeColor.secondary,
    ),
    VpnRuntimePhase.connected => _StatusPresentation(
      label: context.copy('status.connected'),
      detail: context.copy('status.connectedDetail'),
      icon: Icons.verified_user,
      color: _SchemeColor.secondary,
    ),
    VpnRuntimePhase.disconnecting => _StatusPresentation(
      label: context.copy('status.disconnecting'),
      detail: context.copy('status.disconnectingDetail'),
      icon: Icons.link_off,
      color: _SchemeColor.outline,
    ),
    VpnRuntimePhase.error => _StatusPresentation(
      label: context.copy('status.error'),
      detail: context.copy('status.errorDetail'),
      icon: Icons.error_outline,
      color: _SchemeColor.error,
    ),
    VpnRuntimePhase.idle => _StatusPresentation(
      label: context.copy('status.idle'),
      detail: context.copy('status.idleDetail'),
      icon: Icons.shield_outlined,
      color: _SchemeColor.outline,
    ),
  };
}

String _protocolLabel(VpnProtocol protocol) =>
    protocol == VpnProtocol.wireGuard ? 'WireGuard' : 'OpenVPN';

String _themeLabel(BuildContext context, ThemeMode mode) => switch (mode) {
  ThemeMode.system => context.copy('theme.system'),
  ThemeMode.light => context.copy('theme.light'),
  ThemeMode.dark => context.copy('theme.dark'),
};

String _formatDate(BuildContext context, DateTime date) =>
    DateFormat.yMd(Localizations.localeOf(context).toString()).format(date);

Future<void> _confirmRevocation(
  BuildContext context,
  VpnAppController controller,
  VpnDevice device,
) async {
  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      scrollable: true,
      icon: Icon(
        Icons.devices_other,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(context.copy('dialog.removeDevice')),
      content: Text(
        device.deviceId == controller.currentDeviceId
            ? context.copy('dialog.removeCurrent')
            : context.copy(
                'dialog.removeOther',
                arguments: <String, Object?>{'name': device.name},
              ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.copy('action.cancel')),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.copy('action.remove')),
        ),
      ],
    ),
  );
  if (confirm == true) await controller.revokeDevice(device);
}

Future<void> _confirmSignOut(
  BuildContext context,
  VpnAppController controller,
) async {
  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      scrollable: true,
      icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.secondary),
      title: Text(context.copy('dialog.signOut')),
      content: Text(context.copy('dialog.signOutMessage')),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.copy('action.cancel')),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.copy('action.signOut')),
        ),
      ],
    ),
  );
  if (confirm == true) await controller.signOut();
}
