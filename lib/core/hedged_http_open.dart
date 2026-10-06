import 'dart:async';

import 'connection_timing.dart';

/// Races only connection setup. The returned value is selected before callers
/// can write headers or a request body, so it never retries an HTTP request.
class HedgedHttpOpen {
  const HedgedHttpOpen({this.hedgeDelay = const Duration(seconds: 1)});

  final Duration hedgeDelay;

  Future<T> open<T>({
    required Future<T> Function() primary,
    required Future<T> Function() alternate,
    required void Function(T value) abort,
    required Duration timeout,
  }) {
    final Completer<T> result = Completer<T>();
    Timer? hedgeTimer;
    Timer? timeoutTimer;
    Object? primaryError;
    StackTrace? primaryStackTrace;
    Object? alternateError;
    StackTrace? alternateStackTrace;
    var primaryDone = false;
    var alternateStarted = false;
    var alternateDone = false;
    var finished = false;

    void finishSuccess(T value) {
      if (finished) {
        try {
          abort(value);
        } catch (_) {}
        return;
      }
      finished = true;
      hedgeTimer?.cancel();
      timeoutTimer?.cancel();
      result.complete(value);
    }

    void finishError(Object error, [StackTrace? stackTrace]) {
      if (finished) return;
      finished = true;
      hedgeTimer?.cancel();
      timeoutTimer?.cancel();
      if (stackTrace == null) {
        result.completeError(error);
      } else {
        result.completeError(error, stackTrace);
      }
    }

    void finishBothFailures() {
      if (primaryError != null) {
        finishError(primaryError!, primaryStackTrace);
      } else {
        finishError(alternateError!, alternateStackTrace);
      }
    }

    void observe(Future<T> future, {required bool isPrimary}) {
      future.then(
        finishSuccess,
        onError: (Object error, StackTrace stackTrace) {
          if (finished) return;
          if (isPrimary) {
            primaryDone = true;
            primaryError = error;
            primaryStackTrace = stackTrace;
            if (!alternateStarted) {
              finishError(error, stackTrace);
            } else if (alternateDone) {
              finishBothFailures();
            }
          } else {
            alternateDone = true;
            alternateError = error;
            alternateStackTrace = stackTrace;
            if (primaryDone) finishBothFailures();
          }
        },
      );
    }

    void startAlternate() {
      if (finished || alternateStarted) return;
      alternateStarted = true;
      final Future<T> future = ConnectionTiming.measure(
        'http.open.alternate',
        () => Future<T>.sync(alternate),
      );
      observe(future, isPrimary: false);
    }

    final Future<T> first = ConnectionTiming.measure(
      'http.open.primary',
      () => Future<T>.sync(primary),
    );
    observe(first, isPrimary: true);
    hedgeTimer = Timer(hedgeDelay, startAlternate);
    timeoutTimer = Timer(timeout, () {
      finishError(TimeoutException('HTTP open timed out', timeout));
    });
    return result.future;
  }
}
