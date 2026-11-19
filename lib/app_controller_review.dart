part of 'app_controller.dart';

/// Google Play's review card (In-App Review API), asked for after a stop the
/// user requested, once enough connections succeeded, then spaced out as
/// [ReviewPromptState] says. Optional and silent: a platform without it, a
/// storage failure or Play's refusal shows nothing and never touches the VPN.
extension _ReviewPrompt on VpnAppController {
  InAppReviewGateway? get _reviewGateway =>
      _tunnel is InAppReviewGateway ? _tunnel as InAppReviewGateway : null;

  /// A tunnel that comes up counts once; the recovery or the restore of a
  /// connection already counted does not count again.
  void _noteTunnelForReview(VpnRuntimeState previous, VpnRuntimeState state) {
    if (state.phase != VpnRuntimePhase.connected ||
        previous.phase == VpnRuntimePhase.connected ||
        previous.isWireGuardRecovery ||
        previous.messageCode == 'openvpn_reconnecting' ||
        previous.messageCode == 'system_vpn_restoring') {
      return;
    }
    _updateReviewPrompt((ReviewPromptState current) async {
      return current.withConnection();
    });
  }

  /// The user's own stop has left the tunnel stopped, without an error.
  void _afterUserStop() {
    if (_disposed ||
        tunnelState.phase != VpnRuntimePhase.idle ||
        tunnelState.messageCode != null) {
      return;
    }
    _updateReviewPrompt((ReviewPromptState current) async {
      final DateTime now = DateTime.now();
      final InAppReviewGateway? gateway = _reviewGateway;
      if (gateway == null ||
          _disposed ||
          _appInBackground ||
          !current.isDue(now)) {
        return null;
      }
      return await gateway.requestInAppReview() ? current.requested(now) : null;
    });
  }

  /// Where the stop goes through Android's VPN settings (Android 8 and 9, a
  /// permanent VPN), the request waits for the return to the app, and only
  /// follows a tunnel actually stopped there.
  void _afterReturnFromVpnSettings() {
    if (!_reviewAfterStopInSettings) return;
    _reviewAfterStopInSettings = false;
    _afterUserStop();
  }

  void _updateReviewPrompt(
    Future<ReviewPromptState?> Function(ReviewPromptState current) change,
  ) {
    final InAppReviewGateway? gateway = _reviewGateway;
    if (gateway == null) return;
    _reviewPromptWrites = _reviewPromptWrites.then((_) async {
      try {
        final ReviewPromptState current = ReviewPromptState.decode(
          await gateway.readReviewPromptState(),
        );
        final ReviewPromptState? next = await change(current);
        if (next != null) await gateway.writeReviewPromptState(next.encode());
      } catch (_) {
        // Optional: a storage or Play failure is never shown or retried.
      }
    });
  }
}
