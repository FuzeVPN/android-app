import 'dart:convert';
import 'dart:io' show HttpDate;

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
  /// [dateHeader] is the response `Date`, the reference of an HTTP-date
  /// `Retry-After`.
  factory ApiException.fromResponse({
    required int statusCode,
    required String body,
    String? retryAfterHeader,
    String? dateHeader,
  }) {
    var errorCode = 'api_error';
    var retryAfterSeconds = ApiRetryAfter.parseHeader(
      retryAfterHeader,
      dateHeader: dateHeader,
    );
    try {
      final dynamic decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        final candidate = decoded['error'];
        if (candidate is String && _isStableCode(candidate)) {
          errorCode = candidate;
        }
        retryAfterSeconds ??= ApiRetryAfter.parseSeconds(
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

/// Server retry delays (RFC 9110 §10.2.3), shared by error envelopes and
/// accepted location migrations.
///
/// A delay is advisory: a readable value is honoured and bounded to the
/// caller's maximum instead of being discarded, and an unreadable one is
/// ignored. It never turns an otherwise valid response into a rejection.
/// Only finite, integral, non-negative numbers reach an integer conversion.
abstract final class ApiRetryAfter {
  /// Longest delay applied to a failure (24 hours).
  static const int maximumSeconds = 86400;

  static final RegExp _delaySeconds = RegExp(r'^\+?([0-9]+)$');
  static final RegExp _dayName = RegExp(r'^[A-Za-z]{3,9}$');

  /// Parses a `Retry-After` field: delay-seconds or an HTTP-date. An HTTP-date
  /// is measured from the response [dateHeader] so that the device clock does
  /// not matter; [now] (default: the local clock) is used only when that
  /// header is missing or invalid. Repeated fields, joined with commas by the
  /// transport, keep their longest readable delay.
  static int? parseHeader(
    String? value, {
    String? dateHeader,
    DateTime? now,
    int maximum = maximumSeconds,
  }) {
    if (value == null || value.length > 512) return null;
    final parts = value.split(',');
    DateTime? reference;
    int? untilDate(String text) {
      final DateTime? date = _httpDate(text);
      if (date == null) return null;
      reference ??=
          _httpDate(dateHeader ?? '') ?? (now ?? DateTime.now()).toUtc();
      final int milliseconds = date.difference(reference!).inMilliseconds;
      if (milliseconds <= 0) return 0;
      final int seconds = (milliseconds + 999) ~/ 1000;
      return seconds > maximum ? maximum : seconds;
    }

    int? longest;
    for (var index = 0; index < parts.length; index++) {
      final String member = parts[index].trim();
      var seconds = _parseDelaySeconds(member, maximum);
      // IMF-fixdate and rfc850-date carry one comma after the day name.
      if (seconds == null &&
          _dayName.hasMatch(member) &&
          index + 1 < parts.length) {
        seconds = untilDate('$member,${parts[index + 1].trimRight()}');
        if (seconds != null) index++;
      }
      seconds ??= untilDate(member);
      if (seconds != null && (longest == null || seconds > longest)) {
        longest = seconds;
      }
    }
    return longest;
  }

  /// Parses a JSON `retry_after_seconds` value.
  static int? parseSeconds(
    Object? value, {
    int maximum = maximumSeconds,
  }) => switch (value) {
    final int value => value < 0 ? null : (value > maximum ? maximum : value),
    final num value
        when value.isFinite && value >= 0 && value == value.roundToDouble() =>
      value > maximum ? maximum : value.toInt(),
    final String value => _parseDelaySeconds(value.trim(), maximum),
    _ => null,
  };

  static int? _parseDelaySeconds(String value, int maximum) {
    final String? digits = _delaySeconds.firstMatch(value)?.group(1);
    if (digits == null) return null;
    final String significant = digits.replaceFirst(RegExp(r'^0+(?=.)'), '');
    // Longer than nine digits is above every bound; avoid int overflow.
    if (significant.length > 9) return maximum;
    final int seconds = int.parse(significant);
    return seconds > maximum ? maximum : seconds;
  }

  static DateTime? _httpDate(String value) {
    final String text = value.trim();
    if (text.isEmpty || text.length > 64) return null;
    final DateTime date;
    try {
      date = HttpDate.parse(text);
    } catch (_) {
      return null;
    }
    if (date.year >= 100) return date;
    // rfc850-date has a two-digit year: RFC 9110 §5.6.7 picks the most
    // recent matching year that is not more than 50 years in the future.
    final int current = DateTime.now().toUtc().year;
    var year = current - current % 100 + date.year;
    if (year > current + 50) year -= 100;
    return DateTime.utc(
      year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
    );
  }
}
