// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get vpnDisclosure_title => 'तपाईंको जडान सुरक्षित गर्नुहोस्';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ले यो डिभाइस र FuzeVPN सर्भरहरूबीच एन्क्रिप्ट गरिएको टनेल बनाउन Android को VPN सेवा (VpnService) प्रयोग गर्छ।';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN सक्रिय हुँदा तपाईंका एपहरूको इन्टरनेट ट्राफिक, गन्तव्य ठेगानाहरू र DNS अनुरोधहरू तपाईंको जडान रुट गर्न यही टनेलमार्फत जान्छन्, FuzeVPN पृष्ठभूमिमा हुँदा पनि।';

  @override
  String get vpnDisclosure_statusBody =>
      'तपाईंको VPN जडान देखाउन एपले जडानको स्थिति, यसको अवधि र स्थानान्तरण गरिएको डेटाको मात्रा प्रयोग गर्छ। तपाईं जुनसुकै बेला यसलाई रोक्न सक्नुहुन्छ।';

  @override
  String get vpnDisclosure_privacy => 'गोपनीयता';

  @override
  String get vpnDisclosure_accept => 'स्वीकार गर्नुहोस् र जारी राख्नुहोस्';

  @override
  String get vpnDisclosure_decline => 'अहिले होइन';

  @override
  String get accountRestoration_title => 'खाता अस्थायी रूपमा उपलब्ध छैन';

  @override
  String get accountRestoration_message =>
      'तपाईंको सत्र सुरक्षित राखिएको छ। खाता पुनः प्राप्त गर्न फेरि प्रयास गर्नुहोस्। तपाईं यहाँबाट अझै VPN जडान व्यवस्थापन गर्न सक्नुहुन्छ।';

  @override
  String get action_retry => 'फेरि प्रयास गर्नुहोस्';

  @override
  String get session_endingTitle => 'सत्र समाप्त गर्दै';

  @override
  String get session_ending => 'सत्र समाप्त गर्दै: VPN रोक्दै र सफा गर्दै…';

  @override
  String get session_stopFailed =>
      'VPN बन्द भएको पुष्टि भएन। साइन इन गर्नुअघि फेरि प्रयास गर्नुहोस्।';

  @override
  String get session_cleanupFailed =>
      'VPN रोकिएको छ, तर सत्र हटाइएको पुष्टि भएन। सफा गर्ने काम फेरि प्रयास गर्नुहोस्।';

  @override
  String get session_retryStop => 'बन्द गर्न फेरि प्रयास गर्नुहोस्';

  @override
  String get session_retryCleanup => 'सफा गर्न फेरि प्रयास गर्नुहोस्';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN सुरक्षित रूपमा तयार गर्दै…';

  @override
  String get nav_connection => 'जडान';

  @override
  String get nav_locations => 'स्थानहरू';

  @override
  String get nav_account => 'खाता';

  @override
  String get nav_devices => 'डिभाइसहरू';

  @override
  String get nav_settings => 'सेटिङ';

  @override
  String get action_refresh => 'ताजा गर्नुहोस्';

  @override
  String get auth_tab_login => 'साइन इन गर्नुहोस्';

  @override
  String get auth_tab_register => 'साइन अप गर्नुहोस्';

  @override
  String get auth_stepAccount => 'खाता';

  @override
  String get auth_stepIdentity => 'पहिचान';

  @override
  String get auth_stepAddress => 'ठेगाना र सहमति';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'चरण $current / $total';
  }

  @override
  String get auth_tagline => 'तपाईंको VPN, सरल तरिकाले।';

  @override
  String get auth_keysLocal =>
      'तपाईंका निजी VPN कुञ्जीहरू यही डिभाइसमा रहन्छन्।';

  @override
  String get form_email => 'इमेल ठेगाना';

  @override
  String get form_password => 'पासवर्ड';

  @override
  String get form_showPassword => 'पासवर्ड देखाउनुहोस्';

  @override
  String get form_hidePassword => 'पासवर्ड लुकाउनुहोस्';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 बाइट। केही वर्णहरूले एकभन्दा बढी बाइट लिन्छन्।';

  @override
  String get form_firstName => 'पहिलो नाम';

  @override
  String get form_lastName => 'थर';

  @override
  String get form_phone => 'फोन (+33612345678)';

  @override
  String get form_address => 'ठेगाना';

  @override
  String get form_address2 => 'ठेगानाको दोस्रो लाइन (वैकल्पिक)';

  @override
  String get form_postalCode => 'पोस्टल कोड';

  @override
  String get form_city => 'शहर';

  @override
  String get form_country => 'देशको कोड (जस्तै FR)';

  @override
  String get action_login => 'साइन इन गर्नुहोस्';

  @override
  String get action_createAccount => 'खाता बनाउनुहोस्';

  @override
  String get action_createMyAccount => 'मेरो खाता बनाउनुहोस्';

  @override
  String get action_next => 'जारी राख्नुहोस्';

  @override
  String get action_previous => 'पछाडि';

  @override
  String get action_forgotPassword => 'पासवर्ड बिर्सनुभयो?';

  @override
  String get auth_noAccount => 'तपाईंसँग अझै खाता छैन?';

  @override
  String get auth_requiredInformation => 'तीन चरणमा आफ्नो खाता बनाउनुहोस्।';

  @override
  String get auth_termsPrefix => 'म स्वीकार गर्छु: ';

  @override
  String get auth_termsLink => 'प्रयोगका सर्तहरू';

  @override
  String get auth_privacyPrefix => 'म स्वीकार गर्छु: ';

  @override
  String get auth_privacyLink => 'गोपनीयता नीति';

  @override
  String get auth_consentRequired =>
      'खाता बनाउनका लागि तपाईंको सहमति आवश्यक छ।';

  @override
  String get validation_required => 'यो फिल्ड अनिवार्य छ।';

  @override
  String get validation_email => 'मान्य इमेल ठेगाना प्रविष्ट गर्नुहोस्।';

  @override
  String get validation_password =>
      'पासवर्ड धेरै छोटो छ: कम्तीमा 8 UTF-8 बाइट हुनुपर्छ।';

  @override
  String get validation_passwordTooLong =>
      'पासवर्ड धेरै लामो छ: बढीमा 72 UTF-8 बाइट हुनुपर्छ।';

  @override
  String get validation_phone =>
      'अन्तर्राष्ट्रिय ढाँचा प्रयोग गर्नुहोस्, उदाहरणका लागि +33612345678।';

  @override
  String get validation_country =>
      'दुई अक्षरको देश कोड प्रयोग गर्नुहोस्, उदाहरणका लागि FR।';

  @override
  String get passwordReset_title => 'पासवर्ड रिसेट गर्नुहोस्';

  @override
  String get passwordReset_description =>
      'पासवर्ड रिसेट लिङ्कको अनुरोध गर्न आफ्नो खाताको इमेल ठेगाना प्रविष्ट गर्नुहोस्।';

  @override
  String get passwordReset_send => 'लिङ्क पठाउनुहोस्';

  @override
  String get connection_title => 'तपाईंको जडान';

  @override
  String get connection_subtitle =>
      'स्थान छान्नुहोस्, त्यसपछि आफ्नो VPN सक्रिय गर्नुहोस्।';

  @override
  String get connection_prepare => 'जडान गर्न तयार हुनुहुन्छ?';

  @override
  String get connection_advancedOptions => 'उन्नत विकल्पहरू';

  @override
  String get connection_location => 'स्थान';

  @override
  String get connection_chooseLocation => 'स्थान छान्नुहोस्';

  @override
  String get connection_protocol => 'प्रोटोकल';

  @override
  String get connection_connect => 'जडान गर्नुहोस्';

  @override
  String get connection_connecting => 'जडान हुँदै…';

  @override
  String get connection_disconnect => 'जडान विच्छेद गर्नुहोस्';

  @override
  String get connection_disconnecting => 'जडान विच्छेद हुँदै';

  @override
  String get connection_locationChange => 'स्थान बदल्दै…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol उपलब्ध छैन';
  }

  @override
  String get connection_activeLocation => 'सक्रिय स्थान';

  @override
  String get connection_duration => 'अवधि';

  @override
  String get connection_received => 'प्राप्त भएको';

  @override
  String get connection_sent => 'पठाइएको';

  @override
  String get connection_lastHandshake => 'अन्तिम सुरक्षित आदानप्रदान';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration अघि';
  }

  @override
  String get verification_title => 'आफ्नो इमेल ठेगाना पुष्टि गर्नुहोस्';

  @override
  String get verification_message =>
      'यो फोनमा VPN प्रयोग गर्न आफ्नो इमेल ठेगाना पुष्टि गर्नुहोस्।';

  @override
  String get verification_resend => 'इमेल फेरि पठाउनुहोस्';

  @override
  String get migration_title => 'स्थान परिवर्तन';

  @override
  String get migration_draining => 'स्थान परिवर्तनको तयारी गर्दै…';

  @override
  String get migration_activating => 'नयाँ सर्भर सक्रिय गर्दै…';

  @override
  String get migration_ready => 'स्थान अपडेट गरियो।';

  @override
  String get migration_blocked =>
      'स्थान परिवर्तनका लागि सर्भरको हस्तक्षेप आवश्यक छ। पछि फेरि प्रयास गर्नुहोस् वा सहायता टोलीसँग सम्पर्क गर्नुहोस्।';

  @override
  String get migration_progress => 'स्थान परिवर्तनको प्रगति';

  @override
  String migration_retryDelay(Object seconds) {
    return 'जाँचहरूबीचको ढिलाइ: $seconds सेकेन्ड।';
  }

  @override
  String get migration_resume => 'स्थान परिवर्तन पुनः सुरु गर्नुहोस्';

  @override
  String get status_authorizing => 'अनुमति आवश्यक छ';

  @override
  String get status_authorizingDetail =>
      'VPN लाई अनुमति दिन Android को अनुरोध स्वीकार गर्नुहोस्।';

  @override
  String get status_preparing => 'तयारी गर्दै';

  @override
  String get status_preparingDetail => 'तपाईंको सुरक्षित जडान तयार हुँदै छ।';

  @override
  String get status_reconnecting => 'पुनः जडान हुँदै…';

  @override
  String get status_reconnectingDetail =>
      'जडान बाधित भयो। VPN पुनः जडान गर्ने प्रयास गर्दै छ।';

  @override
  String get status_connecting => 'जडान हुँदै';

  @override
  String get status_connectingDetail => 'VPN सर्भरमा जडान हुँदै…';

  @override
  String get status_connected => 'जडान भएको';

  @override
  String get status_connectedDetail => 'तपाईंको VPN जडान सक्रिय छ।';

  @override
  String get status_disconnecting => 'जडान विच्छेद हुँदै';

  @override
  String get status_disconnectingDetail => 'तपाईंको VPN जडान रोकिँदै छ।';

  @override
  String get status_error => 'जडान उपलब्ध छैन';

  @override
  String get status_errorDetail =>
      'VPN जडानको पुष्टि भएको छैन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get status_idle => 'जडान विच्छेद भएको';

  @override
  String get status_idleDetail =>
      'आफ्नो जडान सुरक्षित गर्न VPN जडान गर्नुहोस्।';

  @override
  String get trust_note =>
      'एप बन्द गर्दा VPN रोकिँदैन। यसलाई रोक्न “जडान विच्छेद गर्नुहोस्” थिच्नुहोस्।';

  @override
  String get locations_none => 'हाल कुनै स्थान उपलब्ध छैन।';

  @override
  String get locations_available => 'आफ्नो अर्को स्थान छान्नुहोस्।';

  @override
  String get locations_selected => 'चयन गरिएको स्थान';

  @override
  String get locations_select => 'यो स्थान छान्नुहोस्';

  @override
  String get locations_lockedTunnel =>
      'स्थान बदल्न VPN जडान विच्छेद गर्नुहोस्।';

  @override
  String get locations_lockedMigration =>
      'स्थान परिवर्तन पूरा नहुन्जेल पर्खनुहोस्।';

  @override
  String get devices_title => 'तपाईंका डिभाइसहरू';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit डिभाइस';
  }

  @override
  String get devices_refresh => 'डिभाइसहरू ताजा गर्नुहोस्';

  @override
  String get devices_empty => 'अहिलेसम्म कुनै VPN डिभाइस दर्ता गरिएको छैन।';

  @override
  String get devices_firstConnection => 'पहिलो जडानमा तपाईंको फोन थपिनेछ।';

  @override
  String get devices_thisDevice => 'यो डिभाइस';

  @override
  String devices_added(Object date) {
    return '$date मा थपियो';
  }

  @override
  String get devices_unnamed => 'नामविहीन डिभाइस';

  @override
  String get action_remove => 'हटाउनुहोस्';

  @override
  String get settings_title => 'सेटिङ';

  @override
  String get settings_subtitle => 'तपाईंका प्राथमिकता र खाता, सबै एउटै ठाउँमा।';

  @override
  String get settings_appearance => 'देखावट';

  @override
  String get settings_language => 'भाषा';

  @override
  String get settings_languageDescription =>
      'तपाईंले छानेको भाषा VPN सूचनाहरूमा पनि लागू हुन्छ।';

  @override
  String get settings_account => 'खाता';

  @override
  String get settings_signOut => 'साइन आउट गर्नुहोस्';

  @override
  String get settings_privacy => 'गोपनीयता नीति';

  @override
  String get settings_terms => 'प्रयोगका सर्तहरू';

  @override
  String get settings_security => 'सुरक्षा र पारदर्शिता';

  @override
  String get settings_licenses => 'कम्पोनेन्ट लाइसेन्सहरू';

  @override
  String get settings_licensesDetail => 'एपमा प्रयोग गरिएका सफ्टवेयरहरू';

  @override
  String settings_licensesLegalese(String url) {
    return 'एपको सोर्स कोड र यसका MPL-2.0 कम्पोनेन्टहरू: $url';
  }

  @override
  String get settings_background =>
      'तपाईं एपबाट बाहिर निस्कँदा पनि VPN सक्रिय रहन्छ। यसलाई रोक्न “जडान” ट्याबमा रहेको “जडान विच्छेद गर्नुहोस्” थिच्नुहोस्।';

  @override
  String get theme_system => 'सिस्टम';

  @override
  String get theme_light => 'उज्यालो';

  @override
  String get theme_dark => 'अँध्यारो';

  @override
  String get language_system => 'फोनको भाषा';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'यो डिभाइस हटाउने हो?';

  @override
  String get dialog_removeCurrent =>
      'यो फोन VPN बाट विच्छेद हुनेछ र यसले पहुँच गुमाउनेछ। सर्भरले पुष्टि गरेपछि यसको VPN जडान डेटा हटाइनेछ।';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” को VPN पहुँच रद्द गरिनेछ। यो कार्य पूर्ववत गर्न सकिँदैन।';
  }

  @override
  String get dialog_signOut => 'साइन आउट गर्ने हो?';

  @override
  String get dialog_signOutMessage =>
      'VPN रोकिनेछ र तपाईंले फेरि साइन इन गर्नुपर्नेछ। तपाईंका एन्क्रिप्ट गरिएका VPN कुञ्जीहरू अर्को जडानका लागि यही फोनमा रहनेछन्।';

  @override
  String get action_cancel => 'रद्द गर्नुहोस्';

  @override
  String get action_close => 'बन्द गर्नुहोस्';

  @override
  String get action_copy => 'कपी गर्नुहोस्';

  @override
  String get action_signOut => 'साइन आउट गर्नुहोस्';

  @override
  String get notice_close => 'सन्देश बन्द गर्नुहोस्';

  @override
  String get notice_sessionExpired_title => 'सत्रको म्याद सकियो';

  @override
  String get notice_sessionExpired_message =>
      'तपाईंको सत्रको म्याद सकिएको छ। फेरि साइन इन गर्नुहोस्।';

  @override
  String get notice_connectionFailed_title => 'जडान असफल भयो';

  @override
  String get notice_invalidCredentials_message =>
      'इमेल ठेगाना वा पासवर्ड गलत छ।';

  @override
  String get notice_emailVerification_title => 'इमेल पुष्टिकरण आवश्यक छ';

  @override
  String get notice_emailVerification_message =>
      'VPN डिभाइस थप्नुअघि आफ्नो इमेल ठेगाना पुष्टि गर्नुहोस्।';

  @override
  String get notice_rateLimited_title => 'धेरै पटक प्रयास गरियो';

  @override
  String get notice_deviceLimit_title => 'डिभाइसको सीमा पुग्यो';

  @override
  String get notice_deviceLimit_message =>
      'अर्को डिभाइस थप्नुअघि कुनै विद्यमान डिभाइस हटाउनुहोस्।';

  @override
  String get notice_identityRenewal_title => 'VPN पहिचान नवीकरण गर्नुपर्छ';

  @override
  String get notice_identityRenewal_message =>
      'यो पहिचान हटाइएको छ। नयाँ स्थानीय पहिचान बनाउनुहोस्।';

  @override
  String get notice_migrationPending_title => 'स्थान परिवर्तन हुँदै छ';

  @override
  String get notice_migrationPending_message =>
      'स्थान परिवर्तन पहिले नै भइरहेको छ।';

  @override
  String get notice_migrationBlocked_title => 'स्थान परिवर्तन अवरुद्ध';

  @override
  String get notice_migrationBlocked_message =>
      'स्थान परिवर्तनका लागि सर्भरको हस्तक्षेप आवश्यक छ। पछि फेरि प्रयास गर्नुहोस् वा सहायता टोलीसँग सम्पर्क गर्नुहोस्।';

  @override
  String get notice_targetUnavailable_title => 'सर्भर अस्थायी रूपमा उपलब्ध छैन';

  @override
  String get notice_targetUnavailable_message =>
      'यो सर्भर अस्थायी रूपमा उपलब्ध छैन।';

  @override
  String get notice_networkUnavailable_title => 'इन्टरनेट जडान उपलब्ध छैन';

  @override
  String get notice_networkUnavailable_message =>
      'आफ्नो जडान जाँच गर्नुहोस् र फेरि प्रयास गर्नुहोस्।';

  @override
  String get notice_permissionDenied_title => 'VPN अनुमति अस्वीकृत';

  @override
  String get notice_permissionDenied_message =>
      'जडान फेरि सुरु गर्नुहोस् र Android को अनुमति अनुरोध स्वीकार गर्नुहोस्।';

  @override
  String get notice_wireguardTimeout_title =>
      'सर्भरले प्रतिक्रिया दिइरहेको छैन';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard जडानमा धेरै समय लाग्यो। फेरि प्रयास गर्नुहोस् वा अर्को स्थान छान्नुहोस्।';

  @override
  String get notice_tlsFailed_title => 'सुरक्षित जडान अस्वीकृत';

  @override
  String get notice_tlsFailed_message =>
      'सर्भरले OpenVPN जडान स्वीकार गरेन। फेरि प्रयास गर्नुहोस्। समस्या जारी रहेमा निदान चलाउनुहोस्।';

  @override
  String get notice_tunRejected_title =>
      'Android ले VPN इन्टरफेस अस्वीकार गर्यो';

  @override
  String get notice_tunRejected_message =>
      'OpenVPN ले अनुरोध गरेको नेटवर्क कन्फिगरेसन Android ले अस्वीकार गर्यो।';

  @override
  String get notice_openvpnStart_title => 'OpenVPN सुरु हुन सकेन';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN इन्जिनले सुरु गर्ने प्रक्रिया पूरा गर्न सकेन। फेरि प्रयास गर्नुहोस्। समस्या कायम रहेमा सहायता टोलीसँग सम्पर्क गर्नुहोस्।';

  @override
  String notice_diagnosticCode(Object code) {
    return 'निदान कोड: $code';
  }

  @override
  String get notice_generic_title => 'VPN जडान असफल भयो';

  @override
  String get notice_generic_message => 'त्रुटि भयो। पछि फेरि प्रयास गर्नुहोस्।';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'खाता बनाइयो',
      'password_reset_sent': 'पासवर्ड रिसेट अनुरोध प्राप्त भयो',
      'verification_email_sent': 'पुष्टिकरण इमेल पठाइयो',
      'location_migration_pending': 'स्थान परिवर्तन हुँदै छ',
      'vpn_sign_in_required': 'साइन इन आवश्यक छ',
      'protocol_unavailable_at_location': 'प्रोटोकल उपलब्ध छैन',
      'vpn_permission_denied': 'VPN अनुमति अस्वीकृत',
      'revoked_identity_device_limit': 'डिभाइसको सीमा पुग्यो',
      'tunnel_start_unexpected': 'VPN सुरु हुन सकेन',
      'flutter_disconnect_timeout': 'जडान विच्छेद पुष्टि भएन',
      'flutter_disconnect_unexpected': 'जडान विच्छेद गर्न सकिएन',
      'device_revoked': 'डिभाइस हटाइयो',
      'revoke_unexpected': 'डिभाइस हटाउन सकिएन',
      'identity_renewal_unexpected': 'पहिचान नवीकरण गर्न सकिएन',
      'openvpn_renewal_unexpected': 'OpenVPN नवीकरण गर्न सकिएन',
      'location_migration_blocked': 'स्थान परिवर्तन अवरुद्ध',
      'location_migration_slow': 'स्थान परिवर्तन अझै हुँदै छ',
      'location_migration_conflict': 'स्थान परिवर्तन ताजा गर्नुपर्छ',
      'location_migration_verification_failed': 'स्थान परिवर्तनको पुष्टि भएन',
      'location_migration_device_changed':
          'स्थान परिवर्तनका क्रममा डिभाइस बदलियो',
      'tunnel_stop_failed': 'स्थान परिवर्तन उपलब्ध छैन',
      'device_clock_ahead': 'डिभाइसको घडी अगाडि छ',
      'other': 'सञ्चालन असफल भयो',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'खाता बनाइयो, तर पुष्टिकरण इमेल पठाउन सकिएन। एपमा रहेको “इमेल फेरि पठाउनुहोस्” प्रयोग गर्नुहोस्।',
      'password_reset_sent':
          'तपाईंको अनुरोध प्राप्त भयो। यो ठेगानासँग मिल्ने खाता भए, तपाईंले इमेल प्राप्त गर्न सक्नुहुन्छ। स्प्याम फोल्डर पनि जाँच गर्नुहोस्।',
      'verification_email_sent': 'नयाँ पुष्टिकरण इमेल अहिले नै पठाइएको छ।',
      'location_migration_pending':
          '$target मा सर्ने तयारी अझै हुँदै छ। डिभाइस फेरि सिर्जना नगरी तपाईं यसलाई पुनः सुरु गर्न सक्नुहुन्छ।',
      'vpn_sign_in_required':
          'VPN सुरु गर्नुअघि आफ्नो खातामा साइन इन गर्नुहोस्।',
      'protocol_unavailable_at_location':
          'चयन गरिएको प्रोटोकल यो स्थानले प्रदान गर्दैन। स्थानहरू ताजा गर्नुहोस् वा अर्को प्रोटोकल छान्नुहोस्।',
      'vpn_permission_denied':
          'Android ले VPN अनुमति अस्वीकार गर्यो। जडान फेरि सुरु गर्नुहोस् र सिस्टमको अनुरोध स्वीकार गर्नुहोस्।',
      'revoked_identity_device_limit':
          'यो डिभाइसको VPN पहुँच हटाइएको छ र डिभाइसको सीमा पुगेको छ। खाता → मेरा डिभाइसहरू व्यवस्थापन गर्नुहोस् अन्तर्गत कुनै डिभाइस हटाउनुहोस्।',
      'tunnel_start_unexpected':
          'अप्रत्याशित त्रुटिका कारण टनेलको तयारी रोकियो। निदान कोड जाँच गर्नुहोस् र फेरि प्रयास गर्नुहोस्।',
      'flutter_disconnect_timeout':
          'Android ले समयमै VPN रोकिएको पुष्टि गरेन। फेरि रोक्ने प्रयास गर्नुहोस्।',
      'flutter_disconnect_unexpected':
          'अप्रत्याशित त्रुटिका कारण टनेल रोकिएको पुष्टि गर्न सकिएन।',
      'device_revoked':
          'डिभाइसको VPN पहुँच रद्द गरियो र यसको स्थानीय गोप्य डेटा हटाइयो।',
      'revoke_unexpected':
          'डिभाइस हटाउन सकिएन। सूची ताजा गर्नुहोस् र फेरि प्रयास गर्नुहोस्।',
      'identity_renewal_unexpected':
          'नयाँ VPN पहिचान सिर्जना गर्न सकिएन। डिभाइसहरू ताजा गर्नुहोस् र फेरि प्रयास गर्नुहोस्।',
      'openvpn_renewal_unexpected':
          'OpenVPN प्रोफाइल नवीकरण गर्न सकिएन। फेरि प्रयास गर्नुहोस् वा निदान कोड जाँच गर्नुहोस्।',
      'location_migration_blocked':
          'सर्भरले अहिले यो परिवर्तन पूरा गर्न सक्दैन। डिभाइस र यसको स्थानीय पहिचान सुरक्षित राखिएको छ।',
      'location_migration_slow':
          'सर्भरले अझै $target मा सर्ने तयारी गरिरहेको छ। केही बेरपछि “पुनः सुरु गर्नुहोस्” प्रयोग गर्नुहोस्।',
      'location_migration_conflict':
          'डिभाइसको अवस्था सर्भरमा परिवर्तन भयो। डिभाइसहरू ताजा गर्नुहोस्, त्यसपछि परिवर्तन पुनः सुरु गर्नुहोस्।',
      'location_migration_verification_failed':
          'सर्भरले नयाँ स्थानको पुष्टि गरेन। अघिल्लो स्थानीय पहिचान सुरक्षित राखियो।',
      'location_migration_device_changed':
          'सर्भरबाट फिर्ता आएको डिभाइस परिवर्तन हुँदै गरेको डिभाइससँग मेल खाँदैन। फेरि प्रयास गर्नुअघि डिभाइसहरू ताजा गर्नुहोस्।',
      'tunnel_stop_failed': 'नयाँ जडानअघि अघिल्लो टनेल पूर्ण रूपमा रोकिनुपर्छ।',
      'device_clock_ahead':
          'यो डिभाइसको घडी अगाडि भएजस्तो देखिन्छ। साइन इन रहिरहन स्वचालित मिति र समय सक्रिय गर्नुहोस्।',
      'other':
          'सञ्चालन पूरा गर्न सकिएन। फेरि प्रयास गर्नुहोस् वा निदान कोड सहायता टोलीलाई पठाउनुहोस्।',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'सत्रको म्याद सकियो',
      'invalid_credentials': 'साइन इन हुन सकेन',
      'email_verification_required': 'इमेल पुष्टिकरण आवश्यक छ',
      'verification_email_cooldown': 'इमेल पहिल्यै पठाइयो',
      'rate_limited': 'धेरै पटक प्रयास गरियो',
      'invalid_registration': 'जानकारी सच्याउनुहोस्',
      'email_exists': 'खाता पहिल्यै छ',
      'invalid_profile': 'प्रोफाइल अमान्य छ',
      'invalid_device': 'डिभाइस अमान्य छ',
      'invalid_location': 'स्थान उपलब्ध छैन',
      'device_limit': 'डिभाइसको सीमा पुग्यो',
      'device_exists': 'VPN पहिचान पहिल्यै प्रयोगमा छ',
      'device_identity_revoked': 'VPN पहिचान नवीकरण गर्नुपर्छ',
      'device_location_locked': 'स्थान परिवर्तन ताजा गर्नुपर्छ',
      'location_migration_pending': 'स्थान परिवर्तन हुँदै छ',
      'location_migration_blocked': 'स्थान परिवर्तन अवरुद्ध',
      'target_ca_mismatch': 'असंगत OpenVPN सर्भर',
      'location_migration_conflict': 'स्थान परिवर्तन ताजा गर्नुपर्छ',
      'server_full': 'सर्भर भरिएको छ',
      'capacity_unavailable': 'स्थान अस्थायी रूपमा उपलब्ध छैन',
      'target_unavailable': 'सर्भर अस्थायी रूपमा उपलब्ध छैन',
      'not_found': 'वस्तु फेला परेन',
      'invalid_openvpn_csr': 'OpenVPN पहिचान अमान्य छ',
      'openvpn_profile_exists': 'OpenVPN प्रोफाइल पहिल्यै छ',
      'openvpn_profile_revoked': 'OpenVPN प्रोफाइल रद्द गरियो',
      'openvpn_operation_pending': 'OpenVPN कार्य जारी छ',
      'openvpn_operation_terminal': 'OpenVPN कार्य बाधित भयो',
      'openvpn_address_unavailable': 'OpenVPN ठेगाना उपलब्ध छैन',
      'openvpn_profile_conflict': 'OpenVPN मा बेमेल',
      'openvpn_signer_unavailable': 'OpenVPN उपलब्ध छैन',
      'email_delivery_unavailable': 'इमेल उपलब्ध छैन',
      'invalid_token': 'लिङ्क अमान्य छ',
      'network_unavailable': 'इन्टरनेट जडान उपलब्ध छैन',
      'invalid_json': 'अनुरोध अमान्य छ',
      'invalid_api_response': 'सर्भरको प्रतिक्रिया अमान्य छ',
      'ipv6_unavailable': 'IPv6 उपलब्ध छैन',
      'invalid_ip_families': 'नेटवर्क कन्फिगरेसन अस्वीकार गरियो',
      'other': 'सेवा उपलब्ध छैन',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'तपाईंको सत्रको म्याद सकिएको छ। फेरि साइन इन गर्नुहोस्।',
      'invalid_credentials': 'इमेल ठेगाना वा पासवर्ड गलत छ।',
      'email_verification_required':
          'VPN डिभाइस थप्नुअघि आफ्नो इमेल ठेगाना पुष्टि गर्नुहोस्।',
      'invalid_registration': 'माग गरिएको जानकारी र सहमति जाँच गर्नुहोस्।',
      'email_exists': 'यो इमेल ठेगाना पहिल्यै एउटा खातामा प्रयोग भइसकेको छ।',
      'invalid_profile': 'तपाईंको प्रोफाइलको जानकारी जाँच गर्नुहोस्।',
      'invalid_device': 'यो डिभाइसको नाम वा स्थानीय पहिचान अमान्य छ।',
      'invalid_location': 'स्थान सूची ताजा गरेर फेरि प्रयास गर्नुहोस्।',
      'device_limit': 'अर्को डिभाइस थप्नुअघि कुनै एउटा डिभाइस हटाउनुहोस्।',
      'device_exists': 'यो VPN पहिचान अर्को खातासँग पहिल्यै जोडिएको छ।',
      'device_identity_revoked':
          'यो पहिचान हटाइएको छ। नयाँ स्थानीय पहिचान बनाउनुपर्छ।',
      'device_location_locked':
          'यो डिभाइसको स्थान अहिले मात्रै बदलियो। एपले जारी रहेको परिवर्तन फेरि सुरु गर्नेछ।',
      'location_migration_pending': 'स्थान परिवर्तन पहिले नै भइरहेको छ।',
      'location_migration_blocked':
          'यो स्थान परिवर्तनका लागि सर्भरको हस्तक्षेप चाहिन्छ। पछि फेरि प्रयास गर्नुहोस् वा सहायता टोलीसँग सम्पर्क गर्नुहोस्।',
      'target_ca_mismatch': 'यो सर्भर हालको OpenVPN प्रोफाइलसँग अझै मिल्दैन।',
      'location_migration_conflict':
          'डिभाइसहरू ताजा गर्नुहोस्, त्यसपछि स्थान परिवर्तन फेरि प्रयास गर्नुहोस्।',
      'server_full':
          'यो स्थानमा जडानको सीमा पुगिसकेको छ। अर्को स्थान छान्नुहोस् वा पछि फेरि प्रयास गर्नुहोस्।',
      'capacity_unavailable':
          'यो स्थान अहिले उपलब्ध छ कि छैन भनी हामी पुष्टि गर्न सक्दैनौं। अर्को स्थान छान्नुहोस् वा पछि फेरि प्रयास गर्नुहोस्।',
      'target_unavailable': 'यो सर्भर अस्थायी रूपमा उपलब्ध छैन।',
      'not_found': 'यो वस्तु अब तपाईंको खातामा उपलब्ध छैन।',
      'invalid_openvpn_csr': 'नयाँ OpenVPN पहिचान बनाएर फेरि प्रयास गर्नुहोस्।',
      'openvpn_profile_exists': 'यो डिभाइसका लागि OpenVPN प्रोफाइल पहिल्यै छ।',
      'openvpn_profile_revoked':
          'जारी राख्न OpenVPN प्रोफाइल नवीकरण गर्नुहोस्।',
      'openvpn_operation_pending':
          'परिवर्तन अझै लागू हुँदै छ। पछि फेरि प्रयास गर्नुहोस्।',
      'openvpn_operation_terminal':
          'नयाँ OpenVPN पहिचान बनाएर फेरि प्रयास गर्नुहोस्।',
      'openvpn_address_unavailable':
          'अहिले कुनै पनि OpenVPN ठेगाना उपलब्ध छैन।',
      'openvpn_profile_conflict':
          'प्रोफाइल परिवर्तन भयो। डिभाइसहरू ताजा गरेर फेरि प्रयास गर्नुहोस्।',
      'openvpn_signer_unavailable': 'OpenVPN सेवा अस्थायी रूपमा उपलब्ध छैन।',
      'email_delivery_unavailable':
          'इमेल पठाउन सकिएन। पछि फेरि प्रयास गर्नुहोस्।',
      'invalid_token':
          'यो लिङ्क अमान्य छ वा यसको म्याद सकिएको छ। नयाँ लिङ्कका लागि अनुरोध गर्नुहोस्।',
      'network_unavailable':
          'तपाईंको इन्टरनेट जडान जाँच गरेर फेरि प्रयास गर्नुहोस्।',
      'invalid_json':
          'प्रविष्ट गरिएको जानकारी जाँच गरेर फेरि प्रयास गर्नुहोस्।',
      'invalid_api_response':
          'सर्भरले अपेक्षित नभएको प्रतिक्रिया फर्कायो। पछि फेरि प्रयास गर्नुहोस्।',
      'ipv6_unavailable':
          'सर्भरले अहिले IPv6 सक्रिय गर्न सक्दैन। पछि फेरि प्रयास गर्नुहोस्।',
      'invalid_ip_families':
          'टनेल कन्फिगरेसन अपूर्ण छ वा अधिकृत ठेगानासँग मेल खाँदैन। एपबाट फेरि प्रयास गर्नुहोस्।',
      'other': 'सर्भरमा त्रुटि भयो। पछि फेरि प्रयास गर्नुहोस्।',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'केही बेरपछि फेरि प्रयास गर्नुहोस्।';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds सेकेन्डपछि फेरि प्रयास गर्नुहोस्।',
      one: '$seconds सेकेन्डपछि फेरि प्रयास गर्नुहोस्।',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes मिनेटपछि फेरि प्रयास गर्नुहोस्।',
      one: '$minutes मिनेटपछि फेरि प्रयास गर्नुहोस्।',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours घण्टापछि फेरि प्रयास गर्नुहोस्।',
      one: '$hours घण्टापछि फेरि प्रयास गर्नुहोस्।',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'सिस्टम VPN पुनः सुरु गर्न मिल्दैन',
      'system_vpn_resume_corrupt': 'अमान्य सिस्टम VPN पुनः सुरु',
      'system_vpn_resume_session_invalid': 'अमान्य VPN पुनः सुरु सत्र',
      'system_vpn_resume_identity_changed': 'VPN पहिचान परिवर्तन भयो',
      'system_vpn_resume_identity_invalid': 'अमान्य VPN पुनः सुरु पहिचान',
      'system_vpn_resume_storage_failed': 'VPN पुनः सुरु भण्डारण उपलब्ध छैन',
      'system_vpn_resume_network_timeout': 'VPN पुनः सुरु गर्न नेटवर्क छैन',
      'system_vpn_resume_blocked': 'VPN पुनः सुरु गर्न रोकियो',
      'system_vpn_resume_failed': 'VPN पुनः सुरु गर्न सकिएन',
      'system_vpn_resume_error_invalid': 'अमान्य VPN पुनः सुरु त्रुटि',
      'wireguard_identity_store_failed': 'WireGuard पहिचान सेभ भएन',
      'wireguard_identity_unavailable': 'WireGuard पहिचान उपलब्ध छैन',
      'vpn_host_destroyed': 'Android VPN होस्ट रोकियो',
      'vpn_host_unavailable': 'Android VPN होस्ट उपलब्ध छैन',
      'vpn_permission_required': 'VPN अनुमति आवश्यक छ',
      'vpn_permission_denied': 'VPN अनुमति अस्वीकार गरियो',
      'vpn_permission_request_failed': 'अनुमति अनुरोध गर्न सकिएन',
      'wireguard_foreground_service_unavailable': 'WireGuard सेवा उपलब्ध छैन',
      'wireguard_identity_invalid': 'स्थानीय WireGuard कुञ्जी अमान्य',
      'wireguard_identity_in_use': 'WireGuard पहिचान पहिल्यै प्रयोगमा छ',
      'wireguard_configuration_invalid': 'अमान्य WireGuard कन्फिगरेसन',
      'wireguard_operation_pending': 'WireGuard सञ्चालन अझै सक्रिय छ',
      'wireguard_start_failed': 'WireGuard सुरु गर्ने अनुरोध अस्वीकृत',
      'wireguard_stop_timeout': 'WireGuard रोकिएको पुष्टि भएन',
      'wireguard_handshake_timeout': 'WireGuard ले प्रतिक्रिया दिएन',
      'openvpn_connection_timeout': 'OpenVPN ले प्रतिक्रिया दिएन',
      'openvpn_core_unavailable': 'OpenVPN इन्जिन उपलब्ध छैन',
      'openvpn_operation_pending': 'OpenVPN सत्र अझै सक्रिय छ',
      'openvpn_stop_timeout': 'OpenVPN रोकिएको पुष्टि भएन',
      'openvpn_profile_unavailable': 'स्थानीय OpenVPN प्रोफाइल भेटिएन',
      'openvpn_native_failed': 'नेटिभ OpenVPN कल बाधित भयो',
      'openvpn_key_generation_failed': 'OpenVPN P-256 कुञ्जी बनाउन सकिएन',
      'openvpn_csr_generation_failed': 'OpenVPN CSR बनाउन सकिएन',
      'openvpn_identity_store_failed': 'OpenVPN पहिचान सेभ भएन',
      'openvpn_identity_clear_failed': 'OpenVPN हटाउने काम अपूर्ण',
      'openvpn_identity_in_use': 'OpenVPN पहिचान अझै प्रयोगमा छ',
      'openvpn_tls_verification_required': 'OpenVPN TLS प्रमाणीकरण छुटेको छ',
      'openvpn_cipher_invalid': 'अमान्य OpenVPN सिफर',
      'openvpn_profile_rejected': 'OpenVPN प्रोफाइल अस्वीकृत',
      'openvpn_identity_inconsistent': 'OpenVPN पहिचान मेल खाँदैन',
      'tls_handshake_failed': 'OpenVPN वार्ता अस्वीकृत',
      'tls_alert_unknown_ca': 'OpenVPN क्लाइन्ट प्रमाणपत्र पहिचान भएन',
      'tls_alert_bad_certificate': 'OpenVPN क्लाइन्ट प्रमाणपत्र अस्वीकृत',
      'tls_alert_unsupported_certificate': 'असमर्थित OpenVPN प्रमाणपत्र',
      'tls_client_certificate_required': 'OpenVPN क्लाइन्ट प्रमाणपत्र आवश्यक छ',
      'tls_alert_misc': 'OpenVPN TLS सूचना',
      'tls_signature_algorithm_rejected': 'असमर्थित OpenVPN हस्ताक्षर',
      'tls_handshake_rejected': 'OpenVPN TLS वार्ता अस्वीकृत',
      'tls_version_rejected': 'असंगत OpenVPN TLS संस्करण',
      'tls_certificate_expired': 'TLS प्रमाणपत्रको म्याद सकियो',
      'tls_certificate_revoked': 'TLS प्रमाणपत्र रद्द गरियो',
      'transport_failed': 'OpenVPN सर्भरसम्म पुग्न सकिएन',
      'tun_configuration_rejected': 'OpenVPN इन्टरफेस बनाउन सकिएन',
      'tun_setup_failed': 'OpenVPN TUN सेटअप असफल भयो',
      'tun_interface_create_failed': 'OpenVPN इन्टरफेस बनाउन असफल भयो',
      'tun_interface_disabled': 'OpenVPN इन्टरफेस निष्क्रिय पारियो',
      'tun_halted': 'OpenVPN इन्टरफेस बाधित भयो',
      'tun_already_established': 'OpenVPN इन्टरफेस पहिल्यै खुला छ',
      'tun_addresses_missing': 'OpenVPN ठेगाना भेटिएन',
      'tun_routes_missing': 'OpenVPN रुट भेटिएन',
      'tun_dns_missing': 'OpenVPN DNS भेटिएन',
      'tun_permission_revoked': 'VPN अनुमति रद्द गरियो',
      'tun_establish_returned_null': 'Android ले VPN इन्टरफेस अस्वीकार गर्यो',
      'openvpn_service_start_failed': 'OpenVPN सेवा उपलब्ध छैन',
      'openvpn_operation_timeout': 'OpenVPN कलको समय सकियो',
      'openvpn_start_failed': 'OpenVPN सुरु गर्ने अनुरोध अस्वीकृत',
      'openvpn_connection_failed': 'OpenVPN जडान बाधित भयो',
      'openvpn_core_status_error': 'OpenVPN कोर त्रुटिसहित समाप्त भयो',
      'openvpn_stopped_before_connected': 'जडान हुनुअघि OpenVPN रोकियो',
      'openvpn_auth_failed': 'OpenVPN प्रमाणीकरण अस्वीकृत',
      'openvpn_client_setup_failed': 'OpenVPN क्लाइन्ट सेटअप असफल भयो',
      'openvpn_client_halted': 'OpenVPN क्लाइन्ट बाधित भयो',
      'openvpn_client_restart': 'OpenVPN पुनः सुरु गर्न अनुरोध गरियो',
      'openvpn_inactive_timeout': 'OpenVPN लामो समय निष्क्रिय रह्यो',
      'openvpn_session_expired': 'OpenVPN सत्रको म्याद सकियो',
      'openvpn_credentials_required': 'असमर्थित OpenVPN प्रमाणीकरण',
      'openvpn_proxy_failed': 'OpenVPN मध्यवर्ती ट्रान्सपोर्ट असफल भयो',
      'openvpn_compression_failed': 'OpenVPN कम्प्रेसन अस्वीकृत',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM एन्क्रिप्सन उपलब्ध छैन',
      'openvpn_feature_unsupported': 'असमर्थित OpenVPN सुविधा',
      'network_unavailable': 'इन्टरनेट जडान उपलब्ध छैन',
      'network_lost': 'नेटवर्क उपलब्ध छैन',
      'certificate_validation_failed': 'सर्भर प्रमाणपत्र अस्वीकृत',
      'openvpn_certificate_expired': 'OpenVPN प्रमाणपत्रको म्याद सकियो',
      'tunnel_active_for_another_account': 'अर्को खाताको टनेल अझै सक्रिय छ',
      'tunnel_already_active': 'नेटिभ टनेल पहिल्यै सक्रिय छ',
      'tunnel_stop_timeout': '$protocol रोकिएको पुष्टि भएन',
      'tunnel_disconnected': '$protocol बाधित भयो',
      'native_bridge_unavailable': 'Android ब्रिज उपलब्ध छैन',
      'native_operation_failed': 'Android सञ्चालन बाधित भयो',
      'invalid_arguments': 'VPN प्यारामिटर अपूर्ण छन्',
      'invalid_account_id': 'अमान्य VPN खाता',
      'invalid_device_id': 'अमान्य डिभाइस पहिचानकर्ता',
      'storage_key_not_allowed': 'भण्डारण कुञ्जी अस्वीकृत',
      'secure_storage_read_failed': 'सुरक्षित पढ्ने काम असफल भयो',
      'secure_storage_write_failed': 'सुरक्षित लेख्ने काम असफल भयो',
      'key_generation_failed': 'WireGuard कुञ्जी बनाउन सकिएन',
      'csr_generation_failed': 'OpenVPN CSR बनाउन सकिएन',
      'openvpn_recovery_exhausted':
          'OpenVPN पुनर्प्राप्ति पहिल्यै प्रयोग भइसक्यो',
      'openvpn_recovery_failed': 'OpenVPN पुनर्प्राप्ति असफल भयो',
      'openvpn_renewal_required': 'OpenVPN प्रमाणपत्र नवीकरण आवश्यक छ',
      'other': 'वर्गीकरण नभएको नेटिभ VPN त्रुटि',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ले पुनः सुरु गर्न मिल्ने VPN सत्र भेटाउन सकेन। एपमा नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_corrupt':
          'सेभ गरिएको VPN पुनः सुरु डेटा अमान्य छ र प्रयोग गरिने छैन। नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_session_invalid':
          'सेभ गरिएको सत्रले अब VPN पुनः सुरु गर्न सक्दैन। एपमा फेरि साइन इन गर्नुहोस्।',
      'system_vpn_resume_identity_changed':
          'स्थानीय VPN पहिचान परिवर्तन भयो। पुनः सुरु गर्ने कार्य रोकियो। नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_identity_invalid':
          'पुनः सुरु गर्नका लागि पहिचान अमान्य छ। नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_storage_failed':
          'Android ले एन्क्रिप्ट गरिएको पुनः सुरु डेटा पढ्न वा अपडेट गर्न सकेन। नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_network_timeout':
          'Android ले VPN पुनः सुरु गर्न समयमै नेटवर्क भेटाएन। नेटवर्क उपलब्ध हुँदा फेरि प्रयास गर्नुहोस्।',
      'system_vpn_resume_blocked':
          'VPN पुनः सुरु गर्ने कार्य रोकिएको छ। Android सेटिङ जाँच गर्नुहोस्, त्यसपछि नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_failed':
          'Android VPN पुनः सुरु असफल भयो। एपमा नयाँ जडान सुरु गर्नुहोस्।',
      'system_vpn_resume_error_invalid':
          'Android ले प्रयोग गर्न नमिल्ने पुनः सुरु त्रुटि फर्कायो। नयाँ जडान सुरु गर्नुहोस्।',
      'wireguard_identity_store_failed':
          'Android ले यस खाताको एन्क्रिप्ट गरिएको WireGuard पहिचान सेभ गर्न सकेन।',
      'wireguard_identity_unavailable':
          'यो जडानका लागि प्रयोग गर्न मिल्ने WireGuard पहिचान उपलब्ध छैन।',
      'vpn_host_destroyed':
          'VPN चलाउने Android कम्पोनेन्ट रोकियो। नयाँ जडान सुरु गर्नुहोस्।',
      'vpn_host_unavailable':
          'Android ले VPN चलाउने कम्पोनेन्ट बनाउन सक्दैन। VPN सेटिङ जाँचेर फेरि प्रयास गर्नुहोस्।',
      'openvpn_renewal_required':
          'जडान गर्नुअघि प्रमाणपत्रका लागि एपमा कारबाही आवश्यक छ।',
      'openvpn_recovery_failed':
          'स्वचालित पुनर्प्राप्ति असफल भयो। एपमा नयाँ जडान सुरु गर्नुहोस्।',
      'openvpn_recovery_exhausted':
          'स्वचालित पुनर्प्राप्ति पहिल्यै प्रयोग भइसकेको छ। एपमा नयाँ जडान सुरु गर्नुहोस्।',
      'vpn_permission_required':
          'टनेल सुरु गर्नुअघि Android लाई नयाँ VPN अनुमति चाहिन्छ।',
      'vpn_permission_denied':
          'जारी राख्न Android को अनुरोधमा FuzeVPN लाई अनुमति दिनुहोस्।',
      'vpn_permission_request_failed':
          'Android ले VPN अनुमति स्क्रिन खोल्न सकेन।',
      'wireguard_foreground_service_unavailable':
          'Android ले WireGuard सेवालाई अग्रभूमिमा राख्न सकेन।',
      'wireguard_identity_invalid':
          'यस खाताको एन्क्रिप्ट गरिएको WireGuard कुञ्जी पढ्न नमिल्ने वा अमान्य छ।',
      'wireguard_identity_in_use':
          'अर्को सञ्चालनले अझै यस खाताको WireGuard कुञ्जी प्रयोग गरिरहेको छ।',
      'wireguard_configuration_invalid':
          'प्राप्त WireGuard ठेगाना, DNS, सर्भर कुञ्जी वा रुटहरू अमान्य छन्।',
      'wireguard_operation_pending':
          'अघिल्लो WireGuard सञ्चालनले अझै आफ्नो नेटिभ सेवा मुक्त गरेको छैन।',
      'wireguard_start_failed':
          'WireGuard इन्जिनले कन्फिगरेसन सक्रिय गर्न अस्वीकार गर्यो।',
      'wireguard_stop_timeout':
          'समय सीमाभित्र WireGuard सेवाले VPN इन्टरफेस मुक्त भएको पुष्टि गरेन।',
      'wireguard_handshake_timeout':
          'समयमै टनेलले सर्भरसँग ह्यान्डशेक पुष्टि गरेन।',
      'openvpn_connection_timeout':
          'समयमै OpenVPN ले सर्भरसँगको जडान पुष्टि गरेन।',
      'openvpn_core_unavailable':
          'यो एप संस्करणमा उपयोग गर्न मिल्ने OpenVPN इन्जिन छैन।',
      'openvpn_operation_pending':
          'नेटिभ इन्जिनले अघिल्लो OpenVPN सत्र अझै राखेको छ र दोस्रो सत्र बनाउन अस्वीकार गर्छ।',
      'openvpn_stop_timeout':
          'समय सीमाभित्र OpenVPN कोर ले आफ्नो नेटिभ सत्र रोकियो र नष्ट गरियो भनी पुष्टि गरेन।',
      'openvpn_profile_unavailable':
          'यो जडानका लागि मान्य OpenVPN प्रोफाइल पढ्न सकिँदैन।',
      'openvpn_native_failed':
          'एपको त्रुटिले OpenVPN बाधित गर्यो। फेरि जडान गर्ने प्रयास गर्नुहोस्। समस्या जारी रहेमा निदान चलाउनुहोस्।',
      'openvpn_key_generation_failed':
          'Android Keystore ले निर्यात गर्न नमिल्ने P-256 निजी कुञ्जी बनाउन वा पढ्न सकेन।',
      'openvpn_csr_generation_failed':
          'Android Keystore कुञ्जीले OpenVPN प्रमाणपत्र अनुरोधमा हस्ताक्षर गर्न सकेन।',
      'openvpn_identity_store_failed':
          'OpenVPN प्रमाणपत्र वा प्रोफाइल एन्क्रिप्ट गरिएको भण्डारणमा सेभ गर्न सकिएन।',
      'openvpn_identity_clear_failed':
          'Android ले यस खाताको स्थानीय OpenVPN पहिचान पूर्ण रूपमा हटाउन सकेन।',
      'openvpn_identity_in_use':
          'नेटिभ OpenVPN सत्रले अझै यस डिभाइसको कुञ्जी वा प्रमाणपत्र प्रयोग गरिरहेको छ।',
      'openvpn_tls_verification_required':
          'प्रोफाइलले सर्भर प्रमाणपत्रको प्रमाणीकरण स्पष्ट रूपमा अनिवार्य गरेको छैन।',
      'openvpn_cipher_invalid':
          'सर्भरले अनुमति प्राप्त सूचीमा नभएको एन्क्रिप्सन एल्गोरिदम पठायो।',
      'openvpn_profile_rejected':
          'सर्भरबाट प्राप्त प्रोफाइल असंगत छ। यो डिभाइस फेरि बनाएर प्रयास गर्नुहोस्।',
      'openvpn_identity_inconsistent':
          'प्रमाणपत्र यस फोनको सुरक्षित पहिचानसँग मेल खाँदैन। कुनै स्थानीय प्रोफाइल बदलिएन।',
      'tls_handshake_failed':
          'सर्भरले TLS वार्ता अस्वीकार गर्यो। समस्या जारी रहे प्रोफाइल फेरि बनाउनुहोस्।',
      'tls_alert_unknown_ca':
          'सर्भरले यो डिभाइसको प्रमाणपत्र जारी गर्ने निकायलाई चिन्दैन। OpenVPN सर्भर जाँच गर्नुपर्छ।',
      'tls_alert_bad_certificate':
          'सर्भरले यो डिभाइस प्रमाणपत्र अस्वीकार गर्यो। फेरि प्रयास गर्नुअघि डिभाइस फेरि बनाउनुहोस्।',
      'tls_alert_unsupported_certificate':
          'सर्भरले Android ले प्रयोग गर्ने सुरक्षित प्रमाणपत्र प्रकार समर्थन गर्दैन।',
      'tls_client_certificate_required':
          'सर्भरलाई क्लाइन्ट प्रमाणपत्र चाहिन्छ, तर OpenVPN कोर ले त्यो पेश गर्न सकेन।',
      'tls_alert_misc':
          'सर्भरले प्रमाणपत्र र संस्करण श्रेणीबाहिरको TLS सूचना फर्कायो।',
      'tls_signature_algorithm_rejected':
          'सर्भरले Android Keystore कुञ्जीको ECDSA P-256 एल्गोरिदम अस्वीकार गर्यो।',
      'tls_handshake_rejected': 'जडान हुनुअघि सर्भरले TLS वार्ता बीचमै रोक्यो।',
      'tls_version_rejected':
          'क्लाइन्ट र सर्भरले साझा TLS संस्करण फेला पारेनन्।',
      'tls_certificate_expired':
          'जडानको क्रममा देखाइएको प्रमाणपत्रको म्याद सकिएको छ।',
      'tls_certificate_revoked':
          'जडानको क्रममा देखाइएको प्रमाणपत्र रद्द गरिएको छ।',
      'transport_failed':
          'हालको नेटवर्कमा OpenVPN सर्भरले प्रतिक्रिया दिइरहेको छैन। केही समयपछि फेरि प्रयास गर्नुहोस्।',
      'tun_configuration_rejected':
          'OpenVPN ले अनुरोध गरेको नेटवर्क कन्फिगरेसन Android ले अस्वीकार गर्यो।',
      'tun_setup_failed':
          'Android इन्टरफेस बनाउनुअघि OpenVPN कोर ले नेटवर्क योजना अस्वीकार गर्यो।',
      'tun_interface_create_failed':
          'OpenVPN कोर ले Android VpnService बाट TUN इन्टरफेस प्राप्त गर्न सकेन।',
      'tun_interface_disabled':
          'जडानको क्रममा Android वा OpenVPN कोर ले TUN इन्टरफेस निष्क्रिय गर्यो।',
      'tun_halted': 'OpenVPN कोर ले TUN इन्टरफेस रोक्ने अनुरोध प्राप्त गर्यो।',
      'tun_already_established':
          'एउटै जडानमा OpenVPN ले दोस्रो इन्टरफेस माग्यो। सुरक्षाका लागि टनेल रोकियो।',
      'tun_addresses_missing': 'सर्भरले प्रयोग गर्न मिल्ने टनेल ठेगाना दिएन।',
      'tun_routes_missing': 'सर्भरले प्रयोग गर्न मिल्ने टनेल रुट दिएन।',
      'tun_dns_missing': 'सर्भरले प्रयोग गर्न मिल्ने DNS सर्भर दिएन।',
      'tun_permission_revoked':
          'जडानको क्रममा Android ले VPN अनुमति रद्द गर्यो।',
      'tun_establish_returned_null':
          'Android ले इन्टरफेस बनाएन, सामान्यतया अर्को VPN अझै सक्रिय भएकाले।',
      'openvpn_service_start_failed':
          'Android ले OpenVPN अग्रभूमि सेवा सुरु गर्न सकेन।',
      'openvpn_operation_timeout':
          'OpenVPN कोर मा गरिएको JNI कलले अधिकतम अवधि नाघ्यो।',
      'openvpn_start_failed':
          'Android सेवा तयार छ, तर OpenVPN कोर ले प्रोफाइल सुरु गर्न स्वीकार गरेन।',
      'openvpn_connection_failed':
          'CONNECTED इभेन्ट जारी गर्नुअघि OpenVPN कोर रोकियो।',
      'openvpn_core_status_error':
          'नेटिभ OpenVPN लुप त्रुटिसहित समाप्त भयो र थप विशिष्ट अन्तिम इभेन्ट भेटिएन।',
      'openvpn_stopped_before_connected':
          'स्पष्ट कोर त्रुटि नभई नेटिभ OpenVPN लुप CONNECTED अघि रोकियो।',
      'openvpn_auth_failed':
          'OpenVPN सर्भरले प्रोफाइलको प्रमाणीकरण अस्वीकार गर्यो।',
      'openvpn_client_setup_failed':
          'नेटवर्क जडान अघि OpenVPN कोर ले क्लाइन्ट सुरु गर्न सकेन।',
      'openvpn_client_halted':
          'OpenVPN कोर ले क्लाइन्ट अन्तिम रूपमा रोक्ने अनुरोध प्राप्त गर्यो।',
      'openvpn_client_restart':
          'OpenVPN कोर ले आफ्नो ट्रान्सपोर्ट सत्र पुनः सुरु गर्न अनुरोध गर्यो।',
      'openvpn_inactive_timeout':
          'निष्क्रियता समय सीमा नाघेपछि OpenVPN कोर ले सत्र बन्द गर्यो।',
      'openvpn_session_expired': 'सर्भरले OpenVPN सत्रको म्याद सकिएको जनायो।',
      'openvpn_credentials_required':
          'सर्भर वा प्रोक्सीले यो प्रमाणपत्र प्रोफाइलमा नभएको इन्टरएक्टिभ क्रेडेन्सियल माग्छ।',
      'openvpn_proxy_failed':
          'OpenVPN कोर ले कन्फिगर गरिएको प्रोक्सी वा रिलेमा असफलता जनायो।',
      'openvpn_compression_failed':
          'OpenVPN कोर ले प्रोफाइल वा सर्भरले घोषणा गरेको कम्प्रेसन मोड अस्वीकार गर्यो।',
      'openvpn_ntlm_crypto_unavailable':
          'प्रोफाइलले माग गरेको NTLM एन्क्रिप्सन यो संस्करणमा उपलब्ध छैन।',
      'openvpn_feature_unsupported':
          'प्रोफाइल वा सर्भरलाई यो Android क्लाइन्टमा नभएको सुविधा चाहिन्छ।',
      'network_unavailable': 'प्रयोग गर्न मिल्ने भौतिक नेटवर्क उपलब्ध छैन।',
      'network_lost': 'नेटवर्क हराएपछि टनेल रोकियो।',
      'certificate_validation_failed':
          'OpenVPN सर्भरको पहिचान प्रमाणित गर्न सकिएन।',
      'openvpn_certificate_expired':
          'फेरि जडान गर्नुअघि OpenVPN प्रोफाइल नवीकरण गर्नुहोस्।',
      'tunnel_active_for_another_account':
          'यो जडान गर्नुअघि अर्को खाताको टनेल रोकिनुपर्छ।',
      'tunnel_already_active':
          'Android ले अघिल्लो VPN सत्रले अझै इन्टरफेस प्रयोग गरिरहेको जनाएको छ।',
      'tunnel_stop_timeout':
          'समय सीमाभित्र $protocol इन्जिनले VPN इन्टरफेस मुक्त भएको पुष्टि गरेन।',
      'tunnel_disconnected':
          'सुरु भएपछि नेटिभ इन्जिनले टनेल अप्रत्याशित रूपमा समाप्त भएको जनायो।',
      'native_bridge_unavailable':
          'एपले Android VPN सेवामा पहुँच गर्न सक्दैन। एप बन्द गरी फेरि खोल्नुहोस्, त्यसपछि फेरि प्रयास गर्नुहोस्।',
      'native_operation_failed':
          'एपको त्रुटिले VPN सञ्चालन बाधित गर्यो। फेरि प्रयास गर्नुहोस्। समस्या जारी रहेमा निदान चलाउनुहोस्।',
      'invalid_arguments':
          'यो VPN सञ्चालनका लागि आवश्यक जानकारी अपूर्ण छ। फेरि प्रयास गर्नुहोस्। समस्या जारी रहेमा निदान चलाउनुहोस्।',
      'invalid_account_id':
          'नेटिभ सञ्चालन मान्य खाता पहिचानकर्तासँग सम्बन्धित छैन।',
      'invalid_device_id':
          'नेटिभ इन्जिनमा पठाइएको डिभाइस पहिचानकर्ता छुटेको वा अमान्य छ।',
      'storage_key_not_allowed':
          'Android ब्रिजले अनुमति प्राप्त भण्डारण सूचीभन्दा बाहिरको कुञ्जी रोक्यो।',
      'secure_storage_read_failed':
          'Android Keystore ले यस खाताको स्थानीय डेटा डिक्रिप्ट गर्न सकेन।',
      'secure_storage_write_failed':
          'Android Keystore ले स्थानीय डेटा एन्क्रिप्ट वा सेभ गर्न सकेन।',
      'key_generation_failed':
          'Android ले सुरक्षित भण्डारणमा WireGuard कुञ्जी बनाउन वा पढ्न सकेन।',
      'csr_generation_failed':
          'Android Keystore ले OpenVPN P-256 CSR बनाउन वा हस्ताक्षर गर्न सकेन।',
      'other':
          'नेटिभ कोडको कागजातमा उल्लेख नभएको एउटा भाग असफल भयो। तल देखाइएको निदान कोड सहायता टोलीलाई पठाउनुहोस्।',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'अनुमति अनुरोध पहिल्यै खुलेको छ';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN को अनुमति अनुरोध पहिल्यै देखाइएको छ। फेरि प्रयास गर्नुअघि त्यसलाई पूरा गर्नुहोस्।';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN अनुमति अनुरोध बाधित भयो';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'एपले जवाफ प्राप्त गर्नुअघि VPN अनुमति स्क्रिन बन्द भयो।';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN जडान पुष्टि भएन';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN जडान पुष्टि गर्न सकिएन। सुरक्षाका कारण यो रोकिएको छ। फेरि प्रयास गर्नुहोस्।';

  @override
  String get openvpnCleanup_title => 'रद्द गरिएको OpenVPN प्रोफाइल';

  @override
  String get openvpnCleanup_working =>
      'रद्द गरिएको OpenVPN प्रोफाइल रोक्दै र हटाउँदै छ…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN बन्द भएको पुष्टि हुन सकेन। नयाँ प्रोफाइल बनाउनुअघि फेरि प्रयास गर्नुहोस्।';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'रद्द गरिएको OpenVPN प्रोफाइल पूर्ण रूपमा हटाउन सकिएन। सफा गर्ने काम फेरि प्रयास गर्नुहोस्।';

  @override
  String get openvpnCleanup_complete =>
      'रद्द गरिएको OpenVPN प्रोफाइल हटाइयो। नयाँ बनाउन “जडान गर्नुहोस्” थिच्नुहोस्।';

  @override
  String get network_title => 'नेटवर्क कन्फिगरेसन';

  @override
  String get network_ipv4Fallback =>
      'IPv6 अस्थायी रूपमा उपलब्ध छैन। IPv4 प्रयोग गरेर तयारी जारी छ।';

  @override
  String get network_rejectedTitle => 'नेटवर्क कन्फिगरेसन अस्वीकार गरियो';

  @override
  String get network_rejectedMessage =>
      'टनेल कन्फिगरेसन अपूर्ण छ वा अधिकृत ठेगानासँग मेल खाँदैन। एपबाट फेरि प्रयास गर्नुहोस्।';

  @override
  String get network_unreadableTitle => 'स्थानीय कन्फिगरेसन पढ्न सकिँदैन';

  @override
  String get network_unreadableMessage =>
      'सेभ गरिएको OpenVPN नेटवर्क कन्फिगरेसन प्रयोग गर्न सकिँदैन। यसलाई अद्यावधिक गर्न एपबाट फेरि जडान गर्नुहोस्।';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'नेटवर्क सुरक्षा';

  @override
  String get protection_subtitle =>
      'VPN को जडान विच्छेद भएमा इन्टरनेटमा सिधा पहुँच रोक्नुहोस्।';

  @override
  String get protection_active => 'सिस्टम सुरक्षा सक्रिय छ';

  @override
  String get protection_alwaysOnOnly =>
      'सधैं सक्रिय VPN सक्षम छ। VPN बाहिरका जडानहरू अवरुद्ध गर्ने सुविधा पनि सक्षम गर्नुहोस्।';

  @override
  String get protection_inactive => 'सिस्टम सुरक्षा निष्क्रिय छ';

  @override
  String get protection_unknown => 'सिस्टम सुरक्षा जाँच गर्नुहोस्';

  @override
  String get protection_openSettings => 'Android सेटिङ खोल्नुहोस्';

  @override
  String get protection_dialogTitle => 'नेटवर्क सुरक्षा सेटअप गर्नुहोस्';

  @override
  String get protection_dialogMessage =>
      'Android ले सधैं सक्रिय VPN र VPN बाहिरका जडानहरू रोक्ने कुरा व्यवस्थापन गर्छ। FuzeVPN चयन गरिएको छ कि छैन जाँच गर्नुहोस् र सिस्टम सेटिङमा अवरुद्ध गर्ने सुविधा सक्रिय गर्नुहोस्।';

  @override
  String get protection_dialogOpen => 'सेटिङ खोल्नुहोस्';

  @override
  String get session_systemProtectionNote =>
      'यदि Android ले अझै VPN बाहिरको ट्राफिक रोकिरहेको छ भने, यो सुरक्षा जाँच वा परिवर्तन गर्न सिस्टम सेटिङ खोल्नुहोस्।';

  @override
  String get diagnostics_title => 'निदान';

  @override
  String get diagnostics_settingsTitle => 'एपको निदान';

  @override
  String get diagnostics_automaticTitle => 'महत्त्वपूर्ण त्रुटिहरू पठाउनुहोस्';

  @override
  String get diagnostics_automaticDescription =>
      'महत्त्वपूर्ण त्रुटि देखिँदा एउटा सानो प्राविधिक प्रतिवेदन साझा गर्नुहोस्।';

  @override
  String get diagnostics_privacy =>
      'पठाइएका प्रतिवेदनहरू साइन इन गरिएको खातासँग जोडिन्छन् र 30 दिनसम्म राखिन्छन्। तिनमा ब्राउजिङ इतिहास, पासवर्ड वा VPN कुञ्जीहरू हुँदैनन्।';

  @override
  String get diagnostics_manualOpen => 'निदान चलाउनुहोस्';

  @override
  String get diagnostics_localDescription =>
      'एप र VPN को स्थितिको प्रतिवेदन बनाउनुहोस्। तपाईंको जडान जस्ताको तस्तै रहन्छ।';

  @override
  String get diagnostics_sendReport => 'प्रतिवेदन पठाउनुहोस्';

  @override
  String get diagnostics_sendHint =>
      'प्रतिवेदन यही डिभाइसमा राख्न यो चेकबक्स खाली छोड्नुहोस्।';

  @override
  String get diagnostics_signedOut =>
      'प्रतिवेदन पठाउन आफ्नो खातामा साइन इन गर्नुहोस्।';

  @override
  String get diagnostics_localLifetime =>
      'एप बन्द गरेपछि पनि प्रतिवेदन राख्न यसलाई आफ्नो फोनमा सेभ गर्नुहोस्।';

  @override
  String get diagnostics_run => 'निदान चलाउनुहोस्';

  @override
  String get diagnostics_rerun => 'निदान फेरि चलाउनुहोस्';

  @override
  String get diagnostics_running => 'जाँच गर्दै…';

  @override
  String get diagnostics_sending => 'प्रतिवेदन पठाउँदै…';

  @override
  String get diagnostics_prepared => 'प्रतिवेदन यो डिभाइसमा तयार छ';

  @override
  String get diagnostics_queued => 'प्रतिवेदन पठाउन पर्खिरहेको छ';

  @override
  String get diagnostics_sent => 'प्रतिवेदन प्राप्त भयो';

  @override
  String get diagnostics_failed =>
      'पठाउन सकिएन। तपाईंको स्थानीय प्रतिवेदन अझै उपलब्ध छ।';

  @override
  String get diagnostics_preparationFailed =>
      'निदान प्रतिवेदन तयार गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get diagnostics_authenticationRequired =>
      'प्रतिवेदन पठाउन फेरि साइन इन गर्नुहोस्।';

  @override
  String get diagnostics_retry => 'फेरि पठाउनुहोस्';

  @override
  String get diagnostics_export => 'प्रतिवेदन सेभ गर्नुहोस्';

  @override
  String get diagnostics_exportFailed =>
      'सेभ गर्न सकिएन। स्थानीय प्रतिवेदनबाट फेरि प्रयास गर्नुहोस्।';

  @override
  String get diagnostics_preferenceFailed =>
      'यो सेटिङ सेभ गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String diagnostics_receipt(Object id) {
    return 'सन्दर्भ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date मा प्राप्त भयो';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date सम्म राखिन्छ';
  }

  @override
  String get diagnostics_duplicate =>
      'यो प्रतिवेदन पहिल्यै प्राप्त भइसकेको थियो।';

  @override
  String get diagnostics_preview => 'प्रतिवेदनको पूर्वावलोकन';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्राविधिक घटना संलग्न छन्',
      one: '1 प्राविधिक घटना संलग्न छ',
      zero: 'कुनै प्राविधिक घटना संलग्न छैन',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'प्राविधिक विवरण';

  @override
  String get diagnostics_empty =>
      'अहिलेसम्म कुनै निदान प्रतिवेदन तयार गरिएको छैन।';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'टनेलको स्थिति',
      'handshake': 'जडान पुष्टि',
      'certificate': 'VPN प्रमाणपत्र',
      'kill_switch': 'Android सुरक्षा',
      'connectivity': 'उपलब्ध नेटवर्क',
      'api_reachability': 'सेवा पहुँच',
      'secure_storage': 'सुरक्षित भण्डारण',
      'other': 'स्थानीय जाँच',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'जाँच गरियो',
      'failed': 'ध्यान दिनुपर्छ',
      'skipped': 'परीक्षण गरिएन — सक्रिय जाँच छैन',
      'unknown': 'जानकारी उपलब्ध छैन',
      'other': 'जानकारी उपलब्ध छैन',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN मा स्वागत छ';

  @override
  String get connection_changeLocation => 'स्थान बदल्नुहोस्';

  @override
  String get connection_details => 'जडानको विवरण';

  @override
  String get locations_searchLabel => 'शहर वा देश खोज्नुहोस्';

  @override
  String get locations_clearSearch => 'खोजी खाली गर्नुहोस्';

  @override
  String get locations_filterAll => 'सबै';

  @override
  String get locations_filterFavorites => 'मनपर्ने';

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
  String get locations_noResults => 'कुनै स्थान भेटिएन';

  @override
  String get locations_noResultsHint => 'अर्को शहर वा देश प्रयास गर्नुहोस्।';

  @override
  String get locations_noFavorites => 'तपाईंका मनपर्ने स्थानहरू, सजिलै पहुँचमा';

  @override
  String get locations_noFavoritesHint =>
      'कुनै स्थानलाई यहाँ सेभ गर्न त्यसको छेउको ताराचिन्ह थिच्नुहोस्।';

  @override
  String get locations_showAll => 'सबै स्थानहरू हेर्नुहोस्';

  @override
  String locations_addFavorite(String name) {
    return '$name लाई मनपर्नेमा थप्नुहोस्';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name लाई मनपर्नेबाट हटाउनुहोस्';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'मनपर्ने स्थान सेभ गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get locations_emptyTitle => 'कुनै स्थान उपलब्ध छैन';

  @override
  String get locations_emptyHint => 'फेरि प्रयास गर्न सूची ताजा गर्नुहोस्।';

  @override
  String get devices_manage => 'मेरा डिभाइसहरू व्यवस्थापन गर्नुहोस्';

  @override
  String get settings_personalization => 'आफ्नो रुचिअनुसार बनाउनुहोस्';

  @override
  String get settings_safety => 'सुरक्षा';

  @override
  String get settings_help => 'सहायता चाहिन्छ?';

  @override
  String get settings_about => 'FuzeVPN को बारेमा';

  @override
  String get diagnostics_heading => 'जडानको समस्या बुझ्नुहोस्';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'उपलब्ध',
      'pending': 'तयारी हुँदै',
      'revoked': 'हटाइएको',
      'expired': 'म्याद सकिएको',
      'other': 'स्थिति उपलब्ध छैन',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'प्राथमिकता सेभ भएन';

  @override
  String get notice_preferenceSave_message =>
      'तपाईंको छनोट अहिलेका लागि लागू गरिएको छ, तर सेभ गर्न सकिएन। एप बन्द गरेपछि पनि यो कायम राख्न फेरि प्रयास गर्नुहोस्।';

  @override
  String get connection_androidDisconnectHint =>
      'Android ले VPN सक्रिय राखेमा, खुल्ने सेटिङमा सधैं सक्रिय VPN बन्द गर्नुहोस्।';

  @override
  String get protection_learnMore => 'Android सुरक्षाबारे थप जान्नुहोस्';

  @override
  String get protection_guideWhy =>
      'यो सुरक्षाले VPN को जडान विच्छेद भएमा एपहरूलाई सिधै इन्टरनेट प्रयोग गर्न दिँदैन। यो Android मा कन्फिगर गरिन्छ।';

  @override
  String get protection_guideAlwaysOnTitle => 'सधैं सक्रिय VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android ले VPN सेवालाई चलिरहन दिन्छ र फोन पुनः सुरु भएपछि यसलाई फेरि सुरु गर्न सक्छ।';

  @override
  String get protection_guideBlockTitle => 'VPN बिना जडानहरू अवरुद्ध गर्नुहोस्';

  @override
  String get protection_guideBlock =>
      'यो सेटिङले जडान बाधित भएको बेला पनि ट्राफिकलाई VPN छल्न दिँदैन।';

  @override
  String get protection_guideWarning =>
      'यो सेटिङ सक्रिय भएमा, VPN जडान नभएसम्म इन्टरनेट पहुँच बन्द रहन्छ।';

  @override
  String get protection_guideStepsTitle => 'सुरक्षा सक्रिय गर्नुहोस्';

  @override
  String get protection_guideStep1 =>
      'तलको बटन थिचेर Android को VPN सेटिङ खोल्नुहोस्।';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN को छेउको गियर आइकन थिचेर विकल्पहरू खोल्नुहोस्।';

  @override
  String get protection_guideStep3 =>
      'उपलब्ध भएमा पहिले “सधैं सक्रिय VPN” र त्यसपछि “VPN बिना जडानहरू अवरुद्ध गर्नुहोस्” सक्रिय गर्नुहोस्।';

  @override
  String get protection_guideManufacturers =>
      'नामहरू फोनअनुसार फरक हुन्छन्। आवश्यक परे सेटिङमा VPN खोज्नुहोस्, प्रायः नेटवर्क र इन्टरनेट अन्तर्गत।';

  @override
  String get protection_guideDisableTitle => 'यो सुरक्षा बन्द गर्नुहोस्';

  @override
  String get protection_guideDisable =>
      'VPN बिना इन्टरनेट पहुँचको अनुमति दिन उही सेटिङमा “VPN बिना जडानहरू अवरुद्ध गर्नुहोस्” बन्द गर्नुहोस्। Android ले VPN लाई फेरि सुरु गरेको तपाईं चाहनुहुन्न भने “सधैं सक्रिय VPN” पनि बन्द गर्नुहोस्।';

  @override
  String get protection_guideManual =>
      'यी सेटिङहरू तपाईंले Android मा छान्नुहुन्छ। FuzeVPN ले तपाईंका लागि यिनलाई परिवर्तन गर्दैन।';

  @override
  String get locations_changeTitle => 'स्थान बदल्ने हो?';

  @override
  String locations_changeActive(String name) {
    return 'VPN को जडान विच्छेद हुनेछ, त्यसपछि $name मा जडान गर्ने प्रयास गरिनेछ।';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN ले $name मा जडान गर्ने प्रयास गर्नेछ।';
  }

  @override
  String get locations_confirmChange => 'बदल्नुहोस् र जडान गर्नुहोस्';

  @override
  String get locations_changeBusy =>
      'परिवर्तन हुँदै छ। अर्को स्थान छान्नुअघि पर्खनुहोस्।';

  @override
  String get locations_automaticSelection => 'स्वचालित चयन';

  @override
  String get locations_cities => 'शहरहरू';

  @override
  String get locations_servers => 'सर्भरहरू';

  @override
  String locations_viewCities(String name) {
    return '$name का शहरहरू हेर्नुहोस्';
  }

  @override
  String locations_viewServers(String name) {
    return '$name का सर्भरहरू हेर्नुहोस्';
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
      other: '$count सर्भर',
      one: '$count सर्भर',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'सबै देशहरू';

  @override
  String get locations_backToCountries => 'देशहरूमा फर्कनुहोस्';

  @override
  String locations_backToCities(String name) {
    return '$name का शहरहरूमा फर्कनुहोस्';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name छान्नुहोस्';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name छान्नुहोस्';
  }

  @override
  String get locations_noCompatibleServer => 'उपयुक्त सर्भर उपलब्ध छैन।';

  @override
  String get externalLink_failed =>
      'यो लिङ्क खोल्न सकिएन। तपाईं यसलाई कपी गरेर आफ्नो ब्राउजरमा खोल्न सक्नुहुन्छ।';

  @override
  String get externalLink_copy => 'लिङ्क कपी गर्नुहोस्';

  @override
  String get externalLink_copied => 'लिङ्क कपी गरियो';

  @override
  String get externalLink_copyFailed =>
      'लिङ्क कपी गर्न सकिएन। तलको ठेगाना चयन गर्नुहोस्।';

  @override
  String get settings_deleteAccount => 'मेरो खाता मेटाउनुहोस्';

  @override
  String get settings_deleteAccountDetail =>
      'खाता मेटाउने अनुरोधको प्रक्रिया हेर्नुहोस्';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'आफ्नो VPN सदस्यता छान्नुहोस्।';

  @override
  String get billing_subscribe => 'सदस्यता लिनुहोस्';

  @override
  String get billing_choosePlan => 'जारी राख्न योजना छान्नुहोस्।';

  @override
  String get billing_monthly => 'मासिक';

  @override
  String get billing_yearly => 'वार्षिक';

  @override
  String get billing_continue => 'Google Play सँग जारी राख्नुहोस्';

  @override
  String get billing_restore => 'खरिदहरू पुनर्स्थापित गर्नुहोस्';

  @override
  String get billing_manage => 'सदस्यता व्यवस्थापन गर्नुहोस्';

  @override
  String get billing_deleteAccountWarning =>
      'तपाईंसँग Google Play सदस्यता छ भने FuzeVPN खाता मेटाउँदा त्यसको नवीकरण रद्द हुँदैन। Google Play मा छुट्टै नवीकरण व्यवस्थापन गर्नुहोस् वा रद्द गर्नुहोस्।';

  @override
  String get billing_deleteAccountContinue =>
      'खाता मेटाउने अनुरोधमा जारी राख्नुहोस्';

  @override
  String get billing_refresh => 'पहुँच ताजा गर्नुहोस्';

  @override
  String get billing_loadingPlans => 'योजनाहरू लोड हुँदैछन्…';

  @override
  String get billing_unavailable =>
      'अहिले कुनै योजना उपलब्ध छैन। पछि फेरि प्रयास गर्नुहोस्।';

  @override
  String get billing_comingSoon => 'सदस्यताहरू चाँडै आउँदैछन्।';

  @override
  String get billing_priceDisclosure =>
      'मूल्य Google Play ले उपलब्ध गराएको हो। तपाईंले पुष्टि गर्नुअघि अन्तिम रकम र लागू हुने करहरू पक्का गरिन्छ।';

  @override
  String get billing_renewalMonthly =>
      'रद्द नगरेसम्म हरेक महिना स्वतः नवीकरण हुन्छ। Google Play का सदस्यताहरूमा जुनसुकै बेला रद्द गर्न सक्नुहुन्छ।';

  @override
  String get billing_renewalYearly =>
      'रद्द नगरेसम्म हरेक वर्ष स्वतः नवीकरण हुन्छ। Google Play का सदस्यताहरूमा जुनसुकै बेला रद्द गर्न सक्नुहुन्छ।';

  @override
  String get billing_active => 'तपाईंको Premium पहुँच सक्रिय छ';

  @override
  String billing_accessUntil(String date) {
    return '$date सम्म पहुँच रहनेछ।';
  }

  @override
  String get billing_webManaged =>
      'तपाईंको सदस्यता FuzeVPN वेबसाइटमा व्यवस्थापन गरिन्छ।';

  @override
  String get billing_playManaged =>
      'तपाईंको सदस्यता Google Play ले व्यवस्थापन गर्छ।';

  @override
  String get billing_playOnHold =>
      'तपाईंको Google Play सदस्यता रोकिएको छ वा भुक्तानीको प्रतीक्षामा छ। Google Play मा यसलाई मिलाउन “सदस्यता व्यवस्थापन गर्नुहोस्” खोल्नुहोस्।';

  @override
  String get billing_playReceiptUnlinked =>
      'यो Google Play खातामा पहिल्यै Fuze Premium सदस्यता छ, तर यो FuzeVPN खाताका लागि सक्रिय छैन। Google Play मा यसको विवरण हेर्न “सदस्यता व्यवस्थापन गर्नुहोस्” खोल्नुहोस्।';

  @override
  String get billing_inactive => 'कुनै सक्रिय सदस्यता छैन।';

  @override
  String get billing_checkingAccess => 'तपाईंको पहुँच जाँच गर्दै…';

  @override
  String get billing_restoring => 'खरिदहरू पुनर्स्थापित गर्दै…';

  @override
  String get billing_pending =>
      'भुक्तानी प्रक्रियामा छ। पुष्टि भएपछि तपाईंको पहुँच सक्रिय हुनेछ।';

  @override
  String get billing_cancelled =>
      'खरिद रद्द गरियो। कुनै नयाँ सदस्यता सक्रिय गरिएको छैन।';

  @override
  String get billing_verifying => 'खरिद प्रमाणित गर्दै…';

  @override
  String get billing_success =>
      'सदस्यता सक्रिय भयो। तपाईंको Premium पहुँच तयार छ।';

  @override
  String get billing_restored => 'तपाईंका खरिदहरू पुनर्स्थापित गरिए।';

  @override
  String get billing_restoreEmpty =>
      'यो Google Play खाताका लागि पुनर्स्थापित गर्ने कुनै खरिद छैन।';

  @override
  String get billing_catalogError =>
      'योजनाहरू लोड गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get billing_purchaseError =>
      'खरिद सुरु गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get billing_verificationError =>
      'खरिद प्रमाणीकरण अस्थायी रूपमा उपलब्ध छैन। फेरि प्रयास गर्न खरिदहरू पुनर्स्थापित गर्नुहोस्।';

  @override
  String get billing_restoreError =>
      'खरिदहरू पुनर्स्थापित गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get billing_managementError =>
      'सदस्यता व्यवस्थापन खोल्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get billing_storeUnavailable => 'यो डिभाइसमा Google Play उपलब्ध छैन।';

  @override
  String get welcome_title => 'तपाईंको VPN, सरल तरिकाले।';

  @override
  String get welcome_description =>
      'आफ्नो जडान सुरक्षित राख्नुहोस्। आफ्नो गोपनीयतामाथि नियन्त्रण राख्नुहोस्।';

  @override
  String get welcome_start => 'सुरु गर्नुहोस्';

  @override
  String get welcome_alreadyPurchased => 'पहिल्यै खरिद गर्नुभएको हो?';

  @override
  String get welcome_noAccountRequired => 'सुरु गर्न खाता आवश्यक पर्दैन।';

  @override
  String get guest_accountTitle => 'खाता जोडिएको छैन';

  @override
  String get guest_accountDescription =>
      'अर्को डिभाइसमा आफ्नो सदस्यता प्रयोग गर्न उही Google Play खाताबाट आफ्ना खरिदहरू पुनर्स्थापित गर्नुहोस्।';

  @override
  String get guest_existingSubscriberSignIn =>
      'पहिल्यै सदस्य हुनुहुन्छ? साइन इन गर्नुहोस्';

  @override
  String get guest_claimTitle => 'FuzeVPN लाई आफूसँगै लैजानुहोस्';

  @override
  String get guest_claimDescription =>
      'अन्य डिभाइसहरूमा आफ्नो सदस्यता प्रयोग गर्न खाता बनाउनुहोस्। यो चरण वैकल्पिक हो।';

  @override
  String get guest_skip => 'पछि';

  @override
  String get guest_activationTitle => 'Fuze Premium सक्रिय छ';

  @override
  String get guest_activationDescription =>
      'तपाईंको सदस्यता तयार छ। तपाईं आफ्नो VPN प्रयोग गर्न सक्नुहुन्छ र जब चाहनुहुन्छ खाता बनाउन सक्नुहुन्छ।';

  @override
  String get guest_useVpn => 'मेरो VPN प्रयोग गर्नुहोस्';

  @override
  String get guest_loginRequired =>
      'यो खरिद पहिल्यै FuzeVPN खातासँग जोडिएको छ। आफ्नो सदस्यता प्रयोग गर्न त्यो खातामा साइन इन गर्नुहोस्।';

  @override
  String get guest_signOutWarning =>
      'उही Google Play खाताबाट खरिदहरू पुनर्स्थापित गरेर तपाईं आफ्नो सदस्यता फेरि प्राप्त गर्न सक्नुहुन्छ।';

  @override
  String get guest_profileUnavailable =>
      'तपाईंको खाता पहिल्यै जोडिएको छ। आफ्नो विवरण हेर्न र व्यवस्थापन गर्न साइन इन गर्नुहोस्।';

  @override
  String get billing_acceptance =>
      'जारी राख्दा तपाईं प्रयोगका सर्तहरू र गोपनीयता नीति स्वीकार गर्नुहुन्छ।';

  @override
  String get guest_verifyEmailReminder =>
      'खाता सुरक्षित राख्न आफ्नो इमेल ठेगाना पुष्टि गर्नुहोस्। तपाईं आफ्नो VPN प्रयोग जारी राख्न सक्नुहुन्छ।';

  @override
  String get guest_serviceUnavailable =>
      'सेवा अस्थायी रूपमा उपलब्ध छैन। केही समयपछि फेरि प्रयास गर्नुहोस्।';

  @override
  String get guest_restoreError =>
      'तपाईंका खरिदहरू पुनर्स्थापित गर्न सकिएन। खरिद गर्दा प्रयोग गरिएको Google Play खाताबाट फेरि प्रयास गर्नुहोस्।';

  @override
  String get guest_claimSuccess =>
      'तपाईंको खाता बनाइयो। तपाईंको सदस्यता र VPN पहुँच कायम छन्।';

  @override
  String get guest_emailExists =>
      'यो इमेल पहिल्यै प्रयोगमा छ। अर्को ठेगाना छान्नुहोस् वा आफ्नो विद्यमान खातामा साइन इन गर्नुहोस्। तपाईंको खरिद Google Play मार्फत उपलब्ध रहन्छ।';

  @override
  String get guest_claimError =>
      'तपाईंको खाता बनाउन सकिएन। तपाईं आफ्नो VPN प्रयोग जारी राख्न सक्नुहुन्छ र पछि फेरि प्रयास गर्न सक्नुहुन्छ।';

  @override
  String get guest_secureStorageError =>
      'यो डिभाइसमा तपाईंको सत्र सुरक्षित गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get guest_premiumRequired =>
      'आफ्नो VPN सक्रिय गर्न सदस्यता छान्नुहोस्।';

  @override
  String get welcome_viewPlans => 'योजनाहरू हेर्नुहोस्';

  @override
  String get google_continue => 'Google सँग जारी राख्नुहोस्';

  @override
  String get google_or => 'वा';

  @override
  String get google_title => 'तपाईंको FuzeVPN खाता';

  @override
  String get google_settingUp => 'तपाईंको खाता बनाउने काम पूरा गर्नुहोस्';

  @override
  String get google_country => 'बसोबासको देश';

  @override
  String get google_profileDescription =>
      'आफ्नो देश छान्नुहोस् र FuzeVPN खाता बनाउन दुवै कागजात पढ्नुहोस्।';

  @override
  String get google_claimDescription =>
      'आफ्नो अतिथि खातालाई Google सँग जोड्नुहोस्। तपाईंको सदस्यता र डिभाइस यही खातासँग जोडिएका रहन्छन्।';

  @override
  String get google_linkTitle => 'Google लाई FuzeVPN सँग जोड्नुहोस्';

  @override
  String get google_linkDescription =>
      'तपाईंको विद्यमान FuzeVPN खातामा पहुँच पुष्टि गर्नुहोस्। यो चरणमा तपाईंको Google पासवर्ड सोधिँदैन।';

  @override
  String get google_password => 'FuzeVPN पासवर्ड';

  @override
  String get google_linkAccount => 'जोड्ने कार्य पुष्टि गर्नुहोस्';

  @override
  String get google_requestEmail => 'मलाई पुष्टिकरण इमेल पठाउनुहोस्';

  @override
  String get google_emailInstructions =>
      'FuzeVPN को इमेल खोल्नुहोस् र पुष्टिकरण कोड प्रविष्ट गर्नुहोस्।';

  @override
  String get google_emailCode => 'इमेल पुष्टिकरण कोड';

  @override
  String get google_confirmEmail => 'कोड पुष्टि गर्नुहोस्';

  @override
  String get google_restart => 'अर्को Google खाता छान्नुहोस्';

  @override
  String get google_resume => 'यो प्रयास जाँच गर्नुहोस्';

  @override
  String get google_unavailable =>
      'Google साइन इन उपलब्ध छैन। तपाईं इमेल र पासवर्ड प्रयोग गर्न सक्नुहुन्छ।';

  @override
  String get google_expired =>
      'यो प्रयासको म्याद सकियो। यसलाई रद्द गरेर फेरि सुरु गर्नुहोस्।';

  @override
  String get google_conflict =>
      'यो Google खाता अन्यत्र पहिल्यै जोडिएको छ। तपाईंको हालको खाता र सदस्यता कायम राखिएको छ।';

  @override
  String get google_error =>
      'Google साइन इन असफल भयो। फेरि प्रयास गर्नुहोस्। तपाईंको हालको पहुँच कायम छ।';

  @override
  String get google_uncertain =>
      'नतिजा पुष्टि गर्न सकिएन। फेरि सुरु गर्नुअघि यो प्रयास जाँच गर्नुहोस् वा रद्द गर्नुहोस्।';

  @override
  String get google_cancelFailed =>
      'रद्द गरिएको पुष्टि हुन सकेन। यो स्क्रिन छोड्नुअघि फेरि रद्द गर्ने प्रयास गर्नुहोस्।';

  @override
  String get google_cancelled => 'Google साइन इन रद्द गरियो।';

  @override
  String get google_selecting => 'आफ्नो Google खाता छान्नुहोस्…';

  @override
  String get google_verifying => 'तपाईंको खाता जाँच गर्दै…';

  @override
  String get google_emailUnavailable =>
      'पुष्टिकरण इमेल पठाउन सकिएन। पछि फेरि प्रयास गर्नुहोस्।';

  @override
  String get google_emailSent =>
      'पुष्टिकरण इमेल पठाइयो। आफ्नो इनबक्स जाँच गर्नुहोस्।';

  @override
  String get google_rateLimited => 'फेरि प्रयास गर्नुअघि कृपया पर्खनुहोस्।';

  @override
  String get google_busy =>
      'अर्को कार्य चलिरहेको बेला (VPN जडान, खाता वा अतिथि) Google उपलब्ध हुँदैन। कार्य सकिएपछि फेरि प्रयास गर्नुहोस्। तपाईंको हालको पहुँच कायम रहन्छ।';

  @override
  String get google_invalidPassword =>
      'FuzeVPN पासवर्ड गलत छ। तपाईंको हालको खाता कायम राखिएको छ।';

  @override
  String get google_invalidCode =>
      'पुष्टिकरण कोड अमान्य छ वा यसको म्याद सकिएको छ।';

  @override
  String get google_accountChanged =>
      'तपाईंको सत्र परिवर्तन भएको छ। फेरि सुरु गर्नुअघि यो प्रयास रद्द गर्नुहोस्।';

  @override
  String get google_invalidResponse =>
      'प्रतिक्रिया प्रमाणित गर्न सकिएन। तपाईंको हालको पहुँच कायम छ।';

  @override
  String get google_invalidRegistration =>
      'आफ्नो देश र दुवै सहमति जाँच गर्नुहोस्।';

  @override
  String get google_consentRequired =>
      'जारी राख्न आफ्नो देश छान्नुहोस् र दुवै कागजात स्वीकार गर्नुहोस्।';

  @override
  String get google_challengeRequired =>
      'थप सुरक्षा जाँच आवश्यक छ। तपाईंको हालको पहुँच कायम छ।';

  @override
  String get google_challengeUnavailable =>
      'सुरक्षा जाँच उपलब्ध छैन। पछि फेरि प्रयास गर्नुहोस्।';

  @override
  String get google_intentMismatch =>
      'अघिल्लो Google साइन इन प्रयास अझै बाँकी छ। यो कार्य सुरु गर्नुअघि त्यसलाई रद्द गर्नुहोस्।';

  @override
  String get google_challengeBlocked =>
      'यो एपमा आवश्यक सुरक्षा जाँच उपलब्ध छैन। यो कार्य अहिले पूरा गर्न सकिँदैन।';

  @override
  String get google_solveChallenge => 'सुरक्षा जाँच पूरा गर्नुहोस्';

  @override
  String get google_challengeTitle => 'सुरक्षा जाँच';

  @override
  String get google_challengeReady =>
      'प्रमाणीकरण पूरा भयो। अब तपाईं आफ्नो खाता बनाउने कुरा पुष्टि गर्न सक्नुहुन्छ।';

  @override
  String get google_challengeExpired =>
      'प्रमाणीकरणको म्याद सकियो। पुष्टि गर्नुअघि फेरि पूरा गर्नुहोस्।';

  @override
  String get google_challengeCancelled =>
      'प्रमाणीकरण रद्द गरियो। तपाईं फेरि प्रयास गर्न सक्नुहुन्छ।';

  @override
  String get google_challengeFailed =>
      'सुरक्षा जाँच असफल भयो। फेरि प्रयास गर्नुहोस्।';

  @override
  String get billing_trialTitle => 'Fuze Premium निःशुल्क प्रयास गर्नुहोस्';

  @override
  String get billing_trialSubtitle =>
      'आजदेखि नै आफ्नो जडान सुरक्षित राख्नुहोस्।';

  @override
  String get billing_trialWeeks => '2 हप्ताको निःशुल्क परीक्षण';

  @override
  String billing_trialDays(String days) {
    return '$days दिनको निःशुल्क परीक्षण';
  }

  @override
  String get billing_trialStart => 'मेरो निःशुल्क परीक्षण सुरु गर्नुहोस्';

  @override
  String billing_trialFirstCharge(String date) {
    return 'आज सुरु गर्नुभयो भने पहिलो शुल्क $date मा लाग्ने अपेक्षा छ।';
  }

  @override
  String get billing_trialTerms =>
      'उल्लेख गरिएको मूल्यमा स्वतः नवीकरण हुन्छ। शुल्कबाट बच्न परीक्षण सकिनुअघि Google Play मा रद्द गर्नुहोस्।';

  @override
  String billing_trialThenMonthly(String price) {
    return 'त्यसपछि प्रति महिना $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'त्यसपछि प्रति वर्ष $price';
  }

  @override
  String get billing_choosePeriod => 'आफ्नो योजना छान्नुहोस्';

  @override
  String get billing_selectionHint => 'जारी राख्न योजना चयन गर्नुहोस्।';

  @override
  String get billing_benefitConnection => 'एन्क्रिप्ट गरिएको जडान';

  @override
  String get billing_benefitPrivacy => 'अनलाइन गोपनीयता';

  @override
  String get billing_benefitNoAccount => 'दर्ता आवश्यक छैन';

  @override
  String get billing_cancellation => 'Google Play मा रद्द गर्नुहोस्';

  @override
  String get billing_premiumTitle => 'अझ राम्रोसँग सुरक्षित जडान।';

  @override
  String get billing_premiumSubtitle =>
      'आफ्नो गतिमा आफ्नो जडान सुरक्षित राख्नुहोस्।';

  @override
  String get billing_priceMonthly => 'प्रति महिना';

  @override
  String get billing_priceYearly => 'प्रति वर्ष';

  @override
  String get billing_trialToday => 'आज तिर्नुपर्ने केही छैन';

  @override
  String get billing_trialConfirmation =>
      'तपाईंले पुष्टि गर्नुअघि Google Play ले मितिहरू, अन्तिम रकम र लागू हुने करहरू पुष्टि गर्छ।';

  @override
  String get billing_offerChanged =>
      'यो प्रस्तावका सर्तहरू परिवर्तन भएका छन्। योजनाहरू ताजा गरेर फेरि छान्नुहोस्।';

  @override
  String get status_waitingNetwork => 'नेटवर्कको प्रतीक्षा गर्दै';

  @override
  String get status_waitingNetworkDetail =>
      'कुनै नेटवर्क उपलब्ध छैन। नेटवर्क फर्केपछि VPN ले जडान प्रमाणित गर्नेछ।';

  @override
  String get locations_favoriteLoadFailed =>
      'मनपर्ने सूची लोड गर्न सकिएन। फेरि प्रयास गर्नुहोस्।';

  @override
  String get locations_favoritesLoading => 'मनपर्ने सूची लोड हुँदैछ…';
}
