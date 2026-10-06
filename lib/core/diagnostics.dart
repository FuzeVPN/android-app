import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'api_client.dart';
import 'connection_timing.dart';
import 'diagnostic_schema.dart';

export 'diagnostic_schema.dart'
    show DiagnosticCheck, DiagnosticError, DiagnosticEvent, DiagnosticSnapshot;

enum DiagnosticSendStatus {
  idle,
  prepared,
  sending,
  queued,
  sent,
  failed,
  authenticationRequired,
}

typedef DiagnosticStatus = DiagnosticSendStatus;

/// Intentionally separate from ApiFailure: this endpoint never revokes a VPN session.
class DiagnosticFailure implements Exception {
  const DiagnosticFailure(
    this.code, {
    this.httpStatus,
    this.retryAfterSeconds,
    this.retryable = false,
  });
  final String code;
  final int? httpStatus;
  final int? retryAfterSeconds;
  final bool retryable;
  @override
  String toString() => 'DiagnosticFailure($code)';
}

class DiagnosticReceipt {
  const DiagnosticReceipt({
    required this.serverReportId,
    required this.clientReportId,
    required this.receivedAt,
    required this.expiresAt,
    required this.duplicate,
  });
  final String serverReportId;
  final String clientReportId;
  final DateTime receivedAt;
  final DateTime expiresAt;
  final bool duplicate;
}

class DiagnosticReport implements DiagnosticReportView {
  DiagnosticReport._({
    required this.reportId,
    required this.json,
    required this.createdAt,
    required this.eventCount,
    required this.reportType,
    required this.automatic,
    required this._owner,
    required this._account,
    required this._generation,
    required this._collectedAt,
  }) : byteLength = utf8.encode(json).length;

  @override
  final String reportId;
  @override
  final String json;
  @override
  final int byteLength;
  @override
  final DateTime createdAt;
  @override
  final int eventCount;
  final String reportType;
  final bool automatic;
  final Object _owner;
  final String? _account;
  final int _generation;
  final int _collectedAt;
  final _Delivery _delivery = _Delivery();
  @override
  Map<String, Object?> toJson() => diagnosticJsonCopy(json);
  @override
  String toString() =>
      'DiagnosticReport(type: $reportType, bytes: $byteLength)';
}

class _Delivery {
  int revision = 0;
  int attempts = 0;
  int nextAt = 0;
  String? rejectedToken;
  bool terminal = false;
  DiagnosticFailure? failure;
  DiagnosticReceipt? receipt;
}

class _TimedEvent {
  const _TimedEvent(this.at, this.event);
  final int at;
  final DiagnosticEvent event;
}

/// In-memory only. It owns no authentication, tunnel, storage or transport lifetime.
class DiagnosticService extends ChangeNotifier {
  DiagnosticService({
    required ApiHttpTransport transport,
    required Uri baseUri,
    DateTime Function()? now,
    int Function()? monotonicMilliseconds,
    this.scheduleRetries = true,
  }) : _sender = _DiagnosticSender(transport, baseUri),
       _now = now ?? DateTime.now,
       _externalTick = monotonicMilliseconds;

  static const maxQueueBytes = 2 * 1024 * 1024;
  static const maxEvents = 1000;
  static const eventWindowMs = 600000;
  static const queueTtlMs = 24 * 60 * 60 * 1000;
  static const maxAttempts = 3;
  static const _importantCodes = {
    'certificate_expired',
    'certificate_invalid',
    'certificate_validation_failed',
    'csr_generation_failed',
    'invalid_activation_response',
    'invalid_api_response',
    'invalid_configuration',
    'invalid_device_configuration',
    'key_generation_failed',
    'key_unavailable',
    'handshake_timeout',
    'secure_storage_corrupt',
    'secure_storage_read_failed',
    'secure_storage_write_failed',
    'storage_corrupt',
    'storage_decryption_failed',
    'storage_failure',
    'native_bridge_unavailable',
    'native_operation_failed',
    'runtime_unavailable',
    'openvpn_core_stalled',
    'openvpn_core_status_error',
    'openvpn_core_unavailable',
    'openvpn_cleanup_failed',
    'openvpn_activation_invalid',
    'openvpn_certificate_expired',
    'openvpn_certificate_validation_failed',
    'openvpn_client_config_failed',
    'openvpn_client_setup_failed',
    'openvpn_connection_timeout',
    'openvpn_csr_generation_failed',
    'openvpn_identity_clear_failed',
    'openvpn_identity_store_failed',
    'openvpn_identity_unavailable',
    'openvpn_key_generation_failed',
    'openvpn_local_identity_failed',
    'openvpn_local_identity_mismatch',
    'openvpn_migration_certificate_mismatch',
    'openvpn_certificate_identity_mismatch',
    'openvpn_certificate_expiry_mismatch',
    'openvpn_external_pki_failed',
    'openvpn_network_metadata_invalid',
    'openvpn_recovery_exhausted',
    'openvpn_profile_crypto_failed',
    'openvpn_profile_rejected',
    'openvpn_signer_unavailable',
    'openvpn_tls_handshake_failed',
    'openvpn_stop_timeout',
    'wireguard_identity_store_failed',
    'wireguard_configuration_invalid',
    'wireguard_handshake_timeout',
    'wireguard_identity_invalid',
    'wireguard_identity_unavailable',
    'wireguard_start_failed',
    'wireguard_stop_timeout',
    'wireguard_foreground_service_unavailable',
    'tunnel_start_unexpected',
    'tunnel_handshake_timeout',
    'tunnel_stop_failed',
    'tunnel_stop_timeout',
    'flutter_disconnect_timeout',
    'flutter_disconnect_unexpected',
    'system_vpn_resume_corrupt',
    'system_vpn_resume_storage_failed',
    'system_vpn_resume_identity_invalid',
    'profile_forbidden_directive',
    'profile_invalid_ca',
    'profile_invalid_cipher',
    'profile_invalid_remote',
    'profile_invalid_tls_crypt_v2',
    'profile_invalid_verification_name',
    'profile_missing_required_directive',
    'profile_rejected',
    'tls_alert_bad_certificate',
    'tls_alert_misc',
    'tls_alert_unknown_ca',
    'tls_alert_unsupported_certificate',
    'tls_certificate_expired',
    'tls_certificate_revoked',
    'tls_client_certificate_required',
    'tls_handshake_failed',
    'tls_handshake_rejected',
    'tls_signature_algorithm_rejected',
    'tls_version_rejected',
    'tun_establish_exception',
    'tun_network_mismatch',
    'traffic_guard_failed',
    'vpn_host_destroyed',
  };

  final _DiagnosticSender _sender;
  final DateTime Function() _now;
  final int Function()? _externalTick;
  final Stopwatch _watch = Stopwatch()..start();
  final Object _owner = Object();
  final Queue<_TimedEvent> _events = Queue<_TimedEvent>();
  final List<DiagnosticReport> _queue = [];
  final Queue<int> _attemptTimes = Queue<int>();
  final Random _jitter = Random();
  final bool scheduleRetries;
  DiagnosticMetadata _metadata = DiagnosticMetadata.fromJson(const {});
  String? _account;
  String? _token;
  DateTime? _expiresAt;
  int _generation = 0;
  int _lastTick = 0;
  int _droppedEvents = 0;
  int _blockedUntil = 0;
  int? _lastAutomaticAt;
  bool _disposed = false;
  bool _automaticConsent = false;
  Timer? _retryTimer;
  Future<void>? _pumpFuture;
  DiagnosticError? _lastError;
  int? _lastErrorAt;
  DiagnosticReport? _preparedReport;
  DiagnosticReport? _lastManual;
  DiagnosticReport? _sending;
  DiagnosticSendStatus _status = DiagnosticSendStatus.idle;
  DiagnosticReceipt? _lastReceipt;
  DiagnosticFailure? _lastFailure;

  bool get automaticConsent => _automaticConsent;
  DiagnosticSendStatus get status => _status;
  DiagnosticReport? get preparedReport => _preparedReport;
  DiagnosticReceipt? get lastReceipt => _lastReceipt;
  DiagnosticFailure? get lastFailure => _lastFailure;
  bool get isSending =>
      _sending != null &&
      !_sending!.automatic &&
      _owns(_sending!) &&
      _queue.contains(_sending);
  int get pendingCount {
    _prune();
    return _queue.length;
  }

  int get pendingBytes {
    _prune();
    return _queue.fold(0, (sum, report) => sum + report.byteLength);
  }

  bool get canRetry {
    final report = _lastManual;
    return report != null &&
        _queue.contains(report) &&
        !isSending &&
        _eligible(report, _tick()) &&
        _sessionUsable;
  }

  int _tick() {
    final tick = _externalTick?.call() ?? _watch.elapsedMilliseconds;
    if (tick > _lastTick) _lastTick = tick;
    return _lastTick;
  }

  bool get _sessionUsable =>
      !_disposed &&
      _account != null &&
      _token != null &&
      (_expiresAt == null || _now().isBefore(_expiresAt!));

  void setSession({String? accountId, String? token, DateTime? expiresAt}) {
    if (_disposed) return;
    final account = accountId != null && accountId.isNotEmpty
        ? accountId
        : null;
    final sessionToken = token != null && token.isNotEmpty ? token : null;
    final changedAccount =
        account != _account || (sessionToken == null && _token != null);
    final changedToken = sessionToken != _token;
    if (changedAccount) _resetContent();
    _account = account;
    _token = account == null ? null : sessionToken;
    _expiresAt = expiresAt;
    if (changedAccount || changedToken) {
      _notify();
      if (_sessionUsable && _queue.isNotEmpty) _kick();
    }
    _schedule();
  }

  void setAutomaticConsent(bool value) {
    if (_disposed || value == _automaticConsent) return;
    _automaticConsent = value;
    if (!value) {
      _queue.removeWhere((report) => report.automatic);
    }
    _schedule();
    _notify();
  }

  void setMetadata(Map<String, Object?> metadata) {
    if (!_disposed) _metadata = DiagnosticMetadata.fromJson(metadata);
  }

  void recordEvent({
    String source = 'controller',
    String stage = 'unknown',
    String event = 'info',
    String? code,
    int? httpStatus,
    int? durationMs,
    int? spanId,
    int? parentSpanId,
  }) {
    if (_disposed) return;
    final now = _tick();
    _pruneEvents(now);
    _events.add(
      _TimedEvent(
        now,
        DiagnosticEvent(
          source: source,
          stage: stage,
          event: event,
          code: code,
          httpStatus: httpStatus,
          durationMs: durationMs,
          spanId: spanId,
          parentSpanId: parentSpanId,
        ),
      ),
    );
    while (_events.length > maxEvents) {
      _events.removeFirst();
      _dropEvent();
    }
  }

  void recordError(
    String code, {
    String operation = 'unknown',
    String? protocol,
    String state = 'error',
    String domain = 'unknown',
    String stage = 'unknown',
    int? httpStatus,
  }) {
    if (_disposed) return;
    final error = DiagnosticError(
      code: code,
      operation: operation,
      domain: domain,
      stage: stage,
      httpStatus: httpStatus,
    );
    _lastError = error;
    _lastErrorAt = _tick();
    recordEvent(
      source: domain == 'api' ? 'api' : 'controller',
      stage: stage,
      event: 'error',
      code: error.code,
      httpStatus: httpStatus,
    );
    final now = _tick();
    if (!_automaticConsent ||
        !_sessionUsable ||
        _metadata.appVersion == null ||
        !_importantCodes.contains(error.code) ||
        (_lastAutomaticAt != null && now - _lastAutomaticAt! < 60000)) {
      return;
    }
    try {
      final report = _prepare(
        full: false,
        state: state,
        protocol: protocol,
        snapshot: const {},
        checks: const [],
        automatic: true,
      );
      if (_enqueue(report)) {
        _lastAutomaticAt = now;
        _kick();
      }
    } on DiagnosticFailure {
      // A collector/preparation failure cannot itself generate a diagnostic.
    }
  }

  DiagnosticReport prepareFull({
    required Map<String, Object?> snapshot,
    required String state,
    String? protocol,
    List<Map<String, Object?>> checks = const [],
  }) {
    final report = _prepare(
      full: true,
      state: state,
      protocol: protocol,
      snapshot: snapshot,
      checks: checks,
      automatic: false,
    );
    cancelManual();
    _preparedReport = report;
    _lastReceipt = null;
    _lastFailure = null;
    _status = DiagnosticSendStatus.prepared;
    _notify();
    return report;
  }

  DiagnosticReport _prepare({
    required bool full,
    required String state,
    String? protocol,
    required Map<String, Object?> snapshot,
    required List<Map<String, Object?>> checks,
    required bool automatic,
  }) {
    if (_disposed || (automatic && !_sessionUsable)) {
      throw const DiagnosticFailure('session_required');
    }
    if (_metadata.appVersion == null) {
      throw const DiagnosticFailure('metadata_unavailable');
    }
    final created = _now().toUtc();
    if (created.year < 2000 || created.year > 2100) {
      throw const DiagnosticFailure('invalid_clock');
    }
    final now = _tick();
    _pruneEvents(now);
    final events = <Map<String, Object?>>[];
    final spans = <int, int>{};
    final windowStart = max(0, now - eventWindowMs);
    if (full) {
      for (final entry in _events) {
        final value = entry.event.toJson(entry.at - windowStart);
        for (final key in const ['span_id', 'parent_span_id']) {
          final id = value[key];
          if (id is int) value[key] = spans.putIfAbsent(id, () => spans.length);
        }
        events.add(value);
      }
    }
    final sanitizedSnapshot = DiagnosticSnapshot.fromJson(snapshot).toJson();
    final id = _uuidV4();
    final metadata = _metadata.toJson();
    if (!full && metadata['environment'] is Map) {
      final environment = Map<String, Object?>.from(
        metadata['environment']! as Map,
      )..remove('network_type');
      if (environment.isEmpty) {
        metadata.remove('environment');
      } else {
        metadata['environment'] = environment;
      }
    }
    final payload = <String, Object?>{
      'schema_version': 1,
      'report_id': id,
      'report_type': full ? 'full' : 'simple',
      'platform': 'android',
      ...metadata,
      'created_at': created.toIso8601String(),
      'consent': {
        'mode': automatic ? 'automatic_opt_in' : 'manual',
        'notice_version': 1,
      },
      if (protocol != null)
        'protocol': diagnosticEnum(protocol, diagnosticProtocols),
      'state': diagnosticEnum(state, diagnosticStates),
      'occurrences': 1,
      if (_lastError != null) 'error': _lastError!.toJson(),
      if (full && sanitizedSnapshot.isNotEmpty) 'snapshot': sanitizedSnapshot,
      if (full && checks.isNotEmpty)
        'checks': checks
            .take(64)
            .map((value) => DiagnosticCheck.fromJson(value).toJson())
            .toList(),
      if (events.isNotEmpty) 'events': events,
      'truncated': full && (_droppedEvents > 0 || checks.length > 64),
      'dropped_events': full ? _droppedEvents : 0,
    };
    final limit = full ? 512 * 1024 : 8192;
    var json = jsonEncode(payload);
    while (utf8.encode(json).length > limit && events.isNotEmpty) {
      events.removeAt(0);
      payload['dropped_events'] = min(
        1000000,
        (payload['dropped_events']! as int) + 1,
      );
      payload['truncated'] = true;
      if (events.isEmpty) payload.remove('events');
      json = jsonEncode(payload);
    }
    if (utf8.encode(json).length > limit) {
      throw const DiagnosticFailure('report_too_large');
    }
    return DiagnosticReport._(
      reportId: id,
      json: json,
      createdAt: created,
      eventCount: events.length,
      reportType: full ? 'full' : 'simple',
      automatic: automatic,
      owner: _owner,
      account: _account,
      generation: _generation,
      collectedAt: now,
    );
  }

  Future<void> sendManual(DiagnosticReport report) async {
    if (_disposed) return;
    if (!_owns(report) || report.automatic) {
      _fail(const DiagnosticFailure('report_account_changed'));
      return;
    }
    _lastManual = report;
    if (report._delivery.receipt != null) {
      _lastReceipt = report._delivery.receipt;
      _status = DiagnosticSendStatus.sent;
      _notify();
      return;
    }
    if (_enqueue(report)) await retryPending();
  }

  Future<void> retryManual() async {
    if (!_disposed && _lastManual != null) await sendManual(_lastManual!);
  }

  /// Withdraws pending manual delivery without clearing observations or auto consent.
  /// An already submitted request cannot be unsent; its late result is ignored.
  void cancelManual() {
    if (_disposed) return;
    for (final report in _queue.where((report) => !report.automatic)) {
      report._delivery.revision++;
    }
    _queue.removeWhere((report) => !report.automatic);
    _lastManual = null;
    _lastFailure = null;
    _status = _lastReceipt != null
        ? DiagnosticSendStatus.sent
        : _preparedReport != null
        ? DiagnosticSendStatus.prepared
        : DiagnosticSendStatus.idle;
    _schedule();
    _notify();
  }

  void clearPrepared() {
    if (_disposed) return;
    cancelManual();
    _preparedReport = null;
    _lastReceipt = null;
    _status = DiagnosticSendStatus.idle;
    _notify();
  }

  Future<void> retryPending() {
    if (_disposed) return Future<void>.value();
    final active = _pumpFuture;
    if (active != null) return active;
    // Start on the next microtask so the in-flight owner is installed before notify.
    final pending = Future<void>.microtask(_drain);
    _pumpFuture = pending;
    return pending.whenComplete(() {
      if (identical(_pumpFuture, pending)) _pumpFuture = null;
      _schedule();
    });
  }

  bool _enqueue(DiagnosticReport report) {
    _prune();
    if (_tick() - report._collectedAt >= queueTtlMs) {
      if (!report.automatic) _fail(const DiagnosticFailure('report_expired'));
      return false;
    }
    if (report._delivery.terminal || report._delivery.attempts >= maxAttempts) {
      if (!report.automatic) {
        _fail(
          report._delivery.failure ??
              const DiagnosticFailure('attempts_exhausted'),
        );
      }
      return false;
    }
    if (!_sessionUsable) {
      if (!report.automatic) _fail(const DiagnosticFailure('session_required'));
      return false;
    }
    if (_queue.contains(report)) return true;
    if (_queue.length >= 32 ||
        pendingBytes + report.byteLength > maxQueueBytes) {
      if (!report.automatic) _fail(const DiagnosticFailure('queue_full'));
      return false;
    }
    _queue.add(report);
    if (!report.automatic) _status = DiagnosticSendStatus.queued;
    _notify();
    return true;
  }

  bool _owns(DiagnosticReport report) =>
      !_disposed &&
      identical(report._owner, _owner) &&
      report._generation == _generation &&
      report._account == _account;

  bool _eligible(DiagnosticReport report, int now) =>
      _owns(report) &&
      (!report.automatic || _automaticConsent) &&
      !report._delivery.terminal &&
      report._delivery.attempts < maxAttempts &&
      now - report._collectedAt < queueTtlMs &&
      now >= report._delivery.nextAt &&
      now >= _blockedUntil &&
      (report._delivery.rejectedToken == null ||
          report._delivery.rejectedToken != _token);

  Future<void> _drain() async {
    while (!_disposed) {
      final previousStatus = _status;
      _prune();
      if (_status != previousStatus) _notify();
      if (!_sessionUsable) {
        if (_queue.any((report) => !report.automatic)) {
          _fail(const DiagnosticFailure('session_required'));
        }
        return;
      }
      final now = _tick();
      while (_attemptTimes.isNotEmpty && now - _attemptTimes.first >= 3600000) {
        _attemptTimes.removeFirst();
      }
      if (_attemptTimes.length >= 30) {
        _blockedUntil = max(_blockedUntil, _attemptTimes.first + 3600000);
        return;
      }
      final eligible = _queue.where((report) => _eligible(report, now));
      if (eligible.isEmpty) return;
      final report = eligible.first;
      final token = _token!;
      final delivery = report._delivery;
      final revision = delivery.revision;
      _sending = report;
      if (!report.automatic) {
        _status = DiagnosticSendStatus.sending;
        _lastFailure = null;
      }
      _notify();
      // A notification may synchronously revoke consent or switch accounts.
      if (!_owns(report) ||
          !_queue.contains(report) ||
          !_sessionUsable ||
          (report.automatic && !_automaticConsent) ||
          _token != token ||
          delivery.revision != revision) {
        _sending = null;
        continue;
      }
      delivery.attempts++;
      _attemptTimes.add(now);
      try {
        final receipt = await _sender.send(report, token, _now());
        if (_owns(report) &&
            _queue.contains(report) &&
            delivery.revision == revision &&
            (!report.automatic || _automaticConsent)) {
          delivery.receipt = receipt;
          delivery.terminal = true;
          _queue.remove(report);
          if (!report.automatic) {
            _lastReceipt = receipt;
            _lastFailure = null;
            _status = DiagnosticSendStatus.sent;
          }
        }
      } on DiagnosticFailure catch (failure) {
        if (_owns(report) &&
            _queue.contains(report) &&
            delivery.revision == revision &&
            (!report.automatic || _automaticConsent)) {
          delivery.failure = failure;
          if (!report.automatic) _lastFailure = failure;
          if (failure.httpStatus == 401 || failure.httpStatus == 403) {
            delivery.rejectedToken = token;
            if (!report.automatic) {
              _status = DiagnosticSendStatus.authenticationRequired;
            }
          } else if (failure.retryable && delivery.attempts < maxAttempts) {
            final delaySeconds = max(
              failure.retryAfterSeconds ?? 0,
              (delivery.attempts == 1 ? 30 : 120) + _jitter.nextInt(10),
            );
            delivery.nextAt = _tick() + delaySeconds * 1000;
            // Back pressure applies to this account's whole queue.
            _blockedUntil = max(_blockedUntil, delivery.nextAt);
            if (!report.automatic) _status = DiagnosticSendStatus.queued;
          } else {
            delivery.terminal = true;
            _queue.remove(report);
            if (!report.automatic) _status = DiagnosticSendStatus.failed;
          }
        }
      } finally {
        if (identical(_sending, report)) _sending = null;
        _notify();
      }
    }
  }

  void _pruneEvents(int now) {
    if (_lastErrorAt != null && now - _lastErrorAt! > eventWindowMs) {
      _lastError = null;
      _lastErrorAt = null;
    }
    while (_events.isNotEmpty && now - _events.first.at > eventWindowMs) {
      _events.removeFirst();
      _dropEvent();
    }
  }

  void _dropEvent() {
    if (_droppedEvents < 1000000) _droppedEvents++;
  }

  void _prune() {
    final now = _tick();
    _pruneEvents(now);
    final manual = _lastManual;
    if (manual != null &&
        now - manual._collectedAt >= queueTtlMs &&
        manual._delivery.receipt == null) {
      _lastManual = null;
      _lastFailure = const DiagnosticFailure('report_expired');
      _status = DiagnosticSendStatus.failed;
    }
    final prepared = _preparedReport;
    if (prepared != null && now - prepared._collectedAt >= queueTtlMs) {
      _preparedReport = null;
    }
    _queue.removeWhere(
      (report) =>
          !_owns(report) ||
          now - report._collectedAt >= queueTtlMs ||
          (report.automatic && !_automaticConsent),
    );
  }

  void _fail(DiagnosticFailure failure) {
    _lastFailure = failure;
    _status = failure.code == 'session_required'
        ? DiagnosticSendStatus.authenticationRequired
        : DiagnosticSendStatus.failed;
    _notify();
  }

  void _kick() {
    unawaited(retryPending());
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  void _schedule() {
    _retryTimer?.cancel();
    _retryTimer = null;
    if (_disposed || !scheduleRetries || !_sessionUsable) return;
    _prune();
    if (_queue.isEmpty) return;
    final now = _tick();
    var due = now + queueTtlMs;
    if (_expiresAt != null) {
      due = min(due, now + _expiresAt!.difference(_now()).inMilliseconds);
    }
    for (final report in _queue) {
      due = min(due, report._collectedAt + queueTtlMs);
      if (_sessionUsable &&
          report._delivery.attempts < maxAttempts &&
          report._delivery.rejectedToken != _token) {
        due = min(due, max(_blockedUntil, report._delivery.nextAt));
      }
    }
    if (_pumpFuture != null) return;
    _retryTimer = Timer(Duration(milliseconds: max(1, due - now)), _kick);
  }

  void _resetContent() {
    _generation++;
    _retryTimer?.cancel();
    _retryTimer = null;
    _queue.clear();
    _events.clear();
    _attemptTimes.clear();
    _lastAutomaticAt = null;
    _droppedEvents = 0;
    _blockedUntil = 0;
    _preparedReport = null;
    _lastManual = null;
    _lastError = null;
    _lastErrorAt = null;
    _lastReceipt = null;
    _lastFailure = null;
    _status = DiagnosticSendStatus.idle;
  }

  void clear() {
    if (_disposed) return;
    _resetContent();
    _notify();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _resetContent();
    _disposed = true;
    _watch.stop();
    // The injected HTTP transport may also serve the app's normal API calls.
    super.dispose();
  }
}

class _DiagnosticSender {
  _DiagnosticSender(this.transport, Uri baseUri) : uri = _endpoint(baseUri);
  final ApiHttpTransport transport;
  final Uri uri;

  static Uri _endpoint(Uri base) {
    if (!base.hasScheme ||
        base.host.isEmpty ||
        base.userInfo.isNotEmpty ||
        !{'https', 'http'}.contains(base.scheme) ||
        base.hasQuery ||
        base.hasFragment) {
      throw const DiagnosticFailure('invalid_api_origin');
    }
    return base.replace(path: '/v1/diagnostics');
  }

  Future<DiagnosticReceipt> send(
    DiagnosticReport report,
    String token,
    DateTime now,
  ) async {
    final ApiHttpResponse response;
    try {
      response = await ConnectionTiming.unobserved(
        () => transport.send(
          ApiHttpRequest(
            method: 'POST',
            uri: uri,
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            body: report.json,
          ),
        ),
      ).timeout(const Duration(seconds: 25));
    } catch (_) {
      throw const DiagnosticFailure(
        'diagnostic_network_unavailable',
        retryable: true,
      );
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        if (utf8.encode(response.body).length > 8192) {
          throw const FormatException();
        }
        final raw = jsonDecode(response.body);
        if (raw is! Map<String, dynamic> ||
            raw['status'] != 'received' ||
            raw['duplicate'] != (response.statusCode == 200) ||
            raw['client_report_id'] != report.reportId ||
            !_validUuid(raw['report_id']) ||
            raw['report_id'] == report.reportId) {
          throw const FormatException();
        }
        final received = _rfc3339(raw['received_at']);
        final expires = _rfc3339(raw['expires_at']);
        if (received == null ||
            expires == null ||
            expires.difference(received) != const Duration(days: 30)) {
          throw const FormatException();
        }
        return DiagnosticReceipt(
          serverReportId: raw['report_id'] as String,
          clientReportId: report.reportId,
          receivedAt: received,
          expiresAt: expires,
          duplicate: raw['duplicate'] as bool,
        );
      } catch (_) {
        throw const DiagnosticFailure(
          'invalid_diagnostic_response',
          retryable: true,
        );
      }
    }
    var code = 'diagnostic_http_error';
    try {
      if (utf8.encode(response.body).length <= 8192) {
        final raw = jsonDecode(response.body);
        if (raw is Map<String, dynamic> &&
            const {
              'invalid_diagnostic',
              'unauthorized',
              'not_found',
              'diagnostic_conflict',
              'diagnostic_too_large',
              'rate_limited',
              'diagnostic_quota_exceeded',
              'diagnostics_unavailable',
              'diagnostic_content_unavailable',
              'server_error',
            }.contains(raw['error'])) {
          code = raw['error'] as String;
        }
      }
    } catch (_) {
      /* The HTTP status remains useful without retaining the body. */
    }
    final retryable =
        (response.statusCode == 429 || response.statusCode >= 500) &&
        code != 'diagnostic_content_unavailable';
    throw DiagnosticFailure(
      code,
      httpStatus: response.statusCode,
      retryable: retryable,
      retryAfterSeconds:
          _retryAfter(response.header('retry-after'), now) ??
          (response.statusCode == 429 ? 3600 : null),
    );
  }
}

int? _retryAfter(String? value, DateTime now) {
  if (value == null || value.length > 128) return null;
  final seconds = int.tryParse(value.trim());
  if (seconds != null) return seconds < 0 ? null : min(86400, seconds);
  try {
    return min(
      86400,
      max(0, HttpDate.parse(value).difference(now.toUtc()).inSeconds),
    );
  } catch (_) {
    return null;
  }
}

bool _validUuid(Object? value) =>
    value is String &&
    value.length == 36 &&
    value != '00000000-0000-0000-0000-000000000000' &&
    RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    ).hasMatch(value);

DateTime? _rfc3339(Object? value) {
  if (value is! String || value.length > 40) return null;
  final match = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d{1,9})?(Z|[+-]\d{2}:\d{2})$',
  ).firstMatch(value);
  if (match == null) return null;
  final year = int.parse(match[1]!);
  final month = int.parse(match[2]!);
  final day = int.parse(match[3]!);
  if (year < 2000 ||
      year > 2100 ||
      month < 1 ||
      month > 12 ||
      day < 1 ||
      day > DateTime.utc(year, month + 1, 0).day ||
      int.parse(match[4]!) > 23 ||
      int.parse(match[5]!) > 59 ||
      int.parse(match[6]!) > 59) {
    return null;
  }
  final zone = match[8]!;
  if (zone != 'Z' &&
      (int.parse(zone.substring(1, 3)) > 23 ||
          int.parse(zone.substring(4)) > 59)) {
    return null;
  }
  return DateTime.tryParse(value)?.toUtc();
}

String _uuidV4() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  bytes[6] = (bytes[6] & 15) | 64;
  bytes[8] = (bytes[8] & 63) | 128;
  final hex = bytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
