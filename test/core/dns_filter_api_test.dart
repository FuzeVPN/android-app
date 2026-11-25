import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

class _Transport extends ApiHttpTransport {
  int statusCode = 200;
  Object response = const <String, Object?>{
    'ad_blocking': false,
    'available': true,
    'updated_at': null,
  };
  Map<String, String> headers = <String, String>{'cache-control': 'no-store'};
  final List<ApiHttpRequest> requests = <ApiHttpRequest>[];

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest value) async {
    requests.add(value);
    return ApiHttpResponse(
      statusCode: statusCode,
      headers: headers,
      body: jsonEncode(response),
    );
  }
}

void main() {
  late _Transport transport;
  late ApiClient client;

  setUp(() {
    transport = _Transport();
    client = ApiClient(transport: transport);
  });

  tearDown(() => client.close());

  test('reads the account choice with the session token', () async {
    transport.response = const <String, Object?>{
      'ad_blocking': true,
      'available': false,
      'updated_at': '2026-11-25T13:09:00Z',
    };

    final DnsFilterSettings settings = await client.dnsFilter('session-token');

    expect(
      settings,
      const DnsFilterSettings(adBlocking: true, available: false),
    );
    final ApiHttpRequest request = transport.requests.single;
    expect(request.method, 'GET');
    expect(request.uri.path, '/v1/me/dns-filter');
    expect(request.uri.query, isEmpty);
    expect(request.headers['authorization'], 'Bearer session-token');
    expect(request.body, isNull);
  });

  test('saves the choice with the exact body of the contract', () async {
    transport.response = const <String, Object?>{
      'ad_blocking': true,
      'available': true,
      'updated_at': '2026-11-25T13:10:00Z',
    };

    final DnsFilterSettings settings = await client.updateDnsFilter(
      token: 'session-token',
      adBlocking: true,
    );

    expect(settings, const DnsFilterSettings(adBlocking: true, available: true));
    final ApiHttpRequest request = transport.requests.single;
    expect(request.method, 'PUT');
    expect(request.uri.path, '/v1/me/dns-filter');
    expect(request.headers['authorization'], 'Bearer session-token');
    expect(jsonDecode(request.body!), <String, Object?>{'ad_blocking': true});

    await client.updateDnsFilter(token: 'session-token', adBlocking: false);
    expect(jsonDecode(transport.requests.last.body!), <String, Object?>{
      'ad_blocking': false,
    });
  });

  test('refuses an answer that does not follow the contract', () async {
    for (final Object response in <Object>[
      const <String, Object?>{'ad_blocking': 'true', 'available': true},
      const <String, Object?>{'ad_blocking': true},
      const <String, Object?>{
        'ad_blocking': true,
        'available': true,
        'updated_at': 1764076140,
      },
      const <Object?>[true],
    ]) {
      transport.response = response;
      await expectLater(
        client.dnsFilter('session-token'),
        throwsA(isA<ApiProtocolException>()),
        reason: '$response',
      );
    }
  });

  test('refuses an answer that a cache may keep', () async {
    transport.headers = const <String, String>{};

    await expectLater(
      client.updateDnsFilter(token: 'session-token', adBlocking: true),
      throwsA(isA<ApiProtocolException>()),
    );
  });

  test('reports the rate limit as an API failure', () async {
    transport
      ..statusCode = 429
      ..response = const <String, Object?>{'error': 'rate_limited'};

    await expectLater(
      client.updateDnsFilter(token: 'session-token', adBlocking: true),
      throwsA(
        isA<ApiFailure>().having(
          (ApiFailure failure) => failure.statusCode,
          'statusCode',
          429,
        ),
      ),
    );
  });
}
