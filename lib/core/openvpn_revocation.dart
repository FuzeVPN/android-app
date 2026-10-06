/// Non-secret, account/device-scoped native cleanup result.
class OpenVpnRevocationResult {
  const OpenVpnRevocationResult({
    required this.accountId,
    required this.deviceId,
    required this.csrSha256,
    this.tunnelStopped = false,
    this.identityCleared = false,
    this.tileCleared = false,
    this.markerCleared = false,
    this.inProgress = false,
    this.stale = false,
    this.stopError,
    this.storageError,
  });

  final String accountId;
  final String deviceId;
  final String csrSha256;
  final bool tunnelStopped;
  final bool identityCleared;
  final bool tileCleared;
  final bool markerCleared;
  final bool inProgress;
  final bool stale;
  final String? stopError;
  final String? storageError;
  bool get isComplete =>
      tunnelStopped &&
      identityCleared &&
      tileCleared &&
      markerCleared &&
      !inProgress &&
      !stale;

  OpenVpnRevocationResult waiting() => OpenVpnRevocationResult(
    accountId: accountId,
    deviceId: deviceId,
    csrSha256: csrSha256,
    tunnelStopped: tunnelStopped,
    identityCleared: identityCleared,
    tileCleared: tileCleared,
    markerCleared: markerCleared,
    inProgress: true,
  );

  factory OpenVpnRevocationResult.fromWire(Object? value) {
    if (value is! Map) {
      throw const FormatException('Invalid OpenVPN cleanup result');
    }
    String identifier(String key) {
      final raw = value[key];
      if (raw is! String || !RegExp(r'^[A-Za-z0-9._-]{1,160}$').hasMatch(raw)) {
        throw const FormatException('Invalid OpenVPN cleanup identity');
      }
      return raw;
    }

    final digest = value['csr_sha256'];
    if (digest is! String || !RegExp(r'^[a-f0-9]{64}$').hasMatch(digest)) {
      throw const FormatException('Invalid CSR fingerprint');
    }
    String? code(String key) {
      final raw = value[key];
      return raw is String && RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(raw)
          ? raw
          : null;
    }

    return OpenVpnRevocationResult(
      accountId: identifier('account_id'),
      deviceId: identifier('device_id'),
      csrSha256: digest,
      tunnelStopped: value['tunnel_stopped'] == true,
      identityCleared: value['identity_cleared'] == true,
      tileCleared: value['tile_cleared'] == true,
      markerCleared: value['marker_cleared'] == true,
      inProgress: value['in_progress'] == true,
      stale: value['stale'] == true,
      stopError: code('stop_error'),
      storageError: code('storage_error'),
    );
  }
}
