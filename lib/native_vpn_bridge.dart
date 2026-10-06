import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'core/connection_timing.dart';
import 'core/favorite_locations.dart';
import 'core/guest_accounts.dart';
import 'core/models.dart';
import 'core/repositories.dart';

class NativeVpnException implements Exception {
  const NativeVpnException(this.code);

  final String code;

  @override
  String toString() => 'NativeVpnException($code)';
}

/// Typed Android storage boundary. Flutter can request only these business
/// operations; arbitrary native storage keys never cross the method channel.
abstract interface class NativeStorageGateway {
  Future<String?> readStoredSessionPayload();
  Future<void> writePendingSessionPayload(String payload);
  Future<void> writeAccountSessionPayload({
    required String accountId,
    required String payload,
  });
  Future<SessionTerminationResult> clearStoredSession({bool expired = false});

  Future<String?> readStoredCurrentDeviceId({required String accountId});
  Future<void> writeStoredCurrentDeviceId({
    required String accountId,
    required String deviceId,
  });
  Future<void> clearStoredCurrentDeviceId({required String accountId});

  Future<String?> readStoredLocationMigration({
    required String accountId,
    required String deviceId,
  });
  Future<void> writeStoredLocationMigration({
    required String accountId,
    required String deviceId,
    required String payload,
  });
  Future<void> clearStoredLocationMigration({
    required String accountId,
    required String deviceId,
  });

  Future<String?> readStoredThemeMode();
  Future<void> writeStoredThemeMode(String value);
  Future<String?> readStoredLocale();
  Future<void> writeStoredLocale(String? value);
  Future<String?> readStoredProtocol();
  Future<void> writeStoredProtocol(String value);
  Future<String?> readStoredLocation();
  Future<void> writeStoredLocation(String value);
  Future<bool?> readStoredVerificationNeeded({required String accountId});
  Future<void> writeStoredVerificationNeeded({
    required String accountId,
    required bool value,
  });
}

/// Optional guest operations stay separate so existing platform adapters and
/// account-only test doubles cannot silently opt in to credential recovery.
abstract interface class NativeGuestStorageGateway {
  Future<String?> readStoredGuestCredential();
  Future<void> writeStoredGuestCredential(String credential);
  Future<String?> readStoredPendingGuestCredential();
  Future<void> writeStoredPendingGuestCredential(String credential);
  Future<void> clearStoredGuestCredentials();
  Future<bool> readStoredGuestAutoResume();
  Future<void> writeStoredGuestAutoResume(bool enabled);
  Future<void> replaceStoredGuestSession({
    required String accountId,
    required String payload,
  });
}

/// Non-sensitive settings still use the native encrypted store, but are
/// exposed as typed preferences instead of caller-selected key strings.
abstract interface class AppPreferenceStore {
  Future<String?> readThemeMode();
  Future<void> writeThemeMode(String value);
  Future<String?> readLocale();
  Future<void> writeLocale(String? languageCode);
  Future<String?> readSelectedProtocol();
  Future<void> writeSelectedProtocol(String value);
  Future<String?> readSelectedLocation();
  Future<void> writeSelectedLocation(String value);
  Future<bool?> readVerificationNeeded({required String userId});
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  });
}

/// Optional platform extension, kept separate from business storage and VPN
/// interfaces so unsupported platforms cannot silently opt in.
abstract interface class DiagnosticPreferenceStore {
  Future<bool> readAutomaticDiagnostics();
  Future<void> writeAutomaticDiagnostics(bool enabled);
}

abstract interface class FavoriteLocationStore {
  Future<Set<String>> readFavoriteLocations();
  Future<void> writeFavoriteLocations(Set<String> locationIds);
}

abstract interface class DiagnosticPlatformGateway {
  Future<Map<String, Object?>> diagnosticMetadata();

  /// Reads previously observed native state without polling or repairing a tunnel.
  Future<VpnRuntimeState> diagnosticSnapshot();

  /// True after writing the selected document, false if the user cancelled.
  Future<bool> exportDiagnosticReport(String json);
}

class NativeVpnBridge
    implements
        VpnTunnelGateway,
        VpnSystemProtectionGateway,
        VpnNotificationLocaleGateway,
        NativeStorageGateway,
        NativeGuestStorageGateway,
        FavoriteLocationStore,
        DiagnosticPreferenceStore,
        DiagnosticPlatformGateway {
  NativeVpnBridge({MethodChannel? channel, EventChannel? events})
    : _channel = channel ?? const MethodChannel(_channelName),
      _events = events ?? const EventChannel(_eventsName);

  static const String _channelName = 'com.fuzevpn/android_vpn';

  @override
  Future<Set<String>> readFavoriteLocations() async {
    final value = await _invoke<Object?>('storageReadFavoriteLocations');
    if (value == null) return const <String>{};
    try {
      return FavoriteLocations.checked(value);
    } on FormatException {
      throw const NativeVpnException('secure_storage_corrupt');
    }
  }

  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) =>
      _invoke<void>('storageWriteFavoriteLocations', <String, Object>{
        'value': FavoriteLocations.checked(locationIds).toList()..sort(),
      });
  static const String _eventsName = 'com.fuzevpn/android_vpn/events';

  final MethodChannel _channel;
  final EventChannel _events;

  late final Stream<VpnRuntimeState> _states = _events
      .receiveBroadcastStream()
      .map((Object? value) {
        final Map<Object?, Object?> map = value is Map
            ? value.cast<Object?, Object?>()
            : const <Object?, Object?>{};
        return VpnRuntimeState.fromWire(map);
      })
      .transform(
        StreamTransformer<VpnRuntimeState, VpnRuntimeState>.fromHandlers(
          handleError:
              (Object _, StackTrace _, EventSink<VpnRuntimeState> sink) {
                sink.add(
                  const VpnRuntimeState(
                    phase: VpnRuntimePhase.error,
                    messageCode: 'native_bridge_unavailable',
                  ),
                );
              },
        ),
      )
      .asBroadcastStream();

  @override
  Stream<VpnRuntimeState> get states => _states;

  @override
  Future<VpnRuntimeState> getState() async {
    final Object? value = await _invoke<Object?>('getState');
    final Map<Object?, Object?> map = value is Map
        ? value.cast<Object?, Object?>()
        : const <Object?, Object?>{};
    return VpnRuntimeState.fromWire(map);
  }

  @override
  Future<SystemVpnProtection> getSystemVpnProtection() async {
    final Object? value = await _invoke<Object?>('getSystemVpnProtection');
    final Map<Object?, Object?> map = value is Map
        ? value.cast<Object?, Object?>()
        : const <Object?, Object?>{};
    return SystemVpnProtection.fromWire(map);
  }

  @override
  Future<void> openVpnSettings() => _invoke<void>('openVpnSettings');

  @override
  Future<Map<String, Object?>> diagnosticMetadata() async {
    final value = await _invoke<Object?>('getDiagnosticMetadata');
    if (value is! Map || value.keys.any((key) => key is! String)) {
      throw const NativeVpnException('diagnostic_metadata_unavailable');
    }
    return Map<String, Object?>.from(value);
  }

  @override
  Future<VpnRuntimeState> diagnosticSnapshot() async {
    final value = await _invoke<Object?>('getDiagnosticSnapshot');
    if (value is! Map || value['status'] is! String) {
      throw const NativeVpnException('diagnostic_snapshot_unavailable');
    }
    return VpnRuntimeState.fromWire(value.cast<Object?, Object?>());
  }

  @override
  Future<bool> exportDiagnosticReport(String json) async {
    final value = await _invoke<Object?>(
      'exportDiagnosticReport',
      <String, Object>{'json': json},
    );
    if (value is! bool) {
      throw const NativeVpnException('diagnostic_export_failed');
    }
    return value;
  }

  @override
  Future<bool> readAutomaticDiagnostics() async {
    final value = await _invoke<Object?>('storageReadAutomaticDiagnostics');
    // Only an explicit native Boolean true is consent.
    if (value == null) return false;
    if (value is! bool) {
      throw const NativeVpnException('secure_storage_corrupt');
    }
    return value;
  }

  @override
  Future<void> writeAutomaticDiagnostics(bool enabled) => _invoke<void>(
    'storageWriteAutomaticDiagnostics',
    <String, Object>{'value': enabled},
  );

  @override
  Future<void> disconnectByUser() => _invoke<void>('disconnectByUser');

  @override
  Future<void> prepareTunnelRequest({required String accountId}) =>
      _invoke<void>('prepareTunnelRequest', {'account_id': accountId});

  @override
  Future<bool> requestVpnPermission() async =>
      await _invoke<bool>('requestVpnPermission') ?? false;

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async {
    final value = await _invoke<String>('getOrCreateWireGuardPublicKey', {
      'account_id': accountId,
    });
    if (value == null || value.isEmpty) {
      throw const NativeVpnException('key_generation_failed');
    }
    return value;
  }

  @override
  Future<String> getOrCreateOpenVpnCsr({
    required String accountId,
    required String deviceId,
    bool renewal = false,
  }) async {
    final value = await _invoke<String>('getOrCreateOpenVpnCsr', {
      'account_id': accountId,
      'device_id': deviceId,
      'renewal': renewal,
    });
    if (value == null || value.isEmpty) {
      throw const NativeVpnException('csr_generation_failed');
    }
    return value;
  }

  @override
  Future<OpenVpnCertificateStatus> getOpenVpnCertificateStatus({
    required String accountId,
    required String deviceId,
  }) async {
    final Object? value = await _invoke<Object?>(
      'getOpenVpnCertificateStatus',
      {'account_id': accountId, 'device_id': deviceId},
    );
    final Map<Object?, Object?> map = value is Map
        ? value.cast<Object?, Object?>()
        : const <Object?, Object?>{};
    final String phaseValue = map['status'] as String? ?? 'missing';
    final OpenVpnCertificatePhase phase = switch (phaseValue) {
      'valid' => OpenVpnCertificatePhase.valid,
      'expiring' => OpenVpnCertificatePhase.expiring,
      'expired' => OpenVpnCertificatePhase.expired,
      _ => OpenVpnCertificatePhase.missing,
    };
    final String? notAfterValue = map['not_after'] as String?;
    return OpenVpnCertificateStatus(
      phase: phase,
      notAfter: notAfterValue == null
          ? null
          : DateTime.tryParse(notAfterValue)?.toUtc(),
      renewalPending: map['renewal_pending'] == true,
    );
  }

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) => _invoke<void>('connectWireGuard', {
    'account_id': accountId,
    'device_id': configuration.deviceId,
    'address': configuration.address,
    'dns': configuration.dns,
    'server_public_key': configuration.serverPublicKey,
    'endpoint': configuration.endpoint,
    'allowed_ips': configuration.allowedIps,
    ...configuration.network.toWire(),
    'location_id': location.id,
    'location_name': location.displayName,
  });

  @override
  Future<void> connectOpenVpn({
    required String accountId,
    required OpenVpnActivation activation,
    required Location location,
    bool preserveExistingCertificate = false,
    bool renewal = false,
  }) => _invoke<void>('connectOpenVpn', {
    'account_id': accountId,
    'device_id': activation.deviceId,
    'certificate_pem': activation.certificatePem,
    'ca_certificate_pem': activation.caCertificatePem,
    'tls_crypt_v2_client_key': activation.tlsCryptV2ClientKey,
    'endpoint': activation.endpoint,
    'dns': activation.dns,
    'address': activation.address,
    ...activation.network.toWire(),
    'server_name': activation.serverName,
    'remote_cert_tls_server': activation.remoteCertTlsServer,
    'ciphers': activation.ciphers,
    'not_after': activation.notAfter.toUtc().toIso8601String(),
    'preserve_existing_certificate': preserveExistingCertificate,
    'renewal': renewal,
    'location_id': location.id,
    'location_name': location.displayName,
  });

  @override
  Future<void> disconnect() => _invoke<void>('disconnect');

  @override
  Future<void> clearOpenVpnIdentity({
    required String accountId,
    required String deviceId,
  }) => _invoke<void>('clearOpenVpnIdentity', <String, Object>{
    'account_id': accountId,
    'device_id': deviceId,
  });

  @override
  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  }) async {
    final value = await _invoke<Object?>('getOpenVpnRevocation', {
      'account_id': accountId,
      'device_id': deviceId,
    });
    return value == null ? null : OpenVpnRevocationResult.fromWire(value);
  }

  @override
  Future<OpenVpnRevocationResult> cleanRevokedOpenVpnIdentity({
    required String accountId,
    required String deviceId,
    required String csrSha256,
  }) async => OpenVpnRevocationResult.fromWire(
    await _invoke<Object?>('cleanRevokedOpenVpnIdentity', {
      'account_id': accountId,
      'device_id': deviceId,
      'csr_sha256': csrSha256,
    }),
  );

  @override
  Future<void> clearAccountIdentity({
    required String accountId,
    required String? expectedDeviceId,
  }) => _invoke<void>('clearAccountIdentity', {
    'account_id': accountId,
    'expected_device_id': expectedDeviceId,
  });

  @override
  Future<void> setNotificationLocale(String? languageCode) => _invoke<void>(
    'setNotificationLocale',
    languageCode == null
        ? const <String, Object?>{}
        : <String, Object?>{'language_code': languageCode},
  );

  @override
  Future<String?> readStoredSessionPayload() =>
      _invoke<String>('storageReadSession');

  @override
  Future<void> writePendingSessionPayload(String payload) => _invoke<void>(
    'storageWritePendingSession',
    <String, Object>{'payload': payload},
  );

  @override
  Future<void> writeAccountSessionPayload({
    required String accountId,
    required String payload,
  }) => _invoke<void>('storageWriteAccountSession', <String, Object>{
    'account_id': accountId,
    'payload': payload,
  });

  @override
  Future<String?> readStoredGuestCredential() async =>
      _readGuestCredential('storageReadGuestCredential');

  @override
  Future<void> writeStoredGuestCredential(String credential) =>
      _writeGuestCredential('storageWriteGuestCredential', credential);

  @override
  Future<String?> readStoredPendingGuestCredential() async =>
      _readGuestCredential('storageReadPendingGuestCredential');

  @override
  Future<void> writeStoredPendingGuestCredential(String credential) =>
      _writeGuestCredential('storageWritePendingGuestCredential', credential);

  Future<String?> _readGuestCredential(String method) async {
    final value = await _invokeGuest<Object?>(method);
    if (value == null) return null;
    if (value is! String || !_validGuestCredential(value)) {
      throw const NativeVpnException('secure_storage_corrupt');
    }
    return value;
  }

  Future<void> _writeGuestCredential(String method, String credential) async {
    if (!_validGuestCredential(credential)) {
      throw const NativeVpnException('invalid_guest_credential');
    }
    await _invokeGuest<void>(method, <String, Object>{
      'credential': credential,
    });
  }

  @override
  Future<void> clearStoredGuestCredentials() =>
      _invokeGuest<void>('storageClearGuestCredentials');

  @override
  Future<bool> readStoredGuestAutoResume() async {
    final value = await _invokeGuest<Object?>('storageReadGuestAutoResume');
    if (value == null) return false;
    if (value is! bool) {
      throw const NativeVpnException('secure_storage_corrupt');
    }
    return value;
  }

  @override
  Future<void> writeStoredGuestAutoResume(bool enabled) => _invokeGuest<void>(
    'storageWriteGuestAutoResume',
    <String, Object>{'enabled': enabled},
  );

  @override
  Future<void> replaceStoredGuestSession({
    required String accountId,
    required String payload,
  }) => _invokeGuest<void>('storageReplaceGuestSession', <String, Object>{
    'account_id': accountId,
    'payload': payload,
  });

  @override
  Future<SessionTerminationResult> clearStoredSession({
    bool expired = false,
  }) async => SessionTerminationResult.fromWire(
    await _invoke<Object?>('storageClearSession', {'session_expired': expired}),
  );

  @override
  Future<String?> readStoredCurrentDeviceId({required String accountId}) =>
      _invoke<String>('storageReadCurrentDevice', <String, Object>{
        'account_id': accountId,
      });

  @override
  Future<void> writeStoredCurrentDeviceId({
    required String accountId,
    required String deviceId,
  }) => _invoke<void>('storageWriteCurrentDevice', <String, Object>{
    'account_id': accountId,
    'device_id': deviceId,
  });

  @override
  Future<void> clearStoredCurrentDeviceId({required String accountId}) =>
      _invoke<void>('storageClearCurrentDevice', <String, Object>{
        'account_id': accountId,
      });

  @override
  Future<String?> readStoredLocationMigration({
    required String accountId,
    required String deviceId,
  }) => _invoke<String>('storageReadLocationMigration', <String, Object>{
    'account_id': accountId,
    'device_id': deviceId,
  });

  @override
  Future<void> writeStoredLocationMigration({
    required String accountId,
    required String deviceId,
    required String payload,
  }) => _invoke<void>('storageWriteLocationMigration', <String, Object>{
    'account_id': accountId,
    'device_id': deviceId,
    'payload': payload,
  });

  @override
  Future<void> clearStoredLocationMigration({
    required String accountId,
    required String deviceId,
  }) => _invoke<void>('storageClearLocationMigration', <String, Object>{
    'account_id': accountId,
    'device_id': deviceId,
  });

  @override
  Future<String?> readStoredThemeMode() =>
      _invoke<String>('storageReadThemeMode');

  @override
  Future<void> writeStoredThemeMode(String value) =>
      _invoke<void>('storageWriteThemeMode', <String, Object>{'value': value});

  @override
  Future<String?> readStoredLocale() => _invoke<String>('storageReadLocale');

  @override
  Future<void> writeStoredLocale(String? value) => _invoke<void>(
    'storageWriteLocale',
    value == null
        ? const <String, Object?>{}
        : <String, Object?>{'value': value},
  );

  @override
  Future<String?> readStoredProtocol() =>
      _invoke<String>('storageReadProtocol');

  @override
  Future<void> writeStoredProtocol(String value) =>
      _invoke<void>('storageWriteProtocol', <String, Object>{'value': value});

  @override
  Future<String?> readStoredLocation() =>
      _invoke<String>('storageReadLocation');

  @override
  Future<void> writeStoredLocation(String value) =>
      _invoke<void>('storageWriteLocation', <String, Object>{'value': value});

  @override
  Future<bool?> readStoredVerificationNeeded({required String accountId}) =>
      _invoke<bool>('storageReadVerificationNeeded', <String, Object>{
        'account_id': accountId,
      });

  @override
  Future<void> writeStoredVerificationNeeded({
    required String accountId,
    required bool value,
  }) => _invoke<void>('storageWriteVerificationNeeded', <String, Object>{
    'account_id': accountId,
    'value': value,
  });

  Future<T?> _invoke<T>(String method, [Object? arguments]) =>
      ConnectionTiming.measure(_timingRpcStage(method), () async {
        Object? tracedArguments = arguments;
        final traceId = ConnectionTiming.currentId;
        if (traceId != null && (arguments == null || arguments is Map)) {
          tracedArguments = <Object?, Object?>{
            if (arguments is Map) ...arguments,
            'diagnostic_trace_id': traceId,
            'diagnostic_span_id': ConnectionTiming.currentSpanId,
          };
        }
        try {
          return await _channel.invokeMethod<T>(method, tracedArguments);
        } on PlatformException catch (error) {
          throw NativeVpnException(_stablePlatformCode(error.code));
        } on MissingPluginException {
          throw const NativeVpnException('native_bridge_unavailable');
        }
      });

  Future<T?> _invokeGuest<T>(String method, [Object? arguments]) async {
    try {
      return await _invoke<T>(method, arguments);
    } on NativeVpnException catch (error) {
      // Even a syntactically valid, lowercase Base64URL credential must never
      // become a displayed platform error code if a plugin response is faulty.
      const allowed = <String>{
        'native_operation_failed',
        'native_bridge_unavailable',
        'invalid_arguments',
        'invalid_account_id',
        'invalid_guest_credential',
        'secure_storage_corrupt',
        'secure_storage_read_failed',
        'secure_storage_write_failed',
        'session_operation_cancelled',
        'session_ending',
        'system_vpn_resume_session_invalid',
        'system_vpn_resume_corrupt',
        'system_vpn_resume_storage_failed',
      };
      throw NativeVpnException(
        allowed.contains(error.code) ? error.code : 'native_operation_failed',
      );
    }
  }

  // This allowlist prevents a future dynamic RPC name becoming a log payload.
  String _timingRpcStage(String method) => switch (method) {
    'getState' ||
    'getSystemVpnProtection' ||
    'getDiagnosticMetadata' ||
    'getDiagnosticSnapshot' ||
    'exportDiagnosticReport' ||
    'openVpnSettings' ||
    'disconnectByUser' ||
    'prepareTunnelRequest' ||
    'requestVpnPermission' ||
    'getOrCreateWireGuardPublicKey' ||
    'getOrCreateOpenVpnCsr' ||
    'getOpenVpnCertificateStatus' ||
    'connectWireGuard' ||
    'connectOpenVpn' ||
    'disconnect' ||
    'clearOpenVpnIdentity' ||
    'getOpenVpnRevocation' ||
    'cleanRevokedOpenVpnIdentity' ||
    'clearAccountIdentity' ||
    'setNotificationLocale' ||
    'storageReadSession' ||
    'storageWritePendingSession' ||
    'storageWriteAccountSession' ||
    'storageReadGuestCredential' ||
    'storageWriteGuestCredential' ||
    'storageReadPendingGuestCredential' ||
    'storageWritePendingGuestCredential' ||
    'storageClearGuestCredentials' ||
    'storageReadGuestAutoResume' ||
    'storageWriteGuestAutoResume' ||
    'storageReplaceGuestSession' ||
    'storageClearSession' ||
    'storageReadCurrentDevice' ||
    'storageWriteCurrentDevice' ||
    'storageClearCurrentDevice' ||
    'storageReadLocationMigration' ||
    'storageWriteLocationMigration' ||
    'storageClearLocationMigration' ||
    'storageReadThemeMode' ||
    'storageWriteThemeMode' ||
    'storageReadLocale' ||
    'storageWriteLocale' ||
    'storageReadProtocol' ||
    'storageWriteProtocol' ||
    'storageReadLocation' ||
    'storageWriteLocation' ||
    'storageReadAutomaticDiagnostics' ||
    'storageWriteAutomaticDiagnostics' ||
    'storageReadVerificationNeeded' ||
    'storageWriteVerificationNeeded' => 'rpc.$method',
    _ => 'rpc.other',
  };

  String _stablePlatformCode(String value) =>
      RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(value)
      ? value
      : 'native_operation_failed';
}

/// An account-independent adapter around the same Keystore-backed encrypted
/// native store. Session JSON is only a compact envelope for the token and
/// expiry; it is never written into Flutter preferences or logs.
class NativeSecureStore
    implements
        SecureSessionStore,
        GuestCredentialStore,
        GuestSessionRenewalStore,
        AppPreferenceStore,
        FavoriteLocationStore,
        DiagnosticPreferenceStore {
  NativeSecureStore(this._store);

  final NativeStorageGateway _store;

  NativeGuestStorageGateway get _guestStore {
    final store = _store;
    if (store is! NativeGuestStorageGateway) {
      throw const NativeVpnException('native_bridge_unavailable');
    }
    return store as NativeGuestStorageGateway;
  }

  @override
  Future<String?> readGuestCredential() async =>
      _guestStore.readStoredGuestCredential();

  @override
  Future<void> writeGuestCredential(String credential) async {
    if (!_validGuestCredential(credential)) {
      throw const NativeVpnException('invalid_guest_credential');
    }
    await _guestStore.writeStoredGuestCredential(credential);
  }

  @override
  Future<String?> readPendingGuestCredential() async =>
      _guestStore.readStoredPendingGuestCredential();

  @override
  Future<void> writePendingGuestCredential(String credential) async {
    if (!_validGuestCredential(credential)) {
      throw const NativeVpnException('invalid_guest_credential');
    }
    await _guestStore.writeStoredPendingGuestCredential(credential);
  }

  @override
  Future<void> clearGuestCredentials() async =>
      _guestStore.clearStoredGuestCredentials();

  @override
  Future<bool> readGuestAutoResume() async {
    final store = _store;
    if (store is! NativeGuestStorageGateway) return false;
    return (store as NativeGuestStorageGateway).readStoredGuestAutoResume();
  }

  @override
  Future<void> writeGuestAutoResume(bool enabled) async =>
      _guestStore.writeStoredGuestAutoResume(enabled);

  @override
  Future<void> replaceGuestSession(
    AuthSession session, {
    required String userId,
  }) async => _guestStore.replaceStoredGuestSession(
    accountId: userId,
    payload: jsonEncode(<String, String>{
      'access_token': session.accessToken,
      'expires_at': session.expiresAt.toUtc().toIso8601String(),
    }),
  );

  @override
  Future<Set<String>> readFavoriteLocations() async {
    final store = _store;
    if (store is! FavoriteLocationStore) return const <String>{};
    return (store as FavoriteLocationStore).readFavoriteLocations();
  }

  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) async {
    final store = _store;
    if (store is! FavoriteLocationStore) {
      throw const NativeVpnException('native_bridge_unavailable');
    }
    await (store as FavoriteLocationStore).writeFavoriteLocations(locationIds);
  }

  @override
  Future<bool> readAutomaticDiagnostics() async {
    final store = _store;
    return store is DiagnosticPreferenceStore
        ? await (store as DiagnosticPreferenceStore).readAutomaticDiagnostics()
        : false;
  }

  @override
  Future<void> writeAutomaticDiagnostics(bool enabled) async {
    final store = _store;
    if (store is! DiagnosticPreferenceStore) {
      throw const NativeVpnException('native_bridge_unavailable');
    }
    await (store as DiagnosticPreferenceStore).writeAutomaticDiagnostics(
      enabled,
    );
  }

  @override
  Future<AuthSession?> readSession() async {
    final String? raw = await _store.readStoredSessionPayload();
    if (raw == null) return null;
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      return AuthSession.fromJson(decoded);
    } on FormatException {
      // Let the controller own the shared stop/erase transition and its UI.
      throw const NativeVpnException('secure_storage_corrupt');
    }
  }

  @override
  Future<void> writeSession(AuthSession session, {String? userId}) async {
    final String encoded = jsonEncode(<String, String>{
      'access_token': session.accessToken,
      'expires_at': session.expiresAt.toUtc().toIso8601String(),
    });
    if (userId == null) {
      await _store.writePendingSessionPayload(encoded);
      return;
    }
    await _store.writeAccountSessionPayload(
      accountId: userId,
      payload: encoded,
    );
  }

  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) =>
      _store.clearStoredSession(expired: expired);

  @override
  Future<String?> readCurrentDeviceId({required String userId}) =>
      _store.readStoredCurrentDeviceId(accountId: userId);

  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) =>
      _store.writeStoredCurrentDeviceId(accountId: userId, deviceId: deviceId);

  @override
  Future<void> clearCurrentDeviceId({required String userId}) =>
      _store.clearStoredCurrentDeviceId(accountId: userId);

  @override
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  }) async {
    try {
      final String? raw = await _store.readStoredLocationMigration(
        accountId: userId,
        deviceId: deviceId,
      );
      if (raw == null) return null;
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      return DeviceLocationMigration.fromJson(
        decoded,
        expectedDeviceId: deviceId,
      );
    } on FormatException {
      throw const CorruptLocationMigration();
    } on NativeVpnException catch (error) {
      if (error.code == 'secure_storage_corrupt') {
        throw const CorruptLocationMigration();
      }
      rethrow;
    }
  }

  @override
  Future<void> writeLocationMigration({
    required String userId,
    required DeviceLocationMigration migration,
  }) => _store.writeStoredLocationMigration(
    accountId: userId,
    deviceId: migration.deviceId,
    payload: jsonEncode(migration.toStorageJson()),
  );

  @override
  Future<void> clearLocationMigration({
    required String userId,
    required String deviceId,
  }) => _store.clearStoredLocationMigration(
    accountId: userId,
    deviceId: deviceId,
  );

  @override
  Future<String?> readThemeMode() => _store.readStoredThemeMode();

  @override
  Future<void> writeThemeMode(String value) =>
      _store.writeStoredThemeMode(value);

  @override
  Future<String?> readLocale() => _store.readStoredLocale();

  @override
  Future<void> writeLocale(String? languageCode) =>
      _store.writeStoredLocale(languageCode);

  @override
  Future<String?> readSelectedProtocol() => _store.readStoredProtocol();

  @override
  Future<void> writeSelectedProtocol(String value) =>
      _store.writeStoredProtocol(value);

  @override
  Future<String?> readSelectedLocation() => _store.readStoredLocation();

  @override
  Future<void> writeSelectedLocation(String value) =>
      _store.writeStoredLocation(value);

  @override
  Future<bool?> readVerificationNeeded({required String userId}) =>
      _store.readStoredVerificationNeeded(accountId: userId);

  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) => _store.writeStoredVerificationNeeded(accountId: userId, value: value);
}

bool _validGuestCredential(String value) {
  if (!RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(value)) return false;
  try {
    final bytes = base64Url.decode('$value=');
    return bytes.length == 32 &&
        base64Url.encode(bytes).replaceAll('=', '') == value;
  } on FormatException {
    return false;
  }
}
