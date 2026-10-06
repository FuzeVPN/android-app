part of '../app_controller_test.dart';

const _roamingLocations = [
  Location(
    id: 'frankfurt-01',
    city: 'Frankfurt',
    countryCode: 'DE',
    displayName: 'Frankfurt 1',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
    supportsIpv6: true,
  ),
  Location(
    id: 'frankfurt-02',
    city: 'Frankfurt',
    countryCode: 'DE',
    displayName: 'Frankfurt 2',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
    supportsIpv6: true,
  ),
  Location(
    id: 'philadelphia-01',
    city: 'Philadelphia',
    countryCode: 'US',
    displayName: 'Philadelphia 1',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
    supportsIpv6: true,
  ),
];

// Format-valid, deterministic public-key fixtures; no cryptography is executed.
final _roamingServerKeys = List<String>.generate(
  3,
  (node) => base64Encode(List<int>.filled(32, node + 1)),
);
final _roamingClientPublicKey = base64Encode(
  List<int>.generate(32, (index) => index + 64),
);

/// Scripted API responses for controller sequencing and configuration forwarding.
/// Readiness and network allocation are fixture inputs, not observations of a
/// running control plane, agents, or WireGuard transport.
class _RoamingApi extends _FakeApi {
  _RoamingApi({this.dualStack = true}) {
    locationsResult = _roamingLocations;
    profilesByToken['session-a'] = _profile('user-a');
    loginResult = _session('session-a');
  }
  final bool dualStack;
  int? node;
  int? ipv6Node;
  int? destination;
  int polls = 0;
  int gatewayStartsWhilePending = 0;
  bool blockMigration = false;
  bool sourceSynchronized = true;
  bool targetSynchronized = true;
  DeviceLocationMigration? migration;
  final order = <String>[];

  @override
  Future<DeviceList> listDevices(String token) async {
    await pause('listDevices');
    return node == null
        ? const DeviceList(limit: 2, devices: [])
        : _devices('roaming-device', location: _roamingLocations[node!]);
  }

  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    await pause('registerDevice');
    if (destination != null) {
      throw const ApiException(
        statusCode: 409,
        errorCode: 'location_migration_pending',
      );
    }
    final target = _roamingLocations.indexWhere((v) => v.id == locationId);
    // Fixture for the corrected API: each enrollment returns target addresses.
    ipv6Node = target;
    node = target;
    registerDeviceCalls.add(
      _RegisterDeviceCall(
        token: token,
        name: name,
        publicKey: publicKey,
        locationId: locationId,
      ),
    );
    ipRequests.add(('registerDevice', requestIpv6));
    order.add('register:$locationId');
    return DeviceConfiguration.fromJson({
      'device_id': 'roaming-device',
      'address': '10.${target + 10}.0.2/32',
      'dns': ['1.1.1.1'],
      'server_public_key': _roamingServerKeys[target],
      'endpoint': '198.51.100.${target + 1}:51820',
      'allowed_ips': ['0.0.0.0/0', if (dualStack) '::/0'],
      if (dualStack) 'ip_families': ['ipv4', 'ipv6'],
      if (dualStack)
        'addresses': [
          '10.${target + 10}.0.2/32',
          'fd0d:295d:995b:${ipv6Node! * 2 + 1}::2/128',
        ],
    });
  }

  @override
  Future<DeviceLocationMigration> startLocationMigration({
    required String token,
    required String deviceId,
    required String locationId,
  }) async {
    await pause('startLocationMigration');
    startMigrationCalls.add(
      _LocationMigrationCall(
        token: token,
        deviceId: deviceId,
        locationId: locationId,
      ),
    );
    // The API can reject either node's readiness before creating a migration.
    // This models that response boundary only, not why a real node is unready.
    if (!sourceSynchronized || !targetSynchronized) {
      order.add('migration-rejected:$locationId');
      throw const ApiException(
        statusCode: 503,
        errorCode: 'target_unavailable',
      );
    }
    destination = _roamingLocations.indexWhere((v) => v.id == locationId);
    polls = 0;
    order.add('migration:$locationId');
    return migration = DeviceLocationMigration(
      migrationId: 'roaming-${startMigrationCalls.length}',
      deviceId: deviceId,
      sourceLocationId: _roamingLocations[node!].id,
      targetLocationId: locationId,
      status: LocationMigrationStatus.draining,
      retryAfterSeconds: 0,
    );
  }

  @override
  Future<DeviceLocationMigration> getLocationMigration({
    required String token,
    required String deviceId,
    required String migrationId,
  }) async {
    await pause('getLocationMigration');
    _throwIf(getMigrationFailure);
    migrationPollCalls.add(
      _LocationMigrationPollCall(
        token: token,
        deviceId: deviceId,
        migrationId: migrationId,
      ),
    );
    final ready = ++polls == 2 && !blockMigration;
    if (ready) {
      node = destination;
      ipv6Node = destination;
      destination = null;
    }
    final previous = migration!;
    order.add(ready ? 'ready' : 'activating');
    return migration = DeviceLocationMigration(
      migrationId: previous.migrationId,
      deviceId: deviceId,
      sourceLocationId: previous.sourceLocationId,
      targetLocationId: previous.targetLocationId,
      status: blockMigration
          ? LocationMigrationStatus.blocked
          : ready
          ? LocationMigrationStatus.ready
          : LocationMigrationStatus.activating,
      retryAfterSeconds: 0,
    );
  }
}

class _RoamingTunnel extends _FakeTunnel {
  _RoamingTunnel(this.api) {
    wireGuardPublicKey = _roamingClientPublicKey;
  }
  final _RoamingApi api;
  @override
  Future<void> disconnect() async {
    api.order.add('stop');
    await super.disconnect();
  }

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async {
    if (api.destination != null) api.gatewayStartsWhilePending++;
    api.order.add('gateway-connect:${location.id}');
    await super.connectWireGuard(
      accountId: accountId,
      configuration: configuration,
      location: location,
    );
    // Supply a scripted gateway event so the next controller action can run.
    // The fake never infers handshake success or failure from inner addresses.
    emitConnected(VpnProtocol.wireGuard);
  }
}

void _expectRoamingConfiguration(
  DeviceConfiguration configuration, {
  required int target,
  required bool dualStack,
}) {
  expect(configuration.deviceId, 'roaming-device');
  expect(configuration.endpoint, '198.51.100.${target + 1}:51820');
  expect(configuration.serverPublicKey, _roamingServerKeys[target]);
  expect(configuration.address, '10.${target + 10}.0.2/32');
  expect(configuration.network.addresses, [
    '10.${target + 10}.0.2/32',
    if (dualStack) 'fd0d:295d:995b:${target * 2 + 1}::2/128',
  ]);
  expect(configuration.network.ipFamilies, ['ipv4', if (dualStack) 'ipv6']);
  expect(configuration.allowedIps, ['0.0.0.0/0', if (dualStack) '::/0']);
}

Future<_SignedInHarness> _roamingHarness({
  bool dualStack = true,
  Future<void> Function(Duration)? delay,
}) async {
  final api = _RoamingApi(dualStack: dualStack);
  final tunnel = _RoamingTunnel(api);
  final store = _FakeSessionStore();
  final controller = _controller(
    api: api,
    store: store,
    preferences: _FakePreferences(),
    tunnel: tunnel,
    migrationDelay: delay ?? (_) => Future<void>.value(),
  );
  await controller.initialize();
  await controller.signIn(email: 'client@example.test', password: 'secret');
  return _SignedInHarness(
    api: api,
    store: store,
    tunnel: tunnel,
    controller: controller,
  );
}

void wireGuardRoamingTests() {
  group('WireGuard direct enrollment after API correction', () {
    for (final dual in [true, false]) {
      for (var first = 0; first < 3; first++) {
        test(
          'all six directions from $first without migration (dual=$dual)',
          () async {
            final h = await _roamingHarness(
              dualStack: dual,
              delay: (_) => throw StateError('Unexpected migration wait'),
            );
            addTearDown(h.close);
            final api = h.api as _RoamingApi;
            api.hooks['startLocationMigration'] = () async {
              throw StateError('Unexpected migration request');
            };
            final route = [
              first,
              (first + 1) % 3,
              (first + 2) % 3,
              first,
              (first + 2) % 3,
              (first + 1) % 3,
              first,
            ];
            for (final target in route) {
              await h.controller.selectLocation(_roamingLocations[target]);
              await h.controller.connect();
              await Future<void>.delayed(Duration.zero);
              expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
              _expectRoamingConfiguration(
                h.tunnel.wireGuardConnections.last.configuration,
                target: target,
                dualStack: dual,
              );
            }
            expect(h.tunnel.wireGuardConnections, hasLength(7));
            expect(api.registerDeviceCalls, hasLength(7));
            expect(api.startMigrationCalls, isEmpty);
            expect(api.migrationPollCalls, isEmpty);
            expect(api.registerDeviceCalls.map((v) => v.publicKey).toSet(), {
              _roamingClientPublicKey,
            });
            expect(h.controller.currentDeviceId, 'roaming-device');
            expect(h.store.migrations, isEmpty);
            expect(api.revokeDeviceIds, isEmpty);
            expect(api.revokeOpenVpnProfileIds, isEmpty);
            expect(h.tunnel.clearedAccountIds, isEmpty);
            expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
            expect(h.tunnel.openVpnCsrCalls, isEmpty);
            expect(api.order, [
              for (var step = 0; step < route.length; step++) ...[
                if (step != 0) 'stop',
                'register:${_roamingLocations[route[step]].id}',
                'gateway-connect:${_roamingLocations[route[step]].id}',
              ],
            ]);
          },
        );
      }
    }

    test(
      'uncertain stop prevents target enrollment and tunnel replacement',
      () async {
        final h = await _roamingHarness();
        addTearDown(h.close);
        await h.controller.connect();
        await Future<void>.delayed(Duration.zero);
        h.tunnel.disconnectFailure = const NativeVpnException(
          'wireguard_stop_failed',
        );
        await h.controller.selectLocation(_roamingLocations[1]);
        await h.controller.connect();
        expect(h.api.startMigrationCalls, isEmpty);
        expect(h.api.registerDeviceCalls, hasLength(1));
        expect(h.tunnel.wireGuardConnections, hasLength(1));
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.error);
      },
    );

    test('same location reconnects with the existing key', () async {
      final h = await _roamingHarness();
      addTearDown(h.close);
      await h.controller.connect();
      await Future<void>.delayed(Duration.zero);
      await h.controller.disconnect();
      await h.controller.connect();
      expect(h.api.startMigrationCalls, isEmpty);
      expect(h.api.migrationPollCalls, isEmpty);
      expect(h.tunnel.wireGuardConnections, hasLength(2));
      expect(h.api.registerDeviceCalls.map((v) => v.publicKey).toSet(), {
        _roamingClientPublicKey,
      });
    });

    for (final unauthorized in [false, true]) {
      test(
        'late target enrollment (401=$unauthorized) cannot affect next account',
        () async {
          final h = await _roamingHarness();
          addTearDown(h.close);
          await h.controller.connect();
          await Future<void>.delayed(Duration.zero);
          final entered = Completer<void>();
          final release = Completer<void>();
          h.api.hooks['registerDevice'] = () async {
            h.api.hooks.remove('registerDevice');
            entered.complete();
            await release.future;
            if (unauthorized) {
              throw const ApiException(
                statusCode: 401,
                errorCode: 'unauthorized',
              );
            }
          };
          await h.controller.selectLocation(_roamingLocations[1]);
          final connecting = h.controller.connect();
          await entered.future.timeout(const Duration(seconds: 2));
          await h.controller.signOut();
          h.api.loginResult = _session('session-b');
          h.api.profilesByToken['session-b'] = _profile('user-b');
          await h.controller.signIn(
            email: 'b@example.test',
            password: 'fixture',
          );
          final currentNotice = h.controller.notice;
          release.complete();
          await connecting;
          expect(h.controller.token, 'session-b');
          expect(h.controller.notice, currentNotice);
          expect(h.controller.locationMigration, isNull);
          expect(h.store.clearSessionCalls, 1);
          expect(h.api.startMigrationCalls, isEmpty);
          expect(h.api.migrationPollCalls, isEmpty);
          expect(h.tunnel.wireGuardConnections, hasLength(1));
          expect(
            h.api.registerDeviceCalls.every((v) => v.token == 'session-a'),
            isTrue,
          );
        },
      );
    }

    test(
      'network error retries direct enrollment without replacing the key',
      () async {
        final h = await _roamingHarness();
        addTearDown(h.close);
        await h.controller.connect();
        await Future<void>.delayed(Duration.zero);
        h.api.hooks['registerDevice'] = () async {
          h.api.hooks.remove('registerDevice');
          throw const ApiNetworkException();
        };
        await h.controller.selectLocation(_roamingLocations[1]);
        await h.controller.connect();
        expect(h.tunnel.wireGuardConnections, hasLength(1));
        await h.controller.connect();
        await Future<void>.delayed(Duration.zero);
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
        expect(h.api.startMigrationCalls, isEmpty);
        expect(h.api.migrationPollCalls, isEmpty);
        expect(h.tunnel.wireGuardConnections, hasLength(2));
        expect(h.api.registerDeviceCalls.map((v) => v.publicKey).toSet(), {
          _roamingClientPublicKey,
        });
      },
    );
  });
}
