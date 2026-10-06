import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

const _credential = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
const _sessionJson = <String, Object?>{
  'access_token': 'fixture-guest-session',
  'expires_at': '2099-01-01T00:00:00Z',
  'user_id': 'guest-123',
  'identity_kind': 'guest',
};
const _subscriptionJson = <String, Object?>{
  'status': 'active',
  'has_access': true,
  'provider': 'google_play',
  'expires_at': '2099-01-01T00:00:00Z',
};
const _restoreJson = <String, Object?>{
  ..._sessionJson,
  'purchase_status': 'verified',
  'subscription': _subscriptionJson,
};
const _claimJson = <String, Object?>{
  'identity_kind': 'registered',
  'email_verified': false,
  'verification_email_sent': true,
};

class _Transport extends ApiHttpTransport {
  int statusCode = 201;
  Object response = _sessionJson;
  Map<String, String> headers = <String, String>{
    'cache-control': 'private, no-store',
  };
  ApiHttpRequest? request;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest value) async {
    request = value;
    return ApiHttpResponse(
      statusCode: statusCode,
      headers: headers,
      body: jsonEncode(response),
    );
  }
}

void main() {
  test(
    'guest creation sends only credential and explicit legal consent',
    () async {
      final transport = _Transport();
      final client = ApiClient(transport: transport);
      addTearDown(client.close);

      final result = await client.createGuestSession(
        guestCredential: _credential,
        termsAccepted: true,
        privacyAccepted: true,
      );
      expect(result.userId, 'guest-123');
      expect(result.isGuest, isTrue);
      expect(result.session.accessToken, 'fixture-guest-session');
      expect(transport.request!.method, 'POST');
      expect(transport.request!.uri.path, '/v1/auth/guest');
      expect(transport.request!.headers['authorization'], isNull);
      expect(transport.request!.headers['cache-control'], 'no-store');
      expect(jsonDecode(transport.request!.body!), <String, Object?>{
        'guest_credential': _credential,
        'terms_accepted': true,
        'privacy_accepted': true,
      });

      await client.createGuestSession(guestCredential: _credential);
      expect(jsonDecode(transport.request!.body!), <String, Object?>{
        'guest_credential': _credential,
        'terms_accepted': false,
        'privacy_accepted': false,
      });
      expect(result.toString(), isNot(contains('fixture-guest-session')));
    },
  );

  test(
    'guest restore recovers server owner with no local owner or price',
    () async {
      final transport = _Transport()..response = _restoreJson;
      final client = ApiClient(transport: transport);
      addTearDown(client.close);

      final result = await client.restoreGuestSession(
        purchaseToken: 'fixture-purchase',
        guestCredential: _credential,
      );
      expect(result.userId, 'guest-123');
      expect(result.purchaseStatus, 'verified');
      expect(result.subscription.hasAccess, isTrue);
      expect(result.subscription.provider, 'google_play');
      expect(transport.request!.uri.path, '/v1/auth/guest/google-play/restore');
      expect(transport.request!.headers['authorization'], isNull);
      expect(jsonDecode(transport.request!.body!), <String, Object?>{
        'purchase_token': 'fixture-purchase',
        'guest_credential': _credential,
      });
      expect(result.toString(), isNot(contains('fixture-guest-session')));
      expect(result.toString(), isNot(contains('fixture-purchase')));
    },
  );

  test('pending restoration retains the server denial of access', () async {
    final transport = _Transport()
      ..response = <String, Object?>{
        ..._restoreJson,
        'purchase_status': 'pending',
        'subscription': <String, Object?>{
          'status': 'inactive',
          'has_access': false,
          'provider': null,
          'expires_at': null,
        },
      };
    final client = ApiClient(transport: transport);
    addTearDown(client.close);
    final result = await client.restoreGuestSession(
      purchaseToken: 'fixture-purchase',
      guestCredential: _credential,
    );
    expect(result.purchaseStatus, 'pending');
    expect(result.subscription.hasAccess, isFalse);
  });

  test(
    'claim is authenticated email and password only, without token rotation',
    () async {
      final transport = _Transport()
        ..statusCode = 200
        ..response = _claimJson;
      final client = ApiClient(transport: transport);
      addTearDown(client.close);

      final result = await client.claimGuestAccount(
        token: 'fixture-guest-session',
        email: 'client@example.test',
        password: 'fixture-password',
      );
      expect(result.identityKind, 'registered');
      expect(result.emailVerified, isFalse);
      expect(result.verificationEmailSent, isTrue);
      expect(transport.request!.uri.path, '/v1/auth/guest/claim');
      expect(
        transport.request!.headers['authorization'],
        'Bearer fixture-guest-session',
      );
      expect(jsonDecode(transport.request!.body!), <String, Object?>{
        'email': 'client@example.test',
        'password': 'fixture-password',
      });
    },
  );

  test(
    'provider errors retain retry delay and registered restoration stays blocked',
    () async {
      final transport = _Transport()
        ..statusCode = 503
        ..response = <String, Object?>{'error': 'google_play_unavailable'}
        ..headers = <String, String>{'retry-after': '7'};
      final client = ApiClient(transport: transport);
      addTearDown(client.close);
      await expectLater(
        client.restoreGuestSession(
          purchaseToken: 'fixture-purchase',
          guestCredential: _credential,
        ),
        throwsA(
          isA<ApiException>()
              .having(
                (failure) => failure.code,
                'code',
                'google_play_unavailable',
              )
              .having((failure) => failure.retryAfterSeconds, 'retry delay', 7),
        ),
      );
      transport
        ..statusCode = 409
        ..response = <String, Object?>{'error': 'account_login_required'};
      await expectLater(
        client.restoreGuestSession(
          purchaseToken: 'fixture-purchase',
          guestCredential: _credential,
        ),
        throwsA(
          isA<ApiException>().having(
            (failure) => failure.code,
            'code',
            'account_login_required',
          ),
        ),
      );
      transport.response = <String, Object?>{'error': 'email_exists'};
      await expectLater(
        client.claimGuestAccount(
          token: 'fixture-guest-session',
          email: 'existing@example.test',
          password: 'fixture-password',
        ),
        throwsA(
          isA<ApiException>().having(
            (failure) => failure.code,
            'code',
            'email_exists',
          ),
        ),
      );
    },
  );

  for (final route in <String>['create', 'restore', 'claim']) {
    test(
      '$route rejects an unexpected successful HTTP status and caching',
      () async {
        final transport = _Transport()
          ..statusCode = route == 'claim' ? 201 : 200
          ..response = route == 'create'
              ? _sessionJson
              : route == 'restore'
              ? _restoreJson
              : _claimJson;
        final client = ApiClient(transport: transport);
        addTearDown(client.close);
        Future<Object> call() => switch (route) {
          'create' => client.createGuestSession(guestCredential: _credential),
          'restore' => client.restoreGuestSession(
            purchaseToken: 'fixture-purchase',
            guestCredential: _credential,
          ),
          _ => client.claimGuestAccount(
            token: 'fixture-guest-session',
            email: 'client@example.test',
            password: 'fixture-password',
          ),
        };
        await expectLater(call(), throwsA(isA<ApiException>()));
        transport
          ..statusCode = route == 'claim' ? 200 : 201
          ..headers = <String, String>{'cache-control': 'private'};
        await expectLater(call(), throwsA(isA<ApiProtocolException>()));
      },
    );
  }

  test(
    'guest result rejects registered owner or malformed identifier/session',
    () {
      for (final change in <Map<String, Object?>>[
        <String, Object?>{'identity_kind': 'registered'},
        <String, Object?>{'identity_kind': null},
        <String, Object?>{'user_id': 'raw owner@example.test'},
        <String, Object?>{'user_id': ''},
        <String, Object?>{'access_token': null},
        <String, Object?>{'expires_at': 'invalid'},
      ]) {
        expect(
          () => GuestSessionResult.fromJson(<String, dynamic>{
            ..._sessionJson,
            ...change,
          }),
          throwsFormatException,
        );
      }
    },
  );

  test(
    'restore rejects unsupported purchase state and malformed common entitlement',
    () {
      for (final change in <Map<String, Object?>>[
        <String, Object?>{'purchase_status': 'processing'},
        <String, Object?>{'purchase_status': 'active'},
        <String, Object?>{'subscription': null},
        <String, Object?>{
          'subscription': <String, Object?>{
            ..._subscriptionJson,
            'has_access': 'true',
          },
        },
      ]) {
        expect(
          () => GuestRestoreResult.fromJson(<String, dynamic>{
            ..._restoreJson,
            ...change,
          }),
          throwsFormatException,
        );
      }
    },
  );

  test(
    'claim cannot smuggle a replacement session or ambiguous verification status',
    () {
      for (final change in <Map<String, Object?>>[
        <String, Object?>{'identity_kind': 'guest'},
        <String, Object?>{'email_verified': null},
        <String, Object?>{'verification_email_sent': 'true'},
        <String, Object?>{'access_token': 'unexpected-rotation'},
        <String, Object?>{'expires_at': '2099-01-01T00:00:00Z'},
      ]) {
        expect(
          () => GuestClaimResult.fromJson(<String, dynamic>{
            ..._claimJson,
            ...change,
          }),
          throwsFormatException,
        );
      }
    },
  );
}
