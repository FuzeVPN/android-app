part of 'home_shell.dart';

class _DiagnosticsSettingsCard extends StatefulWidget {
  const _DiagnosticsSettingsCard({required this.controller});
  final VpnAppController controller;

  @override
  State<_DiagnosticsSettingsCard> createState() =>
      _DiagnosticsSettingsCardState();
}

class _DiagnosticsSettingsCardState extends State<_DiagnosticsSettingsCard> {
  bool _saving = false;

  Future<void> _setAutomatic(bool enabled) async {
    setState(() => _saving = true);
    try {
      await widget.controller.setAutomaticDiagnostics(enabled);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    key: const ValueKey('diagnostics-settings-card'),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _AccountIcon(icon: Icons.health_and_safety_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.copy('diagnostics.settingsTitle'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 6),
          SwitchListTile.adaptive(
            key: const ValueKey('automatic-diagnostics-toggle'),
            contentPadding: EdgeInsets.zero,
            title: Text(context.copy('diagnostics.automaticTitle')),
            subtitle: Text(context.copy('diagnostics.automaticDescription')),
            value: widget.controller.automaticDiagnostics,
            onChanged: _saving ? null : _setAutomatic,
          ),
          const SizedBox(height: 8),
          _DiagnosticPrivacyNote(text: context.copy('diagnostics.privacy')),
          if (widget.controller.diagnosticsPreferenceFailed) ...[
            const SizedBox(height: 10),
            _DiagnosticMessage(
              text: context.copy('diagnostics.preferenceFailed'),
              error: true,
            ),
          ],
          const SizedBox(height: 20),
          OutlinedButton.icon(
            key: const ValueKey('open-diagnostics'),
            onPressed: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (_) => DiagnosticsPage(controller: widget.controller),
              ),
            ),
            icon: const Icon(Icons.fact_check_outlined),
            label: Text(context.copy('diagnostics.manualOpen')),
          ),
        ],
      ),
    ),
  );
}

class DiagnosticsPage extends StatefulWidget {
  const DiagnosticsPage({super.key, required this.controller});
  final VpnAppController controller;

  @override
  State<DiagnosticsPage> createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
  // Automatic error sharing never grants consent for this manual report.
  bool _sendReport = false;
  String? _consentAccount;

  @override
  void initState() {
    super.initState();
    _consentAccount = widget.controller.profile?.userId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.controller.cancelDiagnosticSending();
    });
  }

  Future<void> _run() async {
    widget.controller.clearDiagnosticReport();
    await widget.controller.runDiagnostics(
      sendReport: _sendReport && widget.controller.isSignedIn,
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final controller = widget.controller;
      final report = controller.diagnosticReport;
      final status = controller.diagnosticStatus;
      final busy = controller.diagnosticsBusy;
      final canSend = controller.isSignedIn;
      final account = controller.profile?.userId;
      if (account != _consentAccount || !canSend) {
        _sendReport = false;
        _consentAccount = account;
      }
      return Scaffold(
        key: const ValueKey('diagnostics-page'),
        appBar: AppBar(title: Text(context.copy('diagnostics.title'))),
        body: SafeArea(
          top: false,
          child: _PageBody(
            children: [
              FuzePageHeader(
                title: context.copy('diagnostics.heading'),
                description: context.copy('diagnostics.localDescription'),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CheckboxListTile(
                        key: const ValueKey('diagnostics-send-report'),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(context.copy('diagnostics.sendReport')),
                        subtitle: Text(context.copy('diagnostics.sendHint')),
                        value: _sendReport && canSend,
                        onChanged: !canSend || (busy && !_sendReport)
                            ? null
                            : (value) {
                                final enabled = value ?? false;
                                setState(() => _sendReport = enabled);
                                if (!enabled) {
                                  controller.cancelDiagnosticSending();
                                }
                              },
                      ),
                      const SizedBox(height: 8),
                      _DiagnosticPrivacyNote(
                        text: context.copy('diagnostics.privacy'),
                      ),
                      if (!canSend) ...[
                        const SizedBox(height: 10),
                        Text(context.copy('diagnostics.signedOut')),
                      ],
                      const SizedBox(height: 20),
                      FilledButton.icon(
                        key: const ValueKey('run-diagnostics'),
                        onPressed: busy ? null : _run,
                        icon: busy
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.fact_check_outlined),
                        label: Text(
                          context.copy(
                            report == null
                                ? 'diagnostics.run'
                                : 'diagnostics.rerun',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (busy ||
                  status != DiagnosticStatus.idle ||
                  controller.diagnosticsPreparationFailed)
                _DiagnosticMessage(
                  key: const ValueKey('diagnostics-status'),
                  text: context.copy(
                    controller.diagnosticsPreparationFailed
                        ? 'diagnostics.preparationFailed'
                        : _diagnosticStatusKey(status, busy),
                  ),
                  error:
                      controller.diagnosticsPreparationFailed ||
                      status == DiagnosticStatus.failed ||
                      status == DiagnosticStatus.authenticationRequired,
                ),
              if (controller.diagnosticReceipt case final receipt?) ...[
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _AccountIcon(
                              icon: Icons.mark_email_read_outlined,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                context.copy('diagnostics.sent'),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Divider(height: 1),
                        const SizedBox(height: 14),
                        SelectableText(
                          context.copy(
                            'diagnostics.receipt',
                            arguments: {'id': receipt.serverReportId},
                          ),
                          key: const ValueKey('diagnostics-receipt'),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.copy(
                            'diagnostics.received',
                            arguments: {
                              'date': _formatDate(context, receipt.receivedAt),
                            },
                          ),
                        ),
                        Text(
                          context.copy(
                            'diagnostics.expires',
                            arguments: {
                              'date': _formatDate(context, receipt.expiresAt),
                            },
                          ),
                        ),
                        if (receipt.duplicate)
                          Text(context.copy('diagnostics.duplicate')),
                      ],
                    ),
                  ),
                ),
              ],
              if (controller.diagnosticCanRetry) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  key: const ValueKey('retry-diagnostic-report'),
                  onPressed: busy || !_sendReport || !canSend
                      ? null
                      : controller.retryDiagnosticReport,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.copy('diagnostics.retry')),
                ),
              ],
              if (report != null) ...[
                const SizedBox(height: 20),
                _DiagnosticPreview(report: report),
                const SizedBox(height: 12),
                Text(
                  context.copy('diagnostics.localLifetime'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  key: const ValueKey('export-diagnostic-report'),
                  onPressed: busy || !controller.canExportDiagnosticReport
                      ? null
                      : controller.exportDiagnosticReport,
                  icon: const Icon(Icons.save_alt),
                  label: Text(context.copy('diagnostics.export')),
                ),
                if (controller.diagnosticExportFailed) ...[
                  const SizedBox(height: 12),
                  _DiagnosticMessage(
                    text: context.copy('diagnostics.exportFailed'),
                    error: true,
                  ),
                ],
              ] else if (!busy) ...[
                const SizedBox(height: 20),
                FuzeEmptyState(
                  icon: Icons.fact_check_outlined,
                  title: context.copy('diagnostics.empty'),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

class _DiagnosticPrivacyNote extends StatelessWidget {
  const _DiagnosticPrivacyNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.lock_outline,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    ),
  );
}

String _diagnosticStatusKey(DiagnosticStatus status, bool busy) =>
    switch (status) {
      DiagnosticStatus.sending => 'diagnostics.sending',
      DiagnosticStatus.queued => 'diagnostics.queued',
      DiagnosticStatus.sent => 'diagnostics.sent',
      DiagnosticStatus.failed => 'diagnostics.failed',
      DiagnosticStatus.authenticationRequired =>
        'diagnostics.authenticationRequired',
      _ => busy ? 'diagnostics.running' : 'diagnostics.prepared',
    };

class _DiagnosticMessage extends StatelessWidget {
  const _DiagnosticMessage({super.key, required this.text, this.error = false});
  final String text;
  final bool error;
  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: error
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: error
              ? Theme.of(context).colorScheme.error.withValues(alpha: .3)
              : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            error ? Icons.error_outline : Icons.info_outline,
            color: error
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSecondaryContainer,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: error
                    ? Theme.of(context).colorScheme.onErrorContainer
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _DiagnosticPreview extends StatelessWidget {
  const _DiagnosticPreview({required this.report});
  final DiagnosticReport report;

  @override
  Widget build(BuildContext context) {
    final checks = report.toJson()['checks'];
    return Card(
      key: const ValueKey('diagnostic-report-preview'),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AccountIcon(icon: Icons.fact_check_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.copy('diagnostics.preview'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              context.copy(
                'diagnostics.eventCount',
                arguments: {'count': report.eventCount},
              ),
            ),
            const SizedBox(height: 16),
            if (checks is List)
              for (final check in checks.whereType<Map<Object?, Object?>>())
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _DiagnosticCheck(check: check),
                ),
            ExpansionTile(
              key: const ValueKey('diagnostic-technical-details'),
              tilePadding: EdgeInsets.zero,
              leading: const Icon(Icons.code, size: 20),
              title: Text(context.copy('diagnostics.technical')),
              children: [
                SelectableText(
                  report.json,
                  key: const ValueKey('diagnostic-report-json'),
                  style: FuzeVpnTheme.mono(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DiagnosticCheck extends StatelessWidget {
  const _DiagnosticCheck({required this.check});
  final Map<Object?, Object?> check;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final result = check['result'];
    final color = result == 'failed'
        ? scheme.error
        : result == 'passed'
        ? scheme.secondary
        : scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            switch (result) {
              'passed' => Icons.check_circle_outline,
              'failed' => Icons.error_outline,
              'skipped' => Icons.remove_circle_outline,
              _ => Icons.help_outline,
            },
            size: 20,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.copy(
                    'diagnostics.checkName',
                    arguments: {'id': check['id'] ?? ''},
                  ),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  context.copy(
                    'diagnostics.checkResult',
                    arguments: {'result': result ?? ''},
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
