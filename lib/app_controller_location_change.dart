part of 'app_controller.dart';

extension VpnLocationChange on VpnAppController {
  /// Opaque account-session identity for a confirmation dialog's ABA guard.
  Object get locationChangeSessionIdentity => _sessionOperation;

  bool get isChangingLocation => _locationChangeOperation != null;

  /// The confirmed location change still running, for its progress card.
  LocationChangeProgress? get locationChangeProgress {
    final change = _locationChangeOperation;
    if (change == null || change.finished || !change.isCurrent) return null;
    return LocationChangeProgress(
      sourceLocationId: change.sourceLocationId,
      targetLocationId: change.targetLocationId,
      protocol: change.protocol,
      activating: change.activating,
    );
  }

  /// Whether the connection page shows the location-change card: a server
  /// migration, or any OpenVPN change, with or without one. A WireGuard change
  /// takes under a second and the connection card already states it.
  bool get showsLocationChangeProgress =>
      locationMigration != null ||
      locationChangeProgress?.protocol == VpnProtocol.openVpn;

  // The server reported its new node activating, or ready, during this change:
  // the card never goes back to its preparation step afterwards.
  void _noteLocationChangeActivation() {
    final change = _locationChangeOperation;
    if (change != null && !change.finished) change.activating = true;
  }

  bool get canChangeLocation =>
      !_disposed &&
      _sessionOperation.isCurrent &&
      isSignedIn &&
      _session != null &&
      _sessionLive(_session!) &&
      sessionTermination == null &&
      !isInitializing &&
      !isAuthenticating &&
      !isChangingLocation &&
      !isConnecting &&
      !isIdentityBusy &&
      !isRevoking &&
      _disconnectsInFlight == 0 &&
      openVpnRevocation == null &&
      !isLocationMigrationLocked &&
      (tunnelState.phase == VpnRuntimePhase.idle ||
          tunnelState.phase == VpnRuntimePhase.error ||
          tunnelState.phase == VpnRuntimePhase.connected ||
          tunnelState.isReconnecting);

  void _cancelLocationChange() {
    final change = _locationChangeOperation;
    final migration = _migrationContext;
    final saved = migration?.value;
    change?.invalidate();
    // The abandoned continuation keeps its own object and stops at its next
    // check; controls are released now, not when its request returns.
    if (change != null) {
      change.finished = true;
      _locationChangeOperation = null;
    }
    _networkAttemptEpoch++;
    // A cancelled migration may finish server-side, but its stale completion
    // must never continue this connection or replace a newer screen's state.
    _resetMigration();
    _connectionOwner = null;
    isConnecting = false;
    // Keep a known server-side migration visible and locked after cancelling
    // this continuation. Rebind only its record; the old asynchronous owner
    // stays invalid and cannot restart a tunnel.
    if (saved != null && migration != null && migration.isAccountCurrent) {
      _migrationScope().value = saved;
    }
  }

  Future<void> changeLocationAndConnect(Location location) async {
    if (!canChangeLocation) return;
    final candidates = locations.where((item) => item.id == location.id);
    final Location? target = candidates.isEmpty ? null : candidates.first;
    final protocol = isTunnelActive
        ? tunnelState.protocol ?? selectedProtocol
        : selectedProtocol;
    if (target == null || !target.supports(protocol)) {
      notice = _controllerNotice('protocol_unavailable_at_location');
      notifyListeners();
      return;
    }
    final activeLocation =
        tunnelState.locationId ??
        activeDeviceLocation?.id ??
        selectedLocation?.id;
    if (isConnected && activeLocation == target.id) return;
    // Renew a guest token about to expire while the current tunnel still
    // runs: a refused renewal leaves that tunnel untouched, with a notice.
    if (_guestSessionNearExpiry) {
      if (await _renewGuestSession() != _GuestRecovery.admitted) {
        notice = const AppNotice(
          titleKey: 'billing.title',
          messageKey: 'guest.serviceUnavailable',
        );
        notifyListeners();
        return;
      }
      if (!canChangeLocation) return;
    }

    final lineage = _sessionOperation.lineage;
    final account = profile?.userId;
    final device = currentDeviceId;
    final deviceEpoch = _deviceEpoch;
    late final _LocationChangeOperation change;
    // A guest token renewal keeps the account lineage: the confirmed change
    // continues with the new token. Any other session change cancels it.
    change = _LocationChangeOperation(
      sourceLocationId: activeLocation,
      targetLocationId: target.id,
      protocol: protocol,
      matches: () =>
          !_disposed &&
          _sessionOperation.isCurrent &&
          identical(lineage, _sessionOperation.lineage) &&
          (change.finished || identical(change, _locationChangeOperation)) &&
          profile?.userId == account &&
          _session != null &&
          _sessionLive(_session!) &&
          (change.connecting ||
              (currentDeviceId == device && _deviceEpoch == deviceEpoch)),
    );
    _locationChangeOperation = change;
    _clearNoticeForAttempt();
    notifyListeners();
    try {
      change.check();
      // Error also needs a confirmed native stop: its runtime may still exist.
      if (tunnelState.phase != VpnRuntimePhase.idle) {
        await disconnect(cancelPendingConnection: false);
        change.check();
        if (tunnelState.phase != VpnRuntimePhase.idle) return;
      }
      change.check();
      _resetMigration();
      if (selectedProtocol != protocol) {
        await _selectProtocol(protocol);
        change.check();
      }
      await _selectLocation(target);
      change.check();
      if (isIdentityBusy ||
          isConnecting ||
          _disconnectsInFlight > 0 ||
          selectedLocation?.id != target.id ||
          selectedProtocol != protocol ||
          tunnelState.phase != VpnRuntimePhase.idle) {
        return;
      }
      final preferenceNotice =
          notice?.messageKey == 'notice.preferenceSave.message' ? notice : null;
      // Existing connect owns device creation/migration from this point onward;
      // its identity and network-attempt guards validate those expected changes.
      change.connecting = true;
      if (await _connect(locationChange: change)) {
        await _connect(locationChange: change, afterGuestRenewal: true);
      }
      change.check();
      if (notice == null && preferenceNotice != null) notice = preferenceNotice;
    } on SessionOperationCancelled {
      // Cancellation, a different account or a user stop never schedules a retry.
      // A registered token that expired during the change ends like any expiry
      // the device clock finds, never as a silent stop (A13-dart-vpn-01).
      final AuthSession? current = _session;
      if (!_disposed &&
          sessionTermination == null &&
          _sessionOperation.isCurrent &&
          identical(lineage, _sessionOperation.lineage) &&
          profile?.userId == account &&
          profile?.isGuest == false &&
          profile?.profileRedacted == false &&
          current != null &&
          !_sessionLive(current)) {
        await _terminateSession(expired: true);
      }
    } finally {
      if (identical(_locationChangeOperation, change)) {
        change.finished = true;
        _locationChangeOperation = null;
        notifyListeners();
      }
    }
  }
}

/// Where a confirmed location change goes, with which protocol, and whether
/// the server already reported the new node activating.
class LocationChangeProgress {
  const LocationChangeProgress({
    required this.sourceLocationId,
    required this.targetLocationId,
    required this.protocol,
    this.activating = false,
  });

  final String? sourceLocationId;
  final String targetLocationId;
  final VpnProtocol protocol;
  final bool activating;
}

class _LocationChangeOperation extends SessionOperation {
  _LocationChangeOperation({
    required this.sourceLocationId,
    required this.targetLocationId,
    required this.protocol,
    required this.matches,
  });
  final String? sourceLocationId;
  final String targetLocationId;
  final VpnProtocol protocol;
  final bool Function() matches;
  bool activating = false;
  bool connecting = false;
  bool finished = false;

  @override
  bool get isCurrent => super.isCurrent && matches();

  @override
  void check() {
    if (!isCurrent) throw const SessionOperationCancelled();
  }
}
