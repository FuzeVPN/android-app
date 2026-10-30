import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

final Object _attemptKey = Object();

/// Owns only connections being opened by one attempt, never pooled sockets.
class ApiSocketOpenAttempt {
  final Set<void Function()> _cancellations = {};
  var _cancelled = false;

  Future<T> run<T>(Future<T> Function() action) =>
      runZoned(action, zoneValues: {_attemptKey: this});

  void _register(void Function() cancel) {
    if (_cancelled) {
      cancel();
    } else {
      _cancellations.add(cancel);
    }
  }

  void release() => _cancellations.clear();

  void cancel() {
    _cancelled = true;
    for (final cancel in _cancellations.toList()) {
      try {
        cancel();
      } catch (_) {
        // Cancellation of one socket cannot prevent the remaining cleanup.
      }
    }
    _cancellations.clear();
  }
}

/// Factory for the transport's default IO client. Proxy TCP connections retain
/// the SDK's HTTP forwarding, CONNECT, authentication and TLS verification.
Future<ConnectionTask<Socket>> openApiSocket(
  Uri uri,
  String? proxyHost,
  int? proxyPort,
) async {
  final attempt = Zone.current[_attemptKey] as ApiSocketOpenAttempt?;
  if (uri.scheme != 'https' && uri.scheme != 'http') {
    throw ArgumentError('An HTTP API socket is required.');
  }
  if (uri.scheme == 'http' || proxyHost != null) {
    final task = await Socket.startConnect(
      proxyHost ?? uri.host,
      proxyPort ?? uri.port,
    );
    Socket? socket;
    var cancelled = false;
    void cancel() {
      cancelled = true;
      task.cancel();
      socket?.destroy();
    }

    attempt?._register(cancel);
    return ConnectionTask.fromSocket(
      task.socket.then((value) {
        socket = value;
        if (cancelled) {
          value.destroy();
          throw const SocketException('API socket opening cancelled');
        }
        return value;
      }),
      cancel,
    );
  }

  return openApiSocketWithProxyConfiguration(uri, 'DIRECT');
}

/// HTTPS routing for the owned transport. The SDK resolves its environment;
/// this factory retains the raw socket across CONNECT and TLS so cancellation
/// can close either phase. A direct fallback requires an explicit DIRECT item.
Future<ConnectionTask<Socket>> openApiSocketWithProxyConfiguration(
  Uri uri,
  String configuration,
) async {
  if (uri.scheme != 'https') {
    throw ArgumentError('An HTTPS API socket is required.');
  }
  final routes = _ApiProxyRoute.parse(configuration);
  final attempt = Zone.current[_attemptKey] as ApiSocketOpenAttempt?;
  ConnectionTask<RawSocket>? task;
  RawSocket? raw;
  Socket? established;
  var cancelled = false;
  void cancel() {
    cancelled = true;
    task?.cancel();
    established?.destroy();
    final pending = raw;
    if (pending != null) {
      unawaited(pending.close().then<void>((_) {}, onError: (Object _) {}));
    }
  }

  attempt?._register(cancel);
  void checkCancelled() {
    if (cancelled) throw const SocketException('API socket opening cancelled');
  }

  Future<Socket> connect() async {
    for (var index = 0; index < routes.length; index++) {
      checkCancelled();
      final route = routes[index];
      try {
        if (route.port != null && (route.port! < 1 || route.port! > 65535)) {
          throw const SocketException('Invalid API proxy port');
        }
        task = await RawSocket.startConnect(
          route.host ?? uri.host,
          route.port ?? uri.port,
        );
        if (cancelled) task!.cancel();
        final value = raw = await task!.socket;
        checkCancelled();
        // Ownership is transferred to RawSecureSocket.secure below.
        // ignore: cancel_subscriptions
        final subscription = route.host == null
            ? null
            : await _connectApiProxyTunnel(value, uri, route);
        checkCancelled();
        // This is always the destination host, never the proxy. No permissive
        // certificate callback or alternate trust context is installed.
        final secure = await RawSecureSocket.secure(
          value,
          subscription: subscription,
          host: uri.host,
        );
        if (cancelled) {
          await secure.close();
          checkCancelled();
        }
        return established = _ApiSecureSocket(secure);
      } catch (error) {
        await raw?.close();
        raw = null;
        if (error is! IOException) rethrow;
        checkCancelled();
        if (index == routes.length - 1) rethrow;
      }
    }
    throw const HttpException('No API proxy route configured');
  }

  final socket = connect();
  // A local route error can complete before the async factory has delivered
  // its ConnectionTask. Observe it immediately; the unchanged future still
  // delivers the same error to the SDK once it attaches its own listener.
  socket.ignore();
  return ConnectionTask.fromSocket(socket, cancel);
}

class _ApiProxyRoute {
  const _ApiProxyRoute(this.host, this.port, this.credentials);
  final String? host;
  final int? port;
  final String? credentials;

  // Match the installed SDK's PROXY host:port / user:password@host:port list.
  // Configuration or credentials must never appear in public errors.
  static List<_ApiProxyRoute> parse(String configuration) {
    final routes = <_ApiProxyRoute>[];
    for (var item in configuration.split(';')) {
      item = item.trim();
      if (item.isEmpty) continue;
      if (item == 'DIRECT') {
        routes.add(const _ApiProxyRoute(null, null, null));
        continue;
      }
      if (!item.startsWith('PROXY ')) {
        throw const HttpException('Invalid API proxy configuration');
      }
      item = item.substring(6).trim();
      String? credentials;
      final at = item.lastIndexOf('@');
      if (at >= 0) {
        final userInfo = item.substring(0, at).trim();
        item = item.substring(at + 1).trim();
        final colon = userInfo.indexOf(':');
        if (colon <= 0 || colon == userInfo.length - 1) {
          throw const HttpException('Invalid API proxy configuration');
        }
        credentials =
            '${userInfo.substring(0, colon).trim()}:'
            '${userInfo.substring(colon + 1).trim()}';
      }
      final colon = item.lastIndexOf(':');
      if (colon <= 0 || colon == item.length - 1) {
        throw const HttpException('Invalid API proxy configuration');
      }
      var host = item.substring(0, colon).trim();
      if (host.startsWith('[') && host.endsWith(']')) {
        host = host.substring(1, host.length - 1);
      }
      final port = int.tryParse(item.substring(colon + 1).trim());
      if (host.isEmpty || port == null) {
        throw const HttpException('Invalid API proxy configuration');
      }
      routes.add(_ApiProxyRoute(host, port, credentials));
    }
    if (routes.isEmpty) {
      throw const HttpException('No API proxy route configured');
    }
    return routes;
  }

  @override
  String toString() => 'ApiProxyRoute(redacted: true)';
}

Future<StreamSubscription<RawSocketEvent>> _connectApiProxyTunnel(
  RawSocket raw,
  Uri destination,
  _ApiProxyRoute route,
) {
  const maximumHeaders = 16 * 1024;
  const maximumInterimResponses = 4;
  final authority = Uri(
    host: destination.host,
    port: destination.port,
  ).authority;
  final credentials = route.credentials;
  final request = utf8.encode(
    'CONNECT $authority HTTP/1.1\r\nHost: $authority\r\n'
    '${credentials == null ? '' : 'Proxy-Authorization: Basic ${base64Encode(utf8.encode(credentials))}\r\n'}'
    '\r\n',
  );
  if (request.length > maximumHeaders) {
    throw const HttpException('API proxy request headers too large');
  }
  final result = Completer<StreamSubscription<RawSocketEvent>>();
  late final StreamSubscription<RawSocketEvent> subscription;
  final received = <int>[];
  var totalHeaders = 0;
  var interimResponses = 0;
  var written = 0;

  void fail() {
    if (!result.isCompleted) {
      result.completeError(const HttpException('Invalid API proxy response'));
    }
  }

  void write() {
    if (result.isCompleted) return;
    written += raw.write(request, written, request.length - written);
    raw.writeEventsEnabled = written < request.length;
  }

  // Length of the first complete header block (start line, fields and the
  // empty line), or -1. Like the SDK parser, a line ends with LF and an
  // optional CR before it (RFC 9112 §2.2); a bare CR is never a terminator.
  int headerBlockLength() {
    var lineStart = 0;
    for (var index = 0; index < received.length; index++) {
      if (received[index] != 0x0a) continue;
      final lineEnd = index > lineStart && received[index - 1] == 0x0d
          ? index - 1
          : index;
      if (lineEnd == lineStart) return index + 1;
      lineStart = index + 1;
    }
    return -1;
  }

  void read() {
    // RawSocket.read() already drains every available byte. Another call
    // with nothing available trips the SDK's debug assertion, which closes
    // the socket, so read only while bytes are available.
    while (!result.isCompleted && raw.available() > 0) {
      final chunk = raw.read();
      if (chunk == null) return;
      if (totalHeaders + received.length + chunk.length > maximumHeaders) {
        fail();
        return;
      }
      received.addAll(chunk);
      var headerLength = headerBlockLength();
      while (headerLength >= 0) {
        final lines = latin1
            .decode(received.sublist(0, headerLength))
            .split('\n')
            .map(
              (line) => line.endsWith('\r')
                  ? line.substring(0, line.length - 1)
                  : line,
            )
            .toList();
        // Drop the empty line that ends the block and the split remainder.
        lines.removeRange(lines.length - 2, lines.length);
        final status = lines.isEmpty
            ? null
            : RegExp(
                r'^HTTP/1\.[01] ([0-9]{3})(?: [\x09\x20-\x7e\x80-\xff]*)?$',
              ).firstMatch(lines.first);
        if (status == null) {
          fail();
          return;
        }
        var field = false;
        for (final line in lines.skip(1)) {
          // obs-fold continues the previous field value (RFC 9112 §5.2), as
          // in the SDK; it is refused before the first field.
          final folded = line.startsWith(' ') || line.startsWith('\t');
          final colon = folded ? 0 : line.indexOf(':');
          if ((folded && !field) ||
              (!folded &&
                  (colon <= 0 ||
                      !RegExp(
                        r"^[!#$%&'*+.^_`|~0-9A-Za-z-]+$",
                      ).hasMatch(line.substring(0, colon)))) ||
              line
                  .substring(colon + 1)
                  .contains(RegExp(r'[\x00-\x08\x0a-\x1f\x7f]'))) {
            fail();
            return;
          }
          field = true;
        }
        totalHeaders += headerLength;
        received.removeRange(0, headerLength);
        final code = int.parse(status.group(1)!);
        if (code >= 100 && code < 200 && code != 101) {
          if (++interimResponses > maximumInterimResponses) {
            fail();
            return;
          }
          headerLength = headerBlockLength();
          continue;
        }
        // A successful CONNECT switches protocols immediately. In particular,
        // Content-Length and Transfer-Encoding do not frame a response body.
        if (code != 200 || received.isNotEmpty || written != request.length) {
          fail();
          return;
        }
        // RawSecureSocket takes over this active, unpaused subscription. Stop
        // raw reads until its handlers have replaced these CONNECT handlers.
        raw.readEventsEnabled = false;
        raw.writeEventsEnabled = false;
        result.complete(subscription);
        return;
      }
    }
  }

  raw.readEventsEnabled = true;
  raw.writeEventsEnabled = false;
  subscription = raw.listen(
    (event) {
      try {
        if (event == RawSocketEvent.write) write();
        if (event == RawSocketEvent.read) read();
        if (event == RawSocketEvent.readClosed ||
            event == RawSocketEvent.closed) {
          fail();
        }
      } on IOException {
        fail();
      }
    },
    onError: (Object _) => fail(),
    onDone: fail,
  );
  try {
    write();
  } on IOException {
    fail();
  }
  return result.future;
}

/// Adapts the public raw TLS API to the Socket stream/sink used by HttpClient.
/// The underlying IO client still owns keep-alive pooling and HTTP parsing.
class _ApiSecureSocket extends Stream<Uint8List> implements SecureSocket {
  _ApiSecureSocket(this._raw) {
    _reads = StreamController<Uint8List>(
      sync: true,
      onListen: () => _raw.readEventsEnabled = true,
      onPause: () => _raw.readEventsEnabled = false,
      onResume: () => _raw.readEventsEnabled = true,
      onCancel: destroy,
    );
    _sink = IOSink(_ApiSocketWriter(this));
    _raw.readEventsEnabled = false;
    _raw.writeEventsEnabled = false;
    _events = _raw.listen(_onEvent, onError: _onError, onDone: _onDone);
  }

  final RawSecureSocket _raw;
  late final StreamController<Uint8List> _reads;
  late final IOSink _sink;
  late final StreamSubscription<RawSocketEvent> _events;
  Completer<void>? _writable;
  var _destroyed = false;

  void _onEvent(RawSocketEvent event) {
    if (event == RawSocketEvent.read) {
      while (!_reads.isPaused && !_reads.isClosed) {
        final bytes = _raw.read();
        if (bytes == null) break;
        _reads.add(bytes);
      }
    } else if (event == RawSocketEvent.write) {
      _raw.writeEventsEnabled = false;
      _writable?.complete();
      _writable = null;
    } else if (event == RawSocketEvent.readClosed) {
      if (!_reads.isClosed) unawaited(_reads.close());
    }
  }

  void _onError(Object error, StackTrace stack) {
    if (!_reads.isClosed) _reads.addError(error, stack);
    _failWriter(error, stack);
  }

  void _failWriter(Object error, StackTrace stack) {
    _writable?.completeError(error, stack);
    _writable = null;
  }

  void _onDone() {
    if (!_reads.isClosed) unawaited(_reads.close());
    _failWriter(const SocketException('API socket closed'), StackTrace.current);
  }

  Future<void> _write(List<int> bytes) async {
    var offset = 0;
    while (offset < bytes.length) {
      if (_destroyed) throw const SocketException('API socket closed');
      final written = _raw.write(bytes, offset, bytes.length - offset);
      offset += written;
      if (offset < bytes.length) {
        final ready = _writable ??= Completer<void>();
        _raw.writeEventsEnabled = true;
        await ready.future;
      }
    }
  }

  @override
  StreamSubscription<Uint8List> listen(
    void Function(Uint8List)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => _reads.stream.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );

  @override
  void destroy() {
    if (_destroyed) return;
    _destroyed = true;
    _failWriter(const SocketException('API socket closed'), StackTrace.current);
    unawaited(_events.cancel());
    unawaited(_raw.close().then<void>((_) {}, onError: (Object _) {}));
    if (!_reads.isClosed) unawaited(_reads.close());
  }

  @override
  InternetAddress get address => _raw.address;
  @override
  int get port => _raw.port;
  @override
  InternetAddress get remoteAddress => _raw.remoteAddress;
  @override
  int get remotePort => _raw.remotePort;
  @override
  X509Certificate? get peerCertificate => _raw.peerCertificate;
  @override
  String? get selectedProtocol => _raw.selectedProtocol;
  // SecureSocket documents renegotiate as a deprecated no-op; the SDK's own
  // SecureSocket implementation also leaves it empty (unlike its raw layer).
  // Preserve that public Socket behavior rather than initiating a new handshake.
  @override
  void renegotiate({
    bool useSessionCache = true,
    bool requestClientCertificate = false,
    bool requireClientCertificate = false,
  }) {}
  @override
  bool setOption(SocketOption option, bool enabled) =>
      _raw.setOption(option, enabled);
  @override
  Uint8List getRawOption(RawSocketOption option) => _raw.getRawOption(option);
  @override
  void setRawOption(RawSocketOption option) => _raw.setRawOption(option);
  @override
  Encoding get encoding => _sink.encoding;
  @override
  set encoding(Encoding value) => _sink.encoding = value;
  @override
  void add(List<int> data) => _sink.add(data);
  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _sink.addError(error, stackTrace);
  @override
  Future<void> addStream(Stream<List<int>> stream) => _sink.addStream(stream);
  @override
  Future<void> flush() => _sink.flush();
  @override
  Future<void> close() => _sink.close();
  @override
  Future<void> get done => _sink.done;
  @override
  void write(Object? object) => _sink.write(object);
  @override
  void writeAll(Iterable<dynamic> objects, [String separator = '']) =>
      _sink.writeAll(objects, separator);
  @override
  void writeCharCode(int charCode) => _sink.writeCharCode(charCode);
  @override
  void writeln([Object? object = '']) => _sink.writeln(object);
}

class _ApiSocketWriter implements StreamConsumer<List<int>> {
  _ApiSocketWriter(this.socket);
  final _ApiSecureSocket socket;

  @override
  Future<void> addStream(Stream<List<int>> stream) async {
    await for (final bytes in stream) {
      await socket._write(bytes);
    }
  }

  @override
  Future<void> close() async => socket._raw.shutdown(SocketDirection.send);
}
