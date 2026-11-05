import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';

void main() {
  group('ApiException', () {
    test('parse le code public et Retry-After sans conserver le corps', () {
      final ApiException error = ApiException.fromResponse(
        statusCode: 429,
        retryAfterHeader: '18',
        body:
            '{"error":"verification_email_cooldown","retry_after_seconds":42,"detail":"token-secret tls-secret"}',
      );

      expect(error.statusCode, 429);
      expect(error.errorCode, 'verification_email_cooldown');
      expect(error.retryAfterSeconds, 18);
      expect(error.toString(), isNot(contains('token-secret')));
      expect(error.toString(), isNot(contains('tls-secret')));
    });

    test('utilise le délai JSON si l en-tête est absent', () {
      final ApiException error = ApiException.fromResponse(
        statusCode: 429,
        body: '{"error":"rate_limited","retry_after_seconds":42}',
      );

      expect(error.errorCode, 'rate_limited');
      expect(error.retryAfterSeconds, 42);
    });

    test('rejette les codes non fiables et borne les délais excessifs', () {
      final ApiException error = ApiException.fromResponse(
        statusCode: 500,
        retryAfterHeader: '-1',
        body:
            '{"error":"unsafe error with detail","retry_after_seconds":999999}',
      );

      expect(error.errorCode, 'api_error');
      // C5-04: an excessive delay is bounded to 24 h instead of being lost.
      expect(error.retryAfterSeconds, 86400);
    });

    test('ignore les délais illisibles', () {
      final ApiException error = ApiException.fromResponse(
        statusCode: 503,
        retryAfterHeader: 'later',
        body: '{"error":"server_error","retry_after_seconds":-5}',
      );

      expect(error.errorCode, 'server_error');
      expect(error.retryAfterSeconds, isNull);
    });
  });

  group('ApiErrorMessages', () {
    test('produit un contrat localisable pour les erreurs connues', () {
      final ApiErrorMessage message = ApiErrorMessages.fromFailure(
        const ApiException(
          statusCode: 409,
          errorCode: 'device_location_locked',
        ),
      );

      expect(message.titleKey, 'notice.api.title');
      expect(message.messageKey, 'notice.api.message');
      expect(message.arguments['code'], 'device_location_locked');
      expect(message.diagnosticCode, 'API-HTTP-409 · device_location_locked');
    });

    test('inclut le cooldown uniquement lorsqu il est fourni', () {
      final ApiErrorMessage message = ApiErrorMessages.fromFailure(
        const ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 12,
        ),
      );

      expect(message.messageKey, 'notice.retryAfter');
      expect(message.arguments['seconds'], 12);
      expect(message.retryAfterSeconds, 12);
      expect(message.diagnosticCode, 'API-HTTP-429 · rate_limited');
    });

    test('normalise les alias sans perdre le code diagnostic original', () {
      final ApiErrorMessage message = ApiErrorMessages.fromFailure(
        const ApiNetworkException(code: 'network_timeout'),
      );

      expect(message.arguments['code'], 'network_unavailable');
      expect(message.diagnosticCode, 'API-NETWORK · network_timeout');
    });

    test('ajoute la couche réseau au seul code diagnostic', () {
      final ApiErrorMessage plain = ApiErrorMessages.fromFailure(
        const ApiNetworkException(),
      );
      final ApiErrorMessage message = ApiErrorMessages.fromFailure(
        const ApiNetworkException(stage: 'tls', family: 'ipv6'),
      );
      final ApiErrorMessage defect = ApiErrorMessages.fromFailure(
        const ApiNetworkException(stage: 'client'),
      );

      expect(plain.diagnosticCode, 'API-NETWORK · network_unavailable');
      expect(
        message.diagnosticCode,
        'API-NETWORK · network_unavailable/tls/ipv6',
      );
      expect(defect.diagnosticCode, 'API-NETWORK · network_unavailable/client');
      for (final ApiErrorMessage staged in <ApiErrorMessage>[message, defect]) {
        expect(staged.titleKey, plain.titleKey);
        expect(staged.messageKey, plain.messageKey);
        expect(staged.arguments, plain.arguments);
        expect(staged.machineCode, 'network_unavailable');
        expect(staged.httpStatus, isNull);
      }
    });
  });
}
