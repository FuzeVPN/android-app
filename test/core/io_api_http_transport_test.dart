// In-memory request doubles are closed by the transport; every response
// controller is closed in the owning test's finally block.
// ignore_for_file: close_sinks

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

final Matcher _timeout = throwsA(
  isA<ApiNetworkException>().having((e) => e.code, 'code', 'network_timeout'),
);

ApiHttpRequest _post() => ApiHttpRequest(
  method: 'POST',
  uri: Uri.parse('https://fixture.invalid/v1/example'),
  headers: const {'Content-Type': 'application/json'},
  body: '{"value":"été🔒"}',
);

void main() {
  test('continuous chunks cannot extend the total deadline', () async {
    final response = _Response();
    final outgoing = _Request(() async => response);
    final client = _Client(() async => outgoing);
    final transport = IoApiHttpTransport(
      client: client,
      requestTimeout: const Duration(milliseconds: 180),
    );
    final chunks = Timer.periodic(const Duration(milliseconds: 25), (_) {
      response.controller.add([32]);
    });
    final watch = Stopwatch()..start();
    try {
      await expectLater(transport.send(_post()), _timeout);
      expect(watch.elapsedMilliseconds, lessThan(700));
      expect(response.cancelled, isTrue);
      expect(outgoing.closeCalls, 1);
      expect(utf8.decode(outgoing.bytes), _post().body);
      expect(client.closed, isFalse);
    } finally {
      chunks.cancel();
      await response.controller.close();
      transport.close();
    }
  });

  test('opening, headers and body share the same deadline', () async {
    final response = _Response();
    final outgoing = _Request(() async {
      await Future<void>.delayed(const Duration(milliseconds: 70));
      return response;
    });
    final transport = IoApiHttpTransport(
      client: _Client(() async {
        await Future<void>.delayed(const Duration(milliseconds: 70));
        return outgoing;
      }),
      requestTimeout: const Duration(milliseconds: 200),
    );
    final finish = Timer(const Duration(milliseconds: 280), () {
      unawaited(response.controller.close());
    });
    try {
      await expectLater(transport.send(_post()), _timeout);
      expect(response.cancelled, isTrue);
      expect(outgoing.closeCalls, 1);
    } finally {
      finish.cancel();
      await response.controller.close();
      transport.close();
    }
  });

  test('late opening is aborted before any HTTP write', () async {
    final opening = Completer<HttpClientRequest>();
    final outgoing = _Request(() => throw StateError('must not send'));
    final transport = IoApiHttpTransport(
      client: _Client(() => opening.future),
      requestTimeout: const Duration(milliseconds: 40),
    );
    try {
      await expectLater(transport.send(_post()), _timeout);
      opening.complete(outgoing);
      await Future<void>.delayed(Duration.zero);
      expect(outgoing.aborts, greaterThan(0));
      expect(outgoing.headers.values, isEmpty);
      expect(outgoing.bytes, isEmpty);
      expect(outgoing.closeCalls, 0);
    } finally {
      transport.close();
    }
  });

  test('late headers still cause the body stream to be cancelled', () async {
    final headers = Completer<HttpClientResponse>();
    final response = _Response();
    final outgoing = _Request(() => headers.future);
    final transport = IoApiHttpTransport(
      client: _Client(() async => outgoing),
      requestTimeout: const Duration(milliseconds: 40),
    );
    try {
      await expectLater(transport.send(_post()), _timeout);
      expect(outgoing.aborts, greaterThan(0));
      headers.complete(response);
      await Future<void>.delayed(Duration.zero);
      expect(response.cancelled, isTrue);
      expect(outgoing.closeCalls, 1);
    } finally {
      await response.controller.close();
      transport.close();
    }
  });

  test(
    'slow failing cancellation cannot postpone or escape the timeout',
    () async {
      final cleanup = Completer<void>();
      final response = _Response(cleanup: () => cleanup.future);
      final outgoing = _Request(() async => response);
      final transport = IoApiHttpTransport(
        client: _Client(() async => outgoing),
        requestTimeout: const Duration(milliseconds: 40),
      );
      try {
        await expectLater(transport.send(_post()), _timeout);
        expect(response.cancelled, isTrue);
        expect(cleanup.isCompleted, isFalse);
        cleanup.completeError(StateError('fixture cleanup failure'));
        await Future<void>.delayed(Duration.zero);
      } finally {
        await response.controller.close();
        transport.close();
      }
    },
  );

  test(
    'one expired request does not close an independent concurrent request',
    () async {
      final first = _Response();
      final second = _Response();
      var calls = 0;
      final client = _Client(() async {
        calls++;
        if (calls == 1) return _Request(() async => first);
        return _Request(() async {
          await Future<void>.delayed(const Duration(milliseconds: 120));
          second.controller.add(utf8.encode('ok'));
          unawaited(second.controller.close());
          return second;
        });
      });
      final transport = IoApiHttpTransport(
        client: client,
        requestTimeout: const Duration(milliseconds: 180),
      );
      try {
        final firstResult = expectLater(transport.send(_post()), _timeout);
        await Future<void>.delayed(const Duration(milliseconds: 90));
        final secondResult = transport.send(_post());
        await firstResult;
        expect((await secondResult).body, 'ok');
        expect(client.closed, isFalse);
        expect(calls, 2);
      } finally {
        await first.controller.close();
        await second.controller.close();
        transport.close();
      }
    },
  );

  test('successful UTF-8 response has no later deadline abort', () async {
    final response = _Response();
    final body = utf8.encode('été🔒');
    response.controller.add(body.sublist(0, 2));
    response.controller.add(body.sublist(2));
    unawaited(response.controller.close());
    final outgoing = _Request(() async => response);
    final transport = IoApiHttpTransport(
      client: _Client(() async => outgoing),
      requestTimeout: const Duration(milliseconds: 80),
    );
    try {
      expect((await transport.send(_post())).body, 'été🔒');
      await Future<void>.delayed(const Duration(milliseconds: 120));
      expect(outgoing.aborts, 0);
      expect(outgoing.closeCalls, 1);
    } finally {
      await response.controller.close();
      transport.close();
    }
  });

  for (final size in [1024 * 1024, 1024 * 1024 + 1]) {
    test('response byte limit boundary: $size', () async {
      final response = _Response();
      response.controller.add(List<int>.filled(size, 32));
      unawaited(response.controller.close());
      final transport = IoApiHttpTransport(
        client: _Client(() async => _Request(() async => response)),
      );
      try {
        if (size == 1024 * 1024) {
          expect((await transport.send(_post())).body.length, size);
        } else {
          await expectLater(
            transport.send(_post()),
            throwsA(isA<ApiProtocolException>()),
          );
          expect(response.cancelled, isTrue);
        }
      } finally {
        await response.controller.close();
        transport.close();
      }
    });
  }
}

class _Client implements HttpClient {
  _Client(this.openRequest);
  final Future<HttpClientRequest> Function() openRequest;
  bool closed = false;

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) => openRequest();

  @override
  void close({bool force = false}) => closed = true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Request implements HttpClientRequest {
  _Request(this.respond);
  final Future<HttpClientResponse> Function() respond;
  final List<int> bytes = [];
  int closeCalls = 0;
  int aborts = 0;

  @override
  final _Headers headers = _Headers();

  @override
  void add(List<int> data) => bytes.addAll(data);

  @override
  Future<HttpClientResponse> close() {
    closeCalls++;
    return respond();
  }

  @override
  void abort([Object? exception, StackTrace? stackTrace]) => aborts++;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Headers implements HttpHeaders {
  final Map<String, List<String>> values = {};

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    values[name] = [value.toString()];
  }

  @override
  void forEach(void Function(String name, List<String> values) action) {
    values.forEach(action);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Response extends Stream<List<int>> implements HttpClientResponse {
  _Response({Future<void> Function()? cleanup}) {
    controller = StreamController<List<int>>(
      onCancel: () {
        cancelled = true;
        return cleanup?.call();
      },
    );
  }

  late final StreamController<List<int>> controller;
  bool cancelled = false;

  @override
  int get statusCode => 200;

  @override
  final HttpHeaders headers = _Headers();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => controller.stream.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
