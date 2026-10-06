// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get accountRestoration_title => 'खाता अस्थायी रूप से अनुपलब्ध है';

  @override
  String get accountRestoration_message =>
      'आपका सत्र सुरक्षित रखा गया है। अपना खाता पुनर्स्थापित करने के लिए फिर प्रयास करें; आप यहां VPN कनेक्शन प्रबंधित कर सकते हैं।';

  @override
  String get action_retry => 'फिर प्रयास करें';

  @override
  String get session_endingTitle => 'सत्र समाप्त किया जा रहा है';

  @override
  String get session_ending =>
      'आपका सत्र अमान्य कर दिया गया है। VPN बंद किया जा रहा है और सत्र हटाया जा रहा है…';

  @override
  String get session_stopFailed =>
      'VPN बंद होने की पुष्टि नहीं हुई। दोबारा साइन इन करने से पहले फिर प्रयास करें।';

  @override
  String get session_cleanupFailed =>
      'VPN बंद है, लेकिन सत्र हटने की पुष्टि नहीं हुई। सफाई के लिए फिर प्रयास करें।';

  @override
  String get session_retryStop => 'बंद करने का फिर प्रयास करें';

  @override
  String get session_retryCleanup => 'सफाई का फिर प्रयास करें';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN को सुरक्षित रूप से तैयार किया जा रहा है…';

  @override
  String get nav_connection => 'कनेक्शन';

  @override
  String get nav_locations => 'स्थान';

  @override
  String get nav_account => 'खाता';

  @override
  String get nav_devices => 'डिवाइस';

  @override
  String get nav_settings => 'सेटिंग';

  @override
  String get action_refresh => 'रिफ्रेश करें';

  @override
  String get auth_tab_login => 'साइन इन करें';

  @override
  String get auth_tab_register => 'साइन अप करें';

  @override
  String get auth_stepAccount => 'खाता';

  @override
  String get auth_stepIdentity => 'पहचान';

  @override
  String get auth_stepAddress => 'पता और सहमतियां';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'चरण $current, कुल $total में से';
  }

  @override
  String get auth_tagline => 'आपका VPN, सरल बनाया गया।';

  @override
  String get auth_keysLocal => 'आपकी निजी VPN कुंजियां इसी डिवाइस पर रहती हैं।';

  @override
  String get form_email => 'ईमेल पता';

  @override
  String get form_password => 'पासवर्ड';

  @override
  String get form_showPassword => 'पासवर्ड दिखाएं';

  @override
  String get form_hidePassword => 'पासवर्ड छिपाएं';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 बाइट। कुछ वर्ण एक से अधिक बाइट लेते हैं।';

  @override
  String get form_firstName => 'पहला नाम';

  @override
  String get form_lastName => 'उपनाम';

  @override
  String get form_phone => 'फ़ोन (+33612345678)';

  @override
  String get form_address => 'पता';

  @override
  String get form_address2 => 'पते की दूसरी पंक्ति (वैकल्पिक)';

  @override
  String get form_postalCode => 'पिन कोड';

  @override
  String get form_city => 'शहर';

  @override
  String get form_country => 'देश का कोड (जैसे FR)';

  @override
  String get action_login => 'साइन इन करें';

  @override
  String get action_createAccount => 'खाता बनाएं';

  @override
  String get action_createMyAccount => 'मेरा खाता बनाएं';

  @override
  String get action_next => 'जारी रखें';

  @override
  String get action_previous => 'वापस';

  @override
  String get action_forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get auth_noAccount => 'अभी तक खाता नहीं है?';

  @override
  String get auth_requiredInformation => 'तीन चरणों में अपना खाता बनाएं।';

  @override
  String get auth_termsPrefix => 'मैं इन शर्तों से सहमत हूं: ';

  @override
  String get auth_termsLink => 'उपयोग की शर्तें';

  @override
  String get auth_privacyPrefix => 'मैं इस नीति से सहमत हूं: ';

  @override
  String get auth_privacyLink => 'गोपनीयता नीति';

  @override
  String get auth_consentRequired => 'खाता बनाने के लिए आपकी सहमति आवश्यक है।';

  @override
  String get validation_required => 'यह फ़ील्ड आवश्यक है।';

  @override
  String get validation_email => 'मान्य ईमेल पता दर्ज करें।';

  @override
  String get validation_password =>
      'पासवर्ड बहुत छोटा है: कम से कम 8 UTF-8 बाइट आवश्यक हैं।';

  @override
  String get validation_passwordTooLong =>
      'पासवर्ड बहुत लंबा है: अधिकतम 72 UTF-8 बाइट हो सकते हैं।';

  @override
  String get validation_phone =>
      'अंतरराष्ट्रीय प्रारूप का उपयोग करें, जैसे +33612345678।';

  @override
  String get validation_country =>
      'दो अक्षरों वाला देश कोड उपयोग करें, जैसे FR।';

  @override
  String get passwordReset_title => 'पासवर्ड रीसेट करें';

  @override
  String get passwordReset_description =>
      'पासवर्ड रीसेट लिंक का अनुरोध करने के लिए अपने खाते का ईमेल पता दर्ज करें।';

  @override
  String get passwordReset_send => 'लिंक भेजें';

  @override
  String get connection_title => 'आपका कनेक्शन';

  @override
  String get connection_subtitle => 'स्थान चुनें, फिर अपना VPN चालू करें।';

  @override
  String get connection_prepare => 'कनेक्ट करने के लिए तैयार हैं?';

  @override
  String get connection_advancedOptions => 'उन्नत विकल्प';

  @override
  String get connection_location => 'स्थान';

  @override
  String get connection_chooseLocation => 'स्थान चुनें';

  @override
  String get connection_protocol => 'प्रोटोकॉल';

  @override
  String get connection_connect => 'कनेक्ट करें';

  @override
  String get connection_connecting => 'कनेक्ट किया जा रहा है…';

  @override
  String get connection_disconnect => 'डिस्कनेक्ट करें';

  @override
  String get connection_disconnecting => 'डिस्कनेक्ट किया जा रहा है';

  @override
  String get connection_locationChange => 'स्थान बदला जा रहा है…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol अनुपलब्ध है';
  }

  @override
  String get connection_activeLocation => 'सक्रिय स्थान';

  @override
  String get connection_duration => 'अवधि';

  @override
  String get connection_received => 'प्राप्त';

  @override
  String get connection_sent => 'भेजा गया';

  @override
  String get connection_lastHandshake => 'अंतिम सुरक्षित आदान-प्रदान';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration पहले';
  }

  @override
  String get verification_title => 'अपने ईमेल पते की पुष्टि करें';

  @override
  String get verification_message =>
      'इस फ़ोन पर VPN का उपयोग करने के लिए अपने ईमेल पते की पुष्टि करें।';

  @override
  String get verification_resend => 'ईमेल फिर भेजें';

  @override
  String get migration_title => 'स्थान परिवर्तन';

  @override
  String get migration_draining => 'स्थान परिवर्तन की तैयारी की जा रही है…';

  @override
  String get migration_activating => 'नया सर्वर सक्रिय किया जा रहा है…';

  @override
  String get migration_ready => 'स्थान अपडेट कर दिया गया है।';

  @override
  String get migration_blocked =>
      'स्थान परिवर्तन के लिए सर्वर हस्तक्षेप आवश्यक है। बाद में फिर प्रयास करें या सहायता से संपर्क करें।';

  @override
  String get migration_progress => 'स्थान परिवर्तन की प्रगति';

  @override
  String migration_retryDelay(Object seconds) {
    return 'जांचों के बीच विलंब: $seconds सेकंड।';
  }

  @override
  String get migration_resume => 'स्थान परिवर्तन जारी रखें';

  @override
  String get status_authorizing => 'अनुमति आवश्यक है';

  @override
  String get status_authorizingDetail =>
      'VPN की अनुमति देने के लिए Android का अनुरोध स्वीकार करें।';

  @override
  String get status_preparing => 'तैयारी की जा रही है';

  @override
  String get status_preparingDetail =>
      'आपका सुरक्षित कनेक्शन तैयार किया जा रहा है।';

  @override
  String get status_reconnecting => 'फिर से कनेक्ट किया जा रहा है…';

  @override
  String get status_reconnectingDetail =>
      'कनेक्शन बाधित हुआ। VPN फिर से कनेक्ट करने का प्रयास कर रहा है।';

  @override
  String get status_connecting => 'कनेक्ट किया जा रहा है';

  @override
  String get status_connectingDetail => 'VPN सर्वर से कनेक्ट किया जा रहा है…';

  @override
  String get status_connected => 'कनेक्टेड';

  @override
  String get status_connectedDetail => 'आपका VPN कनेक्शन सक्रिय है।';

  @override
  String get status_disconnecting => 'डिस्कनेक्ट किया जा रहा है';

  @override
  String get status_disconnectingDetail =>
      'आपका VPN कनेक्शन बंद किया जा रहा है।';

  @override
  String get status_error => 'कनेक्शन अनुपलब्ध है';

  @override
  String get status_errorDetail =>
      'VPN कनेक्शन की पुष्टि नहीं हुई। फिर प्रयास करें।';

  @override
  String get status_idle => 'डिस्कनेक्टेड';

  @override
  String get status_idleDetail =>
      'अपने कनेक्शन की सुरक्षा के लिए VPN कनेक्ट करें।';

  @override
  String get trust_note =>
      'ऐप बंद करने से VPN बंद नहीं होता। इसे बंद करने के लिए डिस्कनेक्ट करें का उपयोग करें।';

  @override
  String get locations_none => 'इस समय कोई स्थान उपलब्ध नहीं है।';

  @override
  String get locations_available => 'अपना अगला स्थान चुनें।';

  @override
  String get locations_selected => 'चयनित स्थान';

  @override
  String get locations_select => 'यह स्थान चुनें';

  @override
  String get locations_lockedTunnel =>
      'स्थान बदलने के लिए VPN डिस्कनेक्ट करें।';

  @override
  String get locations_lockedMigration =>
      'स्थान परिवर्तन पूरा होने तक प्रतीक्षा करें।';

  @override
  String get devices_title => 'आपके डिवाइस';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit डिवाइस';
  }

  @override
  String get devices_refresh => 'डिवाइस रिफ्रेश करें';

  @override
  String get devices_empty => 'अभी तक कोई VPN डिवाइस पंजीकृत नहीं है।';

  @override
  String get devices_firstConnection =>
      'पहली बार कनेक्ट करने पर आपका फ़ोन जोड़ दिया जाएगा।';

  @override
  String get devices_thisDevice => 'यह डिवाइस';

  @override
  String devices_added(Object date) {
    return '$date को जोड़ा गया';
  }

  @override
  String get action_remove => 'हटाएं';

  @override
  String get settings_title => 'सेटिंग';

  @override
  String get settings_subtitle => 'आपकी पसंद और खाता, सब एक ही जगह।';

  @override
  String get settings_appearance => 'दिखावट';

  @override
  String get settings_language => 'भाषा';

  @override
  String get settings_languageDescription =>
      'आपकी चुनी हुई भाषा VPN सूचनाओं पर भी लागू होती है।';

  @override
  String get settings_account => 'खाता';

  @override
  String get settings_signOut => 'साइन आउट करें';

  @override
  String get settings_privacy => 'गोपनीयता नीति';

  @override
  String get settings_terms => 'उपयोग की शर्तें';

  @override
  String get settings_security => 'सुरक्षा और पारदर्शिता';

  @override
  String get settings_licenses => 'घटक लाइसेंस';

  @override
  String get settings_licensesDetail => 'ऐप में उपयोग किया गया सॉफ़्टवेयर';

  @override
  String get settings_background =>
      'ऐप छोड़ने पर VPN चालू रहता है। इसे बंद करने के लिए कनेक्शन टैब में डिस्कनेक्ट करें का उपयोग करें।';

  @override
  String get theme_system => 'सिस्टम';

  @override
  String get theme_light => 'हल्का';

  @override
  String get theme_dark => 'गहरा';

  @override
  String get language_system => 'फ़ोन की भाषा';

  @override
  String get language_fr => 'फ़्रेंच';

  @override
  String get language_en => 'अंग्रेज़ी';

  @override
  String get language_es => 'स्पेनी';

  @override
  String get language_de => 'जर्मन';

  @override
  String get dialog_removeDevice => 'यह डिवाइस हटाएं?';

  @override
  String get dialog_removeCurrent =>
      'यह फ़ोन VPN से डिस्कनेक्ट हो जाएगा और इसकी पहुंच समाप्त हो जाएगी। सर्वर की पुष्टि के बाद इसका VPN कनेक्शन डेटा हटा दिया जाएगा।';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” की VPN पहुंच रद्द कर दी जाएगी। इसे वापस नहीं किया जा सकता।';
  }

  @override
  String get dialog_signOut => 'साइन आउट करें?';

  @override
  String get dialog_signOutMessage =>
      'VPN बंद हो जाएगा और आपको फिर से साइन इन करना होगा। आपके एन्क्रिप्ट किए गए VPN कुंजी अगले कनेक्शन के लिए इसी फ़ोन पर रहेंगी।';

  @override
  String get action_cancel => 'रद्द करें';

  @override
  String get action_signOut => 'साइन आउट करें';

  @override
  String get notice_close => 'संदेश खारिज करें';

  @override
  String get notice_sessionExpired_title => 'सत्र समाप्त हो गया';

  @override
  String get notice_sessionExpired_message =>
      'आपका सत्र समाप्त हो गया है। फिर से साइन इन करें।';

  @override
  String get notice_connectionFailed_title => 'कनेक्शन विफल रहा';

  @override
  String get notice_invalidCredentials_message => 'ईमेल पता या पासवर्ड गलत है।';

  @override
  String get notice_emailVerification_title => 'ईमेल पुष्टि आवश्यक है';

  @override
  String get notice_emailVerification_message =>
      'VPN डिवाइस जोड़ने से पहले अपने ईमेल पते की पुष्टि करें।';

  @override
  String get notice_rateLimited_title => 'बहुत अधिक प्रयास';

  @override
  String get notice_deviceLimit_title => '2 डिवाइस की सीमा पूरी हो गई';

  @override
  String get notice_deviceLimit_message =>
      'दूसरा डिवाइस जोड़ने से पहले कोई मौजूदा डिवाइस हटाएं।';

  @override
  String get notice_identityRenewal_title => 'VPN पहचान का नवीनीकरण आवश्यक है';

  @override
  String get notice_identityRenewal_message =>
      'यह पहचान हटा दी गई है। नई स्थानीय पहचान बनाएं।';

  @override
  String get notice_migrationPending_title => 'स्थान परिवर्तन जारी है';

  @override
  String get notice_migrationPending_message =>
      'स्थान परिवर्तन पहले से जारी है।';

  @override
  String get notice_migrationBlocked_title => 'स्थान परिवर्तन अवरुद्ध है';

  @override
  String get notice_migrationBlocked_message =>
      'स्थान परिवर्तन के लिए सर्वर हस्तक्षेप आवश्यक है। बाद में फिर प्रयास करें या सहायता से संपर्क करें।';

  @override
  String get notice_targetUnavailable_title =>
      'सर्वर अस्थायी रूप से अनुपलब्ध है';

  @override
  String get notice_targetUnavailable_message =>
      'यह सर्वर अस्थायी रूप से अनुपलब्ध है।';

  @override
  String get notice_networkUnavailable_title => 'इंटरनेट कनेक्शन अनुपलब्ध है';

  @override
  String get notice_networkUnavailable_message =>
      'अपना कनेक्शन जांचें और फिर प्रयास करें।';

  @override
  String get notice_permissionDenied_title => 'VPN अनुमति अस्वीकार की गई';

  @override
  String get notice_permissionDenied_message =>
      'कनेक्शन फिर शुरू करें और Android की अनुमति का अनुरोध स्वीकार करें।';

  @override
  String get notice_wireguardTimeout_title => 'सर्वर उत्तर नहीं दे रहा';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard कनेक्शन में बहुत अधिक समय लगा। फिर प्रयास करें या कोई दूसरा स्थान चुनें।';

  @override
  String get notice_tlsFailed_title => 'सुरक्षित कनेक्शन अस्वीकार किया गया';

  @override
  String get notice_tlsFailed_message =>
      'सर्वर ने OpenVPN कनेक्शन स्वीकार नहीं किया। फिर प्रयास करें। समस्या बनी रहने पर निदान चलाएं।';

  @override
  String get notice_tunRejected_title =>
      'Android ने VPN इंटरफ़ेस अस्वीकार कर दिया';

  @override
  String get notice_tunRejected_message =>
      'Android ने OpenVPN द्वारा अनुरोधित नेटवर्क कॉन्फ़िगरेशन अस्वीकार कर दिया।';

  @override
  String get notice_openvpnStart_title => 'OpenVPN शुरू नहीं हो सका';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN इंजन शुरू होना पूरा नहीं कर सका। फिर प्रयास करें। समस्या बनी रहने पर सहायता से संपर्क करें।';

  @override
  String notice_diagnosticCode(Object code) {
    return 'निदान कोड: $code';
  }

  @override
  String get notice_generic_title => 'VPN कनेक्शन विफल रहा';

  @override
  String get notice_generic_message =>
      'एक त्रुटि हुई। बाद में फिर प्रयास करें।';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'खाता बनाया गया',
      'password_reset_sent': 'पासवर्ड रीसेट अनुरोध प्राप्त हुआ',
      'verification_email_sent': 'पुष्टिकरण ईमेल भेजा गया',
      'location_migration_pending': 'स्थान परिवर्तन जारी है',
      'vpn_sign_in_required': 'साइन इन आवश्यक है',
      'protocol_unavailable_at_location': 'प्रोटोकॉल अनुपलब्ध है',
      'vpn_permission_denied': 'VPN अनुमति अस्वीकार की गई',
      'revoked_identity_device_limit': '2 डिवाइस की सीमा पूरी हो गई',
      'tunnel_start_unexpected': 'VPN शुरू नहीं हो सका',
      'flutter_disconnect_timeout': 'डिस्कनेक्शन की पुष्टि नहीं हुई',
      'flutter_disconnect_unexpected': 'डिस्कनेक्ट नहीं किया जा सका',
      'device_revoked': 'डिवाइस हटा दिया गया',
      'revoke_unexpected': 'डिवाइस हटाया नहीं जा सका',
      'identity_renewal_unexpected': 'पहचान का नवीनीकरण नहीं हो सका',
      'openvpn_renewal_unexpected': 'OpenVPN का नवीनीकरण नहीं हो सका',
      'location_migration_blocked': 'स्थान परिवर्तन अवरुद्ध है',
      'location_migration_slow': 'स्थान परिवर्तन अभी भी जारी है',
      'location_migration_conflict': 'स्थान परिवर्तन के लिए रिफ्रेश आवश्यक है',
      'location_migration_verification_failed':
          'स्थान परिवर्तन की पुष्टि नहीं हुई',
      'location_migration_device_changed':
          'स्थान परिवर्तन के दौरान डिवाइस बदल गया',
      'tunnel_stop_failed': 'स्थान परिवर्तन अनुपलब्ध है',
      'other': 'ऑपरेशन विफल रहा',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'खाता बनाया गया, लेकिन पुष्टिकरण ईमेल नहीं भेजा जा सका। ऐप में फिर भेजें का उपयोग करें।',
      'password_reset_sent':
          'आपका अनुरोध प्राप्त हो गया। यदि इस पते से कोई खाता जुड़ा है, तो आपको ईमेल मिल सकता है। अपना स्पैम फ़ोल्डर भी जांचें।',
      'verification_email_sent': 'नया पुष्टिकरण ईमेल अभी भेजा गया है।',
      'location_migration_pending':
          '$target पर जाने की तैयारी अभी जारी है। डिवाइस को फिर से बनाए बिना इसे जारी रख सकते हैं।',
      'vpn_sign_in_required':
          'VPN शुरू करने से पहले अपने खाते में साइन इन करें।',
      'protocol_unavailable_at_location':
          'चयनित प्रोटोकॉल इस स्थान पर उपलब्ध नहीं है। स्थान रिफ्रेश करें या कोई दूसरा प्रोटोकॉल चुनें।',
      'vpn_permission_denied':
          'Android ने VPN अनुमति अस्वीकार कर दी। कनेक्शन फिर शुरू करें और सिस्टम अनुरोध स्वीकार करें।',
      'revoked_identity_device_limit':
          'इस डिवाइस की VPN पहुंच हटा दी गई है और डिवाइस की सीमा पूरी हो गई है। खाता → मेरे डिवाइस प्रबंधित करें में जाकर कोई डिवाइस हटाएं।',
      'tunnel_start_unexpected':
          'एक अनपेक्षित त्रुटि ने टनल की तैयारी बाधित कर दी। निदान कोड जांचें और फिर प्रयास करें।',
      'flutter_disconnect_timeout':
          'Android ने समय पर VPN के रुकने की पुष्टि नहीं की। इसे फिर रोकने का प्रयास करें।',
      'flutter_disconnect_unexpected':
          'एक अनपेक्षित त्रुटि के कारण टनल के रुकने की पुष्टि नहीं हो सकी।',
      'device_revoked':
          'डिवाइस की VPN पहुंच रद्द कर दी गई और उसके स्थानीय गुप्त डेटा हटा दिए गए।',
      'revoke_unexpected':
          'डिवाइस हटाया नहीं जा सका। सूची रिफ्रेश करें और फिर प्रयास करें।',
      'identity_renewal_unexpected':
          'नई VPN पहचान बनाई नहीं जा सकी। डिवाइस रिफ्रेश करें और फिर प्रयास करें।',
      'openvpn_renewal_unexpected':
          'OpenVPN प्रोफ़ाइल का नवीनीकरण नहीं हो सका। फिर प्रयास करें या निदान कोड जांचें।',
      'location_migration_blocked':
          'सर्वर अभी यह परिवर्तन पूरा नहीं कर सकता। डिवाइस और उसकी स्थानीय पहचान सुरक्षित रखी गई है।',
      'location_migration_slow':
          'सर्वर अभी भी $target पर जाने की तैयारी कर रहा है। कुछ क्षण बाद जारी रखें का उपयोग करें।',
      'location_migration_conflict':
          'सर्वर पर डिवाइस की स्थिति बदल गई। डिवाइस रिफ्रेश करें, फिर परिवर्तन जारी रखें।',
      'location_migration_verification_failed':
          'सर्वर ने नए स्थान की पुष्टि नहीं की। पिछली स्थानीय पहचान सुरक्षित रखी गई है।',
      'location_migration_device_changed':
          'सर्वर द्वारा लौटाया गया डिवाइस बदले जा रहे डिवाइस से मेल नहीं खाता। फिर प्रयास करने से पहले डिवाइस रिफ्रेश करें।',
      'tunnel_stop_failed':
          'नए कनेक्शन से पहले पिछले टनल को पूरी तरह रोकना आवश्यक है।',
      'other':
          'ऑपरेशन पूरा नहीं किया जा सका। फिर प्रयास करें या निदान कोड सहायता टीम को भेजें।',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'सत्र समाप्त हो गया',
      'invalid_credentials': 'साइन इन विफल रहा',
      'email_verification_required': 'ईमेल पुष्टि आवश्यक है',
      'verification_email_cooldown': 'ईमेल पहले ही भेजा जा चुका है',
      'rate_limited': 'बहुत अधिक प्रयास',
      'invalid_registration': 'जानकारी सुधारना आवश्यक है',
      'email_exists': 'खाता पहले से मौजूद है',
      'invalid_profile': 'अमान्य प्रोफ़ाइल',
      'invalid_device': 'अमान्य डिवाइस',
      'invalid_location': 'स्थान अनुपलब्ध है',
      'device_limit': '2 डिवाइस की सीमा पूरी हो गई',
      'device_exists': 'VPN पहचान पहले से उपयोग में है',
      'device_identity_revoked': 'VPN पहचान का नवीनीकरण आवश्यक है',
      'device_location_locked': 'स्थान परिवर्तन के लिए रिफ्रेश आवश्यक है',
      'location_migration_pending': 'स्थान परिवर्तन जारी है',
      'location_migration_blocked': 'स्थान परिवर्तन अवरुद्ध है',
      'target_ca_mismatch': 'OpenVPN सर्वर असंगत है',
      'location_migration_conflict': 'स्थान परिवर्तन के लिए रिफ्रेश आवश्यक है',
      'server_full': 'सर्वर भर गया है',
      'capacity_unavailable': 'स्थान अस्थायी रूप से अनुपलब्ध है',
      'target_unavailable': 'सर्वर अस्थायी रूप से अनुपलब्ध है',
      'not_found': 'आइटम नहीं मिला',
      'invalid_openvpn_csr': 'अमान्य OpenVPN पहचान',
      'openvpn_profile_exists': 'OpenVPN प्रोफ़ाइल पहले से मौजूद है',
      'openvpn_profile_revoked': 'OpenVPN प्रोफ़ाइल रद्द की गई',
      'openvpn_operation_pending': 'OpenVPN ऑपरेशन जारी है',
      'openvpn_operation_terminal': 'OpenVPN ऑपरेशन बाधित हुआ',
      'openvpn_address_unavailable': 'OpenVPN पता अनुपलब्ध है',
      'openvpn_profile_conflict': 'OpenVPN विरोध',
      'openvpn_signer_unavailable': 'OpenVPN अनुपलब्ध है',
      'email_delivery_unavailable': 'ईमेल अनुपलब्ध है',
      'invalid_token': 'अमान्य लिंक',
      'network_unavailable': 'इंटरनेट कनेक्शन अनुपलब्ध है',
      'invalid_json': 'अमान्य अनुरोध',
      'invalid_api_response': 'अमान्य सर्वर प्रतिक्रिया',
      'ipv6_unavailable': 'IPv6 अनुपलब्ध है',
      'invalid_ip_families': 'नेटवर्क कॉन्फ़िगरेशन अस्वीकार किया गया',
      'other': 'सेवा अनुपलब्ध है',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'आपका सत्र समाप्त हो गया है। फिर से साइन इन करें।',
      'invalid_credentials': 'ईमेल पता या पासवर्ड गलत है।',
      'email_verification_required':
          'VPN डिवाइस जोड़ने से पहले अपने ईमेल पते की पुष्टि करें।',
      'invalid_registration': 'मांगी गई जानकारी और सहमतियों की जांच करें।',
      'email_exists': 'इस ईमेल पते से एक खाता पहले से जुड़ा है।',
      'invalid_profile': 'अपनी प्रोफ़ाइल जानकारी जांचें।',
      'invalid_device': 'इस डिवाइस का नाम या स्थानीय पहचान अमान्य है।',
      'invalid_location': 'स्थान सूची रिफ्रेश करें और फिर प्रयास करें।',
      'device_limit': 'दूसरा डिवाइस जोड़ने से पहले कोई मौजूदा डिवाइस हटाएं।',
      'device_exists': 'यह VPN पहचान पहले से किसी दूसरे खाते से जुड़ी है।',
      'device_identity_revoked':
          'यह पहचान हटा दी गई है। नई स्थानीय पहचान बनाना आवश्यक है।',
      'device_location_locked':
          'इस डिवाइस का स्थान अभी बदला गया है। ऐप जारी परिवर्तन को फिर शुरू करेगा।',
      'location_migration_pending': 'स्थान परिवर्तन पहले से जारी है।',
      'location_migration_blocked':
          'स्थान परिवर्तन के लिए सर्वर हस्तक्षेप आवश्यक है। बाद में फिर प्रयास करें या सहायता से संपर्क करें।',
      'target_ca_mismatch':
          'यह सर्वर अभी मौजूदा OpenVPN प्रोफ़ाइल के साथ संगत नहीं है।',
      'location_migration_conflict':
          'डिवाइस रिफ्रेश करें, फिर स्थान परिवर्तन का दोबारा प्रयास करें।',
      'server_full':
          'इस स्थान ने अपनी कनेक्शन सीमा पूरी कर ली है। कोई दूसरा स्थान चुनें या बाद में फिर प्रयास करें।',
      'capacity_unavailable':
          'हम अभी पुष्टि नहीं कर सकते कि यह स्थान उपलब्ध है या नहीं। कोई दूसरा स्थान चुनें या बाद में फिर प्रयास करें।',
      'target_unavailable': 'यह सर्वर अस्थायी रूप से अनुपलब्ध है।',
      'not_found': 'यह आइटम अब आपके खाते में उपलब्ध नहीं है।',
      'invalid_openvpn_csr': 'नई OpenVPN पहचान बनाएं और फिर प्रयास करें।',
      'openvpn_profile_exists':
          'इस डिवाइस के लिए OpenVPN प्रोफ़ाइल पहले से मौजूद है।',
      'openvpn_profile_revoked':
          'जारी रखने के लिए OpenVPN प्रोफ़ाइल का नवीनीकरण करें।',
      'openvpn_operation_pending':
          'परिवर्तन अभी लागू हो रहा है। बाद में फिर प्रयास करें।',
      'openvpn_operation_terminal':
          'नई OpenVPN पहचान बनाएं और फिर प्रयास करें।',
      'openvpn_address_unavailable': 'इस समय कोई OpenVPN पता उपलब्ध नहीं है।',
      'openvpn_profile_conflict':
          'प्रोफ़ाइल बदल गई। डिवाइस रिफ्रेश करें और फिर प्रयास करें।',
      'openvpn_signer_unavailable': 'OpenVPN सेवा अस्थायी रूप से अनुपलब्ध है।',
      'email_delivery_unavailable':
          'ईमेल भेजा नहीं जा सका। बाद में फिर प्रयास करें।',
      'invalid_token':
          'यह लिंक अमान्य है या इसकी अवधि समाप्त हो गई है। नया लिंक मांगें।',
      'network_unavailable': 'अपना इंटरनेट कनेक्शन जांचें और फिर प्रयास करें।',
      'invalid_json': 'दर्ज की गई जानकारी जांचें और फिर प्रयास करें।',
      'invalid_api_response':
          'सर्वर ने अनपेक्षित प्रतिक्रिया दी। बाद में फिर प्रयास करें।',
      'ipv6_unavailable':
          'सर्वर इस समय IPv6 सक्रिय नहीं कर सकता। बाद में फिर प्रयास करें।',
      'invalid_ip_families':
          'टनल कॉन्फ़िगरेशन अधूरा है या अधिकृत पतों से मेल नहीं खाता। ऐप से फिर प्रयास करें।',
      'other': 'सर्वर में त्रुटि हुई। बाद में फिर प्रयास करें।',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'कुछ क्षण बाद फिर प्रयास करें।';

  @override
  String notice_retryAfter(Object seconds) {
    return '$seconds सेकंड बाद फिर प्रयास करें।';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'सिस्टम VPN फिर शुरू करना अनुपलब्ध है',
      'system_vpn_resume_corrupt': 'सिस्टम VPN फिर शुरू करने का डेटा अमान्य है',
      'system_vpn_resume_session_invalid':
          'VPN फिर शुरू करने का सत्र अमान्य है',
      'system_vpn_resume_identity_changed': 'VPN पहचान बदल गई',
      'system_vpn_resume_identity_invalid':
          'VPN फिर शुरू करने की पहचान अमान्य है',
      'system_vpn_resume_storage_failed':
          'VPN फिर शुरू करने का संग्रहण अनुपलब्ध है',
      'system_vpn_resume_network_timeout':
          'VPN फिर शुरू करने के लिए नेटवर्क नहीं है',
      'system_vpn_resume_blocked': 'VPN फिर शुरू करना अवरुद्ध है',
      'system_vpn_resume_failed': 'VPN फिर शुरू करना विफल रहा',
      'system_vpn_resume_error_invalid':
          'VPN फिर शुरू करने की त्रुटि अमान्य है',
      'wireguard_identity_store_failed': 'WireGuard पहचान सहेजी नहीं गई',
      'wireguard_identity_unavailable': 'WireGuard पहचान अनुपलब्ध है',
      'vpn_host_destroyed': 'Android VPN होस्ट रुक गया',
      'vpn_host_unavailable': 'Android VPN होस्ट अनुपलब्ध है',
      'vpn_permission_required': 'VPN अनुमति आवश्यक है',
      'vpn_permission_denied': 'VPN अनुमति अस्वीकार की गई',
      'vpn_permission_request_failed': 'अनुमति का अनुरोध नहीं किया जा सका',
      'wireguard_foreground_service_unavailable': 'WireGuard सेवा अनुपलब्ध है',
      'wireguard_identity_invalid': 'स्थानीय WireGuard कुंजी अमान्य है',
      'wireguard_identity_in_use': 'WireGuard पहचान पहले से उपयोग में है',
      'wireguard_configuration_invalid': 'WireGuard कॉन्फ़िगरेशन अमान्य है',
      'wireguard_operation_pending': 'WireGuard ऑपरेशन अभी भी सक्रिय है',
      'wireguard_start_failed': 'WireGuard शुरू करना अस्वीकार किया गया',
      'wireguard_stop_timeout': 'WireGuard के रुकने की पुष्टि नहीं हुई',
      'wireguard_handshake_timeout': 'WireGuard ने जवाब नहीं दिया',
      'openvpn_connection_timeout': 'OpenVPN ने जवाब नहीं दिया',
      'openvpn_core_unavailable': 'OpenVPN इंजन अनुपलब्ध है',
      'openvpn_operation_pending': 'OpenVPN सत्र अभी भी सक्रिय है',
      'openvpn_stop_timeout': 'OpenVPN के रुकने की पुष्टि नहीं हुई',
      'openvpn_profile_unavailable': 'स्थानीय OpenVPN प्रोफ़ाइल नहीं मिली',
      'openvpn_native_failed': 'मूल OpenVPN कॉल बाधित हुई',
      'openvpn_key_generation_failed': 'OpenVPN P-256 कुंजी नहीं बनाई जा सकी',
      'openvpn_csr_generation_failed': 'OpenVPN CSR नहीं बनाया जा सका',
      'openvpn_identity_store_failed': 'OpenVPN पहचान सहेजी नहीं गई',
      'openvpn_identity_clear_failed': 'OpenVPN हटाना अधूरा रहा',
      'openvpn_identity_in_use': 'OpenVPN पहचान अभी भी उपयोग में है',
      'openvpn_tls_verification_required': 'OpenVPN TLS सत्यापन अनुपलब्ध है',
      'openvpn_cipher_invalid': 'OpenVPN सिफ़र अमान्य है',
      'openvpn_profile_rejected': 'OpenVPN प्रोफ़ाइल अस्वीकार की गई',
      'openvpn_identity_inconsistent': 'OpenVPN पहचान असंगत है',
      'tls_handshake_failed': 'OpenVPN वार्ता अस्वीकार की गई',
      'tls_alert_unknown_ca': 'OpenVPN क्लाइंट प्रमाणपत्र पहचाना नहीं गया',
      'tls_alert_bad_certificate':
          'OpenVPN क्लाइंट प्रमाणपत्र अस्वीकार किया गया',
      'tls_alert_unsupported_certificate': 'OpenVPN प्रमाणपत्र समर्थित नहीं है',
      'tls_client_certificate_required': 'OpenVPN क्लाइंट प्रमाणपत्र आवश्यक है',
      'tls_alert_misc': 'OpenVPN TLS चेतावनी',
      'tls_signature_algorithm_rejected': 'OpenVPN हस्ताक्षर समर्थित नहीं है',
      'tls_handshake_rejected': 'OpenVPN TLS वार्ता अस्वीकार की गई',
      'tls_version_rejected': 'OpenVPN TLS संस्करण असंगत है',
      'tls_certificate_expired': 'TLS प्रमाणपत्र की अवधि समाप्त हो गई',
      'tls_certificate_revoked': 'TLS प्रमाणपत्र रद्द किया गया',
      'transport_failed': 'OpenVPN सर्वर तक पहुंच नहीं है',
      'tun_configuration_rejected': 'OpenVPN इंटरफ़ेस नहीं बनाया जा सका',
      'tun_setup_failed': 'OpenVPN TUN सेटअप विफल रहा',
      'tun_interface_create_failed': 'OpenVPN इंटरफ़ेस बनाना विफल रहा',
      'tun_interface_disabled': 'OpenVPN इंटरफ़ेस अक्षम है',
      'tun_halted': 'OpenVPN इंटरफ़ेस बाधित हुआ',
      'tun_already_established': 'OpenVPN इंटरफ़ेस पहले से खुला है',
      'tun_addresses_missing': 'OpenVPN पता नहीं मिला',
      'tun_routes_missing': 'OpenVPN रूट नहीं मिले',
      'tun_dns_missing': 'OpenVPN DNS नहीं मिला',
      'tun_permission_revoked': 'VPN अनुमति रद्द की गई',
      'tun_establish_returned_null': 'Android ने VPN इंटरफ़ेस अस्वीकार कर दिया',
      'openvpn_service_start_failed': 'OpenVPN सेवा अनुपलब्ध है',
      'openvpn_operation_timeout': 'OpenVPN कॉल का समय समाप्त हो गया',
      'openvpn_start_failed': 'OpenVPN शुरू करना अस्वीकार किया गया',
      'openvpn_connection_failed': 'OpenVPN कनेक्शन बाधित हुआ',
      'openvpn_core_status_error': 'OpenVPN Core त्रुटि के साथ समाप्त हुआ',
      'openvpn_stopped_before_connected': 'कनेक्ट होने से पहले OpenVPN रुक गया',
      'openvpn_auth_failed': 'OpenVPN प्रमाणीकरण अस्वीकार किया गया',
      'openvpn_client_setup_failed': 'OpenVPN क्लाइंट सेटअप विफल रहा',
      'openvpn_client_halted': 'OpenVPN क्लाइंट बाधित हुआ',
      'openvpn_client_restart': 'OpenVPN फिर शुरू करने का अनुरोध किया गया',
      'openvpn_inactive_timeout': 'OpenVPN बहुत देर तक निष्क्रिय रहा',
      'openvpn_session_expired': 'OpenVPN सत्र समाप्त हो गया',
      'openvpn_credentials_required': 'OpenVPN प्रमाणीकरण समर्थित नहीं है',
      'openvpn_proxy_failed': 'OpenVPN मध्यवर्ती परिवहन विफल रहा',
      'openvpn_compression_failed': 'OpenVPN संपीड़न अस्वीकार किया गया',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM एन्क्रिप्शन अनुपलब्ध है',
      'openvpn_feature_unsupported': 'OpenVPN सुविधा समर्थित नहीं है',
      'network_unavailable': 'इंटरनेट कनेक्शन अनुपलब्ध है',
      'network_lost': 'नेटवर्क अनुपलब्ध है',
      'certificate_validation_failed': 'सर्वर प्रमाणपत्र अस्वीकार किया गया',
      'openvpn_certificate_expired': 'OpenVPN प्रमाणपत्र की अवधि समाप्त हो गई',
      'tunnel_active_for_another_account': 'दूसरे खाते का टनल अभी भी सक्रिय है',
      'tunnel_already_active': 'मूल टनल पहले से सक्रिय है',
      'tunnel_stop_timeout': '$protocol के रुकने की पुष्टि नहीं हुई',
      'tunnel_disconnected': '$protocol बाधित हुआ',
      'native_bridge_unavailable': 'Android ब्रिज अनुपलब्ध है',
      'native_operation_failed': 'Android ऑपरेशन बाधित हुआ',
      'invalid_arguments': 'VPN पैरामीटर अधूरे हैं',
      'invalid_account_id': 'VPN खाता अमान्य है',
      'invalid_device_id': 'डिवाइस पहचानकर्ता अमान्य है',
      'storage_key_not_allowed': 'संग्रहण कुंजी अस्वीकार की गई',
      'secure_storage_read_failed': 'सुरक्षित पठन विफल रहा',
      'secure_storage_write_failed': 'सुरक्षित लेखन विफल रहा',
      'key_generation_failed': 'WireGuard कुंजी नहीं बनाई जा सकी',
      'csr_generation_failed': 'OpenVPN CSR नहीं बनाया जा सका',
      'other': 'वर्गीकृत न की गई मूल VPN त्रुटि',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android को फिर शुरू किए जा सकने वाला VPN सत्र नहीं मिला। ऐप में नया कनेक्शन शुरू करें।',
      'system_vpn_resume_corrupt':
          'सहेजा गया VPN पुनः आरंभ डेटा अमान्य है और उपयोग नहीं किया जाएगा। नया कनेक्शन शुरू करें।',
      'system_vpn_resume_session_invalid':
          'सहेजा गया सत्र अब VPN फिर शुरू नहीं कर सकता। ऐप में फिर से साइन इन करें।',
      'system_vpn_resume_identity_changed':
          'स्थानीय VPN पहचान बदल गई। फिर शुरू करना रोक दिया गया; नया कनेक्शन शुरू करें।',
      'system_vpn_resume_identity_invalid':
          'फिर शुरू करने की पहचान अमान्य है। नया कनेक्शन शुरू करें।',
      'system_vpn_resume_storage_failed':
          'Android एन्क्रिप्ट किए गए पुनः आरंभ डेटा को पढ़ या अपडेट नहीं कर सका। नया कनेक्शन शुरू करें।',
      'system_vpn_resume_network_timeout':
          'Android को VPN फिर शुरू करने के लिए समय पर नेटवर्क नहीं मिला। नेटवर्क उपलब्ध होने पर फिर प्रयास करें।',
      'system_vpn_resume_blocked':
          'VPN फिर शुरू करना अवरुद्ध है। Android सेटिंग जांचें, फिर नया कनेक्शन शुरू करें।',
      'system_vpn_resume_failed':
          'Android VPN फिर शुरू करना विफल रहा। ऐप में नया कनेक्शन शुरू करें।',
      'system_vpn_resume_error_invalid':
          'Android ने अनुपयोगी पुनः आरंभ त्रुटि लौटाई। नया कनेक्शन शुरू करें।',
      'wireguard_identity_store_failed':
          'Android इस खाते की एन्क्रिप्ट की गई WireGuard पहचान सहेज नहीं सका।',
      'wireguard_identity_unavailable':
          'इस कनेक्शन के लिए कोई उपयोग योग्य WireGuard पहचान उपलब्ध नहीं है।',
      'vpn_host_destroyed':
          'VPN होस्ट करने वाला Android घटक रोक दिया गया। नया कनेक्शन शुरू करें।',
      'vpn_host_unavailable':
          'Android VPN होस्ट करने वाला घटक नहीं बना सकता। VPN सेटिंग जांचने के बाद फिर प्रयास करें।',
      'openvpn_renewal_required':
          'कनेक्ट करने से पहले प्रमाणपत्र के लिए ऐप में कार्रवाई आवश्यक है।',
      'openvpn_recovery_failed':
          'स्वचालित पुनर्प्राप्ति विफल रही। ऐप में नया कनेक्शन शुरू करें।',
      'openvpn_recovery_exhausted':
          'स्वचालित पुनर्प्राप्ति पहले ही उपयोग की जा चुकी है। ऐप में नया कनेक्शन शुरू करें।',
      'vpn_permission_required':
          'टनल शुरू करने से पहले Android को नई VPN अनुमति चाहिए।',
      'vpn_permission_denied':
          'जारी रखने के लिए Android के अनुरोध में FuzeVPN की अनुमति दें।',
      'vpn_permission_request_failed':
          'Android VPN अनुमति स्क्रीन नहीं खोल सका।',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard सेवा को अग्रभूमि में नहीं रख सका।',
      'wireguard_identity_invalid':
          'इस खाते की एन्क्रिप्ट की गई WireGuard कुंजी पढ़ी नहीं जा सकती या अमान्य है।',
      'wireguard_identity_in_use':
          'एक अन्य ऑपरेशन अभी भी इस खाते की WireGuard कुंजी का उपयोग कर रहा है।',
      'wireguard_configuration_invalid':
          'प्राप्त WireGuard पता, DNS, सर्वर कुंजी या रूट अमान्य हैं।',
      'wireguard_operation_pending':
          'पिछले WireGuard ऑपरेशन ने अभी तक अपनी मूल सेवा मुक्त नहीं की है।',
      'wireguard_start_failed':
          'WireGuard इंजन ने कॉन्फ़िगरेशन सक्रिय करना अस्वीकार कर दिया।',
      'wireguard_stop_timeout':
          'WireGuard सेवा ने समय सीमा के भीतर VPN इंटरफ़ेस छोड़ने की पुष्टि नहीं की।',
      'wireguard_handshake_timeout':
          'टनल ने समय पर सर्वर के साथ हैंडशेक की पुष्टि नहीं की।',
      'openvpn_connection_timeout':
          'OpenVPN ने समय पर सर्वर से कनेक्शन की पुष्टि नहीं की।',
      'openvpn_core_unavailable':
          'ऐप के इस संस्करण में उपयोग योग्य OpenVPN इंजन नहीं है।',
      'openvpn_operation_pending':
          'मूल इंजन अभी भी पिछला OpenVPN सत्र रखे हुए है और दूसरा सत्र बनाने से इनकार कर रहा है।',
      'openvpn_stop_timeout':
          'OpenVPN Core ने समय सीमा के भीतर अपने मूल सत्र के रुकने और नष्ट होने की पुष्टि नहीं की।',
      'openvpn_profile_unavailable':
          'इस कनेक्शन के लिए कोई सत्यापित OpenVPN प्रोफ़ाइल पढ़ी नहीं जा सकती।',
      'openvpn_native_failed':
          'ऐप की त्रुटि ने OpenVPN को बाधित किया। फिर कनेक्ट करने का प्रयास करें। समस्या बनी रहने पर निदान चलाएं।',
      'openvpn_key_generation_failed':
          'Android Keystore गैर-निर्यात योग्य P-256 निजी कुंजी बना या पढ़ नहीं सका।',
      'openvpn_csr_generation_failed':
          'Android Keystore कुंजी OpenVPN प्रमाणपत्र अनुरोध पर हस्ताक्षर नहीं कर सकी।',
      'openvpn_identity_store_failed':
          'OpenVPN प्रमाणपत्र या प्रोफ़ाइल एन्क्रिप्ट किए गए संग्रहण में सहेजी नहीं जा सकी।',
      'openvpn_identity_clear_failed':
          'Android इस खाते की पूरी स्थानीय OpenVPN पहचान नहीं हटा सका।',
      'openvpn_identity_in_use':
          'मूल OpenVPN सत्र अभी भी इस डिवाइस की कुंजी या प्रमाणपत्र का उपयोग कर रहा है।',
      'openvpn_tls_verification_required':
          'प्रोफ़ाइल में सर्वर प्रमाणपत्र सत्यापन स्पष्ट रूप से आवश्यक नहीं है।',
      'openvpn_cipher_invalid':
          'सर्वर ने ऐसी एन्क्रिप्शन एल्गोरिदम दी जो अनुमत सूची में नहीं है।',
      'openvpn_profile_rejected':
          'सर्वर से प्राप्त प्रोफ़ाइल असंगत है। इस डिवाइस को फिर बनाएं और प्रयास करें।',
      'openvpn_identity_inconsistent':
          'प्रमाणपत्र इस फ़ोन की सुरक्षित पहचान से मेल नहीं खाता। कोई स्थानीय प्रोफ़ाइल बदली नहीं गई।',
      'tls_handshake_failed':
          'सर्वर ने TLS वार्ता अस्वीकार कर दी। समस्या बनी रहने पर प्रोफ़ाइल फिर बनाएं।',
      'tls_alert_unknown_ca':
          'सर्वर इस डिवाइस प्रमाणपत्र के प्राधिकरण को नहीं पहचानता। OpenVPN सर्वर की जांच आवश्यक है।',
      'tls_alert_bad_certificate':
          'सर्वर ने यह डिवाइस प्रमाणपत्र अस्वीकार कर दिया। फिर प्रयास करने से पहले डिवाइस फिर बनाएं।',
      'tls_alert_unsupported_certificate':
          'सर्वर Android द्वारा उपयोग किए गए सुरक्षित प्रमाणपत्र प्रकार का समर्थन नहीं करता।',
      'tls_client_certificate_required':
          'सर्वर को क्लाइंट प्रमाणपत्र चाहिए, लेकिन OpenVPN Core उसे प्रस्तुत नहीं कर सका।',
      'tls_alert_misc':
          'सर्वर ने प्रमाणपत्र और संस्करण श्रेणियों से बाहर की TLS चेतावनी लौटाई।',
      'tls_signature_algorithm_rejected':
          'सर्वर ने Android Keystore कुंजी की ECDSA P-256 एल्गोरिदम अस्वीकार कर दी।',
      'tls_handshake_rejected':
          'सर्वर ने कनेक्शन से पहले TLS वार्ता बाधित कर दी।',
      'tls_version_rejected':
          'क्लाइंट और सर्वर को कोई साझा TLS संस्करण नहीं मिला।',
      'tls_certificate_expired':
          'कनेक्शन के दौरान प्रस्तुत प्रमाणपत्र की अवधि समाप्त हो गई है।',
      'tls_certificate_revoked':
          'कनेक्शन के दौरान प्रस्तुत प्रमाणपत्र रद्द कर दिया गया है।',
      'transport_failed':
          'मौजूदा नेटवर्क पर OpenVPN सर्वर जवाब नहीं दे रहा। थोड़ी देर बाद फिर प्रयास करें।',
      'tun_configuration_rejected':
          'Android ने OpenVPN द्वारा अनुरोधित नेटवर्क कॉन्फ़िगरेशन अस्वीकार कर दिया।',
      'tun_setup_failed':
          'Android इंटरफ़ेस बनाने से पहले OpenVPN Core ने नेटवर्क योजना अस्वीकार कर दी।',
      'tun_interface_create_failed':
          'OpenVPN Core Android VpnService से TUN इंटरफ़ेस प्राप्त नहीं कर सका।',
      'tun_interface_disabled':
          'कनेक्शन के दौरान Android या OpenVPN Core ने TUN इंटरफ़ेस अक्षम कर दिया।',
      'tun_halted': 'OpenVPN Core को TUN इंटरफ़ेस रोकने का अनुरोध मिला।',
      'tun_already_established':
          'OpenVPN ने उसी कनेक्शन में दूसरा इंटरफ़ेस मांगा। सुरक्षा के लिए टनल रोक दिया गया।',
      'tun_addresses_missing': 'सर्वर ने उपयोग योग्य टनल पता नहीं दिया।',
      'tun_routes_missing': 'सर्वर ने उपयोग योग्य टनल रूट नहीं दिए।',
      'tun_dns_missing': 'सर्वर ने उपयोग योग्य DNS सर्वर नहीं दिया।',
      'tun_permission_revoked':
          'कनेक्शन के दौरान Android ने VPN अनुमति रद्द कर दी।',
      'tun_establish_returned_null':
          'Android ने इंटरफ़ेस नहीं बनाया, आमतौर पर क्योंकि कोई दूसरा VPN अभी सक्रिय है।',
      'openvpn_service_start_failed':
          'Android OpenVPN अग्रभूमि सेवा शुरू नहीं कर सका।',
      'openvpn_operation_timeout':
          'OpenVPN Core को JNI कॉल में अधिकतम अवधि से अधिक समय लगा।',
      'openvpn_start_failed':
          'Android सेवा तैयार है, लेकिन OpenVPN Core ने प्रोफ़ाइल शुरू करना स्वीकार नहीं किया।',
      'openvpn_connection_failed':
          'CONNECTED इवेंट भेजने से पहले OpenVPN Core रुक गया।',
      'openvpn_core_status_error':
          'मूल OpenVPN लूप त्रुटि के साथ समाप्त हुआ और कोई अधिक विशिष्ट अंतिम इवेंट नहीं मिला।',
      'openvpn_stopped_before_connected':
          'CONNECTED से पहले मूल OpenVPN लूप रुक गया, बिना किसी स्पष्ट Core त्रुटि के।',
      'openvpn_auth_failed':
          'OpenVPN सर्वर ने प्रोफ़ाइल प्रमाणीकरण अस्वीकार कर दिया।',
      'openvpn_client_setup_failed':
          'नेटवर्क कनेक्शन से पहले OpenVPN Core क्लाइंट आरंभ नहीं कर सका।',
      'openvpn_client_halted':
          'OpenVPN Core को क्लाइंट रोकने का अंतिम अनुरोध मिला।',
      'openvpn_client_restart':
          'OpenVPN Core ने अपने परिवहन सत्र को फिर शुरू करने का अनुरोध किया।',
      'openvpn_inactive_timeout':
          'निष्क्रियता की समय सीमा के बाद OpenVPN Core ने सत्र बंद कर दिया।',
      'openvpn_session_expired':
          'सर्वर ने बताया कि OpenVPN सत्र समाप्त हो गया।',
      'openvpn_credentials_required':
          'सर्वर या प्रॉक्सी ऐसे इंटरैक्टिव क्रेडेंशियल मांगता है जो इस प्रमाणपत्र प्रोफ़ाइल का हिस्सा नहीं हैं।',
      'openvpn_proxy_failed':
          'OpenVPN Core ने कॉन्फ़िगर किए गए प्रॉक्सी या रिले की विफलता बताई।',
      'openvpn_compression_failed':
          'OpenVPN Core ने प्रोफ़ाइल या सर्वर द्वारा घोषित संपीड़न मोड अस्वीकार कर दिया।',
      'openvpn_ntlm_crypto_unavailable':
          'प्रोफ़ाइल ऐसे NTLM एन्क्रिप्शन का अनुरोध करती है जो इस संस्करण में उपलब्ध नहीं है।',
      'openvpn_feature_unsupported':
          'प्रोफ़ाइल या सर्वर को इस Android क्लाइंट में अनुपलब्ध सुविधा चाहिए।',
      'network_unavailable': 'कोई उपयोग योग्य भौतिक नेटवर्क उपलब्ध नहीं है।',
      'network_lost': 'नेटवर्क खो जाने के बाद टनल रोक दिया गया।',
      'certificate_validation_failed':
          'OpenVPN सर्वर की पहचान सत्यापित नहीं की जा सकी।',
      'openvpn_certificate_expired':
          'फिर कनेक्ट करने से पहले OpenVPN प्रोफ़ाइल का नवीनीकरण करें।',
      'tunnel_active_for_another_account':
          'इस कनेक्शन से पहले दूसरे खाते का टनल रुकना आवश्यक है।',
      'tunnel_already_active':
          'Android के अनुसार पिछला VPN सत्र अभी भी इंटरफ़ेस का उपयोग कर रहा है।',
      'tunnel_stop_timeout':
          '$protocol इंजन ने समय सीमा के भीतर VPN इंटरफ़ेस छोड़ने की पुष्टि नहीं की।',
      'tunnel_disconnected':
          'मूल इंजन ने बताया कि शुरू होने के बाद टनल अनपेक्षित रूप से समाप्त हो गया।',
      'native_bridge_unavailable':
          'ऐप Android VPN सेवा तक नहीं पहुंच सकता। ऐप बंद करके फिर खोलें और दोबारा प्रयास करें।',
      'native_operation_failed':
          'ऐप की त्रुटि ने VPN ऑपरेशन बाधित किया। फिर प्रयास करें। समस्या बनी रहने पर निदान चलाएं।',
      'invalid_arguments':
          'इस VPN ऑपरेशन के लिए आवश्यक जानकारी अधूरी है। फिर प्रयास करें। समस्या बनी रहने पर निदान चलाएं।',
      'invalid_account_id':
          'मूल ऑपरेशन किसी मान्य खाता पहचानकर्ता से संबद्ध नहीं है।',
      'invalid_device_id':
          'मूल इंजन को भेजा गया डिवाइस पहचानकर्ता अनुपस्थित या अमान्य है।',
      'storage_key_not_allowed':
          'Android ब्रिज ने अनुमत संग्रहण सूची से बाहर की कुंजी रोक दी।',
      'secure_storage_read_failed':
          'Android Keystore इस खाते का स्थानीय डेटा डिक्रिप्ट नहीं कर सका।',
      'secure_storage_write_failed':
          'Android Keystore स्थानीय डेटा एन्क्रिप्ट या सहेज नहीं सका।',
      'key_generation_failed':
          'Android सुरक्षित संग्रहण में WireGuard कुंजी बना या पढ़ नहीं सका।',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR बना या उस पर हस्ताक्षर नहीं कर सका।',
      'other':
          'एक अनिर्दिष्ट मूल शाखा विफल रही। नीचे दिखाया गया निदान कोड सहायता टीम को भेजें।',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'अनुमति का अनुरोध पहले से खुला है';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN अनुमति का अनुरोध पहले से प्रदर्शित है। फिर प्रयास करने से पहले इसे पूरा करें।';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN अनुमति का अनुरोध बाधित हुआ';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ऐप को जवाब मिलने से पहले VPN अनुमति स्क्रीन बंद हो गई।';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN कनेक्शन की पुष्टि नहीं हुई';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN कनेक्शन की पुष्टि नहीं हो सकी। सुरक्षा के लिए इसे बंद कर दिया गया। फिर प्रयास करें।';

  @override
  String get openvpnCleanup_title => 'OpenVPN प्रोफ़ाइल रद्द की गई';

  @override
  String get openvpnCleanup_working =>
      'रद्द की गई OpenVPN प्रोफ़ाइल बंद करके हटाई जा रही है…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN के बंद होने की पुष्टि नहीं हुई। नई प्रोफ़ाइल बनाने से पहले फिर प्रयास करें।';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'रद्द की गई OpenVPN प्रोफ़ाइल पूरी तरह हटाई नहीं जा सकी। सफाई के लिए फिर प्रयास करें।';

  @override
  String get openvpnCleanup_complete =>
      'रद्द की गई OpenVPN प्रोफ़ाइल हटा दी गई है। नई प्रोफ़ाइल बनाने के लिए कनेक्ट करें पर टैप करें।';

  @override
  String get network_title => 'नेटवर्क कॉन्फ़िगरेशन';

  @override
  String get network_ipv4Fallback =>
      'IPv6 अस्थायी रूप से अनुपलब्ध है। IPv4 के साथ तैयारी जारी है।';

  @override
  String get network_rejectedTitle => 'नेटवर्क कॉन्फ़िगरेशन अस्वीकार किया गया';

  @override
  String get network_rejectedMessage =>
      'टनल कॉन्फ़िगरेशन अधूरा है या अधिकृत पतों से मेल नहीं खाता। ऐप से फिर प्रयास करें।';

  @override
  String get network_unreadableTitle =>
      'स्थानीय कॉन्फ़िगरेशन पढ़ा नहीं जा सकता';

  @override
  String get network_unreadableMessage =>
      'सहेजे गए OpenVPN नेटवर्क कॉन्फ़िगरेशन का उपयोग नहीं किया जा सकता। इसे अपडेट करने के लिए ऐप से फिर कनेक्ट करें।';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'नेटवर्क सुरक्षा';

  @override
  String get protection_subtitle =>
      'VPN डिस्कनेक्ट होने पर सीधे इंटरनेट पहुंच रोकें।';

  @override
  String get protection_active => 'सिस्टम सुरक्षा सक्रिय है';

  @override
  String get protection_alwaysOnOnly =>
      'हमेशा चालू VPN सक्षम है; VPN के बाहर अवरोधन चालू करें';

  @override
  String get protection_inactive => 'सिस्टम सुरक्षा निष्क्रिय है';

  @override
  String get protection_unknown => 'सिस्टम सुरक्षा जांचें';

  @override
  String get protection_openSettings => 'Android सेटिंग खोलें';

  @override
  String get protection_dialogTitle => 'नेटवर्क सुरक्षा सेट अप करें';

  @override
  String get protection_dialogMessage =>
      'Android हमेशा चालू रहने वाले VPN और VPN के बाहर के कनेक्शन अवरुद्ध करने का प्रबंधन करता है। जांचें कि FuzeVPN चुना गया है और सिस्टम सेटिंग में अवरोधन सक्षम करें।';

  @override
  String get protection_dialogOpen => 'सेटिंग खोलें';

  @override
  String get session_systemProtectionNote =>
      'यदि Android अभी भी VPN के बाहर ट्रैफ़िक रोक रहा है, तो इस सुरक्षा को जांचने या बदलने के लिए सिस्टम सेटिंग खोलें।';

  @override
  String get diagnostics_title => 'निदान';

  @override
  String get diagnostics_settingsTitle => 'ऐप निदान';

  @override
  String get diagnostics_automaticTitle => 'महत्वपूर्ण त्रुटियां भेजें';

  @override
  String get diagnostics_automaticDescription =>
      'महत्वपूर्ण त्रुटि होने पर एक छोटी तकनीकी रिपोर्ट साझा करें।';

  @override
  String get diagnostics_privacy =>
      'भेजी गई रिपोर्टें साइन इन किए गए खाते से जुड़ी होती हैं और 30 दिनों तक रखी जाती हैं। उनमें ब्राउज़िंग इतिहास, पासवर्ड या VPN कुंजियां नहीं होतीं।';

  @override
  String get diagnostics_manualOpen => 'निदान चलाएं';

  @override
  String get diagnostics_localDescription =>
      'ऐप और VPN स्थिति की रिपोर्ट बनाएं। आपका कनेक्शन अपरिवर्तित रहेगा।';

  @override
  String get diagnostics_sendReport => 'रिपोर्ट भेजें';

  @override
  String get diagnostics_sendHint =>
      'रिपोर्ट इसी डिवाइस पर रखने के लिए इस बॉक्स को अनचेक छोड़ें।';

  @override
  String get diagnostics_signedOut =>
      'रिपोर्ट भेजने के लिए अपने खाते में साइन इन करें।';

  @override
  String get diagnostics_localLifetime =>
      'ऐप बंद करने के बाद भी इसे रखने के लिए यह रिपोर्ट अपने फ़ोन पर सहेजें।';

  @override
  String get diagnostics_run => 'निदान चलाएं';

  @override
  String get diagnostics_rerun => 'निदान फिर चलाएं';

  @override
  String get diagnostics_running => 'जांच की जा रही है…';

  @override
  String get diagnostics_sending => 'रिपोर्ट भेजी जा रही है…';

  @override
  String get diagnostics_prepared => 'इस डिवाइस पर रिपोर्ट तैयार है';

  @override
  String get diagnostics_queued => 'रिपोर्ट भेजे जाने की प्रतीक्षा में है';

  @override
  String get diagnostics_sent => 'रिपोर्ट प्राप्त हो गई';

  @override
  String get diagnostics_failed =>
      'भेजना विफल रहा। आपकी स्थानीय रिपोर्ट अभी भी उपलब्ध है।';

  @override
  String get diagnostics_preparationFailed =>
      'निदान रिपोर्ट तैयार नहीं की जा सकी। फिर प्रयास करें।';

  @override
  String get diagnostics_authenticationRequired =>
      'रिपोर्ट भेजने के लिए फिर से साइन इन करें।';

  @override
  String get diagnostics_retry => 'भेजने का फिर प्रयास करें';

  @override
  String get diagnostics_export => 'रिपोर्ट सहेजें';

  @override
  String get diagnostics_exportFailed =>
      'निर्यात विफल रहा। स्थानीय रिपोर्ट से फिर प्रयास करें।';

  @override
  String get diagnostics_preferenceFailed =>
      'यह सेटिंग सहेजी नहीं जा सकी। फिर प्रयास करें।';

  @override
  String diagnostics_receipt(Object id) {
    return 'संदर्भ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date को प्राप्त हुई';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date तक रखी जाएगी';
  }

  @override
  String get diagnostics_duplicate => 'यह रिपोर्ट पहले ही प्राप्त हो चुकी थी।';

  @override
  String get diagnostics_preview => 'रिपोर्ट का पूर्वावलोकन';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count तकनीकी इवेंट संलग्न हैं',
      one: '1 तकनीकी इवेंट संलग्न है',
      zero: 'कोई तकनीकी इवेंट संलग्न नहीं है',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'तकनीकी विवरण';

  @override
  String get diagnostics_empty =>
      'अभी तक कोई निदान रिपोर्ट तैयार नहीं की गई है।';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'टनल स्थिति',
      'handshake': 'कनेक्शन पुष्टि',
      'certificate': 'VPN प्रमाणपत्र',
      'kill_switch': 'Android सुरक्षा',
      'connectivity': 'उपलब्ध नेटवर्क',
      'api_reachability': 'सेवा पहुंच',
      'secure_storage': 'सुरक्षित संग्रहण',
      'other': 'स्थानीय जांच',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'जांच पूरी',
      'failed': 'ध्यान आवश्यक है',
      'skipped': 'जांच नहीं की गई — कोई सक्रिय जांच नहीं',
      'unknown': 'जानकारी अनुपलब्ध है',
      'other': 'जानकारी अनुपलब्ध है',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN में आपका स्वागत है';

  @override
  String get connection_changeLocation => 'स्थान बदलें';

  @override
  String get connection_details => 'कनेक्शन विवरण';

  @override
  String get locations_searchLabel => 'शहर या देश खोजें';

  @override
  String get locations_clearSearch => 'खोज साफ़ करें';

  @override
  String get locations_filterAll => 'सभी';

  @override
  String get locations_filterFavorites => 'पसंदीदा';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count स्थान',
      one: '$count स्थान',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'कोई स्थान नहीं मिला';

  @override
  String get locations_noResultsHint => 'कोई दूसरा शहर या देश आज़माएं।';

  @override
  String get locations_noFavorites => 'आपके पसंदीदा, आसानी से उपलब्ध';

  @override
  String get locations_noFavoritesHint =>
      'किसी स्थान के पास दिए गए सितारे पर टैप करके उसे यहां सहेजें।';

  @override
  String get locations_showAll => 'सभी स्थान देखें';

  @override
  String locations_addFavorite(String name) {
    return '$name को पसंदीदा में जोड़ें';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name को पसंदीदा से हटाएं';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'पसंदीदा सहेजा नहीं जा सका। फिर प्रयास करें।';

  @override
  String get locations_emptyTitle => 'कोई स्थान उपलब्ध नहीं है';

  @override
  String get locations_emptyHint => 'फिर प्रयास करने के लिए सूची रिफ्रेश करें।';

  @override
  String get devices_manage => 'मेरे डिवाइस प्रबंधित करें';

  @override
  String get settings_personalization => 'इसे अपने अनुसार बनाएं';

  @override
  String get settings_safety => 'सुरक्षा';

  @override
  String get settings_help => 'सहायता चाहिए?';

  @override
  String get settings_about => 'FuzeVPN के बारे में';

  @override
  String get diagnostics_heading => 'कनेक्शन की समस्या समझें';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'उपलब्ध',
      'pending': 'तैयारी जारी है',
      'revoked': 'हटा दिया गया',
      'expired': 'समाप्त',
      'other': 'स्थिति अनुपलब्ध है',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'पसंद सहेजी नहीं गई';

  @override
  String get notice_preferenceSave_message =>
      'आपका विकल्प अभी लागू है, लेकिन सहेजा नहीं जा सका। ऐप बंद करने के बाद भी इसे रखने के लिए फिर प्रयास करें।';

  @override
  String get connection_androidDisconnectHint =>
      'यदि Android VPN को सक्रिय रखता है, तो खुलने वाली सेटिंग में हमेशा चालू VPN बंद करें।';

  @override
  String get protection_learnMore => 'Android सुरक्षा के बारे में जानें';

  @override
  String get protection_guideWhy =>
      'VPN डिस्कनेक्ट होने पर यह सुरक्षा ऐप्स को सीधे इंटरनेट का उपयोग करने से रोकती है। इसे Android में कॉन्फ़िगर किया जाता है।';

  @override
  String get protection_guideAlwaysOnTitle => 'हमेशा चालू VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN सेवा को चालू रखता है और फ़ोन रीबूट होने के बाद इसे फिर शुरू कर सकता है।';

  @override
  String get protection_guideBlockTitle => 'VPN के बिना कनेक्शन अवरुद्ध करें';

  @override
  String get protection_guideBlock =>
      'यह सेटिंग ट्रैफ़िक को VPN को बायपास करने से रोकती है, जिसमें कनेक्शन बाधित होने का समय भी शामिल है।';

  @override
  String get protection_guideWarning =>
      'यह अवरोधन सक्षम होने पर VPN कनेक्ट होने तक इंटरनेट पहुंच बंद रहती है।';

  @override
  String get protection_guideStepsTitle => 'सुरक्षा चालू करें';

  @override
  String get protection_guideStep1 =>
      'नीचे दिए बटन से Android VPN सेटिंग खोलें।';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN के पास दिए गियर आइकन से विकल्प खोलें।';

  @override
  String get protection_guideStep3 =>
      'हमेशा चालू VPN सक्षम करें, फिर VPN के बिना कनेक्शन अवरुद्ध करें, यदि ये विकल्प उपलब्ध हों।';

  @override
  String get protection_guideManufacturers =>
      'फ़ोन के अनुसार नाम अलग हो सकते हैं। जरूरत पड़ने पर सेटिंग में VPN खोजें, जो अक्सर नेटवर्क और इंटरनेट के अंतर्गत होता है।';

  @override
  String get protection_guideDisableTitle => 'यह सुरक्षा बंद करें';

  @override
  String get protection_guideDisable =>
      'उन्हीं सेटिंग में VPN के बिना अवरोधन बंद करके VPN के बिना इंटरनेट पहुंच की अनुमति दें। यदि आप नहीं चाहते कि Android इसे फिर शुरू करे, तो हमेशा चालू VPN भी बंद करें।';

  @override
  String get protection_guideManual =>
      'आप Android में ये सेटिंग स्वयं चुनते हैं। FuzeVPN उन्हें आपके लिए नहीं बदलता।';

  @override
  String get locations_changeTitle => 'स्थान बदलें?';

  @override
  String locations_changeActive(String name) {
    return 'VPN डिस्कनेक्ट होगा, फिर $name से कनेक्ट करने का प्रयास करेगा।';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name से कनेक्ट करने का प्रयास करेगा।';
  }

  @override
  String get locations_confirmChange => 'बदलें और कनेक्ट करें';

  @override
  String get locations_changeBusy =>
      'एक परिवर्तन जारी है। दूसरा स्थान चुनने से पहले प्रतीक्षा करें।';

  @override
  String get locations_automaticSelection => 'स्वचालित चयन';

  @override
  String get locations_cities => 'शहर';

  @override
  String get locations_servers => 'सर्वर';

  @override
  String locations_viewCities(String name) {
    return '$name के शहर देखें';
  }

  @override
  String locations_viewServers(String name) {
    return '$name के सर्वर देखें';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count देश',
      one: '$count देश',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count शहर',
      one: '$count शहर',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सर्वर',
      one: '$count सर्वर',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'सभी देश';

  @override
  String get locations_backToCountries => 'देशों पर वापस जाएं';

  @override
  String locations_backToCities(String name) {
    return '$name के शहरों पर वापस जाएं';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name चुनें';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name चुनें';
  }

  @override
  String get locations_noCompatibleServer => 'कोई संगत सर्वर उपलब्ध नहीं है।';

  @override
  String get externalLink_failed =>
      'यह लिंक नहीं खुल सका। आप इसे कॉपी करके अपने ब्राउज़र में खोल सकते हैं।';

  @override
  String get externalLink_copy => 'लिंक कॉपी करें';

  @override
  String get externalLink_copied => 'लिंक कॉपी हो गया';

  @override
  String get externalLink_copyFailed =>
      'लिंक कॉपी नहीं हो सका। नीचे दिया गया पता चुनें।';

  @override
  String get settings_deleteAccount => 'मेरा खाता हटाएँ';

  @override
  String get settings_deleteAccountDetail =>
      'खाता हटाने का अनुरोध करने की प्रक्रिया देखें';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'अपनी VPN सदस्यता चुनें।';

  @override
  String get billing_subscribe => 'सदस्यता लें';

  @override
  String get billing_choosePlan => 'जारी रखने के लिए एक प्लान चुनें।';

  @override
  String get billing_monthly => 'मासिक';

  @override
  String get billing_yearly => 'वार्षिक';

  @override
  String get billing_continue => 'Google Play से जारी रखें';

  @override
  String get billing_restore => 'खरीदारी बहाल करें';

  @override
  String get billing_manage => 'सदस्यता प्रबंधित करें';

  @override
  String get billing_deleteAccountWarning =>
      'यदि आपके पास Google Play की सदस्यता है, तो अपना FuzeVPN खाता हटाने से उसका नवीनीकरण रद्द नहीं होता। नवीनीकरण को Google Play में अलग से प्रबंधित करें या रद्द करें।';

  @override
  String get billing_deleteAccountContinue =>
      'खाता हटाने का अनुरोध करने के लिए आगे बढ़ें';

  @override
  String get billing_refresh => 'पहुँच रीफ़्रेश करें';

  @override
  String get billing_loadingPlans => 'प्लान लोड हो रहे हैं…';

  @override
  String get billing_unavailable =>
      'अभी कोई प्लान उपलब्ध नहीं है। बाद में फिर कोशिश करें।';

  @override
  String get billing_comingSoon => 'सदस्यताएँ जल्द उपलब्ध होंगी।';

  @override
  String get billing_priceDisclosure =>
      'कीमत Google Play से प्राप्त है। अंतिम राशि की पुष्टि भुगतान से पहले होगी।';

  @override
  String get billing_renewalMonthly =>
      'रद्द न करने पर हर महीने अपने आप नवीनीकरण होगा। Google Play की सदस्यताओं में किसी भी समय रद्द कर सकते हैं।';

  @override
  String get billing_renewalYearly =>
      'रद्द न करने पर हर साल अपने आप नवीनीकरण होगा। Google Play की सदस्यताओं में किसी भी समय रद्द कर सकते हैं।';

  @override
  String get billing_active => 'आपकी Premium पहुँच सक्रिय है';

  @override
  String billing_accessUntil(String date) {
    return '$date तक पहुँच।';
  }

  @override
  String get billing_webManaged =>
      'आपकी सदस्यता FuzeVPN वेबसाइट पर प्रबंधित होती है।';

  @override
  String get billing_playManaged =>
      'आपकी सदस्यता Google Play से प्रबंधित होती है।';

  @override
  String get billing_inactive => 'कोई सक्रिय सदस्यता नहीं है।';

  @override
  String get billing_checkingAccess => 'आपकी पहुँच की जाँच हो रही है…';

  @override
  String get billing_restoring => 'खरीदारी बहाल हो रही है…';

  @override
  String get billing_pending =>
      'भुगतान लंबित है। पुष्टि के बाद आपकी पहुँच सक्रिय होगी।';

  @override
  String get billing_cancelled =>
      'खरीदारी रद्द हुई। कोई नई सदस्यता सक्रिय नहीं हुई।';

  @override
  String get billing_verifying => 'खरीदारी सत्यापित हो रही है…';

  @override
  String get billing_success =>
      'सदस्यता सक्रिय हुई। आपकी Premium पहुँच तैयार है।';

  @override
  String get billing_restored => 'आपकी खरीदारी बहाल हो गई है।';

  @override
  String get billing_restoreEmpty =>
      'इस Google Play खाते में बहाल करने के लिए कोई खरीदारी नहीं है।';

  @override
  String get billing_catalogError => 'प्लान लोड नहीं हो सके। फिर कोशिश करें।';

  @override
  String get billing_purchaseError =>
      'खरीदारी शुरू नहीं हो सकी। फिर कोशिश करें।';

  @override
  String get billing_verificationError =>
      'खरीदारी का सत्यापन अस्थायी रूप से उपलब्ध नहीं है। फिर कोशिश करने के लिए खरीदारी बहाल करें।';

  @override
  String get billing_restoreError =>
      'खरीदारी बहाल नहीं हो सकी। फिर कोशिश करें।';

  @override
  String get billing_managementError =>
      'सदस्यता प्रबंधन नहीं खुल सका। फिर कोशिश करें।';

  @override
  String get billing_storeUnavailable =>
      'इस डिवाइस पर Google Play उपलब्ध नहीं है।';

  @override
  String get welcome_title => 'आपका VPN, अब और आसान।';

  @override
  String get welcome_description =>
      'अपना कनेक्शन सुरक्षित रखें। अपनी गोपनीयता पर नियंत्रण बनाए रखें।';

  @override
  String get welcome_start => 'शुरू करें';

  @override
  String get welcome_alreadyPurchased => 'पहले ही खरीद चुके हैं?';

  @override
  String get welcome_noAccountRequired =>
      'शुरू करने के लिए खाता बनाने की ज़रूरत नहीं है।';

  @override
  String get guest_accountTitle => 'खाता लिंक नहीं है';

  @override
  String get guest_accountDescription =>
      'दूसरे डिवाइस पर अपनी सदस्यता इस्तेमाल करने के लिए उसी Google Play खाते से खरीदारी बहाल करें।';

  @override
  String get guest_existingSubscriberSignIn =>
      'पहले से सदस्यता है? साइन इन करें';

  @override
  String get guest_claimTitle => 'FuzeVPN हर जगह आपके साथ';

  @override
  String get guest_claimDescription =>
      'अपने दूसरे डिवाइस पर सदस्यता इस्तेमाल करने के लिए खाता बनाएँ। यह चरण वैकल्पिक है।';

  @override
  String get guest_skip => 'बाद में';

  @override
  String get guest_activationTitle => 'Fuze Premium सक्रिय है';

  @override
  String get guest_activationDescription =>
      'आपकी सदस्यता तैयार है। अपना VPN इस्तेमाल करें और जब चाहें खाता बनाएँ।';

  @override
  String get guest_useVpn => 'मेरा VPN इस्तेमाल करें';

  @override
  String get guest_loginRequired =>
      'यह खरीदारी पहले से किसी FuzeVPN खाते से लिंक है। अपनी सदस्यता इस्तेमाल करने के लिए उस खाते में साइन इन करें।';

  @override
  String get guest_signOutWarning =>
      'आप उसी Google Play खाते से खरीदारी बहाल करके अपनी सदस्यता वापस पा सकते हैं।';

  @override
  String get guest_profileUnavailable =>
      'आपका खाता पहले से लिंक है। अपनी जानकारी देखने और प्रबंधित करने के लिए साइन इन करें।';

  @override
  String get billing_acceptance =>
      'जारी रखने पर आप उपयोग की शर्तों और गोपनीयता नीति को स्वीकार करते हैं।';

  @override
  String get guest_verifyEmailReminder =>
      'अपना खाता सुरक्षित करने के लिए ईमेल पता सत्यापित करें। आप अपना VPN इस्तेमाल करते रह सकते हैं।';

  @override
  String get guest_serviceUnavailable =>
      'सेवा अभी अस्थायी रूप से उपलब्ध नहीं है। थोड़ी देर में फिर कोशिश करें।';

  @override
  String get guest_restoreError =>
      'आपकी खरीदारी बहाल नहीं हो सकी। खरीदारी के लिए इस्तेमाल किए गए Google Play खाते से फिर कोशिश करें।';

  @override
  String get guest_claimSuccess =>
      'आपका खाता बन गया है। आपकी सदस्यता और VPN का एक्सेस बरकरार हैं।';

  @override
  String get guest_emailExists =>
      'यह ईमेल पता पहले से इस्तेमाल हो रहा है। कोई दूसरा पता चुनें या अपने मौजूदा खाते में साइन इन करें। आपकी खरीदारी Google Play के ज़रिए उपलब्ध रहेगी।';

  @override
  String get guest_claimError =>
      'आपका खाता नहीं बन सका। आप अपना VPN इस्तेमाल करते रह सकते हैं और बाद में फिर कोशिश कर सकते हैं।';

  @override
  String get guest_secureStorageError =>
      'इस डिवाइस पर आपका सेशन सुरक्षित नहीं किया जा सका। फिर कोशिश करें।';

  @override
  String get guest_premiumRequired =>
      'अपना VPN सक्रिय करने के लिए सदस्यता चुनें।';

  @override
  String get welcome_viewPlans => 'प्लान देखें';

  @override
  String get google_continue => 'Google के साथ जारी रखें';

  @override
  String get google_or => 'या';

  @override
  String get google_title => 'आपका FuzeVPN खाता';

  @override
  String get google_settingUp => 'अपना खाता पूरा करें';

  @override
  String get google_country => 'निवास का देश';

  @override
  String get google_profileDescription =>
      'FuzeVPN खाता बनाने के लिए अपना देश चुनें और दोनों दस्तावेज़ पढ़ें।';

  @override
  String get google_claimDescription =>
      'अपने अतिथि खाते को Google से जोड़ें। सदस्यता और डिवाइस इसी खाते से जुड़े रहेंगे।';

  @override
  String get google_linkTitle => 'Google को FuzeVPN से जोड़ें';

  @override
  String get google_linkDescription =>
      'अपने मौजूदा FuzeVPN खाते तक पहुँच की पुष्टि करें। आपका Google पासवर्ड नहीं माँगा जाएगा।';

  @override
  String get google_password => 'FuzeVPN पासवर्ड';

  @override
  String get google_linkAccount => 'जोड़ने की पुष्टि करें';

  @override
  String get google_requestEmail => 'पुष्टि ईमेल भेजें';

  @override
  String get google_emailInstructions =>
      'FuzeVPN का ईमेल खोलें और पुष्टि कोड दर्ज करें।';

  @override
  String get google_emailCode => 'ईमेल पुष्टि कोड';

  @override
  String get google_confirmEmail => 'कोड की पुष्टि करें';

  @override
  String get google_restart => 'दूसरा Google खाता चुनें';

  @override
  String get google_resume => 'इस प्रयास की जाँच करें';

  @override
  String get google_unavailable =>
      'Google साइन-इन उपलब्ध नहीं है। आप ईमेल और पासवर्ड का उपयोग कर सकते हैं।';

  @override
  String get google_expired =>
      'इस प्रयास की समय-सीमा समाप्त हो गई है। इसे रद्द करके फिर शुरू करें।';

  @override
  String get google_conflict =>
      'यह Google खाता पहले से दूसरे खाते से जुड़ा है। आपका मौजूदा खाता और सदस्यता सुरक्षित हैं।';

  @override
  String get google_error =>
      'Google साइन-इन विफल रहा। फिर प्रयास करें; आपकी मौजूदा पहुँच सुरक्षित है।';

  @override
  String get google_uncertain =>
      'परिणाम की पुष्टि नहीं हो सकी। इस प्रयास की जाँच करें या फिर शुरू करने से पहले इसे रद्द करें।';

  @override
  String get google_cancelFailed =>
      'रद्द करने की पुष्टि नहीं हो सकी। इस स्क्रीन से बाहर जाने से पहले फिर रद्द करने का प्रयास करें।';

  @override
  String get google_cancelled => 'Google साइन-इन रद्द किया गया।';

  @override
  String get google_selecting => 'अपना Google खाता चुनें…';

  @override
  String get google_verifying => 'आपके खाते की जाँच हो रही है…';

  @override
  String get google_emailUnavailable =>
      'पुष्टि ईमेल नहीं भेजा जा सका। बाद में प्रयास करें।';

  @override
  String get google_emailSent => 'पुष्टि ईमेल भेजा गया। अपना इनबॉक्स देखें।';

  @override
  String get google_rateLimited => 'फिर प्रयास करने से पहले प्रतीक्षा करें।';

  @override
  String get google_invalidPassword =>
      'FuzeVPN पासवर्ड गलत है। आपका मौजूदा खाता सुरक्षित है।';

  @override
  String get google_invalidCode =>
      'पुष्टि कोड अमान्य है या उसकी समय-सीमा समाप्त हो गई है।';

  @override
  String get google_accountChanged =>
      'सत्र बदल गया है। फिर शुरू करने से पहले इस प्रयास को रद्द करें।';

  @override
  String get google_invalidResponse =>
      'उत्तर की पुष्टि नहीं हो सकी। आपकी मौजूदा पहुँच सुरक्षित है।';

  @override
  String get google_invalidRegistration =>
      'देश और दोनों सहमतियों की जाँच करें।';

  @override
  String get google_consentRequired =>
      'जारी रखने के लिए अपना देश चुनें और दोनों दस्तावेज़ स्वीकार करें।';

  @override
  String get google_challengeRequired =>
      'अतिरिक्त सुरक्षा जाँच आवश्यक है। आपकी मौजूदा पहुँच सुरक्षित है।';

  @override
  String get google_challengeUnavailable =>
      'सुरक्षा जाँच उपलब्ध नहीं है। बाद में प्रयास करें।';
}
