part of '../app_controller_test.dart';

void diagnosticsControllerTests() {
  group('Android diagnostics integration', () {
    test('late consent writes cannot re-enable after revocation', () async {
      final h = await _diagnosticHarness();
      addTearDown(h.close);
      final gate = Completer<void>();
      h.preferences.firstWriteGate = gate;
      final enable = h.controller.setAutomaticDiagnostics(true);
      await Future<void>.delayed(Duration.zero);
      final disable = h.controller.setAutomaticDiagnostics(false);
      expect(h.controller.automaticDiagnostics, isFalse);
      gate.complete();
      await Future.wait([enable, disable]);
      expect(h.preferences.enabled, isFalse);
      expect(h.controller.automaticDiagnostics, isFalse);
    });

    test(
      'late timing events from the previous account are not retained',
      () async {
        final h = await _diagnosticHarness();
        addTearDown(h.close);
        final gate = Completer<void>();
        final old = ConnectionTiming.run('http.open', () async {
          await gate.future;
          ConnectionTiming.event('http.response', status: 599);
        }, sink: (_) {});
        await h.controller.signOut();
        h.api.loginResult = _session('session-b');
        h.api.profilesByToken['session-b'] = _profile('user-b');
        expect(
          await h.controller.signIn(
            email: 'b@example.test',
            password: 'secret',
          ),
          isTrue,
        );
        gate.complete();
        await old;
        await h.controller.runDiagnostics(sendReport: false);
        final events =
            h.controller.diagnosticReport!.toJson()['events'] as List? ?? [];
        expect(
          events.where((dynamic event) => event['http_status'] == 599),
          isEmpty,
        );
      },
    );
    test(
      'manual local snapshot excludes identity and keeps unknown distinct',
      () async {
        final h = await _diagnosticHarness();
        addTearDown(h.close);
        h.tunnel.state = VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
          locationId: 'private-location',
          locationName: 'private-name',
          connectedAt: DateTime.now().subtract(const Duration(seconds: 10)),
          sentBytes: 0,
          receivedBytes: 0,
        );
        h.tunnel.systemProtection = const SystemVpnProtection(lockdown: false);
        await h.controller.runDiagnostics(sendReport: false);
        expect(h.controller.diagnosticsPreparationFailed, isFalse);
        final report = h.controller.diagnosticReport!;
        final body = report.toJson();
        final snapshot = body['snapshot'] as Map;
        expect(snapshot.containsKey('always_on'), isFalse);
        expect(snapshot['lockdown'], false);
        expect(snapshot['bytes_sent'], 0);
        expect(snapshot.containsKey('kill_switch_verified'), isFalse);
        expect(body['app_version'], '2.3.4');
        expect(body['app_build'], 46002);
        for (final secret in [
          'private-location',
          'private-name',
          'session-a',
          'user-a',
          'client@example.test',
        ]) {
          expect(report.json, isNot(contains(secret)));
        }
        expect(h.transport.requests, isEmpty);
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.api.ipRequests, isEmpty);
        await h.controller.exportDiagnosticReport();
        expect(h.tunnel.exported, report.json);
      },
    );

    test(
      'diagnostic unauthorized does not invalidate the VPN session',
      () async {
        final h = await _diagnosticHarness();
        addTearDown(h.close);
        h.transport.status = 401;
        h.tunnel.state = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
        );
        h.controller.tunnelState = h.tunnel.state;
        await h.controller.runDiagnostics(sendReport: true);
        expect(h.transport.requests, hasLength(1));
        expect(h.controller.isSignedIn, isTrue);
        expect(h.controller.token, 'session-a');
        expect(h.controller.isConnected, isTrue);
        expect(h.store.clearSessionCalls, 0);
        expect(h.tunnel.disconnectCalls, 0);
        expect(
          h.controller.diagnosticStatus,
          DiagnosticStatus.authenticationRequired,
        );
      },
    );

    test(
      'logout during collection discards the prepared account report',
      () async {
        final h = await _diagnosticHarness();
        addTearDown(h.close);
        final gate = Completer<void>();
        h.tunnel.metadataGate = gate;
        final pending = h.controller.runDiagnostics(sendReport: true);
        await Future<void>.delayed(Duration.zero);
        await h.controller.signOut();
        gate.complete();
        await pending;
        expect(h.controller.diagnosticReport, isNull);
        expect(h.transport.requests, isEmpty);
        expect(h.controller.diagnosticsBusy, isFalse);
      },
    );

    test('signed-out collection is local and cannot upload', () async {
      final h = await _diagnosticHarness(signedIn: false);
      addTearDown(h.close);
      await h.controller.runDiagnostics(sendReport: true);
      expect(h.controller.diagnosticReport, isNotNull);
      expect(h.transport.requests, isEmpty);
      expect(
        h.controller.diagnosticStatus,
        DiagnosticStatus.authenticationRequired,
      );
    });

    test(
      'automatic consent is off by default and persistently revocable',
      () async {
        final h = await _diagnosticHarness();
        addTearDown(h.close);
        expect(h.controller.automaticDiagnostics, isFalse);
        await h.controller.setAutomaticDiagnostics(true);
        expect(h.controller.automaticDiagnostics, isTrue);
        expect(h.preferences.enabled, isTrue);
        h.preferences.failWrite = true;
        await h.controller.setAutomaticDiagnostics(false);
        expect(h.controller.automaticDiagnostics, isFalse);
        expect(h.controller.diagnosticsPreferenceFailed, isTrue);
        expect(h.transport.requests, isEmpty);
      },
    );

    test(
      'an unobserved state never produces successful checks from cached data',
      () async {
        final h = await _diagnosticHarness();
        addTearDown(h.close);
        h.controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          sentBytes: 12,
          receivedBytes: 15,
        );
        h.tunnel.failState = true;
        await h.controller.runDiagnostics(sendReport: false);
        final body = h.controller.diagnosticReport!.toJson();
        expect(body['state'], 'unknown');
        final snapshot = body['snapshot'] as Map;
        expect(snapshot.containsKey('bytes_sent'), isFalse);
        expect(snapshot.containsKey('freshness_ms'), isFalse);
        expect(
          (body['checks'] as List).where(
            (dynamic c) => c['result'] == 'passed',
          ),
          isEmpty,
        );
      },
    );
  });
}

Future<_DiagnosticsHarness> _diagnosticHarness({bool signedIn = true}) async {
  final api = _FakeApi()
    ..loginResult = _session('session-a')
    ..profilesByToken['session-a'] = _profile('user-a')
    ..deviceListResult = const DeviceList(limit: 2, devices: [])
    ..deviceConfiguration = _wireGuardConfiguration;
  final tunnel = _DiagnosticTunnel();
  final store = _FakeSessionStore()..tunnel = tunnel;
  final preferences = _DiagnosticPreferences();
  final transport = _DiagnosticTransport();
  final service = DiagnosticService(
    transport: transport,
    baseUri: Uri.parse('https://synthetic.invalid/'),
    scheduleRetries: false,
  );
  final controller = VpnAppController(
    api: api,
    sessionStore: store,
    preferences: preferences,
    tunnel: tunnel,
    diagnostics: service,
  );
  await controller.initialize();
  if (signedIn) {
    expect(
      await controller.signIn(email: 'client@example.test', password: 'secret'),
      isTrue,
    );
  }
  return _DiagnosticsHarness(
    api,
    tunnel,
    store,
    preferences,
    transport,
    controller,
  );
}

class _DiagnosticsHarness {
  _DiagnosticsHarness(
    this.api,
    this.tunnel,
    this.store,
    this.preferences,
    this.transport,
    this.controller,
  );
  final _FakeApi api;
  final _DiagnosticTunnel tunnel;
  final _FakeSessionStore store;
  final _DiagnosticPreferences preferences;
  final _DiagnosticTransport transport;
  final VpnAppController controller;
  Future<void> close() async {
    controller.dispose();
    await tunnel._stateEvents.close();
  }
}

class _DiagnosticPreferences extends _FakePreferences
    implements DiagnosticPreferenceStore {
  bool enabled = false;
  bool failWrite = false;
  Completer<void>? firstWriteGate;
  int writes = 0;
  @override
  Future<bool> readAutomaticDiagnostics() async => enabled;
  @override
  Future<void> writeAutomaticDiagnostics(bool value) async {
    if (++writes == 1) await firstWriteGate?.future;
    if (failWrite) throw StateError('storage');
    enabled = value;
  }
}

class _DiagnosticTunnel extends _FakeTunnel
    implements DiagnosticPlatformGateway {
  String? exported;
  Completer<void>? metadataGate;
  bool failState = false;
  @override
  Future<VpnRuntimeState> diagnosticSnapshot() async {
    if (failState) throw StateError('unavailable');
    return state;
  }

  @override
  Future<VpnRuntimeState> getState() async {
    if (failState) throw StateError('unavailable');
    return state;
  }

  @override
  Future<Map<String, Object?>> diagnosticMetadata() async {
    await metadataGate?.future;
    return {
      'app_version': '2.3.4',
      'app_build': 46002,
      'environment': {
        'os_family': 'android',
        'android_sdk': 35,
        'build_mode': 'release',
      },
    };
  }

  @override
  Future<bool> exportDiagnosticReport(String json) async {
    exported = json;
    return true;
  }
}

class _DiagnosticTransport extends ApiHttpTransport {
  int status = 201;
  final requests = <ApiHttpRequest>[];
  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async {
    requests.add(request);
    final body = jsonDecode(request.body!) as Map;
    final now = DateTime.now().toUtc();
    return ApiHttpResponse(
      statusCode: status,
      headers: {},
      body: jsonEncode(
        status == 201
            ? {
                'status': 'received',
                'duplicate': false,
                'report_id': '11111111-1111-4111-8111-111111111111',
                'client_report_id': body['report_id'],
                'received_at': now.toIso8601String(),
                'expires_at': now
                    .add(const Duration(days: 30))
                    .toIso8601String(),
              }
            : {'error': 'unauthorized'},
      ),
    );
  }
}
