// Corrections du 29/10/2026 — C5-…-01, C5-…-05, A05-models-01, A05-models-02.
// Frontière réelle : ApiClient public + jsonDecode + modèles ; seul le
// transport HTTP est simulé. Ce que Dart accepte doit l'être aussi par le
// natif (TunnelNetworkSpec, OpenVpnController, AndroidVpnBridge) avant tout
// effet serveur, et une ligne inattendue ne doit pas invalider toute une liste.
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';

class _Transport extends ApiHttpTransport {
  final Queue<ApiHttpResponse> replies = Queue<ApiHttpResponse>();

  void reply(
    int status,
    Object body, [
    Map<String, String> headers = _noStore,
  ]) => replies.add(
    ApiHttpResponse(
      statusCode: status,
      headers: headers,
      body: jsonEncode(body),
    ),
  );

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) async =>
      replies.removeFirst();
}

class _RecordingTransport extends _Transport {
  _RecordingTransport(this.requests);

  final List<ApiHttpRequest> requests;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest request) {
    requests.add(request);
    return super.send(request);
  }
}

const _noStore = <String, String>{'cache-control': 'no-store'};

Map<String, Object?> _location(
  String id, {
  Object? families,
  String? displayName,
  bool includeFamilies = true,
}) => {
  'id': id,
  'city': 'Paris',
  'country_code': 'FR',
  'display_name': displayName ?? 'Paris $id',
  'supported_protocols': ['wireguard', 'openvpn'],
  if (includeFamilies && families != null) 'supported_ip_families': families,
};

Future<List<Location>> _catalogue(List<Map<String, Object?>> rows) {
  final transport = _Transport()..reply(200, {'locations': rows});
  return ApiClient(transport: transport).locations();
}

Future<DeviceList> _devices(List<Map<String, Object?>> devices) {
  final transport = _Transport()..reply(200, {'limit': 5, 'devices': devices});
  return ApiClient(transport: transport).listDevices('session-fixture');
}

Map<String, Object?> _wireGuard({Object? dns}) => {
  'device_id': 'device-123',
  'address': '10.10.0.2/32',
  'dns': dns ?? ['1.1.1.1'],
  'server_public_key': 'server-public-key',
  'endpoint': '198.51.100.10:51820',
  'allowed_ips': ['0.0.0.0/0'],
};

Map<String, Object?> _openVpn({Object? endpoint, Object? dns}) => {
  'device_id': 'device-123',
  'protocol': 'openvpn',
  'address': '10.20.0.2/32',
  'dns': dns ?? ['1.1.1.1'],
  'endpoint': endpoint ?? '198.51.100.10',
  'server_name': 'paris-01.openvpn.example.test',
  'remote_cert_tls_server': true,
  'ciphers': ['AES-256-GCM'],
  'ca_certificate_pem': 'ca-response-only',
  'certificate_pem': 'certificate-response-only',
  'not_after': '2027-01-01T12:00:00Z',
  'tls_crypt_v2_client_key': 'tls-crypt-response-only',
};

bool _isIsoControl(int unit) => unit <= 0x1f || (unit >= 0x7f && unit <= 0x9f);

bool _hasLoneSurrogate(String value) {
  for (var index = 0; index < value.length; index++) {
    final unit = value.codeUnitAt(index);
    if (unit >= 0xd800 && unit <= 0xdbff) {
      final next = index + 1 < value.length ? value.codeUnitAt(index + 1) : 0;
      if (next < 0xdc00 || next > 0xdfff) return true;
      index++;
    } else if (unit >= 0xdc00 && unit <= 0xdfff) {
      return true;
    }
  }
  return false;
}

void main() {
  group('C5-01 supported_ip_families is a capability hint', () {
    final cases = <String, (Object?, bool)>{
      'reverse order [ipv6, ipv4]': (['ipv6', 'ipv4'], true),
      'future family [ipv4, ipv6, ipv7]': (['ipv4', 'ipv6', 'ipv7'], true),
      'duplicates [ipv4, ipv6, ipv6]': (['ipv4', 'ipv6', 'ipv6'], true),
      'case [IPv4, IPv6]': (['IPv4', 'IPv6'], false),
      'empty list': (<String>[], false),
      'duplicate [ipv4, ipv4]': (['ipv4', 'ipv4'], false),
      'IPv6 only': (['ipv6'], false),
      'non-string item': (['ipv4', 6, null, 'ipv6'], true),
      'string instead of list': ('ipv4,ipv6', false),
      'object instead of list': ({'ipv6': true}, false),
      'witness [ipv4]': (['ipv4'], false),
      'witness [ipv4, ipv6]': (['ipv4', 'ipv6'], true),
    };
    for (final entry in cases.entries) {
      test('${entry.key} keeps the whole catalogue', () async {
        final (families, ipv6) = entry.value;
        final result = await _catalogue([
          _location('paris-01'),
          _location('paris-02', families: ['ipv4']),
          _location('paris-03', families: ['ipv4', 'ipv6']),
          _location('paris-04', families: families),
        ]);
        expect(result.map((location) => location.id), [
          'paris-01',
          'paris-02',
          'paris-03',
          'paris-04',
        ]);
        expect(result.map((location) => location.supportsIpv6), [
          false,
          false,
          true,
          ipv6,
        ]);
      });
    }

    test(
      'a device location with an unexpected family keeps the list',
      () async {
        final list = await _devices([
          {
            'device_id': 'device-123',
            'name': 'Android',
            'location': _location('paris-01', families: ['ipv6', 'ipv4']),
          },
          {
            'device_id': 'device-456',
            'name': 'Tablet',
            'location': _location('paris-02', families: ['ipv4', 'ipv7']),
          },
        ]);
        expect(list.devices.map((device) => device.deviceId), [
          'device-123',
          'device-456',
        ]);
        expect(list.devices.first.location!.supportsIpv6, isTrue);
        expect(list.devices.last.location!.supportsIpv6, isFalse);
      },
    );

    test('the model hint never throws for list contents', () {
      for (final value in [
        null,
        'ipv6',
        42,
        <Object?>[],
        <Object?>['ipv6', 'ipv4'],
        <Object?>['ipv4', 'ipv6', 'ipv4'],
      ]) {
        expect(
          () => VpnNetworkConfiguration.advertisedIpv6(value),
          returnsNormally,
        );
      }
    });

    // Review of 29/10: the hint now offers IPv6 for ['ipv6', 'ipv4'], so the
    // activation that answers it may use the same server order. Families,
    // addresses and routes are matched as sets; the bounds stay strict.
    final orders = <String, Map<String, Object?>>{
      'families, addresses and routes reversed': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'families reversed, addresses canonical': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['10.10.0.2/32', 'fd00::2/128'],
        'allowed_ips': ['0.0.0.0/0', '::/0'],
      },
      'families canonical, addresses reversed': {
        'ip_families': ['ipv4', 'ipv6'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['0.0.0.0/0', '::/0'],
      },
      'only routes reversed': {
        'ip_families': ['ipv4', 'ipv6'],
        'addresses': ['10.10.0.2/32', 'fd00::2/128'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'witness canonical order': {
        'ip_families': ['ipv4', 'ipv6'],
        'addresses': ['10.10.0.2/32', 'fd00::2/128'],
        'allowed_ips': ['0.0.0.0/0', '::/0'],
      },
    };
    for (final entry in orders.entries) {
      test('a dual-stack activation with ${entry.key} is accepted', () async {
        final transport = _Transport()
          ..reply(201, {..._wireGuard(), ...entry.value})
          ..reply(201, {
            ..._openVpn(),
            ...entry.value,
            'addresses': [
              for (final address in entry.value['addresses']! as List)
                address == '10.10.0.2/32' ? '10.20.0.2/32' : address,
            ],
          });
        final api = ApiClient(transport: transport);
        final wireGuard = await api.registerDevice(
          token: 'session-fixture',
          name: 'Android',
          publicKey: 'public-key',
          locationId: 'paris-01',
          requestIpv6: true,
        );
        final openVpn = await api.createOpenVpnProfile(
          token: 'session-fixture',
          deviceId: 'device-123',
          csrPem: 'csr-fixture',
          requestIpv6: true,
        );
        for (final (network, ipv4) in [
          (wireGuard.network, '10.10.0.2/32'),
          (openVpn.network, '10.20.0.2/32'),
        ]) {
          // The native layer always receives the canonical order.
          expect(network.dualStack, isTrue);
          expect(network.toWire(), {
            'ip_families': ['ipv4', 'ipv6'],
            'addresses': [ipv4, 'fd00::2/128'],
            'allowed_ips': ['0.0.0.0/0', '::/0'],
          });
        }
      });
    }

    test(
      'a reversed catalogue hint leads to an accepted reversed activation',
      () async {
        final requests = <ApiHttpRequest>[];
        final transport = _RecordingTransport(requests)
          ..reply(200, {
            'locations': [
              _location('paris-01', families: ['ipv6', 'ipv4']),
            ],
          })
          ..reply(201, {..._wireGuard(), ...orders.values.first})
          ..reply(201, {
            ..._openVpn(),
            ...orders.values.first,
            'addresses': ['fd00::2/128', '10.20.0.2/32'],
          });
        final api = ApiClient(transport: transport);
        final location = (await api.locations()).single;
        expect(location.supportsIpv6, isTrue);
        final wireGuard = await api.registerDevice(
          token: 'session-fixture',
          name: 'Android',
          publicKey: 'public-key',
          locationId: location.id,
          requestIpv6: location.supportsIpv6,
        );
        final openVpn = await api.createOpenVpnProfile(
          token: 'session-fixture',
          deviceId: wireGuard.deviceId,
          csrPem: 'csr-fixture',
          requestIpv6: location.supportsIpv6,
        );
        expect(wireGuard.network.dualStack, isTrue);
        expect(openVpn.network.dualStack, isTrue);
        for (final request in requests.skip(1)) {
          expect(
            (jsonDecode(request.body!) as Map<String, dynamic>)['ip_families'],
            ['ipv4', 'ipv6'],
          );
        }
      },
    );

    final outOfBounds = <String, Map<String, Object?>>{
      'IPv6 only': {
        'ip_families': ['ipv6'],
        'addresses': ['fd00::2/128'],
        'allowed_ips': ['::/0'],
      },
      'duplicate IPv6 family': {
        'ip_families': ['ipv6', 'ipv6'],
        'addresses': ['10.10.0.2/32', 'fd00::2/128'],
        'allowed_ips': ['0.0.0.0/0', '::/0'],
      },
      'duplicate IPv4 family': {
        'ip_families': ['ipv4', 'ipv4'],
        'addresses': ['10.10.0.2/32', 'fd00::2/128'],
        'allowed_ips': ['0.0.0.0/0', '::/0'],
      },
      'three families': {
        'ip_families': ['ipv6', 'ipv4', 'ipv6'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'unknown family': {
        'ip_families': ['ipv6', 'ipv7'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'family case': {
        'ip_families': ['IPv6', 'ipv4'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'two IPv4 addresses': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['10.10.0.2/32', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'two IPv6 addresses': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['fd00::2/128', 'fd00::3/128'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'reversed with a different IPv4': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['fd00::2/128', '10.10.0.3/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'reversed with a global IPv6': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['2001:db8::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
      'duplicate IPv6 route': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '::/0'],
      },
      'three routes': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0', '::/0'],
      },
      'missing IPv6 route': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': ['fd00::2/128', '10.10.0.2/32'],
        'allowed_ips': ['0.0.0.0/0'],
      },
      'non-string address': {
        'ip_families': ['ipv6', 'ipv4'],
        'addresses': [2, '10.10.0.2/32'],
        'allowed_ips': ['::/0', '0.0.0.0/0'],
      },
    };
    for (final entry in outOfBounds.entries) {
      test('an activation with ${entry.key} stays refused', () async {
        final transport = _Transport()
          ..reply(201, {..._wireGuard(), ...entry.value});
        await expectLater(
          ApiClient(transport: transport).registerDevice(
            token: 'session-fixture',
            name: 'Android',
            publicKey: 'public-key',
            locationId: 'paris-01',
            requestIpv6: true,
          ),
          throwsA(
            isA<ApiProtocolException>().having(
              (e) => e.statusCode,
              'status',
              201,
            ),
          ),
        );
      });
    }
  });

  group('C5-05 IPv4 forms are those accepted by the native layer', () {
    final refused = <String>[
      '+1.1.1.1',
      '1.1.1.+1',
      '-0.1.1.1',
      '1.1.1. 1',
      '1.1.1.1 ',
      ' 1.1.1.1',
      '1.1.1. 1',
      '1.1.1.1 ',
      ' 1.1.1.1',
      '1.1.1.\t1',
      '١.١.١.١',
      '1.1.1.01',
      '1.1.1.256',
      '1.1.1.1.',
      '1.1.1',
      '0x1.1.1.1',
      '1.1.1.1/32',
    ];
    for (final value in refused) {
      test('refuses ${jsonEncode(value)} in WireGuard and OpenVPN', () async {
        final transport = _Transport()
          ..reply(201, _wireGuard(dns: [value]))
          ..reply(201, _openVpn(dns: [value]))
          ..reply(201, _openVpn(endpoint: value));
        final api = ApiClient(transport: transport);
        await expectLater(
          api.registerDevice(
            token: 'session-fixture',
            name: 'Android',
            publicKey: 'public-key',
            locationId: 'paris-01',
          ),
          throwsA(
            isA<ApiProtocolException>().having(
              (e) => e.statusCode,
              'status',
              201,
            ),
          ),
        );
        for (var attempt = 0; attempt < 2; attempt++) {
          await expectLater(
            api.createOpenVpnProfile(
              token: 'session-fixture',
              deviceId: 'device-123',
              csrPem: 'csr-fixture',
            ),
            throwsA(
              isA<ApiProtocolException>().having(
                (e) => e.statusCode,
                'status',
                201,
              ),
            ),
          );
        }
      });
    }

    for (final value in [
      '1.1.1.1',
      '0.0.0.0',
      '255.255.255.255',
      '10.0.0.53',
    ]) {
      test('accepts canonical ${jsonEncode(value)}', () async {
        final transport = _Transport()
          ..reply(201, _wireGuard(dns: [value]))
          ..reply(201, _openVpn(dns: [value], endpoint: value));
        final api = ApiClient(transport: transport);
        expect(
          (await api.registerDevice(
            token: 'session-fixture',
            name: 'Android',
            publicKey: 'public-key',
            locationId: 'paris-01',
          )).dns,
          [value],
        );
        final activation = await api.createOpenVpnProfile(
          token: 'session-fixture',
          deviceId: 'device-123',
          csrPem: 'csr-fixture',
        );
        expect(activation.dns, [value]);
        expect(activation.endpoint, value);
      });
    }

    test('the tunnel address prefix is strict as well', () async {
      for (final address in [
        '10.20.0.2/+32',
        '10.20.0.2/ 32',
        '10.20.0.2/032',
      ]) {
        final transport = _Transport()
          ..reply(201, {..._openVpn(), 'address': address});
        await expectLater(
          ApiClient(transport: transport).createOpenVpnProfile(
            token: 'session-fixture',
            deviceId: 'device-123',
            csrPem: 'csr-fixture',
          ),
          throwsA(isA<ApiProtocolException>()),
        );
      }
    });
  });

  group('A05-models-01 location labels follow the native contract', () {
    final emoji = '\u{1F30D}'; // Two UTF-16 code units, as in Kotlin.
    final unsupported = <String, String>{
      '97 characters': 'P' * 97,
      '16 384 characters': 'P' * 16384,
      // Review round 2: past the former 16 384 reading limit, the row is
      // still the only one dropped.
      '16 385 characters': 'P' * 16385,
      '200 000 characters': 'P' * 200000,
      'tab': 'Paris\t02',
      'line feed': 'Paris\n03',
      'NEL U+0085': 'Paris\u008504',
      'DEL U+007F': 'Paris\u007f05',
      'C1 U+009F': 'Paris\u009f06',
      'NUL': 'Paris\u000007',
      '49 emoji (98 UTF-16 units)': emoji * 49,
    };
    for (final entry in unsupported.entries) {
      test('a catalogue row with ${entry.key} is not offered', () async {
        final result = await _catalogue([
          _location('paris-01'),
          _location('paris-02', displayName: entry.value),
          _location('paris-03'),
        ]);
        expect(result.map((location) => location.id), ['paris-01', 'paris-03']);
      });
    }

    final supported = <String, String>{
      '96 characters': 'P' * 96,
      '48 emoji (96 UTF-16 units)': emoji * 48,
      'no-break space U+00A0': 'Paris 1',
      'accents': 'São Paulo — Zürich',
    };
    for (final entry in supported.entries) {
      test('a catalogue row with ${entry.key} is kept unchanged', () async {
        final result = await _catalogue([
          _location('paris-01', displayName: entry.value),
        ]);
        expect(result.single.displayName, entry.value);
      });
    }

    test(
      'an unsupported row still takes part in duplicate detection',
      () async {
        for (final rows in [
          [_location('paris-01'), _location('paris-01', displayName: 'P' * 97)],
          [_location('paris-01', displayName: 'P' * 97), _location('paris-01')],
          [
            _location('paris-01'),
            _location('paris-01', displayName: 'P' * 16385),
          ],
          [
            _location('paris-01', displayName: 'P' * 16385),
            _location('paris-01'),
          ],
        ]) {
          await expectLater(
            _catalogue(rows),
            throwsA(
              isA<ApiProtocolException>().having(
                (e) => e.statusCode,
                'status',
                200,
              ),
            ),
          );
        }
      },
    );

    // Review of 29/10: a blank label, including one made only of characters
    // that trim() removes, is a label the native layer refuses like the
    // others, not a malformed response.
    final blank = <String, String>{
      'empty': '',
      'spaces': '   ',
      'tab only': '\t',
      'line feed only': '\n',
      'NEL only': '\u0085',
      'ideographic space only': '　',
      'no-break space only': ' ',
      'spaces around NEL': ' \u0085 ',
    };
    for (final entry in blank.entries) {
      test(
        'a catalogue row with a blank label (${entry.key}) is not offered',
        () async {
          final result = await _catalogue([
            _location('paris-01'),
            _location('paris-02', displayName: entry.value),
            _location('paris-03'),
          ]);
          expect(result.map((location) => location.id), [
            'paris-01',
            'paris-03',
          ]);
        },
      );

      test(
        'an existing device with a blank label (${entry.key}) is kept',
        () async {
          final list = await _devices([
            {
              'device_id': 'device-123',
              'name': 'Android',
              'location': _location('paris-02', displayName: entry.value),
            },
            {
              'device_id': 'device-456',
              'name': 'Tablet',
              'location': _location('paris-03'),
            },
          ]);
          expect(list.devices.map((device) => device.location!.id), [
            'paris-02',
            'paris-03',
          ]);
          expect(list.devices.first.location!.displayName, 'paris-02');
          expect(list.devices.last.location!.displayName, 'Paris paris-03');
        },
      );
    }

    test('a label that is not text remains an invalid response', () async {
      for (final row in [
        {..._location('paris-01'), 'display_name': 42},
        {..._location('paris-01'), 'display_name': null},
        {..._location('paris-01')}..remove('display_name'),
      ]) {
        await expectLater(
          _catalogue([_location('paris-02'), row]),
          throwsA(isA<ApiProtocolException>()),
        );
      }
    });

    test(
      'an existing device keeps a native-safe label for its location',
      () async {
        final list = await _devices([
          {
            'device_id': 'device-123',
            'name': 'Android',
            'location': _location(
              'paris-01',
              displayName: 'Paris\t${'x' * 200}',
            ),
          },
          {
            'device_id': 'device-456',
            'name': 'Tablet',
            'location': _location('paris-02', displayName: '\u0001\u0002'),
          },
          {
            'device_id': 'device-789',
            'name': 'Phone',
            'location': _location('paris-03', displayName: emoji * 60),
          },
        ]);
        expect(list.devices, hasLength(3));
        expect(list.devices.map((device) => device.location!.id), [
          'paris-01',
          'paris-02',
          'paris-03',
        ]);
        for (final device in list.devices) {
          final label = device.location!.displayName;
          expect(label.trim(), isNotEmpty);
          expect(label.length, lessThanOrEqualTo(96));
          expect(label.codeUnits.where(_isIsoControl), isEmpty);
          expect(_hasLoneSurrogate(label), isFalse, reason: jsonEncode(label));
        }
        expect(list.devices.first.location!.displayName, startsWith('Paris x'));
        expect(list.devices[1].location!.displayName, 'paris-02');
      },
    );

    test(
      'an existing device keeps its location past 16 384 label units',
      () async {
        for (final length in [16384, 16385, 200000]) {
          final list = await _devices([
            {
              'device_id': 'device-123',
              'name': 'Android',
              'location': _location('paris-01', displayName: 'P' * length),
            },
            {
              'device_id': 'device-456',
              'name': 'Tablet',
              'location': _location('paris-02'),
            },
          ]);
          expect(list.devices.map((device) => device.location!.id), [
            'paris-01',
            'paris-02',
          ]);
          final label = list.devices.first.location!.displayName;
          expect(label, '${'P' * 95}…', reason: '$length');
          expect(label.length, 96);
          expect(list.devices.last.location!.displayName, 'Paris paris-02');
        }
      },
    );

    test('labels at the native bound are accepted, one more is not', () async {
      // AndroidVpnBridge.requiredDisplayName: length <= 96 UTF-16 units and
      // no Char.isISOControl (U+0000-U+001F, U+007F-U+009F).
      final result = await _catalogue([
        _location('paris-01', displayName: 'Q' * 96),
        _location('paris-02', displayName: 'Q' * 97),
        _location('paris-03', displayName: 'Paris ​­'),
      ]);
      expect(result.map((location) => location.id), ['paris-01', 'paris-03']);
    });
  });

  group('A05-models-02 the model never invents a French device name', () {
    final cases = <String, (Object?, bool, String)>{
      'absent name': (null, false, ''),
      'null name': (null, true, ''),
      'empty name': ('', true, ''),
      'blank name': ('   ', true, ''),
      'witness name': ('Téléphone Android', true, 'Téléphone Android'),
    };
    for (final entry in cases.entries) {
      test(entry.key, () async {
        final (name, present, expected) = entry.value;
        final list = await _devices([
          {
            'device_id': 'device-123',
            if (present) 'name': name,
            'location': _location('paris-01'),
          },
        ]);
        expect(list.devices.single.name, expected);
        expect(list.devices.single.name, isNot(contains('Appareil')));
      });
    }

    test('a non-string name remains an invalid response', () async {
      await expectLater(
        _devices([
          {'device_id': 'device-123', 'name': 42},
        ]),
        throwsA(isA<ApiProtocolException>()),
      );
    });
  });
}
