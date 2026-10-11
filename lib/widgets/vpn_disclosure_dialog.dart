// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';

import '../core/public_links.dart';
import '../l10n/generated/app_localizations.dart';
import 'external_link.dart';
import 'fuze_brand.dart';

/// A separate, explicit explanation before Android's VPN permission request.
///
/// Only the positive action returns true. Closing, returning, or opening the
/// privacy page never records consent. Persistence and Android permission
/// checks belong to the tunnel boundary, rather than this presentation widget.
Future<bool> showVpnDisclosureDialog(BuildContext context) async =>
    await showDialog<bool>(
      context: context,
      routeSettings: const RouteSettings(name: 'vpn-disclosure'),
      builder: (_) => const VpnDisclosureDialog(),
    ) ??
    false;

class VpnDisclosureDialog extends StatelessWidget {
  const VpnDisclosureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Dialog(
      key: const ValueKey('vpn-disclosure-dialog'),
      constraints: const BoxConstraints(maxWidth: 480),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Column(
        key: const ValueKey('vpn-disclosure-panel'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              key: const ValueKey('vpn-disclosure-scroll'),
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const FuzeBrand(emblemSize: 28),
                  const SizedBox(height: 20),
                  Semantics(
                    header: true,
                    child: Text(
                      copy.vpnDisclosure_title,
                      key: const ValueKey('vpn-disclosure-title'),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 24,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    copy.vpnDisclosure_body,
                    key: const ValueKey('vpn-disclosure-body'),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    copy.vpnDisclosure_dataBody,
                    key: const ValueKey('vpn-disclosure-data'),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    copy.vpnDisclosure_statusBody,
                    key: const ValueKey('vpn-disclosure-status'),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    key: const ValueKey('vpn-disclosure-privacy'),
                    onPressed: () => openExternalLink(
                      context,
                      PublicLinks.privacy(Localizations.localeOf(context)),
                    ),
                    child: Text(copy.vpnDisclosure_privacy),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FilledButton(
                  key: const ValueKey('vpn-disclosure-accept'),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    copy.vpnDisclosure_accept,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  key: const ValueKey('vpn-disclosure-decline'),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    copy.vpnDisclosure_decline,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
