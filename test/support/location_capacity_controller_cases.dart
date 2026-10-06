part of '../app_controller_test.dart';

void locationCapacityControllerTests() {
  group('location capacity recovery', () {
    for (final (status, code) in [
      (409, 'server_full'),
      (503, 'capacity_unavailable'),
    ]) {
      for (final protocol in VpnProtocol.values) {
        for (final refreshResult in ['success', 'stale', 'failure', 'empty']) {
          test(
            '$code registration $protocol hides target and refreshes once ($refreshResult)',
            () async {
              final h = await _capacityHarness();
              addTearDown(h.close);
              await h.controller.selectProtocol(protocol);
              await h.controller.toggleFavoriteLocation(_frankfurt);
              h.api.registerDeviceFailure = ApiException(
                statusCode: status,
                errorCode: code,
              );
              h.api.hooks['registerDevice'] = () async {
                switch (refreshResult) {
                  case 'success':
                    h.api.locationsResult = [_frankfurt02];
                  case 'stale':
                    h.api.locationsResult = [_frankfurt, _frankfurt02];
                  case 'failure':
                    h.api.locationsFailure = const ApiNetworkException();
                  case 'empty':
                    h.api.locationsResult = [];
                }
              };

              await h.controller.connect();

              expect(h.api.catalogueCalls, 2); // IP capability + recovery.
              expect(h.api.registerDeviceCalls, hasLength(1));
              expect(h.tunnel.wireGuardConnections, isEmpty);
              expect(h.tunnel.openVpnConnections, isEmpty);
              expect(h.controller.notice?.arguments['code'], code);
              expect(
                h.controller.locations.map((item) => item.id),
                isNot(contains(_frankfurt.id)),
              );
              expect(
                h.controller.selectedLocation?.id,
                refreshResult == 'empty' ? null : _frankfurt02.id,
              );
              expect(h.controller.isFavoriteLocation(_frankfurt.id), isTrue);
              expect(h.preferences.saved, contains(_frankfurt.id));
              expect(h.controller.isLoadingLocations, isFalse);
              expect(h.controller.isConnecting, isFalse);

              // This is a temporary rejection, not a persistent blacklist.
              h.api.locationsFailure = null;
              h.api.locationsResult = [_frankfurt, _frankfurt02];
              await h.controller.refreshLocations();
              expect(
                h.controller.locations.map((item) => item.id),
                contains(_frankfurt.id),
              );
              expect(h.api.registerDeviceCalls, hasLength(1));
            },
          );
        }
      }

      for (final renewal in [false, true]) {
        test('$code OpenVPN profile (renewal=$renewal) does not retry', () async {
          final h = await _capacityHarness(existingDevice: true);
          addTearDown(h.close);
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          final failure = ApiException(statusCode: status, errorCode: code);
          h.api.createOpenVpnFailure = failure;
          h.api.renewOpenVpnFailure = failure;
          if (renewal) {
            // The profile belongs to the active device, not the next selection.
            await h.controller.selectLocation(_frankfurt02);
            await h.controller.renewOpenVpnProfile();
          } else {
            await h.controller.connect();
          }
          expect(h.api.catalogueCalls, 2);
          expect(h.controller.notice?.arguments['code'], code);
          expect(h.controller.locations.map((item) => item.id), [
            _frankfurt02.id,
          ]);
          expect(h.tunnel.openVpnConnections, isEmpty);
          expect(h.api.createOpenVpnCalls, renewal ? isEmpty : hasLength(1));
          expect(h.api.renewOpenVpnCalls, renewal ? 1 : 0);
          expect(h.controller.isConnecting, isFalse);
        });
      }

      for (final resume in [false, true]) {
        test(
          '$code migration (resume=$resume) refreshes without retry',
          () async {
            final h = await _capacityHarness(
              existingDevice: true,
              savedMigration: resume,
            );
            addTearDown(h.close);
            await h.controller.selectProtocol(VpnProtocol.openVpn);
            final failure = ApiException(statusCode: status, errorCode: code);
            if (resume) {
              h.api.getMigrationFailure = failure;
              await h.controller.resumeLocationMigration();
            } else {
              await h.controller.selectLocation(_frankfurt02);
              h.api.startMigrationFailure = failure;
              await h.controller.connect();
            }
            expect(h.api.catalogueCalls, resume ? 1 : 2);
            expect(h.controller.notice?.arguments['code'], code);
            expect(h.controller.locations.map((item) => item.id), [
              _frankfurt.id,
            ]);
            expect(h.api.startMigrationCalls, resume ? isEmpty : hasLength(1));
            expect(h.api.migrationPollCalls, resume ? hasLength(1) : isEmpty);
            expect(h.controller.isLocationMigrationLocked, resume);
            expect(h.controller.isConnecting, isFalse);
            expect(h.api.registerDeviceCalls, isEmpty);
            expect(h.tunnel.openVpnConnections, isEmpty);
          },
        );
      }
    }

    for (final (status, code) in [
      (503, 'server_full'),
      (409, 'capacity_unavailable'),
      (503, 'ipv6_unavailable'),
      (409, 'device_limit'),
    ]) {
      test('unrelated $status $code does not refresh or hide', () async {
        final h = await _capacityHarness();
        addTearDown(h.close);
        h.api.registerDeviceFailure = ApiException(
          statusCode: status,
          errorCode: code,
        );
        await h.controller.connect();
        expect(h.api.catalogueCalls, 1);
        expect(h.controller.locations, hasLength(2));
        expect(h.api.registerDeviceCalls, hasLength(1));
        expect(h.controller.notice?.arguments['code'], code);
      });
    }

    test('a stale catalogue cannot resurrect the rejected location', () async {
      final h = await _capacityHarness();
      addTearDown(h.close);
      final old = _CapacityCatalogueReply();
      h.api.catalogueReplies.add(old);
      final oldRefresh = h.controller.refreshLocations();
      await old.entered.future;
      h.api.registerDeviceFailure = const ApiException(
        statusCode: 409,
        errorCode: 'server_full',
      );
      await h.controller.connect();
      old.result.complete([_frankfurt, _frankfurt02]);
      await oldRefresh;
      expect(h.controller.locations.map((item) => item.id), [_frankfurt02.id]);
      expect(h.controller.notice?.arguments['code'], 'server_full');
      expect(h.controller.isLoadingLocations, isFalse);
    });

    for (final recovered in [false, true]) {
      test(
        'newer manual catalogue owns final recovery selection (readmitted=$recovered)',
        () async {
          final h = await _capacityHarness();
          addTearDown(h.close);
          final recovery = _CapacityCatalogueReply();
          h.api.registerDeviceFailure = const ApiException(
            statusCode: 409,
            errorCode: 'server_full',
          );
          h.api.hooks['registerDevice'] = () async {
            h.api.catalogueReplies.add(recovery);
          };
          final connection = h.controller.connect();
          await recovery.entered.future;
          final newest = _refreshLocation('newest');
          h.api.locationsResult = [newest, if (recovered) _frankfurt];
          await h.controller.refreshLocations();
          expect(h.controller.selectedLocation, _frankfurt);
          recovery.result.complete([_frankfurt, _frankfurt02]);
          await connection;
          expect(h.controller.locations, [newest, if (recovered) _frankfurt]);
          expect(
            h.controller.selectedLocation,
            recovered ? _frankfurt : newest,
          );
          expect(h.controller.isConnecting, isFalse);
          expect(h.controller.isLoadingLocations, isFalse);
          expect(h.api.registerDeviceCalls, hasLength(1));
          expect(h.tunnel.wireGuardConnections, isEmpty);
        },
      );
    }

    test(
      'automatic recovery fallback does not override a later empty catalogue',
      () async {
        final h = await _capacityHarness();
        addTearDown(h.close);
        final recovery = _CapacityCatalogueReply();
        final latest = _CapacityCatalogueReply();
        h.api.registerDeviceFailure = const ApiException(
          statusCode: 409,
          errorCode: 'server_full',
        );
        h.api.hooks['registerDevice'] = () async {
          h.api.catalogueReplies.add(recovery);
        };
        final connection = h.controller.connect();
        await recovery.entered.future;
        h.api.catalogueReplies.add(latest);
        final manualRefresh = h.controller.refreshLocations();
        await latest.entered.future;
        recovery.result.complete([_frankfurt, _frankfurt02]);
        await connection;
        expect(h.controller.selectedLocation, _frankfurt02);
        expect(h.controller.isLoadingLocations, isTrue);
        latest.result.complete([]);
        await manualRefresh;
        expect(h.controller.locations, isEmpty);
        expect(h.controller.selectedLocation, isNull);
        expect(h.controller.isLoadingLocations, isFalse);
        expect(h.api.registerDeviceCalls, hasLength(1));
        expect(h.tunnel.wireGuardConnections, isEmpty);
      },
    );

    test(
      'confirmed location switch refusal stops once and never reconnects',
      () async {
        final h = await _capacityHarness(existingDevice: true);
        addTearDown(h.close);
        h.tunnel.state = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
          locationId: 'frankfurt-01',
        );
        h.controller.tunnelState = h.tunnel.state;
        h.api.registerDeviceFailure = const ApiException(
          statusCode: 409,
          errorCode: 'server_full',
        );
        await h.controller.changeLocationAndConnect(_frankfurt02);
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.api.registerDeviceCalls.single.locationId, _frankfurt02.id);
        expect(h.api.catalogueCalls, 2);
        expect(h.controller.locations, [_frankfurt]);
        expect(h.controller.selectedLocation, _frankfurt);
        expect(h.controller.notice?.arguments['code'], 'server_full');
        expect(h.controller.isChangingLocation, isFalse);
        expect(h.controller.isConnecting, isFalse);
        expect(h.tunnel.wireGuardConnections, isEmpty);
      },
    );

    test(
      'manual refresh preserves a locked migration target omitted from catalogue',
      () async {
        final h = await _capacityHarness(existingDevice: true);
        addTearDown(h.close);
        await h.controller.selectProtocol(VpnProtocol.openVpn);
        await h.controller.selectLocation(_frankfurt02);
        h.api.migrationStartResult = _locationMigration(
          status: LocationMigrationStatus.blocked,
        );
        await h.controller.connect();
        final previousMigration = h.controller.locationMigration;
        expect(previousMigration, isNotNull);
        h.api.locationsResult = [_frankfurt];
        await h.controller.refreshLocations();
        expect(h.controller.selectedLocation, _frankfurt02);
        expect(h.controller.locations, [_frankfurt]);
        expect(h.controller.locationMigration, same(previousMigration));
        expect(h.controller.isLocationMigrationLocked, isTrue);
        expect(h.api.startMigrationCalls, hasLength(1));
        expect(h.tunnel.openVpnConnections, isEmpty);
      },
    );

    test(
      'capacity refusal remains handled when catalogue omits an in-flight target',
      () async {
        final h = await _capacityHarness();
        addTearDown(h.close);
        final registerEntered = Completer<void>();
        final releaseRegister = Completer<void>();
        h.api.hooks['registerDevice'] = () async {
          registerEntered.complete();
          await releaseRegister.future;
        };
        h.api.registerDeviceFailure = const ApiException(
          statusCode: 409,
          errorCode: 'server_full',
        );
        final connection = h.controller.connect();
        await registerEntered.future;
        h.api.locationsResult = [_frankfurt02];
        await h.controller.refreshLocations();
        expect(h.controller.selectedLocation, _frankfurt);
        expect(h.controller.locations, [_frankfurt02]);
        releaseRegister.complete();
        await connection;
        expect(h.controller.notice?.arguments['code'], 'server_full');
        expect(h.controller.selectedLocation, _frankfurt02);
        expect(h.api.catalogueCalls, 3); // Capability, manual, one recovery.
        expect(h.api.registerDeviceCalls, hasLength(1));
      },
    );

    test(
      'late capacity refusal from a previous session does not refresh the new one',
      () async {
        final h = await _capacityHarness();
        addTearDown(h.close);
        final registerEntered = Completer<void>();
        final releaseRegister = Completer<void>();
        h.api.hooks['registerDevice'] = () async {
          registerEntered.complete();
          await releaseRegister.future;
        };
        h.api.registerDeviceFailure = const ApiException(
          statusCode: 409,
          errorCode: 'server_full',
        );
        final connection = h.controller.connect();
        await registerEntered.future;
        await h.controller.signOut();
        h.api.loginResult = _session('session-b');
        h.api.profilesByToken['session-b'] = _profile('user-b');
        await h.controller.signIn(
          email: 'user-b@example.test',
          password: 'fixture',
        );
        final catalogueCalls = h.api.catalogueCalls;
        final latestLocations = h.controller.locations;
        releaseRegister.complete();
        await connection;
        expect(h.api.catalogueCalls, catalogueCalls);
        expect(h.controller.locations, same(latestLocations));
        expect(h.controller.notice, isNull);
        expect(h.controller.token, 'session-b');
        expect(h.tunnel.wireGuardConnections, isEmpty);
      },
    );

    for (final replacement in ['selection', 'session', 'stop']) {
      test(
        'recovery completion cannot overwrite a newer $replacement',
        () async {
          final h = await _capacityHarness();
          addTearDown(h.close);
          final recovery = _CapacityCatalogueReply();
          h.api.registerDeviceFailure = const ApiException(
            statusCode: 409,
            errorCode: 'server_full',
          );
          h.api.hooks['registerDevice'] = () async {
            h.api.catalogueReplies.add(recovery);
          };
          final connecting = h.controller.connect();
          await recovery.entered.future;
          expect(h.controller.locations.map((item) => item.id), [
            _frankfurt02.id,
          ]);
          const newerNotice = AppNotice(
            titleKey: 'newer.title',
            messageKey: 'newer.message',
          );
          switch (replacement) {
            case 'selection':
              await h.controller.selectLocation(_frankfurt02);
            case 'session':
              await h.controller.signOut();
              h.api.loginResult = _session('session-b');
              h.api.profilesByToken['session-b'] = _profile('user-b');
              await h.controller.signIn(
                email: 'user-b@example.test',
                password: 'fixture',
              );
            case 'stop':
              await h.controller.disconnect();
          }
          h.controller.notice = newerNotice;
          final previousSelection = h.controller.selectedLocation;
          final previousLocations = h.controller.locations;
          recovery.result.complete([_refreshLocation('obsolete')]);
          await connecting;
          expect(h.controller.notice, same(newerNotice));
          expect(h.controller.selectedLocation, same(previousSelection));
          expect(h.controller.locations, same(previousLocations));
          expect(h.controller.isConnecting, isFalse);
          expect(h.controller.isLoadingLocations, isFalse);
          expect(h.tunnel.wireGuardConnections, isEmpty);
        },
      );
    }

    test(
      'a catalogue omission alone preserves the running tunnel and favorites',
      () async {
        final h = await _capacityHarness(existingDevice: true);
        addTearDown(h.close);
        await h.controller.toggleFavoriteLocation(_frankfurt);
        h.tunnel.state = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
          locationId: 'frankfurt-01',
        );
        h.controller.tunnelState = h.tunnel.state;
        h.api.locationsResult = [_frankfurt02];
        await h.controller.refreshLocations();
        expect(h.controller.locations, [_frankfurt02]);
        expect(h.controller.isConnected, isTrue);
        expect(h.controller.tunnelState.locationId, _frankfurt.id);
        expect(h.controller.isFavoriteLocation(_frankfurt.id), isTrue);
        expect(h.tunnel.disconnectCalls, 0);
      },
    );
  });
}

Future<_CapacityHarness> _capacityHarness({
  bool existingDevice = false,
  bool savedMigration = false,
}) async {
  final api = _CapacityApi()
    ..locationsResult = [_frankfurt, _frankfurt02]
    ..profilesByToken['session-a'] = _profile('user-a')
    ..deviceListResult = existingDevice
        ? _devices('device-current')
        : const DeviceList(limit: 2, devices: [])
    ..deviceConfiguration = _wireGuardConfigurationFor('device-current')
    ..openVpnActivation = _openVpnActivation('device-current');
  final store = _FakeSessionStore()..storedSession = _session('session-a');
  if (existingDevice) store.deviceIds['user-a'] = 'device-current';
  if (savedMigration) {
    store.migrations['user-a/device-current'] = _locationMigration(
      status: LocationMigrationStatus.blocked,
    );
  }
  final preferences = _FavoritesPreferences();
  final tunnel = _FakeTunnel();
  final controller = _controller(
    api: api,
    store: store,
    preferences: preferences,
    tunnel: tunnel,
    migrationDelay: (_) async {},
  );
  await controller.initialize();
  api.catalogueCalls = 0;
  return _CapacityHarness(api, store, tunnel, preferences, controller);
}

class _CapacityHarness {
  _CapacityHarness(
    this.api,
    this.store,
    this.tunnel,
    this.preferences,
    this.controller,
  );
  final _CapacityApi api;
  final _FakeSessionStore store;
  final _FakeTunnel tunnel;
  final _FavoritesPreferences preferences;
  final VpnAppController controller;
  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _CapacityCatalogueReply {
  final entered = Completer<void>();
  final result = Completer<List<Location>>();
}

class _CapacityApi extends _FakeApi {
  int catalogueCalls = 0;
  final catalogueReplies = <_CapacityCatalogueReply>[];
  @override
  Future<List<Location>> locations() {
    catalogueCalls++;
    if (catalogueReplies.isEmpty) return super.locations();
    final reply = catalogueReplies.removeAt(0);
    reply.entered.complete();
    return reply.result.future;
  }
}
