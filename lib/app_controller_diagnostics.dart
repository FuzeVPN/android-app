part of 'app_controller.dart';

/// Diagnostics observe the application. No method here mutates VPN state,
/// restores credentials, probes a remote host or weakens system protection.
extension VpnDiagnostics on VpnAppController {
  bool get automaticDiagnostics => _diagnostics?.automaticConsent ?? false;
  bool get diagnosticsBusy =>
      _diagnosticsCollecting ||
      _diagnosticsPreferenceSaving ||
      (_diagnostics?.isSending ?? false);
  DiagnosticReport? get diagnosticReport => _diagnostics?.preparedReport;
  DiagnosticStatus get diagnosticStatus =>
      _diagnostics?.status ?? DiagnosticStatus.idle;
  DiagnosticReceipt? get diagnosticReceipt => _diagnostics?.lastReceipt;
  bool get diagnosticCanRetry => _diagnostics?.canRetry ?? false;
  bool get canExportDiagnosticReport =>
      diagnosticReport != null && _tunnel is DiagnosticPlatformGateway;

  void _diagnosticsChanged() {
    if (!_disposed) _notifyDiagnosticListeners();
  }

  void _syncDiagnosticSession() {
    final valid =
        isSignedIn &&
        sessionTermination == null &&
        _session!.expiresAt.isAfter(DateTime.now());
    _diagnostics?.setSession(
      accountId: valid ? profile!.userId : null,
      token: valid ? token : null,
      expiresAt: valid ? _session!.expiresAt : null,
    );
  }

  Future<void> _initializeDiagnostics() async {
    final service = _diagnostics;
    if (service == null) return;
    final preferenceEpoch = _diagnosticPreferenceEpoch;
    try {
      final preferences = _preferences;
      final enabled = preferences is DiagnosticPreferenceStore
          ? await (preferences as DiagnosticPreferenceStore)
                .readAutomaticDiagnostics()
                .timeout(const Duration(seconds: 2))
          : false;
      if (_disposed || preferenceEpoch != _diagnosticPreferenceEpoch) return;
      service.setAutomaticConsent(enabled);
    } catch (_) {
      if (_disposed || preferenceEpoch != _diagnosticPreferenceEpoch) return;
      service.setAutomaticConsent(false);
    }
    try {
      await _loadDiagnosticMetadata();
    } catch (_) {
      // Missing observations disable preparation, never application startup.
    }
  }

  Future<void> _loadDiagnosticMetadata() async {
    final platform = _tunnel;
    if (platform is! DiagnosticPlatformGateway) return;
    final metadata = await (platform as DiagnosticPlatformGateway)
        .diagnosticMetadata()
        .timeout(const Duration(seconds: 3));
    if (!_disposed) _diagnostics?.setMetadata(metadata);
  }

  Future<void> setAutomaticDiagnostics(bool enabled) async {
    if (_disposed || _diagnostics == null) return;
    _diagnosticsPreferenceSaving = true;
    final epoch = ++_diagnosticPreferenceEpoch;
    diagnosticsPreferenceFailed = false;
    // Revocation takes effect immediately, even if persisting the setting fails.
    if (!enabled) _diagnostics.setAutomaticConsent(false);
    notifyListeners();
    try {
      final preferences = _preferences;
      if (preferences is! DiagnosticPreferenceStore) {
        throw StateError('diagnostics_preference_unavailable');
      }
      // A timeout cannot cancel a native write. Keep their actual completion
      // order so a late enable can never undo a more recent revocation.
      final write = _diagnosticPreferenceWrites.then(
        (_) => (preferences as DiagnosticPreferenceStore)
            .writeAutomaticDiagnostics(enabled),
      );
      _diagnosticPreferenceWrites = write.then<void>(
        (_) {},
        onError: (Object _) {},
      );
      await write;
      if (!_disposed && epoch == _diagnosticPreferenceEpoch) {
        _diagnostics.setAutomaticConsent(enabled);
      }
    } catch (_) {
      if (!_disposed && epoch == _diagnosticPreferenceEpoch) {
        diagnosticsPreferenceFailed = true;
      }
    } finally {
      if (epoch == _diagnosticPreferenceEpoch) {
        _diagnosticsPreferenceSaving = false;
      }
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> runDiagnostics({required bool sendReport}) async {
    final service = _diagnostics;
    if (_disposed || service == null || diagnosticsBusy) return;
    _syncDiagnosticSession();
    final epoch = ++_diagnosticCollectionEpoch;
    final consentEpoch = ++_diagnosticManualConsentEpoch;
    final operation = _sessionOperation;
    final account = profile?.userId;
    bool current() =>
        !_disposed &&
        epoch == _diagnosticCollectionEpoch &&
        identical(operation, _sessionOperation) &&
        profile?.userId == account;
    _diagnosticsCollecting = true;
    diagnosticsPreparationFailed = false;
    diagnosticExportFailed = false;
    notifyListeners();
    try {
      await _loadDiagnosticMetadata();
      if (!current()) return;
      VpnRuntimeState? observed;
      try {
        if (_tunnel is DiagnosticPlatformGateway) {
          observed = await (_tunnel as DiagnosticPlatformGateway)
              .diagnosticSnapshot()
              .timeout(const Duration(seconds: 3));
        }
      } catch (_) {
        /* An unobserved state remains unknown. */
      }
      if (!current()) return;
      final sample = observed ?? tunnelState;
      SystemVpnProtection protection =
          observed?.systemProtection ?? const SystemVpnProtection();
      if (_tunnel is VpnSystemProtectionGateway) {
        try {
          protection = await (_tunnel as VpnSystemProtectionGateway)
              .getSystemVpnProtection()
              .timeout(const Duration(seconds: 3));
        } catch (_) {
          /* Preserve only independently observed fields. */
        }
      }
      if (!current()) return;
      final protocol = sample.protocol ?? selectedProtocol;
      // Business certificate/storage reads may clean corrupt records. A
      // diagnostic must not invoke them merely to populate an optional field.
      if (!current()) return;
      final now = DateTime.now();
      final snapshot = <String, Object?>{
        'phase': observed == null ? 'unknown' : _diagnosticPhase(sample.phase),
        if (observed != null && sample.ipFamilies.isNotEmpty)
          'ip_families': sample.ipFamilies,
        if (protection.alwaysOn != null) 'always_on': protection.alwaysOn,
        if (protection.lockdown != null) 'lockdown': protection.lockdown,
        if (observed != null &&
            sample.isConnected &&
            sample.connectedAt != null)
          'connection_duration_ms': now
              .difference(sample.connectedAt!)
              .inMilliseconds,
        if (observed != null && sample.latestHandshake != null)
          'handshake_age_ms': now
              .difference(sample.latestHandshake!)
              .inMilliseconds,
        if (observed != null && sample.sentBytes != null)
          'bytes_sent': sample.sentBytes,
        if (observed != null && sample.receivedBytes != null)
          'bytes_received': sample.receivedBytes,
        'recovery_state': switch (protection.resumeState) {
          SystemProtectionResumeState.waitingNetwork => 'pending',
          SystemProtectionResumeState.restoring => 'retrying',
          SystemProtectionResumeState.blocked => 'failed',
          _ => 'unknown',
        },
        if (sessionTermination != null)
          'cleanup_state': sessionTermination!.isComplete
              ? 'completed'
              : sessionTermination!.inProgress
              ? 'pending'
              : 'failed',
      };
      final checks = <Map<String, Object?>>[
        {
          'id': 'tunnel_connection',
          'result': observed == null
              ? 'unknown'
              : sample.isConnected
              ? 'passed'
              : sample.phase == VpnRuntimePhase.error
              ? 'failed'
              : 'skipped',
          if (observed != null &&
              sample.phase == VpnRuntimePhase.error &&
              sample.messageCode != null)
            'code': sample.messageCode,
        },
        {'id': 'handshake', 'result': 'unknown'},
        {'id': 'certificate', 'result': 'skipped'},
        // Settings do not prove that traffic is blocked or routed correctly.
        {'id': 'kill_switch', 'result': 'unknown'},
        {'id': 'connectivity', 'result': 'skipped'},
        {'id': 'api_reachability', 'result': 'skipped'},
        {'id': 'secure_storage', 'result': 'skipped'},
      ];
      final report = service.prepareFull(
        snapshot: snapshot,
        checks: checks,
        state: observed == null ? 'unknown' : _diagnosticState(sample),
        protocol: protocol.apiValue,
      );
      if (sendReport &&
          current() &&
          consentEpoch == _diagnosticManualConsentEpoch) {
        _syncDiagnosticSession();
        await service.sendManual(report);
      }
    } catch (_) {
      if (current()) diagnosticsPreparationFailed = true;
    } finally {
      if (epoch == _diagnosticCollectionEpoch) _diagnosticsCollecting = false;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> retryDiagnosticReport() async {
    if (_disposed || diagnosticsBusy) return;
    _syncDiagnosticSession();
    await _diagnostics?.retryManual();
  }

  Future<void> exportDiagnosticReport() async {
    final report = diagnosticReport;
    final platform = _tunnel;
    if (report == null || platform is! DiagnosticPlatformGateway) return;
    diagnosticExportFailed = false;
    try {
      await (platform as DiagnosticPlatformGateway).exportDiagnosticReport(
        report.json,
      );
    } catch (_) {
      if (!_disposed) diagnosticExportFailed = true;
    }
    if (!_disposed) notifyListeners();
  }

  void clearDiagnosticReport() {
    _diagnosticManualConsentEpoch++;
    _diagnosticCollectionEpoch++;
    _diagnosticsCollecting = false;
    diagnosticsPreparationFailed = false;
    diagnosticExportFailed = false;
    _diagnostics?.clearPrepared();
    if (!_disposed) notifyListeners();
  }

  void cancelDiagnosticSending() {
    _diagnosticManualConsentEpoch++;
    _diagnostics?.cancelManual();
  }

  void _recordDiagnosticError(
    String code, {
    String domain = 'tunnel',
    VpnProtocol? protocol,
    int? httpStatus,
  }) {
    if (_disposed || _diagnostics == null) return;
    try {
      _syncDiagnosticSession();
      final stage = _diagnosticErrorStage(code, domain);
      _diagnostics.recordError(
        code,
        domain: domain,
        stage: stage,
        operation: stage == 'disconnect' || stage == 'cleanup'
            ? 'disconnect'
            : stage == 'recovery'
            ? 'restore'
            : stage == 'certificate_renewal'
            ? 'renew'
            : domain == 'api'
            ? 'refresh'
            : 'connect',
        protocol:
            (protocol ?? tunnelState.protocol ?? selectedProtocol).apiValue,
        state: 'error',
        httpStatus: httpStatus,
      );
    } catch (_) {
      /* Diagnostics cannot replace a business error. */
    }
  }

  void _recordDiagnosticState(VpnRuntimeState state) {
    if (state.phase == tunnelState.phase &&
        state.messageCode == tunnelState.messageCode) {
      return;
    }
    try {
      _syncDiagnosticSession();
      _diagnostics?.recordEvent(
        source: 'native',
        stage: _diagnosticPhase(state.phase),
        event: state.phase == VpnRuntimePhase.error ? 'error' : 'info',
        code: state.phase == VpnRuntimePhase.error ? state.messageCode : null,
      );
      if (state.phase == VpnRuntimePhase.error && state.messageCode != null) {
        _recordDiagnosticError(state.messageCode!, protocol: state.protocol);
      }
    } catch (_) {
      /* Observation must not influence state handling. */
    }
  }

  void _recordDiagnosticTiming(
    String stage,
    String event,
    int duration,
    int? status,
  ) {
    if (_disposed) return;
    _syncDiagnosticSession();
    _diagnostics?.recordEvent(
      source: 'flutter',
      stage: _diagnosticTimingStage(stage),
      event: event == 'event' ? 'info' : event,
      durationMs: duration,
      httpStatus: status,
    );
  }
}

String _diagnosticState(VpnRuntimeState state) => state.isReconnecting
    ? 'recovering'
    : switch (state.phase) {
        VpnRuntimePhase.idle => 'disconnected',
        VpnRuntimePhase.authorizing ||
        VpnRuntimePhase.preparing ||
        VpnRuntimePhase.connecting => 'connecting',
        _ => state.phase.name,
      };

String _diagnosticPhase(VpnRuntimePhase phase) => switch (phase) {
  VpnRuntimePhase.idle || VpnRuntimePhase.connected => 'completed',
  VpnRuntimePhase.authorizing => 'authentication',
  VpnRuntimePhase.preparing => 'enrollment',
  VpnRuntimePhase.connecting => 'handshake',
  VpnRuntimePhase.disconnecting => 'disconnect',
  VpnRuntimePhase.error => 'unknown',
};

String _diagnosticErrorStage(String code, String domain) {
  if (code.contains('storage')) return 'storage';
  if (code.contains('stop') || code.contains('disconnect')) return 'disconnect';
  if (code.contains('cleanup') || code.contains('clear_failed')) {
    return 'cleanup';
  }
  if (code.contains('resume') || code.contains('recovery')) return 'recovery';
  if (code.contains('renew')) return 'certificate_renewal';
  if (code.startsWith('tls_') || code.contains('handshake')) return 'handshake';
  if (code.contains('certificate')) return 'certificate';
  if (code.startsWith('tun_')) return 'adapter_create';
  if (code.contains('service')) return 'service_start';
  if (domain == 'api') return 'api_response';
  return 'tunnel_start';
}

String _diagnosticTimingStage(String stage) {
  if (stage.startsWith('storage.')) return 'storage';
  if (stage == 'http.open') return 'api_request';
  if (stage.startsWith('http.')) return 'api_response';
  if (stage.contains('disconnect') || stage.contains('stop')) {
    return 'disconnect';
  }
  if (stage.contains('renew')) return 'certificate_renewal';
  if (stage.contains('revoke')) return 'profile_revoke';
  if (stage.contains('csr') || stage.contains('certificate')) {
    return 'certificate';
  }
  if (stage.startsWith('prepare.')) return 'enrollment';
  if (stage.contains('handshake')) return 'handshake';
  if (stage.contains('connect')) return 'tunnel_start';
  return 'unknown';
}
