// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get vpnDisclosure_title => 'तुमचे कनेक्शन सुरक्षित करा';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN Android च्या VPN सेवेचा (VpnService) वापर करून हे डिव्हाइस आणि FuzeVPN सर्व्हर यांच्यामध्ये एक एन्क्रिप्टेड टनेल तयार करते.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN सक्रिय असताना, तुमच्या ॲप्सचा इंटरनेट ट्रॅफिक, गंतव्य पत्ते आणि DNS विनंत्या तुमचे कनेक्शन राउट करण्यासाठी या टनेलमधून जातात, FuzeVPN पार्श्वभूमीमध्ये असतानाही.';

  @override
  String get vpnDisclosure_statusBody =>
      'हे ॲप तुमचे VPN कनेक्शन दाखवण्यासाठी कनेक्शनची स्थिती, त्याचा कालावधी आणि हस्तांतरित केलेल्या डेटाचे प्रमाण वापरते. तुम्ही ते कधीही थांबवू शकता.';

  @override
  String get vpnDisclosure_privacy => 'गोपनीयता';

  @override
  String get vpnDisclosure_accept => 'स्वीकारा आणि सुरू ठेवा';

  @override
  String get vpnDisclosure_decline => 'आत्ता नको';

  @override
  String get accountRestoration_title => 'खाते तात्पुरते उपलब्ध नाही';

  @override
  String get accountRestoration_message =>
      'तुमचे सत्र जतन केले आहे. तुमचे खाते पुनर्संचयित करण्यासाठी पुन्हा प्रयत्न करा. तरीही तुम्ही येथे VPN कनेक्शन व्यवस्थापित करू शकता.';

  @override
  String get action_retry => 'पुन्हा प्रयत्न करा';

  @override
  String get session_endingTitle => 'सत्र समाप्त करत आहे';

  @override
  String get session_ending =>
      'सत्र समाप्त करत आहे: VPN थांबवत आहे आणि साफसफाई करत आहे…';

  @override
  String get session_stopFailed =>
      'VPN बंद झाल्याची पुष्टी झालेली नाही. पुन्हा साइन इन करण्यापूर्वी बंद करण्याचा पुन्हा प्रयत्न करा.';

  @override
  String get session_cleanupFailed =>
      'VPN थांबवले आहे, पण सत्र काढून टाकल्याची पुष्टी झालेली नाही. साफसफाईसाठी पुन्हा प्रयत्न करा.';

  @override
  String get session_retryStop => 'पुन्हा बंद करा';

  @override
  String get session_retryCleanup => 'पुन्हा साफसफाई करा';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN सुरक्षितपणे तयार होत आहे…';

  @override
  String get nav_connection => 'कनेक्शन';

  @override
  String get nav_locations => 'स्थाने';

  @override
  String get nav_account => 'खाते';

  @override
  String get nav_devices => 'डिव्हाइस';

  @override
  String get nav_settings => 'सेटिंग्ज';

  @override
  String get action_refresh => 'रीफ्रेश करा';

  @override
  String get auth_tab_login => 'साइन इन करा';

  @override
  String get auth_tab_register => 'साइन अप करा';

  @override
  String get auth_stepAccount => 'खाते';

  @override
  String get auth_stepIdentity => 'ओळख';

  @override
  String get auth_stepAddress => 'पत्ता आणि करार';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$total पैकी पायरी $current';
  }

  @override
  String get auth_tagline => 'तुमचे VPN, अगदी सोपे.';

  @override
  String get auth_keysLocal => 'तुमच्या खासगी VPN कीज या डिव्हाइसवरच राहतात.';

  @override
  String get form_email => 'ईमेल पत्ता';

  @override
  String get form_password => 'पासवर्ड';

  @override
  String get form_showPassword => 'पासवर्ड दाखवा';

  @override
  String get form_hidePassword => 'पासवर्ड लपवा';

  @override
  String get form_passwordMin =>
      '8 ते 72 UTF-8 बाइट्स. काही अक्षरांना एकापेक्षा जास्त बाइट लागतात.';

  @override
  String get form_firstName => 'पहिले नाव';

  @override
  String get form_lastName => 'आडनाव';

  @override
  String get form_phone => 'फोन (+33612345678)';

  @override
  String get form_address => 'पत्ता';

  @override
  String get form_address2 => 'पत्त्याची दुसरी ओळ (ऐच्छिक)';

  @override
  String get form_postalCode => 'पोस्टल कोड';

  @override
  String get form_city => 'शहर';

  @override
  String get form_country => 'देश कोड (उदा. FR)';

  @override
  String get action_login => 'साइन इन करा';

  @override
  String get action_createAccount => 'खाते तयार करा';

  @override
  String get action_createMyAccount => 'माझे खाते तयार करा';

  @override
  String get action_next => 'सुरू ठेवा';

  @override
  String get action_previous => 'मागे';

  @override
  String get action_forgotPassword => 'पासवर्ड विसरलात?';

  @override
  String get auth_noAccount => 'अजून खाते नाही?';

  @override
  String get auth_requiredInformation =>
      'तीन पायऱ्यांमध्ये तुमचे खाते तयार करा.';

  @override
  String get auth_termsPrefix => 'मी ';

  @override
  String get auth_termsLink => 'वापराच्या अटींशी सहमत आहे';

  @override
  String get auth_privacyPrefix => 'मी ';

  @override
  String get auth_privacyLink => 'गोपनीयता धोरणाशी सहमत आहे';

  @override
  String get auth_consentRequired =>
      'खाते तयार करण्यासाठी तुमची संमती आवश्यक आहे.';

  @override
  String get validation_required => 'हे फील्ड भरणे आवश्यक आहे.';

  @override
  String get validation_email => 'योग्य ईमेल पत्ता प्रविष्ट करा.';

  @override
  String get validation_password =>
      'पासवर्ड खूप लहान आहे: किमान 8 UTF-8 बाइट्स आवश्यक आहेत.';

  @override
  String get validation_passwordTooLong =>
      'पासवर्ड खूप मोठा आहे: जास्तीत जास्त 72 UTF-8 बाइट्स असू शकतात.';

  @override
  String get validation_phone =>
      'आंतरराष्ट्रीय स्वरूप वापरा, उदाहरणार्थ +33612345678.';

  @override
  String get validation_country => 'दोन अक्षरी देश कोड वापरा, उदाहरणार्थ FR.';

  @override
  String get passwordReset_title => 'पासवर्ड रीसेट करा';

  @override
  String get passwordReset_description =>
      'पासवर्ड रीसेट लिंकची विनंती करण्यासाठी तुमच्या खात्याचा ईमेल पत्ता प्रविष्ट करा.';

  @override
  String get passwordReset_send => 'लिंक पाठवा';

  @override
  String get connection_title => 'तुमचे कनेक्शन';

  @override
  String get connection_subtitle => 'स्थान निवडा, नंतर तुमचे VPN सुरू करा.';

  @override
  String get connection_prepare => 'कनेक्ट करण्यास तयार आहात?';

  @override
  String get connection_advancedOptions => 'प्रगत पर्याय';

  @override
  String get connection_location => 'स्थान';

  @override
  String get connection_chooseLocation => 'स्थान निवडा';

  @override
  String get connection_protocol => 'प्रोटोकॉल';

  @override
  String get connection_connect => 'कनेक्ट करा';

  @override
  String get connection_connecting => 'कनेक्ट होत आहे…';

  @override
  String get connection_disconnect => 'डिस्कनेक्ट करा';

  @override
  String get connection_disconnecting => 'डिस्कनेक्ट होत आहे';

  @override
  String get connection_locationChange => 'स्थान बदलत आहे…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol उपलब्ध नाही';
  }

  @override
  String get connection_activeLocation => 'सक्रिय स्थान';

  @override
  String get connection_duration => 'कालावधी';

  @override
  String get connection_received => 'प्राप्त झाले';

  @override
  String get connection_sent => 'पाठवले';

  @override
  String get connection_lastHandshake => 'शेवटची सुरक्षित देवाणघेवाण';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration पूर्वी';
  }

  @override
  String get verification_title => 'तुमच्या ईमेल पत्त्याची पुष्टी करा';

  @override
  String get verification_message =>
      'या फोनवर VPN वापरण्यासाठी तुमच्या ईमेल पत्त्याची पुष्टी करा.';

  @override
  String get verification_resend => 'ईमेल पुन्हा पाठवा';

  @override
  String get migration_title => 'स्थान बदल';

  @override
  String get migration_draining => 'स्थान बदलाची तयारी सुरू आहे…';

  @override
  String get migration_activating => 'नवीन सर्व्हर सक्रिय करत आहे…';

  @override
  String get migration_ready => 'स्थान अपडेट केले.';

  @override
  String get migration_blocked =>
      'स्थान बदलासाठी सर्व्हरचा हस्तक्षेप आवश्यक आहे. नंतर पुन्हा प्रयत्न करा किंवा सपोर्टशी संपर्क साधा.';

  @override
  String get migration_progress => 'स्थान बदलाची प्रगती';

  @override
  String migration_retryDelay(Object seconds) {
    return 'तपासण्यांमधील विलंब: $seconds सेकंद.';
  }

  @override
  String get migration_resume => 'स्थान बदल पुन्हा सुरू करा';

  @override
  String get status_authorizing => 'परवानगी आवश्यक आहे';

  @override
  String get status_authorizingDetail =>
      'VPN ला परवानगी देण्यासाठी Android ची विनंती स्वीकारा.';

  @override
  String get status_preparing => 'तयारी सुरू आहे';

  @override
  String get status_preparingDetail => 'तुमचे सुरक्षित कनेक्शन तयार होत आहे.';

  @override
  String get status_reconnecting => 'पुन्हा कनेक्ट होत आहे…';

  @override
  String get status_reconnectingDetail =>
      'कनेक्शन खंडित झाले. VPN पुन्हा कनेक्ट होण्याचा प्रयत्न करत आहे.';

  @override
  String get status_connecting => 'कनेक्ट होत आहे';

  @override
  String get status_connectingDetail => 'VPN सर्व्हरशी कनेक्ट होत आहे…';

  @override
  String get status_connected => 'कनेक्ट झाले';

  @override
  String get status_connectedDetail => 'तुमचे VPN कनेक्शन सक्रिय आहे.';

  @override
  String get status_disconnecting => 'डिस्कनेक्ट होत आहे';

  @override
  String get status_disconnectingDetail => 'तुमचे VPN कनेक्शन थांबत आहे.';

  @override
  String get status_error => 'कनेक्शन उपलब्ध नाही';

  @override
  String get status_errorDetail =>
      'VPN कनेक्शनची पुष्टी झालेली नाही. पुन्हा प्रयत्न करा.';

  @override
  String get status_idle => 'डिस्कनेक्ट झाले';

  @override
  String get status_idleDetail =>
      'तुमच्या कनेक्शनचे संरक्षण करण्यासाठी VPN कनेक्ट करा.';

  @override
  String get trust_note =>
      'ॲप बंद केल्याने VPN थांबत नाही. ते थांबवण्यासाठी “डिस्कनेक्ट करा” वापरा.';

  @override
  String get locations_none => 'सध्या कोणतीही स्थाने उपलब्ध नाहीत.';

  @override
  String get locations_available => 'तुमचे पुढील स्थान निवडा.';

  @override
  String get locations_selected => 'निवडलेले स्थान';

  @override
  String get locations_select => 'हे स्थान निवडा';

  @override
  String get locations_lockedTunnel => 'स्थान बदलण्यासाठी VPN डिस्कनेक्ट करा.';

  @override
  String get locations_lockedMigration => 'स्थान बदल पूर्ण होईपर्यंत थांबा.';

  @override
  String get devices_title => 'तुमची डिव्हाइस';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit डिव्हाइस';
  }

  @override
  String get devices_refresh => 'डिव्हाइस रीफ्रेश करा';

  @override
  String get devices_empty => 'अजून कोणतेही VPN डिव्हाइस नोंदणीकृत नाही.';

  @override
  String get devices_firstConnection =>
      'पहिल्या कनेक्शनवेळी तुमचा फोन जोडला जाईल.';

  @override
  String get devices_thisDevice => 'हे डिव्हाइस';

  @override
  String devices_added(Object date) {
    return '$date रोजी जोडले';
  }

  @override
  String get devices_unnamed => 'नाव नसलेले डिव्हाइस';

  @override
  String get action_remove => 'काढून टाका';

  @override
  String get settings_title => 'सेटिंग्ज';

  @override
  String get settings_subtitle =>
      'तुमची प्राधान्ये आणि खाते, सर्व एकाच ठिकाणी.';

  @override
  String get settings_appearance => 'स्वरूप';

  @override
  String get settings_language => 'भाषा';

  @override
  String get settings_languageDescription =>
      'तुम्ही निवडलेली भाषा VPN सूचनांनाही लागू होते.';

  @override
  String get settings_account => 'खाते';

  @override
  String get settings_signOut => 'साइन आउट करा';

  @override
  String get settings_privacy => 'गोपनीयता धोरण';

  @override
  String get settings_terms => 'वापराच्या अटी';

  @override
  String get settings_security => 'सुरक्षा आणि पारदर्शकता';

  @override
  String get settings_licenses => 'घटकांचे परवाने';

  @override
  String get settings_licensesDetail => 'ॲपमध्ये वापरलेले सॉफ्टवेअर';

  @override
  String settings_licensesLegalese(String url) {
    return 'ॲप आणि त्याच्या MPL-2.0 घटकांचा सोर्स कोड: $url';
  }

  @override
  String get settings_background =>
      'तुम्ही ॲप सोडल्यावरही VPN सुरू राहते. ते थांबवण्यासाठी कनेक्शन टॅबवरील “डिस्कनेक्ट करा” वापरा.';

  @override
  String get theme_system => 'सिस्टम';

  @override
  String get theme_light => 'लाइट';

  @override
  String get theme_dark => 'डार्क';

  @override
  String get language_system => 'फोनची भाषा';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'हे डिव्हाइस काढायचे का?';

  @override
  String get dialog_removeCurrent =>
      'हा फोन VPN वरून डिस्कनेक्ट होईल आणि त्याचा प्रवेश बंद होईल. सर्व्हरने पुष्टी केल्यानंतर त्याचा VPN कनेक्शन डेटा काढून टाकला जाईल.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” साठीचा VPN प्रवेश रद्द केला जाईल. ही कृती पूर्ववत करता येणार नाही.';
  }

  @override
  String get dialog_signOut => 'साइन आउट करायचे का?';

  @override
  String get dialog_signOutMessage =>
      'VPN थांबेल आणि तुम्हाला पुन्हा साइन इन करावे लागेल. तुमच्या एन्क्रिप्टेड VPN कीज पुढील कनेक्शनसाठी या फोनवरच राहतील.';

  @override
  String get action_cancel => 'रद्द करा';

  @override
  String get action_close => 'बंद करा';

  @override
  String get action_copy => 'कॉपी करा';

  @override
  String get action_renew => 'नूतनीकरण करा';

  @override
  String get action_signOut => 'साइन आउट करा';

  @override
  String get notice_close => 'संदेश बंद करा';

  @override
  String get notice_sessionExpired_title => 'सत्र कालबाह्य झाले';

  @override
  String get notice_sessionExpired_message =>
      'तुमचे सत्र कालबाह्य झाले आहे. पुन्हा साइन इन करा.';

  @override
  String get notice_connectionFailed_title => 'कनेक्शन अयशस्वी';

  @override
  String get notice_invalidCredentials_message =>
      'ईमेल पत्ता किंवा पासवर्ड चुकीचा आहे.';

  @override
  String get notice_emailVerification_title => 'ईमेलची पुष्टी आवश्यक आहे';

  @override
  String get notice_emailVerification_message =>
      'VPN डिव्हाइस जोडण्यापूर्वी तुमच्या ईमेल पत्त्याची पुष्टी करा.';

  @override
  String get notice_rateLimited_title => 'खूप जास्त प्रयत्न झाले';

  @override
  String get notice_deviceLimit_title => 'डिव्हाइसची मर्यादा गाठली';

  @override
  String get notice_deviceLimit_message =>
      'दुसरे डिव्हाइस जोडण्यापूर्वी सध्याचे एखादे डिव्हाइस काढा.';

  @override
  String get notice_identityRenewal_title => 'VPN ओळखीचे नूतनीकरण आवश्यक आहे';

  @override
  String get notice_identityRenewal_message =>
      'ही ओळख काढून टाकली गेली आहे. नवीन स्थानिक ओळख तयार करा.';

  @override
  String get notice_migrationPending_title => 'स्थान बदल सुरू आहे';

  @override
  String get notice_migrationPending_message => 'स्थान बदल आधीच सुरू आहे.';

  @override
  String get notice_migrationBlocked_title => 'स्थान बदल ब्लॉक झाला';

  @override
  String get notice_migrationBlocked_message =>
      'स्थान बदलासाठी सर्व्हरचा हस्तक्षेप आवश्यक आहे. नंतर पुन्हा प्रयत्न करा किंवा सपोर्टशी संपर्क साधा.';

  @override
  String get notice_targetUnavailable_title => 'सर्व्हर तात्पुरता उपलब्ध नाही';

  @override
  String get notice_targetUnavailable_message =>
      'हा सर्व्हर तात्पुरता उपलब्ध नाही.';

  @override
  String get notice_networkUnavailable_title => 'इंटरनेट कनेक्शन उपलब्ध नाही';

  @override
  String get notice_networkUnavailable_message =>
      'तुमचे कनेक्शन तपासा आणि पुन्हा प्रयत्न करा.';

  @override
  String get notice_permissionDenied_title => 'VPN परवानगी नाकारली';

  @override
  String get notice_permissionDenied_message =>
      'कनेक्शन पुन्हा सुरू करा आणि Android परवानगीची विनंती स्वीकारा.';

  @override
  String get notice_wireguardTimeout_title => 'सर्व्हर प्रतिसाद देत नाही';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard कनेक्शनला खूप वेळ लागला. पुन्हा प्रयत्न करा किंवा दुसरे स्थान निवडा.';

  @override
  String get notice_tlsFailed_title => 'सुरक्षित कनेक्शन नाकारले';

  @override
  String get notice_tlsFailed_message =>
      'सर्व्हरने OpenVPN कनेक्शन स्वीकारले नाही. पुन्हा प्रयत्न करा. समस्या कायम राहिल्यास निदान चालवा.';

  @override
  String get notice_tunRejected_title => 'Android ने VPN इंटरफेस नाकारला';

  @override
  String get notice_tunRejected_message =>
      'OpenVPN ने मागितलेले नेटवर्क कॉन्फिगरेशन Android ने नाकारले.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN सुरू होऊ शकले नाही';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN इंजिन पूर्णपणे सुरू होऊ शकले नाही. पुन्हा प्रयत्न करा. समस्या कायम राहिल्यास सपोर्टशी संपर्क साधा.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'निदान कोड: $code';
  }

  @override
  String get notice_generic_title => 'VPN कनेक्शन अयशस्वी';

  @override
  String get notice_generic_message =>
      'एक त्रुटी आली. नंतर पुन्हा प्रयत्न करा.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'खाते तयार झाले',
      'password_reset_sent': 'पासवर्ड रीसेट विनंती मिळाली',
      'verification_email_sent': 'पडताळणी ईमेल पाठवला',
      'location_migration_pending': 'स्थान बदल सुरू आहे',
      'vpn_sign_in_required': 'साइन इन आवश्यक आहे',
      'protocol_unavailable_at_location': 'प्रोटोकॉल उपलब्ध नाही',
      'vpn_permission_denied': 'VPN परवानगी नाकारली',
      'revoked_identity_device_limit': 'डिव्हाइसची मर्यादा गाठली',
      'tunnel_start_unexpected': 'VPN सुरू होऊ शकले नाही',
      'flutter_disconnect_timeout': 'डिस्कनेक्शनची पुष्टी झालेली नाही',
      'flutter_disconnect_unexpected': 'डिस्कनेक्ट करता आले नाही',
      'device_revoked': 'डिव्हाइस काढले',
      'revoke_unexpected': 'डिव्हाइस काढता आले नाही',
      'identity_renewal_unexpected': 'ओळखीचे नूतनीकरण करता आले नाही',
      'openvpn_renewal_unexpected': 'OpenVPN चे नूतनीकरण करता आले नाही',
      'location_migration_blocked': 'स्थान बदल ब्लॉक झाला',
      'location_migration_slow': 'स्थान बदल अजूनही सुरू आहे',
      'location_migration_conflict': 'स्थान बदल रीफ्रेश करणे आवश्यक आहे',
      'location_migration_verification_failed':
          'स्थान बदलाची पुष्टी झालेली नाही',
      'location_migration_device_changed': 'स्थान बदलादरम्यान डिव्हाइस बदलले',
      'tunnel_stop_failed': 'स्थान बदल उपलब्ध नाही',
      'device_clock_ahead': 'डिव्हाइसचे घड्याळ पुढे आहे',
      'other': 'क्रिया अयशस्वी',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'खाते तयार झाले, पण पडताळणी ईमेल पाठवता आला नाही. ॲपमधील “ईमेल पुन्हा पाठवा” वापरा.',
      'password_reset_sent':
          'तुमची विनंती मिळाली आहे. या पत्त्याशी जुळणारे खाते असल्यास तुम्हाला ईमेल मिळू शकतो. कृपया तुमचे स्पॅम फोल्डर देखील तपासा.',
      'verification_email_sent': 'नवीन पडताळणी ईमेल आत्ताच पाठवला आहे.',
      'location_migration_pending':
          '$target साठीच्या स्थान बदलाची तयारी अजूनही सुरू आहे. डिव्हाइस पुन्हा तयार न करता तुम्ही ते पुन्हा सुरू करू शकता.',
      'vpn_sign_in_required':
          'VPN सुरू करण्यापूर्वी तुमच्या खात्यात साइन इन करा.',
      'protocol_unavailable_at_location':
          'निवडलेला प्रोटोकॉल या स्थानावर उपलब्ध नाही. स्थाने रीफ्रेश करा किंवा दुसरा प्रोटोकॉल निवडा.',
      'vpn_permission_denied':
          'Android ने VPN परवानगी नाकारली. कनेक्शन पुन्हा सुरू करा आणि सिस्टमची विनंती स्वीकारा.',
      'revoked_identity_device_limit':
          'या डिव्हाइसचा VPN प्रवेश काढून टाकला गेला आहे आणि डिव्हाइस मर्यादा गाठली आहे. खाते → माझी डिव्हाइस व्यवस्थापित करा येथून एक डिव्हाइस काढून टाका.',
      'tunnel_start_unexpected':
          'अनपेक्षित त्रुटीमुळे टनेल तयार करणे खंडित झाले. निदान कोड तपासा आणि पुन्हा प्रयत्न करा.',
      'flutter_disconnect_timeout':
          'VPN वेळेत थांबल्याची Android ने पुष्टी केली नाही. ते पुन्हा थांबवण्याचा प्रयत्न करा.',
      'flutter_disconnect_unexpected':
          'अनपेक्षित त्रुटीमुळे टनेल थांबल्याची पुष्टी होऊ शकली नाही.',
      'device_revoked':
          'डिव्हाइसचा VPN प्रवेश रद्द करण्यात आला आहे आणि त्याची स्थानिक गुप्त माहिती काढून टाकली आहे.',
      'revoke_unexpected':
          'डिव्हाइस काढता आले नाही. यादी रीफ्रेश करा आणि पुन्हा प्रयत्न करा.',
      'identity_renewal_unexpected':
          'नवीन VPN ओळख तयार करता आली नाही. डिव्हाइस रीफ्रेश करा आणि पुन्हा प्रयत्न करा.',
      'openvpn_renewal_unexpected':
          'OpenVPN प्रोफाइलचे नूतनीकरण करता आले नाही. पुन्हा प्रयत्न करा किंवा निदान कोड तपासा.',
      'location_migration_blocked':
          'सर्व्हर आत्ता हा बदल पूर्ण करू शकत नाही. डिव्हाइस आणि त्याची स्थानिक ओळख जतन केली आहे.',
      'location_migration_slow':
          'सर्व्हर अजूनही $target साठीचा बदल तयार करत आहे. काही क्षणांनी “पुन्हा सुरू करा” वापरा.',
      'location_migration_conflict':
          'सर्व्हरवर डिव्हाइसची स्थिती बदलली आहे. डिव्हाइस रीफ्रेश करा, नंतर बदल पुन्हा सुरू करा.',
      'location_migration_verification_failed':
          'सर्व्हरने नवीन स्थानाची पुष्टी केली नाही. आधीची स्थानिक ओळख जतन केली आहे.',
      'location_migration_device_changed':
          'सर्व्हरने परत दिलेले डिव्हाइस बदलले जात असलेल्या डिव्हाइसशी जुळत नाही. पुन्हा प्रयत्न करण्यापूर्वी डिव्हाइस रीफ्रेश करा.',
      'tunnel_stop_failed':
          'नवीन कनेक्शनपूर्वी आधीचा टनेल पूर्णपणे थांबवणे आवश्यक आहे.',
      'device_clock_ahead':
          'या डिव्हाइसचे घड्याळ पुढे असल्याचे दिसते. साइन इन राहण्यासाठी स्वयंचलित तारीख आणि वेळ चालू करा.',
      'other':
          'ही क्रिया पूर्ण होऊ शकली नाही. पुन्हा प्रयत्न करा किंवा निदान कोड सपोर्टला पाठवा.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'सत्र कालबाह्य झाले',
      'invalid_credentials': 'साइन इन अयशस्वी',
      'email_verification_required': 'ईमेलची पुष्टी आवश्यक आहे',
      'verification_email_cooldown': 'ईमेल आधीच पाठवला आहे',
      'rate_limited': 'खूप जास्त प्रयत्न झाले',
      'invalid_registration': 'माहिती दुरुस्त करणे आवश्यक आहे',
      'email_exists': 'खाते आधीपासून अस्तित्वात आहे',
      'invalid_profile': 'अवैध प्रोफाइल',
      'invalid_device': 'अवैध डिव्हाइस',
      'invalid_location': 'स्थान उपलब्ध नाही',
      'device_limit': 'डिव्हाइसची मर्यादा गाठली',
      'device_exists': 'VPN ओळख आधीपासून वापरात आहे',
      'device_identity_revoked': 'VPN ओळखीचे नूतनीकरण आवश्यक आहे',
      'device_location_locked': 'स्थान बदल रीफ्रेश करणे आवश्यक आहे',
      'location_migration_pending': 'स्थान बदल सुरू आहे',
      'location_migration_blocked': 'स्थान बदल ब्लॉक झाला',
      'target_ca_mismatch': 'विसंगत OpenVPN सर्व्हर',
      'location_migration_conflict': 'स्थान बदल रीफ्रेश करणे आवश्यक आहे',
      'server_full': 'सर्व्हर भरला आहे',
      'capacity_unavailable': 'स्थान तात्पुरते उपलब्ध नाही',
      'target_unavailable': 'सर्व्हर तात्पुरता उपलब्ध नाही',
      'not_found': 'आयटम सापडला नाही',
      'invalid_openvpn_csr': 'अवैध OpenVPN ओळख',
      'openvpn_profile_exists': 'OpenVPN प्रोफाइल आधीपासून अस्तित्वात आहे',
      'openvpn_profile_revoked': 'OpenVPN प्रोफाइल रद्द केले',
      'openvpn_operation_pending': 'OpenVPN क्रिया सुरू आहे',
      'openvpn_operation_terminal': 'OpenVPN क्रिया खंडित झाली',
      'openvpn_address_unavailable': 'OpenVPN पत्ता उपलब्ध नाही',
      'openvpn_profile_conflict': 'OpenVPN मध्ये विसंगती',
      'openvpn_signer_unavailable': 'OpenVPN उपलब्ध नाही',
      'email_delivery_unavailable': 'ईमेल पाठवता येत नाही',
      'invalid_token': 'अवैध लिंक',
      'network_unavailable': 'इंटरनेट कनेक्शन उपलब्ध नाही',
      'invalid_json': 'अवैध विनंती',
      'invalid_api_response': 'सर्व्हरचा प्रतिसाद अवैध आहे',
      'ipv6_unavailable': 'IPv6 उपलब्ध नाही',
      'invalid_ip_families': 'नेटवर्क कॉन्फिगरेशन नाकारले',
      'other': 'सेवा उपलब्ध नाही',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'तुमचे सत्र कालबाह्य झाले आहे. पुन्हा साइन इन करा.',
      'invalid_credentials': 'ईमेल पत्ता किंवा पासवर्ड चुकीचा आहे.',
      'email_verification_required':
          'VPN डिव्हाइस जोडण्यापूर्वी तुमच्या ईमेल पत्त्याची पुष्टी करा.',
      'invalid_registration': 'विनंती केलेली माहिती आणि संमती तपासा.',
      'email_exists': 'हा ईमेल पत्ता आधीच एका खात्यासाठी वापरला जात आहे.',
      'invalid_profile': 'तुमची प्रोफाइल माहिती तपासा.',
      'invalid_device': 'या डिव्हाइसचे नाव किंवा स्थानिक ओळख अवैध आहे.',
      'invalid_location': 'स्थानांची यादी रीफ्रेश करून पुन्हा प्रयत्न करा.',
      'device_limit':
          'दुसरे डिव्हाइस जोडण्यापूर्वी सध्याचे एखादे डिव्हाइस काढा.',
      'device_exists': 'ही VPN ओळख आधीच दुसऱ्या खात्याशी जोडलेली आहे.',
      'device_identity_revoked':
          'ही ओळख काढून टाकली आहे. नवीन स्थानिक ओळख तयार करणे आवश्यक आहे.',
      'device_location_locked':
          'या डिव्हाइसचे स्थान नुकतेच बदलले आहे. ॲप सुरू असलेला बदल पुन्हा सुरू करेल.',
      'location_migration_pending': 'स्थान बदल आधीपासून सुरू आहे.',
      'location_migration_blocked':
          'स्थान बदलासाठी सर्व्हरचा हस्तक्षेप आवश्यक आहे. नंतर पुन्हा प्रयत्न करा किंवा सपोर्टशी संपर्क साधा.',
      'target_ca_mismatch':
          'हा सर्व्हर सध्याच्या OpenVPN प्रोफाइलशी अजून सुसंगत नाही.',
      'location_migration_conflict':
          'डिव्हाइस रीफ्रेश करा, नंतर स्थान बदल पुन्हा करून पहा.',
      'server_full':
          'या स्थानावरील कनेक्शनची मर्यादा गाठली आहे. दुसरे स्थान निवडा किंवा नंतर पुन्हा प्रयत्न करा.',
      'capacity_unavailable':
          'हे स्थान सध्या उपलब्ध आहे की नाही याची खात्री करता येत नाही. दुसरे स्थान निवडा किंवा नंतर पुन्हा प्रयत्न करा.',
      'target_unavailable': 'हा सर्व्हर तात्पुरता उपलब्ध नाही.',
      'not_found': 'हा आयटम आता तुमच्या खात्यावर उपलब्ध नाही.',
      'invalid_openvpn_csr':
          'नवीन OpenVPN ओळख तयार करा आणि पुन्हा प्रयत्न करा.',
      'openvpn_profile_exists':
          'या डिव्हाइससाठी OpenVPN प्रोफाइल आधीपासून अस्तित्वात आहे.',
      'openvpn_profile_revoked':
          'सुरू ठेवण्यासाठी OpenVPN प्रोफाइलचे नूतनीकरण करा.',
      'openvpn_operation_pending':
          'बदल अजून लागू होत आहे. नंतर पुन्हा प्रयत्न करा.',
      'openvpn_operation_terminal':
          'नवीन OpenVPN ओळख तयार करा आणि पुन्हा प्रयत्न करा.',
      'openvpn_address_unavailable': 'सध्या कोणताही OpenVPN पत्ता उपलब्ध नाही.',
      'openvpn_profile_conflict':
          'प्रोफाइल बदलले आहे. डिव्हाइस रीफ्रेश करून पुन्हा प्रयत्न करा.',
      'openvpn_signer_unavailable': 'OpenVPN सेवा तात्पुरती उपलब्ध नाही.',
      'email_delivery_unavailable':
          'ईमेल पाठवता आला नाही. नंतर पुन्हा प्रयत्न करा.',
      'invalid_token':
          'ही लिंक अवैध आहे किंवा तिची मुदत संपली आहे. नवीन लिंकची विनंती करा.',
      'network_unavailable':
          'तुमचे इंटरनेट कनेक्शन तपासा आणि पुन्हा प्रयत्न करा.',
      'invalid_json': 'प्रविष्ट केलेली माहिती तपासा आणि पुन्हा प्रयत्न करा.',
      'invalid_api_response':
          'सर्व्हरने अपेक्षित नसलेला प्रतिसाद दिला. नंतर पुन्हा प्रयत्न करा.',
      'ipv6_unavailable':
          'सर्व्हर सध्या IPv6 सक्रिय करू शकत नाही. नंतर पुन्हा प्रयत्न करा.',
      'invalid_ip_families':
          'टनेल कॉन्फिगरेशन अपूर्ण आहे किंवा अधिकृत पत्त्यांशी जुळत नाही. ॲपमधून पुन्हा प्रयत्न करा.',
      'other': 'सर्व्हरमध्ये त्रुटी आली. नंतर पुन्हा प्रयत्न करा.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'काही क्षणांनी पुन्हा प्रयत्न करा.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds सेकंदांत पुन्हा प्रयत्न करा.',
      one: '$seconds सेकंदात पुन्हा प्रयत्न करा.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes मिनिटांत पुन्हा प्रयत्न करा.',
      one: '$minutes मिनिटात पुन्हा प्रयत्न करा.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours तासांत पुन्हा प्रयत्न करा.',
      one: '$hours तासात पुन्हा प्रयत्न करा.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'सिस्टम VPN पुन्हा सुरू करणे उपलब्ध नाही',
      'system_vpn_resume_corrupt':
          'अवैध सिस्टम VPN पुन्हा सुरू करण्याची माहिती',
      'system_vpn_resume_session_invalid': 'अवैध VPN पुन्हा सुरू करण्याचे सत्र',
      'system_vpn_resume_identity_changed': 'VPN ओळख बदलली',
      'system_vpn_resume_identity_invalid': 'अवैध VPN पुन्हा सुरू करण्याची ओळख',
      'system_vpn_resume_storage_failed':
          'VPN पुन्हा सुरू करण्यासाठीचे स्टोरेज उपलब्ध नाही',
      'system_vpn_resume_network_timeout':
          'VPN पुन्हा सुरू करण्यासाठी नेटवर्क नाही',
      'system_vpn_resume_blocked': 'VPN पुन्हा सुरू करणे ब्लॉक केले आहे',
      'system_vpn_resume_failed': 'VPN पुन्हा सुरू करणे अयशस्वी झाले',
      'system_vpn_resume_error_invalid': 'अवैध VPN पुन्हा सुरू करण्याची त्रुटी',
      'wireguard_identity_store_failed': 'WireGuard ओळख जतन झाली नाही',
      'wireguard_identity_unavailable': 'WireGuard ओळख उपलब्ध नाही',
      'vpn_host_destroyed': 'Android VPN होस्ट थांबला',
      'vpn_host_unavailable': 'Android VPN होस्ट उपलब्ध नाही',
      'vpn_permission_required': 'VPN परवानगी आवश्यक आहे',
      'vpn_permission_denied': 'VPN परवानगी नाकारली',
      'vpn_permission_request_failed': 'परवानगीची विनंती करता आली नाही',
      'wireguard_foreground_service_unavailable': 'WireGuard सेवा उपलब्ध नाही',
      'wireguard_identity_invalid': 'अवैध स्थानिक WireGuard की',
      'wireguard_identity_in_use': 'WireGuard ओळख आधीच वापरात आहे',
      'wireguard_configuration_invalid': 'अवैध WireGuard कॉन्फिगरेशन',
      'wireguard_operation_pending': 'WireGuard क्रिया अजूनही सक्रिय आहे',
      'wireguard_start_failed': 'WireGuard सुरू होणे नाकारले',
      'wireguard_stop_timeout': 'WireGuard थांबण्याची पुष्टी झाली नाही',
      'wireguard_handshake_timeout': 'WireGuard कडून प्रतिसाद मिळाला नाही',
      'openvpn_connection_timeout': 'OpenVPN कडून प्रतिसाद मिळाला नाही',
      'openvpn_core_unavailable': 'OpenVPN इंजिन उपलब्ध नाही',
      'openvpn_operation_pending': 'OpenVPN सत्र अजूनही सक्रिय आहे',
      'openvpn_stop_timeout': 'OpenVPN थांबण्याची पुष्टी झाली नाही',
      'openvpn_profile_unavailable': 'स्थानिक OpenVPN प्रोफाइल सापडत नाही',
      'openvpn_native_failed': 'नेटिव्ह OpenVPN कॉलमध्ये व्यत्यय आला',
      'openvpn_key_generation_failed': 'OpenVPN P-256 की तयार करता आली नाही',
      'openvpn_csr_generation_failed': 'OpenVPN CSR तयार करता आला नाही',
      'openvpn_identity_store_failed': 'OpenVPN ओळख जतन झाली नाही',
      'openvpn_identity_clear_failed': 'OpenVPN ओळख काढणे अपूर्ण राहिले',
      'openvpn_identity_in_use': 'OpenVPN ओळख अजूनही वापरात आहे',
      'openvpn_tls_verification_required': 'OpenVPN TLS पडताळणी गहाळ आहे',
      'openvpn_cipher_invalid': 'अवैध OpenVPN एन्क्रिप्शन',
      'openvpn_profile_rejected': 'OpenVPN प्रोफाइल नाकारले गेले',
      'openvpn_identity_inconsistent': 'OpenVPN ओळख विसंगत आहे',
      'tls_handshake_failed': 'OpenVPN वाटाघाटी नाकारली',
      'tls_alert_unknown_ca': 'OpenVPN क्लायंट प्रमाणपत्र ओळखले गेले नाही',
      'tls_alert_bad_certificate': 'OpenVPN क्लायंट प्रमाणपत्र नाकारले',
      'tls_alert_unsupported_certificate': 'समर्थित नसलेले OpenVPN प्रमाणपत्र',
      'tls_client_certificate_required':
          'OpenVPN क्लायंट प्रमाणपत्र आवश्यक आहे',
      'tls_alert_misc': 'OpenVPN TLS अलर्ट',
      'tls_signature_algorithm_rejected': 'समर्थित नसलेली OpenVPN स्वाक्षरी',
      'tls_handshake_rejected': 'OpenVPN TLS वाटाघाटी नाकारली',
      'tls_version_rejected': 'विसंगत OpenVPN TLS आवृत्ती',
      'tls_certificate_expired': 'TLS प्रमाणपत्राची मुदत संपली',
      'tls_certificate_revoked': 'TLS प्रमाणपत्र रद्द केले आहे',
      'transport_failed': 'OpenVPN सर्व्हरपर्यंत पोहोचता येत नाही',
      'tun_configuration_rejected': 'OpenVPN इंटरफेस तयार करता आला नाही',
      'tun_setup_failed': 'OpenVPN TUN सेटअप अयशस्वी झाले',
      'tun_interface_create_failed': 'OpenVPN इंटरफेस तयार होणे अयशस्वी झाले',
      'tun_interface_disabled': 'OpenVPN इंटरफेस अक्षम केला आहे',
      'tun_halted': 'OpenVPN इंटरफेसमध्ये व्यत्यय आला',
      'tun_already_established': 'OpenVPN इंटरफेस आधीच उघडला आहे',
      'tun_addresses_missing': 'OpenVPN पत्ता गहाळ आहे',
      'tun_routes_missing': 'OpenVPN राउट्स गहाळ आहेत',
      'tun_dns_missing': 'OpenVPN DNS गहाळ आहे',
      'tun_permission_revoked': 'VPN परवानगी रद्द झाली',
      'tun_establish_returned_null': 'Android ने VPN इंटरफेस नाकारला',
      'openvpn_service_start_failed': 'OpenVPN सेवा उपलब्ध नाही',
      'openvpn_operation_timeout': 'OpenVPN कॉलची वेळ संपली',
      'openvpn_start_failed': 'OpenVPN सुरू होणे नाकारले',
      'openvpn_connection_failed': 'OpenVPN कनेक्शनमध्ये व्यत्यय आला',
      'openvpn_core_status_error': 'OpenVPN कोअर त्रुटीसह समाप्त झाले',
      'openvpn_stopped_before_connected': 'कनेक्ट होण्यापूर्वी OpenVPN थांबले',
      'openvpn_auth_failed': 'OpenVPN प्रमाणीकरण नाकारले',
      'openvpn_client_setup_failed': 'OpenVPN क्लायंट सेटअप अयशस्वी झाले',
      'openvpn_client_halted': 'OpenVPN क्लायंटमध्ये व्यत्यय आला',
      'openvpn_client_restart': 'OpenVPN पुन्हा सुरू करण्याची विनंती केली',
      'openvpn_inactive_timeout': 'OpenVPN बराच वेळ निष्क्रिय आहे',
      'openvpn_session_expired': 'OpenVPN सत्राची मुदत संपली',
      'openvpn_credentials_required': 'समर्थित नसलेले OpenVPN प्रमाणीकरण',
      'openvpn_proxy_failed': 'OpenVPN मध्यस्थ ट्रान्सपोर्ट अयशस्वी झाले',
      'openvpn_compression_failed': 'OpenVPN कॉम्प्रेशन नाकारले',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM एन्क्रिप्शन उपलब्ध नाही',
      'openvpn_feature_unsupported': 'समर्थित नसलेले OpenVPN वैशिष्ट्य',
      'network_unavailable': 'इंटरनेट कनेक्शन उपलब्ध नाही',
      'network_lost': 'नेटवर्क उपलब्ध नाही',
      'certificate_validation_failed': 'सर्व्हर प्रमाणपत्र नाकारले',
      'openvpn_certificate_expired': 'OpenVPN प्रमाणपत्राची मुदत संपली',
      'tunnel_active_for_another_account':
          'दुसऱ्या खात्याचा टनेल अजूनही सक्रिय आहे',
      'tunnel_already_active': 'नेटिव्ह टनेल आधीच सक्रिय आहे',
      'tunnel_stop_timeout': '$protocol थांबण्याची पुष्टी झाली नाही',
      'tunnel_disconnected': '$protocol मध्ये व्यत्यय आला',
      'native_bridge_unavailable': 'Android ब्रिज उपलब्ध नाही',
      'native_operation_failed': 'Android क्रियेमध्ये व्यत्यय आला',
      'invalid_arguments': 'अपूर्ण VPN पॅरामीटर्स',
      'invalid_account_id': 'अवैध VPN खाते',
      'invalid_device_id': 'अवैध डिव्हाइस ओळखकर्ता',
      'storage_key_not_allowed': 'स्टोरेज की नाकारली',
      'secure_storage_read_failed': 'सुरक्षित वाचन अयशस्वी झाले',
      'secure_storage_write_failed': 'सुरक्षित लेखन अयशस्वी झाले',
      'key_generation_failed': 'WireGuard की तयार करता आली नाही',
      'csr_generation_failed': 'OpenVPN CSR तयार करता आला नाही',
      'openvpn_recovery_exhausted': 'OpenVPN पुनर्प्राप्ती आधीच वापरली आहे',
      'openvpn_recovery_failed': 'OpenVPN पुनर्प्राप्ती अयशस्वी झाली',
      'openvpn_renewal_required': 'OpenVPN प्रमाणपत्राचे नूतनीकरण आवश्यक आहे',
      'other': 'वर्गीकृत न केलेली नेटिव्ह VPN त्रुटी',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ला पुन्हा सुरू करता येणारे VPN सत्र सापडत नाही. ॲपमध्ये नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_corrupt':
          'जतन केलेली VPN पुन्हा सुरू करण्याची माहिती अवैध आहे आणि ती वापरली जाणार नाही. नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_session_invalid':
          'जतन केलेले सत्र आता VPN पुन्हा सुरू करू शकत नाही. ॲपमध्ये पुन्हा साइन इन करा.',
      'system_vpn_resume_identity_changed':
          'स्थानिक VPN ओळख बदलली आहे. पुन्हा सुरू करणे थांबवले आहे. नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_identity_invalid':
          'पुन्हा सुरू करण्यासाठीची ओळख अवैध आहे. नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_storage_failed':
          'Android ला एन्क्रिप्ट केलेला पुन्हा सुरू करण्याचा डेटा वाचता किंवा अपडेट करता आला नाही. नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_network_timeout':
          'VPN पुन्हा सुरू करण्यासाठी Android ला वेळेत नेटवर्क सापडले नाही. नेटवर्क उपलब्ध असताना पुन्हा प्रयत्न करा.',
      'system_vpn_resume_blocked':
          'VPN पुन्हा सुरू करणे ब्लॉक केले आहे. Android सेटिंग्ज तपासा, नंतर नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_failed':
          'Android VPN पुन्हा सुरू करणे अयशस्वी झाले. ॲपमध्ये नवीन कनेक्शन सुरू करा.',
      'system_vpn_resume_error_invalid':
          'Android ने वापरता न येणारी पुन्हा सुरू करण्याची त्रुटी परत केली. नवीन कनेक्शन सुरू करा.',
      'wireguard_identity_store_failed':
          'Android ला या खात्याची एन्क्रिप्ट केलेली WireGuard ओळख जतन करता आली नाही.',
      'wireguard_identity_unavailable':
          'या कनेक्शनसाठी वापरता येण्याजोगी WireGuard ओळख उपलब्ध नाही.',
      'vpn_host_destroyed':
          'VPN होस्ट करणारा Android घटक थांबवला गेला. नवीन कनेक्शन सुरू करा.',
      'vpn_host_unavailable':
          'VPN होस्ट करणारा घटक Android तयार करू शकत नाही. VPN सेटिंग्ज तपासल्यानंतर पुन्हा प्रयत्न करा.',
      'openvpn_renewal_required':
          'OpenVPN प्रमाणपत्राचे आपोआप नूतनीकरण होऊ शकले नाही. ॲपमध्ये नवीन कनेक्शन सुरू करा.',
      'openvpn_recovery_failed':
          'स्वयंचलित पुनर्प्राप्ती अयशस्वी झाली. ॲपमध्ये नवीन कनेक्शन सुरू करा.',
      'openvpn_recovery_exhausted':
          'स्वयंचलित पुनर्प्राप्ती आधीच वापरली गेली आहे. ॲपमध्ये नवीन कनेक्शन सुरू करा.',
      'vpn_permission_required':
          'टनेल सुरू करण्यापूर्वी Android ला नवीन VPN परवानगी आवश्यक आहे.',
      'vpn_permission_denied':
          'पुढे जाण्यासाठी Android च्या विनंतीमध्ये FuzeVPN ला परवानगी द्या.',
      'vpn_permission_request_failed':
          'Android ला VPN परवानगीची स्क्रीन उघडता आली नाही.',
      'wireguard_foreground_service_unavailable':
          'Android ला WireGuard सेवा फोरग्राउंडमध्ये ठेवता आली नाही.',
      'wireguard_identity_invalid':
          'या खात्याची एन्क्रिप्ट केलेली WireGuard की वाचता न येणारी किंवा अवैध आहे.',
      'wireguard_identity_in_use':
          'दुसरी एखादी क्रिया अजूनही या खात्याची WireGuard की वापरत आहे.',
      'wireguard_configuration_invalid':
          'मिळालेला WireGuard पत्ता, DNS, सर्व्हर की किंवा राउट्स अवैध आहेत.',
      'wireguard_operation_pending':
          'मागील WireGuard क्रियेने अजून तिची नेटिव्ह सेवा मोकळी केलेली नाही.',
      'wireguard_start_failed':
          'WireGuard इंजिनने कॉन्फिगरेशन सक्रिय करण्यास नकार दिला.',
      'wireguard_stop_timeout':
          'ठरलेल्या वेळेत WireGuard सेवेने VPN इंटरफेस मोकळा झाल्याची पुष्टी केली नाही.',
      'wireguard_handshake_timeout':
          'टनेलने वेळेत सर्व्हरसोबत हँडशेकची पुष्टी केली नाही.',
      'openvpn_connection_timeout':
          'OpenVPN ने वेळेत सर्व्हरसोबतच्या कनेक्शनची पुष्टी केली नाही.',
      'openvpn_core_unavailable':
          'या ॲप आवृत्तीमध्ये वापरता येण्याजोगे OpenVPN इंजिन नाही.',
      'openvpn_operation_pending':
          'नेटिव्ह इंजिनने अजूनही मागील OpenVPN सत्र धरून ठेवले आहे आणि दुसरे सत्र तयार करण्यास नकार दिला आहे.',
      'openvpn_stop_timeout':
          'ठरलेल्या वेळेत OpenVPN कोअरने त्याचे नेटिव्ह सत्र थांबून नष्ट झाल्याची पुष्टी केली नाही.',
      'openvpn_profile_unavailable':
          'या कनेक्शनसाठी पडताळलेले OpenVPN प्रोफाइल वाचता येत नाही.',
      'openvpn_native_failed':
          'ॲपमधील त्रुटीमुळे OpenVPN मध्ये व्यत्यय आला. पुन्हा कनेक्ट करून पहा. समस्या कायम राहिल्यास निदान चालवा.',
      'openvpn_key_generation_failed':
          'Android Keystore ला एक्सपोर्ट करता न येणारी P-256 खासगी की तयार करता आली नाही किंवा वाचता आली नाही.',
      'openvpn_csr_generation_failed':
          'Android Keystore मधील की OpenVPN प्रमाणपत्र विनंतीवर स्वाक्षरी करू शकली नाही.',
      'openvpn_identity_store_failed':
          'OpenVPN प्रमाणपत्र किंवा प्रोफाइल एन्क्रिप्ट केलेल्या स्टोरेजमध्ये जतन करता आले नाही.',
      'openvpn_identity_clear_failed':
          'Android ला या खात्याची संपूर्ण स्थानिक OpenVPN ओळख काढता आली नाही.',
      'openvpn_identity_in_use':
          'एक नेटिव्ह OpenVPN सत्र अजूनही या डिव्हाइसची की किंवा प्रमाणपत्र वापरत आहे.',
      'openvpn_tls_verification_required':
          'प्रोफाइलमध्ये सर्व्हर प्रमाणपत्र पडताळणी स्पष्टपणे आवश्यक केलेली नाही.',
      'openvpn_cipher_invalid':
          'सर्व्हरने परवानगी असलेल्या यादीत नसलेला एन्क्रिप्शन अल्गोरिदम दिला आहे.',
      'openvpn_profile_rejected':
          'सर्व्हरकडून मिळालेले प्रोफाइल विसंगत आहे. हे डिव्हाइस पुन्हा तयार करा आणि पुन्हा प्रयत्न करा.',
      'openvpn_identity_inconsistent':
          'प्रमाणपत्र या फोनच्या सुरक्षित ओळखीशी जुळत नाही. कोणतेही स्थानिक प्रोफाइल बदलले गेले नाही.',
      'tls_handshake_failed':
          'सर्व्हरने TLS वाटाघाटी नाकारली. समस्या कायम राहिल्यास प्रोफाइल पुन्हा तयार करा.',
      'tls_alert_unknown_ca':
          'सर्व्हर या डिव्हाइस प्रमाणपत्राचे प्राधिकरण ओळखत नाही. OpenVPN सर्व्हर तपासणे आवश्यक आहे.',
      'tls_alert_bad_certificate':
          'सर्व्हरने हे डिव्हाइस प्रमाणपत्र नाकारले. पुन्हा प्रयत्न करण्यापूर्वी डिव्हाइस पुन्हा तयार करा.',
      'tls_alert_unsupported_certificate':
          'सर्व्हर Android वापरत असलेल्या सुरक्षित प्रमाणपत्र प्रकाराला समर्थन देत नाही.',
      'tls_client_certificate_required':
          'सर्व्हरला क्लायंट प्रमाणपत्र आवश्यक आहे, परंतु OpenVPN कोअर ते सादर करू शकला नाही.',
      'tls_alert_misc':
          'सर्व्हरने प्रमाणपत्र आणि आवृत्ती प्रकारांबाहेरील TLS अलर्ट परत केला.',
      'tls_signature_algorithm_rejected':
          'सर्व्हरने Android Keystore मधील कीचा ECDSA P-256 अल्गोरिदम नाकारला.',
      'tls_handshake_rejected':
          'कनेक्ट होण्यापूर्वीच सर्व्हरने TLS वाटाघाटीमध्ये व्यत्यय आणला.',
      'tls_version_rejected':
          'क्लायंट आणि सर्व्हरला समान TLS आवृत्ती सापडली नाही.',
      'tls_certificate_expired':
          'कनेक्शन दरम्यान सादर केलेल्या प्रमाणपत्राची मुदत संपली आहे.',
      'tls_certificate_revoked':
          'कनेक्शन दरम्यान सादर केलेले प्रमाणपत्र रद्द केले गेले आहे.',
      'transport_failed':
          'सध्याच्या नेटवर्कवर OpenVPN सर्व्हर प्रतिसाद देत नाही. थोड्या वेळाने पुन्हा प्रयत्न करा.',
      'tun_configuration_rejected':
          'OpenVPN ने मागितलेले नेटवर्क कॉन्फिगरेशन Android ने नाकारले.',
      'tun_setup_failed':
          'Android इंटरफेस तयार करण्यापूर्वीच OpenVPN कोअरने नेटवर्क योजना नाकारली.',
      'tun_interface_create_failed':
          'OpenVPN कोअरला Android VpnService कडून TUN इंटरफेस मिळवता आला नाही.',
      'tun_interface_disabled':
          'कनेक्शन दरम्यान Android किंवा OpenVPN कोअरने TUN इंटरफेस अक्षम केला.',
      'tun_halted': 'OpenVPN कोअरला TUN इंटरफेस थांबवण्याची विनंती मिळाली.',
      'tun_already_established':
          'OpenVPN ने त्याच कनेक्शनमध्ये दुसऱ्या इंटरफेसची विनंती केली. सुरक्षिततेसाठी टनेल थांबवला गेला.',
      'tun_addresses_missing':
          'सर्व्हरने वापरता येण्याजोगा टनेल पत्ता दिला नाही.',
      'tun_routes_missing':
          'सर्व्हरने वापरता येण्याजोगे टनेल राउट्स दिले नाहीत.',
      'tun_dns_missing': 'सर्व्हरने वापरता येण्याजोगा DNS सर्व्हर दिला नाही.',
      'tun_permission_revoked':
          'कनेक्शन दरम्यान Android ने VPN परवानगी रद्द केली.',
      'tun_establish_returned_null':
          'Android ने इंटरफेस तयार केला नाही. सहसा दुसरे VPN अजूनही सक्रिय असल्यामुळे असे होते.',
      'openvpn_service_start_failed':
          'Android ला OpenVPN फोरग्राउंड सेवा सुरू करता आली नाही.',
      'openvpn_operation_timeout':
          'OpenVPN कोअरला केलेल्या JNI कॉलने कमाल कालावधी ओलांडला.',
      'openvpn_start_failed':
          'Android सेवा तयार आहे, परंतु OpenVPN कोअरने प्रोफाइल सुरू करणे स्वीकारले नाही.',
      'openvpn_connection_failed':
          'CONNECTED इव्हेंट पाठवण्यापूर्वीच OpenVPN कोअर थांबला.',
      'openvpn_core_status_error':
          'नेटिव्ह OpenVPN लूप अधिक नेमक्या अंतिम इव्हेंटशिवाय त्रुटीसह संपला.',
      'openvpn_stopped_before_connected':
          'नेटिव्ह OpenVPN लूप स्पष्ट कोअर त्रुटीशिवाय CONNECTED होण्यापूर्वीच थांबला.',
      'openvpn_auth_failed': 'OpenVPN सर्व्हरने प्रोफाइल प्रमाणीकरण नाकारले.',
      'openvpn_client_setup_failed':
          'नेटवर्क कनेक्शनपूर्वी OpenVPN कोअर क्लायंट सुरू करू शकला नाही.',
      'openvpn_client_halted':
          'OpenVPN कोअरला क्लायंट थांबवण्याची अंतिम सूचना मिळाली.',
      'openvpn_client_restart':
          'OpenVPN कोअरने त्याचे ट्रान्सपोर्ट सत्र पुन्हा सुरू करण्याची विनंती केली.',
      'openvpn_inactive_timeout':
          'निष्क्रियतेची कालमर्यादा संपल्यानंतर OpenVPN कोअरने सत्र बंद केले.',
      'openvpn_session_expired':
          'OpenVPN सत्राची मुदत संपल्याचे सर्व्हरने कळवले.',
      'openvpn_credentials_required':
          'सर्व्हर किंवा प्रॉक्सी या प्रमाणपत्र प्रोफाइलचा भाग नसलेली परस्परसंवादी साइन इन माहिती मागत आहे.',
      'openvpn_proxy_failed':
          'OpenVPN कोअरने कॉन्फिगर केलेल्या प्रॉक्सी किंवा रिलेमध्ये अपयश आल्याचे कळवले.',
      'openvpn_compression_failed':
          'प्रोफाइल किंवा सर्व्हरने जाहीर केलेला कॉम्प्रेशन मोड OpenVPN कोअरने नाकारला.',
      'openvpn_ntlm_crypto_unavailable':
          'प्रोफाइल NTLM एन्क्रिप्शनची विनंती करते, जे या आवृत्तीमध्ये उपलब्ध नाही.',
      'openvpn_feature_unsupported':
          'प्रोफाइल किंवा सर्व्हरला या Android क्लायंटमध्ये नसलेले वैशिष्ट्य आवश्यक आहे.',
      'network_unavailable': 'वापरता येण्याजोगे भौतिक नेटवर्क उपलब्ध नाही.',
      'network_lost': 'नेटवर्क खंडित झाल्यानंतर टनेल थांबवला गेला.',
      'certificate_validation_failed':
          'OpenVPN सर्व्हरची ओळख पडताळता आली नाही.',
      'openvpn_certificate_expired':
          'OpenVPN प्रमाणपत्राची मुदत संपली आहे. त्याचे नूतनीकरण करण्यासाठी ॲपमध्ये नवीन कनेक्शन सुरू करा.',
      'tunnel_active_for_another_account':
          'या कनेक्शनपूर्वी दुसऱ्या खात्याचा टनेल थांबणे आवश्यक आहे.',
      'tunnel_already_active':
          'मागील VPN सत्र अजूनही इंटरफेस वापरत असल्याचे Android ने कळवले आहे.',
      'tunnel_stop_timeout':
          'ठरलेल्या वेळेत $protocol इंजिनने VPN इंटरफेस मोकळा झाल्याची पुष्टी केली नाही.',
      'tunnel_disconnected':
          'सुरू झाल्यानंतर टनेल अनपेक्षितपणे बंद झाल्याचे नेटिव्ह इंजिनने कळवले.',
      'native_bridge_unavailable':
          'ॲप Android VPN सेवेपर्यंत पोहोचू शकत नाही. ॲप बंद करून पुन्हा उघडा, नंतर पुन्हा प्रयत्न करा.',
      'native_operation_failed':
          'ॲपमधील त्रुटीमुळे VPN क्रियेमध्ये व्यत्यय आला. पुन्हा प्रयत्न करा. समस्या कायम राहिल्यास निदान चालवा.',
      'invalid_arguments':
          'या VPN क्रियेसाठी आवश्यक माहिती अपूर्ण आहे. पुन्हा प्रयत्न करा. समस्या कायम राहिल्यास निदान चालवा.',
      'invalid_account_id':
          'नेटिव्ह क्रिया वैध खाते ओळखकर्त्याशी संबंधित नाही.',
      'invalid_device_id':
          'नेटिव्ह इंजिनला पाठवलेला डिव्हाइस ओळखकर्ता गहाळ किंवा अवैध आहे.',
      'storage_key_not_allowed':
          'Android ब्रिजने परवानगी असलेल्या स्टोरेज यादीबाहेरील की ब्लॉक केली.',
      'secure_storage_read_failed':
          'Android Keystore ला या खात्याचा स्थानिक डेटा डिक्रिप्ट करता आला नाही.',
      'secure_storage_write_failed':
          'Android Keystore ला स्थानिक डेटा एन्क्रिप्ट किंवा जतन करता आला नाही.',
      'key_generation_failed':
          'Android ला सुरक्षित स्टोरेजमधील WireGuard की तयार करता आली किंवा वाचता आली नाही.',
      'csr_generation_failed':
          'Android Keystore ला OpenVPN P-256 CSR तयार किंवा त्यावर स्वाक्षरी करता आली नाही.',
      'other':
          'एक नोंद नसलेली नेटिव्ह शाखा अयशस्वी झाली. खाली दाखवलेला निदान कोड सपोर्टला पाठवा.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'परवानगीची विनंती आधीच उघडी आहे';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN परवानगीची विनंती आधीच दाखवली जात आहे. पुन्हा प्रयत्न करण्यापूर्वी ती पूर्ण करा.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN परवानगीची विनंती खंडित झाली';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ॲपला प्रतिसाद मिळण्यापूर्वीच VPN परवानगीची स्क्रीन बंद झाली.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN कनेक्शनची पुष्टी झाली नाही';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN कनेक्शनची पुष्टी होऊ शकली नाही. सुरक्षिततेसाठी ते थांबवण्यात आले. पुन्हा प्रयत्न करा.';

  @override
  String get openvpnCleanup_title => 'OpenVPN प्रोफाइल रद्द केले';

  @override
  String get openvpnCleanup_working =>
      'रद्द केलेले OpenVPN प्रोफाइल थांबवले जात आहे आणि काढले जात आहे…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN बंद झाल्याची पुष्टी झालेली नाही. नवीन प्रोफाइल तयार करण्यापूर्वी पुन्हा प्रयत्न करा.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'रद्द केलेले OpenVPN प्रोफाइल पूर्णपणे काढता आले नाही. साफसफाईसाठी पुन्हा प्रयत्न करा.';

  @override
  String get openvpnCleanup_complete =>
      'रद्द केलेले OpenVPN प्रोफाइल काढून टाकण्यात आले आहे. नवीन तयार करण्यासाठी “कनेक्ट करा” वर टॅप करा.';

  @override
  String get network_title => 'नेटवर्क कॉन्फिगरेशन';

  @override
  String get network_ipv4Fallback =>
      'IPv6 तात्पुरते उपलब्ध नाही. IPv4 सह तयारी सुरू ठेवली जात आहे.';

  @override
  String get network_rejectedTitle => 'नेटवर्क कॉन्फिगरेशन नाकारले';

  @override
  String get network_rejectedMessage =>
      'टनेल कॉन्फिगरेशन अपूर्ण आहे किंवा अधिकृत पत्त्यांशी जुळत नाही. ॲपमधून पुन्हा प्रयत्न करा.';

  @override
  String get network_unreadableTitle => 'स्थानिक कॉन्फिगरेशन वाचता येत नाही';

  @override
  String get network_unreadableMessage =>
      'जतन केलेले OpenVPN नेटवर्क कॉन्फिगरेशन वापरता येत नाही. ते अपडेट करण्यासाठी ॲपमधून पुन्हा कनेक्ट करा.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'नेटवर्क संरक्षण';

  @override
  String get protection_subtitle =>
      'VPN डिस्कनेक्ट झाल्यास थेट इंटरनेट प्रवेश ब्लॉक करा.';

  @override
  String get protection_active => 'सिस्टम संरक्षण सक्रिय आहे';

  @override
  String get protection_alwaysOnOnly =>
      'नेहमी-चालू VPN सक्रिय आहे. VPN शिवाय कनेक्शन ब्लॉक करणे चालू करा';

  @override
  String get protection_inactive => 'सिस्टम संरक्षण निष्क्रिय आहे';

  @override
  String get protection_unknown => 'सिस्टम संरक्षण तपासा';

  @override
  String get protection_openSettings => 'Android सेटिंग्ज उघडा';

  @override
  String get protection_dialogTitle => 'नेटवर्क संरक्षण सेट करा';

  @override
  String get protection_dialogMessage =>
      'नेहमी-चालू VPN आणि VPN बाहेरील कनेक्शन ब्लॉक करणे Android व्यवस्थापित करते. FuzeVPN निवडलेले आहे का ते तपासा आणि सिस्टम सेटिंग्जमध्ये ब्लॉक करणे चालू करा.';

  @override
  String get protection_dialogOpen => 'सेटिंग्ज उघडा';

  @override
  String get session_systemProtectionNote =>
      'VPN बाहेरील ट्रॅफिक Android अजूनही ब्लॉक करत असेल, तर हे संरक्षण तपासण्यासाठी किंवा बदलण्यासाठी सिस्टम सेटिंग्ज उघडा.';

  @override
  String get diagnostics_title => 'निदान';

  @override
  String get diagnostics_settingsTitle => 'ॲपचे निदान';

  @override
  String get diagnostics_automaticTitle => 'महत्त्वाच्या त्रुटी पाठवा';

  @override
  String get diagnostics_automaticDescription =>
      'महत्त्वाची त्रुटी आल्यावर एक छोटा तांत्रिक अहवाल शेअर करा.';

  @override
  String get diagnostics_privacy =>
      'पाठवलेले अहवाल साइन इन केलेल्या खात्याशी जोडलेले असतात आणि 30 दिवस ठेवले जातात. त्यामध्ये ब्राउझिंग इतिहास, पासवर्ड किंवा VPN कीज नसतात.';

  @override
  String get diagnostics_manualOpen => 'निदान चालवा';

  @override
  String get diagnostics_localDescription =>
      'ॲप आणि VPN स्थितीचा अहवाल तयार करा. तुमचे कनेक्शन तसेच राहील.';

  @override
  String get diagnostics_sendReport => 'अहवाल पाठवा';

  @override
  String get diagnostics_sendHint =>
      'अहवाल या डिव्हाइसवरच ठेवण्यासाठी हा बॉक्स निवडू नका.';

  @override
  String get diagnostics_signedOut =>
      'अहवाल पाठवण्यासाठी तुमच्या खात्यात साइन इन करा.';

  @override
  String get diagnostics_localLifetime =>
      'ॲप बंद केल्यानंतरही हा अहवाल ठेवण्यासाठी तो तुमच्या फोनमध्ये जतन करा.';

  @override
  String get diagnostics_run => 'निदान चालवा';

  @override
  String get diagnostics_rerun => 'निदान पुन्हा चालवा';

  @override
  String get diagnostics_running => 'तपासणी सुरू आहे…';

  @override
  String get diagnostics_sending => 'अहवाल पाठवला जात आहे…';

  @override
  String get diagnostics_prepared => 'अहवाल या डिव्हाइसवर तयार आहे';

  @override
  String get diagnostics_queued => 'अहवाल पाठवण्यासाठी प्रतीक्षेत आहे';

  @override
  String get diagnostics_sent => 'अहवाल मिळाला';

  @override
  String get diagnostics_failed =>
      'पाठवणे अयशस्वी झाले. तुमचा स्थानिक अहवाल अजूनही उपलब्ध आहे.';

  @override
  String get diagnostics_preparationFailed =>
      'निदान अहवाल तयार करता आला नाही. पुन्हा प्रयत्न करा.';

  @override
  String get diagnostics_authenticationRequired =>
      'अहवाल पाठवण्यासाठी पुन्हा साइन इन करा.';

  @override
  String get diagnostics_retry => 'पुन्हा पाठवा';

  @override
  String get diagnostics_export => 'अहवाल जतन करा';

  @override
  String get diagnostics_exportFailed =>
      'अहवाल जतन करता आला नाही. स्थानिक अहवालावरून पुन्हा प्रयत्न करा.';

  @override
  String get diagnostics_preferenceFailed =>
      'ही सेटिंग जतन करता आली नाही. पुन्हा प्रयत्न करा.';

  @override
  String diagnostics_receipt(Object id) {
    return 'संदर्भ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date रोजी मिळाला';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date पर्यंत ठेवला जाईल';
  }

  @override
  String get diagnostics_duplicate => 'हा अहवाल आधीच मिळाला होता.';

  @override
  String get diagnostics_preview => 'अहवालाचे पूर्वावलोकन';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count तांत्रिक घटना जोडल्या आहेत',
      one: '1 तांत्रिक घटना जोडली आहे',
      zero: 'कोणतीही तांत्रिक घटना जोडलेली नाही',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'तांत्रिक तपशील';

  @override
  String get diagnostics_empty => 'अजून कोणताही निदान अहवाल तयार केलेला नाही.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'टनेल स्थिती',
      'handshake': 'कनेक्शन पुष्टी',
      'certificate': 'VPN प्रमाणपत्र',
      'kill_switch': 'Android संरक्षण',
      'connectivity': 'उपलब्ध नेटवर्क',
      'api_reachability': 'सेवा प्रवेश',
      'secure_storage': 'सुरक्षित स्टोरेज',
      'other': 'स्थानिक तपासणी',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'तपासले',
      'failed': 'लक्ष देणे आवश्यक आहे',
      'skipped': 'चाचणी केलेली नाही — सक्रिय तपासणी नाही',
      'unknown': 'माहिती उपलब्ध नाही',
      'other': 'माहिती उपलब्ध नाही',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN मध्ये स्वागत आहे';

  @override
  String get connection_changeLocation => 'स्थान बदला';

  @override
  String get connection_details => 'कनेक्शनचे तपशील';

  @override
  String get locations_searchLabel => 'शहर किंवा देश शोधा';

  @override
  String get locations_clearSearch => 'शोध साफ करा';

  @override
  String get locations_filterAll => 'सर्व';

  @override
  String get locations_filterFavorites => 'आवडते';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count स्थाने',
      one: '$count स्थान',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'कोणतेही स्थान सापडले नाही';

  @override
  String get locations_noResultsHint => 'दुसरे शहर किंवा देश वापरून पहा.';

  @override
  String get locations_noFavorites => 'तुमची आवडती स्थाने, अगदी हाताशी';

  @override
  String get locations_noFavoritesHint =>
      'येथे जतन करण्यासाठी स्थानाशेजारील तारा चिन्हावर टॅप करा.';

  @override
  String get locations_showAll => 'सर्व स्थाने पहा';

  @override
  String locations_addFavorite(String name) {
    return '$name आवडत्यांमध्ये जोडा';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name आवडत्यांमधून काढा';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'आवडते जतन करता आले नाही. पुन्हा प्रयत्न करा.';

  @override
  String get locations_emptyTitle => 'कोणतीही स्थाने उपलब्ध नाहीत';

  @override
  String get locations_emptyHint =>
      'पुन्हा प्रयत्न करण्यासाठी यादी रीफ्रेश करा.';

  @override
  String get devices_manage => 'माझी डिव्हाइस व्यवस्थापित करा';

  @override
  String get settings_personalization => 'तुमच्या पसंतीनुसार';

  @override
  String get settings_safety => 'संरक्षण';

  @override
  String get settings_help => 'मदत हवी आहे?';

  @override
  String get settings_about => 'FuzeVPN बद्दल';

  @override
  String get diagnostics_heading => 'कनेक्शनची समस्या समजून घ्या';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'उपलब्ध',
      'pending': 'तयारी सुरू आहे',
      'revoked': 'काढून टाकले',
      'expired': 'कालबाह्य',
      'other': 'स्थिती उपलब्ध नाही',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'पसंती जतन झाली नाही';

  @override
  String get notice_preferenceSave_message =>
      'तुमची निवड सध्या लागू केली आहे, पण ती जतन होऊ शकली नाही. ॲप बंद केल्यानंतरही ती ठेवण्यासाठी पुन्हा प्रयत्न करा.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPN सक्रिय ठेवत असेल, तर उघडणाऱ्या सेटिंग्जमध्ये नेहमी-चालू VPN बंद करा.';

  @override
  String get connection_certificate => 'OpenVPN प्रमाणपत्र';

  @override
  String connection_certificateValidUntil(Object date) {
    return '$date पर्यंत वैध';
  }

  @override
  String connection_certificateExpired(Object date) {
    return '$date रोजी मुदत संपली';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'पुढील कनेक्शनच्या वेळी आपोआप नूतनीकरण होईल.';

  @override
  String get protection_learnMore => 'Android संरक्षणाबद्दल जाणून घ्या';

  @override
  String get protection_guideWhy =>
      'VPN डिस्कनेक्ट झाल्यास हे संरक्षण ॲप्सना थेट इंटरनेट वापरण्यापासून रोखते. ते Android मध्ये सेट केले जाते.';

  @override
  String get protection_guideAlwaysOnTitle => 'नेहमी-चालू VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN सेवा चालू ठेवते आणि फोन रीस्टार्ट झाल्यानंतर ती पुन्हा सुरू करू शकते.';

  @override
  String get protection_guideBlockTitle => 'VPN शिवाय कनेक्शन ब्लॉक करा';

  @override
  String get protection_guideBlock =>
      'ही सेटिंग कनेक्शन खंडित असतानाही ट्रॅफिक VPN ला बायपास करून जाण्यापासून रोखते.';

  @override
  String get protection_guideWarning =>
      'हे ब्लॉकिंग चालू असताना, VPN कनेक्ट होईपर्यंत इंटरनेट प्रवेश बंद राहील.';

  @override
  String get protection_guideStepsTitle => 'संरक्षण चालू करा';

  @override
  String get protection_guideStep1 => 'खालील बटणाने Android VPN सेटिंग्ज उघडा.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN च्या शेजारी असलेल्या गिअर आयकॉनवर टॅप करून पर्याय उघडा.';

  @override
  String get protection_guideStep3 =>
      'हे पर्याय उपलब्ध असल्यास, “नेहमी-चालू VPN” चालू करा आणि नंतर “VPN शिवाय कनेक्शन ब्लॉक करा” चालू करा.';

  @override
  String get protection_guideManufacturers =>
      'फोननुसार नावे वेगळी असू शकतात. आवश्यक असल्यास, सेटिंग्जमध्ये VPN शोधा. ते बहुतेकदा “नेटवर्क आणि इंटरनेट” मध्ये असते.';

  @override
  String get protection_guideDisableTitle => 'हे संरक्षण बंद करा';

  @override
  String get protection_guideDisable =>
      'त्याच सेटिंग्जमध्ये, VPN शिवाय इंटरनेट प्रवेश मिळवण्यासाठी “VPN शिवाय कनेक्शन ब्लॉक करा” बंद करा. Android ने VPN पुन्हा सुरू करावे असे तुम्हाला वाटत नसेल, तर “नेहमी-चालू VPN” देखील बंद करा.';

  @override
  String get protection_guideManual =>
      'ही सेटिंग्ज तुम्ही Android मध्ये निवडता. FuzeVPN ती तुमच्यासाठी बदलत नाही.';

  @override
  String get locations_changeTitle => 'स्थान बदलायचे?';

  @override
  String locations_changeActive(String name) {
    return 'VPN डिस्कनेक्ट होईल, त्यानंतर $name शी कनेक्ट करण्याचा प्रयत्न करेल.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name शी कनेक्ट करण्याचा प्रयत्न करेल.';
  }

  @override
  String get locations_confirmChange => 'बदला आणि कनेक्ट करा';

  @override
  String get locations_changeBusy =>
      'एक बदल सुरू आहे. दुसरे स्थान निवडण्यापूर्वी प्रतीक्षा करा.';

  @override
  String get locations_automaticSelection => 'स्वयंचलित निवड';

  @override
  String get locations_cities => 'शहरे';

  @override
  String get locations_servers => 'सर्व्हर';

  @override
  String locations_viewCities(String name) {
    return '$name मधील शहरे पहा';
  }

  @override
  String locations_viewServers(String name) {
    return '$name मधील सर्व्हर पहा';
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
      other: '$count शहरे',
      one: '$count शहर',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सर्व्हर',
      one: '$count सर्व्हर',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'सर्व देश';

  @override
  String get locations_backToCountries => 'देशांकडे परत जा';

  @override
  String locations_backToCities(String name) {
    return '$name मधील शहरांकडे परत जा';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name निवडा';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name निवडा';
  }

  @override
  String get locations_noCompatibleServer =>
      'कोणताही सुसंगत सर्व्हर उपलब्ध नाही.';

  @override
  String get externalLink_failed =>
      'ही लिंक उघडता आली नाही. तुम्ही ती कॉपी करून तुमच्या ब्राउझरमध्ये उघडू शकता.';

  @override
  String get externalLink_copy => 'लिंक कॉपी करा';

  @override
  String get externalLink_copied => 'लिंक कॉपी झाली';

  @override
  String get externalLink_copyFailed =>
      'लिंक कॉपी करता आली नाही. खालील पत्ता निवडा.';

  @override
  String get settings_deleteAccount => 'माझे खाते हटवा';

  @override
  String get settings_deleteAccountDetail =>
      'खाते हटवण्याच्या विनंतीची प्रक्रिया पहा';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'तुमची VPN सदस्यता निवडा.';

  @override
  String get billing_subscribe => 'सदस्यता घ्या';

  @override
  String get billing_choosePlan => 'पुढे जाण्यासाठी एक योजना निवडा.';

  @override
  String get billing_monthly => 'मासिक';

  @override
  String get billing_yearly => 'वार्षिक';

  @override
  String get billing_continue => 'Google Play सह सुरू ठेवा';

  @override
  String get billing_restore => 'खरेदी पुनर्संचयित करा';

  @override
  String get billing_manage => 'सदस्यता व्यवस्थापित करा';

  @override
  String get billing_deleteAccountWarning =>
      'तुमची Google Play सदस्यता असल्यास, तुमचे FuzeVPN खाते हटवल्याने तिचे नूतनीकरण रद्द होत नाही. नूतनीकरण Google Play मध्ये स्वतंत्रपणे व्यवस्थापित करा किंवा रद्द करा.';

  @override
  String get billing_deleteAccountContinue =>
      'खाते हटवण्याच्या विनंतीसाठी पुढे जा';

  @override
  String get billing_refresh => 'प्रवेश पुन्हा तपासा';

  @override
  String get billing_loadingPlans => 'योजना लोड होत आहेत…';

  @override
  String get billing_unavailable =>
      'सध्या कोणतीही योजना उपलब्ध नाही. नंतर पुन्हा प्रयत्न करा.';

  @override
  String get billing_comingSoon => 'सदस्यता लवकरच उपलब्ध होतील.';

  @override
  String get billing_priceDisclosure =>
      'किंमत Google Play द्वारे दिली जाते. तुम्ही पुष्टी करण्यापूर्वी अंतिम रक्कम आणि लागू कर निश्चित केले जातात.';

  @override
  String get billing_renewalMonthly =>
      'रद्द न केल्यास दर महिन्याला आपोआप नूतनीकरण होते. तुम्ही Google Play मधील सदस्यतांमध्ये कधीही रद्द करू शकता.';

  @override
  String get billing_renewalYearly =>
      'रद्द न केल्यास दर वर्षी आपोआप नूतनीकरण होते. तुम्ही Google Play मधील सदस्यतांमध्ये कधीही रद्द करू शकता.';

  @override
  String get billing_active => 'तुमचा Premium प्रवेश सक्रिय आहे';

  @override
  String billing_accessUntil(String date) {
    return '$date पर्यंत प्रवेश.';
  }

  @override
  String get billing_webManaged =>
      'तुमची सदस्यता FuzeVPN वेबसाइटवर व्यवस्थापित केली जाते.';

  @override
  String get billing_playManaged =>
      'तुमची सदस्यता Google Play द्वारे व्यवस्थापित केली जाते.';

  @override
  String get billing_playOnHold =>
      'तुमची Google Play सदस्यता स्थगित आहे किंवा पेमेंटची प्रतीक्षा करत आहे. Google Play मध्ये ती दुरुस्त करण्यासाठी “सदस्यता व्यवस्थापित करा” उघडा.';

  @override
  String get billing_playReceiptUnlinked =>
      'या Google Play खात्यावर आधीपासून एक Fuze Premium सदस्यता आहे, जी या FuzeVPN खात्यासाठी सक्रिय नाही. Google Play मध्ये ती तपासण्यासाठी “सदस्यता व्यवस्थापित करा” उघडा.';

  @override
  String get billing_inactive => 'कोणतीही सक्रिय सदस्यता नाही.';

  @override
  String get billing_checkingAccess => 'तुमच्या प्रवेशाची तपासणी करत आहे…';

  @override
  String get billing_restoring => 'खरेदी पुनर्संचयित करत आहे…';

  @override
  String get billing_pending =>
      'पेमेंट प्रलंबित आहे. पुष्टी झाल्यानंतर तुमचा प्रवेश सक्रिय होईल.';

  @override
  String get billing_cancelled =>
      'खरेदी रद्द झाली. कोणतीही नवीन सदस्यता सक्रिय झालेली नाही.';

  @override
  String get billing_verifying => 'खरेदीची पडताळणी करत आहे…';

  @override
  String get billing_success =>
      'सदस्यता सक्रिय झाली. तुमचा Premium प्रवेश तयार आहे.';

  @override
  String get billing_restored => 'तुमच्या खरेदी पुनर्संचयित झाल्या आहेत.';

  @override
  String get billing_restoreEmpty =>
      'या Google Play खात्यासाठी पुनर्संचयित करण्यासारखी कोणतीही खरेदी नाही.';

  @override
  String get billing_catalogError =>
      'योजना लोड करता आल्या नाहीत. पुन्हा प्रयत्न करा.';

  @override
  String get billing_purchaseError =>
      'खरेदी सुरू करता आली नाही. पुन्हा प्रयत्न करा.';

  @override
  String get billing_verificationError =>
      'खरेदीची पडताळणी तात्पुरती उपलब्ध नाही. पुन्हा प्रयत्न करण्यासाठी खरेदी पुनर्संचयित करा.';

  @override
  String get billing_restoreError =>
      'खरेदी पुनर्संचयित करता आल्या नाहीत. पुन्हा प्रयत्न करा.';

  @override
  String get billing_managementError =>
      'सदस्यता व्यवस्थापन उघडता आले नाही. पुन्हा प्रयत्न करा.';

  @override
  String get billing_storeUnavailable =>
      'या डिव्हाइसवर Google Play उपलब्ध नाही.';

  @override
  String get welcome_title => 'तुमचे VPN, अगदी सोपे.';

  @override
  String get welcome_description =>
      'तुमच्या कनेक्शनचे संरक्षण करा. तुमच्या गोपनीयतेवर नियंत्रण ठेवा.';

  @override
  String get welcome_start => 'सुरू करा';

  @override
  String get welcome_alreadyPurchased => 'आधीच खरेदी केली आहे?';

  @override
  String get welcome_noAccountRequired => 'सुरू करण्यासाठी खाते आवश्यक नाही.';

  @override
  String get guest_accountTitle => 'खाते जोडलेले नाही';

  @override
  String get guest_accountDescription =>
      'दुसऱ्या डिव्हाइसवर तुमची सदस्यता वापरण्यासाठी त्याच Google Play खात्याने तुमच्या खरेदी पुनर्संचयित करा.';

  @override
  String get guest_existingSubscriberSignIn =>
      'आधीपासून सदस्य आहात? साइन इन करा';

  @override
  String get guest_claimTitle => 'FuzeVPN तुमच्यासोबत घेऊन जा';

  @override
  String get guest_claimDescription =>
      'तुमच्या इतर डिव्हाइसवर तुमची सदस्यता वापरण्यासाठी खाते तयार करा. ही पायरी ऐच्छिक आहे.';

  @override
  String get guest_skip => 'नंतर पाहू';

  @override
  String get guest_activationTitle => 'Fuze Premium सक्रिय आहे';

  @override
  String get guest_activationDescription =>
      'तुमची सदस्यता तयार आहे. तुमचे VPN वापरा आणि हवे तेव्हा खाते तयार करा.';

  @override
  String get guest_useVpn => 'माझे VPN वापरा';

  @override
  String get guest_loginRequired =>
      'ही खरेदी आधीच एका FuzeVPN खात्याशी जोडलेली आहे. तुमच्या सदस्यतेत प्रवेश मिळवण्यासाठी त्या खात्यात साइन इन करा.';

  @override
  String get guest_signOutWarning =>
      'त्याच Google Play खात्याने खरेदी पुनर्संचयित करून तुम्ही तुमची सदस्यता परत मिळवू शकता.';

  @override
  String get guest_profileUnavailable =>
      'तुमचे खाते आधीच जोडलेले आहे. तुमची माहिती पाहण्यासाठी आणि व्यवस्थापित करण्यासाठी साइन इन करा.';

  @override
  String get billing_acceptance =>
      'सुरू ठेवल्यास तुम्ही वापराच्या अटी आणि गोपनीयता धोरण स्वीकारता.';

  @override
  String get guest_verifyEmailReminder =>
      'तुमचे खाते सुरक्षित करण्यासाठी तुमच्या ईमेल पत्त्याची पुष्टी करा. तुम्ही तुमचे VPN वापरत राहू शकता.';

  @override
  String get guest_serviceUnavailable =>
      'सेवा तात्पुरती उपलब्ध नाही. थोड्या वेळाने पुन्हा प्रयत्न करा.';

  @override
  String get guest_restoreError =>
      'तुमच्या खरेदी पुनर्संचयित करता आल्या नाहीत. खरेदीसाठी वापरलेल्या Google Play खात्याने पुन्हा प्रयत्न करा.';

  @override
  String get guest_claimSuccess =>
      'तुमचे खाते तयार झाले आहे. तुमची सदस्यता आणि VPN प्रवेश कायम ठेवले आहेत.';

  @override
  String get guest_emailExists =>
      'हा ईमेल आधीच वापरात आहे. दुसरा पत्ता निवडा किंवा तुमच्या सध्याच्या खात्यात साइन इन करा. तुमची खरेदी Google Play द्वारे उपलब्ध राहील.';

  @override
  String get guest_claimError =>
      'तुमचे खाते तयार करता आले नाही. तुम्ही तुमचे VPN वापरत राहू शकता आणि नंतर पुन्हा प्रयत्न करू शकता.';

  @override
  String get guest_secureStorageError =>
      'या डिव्हाइसवर तुमचे सत्र सुरक्षित करता आले नाही. पुन्हा प्रयत्न करा.';

  @override
  String get guest_premiumRequired =>
      'तुमचे VPN सक्रिय करण्यासाठी सदस्यता निवडा.';

  @override
  String get welcome_viewPlans => 'योजना पहा';

  @override
  String get google_continue => 'Google सह सुरू ठेवा';

  @override
  String get google_or => 'किंवा';

  @override
  String get google_title => 'तुमचे FuzeVPN खाते';

  @override
  String get google_settingUp => 'तुमचे खाते तयार करणे पूर्ण करा';

  @override
  String get google_country => 'निवासाचा देश';

  @override
  String get google_profileDescription =>
      'तुमचे FuzeVPN खाते तयार करण्यासाठी तुमचा देश निवडा आणि दोन्ही दस्तऐवज तपासा.';

  @override
  String get google_claimDescription =>
      'तुमचे अतिथी खाते Google शी जोडा. तुमची सदस्यता आणि डिव्हाइस या खात्याशी जोडलेले राहतील.';

  @override
  String get google_linkTitle => 'Google ला FuzeVPN शी जोडा';

  @override
  String get google_linkDescription =>
      'तुमच्या सध्याच्या FuzeVPN खात्याच्या प्रवेशाची पुष्टी करा. या पायरीत तुमचा Google पासवर्ड विचारला जात नाही.';

  @override
  String get google_password => 'FuzeVPN पासवर्ड';

  @override
  String get google_linkAccount => 'लिंकची पुष्टी करा';

  @override
  String get google_requestEmail => 'मला पुष्टीकरण ईमेल पाठवा';

  @override
  String get google_emailInstructions =>
      'FuzeVPN ईमेल उघडा आणि पुष्टीकरण कोड प्रविष्ट करा.';

  @override
  String get google_emailCode => 'ईमेल पुष्टीकरण कोड';

  @override
  String get google_confirmEmail => 'कोडची पुष्टी करा';

  @override
  String get google_restart => 'दुसरे Google खाते निवडा';

  @override
  String get google_resume => 'हा प्रयत्न तपासा';

  @override
  String get google_unavailable =>
      'Google साइन इन उपलब्ध नाही. तुम्ही ईमेल आणि पासवर्ड वापरू शकता.';

  @override
  String get google_expired =>
      'हा प्रयत्न कालबाह्य झाला आहे. तो रद्द करा आणि पुन्हा सुरू करा.';

  @override
  String get google_conflict =>
      'हे Google खाते आधीच दुसरीकडे जोडलेले आहे. तुमचे सध्याचे खाते आणि सदस्यता कायम ठेवली आहे.';

  @override
  String get google_error =>
      'Google साइन इन अयशस्वी झाले. पुन्हा प्रयत्न करा. तुमचा सध्याचा प्रवेश कायम ठेवला आहे.';

  @override
  String get google_uncertain =>
      'निकालाची पुष्टी होऊ शकली नाही. पुन्हा सुरू करण्यापूर्वी हा प्रयत्न तपासा किंवा रद्द करा.';

  @override
  String get google_cancelFailed =>
      'रद्द करण्याची पुष्टी होऊ शकली नाही. ही स्क्रीन सोडण्यापूर्वी पुन्हा रद्द करण्याचा प्रयत्न करा.';

  @override
  String get google_cancelled => 'Google साइन इन रद्द केले.';

  @override
  String get google_selecting => 'तुमचे Google खाते निवडा…';

  @override
  String get google_verifying => 'तुमचे खाते तपासत आहे…';

  @override
  String get google_emailUnavailable =>
      'पुष्टीकरण ईमेल पाठवता आला नाही. नंतर पुन्हा प्रयत्न करा.';

  @override
  String get google_emailSent => 'पुष्टीकरण ईमेल पाठवला. तुमचा इनबॉक्स तपासा.';

  @override
  String get google_rateLimited =>
      'कृपया पुन्हा प्रयत्न करण्यापूर्वी प्रतीक्षा करा.';

  @override
  String get google_busy =>
      'दुसरी क्रिया सुरू असताना (VPN कनेक्शन, खाते किंवा अतिथी) Google उपलब्ध नाही. ती पूर्ण झाल्यावर पुन्हा प्रयत्न करा. तुमचा सध्याचा प्रवेश कायम ठेवला आहे.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN पासवर्ड चुकीचा आहे. तुमचे सध्याचे खाते कायम ठेवले आहे.';

  @override
  String get google_invalidCode =>
      'पुष्टीकरण कोड अवैध आहे किंवा त्याची मुदत संपली आहे.';

  @override
  String get google_accountChanged =>
      'तुमचे सत्र बदलले आहे. पुन्हा सुरू करण्यापूर्वी हा प्रयत्न रद्द करा.';

  @override
  String get google_invalidResponse =>
      'प्रतिसादाची पडताळणी करता आली नाही. तुमचा सध्याचा प्रवेश कायम ठेवला आहे.';

  @override
  String get google_invalidRegistration => 'तुमचा देश आणि दोन्ही संमती तपासा.';

  @override
  String get google_consentRequired =>
      'पुढे जाण्यासाठी तुमचा देश निवडा आणि दोन्ही दस्तऐवज स्वीकारा.';

  @override
  String get google_challengeRequired =>
      'अतिरिक्त सुरक्षा तपासणी आवश्यक आहे. तुमचा सध्याचा प्रवेश कायम ठेवला आहे.';

  @override
  String get google_challengeUnavailable =>
      'सुरक्षा तपासणी उपलब्ध नाही. नंतर पुन्हा प्रयत्न करा.';

  @override
  String get google_intentMismatch =>
      'आधीचा Google साइन इन प्रयत्न अद्याप प्रलंबित आहे. ही क्रिया सुरू करण्यापूर्वी तो रद्द करा.';

  @override
  String get google_challengeBlocked =>
      'आवश्यक सुरक्षा तपासणी या ॲपमध्ये उपलब्ध नाही. ही क्रिया सध्या पूर्ण करता येणार नाही.';

  @override
  String get google_solveChallenge => 'सुरक्षा तपासणी पूर्ण करा';

  @override
  String get google_challengeTitle => 'सुरक्षा तपासणी';

  @override
  String get google_challengeReady =>
      'पडताळणी पूर्ण झाली. आता तुम्ही खाते तयार करण्याची पुष्टी करू शकता.';

  @override
  String get google_challengeExpired =>
      'पडताळणीची मुदत संपली आहे. पुष्टी करण्यापूर्वी ती पुन्हा पूर्ण करा.';

  @override
  String get google_challengeCancelled =>
      'पडताळणी रद्द झाली. तुम्ही ती पुन्हा करून पाहू शकता.';

  @override
  String get google_challengeFailed =>
      'सुरक्षा तपासणी अयशस्वी झाली. पुन्हा प्रयत्न करा.';

  @override
  String get billing_trialTitle => 'Fuze Premium मोफत वापरून पहा';

  @override
  String get billing_trialSubtitle => 'आजपासूनच तुमच्या कनेक्शनचे संरक्षण करा.';

  @override
  String get billing_trialWeeks => '2 आठवड्यांची मोफत चाचणी';

  @override
  String billing_trialDays(String days) {
    return '$days दिवसांची मोफत चाचणी';
  }

  @override
  String get billing_trialStart => 'माझी मोफत चाचणी सुरू करा';

  @override
  String billing_trialFirstCharge(String date) {
    return 'तुम्ही आज सुरू केल्यास, तुमचे पहिले शुल्क $date रोजी आकारले जाणे अपेक्षित आहे.';
  }

  @override
  String get billing_trialTerms =>
      'नमूद केलेल्या किमतीत आपोआप नूतनीकरण होते. शुल्क टाळण्यासाठी चाचणी संपण्यापूर्वी Google Play मध्ये रद्द करा.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'त्यानंतर दर महिन्याला $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'त्यानंतर दर वर्षी $price';
  }

  @override
  String get billing_choosePeriod => 'तुमची योजना निवडा';

  @override
  String get billing_selectionHint => 'पुढे जाण्यासाठी योजना निवडा.';

  @override
  String get billing_benefitConnection => 'एन्क्रिप्टेड कनेक्शन';

  @override
  String get billing_benefitPrivacy => 'ऑनलाइन गोपनीयता';

  @override
  String get billing_benefitNoAccount => 'नोंदणीची आवश्यकता नाही';

  @override
  String get billing_cancellation => 'Google Play मध्ये रद्द करा';

  @override
  String get billing_premiumTitle => 'अधिक संरक्षित कनेक्शन.';

  @override
  String get billing_premiumSubtitle =>
      'तुमच्या सोयीनुसार तुमच्या कनेक्शनचे संरक्षण करा.';

  @override
  String get billing_priceMonthly => 'दर महिन्याला';

  @override
  String get billing_priceYearly => 'दर वर्षी';

  @override
  String get billing_trialToday => 'आज काहीही भरायचे नाही';

  @override
  String get billing_trialConfirmation =>
      'तुम्ही पुष्टी करण्यापूर्वी Google Play तारखा, अंतिम रक्कम आणि लागू कर निश्चित करते.';

  @override
  String get billing_offerChanged =>
      'या ऑफरच्या अटी बदलल्या आहेत. योजना पुन्हा लोड करा आणि पुन्हा निवडा.';

  @override
  String get status_waitingNetwork => 'नेटवर्कची प्रतीक्षा करत आहे';

  @override
  String get status_waitingNetworkDetail =>
      'कोणतेही नेटवर्क उपलब्ध नाही. नेटवर्क परत आल्यावर VPN कनेक्शनची पडताळणी करेल.';

  @override
  String get locations_favoriteLoadFailed =>
      'आवडती स्थाने लोड करता आली नाहीत. पुन्हा प्रयत्न करा.';

  @override
  String get locations_favoritesLoading => 'आवडती स्थाने लोड होत आहेत…';
}
