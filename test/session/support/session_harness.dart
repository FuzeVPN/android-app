// Doubles for the lot S session corrections (2026-10-29). They drive the real
// VpnAppController with an API, tunnel and storage that follow the native
// contract of AndroidVpnBridge:
//  * writeSession without userId fills the pending slot; with a userId it
//    fills that account slot, makes it active and drops the pending slot;
//  * readSession returns the active account's session, else the pending one,
//    as a newly decoded object;
//  * replaceGuestSession is refused (session_operation_cancelled) unless the
//    account is active and has a session (requireAccountSession), when
//    nativeModel is true;
//  * an end publishes its termination in progress (DISCONNECTING,
//    session_ending) before any request is answered. Requests joining one end
//    are merged: it is an expiry if one is, and the automatic guest recovery
//    marker is removed if one is voluntary (storageClearSession "reason"). An
//    older bridge reads only the expired flag (clearSession).
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/diagnostics.dart';
import 'package:fuzevpn_android/core/guest_accounts.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';

const guestCredential = 'AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8';
final farExpiry = DateTime.utc(2099);
final pastExpiry = DateTime.utc(2000);

AuthSession session(String token, [DateTime? expiresAt]) =>
    AuthSession(accessToken: token, expiresAt: expiresAt ?? farExpiry);

const guestA = UserProfile(
  userId: 'guest-a',
  identityKind: 'guest',
  profileRedacted: true,
  canManageAccount: false,
  canClaimAccount: true,
  canUseVpn: true,
);
const accountB = UserProfile(
  userId: 'registered-b',
  email: 'b@example.test',
  emailVerified: true,
);
const frankfurt = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 1',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard, VpnProtocol.openVpn},
);
const paris = Location(
  id: 'paris-01',
  city: 'Paris',
  countryCode: 'FR',
  displayName: 'Paris 1',
  supportedProtocols: <VpnProtocol>{VpnProtocol.wireGuard},
);
const deviceConfiguration = DeviceConfiguration(
  deviceId: 'device-a',
  address: '10.8.0.2/32',
  dns: <String>['1.1.1.1'],
  serverPublicKey: 'AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI=',
  endpoint: '192.0.2.1:51820',
  allowedIps: <String>['0.0.0.0/0'],
);
const unauthorized = ApiException(statusCode: 401, errorCode: 'unauthorized');
final openVpnActivation = OpenVpnActivation(
  deviceId: 'device-a',
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
  notAfter: DateTime.utc(2099),
);

VpnRuntimeState connectedAt(Location location) => VpnRuntimeState(
  phase: VpnRuntimePhase.connected,
  protocol: VpnProtocol.wireGuard,
  locationId: location.id,
);

class SessionApi extends Fake implements VpnApiRepository, GuestApiRepository {
  final createdCredentials = <String>[];
  final meTokens = <String>[];
  final logoutTokens = <String>[];
  final registered = <(String, String)>[];
  final deviceTokens = <String>[];
  int loginCalls = 0;
  int resetCalls = 0;

  /// Consumed in order by createGuestSession; a null entry succeeds.
  final createFailures = <Object?>[];
  DateTime? createExpiry;
  DateTime? loginExpiry;
  Object? loginFailure;
  Future<void> Function()? onReset;
  Future<void> Function()? onCreate;
  Future<DeviceConfiguration> Function(String token, String locationId)?
  onRegister;
  Future<DeviceList> Function(String token)? onDevices;

  /// Scripted /me answers per token, consumed in order (profile or error).
  final meScript = <String, List<Object>>{};

  /// Thrown by the catalogue until reset to null.
  Object? locationsFailure;

  /// Catalogue requests, the answer, and an optional pause before it.
  int locationCalls = 0;
  List<Location> catalogue = const <Location>[frankfurt, paris];
  Future<void> Function()? onLocations;

  /// Device revocations: (token, deviceId).
  final revokedDevices = <(String, String)>[];
  Future<void> Function(String token, String deviceId)? onRevoke;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    if (loginFailure != null) throw loginFailure!;
    return session('token-b', loginExpiry);
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    resetCalls++;
    if (onReset != null) await onReset!();
  }

  @override
  Future<GuestSessionResult> createGuestSession({
    required String guestCredential,
    bool termsAccepted = false,
    bool privacyAccepted = false,
  }) async {
    createdCredentials.add(guestCredential);
    if (onCreate != null) await onCreate!();
    final failure = createFailures.isEmpty ? null : createFailures.removeAt(0);
    if (failure != null) throw failure;
    return GuestSessionResult(
      session: session('token-a${createdCredentials.length}', createExpiry),
      userId: 'guest-a',
    );
  }

  @override
  Future<UserProfile> me(String token) async {
    meTokens.add(token);
    final script = meScript[token];
    if (script != null && script.isNotEmpty) {
      final next = script.removeAt(0);
      if (next is UserProfile) return next;
      throw next;
    }
    return token == 'token-b' ? accountB : guestA;
  }

  @override
  Future<List<Location>> locations() async {
    locationCalls++;
    if (onLocations != null) await onLocations!();
    final failure = locationsFailure;
    if (failure != null) throw failure;
    return catalogue;
  }

  @override
  Future<void> revokeDevice({
    required String token,
    required String deviceId,
  }) async {
    revokedDevices.add((token, deviceId));
    if (onRevoke != null) await onRevoke!(token, deviceId);
  }

  @override
  Future<DeviceList> listDevices(String token) async {
    deviceTokens.add(token);
    return onDevices != null
        ? await onDevices!(token)
        : const DeviceList(limit: 2, devices: <VpnDevice>[]);
  }

  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    registered.add((token, locationId));
    return onRegister != null
        ? await onRegister!(token, locationId)
        : deviceConfiguration;
  }

  /// OpenVPN profile requests: (token, deviceId).
  final openVpnProfiles = <(String, String)>[];
  Future<void> Function(String token)? onOpenVpnProfile;

  @override
  Future<OpenVpnActivation> createOpenVpnProfile({
    required String token,
    required String deviceId,
    required String csrPem,
    bool requestIpv6 = false,
  }) async {
    openVpnProfiles.add((token, deviceId));
    if (onOpenVpnProfile != null) await onOpenVpnProfile!(token);
    return openVpnActivation;
  }

  @override
  Future<void> logout(String token) async => logoutTokens.add(token);
}

class SessionStore extends Fake
    implements
        SecureSessionStore,
        PendingAdmissionStore,
        SessionEndCauseStore,
        GuestCredentialStore,
        GuestSessionRenewalStore {
  SessionStore(this.tunnel, {required this.nativeModel});
  final SessionTunnel tunnel;
  final bool nativeModel;
  AuthSession? pending;
  String? activeUser;
  final accountSessions = <String, AuthSession>{};
  String? credential;
  bool autoResume = false;
  /// The expired flag of every end request, as an older bridge reads it.
  final clears = <bool>[];

  /// The cause of every end request, in order.
  final causes = <SessionEndCause>[];
  final _endRequests = <SessionEndCause>{};
  int _endCalls = 0;
  final replacements = <String>[];
  final refusedReplacements = <String>[];
  final autoResumeWrites = <bool>[];
  final deviceIds = <String, String>{};

  /// One-shot failures.
  Object? readFailure;
  Object? deviceReadFailure;

  /// Thrown after the write committed, like a late native failure.
  Object? writeFailure;
  Object? replaceFailure;
  Object? autoResumeWriteFailure;
  Future<void> Function()? onWrite;
  Future<void> Function()? onReplace;
  Future<void> Function()? onClear;

  AuthSession? get stored =>
      activeUser == null ? pending : accountSessions[activeUser];

  /// Native storageReadSessionBinding: the pending slot holds only explicit
  /// registered admissions, whatever the app version that wrote them.
  @override
  Future<bool> readStoredSessionIsPendingAdmission() async =>
      activeUser == null && pending != null;

  @override
  Future<AuthSession?> readSession() async {
    final failure = readFailure;
    if (failure != null) {
      readFailure = null;
      throw failure;
    }
    final value = stored;
    return value == null
        ? null
        : AuthSession(accessToken: value.accessToken, expiresAt: value.expiresAt);
  }

  @override
  Future<void> writeSession(AuthSession value, {String? userId}) async {
    if (userId == null) {
      pending = value;
    } else {
      accountSessions[userId] = value;
      activeUser = userId;
      pending = null;
    }
    if (onWrite != null) await onWrite!();
    final failure = writeFailure;
    if (failure != null) {
      writeFailure = null;
      throw failure;
    }
  }

  @override
  Future<void> replaceGuestSession(
    AuthSession value, {
    required String userId,
  }) async {
    if (nativeModel &&
        (activeUser != userId || accountSessions[userId] == null)) {
      refusedReplacements.add(value.accessToken);
      throw const NativeVpnException('session_operation_cancelled');
    }
    replacements.add(value.accessToken);
    accountSessions[userId] = value;
    activeUser = userId;
    if (onReplace != null) await onReplace!();
    final failure = replaceFailure;
    if (failure != null) {
      replaceFailure = null;
      throw failure;
    }
  }

  /// An older bridge: the flag is both the expiry and "keep guest recovery".
  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) =>
      _end(expired ? SessionEndCause.expired : SessionEndCause.voluntary, expired);

  @override
  Future<SessionTerminationResult> clearSessionFor(SessionEndCause cause) =>
      _end(cause, cause != SessionEndCause.voluntary);

  Future<SessionTerminationResult> _end(
    SessionEndCause cause,
    bool expiredFlag,
  ) async {
    causes.add(cause);
    clears.add(expiredFlag);
    _endRequests.add(cause);
    _endCalls++;
    bool expired() => _endRequests.contains(SessionEndCause.expired);
    try {
      tunnel.emit(
        VpnRuntimeState(
          phase: VpnRuntimePhase.disconnecting,
          messageCode: 'session_ending',
          sessionTermination: SessionTerminationResult(
            tunnelStopped: false,
            sessionCleared: false,
            inProgress: true,
            sessionExpired: expired(),
          ),
        ),
      );
      if (onClear != null) await onClear!();
      pending = null;
      activeUser = null;
      accountSessions.clear();
      if (_endRequests.contains(SessionEndCause.voluntary)) autoResume = false;
      await tunnel.disconnect();
      return SessionTerminationResult(
        tunnelStopped: true,
        sessionCleared: true,
        sessionExpired: expired(),
      );
    } finally {
      if (--_endCalls == 0) _endRequests.clear();
    }
  }

  @override
  Future<String?> readGuestCredential() async => credential;
  @override
  Future<void> writeGuestCredential(String value) async => credential = value;
  @override
  Future<String?> readPendingGuestCredential() async => null;
  @override
  Future<void> writePendingGuestCredential(String value) async {}
  @override
  Future<bool> readGuestAutoResume() async => autoResume;

  @override
  Future<void> writeGuestAutoResume(bool enabled) async {
    autoResumeWrites.add(enabled);
    final failure = autoResumeWriteFailure;
    if (failure != null) throw failure;
    autoResume = enabled;
  }

  @override
  Future<void> clearGuestCredentials() async {
    credential = null;
    autoResume = false;
  }

  @override
  Future<String?> readCurrentDeviceId({required String userId}) async {
    final failure = deviceReadFailure;
    if (failure != null) {
      deviceReadFailure = null;
      throw failure;
    }
    return deviceIds[userId];
  }

  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async => deviceIds[userId] = deviceId;
  @override
  Future<void> clearCurrentDeviceId({required String userId}) async =>
      deviceIds.remove(userId);
  @override
  Future<DeviceLocationMigration?> readLocationMigration({
    required String userId,
    required String deviceId,
  }) async => null;
  @override
  Future<void> writeLocationMigration({
    required String userId,
    required DeviceLocationMigration migration,
  }) async {}
  @override
  Future<void> clearLocationMigration({
    required String userId,
    required String deviceId,
  }) async {}
}

class SessionPreferences extends Fake implements AppPreferenceStore {
  String? location = frankfurt.id;
  String? protocol = 'wireguard';
  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => null;
  @override
  Future<String?> readSelectedProtocol() async => protocol;
  @override
  Future<String?> readSelectedLocation() async => location;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {}
  @override
  Future<void> writeSelectedLocation(String value) async => location = value;
  @override
  Future<void> writeSelectedProtocol(String value) async => protocol = value;
}

class SessionTunnel extends Fake implements VpnTunnelGateway {
  final _states = StreamController<VpnRuntimeState>.broadcast();
  VpnRuntimeState state = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  int disconnectCalls = 0;
  int snapshots = 0;
  final connections = <String>[];

  @override
  Stream<VpnRuntimeState> get states => _states.stream;

  // Like the method channel, every snapshot is a freshly decoded object.
  @override
  Future<VpnRuntimeState> getState() async {
    snapshots++;
    return VpnRuntimeState(
      phase: state.phase,
      protocol: state.protocol,
      messageCode: state.messageCode,
      locationId: state.locationId,
      sessionTermination: state.sessionTermination,
    );
  }

  @override
  Future<bool> requestVpnPermission() async => true;

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async => 'AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE=';

  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async {
    connections.add(location.id);
    emit(connectedAt(location));
  }

  @override
  Future<void> disconnect() async {
    disconnectCalls++;
    openVpnRetained = false;
    emit(const VpnRuntimeState(phase: VpnRuntimePhase.idle));
  }

  int openVpnConnections = 0;

  /// An OpenVPN engine whose stop never completed: the native CSR route
  /// refuses while it is in use, until a native stop releases it.
  bool openVpnRetained = false;

  @override
  Future<OpenVpnCertificateStatus> getOpenVpnCertificateStatus({
    required String accountId,
    required String deviceId,
  }) async => const OpenVpnCertificateStatus(
    phase: OpenVpnCertificatePhase.missing,
    renewalPending: false,
  );

  @override
  Future<String> getOrCreateOpenVpnCsr({
    required String accountId,
    required String deviceId,
    bool renewal = false,
  }) async {
    if (openVpnRetained) {
      throw const NativeVpnException('openvpn_identity_in_use');
    }
    return 'csr-fixture';
  }

  @override
  Future<void> connectOpenVpn({
    required String accountId,
    required OpenVpnActivation activation,
    required Location location,
    bool preserveExistingCertificate = false,
    bool renewal = false,
  }) async {
    openVpnConnections++;
    emit(
      VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.openVpn,
        locationId: location.id,
      ),
    );
  }

  @override
  Future<OpenVpnRevocationResult?> getOpenVpnRevocation({
    required String accountId,
    required String deviceId,
  }) async => null;

  @override
  Future<void> clearAccountIdentity({
    required String accountId,
    required String? expectedDeviceId,
  }) async {}

  void emit(VpnRuntimeState value) {
    state = value;
    if (!_states.isClosed) _states.add(value);
  }

  Future<void> close() => _states.close();
}

class SessionHarness {
  SessionHarness({
    bool nativeModel = true,
    GoogleAuthController? google,
    DiagnosticService? diagnostics,
  }) {
    store = SessionStore(tunnel, nativeModel: nativeModel);
    controller = VpnAppController(
      api: api,
      sessionStore: store,
      preferences: preferences,
      tunnel: tunnel,
      googleAuthOverride: google,
      diagnostics: diagnostics,
    );
  }

  final api = SessionApi();
  final tunnel = SessionTunnel();
  final preferences = SessionPreferences();
  late final SessionStore store;
  late final VpnAppController controller;
  bool _closed = false;

  /// A guest A whose stored account session is [value], with a live tunnel.
  static SessionHarness guest(
    AuthSession value, {
    VpnRuntimeState? tunnel,
    bool nativeModel = true,
    DiagnosticService? diagnostics,
  }) {
    final h = SessionHarness(nativeModel: nativeModel, diagnostics: diagnostics);
    h.store.activeUser = 'guest-a';
    h.store.accountSessions['guest-a'] = value;
    h.store.credential = guestCredential;
    h.store.autoResume = true;
    h.tunnel.state = tunnel ?? connectedAt(frankfurt);
    return h;
  }

  /// A later process on the same durable storage.
  SessionHarness nextProcess({bool nativeModel = true}) {
    final next = SessionHarness(nativeModel: nativeModel);
    next.store.pending = store.pending;
    next.store.activeUser = store.activeUser;
    next.store.accountSessions.addAll(store.accountSessions);
    next.store.credential = store.credential;
    next.store.autoResume = store.autoResume;
    return next;
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    controller.dispose();
    await tunnel.close();
  }
}

String observe(SessionHarness h) =>
    'token=${h.controller.token} profile=${h.controller.profile?.userId} '
    'pending=${h.controller.hasPendingAccountRestoration} '
    'stored=${h.store.stored?.accessToken} clears=${h.store.clears} '
    'autoResume=${h.store.autoResume} created=${h.api.createdCredentials.length} '
    'me=${h.api.meTokens} replacements=${h.store.replacements} '
    'disconnects=${h.tunnel.disconnectCalls} '
    'notice=${h.controller.notice?.messageKey}/'
    '${h.controller.notice?.arguments['code']} '
    'guestMessage=${h.controller.guestMessageKey}';
