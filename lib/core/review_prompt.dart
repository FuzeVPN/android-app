import 'dart:convert';

/// When the app asks Google Play for its own review card (In-App Review API),
/// and the state that spaces these requests. Play alone decides whether the
/// card is shown and never tells the answer, so a request counts once Play
/// has launched its flow.
///
/// - First request: after a disconnection the user asked for, once
///   [minimumConnections] successful connections have been seen.
/// - Second: [delays] first (4 weeks) after the first request.
/// - Third and last: [delays] last (3 months, 90 days) after the second.
class ReviewPromptState {
  const ReviewPromptState({
    this.connections = 0,
    this.requests = 0,
    this.lastRequestAt,
  });

  /// A record that cannot be read never makes the app ask again.
  const ReviewPromptState.exhausted() : this(requests: maximumRequests);

  static const int minimumConnections = 5;
  static const List<Duration> delays = <Duration>[
    Duration(days: 28),
    Duration(days: 90),
  ];
  static const int maximumRequests = 3;

  // Counting stops well past the threshold: the record stays small.
  static const int _connectionCap = 1000;

  final int connections;
  final int requests;
  final DateTime? lastRequestAt;

  bool isDue(DateTime now) {
    if (requests >= maximumRequests || connections < minimumConnections) {
      return false;
    }
    if (requests == 0) return true;
    final DateTime? last = lastRequestAt;
    // A clock set back keeps the next request waiting rather than asking early.
    return last != null && !now.isBefore(last.add(delays[requests - 1]));
  }

  ReviewPromptState withConnection() => ReviewPromptState(
    connections: connections >= _connectionCap ? connections : connections + 1,
    requests: requests,
    lastRequestAt: lastRequestAt,
  );

  ReviewPromptState requested(DateTime now) => ReviewPromptState(
    connections: connections,
    requests: requests + 1,
    lastRequestAt: now.toUtc(),
  );

  String encode() => jsonEncode(<String, Object?>{
    'v': 1,
    'connections': connections,
    'requests': requests,
    'last_request_at': lastRequestAt?.toUtc().toIso8601String(),
  });

  /// No record yet is a fresh state; a malformed one is [exhausted].
  static ReviewPromptState decode(String? raw) {
    if (raw == null) return const ReviewPromptState();
    try {
      final Object? data = jsonDecode(raw);
      if (data is! Map<String, Object?> || data['v'] != 1) {
        return const ReviewPromptState.exhausted();
      }
      final Object? connections = data['connections'];
      final Object? requests = data['requests'];
      final Object? last = data['last_request_at'];
      if (connections is! int ||
          requests is! int ||
          connections < 0 ||
          requests < 0 ||
          (last != null && last is! String) ||
          (requests > 0 && last == null)) {
        return const ReviewPromptState.exhausted();
      }
      return ReviewPromptState(
        connections: connections,
        requests: requests,
        lastRequestAt: last == null ? null : DateTime.parse(last as String),
      );
    } on FormatException {
      return const ReviewPromptState.exhausted();
    }
  }
}
