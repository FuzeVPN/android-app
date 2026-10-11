import 'dart:convert';

/// Failures returned by the public FuzeVPN API or raised before a response
/// can be parsed.  None of these types retain an HTTP body, URL query, token,
/// VPN profile, or transport exception: those values can contain credentials.
sealed class ApiFailure implements Exception {
  const ApiFailure({
    required this.code,
    this.statusCode,
    this.retryAfterSeconds,
  });

  /// Stable machine-readable code suitable for controller decisions.
  final String code;

  /// HTTP status when the server responded, otherwise `null`.
  final int? statusCode;

  /// Bounded delay supplied by the server, when applicable.
  final int? retryAfterSeconds;
}

/// An unsuccessful HTTP response from the public API.
class ApiException extends ApiFailure {
  const ApiException({
    required super.statusCode,
    required String errorCode,
    super.retryAfterSeconds,
  }) : errorCode = errorCode,
       super(code: errorCode);

  /// The API's stable `error` value. Unknown but syntactically safe values are
  /// preserved to allow forward-compatible generic handling.
  final String errorCode;

  /// Parses the documented public error envelope without retaining its body.
  factory ApiException.fromResponse({
    required int statusCode,
    required String body,
    String? retryAfterHeader,
  }) {
    var errorCode = 'api_error';
    var retryAfterSeconds = _parseRetryAfter(retryAfterHeader);
    try {
      final dynamic decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        final candidate = decoded['error'];
        if (candidate is String && _isStableCode(candidate)) {
          errorCode = candidate;
        }
        retryAfterSeconds ??= _parseRetryAfterValue(
          decoded['retry_after_seconds'],
        );
      }
    } on FormatException {
      // A malformed failure response intentionally becomes a generic error.
    }
    return ApiException(
      statusCode: statusCode,
      errorCode: errorCode,
      retryAfterSeconds: retryAfterSeconds,
    );
  }

  @override
  String toString() {
    final String retry = retryAfterSeconds == null
        ? ''
        : ', retryAfterSeconds: $retryAfterSeconds';
    return 'ApiException(statusCode: $statusCode, errorCode: $errorCode$retry)';
  }
}

/// The API returned a successful HTTP status with an invalid or unsafe shape.
class ApiProtocolException extends ApiFailure {
  const ApiProtocolException({
    super.code = 'invalid_api_response',
    super.statusCode,
  });

  @override
  String toString() =>
      'ApiProtocolException(code: $code, statusCode: $statusCode)';
}

/// A connection, TLS, timeout, or other transport failure that did not yield a
/// trusted API response. The source exception is deliberately not exposed.
class ApiNetworkException extends ApiFailure {
  const ApiNetworkException({super.code = 'network_unavailable'});

  @override
  String toString() => 'ApiNetworkException(code: $code)';
}

/// Presentation-safe localization contract for a public API failure.
class ApiErrorMessage {
  const ApiErrorMessage({
    required this.titleKey,
    required this.messageKey,
    required this.arguments,
    this.retryAfterSeconds,
    this.diagnosticCode,
    this.machineCode,
    this.httpStatus,
  });

  final String titleKey;
  final String messageKey;
  final Map<String, Object?> arguments;
  final int? retryAfterSeconds;
  final String? diagnosticCode;
  final String? machineCode;
  final int? httpStatus;
}

/// Converts trusted API metadata into localization identifiers and parameters.
abstract final class ApiErrorMessages {
  static const Set<String> _retryCodes = <String>{
    'verification_email_cooldown',
    'rate_limited',
  };

  static ApiErrorMessage fromFailure(ApiFailure failure) {
    final int? retryAfter = failure.retryAfterSeconds;
    final bool retryMessage = _retryCodes.contains(failure.code);
    final String localizationCode = switch (failure.code) {
      'node_unavailable' => 'target_unavailable',
      'openvpn_state_signer_unavailable' ||
      'openvpn_signer_invalid_response' => 'openvpn_signer_unavailable',
      'invalid_or_expired_token' || 'invalid_reset' => 'invalid_token',
      'network_timeout' => 'network_unavailable',
      _ => failure.code,
    };
    final String origin = failure.statusCode == null
        ? 'NETWORK'
        : 'HTTP-${failure.statusCode}';
    return ApiErrorMessage(
      titleKey: 'notice.api.title',
      messageKey: retryMessage
          ? retryAfter == null
                ? 'notice.retryLater'
                : 'notice.retryAfter'
          : 'notice.api.message',
      arguments: <String, Object?>{
        'code': localizationCode,
        if (retryAfter != null) 'seconds': retryAfter,
      },
      retryAfterSeconds: retryAfter,
      diagnosticCode: 'API-$origin · ${failure.code}',
      machineCode: failure.code,
      httpStatus: failure.statusCode,
    );
  }
}

bool _isStableCode(String value) =>
    RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(value);

int? _parseRetryAfter(String? value) =>
    value == null ? null : _parseRetryAfterValue(value);

int? _parseRetryAfterValue(Object? value) {
  final int? seconds = switch (value) {
    final int value => value,
    final num value when value == value.roundToDouble() => value.toInt(),
    final String value => int.tryParse(value.trim()),
    _ => null,
  };
  return seconds != null && seconds >= 0 && seconds <= 86400 ? seconds : null;
}
