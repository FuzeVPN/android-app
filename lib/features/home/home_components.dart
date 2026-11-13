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
  });

  final String label;
  final String detail;
  final IconData icon;
}

/// The label and detail keys of a connecting tunnel: waiting for a network,
/// reconnecting, or connecting for the first time.
({String label, String detail}) _connectingStatusKeys(VpnRuntimeState state) =>
    state.isWaitingForNetwork
    ? (label: 'status.waitingNetwork', detail: 'status.waitingNetworkDetail')
    : state.isReconnecting
    ? (label: 'status.reconnecting', detail: 'status.reconnectingDetail')
    : (label: 'status.connecting', detail: 'status.connectingDetail');

_StatusPresentation _statusPresentation(
  BuildContext context,
  VpnRuntimeState state, [
  VpnRuntimePhase? phase,
]) {
  return switch (phase ?? state.phase) {
    VpnRuntimePhase.authorizing => _StatusPresentation(
      label: context.copy('status.authorizing'),
      detail: context.copy('status.authorizingDetail'),
      icon: Icons.admin_panel_settings_outlined,
    ),
    VpnRuntimePhase.preparing => _StatusPresentation(
      label: context.copy('status.preparing'),
      detail: context.copy('status.preparingDetail'),
      icon: Icons.settings_suggest_outlined,
    ),
    VpnRuntimePhase.connecting => _StatusPresentation(
      label: context.copy(_connectingStatusKeys(state).label),
      detail: context.copy(_connectingStatusKeys(state).detail),
      icon: Icons.sync,
    ),
    VpnRuntimePhase.connected => _StatusPresentation(
      label: context.copy('status.connected'),
      detail: context.copy('status.connectedDetail'),
      icon: Icons.verified_user,
    ),
    VpnRuntimePhase.disconnecting => _StatusPresentation(
      label: context.copy('status.disconnecting'),
      detail: context.copy('status.disconnectingDetail'),
      icon: Icons.link_off,
    ),
    VpnRuntimePhase.error => _StatusPresentation(
      label: context.copy('status.error'),
      detail: context.copy('status.errorDetail'),
      icon: Icons.error_outline,
    ),
    VpnRuntimePhase.idle => _StatusPresentation(
      label: context.copy('status.idle'),
      detail: context.copy('status.idleDetail'),
      icon: Icons.shield_outlined,
    ),
  };
}

String _protocolLabel(VpnProtocol protocol) =>
    protocol == VpnProtocol.wireGuard ? 'WireGuard' : 'OpenVPN';

/// The protocol in effect: the running tunnel's while one is active, the
/// selected one otherwise.
VpnProtocol _effectiveProtocol(VpnAppController controller) =>
    controller.isTunnelActive
    ? controller.tunnelState.protocol ?? controller.selectedProtocol
    : controller.selectedProtocol;

String _themeLabel(BuildContext context, ThemeMode mode) => switch (mode) {
  ThemeMode.system => context.copy('theme.system'),
  ThemeMode.light => context.copy('theme.light'),
  ThemeMode.dark => context.copy('theme.dark'),
};

String _formatDate(BuildContext context, DateTime date) =>
    AppFormats.date(context, date);

/// The API may omit a device name; the fallback follows the interface language.
String _deviceName(BuildContext context, String? name) =>
    name == null || name.trim().isEmpty
    ? context.copy('devices.unnamed')
    : name;

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
      title: WholeWords(child: Text(context.copy('dialog.removeDevice'))),
      content: WholeWords(
        child: Text(
          device.deviceId == controller.currentDeviceId
              ? context.copy('dialog.removeCurrent')
              : context.copy(
                  'dialog.removeOther',
                  arguments: <String, Object?>{
                    'name': _deviceName(context, device.name),
                  },
                ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: WholeWords(child: Text(context.copy('action.cancel'))),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: WholeWords(child: Text(context.copy('action.remove'))),
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
      title: WholeWords(child: Text(context.copy('dialog.signOut'))),
      content: WholeWords(child: Text(context.copy('dialog.signOutMessage'))),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: WholeWords(child: Text(context.copy('action.cancel'))),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: WholeWords(child: Text(context.copy('action.signOut'))),
        ),
      ],
    ),
  );
  if (confirm == true) await controller.signOut();
}
