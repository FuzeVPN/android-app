part of '../app_controller_test.dart';

Future<_SignedInHarness> _switchHarness({VpnProtocol? active}) async {
  final h = await _signedInHarness();
  h.api.locationsResult = const [_frankfurt, _frankfurt02];
  await h.controller.refreshLocations();
  if (active != null) {
    h.tunnel.state = VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: active,
      locationId: _frankfurt.id,
    );
    h.controller.tunnelState = h.tunnel.state;
  }
  return h;
}

void locationChangeControllerTests() {
  group('location switching', () {
    test(
      'last stop notification immediately unlocks location changes',
      () async {
        final h = await _switchHarness(active: VpnProtocol.wireGuard);
        addTearDown(h.close);
        final stop = Completer<void>();
        h.tunnel.hooks['disconnect'] = () => stop.future;
        final availability = <bool>[];
        h.controller.addListener(
          () => availability.add(h.controller.canChangeLocation),
        );
        final disconnecting = h.controller.disconnect();
        await Future<void>.delayed(Duration.zero);
        expect(availability.last, isFalse);
        stop.complete();
        await disconnecting;
        expect(h.controller.canChangeLocation, isTrue);
        expect(availability.last, isTrue);
      },
    );

    for (final active in <VpnProtocol?>[
      null,
      VpnProtocol.wireGuard,
      VpnProtocol.openVpn,
    ]) {
      test(
        'stops then connects once, preserving native protocol ($active)',
        () async {
          final h = await _switchHarness(active: active);
          addTearDown(h.close);
          expect(h.controller.canChangeLocation, isTrue);
          await h.controller.changeLocationAndConnect(_frankfurt02);
          expect(h.tunnel.disconnectCalls, active == null ? 0 : 1);
          expect(h.tunnel.disconnectByUserCalls, 0);
          expect(h.tunnel.openVpnSettingsCalls, 0);
          expect(h.controller.selectedLocation?.id, _frankfurt02.id);
          expect(h.api.registerDeviceCalls.single.locationId, _frankfurt02.id);
          expect(
            h.tunnel.openVpnConnections,
            active == VpnProtocol.openVpn ? hasLength(1) : isEmpty,
          );
          expect(
            h.tunnel.wireGuardConnections,
            active == VpnProtocol.openVpn ? isEmpty : hasLength(1),
          );
          expect(h.controller.isChangingLocation, isFalse);
          expect(
            h.controller.notice?.arguments['code'],
            isNot('location_migration_ready'),
          );
        },
      );
    }

    test(
      'does not stop for a target unsupported by the native protocol',
      () async {
        final h = await _switchHarness(active: VpnProtocol.openVpn);
        addTearDown(h.close);
        const unsupported = Location(
          id: 'wg-only',
          city: 'Test',
          countryCode: 'DE',
          displayName: 'Test',
          supportedProtocols: {VpnProtocol.wireGuard},
        );
        h.controller.locations = [...h.controller.locations, unsupported];
        await h.controller.changeLocationAndConnect(unsupported);
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.controller.isConnected, isTrue);
        expect(h.controller.selectedLocation?.id, _frankfurt.id);
        expect(
          h.controller.notice?.arguments['code'],
          'protocol_unavailable_at_location',
        );
      },
    );

    test(
      'double tap and competing connect cannot restart before stop completes',
      () async {
        final h = await _switchHarness(active: VpnProtocol.wireGuard);
        addTearDown(h.close);
        final stop = Completer<void>();
        h.tunnel.hooks['disconnect'] = () => stop.future;
        final changing = h.controller.changeLocationAndConnect(_frankfurt02);
        await Future<void>.delayed(Duration.zero);
        expect(h.controller.isChangingLocation, isTrue);
        expect(h.controller.canChangeLocation, isFalse);
        await h.controller.changeLocationAndConnect(_frankfurt02);
        await h.controller.connect();
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.api.registerDeviceCalls, isEmpty);
        expect(h.controller.selectedLocation?.id, _frankfurt.id);
        stop.complete();
        await changing;
        expect(h.tunnel.wireGuardConnections, hasLength(1));
      },
    );

    test('failed stop and late idle never select or restart', () async {
      final h = await _switchHarness(active: VpnProtocol.wireGuard);
      addTearDown(h.close);
      h.tunnel.disconnectFailure = const NativeVpnException(
        'wireguard_stop_timeout',
      );
      await h.controller.changeLocationAndConnect(_frankfurt02);
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.error);
      h.tunnel._stateEvents.add(
        const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      await Future<void>.delayed(Duration.zero);
      expect(h.controller.selectedLocation?.id, _frankfurt.id);
      expect(h.api.registerDeviceCalls, isEmpty);
      expect(h.tunnel.wireGuardConnections, isEmpty);
    });

    testWidgets('timed out stop cannot restart after late completion', (
      tester,
    ) async {
      final h = await _switchHarness(active: VpnProtocol.wireGuard);
      addTearDown(h.close);
      final stop = Completer<void>();
      h.tunnel.hooks['disconnect'] = () => stop.future;
      final changing = h.controller.changeLocationAndConnect(_frankfurt02);
      await tester.pump();
      await tester.pump(const Duration(seconds: 16));
      await changing;
      expect(
        h.controller.notice?.arguments['code'],
        'flutter_disconnect_timeout',
      );
      stop.complete();
      await tester.pump();
      h.tunnel._stateEvents.add(
        const VpnRuntimeState(phase: VpnRuntimePhase.idle),
      );
      await tester.pump();
      expect(h.api.registerDeviceCalls, isEmpty);
      expect(h.controller.selectedLocation?.id, _frankfurt.id);
    });

    for (final cancel in [
      'user settings',
      'disconnect',
      'location',
      'logout',
      'device',
    ]) {
      test('cancels during stop on $cancel', () async {
        final h = await _switchHarness(active: VpnProtocol.wireGuard);
        addTearDown(h.close);
        final stop = Completer<void>();
        h.tunnel.hooks['disconnect'] = () => stop.future;
        final changing = h.controller.changeLocationAndConnect(_frankfurt02);
        await Future<void>.delayed(Duration.zero);
        Future<void>? extraStop;
        switch (cancel) {
          case 'user settings':
            h.tunnel.systemProtection = const SystemVpnProtection(
              alwaysOn: true,
            );
            await h.controller.requestUserDisconnect();
          case 'disconnect':
            extraStop = h.controller.disconnect();
          case 'location':
            await h.controller.selectLocation(_frankfurt);
          case 'logout':
            extraStop = h.controller.signOut();
          case 'device':
            h.controller.currentDeviceId = 'different-device';
        }
        stop.complete();
        await changing;
        await extraStop;
        expect(h.api.registerDeviceCalls, isEmpty);
        expect(h.tunnel.wireGuardConnections, isEmpty);
        expect(h.tunnel.openVpnConnections, isEmpty);
        expect(h.controller.isChangingLocation, isFalse);
      });
    }

    for (final state in [
      LocationMigrationStatus.draining,
      LocationMigrationStatus.blocked,
    ]) {
      test('keeps $state visible and resumable after workflow ends', () async {
        final h = await _restoredHarness(
          events: [],
          migrationDelay: (_) async {},
        );
        addTearDown(h.close);
        h.api.locationsResult = const [_frankfurt, _frankfurt02];
        await h.controller.refreshLocations();
        h.api.migrationStartResult = _locationMigration(status: state);
        h.controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.openVpn,
          locationId: 'frankfurt-01',
        );
        await h.controller.changeLocationAndConnect(_frankfurt02);
        expect(h.controller.isChangingLocation, isFalse);
        expect(h.controller.locationMigration?.status, state);
        expect(h.controller.canChangeLocation, isFalse);
        expect(h.tunnel.openVpnConnections, isEmpty);
        h.api.migrationPollResults.add(
          _locationMigration(status: LocationMigrationStatus.ready),
        );
        h.api.deviceListResult = _devices(
          'device-current',
          location: _frankfurt02,
        );
        await h.controller.resumeLocationMigration();
        expect(h.controller.locationMigration, isNull);
        expect(
          h.controller.notice?.arguments['code'],
          isNot('location_migration_ready'),
        );
      });
    }

    test(
      'cancelling a pending migration retains its lock without restarting',
      () async {
        final pause = Completer<void>();
        final h = await _restoredHarness(
          events: [],
          migrationDelay: (_) => pause.future,
        );
        addTearDown(h.close);
        h.api.locationsResult = const [_frankfurt, _frankfurt02];
        await h.controller.refreshLocations();
        h.api.migrationStartResult = _locationMigration(
          status: LocationMigrationStatus.draining,
        );
        h.controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.openVpn,
          locationId: 'frankfurt-01',
        );
        final changing = h.controller.changeLocationAndConnect(_frankfurt02);
        await Future<void>.delayed(Duration.zero);
        expect(
          h.controller.locationMigration?.status,
          LocationMigrationStatus.draining,
        );
        h.tunnel.systemProtection = const SystemVpnProtection(alwaysOn: true);
        await h.controller.requestUserDisconnect();
        pause.complete();
        await changing;
        expect(
          h.controller.locationMigration?.status,
          LocationMigrationStatus.draining,
        );
        expect(h.controller.canChangeLocation, isFalse);
        expect(h.tunnel.openVpnConnections, isEmpty);
      },
    );

    test('a stop while registration waits cancels native start', () async {
      final h = await _switchHarness();
      addTearDown(h.close);
      final registration = Completer<void>();
      h.api.hooks['registerDevice'] = () => registration.future;
      final changing = h.controller.changeLocationAndConnect(_frankfurt02);
      await Future<void>.delayed(Duration.zero);
      await h.controller.disconnect();
      registration.complete();
      await changing;
      expect(h.tunnel.wireGuardConnections, isEmpty);
    });

    test(
      'reconnecting is available but transitional operations are locked',
      () async {
        final h = await _switchHarness();
        addTearDown(h.close);
        h.controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connecting,
          protocol: VpnProtocol.openVpn,
          messageCode: 'openvpn_reconnecting',
        );
        expect(h.controller.canChangeLocation, isTrue);
        for (final phase in [
          VpnRuntimePhase.authorizing,
          VpnRuntimePhase.preparing,
          VpnRuntimePhase.connecting,
          VpnRuntimePhase.disconnecting,
        ]) {
          h.controller.tunnelState = VpnRuntimeState(phase: phase);
          expect(h.controller.canChangeLocation, isFalse, reason: phase.name);
        }
        h.controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.idle,
        );
        h.controller.isConnecting = true;
        expect(h.controller.canChangeLocation, isFalse);
        h.controller.isConnecting = false;
        final sessionIdentity = h.controller.locationChangeSessionIdentity;
        await h.controller.signOut();
        expect(h.controller.canChangeLocation, isFalse);
        await h.controller.signIn(
          email: 'client@example.test',
          password: 'secret',
        );
        expect(
          identical(
            sessionIdentity,
            h.controller.locationChangeSessionIdentity,
          ),
          isFalse,
        );
      },
    );
  });

  group('connection cancellation and migration ownership', () {
    setUpAll(() async {
      if (!const bool.fromEnvironment('FUZEVPN_AUDIT_CAPTURES')) return;
      TestWidgetsFlutterBinding.ensureInitialized();
      await (FontLoader(
        'Archivo',
      )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
      await (FontLoader(
        'MaterialIcons',
      )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    });

    Future<void> showControls(
      WidgetTester tester,
      VpnAppController controller,
    ) => tester.pumpWidget(
      MaterialApp(
        theme: FuzeVpnTheme.light(),
        locale: const Locale('fr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListenableBuilder(
            listenable: controller,
            builder: (context, _) => RepaintBoundary(
              key: const ValueKey('connection-audit-preview'),
              child: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryVpnAction(controller: controller),
                      const SizedBox(height: 16),
                      ProtocolOptions(controller: controller),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    testWidgets('protocol tap cannot abandon an accepted migration', (
      tester,
    ) async {
      final h = await _restoredHarness(
        events: [],
        migrationDelay: (_) async {},
      );
      addTearDown(h.close);
      h.api.locationsResult = const [_frankfurt, _frankfurt02];
      await h.controller.refreshLocations();
      await h.controller.selectProtocol(VpnProtocol.openVpn);
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.openVpn,
        locationId: 'frankfurt-01',
      );
      final entered = Completer<void>(), release = Completer<void>();
      h.api.hooks['startLocationMigration'] = () async {
        entered.complete();
        await release.future;
      };
      h.api.migrationStartResult = _locationMigration(
        status: LocationMigrationStatus.blocked,
      );
      final changing = h.controller.changeLocationAndConnect(_frankfurt02);
      await tester.pump();
      await entered.future;
      await showControls(tester, h.controller);
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();
      final protocol = find.widgetWithText(ChoiceChip, 'WireGuard');
      expect(tester.widget<ChoiceChip>(protocol).onSelected, isNull);
      await tester.tap(protocol);
      await h.controller.selectProtocol(VpnProtocol.wireGuard);
      expect(h.controller.selectedProtocol, VpnProtocol.openVpn);
      expect(h.controller.isConnecting, isTrue);
      expect(h.controller.isStartingLocationMigration, isTrue);
      if (const bool.fromEnvironment('FUZEVPN_AUDIT_CAPTURES')) {
        await expectLater(
          find.byKey(const ValueKey('connection-audit-preview')),
          matchesGoldenFile(
            '../build/reports/audit-fixes-2026-09-30/connection-protocol-locked.png',
          ),
        );
      }
      release.complete();
      await changing;
      await tester.pump();
      expect(
        h.controller.locationMigration?.status,
        LocationMigrationStatus.blocked,
      );
      expect(h.store.migrations['user-a/device-current'], isNotNull);
      expect(h.tunnel.openVpnConnections, isEmpty);
      expect(h.api.migrationPollCalls, isEmpty);
      h.api.migrationPollResults.add(
        _locationMigration(status: LocationMigrationStatus.ready),
      );
      h.api.deviceListResult = _devices(
        'device-current',
        location: _frankfurt02,
      );
      await h.controller.resumeLocationMigration();
      expect(h.controller.locationMigration, isNull);
      expect(h.tunnel.openVpnConnections, isEmpty);
    });

    for (final status in LocationMigrationStatus.values) {
      test(
        'late accepted $status migration survives cancel without connecting',
        () async {
          final h = await _restoredHarness(
            events: [],
            migrationDelay: (_) async {},
          );
          addTearDown(h.close);
          h.api.locationsResult = const [_frankfurt, _frankfurt02];
          await h.controller.refreshLocations();
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          final entered = Completer<void>(), release = Completer<void>();
          h.api.hooks['startLocationMigration'] = () async {
            entered.complete();
            await release.future;
          };
          h.api.migrationStartResult = _locationMigration(status: status);
          final changing = h.controller.changeLocationAndConnect(_frankfurt02);
          await entered.future;
          await h.controller.cancelConnectionAttempt();
          expect(h.controller.isConnecting, isFalse);
          expect(h.controller.isLocationMigrationLocked, isTrue);
          await h.controller.selectProtocol(VpnProtocol.wireGuard);
          await h.controller.connect();
          expect(h.controller.selectedProtocol, VpnProtocol.openVpn);
          expect(h.api.startMigrationCalls, isEmpty);
          release.complete();
          await changing;
          expect(h.controller.isStartingLocationMigration, isFalse);
          expect(h.controller.locationMigration?.status, status);
          expect(h.store.migrations['user-a/device-current']?.status, status);
          expect(h.api.migrationPollCalls, isEmpty);
          expect(h.tunnel.openVpnConnections, isEmpty);
          expect(h.tunnel.wireGuardConnections, isEmpty);
          h.api.migrationPollResults.add(
            _locationMigration(status: LocationMigrationStatus.ready),
          );
          h.api.deviceListResult = _devices(
            'device-current',
            location: _frankfurt02,
          );
          await h.controller.resumeLocationMigration();
          expect(h.controller.locationMigration, isNull);
          expect(h.tunnel.openVpnConnections, isEmpty);
        },
      );
    }

    for (final replacement in ['device ABA', 'session ABA', 'account']) {
      test(
        'late accepted migration cannot survive $replacement replacement',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          h.api.locationsResult = const [_frankfurt, _frankfurt02];
          await h.controller.refreshLocations();
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          final entered = Completer<void>(), release = Completer<void>();
          h.api.hooks['startLocationMigration'] = () async {
            entered.complete();
            await release.future;
          };
          final changing = h.controller.changeLocationAndConnect(_frankfurt02);
          await entered.future;
          await h.controller.cancelConnectionAttempt();
          if (replacement == 'device ABA') {
            h.controller.currentDeviceId = 'device-new';
            h.controller.currentDeviceId = 'device-current';
          } else {
            await h.controller.signOut();
            if (replacement == 'account') {
              h.api.loginResult = _session('session-b');
              h.api.profilesByToken['session-b'] = _profile('user-b');
              h.api.deviceListResult = _devices('device-b');
              h.store.deviceIds['user-b'] = 'device-b';
            }
            await h.controller.signIn(
              email: 'client@example.test',
              password: 'secret',
            );
          }
          release.complete();
          await changing;
          expect(h.store.migrations, isEmpty);
          expect(h.controller.locationMigration, isNull);
          expect(h.api.migrationPollCalls, isEmpty);
          expect(h.tunnel.openVpnConnections, isEmpty);
        },
      );
    }

    for (final protocol in VpnProtocol.values) {
      final stages = [
        'prepareTunnelRequest',
        'locations',
        'requestVpnPermission',
        'registerDevice',
        if (protocol == VpnProtocol.openVpn) 'createOpenVpnProfile',
        if (protocol == VpnProtocol.openVpn) 'getOrCreateOpenVpnCsr',
        if (protocol == VpnProtocol.openVpn)
          'connectOpenVpn'
        else
          'connectWireGuard',
      ];
      for (final stage in stages) {
        testWidgets('initial $protocol connection can cancel during $stage', (
          tester,
        ) async {
          final h = await _signedInHarness();
          addTearDown(h.close);
          await h.controller.selectProtocol(protocol);
          final entered = Completer<void>(), release = Completer<void>();
          Future<void> pause() async {
            entered.complete();
            await release.future;
          }

          if ([
            'locations',
            'registerDevice',
            'createOpenVpnProfile',
          ].contains(stage)) {
            h.api.hooks[stage] = pause;
          } else {
            h.tunnel.hooks[stage] = pause;
          }
          final connecting = h.controller.connect();
          await tester.pump();
          await entered.future;
          if (stage == 'requestVpnPermission') {
            h.controller.tunnelState = VpnRuntimeState(
              phase: VpnRuntimePhase.authorizing,
              protocol: protocol,
            );
          } else if (stage.startsWith('connect')) {
            h.controller.tunnelState = VpnRuntimeState(
              phase: VpnRuntimePhase.connecting,
              protocol: protocol,
            );
          }
          await showControls(tester, h.controller);
          final cancel = find.widgetWithText(FilledButton, 'Annuler');
          expect(tester.widget<FilledButton>(cancel).onPressed, isNotNull);
          if (stage == 'registerDevice' &&
              protocol == VpnProtocol.openVpn &&
              const bool.fromEnvironment('FUZEVPN_AUDIT_CAPTURES')) {
            await expectLater(
              find.byKey(const ValueKey('connection-audit-preview')),
              matchesGoldenFile(
                '../build/reports/audit-fixes-2026-09-30/connection-cancel.png',
              ),
            );
          }
          final stopping = Completer<void>();
          h.tunnel.hooks['disconnect'] = () => stopping.future;
          await tester.tap(cancel);
          await tester.pump();
          expect(h.controller.isDisconnecting, isTrue);
          expect(h.controller.isConnecting, isFalse);
          expect(h.tunnel.disconnectCalls, 1);
          await h.controller.connect();
          final before =
              h.tunnel.wireGuardConnections.length +
              h.tunnel.openVpnConnections.length;
          stopping.complete();
          await tester.pump();
          release.complete();
          await connecting;
          await tester.pump();
          expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
          expect(h.controller.isDisconnecting, isFalse);
          expect(
            h.tunnel.wireGuardConnections.length +
                h.tunnel.openVpnConnections.length,
            before,
          );
          expect(before, stage.startsWith('connect') ? 1 : 0);
          expect(h.controller.notice, isNull);
        });
      }
    }

    for (final phase in [
      VpnRuntimePhase.authorizing,
      VpnRuntimePhase.preparing,
      VpnRuntimePhase.connecting,
    ]) {
      testWidgets('native $phase can cancel after controller future returns', (
        tester,
      ) async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.controller.tunnelState = VpnRuntimeState(
          phase: phase,
          protocol: VpnProtocol.openVpn,
        );
        expect(h.controller.isConnecting, isFalse);
        await showControls(tester, h.controller);
        await tester.tap(find.widgetWithText(FilledButton, 'Annuler'));
        await tester.pump();
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
        expect(h.tunnel.openVpnConnections, isEmpty);
      });
    }

    test(
      'a failed cancellation keeps the native stop error actionable',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        final entered = Completer<void>(), release = Completer<void>();
        h.api.hooks['registerDevice'] = () async {
          entered.complete();
          await release.future;
        };
        final connecting = h.controller.connect();
        await entered.future;
        h.tunnel.disconnectFailure = const NativeVpnException(
          'wireguard_stop_timeout',
        );
        await h.controller.cancelConnectionAttempt();
        release.complete();
        await connecting;
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.error);
        expect(h.controller.tunnelState.messageCode, 'wireguard_stop_timeout');
        expect(h.controller.notice, isNotNull);
        expect(h.tunnel.wireGuardConnections, isEmpty);
      },
    );

    testWidgets('unavailable counters stay distinct from measured zero', (
      tester,
    ) async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.openVpn,
        locationName: 'Frankfurt 1',
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: TunnelMetricsCard(controller: h.controller)),
        ),
      );
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();
      expect(find.text('—'), findsNWidgets(3));
      expect(find.text('0 B'), findsNothing);
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.openVpn,
        locationName: 'Frankfurt 1',
        receivedBytes: 0,
        sentBytes: 0,
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: TunnelMetricsCard(controller: h.controller)),
        ),
      );
      expect(find.text('—'), findsOneWidget);
      expect(find.text('0 B'), findsNWidgets(2));
    });
  });
}
