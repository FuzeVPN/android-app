// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get vpnDisclosure_title => 'ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ರಕ್ಷಿಸಿ';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN, ಈ ಸಾಧನ ಮತ್ತು FuzeVPN ಸರ್ವರ್‌ಗಳ ನಡುವೆ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ ಟನಲ್ ರಚಿಸಲು Android ನ VPN ಸೇವೆಯನ್ನು (VpnService) ಬಳಸುತ್ತದೆ.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN ಸಕ್ರಿಯವಾಗಿರುವಾಗ, ನಿಮ್ಮ ಆ್ಯಪ್‌ಗಳ ಇಂಟರ್ನೆಟ್ ಟ್ರಾಫಿಕ್, ಗಮ್ಯಸ್ಥಾನದ ವಿಳಾಸಗಳು ಮತ್ತು DNS ವಿನಂತಿಗಳು ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ರೂಟ್ ಮಾಡಲು ಈ ಟನಲ್ ಮೂಲಕ ಹಾದುಹೋಗುತ್ತವೆ, FuzeVPN ಹಿನ್ನೆಲೆಯಲ್ಲಿದ್ದರೂ ಸಹ.';

  @override
  String get vpnDisclosure_statusBody =>
      'ನಿಮ್ಮ VPN ಸಂಪರ್ಕವನ್ನು ತೋರಿಸಲು ಈ ಆ್ಯಪ್ ಸಂಪರ್ಕದ ಸ್ಥಿತಿ, ಅದರ ಅವಧಿ ಮತ್ತು ವರ್ಗಾವಣೆಯಾದ ಡೇಟಾದ ಪ್ರಮಾಣವನ್ನು ಬಳಸುತ್ತದೆ. ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ಅದನ್ನು ನಿಲ್ಲಿಸಬಹುದು.';

  @override
  String get vpnDisclosure_privacy => 'ಗೌಪ್ಯತೆ';

  @override
  String get vpnDisclosure_accept => 'ಒಪ್ಪಿಕೊಂಡು ಮುಂದುವರಿಸಿ';

  @override
  String get vpnDisclosure_decline => 'ಈಗ ಬೇಡ';

  @override
  String get accountRestoration_title => 'ಖಾತೆ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String get accountRestoration_message =>
      'ನಿಮ್ಮ ಸೆಷನ್ ಉಳಿಸಲಾಗಿದೆ. ಖಾತೆಯನ್ನು ಮರುಸ್ಥಾಪಿಸಲು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ; ನೀವು ಇಲ್ಲಿಯೇ VPN ಸಂಪರ್ಕವನ್ನು ಇನ್ನೂ ನಿರ್ವಹಿಸಬಹುದು.';

  @override
  String get action_retry => 'ಮರುಪ್ರಯತ್ನಿಸಿ';

  @override
  String get session_endingTitle => 'ಸೆಷನ್ ಕೊನೆಗೊಳಿಸಲಾಗುತ್ತಿದೆ';

  @override
  String get session_ending =>
      'ಸೆಷನ್ ಕೊನೆಗೊಳಿಸಲಾಗುತ್ತಿದೆ: VPN ನಿಲ್ಲಿಸಲಾಗುತ್ತಿದೆ ಮತ್ತು ಸ್ವಚ್ಛಗೊಳಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get session_stopFailed =>
      'VPN ನಿಲುಗಡೆಯನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ. ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡುವ ಮೊದಲು ಮರುಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get session_cleanupFailed =>
      'VPN ನಿಲ್ಲಿಸಲಾಗಿದೆ, ಆದರೆ ಸೆಷನ್ ತೆಗೆದುಹಾಕುವಿಕೆಯನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ. ಸ್ವಚ್ಛಗೊಳಿಸಲು ಮರುಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get session_retryStop => 'ನಿಲ್ಲಿಸಲು ಮರುಪ್ರಯತ್ನಿಸಿ';

  @override
  String get session_retryCleanup => 'ಸ್ವಚ್ಛಗೊಳಿಸಲು ಮರುಪ್ರಯತ್ನಿಸಿ';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN ಅನ್ನು ಸುರಕ್ಷಿತವಾಗಿ ಸಿದ್ಧಗೊಳಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get nav_connection => 'ಸಂಪರ್ಕ';

  @override
  String get nav_locations => 'ಸ್ಥಳಗಳು';

  @override
  String get nav_account => 'ಖಾತೆ';

  @override
  String get nav_devices => 'ಸಾಧನಗಳು';

  @override
  String get nav_settings => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get action_refresh => 'ರಿಫ್ರೆಶ್ ಮಾಡಿ';

  @override
  String get auth_tab_login => 'ಸೈನ್ ಇನ್';

  @override
  String get auth_tab_register => 'ಸೈನ್ ಅಪ್';

  @override
  String get auth_stepAccount => 'ಖಾತೆ';

  @override
  String get auth_stepIdentity => 'ಗುರುತು';

  @override
  String get auth_stepAddress => 'ವಿಳಾಸ ಮತ್ತು ಒಪ್ಪಂದಗಳು';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'ಹಂತ $current / $total';
  }

  @override
  String get auth_tagline => 'ನಿಮ್ಮ VPN, ಈಗ ಸರಳ.';

  @override
  String get auth_keysLocal =>
      'ನಿಮ್ಮ ಖಾಸಗಿ VPN ಕೀಗಳು ಈ ಸಾಧನದಲ್ಲಿಯೇ ಉಳಿಯುತ್ತವೆ.';

  @override
  String get form_email => 'ಇಮೇಲ್ ವಿಳಾಸ';

  @override
  String get form_password => 'ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get form_showPassword => 'ಪಾಸ್‌ವರ್ಡ್ ತೋರಿಸಿ';

  @override
  String get form_hidePassword => 'ಪಾಸ್‌ವರ್ಡ್ ಮರೆಮಾಡಿ';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 ಬೈಟ್‌ಗಳು. ಕೆಲವು ಅಕ್ಷರಗಳು ಒಂದಕ್ಕಿಂತ ಹೆಚ್ಚು ಬೈಟ್ ಬಳಸುತ್ತವೆ.';

  @override
  String get form_firstName => 'ಮೊದಲ ಹೆಸರು';

  @override
  String get form_lastName => 'ಕೊನೆಯ ಹೆಸರು';

  @override
  String get form_phone => 'ಫೋನ್ (+33612345678)';

  @override
  String get form_address => 'ವಿಳಾಸ';

  @override
  String get form_address2 => 'ವಿಳಾಸದ ಎರಡನೇ ಸಾಲು (ಐಚ್ಛಿಕ)';

  @override
  String get form_postalCode => 'ಅಂಚೆ ಕೋಡ್';

  @override
  String get form_city => 'ನಗರ';

  @override
  String get form_country => 'ದೇಶದ ಕೋಡ್ (ಉದಾ. FR)';

  @override
  String get action_login => 'ಸೈನ್ ಇನ್';

  @override
  String get action_createAccount => 'ಖಾತೆ ರಚಿಸಿ';

  @override
  String get action_createMyAccount => 'ನನ್ನ ಖಾತೆ ರಚಿಸಿ';

  @override
  String get action_next => 'ಮುಂದುವರಿಸಿ';

  @override
  String get action_previous => 'ಹಿಂದೆ';

  @override
  String get action_forgotPassword => 'ಪಾಸ್‌ವರ್ಡ್ ಮರೆತಿರಾ?';

  @override
  String get auth_noAccount => 'ಇನ್ನೂ ಖಾತೆ ಇಲ್ಲವೇ?';

  @override
  String get auth_requiredInformation =>
      'ಮೂರು ಹಂತಗಳಲ್ಲಿ ನಿಮ್ಮ ಖಾತೆಯನ್ನು ರಚಿಸಿ.';

  @override
  String get auth_termsPrefix => 'ನಾನು ಒಪ್ಪುತ್ತೇನೆ: ';

  @override
  String get auth_termsLink => 'ಬಳಕೆಯ ನಿಯಮಗಳು';

  @override
  String get auth_privacyPrefix => 'ನಾನು ಒಪ್ಪುತ್ತೇನೆ: ';

  @override
  String get auth_privacyLink => 'ಗೌಪ್ಯತಾ ನೀತಿ';

  @override
  String get auth_consentRequired => 'ಖಾತೆ ರಚಿಸಲು ನಿಮ್ಮ ಒಪ್ಪಿಗೆ ಅಗತ್ಯ.';

  @override
  String get validation_required => 'ಈ ಕ್ಷೇತ್ರ ಕಡ್ಡಾಯ.';

  @override
  String get validation_email => 'ಮಾನ್ಯವಾದ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ನಮೂದಿಸಿ.';

  @override
  String get validation_password =>
      'ಪಾಸ್‌ವರ್ಡ್ ತುಂಬಾ ಚಿಕ್ಕದಾಗಿದೆ: ಕನಿಷ್ಠ 8 UTF-8 ಬೈಟ್‌ಗಳಿರಬೇಕು.';

  @override
  String get validation_passwordTooLong =>
      'ಪಾಸ್‌ವರ್ಡ್ ತುಂಬಾ ಉದ್ದವಾಗಿದೆ: ಗರಿಷ್ಠ 72 UTF-8 ಬೈಟ್‌ಗಳಿರಬೇಕು.';

  @override
  String get validation_phone =>
      'ಅಂತರರಾಷ್ಟ್ರೀಯ ಸ್ವರೂಪವನ್ನು ಬಳಸಿ, ಉದಾಹರಣೆಗೆ +33612345678.';

  @override
  String get validation_country => 'ಎರಡು ಅಕ್ಷರಗಳ ದೇಶದ ಕೋಡ್ ಬಳಸಿ, ಉದಾಹರಣೆಗೆ FR.';

  @override
  String get passwordReset_title => 'ಪಾಸ್‌ವರ್ಡ್ ಮರುಹೊಂದಿಸಿ';

  @override
  String get passwordReset_description =>
      'ಪಾಸ್‌ವರ್ಡ್ ಮರುಹೊಂದಿಸುವ ಲಿಂಕ್ ಪಡೆಯಲು ನಿಮ್ಮ ಖಾತೆಯ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ನಮೂದಿಸಿ.';

  @override
  String get passwordReset_send => 'ಲಿಂಕ್ ಕಳುಹಿಸಿ';

  @override
  String get connection_title => 'ನಿಮ್ಮ ಸಂಪರ್ಕ';

  @override
  String get connection_subtitle =>
      'ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ, ನಂತರ ನಿಮ್ಮ VPN ಆನ್ ಮಾಡಿ.';

  @override
  String get connection_prepare => 'ಸಂಪರ್ಕಿಸಲು ಸಿದ್ಧರಿದ್ದೀರಾ?';

  @override
  String get connection_advancedOptions => 'ಸುಧಾರಿತ ಆಯ್ಕೆಗಳು';

  @override
  String get connection_location => 'ಸ್ಥಳ';

  @override
  String get connection_chooseLocation => 'ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get connection_protocol => 'ಪ್ರೋಟೋಕಾಲ್';

  @override
  String get connection_connect => 'ಸಂಪರ್ಕಿಸಿ';

  @override
  String get connection_connecting => 'ಸಂಪರ್ಕಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get connection_disconnect => 'ಸಂಪರ್ಕ ಕಡಿತಗೊಳಿಸಿ';

  @override
  String get connection_disconnecting => 'ಸಂಪರ್ಕ ಕಡಿತಗೊಳಿಸಲಾಗುತ್ತಿದೆ';

  @override
  String get connection_locationChange => 'ಸ್ಥಳ ಬದಲಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ಲಭ್ಯವಿಲ್ಲ';
  }

  @override
  String get connection_activeLocation => 'ಸಕ್ರಿಯ ಸ್ಥಳ';

  @override
  String get connection_duration => 'ಅವಧಿ';

  @override
  String get connection_received => 'ಸ್ವೀಕರಿಸಲಾಗಿದೆ';

  @override
  String get connection_sent => 'ಕಳುಹಿಸಲಾಗಿದೆ';

  @override
  String get connection_lastHandshake => 'ಕೊನೆಯ ಸುರಕ್ಷಿತ ವಿನಿಮಯ';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ಹಿಂದೆ';
  }

  @override
  String get verification_title => 'ನಿಮ್ಮ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ದೃಢೀಕರಿಸಿ';

  @override
  String get verification_message =>
      'ಈ ಫೋನ್‌ನಲ್ಲಿ VPN ಬಳಸಲು ನಿಮ್ಮ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ದೃಢೀಕರಿಸಿ.';

  @override
  String get verification_resend => 'ಇಮೇಲ್ ಮತ್ತೆ ಕಳುಹಿಸಿ';

  @override
  String get migration_title => 'ಸ್ಥಳ ಬದಲಾವಣೆ';

  @override
  String get migration_draining => 'ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ಸಿದ್ಧಗೊಳಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get migration_activating => 'ಹೊಸ ಸರ್ವರ್ ಅನ್ನು ಸಕ್ರಿಯಗೊಳಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get migration_ready => 'ಸ್ಥಳವನ್ನು ನವೀಕರಿಸಲಾಗಿದೆ.';

  @override
  String get migration_blocked =>
      'ಸ್ಥಳ ಬದಲಾವಣೆಗೆ ಸರ್ವರ್ ಕಡೆಯಿಂದ ಮಧ್ಯಪ್ರವೇಶ ಅಗತ್ಯವಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ ಅಥವಾ ಬೆಂಬಲ ತಂಡವನ್ನು ಸಂಪರ್ಕಿಸಿ.';

  @override
  String get migration_progress => 'ಸ್ಥಳ ಬದಲಾವಣೆಯ ಪ್ರಗತಿ';

  @override
  String migration_retryDelay(Object seconds) {
    return 'ಪರಿಶೀಲನೆಗಳ ನಡುವಿನ ವಿಳಂಬ: $seconds ಸೆ.';
  }

  @override
  String get migration_resume => 'ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ಮುಂದುವರಿಸಿ';

  @override
  String get status_authorizing => 'ಅನುಮತಿ ಅಗತ್ಯ';

  @override
  String get status_authorizingDetail =>
      'VPN ಅನ್ನು ಅನುಮತಿಸಲು Android ವಿನಂತಿಯನ್ನು ಒಪ್ಪಿಕೊಳ್ಳಿ.';

  @override
  String get status_preparing => 'ಸಿದ್ಧತೆ';

  @override
  String get status_preparingDetail =>
      'ನಿಮ್ಮ ಸುರಕ್ಷಿತ ಸಂಪರ್ಕವನ್ನು ಸಿದ್ಧಗೊಳಿಸಲಾಗುತ್ತಿದೆ.';

  @override
  String get status_reconnecting => 'ಮತ್ತೆ ಸಂಪರ್ಕ…';

  @override
  String get status_reconnectingDetail =>
      'ಸಂಪರ್ಕಕ್ಕೆ ಅಡಚಣೆಯಾಗಿದೆ. VPN ಮತ್ತೆ ಸಂಪರ್ಕಿಸಲು ಪ್ರಯತ್ನಿಸುತ್ತಿದೆ.';

  @override
  String get status_connecting => 'ಸಂಪರ್ಕ ಸಾಧಿಸುತ್ತಿದೆ';

  @override
  String get status_connectingDetail => 'VPN ಸರ್ವರ್‌ಗೆ ಸಂಪರ್ಕಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get status_connected => 'ಸಂಪರ್ಕಿತ';

  @override
  String get status_connectedDetail => 'ನಿಮ್ಮ VPN ಸಂಪರ್ಕ ಸಕ್ರಿಯವಾಗಿದೆ.';

  @override
  String get status_disconnecting => 'ಸಂಪರ್ಕ ಕಡಿತ ಆಗುತ್ತಿದೆ';

  @override
  String get status_disconnectingDetail => 'ನಿಮ್ಮ VPN ಸಂಪರ್ಕ ನಿಲ್ಲುತ್ತಿದೆ.';

  @override
  String get status_error => 'ಸಂಪರ್ಕ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String get status_errorDetail =>
      'VPN ಸಂಪರ್ಕವನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get status_idle => 'ಸಂಪರ್ಕ ಕಡಿತ';

  @override
  String get status_idleDetail =>
      'ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ರಕ್ಷಿಸಲು VPN ಗೆ ಸಂಪರ್ಕಿಸಿ.';

  @override
  String get trust_note =>
      'ಆ್ಯಪ್ ಮುಚ್ಚುವುದರಿಂದ VPN ನಿಲ್ಲುವುದಿಲ್ಲ. ನಿಲ್ಲಿಸಲು ‘ಸಂಪರ್ಕ ಕಡಿತಗೊಳಿಸಿ’ ಬಳಸಿ.';

  @override
  String get locations_none => 'ಸದ್ಯಕ್ಕೆ ಯಾವುದೇ ಸ್ಥಳಗಳು ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get locations_available => 'ನಿಮ್ಮ ಮುಂದಿನ ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get locations_selected => 'ಆಯ್ಕೆಮಾಡಿದ ಸ್ಥಳ';

  @override
  String get locations_select => 'ಈ ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get locations_lockedTunnel => 'ಸ್ಥಳ ಬದಲಿಸಲು VPN ಸಂಪರ್ಕ ಕಡಿತಗೊಳಿಸಿ.';

  @override
  String get locations_lockedMigration => 'ಸ್ಥಳ ಬದಲಾವಣೆ ಮುಗಿಯುವವರೆಗೆ ಕಾಯಿರಿ.';

  @override
  String get devices_title => 'ನಿಮ್ಮ ಸಾಧನಗಳು';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ಸಾಧನಗಳು';
  }

  @override
  String get devices_refresh => 'ಸಾಧನಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ';

  @override
  String get devices_empty => 'ಇನ್ನೂ ಯಾವುದೇ VPN ಸಾಧನ ನೋಂದಾಯಿಸಲಾಗಿಲ್ಲ.';

  @override
  String get devices_firstConnection =>
      'ಮೊದಲ ಸಂಪರ್ಕದಲ್ಲಿ ನಿಮ್ಮ ಫೋನ್ ಸೇರಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get devices_thisDevice => 'ಈ ಸಾಧನ';

  @override
  String devices_added(Object date) {
    return '$date ರಂದು ಸೇರಿಸಲಾಗಿದೆ';
  }

  @override
  String get devices_unnamed => 'ಹೆಸರಿಲ್ಲದ ಸಾಧನ';

  @override
  String get action_remove => 'ತೆಗೆದುಹಾಕಿ';

  @override
  String get settings_title => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get settings_subtitle =>
      'ನಿಮ್ಮ ಆದ್ಯತೆಗಳು ಮತ್ತು ಖಾತೆ, ಎಲ್ಲವೂ ಒಂದೇ ಸ್ಥಳದಲ್ಲಿ.';

  @override
  String get settings_appearance => 'ಗೋಚರತೆ';

  @override
  String get settings_language => 'ಭಾಷೆ';

  @override
  String get settings_languageDescription =>
      'ನೀವು ಆಯ್ಕೆಮಾಡಿದ ಭಾಷೆ VPN ಅಧಿಸೂಚನೆಗಳಿಗೂ ಅನ್ವಯಿಸುತ್ತದೆ.';

  @override
  String get settings_account => 'ಖಾತೆ';

  @override
  String get settings_signOut => 'ಸೈನ್ ಔಟ್';

  @override
  String get settings_privacy => 'ಗೌಪ್ಯತಾ ನೀತಿ';

  @override
  String get settings_terms => 'ಬಳಕೆಯ ನಿಯಮಗಳು';

  @override
  String get settings_security => 'ಭದ್ರತೆ ಮತ್ತು ಪಾರದರ್ಶಕತೆ';

  @override
  String get settings_licenses => 'ಘಟಕ ಪರವಾನಗಿಗಳು';

  @override
  String get settings_licensesDetail => 'ಆ್ಯಪ್‌ನಲ್ಲಿ ಬಳಸಲಾದ ಸಾಫ್ಟ್‌ವೇರ್';

  @override
  String settings_licensesLegalese(String url) {
    return 'ಆ್ಯಪ್ ಮತ್ತು ಅದರ MPL-2.0 ಘಟಕಗಳ ಮೂಲ ಕೋಡ್: $url';
  }

  @override
  String get settings_background =>
      'ನೀವು ಆ್ಯಪ್‌ನಿಂದ ಹೊರಬಂದಾಗಲೂ VPN ಸಕ್ರಿಯವಾಗಿರುತ್ತದೆ. ಅದನ್ನು ನಿಲ್ಲಿಸಲು, ಸಂಪರ್ಕ ಟ್ಯಾಬ್‌ನಲ್ಲಿರುವ ‘ಸಂಪರ್ಕ ಕಡಿತಗೊಳಿಸಿ’ ಬಳಸಿ.';

  @override
  String get theme_system => 'ಸಿಸ್ಟಮ್';

  @override
  String get theme_light => 'ಲೈಟ್';

  @override
  String get theme_dark => 'ಡಾರ್ಕ್';

  @override
  String get language_system => 'ಫೋನ್ ಭಾಷೆ';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'ಈ ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಬೇಕೇ?';

  @override
  String get dialog_removeCurrent =>
      'ಈ ಫೋನ್ VPN ನಿಂದ ಸಂಪರ್ಕ ಕಡಿತಗೊಂಡು ಪ್ರವೇಶವನ್ನು ಕಳೆದುಕೊಳ್ಳುತ್ತದೆ. ಸರ್ವರ್ ದೃಢೀಕರಿಸಿದ ನಂತರ ಅದರ VPN ಸಂಪರ್ಕ ಡೇಟಾವನ್ನು ತೆಗೆದುಹಾಕಲಾಗುತ್ತದೆ.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name”ಗಾಗಿ VPN ಪ್ರವೇಶವನ್ನು ರದ್ದುಗೊಳಿಸಲಾಗುತ್ತದೆ. ಈ ಕ್ರಿಯೆಯನ್ನು ಹಿಂತಿರುಗಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ.';
  }

  @override
  String get dialog_signOut => 'ಸೈನ್ ಔಟ್ ಮಾಡಬೇಕೇ?';

  @override
  String get dialog_signOutMessage =>
      'VPN ನಿಲ್ಲುತ್ತದೆ ಮತ್ತು ನೀವು ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡಬೇಕಾಗುತ್ತದೆ. ನಿಮ್ಮ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ VPN ಕೀಗಳು ಮುಂದಿನ ಸಂಪರ್ಕಕ್ಕಾಗಿ ಈ ಫೋನ್‌ನಲ್ಲೇ ಉಳಿಯುತ್ತವೆ.';

  @override
  String get action_cancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get action_close => 'ಮುಚ್ಚಿರಿ';

  @override
  String get action_copy => 'ಕಾಪಿ ಮಾಡಿ';

  @override
  String get action_signOut => 'ಸೈನ್ ಔಟ್';

  @override
  String get notice_close => 'ಸಂದೇಶವನ್ನು ಮುಚ್ಚಿ';

  @override
  String get notice_sessionExpired_title => 'ಸೆಷನ್ ಅವಧಿ ಮುಗಿದಿದೆ';

  @override
  String get notice_sessionExpired_message =>
      'ನಿಮ್ಮ ಸೆಷನ್ ಅವಧಿ ಮುಗಿದಿದೆ. ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.';

  @override
  String get notice_connectionFailed_title => 'ಸಂಪರ್ಕ ವಿಫಲವಾಗಿದೆ';

  @override
  String get notice_invalidCredentials_message =>
      'ಇಮೇಲ್ ವಿಳಾಸ ಅಥವಾ ಪಾಸ್‌ವರ್ಡ್ ತಪ್ಪಾಗಿದೆ.';

  @override
  String get notice_emailVerification_title => 'ಇಮೇಲ್ ದೃಢೀಕರಣ ಅಗತ್ಯ';

  @override
  String get notice_emailVerification_message =>
      'VPN ಸಾಧನ ಸೇರಿಸುವ ಮೊದಲು ನಿಮ್ಮ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ದೃಢೀಕರಿಸಿ.';

  @override
  String get notice_rateLimited_title => 'ಹಲವು ಬಾರಿ ಪ್ರಯತ್ನಿಸಲಾಗಿದೆ';

  @override
  String get notice_deviceLimit_title => 'ಸಾಧನ ಮಿತಿ ತಲುಪಿದೆ';

  @override
  String get notice_deviceLimit_message =>
      'ಇನ್ನೊಂದು ಸಾಧನವನ್ನು ಸೇರಿಸುವ ಮೊದಲು ಈಗಿರುವ ಒಂದು ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಿ.';

  @override
  String get notice_identityRenewal_title => 'VPN ಗುರುತನ್ನು ನವೀಕರಿಸಬೇಕು';

  @override
  String get notice_identityRenewal_message =>
      'ಈ ಗುರುತನ್ನು ತೆಗೆದುಹಾಕಲಾಗಿದೆ. ಹೊಸ ಸ್ಥಳೀಯ ಗುರುತನ್ನು ರಚಿಸಿ.';

  @override
  String get notice_migrationPending_title => 'ಸ್ಥಳ ಬದಲಾವಣೆ ಪ್ರಗತಿಯಲ್ಲಿದೆ';

  @override
  String get notice_migrationPending_message =>
      'ಸ್ಥಳ ಬದಲಾವಣೆ ಈಗಾಗಲೇ ಪ್ರಗತಿಯಲ್ಲಿದೆ.';

  @override
  String get notice_migrationBlocked_title =>
      'ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ನಿರ್ಬಂಧಿಸಲಾಗಿದೆ';

  @override
  String get notice_migrationBlocked_message =>
      'ಸ್ಥಳ ಬದಲಾವಣೆಗೆ ಸರ್ವರ್ ಕಡೆಯಿಂದ ಮಧ್ಯಪ್ರವೇಶ ಅಗತ್ಯವಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ ಅಥವಾ ಬೆಂಬಲ ತಂಡವನ್ನು ಸಂಪರ್ಕಿಸಿ.';

  @override
  String get notice_targetUnavailable_title => 'ಸರ್ವರ್ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String get notice_targetUnavailable_message =>
      'ಈ ಸರ್ವರ್ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get notice_networkUnavailable_title => 'ಇಂಟರ್ನೆಟ್ ಸಂಪರ್ಕ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String get notice_networkUnavailable_message =>
      'ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ಪರಿಶೀಲಿಸಿ ಮತ್ತು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get notice_permissionDenied_title => 'VPN ಅನುಮತಿಯನ್ನು ನಿರಾಕರಿಸಲಾಗಿದೆ';

  @override
  String get notice_permissionDenied_message =>
      'ಸಂಪರ್ಕವನ್ನು ಮತ್ತೆ ಪ್ರಾರಂಭಿಸಿ ಮತ್ತು Android ಅನುಮತಿ ವಿನಂತಿಯನ್ನು ಒಪ್ಪಿಕೊಳ್ಳಿ.';

  @override
  String get notice_wireguardTimeout_title => 'ಸರ್ವರ್ ಪ್ರತಿಕ್ರಿಯಿಸುತ್ತಿಲ್ಲ';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard ಸಂಪರ್ಕಕ್ಕೆ ತುಂಬಾ ಸಮಯ ತೆಗೆದುಕೊಂಡಿತು. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ ಅಥವಾ ಬೇರೆ ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get notice_tlsFailed_title => 'ಸುರಕ್ಷಿತ ಸಂಪರ್ಕವನ್ನು ನಿರಾಕರಿಸಲಾಗಿದೆ';

  @override
  String get notice_tlsFailed_message =>
      'ಸರ್ವರ್ OpenVPN ಸಂಪರ್ಕವನ್ನು ಸ್ವೀಕರಿಸಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ. ಸಮಸ್ಯೆ ಮುಂದುವರಿದರೆ, ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ನಡೆಸಿ.';

  @override
  String get notice_tunRejected_title =>
      'Android VPN ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ತಿರಸ್ಕರಿಸಿದೆ';

  @override
  String get notice_tunRejected_message =>
      'OpenVPN ಕೋರಿದ ನೆಟ್‌ವರ್ಕ್ ಸಂರಚನೆಯನ್ನು Android ತಿರಸ್ಕರಿಸಿದೆ.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN ಪ್ರಾರಂಭಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN ಎಂಜಿನ್‌ನ ಪ್ರಾರಂಭ ಪೂರ್ಣಗೊಳ್ಳಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ. ಸಮಸ್ಯೆ ಮುಂದುವರಿದರೆ, ಬೆಂಬಲ ತಂಡವನ್ನು ಸಂಪರ್ಕಿಸಿ.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ಕೋಡ್: $code';
  }

  @override
  String get notice_generic_title => 'VPN ಸಂಪರ್ಕ ವಿಫಲವಾಗಿದೆ';

  @override
  String get notice_generic_message => 'ದೋಷ ಸಂಭವಿಸಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'ಖಾತೆ ರಚಿಸಲಾಗಿದೆ',
      'password_reset_sent': 'ಪಾಸ್‌ವರ್ಡ್ ಮರುಹೊಂದಿಸುವ ವಿನಂತಿ ಸ್ವೀಕರಿಸಲಾಗಿದೆ',
      'verification_email_sent': 'ದೃಢೀಕರಣ ಇಮೇಲ್ ಕಳುಹಿಸಲಾಗಿದೆ',
      'location_migration_pending': 'ಸ್ಥಳ ಬದಲಾವಣೆ ಪ್ರಗತಿಯಲ್ಲಿದೆ',
      'vpn_sign_in_required': 'ಸೈನ್ ಇನ್ ಅಗತ್ಯ',
      'protocol_unavailable_at_location': 'ಪ್ರೋಟೋಕಾಲ್ ಲಭ್ಯವಿಲ್ಲ',
      'vpn_permission_denied': 'VPN ಅನುಮತಿಯನ್ನು ನಿರಾಕರಿಸಲಾಗಿದೆ',
      'revoked_identity_device_limit': 'ಸಾಧನ ಮಿತಿ ತಲುಪಿದೆ',
      'tunnel_start_unexpected': 'VPN ಪ್ರಾರಂಭಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'flutter_disconnect_timeout': 'ಸಂಪರ್ಕ ಕಡಿತವನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ',
      'flutter_disconnect_unexpected': 'ಸಂಪರ್ಕ ಕಡಿತಗೊಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'device_revoked': 'ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಲಾಗಿದೆ',
      'revoke_unexpected': 'ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'identity_renewal_unexpected': 'ಗುರುತನ್ನು ನವೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'openvpn_renewal_unexpected': 'OpenVPN ಅನ್ನು ನವೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'location_migration_blocked': 'ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ನಿರ್ಬಂಧಿಸಲಾಗಿದೆ',
      'location_migration_slow': 'ಸ್ಥಳ ಬದಲಾವಣೆ ಇನ್ನೂ ಪ್ರಗತಿಯಲ್ಲಿದೆ',
      'location_migration_conflict': 'ಸ್ಥಳ ಬದಲಾವಣೆಗೆ ರಿಫ್ರೆಶ್ ಅಗತ್ಯ',
      'location_migration_verification_failed':
          'ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ',
      'location_migration_device_changed': 'ಸ್ಥಳ ಬದಲಾವಣೆಯ ವೇಳೆ ಸಾಧನ ಬದಲಾಗಿದೆ',
      'tunnel_stop_failed': 'ಸ್ಥಳ ಬದಲಾವಣೆ ಲಭ್ಯವಿಲ್ಲ',
      'device_clock_ahead': 'ಸಾಧನದ ಗಡಿಯಾರ ಮುಂದಿದೆ',
      'other': 'ಕಾರ್ಯಾಚರಣೆ ವಿಫಲವಾಗಿದೆ',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'ಖಾತೆ ರಚಿಸಲಾಗಿದೆ, ಆದರೆ ದೃಢೀಕರಣ ಇಮೇಲ್ ಕಳುಹಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಆ್ಯಪ್‌ನಲ್ಲಿರುವ ‘ಇಮೇಲ್ ಮತ್ತೆ ಕಳುಹಿಸಿ’ ಬಳಸಿ.',
      'password_reset_sent':
          'ನಿಮ್ಮ ವಿನಂತಿ ಸ್ವೀಕರಿಸಲಾಗಿದೆ. ಈ ವಿಳಾಸಕ್ಕೆ ಹೊಂದಿಕೆಯಾಗುವ ಖಾತೆ ಇದ್ದರೆ, ನಿಮಗೆ ಇಮೇಲ್ ಬರಬಹುದು. ದಯವಿಟ್ಟು ಸ್ಪ್ಯಾಮ್ ಫೋಲ್ಡರ್ ಅನ್ನೂ ಪರಿಶೀಲಿಸಿ.',
      'verification_email_sent': 'ಹೊಸ ದೃಢೀಕರಣ ಇಮೇಲ್ ಈಗಷ್ಟೇ ಕಳುಹಿಸಲಾಗಿದೆ.',
      'location_migration_pending':
          '$target‌ಗೆ ಸ್ಥಳ ಬದಲಾವಣೆಯ ಸಿದ್ಧತೆ ಇನ್ನೂ ನಡೆಯುತ್ತಿದೆ. ಸಾಧನವನ್ನು ಮತ್ತೆ ರಚಿಸದೆಯೇ ನೀವು ಇದನ್ನು ಮುಂದುವರಿಸಬಹುದು.',
      'vpn_sign_in_required':
          'VPN ಪ್ರಾರಂಭಿಸುವ ಮೊದಲು ನಿಮ್ಮ ಖಾತೆಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.',
      'protocol_unavailable_at_location':
          'ಆಯ್ಕೆಮಾಡಿದ ಪ್ರೋಟೋಕಾಲ್ ಈ ಸ್ಥಳದಲ್ಲಿ ಲಭ್ಯವಿಲ್ಲ. ಸ್ಥಳಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ ಅಥವಾ ಬೇರೆ ಪ್ರೋಟೋಕಾಲ್ ಆಯ್ಕೆಮಾಡಿ.',
      'vpn_permission_denied':
          'VPN ಅನುಮತಿಯನ್ನು Android ನಿರಾಕರಿಸಿದೆ. ಸಂಪರ್ಕವನ್ನು ಮತ್ತೆ ಪ್ರಾರಂಭಿಸಿ ಮತ್ತು ಸಿಸ್ಟಮ್ ವಿನಂತಿಯನ್ನು ಒಪ್ಪಿಕೊಳ್ಳಿ.',
      'revoked_identity_device_limit':
          'ಈ ಸಾಧನದ VPN ಪ್ರವೇಶವನ್ನು ತೆಗೆದುಹಾಕಲಾಗಿದೆ ಮತ್ತು ಸಾಧನ ಮಿತಿ ತಲುಪಿದೆ. ಖಾತೆ → ನನ್ನ ಸಾಧನಗಳನ್ನು ನಿರ್ವಹಿಸಿ ಅಡಿಯಲ್ಲಿ ಒಂದು ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಿ.',
      'tunnel_start_unexpected':
          'ಟನಲ್ ಸಿದ್ಧತೆಗೆ ಅನಿರೀಕ್ಷಿತ ದೋಷ ಅಡ್ಡಿಯಾಯಿತು. ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ಕೋಡ್ ಪರಿಶೀಲಿಸಿ ಮತ್ತು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'flutter_disconnect_timeout':
          'VPN ನಿಂತಿದೆ ಎಂಬುದನ್ನು Android ಸಮಯಕ್ಕೆ ಸರಿಯಾಗಿ ದೃಢೀಕರಿಸಲಿಲ್ಲ. ಮತ್ತೆ ನಿಲ್ಲಿಸಲು ಪ್ರಯತ್ನಿಸಿ.',
      'flutter_disconnect_unexpected':
          'ಟನಲ್ ನಿಂತಿದೆ ಎಂಬುದನ್ನು ದೃಢೀಕರಿಸುವುದನ್ನು ಅನಿರೀಕ್ಷಿತ ದೋಷ ತಡೆಯಿತು.',
      'device_revoked':
          'ಸಾಧನದ VPN ಪ್ರವೇಶವನ್ನು ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ ಮತ್ತು ಅದರ ಸ್ಥಳೀಯ ರಹಸ್ಯ ಮಾಹಿತಿಯನ್ನು ತೆಗೆದುಹಾಕಲಾಗಿದೆ.',
      'revoke_unexpected':
          'ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಪಟ್ಟಿಯನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ ಮತ್ತು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'identity_renewal_unexpected':
          'ಹೊಸ VPN ಗುರುತನ್ನು ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಸಾಧನಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ ಮತ್ತು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_renewal_unexpected':
          'OpenVPN ಪ್ರೊಫೈಲ್ ಅನ್ನು ನವೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ ಅಥವಾ ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ಕೋಡ್ ಪರಿಶೀಲಿಸಿ.',
      'location_migration_blocked':
          'ಸರ್ವರ್‌ಗೆ ಈಗ ಈ ಬದಲಾವಣೆಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಲು ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ. ಸಾಧನ ಮತ್ತು ಅದರ ಸ್ಥಳೀಯ ಗುರುತನ್ನು ಉಳಿಸಲಾಗಿದೆ.',
      'location_migration_slow':
          '$target‌ಗೆ ಬದಲಾವಣೆಯನ್ನು ಸರ್ವರ್ ಇನ್ನೂ ಸಿದ್ಧಗೊಳಿಸುತ್ತಿದೆ. ಕೆಲವು ಕ್ಷಣಗಳ ನಂತರ ‘ಮುಂದುವರಿಸಿ’ ಬಳಸಿ.',
      'location_migration_conflict':
          'ಸರ್ವರ್‌ನಲ್ಲಿ ಸಾಧನದ ಸ್ಥಿತಿ ಬದಲಾಗಿದೆ. ಸಾಧನಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ, ನಂತರ ಬದಲಾವಣೆಯನ್ನು ಮುಂದುವರಿಸಿ.',
      'location_migration_verification_failed':
          'ಹೊಸ ಸ್ಥಳವನ್ನು ಸರ್ವರ್ ದೃಢೀಕರಿಸಲಿಲ್ಲ. ಹಿಂದಿನ ಸ್ಥಳೀಯ ಗುರುತನ್ನು ಉಳಿಸಲಾಗಿದೆ.',
      'location_migration_device_changed':
          'ಸರ್ವರ್ ಹಿಂದಿರುಗಿಸಿದ ಸಾಧನವು ಬದಲಾಗುತ್ತಿರುವ ಸಾಧನಕ್ಕೆ ಇನ್ನು ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸುವ ಮೊದಲು ಸಾಧನಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ.',
      'tunnel_stop_failed':
          'ಹೊಸ ಸಂಪರ್ಕಕ್ಕೆ ಮೊದಲು ಹಿಂದಿನ ಟನಲ್ ಸಂಪೂರ್ಣವಾಗಿ ನಿಲ್ಲಬೇಕು.',
      'device_clock_ahead':
          'ಈ ಸಾಧನದ ಗಡಿಯಾರ ಮುಂದಿರುವಂತಿದೆ. ಸೈನ್ ಇನ್ ಆಗಿರಲು ಸ್ವಯಂಚಾಲಿತ ದಿನಾಂಕ ಮತ್ತು ಸಮಯವನ್ನು ಆನ್ ಮಾಡಿ.',
      'other':
          'ಕಾರ್ಯಾಚರಣೆಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ ಅಥವಾ ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ಕೋಡ್ ಅನ್ನು ಬೆಂಬಲ ತಂಡಕ್ಕೆ ಕಳುಹಿಸಿ.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ಸೆಷನ್ ಅವಧಿ ಮುಗಿದಿದೆ',
      'invalid_credentials': 'ಸೈನ್ ಇನ್ ವಿಫಲವಾಗಿದೆ',
      'email_verification_required': 'ಇಮೇಲ್ ದೃಢೀಕರಣ ಅಗತ್ಯ',
      'verification_email_cooldown': 'ಇಮೇಲ್ ಈಗಾಗಲೇ ಕಳುಹಿಸಲಾಗಿದೆ',
      'rate_limited': 'ಹಲವು ಬಾರಿ ಪ್ರಯತ್ನಿಸಲಾಗಿದೆ',
      'invalid_registration': 'ಮಾಹಿತಿಯನ್ನು ಸರಿಪಡಿಸಬೇಕು',
      'email_exists': 'ಖಾತೆ ಈಗಾಗಲೇ ಇದೆ',
      'invalid_profile': 'ಅಮಾನ್ಯ ಪ್ರೊಫೈಲ್',
      'invalid_device': 'ಅಮಾನ್ಯ ಸಾಧನ',
      'invalid_location': 'ಸ್ಥಳ ಲಭ್ಯವಿಲ್ಲ',
      'device_limit': 'ಸಾಧನ ಮಿತಿ ತಲುಪಿದೆ',
      'device_exists': 'VPN ಗುರುತು ಈಗಾಗಲೇ ಬಳಕೆಯಲ್ಲಿದೆ',
      'device_identity_revoked': 'VPN ಗುರುತನ್ನು ನವೀಕರಿಸಬೇಕು',
      'device_location_locked': 'ಸ್ಥಳ ಬದಲಾವಣೆಗೆ ರಿಫ್ರೆಶ್ ಅಗತ್ಯ',
      'location_migration_pending': 'ಸ್ಥಳ ಬದಲಾವಣೆ ಪ್ರಗತಿಯಲ್ಲಿದೆ',
      'location_migration_blocked': 'ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ನಿರ್ಬಂಧಿಸಲಾಗಿದೆ',
      'target_ca_mismatch': 'ಹೊಂದಿಕೆಯಾಗದ OpenVPN ಸರ್ವರ್',
      'location_migration_conflict': 'ಸ್ಥಳ ಬದಲಾವಣೆಗೆ ರಿಫ್ರೆಶ್ ಅಗತ್ಯ',
      'server_full': 'ಸರ್ವರ್ ತುಂಬಿದೆ',
      'capacity_unavailable': 'ಸ್ಥಳ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ',
      'target_unavailable': 'ಸರ್ವರ್ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ',
      'not_found': 'ಐಟಂ ಕಂಡುಬಂದಿಲ್ಲ',
      'invalid_openvpn_csr': 'ಅಮಾನ್ಯ OpenVPN ಗುರುತು',
      'openvpn_profile_exists': 'OpenVPN ಪ್ರೊಫೈಲ್ ಈಗಾಗಲೇ ಇದೆ',
      'openvpn_profile_revoked': 'OpenVPN ಪ್ರೊಫೈಲ್ ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ',
      'openvpn_operation_pending': 'OpenVPN ಕಾರ್ಯಾಚರಣೆ ಪ್ರಗತಿಯಲ್ಲಿದೆ',
      'openvpn_operation_terminal': 'OpenVPN ಕಾರ್ಯಾಚರಣೆ ಅಡಚಣೆಯಾಗಿದೆ',
      'openvpn_address_unavailable': 'OpenVPN ವಿಳಾಸ ಲಭ್ಯವಿಲ್ಲ',
      'openvpn_profile_conflict': 'OpenVPN ಸಂಘರ್ಷ',
      'openvpn_signer_unavailable': 'OpenVPN ಲಭ್ಯವಿಲ್ಲ',
      'email_delivery_unavailable': 'ಇಮೇಲ್ ಲಭ್ಯವಿಲ್ಲ',
      'invalid_token': 'ಅಮಾನ್ಯ ಲಿಂಕ್',
      'network_unavailable': 'ಇಂಟರ್ನೆಟ್ ಸಂಪರ್ಕ ಲಭ್ಯವಿಲ್ಲ',
      'invalid_json': 'ಅಮಾನ್ಯ ವಿನಂತಿ',
      'invalid_api_response': 'ಸರ್ವರ್ ಪ್ರತಿಕ್ರಿಯೆ ಅಮಾನ್ಯವಾಗಿದೆ',
      'ipv6_unavailable': 'IPv6 ಲಭ್ಯವಿಲ್ಲ',
      'invalid_ip_families': 'ನೆಟ್‌ವರ್ಕ್ ಸಂರಚನೆ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'other': 'ಸೇವೆ ಲಭ್ಯವಿಲ್ಲ',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ನಿಮ್ಮ ಸೆಷನ್ ಅವಧಿ ಮುಗಿದಿದೆ. ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.',
      'invalid_credentials': 'ಇಮೇಲ್ ವಿಳಾಸ ಅಥವಾ ಪಾಸ್‌ವರ್ಡ್ ತಪ್ಪಾಗಿದೆ.',
      'email_verification_required':
          'VPN ಸಾಧನ ಸೇರಿಸುವ ಮೊದಲು ನಿಮ್ಮ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ದೃಢೀಕರಿಸಿ.',
      'invalid_registration': 'ಕೇಳಲಾದ ಮಾಹಿತಿ ಮತ್ತು ಒಪ್ಪಿಗೆಗಳನ್ನು ಪರಿಶೀಲಿಸಿ.',
      'email_exists': 'ಈ ಇಮೇಲ್ ವಿಳಾಸಕ್ಕೆ ಈಗಾಗಲೇ ಒಂದು ಖಾತೆ ಇದೆ.',
      'invalid_profile': 'ನಿಮ್ಮ ಪ್ರೊಫೈಲ್ ಮಾಹಿತಿಯನ್ನು ಪರಿಶೀಲಿಸಿ.',
      'invalid_device': 'ಈ ಸಾಧನದ ಹೆಸರು ಅಥವಾ ಸ್ಥಳೀಯ ಗುರುತು ಅಮಾನ್ಯವಾಗಿದೆ.',
      'invalid_location': 'ಸ್ಥಳಗಳ ಪಟ್ಟಿಯನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'device_limit':
          'ಇನ್ನೊಂದು ಸಾಧನವನ್ನು ಸೇರಿಸುವ ಮೊದಲು ಈಗಿರುವ ಒಂದು ಸಾಧನವನ್ನು ತೆಗೆದುಹಾಕಿ.',
      'device_exists': 'ಈ VPN ಗುರುತು ಈಗಾಗಲೇ ಇನ್ನೊಂದು ಖಾತೆಗೆ ಲಿಂಕ್ ಆಗಿದೆ.',
      'device_identity_revoked':
          'ಈ ಗುರುತನ್ನು ತೆಗೆದುಹಾಕಲಾಗಿದೆ. ಹೊಸ ಸ್ಥಳೀಯ ಗುರುತನ್ನು ರಚಿಸಬೇಕು.',
      'device_location_locked':
          'ಈ ಸಾಧನದ ಸ್ಥಳ ಈಗಷ್ಟೇ ಬದಲಾಗಿದೆ. ನಡೆಯುತ್ತಿರುವ ಬದಲಾವಣೆಯನ್ನು ಆ್ಯಪ್ ಮುಂದುವರಿಸುತ್ತದೆ.',
      'location_migration_pending': 'ಸ್ಥಳ ಬದಲಾವಣೆ ಈಗಾಗಲೇ ಪ್ರಗತಿಯಲ್ಲಿದೆ.',
      'location_migration_blocked':
          'ಸ್ಥಳ ಬದಲಾವಣೆಗೆ ಸರ್ವರ್ ಕಡೆಯಿಂದ ಮಧ್ಯಪ್ರವೇಶ ಅಗತ್ಯವಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ ಅಥವಾ ಬೆಂಬಲ ತಂಡವನ್ನು ಸಂಪರ್ಕಿಸಿ.',
      'target_ca_mismatch':
          'ಈ ಸರ್ವರ್ ಇನ್ನೂ ಪ್ರಸ್ತುತ OpenVPN ಪ್ರೊಫೈಲ್‌ಗೆ ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ.',
      'location_migration_conflict':
          'ಸಾಧನಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ, ನಂತರ ಸ್ಥಳ ಬದಲಾವಣೆಯನ್ನು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'server_full':
          'ಈ ಸ್ಥಳ ತನ್ನ ಸಂಪರ್ಕ ಮಿತಿಯನ್ನು ತಲುಪಿದೆ. ಬೇರೆ ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ ಅಥವಾ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'capacity_unavailable':
          'ಈ ಸ್ಥಳ ಈಗ ಲಭ್ಯವಿದೆಯೇ ಎಂದು ದೃಢೀಕರಿಸಲು ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ. ಬೇರೆ ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡಿ ಅಥವಾ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'target_unavailable': 'ಈ ಸರ್ವರ್ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ.',
      'not_found': 'ಈ ಐಟಂ ಇನ್ನು ನಿಮ್ಮ ಖಾತೆಯಲ್ಲಿ ಲಭ್ಯವಿಲ್ಲ.',
      'invalid_openvpn_csr': 'ಹೊಸ OpenVPN ಗುರುತನ್ನು ರಚಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_profile_exists': 'ಈ ಸಾಧನಕ್ಕೆ ಈಗಾಗಲೇ OpenVPN ಪ್ರೊಫೈಲ್ ಇದೆ.',
      'openvpn_profile_revoked': 'ಮುಂದುವರಿಸಲು OpenVPN ಪ್ರೊಫೈಲ್ ನವೀಕರಿಸಿ.',
      'openvpn_operation_pending':
          'ಬದಲಾವಣೆ ಇನ್ನೂ ಕಾರ್ಯರೂಪಕ್ಕೆ ಬರುತ್ತಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_operation_terminal':
          'ಹೊಸ OpenVPN ಗುರುತನ್ನು ರಚಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_address_unavailable': 'ಸದ್ಯಕ್ಕೆ ಯಾವುದೇ OpenVPN ವಿಳಾಸ ಲಭ್ಯವಿಲ್ಲ.',
      'openvpn_profile_conflict':
          'ಪ್ರೊಫೈಲ್ ಬದಲಾಗಿದೆ. ಸಾಧನಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_signer_unavailable': 'OpenVPN ಸೇವೆ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ.',
      'email_delivery_unavailable':
          'ಇಮೇಲ್ ಕಳುಹಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'invalid_token':
          'ಈ ಲಿಂಕ್ ಅಮಾನ್ಯವಾಗಿದೆ ಅಥವಾ ಅವಧಿ ಮುಗಿದಿದೆ. ಹೊಸದನ್ನು ವಿನಂತಿಸಿ.',
      'network_unavailable':
          'ನಿಮ್ಮ ಇಂಟರ್ನೆಟ್ ಸಂಪರ್ಕವನ್ನು ಪರಿಶೀಲಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'invalid_json': 'ನಮೂದಿಸಿದ ಮಾಹಿತಿಯನ್ನು ಪರಿಶೀಲಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'invalid_api_response':
          'ಸರ್ವರ್ ಅನಿರೀಕ್ಷಿತ ಪ್ರತಿಕ್ರಿಯೆಯನ್ನು ನೀಡಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'ipv6_unavailable':
          'ಸರ್ವರ್‌ಗೆ ಸದ್ಯಕ್ಕೆ IPv6 ಅನ್ನು ಸಕ್ರಿಯಗೊಳಿಸಲು ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'invalid_ip_families':
          'ಟನಲ್ ಸಂರಚನೆ ಅಪೂರ್ಣವಾಗಿದೆ ಅಥವಾ ಅಧಿಕೃತ ವಿಳಾಸಗಳಿಗೆ ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ. ಆ್ಯಪ್ ಮೂಲಕ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'other': 'ಸರ್ವರ್ ದೋಷ ಸಂಭವಿಸಿದೆ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'ಕೆಲವು ಕ್ಷಣಗಳ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds ಸೆಕೆಂಡುಗಳಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      one: '$seconds ಸೆಕೆಂಡಿನಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes ನಿಮಿಷಗಳಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      one: '$minutes ನಿಮಿಷದಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ಗಂಟೆಗಳಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      one: '$hours ಗಂಟೆಯಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'ಸಿಸ್ಟಮ್ VPN ಪುನರಾರಂಭ ಲಭ್ಯವಿಲ್ಲ',
      'system_vpn_resume_corrupt': 'ಅಮಾನ್ಯ ಸಿಸ್ಟಮ್ VPN ಪುನರಾರಂಭ',
      'system_vpn_resume_session_invalid': 'ಅಮಾನ್ಯ VPN ಪುನರಾರಂಭ ಸೆಷನ್',
      'system_vpn_resume_identity_changed': 'VPN ಗುರುತು ಬದಲಾಗಿದೆ',
      'system_vpn_resume_identity_invalid': 'ಅಮಾನ್ಯ VPN ಪುನರಾರಂಭ ಗುರುತು',
      'system_vpn_resume_storage_failed': 'VPN ಪುನರಾರಂಭ ಸಂಗ್ರಹಣೆ ಲಭ್ಯವಿಲ್ಲ',
      'system_vpn_resume_network_timeout': 'VPN ಪುನರಾರಂಭಕ್ಕೆ ನೆಟ್‌ವರ್ಕ್ ಇಲ್ಲ',
      'system_vpn_resume_blocked': 'VPN ಪುನರಾರಂಭ ನಿರ್ಬಂಧಿಸಲಾಗಿದೆ',
      'system_vpn_resume_failed': 'VPN ಪುನರಾರಂಭ ವಿಫಲವಾಗಿದೆ',
      'system_vpn_resume_error_invalid': 'ಅಮಾನ್ಯ VPN ಪುನರಾರಂಭ ದೋಷ',
      'wireguard_identity_store_failed': 'WireGuard ಗುರುತು ಉಳಿಸಲಾಗಿಲ್ಲ',
      'wireguard_identity_unavailable': 'WireGuard ಗುರುತು ಲಭ್ಯವಿಲ್ಲ',
      'vpn_host_destroyed': 'Android VPN ಹೋಸ್ಟ್ ನಿಲ್ಲಿಸಲಾಗಿದೆ',
      'vpn_host_unavailable': 'Android VPN ಹೋಸ್ಟ್ ಲಭ್ಯವಿಲ್ಲ',
      'openvpn_renewal_required': 'OpenVPN ಪ್ರಮಾಣಪತ್ರ ನವೀಕರಣ ಅಗತ್ಯವಿದೆ',
      'openvpn_recovery_failed': 'OpenVPN ಮರುಪಡೆಯುವಿಕೆ ವಿಫಲವಾಗಿದೆ',
      'openvpn_recovery_exhausted': 'OpenVPN ಮರುಪಡೆಯುವಿಕೆ ಈಗಾಗಲೇ ಬಳಸಲಾಗಿದೆ',
      'vpn_permission_required': 'VPN ಅನುಮತಿ ಅಗತ್ಯವಿದೆ',
      'vpn_permission_denied': 'VPN ಅನುಮತಿ ನಿರಾಕರಿಸಲಾಗಿದೆ',
      'vpn_permission_request_failed': 'ಅನುಮತಿ ವಿನಂತಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'wireguard_foreground_service_unavailable': 'WireGuard ಸೇವೆ ಲಭ್ಯವಿಲ್ಲ',
      'wireguard_identity_invalid': 'ಅಮಾನ್ಯ ಸ್ಥಳೀಯ WireGuard ಕೀ',
      'wireguard_identity_in_use': 'WireGuard ಗುರುತು ಈಗಾಗಲೇ ಬಳಕೆಯಲ್ಲಿದೆ',
      'wireguard_configuration_invalid': 'ಅಮಾನ್ಯ WireGuard ಸಂರಚನೆ',
      'wireguard_operation_pending': 'WireGuard ಕಾರ್ಯಾಚರಣೆ ಇನ್ನೂ ಸಕ್ರಿಯವಾಗಿದೆ',
      'wireguard_start_failed': 'WireGuard ಪ್ರಾರಂಭ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'wireguard_stop_timeout': 'WireGuard ನಿಲುಗಡೆ ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ',
      'wireguard_handshake_timeout': 'WireGuard ಪ್ರತಿಕ್ರಿಯಿಸಲಿಲ್ಲ',
      'openvpn_connection_timeout': 'OpenVPN ಪ್ರತಿಕ್ರಿಯಿಸಲಿಲ್ಲ',
      'openvpn_core_unavailable': 'OpenVPN ಎಂಜಿನ್ ಲಭ್ಯವಿಲ್ಲ',
      'openvpn_operation_pending': 'OpenVPN ಸೆಷನ್ ಇನ್ನೂ ಸಕ್ರಿಯವಾಗಿದೆ',
      'openvpn_stop_timeout': 'OpenVPN ನಿಲುಗಡೆ ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ',
      'openvpn_profile_unavailable': 'ಸ್ಥಳೀಯ OpenVPN ಪ್ರೊಫೈಲ್ ಕಾಣೆಯಾಗಿದೆ',
      'openvpn_native_failed': 'ನೇಟಿವ್ OpenVPN ಕರೆ ಅಡಚಣೆಯಾಗಿದೆ',
      'openvpn_key_generation_failed': 'OpenVPN P-256 ಕೀ ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'openvpn_csr_generation_failed': 'OpenVPN CSR ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'openvpn_identity_store_failed': 'OpenVPN ಗುರುತು ಉಳಿಸಲಾಗಿಲ್ಲ',
      'openvpn_identity_clear_failed': 'OpenVPN ತೆಗೆದುಹಾಕುವಿಕೆ ಅಪೂರ್ಣವಾಗಿದೆ',
      'openvpn_identity_in_use': 'OpenVPN ಗುರುತು ಇನ್ನೂ ಬಳಕೆಯಲ್ಲಿದೆ',
      'openvpn_tls_verification_required': 'OpenVPN TLS ಪರಿಶೀಲನೆ ಕಾಣೆಯಾಗಿದೆ',
      'openvpn_cipher_invalid': 'ಅಮಾನ್ಯ OpenVPN ಸಿಫರ್',
      'openvpn_profile_rejected': 'OpenVPN ಪ್ರೊಫೈಲ್ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'openvpn_identity_inconsistent': 'ಅಸಂಗತ OpenVPN ಗುರುತು',
      'tls_handshake_failed': 'OpenVPN ಮಾತುಕತೆ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'tls_alert_unknown_ca': 'OpenVPN ಕ್ಲೈಂಟ್ ಪ್ರಮಾಣಪತ್ರವನ್ನು ಗುರುತಿಸಲಾಗಿಲ್ಲ',
      'tls_alert_bad_certificate': 'OpenVPN ಕ್ಲೈಂಟ್ ಪ್ರಮಾಣಪತ್ರ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'tls_alert_unsupported_certificate': 'ಬೆಂಬಲಿತವಲ್ಲದ OpenVPN ಪ್ರಮಾಣಪತ್ರ',
      'tls_client_certificate_required': 'OpenVPN ಕ್ಲೈಂಟ್ ಪ್ರಮಾಣಪತ್ರ ಅಗತ್ಯವಿದೆ',
      'tls_alert_misc': 'OpenVPN TLS ಎಚ್ಚರಿಕೆ',
      'tls_signature_algorithm_rejected': 'ಬೆಂಬಲಿತವಲ್ಲದ OpenVPN ಸಹಿ',
      'tls_handshake_rejected': 'OpenVPN TLS ಮಾತುಕತೆ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'tls_version_rejected': 'ಹೊಂದಿಕೆಯಾಗದ OpenVPN TLS ಆವೃತ್ತಿ',
      'tls_certificate_expired': 'TLS ಪ್ರಮಾಣಪತ್ರದ ಅವಧಿ ಮುಗಿದಿದೆ',
      'tls_certificate_revoked': 'TLS ಪ್ರಮಾಣಪತ್ರ ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ',
      'transport_failed': 'OpenVPN ಸರ್ವರ್ ತಲುಪಲು ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ',
      'tun_configuration_rejected': 'OpenVPN ಇಂಟರ್ಫೇಸ್ ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'tun_setup_failed': 'OpenVPN TUN ಸೆಟಪ್ ವಿಫಲವಾಗಿದೆ',
      'tun_interface_create_failed': 'OpenVPN ಇಂಟರ್ಫೇಸ್ ರಚನೆ ವಿಫಲವಾಗಿದೆ',
      'tun_interface_disabled': 'OpenVPN ಇಂಟರ್ಫೇಸ್ ನಿಷ್ಕ್ರಿಯಗೊಳಿಸಲಾಗಿದೆ',
      'tun_halted': 'OpenVPN ಇಂಟರ್ಫೇಸ್ ಅಡಚಣೆಯಾಗಿದೆ',
      'tun_already_established': 'OpenVPN ಇಂಟರ್ಫೇಸ್ ಈಗಾಗಲೇ ತೆರೆದಿದೆ',
      'tun_addresses_missing': 'OpenVPN ವಿಳಾಸ ಕಾಣೆಯಾಗಿದೆ',
      'tun_routes_missing': 'OpenVPN ರೂಟ್‌ಗಳು ಕಾಣೆಯಾಗಿವೆ',
      'tun_dns_missing': 'OpenVPN DNS ಕಾಣೆಯಾಗಿದೆ',
      'tun_permission_revoked': 'VPN ಅನುಮತಿ ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ',
      'tun_establish_returned_null': 'Android VPN ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ತಿರಸ್ಕರಿಸಿದೆ',
      'openvpn_service_start_failed': 'OpenVPN ಸೇವೆ ಲಭ್ಯವಿಲ್ಲ',
      'openvpn_operation_timeout': 'OpenVPN ಕರೆಗೆ ಸಮಯ ಮೀರಿದೆ',
      'openvpn_start_failed': 'OpenVPN ಪ್ರಾರಂಭ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'openvpn_connection_failed': 'OpenVPN ಸಂಪರ್ಕ ಅಡಚಣೆಯಾಗಿದೆ',
      'openvpn_core_status_error': 'OpenVPN ಕೋರ್ ದೋಷದೊಂದಿಗೆ ಕೊನೆಗೊಂಡಿದೆ',
      'openvpn_stopped_before_connected':
          'ಸಂಪರ್ಕಗೊಳ್ಳುವ ಮೊದಲೇ OpenVPN ನಿಲ್ಲಿಸಲಾಗಿದೆ',
      'openvpn_auth_failed': 'OpenVPN ದೃಢೀಕರಣ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'openvpn_client_setup_failed': 'OpenVPN ಕ್ಲೈಂಟ್ ಸೆಟಪ್ ವಿಫಲವಾಗಿದೆ',
      'openvpn_client_halted': 'OpenVPN ಕ್ಲೈಂಟ್ ಅಡಚಣೆಯಾಗಿದೆ',
      'openvpn_client_restart': 'OpenVPN ಮರುಪ್ರಾರಂಭಕ್ಕೆ ವಿನಂತಿಸಲಾಗಿದೆ',
      'openvpn_inactive_timeout': 'OpenVPN ತುಂಬಾ ಹೊತ್ತು ನಿಷ್ಕ್ರಿಯವಾಗಿದೆ',
      'openvpn_session_expired': 'OpenVPN ಸೆಷನ್ ಅವಧಿ ಮುಗಿದಿದೆ',
      'openvpn_credentials_required': 'ಬೆಂಬಲಿತವಲ್ಲದ OpenVPN ದೃಢೀಕರಣ',
      'openvpn_proxy_failed': 'OpenVPN ಮಧ್ಯವರ್ತಿ ಟ್ರಾನ್ಸ್‌ಪೋರ್ಟ್ ವಿಫಲವಾಗಿದೆ',
      'openvpn_compression_failed': 'OpenVPN ಕಂಪ್ರೆಷನ್ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM ಎನ್‌ಕ್ರಿಪ್ಷನ್ ಲಭ್ಯವಿಲ್ಲ',
      'openvpn_feature_unsupported': 'ಬೆಂಬಲಿತವಲ್ಲದ OpenVPN ವೈಶಿಷ್ಟ್ಯ',
      'network_unavailable': 'ಇಂಟರ್ನೆಟ್ ಸಂಪರ್ಕ ಲಭ್ಯವಿಲ್ಲ',
      'network_lost': 'ನೆಟ್‌ವರ್ಕ್ ಲಭ್ಯವಿಲ್ಲ',
      'certificate_validation_failed': 'ಸರ್ವರ್ ಪ್ರಮಾಣಪತ್ರ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'openvpn_certificate_expired': 'OpenVPN ಪ್ರಮಾಣಪತ್ರದ ಅವಧಿ ಮುಗಿದಿದೆ',
      'tunnel_active_for_another_account':
          'ಇನ್ನೊಂದು ಖಾತೆಯ ಟನಲ್ ಇನ್ನೂ ಸಕ್ರಿಯವಾಗಿದೆ',
      'tunnel_already_active': 'ನೇಟಿವ್ ಟನಲ್ ಈಗಾಗಲೇ ಸಕ್ರಿಯವಾಗಿದೆ',
      'tunnel_stop_timeout': '$protocol ನಿಲುಗಡೆ ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ',
      'tunnel_disconnected': '$protocol ಅಡಚಣೆಯಾಗಿದೆ',
      'native_bridge_unavailable': 'Android ಬ್ರಿಡ್ಜ್ ಲಭ್ಯವಿಲ್ಲ',
      'native_operation_failed': 'Android ಕಾರ್ಯಾಚರಣೆ ಅಡಚಣೆಯಾಗಿದೆ',
      'invalid_arguments': 'ಅಪೂರ್ಣ VPN ನಿಯತಾಂಕಗಳು',
      'invalid_account_id': 'ಅಮಾನ್ಯ VPN ಖಾತೆ',
      'invalid_device_id': 'ಅಮಾನ್ಯ ಸಾಧನ ಐಡಿ',
      'storage_key_not_allowed': 'ಸಂಗ್ರಹಣೆ ಕೀ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ',
      'secure_storage_read_failed': 'ಸುರಕ್ಷಿತ ಓದುವಿಕೆ ವಿಫಲವಾಗಿದೆ',
      'secure_storage_write_failed': 'ಸುರಕ್ಷಿತ ಬರೆಯುವಿಕೆ ವಿಫಲವಾಗಿದೆ',
      'key_generation_failed': 'WireGuard ಕೀ ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'csr_generation_failed': 'OpenVPN CSR ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
      'other': 'ವರ್ಗೀಕರಿಸದ ನೇಟಿವ್ VPN ದೋಷ',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ಗೆ ಪುನರಾರಂಭಿಸಬಹುದಾದ VPN ಸೆಷನ್ ಸಿಗುತ್ತಿಲ್ಲ. ಆ್ಯಪ್‌ನಲ್ಲಿ ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_corrupt':
          'ಉಳಿಸಲಾದ VPN ಪುನರಾರಂಭ ಡೇಟಾ ಅಮಾನ್ಯವಾಗಿದೆ ಮತ್ತು ಬಳಸಲಾಗುವುದಿಲ್ಲ. ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_session_invalid':
          'ಉಳಿಸಲಾದ ಸೆಷನ್‌ನಿಂದ ಇನ್ನು VPN ಅನ್ನು ಪುನರಾರಂಭಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ. ಆ್ಯಪ್‌ನಲ್ಲಿ ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.',
      'system_vpn_resume_identity_changed':
          'ಸ್ಥಳೀಯ VPN ಗುರುತು ಬದಲಾಗಿದೆ. ಪುನರಾರಂಭವನ್ನು ನಿಲ್ಲಿಸಲಾಗಿದೆ; ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_identity_invalid':
          'ಪುನರಾರಂಭಕ್ಕಾಗಿ ಬಳಸಿದ ಗುರುತು ಅಮಾನ್ಯವಾಗಿದೆ. ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_storage_failed':
          'Android ಗೆ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ ಪುನರಾರಂಭ ಡೇಟಾವನ್ನು ಓದಲು ಅಥವಾ ನವೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_network_timeout':
          'VPN ಅನ್ನು ಪುನರಾರಂಭಿಸಲು Android ಗೆ ಸಕಾಲದಲ್ಲಿ ನೆಟ್‌ವರ್ಕ್ ಸಿಗಲಿಲ್ಲ. ನೆಟ್‌ವರ್ಕ್ ಲಭ್ಯವಿದ್ದಾಗ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'system_vpn_resume_blocked':
          'VPN ಪುನರಾರಂಭ ನಿರ್ಬಂಧಿಸಲಾಗಿದೆ. Android ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು ಪರಿಶೀಲಿಸಿ, ನಂತರ ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_failed':
          'Android VPN ಪುನರಾರಂಭ ವಿಫಲವಾಗಿದೆ. ಆ್ಯಪ್‌ನಲ್ಲಿ ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'system_vpn_resume_error_invalid':
          'Android ಬಳಸಲಾಗದ ಪುನರಾರಂಭ ದೋಷವನ್ನು ಹಿಂತಿರುಗಿಸಿದೆ. ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'wireguard_identity_store_failed':
          'ಈ ಖಾತೆಯ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ WireGuard ಗುರುತನ್ನು ಉಳಿಸಲು Android ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'wireguard_identity_unavailable':
          'ಈ ಸಂಪರ್ಕಕ್ಕೆ ಬಳಸಬಹುದಾದ WireGuard ಗುರುತು ಲಭ್ಯವಿಲ್ಲ.',
      'vpn_host_destroyed':
          'VPN ಅನ್ನು ಹೋಸ್ಟ್ ಮಾಡುವ Android ಘಟಕವನ್ನು ನಿಲ್ಲಿಸಲಾಗಿದೆ. ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'vpn_host_unavailable':
          'VPN ಅನ್ನು ಹೋಸ್ಟ್ ಮಾಡುವ ಘಟಕವನ್ನು ರಚಿಸಲು Android ಗೆ ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ. VPN ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು ಪರಿಶೀಲಿಸಿದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_renewal_required':
          'ಸಂಪರ್ಕಿಸುವ ಮೊದಲು ಪ್ರಮಾಣಪತ್ರಕ್ಕಾಗಿ ಆ್ಯಪ್‌ನಲ್ಲಿ ಕ್ರಮ ಕೈಗೊಳ್ಳಬೇಕು.',
      'openvpn_recovery_failed':
          'ಸ್ವಯಂಚಾಲಿತ ಮರುಪಡೆಯುವಿಕೆ ವಿಫಲವಾಗಿದೆ. ಆ್ಯಪ್‌ನಲ್ಲಿ ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'openvpn_recovery_exhausted':
          'ಸ್ವಯಂಚಾಲಿತ ಮರುಪಡೆಯುವಿಕೆಯನ್ನು ಈಗಾಗಲೇ ಬಳಸಲಾಗಿದೆ. ಆ್ಯಪ್‌ನಲ್ಲಿ ಹೊಸ ಸಂಪರ್ಕವನ್ನು ಪ್ರಾರಂಭಿಸಿ.',
      'vpn_permission_required':
          'ಟನಲ್ ಪ್ರಾರಂಭಿಸುವ ಮೊದಲು Android ಗೆ ಹೊಸ VPN ಅನುಮತಿ ಬೇಕು.',
      'vpn_permission_denied':
          'ಮುಂದುವರಿಸಲು Android ವಿನಂತಿಯಲ್ಲಿ FuzeVPN ಅನ್ನು ಅನುಮತಿಸಿ.',
      'vpn_permission_request_failed':
          'VPN ಅನುಮತಿ ಪರದೆಯನ್ನು ತೆರೆಯಲು Android ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'wireguard_foreground_service_unavailable':
          'WireGuard ಸೇವೆಯನ್ನು ಮುನ್ನೆಲೆಯಲ್ಲಿ ಇರಿಸಲು Android ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'wireguard_identity_invalid':
          'ಈ ಖಾತೆಯ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ WireGuard ಕೀ ಓದಲಾಗದು ಅಥವಾ ಅಮಾನ್ಯವಾಗಿದೆ.',
      'wireguard_identity_in_use':
          'ಇನ್ನೊಂದು ಕಾರ್ಯಾಚರಣೆ ಈ ಖಾತೆಯ WireGuard ಕೀಯನ್ನು ಇನ್ನೂ ಬಳಸುತ್ತಿದೆ.',
      'wireguard_configuration_invalid':
          'ಸ್ವೀಕರಿಸಿದ WireGuard ವಿಳಾಸ, DNS, ಸರ್ವರ್ ಕೀ ಅಥವಾ ರೂಟ್‌ಗಳು ಅಮಾನ್ಯವಾಗಿವೆ.',
      'wireguard_operation_pending':
          'ಹಿಂದಿನ WireGuard ಕಾರ್ಯಾಚರಣೆ ಇನ್ನೂ ತನ್ನ ನೇಟಿವ್ ಸೇವೆಯನ್ನು ಬಿಡುಗಡೆ ಮಾಡಿಲ್ಲ.',
      'wireguard_start_failed':
          'WireGuard ಎಂಜಿನ್ ಈ ಸಂರಚನೆಯ ಸಕ್ರಿಯಗೊಳಿಸುವಿಕೆಯನ್ನು ತಿರಸ್ಕರಿಸಿದೆ.',
      'wireguard_stop_timeout':
          'ನಿಗದಿತ ಸಮಯದೊಳಗೆ VPN ಇಂಟರ್ಫೇಸ್ ಬಿಡುಗಡೆಯನ್ನು WireGuard ಸೇವೆ ದೃಢೀಕರಿಸಲಿಲ್ಲ.',
      'wireguard_handshake_timeout':
          'ಟನಲ್ ನಿಗದಿತ ಸಮಯದೊಳಗೆ ಸರ್ವರ್‌ನೊಂದಿಗೆ ಹ್ಯಾಂಡ್‌ಶೇಕ್ ಅನ್ನು ದೃಢೀಕರಿಸಲಿಲ್ಲ.',
      'openvpn_connection_timeout':
          'OpenVPN ನಿಗದಿತ ಸಮಯದೊಳಗೆ ಸರ್ವರ್‌ಗೆ ಸಂಪರ್ಕವನ್ನು ದೃಢೀಕರಿಸಲಿಲ್ಲ.',
      'openvpn_core_unavailable':
          'ಈ ಆ್ಯಪ್ ಆವೃತ್ತಿಯಲ್ಲಿ ಬಳಸಬಹುದಾದ OpenVPN ಎಂಜಿನ್ ಇಲ್ಲ.',
      'openvpn_operation_pending':
          'ನೇಟಿವ್ ಎಂಜಿನ್ ಇನ್ನೂ ಹಿಂದಿನ OpenVPN ಸೆಷನ್ ಅನ್ನು ಹಿಡಿದಿಟ್ಟುಕೊಂಡಿದೆ ಮತ್ತು ಎರಡನೆಯದನ್ನು ರಚಿಸಲು ನಿರಾಕರಿಸುತ್ತಿದೆ.',
      'openvpn_stop_timeout':
          'ನಿಗದಿತ ಸಮಯದೊಳಗೆ ತನ್ನ ನೇಟಿವ್ ಸೆಷನ್ ನಿಲ್ಲಿಸಲಾಗಿದೆ ಮತ್ತು ನಾಶಗೊಳಿಸಲಾಗಿದೆ ಎಂದು OpenVPN ಕೋರ್ ದೃಢೀಕರಿಸಲಿಲ್ಲ.',
      'openvpn_profile_unavailable':
          'ಈ ಸಂಪರ್ಕಕ್ಕಾಗಿ ಮಾನ್ಯೀಕರಿಸಿದ OpenVPN ಪ್ರೊಫೈಲ್ ಅನ್ನು ಓದಲು ಸಾಧ್ಯವಿಲ್ಲ.',
      'openvpn_native_failed':
          'ಆ್ಯಪ್ ದೋಷದಿಂದ OpenVPN ಅಡಚಣೆಯಾಗಿದೆ. ಮತ್ತೆ ಸಂಪರ್ಕಿಸಲು ಪ್ರಯತ್ನಿಸಿ. ಸಮಸ್ಯೆ ಮುಂದುವರಿದರೆ, ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ನಡೆಸಿ.',
      'openvpn_key_generation_failed':
          'Android Keystore ಗೆ ರಫ್ತು ಮಾಡಲಾಗದ P-256 ಖಾಸಗಿ ಕೀಯನ್ನು ರಚಿಸಲು ಅಥವಾ ಓದಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_csr_generation_failed':
          'Android Keystore ಕೀಗೆ OpenVPN ಪ್ರಮಾಣಪತ್ರ ವಿನಂತಿಗೆ ಸಹಿ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_identity_store_failed':
          'OpenVPN ಪ್ರಮಾಣಪತ್ರ ಅಥವಾ ಪ್ರೊಫೈಲ್ ಅನ್ನು ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ ಸಂಗ್ರಹಣೆಯಲ್ಲಿ ಉಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_identity_clear_failed':
          'ಈ ಖಾತೆಯ ಸಂಪೂರ್ಣ ಸ್ಥಳೀಯ OpenVPN ಗುರುತನ್ನು ತೆಗೆದುಹಾಕಲು Android ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_identity_in_use':
          'ನೇಟಿವ್ OpenVPN ಸೆಷನ್ ಈ ಸಾಧನದ ಕೀ ಅಥವಾ ಪ್ರಮಾಣಪತ್ರವನ್ನು ಇನ್ನೂ ಬಳಸುತ್ತಿದೆ.',
      'openvpn_tls_verification_required':
          'ಸರ್ವರ್ ಪ್ರಮಾಣಪತ್ರ ಪರಿಶೀಲನೆಯನ್ನು ಪ್ರೊಫೈಲ್ ಸ್ಪಷ್ಟವಾಗಿ ಕಡ್ಡಾಯಗೊಳಿಸುವುದಿಲ್ಲ.',
      'openvpn_cipher_invalid':
          'ಅನುಮತಿಸಲಾದ ಪಟ್ಟಿಯಲ್ಲಿ ಇಲ್ಲದ ಎನ್‌ಕ್ರಿಪ್ಷನ್ ಅಲ್ಗಾರಿದಮ್ ಅನ್ನು ಸರ್ವರ್ ಒದಗಿಸಿದೆ.',
      'openvpn_profile_rejected':
          'ಸರ್ವರ್‌ನಿಂದ ಸ್ವೀಕರಿಸಿದ ಪ್ರೊಫೈಲ್ ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ. ಈ ಸಾಧನವನ್ನು ಮರುರಚಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'openvpn_identity_inconsistent':
          'ಪ್ರಮಾಣಪತ್ರ ಈ ಫೋನ್‌ನ ಸುರಕ್ಷಿತ ಗುರುತಿಗೆ ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ. ಯಾವುದೇ ಸ್ಥಳೀಯ ಪ್ರೊಫೈಲ್ ಅನ್ನು ಬದಲಿಸಲಾಗಿಲ್ಲ.',
      'tls_handshake_failed':
          'ಸರ್ವರ್ TLS ಮಾತುಕತೆಯನ್ನು ತಿರಸ್ಕರಿಸಿದೆ. ಸಮಸ್ಯೆ ಮುಂದುವರಿದರೆ ಪ್ರೊಫೈಲ್ ಅನ್ನು ಮರುರಚಿಸಿ.',
      'tls_alert_unknown_ca':
          'ಈ ಸಾಧನದ ಪ್ರಮಾಣಪತ್ರದ ಪ್ರಾಧಿಕಾರವನ್ನು ಸರ್ವರ್ ಗುರುತಿಸುವುದಿಲ್ಲ. OpenVPN ಸರ್ವರ್ ಅನ್ನು ಪರಿಶೀಲಿಸಬೇಕು.',
      'tls_alert_bad_certificate':
          'ಈ ಸಾಧನದ ಪ್ರಮಾಣಪತ್ರವನ್ನು ಸರ್ವರ್ ತಿರಸ್ಕರಿಸಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸುವ ಮೊದಲು ಸಾಧನವನ್ನು ಮರುರಚಿಸಿ.',
      'tls_alert_unsupported_certificate':
          'Android ಬಳಸುವ ಸುರಕ್ಷಿತ ಪ್ರಮಾಣಪತ್ರ ಪ್ರಕಾರವನ್ನು ಸರ್ವರ್ ಬೆಂಬಲಿಸುವುದಿಲ್ಲ.',
      'tls_client_certificate_required':
          'ಸರ್ವರ್‌ಗೆ ಕ್ಲೈಂಟ್ ಪ್ರಮಾಣಪತ್ರ ಬೇಕು, ಆದರೆ OpenVPN ಕೋರ್‌ಗೆ ಒಂದನ್ನು ಒದಗಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'tls_alert_misc':
          'ಪ್ರಮಾಣಪತ್ರ ಮತ್ತು ಆವೃತ್ತಿ ವರ್ಗಗಳ ಹೊರಗಿನ TLS ಎಚ್ಚರಿಕೆಯನ್ನು ಸರ್ವರ್ ಹಿಂತಿರುಗಿಸಿದೆ.',
      'tls_signature_algorithm_rejected':
          'Android Keystore ಕೀಯ ECDSA P-256 ಅಲ್ಗಾರಿದಮ್ ಅನ್ನು ಸರ್ವರ್ ತಿರಸ್ಕರಿಸಿದೆ.',
      'tls_handshake_rejected':
          'ಸಂಪರ್ಕಕ್ಕೆ ಮೊದಲೇ ಸರ್ವರ್ TLS ಮಾತುಕತೆಯನ್ನು ಅಡ್ಡಿಪಡಿಸಿದೆ.',
      'tls_version_rejected':
          'ಕ್ಲೈಂಟ್ ಮತ್ತು ಸರ್ವರ್ ಎರಡೂ ಬೆಂಬಲಿಸುವ ಸಾಮಾನ್ಯ TLS ಆವೃತ್ತಿ ಸಿಗಲಿಲ್ಲ.',
      'tls_certificate_expired':
          'ಸಂಪರ್ಕದ ಸಮಯದಲ್ಲಿ ಒದಗಿಸಲಾದ ಪ್ರಮಾಣಪತ್ರದ ಅವಧಿ ಮುಗಿದಿದೆ.',
      'tls_certificate_revoked':
          'ಸಂಪರ್ಕದ ಸಮಯದಲ್ಲಿ ಒದಗಿಸಲಾದ ಪ್ರಮಾಣಪತ್ರವನ್ನು ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ.',
      'transport_failed':
          'ಪ್ರಸ್ತುತ ನೆಟ್‌ವರ್ಕ್‌ನಲ್ಲಿ OpenVPN ಸರ್ವರ್ ಪ್ರತಿಕ್ರಿಯಿಸುತ್ತಿಲ್ಲ. ಸ್ವಲ್ಪ ಸಮಯದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'tun_configuration_rejected':
          'OpenVPN ಕೇಳಿದ ನೆಟ್‌ವರ್ಕ್ ಸಂರಚನೆಯನ್ನು Android ತಿರಸ್ಕರಿಸಿದೆ.',
      'tun_setup_failed':
          'Android ಇಂಟರ್ಫೇಸ್ ರಚಿಸುವ ಮೊದಲು OpenVPN ಕೋರ್ ನೆಟ್‌ವರ್ಕ್ ಯೋಜನೆಯನ್ನು ತಿರಸ್ಕರಿಸಿದೆ.',
      'tun_interface_create_failed':
          'Android VpnService ನಿಂದ TUN ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ಪಡೆಯಲು OpenVPN ಕೋರ್‌ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'tun_interface_disabled':
          'ಸಂಪರ್ಕದ ಸಮಯದಲ್ಲಿ Android ಅಥವಾ OpenVPN ಕೋರ್ TUN ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ನಿಷ್ಕ್ರಿಯಗೊಳಿಸಿದೆ.',
      'tun_halted':
          'TUN ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ನಿಲ್ಲಿಸುವ ವಿನಂತಿಯನ್ನು OpenVPN ಕೋರ್ ಸ್ವೀಕರಿಸಿದೆ.',
      'tun_already_established':
          'ಅದೇ ಸಂಪರ್ಕದಲ್ಲಿ ಎರಡನೇ ಇಂಟರ್ಫೇಸ್ ಅನ್ನು OpenVPN ಕೇಳಿದೆ. ಸುರಕ್ಷತೆಗಾಗಿ ಟನಲ್ ಅನ್ನು ನಿಲ್ಲಿಸಲಾಗಿದೆ.',
      'tun_addresses_missing': 'ಬಳಸಬಹುದಾದ ಟನಲ್ ವಿಳಾಸವನ್ನು ಸರ್ವರ್ ಒದಗಿಸಲಿಲ್ಲ.',
      'tun_routes_missing': 'ಬಳಸಬಹುದಾದ ಟನಲ್ ರೂಟ್‌ಗಳನ್ನು ಸರ್ವರ್ ಒದಗಿಸಲಿಲ್ಲ.',
      'tun_dns_missing': 'ಸರ್ವರ್ ಬಳಸಬಹುದಾದ DNS ಸರ್ವರ್ ಅನ್ನು ಒದಗಿಸಲಿಲ್ಲ.',
      'tun_permission_revoked':
          'ಸಂಪರ್ಕದ ಸಮಯದಲ್ಲಿ Android VPN ಅನುಮತಿಯನ್ನು ರದ್ದುಗೊಳಿಸಿದೆ.',
      'tun_establish_returned_null':
          'Android ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ರಚಿಸಲಿಲ್ಲ, ಸಾಮಾನ್ಯವಾಗಿ ಇನ್ನೊಂದು VPN ಇನ್ನೂ ಸಕ್ರಿಯವಾಗಿರುವುದರಿಂದ.',
      'openvpn_service_start_failed':
          'OpenVPN ಮುನ್ನೆಲೆ ಸೇವೆಯನ್ನು ಪ್ರಾರಂಭಿಸಲು Android ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_operation_timeout':
          'OpenVPN ಕೋರ್‌ಗೆ JNI ಕರೆ ತನ್ನ ಗರಿಷ್ಠ ಅವಧಿಯನ್ನು ಮೀರಿದೆ.',
      'openvpn_start_failed':
          'Android ಸೇವೆ ಸಿದ್ಧವಾಗಿದೆ, ಆದರೆ ಪ್ರೊಫೈಲ್ ಪ್ರಾರಂಭಿಸುವುದನ್ನು OpenVPN ಕೋರ್ ಒಪ್ಪಿಕೊಳ್ಳಲಿಲ್ಲ.',
      'openvpn_connection_failed':
          'CONNECTED ಈವೆಂಟ್ ಅನ್ನು ಕಳುಹಿಸುವ ಮೊದಲೇ OpenVPN ಕೋರ್ ನಿಂತಿದೆ.',
      'openvpn_core_status_error':
          'ನೇಟಿವ್ OpenVPN ಲೂಪ್ ದೋಷದಿಂದ ಕೊನೆಗೊಂಡಿದೆ, ಹೆಚ್ಚು ನಿರ್ದಿಷ್ಟ ಅಂತಿಮ ಈವೆಂಟ್ ಇಲ್ಲದೆ.',
      'openvpn_stopped_before_connected':
          'ಸ್ಪಷ್ಟ ಕೋರ್ ದೋಷವಿಲ್ಲದೆ, CONNECTED ಗೆ ಮೊದಲೇ ನೇಟಿವ್ OpenVPN ಲೂಪ್ ನಿಂತಿದೆ.',
      'openvpn_auth_failed':
          'ಪ್ರೊಫೈಲ್ ದೃಢೀಕರಣವನ್ನು OpenVPN ಸರ್ವರ್ ತಿರಸ್ಕರಿಸಿದೆ.',
      'openvpn_client_setup_failed':
          'ನೆಟ್‌ವರ್ಕ್ ಸಂಪರ್ಕಕ್ಕೆ ಮೊದಲು ಕ್ಲೈಂಟ್ ಅನ್ನು ಆರಂಭಿಸಲು OpenVPN ಕೋರ್‌ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_client_halted':
          'OpenVPN ಕೋರ್ ಕ್ಲೈಂಟ್‌ನಿಂದ ಅಂತಿಮ ನಿಲುಗಡೆ ವಿನಂತಿಯನ್ನು ಸ್ವೀಕರಿಸಿದೆ.',
      'openvpn_client_restart':
          'ತನ್ನ ಟ್ರಾನ್ಸ್‌ಪೋರ್ಟ್ ಸೆಷನ್ ಅನ್ನು ಮರುಪ್ರಾರಂಭಿಸಲು OpenVPN ಕೋರ್ ವಿನಂತಿಸಿದೆ.',
      'openvpn_inactive_timeout':
          'ನಿಷ್ಕ್ರಿಯತೆಯ ಸಮಯ ಮೀರಿದ ನಂತರ OpenVPN ಕೋರ್ ಸೆಷನ್ ಅನ್ನು ಮುಚ್ಚಿದೆ.',
      'openvpn_session_expired':
          'OpenVPN ಸೆಷನ್ ಅವಧಿ ಮುಗಿದಿದೆ ಎಂದು ಸರ್ವರ್ ತಿಳಿಸಿದೆ.',
      'openvpn_credentials_required':
          'ಈ ಪ್ರಮಾಣಪತ್ರ ಪ್ರೊಫೈಲ್‌ನ ಭಾಗವಲ್ಲದ ಸಂವಾದಾತ್ಮಕ ರುಜುವಾತುಗಳನ್ನು ಸರ್ವರ್ ಅಥವಾ ಪ್ರಾಕ್ಸಿ ಕೇಳುತ್ತಿದೆ.',
      'openvpn_proxy_failed':
          'ಸಂರಚಿಸಿದ ಪ್ರಾಕ್ಸಿ ಅಥವಾ ರಿಲೇಯಲ್ಲಿ ವೈಫಲ್ಯವಿದೆ ಎಂದು OpenVPN ಕೋರ್ ವರದಿ ಮಾಡಿದೆ.',
      'openvpn_compression_failed':
          'ಪ್ರೊಫೈಲ್ ಅಥವಾ ಸರ್ವರ್ ಘೋಷಿಸಿದ ಕಂಪ್ರೆಷನ್ ಮೋಡ್ ಅನ್ನು OpenVPN ಕೋರ್ ತಿರಸ್ಕರಿಸಿದೆ.',
      'openvpn_ntlm_crypto_unavailable':
          'ಈ ಆವೃತ್ತಿಯಲ್ಲಿ ಲಭ್ಯವಿಲ್ಲದ NTLM ಎನ್‌ಕ್ರಿಪ್ಷನ್ ಅನ್ನು ಪ್ರೊಫೈಲ್ ಕೇಳುತ್ತಿದೆ.',
      'openvpn_feature_unsupported':
          'ಈ Android ಕ್ಲೈಂಟ್‌ನಲ್ಲಿ ಇಲ್ಲದ ವೈಶಿಷ್ಟ್ಯವನ್ನು ಪ್ರೊಫೈಲ್ ಅಥವಾ ಸರ್ವರ್ ಬಯಸುತ್ತಿದೆ.',
      'network_unavailable': 'ಬಳಸಬಹುದಾದ ಭೌತಿಕ ನೆಟ್‌ವರ್ಕ್ ಲಭ್ಯವಿಲ್ಲ.',
      'network_lost': 'ನೆಟ್‌ವರ್ಕ್ ಕಳೆದುಹೋದ ನಂತರ ಟನಲ್ ಅನ್ನು ನಿಲ್ಲಿಸಲಾಗಿದೆ.',
      'certificate_validation_failed':
          'OpenVPN ಸರ್ವರ್‌ನ ಗುರುತನ್ನು ಪರಿಶೀಲಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'openvpn_certificate_expired':
          'ಮತ್ತೆ ಸಂಪರ್ಕಿಸುವ ಮೊದಲು OpenVPN ಪ್ರೊಫೈಲ್ ಅನ್ನು ನವೀಕರಿಸಿ.',
      'tunnel_active_for_another_account':
          'ಈ ಸಂಪರ್ಕದ ಮೊದಲು ಇನ್ನೊಂದು ಖಾತೆಗೆ ಸೇರಿದ ಟನಲ್ ನಿಲ್ಲಬೇಕು.',
      'tunnel_already_active':
          'ಹಿಂದಿನ VPN ಸೆಷನ್ ಇನ್ನೂ ಇಂಟರ್ಫೇಸ್ ಅನ್ನು ಬಳಸುತ್ತಿದೆ ಎಂದು Android ತಿಳಿಸಿದೆ.',
      'tunnel_stop_timeout':
          'ನಿಗದಿತ ಸಮಯದೊಳಗೆ VPN ಇಂಟರ್ಫೇಸ್ ಬಿಡುಗಡೆಯನ್ನು $protocol ಎಂಜಿನ್ ದೃಢೀಕರಿಸಲಿಲ್ಲ.',
      'tunnel_disconnected':
          'ಪ್ರಾರಂಭವಾದ ನಂತರ ಟನಲ್ ಅನಿರೀಕ್ಷಿತವಾಗಿ ಕೊನೆಗೊಂಡಿದೆ ಎಂದು ನೇಟಿವ್ ಎಂಜಿನ್ ವರದಿ ಮಾಡಿದೆ.',
      'native_bridge_unavailable':
          'Android VPN ಸೇವೆಯನ್ನು ಪ್ರವೇಶಿಸಲು ಆ್ಯಪ್‌ಗೆ ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ. ಆ್ಯಪ್ ಮುಚ್ಚಿ ಮತ್ತೆ ತೆರೆಯಿರಿ, ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
      'native_operation_failed':
          'ಆ್ಯಪ್ ದೋಷದಿಂದ VPN ಕಾರ್ಯಾಚರಣೆ ಅಡಚಣೆಯಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ. ಸಮಸ್ಯೆ ಮುಂದುವರಿದರೆ, ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ನಡೆಸಿ.',
      'invalid_arguments':
          'ಈ VPN ಕಾರ್ಯಾಚರಣೆಗೆ ಬೇಕಾದ ಮಾಹಿತಿ ಅಪೂರ್ಣವಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ. ಸಮಸ್ಯೆ ಮುಂದುವರಿದರೆ, ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ನಡೆಸಿ.',
      'invalid_account_id': 'ನೇಟಿವ್ ಕಾರ್ಯಾಚರಣೆ ಮಾನ್ಯ ಖಾತೆ ಐಡಿಗೆ ಸಂಬಂಧಿಸಿಲ್ಲ.',
      'invalid_device_id':
          'ನೇಟಿವ್ ಎಂಜಿನ್‌ಗೆ ಕಳುಹಿಸಿದ ಸಾಧನ ಐಡಿ ಕಾಣೆಯಾಗಿದೆ ಅಥವಾ ಅಮಾನ್ಯವಾಗಿದೆ.',
      'storage_key_not_allowed':
          'ಅನುಮತಿಸಲಾದ ಸಂಗ್ರಹಣೆ ಪಟ್ಟಿಯ ಹೊರಗಿನ ಕೀಯನ್ನು Android ಬ್ರಿಡ್ಜ್ ನಿರ್ಬಂಧಿಸಿದೆ.',
      'secure_storage_read_failed':
          'ಈ ಖಾತೆಯ ಸ್ಥಳೀಯ ಡೇಟಾವನ್ನು ಡಿಕ್ರಿಪ್ಟ್ ಮಾಡಲು Android Keystore ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'secure_storage_write_failed':
          'ಸ್ಥಳೀಯ ಡೇಟಾವನ್ನು ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಲು ಅಥವಾ ಉಳಿಸಲು Android Keystore ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'key_generation_failed':
          'ಸುರಕ್ಷಿತ ಸಂಗ್ರಹಣೆಯಲ್ಲಿ WireGuard ಕೀಯನ್ನು ರಚಿಸಲು ಅಥವಾ ಓದಲು Android ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'csr_generation_failed':
          'OpenVPN P-256 CSR ಅನ್ನು ರಚಿಸಲು ಅಥವಾ ಸಹಿ ಮಾಡಲು Android Keystore ಗೆ ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
      'other':
          'ದಾಖಲಿಸದ ನೇಟಿವ್ ಶಾಖೆ ವಿಫಲವಾಗಿದೆ. ಕೆಳಗೆ ತೋರಿಸಿರುವ ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ಕೋಡ್ ಅನ್ನು ಬೆಂಬಲ ತಂಡಕ್ಕೆ ಕಳುಹಿಸಿ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'ಅನುಮತಿ ವಿನಂತಿ ಈಗಾಗಲೇ ತೆರೆದಿದೆ';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN ಅನುಮತಿ ವಿನಂತಿ ಈಗಾಗಲೇ ಪ್ರದರ್ಶಿಸಲಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸುವ ಮೊದಲು ಅದನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN ಅನುಮತಿ ವಿನಂತಿ ಅಡಚಣೆಯಾಗಿದೆ';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ಆ್ಯಪ್ ಪ್ರತಿಕ್ರಿಯೆ ಪಡೆಯುವ ಮೊದಲೇ VPN ಅನುಮತಿ ಪರದೆ ಮುಚ್ಚಿಕೊಂಡಿತು.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN ಸಂಪರ್ಕವನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN ಸಂಪರ್ಕವನ್ನು ದೃಢೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಭದ್ರತೆಗಾಗಿ ಅದನ್ನು ನಿಲ್ಲಿಸಲಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get openvpnCleanup_title => 'OpenVPN ಪ್ರೊಫೈಲ್ ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ';

  @override
  String get openvpnCleanup_working =>
      'ರದ್ದುಗೊಳಿಸಲಾದ OpenVPN ಪ್ರೊಫೈಲ್ ಅನ್ನು ನಿಲ್ಲಿಸಿ ತೆಗೆದುಹಾಕಲಾಗುತ್ತಿದೆ…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN ನಿಲುಗಡೆಯನ್ನು ದೃಢೀಕರಿಸಲಾಗಿಲ್ಲ. ಹೊಸ ಪ್ರೊಫೈಲ್ ರಚಿಸುವ ಮೊದಲು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'ರದ್ದುಗೊಳಿಸಲಾದ OpenVPN ಪ್ರೊಫೈಲ್ ಅನ್ನು ಸಂಪೂರ್ಣವಾಗಿ ತೆಗೆದುಹಾಕಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಸ್ವಚ್ಛಗೊಳಿಸಲು ಮರುಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get openvpnCleanup_complete =>
      'ರದ್ದುಗೊಳಿಸಲಾದ OpenVPN ಪ್ರೊಫೈಲ್ ಅನ್ನು ತೆಗೆದುಹಾಕಲಾಗಿದೆ. ಹೊಸದನ್ನು ರಚಿಸಲು ‘ಸಂಪರ್ಕಿಸಿ’ ಟ್ಯಾಪ್ ಮಾಡಿ.';

  @override
  String get network_title => 'ನೆಟ್‌ವರ್ಕ್ ಸಂರಚನೆ';

  @override
  String get network_ipv4Fallback =>
      'IPv6 ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ. IPv4 ಮೂಲಕ ಸಿದ್ಧತೆ ಮುಂದುವರಿಯುತ್ತಿದೆ.';

  @override
  String get network_rejectedTitle => 'ನೆಟ್‌ವರ್ಕ್ ಸಂರಚನೆ ತಿರಸ್ಕರಿಸಲಾಗಿದೆ';

  @override
  String get network_rejectedMessage =>
      'ಟನಲ್ ಸಂರಚನೆ ಅಪೂರ್ಣವಾಗಿದೆ ಅಥವಾ ಅಧಿಕೃತ ವಿಳಾಸಗಳಿಗೆ ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ. ಆ್ಯಪ್ ಮೂಲಕ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get network_unreadableTitle => 'ಸ್ಥಳೀಯ ಸಂರಚನೆ ಓದಲಾಗುತ್ತಿಲ್ಲ';

  @override
  String get network_unreadableMessage =>
      'ಉಳಿಸಲಾದ OpenVPN ನೆಟ್‌ವರ್ಕ್ ಸಂರಚನೆಯನ್ನು ಬಳಸಲು ಸಾಧ್ಯವಿಲ್ಲ. ಅದನ್ನು ನವೀಕರಿಸಲು ಆ್ಯಪ್ ಮೂಲಕ ಮತ್ತೆ ಸಂಪರ್ಕಿಸಿ.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ನೆಟ್‌ವರ್ಕ್ ರಕ್ಷಣೆ';

  @override
  String get protection_subtitle =>
      'VPN ಸಂಪರ್ಕ ಕಡಿತಗೊಂಡರೆ ನೇರ ಇಂಟರ್ನೆಟ್ ಪ್ರವೇಶವನ್ನು ನಿರ್ಬಂಧಿಸಿ.';

  @override
  String get protection_active => 'ಸಿಸ್ಟಮ್ ರಕ್ಷಣೆ ಸಕ್ರಿಯವಾಗಿದೆ';

  @override
  String get protection_alwaysOnOnly =>
      'ಯಾವಾಗಲೂ ಆನ್ ಇರುವ VPN ಸಕ್ರಿಯವಾಗಿದೆ; VPN ಇಲ್ಲದೆ ಸಂಪರ್ಕಗಳನ್ನು ನಿರ್ಬಂಧಿಸುವುದನ್ನು ಆನ್ ಮಾಡಿ';

  @override
  String get protection_inactive => 'ಸಿಸ್ಟಮ್ ರಕ್ಷಣೆ ನಿಷ್ಕ್ರಿಯವಾಗಿದೆ';

  @override
  String get protection_unknown => 'ಸಿಸ್ಟಮ್ ರಕ್ಷಣೆಯನ್ನು ಪರಿಶೀಲಿಸಿ';

  @override
  String get protection_openSettings => 'Android ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು ತೆರೆಯಿರಿ';

  @override
  String get protection_dialogTitle => 'ನೆಟ್‌ವರ್ಕ್ ರಕ್ಷಣೆಯನ್ನು ಹೊಂದಿಸಿ';

  @override
  String get protection_dialogMessage =>
      'ಯಾವಾಗಲೂ ಆನ್ ಇರುವ VPN ಮತ್ತು VPN ಇಲ್ಲದೆ ಸಂಪರ್ಕಗಳನ್ನು ನಿರ್ಬಂಧಿಸುವುದನ್ನು Android ನಿರ್ವಹಿಸುತ್ತದೆ. FuzeVPN ಆಯ್ಕೆಯಾಗಿದೆಯೇ ಎಂದು ಪರಿಶೀಲಿಸಿ ಮತ್ತು ಸಿಸ್ಟಮ್ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ನಿರ್ಬಂಧವನ್ನು ಸಕ್ರಿಯಗೊಳಿಸಿ.';

  @override
  String get protection_dialogOpen => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು ತೆರೆಯಿರಿ';

  @override
  String get session_systemProtectionNote =>
      'Android ಇನ್ನೂ VPN ಹೊರಗಿನ ಟ್ರಾಫಿಕ್ ಅನ್ನು ನಿರ್ಬಂಧಿಸುತ್ತಿದ್ದರೆ, ಈ ರಕ್ಷಣೆಯನ್ನು ಪರಿಶೀಲಿಸಲು ಅಥವಾ ಬದಲಿಸಲು ಸಿಸ್ಟಮ್ ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು ತೆರೆಯಿರಿ.';

  @override
  String get diagnostics_title => 'ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್';

  @override
  String get diagnostics_settingsTitle => 'ಆ್ಯಪ್ ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್';

  @override
  String get diagnostics_automaticTitle => 'ಮುಖ್ಯ ದೋಷಗಳನ್ನು ಕಳುಹಿಸಿ';

  @override
  String get diagnostics_automaticDescription =>
      'ಮುಖ್ಯ ದೋಷ ಸಂಭವಿಸಿದಾಗ ಒಂದು ಸಣ್ಣ ತಾಂತ್ರಿಕ ವರದಿಯನ್ನು ಹಂಚಿಕೊಳ್ಳಿ.';

  @override
  String get diagnostics_privacy =>
      'ಕಳುಹಿಸಿದ ವರದಿಗಳು ಸೈನ್ ಇನ್ ಆಗಿರುವ ಖಾತೆಗೆ ಲಿಂಕ್ ಆಗಿರುತ್ತವೆ ಮತ್ತು 30 ದಿನಗಳ ಕಾಲ ಉಳಿಸಲಾಗುತ್ತವೆ. ಅವುಗಳಲ್ಲಿ ಬ್ರೌಸಿಂಗ್ ಇತಿಹಾಸ, ಪಾಸ್‌ವರ್ಡ್‌ಗಳು ಅಥವಾ VPN ಕೀಗಳು ಇರುವುದಿಲ್ಲ.';

  @override
  String get diagnostics_manualOpen => 'ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ನಡೆಸಿ';

  @override
  String get diagnostics_localDescription =>
      'ಆ್ಯಪ್ ಮತ್ತು VPN ಸ್ಥಿತಿಯ ವರದಿಯನ್ನು ರಚಿಸಿ. ನಿಮ್ಮ ಸಂಪರ್ಕ ಬದಲಾಗದೆ ಉಳಿಯುತ್ತದೆ.';

  @override
  String get diagnostics_sendReport => 'ವರದಿಯನ್ನು ಕಳುಹಿಸಿ';

  @override
  String get diagnostics_sendHint =>
      'ವರದಿಯನ್ನು ಈ ಸಾಧನದಲ್ಲೇ ಇರಿಸಲು ಈ ಚೆಕ್‌ಬಾಕ್ಸ್ ಅನ್ನು ಗುರುತಿಸದೆ ಬಿಡಿ.';

  @override
  String get diagnostics_signedOut =>
      'ವರದಿ ಕಳುಹಿಸಲು ನಿಮ್ಮ ಖಾತೆಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.';

  @override
  String get diagnostics_localLifetime =>
      'ಆ್ಯಪ್ ಮುಚ್ಚಿದ ನಂತರವೂ ಈ ವರದಿ ಉಳಿಯಲು ನಿಮ್ಮ ಫೋನ್‌ನಲ್ಲಿ ಉಳಿಸಿ.';

  @override
  String get diagnostics_run => 'ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ನಡೆಸಿ';

  @override
  String get diagnostics_rerun => 'ಡಯಾಗ್ನೋಸ್ಟಿಕ್ಸ್ ಮತ್ತೆ ನಡೆಸಿ';

  @override
  String get diagnostics_running => 'ಪರಿಶೀಲಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get diagnostics_sending => 'ವರದಿ ಕಳುಹಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get diagnostics_prepared => 'ಈ ಸಾಧನದಲ್ಲಿ ವರದಿ ಸಿದ್ಧವಾಗಿದೆ';

  @override
  String get diagnostics_queued => 'ಕಳುಹಿಸಲು ವರದಿ ಕಾಯುತ್ತಿದೆ';

  @override
  String get diagnostics_sent => 'ವರದಿ ಸ್ವೀಕರಿಸಲಾಗಿದೆ';

  @override
  String get diagnostics_failed =>
      'ಕಳುಹಿಸುವಿಕೆ ವಿಫಲವಾಗಿದೆ. ನಿಮ್ಮ ಸ್ಥಳೀಯ ವರದಿ ಇನ್ನೂ ಲಭ್ಯವಿದೆ.';

  @override
  String get diagnostics_preparationFailed =>
      'ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ವರದಿಯನ್ನು ಸಿದ್ಧಪಡಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get diagnostics_authenticationRequired =>
      'ವರದಿ ಕಳುಹಿಸಲು ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.';

  @override
  String get diagnostics_retry => 'ಮತ್ತೆ ಕಳುಹಿಸಿ';

  @override
  String get diagnostics_export => 'ವರದಿಯನ್ನು ಉಳಿಸಿ';

  @override
  String get diagnostics_exportFailed =>
      'ರಫ್ತು ವಿಫಲವಾಗಿದೆ. ಸ್ಥಳೀಯ ವರದಿಯಿಂದ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get diagnostics_preferenceFailed =>
      'ಈ ಸೆಟ್ಟಿಂಗ್ ಉಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String diagnostics_receipt(Object id) {
    return 'ಉಲ್ಲೇಖ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date ರಂದು ಸ್ವೀಕರಿಸಲಾಗಿದೆ';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date ವರೆಗೆ ಉಳಿಸಲಾಗುತ್ತದೆ';
  }

  @override
  String get diagnostics_duplicate => 'ಈ ವರದಿಯನ್ನು ಈಗಾಗಲೇ ಸ್ವೀಕರಿಸಲಾಗಿತ್ತು.';

  @override
  String get diagnostics_preview => 'ವರದಿಯ ಮುನ್ನೋಟ';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ತಾಂತ್ರಿಕ ಘಟನೆಗಳನ್ನು ಲಗತ್ತಿಸಲಾಗಿದೆ',
      one: '1 ತಾಂತ್ರಿಕ ಘಟನೆಯನ್ನು ಲಗತ್ತಿಸಲಾಗಿದೆ',
      zero: 'ಯಾವುದೇ ತಾಂತ್ರಿಕ ಘಟನೆಯನ್ನು ಲಗತ್ತಿಸಲಾಗಿಲ್ಲ',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'ತಾಂತ್ರಿಕ ವಿವರಗಳು';

  @override
  String get diagnostics_empty =>
      'ಇನ್ನೂ ಯಾವುದೇ ಡಯಾಗ್ನೋಸ್ಟಿಕ್ ವರದಿ ಸಿದ್ಧಪಡಿಸಲಾಗಿಲ್ಲ.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ಟನಲ್ ಸ್ಥಿತಿ',
      'handshake': 'ಸಂಪರ್ಕ ದೃಢೀಕರಣ',
      'certificate': 'VPN ಪ್ರಮಾಣಪತ್ರ',
      'kill_switch': 'Android ರಕ್ಷಣೆ',
      'connectivity': 'ಲಭ್ಯವಿರುವ ನೆಟ್‌ವರ್ಕ್',
      'api_reachability': 'ಸೇವಾ ಪ್ರವೇಶ',
      'secure_storage': 'ಸುರಕ್ಷಿತ ಸಂಗ್ರಹಣೆ',
      'other': 'ಸ್ಥಳೀಯ ಪರಿಶೀಲನೆ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'ಪರಿಶೀಲಿಸಲಾಗಿದೆ',
      'failed': 'ಗಮನ ಅಗತ್ಯ',
      'skipped': 'ಪರೀಕ್ಷಿಸಲಾಗಿಲ್ಲ — ಸಕ್ರಿಯ ಪರೀಕ್ಷೆ ಇಲ್ಲ',
      'unknown': 'ಮಾಹಿತಿ ಲಭ್ಯವಿಲ್ಲ',
      'other': 'ಮಾಹಿತಿ ಲಭ್ಯವಿಲ್ಲ',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN ಗೆ ಸ್ವಾಗತ';

  @override
  String get connection_changeLocation => 'ಸ್ಥಳ ಬದಲಿಸಿ';

  @override
  String get connection_details => 'ಸಂಪರ್ಕದ ವಿವರಗಳು';

  @override
  String get locations_searchLabel => 'ನಗರ ಅಥವಾ ದೇಶವನ್ನು ಹುಡುಕಿ';

  @override
  String get locations_clearSearch => 'ಹುಡುಕಾಟ ತೆರವುಗೊಳಿಸಿ';

  @override
  String get locations_filterAll => 'ಎಲ್ಲಾ';

  @override
  String get locations_filterFavorites => 'ಮೆಚ್ಚಿನವುಗಳು';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸ್ಥಳಗಳು',
      one: '$count ಸ್ಥಳ',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'ಯಾವುದೇ ಸ್ಥಳ ಕಂಡುಬಂದಿಲ್ಲ';

  @override
  String get locations_noResultsHint => 'ಬೇರೆ ನಗರ ಅಥವಾ ದೇಶವನ್ನು ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get locations_noFavorites =>
      'ನಿಮ್ಮ ಮೆಚ್ಚಿನವುಗಳು ಇಲ್ಲಿಯೇ ಸುಲಭವಾಗಿ ಲಭ್ಯ';

  @override
  String get locations_noFavoritesHint =>
      'ಸ್ಥಳದ ಪಕ್ಕದಲ್ಲಿರುವ ನಕ್ಷತ್ರವನ್ನು ಟ್ಯಾಪ್ ಮಾಡಿ ಅದನ್ನು ಇಲ್ಲಿ ಉಳಿಸಿ.';

  @override
  String get locations_showAll => 'ಎಲ್ಲಾ ಸ್ಥಳಗಳನ್ನು ನೋಡಿ';

  @override
  String locations_addFavorite(String name) {
    return '$name ಅನ್ನು ಮೆಚ್ಚಿನವುಗಳಿಗೆ ಸೇರಿಸಿ';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name ಅನ್ನು ಮೆಚ್ಚಿನವುಗಳಿಂದ ತೆಗೆದುಹಾಕಿ';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'ಮೆಚ್ಚಿನದನ್ನು ಉಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get locations_emptyTitle => 'ಯಾವುದೇ ಸ್ಥಳ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String get locations_emptyHint =>
      'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಲು ಪಟ್ಟಿಯನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ.';

  @override
  String get devices_manage => 'ನನ್ನ ಸಾಧನಗಳನ್ನು ನಿರ್ವಹಿಸಿ';

  @override
  String get settings_personalization => 'ನಿಮ್ಮ ಇಷ್ಟದಂತೆ';

  @override
  String get settings_safety => 'ರಕ್ಷಣೆ';

  @override
  String get settings_help => 'ಸಹಾಯ ಬೇಕೇ?';

  @override
  String get settings_about => 'FuzeVPN ಬಗ್ಗೆ';

  @override
  String get diagnostics_heading => 'ಸಂಪರ್ಕ ಸಮಸ್ಯೆಯನ್ನು ಅರ್ಥ ಮಾಡಿಕೊಳ್ಳಿ';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ಲಭ್ಯವಿದೆ',
      'pending': 'ಸಿದ್ಧಗೊಳಿಸಲಾಗುತ್ತಿದೆ',
      'revoked': 'ತೆಗೆದುಹಾಕಲಾಗಿದೆ',
      'expired': 'ಅವಧಿ ಮುಗಿದಿದೆ',
      'other': 'ಸ್ಥಿತಿ ಲಭ್ಯವಿಲ್ಲ',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ಆಯ್ಕೆ ಉಳಿಸಲಾಗಿಲ್ಲ';

  @override
  String get notice_preferenceSave_message =>
      'ನಿಮ್ಮ ಆಯ್ಕೆ ಈಗಲೇ ಅನ್ವಯವಾಗಿದೆ, ಆದರೆ ಉಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಆ್ಯಪ್ ಮುಚ್ಚಿದ ನಂತರವೂ ಇದನ್ನು ಉಳಿಸಿಡಲು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPN ಅನ್ನು ಸಕ್ರಿಯವಾಗಿಯೇ ಇರಿಸಿದರೆ, ತೆರೆಯುವ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ‘ಯಾವಾಗಲೂ ಆನ್ ಇರುವ VPN’ ಅನ್ನು ಆಫ್ ಮಾಡಿ.';

  @override
  String get protection_learnMore => 'Android ರಕ್ಷಣೆಯ ಬಗ್ಗೆ ತಿಳಿಯಿರಿ';

  @override
  String get protection_guideWhy =>
      'VPN ಸಂಪರ್ಕ ಕಡಿತಗೊಂಡರೆ ಈ ರಕ್ಷಣೆ ಆ್ಯಪ್‌ಗಳು ನೇರವಾಗಿ ಇಂಟರ್ನೆಟ್ ಬಳಸದಂತೆ ತಡೆಯುತ್ತದೆ. ಇದನ್ನು Android ನಲ್ಲಿ ಹೊಂದಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get protection_guideAlwaysOnTitle => 'ಯಾವಾಗಲೂ ಆನ್ ಇರುವ VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN ಸೇವೆಯನ್ನು ಚಾಲನೆಯಲ್ಲಿರಿಸುತ್ತದೆ ಮತ್ತು ಫೋನ್ ರೀಬೂಟ್ ಆದ ನಂತರ ಅದನ್ನು ಮರುಪ್ರಾರಂಭಿಸಬಹುದು.';

  @override
  String get protection_guideBlockTitle => 'VPN ಇಲ್ಲದೆ ಸಂಪರ್ಕಗಳನ್ನು ನಿರ್ಬಂಧಿಸಿ';

  @override
  String get protection_guideBlock =>
      'ಸಂಪರ್ಕಕ್ಕೆ ಅಡಚಣೆಯಾದಾಗಲೂ ಟ್ರಾಫಿಕ್ VPN ಅನ್ನು ಬೈಪಾಸ್ ಮಾಡದಂತೆ ಈ ಸೆಟ್ಟಿಂಗ್ ತಡೆಯುತ್ತದೆ.';

  @override
  String get protection_guideWarning =>
      'ಈ ನಿರ್ಬಂಧ ಆನ್ ಆಗಿದ್ದರೆ, VPN ಸಂಪರ್ಕಗೊಳ್ಳುವವರೆಗೆ ಇಂಟರ್ನೆಟ್ ಪ್ರವೇಶ ಇರುವುದಿಲ್ಲ.';

  @override
  String get protection_guideStepsTitle => 'ರಕ್ಷಣೆಯನ್ನು ಆನ್ ಮಾಡಿ';

  @override
  String get protection_guideStep1 =>
      'ಕೆಳಗಿನ ಬಟನ್ ಬಳಸಿ Android VPN ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು ತೆರೆಯಿರಿ.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN ಪಕ್ಕದಲ್ಲಿರುವ ಗೇರ್ ಐಕಾನ್ ಬಳಸಿ ಆಯ್ಕೆಗಳನ್ನು ತೆರೆಯಿರಿ.';

  @override
  String get protection_guideStep3 =>
      'ಈ ಆಯ್ಕೆಗಳು ಲಭ್ಯವಿದ್ದರೆ, ಮೊದಲು “ಯಾವಾಗಲೂ ಆನ್ ಇರುವ VPN” ಅನ್ನು ಆನ್ ಮಾಡಿ, ನಂತರ “VPN ಇಲ್ಲದೆ ಸಂಪರ್ಕಗಳನ್ನು ನಿರ್ಬಂಧಿಸಿ” ಅನ್ನು ಆನ್ ಮಾಡಿ.';

  @override
  String get protection_guideManufacturers =>
      'ಹೆಸರುಗಳು ಫೋನ್ ಮಾದರಿಯನ್ನು ಅವಲಂಬಿಸಿ ಬದಲಾಗುತ್ತವೆ. ಅಗತ್ಯವಿದ್ದರೆ, ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ VPN ಅನ್ನು ಹುಡುಕಿ; ಇದು ಸಾಮಾನ್ಯವಾಗಿ ನೆಟ್‌ವರ್ಕ್ ಮತ್ತು ಇಂಟರ್ನೆಟ್ ಅಡಿಯಲ್ಲಿರುತ್ತದೆ.';

  @override
  String get protection_guideDisableTitle => 'ಈ ರಕ್ಷಣೆಯನ್ನು ಆಫ್ ಮಾಡಿ';

  @override
  String get protection_guideDisable =>
      'ಅದೇ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ, VPN ಇಲ್ಲದೆ ಇಂಟರ್ನೆಟ್ ಬಳಸಲು “VPN ಇಲ್ಲದೆ ಸಂಪರ್ಕಗಳನ್ನು ನಿರ್ಬಂಧಿಸಿ” ಆಯ್ಕೆಯನ್ನು ಆಫ್ ಮಾಡಿ. Android ಅದನ್ನು ಮರುಪ್ರಾರಂಭಿಸಬಾರದು ಎಂದಾದರೆ “ಯಾವಾಗಲೂ ಆನ್ ಇರುವ VPN” ಅನ್ನೂ ಆಫ್ ಮಾಡಿ.';

  @override
  String get protection_guideManual =>
      'ಈ ಸೆಟ್ಟಿಂಗ್‌ಗಳನ್ನು Android ನಲ್ಲಿ ನೀವೇ ಆಯ್ಕೆ ಮಾಡಿಕೊಳ್ಳುತ್ತೀರಿ. FuzeVPN ಅವುಗಳನ್ನು ನಿಮ್ಮ ಪರವಾಗಿ ಬದಲಿಸುವುದಿಲ್ಲ.';

  @override
  String get locations_changeTitle => 'ಸ್ಥಳ ಬದಲಿಸಬೇಕೇ?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ಸಂಪರ್ಕ ಕಡಿತಗೊಳ್ಳುತ್ತದೆ, ನಂತರ $name‌ಗೆ ಸಂಪರ್ಕಿಸಲು ಪ್ರಯತ್ನಿಸುತ್ತದೆ.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name‌ಗೆ ಸಂಪರ್ಕಿಸಲು ಪ್ರಯತ್ನಿಸುತ್ತದೆ.';
  }

  @override
  String get locations_confirmChange => 'ಬದಲಿಸಿ ಮತ್ತು ಸಂಪರ್ಕಿಸಿ';

  @override
  String get locations_changeBusy =>
      'ಬದಲಾವಣೆ ನಡೆಯುತ್ತಿದೆ. ಇನ್ನೊಂದು ಸ್ಥಳವನ್ನು ಆಯ್ಕೆಮಾಡುವ ಮೊದಲು ಕಾಯಿರಿ.';

  @override
  String get locations_automaticSelection => 'ಸ್ವಯಂಚಾಲಿತ ಆಯ್ಕೆ';

  @override
  String get locations_cities => 'ನಗರಗಳು';

  @override
  String get locations_servers => 'ಸರ್ವರ್‌ಗಳು';

  @override
  String locations_viewCities(String name) {
    return '$name‌ನಲ್ಲಿರುವ ನಗರಗಳನ್ನು ವೀಕ್ಷಿಸಿ';
  }

  @override
  String locations_viewServers(String name) {
    return '$name‌ನಲ್ಲಿರುವ ಸರ್ವರ್‌ಗಳನ್ನು ವೀಕ್ಷಿಸಿ';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ದೇಶಗಳು',
      one: '$count ದೇಶ',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ನಗರಗಳು',
      one: '$count ನಗರ',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಸರ್ವರ್‌ಗಳು',
      one: '$count ಸರ್ವರ್',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ಎಲ್ಲಾ ದೇಶಗಳು';

  @override
  String get locations_backToCountries => 'ದೇಶಗಳಿಗೆ ಹಿಂತಿರುಗಿ';

  @override
  String locations_backToCities(String name) {
    return '$name‌ನಲ್ಲಿರುವ ನಗರಗಳಿಗೆ ಹಿಂತಿರುಗಿ';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name ಆಯ್ಕೆಮಾಡಿ';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name ಆಯ್ಕೆಮಾಡಿ';
  }

  @override
  String get locations_noCompatibleServer =>
      'ಹೊಂದಿಕೆಯಾಗುವ ಸರ್ವರ್ ಯಾವುದೂ ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get externalLink_failed =>
      'ಈ ಲಿಂಕ್ ತೆರೆಯಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನೀವು ಇದನ್ನು ನಕಲಿಸಿ ನಿಮ್ಮ ಬ್ರೌಸರ್‌ನಲ್ಲಿ ತೆರೆಯಬಹುದು.';

  @override
  String get externalLink_copy => 'ಲಿಂಕ್ ನಕಲಿಸಿ';

  @override
  String get externalLink_copied => 'ಲಿಂಕ್ ನಕಲಿಸಲಾಗಿದೆ';

  @override
  String get externalLink_copyFailed =>
      'ಲಿಂಕ್ ನಕಲಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಕೆಳಗಿನ ವಿಳಾಸವನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get settings_deleteAccount => 'ನನ್ನ ಖಾತೆಯನ್ನು ಅಳಿಸಿ';

  @override
  String get settings_deleteAccountDetail =>
      'ಖಾತೆ ಅಳಿಸುವ ವಿನಂತಿಯ ಪ್ರಕ್ರಿಯೆಯನ್ನು ವೀಕ್ಷಿಸಿ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'ನಿಮ್ಮ VPN ಚಂದಾದಾರಿಕೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get billing_subscribe => 'ಚಂದಾದಾರರಾಗಿ';

  @override
  String get billing_choosePlan => 'ಮುಂದುವರಿಯಲು ಒಂದು ಯೋಜನೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get billing_monthly => 'ಮಾಸಿಕ';

  @override
  String get billing_yearly => 'ವಾರ್ಷಿಕ';

  @override
  String get billing_continue => 'Google Play ಮೂಲಕ ಮುಂದುವರಿಸಿ';

  @override
  String get billing_restore => 'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಿ';

  @override
  String get billing_manage => 'ಚಂದಾದಾರಿಕೆಯನ್ನು ನಿರ್ವಹಿಸಿ';

  @override
  String get billing_deleteAccountWarning =>
      'ನಿಮ್ಮ ಬಳಿ Google Play ಚಂದಾದಾರಿಕೆ ಇದ್ದರೆ, ನಿಮ್ಮ FuzeVPN ಖಾತೆಯನ್ನು ಅಳಿಸುವುದರಿಂದ ಅದರ ನವೀಕರಣ ರದ್ದಾಗುವುದಿಲ್ಲ. ನವೀಕರಣವನ್ನು Google Play ನಲ್ಲಿ ಪ್ರತ್ಯೇಕವಾಗಿ ನಿರ್ವಹಿಸಿ ಅಥವಾ ರದ್ದುಮಾಡಿ.';

  @override
  String get billing_deleteAccountContinue =>
      'ಖಾತೆ ಅಳಿಸುವ ವಿನಂತಿಯನ್ನು ಮುಂದುವರಿಸಿ';

  @override
  String get billing_refresh => 'ಪ್ರವೇಶವನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ';

  @override
  String get billing_loadingPlans => 'ಯೋಜನೆಗಳನ್ನು ಲೋಡ್ ಮಾಡಲಾಗುತ್ತಿದೆ…';

  @override
  String get billing_unavailable =>
      'ಸದ್ಯಕ್ಕೆ ಯಾವುದೇ ಯೋಜನೆಗಳು ಲಭ್ಯವಿಲ್ಲ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get billing_comingSoon => 'ಚಂದಾದಾರಿಕೆಗಳು ಶೀಘ್ರದಲ್ಲೇ ಲಭ್ಯವಾಗಲಿವೆ.';

  @override
  String get billing_priceDisclosure =>
      'ಬೆಲೆಯನ್ನು Google Play ಒದಗಿಸುತ್ತದೆ. ನೀವು ದೃಢೀಕರಿಸುವ ಮೊದಲು ಅಂತಿಮ ಮೊತ್ತ ಮತ್ತು ಅನ್ವಯವಾಗುವ ತೆರಿಗೆಗಳನ್ನು ಖಚಿತಪಡಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get billing_renewalMonthly =>
      'ರದ್ದುಮಾಡದ ಹೊರತು ಪ್ರತಿ ತಿಂಗಳು ಸ್ವಯಂಚಾಲಿತವಾಗಿ ನವೀಕರಣಗೊಳ್ಳುತ್ತದೆ. Google Play ಚಂದಾದಾರಿಕೆಗಳಲ್ಲಿ ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ರದ್ದುಮಾಡಬಹುದು.';

  @override
  String get billing_renewalYearly =>
      'ರದ್ದುಮಾಡದ ಹೊರತು ಪ್ರತಿ ವರ್ಷ ಸ್ವಯಂಚಾಲಿತವಾಗಿ ನವೀಕರಣಗೊಳ್ಳುತ್ತದೆ. Google Play ಚಂದಾದಾರಿಕೆಗಳಲ್ಲಿ ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ರದ್ದುಮಾಡಬಹುದು.';

  @override
  String get billing_active => 'ನಿಮ್ಮ Premium ಪ್ರವೇಶ ಸಕ್ರಿಯವಾಗಿದೆ';

  @override
  String billing_accessUntil(String date) {
    return '$date ವರೆಗೆ ಪ್ರವೇಶ.';
  }

  @override
  String get billing_webManaged =>
      'ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆಯನ್ನು FuzeVPN ವೆಬ್‌ಸೈಟ್‌ನಲ್ಲಿ ನಿರ್ವಹಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get billing_playManaged =>
      'ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆಯನ್ನು Google Play ಮೂಲಕ ನಿರ್ವಹಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get billing_playOnHold =>
      'ನಿಮ್ಮ Google Play ಚಂದಾದಾರಿಕೆ ತಡೆಹಿಡಿಯಲಾಗಿದೆ ಅಥವಾ ಪಾವತಿಗಾಗಿ ಕಾಯುತ್ತಿದೆ. Google Play ನಲ್ಲಿ ಸರಿಪಡಿಸಲು “ಚಂದಾದಾರಿಕೆಯನ್ನು ನಿರ್ವಹಿಸಿ” ತೆರೆಯಿರಿ.';

  @override
  String get billing_playReceiptUnlinked =>
      'ಈ Google Play ಖಾತೆಯಲ್ಲಿ ಈಗಾಗಲೇ Fuze Premium ಚಂದಾದಾರಿಕೆ ಇದೆ, ಆದರೆ ಅದು ಈ FuzeVPN ಖಾತೆಗೆ ಸಕ್ರಿಯವಾಗಿಲ್ಲ. ಪರಿಶೀಲಿಸಲು Google Play ನಲ್ಲಿ “ಚಂದಾದಾರಿಕೆಯನ್ನು ನಿರ್ವಹಿಸಿ” ತೆರೆಯಿರಿ.';

  @override
  String get billing_inactive => 'ಸಕ್ರಿಯ ಚಂದಾದಾರಿಕೆ ಇಲ್ಲ.';

  @override
  String get billing_checkingAccess => 'ನಿಮ್ಮ ಪ್ರವೇಶವನ್ನು ಪರಿಶೀಲಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get billing_restoring => 'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get billing_pending =>
      'ಪಾವತಿ ಬಾಕಿ ಇದೆ. ದೃಢೀಕರಣದ ನಂತರ ನಿಮ್ಮ ಪ್ರವೇಶ ಸಕ್ರಿಯಗೊಳ್ಳುತ್ತದೆ.';

  @override
  String get billing_cancelled =>
      'ಖರೀದಿಯನ್ನು ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ. ಹೊಸ ಚಂದಾದಾರಿಕೆಯನ್ನು ಸಕ್ರಿಯಗೊಳಿಸಲಾಗಿಲ್ಲ.';

  @override
  String get billing_verifying => 'ಖರೀದಿಯನ್ನು ಪರಿಶೀಲಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get billing_success =>
      'ಚಂದಾದಾರಿಕೆಯನ್ನು ಸಕ್ರಿಯಗೊಳಿಸಲಾಗಿದೆ. ನಿಮ್ಮ Premium ಪ್ರವೇಶ ಸಿದ್ಧವಾಗಿದೆ.';

  @override
  String get billing_restored => 'ನಿಮ್ಮ ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಲಾಗಿದೆ.';

  @override
  String get billing_restoreEmpty =>
      'ಈ Google Play ಖಾತೆಗೆ ಮರುಸ್ಥಾಪಿಸಲು ಯಾವುದೇ ಖರೀದಿಗಳಿಲ್ಲ.';

  @override
  String get billing_catalogError =>
      'ಯೋಜನೆಗಳನ್ನು ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get billing_purchaseError =>
      'ಖರೀದಿ ಪ್ರಾರಂಭಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get billing_verificationError =>
      'ಖರೀದಿ ಪರಿಶೀಲನೆ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಲು ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಿ.';

  @override
  String get billing_restoreError =>
      'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get billing_managementError =>
      'ಚಂದಾದಾರಿಕೆ ನಿರ್ವಹಣೆಯನ್ನು ತೆರೆಯಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get billing_storeUnavailable => 'ಈ ಸಾಧನದಲ್ಲಿ Google Play ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get welcome_title => 'ನಿಮ್ಮ VPN, ಈಗ ಸರಳ.';

  @override
  String get welcome_description =>
      'ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ರಕ್ಷಿಸಿ. ನಿಮ್ಮ ಗೌಪ್ಯತೆಯ ಮೇಲೆ ನಿಯಂತ್ರಣ ಇರಿಸಿಕೊಳ್ಳಿ.';

  @override
  String get welcome_start => 'ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get welcome_alreadyPurchased => 'ಈಗಾಗಲೇ ಖರೀದಿಸಿದ್ದೀರಾ?';

  @override
  String get welcome_noAccountRequired => 'ಪ್ರಾರಂಭಿಸಲು ಖಾತೆಯ ಅಗತ್ಯವಿಲ್ಲ.';

  @override
  String get guest_accountTitle => 'ಖಾತೆ ಲಿಂಕ್ ಆಗಿಲ್ಲ';

  @override
  String get guest_accountDescription =>
      'ಇನ್ನೊಂದು ಸಾಧನದಲ್ಲಿ ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆಯನ್ನು ಬಳಸಲು, ಅದೇ Google Play ಖಾತೆಯಿಂದ ನಿಮ್ಮ ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಿ.';

  @override
  String get guest_existingSubscriberSignIn =>
      'ಈಗಾಗಲೇ ಚಂದಾದಾರರೇ? ಸೈನ್ ಇನ್ ಮಾಡಿ';

  @override
  String get guest_claimTitle => 'ಎಲ್ಲೆಡೆ FuzeVPN ಬಳಸಿ';

  @override
  String get guest_claimDescription =>
      'ನಿಮ್ಮ ಇತರ ಸಾಧನಗಳಲ್ಲಿ ಚಂದಾದಾರಿಕೆಯನ್ನು ಪ್ರವೇಶಿಸಲು ಖಾತೆ ರಚಿಸಿ. ಈ ಹಂತ ಐಚ್ಛಿಕ.';

  @override
  String get guest_skip => 'ನಂತರ';

  @override
  String get guest_activationTitle => 'Fuze Premium ಸಕ್ರಿಯವಾಗಿದೆ';

  @override
  String get guest_activationDescription =>
      'ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆ ಸಿದ್ಧವಾಗಿದೆ. ನಿಮ್ಮ VPN ಬಳಸಿ, ನಿಮಗೆ ಬೇಕಾದಾಗ ಖಾತೆ ರಚಿಸಿ.';

  @override
  String get guest_useVpn => 'ನನ್ನ VPN ಬಳಸಿ';

  @override
  String get guest_loginRequired =>
      'ಈ ಖರೀದಿ ಈಗಾಗಲೇ ಒಂದು FuzeVPN ಖಾತೆಗೆ ಲಿಂಕ್ ಆಗಿದೆ. ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆಯನ್ನು ಪ್ರವೇಶಿಸಲು ಆ ಖಾತೆಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ.';

  @override
  String get guest_signOutWarning =>
      'ಅದೇ Google Play ಖಾತೆಯಿಂದ ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸುವ ಮೂಲಕ ನೀವು ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆಯನ್ನು ಮರಳಿ ಪಡೆಯಬಹುದು.';

  @override
  String get guest_profileUnavailable =>
      'ನಿಮ್ಮ ಖಾತೆ ಈಗಾಗಲೇ ಲಿಂಕ್ ಆಗಿದೆ. ನಿಮ್ಮ ವಿವರಗಳನ್ನು ವೀಕ್ಷಿಸಲು ಮತ್ತು ನಿರ್ವಹಿಸಲು ಸೈನ್ ಇನ್ ಮಾಡಿ.';

  @override
  String get billing_acceptance =>
      'ಮುಂದುವರಿಸುವ ಮೂಲಕ, ನೀವು ಬಳಕೆಯ ನಿಯಮಗಳನ್ನು ಮತ್ತು ಗೌಪ್ಯತಾ ನೀತಿಯನ್ನು ಒಪ್ಪುತ್ತೀರಿ.';

  @override
  String get guest_verifyEmailReminder =>
      'ನಿಮ್ಮ ಖಾತೆಯನ್ನು ಸುರಕ್ಷಿತಗೊಳಿಸಲು ನಿಮ್ಮ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ದೃಢೀಕರಿಸಿ. ನಿಮ್ಮ VPN ಬಳಸುವುದನ್ನು ಮುಂದುವರಿಸಬಹುದು.';

  @override
  String get guest_serviceUnavailable =>
      'ಸೇವೆ ತಾತ್ಕಾಲಿಕವಾಗಿ ಲಭ್ಯವಿಲ್ಲ. ಸ್ವಲ್ಪ ಸಮಯದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get guest_restoreError =>
      'ನಿಮ್ಮ ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಖರೀದಿಗೆ ಬಳಸಿದ Google Play ಖಾತೆಯೊಂದಿಗೆ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get guest_claimSuccess =>
      'ನಿಮ್ಮ ಖಾತೆ ರಚಿಸಲಾಗಿದೆ. ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆ ಮತ್ತು VPN ಪ್ರವೇಶ ಹಾಗೆಯೇ ಉಳಿದಿವೆ.';

  @override
  String get guest_emailExists =>
      'ಈ ಇಮೇಲ್ ಈಗಾಗಲೇ ಬಳಕೆಯಲ್ಲಿದೆ. ಬೇರೆ ವಿಳಾಸವನ್ನು ಆಯ್ಕೆಮಾಡಿ ಅಥವಾ ನಿಮ್ಮ ಅಸ್ತಿತ್ವದಲ್ಲಿರುವ ಖಾತೆಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ. ನಿಮ್ಮ ಖರೀದಿ Google Play ಮೂಲಕ ಲಭ್ಯವಾಗುತ್ತಲೇ ಇರುತ್ತದೆ.';

  @override
  String get guest_claimError =>
      'ನಿಮ್ಮ ಖಾತೆ ರಚಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನಿಮ್ಮ VPN ಬಳಸುವುದನ್ನು ಮುಂದುವರಿಸಬಹುದು ಮತ್ತು ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಬಹುದು.';

  @override
  String get guest_secureStorageError =>
      'ಈ ಸಾಧನದಲ್ಲಿ ನಿಮ್ಮ ಸೆಷನ್ ಸುರಕ್ಷಿತಗೊಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get guest_premiumRequired =>
      'ನಿಮ್ಮ VPN ಸಕ್ರಿಯಗೊಳಿಸಲು ಚಂದಾದಾರಿಕೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get welcome_viewPlans => 'ಯೋಜನೆಗಳನ್ನು ವೀಕ್ಷಿಸಿ';

  @override
  String get google_continue => 'Google ಮೂಲಕ ಮುಂದುವರಿಸಿ';

  @override
  String get google_or => 'ಅಥವಾ';

  @override
  String get google_title => 'ನಿಮ್ಮ FuzeVPN ಖಾತೆ';

  @override
  String get google_settingUp => 'ನಿಮ್ಮ ಖಾತೆಯನ್ನು ರಚಿಸುವುದನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ';

  @override
  String get google_country => 'ನಿವಾಸದ ದೇಶ';

  @override
  String get google_profileDescription =>
      'ನಿಮ್ಮ FuzeVPN ಖಾತೆ ರಚಿಸಲು ನಿಮ್ಮ ದೇಶವನ್ನು ಆಯ್ಕೆಮಾಡಿ ಮತ್ತು ಎರಡು ದಾಖಲೆಗಳನ್ನು ಪರಿಶೀಲಿಸಿ.';

  @override
  String get google_claimDescription =>
      'ನಿಮ್ಮ ಅತಿಥಿ ಖಾತೆಯನ್ನು Google ಗೆ ಲಿಂಕ್ ಮಾಡಿ. ನಿಮ್ಮ ಚಂದಾದಾರಿಕೆ ಮತ್ತು ಸಾಧನ ಈ ಖಾತೆಯೊಂದಿಗೇ ಉಳಿಯುತ್ತವೆ.';

  @override
  String get google_linkTitle => 'Google ಅನ್ನು FuzeVPN ಗೆ ಲಿಂಕ್ ಮಾಡಿ';

  @override
  String get google_linkDescription =>
      'ನಿಮ್ಮ ಅಸ್ತಿತ್ವದಲ್ಲಿರುವ FuzeVPN ಖಾತೆಯ ಪ್ರವೇಶವನ್ನು ದೃಢೀಕರಿಸಿ. ಈ ಹಂತದಲ್ಲಿ ನಿಮ್ಮ Google ಪಾಸ್‌ವರ್ಡ್ ಕೇಳುವುದಿಲ್ಲ.';

  @override
  String get google_password => 'FuzeVPN ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get google_linkAccount => 'ಲಿಂಕ್ ಅನ್ನು ದೃಢೀಕರಿಸಿ';

  @override
  String get google_requestEmail => 'ನನಗೆ ದೃಢೀಕರಣ ಇಮೇಲ್ ಕಳುಹಿಸಿ';

  @override
  String get google_emailInstructions =>
      'FuzeVPN ಇಮೇಲ್ ತೆರೆಯಿರಿ ಮತ್ತು ದೃಢೀಕರಣ ಕೋಡ್ ನಮೂದಿಸಿ.';

  @override
  String get google_emailCode => 'ಇಮೇಲ್ ದೃಢೀಕರಣ ಕೋಡ್';

  @override
  String get google_confirmEmail => 'ಕೋಡ್ ಅನ್ನು ದೃಢೀಕರಿಸಿ';

  @override
  String get google_restart => 'ಇನ್ನೊಂದು Google ಖಾತೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get google_resume => 'ಈ ಪ್ರಯತ್ನವನ್ನು ಪರಿಶೀಲಿಸಿ';

  @override
  String get google_unavailable =>
      'Google ಸೈನ್ ಇನ್ ಲಭ್ಯವಿಲ್ಲ. ನೀವು ಇಮೇಲ್ ಮತ್ತು ಪಾಸ್‌ವರ್ಡ್ ಬಳಸಬಹುದು.';

  @override
  String get google_expired =>
      'ಈ ಪ್ರಯತ್ನದ ಅವಧಿ ಮುಗಿದಿದೆ. ಇದನ್ನು ರದ್ದುಮಾಡಿ ಮತ್ತೆ ಪ್ರಾರಂಭಿಸಿ.';

  @override
  String get google_conflict =>
      'ಈ Google ಖಾತೆ ಈಗಾಗಲೇ ಬೇರೆಡೆ ಲಿಂಕ್ ಆಗಿದೆ. ನಿಮ್ಮ ಪ್ರಸ್ತುತ ಖಾತೆ ಮತ್ತು ಚಂದಾದಾರಿಕೆ ಉಳಿದಿವೆ.';

  @override
  String get google_error =>
      'Google ಸೈನ್ ಇನ್ ವಿಫಲವಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ; ನಿಮ್ಮ ಪ್ರಸ್ತುತ ಪ್ರವೇಶ ಉಳಿದಿದೆ.';

  @override
  String get google_uncertain =>
      'ಫಲಿತಾಂಶವನ್ನು ದೃಢೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಾರಂಭಿಸುವ ಮೊದಲು ಈ ಪ್ರಯತ್ನವನ್ನು ಪರಿಶೀಲಿಸಿ ಅಥವಾ ರದ್ದುಮಾಡಿ.';

  @override
  String get google_cancelFailed =>
      'ರದ್ದತಿಯನ್ನು ದೃಢೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಈ ಪರದೆಯಿಂದ ಹೊರಹೋಗುವ ಮೊದಲು ಮತ್ತೆ ರದ್ದುಮಾಡಲು ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get google_cancelled => 'Google ಸೈನ್ ಇನ್ ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ.';

  @override
  String get google_selecting => 'ನಿಮ್ಮ Google ಖಾತೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ…';

  @override
  String get google_verifying => 'ನಿಮ್ಮ ಖಾತೆಯನ್ನು ಪರಿಶೀಲಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get google_emailUnavailable =>
      'ದೃಢೀಕರಣ ಇಮೇಲ್ ಕಳುಹಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get google_emailSent =>
      'ದೃಢೀಕರಣ ಇಮೇಲ್ ಕಳುಹಿಸಲಾಗಿದೆ. ನಿಮ್ಮ ಇನ್‌ಬಾಕ್ಸ್ ಪರಿಶೀಲಿಸಿ.';

  @override
  String get google_rateLimited => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸುವ ಮೊದಲು ದಯವಿಟ್ಟು ಕಾಯಿರಿ.';

  @override
  String get google_busy =>
      'ಇನ್ನೊಂದು ಕಾರ್ಯಾಚರಣೆ ನಡೆಯುತ್ತಿರುವಾಗ (VPN ಸಂಪರ್ಕ, ಖಾತೆ ಅಥವಾ ಅತಿಥಿ) Google ಲಭ್ಯವಿರುವುದಿಲ್ಲ. ಅದು ಮುಗಿದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ; ನಿಮ್ಮ ಪ್ರಸ್ತುತ ಪ್ರವೇಶ ಉಳಿದಿದೆ.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN ಪಾಸ್‌ವರ್ಡ್ ತಪ್ಪಾಗಿದೆ. ನಿಮ್ಮ ಪ್ರಸ್ತುತ ಖಾತೆ ಉಳಿದಿದೆ.';

  @override
  String get google_invalidCode =>
      'ದೃಢೀಕರಣ ಕೋಡ್ ಅಮಾನ್ಯವಾಗಿದೆ ಅಥವಾ ಅವಧಿ ಮುಗಿದಿದೆ.';

  @override
  String get google_accountChanged =>
      'ನಿಮ್ಮ ಸೆಷನ್ ಬದಲಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಾರಂಭಿಸುವ ಮೊದಲು ಈ ಪ್ರಯತ್ನವನ್ನು ರದ್ದುಮಾಡಿ.';

  @override
  String get google_invalidResponse =>
      'ಪ್ರತಿಕ್ರಿಯೆಯನ್ನು ಮೌಲ್ಯೀಕರಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನಿಮ್ಮ ಪ್ರಸ್ತುತ ಪ್ರವೇಶ ಉಳಿದಿದೆ.';

  @override
  String get google_invalidRegistration =>
      'ನಿಮ್ಮ ದೇಶ ಮತ್ತು ಎರಡೂ ಒಪ್ಪಿಗೆಗಳನ್ನು ಪರಿಶೀಲಿಸಿ.';

  @override
  String get google_consentRequired =>
      'ಮುಂದುವರಿಸಲು ನಿಮ್ಮ ದೇಶವನ್ನು ಆಯ್ಕೆಮಾಡಿ ಮತ್ತು ಎರಡೂ ದಾಖಲೆಗಳನ್ನು ಒಪ್ಪಿಕೊಳ್ಳಿ.';

  @override
  String get google_challengeRequired =>
      'ಹೆಚ್ಚುವರಿ ಭದ್ರತಾ ಪರಿಶೀಲನೆ ಅಗತ್ಯವಿದೆ. ನಿಮ್ಮ ಪ್ರಸ್ತುತ ಪ್ರವೇಶ ಉಳಿದಿದೆ.';

  @override
  String get google_challengeUnavailable =>
      'ಭದ್ರತಾ ಪರಿಶೀಲನೆ ಲಭ್ಯವಿಲ್ಲ. ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get google_intentMismatch =>
      'ಹಿಂದಿನ Google ಸೈನ್ ಇನ್ ಪ್ರಯತ್ನ ಇನ್ನೂ ಬಾಕಿ ಇದೆ. ಈ ಕಾರ್ಯಾಚರಣೆ ಪ್ರಾರಂಭಿಸುವ ಮೊದಲು ಅದನ್ನು ರದ್ದುಮಾಡಿ.';

  @override
  String get google_challengeBlocked =>
      'ಅಗತ್ಯವಿರುವ ಭದ್ರತಾ ಪರಿಶೀಲನೆ ಈ ಆ್ಯಪ್‌ನಲ್ಲಿ ಲಭ್ಯವಿಲ್ಲ. ಈ ಕಾರ್ಯಾಚರಣೆಯನ್ನು ಈಗ ಪೂರ್ಣಗೊಳಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get google_solveChallenge => 'ಭದ್ರತಾ ಪರಿಶೀಲನೆಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ';

  @override
  String get google_challengeTitle => 'ಭದ್ರತಾ ಪರಿಶೀಲನೆ';

  @override
  String get google_challengeReady =>
      'ಪರಿಶೀಲನೆ ಪೂರ್ಣಗೊಂಡಿದೆ. ಈಗ ನಿಮ್ಮ ಖಾತೆ ರಚನೆಯನ್ನು ದೃಢೀಕರಿಸಬಹುದು.';

  @override
  String get google_challengeExpired =>
      'ಪರಿಶೀಲನೆಯ ಅವಧಿ ಮುಗಿದಿದೆ. ದೃಢೀಕರಿಸುವ ಮೊದಲು ಮತ್ತೆ ಪೂರ್ಣಗೊಳಿಸಿ.';

  @override
  String get google_challengeCancelled =>
      'ಪರಿಶೀಲನೆ ರದ್ದುಗೊಳಿಸಲಾಗಿದೆ. ನೀವು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಬಹುದು.';

  @override
  String get google_challengeFailed =>
      'ಭದ್ರತಾ ಪರಿಶೀಲನೆ ವಿಫಲವಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get billing_trialTitle => 'Fuze Premium ಅನ್ನು ಉಚಿತವಾಗಿ ಬಳಸಿ ನೋಡಿ';

  @override
  String get billing_trialSubtitle => 'ಇಂದಿನಿಂದಲೇ ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ರಕ್ಷಿಸಿ.';

  @override
  String get billing_trialWeeks => '2 ವಾರಗಳ ಉಚಿತ ಪ್ರಯೋಗ';

  @override
  String billing_trialDays(String days) {
    return '$days ದಿನದ ಉಚಿತ ಪ್ರಯೋಗ';
  }

  @override
  String get billing_trialStart => 'ನನ್ನ ಉಚಿತ ಪ್ರಯೋಗವನ್ನು ಪ್ರಾರಂಭಿಸಿ';

  @override
  String billing_trialFirstCharge(String date) {
    return 'ಇಂದು ಪ್ರಾರಂಭಿಸಿದರೆ, ನಿಮ್ಮ ಮೊದಲ ಶುಲ್ಕ $date ರಂದು ಆಗುವ ನಿರೀಕ್ಷೆ ಇದೆ.';
  }

  @override
  String get billing_trialTerms =>
      'ತಿಳಿಸಲಾದ ಬೆಲೆಯಲ್ಲಿ ಸ್ವಯಂಚಾಲಿತವಾಗಿ ನವೀಕರಣಗೊಳ್ಳುತ್ತದೆ. ಶುಲ್ಕ ತಪ್ಪಿಸಲು, ಪ್ರಯೋಗ ಮುಗಿಯುವ ಮೊದಲು Google Play ನಲ್ಲಿ ರದ್ದುಮಾಡಿ.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'ನಂತರ ತಿಂಗಳಿಗೆ $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'ನಂತರ ವರ್ಷಕ್ಕೆ $price';
  }

  @override
  String get billing_choosePeriod => 'ನಿಮ್ಮ ಯೋಜನೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get billing_selectionHint => 'ಮುಂದುವರಿಯಲು ಒಂದು ಯೋಜನೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get billing_benefitConnection => 'ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿದ ಸಂಪರ್ಕ';

  @override
  String get billing_benefitPrivacy => 'ಆನ್‌ಲೈನ್ ಗೌಪ್ಯತೆ';

  @override
  String get billing_benefitNoAccount => 'ನೋಂದಣಿ ಅಗತ್ಯವಿಲ್ಲ';

  @override
  String get billing_cancellation => 'Google Play ನಲ್ಲಿ ರದ್ದುಮಾಡಿ';

  @override
  String get billing_premiumTitle => 'ಉತ್ತಮ ರಕ್ಷಣೆಯ ಸಂಪರ್ಕ.';

  @override
  String get billing_premiumSubtitle =>
      'ನಿಮ್ಮ ಸ್ವಂತ ವೇಗದಲ್ಲಿ ನಿಮ್ಮ ಸಂಪರ್ಕವನ್ನು ರಕ್ಷಿಸಿ.';

  @override
  String get billing_priceMonthly => 'ತಿಂಗಳಿಗೆ';

  @override
  String get billing_priceYearly => 'ವರ್ಷಕ್ಕೆ';

  @override
  String get billing_trialToday => 'ಇಂದು ಏನನ್ನೂ ಪಾವತಿಸಬೇಕಿಲ್ಲ';

  @override
  String get billing_trialConfirmation =>
      'ದಿನಾಂಕಗಳು, ಅಂತಿಮ ಮೊತ್ತ ಮತ್ತು ಅನ್ವಯವಾಗುವ ತೆರಿಗೆಗಳನ್ನು ನೀವು ದೃಢೀಕರಿಸುವ ಮೊದಲು Google Play ಖಚಿತಪಡಿಸುತ್ತದೆ.';

  @override
  String get billing_offerChanged =>
      'ಈ ಆಫರ್‌ನ ನಿಯಮಗಳು ಬದಲಾಗಿವೆ. ಯೋಜನೆಗಳನ್ನು ರಿಫ್ರೆಶ್ ಮಾಡಿ ಮತ್ತು ಮತ್ತೆ ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get status_waitingNetwork => 'ನೆಟ್‌ವರ್ಕ್ ನಿರೀಕ್ಷೆ';

  @override
  String get status_waitingNetworkDetail =>
      'ನೆಟ್‌ವರ್ಕ್ ಲಭ್ಯವಿಲ್ಲ. ನೆಟ್‌ವರ್ಕ್ ಮರಳಿದಾಗ VPN ಸಂಪರ್ಕವನ್ನು ಪರಿಶೀಲಿಸುತ್ತದೆ.';

  @override
  String get locations_favoriteLoadFailed =>
      'ಮೆಚ್ಚಿನವುಗಳನ್ನು ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get locations_favoritesLoading =>
      'ಮೆಚ್ಚಿನವುಗಳನ್ನು ಲೋಡ್ ಮಾಡಲಾಗುತ್ತಿದೆ…';
}
