import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'billing_controller.dart';
import 'core/api_exception.dart';
import 'core/connection_timing.dart';
import 'core/diagnostics.dart';
import 'core/favorite_locations.dart';
import 'core/google_auth.dart';
import 'core/google_credentials.dart';
import 'core/guest_accounts.dart';
import 'core/ip_activation_attempt.dart';
import 'core/models.dart';
import 'core/play_billing.dart';
import 'core/repositories.dart';
import 'google_auth_controller.dart';
import 'l10n/app_languages.dart';
import 'native_vpn_bridge.dart';

part 'app_controller_capacity.dart';
part 'app_controller_diagnostics.dart';
part 'app_controller_favorites.dart';
part 'app_controller_google.dart';
part 'app_controller_guest.dart';
part 'app_controller_location_change.dart';
part 'app_controller_preferences.dart';

class AppNotice {
  const AppNotice({
    required this.titleKey,
    required this.messageKey,
    this.arguments = const <String, Object?>{},
    this.diagnosticCode,
  });

  final String titleKey;
  final String messageKey;
  final Map<String, Object?> arguments;

  /// Safe, non-secret reference identifying the exact failing branch.
  final String? diagnosticCode;
}

class VpnAppController extends ChangeNotifier {
  factory VpnAppController({
    required VpnApiRepository api,
    required SecureSessionStore sessionStore,
    required AppPreferenceStore preferences,
    required VpnTunnelGateway tunnel,
    Future<void> Function(Duration)? migrationDelay,
    int migrationMaxPollAttempts = 45,
    DiagnosticService? diagnostics,
    PlayBillingGateway? billingGateway,
    BillingApiRepository? billingApi,
    GoogleCredentialGateway? googleGateway,
    GooglePendingAuthStore? googlePendingStore,
    GoogleAuthController? googleAuthOverride,
  }) => VpnAppController._(
    api,
    sessionStore,
    preferences,
    tunnel,
    migrationDelay ?? ((Duration duration) => Future<void>.delayed(duration)),
    migrationMaxPollAttempts,
    diagnostics,
    billingGateway,
    billingApi,
    googleGateway,
    googlePendingStore,
    googleAuthOverride,
  );

  VpnAppController._(
    this._api,
    this._sessionStore,
    this._preferences,
    this._tunnel,
    this._migrationDelay,
    this._migrationMaxPollAttempts,
    this._diagnostics,
    PlayBillingGateway? billingGateway,
    BillingApiRepository? billingApi,
    GoogleCredentialGateway? googleGateway,
    GooglePendingAuthStore? googlePendingStore,
    GoogleAuthController? googleAuthOverride,
  ) {
    if (_migrationMaxPollAttempts < 1) {
      throw ArgumentError.value(
        _migrationMaxPollAttempts,
        'migrationMaxPollAttempts',
        'must_be_positive',
      );
    }
    _billing = BillingController(
      autoRestore: billingGateway is BillingSessionGateway,
      gateway: billingGateway ?? const UnavailablePlayBillingGateway(),
      api:
          billingApi ??
          (_api is BillingApiRepository
              ? _api as BillingApiRepository
              : const UnavailableBillingApi()),
      currentAccount: () => !isSignedIn || token == null
          ? null
          : BillingAccount(
              userId: profile!.userId,
              accessToken: token!,
              scope: _sessionOperation,
              allowAutoRestore: _guestActionOwner == null,
            ),
    );
    _googleAuth =
        googleAuthOverride ??
        GoogleAuthController(
          api: _api is GoogleAuthApiRepository
              ? _api as GoogleAuthApiRepository
              : null,
          gateway: googleGateway,
          pendingStore: googlePendingStore,
          identity: _googleIdentity,
          identityMatches: _googleIdentityMatches,
          canBegin: _canBeginGoogle,
          admitSession: _admitGoogleSession,
          admitClaim: _admitGoogleClaim,
        );
    _googleAuth.addListener(_googleChanged);
    _tunnelSubscription = _tunnel.states.listen(_onTunnelState);
    _billing.addListener(_guestBillingChanged);
    _diagnostics?.addListener(_diagnosticsChanged);
    if (_diagnostics != null) {
      _timingObserver = () {
        final operation = _sessionOperation;
        final account = profile?.userId;
        return (stage, event, duration, status) {
          if (!_disposed &&
              operation.isCurrent &&
              identical(operation, _sessionOperation) &&
              account == profile?.userId) {
            _recordDiagnosticTiming(stage, event, duration, status);
          }
        };
      };
      ConnectionTiming.observerFactories.add(_timingObserver!);
    }
  }

  final VpnApiRepository _api;
  late final BillingController _billing;
  BillingController get billing => _billing;
  late final GoogleAuthController _googleAuth;
  GoogleAuthController get googleAuth => _googleAuth;
  Object? _googleGuestOwner;
  final SecureSessionStore _sessionStore;
  final AppPreferenceStore _preferences;
  final VpnTunnelGateway _tunnel;
  final Future<void> Function(Duration) _migrationDelay;
  final int _migrationMaxPollAttempts;
  final DiagnosticService? _diagnostics;
  ConnectionTimingObserver Function()? _timingObserver;
  bool _diagnosticsCollecting = false;
  bool _diagnosticsPreferenceSaving = false;
  bool diagnosticsPreferenceFailed = false;
  bool diagnosticsPreparationFailed = false;
  bool diagnosticExportFailed = false;
  int _diagnosticCollectionEpoch = 0;
  int _diagnosticPreferenceEpoch = 0;
  int _diagnosticManualConsentEpoch = 0;
  Future<void> _diagnosticPreferenceWrites = Future<void>.value();
  Set<String> _favoriteLocationIds = const <String>{};
  Set<String> _savedFavoriteLocationIds = const <String>{};
  Future<void> _favoriteWrites = Future<void>.value();
  Future<void> _uiPreferenceWrites = Future<void>.value();
  final Map<String, int> _uiPreferenceEpochs = {};
  int _favoriteEpoch = 0;
  int _favoriteWritesPending = 0;
  bool favoritesSaveFailed = false;
  late final StreamSubscription<VpnRuntimeState> _tunnelSubscription;
  Timer? _tunnelMetricsTimer;
  bool _tunnelMetricsRefreshInFlight = false;
  SessionOperation _sessionOperation = SessionOperation();
  Future<void> _sessionWrites = Future<void>.value();
  Future<void>? _terminationTask;
  Object? _accountRestorationOwner;
  bool? _pendingVerificationNeeded;
  bool _disposed = false;
  Object? _guestActionOwner;
  Timer? _guestRetryTimer;
  bool _guestRefreshing = false;
  bool _guestRefreshQueued = false;
  Future<bool>? _guestRefreshTask;
  bool _guestRenewing = false;
  Future<bool>? _guestRenewalTask;
  bool _guestResuming = false;
  Future<bool>? _guestResumeTask;
  bool _guestRecoveryDeferred = false;
  bool? _guestObservedAccess;
  String? _guestMessage;
  bool get isGuestActionBusy =>
      _guestActionOwner != null ||
      _guestRetryTimer != null ||
      _guestRenewing ||
      _guestResuming;
  String? get guestMessageKey => _guestMessage;
  Future<bool> beginGuestPurchase(PlaySubscriptionPlan plan) =>
      _beginGuestPurchase(plan);
  Future<bool> restoreGuestPurchases() => _restoreGuestPurchases();
  Future<bool> claimGuestAccount({
    required String email,
    required String password,
  }) => _claimGuestAccount(email: email, password: password);
  Future<bool> refreshGuestAccount() => _refreshGuestAccount();
  int _locationsRefreshGeneration = 0;
  int _capacityRejectionGeneration = 0;
  final Map<String, int> _capacityRejectedLocations = {};
  int _devicesRefreshGeneration = 0;
  int _locationSelectionGeneration = 0;
  bool _sessionExpired = false;
  SessionTerminationResult? sessionTermination;

  Future<T> _sessionWrite<T>(
    SessionOperation operation,
    Future<T> Function() write, {
    _MigrationContext? migrationContext,
    _IdentityOperation? identityContext,
    IpActivationAttempt? networkAttempt,
  }) {
    final Future<T> result = ConnectionTiming.measure(
      'storage.session_queue_write',
      () => _sessionWrites.then((_) {
        ConnectionTiming.event('storage.session_queue_acquired');
        operation.check();
        migrationContext?.check();
        identityContext?.check();
        networkAttempt?.check();
        return ConnectionTiming.measure('storage.session_write', write);
      }),
    );
    _sessionWrites = result.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return result;
  }

  ThemeMode themeMode = ThemeMode.system;
  Locale? locale;
  VpnProtocol selectedProtocol = VpnProtocol.wireGuard;
  VpnRuntimeState tunnelState = const VpnRuntimeState(
    phase: VpnRuntimePhase.idle,
  );
  List<Location> locations = const <Location>[];
  Location? selectedLocation;
  DeviceList deviceList = const DeviceList(limit: 2, devices: <VpnDevice>[]);
  UserProfile? profile;
  AuthSession? _session;
  String? _currentDeviceId;
  int _deviceEpoch = 0;
  String? get currentDeviceId => _currentDeviceId;
  set currentDeviceId(String? value) {
    if (value != _currentDeviceId) {
      _deviceEpoch++;
      _resetMigration();
      _revocationResult = null;
      _revocationOperation = null;
      _revocationTask = null;
    }
    _currentDeviceId = value;
  }

  _MigrationContext? _migrationContext;
  _MigrationContext? _migrationStartRequest;
  OpenVpnRevocationResult? _revocationResult;
  _IdentityOperation? _revocationOperation;
  Future<void>? _revocationTask;
  final Set<String> _completedRevocations = {};
  OpenVpnRevocationResult? get openVpnRevocation =>
      _revocationOperation?.isCurrent == true ? _revocationResult : null;

  _IdentityOperation _identityScope(
    String? deviceId, {
    _MigrationContext? migrationContext,
  }) {
    final operation = _sessionOperation;
    final account = profile?.userId;
    final activeToken = token;
    final epoch = _deviceEpoch;
    return _IdentityOperation(
      operation,
      () =>
          account != null &&
          profile?.userId == account &&
          token == activeToken &&
          currentDeviceId == deviceId &&
          _deviceEpoch == epoch &&
          (migrationContext?.isCurrent ?? true),
    );
  }

  Future<void> retryOpenVpnRevocation() async {
    if (isIdentityBusy) return;
    final result = openVpnRevocation;
    final context = _revocationOperation;
    if (result == null || context == null || result.inProgress) return;
    final Object owner = Object();
    _identityMutationOwner = owner;
    try {
      await _cleanOpenVpnRevocation(context, result);
    } on SessionOperationCancelled {
      // The replacing session or device owns subsequent UI and cleanup.
    } finally {
      if (identical(_identityMutationOwner, owner)) {
        _identityMutationOwner = null;
        if (context.isCurrent) notifyListeners();
      }
    }
  }

  Future<void> _cleanOpenVpnRevocation(
    _IdentityOperation context,
    OpenVpnRevocationResult target,
  ) {
    context.check();
    if (_revocationTask != null) return _revocationTask!;
    _revocationOperation = context;
    _revocationResult = target.waiting();
    notice = null;
    notifyListeners();
    final done = Completer<void>();
    _revocationTask = done.future;
    unawaited(() async {
      try {
        context.check();
        final result = await _tunnel.cleanRevokedOpenVpnIdentity(
          accountId: target.accountId,
          deviceId: target.deviceId,
          csrSha256: target.csrSha256,
        );
        context.check();
        if (result.accountId != target.accountId ||
            result.deviceId != target.deviceId ||
            result.csrSha256 != target.csrSha256) {
          throw const NativeVpnException('invalid_arguments');
        }
        if (result.stale || result.isComplete) {
          _completedRevocations.add(
            '${target.accountId}/${target.deviceId}/${target.csrSha256}',
          );
          _revocationResult = null;
          if (result.isComplete) {
            notice = const AppNotice(
              titleKey: 'openvpnCleanup.title',
              messageKey: 'openvpnCleanup.complete',
            );
          }
        } else {
          _revocationResult = result;
        }
        done.complete();
      } catch (error, stack) {
        if (!context.isCurrent) {
          done.completeError(const SessionOperationCancelled(), stack);
        } else {
          _revocationResult = OpenVpnRevocationResult(
            accountId: target.accountId,
            deviceId: target.deviceId,
            csrSha256: target.csrSha256,
            tunnelStopped: _revocationResult?.tunnelStopped ?? false,
            storageError: 'openvpn_identity_clear_failed',
          );
          done.complete();
        }
      } finally {
        if (context.isCurrent && identical(_revocationTask, done.future)) {
          _revocationTask = null;
          notifyListeners();
        }
      }
    }());
    return done.future;
  }

  int _networkAttemptEpoch = 0;

  IpActivationAttempt _networkAttempt() {
    final epoch = ++_networkAttemptEpoch;
    final operation = _sessionOperation;
    final account = profile?.userId;
    final activeToken = token;
    final location = selectedLocation?.id;
    final protocol = selectedProtocol;
    final locationChange = _locationChangeOperation;
    return IpActivationAttempt(
      deviceId: currentDeviceId,
      deviceEpoch: _deviceEpoch,
      matches: (attempt) =>
          (locationChange?.isCurrent ?? true) &&
          !_disposed &&
          operation.isCurrent &&
          epoch == _networkAttemptEpoch &&
          account == profile?.userId &&
          activeToken == token &&
          location == selectedLocation?.id &&
          protocol == selectedProtocol &&
          attempt.deviceId == currentDeviceId &&
          attempt.deviceEpoch == _deviceEpoch,
    );
  }

  Future<void> _refreshIpCapability(
    IpActivationAttempt attempt,
    String locationId,
  ) => ConnectionTiming.measure('prepare.capabilities', () async {
    attempt.check();
    final SessionOperation operation = _sessionOperation;
    final int generation = ++_locationsRefreshGeneration;
    final int capacityGeneration = _capacityRejectionGeneration;
    isLoadingLocations = true;
    notifyListeners();
    try {
      final received = await _api.locations();
      attempt.check();
      if (generation == _locationsRefreshGeneration) {
        locations = _filterCapacityRejections(received, capacityGeneration);
      }
      final matching = received.where((item) => item.id == locationId);
      attempt.requestIpv6 = matching.isNotEmpty && matching.first.supportsIpv6;
    } on ApiFailure {
      attempt.check();
      // Omission preserves an existing device's family choice on the server.
      attempt.requestIpv6 = false;
    } finally {
      if (!_disposed &&
          operation.isCurrent &&
          generation == _locationsRefreshGeneration) {
        isLoadingLocations = false;
        notifyListeners();
      }
    }
  });

  void _showIpv4Fallback(
    IpActivationAttempt attempt,
    VpnNetworkConfiguration network,
  ) {
    attempt.check();
    if (attempt.fellBack && !network.dualStack) {
      notice = const AppNotice(
        titleKey: 'network.title',
        messageKey: 'network.ipv4Fallback',
      );
    }
  }

  Future<OpenVpnActivation> _requestOpenVpnActivation({
    required _IdentityOperation context,
    required String accountId,
    required String deviceId,
    required String activeToken,
    required String csr,
    required bool renewal,
    required IpActivationAttempt networkAttempt,
  }) async {
    context.check();
    try {
      final activation = await networkAttempt.request(
        (ipv6) async => renewal
            ? await _api.renewOpenVpnProfile(
                token: activeToken,
                deviceId: deviceId,
                csrPem: csr,
                requestIpv6: ipv6,
              )
            : await _api.createOpenVpnProfile(
                token: activeToken,
                deviceId: deviceId,
                csrPem: csr,
                requestIpv6: ipv6,
              ),
        checkIdentity: context.check,
      );
      context.check();
      return activation;
    } on ApiFailure catch (error) {
      context.check();
      if (error.statusCode != 409 || error.code != 'openvpn_profile_revoked') {
        rethrow;
      }
      await _cleanOpenVpnRevocation(
        context,
        OpenVpnRevocationResult(
          accountId: accountId,
          deviceId: deviceId,
          csrSha256: sha256.convert(utf8.encode(csr)).toString(),
        ),
      );
      context.check();
      throw const _OpenVpnRevocationHandled();
    }
  }

  Object? _connectionOwner;
  _LocationChangeOperation? _locationChangeOperation;
  int _disconnectsInFlight = 0;
  Object? _identityMutationOwner;
  bool get isIdentityBusy =>
      _identityMutationOwner != null || _connectionOwner != null;
  DeviceLocationMigration? get locationMigration {
    final _MigrationContext? context = _migrationContext;
    return context != null && context.isCurrent ? context.value : null;
  }

  Object _beginConnectionWork() {
    final Object owner = Object();
    _connectionOwner = owner;
    isConnecting = true;
    return owner;
  }

  void _resetMigration() {
    final _MigrationContext? previous = _migrationContext;
    previous?.invalidate();
    _migrationContext = null;
    if (previous?.connectionOwner != null &&
        identical(previous!.connectionOwner, _connectionOwner)) {
      _connectionOwner = null;
      isConnecting = false;
    }
  }

  _MigrationContext _migrationScope() {
    _sessionOperation.check();
    final String? userId = profile?.userId;
    final String? activeToken = token;
    if (userId == null || activeToken == null) {
      throw const SessionOperationCancelled();
    }
    final _MigrationContext? existing = _migrationContext;
    if (existing != null && existing.isCurrent) return existing;
    _resetMigration();
    final String? deviceId = currentDeviceId;
    final int deviceEpoch = _deviceEpoch;
    final SessionOperation session = _sessionOperation;
    final locationChange = _locationChangeOperation?.isCurrent == true
        ? _locationChangeOperation
        : null;
    return _migrationContext = _MigrationContext(
      session: _sessionOperation,
      userId: userId,
      token: activeToken,
      deviceId: deviceId,
      matchesAccount: () =>
          !_disposed &&
          identical(session, _sessionOperation) &&
          profile?.userId == userId &&
          token == activeToken &&
          currentDeviceId == deviceId &&
          _deviceEpoch == deviceEpoch,
      matches: () =>
          (locationChange?.isCurrent ?? true) &&
          profile?.userId == userId &&
          token == activeToken &&
          currentDeviceId == deviceId,
    );
  }

  AppNotice? notice;
  bool isInitializing = true;
  bool isLoadingLocations = false;
  bool isLoadingDevices = false;
  bool _isAuthenticating = false;
  bool get isAuthenticating =>
      _isAuthenticating || _googleAuth.hasPendingIntent;
  set isAuthenticating(bool value) => _isAuthenticating = value;
  bool isConnecting = false;
  bool isRevoking = false;
  bool mayNeedEmailVerification = false;

  bool get isRestoringAccount => _accountRestorationOwner != null;
  bool get hasPendingAccountRestoration => _session != null && !isSignedIn;
  bool get isSignedIn =>
      _session != null && profile != null && !isRestoringAccount;
  String? get token => _session?.accessToken;
  bool get isTunnelActive =>
      tunnelState.phase != VpnRuntimePhase.idle &&
      tunnelState.phase != VpnRuntimePhase.error;
  bool get isConnected => tunnelState.phase == VpnRuntimePhase.connected;
  bool get isDisconnecting => _disconnectsInFlight > 0;
  bool get isStartingLocationMigration =>
      _migrationStartRequest?.isAccountCurrent ?? false;
  bool get canSelectProtocol =>
      !_disposed &&
      !isInitializing &&
      !isAuthenticating &&
      !isRestoringAccount &&
      !isConnecting &&
      !isChangingLocation &&
      !isIdentityBusy &&
      !isRevoking &&
      !isDisconnecting &&
      !isTunnelActive &&
      !isLocationMigrationLocked;
  bool get canCancelConnectionAttempt =>
      !_disposed &&
      _sessionOperation.isCurrent &&
      !isDisconnecting &&
      (isConnecting ||
          isChangingLocation ||
          tunnelState.phase == VpnRuntimePhase.authorizing ||
          tunnelState.phase == VpnRuntimePhase.preparing ||
          tunnelState.phase == VpnRuntimePhase.connecting);
  bool get isLocationMigrationPending =>
      locationMigration?.status.isPending ?? false;
  bool get isLocationMigrationLocked =>
      locationMigration != null || isStartingLocationMigration;
  bool get hasBlockedLocationMigration =>
      locationMigration?.status == LocationMigrationStatus.blocked;
  bool get supportsSystemProtectionSettings =>
      _tunnel is VpnSystemProtectionGateway;
  SystemVpnProtection get systemProtection => tunnelState.systemProtection;

  Location? get activeDeviceLocation => currentDevice?.location;

  VpnDevice? get currentDevice => currentDeviceId == null
      ? null
      : deviceList.devices.cast<VpnDevice?>().firstWhere(
          (VpnDevice? device) => device?.deviceId == currentDeviceId,
          orElse: () => null,
        );

  Future<void> initialize() async {
    final SessionOperation operation = _sessionOperation;
    isInitializing = true;
    notifyListeners();
    try {
      unawaited(_initializeDiagnostics());
      await _initializeFavorites();
      operation.check();
      final String? savedTheme = await _safe<String?>(
        _preferences.readThemeMode(),
      );
      operation.check();
      themeMode = switch (savedTheme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
      final String? savedLocale = await _safe<String?>(
        _preferences.readLocale(),
      );
      operation.check();
      locale = _supportedLocale(savedLocale);
      await _syncNotificationLocale();
      operation.check();
      final String? savedProtocol = await _safe<String?>(
        _preferences.readSelectedProtocol(),
      );
      operation.check();
      selectedProtocol = savedProtocol == VpnProtocol.openVpn.apiValue
          ? VpnProtocol.openVpn
          : VpnProtocol.wireGuard;
      final String? savedLocation = await _safe<String?>(
        _preferences.readSelectedLocation(),
      );
      operation.check();
      final VpnRuntimeState? restoredState = await _safe<VpnRuntimeState?>(
        _tunnel.getState(),
      );
      operation.check();
      tunnelState = restoredState ?? tunnelState;
      await refreshSystemProtection(notify: false);
      operation.check();
      final SessionTerminationResult? pending = tunnelState.sessionTermination;
      _sessionExpired = _sessionExpired || (pending?.sessionExpired ?? false);
      if (pending != null && !pending.isComplete) {
        sessionTermination = pending;
        if (pending.inProgress) await _terminateSession();
        return;
      }
      _syncTunnelMetricsTimer();
      await refreshLocations(savedLocation: savedLocation, notify: false);
      operation.check();

      final AuthSession? savedSession;
      try {
        savedSession = await _sessionStore.readSession();
      } catch (_) {
        operation.check();
        await _terminateSession();
        return;
      }
      operation.check();
      if (savedSession != null &&
          savedSession.expiresAt.isAfter(DateTime.now())) {
        _session = savedSession;
        await _restoreAccount(notify: false);
      } else if (savedSession != null) {
        if (!await _resumeGuestSession(operation, previous: savedSession)) {
          operation.check();
          if (_guestRecoveryDeferred) {
            _session = savedSession;
            notice = const AppNotice(
              titleKey: 'billing.title',
              messageKey: 'guest.serviceUnavailable',
            );
          } else {
            await _terminateSession(expired: true);
          }
        }
      } else if (await _resumeGuestSession(operation)) {
        operation.check();
      } else if (tunnelState.phase != VpnRuntimePhase.idle) {
        await _terminateSession();
      }
      if (_session == null && pending?.isComplete == true && _sessionExpired) {
        _showSessionExpiredNotice();
      }
    } on SessionOperationCancelled {
      // The shared session termination already owns the UI.
    } finally {
      if (operation.isCurrent) {
        isInitializing = false;
        notifyListeners();
      }
    }
  }

  Future<void> setLocale(Locale? value) async {
    final Locale? normalized = _supportedLocale(value?.toLanguageTag());
    locale = normalized;
    await _persistUiPreference(
      'locale',
      () => _preferences.writeLocale(normalized?.toLanguageTag()),
    );
    await _syncNotificationLocale();
    notifyListeners();
  }

  Locale? _supportedLocale(String? value) => AppLanguages.parse(value);

  Future<void> _syncNotificationLocale() async {
    final VpnNotificationLocaleGateway? localized =
        _tunnel is VpnNotificationLocaleGateway
        ? _tunnel as VpnNotificationLocaleGateway
        : null;
    if (localized != null) {
      await _safe<void>(
        localized.setNotificationLocale(locale?.toLanguageTag()),
      );
    }
  }

  Future<void> refreshLocations({
    String? savedLocation,
    bool notify = true,
  }) async {
    final SessionOperation operation = _sessionOperation;
    if (_disposed || !operation.isCurrent) return;
    final int generation = ++_locationsRefreshGeneration;
    final int capacityGeneration = _capacityRejectionGeneration;
    final int selectionGeneration = _locationSelectionGeneration;
    bool isCurrent() =>
        !_disposed &&
        operation.isCurrent &&
        generation == _locationsRefreshGeneration;
    isLoadingLocations = true;
    if (notify) notifyListeners();
    try {
      final List<Location> received = await _api.locations();
      if (!isCurrent()) return;
      locations = _filterCapacityRejections(received, capacityGeneration);
      final bool selectionChanged =
          selectionGeneration != _locationSelectionGeneration;
      final String? preferredId = selectionChanged
          ? selectedLocation?.id
          : savedLocation ?? selectedLocation?.id;
      selectedLocation = locations.cast<Location?>().firstWhere(
        (Location? location) => location?.id == preferredId,
        // A catalogue cannot replace an explicit newer choice or the target of
        // ongoing connection/migration work. An omitted target is no longer a
        // selectable row, but that omission does not cancel or restart work.
        orElse: () =>
            selectionChanged || isConnecting || isLocationMigrationLocked
            ? selectedLocation
            : locations.isEmpty
            ? null
            : locations.first,
      );
    } on ApiFailure catch (error) {
      if (!isCurrent()) return;
      _setNotice(ApiErrorMessages.fromFailure(error));
    } finally {
      if (isCurrent()) {
        isLoadingLocations = false;
        if (notify) notifyListeners();
      }
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    if (_session != null &&
        (profile?.isGuest == true || profile?.profileRedacted == true)) {
      return _signInSeparately(email: email, password: password);
    }
    if (sessionTermination != null || _session != null || isAuthenticating) {
      return false;
    }
    _sessionOperation.invalidate();
    _invalidateListRefreshes();
    _sessionOperation = SessionOperation();
    _resetMigration();
    _sessionExpired = false;
    final SessionOperation operation = _sessionOperation;
    if (!operation.isCurrent) return false;
    try {
      isAuthenticating = true;
      notice = null;
      notifyListeners();
      try {
        final AuthSession session = await _api.login(
          email: email,
          password: password,
        );
        operation.check();
        final bool restored = await _setSession(
          session,
          verificationNeeded: false,
        );
        operation.check();
        return restored;
      } on ApiFailure catch (error) {
        operation.check();
        _setNotice(ApiErrorMessages.fromFailure(error));
        return false;
      } on NativeVpnException catch (error) {
        operation.check();
        await _handleInitialSessionWriteFailure(error);
        return false;
      } finally {
        if (operation.isCurrent) {
          isAuthenticating = false;
          notifyListeners();
        }
      }
    } on SessionOperationCancelled {
      return false;
    }
  }

  Future<bool> register(RegisterAccountRequest request) async {
    if (sessionTermination != null || _session != null || isAuthenticating) {
      return false;
    }
    _sessionOperation.invalidate();
    _invalidateListRefreshes();
    _sessionOperation = SessionOperation();
    _resetMigration();
    _sessionExpired = false;
    final SessionOperation operation = _sessionOperation;
    if (!operation.isCurrent) return false;
    try {
      isAuthenticating = true;
      notice = null;
      notifyListeners();
      try {
        final RegistrationResult registration = await _api.register(request);
        operation.check();
        final bool restored = await _setSession(
          registration,
          verificationNeeded: true,
        );
        operation.check();
        if (restored && !registration.verificationEmailSent) {
          notice = _controllerNotice('account_created_email_unavailable');
        }
        return restored;
      } on ApiFailure catch (error) {
        operation.check();
        _setNotice(ApiErrorMessages.fromFailure(error));
        return false;
      } on NativeVpnException catch (error) {
        operation.check();
        await _handleInitialSessionWriteFailure(error);
        return false;
      } finally {
        if (operation.isCurrent) {
          isAuthenticating = false;
          notifyListeners();
        }
      }
    } on SessionOperationCancelled {
      return false;
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    if (isAuthenticating) return false;
    isAuthenticating = true;
    notice = null;
    notifyListeners();
    try {
      await _api.requestPasswordReset(email);
      notice = _controllerNotice('password_reset_sent');
      return true;
    } on ApiFailure catch (error) {
      _setNotice(ApiErrorMessages.fromFailure(error));
      return false;
    } finally {
      isAuthenticating = false;
      notifyListeners();
    }
  }

  Future<void> resendVerification() async {
    final SessionOperation operation = _sessionOperation;
    if (!operation.isCurrent) return;
    try {
      final String? activeToken = token;
      if (activeToken == null) return;
      notice = null;
      notifyListeners();
      try {
        await _api.resendVerification(activeToken);
        operation.check();
        notice = _controllerNotice('verification_email_sent');
      } on ApiFailure catch (error) {
        operation.check();
        await _handleSessionFailure(error, operation);
        operation.check();
        _setNotice(ApiErrorMessages.fromFailure(error));
      }
      notifyListeners();
    } on SessionOperationCancelled {
      return;
    }
  }

  Future<void> refreshDevices() async {
    final SessionOperation operation = _sessionOperation;
    if (_disposed || !operation.isCurrent) return;
    try {
      final String? activeToken = token;
      if (activeToken == null) return;
      final int generation = ++_devicesRefreshGeneration;
      bool isCurrent() =>
          !_disposed &&
          operation.isCurrent &&
          generation == _devicesRefreshGeneration;
      isLoadingDevices = true;
      notifyListeners();
      try {
        final DeviceList received = await _api.listDevices(activeToken);
        operation.check();
        if (!isCurrent()) return;
        deviceList = received;
      } on ApiFailure catch (error) {
        operation.check();
        // A 401 still invalidates this exact active session even when another
        // list request superseded its UI result. A replaced session is guarded
        // by operation.check() before interpreting the response.
        await _handleSessionFailure(error, operation);
        operation.check();
        if (!isCurrent()) return;
        _setNotice(ApiErrorMessages.fromFailure(error));
      } finally {
        if (isCurrent()) {
          isLoadingDevices = false;
          notifyListeners();
        }
      }
    } on SessionOperationCancelled {
      return;
    }
  }

  Future<void> selectLocation(Location location) async {
    _cancelLocationChange();
    await _selectLocation(location);
  }

  Future<void> _selectLocation(Location location) async {
    if (isLocationMigrationLocked) {
      notice = _controllerNotice(
        'location_migration_pending',
        arguments: <String, Object?>{'target': _migrationTargetLabel()},
      );
      notifyListeners();
      return;
    }
    selectedLocation = location;
    _locationSelectionGeneration++;
    await _persistUiPreference(
      'location',
      () => _preferences.writeSelectedLocation(location.id),
    );
  }

  Future<void> resumeLocationMigration() async {
    if (!_sessionOperation.isCurrent ||
        isStartingLocationMigration ||
        isConnecting ||
        isChangingLocation ||
        isIdentityBusy ||
        locationMigration == null) {
      return;
    }
    final _MigrationContext context = _migrationScope();
    await _followLocationMigration(context, refreshFirst: true);
  }

  Future<void> selectProtocol(VpnProtocol protocol) async {
    if (!canSelectProtocol) return;
    await _selectProtocol(protocol);
  }

  Future<void> _selectProtocol(VpnProtocol protocol) async {
    selectedProtocol = protocol;
    await _persistUiPreference(
      'protocol',
      () => _preferences.writeSelectedProtocol(protocol.apiValue),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    await _persistUiPreference(
      'theme',
      () => _preferences.writeThemeMode(mode.name),
    );
  }

  Future<void> connect() => _connect();

  Future<void> _connect({
    _LocationChangeOperation? locationChange,
  }) => ConnectionTiming.run('connection', () async {
    if (profile?.isGuest == true &&
        _session != null &&
        !_session!.expiresAt.isAfter(
          DateTime.now().add(const Duration(minutes: 2)),
        )) {
      if (!await _renewGuestSession()) {
        notice = const AppNotice(
          titleKey: 'billing.title',
          messageKey: 'guest.serviceUnavailable',
        );
        notifyListeners();
        return;
      }
    }
    if (_disconnectsInFlight > 0 ||
        isStartingLocationMigration ||
        (isChangingLocation &&
            !identical(locationChange, _locationChangeOperation))) {
      return;
    }
    if (locationChange != null && !locationChange.isCurrent) return;
    final SessionOperation operation = _sessionOperation;
    if (!operation.isCurrent) return;
    if (openVpnRevocation != null) return;
    try {
      final VpnProtocol connectionProtocol = selectedProtocol;

      final UserProfile? activeProfile = profile;
      final String? activeToken = token;
      final Location? location = selectedLocation;
      if (!isSignedIn || activeProfile == null || activeToken == null) {
        notice = _controllerNotice('vpn_sign_in_required');
        notifyListeners();
        return;
      }
      if (!activeProfile.canUseVpn) {
        notice = const AppNotice(
          titleKey: 'billing.title',
          messageKey: 'guest.premiumRequired',
        );
        notifyListeners();
        return;
      }
      if (location == null || !location.supports(connectionProtocol)) {
        notice = _controllerNotice('protocol_unavailable_at_location');
        notifyListeners();
        return;
      }
      if (isConnecting ||
          isIdentityBusy ||
          tunnelState.phase == VpnRuntimePhase.disconnecting) {
        return;
      }
      final DeviceLocationMigration? pendingMigration = locationMigration;
      if (pendingMigration != null &&
          pendingMigration.status.isPending &&
          pendingMigration.targetLocationId != location.id) {
        notice = _controllerNotice(
          'location_migration_pending',
          arguments: <String, Object?>{'target': _migrationTargetLabel()},
        );
        notifyListeners();
        return;
      }

      final Object owner = _beginConnectionWork();
      final networkAttempt = _networkAttempt();
      _MigrationContext? migrationContext;
      notice = null;
      notifyListeners();
      try {
        await _prepareTunnelRequest(activeProfile.userId);
        operation.check();
        networkAttempt.check();
        await _refreshIpCapability(networkAttempt, location.id);
        networkAttempt.check();
        final _LocationPreparation locationPreparation =
            await _prepareLocationForConnection(
              activeProfile: activeProfile,
              token: activeToken,
              location: location,
              protocol: connectionProtocol,
            );
        operation.check();
        networkAttempt.check();
        if (!locationPreparation.ready) return;
        migrationContext = locationPreparation.context;
        migrationContext?.check();
        migrationContext?.connectionOwner = owner;

        await _stopActiveTunnelBeforeChange();
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        final bool permissionGranted = await ConnectionTiming.measure(
          'permission.android',
          _tunnel.requestVpnPermission,
        );
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        if (!permissionGranted) {
          throw const _ControllerFailure('vpn_permission_denied');
        }
        var replacedRevokedIdentity = false;
        final bool migratedCurrentDevice = locationPreparation.migrated;
        var releasedBlockingOpenVpnProfile = false;
        while (true) {
          try {
            if (connectionProtocol == VpnProtocol.wireGuard) {
              await _connectWireGuard(
                activeProfile,
                activeToken,
                location,
                networkAttempt: networkAttempt,
                migrationContext: migrationContext,
                expectedDeviceId: migratedCurrentDevice
                    ? migrationContext?.deviceId
                    : null,
              );
              operation.check();
              networkAttempt.check();
              migrationContext?.check();
            } else {
              await _connectOpenVpn(
                activeProfile,
                activeToken,
                location,
                networkAttempt: networkAttempt,
                migrationContext: migrationContext,
                expectedDeviceId: migratedCurrentDevice
                    ? migrationContext?.deviceId
                    : null,
                preserveExistingCertificate: migratedCurrentDevice,
              );
              operation.check();
              networkAttempt.check();
              migrationContext?.check();
            }
            break;
          } on SessionOperationCancelled {
            rethrow;
          } on ApiFailure catch (error) {
            operation.check();
            networkAttempt.check();
            migrationContext?.check();
            if (!releasedBlockingOpenVpnProfile &&
                error.code == 'device_location_locked' &&
                connectionProtocol == VpnProtocol.wireGuard &&
                currentDeviceId != null) {
              releasedBlockingOpenVpnProfile = true;
              await _releaseOpenVpnForWireGuard(
                activeProfile: activeProfile,
                token: activeToken,
                migrationContext: migrationContext,
              );
              operation.check();
              networkAttempt.check();
              migrationContext?.check();
              continue;
            }
            if (!replacedRevokedIdentity &&
                error.code == 'device_identity_revoked') {
              // The server has already revoked this identity, so no DELETE is
              // needed or allowed here. Remove the unusable account-scoped
              // material and retry exactly once with fresh native keys.
              await _replaceRevokedLocalIdentity(
                activeProfile.userId,
                networkAttempt: networkAttempt,
                migrationContext: migrationContext,
              );
              operation.check();
              networkAttempt.check();
              migrationContext?.check();
              replacedRevokedIdentity = true;
              continue;
            }
            if (replacedRevokedIdentity && error.code == 'device_limit') {
              throw const _ControllerFailure('revoked_identity_device_limit');
            }
            rethrow;
          }
        }
        // Native code emits `connected` only after its own real tunnel proof.
        // The controller deliberately does not claim success here.
      } on _OpenVpnRevocationHandled {
        // Cleanup owns its message; the next connection requires a new user action.
      } on SessionOperationCancelled {
        rethrow;
      } on ApiFailure catch (error) {
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        await _handleSessionFailure(error, operation);
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        _setNotice(ApiErrorMessages.fromFailure(error));
        await _refreshAfterCapacityFailure(
          error,
          location.id,
          check: () {
            operation.check();
            networkAttempt.check();
            migrationContext?.check();
          },
        );
      } on _ControllerFailure catch (failure) {
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        notice = _controllerFailureNotice(failure);
        tunnelState = VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          messageCode: failure.code,
        );
      } on NativeVpnException catch (error) {
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        notice = _nativeNotice(error.code, protocol: connectionProtocol);
        tunnelState = VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          messageCode: error.code,
        );
      } catch (_) {
        operation.check();
        networkAttempt.check();
        migrationContext?.check();
        notice = _controllerNotice(
          'tunnel_start_unexpected',
          diagnosticCode: 'APP-CONNECT · tunnel_start_unexpected',
        );
        tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.error,
          messageCode: 'tunnel_start_failed',
        );
      } finally {
        if (operation.isCurrent && identical(owner, _connectionOwner)) {
          migrationContext?.connectionOwner = null;
          _connectionOwner = null;
          isConnecting = false;
          _syncTunnelMetricsTimer();
          notifyListeners();
        }
      }
    } on SessionOperationCancelled {
      return;
    }
  });

  Future<void> disconnect({
    bool cancelPendingConnection = true,
    bool userRequested = false,
    bool forceNativeStop = false,
  }) => ConnectionTiming.run('disconnect', () async {
    if (cancelPendingConnection) _cancelLocationChange();
    _disconnectsInFlight++;
    try {
      if (cancelPendingConnection) {
        _networkAttemptEpoch++;
        _connectionOwner = null;
        isConnecting = false;
        notifyListeners();
      }
      final SessionOperation operation = _sessionOperation;
      if (!operation.isCurrent) return;
      try {
        if (tunnelState.phase == VpnRuntimePhase.idle && !forceNativeStop) {
          return;
        }
        final VpnProtocol? stoppingProtocol = tunnelState.protocol;
        notice = null;
        tunnelState = VpnRuntimeState(
          phase: VpnRuntimePhase.disconnecting,
          protocol: tunnelState.protocol,
        );
        notifyListeners();
        try {
          final VpnSystemProtectionGateway? systemGateway =
              userRequested && _tunnel is VpnSystemProtectionGateway
              ? _tunnel as VpnSystemProtectionGateway
              : null;
          if (systemGateway == null) {
            await _tunnel.disconnect().timeout(const Duration(seconds: 15));
          } else {
            await systemGateway.disconnectByUser().timeout(
              const Duration(seconds: 15),
            );
          }
          operation.check();
          if (systemGateway == null) {
            tunnelState = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
          } else {
            final VpnRuntimeState snapshot = await _tunnel.getState().timeout(
              const Duration(seconds: 5),
            );
            operation.check();
            tunnelState = snapshot;
          }
        } on TimeoutException {
          operation.check();
          tunnelState = const VpnRuntimeState(
            phase: VpnRuntimePhase.error,
            messageCode: 'tunnel_stop_timeout',
          );
          notice = _controllerNotice(
            'flutter_disconnect_timeout',
            diagnosticCode: 'VPN-STOP · flutter_disconnect_timeout',
          );
        } on NativeVpnException catch (error) {
          operation.check();
          tunnelState = VpnRuntimeState(
            phase: VpnRuntimePhase.error,
            protocol: stoppingProtocol,
            messageCode: error.code,
          );
          notice = _nativeNotice(error.code, protocol: stoppingProtocol);
        } catch (_) {
          operation.check();
          tunnelState = VpnRuntimeState(
            phase: VpnRuntimePhase.error,
            protocol: stoppingProtocol,
            messageCode: 'flutter_disconnect_unexpected',
          );
          notice = _controllerNotice(
            'flutter_disconnect_unexpected',
            diagnosticCode: 'APP-STOP · flutter_disconnect_unexpected',
          );
        }
        _syncTunnelMetricsTimer();
        notifyListeners();
      } on SessionOperationCancelled {
        return;
      }
    } finally {
      _disconnectsInFlight--;
      notifyListeners();
    }
  });

  /// Cancels local preparation and asks native code to confirm a stop even
  /// before Flutter has observed a tunnel state. Accepted remote migrations
  /// remain tracked, but can never continue this cancelled tunnel attempt.
  Future<void> cancelConnectionAttempt() async {
    if (!canCancelConnectionAttempt) return;
    await disconnect(forceNativeStop: true);
  }

  /// The visible Disconnect control respects Android's system-owned
  /// always-on/lockdown setting. Internal disconnects (server changes,
  /// cleanup, logout) intentionally continue to call [disconnect] directly.
  Future<void> requestUserDisconnect() async {
    // Revoke automatic restart before even waiting for Android's settings read.
    _cancelLocationChange();
    final SessionOperation operation = _sessionOperation;
    if (supportsSystemProtectionSettings) {
      await refreshSystemProtection(notify: false);
      if (!operation.isCurrent) return;
      final SystemVpnProtection protection = systemProtection;
      if (protection.alwaysOn != false) {
        await openSystemVpnSettings();
        return;
      }
      await disconnect(userRequested: true);
      return;
    }
    await disconnect();
  }

  Future<void> _prepareTunnelRequest(String accountId) =>
      ConnectionTiming.measure('prepare.native', () async {
        final VpnSystemProtectionGateway? gateway =
            _tunnel is VpnSystemProtectionGateway
            ? _tunnel as VpnSystemProtectionGateway
            : null;
        if (gateway != null) {
          await gateway.prepareTunnelRequest(accountId: accountId);
        }
      });

  Future<void> openSystemVpnSettings() async {
    final VpnSystemProtectionGateway? gateway =
        _tunnel is VpnSystemProtectionGateway
        ? _tunnel as VpnSystemProtectionGateway
        : null;
    if (gateway == null) return;
    try {
      await gateway.openVpnSettings();
    } catch (_) {
      // Android Settings is an optional handoff. Its availability must not
      // alter the live tunnel state or show a misleading protection status.
    }
  }

  /// Called when this app returns from Android Settings. This performs only a
  /// local platform read; it never connects or calls the control-plane API.
  Future<void> refreshSystemProtection({bool notify = true}) async {
    final VpnSystemProtectionGateway? gateway =
        _tunnel is VpnSystemProtectionGateway
        ? _tunnel as VpnSystemProtectionGateway
        : null;
    if (gateway == null) return;
    try {
      final SystemVpnProtection protection = await gateway
          .getSystemVpnProtection();
      if (_disposed) return;
      tunnelState = tunnelState.copyWith(systemProtection: protection);
      if (notify) notifyListeners();
    } catch (_) {
      if (_disposed) return;
      tunnelState = tunnelState.copyWith(
        systemProtection: const SystemVpnProtection(),
      );
      if (notify) notifyListeners();
    }
  }

  void onAppPaused() => _billing.onAppPaused();

  Future<void> onAppResumed() async {
    if (profile?.isGuest == true || profile?.profileRedacted == true) {
      if (_session?.expiresAt.isAfter(DateTime.now()) == false) {
        await _renewGuestSession();
      } else {
        await refreshGuestAccount();
      }
    } else if (_guestRecoveryDeferred &&
        profile == null &&
        !isInitializing &&
        !isGuestActionBusy) {
      await _resumeGuestSession(_sessionOperation, previous: _session);
      notifyListeners();
    } else if (_session == null && !isInitializing && !isGuestActionBusy) {
      await _resumeGuestSession(_sessionOperation);
    }
    unawaited(_billing.onAppResumed());
    await refreshSystemProtection();
    _syncDiagnosticSession();
    await _diagnostics?.retryPending();
  }

  Future<bool> revokeDevice(VpnDevice device) =>
      _revokeDeviceById(device.deviceId);

  Future<bool> _revokeDeviceById(String deviceId) async {
    final SessionOperation operation = _sessionOperation;
    if (!operation.isCurrent) return false;
    try {
      final UserProfile? activeProfile = profile;
      final String? activeToken = token;
      if (!isSignedIn ||
          activeProfile == null ||
          activeToken == null ||
          isRevoking ||
          isChangingLocation ||
          isConnecting ||
          isIdentityBusy) {
        return false;
      }
      final Object owner = Object();
      _identityMutationOwner = owner;
      isRevoking = true;
      notice = null;
      notifyListeners();
      try {
        final bool revokingCurrent = deviceId == currentDeviceId;
        final _IdentityOperation? target = revokingCurrent
            ? _identityScope(deviceId)
            : null;
        if (revokingCurrent) {
          await disconnect();
          operation.check();
          target!.check();
        }
        await _api.revokeDevice(token: activeToken, deviceId: deviceId);
        operation.check();
        target?.check();
        if (revokingCurrent) {
          await _tunnel.clearAccountIdentity(
            accountId: activeProfile.userId,
            expectedDeviceId: deviceId,
          );
          operation.check();
          target!.check();
          await _sessionWrite(
            operation,
            () => _sessionStore.clearCurrentDeviceId(
              userId: activeProfile.userId,
            ),
            identityContext: target,
          );
          operation.check();
          target.check();
          await _sessionWrite(
            operation,
            () => _sessionStore.clearLocationMigration(
              userId: activeProfile.userId,
              deviceId: deviceId,
            ),
            identityContext: target,
          );
          operation.check();
          target.check();
          currentDeviceId = null;
          _resetMigration();
        }
        await refreshDevices();
        operation.check();
        notice = _controllerNotice('device_revoked');
        return true;
      } on SessionOperationCancelled {
        return false;
      } on ApiFailure catch (error) {
        operation.check();
        await _handleSessionFailure(error, operation);
        operation.check();
        _setNotice(ApiErrorMessages.fromFailure(error));
        return false;
      } catch (_) {
        operation.check();
        notice = _controllerNotice(
          'revoke_unexpected',
          diagnosticCode: 'APP-DEVICE · revoke_unexpected',
        );
        return false;
      } finally {
        if (identical(_identityMutationOwner, owner)) {
          _identityMutationOwner = null;
        }
        if (operation.isCurrent) {
          isRevoking = false;
          notifyListeners();
        }
      }
    } on SessionOperationCancelled {
      return false;
    }
  }

  Future<void> resetRevokedIdentity() async {
    final SessionOperation operation = _sessionOperation;
    if (!operation.isCurrent ||
        isConnecting ||
        isIdentityBusy ||
        isChangingLocation) {
      return;
    }
    final Object owner = Object();
    _identityMutationOwner = owner;
    try {
      final UserProfile? activeProfile = profile;
      if (!isSignedIn || activeProfile == null) return;
      final String? deviceId = currentDeviceId;
      final _IdentityOperation target = _identityScope(deviceId);
      await disconnect();
      operation.check();
      target.check();
      try {
        await _tunnel.clearAccountIdentity(
          accountId: activeProfile.userId,
          expectedDeviceId: deviceId,
        );
        operation.check();
        target.check();
        await _sessionWrite(
          operation,
          () =>
              _sessionStore.clearCurrentDeviceId(userId: activeProfile.userId),
          identityContext: target,
        );
        operation.check();
        target.check();
        if (deviceId != null) {
          await _sessionWrite(
            operation,
            () => _sessionStore.clearLocationMigration(
              userId: activeProfile.userId,
              deviceId: deviceId,
            ),
            identityContext: target,
          );
          operation.check();
          target.check();
        }
        currentDeviceId = null;
        _resetMigration();
        notice = null;
        if (identical(_identityMutationOwner, owner)) {
          _identityMutationOwner = null;
        }
        await connect();
        operation.check();
      } on SessionOperationCancelled {
        rethrow;
      } catch (_) {
        operation.check();
        notice = _controllerNotice(
          'identity_renewal_unexpected',
          diagnosticCode: 'APP-IDENTITY · identity_renewal_unexpected',
        );
        notifyListeners();
      }
    } on SessionOperationCancelled {
      return;
    } finally {
      if (identical(_identityMutationOwner, owner)) {
        _identityMutationOwner = null;
        if (operation.isCurrent) notifyListeners();
      }
    }
  }

  Future<void> _replaceRevokedLocalIdentity(
    String userId, {
    _MigrationContext? migrationContext,
    required IpActivationAttempt networkAttempt,
  }) async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final String? deviceId = currentDeviceId;
    final _IdentityOperation target = _identityScope(deviceId);
    await _tunnel.clearAccountIdentity(
      accountId: userId,
      expectedDeviceId: deviceId,
    );
    operation.check();
    target.check();
    networkAttempt.check();
    migrationContext?.check();
    await _sessionWrite(
      operation,
      () => _sessionStore.clearCurrentDeviceId(userId: userId),
      migrationContext: migrationContext,
      identityContext: target,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    if (deviceId != null) {
      await _sessionWrite(
        operation,
        () => _sessionStore.clearLocationMigration(
          userId: userId,
          deviceId: deviceId,
        ),
        migrationContext: migrationContext,
        identityContext: target,
      );
      operation.check();
      networkAttempt.check();
      migrationContext?.check();
    }
    currentDeviceId = null;
    networkAttempt.deviceId = null;
    networkAttempt.deviceEpoch = _deviceEpoch;
    _resetMigration();
    notice = null;
  }

  Future<void> renewOpenVpnProfile() => ConnectionTiming.run(
    'renewal',
    () async {
      final SessionOperation operation = _sessionOperation;
      if (!operation.isCurrent ||
          isChangingLocation ||
          isConnecting ||
          isIdentityBusy ||
          openVpnRevocation != null) {
        return;
      }
      try {
        final UserProfile? activeProfile = profile;
        final String? activeToken = token;
        final String? deviceId = currentDeviceId;
        final Location? location = activeDeviceLocation ?? selectedLocation;
        if (!isSignedIn ||
            activeProfile == null ||
            activeToken == null ||
            deviceId == null ||
            location == null) {
          return;
        }
        final context = _identityScope(deviceId);
        final Object owner = _beginConnectionWork();
        final networkAttempt = _networkAttempt();
        notice = null;
        notifyListeners();
        try {
          await _prepareTunnelRequest(activeProfile.userId);
          operation.check();
          networkAttempt.check();
          await _refreshIpCapability(networkAttempt, location.id);
          networkAttempt.check();
          await _stopActiveTunnelBeforeChange();
          operation.check();
          networkAttempt.check();
          context.check();
          final bool permissionGranted = await ConnectionTiming.measure(
            'permission.android',
            _tunnel.requestVpnPermission,
          );
          operation.check();
          networkAttempt.check();
          context.check();
          if (!permissionGranted) {
            throw const _ControllerFailure('vpn_permission_denied');
          }
          final String csr = await _tunnel.getOrCreateOpenVpnCsr(
            accountId: activeProfile.userId,
            deviceId: deviceId,
            renewal: true,
          );
          operation.check();
          networkAttempt.check();
          context.check();
          final OpenVpnActivation activation = await _requestOpenVpnActivation(
            context: context,
            accountId: activeProfile.userId,
            deviceId: deviceId,
            activeToken: activeToken,
            csr: csr,
            renewal: true,
            networkAttempt: networkAttempt,
          );
          operation.check();
          networkAttempt.check();
          context.check();
          networkAttempt.check();
          _showIpv4Fallback(networkAttempt, activation.network);
          await _tunnel.connectOpenVpn(
            accountId: activeProfile.userId,
            activation: activation,
            location: location,
            renewal: true,
          );
          operation.check();
          networkAttempt.check();
          context.check();
        } on _OpenVpnRevocationHandled {
          // A new connection is explicit, after confirmed cleanup.
        } on SessionOperationCancelled {
          rethrow;
        } on ApiFailure catch (error) {
          context.check();
          operation.check();
          networkAttempt.check();
          context.check();
          await _handleSessionFailure(error, operation);
          operation.check();
          networkAttempt.check();
          context.check();
          _setNotice(ApiErrorMessages.fromFailure(error));
          await _refreshAfterCapacityFailure(
            error,
            location.id,
            check: () {
              operation.check();
              networkAttempt.check();
              context.check();
            },
          );
        } on _ControllerFailure catch (failure) {
          context.check();
          operation.check();
          networkAttempt.check();
          context.check();
          notice = _controllerFailureNotice(failure);
        } catch (_) {
          context.check();
          operation.check();
          networkAttempt.check();
          context.check();
          notice = _controllerNotice(
            'openvpn_renewal_unexpected',
            diagnosticCode: 'APP-OVPN-RENEW · renewal_unexpected',
          );
        } finally {
          if (operation.isCurrent && identical(owner, _connectionOwner)) {
            _connectionOwner = null;
            isConnecting = false;
            notifyListeners();
          }
        }
      } on SessionOperationCancelled {
        return;
      }
    },
  );

  Future<void> signOut() async {
    // Local logout cannot depend on provider availability. Invalidate pending
    // Google admission immediately; private recovery tickets remain if offline.
    final googleCancellation = _googleAuth.hasPendingIntent
        ? _googleAuth.cancel()
        : Future<bool>.value(true);
    final store = _sessionStore;
    if (store is GuestCredentialStore) {
      await (store as GuestCredentialStore).writeGuestAutoResume(false);
    }
    final String? oldToken = token;
    final Future<void> ending = _terminateSession();
    unawaited(googleCancellation.then<void>((_) {}, onError: (Object _) {}));
    unawaited(_googleAuth.clearCredentialState());
    if (oldToken != null) unawaited(_logoutRemotely(oldToken));
    await ending;
    await googleCancellation;
  }

  Future<void> _logoutRemotely(String oldToken) async {
    try {
      await _api.logout(oldToken).timeout(const Duration(seconds: 20));
    } catch (_) {
      // Remote logout must never restore or modify a locally ended session.
    }
  }

  Future<void> retrySessionTermination() => _terminateSession();

  Future<void> _terminateSession({bool expired = false}) {
    _sessionExpired = _sessionExpired || expired;
    if (_terminationTask != null) return _terminationTask!;
    final Completer<void> done = Completer<void>();
    _terminationTask = done.future;
    _sessionOperation.invalidate();
    _guestActionOwner = null;
    _guestObservedAccess = null;
    _guestMessage = null;
    _guestRecoveryDeferred = false;
    _guestRetryTimer?.cancel();
    _guestRetryTimer = null;
    _cancelLocationChange();
    _locationChangeOperation = null;
    _invalidateListRefreshes();
    _identityMutationOwner = null;
    _connectionOwner = null;
    _completedRevocations.clear();
    _revocationResult = null;
    _revocationOperation = null;
    _revocationTask = null;
    _session = null;
    _accountRestorationOwner = null;
    _pendingVerificationNeeded = null;
    profile = null;
    currentDeviceId = null;
    _resetMigration();
    deviceList = const DeviceList(limit: 2, devices: <VpnDevice>[]);
    mayNeedEmailVerification = false;
    isConnecting = false;
    isRevoking = false;
    isAuthenticating = false;
    isInitializing = false;
    isLoadingDevices = false;
    _tunnelMetricsTimer?.cancel();
    _tunnelMetricsTimer = null;
    tunnelState = VpnRuntimeState(
      phase: VpnRuntimePhase.disconnecting,
      protocol: tunnelState.protocol,
      messageCode: 'session_ending',
    );
    notice = null;
    sessionTermination = SessionTerminationResult(
      tunnelStopped: false,
      sessionCleared: false,
      inProgress: true,
      sessionExpired: _sessionExpired,
    );
    notifyListeners();
    unawaited(_finishSessionTermination(done));
    return done.future;
  }

  Future<void> _finishSessionTermination(Completer<void> done) async {
    try {
      // Drain submitted writes, but never wait for pending API requests.
      await _sessionWrites;
      final SessionTerminationResult result = await _sessionStore.clearSession(
        expired: _sessionExpired,
      );
      if (_disposed) return;
      sessionTermination = result.isComplete ? null : result;
      tunnelState = VpnRuntimeState(
        phase: result.tunnelStopped
            ? VpnRuntimePhase.idle
            : VpnRuntimePhase.error,
        protocol: result.tunnelStopped ? null : tunnelState.protocol,
        messageCode: result.stopError,
      );
      if (result.isComplete && _sessionExpired) {
        _showSessionExpiredNotice();
      }
    } catch (_) {
      if (!_disposed) {
        sessionTermination = const SessionTerminationResult(
          tunnelStopped: false,
          sessionCleared: false,
          stopError: 'session_termination_unconfirmed',
          storageError: 'secure_storage_write_failed',
        );
      }
    } finally {
      _terminationTask = null;
      done.complete();
      if (!_disposed) notifyListeners();
    }
  }

  void clearNotice() {
    notice = null;
    notifyListeners();
  }

  Future<void> _handleInitialSessionWriteFailure(
    NativeVpnException error,
  ) async {
    // A failed commit may have left native session material behind. Reuse the
    // confirmed stop/erase transition before admitting another login.
    await _terminateSession();
    if (!_disposed && sessionTermination == null && _session == null) {
      notice = _nativeNotice(error.code);
      notifyListeners();
    }
  }

  Future<bool> _setSession(
    AuthSession session, {
    required bool verificationNeeded,
    bool Function()? authorizationCurrent,
  }) async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    void checkAuthorization() {
      if (authorizationCurrent?.call() == false) {
        throw const SessionOperationCancelled();
      }
    }

    checkAuthorization();
    await _sessionWrite(operation, () {
      checkAuthorization();
      return _sessionStore.writeSession(session);
    });
    operation.check();
    checkAuthorization();
    _session = session;
    _pendingVerificationNeeded = verificationNeeded;
    return _restoreAccount(
      verificationNeeded: verificationNeeded,
      notify: false,
      authorizationCurrent: authorizationCurrent,
    );
  }

  Future<void> retryAccountRestoration() async {
    if (!hasPendingAccountRestoration ||
        isRestoringAccount ||
        !_sessionOperation.isCurrent) {
      return;
    }
    notice = null;
    try {
      if (_guestRecoveryDeferred) {
        await _resumeGuestSession(_sessionOperation, previous: _session);
        notifyListeners();
        return;
      }
      await _restoreAccount(verificationNeeded: _pendingVerificationNeeded);
    } on SessionOperationCancelled {
      // Logout or another account owns the UI now.
    }
  }

  Future<bool> _restoreAccount({
    bool? verificationNeeded,
    bool notify = true,
    String? expectedUserId,
    bool Function()? authorizationCurrent,
  }) async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    final AuthSession? session = _session;
    if (session == null || isRestoringAccount) return false;
    if (!session.expiresAt.isAfter(DateTime.now())) {
      await _terminateSession(expired: true);
      return false;
    }
    final Object owner = Object();
    final int deviceEpoch = _deviceEpoch;
    _accountRestorationOwner = owner;
    profile = null;
    _resetMigration();
    if (notify) notifyListeners();
    void check() {
      operation.check();
      if (!identical(_accountRestorationOwner, owner) ||
          authorizationCurrent?.call() == false ||
          !identical(_session, session) ||
          _deviceEpoch != deviceEpoch) {
        throw const SessionOperationCancelled();
      }
    }

    try {
      final UserProfile restoredProfile = await _api.me(session.accessToken);
      check();
      if (expectedUserId != null && restoredProfile.userId != expectedUserId) {
        throw const NativeVpnException('invalid_arguments');
      }
      await _sessionWrite(operation, () {
        check();
        return _sessionStore.writeSession(
          session,
          userId: restoredProfile.userId,
        );
      });
      check();
      final String? restoredDevice = await _sessionStore.readCurrentDeviceId(
        userId: restoredProfile.userId,
      );
      check();
      final OpenVpnRevocationResult? revocation = restoredDevice == null
          ? null
          : await _tunnel.getOpenVpnRevocation(
              accountId: restoredProfile.userId,
              deviceId: restoredDevice,
            );
      check();
      if (revocation != null &&
          (revocation.accountId != restoredProfile.userId ||
              revocation.deviceId != restoredDevice)) {
        throw const NativeVpnException('invalid_arguments');
      }
      final bool restoredVerification =
          verificationNeeded ??
          ((await _safe<bool?>(
                _preferences.readVerificationNeeded(
                  userId: restoredProfile.userId,
                ),
              )) ??
              false);
      check();
      if (verificationNeeded != null) {
        await _sessionWrite(operation, () {
          check();
          return _preferences.writeVerificationNeeded(
            userId: restoredProfile.userId,
            value: verificationNeeded,
          );
        });
        check();
      }
      DeviceList restoredDevices = const DeviceList(limit: 2, devices: []);
      final int devicesGeneration = ++_devicesRefreshGeneration;
      isLoadingDevices = true;
      try {
        restoredDevices = await _api.listDevices(session.accessToken);
        check();
      } on ApiFailure catch (error) {
        check();
        await _handleSessionFailure(error, operation);
        check();
        // Device metadata can be refreshed later; secure admission below is
        // still required before publishing a usable account.
        if (devicesGeneration == _devicesRefreshGeneration) {
          _setNotice(ApiErrorMessages.fromFailure(error));
        }
      } finally {
        if (operation.isCurrent &&
            devicesGeneration == _devicesRefreshGeneration) {
          isLoadingDevices = false;
        }
      }
      DeviceLocationMigration? migration;
      if (restoredDevice != null) {
        try {
          migration = await _sessionStore.readLocationMigration(
            userId: restoredProfile.userId,
            deviceId: restoredDevice,
          );
          check();
          if (migration != null && migration.deviceId != restoredDevice) {
            throw const CorruptLocationMigration();
          }
        } on CorruptLocationMigration {
          check();
          await _sessionWrite(operation, () {
            check();
            return _sessionStore.clearLocationMigration(
              userId: restoredProfile.userId,
              deviceId: restoredDevice,
            );
          });
          check();
          migration = null;
        }
      }
      check();
      // Publish one coherent account only after secure binding and all local
      // admission records have been read. The pending page keeps VPN controls.
      profile = restoredProfile;
      currentDeviceId = restoredDevice;
      if (devicesGeneration == _devicesRefreshGeneration) {
        deviceList = restoredDevices;
      }
      mayNeedEmailVerification = restoredVerification;
      _pendingVerificationNeeded = null;
      if (restoredDevice != null) {
        _revocationOperation = _identityScope(restoredDevice);
        _revocationResult =
            revocation?.isComplete == true || revocation?.stale == true
            ? null
            : revocation;
      }
      final _MigrationContext context = _migrationScope();
      context.value = migration;
      if (migration?.status.isPending == true &&
          !isConnecting &&
          !isIdentityBusy) {
        unawaited(_followLocationMigration(context, refreshFirst: false));
      }
      return true;
    } on ApiFailure catch (error) {
      check();
      if (expectedUserId == null &&
          !_guestResuming &&
          (error.statusCode == 401 || error.code == 'unauthorized') &&
          _guestStore != null &&
          await _safe<bool>(_guestStore!.readGuestAutoResume()) == true) {
        operation.check();
        // The cached token may have been revoked before its local expiry.
        // Release restoration ownership before reentering it with the same
        // durable guest credential and native device binding.
        _accountRestorationOwner = null;
        if (await _resumeGuestSession(operation, previous: session)) {
          return true;
        }
        operation.check();
        if (_guestRecoveryDeferred) {
          _session = session;
          notice = const AppNotice(
            titleKey: 'billing.title',
            messageKey: 'guest.serviceUnavailable',
          );
          return false;
        }
        await _terminateSession(expired: true);
        return false;
      }
      await _handleSessionFailure(error, operation);
      check();
      _setNotice(ApiErrorMessages.fromFailure(error));
      return false;
    } on NativeVpnException catch (error) {
      check();
      notice = _nativeNotice(error.code);
      return false;
    } finally {
      if (identical(_accountRestorationOwner, owner)) {
        _accountRestorationOwner = null;
        if (operation.isCurrent && notify) notifyListeners();
      }
    }
  }

  Future<DeviceLocationMigration?> _readLocationMigration(
    _MigrationContext context,
  ) async {
    context.check();
    final String? deviceId = context.deviceId;
    if (deviceId == null) return null;
    try {
      final DeviceLocationMigration? saved = await _sessionStore
          .readLocationMigration(userId: context.userId, deviceId: deviceId);
      context.check();
      if (saved != null && saved.deviceId != deviceId) {
        throw const CorruptLocationMigration();
      }
      return saved;
    } on CorruptLocationMigration {
      context.check();
      await _clearStoredMigration(context);
      context.check();
      return null;
    } catch (_) {
      context.check();
      rethrow;
    }
  }

  Future<void> _followLocationMigration(
    _MigrationContext context, {
    required bool refreshFirst,
  }) async {
    Object? owner;
    try {
      context.check();
      final DeviceLocationMigration? saved = context.value;
      if (saved == null || isConnecting || isIdentityBusy) return;
      owner = _beginConnectionWork();
      context.connectionOwner = owner;
      notice = null;
      notifyListeners();
      try {
        await _stopActiveTunnelBeforeChange();
        context.check();
        final DeviceLocationMigration current = refreshFirst
            ? await _pollLocationMigration(context, saved)
            : saved;
        context.check();
        await _waitForLocationMigration(context, current);
        context.check();
      } on SessionOperationCancelled {
        rethrow;
      } on ApiFailure catch (error) {
        context.check();
        await _handleSessionFailure(error, context.session);
        context.check();
        _setNotice(ApiErrorMessages.fromFailure(error));
        await _refreshAfterCapacityFailure(
          error,
          saved.targetLocationId,
          check: context.check,
        );
      } on _ControllerFailure catch (failure) {
        context.check();
        notice = _controllerFailureNotice(failure);
      } on NativeVpnException catch (error) {
        context.check();
        notice = _nativeNotice(error.code);
      } catch (_) {
        context.check();
        notice = _controllerFailureNotice(
          const _ControllerFailure('location_migration_verification_failed'),
        );
      }
    } on SessionOperationCancelled {
      // The replacing account/device owns the UI and further requests.
    } finally {
      if (owner != null &&
          context.isCurrent &&
          identical(owner, _connectionOwner)) {
        _connectionOwner = null;
        context.connectionOwner = null;
        isConnecting = false;
        _syncTunnelMetricsTimer();
        notifyListeners();
      }
    }
  }

  Future<_LocationPreparation> _prepareLocationForConnection({
    required UserProfile activeProfile,
    required String token,
    required Location location,
    required VpnProtocol protocol,
  }) => ConnectionTiming.measure('prepare.location', () async {
    final _MigrationContext context = _migrationScope();
    context.check();
    if (context.userId != activeProfile.userId || context.token != token) {
      throw const SessionOperationCancelled();
    }
    context.connectionOwner = _connectionOwner;
    try {
      final DeviceList snapshot = await _refreshDevicesForConnection(
        token,
        migrationContext: context,
      );
      context.check();
      if (context.deviceId == null) return const _LocationPreparation.ready();
      final DeviceLocationMigration? saved =
          context.value ?? await _readLocationMigration(context);
      context.check();
      context.value = saved;
      if (saved != null) {
        _validateMigration(context, saved);
        if (saved.targetLocationId != location.id &&
            saved.status != LocationMigrationStatus.ready) {
          throw _ControllerFailure(
            'location_migration_pending',
            arguments: <String, Object?>{'target': _migrationTargetLabel()},
          );
        }
        if (saved.targetLocationId == location.id) {
          await _stopActiveTunnelBeforeChange();
          context.check();
          final DeviceLocationMigration current =
              saved.status == LocationMigrationStatus.blocked
              ? await _pollLocationMigration(context, saved)
              : saved;
          context.check();
          final bool ready = await _waitForLocationMigration(context, current);
          context.check();
          return _LocationPreparation(
            ready: ready,
            migrated: ready,
            context: ready ? context : null,
          );
        }
      }
      final VpnDevice? device = _deviceFromSnapshot(snapshot, context.deviceId);
      if (device == null ||
          device.location == null ||
          device.location!.id == location.id) {
        return const _LocationPreparation.ready();
      }
      // WireGuard keeps its direct device registration contract.
      if (protocol == VpnProtocol.wireGuard) {
        return const _LocationPreparation.ready();
      }
      final bool ready = await _migrateCurrentDeviceTo(
        context,
        location,
        saved,
      );
      context.check();
      return _LocationPreparation(
        ready: ready,
        migrated: ready,
        context: ready ? context : null,
      );
    } catch (_) {
      context.check();
      rethrow;
    } finally {
      if (context.isCurrent) context.connectionOwner = null;
    }
  });

  Future<DeviceList> _refreshDevicesForConnection(
    String activeToken, {
    _MigrationContext? migrationContext,
  }) async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    migrationContext?.check();
    final int generation = ++_devicesRefreshGeneration;
    isLoadingDevices = true;
    notifyListeners();
    try {
      final DeviceList received = await _api.listDevices(activeToken);
      operation.check();
      migrationContext?.check();
      if (generation == _devicesRefreshGeneration) deviceList = received;
      // Connection admission uses its own checked snapshot; a newer UI refresh
      // may own publication without changing this operation's input mid-flight.
      return received;
    } finally {
      if (!_disposed &&
          operation.isCurrent &&
          generation == _devicesRefreshGeneration) {
        isLoadingDevices = false;
        notifyListeners();
      }
    }
  }

  VpnDevice? _deviceFromSnapshot(DeviceList snapshot, String? deviceId) =>
      snapshot.devices.cast<VpnDevice?>().firstWhere(
        (device) => device?.deviceId == deviceId,
        orElse: () => null,
      );

  Future<bool> _migrateCurrentDeviceTo(
    _MigrationContext context,
    Location location,
    DeviceLocationMigration? saved,
  ) async {
    context.check();
    final String? deviceId = context.deviceId;
    if (deviceId == null) return true;
    await _stopActiveTunnelBeforeChange();
    context.check();
    if (saved != null && saved.targetLocationId != location.id) {
      if (saved.status != LocationMigrationStatus.ready) {
        throw _ControllerFailure(
          'location_migration_pending',
          arguments: <String, Object?>{'target': _migrationTargetLabel()},
        );
      }
      await _clearStoredMigration(context);
      context.check();
    }
    final DeviceLocationMigration migration;
    if (saved != null && saved.targetLocationId == location.id) {
      migration = saved;
    } else {
      // The POST can be accepted after the local connection is cancelled.
      // Keep its account/device ownership separate from the continuation.
      _migrationStartRequest = context;
      notifyListeners();
      try {
        migration = await _api.startLocationMigration(
          token: context.token,
          deviceId: deviceId,
          locationId: location.id,
        );
        await _retainAcceptedMigration(context, migration, location.id);
      } finally {
        if (identical(_migrationStartRequest, context)) {
          _migrationStartRequest = null;
          notifyListeners();
        }
      }
    }
    context.check();
    _validateMigration(context, migration, targetLocationId: location.id);
    return _waitForLocationMigration(context, migration);
  }

  /// Executes the documented WireGuard transition for a logical device whose
  /// OpenVPN profile locks its location. Server revocation is completed first;
  /// only then is the matching local OpenVPN identity removed. The WireGuard
  /// key, logical device id and account session are deliberately untouched.
  Future<void> _releaseOpenVpnForWireGuard({
    required UserProfile activeProfile,
    required String token,
    _MigrationContext? migrationContext,
  }) async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    migrationContext?.check();
    final String? deviceId = currentDeviceId;
    if (deviceId == null) {
      throw const _ControllerFailure('invalid_device');
    }
    await _api.revokeOpenVpnProfile(token: token, deviceId: deviceId);
    operation.check();
    migrationContext?.check();
    await _tunnel.clearOpenVpnIdentity(
      accountId: activeProfile.userId,
      deviceId: deviceId,
    );
    operation.check();
    migrationContext?.check();
  }

  void _validateMigration(
    _MigrationContext context,
    DeviceLocationMigration value, {
    DeviceLocationMigration? expected,
    String? targetLocationId,
    bool checkContinuation = true,
  }) {
    if (checkContinuation) {
      context.check();
    } else {
      context.checkAccount();
    }
    if (context.deviceId == null ||
        value.deviceId != context.deviceId ||
        (targetLocationId != null &&
            value.targetLocationId != targetLocationId) ||
        (expected != null &&
            (value.migrationId != expected.migrationId ||
                value.targetLocationId != expected.targetLocationId ||
                value.sourceLocationId != expected.sourceLocationId))) {
      throw const _ControllerFailure('location_migration_conflict');
    }
  }

  Future<void> _retainAcceptedMigration(
    _MigrationContext context,
    DeviceLocationMigration migration,
    String targetLocationId,
  ) async {
    _validateMigration(
      context,
      migration,
      targetLocationId: targetLocationId,
      checkContinuation: false,
    );
    // Publish before writing so a storage failure still leaves a resumable
    // record in this session. Rebinding never revives the cancelled owner.
    final record = context.isCurrent ? context : _migrationScope();
    record.value = migration;
    notifyListeners();
    await _sessionWrite(context.session, () {
      context.checkAccount();
      return _sessionStore.writeLocationMigration(
        userId: context.userId,
        migration: migration,
      );
    });
    context.checkAccount();
  }

  Future<DeviceLocationMigration> _pollLocationMigration(
    _MigrationContext context,
    DeviceLocationMigration previous,
  ) async {
    _validateMigration(context, previous);
    final DeviceLocationMigration received = await _api.getLocationMigration(
      token: context.token,
      deviceId: previous.deviceId,
      migrationId: previous.migrationId,
    );
    context.check();
    _validateMigration(context, received, expected: previous);
    return received;
  }

  Future<void> _clearStoredMigration(_MigrationContext context) async {
    context.check();
    final String? deviceId = context.deviceId;
    if (deviceId == null) return;
    try {
      await _sessionWrite(context.session, () {
        context.check();
        return _sessionStore.clearLocationMigration(
          userId: context.userId,
          deviceId: deviceId,
        );
      });
    } catch (_) {
      context.check();
      rethrow;
    }
    context.check();
    context.value = null;
  }

  Future<bool> _waitForLocationMigration(
    _MigrationContext context,
    DeviceLocationMigration migration,
  ) => ConnectionTiming.measure('migration.total', () async {
    _validateMigration(context, migration);
    DeviceLocationMigration current = migration;
    for (int attempt = 0; ; attempt++) {
      context.check();
      if (current.status == LocationMigrationStatus.blocked) {
        await _storeLocationMigration(context, current);
        context.check();
        notice = _controllerNotice('location_migration_blocked');
        notifyListeners();
        return false;
      }
      if (current.status == LocationMigrationStatus.ready) {
        final DeviceList snapshot = await _refreshDevicesForConnection(
          context.token,
          migrationContext: context,
        );
        context.check();
        final VpnDevice? refreshed = _deviceFromSnapshot(
          snapshot,
          context.deviceId,
        );
        if (refreshed == null ||
            refreshed.deviceId != current.deviceId ||
            refreshed.location?.id != current.targetLocationId) {
          throw const _ControllerFailure(
            'location_migration_verification_failed',
          );
        }
        await _clearStoredMigration(context);
        context.check();
        notifyListeners();
        return true;
      }
      if (attempt >= _migrationMaxPollAttempts) break;
      await _storeLocationMigration(context, current);
      context.check();
      notifyListeners();
      await ConnectionTiming.measure(
        'migration.retry_wait',
        () => context.wait(
          _migrationDelay(Duration(seconds: current.retryAfterSeconds ?? 2)),
        ),
      );
      context.check();
      current = await _pollLocationMigration(context, current);
      context.check();
    }
    await _storeLocationMigration(context, current);
    context.check();
    notice = _controllerNotice('location_migration_slow');
    notifyListeners();
    return false;
  });

  Future<void> _storeLocationMigration(
    _MigrationContext context,
    DeviceLocationMigration migration,
  ) async {
    _validateMigration(context, migration);
    await _sessionWrite(context.session, () {
      _validateMigration(context, migration);
      return _sessionStore.writeLocationMigration(
        userId: context.userId,
        migration: migration,
      );
    });
    context.check();
    context.value = migration;
  }

  Future<void> _connectWireGuard(
    UserProfile activeProfile,
    String activeToken,
    Location location, {
    required IpActivationAttempt networkAttempt,
    String? expectedDeviceId,
    _MigrationContext? migrationContext,
  }) => ConnectionTiming.measure('wireguard.prepare_connect', () async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final String publicKey = await _tunnel.getOrCreateWireGuardPublicKey(
      accountId: activeProfile.userId,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final DeviceConfiguration configuration = await networkAttempt.request(
      (ipv6) => _api.registerDevice(
        token: activeToken,
        name: 'FuzeVPN — Android',
        publicKey: publicKey,
        locationId: location.id,
        requestIpv6: ipv6,
      ),
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    if (expectedDeviceId != null &&
        configuration.deviceId != expectedDeviceId) {
      throw const _ControllerFailure('location_migration_device_changed');
    }
    await _rememberDevice(
      activeProfile.userId,
      configuration.deviceId,
      networkAttempt: networkAttempt,
      migrationContext: migrationContext,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    mayNeedEmailVerification = false;
    await _sessionWrite(operation, () {
      networkAttempt.check();
      return _preferences.writeVerificationNeeded(
        userId: activeProfile.userId,
        value: false,
      );
    }, migrationContext: migrationContext);
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    networkAttempt.check();
    _showIpv4Fallback(networkAttempt, configuration.network);
    await _tunnel.connectWireGuard(
      accountId: activeProfile.userId,
      configuration: configuration,
      location: location,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
  });

  Future<void> _connectOpenVpn(
    UserProfile activeProfile,
    String activeToken,
    Location location, {
    required IpActivationAttempt networkAttempt,
    String? expectedDeviceId,
    _MigrationContext? migrationContext,
    bool preserveExistingCertificate = false,
  }) => ConnectionTiming.measure('openvpn.prepare_connect', () async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final String deviceId = await _ensureLogicalDevice(
      activeProfile: activeProfile,
      token: activeToken,
      location: location,
      networkAttempt: networkAttempt,
      expectedDeviceId: expectedDeviceId,
      migrationContext: migrationContext,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final context = _identityScope(
      deviceId,
      migrationContext: migrationContext,
    );
    try {
      final OpenVpnCertificateStatus certificateStatus = await _tunnel
          .getOpenVpnCertificateStatus(
            accountId: activeProfile.userId,
            deviceId: deviceId,
          );
      operation.check();
      networkAttempt.check();
      migrationContext?.check();
      context.check();
      networkAttempt.check();
      final bool renewal = certificateStatus.requiresRenewal;
      final String csr = await _tunnel.getOrCreateOpenVpnCsr(
        accountId: activeProfile.userId,
        deviceId: deviceId,
        renewal: renewal,
      );
      operation.check();
      networkAttempt.check();
      migrationContext?.check();
      context.check();
      final OpenVpnActivation activation = await _requestOpenVpnActivation(
        context: context,
        accountId: activeProfile.userId,
        deviceId: deviceId,
        activeToken: activeToken,
        csr: csr,
        renewal: renewal,
        networkAttempt: networkAttempt,
      );
      operation.check();
      networkAttempt.check();
      migrationContext?.check();
      context.check();
      networkAttempt.check();
      _showIpv4Fallback(networkAttempt, activation.network);
      mayNeedEmailVerification = false;
      await _sessionWrite(
        operation,
        () {
          networkAttempt.check();
          return _preferences.writeVerificationNeeded(
            userId: activeProfile.userId,
            value: false,
          );
        },
        migrationContext: migrationContext,
        identityContext: context,
      );
      operation.check();
      networkAttempt.check();
      migrationContext?.check();
      context.check();
      networkAttempt.check();
      await _tunnel.connectOpenVpn(
        accountId: activeProfile.userId,
        activation: activation,
        location: location,
        preserveExistingCertificate: preserveExistingCertificate,
        renewal: renewal,
      );
      operation.check();
      networkAttempt.check();
      migrationContext?.check();
      context.check();
    } catch (_) {
      context.check();
      rethrow;
    }
  });

  Future<String> _ensureLogicalDevice({
    required UserProfile activeProfile,
    required String token,
    required Location location,
    required IpActivationAttempt networkAttempt,
    String? expectedDeviceId,
    _MigrationContext? migrationContext,
  }) => ConnectionTiming.measure('device.ensure', () async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final String publicKey = await _tunnel.getOrCreateWireGuardPublicKey(
      accountId: activeProfile.userId,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    final DeviceConfiguration configuration = await networkAttempt.request(
      (ipv6) => _api.registerDevice(
        token: token,
        name: 'FuzeVPN — Android',
        publicKey: publicKey,
        locationId: location.id,
        requestIpv6: ipv6,
      ),
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    if (expectedDeviceId != null &&
        configuration.deviceId != expectedDeviceId) {
      throw const _ControllerFailure('location_migration_device_changed');
    }
    await _rememberDevice(
      activeProfile.userId,
      configuration.deviceId,
      networkAttempt: networkAttempt,
      migrationContext: migrationContext,
    );
    operation.check();
    networkAttempt.check();
    migrationContext?.check();
    return configuration.deviceId;
  });

  Future<void> _rememberDevice(
    String userId,
    String deviceId, {
    IpActivationAttempt? networkAttempt,
    _MigrationContext? migrationContext,
  }) async {
    final SessionOperation operation = _sessionOperation;
    operation.check();
    migrationContext?.check();
    networkAttempt?.check();
    currentDeviceId = deviceId;
    networkAttempt?.deviceId = currentDeviceId;
    networkAttempt?.deviceEpoch = _deviceEpoch;
    await _sessionWrite(operation, () {
      networkAttempt?.check();
      return _sessionStore.writeCurrentDeviceId(
        userId: userId,
        deviceId: deviceId,
      );
    }, migrationContext: migrationContext);
    operation.check();
    migrationContext?.check();
    networkAttempt?.check();
  }

  Future<void> _stopActiveTunnelBeforeChange() => ConnectionTiming.measure(
    'tunnel.stop_previous',
    () async {
      final SessionOperation operation = _sessionOperation;
      operation.check();
      final VpnRuntimePhase current = tunnelState.phase;
      if (current == VpnRuntimePhase.idle || current == VpnRuntimePhase.error) {
        return;
      }
      await disconnect(cancelPendingConnection: false);
      operation.check();
      if (tunnelState.phase != VpnRuntimePhase.idle) {
        throw const _ControllerFailure('tunnel_stop_failed');
      }
    },
  );

  void _onTunnelState(VpnRuntimeState state) {
    if (_disposed) return;
    _recordDiagnosticState(state);
    final cleanup = state.openVpnRevocation;
    if (cleanup != null &&
        cleanup.accountId == profile?.userId &&
        cleanup.deviceId == currentDeviceId &&
        !_completedRevocations.contains(
          '${cleanup.accountId}/${cleanup.deviceId}/${cleanup.csrSha256}',
        )) {
      if (cleanup.isComplete || cleanup.stale) {
        _completedRevocations.add(
          '${cleanup.accountId}/${cleanup.deviceId}/${cleanup.csrSha256}',
        );
        _revocationResult = null;
      } else {
        _revocationOperation = _identityScope(cleanup.deviceId);
        _revocationResult = cleanup;
      }
    }
    _sessionExpired =
        _sessionExpired || (state.sessionTermination?.sessionExpired ?? false);
    if (state.sessionTermination != null &&
        !state.sessionTermination!.isComplete) {
      sessionTermination = state.sessionTermination;
    }
    if (sessionTermination != null) {
      notifyListeners();
      return;
    }
    tunnelState = state;
    _syncTunnelMetricsTimer();
    if (state.phase == VpnRuntimePhase.error && state.messageCode != null) {
      notice ??= _nativeNotice(
        state.messageCode!,
        protocol: state.protocol,
        record: false,
      );
    }
    notifyListeners();
  }

  void _syncTunnelMetricsTimer() {
    if (tunnelState.phase != VpnRuntimePhase.connected) {
      _tunnelMetricsTimer?.cancel();
      _tunnelMetricsTimer = null;
      return;
    }
    _tunnelMetricsTimer ??= Timer.periodic(
      const Duration(seconds: 1),
      (_) => _refreshTunnelMetrics(),
    );
  }

  Future<void> _refreshTunnelMetrics() async {
    if (isConnecting ||
        _tunnelMetricsRefreshInFlight ||
        tunnelState.phase != VpnRuntimePhase.connected) {
      return;
    }
    _tunnelMetricsRefreshInFlight = true;
    final VpnRuntimeState requestedFor = tunnelState;
    try {
      final VpnRuntimeState refreshed = await _tunnel.getState();
      if (identical(tunnelState, requestedFor)) {
        _onTunnelState(refreshed);
      }
    } catch (_) {
      // Statistics are informative only. Never tear down a proven tunnel or
      // replace its precise state because one metrics sample was unavailable.
    } finally {
      _tunnelMetricsRefreshInFlight = false;
    }
  }

  AppNotice _nativeNotice(
    String code, {
    VpnProtocol? protocol,
    bool record = true,
  }) {
    if (record) _recordDiagnosticError(code, protocol: protocol);
    final String localizationCode = _nativeLocalizationCode(code);
    return AppNotice(
      titleKey: 'notice.native.title',
      messageKey: 'notice.native.message',
      arguments: <String, Object?>{
        'code': localizationCode,
        'protocol': _protocolName(protocol),
      },
      diagnosticCode: '${_diagnosticStage(code, protocol)} · $code',
    );
  }

  String _nativeLocalizationCode(String code) => switch (code) {
    'openvpn_activation_invalid' ||
    'profile_rejected' ||
    'profile_too_large' ||
    'profile_invalid_encoding' ||
    'profile_forbidden_directive' ||
    'profile_missing_required_directive' ||
    'profile_invalid' ||
    'profile_invalid_remote' ||
    'profile_invalid_address' ||
    'profile_invalid_dns' ||
    'profile_invalid_cipher' ||
    'profile_invalid_ciphers' ||
    'profile_invalid_verification_name' ||
    'profile_invalid_server_name' ||
    'profile_invalid_certificate' ||
    'profile_invalid_ca' ||
    'profile_invalid_tls_crypt_v2' ||
    'profile_invalid_identity_alias' => 'openvpn_profile_rejected',
    'openvpn_certificate_identity_mismatch' ||
    'openvpn_certificate_expiry_mismatch' ||
    'openvpn_migration_certificate_mismatch' ||
    'openvpn_identity_unavailable' ||
    'openvpn_csr_required' ||
    'openvpn_renewal_not_prepared' ||
    'openvpn_renewal_state_invalid' ||
    'openvpn_external_pki_failed' => 'openvpn_identity_inconsistent',
    'openvpn_renewal_required' => 'openvpn_certificate_expired',
    'tun_failed' ||
    'tun_establish_failed' ||
    'tun_plan_rejected' ||
    'tun_establish_exception' => 'tun_configuration_rejected',
    'connection_failed' => 'openvpn_connection_failed',
    'openvpn_dynamic_challenge_required' ||
    'openvpn_proxy_credentials_required' => 'openvpn_credentials_required',
    'openvpn_relay_failed' => 'openvpn_proxy_failed',
    'account_id_required' => 'invalid_account_id',
    'activity_destroyed' => 'vpn_permission_request_interrupted',
    _ => code,
  };
  String _protocolName(VpnProtocol? protocol) => switch (protocol) {
    VpnProtocol.wireGuard => 'WireGuard',
    VpnProtocol.openVpn => 'OpenVPN',
    null => 'VPN',
  };

  String _diagnosticStage(String code, VpnProtocol? protocol) {
    if (code.startsWith('wireguard_')) {
      if (code.contains('stop')) return 'WG-STOP';
      if (code.contains('handshake')) return 'WG-HANDSHAKE';
      if (code.contains('identity') || code.contains('key')) {
        return 'WG-IDENTITY';
      }
      if (code.contains('configuration')) return 'WG-CONFIG';
      if (code.contains('service')) return 'WG-SERVICE';
      return 'WG-START';
    }
    if (code.startsWith('tun_')) return 'OVPN-TUN';
    if (code.startsWith('tls_') ||
        code == 'certificate_validation_failed' ||
        code == 'transport_failed') {
      return 'OVPN-TLS';
    }
    if (code.startsWith('profile_') ||
        code.contains('profile') ||
        code.contains('certificate') ||
        code.contains('csr') ||
        code.contains('identity')) {
      return 'OVPN-PROFILE';
    }
    if (code.startsWith('openvpn_') || code == 'connection_failed') {
      if (code.contains('stop')) return 'OVPN-STOP';
      if (code.contains('service')) return 'OVPN-SERVICE';
      return 'OVPN-CORE';
    }
    if (code.contains('permission')) return 'VPN-AUTH';
    if (code.contains('storage')) return 'VPN-STORAGE';
    if (code.contains('stop')) {
      return switch (protocol) {
        VpnProtocol.wireGuard => 'WG-STOP',
        VpnProtocol.openVpn => 'OVPN-STOP',
        null => 'VPN-STOP',
      };
    }
    if (code.contains('bridge') || code.contains('native')) {
      return 'VPN-BRIDGE';
    }
    return 'VPN-STATE';
  }

  Future<void> _handleSessionFailure(
    ApiFailure error,
    SessionOperation operation,
  ) async {
    operation.check();
    if (error.code != 'unauthorized' && error.statusCode != 401) return;
    if (profile?.isGuest == true) {
      if (await _renewGuestSession()) return;
      operation.check();
    }
    await _terminateSession(expired: true);
  }

  void _showSessionExpiredNotice() => _setNotice(
    ApiErrorMessages.fromFailure(
      const ApiException(statusCode: 401, errorCode: 'unauthorized'),
    ),
  );

  void _setNotice(ApiErrorMessage message) {
    if (message.machineCode case final String code) {
      _recordDiagnosticError(
        code,
        domain: 'api',
        httpStatus: message.httpStatus,
      );
    }
    notice = AppNotice(
      titleKey: message.titleKey,
      messageKey: message.messageKey,
      arguments: message.arguments,
      diagnosticCode: message.diagnosticCode,
    );
  }

  AppNotice _controllerNotice(
    String code, {
    Map<String, Object?> arguments = const <String, Object?>{},
    String? diagnosticCode,
  }) {
    if (diagnosticCode != null) _recordDiagnosticError(code, domain: 'client');
    return AppNotice(
      titleKey: 'notice.controller.title',
      messageKey: 'notice.controller.message',
      arguments: <String, Object?>{'code': code, ...arguments},
      diagnosticCode: diagnosticCode,
    );
  }

  AppNotice _controllerFailureNotice(_ControllerFailure failure) =>
      _controllerNotice(
        failure.code,
        arguments: failure.arguments,
        diagnosticCode: 'APP-LOGIC · ${failure.code}',
      );

  String _migrationTargetLabel() {
    final String? targetId = locationMigration?.targetLocationId;
    if (targetId == null) return '';
    return locations
            .cast<Location?>()
            .firstWhere(
              (Location? location) => location?.id == targetId,
              orElse: () => null,
            )
            ?.displayName ??
        targetId;
  }

  Future<T?> _safe<T>(Future<T> future) async {
    try {
      return await future;
    } catch (_) {
      return null;
    }
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    _billing.syncAccount();
    _syncDiagnosticSession();
    super.notifyListeners();
  }

  void _notifyDiagnosticListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _googleAuth.removeListener(_googleChanged);
    _googleAuth.dispose();
    _guestRetryTimer?.cancel();
    _billing.removeListener(_guestBillingChanged);
    _billing.dispose();
    if (_timingObserver != null) {
      ConnectionTiming.observerFactories.remove(_timingObserver);
    }
    _diagnostics?.removeListener(_diagnosticsChanged);
    _diagnostics?.dispose();
    _sessionOperation.invalidate();
    _invalidateListRefreshes();
    _resetMigration();
    _tunnelMetricsTimer?.cancel();
    _tunnelSubscription.cancel();
    super.dispose();
  }

  void _invalidateListRefreshes() {
    _locationsRefreshGeneration++;
    _capacityRejectedLocations.clear();
    _devicesRefreshGeneration++;
    isLoadingLocations = false;
    isLoadingDevices = false;
  }
}

class _OpenVpnRevocationHandled implements Exception {
  const _OpenVpnRevocationHandled();
}

class _IdentityOperation extends SessionOperation {
  _IdentityOperation(this.session, this.matches);
  final SessionOperation session;
  final bool Function() matches;
  @override
  bool get isCurrent => super.isCurrent && session.isCurrent && matches();
  @override
  void check() {
    if (!isCurrent) throw const SessionOperationCancelled();
  }
}

class _ControllerFailure implements Exception {
  const _ControllerFailure(
    this.code, {
    this.arguments = const <String, Object?>{},
  });

  final String code;
  final Map<String, Object?> arguments;
}

class _LocationPreparation {
  const _LocationPreparation({
    required this.ready,
    required this.migrated,
    this.context,
  });

  const _LocationPreparation.ready()
    : ready = true,
      migrated = false,
      context = null;

  final bool ready;
  final bool migrated;
  final _MigrationContext? context;
}

/// Ephemeral ownership only; the encrypted migration wire format is unchanged.
class _MigrationContext extends SessionOperation {
  _MigrationContext({
    required this.session,
    required this.userId,
    required this.token,
    required this.deviceId,
    required this.matchesAccount,
    required this.matches,
  });
  final SessionOperation session;
  final String userId;
  final String token;
  final String? deviceId;
  final bool Function() matchesAccount;
  final bool Function() matches;
  DeviceLocationMigration? value;
  Object? connectionOwner;

  bool get isAccountCurrent => session.isCurrent && matchesAccount();

  void checkAccount() {
    if (!isAccountCurrent) throw const SessionOperationCancelled();
  }

  @override
  bool get isCurrent => super.isCurrent && isAccountCurrent && matches();

  @override
  void check() {
    if (!isCurrent) throw const SessionOperationCancelled();
  }

  @override
  Future<void> wait(Future<void> pending) => session.wait(super.wait(pending));
}
