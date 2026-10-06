import 'dart:convert';

import 'package:flutter/services.dart';

abstract interface class GoogleCredentialGateway {
  Future<GoogleCredentialCapabilities> getCapabilities();
  Future<GoogleCredentialResult> signIn({
    required String requestId,
    required String serverClientId,
    required String nonce,
  });
  Future<void> cancelSignIn({required String requestId});
  Future<void> clearCredentialState();
}

/// Private API continuations survive a lost response, unlike Google ID tokens.
abstract interface class GooglePendingAuthStore {
  Future<String?> readPendingAuthentication();
  Future<void> writePendingAuthentication(String payload);
  Future<void> clearPendingAuthentication();
}

class GoogleCredentialCapabilities {
  const GoogleCredentialCapabilities({required this.supported, this.reason});
  final bool supported;
  final String? reason;
}

class GoogleCredentialResult {
  const GoogleCredentialResult({
    required this.requestId,
    required this.idToken,
  });
  final String requestId;
  final String idToken;
  @override
  String toString() => 'GoogleCredentialResult(redacted: true)';
}

class GoogleCredentialException implements Exception {
  GoogleCredentialException(String code) : code = _safeError(code);
  final String code;
  @override
  String toString() => 'GoogleCredentialException($code)';
}

const _errorCodes = <String>{
  'cancelled',
  'busy',
  'unavailable',
  'interrupted',
  'no_credential',
  'invalid_request',
  'invalid_response',
  'provider_error',
  'invalid_pending_authentication',
  'secure_storage_failed',
  'secure_storage_corrupt',
};
String _safeError(Object? value) =>
    value is String && _errorCodes.contains(value) ? value : 'provider_error';
final _requestIdentifier = RegExp(r'^[A-Za-z0-9._-]{1,128}$');
final _clientIdentifier = RegExp(
  r'^[0-9]+-[A-Za-z0-9_-]+\.apps\.googleusercontent\.com$',
);
bool _printable(String value) =>
    value.codeUnits.every((unit) => unit >= 33 && unit <= 126);
bool _validRequestIdentifier(String value) =>
    value.length <= 128 &&
    _printable(value) &&
    _requestIdentifier.hasMatch(value);

/// Typed method channel. Provider messages/details and credential bundles are
/// deliberately excluded from every error and representation exposed to UI.
class NativeGoogleCredentialGateway
    implements GoogleCredentialGateway, GooglePendingAuthStore {
  NativeGoogleCredentialGateway({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('com.fuzevpn/google_auth');
  final MethodChannel _channel;
  String? _activeRequestId;
  int _generation = 0;

  @override
  Future<GoogleCredentialCapabilities> getCapabilities() async {
    final raw = await _invoke('getCapabilities');
    if (raw is! Map ||
        raw.keys.toSet().difference({'supported', 'reason'}).isNotEmpty ||
        raw['supported'] is! bool) {
      throw GoogleCredentialException('invalid_response');
    }
    final supported = raw['supported'] as bool;
    final reason = raw['reason'];
    if (supported && reason != null || !supported && reason != 'unavailable') {
      throw GoogleCredentialException('invalid_response');
    }
    return GoogleCredentialCapabilities(
      supported: supported,
      reason: reason as String?,
    );
  }

  @override
  Future<GoogleCredentialResult> signIn({
    required String requestId,
    required String serverClientId,
    required String nonce,
  }) async {
    if (!_validRequestIdentifier(requestId) ||
        serverClientId.length > 256 ||
        !_printable(serverClientId) ||
        !_clientIdentifier.hasMatch(serverClientId) ||
        nonce.isEmpty ||
        nonce.length > 1024 ||
        !_printable(nonce)) {
      throw GoogleCredentialException('invalid_request');
    }
    if (_activeRequestId != null) throw GoogleCredentialException('busy');
    final generation = ++_generation;
    _activeRequestId = requestId;
    try {
      final raw = await _invoke('signIn', {
        'requestId': requestId,
        'serverClientId': serverClientId,
        'nonce': nonce,
      });
      if (generation != _generation || _activeRequestId != requestId) {
        throw GoogleCredentialException('cancelled');
      }
      if (raw is! Map ||
          raw.keys.toSet().difference({'requestId', 'idToken'}).isNotEmpty ||
          raw['requestId'] != requestId ||
          raw['idToken'] is! String) {
        throw GoogleCredentialException('invalid_response');
      }
      final token = raw['idToken'] as String;
      if (token.isEmpty || token.length > 65536 || !_printable(token)) {
        throw GoogleCredentialException('invalid_response');
      }
      return GoogleCredentialResult(requestId: requestId, idToken: token);
    } catch (_) {
      if (generation != _generation || _activeRequestId != requestId) {
        throw GoogleCredentialException('cancelled');
      }
      rethrow;
    } finally {
      if (generation == _generation && _activeRequestId == requestId) {
        _activeRequestId = null;
      }
    }
  }

  @override
  Future<void> cancelSignIn({required String requestId}) async {
    if (!_validRequestIdentifier(requestId)) {
      throw GoogleCredentialException('invalid_request');
    }
    if (_activeRequestId == requestId) {
      _generation++;
      _activeRequestId = null;
    }
    await _invoke('cancelSignIn', {'requestId': requestId});
  }

  @override
  Future<void> clearCredentialState() async {
    _generation++;
    _activeRequestId = null;
    await _invoke('clearCredentialState');
  }

  @override
  Future<String?> readPendingAuthentication() async {
    final raw = await _invoke('readPendingAuthentication');
    if (raw == null) return null;
    if (raw is! String || !_validPendingAuthentication(raw)) {
      throw GoogleCredentialException('secure_storage_corrupt');
    }
    return raw;
  }

  @override
  Future<void> writePendingAuthentication(String payload) async {
    if (!_validPendingAuthentication(payload)) {
      throw GoogleCredentialException('invalid_pending_authentication');
    }
    await _invoke('writePendingAuthentication', {'payload': payload});
  }

  @override
  Future<void> clearPendingAuthentication() async {
    await _invoke('clearPendingAuthentication');
  }

  Future<dynamic> _invoke(
    String method, [
    Map<String, Object?>? arguments,
  ]) async {
    try {
      return await _channel.invokeMethod<dynamic>(method, arguments);
    } on PlatformException catch (error) {
      throw GoogleCredentialException(_safeError(error.code));
    } on MissingPluginException {
      throw GoogleCredentialException('unavailable');
    } catch (_) {
      throw GoogleCredentialException('provider_error');
    }
  }
}

bool _validPendingAuthentication(String payload) {
  try {
    if (utf8.encode(payload).length > 16384) return false;
    final value = jsonDecode(payload);
    if (value is! Map<String, dynamic>) return false;
    const required = {
      'version',
      'request_id',
      'purpose',
      'stage',
      'ticket',
      'context',
      'expires_at',
      'generation',
    };
    const optional = {'challenge_id', 'user_id'};
    if (!value.keys.toSet().containsAll(required) ||
        value.keys.any(
          (key) => !required.contains(key) && !optional.contains(key),
        )) {
      return false;
    }
    bool text(String key, int limit) =>
        value[key] is String &&
        (value[key] as String).isNotEmpty &&
        (value[key] as String).length <= limit;
    if (value['version'] is! int ||
        value['version'] != 1 ||
        !text('request_id', 128) ||
        !_validRequestIdentifier(value['request_id'] as String) ||
        !{'authenticate', 'claim', 'link'}.contains(value['purpose']) ||
        !{'challenge', 'continuation', 'uncertain'}.contains(value['stage']) ||
        !text('ticket', 8192) ||
        !_printable(value['ticket'] as String) ||
        !text('context', 8192) ||
        !_printable(value['context'] as String) ||
        !text('expires_at', 64) ||
        !_validExpiry(value['expires_at'] as String) ||
        value['generation'] is! int ||
        (value['generation'] as int) < 1 ||
        (value['generation'] as int) > 9007199254740991) {
      return false;
    }
    for (final key in optional) {
      if (value.containsKey(key) &&
          (!text(key, 160) ||
              !_printable(value[key] as String) ||
              !RegExp(
                r'^[A-Za-z0-9._-]{1,160}$',
              ).hasMatch(value[key] as String))) {
        return false;
      }
    }
    return true;
  } catch (_) {
    return false;
  }
}

bool _validExpiry(String value) {
  final match = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(?:\.\d{1,9})?(Z|[+-](\d{2}):(\d{2}))$',
  ).firstMatch(value);
  if (match == null || match.end != value.length) return false;
  final year = int.parse(match[1]!);
  final month = int.parse(match[2]!);
  final day = int.parse(match[3]!);
  final hour = int.parse(match[4]!);
  final minute = int.parse(match[5]!);
  final second = int.parse(match[6]!);
  if (month < 1 ||
      month > 12 ||
      day < 1 ||
      day > DateTime.utc(year, month + 1, 0).day ||
      hour > 23 ||
      minute > 59 ||
      second > 59) {
    return false;
  }
  if (match[7] != 'Z') {
    final offsetHour = int.parse(match[8]!);
    final offsetMinute = int.parse(match[9]!);
    if (offsetHour > 18 ||
        offsetMinute > 59 ||
        offsetHour == 18 && offsetMinute != 0) {
      return false;
    }
  }
  return DateTime.tryParse(value) != null;
}
