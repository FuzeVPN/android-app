import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_theme.dart';
import '../l10n/app_copy.dart';
import 'fuze_design.dart';

/// Offers a usable address when Android cannot open the public page.
Future<void> openExternalLink(BuildContext context, Uri url) async {
  bool opened = false;
  try {
    opened = await launchUrl(url, mode: LaunchMode.externalApplication);
  } on Exception {
    // A missing browser and a platform launch refusal use the same fallback.
  }
  if (opened || !context.mounted) return;
  await showDialog<void>(
    context: context,
    builder: (_) => _ExternalLinkFailureDialog(url: url),
  );
}

class _ExternalLinkFailureDialog extends StatefulWidget {
  const _ExternalLinkFailureDialog({required this.url});
  final Uri url;

  @override
  State<_ExternalLinkFailureDialog> createState() =>
      _ExternalLinkFailureDialogState();
}

class _ExternalLinkFailureDialogState
    extends State<_ExternalLinkFailureDialog> {
  bool _copying = false;
  String? _copyStatus;

  Future<void> _copy() async {
    setState(() => _copying = true);
    String status;
    try {
      await Clipboard.setData(ClipboardData(text: widget.url.toString()));
      status = 'externalLink.copied';
    } on Exception {
      status = 'externalLink.copyFailed';
    }
    if (!mounted) return;
    setState(() {
      _copying = false;
      _copyStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    scrollable: true,
    icon: Center(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.open_in_new,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    ),
    title: Text(
      context.copy('externalLink.failed'),
      style: Theme.of(context).textTheme.titleMedium,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FuzePanel(
          tone: FuzePanelTone.wash,
          padding: const EdgeInsets.all(14),
          child: SelectableText(
            widget.url.toString(),
            textDirection: TextDirection.ltr,
            style: FuzeVpnTheme.mono(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        if (_copyStatus != null) ...<Widget>[
          const SizedBox(height: 12),
          Semantics(
            liveRegion: true,
            child: Text(
              context.copy(_copyStatus!),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _copyStatus == 'externalLink.copyFailed'
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(MaterialLocalizations.of(context).closeButtonLabel),
      ),
      FilledButton.icon(
        key: const ValueKey('copy-external-link'),
        onPressed: _copying ? null : _copy,
        icon: const Icon(Icons.copy_outlined),
        label: Text(context.copy('externalLink.copy')),
      ),
    ],
  );
}
