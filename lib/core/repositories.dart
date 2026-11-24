import 'excluded_apps.dart';
import 'models.dart';
import 'openvpn_revocation.dart';
import 'session_lifecycle.dart';

export 'openvpn_revocation.dart';
export 'session_lifecycle.dart';

/// Dependency boundary for controllers. `ApiClient` implements this interface;
/// tests and UI code can supply a deterministic repository without HTTP.
abstract interface class VpnApiRepository {
  Future<AuthSession> login({required String email, required String password});

  Future<RegistrationResult> register(RegisterAccountRequest request);

  Future<void> logout(String token);

  Future<void> resendVerification(String token);

  Future<void> requestPasswordReset(String email);

  Future<void> confirmPasswordReset({
    required String token,
    required String password,
  });

  Future<bool> verifyEmail(String token);

  Future<UserProfile> me(String token);

  Future<UserProfile> updateMe({
    required String token,
    required UpdateProfileRequest request,
  });

  Future<List<Location>> locations();

  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  });

  Future<DeviceList> listDevices(String token);

  /// Starts (or idempotently returns) the asynchronous move of one existing
  /// logical device. No device, WireGuard key, CSR or certificate is replaced.
  Future<DeviceLocationMigration> startLocationMigration({
    required String token,
    required String deviceId,
    required String locationId,
  });

  Future<DeviceLocationMigration> getLocationMigration({
    required String token,
    required String deviceId,
    required String migrationId,
  });

  Future<void> revokeDevice({required String token, required String deviceId});

  Future<DeviceProfiles> deviceProfiles({
    required String token,
    required String deviceId,
  });

  Future<OpenVpnActivation> createOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  });

  Future<OpenVpnActivation> renewOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  });

  /// Revokes only the OpenVPN profile. The logical device and its WireGuard
  /// identity remain valid so WireGuard can move directly afterwards.
  Future<void> revokeOpenVpnProfile({
    required String token,
    required String deviceId,
  });
}

/// Persists only session/UI metadata. Implementations must keep the token in a
/// Keystore-backed encrypted store, never Flutter shared preferences.
abstract interface class SecureSessionStore {
  Future<AuthSession?> readSession();

  /// A session starts temporarily unscoped immediately after login, before
  /// `/v1/me` has disclosed its account id. Callers provide [userId] as soon
  /// as it is known so the native store can move the token into that account's
  /// encrypted scope.
  Future<void> writeSession(AuthSession session, {String? userId});

  /// Invalidates pending native commands, stops the tunnel and clears tokens.
  Future<SessionTerminationResult> clearSession({bool expired = false});

  Future<String?> readCurrentDeviceId({required String userId});

  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  });

  Future<void> clearCurrentDeviceId({required String userId});

  /// Persists only opaque migration state, encrypted and scoped to its account
  /// and logical device. No profile or credential crosses this boundary.
  /// Reads never delete data; malformed records throw [CorruptLocationMigration].
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  });

  Future<void> writeLocationMigration({
    required String userId,
    required DeviceLocationMigration migration,
  });

  Future<void> clearLocationMigration({
    required String userId,
    required String deviceId,
  });
}

/// Tells an explicit registered admission still waiting for its first account
/// restoration (stored unscoped) from an account-bound session. Such a stored
/// session, even expired, is an explicit intent to leave any guest.
abstract interface class PendingAdmissionStore {
  Future<bool> readStoredSessionIsPendingAdmission();
}

/// Native storage that is told why a session ends. Each request joins the end
/// in progress; stores without it receive the legacy expired flag once.
abstract interface class SessionEndCauseStore {
  Future<SessionTerminationResult> clearSessionFor(SessionEndCause cause);
}

/// Native storage that owns renewable app sessions (session-renewal
/// contract). Only native code holds and presents the refresh token; Dart
/// only receives the stored access session. [userId] is the account the
/// stored session is bound to, or null while Dart does not know it yet (a
/// session read back before /v1/me): native code then uses the active
/// account's session.
abstract interface class SessionRenewalStore {
  /// Converts a personal session confirmed by /v1/me, or resumes a pending
  /// conversion. A server without the contract keeps it classic.
  Future<SessionRenewal> upgradeSession({required String userId});

  /// The current access, renewed first when it expires within five minutes,
  /// or whatever the device clock says when [force]d (after a 401: the
  /// server's dates prevail). A classic session is returned as it is.
  Future<SessionRenewal> ensureFreshSession({
    String? userId,
    bool force = false,
  });

  /// Called before the session is cleared. True: native code sends the
  /// refresh-token logout itself. False: a classic session, whose caller
  /// keeps the access-token logout.
  Future<bool> logoutSession({String? userId});
}

/// The stored access session, as native code returns it.
class SessionRenewal {
  const SessionRenewal({required this.renewable, required this.session});

  final bool renewable;
  final AuthSession session;

  @override
  String toString() => 'SessionRenewal(renewable: $renewable, redacted: true)';
}

enum SessionRenewalError {
  /// The server refused the session: it ends as an expiry.
  unauthorized,

  /// Temporary (network, 429, 5xx, a renewal in progress): the local session
  /// is kept and the same request is retried later.
  unavailable,

  /// A malformed renewal request: a client defect.
  invalid,

  /// The right to renew has lapsed: a new sign-in is required.
  refreshExpired,
}

class SessionRenewalFailure implements Exception {
  const SessionRenewalFailure(this.error, {this.retryAfterSeconds});

  final SessionRenewalError error;
  final int? retryAfterSeconds;

  @override
  String toString() => 'SessionRenewalFailure(${error.name})';
}

/// The caller owns cleanup after checking the account/device operation again.
class CorruptLocationMigration implements Exception {
  const CorruptLocationMigration();
}

/// The one Dart-facing tunnel boundary. Private keys, certificates and the
/// encrypted account binding are kept by the Android implementation.
abstract interface class VpnTunnelGateway {
  Stream<VpnRuntimeState> get states;

  Future<VpnRuntimeState> getState();

  /// Must only be called after a user initiated connection action.
  Future<bool> requestVpnPermission();

  /// Returns only the WireGuard public key. The private key never enters Dart.
  Future<String> getOrCreateWireGuardPublicKey({required String accountId});

  /// Returns a public P-256 CSR. The private key stays in Android Keystore.
  /// [replacePending] discards the renewal key already prepared for a new
  /// one: the API answered that the certificate its CSR obtained has expired
  /// (`openvpn_renewal_expired`), so that CSR can never renew.
  Future<String> getOrCreateOpenVpnCsr({
    required String accountId,
    required String deviceId,
    bool renewal = false,
    bool replacePending = false,
  });

  /// Gives native code the API's `Retry-After` of a refused OpenVPN profile
  /// creation or renewal (`429 rate_limited`): neither Flutter nor the native
  /// renewals send one for this device before it. Read back through
  /// [OpenVpnCertificateStatus.retryAfterSeconds].
  Future<void> deferOpenVpnProfileRequests({
    required String accountId,
    required String deviceId,
    required int retryAfterSeconds,
  });

  /// Reads only the locally authenticated certificate lifetime and renewal
  /// transaction state. No certificate, CSR, profile or private key is
  /// returned to Flutter.
  Future<OpenVpnCertificateStatus> getOpenVpnCertificateStatus({
    required String accountId,
    required String deviceId,
  });

  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  });

  /// The activation is imported once into native encrypted storage.
  Future<void> connectOpenVpn({
    required String accountId,
    required OpenVpnActivation activation,
    required Location location,
    bool preserveExistingCertificate = false,
    bool renewal = false,
  });

  Future<void> disconnect();

  /// Removes the revoked OpenVPN key, CSR and activation for one logical
  /// device without touching its WireGuard identity or account session.
  Future<void> clearOpenVpnIdentity({
    required String accountId,
    required String deviceId,
  });

  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  });

  Future<OpenVpnRevocationResult> cleanRevokedOpenVpnIdentity({
    required String accountId,
    required String deviceId,
    required String csrSha256,
  });

  /// Stops any tunnel and removes every account-scoped native identity only
  /// while the native current device still matches the captured target.
  /// Null explicitly means that no device has been enrolled yet.
  Future<void> clearAccountIdentity({
    required String accountId,
    required String? expectedDeviceId,
  });
}

/// Optional Android-only controls for the operating system's VPN lockdown
/// setting. Keeping this separate from [VpnTunnelGateway] lets tests and
/// non-Android implementations remain a normal tunnel boundary.
abstract interface class VpnSystemProtectionGateway {
  Future<SystemVpnProtection> getSystemVpnProtection();

  Future<void> openVpnSettings();

  /// A user-requested stop. Android rechecks its system-owned flags before it
  /// tears down the shared VPN host; internal handoffs must not call this.
  Future<void> disconnectByUser();

  /// Cancels a pending system resume before an explicit connection request.
  /// It never requests a normal tunnel stop.
  Future<void> prepareTunnelRequest({required String accountId});
}

enum SystemProtectionResumeState {
  unavailable,
  ready,
  waitingNetwork,
  restoring,
  blocked;

  static SystemProtectionResumeState fromWireValue(Object? value) =>
      switch (value) {
        'ready' => SystemProtectionResumeState.ready,
        'waiting_network' => SystemProtectionResumeState.waitingNetwork,
        'restoring' => SystemProtectionResumeState.restoring,
        'blocked' => SystemProtectionResumeState.blocked,
        _ => SystemProtectionResumeState.unavailable,
      };
}

/// State read from Android Settings. Null flags are deliberately *unknown*;
/// they must never be presented as a disabled system safeguard.
class SystemVpnProtection {
  const SystemVpnProtection({
    this.alwaysOn,
    this.lockdown,
    this.resumeState = SystemProtectionResumeState.unavailable,
    this.resumeError,
  });

  final bool? alwaysOn;
  final bool? lockdown;
  final SystemProtectionResumeState resumeState;
  final String? resumeError;

  bool get isActive => alwaysOn == true && lockdown == true;

  factory SystemVpnProtection.fromWire(Map<Object?, Object?> value) {
    final Object? rawError = value['resume_error'];
    return SystemVpnProtection(
      alwaysOn: value['always_on'] is bool ? value['always_on'] as bool : null,
      lockdown: value['lockdown'] is bool ? value['lockdown'] as bool : null,
      resumeState: SystemProtectionResumeState.fromWireValue(
        value['resume_state'],
      ),
      resumeError:
          rawError is String &&
              rawError.isNotEmpty &&
              rawError.length <= 96 &&
              RegExp(r'^[a-z0-9_]+$').hasMatch(rawError)
          ? rawError
          : null,
    );
  }
}

enum OpenVpnCertificatePhase { missing, valid, expiring, expired }

class OpenVpnCertificateStatus {
  const OpenVpnCertificateStatus({
    required this.phase,
    required this.renewalPending,
    this.notAfter,
    this.retryAfterSeconds,
  });

  final OpenVpnCertificatePhase phase;
  final DateTime? notAfter;
  final bool renewalPending;

  /// Seconds before the API accepts a creation or renewal for this device
  /// again, after its `429`; null when one may be sent now.
  final int? retryAfterSeconds;

  bool get requiresRenewal =>
      renewalPending ||
      phase == OpenVpnCertificatePhase.expiring ||
      phase == OpenVpnCertificatePhase.expired;
}

/// Optional native capability used only for non-sensitive notification copy.
/// A locale tag is never an account identifier, credential or VPN profile.
abstract interface class VpnNotificationLocaleGateway {
  Future<void> setNotificationLocale(String? languageCode);
}

enum VpnRuntimePhase {
  idle,
  authorizing,
  preparing,
  connecting,
  connected,
  disconnecting,
  error;

  static VpnRuntimePhase fromWireValue(String value) => switch (value) {
    'idle' => VpnRuntimePhase.idle,
    'authorizing' => VpnRuntimePhase.authorizing,
    'preparing' => VpnRuntimePhase.preparing,
    'connecting' => VpnRuntimePhase.connecting,
    'connected' => VpnRuntimePhase.connected,
    'disconnecting' => VpnRuntimePhase.disconnecting,
    _ => VpnRuntimePhase.error,
  };
}

/// Sanitized native state. `messageCode` is stable and never contains an
/// OpenVPN activation, public key, token, host, certificate or stack trace.
class VpnRuntimeState {
  const VpnRuntimeState({
    required this.phase,
    this.protocol,
    this.messageCode,
    this.connectedAt,
    this.locationId,
    this.locationName,
    this.receivedBytes,
    this.sentBytes,
    this.latestHandshake,
    this.sessionTermination,
    this.openVpnRevocation,
    this.ipFamilies = const <String>[],
    this.systemProtection = const SystemVpnProtection(),
    this.retryAt,
    this.excludedApps,
  });

  final VpnRuntimePhase phase;
  final VpnProtocol? protocol;
  final String? messageCode;
  final DateTime? connectedAt;
  final String? locationId;
  final String? locationName;
  final int? receivedBytes;
  final int? sentBytes;
  final DateTime? latestHandshake;
  final SessionTerminationResult? sessionTermination;
  final OpenVpnRevocationResult? openVpnRevocation;
  final List<String> ipFamilies;
  final SystemVpnProtection systemProtection;

  /// With `openvpn_renewal_rate_limited`: when the API accepts the renewal
  /// again (`retry_at`, device clock).
  final DateTime? retryAt;

  /// While connected: the apps excluded from the VPN (split tunneling) that
  /// were saved when this tunnel started (`excluded_apps`), as package names.
  /// Null when native code did not say.
  final List<String>? excludedApps;
  List<String> get connectedIpFamilies =>
      isConnected ? ipFamilies : const <String>[];

  bool get isConnected => phase == VpnRuntimePhase.connected;
  bool get isReconnecting =>
      phase == VpnRuntimePhase.connecting &&
      (messageCode == 'openvpn_reconnecting' ||
          messageCode == 'system_vpn_restoring' ||
          isWireGuardRecovery);
  bool get isWaitingForNetwork =>
      isWireGuardRecovery && messageCode == 'wireguard_waiting_network';
  bool get isWireGuardRecovery =>
      phase == VpnRuntimePhase.connecting &&
      protocol == VpnProtocol.wireGuard &&
      (messageCode == 'wireguard_waiting_network' ||
          messageCode == 'wireguard_recovering');

  factory VpnRuntimeState.fromWire(Map<Object?, Object?> value) {
    final Object? rawPhase = value['phase'] ?? value['status'];
    final Object? rawProtocol = value['protocol'];
    final Object? rawMessageCode =
        value['messageCode'] ?? value['message_code'];
    final VpnProtocol? protocol = rawProtocol is String
        ? VpnProtocol.fromApi(rawProtocol)
        : null;
    final String? messageCode =
        rawMessageCode is String &&
            RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(rawMessageCode)
        ? rawMessageCode
        : null;
    DateTime? timestamp(String key) {
      final Object? raw = value[key];
      if (raw is! int || raw <= 0) return null;
      return DateTime.fromMillisecondsSinceEpoch(raw);
    }

    int? bytes(String key) {
      final Object? raw = value[key];
      return raw is int && raw >= 0 ? raw : null;
    }

    String? safeText(String key, {bool identifier = false}) {
      final Object? raw = value[key];
      if (raw is! String || raw.isEmpty || raw.length > 160) return null;
      if (identifier && !RegExp(r'^[A-Za-z0-9._-]{1,160}$').hasMatch(raw)) {
        return null;
      }
      if (!identifier && raw.runes.any((int rune) => rune < 0x20)) return null;
      return raw;
    }

    return VpnRuntimeState(
      phase: rawPhase is String
          ? VpnRuntimePhase.fromWireValue(rawPhase)
          : VpnRuntimePhase.error,
      protocol: protocol,
      ipFamilies: switch (value['ip_families']) {
        ['ipv4', 'ipv6'] => const ['ipv4', 'ipv6'],
        ['ipv4'] => const ['ipv4'],
        _ => const [],
      },
      openVpnRevocation: value['openvpn_revocation'] == null
          ? null
          : OpenVpnRevocationResult.fromWire(value['openvpn_revocation']),
      messageCode: messageCode,
      connectedAt: timestamp('connected_at'),
      locationId: safeText('location_id', identifier: true),
      locationName: safeText('location_name'),
      receivedBytes: bytes('received_bytes'),
      sentBytes: bytes('sent_bytes'),
      latestHandshake: timestamp('latest_handshake'),
      sessionTermination: value['session_termination'] == null
          ? null
          : SessionTerminationResult.fromWire(value['session_termination']),
      systemProtection: value['system_protection'] is Map
          ? SystemVpnProtection.fromWire(
              (value['system_protection'] as Map).cast<Object?, Object?>(),
            )
          : const SystemVpnProtection(),
      retryAt: messageCode == 'openvpn_renewal_rate_limited'
          ? timestamp('retry_at')
          : null,
      excludedApps: switch (value['excluded_apps']) {
        final List<Object?> apps
            when apps.length <= ExcludedApps.maxApps &&
                apps.every(ExcludedApps.isPackageName) =>
          List<String>.unmodifiable(
            apps.cast<String>().toSet().toList()..sort(),
          ),
        _ => null,
      },
    );
  }

  VpnRuntimeState copyWith({SystemVpnProtection? systemProtection}) =>
      VpnRuntimeState(
        phase: phase,
        protocol: protocol,
        messageCode: messageCode,
        connectedAt: connectedAt,
        locationId: locationId,
        locationName: locationName,
        receivedBytes: receivedBytes,
        sentBytes: sentBytes,
        latestHandshake: latestHandshake,
        sessionTermination: sessionTermination,
        openVpnRevocation: openVpnRevocation,
        ipFamilies: ipFamilies,
        systemProtection: systemProtection ?? this.systemProtection,
        retryAt: retryAt,
        excludedApps: excludedApps,
      );

  @override
  String toString() =>
      'VpnRuntimeState(phase: ${phase.name}, protocol: ${protocol?.apiValue}, '
      'messageCode: $messageCode, metrics: redacted)';
}
