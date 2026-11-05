import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/hedged_http_open.dart';

import 'fixtures/api_transport/synthetic_tls_fixture.dart';

void main() {
  for (final redirect in [
    (method: 'GET', status: 302),
    (method: 'POST', status: 303),
  ]) {
    test(
      '${redirect.method} ${redirect.status} cannot forward Google context across origins',
      () async {
        final origin = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        final target = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        final transport = IoApiHttpTransport(
          client: HttpClient()..findProxy = (_) => 'DIRECT',
        );
        var forwardedRequests = 0;
        final originListener = origin.listen((request) async {
          await request.drain<void>();
          request.response.statusCode = redirect.status;
          request.response.headers.set(
            'location',
            'http://127.0.0.1:${target.port}/capture',
          );
          await request.response.close();
        });
        final targetListener = target.listen((request) async {
          forwardedRequests++;
          request.response.write('{}');
          await request.response.close();
        });
        try {
          final response = await transport.send(
            ApiHttpRequest(
              method: redirect.method,
              uri: Uri.parse(
                'http://127.0.0.1:${origin.port}/v1/auth/google/context',
              ),
              headers: const {
                'authorization': 'Bearer synthetic-bearer-only',
                'x-fuze-browser-context': 'synthetic-context-only',
                'x-fuze-auth-generation': '3',
              },
            ),
          );
          expect(response.statusCode, redirect.status);
          expect(forwardedRequests, 0);
        } finally {
          transport.close();
          await origin.close(force: true);
          await target.close(force: true);
          await originListener.cancel();
          await targetListener.cancel();
        }
      },
    );
  }

  test('redirect body is subject to the response byte budget', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final transport = IoApiHttpTransport(
      client: HttpClient()..findProxy = (_) => 'DIRECT',
    );
    var requests = 0;
    final handlers = <Future<void>>[];
    final listener = server.listen((request) {
      requests++;
      handlers.add(() async {
        try {
          request.response.statusCode = 302;
          request.response.headers.set('location', '/final');
          request.response.add(List<int>.filled(1024 * 1024 + 1, 32));
          await request.response.close();
        } on IOException {
          // Exceeding the budget deliberately cancels the response stream.
        }
      }());
    });
    try {
      // The redirect is not followed and its body is dropped at the budget;
      // as any non-2xx response it keeps its status (A04-transport-01).
      final response = await transport.send(
        ApiHttpRequest(
          method: 'GET',
          uri: Uri.parse('http://127.0.0.1:${server.port}/initial'),
          headers: const {},
        ),
      );
      expect(response.statusCode, 302);
      expect(response.body, isEmpty);
      expect(requests, 1);
    } finally {
      transport.close();
      await server.close(force: true);
      await listener.cancel();
      await Future.wait(handlers);
    }
  });

  test(
    'timed out TLS openings are physically closed without closing the client',
    () async {
      final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final sockets = <Socket>[];
      final subscriptions = <StreamSubscription<List<int>>>[];
      var closedSockets = 0;
      final listener = server.listen((socket) {
        sockets.add(socket);
        subscriptions.add(
          socket.listen(
            (_) {},
            onDone: () => closedSockets++,
            onError: (Object _) {},
          ),
        );
      });
      final transport = IoApiHttpTransport(
        opener: const HedgedHttpOpen(hedgeDelay: Duration(milliseconds: 20)),
        requestTimeout: const Duration(milliseconds: 100),
      );
      try {
        for (var attempt = 0; attempt < 4; attempt++) {
          await expectLater(
            transport.send(
              ApiHttpRequest(
                method: 'GET',
                uri: Uri.parse(
                  'https://127.0.0.1:${server.port}/never-handshakes',
                ),
                headers: const {},
              ),
            ),
            throwsA(isA<ApiNetworkException>()),
          );
        }
        await Future<void>.delayed(const Duration(milliseconds: 250));
        expect(sockets.length, greaterThanOrEqualTo(4));
        expect(closedSockets, sockets.length);

        // The same pooled client remains usable by unrelated subsequent calls.
        final healthy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        final healthyListener = healthy.listen((request) async {
          request.response.write('ok');
          await request.response.close();
        });
        try {
          final response = await transport.send(
            ApiHttpRequest(
              method: 'GET',
              uri: Uri.parse('http://127.0.0.1:${healthy.port}/healthy'),
              headers: const {},
            ),
          );
          expect(response.body, 'ok');
        } finally {
          await healthy.close(force: true);
          await healthyListener.cancel();
        }
      } finally {
        transport.close();
        for (final socket in sockets) {
          socket.destroy();
        }
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
        await listener.cancel();
        await server.close();
      }
    },
  );

  test(
    'connection budget preserves an injected stricter timeout and socket pooling',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final io = HttpClient()
        ..findProxy = ((_) => 'DIRECT')
        ..connectionTimeout = const Duration(milliseconds: 50);
      final transport = IoApiHttpTransport(
        client: io,
        requestTimeout: const Duration(seconds: 1),
      );
      final remotePorts = <int>[];
      final listener = server.listen((request) async {
        remotePorts.add(request.connectionInfo!.remotePort);
        request.response.contentLength = 2;
        request.response.write('ok');
        await request.response.close();
      });
      try {
        expect(io.connectionTimeout, const Duration(milliseconds: 50));
        for (var attempt = 0; attempt < 2; attempt++) {
          await Future<void>.delayed(Duration.zero);
          expect(
            (await transport.send(
              ApiHttpRequest(
                method: 'GET',
                uri: Uri.parse('http://127.0.0.1:${server.port}/healthy'),
                headers: const {},
              ),
            )).body,
            'ok',
          );
        }
        expect(remotePorts, hasLength(2));
        expect(remotePorts[0], remotePorts[1]);
      } finally {
        transport.close();
        await server.close(force: true);
        await listener.cancel();
      }
    },
  );

  test(
    'expiring real TLS openings does not cancel a concurrent healthy request',
    () async {
      final blocked = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final healthy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final sockets = <Socket>[];
      final subscriptions = <StreamSubscription<List<int>>>[];
      final blockedListener = blocked.listen((socket) {
        sockets.add(socket);
        subscriptions.add(socket.listen((_) {}, onError: (Object _) {}));
      });
      final handlers = <Future<void>>[];
      final healthyListener = healthy.listen((request) {
        handlers.add(() async {
          await Future<void>.delayed(const Duration(milliseconds: 130));
          request.response.write('independent');
          await request.response.close();
        }());
      });
      final transport = IoApiHttpTransport(
        requestTimeout: const Duration(milliseconds: 180),
      );
      try {
        final expired = expectLater(
          transport.send(
            ApiHttpRequest(
              method: 'GET',
              uri: Uri.parse('https://127.0.0.1:${blocked.port}/blocked'),
              headers: const {},
            ),
          ),
          throwsA(isA<ApiNetworkException>()),
        );
        await Future<void>.delayed(const Duration(milliseconds: 70));
        final independent = transport.send(
          ApiHttpRequest(
            method: 'GET',
            uri: Uri.parse('http://127.0.0.1:${healthy.port}/healthy'),
            headers: const {},
          ),
        );
        await expired;
        expect((await independent).body, 'independent');
      } finally {
        transport.close();
        for (final socket in sockets) {
          socket.destroy();
        }
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
        await blockedListener.cancel();
        await blocked.close();
        await healthy.close(force: true);
        await healthyListener.cancel();
        await Future.wait(handlers);
      }
    },
  );

  test(
    'default TLS verifies certificates and hosts, streams bodies and reuses its socket',
    () async {
      final context = SecurityContext()
        ..useCertificateChainBytes(utf8.encode(syntheticCertificatePem))
        ..usePrivateKeyBytes(utf8.encode(syntheticPrivateKeyPem));
      final server = await HttpServer.bindSecure(
        InternetAddress.anyIPv4,
        0,
        context,
      );
      final transport = IoApiHttpTransport(
        requestTimeout: const Duration(seconds: 3),
      );
      final ports = <int>[];
      final bodies = <String>[];
      final handlers = <Future<void>>[];
      final body = List.filled(30000, 'été🔒').join();
      final listener = server.listen(
        (request) {
          ports.add(request.connectionInfo!.remotePort);
          handlers.add(() async {
            expect(
              request.headers.value('authorization'),
              'Bearer synthetic-tls-only',
            );
            bodies.add(await utf8.decoder.bind(request).join());
            request.response.contentLength = utf8.encode(body).length;
            request.response.write(body);
            await request.response.close();
          }());
        },
        onError: (Object error) {
          if (error is! TlsException) throw error;
        },
      );
      ApiHttpRequest request(String host) => ApiHttpRequest(
        method: 'POST',
        uri: Uri.parse('https://$host:${server.port}/roundtrip'),
        headers: const {'authorization': 'Bearer synthetic-tls-only'},
        body: body,
      );
      try {
        // This public synthetic certificate is trusted only in this test isolate.
        // A real platform validation failure must remain rejected by default.
        await expectLater(
          transport.send(request('127.0.0.1')),
          throwsA(isA<ApiNetworkException>()),
        );
        expect(ports, isEmpty);
        SecurityContext.defaultContext.setTrustedCertificatesBytes(
          utf8.encode(syntheticCertificatePem),
        );
        for (var attempt = 0; attempt < 2; attempt++) {
          await Future<void>.delayed(Duration.zero);
          expect((await transport.send(request('127.0.0.1'))).body, body);
        }
        expect(bodies, [body, body]);
        expect(ports[0], ports[1]);
        await expectLater(
          transport.send(request('127.0.0.2')),
          throwsA(isA<ApiNetworkException>()),
        );
        expect(ports, hasLength(2));
      } finally {
        transport.close();
        await server.close(force: true);
        await listener.cancel();
        await Future.wait(handlers);
      }
    },
  );

  // 86401 is no longer malformed: C5-04 bounds it to 86400 (see below).
  for (final number in ['1e309', '-1e309', '1.5', '-1']) {
    test(
      'malformed optional retry $number preserves the typed HTTP failure',
      () async {
        final api = ApiClient(
          transport: _ResponseTransport(
            ApiHttpResponse(
              statusCode: 429,
              headers: const {},
              body: '{"error":"rate_limited","retry_after_seconds":$number}',
            ),
          ),
        );
        await expectLater(
          api.requestPasswordReset('synthetic@example.invalid'),
          throwsA(
            isA<ApiException>()
                .having((error) => error.statusCode, 'HTTP status', 429)
                .having((error) => error.code, 'error code', 'rate_limited')
                .having(
                  (error) => error.retryAfterSeconds,
                  'ignored optional delay',
                  isNull,
                ),
          ),
        );
      },
    );
  }

  test('valid bounded retries and the header precedence remain supported', () {
    for (final value in [0, 12, 12.0, '12', 86400]) {
      final expected = value == '12' ? 12 : (value as num).toInt();
      final result = ApiException.fromResponse(
        statusCode: 429,
        body: jsonEncode({
          'error': 'rate_limited',
          'retry_after_seconds': value,
        }),
      );
      expect(result.retryAfterSeconds, expected);
    }
    expect(
      ApiException.fromResponse(
        statusCode: 429,
        retryAfterHeader: '4',
        body: '{"error":"rate_limited","retry_after_seconds":1e309}',
      ).retryAfterSeconds,
      4,
    );
    for (final value in [86401, 86401.0, 1e100]) {
      expect(
        ApiException.fromResponse(
          statusCode: 429,
          body: jsonEncode({
            'error': 'rate_limited',
            'retry_after_seconds': value,
          }),
        ).retryAfterSeconds,
        86400,
      );
    }
  });

  test(
    'duplicate location IDs reject the entire catalogue with a protocol failure',
    () async {
      final api = ApiClient(
        transport: _ResponseTransport(
          ApiHttpResponse(
            statusCode: 200,
            headers: const {},
            body: jsonEncode({
              'locations': [
                _location('shared-01', 'Frankfurt', 'DE'),
                _location('shared-01', 'Sao Paulo', 'BR'),
              ],
            }),
          ),
        ),
      );
      await expectLater(api.locations(), throwsA(isA<ApiProtocolException>()));
    },
  );

  test(
    'distinct IDs may retain the same display name in a valid catalogue',
    () async {
      final api = ApiClient(
        transport: _ResponseTransport(
          ApiHttpResponse(
            statusCode: 200,
            headers: const {},
            body: jsonEncode({
              'locations': [
                _location('frankfurt-01', 'Frankfurt', 'DE'),
                _location('frankfurt-02', 'Frankfurt', 'DE'),
              ],
            }),
          ),
        ),
      );
      expect((await api.locations()).map((location) => location.id), [
        'frankfurt-01',
        'frankfurt-02',
      ]);
    },
  );
}

Map<String, Object> _location(String id, String city, String country) => {
  'id': id,
  'city': city,
  'display_name': city,
  'country_code': country,
  'supported_protocols': ['wireguard', 'openvpn'],
};

class _ResponseTransport extends ApiHttpTransport {
  _ResponseTransport(this.response);
  final ApiHttpResponse response;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async => response;
}
