import 'dart:async';

/// No token is stored here. Identity is the lifetime of an account operation.
class SessionOperation {
  SessionOperation();

  bool _cancelled = false;
  final Completer<void> _cancellation = Completer<void>();
  bool get isCurrent => !_cancelled;

  void invalidate() {
    if (_cancelled) return;
    _cancelled = true;
    _cancellation.complete();
  }

  void check() {
    if (_cancelled) throw const SessionOperationCancelled();
  }

  Future<void> wait(Future<void> pending) async {
    check();
    await Future.any<void>(<Future<void>>[pending, _cancellation.future]);
    check();
  }
}

class SessionOperationCancelled implements Exception {
  const SessionOperationCancelled();
}

/// A success means both the native worker and the persisted session are gone.
class SessionTerminationResult {
  const SessionTerminationResult({
    required this.tunnelStopped,
    required this.sessionCleared,
    this.stopError,
    this.storageError,
    this.inProgress = false,
    this.sessionExpired = false,
  });

  const SessionTerminationResult.complete()
    : this(tunnelStopped: true, sessionCleared: true);

  final bool tunnelStopped;
  final bool sessionCleared;
  final String? stopError;
  final String? storageError;
  final bool inProgress;
  final bool sessionExpired;
  bool get isComplete => tunnelStopped && sessionCleared && !inProgress;

  factory SessionTerminationResult.fromWire(Object? value) {
    final Map<Object?, Object?> data = value is Map
        ? value.cast<Object?, Object?>()
        : const <Object?, Object?>{};
    String? code(String key) =>
        data[key] is String &&
            RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(data[key]! as String)
        ? data[key]! as String
        : null;
    return SessionTerminationResult(
      tunnelStopped: data['tunnel_stopped'] == true,
      sessionCleared: data['session_cleared'] == true,
      inProgress: data['in_progress'] == true,
      sessionExpired: data['session_expired'] == true,
      stopError: code('stop_error'),
      storageError: code('storage_error'),
    );
  }
}
