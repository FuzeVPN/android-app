import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_client.dart';
import 'package:fuzevpn_android/core/connection_timing.dart';

class _RecordingTransport extends ApiHttpTransport {
  _RecordingTransport(this.response);

  final ApiHttpResponse response;
  ApiHttpRequest? request;

  @override
  Future<ApiHttpResponse> send(ApiHttpRequest value) async {
    request = value;
    return response;
  }
}

Map<String, dynamic> _record(String line) =>
    jsonDecode(line.substring('FuzeVpnTiming '.length)) as Map<String, dynamic>;

void main() {
  test(
    'chronomètre une inscription d appareil sans exposer la requête',
    () async {
      const String token = 'token-secret';
      const String publicKey = 'public-key-secret';
      const String location = 'location-secret';
      final _RecordingTransport transport = _RecordingTransport(
        ApiHttpResponse(
          statusCode: 201,
          headers: const <String, String>{'cache-control': 'no-store'},
          body: jsonEncode(<String, Object>{
            'device_id': 'returned-device-secret',
            'address': '10.0.0.2/32',
            'dns': <String>['1.1.1.1'],
            'server_public_key': 'server-key-secret',
            'endpoint': '198.51.100.1:51820',
            'allowed_ips': <String>['0.0.0.0/0'],
          }),
        ),
      );
      final ApiClient client = ApiClient(transport: transport);
      final List<String> lines = <String>[];

      final DeviceConfiguration configuration = await ConnectionTiming.run(
        'connection',
        () => client.registerDevice(
          token: token,
          name: 'Private device name',
          publicKey: publicKey,
          locationId: location,
        ),
        sink: lines.add,
      );

      expect(configuration.deviceId, 'returned-device-secret');
      expect(transport.request!.headers['authorization'], 'Bearer $token');
      expect(
        jsonDecode(transport.request!.body!),
        <String, dynamic>{
          'name': 'Private device name',
          'public_key': publicKey,
          'location_id': location,
        },
      );
      final List<Map<String, dynamic>> records = lines.map(_record).toList();
      expect(
        records.where((record) => record['stage'] == 'api.device.register'),
        isNotEmpty,
      );
      expect(
        records
            .where((record) => record['stage'] == 'api.device.register')
            .map((record) => record['event']),
        containsAll(<String>['begin', 'end', 'event']),
      );
      final String diagnosticOutput = lines.join('\n');
      for (final String sensitive in <String>[
        token,
        publicKey,
        location,
        'Private device name',
        'returned-device-secret',
        'server-key-secret',
      ]) {
        expect(diagnosticOutput, isNot(contains(sensitive)));
      }
    },
  );
}
