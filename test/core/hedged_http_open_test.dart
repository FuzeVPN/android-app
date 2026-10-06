import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/hedged_http_open.dart';

void main() {
  test('une ouverture primaire rapide ne lance pas la seconde', () async {
    var primaryCalls = 0;
    var alternateCalls = 0;
    final String value =
        await const HedgedHttpOpen(
          hedgeDelay: Duration(milliseconds: 2),
        ).open<String>(
          primary: () async {
            primaryCalls++;
            return 'ipv4';
          },
          alternate: () async {
            alternateCalls++;
            return 'ipv6';
          },
          abort: (_) {},
          timeout: const Duration(seconds: 1),
        );

    expect(value, 'ipv4');
    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(primaryCalls, 1);
    expect(alternateCalls, 0);
  });

  test(
    'une seconde ouverture peut gagner et le premier socket est abandonné',
    () async {
      final Completer<String> primary = Completer<String>();
      final List<String> abandoned = <String>[];
      var alternateCalls = 0;
      final Future<String> result =
          const HedgedHttpOpen(
            hedgeDelay: Duration(milliseconds: 1),
          ).open<String>(
            primary: () => primary.future,
            alternate: () async {
              alternateCalls++;
              return 'ipv6';
            },
            abort: abandoned.add,
            timeout: const Duration(seconds: 1),
          );

      expect(await result, 'ipv6');
      expect(alternateCalls, 1);
      primary.complete('ipv4');
      await Future<void>.delayed(Duration.zero);
      expect(abandoned, <String>['ipv4']);
    },
  );

  test('un seul chemin disponible reste utilisable', () async {
    final Completer<String> unavailable = Completer<String>();
    final String value =
        await const HedgedHttpOpen(
          hedgeDelay: Duration(milliseconds: 1),
        ).open<String>(
          primary: () => unavailable.future,
          alternate: () async => 'ipv6-only',
          abort: (_) {},
          timeout: const Duration(seconds: 1),
        );

    expect(value, 'ipv6-only');
    unavailable.completeError(StateError('unused IPv4 connection'));
  });

  test('deux échecs conservent l erreur de l ouverture primaire', () async {
    final Completer<String> primary = Completer<String>();
    final Completer<String> alternate = Completer<String>();
    final Future<String> result =
        const HedgedHttpOpen(
          hedgeDelay: Duration(milliseconds: 1),
        ).open<String>(
          primary: () => primary.future,
          alternate: () => alternate.future,
          abort: (_) {},
          timeout: const Duration(seconds: 1),
        );

    await Future<void>.delayed(const Duration(milliseconds: 5));
    alternate.completeError(StateError('alternate failure'));
    primary.completeError(StateError('primary failure'));
    await expectLater(
      result,
      throwsA(
        isA<StateError>().having(
          (StateError error) => error.message,
          'message',
          'primary failure',
        ),
      ),
    );
  });

  test('le délai global abandonne les ouvertures qui arrivent tard', () async {
    final Completer<String> primary = Completer<String>();
    final Completer<String> alternate = Completer<String>();
    final List<String> abandoned = <String>[];
    final Future<String> result =
        const HedgedHttpOpen(
          hedgeDelay: Duration(milliseconds: 1),
        ).open<String>(
          primary: () => primary.future,
          alternate: () => alternate.future,
          abort: abandoned.add,
          timeout: const Duration(milliseconds: 20),
        );

    await expectLater(result, throwsA(isA<TimeoutException>()));
    primary.complete('primary late');
    alternate.complete('alternate late');
    await Future<void>.delayed(Duration.zero);
    expect(abandoned, containsAll(<String>['primary late', 'alternate late']));
  });

  test(
    'seule l ouverture sélectionnée envoie en-têtes et corps HTTP',
    () async {
      final HttpServer server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));
      final Completer<void> firstSocketConnected = Completer<void>();
      final Completer<void> releaseFirstSocket = Completer<void>();
      var factoryCalls = 0;
      final HttpClient client = HttpClient()
        ..connectionFactory = (Uri _, String? proxyHost, int? proxyPort) async {
          expect(proxyHost, isNull);
          expect(proxyPort, isNull);
          final bool delaySocket = factoryCalls++ == 0;
          final ConnectionTask<Socket> task = await Socket.startConnect(
            InternetAddress.loopbackIPv4,
            server.port,
          );
          final Future<Socket> socket = task.socket.then((Socket value) async {
            if (delaySocket) {
              firstSocketConnected.complete();
              await releaseFirstSocket.future;
            }
            return value;
          });
          return ConnectionTask.fromSocket<Socket>(socket, task.cancel);
        };
      final IoApiHttpTransport transport = IoApiHttpTransport(
        client: client,
        opener: const HedgedHttpOpen(hedgeDelay: Duration(milliseconds: 2)),
        requestTimeout: const Duration(seconds: 1),
      );
      addTearDown(transport.close);
      final List<HttpRequest> requests = <HttpRequest>[];
      final Future<void> served = server.listen((HttpRequest request) async {
        requests.add(request);
        expect(
          request.headers.value(HttpHeaders.authorizationHeader),
          'Bearer secret',
        );
        expect(await utf8.decoder.bind(request).join(), '{"safe":true}');
        request.response.statusCode = HttpStatus.ok;
        request.response.write('ok');
        await request.response.close();
      }).asFuture<void>();

      final Future<ApiHttpResponse> response = transport.send(
        ApiHttpRequest(
          method: 'POST',
          uri: Uri.parse('http://example.test:${server.port}/v1/locations'),
          headers: const <String, String>{
            'authorization': 'Bearer secret',
            'content-type': 'application/json',
          },
          body: '{"safe":true}',
        ),
      );

      await firstSocketConnected.future;
      final ApiHttpResponse received = await response;
      expect(received.statusCode, HttpStatus.ok);
      expect(received.body, 'ok');
      expect(factoryCalls, 2);
      expect(requests, hasLength(1));
      releaseFirstSocket.complete();
      await Future<void>.delayed(const Duration(milliseconds: 5));
      expect(requests, hasLength(1));
      await server.close(force: true);
      await served;
    },
  );
}
