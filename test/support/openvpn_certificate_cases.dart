part of '../app_controller_test.dart';

OpenVpnCertificateStatus _certificate(
  OpenVpnCertificatePhase phase,
  DateTime notAfter, {
  bool renewalPending = false,
}) => OpenVpnCertificateStatus(
  phase: phase,
  notAfter: notAfter,
  renewalPending: renewalPending,
);

const OpenVpnCertificateStatus _noCertificate = OpenVpnCertificateStatus(
  phase: OpenVpnCertificatePhase.missing,
  renewalPending: false,
);

/// OpenVPN certificates last 90 days. Connections and the native reconnections
/// renew one that is due; the connection options show its lifetime and offer
/// the renewal that no screen offered before.
void openVpnCertificateTests() {
  // Midday UTC: the same calendar day in every time zone of a test machine.
  final DateTime soon = DateTime.utc(2026, 11, 15, 12);
  final DateTime renewed = DateTime.utc(2027, 2, 13, 12);

  group('OpenVPN certificate lifetime', () {
    test('a restored account publishes its stored certificate, and nothing '
        'without one', () async {
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) => tunnel.openVpnCertificateStatus =
            _certificate(OpenVpnCertificatePhase.valid, renewed),
      );
      addTearDown(h.close);
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate?.notAfter, renewed);
      expect(h.controller.openVpnCertificate?.requiresRenewal, isFalse);
      expect(
        h.tunnel.certificateStatusReads,
        contains('user-a/device-current'),
      );

      final none = await _restoredHarness(events: []);
      addTearDown(none.close);
      await pumpEventQueue();
      expect(none.controller.openVpnCertificate, isNull);
      expect(none.controller.canRenewOpenVpnCertificate, isFalse);
    });

    test('a reconnection that renewed the certificate without the application '
        'is read again from the tunnel state', () async {
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) => tunnel.openVpnCertificateStatus =
            _certificate(OpenVpnCertificatePhase.expiring, soon),
      );
      addTearDown(h.close);
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate?.requiresRenewal, isTrue);
      var notifications = 0;
      h.controller.addListener(() => notifications++);

      // What a recovery, a tile click or a system restore leaves behind.
      h.tunnel.openVpnCertificateStatus = _certificate(
        OpenVpnCertificatePhase.valid,
        renewed,
      );
      h.tunnel.emitConnected(VpnProtocol.openVpn);
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate?.notAfter, renewed);
      expect(h.controller.openVpnCertificate?.requiresRenewal, isFalse);
      expect(notifications, greaterThanOrEqualTo(2));

      // Counter samples of the same connected tunnel read nothing.
      final reads = h.tunnel.certificateStatusReads.length;
      h.tunnel.emitState(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.openVpn,
          receivedBytes: 4096,
          sentBytes: 512,
        ),
      );
      await pumpEventQueue();
      expect(h.tunnel.certificateStatusReads, hasLength(reads));
    });

    test('a failed read shows nothing and a late answer for another device is '
        'dropped', () async {
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) => tunnel.openVpnCertificateStatus =
            _certificate(OpenVpnCertificatePhase.valid, renewed),
      );
      addTearDown(h.close);
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate, isNotNull);

      h.tunnel.hooks['getOpenVpnCertificateStatus'] = () async =>
          throw const NativeVpnException('secure_storage_read_failed');
      h.tunnel.emitState(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate, isNull);
      expect(h.controller.notice, isNull);

      final answer = Completer<void>();
      h.tunnel.hooks['getOpenVpnCertificateStatus'] = () => answer.future;
      h.tunnel.emitState(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await pumpEventQueue();
      h.controller.currentDeviceId = 'device-other';
      answer.complete();
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate, isNull);
    });

    test('renewal is offered from a settled state only', () async {
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) => tunnel.openVpnCertificateStatus =
            _certificate(OpenVpnCertificatePhase.valid, renewed),
      );
      addTearDown(h.close);
      await pumpEventQueue();
      expect(h.controller.canRenewOpenVpnCertificate, isTrue);

      h.tunnel.emitState(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connecting,
          protocol: VpnProtocol.openVpn,
        ),
      );
      await pumpEventQueue();
      expect(h.controller.canRenewOpenVpnCertificate, isFalse);

      h.tunnel.emitConnected(VpnProtocol.openVpn);
      await pumpEventQueue();
      expect(h.controller.canRenewOpenVpnCertificate, isTrue);

      h.tunnel.openVpnCertificateStatus = _noCertificate;
      h.tunnel.emitState(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate, isNull);
      expect(h.controller.canRenewOpenVpnCertificate, isFalse);
    });

    test('renewal is not offered where the location has no OpenVPN', () async {
      const wireGuardOnly = Location(
        id: 'paris-01',
        city: 'Paris',
        countryCode: 'FR',
        displayName: 'Paris 1',
        supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard},
      );
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) {
          api.locationsResult = const <Location>[wireGuardOnly];
          api.deviceListResult = _devices(
            'device-current',
            location: wireGuardOnly,
          );
          tunnel.openVpnCertificateStatus = _certificate(
            OpenVpnCertificatePhase.valid,
            renewed,
          );
        },
      );
      addTearDown(h.close);
      await pumpEventQueue();
      expect(h.controller.openVpnCertificate, isNotNull);
      expect(h.controller.canRenewOpenVpnCertificate, isFalse);
    });

    Future<void> showOptions(
      WidgetTester tester,
      VpnAppController controller, {
      Locale locale = const Locale('fr'),
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FuzeVpnTheme.light(),
          locale: locale,
          localizationsDelegates: AppLocalizationDelegates.all,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ListenableBuilder(
              listenable: controller,
              builder: (context, _) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ProtocolOptions(controller: controller),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();
    }

    testWidgets('the options show the lifetime and renew on request', (
      tester,
    ) async {
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) {
          api.openVpnActivation = _openVpnActivation('device-current');
          tunnel.openVpnCertificateStatus = _certificate(
            OpenVpnCertificatePhase.expiring,
            soon,
          );
        },
      );
      addTearDown(h.close);
      await tester.pump();

      // WireGuard is selected: its options name no certificate.
      await showOptions(tester, h.controller);
      expect(find.text('Certificat OpenVPN'), findsNothing);

      await h.controller.selectProtocol(VpnProtocol.openVpn);
      await tester.pumpAndSettle();
      expect(find.text('Certificat OpenVPN'), findsOneWidget);
      expect(find.text('Valable jusqu’au 15 novembre 2026'), findsOneWidget);
      const hint = 'Renouvelé automatiquement à la prochaine connexion.';
      expect(find.text(hint), findsOneWidget);

      h.tunnel.hooks['connectOpenVpn'] = () async {
        h.tunnel.openVpnCertificateStatus = _certificate(
          OpenVpnCertificatePhase.valid,
          renewed,
        );
      };
      await tester.tap(find.widgetWithText(TextButton, 'Renouveler'));
      await tester.pumpAndSettle();
      expect(h.api.renewOpenVpnCalls, 1);
      expect(h.api.createOpenVpnCalls, isEmpty);
      expect(h.tunnel.openVpnCsrCalls.single.renewal, isTrue);
      expect(h.tunnel.openVpnConnections.single.renewal, isTrue);
      expect(h.controller.notice, isNull);

      h.tunnel.emitConnected(VpnProtocol.openVpn);
      await tester.pumpAndSettle();
      expect(find.text('Valable jusqu’au 13 février 2027'), findsOneWidget);
      expect(find.text(hint), findsNothing);

      // A connected tunnel samples its counters every second: end it here.
      h.tunnel.emitState(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await tester.pumpAndSettle();
    });

    testWidgets('an expired certificate says so, and the button is disabled '
        'while a tunnel is being started', (tester) async {
      final h = await _restoredHarness(
        events: [],
        prepare: (api, store, tunnel) => tunnel.openVpnCertificateStatus =
            _certificate(OpenVpnCertificatePhase.expired, soon),
      );
      addTearDown(h.close);
      await h.controller.selectProtocol(VpnProtocol.openVpn);
      await tester.pump();
      await showOptions(tester, h.controller);
      expect(find.text('Expiré le 15 novembre 2026'), findsOneWidget);
      expect(
        find.text('Renouvelé automatiquement à la prochaine connexion.'),
        findsOneWidget,
      );
      final renew = find.widgetWithText(TextButton, 'Renouveler');
      expect(tester.widget<TextButton>(renew).onPressed, isNotNull);

      h.tunnel.emitState(
        const VpnRuntimeState(
          phase: VpnRuntimePhase.connecting,
          protocol: VpnProtocol.openVpn,
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.widget<TextButton>(renew).onPressed, isNull);
    });

    for (final language in ['fr', 'de', 'si', 'ne', 'hi', 'km', 'ar', 'ja']) {
      testWidgets('the certificate row fits 320dp at 200% text in $language', (
        tester,
      ) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final h = await _restoredHarness(
          events: [],
          prepare: (api, store, tunnel) => tunnel.openVpnCertificateStatus =
              _certificate(OpenVpnCertificatePhase.expiring, soon),
        );
        addTearDown(h.close);
        await h.controller.selectProtocol(VpnProtocol.openVpn);
        await tester.pump();
        await showOptions(tester, h.controller, locale: Locale(language));
        expect(
          find.byKey(const ValueKey('openvpn-certificate-validity')),
          findsOneWidget,
        );
        expect(
          find.byKey(const ValueKey('openvpn-certificate-renew')),
          findsOneWidget,
        );
        expect(
          find.byKey(const ValueKey('openvpn-certificate-auto-renewal')),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      });
    }
  });
}
