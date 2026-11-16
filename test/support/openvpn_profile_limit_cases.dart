part of '../app_controller_test.dart';

/// OpenVPN profile creation and renewal are limited to six attempts an hour
/// per device. The API's 429 names the seconds left in that hour
/// (Retry-After): the app says when to try again and sends nothing before.
/// Once the certificate a CSR obtained has expired, the API answers 409
/// openvpn_renewal_expired (a 503 each time before): only a new key renews.
void openVpnProfileLimitTests() {
  // A connection that creates the profile, one that renews a certificate that
  // is due, and the renewal button of the connection options.
  const modes = ['create', 'renewal', 'explicit-renewal'];

  Future<_RestoredHarness> limitHarness(String mode) async {
    final h = await _restoredHarness(events: []);
    h.api.deviceConfiguration = _wireGuardConfigurationFor('device-current');
    h.api.openVpnActivation = _openVpnActivation('device-current');
    await h.controller.selectProtocol(VpnProtocol.openVpn);
    h.tunnel.openVpnCertificateStatus = mode == 'create'
        ? const OpenVpnCertificateStatus(
            phase: OpenVpnCertificatePhase.missing,
            renewalPending: false,
          )
        : OpenVpnCertificateStatus(
            phase: OpenVpnCertificatePhase.expiring,
            notAfter: DateTime.utc(2026, 11, 20, 12),
            renewalPending: false,
          );
    return h;
  }

  Future<void> start(_RestoredHarness h, String mode) =>
      mode == 'explicit-renewal'
      ? h.controller.renewOpenVpnProfile()
      : h.controller.connect();

  int sent(_RestoredHarness h) =>
      h.api.createOpenVpnCalls.length + h.api.renewOpenVpnCalls;

  group('OpenVPN profile limits', () {
    for (final mode in modes) {
      test('$mode: a 429 says when to try again, and nothing is sent '
          'before', () async {
        final h = await limitHarness(mode);
        addTearDown(h.close);
        const refusal = ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 1800,
        );
        h.api.createOpenVpnFailure = refusal;
        h.api.renewOpenVpnFailure = refusal;

        await start(h, mode);
        expect(sent(h), 1);
        expect(h.tunnel.openVpnConnections, isEmpty);
        expect(h.controller.notice?.messageKey, 'notice.retryAfter');
        expect(h.controller.notice?.arguments['code'], 'rate_limited');
        expect(h.controller.notice?.arguments['seconds'], 1800);
        // Native code keeps the deadline: its own renewals wait for it too.
        expect(h.tunnel.deferredOpenVpnRequests, [
          'user-a/device-current 1800',
        ]);

        // Ten minutes later, as native code counts them.
        h.api.createOpenVpnFailure = null;
        h.api.renewOpenVpnFailure = null;
        h.tunnel.openVpnRetryAfterSeconds = 1200;
        h.controller.clearNotice();
        await start(h, mode);
        expect(sent(h), 1, reason: 'a request was sent before Retry-After');
        expect(h.tunnel.openVpnConnections, isEmpty);
        expect(h.controller.notice?.messageKey, 'notice.retryAfter');
        expect(h.controller.notice?.arguments['code'], 'rate_limited');
        expect(h.controller.notice?.arguments['seconds'], 1200);
        expect(h.tunnel.deferredOpenVpnRequests, hasLength(1));
        expect(h.controller.isConnecting, isFalse);

        // The hour is over: the request goes out and the tunnel starts.
        h.tunnel.openVpnRetryAfterSeconds = null;
        h.controller.clearNotice();
        await start(h, mode);
        expect(sent(h), 2);
        expect(h.tunnel.openVpnConnections, hasLength(1));
        expect(h.controller.notice, isNull);
      });

      test('$mode: an expired renewal is renewed at once with a new '
          'key', () async {
        final h = await limitHarness(mode);
        addTearDown(h.close);
        final String first = mode == 'create'
            ? 'createOpenVpnProfile'
            : 'renewOpenVpnProfile';
        h.api.ipFailures[first] = [
          const ApiException(
            statusCode: 409,
            errorCode: 'openvpn_renewal_expired',
          ),
        ];
        final String original = h.tunnel.openVpnCsr;

        await start(h, mode);
        expect(h.controller.notice, isNull);
        expect(h.api.csrRequests, [
          (first, original),
          ('renewOpenVpnProfile', 'new-key-1-csr'),
        ]);
        expect(h.tunnel.openVpnCsrCalls.last.renewal, isTrue);
        expect(h.tunnel.openVpnCsrCalls.last.replacePending, isTrue);
        expect(
          h.tunnel.openVpnCsrCalls.where((call) => call.replacePending),
          hasLength(1),
        );
        expect(h.tunnel.openVpnConnections, hasLength(1));
        expect(h.tunnel.openVpnConnections.single.renewal, isTrue);
      });
    }

    test('a new key the API also finds expired is not renewed a third '
        'time', () async {
      final h = await limitHarness('renewal');
      addTearDown(h.close);
      h.api.renewOpenVpnFailure = const ApiException(
        statusCode: 409,
        errorCode: 'openvpn_renewal_expired',
      );
      await h.controller.connect();
      expect(h.api.csrRequests, hasLength(2));
      expect(h.tunnel.openVpnConnections, isEmpty);
      expect(h.controller.notice?.messageKey, 'notice.api.message');
      expect(h.controller.notice?.arguments['code'], 'openvpn_renewal_expired');
    });

    // A recovery, a tile click or a restore renewed without the application
    // and the API refused it for its rate: the error names when to retry.
    test('a native renewal refused for its rate says when to try '
        'again', () async {
      final h = await _restoredHarness(events: []);
      addTearDown(h.close);
      await pumpEventQueue();
      final DateTime retryAt = DateTime.now().add(const Duration(minutes: 30));
      h.tunnel.emitState(
        VpnRuntimeState.fromWire(<Object?, Object?>{
          'status': 'error',
          'protocol': 'openvpn',
          'message_code': 'openvpn_renewal_rate_limited',
          'retry_at': retryAt.millisecondsSinceEpoch,
        }),
      );
      await pumpEventQueue();
      final AppNotice? notice = h.controller.notice;
      expect(notice?.titleKey, 'notice.native.title');
      expect(notice?.arguments['code'], 'openvpn_renewal_rate_limited');
      expect(notice?.messageKey, 'notice.retryAfter');
      expect(notice?.arguments['seconds'], inInclusiveRange(1790, 1800));

      // Without a deadline (or once it has passed), the native text remains.
      h.controller.clearNotice();
      h.tunnel.emitState(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
      await pumpEventQueue();
      h.tunnel.emitState(
        VpnRuntimeState.fromWire(<Object?, Object?>{
          'status': 'error',
          'protocol': 'openvpn',
          'message_code': 'openvpn_renewal_rate_limited',
          'retry_at': DateTime.now()
              .subtract(const Duration(seconds: 5))
              .millisecondsSinceEpoch,
        }),
      );
      await pumpEventQueue();
      expect(h.controller.notice?.messageKey, 'notice.native.message');
      expect(
        h.controller.notice?.arguments['code'],
        'openvpn_renewal_rate_limited',
      );
    });

    String french(AppNotice? notice, String key) => AppCopy.resolve(
      lookupAppLocalizations(const Locale('fr')),
      key,
      arguments: notice?.arguments ?? const <String, Object?>{},
    );

    test('the delays read in minutes', () async {
      final h = await limitHarness('create');
      addTearDown(h.close);
      h.api.createOpenVpnFailure = const ApiException(
        statusCode: 429,
        errorCode: 'rate_limited',
        retryAfterSeconds: 1790,
      );
      await h.controller.connect();
      AppNotice? notice = h.controller.notice;
      expect(french(notice, notice!.titleKey), 'Trop de tentatives');
      expect(french(notice, notice.messageKey), 'Réessayez dans 30 minutes.');

      h.controller.clearNotice();
      h.tunnel.emitState(
        VpnRuntimeState.fromWire(<Object?, Object?>{
          'status': 'error',
          'protocol': 'openvpn',
          'message_code': 'openvpn_renewal_rate_limited',
          'retry_at': DateTime.now()
              .add(const Duration(minutes: 12))
              .millisecondsSinceEpoch,
        }),
      );
      await pumpEventQueue();
      notice = h.controller.notice;
      expect(french(notice, notice!.titleKey), 'Trop de tentatives');
      expect(french(notice, notice.messageKey), 'Réessayez dans 12 minutes.');
    });
  });
}
