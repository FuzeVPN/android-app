// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Protect your connection';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN uses Android’s VPN service (VpnService) to create an encrypted tunnel between this device and FuzeVPN servers.';

  @override
  String get vpnDisclosure_dataBody =>
      'While the VPN is active, your apps’ Internet traffic, destination addresses and DNS requests travel through this tunnel to route your connection, even when FuzeVPN is in the background.';

  @override
  String get vpnDisclosure_statusBody =>
      'The app uses the connection status, its duration and the amount of data transferred to display your VPN connection. You can stop it at any time.';

  @override
  String get vpnDisclosure_privacy => 'Privacy';

  @override
  String get vpnDisclosure_accept => 'Accept and continue';

  @override
  String get vpnDisclosure_decline => 'Not now';

  @override
  String get accountRestoration_title => 'Account temporarily unavailable';

  @override
  String get accountRestoration_message =>
      'Your session has been kept. Retry to restore your account; you can still manage the VPN connection here.';

  @override
  String get action_retry => 'Retry';

  @override
  String get session_endingTitle => 'Ending the session';

  @override
  String get session_ending =>
      'Your session is invalidated. Stopping the VPN and clearing the session…';

  @override
  String get session_stopFailed =>
      'VPN shutdown is not confirmed. Retry before signing in again.';

  @override
  String get session_cleanupFailed =>
      'The VPN is stopped, but session removal is not confirmed. Retry cleanup.';

  @override
  String get session_retryStop => 'Retry shutdown';

  @override
  String get session_retryCleanup => 'Retry cleanup';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Preparing FuzeVPN securely…';

  @override
  String get nav_connection => 'Connection';

  @override
  String get nav_locations => 'Locations';

  @override
  String get nav_account => 'Account';

  @override
  String get nav_devices => 'Devices';

  @override
  String get nav_settings => 'Settings';

  @override
  String get action_refresh => 'Refresh';

  @override
  String get auth_tab_login => 'Sign in';

  @override
  String get auth_tab_register => 'Sign up';

  @override
  String get auth_stepAccount => 'Account';

  @override
  String get auth_stepIdentity => 'Identity';

  @override
  String get auth_stepAddress => 'Address and agreements';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Step $current of $total';
  }

  @override
  String get auth_tagline => 'Your VPN, made simple.';

  @override
  String get auth_keysLocal => 'Your private VPN keys stay on this device.';

  @override
  String get form_email => 'Email address';

  @override
  String get form_password => 'Password';

  @override
  String get form_showPassword => 'Show password';

  @override
  String get form_hidePassword => 'Hide password';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 bytes. Some characters use more than one byte.';

  @override
  String get form_firstName => 'First name';

  @override
  String get form_lastName => 'Last name';

  @override
  String get form_phone => 'Phone (+33612345678)';

  @override
  String get form_address => 'Address';

  @override
  String get form_address2 => 'Address line 2 (optional)';

  @override
  String get form_postalCode => 'Postal code';

  @override
  String get form_city => 'City';

  @override
  String get form_country => 'Country code (e.g. FR)';

  @override
  String get action_login => 'Sign in';

  @override
  String get action_createAccount => 'Create an account';

  @override
  String get action_createMyAccount => 'Create my account';

  @override
  String get action_next => 'Continue';

  @override
  String get action_previous => 'Back';

  @override
  String get action_forgotPassword => 'Forgot password?';

  @override
  String get auth_noAccount => 'Don’t have an account yet?';

  @override
  String get auth_requiredInformation => 'Create your account in three steps.';

  @override
  String get auth_termsPrefix => 'I accept the ';

  @override
  String get auth_termsLink => 'terms of use';

  @override
  String get auth_privacyPrefix => 'I accept the ';

  @override
  String get auth_privacyLink => 'privacy policy';

  @override
  String get auth_consentRequired =>
      'Your consent is required to create an account.';

  @override
  String get validation_required => 'This field is required.';

  @override
  String get validation_email => 'Enter a valid email address.';

  @override
  String get validation_password =>
      'Password is too short: at least 8 UTF-8 bytes.';

  @override
  String get validation_passwordTooLong =>
      'Password is too long: at most 72 UTF-8 bytes.';

  @override
  String get validation_phone =>
      'Use international format, for example +33612345678.';

  @override
  String get validation_country =>
      'Use a two-letter country code, for example FR.';

  @override
  String get passwordReset_title => 'Reset password';

  @override
  String get passwordReset_description =>
      'Enter your account email address to request a password reset link.';

  @override
  String get passwordReset_send => 'Send link';

  @override
  String get connection_title => 'Your connection';

  @override
  String get connection_subtitle => 'Choose a location, then turn on your VPN.';

  @override
  String get connection_prepare => 'Ready to connect?';

  @override
  String get connection_advancedOptions => 'Advanced options';

  @override
  String get connection_location => 'Location';

  @override
  String get connection_chooseLocation => 'Choose a location';

  @override
  String get connection_protocol => 'Protocol';

  @override
  String get connection_connect => 'Connect';

  @override
  String get connection_connecting => 'Connecting…';

  @override
  String get connection_disconnect => 'Disconnect';

  @override
  String get connection_disconnecting => 'Disconnecting';

  @override
  String get connection_locationChange => 'Changing location…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol unavailable';
  }

  @override
  String get connection_activeLocation => 'Active location';

  @override
  String get connection_duration => 'Duration';

  @override
  String get connection_received => 'Received';

  @override
  String get connection_sent => 'Sent';

  @override
  String get connection_lastHandshake => 'Last secure exchange';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ago';
  }

  @override
  String get verification_title => 'Confirm your email address';

  @override
  String get verification_message =>
      'Confirm your email address to use the VPN on this phone.';

  @override
  String get verification_resend => 'Resend email';

  @override
  String get migration_title => 'Location change';

  @override
  String get migration_draining => 'Preparing the location change…';

  @override
  String get migration_activating => 'Activating the new server…';

  @override
  String get migration_ready => 'Location updated.';

  @override
  String get migration_blocked =>
      'The location change requires server intervention. Try again later or contact support.';

  @override
  String get migration_progress => 'Location change progress';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Delay between checks: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Resume location change';

  @override
  String get status_authorizing => 'Permission required';

  @override
  String get status_authorizingDetail =>
      'Accept the Android request to allow the VPN.';

  @override
  String get status_preparing => 'Preparing';

  @override
  String get status_preparingDetail => 'Preparing your secure connection.';

  @override
  String get status_reconnecting => 'Reconnecting…';

  @override
  String get status_reconnectingDetail =>
      'Connection interrupted. The VPN is trying to reconnect.';

  @override
  String get status_connecting => 'Connecting';

  @override
  String get status_connectingDetail => 'Connecting to the VPN server…';

  @override
  String get status_connected => 'Connected';

  @override
  String get status_connectedDetail => 'Your VPN connection is active.';

  @override
  String get status_disconnecting => 'Disconnecting';

  @override
  String get status_disconnectingDetail => 'Your VPN connection is stopping.';

  @override
  String get status_error => 'Connection unavailable';

  @override
  String get status_errorDetail =>
      'The VPN connection is not confirmed. Try again.';

  @override
  String get status_idle => 'Disconnected';

  @override
  String get status_idleDetail => 'Connect the VPN to protect your connection.';

  @override
  String get trust_note =>
      'Closing the app does not stop the VPN. To stop it, use Disconnect.';

  @override
  String get locations_none => 'No locations are currently available.';

  @override
  String get locations_available => 'Choose your next location.';

  @override
  String get locations_selected => 'Selected location';

  @override
  String get locations_select => 'Choose this location';

  @override
  String get locations_lockedTunnel => 'Disconnect the VPN to change location.';

  @override
  String get locations_lockedMigration =>
      'Wait for the location change to finish.';

  @override
  String get devices_title => 'Your devices';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit devices';
  }

  @override
  String get devices_refresh => 'Refresh devices';

  @override
  String get devices_empty => 'No VPN device is registered yet.';

  @override
  String get devices_firstConnection =>
      'Your phone will be added on the first connection.';

  @override
  String get devices_thisDevice => 'This device';

  @override
  String devices_added(Object date) {
    return 'Added on $date';
  }

  @override
  String get action_remove => 'Remove';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_subtitle =>
      'Your preferences and account, all in one place.';

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_languageDescription =>
      'Your chosen language also applies to VPN notifications.';

  @override
  String get settings_account => 'Account';

  @override
  String get settings_signOut => 'Sign out';

  @override
  String get settings_privacy => 'Privacy policy';

  @override
  String get settings_terms => 'Terms of use';

  @override
  String get settings_security => 'Security and transparency';

  @override
  String get settings_licenses => 'Component licenses';

  @override
  String get settings_licensesDetail => 'Software used in the app';

  @override
  String get settings_background =>
      'The VPN stays on when you leave the app. To stop it, use Disconnect on the Connection tab.';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Light';

  @override
  String get theme_dark => 'Dark';

  @override
  String get language_system => 'Phone language';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Remove this device?';

  @override
  String get dialog_removeCurrent =>
      'This phone will disconnect from the VPN and lose access. Its VPN connection data will be removed after the server confirms.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN access for “$name” will be revoked. This cannot be undone.';
  }

  @override
  String get dialog_signOut => 'Sign out?';

  @override
  String get dialog_signOutMessage =>
      'The VPN will stop and you will need to sign in again. Your encrypted VPN keys will stay on this phone for your next connection.';

  @override
  String get action_cancel => 'Cancel';

  @override
  String get action_signOut => 'Sign out';

  @override
  String get notice_close => 'Dismiss message';

  @override
  String get notice_sessionExpired_title => 'Session expired';

  @override
  String get notice_sessionExpired_message =>
      'Your session has expired. Sign in again.';

  @override
  String get notice_connectionFailed_title => 'Connection failed';

  @override
  String get notice_invalidCredentials_message =>
      'The email address or password is incorrect.';

  @override
  String get notice_emailVerification_title => 'Email confirmation required';

  @override
  String get notice_emailVerification_message =>
      'Confirm your email address before adding a VPN device.';

  @override
  String get notice_rateLimited_title => 'Too many attempts';

  @override
  String get notice_deviceLimit_title => '2-device limit reached';

  @override
  String get notice_deviceLimit_message =>
      'Remove an existing device before adding another one.';

  @override
  String get notice_identityRenewal_title => 'VPN identity must be renewed';

  @override
  String get notice_identityRenewal_message =>
      'This identity was removed. Create a new local identity.';

  @override
  String get notice_migrationPending_title => 'Location change in progress';

  @override
  String get notice_migrationPending_message =>
      'A location change is already in progress.';

  @override
  String get notice_migrationBlocked_title => 'Location change blocked';

  @override
  String get notice_migrationBlocked_message =>
      'The location change requires server intervention. Try again later or contact support.';

  @override
  String get notice_targetUnavailable_title => 'Server temporarily unavailable';

  @override
  String get notice_targetUnavailable_message =>
      'This server is temporarily unavailable.';

  @override
  String get notice_networkUnavailable_title =>
      'Internet connection unavailable';

  @override
  String get notice_networkUnavailable_message =>
      'Check your connection and try again.';

  @override
  String get notice_permissionDenied_title => 'VPN permission denied';

  @override
  String get notice_permissionDenied_message =>
      'Start the connection again and accept the Android permission request.';

  @override
  String get notice_wireguardTimeout_title => 'The server is not responding';

  @override
  String get notice_wireguardTimeout_message =>
      'The WireGuard connection took too long. Try again or choose another location.';

  @override
  String get notice_tlsFailed_title => 'Secure connection refused';

  @override
  String get notice_tlsFailed_message =>
      'The server did not accept the OpenVPN connection. Try again. If the problem continues, run a diagnostic.';

  @override
  String get notice_tunRejected_title => 'Android rejected the VPN interface';

  @override
  String get notice_tunRejected_message =>
      'Android rejected the network configuration requested by OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN could not start';

  @override
  String get notice_openvpnStart_message =>
      'The OpenVPN engine could not finish starting. Try again. If the problem persists, contact support.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostic code: $code';
  }

  @override
  String get notice_generic_title => 'VPN connection failed';

  @override
  String get notice_generic_message => 'An error occurred. Try again later.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Account created',
      'password_reset_sent': 'Password reset request received',
      'verification_email_sent': 'Verification email sent',
      'location_migration_pending': 'Location change in progress',
      'vpn_sign_in_required': 'Sign-in required',
      'protocol_unavailable_at_location': 'Protocol unavailable',
      'vpn_permission_denied': 'VPN permission denied',
      'revoked_identity_device_limit': '2-device limit reached',
      'tunnel_start_unexpected': 'VPN could not start',
      'flutter_disconnect_timeout': 'Disconnection not confirmed',
      'flutter_disconnect_unexpected': 'Could not disconnect',
      'device_revoked': 'Device removed',
      'revoke_unexpected': 'Could not remove device',
      'identity_renewal_unexpected': 'Could not renew identity',
      'openvpn_renewal_unexpected': 'Could not renew OpenVPN',
      'location_migration_blocked': 'Location change blocked',
      'location_migration_slow': 'Location change still in progress',
      'location_migration_conflict': 'Location change needs refreshing',
      'location_migration_verification_failed': 'Location change not confirmed',
      'location_migration_device_changed':
          'Device changed during location change',
      'tunnel_stop_failed': 'Location change unavailable',
      'other': 'Operation failed',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'The account was created, but the verification email could not be sent. Use resend in the app.',
      'password_reset_sent':
          'Your request was received. If an account matches this address, you may receive an email. Please also check your spam folder.',
      'verification_email_sent': 'A new verification email has just been sent.',
      'location_migration_pending':
          'The move to $target is still being prepared. You can resume it without recreating the device.',
      'vpn_sign_in_required':
          'Sign in to your account before starting the VPN.',
      'protocol_unavailable_at_location':
          'The selected protocol is not offered by this location. Refresh locations or choose another protocol.',
      'vpn_permission_denied':
          'Android denied the VPN permission. Start the connection again and accept the system request.',
      'revoked_identity_device_limit':
          'This device’s VPN access was removed and the device limit has been reached. Remove a device under Account → Manage my devices.',
      'tunnel_start_unexpected':
          'An unexpected error interrupted tunnel preparation. Check the diagnostic code and try again.',
      'flutter_disconnect_timeout':
          'Android did not confirm that the VPN stopped in time. Try stopping it again.',
      'flutter_disconnect_unexpected':
          'An unexpected error prevented confirmation that the tunnel stopped.',
      'device_revoked':
          'The device’s VPN access was revoked and its local secrets were removed.',
      'revoke_unexpected':
          'The device could not be removed. Refresh the list and try again.',
      'identity_renewal_unexpected':
          'The new VPN identity could not be created. Refresh devices and try again.',
      'openvpn_renewal_unexpected':
          'The OpenVPN profile could not be renewed. Try again or check the diagnostic code.',
      'location_migration_blocked':
          'The server cannot complete this change right now. The device and its local identity were kept.',
      'location_migration_slow':
          'The server is still preparing the move to $target. Use Resume in a few moments.',
      'location_migration_conflict':
          'The device state changed on the server. Refresh devices, then resume the change.',
      'location_migration_verification_failed':
          'The server did not confirm the new location. The previous local identity was kept.',
      'location_migration_device_changed':
          'The device returned by the server no longer matches the one being changed. Refresh devices before trying again.',
      'tunnel_stop_failed':
          'The previous tunnel must be completely stopped before the new connection.',
      'other':
          'The operation could not be completed. Try again or send the diagnostic code to support.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Session expired',
      'invalid_credentials': 'Sign-in failed',
      'email_verification_required': 'Email confirmation required',
      'verification_email_cooldown': 'Email already sent',
      'rate_limited': 'Too many attempts',
      'invalid_registration': 'Information must be corrected',
      'email_exists': 'Account already exists',
      'invalid_profile': 'Invalid profile',
      'invalid_device': 'Invalid device',
      'invalid_location': 'Location unavailable',
      'device_limit': 'Device limit reached',
      'device_exists': 'VPN identity already in use',
      'device_identity_revoked': 'VPN identity must be renewed',
      'device_location_locked': 'Location change needs refreshing',
      'location_migration_pending': 'Location change in progress',
      'location_migration_blocked': 'Location change blocked',
      'target_ca_mismatch': 'Incompatible OpenVPN server',
      'location_migration_conflict': 'Location change needs refreshing',
      'server_full': 'Server full',
      'capacity_unavailable': 'Location temporarily unavailable',
      'target_unavailable': 'Server temporarily unavailable',
      'not_found': 'Item not found',
      'invalid_openvpn_csr': 'Invalid OpenVPN identity',
      'openvpn_profile_exists': 'OpenVPN profile already exists',
      'openvpn_profile_revoked': 'OpenVPN profile revoked',
      'openvpn_operation_pending': 'OpenVPN operation in progress',
      'openvpn_operation_terminal': 'OpenVPN operation interrupted',
      'openvpn_address_unavailable': 'OpenVPN address unavailable',
      'openvpn_profile_conflict': 'OpenVPN conflict',
      'openvpn_signer_unavailable': 'OpenVPN unavailable',
      'email_delivery_unavailable': 'Email unavailable',
      'invalid_token': 'Invalid link',
      'network_unavailable': 'Internet connection unavailable',
      'invalid_json': 'Invalid request',
      'invalid_api_response': 'Invalid server response',
      'ipv6_unavailable': 'IPv6 unavailable',
      'invalid_ip_families': 'Network configuration rejected',
      'other': 'Service unavailable',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Your session has expired. Sign in again.',
      'invalid_credentials': 'The email address or password is incorrect.',
      'email_verification_required':
          'Confirm your email address before adding a VPN device.',
      'invalid_registration': 'Check the requested information and consents.',
      'email_exists': 'An account already uses this email address.',
      'invalid_profile': 'Check your profile information.',
      'invalid_device': 'This device’s name or local identity is invalid.',
      'invalid_location': 'Refresh the location list and try again.',
      'device_limit': 'Remove an existing device before adding another one.',
      'device_exists':
          'This VPN identity is already linked to another account.',
      'device_identity_revoked':
          'This identity was removed. A new local identity must be created.',
      'device_location_locked':
          'This device’s location has just changed. The app will resume the change in progress.',
      'location_migration_pending': 'A location change is already in progress.',
      'location_migration_blocked':
          'The location change requires server intervention. Try again later or contact support.',
      'target_ca_mismatch':
          'This server is not yet compatible with the current OpenVPN profile.',
      'location_migration_conflict':
          'Refresh devices, then try the location change again.',
      'server_full':
          'This location has reached its connection limit. Choose another location or try again later.',
      'capacity_unavailable':
          'We cannot confirm whether this location is available right now. Choose another location or try again later.',
      'target_unavailable': 'This server is temporarily unavailable.',
      'not_found': 'This item is no longer available on your account.',
      'invalid_openvpn_csr': 'Create a new OpenVPN identity and try again.',
      'openvpn_profile_exists':
          'An OpenVPN profile already exists for this device.',
      'openvpn_profile_revoked': 'Renew the OpenVPN profile to continue.',
      'openvpn_operation_pending':
          'The change is still propagating. Try again later.',
      'openvpn_operation_terminal':
          'Create a new OpenVPN identity and try again.',
      'openvpn_address_unavailable':
          'No OpenVPN address is currently available.',
      'openvpn_profile_conflict':
          'The profile changed. Refresh devices and try again.',
      'openvpn_signer_unavailable':
          'The OpenVPN service is temporarily unavailable.',
      'email_delivery_unavailable':
          'The email could not be sent. Try again later.',
      'invalid_token':
          'This link is invalid or has expired. Request a new one.',
      'network_unavailable': 'Check your Internet connection and try again.',
      'invalid_json': 'Check the entered information and try again.',
      'invalid_api_response':
          'The server returned an unexpected response. Try again later.',
      'ipv6_unavailable':
          'The server cannot activate IPv6 at the moment. Try again later.',
      'invalid_ip_families':
          'The tunnel configuration is incomplete or does not match the authorized addresses. Try again from the app.',
      'other': 'A server error occurred. Try again later.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Try again in a few moments.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Try again in $seconds seconds.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'System VPN resume unavailable',
      'system_vpn_resume_corrupt': 'Invalid system VPN resume',
      'system_vpn_resume_session_invalid': 'Invalid VPN resume session',
      'system_vpn_resume_identity_changed': 'VPN identity changed',
      'system_vpn_resume_identity_invalid': 'Invalid VPN resume identity',
      'system_vpn_resume_storage_failed': 'VPN resume storage unavailable',
      'system_vpn_resume_network_timeout': 'VPN resume has no network',
      'system_vpn_resume_blocked': 'VPN resume blocked',
      'system_vpn_resume_failed': 'VPN resume failed',
      'system_vpn_resume_error_invalid': 'Invalid VPN resume error',
      'wireguard_identity_store_failed': 'WireGuard identity not saved',
      'wireguard_identity_unavailable': 'WireGuard identity unavailable',
      'vpn_host_destroyed': 'Android VPN host stopped',
      'vpn_host_unavailable': 'Android VPN host unavailable',
      'vpn_permission_required': 'VPN permission required',
      'vpn_permission_denied': 'VPN permission denied',
      'vpn_permission_request_failed': 'Could not request permission',
      'wireguard_foreground_service_unavailable':
          'WireGuard service unavailable',
      'wireguard_identity_invalid': 'Invalid local WireGuard key',
      'wireguard_identity_in_use': 'WireGuard identity already in use',
      'wireguard_configuration_invalid': 'Invalid WireGuard configuration',
      'wireguard_operation_pending': 'WireGuard operation still active',
      'wireguard_start_failed': 'WireGuard start rejected',
      'wireguard_stop_timeout': 'WireGuard stop not confirmed',
      'wireguard_handshake_timeout': 'WireGuard did not respond',
      'openvpn_connection_timeout': 'OpenVPN did not respond',
      'openvpn_core_unavailable': 'OpenVPN engine unavailable',
      'openvpn_operation_pending': 'OpenVPN session still active',
      'openvpn_stop_timeout': 'OpenVPN stop not confirmed',
      'openvpn_profile_unavailable': 'Local OpenVPN profile missing',
      'openvpn_native_failed': 'Native OpenVPN call interrupted',
      'openvpn_key_generation_failed': 'Could not create OpenVPN P-256 key',
      'openvpn_csr_generation_failed': 'Could not create OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN identity not saved',
      'openvpn_identity_clear_failed': 'Incomplete OpenVPN removal',
      'openvpn_identity_in_use': 'OpenVPN identity still in use',
      'openvpn_tls_verification_required': 'OpenVPN TLS verification missing',
      'openvpn_cipher_invalid': 'Invalid OpenVPN cipher',
      'openvpn_profile_rejected': 'OpenVPN profile rejected',
      'openvpn_identity_inconsistent': 'Inconsistent OpenVPN identity',
      'tls_handshake_failed': 'OpenVPN negotiation rejected',
      'tls_alert_unknown_ca': 'OpenVPN client certificate not recognized',
      'tls_alert_bad_certificate': 'OpenVPN client certificate rejected',
      'tls_alert_unsupported_certificate': 'Unsupported OpenVPN certificate',
      'tls_client_certificate_required': 'OpenVPN client certificate required',
      'tls_alert_misc': 'OpenVPN TLS alert',
      'tls_signature_algorithm_rejected': 'Unsupported OpenVPN signature',
      'tls_handshake_rejected': 'OpenVPN TLS negotiation rejected',
      'tls_version_rejected': 'Incompatible OpenVPN TLS version',
      'tls_certificate_expired': 'TLS certificate expired',
      'tls_certificate_revoked': 'TLS certificate revoked',
      'transport_failed': 'OpenVPN server unreachable',
      'tun_configuration_rejected': 'Could not create OpenVPN interface',
      'tun_setup_failed': 'OpenVPN TUN setup failed',
      'tun_interface_create_failed': 'OpenVPN interface creation failed',
      'tun_interface_disabled': 'OpenVPN interface disabled',
      'tun_halted': 'OpenVPN interface interrupted',
      'tun_already_established': 'OpenVPN interface already open',
      'tun_addresses_missing': 'OpenVPN address missing',
      'tun_routes_missing': 'OpenVPN routes missing',
      'tun_dns_missing': 'OpenVPN DNS missing',
      'tun_permission_revoked': 'VPN permission revoked',
      'tun_establish_returned_null': 'Android rejected the VPN interface',
      'openvpn_service_start_failed': 'OpenVPN service unavailable',
      'openvpn_operation_timeout': 'OpenVPN call timed out',
      'openvpn_start_failed': 'OpenVPN start rejected',
      'openvpn_connection_failed': 'OpenVPN connection interrupted',
      'openvpn_core_status_error': 'OpenVPN Core ended with an error',
      'openvpn_stopped_before_connected': 'OpenVPN stopped before connecting',
      'openvpn_auth_failed': 'OpenVPN authentication rejected',
      'openvpn_client_setup_failed': 'OpenVPN client setup failed',
      'openvpn_client_halted': 'OpenVPN client interrupted',
      'openvpn_client_restart': 'OpenVPN restart requested',
      'openvpn_inactive_timeout': 'OpenVPN inactive too long',
      'openvpn_session_expired': 'OpenVPN session expired',
      'openvpn_credentials_required': 'Unsupported OpenVPN authentication',
      'openvpn_proxy_failed': 'OpenVPN intermediary transport failed',
      'openvpn_compression_failed': 'OpenVPN compression rejected',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM encryption unavailable',
      'openvpn_feature_unsupported': 'Unsupported OpenVPN feature',
      'network_unavailable': 'Internet connection unavailable',
      'network_lost': 'Network unavailable',
      'certificate_validation_failed': 'Server certificate rejected',
      'openvpn_certificate_expired': 'OpenVPN certificate expired',
      'tunnel_active_for_another_account':
          'Another account’s tunnel is still active',
      'tunnel_already_active': 'Native tunnel already active',
      'tunnel_stop_timeout': '$protocol stop not confirmed',
      'tunnel_disconnected': '$protocol interrupted',
      'native_bridge_unavailable': 'Android bridge unavailable',
      'native_operation_failed': 'Android operation interrupted',
      'invalid_arguments': 'Incomplete VPN parameters',
      'invalid_account_id': 'Invalid VPN account',
      'invalid_device_id': 'Invalid device identifier',
      'storage_key_not_allowed': 'Storage key rejected',
      'secure_storage_read_failed': 'Secure read failed',
      'secure_storage_write_failed': 'Secure write failed',
      'key_generation_failed': 'Could not generate WireGuard key',
      'csr_generation_failed': 'Could not generate OpenVPN CSR',
      'other': 'Unclassified native VPN error',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android cannot find a resumable VPN session. Start a new connection in the app.',
      'system_vpn_resume_corrupt':
          'The saved VPN resume data is invalid and will not be used. Start a new connection.',
      'system_vpn_resume_session_invalid':
          'The saved session can no longer resume the VPN. Sign in again in the app.',
      'system_vpn_resume_identity_changed':
          'The local VPN identity changed. Resume was stopped; start a new connection.',
      'system_vpn_resume_identity_invalid':
          'The identity for resuming is invalid. Start a new connection.',
      'system_vpn_resume_storage_failed':
          'Android could not read or update encrypted resume data. Start a new connection.',
      'system_vpn_resume_network_timeout':
          'Android did not find a network in time to resume the VPN. Try again when a network is available.',
      'system_vpn_resume_blocked':
          'VPN resume is blocked. Check Android settings, then start a new connection.',
      'system_vpn_resume_failed':
          'Android VPN resume failed. Start a new connection in the app.',
      'system_vpn_resume_error_invalid':
          'Android returned an unusable resume error. Start a new connection.',
      'wireguard_identity_store_failed':
          'Android could not save this account’s encrypted WireGuard identity.',
      'wireguard_identity_unavailable':
          'No usable WireGuard identity is available for this connection.',
      'vpn_host_destroyed':
          'The Android component hosting the VPN was stopped. Start a new connection.',
      'vpn_host_unavailable':
          'Android cannot create the component hosting the VPN. Try again after checking VPN settings.',
      'openvpn_renewal_required':
          'The certificate requires an action in the app before connecting.',
      'openvpn_recovery_failed':
          'Automatic recovery failed. Start a new connection in the app.',
      'openvpn_recovery_exhausted':
          'Automatic recovery has already been used. Start a new connection in the app.',
      'vpn_permission_required':
          'Android requires a new VPN authorization before starting the tunnel.',
      'vpn_permission_denied':
          'Allow FuzeVPN in the Android request to continue.',
      'vpn_permission_request_failed':
          'Android could not open the VPN permission screen.',
      'wireguard_foreground_service_unavailable':
          'Android could not keep the WireGuard service in the foreground.',
      'wireguard_identity_invalid':
          'This account’s encrypted WireGuard key is unreadable or invalid.',
      'wireguard_identity_in_use':
          'Another operation is still using this account’s WireGuard key.',
      'wireguard_configuration_invalid':
          'The received WireGuard address, DNS, server key, or routes are invalid.',
      'wireguard_operation_pending':
          'The previous WireGuard operation has not yet released its native service.',
      'wireguard_start_failed':
          'The WireGuard engine rejected activation of the configuration.',
      'wireguard_stop_timeout':
          'The WireGuard service did not confirm release of the VPN interface within the time limit.',
      'wireguard_handshake_timeout':
          'The tunnel did not confirm a handshake with the server in time.',
      'openvpn_connection_timeout':
          'OpenVPN did not confirm the connection to the server in time.',
      'openvpn_core_unavailable':
          'This app version does not contain a usable OpenVPN engine.',
      'openvpn_operation_pending':
          'The native engine still holds the previous OpenVPN session and refuses to create a second one.',
      'openvpn_stop_timeout':
          'OpenVPN Core did not confirm that its native session stopped and was destroyed within the time limit.',
      'openvpn_profile_unavailable':
          'No validated OpenVPN profile can be read for this connection.',
      'openvpn_native_failed':
          'An app error interrupted OpenVPN. Try connecting again. If the problem continues, run a diagnostic.',
      'openvpn_key_generation_failed':
          'Android Keystore could not create or read the non-exportable P-256 private key.',
      'openvpn_csr_generation_failed':
          'The Android Keystore key could not sign the OpenVPN certificate request.',
      'openvpn_identity_store_failed':
          'The OpenVPN certificate or profile could not be saved in encrypted storage.',
      'openvpn_identity_clear_failed':
          'Android could not remove the entire local OpenVPN identity for this account.',
      'openvpn_identity_in_use':
          'A native OpenVPN session is still using this device’s key or certificate.',
      'openvpn_tls_verification_required':
          'The profile does not explicitly require server certificate verification.',
      'openvpn_cipher_invalid':
          'The server supplied an encryption algorithm that is not in the allowed list.',
      'openvpn_profile_rejected':
          'The profile received from the server is incompatible. Recreate this device and try again.',
      'openvpn_identity_inconsistent':
          'The certificate does not match this phone’s secure identity. No local profile was replaced.',
      'tls_handshake_failed':
          'The server rejected the TLS negotiation. Recreate the profile if the problem persists.',
      'tls_alert_unknown_ca':
          'The server does not recognize the authority of this device certificate. The OpenVPN server must be checked.',
      'tls_alert_bad_certificate':
          'The server rejected this device certificate. Recreate the device before trying again.',
      'tls_alert_unsupported_certificate':
          'The server does not support the secure certificate type used by Android.',
      'tls_client_certificate_required':
          'The server requires a client certificate, but OpenVPN Core could not present one.',
      'tls_alert_misc':
          'The server returned a TLS alert outside the certificate and version categories.',
      'tls_signature_algorithm_rejected':
          'The server rejected the Android Keystore key’s ECDSA P-256 algorithm.',
      'tls_handshake_rejected':
          'The server interrupted the TLS negotiation before connection.',
      'tls_version_rejected':
          'The client and server did not find a common TLS version.',
      'tls_certificate_expired':
          'The certificate presented during connection has expired.',
      'tls_certificate_revoked':
          'The certificate presented during connection has been revoked.',
      'transport_failed':
          'The OpenVPN server is not responding on the current network. Try again shortly.',
      'tun_configuration_rejected':
          'Android rejected the network configuration requested by OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core rejected the network plan before creating the Android interface.',
      'tun_interface_create_failed':
          'OpenVPN Core could not obtain the TUN interface from Android VpnService.',
      'tun_interface_disabled':
          'Android or OpenVPN Core disabled the TUN interface during the connection.',
      'tun_halted':
          'OpenVPN Core received a request to stop the TUN interface.',
      'tun_already_established':
          'OpenVPN requested a second interface in the same connection. The tunnel was stopped for safety.',
      'tun_addresses_missing':
          'The server did not provide a usable tunnel address.',
      'tun_routes_missing': 'The server did not provide usable tunnel routes.',
      'tun_dns_missing': 'The server did not provide a usable DNS server.',
      'tun_permission_revoked':
          'Android revoked the VPN permission during the connection.',
      'tun_establish_returned_null':
          'Android did not create the interface, usually because another VPN is still active.',
      'openvpn_service_start_failed':
          'Android could not start the OpenVPN foreground service.',
      'openvpn_operation_timeout':
          'A JNI call to OpenVPN Core exceeded its maximum duration.',
      'openvpn_start_failed':
          'The Android service is ready, but OpenVPN Core did not accept starting the profile.',
      'openvpn_connection_failed':
          'OpenVPN Core stopped before emitting the CONNECTED event.',
      'openvpn_core_status_error':
          'The native OpenVPN loop ended with an error and no more specific terminal event.',
      'openvpn_stopped_before_connected':
          'The native OpenVPN loop stopped before CONNECTED, without an explicit Core error.',
      'openvpn_auth_failed':
          'The OpenVPN server rejected the profile authentication.',
      'openvpn_client_setup_failed':
          'OpenVPN Core could not initialize the client before the network connection.',
      'openvpn_client_halted': 'OpenVPN Core received a terminal client stop.',
      'openvpn_client_restart':
          'OpenVPN Core requested a restart of its transport session.',
      'openvpn_inactive_timeout':
          'OpenVPN Core closed the session after the inactivity timeout.',
      'openvpn_session_expired':
          'The server reported that the OpenVPN session expired.',
      'openvpn_credentials_required':
          'The server or a proxy requests interactive credentials that are not part of this certificate profile.',
      'openvpn_proxy_failed':
          'OpenVPN Core reported a failure of the configured proxy or relay.',
      'openvpn_compression_failed':
          'OpenVPN Core rejected the compression mode announced by the profile or server.',
      'openvpn_ntlm_crypto_unavailable':
          'The profile requests NTLM encryption that is unavailable in this version.',
      'openvpn_feature_unsupported':
          'The profile or server requires a feature missing from this Android client.',
      'network_unavailable': 'No usable physical network is available.',
      'network_lost': 'The tunnel was stopped after the network was lost.',
      'certificate_validation_failed':
          'The OpenVPN server identity could not be verified.',
      'openvpn_certificate_expired':
          'Renew the OpenVPN profile before reconnecting.',
      'tunnel_active_for_another_account':
          'A tunnel belonging to another account must stop before this connection.',
      'tunnel_already_active':
          'Android reports that a previous VPN session is still using the interface.',
      'tunnel_stop_timeout':
          'The $protocol engine did not confirm release of the VPN interface within the time limit.',
      'tunnel_disconnected':
          'The native engine reported that the tunnel ended unexpectedly after starting.',
      'native_bridge_unavailable':
          'The app cannot access the Android VPN service. Close and reopen the app, then try again.',
      'native_operation_failed':
          'An app error interrupted the VPN operation. Try again. If the problem continues, run a diagnostic.',
      'invalid_arguments':
          'The information needed for this VPN operation is incomplete. Try again. If the problem continues, run a diagnostic.',
      'invalid_account_id':
          'The native operation is not associated with a valid account identifier.',
      'invalid_device_id':
          'The device identifier sent to the native engine is missing or invalid.',
      'storage_key_not_allowed':
          'The Android bridge blocked a key outside the allowed storage list.',
      'secure_storage_read_failed':
          'Android Keystore could not decrypt this account’s local data.',
      'secure_storage_write_failed':
          'Android Keystore could not encrypt or save the local data.',
      'key_generation_failed':
          'Android could not create or read the WireGuard key in secure storage.',
      'csr_generation_failed':
          'Android Keystore could not create or sign the OpenVPN P-256 CSR.',
      'other':
          'An undocumented native branch failed. Send the diagnostic code shown below to support.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Permission request already open';

  @override
  String get notice_permissionRequestInProgress_message =>
      'The Android VPN permission request is already displayed. Complete it before trying again.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN permission request interrupted';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'The VPN permission screen closed before the app received a response.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN connection not confirmed';

  @override
  String get notice_openvpnProofMissing_message =>
      'The OpenVPN connection could not be confirmed. It was stopped for safety. Try again.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profile revoked';

  @override
  String get openvpnCleanup_working =>
      'Stopping and removing the revoked OpenVPN profile…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN shutdown has not been confirmed. Retry before creating a new profile.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'The revoked OpenVPN profile could not be fully removed. Retry cleanup.';

  @override
  String get openvpnCleanup_complete =>
      'The revoked OpenVPN profile has been removed. Tap Connect to create a new one.';

  @override
  String get network_title => 'Network configuration';

  @override
  String get network_ipv4Fallback =>
      'IPv6 is temporarily unavailable. Preparation continues with IPv4.';

  @override
  String get network_rejectedTitle => 'Network configuration rejected';

  @override
  String get network_rejectedMessage =>
      'The tunnel configuration is incomplete or does not match the authorized addresses. Try again from the app.';

  @override
  String get network_unreadableTitle => 'Local configuration unreadable';

  @override
  String get network_unreadableMessage =>
      'The saved OpenVPN network configuration cannot be used. Reconnect from the app to update it.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Network protection';

  @override
  String get protection_subtitle =>
      'Block direct internet access if the VPN disconnects.';

  @override
  String get protection_active => 'System protection active';

  @override
  String get protection_alwaysOnOnly =>
      'Always-on VPN enabled; turn on blocking outside the VPN';

  @override
  String get protection_inactive => 'System protection inactive';

  @override
  String get protection_unknown => 'Check system protection';

  @override
  String get protection_openSettings => 'Open Android settings';

  @override
  String get protection_dialogTitle => 'Set up network protection';

  @override
  String get protection_dialogMessage =>
      'Android manages always-on VPN and blocking connections outside the VPN. Check that FuzeVPN is selected and enable blocking in system settings.';

  @override
  String get protection_dialogOpen => 'Open settings';

  @override
  String get session_systemProtectionNote =>
      'If Android is still blocking traffic outside the VPN, open system settings to check or change this protection.';

  @override
  String get diagnostics_title => 'Diagnostics';

  @override
  String get diagnostics_settingsTitle => 'App diagnostics';

  @override
  String get diagnostics_automaticTitle => 'Send important errors';

  @override
  String get diagnostics_automaticDescription =>
      'Share a small technical report when an important error occurs.';

  @override
  String get diagnostics_privacy =>
      'Sent reports are linked to the signed-in account and kept for 30 days. They contain no browsing history, passwords or VPN keys.';

  @override
  String get diagnostics_manualOpen => 'Run diagnostics';

  @override
  String get diagnostics_localDescription =>
      'Create a report of the app and VPN status. Your connection stays unchanged.';

  @override
  String get diagnostics_sendReport => 'Send the report';

  @override
  String get diagnostics_sendHint =>
      'Leave this box unchecked to keep the report on this device.';

  @override
  String get diagnostics_signedOut =>
      'Sign in to your account to send a report.';

  @override
  String get diagnostics_localLifetime =>
      'Save this report on your phone to keep it after closing the app.';

  @override
  String get diagnostics_run => 'Run diagnostics';

  @override
  String get diagnostics_rerun => 'Run diagnostics again';

  @override
  String get diagnostics_running => 'Checking…';

  @override
  String get diagnostics_sending => 'Sending report…';

  @override
  String get diagnostics_prepared => 'Report ready on this device';

  @override
  String get diagnostics_queued => 'Report waiting to be sent';

  @override
  String get diagnostics_sent => 'Report received';

  @override
  String get diagnostics_failed =>
      'Sending failed. Your local report is still available.';

  @override
  String get diagnostics_preparationFailed =>
      'The diagnostic report could not be prepared. Try again.';

  @override
  String get diagnostics_authenticationRequired =>
      'Sign in again to send the report.';

  @override
  String get diagnostics_retry => 'Retry sending';

  @override
  String get diagnostics_export => 'Save report';

  @override
  String get diagnostics_exportFailed =>
      'Export failed. Try again from the local report.';

  @override
  String get diagnostics_preferenceFailed =>
      'This setting could not be saved. Try again.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Reference: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Received on $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Kept until $date';
  }

  @override
  String get diagnostics_duplicate => 'This report had already been received.';

  @override
  String get diagnostics_preview => 'Report preview';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count technical events attached',
      one: '1 technical event attached',
      zero: 'No technical events attached',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Technical details';

  @override
  String get diagnostics_empty => 'No diagnostic report has been prepared yet.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunnel state',
      'handshake': 'Connection confirmation',
      'certificate': 'VPN certificate',
      'kill_switch': 'Android protection',
      'connectivity': 'Available network',
      'api_reachability': 'Service access',
      'secure_storage': 'Secure storage',
      'other': 'Local check',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Checked',
      'failed': 'Needs attention',
      'skipped': 'Not tested — no active probe',
      'unknown': 'Information unavailable',
      'other': 'Information unavailable',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Welcome to FuzeVPN';

  @override
  String get connection_changeLocation => 'Change location';

  @override
  String get connection_details => 'Connection details';

  @override
  String get locations_searchLabel => 'Search a city or country';

  @override
  String get locations_clearSearch => 'Clear search';

  @override
  String get locations_filterAll => 'All';

  @override
  String get locations_filterFavorites => 'Favorites';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locations',
      one: '$count location',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'No locations found';

  @override
  String get locations_noResultsHint => 'Try another city or country.';

  @override
  String get locations_noFavorites => 'Your favorites, close at hand';

  @override
  String get locations_noFavoritesHint =>
      'Tap the star beside a location to save it here.';

  @override
  String get locations_showAll => 'See all locations';

  @override
  String locations_addFavorite(String name) {
    return 'Add $name to favorites';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Remove $name from favorites';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'The favorite could not be saved. Try again.';

  @override
  String get locations_emptyTitle => 'No locations available';

  @override
  String get locations_emptyHint => 'Refresh the list to try again.';

  @override
  String get devices_manage => 'Manage my devices';

  @override
  String get settings_personalization => 'Make it yours';

  @override
  String get settings_safety => 'Protection';

  @override
  String get settings_help => 'Need help?';

  @override
  String get settings_about => 'About FuzeVPN';

  @override
  String get diagnostics_heading => 'Understand a connection problem';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Available',
      'pending': 'Preparing',
      'revoked': 'Removed',
      'expired': 'Expired',
      'other': 'Status unavailable',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preference not saved';

  @override
  String get notice_preferenceSave_message =>
      'Your choice is applied for now, but could not be saved. Try again to keep it after closing the app.';

  @override
  String get connection_androidDisconnectHint =>
      'If Android keeps the VPN active, turn off Always-on VPN in the settings that open.';

  @override
  String get protection_learnMore => 'Learn about Android protection';

  @override
  String get protection_guideWhy =>
      'This protection prevents apps from using the internet directly if the VPN disconnects. It is configured in Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Always-on VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android keeps the VPN service running and can restart it after the phone reboots.';

  @override
  String get protection_guideBlockTitle => 'Block connections without VPN';

  @override
  String get protection_guideBlock =>
      'This setting prevents traffic from bypassing the VPN, including while the connection is interrupted.';

  @override
  String get protection_guideWarning =>
      'With this blocking enabled, internet access stays off until the VPN is connected.';

  @override
  String get protection_guideStepsTitle => 'Turn on protection';

  @override
  String get protection_guideStep1 =>
      'Open Android VPN settings with the button below.';

  @override
  String get protection_guideStep2 =>
      'Open the options using the gear icon beside FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Enable Always-on VPN, then Block connections without VPN, if these options are available.';

  @override
  String get protection_guideManufacturers =>
      'Names vary by phone. If needed, search for VPN in Settings, often under Network & internet.';

  @override
  String get protection_guideDisableTitle => 'Turn off this protection';

  @override
  String get protection_guideDisable =>
      'In the same settings, turn off blocking without VPN to allow internet access without the VPN. Also turn off Always-on VPN if you no longer want Android to restart it.';

  @override
  String get protection_guideManual =>
      'You choose these settings in Android. FuzeVPN does not change them for you.';

  @override
  String get locations_changeTitle => 'Change location?';

  @override
  String locations_changeActive(String name) {
    return 'The VPN will disconnect, then try to connect to $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'The VPN will try to connect to $name.';
  }

  @override
  String get locations_confirmChange => 'Change and connect';

  @override
  String get locations_changeBusy =>
      'A change is in progress. Wait before choosing another location.';

  @override
  String get locations_automaticSelection => 'Automatic selection';

  @override
  String get locations_cities => 'Cities';

  @override
  String get locations_servers => 'Servers';

  @override
  String locations_viewCities(String name) {
    return 'View cities in $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'View servers in $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count countries',
      one: '$count country',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cities',
      one: '$count city',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servers',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'All countries';

  @override
  String get locations_backToCountries => 'Back to countries';

  @override
  String locations_backToCities(String name) {
    return 'Back to cities in $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Choose $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Choose $name';
  }

  @override
  String get locations_noCompatibleServer => 'No compatible server available.';

  @override
  String get externalLink_failed =>
      'Unable to open this link. You can copy it and open it in your browser.';

  @override
  String get externalLink_copy => 'Copy link';

  @override
  String get externalLink_copied => 'Link copied';

  @override
  String get externalLink_copyFailed =>
      'Unable to copy the link. Select the address below.';

  @override
  String get settings_deleteAccount => 'Delete my account';

  @override
  String get settings_deleteAccountDetail =>
      'View the account deletion request procedure';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Choose your VPN subscription.';

  @override
  String get billing_subscribe => 'Subscribe';

  @override
  String get billing_choosePlan => 'Choose a plan to continue.';

  @override
  String get billing_monthly => 'Monthly';

  @override
  String get billing_yearly => 'Yearly';

  @override
  String get billing_continue => 'Continue with Google Play';

  @override
  String get billing_restore => 'Restore purchases';

  @override
  String get billing_manage => 'Manage subscription';

  @override
  String get billing_deleteAccountWarning =>
      'If you have a Google Play subscription, deleting your FuzeVPN account does not cancel its renewal. Manage or cancel the renewal separately in Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Continue to account deletion request';

  @override
  String get billing_refresh => 'Refresh access';

  @override
  String get billing_loadingPlans => 'Loading plans…';

  @override
  String get billing_unavailable =>
      'No plans are available right now. Try again later.';

  @override
  String get billing_comingSoon => 'Subscriptions coming soon.';

  @override
  String get billing_priceDisclosure =>
      'Price provided by Google Play. The final amount is confirmed before payment.';

  @override
  String get billing_renewalMonthly =>
      'Renews automatically every month unless cancelled. You can cancel anytime in Google Play subscriptions.';

  @override
  String get billing_renewalYearly =>
      'Renews automatically every year unless cancelled. You can cancel anytime in Google Play subscriptions.';

  @override
  String get billing_active => 'Your Premium access is active';

  @override
  String billing_accessUntil(String date) {
    return 'Access until $date.';
  }

  @override
  String get billing_webManaged =>
      'Your subscription is managed on the FuzeVPN website.';

  @override
  String get billing_playManaged =>
      'Your subscription is managed by Google Play.';

  @override
  String get billing_inactive => 'No active subscription.';

  @override
  String get billing_checkingAccess => 'Checking your access…';

  @override
  String get billing_restoring => 'Restoring purchases…';

  @override
  String get billing_pending =>
      'Payment is pending. Your access will activate after confirmation.';

  @override
  String get billing_cancelled =>
      'Purchase cancelled. No new subscription was activated.';

  @override
  String get billing_verifying => 'Verifying purchase…';

  @override
  String get billing_success =>
      'Subscription activated. Your Premium access is ready.';

  @override
  String get billing_restored => 'Your purchases have been restored.';

  @override
  String get billing_restoreEmpty =>
      'No purchases to restore for this Google Play account.';

  @override
  String get billing_catalogError => 'Unable to load plans. Try again.';

  @override
  String get billing_purchaseError =>
      'Unable to start the purchase. Try again.';

  @override
  String get billing_verificationError =>
      'Purchase verification is temporarily unavailable. Restore purchases to try again.';

  @override
  String get billing_restoreError => 'Unable to restore purchases. Try again.';

  @override
  String get billing_managementError =>
      'Unable to open subscription management. Try again.';

  @override
  String get billing_storeUnavailable =>
      'Google Play is unavailable on this device.';

  @override
  String get welcome_title => 'Your VPN, made simple.';

  @override
  String get welcome_description =>
      'Protect your connection. Stay in control of your privacy.';

  @override
  String get welcome_start => 'Get started';

  @override
  String get welcome_alreadyPurchased => 'Already purchased?';

  @override
  String get welcome_noAccountRequired => 'No account needed to get started.';

  @override
  String get guest_accountTitle => 'Account not linked';

  @override
  String get guest_accountDescription =>
      'Restore your purchases with the same Google Play account to use your subscription on another device.';

  @override
  String get guest_existingSubscriberSignIn => 'Already subscribed? Sign in';

  @override
  String get guest_claimTitle => 'Take FuzeVPN with you';

  @override
  String get guest_claimDescription =>
      'Create an account to access your subscription on your other devices. This step is optional.';

  @override
  String get guest_skip => 'Maybe later';

  @override
  String get guest_activationTitle => 'Fuze Premium is active';

  @override
  String get guest_activationDescription =>
      'Your subscription is ready. Use your VPN and create an account whenever you like.';

  @override
  String get guest_useVpn => 'Use my VPN';

  @override
  String get guest_loginRequired =>
      'This purchase is already linked to a FuzeVPN account. Sign in to that account to access your subscription.';

  @override
  String get guest_signOutWarning =>
      'You can recover your subscription by restoring purchases with the same Google Play account.';

  @override
  String get guest_profileUnavailable =>
      'Your account is already linked. Sign in to view and manage your details.';

  @override
  String get billing_acceptance =>
      'By continuing, you accept the Terms of Use and Privacy Policy.';

  @override
  String get guest_verifyEmailReminder =>
      'Confirm your email address to secure your account. You can keep using your VPN.';

  @override
  String get guest_serviceUnavailable =>
      'The service is temporarily unavailable. Try again shortly.';

  @override
  String get guest_restoreError =>
      'Your purchases could not be restored. Try again with the Google Play account used for the purchase.';

  @override
  String get guest_claimSuccess =>
      'Your account has been created. Your subscription and VPN access are preserved.';

  @override
  String get guest_emailExists =>
      'This email is already in use. Choose another address or sign in to your existing account. Your purchase remains available through Google Play.';

  @override
  String get guest_claimError =>
      'Your account could not be created. You can keep using your VPN and try again later.';

  @override
  String get guest_secureStorageError =>
      'Your session could not be secured on this device. Try again.';

  @override
  String get guest_premiumRequired =>
      'Choose a subscription to activate your VPN.';

  @override
  String get welcome_viewPlans => 'View plans';

  @override
  String get google_continue => 'Continue with Google';

  @override
  String get google_or => 'or';

  @override
  String get google_title => 'Your FuzeVPN account';

  @override
  String get google_settingUp => 'Finish creating your account';

  @override
  String get google_country => 'Country of residence';

  @override
  String get google_profileDescription =>
      'Choose your country and review the two documents to create your FuzeVPN account.';

  @override
  String get google_claimDescription =>
      'Link your guest account to Google. Your subscription and device stay attached to this account.';

  @override
  String get google_linkTitle => 'Link Google to FuzeVPN';

  @override
  String get google_linkDescription =>
      'Confirm access to your existing FuzeVPN account. This step does not ask for your Google password.';

  @override
  String get google_password => 'FuzeVPN password';

  @override
  String get google_linkAccount => 'Confirm the link';

  @override
  String get google_requestEmail => 'Send me a confirmation email';

  @override
  String get google_emailInstructions =>
      'Open the FuzeVPN email and enter the confirmation code.';

  @override
  String get google_emailCode => 'Email confirmation code';

  @override
  String get google_confirmEmail => 'Confirm the code';

  @override
  String get google_restart => 'Choose another Google account';

  @override
  String get google_resume => 'Check this attempt';

  @override
  String get google_unavailable =>
      'Google sign-in is unavailable. You can use email and password.';

  @override
  String get google_expired =>
      'This attempt has expired. Cancel it and start again.';

  @override
  String get google_conflict =>
      'This Google account is already linked elsewhere. Your current account and subscription are kept.';

  @override
  String get google_error =>
      'Google sign-in failed. Try again; your current access is kept.';

  @override
  String get google_uncertain =>
      'The result could not be confirmed. Check this attempt or cancel it before starting again.';

  @override
  String get google_cancelFailed =>
      'Cancellation could not be confirmed. Try cancelling again before leaving this screen.';

  @override
  String get google_cancelled => 'Google sign-in cancelled.';

  @override
  String get google_selecting => 'Choose your Google account…';

  @override
  String get google_verifying => 'Checking your account…';

  @override
  String get google_emailUnavailable =>
      'The confirmation email could not be sent. Try again later.';

  @override
  String get google_emailSent => 'Confirmation email sent. Check your inbox.';

  @override
  String get google_rateLimited => 'Please wait before trying again.';

  @override
  String get google_invalidPassword =>
      'The FuzeVPN password is incorrect. Your current account is kept.';

  @override
  String get google_invalidCode =>
      'The confirmation code is invalid or expired.';

  @override
  String get google_accountChanged =>
      'Your session has changed. Cancel this attempt before starting again.';

  @override
  String get google_invalidResponse =>
      'The response could not be validated. Your current access is kept.';

  @override
  String get google_invalidRegistration =>
      'Check your country and both consents.';

  @override
  String get google_consentRequired =>
      'Choose your country and accept both documents to continue.';

  @override
  String get google_challengeRequired =>
      'An additional security check is required. Your current access is kept.';

  @override
  String get google_challengeUnavailable =>
      'The security check is unavailable. Try again later.';
}
