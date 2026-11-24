part of 'home_shell.dart';

/// The row of the advanced options that opens [SplitTunnelPage].
class _SplitTunnelEntry extends StatelessWidget {
  const _SplitTunnelEntry({required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final int count = controller.excludedApps.length;
    return ListTile(
      key: const ValueKey('split-tunnel-open'),
      contentPadding: EdgeInsets.zero,
      leading: const _ConnectionOptionIcon(icon: Icons.alt_route_rounded),
      title: Text(context.copy('splitTunnel.title')),
      subtitle: count == 0 && controller.excludedAppsLoaded
          ? Text(context.copy('splitTunnel.allInVpn'))
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (count > 0)
            Text(
              '$count',
              key: const ValueKey('split-tunnel-count'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
      onTap: () => Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => SplitTunnelPage(controller: controller),
        ),
      ),
    );
  }
}

/// Split tunneling: the launcher's apps, each with a box that keeps it out of
/// the VPN. A change is saved at once and applies to the next tunnel; while a
/// tunnel started with another list is up, the page offers to reconnect.
class SplitTunnelPage extends StatefulWidget {
  const SplitTunnelPage({super.key, required this.controller});

  final VpnAppController controller;

  @override
  State<SplitTunnelPage> createState() => _SplitTunnelPageState();
}

class _SplitTunnelPageState extends State<SplitTunnelPage> {
  final TextEditingController _search = TextEditingController();
  late Future<List<InstalledApp>> _apps;
  // One read per app while the page is open.
  final Map<String, Future<Uint8List?>> _icons = <String, Future<Uint8List?>>{};

  static const double _iconSize = 40;

  @override
  void initState() {
    super.initState();
    _apps = _readApps();
    unawaited(widget.controller.loadExcludedApps());
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<List<InstalledApp>> _readApps() async {
    final List<InstalledApp> apps = List<InstalledApp>.of(
      await widget.controller.launchableApps(),
    );
    apps.sort(
      (InstalledApp a, InstalledApp b) =>
          a.label.toLowerCase().compareTo(b.label.toLowerCase()),
    );
    return apps;
  }

  void _retry() {
    setState(() {
      _apps = _readApps();
    });
    unawaited(widget.controller.loadExcludedApps());
  }

  Future<Uint8List?> _icon(String packageName, int sizePx) =>
      _icons.putIfAbsent(
        packageName,
        () => widget.controller.appIcon(packageName, sizePx),
      );

  List<InstalledApp> _filtered(List<InstalledApp> apps) {
    final String query = _search.text.trim().toLowerCase();
    if (query.isEmpty) return apps;
    return apps
        .where(
          (InstalledApp app) =>
              app.label.toLowerCase().contains(query) ||
              app.packageName.toLowerCase().contains(query),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (BuildContext context, _) => Scaffold(
      key: const ValueKey('split-tunnel-page'),
      appBar: AppBar(title: Text(context.copy('splitTunnel.title'))),
      body: SafeArea(
        top: false,
        child: FutureBuilder<List<InstalledApp>>(
          future: _apps,
          builder:
              (
                BuildContext context,
                AsyncSnapshot<List<InstalledApp>> snapshot,
              ) => _list(context, snapshot),
        ),
      ),
    ),
  );

  Widget _list(
    BuildContext context,
    AsyncSnapshot<List<InstalledApp>> snapshot,
  ) {
    final VpnAppController controller = widget.controller;
    final ThemeData theme = Theme.of(context);
    final List<Widget> header = <Widget>[
      Text(
        context.copy('splitTunnel.intro'),
        style: theme.textTheme.bodyMedium,
      ),
      const SizedBox(height: 12),
      if (controller.excludedAppsBlockedByLockdown)
        _SplitTunnelBanner(
          key: const ValueKey('split-tunnel-lockdown'),
          icon: Icons.block_rounded,
          message: context.copy('splitTunnel.lockdownActive'),
          error: true,
          action: TextButton(
            key: const ValueKey('split-tunnel-open-settings'),
            onPressed: controller.openSystemVpnSettings,
            child: Text(context.copy('protection.openSettings')),
          ),
        )
      else
        _SplitTunnelNote(text: context.copy('splitTunnel.lockdownNote')),
      if (controller.excludedAppsAwaitReconnect) ...<Widget>[
        const SizedBox(height: 12),
        _SplitTunnelBanner(
          key: const ValueKey('split-tunnel-pending'),
          icon: Icons.sync_rounded,
          message: context.copy('splitTunnel.reconnectMessage'),
          action: FilledButton.tonal(
            key: const ValueKey('split-tunnel-reconnect'),
            onPressed: controller.canReconnectToApplyExcludedApps
                ? controller.reconnectToApplyExcludedApps
                : null,
            child: Text(context.copy('splitTunnel.reconnect')),
          ),
        ),
      ],
      if (controller.excludedAppsSaveFailed) ...<Widget>[
        const SizedBox(height: 12),
        _SplitTunnelError(text: context.copy('splitTunnel.saveFailed')),
      ],
      const SizedBox(height: 16),
      TextField(
        key: const ValueKey('split-tunnel-search'),
        controller: _search,
        onChanged: (_) => setState(() {}),
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          labelText: context.copy('splitTunnel.search'),
          prefixIcon: const Icon(Icons.search_rounded, size: 22),
          suffixIcon: _search.text.isEmpty
              ? null
              : IconButton(
                  key: const ValueKey('split-tunnel-clear-search'),
                  tooltip: context.copy('locations.clearSearch'),
                  onPressed: () => setState(_search.clear),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  icon: const Icon(Icons.close_rounded),
                ),
        ),
      ),
      const SizedBox(height: 8),
    ];
    final bool failed =
        snapshot.hasError ||
        (controller.excludedAppsLoadFailed && !controller.excludedAppsLoaded);
    final bool loading =
        !failed &&
        (snapshot.connectionState != ConnectionState.done ||
            !controller.excludedAppsLoaded);
    final List<InstalledApp> apps = loading || failed
        ? const <InstalledApp>[]
        : _filtered(snapshot.data ?? const <InstalledApp>[]);
    final Widget? status = failed
        ? _SplitTunnelError(
            key: const ValueKey('split-tunnel-load-failed'),
            text: context.copy('splitTunnel.loadFailed'),
            onRetry: _retry,
          )
        : loading
        ? Row(
            key: const ValueKey('split-tunnel-loading'),
            children: <Widget>[
              const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(context.copy('splitTunnel.loading'))),
            ],
          )
        : apps.isEmpty
        ? Text(
            context.copy('splitTunnel.noApps'),
            key: const ValueKey('split-tunnel-empty'),
          )
        : null;
    final int iconPx = (_iconSize * MediaQuery.devicePixelRatioOf(context))
        .round()
        .clamp(16, 256);
    final int rows = header.length + (status == null ? apps.length : 1);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double horizontal = constraints.maxWidth > 768
            ? (constraints.maxWidth - 720) / 2
            : constraints.maxWidth < 360
            ? 16
            : 24;
        return ListView.builder(
          key: const ValueKey('split-tunnel-list'),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 32),
          itemCount: rows,
          itemBuilder: (BuildContext context, int index) {
            if (index < header.length) return header[index];
            if (status != null) return status;
            final InstalledApp app = apps[index - header.length];
            return CheckboxListTile(
              key: ValueKey('split-tunnel-app-${app.packageName}'),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.trailing,
              secondary: _SplitTunnelAppIcon(
                icon: _icon(app.packageName, iconPx),
                size: _iconSize,
              ),
              title: Text(app.label),
              subtitle: Text(
                app.packageName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
              value: controller.excludedApps.contains(app.packageName),
              onChanged: controller.excludedAppsLoaded
                  ? (bool? excluded) => controller.setAppExcluded(
                      app.packageName,
                      excluded ?? false,
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}

class _SplitTunnelAppIcon extends StatelessWidget {
  const _SplitTunnelAppIcon({required this.icon, required this.size});

  final Future<Uint8List?> icon;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: FutureBuilder<Uint8List?>(
      future: icon,
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        final Uint8List? bytes = snapshot.data;
        if (bytes == null) {
          return Icon(
            Icons.apps_rounded,
            size: size * 0.7,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          );
        }
        return Image.memory(
          bytes,
          width: size,
          height: size,
          gaplessPlayback: true,
          excludeFromSemantics: true,
          errorBuilder: (_, _, _) => Icon(Icons.apps_rounded, size: size * 0.7),
        );
      },
    ),
  );
}

class _SplitTunnelBanner extends StatelessWidget {
  const _SplitTunnelBanner({
    super.key,
    required this.icon,
    required this.message,
    required this.action,
    this.error = false,
  });

  final IconData icon;
  final String message;
  final Widget action;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color foreground = error
        ? scheme.onErrorContainer
        : scheme.onSecondaryContainer;
    return Card(
      margin: EdgeInsets.zero,
      color: error ? scheme.errorContainer : scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, size: 20, color: foreground),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: foreground),
                  ),
                ),
              ],
            ),
            Align(alignment: AlignmentDirectional.centerEnd, child: action),
          ],
        ),
      ),
    );
  }
}

class _SplitTunnelNote extends StatelessWidget {
  const _SplitTunnelNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      key: const ValueKey('split-tunnel-lockdown-note'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.info_outline_rounded,
          size: 18,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class _SplitTunnelError extends StatelessWidget {
  const _SplitTunnelError({super.key, required this.text, this.onRetry});

  final String text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(text, style: TextStyle(color: scheme.error)),
          if (onRetry != null)
            TextButton(
              key: const ValueKey('split-tunnel-retry'),
              onPressed: onRetry,
              child: Text(context.copy('action.retry')),
            ),
        ],
      ),
    );
  }
}
