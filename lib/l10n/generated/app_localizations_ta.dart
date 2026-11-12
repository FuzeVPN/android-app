// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get vpnDisclosure_title => 'உங்கள் இணைப்பைப் பாதுகாக்கவும்';

  @override
  String get vpnDisclosure_body =>
      'இந்தச் சாதனத்திற்கும் FuzeVPN சர்வர்களுக்கும் இடையே குறியாக்கம் செய்யப்பட்ட சுரங்கப்பாதையை உருவாக்க FuzeVPN, Android-இன் VPN சேவையைப் (VpnService) பயன்படுத்துகிறது.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN இயக்கத்தில் இருக்கும்போது, FuzeVPN பின்னணியில் இருந்தாலும், உங்கள் பயன்பாடுகளின் இணையப் போக்குவரத்து, இலக்கு முகவரிகள் மற்றும் DNS கோரிக்கைகள் உங்கள் இணைப்பை வழிப்படுத்த இந்தச் சுரங்கப்பாதை வழியாகச் செல்லும்.';

  @override
  String get vpnDisclosure_statusBody =>
      'உங்கள் VPN இணைப்பைக் காட்ட, இணைப்பு நிலை, அதன் கால அளவு மற்றும் பரிமாற்றப்பட்ட தரவின் அளவு ஆகியவற்றை இந்தப் பயன்பாடு பயன்படுத்துகிறது. நீங்கள் எப்போது வேண்டுமானாலும் அதை நிறுத்தலாம்.';

  @override
  String get vpnDisclosure_privacy => 'தனியுரிமை';

  @override
  String get vpnDisclosure_accept => 'ஏற்றுக்கொண்டு தொடரவும்';

  @override
  String get vpnDisclosure_decline => 'இப்போது வேண்டாம்';

  @override
  String get accountRestoration_title => 'கணக்கு தற்காலிகமாகக் கிடைக்கவில்லை';

  @override
  String get accountRestoration_message =>
      'உங்கள் அமர்வு தக்கவைக்கப்பட்டுள்ளது. உங்கள் கணக்கை மீட்டெடுக்க மீண்டும் முயற்சிக்கவும்; இங்கே VPN இணைப்பைத் தொடர்ந்து நிர்வகிக்கலாம்.';

  @override
  String get action_retry => 'மீண்டும் முயற்சிக்கவும்';

  @override
  String get session_endingTitle => 'அமர்வு முடிவடைகிறது';

  @override
  String get session_ending =>
      'அமர்வு முடிவடைகிறது: VPN நிறுத்தப்படுகிறது மற்றும் சுத்தம் செய்யப்படுகிறது…';

  @override
  String get session_stopFailed =>
      'VPN நிறுத்தப்பட்டதை உறுதிப்படுத்த முடியவில்லை. மீண்டும் உள்நுழையும் முன் மறுமுயற்சி செய்யவும்.';

  @override
  String get session_cleanupFailed =>
      'VPN நிறுத்தப்பட்டது, ஆனால் அமர்வு அகற்றப்பட்டதை உறுதிப்படுத்த முடியவில்லை. சுத்தம் செய்வதை மீண்டும் முயற்சிக்கவும்.';

  @override
  String get session_retryStop => 'மீண்டும் நிறுத்த முயற்சிக்கவும்';

  @override
  String get session_retryCleanup => 'மீண்டும் சுத்தம் செய்யவும்';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN பாதுகாப்பாகத் தயாராகிறது…';

  @override
  String get nav_connection => 'இணைப்பு';

  @override
  String get nav_locations => 'இடங்கள்';

  @override
  String get nav_account => 'கணக்கு';

  @override
  String get nav_devices => 'சாதனங்கள்';

  @override
  String get nav_settings => 'அமைப்புகள்';

  @override
  String get action_refresh => 'புதுப்பிக்கவும்';

  @override
  String get auth_tab_login => 'உள்நுழையவும்';

  @override
  String get auth_tab_register => 'பதிவு செய்யவும்';

  @override
  String get auth_stepAccount => 'கணக்கு';

  @override
  String get auth_stepIdentity => 'அடையாளம்';

  @override
  String get auth_stepAddress => 'முகவரி மற்றும் ஒப்பந்தங்கள்';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'படி $current / $total';
  }

  @override
  String get auth_tagline => 'உங்கள் VPN, எளிமையாக.';

  @override
  String get auth_keysLocal =>
      'உங்கள் தனிப்பட்ட VPN விசைகள் இந்தச் சாதனத்திலேயே இருக்கும்.';

  @override
  String get form_email => 'மின்னஞ்சல் முகவரி';

  @override
  String get form_password => 'கடவுச்சொல்';

  @override
  String get form_showPassword => 'கடவுச்சொல்லைக் காட்டவும்';

  @override
  String get form_hidePassword => 'கடவுச்சொல்லை மறைக்கவும்';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 பைட்டுகள். சில எழுத்துகள் ஒன்றுக்கும் மேற்பட்ட பைட்டுகளைப் பயன்படுத்தும்.';

  @override
  String get form_firstName => 'முதல் பெயர்';

  @override
  String get form_lastName => 'கடைசிப் பெயர்';

  @override
  String get form_phone => 'தொலைபேசி (+33612345678)';

  @override
  String get form_address => 'முகவரி';

  @override
  String get form_address2 => 'முகவரி வரி 2 (விருப்பத்தேர்வு)';

  @override
  String get form_postalCode => 'அஞ்சல் குறியீடு';

  @override
  String get form_city => 'நகரம்';

  @override
  String get form_country => 'நாட்டுக் குறியீடு (எ.கா. FR)';

  @override
  String get action_login => 'உள்நுழையவும்';

  @override
  String get action_createAccount => 'கணக்கை உருவாக்கவும்';

  @override
  String get action_createMyAccount => 'எனது கணக்கை உருவாக்கவும்';

  @override
  String get action_next => 'தொடரவும்';

  @override
  String get action_previous => 'பின்செல்லவும்';

  @override
  String get action_forgotPassword => 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?';

  @override
  String get auth_noAccount => 'இன்னும் கணக்கு இல்லையா?';

  @override
  String get auth_requiredInformation =>
      'மூன்று படிகளில் உங்கள் கணக்கை உருவாக்கவும்.';

  @override
  String get auth_termsPrefix => 'நான் ஏற்கிறேன்: ';

  @override
  String get auth_termsLink => 'பயன்பாட்டு விதிமுறைகள்';

  @override
  String get auth_privacyPrefix => 'நான் ஏற்கிறேன்: ';

  @override
  String get auth_privacyLink => 'தனியுரிமைக் கொள்கை';

  @override
  String get auth_consentRequired => 'கணக்கை உருவாக்க உங்கள் ஒப்புதல் தேவை.';

  @override
  String get validation_required => 'இந்தப் புலம் தேவை.';

  @override
  String get validation_email => 'சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்.';

  @override
  String get validation_password =>
      'கடவுச்சொல் மிகக் குறுகியது: குறைந்தது 8 UTF-8 பைட்டுகள் தேவை.';

  @override
  String get validation_passwordTooLong =>
      'கடவுச்சொல் மிக நீளமானது: அதிகபட்சம் 72 UTF-8 பைட்டுகள் மட்டுமே.';

  @override
  String get validation_phone =>
      'சர்வதேச வடிவத்தைப் பயன்படுத்தவும், எடுத்துக்காட்டாக +33612345678.';

  @override
  String get validation_country =>
      'இரண்டு எழுத்துகள் கொண்ட நாட்டுக் குறியீட்டைப் பயன்படுத்தவும், எடுத்துக்காட்டாக FR.';

  @override
  String get passwordReset_title => 'கடவுச்சொல்லை மீட்டமைக்கவும்';

  @override
  String get passwordReset_description =>
      'கடவுச்சொல் மீட்டமைப்பு இணைப்பைக் கோர, உங்கள் கணக்கின் மின்னஞ்சல் முகவரியை உள்ளிடவும்.';

  @override
  String get passwordReset_send => 'இணைப்பை அனுப்பவும்';

  @override
  String get connection_title => 'உங்கள் இணைப்பு';

  @override
  String get connection_subtitle =>
      'ஓர் இடத்தைத் தேர்ந்தெடுத்து, பின்னர் உங்கள் VPN-ஐ இயக்கவும்.';

  @override
  String get connection_prepare => 'இணைக்கத் தயாரா?';

  @override
  String get connection_advancedOptions => 'மேம்பட்ட விருப்பங்கள்';

  @override
  String get connection_location => 'இடம்';

  @override
  String get connection_chooseLocation => 'ஓர் இடத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get connection_protocol => 'நெறிமுறை';

  @override
  String get connection_connect => 'இணைக்கவும்';

  @override
  String get connection_connecting => 'இணைக்கிறது…';

  @override
  String get connection_disconnect => 'துண்டிக்கவும்';

  @override
  String get connection_disconnecting => 'துண்டிக்கிறது';

  @override
  String get connection_locationChange => 'இடம் மாற்றப்படுகிறது…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol கிடைக்கவில்லை';
  }

  @override
  String get connection_activeLocation => 'செயலில் உள்ள இடம்';

  @override
  String get connection_duration => 'கால அளவு';

  @override
  String get connection_received => 'பெறப்பட்டது';

  @override
  String get connection_sent => 'அனுப்பப்பட்டது';

  @override
  String get connection_lastHandshake => 'கடைசிப் பாதுகாப்பான பரிமாற்றம்';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration முன்பு';
  }

  @override
  String get verification_title =>
      'உங்கள் மின்னஞ்சல் முகவரியை உறுதிப்படுத்தவும்';

  @override
  String get verification_message =>
      'இந்தத் தொலைபேசியில் VPN-ஐப் பயன்படுத்த உங்கள் மின்னஞ்சல் முகவரியை உறுதிப்படுத்தவும்.';

  @override
  String get verification_resend => 'மின்னஞ்சலை மீண்டும் அனுப்பவும்';

  @override
  String get migration_title => 'இட மாற்றம்';

  @override
  String get migration_draining => 'இட மாற்றம் தயாராகிறது…';

  @override
  String get migration_activating => 'புதிய சர்வர் செயல்படுத்தப்படுகிறது…';

  @override
  String get migration_ready => 'இடம் புதுப்பிக்கப்பட்டது.';

  @override
  String get migration_blocked =>
      'இட மாற்றத்திற்குச் சர்வர் தரப்பில் தலையீடு தேவை. பின்னர் மீண்டும் முயற்சிக்கவும் அல்லது ஆதரவுக் குழுவைத் தொடர்புகொள்ளவும்.';

  @override
  String get migration_progress => 'இட மாற்றத்தின் முன்னேற்றம்';

  @override
  String migration_retryDelay(Object seconds) {
    return 'சரிபார்ப்புகளுக்கு இடையிலான தாமதம்: $seconds வி.';
  }

  @override
  String get migration_resume => 'இட மாற்றத்தைத் தொடரவும்';

  @override
  String get status_authorizing => 'அனுமதி தேவை';

  @override
  String get status_authorizingDetail =>
      'VPN-ஐ அனுமதிக்க Android கோரிக்கையை ஏற்கவும்.';

  @override
  String get status_preparing => 'தயாராகிறது';

  @override
  String get status_preparingDetail => 'உங்கள் பாதுகாப்பான இணைப்பு தயாராகிறது.';

  @override
  String get status_reconnecting => 'மீண்டும் இணைக்கிறது…';

  @override
  String get status_reconnectingDetail =>
      'இணைப்பு தடைபட்டது. VPN மீண்டும் இணைக்க முயற்சிக்கிறது.';

  @override
  String get status_connecting => 'இணைக்கிறது';

  @override
  String get status_connectingDetail => 'VPN சர்வருடன் இணைக்கிறது…';

  @override
  String get status_connected => 'இணைந்தது';

  @override
  String get status_connectedDetail => 'உங்கள் VPN இணைப்பு செயலில் உள்ளது.';

  @override
  String get status_disconnecting => 'துண்டித்தல்';

  @override
  String get status_disconnectingDetail =>
      'உங்கள் VPN இணைப்பு நிறுத்தப்படுகிறது.';

  @override
  String get status_error => 'இணைப்பு இல்லை';

  @override
  String get status_errorDetail =>
      'VPN இணைப்பு உறுதிப்படுத்தப்படவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get status_idle => 'இணையவில்லை';

  @override
  String get status_idleDetail =>
      'உங்கள் இணைப்பைப் பாதுகாக்க VPN-ஐ இணைக்கவும்.';

  @override
  String get trust_note =>
      'பயன்பாட்டை மூடுவது VPN-ஐ நிறுத்தாது. அதை நிறுத்த, “துண்டிக்கவும்” என்பதைத் தட்டவும்.';

  @override
  String get locations_none => 'தற்போது இடங்கள் எதுவும் கிடைக்கவில்லை.';

  @override
  String get locations_available => 'உங்கள் அடுத்த இடத்தைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get locations_selected => 'தேர்ந்தெடுக்கப்பட்ட இடம்';

  @override
  String get locations_select => 'இந்த இடத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get locations_lockedTunnel => 'இடத்தை மாற்ற VPN-ஐ துண்டிக்கவும்.';

  @override
  String get locations_lockedMigration =>
      'இட மாற்றம் முடியும் வரை காத்திருக்கவும்.';

  @override
  String get devices_title => 'உங்கள் சாதனங்கள்';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit சாதனங்கள்';
  }

  @override
  String get devices_refresh => 'சாதனங்களைப் புதுப்பிக்கவும்';

  @override
  String get devices_empty =>
      'இன்னும் VPN சாதனம் எதுவும் பதிவு செய்யப்படவில்லை.';

  @override
  String get devices_firstConnection =>
      'முதல் இணைப்பின்போது உங்கள் தொலைபேசி சேர்க்கப்படும்.';

  @override
  String get devices_thisDevice => 'இந்தச் சாதனம்';

  @override
  String devices_added(Object date) {
    return '$date அன்று சேர்க்கப்பட்டது';
  }

  @override
  String get devices_unnamed => 'பெயரிடப்படாத சாதனம்';

  @override
  String get action_remove => 'அகற்றவும்';

  @override
  String get settings_title => 'அமைப்புகள்';

  @override
  String get settings_subtitle =>
      'உங்கள் விருப்பங்களும் கணக்கும், ஒரே இடத்தில்.';

  @override
  String get settings_appearance => 'தோற்றம்';

  @override
  String get settings_language => 'மொழி';

  @override
  String get settings_languageDescription =>
      'நீங்கள் தேர்ந்தெடுக்கும் மொழி VPN அறிவிப்புகளுக்கும் பொருந்தும்.';

  @override
  String get settings_account => 'கணக்கு';

  @override
  String get settings_signOut => 'வெளியேறவும்';

  @override
  String get settings_privacy => 'தனியுரிமைக் கொள்கை';

  @override
  String get settings_terms => 'பயன்பாட்டு விதிமுறைகள்';

  @override
  String get settings_security => 'பாதுகாப்பும் வெளிப்படைத்தன்மையும்';

  @override
  String get settings_licenses => 'கூறுகளின் உரிமங்கள்';

  @override
  String get settings_licensesDetail =>
      'பயன்பாட்டில் பயன்படுத்தப்படும் மென்பொருள்';

  @override
  String settings_licensesLegalese(String url) {
    return 'பயன்பாட்டின் மூலக் குறியீடு மற்றும் அதன் MPL-2.0 கூறுகள்: $url';
  }

  @override
  String get settings_background =>
      'பயன்பாட்டை விட்டு வெளியேறும்போதும் VPN இயக்கத்தில் இருக்கும். அதை நிறுத்த, இணைப்புத் தாவலில் உள்ள “துண்டிக்கவும்” என்பதைத் தட்டவும்.';

  @override
  String get theme_system => 'சிஸ்டம்';

  @override
  String get theme_light => 'ஒளி';

  @override
  String get theme_dark => 'இருள்';

  @override
  String get language_system => 'தொலைபேசி மொழி';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'இந்தச் சாதனத்தை அகற்றவா?';

  @override
  String get dialog_removeCurrent =>
      'இந்தத் தொலைபேசி VPN-இலிருந்து துண்டிக்கப்பட்டு அணுகலை இழக்கும். சர்வர் உறுதிப்படுத்திய பிறகு அதன் VPN இணைப்புத் தரவு அகற்றப்படும்.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name”-இன் VPN அணுகல் திரும்பப் பெறப்படும். இதைச் செயல்தவிர்க்க முடியாது.';
  }

  @override
  String get dialog_signOut => 'வெளியேறவா?';

  @override
  String get dialog_signOutMessage =>
      'VPN நிறுத்தப்படும், மீண்டும் உள்நுழைய வேண்டியிருக்கும். குறியாக்கம் செய்யப்பட்ட உங்கள் VPN விசைகள், அடுத்த இணைப்புக்காக இந்தத் தொலைபேசியிலேயே இருக்கும்.';

  @override
  String get action_cancel => 'ரத்துசெய்யவும்';

  @override
  String get action_close => 'மூடுக';

  @override
  String get action_copy => 'நகலெடு';

  @override
  String get action_renew => 'புதுப்பிக்கவும்';

  @override
  String get action_signOut => 'வெளியேறவும்';

  @override
  String get notice_close => 'செய்தியை மூடவும்';

  @override
  String get notice_sessionExpired_title => 'அமர்வு காலாவதியானது';

  @override
  String get notice_sessionExpired_message =>
      'உங்கள் அமர்வு காலாவதியானது. மீண்டும் உள்நுழையவும்.';

  @override
  String get notice_connectionFailed_title => 'இணைப்பு தோல்வியடைந்தது';

  @override
  String get notice_invalidCredentials_message =>
      'மின்னஞ்சல் முகவரி அல்லது கடவுச்சொல் தவறானது.';

  @override
  String get notice_emailVerification_title =>
      'மின்னஞ்சல் உறுதிப்படுத்தல் தேவை';

  @override
  String get notice_emailVerification_message =>
      'VPN சாதனத்தைச் சேர்ப்பதற்கு முன் உங்கள் மின்னஞ்சல் முகவரியை உறுதிப்படுத்தவும்.';

  @override
  String get notice_rateLimited_title => 'அளவுக்கு அதிகமான முயற்சிகள்';

  @override
  String get notice_deviceLimit_title => 'சாதன வரம்பு எட்டப்பட்டது';

  @override
  String get notice_deviceLimit_message =>
      'மற்றொரு சாதனத்தைச் சேர்ப்பதற்கு முன் ஏற்கனவே உள்ள ஒரு சாதனத்தை அகற்றவும்.';

  @override
  String get notice_identityRenewal_title =>
      'VPN அடையாளத்தைப் புதுப்பிக்க வேண்டும்';

  @override
  String get notice_identityRenewal_message =>
      'இந்த அடையாளம் அகற்றப்பட்டது. புதிய உள்ளூர் அடையாளத்தை உருவாக்கவும்.';

  @override
  String get notice_migrationPending_title => 'இட மாற்றம் நடைபெறுகிறது';

  @override
  String get notice_migrationPending_message =>
      'ஓர் இட மாற்றம் ஏற்கனவே நடைபெறுகிறது.';

  @override
  String get notice_migrationBlocked_title => 'இட மாற்றம் தடுக்கப்பட்டது';

  @override
  String get notice_migrationBlocked_message =>
      'இட மாற்றத்திற்குச் சர்வர் தரப்பில் தலையீடு தேவை. பின்னர் மீண்டும் முயற்சிக்கவும் அல்லது ஆதரவுக் குழுவைத் தொடர்புகொள்ளவும்.';

  @override
  String get notice_targetUnavailable_title =>
      'சர்வர் தற்காலிகமாகக் கிடைக்கவில்லை';

  @override
  String get notice_targetUnavailable_message =>
      'இந்தச் சர்வர் தற்காலிகமாகக் கிடைக்கவில்லை.';

  @override
  String get notice_networkUnavailable_title => 'இணைய இணைப்பு கிடைக்கவில்லை';

  @override
  String get notice_networkUnavailable_message =>
      'உங்கள் இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get notice_permissionDenied_title => 'VPN அனுமதி மறுக்கப்பட்டது';

  @override
  String get notice_permissionDenied_message =>
      'இணைப்பை மீண்டும் தொடங்கி, Android அனுமதிக் கோரிக்கையை ஏற்கவும்.';

  @override
  String get notice_wireguardTimeout_title => 'சர்வர் பதிலளிக்கவில்லை';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard இணைப்பு மிக நீண்ட நேரம் எடுத்தது. மீண்டும் முயற்சிக்கவும் அல்லது வேறு இடத்தைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get notice_tlsFailed_title => 'பாதுகாப்பான இணைப்பு மறுக்கப்பட்டது';

  @override
  String get notice_tlsFailed_message =>
      'சர்வர் OpenVPN இணைப்பை ஏற்கவில்லை. மீண்டும் முயற்சிக்கவும். சிக்கல் தொடர்ந்தால், கண்டறிதலை இயக்கவும்.';

  @override
  String get notice_tunRejected_title => 'VPN இடைமுகத்தை Android நிராகரித்தது';

  @override
  String get notice_tunRejected_message =>
      'OpenVPN கோரிய நெட்வொர்க் உள்ளமைவை Android நிராகரித்தது.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN தொடங்க முடியவில்லை';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN என்ஜினால் தொடங்குவதை முடிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும். சிக்கல் நீடித்தால், ஆதரவுக் குழுவைத் தொடர்புகொள்ளவும்.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'கண்டறிதல் குறியீடு: $code';
  }

  @override
  String get notice_generic_title => 'VPN இணைப்பு தோல்வியடைந்தது';

  @override
  String get notice_generic_message =>
      'ஒரு பிழை ஏற்பட்டது. பின்னர் மீண்டும் முயற்சிக்கவும்.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'கணக்கு உருவாக்கப்பட்டது',
      'password_reset_sent': 'கடவுச்சொல் மீட்டமைப்புக் கோரிக்கை பெறப்பட்டது',
      'verification_email_sent': 'சரிபார்ப்பு மின்னஞ்சல் அனுப்பப்பட்டது',
      'location_migration_pending': 'இட மாற்றம் நடைபெறுகிறது',
      'vpn_sign_in_required': 'உள்நுழைவு தேவை',
      'protocol_unavailable_at_location': 'நெறிமுறை கிடைக்கவில்லை',
      'vpn_permission_denied': 'VPN அனுமதி மறுக்கப்பட்டது',
      'revoked_identity_device_limit': 'சாதன வரம்பு எட்டப்பட்டது',
      'tunnel_start_unexpected': 'VPN தொடங்க முடியவில்லை',
      'flutter_disconnect_timeout': 'துண்டிப்பு உறுதிப்படுத்தப்படவில்லை',
      'flutter_disconnect_unexpected': 'துண்டிக்க முடியவில்லை',
      'device_revoked': 'சாதனம் அகற்றப்பட்டது',
      'revoke_unexpected': 'சாதனத்தை அகற்ற முடியவில்லை',
      'identity_renewal_unexpected': 'அடையாளத்தைப் புதுப்பிக்க முடியவில்லை',
      'openvpn_renewal_unexpected': 'OpenVPN-ஐப் புதுப்பிக்க முடியவில்லை',
      'location_migration_blocked': 'இட மாற்றம் தடுக்கப்பட்டது',
      'location_migration_slow': 'இட மாற்றம் இன்னும் நடைபெறுகிறது',
      'location_migration_conflict': 'இட மாற்றத்தைப் புதுப்பிக்க வேண்டும்',
      'location_migration_verification_failed':
          'இட மாற்றம் உறுதிப்படுத்தப்படவில்லை',
      'location_migration_device_changed': 'இட மாற்றத்தின்போது சாதனம் மாறியது',
      'tunnel_stop_failed': 'இட மாற்றம் கிடைக்கவில்லை',
      'device_clock_ahead': 'சாதனக் கடிகாரம் முன்னதாக உள்ளது',
      'other': 'செயல்பாடு தோல்வியடைந்தது',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'கணக்கு உருவாக்கப்பட்டது, ஆனால் சரிபார்ப்பு மின்னஞ்சலை அனுப்ப முடியவில்லை. பயன்பாட்டில் “மின்னஞ்சலை மீண்டும் அனுப்பவும்” என்பதைத் தட்டவும்.',
      'password_reset_sent':
          'உங்கள் கோரிக்கை பெறப்பட்டது. இந்த முகவரியுடன் ஒரு கணக்கு பொருந்தினால், உங்களுக்கு மின்னஞ்சல் வரலாம். ஸ்பேம் கோப்புறையையும் சரிபார்க்கவும்.',
      'verification_email_sent':
          'புதிய சரிபார்ப்பு மின்னஞ்சல் இப்போதுதான் அனுப்பப்பட்டது.',
      'location_migration_pending':
          '$target-க்கான இட மாற்றம் இன்னும் தயாராகிக்கொண்டிருக்கிறது. சாதனத்தை மீண்டும் உருவாக்காமல் அதைத் தொடரலாம்.',
      'vpn_sign_in_required':
          'VPN-ஐத் தொடங்குவதற்கு முன் உங்கள் கணக்கில் உள்நுழையவும்.',
      'protocol_unavailable_at_location':
          'தேர்ந்தெடுக்கப்பட்ட நெறிமுறை இந்த இடத்தில் வழங்கப்படவில்லை. இடங்களைப் புதுப்பிக்கவும் அல்லது வேறு நெறிமுறையைத் தேர்ந்தெடுக்கவும்.',
      'vpn_permission_denied':
          'VPN அனுமதியை Android மறுத்துவிட்டது. இணைப்பை மீண்டும் தொடங்கி, சிஸ்டம் கோரிக்கையை ஏற்கவும்.',
      'revoked_identity_device_limit':
          'இந்தச் சாதனத்தின் VPN அணுகல் அகற்றப்பட்டது, சாதன வரம்பும் எட்டப்பட்டுவிட்டது. கணக்கு → “எனது சாதனங்களை நிர்வகிக்கவும்” என்பதன் கீழ் ஒரு சாதனத்தை அகற்றவும்.',
      'tunnel_start_unexpected':
          'எதிர்பாராத பிழையால் சுரங்கப்பாதை தயாரிப்பு தடைபட்டது. கண்டறிதல் குறியீட்டைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.',
      'flutter_disconnect_timeout':
          'நேரத்திற்குள் VPN நின்றதை Android உறுதிப்படுத்தவில்லை. மீண்டும் நிறுத்த முயற்சிக்கவும்.',
      'flutter_disconnect_unexpected':
          'எதிர்பாராத பிழையால் சுரங்கப்பாதை நின்றதை உறுதிப்படுத்த முடியவில்லை.',
      'device_revoked':
          'சாதனத்தின் VPN அணுகல் திரும்பப் பெறப்பட்டது, அதன் உள்ளூர் ரகசியத் தரவுகள் அகற்றப்பட்டன.',
      'revoke_unexpected':
          'சாதனத்தை அகற்ற முடியவில்லை. பட்டியலைப் புதுப்பித்து மீண்டும் முயற்சிக்கவும்.',
      'identity_renewal_unexpected':
          'புதிய VPN அடையாளத்தை உருவாக்க முடியவில்லை. சாதனங்களைப் புதுப்பித்து மீண்டும் முயற்சிக்கவும்.',
      'openvpn_renewal_unexpected':
          'OpenVPN சுயவிவரத்தைப் புதுப்பிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும் அல்லது கண்டறிதல் குறியீட்டைச் சரிபார்க்கவும்.',
      'location_migration_blocked':
          'இந்த மாற்றத்தைச் சர்வரால் இப்போது முடிக்க முடியவில்லை. சாதனமும் அதன் உள்ளூர் அடையாளமும் தக்கவைக்கப்பட்டுள்ளன.',
      'location_migration_slow':
          '$target-க்கான இட மாற்றத்தைச் சர்வர் இன்னும் தயாரிக்கிறது. சிறிது நேரம் கழித்து “இட மாற்றத்தைத் தொடரவும்” என்பதைத் தட்டவும்.',
      'location_migration_conflict':
          'சர்வரில் சாதனத்தின் நிலை மாறிவிட்டது. சாதனங்களைப் புதுப்பித்து, பின்னர் மாற்றத்தைத் தொடரவும்.',
      'location_migration_verification_failed':
          'புதிய இடத்தைச் சர்வர் உறுதிப்படுத்தவில்லை. முந்தைய உள்ளூர் அடையாளம் தக்கவைக்கப்பட்டது.',
      'location_migration_device_changed':
          'சர்வர் திருப்பி அனுப்பிய சாதனம், மாற்றப்படும் சாதனத்துடன் இனி பொருந்தவில்லை. மீண்டும் முயற்சிக்கும் முன் சாதனங்களைப் புதுப்பிக்கவும்.',
      'tunnel_stop_failed':
          'புதிய இணைப்புக்கு முன், முந்தைய சுரங்கப்பாதை முழுமையாக நிறுத்தப்பட வேண்டும்.',
      'device_clock_ahead':
          'இந்தச் சாதனத்தின் கடிகாரம் முன்னதாக இருப்பதாகத் தெரிகிறது. உள்நுழைந்திருக்க, தானியங்கி தேதி மற்றும் நேரத்தை இயக்கவும்.',
      'other':
          'செயல்பாட்டை முடிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும் அல்லது கண்டறிதல் குறியீட்டை ஆதரவுக் குழுவுக்கு அனுப்பவும்.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'அமர்வு காலாவதியானது',
      'invalid_credentials': 'உள்நுழைவு தோல்வியடைந்தது',
      'email_verification_required': 'மின்னஞ்சல் உறுதிப்படுத்தல் தேவை',
      'verification_email_cooldown': 'மின்னஞ்சல் ஏற்கனவே அனுப்பப்பட்டது',
      'rate_limited': 'அளவுக்கு அதிகமான முயற்சிகள்',
      'invalid_registration': 'தகவலைத் திருத்த வேண்டும்',
      'email_exists': 'கணக்கு ஏற்கனவே உள்ளது',
      'invalid_profile': 'சுயவிவரம் தவறானது',
      'invalid_device': 'சாதனம் தவறானது',
      'invalid_location': 'இடம் கிடைக்கவில்லை',
      'device_limit': 'சாதன வரம்பு எட்டப்பட்டது',
      'device_exists': 'VPN அடையாளம் ஏற்கனவே பயன்பாட்டில் உள்ளது',
      'device_identity_revoked': 'VPN அடையாளத்தைப் புதுப்பிக்க வேண்டும்',
      'device_location_locked': 'இட மாற்றத்தைப் புதுப்பிக்க வேண்டும்',
      'location_migration_pending': 'இட மாற்றம் நடைபெறுகிறது',
      'location_migration_blocked': 'இட மாற்றம் தடுக்கப்பட்டது',
      'target_ca_mismatch': 'பொருந்தாத OpenVPN சர்வர்',
      'location_migration_conflict': 'இட மாற்றத்தைப் புதுப்பிக்க வேண்டும்',
      'server_full': 'சர்வர் நிரம்பிவிட்டது',
      'capacity_unavailable': 'இடம் தற்காலிகமாகக் கிடைக்கவில்லை',
      'target_unavailable': 'சர்வர் தற்காலிகமாகக் கிடைக்கவில்லை',
      'not_found': 'உருப்படி கிடைக்கவில்லை',
      'invalid_openvpn_csr': 'OpenVPN அடையாளம் தவறானது',
      'openvpn_profile_exists': 'OpenVPN சுயவிவரம் ஏற்கனவே உள்ளது',
      'openvpn_profile_revoked': 'OpenVPN சுயவிவரம் திரும்பப் பெறப்பட்டது',
      'openvpn_operation_pending': 'OpenVPN செயல்பாடு நடைபெறுகிறது',
      'openvpn_operation_terminal': 'OpenVPN செயல்பாடு தடைபட்டது',
      'openvpn_address_unavailable': 'OpenVPN முகவரி கிடைக்கவில்லை',
      'openvpn_profile_conflict': 'OpenVPN முரண்பாடு',
      'openvpn_signer_unavailable': 'OpenVPN கிடைக்கவில்லை',
      'email_delivery_unavailable': 'மின்னஞ்சல் சேவை கிடைக்கவில்லை',
      'invalid_token': 'தவறான இணைப்பு',
      'network_unavailable': 'இணைய இணைப்பு கிடைக்கவில்லை',
      'invalid_json': 'தவறான கோரிக்கை',
      'invalid_api_response': 'தவறான சர்வர் பதில்',
      'ipv6_unavailable': 'IPv6 கிடைக்கவில்லை',
      'invalid_ip_families': 'நெட்வொர்க் உள்ளமைவு நிராகரிக்கப்பட்டது',
      'other': 'சேவை கிடைக்கவில்லை',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'உங்கள் அமர்வு காலாவதியானது. மீண்டும் உள்நுழையவும்.',
      'invalid_credentials': 'மின்னஞ்சல் முகவரி அல்லது கடவுச்சொல் தவறானது.',
      'email_verification_required':
          'VPN சாதனத்தைச் சேர்ப்பதற்கு முன் உங்கள் மின்னஞ்சல் முகவரியை உறுதிப்படுத்தவும்.',
      'invalid_registration':
          'கோரப்பட்ட தகவல்களையும் ஒப்புதல்களையும் சரிபார்க்கவும்.',
      'email_exists':
          'இந்த மின்னஞ்சல் முகவரியைப் பயன்படுத்தும் கணக்கு ஏற்கனவே உள்ளது.',
      'invalid_profile': 'உங்கள் சுயவிவரத் தகவலைச் சரிபார்க்கவும்.',
      'invalid_device':
          'இந்தச் சாதனத்தின் பெயர் அல்லது உள்ளூர் அடையாளம் தவறானது.',
      'invalid_location':
          'இடப் பட்டியலைப் புதுப்பித்து மீண்டும் முயற்சிக்கவும்.',
      'device_limit':
          'மற்றொரு சாதனத்தைச் சேர்ப்பதற்கு முன் ஏற்கனவே உள்ள ஒரு சாதனத்தை அகற்றவும்.',
      'device_exists':
          'இந்த VPN அடையாளம் ஏற்கனவே வேறொரு கணக்குடன் இணைக்கப்பட்டுள்ளது.',
      'device_identity_revoked':
          'இந்த அடையாளம் அகற்றப்பட்டுள்ளது. புதிய உள்ளூர் அடையாளத்தை உருவாக்க வேண்டும்.',
      'device_location_locked':
          'இந்தச் சாதனத்தின் இடம் இப்போதுதான் மாறியுள்ளது. நடைபெறும் இட மாற்றத்தைப் பயன்பாடு தொடரும்.',
      'location_migration_pending': 'ஓர் இட மாற்றம் ஏற்கனவே நடைபெறுகிறது.',
      'location_migration_blocked':
          'இட மாற்றத்திற்குச் சர்வர் தரப்பில் தலையீடு தேவை. பின்னர் மீண்டும் முயற்சிக்கவும் அல்லது ஆதரவுக் குழுவைத் தொடர்புகொள்ளவும்.',
      'target_ca_mismatch':
          'இந்தச் சர்வர் தற்போதைய OpenVPN சுயவிவரத்துடன் இன்னும் பொருந்தவில்லை.',
      'location_migration_conflict':
          'சாதனங்களைப் புதுப்பித்த பிறகு இட மாற்றத்தை மீண்டும் முயற்சிக்கவும்.',
      'server_full':
          'இந்த இடம் இணைப்பு வரம்பை எட்டிவிட்டது. வேறொரு இடத்தைத் தேர்ந்தெடுக்கவும் அல்லது பின்னர் மீண்டும் முயற்சிக்கவும்.',
      'capacity_unavailable':
          'இந்த இடம் இப்போது கிடைக்கிறதா என்பதை உறுதிப்படுத்த முடியவில்லை. வேறொரு இடத்தைத் தேர்ந்தெடுக்கவும் அல்லது பின்னர் மீண்டும் முயற்சிக்கவும்.',
      'target_unavailable': 'இந்தச் சர்வர் தற்காலிகமாகக் கிடைக்கவில்லை.',
      'not_found': 'இந்த உருப்படி இனி உங்கள் கணக்கில் கிடைக்கவில்லை.',
      'invalid_openvpn_csr':
          'புதிய OpenVPN அடையாளத்தை உருவாக்கி மீண்டும் முயற்சிக்கவும்.',
      'openvpn_profile_exists':
          'இந்தச் சாதனத்திற்கு ஏற்கனவே ஒரு OpenVPN சுயவிவரம் உள்ளது.',
      'openvpn_profile_revoked': 'தொடர OpenVPN சுயவிவரத்தைப் புதுப்பிக்கவும்.',
      'openvpn_operation_pending':
          'மாற்றம் இன்னும் பரவிக்கொண்டிருக்கிறது. பின்னர் மீண்டும் முயற்சிக்கவும்.',
      'openvpn_operation_terminal':
          'புதிய OpenVPN அடையாளத்தை உருவாக்கி மீண்டும் முயற்சிக்கவும்.',
      'openvpn_address_unavailable':
          'தற்போது OpenVPN முகவரி எதுவும் கிடைக்கவில்லை.',
      'openvpn_profile_conflict':
          'சுயவிவரம் மாறிவிட்டது. சாதனங்களைப் புதுப்பித்து மீண்டும் முயற்சிக்கவும்.',
      'openvpn_signer_unavailable': 'OpenVPN சேவை தற்காலிகமாகக் கிடைக்கவில்லை.',
      'email_delivery_unavailable':
          'மின்னஞ்சலை அனுப்ப முடியவில்லை. பின்னர் மீண்டும் முயற்சிக்கவும்.',
      'invalid_token':
          'இந்த இணைப்பு தவறானது அல்லது காலாவதியாகிவிட்டது. புதியதைக் கோரவும்.',
      'network_unavailable':
          'உங்கள் இணைய இணைப்பைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.',
      'invalid_json': 'உள்ளிட்ட தகவலைச் சரிபார்த்து மீண்டும் முயற்சிக்கவும்.',
      'invalid_api_response':
          'சர்வர் எதிர்பாராத பதிலை அனுப்பியது. பின்னர் மீண்டும் முயற்சிக்கவும்.',
      'ipv6_unavailable':
          'சர்வரால் இப்போது IPv6-ஐ இயக்க முடியவில்லை. பின்னர் மீண்டும் முயற்சிக்கவும்.',
      'invalid_ip_families':
          'சுரங்கப்பாதை உள்ளமைவு முழுமையடையவில்லை அல்லது அங்கீகரிக்கப்பட்ட முகவரிகளுடன் பொருந்தவில்லை. பயன்பாட்டிலிருந்து மீண்டும் முயற்சிக்கவும்.',
      'other': 'சர்வர் பிழை ஏற்பட்டது. பின்னர் மீண்டும் முயற்சிக்கவும்.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'சில கணங்களில் மீண்டும் முயற்சிக்கவும்.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds வினாடிகளில் மீண்டும் முயற்சிக்கவும்.',
      one: '$seconds வினாடியில் மீண்டும் முயற்சிக்கவும்.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes நிமிடங்களில் மீண்டும் முயற்சிக்கவும்.',
      one: '$minutes நிமிடத்தில் மீண்டும் முயற்சிக்கவும்.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours மணி நேரங்களில் மீண்டும் முயற்சிக்கவும்.',
      one: '$hours மணி நேரத்தில் மீண்டும் முயற்சிக்கவும்.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'சிஸ்டம் VPN மீண்டும் தொடர்தல் கிடைக்கவில்லை',
      'system_vpn_resume_corrupt': 'தவறான சிஸ்டம் VPN மீண்டும் தொடர்தல்',
      'system_vpn_resume_session_invalid':
          'VPN மீண்டும் தொடர்தல் அமர்வு தவறானது',
      'system_vpn_resume_identity_changed': 'VPN அடையாளம் மாறிவிட்டது',
      'system_vpn_resume_identity_invalid':
          'VPN மீண்டும் தொடர்தல் அடையாளம் தவறானது',
      'system_vpn_resume_storage_failed':
          'VPN மீண்டும் தொடர்தல் சேமிப்பகம் கிடைக்கவில்லை',
      'system_vpn_resume_network_timeout': 'VPN மீண்டும் தொடர நெட்வொர்க் இல்லை',
      'system_vpn_resume_blocked': 'VPN மீண்டும் தொடர்தல் தடுக்கப்பட்டது',
      'system_vpn_resume_failed': 'VPN மீண்டும் தொடர்தல் தோல்வியடைந்தது',
      'system_vpn_resume_error_invalid': 'தவறான VPN மீண்டும் தொடர்தல் பிழை',
      'wireguard_identity_store_failed': 'WireGuard அடையாளம் சேமிக்கப்படவில்லை',
      'wireguard_identity_unavailable': 'WireGuard அடையாளம் கிடைக்கவில்லை',
      'vpn_host_destroyed': 'Android VPN ஹோஸ்ட் நிறுத்தப்பட்டது',
      'vpn_host_unavailable': 'Android VPN ஹோஸ்ட் கிடைக்கவில்லை',
      'vpn_permission_required': 'VPN அனுமதி தேவை',
      'vpn_permission_denied': 'VPN அனுமதி மறுக்கப்பட்டது',
      'vpn_permission_request_failed': 'அனுமதியைக் கோர முடியவில்லை',
      'wireguard_foreground_service_unavailable':
          'WireGuard சேவை கிடைக்கவில்லை',
      'wireguard_identity_invalid': 'உள்ளூர் WireGuard விசை தவறானது',
      'wireguard_identity_in_use':
          'WireGuard அடையாளம் ஏற்கனவே பயன்பாட்டில் உள்ளது',
      'wireguard_configuration_invalid': 'தவறான WireGuard உள்ளமைவு',
      'wireguard_operation_pending':
          'WireGuard செயல்பாடு இன்னும் இயக்கத்தில் உள்ளது',
      'wireguard_start_failed': 'WireGuard தொடக்கம் நிராகரிக்கப்பட்டது',
      'wireguard_stop_timeout': 'WireGuard நிறுத்தம் உறுதிப்படுத்தப்படவில்லை',
      'wireguard_handshake_timeout': 'WireGuard பதிலளிக்கவில்லை',
      'openvpn_connection_timeout': 'OpenVPN பதிலளிக்கவில்லை',
      'openvpn_core_unavailable': 'OpenVPN என்ஜின் கிடைக்கவில்லை',
      'openvpn_operation_pending': 'OpenVPN அமர்வு இன்னும் இயக்கத்தில் உள்ளது',
      'openvpn_stop_timeout': 'OpenVPN நிறுத்தம் உறுதிப்படுத்தப்படவில்லை',
      'openvpn_profile_unavailable': 'உள்ளூர் OpenVPN சுயவிவரம் இல்லை',
      'openvpn_native_failed': 'நேட்டிவ் OpenVPN அழைப்பு தடைபட்டது',
      'openvpn_key_generation_failed':
          'OpenVPN P-256 விசையை உருவாக்க முடியவில்லை',
      'openvpn_csr_generation_failed': 'OpenVPN CSR-ஐ உருவாக்க முடியவில்லை',
      'openvpn_identity_store_failed': 'OpenVPN அடையாளம் சேமிக்கப்படவில்லை',
      'openvpn_identity_clear_failed': 'OpenVPN அகற்றுதல் முழுமையடையவில்லை',
      'openvpn_identity_in_use': 'OpenVPN அடையாளம் இன்னும் பயன்பாட்டில் உள்ளது',
      'openvpn_tls_verification_required': 'OpenVPN TLS சரிபார்ப்பு இல்லை',
      'openvpn_cipher_invalid': 'தவறான OpenVPN குறியாக்க வழிமுறை',
      'openvpn_profile_rejected': 'OpenVPN சுயவிவரம் நிராகரிக்கப்பட்டது',
      'openvpn_identity_inconsistent': 'பொருந்தாத OpenVPN அடையாளம்',
      'tls_handshake_failed': 'OpenVPN பேச்சுவார்த்தை நிராகரிக்கப்பட்டது',
      'tls_alert_unknown_ca':
          'OpenVPN கிளையன்ட் சான்றிதழ் அடையாளம் காணப்படவில்லை',
      'tls_alert_bad_certificate':
          'OpenVPN கிளையன்ட் சான்றிதழ் நிராகரிக்கப்பட்டது',
      'tls_alert_unsupported_certificate': 'ஆதரிக்கப்படாத OpenVPN சான்றிதழ்',
      'tls_client_certificate_required': 'OpenVPN கிளையன்ட் சான்றிதழ் தேவை',
      'tls_alert_misc': 'OpenVPN TLS எச்சரிக்கை',
      'tls_signature_algorithm_rejected': 'ஆதரிக்கப்படாத OpenVPN கையொப்பம்',
      'tls_handshake_rejected': 'OpenVPN TLS பேச்சுவார்த்தை நிராகரிக்கப்பட்டது',
      'tls_version_rejected': 'பொருந்தாத OpenVPN TLS பதிப்பு',
      'tls_certificate_expired': 'TLS சான்றிதழ் காலாவதியானது',
      'tls_certificate_revoked': 'TLS சான்றிதழ் திரும்பப் பெறப்பட்டது',
      'transport_failed': 'OpenVPN சர்வரை அடைய முடியவில்லை',
      'tun_configuration_rejected': 'OpenVPN இடைமுகத்தை உருவாக்க முடியவில்லை',
      'tun_setup_failed': 'OpenVPN TUN அமைப்பு தோல்வியடைந்தது',
      'tun_interface_create_failed': 'OpenVPN இடைமுக உருவாக்கம் தோல்வியடைந்தது',
      'tun_interface_disabled': 'OpenVPN இடைமுகம் முடக்கப்பட்டது',
      'tun_halted': 'OpenVPN இடைமுகம் தடைபட்டது',
      'tun_already_established': 'OpenVPN இடைமுகம் ஏற்கனவே திறந்துள்ளது',
      'tun_addresses_missing': 'OpenVPN முகவரி இல்லை',
      'tun_routes_missing': 'OpenVPN வழித்தடங்கள் இல்லை',
      'tun_dns_missing': 'OpenVPN DNS இல்லை',
      'tun_permission_revoked': 'VPN அனுமதி திரும்பப் பெறப்பட்டது',
      'tun_establish_returned_null': 'VPN இடைமுகத்தை Android நிராகரித்தது',
      'openvpn_service_start_failed': 'OpenVPN சேவை கிடைக்கவில்லை',
      'openvpn_operation_timeout': 'OpenVPN அழைப்பு நேரம் கடந்தது',
      'openvpn_start_failed': 'OpenVPN தொடக்கம் நிராகரிக்கப்பட்டது',
      'openvpn_connection_failed': 'OpenVPN இணைப்பு தடைபட்டது',
      'openvpn_core_status_error': 'OpenVPN மையக்கூறு பிழையுடன் முடிவடைந்தது',
      'openvpn_stopped_before_connected':
          'இணைவதற்கு முன் OpenVPN நின்றுவிட்டது',
      'openvpn_auth_failed': 'OpenVPN அங்கீகாரம் நிராகரிக்கப்பட்டது',
      'openvpn_client_setup_failed': 'OpenVPN கிளையன்ட் அமைப்பு தோல்வியடைந்தது',
      'openvpn_client_halted': 'OpenVPN கிளையன்ட் தடைபட்டது',
      'openvpn_client_restart': 'OpenVPN மறுதொடக்கம் கோரப்பட்டது',
      'openvpn_inactive_timeout': 'OpenVPN நீண்ட நேரம் செயலற்று உள்ளது',
      'openvpn_session_expired': 'OpenVPN அமர்வு காலாவதியானது',
      'openvpn_credentials_required': 'ஆதரிக்கப்படாத OpenVPN அங்கீகாரம்',
      'openvpn_proxy_failed': 'OpenVPN இடைநிலைப் போக்குவரத்து தோல்வியடைந்தது',
      'openvpn_compression_failed': 'OpenVPN சுருக்கம் நிராகரிக்கப்பட்டது',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM குறியாக்கம் கிடைக்கவில்லை',
      'openvpn_feature_unsupported': 'ஆதரிக்கப்படாத OpenVPN அம்சம்',
      'network_unavailable': 'இணைய இணைப்பு கிடைக்கவில்லை',
      'network_lost': 'நெட்வொர்க் கிடைக்கவில்லை',
      'certificate_validation_failed': 'சர்வர் சான்றிதழ் நிராகரிக்கப்பட்டது',
      'openvpn_certificate_expired': 'OpenVPN சான்றிதழ் காலாவதியானது',
      'tunnel_active_for_another_account':
          'மற்றொரு கணக்கின் சுரங்கப்பாதை இன்னும் இயக்கத்தில் உள்ளது',
      'tunnel_already_active':
          'நேட்டிவ் சுரங்கப்பாதை ஏற்கனவே இயக்கத்தில் உள்ளது',
      'tunnel_stop_timeout': '$protocol நிறுத்தம் உறுதிப்படுத்தப்படவில்லை',
      'tunnel_disconnected': '$protocol இணைப்பு தடைபட்டது',
      'native_bridge_unavailable': 'Android பாலம் கிடைக்கவில்லை',
      'native_operation_failed': 'Android செயல்பாடு தடைபட்டது',
      'invalid_arguments': 'VPN அளவுருக்கள் முழுமையடையவில்லை',
      'invalid_account_id': 'தவறான VPN கணக்கு',
      'invalid_device_id': 'தவறான சாதன அடையாளங்காட்டி',
      'storage_key_not_allowed': 'சேமிப்பக விசை நிராகரிக்கப்பட்டது',
      'secure_storage_read_failed': 'பாதுகாப்பான வாசிப்பு தோல்வியடைந்தது',
      'secure_storage_write_failed': 'பாதுகாப்பான எழுதுதல் தோல்வியடைந்தது',
      'key_generation_failed': 'WireGuard விசையை உருவாக்க முடியவில்லை',
      'csr_generation_failed': 'OpenVPN CSR-ஐ உருவாக்க முடியவில்லை',
      'openvpn_recovery_exhausted': 'OpenVPN மீட்பு ஏற்கனவே பயன்படுத்தப்பட்டது',
      'openvpn_recovery_failed': 'OpenVPN மீட்பு தோல்வியடைந்தது',
      'openvpn_renewal_required': 'OpenVPN சான்றிதழைப் புதுப்பிக்க வேண்டும்',
      'other': 'வகைப்படுத்தப்படாத நேட்டிவ் VPN பிழை',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'மீண்டும் தொடரக்கூடிய VPN அமர்வை Android-ஆல் கண்டறிய முடியவில்லை. பயன்பாட்டில் புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_corrupt':
          'சேமிக்கப்பட்ட VPN மீண்டும் தொடர்தல் தரவு தவறானது, அது பயன்படுத்தப்படாது. புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_session_invalid':
          'சேமிக்கப்பட்ட அமர்வால் இனி VPN-ஐ மீண்டும் தொடர முடியாது. பயன்பாட்டில் மீண்டும் உள்நுழையவும்.',
      'system_vpn_resume_identity_changed':
          'உள்ளூர் VPN அடையாளம் மாறிவிட்டது. மீண்டும் தொடர்தல் நிறுத்தப்பட்டது. புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_identity_invalid':
          'மீண்டும் தொடர்வதற்கான அடையாளம் தவறானது. புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_storage_failed':
          'குறியாக்கம் செய்யப்பட்ட மீண்டும் தொடர்தல் தரவைப் படிக்கவோ புதுப்பிக்கவோ Android-ஆல் முடியவில்லை. புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_network_timeout':
          'நேரத்திற்குள் VPN-ஐ மீண்டும் தொடர நெட்வொர்க்கை Android-ஆல் கண்டறிய முடியவில்லை. நெட்வொர்க் கிடைக்கும்போது மீண்டும் முயற்சிக்கவும்.',
      'system_vpn_resume_blocked':
          'VPN மீண்டும் தொடர்தல் தடுக்கப்பட்டுள்ளது. Android அமைப்புகளைச் சரிபார்த்து, பின்னர் புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_failed':
          'Android VPN மீண்டும் தொடர்தல் தோல்வியடைந்தது. பயன்பாட்டில் புதிய இணைப்பைத் தொடங்கவும்.',
      'system_vpn_resume_error_invalid':
          'Android திருப்பி அனுப்பிய மீண்டும் தொடர்தல் பிழை பயன்படுத்த முடியாததாக உள்ளது. புதிய இணைப்பைத் தொடங்கவும்.',
      'wireguard_identity_store_failed':
          'இந்தக் கணக்கின் குறியாக்கம் செய்யப்பட்ட WireGuard அடையாளத்தை Android-ஆல் சேமிக்க முடியவில்லை.',
      'wireguard_identity_unavailable':
          'இந்த இணைப்புக்குப் பயன்படுத்தக்கூடிய WireGuard அடையாளம் எதுவும் கிடைக்கவில்லை.',
      'vpn_host_destroyed':
          'VPN-ஐ இயக்கும் Android கூறு நிறுத்தப்பட்டது. புதிய இணைப்பைத் தொடங்கவும்.',
      'vpn_host_unavailable':
          'VPN-ஐ இயக்கும் கூறை Android-ஆல் உருவாக்க முடியவில்லை. VPN அமைப்புகளைச் சரிபார்த்த பிறகு மீண்டும் முயற்சிக்கவும்.',
      'openvpn_renewal_required':
          'OpenVPN சான்றிதழைத் தானாகப் புதுப்பிக்க முடியவில்லை. பயன்பாட்டில் புதிய இணைப்பைத் தொடங்கவும்.',
      'openvpn_recovery_failed':
          'தானியங்கி மீட்பு தோல்வியடைந்தது. பயன்பாட்டில் புதிய இணைப்பைத் தொடங்கவும்.',
      'openvpn_recovery_exhausted':
          'தானியங்கி மீட்பு ஏற்கனவே பயன்படுத்தப்பட்டுவிட்டது. பயன்பாட்டில் புதிய இணைப்பைத் தொடங்கவும்.',
      'vpn_permission_required':
          'சுரங்கப்பாதையைத் தொடங்கும் முன் Android புதிய VPN அனுமதியைக் கோருகிறது.',
      'vpn_permission_denied':
          'தொடர Android கோரிக்கையில் FuzeVPN-ஐ அனுமதிக்கவும்.',
      'vpn_permission_request_failed':
          'VPN அனுமதித் திரையை Android-ஆல் திறக்க முடியவில்லை.',
      'wireguard_foreground_service_unavailable':
          'WireGuard சேவையை முன்னணியில் வைத்திருக்க Android-ஆல் முடியவில்லை.',
      'wireguard_identity_invalid':
          'இந்தக் கணக்கின் குறியாக்கம் செய்யப்பட்ட WireGuard விசை படிக்க முடியாததாக அல்லது தவறானதாக உள்ளது.',
      'wireguard_identity_in_use':
          'இந்தக் கணக்கின் WireGuard விசையை இன்னொரு செயல்பாடு இன்னும் பயன்படுத்துகிறது.',
      'wireguard_configuration_invalid':
          'பெறப்பட்ட WireGuard முகவரி, DNS, சர்வர் விசை அல்லது வழித்தடங்கள் தவறானவை.',
      'wireguard_operation_pending':
          'முந்தைய WireGuard செயல்பாடு அதன் நேட்டிவ் சேவையை இன்னும் விடுவிக்கவில்லை.',
      'wireguard_start_failed':
          'WireGuard என்ஜின் உள்ளமைவைச் செயல்படுத்துவதை நிராகரித்தது.',
      'wireguard_stop_timeout':
          'WireGuard சேவை நேர வரம்பிற்குள் VPN இடைமுகத்தின் விடுவிப்பை உறுதிப்படுத்தவில்லை.',
      'wireguard_handshake_timeout':
          'நேர வரம்பிற்குள் சர்வருடனான கைகுலுக்கலைச் சுரங்கப்பாதை உறுதிப்படுத்தவில்லை.',
      'openvpn_connection_timeout':
          'நேர வரம்பிற்குள் சர்வருடனான இணைப்பை OpenVPN உறுதிப்படுத்தவில்லை.',
      'openvpn_core_unavailable':
          'இந்தப் பயன்பாட்டுப் பதிப்பில் பயன்படுத்தக்கூடிய OpenVPN என்ஜின் இல்லை.',
      'openvpn_operation_pending':
          'நேட்டிவ் என்ஜின் முந்தைய OpenVPN அமர்வை இன்னும் வைத்திருக்கிறது; இரண்டாவது அமர்வை உருவாக்க மறுக்கிறது.',
      'openvpn_stop_timeout':
          'நேர வரம்பிற்குள் அதன் நேட்டிவ் அமர்வு நின்று அழிக்கப்பட்டதை OpenVPN மையக்கூறு உறுதிப்படுத்தவில்லை.',
      'openvpn_profile_unavailable':
          'இந்த இணைப்புக்குச் சரிபார்க்கப்பட்ட OpenVPN சுயவிவரத்தைப் படிக்க முடியவில்லை.',
      'openvpn_native_failed':
          'பயன்பாட்டுப் பிழையால் OpenVPN தடைபட்டது. மீண்டும் இணைக்க முயற்சிக்கவும். சிக்கல் தொடர்ந்தால் கண்டறிதலை இயக்கவும்.',
      'openvpn_key_generation_failed':
          'ஏற்றுமதி செய்ய இயலாத P-256 தனிப்பட்ட விசையை Android Keystore-ஆல் உருவாக்கவோ படிக்கவோ முடியவில்லை.',
      'openvpn_csr_generation_failed':
          'OpenVPN சான்றிதழ் கோரிக்கையில் Android Keystore விசையால் கையொப்பமிட முடியவில்லை.',
      'openvpn_identity_store_failed':
          'OpenVPN சான்றிதழ் அல்லது சுயவிவரத்தைக் குறியாக்கம் செய்யப்பட்ட சேமிப்பகத்தில் சேமிக்க முடியவில்லை.',
      'openvpn_identity_clear_failed':
          'இந்தக் கணக்கின் உள்ளூர் OpenVPN அடையாளம் முழுவதையும் Android-ஆல் அகற்ற முடியவில்லை.',
      'openvpn_identity_in_use':
          'இந்தச் சாதனத்தின் விசை அல்லது சான்றிதழை நேட்டிவ் OpenVPN அமர்வு இன்னும் பயன்படுத்துகிறது.',
      'openvpn_tls_verification_required':
          'சுயவிவரம் சர்வர் சான்றிதழ் சரிபார்ப்பை வெளிப்படையாகக் கோரவில்லை.',
      'openvpn_cipher_invalid':
          'அனுமதிக்கப்பட்ட பட்டியலில் இல்லாத குறியாக்க வழிமுறையைச் சர்வர் வழங்கியது.',
      'openvpn_profile_rejected':
          'சர்வரிடமிருந்து பெற்ற சுயவிவரம் இணக்கமாக இல்லை. இந்தச் சாதனத்தை மீண்டும் உருவாக்கி மீண்டும் முயற்சிக்கவும்.',
      'openvpn_identity_inconsistent':
          'சான்றிதழ் இந்தத் தொலைபேசியின் பாதுகாப்பான அடையாளத்துடன் பொருந்தவில்லை. உள்ளூர் சுயவிவரம் எதுவும் மாற்றப்படவில்லை.',
      'tls_handshake_failed':
          'TLS பேச்சுவார்த்தையைச் சர்வர் நிராகரித்தது. சிக்கல் தொடர்ந்தால் சுயவிவரத்தை மீண்டும் உருவாக்கவும்.',
      'tls_alert_unknown_ca':
          'இந்தச் சாதனச் சான்றிதழை வழங்கிய அதிகாரத்தைச் சர்வர் அடையாளம் காணவில்லை. OpenVPN சர்வரைச் சரிபார்க்க வேண்டும்.',
      'tls_alert_bad_certificate':
          'இந்தச் சாதனச் சான்றிதழைச் சர்வர் நிராகரித்தது. மீண்டும் முயற்சிக்கும் முன் இந்தச் சாதனத்தை மீண்டும் உருவாக்கவும்.',
      'tls_alert_unsupported_certificate':
          'Android பயன்படுத்தும் பாதுகாப்பான சான்றிதழ் வகையைச் சர்வர் ஆதரிக்கவில்லை.',
      'tls_client_certificate_required':
          'சர்வருக்குக் கிளையன்ட் சான்றிதழ் தேவை, ஆனால் OpenVPN மையக்கூறால் அதை வழங்க முடியவில்லை.',
      'tls_alert_misc':
          'சான்றிதழ் அல்லது பதிப்புப் பிரிவுகளுக்கு வெளியே உள்ள TLS எச்சரிக்கையைச் சர்வர் திருப்பி அனுப்பியது.',
      'tls_signature_algorithm_rejected':
          'Android Keystore விசையின் ECDSA P-256 வழிமுறையைச் சர்வர் நிராகரித்தது.',
      'tls_handshake_rejected':
          'இணைப்புக்கு முன் TLS பேச்சுவார்த்தையைச் சர்வர் இடைநிறுத்தியது.',
      'tls_version_rejected':
          'கிளையன்டுக்கும் சர்வருக்கும் பொதுவான TLS பதிப்பு கிடைக்கவில்லை.',
      'tls_certificate_expired':
          'இணைப்பின்போது வழங்கப்பட்ட சான்றிதழ் காலாவதியாகிவிட்டது.',
      'tls_certificate_revoked':
          'இணைப்பின்போது வழங்கப்பட்ட சான்றிதழ் திரும்பப் பெறப்பட்டுள்ளது.',
      'transport_failed':
          'தற்போதைய நெட்வொர்க்கில் OpenVPN சர்வர் பதிலளிக்கவில்லை. சிறிது நேரத்தில் மீண்டும் முயற்சிக்கவும்.',
      'tun_configuration_rejected':
          'OpenVPN கோரிய நெட்வொர்க் உள்ளமைவை Android நிராகரித்தது.',
      'tun_setup_failed':
          'Android இடைமுகத்தை உருவாக்குவதற்கு முன் OpenVPN மையக்கூறு நெட்வொர்க் திட்டத்தை நிராகரித்தது.',
      'tun_interface_create_failed':
          'Android VpnService-இடமிருந்து TUN இடைமுகத்தை OpenVPN மையக்கூறால் பெற முடியவில்லை.',
      'tun_interface_disabled':
          'இணைப்பின்போது Android அல்லது OpenVPN மையக்கூறு TUN இடைமுகத்தை முடக்கியது.',
      'tun_halted':
          'TUN இடைமுகத்தை நிறுத்துமாறு OpenVPN மையக்கூறு கோரிக்கையைப் பெற்றது.',
      'tun_already_established':
          'அதே இணைப்பில் இரண்டாவது இடைமுகத்தை OpenVPN கோரியது. பாதுகாப்புக்காகச் சுரங்கப்பாதை நிறுத்தப்பட்டது.',
      'tun_addresses_missing':
          'பயன்படுத்தக்கூடிய சுரங்கப்பாதை முகவரியைச் சர்வர் வழங்கவில்லை.',
      'tun_routes_missing':
          'பயன்படுத்தக்கூடிய சுரங்கப்பாதை வழித்தடங்களைச் சர்வர் வழங்கவில்லை.',
      'tun_dns_missing': 'பயன்படுத்தக்கூடிய DNS சர்வரைச் சர்வர் வழங்கவில்லை.',
      'tun_permission_revoked':
          'இணைப்பின்போது VPN அனுமதியை Android திரும்பப் பெற்றது.',
      'tun_establish_returned_null':
          'பொதுவாக இன்னொரு VPN இன்னும் இயக்கத்தில் இருப்பதால் Android இடைமுகத்தை உருவாக்கவில்லை.',
      'openvpn_service_start_failed':
          'முன்னணி OpenVPN சேவையை Android-ஆல் தொடங்க முடியவில்லை.',
      'openvpn_operation_timeout':
          'OpenVPN மையக்கூறுக்கான JNI அழைப்பு அதன் அதிகபட்ச கால அளவை மீறியது.',
      'openvpn_start_failed':
          'Android சேவை தயாராக உள்ளது, ஆனால் சுயவிவரத்தைத் தொடங்குவதை OpenVPN மையக்கூறு ஏற்கவில்லை.',
      'openvpn_connection_failed':
          'CONNECTED நிகழ்வு வெளியிடப்படுவதற்கு முன்பே OpenVPN மையக்கூறு நின்றுவிட்டது.',
      'openvpn_core_status_error':
          'நேட்டிவ் OpenVPN லூப் பிழையுடன் முடிந்தது; இதற்கான இன்னும் குறிப்பிட்ட இறுதி நிகழ்வு எதுவும் இல்லை.',
      'openvpn_stopped_before_connected':
          'மையக்கூறின் வெளிப்படையான பிழை இல்லாமல், CONNECTED நிலைக்கு முன்பே நேட்டிவ் OpenVPN லூப் நின்றுவிட்டது.',
      'openvpn_auth_failed':
          'OpenVPN சர்வர் சுயவிவர அங்கீகாரத்தை நிராகரித்தது.',
      'openvpn_client_setup_failed':
          'நெட்வொர்க் இணைப்புக்கு முன் கிளையன்டை OpenVPN மையக்கூறால் துவக்க முடியவில்லை.',
      'openvpn_client_halted':
          'OpenVPN மையக்கூறு கிளையன்டிடமிருந்து இறுதி நிறுத்தக் கோரிக்கையைப் பெற்றது.',
      'openvpn_client_restart':
          'போக்குவரத்து அமர்வை மறுதொடக்கம் செய்ய வேண்டும் என்று OpenVPN மையக்கூறு கோரியது.',
      'openvpn_inactive_timeout':
          'நீண்ட நேரம் செயலற்று இருந்ததால் OpenVPN மையக்கூறு அமர்வை மூடியது.',
      'openvpn_session_expired':
          'OpenVPN அமர்வு காலாவதியாகிவிட்டதாகச் சர்வர் தெரிவித்தது.',
      'openvpn_credentials_required':
          'இந்தச் சான்றிதழ் சுயவிவரத்தில் இல்லாத ஊடாடும் நற்சான்றுகளைச் சர்வர் அல்லது ப்ராக்ஸி கோருகிறது.',
      'openvpn_proxy_failed':
          'உள்ளமைக்கப்பட்ட ப்ராக்ஸி அல்லது ரிலேயில் தோல்வி ஏற்பட்டதாக OpenVPN மையக்கூறு தெரிவித்தது.',
      'openvpn_compression_failed':
          'சுயவிவரம் அல்லது சர்வர் அறிவித்த சுருக்க முறையை OpenVPN மையக்கூறு நிராகரித்தது.',
      'openvpn_ntlm_crypto_unavailable':
          'இந்தப் பதிப்பில் கிடைக்காத NTLM குறியாக்கத்தைச் சுயவிவரம் கோருகிறது.',
      'openvpn_feature_unsupported':
          'இந்த Android கிளையன்டில் இல்லாத அம்சத்தைச் சுயவிவரம் அல்லது சர்வர் கோருகிறது.',
      'network_unavailable':
          'பயன்படுத்தக்கூடிய இயற்பியல் நெட்வொர்க் எதுவும் கிடைக்கவில்லை.',
      'network_lost':
          'நெட்வொர்க் இல்லாமல் போன பிறகு சுரங்கப்பாதை நிறுத்தப்பட்டது.',
      'certificate_validation_failed':
          'OpenVPN சர்வரின் அடையாளத்தைச் சரிபார்க்க முடியவில்லை.',
      'openvpn_certificate_expired':
          'OpenVPN சான்றிதழ் காலாவதியாகிவிட்டது. அதைப் புதுப்பிக்கப் பயன்பாட்டில் புதிய இணைப்பைத் தொடங்கவும்.',
      'tunnel_active_for_another_account':
          'இந்த இணைப்புக்கு முன் மற்றொரு கணக்கிற்குச் சொந்தமான சுரங்கப்பாதை நிறுத்தப்பட வேண்டும்.',
      'tunnel_already_active':
          'முந்தைய VPN அமர்வு இன்னும் இடைமுகத்தைப் பயன்படுத்துவதாக Android தெரிவிக்கிறது.',
      'tunnel_stop_timeout':
          '$protocol என்ஜின் நேர வரம்பிற்குள் VPN இடைமுகத்தின் விடுவிப்பை உறுதிப்படுத்தவில்லை.',
      'tunnel_disconnected':
          'தொடங்கிய பிறகு சுரங்கப்பாதை எதிர்பாராதவிதமாக முடிவடைந்ததாக நேட்டிவ் என்ஜின் தெரிவித்தது.',
      'native_bridge_unavailable':
          'பயன்பாட்டால் Android VPN சேவையை அணுக முடியவில்லை. பயன்பாட்டை மூடித் திறந்து மீண்டும் முயற்சிக்கவும்.',
      'native_operation_failed':
          'பயன்பாட்டுப் பிழையால் VPN செயல்பாடு தடைபட்டது. மீண்டும் முயற்சிக்கவும். சிக்கல் தொடர்ந்தால் கண்டறிதலை இயக்கவும்.',
      'invalid_arguments':
          'இந்த VPN செயல்பாட்டுக்குத் தேவையான தகவல்கள் முழுமையடையவில்லை. மீண்டும் முயற்சிக்கவும். சிக்கல் தொடர்ந்தால் கண்டறிதலை இயக்கவும்.',
      'invalid_account_id':
          'நேட்டிவ் செயல்பாடு சரியான கணக்கு அடையாளங்காட்டியுடன் தொடர்புடையதாக இல்லை.',
      'invalid_device_id':
          'நேட்டிவ் என்ஜினுக்கு அனுப்பப்பட்ட சாதன அடையாளங்காட்டி இல்லை அல்லது தவறானது.',
      'storage_key_not_allowed':
          'அனுமதிக்கப்பட்ட சேமிப்பகப் பட்டியலுக்கு வெளியே உள்ள விசையை Android பாலம் தடுத்தது.',
      'secure_storage_read_failed':
          'இந்தக் கணக்கின் உள்ளூர் தரவை Android Keystore-ஆல் மறைகுறியாக்க முடியவில்லை.',
      'secure_storage_write_failed':
          'உள்ளூர் தரவை Android Keystore-ஆல் குறியாக்கம் செய்யவோ சேமிக்கவோ முடியவில்லை.',
      'key_generation_failed':
          'பாதுகாப்பான சேமிப்பகத்தில் WireGuard விசையை Android-ஆல் உருவாக்கவோ படிக்கவோ முடியவில்லை.',
      'csr_generation_failed':
          'OpenVPN P-256 CSR-ஐ Android Keystore-ஆல் உருவாக்கவோ கையொப்பமிடவோ முடியவில்லை.',
      'other':
          'ஆவணப்படுத்தப்படாத நேட்டிவ் கிளை தோல்வியடைந்தது. கீழே காட்டப்பட்டுள்ள கண்டறிதல் குறியீட்டை ஆதரவுக் குழுவுக்கு அனுப்பவும்.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'அனுமதிக் கோரிக்கை ஏற்கனவே திறந்துள்ளது';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN அனுமதிக் கோரிக்கை ஏற்கனவே காட்டப்பட்டுள்ளது. மீண்டும் முயற்சிப்பதற்கு முன் அதை முடிக்கவும்.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN அனுமதிக் கோரிக்கை தடைபட்டது';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'பயன்பாடு பதிலைப் பெறுவதற்கு முன்பே VPN அனுமதித் திரை மூடப்பட்டது.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN இணைப்பு உறுதிப்படுத்தப்படவில்லை';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN இணைப்பை உறுதிப்படுத்த முடியவில்லை. பாதுகாப்புக்காக அது நிறுத்தப்பட்டது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get openvpnCleanup_title => 'OpenVPN சுயவிவரம் திரும்பப் பெறப்பட்டது';

  @override
  String get openvpnCleanup_working =>
      'திரும்பப் பெறப்பட்ட OpenVPN சுயவிவரத்தை நிறுத்தி அகற்றுகிறது…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN நிறுத்தப்பட்டதை உறுதிப்படுத்த முடியவில்லை. புதிய சுயவிவரத்தை உருவாக்கும் முன் மீண்டும் முயற்சிக்கவும்.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'திரும்பப் பெறப்பட்ட OpenVPN சுயவிவரத்தை முழுமையாக அகற்ற முடியவில்லை. சுத்தம் செய்வதை மீண்டும் முயற்சிக்கவும்.';

  @override
  String get openvpnCleanup_complete =>
      'திரும்பப் பெறப்பட்ட OpenVPN சுயவிவரம் அகற்றப்பட்டது. புதியதை உருவாக்க “இணைக்கவும்” என்பதைத் தட்டவும்.';

  @override
  String get network_title => 'நெட்வொர்க் உள்ளமைவு';

  @override
  String get network_ipv4Fallback =>
      'IPv6 தற்காலிகமாகக் கிடைக்கவில்லை. IPv4 மூலம் தயாரிப்பு தொடர்கிறது.';

  @override
  String get network_rejectedTitle => 'நெட்வொர்க் உள்ளமைவு நிராகரிக்கப்பட்டது';

  @override
  String get network_rejectedMessage =>
      'சுரங்கப்பாதை உள்ளமைவு முழுமையடையவில்லை அல்லது அங்கீகரிக்கப்பட்ட முகவரிகளுடன் பொருந்தவில்லை. பயன்பாட்டிலிருந்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get network_unreadableTitle => 'உள்ளூர் உள்ளமைவைப் படிக்க முடியவில்லை';

  @override
  String get network_unreadableMessage =>
      'சேமிக்கப்பட்ட OpenVPN நெட்வொர்க் உள்ளமைவைப் பயன்படுத்த முடியாது. அதைப் புதுப்பிக்கப் பயன்பாட்டிலிருந்து மீண்டும் இணைக்கவும்.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'நெட்வொர்க் பாதுகாப்பு';

  @override
  String get protection_subtitle =>
      'VPN துண்டிக்கப்பட்டால் நேரடி இணைய அணுகலைத் தடுக்கவும்.';

  @override
  String get protection_active => 'சிஸ்டம் பாதுகாப்பு செயலில் உள்ளது';

  @override
  String get protection_alwaysOnOnly =>
      'எப்போதும் இயக்கத்தில் உள்ள VPN இயக்கப்பட்டுள்ளது; VPN இல்லாத இணைப்புகளைத் தடுப்பதை இயக்கவும்';

  @override
  String get protection_inactive => 'சிஸ்டம் பாதுகாப்பு செயலில் இல்லை';

  @override
  String get protection_unknown => 'சிஸ்டம் பாதுகாப்பைச் சரிபார்க்கவும்';

  @override
  String get protection_openSettings => 'Android அமைப்புகளைத் திறக்கவும்';

  @override
  String get protection_dialogTitle => 'நெட்வொர்க் பாதுகாப்பை அமைக்கவும்';

  @override
  String get protection_dialogMessage =>
      'எப்போதும் இயக்கத்தில் உள்ள VPN மற்றும் VPN இல்லாமல் இணைப்புகளைத் தடுப்பதை Android நிர்வகிக்கிறது. FuzeVPN தேர்ந்தெடுக்கப்பட்டுள்ளதா எனச் சரிபார்த்து, சிஸ்டம் அமைப்புகளில் தடுப்பதை இயக்கவும்.';

  @override
  String get protection_dialogOpen => 'அமைப்புகளைத் திறக்கவும்';

  @override
  String get session_systemProtectionNote =>
      'VPN இல்லாமல் போக்குவரத்தை Android இன்னும் தடுத்தால், இந்தப் பாதுகாப்பைச் சரிபார்க்கவோ மாற்றவோ சிஸ்டம் அமைப்புகளைத் திறக்கவும்.';

  @override
  String get diagnostics_title => 'கண்டறிதல்';

  @override
  String get diagnostics_settingsTitle => 'பயன்பாட்டுக் கண்டறிதல்';

  @override
  String get diagnostics_automaticTitle => 'முக்கியமான பிழைகளை அனுப்பவும்';

  @override
  String get diagnostics_automaticDescription =>
      'முக்கியமான பிழை ஏற்படும்போது ஒரு சிறிய தொழில்நுட்ப அறிக்கையைப் பகிரவும்.';

  @override
  String get diagnostics_privacy =>
      'அனுப்பப்பட்ட அறிக்கைகள் உள்நுழைந்த கணக்குடன் இணைக்கப்பட்டு 30 நாட்களுக்கு வைத்திருக்கப்படும். அவற்றில் உலாவல் வரலாறு, கடவுச்சொற்கள் அல்லது VPN விசைகள் இருக்காது.';

  @override
  String get diagnostics_manualOpen => 'கண்டறிதலை இயக்கவும்';

  @override
  String get diagnostics_localDescription =>
      'பயன்பாடு மற்றும் VPN நிலையின் அறிக்கையை உருவாக்கவும். உங்கள் இணைப்பு மாறாமல் இருக்கும்.';

  @override
  String get diagnostics_sendReport => 'அறிக்கையை அனுப்பவும்';

  @override
  String get diagnostics_sendHint =>
      'அறிக்கையை இந்தச் சாதனத்திலேயே வைத்திருக்க, இந்தப் பெட்டியைத் தேர்ந்தெடுக்காமல் விடவும்.';

  @override
  String get diagnostics_signedOut =>
      'அறிக்கையை அனுப்ப உங்கள் கணக்கில் உள்நுழையவும்.';

  @override
  String get diagnostics_localLifetime =>
      'பயன்பாட்டை மூடிய பிறகும் இந்த அறிக்கையை வைத்திருக்க, உங்கள் தொலைபேசியில் சேமிக்கவும்.';

  @override
  String get diagnostics_run => 'கண்டறிதலை இயக்கவும்';

  @override
  String get diagnostics_rerun => 'கண்டறிதலை மீண்டும் இயக்கவும்';

  @override
  String get diagnostics_running => 'சரிபார்க்கிறது…';

  @override
  String get diagnostics_sending => 'அறிக்கை அனுப்பப்படுகிறது…';

  @override
  String get diagnostics_prepared => 'அறிக்கை இந்தச் சாதனத்தில் தயாராக உள்ளது';

  @override
  String get diagnostics_queued => 'அறிக்கை அனுப்பப்படக் காத்திருக்கிறது';

  @override
  String get diagnostics_sent => 'அறிக்கை பெறப்பட்டது';

  @override
  String get diagnostics_failed =>
      'அனுப்புதல் தோல்வியடைந்தது. உங்கள் உள்ளூர் அறிக்கை இன்னும் கிடைக்கிறது.';

  @override
  String get diagnostics_preparationFailed =>
      'கண்டறிதல் அறிக்கையைத் தயாரிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get diagnostics_authenticationRequired =>
      'அறிக்கையை அனுப்ப மீண்டும் உள்நுழையவும்.';

  @override
  String get diagnostics_retry => 'மீண்டும் அனுப்பவும்';

  @override
  String get diagnostics_export => 'அறிக்கையைச் சேமிக்கவும்';

  @override
  String get diagnostics_exportFailed =>
      'ஏற்றுமதி தோல்வியடைந்தது. உள்ளூர் அறிக்கையிலிருந்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get diagnostics_preferenceFailed =>
      'இந்த அமைப்பைச் சேமிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String diagnostics_receipt(Object id) {
    return 'குறிப்பு எண்: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date அன்று பெறப்பட்டது';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date வரை வைத்திருக்கப்படும்';
  }

  @override
  String get diagnostics_duplicate => 'இந்த அறிக்கை ஏற்கனவே பெறப்பட்டுள்ளது.';

  @override
  String get diagnostics_preview => 'அறிக்கை முன்னோட்டம்';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count தொழில்நுட்ப நிகழ்வுகள் இணைக்கப்பட்டுள்ளன',
      one: '1 தொழில்நுட்ப நிகழ்வு இணைக்கப்பட்டுள்ளது',
      zero: 'தொழில்நுட்ப நிகழ்வுகள் எதுவும் இணைக்கப்படவில்லை',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'தொழில்நுட்ப விவரங்கள்';

  @override
  String get diagnostics_empty =>
      'கண்டறிதல் அறிக்கை இன்னும் தயாரிக்கப்படவில்லை.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'சுரங்கப்பாதை நிலை',
      'handshake': 'இணைப்பு உறுதிப்படுத்தல்',
      'certificate': 'VPN சான்றிதழ்',
      'kill_switch': 'Android பாதுகாப்பு',
      'connectivity': 'கிடைக்கும் நெட்வொர்க்',
      'api_reachability': 'சேவை அணுகல்',
      'secure_storage': 'பாதுகாப்பான சேமிப்பகம்',
      'other': 'உள்ளூர் சரிபார்ப்பு',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'சரிபார்க்கப்பட்டது',
      'failed': 'கவனம் தேவை',
      'skipped': 'சோதிக்கப்படவில்லை — செயலில் உள்ள ஆய்வு இல்லை',
      'unknown': 'தகவல் கிடைக்கவில்லை',
      'other': 'தகவல் கிடைக்கவில்லை',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN-க்கு வரவேற்கிறோம்';

  @override
  String get connection_changeLocation => 'இடத்தை மாற்றவும்';

  @override
  String get connection_details => 'இணைப்பு விவரங்கள்';

  @override
  String get locations_searchLabel => 'நகரம் அல்லது நாட்டைத் தேடவும்';

  @override
  String get locations_clearSearch => 'தேடலை அழிக்கவும்';

  @override
  String get locations_filterAll => 'அனைத்தும்';

  @override
  String get locations_filterFavorites => 'பிடித்தவை';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count இடங்கள்',
      one: '$count இடம்',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'இடங்கள் எதுவும் கிடைக்கவில்லை';

  @override
  String get locations_noResultsHint =>
      'வேறொரு நகரம் அல்லது நாட்டை முயற்சிக்கவும்.';

  @override
  String get locations_noFavorites =>
      'உங்கள் பிடித்தவை, கைக்கு எட்டும் தூரத்தில்';

  @override
  String get locations_noFavoritesHint =>
      'இங்கே சேமிக்க, ஓர் இடத்தின் அருகில் உள்ள நட்சத்திரத்தைத் தட்டவும்.';

  @override
  String get locations_showAll => 'அனைத்து இடங்களையும் பார்க்கவும்';

  @override
  String locations_addFavorite(String name) {
    return '$name-ஐப் பிடித்தவற்றில் சேர்க்கவும்';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name-ஐப் பிடித்தவற்றிலிருந்து அகற்றவும்';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'பிடித்ததைச் சேமிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get locations_emptyTitle => 'கிடைக்கக்கூடிய இடங்கள் இல்லை';

  @override
  String get locations_emptyHint =>
      'மீண்டும் முயற்சிக்க பட்டியலைப் புதுப்பிக்கவும்.';

  @override
  String get devices_manage => 'எனது சாதனங்களை நிர்வகிக்கவும்';

  @override
  String get settings_personalization => 'உங்களுக்கு ஏற்றபடி அமைக்கவும்';

  @override
  String get settings_safety => 'பாதுகாப்பு';

  @override
  String get settings_help => 'உதவி தேவையா?';

  @override
  String get settings_about => 'FuzeVPN பற்றி';

  @override
  String get diagnostics_heading => 'இணைப்புச் சிக்கலைப் புரிந்துகொள்ளவும்';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'கிடைக்கிறது',
      'pending': 'தயாராகிறது',
      'revoked': 'அகற்றப்பட்டது',
      'expired': 'காலாவதியானது',
      'other': 'நிலை கிடைக்கவில்லை',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'விருப்பம் சேமிக்கப்படவில்லை';

  @override
  String get notice_preferenceSave_message =>
      'உங்கள் தேர்வு இப்போதைக்குப் பயன்படுத்தப்பட்டுள்ளது, ஆனால் சேமிக்க முடியவில்லை. பயன்பாட்டை மூடிய பிறகும் அதை வைத்திருக்க மீண்டும் முயற்சிக்கவும்.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPN-ஐத் தொடர்ந்து செயலில் வைத்திருந்தால், திறக்கும் அமைப்புகளில் “எப்போதும் இயக்கத்தில் உள்ள VPN” விருப்பத்தை முடக்கவும்.';

  @override
  String get connection_certificate => 'OpenVPN சான்றிதழ்';

  @override
  String connection_certificateValidUntil(Object date) {
    return '$date வரை செல்லுபடியாகும்';
  }

  @override
  String connection_certificateExpired(Object date) {
    return '$date அன்று காலாவதியானது';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'அடுத்த முறை இணைக்கும்போது தானாகப் புதுப்பிக்கப்படும்.';

  @override
  String get protection_learnMore => 'Android பாதுகாப்பு பற்றி அறியவும்';

  @override
  String get protection_guideWhy =>
      'VPN துண்டிக்கப்பட்டால், பயன்பாடுகள் நேரடியாக இணையத்தைப் பயன்படுத்துவதை இந்தப் பாதுகாப்பு தடுக்கும். இது Android-இல் அமைக்கப்படுகிறது.';

  @override
  String get protection_guideAlwaysOnTitle => 'எப்போதும் இயக்கத்தில் உள்ள VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN சேவையைத் தொடர்ந்து இயக்கத்தில் வைத்திருக்கும்; தொலைபேசியை மறுதொடக்கம் செய்த பிறகும் அதை மீண்டும் தொடங்க முடியும்.';

  @override
  String get protection_guideBlockTitle =>
      'VPN இல்லாமல் இணைப்புகளைத் தடுக்கவும்';

  @override
  String get protection_guideBlock =>
      'இணைப்பு தடைபட்டிருக்கும்போதும், VPN-ஐத் தவிர்த்துப் போக்குவரத்து செல்வதை இந்த அமைப்பு தடுக்கும்.';

  @override
  String get protection_guideWarning =>
      'இந்தத் தடுப்பு இயக்கத்தில் இருக்கும்போது, VPN இணைக்கப்படும் வரை இணைய அணுகல் முடக்கப்பட்டே இருக்கும்.';

  @override
  String get protection_guideStepsTitle => 'பாதுகாப்பை இயக்கவும்';

  @override
  String get protection_guideStep1 =>
      'கீழே உள்ள பொத்தானைப் பயன்படுத்தி Android VPN அமைப்புகளைத் திறக்கவும்.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN-க்கு அடுத்துள்ள கியர் ஐகானைத் தட்டி விருப்பங்களைத் திறக்கவும்.';

  @override
  String get protection_guideStep3 =>
      'இந்த விருப்பங்கள் இருந்தால், முதலில் “எப்போதும் இயக்கத்தில் உள்ள VPN”-ஐயும், பிறகு “VPN இல்லாமல் இணைப்புகளைத் தடுக்கவும்”-ஐயும் இயக்கவும்.';

  @override
  String get protection_guideManufacturers =>
      'பெயர்கள் தொலைபேசிக்குத் தொலைபேசி மாறுபடும். தேவைப்பட்டால், அமைப்புகளில் VPN-ஐத் தேடவும்; இது பெரும்பாலும் நெட்வொர்க் & இணையம் பிரிவின் கீழ் இருக்கும்.';

  @override
  String get protection_guideDisableTitle => 'இந்தப் பாதுகாப்பை முடக்கவும்';

  @override
  String get protection_guideDisable =>
      'அதே அமைப்புகளில், VPN இல்லாமல் இணையத்தை அனுமதிக்க “VPN இல்லாமல் இணைப்புகளைத் தடுக்கவும்” விருப்பத்தை முடக்கவும். Android அதை மீண்டும் தொடங்கக்கூடாது என்று விரும்பினால், “எப்போதும் இயக்கத்தில் உள்ள VPN”-ஐயும் முடக்கவும்.';

  @override
  String get protection_guideManual =>
      'இந்த அமைப்புகளை Android-இல் நீங்களே தேர்ந்தெடுக்கிறீர்கள். FuzeVPN இவற்றை உங்களுக்காக மாற்றாது.';

  @override
  String get locations_changeTitle => 'இடத்தை மாற்றவா?';

  @override
  String locations_changeActive(String name) {
    return 'VPN துண்டிக்கப்பட்டு, பின்னர் $name-உடன் இணைய முயலும்.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name-உடன் இணைய முயலும்.';
  }

  @override
  String get locations_confirmChange => 'மாற்றி இணைக்கவும்';

  @override
  String get locations_changeBusy =>
      'இட மாற்றம் நடைபெறுகிறது. வேறு இடத்தைத் தேர்ந்தெடுக்கும் முன் காத்திருக்கவும்.';

  @override
  String get locations_automaticSelection => 'தானியங்கித் தேர்வு';

  @override
  String get locations_cities => 'நகரங்கள்';

  @override
  String get locations_servers => 'சர்வர்கள்';

  @override
  String locations_viewCities(String name) {
    return '$name-இல் உள்ள நகரங்களைப் பார்க்கவும்';
  }

  @override
  String locations_viewServers(String name) {
    return '$name-இல் உள்ள சர்வர்களைப் பார்க்கவும்';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நாடுகள்',
      one: '$count நாடு',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நகரங்கள்',
      one: '$count நகரம்',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count சர்வர்கள்',
      one: '$count சர்வர்',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'அனைத்து நாடுகளும்';

  @override
  String get locations_backToCountries => 'நாடுகளுக்குத் திரும்பவும்';

  @override
  String locations_backToCities(String name) {
    return '$name-இல் உள்ள நகரங்களுக்குத் திரும்பவும்';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name-ஐத் தேர்ந்தெடுக்கவும்';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name-ஐத் தேர்ந்தெடுக்கவும்';
  }

  @override
  String get locations_noCompatibleServer =>
      'இணக்கமான சர்வர் எதுவும் கிடைக்கவில்லை.';

  @override
  String get externalLink_failed =>
      'இந்த இணைப்பைத் திறக்க முடியவில்லை. அதை நகலெடுத்து உங்கள் உலாவியில் திறக்கலாம்.';

  @override
  String get externalLink_copy => 'இணைப்பை நகலெடுக்கவும்';

  @override
  String get externalLink_copied => 'இணைப்பு நகலெடுக்கப்பட்டது';

  @override
  String get externalLink_copyFailed =>
      'இணைப்பை நகலெடுக்க முடியவில்லை. கீழே உள்ள முகவரியைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get settings_deleteAccount => 'எனது கணக்கை நீக்கவும்';

  @override
  String get settings_deleteAccountDetail =>
      'கணக்கு நீக்கக் கோரிக்கை நடைமுறையைப் பார்க்கவும்';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'உங்கள் VPN சந்தாவைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get billing_subscribe => 'சந்தா செலுத்தவும்';

  @override
  String get billing_choosePlan => 'தொடர ஒரு திட்டத்தைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get billing_monthly => 'மாதந்தோறும்';

  @override
  String get billing_yearly => 'ஆண்டுதோறும்';

  @override
  String get billing_continue => 'Google Play மூலம் தொடரவும்';

  @override
  String get billing_restore => 'வாங்கியவற்றை மீட்டெடுக்கவும்';

  @override
  String get billing_manage => 'சந்தாவை நிர்வகிக்கவும்';

  @override
  String get billing_deleteAccountWarning =>
      'உங்களிடம் Google Play சந்தா இருந்தால், உங்கள் FuzeVPN கணக்கை நீக்குவது அதன் புதுப்பித்தலை ரத்துசெய்யாது. Google Play-இல் புதுப்பித்தலைத் தனியாக நிர்வகிக்கவும் அல்லது ரத்துசெய்யவும்.';

  @override
  String get billing_deleteAccountContinue =>
      'கணக்கு நீக்கக் கோரிக்கையைத் தொடரவும்';

  @override
  String get billing_refresh => 'அணுகலைப் புதுப்பிக்கவும்';

  @override
  String get billing_loadingPlans => 'திட்டங்கள் ஏற்றப்படுகின்றன…';

  @override
  String get billing_unavailable =>
      'இப்போது திட்டங்கள் எதுவும் கிடைக்கவில்லை. பின்னர் மீண்டும் முயற்சிக்கவும்.';

  @override
  String get billing_comingSoon => 'சந்தாக்கள் விரைவில் வரவுள்ளன.';

  @override
  String get billing_priceDisclosure =>
      'விலையை Google Play வழங்குகிறது. நீங்கள் உறுதிப்படுத்துவதற்கு முன், இறுதித் தொகையும் பொருந்தக்கூடிய வரிகளும் உறுதிப்படுத்தப்படும்.';

  @override
  String get billing_renewalMonthly =>
      'ரத்துசெய்யப்படாவிட்டால் ஒவ்வொரு மாதமும் தானாகப் புதுப்பிக்கப்படும். Google Play சந்தாக்களில் எப்போது வேண்டுமானாலும் ரத்துசெய்யலாம்.';

  @override
  String get billing_renewalYearly =>
      'ரத்துசெய்யப்படாவிட்டால் ஒவ்வொரு ஆண்டும் தானாகப் புதுப்பிக்கப்படும். Google Play சந்தாக்களில் எப்போது வேண்டுமானாலும் ரத்துசெய்யலாம்.';

  @override
  String get billing_active => 'உங்கள் Premium அணுகல் செயலில் உள்ளது';

  @override
  String billing_accessUntil(String date) {
    return '$date வரை அணுகல்.';
  }

  @override
  String get billing_webManaged =>
      'உங்கள் சந்தா FuzeVPN இணையதளத்தில் நிர்வகிக்கப்படுகிறது.';

  @override
  String get billing_playManaged =>
      'உங்கள் சந்தா Google Play மூலம் நிர்வகிக்கப்படுகிறது.';

  @override
  String get billing_playOnHold =>
      'உங்கள் Google Play சந்தா நிறுத்திவைக்கப்பட்டுள்ளது அல்லது பணம் செலுத்தப்பட வேண்டியுள்ளது. Google Play-இல் இதைச் சரிசெய்ய “சந்தாவை நிர்வகிக்கவும்” என்பதைத் திறக்கவும்.';

  @override
  String get billing_playReceiptUnlinked =>
      'இந்த Google Play கணக்கில் ஏற்கனவே ஒரு Fuze Premium சந்தா உள்ளது; ஆனால் இது இந்த FuzeVPN கணக்கிற்குச் செயலில் இல்லை. Google Play-இல் இதை மதிப்பாய்வு செய்ய “சந்தாவை நிர்வகிக்கவும்” என்பதைத் திறக்கவும்.';

  @override
  String get billing_inactive => 'செயலில் உள்ள சந்தா எதுவும் இல்லை.';

  @override
  String get billing_checkingAccess => 'உங்கள் அணுகலைச் சரிபார்க்கிறது…';

  @override
  String get billing_restoring => 'வாங்கியவை மீட்டெடுக்கப்படுகின்றன…';

  @override
  String get billing_pending =>
      'பணம் செலுத்துதல் நிலுவையில் உள்ளது. உறுதிப்படுத்திய பிறகு உங்கள் அணுகல் செயல்படுத்தப்படும்.';

  @override
  String get billing_cancelled =>
      'வாங்குதல் ரத்துசெய்யப்பட்டது. புதிய சந்தா எதுவும் செயல்படுத்தப்படவில்லை.';

  @override
  String get billing_verifying => 'வாங்குதல் சரிபார்க்கப்படுகிறது…';

  @override
  String get billing_success =>
      'சந்தா செயல்படுத்தப்பட்டது. உங்கள் Premium அணுகல் தயாராக உள்ளது.';

  @override
  String get billing_restored => 'உங்கள் வாங்கியவை மீட்டெடுக்கப்பட்டன.';

  @override
  String get billing_restoreEmpty =>
      'இந்த Google Play கணக்கில் மீட்டெடுக்க வாங்கியவை எதுவும் இல்லை.';

  @override
  String get billing_catalogError =>
      'திட்டங்களை ஏற்ற முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get billing_purchaseError =>
      'வாங்குதலைத் தொடங்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get billing_verificationError =>
      'வாங்குதல் சரிபார்ப்பு தற்காலிகமாகக் கிடைக்கவில்லை. மீண்டும் முயல, வாங்கியவற்றை மீட்டெடுக்கவும்.';

  @override
  String get billing_restoreError =>
      'வாங்கியவற்றை மீட்டெடுக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get billing_managementError =>
      'சந்தா நிர்வாகத்தைத் திறக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get billing_storeUnavailable =>
      'இந்தச் சாதனத்தில் Google Play கிடைக்கவில்லை.';

  @override
  String get welcome_title => 'உங்கள் VPN, எளிமையாக.';

  @override
  String get welcome_description =>
      'உங்கள் இணைப்பைப் பாதுகாக்கவும். உங்கள் தனியுரிமையின் கட்டுப்பாட்டை உங்கள் கையிலேயே வைத்திருக்கவும்.';

  @override
  String get welcome_start => 'தொடங்கவும்';

  @override
  String get welcome_alreadyPurchased => 'ஏற்கனவே வாங்கிவிட்டீர்களா?';

  @override
  String get welcome_noAccountRequired => 'தொடங்கக் கணக்கு தேவையில்லை.';

  @override
  String get guest_accountTitle => 'கணக்கு இணைக்கப்படவில்லை';

  @override
  String get guest_accountDescription =>
      'வேறொரு சாதனத்தில் உங்கள் சந்தாவைப் பயன்படுத்த, அதே Google Play கணக்கைக் கொண்டு உங்கள் வாங்கியவற்றை மீட்டெடுக்கவும்.';

  @override
  String get guest_existingSubscriberSignIn =>
      'ஏற்கனவே சந்தாதாரரா? உள்நுழையவும்';

  @override
  String get guest_claimTitle => 'FuzeVPN-ஐ உங்களுடன் எடுத்துச் செல்லவும்';

  @override
  String get guest_claimDescription =>
      'உங்கள் மற்ற சாதனங்களிலும் சந்தாவைப் பெற ஒரு கணக்கை உருவாக்கவும். இந்தப் படி கட்டாயமில்லை.';

  @override
  String get guest_skip => 'பிறகு பார்க்கலாம்';

  @override
  String get guest_activationTitle => 'Fuze Premium செயலில் உள்ளது';

  @override
  String get guest_activationDescription =>
      'உங்கள் சந்தா தயாராக உள்ளது. நீங்கள் விரும்பும்போது VPN-ஐப் பயன்படுத்தலாம்; கணக்கையும் உருவாக்கலாம்.';

  @override
  String get guest_useVpn => 'எனது VPN-ஐப் பயன்படுத்தவும்';

  @override
  String get guest_loginRequired =>
      'இந்த வாங்குதல் ஏற்கனவே ஒரு FuzeVPN கணக்குடன் இணைக்கப்பட்டுள்ளது. உங்கள் சந்தாவைப் பெற, அந்தக் கணக்கில் உள்நுழையவும்.';

  @override
  String get guest_signOutWarning =>
      'அதே Google Play கணக்கைக் கொண்டு வாங்கியவற்றை மீட்டெடுப்பதன் மூலம் உங்கள் சந்தாவை மீண்டும் பெறலாம்.';

  @override
  String get guest_profileUnavailable =>
      'உங்கள் கணக்கு ஏற்கனவே இணைக்கப்பட்டுள்ளது. உங்கள் விவரங்களைப் பார்க்கவும் நிர்வகிக்கவும் உள்நுழையவும்.';

  @override
  String get billing_acceptance =>
      'தொடர்வதன் மூலம், பயன்பாட்டு விதிமுறைகளையும் தனியுரிமைக் கொள்கையையும் ஏற்றுக்கொள்கிறீர்கள்.';

  @override
  String get guest_verifyEmailReminder =>
      'உங்கள் கணக்கைப் பாதுகாக்க மின்னஞ்சல் முகவரியை உறுதிப்படுத்தவும். உங்கள் VPN-ஐத் தொடர்ந்து பயன்படுத்தலாம்.';

  @override
  String get guest_serviceUnavailable =>
      'சேவை தற்காலிகமாகக் கிடைக்கவில்லை. சிறிது நேரத்தில் மீண்டும் முயற்சிக்கவும்.';

  @override
  String get guest_restoreError =>
      'உங்கள் வாங்கியவற்றை மீட்டெடுக்க முடியவில்லை. வாங்குதலுக்குப் பயன்படுத்திய Google Play கணக்கைக் கொண்டு மீண்டும் முயற்சிக்கவும்.';

  @override
  String get guest_claimSuccess =>
      'உங்கள் கணக்கு உருவாக்கப்பட்டது. உங்கள் சந்தாவும் VPN அணுகலும் தக்கவைக்கப்பட்டுள்ளன.';

  @override
  String get guest_emailExists =>
      'இந்த மின்னஞ்சல் ஏற்கனவே பயன்பாட்டில் உள்ளது. வேறு முகவரியைத் தேர்ந்தெடுக்கவும் அல்லது ஏற்கனவே உள்ள கணக்கில் உள்நுழையவும். உங்கள் வாங்குதல் Google Play மூலம் தொடர்ந்து கிடைக்கும்.';

  @override
  String get guest_claimError =>
      'உங்கள் கணக்கை உருவாக்க முடியவில்லை. உங்கள் VPN-ஐத் தொடர்ந்து பயன்படுத்தலாம்; பின்னர் மீண்டும் முயற்சிக்கலாம்.';

  @override
  String get guest_secureStorageError =>
      'இந்தச் சாதனத்தில் உங்கள் அமர்வைப் பாதுகாக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get guest_premiumRequired =>
      'உங்கள் VPN-ஐ இயக்க ஒரு சந்தாவைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get welcome_viewPlans => 'திட்டங்களைப் பார்க்கவும்';

  @override
  String get google_continue => 'Google மூலம் தொடரவும்';

  @override
  String get google_or => 'அல்லது';

  @override
  String get google_title => 'உங்கள் FuzeVPN கணக்கு';

  @override
  String get google_settingUp => 'உங்கள் கணக்கை உருவாக்குவதை முடிக்கவும்';

  @override
  String get google_country => 'வசிக்கும் நாடு';

  @override
  String get google_profileDescription =>
      'உங்கள் FuzeVPN கணக்கை உருவாக்க, உங்கள் நாட்டைத் தேர்ந்தெடுத்து இரண்டு ஆவணங்களையும் மதிப்பாய்வு செய்யவும்.';

  @override
  String get google_claimDescription =>
      'உங்கள் விருந்தினர் கணக்கை Google-உடன் இணைக்கவும். உங்கள் சந்தாவும் சாதனமும் இந்தக் கணக்குடனேயே இணைந்திருக்கும்.';

  @override
  String get google_linkTitle => 'Google-ஐ FuzeVPN-உடன் இணைக்கவும்';

  @override
  String get google_linkDescription =>
      'ஏற்கனவே உள்ள உங்கள் FuzeVPN கணக்கிற்கான அணுகலை உறுதிப்படுத்தவும். இந்தப் படி உங்கள் Google கடவுச்சொல்லைக் கேட்காது.';

  @override
  String get google_password => 'FuzeVPN கடவுச்சொல்';

  @override
  String get google_linkAccount => 'இணைப்பை உறுதிப்படுத்தவும்';

  @override
  String get google_requestEmail =>
      'உறுதிப்படுத்தல் மின்னஞ்சலை எனக்கு அனுப்பவும்';

  @override
  String get google_emailInstructions =>
      'FuzeVPN மின்னஞ்சலைத் திறந்து உறுதிப்படுத்தல் குறியீட்டை உள்ளிடவும்.';

  @override
  String get google_emailCode => 'மின்னஞ்சல் உறுதிப்படுத்தல் குறியீடு';

  @override
  String get google_confirmEmail => 'குறியீட்டை உறுதிப்படுத்தவும்';

  @override
  String get google_restart => 'வேறு Google கணக்கைத் தேர்ந்தெடுக்கவும்';

  @override
  String get google_resume => 'இந்த முயற்சியைச் சரிபார்க்கவும்';

  @override
  String get google_unavailable =>
      'Google உள்நுழைவு கிடைக்கவில்லை. மின்னஞ்சல் மற்றும் கடவுச்சொல்லைப் பயன்படுத்தலாம்.';

  @override
  String get google_expired =>
      'இந்த முயற்சி காலாவதியாகிவிட்டது. இதை ரத்துசெய்துவிட்டு மீண்டும் தொடங்கவும்.';

  @override
  String get google_conflict =>
      'இந்த Google கணக்கு ஏற்கனவே வேறு இடத்தில் இணைக்கப்பட்டுள்ளது. உங்கள் தற்போதைய கணக்கும் சந்தாவும் அப்படியே உள்ளன.';

  @override
  String get google_error =>
      'Google உள்நுழைவு தோல்வியடைந்தது. மீண்டும் முயற்சிக்கவும்; உங்கள் தற்போதைய அணுகல் அப்படியே உள்ளது.';

  @override
  String get google_uncertain =>
      'முடிவை உறுதிப்படுத்த முடியவில்லை. மீண்டும் தொடங்கும் முன் இந்த முயற்சியைச் சரிபார்க்கவும் அல்லது ரத்துசெய்யவும்.';

  @override
  String get google_cancelFailed =>
      'ரத்துசெய்தல் உறுதிப்படுத்தப்படவில்லை. இந்தத் திரையை விட்டு வெளியேறும் முன் மீண்டும் ரத்துசெய்ய முயற்சிக்கவும்.';

  @override
  String get google_cancelled => 'Google உள்நுழைவு ரத்துசெய்யப்பட்டது.';

  @override
  String get google_selecting => 'உங்கள் Google கணக்கைத் தேர்ந்தெடுக்கவும்…';

  @override
  String get google_verifying => 'உங்கள் கணக்கைச் சரிபார்க்கிறது…';

  @override
  String get google_emailUnavailable =>
      'உறுதிப்படுத்தல் மின்னஞ்சலை அனுப்ப முடியவில்லை. பின்னர் மீண்டும் முயற்சிக்கவும்.';

  @override
  String get google_emailSent =>
      'உறுதிப்படுத்தல் மின்னஞ்சல் அனுப்பப்பட்டது. உங்கள் இன்பாக்ஸைச் சரிபார்க்கவும்.';

  @override
  String get google_rateLimited =>
      'மீண்டும் முயல்வதற்கு முன் சிறிது நேரம் காத்திருக்கவும்.';

  @override
  String get google_busy =>
      'வேறொரு செயல்பாடு நடைபெறுவதால் (VPN இணைப்பு, கணக்கு அல்லது விருந்தினர்) Google கிடைக்கவில்லை. அது முடிந்ததும் மீண்டும் முயற்சிக்கவும்; உங்கள் தற்போதைய அணுகல் அப்படியே உள்ளது.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN கடவுச்சொல் தவறானது. உங்கள் தற்போதைய கணக்கு அப்படியே உள்ளது.';

  @override
  String get google_invalidCode =>
      'உறுதிப்படுத்தல் குறியீடு தவறானது அல்லது காலாவதியாகிவிட்டது.';

  @override
  String get google_accountChanged =>
      'உங்கள் அமர்வு மாறிவிட்டது. மீண்டும் தொடங்கும் முன் இந்த முயற்சியை ரத்துசெய்யவும்.';

  @override
  String get google_invalidResponse =>
      'பதிலைச் சரிபார்க்க முடியவில்லை. உங்கள் தற்போதைய அணுகல் அப்படியே உள்ளது.';

  @override
  String get google_invalidRegistration =>
      'உங்கள் நாட்டையும் இரண்டு ஒப்புதல்களையும் சரிபார்க்கவும்.';

  @override
  String get google_consentRequired =>
      'தொடர, உங்கள் நாட்டைத் தேர்ந்தெடுத்து இரண்டு ஆவணங்களையும் ஏற்றுக்கொள்ளவும்.';

  @override
  String get google_challengeRequired =>
      'கூடுதல் பாதுகாப்புச் சரிபார்ப்பு தேவை. உங்கள் தற்போதைய அணுகல் அப்படியே உள்ளது.';

  @override
  String get google_challengeUnavailable =>
      'பாதுகாப்புச் சரிபார்ப்பு கிடைக்கவில்லை. பின்னர் மீண்டும் முயற்சிக்கவும்.';

  @override
  String get google_intentMismatch =>
      'முந்தைய Google உள்நுழைவு முயற்சி இன்னும் நிலுவையில் உள்ளது. இந்தச் செயல்பாட்டைத் தொடங்கும் முன் அதை ரத்துசெய்யவும்.';

  @override
  String get google_challengeBlocked =>
      'தேவையான பாதுகாப்புச் சரிபார்ப்பு இந்தப் பயன்பாட்டில் கிடைக்கவில்லை. இந்தச் செயல்பாட்டை இப்போது முடிக்க முடியாது.';

  @override
  String get google_solveChallenge => 'பாதுகாப்புச் சரிபார்ப்பை முடிக்கவும்';

  @override
  String get google_challengeTitle => 'பாதுகாப்புச் சரிபார்ப்பு';

  @override
  String get google_challengeReady =>
      'சரிபார்ப்பு முடிந்தது. இப்போது உங்கள் கணக்கு உருவாக்கத்தை உறுதிப்படுத்தலாம்.';

  @override
  String get google_challengeExpired =>
      'சரிபார்ப்பு காலாவதியாகிவிட்டது. உறுதிப்படுத்தும் முன் மீண்டும் முடிக்கவும்.';

  @override
  String get google_challengeCancelled =>
      'சரிபார்ப்பு ரத்துசெய்யப்பட்டது. மீண்டும் முயற்சிக்கலாம்.';

  @override
  String get google_challengeFailed =>
      'பாதுகாப்புச் சரிபார்ப்பு தோல்வியடைந்தது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get billing_trialTitle => 'Fuze Premium-ஐ இலவசமாக முயற்சிக்கவும்';

  @override
  String get billing_trialSubtitle =>
      'இன்றிலிருந்தே உங்கள் இணைப்பைப் பாதுகாக்கவும்.';

  @override
  String get billing_trialWeeks => '2 வார இலவச சோதனை';

  @override
  String billing_trialDays(String days) {
    return '$days நாள் இலவச சோதனை';
  }

  @override
  String get billing_trialStart => 'எனது இலவச சோதனையைத் தொடங்கவும்';

  @override
  String billing_trialFirstCharge(String date) {
    return 'இன்று தொடங்கினால், உங்கள் முதல் கட்டணம் $date அன்று வசூலிக்கப்படும் என எதிர்பார்க்கப்படுகிறது.';
  }

  @override
  String get billing_trialTerms =>
      'குறிப்பிட்ட விலையில் தானாகப் புதுப்பிக்கப்படும். கட்டணம் வசூலிக்கப்படுவதைத் தவிர்க்க, சோதனைக் காலம் முடிவதற்கு முன் Google Play-இல் ரத்துசெய்யவும்.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'பிறகு மாதத்திற்கு $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'பிறகு ஆண்டுக்கு $price';
  }

  @override
  String get billing_choosePeriod => 'உங்கள் திட்டத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get billing_selectionHint => 'தொடர ஒரு திட்டத்தைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get billing_benefitConnection => 'குறியாக்கம் செய்யப்பட்ட இணைப்பு';

  @override
  String get billing_benefitPrivacy => 'ஆன்லைன் தனியுரிமை';

  @override
  String get billing_benefitNoAccount => 'பதிவு தேவையில்லை';

  @override
  String get billing_cancellation => 'Google Play-இல் ரத்துசெய்யவும்';

  @override
  String get billing_premiumTitle =>
      'மேலும் சிறப்பாகப் பாதுகாக்கப்பட்ட இணைப்பு.';

  @override
  String get billing_premiumSubtitle =>
      'உங்கள் வேகத்திற்கேற்ப உங்கள் இணைப்பைப் பாதுகாக்கவும்.';

  @override
  String get billing_priceMonthly => 'மாதத்திற்கு';

  @override
  String get billing_priceYearly => 'ஆண்டுக்கு';

  @override
  String get billing_trialToday => 'இன்று செலுத்த எதுவும் இல்லை';

  @override
  String get billing_trialConfirmation =>
      'நீங்கள் உறுதிப்படுத்துவதற்கு முன், தேதிகள், இறுதித் தொகை மற்றும் பொருந்தக்கூடிய வரிகளை Google Play உறுதிப்படுத்தும்.';

  @override
  String get billing_offerChanged =>
      'இந்தச் சலுகையின் விதிமுறைகள் மாறிவிட்டன. திட்டங்களைப் புதுப்பித்து மீண்டும் தேர்ந்தெடுக்கவும்.';

  @override
  String get status_waitingNetwork => 'நெட்வொர்க் காத்திருப்பு';

  @override
  String get status_waitingNetworkDetail =>
      'நெட்வொர்க் எதுவும் கிடைக்கவில்லை. நெட்வொர்க் திரும்பியதும் VPN இணைப்பைச் சரிபார்க்கும்.';

  @override
  String get locations_favoriteLoadFailed =>
      'பிடித்தவற்றை ஏற்ற முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get locations_favoritesLoading => 'பிடித்தவை ஏற்றப்படுகின்றன…';
}
