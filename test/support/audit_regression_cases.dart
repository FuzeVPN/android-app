part of '../app_controller_test.dart';

// Product regressions converted from the seven independent audit probes.
// These assert the corrected behavior; historical reports remain unchanged.
void auditRegressionTests() {
  group('Android audit regressions', () {
    for (final register in [false, true]) {
      test(
        'initial secure write failure is handled for ${register ? 'registration' : 'login'}',
        () async {
          final api = _FakeApi()
            ..profilesByToken['session-a'] = _profile('user-a');
          final store = _FakeSessionStore();
          final tunnel = _FakeTunnel();
          final controller = _controller(
            api: api,
            store: store,
            preferences: _FakePreferences(),
            tunnel: tunnel,
          );
          addTearDown(() async {
            controller.dispose();
            await tunnel.close();
          });
          await controller.initialize();
          store.beforeWrite = () async {
            throw const NativeVpnException('secure_storage_write_failed');
          };
          final result = register
              ? await controller.register(
                  const RegisterAccountRequest(
                    email: 'a@example.test',
                    password: 'fixture',
                    firstName: 'A',
                    lastName: 'Test',
                    phone: '+33123456789',
                    addressLine1: '1 rue Test',
                    postalCode: '75001',
                    city: 'Paris',
                    countryCode: 'FR',
                    termsAccepted: true,
                    privacyAccepted: true,
                  ),
                )
              : await controller.signIn(
                  email: 'a@example.test',
                  password: 'fixture',
                );
          expect(result, isFalse);
          expect(controller.isAuthenticating, isFalse);
          expect(controller.isSignedIn, isFalse);
          expect(controller.token, isNull);
          expect(store.clearSessionCalls, 1);
          expect(
            controller.notice?.arguments['code'],
            'secure_storage_write_failed',
          );
          store.beforeWrite = null;
          expect(
            await controller.signIn(
              email: 'a@example.test',
              password: 'fixture',
            ),
            isTrue,
          );
        },
      );
    }

    test(
      'failed secure account binding keeps account unpublished and can retry the same token',
      () async {
        final api = _FakeApi()
          ..profilesByToken['session-a'] = _profile('user-a')
          ..deviceListResult = _devices('device-current');
        var loginCalls = 0;
        api.hooks['login'] = () async {
          loginCalls++;
        };
        final store = _FakeSessionStore()
          ..deviceIds['user-a'] = 'device-current';
        final tunnel = _FakeTunnel();
        final controller = _controller(
          api: api,
          store: store,
          preferences: _FakePreferences(),
          tunnel: tunnel,
        );
        addTearDown(() async {
          controller.dispose();
          await tunnel.close();
        });
        await controller.initialize();
        var writes = 0;
        store.beforeWrite = () async {
          if (++writes == 2) {
            throw const NativeVpnException('secure_storage_write_failed');
          }
        };
        expect(
          await controller.signIn(email: 'a@example.test', password: 'fixture'),
          isFalse,
        );
        expect(controller.isSignedIn, isFalse);
        expect(controller.profile, isNull);
        expect(controller.hasPendingAccountRestoration, isTrue);
        expect(controller.currentDeviceId, isNull);
        expect(store.readDeviceUsers, isEmpty);
        expect(store.sessionWriteUsers, [null]);
        await controller.connect();
        expect(tunnel.preparedTunnelRequests, isEmpty);
        store.beforeWrite = null;
        await controller.retryAccountRestoration();
        expect(controller.isSignedIn, isTrue);
        expect(controller.hasPendingAccountRestoration, isFalse);
        expect(controller.currentDeviceId, 'device-current');
        expect(loginCalls, 1);
      },
    );

    test(
      'offline restoration preserves local tunnel controls and retries without login',
      () async {
        final api = _FakeApi()
          ..profilesByToken['session-a'] = _profile('user-a');
        api.hooks['me'] = () async {
          throw const ApiNetworkException();
        };
        final store = _FakeSessionStore()
          ..storedSession = _session('session-a');
        final tunnel = _FakeTunnel()
          ..state = const VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
            protocol: VpnProtocol.wireGuard,
          )
          ..systemProtection = const SystemVpnProtection(
            alwaysOn: false,
            lockdown: false,
          );
        final controller = _controller(
          api: api,
          store: store,
          preferences: _FakePreferences(),
          tunnel: tunnel,
        );
        addTearDown(() async {
          controller.dispose();
          await tunnel.close();
        });
        await controller.initialize();
        expect(controller.hasPendingAccountRestoration, isTrue);
        expect(controller.isSignedIn, isFalse);
        expect(controller.isConnected, isTrue);
        await controller.requestUserDisconnect();
        expect(tunnel.disconnectByUserCalls, 1);
        expect(controller.isConnected, isFalse);
        expect(controller.token, 'session-a');
        api.hooks.remove('me');
        api.hooks['login'] = () async {
          fail('Retry must reuse the saved session');
        };
        await controller.retryAccountRestoration();
        expect(controller.isSignedIn, isTrue);
        expect(controller.hasPendingAccountRestoration, isFalse);
      },
    );

    testWidgets(
      'an obsolete disconnect timeout cannot replace a new account state',
      (tester) async {
        final h = await _signedInHarness();
        try {
          h.tunnel.emitConnected(VpnProtocol.wireGuard);
          await tester.pump();
          final pendingStop = Completer<void>();
          var stops = 0;
          h.tunnel.hooks['disconnect'] = () =>
              ++stops == 1 ? pendingStop.future : Future<void>.value();
          final oldDisconnect = h.controller.disconnect();
          await tester.pump();
          await h.controller.signOut();
          h.api.loginResult = _session('session-b');
          h.api.profilesByToken['session-b'] = _profile('user-b');
          expect(
            await h.controller.signIn(
              email: 'b@example.test',
              password: 'fixture',
            ),
            isTrue,
          );
          h.tunnel.emitConnected(VpnProtocol.wireGuard);
          await tester.pump();
          await tester.pump(const Duration(seconds: 16));
          await oldDisconnect;
          expect(h.controller.profile?.userId, 'user-b');
          expect(h.controller.isConnected, isTrue);
          expect(h.controller.notice, isNull);
          pendingStop.complete();
          await tester.pump();
        } finally {
          await h.close();
        }
      },
    );

    test(
      'native stream errors produce a safe error state and allow later events',
      () async {
        final source = StreamController<dynamic>();
        final bridge = NativeVpnBridge(
          events: _AuditEventChannel(source.stream),
        );
        final events = <VpnRuntimeState>[];
        final subscription = bridge.states.listen(events.add);
        source.add({'phase': 'connecting', 'protocol': 'wireguard'});
        source.addError(
          PlatformException(
            code: 'channel_disconnected',
            message: 'secret-payload',
          ),
        );
        source.add({'phase': 'connected', 'protocol': 'wireguard'});
        await source.close();
        await Future<void>.delayed(Duration.zero);
        expect(events.map((event) => event.phase), [
          VpnRuntimePhase.connecting,
          VpnRuntimePhase.error,
          VpnRuntimePhase.connected,
        ]);
        expect(events[1].messageCode, 'native_bridge_unavailable');
        expect(events[1].toString(), isNot(contains('secret-payload')));
        await subscription.cancel();
      },
    );

    test(
      'identity cleanup always sends the expected device including explicit null',
      () async {
        const channel = MethodChannel('audit/identity');
        final calls = <MethodCall>[];
        final messenger =
            TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
        messenger.setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return null;
        });
        addTearDown(() => messenger.setMockMethodCallHandler(channel, null));
        final bridge = NativeVpnBridge(channel: channel);
        await bridge.clearAccountIdentity(
          accountId: 'account-a',
          expectedDeviceId: 'device-old',
        );
        await bridge.clearAccountIdentity(
          accountId: 'account-a',
          expectedDeviceId: null,
        );
        expect(calls.map((call) => call.method), [
          'clearAccountIdentity',
          'clearAccountIdentity',
        ]);
        expect(calls[0].arguments, {
          'account_id': 'account-a',
          'expected_device_id': 'device-old',
        });
        expect(calls[1].arguments, {
          'account_id': 'account-a',
          'expected_device_id': null,
        });
      },
    );

    test(
      'last allowed migration poll is processed before reporting a timeout',
      () async {
        final api = _FakeApi()
          ..profilesByToken['session-a'] = _profile('user-a')
          ..locationsResult = [_frankfurt, _frankfurt02]
          ..deviceListResult = _devices('device-current')
          ..deviceConfiguration = _wireGuardConfigurationFor('device-current')
          ..openVpnActivation = _openVpnActivation('device-current');
        final store = _FakeSessionStore()
          ..storedSession = _session('session-a')
          ..deviceIds['user-a'] = 'device-current';
        final tunnel = _FakeTunnel();
        final controller = VpnAppController(
          api: api,
          sessionStore: store..tunnel = tunnel,
          preferences: _FakePreferences(),
          tunnel: tunnel,
          migrationDelay: (_) => Future<void>.value(),
          migrationMaxPollAttempts: 1,
        );
        addTearDown(() async {
          controller.dispose();
          await tunnel.close();
        });
        await controller.initialize();
        await controller.selectProtocol(VpnProtocol.openVpn);
        await controller.selectLocation(_frankfurt02);
        api.migrationStartResult = _locationMigration(
          status: LocationMigrationStatus.draining,
        );
        api.migrationPollResults.add(
          _locationMigration(status: LocationMigrationStatus.ready),
        );
        api.hooks['getLocationMigration'] = () async {
          api.deviceListResult = _devices(
            'device-current',
            location: _frankfurt02,
          );
        };
        await controller.connect();
        expect(controller.locationMigration, isNull);
        expect(controller.isLocationMigrationLocked, isFalse);
        expect(api.migrationPollCalls, hasLength(1));
        expect(tunnel.openVpnConnections, hasLength(1));
      },
    );

    test(
      'device revocation serializes connection renewal and identity reset',
      () async {
        final h = await _restoredHarness(events: []);
        addTearDown(h.close);
        final entered = Completer<void>();
        final release = Completer<void>();
        h.api.hooks['revokeDevice'] = () async {
          entered.complete();
          await release.future;
        };
        final removing = h.controller.revokeDevice(h.controller.currentDevice!);
        await entered.future;
        expect(h.controller.isIdentityBusy, isTrue);
        await h.controller.connect();
        await h.controller.renewOpenVpnProfile();
        await h.controller.resetRevokedIdentity();
        expect(h.api.registerDeviceCalls, isEmpty);
        expect(h.api.renewOpenVpnCalls, 0);
        expect(h.tunnel.clearedAccountIds, isEmpty);
        release.complete();
        expect(await removing, isTrue);
        expect(h.tunnel.clearedExpectedDeviceIds, ['device-current']);
        expect(h.controller.isIdentityBusy, isFalse);
        h.api.deviceConfiguration = _wireGuardConfigurationFor('device-new');
        await h.controller.connect();
        expect(h.controller.currentDeviceId, 'device-new');
        expect(h.tunnel.wireGuardConnections, hasLength(1));
      },
    );

    for (final returnToSameId in [false, true]) {
      test(
        'late revocation guards device epoch including return-to-same-ID=$returnToSameId',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          final entered = Completer<void>();
          final release = Completer<void>();
          h.api.hooks['revokeDevice'] = () async {
            entered.complete();
            await release.future;
          };
          final removing = h.controller.revokeDevice(
            h.controller.currentDevice!,
          );
          await entered.future;
          h.controller.currentDeviceId = 'device-new';
          if (returnToSameId) h.controller.currentDeviceId = 'device-current';
          h.store.deviceIds['user-a'] = h.controller.currentDeviceId!;
          final replacementId = h.controller.currentDeviceId;
          release.complete();
          expect(await removing, isFalse);
          expect(h.tunnel.clearedAccountIds, isEmpty);
          expect(h.controller.currentDeviceId, replacementId);
          expect(h.store.deviceIds['user-a'], replacementId);
        },
      );
    }
  });
}

class _AuditEventChannel extends EventChannel {
  _AuditEventChannel(this.source) : super('audit/events');
  final Stream<dynamic> source;
  @override
  Stream<dynamic> receiveBroadcastStream([dynamic arguments]) => source;
}
