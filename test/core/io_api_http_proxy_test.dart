import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/hedged_http_open.dart';

import '../fixtures/api_transport/synthetic_tls_fixture.dart';

class _EnvironmentProxy extends HttpOverrides {
  _EnvironmentProxy(this.port, {this.noProxy = '', this.credentials = false});
  final int port;
  final String noProxy;
  final bool credentials;

  @override
  String findProxyFromEnvironment(
    Uri uri,
    Map<String, String>? environment,
  ) => super.findProxyFromEnvironment(uri, {
    'http_proxy':
        '${credentials ? 'synthetic-user:synthetic-password@' : ''}127.0.0.1:$port',
    'https_proxy':
        '${credentials ? 'synthetic-user:synthetic-password@' : ''}127.0.0.1:$port',
    'no_proxy': noProxy,
  });
}

enum _ProxyMode { normal, connectStall, tlsStall, reject, firstTlsStall }

/// How the CONNECT response reaches the client: one TCP segment, the first
/// line then the rest 50 ms later, one byte every 3 ms, or each header block
/// (interim or final response) in its own segment 40 ms apart.
enum _Delivery { whole, split, bytewise, blocks }

/// Splits a CONNECT response after each empty line that ends a header block.
List<String> _headerBlocks(String response) {
  final blocks = <String>[];
  var start = 0;
  for (final end in RegExp(r'\r?\n\r?\n').allMatches(response)) {
    blocks.add(response.substring(start, end.end));
    start = end.end;
  }
  if (start < response.length) blocks.add(response.substring(start));
  return blocks;
}

/// Four interim responses then a final 200, [total] bytes in all, every block
/// well below 16 KiB. The padding lies in the interim responses, or in the
/// final 200 reason phrase when [padFinal] is set. Without [finalResponse],
/// the four interim responses alone make up the [total] bytes.
String _cumulativeConnectResponse(
  int total, {
  String eol = '\r\n',
  bool padFinal = false,
  bool finalResponse = true,
}) {
  String interim(int size) {
    final head = 'HTTP/1.1 100 Continue${eol}X-Pad: ';
    return '$head${'x' * (size - head.length - 2 * eol.length)}$eol$eol';
  }

  final String response;
  if (padFinal) {
    const interimSize = 4000;
    const head = 'HTTP/1.1 200 ';
    final reason =
        'x' * (total - 4 * interimSize - head.length - 2 * eol.length);
    response =
        '${List.generate(4, (_) => interim(interimSize)).join()}'
        '$head$reason$eol$eol';
  } else {
    final last = finalResponse ? 'HTTP/1.1 200 OK$eol$eol' : '';
    final share = (total - last.length) ~/ 4;
    response =
        '${List.generate(3, (_) => interim(share)).join()}'
        '${interim(total - last.length - 3 * share)}$last';
  }
  expect(response.length, total);
  final blocks = _headerBlocks(response);
  expect(blocks, hasLength(finalResponse ? 5 : 4));
  expect(blocks.map((block) => block.length), everyElement(lessThan(5000)));
  return response;
}

class _ConfiguredProxy extends HttpOverrides {
  _ConfiguredProxy(this.configuration);
  final String configuration;
  @override
  String findProxyFromEnvironment(Uri uri, Map<String, String>? environment) =>
      configuration;
}

class _Proxy {
  _Proxy(
    this.server,
    this.mode, [
    this.connectResponse,
    this.delivery = _Delivery.whole,
  ]) {
    _listener = server.listen(_accept);
  }
  final ServerSocket server;
  final _ProxyMode mode;
  final String? connectResponse;
  final _Delivery delivery;
  final sockets = <Socket>[];
  final subscriptions = <StreamSubscription<List<int>>>[];
  final handlers = <Future<void>>[];
  final connectLines = <String>[];
  final requestLines = <String>[];
  final connectHeaders = <String>[];
  final requestHeaders = <String>[];
  final serverNames = <String?>[];
  final failures = <Object>[];
  late final StreamSubscription<Socket> _listener;
  int accepted = 0;
  int closed = 0;

  /// Bytes the client sent through the tunnel after the CONNECT request,
  /// i.e. the start of its TLS handshake.
  int tunnelBytes = 0;

  static Future<_Proxy> bind([
    _ProxyMode mode = _ProxyMode.normal,
    String? response,
    _Delivery delivery = _Delivery.whole,
  ]) async => _Proxy(
    await ServerSocket.bind(InternetAddress.loopbackIPv4, 0),
    mode,
    response,
    delivery,
  );

  Future<void> _deliver(Socket socket, String response) async {
    final bytes = utf8.encode(response);
    if (delivery == _Delivery.whole) {
      socket.add(bytes);
    } else {
      socket.setOption(SocketOption.tcpNoDelay, true);
      final cut = response.indexOf('\n') + 1;
      final segments = switch (delivery) {
        _Delivery.split => [bytes.sublist(0, cut), bytes.sublist(cut)],
        _Delivery.bytewise => [
          for (final byte in bytes) [byte],
        ],
        _Delivery.whole || _Delivery.blocks => [
          for (final block in _headerBlocks(response)) utf8.encode(block),
        ],
      };
      for (final segment in segments) {
        socket.add(segment);
        await socket.flush();
        await Future<void>.delayed(
          Duration(
            milliseconds: switch (delivery) {
              _Delivery.split => 50,
              _Delivery.blocks => 40,
              _ => 3,
            },
          ),
        );
      }
    }
    await socket.flush();
  }

  void _accept(Socket socket) {
    accepted++;
    final effectiveMode = mode == _ProxyMode.firstTlsStall
        ? (accepted == 1 ? _ProxyMode.tlsStall : _ProxyMode.normal)
        : mode;
    sockets.add(socket);
    var headers = '';
    var tunnelling = false;
    Completer<List<int>>? hello;
    final helloBytes = <int>[];
    late StreamSubscription<List<int>> input;
    input = socket.listen(
      (data) {
        if (tunnelling) {
          tunnelBytes += data.length;
          final pending = hello;
          if (pending != null && !pending.isCompleted) {
            helloBytes.addAll(data);
            if (helloBytes.length >= 5 &&
                helloBytes.length >= 5 + (helloBytes[3] << 8 | helloBytes[4])) {
              input.pause();
              serverNames.add(_serverName(helloBytes));
              pending.complete(helloBytes);
            }
          }
          return;
        }
        headers += latin1.decode(data);
        while (headers.contains('\r\n\r\n')) {
          final end = headers.indexOf('\r\n\r\n') + 4;
          final block = headers.substring(0, end);
          final first = block.split('\r\n').first;
          headers = headers.substring(end);
          if (first.startsWith('CONNECT ')) {
            tunnelling = true;
            connectLines.add(first);
            connectHeaders.add(block);
            if (effectiveMode == _ProxyMode.connectStall) return;
            if (effectiveMode == _ProxyMode.reject) {
              socket.write(
                'HTTP/1.1 502 Refused\r\nContent-Length: 0\r\nConnection: close\r\n\r\n',
              );
              unawaited(socket.flush().then((_) => socket.close()));
              return;
            }
            final delivered = _deliver(
              socket,
              connectResponse ?? 'HTTP/1.1 200 Connection Established\r\n\r\n',
            );
            if (effectiveMode == _ProxyMode.tlsStall) {
              handlers.add(delivered.catchError((Object _) {}));
              return;
            }
            hello = Completer<List<int>>();
            handlers.add(
              _secure(socket, delivered, hello!.future).catchError((
                Object error,
              ) {
                if (error is! IOException) failures.add(error);
              }),
            );
            return;
          }
          requestLines.add(first);
          requestHeaders.add(block);
          socket.write('HTTP/1.1 200 OK\r\nContent-Length: 7\r\n\r\nproxied');
        }
      },
      onDone: () {
        closed++;
        if (hello != null && !hello!.isCompleted) {
          hello!.completeError(const SocketException('fixture peer closed'));
        }
      },
      onError: (Object error) {
        if (hello != null && !hello!.isCompleted) hello!.completeError(error);
      },
    );
    subscriptions.add(input);
  }

  Future<void> _secure(
    Socket socket,
    Future<void> delivered,
    Future<List<int>> hello,
  ) async {
    await delivered;
    final buffered = await hello;
    final context = SecurityContext()
      ..useCertificateChainBytes(utf8.encode(syntheticCertificatePem))
      ..usePrivateKeyBytes(utf8.encode(syntheticPrivateKeyPem));
    final secure = await SecureSocket.secureServer(
      socket,
      context,
      bufferedData: buffered,
    );
    sockets.add(secure);
    var headers = '';
    subscriptions.add(
      secure.listen(
        (data) {
          headers += latin1.decode(data);
          while (headers.contains('\r\n\r\n')) {
            final end = headers.indexOf('\r\n\r\n') + 4;
            requestLines.add(headers.substring(0, end).split('\r\n').first);
            headers = headers.substring(end);
            secure.write('HTTP/1.1 200 OK\r\nContent-Length: 7\r\n\r\nproxied');
          }
        },
        onDone: () => closed++,
        onError: (Object _) {},
      ),
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
    await Future.wait(handlers);
    expect(failures, isEmpty);
  }
}

String? _serverName(List<int> hello) {
  int short(int at) => hello[at] << 8 | hello[at + 1];
  var at = 5 + 4 + 2 + 32;
  at += 1 + hello[at]; // Session ID.
  at += 2 + short(at); // Cipher suites.
  at += 1 + hello[at]; // Compression methods.
  final end = at + 2 + short(at);
  at += 2;
  while (at + 4 <= end) {
    final kind = short(at);
    final length = short(at + 2);
    at += 4;
    if (kind == 0 && length >= 5 && hello[at + 2] == 0) {
      final size = short(at + 3);
      return ascii.decode(hello.sublist(at + 5, at + 5 + size));
    }
    at += length;
  }
  return null;
}

ApiHttpRequest _request(String scheme, {String host = '127.0.0.1'}) =>
    ApiHttpRequest(
      method: 'GET',
      uri: Uri(
        scheme: scheme,
        host: scheme == 'http' ? 'synthetic.invalid' : host,
        port: scheme == 'http' ? null : 1,
        path: '/resource',
      ),
      headers: const {},
    );

void main() {
  // Every HTTPS case of this file trusts the synthetic certificate before it
  // runs, whatever the order, filter or shard (A04-transport-02). Refusal of
  // an untrusted certificate is proven in its own isolate by
  // io_api_http_proxy_untrusted_test.dart: the trust cannot be withdrawn.
  setUpAll(() {
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      utf8.encode(syntheticCertificatePem),
    );
  });

  test(
    'proxy environment keeps SDK HTTP forwarding and connection pooling',
    () async {
      final proxy = await _Proxy.bind();
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport();
          try {
            for (var i = 0; i < 2; i++) {
              expect((await transport.send(_request('http'))).body, 'proxied');
              await Future<void>.delayed(Duration.zero);
            }
            expect(proxy.accepted, 1);
            expect(proxy.requestLines, [
              'GET http://synthetic.invalid/resource HTTP/1.1',
              'GET http://synthetic.invalid/resource HTTP/1.1',
            ]);
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    },
  );

  test(
    'proxy CONNECT keeps certificate verification and the destination host',
    () async {
      final proxy = await _Proxy.bind();
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 3),
          );
          try {
            for (var i = 0; i < 2; i++) {
              expect((await transport.send(_request('https'))).body, 'proxied');
              await Future<void>.delayed(Duration.zero);
            }
            // Both trusted requests reuse one established TLS tunnel owned
            // by the transport.
            expect(proxy.connectLines, hasLength(1));
            expect(
              proxy.connectLines.every(
                (line) => line == 'CONNECT 127.0.0.1:1 HTTP/1.1',
              ),
              isTrue,
            );
            expect(proxy.requestLines, [
              'GET /resource HTTP/1.1',
              'GET /resource HTTP/1.1',
            ]);
            await expectLater(
              transport.send(_request('https', host: '127.0.0.2')),
              throwsA(isA<ApiNetworkException>()),
            );
            expect(proxy.requestLines, hasLength(2));
            expect(proxy.connectLines.last, 'CONNECT 127.0.0.2:1 HTTP/1.1');
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    },
  );

  test('no_proxy still selects the direct route', () async {
    final proxy = await _Proxy.bind();
    final direct = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final listener = direct.listen((request) async {
      request.response.write('direct');
      await request.response.close();
    });
    try {
      await HttpOverrides.runWithHttpOverrides(() async {
        final transport = IoApiHttpTransport();
        try {
          expect(
            (await transport.send(
              ApiHttpRequest(
                method: 'GET',
                uri: Uri.parse('http://127.0.0.1:${direct.port}/'),
                headers: const {},
              ),
            )).body,
            'direct',
          );
          expect(proxy.accepted, 0);
        } finally {
          transport.close();
        }
      }, _EnvironmentProxy(proxy.server.port, noProxy: '127.0.0.1'));
    } finally {
      await direct.close(force: true);
      await listener.cancel();
      await proxy.close();
    }
  });

  for (final scheme in ['http', 'https']) {
    test('proxy $scheme keeps SDK synthetic Basic credentials', () async {
      final proxy = await _Proxy.bind();
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport();
          try {
            expect((await transport.send(_request(scheme))).body, 'proxied');
            final headers = scheme == 'https'
                ? proxy.connectHeaders.single
                : proxy.requestHeaders.single;
            expect(
              headers.toLowerCase(),
              contains(
                'proxy-authorization: basic '
                '${base64Encode(utf8.encode('synthetic-user:synthetic-password')).toLowerCase()}',
              ),
            );
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port, credentials: true));
      } finally {
        await proxy.close();
      }
    });
  }

  for (final response in [
    'HTTP/1.1 100 Continue\r\n\r\nHTTP/1.1 103 Early Hints\r\nLink: </x>\r\n\r\nHTTP/1.1 200 OK\r\n\r\n',
    'HTTP/1.1 200 Connexion établie\t\r\nContent-Length: 19\r\nTransfer-Encoding: chunked\r\n\r\n',
    '${List.filled(4, 'HTTP/1.1 100 Continue\r\n\r\n').join()}HTTP/1.1 200 OK\r\n\r\n',
  ]) {
    test(
      'CONNECT interim and successful tunnel headers keep TLS framing ${response.length}',
      () async {
        final proxy = await _Proxy.bind(_ProxyMode.normal, response);
        try {
          await HttpOverrides.runWithHttpOverrides(() async {
            final transport = IoApiHttpTransport();
            try {
              expect((await transport.send(_request('https'))).body, 'proxied');
              expect(proxy.requestLines, hasLength(1));
            } finally {
              transport.close();
            }
          }, _EnvironmentProxy(proxy.server.port));
        } finally {
          await proxy.close();
        }
      },
    );
  }

  final exactHeader =
      'HTTP/1.1 200 OK\r\nX-Padding: '
      '${'x' * (16 * 1024 - 'HTTP/1.1 200 OK\r\nX-Padding: \r\n\r\n'.length)}\r\n\r\n';
  test('CONNECT accepts exactly 16KiB total response headers', () async {
    expect(exactHeader.length, 16 * 1024);
    final proxy = await _Proxy.bind(_ProxyMode.normal, exactHeader);
    try {
      await HttpOverrides.runWithHttpOverrides(() async {
        final transport = IoApiHttpTransport();
        try {
          expect((await transport.send(_request('https'))).body, 'proxied');
        } finally {
          transport.close();
        }
      }, _EnvironmentProxy(proxy.server.port));
    } finally {
      await proxy.close();
    }
  });

  // H-B-02-PROXY-01: a response that needs several TCP reads must not trip
  // the SDK's debug-mode assertion on an empty RawSocket.read().
  final fragmented = [
    'HTTP/1.1 200 Connection Established\r\n\r\n',
    'HTTP/1.1 100 Continue\r\n\r\nHTTP/1.1 200 Connection Established\r\nProxy-Agent: x\r\n\r\n',
    'HTTP/1.1 200 Connection Established\n\n',
  ];
  for (final delivery in [_Delivery.split, _Delivery.bytewise]) {
    for (var index = 0; index < fragmented.length; index++) {
      test(
        'CONNECT response delivered ${delivery.name} keeps the tunnel $index',
        () async {
          final proxy = await _Proxy.bind(
            _ProxyMode.normal,
            fragmented[index],
            delivery,
          );
          try {
            await HttpOverrides.runWithHttpOverrides(() async {
              final transport = IoApiHttpTransport(
                requestTimeout: const Duration(seconds: 8),
              );
              try {
                expect(
                  (await transport.send(_request('https'))).body,
                  'proxied',
                );
                expect(proxy.connectLines, hasLength(1));
                expect(proxy.requestLines, ['GET /resource HTTP/1.1']);
              } finally {
                transport.close();
              }
            }, _EnvironmentProxy(proxy.server.port));
          } finally {
            await proxy.close();
          }
        },
      );
    }
  }

  // H-B-02-PROXY-02: like the SDK parser (RFC 9112 §2.2 and §5.2), a bare LF
  // ends a line and an obs-fold continues the previous field value.
  final exactLfHeader =
      'HTTP/1.1 200 OK\nX-Padding: '
      '${'x' * (16 * 1024 - 'HTTP/1.1 200 OK\nX-Padding: \n\n'.length)}\n\n';
  final tolerated = [
    'HTTP/1.1 200 Connection established\n\n',
    'HTTP/1.1 200 Connection established\nProxy-Agent: synthetic\n\n',
    'HTTP/1.1 200 OK\r\nProxy-Agent: synthetic\n\r\n',
    'HTTP/1.1 100 Continue\n\nHTTP/1.1 200 OK\r\n\r\n',
    'HTTP/1.1 200 Connection established\r\nProxy-Agent: synthetic\r\n relay\r\n\r\n',
    'HTTP/1.1 200 OK\r\nVia: 1.1 first\r\n\tsecond\r\n \r\nX-Next: y\r\n\r\n',
    'HTTP/1.1 200 OK\nVia: 1.1 first\n  second\n\n',
    exactLfHeader,
  ];
  for (var index = 0; index < tolerated.length; index++) {
    test('CONNECT accepts SDK-tolerated framing $index', () async {
      expect(exactLfHeader.length, 16 * 1024);
      final proxy = await _Proxy.bind(_ProxyMode.normal, tolerated[index]);
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 3),
          );
          final watch = Stopwatch()..start();
          try {
            expect((await transport.send(_request('https'))).body, 'proxied');
            expect(watch.elapsed, lessThan(const Duration(seconds: 2)));
            expect(proxy.requestLines, ['GET /resource HTTP/1.1']);
            expect(proxy.tunnelBytes, greaterThan(0));
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    });
  }

  final malformed = [
    'HTTP/1.1 200 OK\r\nInvalid header\r\n\r\n',
    'HTTP/1.1 200 OK\r\n folded: x\r\n\r\n',
    'HTTP/1.1 200 OK\r\nX-Header: bad\x00value\r\n\r\n',
    'HTTP/1.1 200 OK\r\n\r\nunexpected',
    'HTTP/1.1 101 Switching Protocols\r\n\r\n',
    '${List.filled(5, 'HTTP/1.1 100 Continue\r\n\r\n').join()}HTTP/1.1 200 OK\r\n\r\n',
    exactHeader.replaceFirst('X-Padding: ', 'X-Padding: x'),
    // Tolerance for LF and obs-fold keeps every other bound.
    'HTTP/1.1 200 OK\n folded: x\n\n',
    'HTTP/1.1 200 OK\r\nX-Header: ok\r\n bad\x01fold\r\n\r\n',
    'HTTP/1.1 200 OK\rX-Header: bare carriage return\r\n\r\n',
    'HTTP/1.1 200 OK\r\nX-Header: bare\rcarriage return\r\n\r\n',
    'HTTP/1.1 200 OK\n\nunexpected',
    '${List.filled(5, 'HTTP/1.1 100 Continue\n\n').join()}HTTP/1.1 200 OK\n\n',
    exactLfHeader.replaceFirst('X-Padding: ', 'X-Padding: x'),
    '\nHTTP/1.1 200 OK\n\n',
    // Same bounds with the other tolerated framings.
    'HTTP/1.1 200 OK\nX: a\n\tb\x00c\n\n',
    'HTTP/1.1 200 OK\nX: a\r\n \x7f\n\n',
    'HTTP/1.1 200 OK\r\r\n\r\n',
    '${List.filled(5, 'HTTP/1.1 103 Early Hints\nLink: </a>\n\n').join()}HTTP/1.1 200 OK\n\n',
    'HTTP/1.1 200 OK\n\r\nX',
    'HTTP/1.1 407 Proxy Authentication Required\nProxy-Authenticate: Basic\n\n',
    'HTTP/1.1 101 Switching Protocols\n\n',
    'HTTP/1.1 200 OK\nX-Bad Name: v\n\n',
  ];
  for (var index = 0; index < malformed.length; index++) {
    test(
      'CONNECT malformed or excessive response $index closes before TLS',
      () async {
        final proxy = await _Proxy.bind(_ProxyMode.tlsStall, malformed[index]);
        try {
          await HttpOverrides.runWithHttpOverrides(() async {
            // An accepted response would start TLS through the tunnel, then
            // stall until the deadline. The refusal must come from the
            // CONNECT parser itself: immediate, before any TLS byte.
            final transport = IoApiHttpTransport(
              requestTimeout: const Duration(seconds: 3),
            );
            final watch = Stopwatch()..start();
            try {
              await expectLater(
                transport.send(_request('https')),
                throwsA(
                  isA<ApiNetworkException>().having(
                    (e) => e.code,
                    'code',
                    'network_unavailable',
                  ),
                ),
              );
              expect(
                watch.elapsed,
                lessThan(const Duration(milliseconds: 1500)),
              );
              await Future<void>.delayed(const Duration(milliseconds: 20));
              expect(proxy.tunnelBytes, 0);
              expect(proxy.closed, proxy.accepted);
              expect(proxy.requestLines, isEmpty);
            } finally {
              transport.close();
            }
          }, _EnvironmentProxy(proxy.server.port));
        } finally {
          await proxy.close();
        }
      },
    );
  }

  // H-B-02-PROXY-02 (review of 29/10): the 16 KiB bound covers all CONNECT
  // response blocks together, interim responses included, not each block on
  // its own. Every block arrives in its own TCP segment, so no single read
  // ever reaches the bound.
  for (final eol in ['\r\n', '\n']) {
    final framing = eol == '\n' ? 'LF' : 'CRLF';

    Future<void> closesBeforeTls(String response) async {
      final proxy = await _Proxy.bind(
        _ProxyMode.tlsStall,
        response,
        _Delivery.blocks,
      );
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 3),
          );
          final watch = Stopwatch()..start();
          try {
            await expectLater(
              transport.send(_request('https')),
              throwsA(
                isA<ApiNetworkException>().having(
                  (e) => e.code,
                  'code',
                  'network_unavailable',
                ),
              ),
            );
            expect(watch.elapsed, lessThan(const Duration(milliseconds: 1500)));
            await Future<void>.delayed(const Duration(milliseconds: 20));
            expect(proxy.tunnelBytes, 0);
            expect(proxy.closed, proxy.accepted);
            expect(proxy.requestLines, isEmpty);
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    }

    for (final padFinal in [false, true]) {
      final variant =
          '$framing, ${padFinal ? 'padded final 200' : 'padded interims'}';
      test(
        'CONNECT interim responses totalling 16KiB keep the tunnel ($variant)',
        () async {
          final proxy = await _Proxy.bind(
            _ProxyMode.normal,
            _cumulativeConnectResponse(16 * 1024, eol: eol, padFinal: padFinal),
            _Delivery.blocks,
          );
          try {
            await HttpOverrides.runWithHttpOverrides(() async {
              final transport = IoApiHttpTransport(
                requestTimeout: const Duration(seconds: 8),
              );
              try {
                expect(
                  (await transport.send(_request('https'))).body,
                  'proxied',
                );
                expect(proxy.connectLines, hasLength(1));
                expect(proxy.requestLines, ['GET /resource HTTP/1.1']);
                expect(proxy.tunnelBytes, greaterThan(0));
              } finally {
                transport.close();
              }
            }, _EnvironmentProxy(proxy.server.port));
          } finally {
            await proxy.close();
          }
        },
      );

      test(
        'CONNECT interim responses totalling 16KiB + 1 close before TLS '
        '($variant)',
        () => closesBeforeTls(
          _cumulativeConnectResponse(
            16 * 1024 + 1,
            eol: eol,
            padFinal: padFinal,
          ),
        ),
      );
    }

    // The four interim responses alone exceed the bound: the response is
    // refused before any final response arrives. A parser bounding each
    // block on its own would wait for that final response until the
    // deadline (network_timeout) instead.
    test(
      'CONNECT interim responses alone totalling 16KiB + 1 close before TLS '
      '($framing)',
      () => closesBeforeTls(
        _cumulativeConnectResponse(
          16 * 1024 + 1,
          eol: eol,
          finalResponse: false,
        ),
      ),
    );
  }

  test('CONNECT authority brackets an IPv6 destination', () async {
    final proxy = await _Proxy.bind();
    try {
      await HttpOverrides.runWithHttpOverrides(() async {
        final transport = IoApiHttpTransport();
        try {
          await expectLater(
            transport.send(_request('https', host: '::1')),
            throwsA(isA<ApiNetworkException>()),
          ); // Fixture has no IPv6 SAN.
          expect(proxy.connectLines.single, 'CONNECT [::1]:1 HTTP/1.1');
        } finally {
          transport.close();
        }
      }, _EnvironmentProxy(proxy.server.port));
    } finally {
      await proxy.close();
    }
  });

  test(
    'CONNECT TLS sends destination DNS SNI and verifies its certificate',
    () async {
      final proxy = await _Proxy.bind();
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport();
          try {
            expect(
              (await transport.send(_request('https', host: 'localhost'))).body,
              'proxied',
            );
            expect(proxy.serverNames.single, 'localhost');
            expect(proxy.connectLines.single, 'CONNECT localhost:1 HTTP/1.1');
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    },
  );

  test(
    'an invalid proxy port falls back only to the next explicitly listed proxy',
    () async {
      final proxy = await _Proxy.bind();
      try {
        await HttpOverrides.runWithHttpOverrides(
          () async {
            final transport = IoApiHttpTransport();
            try {
              expect((await transport.send(_request('https'))).body, 'proxied');
              expect(proxy.connectLines, hasLength(1));
            } finally {
              transport.close();
            }
          },
          _ConfiguredProxy(
            'PROXY 127.0.0.1:0; PROXY 127.0.0.1:${proxy.server.port}',
          ),
        );
      } finally {
        await proxy.close();
      }
    },
  );

  test(
    'a healthy hedged proxy tunnel survives cancellation of the stalled opening',
    () async {
      final proxy = await _Proxy.bind(_ProxyMode.firstTlsStall);
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 2),
            opener: const HedgedHttpOpen(
              hedgeDelay: Duration(milliseconds: 25),
            ),
          );
          try {
            for (var i = 0; i < 2; i++) {
              expect((await transport.send(_request('https'))).body, 'proxied');
              await Future<void>.delayed(const Duration(milliseconds: 20));
            }
            expect(proxy.accepted, 2);
            expect(proxy.closed, 1);
            expect(proxy.requestLines, hasLength(2));
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    },
  );

  test(
    'DIRECT fallback is used only when explicitly present in the configuration',
    () async {
      final context = SecurityContext()
        ..useCertificateChainBytes(utf8.encode(syntheticCertificatePem))
        ..usePrivateKeyBytes(utf8.encode(syntheticPrivateKeyPem));
      final server = await HttpServer.bindSecure(
        InternetAddress.loopbackIPv4,
        0,
        context,
      );
      var requests = 0;
      final listener = server.listen((request) async {
        requests++;
        request.response.write('explicit direct');
        await request.response.close();
      });
      final transport = IoApiHttpTransport();
      final request = ApiHttpRequest(
        method: 'GET',
        uri: Uri.parse('https://127.0.0.1:${server.port}/'),
        headers: const {},
      );
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          await expectLater(
            transport.send(request),
            throwsA(isA<ApiNetworkException>()),
          );
          expect(requests, 0);
        }, _ConfiguredProxy('PROXY 127.0.0.1:0'));
        await HttpOverrides.runWithHttpOverrides(() async {
          expect((await transport.send(request)).body, 'explicit direct');
          expect(requests, 1);
        }, _ConfiguredProxy('PROXY 127.0.0.1:0; DIRECT'));
      } finally {
        transport.close();
        await server.close(force: true);
        await listener.cancel();
      }
    },
  );

  test(
    'separate proxy configurations keep separate pools and close releases every pool',
    () async {
      final first = await _Proxy.bind();
      final second = await _Proxy.bind();
      final transport = IoApiHttpTransport();
      try {
        for (final proxy in [first, second, first]) {
          await HttpOverrides.runWithHttpOverrides(() async {
            expect((await transport.send(_request('https'))).body, 'proxied');
            await Future<void>.delayed(Duration.zero);
          }, _EnvironmentProxy(proxy.server.port));
        }
        expect(first.accepted, 1);
        expect(second.accepted, 1);
        transport.close();
        await Future<void>.delayed(const Duration(milliseconds: 20));
        expect(first.closed, 1);
        expect(second.closed, 1);
        await expectLater(
          transport.send(_request('https')),
          throwsA(isA<ApiNetworkException>()),
        );
        expect(first.accepted, 1);
        expect(second.accepted, 1);
      } finally {
        transport.close();
        await first.close();
        await second.close();
      }
    },
  );

  test(
    'an expired proxy opening does not close a concurrent healthy origin',
    () async {
      final proxy = await _Proxy.bind(_ProxyMode.firstTlsStall);
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(milliseconds: 180),
          );
          try {
            final expired = expectLater(
              transport.send(_request('https')),
              throwsA(isA<ApiNetworkException>()),
            );
            await Future<void>.delayed(const Duration(milliseconds: 30));
            expect(
              (await transport.send(_request('https', host: 'localhost'))).body,
              'proxied',
            );
            await expired;
            await Future<void>.delayed(const Duration(milliseconds: 20));
            expect(proxy.accepted, 2);
            expect(proxy.closed, 1);
            expect(proxy.requestLines, hasLength(1));
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    },
  );

  for (final mode in [_ProxyMode.connectStall, _ProxyMode.tlsStall]) {
    test('proxy $mode deadline physically closes both hedged openings', () async {
      final proxy = await _Proxy.bind(mode);
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(milliseconds: 180),
            opener: const HedgedHttpOpen(
              hedgeDelay: Duration(milliseconds: 25),
            ),
          );
          try {
            await expectLater(
              transport.send(_request('https')),
              throwsA(
                isA<ApiNetworkException>().having(
                  (error) => error.code,
                  'code',
                  'network_timeout',
                ),
              ),
            );
            await Future<void>.delayed(const Duration(milliseconds: 100));
            expect(proxy.accepted, 2);
            expect(
              proxy.closed,
              proxy.accepted,
              reason:
                  'must close before transport.close, including SDK CONNECT/TLS',
            );
            // Control for the malformed cases: an accepted CONNECT response
            // makes the client send its TLS handshake through the tunnel.
            expect(
              proxy.tunnelBytes,
              mode == _ProxyMode.tlsStall ? greaterThan(0) : 0,
            );
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    });
  }

  test(
    'a refused CONNECT never falls back to a direct business request',
    () async {
      final proxy = await _Proxy.bind(_ProxyMode.reject);
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport();
          try {
            await expectLater(
              transport.send(_request('https')),
              throwsA(isA<ApiNetworkException>()),
            );
            expect(proxy.connectLines, hasLength(1));
            expect(proxy.requestLines, isEmpty);
          } finally {
            transport.close();
          }
        }, _EnvironmentProxy(proxy.server.port));
      } finally {
        await proxy.close();
      }
    },
  );
}
