import 'dart:async';

import 'package:flutter/services.dart';

abstract interface class SecurityChallengeGateway {
  Future<SecurityChallengeResult> solve({
    required String requestId,
    required String title,
    required String cancelLabel,
  });
  Future<void> cancel({required String requestId});
}

class SecurityChallengeResult {
  const SecurityChallengeResult({required this.requestId, required this.token});
  final String requestId;
  final String token;
  @override
  String toString() => 'SecurityChallengeResult(redacted: true)';
}

class SecurityChallengeException implements Exception {
  SecurityChallengeException(String code) : code = _safeCode(code);
  final String code;
  @override
  String toString() => 'SecurityChallengeException($code)';
}

const _safeCodes = {
  'cancelled',
  'interrupted',
  'unavailable',
  'busy',
  'invalid_request',
  'invalid_response',
  'provider_error',
};
String _safeCode(String code) =>
    _safeCodes.contains(code) ? code : 'provider_error';
final _requestIdPattern = RegExp(r'^[A-Za-z0-9_-]{16,128}$');
final _tokenPattern = RegExp(r'^[\x21-\x7e]{1,2048}$');

/// A public widget only. Fuze sessions and Google tickets never cross this channel.
class NativeSecurityChallengeGateway implements SecurityChallengeGateway {
  NativeSecurityChallengeGateway({
    MethodChannel? channel,
    this.solveTimeout = defaultSolveTimeout,
  }) : _channel =
           channel ?? const MethodChannel('com.fuzevpn/security_challenge');

  /// Native TurnstilePolicy.TIMEOUT_MS (240 s) owns the user-facing deadline
  /// and reports its own terminal code. This guard only covers a native side
  /// that never answers, so it must outlive that deadline.
  static const defaultSolveTimeout = Duration(minutes: 4, seconds: 20);

  final MethodChannel _channel;
  final Duration solveTimeout;
  String? _activeRequestId;
  Completer<void>? _cancelled;
  int _generation = 0;

  @override
  Future<SecurityChallengeResult> solve({
    required String requestId,
    required String title,
    required String cancelLabel,
  }) async {
    if (!_validId(requestId) ||
        !_validLabel(title, 120) ||
        !_validLabel(cancelLabel, 64)) {
      throw SecurityChallengeException('invalid_request');
    }
    if (_activeRequestId != null) throw SecurityChallengeException('busy');
    final generation = ++_generation;
    final cancelled = Completer<void>();
    _activeRequestId = requestId;
    _cancelled = cancelled;
    try {
      final raw = await Future.any<Object?>([
        _invoke('solve', {
          'requestId': requestId,
          'title': title,
          'cancelLabel': cancelLabel,
        }),
        cancelled.future.then<Object?>(
          (_) => throw SecurityChallengeException('cancelled'),
        ),
      ]).timeout(solveTimeout);
      if (generation != _generation || _activeRequestId != requestId) {
        throw SecurityChallengeException('cancelled');
      }
      if (raw is! Map ||
          raw.length != 2 ||
          raw['requestId'] != requestId ||
          raw['token'] is! String ||
          !_validToken(raw['token'] as String)) {
        throw SecurityChallengeException('invalid_response');
      }
      return SecurityChallengeResult(
        requestId: requestId,
        token: raw['token'] as String,
      );
    } on TimeoutException {
      unawaited(cancel(requestId: requestId).catchError((Object _) {}));
      // The user did not cancel: the provider never produced a terminal result.
      throw SecurityChallengeException('provider_error');
    } finally {
      if (generation == _generation && _activeRequestId == requestId) {
        _activeRequestId = null;
        _cancelled = null;
      }
    }
  }

  @override
  Future<void> cancel({required String requestId}) async {
    if (!_validId(requestId)) {
      throw SecurityChallengeException('invalid_request');
    }
    if (_activeRequestId == requestId) {
      _generation++;
      _activeRequestId = null;
      final cancelled = _cancelled;
      _cancelled = null;
      if (cancelled != null && !cancelled.isCompleted) cancelled.complete();
    }
    try {
      await _invoke('cancel', {
        'requestId': requestId,
      }).timeout(const Duration(seconds: 2));
    } on TimeoutException {
      throw SecurityChallengeException('interrupted');
    }
  }

  Future<Object?> _invoke(String method, Map<String, Object?> arguments) async {
    try {
      return await _channel.invokeMethod<Object?>(method, arguments);
    } on PlatformException catch (error) {
      throw SecurityChallengeException(error.code);
    } on MissingPluginException {
      throw SecurityChallengeException('unavailable');
    } catch (_) {
      throw SecurityChallengeException('provider_error');
    }
  }

  static bool _validId(String value) =>
      value.length <= 128 &&
      _requestIdPattern.firstMatch(value)?.end == value.length;
  static bool _validToken(String value) =>
      value.length <= 2048 &&
      _tokenPattern.hasMatch(value) &&
      !value.contains('\n');
  static bool _validLabel(String value, int maxLength) =>
      value.trim().isNotEmpty &&
      value.length <= maxLength &&
      !value.contains(RegExp(r'[\x00-\x1f\x7f-\x9f]'));
}
