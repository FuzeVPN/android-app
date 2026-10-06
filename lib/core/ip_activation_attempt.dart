import 'api_exception.dart';
import 'session_lifecycle.dart';

/// One explicit action, shared by enrollment, profile creation and renewal.
class IpActivationAttempt {
  IpActivationAttempt({
    required this.matches,
    required this.deviceId,
    required this.deviceEpoch,
  });
  final bool Function(IpActivationAttempt) matches;
  String? deviceId;
  int deviceEpoch;
  bool requestIpv6 = false;
  bool fellBack = false;

  void check() {
    if (!matches(this)) throw const SessionOperationCancelled();
  }

  Future<T> request<T>(
    Future<T> Function(bool ipv6) send, {
    void Function()? checkIdentity,
  }) async {
    void guard() {
      check();
      checkIdentity?.call();
    }

    guard();
    try {
      final result = await send(requestIpv6);
      guard();
      return result;
    } on ApiFailure catch (error) {
      guard();
      if (!requestIpv6 ||
          fellBack ||
          error.statusCode != 503 ||
          error.code != 'ipv6_unavailable') {
        rethrow;
      }
      requestIpv6 = false;
      fellBack = true;
      try {
        final result = await send(false);
        guard();
        return result;
      } catch (_) {
        guard();
        rethrow;
      }
    } catch (_) {
      guard();
      rethrow;
    }
  }
}
