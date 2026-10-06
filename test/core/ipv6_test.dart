import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/ip_activation_attempt.dart';

import 'api_client_test.dart'
    show RecordingTransport, wireGuardJson, openVpnJson, noStoreHeaders;

Map<String, dynamic> dual(Map<String, dynamic> legacy) => {
  ...legacy,
  'ip_families': ['ipv4', 'ipv6'],
  'addresses': [legacy['address'], 'fd0d:295d:995b:2::3/128'],
  'allowed_ips': ['0.0.0.0/0', '::/0'],
};

void main() {
  test('legacy IPv4 and immutable dual stack network contracts', () {
    final old = VpnNetworkConfiguration.fromJson(
      openVpnJson(),
      legacyOpenVpn: true,
    );
    expect(old.dualStack, isFalse);
    final source = dual(wireGuardJson());
    final network = VpnNetworkConfiguration.fromJson(source);
    (source['addresses'] as List)[1] = 'fd00::9/128';
    expect(network.addresses[1], 'fd0d:295d:995b:2::3/128');
    expect(network.toWire()['allowed_ips'], ['0.0.0.0/0', '::/0']);
    expect(() => network.addresses.clear(), throwsUnsupportedError);
    expect(() => network.ipFamilies.clear(), throwsUnsupportedError);
  });

  final invalid = <String, void Function(Map<String, dynamic>)>{
    'missing families': (v) => v.remove('ip_families'),
    'missing addresses': (v) => v.remove('addresses'),
    'missing routes': (v) => v.remove('allowed_ips'),
    'null families': (v) => v['ip_families'] = null,
    'only ipv6': (v) => v['ip_families'] = ['ipv6'],
    'contradictory families': (v) => v['ip_families'] = ['ipv4'],
    'extra address': (v) => (v['addresses'] as List).add('fd00::7/128'),
    'missing address': (v) => (v['addresses'] as List).removeLast(),
    'different IPv4': (v) => (v['addresses'] as List)[0] = '10.10.0.3/32',
    'IPv4 prefix': (v) => v['address'] = '10.10.0.2/24',
    'IPv6 prefix': (v) => (v['addresses'] as List)[1] = 'fd00::3/64',
    'global IPv6': (v) => (v['addresses'] as List)[1] = '2001:db8::3/128',
    'scoped IPv6': (v) => (v['addresses'] as List)[1] = 'fd00::3%wlan0/128',
    'malformed IPv6': (v) => (v['addresses'] as List)[1] = 'fd00:::3/128',
    'missing IPv6 route': (v) => v['allowed_ips'] = ['0.0.0.0/0'],
    'split IPv6 route': (v) => v['allowed_ips'] = ['0.0.0.0/0', 'fd00::/8'],
  };
  for (final entry in invalid.entries) {
    test('rejects ${entry.key} without IPv4 downgrade', () {
      final value = dual(wireGuardJson());
      entry.value(value);
      expect(
        () => VpnNetworkConfiguration.fromJson(value),
        throwsFormatException,
      );
    });
  }
  test('IPv4 response cannot hide IPv6 routes', () {
    expect(
      () => VpnNetworkConfiguration.fromJson({
        ...wireGuardJson(),
        'allowed_ips': ['0.0.0.0/0', '::/0'],
      }),
      throwsFormatException,
    );
  });
  test('catalog supports historical omission and explicit capabilities', () {
    expect(VpnNetworkConfiguration.advertisedIpv6(null), isFalse);
    expect(VpnNetworkConfiguration.advertisedIpv6(['ipv4']), isFalse);
    expect(VpnNetworkConfiguration.advertisedIpv6(['ipv4', 'ipv6']), isTrue);
    expect(
      () => VpnNetworkConfiguration.advertisedIpv6(['ipv6']),
      throwsFormatException,
    );
  });

  for (final ipv6 in [false, true]) {
    test(
      'three authenticated API bodies use ${ipv6 ? "dual stack" : "omission"}',
      () async {
        final transport = RecordingTransport()
          ..respond(
            201,
            body: ipv6 ? dual(wireGuardJson()) : wireGuardJson(),
            headers: noStoreHeaders,
          )
          ..respond(
            201,
            body: ipv6 ? dual(openVpnJson()) : openVpnJson(),
            headers: noStoreHeaders,
          )
          ..respond(
            201,
            body: ipv6 ? dual(openVpnJson()) : openVpnJson(),
            headers: noStoreHeaders,
          );
        final client = ApiClient(
          baseUri: Uri.parse('https://api.example.test/'),
          transport: transport,
        );
        final wg = await client.registerDevice(
          token: 'session',
          name: 'phone',
          publicKey: 'same-key',
          locationId: 'frankfurt-01',
          requestIpv6: ipv6,
        );
        final created = await client.createOpenVpnProfile(
          token: 'session',
          deviceId: 'device-123',
          csrPem: 'same-csr',
          requestIpv6: ipv6,
        );
        final renewed = await client.renewOpenVpnProfile(
          token: 'session',
          deviceId: 'device-123',
          csrPem: 'same-csr',
          requestIpv6: ipv6,
        );
        expect(
          [
            wg.network.dualStack,
            created.network.dualStack,
            renewed.network.dualStack,
          ],
          [ipv6, ipv6, ipv6],
        );
        for (final request in transport.requests) {
          final body = jsonDecode(request.body!) as Map;
          expect(body.containsKey('ip_families'), ipv6);
          if (ipv6) expect(body['ip_families'], ['ipv4', 'ipv6']);
        }
      },
    );
  }

  const unavailable = ApiException(
    statusCode: 503,
    errorCode: 'ipv6_unavailable',
  );
  IpActivationAttempt attempt({bool Function(IpActivationAttempt)? matches}) =>
      IpActivationAttempt(
        matches: matches ?? (_) => true,
        deviceId: 'device',
        deviceEpoch: 0,
      )..requestIpv6 = true;

  test(
    '503 fallback is shared by enrollment and later profile steps',
    () async {
      final state = attempt();
      final sent = <bool>[];
      await state.request((ipv6) async {
        sent.add(ipv6);
        if (ipv6) throw unavailable;
        return 'same-key';
      });
      await state.request((ipv6) async {
        sent.add(ipv6);
        return 'same-csr';
      });
      expect(sent, [true, false, false]);
      expect(state.fellBack, isTrue);
    },
  );
  test('fallback never changes an already dual stack response', () async {
    final state = attempt();
    final network = await state.request((ipv6) async {
      if (ipv6) throw unavailable;
      return VpnNetworkConfiguration.fromJson(dual(wireGuardJson()));
    });
    expect(network.dualStack, isTrue);
    expect(state.requestIpv6, isFalse);
  });
  test('second ipv6_unavailable is final', () async {
    var calls = 0;
    await expectLater(
      attempt().request((_) async {
        calls++;
        throw unavailable;
      }),
      throwsA(isA<ApiFailure>()),
    );
    expect(calls, 2);
  });
  for (final error in [
    const ApiException(statusCode: 409, errorCode: 'ipv6_unavailable'),
    const ApiException(statusCode: 503, errorCode: 'target_unavailable'),
    const ApiException(statusCode: 401, errorCode: 'unauthorized'),
  ]) {
    test('no fallback for ${error.statusCode}/${error.code}', () async {
      var calls = 0;
      await expectLater(
        attempt().request((_) async {
          calls++;
          throw error;
        }),
        throwsA(isA<ApiFailure>()),
      );
      expect(calls, 1);
    });
  }
  for (final phase in ['initial', 'fallback']) {
    for (final error in [false, true]) {
      test('cancel stale $phase ${error ? "failure" : "success"}', () async {
        var current = true;
        var calls = 0;
        final held = Completer<String>();
        final state = attempt(matches: (_) => current);
        final result = state.request((ipv6) {
          calls++;
          if (phase == 'fallback' && ipv6) {
            return Future<String>.error(unavailable);
          }
          return held.future;
        });
        final expectation = expectLater(
          result,
          throwsA(isA<SessionOperationCancelled>()),
        );
        await Future<void>.delayed(Duration.zero);
        current = false;
        if (error) {
          held.completeError(unavailable);
        } else {
          held.complete('late');
        }
        await expectation;
        expect(calls, phase == 'initial' ? 1 : 2);
      });
    }
  }
  test(
    'identity invalidation stops fallback before the second request',
    () async {
      var identity = true;
      var calls = 0;
      await expectLater(
        attempt().request(
          (_) async {
            calls++;
            identity = false;
            throw unavailable;
          },
          checkIdentity: () {
            if (!identity) throw const SessionOperationCancelled();
          },
        ),
        throwsA(isA<SessionOperationCancelled>()),
      );
      expect(calls, 1);
    },
  );
}
