import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

const _cleanupTimeout = Duration(seconds: 2);
const _privateFixtureText = 'socket-fixture-private-body';

void main() {
  test('continuous socket chunks cannot extend the total deadline', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final io = HttpClient()..findProxy = (_) => 'DIRECT';
    final transport = IoApiHttpTransport(
      client: io,
      requestTimeout: const Duration(milliseconds: 300),
    );
    final responses = _ResponseTasks();
    var shuttingDown = false;
    var requestCount = 0;
    var chunksSent = 0;
    final listener = server.listen((request) {
      requestCount++;
      responses.add(() async {
        try {
          request.response.bufferOutput = false;
          request.response.write('[');
          await request.response.flush();
          chunksSent++;
          // Every gap is below 300 ms, but a complete response takes 900 ms.
          for (var chunk = 0; chunk < 15; chunk++) {
            await Future<void>.delayed(const Duration(milliseconds: 60));
            if (shuttingDown) return;
            request.response.write(' ');
            await request.response.flush();
            chunksSent++;
          }
          request.response.write(']');
          await request.response.close();
        } on IOException {
          // The deadline deliberately closes the connection during this body.
        }
      }());
    });
    try {
      final watch = Stopwatch()..start();
      await expectLater(
        transport
            .send(
              ApiHttpRequest(
                method: 'GET',
                uri: Uri.parse('http://127.0.0.1:${server.port}/deadline'),
                headers: const {},
              ),
            )
            .timeout(_cleanupTimeout),
        throwsA(
          isA<ApiNetworkException>().having(
            (error) => error.code,
            'normalized deadline failure',
            'network_timeout',
          ),
        ),
      );
      watch.stop();
      expect(watch.elapsedMilliseconds, lessThan(800));
      expect(chunksSent, greaterThanOrEqualTo(2));
      expect(requestCount, 1);
    } finally {
      shuttingDown = true;
      transport.close();
      await _closeHttpServer(server, listener, responses);
    }
  });

  test('HTML intermediary failure preserves 503 without its body', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final io = HttpClient()..findProxy = (_) => 'DIRECT';
    final client = ApiClient(
      baseUri: Uri.parse('http://127.0.0.1:${server.port}/'),
      transport: IoApiHttpTransport(client: io),
    );
    final responses = _ResponseTasks();
    var requestCount = 0;
    final listener = server.listen((request) {
      requestCount++;
      responses.add(() async {
        request.response.statusCode = HttpStatus.serviceUnavailable;
        request.response.headers.contentType = ContentType.html;
        request.response.write('<html>$_privateFixtureText</html>');
        await request.response.close();
      }());
    });
    try {
      await expectLater(
        client.locations().timeout(_cleanupTimeout),
        throwsA(
          isA<ApiException>()
              .having((error) => error.statusCode, 'HTTP status', 503)
              .having((error) => error.code, 'safe fallback code', 'api_error')
              .having(
                (error) => error.toString(),
                'public failure excludes the intermediary body',
                allOf(
                  isNot(contains('<html>')),
                  isNot(contains(_privateFixtureText)),
                ),
              ),
        ),
      );
      expect(requestCount, 1);
    } finally {
      client.close();
      await _closeHttpServer(server, listener, responses);
    }
  });

  test('truncated socket response fails safely without HTTP replay', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final io = HttpClient()..findProxy = (_) => 'DIRECT';
    final client = ApiClient(
      baseUri: Uri.parse('http://127.0.0.1:${server.port}/'),
      transport: IoApiHttpTransport(client: io),
    );
    final sockets = <Socket>[];
    final subscriptions = <StreamSubscription<List<int>>>[];
    final responses = _ResponseTasks();
    var requestCount = 0;
    var truncatedResponsesSent = 0;
    final listener = server.listen((socket) {
      sockets.add(socket);
      final requestHeaders = StringBuffer();
      var replied = false;
      subscriptions.add(
        socket.listen(
          (chunk) {
            if (replied) return;
            requestHeaders.write(latin1.decode(chunk));
            if (!requestHeaders.toString().contains('\r\n\r\n')) return;
            replied = true;
            requestCount++;
            responses.add(() async {
              socket.write(
                'HTTP/1.1 200 OK\r\n'
                'Content-Type: application/json\r\n'
                'Content-Length: 256\r\n'
                'Connection: close\r\n\r\n'
                '{"private":"$_privateFixtureText',
              );
              await socket.flush();
              truncatedResponsesSent++;
              await socket.close();
            }());
          },
          onError: (Object _) {
            // Teardown may destroy the accepted socket after its output closes.
          },
        ),
      );
    });
    try {
      await expectLater(
        client.locations().timeout(_cleanupTimeout),
        throwsA(
          isA<ApiFailure>()
              .having(
                (error) => error.code,
                'normalized truncated response failure',
                anyOf('network_unavailable', 'invalid_api_response'),
              )
              .having(
                (error) => error.toString(),
                'public failure excludes body and transport exception',
                allOf(
                  isNot(contains(_privateFixtureText)),
                  isNot(contains('HttpException')),
                  isNot(contains('Content-Length')),
                ),
              ),
        ),
      );
      expect(truncatedResponsesSent, 1);
      expect(requestCount, 1);
    } finally {
      client.close();
      for (final socket in sockets) {
        socket.destroy();
      }
      await Future.wait<void>([
        server.close().then<void>((_) {}),
        listener.cancel(),
        for (final subscription in subscriptions) subscription.cancel(),
        ...responses.pending,
      ]).timeout(_cleanupTimeout);
      expect(responses.unexpectedErrors, isEmpty);
    }
  });
}

Future<void> _closeHttpServer(
  HttpServer server,
  StreamSubscription<HttpRequest> listener,
  _ResponseTasks responses,
) async {
  await Future.wait<void>([
    server.close(force: true).then<void>((_) {}),
    listener.cancel(),
    ...responses.pending,
  ]).timeout(_cleanupTimeout);
  expect(responses.unexpectedErrors, isEmpty);
}

class _ResponseTasks {
  final pending = <Future<void>>[];
  final unexpectedErrors = <Object>[];

  void add(Future<void> response) {
    // Observe each handler immediately, including errors during teardown.
    pending.add(
      response.then<void>(
        (_) {},
        onError: (Object error) {
          if (error is! IOException) unexpectedErrors.add(error);
        },
      ),
    );
  }
}
