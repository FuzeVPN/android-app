// Corrections du 29/10/2026 — A04-transport-01.
// Chemin réel : IoApiHttpTransport() (client possédé) puis ApiClient, sur un
// serveur HTTP loopback. Un corps d'erreur non UTF-8, mal encodé ou plus grand
// que le budget de 1 Mio ne doit plus effacer le statut HTTP ni Retry-After ;
// un corps 2xx reste strict.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

typedef _Reply = ({int status, Map<String, String> headers, List<int> body});

/// Serveur loopback qui renvoie des octets bruts, sans recodage du SDK.
class _RawServer {
  _RawServer._(this.server);

  final HttpServer server;
  var requests = 0;

  static Future<_RawServer> bind(_Reply reply) async {
    final value = _RawServer._(
      await HttpServer.bind(InternetAddress.loopbackIPv4, 0),
    );
    value.server.autoCompress = false;
    value.server.listen((request) async {
      value.requests++;
      await request.drain<void>();
      request.response.statusCode = reply.status;
      reply.headers.forEach(request.response.headers.set);
      request.response.add(reply.body);
      await request.response.close();
    });
    return value;
  }

  Uri get base => Uri.parse('http://127.0.0.1:${server.port}/');

  Future<void> close() => server.close(force: true);
}

/// Socket brute : écrit [head] puis [body] après [delay], puis ferme sa
/// sortie ([close]) ou garde la connexion ouverte sans rien envoyer de plus.
class _SocketServer {
  _SocketServer._(this.server);

  final ServerSocket server;
  final sockets = <Socket>[];
  final peerClosed = Completer<void>();
  var connections = 0;

  static Future<_SocketServer> bind(
    String head,
    List<int> body, {
    bool close = true,
    Duration delay = Duration.zero,
  }) async {
    final value = _SocketServer._(
      await ServerSocket.bind(InternetAddress.loopbackIPv4, 0),
    );
    value.server.listen((socket) async {
      value.connections++;
      value.sockets.add(socket);
      socket.listen(
        (_) {},
        onError: (Object _) {},
        onDone: () {
          if (!value.peerClosed.isCompleted) value.peerClosed.complete();
        },
      );
      unawaited(socket.done.then<void>((_) {}, onError: (Object _) {}));
      try {
        await Future<void>.delayed(delay);
        socket.add(ascii.encode(head));
        socket.add(body);
        await socket.flush();
        if (close) await socket.close();
      } catch (_) {
        // The client may already have given up.
      }
    });
    return value;
  }

  Uri get base => Uri.parse('http://127.0.0.1:${server.port}/');

  Future<void> close() async {
    for (final socket in sockets) {
      socket.destroy();
    }
    await server.close();
  }
}

final List<int> _latin1Html = latin1.encode(
  '<html><body>Service indisponible é ç</body></html>',
);

Future<Object?> _failureOf(Future<Object?> Function() call) async {
  try {
    await call();
  } catch (error) {
    return error;
  }
  return null;
}

void main() {
  group('A04-transport-01 non-success bodies keep HTTP metadata', () {
    final cases = <String, _Reply>{
      '503 Latin-1 HTML with Retry-After': (
        status: 503,
        headers: {
          'retry-after': '30',
          'content-type': 'text/html; charset=iso-8859-1',
        },
        body: _latin1Html,
      ),
      '503 invalid gzip with Retry-After': (
        status: 503,
        headers: {'retry-after': '30', 'content-encoding': 'gzip'},
        body: ascii.encode('{"error":"server_error"}'),
      ),
      '502 truncated UTF-8 sequence with Retry-After': (
        status: 502,
        headers: {'retry-after': '30'},
        body: <int>[...ascii.encode('{"error":"bad_gateway"'), 0xe2, 0x82],
      ),
      '504 lone continuation byte with Retry-After': (
        status: 504,
        headers: {'retry-after': '30'},
        body: <int>[0x80, 0x80, 0xff],
      ),
      // Same consequence through the byte budget (review of 29/10).
      '503 body over 1 MiB with Retry-After': (
        status: 503,
        headers: {'retry-after': '30'},
        body: List<int>.filled(1024 * 1024 + 1, 0x20),
      ),
      '503 gzip expanding over 1 MiB with Retry-After': (
        status: 503,
        headers: {'retry-after': '30', 'content-encoding': 'gzip'},
        body: gzip.encode(List<int>.filled(2 * 1024 * 1024, 0x20)),
      ),
      '502 1 MiB envelope prefix then padding with Retry-After': (
        status: 502,
        headers: {'retry-after': '30'},
        body: <int>[
          ...ascii.encode('{"error":"bad_gateway"}'),
          ...List<int>.filled(1024 * 1024, 0x20),
        ],
      ),
    };
    for (final entry in cases.entries) {
      test('${entry.key} stays an ApiException', () async {
        final server = await _RawServer.bind(entry.value);
        final api = ApiClient(
          baseUri: server.base,
          transport: IoApiHttpTransport(),
        );
        try {
          final error = await _failureOf(
            () => api.requestPasswordReset('synthetic@example.invalid'),
          );
          expect(
            error,
            isA<ApiException>()
                .having((e) => e.statusCode, 'status', entry.value.status)
                .having((e) => e.code, 'code', 'api_error')
                .having((e) => e.retryAfterSeconds, 'Retry-After', 30),
          );
          expect(server.requests, 1);
          final message = ApiErrorMessages.fromFailure(error! as ApiFailure);
          expect(
            message.diagnosticCode,
            'API-HTTP-${entry.value.status} · api_error',
          );
        } finally {
          api.close();
          await server.close();
        }
      });
    }

    test(
      'a stable error envelope survives an invalid byte in another field',
      () async {
        final server = await _RawServer.bind((
          status: 429,
          headers: const {},
          body: <int>[
            ...ascii.encode('{"error":"rate_limited","message":"'),
            0xe9, // Latin-1 é, invalid in UTF-8.
            ...ascii.encode('","retry_after_seconds":42}'),
          ],
        ));
        final api = ApiClient(
          baseUri: server.base,
          transport: IoApiHttpTransport(),
        );
        try {
          final error = await _failureOf(
            () => api.requestPasswordReset('synthetic@example.invalid'),
          );
          expect(
            error,
            isA<ApiException>()
                .having((e) => e.statusCode, 'status', 429)
                .having((e) => e.code, 'code', 'rate_limited')
                .having((e) => e.retryAfterSeconds, 'Retry-After', 42),
          );
        } finally {
          api.close();
          await server.close();
        }
      },
    );

    test('guest recovery 503 keeps the deferrable server status', () async {
      final server = await _RawServer.bind((
        status: 503,
        headers: {'retry-after': '30'},
        body: _latin1Html,
      ));
      final api = ApiClient(
        baseUri: server.base,
        transport: IoApiHttpTransport(),
      );
      try {
        final error = await _failureOf(
          () => api.createGuestSession(guestCredential: 'synthetic-guest'),
        );
        expect(
          error,
          isA<ApiFailure>()
              .having((e) => e.statusCode, 'status', 503)
              .having((e) => e.retryAfterSeconds, 'Retry-After', 30),
        );
      } finally {
        api.close();
        await server.close();
      }
    });

    test('the raw transport returns the status and headers', () async {
      final server = await _RawServer.bind((
        status: 503,
        headers: {'retry-after': '30'},
        body: _latin1Html,
      ));
      final transport = IoApiHttpTransport();
      try {
        final response = await transport.send(
          ApiHttpRequest(method: 'GET', uri: server.base, headers: const {}),
        );
        expect(response.statusCode, 503);
        expect(response.header('retry-after'), '30');
        expect(response.body, contains('Service indisponible'));
      } finally {
        transport.close();
        await server.close();
      }
    });

    test('a 64 MiB 503 body stops at the byte budget', () async {
      // Raw socket: HttpServer hides the peer's reset, a socket reports it.
      final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      const limit = 64 * 1024 * 1024;
      var written = 0;
      final writing = Completer<Object?>();
      server.listen((socket) async {
        socket.listen((_) {}, onError: (Object _) {});
        unawaited(socket.done.then<void>((_) {}, onError: (Object _) {}));
        socket.add(
          ascii.encode(
            'HTTP/1.1 503 Service Unavailable\r\nRetry-After: 30\r\n'
            'Content-Length: $limit\r\n\r\n',
          ),
        );
        final chunk = List<int>.filled(64 * 1024, 0x20);
        try {
          while (written < limit) {
            socket.add(chunk);
            await socket.flush();
            written += chunk.length;
          }
          writing.complete(null);
        } catch (error) {
          writing.complete(error);
        }
      });
      final transport = IoApiHttpTransport(
        requestTimeout: const Duration(seconds: 10),
      );
      try {
        final response = await transport.send(
          ApiHttpRequest(
            method: 'GET',
            uri: Uri.parse('http://127.0.0.1:${server.port}/'),
            headers: const {},
          ),
        );
        expect(response.statusCode, 503);
        expect(response.header('retry-after'), '30');
        expect(response.body, isEmpty);
        // The client closed the connection instead of draining the body.
        expect(
          await writing.future.timeout(const Duration(seconds: 5)),
          isA<SocketException>(),
        );
        expect(written, lessThan(limit));
      } finally {
        transport.close();
        await server.close();
      }
    });

    test('a 503 body of exactly 1 MiB is still read', () async {
      final server = await _RawServer.bind((
        status: 503,
        headers: {'retry-after': '30'},
        body: <int>[
          ...ascii.encode('{"error":"maintenance"}'),
          ...List<int>.filled(1024 * 1024 - 23, 0x20),
        ],
      ));
      final api = ApiClient(
        baseUri: server.base,
        transport: IoApiHttpTransport(),
      );
      try {
        final error = await _failureOf(
          () => api.requestPasswordReset('synthetic@example.invalid'),
        );
        expect(
          error,
          isA<ApiException>()
              .having((e) => e.statusCode, 'status', 503)
              .having((e) => e.code, 'code', 'maintenance')
              .having((e) => e.retryAfterSeconds, 'Retry-After', 30),
        );
      } finally {
        api.close();
        await server.close();
      }
    });

    test('ASCII witness keeps the same typed failure', () async {
      final server = await _RawServer.bind((
        status: 503,
        headers: {'retry-after': '30'},
        body: ascii.encode('<html>Service indisponible</html>'),
      ));
      final api = ApiClient(
        baseUri: server.base,
        transport: IoApiHttpTransport(),
      );
      try {
        final error = await _failureOf(
          () => api.requestPasswordReset('synthetic@example.invalid'),
        );
        expect(
          error,
          isA<ApiException>()
              .having((e) => e.statusCode, 'status', 503)
              .having((e) => e.retryAfterSeconds, 'Retry-After', 30),
        );
      } finally {
        api.close();
        await server.close();
      }
    });
  });

  group('A04-transport-01 success bodies stay strict', () {
    final cases = <String, _Reply>{
      '200 invalid UTF-8': (
        status: 200,
        headers: {'cache-control': 'no-store'},
        body: <int>[...ascii.encode('{"limit":2,"devices":["'), 0xff, 0x22],
      ),
      '200 invalid gzip': (
        status: 200,
        headers: {'cache-control': 'no-store', 'content-encoding': 'gzip'},
        body: ascii.encode('{"limit":2,"devices":[]}'),
      ),
      '200 body over 1 MiB': (
        status: 200,
        headers: {'cache-control': 'no-store'},
        body: <int>[
          ...ascii.encode('{"limit":2,"devices":[]}'),
          ...List<int>.filled(1024 * 1024, 0x20),
        ],
      ),
      '200 gzip expanding over 1 MiB': (
        status: 200,
        headers: {'cache-control': 'no-store', 'content-encoding': 'gzip'},
        body: gzip.encode(<int>[
          ...ascii.encode('{"limit":2,"devices":[]}'),
          ...List<int>.filled(2 * 1024 * 1024, 0x20),
        ]),
      ),
    };
    for (final entry in cases.entries) {
      test('${entry.key} is a protocol failure with its status', () async {
        final server = await _RawServer.bind(entry.value);
        final api = ApiClient(
          baseUri: server.base,
          transport: IoApiHttpTransport(),
        );
        try {
          final error = await _failureOf(
            () => api.listDevices('synthetic-session'),
          );
          expect(
            error,
            isA<ApiProtocolException>()
                .having((e) => e.code, 'code', 'invalid_api_response')
                .having((e) => e.statusCode, 'status', 200),
          );
        } finally {
          api.close();
          await server.close();
        }
      });
    }

    test('valid UTF-8 success bodies are unchanged', () async {
      final server = await _RawServer.bind((
        status: 200,
        headers: {'cache-control': 'no-store'},
        body: utf8.encode('{"limit":2,"devices":[]}'),
      ));
      final api = ApiClient(
        baseUri: server.base,
        transport: IoApiHttpTransport(),
      );
      try {
        expect((await api.listDevices('synthetic-session')).limit, 2);
      } finally {
        api.close();
        await server.close();
      }
    });
  });

  // Review round 2: once the headers of a non-2xx response have arrived in
  // time, nothing that happens to its body (truncation, broken chunked
  // framing, closed connection, body still pending at the deadline) removes
  // its status or Retry-After. A partial envelope is never interpreted.
  group('A04-transport-01 non-success body framing failures', () {
    const retry = 'Retry-After: 30\r\n';
    final cases = <String, (int, String, List<int>)>{
      '503 Content-Length 1000, 10 bytes then close': (
        503,
        'HTTP/1.1 503 Service Unavailable\r\n${retry}Content-Length: 1000\r\n\r\n',
        ascii.encode('0123456789'),
      ),
      '503 broken chunked framing': (
        503,
        'HTTP/1.1 503 Service Unavailable\r\n$retry'
            'Transfer-Encoding: chunked\r\n\r\n',
        ascii.encode('zz\r\nabc\r\n0\r\n\r\n'),
      ),
      '502 chunked body cut before its last chunk': (
        502,
        'HTTP/1.1 502 Bad Gateway\r\n${retry}Transfer-Encoding: chunked\r\n\r\n',
        ascii.encode('5\r\nabcde\r\n'),
      ),
      '429 stable envelope cut before its end': (
        429,
        'HTTP/1.1 429 Too Many Requests\r\n${retry}Content-Length: 100\r\n\r\n',
        ascii.encode('{"error":"rate_limited","retry_after_seconds":42'),
      ),
    };
    for (final entry in cases.entries) {
      test('${entry.key} keeps its status and Retry-After', () async {
        final (status, head, body) = entry.value;
        final server = await _SocketServer.bind(head, body);
        final api = ApiClient(
          baseUri: server.base,
          transport: IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 5),
          ),
        );
        final watch = Stopwatch()..start();
        try {
          final error = await _failureOf(
            () => api.requestPasswordReset('synthetic@example.invalid'),
          );
          expect(
            error,
            isA<ApiException>()
                .having((e) => e.statusCode, 'status', status)
                .having((e) => e.code, 'code', 'api_error')
                .having((e) => e.retryAfterSeconds, 'Retry-After', 30),
          );
          expect(watch.elapsed, lessThan(const Duration(seconds: 2)));
          expect(server.connections, 1);
        } finally {
          api.close();
          await server.close();
        }
      });
    }

    test('a 503 body still pending at the deadline keeps its status', () async {
      final server = await _SocketServer.bind(
        'HTTP/1.1 503 Service Unavailable\r\n${retry}Content-Length: 1000\r\n\r\n',
        ascii.encode('<html>'),
        close: false,
      );
      final api = ApiClient(
        baseUri: server.base,
        transport: IoApiHttpTransport(
          requestTimeout: const Duration(seconds: 1),
        ),
      );
      final watch = Stopwatch()..start();
      try {
        final error = await _failureOf(
          () => api.requestPasswordReset('synthetic@example.invalid'),
        );
        expect(
          error,
          isA<ApiException>()
              .having((e) => e.statusCode, 'status', 503)
              .having((e) => e.code, 'code', 'api_error')
              .having((e) => e.retryAfterSeconds, 'Retry-After', 30),
        );
        // The deadline is not extended, and the connection is released.
        expect(watch.elapsed, greaterThan(const Duration(milliseconds: 900)));
        expect(watch.elapsed, lessThan(const Duration(seconds: 3)));
        await server.peerClosed.future.timeout(const Duration(seconds: 2));
      } finally {
        api.close();
        await server.close();
      }
    });

    final witnesses = <String, (String, List<int>, bool, Duration, String)>{
      '200 Content-Length 1000, 10 bytes then close': (
        'HTTP/1.1 200 OK\r\nCache-Control: no-store\r\n'
            'Content-Length: 1000\r\n\r\n',
        ascii.encode('{"limit":2'),
        true,
        Duration.zero,
        'network_unavailable',
      ),
      '200 broken chunked framing': (
        'HTTP/1.1 200 OK\r\nCache-Control: no-store\r\n'
            'Transfer-Encoding: chunked\r\n\r\n',
        ascii.encode('zz\r\nabc\r\n0\r\n\r\n'),
        true,
        Duration.zero,
        'network_unavailable',
      ),
      '200 body still pending at the deadline': (
        'HTTP/1.1 200 OK\r\nCache-Control: no-store\r\n'
            'Content-Length: 1000\r\n\r\n',
        ascii.encode('{"limit":2'),
        false,
        Duration.zero,
        'network_timeout',
      ),
      '503 headers after the deadline': (
        'HTTP/1.1 503 Service Unavailable\r\n${retry}Content-Length: 0\r\n\r\n',
        const <int>[],
        false,
        const Duration(milliseconds: 1500),
        'network_timeout',
      ),
    };
    for (final entry in witnesses.entries) {
      test('${entry.key} stays a network failure', () async {
        final (head, body, close, delay, code) = entry.value;
        final server = await _SocketServer.bind(
          head,
          body,
          close: close,
          delay: delay,
        );
        final api = ApiClient(
          baseUri: server.base,
          transport: IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 1),
          ),
        );
        try {
          final error = await _failureOf(
            () => api.listDevices('synthetic-session'),
          );
          expect(
            error,
            isA<ApiNetworkException>()
                .having((e) => e.code, 'code', code)
                .having((e) => e.statusCode, 'status', isNull),
          );
        } finally {
          api.close();
          await server.close();
        }
      });
    }
  });
}
