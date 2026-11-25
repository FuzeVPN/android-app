part of 'app_controller.dart';

/// The account's ad blocker (DNS filter contract v1): one choice kept by the
/// server for every device of the account, applied by the nodes' resolver
/// within seconds. Nothing is stored on the device or sent to native code,
/// and the tunnel never reconnects. What is known belongs to one account
/// session (its lineage): another admission reads the choice again.
extension VpnAdBlocker on VpnAppController {
  DnsFilterApiRepository? get _dnsFilterApi =>
      _api is DnsFilterApiRepository ? _api as DnsFilterApiRepository : null;

  /// The current session's state, or null when nothing was read for it.
  _AdBlockerState? get _adBlocker {
    final _AdBlockerState? state = _adBlockerState;
    final SessionOperation operation = _sessionOperation;
    return state != null &&
            operation.isCurrent &&
            identical(state.lineage, operation.lineage)
        ? state
        : null;
  }

  bool get _adBlockerSupported => _dnsFilterApi != null && token != null;

  /// The switch: the choice being saved, else the account's; null until read.
  bool? get adBlocking {
    final _AdBlockerState? state = _adBlocker;
    return state?.pending ?? state?.settings?.adBlocking;
  }

  /// False while the service has turned the blocker off for everyone.
  bool get adBlockerAvailable => _adBlocker?.settings?.available ?? true;

  bool get adBlockerBusy {
    final _AdBlockerState? state = _adBlocker;
    return state != null && (state.loading || state.pending != null);
  }

  bool get adBlockerLoadFailed => _adBlocker?.loadFailed ?? false;
  bool get adBlockerSaveFailed => _adBlocker?.saveFailed ?? false;

  /// Nothing was read yet for the current session.
  bool get adBlockerNeedsLoad => supportsAdBlocker && _adBlocker == null;

  /// Reads the account's choice; a failed read can be retried.
  Future<void> loadAdBlocker() async {
    final DnsFilterApiRepository? api = _dnsFilterApi;
    final SessionOperation operation = _sessionOperation;
    if (_disposed || api == null || token == null || !operation.isCurrent) {
      return;
    }
    final _AdBlockerState state =
        _adBlocker ?? (_adBlockerState = _AdBlockerState(operation.lineage));
    if (state.loading || state.pending != null) return;
    state.loading = true;
    state.loadFailed = false;
    notifyListeners();
    try {
      final DnsFilterSettings? settings = await _adBlockerRequest(
        operation,
        api.dnsFilter,
      );
      if (settings != null) {
        state.settings = settings;
      } else {
        state.loadFailed = true;
      }
    } finally {
      state.loading = false;
      if (!_disposed) notifyListeners();
    }
  }

  /// Saves [enabled] for the account. The switch shows it at once; a failure
  /// puts back the account's choice and says so.
  Future<void> setAdBlocking(bool enabled) async {
    final DnsFilterApiRepository? api = _dnsFilterApi;
    final SessionOperation operation = _sessionOperation;
    final _AdBlockerState? state = _adBlocker;
    final DnsFilterSettings? saved = state?.settings;
    if (_disposed ||
        api == null ||
        state == null ||
        saved == null ||
        state.loading ||
        state.pending != null ||
        saved.adBlocking == enabled) {
      return;
    }
    state.pending = enabled;
    state.saveFailed = false;
    notifyListeners();
    try {
      final DnsFilterSettings? settings = await _adBlockerRequest(
        operation,
        (String token) =>
            api.updateDnsFilter(token: token, adBlocking: enabled),
      );
      if (settings != null) {
        state.settings = settings;
      } else {
        state.saveFailed = true;
      }
    } finally {
      state.pending = null;
      if (!_disposed) notifyListeners();
    }
  }

  /// [request] with the session's access, renewed first when it expires soon.
  /// Null when it failed: a refused access ends the session as for any
  /// account request, and an ended or replaced session makes no difference.
  Future<DnsFilterSettings?> _adBlockerRequest(
    SessionOperation operation,
    Future<DnsFilterSettings> Function(String token) request,
  ) async {
    try {
      if (_accessDueForRenewal && !await _renewAccessForOperation()) {
        return null;
      }
      operation.check();
      final DnsFilterSettings settings = await _authorized(request);
      operation.check();
      return settings;
    } on ApiFailure catch (error) {
      try {
        await _handleSessionFailure(error, operation);
      } on SessionOperationCancelled {
        // The session ended or was replaced meanwhile.
      }
      return null;
    } on SessionOperationCancelled {
      return null;
    }
  }
}

/// What this app knows of the ad blocker during one account session.
class _AdBlockerState {
  _AdBlockerState(this.lineage);

  final Object lineage;

  /// The server's last answer.
  DnsFilterSettings? settings;

  /// The choice being saved.
  bool? pending;
  bool loading = false;
  bool loadFailed = false;
  bool saveFailed = false;
}
