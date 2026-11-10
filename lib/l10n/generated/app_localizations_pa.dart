// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get vpnDisclosure_title => 'ਆਪਣੇ ਕਨੈਕਸ਼ਨ ਨੂੰ ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ਇਸ ਡੀਵਾਈਸ ਅਤੇ FuzeVPN ਸਰਵਰਾਂ ਵਿਚਕਾਰ ਇਨਕ੍ਰਿਪਟਡ ਟਨਲ ਬਣਾਉਣ ਲਈ Android ਦੀ VPN ਸੇਵਾ (VpnService) ਵਰਤਦਾ ਹੈ।';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN ਚਾਲੂ ਹੋਣ ਦੌਰਾਨ, ਤੁਹਾਡੀਆਂ ਐਪਾਂ ਦਾ ਇੰਟਰਨੈੱਟ ਟ੍ਰੈਫ਼ਿਕ, ਮੰਜ਼ਿਲ ਦੇ ਪਤੇ ਅਤੇ DNS ਬੇਨਤੀਆਂ ਤੁਹਾਡੇ ਕਨੈਕਸ਼ਨ ਨੂੰ ਰੂਟ ਕਰਨ ਲਈ ਇਸ ਟਨਲ ਰਾਹੀਂ ਲੰਘਦੇ ਹਨ, ਭਾਵੇਂ FuzeVPN ਬੈਕਗ੍ਰਾਊਂਡ ਵਿੱਚ ਹੋਵੇ।';

  @override
  String get vpnDisclosure_statusBody =>
      'ਤੁਹਾਡਾ VPN ਕਨੈਕਸ਼ਨ ਦਿਖਾਉਣ ਲਈ ਐਪ ਕਨੈਕਸ਼ਨ ਦੀ ਸਥਿਤੀ, ਇਸ ਦੀ ਮਿਆਦ ਅਤੇ ਟ੍ਰਾਂਸਫ਼ਰ ਹੋਏ ਡੇਟਾ ਦੀ ਮਾਤਰਾ ਵਰਤਦੀ ਹੈ। ਤੁਸੀਂ ਇਸ ਨੂੰ ਕਿਸੇ ਵੀ ਵੇਲੇ ਰੋਕ ਸਕਦੇ ਹੋ।';

  @override
  String get vpnDisclosure_privacy => 'ਗੋਪਨੀਯਤਾ';

  @override
  String get vpnDisclosure_accept => 'ਸਵੀਕਾਰ ਕਰੋ ਅਤੇ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get vpnDisclosure_decline => 'ਹੁਣ ਨਹੀਂ';

  @override
  String get accountRestoration_title => 'ਖਾਤਾ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get accountRestoration_message =>
      'ਤੁਹਾਡਾ ਸੈਸ਼ਨ ਸੰਭਾਲ ਕੇ ਰੱਖਿਆ ਗਿਆ ਹੈ। ਆਪਣਾ ਖਾਤਾ ਬਹਾਲ ਕਰਨ ਲਈ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ। ਤੁਸੀਂ ਅਜੇ ਵੀ ਇੱਥੋਂ VPN ਕਨੈਕਸ਼ਨ ਦਾ ਪ੍ਰਬੰਧ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get action_retry => 'ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get session_endingTitle => 'ਸੈਸ਼ਨ ਖ਼ਤਮ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ';

  @override
  String get session_ending =>
      'ਸੈਸ਼ਨ ਖ਼ਤਮ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ: VPN ਬੰਦ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ ਅਤੇ ਸਫ਼ਾਈ ਕੀਤੀ ਜਾ ਰਹੀ ਹੈ…';

  @override
  String get session_stopFailed =>
      'VPN ਬੰਦ ਹੋਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ। ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get session_cleanupFailed =>
      'VPN ਬੰਦ ਹੋ ਗਿਆ ਹੈ, ਪਰ ਸੈਸ਼ਨ ਹਟਾਏ ਜਾਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ। ਸਫ਼ਾਈ ਦੀ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get session_retryStop => 'ਬੰਦ ਕਰਨ ਦੀ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get session_retryCleanup => 'ਸਫ਼ਾਈ ਦੀ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN ਸੁਰੱਖਿਅਤ ਢੰਗ ਨਾਲ ਤਿਆਰ ਹੋ ਰਿਹਾ ਹੈ…';

  @override
  String get nav_connection => 'ਕਨੈਕਸ਼ਨ';

  @override
  String get nav_locations => 'ਟਿਕਾਣੇ';

  @override
  String get nav_account => 'ਖਾਤਾ';

  @override
  String get nav_devices => 'ਡੀਵਾਈਸਾਂ';

  @override
  String get nav_settings => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get action_refresh => 'ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get auth_tab_login => 'ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get auth_tab_register => 'ਸਾਈਨ ਅੱਪ ਕਰੋ';

  @override
  String get auth_stepAccount => 'ਖਾਤਾ';

  @override
  String get auth_stepIdentity => 'ਪਛਾਣ';

  @override
  String get auth_stepAddress => 'ਪਤਾ ਅਤੇ ਸਹਿਮਤੀਆਂ';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$total ਵਿੱਚੋਂ ਕਦਮ $current';
  }

  @override
  String get auth_tagline => 'ਤੁਹਾਡਾ VPN, ਹੁਣ ਬਹੁਤ ਸੌਖਾ।';

  @override
  String get auth_keysLocal =>
      'ਤੁਹਾਡੀਆਂ ਨਿੱਜੀ VPN ਕੁੰਜੀਆਂ ਇਸ ਡੀਵਾਈਸ ’ਤੇ ਹੀ ਰਹਿੰਦੀਆਂ ਹਨ।';

  @override
  String get form_email => 'ਈਮੇਲ ਪਤਾ';

  @override
  String get form_password => 'ਪਾਸਵਰਡ';

  @override
  String get form_showPassword => 'ਪਾਸਵਰਡ ਦਿਖਾਓ';

  @override
  String get form_hidePassword => 'ਪਾਸਵਰਡ ਲੁਕਾਓ';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 ਬਾਈਟ। ਕੁਝ ਅੱਖਰ ਇੱਕ ਤੋਂ ਵੱਧ ਬਾਈਟ ਵਰਤਦੇ ਹਨ।';

  @override
  String get form_firstName => 'ਪਹਿਲਾ ਨਾਮ';

  @override
  String get form_lastName => 'ਆਖ਼ਰੀ ਨਾਮ';

  @override
  String get form_phone => 'ਫ਼ੋਨ ਨੰਬਰ (+33612345678)';

  @override
  String get form_address => 'ਪਤਾ';

  @override
  String get form_address2 => 'ਪਤੇ ਦੀ ਲਾਈਨ 2 (ਵਿਕਲਪਿਕ)';

  @override
  String get form_postalCode => 'ਡਾਕ ਕੋਡ';

  @override
  String get form_city => 'ਸ਼ਹਿਰ';

  @override
  String get form_country => 'ਦੇਸ਼ ਕੋਡ (ਜਿਵੇਂ FR)';

  @override
  String get action_login => 'ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get action_createAccount => 'ਖਾਤਾ ਬਣਾਓ';

  @override
  String get action_createMyAccount => 'ਮੇਰਾ ਖਾਤਾ ਬਣਾਓ';

  @override
  String get action_next => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get action_previous => 'ਪਿੱਛੇ';

  @override
  String get action_forgotPassword => 'ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ ਹੋ?';

  @override
  String get auth_noAccount => 'ਤੁਹਾਡੇ ਕੋਲ ਅਜੇ ਖਾਤਾ ਨਹੀਂ ਹੈ?';

  @override
  String get auth_requiredInformation => 'ਤਿੰਨ ਕਦਮਾਂ ਵਿੱਚ ਆਪਣਾ ਖਾਤਾ ਬਣਾਓ।';

  @override
  String get auth_termsPrefix => 'ਮੈਂ ਇਨ੍ਹਾਂ ਨਾਲ ਸਹਿਮਤ ਹਾਂ: ';

  @override
  String get auth_termsLink => 'ਵਰਤੋਂ ਦੀਆਂ ਸ਼ਰਤਾਂ';

  @override
  String get auth_privacyPrefix => 'ਮੈਂ ਇਸ ਨਾਲ ਸਹਿਮਤ ਹਾਂ: ';

  @override
  String get auth_privacyLink => 'ਗੋਪਨੀਯਤਾ ਨੀਤੀ';

  @override
  String get auth_consentRequired => 'ਖਾਤਾ ਬਣਾਉਣ ਲਈ ਤੁਹਾਡੀ ਸਹਿਮਤੀ ਲਾਜ਼ਮੀ ਹੈ।';

  @override
  String get validation_required => 'ਇਹ ਖੇਤਰ ਲਾਜ਼ਮੀ ਹੈ।';

  @override
  String get validation_email => 'ਵੈਧ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ।';

  @override
  String get validation_password =>
      'ਪਾਸਵਰਡ ਬਹੁਤ ਛੋਟਾ ਹੈ: ਘੱਟੋ-ਘੱਟ 8 UTF-8 ਬਾਈਟ ਹੋਣੇ ਚਾਹੀਦੇ ਹਨ।';

  @override
  String get validation_passwordTooLong =>
      'ਪਾਸਵਰਡ ਬਹੁਤ ਲੰਬਾ ਹੈ: ਵੱਧ ਤੋਂ ਵੱਧ 72 UTF-8 ਬਾਈਟ ਹੋ ਸਕਦੇ ਹਨ।';

  @override
  String get validation_phone =>
      'ਅੰਤਰਰਾਸ਼ਟਰੀ ਫ਼ਾਰਮੈਟ ਵਰਤੋ, ਜਿਵੇਂ ਕਿ +33612345678।';

  @override
  String get validation_country => 'ਦੋ ਅੱਖਰਾਂ ਦਾ ਦੇਸ਼ ਕੋਡ ਵਰਤੋ, ਜਿਵੇਂ ਕਿ FR।';

  @override
  String get passwordReset_title => 'ਪਾਸਵਰਡ ਰੀਸੈੱਟ ਕਰੋ';

  @override
  String get passwordReset_description =>
      'ਪਾਸਵਰਡ ਰੀਸੈੱਟ ਲਿੰਕ ਮੰਗਣ ਲਈ ਆਪਣੇ ਖਾਤੇ ਦਾ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ।';

  @override
  String get passwordReset_send => 'ਲਿੰਕ ਭੇਜੋ';

  @override
  String get connection_title => 'ਤੁਹਾਡਾ ਕਨੈਕਸ਼ਨ';

  @override
  String get connection_subtitle => 'ਟਿਕਾਣਾ ਚੁਣੋ, ਫਿਰ ਆਪਣਾ VPN ਚਾਲੂ ਕਰੋ।';

  @override
  String get connection_prepare => 'ਕਨੈਕਟ ਕਰਨ ਲਈ ਤਿਆਰ ਹੋ?';

  @override
  String get connection_advancedOptions => 'ਉੱਨਤ ਵਿਕਲਪ';

  @override
  String get connection_location => 'ਟਿਕਾਣਾ';

  @override
  String get connection_chooseLocation => 'ਟਿਕਾਣਾ ਚੁਣੋ';

  @override
  String get connection_protocol => 'ਪ੍ਰੋਟੋਕੋਲ';

  @override
  String get connection_connect => 'ਕਨੈਕਟ ਕਰੋ';

  @override
  String get connection_connecting => 'ਕਨੈਕਟ ਹੋ ਰਿਹਾ ਹੈ…';

  @override
  String get connection_disconnect => 'ਡਿਸਕਨੈਕਟ ਕਰੋ';

  @override
  String get connection_disconnecting => 'ਡਿਸਕਨੈਕਟ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get connection_locationChange => 'ਟਿਕਾਣਾ ਬਦਲਿਆ ਜਾ ਰਿਹਾ ਹੈ…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ਉਪਲਬਧ ਨਹੀਂ';
  }

  @override
  String get connection_activeLocation => 'ਸਰਗਰਮ ਟਿਕਾਣਾ';

  @override
  String get connection_duration => 'ਮਿਆਦ';

  @override
  String get connection_received => 'ਪ੍ਰਾਪਤ ਹੋਇਆ';

  @override
  String get connection_sent => 'ਭੇਜਿਆ ਗਿਆ';

  @override
  String get connection_lastHandshake => 'ਆਖ਼ਰੀ ਸੁਰੱਖਿਅਤ ਆਦਾਨ-ਪ੍ਰਦਾਨ';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ਪਹਿਲਾਂ';
  }

  @override
  String get verification_title => 'ਆਪਣੇ ਈਮੇਲ ਪਤੇ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get verification_message =>
      'ਇਸ ਫ਼ੋਨ ’ਤੇ VPN ਵਰਤਣ ਲਈ ਆਪਣੇ ਈਮੇਲ ਪਤੇ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ।';

  @override
  String get verification_resend => 'ਈਮੇਲ ਮੁੜ ਭੇਜੋ';

  @override
  String get migration_title => 'ਟਿਕਾਣਾ ਬਦਲਣਾ';

  @override
  String get migration_draining => 'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਤਿਆਰੀ ਹੋ ਰਹੀ ਹੈ…';

  @override
  String get migration_activating => 'ਨਵਾਂ ਸਰਵਰ ਸਰਗਰਮ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ…';

  @override
  String get migration_ready => 'ਟਿਕਾਣਾ ਅੱਪਡੇਟ ਕੀਤਾ ਗਿਆ।';

  @override
  String get migration_blocked =>
      'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ ਸਰਵਰ ਵੱਲੋਂ ਦਖ਼ਲ ਦੀ ਲੋੜ ਹੈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ ਜਾਂ ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ।';

  @override
  String get migration_progress => 'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪ੍ਰਗਤੀ';

  @override
  String migration_retryDelay(Object seconds) {
    return 'ਜਾਂਚਾਂ ਵਿਚਕਾਰ ਉਡੀਕ: $seconds ਸਕਿੰਟ।';
  }

  @override
  String get migration_resume => 'ਟਿਕਾਣਾ ਬਦਲਣਾ ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get status_authorizing => 'ਇਜਾਜ਼ਤ ਲੋੜੀਂਦੀ ਹੈ';

  @override
  String get status_authorizingDetail =>
      'VPN ਦੀ ਇਜਾਜ਼ਤ ਦੇਣ ਲਈ Android ਦੀ ਬੇਨਤੀ ਸਵੀਕਾਰ ਕਰੋ।';

  @override
  String get status_preparing => 'ਤਿਆਰ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get status_preparingDetail =>
      'ਤੁਹਾਡਾ ਸੁਰੱਖਿਅਤ ਕਨੈਕਸ਼ਨ ਤਿਆਰ ਹੋ ਰਿਹਾ ਹੈ।';

  @override
  String get status_reconnecting => 'ਮੁੜ ਕਨੈਕਟ ਹੋ ਰਿਹਾ ਹੈ…';

  @override
  String get status_reconnectingDetail =>
      'ਕਨੈਕਸ਼ਨ ਵਿੱਚ ਵਿਘਨ ਪਿਆ। VPN ਮੁੜ ਕਨੈਕਟ ਕਰਨ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰ ਰਿਹਾ ਹੈ।';

  @override
  String get status_connecting => 'ਕਨੈਕਟ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get status_connectingDetail => 'VPN ਸਰਵਰ ਨਾਲ ਕਨੈਕਟ ਹੋ ਰਿਹਾ ਹੈ…';

  @override
  String get status_connected => 'ਕਨੈਕਟ ਹੋਇਆ';

  @override
  String get status_connectedDetail => 'ਤੁਹਾਡਾ VPN ਕਨੈਕਸ਼ਨ ਸਰਗਰਮ ਹੈ।';

  @override
  String get status_disconnecting => 'ਡਿਸਕਨੈਕਟ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get status_disconnectingDetail => 'ਤੁਹਾਡਾ VPN ਕਨੈਕਸ਼ਨ ਬੰਦ ਹੋ ਰਿਹਾ ਹੈ।';

  @override
  String get status_error => 'ਕਨੈਕਸ਼ਨ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get status_errorDetail =>
      'VPN ਕਨੈਕਸ਼ਨ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get status_idle => 'ਡਿਸਕਨੈਕਟ ਹੋਇਆ';

  @override
  String get status_idleDetail => 'ਆਪਣੇ ਕਨੈਕਸ਼ਨ ਦੀ ਸੁਰੱਖਿਆ ਲਈ VPN ਕਨੈਕਟ ਕਰੋ।';

  @override
  String get trust_note =>
      'ਐਪ ਬੰਦ ਕਰਨ ਨਾਲ VPN ਬੰਦ ਨਹੀਂ ਹੁੰਦਾ। ਇਸ ਨੂੰ ਬੰਦ ਕਰਨ ਲਈ “ਡਿਸਕਨੈਕਟ ਕਰੋ” ਦੀ ਵਰਤੋਂ ਕਰੋ।';

  @override
  String get locations_none => 'ਇਸ ਵੇਲੇ ਕੋਈ ਟਿਕਾਣਾ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String get locations_available => 'ਆਪਣਾ ਅਗਲਾ ਟਿਕਾਣਾ ਚੁਣੋ।';

  @override
  String get locations_selected => 'ਚੁਣਿਆ ਗਿਆ ਟਿਕਾਣਾ';

  @override
  String get locations_select => 'ਇਹ ਟਿਕਾਣਾ ਚੁਣੋ';

  @override
  String get locations_lockedTunnel => 'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ VPN ਡਿਸਕਨੈਕਟ ਕਰੋ।';

  @override
  String get locations_lockedMigration =>
      'ਟਿਕਾਣਾ ਬਦਲਣਾ ਮੁਕੰਮਲ ਹੋਣ ਦੀ ਉਡੀਕ ਕਰੋ।';

  @override
  String get devices_title => 'ਤੁਹਾਡੇ ਡੀਵਾਈਸ';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ਡੀਵਾਈਸ';
  }

  @override
  String get devices_refresh => 'ਡੀਵਾਈਸ ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get devices_empty => 'ਅਜੇ ਤੱਕ ਕੋਈ VPN ਡੀਵਾਈਸ ਰਜਿਸਟਰ ਨਹੀਂ ਹੋਇਆ।';

  @override
  String get devices_firstConnection =>
      'ਪਹਿਲੇ ਕਨੈਕਸ਼ਨ ’ਤੇ ਤੁਹਾਡਾ ਫ਼ੋਨ ਜੋੜਿਆ ਜਾਵੇਗਾ।';

  @override
  String get devices_thisDevice => 'ਇਹ ਡੀਵਾਈਸ';

  @override
  String devices_added(Object date) {
    return '$date ਨੂੰ ਜੋੜਿਆ ਗਿਆ';
  }

  @override
  String get devices_unnamed => 'ਬਿਨਾਂ ਨਾਮ ਵਾਲਾ ਡੀਵਾਈਸ';

  @override
  String get action_remove => 'ਹਟਾਓ';

  @override
  String get settings_title => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get settings_subtitle => 'ਤੁਹਾਡੀਆਂ ਪਸੰਦਾਂ ਅਤੇ ਖਾਤਾ, ਸਭ ਇੱਕੋ ਥਾਂ ’ਤੇ।';

  @override
  String get settings_appearance => 'ਦਿੱਖ';

  @override
  String get settings_language => 'ਭਾਸ਼ਾ';

  @override
  String get settings_languageDescription =>
      'ਤੁਹਾਡੀ ਚੁਣੀ ਹੋਈ ਭਾਸ਼ਾ VPN ਸੂਚਨਾਵਾਂ ’ਤੇ ਵੀ ਲਾਗੂ ਹੁੰਦੀ ਹੈ।';

  @override
  String get settings_account => 'ਖਾਤਾ';

  @override
  String get settings_signOut => 'ਸਾਈਨ ਆਉਟ ਕਰੋ';

  @override
  String get settings_privacy => 'ਗੋਪਨੀਯਤਾ ਨੀਤੀ';

  @override
  String get settings_terms => 'ਵਰਤੋਂ ਦੀਆਂ ਸ਼ਰਤਾਂ';

  @override
  String get settings_security => 'ਸੁਰੱਖਿਆ ਅਤੇ ਪਾਰਦਰਸ਼ਤਾ';

  @override
  String get settings_licenses => 'ਕੰਪੋਨੈਂਟ ਲਾਇਸੈਂਸ';

  @override
  String get settings_licensesDetail => 'ਐਪ ਵਿੱਚ ਵਰਤਿਆ ਗਿਆ ਸਾਫ਼ਟਵੇਅਰ';

  @override
  String settings_licensesLegalese(String url) {
    return 'ਐਪ ਅਤੇ ਇਸ ਦੇ MPL-2.0 ਕੰਪੋਨੈਂਟਾਂ ਦਾ ਸੋਰਸ ਕੋਡ: $url';
  }

  @override
  String get settings_background =>
      'ਐਪ ਤੋਂ ਬਾਹਰ ਜਾਣ ’ਤੇ ਵੀ VPN ਚਾਲੂ ਰਹਿੰਦਾ ਹੈ। ਇਸ ਨੂੰ ਬੰਦ ਕਰਨ ਲਈ ਕਨੈਕਸ਼ਨ ਟੈਬ ’ਤੇ “ਡਿਸਕਨੈਕਟ ਕਰੋ” ਦੀ ਵਰਤੋਂ ਕਰੋ।';

  @override
  String get theme_system => 'ਸਿਸਟਮ';

  @override
  String get theme_light => 'ਲਾਈਟ';

  @override
  String get theme_dark => 'ਡਾਰਕ';

  @override
  String get language_system => 'ਫ਼ੋਨ ਦੀ ਭਾਸ਼ਾ';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'ਕੀ ਇਹ ਡੀਵਾਈਸ ਹਟਾਉਣਾ ਹੈ?';

  @override
  String get dialog_removeCurrent =>
      'ਇਹ ਫ਼ੋਨ VPN ਤੋਂ ਡਿਸਕਨੈਕਟ ਹੋ ਜਾਵੇਗਾ ਅਤੇ ਇਸ ਦੀ ਪਹੁੰਚ ਖ਼ਤਮ ਹੋ ਜਾਵੇਗੀ। ਸਰਵਰ ਦੀ ਪੁਸ਼ਟੀ ਤੋਂ ਬਾਅਦ ਇਸ ਦਾ VPN ਕਨੈਕਸ਼ਨ ਡੇਟਾ ਹਟਾ ਦਿੱਤਾ ਜਾਵੇਗਾ।';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” ਦੀ VPN ਪਹੁੰਚ ਰੱਦ ਕਰ ਦਿੱਤੀ ਜਾਵੇਗੀ। ਇਸ ਕਾਰਵਾਈ ਨੂੰ ਵਾਪਸ ਨਹੀਂ ਲਿਆ ਜਾ ਸਕਦਾ।';
  }

  @override
  String get dialog_signOut => 'ਕੀ ਸਾਈਨ ਆਉਟ ਕਰਨਾ ਹੈ?';

  @override
  String get dialog_signOutMessage =>
      'VPN ਬੰਦ ਹੋ ਜਾਵੇਗਾ ਅਤੇ ਤੁਹਾਨੂੰ ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰਨਾ ਪਵੇਗਾ। ਤੁਹਾਡੀਆਂ ਇਨਕ੍ਰਿਪਟਡ VPN ਕੁੰਜੀਆਂ ਅਗਲੇ ਕਨੈਕਸ਼ਨ ਲਈ ਇਸ ਫ਼ੋਨ ’ਤੇ ਹੀ ਰਹਿਣਗੀਆਂ।';

  @override
  String get action_cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get action_close => 'ਬੰਦ ਕਰੋ';

  @override
  String get action_copy => 'ਕਾਪੀ ਕਰੋ';

  @override
  String get action_signOut => 'ਸਾਈਨ ਆਉਟ ਕਰੋ';

  @override
  String get notice_close => 'ਸੁਨੇਹਾ ਬੰਦ ਕਰੋ';

  @override
  String get notice_sessionExpired_title => 'ਸੈਸ਼ਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ';

  @override
  String get notice_sessionExpired_message =>
      'ਤੁਹਾਡੇ ਸੈਸ਼ਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ ਹੈ। ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get notice_connectionFailed_title => 'ਕਨੈਕਸ਼ਨ ਅਸਫ਼ਲ ਰਿਹਾ';

  @override
  String get notice_invalidCredentials_message =>
      'ਈਮੇਲ ਪਤਾ ਜਾਂ ਪਾਸਵਰਡ ਗ਼ਲਤ ਹੈ।';

  @override
  String get notice_emailVerification_title => 'ਈਮੇਲ ਦੀ ਪੁਸ਼ਟੀ ਲੋੜੀਂਦੀ ਹੈ';

  @override
  String get notice_emailVerification_message =>
      'VPN ਡੀਵਾਈਸ ਜੋੜਨ ਤੋਂ ਪਹਿਲਾਂ ਆਪਣੇ ਈਮੇਲ ਪਤੇ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ।';

  @override
  String get notice_rateLimited_title => 'ਬਹੁਤ ਸਾਰੀਆਂ ਕੋਸ਼ਿਸ਼ਾਂ';

  @override
  String get notice_deviceLimit_title => 'ਡੀਵਾਈਸ ਦੀ ਹੱਦ ਪੂਰੀ ਹੋ ਗਈ';

  @override
  String get notice_deviceLimit_message =>
      'ਕੋਈ ਹੋਰ ਡੀਵਾਈਸ ਜੋੜਨ ਤੋਂ ਪਹਿਲਾਂ ਕੋਈ ਮੌਜੂਦਾ ਡੀਵਾਈਸ ਹਟਾਓ।';

  @override
  String get notice_identityRenewal_title => 'VPN ਪਛਾਣ ਨਵਿਆਉਣੀ ਲਾਜ਼ਮੀ ਹੈ';

  @override
  String get notice_identityRenewal_message =>
      'ਇਹ ਪਛਾਣ ਹਟਾ ਦਿੱਤੀ ਗਈ ਸੀ। ਇੱਕ ਨਵੀਂ ਸਥਾਨਕ ਪਛਾਣ ਬਣਾਓ।';

  @override
  String get notice_migrationPending_title => 'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪ੍ਰਕਿਰਿਆ ਜਾਰੀ ਹੈ';

  @override
  String get notice_migrationPending_message =>
      'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪ੍ਰਕਿਰਿਆ ਪਹਿਲਾਂ ਹੀ ਜਾਰੀ ਹੈ।';

  @override
  String get notice_migrationBlocked_title => 'ਟਿਕਾਣਾ ਬਦਲਣਾ ਰੋਕਿਆ ਗਿਆ';

  @override
  String get notice_migrationBlocked_message =>
      'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ ਸਰਵਰ ਵੱਲੋਂ ਦਖ਼ਲ ਦੀ ਲੋੜ ਹੈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ ਜਾਂ ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ।';

  @override
  String get notice_targetUnavailable_title => 'ਸਰਵਰ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get notice_targetUnavailable_message =>
      'ਇਹ ਸਰਵਰ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String get notice_networkUnavailable_title => 'ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get notice_networkUnavailable_message =>
      'ਆਪਣਾ ਕਨੈਕਸ਼ਨ ਜਾਂਚੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get notice_permissionDenied_title => 'VPN ਇਜਾਜ਼ਤ ਨਹੀਂ ਦਿੱਤੀ ਗਈ';

  @override
  String get notice_permissionDenied_message =>
      'ਕਨੈਕਸ਼ਨ ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ ਅਤੇ Android ਦੀ ਇਜਾਜ਼ਤ ਬੇਨਤੀ ਸਵੀਕਾਰ ਕਰੋ।';

  @override
  String get notice_wireguardTimeout_title => 'ਸਰਵਰ ਜਵਾਬ ਨਹੀਂ ਦੇ ਰਿਹਾ';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard ਕਨੈਕਸ਼ਨ ਨੂੰ ਬਹੁਤ ਸਮਾਂ ਲੱਗ ਗਿਆ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ ਜਾਂ ਕੋਈ ਹੋਰ ਟਿਕਾਣਾ ਚੁਣੋ।';

  @override
  String get notice_tlsFailed_title => 'ਸੁਰੱਖਿਅਤ ਕਨੈਕਸ਼ਨ ਅਸਵੀਕਾਰ ਕੀਤਾ ਗਿਆ';

  @override
  String get notice_tlsFailed_message =>
      'ਸਰਵਰ ਨੇ OpenVPN ਕਨੈਕਸ਼ਨ ਸਵੀਕਾਰ ਨਹੀਂ ਕੀਤਾ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ। ਜੇ ਸਮੱਸਿਆ ਬਣੀ ਰਹੇ, ਤਾਂ ਡਾਇਗਨੌਸਟਿਕ ਚਲਾਓ।';

  @override
  String get notice_tunRejected_title => 'Android ਨੇ VPN ਇੰਟਰਫ਼ੇਸ ਰੱਦ ਕੀਤਾ';

  @override
  String get notice_tunRejected_message =>
      'Android ਨੇ OpenVPN ਵੱਲੋਂ ਮੰਗੀ ਗਈ ਨੈੱਟਵਰਕ ਸੰਰਚਨਾ ਰੱਦ ਕਰ ਦਿੱਤੀ।';

  @override
  String get notice_openvpnStart_title => 'OpenVPN ਸ਼ੁਰੂ ਨਹੀਂ ਹੋ ਸਕਿਆ';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN ਇੰਜਣ ਪੂਰੀ ਤਰ੍ਹਾਂ ਸ਼ੁਰੂ ਨਹੀਂ ਹੋ ਸਕਿਆ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ। ਜੇ ਸਮੱਸਿਆ ਬਣੀ ਰਹੇ, ਤਾਂ ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ।';

  @override
  String notice_diagnosticCode(Object code) {
    return 'ਡਾਇਗਨੌਸਟਿਕ ਕੋਡ: $code';
  }

  @override
  String get notice_generic_title => 'VPN ਕਨੈਕਸ਼ਨ ਅਸਫ਼ਲ ਰਿਹਾ';

  @override
  String get notice_generic_message =>
      'ਕੋਈ ਗ਼ਲਤੀ ਹੋ ਗਈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'ਖਾਤਾ ਬਣਾਇਆ ਗਿਆ',
      'password_reset_sent': 'ਪਾਸਵਰਡ ਰੀਸੈੱਟ ਬੇਨਤੀ ਮਿਲ ਗਈ',
      'verification_email_sent': 'ਪੁਸ਼ਟੀ ਈਮੇਲ ਭੇਜੀ ਗਈ',
      'location_migration_pending': 'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪ੍ਰਕਿਰਿਆ ਜਾਰੀ ਹੈ',
      'vpn_sign_in_required': 'ਸਾਈਨ ਇਨ ਲੋੜੀਂਦਾ ਹੈ',
      'protocol_unavailable_at_location': 'ਪ੍ਰੋਟੋਕੋਲ ਉਪਲਬਧ ਨਹੀਂ',
      'vpn_permission_denied': 'VPN ਇਜਾਜ਼ਤ ਨਹੀਂ ਦਿੱਤੀ ਗਈ',
      'revoked_identity_device_limit': 'ਡੀਵਾਈਸ ਦੀ ਹੱਦ ਪੂਰੀ ਹੋ ਗਈ',
      'tunnel_start_unexpected': 'VPN ਸ਼ੁਰੂ ਨਹੀਂ ਹੋ ਸਕਿਆ',
      'flutter_disconnect_timeout': 'ਡਿਸਕਨੈਕਸ਼ਨ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ',
      'flutter_disconnect_unexpected': 'ਡਿਸਕਨੈਕਟ ਨਹੀਂ ਹੋ ਸਕਿਆ',
      'device_revoked': 'ਡੀਵਾਈਸ ਹਟਾਇਆ ਗਿਆ',
      'revoke_unexpected': 'ਡੀਵਾਈਸ ਹਟਾਇਆ ਨਹੀਂ ਜਾ ਸਕਿਆ',
      'identity_renewal_unexpected': 'ਪਛਾਣ ਨਵਿਆਈ ਨਹੀਂ ਜਾ ਸਕੀ',
      'openvpn_renewal_unexpected': 'OpenVPN ਨਵਿਆਇਆ ਨਹੀਂ ਜਾ ਸਕਿਆ',
      'location_migration_blocked': 'ਟਿਕਾਣਾ ਬਦਲਣਾ ਰੋਕਿਆ ਗਿਆ',
      'location_migration_slow': 'ਟਿਕਾਣਾ ਬਦਲਣਾ ਅਜੇ ਵੀ ਜਾਰੀ ਹੈ',
      'location_migration_conflict': 'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ ਤਾਜ਼ਾ ਕਰਨਾ ਲੋੜੀਂਦਾ ਹੈ',
      'location_migration_verification_failed':
          'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ',
      'location_migration_device_changed': 'ਟਿਕਾਣਾ ਬਦਲਣ ਦੌਰਾਨ ਡੀਵਾਈਸ ਬਦਲ ਗਿਆ',
      'tunnel_stop_failed': 'ਟਿਕਾਣਾ ਬਦਲਣਾ ਉਪਲਬਧ ਨਹੀਂ',
      'device_clock_ahead': 'ਡੀਵਾਈਸ ਦੀ ਘੜੀ ਅੱਗੇ ਹੈ',
      'other': 'ਕਾਰਵਾਈ ਅਸਫ਼ਲ ਰਹੀ',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'ਖਾਤਾ ਬਣਾਇਆ ਗਿਆ ਹੈ, ਪਰ ਪੁਸ਼ਟੀ ਈਮੇਲ ਭੇਜੀ ਨਹੀਂ ਜਾ ਸਕੀ। ਐਪ ਵਿੱਚ “ਈਮੇਲ ਮੁੜ ਭੇਜੋ” ਵਰਤੋ।',
      'password_reset_sent':
          'ਤੁਹਾਡੀ ਬੇਨਤੀ ਮਿਲ ਗਈ ਹੈ। ਜੇ ਇਸ ਪਤੇ ਨਾਲ ਕੋਈ ਖਾਤਾ ਮੇਲ ਖਾਂਦਾ ਹੈ, ਤਾਂ ਤੁਹਾਨੂੰ ਇੱਕ ਈਮੇਲ ਮਿਲ ਸਕਦੀ ਹੈ। ਕਿਰਪਾ ਕਰਕੇ ਆਪਣਾ ਸਪੈਮ ਫ਼ੋਲਡਰ ਵੀ ਦੇਖੋ।',
      'verification_email_sent': 'ਇੱਕ ਨਵੀਂ ਪੁਸ਼ਟੀ ਈਮੇਲ ਹੁਣੇ ਭੇਜੀ ਗਈ ਹੈ।',
      'location_migration_pending':
          '$target ਵੱਲ ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਤਿਆਰੀ ਅਜੇ ਜਾਰੀ ਹੈ। ਤੁਸੀਂ ਡੀਵਾਈਸ ਦੁਬਾਰਾ ਬਣਾਏ ਬਿਨਾਂ ਇਸ ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰ ਸਕਦੇ ਹੋ।',
      'vpn_sign_in_required':
          'VPN ਸ਼ੁਰੂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਆਪਣੇ ਖਾਤੇ ਵਿੱਚ ਸਾਈਨ ਇਨ ਕਰੋ।',
      'protocol_unavailable_at_location':
          'ਚੁਣਿਆ ਗਿਆ ਪ੍ਰੋਟੋਕੋਲ ਇਸ ਟਿਕਾਣੇ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਟਿਕਾਣੇ ਤਾਜ਼ਾ ਕਰੋ ਜਾਂ ਕੋਈ ਹੋਰ ਪ੍ਰੋਟੋਕੋਲ ਚੁਣੋ।',
      'vpn_permission_denied':
          'Android ਨੇ VPN ਇਜਾਜ਼ਤ ਦੇਣ ਤੋਂ ਇਨਕਾਰ ਕਰ ਦਿੱਤਾ। ਕਨੈਕਸ਼ਨ ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ ਅਤੇ ਸਿਸਟਮ ਦੀ ਬੇਨਤੀ ਸਵੀਕਾਰ ਕਰੋ।',
      'revoked_identity_device_limit':
          'ਇਸ ਡੀਵਾਈਸ ਦੀ VPN ਪਹੁੰਚ ਹਟਾ ਦਿੱਤੀ ਗਈ ਹੈ ਅਤੇ ਡੀਵਾਈਸ ਦੀ ਹੱਦ ਪੂਰੀ ਹੋ ਚੁੱਕੀ ਹੈ। “ਖਾਤਾ” → “ਮੇਰੇ ਡੀਵਾਈਸ ਪ੍ਰਬੰਧਿਤ ਕਰੋ” ਵਿੱਚ ਜਾ ਕੇ ਕੋਈ ਡੀਵਾਈਸ ਹਟਾਓ।',
      'tunnel_start_unexpected':
          'ਇੱਕ ਅਣਕਿਆਸੀ ਗ਼ਲਤੀ ਨੇ ਟਨਲ ਤਿਆਰ ਕਰਨ ਵਿੱਚ ਰੁਕਾਵਟ ਪਾਈ। ਡਾਇਗਨੌਸਟਿਕ ਕੋਡ ਜਾਂਚੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'flutter_disconnect_timeout':
          'Android ਨੇ ਸਮੇਂ ਸਿਰ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ ਕਿ VPN ਬੰਦ ਹੋ ਗਿਆ ਹੈ। ਇਸ ਨੂੰ ਮੁੜ ਬੰਦ ਕਰਨ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'flutter_disconnect_unexpected':
          'ਇੱਕ ਅਣਕਿਆਸੀ ਗ਼ਲਤੀ ਕਾਰਨ ਟਨਲ ਦੇ ਬੰਦ ਹੋਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ।',
      'device_revoked':
          'ਡੀਵਾਈਸ ਦੀ VPN ਪਹੁੰਚ ਰੱਦ ਕਰ ਦਿੱਤੀ ਗਈ ਹੈ ਅਤੇ ਇਸ ਦੀ ਸਥਾਨਕ ਗੁਪਤ ਜਾਣਕਾਰੀ ਹਟਾ ਦਿੱਤੀ ਗਈ ਹੈ।',
      'revoke_unexpected':
          'ਡੀਵਾਈਸ ਹਟਾਇਆ ਨਹੀਂ ਜਾ ਸਕਿਆ। ਸੂਚੀ ਤਾਜ਼ੀ ਕਰੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'identity_renewal_unexpected':
          'ਨਵੀਂ VPN ਪਛਾਣ ਨਹੀਂ ਬਣਾਈ ਜਾ ਸਕੀ। ਡੀਵਾਈਸ ਤਾਜ਼ਾ ਕਰੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_renewal_unexpected':
          'OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਨਵਿਆਇਆ ਨਹੀਂ ਜਾ ਸਕਿਆ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ ਜਾਂ ਡਾਇਗਨੌਸਟਿਕ ਕੋਡ ਜਾਂਚੋ।',
      'location_migration_blocked':
          'ਸਰਵਰ ਇਸ ਵੇਲੇ ਟਿਕਾਣਾ ਬਦਲਣਾ ਪੂਰਾ ਨਹੀਂ ਕਰ ਸਕਦਾ। ਡੀਵਾਈਸ ਅਤੇ ਇਸ ਦੀ ਸਥਾਨਕ ਪਛਾਣ ਸੰਭਾਲ ਕੇ ਰੱਖੀ ਗਈ ਹੈ।',
      'location_migration_slow':
          'ਸਰਵਰ ਅਜੇ ਵੀ $target ਵੱਲ ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਤਿਆਰੀ ਕਰ ਰਿਹਾ ਹੈ। ਕੁਝ ਦੇਰ ਬਾਅਦ “ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ” ਵਰਤੋ।',
      'location_migration_conflict':
          'ਸਰਵਰ ’ਤੇ ਡੀਵਾਈਸ ਦੀ ਸਥਿਤੀ ਬਦਲ ਗਈ ਹੈ। ਡੀਵਾਈਸ ਤਾਜ਼ਾ ਕਰੋ, ਫਿਰ ਟਿਕਾਣਾ ਬਦਲਣਾ ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ।',
      'location_migration_verification_failed':
          'ਸਰਵਰ ਨੇ ਨਵੇਂ ਟਿਕਾਣੇ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ। ਪਿਛਲੀ ਸਥਾਨਕ ਪਛਾਣ ਸੰਭਾਲ ਕੇ ਰੱਖੀ ਗਈ ਹੈ।',
      'location_migration_device_changed':
          'ਸਰਵਰ ਵੱਲੋਂ ਮਿਲਿਆ ਡੀਵਾਈਸ ਹੁਣ ਉਸ ਨਾਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦਾ ਜੋ ਬਦਲਿਆ ਜਾ ਰਿਹਾ ਸੀ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਡੀਵਾਈਸ ਤਾਜ਼ਾ ਕਰੋ।',
      'tunnel_stop_failed':
          'ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਪਿਛਲੀ ਟਨਲ ਪੂਰੀ ਤਰ੍ਹਾਂ ਬੰਦ ਹੋਣੀ ਚਾਹੀਦੀ ਹੈ।',
      'device_clock_ahead':
          'ਇਸ ਡੀਵਾਈਸ ਦੀ ਘੜੀ ਅੱਗੇ ਲੱਗਦੀ ਹੈ। ਸਾਈਨ ਇਨ ਰਹਿਣ ਲਈ ਆਟੋਮੈਟਿਕ ਤਾਰੀਖ਼ ਅਤੇ ਸਮਾਂ ਚਾਲੂ ਕਰੋ।',
      'other':
          'ਕਾਰਵਾਈ ਪੂਰੀ ਨਹੀਂ ਹੋ ਸਕੀ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ ਜਾਂ ਡਾਇਗਨੌਸਟਿਕ ਕੋਡ ਸਹਾਇਤਾ ਨੂੰ ਭੇਜੋ।',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ਸੈਸ਼ਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ',
      'invalid_credentials': 'ਸਾਈਨ ਇਨ ਨਹੀਂ ਹੋ ਸਕਿਆ',
      'email_verification_required': 'ਈਮੇਲ ਦੀ ਪੁਸ਼ਟੀ ਲੋੜੀਂਦੀ ਹੈ',
      'verification_email_cooldown': 'ਈਮੇਲ ਪਹਿਲਾਂ ਹੀ ਭੇਜੀ ਗਈ',
      'rate_limited': 'ਬਹੁਤ ਸਾਰੀਆਂ ਕੋਸ਼ਿਸ਼ਾਂ',
      'invalid_registration': 'ਜਾਣਕਾਰੀ ਠੀਕ ਕਰਨੀ ਲਾਜ਼ਮੀ ਹੈ',
      'email_exists': 'ਖਾਤਾ ਪਹਿਲਾਂ ਹੀ ਮੌਜੂਦ ਹੈ',
      'invalid_profile': 'ਅਵੈਧ ਪ੍ਰੋਫ਼ਾਈਲ',
      'invalid_device': 'ਅਵੈਧ ਡੀਵਾਈਸ',
      'invalid_location': 'ਟਿਕਾਣਾ ਉਪਲਬਧ ਨਹੀਂ',
      'device_limit': 'ਡੀਵਾਈਸ ਦੀ ਹੱਦ ਪੂਰੀ ਹੋ ਗਈ',
      'device_exists': 'VPN ਪਛਾਣ ਪਹਿਲਾਂ ਹੀ ਵਰਤੋਂ ਵਿੱਚ ਹੈ',
      'device_identity_revoked': 'VPN ਪਛਾਣ ਨਵਿਆਉਣੀ ਲਾਜ਼ਮੀ ਹੈ',
      'device_location_locked': 'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ ਤਾਜ਼ਾ ਕਰਨਾ ਲੋੜੀਂਦਾ ਹੈ',
      'location_migration_pending': 'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪ੍ਰਕਿਰਿਆ ਜਾਰੀ ਹੈ',
      'location_migration_blocked': 'ਟਿਕਾਣਾ ਬਦਲਣਾ ਰੋਕਿਆ ਗਿਆ',
      'target_ca_mismatch': 'OpenVPN ਸਰਵਰ ਅਨੁਕੂਲ ਨਹੀਂ',
      'location_migration_conflict': 'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ ਤਾਜ਼ਾ ਕਰਨਾ ਲੋੜੀਂਦਾ ਹੈ',
      'server_full': 'ਸਰਵਰ ਭਰ ਚੁੱਕਾ ਹੈ',
      'capacity_unavailable': 'ਟਿਕਾਣਾ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ',
      'target_unavailable': 'ਸਰਵਰ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ',
      'not_found': 'ਚੀਜ਼ ਨਹੀਂ ਮਿਲੀ',
      'invalid_openvpn_csr': 'ਅਵੈਧ OpenVPN ਪਛਾਣ',
      'openvpn_profile_exists': 'OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਪਹਿਲਾਂ ਹੀ ਮੌਜੂਦ ਹੈ',
      'openvpn_profile_revoked': 'OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਰੱਦ ਹੋ ਗਈ',
      'openvpn_operation_pending': 'OpenVPN ਕਾਰਵਾਈ ਜਾਰੀ ਹੈ',
      'openvpn_operation_terminal': 'OpenVPN ਕਾਰਵਾਈ ਰੁਕ ਗਈ',
      'openvpn_address_unavailable': 'OpenVPN ਪਤਾ ਉਪਲਬਧ ਨਹੀਂ',
      'openvpn_profile_conflict': 'OpenVPN ਵਿੱਚ ਟਕਰਾਅ',
      'openvpn_signer_unavailable': 'OpenVPN ਉਪਲਬਧ ਨਹੀਂ',
      'email_delivery_unavailable': 'ਈਮੇਲ ਉਪਲਬਧ ਨਹੀਂ',
      'invalid_token': 'ਅਵੈਧ ਲਿੰਕ',
      'network_unavailable': 'ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਉਪਲਬਧ ਨਹੀਂ',
      'invalid_json': 'ਅਵੈਧ ਬੇਨਤੀ',
      'invalid_api_response': 'ਅਵੈਧ ਸਰਵਰ ਜਵਾਬ',
      'ipv6_unavailable': 'IPv6 ਉਪਲਬਧ ਨਹੀਂ',
      'invalid_ip_families': 'ਨੈੱਟਵਰਕ ਸੰਰਚਨਾ ਰੱਦ ਹੋਈ',
      'other': 'ਸੇਵਾ ਉਪਲਬਧ ਨਹੀਂ',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ਤੁਹਾਡੇ ਸੈਸ਼ਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ ਹੈ। ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰੋ।',
      'invalid_credentials': 'ਈਮੇਲ ਪਤਾ ਜਾਂ ਪਾਸਵਰਡ ਗ਼ਲਤ ਹੈ।',
      'email_verification_required':
          'VPN ਡੀਵਾਈਸ ਜੋੜਨ ਤੋਂ ਪਹਿਲਾਂ ਆਪਣੇ ਈਮੇਲ ਪਤੇ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ।',
      'invalid_registration': 'ਮੰਗੀ ਗਈ ਜਾਣਕਾਰੀ ਅਤੇ ਸਹਿਮਤੀਆਂ ਦੀ ਜਾਂਚ ਕਰੋ।',
      'email_exists': 'ਇਸ ਈਮੇਲ ਪਤੇ ਨਾਲ ਪਹਿਲਾਂ ਹੀ ਇੱਕ ਖਾਤਾ ਹੈ।',
      'invalid_profile': 'ਆਪਣੀ ਪ੍ਰੋਫ਼ਾਈਲ ਦੀ ਜਾਣਕਾਰੀ ਦੀ ਜਾਂਚ ਕਰੋ।',
      'invalid_device': 'ਇਸ ਡੀਵਾਈਸ ਦਾ ਨਾਮ ਜਾਂ ਸਥਾਨਕ ਪਛਾਣ ਅਵੈਧ ਹੈ।',
      'invalid_location': 'ਟਿਕਾਣਿਆਂ ਦੀ ਸੂਚੀ ਤਾਜ਼ਾ ਕਰੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'device_limit': 'ਕੋਈ ਹੋਰ ਡੀਵਾਈਸ ਜੋੜਨ ਤੋਂ ਪਹਿਲਾਂ ਮੌਜੂਦਾ ਡੀਵਾਈਸ ਹਟਾਓ।',
      'device_exists': 'ਇਹ VPN ਪਛਾਣ ਪਹਿਲਾਂ ਹੀ ਕਿਸੇ ਹੋਰ ਖਾਤੇ ਨਾਲ ਜੁੜੀ ਹੋਈ ਹੈ।',
      'device_identity_revoked':
          'ਇਹ ਪਛਾਣ ਹਟਾ ਦਿੱਤੀ ਗਈ ਸੀ। ਨਵੀਂ ਸਥਾਨਕ ਪਛਾਣ ਬਣਾਉਣੀ ਪਵੇਗੀ।',
      'device_location_locked':
          'ਇਸ ਡੀਵਾਈਸ ਦਾ ਟਿਕਾਣਾ ਹੁਣੇ ਬਦਲਿਆ ਹੈ। ਐਪ ਚੱਲ ਰਹੀ ਤਬਦੀਲੀ ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰੇਗੀ।',
      'location_migration_pending':
          'ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਪ੍ਰਕਿਰਿਆ ਪਹਿਲਾਂ ਹੀ ਜਾਰੀ ਹੈ।',
      'location_migration_blocked':
          'ਟਿਕਾਣਾ ਬਦਲਣ ਲਈ ਸਰਵਰ ਵੱਲੋਂ ਦਖ਼ਲ ਦੀ ਲੋੜ ਹੈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ ਜਾਂ ਸਹਾਇਤਾ ਨਾਲ ਸੰਪਰਕ ਕਰੋ।',
      'target_ca_mismatch':
          'ਇਹ ਸਰਵਰ ਅਜੇ ਮੌਜੂਦਾ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਦੇ ਅਨੁਕੂਲ ਨਹੀਂ ਹੈ।',
      'location_migration_conflict':
          'ਡੀਵਾਈਸ ਤਾਜ਼ਾ ਕਰੋ, ਫਿਰ ਟਿਕਾਣਾ ਬਦਲਣ ਦੀ ਕੋਸ਼ਿਸ਼ ਮੁੜ ਕਰੋ।',
      'server_full':
          'ਇਸ ਟਿਕਾਣੇ ’ਤੇ ਕਨੈਕਸ਼ਨਾਂ ਦੀ ਹੱਦ ਪੂਰੀ ਹੋ ਚੁੱਕੀ ਹੈ। ਕੋਈ ਹੋਰ ਟਿਕਾਣਾ ਚੁਣੋ ਜਾਂ ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'capacity_unavailable':
          'ਇਸ ਵੇਲੇ ਅਸੀਂ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕਰ ਸਕਦੇ ਕਿ ਇਹ ਟਿਕਾਣਾ ਉਪਲਬਧ ਹੈ ਜਾਂ ਨਹੀਂ। ਕੋਈ ਹੋਰ ਟਿਕਾਣਾ ਚੁਣੋ ਜਾਂ ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'target_unavailable': 'ਇਹ ਸਰਵਰ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'not_found': 'ਇਹ ਚੀਜ਼ ਹੁਣ ਤੁਹਾਡੇ ਖਾਤੇ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'invalid_openvpn_csr': 'ਨਵੀਂ OpenVPN ਪਛਾਣ ਬਣਾਓ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_profile_exists':
          'ਇਸ ਡੀਵਾਈਸ ਲਈ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਪਹਿਲਾਂ ਹੀ ਮੌਜੂਦ ਹੈ।',
      'openvpn_profile_revoked': 'ਜਾਰੀ ਰੱਖਣ ਲਈ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਨਵਿਆਓ।',
      'openvpn_operation_pending':
          'ਤਬਦੀਲੀ ਅਜੇ ਲਾਗੂ ਹੋ ਰਹੀ ਹੈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_operation_terminal':
          'ਨਵੀਂ OpenVPN ਪਛਾਣ ਬਣਾਓ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_address_unavailable': 'ਇਸ ਵੇਲੇ ਕੋਈ OpenVPN ਪਤਾ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'openvpn_profile_conflict':
          'ਪ੍ਰੋਫ਼ਾਈਲ ਬਦਲ ਗਈ ਹੈ। ਡੀਵਾਈਸ ਤਾਜ਼ਾ ਕਰੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_signer_unavailable': 'OpenVPN ਸੇਵਾ ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'email_delivery_unavailable':
          'ਈਮੇਲ ਭੇਜੀ ਨਹੀਂ ਜਾ ਸਕੀ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'invalid_token':
          'ਇਹ ਲਿੰਕ ਅਵੈਧ ਹੈ ਜਾਂ ਇਸ ਦੀ ਮਿਆਦ ਪੁੱਗ ਚੁੱਕੀ ਹੈ। ਨਵਾਂ ਲਿੰਕ ਮੰਗੋ।',
      'network_unavailable':
          'ਆਪਣੇ ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਦੀ ਜਾਂਚ ਕਰੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'invalid_json': 'ਦਰਜ ਕੀਤੀ ਜਾਣਕਾਰੀ ਦੀ ਜਾਂਚ ਕਰੋ ਅਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'invalid_api_response':
          'ਸਰਵਰ ਨੇ ਅਣਕਿਆਸਿਆ ਜਵਾਬ ਦਿੱਤਾ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'ipv6_unavailable':
          'ਸਰਵਰ ਇਸ ਵੇਲੇ IPv6 ਚਾਲੂ ਨਹੀਂ ਕਰ ਸਕਦਾ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'invalid_ip_families':
          'ਟਨਲ ਸੰਰਚਨਾ ਅਧੂਰੀ ਹੈ ਜਾਂ ਮਨਜ਼ੂਰ ਪਤਿਆਂ ਨਾਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦੀ। ਐਪ ਤੋਂ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'other': 'ਸਰਵਰ ’ਤੇ ਗ਼ਲਤੀ ਹੋ ਗਈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'ਕੁਝ ਪਲਾਂ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds ਸਕਿੰਟਾਂ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      one: '$seconds ਸਕਿੰਟ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes ਮਿੰਟਾਂ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      one: '$minutes ਮਿੰਟ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ਘੰਟਿਆਂ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      one: '$hours ਘੰਟੇ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'ਸਿਸਟਮ VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਉਪਲਬਧ ਨਹੀਂ',
      'system_vpn_resume_corrupt': 'ਅਵੈਧ ਸਿਸਟਮ VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ',
      'system_vpn_resume_session_invalid': 'ਅਵੈਧ VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਸੈਸ਼ਨ',
      'system_vpn_resume_identity_changed': 'VPN ਪਛਾਣ ਬਦਲ ਗਈ',
      'system_vpn_resume_identity_invalid': 'ਅਵੈਧ VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਪਛਾਣ',
      'system_vpn_resume_storage_failed': 'VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਸਟੋਰੇਜ ਉਪਲਬਧ ਨਹੀਂ',
      'system_vpn_resume_network_timeout':
          'VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਲਈ ਨੈੱਟਵਰਕ ਨਹੀਂ ਮਿਲਿਆ',
      'system_vpn_resume_blocked': 'VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਬਲਾਕ ਹੈ',
      'system_vpn_resume_failed': 'VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਅਸਫ਼ਲ',
      'system_vpn_resume_error_invalid': 'ਅਵੈਧ VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਗ਼ਲਤੀ',
      'wireguard_identity_store_failed': 'WireGuard ਪਛਾਣ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋਈ',
      'wireguard_identity_unavailable': 'WireGuard ਪਛਾਣ ਉਪਲਬਧ ਨਹੀਂ',
      'vpn_host_destroyed': 'Android VPN ਹੋਸਟ ਬੰਦ ਹੋਇਆ',
      'vpn_host_unavailable': 'Android VPN ਹੋਸਟ ਉਪਲਬਧ ਨਹੀਂ',
      'vpn_permission_required': 'VPN ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੈ',
      'vpn_permission_denied': 'VPN ਇਜਾਜ਼ਤ ਨਹੀਂ ਦਿੱਤੀ ਗਈ',
      'vpn_permission_request_failed': 'ਇਜਾਜ਼ਤ ਮੰਗੀ ਨਹੀਂ ਜਾ ਸਕੀ',
      'wireguard_foreground_service_unavailable': 'WireGuard ਸੇਵਾ ਉਪਲਬਧ ਨਹੀਂ',
      'wireguard_identity_invalid': 'ਅਵੈਧ ਸਥਾਨਕ WireGuard ਕੁੰਜੀ',
      'wireguard_identity_in_use': 'WireGuard ਪਛਾਣ ਪਹਿਲਾਂ ਹੀ ਵਰਤੋਂ ਵਿੱਚ ਹੈ',
      'wireguard_configuration_invalid': 'ਅਵੈਧ WireGuard ਸੰਰਚਨਾ',
      'wireguard_operation_pending': 'WireGuard ਕਾਰਵਾਈ ਅਜੇ ਸਰਗਰਮ ਹੈ',
      'wireguard_start_failed': 'WireGuard ਸ਼ੁਰੂ ਹੋਣਾ ਰੱਦ ਹੋਇਆ',
      'wireguard_stop_timeout': 'WireGuard ਬੰਦ ਹੋਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ',
      'wireguard_handshake_timeout': 'WireGuard ਨੇ ਜਵਾਬ ਨਹੀਂ ਦਿੱਤਾ',
      'openvpn_connection_timeout': 'OpenVPN ਨੇ ਜਵਾਬ ਨਹੀਂ ਦਿੱਤਾ',
      'openvpn_core_unavailable': 'OpenVPN ਇੰਜਣ ਉਪਲਬਧ ਨਹੀਂ',
      'openvpn_operation_pending': 'OpenVPN ਸੈਸ਼ਨ ਅਜੇ ਸਰਗਰਮ ਹੈ',
      'openvpn_stop_timeout': 'OpenVPN ਬੰਦ ਹੋਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ',
      'openvpn_profile_unavailable': 'ਸਥਾਨਕ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਗੁੰਮ ਹੈ',
      'openvpn_native_failed': 'ਨੇਟਿਵ OpenVPN ਕਾਲ ਰੁਕ ਗਈ',
      'openvpn_key_generation_failed': 'OpenVPN P-256 ਕੁੰਜੀ ਨਹੀਂ ਬਣ ਸਕੀ',
      'openvpn_csr_generation_failed': 'OpenVPN CSR ਨਹੀਂ ਬਣ ਸਕੀ',
      'openvpn_identity_store_failed': 'OpenVPN ਪਛਾਣ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋਈ',
      'openvpn_identity_clear_failed': 'OpenVPN ਹਟਾਉਣਾ ਅਧੂਰਾ',
      'openvpn_identity_in_use': 'OpenVPN ਪਛਾਣ ਅਜੇ ਵਰਤੋਂ ਵਿੱਚ ਹੈ',
      'openvpn_tls_verification_required': 'OpenVPN TLS ਪੁਸ਼ਟੀ ਗੁੰਮ',
      'openvpn_cipher_invalid': 'ਅਵੈਧ OpenVPN ਸਾਈਫ਼ਰ',
      'openvpn_profile_rejected': 'OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਰੱਦ ਹੋਈ',
      'openvpn_identity_inconsistent': 'OpenVPN ਪਛਾਣ ਮੇਲ ਨਹੀਂ ਖਾਂਦੀ',
      'tls_handshake_failed': 'OpenVPN ਗੱਲਬਾਤ ਰੱਦ ਹੋਈ',
      'tls_alert_unknown_ca': 'OpenVPN ਕਲਾਇੰਟ ਸਰਟੀਫ਼ਿਕੇਟ ਪਛਾਣਿਆ ਨਹੀਂ ਗਿਆ',
      'tls_alert_bad_certificate': 'OpenVPN ਕਲਾਇੰਟ ਸਰਟੀਫ਼ਿਕੇਟ ਰੱਦ ਹੋਇਆ',
      'tls_alert_unsupported_certificate': 'ਅਸਮਰਥਿਤ OpenVPN ਸਰਟੀਫ਼ਿਕੇਟ',
      'tls_client_certificate_required': 'OpenVPN ਕਲਾਇੰਟ ਸਰਟੀਫ਼ਿਕੇਟ ਦੀ ਲੋੜ ਹੈ',
      'tls_alert_misc': 'OpenVPN TLS ਚੇਤਾਵਨੀ',
      'tls_signature_algorithm_rejected': 'ਅਸਮਰਥਿਤ OpenVPN ਦਸਤਖ਼ਤ',
      'tls_handshake_rejected': 'OpenVPN TLS ਗੱਲਬਾਤ ਰੱਦ ਹੋਈ',
      'tls_version_rejected': 'OpenVPN TLS ਵਰਜਨ ਅਨੁਕੂਲ ਨਹੀਂ',
      'tls_certificate_expired': 'TLS ਸਰਟੀਫ਼ਿਕੇਟ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ',
      'tls_certificate_revoked': 'TLS ਸਰਟੀਫ਼ਿਕੇਟ ਰੱਦ ਕੀਤਾ ਗਿਆ',
      'transport_failed': 'OpenVPN ਸਰਵਰ ਤੱਕ ਪਹੁੰਚ ਨਹੀਂ',
      'tun_configuration_rejected': 'OpenVPN ਇੰਟਰਫ਼ੇਸ ਨਹੀਂ ਬਣ ਸਕਿਆ',
      'tun_setup_failed': 'OpenVPN TUN ਸੈੱਟਅੱਪ ਅਸਫ਼ਲ',
      'tun_interface_create_failed': 'OpenVPN ਇੰਟਰਫ਼ੇਸ ਬਣਾਉਣਾ ਅਸਫ਼ਲ',
      'tun_interface_disabled': 'OpenVPN ਇੰਟਰਫ਼ੇਸ ਬੰਦ ਕੀਤਾ ਗਿਆ',
      'tun_halted': 'OpenVPN ਇੰਟਰਫ਼ੇਸ ਵਿੱਚ ਵਿਘਨ ਪਿਆ',
      'tun_already_established': 'OpenVPN ਇੰਟਰਫ਼ੇਸ ਪਹਿਲਾਂ ਹੀ ਖੁੱਲ੍ਹਾ ਹੈ',
      'tun_addresses_missing': 'OpenVPN ਪਤਾ ਗੁੰਮ',
      'tun_routes_missing': 'OpenVPN ਰੂਟ ਗੁੰਮ',
      'tun_dns_missing': 'OpenVPN DNS ਗੁੰਮ',
      'tun_permission_revoked': 'VPN ਇਜਾਜ਼ਤ ਰੱਦ ਕੀਤੀ ਗਈ',
      'tun_establish_returned_null': 'Android ਨੇ VPN ਇੰਟਰਫ਼ੇਸ ਰੱਦ ਕੀਤਾ',
      'openvpn_service_start_failed': 'OpenVPN ਸੇਵਾ ਉਪਲਬਧ ਨਹੀਂ',
      'openvpn_operation_timeout': 'OpenVPN ਕਾਲ ਦਾ ਸਮਾਂ ਖ਼ਤਮ',
      'openvpn_start_failed': 'OpenVPN ਸ਼ੁਰੂ ਹੋਣਾ ਰੱਦ ਹੋਇਆ',
      'openvpn_connection_failed': 'OpenVPN ਕਨੈਕਸ਼ਨ ਵਿੱਚ ਵਿਘਨ ਪਿਆ',
      'openvpn_core_status_error': 'OpenVPN ਕੋਰ ਗ਼ਲਤੀ ਨਾਲ ਖ਼ਤਮ ਹੋਇਆ',
      'openvpn_stopped_before_connected':
          'ਕਨੈਕਟ ਹੋਣ ਤੋਂ ਪਹਿਲਾਂ OpenVPN ਬੰਦ ਹੋਇਆ',
      'openvpn_auth_failed': 'OpenVPN ਪ੍ਰਮਾਣਿਕਤਾ ਰੱਦ ਹੋਈ',
      'openvpn_client_setup_failed': 'OpenVPN ਕਲਾਇੰਟ ਸੈੱਟਅੱਪ ਅਸਫ਼ਲ',
      'openvpn_client_halted': 'OpenVPN ਕਲਾਇੰਟ ਵਿੱਚ ਵਿਘਨ ਪਿਆ',
      'openvpn_client_restart': 'OpenVPN ਮੁੜ ਚਾਲੂ ਕਰਨ ਦੀ ਬੇਨਤੀ',
      'openvpn_inactive_timeout': 'OpenVPN ਬਹੁਤ ਦੇਰ ਤੱਕ ਸਰਗਰਮ ਨਹੀਂ ਰਿਹਾ',
      'openvpn_session_expired': 'OpenVPN ਸੈਸ਼ਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ',
      'openvpn_credentials_required': 'ਅਸਮਰਥਿਤ OpenVPN ਪ੍ਰਮਾਣਿਕਤਾ',
      'openvpn_proxy_failed': 'OpenVPN ਪ੍ਰੌਕਸੀ ਅਸਫ਼ਲ',
      'openvpn_compression_failed': 'OpenVPN ਕੰਪਰੈਸ਼ਨ ਰੱਦ ਹੋਈ',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM ਇਨਕ੍ਰਿਪਸ਼ਨ ਉਪਲਬਧ ਨਹੀਂ',
      'openvpn_feature_unsupported': 'ਅਸਮਰਥਿਤ OpenVPN ਫ਼ੀਚਰ',
      'network_unavailable': 'ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਉਪਲਬਧ ਨਹੀਂ',
      'network_lost': 'ਨੈੱਟਵਰਕ ਉਪਲਬਧ ਨਹੀਂ',
      'certificate_validation_failed': 'ਸਰਵਰ ਸਰਟੀਫ਼ਿਕੇਟ ਰੱਦ ਹੋਇਆ',
      'openvpn_certificate_expired': 'OpenVPN ਸਰਟੀਫ਼ਿਕੇਟ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ',
      'tunnel_active_for_another_account': 'ਹੋਰ ਖਾਤੇ ਦੀ ਟਨਲ ਅਜੇ ਸਰਗਰਮ ਹੈ',
      'tunnel_already_active': 'ਨੇਟਿਵ ਟਨਲ ਪਹਿਲਾਂ ਹੀ ਸਰਗਰਮ ਹੈ',
      'tunnel_stop_timeout': '$protocol ਬੰਦ ਹੋਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ',
      'tunnel_disconnected': '$protocol ਵਿੱਚ ਵਿਘਨ ਪਿਆ',
      'native_bridge_unavailable': 'Android ਬ੍ਰਿਜ ਉਪਲਬਧ ਨਹੀਂ',
      'native_operation_failed': 'Android ਕਾਰਵਾਈ ਰੁਕ ਗਈ',
      'invalid_arguments': 'ਅਧੂਰੇ VPN ਪੈਰਾਮੀਟਰ',
      'invalid_account_id': 'ਅਵੈਧ VPN ਖਾਤਾ',
      'invalid_device_id': 'ਅਵੈਧ ਡੀਵਾਈਸ ਪਛਾਣਕਰਤਾ',
      'storage_key_not_allowed': 'ਸਟੋਰੇਜ ਕੁੰਜੀ ਰੱਦ ਹੋਈ',
      'secure_storage_read_failed': 'ਸੁਰੱਖਿਅਤ ਪੜ੍ਹਨਾ ਅਸਫ਼ਲ',
      'secure_storage_write_failed': 'ਸੁਰੱਖਿਅਤ ਲਿਖਣਾ ਅਸਫ਼ਲ',
      'key_generation_failed': 'WireGuard ਕੁੰਜੀ ਨਹੀਂ ਬਣ ਸਕੀ',
      'csr_generation_failed': 'OpenVPN CSR ਨਹੀਂ ਬਣ ਸਕੀ',
      'openvpn_recovery_exhausted': 'OpenVPN ਬਹਾਲੀ ਪਹਿਲਾਂ ਹੀ ਵਰਤੀ ਗਈ',
      'openvpn_recovery_failed': 'OpenVPN ਬਹਾਲੀ ਅਸਫ਼ਲ',
      'openvpn_renewal_required': 'OpenVPN ਸਰਟੀਫ਼ਿਕੇਟ ਨਵਿਆਉਣਾ ਲੋੜੀਂਦਾ ਹੈ',
      'other': 'ਸ਼੍ਰੇਣੀ ਤੋਂ ਬਾਹਰ ਨੇਟਿਵ VPN ਗ਼ਲਤੀ',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਹੋਣ ਯੋਗ VPN ਸੈਸ਼ਨ ਨਹੀਂ ਮਿਲਿਆ। ਐਪ ਵਿੱਚ ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_corrupt':
          'ਸੁਰੱਖਿਅਤ ਕੀਤਾ ਗਿਆ VPN ਮੁੜ-ਸ਼ੁਰੂਆਤ ਡੇਟਾ ਅਵੈਧ ਹੈ ਅਤੇ ਵਰਤਿਆ ਨਹੀਂ ਜਾਵੇਗਾ। ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_session_invalid':
          'ਸੁਰੱਖਿਅਤ ਕੀਤਾ ਸੈਸ਼ਨ ਹੁਣ VPN ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਨਹੀਂ ਕਰ ਸਕਦਾ। ਐਪ ਵਿੱਚ ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰੋ।',
      'system_vpn_resume_identity_changed':
          'ਸਥਾਨਕ VPN ਪਛਾਣ ਬਦਲ ਗਈ ਹੈ। ਮੁੜ ਸ਼ੁਰੂ ਕਰਨਾ ਰੋਕ ਦਿੱਤਾ ਗਿਆ ਹੈ। ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_identity_invalid':
          'ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਵਰਤੀ ਜਾਣ ਵਾਲੀ ਪਛਾਣ ਅਵੈਧ ਹੈ। ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_storage_failed':
          'Android ਇਨਕ੍ਰਿਪਟਡ ਮੁੜ-ਸ਼ੁਰੂਆਤ ਡੇਟਾ ਪੜ੍ਹ ਜਾਂ ਅੱਪਡੇਟ ਨਹੀਂ ਕਰ ਸਕਿਆ। ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_network_timeout':
          'VPN ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ਲਈ Android ਨੂੰ ਸਮੇਂ ਸਿਰ ਨੈੱਟਵਰਕ ਨਹੀਂ ਮਿਲਿਆ। ਨੈੱਟਵਰਕ ਉਪਲਬਧ ਹੋਣ ’ਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'system_vpn_resume_blocked':
          'VPN ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ’ਤੇ ਰੋਕ ਲੱਗੀ ਹੋਈ ਹੈ। Android ਸੈਟਿੰਗਾਂ ਜਾਂਚੋ, ਫਿਰ ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_failed':
          'Android ਵੱਲੋਂ VPN ਮੁੜ ਸ਼ੁਰੂ ਕਰਨਾ ਅਸਫ਼ਲ ਰਿਹਾ। ਐਪ ਵਿੱਚ ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'system_vpn_resume_error_invalid':
          'Android ਨੇ ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ਸੰਬੰਧੀ ਅਜਿਹੀ ਗ਼ਲਤੀ ਵਾਪਸ ਕੀਤੀ ਜੋ ਵਰਤੀ ਨਹੀਂ ਜਾ ਸਕਦੀ। ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'wireguard_identity_store_failed':
          'Android ਇਸ ਖਾਤੇ ਦੀ ਇਨਕ੍ਰਿਪਟਡ WireGuard ਪਛਾਣ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'wireguard_identity_unavailable':
          'ਇਸ ਕਨੈਕਸ਼ਨ ਲਈ ਕੋਈ ਵਰਤੋਂ ਯੋਗ WireGuard ਪਛਾਣ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'vpn_host_destroyed':
          'VPN ਚਲਾਉਣ ਵਾਲਾ Android ਕੰਪੋਨੈਂਟ ਬੰਦ ਹੋ ਗਿਆ ਹੈ। ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'vpn_host_unavailable':
          'Android VPN ਚਲਾਉਣ ਵਾਲਾ ਕੰਪੋਨੈਂਟ ਨਹੀਂ ਬਣਾ ਸਕਦਾ। VPN ਸੈਟਿੰਗਾਂ ਜਾਂਚਣ ਤੋਂ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_renewal_required':
          'ਕਨੈਕਟ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਸਰਟੀਫ਼ਿਕੇਟ ਲਈ ਐਪ ਵਿੱਚ ਕਾਰਵਾਈ ਕਰਨੀ ਪਵੇਗੀ।',
      'openvpn_recovery_failed':
          'ਆਟੋਮੈਟਿਕ ਬਹਾਲੀ ਅਸਫ਼ਲ ਰਹੀ। ਐਪ ਵਿੱਚ ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'openvpn_recovery_exhausted':
          'ਆਟੋਮੈਟਿਕ ਬਹਾਲੀ ਪਹਿਲਾਂ ਹੀ ਵਰਤੀ ਜਾ ਚੁੱਕੀ ਹੈ। ਐਪ ਵਿੱਚ ਨਵਾਂ ਕਨੈਕਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ।',
      'vpn_permission_required':
          'ਟਨਲ ਸ਼ੁਰੂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ Android ਨੂੰ ਨਵੀਂ VPN ਇਜਾਜ਼ਤ ਚਾਹੀਦੀ ਹੈ।',
      'vpn_permission_denied':
          'ਜਾਰੀ ਰੱਖਣ ਲਈ Android ਦੀ ਬੇਨਤੀ ਵਿੱਚ FuzeVPN ਨੂੰ ਇਜਾਜ਼ਤ ਦਿਓ।',
      'vpn_permission_request_failed':
          'Android VPN ਇਜਾਜ਼ਤ ਵਾਲੀ ਸਕ੍ਰੀਨ ਨਹੀਂ ਖੋਲ੍ਹ ਸਕਿਆ।',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard ਸੇਵਾ ਨੂੰ ਫ਼ੋਰਗ੍ਰਾਊਂਡ ਵਿੱਚ ਨਹੀਂ ਰੱਖ ਸਕਿਆ।',
      'wireguard_identity_invalid':
          'ਇਸ ਖਾਤੇ ਦੀ ਇਨਕ੍ਰਿਪਟਡ WireGuard ਕੁੰਜੀ ਪੜ੍ਹੀ ਨਹੀਂ ਜਾ ਸਕਦੀ ਜਾਂ ਅਵੈਧ ਹੈ।',
      'wireguard_identity_in_use':
          'ਇਸ ਖਾਤੇ ਦੀ WireGuard ਕੁੰਜੀ ਅਜੇ ਕੋਈ ਹੋਰ ਕਾਰਵਾਈ ਵਰਤ ਰਹੀ ਹੈ।',
      'wireguard_configuration_invalid':
          'ਪ੍ਰਾਪਤ ਹੋਏ WireGuard ਪਤੇ, DNS, ਸਰਵਰ ਕੁੰਜੀ ਜਾਂ ਰੂਟ ਅਵੈਧ ਹਨ।',
      'wireguard_operation_pending':
          'ਪਿਛਲੀ WireGuard ਕਾਰਵਾਈ ਨੇ ਅਜੇ ਆਪਣੀ ਨੇਟਿਵ ਸੇਵਾ ਛੱਡੀ ਨਹੀਂ ਹੈ।',
      'wireguard_start_failed':
          'WireGuard ਇੰਜਣ ਨੇ ਸੰਰਚਨਾ ਚਾਲੂ ਕਰਨ ਤੋਂ ਇਨਕਾਰ ਕੀਤਾ।',
      'wireguard_stop_timeout':
          'WireGuard ਸੇਵਾ ਨੇ ਸਮਾਂ ਸੀਮਾ ਵਿੱਚ VPN ਇੰਟਰਫ਼ੇਸ ਛੱਡਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ।',
      'wireguard_handshake_timeout':
          'ਟਨਲ ਨੇ ਸਮੇਂ ਸਿਰ ਸਰਵਰ ਨਾਲ ਹੈਂਡਸ਼ੇਕ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ।',
      'openvpn_connection_timeout':
          'OpenVPN ਨੇ ਸਮੇਂ ਸਿਰ ਸਰਵਰ ਨਾਲ ਕਨੈਕਸ਼ਨ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ।',
      'openvpn_core_unavailable':
          'ਇਸ ਐਪ ਵਰਜਨ ਵਿੱਚ ਵਰਤੋਂ ਯੋਗ OpenVPN ਇੰਜਣ ਨਹੀਂ ਹੈ।',
      'openvpn_operation_pending':
          'ਨੇਟਿਵ ਇੰਜਣ ਅਜੇ ਪਿਛਲਾ OpenVPN ਸੈਸ਼ਨ ਰੱਖਦਾ ਹੈ ਅਤੇ ਦੂਜਾ ਬਣਾਉਣ ਤੋਂ ਇਨਕਾਰ ਕਰਦਾ ਹੈ।',
      'openvpn_stop_timeout':
          'OpenVPN ਕੋਰ ਨੇ ਸਮਾਂ ਸੀਮਾ ਵਿੱਚ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ ਕਿ ਇਸ ਦਾ ਨੇਟਿਵ ਸੈਸ਼ਨ ਬੰਦ ਹੋ ਕੇ ਖ਼ਤਮ ਹੋ ਗਿਆ ਹੈ।',
      'openvpn_profile_unavailable':
          'ਇਸ ਕਨੈਕਸ਼ਨ ਲਈ ਕੋਈ ਵੈਧ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਪੜ੍ਹੀ ਨਹੀਂ ਜਾ ਸਕਦੀ।',
      'openvpn_native_failed':
          'ਐਪ ਗ਼ਲਤੀ ਕਾਰਨ OpenVPN ਰੁਕ ਗਿਆ। ਦੁਬਾਰਾ ਕਨੈਕਟ ਕਰਨ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰੋ। ਸਮੱਸਿਆ ਬਣੀ ਰਹੇ ਤਾਂ ਡਾਇਗਨੌਸਟਿਕ ਚਲਾਓ।',
      'openvpn_key_generation_failed':
          'Android Keystore ਬਾਹਰ ਨਾ ਕੱਢੀ ਜਾ ਸਕਣ ਵਾਲੀ P-256 ਨਿੱਜੀ ਕੁੰਜੀ ਨਹੀਂ ਬਣਾ ਜਾਂ ਪੜ੍ਹ ਸਕਿਆ।',
      'openvpn_csr_generation_failed':
          'Android Keystore ਦੀ ਕੁੰਜੀ OpenVPN ਸਰਟੀਫ਼ਿਕੇਟ ਬੇਨਤੀ ’ਤੇ ਦਸਤਖ਼ਤ ਨਹੀਂ ਕਰ ਸਕੀ।',
      'openvpn_identity_store_failed':
          'OpenVPN ਸਰਟੀਫ਼ਿਕੇਟ ਜਾਂ ਪ੍ਰੋਫ਼ਾਈਲ ਇਨਕ੍ਰਿਪਟਡ ਸਟੋਰੇਜ ਵਿੱਚ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋ ਸਕੀ।',
      'openvpn_identity_clear_failed':
          'Android ਇਸ ਖਾਤੇ ਦੀ ਪੂਰੀ ਸਥਾਨਕ OpenVPN ਪਛਾਣ ਹਟਾ ਨਹੀਂ ਸਕਿਆ।',
      'openvpn_identity_in_use':
          'ਇੱਕ ਨੇਟਿਵ OpenVPN ਸੈਸ਼ਨ ਅਜੇ ਇਸ ਡੀਵਾਈਸ ਦੀ ਕੁੰਜੀ ਜਾਂ ਸਰਟੀਫ਼ਿਕੇਟ ਵਰਤ ਰਿਹਾ ਹੈ।',
      'openvpn_tls_verification_required':
          'ਪ੍ਰੋਫ਼ਾਈਲ ਸਰਵਰ ਸਰਟੀਫ਼ਿਕੇਟ ਦੀ ਪੁਸ਼ਟੀ ਨੂੰ ਸਪੱਸ਼ਟ ਤੌਰ ’ਤੇ ਲਾਜ਼ਮੀ ਨਹੀਂ ਬਣਾਉਂਦੀ।',
      'openvpn_cipher_invalid':
          'ਸਰਵਰ ਨੇ ਅਜਿਹਾ ਇਨਕ੍ਰਿਪਸ਼ਨ ਐਲਗੋਰਿਦਮ ਦਿੱਤਾ ਜੋ ਮਨਜ਼ੂਰਸ਼ੁਦਾ ਸੂਚੀ ਵਿੱਚ ਨਹੀਂ ਹੈ।',
      'openvpn_profile_rejected':
          'ਸਰਵਰ ਤੋਂ ਮਿਲੀ ਪ੍ਰੋਫ਼ਾਈਲ ਅਨੁਕੂਲ ਨਹੀਂ ਹੈ। ਇਸ ਡੀਵਾਈਸ ਨੂੰ ਮੁੜ ਬਣਾਓ ਅਤੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'openvpn_identity_inconsistent':
          'ਸਰਟੀਫ਼ਿਕੇਟ ਇਸ ਫ਼ੋਨ ਦੀ ਸੁਰੱਖਿਅਤ ਪਛਾਣ ਨਾਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦਾ। ਕੋਈ ਸਥਾਨਕ ਪ੍ਰੋਫ਼ਾਈਲ ਨਹੀਂ ਬਦਲੀ ਗਈ।',
      'tls_handshake_failed':
          'ਸਰਵਰ ਨੇ TLS ਗੱਲਬਾਤ ਰੱਦ ਕੀਤੀ। ਸਮੱਸਿਆ ਬਣੀ ਰਹੇ ਤਾਂ ਪ੍ਰੋਫ਼ਾਈਲ ਮੁੜ ਬਣਾਓ।',
      'tls_alert_unknown_ca':
          'ਸਰਵਰ ਇਸ ਡੀਵਾਈਸ ਦੇ ਸਰਟੀਫ਼ਿਕੇਟ ਦੀ ਅਥਾਰਟੀ ਨੂੰ ਨਹੀਂ ਪਛਾਣਦਾ। OpenVPN ਸਰਵਰ ਦੀ ਜਾਂਚ ਕਰਨੀ ਪਵੇਗੀ।',
      'tls_alert_bad_certificate':
          'ਸਰਵਰ ਨੇ ਇਸ ਡੀਵਾਈਸ ਦੇ ਸਰਟੀਫ਼ਿਕੇਟ ਨੂੰ ਰੱਦ ਕਰ ਦਿੱਤਾ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਡੀਵਾਈਸ ਮੁੜ ਬਣਾਓ।',
      'tls_alert_unsupported_certificate':
          'ਸਰਵਰ ਉਸ ਸੁਰੱਖਿਅਤ ਸਰਟੀਫ਼ਿਕੇਟ ਕਿਸਮ ਦਾ ਸਮਰਥਨ ਨਹੀਂ ਕਰਦਾ ਜੋ Android ਵਰਤਦਾ ਹੈ।',
      'tls_client_certificate_required':
          'ਸਰਵਰ ਨੂੰ ਕਲਾਇੰਟ ਸਰਟੀਫ਼ਿਕੇਟ ਚਾਹੀਦਾ ਹੈ, ਪਰ OpenVPN ਕੋਰ ਇਹ ਪੇਸ਼ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'tls_alert_misc':
          'ਸਰਵਰ ਨੇ ਸਰਟੀਫ਼ਿਕੇਟ ਅਤੇ ਵਰਜਨ ਸ਼੍ਰੇਣੀਆਂ ਤੋਂ ਬਾਹਰ ਦੀ TLS ਚੇਤਾਵਨੀ ਭੇਜੀ।',
      'tls_signature_algorithm_rejected':
          'ਸਰਵਰ ਨੇ Android Keystore ਕੁੰਜੀ ਦਾ ECDSA P-256 ਐਲਗੋਰਿਦਮ ਰੱਦ ਕੀਤਾ।',
      'tls_handshake_rejected':
          'ਸਰਵਰ ਨੇ ਕਨੈਕਸ਼ਨ ਤੋਂ ਪਹਿਲਾਂ TLS ਗੱਲਬਾਤ ਵਿੱਚ ਰੁਕਾਵਟ ਪਾਈ।',
      'tls_version_rejected':
          'ਕਲਾਇੰਟ ਅਤੇ ਸਰਵਰ ਨੂੰ ਕੋਈ ਸਾਂਝਾ TLS ਵਰਜਨ ਨਹੀਂ ਮਿਲਿਆ।',
      'tls_certificate_expired':
          'ਕਨੈਕਸ਼ਨ ਦੌਰਾਨ ਪੇਸ਼ ਕੀਤੇ ਗਏ ਸਰਟੀਫ਼ਿਕੇਟ ਦੀ ਮਿਆਦ ਪੁੱਗ ਚੁੱਕੀ ਹੈ।',
      'tls_certificate_revoked':
          'ਕਨੈਕਸ਼ਨ ਦੌਰਾਨ ਪੇਸ਼ ਕੀਤਾ ਗਿਆ ਸਰਟੀਫ਼ਿਕੇਟ ਰੱਦ ਕੀਤਾ ਗਿਆ ਹੈ।',
      'transport_failed':
          'ਮੌਜੂਦਾ ਨੈੱਟਵਰਕ ’ਤੇ OpenVPN ਸਰਵਰ ਜਵਾਬ ਨਹੀਂ ਦੇ ਰਿਹਾ। ਕੁਝ ਦੇਰ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'tun_configuration_rejected':
          'Android ਨੇ OpenVPN ਵੱਲੋਂ ਮੰਗੀ ਨੈੱਟਵਰਕ ਸੰਰਚਨਾ ਰੱਦ ਕੀਤੀ।',
      'tun_setup_failed':
          'Android ਇੰਟਰਫ਼ੇਸ ਬਣਾਉਣ ਤੋਂ ਪਹਿਲਾਂ OpenVPN ਕੋਰ ਨੇ ਨੈੱਟਵਰਕ ਯੋਜਨਾ ਰੱਦ ਕੀਤੀ।',
      'tun_interface_create_failed':
          'OpenVPN ਕੋਰ ਨੂੰ Android VpnService ਤੋਂ TUN ਇੰਟਰਫ਼ੇਸ ਨਹੀਂ ਮਿਲ ਸਕਿਆ।',
      'tun_interface_disabled':
          'ਕਨੈਕਸ਼ਨ ਦੌਰਾਨ Android ਜਾਂ OpenVPN ਕੋਰ ਨੇ TUN ਇੰਟਰਫ਼ੇਸ ਬੰਦ ਕਰ ਦਿੱਤਾ।',
      'tun_halted': 'OpenVPN ਕੋਰ ਨੂੰ TUN ਇੰਟਰਫ਼ੇਸ ਬੰਦ ਕਰਨ ਦੀ ਬੇਨਤੀ ਮਿਲੀ।',
      'tun_already_established':
          'OpenVPN ਨੇ ਉਸੇ ਕਨੈਕਸ਼ਨ ਵਿੱਚ ਦੂਜੇ ਇੰਟਰਫ਼ੇਸ ਦੀ ਬੇਨਤੀ ਕੀਤੀ। ਸੁਰੱਖਿਆ ਲਈ ਟਨਲ ਬੰਦ ਕੀਤੀ ਗਈ।',
      'tun_addresses_missing': 'ਸਰਵਰ ਨੇ ਵਰਤੋਂ ਯੋਗ ਟਨਲ ਪਤਾ ਨਹੀਂ ਦਿੱਤਾ।',
      'tun_routes_missing': 'ਸਰਵਰ ਨੇ ਵਰਤੋਂ ਯੋਗ ਟਨਲ ਰੂਟ ਨਹੀਂ ਦਿੱਤੇ।',
      'tun_dns_missing': 'ਸਰਵਰ ਨੇ ਵਰਤੋਂ ਯੋਗ DNS ਸਰਵਰ ਨਹੀਂ ਦਿੱਤਾ।',
      'tun_permission_revoked':
          'ਕਨੈਕਸ਼ਨ ਦੌਰਾਨ Android ਨੇ VPN ਇਜਾਜ਼ਤ ਰੱਦ ਕਰ ਦਿੱਤੀ।',
      'tun_establish_returned_null':
          'Android ਨੇ ਇੰਟਰਫ਼ੇਸ ਨਹੀਂ ਬਣਾਇਆ, ਆਮ ਤੌਰ ’ਤੇ ਇਸ ਲਈ ਕਿ ਕੋਈ ਹੋਰ VPN ਅਜੇ ਸਰਗਰਮ ਹੈ।',
      'openvpn_service_start_failed':
          'Android OpenVPN ਫ਼ੋਰਗ੍ਰਾਊਂਡ ਸੇਵਾ ਸ਼ੁਰੂ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'openvpn_operation_timeout':
          'OpenVPN ਕੋਰ ਲਈ JNI ਕਾਲ ਵੱਧ ਤੋਂ ਵੱਧ ਸਮਾਂ ਪਾਰ ਕਰ ਗਈ।',
      'openvpn_start_failed':
          'Android ਸੇਵਾ ਤਿਆਰ ਹੈ, ਪਰ OpenVPN ਕੋਰ ਨੇ ਪ੍ਰੋਫ਼ਾਈਲ ਸ਼ੁਰੂ ਕਰਨਾ ਸਵੀਕਾਰ ਨਹੀਂ ਕੀਤਾ।',
      'openvpn_connection_failed':
          'CONNECTED ਇਵੈਂਟ ਤੋਂ ਪਹਿਲਾਂ OpenVPN ਕੋਰ ਬੰਦ ਹੋ ਗਿਆ।',
      'openvpn_core_status_error':
          'ਨੇਟਿਵ OpenVPN ਲੂਪ ਗ਼ਲਤੀ ਨਾਲ ਖ਼ਤਮ ਹੋਇਆ ਅਤੇ ਕੋਈ ਹੋਰ ਖ਼ਾਸ ਅੰਤਿਮ ਇਵੈਂਟ ਨਹੀਂ ਮਿਲਿਆ।',
      'openvpn_stopped_before_connected':
          'ਨੇਟਿਵ OpenVPN ਲੂਪ CONNECTED ਤੋਂ ਪਹਿਲਾਂ ਰੁਕ ਗਿਆ, ਕੋਈ ਸਪੱਸ਼ਟ ਕੋਰ ਗ਼ਲਤੀ ਨਹੀਂ ਸੀ।',
      'openvpn_auth_failed':
          'OpenVPN ਸਰਵਰ ਨੇ ਪ੍ਰੋਫ਼ਾਈਲ ਦੀ ਪ੍ਰਮਾਣਿਕਤਾ ਰੱਦ ਕੀਤੀ।',
      'openvpn_client_setup_failed':
          'ਨੈੱਟਵਰਕ ਕਨੈਕਸ਼ਨ ਤੋਂ ਪਹਿਲਾਂ OpenVPN ਕੋਰ ਕਲਾਇੰਟ ਸ਼ੁਰੂ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'openvpn_client_halted':
          'OpenVPN ਕੋਰ ਨੂੰ ਕਲਾਇੰਟ ਨੂੰ ਪੱਕੇ ਤੌਰ ’ਤੇ ਰੋਕਣ ਦੀ ਬੇਨਤੀ ਮਿਲੀ।',
      'openvpn_client_restart':
          'OpenVPN ਕੋਰ ਨੇ ਆਪਣੇ ਟ੍ਰਾਂਸਪੋਰਟ ਸੈਸ਼ਨ ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ਦੀ ਬੇਨਤੀ ਕੀਤੀ।',
      'openvpn_inactive_timeout':
          'ਕੋਈ ਕਾਰਵਾਈ ਨਾ ਹੋਣ ਕਾਰਨ OpenVPN ਕੋਰ ਨੇ ਸੈਸ਼ਨ ਬੰਦ ਕਰ ਦਿੱਤਾ।',
      'openvpn_session_expired':
          'ਸਰਵਰ ਨੇ ਦੱਸਿਆ ਕਿ OpenVPN ਸੈਸ਼ਨ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ ਹੈ।',
      'openvpn_credentials_required':
          'ਸਰਵਰ ਜਾਂ ਪ੍ਰੌਕਸੀ ਹੱਥੀਂ ਦਰਜ ਕੀਤੇ ਜਾਣ ਵਾਲੇ ਸਾਈਨ ਇਨ ਵੇਰਵੇ ਮੰਗ ਰਿਹਾ ਹੈ, ਜੋ ਇਸ ਸਰਟੀਫ਼ਿਕੇਟ ਪ੍ਰੋਫ਼ਾਈਲ ਦਾ ਹਿੱਸਾ ਨਹੀਂ ਹਨ।',
      'openvpn_proxy_failed':
          'OpenVPN ਕੋਰ ਨੇ ਸੰਰਚਿਤ ਪ੍ਰੌਕਸੀ ਜਾਂ ਰਿਲੇ ਦੀ ਅਸਫ਼ਲਤਾ ਦੀ ਰਿਪੋਰਟ ਕੀਤੀ।',
      'openvpn_compression_failed':
          'OpenVPN ਕੋਰ ਨੇ ਪ੍ਰੋਫ਼ਾਈਲ ਜਾਂ ਸਰਵਰ ਵੱਲੋਂ ਐਲਾਨੇ ਕੰਪਰੈਸ਼ਨ ਮੋਡ ਨੂੰ ਰੱਦ ਕੀਤਾ।',
      'openvpn_ntlm_crypto_unavailable':
          'ਪ੍ਰੋਫ਼ਾਈਲ ਵੱਲੋਂ ਮੰਗੀ NTLM ਇਨਕ੍ਰਿਪਸ਼ਨ ਇਸ ਵਰਜਨ ਵਿੱਚ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'openvpn_feature_unsupported':
          'ਪ੍ਰੋਫ਼ਾਈਲ ਜਾਂ ਸਰਵਰ ਨੂੰ ਇੱਕ ਅਜਿਹਾ ਫ਼ੀਚਰ ਚਾਹੀਦਾ ਹੈ ਜੋ ਇਸ Android ਕਲਾਇੰਟ ਵਿੱਚ ਨਹੀਂ ਹੈ।',
      'network_unavailable': 'ਕੋਈ ਵਰਤੋਂ ਯੋਗ ਭੌਤਿਕ ਨੈੱਟਵਰਕ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।',
      'network_lost': 'ਨੈੱਟਵਰਕ ਟੁੱਟਣ ਤੋਂ ਬਾਅਦ ਟਨਲ ਬੰਦ ਕਰ ਦਿੱਤੀ ਗਈ।',
      'certificate_validation_failed':
          'OpenVPN ਸਰਵਰ ਦੀ ਪਛਾਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ।',
      'openvpn_certificate_expired':
          'ਮੁੜ ਕਨੈਕਟ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਨਵਿਆਓ।',
      'tunnel_active_for_another_account':
          'ਇਸ ਕਨੈਕਸ਼ਨ ਤੋਂ ਪਹਿਲਾਂ ਕਿਸੇ ਹੋਰ ਖਾਤੇ ਦੀ ਟਨਲ ਬੰਦ ਕਰਨੀ ਪਵੇਗੀ।',
      'tunnel_already_active':
          'Android ਦੱਸਦਾ ਹੈ ਕਿ ਪਿਛਲਾ VPN ਸੈਸ਼ਨ ਅਜੇ ਵੀ ਇੰਟਰਫ਼ੇਸ ਵਰਤ ਰਿਹਾ ਹੈ।',
      'tunnel_stop_timeout':
          '$protocol ਇੰਜਣ ਨੇ ਸਮਾਂ ਸੀਮਾ ਵਿੱਚ VPN ਇੰਟਰਫ਼ੇਸ ਛੱਡਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕੀਤੀ।',
      'tunnel_disconnected':
          'ਸ਼ੁਰੂ ਹੋਣ ਤੋਂ ਬਾਅਦ ਨੇਟਿਵ ਇੰਜਣ ਨੇ ਦੱਸਿਆ ਕਿ ਟਨਲ ਅਚਾਨਕ ਖ਼ਤਮ ਹੋ ਗਈ।',
      'native_bridge_unavailable':
          'ਐਪ Android VPN ਸੇਵਾ ਤੱਕ ਪਹੁੰਚ ਨਹੀਂ ਕਰ ਸਕਦੀ। ਐਪ ਬੰਦ ਕਰਕੇ ਦੁਬਾਰਾ ਖੋਲ੍ਹੋ, ਫਿਰ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
      'native_operation_failed':
          'ਐਪ ਗ਼ਲਤੀ ਕਾਰਨ VPN ਕਾਰਵਾਈ ਰੁਕ ਗਈ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ। ਸਮੱਸਿਆ ਬਣੀ ਰਹੇ ਤਾਂ ਡਾਇਗਨੌਸਟਿਕ ਚਲਾਓ।',
      'invalid_arguments':
          'ਇਸ VPN ਕਾਰਵਾਈ ਲਈ ਲੋੜੀਂਦੀ ਜਾਣਕਾਰੀ ਅਧੂਰੀ ਹੈ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ। ਸਮੱਸਿਆ ਬਣੀ ਰਹੇ ਤਾਂ ਡਾਇਗਨੌਸਟਿਕ ਚਲਾਓ।',
      'invalid_account_id':
          'ਨੇਟਿਵ ਕਾਰਵਾਈ ਖਾਤੇ ਦੇ ਕਿਸੇ ਵੈਧ ਪਛਾਣਕਰਤਾ ਨਾਲ ਜੁੜੀ ਨਹੀਂ ਹੈ।',
      'invalid_device_id':
          'ਨੇਟਿਵ ਇੰਜਣ ਨੂੰ ਭੇਜਿਆ ਡੀਵਾਈਸ ਪਛਾਣਕਰਤਾ ਗੁੰਮ ਹੈ ਜਾਂ ਅਵੈਧ ਹੈ।',
      'storage_key_not_allowed':
          'Android ਬ੍ਰਿਜ ਨੇ ਮਨਜ਼ੂਰ ਸਟੋਰੇਜ ਸੂਚੀ ਤੋਂ ਬਾਹਰ ਦੀ ਕੁੰਜੀ ਬਲਾਕ ਕੀਤੀ।',
      'secure_storage_read_failed':
          'Android Keystore ਇਸ ਖਾਤੇ ਦਾ ਸਥਾਨਕ ਡੇਟਾ ਡੀਕ੍ਰਿਪਟ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'secure_storage_write_failed':
          'Android Keystore ਸਥਾਨਕ ਡੇਟਾ ਇਨਕ੍ਰਿਪਟ ਜਾਂ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'key_generation_failed':
          'Android ਸੁਰੱਖਿਅਤ ਸਟੋਰੇਜ ਵਿੱਚ WireGuard ਕੁੰਜੀ ਨਹੀਂ ਬਣਾ ਜਾਂ ਪੜ੍ਹ ਸਕਿਆ।',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR ਨਹੀਂ ਬਣਾ ਜਾਂ ਉਸ ’ਤੇ ਦਸਤਖ਼ਤ ਨਹੀਂ ਕਰ ਸਕਿਆ।',
      'other':
          'ਨੇਟਿਵ ਹਿੱਸੇ ਵਿੱਚ ਇੱਕ ਅਣਪਛਾਤੀ ਗ਼ਲਤੀ ਹੋਈ। ਹੇਠਾਂ ਦਿੱਤਾ ਡਾਇਗਨੌਸਟਿਕ ਕੋਡ ਸਹਾਇਤਾ ਨੂੰ ਭੇਜੋ।',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'ਇਜਾਜ਼ਤ ਦੀ ਬੇਨਤੀ ਪਹਿਲਾਂ ਹੀ ਖੁੱਲ੍ਹੀ ਹੈ';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN ਇਜਾਜ਼ਤ ਦੀ ਬੇਨਤੀ ਪਹਿਲਾਂ ਹੀ ਦਿਖਾਈ ਜਾ ਰਹੀ ਹੈ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਇਸ ਨੂੰ ਪੂਰਾ ਕਰੋ।';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN ਇਜਾਜ਼ਤ ਦੀ ਬੇਨਤੀ ਰੁਕ ਗਈ';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ਐਪ ਨੂੰ ਜਵਾਬ ਮਿਲਣ ਤੋਂ ਪਹਿਲਾਂ ਹੀ VPN ਇਜਾਜ਼ਤ ਵਾਲੀ ਸਕ੍ਰੀਨ ਬੰਦ ਹੋ ਗਈ।';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN ਕਨੈਕਸ਼ਨ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN ਕਨੈਕਸ਼ਨ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ। ਸੁਰੱਖਿਆ ਲਈ ਇਸ ਨੂੰ ਰੋਕ ਦਿੱਤਾ ਗਿਆ ਹੈ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get openvpnCleanup_title => 'OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਰੱਦ ਕੀਤੀ ਗਈ';

  @override
  String get openvpnCleanup_working =>
      'ਰੱਦ ਹੋਈ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਬੰਦ ਅਤੇ ਹਟਾਈ ਜਾ ਰਹੀ ਹੈ…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN ਬੰਦ ਹੋਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ। ਨਵੀਂ ਪ੍ਰੋਫ਼ਾਈਲ ਬਣਾਉਣ ਤੋਂ ਪਹਿਲਾਂ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'ਰੱਦ ਹੋਈ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਪੂਰੀ ਤਰ੍ਹਾਂ ਹਟਾਈ ਨਹੀਂ ਜਾ ਸਕੀ। ਸਫ਼ਾਈ ਦੀ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get openvpnCleanup_complete =>
      'ਰੱਦ ਹੋਈ OpenVPN ਪ੍ਰੋਫ਼ਾਈਲ ਹਟਾ ਦਿੱਤੀ ਗਈ ਹੈ। ਨਵੀਂ ਬਣਾਉਣ ਲਈ “ਕਨੈਕਟ ਕਰੋ” ’ਤੇ ਟੈਪ ਕਰੋ।';

  @override
  String get network_title => 'ਨੈੱਟਵਰਕ ਸੰਰਚਨਾ';

  @override
  String get network_ipv4Fallback =>
      'IPv6 ਅਸਥਾਈ ਤੌਰ ’ਤੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਤਿਆਰੀ IPv4 ਨਾਲ ਜਾਰੀ ਹੈ।';

  @override
  String get network_rejectedTitle => 'ਨੈੱਟਵਰਕ ਸੰਰਚਨਾ ਰੱਦ ਹੋਈ';

  @override
  String get network_rejectedMessage =>
      'ਟਨਲ ਸੰਰਚਨਾ ਅਧੂਰੀ ਹੈ ਜਾਂ ਮਨਜ਼ੂਰ ਪਤਿਆਂ ਨਾਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦੀ। ਐਪ ਤੋਂ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get network_unreadableTitle => 'ਸਥਾਨਕ ਸੰਰਚਨਾ ਪੜ੍ਹੀ ਨਹੀਂ ਜਾ ਸਕਦੀ';

  @override
  String get network_unreadableMessage =>
      'ਸੰਭਾਲੀ ਗਈ OpenVPN ਨੈੱਟਵਰਕ ਸੰਰਚਨਾ ਵਰਤੀ ਨਹੀਂ ਜਾ ਸਕਦੀ। ਇਸ ਨੂੰ ਅੱਪਡੇਟ ਕਰਨ ਲਈ ਐਪ ਤੋਂ ਮੁੜ ਕਨੈਕਟ ਕਰੋ।';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ਨੈੱਟਵਰਕ ਸੁਰੱਖਿਆ';

  @override
  String get protection_subtitle =>
      'VPN ਬੰਦ ਹੋਣ ’ਤੇ ਸਿੱਧੀ ਇੰਟਰਨੈੱਟ ਪਹੁੰਚ ਬਲਾਕ ਕਰੋ।';

  @override
  String get protection_active => 'ਸਿਸਟਮ ਸੁਰੱਖਿਆ ਚਾਲੂ ਹੈ';

  @override
  String get protection_alwaysOnOnly =>
      'ਹਮੇਸ਼ਾ-ਚਾਲੂ VPN ਚਾਲੂ ਹੈ; VPN ਤੋਂ ਬਾਹਰ ਦੇ ਕਨੈਕਸ਼ਨ ਬਲਾਕ ਕਰਨਾ ਚਾਲੂ ਕਰੋ';

  @override
  String get protection_inactive => 'ਸਿਸਟਮ ਸੁਰੱਖਿਆ ਬੰਦ ਹੈ';

  @override
  String get protection_unknown => 'ਸਿਸਟਮ ਸੁਰੱਖਿਆ ਦੀ ਜਾਂਚ ਕਰੋ';

  @override
  String get protection_openSettings => 'Android ਸੈਟਿੰਗਾਂ ਖੋਲ੍ਹੋ';

  @override
  String get protection_dialogTitle => 'ਨੈੱਟਵਰਕ ਸੁਰੱਖਿਆ ਸੈੱਟ ਕਰੋ';

  @override
  String get protection_dialogMessage =>
      'ਹਮੇਸ਼ਾ-ਚਾਲੂ VPN ਅਤੇ VPN ਤੋਂ ਬਾਹਰਲੇ ਕਨੈਕਸ਼ਨਾਂ ਨੂੰ ਬਲਾਕ ਕਰਨਾ Android ਵੱਲੋਂ ਸੰਭਾਲਿਆ ਜਾਂਦਾ ਹੈ। ਯਕੀਨੀ ਬਣਾਓ ਕਿ FuzeVPN ਚੁਣਿਆ ਗਿਆ ਹੈ ਅਤੇ ਸਿਸਟਮ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਬਲਾਕਿੰਗ ਚਾਲੂ ਕਰੋ।';

  @override
  String get protection_dialogOpen => 'ਸੈਟਿੰਗਾਂ ਖੋਲ੍ਹੋ';

  @override
  String get session_systemProtectionNote =>
      'ਜੇ Android ਅਜੇ ਵੀ VPN ਤੋਂ ਬਾਹਰ ਦਾ ਟ੍ਰੈਫ਼ਿਕ ਬਲਾਕ ਕਰ ਰਿਹਾ ਹੈ, ਤਾਂ ਇਸ ਸੁਰੱਖਿਆ ਦੀ ਜਾਂਚ ਕਰਨ ਜਾਂ ਬਦਲਣ ਲਈ ਸਿਸਟਮ ਸੈਟਿੰਗਾਂ ਖੋਲ੍ਹੋ।';

  @override
  String get diagnostics_title => 'ਡਾਇਗਨੌਸਟਿਕਸ';

  @override
  String get diagnostics_settingsTitle => 'ਐਪ ਡਾਇਗਨੌਸਟਿਕਸ';

  @override
  String get diagnostics_automaticTitle => 'ਮਹੱਤਵਪੂਰਨ ਗ਼ਲਤੀਆਂ ਭੇਜੋ';

  @override
  String get diagnostics_automaticDescription =>
      'ਮਹੱਤਵਪੂਰਨ ਗ਼ਲਤੀ ਆਉਣ ’ਤੇ ਇੱਕ ਛੋਟੀ ਤਕਨੀਕੀ ਰਿਪੋਰਟ ਸਾਂਝੀ ਕਰੋ।';

  @override
  String get diagnostics_privacy =>
      'ਭੇਜੀਆਂ ਗਈਆਂ ਰਿਪੋਰਟਾਂ ਸਾਈਨ ਇਨ ਕੀਤੇ ਖਾਤੇ ਨਾਲ ਜੁੜੀਆਂ ਹੁੰਦੀਆਂ ਹਨ ਅਤੇ 30 ਦਿਨਾਂ ਲਈ ਰੱਖੀਆਂ ਜਾਂਦੀਆਂ ਹਨ। ਇਨ੍ਹਾਂ ਵਿੱਚ ਬ੍ਰਾਊਜ਼ਿੰਗ ਇਤਿਹਾਸ, ਪਾਸਵਰਡ ਜਾਂ VPN ਕੁੰਜੀਆਂ ਸ਼ਾਮਲ ਨਹੀਂ ਹੁੰਦੇ।';

  @override
  String get diagnostics_manualOpen => 'ਡਾਇਗਨੌਸਟਿਕਸ ਚਲਾਓ';

  @override
  String get diagnostics_localDescription =>
      'ਐਪ ਅਤੇ VPN ਦੀ ਸਥਿਤੀ ਦੀ ਰਿਪੋਰਟ ਬਣਾਓ। ਤੁਹਾਡਾ ਕਨੈਕਸ਼ਨ ਨਹੀਂ ਬਦਲੇਗਾ।';

  @override
  String get diagnostics_sendReport => 'ਰਿਪੋਰਟ ਭੇਜੋ';

  @override
  String get diagnostics_sendHint =>
      'ਰਿਪੋਰਟ ਇਸ ਡੀਵਾਈਸ ’ਤੇ ਰੱਖਣ ਲਈ ਇਹ ਬਾਕਸ ਅਣਚੁਣਿਆ ਰਹਿਣ ਦਿਓ।';

  @override
  String get diagnostics_signedOut =>
      'ਰਿਪੋਰਟ ਭੇਜਣ ਲਈ ਆਪਣੇ ਖਾਤੇ ਵਿੱਚ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get diagnostics_localLifetime =>
      'ਐਪ ਬੰਦ ਕਰਨ ਤੋਂ ਬਾਅਦ ਵੀ ਇਹ ਰਿਪੋਰਟ ਰੱਖਣ ਲਈ ਇਸ ਨੂੰ ਆਪਣੇ ਫ਼ੋਨ ’ਤੇ ਸੁਰੱਖਿਅਤ ਕਰੋ।';

  @override
  String get diagnostics_run => 'ਡਾਇਗਨੌਸਟਿਕਸ ਚਲਾਓ';

  @override
  String get diagnostics_rerun => 'ਡਾਇਗਨੌਸਟਿਕਸ ਦੁਬਾਰਾ ਚਲਾਓ';

  @override
  String get diagnostics_running => 'ਜਾਂਚ ਹੋ ਰਹੀ ਹੈ…';

  @override
  String get diagnostics_sending => 'ਰਿਪੋਰਟ ਭੇਜੀ ਜਾ ਰਹੀ ਹੈ…';

  @override
  String get diagnostics_prepared => 'ਰਿਪੋਰਟ ਇਸ ਡੀਵਾਈਸ ’ਤੇ ਤਿਆਰ ਹੈ';

  @override
  String get diagnostics_queued => 'ਰਿਪੋਰਟ ਭੇਜੇ ਜਾਣ ਦੀ ਉਡੀਕ ਵਿੱਚ ਹੈ';

  @override
  String get diagnostics_sent => 'ਰਿਪੋਰਟ ਪ੍ਰਾਪਤ ਹੋਈ';

  @override
  String get diagnostics_failed =>
      'ਭੇਜਣਾ ਅਸਫ਼ਲ ਰਿਹਾ। ਤੁਹਾਡੀ ਸਥਾਨਕ ਰਿਪੋਰਟ ਅਜੇ ਵੀ ਉਪਲਬਧ ਹੈ।';

  @override
  String get diagnostics_preparationFailed =>
      'ਡਾਇਗਨੌਸਟਿਕ ਰਿਪੋਰਟ ਤਿਆਰ ਨਹੀਂ ਹੋ ਸਕੀ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get diagnostics_authenticationRequired =>
      'ਰਿਪੋਰਟ ਭੇਜਣ ਲਈ ਦੁਬਾਰਾ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get diagnostics_retry => 'ਭੇਜਣ ਦੀ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get diagnostics_export => 'ਰਿਪੋਰਟ ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get diagnostics_exportFailed =>
      'ਐਕਸਪੋਰਟ ਅਸਫ਼ਲ ਰਿਹਾ। ਸਥਾਨਕ ਰਿਪੋਰਟ ਤੋਂ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get diagnostics_preferenceFailed =>
      'ਇਹ ਸੈਟਿੰਗ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋ ਸਕੀ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String diagnostics_receipt(Object id) {
    return 'ਹਵਾਲਾ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date ਨੂੰ ਪ੍ਰਾਪਤ ਹੋਈ';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date ਤੱਕ ਰੱਖੀ ਜਾਵੇਗੀ';
  }

  @override
  String get diagnostics_duplicate => 'ਇਹ ਰਿਪੋਰਟ ਪਹਿਲਾਂ ਹੀ ਪ੍ਰਾਪਤ ਹੋ ਚੁੱਕੀ ਸੀ।';

  @override
  String get diagnostics_preview => 'ਰਿਪੋਰਟ ਦੀ ਝਲਕ';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਤਕਨੀਕੀ ਘਟਨਾਵਾਂ ਜੋੜੀਆਂ ਗਈਆਂ',
      one: '1 ਤਕਨੀਕੀ ਘਟਨਾ ਜੋੜੀ ਗਈ',
      zero: 'ਕੋਈ ਤਕਨੀਕੀ ਘਟਨਾ ਨਹੀਂ ਜੋੜੀ ਗਈ',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'ਤਕਨੀਕੀ ਵੇਰਵੇ';

  @override
  String get diagnostics_empty =>
      'ਅਜੇ ਤੱਕ ਕੋਈ ਡਾਇਗਨੌਸਟਿਕ ਰਿਪੋਰਟ ਤਿਆਰ ਨਹੀਂ ਕੀਤੀ ਗਈ।';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ਟਨਲ ਦੀ ਸਥਿਤੀ',
      'handshake': 'ਕਨੈਕਸ਼ਨ ਦੀ ਪੁਸ਼ਟੀ',
      'certificate': 'VPN ਸਰਟੀਫ਼ਿਕੇਟ',
      'kill_switch': 'Android ਸੁਰੱਖਿਆ',
      'connectivity': 'ਉਪਲਬਧ ਨੈੱਟਵਰਕ',
      'api_reachability': 'ਸੇਵਾ ਤੱਕ ਪਹੁੰਚ',
      'secure_storage': 'ਸੁਰੱਖਿਅਤ ਸਟੋਰੇਜ',
      'other': 'ਸਥਾਨਕ ਜਾਂਚ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'ਜਾਂਚਿਆ ਗਿਆ',
      'failed': 'ਧਿਆਨ ਦੀ ਲੋੜ ਹੈ',
      'skipped': 'ਜਾਂਚ ਨਹੀਂ ਕੀਤੀ ਗਈ — ਕੋਈ ਸਰਗਰਮ ਪੜਤਾਲ ਨਹੀਂ',
      'unknown': 'ਜਾਣਕਾਰੀ ਉਪਲਬਧ ਨਹੀਂ',
      'other': 'ਜਾਣਕਾਰੀ ਉਪਲਬਧ ਨਹੀਂ',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN ਵਿੱਚ ਜੀ ਆਇਆਂ ਨੂੰ';

  @override
  String get connection_changeLocation => 'ਟਿਕਾਣਾ ਬਦਲੋ';

  @override
  String get connection_details => 'ਕਨੈਕਸ਼ਨ ਦੇ ਵੇਰਵੇ';

  @override
  String get locations_searchLabel => 'ਸ਼ਹਿਰ ਜਾਂ ਦੇਸ਼ ਖੋਜੋ';

  @override
  String get locations_clearSearch => 'ਖੋਜ ਸਾਫ਼ ਕਰੋ';

  @override
  String get locations_filterAll => 'ਸਾਰੇ';

  @override
  String get locations_filterFavorites => 'ਮਨਪਸੰਦ';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਟਿਕਾਣੇ',
      one: '$count ਟਿਕਾਣਾ',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'ਕੋਈ ਟਿਕਾਣਾ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get locations_noResultsHint => 'ਕੋਈ ਹੋਰ ਸ਼ਹਿਰ ਜਾਂ ਦੇਸ਼ ਅਜ਼ਮਾਓ।';

  @override
  String get locations_noFavorites => 'ਤੁਹਾਡੇ ਮਨਪਸੰਦ, ਬਿਲਕੁਲ ਨੇੜੇ';

  @override
  String get locations_noFavoritesHint =>
      'ਇੱਥੇ ਸੰਭਾਲਣ ਲਈ ਕਿਸੇ ਟਿਕਾਣੇ ਦੇ ਕੋਲ ਸਟਾਰ ’ਤੇ ਟੈਪ ਕਰੋ।';

  @override
  String get locations_showAll => 'ਸਾਰੇ ਟਿਕਾਣੇ ਦੇਖੋ';

  @override
  String locations_addFavorite(String name) {
    return '$name ਨੂੰ ਮਨਪਸੰਦ ਵਿੱਚ ਸ਼ਾਮਲ ਕਰੋ';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name ਨੂੰ ਮਨਪਸੰਦ ਤੋਂ ਹਟਾਓ';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'ਮਨਪਸੰਦ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋ ਸਕਿਆ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get locations_emptyTitle => 'ਕੋਈ ਟਿਕਾਣਾ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get locations_emptyHint => 'ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰਨ ਲਈ ਸੂਚੀ ਤਾਜ਼ਾ ਕਰੋ।';

  @override
  String get devices_manage => 'ਮੇਰੇ ਡੀਵਾਈਸ ਪ੍ਰਬੰਧਿਤ ਕਰੋ';

  @override
  String get settings_personalization => 'ਆਪਣੇ ਮੁਤਾਬਕ ਬਣਾਓ';

  @override
  String get settings_safety => 'ਸੁਰੱਖਿਆ';

  @override
  String get settings_help => 'ਮਦਦ ਚਾਹੀਦੀ ਹੈ?';

  @override
  String get settings_about => 'FuzeVPN ਬਾਰੇ';

  @override
  String get diagnostics_heading => 'ਕਨੈਕਸ਼ਨ ਦੀ ਸਮੱਸਿਆ ਨੂੰ ਸਮਝੋ';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ਉਪਲਬਧ',
      'pending': 'ਤਿਆਰ ਹੋ ਰਿਹਾ ਹੈ',
      'revoked': 'ਹਟਾਇਆ ਗਿਆ',
      'expired': 'ਮਿਆਦ ਪੁੱਗ ਗਈ',
      'other': 'ਸਥਿਤੀ ਉਪਲਬਧ ਨਹੀਂ',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ਸੈਟਿੰਗ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋਈ';

  @override
  String get notice_preferenceSave_message =>
      'ਤੁਹਾਡੀ ਚੋਣ ਫ਼ਿਲਹਾਲ ਲਾਗੂ ਹੈ, ਪਰ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਹੋ ਸਕੀ। ਐਪ ਬੰਦ ਕਰਨ ਤੋਂ ਬਾਅਦ ਵੀ ਇਸ ਨੂੰ ਰੱਖਣ ਲਈ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get connection_androidDisconnectHint =>
      'ਜੇ Android VPN ਨੂੰ ਚਾਲੂ ਰੱਖਦਾ ਹੈ, ਤਾਂ ਖੁੱਲ੍ਹਣ ਵਾਲੀਆਂ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਹਮੇਸ਼ਾ-ਚਾਲੂ VPN ਬੰਦ ਕਰੋ।';

  @override
  String get protection_learnMore => 'Android ਸੁਰੱਖਿਆ ਬਾਰੇ ਜਾਣੋ';

  @override
  String get protection_guideWhy =>
      'ਜੇ VPN ਡਿਸਕਨੈਕਟ ਹੋ ਜਾਵੇ, ਤਾਂ ਇਹ ਸੁਰੱਖਿਆ ਐਪਾਂ ਨੂੰ ਸਿੱਧਾ ਇੰਟਰਨੈੱਟ ਵਰਤਣ ਤੋਂ ਰੋਕਦੀ ਹੈ। ਇਹ Android ਵਿੱਚ ਸੈੱਟ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String get protection_guideAlwaysOnTitle => 'ਹਮੇਸ਼ਾ-ਚਾਲੂ VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN ਸੇਵਾ ਨੂੰ ਚਾਲੂ ਰੱਖਦਾ ਹੈ ਅਤੇ ਫ਼ੋਨ ਮੁੜ ਚਾਲੂ ਹੋਣ ਤੋਂ ਬਾਅਦ ਇਸ ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰ ਸਕਦਾ ਹੈ।';

  @override
  String get protection_guideBlockTitle => 'VPN ਤੋਂ ਬਿਨਾਂ ਕਨੈਕਸ਼ਨ ਬਲਾਕ ਕਰੋ';

  @override
  String get protection_guideBlock =>
      'ਇਹ ਸੈਟਿੰਗ ਟ੍ਰੈਫ਼ਿਕ ਨੂੰ VPN ਤੋਂ ਬਾਹਰ ਲੰਘਣ ਤੋਂ ਰੋਕਦੀ ਹੈ, ਕਨੈਕਸ਼ਨ ਟੁੱਟਣ ਦੌਰਾਨ ਵੀ।';

  @override
  String get protection_guideWarning =>
      'ਜੇ ਇਹ ਬਲਾਕਿੰਗ ਚਾਲੂ ਹੈ, ਤਾਂ VPN ਕਨੈਕਟ ਹੋਣ ਤੱਕ ਇੰਟਰਨੈੱਟ ਬੰਦ ਰਹਿੰਦਾ ਹੈ।';

  @override
  String get protection_guideStepsTitle => 'ਸੁਰੱਖਿਆ ਚਾਲੂ ਕਰੋ';

  @override
  String get protection_guideStep1 =>
      'ਹੇਠਾਂ ਦਿੱਤੇ ਬਟਨ ਨਾਲ Android VPN ਸੈਟਿੰਗਾਂ ਖੋਲ੍ਹੋ।';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN ਦੇ ਕੋਲ ਮੌਜੂਦ ਗੇਅਰ ਆਈਕਨ ’ਤੇ ਟੈਪ ਕਰਕੇ ਵਿਕਲਪ ਖੋਲ੍ਹੋ।';

  @override
  String get protection_guideStep3 =>
      'ਜੇ ਇਹ ਵਿਕਲਪ ਉਪਲਬਧ ਹਨ, ਤਾਂ “ਹਮੇਸ਼ਾ-ਚਾਲੂ VPN” ਅਤੇ ਫਿਰ “VPN ਤੋਂ ਬਿਨਾਂ ਕਨੈਕਸ਼ਨ ਬਲਾਕ ਕਰੋ” ਨੂੰ ਚਾਲੂ ਕਰੋ।';

  @override
  String get protection_guideManufacturers =>
      'ਨਾਮ ਫ਼ੋਨ ਮੁਤਾਬਕ ਵੱਖ-ਵੱਖ ਹੋ ਸਕਦੇ ਹਨ। ਲੋੜ ਪੈਣ ’ਤੇ ਸੈਟਿੰਗਾਂ ਵਿੱਚ VPN ਖੋਜੋ, ਜੋ ਅਕਸਰ “ਨੈੱਟਵਰਕ ਅਤੇ ਇੰਟਰਨੈੱਟ” ਹੇਠ ਹੁੰਦਾ ਹੈ।';

  @override
  String get protection_guideDisableTitle => 'ਇਹ ਸੁਰੱਖਿਆ ਬੰਦ ਕਰੋ';

  @override
  String get protection_guideDisable =>
      'ਇਨ੍ਹਾਂ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਹੀ, VPN ਤੋਂ ਬਿਨਾਂ ਕਨੈਕਸ਼ਨ ਬਲਾਕ ਕਰਨਾ ਬੰਦ ਕਰੋ, ਤਾਂ ਜੋ VPN ਤੋਂ ਬਿਨਾਂ ਵੀ ਇੰਟਰਨੈੱਟ ਵਰਤਿਆ ਜਾ ਸਕੇ। ਜੇ ਤੁਸੀਂ ਨਹੀਂ ਚਾਹੁੰਦੇ ਕਿ Android VPN ਨੂੰ ਮੁੜ ਸ਼ੁਰੂ ਕਰੇ, ਤਾਂ “ਹਮੇਸ਼ਾ-ਚਾਲੂ VPN” ਵੀ ਬੰਦ ਕਰੋ।';

  @override
  String get protection_guideManual =>
      'ਇਹ ਸੈਟਿੰਗਾਂ ਤੁਸੀਂ Android ਵਿੱਚ ਚੁਣਦੇ ਹੋ। FuzeVPN ਇਨ੍ਹਾਂ ਨੂੰ ਤੁਹਾਡੇ ਲਈ ਨਹੀਂ ਬਦਲਦਾ।';

  @override
  String get locations_changeTitle => 'ਕੀ ਟਿਕਾਣਾ ਬਦਲਣਾ ਹੈ?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ਡਿਸਕਨੈਕਟ ਹੋ ਜਾਵੇਗਾ, ਫਿਰ $name ਨਾਲ ਕਨੈਕਟ ਕਰਨ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰੇਗਾ।';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name ਨਾਲ ਕਨੈਕਟ ਕਰਨ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰੇਗਾ।';
  }

  @override
  String get locations_confirmChange => 'ਬਦਲੋ ਅਤੇ ਕਨੈਕਟ ਕਰੋ';

  @override
  String get locations_changeBusy =>
      'ਇੱਕ ਬਦਲਾਅ ਜਾਰੀ ਹੈ। ਕੋਈ ਹੋਰ ਟਿਕਾਣਾ ਚੁਣਨ ਤੋਂ ਪਹਿਲਾਂ ਉਡੀਕ ਕਰੋ।';

  @override
  String get locations_automaticSelection => 'ਆਟੋਮੈਟਿਕ ਚੋਣ';

  @override
  String get locations_cities => 'ਸ਼ਹਿਰ';

  @override
  String get locations_servers => 'ਸਰਵਰ';

  @override
  String locations_viewCities(String name) {
    return '$name ਦੇ ਸ਼ਹਿਰ ਦੇਖੋ';
  }

  @override
  String locations_viewServers(String name) {
    return '$name ਦੇ ਸਰਵਰ ਦੇਖੋ';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਦੇਸ਼',
      one: '$count ਦੇਸ਼',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਸ਼ਹਿਰ',
      one: '$count ਸ਼ਹਿਰ',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਸਰਵਰ',
      one: '$count ਸਰਵਰ',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ਸਾਰੇ ਦੇਸ਼';

  @override
  String get locations_backToCountries => 'ਦੇਸ਼ਾਂ ਦੀ ਸੂਚੀ ’ਤੇ ਵਾਪਸ ਜਾਓ';

  @override
  String locations_backToCities(String name) {
    return '$name ਦੇ ਸ਼ਹਿਰਾਂ ਦੀ ਸੂਚੀ ’ਤੇ ਵਾਪਸ ਜਾਓ';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name ਚੁਣੋ';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name ਚੁਣੋ';
  }

  @override
  String get locations_noCompatibleServer => 'ਕੋਈ ਅਨੁਕੂਲ ਸਰਵਰ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String get externalLink_failed =>
      'ਇਹ ਲਿੰਕ ਖੋਲ੍ਹਿਆ ਨਹੀਂ ਜਾ ਸਕਿਆ। ਤੁਸੀਂ ਇਸ ਨੂੰ ਕਾਪੀ ਕਰਕੇ ਆਪਣੇ ਬ੍ਰਾਊਜ਼ਰ ਵਿੱਚ ਖੋਲ੍ਹ ਸਕਦੇ ਹੋ।';

  @override
  String get externalLink_copy => 'ਲਿੰਕ ਕਾਪੀ ਕਰੋ';

  @override
  String get externalLink_copied => 'ਲਿੰਕ ਕਾਪੀ ਹੋ ਗਿਆ';

  @override
  String get externalLink_copyFailed =>
      'ਲਿੰਕ ਕਾਪੀ ਨਹੀਂ ਹੋ ਸਕਿਆ। ਹੇਠਾਂ ਦਿੱਤਾ ਪਤਾ ਚੁਣੋ।';

  @override
  String get settings_deleteAccount => 'ਮੇਰਾ ਖਾਤਾ ਮਿਟਾਓ';

  @override
  String get settings_deleteAccountDetail =>
      'ਖਾਤਾ ਮਿਟਾਉਣ ਦੀ ਬੇਨਤੀ ਦੀ ਪ੍ਰਕਿਰਿਆ ਦੇਖੋ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'ਆਪਣੀ VPN ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਚੁਣੋ।';

  @override
  String get billing_subscribe => 'ਸਬਸਕ੍ਰਾਈਬ ਕਰੋ';

  @override
  String get billing_choosePlan => 'ਜਾਰੀ ਰੱਖਣ ਲਈ ਇੱਕ ਪਲਾਨ ਚੁਣੋ।';

  @override
  String get billing_monthly => 'ਮਹੀਨਾਵਾਰ';

  @override
  String get billing_yearly => 'ਸਾਲਾਨਾ';

  @override
  String get billing_continue => 'Google Play ਨਾਲ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get billing_restore => 'ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਕਰੋ';

  @override
  String get billing_manage => 'ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਪ੍ਰਬੰਧਿਤ ਕਰੋ';

  @override
  String get billing_deleteAccountWarning =>
      'ਜੇ ਤੁਹਾਡੀ Google Play ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਹੈ, ਤਾਂ FuzeVPN ਖਾਤਾ ਮਿਟਾਉਣ ਨਾਲ ਇਸ ਦਾ ਨਵੀਨੀਕਰਨ ਰੱਦ ਨਹੀਂ ਹੁੰਦਾ। ਨਵੀਨੀਕਰਨ ਨੂੰ Google Play ਵਿੱਚ ਵੱਖਰੇ ਤੌਰ ’ਤੇ ਪ੍ਰਬੰਧਿਤ ਕਰੋ ਜਾਂ ਰੱਦ ਕਰੋ।';

  @override
  String get billing_deleteAccountContinue =>
      'ਖਾਤਾ ਮਿਟਾਉਣ ਦੀ ਬੇਨਤੀ ਲਈ ਅੱਗੇ ਵਧੋ';

  @override
  String get billing_refresh => 'ਪਹੁੰਚ ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get billing_loadingPlans => 'ਪਲਾਨ ਲੋਡ ਹੋ ਰਹੇ ਹਨ…';

  @override
  String get billing_unavailable =>
      'ਇਸ ਵੇਲੇ ਕੋਈ ਪਲਾਨ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਕੁਝ ਦੇਰ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get billing_comingSoon => 'ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਜਲਦੀ ਉਪਲਬਧ ਹੋਣਗੀਆਂ।';

  @override
  String get billing_priceDisclosure =>
      'ਕੀਮਤ Google Play ਵੱਲੋਂ ਦਿੱਤੀ ਗਈ ਹੈ। ਤੁਹਾਡੇ ਵੱਲੋਂ ਪੁਸ਼ਟੀ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਅੰਤਿਮ ਰਕਮ ਅਤੇ ਲਾਗੂ ਟੈਕਸਾਂ ਦੀ ਪੁਸ਼ਟੀ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String get billing_renewalMonthly =>
      'ਜਦੋਂ ਤੱਕ ਰੱਦ ਨਾ ਕੀਤੀ ਜਾਵੇ, ਇਹ ਹਰ ਮਹੀਨੇ ਆਪਣੇ-ਆਪ ਨਵਿਆਈ ਜਾਂਦੀ ਹੈ। ਤੁਸੀਂ Google Play ਦੀਆਂ ਸਬਸਕ੍ਰਿਪਸ਼ਨਾਂ ਵਿੱਚ ਕਦੇ ਵੀ ਰੱਦ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get billing_renewalYearly =>
      'ਜਦੋਂ ਤੱਕ ਰੱਦ ਨਾ ਕੀਤੀ ਜਾਵੇ, ਇਹ ਹਰ ਸਾਲ ਆਪਣੇ-ਆਪ ਨਵਿਆਈ ਜਾਂਦੀ ਹੈ। ਤੁਸੀਂ Google Play ਦੀਆਂ ਸਬਸਕ੍ਰਿਪਸ਼ਨਾਂ ਵਿੱਚ ਕਦੇ ਵੀ ਰੱਦ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get billing_active => 'ਤੁਹਾਡੀ Premium ਪਹੁੰਚ ਸਰਗਰਮ ਹੈ';

  @override
  String billing_accessUntil(String date) {
    return '$date ਤੱਕ ਪਹੁੰਚ ਉਪਲਬਧ ਹੈ।';
  }

  @override
  String get billing_webManaged =>
      'ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ FuzeVPN ਵੈੱਬਸਾਈਟ ’ਤੇ ਪ੍ਰਬੰਧਿਤ ਹੁੰਦੀ ਹੈ।';

  @override
  String get billing_playManaged =>
      'ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ Google Play ਵੱਲੋਂ ਪ੍ਰਬੰਧਿਤ ਹੁੰਦੀ ਹੈ।';

  @override
  String get billing_playOnHold =>
      'ਤੁਹਾਡੀ Google Play ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਰੋਕੀ ਹੋਈ ਹੈ ਜਾਂ ਭੁਗਤਾਨ ਦੀ ਉਡੀਕ ਵਿੱਚ ਹੈ। ਇਸ ਨੂੰ Google Play ਵਿੱਚ ਠੀਕ ਕਰਨ ਲਈ “ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਪ੍ਰਬੰਧਿਤ ਕਰੋ” ਖੋਲ੍ਹੋ।';

  @override
  String get billing_playReceiptUnlinked =>
      'ਇਸ Google Play ਖਾਤੇ ਕੋਲ ਪਹਿਲਾਂ ਹੀ ਇੱਕ Fuze Premium ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਹੈ ਜੋ ਇਸ FuzeVPN ਖਾਤੇ ਲਈ ਸਰਗਰਮ ਨਹੀਂ ਹੈ। ਇਸ ਨੂੰ Google Play ਵਿੱਚ ਦੇਖਣ ਲਈ “ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਪ੍ਰਬੰਧਿਤ ਕਰੋ” ਖੋਲ੍ਹੋ।';

  @override
  String get billing_inactive => 'ਕੋਈ ਸਰਗਰਮ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਨਹੀਂ ਹੈ।';

  @override
  String get billing_checkingAccess => 'ਤੁਹਾਡੀ ਪਹੁੰਚ ਦੀ ਜਾਂਚ ਹੋ ਰਹੀ ਹੈ…';

  @override
  String get billing_restoring => 'ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਹੋ ਰਹੀਆਂ ਹਨ…';

  @override
  String get billing_pending =>
      'ਭੁਗਤਾਨ ਉਡੀਕ ਵਿੱਚ ਹੈ। ਪੁਸ਼ਟੀ ਤੋਂ ਬਾਅਦ ਤੁਹਾਡੀ ਪਹੁੰਚ ਸਰਗਰਮ ਹੋ ਜਾਵੇਗੀ।';

  @override
  String get billing_cancelled =>
      'ਖ਼ਰੀਦ ਰੱਦ ਕੀਤੀ ਗਈ। ਕੋਈ ਨਵੀਂ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਸਰਗਰਮ ਨਹੀਂ ਹੋਈ।';

  @override
  String get billing_verifying => 'ਖ਼ਰੀਦ ਦੀ ਪੁਸ਼ਟੀ ਹੋ ਰਹੀ ਹੈ…';

  @override
  String get billing_success =>
      'ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਸਰਗਰਮ ਹੋ ਗਈ। ਤੁਹਾਡੀ Premium ਪਹੁੰਚ ਤਿਆਰ ਹੈ।';

  @override
  String get billing_restored => 'ਤੁਹਾਡੀਆਂ ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਕਰ ਦਿੱਤੀਆਂ ਗਈਆਂ ਹਨ।';

  @override
  String get billing_restoreEmpty =>
      'ਇਸ Google Play ਖਾਤੇ ਲਈ ਬਹਾਲ ਕਰਨ ਵਾਲੀ ਕੋਈ ਖ਼ਰੀਦ ਨਹੀਂ ਹੈ।';

  @override
  String get billing_catalogError => 'ਪਲਾਨ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੇ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get billing_purchaseError =>
      'ਖ਼ਰੀਦ ਸ਼ੁਰੂ ਨਹੀਂ ਹੋ ਸਕੀ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get billing_verificationError =>
      'ਖ਼ਰੀਦ ਦੀ ਪੁਸ਼ਟੀ ਇਸ ਵੇਲੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰਨ ਲਈ ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਕਰੋ।';

  @override
  String get billing_restoreError =>
      'ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਨਹੀਂ ਹੋ ਸਕੀਆਂ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get billing_managementError =>
      'ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਪ੍ਰਬੰਧਨ ਨਹੀਂ ਖੁੱਲ੍ਹ ਸਕਿਆ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get billing_storeUnavailable =>
      'ਇਸ ਡੀਵਾਈਸ ’ਤੇ Google Play ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String get welcome_title => 'ਤੁਹਾਡਾ VPN, ਹੁਣ ਬਹੁਤ ਸੌਖਾ।';

  @override
  String get welcome_description =>
      'ਆਪਣੇ ਕਨੈਕਸ਼ਨ ਦੀ ਸੁਰੱਖਿਆ ਕਰੋ। ਆਪਣੀ ਗੋਪਨੀਯਤਾ ’ਤੇ ਕੰਟਰੋਲ ਰੱਖੋ।';

  @override
  String get welcome_start => 'ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get welcome_alreadyPurchased => 'ਪਹਿਲਾਂ ਹੀ ਖ਼ਰੀਦ ਚੁੱਕੇ ਹੋ?';

  @override
  String get welcome_noAccountRequired => 'ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਖਾਤੇ ਦੀ ਲੋੜ ਨਹੀਂ ਹੈ।';

  @override
  String get guest_accountTitle => 'ਖਾਤਾ ਜੁੜਿਆ ਨਹੀਂ ਹੈ';

  @override
  String get guest_accountDescription =>
      'ਕਿਸੇ ਹੋਰ ਡੀਵਾਈਸ ’ਤੇ ਆਪਣੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਵਰਤਣ ਲਈ ਉਸੇ Google Play ਖਾਤੇ ਨਾਲ ਆਪਣੀਆਂ ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਕਰੋ।';

  @override
  String get guest_existingSubscriberSignIn =>
      'ਪਹਿਲਾਂ ਹੀ ਸਬਸਕ੍ਰਾਈਬ ਕਰ ਚੁੱਕੇ ਹੋ? ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get guest_claimTitle => 'FuzeVPN ਆਪਣੇ ਨਾਲ ਲੈ ਜਾਓ';

  @override
  String get guest_claimDescription =>
      'ਆਪਣੇ ਹੋਰ ਡੀਵਾਈਸਾਂ ’ਤੇ ਆਪਣੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਵਰਤਣ ਲਈ ਖਾਤਾ ਬਣਾਓ। ਇਹ ਕਦਮ ਵਿਕਲਪਿਕ ਹੈ।';

  @override
  String get guest_skip => 'ਬਾਅਦ ਵਿੱਚ';

  @override
  String get guest_activationTitle => 'Fuze Premium ਸਰਗਰਮ ਹੈ';

  @override
  String get guest_activationDescription =>
      'ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਤਿਆਰ ਹੈ। ਤੁਸੀਂ ਆਪਣਾ VPN ਵਰਤ ਸਕਦੇ ਹੋ ਅਤੇ ਜਦੋਂ ਚਾਹੋ ਖਾਤਾ ਬਣਾ ਸਕਦੇ ਹੋ।';

  @override
  String get guest_useVpn => 'ਮੇਰਾ VPN ਵਰਤੋ';

  @override
  String get guest_loginRequired =>
      'ਇਹ ਖ਼ਰੀਦ ਪਹਿਲਾਂ ਹੀ ਇੱਕ FuzeVPN ਖਾਤੇ ਨਾਲ ਜੁੜੀ ਹੋਈ ਹੈ। ਆਪਣੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਤੱਕ ਪਹੁੰਚ ਲਈ ਉਸ ਖਾਤੇ ਵਿੱਚ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get guest_signOutWarning =>
      'ਉਸੇ Google Play ਖਾਤੇ ਨਾਲ ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਕਰਕੇ ਤੁਸੀਂ ਆਪਣੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਮੁੜ ਹਾਸਲ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get guest_profileUnavailable =>
      'ਤੁਹਾਡਾ ਖਾਤਾ ਪਹਿਲਾਂ ਹੀ ਜੁੜਿਆ ਹੋਇਆ ਹੈ। ਆਪਣੀ ਜਾਣਕਾਰੀ ਦੇਖਣ ਅਤੇ ਪ੍ਰਬੰਧਿਤ ਕਰਨ ਲਈ ਸਾਈਨ ਇਨ ਕਰੋ।';

  @override
  String get billing_acceptance =>
      'ਜਾਰੀ ਰੱਖ ਕੇ, ਤੁਸੀਂ ਵਰਤੋਂ ਦੀਆਂ ਸ਼ਰਤਾਂ ਅਤੇ ਗੋਪਨੀਯਤਾ ਨੀਤੀ ਨੂੰ ਸਵੀਕਾਰ ਕਰਦੇ ਹੋ।';

  @override
  String get guest_verifyEmailReminder =>
      'ਆਪਣਾ ਖਾਤਾ ਸੁਰੱਖਿਅਤ ਕਰਨ ਲਈ ਆਪਣੇ ਈਮੇਲ ਪਤੇ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ। ਤੁਸੀਂ ਆਪਣਾ VPN ਵਰਤਣਾ ਜਾਰੀ ਰੱਖ ਸਕਦੇ ਹੋ।';

  @override
  String get guest_serviceUnavailable =>
      'ਸੇਵਾ ਇਸ ਵੇਲੇ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਥੋੜ੍ਹੀ ਦੇਰ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get guest_restoreError =>
      'ਤੁਹਾਡੀਆਂ ਖ਼ਰੀਦਾਂ ਬਹਾਲ ਨਹੀਂ ਹੋ ਸਕੀਆਂ। ਖ਼ਰੀਦ ਲਈ ਵਰਤੇ ਗਏ Google Play ਖਾਤੇ ਨਾਲ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get guest_claimSuccess =>
      'ਤੁਹਾਡਾ ਖਾਤਾ ਬਣਾ ਦਿੱਤਾ ਗਿਆ ਹੈ। ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਅਤੇ VPN ਪਹੁੰਚ ਬਰਕਰਾਰ ਰੱਖੀ ਗਈ ਹੈ।';

  @override
  String get guest_emailExists =>
      'ਇਹ ਈਮੇਲ ਪਹਿਲਾਂ ਹੀ ਵਰਤੋਂ ਵਿੱਚ ਹੈ। ਕੋਈ ਹੋਰ ਪਤਾ ਚੁਣੋ ਜਾਂ ਆਪਣੇ ਮੌਜੂਦਾ ਖਾਤੇ ਵਿੱਚ ਸਾਈਨ ਇਨ ਕਰੋ। ਤੁਹਾਡੀ ਖ਼ਰੀਦ Google Play ਰਾਹੀਂ ਉਪਲਬਧ ਰਹਿੰਦੀ ਹੈ।';

  @override
  String get guest_claimError =>
      'ਤੁਹਾਡਾ ਖਾਤਾ ਨਹੀਂ ਬਣ ਸਕਿਆ। ਤੁਸੀਂ ਆਪਣਾ VPN ਵਰਤਣਾ ਜਾਰੀ ਰੱਖ ਸਕਦੇ ਹੋ ਅਤੇ ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get guest_secureStorageError =>
      'ਇਸ ਡੀਵਾਈਸ ’ਤੇ ਤੁਹਾਡਾ ਸੈਸ਼ਨ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਕੀਤਾ ਜਾ ਸਕਿਆ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get guest_premiumRequired =>
      'ਆਪਣਾ VPN ਚਾਲੂ ਕਰਨ ਲਈ ਇੱਕ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਚੁਣੋ।';

  @override
  String get welcome_viewPlans => 'ਪਲਾਨ ਦੇਖੋ';

  @override
  String get google_continue => 'Google ਨਾਲ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get google_or => 'ਜਾਂ';

  @override
  String get google_title => 'ਤੁਹਾਡਾ FuzeVPN ਖਾਤਾ';

  @override
  String get google_settingUp => 'ਆਪਣਾ ਖਾਤਾ ਬਣਾਉਣਾ ਪੂਰਾ ਕਰੋ';

  @override
  String get google_country => 'ਰਿਹਾਇਸ਼ ਦਾ ਦੇਸ਼';

  @override
  String get google_profileDescription =>
      'ਆਪਣਾ FuzeVPN ਖਾਤਾ ਬਣਾਉਣ ਲਈ ਆਪਣਾ ਦੇਸ਼ ਚੁਣੋ ਅਤੇ ਦੋਵੇਂ ਦਸਤਾਵੇਜ਼ ਦੇਖੋ।';

  @override
  String get google_claimDescription =>
      'ਆਪਣਾ ਮਹਿਮਾਨ ਖਾਤਾ Google ਨਾਲ ਜੋੜੋ। ਤੁਹਾਡੀ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਅਤੇ ਡੀਵਾਈਸ ਇਸ ਖਾਤੇ ਨਾਲ ਜੁੜੇ ਰਹਿਣਗੇ।';

  @override
  String get google_linkTitle => 'Google ਨੂੰ FuzeVPN ਨਾਲ ਜੋੜੋ';

  @override
  String get google_linkDescription =>
      'ਆਪਣੇ ਮੌਜੂਦਾ FuzeVPN ਖਾਤੇ ਤੱਕ ਪਹੁੰਚ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ। ਇਸ ਕਦਮ ਵਿੱਚ ਤੁਹਾਡਾ Google ਪਾਸਵਰਡ ਨਹੀਂ ਮੰਗਿਆ ਜਾਂਦਾ।';

  @override
  String get google_password => 'FuzeVPN ਪਾਸਵਰਡ';

  @override
  String get google_linkAccount => 'ਜੋੜਨ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get google_requestEmail => 'ਮੈਨੂੰ ਪੁਸ਼ਟੀ ਈਮੇਲ ਭੇਜੋ';

  @override
  String get google_emailInstructions =>
      'FuzeVPN ਦੀ ਈਮੇਲ ਖੋਲ੍ਹੋ ਅਤੇ ਪੁਸ਼ਟੀ ਕੋਡ ਦਰਜ ਕਰੋ।';

  @override
  String get google_emailCode => 'ਈਮੇਲ ਪੁਸ਼ਟੀ ਕੋਡ';

  @override
  String get google_confirmEmail => 'ਕੋਡ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get google_restart => 'ਕੋਈ ਹੋਰ Google ਖਾਤਾ ਚੁਣੋ';

  @override
  String get google_resume => 'ਇਹ ਕੋਸ਼ਿਸ਼ ਜਾਂਚੋ';

  @override
  String get google_unavailable =>
      'Google ਸਾਈਨ ਇਨ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਤੁਸੀਂ ਈਮੇਲ ਅਤੇ ਪਾਸਵਰਡ ਵਰਤ ਸਕਦੇ ਹੋ।';

  @override
  String get google_expired =>
      'ਇਸ ਕੋਸ਼ਿਸ਼ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ ਹੈ। ਇਸ ਨੂੰ ਰੱਦ ਕਰੋ ਅਤੇ ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ।';

  @override
  String get google_conflict =>
      'ਇਹ Google ਖਾਤਾ ਪਹਿਲਾਂ ਹੀ ਕਿਤੇ ਹੋਰ ਜੁੜਿਆ ਹੋਇਆ ਹੈ। ਤੁਹਾਡਾ ਮੌਜੂਦਾ ਖਾਤਾ ਅਤੇ ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਬਰਕਰਾਰ ਰੱਖੇ ਗਏ ਹਨ।';

  @override
  String get google_error =>
      'Google ਸਾਈਨ ਇਨ ਅਸਫ਼ਲ ਰਿਹਾ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ; ਤੁਹਾਡੀ ਮੌਜੂਦਾ ਪਹੁੰਚ ਬਰਕਰਾਰ ਰੱਖੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String get google_uncertain =>
      'ਨਤੀਜੇ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ। ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਇਹ ਕੋਸ਼ਿਸ਼ ਜਾਂਚੋ ਜਾਂ ਇਸ ਨੂੰ ਰੱਦ ਕਰੋ।';

  @override
  String get google_cancelFailed =>
      'ਰੱਦ ਕਰਨ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ। ਇਸ ਸਕ੍ਰੀਨ ਤੋਂ ਬਾਹਰ ਜਾਣ ਤੋਂ ਪਹਿਲਾਂ ਮੁੜ ਰੱਦ ਕਰਨ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get google_cancelled => 'Google ਸਾਈਨ ਇਨ ਰੱਦ ਕੀਤਾ ਗਿਆ।';

  @override
  String get google_selecting => 'ਆਪਣਾ Google ਖਾਤਾ ਚੁਣੋ…';

  @override
  String get google_verifying => 'ਤੁਹਾਡੇ ਖਾਤੇ ਦੀ ਜਾਂਚ ਹੋ ਰਹੀ ਹੈ…';

  @override
  String get google_emailUnavailable =>
      'ਪੁਸ਼ਟੀ ਈਮੇਲ ਭੇਜੀ ਨਹੀਂ ਜਾ ਸਕੀ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get google_emailSent =>
      'ਪੁਸ਼ਟੀ ਈਮੇਲ ਭੇਜ ਦਿੱਤੀ ਗਈ ਹੈ। ਆਪਣਾ ਇਨਬਾਕਸ ਦੇਖੋ।';

  @override
  String get google_rateLimited =>
      'ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਕਿਰਪਾ ਕਰਕੇ ਉਡੀਕ ਕਰੋ।';

  @override
  String get google_busy =>
      'ਕੋਈ ਹੋਰ ਕਾਰਵਾਈ ਜਾਰੀ ਹੋਣ ਦੌਰਾਨ (VPN ਕਨੈਕਸ਼ਨ, ਖਾਤਾ ਜਾਂ ਮਹਿਮਾਨ) Google ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਇਹ ਮੁਕੰਮਲ ਹੋਣ ਤੋਂ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ; ਤੁਹਾਡੀ ਮੌਜੂਦਾ ਪਹੁੰਚ ਬਰਕਰਾਰ ਰੱਖੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String get google_invalidPassword =>
      'FuzeVPN ਪਾਸਵਰਡ ਗ਼ਲਤ ਹੈ। ਤੁਹਾਡਾ ਮੌਜੂਦਾ ਖਾਤਾ ਬਰਕਰਾਰ ਰੱਖਿਆ ਗਿਆ ਹੈ।';

  @override
  String get google_invalidCode =>
      'ਪੁਸ਼ਟੀ ਕੋਡ ਅਵੈਧ ਹੈ ਜਾਂ ਇਸ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ ਹੈ।';

  @override
  String get google_accountChanged =>
      'ਤੁਹਾਡਾ ਸੈਸ਼ਨ ਬਦਲ ਗਿਆ ਹੈ। ਮੁੜ ਸ਼ੁਰੂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਇਹ ਕੋਸ਼ਿਸ਼ ਰੱਦ ਕਰੋ।';

  @override
  String get google_invalidResponse =>
      'ਜਵਾਬ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ। ਤੁਹਾਡੀ ਮੌਜੂਦਾ ਪਹੁੰਚ ਬਰਕਰਾਰ ਰੱਖੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String get google_invalidRegistration =>
      'ਆਪਣਾ ਦੇਸ਼ ਅਤੇ ਦੋਵੇਂ ਸਹਿਮਤੀਆਂ ਜਾਂਚੋ।';

  @override
  String get google_consentRequired =>
      'ਜਾਰੀ ਰੱਖਣ ਲਈ ਆਪਣਾ ਦੇਸ਼ ਚੁਣੋ ਅਤੇ ਦੋਵੇਂ ਦਸਤਾਵੇਜ਼ ਸਵੀਕਾਰ ਕਰੋ।';

  @override
  String get google_challengeRequired =>
      'ਇੱਕ ਵਾਧੂ ਸੁਰੱਖਿਆ ਜਾਂਚ ਦੀ ਲੋੜ ਹੈ। ਤੁਹਾਡੀ ਮੌਜੂਦਾ ਪਹੁੰਚ ਬਰਕਰਾਰ ਰੱਖੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String get google_challengeUnavailable =>
      'ਸੁਰੱਖਿਆ ਜਾਂਚ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਬਾਅਦ ਵਿੱਚ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get google_intentMismatch =>
      'ਪਿਛਲੀ Google ਸਾਈਨ ਇਨ ਕੋਸ਼ਿਸ਼ ਅਜੇ ਉਡੀਕ ਵਿੱਚ ਹੈ। ਇਹ ਕਾਰਵਾਈ ਸ਼ੁਰੂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਇਸ ਨੂੰ ਰੱਦ ਕਰੋ।';

  @override
  String get google_challengeBlocked =>
      'ਲੋੜੀਂਦੀ ਸੁਰੱਖਿਆ ਜਾਂਚ ਇਸ ਐਪ ਵਿੱਚ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਇਹ ਕਾਰਵਾਈ ਇਸ ਵੇਲੇ ਪੂਰੀ ਨਹੀਂ ਹੋ ਸਕਦੀ।';

  @override
  String get google_solveChallenge => 'ਸੁਰੱਖਿਆ ਜਾਂਚ ਪੂਰੀ ਕਰੋ';

  @override
  String get google_challengeTitle => 'ਸੁਰੱਖਿਆ ਜਾਂਚ';

  @override
  String get google_challengeReady =>
      'ਜਾਂਚ ਪੂਰੀ ਹੋ ਗਈ। ਹੁਣ ਤੁਸੀਂ ਆਪਣਾ ਖਾਤਾ ਬਣਾਉਣ ਦੀ ਪੁਸ਼ਟੀ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get google_challengeExpired =>
      'ਜਾਂਚ ਦੀ ਮਿਆਦ ਪੁੱਗ ਗਈ ਹੈ। ਪੁਸ਼ਟੀ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਇਸ ਨੂੰ ਮੁੜ ਪੂਰਾ ਕਰੋ।';

  @override
  String get google_challengeCancelled =>
      'ਜਾਂਚ ਰੱਦ ਕੀਤੀ ਗਈ। ਤੁਸੀਂ ਇਸ ਨੂੰ ਮੁੜ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get google_challengeFailed =>
      'ਸੁਰੱਖਿਆ ਜਾਂਚ ਅਸਫ਼ਲ ਰਹੀ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get billing_trialTitle => 'Fuze Premium ਮੁਫ਼ਤ ਅਜ਼ਮਾਓ';

  @override
  String get billing_trialSubtitle => 'ਅੱਜ ਤੋਂ ਹੀ ਆਪਣੇ ਕਨੈਕਸ਼ਨ ਦੀ ਸੁਰੱਖਿਆ ਕਰੋ।';

  @override
  String get billing_trialWeeks => '2 ਹਫ਼ਤਿਆਂ ਦੀ ਮੁਫ਼ਤ ਅਜ਼ਮਾਇਸ਼';

  @override
  String billing_trialDays(String days) {
    return '$days ਦਿਨਾਂ ਦੀ ਮੁਫ਼ਤ ਅਜ਼ਮਾਇਸ਼';
  }

  @override
  String get billing_trialStart => 'ਮੇਰੀ ਮੁਫ਼ਤ ਅਜ਼ਮਾਇਸ਼ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String billing_trialFirstCharge(String date) {
    return 'ਜੇ ਤੁਸੀਂ ਅੱਜ ਸ਼ੁਰੂ ਕਰਦੇ ਹੋ, ਤਾਂ ਤੁਹਾਡਾ ਪਹਿਲਾ ਚਾਰਜ $date ਨੂੰ ਲੱਗਣ ਦੀ ਉਮੀਦ ਹੈ।';
  }

  @override
  String get billing_trialTerms =>
      'ਦੱਸੀ ਗਈ ਕੀਮਤ ’ਤੇ ਆਪਣੇ-ਆਪ ਨਵਿਆਈ ਜਾਂਦੀ ਹੈ। ਚਾਰਜ ਤੋਂ ਬਚਣ ਲਈ, ਅਜ਼ਮਾਇਸ਼ ਖ਼ਤਮ ਹੋਣ ਤੋਂ ਪਹਿਲਾਂ Google Play ਵਿੱਚ ਰੱਦ ਕਰੋ।';

  @override
  String billing_trialThenMonthly(String price) {
    return 'ਫਿਰ $price ਪ੍ਰਤੀ ਮਹੀਨਾ';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'ਫਿਰ $price ਪ੍ਰਤੀ ਸਾਲ';
  }

  @override
  String get billing_choosePeriod => 'ਆਪਣਾ ਪਲਾਨ ਚੁਣੋ';

  @override
  String get billing_selectionHint => 'ਜਾਰੀ ਰੱਖਣ ਲਈ ਇੱਕ ਪਲਾਨ ਚੁਣੋ।';

  @override
  String get billing_benefitConnection => 'ਇਨਕ੍ਰਿਪਟਡ ਕਨੈਕਸ਼ਨ';

  @override
  String get billing_benefitPrivacy => 'ਆਨਲਾਈਨ ਗੋਪਨੀਯਤਾ';

  @override
  String get billing_benefitNoAccount => 'ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਦੀ ਲੋੜ ਨਹੀਂ';

  @override
  String get billing_cancellation => 'Google Play ਵਿੱਚ ਰੱਦ ਕਰੋ';

  @override
  String get billing_premiumTitle => 'ਬਿਹਤਰ ਸੁਰੱਖਿਆ ਵਾਲਾ ਕਨੈਕਸ਼ਨ।';

  @override
  String get billing_premiumSubtitle =>
      'ਆਪਣੀ ਰਫ਼ਤਾਰ ਨਾਲ ਆਪਣੇ ਕਨੈਕਸ਼ਨ ਦੀ ਸੁਰੱਖਿਆ ਕਰੋ।';

  @override
  String get billing_priceMonthly => 'ਪ੍ਰਤੀ ਮਹੀਨਾ';

  @override
  String get billing_priceYearly => 'ਪ੍ਰਤੀ ਸਾਲ';

  @override
  String get billing_trialToday => 'ਅੱਜ ਕੁਝ ਵੀ ਭੁਗਤਾਨ ਕਰਨ ਦੀ ਲੋੜ ਨਹੀਂ';

  @override
  String get billing_trialConfirmation =>
      'ਤੁਹਾਡੇ ਵੱਲੋਂ ਪੁਸ਼ਟੀ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ Google Play ਤਾਰੀਖ਼ਾਂ, ਅੰਤਿਮ ਰਕਮ ਅਤੇ ਲਾਗੂ ਟੈਕਸਾਂ ਦੀ ਪੁਸ਼ਟੀ ਕਰਦਾ ਹੈ।';

  @override
  String get billing_offerChanged =>
      'ਇਸ ਪੇਸ਼ਕਸ਼ ਦੀਆਂ ਸ਼ਰਤਾਂ ਬਦਲ ਗਈਆਂ ਹਨ। ਪਲਾਨ ਤਾਜ਼ਾ ਕਰੋ ਅਤੇ ਮੁੜ ਚੁਣੋ।';

  @override
  String get status_waitingNetwork => 'ਨੈੱਟਵਰਕ ਦੀ ਉਡੀਕ ਹੈ';

  @override
  String get status_waitingNetworkDetail =>
      'ਕੋਈ ਨੈੱਟਵਰਕ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਨੈੱਟਵਰਕ ਵਾਪਸ ਆਉਣ ’ਤੇ VPN ਕਨੈਕਸ਼ਨ ਦੀ ਜਾਂਚ ਕਰੇਗਾ।';

  @override
  String get locations_favoriteLoadFailed =>
      'ਮਨਪਸੰਦ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੇ। ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get locations_favoritesLoading => 'ਮਨਪਸੰਦ ਲੋਡ ਹੋ ਰਹੇ ਹਨ…';
}
