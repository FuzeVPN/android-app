part of 'app_controller.dart';

/// Split tunneling: the apps kept out of the VPN. A change is saved at once;
/// native code applies the saved list to each new tunnel, whoever starts it.
/// A tunnel already up keeps the list it started with until it reconnects,
/// which [reconnectToApplyExcludedApps] offers.
extension VpnSplitTunnel on VpnAppController {
  SplitTunnelGateway? get _splitTunnelGateway =>
      _tunnel is SplitTunnelGateway ? _tunnel as SplitTunnelGateway : null;

  bool get supportsSplitTunneling => _splitTunnelGateway != null;

  /// The apps saved as excluded; empty until read.
  Set<String> get excludedApps => _excludedApps;
  bool get excludedAppsLoaded => _excludedAppsLoaded;
  bool get excludedAppsSaving => _excludedAppWritesPending > 0;

  /// The connected tunnel started with another list than the one saved: the
  /// saved one applies from the next connection.
  bool get excludedAppsAwaitReconnect {
    final List<String>? applied = tunnelState.excludedApps;
    return _excludedAppsLoaded &&
        tunnelState.isConnected &&
        applied != null &&
        !setEquals(applied.toSet(), _excludedApps);
  }

  /// Android's « Block connections without VPN » is on: Android then cuts the
  /// network of every excluded app. Known only while this app's VPN is up.
  bool get excludedAppsBlockedByLockdown =>
      _excludedApps.isNotEmpty && systemProtection.lockdown == true;

  Future<void> _initializeExcludedApps() => loadExcludedApps();

  /// Reads the saved list once; a failed read can be retried.
  Future<void> loadExcludedApps() async {
    final SplitTunnelGateway? gateway = _splitTunnelGateway;
    if (_disposed || _excludedAppsLoaded || gateway == null) return;
    final Future<void> read = _excludedAppsRead ??= Future<void>.microtask(
      () => _readExcludedApps(gateway),
    );
    excludedAppsLoadFailed = false;
    notifyListeners();
    await read.timeout(
      const Duration(seconds: 4),
      onTimeout: () {
        if (!_disposed && !_excludedAppsLoaded) {
          excludedAppsLoadFailed = true;
          notifyListeners();
        }
      },
    );
  }

  Future<void> _readExcludedApps(SplitTunnelGateway gateway) async {
    final int epoch = _excludedAppsEpoch;
    try {
      final Set<String> saved = ExcludedApps.checked(
        await gateway.readExcludedApps(),
      );
      if (_disposed || epoch != _excludedAppsEpoch) return;
      _excludedApps = saved;
      _savedExcludedApps = saved;
      _excludedAppsLoaded = true;
      excludedAppsLoadFailed = false;
    } catch (_) {
      if (!_disposed && epoch == _excludedAppsEpoch) {
        excludedAppsLoadFailed = true;
      }
    } finally {
      _excludedAppsRead = null;
      if (!_disposed) notifyListeners();
    }
  }

  /// Optimistic, with ordered durable writes: a failure restores the last
  /// saved list, and a late result never overwrites a newer choice.
  Future<void> setAppExcluded(String packageName, bool excluded) async {
    final SplitTunnelGateway? gateway = _splitTunnelGateway;
    if (_disposed || !_excludedAppsLoaded || gateway == null) return;
    final Set<String> next;
    try {
      final Set<String> updated = Set<String>.of(_excludedApps);
      if (excluded) {
        updated.add(packageName);
      } else {
        updated.remove(packageName);
      }
      next = ExcludedApps.checked(updated);
    } catch (_) {
      excludedAppsSaveFailed = true;
      notifyListeners();
      return;
    }
    if (setEquals(next, _excludedApps)) return;
    final int epoch = ++_excludedAppsEpoch;
    _excludedApps = next;
    _excludedAppWritesPending++;
    excludedAppsSaveFailed = false;
    notifyListeners();
    final Future<void> write = _excludedAppWrites.then((_) async {
      try {
        await gateway.writeExcludedApps(next);
        _savedExcludedApps = next;
        if (!_disposed && epoch == _excludedAppsEpoch) {
          excludedAppsSaveFailed = false;
        }
      } catch (_) {
        if (!_disposed && epoch == _excludedAppsEpoch) {
          _excludedApps = _savedExcludedApps;
          excludedAppsSaveFailed = true;
        }
      } finally {
        _excludedAppWritesPending--;
        if (!_disposed) notifyListeners();
      }
    });
    _excludedAppWrites = write;
    await write;
  }

  /// The apps the screen offers: those with an icon in the launcher.
  Future<List<InstalledApp>> launchableApps() async {
    final SplitTunnelGateway? gateway = _splitTunnelGateway;
    if (gateway == null) return const <InstalledApp>[];
    return gateway.launchableApps();
  }

  Future<Uint8List?> appIcon(String packageName, int sizePx) async {
    final SplitTunnelGateway? gateway = _splitTunnelGateway;
    if (gateway == null) return null;
    try {
      return await gateway.appIcon(packageName, sizePx);
    } catch (_) {
      return null;
    }
  }

  bool get canReconnectToApplyExcludedApps =>
      excludedAppsAwaitReconnect && !excludedAppsSaving && canChangeLocation;

  /// Reconnects the current tunnel at its location, with its protocol, so
  /// that the saved list applies now. Android only applies a list when it
  /// establishes a VPN interface: the traffic stops for a moment.
  Future<void> reconnectToApplyExcludedApps() async {
    if (!canReconnectToApplyExcludedApps) return;
    final String? id =
        tunnelState.locationId ??
        activeDeviceLocation?.id ??
        selectedLocation?.id;
    final Iterable<Location> matches = locations.where(
      (Location location) => location.id == id,
    );
    if (matches.isEmpty) return;
    await changeLocationAndConnect(matches.first, reconnect: true);
  }
}
