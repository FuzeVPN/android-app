// A04-transport-02: the "untrusted certificate" proof of B-02-PROXY runs in
// its own test isolate. This file never installs the synthetic certificate in
// SecurityContext.defaultContext, so its result does not depend on the order,
// filter or shard of io_api_http_proxy_test.dart (which trusts it in setUpAll).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

import '../fixtures/api_transport/synthetic_tls_fixture.dart';

class _ConfiguredProxy extends HttpOverrides {
  _ConfiguredProxy(this.configuration);
  final String configuration;
  @override
  String findProxyFromEnvironment(Uri uri, Map<String, String>? environment) =>
      configuration;
}

/// CONNECT proxy relaying the tunnel to a local TLS origin.
class _RelayProxy {
  _RelayProxy._(this.server, this.originPort) {
    server.listen(_accept);
  }

  static Future<_RelayProxy> bind(int originPort) async => _RelayProxy._(
    await ServerSocket.bind(InternetAddress.loopbackIPv4, 0),
    originPort,
  );

  final ServerSocket server;
  final int originPort;
  final sockets = <Socket>[];
  final connectLines = <String>[];

  void _accept(Socket client) {
    sockets.add(client);
    final header = <int>[];
    Socket? origin;
    var tunnelling = false;
    client.listen(
      (data) async {
        if (tunnelling) {
          origin?.add(data);
          return;
        }
        header.addAll(data);
        final text = latin1.decode(header);
        final end = text.indexOf('\r\n\r\n');
        if (end < 0) return;
        tunnelling = true;
        connectLines.add(text.substring(0, text.indexOf('\r\n')));
        final upstream = await Socket.connect(
          InternetAddress.loopbackIPv4,
          originPort,
        );
        origin = upstream;
        sockets.add(upstream);
        upstream.listen(
          client.add,
          onDone: client.destroy,
          onError: (Object _) => client.destroy(),
        );
        client.add(
          latin1.encode('HTTP/1.1 200 Connection established\r\n\r\n'),
        );
        final rest = header.sublist(end + 4);
        if (rest.isNotEmpty) upstream.add(rest);
      },
      onDone: () => origin?.destroy(),
      onError: (Object _) => origin?.destroy(),
    );
  }

  Future<void> close() async {
    for (final socket in sockets) {
      socket.destroy();
    }
    await server.close();
  }
}

void main() {
  test(
    'proxy CONNECT refuses a certificate the platform does not trust',
    () async {
      final context = SecurityContext()
        ..useCertificateChainBytes(utf8.encode(syntheticCertificatePem))
        ..usePrivateKeyBytes(utf8.encode(syntheticPrivateKeyPem));
      final origin = await HttpServer.bindSecure(
        InternetAddress.loopbackIPv4,
        0,
        context,
      );
      var requests = 0;
      final listener = origin.listen((request) async {
        requests++;
        request.response.write('must not be reached');
        await request.response.close();
      });
      final proxy = await _RelayProxy.bind(origin.port);
      try {
        await HttpOverrides.runWithHttpOverrides(() async {
          final transport = IoApiHttpTransport(
            requestTimeout: const Duration(seconds: 3),
          );
          try {
            for (final host in ['127.0.0.1', 'localhost']) {
              await expectLater(
                transport.send(
                  ApiHttpRequest(
                    method: 'GET',
                    uri: Uri.parse('https://$host:${origin.port}/resource'),
                    headers: const {},
                  ),
                ),
                throwsA(isA<ApiNetworkException>()),
              );
            }
            expect(proxy.connectLines, [
              'CONNECT 127.0.0.1:${origin.port} HTTP/1.1',
              'CONNECT localhost:${origin.port} HTTP/1.1',
            ]);
            expect(requests, 0);
          } finally {
            transport.close();
          }
        }, _ConfiguredProxy('PROXY 127.0.0.1:${proxy.server.port}'));
      } finally {
        await proxy.close();
        await origin.close(force: true);
        await listener.cancel();
      }
    },
  );
}
