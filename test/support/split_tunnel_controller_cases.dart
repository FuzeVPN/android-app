part of '../app_controller_test.dart';

const String _bank = 'org.example.bank';
const String _game = 'com.example.game';

class _SplitTunnelTunnel extends _FakeTunnel implements SplitTunnelGateway {
  Set<String> saved = <String>{};
  final List<Set<String>> writes = <Set<String>>[];
  Object? readFailure;
  Object? writeFailure;

  @override
  Future<Set<String>> readExcludedApps() async {
    final Object? failure = readFailure;
    if (failure != null) throw failure;
    return saved;
  }

  @override
  Future<void> writeExcludedApps(Set<String> packageNames) async {
    writes.add(packageNames);
    final Object? failure = writeFailure;
    if (failure != null) throw failure;
    saved = packageNames;
  }

  @override
  Future<List<InstalledApp>> launchableApps() async => const <InstalledApp>[
    InstalledApp(packageName: _bank, label: 'Bank'),
    InstalledApp(packageName: _game, label: 'Game'),
  ];

  @override
  Future<Uint8List?> appIcon(String packageName, int sizePx) async => null;
}

Future<(_SignedInHarness, _SplitTunnelTunnel)> _splitTunnelHarness({
  Set<String> saved = const <String>{},
}) async {
  final _SplitTunnelTunnel tunnel = _SplitTunnelTunnel()..saved = saved;
  final _SignedInHarness h = await _signedInHarness(withTunnel: tunnel);
  h.api.locationsResult = const [_frankfurt, _frankfurt02];
  await h.controller.refreshLocations();
  return (h, tunnel);
}

/// The tunnel native code reports up at Frankfurt 1, started with [apps].
void _connectedWith(
  _SignedInHarness h,
  List<String>? apps, {
  SystemVpnProtection protection = const SystemVpnProtection(),
}) {
  h.tunnel.state = VpnRuntimeState(
    phase: VpnRuntimePhase.connected,
    protocol: VpnProtocol.wireGuard,
    locationId: _frankfurt.id,
    excludedApps: apps,
    systemProtection: protection,
  );
  h.controller.tunnelState = h.tunnel.state;
}

void splitTunnelControllerTests() {
  group('split tunneling', () {
    test(
      'the saved list is read at start and each change saved at once',
      () async {
        final (h, tunnel) = await _splitTunnelHarness(saved: {_bank});
        addTearDown(h.close);
        expect(h.controller.supportsSplitTunneling, isTrue);
        expect(h.controller.excludedAppsLoaded, isTrue);
        expect(h.controller.excludedApps, {_bank});
        await h.controller.setAppExcluded(_game, true);
        expect(tunnel.writes.last, {_bank, _game});
        expect(h.controller.excludedApps, {_bank, _game});
        await h.controller.setAppExcluded(_bank, false);
        expect(tunnel.writes.last, {_game});
        expect(h.controller.excludedApps, {_game});
        // Nothing changes: nothing is written.
        await h.controller.setAppExcluded(_bank, false);
        expect(tunnel.writes, hasLength(2));
        expect(h.controller.excludedAppsSaveFailed, isFalse);
      },
    );

    test('a refused save restores the saved list and says so', () async {
      final (h, tunnel) = await _splitTunnelHarness(saved: {_bank});
      addTearDown(h.close);
      tunnel.writeFailure = const NativeVpnException(
        'secure_storage_write_failed',
      );
      await h.controller.setAppExcluded(_game, true);
      expect(h.controller.excludedApps, {_bank});
      expect(h.controller.excludedAppsSaveFailed, isTrue);
      tunnel.writeFailure = null;
      await h.controller.setAppExcluded(_game, true);
      expect(h.controller.excludedApps, {_bank, _game});
      expect(h.controller.excludedAppsSaveFailed, isFalse);
    });

    test(
      'anything else than a package name never reaches native code',
      () async {
        final (h, tunnel) = await _splitTunnelHarness();
        addTearDown(h.close);
        await h.controller.setAppExcluded('not a package', true);
        expect(tunnel.writes, isEmpty);
        expect(h.controller.excludedApps, isEmpty);
        expect(h.controller.excludedAppsSaveFailed, isTrue);
      },
    );

    test(
      'an unreadable list is retried and changes nothing meanwhile',
      () async {
        final _SplitTunnelTunnel tunnel = _SplitTunnelTunnel()
          ..readFailure = const NativeVpnException(
            'secure_storage_read_failed',
          );
        final _SignedInHarness h = await _signedInHarness(withTunnel: tunnel);
        addTearDown(h.close);
        expect(h.controller.excludedAppsLoaded, isFalse);
        expect(h.controller.excludedAppsLoadFailed, isTrue);
        await h.controller.setAppExcluded(_bank, true);
        expect(tunnel.writes, isEmpty);
        tunnel
          ..readFailure = null
          ..saved = {_game};
        await h.controller.loadExcludedApps();
        expect(h.controller.excludedAppsLoaded, isTrue);
        expect(h.controller.excludedApps, {_game});
      },
    );

    test('a tunnel started with another list offers a reconnection at its '
        'location, which is not a stop by the user', () async {
      final (h, tunnel) = await _splitTunnelHarness();
      addTearDown(h.close);
      _connectedWith(h, const <String>[]);
      expect(h.controller.excludedAppsAwaitReconnect, isFalse);
      await h.controller.setAppExcluded(_bank, true);
      expect(h.controller.excludedAppsAwaitReconnect, isTrue);
      expect(h.controller.canReconnectToApplyExcludedApps, isTrue);
      await h.controller.reconnectToApplyExcludedApps();
      expect(tunnel.disconnectCalls, 1);
      expect(tunnel.disconnectByUserCalls, 0);
      expect(tunnel.wireGuardConnections, hasLength(1));
      expect(h.controller.selectedLocation?.id, _frankfurt.id);
      // Native code reports the new tunnel with the saved list.
      _connectedWith(h, const <String>[_bank]);
      expect(h.controller.excludedAppsAwaitReconnect, isFalse);
      expect(h.controller.canReconnectToApplyExcludedApps, isFalse);
    });

    test('without a connected tunnel, or a list it did not name, nothing is '
        'offered', () async {
      final (h, tunnel) = await _splitTunnelHarness(saved: {_bank});
      addTearDown(h.close);
      expect(h.controller.excludedAppsAwaitReconnect, isFalse);
      await h.controller.reconnectToApplyExcludedApps();
      expect(tunnel.wireGuardConnections, isEmpty);
      _connectedWith(h, null);
      expect(h.controller.excludedAppsAwaitReconnect, isFalse);
      _connectedWith(h, const <String>[_bank]);
      expect(h.controller.excludedAppsAwaitReconnect, isFalse);
      h.controller.tunnelState = VpnRuntimeState(
        phase: VpnRuntimePhase.connecting,
        protocol: VpnProtocol.wireGuard,
        excludedApps: const <String>[],
      );
      expect(h.controller.excludedAppsAwaitReconnect, isFalse);
    });

    test('Android blocking connections without VPN is reported only for '
        'excluded apps', () async {
      final (h, _) = await _splitTunnelHarness();
      addTearDown(h.close);
      const SystemVpnProtection lockdown = SystemVpnProtection(
        alwaysOn: true,
        lockdown: true,
      );
      _connectedWith(h, const <String>[], protection: lockdown);
      expect(h.controller.excludedAppsBlockedByLockdown, isFalse);
      await h.controller.setAppExcluded(_bank, true);
      expect(h.controller.excludedAppsBlockedByLockdown, isTrue);
      _connectedWith(
        h,
        const <String>[],
        protection: const SystemVpnProtection(alwaysOn: true, lockdown: false),
      );
      expect(h.controller.excludedAppsBlockedByLockdown, isFalse);
      // Unknown (no tunnel of this app): never presented as on.
      _connectedWith(h, const <String>[]);
      expect(h.controller.excludedAppsBlockedByLockdown, isFalse);
    });

    test('a platform without split tunneling offers nothing', () async {
      final _SignedInHarness h = await _signedInHarness();
      addTearDown(h.close);
      expect(h.controller.supportsSplitTunneling, isFalse);
      expect(await h.controller.launchableApps(), isEmpty);
      await h.controller.setAppExcluded(_bank, true);
      expect(h.controller.excludedApps, isEmpty);
    });
  });
}
