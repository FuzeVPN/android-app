import 'dart:convert';

import 'diagnostic_codes.dart';

const diagnosticStages = {
  'unknown',
  'startup',
  'storage',
  'authentication',
  'api_request',
  'api_response',
  'enrollment',
  'profile_create',
  'profile_revoke',
  'certificate',
  'certificate_renewal',
  'driver_check',
  'service_start',
  'tunnel_start',
  'handshake',
  'adapter_create',
  'addresses_apply',
  'routes_apply',
  'dns_apply',
  'mtu_apply',
  'postconditions',
  'proxy_configuration',
  'guard_verify',
  'webrtc_check',
  'network_check',
  'disconnect',
  'cleanup',
  'recovery',
  'repair',
  'completed',
};
const diagnosticStates = {
  'unknown',
  'disconnected',
  'connecting',
  'connected',
  'disconnecting',
  'error',
  'degraded',
  'recovering',
};
const diagnosticOperations = {
  'unknown',
  'startup',
  'authenticate',
  'register',
  'connect',
  'disconnect',
  'refresh',
  'probe',
  'restore',
  'renew',
  'update',
  'repair',
};
const diagnosticSources = {
  'app',
  'native',
  'flutter',
  'controller',
  'api',
  'system',
};
const diagnosticEvents = {
  'begin',
  'end',
  'error',
  'waiting',
  'retry',
  'cancelled',
  'info',
};
const diagnosticDomains = {
  'api',
  'system',
  'tunnel',
  'storage',
  'protection',
  'proxy',
  'client',
  'unknown',
};
const diagnosticProtocols = {'unknown', 'wireguard', 'openvpn'};
const diagnosticDurationLimit = 604800000;

String diagnosticEnum(
  Object? value,
  Set<String> allowed, [
  String fallback = 'unknown',
]) => value is String && allowed.contains(value) ? value : fallback;

int? diagnosticInteger(Object? value, int maximum, [int minimum = 0]) =>
    value is int && value >= minimum && value <= maximum ? value : null;

String diagnosticCode(Object? value) =>
    value is String && diagnosticCodes.contains(value)
    ? value
    : 'unknown_error';

/// These objects only retain normalized, finite vocabulary, never their inputs.
class DiagnosticError {
  DiagnosticError({
    required String code,
    String domain = 'unknown',
    String operation = 'unknown',
    String stage = 'unknown',
    int? httpStatus,
  }) : code = diagnosticCode(code),
       domain = diagnosticEnum(domain, diagnosticDomains),
       operation = diagnosticEnum(operation, diagnosticOperations),
       stage = diagnosticEnum(stage, diagnosticStages),
       httpStatus = diagnosticInteger(httpStatus, 599, 100);

  final String code;
  final String domain;
  final String operation;
  final String stage;
  final int? httpStatus;

  Map<String, Object?> toJson() => {
    'domain': domain,
    'code': code,
    'operation': operation,
    'stage': stage,
    if (httpStatus != null) 'http_status': httpStatus,
  };
}

class DiagnosticEvent {
  DiagnosticEvent({
    String source = 'controller',
    String stage = 'unknown',
    String event = 'info',
    String? code,
    int? httpStatus,
    int? durationMs,
    int? spanId,
    int? parentSpanId,
  }) : source = diagnosticEnum(source, diagnosticSources, 'app'),
       stage = diagnosticEnum(stage, diagnosticStages),
       event = diagnosticEnum(event, diagnosticEvents, 'info'),
       code = code == null ? null : diagnosticCode(code),
       httpStatus = diagnosticInteger(httpStatus, 599, 100),
       durationMs = diagnosticInteger(durationMs, diagnosticDurationLimit),
       spanId = diagnosticInteger(spanId, 2000),
       parentSpanId = diagnosticInteger(parentSpanId, 2000);

  final String source;
  final String stage;
  final String event;
  final String? code;
  final int? httpStatus;
  final int? durationMs;
  final int? spanId;
  final int? parentSpanId;

  Map<String, Object?> toJson(int offsetMs) => {
    'source': source,
    'stage': stage,
    'event': event,
    'offset_ms': offsetMs,
    if (code != null) 'code': code,
    if (httpStatus != null) 'http_status': httpStatus,
    if (durationMs != null) 'duration_ms': durationMs,
    if (spanId != null) 'span_id': spanId,
    if (parentSpanId != null) 'parent_span_id': parentSpanId,
  };
}

class DiagnosticCheck {
  DiagnosticCheck.fromJson(Map<String, Object?> values)
    : id = diagnosticEnum(values['id'], const {
        'unknown',
        'api_reachability',
        'service_availability',
        'driver_availability',
        'secure_storage',
        'tunnel_configuration',
        'tunnel_connection',
        'handshake',
        'routing',
        'dns',
        'ipv4',
        'ipv6',
        'kill_switch',
        'webrtc',
        'proxy_settings',
        'certificate',
        'cleanup',
        'connectivity',
        'permissions',
      }),
      result = diagnosticEnum(values['result'], const {
        'passed',
        'failed',
        'skipped',
        'unknown',
      }),
      code = values['code'] == null ? null : diagnosticCode(values['code']),
      durationMs = diagnosticInteger(
        values['duration_ms'],
        diagnosticDurationLimit,
      ),
      ageMs = diagnosticInteger(values['age_ms'], diagnosticDurationLimit);

  final String id;
  final String result;
  final String? code;
  final int? durationMs;
  final int? ageMs;

  Map<String, Object?> toJson() => {
    'id': id,
    'result': result,
    if (code != null) 'code': code,
    if (durationMs != null) 'duration_ms': durationMs,
    if (ageMs != null) 'age_ms': ageMs,
  };
}

class DiagnosticSnapshot {
  DiagnosticSnapshot.fromJson(Map<String, Object?> source) {
    for (final key in const [
      'kill_switch_requested',
      'kill_switch_verified',
      'traffic_blocked',
      'always_on',
      'lockdown',
    ]) {
      if (source[key] is bool) _values[key] = source[key];
    }
    for (final key in const [
      'handshake_age_ms',
      'connection_duration_ms',
      'freshness_ms',
    ]) {
      _number(source, key, diagnosticDurationLimit);
    }
    for (final key in const ['bytes_sent', 'bytes_received']) {
      _number(source, key, 9007199254740991);
    }
    _number(source, 'reconnect_count', 1000000);
    _enum(source, 'phase', diagnosticStages);
    _enum(source, 'recovery_state', const {
      'none',
      'pending',
      'retrying',
      'succeeded',
      'failed',
      'unknown',
    });
    _enum(source, 'certificate_state', const {
      'missing',
      'valid',
      'expiring',
      'renewing',
      'expired',
      'revoked',
      'unknown',
    });
    _enum(source, 'cleanup_state', const {
      'not_requested',
      'pending',
      'completed',
      'failed',
      'unknown',
    });
    final families = source['ip_families'];
    if (families is List &&
        families.isNotEmpty &&
        families.length <= 2 &&
        families.every((Object? item) => item == 'ipv4' || item == 'ipv6') &&
        families.toSet().length == families.length) {
      _values['ip_families'] = List<String>.unmodifiable(
        families.cast<String>(),
      );
    }
  }

  final Map<String, Object?> _values = {};
  void _number(Map<String, Object?> source, String key, int max) {
    final value = diagnosticInteger(source[key], max);
    if (value != null) _values[key] = value;
  }

  void _enum(Map<String, Object?> source, String key, Set<String> values) {
    if (values.contains(source[key])) _values[key] = source[key];
  }

  Map<String, Object?> toJson() => Map<String, Object?>.unmodifiable(_values);
}

class DiagnosticMetadata {
  DiagnosticMetadata.fromJson(Map<String, Object?> source) {
    final version = source['app_version'];
    if (version is String &&
        version.length <= 64 &&
        version.codeUnits.every((unit) => unit > 32 && unit < 127) &&
        RegExp(
          r'^(0|[1-9][0-9]{0,4})(\.(0|[1-9][0-9]{0,4})){2,3}([+-](dev|beta|rc)(\.[0-9]{1,5})?|\+[0-9]{1,10})?$',
        ).hasMatch(version)) {
      appVersion = version;
    }
    appBuild = diagnosticInteger(source['app_build'], 2147483647);
    final raw = source['environment'];
    if (raw is Map) {
      for (final entry in <String, Set<String>>{
        'architecture': {'x64', 'x86', 'arm64', 'armv7', 'unknown'},
        'os_family': {'android'},
        'network_type': {'wifi', 'cellular', 'ethernet', 'none', 'unknown'},
        'build_mode': {'debug', 'release', 'unknown'},
      }.entries) {
        final value = raw[entry.key];
        if (entry.value.contains(value)) _environment[entry.key] = value;
      }
      for (final key in const ['os_major', 'android_sdk']) {
        final value = diagnosticInteger(raw[key], 100, 1);
        if (value != null) _environment[key] = value;
      }
    }
  }

  String? appVersion;
  int? appBuild;
  final Map<String, Object?> _environment = {};
  Map<String, Object?> toJson() => {
    if (appVersion != null) 'app_version': appVersion,
    if (appBuild != null) 'app_build': appBuild,
    if (_environment.isNotEmpty)
      'environment': Map<String, Object?>.unmodifiable(_environment),
  };
}

/// Private construction by the service fixes content/identity before any send.
/// JSON is the only retained payload; mutable caller maps are never retained.
abstract interface class DiagnosticReportView {
  String get reportId;
  String get json;
  int get byteLength;
  int get eventCount;
  DateTime get createdAt;
  Map<String, Object?> toJson();
}

Map<String, Object?> diagnosticJsonCopy(String json) =>
    Map<String, Object?>.from(jsonDecode(json) as Map<String, dynamic>);
