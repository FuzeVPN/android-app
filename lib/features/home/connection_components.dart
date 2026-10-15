part of 'home_shell.dart';

class VerificationBanner extends StatelessWidget {
  const VerificationBanner({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.mark_email_unread_outlined,
                    color: scheme.onSecondaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.copy('verification.title'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              context.copy('verification.message'),
              style: TextStyle(color: scheme.onSecondaryContainer),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: controller.resendVerification,
              icon: const Icon(Icons.send_outlined),
              label: Text(context.copy('verification.resend')),
            ),
          ],
        ),
      ),
    );
  }
}

class TunnelHero extends StatelessWidget {
  const TunnelHero({
    super.key,
    required this.controller,
    this.onBrowseLocations,
  });

  final VpnAppController controller;
  final VoidCallback? onBrowseLocations;

  @override
  Widget build(BuildContext context) {
    final bool compact = _compactConnectionLayout(context);
    final _StatusPresentation presentation = _statusPresentation(
      context,
      controller.tunnelState,
    );
    final VpnProtocol displayedProtocol = controller.isTunnelActive
        ? controller.tunnelState.protocol ?? controller.selectedProtocol
        : controller.selectedProtocol;
    final Color statusColor = switch (controller.tunnelState.phase) {
      VpnRuntimePhase.connected => FuzeVpnTheme.successDark,
      VpnRuntimePhase.error => FuzeVpnTheme.errorDark,
      VpnRuntimePhase.authorizing ||
      VpnRuntimePhase.preparing ||
      VpnRuntimePhase.connecting => FuzeVpnTheme.signal,
      VpnRuntimePhase.idle ||
      VpnRuntimePhase.disconnecting => const Color(0xFFC6BEB2),
    };
    return Card(
      color: const Color(0xFF17242C),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: FuzeVpnTheme.paper.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomPaint(
            painter: const _ConnectionGridPainter(),
            child: Padding(
              padding: compact
                  ? const EdgeInsets.fromLTRB(16, 14, 16, 18)
                  : const EdgeInsets.fromLTRB(22, 18, 22, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '${context.copy('connection.protocol')} · '
                    '${_protocolLabel(displayedProtocol)}',
                    textAlign: TextAlign.center,
                    style: FuzeVpnTheme.mono(
                      fontSize: 11,
                      color: const Color(0xFFC6BEB2),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: compact ? 8 : 10),
                  ExcludeSemantics(
                    child: _ConnectionSignal(
                      color: statusColor,
                      icon: presentation.icon,
                      compact: compact,
                    ),
                  ),
                  SizedBox(height: compact ? 8 : 10),
                  Semantics(
                    liveRegion: true,
                    child: Column(
                      children: <Widget>[
                        FuzeAdaptiveText(
                          presentation.label,
                          key: const ValueKey('tunnel-status'),
                          minimumFontSize: 14,
                          textAlign: TextAlign.center,
                          style:
                              (compact
                                      ? Theme.of(
                                          context,
                                        ).textTheme.headlineSmall
                                      : Theme.of(
                                          context,
                                        ).textTheme.headlineMedium)
                                  ?.copyWith(color: FuzeVpnTheme.paper),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          presentation.detail,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFFC6BEB2)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: compact ? 16 : 22),
                  PrimaryVpnAction(controller: controller),
                ],
              ),
            ),
          ),
          if (onBrowseLocations != null)
            ConnectionLocationSelector(
              controller: controller,
              onPressed: onBrowseLocations!,
              embedded: true,
            ),
        ],
      ),
    );
  }
}

/// A restrained echo of the official website's network diagram. Its grid is
/// decorative: only the native tunnel state controls the status and its colour.
class _ConnectionGridPainter extends CustomPainter {
  const _ConnectionGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = FuzeVpnTheme.paper.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(_ConnectionGridPainter oldDelegate) => false;
}

class _ConnectionSignal extends StatelessWidget {
  const _ConnectionSignal({
    required this.color,
    required this.icon,
    required this.compact,
  });

  final Color color;
  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox.square(
      dimension: compact ? 90 : 132,
      child: CustomPaint(
        painter: _ConnectionOrbitPainter(color: color),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: compact ? 56 : 76,
              height: compact ? 56 : 76,
              decoration: BoxDecoration(
                color: const Color(0xFF17242C),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.10),
                    blurRadius: 28,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: FuzeEmblem(
                  size: compact ? 30 : 38,
                  color: FuzeVpnTheme.signal,
                ),
              ),
            ),
            Positioned(
              right: compact ? 12 : 23,
              bottom: compact ? 12 : 24,
              child: Container(
                width: compact ? 24 : 28,
                height: compact ? 24 : 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF17242C),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withValues(alpha: 0.5)),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ConnectionOrbitPainter extends CustomPainter {
  const _ConnectionOrbitPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = size.shortestSide / 2 - 8;
    final Paint orbit = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color.withValues(alpha: 0.18);
    canvas.drawCircle(center, radius, orbit);
    canvas.drawOval(
      Rect.fromCenter(center: center, width: radius * 1.28, height: radius * 2),
      orbit,
    );
    canvas.drawOval(
      Rect.fromCenter(center: center, width: radius * 2, height: radius * 0.69),
      orbit,
    );
    final Paint marker = Paint()..color = color.withValues(alpha: 0.65);
    canvas.drawCircle(Offset(center.dx, center.dy - radius), 2.5, marker);
    canvas.drawCircle(Offset(center.dx - radius, center.dy), 2.5, marker);
    canvas.drawCircle(Offset(center.dx + radius, center.dy), 2.5, marker);
  }

  @override
  bool shouldRepaint(_ConnectionOrbitPainter oldDelegate) =>
      oldDelegate.color != color;
}

class ConnectionLocationSelector extends StatelessWidget {
  const ConnectionLocationSelector({
    super.key,
    required this.controller,
    required this.onPressed,
    this.embedded = false,
  });

  final VpnAppController controller;
  final VoidCallback onPressed;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final currentId = _currentLocationId(controller);
    final Location? location = controller.locations
        .cast<Location?>()
        .firstWhere(
          (location) => location?.id == currentId,
          orElse: () => controller.activeDeviceLocation?.id == currentId
              ? controller.activeDeviceLocation
              : controller.selectedLocation?.id == currentId
              ? controller.selectedLocation
              : null,
        );
    final bool locked = !controller.canChangeLocation;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final String country = location == null
        ? ''
        : locationCountryName(
            location,
            Localizations.localeOf(context).toLanguageTag(),
          );
    final Widget content = Semantics(
      button: true,
      enabled: !locked,
      label: context.copy('connection.location'),
      value: location == null
          ? context.copy('connection.chooseLocation')
          : '${location.city}, $country',
      child: InkWell(
        onTap: locked ? null : onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 104),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool stacked =
                    constraints.maxWidth < 360 &&
                    MediaQuery.textScalerOf(context).scale(14) > 20;
                final Widget flag = Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: location == null
                      ? Icon(Icons.public, size: 24, color: scheme.onSurface)
                      : CountryFlag(
                          countryCode: location.countryCode,
                          width: 30,
                          height: 22,
                        ),
                );
                final Widget eyebrow = Text(
                  context.copy('connection.location'),
                  style: FuzeVpnTheme.mono(
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                  ),
                );
                final Widget arrow = Icon(
                  locked ? Icons.lock_outline : Icons.arrow_forward,
                  size: 20,
                  color: scheme.onSurfaceVariant,
                );
                final Widget details = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!stacked) ...<Widget>[
                      eyebrow,
                      const SizedBox(height: 2),
                    ],
                    Text(
                      location == null
                          ? context.copy('connection.chooseLocation')
                          : location.city,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (location != null) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        country,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (locked) ...<Widget>[
                      const SizedBox(height: 3),
                      Text(
                        _locationLockMessage(context, controller),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ] else ...<Widget>[
                      const SizedBox(height: 6),
                      Text(
                        context.copy('connection.changeLocation'),
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: scheme.onSurface),
                      ),
                    ],
                  ],
                );
                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          flag,
                          const SizedBox(width: 14),
                          Expanded(child: eyebrow),
                          const SizedBox(width: 8),
                          arrow,
                        ],
                      ),
                      const SizedBox(height: 14),
                      details,
                    ],
                  );
                }
                return Row(
                  children: <Widget>[
                    flag,
                    const SizedBox(width: 14),
                    Expanded(child: details),
                    const SizedBox(width: 8),
                    arrow,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
    if (embedded) {
      return Material(color: scheme.surface, child: content);
    }
    return Card(clipBehavior: Clip.antiAlias, child: content);
  }
}

class TunnelMetricsCard extends StatelessWidget {
  const TunnelMetricsCard({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: ExpansionTile(
      key: const PageStorageKey<String>('connection-details'),
      leading: const _ConnectionOptionIcon(icon: Icons.insights_outlined),
      title: Text(context.copy('connection.details')),
      subtitle: Text(
        _protocolLabel(
          controller.tunnelState.protocol ?? controller.selectedProtocol,
        ),
        style: FuzeVpnTheme.mono(
          fontSize: 11,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w400,
        ),
      ),
      childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: <Widget>[
        if (controller.tunnelState.connectedIpFamilies.isNotEmpty) ...<Widget>[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Chip(
              avatar: const Icon(Icons.language, size: 18),
              label: Text(
                context.copy(
                  controller.tunnelState.connectedIpFamilies.length == 2
                      ? 'network.dualStack'
                      : 'network.ipv4',
                ),
                key: const ValueKey('tunnel-ip-families'),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        _TunnelMetrics(
          state: controller.tunnelState,
          fallbackLocation:
              controller.activeDeviceLocation?.displayName ??
              controller.selectedLocation?.displayName,
        ),
      ],
    ),
  );
}

class _TunnelMetrics extends StatelessWidget {
  const _TunnelMetrics({required this.state, this.fallbackLocation});

  final VpnRuntimeState state;
  final String? fallbackLocation;

  @override
  Widget build(BuildContext context) {
    final String location = state.locationName ?? fallbackLocation ?? '—';
    final DateTime now = DateTime.now();
    final Duration? connectedFor = state.connectedAt == null
        ? null
        : now.difference(state.connectedAt!).isNegative
        ? Duration.zero
        : now.difference(state.connectedAt!);
    final Duration? handshakeAgo = state.latestHandshake == null
        ? null
        : now.difference(state.latestHandshake!).isNegative
        ? Duration.zero
        : now.difference(state.latestHandshake!);
    final List<_MetricValue> metrics = <_MetricValue>[
      _MetricValue(
        Icons.location_on_outlined,
        context.copy('connection.activeLocation'),
        location,
      ),
      _MetricValue(
        Icons.timer_outlined,
        context.copy('connection.duration'),
        connectedFor == null ? '—' : _formatDuration(connectedFor),
      ),
      _MetricValue(
        Icons.south_west,
        context.copy('connection.received'),
        state.receivedBytes == null ? '—' : _formatBytes(state.receivedBytes!),
      ),
      _MetricValue(
        Icons.north_east,
        context.copy('connection.sent'),
        state.sentBytes == null ? '—' : _formatBytes(state.sentBytes!),
      ),
      if (state.protocol == VpnProtocol.wireGuard)
        _MetricValue(
          Icons.sync_lock_outlined,
          context.copy('connection.lastHandshake'),
          handshakeAgo == null
              ? '—'
              : context.copy(
                  'connection.handshakeAgo',
                  arguments: <String, Object?>{
                    'duration': _formatDuration(handshakeAgo),
                  },
                ),
        ),
    ];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool useSingleColumn =
            constraints.maxWidth < 360 ||
            MediaQuery.textScalerOf(context).scale(14) > 20;
        final double width = useSingleColumn
            ? constraints.maxWidth
            : (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: metrics
              .map(
                (_MetricValue metric) => SizedBox(
                  width: width,
                  child: Semantics(
                    container: true,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                metric.icon,
                                size: 16,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  metric.label,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            metric.value,
                            style: FuzeVpnTheme.mono(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _MetricValue {
  const _MetricValue(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;
}

String _formatDuration(Duration value) {
  final int totalHours = value.inHours;
  final String minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
  final String seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
  return '${totalHours.toString().padLeft(2, '0')}:$minutes:$seconds';
}

String _formatBytes(int value) {
  const List<String> units = <String>['B', 'KiB', 'MiB', 'GiB', 'TiB'];
  double amount = value < 0 ? 0 : value.toDouble();
  int unit = 0;
  while (amount >= 1024 && unit < units.length - 1) {
    amount /= 1024;
    unit++;
  }
  final String formatted = unit == 0
      ? amount.toStringAsFixed(0)
      : amount >= 100
      ? amount.toStringAsFixed(0)
      : amount.toStringAsFixed(1);
  return '$formatted ${units[unit]}';
}

class LocationMigrationBanner extends StatelessWidget {
  const LocationMigrationBanner({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final DeviceLocationMigration migration = controller.locationMigration!;
    final Location? sourceLocation = controller.locations
        .cast<Location?>()
        .firstWhere(
          (Location? location) => location?.id == migration.sourceLocationId,
          orElse: () => null,
        );
    final String active =
        sourceLocation?.displayName ??
        (controller.activeDeviceLocation?.id == migration.sourceLocationId
            ? controller.activeDeviceLocation!.displayName
            : migration.sourceLocationId);
    final String target =
        controller.locations
            .cast<Location?>()
            .firstWhere(
              (Location? location) =>
                  location?.id == migration.targetLocationId,
              orElse: () => null,
            )
            ?.displayName ??
        migration.targetLocationId;
    final String message = switch (migration.status) {
      LocationMigrationStatus.draining => context.copy('migration.draining'),
      LocationMigrationStatus.activating => context.copy(
        'migration.activating',
      ),
      LocationMigrationStatus.ready => context.copy('migration.ready'),
      LocationMigrationStatus.blocked => context.copy('migration.blocked'),
    };
    final bool pending = migration.status.isPending;
    final bool activelyChecking = pending && controller.isConnecting;
    final double progress = switch (migration.status) {
      LocationMigrationStatus.draining => 0.35,
      LocationMigrationStatus.activating => 0.75,
      LocationMigrationStatus.ready => 1,
      LocationMigrationStatus.blocked => 0,
    };
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      color: migration.status == LocationMigrationStatus.blocked
          ? scheme.errorContainer
          : pending
          ? scheme.secondaryContainer
          : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: migration.status == LocationMigrationStatus.blocked
              ? scheme.error.withValues(alpha: 0.45)
              : scheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            activelyChecking
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(switch (migration.status) {
                    LocationMigrationStatus.draining =>
                      Icons.hourglass_top_rounded,
                    LocationMigrationStatus.activating => Icons.sync,
                    LocationMigrationStatus.ready => Icons.check_circle_outline,
                    LocationMigrationStatus.blocked => Icons.error_outline,
                  }),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context.copy('migration.title'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$active → $target',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(message),
                  if (migration.status !=
                      LocationMigrationStatus.blocked) ...<Widget>[
                    const SizedBox(height: 12),
                    Semantics(
                      label: context.copy('migration.progress'),
                      value: message,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 4,
                        ),
                      ),
                    ),
                  ],
                  if (pending) ...<Widget>[
                    const SizedBox(height: 8),
                    Text(
                      context.copy(
                        'migration.retryDelay',
                        arguments: <String, Object?>{
                          'seconds': migration.retryAfterSeconds ?? 2,
                        },
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  if (!controller.isConnecting &&
                      migration.status !=
                          LocationMigrationStatus.ready) ...<Widget>[
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: controller.resumeLocationMigration,
                      icon: const Icon(Icons.refresh),
                      label: Text(context.copy('migration.resume')),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProtocolOptions extends StatelessWidget {
  const ProtocolOptions({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final Location? selected = controller.selectedLocation;
    final VpnProtocol displayedProtocol = controller.isTunnelActive
        ? controller.tunnelState.protocol ?? controller.selectedProtocol
        : controller.selectedProtocol;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        key: const PageStorageKey<String>('connection-options'),
        leading: const _ConnectionOptionIcon(icon: Icons.tune_outlined),
        title: Text(context.copy('connection.advancedOptions')),
        subtitle: Text(
          '${context.copy('connection.protocol')} · ${_protocolLabel(displayedProtocol)}',
          style: FuzeVpnTheme.mono(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              context.copy('connection.protocol'),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: VpnProtocol.values
                  .map((VpnProtocol protocol) {
                    final bool available =
                        selected?.supports(protocol) ?? false;
                    return ChoiceChip(
                      selected: displayedProtocol == protocol,
                      onSelected: !controller.canSelectProtocol || !available
                          ? null
                          : (bool enabled) {
                              if (enabled) controller.selectProtocol(protocol);
                            },
                      avatar: Icon(
                        protocol == VpnProtocol.wireGuard
                            ? Icons.bolt
                            : Icons.key_outlined,
                      ),
                      label: Text(
                        available
                            ? _protocolLabel(protocol)
                            : context.copy(
                                'connection.unavailable',
                                arguments: <String, Object?>{
                                  'protocol': _protocolLabel(protocol),
                                },
                              ),
                      ),
                    );
                  })
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionOptionIcon extends StatelessWidget {
  const _ConnectionOptionIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 38,
    height: 38,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface),
  );
}

class PrimaryVpnAction extends StatelessWidget {
  const PrimaryVpnAction({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) {
    final bool busy =
        controller.isChangingLocation ||
        controller.isConnecting ||
        controller.isLocationMigrationPending ||
        controller.isStartingLocationMigration ||
        controller.isDisconnecting ||
        controller.tunnelState.phase == VpnRuntimePhase.authorizing ||
        controller.tunnelState.phase == VpnRuntimePhase.preparing ||
        controller.tunnelState.phase == VpnRuntimePhase.connecting ||
        controller.tunnelState.phase == VpnRuntimePhase.disconnecting;
    final ButtonStyle actionStyle = FilledButton.styleFrom(
      minimumSize: const Size(double.infinity, 60),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      backgroundColor: FuzeVpnTheme.signal,
      foregroundColor: FuzeVpnTheme.ink,
      disabledBackgroundColor: const Color(0xFF354149),
      disabledForegroundColor: const Color(0xFFC6BEB2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      textStyle: Theme.of(context).textTheme.titleMedium,
    );
    if (controller.canCancelConnectionAttempt && !controller.isConnected) {
      return FilledButton.icon(
        style: actionStyle,
        onPressed: controller.tunnelState.isReconnecting
            ? controller.requestUserDisconnect
            : controller.cancelConnectionAttempt,
        icon: const Icon(Icons.close),
        label: Text(context.copy('action.cancel'), textAlign: TextAlign.center),
      );
    }
    if (controller.isConnected ||
        controller.isDisconnecting ||
        controller.tunnelState.phase == VpnRuntimePhase.disconnecting) {
      final bool isStopping =
          controller.isDisconnecting ||
          controller.tunnelState.phase == VpnRuntimePhase.disconnecting;
      final Widget action = FilledButton.icon(
        style: actionStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? const Color(0xFF354149)
                : FuzeVpnTheme.paper,
          ),
        ),
        // A native CONNECTED event is sufficient proof to let the user stop
        // immediately. Do not keep this safety action disabled because an
        // unrelated controller future has not returned yet.
        onPressed: isStopping ? null : controller.requestUserDisconnect,
        icon: isStopping
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFC6BEB2),
                ),
              )
            : const Icon(Icons.power_settings_new, size: 26),
        label: Text(
          context.copy(
            isStopping ? 'connection.disconnecting' : 'connection.disconnect',
          ),
          textAlign: TextAlign.center,
        ),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          action,
          if (controller.supportsSystemProtectionSettings &&
              controller.systemProtection.alwaysOn != false) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              context.copy('connection.androidDisconnectHint'),
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFFC6BEB2)),
            ),
          ],
        ],
      );
    }
    return FilledButton.icon(
      style: actionStyle,
      onPressed: busy || controller.isIdentityBusy ? null : controller.connect,
      icon: busy
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFC6BEB2),
              ),
            )
          : const Icon(Icons.power_settings_new, size: 26),
      label: Text(
        controller.isChangingLocation || controller.isLocationMigrationPending
            ? context.copy('connection.locationChange')
            : busy
            ? context.copy('connection.connecting')
            : context.copy('connection.connect'),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TunnelTrustNote extends StatelessWidget {
  const TunnelTrustNote({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.info_outline,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            context.copy('trust.note'),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    ),
  );
}
