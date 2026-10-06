// Immutable values exchanged with the public FuzeVPN API. The activation
// and session types deliberately redact secrets in `toString`; they must not
// be sent to analytics, crash reporting, or application logs.

import 'network_configuration.dart';
export 'network_configuration.dart';

enum VpnProtocol {
  wireGuard('wireguard'),
  openVpn('openvpn');

  const VpnProtocol(this.apiValue);

  final String apiValue;

  static VpnProtocol? fromApi(String value) => switch (value) {
    'wireguard' => VpnProtocol.wireGuard,
    'openvpn' => VpnProtocol.openVpn,
    _ => null,
  };
}

/// Backward-compatible helper for code ported from the Windows application.
VpnProtocol? vpnProtocolFromApi(String value) => VpnProtocol.fromApi(value);

/// A location advertised by the server. The protocol list is authoritative:
/// an empty list means that no protocol can be offered for that location.
class Location {
  const Location({
    required this.id,
    required this.city,
    required this.countryCode,
    required this.displayName,
    this.supportedProtocols = const <VpnProtocol>{},
    this.supportsIpv6 = false,
  });

  final String id;
  final String city;
  final String countryCode;
  final String displayName;
  final Set<VpnProtocol> supportedProtocols;
  final bool supportsIpv6;

  bool supports(VpnProtocol protocol) => supportedProtocols.contains(protocol);

  factory Location.fromJson(Map<String, dynamic> json) {
    final Object? rawProtocols = json['supported_protocols'];
    final Set<VpnProtocol> protocols = <VpnProtocol>{};
    if (rawProtocols != null) {
      if (rawProtocols is! List) {
        throw const FormatException('Emplacement VPN invalide.');
      }
      for (final Object? item in rawProtocols) {
        if (item is String) {
          final VpnProtocol? protocol = VpnProtocol.fromApi(item);
          if (protocol != null) protocols.add(protocol);
        }
      }
    }
    return Location(
      id: _requiredIdentifier(json, 'id', 'Emplacement VPN invalide.'),
      city: _requiredText(json, 'city', 'Emplacement VPN invalide.'),
      countryCode: _requiredCountryCode(json, 'country_code'),
      displayName: _requiredText(
        json,
        'display_name',
        'Emplacement VPN invalide.',
      ),
      supportedProtocols: Set<VpnProtocol>.unmodifiable(protocols),
      supportsIpv6: VpnNetworkConfiguration.advertisedIpv6(
        json['supported_ip_families'],
      ),
    );
  }

  @override
  String toString() => 'Location(id: $id, displayName: $displayName)';
}

/// WireGuard configuration returned only while enrolling or updating a device.
class DeviceConfiguration {
  const DeviceConfiguration({
    required this.deviceId,
    required this.address,
    required this.dns,
    required this.serverPublicKey,
    required this.endpoint,
    required this.allowedIps,
    this.networkConfiguration,
  });

  final String deviceId;
  final String address;
  final List<String> dns;
  final String serverPublicKey;
  final String endpoint;
  final List<String> allowedIps;
  final VpnNetworkConfiguration? networkConfiguration;
  VpnNetworkConfiguration get network =>
      networkConfiguration ??
      VpnNetworkConfiguration.ipv4(address, routes: allowedIps);

  factory DeviceConfiguration.fromJson(Map<String, dynamic> json) {
    final String address = _requiredIpv4Cidr(
      json,
      'address',
      'Configuration WireGuard invalide.',
    );
    final List<String> dns = _requiredIpv4List(
      json,
      'dns',
      'Configuration WireGuard invalide.',
    );
    final network = VpnNetworkConfiguration.fromJson(json);
    final allowedIps = network.allowedIps;
    return DeviceConfiguration(
      deviceId: _requiredIdentifier(
        json,
        'device_id',
        'Configuration WireGuard invalide.',
      ),
      address: address,
      dns: List<String>.unmodifiable(dns),
      serverPublicKey: _requiredText(
        json,
        'server_public_key',
        'Configuration WireGuard invalide.',
      ),
      endpoint: _requiredText(
        json,
        'endpoint',
        'Configuration WireGuard invalide.',
      ),
      allowedIps: List<String>.unmodifiable(allowedIps),
      networkConfiguration: network,
    );
  }

  @override
  String toString() =>
      'DeviceConfiguration(deviceId: $deviceId, redacted: true)';
}

/// Clearer name for new code; retained as a type alias for the Windows model.
typedef WireGuardConfiguration = DeviceConfiguration;

/// Metadata for one profile on an account device. It never carries credentials
/// or tunnel configuration.
class VpnProfile {
  const VpnProfile({
    required this.protocol,
    required this.status,
    this.createdAt,
    this.expiresAt,
  });

  final VpnProtocol protocol;
  final String status;
  final DateTime? createdAt;
  final DateTime? expiresAt;

  factory VpnProfile.fromJson(Map<String, dynamic> json) {
    final Object? rawProtocol = json['protocol'];
    final VpnProtocol? protocol = rawProtocol is String
        ? VpnProtocol.fromApi(rawProtocol)
        : null;
    if (protocol == null) {
      throw const FormatException('Profil VPN invalide.');
    }
    final String status = _requiredText(json, 'status', 'Profil VPN invalide.');
    if (!RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(status)) {
      throw const FormatException('Profil VPN invalide.');
    }
    return VpnProfile(
      protocol: protocol,
      status: status,
      createdAt: _optionalDateTime(json['created_at'], 'Profil VPN invalide.'),
      expiresAt: _optionalDateTime(json['expires_at'], 'Profil VPN invalide.'),
    );
  }

  @override
  String toString() =>
      'VpnProfile(protocol: ${protocol.apiValue}, status: $status)';
}

/// A logical account device, without VPN keys, certificates, endpoints or
/// assigned tunnel addresses.
class VpnDevice {
  const VpnDevice({
    required this.deviceId,
    required this.name,
    required this.location,
    required this.createdAt,
    this.profiles = const <VpnProfile>[],
  });

  final String deviceId;
  final String name;

  /// Null for account devices whose service selects a location per session,
  /// such as the browser proxy extension.
  final Location? location;
  final DateTime? createdAt;
  final List<VpnProfile> profiles;

  factory VpnDevice.fromJson(Map<String, dynamic> json) {
    final Object? rawLocation = json['location'];
    if (rawLocation != null && rawLocation is! Map<String, dynamic>) {
      throw const FormatException('Appareil invalide.');
    }
    return VpnDevice(
      deviceId: _requiredIdentifier(
        json,
        'device_id',
        'Appareil VPN invalide.',
      ),
      name: _optionalText(json['name']) ?? 'Appareil sans nom',
      location: rawLocation is Map<String, dynamic>
          ? Location.fromJson(rawLocation)
          : null,
      createdAt: _optionalDateTime(
        json['created_at'],
        'Appareil VPN invalide.',
      ),
      profiles: List<VpnProfile>.unmodifiable(
        _optionalProfiles(json['profiles']),
      ),
    );
  }

  @override
  String toString() => 'VpnDevice(deviceId: $deviceId, redacted: true)';
}

class DeviceList {
  const DeviceList({required this.limit, required this.devices});

  final int limit;
  final List<VpnDevice> devices;

  factory DeviceList.fromJson(Map<String, dynamic> json) {
    final Object? rawLimit = json['limit'];
    final int limit = switch (rawLimit) {
      final int value => value,
      final num value when value == value.roundToDouble() => value.toInt(),
      _ => throw const FormatException('Liste des appareils invalide.'),
    };
    final Object? rawDevices = json['devices'];
    if (limit < 1 || limit > 100 || rawDevices is! List) {
      throw const FormatException('Liste des appareils invalide.');
    }
    final List<VpnDevice> devices = <VpnDevice>[];
    for (final Object? item in rawDevices) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Liste des appareils invalide.');
      }
      devices.add(VpnDevice.fromJson(item));
    }
    return DeviceList(
      limit: limit,
      devices: List<VpnDevice>.unmodifiable(devices),
    );
  }
}

/// Lifecycle of an asynchronous move of one existing logical device.
///
/// This intentionally contains only opaque identifiers and state. It never
/// carries a WireGuard key, CSR, certificate, endpoint, or tunnel profile.
enum LocationMigrationStatus {
  draining,
  activating,
  ready,
  blocked;

  static LocationMigrationStatus fromApi(String value) => switch (value) {
    'draining' => LocationMigrationStatus.draining,
    'activating' => LocationMigrationStatus.activating,
    'ready' => LocationMigrationStatus.ready,
    'blocked' => LocationMigrationStatus.blocked,
    _ => throw const FormatException('Migration d’emplacement invalide.'),
  };

  bool get isPending =>
      this == LocationMigrationStatus.draining ||
      this == LocationMigrationStatus.activating;
}

/// A strictly validated response from the location-migration API.
class DeviceLocationMigration {
  const DeviceLocationMigration({
    required this.migrationId,
    required this.deviceId,
    required this.sourceLocationId,
    required this.targetLocationId,
    required this.status,
    this.retryAfterSeconds,
  });

  final String migrationId;
  final String deviceId;
  final String sourceLocationId;
  final String targetLocationId;
  final LocationMigrationStatus status;
  final int? retryAfterSeconds;

  factory DeviceLocationMigration.fromJson(
    Map<String, dynamic> json, {
    required String expectedDeviceId,
  }) {
    final String deviceId = _requiredIdentifier(
      json,
      'device_id',
      'Migration d’emplacement invalide.',
    );
    if (deviceId != expectedDeviceId) {
      throw const FormatException('Migration d’emplacement invalide.');
    }
    final int? retryAfter = _optionalBoundedRetryAfter(
      json['retry_after_seconds'],
    );
    return DeviceLocationMigration(
      migrationId: _requiredIdentifier(
        json,
        'migration_id',
        'Migration d’emplacement invalide.',
      ),
      deviceId: deviceId,
      sourceLocationId: _requiredIdentifier(
        json,
        'source_location_id',
        'Migration d’emplacement invalide.',
      ),
      targetLocationId: _requiredIdentifier(
        json,
        'target_location_id',
        'Migration d’emplacement invalide.',
      ),
      status: LocationMigrationStatus.fromApi(
        _requiredText(json, 'status', 'Migration d’emplacement invalide.'),
      ),
      retryAfterSeconds: retryAfter,
    );
  }

  DeviceLocationMigration withRetryAfterSeconds(int? value) {
    if (value != null && (value < 0 || value > _maximumRetryAfterSeconds)) {
      throw const FormatException('Migration d’emplacement invalide.');
    }
    return DeviceLocationMigration(
      migrationId: migrationId,
      deviceId: deviceId,
      sourceLocationId: sourceLocationId,
      targetLocationId: targetLocationId,
      status: status,
      retryAfterSeconds: value,
    );
  }

  Map<String, Object?> toStorageJson() => <String, Object?>{
    'migration_id': migrationId,
    'device_id': deviceId,
    'source_location_id': sourceLocationId,
    'target_location_id': targetLocationId,
    'status': status.name,
    if (retryAfterSeconds != null) 'retry_after_seconds': retryAfterSeconds,
  };

  @override
  String toString() =>
      'DeviceLocationMigration(deviceId: $deviceId, targetLocationId: $targetLocationId, status: ${status.name})';
}

const int _maximumRetryAfterSeconds = 300;

int? _optionalBoundedRetryAfter(Object? value) {
  if (value == null) return null;
  final int? seconds = switch (value) {
    final int value => value,
    final num value when value == value.roundToDouble() => value.toInt(),
    _ => null,
  };
  if (seconds == null || seconds < 0 || seconds > _maximumRetryAfterSeconds) {
    throw const FormatException('Migration d’emplacement invalide.');
  }
  return seconds;
}

class DeviceProfiles {
  const DeviceProfiles({required this.deviceId, required this.profiles});

  final String deviceId;
  final List<VpnProfile> profiles;

  factory DeviceProfiles.fromJson(Map<String, dynamic> json) {
    final String deviceId = _requiredIdentifier(
      json,
      'device_id',
      'Profils VPN invalides.',
    );
    return DeviceProfiles(
      deviceId: deviceId,
      profiles: List<VpnProfile>.unmodifiable(
        _requiredProfiles(json['profiles']),
      ),
    );
  }
}

/// Response-only OpenVPN activation material. It must be passed immediately to
/// the native bridge, which imports it into Android Keystore-backed storage.
class OpenVpnActivation {
  const OpenVpnActivation({
    required this.deviceId,
    required this.protocol,
    required this.certificatePem,
    required this.caCertificatePem,
    required this.tlsCryptV2ClientKey,
    required this.endpoint,
    required this.dns,
    required this.address,
    required this.serverName,
    required this.remoteCertTlsServer,
    required this.ciphers,
    required this.notAfter,
    this.networkConfiguration,
  });

  final String deviceId;
  final String protocol;
  final String certificatePem;
  final String caCertificatePem;
  final String tlsCryptV2ClientKey;
  final String endpoint;
  final List<String> dns;
  final String address;
  final String serverName;
  final bool remoteCertTlsServer;
  final List<String> ciphers;
  final DateTime notAfter;
  final VpnNetworkConfiguration? networkConfiguration;
  VpnNetworkConfiguration get network =>
      networkConfiguration ?? VpnNetworkConfiguration.ipv4(address);

  factory OpenVpnActivation.fromJson(
    Map<String, dynamic> json, {
    required String expectedDeviceId,
  }) {
    final String deviceId = _requiredIdentifier(
      json,
      'device_id',
      'Profil OpenVPN invalide.',
    );
    if (deviceId != expectedDeviceId || json['protocol'] != 'openvpn') {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    final String endpoint = _requiredText(
      json,
      'endpoint',
      'Profil OpenVPN invalide.',
    );
    if (!_isIpv4Address(endpoint)) {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    final String address = _requiredIpv4Cidr(
      json,
      'address',
      'Profil OpenVPN invalide.',
    );
    if (!_hasIpv4Prefix(address, 32)) {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    final String serverName = _requiredText(
      json,
      'server_name',
      'Profil OpenVPN invalide.',
    );
    if (!RegExp(r'^[A-Za-z0-9][A-Za-z0-9._-]{0,252}$').hasMatch(serverName)) {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    if (json['remote_cert_tls_server'] != true) {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    final List<String> ciphers = _requiredCiphers(json['ciphers']);
    final DateTime? notAfter = _optionalDateTime(
      json['not_after'],
      'Profil OpenVPN invalide.',
    );
    if (notAfter == null) {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    return OpenVpnActivation(
      deviceId: deviceId,
      protocol: 'openvpn',
      certificatePem: _requiredText(
        json,
        'certificate_pem',
        'Profil OpenVPN invalide.',
      ),
      caCertificatePem: _requiredText(
        json,
        'ca_certificate_pem',
        'Profil OpenVPN invalide.',
      ),
      tlsCryptV2ClientKey: _requiredText(
        json,
        'tls_crypt_v2_client_key',
        'Profil OpenVPN invalide.',
      ),
      endpoint: endpoint,
      dns: List<String>.unmodifiable(
        _requiredIpv4List(json, 'dns', 'Profil OpenVPN invalide.'),
      ),
      address: address,
      serverName: serverName,
      remoteCertTlsServer: true,
      ciphers: List<String>.unmodifiable(ciphers),
      notAfter: notAfter,
      networkConfiguration: VpnNetworkConfiguration.fromJson(
        json,
        legacyOpenVpn: true,
      ),
    );
  }

  @override
  String toString() =>
      'OpenVpnActivation(deviceId: $deviceId, protocol: $protocol, redacted: true)';
}

class AuthSession {
  const AuthSession({required this.accessToken, required this.expiresAt});

  final String accessToken;
  final DateTime expiresAt;

  factory AuthSession.fromJson(Map<String, dynamic> json) => AuthSession(
    accessToken: _requiredText(
      json,
      'access_token',
      'Réponse d’authentification invalide.',
    ),
    expiresAt: _requiredDateTime(
      json,
      'expires_at',
      'Réponse d’authentification invalide.',
    ),
  );

  @override
  String toString() => 'AuthSession(redacted: true, expiresAt: $expiresAt)';
}

class RegistrationResult extends AuthSession {
  const RegistrationResult({
    required super.accessToken,
    required super.expiresAt,
    required this.verificationEmailSent,
  });

  /// `false` means account creation succeeded but SMTP was unavailable.
  final bool verificationEmailSent;

  factory RegistrationResult.fromJson(Map<String, dynamic> json) {
    final AuthSession session = AuthSession.fromJson(json);
    final Object? emailSent = json['verification_email_sent'];
    if (emailSent is! bool) {
      throw const FormatException('Réponse d’inscription invalide.');
    }
    return RegistrationResult(
      accessToken: session.accessToken,
      expiresAt: session.expiresAt,
      verificationEmailSent: emailSent,
    );
  }
}

/// Identity and session permissions are independent. A restored Play session
/// can see a registered identity while its personal profile remains redacted.
/// `emailVerified == null` means unknown, never an implicit denial.
class UserProfile {
  const UserProfile({
    required this.userId,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.postalCode = '',
    this.city = '',
    this.countryCode = '',
    this.emailVerified,
    this.authMethods,
    this.hasPassword,
    this.identityKind = 'registered',
    this.hasSessionCapabilities = false,
    this.profileRedacted = false,
    bool? canManageAccount,
    bool? canClaimAccount,
    this.canUseVpn = true,
  }) : canManageAccount = canManageAccount ?? (identityKind == 'registered'),
       canClaimAccount = canClaimAccount ?? (identityKind == 'guest');

  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final String city;
  final String countryCode;
  final String identityKind;

  /// True only for a server projection with explicit identity and permissions.
  /// Legacy defaults must not imply that an unverified account can use the VPN.
  final bool hasSessionCapabilities;
  final bool profileRedacted;
  final bool canManageAccount;
  final bool canClaimAccount;
  final bool canUseVpn;

  bool get isGuest => identityKind == 'guest';

  /// Null represents the current public API's unknown status.
  final bool? emailVerified;

  /// Missing metadata on a legacy API is unknown, not a passwordless account.
  final List<String>? authMethods;
  final bool? hasPassword;

  bool get hasVerifiedEmail => emailVerified == true;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    const capabilityFields = <String>[
      'profile_redacted',
      'can_manage_account',
      'can_claim_account',
      'can_use_vpn',
    ];
    final bool explicitIdentity = json.containsKey('identity_kind');
    final Object? rawKind = json['identity_kind'];
    if ((explicitIdentity &&
            !const <String>['guest', 'registered'].contains(rawKind)) ||
        (!explicitIdentity && capabilityFields.any(json.containsKey))) {
      throw const FormatException('Identité utilisateur invalide.');
    }
    final String identityKind = explicitIdentity
        ? rawKind as String
        : 'registered';
    bool capability(String key, bool legacyDefault) {
      if (!explicitIdentity) return legacyDefault;
      final Object? value = json[key];
      if (value is! bool) {
        throw const FormatException('Permissions utilisateur invalides.');
      }
      return value;
    }

    final bool profileRedacted = capability('profile_redacted', false);
    if (profileRedacted &&
        const <String>[
          'email',
          'first_name',
          'last_name',
          'phone',
          'address_line1',
          'address_line2',
          'postal_code',
          'city',
          'country_code',
          'email_verified',
          'auth_methods',
          'has_password',
        ].any(json.containsKey)) {
      throw const FormatException('Projection utilisateur invalide.');
    }
    final Object? rawVerified = json['email_verified'];
    if (rawVerified != null && rawVerified is! bool) {
      throw const FormatException('Profil utilisateur invalide.');
    }
    if (identityKind == 'guest' &&
        (json.containsKey('auth_methods') || json.containsKey('has_password'))) {
      throw const FormatException('Projection utilisateur invalide.');
    }
    List<String>? authMethods;
    if (json.containsKey('auth_methods')) {
      final rawMethods = json['auth_methods'];
      if (rawMethods is! List ||
          rawMethods.isEmpty ||
          rawMethods.any(
            (method) => !const <String>['password', 'google'].contains(method),
          ) ||
          rawMethods.toSet().length != rawMethods.length) {
        throw const FormatException('Méthodes d’authentification invalides.');
      }
      authMethods = List<String>.unmodifiable(rawMethods.cast<String>());
    }
    bool? hasPassword;
    if (json.containsKey('has_password')) {
      final rawPassword = json['has_password'];
      if (rawPassword is! bool) {
        throw const FormatException('Méthodes d’authentification invalides.');
      }
      hasPassword = rawPassword;
    }
    if (authMethods != null &&
        hasPassword != null &&
        authMethods.contains('password') != hasPassword) {
      throw const FormatException('Méthodes d’authentification invalides.');
    }
    return UserProfile(
      userId: _requiredIdentifier(
        json,
        'user_id',
        'Profil utilisateur invalide.',
      ),
      email: profileRedacted || identityKind == 'guest'
          ? _optionalText(json['email']) ?? ''
          : _requiredText(json, 'email', 'Profil utilisateur invalide.'),
      firstName: _optionalText(json['first_name']) ?? '',
      lastName: _optionalText(json['last_name']) ?? '',
      phone: _optionalText(json['phone']) ?? '',
      addressLine1: _optionalText(json['address_line1']) ?? '',
      addressLine2: _optionalText(json['address_line2']) ?? '',
      postalCode: _optionalText(json['postal_code']) ?? '',
      city: _optionalText(json['city']) ?? '',
      countryCode: _optionalText(json['country_code']) ?? '',
      emailVerified: rawVerified as bool?,
      authMethods: authMethods,
      hasPassword: hasPassword,
      identityKind: identityKind,
      hasSessionCapabilities: explicitIdentity,
      profileRedacted: profileRedacted,
      canManageAccount: capability('can_manage_account', true),
      canClaimAccount: capability('can_claim_account', false),
      canUseVpn: capability('can_use_vpn', true),
    );
  }

  @override
  String toString() => 'UserProfile(userId: $userId, redacted: true)';
}

class RegisterAccountRequest {
  const RegisterAccountRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.postalCode,
    required this.city,
    required this.countryCode,
    required this.termsAccepted,
    required this.privacyAccepted,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final String city;
  final String countryCode;
  final bool termsAccepted;
  final bool privacyAccepted;

  Map<String, Object> toJson() => <String, Object>{
    'email': email,
    'password': password,
    'first_name': firstName,
    'last_name': lastName,
    'phone': phone,
    'address_line1': addressLine1,
    'address_line2': addressLine2,
    'postal_code': postalCode,
    'city': city,
    'country_code': countryCode,
    'terms_accepted': termsAccepted,
    'privacy_accepted': privacyAccepted,
  };

  @override
  String toString() => 'RegisterAccountRequest(redacted: true)';
}

class UpdateProfileRequest {
  const UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.postalCode,
    required this.city,
    required this.countryCode,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final String city;
  final String countryCode;

  Map<String, Object> toJson() => <String, Object>{
    'first_name': firstName,
    'last_name': lastName,
    'phone': phone,
    'address_line1': addressLine1,
    'address_line2': addressLine2,
    'postal_code': postalCode,
    'city': city,
    'country_code': countryCode,
  };
}

String _requiredIdentifier(
  Map<String, dynamic> json,
  String key,
  String message,
) {
  final String value = _requiredText(json, key, message);
  if (!RegExp(r'^[A-Za-z0-9_-]{3,128}$').hasMatch(value)) {
    throw FormatException(message);
  }
  return value;
}

String _requiredCountryCode(Map<String, dynamic> json, String key) {
  final String value = _requiredText(json, key, 'Emplacement VPN invalide.');
  if (!RegExp(r'^[A-Z]{2}$').hasMatch(value)) {
    throw const FormatException('Emplacement VPN invalide.');
  }
  return value;
}

String _requiredText(Map<String, dynamic> json, String key, String message) {
  final Object? value = json[key];
  if (value is! String || value.trim().isEmpty || value.length > 16384) {
    throw FormatException(message);
  }
  return value;
}

String? _optionalText(Object? value) {
  if (value == null) return null;
  if (value is! String || value.length > 16384) {
    throw const FormatException('Réponse API invalide.');
  }
  return value;
}

DateTime _requiredDateTime(
  Map<String, dynamic> json,
  String key,
  String message,
) {
  final DateTime? parsed = _optionalDateTime(json[key], message);
  if (parsed == null) throw FormatException(message);
  return parsed;
}

DateTime? _optionalDateTime(Object? value, String message) {
  if (value == null) return null;
  if (value is! String || !RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(value)) {
    throw FormatException(message);
  }
  final DateTime? parsed = DateTime.tryParse(value);
  if (parsed == null) throw FormatException(message);
  return parsed.toUtc();
}

List<VpnProfile> _optionalProfiles(Object? value) {
  if (value == null) return const <VpnProfile>[];
  return _requiredProfiles(value);
}

List<VpnProfile> _requiredProfiles(Object? value) {
  if (value is! List) {
    throw const FormatException('Profils VPN invalides.');
  }
  final List<VpnProfile> profiles = <VpnProfile>[];
  for (final Object? item in value) {
    if (item is! Map<String, dynamic>) {
      throw const FormatException('Profils VPN invalides.');
    }
    // Account devices may expose non-tunnel profiles such as
    // `browser_proxy`. They count toward the same device quota but are not a
    // selectable VPN protocol in this application. Ignore only well-formed
    // future protocols; malformed WireGuard/OpenVPN metadata remains fatal.
    final Object? rawProtocol = item['protocol'];
    if (rawProtocol is String && VpnProtocol.fromApi(rawProtocol) == null) {
      continue;
    }
    profiles.add(VpnProfile.fromJson(item));
  }
  return profiles;
}

List<String> _requiredIpv4List(
  Map<String, dynamic> json,
  String key,
  String message,
) {
  final Object? raw = json[key];
  if (raw is! List || raw.isEmpty || raw.length > 8) {
    throw FormatException(message);
  }
  final List<String> values = <String>[];
  for (final Object? item in raw) {
    if (item is! String || !_isIpv4Address(item)) {
      throw FormatException(message);
    }
    values.add(item);
  }
  return values;
}

String _requiredIpv4Cidr(
  Map<String, dynamic> json,
  String key,
  String message,
) {
  final String value = _requiredText(json, key, message);
  if (!_isIpv4Cidr(value)) throw FormatException(message);
  return value;
}

List<String> _requiredCiphers(Object? raw) {
  if (raw is! List || raw.isEmpty || raw.length > 16) {
    throw const FormatException('Profil OpenVPN invalide.');
  }
  final List<String> ciphers = <String>[];
  for (final Object? item in raw) {
    if (item is! String || !RegExp(r'^[A-Za-z0-9_-]{1,64}$').hasMatch(item)) {
      throw const FormatException('Profil OpenVPN invalide.');
    }
    ciphers.add(item);
  }
  return ciphers;
}

bool _isIpv4Cidr(String value) {
  final List<String> parts = value.split('/');
  if (parts.length != 2 || !_isIpv4Address(parts.first)) return false;
  final int? prefix = int.tryParse(parts.last);
  return prefix != null && prefix >= 0 && prefix <= 32;
}

bool _hasIpv4Prefix(String value, int expectedPrefix) =>
    value.endsWith('/$expectedPrefix') && _isIpv4Cidr(value);

bool _isIpv4Address(String value) {
  final List<String> parts = value.split('.');
  if (parts.length != 4) return false;
  for (final String part in parts) {
    if (part.isEmpty ||
        part.length > 3 ||
        (part.length > 1 && part.startsWith('0'))) {
      return false;
    }
    final int? value = int.tryParse(part);
    if (value == null || value < 0 || value > 255) return false;
  }
  return true;
}
