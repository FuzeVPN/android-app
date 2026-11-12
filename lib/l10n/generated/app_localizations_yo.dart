// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Ẹ dáàbò bo àsopọ̀ yín';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ń lo iṣẹ́ VPN ti Android (VpnService) láti ṣẹ̀dá ọ̀nà ìsopọ̀ tí a fi ìkọ̀kọ̀ pamọ́ láàárín ẹ̀rọ yìí àti àwọn olùpín FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Nígbà tí VPN bá ń ṣiṣẹ́, ìrìnnà Íńtánẹ́ẹ̀tì ti àwọn ohun èlò yín, àwọn àdírẹ́sì ibi tí wọ́n ń lọ àti àwọn ìbéèrè DNS ń gba ọ̀nà ìsopọ̀ yìí kọjá láti darí àsopọ̀ yín, kódà nígbà tí FuzeVPN wà ní abẹ́lẹ̀.';

  @override
  String get vpnDisclosure_statusBody =>
      'Ohun èlò náà ń lo ipò àsopọ̀, ìgbà tí ó ti pẹ́ àti iye dátà tí a gbé kọjá láti fi àsopọ̀ VPN yín hàn. Ẹ lè dá a dúró nígbàkigbà.';

  @override
  String get vpnDisclosure_privacy => 'Ìpamọ́';

  @override
  String get vpnDisclosure_accept => 'Gbà, tẹ̀síwájú';

  @override
  String get vpnDisclosure_decline => 'Kì í ṣe nísinsìnyí';

  @override
  String get accountRestoration_title => 'Àkántì kò sí fún ìgbà díẹ̀';

  @override
  String get accountRestoration_message =>
      'A ti pa ìgbà ìwọlé yín mọ́. Ẹ tún gbìyànjú láti mú àkántì yín padà; ẹ ṣì lè ṣàkóso àsopọ̀ VPN níhìn-ín.';

  @override
  String get action_retry => 'Tún gbìyànjú';

  @override
  String get session_endingTitle => 'Ń parí ìgbà ìwọlé';

  @override
  String get session_ending =>
      'Ń parí ìgbà ìwọlé: ń dá VPN dúró, ń sì ń ṣe ìwẹ̀nùmọ́…';

  @override
  String get session_stopFailed =>
      'A kò tíì jẹ́rìí sí pé VPN ti dúró. Ẹ tún gbìyànjú kí ẹ tó tún wọlé.';

  @override
  String get session_cleanupFailed =>
      'VPN ti dúró, ṣùgbọ́n a kò tíì jẹ́rìí sí yíyọ ìgbà ìwọlé kúrò. Ẹ tún gbìyànjú ìwẹ̀nùmọ́.';

  @override
  String get session_retryStop => 'Tún gbìyànjú ìdádúró';

  @override
  String get session_retryCleanup => 'Tún gbìyànjú ìwẹ̀nùmọ́';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Ń múra FuzeVPN sílẹ̀ lọ́nà ààbò…';

  @override
  String get nav_connection => 'Àsopọ̀';

  @override
  String get nav_locations => 'Àwọn ibi';

  @override
  String get nav_account => 'Àkántì';

  @override
  String get nav_devices => 'Àwọn ẹ̀rọ';

  @override
  String get nav_settings => 'Ìṣètò';

  @override
  String get action_refresh => 'Sọdọ̀tun';

  @override
  String get auth_tab_login => 'Wọlé';

  @override
  String get auth_tab_register => 'Forúkọsílẹ̀';

  @override
  String get auth_stepAccount => 'Àkántì';

  @override
  String get auth_stepIdentity => 'Ìdánimọ̀';

  @override
  String get auth_stepAddress => 'Àdírẹ́sì àti àwọn àdéhùn';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Ìgbésẹ̀ $current nínú $total';
  }

  @override
  String get auth_tagline => 'VPN yín, ní ọ̀nà tó rọrùn.';

  @override
  String get auth_keysLocal =>
      'Àwọn kọ́kọ́rọ́ VPN ìkọ̀kọ̀ yín wà lórí ẹ̀rọ yìí.';

  @override
  String get form_email => 'Àdírẹ́sì ímẹ́lì';

  @override
  String get form_password => 'Ọ̀rọ̀ aṣínà';

  @override
  String get form_showPassword => 'Fi ọ̀rọ̀ aṣínà hàn';

  @override
  String get form_hidePassword => 'Fi ọ̀rọ̀ aṣínà pamọ́';

  @override
  String get form_passwordMin =>
      '8 sí 72 báìtì UTF-8. Àwọn àmì kan gba ju báìtì kan lọ.';

  @override
  String get form_firstName => 'Orúkọ àkọ́kọ́';

  @override
  String get form_lastName => 'Orúkọ ìdílé';

  @override
  String get form_phone => 'Fóònù (+33612345678)';

  @override
  String get form_address => 'Àdírẹ́sì';

  @override
  String get form_address2 => 'Àfikún àdírẹ́sì (kò ṣe dandan)';

  @override
  String get form_postalCode => 'Kóòdù ìfìwéránṣẹ́';

  @override
  String get form_city => 'Ìlú';

  @override
  String get form_country => 'Kóòdù orílẹ̀-èdè (fún àpẹẹrẹ FR)';

  @override
  String get action_login => 'Wọlé';

  @override
  String get action_createAccount => 'Ṣẹ̀dá àkántì';

  @override
  String get action_createMyAccount => 'Ṣẹ̀dá àkántì mi';

  @override
  String get action_next => 'Tẹ̀síwájú';

  @override
  String get action_previous => 'Padà';

  @override
  String get action_forgotPassword => 'Ṣé ẹ ti gbàgbé ọ̀rọ̀ aṣínà?';

  @override
  String get auth_noAccount => 'Ẹ ò tíì ní àkántì?';

  @override
  String get auth_requiredInformation => 'Ẹ ṣẹ̀dá àkántì yín ní ìgbésẹ̀ mẹ́ta.';

  @override
  String get auth_termsPrefix => 'Mo gbà ';

  @override
  String get auth_termsLink => 'àwọn ìlànà lílo';

  @override
  String get auth_privacyPrefix => 'Mo gbà ';

  @override
  String get auth_privacyLink => 'ìlànà ìpamọ́';

  @override
  String get auth_consentRequired =>
      'Ìfọwọ́sí yín ni a nílò láti ṣẹ̀dá àkántì.';

  @override
  String get validation_required => 'Pápá yìí jẹ́ dandan.';

  @override
  String get validation_email => 'Ẹ tẹ̀ àdírẹ́sì ímẹ́lì tó tọ́ wọlé.';

  @override
  String get validation_password =>
      'Ọ̀rọ̀ aṣínà kéré jù: ó kéré tán 8 báìtì UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Ọ̀rọ̀ aṣínà gùn jù: kò ju 72 báìtì UTF-8 lọ.';

  @override
  String get validation_phone => 'Ẹ lo ìlànà àgbáyé, fún àpẹẹrẹ +33612345678.';

  @override
  String get validation_country =>
      'Ẹ lo kóòdù orílẹ̀-èdè onílẹ́tà méjì, fún àpẹẹrẹ FR.';

  @override
  String get passwordReset_title => 'Tún ọ̀rọ̀ aṣínà ṣe';

  @override
  String get passwordReset_description =>
      'Ẹ tẹ̀ àdírẹ́sì ímẹ́lì àkántì yín wọlé láti béèrè ìjápọ̀ ìtúnṣe ọ̀rọ̀ aṣínà.';

  @override
  String get passwordReset_send => 'Fi ìjápọ̀ ránṣẹ́';

  @override
  String get connection_title => 'Àsopọ̀ yín';

  @override
  String get connection_subtitle => 'Ẹ yan ibi kan, lẹ́yìn náà ẹ tan VPN yín.';

  @override
  String get connection_prepare => 'Ṣé ẹ ti ṣetán láti sopọ̀?';

  @override
  String get connection_advancedOptions => 'Àwọn àṣàyàn ìlọsíwájú';

  @override
  String get connection_location => 'Ibi';

  @override
  String get connection_chooseLocation => 'Yan ibi kan';

  @override
  String get connection_protocol => 'Ìlànà';

  @override
  String get connection_connect => 'Sopọ̀';

  @override
  String get connection_connecting => 'Ń sopọ̀…';

  @override
  String get connection_disconnect => 'Gé àsopọ̀';

  @override
  String get connection_disconnecting => 'Ń gé àsopọ̀';

  @override
  String get connection_locationChange => 'Ń yí ibi padà…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol kò sí';
  }

  @override
  String get connection_activeLocation => 'Ibi tí a ń lò lọ́wọ́';

  @override
  String get connection_duration => 'Àkókò àsopọ̀';

  @override
  String get connection_received => 'Tí a gbà';

  @override
  String get connection_sent => 'Tí a ránṣẹ́';

  @override
  String get connection_lastHandshake => 'Pàṣípààrọ̀ ààbò tó kẹ́yìn';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration sẹ́yìn';
  }

  @override
  String get verification_title => 'Ẹ jẹ́rìí sí àdírẹ́sì ímẹ́lì yín';

  @override
  String get verification_message =>
      'Ẹ jẹ́rìí sí àdírẹ́sì ímẹ́lì yín láti lo VPN lórí fóònù yìí.';

  @override
  String get verification_resend => 'Tún ímẹ́lì ránṣẹ́';

  @override
  String get migration_title => 'Yíyí ibi padà';

  @override
  String get migration_draining => 'Ń múra láti yí ibi padà…';

  @override
  String get migration_activating => 'Ń mú olùpín tuntun ṣiṣẹ́…';

  @override
  String get migration_ready => 'A ti ṣe ìmúdójúìwọ̀n ibi náà.';

  @override
  String get migration_blocked =>
      'Yíyí ibi padà nílò ìdásí olùpín. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀ tàbí kí ẹ kàn sí ẹgbẹ́ atìlẹ́yìn.';

  @override
  String get migration_progress => 'Ìlọsíwájú yíyí ibi padà';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Ìdádúró láàárín àyẹ̀wò: $seconds ìṣẹ́jú àáyá.';
  }

  @override
  String get migration_resume => 'Tẹ̀síwájú yíyí ibi padà';

  @override
  String get status_authorizing => 'A nílò ìyọ̀ǹda';

  @override
  String get status_authorizingDetail =>
      'Ẹ gbà ìbéèrè Android láti jẹ́ kí VPN ṣiṣẹ́.';

  @override
  String get status_preparing => 'Ń múra sílẹ̀';

  @override
  String get status_preparingDetail => 'Ń múra àsopọ̀ ààbò yín sílẹ̀.';

  @override
  String get status_reconnecting => 'Ń tún sopọ̀…';

  @override
  String get status_reconnectingDetail =>
      'Àsopọ̀ ti dáwọ́ dúró. VPN ń gbìyànjú láti tún sopọ̀.';

  @override
  String get status_connecting => 'Ń sopọ̀';

  @override
  String get status_connectingDetail => 'Ń sopọ̀ mọ́ olùpín VPN…';

  @override
  String get status_connected => 'Ti sopọ̀';

  @override
  String get status_connectedDetail => 'Àsopọ̀ VPN yín ń ṣiṣẹ́.';

  @override
  String get status_disconnecting => 'Ń gé àsopọ̀';

  @override
  String get status_disconnectingDetail => 'Àsopọ̀ VPN yín ń dúró.';

  @override
  String get status_error => 'Àsopọ̀ kò sí';

  @override
  String get status_errorDetail =>
      'A kò tíì jẹ́rìí sí àsopọ̀ VPN. Ẹ tún gbìyànjú.';

  @override
  String get status_idle => 'Ti gé àsopọ̀';

  @override
  String get status_idleDetail => 'Ẹ sopọ̀ mọ́ VPN láti dáàbò bo àsopọ̀ yín.';

  @override
  String get trust_note =>
      'Pípa ohun èlò náà kò dá VPN dúró. Láti dá a dúró, ẹ lo Gé àsopọ̀.';

  @override
  String get locations_none => 'Kò sí ibi kankan tí a lè lò lọ́wọ́lọ́wọ́.';

  @override
  String get locations_available => 'Ẹ yan ibi tí ẹ fẹ́ lò tókàn.';

  @override
  String get locations_selected => 'Ibi tí a yàn';

  @override
  String get locations_select => 'Yan ibi yìí';

  @override
  String get locations_lockedTunnel => 'Ẹ gé àsopọ̀ VPN láti yí ibi padà.';

  @override
  String get locations_lockedMigration =>
      'Ẹ dúró títí yíyí ibi padà yóò fi parí.';

  @override
  String get devices_title => 'Àwọn ẹ̀rọ yín';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ẹ̀rọ';
  }

  @override
  String get devices_refresh => 'Sọdọ̀tun àwọn ẹ̀rọ';

  @override
  String get devices_empty => 'Kò tíì sí ẹ̀rọ VPN tí a forúkọsílẹ̀ síbẹ̀.';

  @override
  String get devices_firstConnection =>
      'A ó ṣàfikún fóònù yín nígbà àsopọ̀ àkọ́kọ́.';

  @override
  String get devices_thisDevice => 'Ẹ̀rọ yìí';

  @override
  String devices_added(Object date) {
    return 'A ṣàfikún rẹ̀ ní $date';
  }

  @override
  String get devices_unnamed => 'Ẹ̀rọ láìní orúkọ';

  @override
  String get action_remove => 'Yọ kúrò';

  @override
  String get settings_title => 'Ìṣètò';

  @override
  String get settings_subtitle =>
      'Àwọn ohun tí ẹ fẹ́ àti àkántì yín, gbogbo rẹ̀ ní ibì kan.';

  @override
  String get settings_appearance => 'Ìrísí';

  @override
  String get settings_language => 'Èdè';

  @override
  String get settings_languageDescription =>
      'Èdè tí ẹ yàn náà ni a ó lò fún àwọn ìfitónilétí VPN.';

  @override
  String get settings_account => 'Àkántì';

  @override
  String get settings_signOut => 'Jáde';

  @override
  String get settings_privacy => 'Ìlànà ìpamọ́';

  @override
  String get settings_terms => 'Àwọn ìlànà lílo';

  @override
  String get settings_security => 'Ààbò àti ìṣípayá';

  @override
  String get settings_licenses => 'Ìwé-àṣẹ àwọn èròjà';

  @override
  String get settings_licensesDetail => 'Sọ́fítíwia tí a lò nínú ohun èlò náà';

  @override
  String settings_licensesLegalese(String url) {
    return 'Kóòdù orísun ohun èlò náà àti àwọn èròjà MPL-2.0 rẹ̀: $url';
  }

  @override
  String get settings_background =>
      'VPN máa ń wà lórí nígbà tí ẹ bá fi ohun èlò náà sílẹ̀. Láti dá a dúró, ẹ lo Gé àsopọ̀ nínú táàbù Àsopọ̀.';

  @override
  String get theme_system => 'Ti ẹ̀rọ';

  @override
  String get theme_light => 'Ìmọ́lẹ̀';

  @override
  String get theme_dark => 'Òkùnkùn';

  @override
  String get language_system => 'Èdè fóònù';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Ṣé ẹ fẹ́ yọ ẹ̀rọ yìí kúrò?';

  @override
  String get dialog_removeCurrent =>
      'Fóònù yìí yóò gé àsopọ̀ VPN, yóò sì pàdánù ìwọlé. A ó yọ dátà àsopọ̀ VPN rẹ̀ kúrò lẹ́yìn tí olùpín bá jẹ́rìí sí i.';

  @override
  String dialog_removeOther(Object name) {
    return 'A ó fagilé ìwọlé VPN fún “$name”. Ìgbésẹ̀ yìí kò ṣeé dá padà.';
  }

  @override
  String get dialog_signOut => 'Ṣé ẹ fẹ́ jáde?';

  @override
  String get dialog_signOutMessage =>
      'VPN yóò dúró, ẹ ó sì nílò láti wọlé lẹ́ẹ̀kan sí i. Àwọn kọ́kọ́rọ́ VPN yín tí a fi ìkọ̀kọ̀ pamọ́ yóò wà lórí fóònù yìí fún àsopọ̀ tó tẹ̀lé.';

  @override
  String get action_cancel => 'Fagilé';

  @override
  String get action_close => 'Tì';

  @override
  String get action_copy => 'Dàkọ';

  @override
  String get action_renew => 'Sọdọ̀tun';

  @override
  String get action_signOut => 'Jáde';

  @override
  String get notice_close => 'Pa ìfiránṣẹ́ yìí';

  @override
  String get notice_sessionExpired_title => 'Ìgbà ìwọlé ti parí';

  @override
  String get notice_sessionExpired_message =>
      'Ìgbà ìwọlé yín ti parí. Ẹ wọlé lẹ́ẹ̀kan sí i.';

  @override
  String get notice_connectionFailed_title => 'Àsopọ̀ kùnà';

  @override
  String get notice_invalidCredentials_message =>
      'Àdírẹ́sì ímẹ́lì tàbí ọ̀rọ̀ aṣínà kò tọ̀nà.';

  @override
  String get notice_emailVerification_title => 'A nílò ìjẹ́rìísí ímẹ́lì';

  @override
  String get notice_emailVerification_message =>
      'Ẹ jẹ́rìí sí àdírẹ́sì ímẹ́lì yín kí ẹ tó ṣàfikún ẹ̀rọ VPN.';

  @override
  String get notice_rateLimited_title => 'Ìgbìyànjú pọ̀ jù';

  @override
  String get notice_deviceLimit_title => 'Iye ẹ̀rọ ti dé ààlà';

  @override
  String get notice_deviceLimit_message =>
      'Ẹ yọ ẹ̀rọ kan tó wà tẹ́lẹ̀ kúrò kí ẹ tó ṣàfikún òmíràn.';

  @override
  String get notice_identityRenewal_title => 'Ìdánimọ̀ VPN nílò ìsọdọ̀tun';

  @override
  String get notice_identityRenewal_message =>
      'A ti yọ ìdánimọ̀ yìí kúrò. Ẹ ṣẹ̀dá ìdánimọ̀ tuntun lórí ẹ̀rọ yìí.';

  @override
  String get notice_migrationPending_title => 'Yíyí ibi padà ń lọ lọ́wọ́';

  @override
  String get notice_migrationPending_message =>
      'Yíyí ibi padà kan ti ń lọ lọ́wọ́ tẹ́lẹ̀.';

  @override
  String get notice_migrationBlocked_title => 'Yíyí ibi padà ti dí';

  @override
  String get notice_migrationBlocked_message =>
      'Yíyí ibi padà nílò ìdásí olùpín. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀ tàbí kí ẹ kàn sí ẹgbẹ́ atìlẹ́yìn.';

  @override
  String get notice_targetUnavailable_title => 'Olùpín kò sí fún ìgbà díẹ̀';

  @override
  String get notice_targetUnavailable_message =>
      'Olùpín yìí kò sí fún ìgbà díẹ̀.';

  @override
  String get notice_networkUnavailable_title => 'Àsopọ̀ Íńtánẹ́ẹ̀tì kò sí';

  @override
  String get notice_networkUnavailable_message =>
      'Ẹ ṣàyẹ̀wò àsopọ̀ yín, lẹ́yìn náà ẹ tún gbìyànjú.';

  @override
  String get notice_permissionDenied_title => 'A kọ̀ ìyọ̀ǹda VPN';

  @override
  String get notice_permissionDenied_message =>
      'Ẹ tún bẹ̀rẹ̀ àsopọ̀ náà, kí ẹ sì gbà ìbéèrè ìyọ̀ǹda Android.';

  @override
  String get notice_wireguardTimeout_title => 'Olùpín kò dáhùn';

  @override
  String get notice_wireguardTimeout_message =>
      'Àsopọ̀ WireGuard gba àkókò jù. Ẹ tún gbìyànjú tàbí ẹ yan ibi mìíràn.';

  @override
  String get notice_tlsFailed_title => 'A kọ̀ àsopọ̀ ààbò';

  @override
  String get notice_tlsFailed_message =>
      'Olùpín kò gba àsopọ̀ OpenVPN. Ẹ tún gbìyànjú. Tí ìṣòro náà bá tún wà, ẹ ṣe àyẹ̀wò.';

  @override
  String get notice_tunRejected_title => 'Android kọ̀ atọ́kun VPN';

  @override
  String get notice_tunRejected_message =>
      'Android kọ̀ ìṣètò nẹ́tíwọ́ọ̀kì tí OpenVPN béèrè.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN kò lè bẹ̀rẹ̀';

  @override
  String get notice_openvpnStart_message =>
      'Ẹ́ńjìnnì OpenVPN kò lè parí bíbẹ̀rẹ̀. Ẹ tún gbìyànjú. Tí ìṣòro náà bá tún wà, ẹ kàn sí ẹgbẹ́ atìlẹ́yìn.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kóòdù àyẹ̀wò: $code';
  }

  @override
  String get notice_generic_title => 'Àsopọ̀ VPN kùnà';

  @override
  String get notice_generic_message =>
      'Àṣìṣe kan ṣẹlẹ̀. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'A ti ṣẹ̀dá àkántì',
      'password_reset_sent': 'A ti gba ìbéèrè ìtúnṣe ọ̀rọ̀ aṣínà',
      'verification_email_sent': 'A ti fi ímẹ́lì ìjẹ́rìísí ránṣẹ́',
      'location_migration_pending': 'Yíyí ibi padà ń lọ lọ́wọ́',
      'vpn_sign_in_required': 'A nílò ìwọlé',
      'protocol_unavailable_at_location': 'Ìlànà kò sí',
      'vpn_permission_denied': 'A kọ̀ ìyọ̀ǹda VPN',
      'revoked_identity_device_limit': 'Iye ẹ̀rọ ti dé ààlà',
      'tunnel_start_unexpected': 'VPN kò lè bẹ̀rẹ̀',
      'flutter_disconnect_timeout': 'A kò jẹ́rìí sí gígé àsopọ̀',
      'flutter_disconnect_unexpected': 'A kò lè gé àsopọ̀',
      'device_revoked': 'A ti yọ ẹ̀rọ kúrò',
      'revoke_unexpected': 'A kò lè yọ ẹ̀rọ kúrò',
      'identity_renewal_unexpected': 'A kò lè ṣe ìsọdọ̀tun ìdánimọ̀',
      'openvpn_renewal_unexpected': 'A kò lè ṣe ìsọdọ̀tun OpenVPN',
      'location_migration_blocked': 'Yíyí ibi padà ti dí',
      'location_migration_slow': 'Yíyí ibi padà ṣì ń lọ lọ́wọ́',
      'location_migration_conflict': 'Yíyí ibi padà nílò ìsọdọ̀tun',
      'location_migration_verification_failed': 'A kò jẹ́rìí sí yíyí ibi padà',
      'location_migration_device_changed': 'Ẹ̀rọ yípadà nígbà yíyí ibi padà',
      'tunnel_stop_failed': 'Yíyí ibi padà kò sí',
      'device_clock_ahead': 'Aago ẹ̀rọ ti yára ju',
      'other': 'Iṣẹ́ kùnà',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'A ti ṣẹ̀dá àkántì náà, ṣùgbọ́n a kò lè fi ímẹ́lì ìjẹ́rìísí ránṣẹ́. Ẹ lo “Tún ímẹ́lì ránṣẹ́” nínú ohun èlò náà.',
      'password_reset_sent':
          'A ti gba ìbéèrè yín. Tí àkántì kan bá bá àdírẹ́sì yìí mu, ẹ lè gba ímẹ́lì kan. Ẹ jọ̀wọ́, ẹ ṣàyẹ̀wò àpótí ìfiránṣẹ́ àìfẹ́ yín pẹ̀lú.',
      'verification_email_sent':
          'A ti fi ímẹ́lì ìjẹ́rìísí tuntun ránṣẹ́ báyìí.',
      'location_migration_pending':
          'Yíyí ibi padà sí $target ṣì wà ní ìmúrasílẹ̀. Ẹ lè tẹ̀síwájú pẹ̀lú rẹ̀ láìtún ẹ̀rọ náà ṣẹ̀dá.',
      'vpn_sign_in_required': 'Ẹ wọlé sí àkántì yín kí ẹ tó bẹ̀rẹ̀ VPN.',
      'protocol_unavailable_at_location':
          'Ìlànà tí ẹ yàn kò sí ní ibi yìí. Ẹ sọdọ̀tun àwọn ibi tàbí kí ẹ yan ìlànà mìíràn.',
      'vpn_permission_denied':
          'Android kọ̀ ìyọ̀ǹda VPN. Ẹ tún bẹ̀rẹ̀ àsopọ̀ náà kí ẹ sì gbà ìbéèrè ètò náà.',
      'revoked_identity_device_limit':
          'A ti yọ ìwọlé VPN ẹ̀rọ yìí kúrò, iye ẹ̀rọ sì ti dé ààlà. Ẹ yọ ẹ̀rọ kan kúrò lábẹ́ Àkántì → Ṣàkóso àwọn ẹ̀rọ mi.',
      'tunnel_start_unexpected':
          'Àṣìṣe tí a kò retí dá ìmúrasílẹ̀ ọ̀nà ìsopọ̀ dúró. Ẹ ṣàyẹ̀wò kóòdù àyẹ̀wò náà, kí ẹ sì tún gbìyànjú.',
      'flutter_disconnect_timeout':
          'Android kò jẹ́rìí sí pé VPN dúró ní àkókò tó yẹ. Ẹ tún gbìyànjú láti dá a dúró.',
      'flutter_disconnect_unexpected':
          'Àṣìṣe tí a kò retí dènà ìjẹ́rìísí pé ọ̀nà ìsopọ̀ ti dúró.',
      'device_revoked':
          'A ti fagilé ìwọlé VPN ẹ̀rọ náà, a sì ti yọ àwọn àṣírí rẹ̀ tó wà lórí ẹ̀rọ kúrò.',
      'revoke_unexpected':
          'A kò lè yọ ẹ̀rọ náà kúrò. Ẹ sọdọ̀tun àtòjọ, kí ẹ sì tún gbìyànjú.',
      'identity_renewal_unexpected':
          'A kò lè ṣẹ̀dá ìdánimọ̀ VPN tuntun. Ẹ sọdọ̀tun àwọn ẹ̀rọ, kí ẹ sì tún gbìyànjú.',
      'openvpn_renewal_unexpected':
          'A kò lè ṣe ìsọdọ̀tun pírófáìlì OpenVPN. Ẹ tún gbìyànjú tàbí ẹ ṣàyẹ̀wò kóòdù àyẹ̀wò náà.',
      'location_migration_blocked':
          'Olùpín kò lè parí ìyípadà yìí ní báyìí. A ti pa ẹ̀rọ náà àti ìdánimọ̀ rẹ̀ lórí ẹ̀rọ mọ́.',
      'location_migration_slow':
          'Olùpín ṣì ń múra yíyí ibi padà sí $target. Ẹ lo Tẹ̀síwájú lẹ́yìn àkókò díẹ̀.',
      'location_migration_conflict':
          'Ipò ẹ̀rọ yípadà lórí olùpín. Ẹ sọdọ̀tun àwọn ẹ̀rọ, lẹ́yìn náà ẹ tẹ̀síwájú pẹ̀lú yíyí ibi padà.',
      'location_migration_verification_failed':
          'Olùpín kò jẹ́rìí sí ibi tuntun náà. A ti pa ìdánimọ̀ àtijọ́ tó wà lórí ẹ̀rọ mọ́.',
      'location_migration_device_changed':
          'Ẹ̀rọ tí olùpín dá padà kò bá èyí tí a ń yí mu mọ́. Ẹ sọdọ̀tun àwọn ẹ̀rọ kí ẹ tó tún gbìyànjú.',
      'tunnel_stop_failed':
          'Ọ̀nà ìsopọ̀ tó wà tẹ́lẹ̀ gbọ́dọ̀ dúró pátápátá kí àsopọ̀ tuntun tó lè bẹ̀rẹ̀.',
      'device_clock_ahead':
          'Ó dàbí pé aago ẹ̀rọ yìí ti yára jù. Ẹ tan ọjọ́ àti àkókò aládàáṣe kí ẹ lè máa wà ní ìwọlé.',
      'other':
          'A kò lè parí iṣẹ́ náà. Ẹ tún gbìyànjú tàbí ẹ fi kóòdù àyẹ̀wò ránṣẹ́ sí ẹgbẹ́ atìlẹ́yìn.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Ìgbà ìwọlé ti parí',
      'invalid_credentials': 'Wíwọlé kùnà',
      'email_verification_required': 'A nílò ìjẹ́rìísí ímẹ́lì',
      'verification_email_cooldown': 'A ti fi ímẹ́lì ránṣẹ́ tẹ́lẹ̀',
      'rate_limited': 'Ìgbìyànjú pọ̀ jù',
      'invalid_registration': 'Ìsọfúnni nílò àtúnṣe',
      'email_exists': 'Àkántì ti wà tẹ́lẹ̀',
      'invalid_profile': 'Ìsọfúnni ara ẹni kò tọ̀nà',
      'invalid_device': 'Ẹ̀rọ kò tọ̀nà',
      'invalid_location': 'Ibi kò sí',
      'device_limit': 'Iye ẹ̀rọ ti dé ààlà',
      'device_exists': 'Ìdánimọ̀ VPN ti wà ní lílò',
      'device_identity_revoked': 'Ìdánimọ̀ VPN nílò ìsọdọ̀tun',
      'device_location_locked': 'Yíyí ibi padà nílò ìsọdọ̀tun',
      'location_migration_pending': 'Yíyí ibi padà ń lọ lọ́wọ́',
      'location_migration_blocked': 'Yíyí ibi padà ti dí',
      'target_ca_mismatch': 'Olùpín OpenVPN kò báramu',
      'location_migration_conflict': 'Yíyí ibi padà nílò ìsọdọ̀tun',
      'server_full': 'Olùpín ti kún',
      'capacity_unavailable': 'Ibi kò sí fún ìgbà díẹ̀',
      'target_unavailable': 'Olùpín kò sí fún ìgbà díẹ̀',
      'not_found': 'A kò rí nǹkan náà',
      'invalid_openvpn_csr': 'Ìdánimọ̀ OpenVPN kò tọ̀nà',
      'openvpn_profile_exists': 'Pírófáìlì OpenVPN ti wà tẹ́lẹ̀',
      'openvpn_profile_revoked': 'A ti fagilé pírófáìlì OpenVPN',
      'openvpn_operation_pending': 'Iṣẹ́ OpenVPN ń lọ lọ́wọ́',
      'openvpn_operation_terminal': 'Iṣẹ́ OpenVPN ti dáwọ́ dúró',
      'openvpn_address_unavailable': 'Àdírẹ́sì OpenVPN kò sí',
      'openvpn_profile_conflict': 'Ìforígbárí OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN kò sí',
      'email_delivery_unavailable': 'Ímẹ́lì kò sí',
      'invalid_token': 'Ìjápọ̀ kò tọ̀nà',
      'network_unavailable': 'Àsopọ̀ Íńtánẹ́ẹ̀tì kò sí',
      'invalid_json': 'Ìbéèrè kò tọ̀nà',
      'invalid_api_response': 'Ìdáhùn olùpín kò tọ̀nà',
      'ipv6_unavailable': 'IPv6 kò sí',
      'invalid_ip_families': 'A kọ̀ ìṣètò nẹ́tíwọ́ọ̀kì',
      'other': 'Iṣẹ́ kò sí',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Ìgbà ìwọlé yín ti parí. Ẹ tún wọlé.',
      'invalid_credentials': 'Àdírẹ́sì ímẹ́lì tàbí ọ̀rọ̀ aṣínà kò tọ̀nà.',
      'email_verification_required':
          'Ẹ jẹ́rìí sí àdírẹ́sì ímẹ́lì yín kí ẹ tó ṣàfikún ẹ̀rọ VPN.',
      'invalid_registration':
          'Ẹ ṣàyẹ̀wò àwọn ìsọfúnni àti ìfọwọ́sí tí a béèrè.',
      'email_exists': 'Àkántì kan ti lo àdírẹ́sì ímẹ́lì yìí tẹ́lẹ̀.',
      'invalid_profile': 'Ẹ ṣàyẹ̀wò ìsọfúnni ara ẹni yín.',
      'invalid_device': 'Orúkọ tàbí ìdánimọ̀ ẹ̀rọ yìí kò tọ̀nà.',
      'invalid_location': 'Ẹ sọdọ̀tun àtòjọ ibi, lẹ́yìn náà ẹ tún gbìyànjú.',
      'device_limit': 'Ẹ yọ ẹ̀rọ tó wà tẹ́lẹ̀ kúrò kí ẹ tó ṣàfikún òmíràn.',
      'device_exists': 'Ìdánimọ̀ VPN yìí ti so mọ́ àkántì mìíràn.',
      'device_identity_revoked':
          'A ti yọ ìdánimọ̀ yìí kúrò. A gbọ́dọ̀ ṣẹ̀dá ìdánimọ̀ tuntun lórí ẹ̀rọ yìí.',
      'device_location_locked':
          'Ibi ẹ̀rọ yìí ti yípadà báyìí. Ohun èlò náà yóò tẹ̀síwájú pẹ̀lú ìyípadà tí ń lọ lọ́wọ́.',
      'location_migration_pending': 'Yíyí ibi padà kan ti ń lọ lọ́wọ́ tẹ́lẹ̀.',
      'location_migration_blocked':
          'Yíyí ibi padà nílò ìdásí olùpín. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀ tàbí kí ẹ kàn sí ẹgbẹ́ atìlẹ́yìn.',
      'target_ca_mismatch':
          'Olùpín yìí kò tíì báramu pẹ̀lú pírófáìlì OpenVPN tí a ń lò lọ́wọ́.',
      'location_migration_conflict':
          'Ẹ sọdọ̀tun àwọn ẹ̀rọ, lẹ́yìn náà ẹ tún gbìyànjú yíyí ibi padà.',
      'server_full':
          'Ibi yìí ti dé ààlà àsopọ̀ rẹ̀. Ẹ yan ibi mìíràn tàbí ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
      'capacity_unavailable':
          'A kò lè jẹ́rìí sí bóyá ibi yìí wà ní báyìí. Ẹ yan ibi mìíràn tàbí ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
      'target_unavailable': 'Olùpín yìí kò sí fún ìgbà díẹ̀.',
      'not_found': 'Nǹkan yìí kò sí lórí àkántì yín mọ́.',
      'invalid_openvpn_csr':
          'Ẹ ṣẹ̀dá ìdánimọ̀ OpenVPN tuntun, lẹ́yìn náà ẹ tún gbìyànjú.',
      'openvpn_profile_exists':
          'Pírófáìlì OpenVPN kan ti wà fún ẹ̀rọ yìí tẹ́lẹ̀.',
      'openvpn_profile_revoked':
          'Ẹ sọ pírófáìlì OpenVPN di tuntun láti tẹ̀síwájú.',
      'openvpn_operation_pending':
          'Ìyípadà náà ṣì ń tàn káàkiri. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
      'openvpn_operation_terminal':
          'Ẹ ṣẹ̀dá ìdánimọ̀ OpenVPN tuntun, lẹ́yìn náà ẹ tún gbìyànjú.',
      'openvpn_address_unavailable':
          'Kò sí àdírẹ́sì OpenVPN tó wà ní àkókò yìí.',
      'openvpn_profile_conflict':
          'Pírófáìlì ti yípadà. Ẹ sọdọ̀tun àwọn ẹ̀rọ, lẹ́yìn náà ẹ tún gbìyànjú.',
      'openvpn_signer_unavailable': 'Iṣẹ́ OpenVPN kò sí fún ìgbà díẹ̀.',
      'email_delivery_unavailable':
          'A kò lè fi ímẹ́lì ránṣẹ́. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
      'invalid_token':
          'Ìjápọ̀ yìí kò tọ̀nà tàbí ó ti parí. Ẹ béèrè ìjápọ̀ tuntun.',
      'network_unavailable':
          'Ẹ ṣàyẹ̀wò àsopọ̀ Íńtánẹ́ẹ̀tì yín, lẹ́yìn náà ẹ tún gbìyànjú.',
      'invalid_json':
          'Ẹ ṣàyẹ̀wò ìsọfúnni tí ẹ tẹ̀ wọlé, lẹ́yìn náà ẹ tún gbìyànjú.',
      'invalid_api_response':
          'Olùpín dáhùn lọ́nà tí a kò retí. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
      'ipv6_unavailable':
          'Olùpín kò lè mú IPv6 ṣiṣẹ́ lásìkò yìí. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
      'invalid_ip_families':
          'Ìṣètò ọ̀nà ìsopọ̀ ààbò kò pé, tàbí kò bá àwọn àdírẹ́sì tí a fọwọ́sí mu. Ẹ tún gbìyànjú láti inú ohun èlò náà.',
      'other': 'Àṣìṣe kan wáyé lórí olùpín. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Ẹ tún gbìyànjú lẹ́yìn àkókò díẹ̀.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Ẹ tún gbìyànjú lẹ́yìn $seconds ìṣẹ́jú àáyá.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ẹ tún gbìyànjú lẹ́yìn $minutes ìṣẹ́jú.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Ẹ tún gbìyànjú lẹ́yìn $hours wákàtí.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Ìtẹ̀síwájú VPN ti ẹ̀rọ kò sí',
      'system_vpn_resume_corrupt': 'Ìtẹ̀síwájú VPN kò tọ́',
      'system_vpn_resume_session_invalid': 'Ìgbà ìtẹ̀síwájú VPN kò wúlò',
      'system_vpn_resume_identity_changed': 'Ìdánimọ̀ VPN ti yípadà',
      'system_vpn_resume_identity_invalid': 'Ìdánimọ̀ ìtẹ̀síwájú VPN kò tọ́',
      'system_vpn_resume_storage_failed': 'Ibi ìpamọ́ ìtẹ̀síwájú VPN kò sí',
      'system_vpn_resume_network_timeout': 'Ìtẹ̀síwájú VPN kò ní nẹ́tíwọ́ọ̀kì',
      'system_vpn_resume_blocked': 'Ìtẹ̀síwájú VPN ti dí',
      'system_vpn_resume_failed': 'Ìtẹ̀síwájú VPN kùnà',
      'system_vpn_resume_error_invalid': 'Àṣìṣe ìtẹ̀síwájú VPN kò tọ́',
      'wireguard_identity_store_failed': 'A kò fi ìdánimọ̀ WireGuard pamọ́',
      'wireguard_identity_unavailable': 'Ìdánimọ̀ WireGuard kò sí',
      'vpn_host_destroyed': 'Olùgbàlejò VPN Android ti dúró',
      'vpn_host_unavailable': 'Olùgbàlejò VPN Android kò sí',
      'openvpn_renewal_required': 'A nílò ìsọdọ̀tun ìwé-ẹ̀rí OpenVPN',
      'openvpn_recovery_failed': 'Ìmúpadàbọ̀sípò OpenVPN kùnà',
      'openvpn_recovery_exhausted': 'A ti lo ìmúpadàbọ̀sípò OpenVPN tẹ́lẹ̀',
      'vpn_permission_required': 'A nílò ìyọ̀ǹda VPN',
      'vpn_permission_denied': 'A kọ̀ ìyọ̀ǹda VPN',
      'vpn_permission_request_failed': 'A kò lè béèrè ìyọ̀ǹda',
      'wireguard_foreground_service_unavailable': 'Iṣẹ́ WireGuard kò sí',
      'wireguard_identity_invalid': 'Kọ́kọ́rọ́ WireGuard orí ẹ̀rọ kò tọ́',
      'wireguard_identity_in_use': 'Ìdánimọ̀ WireGuard ti wà ní lílò',
      'wireguard_configuration_invalid': 'Ìṣètò WireGuard kò tọ́',
      'wireguard_operation_pending': 'Iṣẹ́ WireGuard ṣì ń ṣiṣẹ́',
      'wireguard_start_failed': 'A kọ̀ ìbẹ̀rẹ̀ WireGuard',
      'wireguard_stop_timeout': 'A kò jẹ́rìí sí ìdúró WireGuard',
      'wireguard_handshake_timeout': 'WireGuard kò dáhùn',
      'openvpn_connection_timeout': 'OpenVPN kò dáhùn',
      'openvpn_core_unavailable': 'Ẹ́ńjìnnì OpenVPN kò sí',
      'openvpn_operation_pending': 'Ìgbà ìwọlé OpenVPN ṣì ń ṣiṣẹ́',
      'openvpn_stop_timeout': 'A kò jẹ́rìí sí ìdúró OpenVPN',
      'openvpn_profile_unavailable': 'Pírófáìlì OpenVPN orí ẹ̀rọ kò sí',
      'openvpn_native_failed': 'Ìpè OpenVPN ti ẹ̀rọ dáwọ́ dúró',
      'openvpn_key_generation_failed': 'A kò lè ṣẹ̀dá kọ́kọ́rọ́ OpenVPN P-256',
      'openvpn_csr_generation_failed': 'A kò lè ṣẹ̀dá CSR OpenVPN',
      'openvpn_identity_store_failed': 'A kò fi ìdánimọ̀ OpenVPN pamọ́',
      'openvpn_identity_clear_failed': 'Yíyọ OpenVPN kúrò kò pé',
      'openvpn_identity_in_use': 'Ìdánimọ̀ OpenVPN ṣì wà ní lílò',
      'openvpn_tls_verification_required': 'Ìjẹ́rìísí TLS OpenVPN kò sí',
      'openvpn_cipher_invalid': 'Álgọ́rídímù ìkọ̀kọ̀ OpenVPN kò tọ́',
      'openvpn_profile_rejected': 'A kọ̀ pírófáìlì OpenVPN',
      'openvpn_identity_inconsistent': 'Ìdánimọ̀ OpenVPN kò báramu',
      'tls_handshake_failed': 'A kọ̀ ìdúnàádúrà OpenVPN',
      'tls_alert_unknown_ca': 'A kò dá ìwé-ẹ̀rí oníbàárà OpenVPN mọ̀',
      'tls_alert_bad_certificate': 'A kọ̀ ìwé-ẹ̀rí oníbàárà OpenVPN',
      'tls_alert_unsupported_certificate': 'Ìwé-ẹ̀rí OpenVPN kò ní àtìlẹ́yìn',
      'tls_client_certificate_required': 'A nílò ìwé-ẹ̀rí oníbàárà OpenVPN',
      'tls_alert_misc': 'Ìkìlọ̀ TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Ìbuwọ́lù OpenVPN kò ní àtìlẹ́yìn',
      'tls_handshake_rejected': 'A kọ̀ ìdúnàádúrà TLS OpenVPN',
      'tls_version_rejected': 'Ẹ̀dà TLS OpenVPN kò báramu',
      'tls_certificate_expired': 'Ìwé-ẹ̀rí TLS ti parí',
      'tls_certificate_revoked': 'A ti fagilé ìwé-ẹ̀rí TLS',
      'transport_failed': 'Olùpín OpenVPN kò ṣeé dé',
      'tun_configuration_rejected': 'A kò lè ṣẹ̀dá atọ́kun OpenVPN',
      'tun_setup_failed': 'Ìṣètò TUN OpenVPN kùnà',
      'tun_interface_create_failed': 'Ṣíṣẹ̀dá atọ́kun OpenVPN kùnà',
      'tun_interface_disabled': 'A ti pa atọ́kun OpenVPN',
      'tun_halted': 'Atọ́kun OpenVPN ti dáwọ́ dúró',
      'tun_already_established': 'Atọ́kun OpenVPN ti ṣí tẹ́lẹ̀',
      'tun_addresses_missing': 'Àdírẹ́sì OpenVPN kò sí',
      'tun_routes_missing': 'Ipa ọ̀nà OpenVPN kò sí',
      'tun_dns_missing': 'DNS OpenVPN kò sí',
      'tun_permission_revoked': 'A ti fagilé ìyọ̀ǹda VPN',
      'tun_establish_returned_null': 'Android kọ̀ atọ́kun VPN',
      'openvpn_service_start_failed': 'Iṣẹ́ OpenVPN kò sí',
      'openvpn_operation_timeout': 'Ìpè OpenVPN ti kọjá àkókò',
      'openvpn_start_failed': 'A kọ̀ ìbẹ̀rẹ̀ OpenVPN',
      'openvpn_connection_failed': 'Àsopọ̀ OpenVPN ti dáwọ́ dúró',
      'openvpn_core_status_error': 'OpenVPN Core parí pẹ̀lú àṣìṣe',
      'openvpn_stopped_before_connected': 'OpenVPN dúró kí ó tó sopọ̀',
      'openvpn_auth_failed': 'A kọ̀ ìjẹ́rìísí OpenVPN',
      'openvpn_client_setup_failed': 'Ìṣètò ẹ̀rọ oníbàárà OpenVPN kùnà',
      'openvpn_client_halted': 'Ẹ̀rọ oníbàárà OpenVPN dáwọ́ dúró',
      'openvpn_client_restart': 'A béèrè àtúnbẹ̀rẹ̀ OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN ti pẹ́ jù láìṣiṣẹ́',
      'openvpn_session_expired': 'Ìgbà ìwọlé OpenVPN ti parí',
      'openvpn_credentials_required': 'Ìjẹ́rìísí OpenVPN kò ní àtìlẹ́yìn',
      'openvpn_proxy_failed': 'Ìrìnnà agbedeméjì OpenVPN kùnà',
      'openvpn_compression_failed': 'A kọ̀ ìfúnpọ̀ OpenVPN',
      'openvpn_ntlm_crypto_unavailable': 'Ìfi ìkọ̀kọ̀ pamọ́ NTLM OpenVPN kò sí',
      'openvpn_feature_unsupported': 'Ẹ̀yà ìlò OpenVPN kò ní àtìlẹ́yìn',
      'network_unavailable': 'Àsopọ̀ Íńtánẹ́ẹ̀tì kò sí',
      'network_lost': 'Nẹ́tíwọ́ọ̀kì kò sí',
      'certificate_validation_failed': 'A kọ̀ ìwé-ẹ̀rí olùpín',
      'openvpn_certificate_expired': 'Ìwé-ẹ̀rí OpenVPN ti parí',
      'tunnel_active_for_another_account':
          'Ọ̀nà ìsopọ̀ ààbò àkántì mìíràn ṣì ń ṣiṣẹ́',
      'tunnel_already_active': 'Ọ̀nà ìsopọ̀ ààbò ti ń ṣiṣẹ́ tẹ́lẹ̀',
      'tunnel_stop_timeout': 'A kò jẹ́rìí sí ìdúró $protocol',
      'tunnel_disconnected': '$protocol ti dáwọ́ dúró',
      'native_bridge_unavailable': 'Afárá Android kò sí',
      'native_operation_failed': 'Iṣẹ́ Android dáwọ́ dúró',
      'invalid_arguments': 'Àwọn pàrámítà VPN kò pé',
      'invalid_account_id': 'Àkántì VPN kò tọ́',
      'invalid_device_id': 'Ìdánimọ̀ ẹ̀rọ kò tọ́',
      'storage_key_not_allowed': 'A kọ̀ kọ́kọ́rọ́ ìpamọ́',
      'secure_storage_read_failed': 'Kíkà láti ibi ìpamọ́ ààbò kùnà',
      'secure_storage_write_failed': 'Kíkọ sí ibi ìpamọ́ ààbò kùnà',
      'key_generation_failed': 'A kò lè ṣẹ̀dá kọ́kọ́rọ́ WireGuard',
      'csr_generation_failed': 'A kò lè ṣẹ̀dá CSR OpenVPN',
      'other': 'Àṣìṣe VPN ti ẹ̀rọ tí a kò tíì pín sí ẹ̀ka',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android kò rí ìgbà ìwọlé VPN tó lè tẹ̀síwájú. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun nínú ohun èlò náà.',
      'system_vpn_resume_corrupt':
          'Ìsọfúnni ìtẹ̀síwájú VPN tí a fi pamọ́ kò tọ́, a kò sì ní lò ó. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'system_vpn_resume_session_invalid':
          'Ìgbà ìwọlé tí a fi pamọ́ kò lè mú VPN tẹ̀síwájú mọ́. Ẹ tún wọlé nínú ohun èlò náà.',
      'system_vpn_resume_identity_changed':
          'Ìdánimọ̀ VPN orí ẹ̀rọ ti yípadà. A dá ìtẹ̀síwájú dúró; ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'system_vpn_resume_identity_invalid':
          'Ìdánimọ̀ fún ìtẹ̀síwájú kò tọ́. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'system_vpn_resume_storage_failed':
          'Android kò lè kà tàbí ṣe ìmúdójúìwọ̀n ìsọfúnni ìtẹ̀síwájú tí a fi ìkọ̀kọ̀ pamọ́. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'system_vpn_resume_network_timeout':
          'Android kò rí nẹ́tíwọ́ọ̀kì ní àkókò láti mú VPN tẹ̀síwájú. Ẹ tún gbìyànjú nígbà tí nẹ́tíwọ́ọ̀kì bá wà.',
      'system_vpn_resume_blocked':
          'Ìtẹ̀síwájú VPN ti dí. Ẹ ṣàyẹ̀wò ìṣètò Android, lẹ́yìn náà ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'system_vpn_resume_failed':
          'Ìtẹ̀síwájú VPN Android kùnà. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun nínú ohun èlò náà.',
      'system_vpn_resume_error_invalid':
          'Android dá àṣìṣe ìtẹ̀síwájú tí kò ṣeé lò padà. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'wireguard_identity_store_failed':
          'Android kò lè fi ìdánimọ̀ WireGuard àkántì yìí pamọ́ láàbò.',
      'wireguard_identity_unavailable':
          'Kò sí ìdánimọ̀ WireGuard tó wúlò fún àsopọ̀ yìí.',
      'vpn_host_destroyed':
          'Èròjà Android tó ń gbà VPN lálejò ti dúró. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun.',
      'vpn_host_unavailable':
          'Android kò lè ṣẹ̀dá èròjà tó ń gbà VPN lálejò. Ẹ tún gbìyànjú lẹ́yìn tí ẹ bá ti ṣàyẹ̀wò ìṣètò VPN.',
      'openvpn_renewal_required':
          'Ìsọdọ̀tun aládàáṣe ti ìwé-ẹ̀rí OpenVPN kùnà. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun nínú ohun èlò náà.',
      'openvpn_recovery_failed':
          'Ìmúpadàbọ̀sípò aládàáṣe kùnà. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun nínú ohun èlò náà.',
      'openvpn_recovery_exhausted':
          'A ti lo ìmúpadàbọ̀sípò aládàáṣe tẹ́lẹ̀. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun nínú ohun èlò náà.',
      'vpn_permission_required':
          'Android nílò ìyọ̀ǹda VPN tuntun kí ó tó bẹ̀rẹ̀ ọ̀nà ìsopọ̀ ààbò.',
      'vpn_permission_denied':
          'Ẹ gba FuzeVPN láyè nínú ìbéèrè Android láti tẹ̀síwájú.',
      'vpn_permission_request_failed': 'Android kò lè ṣí ìbòjú ìyọ̀ǹda VPN.',
      'wireguard_foreground_service_unavailable':
          'Android kò lè jẹ́ kí iṣẹ́ WireGuard wà ní iwájú.',
      'wireguard_identity_invalid':
          'Kọ́kọ́rọ́ WireGuard tí a fi láàbò pamọ́ fún àkántì yìí kò ṣeé kà tàbí kò tọ́.',
      'wireguard_identity_in_use':
          'Iṣẹ́ mìíràn ṣì ń lo kọ́kọ́rọ́ WireGuard àkántì yìí.',
      'wireguard_configuration_invalid':
          'Àdírẹ́sì, DNS, kọ́kọ́rọ́ olùpín tàbí ipa ọ̀nà WireGuard tí a gbà kò tọ́.',
      'wireguard_operation_pending':
          'Iṣẹ́ WireGuard tó ṣáájú kò tíì tú iṣẹ́ ẹ̀rọ rẹ̀ sílẹ̀.',
      'wireguard_start_failed':
          'Ẹ́ńjìnnì WireGuard kọ̀ láti mú ìṣètò náà ṣiṣẹ́.',
      'wireguard_stop_timeout':
          'Iṣẹ́ WireGuard kò jẹ́rìí sí ìtúsílẹ̀ atọ́kun VPN láàárín àkókò tí a fi lélẹ̀.',
      'wireguard_handshake_timeout':
          'Ọ̀nà ìsopọ̀ ààbò kò jẹ́rìí sí ìdúnàádúrà pẹ̀lú olùpín ní àkókò.',
      'openvpn_connection_timeout':
          'OpenVPN kò jẹ́rìí sí àsopọ̀ pẹ̀lú olùpín ní àkókò.',
      'openvpn_core_unavailable':
          'Ẹ̀dà ohun èlò yìí kò ní ẹ́ńjìnnì OpenVPN tó wúlò.',
      'openvpn_operation_pending':
          'Ẹ́ńjìnnì ẹ̀rọ ṣì ń mú ìgbà ìwọlé OpenVPN tó ṣáájú, ó sì kọ̀ láti ṣẹ̀dá ọ̀kan mìíràn.',
      'openvpn_stop_timeout':
          'OpenVPN Core kò jẹ́rìí sí pé ìgbà ìwọlé rẹ̀ ti dúró àti pé a ti pa á run láàárín àkókò tí a fi lélẹ̀.',
      'openvpn_profile_unavailable':
          'Kò sí pírófáìlì OpenVPN tí a fọwọ́sí tí a lè kà fún àsopọ̀ yìí.',
      'openvpn_native_failed':
          'Àṣìṣe ohun èlò dá OpenVPN dúró. Ẹ tún gbìyànjú láti sopọ̀. Tí ìṣòro náà bá tẹ̀síwájú, ẹ ṣe àyẹ̀wò ìṣòro.',
      'openvpn_key_generation_failed':
          'Android Keystore kò lè ṣẹ̀dá tàbí kà kọ́kọ́rọ́ ìkọ̀kọ̀ P-256 tí a kò lè kó jáde.',
      'openvpn_csr_generation_failed':
          'Kọ́kọ́rọ́ Android Keystore kò lè buwọ́lù ìbéèrè ìwé-ẹ̀rí OpenVPN.',
      'openvpn_identity_store_failed':
          'A kò lè fi ìwé-ẹ̀rí tàbí pírófáìlì OpenVPN pamọ́ sínú ibi ìpamọ́ tí a fi ìkọ̀kọ̀ pamọ́.',
      'openvpn_identity_clear_failed':
          'Android kò lè yọ gbogbo ìdánimọ̀ OpenVPN orí ẹ̀rọ fún àkántì yìí kúrò.',
      'openvpn_identity_in_use':
          'Ìgbà ìwọlé OpenVPN ti ẹ̀rọ ṣì ń lo kọ́kọ́rọ́ tàbí ìwé-ẹ̀rí ẹ̀rọ yìí.',
      'openvpn_tls_verification_required':
          'Pírófáìlì kò béèrè ìjẹ́rìísí ìwé-ẹ̀rí olùpín ní kedere.',
      'openvpn_cipher_invalid':
          'Olùpín pèsè álgọ́rídímù ìkọ̀kọ̀ tí kò sí nínú àtòjọ tí a gbà láàyè.',
      'openvpn_profile_rejected':
          'Pírófáìlì tí olùpín fi ránṣẹ́ kò báramu. Ẹ tún ẹ̀rọ yìí ṣẹ̀dá, kí ẹ sì tún gbìyànjú.',
      'openvpn_identity_inconsistent':
          'Ìwé-ẹ̀rí kò bá ìdánimọ̀ láàbò ti fóònù yìí mu. A kò rọ́pò pírófáìlì orí ẹ̀rọ kankan.',
      'tls_handshake_failed':
          'Olùpín kọ̀ ìdúnàádúrà TLS. Ẹ tún pírófáìlì ṣẹ̀dá tí ìṣòro náà bá ń bá a nìṣó.',
      'tls_alert_unknown_ca':
          'Olùpín kò mọ aláṣẹ ìwé-ẹ̀rí ẹ̀rọ yìí. A gbọ́dọ̀ ṣàyẹ̀wò olùpín OpenVPN.',
      'tls_alert_bad_certificate':
          'Olùpín kọ̀ ìwé-ẹ̀rí ẹ̀rọ yìí. Ẹ tún ẹ̀rọ yìí ṣẹ̀dá kí ẹ tó tún gbìyànjú.',
      'tls_alert_unsupported_certificate':
          'Olùpín kò ṣe àtìlẹ́yìn fún irú ìwé-ẹ̀rí aláàbò tí Android ń lò.',
      'tls_client_certificate_required':
          'Olùpín nílò ìwé-ẹ̀rí oníbàárà, ṣùgbọ́n OpenVPN Core kò lè fi ọ̀kan hàn.',
      'tls_alert_misc':
          'Olùpín dá ìkìlọ̀ TLS padà tí kò sí nínú ẹ̀ka ìwé-ẹ̀rí àti ẹ̀dà.',
      'tls_signature_algorithm_rejected':
          'Olùpín kọ̀ álgọ́rídímù ECDSA P-256 ti kọ́kọ́rọ́ Android Keystore.',
      'tls_handshake_rejected':
          'Olùpín dá ìdúnàádúrà TLS dúró kí àsopọ̀ tó wáyé.',
      'tls_version_rejected': 'Oníbàárà àti olùpín kò rí ẹ̀dà TLS kan náà.',
      'tls_certificate_expired': 'Ìwé-ẹ̀rí tí a fihàn nígbà àsopọ̀ ti parí.',
      'tls_certificate_revoked':
          'A ti fagilé ìwé-ẹ̀rí tí a fihàn nígbà àsopọ̀.',
      'transport_failed':
          'Olùpín OpenVPN kò dáhùn lórí nẹ́tíwọ́ọ̀kì tó wà lọ́wọ́ yìí. Ẹ tún gbìyànjú láìpẹ́.',
      'tun_configuration_rejected':
          'Android kọ̀ ìṣètò nẹ́tíwọ́ọ̀kì tí OpenVPN béèrè.',
      'tun_setup_failed':
          'OpenVPN Core kọ̀ ètò nẹ́tíwọ́ọ̀kì kí ó tó ṣẹ̀dá atọ́kun Android.',
      'tun_interface_create_failed':
          'OpenVPN Core kò lè rí atọ́kun TUN gbà láti ọ̀dọ̀ VpnService Android.',
      'tun_interface_disabled':
          'Android tàbí OpenVPN Core pa atọ́kun TUN nígbà àsopọ̀.',
      'tun_halted': 'OpenVPN Core gba ìbéèrè láti dá atọ́kun TUN dúró.',
      'tun_already_established':
          'OpenVPN béèrè atọ́kun kejì nínú àsopọ̀ kan náà. A dá ọ̀nà ìsopọ̀ ààbò dúró fún ààbò.',
      'tun_addresses_missing':
          'Olùpín kò pèsè àdírẹ́sì ọ̀nà ìsopọ̀ ààbò tó wúlò.',
      'tun_routes_missing': 'Olùpín kò pèsè ipa ọ̀nà tó wúlò fún àsopọ̀ ààbò.',
      'tun_dns_missing': 'Olùpín kò pèsè DNS tó wúlò.',
      'tun_permission_revoked': 'Android fagilé ìyọ̀ǹda VPN nígbà àsopọ̀.',
      'tun_establish_returned_null':
          'Android kò ṣẹ̀dá atọ́kun náà, ó sábà máa ń jẹ́ nítorí pé VPN mìíràn ṣì ń ṣiṣẹ́.',
      'openvpn_service_start_failed':
          'Android kò lè bẹ̀rẹ̀ iṣẹ́ OpenVPN ní iwájú.',
      'openvpn_operation_timeout':
          'Ìpè JNI sí OpenVPN Core kọjá àkókò tó pọ̀ jùlọ rẹ̀.',
      'openvpn_start_failed':
          'Iṣẹ́ Android ti ṣetán, ṣùgbọ́n OpenVPN Core kò gbà pé kí a bẹ̀rẹ̀ pírófáìlì náà.',
      'openvpn_connection_failed':
          'OpenVPN Core dúró kí ó tó fi ìṣẹ̀lẹ̀ CONNECTED hàn.',
      'openvpn_core_status_error':
          'Lúùpù OpenVPN ti ẹ̀rọ parí pẹ̀lú àṣìṣe, láìsí ìṣẹ̀lẹ̀ ìparí tó péye jù.',
      'openvpn_stopped_before_connected':
          'Lúùpù OpenVPN ti ẹ̀rọ dúró kí ó tó di CONNECTED, láìsí àṣìṣe Core tó ṣe kedere.',
      'openvpn_auth_failed': 'Olùpín OpenVPN kọ̀ ìjẹ́rìísí pírófáìlì náà.',
      'openvpn_client_setup_failed':
          'OpenVPN Core kò lè múra oníbàárà sílẹ̀ kí àsopọ̀ nẹ́tíwọ́ọ̀kì tó wáyé.',
      'openvpn_client_halted':
          'OpenVPN Core gba ìdúró ìparí láti ọ̀dọ̀ oníbàárà.',
      'openvpn_client_restart':
          'OpenVPN Core béèrè àtúnbẹ̀rẹ̀ ìgbà ìrìnnà rẹ̀.',
      'openvpn_inactive_timeout':
          'OpenVPN Core pa ìgbà ìwọlé náà lẹ́yìn àkókò àìṣiṣẹ́ tí a fi lélẹ̀.',
      'openvpn_session_expired': 'Olùpín sọ pé ìgbà ìwọlé OpenVPN ti parí.',
      'openvpn_credentials_required':
          'Olùpín tàbí pírọ́ọ̀kìsì béèrè ẹ̀rí ìwọlé lọ́wọ́ oníbàárà, èyí tí kò sí nínú pírófáìlì ìwé-ẹ̀rí yìí.',
      'openvpn_proxy_failed':
          'OpenVPN Core sọ pé pírọ́ọ̀kìsì tàbí ibùdó ìfiránṣẹ́ tí a ṣètò kùnà.',
      'openvpn_compression_failed':
          'OpenVPN Core kọ̀ ọ̀nà ìfúnpọ̀ tí pírófáìlì tàbí olùpín kéde.',
      'openvpn_ntlm_crypto_unavailable':
          'Pírófáìlì béèrè ìfi ìkọ̀kọ̀ pamọ́ NTLM tí kò sí nínú ẹ̀dà yìí.',
      'openvpn_feature_unsupported':
          'Pírófáìlì tàbí olùpín nílò ẹ̀yà kan tí kò sí nínú oníbàárà Android yìí.',
      'network_unavailable': 'Kò sí nẹ́tíwọ́ọ̀kì ti ara tó wúlò.',
      'network_lost': 'A dá ọ̀nà ìsopọ̀ ààbò dúró lẹ́yìn tí nẹ́tíwọ́ọ̀kì sọnù.',
      'certificate_validation_failed':
          'A kò lè jẹ́rìí sí ìdánimọ̀ olùpín OpenVPN.',
      'openvpn_certificate_expired':
          'Ìwé-ẹ̀rí OpenVPN ti parí. Ẹ bẹ̀rẹ̀ àsopọ̀ tuntun nínú ohun èlò náà láti sọ ọ́ di tuntun.',
      'tunnel_active_for_another_account':
          'Ọ̀nà ìsopọ̀ ààbò tó jẹ́ ti àkántì mìíràn gbọ́dọ̀ dúró kí àsopọ̀ yìí tó bẹ̀rẹ̀.',
      'tunnel_already_active':
          'Android sọ pé ìgbà ìwọlé VPN tó ṣáájú ṣì ń lo atọ́kun náà.',
      'tunnel_stop_timeout':
          'Ẹ́ńjìnnì $protocol kò jẹ́rìí sí ìtúsílẹ̀ atọ́kun VPN láàárín àkókò tí a fi lélẹ̀.',
      'tunnel_disconnected':
          'Ẹ́ńjìnnì ẹ̀rọ sọ pé ọ̀nà ìsopọ̀ ààbò ti parí lójijì lẹ́yìn tí ó bẹ̀rẹ̀.',
      'native_bridge_unavailable':
          'Ohun èlò náà kò lè wọlé sí iṣẹ́ VPN Android. Ẹ pa ohun èlò náà, ẹ sì tún ṣí i, lẹ́yìn náà ẹ tún gbìyànjú.',
      'native_operation_failed':
          'Àṣìṣe ohun èlò dá iṣẹ́ VPN dúró. Ẹ tún gbìyànjú. Tí ìṣòro náà bá tẹ̀síwájú, ẹ ṣe àyẹ̀wò ìṣòro.',
      'invalid_arguments':
          'Ìsọfúnni tí a nílò fún iṣẹ́ VPN yìí kò pé. Ẹ tún gbìyànjú. Tí ìṣòro náà bá tẹ̀síwájú, ẹ ṣe àyẹ̀wò ìṣòro.',
      'invalid_account_id':
          'Iṣẹ́ ẹ̀rọ yìí kò so mọ́ ìdánimọ̀ àkántì tó wúlò kan.',
      'invalid_device_id':
          'Ìdánimọ̀ ẹ̀rọ tí a fi ránṣẹ́ sí ẹ́ńjìnnì ẹ̀rọ kò sí tàbí kò tọ́.',
      'storage_key_not_allowed':
          'Afárá Android dí kọ́kọ́rọ́ kan tí kò sí nínú àtòjọ ibi ìpamọ́ tí a gbà láàyè.',
      'secure_storage_read_failed':
          'Android Keystore kò lè yọ ìkọ̀kọ̀ kúrò nínú ìsọfúnni orí ẹ̀rọ àkántì yìí.',
      'secure_storage_write_failed':
          'Android Keystore kò lè fi ìkọ̀kọ̀ pamọ́ tàbí tọ́jú ìsọfúnni orí ẹ̀rọ.',
      'key_generation_failed':
          'Android kò lè ṣẹ̀dá tàbí kà kọ́kọ́rọ́ WireGuard nínú ibi ìpamọ́ aláàbò.',
      'csr_generation_failed':
          'Android Keystore kò lè ṣẹ̀dá tàbí buwọ́lù CSR P-256 OpenVPN.',
      'other':
          'Ẹ̀ka ẹ̀rọ kan tí a kò kọ sílẹ̀ kùnà. Ẹ fi kóòdù àyẹ̀wò tí a fihàn nísàlẹ̀ ránṣẹ́ sí ẹgbẹ́ atìlẹ́yìn.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Ìbéèrè ìyọ̀ǹda ti ṣí sílẹ̀';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Ìbéèrè ìyọ̀ǹda VPN Android ti wà lórí ìbòjú. Ẹ parí rẹ̀ kí ẹ tó tún gbìyànjú.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Ìbéèrè ìyọ̀ǹda VPN ti dáwọ́ dúró';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'A pa ìbòjú ìyọ̀ǹda VPN náà kí ohun èlò náà tó gba ìdáhùn.';

  @override
  String get notice_openvpnProofMissing_title =>
      'A kò jẹ́rìí sí àsopọ̀ OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'A kò lè jẹ́rìí sí àsopọ̀ OpenVPN. A dá a dúró fún ààbò. Ẹ tún gbìyànjú.';

  @override
  String get openvpnCleanup_title => 'A ti fagilé pírófáìlì OpenVPN';

  @override
  String get openvpnCleanup_working =>
      'Ń dá OpenVPN dúró, ń sì ń yọ pírófáìlì OpenVPN tí a fagilé kúrò…';

  @override
  String get openvpnCleanup_stopFailed =>
      'A kò tíì jẹ́rìí sí pé OpenVPN ti dúró. Ẹ tún gbìyànjú kí ẹ tó ṣẹ̀dá pírófáìlì tuntun.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'A kò lè yọ pírófáìlì OpenVPN tí a fagilé kúrò pátápátá. Ẹ tún gbìyànjú ìwẹ̀nùmọ́.';

  @override
  String get openvpnCleanup_complete =>
      'A ti yọ pírófáìlì OpenVPN tí a fagilé kúrò. Ẹ tẹ̀ Sopọ̀ láti ṣẹ̀dá òmíràn.';

  @override
  String get network_title => 'Ìṣètò nẹ́tíwọ́ọ̀kì';

  @override
  String get network_ipv4Fallback =>
      'IPv6 kò sí fún ìgbà díẹ̀. Ìmúrasílẹ̀ ń tẹ̀síwájú pẹ̀lú IPv4.';

  @override
  String get network_rejectedTitle => 'A kọ̀ ìṣètò nẹ́tíwọ́ọ̀kì';

  @override
  String get network_rejectedMessage =>
      'Ìṣètò ọ̀nà ìsopọ̀ ààbò kò pé, tàbí kò bá àwọn àdírẹ́sì tí a fọwọ́sí mu. Ẹ tún gbìyànjú láti inú ohun èlò náà.';

  @override
  String get network_unreadableTitle => 'Ìṣètò orí ẹ̀rọ kò ṣeé kà';

  @override
  String get network_unreadableMessage =>
      'A kò lè lo ìṣètò nẹ́tíwọ́ọ̀kì OpenVPN tí a fi pamọ́. Ẹ tún sopọ̀ láti inú ohun èlò náà láti ṣe ìmúdójúìwọ̀n rẹ̀.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ààbò nẹ́tíwọ́ọ̀kì';

  @override
  String get protection_subtitle =>
      'Dènà ìwọlé Íńtánẹ́ẹ̀tì tààrà nígbà tí VPN bá gé àsopọ̀.';

  @override
  String get protection_active => 'Ààbò ètò ń ṣiṣẹ́';

  @override
  String get protection_alwaysOnOnly =>
      'VPN nígbà gbogbo ti ṣiṣẹ́; ẹ tan ìdènà àsopọ̀ láìsí VPN';

  @override
  String get protection_inactive => 'Ààbò ètò kò ṣiṣẹ́';

  @override
  String get protection_unknown => 'Ẹ ṣàyẹ̀wò ààbò ètò';

  @override
  String get protection_openSettings => 'Ṣí ìṣètò Android';

  @override
  String get protection_dialogTitle => 'Ṣètò ààbò nẹ́tíwọ́ọ̀kì';

  @override
  String get protection_dialogMessage =>
      'Android ń ṣàkóso VPN nígbà gbogbo àti dídènà àwọn àsopọ̀ láìsí VPN. Ẹ ṣàyẹ̀wò pé a ti yan FuzeVPN, kí ẹ sì tan dídènà nínú ìṣètò Android.';

  @override
  String get protection_dialogOpen => 'Ṣí ìṣètò';

  @override
  String get session_systemProtectionNote =>
      'Tí Android bá ṣì ń dènà ìrìnnà láìsí VPN, ẹ ṣí ìṣètò Android láti ṣàyẹ̀wò tàbí yí ààbò yìí padà.';

  @override
  String get diagnostics_title => 'Àyẹ̀wò';

  @override
  String get diagnostics_settingsTitle => 'Àyẹ̀wò ohun èlò';

  @override
  String get diagnostics_automaticTitle => 'Fi àwọn àṣìṣe pàtàkì ránṣẹ́';

  @override
  String get diagnostics_automaticDescription =>
      'Pín ìròyìn ìmọ̀ ẹ̀rọ kékeré kan nígbà tí àṣìṣe pàtàkì bá wáyé.';

  @override
  String get diagnostics_privacy =>
      'Àwọn ìròyìn tí a fi ránṣẹ́ so mọ́ àkántì tí ẹ wọlé sí, a sì tọ́jú wọn fún ọjọ́ 30. Wọn kò ní ìtàn ìlọkiri wẹ́ẹ̀bù, ọ̀rọ̀ aṣínà tàbí kọ́kọ́rọ́ VPN nínú.';

  @override
  String get diagnostics_manualOpen => 'Ṣe àyẹ̀wò';

  @override
  String get diagnostics_localDescription =>
      'Ṣẹ̀dá ìròyìn nípa ipò ohun èlò àti VPN. Àsopọ̀ yín kò ní yípadà.';

  @override
  String get diagnostics_sendReport => 'Fi ìròyìn ránṣẹ́';

  @override
  String get diagnostics_sendHint =>
      'Ẹ má ṣe fi àmì sí àpótí yìí láti pa ìròyìn mọ́ sórí ẹ̀rọ yìí.';

  @override
  String get diagnostics_signedOut =>
      'Ẹ wọlé sí àkántì yín láti fi ìròyìn ránṣẹ́.';

  @override
  String get diagnostics_localLifetime =>
      'Ẹ fi ìròyìn yìí pamọ́ sórí fóònù yín láti tọ́jú rẹ̀ lẹ́yìn tí ẹ bá ti pa ohun èlò náà.';

  @override
  String get diagnostics_run => 'Ṣe àyẹ̀wò';

  @override
  String get diagnostics_rerun => 'Ṣe àyẹ̀wò lẹ́ẹ̀kan sí i';

  @override
  String get diagnostics_running => 'Ń ṣàyẹ̀wò…';

  @override
  String get diagnostics_sending => 'Ń fi ìròyìn ránṣẹ́…';

  @override
  String get diagnostics_prepared => 'Ìròyìn ti ṣetán lórí ẹ̀rọ yìí';

  @override
  String get diagnostics_queued => 'Ìròyìn ń dúró láti fi ránṣẹ́';

  @override
  String get diagnostics_sent => 'A ti gba ìròyìn náà';

  @override
  String get diagnostics_failed =>
      'Fífi ìròyìn ránṣẹ́ kùnà. Ìròyìn orí ẹ̀rọ yín ṣì wà.';

  @override
  String get diagnostics_preparationFailed =>
      'A kò lè pèsè ìròyìn àyẹ̀wò náà. Ẹ tún gbìyànjú.';

  @override
  String get diagnostics_authenticationRequired =>
      'Ẹ tún wọlé láti fi ìròyìn ránṣẹ́.';

  @override
  String get diagnostics_retry => 'Tún fi ìròyìn ránṣẹ́';

  @override
  String get diagnostics_export => 'Fi ìròyìn pamọ́';

  @override
  String get diagnostics_exportFailed =>
      'Ìfipamọ́ kùnà. Ẹ tún gbìyànjú láti inú ìròyìn orí ẹ̀rọ.';

  @override
  String get diagnostics_preferenceFailed =>
      'A kò lè fi ìṣètò yìí pamọ́. Ẹ tún gbìyànjú.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Ìtọ́kasí: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'A gbà á ní ọjọ́ $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'A ó tọ́jú rẹ̀ títí di $date';
  }

  @override
  String get diagnostics_duplicate => 'A ti gba ìròyìn yìí tẹ́lẹ̀.';

  @override
  String get diagnostics_preview => 'Àwotẹ́lẹ̀ ìròyìn';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A so ìṣẹ̀lẹ̀ ìmọ̀ ẹ̀rọ $count mọ́',
      one: 'A so ìṣẹ̀lẹ̀ ìmọ̀ ẹ̀rọ kan mọ́',
      zero: 'Kò sí ìṣẹ̀lẹ̀ ìmọ̀ ẹ̀rọ kankan tí a so mọ́',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Àwọn àlàyé ìmọ̀ ẹ̀rọ';

  @override
  String get diagnostics_empty => 'A kò tíì ṣẹ̀dá ìròyìn àyẹ̀wò kankan.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Ipò ọ̀nà ìsopọ̀ ààbò',
      'handshake': 'Ìjẹ́rìísí àsopọ̀',
      'certificate': 'Ìwé-ẹ̀rí VPN',
      'kill_switch': 'Ààbò Android',
      'connectivity': 'Nẹ́tíwọ́ọ̀kì tó wà',
      'api_reachability': 'Ìwọlé sí iṣẹ́',
      'secure_storage': 'Ibi ìpamọ́ ààbò',
      'other': 'Àyẹ̀wò orí ẹ̀rọ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Ti ṣàyẹ̀wò',
      'failed': 'Ó nílò àfiyèsí',
      'skipped': 'A kò dánwò — kò sí ìwádìí tó ń lọ lọ́wọ́',
      'unknown': 'Ìsọfúnni kò sí',
      'other': 'Ìsọfúnni kò sí',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Káàbọ̀ sí FuzeVPN';

  @override
  String get connection_changeLocation => 'Yí ibi padà';

  @override
  String get connection_details => 'Àlàyé nípa àsopọ̀';

  @override
  String get locations_searchLabel => 'Ṣàwárí ìlú tàbí orílẹ̀-èdè';

  @override
  String get locations_clearSearch => 'Pa ìṣàwárí rẹ́';

  @override
  String get locations_filterAll => 'Gbogbo';

  @override
  String get locations_filterFavorites => 'Àwọn àyànfẹ́';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ibi',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'A kò rí ibi kankan';

  @override
  String get locations_noResultsHint =>
      'Ẹ gbìyànjú ìlú tàbí orílẹ̀-èdè mìíràn.';

  @override
  String get locations_noFavorites => 'Àwọn àyànfẹ́ yín, ní ìkáwọ́ yín';

  @override
  String get locations_noFavoritesHint =>
      'Ẹ tẹ̀ ìràwọ̀ tó wà lẹ́gbẹ̀ẹ́ ibi kan láti fi pamọ́ síbí.';

  @override
  String get locations_showAll => 'Wo gbogbo ibi';

  @override
  String locations_addFavorite(String name) {
    return 'Fi $name kún àwọn àyànfẹ́';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Yọ $name kúrò nínú àwọn àyànfẹ́';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'A kò lè fi àyànfẹ́ pamọ́. Ẹ tún gbìyànjú.';

  @override
  String get locations_emptyTitle => 'Kò sí ibi kankan';

  @override
  String get locations_emptyHint => 'Ẹ sọdọ̀tun àtòjọ náà láti tún gbìyànjú.';

  @override
  String get devices_manage => 'Ṣàkóso àwọn ẹ̀rọ mi';

  @override
  String get settings_personalization => 'Ṣe é tiyín';

  @override
  String get settings_safety => 'Ààbò';

  @override
  String get settings_help => 'Ṣé ẹ nílò ìrànlọ́wọ́?';

  @override
  String get settings_about => 'Nípa FuzeVPN';

  @override
  String get diagnostics_heading => 'Lóye ìṣòro àsopọ̀';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Ó wà',
      'pending': 'Ń múra sílẹ̀',
      'revoked': 'A ti yọ kúrò',
      'expired': 'Ó ti parí',
      'other': 'Ipò kò sí',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'A kò fi àṣàyàn pamọ́';

  @override
  String get notice_preferenceSave_message =>
      'Àṣàyàn yín ti ń ṣiṣẹ́ báyìí, ṣùgbọ́n a kò lè fi pamọ́. Ẹ tún gbìyànjú láti tọ́jú rẹ̀ lẹ́yìn tí ẹ bá ti pa ohun èlò náà.';

  @override
  String get connection_androidDisconnectHint =>
      'Tí Android bá ń jẹ́ kí VPN wà lórí, ẹ pa VPN nígbà gbogbo nínú ìṣètò tí ó ṣí.';

  @override
  String get connection_certificate => 'Ìwé-ẹ̀rí OpenVPN';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Ó wúlò títí di $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Ó parí ní $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Yóò sọdọ̀tun fúnra rẹ̀ nígbà àsopọ̀ tó kàn.';

  @override
  String get protection_learnMore => 'Kọ́ nípa ààbò Android';

  @override
  String get protection_guideWhy =>
      'Ààbò yìí dènà àwọn ohun èlò láti lo Íńtánẹ́ẹ̀tì tààrà nígbà tí VPN bá gé àsopọ̀. A ṣètò rẹ̀ nínú Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN nígbà gbogbo';

  @override
  String get protection_guideAlwaysOn =>
      'Android ń jẹ́ kí iṣẹ́ VPN máa ṣiṣẹ́ nígbà gbogbo, ó sì lè tún un bẹ̀rẹ̀ lẹ́yìn tí fóònù bá tún bẹ̀rẹ̀.';

  @override
  String get protection_guideBlockTitle => 'Dènà àsopọ̀ láìsí VPN';

  @override
  String get protection_guideBlock =>
      'Ìṣètò yìí dènà ìrìnnà láti yẹra fún VPN, pẹ̀lú nígbà tí àsopọ̀ bá dáwọ́ dúró.';

  @override
  String get protection_guideWarning =>
      'Nígbà tí ìdènà yìí bá ń ṣiṣẹ́, Íńtánẹ́ẹ̀tì yóò wà ní pípa títí VPN yóò fi sopọ̀.';

  @override
  String get protection_guideStepsTitle => 'Mú ààbò ṣiṣẹ́';

  @override
  String get protection_guideStep1 =>
      'Ẹ ṣí ìṣètò VPN Android nípa lílo bọ́tìnì tó wà nísàlẹ̀.';

  @override
  String get protection_guideStep2 =>
      'Ẹ ṣí àwọn àṣàyàn nípa àmì ìṣètò (kẹ̀kẹ́ eyín) tó wà lẹ́gbẹ̀ẹ́ FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Ẹ tan “VPN nígbà gbogbo”, lẹ́yìn náà ẹ tan “Dènà àsopọ̀ láìsí VPN”, tí àwọn àṣàyàn wọ̀nyí bá wà.';

  @override
  String get protection_guideManufacturers =>
      'Orúkọ máa ń yàtọ̀ lórí fóònù kọ̀ọ̀kan. Tí ó bá pọn dandan, ẹ ṣàwárí VPN nínú Ìṣètò, tí ó sábà máa ń wà lábẹ́ Nẹ́tíwọ́ọ̀kì àti Íńtánẹ́ẹ̀tì.';

  @override
  String get protection_guideDisableTitle => 'Pa ààbò yìí';

  @override
  String get protection_guideDisable =>
      'Nínú ìṣètò kan náà, ẹ pa ìdènà láìsí VPN kí ẹ lè lo Íńtánẹ́ẹ̀tì láìsí VPN. Ẹ tún pa VPN nígbà gbogbo bí ẹ kò bá fẹ́ kí Android tún un bẹ̀rẹ̀ mọ́.';

  @override
  String get protection_guideManual =>
      'Ẹ̀yin ni ẹ máa yan àwọn ìṣètò wọ̀nyí nínú Android. FuzeVPN kò yí wọn padà fún yín.';

  @override
  String get locations_changeTitle => 'Yí ibi padà?';

  @override
  String locations_changeActive(String name) {
    return 'VPN yóò gé àsopọ̀, lẹ́yìn náà yóò gbìyànjú láti sopọ̀ mọ́ $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN yóò gbìyànjú láti sopọ̀ mọ́ $name.';
  }

  @override
  String get locations_confirmChange => 'Yí padà, kí ẹ sì sopọ̀';

  @override
  String get locations_changeBusy =>
      'Yíyí ibi padà ń lọ lọ́wọ́. Ẹ dúró kí ẹ tó yan ibi mìíràn.';

  @override
  String get locations_automaticSelection => 'Yíyàn aládàáṣe';

  @override
  String get locations_cities => 'Àwọn ìlú';

  @override
  String get locations_servers => 'Àwọn olùpín';

  @override
  String locations_viewCities(String name) {
    return 'Wo àwọn ìlú ní $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Wo àwọn olùpín ní $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count orílẹ̀-èdè',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ìlú',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count olùpín',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Gbogbo orílẹ̀-èdè';

  @override
  String get locations_backToCountries => 'Padà sí àwọn orílẹ̀-èdè';

  @override
  String locations_backToCities(String name) {
    return 'Padà sí àwọn ìlú ní $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Yan $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Yan $name';
  }

  @override
  String get locations_noCompatibleServer => 'Kò sí olùpín tó báramu.';

  @override
  String get externalLink_failed =>
      'A kò lè ṣí ìjápọ̀ yìí. Ẹ lè dàkọ rẹ̀, kí ẹ sì ṣí i nínú aṣàwákiri yín.';

  @override
  String get externalLink_copy => 'Dàkọ ìjápọ̀';

  @override
  String get externalLink_copied => 'A ti dàkọ ìjápọ̀ náà';

  @override
  String get externalLink_copyFailed =>
      'A kò lè dàkọ ìjápọ̀ náà. Ẹ yan àdírẹ́sì tó wà nísàlẹ̀.';

  @override
  String get settings_deleteAccount => 'Parẹ́ àkántì mi';

  @override
  String get settings_deleteAccountDetail =>
      'Wo ìlànà ìbéèrè fún píparẹ́ àkántì';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Ẹ yan ìforúkọsílẹ̀ VPN yín.';

  @override
  String get billing_subscribe => 'Forúkọsílẹ̀';

  @override
  String get billing_choosePlan => 'Ẹ yan ètò láti tẹ̀síwájú.';

  @override
  String get billing_monthly => 'Oṣooṣù';

  @override
  String get billing_yearly => 'Ọdọọdún';

  @override
  String get billing_continue => 'Tẹ̀síwájú pẹ̀lú Google Play';

  @override
  String get billing_restore => 'Mú àwọn ohun tí a rà padà';

  @override
  String get billing_manage => 'Ṣàkóso ìforúkọsílẹ̀';

  @override
  String get billing_deleteAccountWarning =>
      'Tí ẹ bá ní ìforúkọsílẹ̀ Google Play, píparẹ́ àkántì FuzeVPN yín kò ní fagilé ìsọdọ̀tun rẹ̀. Ẹ ṣàkóso tàbí fagilé ìsọdọ̀tun náà lọ́tọ̀ọ̀tọ̀ nínú Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Tẹ̀síwájú sí ìbéèrè píparẹ́ àkántì';

  @override
  String get billing_refresh => 'Sọdọ̀tun àǹfààní';

  @override
  String get billing_loadingPlans => 'Ń gbé àwọn ètò wá…';

  @override
  String get billing_unavailable =>
      'Kò sí ètò kankan lásìkò yìí. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.';

  @override
  String get billing_comingSoon => 'Ìforúkọsílẹ̀ yóò wà láìpẹ́.';

  @override
  String get billing_priceDisclosure =>
      'Google Play ni ó pèsè iye owó náà. A ó jẹ́rìí sí iye ìkẹyìn àti owó orí tó wúlò kí ẹ tó fọwọ́sí.';

  @override
  String get billing_renewalMonthly =>
      'Ó máa ń sọdọ̀tun fúnra rẹ̀ lóṣooṣù àyàfi tí a bá fagilé. Ẹ lè fagilé nígbàkigbà nínú àwọn ìforúkọsílẹ̀ Google Play.';

  @override
  String get billing_renewalYearly =>
      'Ó máa ń sọdọ̀tun fúnra rẹ̀ lọdọọdún àyàfi tí a bá fagilé. Ẹ lè fagilé nígbàkigbà nínú àwọn ìforúkọsílẹ̀ Google Play.';

  @override
  String get billing_active => 'Àǹfààní Premium yín ń ṣiṣẹ́';

  @override
  String billing_accessUntil(String date) {
    return 'Àǹfààní náà wà títí di $date.';
  }

  @override
  String get billing_webManaged =>
      'Ìforúkọsílẹ̀ yín ni a ń ṣàkóso lórí ojú òpó FuzeVPN.';

  @override
  String get billing_playManaged => 'Google Play ni ń ṣàkóso ìforúkọsílẹ̀ yín.';

  @override
  String get billing_playOnHold =>
      'Ìforúkọsílẹ̀ Google Play yín ti dúró tàbí ó ń dúró de ìsanwó. Ẹ ṣí “Ṣàkóso ìforúkọsílẹ̀” láti ṣàtúnṣe rẹ̀ nínú Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Àkántì Google Play yìí ti ní ìforúkọsílẹ̀ Fuze Premium kan tí kò ṣiṣẹ́ fún àkántì FuzeVPN yìí. Ẹ ṣí “Ṣàkóso ìforúkọsílẹ̀” láti yẹ̀ ẹ́ wò nínú Google Play.';

  @override
  String get billing_inactive => 'Kò sí ìforúkọsílẹ̀ tó ń ṣiṣẹ́.';

  @override
  String get billing_checkingAccess => 'Ń ṣàyẹ̀wò àǹfààní yín…';

  @override
  String get billing_restoring => 'Ń mú àwọn ohun tí a rà padà…';

  @override
  String get billing_pending =>
      'Ìsanwó ń dúró. Àǹfààní yín yóò ṣiṣẹ́ lẹ́yìn ìjẹ́rìísí.';

  @override
  String get billing_cancelled =>
      'A ti fagilé rírà náà. Kò sí ìforúkọsílẹ̀ tuntun tí a mú ṣiṣẹ́.';

  @override
  String get billing_verifying => 'Ń jẹ́rìí sí rírà náà…';

  @override
  String get billing_success =>
      'A ti mú ìforúkọsílẹ̀ ṣiṣẹ́. Àǹfààní Premium yín ti ṣetán.';

  @override
  String get billing_restored => 'A ti mú àwọn ohun tí ẹ rà padà.';

  @override
  String get billing_restoreEmpty =>
      'Kò sí ohun tí a rà láti mú padà fún àkántì Google Play yìí.';

  @override
  String get billing_catalogError => 'A kò lè gbé àwọn ètò wá. Ẹ tún gbìyànjú.';

  @override
  String get billing_purchaseError =>
      'A kò lè bẹ̀rẹ̀ rírà náà. Ẹ tún gbìyànjú.';

  @override
  String get billing_verificationError =>
      'Ìjẹ́rìísí rírà kò sí fún ìgbà díẹ̀. Ẹ mú àwọn ohun tí ẹ rà padà láti tún gbìyànjú.';

  @override
  String get billing_restoreError =>
      'A kò lè mú àwọn ohun tí ẹ rà padà. Ẹ tún gbìyànjú.';

  @override
  String get billing_managementError =>
      'A kò lè ṣí ìṣàkóso ìforúkọsílẹ̀. Ẹ tún gbìyànjú.';

  @override
  String get billing_storeUnavailable => 'Google Play kò sí lórí ẹ̀rọ yìí.';

  @override
  String get welcome_title => 'VPN yín, ní ọ̀nà tó rọrùn.';

  @override
  String get welcome_description =>
      'Ẹ dáàbò bo àsopọ̀ yín. Ẹ máa ṣàkóso ìpamọ́ yín.';

  @override
  String get welcome_start => 'Bẹ̀rẹ̀';

  @override
  String get welcome_alreadyPurchased => 'Ṣé ẹ ti rà tẹ́lẹ̀?';

  @override
  String get welcome_noAccountRequired => 'Kò nílò àkántì láti bẹ̀rẹ̀.';

  @override
  String get guest_accountTitle => 'Àkántì kò tíì so pọ̀';

  @override
  String get guest_accountDescription =>
      'Ẹ mú àwọn ohun tí ẹ rà padà pẹ̀lú àkántì Google Play kan náà láti lo ìforúkọsílẹ̀ yín lórí ẹ̀rọ mìíràn.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Ṣé ẹ ti forúkọsílẹ̀ tẹ́lẹ̀? Wọlé';

  @override
  String get guest_claimTitle => 'Mú FuzeVPN lọ pẹ̀lú yín';

  @override
  String get guest_claimDescription =>
      'Ẹ ṣẹ̀dá àkántì láti lo ìforúkọsílẹ̀ yín lórí àwọn ẹ̀rọ yín yòókù. Ìgbésẹ̀ yìí kì í ṣe dandan.';

  @override
  String get guest_skip => 'Ìgbà mìíràn';

  @override
  String get guest_activationTitle => 'Fuze Premium ti ṣiṣẹ́';

  @override
  String get guest_activationDescription =>
      'Ìforúkọsílẹ̀ yín ti ṣetán. Ẹ lè lo VPN yín, kí ẹ sì ṣẹ̀dá àkántì nígbàkigbà tí ẹ bá fẹ́.';

  @override
  String get guest_useVpn => 'Lo VPN mi';

  @override
  String get guest_loginRequired =>
      'Rírà yìí ti so mọ́ àkántì FuzeVPN kan. Ẹ wọlé sí àkántì yẹn láti lo ìforúkọsílẹ̀ yín.';

  @override
  String get guest_signOutWarning =>
      'Ẹ lè rí ìforúkọsílẹ̀ yín padà nípa mímú àwọn ohun tí ẹ rà padà pẹ̀lú àkántì Google Play kan náà.';

  @override
  String get guest_profileUnavailable =>
      'Àkántì yín ti so pọ̀ tẹ́lẹ̀. Ẹ wọlé láti wo àti ṣàkóso àwọn àlàyé yín.';

  @override
  String get billing_acceptance =>
      'Nípa títẹ̀síwájú, ẹ gba àwọn ìlànà lílo àti ìlànà ìpamọ́.';

  @override
  String get guest_verifyEmailReminder =>
      'Ẹ jẹ́rìí sí àdírẹ́sì ímẹ́lì yín láti dáàbò bo àkántì yín. Ẹ lè máa lo VPN yín.';

  @override
  String get guest_serviceUnavailable =>
      'Iṣẹ́ náà kò sí fún ìgbà díẹ̀. Ẹ tún gbìyànjú láìpẹ́.';

  @override
  String get guest_restoreError =>
      'A kò lè mú àwọn ohun tí ẹ rà padà. Ẹ tún gbìyànjú pẹ̀lú àkántì Google Play tí a lò fún rírà náà.';

  @override
  String get guest_claimSuccess =>
      'A ti ṣẹ̀dá àkántì yín. Ìforúkọsílẹ̀ yín àti àǹfààní VPN yín ṣì wà.';

  @override
  String get guest_emailExists =>
      'Àdírẹ́sì ímẹ́lì yìí ti wà ní lílo tẹ́lẹ̀. Ẹ yan àdírẹ́sì mìíràn tàbí ẹ wọlé sí àkántì tí ẹ ti ní tẹ́lẹ̀. Rírà yín ṣì wà lórí Google Play.';

  @override
  String get guest_claimError =>
      'A kò lè ṣẹ̀dá àkántì yín. Ẹ lè máa lo VPN yín, kí ẹ sì tún gbìyànjú lẹ́yìn ìgbà díẹ̀.';

  @override
  String get guest_secureStorageError =>
      'A kò lè dáàbò bo ìgbà ìwọlé yín lórí ẹ̀rọ yìí. Ẹ tún gbìyànjú.';

  @override
  String get guest_premiumRequired =>
      'Ẹ yan ìforúkọsílẹ̀ láti mú VPN yín ṣiṣẹ́.';

  @override
  String get welcome_viewPlans => 'Wo àwọn ètò';

  @override
  String get google_continue => 'Tẹ̀síwájú pẹ̀lú Google';

  @override
  String get google_or => 'tàbí';

  @override
  String get google_title => 'Àkántì FuzeVPN yín';

  @override
  String get google_settingUp => 'Ẹ parí ṣíṣẹ̀dá àkántì yín';

  @override
  String get google_country => 'Orílẹ̀-èdè ibùgbé';

  @override
  String get google_profileDescription =>
      'Ẹ yan orílẹ̀-èdè yín, kí ẹ sì ṣàyẹ̀wò àwọn ìwé méjèèjì láti ṣẹ̀dá àkántì FuzeVPN yín.';

  @override
  String get google_claimDescription =>
      'Ẹ so àkántì àlejò yín mọ́ Google. Ìforúkọsílẹ̀ àti ẹ̀rọ yín yóò máa wà mọ́ àkántì yìí.';

  @override
  String get google_linkTitle => 'So Google mọ́ FuzeVPN';

  @override
  String get google_linkDescription =>
      'Ẹ jẹ́rìí sí ìwọlé sí àkántì FuzeVPN tí ẹ ti ní tẹ́lẹ̀. Ìgbésẹ̀ yìí kò béèrè ọ̀rọ̀ aṣínà Google yín.';

  @override
  String get google_password => 'Ọ̀rọ̀ aṣínà FuzeVPN';

  @override
  String get google_linkAccount => 'Jẹ́rìí sí àsopọ̀ náà';

  @override
  String get google_requestEmail => 'Fi ímẹ́lì ìjẹ́rìísí ránṣẹ́ sí mi';

  @override
  String get google_emailInstructions =>
      'Ẹ ṣí ímẹ́lì FuzeVPN, kí ẹ sì tẹ̀ kóòdù ìjẹ́rìísí náà wọlé.';

  @override
  String get google_emailCode => 'Kóòdù ìjẹ́rìísí ímẹ́lì';

  @override
  String get google_confirmEmail => 'Jẹ́rìí sí kóòdù náà';

  @override
  String get google_restart => 'Yan àkántì Google mìíràn';

  @override
  String get google_resume => 'Ṣàyẹ̀wò ìgbìyànjú yìí';

  @override
  String get google_unavailable =>
      'Ìwọlé pẹ̀lú Google kò sí. Ẹ lè lo ímẹ́lì àti ọ̀rọ̀ aṣínà.';

  @override
  String get google_expired =>
      'Ìgbìyànjú yìí ti parí. Ẹ fagilé rẹ̀, kí ẹ sì tún bẹ̀rẹ̀.';

  @override
  String get google_conflict =>
      'Àkántì Google yìí ti so pọ̀ ní ibòmíràn. Àkántì àti ìforúkọsílẹ̀ yín lọ́wọ́lọ́wọ́ ṣì wà.';

  @override
  String get google_error =>
      'Ìwọlé pẹ̀lú Google kùnà. Ẹ tún gbìyànjú; àǹfààní yín lọ́wọ́lọ́wọ́ ṣì wà.';

  @override
  String get google_uncertain =>
      'A kò lè jẹ́rìí sí àbájáde náà. Ẹ ṣàyẹ̀wò ìgbìyànjú yìí tàbí ẹ fagilé rẹ̀ kí ẹ tó tún bẹ̀rẹ̀.';

  @override
  String get google_cancelFailed =>
      'A kò lè jẹ́rìí sí ìfagilé náà. Ẹ tún gbìyànjú láti fagilé kí ẹ tó kúrò lórí ìbòjú yìí.';

  @override
  String get google_cancelled => 'A ti fagilé ìwọlé pẹ̀lú Google.';

  @override
  String get google_selecting => 'Ẹ yan àkántì Google yín…';

  @override
  String get google_verifying => 'Ń ṣàyẹ̀wò àkántì yín…';

  @override
  String get google_emailUnavailable =>
      'A kò lè fi ímẹ́lì ìjẹ́rìísí ránṣẹ́. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.';

  @override
  String get google_emailSent =>
      'A ti fi ímẹ́lì ìjẹ́rìísí ránṣẹ́. Ẹ ṣàyẹ̀wò àpótí ímẹ́lì yín.';

  @override
  String get google_rateLimited => 'Ẹ jọ̀wọ́ dúró díẹ̀ kí ẹ tó tún gbìyànjú.';

  @override
  String get google_busy =>
      'Google kò sí nígbà tí iṣẹ́ mìíràn ń lọ lọ́wọ́ (àsopọ̀ VPN, àkántì tàbí àlejò). Ẹ tún gbìyànjú lẹ́yìn tí ó bá parí; àǹfààní yín lọ́wọ́lọ́wọ́ ṣì wà.';

  @override
  String get google_invalidPassword =>
      'Ọ̀rọ̀ aṣínà FuzeVPN kò tọ́. Àkántì yín lọ́wọ́lọ́wọ́ ṣì wà.';

  @override
  String get google_invalidCode =>
      'Kóòdù ìjẹ́rìísí náà kò wúlò tàbí ó ti parí.';

  @override
  String get google_accountChanged =>
      'Ìgbà ìwọlé yín ti yípadà. Ẹ fagilé ìgbìyànjú yìí kí ẹ tó tún bẹ̀rẹ̀.';

  @override
  String get google_invalidResponse =>
      'A kò lè fìdí ìdáhùn náà múlẹ̀. Àǹfààní yín lọ́wọ́lọ́wọ́ ṣì wà.';

  @override
  String get google_invalidRegistration =>
      'Ẹ ṣàyẹ̀wò orílẹ̀-èdè yín àti ìfọwọ́sí méjèèjì.';

  @override
  String get google_consentRequired =>
      'Ẹ yan orílẹ̀-èdè yín, kí ẹ sì gba ìwé méjèèjì láti tẹ̀síwájú.';

  @override
  String get google_challengeRequired =>
      'A nílò àyẹ̀wò ààbò àfikún. Àǹfààní yín lọ́wọ́lọ́wọ́ ṣì wà.';

  @override
  String get google_challengeUnavailable =>
      'Àyẹ̀wò ààbò kò sí. Ẹ tún gbìyànjú lẹ́yìn ìgbà díẹ̀.';

  @override
  String get google_intentMismatch =>
      'Ìgbìyànjú ìwọlé Google tó ṣáájú ṣì ń dúró. Ẹ fagilé rẹ̀ kí ẹ tó bẹ̀rẹ̀ iṣẹ́ yìí.';

  @override
  String get google_challengeBlocked =>
      'Àyẹ̀wò ààbò tí a nílò kò sí nínú ohun èlò yìí. A kò lè parí iṣẹ́ yìí lásìkò yìí.';

  @override
  String get google_solveChallenge => 'Parí àyẹ̀wò ààbò';

  @override
  String get google_challengeTitle => 'Àyẹ̀wò ààbò';

  @override
  String get google_challengeReady =>
      'A ti parí ìjẹ́rìísí. Ẹ lè fọwọ́sí ṣíṣẹ̀dá àkántì yín nísinsìnyí.';

  @override
  String get google_challengeExpired =>
      'Ìjẹ́rìísí náà ti parí. Ẹ parí rẹ̀ lẹ́ẹ̀kan sí i kí ẹ tó fọwọ́sí.';

  @override
  String get google_challengeCancelled =>
      'A ti fagilé ìjẹ́rìísí. Ẹ lè tún gbìyànjú rẹ̀.';

  @override
  String get google_challengeFailed => 'Àyẹ̀wò ààbò kùnà. Ẹ tún gbìyànjú.';

  @override
  String get billing_trialTitle => 'Ẹ gbìyànjú Fuze Premium lọ́fẹ̀ẹ́';

  @override
  String get billing_trialSubtitle => 'Ẹ dáàbò bo àsopọ̀ yín láti òní lọ.';

  @override
  String get billing_trialWeeks => 'Ìdánwò ọ̀fẹ́ ọ̀sẹ̀ méjì';

  @override
  String billing_trialDays(String days) {
    return 'Ìdánwò ọ̀fẹ́ fún ọjọ́ $days';
  }

  @override
  String get billing_trialStart => 'Bẹ̀rẹ̀ ìdánwò ọ̀fẹ́ mi';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Tí ẹ bá bẹ̀rẹ̀ lónìí, a retí pé ìsanwó àkọ́kọ́ yín yóò wáyé ní $date.';
  }

  @override
  String get billing_trialTerms =>
      'Ó máa ń sọdọ̀tun fúnra rẹ̀ ní iye owó tí a sọ. Láti yẹra fún ìsanwó, ẹ fagilé nínú Google Play kí ìdánwò ọ̀fẹ́ tó parí.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Lẹ́yìn náà $price lóṣooṣù';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Lẹ́yìn náà $price lọdọọdún';
  }

  @override
  String get billing_choosePeriod => 'Ẹ yan ètò yín';

  @override
  String get billing_selectionHint => 'Ẹ yan ètò kan láti tẹ̀síwájú.';

  @override
  String get billing_benefitConnection => 'Àsopọ̀ tí a fi ìkọ̀kọ̀ pamọ́';

  @override
  String get billing_benefitPrivacy => 'Ìpamọ́ lórí Íńtánẹ́ẹ̀tì';

  @override
  String get billing_benefitNoAccount => 'Kò nílò àkántì';

  @override
  String get billing_cancellation => 'Fagilé nínú Google Play';

  @override
  String get billing_premiumTitle => 'Àsopọ̀ tó ní ààbò tó dára jù.';

  @override
  String get billing_premiumSubtitle =>
      'Ẹ dáàbò bo àsopọ̀ yín, ní ìyára tiyín.';

  @override
  String get billing_priceMonthly => 'lóṣooṣù';

  @override
  String get billing_priceYearly => 'lọdọọdún';

  @override
  String get billing_trialToday => 'Kò sí owó láti san lónìí';

  @override
  String get billing_trialConfirmation =>
      'Google Play yóò jẹ́rìí sí àwọn ọjọ́, iye ìkẹyìn àti owó orí tó wúlò kí ẹ tó fọwọ́sí.';

  @override
  String get billing_offerChanged =>
      'Àwọn ìlànà ìpèsè yìí ti yípadà. Ẹ sọdọ̀tun àwọn ètò, kí ẹ sì yan lẹ́ẹ̀kan sí i.';

  @override
  String get status_waitingNetwork => 'Ń dúró de nẹ́tíwọ́ọ̀kì';

  @override
  String get status_waitingNetworkDetail =>
      'Kò sí nẹ́tíwọ́ọ̀kì. VPN yóò ṣàyẹ̀wò àsopọ̀ nígbà tí nẹ́tíwọ́ọ̀kì bá padà wá.';

  @override
  String get locations_favoriteLoadFailed =>
      'A kò lè gbé àwọn àyànfẹ́ wá. Ẹ tún gbìyànjú.';

  @override
  String get locations_favoritesLoading => 'Ń gbé àwọn àyànfẹ́ wá…';
}
