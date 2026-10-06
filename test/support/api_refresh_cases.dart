part of '../app_controller_test.dart';

void apiRefreshTests() {
  group('API list refresh ownership', () {
    for (final devices in [false, true]) {
      final resource = devices ? 'devices' : 'locations';
      for (final olderFirst in [false, true]) {
        test(
          '$resource latest success owns data and loading (olderFirst=$olderFirst)',
          () async {
            final h = await _refreshHarness();
            addTearDown(h.close);
            final before = h.snapshotId(devices);
            final old = h.defer(devices);
            final latest = h.defer(devices);
            final oldRequest = h.refresh(devices);
            final latestRequest = h.refresh(devices);
            expect(h.loading(devices), isTrue);
            if (olderFirst) {
              old.reply.complete('older');
              await oldRequest;
              expect(h.snapshotId(devices), before);
              expect(h.loading(devices), isTrue);
            }
            latest.reply.complete('latest');
            await latestRequest;
            expect(h.snapshotId(devices), 'latest');
            expect(h.loading(devices), isFalse);
            if (!olderFirst) {
              old.reply.complete('older');
              await oldRequest;
            }
            expect(h.snapshotId(devices), 'latest');
            expect(h.controller.notice, isNull);
          },
        );

        test(
          '$resource stale error is ignored (olderFirst=$olderFirst)',
          () async {
            final h = await _refreshHarness();
            addTearDown(h.close);
            final old = h.defer(devices);
            final latest = h.defer(devices);
            final oldRequest = h.refresh(devices);
            final latestRequest = h.refresh(devices);
            if (olderFirst) {
              old.reply.completeError(
                const ApiException(statusCode: 503, errorCode: 'server_error'),
              );
              await oldRequest;
              expect(h.loading(devices), isTrue);
              expect(h.controller.notice, isNull);
            }
            latest.reply.complete('latest');
            await latestRequest;
            if (!olderFirst) {
              old.reply.completeError(const ApiNetworkException());
              await oldRequest;
            }
            expect(h.snapshotId(devices), 'latest');
            expect(h.controller.notice, isNull);
            expect(h.loading(devices), isFalse);
            expect(h.store.clearSessionCalls, 0);
          },
        );

        test(
          '$resource latest error wins without admitting old success (olderFirst=$olderFirst)',
          () async {
            final h = await _refreshHarness();
            addTearDown(h.close);
            final before = h.snapshotId(devices);
            final old = h.defer(devices);
            final latest = h.defer(devices);
            final oldRequest = h.refresh(devices);
            final latestRequest = h.refresh(devices);
            if (olderFirst) {
              old.reply.complete('older');
              await oldRequest;
              expect(h.loading(devices), isTrue);
            }
            latest.reply.completeError(
              const ApiException(statusCode: 503, errorCode: 'server_error'),
            );
            await latestRequest;
            if (!olderFirst) {
              old.reply.complete('older');
              await oldRequest;
            }
            expect(h.snapshotId(devices), before);
            expect(h.loading(devices), isFalse);
            expect(h.controller.notice?.arguments['code'], 'server_error');
            expect(h.controller.token, 'session-a');
            expect(h.store.clearSessionCalls, 0);
          },
        );
      }

      for (final failure in [false, true]) {
        test(
          '$resource completion after dispose is inert (failure=$failure)',
          () async {
            final h = await _refreshHarness();
            final old = h.defer(devices);
            final pending = h.refresh(devices);
            final before = h.snapshotId(devices);
            h.controller.dispose();
            try {
              if (failure) {
                old.reply.completeError(
                  const ApiException(
                    statusCode: 401,
                    errorCode: 'unauthorized',
                  ),
                );
              } else {
                old.reply.complete('obsolete');
              }
              await pending;
              expect(h.snapshotId(devices), before);
              expect(h.controller.notice, isNull);
              expect(h.loading(devices), isFalse);
              expect(h.store.clearSessionCalls, 0);
              await h.refresh(devices);
              expect(h.api.callsAfterInitialize, 1);
            } finally {
              await h.tunnel.close();
            }
          },
        );
      }

      for (final result in ['success', 'network', 'unauthorized']) {
        test(
          '$resource obsolete $result cannot affect replacement session or loading',
          () async {
            final h = await _refreshHarness();
            addTearDown(h.close);
            final old = h.defer(devices);
            final oldRequest = h.refresh(devices);
            await h.controller.signOut();
            expect(h.loading(devices), isFalse);
            h.api.loginResult = _session('session-b');
            h.api.profilesByToken['session-b'] = _profile('user-a');
            expect(
              await h.controller.signIn(
                email: 'fixture@example.test',
                password: 'fixture',
              ),
              isTrue,
            );
            final before = h.snapshotId(devices);
            final latest = h.defer(devices);
            final latestRequest = h.refresh(devices);
            switch (result) {
              case 'success':
                old.reply.complete('obsolete');
              case 'network':
                old.reply.completeError(const ApiNetworkException());
              case 'unauthorized':
                old.reply.completeError(
                  const ApiException(
                    statusCode: 401,
                    errorCode: 'unauthorized',
                  ),
                );
            }
            await oldRequest;
            expect(h.controller.token, 'session-b');
            expect(h.snapshotId(devices), before);
            expect(h.controller.notice, isNull);
            expect(h.loading(devices), isTrue);
            expect(h.store.clearSessionCalls, 1);
            latest.reply.complete('latest');
            await latestRequest;
            expect(h.snapshotId(devices), 'latest');
            expect(h.loading(devices), isFalse);
          },
        );
      }
    }

    for (final latestFirst in [false, true]) {
      test(
        'old authenticated 401 expires the same active session (latestFirst=$latestFirst)',
        () async {
          final h = await _refreshHarness();
          addTearDown(h.close);
          final old = h.defer(true);
          final latest = h.defer(true);
          final oldRequest = h.controller.refreshDevices();
          final latestRequest = h.controller.refreshDevices();
          if (latestFirst) {
            latest.reply.complete('latest');
            await latestRequest;
          }
          old.reply.completeError(
            const ApiException(statusCode: 401, errorCode: 'unauthorized'),
          );
          await oldRequest;
          if (!latestFirst) {
            latest.reply.complete('latest');
            await latestRequest;
          }
          expect(h.controller.token, isNull);
          expect(h.controller.deviceList.devices, isEmpty);
          expect(h.store.clearSessionCalls, 1);
          expect(h.controller.notice?.arguments['code'], 'unauthorized');
          expect(h.controller.isLoadingDevices, isFalse);
        },
      );
    }

    for (final returnToInitial in [false, true]) {
      test(
        'a catalogue started before a choice preserves that choice (return=$returnToInitial)',
        () async {
          final h = await _refreshHarness();
          addTearDown(h.close);
          final pending = h.defer(false);
          final refresh = h.controller.refreshLocations(
            savedLocation: 'catalogue-default',
          );
          await h.controller.selectLocation(_refreshLocation('chosen'));
          if (returnToInitial) await h.controller.selectLocation(_frankfurt);
          final chosenId = h.controller.selectedLocation?.id;
          pending.reply.complete('catalogue-default');
          await refresh;
          expect(h.controller.locations.single.id, 'catalogue-default');
          expect(h.controller.selectedLocation?.id, chosenId);
        },
      );
    }

    test(
      'a current catalogue still falls back when no choice happened while pending',
      () async {
        final h = await _refreshHarness();
        addTearDown(h.close);
        final pending = h.defer(false);
        final refresh = h.controller.refreshLocations();
        pending.reply.complete('available');
        await refresh;
        expect(h.controller.selectedLocation?.id, 'available');
      },
    );

    for (final publicFirst in [false, true]) {
      test(
        'public and connection location snapshots share order and keep own IP capability (publicFirst=$publicFirst)',
        () async {
          final h = await _refreshHarness();
          addTearDown(h.close);
          final first = h.defer(false);
          final second = h.defer(false);
          final publicReply = publicFirst ? first : second;
          final connectionReply = publicFirst ? second : first;
          publicReply.locations = [
            _refreshLocation('public-catalogue'),
            _frankfurt,
          ];
          connectionReply.locations = [
            _refreshLocation('connection-catalogue'),
            Location(
              id: _frankfurt.id,
              city: _frankfurt.city,
              countryCode: _frankfurt.countryCode,
              displayName: _frankfurt.displayName,
              supportedProtocols: _frankfurt.supportedProtocols,
              supportsIpv6: true,
            ),
          ];
          late final Future<void> connection;
          late final Future<void> refresh;
          if (publicFirst) {
            refresh = h.controller.refreshLocations();
            connection = h.controller.connect();
          } else {
            connection = h.controller.connect();
            await first.entered.future;
            refresh = h.controller.refreshLocations();
          }
          await second.entered.future;
          second.reply.complete('latest');
          if (publicFirst) {
            await connection;
          } else {
            await refresh;
          }
          final expectedCatalogue = publicFirst
              ? 'connection-catalogue'
              : 'public-catalogue';
          expect(h.snapshotId(false), expectedCatalogue);
          expect(h.controller.isLoadingLocations, isFalse);
          first.reply.complete('older');
          await Future.wait([connection, refresh]);
          expect(h.snapshotId(false), expectedCatalogue);
          expect(h.controller.selectedLocation?.id, _frankfurt.id);
          expect(h.api.ipRequests, contains(('registerDevice', true)));
          expect(h.tunnel.wireGuardConnections, hasLength(1));
        },
      );

      test(
        'public and connection device snapshots share publication order (publicFirst=$publicFirst)',
        () async {
          final h = await _refreshHarness();
          addTearDown(h.close);
          final first = h.defer(true);
          final second = h.defer(true);
          late final Future<void> connection;
          late final Future<void> refresh;
          if (publicFirst) {
            refresh = h.controller.refreshDevices();
            connection = h.controller.connect();
          } else {
            connection = h.controller.connect();
            await first.entered.future;
            refresh = h.controller.refreshDevices();
          }
          await second.entered.future;
          second.reply.complete('latest');
          if (publicFirst) {
            await connection;
          } else {
            await refresh;
          }
          expect(h.snapshotId(true), 'latest');
          first.reply.complete('older');
          await Future.wait([connection, refresh]);
          expect(h.snapshotId(true), 'latest');
          expect(h.controller.isLoadingDevices, isFalse);
          expect(h.tunnel.wireGuardConnections, hasLength(1));
        },
      );
    }
  });
}

Location _refreshLocation(String id) => Location(
  id: id,
  city: 'Fixture',
  countryCode: 'FR',
  displayName: id,
  supportedProtocols: const {VpnProtocol.wireGuard, VpnProtocol.openVpn},
);

Future<_RefreshHarness> _refreshHarness() async {
  final api = _QueuedRefreshApi()
    ..profilesByToken['session-a'] = _profile('user-a')
    ..deviceListResult = _devices('device-current')
    ..deviceConfiguration = _wireGuardConfigurationFor('device-current');
  final store = _FakeSessionStore()
    ..storedSession = _session('session-a')
    ..deviceIds['user-a'] = 'device-current';
  final tunnel = _FakeTunnel();
  final controller = _controller(
    api: api,
    store: store,
    preferences: _FakePreferences(),
    tunnel: tunnel,
  );
  await controller.initialize();
  api.callsAfterInitialize = 0;
  return _RefreshHarness(api, store, tunnel, controller);
}

class _RefreshHarness {
  _RefreshHarness(this.api, this.store, this.tunnel, this.controller);
  final _QueuedRefreshApi api;
  final _FakeSessionStore store;
  final _FakeTunnel tunnel;
  final VpnAppController controller;
  _RefreshReply defer(bool devices) {
    final result = _RefreshReply();
    (devices ? api.deviceReplies : api.locationReplies).add(result);
    return result;
  }

  Future<void> refresh(bool devices) =>
      devices ? controller.refreshDevices() : controller.refreshLocations();
  bool loading(bool devices) =>
      devices ? controller.isLoadingDevices : controller.isLoadingLocations;
  String? snapshotId(bool devices) => devices
      ? controller.deviceList.devices.firstOrNull?.deviceId
      : controller.locations.firstOrNull?.id;
  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _RefreshReply {
  final entered = Completer<void>();
  final reply = Completer<String>();
  List<Location>? locations;
  Future<String> receive() {
    entered.complete();
    return reply.future;
  }
}

class _QueuedRefreshApi extends _FakeApi {
  final deviceReplies = <_RefreshReply>[];
  final locationReplies = <_RefreshReply>[];
  int callsAfterInitialize = 0;
  @override
  Future<DeviceList> listDevices(String token) {
    callsAfterInitialize++;
    return deviceReplies.isEmpty
        ? super.listDevices(token)
        : deviceReplies.removeAt(0).receive().then(_devices);
  }

  @override
  Future<List<Location>> locations() {
    callsAfterInitialize++;
    if (locationReplies.isEmpty) return super.locations();
    final reply = locationReplies.removeAt(0);
    return reply.receive().then(
      (id) => reply.locations ?? [_refreshLocation(id)],
    );
  }
}
