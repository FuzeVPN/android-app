import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/diagnostic_codes.dart';
import 'package:fuzevpn_android/core/diagnostic_schema.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

// Expected wire categories are independent of diagnosticCodeAliases. Keep the
// native producer inventory separate so a missing alias cannot hide itself.
const _eventCategories = <String, String>{
  'openvpn_external_pki_failed': 'openvpn_external_pki_failed',
  'tls_alert_unknown_ca': 'tls_alert_unknown_ca',
  'tls_alert_bad_certificate': 'tls_alert_bad_certificate',
  'tls_alert_unsupported_certificate': 'tls_alert_unsupported_certificate',
  'tls_signature_algorithm_rejected': 'tls_signature_algorithm_rejected',
  'tls_handshake_rejected': 'tls_handshake_rejected',
  'tls_client_certificate_required': 'tls_client_certificate_required',
  'tls_alert_misc': 'tls_alert_misc',
  'tls_version_rejected': 'tls_version_rejected',
  'tls_certificate_expired': 'tls_certificate_expired',
  'tls_certificate_revoked': 'tls_certificate_revoked',
  'certificate_validation_failed': 'certificate_validation_failed',
  'openvpn_auth_failed': 'openvpn_auth_failed',
  'tls_handshake_failed': 'tls_handshake_failed',
  'tun_setup_failed': 'tun_setup_failed',
  'tun_interface_create_failed': 'tun_interface_create_failed',
  'tun_interface_disabled': 'tun_interface_disabled',
  'tun_halted': 'tun_halted',
  'tun_failed': 'tun_failed',
  'profile_rejected': 'profile_rejected',
  'transport_failed': 'openvpn_transport_failed',
  'openvpn_connection_timeout': 'openvpn_connection_timeout',
  'openvpn_inactive_timeout': 'request_timeout',
  'openvpn_client_restart': 'openvpn_connection_failed',
  'openvpn_client_setup_failed': 'openvpn_client_setup_failed',
  'openvpn_client_halted': 'openvpn_client_halted',
  'openvpn_session_expired': 'session_expired',
  'openvpn_credentials_required': 'openvpn_auth_failed',
  'openvpn_dynamic_challenge_required': 'openvpn_auth_failed',
  'openvpn_proxy_credentials_required': 'proxy_authentication_failed',
  'openvpn_proxy_failed': 'proxy_unavailable',
  'openvpn_relay_failed': 'openvpn_transport_failed',
  'openvpn_compression_failed': 'openvpn_profile_rejected',
  'openvpn_ntlm_crypto_unavailable': 'openvpn_profile_crypto_failed',
  'openvpn_feature_unsupported': 'openvpn_profile_rejected',
  'connection_failed': 'openvpn_connection_failed',
};

// All TUN literals in the entire adapter, including the establishment return
// code switch outside FailureForEvent, must retain an existing v1 category.
const _tunCategories = <String, String>{
  'tun_setup_failed': 'tun_setup_failed',
  'tun_interface_create_failed': 'tun_interface_create_failed',
  'tun_interface_disabled': 'tun_interface_disabled',
  'tun_halted': 'tun_halted',
  'tun_failed': 'tun_failed',
  'tun_establish_failed': 'tun_failed',
  'tun_addresses_missing': 'openvpn_network_configuration_failed',
  'tun_dns_missing': 'openvpn_dns_configuration_failed',
  'tun_routes_missing': 'openvpn_network_configuration_failed',
  'tun_network_mismatch': 'tun_network_mismatch',
  'tun_already_established': 'tun_failed',
  'tun_plan_rejected': 'openvpn_network_configuration_failed',
  'tun_permission_revoked': 'permission_denied',
  'tun_establish_returned_null': 'tun_establish_returned_null',
  'tun_establish_exception': 'tun_establish_exception',
};

const _tunResults = <int, String>{
  -2: 'tun_already_established',
  -3: 'tun_plan_rejected',
  -4: 'tun_addresses_missing',
  -5: 'tun_routes_missing',
  -6: 'tun_dns_missing',
  -7: 'tun_permission_revoked',
  -8: 'tun_establish_returned_null',
  -9: 'tun_establish_exception',
};

// A13-03 and H-F-RESIDUEL-A13-03-01: every other failure code produced by
// Kotlin (android/app/src/main/kotlin/**), the OpenVPN C++ layer
// (android/app/src/main/cpp/*.cpp, *.h) or the Dart side of the bridge that
// has no identical v1 code. Each category is written here, independently of
// diagnosticCodeAliases, and must be an existing v1 category.
const _nativeFailureCategories = <String, String>{
  // VPN authorization: the user's consent or the permission dialog.
  'activity_destroyed': 'vpn_permission_request_failed',
  'permission_request_in_progress': 'vpn_permission_request_failed',
  'vpn_disclosure_required': 'permission_denied',
  'vpn_permission_denied': 'permission_denied',
  'vpn_permission_required': 'permission_denied',
  // Local arguments and identifiers rejected before any tunnel effect.
  'invalid_account_id': 'invalid_configuration',
  'invalid_arguments': 'invalid_configuration',
  'invalid_device_id': 'invalid_configuration',
  'invalid_guest_credential': 'invalid_configuration',
  // OpenVPN profile validation (C++ ProfileValidator and Kotlin activation).
  'invalid_identity_alias': 'profile_rejected',
  'openvpn_cipher_invalid': 'profile_invalid_cipher',
  'openvpn_tls_verification_required': 'profile_missing_required_directive',
  'profile_invalid_dns': 'profile_rejected',
  'profile_invalid_encoding': 'profile_rejected',
  'profile_invalid_identity_alias': 'profile_rejected',
  'profile_too_large': 'profile_rejected',
  // OpenVPN identity, signer and native engine.
  'core_unavailable': 'openvpn_core_unavailable',
  'openvpn_csr_required': 'openvpn_identity_unavailable',
  'openvpn_identity_in_use': 'openvpn_operation_pending',
  'openvpn_profile_revoked_cleaned': 'device_identity_revoked',
  'openvpn_renewal_required': 'openvpn_certificate_expired',
  'platform_callback_failed': 'openvpn_external_pki_failed',
  'platform_identity_unavailable': 'openvpn_identity_unavailable',
  'platform_signature_failed': 'openvpn_external_pki_failed',
  'session_busy': 'openvpn_operation_pending',
  // OpenVPN connection and recovery.
  'openvpn_connection_proof_missing': 'openvpn_connection_failed',
  'openvpn_reconnect_required': 'openvpn_transport_failed',
  'openvpn_recovery_failed': 'openvpn_connection_failed',
  // Tunnel start and end, both protocols.
  'quick_tile_operation_failed': 'native_operation_failed',
  'quick_tile_profile_unavailable': 'tunnel_start_failed',
  'tunnel_active_for_another_account': 'tunnel_start_failed',
  'tunnel_already_active': 'tunnel_start_failed',
  'tunnel_disconnected': 'tunnel_failure',
  'wireguard_identity_in_use': 'cleanup_failed',
  'wireguard_operation_pending': 'tunnel_start_failed',
  // Review round 2: a user stop under always-on opens Android's VPN settings
  // (disconnectByUser); when they cannot open, the controller records the
  // code through _nativeNotice. The user's stop request failed.
  'vpn_settings_unavailable': 'tunnel_stop_failed',
  // System VPN resume record and its saved session.
  'system_vpn_resume_blocked': 'system_vpn_resume_failed',
  'system_vpn_resume_error_invalid': 'system_vpn_resume_corrupt',
  'system_vpn_resume_unavailable': 'system_vpn_resume_failed',
};

// Review round 1: messages of untyped exceptions never cross the bridge.
// AndroidVpnBridge.messageCode() only reads the code of VpnNativeException,
// SecureStorageException and SystemVpnResumeException, and no native source
// reads an exception's text; each caller reports its own typed code instead.
// An alias for these words would only requalify unrelated codes (API
// invalid_profile and invalid_token), so they must have none. Every
// occurrence is checked below to stay in a swallowed context.
const _swallowedNativeMessages = <String, String>{
  // SystemVpnResume.kt decoders: runCatching { error(...) }.getOrNull().
  'invalid_error': 'resume record decoder, the record reads as absent',
  'invalid_expiry': 'resume session decoder, the session reads as absent',
  'invalid_identity': 'resume record decoder, the record reads as absent',
  'invalid_profile': 'resume record decoder, the record reads as absent',
  'invalid_recovery': 'resume record decoder, the record reads as absent',
  'invalid_session': 'resume record decoder, the record reads as absent',
  'invalid_status': 'resume record decoder, the record reads as absent',
  'invalid_token': 'resume session decoder, the session reads as absent',
  // QuickTileProfile.decode: runCatching { error(...) }.getOrNull().
  'invalid_protocol': 'quick tile profile decoder, the profile reads absent',
  // SecureKeystoreStore require { } messages (IllegalArgumentException):
  // callers report secure_storage_* or openvpn_identity_store_failed.
  'invalid_storage_key': 'require message, caller reports its typed code',
  'invalid_storage_scope': 'require message, caller reports its typed code',
  'storage_keys_empty': 'require message, caller reports its typed code',
  'storage_update_conflict': 'require message, caller reports its typed code',
  'storage_update_empty': 'require message, caller reports its typed code',
  'storage_value_too_large': 'require message, caller reports its typed code',
  'storage_values_empty': 'require message, caller reports its typed code',
  // Pkcs10Csr: wrapped as openvpn_csr_generation_failed.
  'der_too_large': 'IllegalArgumentException, wrapped by its caller',
  'invalid_oid': 'IllegalArgumentException, wrapped by its caller',
  // Caught and reported as vpn_permission_request_failed.
  'activity_not_available': 'IllegalStateException, caught by its caller',
  // check { } message, wrapped as openvpn_native_failed.
  'native_creation_not_claimable': 'check message, wrapped by its caller',
  // JNI IllegalStateException text, never read by Kotlin.
  'openvpn_native_state_unavailable': 'JNI exception text, never read',
  // Standard CancellationException tokens (java.util.concurrent or
  // kotlinx.coroutines): only their type is caught, never their text.
  'system_vpn_request_replaced': 'cancellation token, text never read',
  'system_vpn_start_superseded': 'cancellation token, text never read',
  'wireguard_call_withdrawn': 'withdrawn worker call, text never read',
};

// Native literals that are not failure causes. Each reason is enforced below:
// these literals never appear in a failure producer context.
const _nativeWireFields = <String>{
  'access_token',
  'account_id',
  'allowed_ips',
  'always_on',
  'android_permission',
  'android_sdk',
  'app_build',
  'app_version',
  'automatic_diagnostics_denied',
  'build_mode',
  'ca_certificate_pem',
  'certificate_pem',
  'challenge_id',
  'connected_at',
  'csr_sha256',
  'device_id',
  'diagnostic_span_id',
  'diagnostic_trace_id',
  'disclosure_accepted',
  'error_code',
  'expected_device_id',
  'expires_at',
  'identity_cleared',
  'identity_fingerprint',
  'in_progress',
  'ip_families',
  'language_code',
  'latest_handshake',
  'legacy_ipv4_network_v1',
  'location_id',
  'location_name',
  'marker_cleared',
  'message_code',
  'network_type',
  'not_after',
  'notification_language',
  'openvpn_network',
  'openvpn_revocation',
  'os_family',
  'os_major',
  'preserve_existing_certificate',
  'private_key',
  'profile_fingerprint',
  'profile_payload',
  'received_bytes',
  'recovery_consumed',
  'remote_cert_tls_server',
  'renewal_pending',
  'request_id',
  'resume_error',
  'resume_state',
  'sent_bytes',
  'server_name',
  'server_public_key',
  'session_cleared',
  'session_fingerprint',
  'session_termination',
  'stop_error',
  'system_protection',
  'tile_cleared',
  'tls_crypt_v2_client_key',
  'tunnel_stopped',
  'user_id',
};
const _nativeTimingSpans = <String>{
  'openvpn_certificate_read',
  'openvpn_certificate_validate',
  'openvpn_handshake_wait',
  'openvpn_identity_load',
  'openvpn_identity_profile_persist',
  'openvpn_key_csr_load',
  'openvpn_native_create',
  'openvpn_native_start',
  'openvpn_profile_validate',
  'openvpn_stop_worker',
  'postproof_notification',
  'resume_invalidation',
  'rpc_arrival',
  'rpc_execution',
  'rpc_execution_queue',
  'session_validation',
  'stop_worker',
  'tunnel_mutex_execution',
  'tunnel_mutex_wait',
  'vpn_service_await',
  'vpn_service_start',
  'wireguard_handshake_wait',
  'wireguard_identity_config',
  'wireguard_native_start',
  'wireguard_stop_worker',
};
// Message codes of non-error states (connecting, recovering, notices).
const _nativeProgressStates = <String>{
  'notifications_denied',
  'openvpn_reconnecting',
  'system_vpn_restoring',
  'waiting_network',
  'wireguard_recovering',
  'wireguard_waiting_network',
};
// Notification channel, native library and ABI names.
const _nativePlatformNames = <String>{
  'fuzevpn_connection',
  'fuzevpn_openvpn',
  'x86_64',
};
// Play Billing, Google sign-in and Turnstile codes. Their Dart consumers have
// their own notices and never call DiagnosticService (asserted below).
const _otherChannelCodes = <String>{
  'already_owned',
  'busy',
  'cancelled',
  'code',
  'expired',
  'interrupted',
  'invalid_pending_authentication',
  'invalid_request',
  'no_credential',
  'price_changed',
  'provider_error',
  'secure_storage_failed',
  'unavailable',
};
final _otherChannelFile = RegExp(
  r'^(PlayBilling|GoogleAuth|GooglePendingAuth|NativeTurnstile|Turnstile)'
  r'[A-Za-z]*\.kt$',
);
// Failure codes that are not causes and that no v1 category describes.
// Inventing a category would extend the server contract, which is forbidden.
const _unrecordedOutcomes = <String, String>{
  'diagnostic_export_failed': 'diagnostic export result, never recorded',
  'diagnostic_export_in_progress': 'diagnostic export result, never recorded',
  'diagnostic_export_invalid': 'diagnostic export result, never recorded',
  'diagnostic_metadata_unavailable': 'diagnostic collector, never recorded',
  'diagnostic_snapshot_unavailable': 'diagnostic collector, never recorded',
  'session_ending': 'local session end in progress, not a failure cause',
  'session_operation_cancelled': 'superseded operation, not a failure cause',
  // Quick Settings tile callbacks (lot N, C2-03 and A11-03): the tile service
  // opens Android's VPN settings or the app; nothing is sent to Dart.
  'quick_tile_open_settings': 'tile service handoff, never sent to Dart',
  'quick_tile_session_required': 'tile service handoff, never sent to Dart',
};
// Constants that carry tile service outcomes; checked to stay out of every
// producer call, even through their constant name.
const _tileOutcomeConstants = <String, String>{
  'quick_tile_open_settings': 'QUICK_TILE_OPEN_SETTINGS',
  'quick_tile_session_required': 'QUICK_TILE_SESSION_REQUIRED',
};

class _NativeSource {
  const _NativeSource(this.name, this.text);
  final String name;
  final String text;
}

List<_NativeSource> _nativeSources() => <_NativeSource>[
  for (final entity in Directory(
    'android/app/src/main/kotlin',
  ).listSync(recursive: true))
    if (entity is File && entity.path.endsWith('.kt'))
      _NativeSource(entity.uri.pathSegments.last, entity.readAsStringSync()),
  for (final entity in Directory('android/app/src/main/cpp').listSync())
    if (entity is File &&
        (entity.path.endsWith('.cpp') || entity.path.endsWith('.h')))
      _NativeSource(entity.uri.pathSegments.last, entity.readAsStringSync()),
];

final _multiWordLiteral = RegExp(r'"([a-z][a-z0-9]*(?:_[a-z0-9]+)+)"');
final _singleWordFailures = <RegExp>[
  RegExp(r'[A-Za-z]*Exception\(\s*"([a-z][a-z0-9]*)"'),
  RegExp(r'\.error\(\s*"([a-z][a-z0-9]*)"'),
  RegExp(r'"error"\s*,\s*"([a-z][a-z0-9]*)"'),
  RegExp(r'VpnStatus\.ERROR\s*,[^,]*,\s*"([a-z][a-z0-9]*)"'),
];

/// Every snake_case literal of the native sources, plus single-word codes in
/// failure producer calls and the Dart bridge's own native codes.
Map<String, Set<String>> _nativeInventory(List<_NativeSource> sources) {
  final found = <String, Set<String>>{};
  for (final source in sources) {
    for (final pattern in [_multiWordLiteral, ..._singleWordFailures]) {
      for (final match in pattern.allMatches(source.text)) {
        found.putIfAbsent(match[1]!, () => <String>{}).add(source.name);
      }
    }
  }
  final bridge = File('lib/native_vpn_bridge.dart').readAsStringSync();
  for (final pattern in [
    RegExp(r"NativeVpnException\(\s*'([a-z0-9_]+)'"),
    RegExp(r"messageCode:\s*'([a-z0-9_]+)'"),
  ]) {
    for (final match in pattern.allMatches(bridge)) {
      found.putIfAbsent(match[1]!, () => <String>{}).add('native_vpn_bridge');
    }
  }
  return found;
}

/// Contexts in which a literal becomes a failure code sent towards Dart.
List<RegExp> _failureContexts(String code) {
  final c = RegExp.escape(code);
  return <RegExp>[
    RegExp('Exception\\(\\s*"$c"'),
    RegExp('\\.error\\(\\s*"$c"'),
    RegExp('\\berror\\(\\s*"$c"'),
    RegExp('"error"\\s*,\\s*"$c"'),
    RegExp('VpnStatus\\.ERROR\\s*,[^,]*,\\s*"$c"'),
    RegExp(
      '(?:interrupt|Interrupt|failed|failAndStopLocked|FailTun)\\(\\s*"$c"',
    ),
    RegExp('messageCode\\([^,()]*,\\s*"$c"\\)'),
    RegExp(
      '(?:failure|Failure|failureCode|finalFailure|reason_|errorText|cause)'
      '\\s*(?::\\s*String\\s*)?=\\s*"$c"',
    ),
    RegExp('\\?:\\s*"$c"'),
    RegExp('return\\s+"$c"'),
    RegExp('(?:require|check)\\([^)]*\\)\\s*\\{\\s*"$c"'),
    RegExp('->\\s*"$c"'),
  ];
}

bool _producedAsFailure(String code, List<_NativeSource> sources) =>
    sources.any((s) => _failureContexts(code).any((p) => p.hasMatch(s.text)));

/// Index just after the brace that closes the block opened at [open], skipping
/// comments, strings and character literals.
int _blockEnd(String text, int open) {
  var depth = 0;
  var i = open;
  while (i < text.length) {
    if (text.startsWith('//', i)) {
      final end = text.indexOf('\n', i);
      i = end < 0 ? text.length : end;
      continue;
    }
    if (text.startsWith('/*', i)) {
      final end = text.indexOf('*/', i + 2);
      i = end < 0 ? text.length : end + 2;
      continue;
    }
    if (text.startsWith('"""', i)) {
      final end = text.indexOf('"""', i + 3);
      i = end < 0 ? text.length : end + 3;
      continue;
    }
    final char = text[i];
    if (char == '"' || char == "'") {
      i++;
      while (i < text.length && text[i] != char && text[i] != '\n') {
        i += text[i] == r'\' ? 2 : 1;
      }
      i++;
      continue;
    }
    if (char == '{') depth++;
    if (char == '}' && --depth == 0) return i + 1;
    i++;
  }
  return -1;
}

/// Ranges of `runCatching { ... }.getOrNull()` blocks: any exception thrown
/// inside becomes null and its message is lost.
List<(int, int)> _swallowingBlocks(String text) => <(int, int)>[
  for (final match in RegExp(r'\brunCatching\s*\{').allMatches(text))
    if (_blockEnd(text, match.end - 1) case final end
        when end > 0 &&
            RegExp(r'^\s*\.getOrNull\(\)').hasMatch(text.substring(end)))
      (match.start, end),
];

final _standardCancellationImport = RegExp(
  r'^import (?:java\.util\.concurrent|kotlinx\.coroutines|'
  r'kotlin\.coroutines\.cancellation)\.CancellationException\s*$',
  multiLine: true,
);

/// Why the occurrence of [code] at [index] cannot leave its exception, or
/// null when it may reach Dart.
String? _swallowedContext(_NativeSource source, String code, int index) {
  final text = source.text;
  final c = RegExp.escape(code);
  final lineStart = text.lastIndexOf('\n', index) + 1;
  final lineEnd = text.indexOf('\n', index);
  final line = text.substring(lineStart, lineEnd < 0 ? text.length : lineEnd);
  final kotlin = source.name.endsWith('.kt');
  // Kotlin's error() throws IllegalStateException; inside runCatching {
  // }.getOrNull() it only yields null. No local error() may shadow it.
  if (kotlin &&
      RegExp('(?<![.\\w])error\\(\\s*"$c"\\s*\\)').hasMatch(line) &&
      !RegExp(r'\bfun\s+(?:<[^>]*>\s*)?error\s*\(').hasMatch(text) &&
      _swallowingBlocks(
        text,
      ).any((block) => block.$1 < index && index < block.$2)) {
    return 'runCatching';
  }
  // require/check { message } throw IllegalArgument/IllegalStateException.
  if (kotlin &&
      RegExp(
        '\\b(?:require|check)(?:NotNull)?\\(.*\\)\\s*\\{\\s*"$c"\\s*\\}',
      ).hasMatch(line)) {
    return 'require';
  }
  if (kotlin &&
      RegExp(
        '\\b(?:IllegalArgumentException|IllegalStateException)'
        '\\(\\s*"$c"\\s*[,)]',
      ).hasMatch(line)) {
    return 'untyped exception';
  }
  // A standard cancellation is caught by its type; its text is never read.
  if (kotlin &&
      RegExp(
        '(?<![.\\w])CancellationException\\(\\s*"$c"\\s*[,)]',
      ).hasMatch(line) &&
      _standardCancellationImport.hasMatch(text)) {
    return 'cancellation';
  }
  // A JNI exception of a java.lang type only carries its text.
  if (!kotlin &&
      RegExp('ThrowNew\\([^,]*,\\s*"$c"\\)').hasMatch(line) &&
      RegExp(r'FindClass\("([^"]+Exception)"\)')
          .allMatches(text)
          .every(
            (m) => const {
              'java/lang/IllegalStateException',
              'java/lang/IllegalArgumentException',
            }.contains(m[1]),
          )) {
    return 'JNI';
  }
  return null;
}

void main() {
  test(
    'every Core event and TUN producer has an explicit diagnostic contract',
    () {
      final adapter = File(
        'android/app/src/main/cpp/openvpn_core_adapter.cpp',
      ).readAsStringSync();
      final eventFunction = adapter.substring(
        adapter.indexOf('const char* FailureForEvent'),
        adapter.indexOf('class AndroidCoreClient'),
      );
      final events = RegExp(
        r'return "([a-z_]+)"',
      ).allMatches(eventFunction).map((match) => match[1]!).toSet();
      final tun = RegExp(
        r'"(tun_[a-z_]+)"',
      ).allMatches(adapter).map((match) => match[1]!).toSet();
      expect(events, _eventCategories.keys.toSet());
      expect(tun, _tunCategories.keys.toSet());
      expect(events, hasLength(36));
      expect(tun, hasLength(15));
      expect(diagnosticCodes, hasLength(206));
      for (final entry in {..._eventCategories, ..._tunCategories}.entries) {
        expect(diagnosticCodes, contains(entry.value), reason: entry.key);
        expect(diagnosticCode(entry.key), entry.value, reason: entry.key);
      }
    },
  );

  test('all Kotlin TUN results and C++ switch branches are inventoried', () {
    final adapter = File(
      'android/app/src/main/cpp/openvpn_core_adapter.cpp',
    ).readAsStringSync();
    final results = <int, String>{
      for (final match in RegExp(
        r'case (-\d+): failure = "(tun_[a-z_]+)";',
      ).allMatches(adapter))
        int.parse(match[1]!): match[2]!,
    };
    expect(results, _tunResults);
    final service = File(
      'android/app/src/main/kotlin/com/fuzevpn/android/OpenVpnService.kt',
    ).readAsStringSync();
    final kotlinResults = <int, String>{
      for (final match in RegExp(
        r'private const val (TUN_[A-Z_]+) = (-\d+)',
      ).allMatches(service))
        int.parse(match[2]!): match[1]!.toLowerCase(),
    };
    expect(kotlinResults, {
      -2: 'tun_already_established',
      -3: 'tun_plan_rejected',
      -7: 'tun_permission_revoked',
      -8: 'tun_establish_returned_null',
      -9: 'tun_establish_exception',
    });
    for (final entry in kotlinResults.entries) {
      expect(results[entry.key], entry.value);
      expect(_tunCategories, contains(entry.value));
    }
  });

  for (final entry in {..._eventCategories, ..._tunCategories}.entries) {
    test(
      'real controller retains ${entry.key} in error, events and checks',
      () async {
        final fixture = _Fixture();
        addTearDown(fixture.dispose);
        fixture.emit(entry.key);
        if (entry.key == 'tun_plan_rejected' ||
            entry.key == 'tun_establish_failed') {
          expect(
            fixture.controller.notice!.arguments['code'],
            'tun_configuration_rejected',
          );
        }
        fixture.expectReport(entry.key, entry.value);
      },
    );
  }

  test(
    'arbitrary native strings stay unknown through the real controller',
    () async {
      for (final code in [
        'tun_plan_rejected_private_fixture',
        'tun_establish_failed private@example.invalid',
        'TUN_PLAN_REJECTED',
        ' tun_plan_rejected',
        'tun_plan_rejected ',
        'https://private.invalid/fixture',
        'private_key_synthetic_0123456789',
      ]) {
        final fixture = _Fixture();
        try {
          fixture.emit(code);
          fixture.expectReport(code, 'unknown_error');
          expect(fixture.service.preparedReport!.json, isNot(contains(code)));
        } finally {
          await fixture.dispose();
        }
      }
      for (final value in <Object?>[
        null,
        7,
        <String>[],
        {'code': 'tun_plan_rejected'},
      ]) {
        expect(diagnosticCode(value), 'unknown_error');
      }
    },
  );

  test('A13-03 every Kotlin, C++ and bridge failure code keeps a v1 '
      'category', () {
    final sources = _nativeSources();
    final inventory = _nativeInventory(sources);
    // The audit's triggers are all inventoried from the real sources.
    for (final code in [
      'profile_too_large',
      'profile_invalid_dns',
      'openvpn_cipher_invalid',
      'openvpn_identity_in_use',
      'tunnel_disconnected',
      'openvpn_recovery_failed',
      'system_vpn_resume_unavailable',
      'system_vpn_resume_blocked',
      'vpn_permission_required',
      'vpn_permission_denied',
      'wireguard_operation_pending',
      'session_busy',
    ]) {
      expect(inventory, contains(code));
      expect(_producedAsFailure(code, sources), isTrue, reason: code);
    }
    final excluded = <String>{
      ..._nativeWireFields,
      ..._nativeTimingSpans,
      ..._nativeProgressStates,
      ..._nativePlatformNames,
      ..._otherChannelCodes,
      ..._unrecordedOutcomes.keys,
      ..._swallowedNativeMessages.keys,
    };
    final explicit = <String, String>{
      ..._eventCategories,
      ..._tunCategories,
      ..._nativeFailureCategories,
    };
    final unmapped = <String>[];
    for (final entry in inventory.entries) {
      final code = entry.key;
      if (excluded.contains(code)) {
        expect(explicit, isNot(contains(code)), reason: code);
        continue;
      }
      final expected = explicit[code] ?? code;
      if (!diagnosticCodes.contains(expected) ||
          diagnosticCode(code) != expected) {
        unmapped.add(
          '$code (${entry.value.join(', ')}) -> ${diagnosticCode(code)}',
        );
      }
    }
    expect(unmapped, isEmpty, reason: 'unmapped native failure codes');
  });

  test('A13-03 exclusions are enforced, never assumed', () {
    final sources = _nativeSources();
    final inventory = _nativeInventory(sources);
    for (final code in {
      ..._nativeWireFields,
      ..._nativeTimingSpans,
      ..._nativeProgressStates,
      ..._nativePlatformNames,
    }) {
      expect(
        _producedAsFailure(code, sources),
        isFalse,
        reason: '$code is now a failure code and needs a v1 category',
      );
      expect(diagnosticCodes, isNot(contains(code)), reason: code);
    }
    for (final code in _otherChannelCodes) {
      for (final file in inventory[code] ?? const <String>{}) {
        expect(file, matches(_otherChannelFile), reason: code);
      }
    }
    for (final code in _unrecordedOutcomes.keys) {
      expect(diagnosticCodes, isNot(contains(code)), reason: code);
      expect(diagnosticCodeAliases, isNot(contains(code)), reason: code);
    }
    // Tile outcomes only reach the tile service callback, never a producer.
    final producer = RegExp(
      r'emitState\(|\.error\(|Exception\(|\bfailed\(|interrupt\(|'
      r'failAndStopLocked\(|result\.success\(',
    );
    for (final entry in _tileOutcomeConstants.entries) {
      for (final source in sources) {
        if (source.text.contains('"${entry.key}"')) {
          expect(
            source.text,
            contains('const val ${entry.value} = "${entry.key}"'),
            reason: entry.key,
          );
          expect(_producedAsFailure(entry.key, [source]), isFalse);
        }
        for (final line in source.text.split('\n')) {
          if (!RegExp('\\b${entry.value}\\b').hasMatch(line)) continue;
          expect(line, isNot(matches(producer)), reason: line.trim());
        }
      }
    }
    // These channels report through their own controllers, never through
    // DiagnosticService, so their codes cannot reach a report.
    for (final path in [
      'lib/billing_controller.dart',
      'lib/play_billing_bridge.dart',
      'lib/core/play_billing.dart',
      'lib/google_auth_controller.dart',
    ]) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('DiagnosticService')), reason: path);
      expect(source, isNot(contains('recordError(')), reason: path);
      expect(source, isNot(contains('diagnostics.dart')), reason: path);
    }
  });

  test('A13-03 swallowed exception messages never cross the bridge and get '
      'no alias', () {
    final sources = _nativeSources();
    final inventory = _nativeInventory(sources);
    final kotlin = sources.where((s) => s.name.endsWith('.kt')).toList();
    // No native source turns an exception's text into a code.
    for (final source in kotlin) {
      expect(
        source.text,
        isNot(matches(RegExp(r'\.(?:message|localizedMessage)\b'))),
        reason: source.name,
      );
      expect(source.text, isNot(contains('stackTraceToString')));
      // Standard exception names are never shadowed by a typed local class.
      expect(
        source.text,
        isNot(
          matches(
            RegExp(
              r'\b(?:class|typealias|object)\s+(?:IllegalArgumentException|'
              r'IllegalStateException|CancellationException)\b',
            ),
          ),
        ),
        reason: source.name,
      );
    }
    // The bridge only forwards the code of its own typed exceptions.
    final bridge = kotlin.singleWhere((s) => s.name == 'AndroidVpnBridge.kt');
    final start = bridge.text.indexOf('private fun messageCode(');
    expect(start, greaterThan(0));
    final body = bridge.text.substring(
      start,
      bridge.text.indexOf('?: fallback', start),
    );
    expect(RegExp(r'as\? (\w+)\)').allMatches(body).map((m) => m[1]).toSet(), {
      'VpnNativeException',
      'SecureStorageException',
      'SystemVpnResumeException',
    });
    final contexts = <String, Set<String>>{};
    final transmitted = <String>[];
    for (final code in _swallowedNativeMessages.keys) {
      expect(diagnosticCodeAliases, isNot(contains(code)), reason: code);
      expect(diagnosticCodes, isNot(contains(code)), reason: code);
      expect(inventory, contains(code), reason: '$code is no longer produced');
      expect(inventory[code], isNot(contains('native_vpn_bridge')));
      for (final source in sources) {
        for (final match in RegExp(
          '"${RegExp.escape(code)}"',
        ).allMatches(source.text)) {
          final context = _swallowedContext(source, code, match.start);
          if (context == null) {
            transmitted.add('$code (${source.name})');
          } else {
            contexts.putIfAbsent(code, () => <String>{}).add(context);
          }
        }
      }
    }
    expect(
      transmitted,
      isEmpty,
      reason: 'now transmitted: move to _nativeFailureCategories with an alias',
    );
    // The review's counterexamples are recognized in their real context.
    expect(contexts['invalid_profile'], {'runCatching'});
    expect(contexts['invalid_token'], {'runCatching'});
    expect(contexts['storage_value_too_large'], {'require'});
    expect(contexts['openvpn_native_state_unavailable'], {'JNI'});
    // Review round 2: the lot N worker withdrawal and the system start
    // cancellation tokens are standard cancellations.
    expect(contexts['wireguard_call_withdrawn'], {'cancellation'});
    expect(contexts['system_vpn_start_superseded'], {'cancellation'});
    expect(contexts['system_vpn_request_replaced'], {'cancellation'});
    // Synthetic controls: a typed exception, a state factory named error, or
    // a result kept by getOrElse would all transmit the code.
    String? synthetic(String name, String text) => _swallowedContext(
      _NativeSource(name, text),
      'invalid_profile',
      text.indexOf('"invalid_profile"'),
    );
    for (final import in [
      'java.util.concurrent',
      'kotlinx.coroutines',
      'kotlin.coroutines.cancellation',
    ]) {
      expect(
        synthetic(
          'A.kt',
          'import $import.CancellationException\r\n'
              'fun f() { throw CancellationException("invalid_profile") }',
        ),
        'cancellation',
        reason: import,
      );
    }
    for (final text in [
      // No standard import: a typed exception of the package.
      'fun f() { throw CancellationException("invalid_profile") }',
      'import com.fuzevpn.CancellationException\n'
          'fun f() { throw CancellationException("invalid_profile") }',
      'import kotlinx.coroutines.CancellationException\n'
          'fun f() { throw VpnCancellationException("invalid_profile") }',
    ]) {
      expect(synthetic('A.kt', text), isNull, reason: text);
    }
    expect(
      synthetic(
        'A.kt',
        'val x = runCatching { error("invalid_profile") }'
            '.getOrNull()',
      ),
      'runCatching',
    );
    for (final text in [
      'fun f() { throw VpnNativeException("invalid_profile") }',
      'val x = runCatching { throw SecureStorageException("invalid_profile") '
          '}.getOrElse { null }',
      'val x = runCatching { error("invalid_profile") }.getOrElse { it }',
      'val x = runCatching { State.error("invalid_profile") }.getOrNull()',
      'fun error(c: String) = State(c)\n'
          'val x = runCatching { error("invalid_profile") }.getOrNull()',
      'emitState(VpnStatus.ERROR, null, "invalid_profile")',
    ]) {
      expect(synthetic('A.kt', text), isNull, reason: text);
    }
    expect(
      synthetic(
        'a.cpp',
        'env->FindClass("com/fuzevpn/TypedException");\n'
            'env->ThrowNew(type.get(), "invalid_profile");',
      ),
      isNull,
    );
    // Positive controls: transmitted codes are never taken for swallowed.
    for (final code in [
      'vpn_permission_required',
      'openvpn_identity_in_use',
      'system_vpn_resume_unavailable',
      'connection_failed',
    ]) {
      for (final source in sources) {
        for (final match in RegExp('"$code"').allMatches(source.text)) {
          expect(
            _swallowedContext(source, code, match.start),
            isNull,
            reason: '$code (${source.name})',
          );
        }
      }
    }
  });

  test('A13-03 aliases only target existing v1 categories', () {
    expect(diagnosticCodes, hasLength(206));
    for (final entry in diagnosticCodeAliases.entries) {
      expect(diagnosticCodes, isNot(contains(entry.key)), reason: entry.key);
      expect(diagnosticCodes, contains(entry.value), reason: entry.key);
      expect(diagnosticCodeAliases, isNot(contains(entry.value)));
    }
    for (final entry in _nativeFailureCategories.entries) {
      expect(entry.value, isNot('unknown_error'), reason: entry.key);
      expect(diagnosticCodes, contains(entry.value), reason: entry.key);
      expect(diagnosticCode(entry.key), entry.value, reason: entry.key);
    }
    // Near misses of the new codes still stay unknown.
    for (final code in [
      'profile_too_large ',
      'PROFILE_TOO_LARGE',
      'tunnel_disconnected_private',
      'vpn-permission-denied',
      'session_busy\n',
    ]) {
      expect(diagnosticCode(code), 'unknown_error', reason: code);
    }
  });

  for (final entry in _nativeFailureCategories.entries) {
    test(
      'A13-03 real controller retains ${entry.key} as ${entry.value}',
      () async {
        final fixture = _Fixture();
        addTearDown(fixture.dispose);
        fixture.emit(entry.key);
        fixture.expectReport(entry.key, entry.value);
        expect(
          fixture.service.preparedReport!.json,
          isNot(contains('"${entry.key}"')),
        );
      },
    );
  }

  // Review round 2 (probe D1): the only path that records this native code is
  // a user stop under always-on, when Android's VPN settings cannot open.
  test('A13-03 a user stop whose VPN settings cannot open is recorded as '
      'tunnel_stop_failed by the real controller', () async {
    final transport = _OfflineTransport();
    final service = DiagnosticService(
      transport: transport,
      baseUri: Uri.parse('https://synthetic.invalid'),
      scheduleRetries: false,
    );
    service.setMetadata({'app_version': '1.2.3'});
    final tunnel = _SystemTunnel();
    final controller = VpnAppController(
      api: _NoData(),
      sessionStore: _NoData(),
      preferences: _NoData(),
      tunnel: tunnel,
      diagnostics: service,
    );
    addTearDown(() async {
      controller.dispose();
      await tunnel.close();
    });
    await controller.disconnect(userRequested: true, forceNativeStop: true);
    expect(tunnel.userStops, 1);
    expect(controller.tunnelState.messageCode, 'vpn_settings_unavailable');
    final report = service
        .prepareFull(
          snapshot: const {},
          state: 'error',
          protocol: 'wireguard',
          checks: const [],
        )
        .toJson();
    expect((report['error'] as Map)['code'], 'tunnel_stop_failed');
    final coded = (report['events'] as List)
        .cast<Map<String, dynamic>>()
        .where((event) => event.containsKey('code'))
        .toList();
    expect(coded, isNotEmpty);
    for (final event in coded) {
      expect(event['code'], 'tunnel_stop_failed');
    }
    expect(jsonEncode(report), isNot(contains('vpn_settings_unavailable')));
    expect(transport.requests, 0);
  });

  test('A13-03 profile refusals regain automatic reports, user refusals '
      'stay manual', () async {
    Future<List<Map<String, dynamic>>> automatic(String code) async {
      final transport = _RecordingTransport();
      final service = DiagnosticService(
        transport: transport,
        baseUri: Uri.parse('https://synthetic.invalid'),
        scheduleRetries: false,
      );
      addTearDown(service.dispose);
      service.setMetadata({'app_version': '1.2.3'});
      service.setSession(
        accountId: 'synthetic-account',
        token: 'synthetic-token',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );
      service.setAutomaticConsent(true);
      service.recordError(code, operation: 'connect', domain: 'tunnel');
      await service.retryPending();
      return transport.bodies;
    }

    for (final entry in {
      'profile_invalid_dns': 'profile_rejected',
      'profile_too_large': 'profile_rejected',
      'profile_invalid_encoding': 'profile_rejected',
      'openvpn_cipher_invalid': 'profile_invalid_cipher',
      'openvpn_tls_verification_required': 'profile_missing_required_directive',
      'profile_invalid_ca': 'profile_invalid_ca',
      // A user who cannot stop the VPN from the app is reported too.
      'vpn_settings_unavailable': 'tunnel_stop_failed',
    }.entries) {
      final bodies = await automatic(entry.key);
      expect(bodies, hasLength(1), reason: entry.key);
      expect((bodies.single['error'] as Map)['code'], entry.value);
      if (entry.key != entry.value) {
        expect(jsonEncode(bodies.single), isNot(contains('"${entry.key}"')));
      }
    }
    for (final code in [
      'vpn_permission_denied',
      'vpn_permission_required',
      'vpn_disclosure_required',
      'tunnel_disconnected',
      'wireguard_operation_pending',
      'openvpn_identity_in_use',
      'session_operation_cancelled',
    ]) {
      expect(await automatic(code), isEmpty, reason: code);
    }
  });
}

class _RecordingTransport extends ApiHttpTransport {
  final bodies = <Map<String, dynamic>>[];

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    final body = jsonDecode(request.body!) as Map<String, dynamic>;
    bodies.add(body);
    return ApiHttpResponse(
      statusCode: 201,
      headers: const {},
      body: jsonEncode({
        'status': 'received',
        'duplicate': false,
        'report_id': 'a1000000-0000-4000-8000-000000000099',
        'client_report_id': body['report_id'],
        'received_at': '2026-09-23T00:00:00Z',
        'expires_at': '2026-10-23T00:00:00Z',
      }),
    );
  }
}

class _Fixture {
  _Fixture() {
    service.setMetadata({'app_version': '1.2.3'});
    controller = VpnAppController(
      api: _NoData(),
      sessionStore: _NoData(),
      preferences: _NoData(),
      tunnel: tunnel,
      diagnostics: service,
    );
  }

  final transport = _OfflineTransport();
  final tunnel = _Tunnel();
  late final service = DiagnosticService(
    transport: transport,
    baseUri: Uri.parse('https://synthetic.invalid'),
    scheduleRetries: false,
  );
  late final VpnAppController controller;

  void emit(String code) => tunnel.events.add(
    VpnRuntimeState(
      phase: VpnRuntimePhase.error,
      protocol: VpnProtocol.openVpn,
      messageCode: code,
    ),
  );

  void expectReport(String sourceCode, String expectedCode) {
    final report = service
        .prepareFull(
          snapshot: const {},
          state: 'error',
          protocol: 'openvpn',
          checks: [
            {'id': 'tunnel_connection', 'result': 'failed', 'code': sourceCode},
          ],
        )
        .toJson();
    expect((report['error'] as Map)['code'], expectedCode);
    expect(((report['checks'] as List).single as Map)['code'], expectedCode);
    final events = report['events'] as List;
    expect(events, hasLength(2));
    expect(events.where((event) => event['source'] == 'native'), hasLength(1));
    expect(
      events.where((event) => event['source'] == 'controller'),
      hasLength(1),
    );
    for (final event in events) {
      expect((event as Map)['code'], expectedCode);
    }
    expect(transport.requests, 0);
  }

  Future<void> dispose() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _OfflineTransport extends ApiHttpTransport {
  int requests = 0;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests++;
    throw StateError('No diagnostic must be submitted');
  }
}

class _Tunnel implements VpnTunnelGateway {
  final events = StreamController<VpnRuntimeState>.broadcast(sync: true);

  Future<void> close() => events.close();

  @override
  Stream<VpnRuntimeState> get states => events.stream;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A tunnel whose user stop asks Android's VPN settings, which cannot open.
class _SystemTunnel extends _Tunnel implements VpnSystemProtectionGateway {
  int userStops = 0;

  @override
  Future<void> disconnectByUser() async {
    userStops++;
    throw const NativeVpnException('vpn_settings_unavailable');
  }
}

class _NoData
    implements VpnApiRepository, SecureSessionStore, AppPreferenceStore {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
