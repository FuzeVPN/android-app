import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_socket_open.dart';

import '../fixtures/api_transport/synthetic_tls_fixture.dart';

void main() {
  setUpAll(() {
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      utf8.encode(syntheticCertificatePem),
    );
  });

  // The HTTP client pauses its reader while it sends a request. A connection
  // that ends meanwhile is finished but not yet destroyed by that reader.
  test('a write after the connection ended fails as a closed socket, like '
      'after destroy', () async {
    final context = SecurityContext()
      ..useCertificateChainBytes(utf8.encode(syntheticCertificatePem))
      ..usePrivateKeyBytes(utf8.encode(syntheticPrivateKeyPem));
    final server = await SecureServerSocket.bind(
      InternetAddress.loopbackIPv4,
      0,
      context,
    );
    final accepted = Completer<SecureSocket>();
    final listener = server.listen(accepted.complete, onError: (Object _) {});
    Socket? socket;
    try {
      final task = await openApiSocketWithProxyConfiguration(
        Uri.parse('https://127.0.0.1:${server.port}/'),
        'DIRECT',
      );
      socket = await task.socket.timeout(const Duration(seconds: 10));
      final peer = await accepted.future.timeout(const Duration(seconds: 10));
      // Nobody reads on the client: only its writes can meet the closed peer.
      peer.destroy();
      final failures = <Object>[];
      final elapsed = Stopwatch()..start();
      while (failures.length < 3 &&
          elapsed.elapsed < const Duration(seconds: 20)) {
        try {
          socket.add(const [0]);
          await socket.flush().timeout(const Duration(seconds: 5));
        } catch (error) {
          failures.add(error);
        }
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      expect(failures, hasLength(3));
      expect(failures, everyElement(isA<SocketException>()));
    } finally {
      socket?.destroy();
      await listener.cancel();
      await server.close();
    }
  });
}
