// COLD-RESTORE-ONLINE-06GB, phase 0: a transport failure keeps the layer it
// reached (dns, connect, tls, http, or client for a defect) and the address
// family as a diagnostic suffix. Its code, localized text, and the absence of
// any host, address, port or message are unchanged.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/api_socket_open.dart';
import 'package:fuzevpn_android/core/hedged_http_open.dart';

import '../fixtures/api_transport/synthetic_tls_fixture.dart';

const _cleanupTimeout = Duration(seconds: 2);

class _Direct extends HttpOverrides {
  @override
  String findProxyFromEnvironment(Uri uri, Map<String, String>? environment) =>
      'DIRECT';
}

/// What a loopback peer does with each accepted connection, in order.
enum _Peer { serve, stall, closeAfterHello, closeAfterRequest }

class _LoopbackPeer {
  _LoopbackPeer._(this.server, this.plan, this.closeDelay) {
    _listener = server.listen(_accept);
  }

  final ServerSocket server;
  final _Peer Function(int index) plan;
  final Duration closeDelay;
  final sockets = <Socket>[];
  final subscriptions = <StreamSubscription<List<int>>>[];
  final handlers = <Future<void>>[];
  final failures = <Object>[];
  final helloReceived = Completer<void>();
  final stalledClosed = Completer<void>();
  late final StreamSubscription<Socket> _listener;
  int accepted = 0;
  int requests = 0;

  static Future<_LoopbackPeer> bind(
    _Peer Function(int index) plan, {
    Duration closeDelay = Duration.zero,
  }) async => _LoopbackPeer._(
    await ServerSocket.bind(InternetAddress.loopbackIPv4, 0),
    plan,
    closeDelay,
  );

  Uri get base => Uri.parse('https://127.0.0.1:${server.port}/');

  void _accept(Socket socket) {
    final mode = plan(accepted++);
    sockets.add(socket);
    if (mode == _Peer.serve || mode == _Peer.closeAfterRequest) {
      handlers.add(
        _serve(socket, close: mode == _Peer.closeAfterRequest).catchError((
          Object error,
        ) {
          if (error is! IOException) failures.add(error);
        }),
      );
      return;
    }
    subscriptions.add(
      socket.listen(
        (_) {
          if (!helloReceived.isCompleted) helloReceived.complete();
          if (mode == _Peer.closeAfterHello) {
            handlers.add(Future<void>.delayed(closeDelay, socket.destroy));
          }
        },
        onDone: () {
          if (mode == _Peer.stall && !stalledClosed.isCompleted) {
            stalledClosed.complete();
          }
        },
        onError: (Object _) {},
      ),
    );
  }

  Future<void> _serve(Socket socket, {required bool close}) async {
    final context = SecurityContext()
      ..useCertificateChainBytes(utf8.encode(syntheticCertificatePem))
      ..usePrivateKeyBytes(utf8.encode(syntheticPrivateKeyPem));
    final secure = await SecureSocket.secureServer(socket, context);
    sockets.add(secure);
    var headers = '';
    subscriptions.add(
      secure.listen((data) {
        headers += latin1.decode(data);
        if (!headers.contains('\r\n\r\n')) return;
        headers = '';
        requests++;
        if (close) {
          secure.destroy();
          return;
        }
        secure.write(
          'HTTP/1.1 200 OK\r\nContent-Length: 2\r\n'
          'Connection: close\r\n\r\nok',
        );
      }, onError: (Object _) {}),
    );
  }

  Future<void> close() async {
    for (final socket in sockets) {
      socket.destroy();
    }
    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
    await _listener.cancel();
    await server.close();
    await Future.wait(handlers).timeout(_cleanupTimeout);
    expect(failures, isEmpty);
  }
}

class _DefectTransport extends ApiHttpTransport {
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async =>
      throw StateError('synthetic client defect token-secret');
}

Future<Object?> _failureOf(Future<Object?> Function() action) async {
  try {
    await action();
  } catch (error) {
    return error;
  }
  return null;
}

String? _diagnostic(Object? error) => error is ApiFailure
    ? ApiErrorMessages.fromFailure(error).diagnosticCode
    : null;

Matcher _unavailable() => isA<ApiNetworkException>()
    .having((e) => e.code, 'code', 'network_unavailable')
    .having((e) => e.statusCode, 'status', isNull);

const _lookupFailure = SocketException(
  "Failed host lookup: 'api.example.invalid'",
  osError: OSError('No address associated with hostname', 7),
);

Future<Object?> _injectedFailure(
  Future<ConnectionTask<Socket>> Function(Uri, String?, int?) factory, {
  HedgedHttpOpen opener = const HedgedHttpOpen(),
}) async {
  final io = HttpClient()
    ..findProxy = ((_) => 'DIRECT')
    ..connectionFactory = factory;
  final api = ApiClient(
    baseUri: Uri.parse('https://api.example.invalid/'),
    transport: IoApiHttpTransport(
      client: io,
      opener: opener,
      requestTimeout: const Duration(seconds: 2),
    ),
  );
  try {
    return await _failureOf(() => api.me('token-secret'));
  } finally {
    api.close();
  }
}

void main() {
  setUpAll(() {
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      utf8.encode(syntheticCertificatePem),
    );
  });

  group('owned transport', () {
    test(
      'a peer closing after the ClientHello reports tls over IPv4',
      () async {
        final peer = await _LoopbackPeer.bind(
          (_) => _Peer.closeAfterHello,
          closeDelay: const Duration(milliseconds: 300),
        );
        final api = ApiClient(
          baseUri: peer.base,
          transport: IoApiHttpTransport(),
        );
        try {
          final watch = Stopwatch()..start();
          final error = await HttpOverrides.runWithHttpOverrides(
            () => _failureOf(() => api.me('token-secret')),
            _Direct(),
          );
          // A delayed failure is still a failure, not a timeout.
          expect(error, _unavailable());
          expect(watch.elapsed, greaterThan(const Duration(milliseconds: 250)));
          expect(peer.helloReceived.isCompleted, isTrue);
          expect(
            _diagnostic(error),
            'API-NETWORK · network_unavailable/tls/ipv4',
          );
          final message = ApiErrorMessages.fromFailure(error! as ApiFailure);
          expect(message.arguments['code'], 'network_unavailable');
          expect(message.machineCode, 'network_unavailable');
          for (final private in ['127.0.0.1', '${peer.server.port}', 'token']) {
            expect(error.toString(), isNot(contains(private)));
            expect(message.diagnosticCode, isNot(contains(private)));
          }
        } finally {
          api.close();
          await peer.close();
        }
      },
    );

    test('a refused connection reports connect with its family', () async {
      final closed = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final port = closed.port;
      await closed.close();
      final api = ApiClient(
        baseUri: Uri.parse('https://127.0.0.1:$port/'),
        transport: IoApiHttpTransport(),
      );
      try {
        final error = await HttpOverrides.runWithHttpOverrides(
          () => _failureOf(() => api.me('token-secret')),
          _Direct(),
        );
        expect(error, _unavailable());
        expect(
          _diagnostic(error),
          'API-NETWORK · network_unavailable/connect/ipv4',
        );
        expect(error.toString(), isNot(contains('$port')));
      } finally {
        api.close();
      }
    });

    test(
      'a failure after a TLS opening reports http with its family',
      () async {
        final peer = await _LoopbackPeer.bind((_) => _Peer.closeAfterRequest);
        final api = ApiClient(
          baseUri: peer.base,
          transport: IoApiHttpTransport(),
        );
        try {
          final error = await HttpOverrides.runWithHttpOverrides(
            () => _failureOf(() => api.me('token-secret')),
            _Direct(),
          );
          expect(error, _unavailable());
          expect(peer.requests, 1);
          expect(
            _diagnostic(error),
            'API-NETWORK · network_unavailable/http/ipv4',
          );
        } finally {
          api.close();
          await peer.close();
        }
      },
    );

    test(
      'cancelling an opening inside the TLS handshake completes it promptly',
      () async {
        final peer = await _LoopbackPeer.bind((_) => _Peer.stall);
        final attempt = ApiSocketOpenAttempt();
        try {
          final task = await attempt.run(
            () => openApiSocketWithProxyConfiguration(peer.base, 'DIRECT'),
          );
          await peer.helloReceived.future.timeout(_cleanupTimeout);
          final watch = Stopwatch()..start();
          attempt.cancel();
          await expectLater(
            task.socket.timeout(const Duration(seconds: 1)),
            throwsA(isA<SocketException>()),
          );
          expect(watch.elapsed, lessThan(const Duration(seconds: 1)));
          await peer.stalledClosed.future.timeout(_cleanupTimeout);
        } finally {
          await peer.close();
        }
      },
    );

    test(
      'a hedged opening cancelled in TLS leaves a concurrent request intact',
      () async {
        final peer = await _LoopbackPeer.bind(
          (index) => index == 0 ? _Peer.stall : _Peer.serve,
        );
        final transport = IoApiHttpTransport(
          requestTimeout: const Duration(seconds: 5),
          opener: const HedgedHttpOpen(hedgeDelay: Duration(milliseconds: 200)),
        );
        ApiHttpRequest request(String path) => ApiHttpRequest(
          method: 'GET',
          uri: peer.base.resolve(path),
          headers: const {},
        );
        try {
          await HttpOverrides.runWithHttpOverrides(() async {
            final responses = await Future.wait([
              transport.send(request('v1/me')),
              transport.send(request('v1/locations')),
            ]);
            expect(responses.map((response) => response.body), ['ok', 'ok']);
          }, _Direct());
          await peer.stalledClosed.future.timeout(_cleanupTimeout);
          // A slow handshake may hedge the healthy request too.
          expect(peer.accepted, greaterThanOrEqualTo(3));
          expect(peer.requests, 2);
        } finally {
          transport.close();
          await peer.close();
        }
      },
    );
  });

  group('injected client', () {
    test('a host lookup failure reports dns, not a timeout', () async {
      final watch = Stopwatch()..start();
      final error = await _injectedFailure((_, _, _) async {
        await Future<void>.delayed(const Duration(milliseconds: 150));
        throw _lookupFailure;
      });
      expect(error, _unavailable());
      expect(watch.elapsed, greaterThan(const Duration(milliseconds: 100)));
      expect(_diagnostic(error), 'API-NETWORK · network_unavailable/dns');
      expect(error.toString(), isNot(contains('api.example.invalid')));
      expect(error.toString(), isNot(contains('No address')));
    });

    test('a refused address reports connect with its family', () async {
      final error = await _injectedFailure(
        (_, _, _) async => throw SocketException(
          'Connection refused',
          osError: const OSError('Connection refused', 111),
          address: InternetAddress('::1'),
          port: 443,
        ),
      );
      expect(error, _unavailable());
      expect(
        _diagnostic(error),
        'API-NETWORK · network_unavailable/connect/ipv6',
      );
    });

    test('an unclassifiable socket failure keeps no stage', () async {
      final error = await _injectedFailure(
        (_, _, _) async => throw const SocketException('synthetic failure'),
      );
      expect(error, _unavailable());
      expect(_diagnostic(error), 'API-NETWORK · network_unavailable');
    });

    test('a Dart error is a client defect, not a network failure', () async {
      final error = await _injectedFailure(
        (_, _, _) async => throw StateError('synthetic defect'),
      );
      expect(error, _unavailable());
      expect(_diagnostic(error), 'API-NETWORK · network_unavailable/client');
      expect(error.toString(), isNot(contains('synthetic defect')));
    });

    test(
      'when both hedged openings fail, the furthest layer is reported',
      () async {
        final alternateFailed = Completer<void>();
        var calls = 0;
        final error = await _injectedFailure(
          (_, _, _) async {
            if (calls++ == 0) {
              // The primary fails last, at name resolution.
              await alternateFailed.future;
              throw _lookupFailure;
            }
            Timer(const Duration(milliseconds: 20), alternateFailed.complete);
            throw const HandshakeException('synthetic handshake failure');
          },
          opener: const HedgedHttpOpen(hedgeDelay: Duration(milliseconds: 20)),
        );
        expect(calls, 2);
        expect(error, _unavailable());
        expect(_diagnostic(error), 'API-NETWORK · network_unavailable/tls');
      },
    );
  });

  group('API client', () {
    test('a Dart error from a transport is a client defect', () async {
      final api = ApiClient(
        baseUri: Uri.parse('https://api.example.invalid/'),
        transport: _DefectTransport(),
      );
      final error = await _failureOf(() => api.me('token-secret'));
      expect(error, _unavailable());
      expect(_diagnostic(error), 'API-NETWORK · network_unavailable/client');
      expect(error.toString(), isNot(contains('token-secret')));
    });

    test('debug output names the failing layer without identifiers', () async {
      // Printed synchronously like the FuzeVpnTiming lines, never through the
      // throttled debugPrint, so both keep their relative order in logcat.
      final lines = <String>[];
      final throttled = <String>[];
      final previous = debugPrint;
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) throttled.add(message);
      };
      addTearDown(() => debugPrint = previous);
      final api = ApiClient(
        baseUri: Uri.parse('https://api.example.invalid/'),
        transport: _DefectTransport(),
      );
      await runZoned(
        () => _failureOf(
          () => api.deviceProfiles(
            token: 'token-secret',
            deviceId: 'device-secret-42',
          ),
        ),
        zoneSpecification: ZoneSpecification(
          print: (_, _, _, line) => lines.add(line),
        ),
      );
      expect(throttled, isNot(contains(startsWith('FuzeVpnApi '))));
      final records = lines.where((line) => line.startsWith('FuzeVpnApi '));
      expect(records, hasLength(1));
      final record =
          jsonDecode(records.single.substring('FuzeVpnApi '.length))
              as Map<String, dynamic>;
      expect(record['method'], 'GET');
      expect(record['path'], 'v1/devices/:id/profiles');
      expect(record['code'], 'network_unavailable');
      expect(record['stage'], 'client');
      expect(record['elapsed_ms'], isA<int>());
      for (final private in [
        'device-secret',
        'token-secret',
        'api.example.invalid',
        'synthetic client defect',
      ]) {
        expect([...lines, ...throttled].join('\n'), isNot(contains(private)));
      }
    });
  });
}
