import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_client.dart'
    show ApiHttpTransport, ApiHttpRequest, ApiHttpResponse;
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/connection_timing.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/core/google_auth.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

part 'support/api_refresh_cases.dart';
part 'support/audit_regression_cases.dart';
part 'support/diagnostics_controller_cases.dart';
part 'support/favorite_controller_cases.dart';
part 'support/google_controller_cases.dart';
part 'support/location_change_controller_cases.dart';
part 'support/location_capacity_controller_cases.dart';
part 'support/wireguard_roaming_cases.dart';

const Location _frankfurt = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 1',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard, VpnProtocol.openVpn},
);

const Location _frankfurt02 = Location(
  id: 'frankfurt-02',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 2',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard, VpnProtocol.openVpn},
);

UserProfile _profile(String userId) => UserProfile(
  userId: userId,
  email: '$userId@example.test',
  firstName: 'Client',
  lastName: 'Test',
  phone: '+33600000000',
  addressLine1: '1 rue Exemple',
  addressLine2: '',
  postalCode: '75001',
  city: 'Paris',
  countryCode: 'FR',
  emailVerified: true,
);

AuthSession _session(String token) =>
    AuthSession(accessToken: token, expiresAt: DateTime.utc(2099, 1, 1));

DeviceList _devices(String deviceId, {Location location = _frankfurt}) =>
    DeviceList(
      limit: 2,
      devices: <VpnDevice>[
        VpnDevice(
          deviceId: deviceId,
          name: 'FuzeVPN Android',
          location: location,
          createdAt: DateTime.utc(2026, 8, 10),
          profiles: const <VpnProfile>[
            VpnProfile(protocol: VpnProtocol.wireGuard, status: 'active'),
          ],
        ),
      ],
    );

const DeviceConfiguration _wireGuardConfiguration = DeviceConfiguration(
  deviceId: 'device-android',
  address: '10.10.0.2/32',
  dns: <String>['1.1.1.1', '1.0.0.1'],
  serverPublicKey: 'server-public-key-only',
  endpoint: '198.51.100.10:51820',
  allowedIps: <String>['0.0.0.0/0'],
);

DeviceConfiguration _wireGuardConfigurationFor(String deviceId) =>
    DeviceConfiguration(
      deviceId: deviceId,
      address: '10.10.0.2/32',
      dns: const <String>['1.1.1.1', '1.0.0.1'],
      serverPublicKey: 'server-public-key-only',
      endpoint: '198.51.100.10:51820',
      allowedIps: const <String>['0.0.0.0/0'],
    );

OpenVpnActivation _openVpnActivation([String deviceId = 'device-android']) =>
    OpenVpnActivation(
      deviceId: deviceId,
      protocol: 'openvpn',
      certificatePem: 'certificate-response-only',
      caCertificatePem: 'ca-response-only',
      tlsCryptV2ClientKey: 'tls-crypt-response-only',
      endpoint: '198.51.100.10',
      dns: const <String>['1.1.1.1'],
      address: '10.20.0.2/32',
      serverName: 'frankfurt-01.openvpn.fuzevpn.internal',
      remoteCertTlsServer: true,
      ciphers: const <String>['AES-256-GCM', 'CHACHA20-POLY1305'],
      notAfter: DateTime.utc(2027, 1, 1),
    );

DeviceLocationMigration _locationMigration({
  required LocationMigrationStatus status,
  String deviceId = 'device-current',
  String targetLocationId = 'frankfurt-02',
  int? retryAfterSeconds,
}) => DeviceLocationMigration(
  migrationId: 'migration-test',
  deviceId: deviceId,
  sourceLocationId: _frankfurt.id,
  targetLocationId: targetLocationId,
  status: status,
  retryAfterSeconds: retryAfterSeconds,
);

void main() {
  locationCapacityControllerTests();
  locationChangeControllerTests();
  favoriteControllerTests();
  diagnosticsControllerTests();
  wireGuardRoamingTests();
  auditRegressionTests();
  apiRefreshTests();
  googleControllerTests();
  group('VPN disclosure cancellation', () {
    test(
      'WireGuard cancellation is silent and leaves identity ready for retry',
      () async {
        final h = await _restoredHarness(events: []);
        addTearDown(h.close);
        h.api.deviceConfiguration = _wireGuardConfigurationFor(
          'device-current',
        );
        final session = h.store.storedSession;
        final devices = Map<String, String>.from(h.store.deviceIds);
        final publicKey = h.tunnel.wireGuardPublicKey;
        final csr = h.tunnel.openVpnCsr;
        final certificate = h.tunnel.openVpnCertificateStatus;
        var disclosureRequests = 0;
        h.tunnel.hooks['requestVpnPermission'] = () async {
          disclosureRequests += 1;
          throw const VpnDisclosureCancelled();
        };

        await h.controller.connect();

        expect(disclosureRequests, 1);
        expect(h.controller.notice, isNull);
        expect(h.controller.isConnecting, isFalse);
        expect(h.controller.isSignedIn, isTrue);
        expect(h.controller.profile?.userId, 'user-a');
        expect(h.controller.currentDeviceId, 'device-current');
        expect(h.store.storedSession, same(session));
        expect(h.store.deviceIds, devices);
        expect(h.store.clearSessionCalls, 0);
        expect(h.tunnel.wireGuardPublicKey, publicKey);
        expect(h.tunnel.openVpnCsr, csr);
        expect(h.tunnel.openVpnCertificateStatus, same(certificate));
        expect(h.tunnel.wireGuardKeyAccounts, isEmpty);
        expect(h.tunnel.openVpnCsrCalls, isEmpty);
        expect(h.tunnel.clearedAccountIds, isEmpty);
        expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
        expect(h.api.registerDeviceCalls, isEmpty);
        expect(h.api.createOpenVpnCalls, isEmpty);
        expect(h.api.renewOpenVpnCalls, 0);
        expect(h.tunnel.wireGuardConnections, isEmpty);
        expect(h.tunnel.openVpnConnections, isEmpty);

        h.tunnel.hooks.remove('requestVpnPermission');
        await h.controller.connect();

        expect(h.tunnel.wireGuardConnections, hasLength(1));
        expect(h.tunnel.openVpnConnections, isEmpty);
        expect(h.tunnel.wireGuardConnections.single.accountId, 'user-a');
        expect(h.store.deviceIds, devices);
        expect(h.controller.isConnecting, isFalse);
      },
    );

    test(
      'OpenVPN renewal cancellation is silent and preserves its certificate',
      () async {
        final h = await _restoredHarness(
          events: [],
          prepare: (api, store, tunnel) {
            api.openVpnActivation = _openVpnActivation('device-current');
            tunnel.openVpnCertificateStatus = OpenVpnCertificateStatus(
              phase: OpenVpnCertificatePhase.expired,
              notAfter: DateTime.utc(2026, 8, 1),
              renewalPending: false,
            );
          },
        );
        addTearDown(h.close);
        final session = h.store.storedSession;
        final devices = Map<String, String>.from(h.store.deviceIds);
        final publicKey = h.tunnel.wireGuardPublicKey;
        final csr = h.tunnel.openVpnCsr;
        final certificate = h.tunnel.openVpnCertificateStatus;
        var disclosureRequests = 0;
        h.tunnel.hooks['requestVpnPermission'] = () async {
          disclosureRequests += 1;
          throw const VpnDisclosureCancelled();
        };

        await h.controller.renewOpenVpnProfile();

        expect(disclosureRequests, 1);
        expect(h.controller.notice, isNull);
        expect(h.controller.isConnecting, isFalse);
        expect(h.controller.isSignedIn, isTrue);
        expect(h.controller.profile?.userId, 'user-a');
        expect(h.controller.currentDeviceId, 'device-current');
        expect(h.store.storedSession, same(session));
        expect(h.store.deviceIds, devices);
        expect(h.store.clearSessionCalls, 0);
        expect(h.tunnel.wireGuardPublicKey, publicKey);
        expect(h.tunnel.openVpnCsr, csr);
        expect(h.tunnel.openVpnCertificateStatus, same(certificate));
        expect(h.tunnel.openVpnCsrCalls, isEmpty);
        expect(h.tunnel.clearedAccountIds, isEmpty);
        expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
        expect(h.api.registerDeviceCalls, isEmpty);
        expect(h.api.createOpenVpnCalls, isEmpty);
        expect(h.api.renewOpenVpnCalls, 0);
        expect(h.tunnel.wireGuardConnections, isEmpty);
        expect(h.tunnel.openVpnConnections, isEmpty);

        h.tunnel.hooks.remove('requestVpnPermission');
        await h.controller.renewOpenVpnProfile();

        expect(h.api.renewOpenVpnCalls, 1);
        expect(h.api.createOpenVpnCalls, isEmpty);
        expect(h.tunnel.openVpnCsrCalls, hasLength(1));
        expect(h.tunnel.openVpnCsrCalls.single.renewal, isTrue);
        expect(h.tunnel.openVpnConnections, hasLength(1));
        expect(h.tunnel.openVpnConnections.single.renewal, isTrue);
        expect(h.tunnel.wireGuardConnections, isEmpty);
        expect(h.store.deviceIds, devices);
        expect(h.controller.isConnecting, isFalse);
      },
    );
  });
  group('system VPN protection handoff', () {
    test(
      'prepares an explicit connection before control-plane activity',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);

        await h.controller.connect();

        expect(h.tunnel.preparedTunnelRequests, <String>['user-a']);
        expect(h.api.ipRequests, isNotEmpty);
      },
    );

    test(
      'user disconnect opens Android settings while always-on is unknown',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.tunnel.state = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
        );
        h.controller.tunnelState = h.tunnel.state;

        await h.controller.requestUserDisconnect();

        expect(h.tunnel.openVpnSettingsCalls, 1);
        expect(h.tunnel.disconnectCalls, 0);
      },
    );

    test('user disconnect stops normally only when always-on is off', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      h.tunnel.systemProtection = const SystemVpnProtection(
        alwaysOn: false,
        lockdown: false,
      );
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
        systemProtection: SystemVpnProtection(alwaysOn: false, lockdown: false),
      );

      await h.controller.requestUserDisconnect();

      expect(h.tunnel.openVpnSettingsCalls, 0);
      expect(h.tunnel.disconnectByUserCalls, 1);
      expect(h.tunnel.disconnectCalls, 1);
    });

    test('user stop failure keeps the native stop error actionable', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      h.tunnel.systemProtection = const SystemVpnProtection(
        alwaysOn: false,
        lockdown: false,
      );
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      h.tunnel.disconnectFailure = const NativeVpnException(
        'wireguard_stop_timeout',
      );
      await h.controller.requestUserDisconnect();
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.error);
      expect(h.controller.tunnelState.messageCode, 'wireguard_stop_timeout');
      expect(h.controller.notice, isNotNull);
    });

    test(
      'native always-on change during user stop cannot publish idle',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.tunnel.systemProtection = const SystemVpnProtection(
          alwaysOn: false,
          lockdown: false,
        );
        h.tunnel.state = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
        );
        h.controller.tunnelState = h.tunnel.state;
        h.tunnel.userDisconnectOpensSettings = true;
        await h.controller.requestUserDisconnect();
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.connected);
        expect(h.tunnel.disconnectCalls, 0);
        expect(h.tunnel.openVpnSettingsCalls, 1);
      },
    );

    test('resume refreshes protection locally without connecting', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      h.tunnel.systemProtection = const SystemVpnProtection(
        alwaysOn: true,
        lockdown: true,
        resumeState: SystemProtectionResumeState.ready,
      );

      await h.controller.onAppResumed();

      expect(h.controller.systemProtection.isActive, isTrue);
      expect(h.tunnel.wireGuardConnections, isEmpty);
      expect(h.tunnel.openVpnConnections, isEmpty);
      expect(h.api.ipRequests, isEmpty);
    });
  });
  const dualLocation = Location(
    id: 'frankfurt-01',
    city: 'Frankfurt',
    countryCode: 'DE',
    displayName: 'Frankfurt 1',
    supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
    supportsIpv6: true,
  );
  const unavailable6 = ApiException(
    statusCode: 503,
    errorCode: 'ipv6_unavailable',
  );
  group('IPv6 explicit activation', () {
    for (final protocol in VpnProtocol.values) {
      test(
        'refreshes public catalog for $protocol despite device projection',
        () async {
          final h = await _signedInHarness();
          addTearDown(h.close);
          h.api.locationsResult = [dualLocation];
          await h.controller.selectProtocol(protocol);
          await h.controller.connect();
          expect(h.api.ipRequests.first, ('registerDevice', true));
          if (protocol == VpnProtocol.openVpn) {
            expect(h.api.ipRequests.last, ('createOpenVpnProfile', true));
          }
          expect(
            h.tunnel.wireGuardConnections.length +
                h.tunnel.openVpnConnections.length,
            1,
          );
        },
      );
    }
    for (final capability in ['absent', 'unavailable']) {
      test('catalog $capability omits ip_families', () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        if (capability == 'unavailable') {
          h.api.locationsFailure = const ApiException(
            statusCode: 503,
            errorCode: 'target_unavailable',
          );
        }
        await h.controller.connect();
        expect(h.api.ipRequests, [('registerDevice', false)]);
        expect(h.tunnel.wireGuardConnections, hasLength(1));
      });
    }
    test(
      'enrollment fallback remains omitted during OpenVPN creation',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.api.locationsResult = [dualLocation];
        h.api.registerDeviceFailures.add(unavailable6);
        await h.controller.selectProtocol(VpnProtocol.openVpn);
        await h.controller.connect();
        expect(h.api.ipRequests, [
          ('registerDevice', true),
          ('registerDevice', false),
          ('createOpenVpnProfile', false),
        ]);
        expect(
          h.api.registerDeviceCalls.map((v) => v.publicKey).toSet(),
          hasLength(1),
        );
        expect(h.tunnel.openVpnConnections, hasLength(1));
        expect(h.controller.notice?.messageKey, 'network.ipv4Fallback');
      },
    );
    for (final renewal in [false, true]) {
      test(
        'OpenVPN ${renewal ? "renewal" : "creation"} fallback preserves CSR',
        () async {
          final h = await _signedInHarness();
          addTearDown(h.close);
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          if (renewal) await h.controller.connect();
          h.api.ipRequests.clear();
          h.api.locationsResult = [dualLocation];
          final method = renewal
              ? 'renewOpenVpnProfile'
              : 'createOpenVpnProfile';
          h.api.ipFailures[method] = [unavailable6];
          if (renewal) {
            await h.controller.renewOpenVpnProfile();
          } else {
            await h.controller.connect();
          }
          expect(
            h.api.ipRequests.where((v) => v.$1 == method).map((v) => v.$2),
            [true, false],
          );
          expect(
            h.api.csrRequests
                .where((v) => v.$1 == method)
                .map((v) => v.$2)
                .toSet(),
            hasLength(1),
          );
          expect(h.tunnel.openVpnConnections, hasLength(renewal ? 2 : 1));
        },
      );
    }
    for (final stage in [
      'prepareTunnelRequest',
      'locations',
      'registerDevice',
      'createOpenVpnProfile',
      'getOrCreateOpenVpnCsr',
      'requestVpnPermission',
    ]) {
      for (final action in ['disconnect', 'userDisconnect', 'signOut']) {
        test('$action during $stage prevents subsequent preparation', () async {
          final h = await _signedInHarness();
          addTearDown(h.close);
          h.api.locationsResult = [dualLocation];
          h.tunnel.systemProtection = const SystemVpnProtection(
            alwaysOn: false,
            lockdown: false,
          );
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          final entered = Completer<void>(), release = Completer<void>();
          Future<void> pause() {
            entered.complete();
            return release.future;
          }

          if (stage == 'prepareTunnelRequest' ||
              stage == 'getOrCreateOpenVpnCsr' ||
              stage == 'requestVpnPermission') {
            h.tunnel.hooks[stage] = pause;
          } else {
            h.api.hooks[stage] = pause;
          }
          h.api.ipFailures['createOpenVpnProfile'] = [unavailable6];
          h.api.registerDeviceFailures.add(unavailable6);
          final connect = h.controller.connect();
          await entered.future;
          if (action == 'disconnect') {
            await h.controller.disconnect();
          } else if (action == 'userDisconnect') {
            await h.controller.requestUserDisconnect();
          } else {
            await h.controller.signOut();
          }
          final before = h.api.ipRequests.length;
          release.complete();
          await connect;
          expect(h.api.ipRequests.length, lessThanOrEqualTo(before + 1));
          expect(h.tunnel.openVpnConnections, isEmpty);
          expect(h.tunnel.wireGuardConnections, isEmpty);
          expect(h.controller.isConnecting, isFalse);
        });
      }
    }
    test(
      'late fallback response after changing location cannot start tunnel',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.api.locationsResult = [dualLocation];
        h.api.registerDeviceFailures.add(unavailable6);
        final entered = Completer<void>(), release = Completer<void>();
        var calls = 0;
        h.api.hooks['registerDevice'] = () {
          if (++calls == 2) {
            entered.complete();
            return release.future;
          }
          return Future<void>.value();
        };
        final connecting = h.controller.connect();
        await entered.future;
        await h.controller.disconnect();
        await h.controller.selectLocation(_frankfurt02);
        release.complete();
        await connecting;
        expect(h.tunnel.wireGuardConnections, isEmpty);
        expect(h.controller.currentDeviceId, isNull);
        expect(h.controller.selectedLocation?.id, 'frankfurt-02');
      },
    );
  });

  group('OpenVPN profile revocation', () {
    for (final mode in [
      'create',
      'automatic-renewal',
      'pending-renewal',
      'explicit-renewal',
    ]) {
      test(
        'A4 $mode removes only the revoked identity and the next explicit connection uses a fresh CSR',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          h.api.deviceConfiguration = _wireGuardConfigurationFor(
            'device-current',
          );
          h.api.openVpnActivation = _openVpnActivation('device-current');
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          h.tunnel.openVpnCertificateStatus = OpenVpnCertificateStatus(
            phase: mode == 'automatic-renewal'
                ? OpenVpnCertificatePhase.expiring
                : OpenVpnCertificatePhase.valid,
            renewalPending: mode == 'pending-renewal',
          );
          const refusal = ApiException(
            statusCode: 409,
            errorCode: 'openvpn_profile_revoked',
          );
          h.api.createOpenVpnFailure = refusal;
          h.api.renewOpenVpnFailure = refusal;
          final originalCsr = h.tunnel.openVpnCsr;
          final originalWireGuardKey = h.tunnel.wireGuardPublicKey;
          final otherMigration = _locationMigration(
            deviceId: 'other-device',
            status: LocationMigrationStatus.blocked,
          );
          h.store.migrations['user-a/other-device'] = otherMigration;
          if (mode == 'explicit-renewal') {
            await h.controller.renewOpenVpnProfile();
          } else {
            await h.controller.connect();
          }
          expect(h.api.createOpenVpnCalls.length + h.api.renewOpenVpnCalls, 1);
          expect(h.tunnel.openVpnConnections, isEmpty);
          expect(h.tunnel.clearedOpenVpnIdentities, ['user-a/device-current']);
          expect(h.tunnel.clearedAccountIds, isEmpty);
          expect(h.tunnel.wireGuardPublicKey, originalWireGuardKey);
          expect(h.controller.currentDeviceId, 'device-current');
          expect(h.controller.token, 'session-a');
          expect(
            h.store.migrations['user-a/other-device'],
            same(otherMigration),
          );
          expect(h.api.revokeOpenVpnProfileIds, isEmpty);
          expect(h.controller.notice?.messageKey, 'openvpnCleanup.complete');
          expect(h.controller.openVpnRevocation, isNull);
          h.api.createOpenVpnFailure = null;
          h.api.renewOpenVpnFailure = null;
          await h.controller.connect();
          expect(h.api.createOpenVpnCalls.last.csrPem, isNot(originalCsr));
          expect(h.tunnel.openVpnCsrCalls.last.renewal, isFalse);
          expect(h.tunnel.openVpnConnections, hasLength(1));
        },
      );
    }

    test(
      'a network failure after cleanup preserves the new CSR for idempotent retry',
      () async {
        final h = await _restoredHarness(events: []);
        addTearDown(h.close);
        h.api.deviceConfiguration = _wireGuardConfigurationFor(
          'device-current',
        );
        h.api.openVpnActivation = _openVpnActivation('device-current');
        await h.controller.selectProtocol(VpnProtocol.openVpn);
        h.api.createOpenVpnFailure = const ApiException(
          statusCode: 409,
          errorCode: 'openvpn_profile_revoked',
        );
        await h.controller.connect();
        h.api.createOpenVpnFailure = const ApiNetworkException();
        await h.controller.connect();
        h.api.createOpenVpnFailure = null;
        await h.controller.connect();
        expect(h.api.createOpenVpnCalls, hasLength(3));
        expect(
          h.api.createOpenVpnCalls[0].csrPem,
          isNot(h.api.createOpenVpnCalls[1].csrPem),
        );
        expect(
          h.api.createOpenVpnCalls[1].csrPem,
          h.api.createOpenVpnCalls[2].csrPem,
        );
        expect(h.tunnel.revocationCleanupCalls, hasLength(1));
      },
    );

    for (final replacement in [
      'same-account',
      'another-account',
      'device',
      'csr',
    ]) {
      test(
        'late revocation cannot remove a replacement $replacement',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          h.api.deviceConfiguration = _wireGuardConfigurationFor(
            'device-current',
          );
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          final entered = Completer<void>();
          final release = Completer<void>();
          h.api.hooks['createOpenVpnProfile'] = () async {
            entered.complete();
            await release.future;
            throw const ApiException(
              statusCode: 409,
              errorCode: 'openvpn_profile_revoked',
            );
          };
          final connecting = h.controller.connect();
          await entered.future;
          if (replacement.endsWith('account')) {
            await h.controller.signOut();
            h.api.loginResult = _session('session-next');
            h.api.profilesByToken['session-next'] = _profile(
              replacement == 'same-account' ? 'user-a' : 'user-b',
            );
            await h.controller.signIn(
              email: 'next@example.test',
              password: 'fixture',
            );
          } else if (replacement == 'device') {
            h.controller.currentDeviceId = 'device-new';
          } else {
            h.tunnel.openVpnCsr = 'newer-csr-not-revoked';
          }
          release.complete();
          await connecting;
          expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
          expect(h.controller.openVpnRevocation, isNull);
          expect(h.controller.isSignedIn, isTrue);
          expect(h.tunnel.openVpnConnections, isEmpty);
          if (replacement != 'csr') {
            expect(h.tunnel.revocationCleanupCalls, isEmpty);
          }
        },
      );
    }

    for (final stopped in [false, true]) {
      test(
        'incomplete cleanup (stopped=$stopped) blocks profile calls and can be restored then retried',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          h.api.deviceConfiguration = _wireGuardConfigurationFor(
            'device-current',
          );
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          h.tunnel.cleanupResult = OpenVpnRevocationResult(
            accountId: 'user-a',
            deviceId: 'device-current',
            csrSha256: sha256
                .convert(utf8.encode(h.tunnel.openVpnCsr))
                .toString(),
            tunnelStopped: stopped,
            stopError: stopped ? null : 'openvpn_stop_timeout',
            storageError: stopped ? 'openvpn_identity_clear_failed' : null,
          );
          h.api.createOpenVpnFailure = const ApiException(
            statusCode: 409,
            errorCode: 'openvpn_profile_revoked',
          );
          await h.controller.connect();
          expect(h.controller.openVpnRevocation?.tunnelStopped, stopped);
          await h.controller.connect();
          await h.controller.renewOpenVpnProfile();
          expect(h.api.createOpenVpnCalls, hasLength(1));
          expect(h.api.renewOpenVpnCalls, 0);
          await h.controller.initialize();
          expect(h.controller.openVpnRevocation?.tunnelStopped, stopped);
          h.tunnel.cleanupResult = null;
          await h.controller.retryOpenVpnRevocation();
          expect(h.controller.openVpnRevocation, isNull);
          expect(h.controller.notice?.messageKey, 'openvpnCleanup.complete');
          expect(h.tunnel.openVpnConnections, isEmpty);
          expect(h.api.createOpenVpnCalls, hasLength(1));
        },
      );
    }

    test(
      'simultaneous retries share cleanup and a late completion cannot update another account',
      () async {
        final h = await _restoredHarness(events: []);
        addTearDown(h.close);
        h.tunnel.pendingRevocation = OpenVpnRevocationResult(
          accountId: 'user-a',
          deviceId: 'device-current',
          csrSha256: sha256
              .convert(utf8.encode(h.tunnel.openVpnCsr))
              .toString(),
        );
        await h.controller.initialize();
        final entered = Completer<void>();
        final release = Completer<void>();
        h.tunnel.hooks['cleanRevokedOpenVpnIdentity'] = () async {
          entered.complete();
          await release.future;
        };
        final first = h.controller.retryOpenVpnRevocation();
        await entered.future;
        await h.controller.retryOpenVpnRevocation();
        expect(h.tunnel.revocationCleanupCalls, hasLength(1));
        await h.controller.signOut();
        h.api.loginResult = _session('session-b');
        h.api.profilesByToken['session-b'] = _profile('user-b');
        await h.controller.signIn(email: 'b@example.test', password: 'fixture');
        release.complete();
        await first;
        expect(h.controller.openVpnRevocation, isNull);
        expect(h.controller.notice, isNull);
        expect(h.controller.token, 'session-b');
      },
    );

    for (final failure in <ApiFailure>[
      const ApiException(statusCode: 409, errorCode: 'openvpn_profile_exists'),
      const ApiException(
        statusCode: 503,
        errorCode: 'openvpn_signer_unavailable',
      ),
      const ApiException(statusCode: 503, errorCode: 'openvpn_profile_revoked'),
      const ApiNetworkException(),
    ]) {
      test(
        'unconfirmed refusal ${failure.code}/${failure.statusCode} preserves OpenVPN identity',
        () async {
          final h = await _signedInHarness();
          addTearDown(h.close);
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          h.api.createOpenVpnFailure = failure;
          await h.controller.connect();
          expect(h.tunnel.revocationCleanupCalls, isEmpty);
          expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
        },
      );
    }
  });
  group('migration account isolation', () {
    for (final errorCode in [
      'device_location_locked',
      'device_identity_revoked',
    ]) {
      test(
        'device replacement cancels delayed $errorCode cleanup after migration',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          await h.controller.selectLocation(_frankfurt02);
          h.store.migrations['user-a/device-current'] = _locationMigration(
            status: LocationMigrationStatus.ready,
          );
          h.api.listDeviceResults.addAll([
            _devices('device-current'),
            _devices('device-current', location: _frankfurt02),
          ]);
          h.api.registerDeviceFailures.add(
            ApiException(statusCode: 409, errorCode: errorCode),
          );
          final entered = Completer<void>();
          final release = Completer<void>();
          final hooks = errorCode == 'device_location_locked'
              ? h.api.hooks
              : h.tunnel.hooks;
          final boundary = errorCode == 'device_location_locked'
              ? 'revokeOpenVpnProfile'
              : 'clearAccountIdentity';
          hooks[boundary] = () async {
            entered.complete();
            await release.future;
          };
          final connecting = h.controller.connect();
          await entered.future;
          h.controller.currentDeviceId = 'device-new';
          h.store.deviceIds['user-a'] = 'device-new';
          final newMigration = _locationMigration(
            deviceId: 'device-new',
            status: LocationMigrationStatus.blocked,
          );
          h.store.migrations['user-a/device-new'] = newMigration;
          final previousClears = List<String>.of(h.store.clearedMigrations);
          release.complete();
          await connecting;
          expect(h.controller.currentDeviceId, 'device-new');
          expect(h.store.deviceIds['user-a'], 'device-new');
          expect(h.store.migrations['user-a/device-new'], same(newMigration));
          expect(h.store.clearedMigrations, previousClears);
          expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
          expect(h.tunnel.wireGuardConnections, isEmpty);
          expect(h.api.registerDeviceCalls, hasLength(1));
          expect(h.controller.isConnecting, isFalse);
        },
      );
    }

    for (final boundary in ['requestVpnPermission', 'createOpenVpnProfile']) {
      test(
        'device replacement after a ready migration invalidates delayed $boundary',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          h.api.deviceConfiguration = _wireGuardConfigurationFor(
            'device-current',
          );
          h.api.openVpnActivation = _openVpnActivation('device-current');
          h.api.migrationStartResult = _locationMigration(
            status: LocationMigrationStatus.ready,
          );
          h.api.listDeviceResults.addAll([
            _devices('device-current'),
            _devices('device-current', location: _frankfurt02),
          ]);
          await h.controller.selectLocation(_frankfurt02);
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          final entered = Completer<void>();
          final release = Completer<void>();
          final hooks = boundary == 'requestVpnPermission'
              ? h.tunnel.hooks
              : h.api.hooks;
          hooks[boundary] = () async {
            entered.complete();
            await release.future;
          };
          final connecting = h.controller.connect();
          await entered.future;
          h.controller.currentDeviceId = 'device-new';
          release.complete();
          await connecting;
          expect(h.tunnel.openVpnConnections, isEmpty);
          expect(h.controller.currentDeviceId, 'device-new');
          expect(h.controller.isConnecting, isFalse);
          expect(
            h.controller.notice?.arguments['code'],
            isNot('tunnel_start_unexpected'),
          );
        },
      );
    }

    for (final bState in ['no-device', 'device-only', 'own-migration']) {
      test(
        'A3 normal blocked migration cannot contaminate B ($bState), and A can return',
        () async {
          final h = await _restoredHarness(events: []);
          addTearDown(h.close);
          h.api.locationsResult = [_frankfurt, _frankfurt02];
          await h.controller.refreshLocations();
          h.api.migrationStartResult = _locationMigration(
            status: LocationMigrationStatus.blocked,
          );
          await h.controller.selectProtocol(VpnProtocol.openVpn);
          await h.controller.selectLocation(_frankfurt02);
          await h.controller.connect();
          final aMigration = h.controller.locationMigration!;
          expect(aMigration.status, LocationMigrationStatus.blocked);
          expect(h.api.startMigrationCalls, hasLength(1));
          await h.controller.signOut();
          h.api.loginResult = _session('session-b');
          h.api.profilesByToken['session-b'] = _profile('user-b');
          h.api.deviceListResult = const DeviceList(limit: 2, devices: []);
          if (bState != 'no-device') {
            h.store.deviceIds['user-b'] = 'device-b';
            h.api.deviceListResult = _devices('device-b');
          }
          final bMigration = _locationMigration(
            deviceId: 'device-b',
            status: LocationMigrationStatus.blocked,
            targetLocationId: _frankfurt.id,
          );
          if (bState == 'own-migration') {
            h.store.migrations['user-b/device-b'] = bMigration;
          }
          expect(
            await h.controller.signIn(
              email: 'b@example.test',
              password: 'fixture',
            ),
            isTrue,
          );
          expect(
            h.controller.locationMigration,
            bState == 'own-migration' ? same(bMigration) : isNull,
          );
          expect(
            h.controller.isLocationMigrationLocked,
            bState == 'own-migration',
          );
          if (bState != 'own-migration') {
            await h.controller.selectLocation(_frankfurt);
            await h.controller.selectProtocol(VpnProtocol.wireGuard);
            expect(h.controller.selectedLocation, _frankfurt);
            expect(h.controller.selectedProtocol, VpnProtocol.wireGuard);
            expect(h.controller.notice, isNull);
          }
          expect(h.api.migrationPollCalls, isEmpty);
          expect(h.store.migrations['user-a/device-current'], same(aMigration));
          await h.controller.signOut();
          h.api.loginResult = _session('session-a-new');
          h.api.profilesByToken['session-a-new'] = _profile('user-a');
          h.api.deviceListResult = _devices('device-current');
          await h.controller.signIn(
            email: 'a@example.test',
            password: 'fixture',
          );
          expect(h.controller.locationMigration, same(aMigration));
          expect(h.tunnel.clearedAccountIds, isEmpty);
          expect(h.tunnel.clearedOpenVpnIdentities, isEmpty);
        },
      );
    }

    for (final noDevice in [false, true]) {
      test(
        'restoration clears previous memory with ${noDevice ? "no device" : "no saved migration"}',
        () async {
          final h = await _blockedMigrationHarness();
          addTearDown(h.close);
          expect(h.controller.isLocationMigrationLocked, isTrue);
          if (noDevice) {
            h.store.deviceIds.remove('user-a');
          } else {
            h.store.migrations.remove('user-a/device-current');
          }
          await h.controller.initialize();
          expect(h.controller.locationMigration, isNull);
          expect(h.controller.isLocationMigrationLocked, isFalse);
          expect(h.api.migrationPollCalls, isEmpty);
        },
      );
    }

    for (final nextUser in ['user-a', 'user-b']) {
      for (final corrupt in [false, true]) {
        test(
          'late ${corrupt ? "malformed" : "valid"} read cannot alter a new session of $nextUser',
          () async {
            final h = await _blockedMigrationHarness();
            addTearDown(h.close);
            final entered = Completer<void>();
            final release = Completer<void>();
            h.store.hooks['readLocationMigration'] = () async {
              h.store.hooks.remove('readLocationMigration');
              entered.complete();
              await release.future;
              if (corrupt) throw const CorruptLocationMigration();
            };
            final restoring = h.controller.initialize();
            await entered.future;
            expect(h.controller.locationMigration, isNull);
            await h.controller.signOut();
            final nextMigration = _locationMigration(
              deviceId: 'device-current',
              targetLocationId: _frankfurt.id,
              status: LocationMigrationStatus.blocked,
            );
            h.api.loginResult = _session('session-next');
            h.api.profilesByToken['session-next'] = _profile(nextUser);
            h.store.deviceIds[nextUser] = 'device-current';
            h.store.migrations['$nextUser/device-current'] = nextMigration;
            await h.controller.signIn(
              email: 'next@example.test',
              password: 'fixture',
            );
            release.complete();
            await restoring;
            expect(h.controller.locationMigration, same(nextMigration));
            expect(
              h.store.migrations['$nextUser/device-current'],
              same(nextMigration),
            );
            expect(h.store.clearedMigrations, isEmpty);
            expect(h.controller.notice, isNull);
            expect(h.controller.token, 'session-next');
          },
        );
      }
    }

    for (final outcome in ['success', '401', 'network']) {
      test('late migration $outcome cannot affect another account', () async {
        final h = await _blockedMigrationHarness();
        addTearDown(h.close);
        final entered = Completer<void>();
        final release = Completer<void>();
        h.api.hooks['getLocationMigration'] = () async {
          h.api.hooks.remove('getLocationMigration');
          entered.complete();
          await release.future;
          if (outcome == '401') {
            throw const ApiException(
              statusCode: 401,
              errorCode: 'unauthorized',
            );
          }
          if (outcome == 'network') throw const ApiNetworkException();
        };
        final following = h.controller.resumeLocationMigration();
        await entered.future;
        await h.controller.signOut();
        h.api.loginResult = _session('session-b');
        h.api.profilesByToken['session-b'] = _profile('user-b');
        await h.controller.signIn(email: 'b@example.test', password: 'fixture');
        final currentNotice = h.controller.notice;
        release.complete();
        await following;
        expect(h.controller.token, 'session-b');
        expect(h.controller.locationMigration, isNull);
        expect(h.controller.notice, currentNotice);
        expect(h.store.clearSessionCalls, 1);
        expect(h.store.clearedMigrations, isEmpty);
        expect(
          h.api.migrationPollCalls.every((call) => call.token == 'session-a'),
          isTrue,
        );
      });
    }

    test(
      'device replacement cancels the wait and preserves a new connection busy flag',
      () async {
        final delayEntered = Completer<void>();
        final delay = Completer<void>();
        final h = await _blockedMigrationHarness(
          migrationDelay: (_) {
            delayEntered.complete();
            return delay.future;
          },
        );
        addTearDown(h.close);
        h.api.migrationPollResults.add(
          _locationMigration(status: LocationMigrationStatus.draining),
        );
        final following = h.controller.resumeLocationMigration();
        await delayEntered.future;
        h.controller.currentDeviceId = 'device-new';
        expect(h.controller.locationMigration, isNull);
        expect(h.controller.isConnecting, isFalse);
        final connectEntered = Completer<void>();
        final connectRelease = Completer<void>();
        h.api.hooks['registerDevice'] = () async {
          connectEntered.complete();
          await connectRelease.future;
        };
        final connecting = h.controller.connect();
        await connectEntered.future;
        await following.timeout(const Duration(seconds: 1));
        expect(h.controller.isConnecting, isTrue);
        expect(h.api.migrationPollCalls, hasLength(1));
        expect(h.store.migrations['user-a/device-current'], isNotNull);
        delay.complete();
        connectRelease.complete();
        await connecting;
        expect(h.tunnel.wireGuardConnections, hasLength(1));
      },
    );

    test(
      'device change during migration 401 cannot invalidate the account',
      () async {
        final h = await _blockedMigrationHarness();
        addTearDown(h.close);
        final entered = Completer<void>();
        final release = Completer<void>();
        h.api.hooks['getLocationMigration'] = () async {
          entered.complete();
          await release.future;
          throw const ApiException(statusCode: 401, errorCode: 'unauthorized');
        };
        final following = h.controller.resumeLocationMigration();
        await entered.future;
        h.controller.currentDeviceId = 'device-new';
        release.complete();
        await following;
        expect(h.controller.isSignedIn, isTrue);
        expect(h.store.clearSessionCalls, 0);
        expect(h.controller.notice, isNull);
      },
    );

    for (final mismatch in ['device', 'migration', 'target', 'source']) {
      test(
        'rejects a migration response with mismatched $mismatch before publication or storage',
        () async {
          final h = await _blockedMigrationHarness();
          addTearDown(h.close);
          final original = h.controller.locationMigration!;
          h.api.migrationPollResults.add(
            DeviceLocationMigration(
              migrationId: mismatch == 'migration'
                  ? 'foreign-migration'
                  : original.migrationId,
              deviceId: mismatch == 'device'
                  ? 'foreign-device'
                  : original.deviceId,
              sourceLocationId: mismatch == 'source'
                  ? 'foreign-source'
                  : original.sourceLocationId,
              targetLocationId: mismatch == 'target'
                  ? 'foreign-target'
                  : original.targetLocationId,
              status: LocationMigrationStatus.ready,
            ),
          );
          await h.controller.resumeLocationMigration();
          expect(h.controller.locationMigration, same(original));
          expect(h.store.migrations['user-a/device-current'], same(original));
          expect(h.store.clearedMigrations, isEmpty);
          expect(
            h.controller.notice?.arguments['code'],
            'location_migration_conflict',
          );
        },
      );
    }

    test('malformed current record only clears its own slot', () async {
      final h = await _blockedMigrationHarness();
      addTearDown(h.close);
      final other = _locationMigration(
        deviceId: 'device-b',
        status: LocationMigrationStatus.blocked,
      );
      h.store.migrations['user-b/device-b'] = other;
      h.store.hooks['readLocationMigration'] = () async {
        throw const CorruptLocationMigration();
      };
      await h.controller.initialize();
      expect(h.controller.locationMigration, isNull);
      expect(h.store.clearedMigrations, ['user-a/device-current']);
      expect(h.store.migrations['user-b/device-b'], same(other));
      expect(h.controller.isSignedIn, isTrue);
      expect(h.tunnel.clearedAccountIds, isEmpty);
    });
  });

  group('session lifecycle regression', () {
    for (final VpnProtocol protocol in VpnProtocol.values) {
      test('A1 unauthorized stops $protocol and clears the session', () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.tunnel.emitConnected(protocol);
        await Future<void>.delayed(Duration.zero);
        h.api.listDevicesFailure = const ApiException(
          statusCode: 401,
          errorCode: 'unauthorized',
        );
        await h.controller.refreshDevices();
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.store.storedSession, isNull);
        expect(h.controller.sessionTermination, isNull);
        expect(h.controller.isSignedIn, isFalse);
        expect(h.api.logoutTokens, isEmpty);
        expect(h.controller.notice?.arguments['code'], 'unauthorized');
      });
    }

    for (final boundary in <String>[
      'listDevices',
      'registerDevice',
      'createOpenVpnProfile',
      'requestVpnPermission',
      'getOrCreateWireGuardPublicKey',
      'getOrCreateOpenVpnCsr',
    ]) {
      test('A2 logout invalidates the delayed $boundary result', () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        if (boundary.contains('OpenVpn')) {
          await h.controller.selectProtocol(VpnProtocol.openVpn);
        }
        final entered = Completer<void>();
        final release = Completer<void>();
        final hooks =
            boundary.startsWith('getOr') || boundary == 'requestVpnPermission'
            ? h.tunnel.hooks
            : h.api.hooks;
        hooks[boundary] = () async {
          entered.complete();
          await release.future;
        };
        final connecting = h.controller.connect();
        await entered.future;
        await h.controller.signOut();
        final savedDevice = h.store.deviceIds['user-a'];
        release.complete();
        await connecting;
        expect(h.tunnel.wireGuardConnections, isEmpty);
        expect(h.tunnel.openVpnConnections, isEmpty);
        expect(h.store.deviceIds['user-a'], savedDevice);
        expect(h.store.storedSession, isNull);
        expect(h.controller.isConnecting, isFalse);
        expect(h.controller.notice, isNull);
      });
    }

    test('late renewal activation cannot restart after logout', () async {
      final h = await _restoredHarness(events: []);
      addTearDown(h.close);
      final entered = Completer<void>();
      final release = Completer<void>();
      h.api.hooks['renewOpenVpnProfile'] = () async {
        entered.complete();
        await release.future;
      };
      final renewal = h.controller.renewOpenVpnProfile();
      await entered.future;
      await h.controller.signOut();
      release.complete();
      await renewal;
      expect(h.tunnel.openVpnConnections, isEmpty);
      expect(h.controller.notice, isNull);
    });

    for (final user in ['user-a', 'user-b']) {
      for (final unauthorized in [false, true]) {
        test(
          'old result (401=$unauthorized) cannot affect a new session of $user',
          () async {
            final h = await _signedInHarness();
            addTearDown(h.close);
            final entered = Completer<void>();
            final release = Completer<void>();
            h.api.hooks['listDevices'] = () async {
              h.api.hooks.remove('listDevices');
              entered.complete();
              await release.future;
              if (unauthorized) {
                throw const ApiException(
                  statusCode: 401,
                  errorCode: 'unauthorized',
                );
              }
            };
            final oldRefresh = h.controller.refreshDevices();
            await entered.future;
            await h.controller.signOut();
            h.api.loginResult = _session('session-new');
            h.api.profilesByToken['session-new'] = _profile(user);
            expect(
              await h.controller.signIn(
                email: 'new@example.test',
                password: 'fixture',
              ),
              isTrue,
            );
            final currentDevices = h.controller.deviceList;
            h.api.deviceListResult = _devices('obsolete-device');
            release.complete();
            await oldRefresh;
            expect(h.controller.profile?.userId, user);
            expect(h.controller.token, 'session-new');
            expect(h.controller.deviceList, same(currentDevices));
            expect(h.store.clearSessionCalls, 1);
            expect(h.controller.notice, isNull);
          },
        );
      }
    }

    test(
      'stop failure clears the token but blocks login until retry succeeds',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.tunnel.emitConnected(VpnProtocol.openVpn);
        await Future<void>.delayed(Duration.zero);
        h.tunnel.disconnectFailure = const NativeVpnException(
          'openvpn_stop_timeout',
        );
        await h.controller.signOut();
        expect(h.controller.sessionTermination?.tunnelStopped, isFalse);
        expect(h.controller.sessionTermination?.sessionCleared, isTrue);
        expect(h.store.storedSession, isNull);
        expect(
          await h.controller.signIn(
            email: 'new@example.test',
            password: 'fixture',
          ),
          isFalse,
        );
        h.tunnel.disconnectFailure = null;
        await h.controller.retrySessionTermination();
        expect(h.controller.sessionTermination, isNull);
        expect(h.api.logoutTokens, ['session-a']);
      },
    );

    test(
      'storage failure does not prevent native shutdown and can be retried',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.store.failClear = true;
        await h.controller.signOut();
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.controller.sessionTermination?.tunnelStopped, isTrue);
        expect(h.controller.sessionTermination?.sessionCleared, isFalse);
        expect(h.controller.token, isNull);
        h.store.failClear = false;
        await h.controller.retrySessionTermination();
        expect(h.store.storedSession, isNull);
        expect(h.controller.sessionTermination, isNull);
      },
    );

    test('concurrent 401 and logout share one local termination', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      h.store.clearEntered = Completer<void>();
      h.store.clearRelease = Completer<void>();
      h.api.listDevicesFailure = const ApiException(
        statusCode: 401,
        errorCode: 'unauthorized',
      );
      final first = h.controller.refreshDevices();
      final second = h.controller.refreshDevices();
      await h.store.clearEntered!.future;
      final logout = h.controller.signOut();
      expect(h.controller.isConnected, isFalse);
      expect(h.store.clearSessionCalls, 1);
      h.store.clearRelease!.complete();
      await Future.wait([first, second, logout]);
      expect(h.store.clearSessionCalls, 1);
      expect(h.api.logoutTokens, isEmpty);
    });

    test(
      'a late login response cannot restore an explicitly ended session',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        await h.controller.signOut();
        final entered = Completer<void>();
        final release = Completer<void>();
        h.api.hooks['login'] = () async {
          entered.complete();
          await release.future;
        };
        final login = h.controller.signIn(
          email: 'client@example.test',
          password: 'fixture',
        );
        await entered.future;
        await h.controller.signOut();
        release.complete();
        expect(await login, isFalse);
        expect(h.store.storedSession, isNull);
      },
    );

    test('session cleanup drains an already submitted session write', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      await h.controller.signOut();
      final entered = Completer<void>();
      final release = Completer<void>();
      h.store.beforeWrite = () async {
        entered.complete();
        await release.future;
      };
      final login = h.controller.signIn(
        email: 'client@example.test',
        password: 'fixture',
      );
      await entered.future;
      final ending = h.controller.signOut();
      release.complete();
      await ending;
      expect(await login, isFalse);
      expect(h.store.storedSession, isNull);
      expect(h.controller.sessionTermination, isNull);
    });

    test(
      'logout cancels migration polling and drops account migration memory',
      () async {
        final h = await _restoredHarness(events: []);
        addTearDown(h.close);
        h.store.migrations['user-a/device-current'] = _locationMigration(
          status: LocationMigrationStatus.blocked,
        );
        await h.controller.initialize();
        final entered = Completer<void>();
        final release = Completer<void>();
        h.api.hooks['getLocationMigration'] = () async {
          entered.complete();
          await release.future;
        };
        final migrating = h.controller.resumeLocationMigration();
        await entered.future;
        await h.controller.signOut();
        release.complete();
        await migrating;
        expect(h.controller.locationMigration, isNull);
        expect(h.tunnel.openVpnConnections, isEmpty);
      },
    );

    test(
      'HTTP 401 without the expected error body still ends the session',
      () async {
        final h = await _signedInHarness();
        addTearDown(h.close);
        h.api.hooks['resendVerification'] = () async {
          throw const ApiException(statusCode: 401, errorCode: 'api_error');
        };
        await h.controller.resendVerification();
        expect(h.tunnel.disconnectCalls, 1);
        expect(h.controller.isSignedIn, isFalse);
      },
    );

    for (final corrupt in [false, true]) {
      test(
        'restored ${corrupt ? "unreadable" : "expired"} session stops an active tunnel',
        () async {
          final h = await _restoredHarness(
            events: [],
            prepare: (api, store, tunnel) {
              store.storedSession = AuthSession(
                accessToken: 'obsolete',
                expiresAt: DateTime.utc(2000),
              );
              if (corrupt) {
                store.readFailure = const NativeVpnException(
                  'secure_storage_corrupt',
                );
              }
              tunnel.state = const VpnRuntimeState(
                phase: VpnRuntimePhase.connected,
                protocol: VpnProtocol.openVpn,
              );
            },
          );
          addTearDown(h.close);
          expect(h.controller.isSignedIn, isFalse);
          expect(h.controller.isInitializing, isFalse);
          expect(h.store.storedSession, isNull);
          expect(h.tunnel.disconnectCalls, 1);
          expect(h.api.logoutTokens, isEmpty);
        },
      );
    }

    for (final boundary in ['me', 'readCurrentDevice', 'readSession']) {
      test(
        'late $boundary restoration cannot replace a newly authenticated account',
        () async {
          final h = await _signedInHarness();
          addTearDown(h.close);
          final entered = Completer<void>();
          final release = Completer<void>();
          final hooks = boundary == 'me' ? h.api.hooks : h.store.hooks;
          hooks[boundary] = () async {
            hooks.remove(boundary);
            entered.complete();
            await release.future;
          };
          final oldRestore = h.controller.initialize();
          await entered.future;
          await h.controller.signOut();
          h.api.loginResult = _session('session-new');
          h.api.profilesByToken['session-new'] = _profile('user-b');
          h.store.deviceIds['user-b'] = 'device-b';
          expect(
            await h.controller.signIn(
              email: 'b@example.test',
              password: 'fixture',
            ),
            isTrue,
          );
          release.complete();
          await oldRestore;
          expect(h.controller.profile?.userId, 'user-b');
          expect(h.controller.currentDeviceId, 'device-b');
          expect(h.controller.token, 'session-new');
          expect(h.store.clearSessionCalls, 1);
        },
      );
    }

    test('late revocation cannot delete identities after logout', () async {
      final h = await _restoredHarness(events: []);
      addTearDown(h.close);
      final entered = Completer<void>();
      final release = Completer<void>();
      h.api.hooks['revokeDevice'] = () async {
        entered.complete();
        await release.future;
      };
      final revoking = h.controller.revokeDevice(h.controller.currentDevice!);
      await entered.future;
      await h.controller.signOut();
      release.complete();
      await revoking;
      expect(h.tunnel.clearedAccountIds, isEmpty);
      expect(h.store.deviceIds['user-a'], 'device-current');
      expect(h.controller.notice, isNull);
    });

    test('old connection finalization leaves a new connection busy', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      final entered = Completer<void>();
      final release = Completer<void>();
      h.tunnel.hooks['requestVpnPermission'] = () async {
        h.tunnel.hooks.remove('requestVpnPermission');
        entered.complete();
        await release.future;
      };
      final oldConnect = h.controller.connect();
      await entered.future;
      await h.controller.signOut();
      await h.controller.signIn(email: 'a@example.test', password: 'fixture');
      final newEntered = Completer<void>();
      final newRelease = Completer<void>();
      h.api.hooks['registerDevice'] = () async {
        newEntered.complete();
        await newRelease.future;
      };
      final newConnect = h.controller.connect();
      await newEntered.future;
      release.complete();
      await oldConnect;
      expect(h.controller.isConnecting, isTrue);
      newRelease.complete();
      await newConnect;
      expect(h.tunnel.wireGuardConnections, hasLength(1));
    });

    test(
      'migration delay is cancellable without making another HTTP request',
      () async {
        final entered = Completer<void>();
        final delay = Completer<void>();
        final h = await _restoredHarness(
          events: [],
          migrationDelay: (_) {
            entered.complete();
            return delay.future;
          },
        );
        addTearDown(h.close);
        h.store.migrations['user-a/device-current'] = _locationMigration(
          status: LocationMigrationStatus.blocked,
        );
        await h.controller.initialize();
        h.api.migrationPollResults.add(
          _locationMigration(status: LocationMigrationStatus.draining),
        );
        final migrating = h.controller.resumeLocationMigration();
        await entered.future;
        final polls = h.api.migrationPollCalls.length;
        await h.controller.signOut();
        await migrating.timeout(const Duration(seconds: 1));
        expect(h.api.migrationPollCalls, hasLength(polls));
        expect(h.controller.locationMigration, isNull);
        delay.complete();
      },
    );

    test('a stalled remote logout does not hold local termination', () async {
      final h = await _signedInHarness();
      addTearDown(h.close);
      final remote = Completer<void>();
      h.api.hooks['logout'] = () => remote.future;
      await h.controller.signOut().timeout(const Duration(seconds: 1));
      expect(h.store.storedSession, isNull);
      expect(h.controller.sessionTermination, isNull);
      expect(h.api.logoutTokens, ['session-a']);
      remote.completeError(
        const ApiException(statusCode: 503, errorCode: 'unavailable'),
      );
      await Future<void>.delayed(Duration.zero);
      expect(h.controller.notice, isNull);
    });
  });

  group('VpnAppController account scope', () {
    test(
      'restaure uniquement l appareil du compte de la session active',
      () async {
        final List<String> events = <String>[];
        final _FakeApi api = _FakeApi(events: events)
          ..profilesByToken['token-b'] = _profile('user-b')
          ..deviceListResult = _devices('device-b');
        final _FakeSessionStore store = _FakeSessionStore(events: events)
          ..storedSession = _session('token-b')
          ..deviceIds['user-a'] = 'device-a'
          ..deviceIds['user-b'] = 'device-b';
        final _FakePreferences preferences = _FakePreferences();
        final _FakeTunnel tunnel = _FakeTunnel(events: events);
        final VpnAppController controller = _controller(
          api: api,
          store: store,
          preferences: preferences,
          tunnel: tunnel,
        );
        addTearDown(() async {
          controller.dispose();
          await tunnel.close();
        });

        await controller.initialize();

        expect(controller.isSignedIn, isTrue);
        expect(controller.token, 'token-b');
        expect(controller.profile?.userId, 'user-b');
        expect(controller.currentDeviceId, 'device-b');
        expect(controller.currentDevice?.deviceId, 'device-b');
        expect(store.readDeviceUsers, <String>['user-b']);
        expect(store.sessionWriteUsers, <String?>['user-b']);
        expect(api.meTokens, <String>['token-b']);
        expect(store.clearSessionCalls, 0);
      },
    );

    test('efface une session expirée sans restaurer un autre compte', () async {
      final _FakeApi api = _FakeApi();
      final _FakeSessionStore store = _FakeSessionStore()
        ..storedSession = AuthSession(
          accessToken: 'expired-token',
          expiresAt: DateTime.utc(2020, 1, 1),
        )
        ..deviceIds['user-a'] = 'device-a';
      final _FakeTunnel tunnel = _FakeTunnel();
      final VpnAppController controller = _controller(
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

      expect(controller.isSignedIn, isFalse);
      expect(controller.currentDeviceId, isNull);
      expect(store.clearSessionCalls, 1);
      expect(api.meTokens, isEmpty);
      expect(store.readDeviceUsers, isEmpty);
    });
  });

  group('VpnAppController protocol hand-off', () {
    test(
      'sélectionne WireGuard et remet toute la configuration au tunnel natif',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);

        await harness.controller.connect();

        expect(harness.api.registerDeviceCalls, hasLength(1));
        final _RegisterDeviceCall enrollment =
            harness.api.registerDeviceCalls.single;
        expect(enrollment.token, 'session-a');
        expect(enrollment.name, 'FuzeVPN — Android');
        expect(enrollment.publicKey, 'wireguard-public-key-only');
        expect(enrollment.locationId, _frankfurt.id);
        expect(harness.tunnel.wireGuardConnections, hasLength(1));
        final _WireGuardConnection connection =
            harness.tunnel.wireGuardConnections.single;
        expect(connection.accountId, 'user-a');
        expect(connection.configuration.deviceId, 'device-android');
        expect(connection.configuration.address, '10.10.0.2/32');
        expect(connection.configuration.dns, <String>['1.1.1.1', '1.0.0.1']);
        expect(
          connection.configuration.serverPublicKey,
          'server-public-key-only',
        );
        expect(connection.configuration.endpoint, '198.51.100.10:51820');
        expect(connection.configuration.allowedIps, <String>['0.0.0.0/0']);
        expect(harness.tunnel.openVpnConnections, isEmpty);
        expect(harness.store.deviceIds['user-a'], 'device-android');
        expect(harness.store.sessionWriteUsers, <String?>[null, 'user-a']);
      },
    );

    test(
      'sélectionne OpenVPN et transmet le CSR et l activation au tunnel natif',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);

        await harness.controller.selectProtocol(VpnProtocol.openVpn);
        await harness.controller.connect();

        expect(harness.tunnel.wireGuardConnections, isEmpty);
        expect(harness.api.registerDeviceCalls, hasLength(1));
        expect(
          harness.api.registerDeviceCalls.single.locationId,
          _frankfurt.id,
        );
        expect(harness.tunnel.openVpnCsrCalls, hasLength(1));
        final _OpenVpnCsrCall csrCall = harness.tunnel.openVpnCsrCalls.single;
        expect(csrCall.accountId, 'user-a');
        expect(csrCall.deviceId, 'device-android');
        expect(csrCall.renewal, isFalse);
        expect(harness.api.createOpenVpnCalls, hasLength(1));
        final _OpenVpnProfileCall profileCall =
            harness.api.createOpenVpnCalls.single;
        expect(profileCall.token, 'session-a');
        expect(profileCall.deviceId, 'device-android');
        expect(profileCall.csrPem, 'public-p256-csr-only');
        expect(harness.tunnel.openVpnConnections, hasLength(1));
        final _OpenVpnConnection connection =
            harness.tunnel.openVpnConnections.single;
        expect(connection.accountId, 'user-a');
        expect(connection.activation.deviceId, 'device-android');
        expect(connection.activation.endpoint, '198.51.100.10');
        expect(connection.activation.address, '10.20.0.2/32');
        expect(
          connection.activation.serverName,
          'frankfurt-01.openvpn.fuzevpn.internal',
        );
        expect(connection.activation.remoteCertTlsServer, isTrue);
        expect(connection.activation.ciphers, <String>[
          'AES-256-GCM',
          'CHACHA20-POLY1305',
        ]);
      },
    );

    test(
      'renouvelle directement un certificat OpenVPN expiré sans appeler create',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.tunnel.openVpnCertificateStatus = OpenVpnCertificateStatus(
          phase: OpenVpnCertificatePhase.expired,
          notAfter: DateTime.utc(2026, 8, 1),
          renewalPending: false,
        );

        await harness.controller.selectProtocol(VpnProtocol.openVpn);
        await harness.controller.connect();

        expect(harness.api.createOpenVpnCalls, isEmpty);
        expect(harness.api.renewOpenVpnCalls, 1);
        expect(harness.tunnel.openVpnCsrCalls, hasLength(1));
        expect(harness.tunnel.openVpnCsrCalls.single.renewal, isTrue);
        expect(harness.tunnel.openVpnConnections, hasLength(1));
        expect(harness.tunnel.openVpnConnections.single.renewal, isTrue);
      },
    );

    test(
      'reprend une transaction de renouvellement avec le CSR déjà préparé',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.tunnel.openVpnCertificateStatus = OpenVpnCertificateStatus(
          phase: OpenVpnCertificatePhase.valid,
          notAfter: DateTime.utc(2027, 1, 1),
          renewalPending: true,
        );

        await harness.controller.selectProtocol(VpnProtocol.openVpn);
        await harness.controller.connect();

        expect(harness.api.createOpenVpnCalls, isEmpty);
        expect(harness.api.renewOpenVpnCalls, 1);
        expect(harness.tunnel.openVpnCsrCalls.single.renewal, isTrue);
        expect(harness.tunnel.openVpnConnections.single.renewal, isTrue);
      },
    );

    test(
      'refuse de démarrer sans actualiser les appareils avant la connexion',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        final int deviceReadsBeforeConnect =
            harness.api.listDeviceTokens.length;
        harness.api.listDevicesFailure = const ApiNetworkException(
          code: 'network_timeout',
        );

        await harness.controller.connect();

        expect(harness.tunnel.wireGuardConnections, isEmpty);
        expect(
          harness.api.listDeviceTokens,
          hasLength(deviceReadsBeforeConnect + 1),
        );
        expect(harness.controller.isConnecting, isFalse);
        expect(harness.controller.notice?.titleKey, 'notice.api.title');
        expect(
          harness.controller.notice?.arguments['code'],
          'network_unavailable',
        );
      },
    );

    test(
      'affiche la cause native OpenVPN au lieu d une erreur générique',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.tunnel.openVpnFailure = const NativeVpnException(
          'tls_handshake_failed',
        );

        await harness.controller.selectProtocol(VpnProtocol.openVpn);
        await harness.controller.connect();

        expect(
          harness.controller.tunnelState.messageCode,
          'tls_handshake_failed',
        );
        expect(harness.controller.notice?.titleKey, 'notice.native.title');
        expect(
          harness.controller.notice?.arguments['code'],
          'tls_handshake_failed',
        );
        expect(
          harness.controller.notice?.diagnosticCode,
          'OVPN-TLS · tls_handshake_failed',
        );
      },
    );

    test(
      'conserve la cause native et le protocole lors d un echec d arret',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.tunnel.emitConnected(VpnProtocol.wireGuard);
        await Future<void>.delayed(Duration.zero);
        harness.tunnel.disconnectFailure = const NativeVpnException(
          'wireguard_stop_timeout',
        );

        await harness.controller.disconnect();

        expect(
          harness.controller.tunnelState.messageCode,
          'wireguard_stop_timeout',
        );
        expect(harness.controller.notice?.titleKey, 'notice.native.title');
        expect(
          harness.controller.notice?.arguments['code'],
          'wireguard_stop_timeout',
        );
        expect(
          harness.controller.notice?.diagnosticCode,
          'WG-STOP · wireguard_stop_timeout',
        );
      },
    );

    test(
      'remplace automatiquement une identité révoquée sans afficher d erreur',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.api.registerDeviceFailures.add(
          const ApiException(
            statusCode: 409,
            errorCode: 'device_identity_revoked',
          ),
        );

        await harness.controller.connect();

        expect(harness.api.registerDeviceCalls, hasLength(2));
        expect(
          harness.api.registerDeviceCalls.map((call) => call.publicKey),
          <String>[
            'wireguard-public-key-only',
            'replacement-wireguard-public-key-only',
          ],
        );
        expect(harness.tunnel.clearedAccountIds, <String>['user-a']);
        expect(harness.store.clearedDeviceUsers, <String>['user-a']);
        expect(harness.tunnel.wireGuardConnections, hasLength(1));
        expect(harness.controller.notice, isNull);
        expect(harness.controller.currentDeviceId, 'device-android');
      },
    );

    test(
      'explique la limite après suppression automatique de l identité révoquée',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.api.registerDeviceFailures.addAll(<ApiFailure>[
          const ApiException(
            statusCode: 409,
            errorCode: 'device_identity_revoked',
          ),
          const ApiException(statusCode: 409, errorCode: 'device_limit'),
        ]);

        await harness.controller.connect();

        expect(harness.api.registerDeviceCalls, hasLength(2));
        expect(harness.tunnel.clearedAccountIds, <String>['user-a']);
        expect(harness.store.clearedDeviceUsers, <String>['user-a']);
        expect(harness.tunnel.wireGuardConnections, isEmpty);
        expect(harness.controller.currentDeviceId, isNull);
        expect(harness.controller.notice?.titleKey, 'notice.controller.title');
        expect(
          harness.controller.notice?.arguments['code'],
          'revoked_identity_device_limit',
        );
      },
    );

    test(
      'autorise WireGuard à se reconnecter après un arrêt confirmé',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);

        await harness.controller.connect();
        harness.tunnel.emitConnected(VpnProtocol.wireGuard);
        await Future<void>.delayed(Duration.zero);
        await harness.controller.disconnect();
        await harness.controller.connect();

        expect(harness.tunnel.disconnectCalls, 1);
        expect(harness.tunnel.wireGuardConnections, hasLength(2));
        expect(harness.controller.notice, isNull);
      },
    );

    test('autorise OpenVPN à se reconnecter après un arrêt confirmé', () async {
      final _SignedInHarness harness = await _signedInHarness();
      addTearDown(harness.close);

      await harness.controller.selectProtocol(VpnProtocol.openVpn);
      await harness.controller.connect();
      harness.tunnel.emitConnected(VpnProtocol.openVpn);
      await Future<void>.delayed(Duration.zero);
      await harness.controller.disconnect();
      await harness.controller.connect();

      expect(harness.tunnel.disconnectCalls, 1);
      expect(harness.tunnel.openVpnConnections, hasLength(2));
      expect(harness.controller.notice, isNull);
    });
  });

  group('VpnAppController location migrations', () {
    test('même emplacement : ne lance aucune migration', () async {
      final _RestoredHarness harness = await _restoredHarness(
        events: <String>[],
      );
      addTearDown(harness.close);
      harness.api.deviceConfiguration = _wireGuardConfigurationFor(
        'device-current',
      );

      await harness.controller.connect();

      expect(harness.api.startMigrationCalls, isEmpty);
      expect(harness.api.migrationPollCalls, isEmpty);
      expect(harness.tunnel.wireGuardConnections, hasLength(1));
    });

    test(
      'déplace WireGuard directement sans migration après arrêt confirmé',
      () async {
        final List<String> events = <String>[];
        final _FakeApi api = _FakeApi(events: events)
          ..profilesByToken['session-a'] = _profile('user-a')
          ..locationsResult = const <Location>[_frankfurt, _frankfurt02]
          ..deviceListResult = _devices('device-current')
          ..deviceConfiguration = _wireGuardConfigurationFor('device-current')
          ..migrationStartResult = _locationMigration(
            deviceId: 'device-current',
            targetLocationId: _frankfurt02.id,
            status: LocationMigrationStatus.draining,
          )
          ..migrationPollResults.add(
            _locationMigration(
              deviceId: 'device-current',
              targetLocationId: _frankfurt02.id,
              status: LocationMigrationStatus.ready,
            ),
          );
        final _FakeSessionStore store = _FakeSessionStore()
          ..storedSession = _session('session-a')
          ..deviceIds['user-a'] = 'device-current';
        final _FakeTunnel tunnel = _FakeTunnel(events: events)
          ..state = const VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
            protocol: VpnProtocol.wireGuard,
          );
        final VpnAppController controller = _controller(
          api: api,
          store: store,
          preferences: _FakePreferences(),
          tunnel: tunnel,
          migrationDelay: (_) => Future<void>.value(),
        );
        addTearDown(() async {
          controller.dispose();
          await tunnel.close();
        });
        await controller.initialize();
        controller.tunnelState = tunnel.state;
        events.clear();
        api.listDeviceResults.add(_devices('device-current'));
        await controller.selectLocation(_frankfurt02);

        await controller.connect();

        expect(tunnel.disconnectCalls, 1);
        expect(events, <String>['tunnel.disconnect']);
        expect(api.startMigrationCalls, isEmpty);
        expect(api.migrationPollCalls, isEmpty);
        expect(api.registerDeviceCalls.single.locationId, _frankfurt02.id);
        expect(api.revokeDeviceIds, isEmpty);
        expect(tunnel.clearedAccountIds, isEmpty);
        expect(
          tunnel.wireGuardConnections.single.configuration.deviceId,
          'device-current',
        );
        expect(controller.currentDeviceId, 'device-current');
        expect(controller.locationMigration, isNull);
      },
    );

    test(
      'préserve CSR, certificat et appareil lors d une migration OpenVPN',
      () async {
        final _FakeApi api = _FakeApi()
          ..profilesByToken['session-a'] = _profile('user-a')
          ..locationsResult = const <Location>[_frankfurt, _frankfurt02]
          ..deviceListResult = _devices('device-current')
          ..deviceConfiguration = _wireGuardConfigurationFor('device-current')
          ..openVpnActivation = _openVpnActivation('device-current')
          ..migrationStartResult = _locationMigration(
            deviceId: 'device-current',
            targetLocationId: _frankfurt02.id,
            status: LocationMigrationStatus.ready,
          );
        final _FakeSessionStore store = _FakeSessionStore()
          ..storedSession = _session('session-a')
          ..deviceIds['user-a'] = 'device-current';
        final _FakeTunnel tunnel = _FakeTunnel();
        final VpnAppController controller = _controller(
          api: api,
          store: store,
          preferences: _FakePreferences(),
          tunnel: tunnel,
          migrationDelay: (_) => Future<void>.value(),
        );
        addTearDown(() async {
          controller.dispose();
          await tunnel.close();
        });
        await controller.initialize();
        api.listDeviceResults.addAll(<DeviceList>[
          _devices('device-current'),
          _devices('device-current', location: _frankfurt02),
        ]);
        await controller.selectLocation(_frankfurt02);
        await controller.selectProtocol(VpnProtocol.openVpn);

        await controller.connect();

        expect(tunnel.openVpnCsrCalls.single.deviceId, 'device-current');
        expect(tunnel.openVpnCsrCalls.single.renewal, isFalse);
        expect(api.createOpenVpnCalls.single.deviceId, 'device-current');
        expect(api.renewOpenVpnCalls, 0);
        expect(
          tunnel.openVpnConnections.single.preserveExistingCertificate,
          isTrue,
        );
        expect(
          tunnel.openVpnConnections.single.activation.certificatePem,
          'certificate-response-only',
        );
        expect(api.revokeDeviceIds, isEmpty);
        expect(tunnel.clearedAccountIds, isEmpty);
      },
    );

    test('conserve la migration bloquée, sans boucle ni révocation', () async {
      final _RestoredHarness harness = await _restoredHarness(
        events: <String>[],
      );
      addTearDown(harness.close);
      harness.api.locationsResult = const <Location>[_frankfurt, _frankfurt02];
      await harness.controller.refreshLocations();
      harness.api.deviceConfiguration = _wireGuardConfigurationFor(
        'device-current',
      );
      harness.api.migrationStartResult = _locationMigration(
        deviceId: 'device-current',
        targetLocationId: _frankfurt02.id,
        status: LocationMigrationStatus.blocked,
      );
      await harness.controller.selectLocation(_frankfurt02);
      await harness.controller.selectProtocol(VpnProtocol.openVpn);

      await harness.controller.connect();

      expect(harness.api.migrationPollCalls, isEmpty);
      expect(harness.api.revokeDeviceIds, isEmpty);
      expect(harness.tunnel.wireGuardConnections, isEmpty);
      expect(
        harness.controller.locationMigration?.status,
        LocationMigrationStatus.blocked,
      );
      expect(harness.controller.notice?.titleKey, 'notice.controller.title');
      expect(
        harness.controller.notice?.arguments['code'],
        'location_migration_blocked',
      );
    });

    test('reprend une migration mémorisée après redémarrage', () async {
      final _FakeApi api = _FakeApi()
        ..profilesByToken['session-a'] = _profile('user-a')
        ..listDeviceResults.addAll(<DeviceList>[
          _devices('device-current'),
          _devices('device-current', location: _frankfurt02),
        ])
        ..migrationPollResults.add(
          _locationMigration(
            deviceId: 'device-current',
            targetLocationId: _frankfurt02.id,
            status: LocationMigrationStatus.ready,
          ),
        );
      final _FakeSessionStore store = _FakeSessionStore()
        ..storedSession = _session('session-a')
        ..deviceIds['user-a'] = 'device-current'
        ..migrations['user-a/device-current'] = _locationMigration(
          deviceId: 'device-current',
          targetLocationId: _frankfurt02.id,
          status: LocationMigrationStatus.activating,
          retryAfterSeconds: 0,
        );
      final _FakeTunnel tunnel = _FakeTunnel();
      final VpnAppController controller = _controller(
        api: api,
        store: store,
        preferences: _FakePreferences(),
        tunnel: tunnel,
        migrationDelay: (_) => Future<void>.value(),
      );
      addTearDown(() async {
        controller.dispose();
        await tunnel.close();
      });

      await controller.initialize();
      await Future<void>.delayed(Duration.zero);

      expect(api.migrationPollCalls, hasLength(1));
      expect(controller.currentDevice?.location?.id, _frankfurt02.id);
      expect(controller.locationMigration, isNull);
      expect(store.migrations, isEmpty);
      expect(tunnel.wireGuardConnections, isEmpty);
    });

    test('reprend sur demande sans recréer ni révoquer l appareil', () async {
      final _RestoredHarness harness = await _restoredHarness(
        events: <String>[],
      );
      addTearDown(harness.close);
      harness.store.migrations['user-a/device-current'] = _locationMigration(
        status: LocationMigrationStatus.blocked,
        retryAfterSeconds: 7,
      );
      await harness.controller.initialize();
      harness.api.migrationPollResults.add(
        _locationMigration(status: LocationMigrationStatus.ready),
      );
      harness.api.deviceListResult = _devices(
        'device-current',
        location: _frankfurt02,
      );

      await harness.controller.resumeLocationMigration();

      expect(harness.api.migrationPollCalls, hasLength(1));
      expect(harness.api.startMigrationCalls, isEmpty);
      expect(harness.api.registerDeviceCalls, isEmpty);
      expect(harness.api.revokeDeviceIds, isEmpty);
      expect(harness.tunnel.clearedAccountIds, isEmpty);
      expect(harness.controller.currentDeviceId, 'device-current');
      expect(harness.controller.currentDevice?.location?.id, _frankfurt02.id);
      expect(harness.controller.locationMigration, isNull);
    });

    test(
      'refuse une autre destination tant que la migration est en cours',
      () async {
        final _RestoredHarness harness = await _restoredHarness(
          events: <String>[],
        );
        addTearDown(harness.close);
        harness.store.migrations['user-a/device-current'] = _locationMigration(
          deviceId: 'device-current',
          targetLocationId: _frankfurt02.id,
          status: LocationMigrationStatus.blocked,
        );
        await harness.controller.initialize();

        await harness.controller.selectLocation(_frankfurt02);

        expect(harness.controller.selectedLocation?.id, _frankfurt.id);
        expect(harness.controller.notice?.titleKey, 'notice.controller.title');
        expect(
          harness.controller.notice?.arguments['code'],
          'location_migration_pending',
        );
        expect(harness.api.startMigrationCalls, isEmpty);
      },
    );

    test(
      'libère le profil OpenVPN puis retente WireGuard directement une fois',
      () async {
        final _RestoredHarness harness = await _restoredHarness(
          events: <String>[],
        );
        addTearDown(harness.close);
        harness.api.deviceConfiguration = _wireGuardConfigurationFor(
          'device-current',
        );
        harness.api.locationsResult = const <Location>[
          _frankfurt,
          _frankfurt02,
        ];
        await harness.controller.refreshLocations();
        await harness.controller.selectLocation(_frankfurt02);
        harness.api.listDeviceResults.addAll(<DeviceList>[
          _devices('device-current'),
          _devices('device-current', location: _frankfurt02),
        ]);
        harness.api.registerDeviceFailures.add(
          const ApiException(
            statusCode: 409,
            errorCode: 'device_location_locked',
          ),
        );
        await harness.controller.connect();

        expect(harness.api.startMigrationCalls, isEmpty);
        expect(harness.api.migrationPollCalls, isEmpty);
        expect(harness.api.revokeOpenVpnProfileIds, <String>['device-current']);
        expect(harness.tunnel.clearedOpenVpnIdentities, <String>[
          'user-a/device-current',
        ]);
        expect(harness.api.revokeDeviceIds, isEmpty);
        expect(harness.tunnel.clearedAccountIds, isEmpty);
        expect(harness.api.registerDeviceCalls, hasLength(2));
        expect(harness.tunnel.wireGuardConnections, hasLength(1));
      },
    );

    test(
      'ne supprime pas l identité OpenVPN locale si sa révocation échoue',
      () async {
        final _RestoredHarness harness = await _restoredHarness(
          events: <String>[],
        );
        addTearDown(harness.close);
        harness.api.deviceConfiguration = _wireGuardConfigurationFor(
          'device-current',
        );
        harness.api.locationsResult = const <Location>[
          _frankfurt,
          _frankfurt02,
        ];
        await harness.controller.refreshLocations();
        await harness.controller.selectLocation(_frankfurt02);
        harness.api.listDeviceResults.add(_devices('device-current'));
        harness.api.registerDeviceFailures.add(
          const ApiException(
            statusCode: 409,
            errorCode: 'device_location_locked',
          ),
        );
        harness.api.revokeOpenVpnProfileFailure = const ApiException(
          statusCode: 503,
          errorCode: 'server_error',
        );

        await harness.controller.connect();

        expect(harness.api.registerDeviceCalls, hasLength(1));
        expect(harness.api.revokeOpenVpnProfileIds, <String>['device-current']);
        expect(harness.tunnel.clearedOpenVpnIdentities, isEmpty);
        expect(harness.api.startMigrationCalls, isEmpty);
        expect(harness.tunnel.wireGuardConnections, isEmpty);
        expect(harness.controller.notice?.arguments['code'], 'server_error');
      },
    );
  });

  group('VpnAppController revocation and API failures', () {
    test('ne supprime jamais l identité locale si DELETE échoue', () async {
      final List<String> events = <String>[];
      final _RestoredHarness harness = await _restoredHarness(events: events);
      addTearDown(harness.close);
      harness.api.revokeDeviceFailure = const ApiException(
        statusCode: 503,
        errorCode: 'server_error',
      );
      events.clear();

      final bool removed = await harness.controller.revokeDevice(
        harness.controller.currentDevice!,
      );

      expect(removed, isFalse);
      expect(harness.api.revokeDeviceIds, <String>['device-current']);
      expect(harness.tunnel.clearedAccountIds, isEmpty);
      expect(harness.store.clearedDeviceUsers, isEmpty);
      expect(harness.controller.currentDeviceId, 'device-current');
      expect(events, <String>['api.revoke:device-current']);
    });

    test('nettoie l identité locale seulement après DELETE réussi', () async {
      final List<String> events = <String>[];
      final _RestoredHarness harness = await _restoredHarness(events: events);
      addTearDown(harness.close);
      events.clear();

      final bool removed = await harness.controller.revokeDevice(
        harness.controller.currentDevice!,
      );

      expect(removed, isTrue);
      expect(harness.tunnel.clearedAccountIds, <String>['user-a']);
      expect(harness.store.clearedDeviceUsers, <String>['user-a']);
      expect(harness.controller.currentDeviceId, isNull);
      expect(events, <String>[
        'api.revoke:device-current',
        'tunnel.clear:user-a',
        'store.clearDevice:user-a',
      ]);
    });

    test('affiche la limite d appareils et ne démarre pas le tunnel', () async {
      final _SignedInHarness harness = await _signedInHarness();
      addTearDown(harness.close);
      harness.api.registerDeviceFailure = const ApiException(
        statusCode: 409,
        errorCode: 'device_limit',
      );

      await harness.controller.connect();

      expect(harness.tunnel.wireGuardConnections, isEmpty);
      expect(harness.tunnel.openVpnConnections, isEmpty);
      expect(harness.controller.isConnecting, isFalse);
      expect(harness.controller.notice?.titleKey, 'notice.api.title');
      expect(harness.controller.notice?.arguments['code'], 'device_limit');
    });

    test(
      'supprime la session locale lors d une réponse unauthorized',
      () async {
        final _SignedInHarness harness = await _signedInHarness();
        addTearDown(harness.close);
        harness.api.listDevicesFailure = const ApiException(
          statusCode: 401,
          errorCode: 'unauthorized',
        );

        await harness.controller.refreshDevices();

        expect(harness.controller.isSignedIn, isFalse);
        expect(harness.controller.profile, isNull);
        expect(harness.controller.currentDeviceId, isNull);
        expect(harness.store.clearSessionCalls, 1);
        expect(harness.controller.notice?.titleKey, 'notice.api.title');
        expect(harness.controller.notice?.arguments['code'], 'unauthorized');
      },
    );
  });
}

VpnAppController _controller({
  required _FakeApi api,
  required _FakeSessionStore store,
  required _FakePreferences preferences,
  required _FakeTunnel tunnel,
  Future<void> Function(Duration)? migrationDelay,
}) => VpnAppController(
  api: api,
  sessionStore: store..tunnel = tunnel,
  preferences: preferences,
  tunnel: tunnel,
  migrationDelay: migrationDelay,
);

Future<_SignedInHarness> _signedInHarness() async {
  final _FakeApi api = _FakeApi()
    ..loginResult = _session('session-a')
    ..profilesByToken['session-a'] = _profile('user-a')
    ..deviceListResult = const DeviceList(limit: 2, devices: <VpnDevice>[])
    ..deviceConfiguration = _wireGuardConfiguration
    ..openVpnActivation = _openVpnActivation();
  final _FakeSessionStore store = _FakeSessionStore();
  final _FakeTunnel tunnel = _FakeTunnel();
  final VpnAppController controller = _controller(
    api: api,
    store: store,
    preferences: _FakePreferences(),
    tunnel: tunnel,
  );
  await controller.initialize();
  expect(
    await controller.signIn(email: 'client@example.test', password: 'secret'),
    isTrue,
  );
  return _SignedInHarness(
    api: api,
    store: store,
    tunnel: tunnel,
    controller: controller,
  );
}

Future<_RestoredHarness> _restoredHarness({
  required List<String> events,
  void Function(_FakeApi, _FakeSessionStore, _FakeTunnel)? prepare,
  Future<void> Function(Duration)? migrationDelay,
}) async {
  final _FakeApi api = _FakeApi(events: events)
    ..profilesByToken['session-a'] = _profile('user-a')
    ..deviceListResult = _devices('device-current');
  final _FakeSessionStore store = _FakeSessionStore(events: events)
    ..storedSession = _session('session-a')
    ..deviceIds['user-a'] = 'device-current';
  final _FakeTunnel tunnel = _FakeTunnel(events: events);
  prepare?.call(api, store, tunnel);
  final VpnAppController controller = _controller(
    api: api,
    store: store,
    preferences: _FakePreferences(),
    tunnel: tunnel,
    migrationDelay: migrationDelay,
  );
  await controller.initialize();
  return _RestoredHarness(
    api: api,
    store: store,
    tunnel: tunnel,
    controller: controller,
  );
}

Future<_RestoredHarness> _blockedMigrationHarness({
  Future<void> Function(Duration)? migrationDelay,
}) => _restoredHarness(
  events: [],
  migrationDelay: migrationDelay,
  prepare: (api, store, tunnel) {
    store.migrations['user-a/device-current'] = _locationMigration(
      status: LocationMigrationStatus.blocked,
    );
  },
);

class _SignedInHarness {
  const _SignedInHarness({
    required this.api,
    required this.store,
    required this.tunnel,
    required this.controller,
  });

  final _FakeApi api;
  final _FakeSessionStore store;
  final _FakeTunnel tunnel;
  final VpnAppController controller;

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _RestoredHarness {
  const _RestoredHarness({
    required this.api,
    required this.store,
    required this.tunnel,
    required this.controller,
  });

  final _FakeApi api;
  final _FakeSessionStore store;
  final _FakeTunnel tunnel;
  final VpnAppController controller;

  Future<void> close() async {
    controller.dispose();
    await tunnel.close();
  }
}

class _FakeApi implements VpnApiRepository {
  _FakeApi({List<String>? events}) : _events = events ?? <String>[];

  final List<String> _events;
  final Map<String, UserProfile> profilesByToken = <String, UserProfile>{};
  final List<String> meTokens = <String>[];
  final List<_RegisterDeviceCall> registerDeviceCalls = <_RegisterDeviceCall>[];
  final List<_OpenVpnProfileCall> createOpenVpnCalls = <_OpenVpnProfileCall>[];
  final List<_LocationMigrationCall> startMigrationCalls =
      <_LocationMigrationCall>[];
  final List<_LocationMigrationPollCall> migrationPollCalls =
      <_LocationMigrationPollCall>[];
  final List<String> revokeDeviceIds = <String>[];
  final List<String> revokeOpenVpnProfileIds = <String>[];
  final List<String> listDeviceTokens = <String>[];
  final List<DeviceList> listDeviceResults = <DeviceList>[];
  final List<(String, bool)> ipRequests = [];
  final List<(String, String)> csrRequests = [];
  final Map<String, List<ApiFailure>> ipFailures = {};
  ApiFailure? locationsFailure;
  int renewOpenVpnCalls = 0;
  final Map<String, Future<void> Function()> hooks = {};
  final List<String> logoutTokens = [];
  Future<void> pause(String method) async {
    await hooks[method]?.call();
  }

  List<Location> locationsResult = const <Location>[_frankfurt];
  DeviceList deviceListResult = const DeviceList(
    limit: 2,
    devices: <VpnDevice>[],
  );
  AuthSession loginResult = AuthSession(
    accessToken: 'session-a',
    expiresAt: DateTime.utc(2099, 1, 1),
  );
  DeviceConfiguration deviceConfiguration = _wireGuardConfiguration;
  OpenVpnActivation openVpnActivation = _openVpnActivation();
  ApiFailure? loginFailure;
  ApiFailure? listDevicesFailure;
  ApiFailure? registerDeviceFailure;
  final List<ApiFailure> registerDeviceFailures = <ApiFailure>[];
  ApiFailure? revokeDeviceFailure;
  ApiFailure? revokeOpenVpnProfileFailure;
  ApiFailure? createOpenVpnFailure;
  ApiFailure? renewOpenVpnFailure;
  ApiFailure? startMigrationFailure;
  ApiFailure? getMigrationFailure;
  DeviceLocationMigration migrationStartResult = _locationMigration(
    status: LocationMigrationStatus.ready,
  );
  final List<DeviceLocationMigration> migrationPollResults =
      <DeviceLocationMigration>[];

  @override
  Future<void> confirmPasswordReset({
    required String token,
    required String password,
  }) async {}

  @override
  Future<OpenVpnActivation> createOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) async {
    await pause('createOpenVpnProfile');
    ipRequests.add(('createOpenVpnProfile', requestIpv6));
    csrRequests.add(('createOpenVpnProfile', csrPem));
    if (ipFailures['createOpenVpnProfile']?.isNotEmpty == true) {
      throw ipFailures['createOpenVpnProfile']!.removeAt(0);
    }
    createOpenVpnCalls.add(
      _OpenVpnProfileCall(token: token, deviceId: deviceId, csrPem: csrPem),
    );
    _throwIf(createOpenVpnFailure);
    return openVpnActivation;
  }

  @override
  Future<DeviceProfiles> deviceProfiles({
    required String token,
    required String deviceId,
  }) async =>
      DeviceProfiles(deviceId: deviceId, profiles: const <VpnProfile>[]);

  @override
  Future<List<Location>> locations() async {
    await pause('locations');
    _throwIf(locationsFailure);
    return locationsResult;
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    await pause('login');
    _throwIf(loginFailure);
    return loginResult;
  }

  @override
  Future<void> logout(String token) async {
    logoutTokens.add(token);
    await pause('logout');
  }

  @override
  Future<DeviceList> listDevices(String token) async {
    await pause('listDevices');
    listDeviceTokens.add(token);
    _throwIf(listDevicesFailure);
    return listDeviceResults.isNotEmpty
        ? listDeviceResults.removeAt(0)
        : deviceListResult;
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
    _events.add('api.startMigration:$deviceId');
    _throwIf(startMigrationFailure);
    return migrationStartResult;
  }

  @override
  Future<DeviceLocationMigration> getLocationMigration({
    required String token,
    required String deviceId,
    required String migrationId,
  }) async {
    await pause('getLocationMigration');
    migrationPollCalls.add(
      _LocationMigrationPollCall(
        token: token,
        deviceId: deviceId,
        migrationId: migrationId,
      ),
    );
    _throwIf(getMigrationFailure);
    return migrationPollResults.isNotEmpty
        ? migrationPollResults.removeAt(0)
        : migrationStartResult;
  }

  @override
  Future<UserProfile> me(String token) async {
    await pause('me');
    meTokens.add(token);
    final UserProfile? profile = profilesByToken[token];
    if (profile == null) {
      throw StateError('Profil de test manquant pour $token');
    }
    return profile;
  }

  @override
  Future<RegistrationResult> register(RegisterAccountRequest request) async =>
      RegistrationResult(
        accessToken: loginResult.accessToken,
        expiresAt: loginResult.expiresAt,
        verificationEmailSent: true,
      );

  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    await pause('registerDevice');
    ipRequests.add(('registerDevice', requestIpv6));
    if (ipFailures['registerDevice']?.isNotEmpty == true) {
      throw ipFailures['registerDevice']!.removeAt(0);
    }
    registerDeviceCalls.add(
      _RegisterDeviceCall(
        token: token,
        name: name,
        publicKey: publicKey,
        locationId: locationId,
      ),
    );
    if (registerDeviceFailures.isNotEmpty) {
      throw registerDeviceFailures.removeAt(0);
    }
    _throwIf(registerDeviceFailure);
    return deviceConfiguration;
  }

  @override
  Future<OpenVpnActivation> renewOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) async {
    await pause('renewOpenVpnProfile');
    ipRequests.add(('renewOpenVpnProfile', requestIpv6));
    csrRequests.add(('renewOpenVpnProfile', csrPem));
    if (ipFailures['renewOpenVpnProfile']?.isNotEmpty == true) {
      throw ipFailures['renewOpenVpnProfile']!.removeAt(0);
    }
    renewOpenVpnCalls += 1;
    _throwIf(renewOpenVpnFailure);
    return openVpnActivation;
  }

  @override
  Future<void> requestPasswordReset(String email) async {}

  @override
  Future<void> resendVerification(String token) async {
    await pause('resendVerification');
  }

  @override
  Future<void> revokeDevice({
    required String token,
    required String deviceId,
  }) async {
    await pause('revokeDevice');
    revokeDeviceIds.add(deviceId);
    _events.add('api.revoke:$deviceId');
    _throwIf(revokeDeviceFailure);
  }

  @override
  Future<void> revokeOpenVpnProfile({
    required String token,
    required String deviceId,
  }) async {
    await pause('revokeOpenVpnProfile');
    revokeOpenVpnProfileIds.add(deviceId);
    _events.add('api.revokeOpenVpn:$deviceId');
    _throwIf(revokeOpenVpnProfileFailure);
  }

  @override
  Future<UserProfile> updateMe({
    required String token,
    required UpdateProfileRequest request,
  }) async => me(token);

  @override
  Future<bool> verifyEmail(String token) async => true;

  void _throwIf(ApiFailure? failure) {
    if (failure != null) throw failure;
  }
}

class _FakeSessionStore implements SecureSessionStore {
  _FakeSessionStore({List<String>? events}) : _events = events ?? <String>[];

  final List<String> _events;
  AuthSession? storedSession;
  final Map<String, String> deviceIds = <String, String>{};
  final Map<String, DeviceLocationMigration> migrations =
      <String, DeviceLocationMigration>{};
  final List<String> clearedMigrations = [];
  final List<String> readDeviceUsers = <String>[];
  final List<String> clearedDeviceUsers = <String>[];
  final List<String?> sessionWriteUsers = <String?>[];
  int clearSessionCalls = 0;
  _FakeTunnel? tunnel;
  bool failClear = false;
  Completer<void>? clearEntered;
  Completer<void>? clearRelease;
  Future<void> Function()? beforeWrite;
  Object? readFailure;
  final Map<String, Future<void> Function()> hooks = {};

  @override
  Future<void> clearCurrentDeviceId({required String userId}) async {
    clearedDeviceUsers.add(userId);
    deviceIds.remove(userId);
    _events.add('store.clearDevice:$userId');
  }

  @override
  Future<void> clearLocationMigration({
    required String userId,
    required String deviceId,
  }) async {
    clearedMigrations.add('$userId/$deviceId');
    migrations.remove('$userId/$deviceId');
  }

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    clearSessionCalls += 1;
    clearEntered?.complete();
    if (clearRelease != null) await clearRelease!.future;
    String? stopError;
    try {
      await tunnel?.disconnect();
    } on NativeVpnException catch (error) {
      stopError = error.code;
    }
    if (!failClear) storedSession = null;
    return SessionTerminationResult(
      tunnelStopped: stopError == null,
      sessionCleared: !failClear,
      stopError: stopError,
      storageError: failClear ? 'secure_storage_write_failed' : null,
    );
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async {
    readDeviceUsers.add(userId);
    final value = deviceIds[userId];
    await hooks['readCurrentDevice']?.call();
    return value;
  }

  @override
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  }) async {
    final value = migrations['$userId/$deviceId'];
    await hooks['readLocationMigration']?.call();
    return value;
  }

  @override
  Future<AuthSession?> readSession() async {
    final value = storedSession;
    await hooks['readSession']?.call();
    if (readFailure != null) throw readFailure!;
    return value;
  }

  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async {
    deviceIds[userId] = deviceId;
  }

  @override
  Future<void> writeLocationMigration({
    required String userId,
    required DeviceLocationMigration migration,
  }) async {
    migrations['$userId/${migration.deviceId}'] = migration;
  }

  @override
  Future<void> writeSession(AuthSession session, {String? userId}) async {
    if (beforeWrite != null) await beforeWrite!();
    storedSession = session;
    sessionWriteUsers.add(userId);
  }
}

class _FakePreferences implements AppPreferenceStore {
  String? themeMode;
  String? locale;
  String? selectedProtocol;
  String? selectedLocation;
  final Map<String, bool> verificationNeeded = <String, bool>{};

  @override
  Future<String?> readLocale() async => locale;

  @override
  Future<String?> readSelectedLocation() async => selectedLocation;

  @override
  Future<String?> readSelectedProtocol() async => selectedProtocol;

  @override
  Future<String?> readThemeMode() async => themeMode;

  @override
  Future<bool?> readVerificationNeeded({required String userId}) async =>
      verificationNeeded[userId];

  @override
  Future<void> writeLocale(String? languageCode) async {
    locale = languageCode;
  }

  @override
  Future<void> writeSelectedLocation(String value) async {
    selectedLocation = value;
  }

  @override
  Future<void> writeSelectedProtocol(String value) async {
    selectedProtocol = value;
  }

  @override
  Future<void> writeThemeMode(String value) async {
    themeMode = value;
  }

  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {
    verificationNeeded[userId] = value;
  }
}

class _FakeTunnel implements VpnTunnelGateway, VpnSystemProtectionGateway {
  _FakeTunnel({List<String>? events}) : _events = events ?? <String>[];

  final List<String> _events;
  final StreamController<VpnRuntimeState> _stateEvents =
      StreamController<VpnRuntimeState>.broadcast();
  final List<_WireGuardConnection> wireGuardConnections =
      <_WireGuardConnection>[];
  final List<_OpenVpnConnection> openVpnConnections = <_OpenVpnConnection>[];
  final List<_OpenVpnCsrCall> openVpnCsrCalls = <_OpenVpnCsrCall>[];
  final List<String> wireGuardKeyAccounts = <String>[];
  final List<String> clearedAccountIds = <String>[];
  final List<String?> clearedExpectedDeviceIds = <String?>[];
  final List<String> clearedOpenVpnIdentities = <String>[];
  VpnRuntimeState state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  bool permissionGranted = true;
  String wireGuardPublicKey = 'wireguard-public-key-only';
  String openVpnCsr = 'public-p256-csr-only';
  int permissionCalls = 0;
  int disconnectCalls = 0;
  int disconnectByUserCalls = 0;
  bool userDisconnectOpensSettings = false;
  int openVpnSettingsCalls = 0;
  final List<String> preparedTunnelRequests = <String>[];
  SystemVpnProtection systemProtection = const SystemVpnProtection();
  int revokedIdentityGeneration = 0;
  OpenVpnRevocationResult? pendingRevocation;
  OpenVpnRevocationResult? cleanupResult;
  final List<String> revocationCleanupCalls = [];
  @override
  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  }) async {
    await pause('getOpenVpnRevocation');
    return pendingRevocation?.accountId == accountId &&
            pendingRevocation?.deviceId == deviceId
        ? pendingRevocation
        : null;
  }

  @override
  Future<OpenVpnRevocationResult> cleanRevokedOpenVpnIdentity({
    required String accountId,
    required String deviceId,
    required String csrSha256,
  }) async {
    revocationCleanupCalls.add('$accountId/$deviceId/$csrSha256');
    await pause('cleanRevokedOpenVpnIdentity');
    if (cleanupResult != null) return pendingRevocation = cleanupResult!;
    if (csrSha256 != sha256.convert(utf8.encode(openVpnCsr)).toString() &&
        pendingRevocation?.csrSha256 != csrSha256) {
      return OpenVpnRevocationResult(
        accountId: accountId,
        deviceId: deviceId,
        csrSha256: csrSha256,
        stale: true,
      );
    }
    await clearOpenVpnIdentity(accountId: accountId, deviceId: deviceId);
    openVpnCsr = 'new-revocation-csr-${++revokedIdentityGeneration}';
    openVpnCertificateStatus = const OpenVpnCertificateStatus(
      phase: OpenVpnCertificatePhase.missing,
      renewalPending: false,
    );
    pendingRevocation = null;
    return OpenVpnRevocationResult(
      accountId: accountId,
      deviceId: deviceId,
      csrSha256: csrSha256,
      tunnelStopped: true,
      identityCleared: true,
      tileCleared: true,
      markerCleared: true,
    );
  }

  final Map<String, Future<void> Function()> hooks = {};
  Future<void> pause(String method) async {
    await hooks[method]?.call();
  }

  NativeVpnException? openVpnFailure;
  NativeVpnException? disconnectFailure;
  OpenVpnCertificateStatus openVpnCertificateStatus =
      const OpenVpnCertificateStatus(
        phase: OpenVpnCertificatePhase.missing,
        renewalPending: false,
      );

  @override
  Stream<VpnRuntimeState> get states => _stateEvents.stream;

  @override
  Future<void> clearAccountIdentity({
    required String accountId,
    required String? expectedDeviceId,
  }) async {
    clearedAccountIds.add(accountId);
    clearedExpectedDeviceIds.add(expectedDeviceId);
    _events.add('tunnel.clear:$accountId');
    wireGuardPublicKey = 'replacement-wireguard-public-key-only';
    openVpnCsr = 'replacement-public-p256-csr-only';
    await pause('clearAccountIdentity');
  }

  @override
  Future<void> clearOpenVpnIdentity({
    required String accountId,
    required String deviceId,
  }) async {
    clearedOpenVpnIdentities.add('$accountId/$deviceId');
    _events.add('tunnel.clearOpenVpn:$accountId/$deviceId');
    openVpnCsr = 'replacement-public-p256-csr-only';
  }

  Future<void> close() => _stateEvents.close();

  void emitConnected(VpnProtocol protocol) {
    state = VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: protocol,
    );
    _stateEvents.add(state);
  }

  @override
  Future<void> connectOpenVpn({
    required String accountId,
    required OpenVpnActivation activation,
    required Location location,
    bool preserveExistingCertificate = false,
    bool renewal = false,
  }) async {
    openVpnConnections.add(
      _OpenVpnConnection(
        accountId: accountId,
        activation: activation,
        preserveExistingCertificate: preserveExistingCertificate,
        renewal: renewal,
      ),
    );
    final NativeVpnException? failure = openVpnFailure;
    if (failure != null) throw failure;
    await pause('connectOpenVpn');
  }

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async {
    wireGuardConnections.add(
      _WireGuardConnection(accountId: accountId, configuration: configuration),
    );
    await pause('connectWireGuard');
  }

  @override
  Future<void> disconnect() async {
    disconnectCalls += 1;
    await pause('disconnect');
    _events.add('tunnel.disconnect');
    final NativeVpnException? failure = disconnectFailure;
    if (failure != null) throw failure;
    state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  }

  @override
  Future<void> disconnectByUser() async {
    disconnectByUserCalls += 1;
    if (userDisconnectOpensSettings) {
      openVpnSettingsCalls += 1;
      return;
    }
    await disconnect();
  }

  @override
  Future<String> getOrCreateOpenVpnCsr({
    required String accountId,
    required String deviceId,
    bool renewal = false,
  }) async {
    await pause('getOrCreateOpenVpnCsr');
    openVpnCsrCalls.add(
      _OpenVpnCsrCall(
        accountId: accountId,
        deviceId: deviceId,
        renewal: renewal,
      ),
    );
    return openVpnCsr;
  }

  @override
  Future<OpenVpnCertificateStatus> getOpenVpnCertificateStatus({
    required String accountId,
    required String deviceId,
  }) async => openVpnCertificateStatus;

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async {
    await pause('getOrCreateWireGuardPublicKey');
    wireGuardKeyAccounts.add(accountId);
    return wireGuardPublicKey;
  }

  @override
  Future<VpnRuntimeState> getState() async => state;

  @override
  Future<SystemVpnProtection> getSystemVpnProtection() async =>
      systemProtection;

  @override
  Future<void> openVpnSettings() async {
    openVpnSettingsCalls += 1;
  }

  @override
  Future<void> prepareTunnelRequest({required String accountId}) async {
    preparedTunnelRequests.add(accountId);
    await pause('prepareTunnelRequest');
  }

  @override
  Future<bool> requestVpnPermission() async {
    await pause('requestVpnPermission');
    permissionCalls += 1;
    return permissionGranted;
  }
}

class _RegisterDeviceCall {
  const _RegisterDeviceCall({
    required this.token,
    required this.name,
    required this.publicKey,
    required this.locationId,
  });

  final String token;
  final String name;
  final String publicKey;
  final String locationId;
}

class _OpenVpnProfileCall {
  const _OpenVpnProfileCall({
    required this.token,
    required this.deviceId,
    required this.csrPem,
  });

  final String token;
  final String deviceId;
  final String csrPem;
}

class _OpenVpnCsrCall {
  const _OpenVpnCsrCall({
    required this.accountId,
    required this.deviceId,
    required this.renewal,
  });

  final String accountId;
  final String deviceId;
  final bool renewal;
}

class _LocationMigrationCall {
  const _LocationMigrationCall({
    required this.token,
    required this.deviceId,
    required this.locationId,
  });

  final String token;
  final String deviceId;
  final String locationId;
}

class _LocationMigrationPollCall {
  const _LocationMigrationPollCall({
    required this.token,
    required this.deviceId,
    required this.migrationId,
  });

  final String token;
  final String deviceId;
  final String migrationId;
}

class _WireGuardConnection {
  const _WireGuardConnection({
    required this.accountId,
    required this.configuration,
  });

  final String accountId;
  final DeviceConfiguration configuration;
}

class _OpenVpnConnection {
  const _OpenVpnConnection({
    required this.accountId,
    required this.activation,
    required this.preserveExistingCertificate,
    required this.renewal,
  });

  final String accountId;
  final OpenVpnActivation activation;
  final bool preserveExistingCertificate;
  final bool renewal;
}
