import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

typedef ConnectionTimingObserver = void Function(String, String, int, int?);

/// Structured timings. Callers supply constant stage names, never payloads,
/// identifiers, URLs or exception text. Zones keep concurrent attempts separate.
abstract final class ConnectionTiming {
  static final Object _traceKey = Object();
  static final Object _spanKey = Object();
  static int _sequence = 0;

  /// Only fixed stage/event names and numeric observations cross this boundary.
  /// Observers must rebuild a closed report; raw debug output is never uploaded.
  static final Set<ConnectionTimingObserver Function()> observerFactories = {};

  static List<ConnectionTimingObserver> _captureObservers() {
    final captured = <ConnectionTimingObserver>[];
    for (final factory in List.of(observerFactories)) {
      try {
        captured.add(factory());
      } catch (_) {
        /* An optional observer cannot stop a VPN operation. */
      }
    }
    return captured;
  }

  static _TimingTrace? get _trace {
    final trace = Zone.current[_traceKey] as _TimingTrace?;
    return trace != null && !trace.closed ? trace : null;
  }

  static String? get currentId => _trace?.id;
  static int? get currentSpanId =>
      _trace == null ? null : Zone.current[_spanKey] as int?;

  /// Collector requests must never appear as failures of the observed VPN.
  static Future<T> unobserved<T>(Future<T> Function() action) =>
      runZoned(action, zoneValues: {_traceKey: null, _spanKey: null});

  static Future<T> run<T>(
    String stage,
    Future<T> Function() action, {
    @visibleForTesting void Function(String)? sink,
  }) {
    if (!kDebugMode && observerFactories.isEmpty) return action();
    if (_trace != null) return measure(stage, action);
    final trace = _TimingTrace(
      'c${DateTime.now().microsecondsSinceEpoch}${++_sequence}',
      sink ?? (kDebugMode ? debugPrintSynchronously : (_) {}),
      _captureObservers(),
    );
    return runZoned(() async {
      try {
        return await measure(stage, action);
      } finally {
        trace.closed = true;
        for (final timer in trace.timers) {
          timer.cancel();
        }
        trace.timers.clear();
      }
    }, zoneValues: {_traceKey: trace});
  }

  static Future<T> measure<T>(String stage, Future<T> Function() action) {
    final trace = _trace;
    if (trace == null || trace.closed) return action();
    final int span = ++trace.nextSpan;
    final int? parent = currentSpanId;
    final watch = Stopwatch()..start();
    void emit(String event) => trace.emit(
      stage,
      event,
      span,
      parent,
      durationMs: watch.elapsedMilliseconds,
    );
    emit('begin');
    final timer = Timer.periodic(const Duration(seconds: 2), (_) {
      emit('waiting');
    });
    trace.timers.add(timer);
    return runZoned(() async {
      try {
        final result = await action();
        emit('end');
        return result;
      } catch (_) {
        emit('error');
        rethrow;
      } finally {
        timer.cancel();
        trace.timers.remove(timer);
        watch.stop();
      }
    }, zoneValues: {_spanKey: span});
  }

  static void event(String stage, {int? status}) {
    if (!kDebugMode && observerFactories.isEmpty) return;
    final trace = _trace;
    if (trace == null || trace.closed) return;
    trace.emit(stage, 'event', ++trace.nextSpan, currentSpanId, status: status);
  }
}

class _TimingTrace {
  _TimingTrace(this.id, this.sink, this.observers);

  final String id;
  final void Function(String) sink;
  final List<ConnectionTimingObserver> observers;
  final Stopwatch watch = Stopwatch()..start();
  final Set<Timer> timers = <Timer>{};
  int nextSpan = 0;
  bool closed = false;

  void emit(
    String stage,
    String event,
    int span,
    int? parent, {
    int durationMs = 0,
    int? status,
  }) {
    if (closed) return;
    for (final observer in observers) {
      try {
        observer(stage, event, durationMs, status);
      } catch (_) {
        // Collection failure must never change a VPN operation.
      }
    }
    try {
      sink(
        'FuzeVpnTiming ${jsonEncode(<String, Object?>{'source': 'flutter', 'trace_id': id, 'span_id': span, 'parent_span_id': parent, 'stage': stage, 'event': event, 'elapsed_ms': watch.elapsedMilliseconds, 'duration_ms': durationMs, if (status != null) 'status': status})}',
      );
    } catch (_) {
      // Diagnostics must never change the outcome of the operation.
    }
  }
}
