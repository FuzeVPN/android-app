import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/review_prompt.dart';

void main() {
  final DateTime now = DateTime.utc(2026, 11, 19, 12);

  test('the first request needs five successful connections', () {
    var state = const ReviewPromptState();
    for (var i = 0; i < 4; i++) {
      state = state.withConnection();
      expect(state.isDue(now), isFalse);
    }
    state = state.withConnection();
    expect(state.connections, 5);
    expect(state.isDue(now), isTrue);
  });

  test('then 4 weeks after the first, 3 months after the second, then never', () {
    final ReviewPromptState first = const ReviewPromptState(
      connections: 5,
    ).requested(now);
    expect(first.isDue(now.add(const Duration(days: 27))), isFalse);
    expect(first.isDue(now.add(const Duration(days: 28))), isTrue);

    final DateTime secondAt = now.add(const Duration(days: 30));
    final ReviewPromptState second = first.requested(secondAt);
    expect(second.isDue(secondAt.add(const Duration(days: 89))), isFalse);
    expect(second.isDue(secondAt.add(const Duration(days: 90))), isTrue);

    final ReviewPromptState third = second.requested(
      secondAt.add(const Duration(days: 90)),
    );
    expect(third.requests, ReviewPromptState.maximumRequests);
    expect(third.isDue(now.add(const Duration(days: 3650))), isFalse);
  });

  test('a clock set back keeps the next request waiting', () {
    final ReviewPromptState first = const ReviewPromptState(
      connections: 5,
    ).requested(now);
    expect(first.isDue(now.subtract(const Duration(days: 60))), isFalse);
  });

  test('the record survives its round trip, in UTC', () {
    final ReviewPromptState state = const ReviewPromptState(
      connections: 7,
    ).requested(now.toLocal());
    final ReviewPromptState read = ReviewPromptState.decode(state.encode());
    expect(read.connections, 7);
    expect(read.requests, 1);
    expect(read.lastRequestAt, now);
    expect(read.lastRequestAt!.isUtc, isTrue);
  });

  test('no record is a fresh start; a malformed one never asks', () {
    expect(ReviewPromptState.decode(null).isDue(now), isFalse);
    expect(ReviewPromptState.decode(null).connections, 0);
    for (final String raw in <String>[
      '',
      'not json',
      '[]',
      '{"v":2,"connections":9,"requests":0}',
      '{"v":1,"connections":"9","requests":0}',
      '{"v":1,"connections":9,"requests":-1}',
      '{"v":1,"connections":9,"requests":1}',
      '{"v":1,"connections":9,"requests":1,"last_request_at":"yesterday"}',
    ]) {
      final ReviewPromptState state = ReviewPromptState.decode(raw);
      expect(state.isDue(now.add(const Duration(days: 3650))), isFalse,
          reason: raw);
    }
  });

  test('counting stops well past the threshold', () {
    var state = const ReviewPromptState(connections: 1000);
    state = state.withConnection();
    expect(state.connections, 1000);
  });
}
