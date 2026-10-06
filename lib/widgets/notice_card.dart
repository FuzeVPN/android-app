import 'package:flutter/material.dart';

import '../app_controller.dart';
import '../app_theme.dart';
import '../l10n/app_copy.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key, required this.notice, required this.onDismiss});

  final AppNotice? notice;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final AppNotice? current = notice;
    if (current == null) return const SizedBox.shrink();
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool confirmation =
        current.titleKey == 'notice.controller.title' &&
        const {
          'password_reset_sent',
          'verification_email_sent',
          'device_revoked',
        }.contains(current.arguments['code']);
    final bool information =
        current.titleKey == 'notice.controller.title' &&
        const {
          'location_migration_pending',
          'location_migration_slow',
        }.contains(current.arguments['code']);
    final Color foreground = confirmation
        ? scheme.onSecondaryContainer
        : information
        ? scheme.onSurface
        : scheme.onErrorContainer;
    if (current.messageKey == 'network.ipv4Fallback') {
      return Semantics(
        liveRegion: true,
        child: Row(
          children: [
            const Icon(Icons.info_outline, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                context.copy(current.messageKey),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            IconButton(
              onPressed: onDismiss,
              icon: const Icon(Icons.close, size: 18),
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            ),
          ],
        ),
      );
    }
    final message = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          context.copy(current.titleKey, arguments: current.arguments),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.copy(current.messageKey, arguments: current.arguments),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: foreground),
        ),
        if (current.diagnosticCode != null) ...<Widget>[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: foreground.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: SelectableText(
              context.copy(
                'notice.diagnosticCode',
                arguments: <String, Object?>{'code': current.diagnosticCode!},
              ),
              style: FuzeVpnTheme.mono(fontSize: 12, color: foreground),
            ),
          ),
        ],
      ],
    );
    final icon = Icon(
      confirmation
          ? Icons.check_circle_outline
          : information
          ? Icons.info_outline
          : Icons.error_outline,
      color: foreground,
      size: 22,
    );
    final closeButton = SizedBox(
      width: 48,
      child: IconButton(
        tooltip: context.copy('notice.close'),
        onPressed: onDismiss,
        icon: Icon(Icons.close, color: foreground, size: 20),
      ),
    );
    return Semantics(
      liveRegion: true,
      child: Card(
        color: confirmation
            ? scheme.secondaryContainer
            : information
            ? scheme.surfaceContainerHigh
            : scheme.errorContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: foreground.withValues(alpha: 0.24)),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 8, 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 360 &&
                  MediaQuery.textScalerOf(context).scale(1) > 1.4) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: [icon, const Spacer(), closeButton]),
                    const SizedBox(height: 8),
                    message,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(top: 2), child: icon),
                  const SizedBox(width: 12),
                  Expanded(child: message),
                  closeButton,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
