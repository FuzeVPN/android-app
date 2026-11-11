// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Linda muunganisho wako';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN hutumia huduma ya VPN ya Android (VpnService) kuunda handaki lililosimbwa kati ya kifaa hiki na seva za FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN inapotumika, trafiki ya intaneti ya programu zako, anwani lengwa na maombi ya DNS hupitia kwenye handaki hili ili kuelekeza muunganisho wako, hata FuzeVPN ikiwa chinichini.';

  @override
  String get vpnDisclosure_statusBody =>
      'Programu hutumia hali ya muunganisho, muda wake na kiasi cha data kilichohamishwa ili kuonyesha muunganisho wako wa VPN. Unaweza kuusimamisha wakati wowote.';

  @override
  String get vpnDisclosure_privacy => 'Faragha';

  @override
  String get vpnDisclosure_accept => 'Kubali na uendelee';

  @override
  String get vpnDisclosure_decline => 'Si sasa';

  @override
  String get accountRestoration_title => 'Akaunti haipatikani kwa muda';

  @override
  String get accountRestoration_message =>
      'Kipindi chako kimehifadhiwa. Jaribu tena ili kurejesha akaunti yako; bado unaweza kudhibiti muunganisho wa VPN hapa.';

  @override
  String get action_retry => 'Jaribu tena';

  @override
  String get session_endingTitle => 'Kumaliza kipindi';

  @override
  String get session_ending =>
      'Inamaliza kipindi: inasimamisha VPN na kusafisha…';

  @override
  String get session_stopFailed =>
      'Kusimamisha VPN hakujathibitishwa. Jaribu tena kabla ya kuingia tena.';

  @override
  String get session_cleanupFailed =>
      'VPN imesimamishwa, lakini kuondolewa kwa kipindi hakujathibitishwa. Jaribu kusafisha tena.';

  @override
  String get session_retryStop => 'Jaribu kusimamisha tena';

  @override
  String get session_retryCleanup => 'Jaribu kusafisha tena';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Inaandaa FuzeVPN kwa usalama…';

  @override
  String get nav_connection => 'Muunganisho';

  @override
  String get nav_locations => 'Maeneo';

  @override
  String get nav_account => 'Akaunti';

  @override
  String get nav_devices => 'Vifaa';

  @override
  String get nav_settings => 'Mipangilio';

  @override
  String get action_refresh => 'Onyesha upya';

  @override
  String get auth_tab_login => 'Ingia';

  @override
  String get auth_tab_register => 'Jisajili';

  @override
  String get auth_stepAccount => 'Akaunti';

  @override
  String get auth_stepIdentity => 'Utambulisho';

  @override
  String get auth_stepAddress => 'Anwani na makubaliano';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Hatua $current kati ya $total';
  }

  @override
  String get auth_tagline => 'VPN yako, kwa urahisi.';

  @override
  String get auth_keysLocal =>
      'Funguo zako za faragha za VPN hubaki kwenye kifaa hiki.';

  @override
  String get form_email => 'Anwani ya barua pepe';

  @override
  String get form_password => 'Nenosiri';

  @override
  String get form_showPassword => 'Onyesha nenosiri';

  @override
  String get form_hidePassword => 'Ficha nenosiri';

  @override
  String get form_passwordMin =>
      'Baiti 8–72 za UTF-8. Baadhi ya herufi hutumia zaidi ya baiti moja.';

  @override
  String get form_firstName => 'Jina la kwanza';

  @override
  String get form_lastName => 'Jina la ukoo';

  @override
  String get form_phone => 'Nambari ya simu (+33612345678)';

  @override
  String get form_address => 'Anwani';

  @override
  String get form_address2 => 'Mstari wa pili wa anwani (hiari)';

  @override
  String get form_postalCode => 'Msimbo wa posta';

  @override
  String get form_city => 'Mji';

  @override
  String get form_country => 'Msimbo wa nchi (kwa mfano FR)';

  @override
  String get action_login => 'Ingia';

  @override
  String get action_createAccount => 'Unda akaunti';

  @override
  String get action_createMyAccount => 'Unda akaunti yangu';

  @override
  String get action_next => 'Endelea';

  @override
  String get action_previous => 'Rudi';

  @override
  String get action_forgotPassword => 'Umesahau nenosiri?';

  @override
  String get auth_noAccount => 'Bado huna akaunti?';

  @override
  String get auth_requiredInformation => 'Unda akaunti yako katika hatua tatu.';

  @override
  String get auth_termsPrefix => 'Ninakubali ';

  @override
  String get auth_termsLink => 'masharti ya matumizi';

  @override
  String get auth_privacyPrefix => 'Ninakubali ';

  @override
  String get auth_privacyLink => 'sera ya faragha';

  @override
  String get auth_consentRequired =>
      'Idhini yako inahitajika ili kuunda akaunti.';

  @override
  String get validation_required => 'Sehemu hii ni ya lazima.';

  @override
  String get validation_email => 'Weka anwani sahihi ya barua pepe.';

  @override
  String get validation_password =>
      'Nenosiri ni fupi mno: angalau baiti 8 za UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Nenosiri ni refu mno: kiwango cha juu ni baiti 72 za UTF-8.';

  @override
  String get validation_phone =>
      'Tumia muundo wa kimataifa, kwa mfano +33612345678.';

  @override
  String get validation_country =>
      'Tumia msimbo wa nchi wa herufi mbili, kwa mfano FR.';

  @override
  String get passwordReset_title => 'Weka upya nenosiri';

  @override
  String get passwordReset_description =>
      'Weka anwani ya barua pepe ya akaunti yako ili kuomba kiungo cha kuweka upya nenosiri.';

  @override
  String get passwordReset_send => 'Tuma kiungo';

  @override
  String get connection_title => 'Muunganisho wako';

  @override
  String get connection_subtitle => 'Chagua eneo, kisha washa VPN yako.';

  @override
  String get connection_prepare => 'Uko tayari kuunganisha?';

  @override
  String get connection_advancedOptions => 'Chaguo za kina';

  @override
  String get connection_location => 'Eneo';

  @override
  String get connection_chooseLocation => 'Chagua eneo';

  @override
  String get connection_protocol => 'Itifaki';

  @override
  String get connection_connect => 'Unganisha';

  @override
  String get connection_connecting => 'Inaunganishwa…';

  @override
  String get connection_disconnect => 'Tenganisha';

  @override
  String get connection_disconnecting => 'Inatenganishwa';

  @override
  String get connection_locationChange => 'Inabadilisha eneo…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol haipatikani';
  }

  @override
  String get connection_activeLocation => 'Eneo linalotumika';

  @override
  String get connection_duration => 'Muda';

  @override
  String get connection_received => 'Imepokelewa';

  @override
  String get connection_sent => 'Imetumwa';

  @override
  String get connection_lastHandshake => 'Mabadilishano salama ya mwisho';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration zilizopita';
  }

  @override
  String get verification_title => 'Thibitisha anwani yako ya barua pepe';

  @override
  String get verification_message =>
      'Thibitisha anwani yako ya barua pepe ili kutumia VPN kwenye simu hii.';

  @override
  String get verification_resend => 'Tuma barua pepe tena';

  @override
  String get migration_title => 'Mabadiliko ya eneo';

  @override
  String get migration_draining => 'Inaandaa mabadiliko ya eneo…';

  @override
  String get migration_activating => 'Inawasha seva mpya…';

  @override
  String get migration_ready => 'Eneo limesasishwa.';

  @override
  String get migration_blocked =>
      'Mabadiliko ya eneo yanahitaji kushughulikiwa kwenye seva. Jaribu tena baadaye au wasiliana na usaidizi.';

  @override
  String get migration_progress => 'Maendeleo ya mabadiliko ya eneo';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Muda kati ya ukaguzi: sekunde $seconds.';
  }

  @override
  String get migration_resume => 'Endelea na mabadiliko ya eneo';

  @override
  String get status_authorizing => 'Ruhusa inahitajika';

  @override
  String get status_authorizingDetail =>
      'Kubali ombi la Android ili kuruhusu VPN.';

  @override
  String get status_preparing => 'Inajiandaa';

  @override
  String get status_preparingDetail => 'Inaandaa muunganisho wako salama.';

  @override
  String get status_reconnecting => 'Inaunganishwa tena…';

  @override
  String get status_reconnectingDetail =>
      'Muunganisho umekatizwa. VPN inajaribu kuunganisha tena.';

  @override
  String get status_connecting => 'Inaunganishwa';

  @override
  String get status_connectingDetail => 'Inaunganishwa kwenye seva ya VPN…';

  @override
  String get status_connected => 'Imeunganishwa';

  @override
  String get status_connectedDetail => 'Muunganisho wako wa VPN unatumika.';

  @override
  String get status_disconnecting => 'Inatenganishwa';

  @override
  String get status_disconnectingDetail =>
      'Muunganisho wako wa VPN unasimamishwa.';

  @override
  String get status_error => 'Muunganisho haupatikani';

  @override
  String get status_errorDetail =>
      'Muunganisho wa VPN haujathibitishwa. Jaribu tena.';

  @override
  String get status_idle => 'Imetenganishwa';

  @override
  String get status_idleDetail => 'Unganisha VPN ili kulinda muunganisho wako.';

  @override
  String get trust_note =>
      'Kufunga programu hakusimamishi VPN. Ili kuisimamisha, tumia Tenganisha.';

  @override
  String get locations_none => 'Hakuna maeneo yanayopatikana kwa sasa.';

  @override
  String get locations_available => 'Chagua eneo lako linalofuata.';

  @override
  String get locations_selected => 'Eneo lililochaguliwa';

  @override
  String get locations_select => 'Chagua eneo hili';

  @override
  String get locations_lockedTunnel => 'Tenganisha VPN ili kubadilisha eneo.';

  @override
  String get locations_lockedMigration =>
      'Subiri mabadiliko ya eneo yakamilike.';

  @override
  String get devices_title => 'Vifaa vyako';

  @override
  String devices_used(Object count, Object limit) {
    return 'Vifaa $count kati ya $limit';
  }

  @override
  String get devices_refresh => 'Onyesha upya vifaa';

  @override
  String get devices_empty => 'Hakuna kifaa cha VPN kilichosajiliwa bado.';

  @override
  String get devices_firstConnection =>
      'Simu yako itaongezwa wakati wa muunganisho wa kwanza.';

  @override
  String get devices_thisDevice => 'Kifaa hiki';

  @override
  String devices_added(Object date) {
    return 'Kimeongezwa tarehe $date';
  }

  @override
  String get devices_unnamed => 'Kifaa kisicho na jina';

  @override
  String get action_remove => 'Ondoa';

  @override
  String get settings_title => 'Mipangilio';

  @override
  String get settings_subtitle =>
      'Mapendeleo yako na akaunti yako, vyote mahali pamoja.';

  @override
  String get settings_appearance => 'Mwonekano';

  @override
  String get settings_language => 'Lugha';

  @override
  String get settings_languageDescription =>
      'Lugha uliyochagua pia inatumika kwenye arifa za VPN.';

  @override
  String get settings_account => 'Akaunti';

  @override
  String get settings_signOut => 'Ondoka';

  @override
  String get settings_privacy => 'Sera ya faragha';

  @override
  String get settings_terms => 'Masharti ya matumizi';

  @override
  String get settings_security => 'Usalama na uwazi';

  @override
  String get settings_licenses => 'Leseni za vipengele';

  @override
  String get settings_licensesDetail =>
      'Programu zinazotumika katika programu hii';

  @override
  String settings_licensesLegalese(String url) {
    return 'Msimbo wa chanzo wa programu na vipengele vyake vya MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN inabaki imewashwa unapoondoka kwenye programu. Ili kuisimamisha, tumia Tenganisha kwenye kichupo cha Muunganisho.';

  @override
  String get theme_system => 'Mfumo';

  @override
  String get theme_light => 'Mwanga';

  @override
  String get theme_dark => 'Giza';

  @override
  String get language_system => 'Lugha ya simu';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Ondoa kifaa hiki?';

  @override
  String get dialog_removeCurrent =>
      'Simu hii itatenganishwa na VPN na itapoteza ufikiaji. Taarifa za muunganisho wake wa VPN zitafutwa baada ya seva kuthibitisha.';

  @override
  String dialog_removeOther(Object name) {
    return 'Ufikiaji wa VPN wa “$name” utaondolewa. Hatua hii haiwezi kutenduliwa.';
  }

  @override
  String get dialog_signOut => 'Ondoka kwenye akaunti?';

  @override
  String get dialog_signOutMessage =>
      'VPN itasimamishwa na utahitaji kuingia tena. Funguo zako za VPN zilizosimbwa zitabaki kwenye simu hii kwa muunganisho wako ujao.';

  @override
  String get action_cancel => 'Ghairi';

  @override
  String get action_close => 'Funga';

  @override
  String get action_copy => 'Nakili';

  @override
  String get action_renew => 'Fanya upya';

  @override
  String get action_signOut => 'Ondoka';

  @override
  String get notice_close => 'Funga ujumbe';

  @override
  String get notice_sessionExpired_title => 'Kipindi kimeisha muda';

  @override
  String get notice_sessionExpired_message =>
      'Kipindi chako kimeisha muda. Ingia tena.';

  @override
  String get notice_connectionFailed_title => 'Imeshindwa kuunganisha';

  @override
  String get notice_invalidCredentials_message =>
      'Anwani ya barua pepe au nenosiri si sahihi.';

  @override
  String get notice_emailVerification_title =>
      'Uthibitisho wa barua pepe unahitajika';

  @override
  String get notice_emailVerification_message =>
      'Thibitisha anwani yako ya barua pepe kabla ya kuongeza kifaa cha VPN.';

  @override
  String get notice_rateLimited_title => 'Majaribio mengi mno';

  @override
  String get notice_deviceLimit_title => 'Umefikia kikomo cha vifaa';

  @override
  String get notice_deviceLimit_message =>
      'Ondoa kifaa kilichopo kabla ya kuongeza kingine.';

  @override
  String get notice_identityRenewal_title =>
      'Utambulisho wa VPN unahitaji kufanywa upya';

  @override
  String get notice_identityRenewal_message =>
      'Utambulisho huu uliondolewa. Unda utambulisho mpya wa ndani.';

  @override
  String get notice_migrationPending_title => 'Mabadiliko ya eneo yanaendelea';

  @override
  String get notice_migrationPending_message =>
      'Mabadiliko ya eneo tayari yanaendelea.';

  @override
  String get notice_migrationBlocked_title => 'Mabadiliko ya eneo yamezuiwa';

  @override
  String get notice_migrationBlocked_message =>
      'Mabadiliko ya eneo yanahitaji kushughulikiwa kwenye seva. Jaribu tena baadaye au wasiliana na usaidizi.';

  @override
  String get notice_targetUnavailable_title => 'Seva haipatikani kwa muda';

  @override
  String get notice_targetUnavailable_message =>
      'Seva hii haipatikani kwa muda.';

  @override
  String get notice_networkUnavailable_title =>
      'Muunganisho wa intaneti haupatikani';

  @override
  String get notice_networkUnavailable_message =>
      'Angalia muunganisho wako kisha ujaribu tena.';

  @override
  String get notice_permissionDenied_title => 'Ruhusa ya VPN imekataliwa';

  @override
  String get notice_permissionDenied_message =>
      'Anza muunganisho tena kisha ukubali ombi la ruhusa la Android.';

  @override
  String get notice_wireguardTimeout_title => 'Seva haijibu';

  @override
  String get notice_wireguardTimeout_message =>
      'Muunganisho wa WireGuard umechukua muda mrefu mno. Jaribu tena au chagua eneo lingine.';

  @override
  String get notice_tlsFailed_title => 'Muunganisho salama umekataliwa';

  @override
  String get notice_tlsFailed_message =>
      'Seva haikukubali muunganisho wa OpenVPN. Jaribu tena. Tatizo likiendelea, endesha uchunguzi.';

  @override
  String get notice_tunRejected_title => 'Android imekataa kiolesura cha VPN';

  @override
  String get notice_tunRejected_message =>
      'Android imekataa usanidi wa mtandao ulioombwa na OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN haikuweza kuanza';

  @override
  String get notice_openvpnStart_message =>
      'Injini ya OpenVPN haikuweza kuanza kikamilifu. Jaribu tena. Tatizo likiendelea, wasiliana na usaidizi.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Msimbo wa uchunguzi: $code';
  }

  @override
  String get notice_generic_title => 'Imeshindwa kuunganisha VPN';

  @override
  String get notice_generic_message =>
      'Hitilafu imetokea. Jaribu tena baadaye.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Akaunti imeundwa',
      'password_reset_sent': 'Ombi la kuweka upya nenosiri limepokelewa',
      'verification_email_sent': 'Barua pepe ya uthibitisho imetumwa',
      'location_migration_pending': 'Mabadiliko ya eneo yanaendelea',
      'vpn_sign_in_required': 'Kuingia kunahitajika',
      'protocol_unavailable_at_location': 'Itifaki haipatikani',
      'vpn_permission_denied': 'Ruhusa ya VPN imekataliwa',
      'revoked_identity_device_limit': 'Umefikia kikomo cha vifaa',
      'tunnel_start_unexpected': 'VPN haikuweza kuanza',
      'flutter_disconnect_timeout': 'Kutenganishwa hakujathibitishwa',
      'flutter_disconnect_unexpected': 'Imeshindwa kutenganisha',
      'device_revoked': 'Kifaa kimeondolewa',
      'revoke_unexpected': 'Imeshindwa kuondoa kifaa',
      'identity_renewal_unexpected': 'Imeshindwa kufanya upya utambulisho',
      'openvpn_renewal_unexpected': 'Imeshindwa kufanya upya OpenVPN',
      'location_migration_blocked': 'Mabadiliko ya eneo yamezuiwa',
      'location_migration_slow': 'Mabadiliko ya eneo bado yanaendelea',
      'location_migration_conflict':
          'Mabadiliko ya eneo yanahitaji kuonyeshwa upya',
      'location_migration_verification_failed':
          'Mabadiliko ya eneo hayajathibitishwa',
      'location_migration_device_changed':
          'Kifaa kimebadilika wakati wa mabadiliko ya eneo',
      'tunnel_stop_failed': 'Mabadiliko ya eneo hayapatikani',
      'device_clock_ahead': 'Saa ya kifaa iko mbele',
      'other': 'Operesheni imeshindwa',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Akaunti imeundwa, lakini barua pepe ya uthibitisho haikuweza kutumwa. Tumia kitufe cha kutuma tena kwenye programu.',
      'password_reset_sent':
          'Ombi lako limepokelewa. Ikiwa kuna akaunti inayolingana na anwani hii, unaweza kupokea barua pepe. Tafadhali angalia pia folda ya barua taka.',
      'verification_email_sent':
          'Barua pepe mpya ya uthibitisho imetumwa sasa hivi.',
      'location_migration_pending':
          'Mabadiliko kuelekea $target bado yanaandaliwa. Unaweza kuendelea nayo bila kuunda upya kifaa.',
      'vpn_sign_in_required':
          'Ingia kwenye akaunti yako kabla ya kuanzisha VPN.',
      'protocol_unavailable_at_location':
          'Itifaki iliyochaguliwa haitolewi na eneo hili. Onyesha upya maeneo au chagua itifaki nyingine.',
      'vpn_permission_denied':
          'Android imekataa ruhusa ya VPN. Anza muunganisho tena kisha ukubali ombi la mfumo.',
      'revoked_identity_device_limit':
          'Ufikiaji wa VPN wa kifaa hiki umeondolewa na kikomo cha vifaa kimefikiwa. Ondoa kifaa chini ya Akaunti → Dhibiti vifaa vyangu.',
      'tunnel_start_unexpected':
          'Hitilafu isiyotarajiwa imekatiza maandalizi ya handaki. Angalia msimbo wa uchunguzi kisha ujaribu tena.',
      'flutter_disconnect_timeout':
          'Android haikuthibitisha kwa wakati kwamba VPN imesimama. Jaribu kuisimamisha tena.',
      'flutter_disconnect_unexpected':
          'Hitilafu isiyotarajiwa imezuia uthibitisho wa kusimama kwa handaki.',
      'device_revoked':
          'Ufikiaji wa VPN wa kifaa umeondolewa na siri zake za ndani zimefutwa.',
      'revoke_unexpected':
          'Kifaa hakikuweza kuondolewa. Onyesha upya orodha kisha ujaribu tena.',
      'identity_renewal_unexpected':
          'Utambulisho mpya wa VPN haukuweza kuundwa. Onyesha upya vifaa kisha ujaribu tena.',
      'openvpn_renewal_unexpected':
          'Wasifu wa OpenVPN haukuweza kufanywa upya. Jaribu tena au angalia msimbo wa uchunguzi.',
      'location_migration_blocked':
          'Seva haiwezi kukamilisha mabadiliko haya kwa sasa. Kifaa na utambulisho wake wa ndani vimehifadhiwa.',
      'location_migration_slow':
          'Seva bado inaandaa mabadiliko kuelekea $target. Tumia “Endelea na mabadiliko ya eneo” baada ya muda mfupi.',
      'location_migration_conflict':
          'Hali ya kifaa imebadilika kwenye seva. Onyesha upya vifaa kisha uendelee na mabadiliko.',
      'location_migration_verification_failed':
          'Seva haikuthibitisha eneo jipya. Utambulisho wa awali wa ndani umehifadhiwa.',
      'location_migration_device_changed':
          'Kifaa kilichorejeshwa na seva hakilingani tena na kile kilichokuwa kinabadilishwa. Onyesha upya vifaa kabla ya kujaribu tena.',
      'tunnel_stop_failed':
          'Handaki lililotangulia lazima lisimamishwe kikamilifu kabla ya muunganisho mpya.',
      'device_clock_ahead':
          'Saa ya kifaa hiki inaonekana iko mbele. Washa tarehe na saa otomatiki ili ubaki umeingia.',
      'other':
          'Operesheni haikuweza kukamilika. Jaribu tena au tuma msimbo wa uchunguzi kwa usaidizi.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Kipindi kimeisha muda',
      'invalid_credentials': 'Imeshindwa kuingia',
      'email_verification_required': 'Uthibitisho wa barua pepe unahitajika',
      'verification_email_cooldown': 'Barua pepe imeshatumwa',
      'rate_limited': 'Majaribio mengi mno',
      'invalid_registration': 'Taarifa zinahitaji kusahihishwa',
      'email_exists': 'Akaunti tayari ipo',
      'invalid_profile': 'Wasifu si sahihi',
      'invalid_device': 'Kifaa si sahihi',
      'invalid_location': 'Eneo halipatikani',
      'device_limit': 'Umefikia kikomo cha vifaa',
      'device_exists': 'Utambulisho wa VPN tayari unatumika',
      'device_identity_revoked': 'Utambulisho wa VPN unahitaji kufanywa upya',
      'device_location_locked': 'Mabadiliko ya eneo yanahitaji kuonyeshwa upya',
      'location_migration_pending': 'Mabadiliko ya eneo yanaendelea',
      'location_migration_blocked': 'Mabadiliko ya eneo yamezuiwa',
      'target_ca_mismatch': 'Seva ya OpenVPN haioani',
      'location_migration_conflict':
          'Mabadiliko ya eneo yanahitaji kuonyeshwa upya',
      'server_full': 'Seva imejaa',
      'capacity_unavailable': 'Eneo halipatikani kwa muda',
      'target_unavailable': 'Seva haipatikani kwa muda',
      'not_found': 'Kipengee hakijapatikana',
      'invalid_openvpn_csr': 'Utambulisho wa OpenVPN si sahihi',
      'openvpn_profile_exists': 'Wasifu wa OpenVPN tayari upo',
      'openvpn_profile_revoked': 'Wasifu wa OpenVPN umebatilishwa',
      'openvpn_operation_pending': 'Operesheni ya OpenVPN inaendelea',
      'openvpn_operation_terminal': 'Operesheni ya OpenVPN imekatizwa',
      'openvpn_address_unavailable': 'Anwani ya OpenVPN haipatikani',
      'openvpn_profile_conflict': 'Mgongano wa OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN haipatikani',
      'email_delivery_unavailable': 'Barua pepe haipatikani',
      'invalid_token': 'Kiungo si sahihi',
      'network_unavailable': 'Muunganisho wa intaneti haupatikani',
      'invalid_json': 'Ombi si sahihi',
      'invalid_api_response': 'Jibu la seva si sahihi',
      'ipv6_unavailable': 'IPv6 haipatikani',
      'invalid_ip_families': 'Usanidi wa mtandao umekataliwa',
      'other': 'Huduma haipatikani',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Kipindi chako kimeisha muda. Ingia tena.',
      'invalid_credentials': 'Anwani ya barua pepe au nenosiri si sahihi.',
      'email_verification_required':
          'Thibitisha anwani yako ya barua pepe kabla ya kuongeza kifaa cha VPN.',
      'invalid_registration': 'Angalia taarifa na idhini zilizoombwa.',
      'email_exists': 'Akaunti tayari inatumia anwani hii ya barua pepe.',
      'invalid_profile': 'Angalia taarifa za wasifu wako.',
      'invalid_device': 'Jina au utambulisho wa ndani wa kifaa hiki si sahihi.',
      'invalid_location': 'Onyesha upya orodha ya maeneo kisha ujaribu tena.',
      'device_limit': 'Ondoa kifaa kilichopo kabla ya kuongeza kingine.',
      'device_exists':
          'Utambulisho huu wa VPN tayari umeunganishwa na akaunti nyingine.',
      'device_identity_revoked':
          'Utambulisho huu umeondolewa. Utambulisho mpya wa ndani lazima uundwe.',
      'device_location_locked':
          'Eneo la kifaa hiki limebadilika sasa hivi. Programu itaendelea na mabadiliko yanayoendelea.',
      'location_migration_pending': 'Mabadiliko ya eneo tayari yanaendelea.',
      'location_migration_blocked':
          'Mabadiliko ya eneo yanahitaji kushughulikiwa kwenye seva. Jaribu tena baadaye au wasiliana na usaidizi.',
      'target_ca_mismatch':
          'Seva hii bado haioani na wasifu wa sasa wa OpenVPN.',
      'location_migration_conflict':
          'Onyesha upya vifaa, kisha ujaribu tena mabadiliko ya eneo.',
      'server_full':
          'Eneo hili limefikia kikomo cha miunganisho. Chagua eneo lingine au ujaribu tena baadaye.',
      'capacity_unavailable':
          'Hatuwezi kuthibitisha kama eneo hili linapatikana sasa hivi. Chagua eneo lingine au ujaribu tena baadaye.',
      'target_unavailable': 'Seva hii haipatikani kwa muda.',
      'not_found': 'Kipengee hiki hakipatikani tena kwenye akaunti yako.',
      'invalid_openvpn_csr':
          'Unda utambulisho mpya wa OpenVPN kisha ujaribu tena.',
      'openvpn_profile_exists': 'Kifaa hiki tayari kina wasifu wa OpenVPN.',
      'openvpn_profile_revoked': 'Fanya upya wasifu wa OpenVPN ili uendelee.',
      'openvpn_operation_pending':
          'Mabadiliko bado yanasambazwa. Jaribu tena baadaye.',
      'openvpn_operation_terminal':
          'Unda utambulisho mpya wa OpenVPN kisha ujaribu tena.',
      'openvpn_address_unavailable':
          'Hakuna anwani ya OpenVPN inayopatikana kwa sasa.',
      'openvpn_profile_conflict':
          'Wasifu umebadilika. Onyesha upya vifaa kisha ujaribu tena.',
      'openvpn_signer_unavailable': 'Huduma ya OpenVPN haipatikani kwa muda.',
      'email_delivery_unavailable':
          'Barua pepe haikuweza kutumwa. Jaribu tena baadaye.',
      'invalid_token':
          'Kiungo hiki si sahihi au kimeisha muda. Omba kiungo kipya.',
      'network_unavailable':
          'Angalia muunganisho wako wa intaneti kisha ujaribu tena.',
      'invalid_json': 'Angalia taarifa ulizoweka kisha ujaribu tena.',
      'invalid_api_response':
          'Seva imetoa jibu lisilotarajiwa. Jaribu tena baadaye.',
      'ipv6_unavailable':
          'Seva haiwezi kuwasha IPv6 kwa sasa. Jaribu tena baadaye.',
      'invalid_ip_families':
          'Usanidi wa handaki haujakamilika au hauendani na anwani zilizoidhinishwa. Jaribu tena kutoka kwenye programu.',
      'other': 'Hitilafu ya seva imetokea. Jaribu tena baadaye.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Jaribu tena baada ya muda mfupi.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Jaribu tena baada ya sekunde $seconds.',
      one: 'Jaribu tena baada ya sekunde $seconds.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Jaribu tena baada ya dakika $minutes.',
      one: 'Jaribu tena baada ya dakika $minutes.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Jaribu tena baada ya saa $hours.',
      one: 'Jaribu tena baada ya saa $hours.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Kuendelea kwa VPN ya mfumo hakupatikani',
      'system_vpn_resume_corrupt': 'Kuendelea kwa VPN ya mfumo si sahihi',
      'system_vpn_resume_session_invalid':
          'Kipindi cha kuendelea kwa VPN si sahihi',
      'system_vpn_resume_identity_changed': 'Utambulisho wa VPN umebadilika',
      'system_vpn_resume_identity_invalid':
          'Utambulisho wa kuendelea kwa VPN si sahihi',
      'system_vpn_resume_storage_failed':
          'Hifadhi ya kuendelea kwa VPN haipatikani',
      'system_vpn_resume_network_timeout':
          'Hakuna mtandao wa kuendelea kwa VPN',
      'system_vpn_resume_blocked': 'Kuendelea kwa VPN kumezuiwa',
      'system_vpn_resume_failed': 'Kuendelea kwa VPN kumeshindwa',
      'system_vpn_resume_error_invalid':
          'Hitilafu ya kuendelea kwa VPN si sahihi',
      'wireguard_identity_store_failed':
          'Utambulisho wa WireGuard haukuhifadhiwa',
      'wireguard_identity_unavailable': 'Utambulisho wa WireGuard haupatikani',
      'vpn_host_destroyed': 'Sehemu ya VPN ya Android imesimamishwa',
      'vpn_host_unavailable': 'Sehemu ya VPN ya Android haipatikani',
      'vpn_permission_required': 'Ruhusa ya VPN inahitajika',
      'vpn_permission_denied': 'Ruhusa ya VPN imekataliwa',
      'vpn_permission_request_failed': 'Imeshindwa kuomba ruhusa',
      'wireguard_foreground_service_unavailable':
          'Huduma ya WireGuard haipatikani',
      'wireguard_identity_invalid': 'Ufunguo wa ndani wa WireGuard si sahihi',
      'wireguard_identity_in_use': 'Utambulisho wa WireGuard unatumika tayari',
      'wireguard_configuration_invalid': 'Usanidi wa WireGuard si sahihi',
      'wireguard_operation_pending': 'Operesheni ya WireGuard bado inaendelea',
      'wireguard_start_failed': 'WireGuard imekataa kuanza',
      'wireguard_stop_timeout': 'Kusimamisha WireGuard hakujathibitishwa',
      'wireguard_handshake_timeout': 'WireGuard haijajibu',
      'openvpn_connection_timeout': 'OpenVPN haijajibu',
      'openvpn_core_unavailable': 'Injini ya OpenVPN haipatikani',
      'openvpn_operation_pending': 'Kipindi cha OpenVPN bado kinatumika',
      'openvpn_stop_timeout': 'Kusimamisha OpenVPN hakujathibitishwa',
      'openvpn_profile_unavailable': 'Wasifu wa ndani wa OpenVPN haupo',
      'openvpn_native_failed': 'Mwito asilia wa OpenVPN umekatizwa',
      'openvpn_key_generation_failed':
          'Imeshindwa kuunda ufunguo wa P-256 wa OpenVPN',
      'openvpn_csr_generation_failed': 'Imeshindwa kuunda CSR ya OpenVPN',
      'openvpn_identity_store_failed': 'Utambulisho wa OpenVPN haukuhifadhiwa',
      'openvpn_identity_clear_failed': 'Kuondolewa kwa OpenVPN hakujakamilika',
      'openvpn_identity_in_use': 'Utambulisho wa OpenVPN bado unatumika',
      'openvpn_tls_verification_required':
          'Uthibitishaji wa TLS wa OpenVPN haupo',
      'openvpn_cipher_invalid': 'Usimbaji wa OpenVPN si sahihi',
      'openvpn_profile_rejected': 'Wasifu wa OpenVPN umekataliwa',
      'openvpn_identity_inconsistent': 'Utambulisho wa OpenVPN hauendani',
      'tls_handshake_failed': 'Mazungumzo ya OpenVPN yamekataliwa',
      'tls_alert_unknown_ca': 'Cheti cha mteja cha OpenVPN hakitambuliwi',
      'tls_alert_bad_certificate': 'Cheti cha mteja cha OpenVPN kimekataliwa',
      'tls_alert_unsupported_certificate': 'Cheti cha OpenVPN hakiungwi mkono',
      'tls_client_certificate_required':
          'Cheti cha mteja cha OpenVPN kinahitajika',
      'tls_alert_misc': 'Tahadhari ya TLS ya OpenVPN',
      'tls_signature_algorithm_rejected': 'Saini ya OpenVPN haiungwi mkono',
      'tls_handshake_rejected': 'Mazungumzo ya TLS ya OpenVPN yamekataliwa',
      'tls_version_rejected': 'Toleo la TLS la OpenVPN halilingani',
      'tls_certificate_expired': 'Cheti cha TLS kimeisha muda',
      'tls_certificate_revoked': 'Cheti cha TLS kimebatilishwa',
      'transport_failed': 'Seva ya OpenVPN haifikiki',
      'tun_configuration_rejected': 'Imeshindwa kuunda kiolesura cha OpenVPN',
      'tun_setup_failed': 'Usanidi wa TUN wa OpenVPN umeshindwa',
      'tun_interface_create_failed':
          'Kuundwa kwa kiolesura cha OpenVPN kumeshindwa',
      'tun_interface_disabled': 'Kiolesura cha OpenVPN kimezimwa',
      'tun_halted': 'Kiolesura cha OpenVPN kimekatizwa',
      'tun_already_established': 'Kiolesura cha OpenVPN tayari kimefunguliwa',
      'tun_addresses_missing': 'Anwani ya OpenVPN haipo',
      'tun_routes_missing': 'Njia za OpenVPN hazipo',
      'tun_dns_missing': 'DNS ya OpenVPN haipo',
      'tun_permission_revoked': 'Ruhusa ya VPN imeondolewa',
      'tun_establish_returned_null': 'Android imekataa kiolesura cha VPN',
      'openvpn_service_start_failed': 'Huduma ya OpenVPN haipatikani',
      'openvpn_operation_timeout': 'Mwito wa OpenVPN umeisha muda',
      'openvpn_start_failed': 'OpenVPN imekataa kuanza',
      'openvpn_connection_failed': 'Muunganisho wa OpenVPN umekatizwa',
      'openvpn_core_status_error': 'OpenVPN Core imemaliza kwa hitilafu',
      'openvpn_stopped_before_connected':
          'OpenVPN imesimama kabla ya kuunganishwa',
      'openvpn_auth_failed': 'Uthibitishaji wa OpenVPN umekataliwa',
      'openvpn_client_setup_failed': 'Usanidi wa mteja wa OpenVPN umeshindwa',
      'openvpn_client_halted': 'Mteja wa OpenVPN amekatizwa',
      'openvpn_client_restart': 'OpenVPN imeomba kuanzishwa upya',
      'openvpn_inactive_timeout': 'OpenVPN haijatumika kwa muda mrefu',
      'openvpn_session_expired': 'Kipindi cha OpenVPN kimeisha muda',
      'openvpn_credentials_required': 'Uthibitishaji wa OpenVPN hauungwi mkono',
      'openvpn_proxy_failed': 'Usafirishaji wa kati wa OpenVPN umeshindwa',
      'openvpn_compression_failed': 'Ubanaji wa data wa OpenVPN umekataliwa',
      'openvpn_ntlm_crypto_unavailable':
          'Usimbaji fiche wa NTLM wa OpenVPN haupatikani',
      'openvpn_feature_unsupported': 'Kipengele cha OpenVPN hakiungwi mkono',
      'network_unavailable': 'Muunganisho wa intaneti haupatikani',
      'network_lost': 'Mtandao haupatikani',
      'certificate_validation_failed': 'Cheti cha seva kimekataliwa',
      'openvpn_certificate_expired': 'Cheti cha OpenVPN kimeisha muda',
      'tunnel_active_for_another_account':
          'Handaki la akaunti nyingine bado linatumika',
      'tunnel_already_active': 'Handaki asilia tayari linatumika',
      'tunnel_stop_timeout': 'Kusimamisha $protocol hakujathibitishwa',
      'tunnel_disconnected': '$protocol imekatizwa',
      'native_bridge_unavailable': 'Daraja la Android halipatikani',
      'native_operation_failed': 'Operesheni ya Android imekatizwa',
      'invalid_arguments': 'Vigezo vya VPN havijakamilika',
      'invalid_account_id': 'Akaunti ya VPN si sahihi',
      'invalid_device_id': 'Kitambulisho cha kifaa si sahihi',
      'storage_key_not_allowed': 'Ufunguo wa hifadhi umekataliwa',
      'secure_storage_read_failed': 'Kusoma hifadhi salama kumeshindwa',
      'secure_storage_write_failed':
          'Kuandika kwenye hifadhi salama kumeshindwa',
      'key_generation_failed': 'Imeshindwa kuunda ufunguo wa WireGuard',
      'csr_generation_failed': 'Imeshindwa kuunda CSR ya OpenVPN',
      'openvpn_recovery_exhausted': 'Urejeshaji wa OpenVPN umeshatumika',
      'openvpn_recovery_failed': 'Urejeshaji wa OpenVPN umeshindwa',
      'openvpn_renewal_required': 'Cheti cha OpenVPN kinahitaji kufanywa upya',
      'other': 'Hitilafu asilia ya VPN isiyoainishwa',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android haiwezi kupata kipindi cha VPN kinachoweza kuendelea. Anzisha muunganisho mpya kwenye programu.',
      'system_vpn_resume_corrupt':
          'Data ya kuendelea kwa VPN iliyohifadhiwa si sahihi na haitatumika. Anzisha muunganisho mpya.',
      'system_vpn_resume_session_invalid':
          'Kipindi kilichohifadhiwa hakiwezi tena kuendeleza VPN. Ingia tena kwenye programu.',
      'system_vpn_resume_identity_changed':
          'Utambulisho wa VPN wa ndani umebadilika. Kuendelea kumesimamishwa; anzisha muunganisho mpya.',
      'system_vpn_resume_identity_invalid':
          'Utambulisho wa kuendelea si sahihi. Anzisha muunganisho mpya.',
      'system_vpn_resume_storage_failed':
          'Android haikuweza kusoma au kusasisha data ya kuendelea iliyosimbwa. Anzisha muunganisho mpya.',
      'system_vpn_resume_network_timeout':
          'Android haikupata mtandao kwa wakati ili kuendeleza VPN. Jaribu tena mtandao unapopatikana.',
      'system_vpn_resume_blocked':
          'Kuendelea kwa VPN kumezuiwa. Angalia mipangilio ya Android, kisha anzisha muunganisho mpya.',
      'system_vpn_resume_failed':
          'Kuendelea kwa VPN kupitia Android kumeshindwa. Anzisha muunganisho mpya kwenye programu.',
      'system_vpn_resume_error_invalid':
          'Android imerudisha hitilafu ya kuendelea isiyoweza kutumika. Anzisha muunganisho mpya.',
      'wireguard_identity_store_failed':
          'Android haikuweza kuhifadhi utambulisho uliosimbwa wa WireGuard wa akaunti hii.',
      'wireguard_identity_unavailable':
          'Hakuna utambulisho wa WireGuard unaoweza kutumika kwa muunganisho huu.',
      'vpn_host_destroyed':
          'Sehemu ya Android inayoendesha VPN imesimamishwa. Anzisha muunganisho mpya.',
      'vpn_host_unavailable':
          'Android haiwezi kuunda sehemu inayoendesha VPN. Jaribu tena baada ya kuangalia mipangilio ya VPN.',
      'openvpn_renewal_required':
          'Cheti cha OpenVPN hakikuweza kufanywa upya kiotomatiki. Anzisha muunganisho mpya kwenye programu.',
      'openvpn_recovery_failed':
          'Urejeshaji wa kiotomatiki umeshindwa. Anzisha muunganisho mpya kwenye programu.',
      'openvpn_recovery_exhausted':
          'Urejeshaji wa kiotomatiki tayari umetumika. Anzisha muunganisho mpya kwenye programu.',
      'vpn_permission_required':
          'Android inahitaji ruhusa mpya ya VPN kabla ya kuanzisha handaki.',
      'vpn_permission_denied':
          'Ruhusu FuzeVPN kwenye ombi la Android ili kuendelea.',
      'vpn_permission_request_failed':
          'Android haikuweza kufungua skrini ya ruhusa ya VPN.',
      'wireguard_foreground_service_unavailable':
          'Android haikuweza kuweka huduma ya WireGuard kwenye hali ya mbele.',
      'wireguard_identity_invalid':
          'Ufunguo uliosimbwa wa WireGuard wa akaunti hii hausomeki au si sahihi.',
      'wireguard_identity_in_use':
          'Operesheni nyingine bado inatumia ufunguo wa WireGuard wa akaunti hii.',
      'wireguard_configuration_invalid':
          'Anwani, DNS, ufunguo wa seva, au njia za WireGuard zilizopokelewa si sahihi.',
      'wireguard_operation_pending':
          'Operesheni iliyotangulia ya WireGuard bado haijaachilia huduma yake asilia.',
      'wireguard_start_failed': 'Injini ya WireGuard imekataa kuwasha usanidi.',
      'wireguard_stop_timeout':
          'Huduma ya WireGuard haikuthibitisha kuachilia kiolesura cha VPN ndani ya muda uliowekwa.',
      'wireguard_handshake_timeout':
          'Handaki halikuthibitisha mazungumzo ya awali na seva kwa wakati.',
      'openvpn_connection_timeout':
          'OpenVPN haikuthibitisha muunganisho na seva kwa wakati.',
      'openvpn_core_unavailable':
          'Toleo hili la programu halina injini ya OpenVPN inayoweza kutumika.',
      'openvpn_operation_pending':
          'Injini asilia bado inashikilia kipindi cha awali cha OpenVPN na inakataa kuunda kingine.',
      'openvpn_stop_timeout':
          'OpenVPN Core haikuthibitisha kwamba kipindi chake asilia kimesimama na kuondolewa ndani ya muda uliowekwa.',
      'openvpn_profile_unavailable':
          'Hakuna wasifu wa OpenVPN uliothibitishwa unaoweza kusomwa kwa muunganisho huu.',
      'openvpn_native_failed':
          'Hitilafu ya programu imekatiza OpenVPN. Jaribu kuunganisha tena. Tatizo likiendelea, endesha uchunguzi.',
      'openvpn_key_generation_failed':
          'Android Keystore haikuweza kuunda au kusoma ufunguo wa faragha wa P-256 usioweza kutolewa nje.',
      'openvpn_csr_generation_failed':
          'Ufunguo wa Android Keystore haukuweza kutia saini ombi la cheti la OpenVPN.',
      'openvpn_identity_store_failed':
          'Cheti au wasifu wa OpenVPN haukuweza kuhifadhiwa kwenye hifadhi iliyosimbwa.',
      'openvpn_identity_clear_failed':
          'Android haikuweza kuondoa utambulisho wote wa ndani wa OpenVPN wa akaunti hii.',
      'openvpn_identity_in_use':
          'Kipindi asilia cha OpenVPN bado kinatumia ufunguo au cheti cha kifaa hiki.',
      'openvpn_tls_verification_required':
          'Wasifu haudai wazi uthibitishaji wa cheti cha seva.',
      'openvpn_cipher_invalid':
          'Seva imetoa algoriti ya usimbaji isiyo kwenye orodha iliyoruhusiwa.',
      'openvpn_profile_rejected':
          'Wasifu uliopokelewa kutoka kwa seva hauendani. Unda upya kifaa hiki kisha ujaribu tena.',
      'openvpn_identity_inconsistent':
          'Cheti hakilingani na utambulisho salama wa simu hii. Hakuna wasifu wa ndani uliobadilishwa.',
      'tls_handshake_failed':
          'Seva imekataa mazungumzo ya TLS. Unda upya wasifu ikiwa tatizo linaendelea.',
      'tls_alert_unknown_ca':
          'Seva haitambui mamlaka ya cheti cha kifaa hiki. Seva ya OpenVPN inapaswa kukaguliwa.',
      'tls_alert_bad_certificate':
          'Seva imekataa cheti cha kifaa hiki. Unda upya kifaa kabla ya kujaribu tena.',
      'tls_alert_unsupported_certificate':
          'Seva haiungi mkono aina ya cheti salama inayotumiwa na Android.',
      'tls_client_certificate_required':
          'Seva inahitaji cheti cha mteja, lakini OpenVPN Core haikuweza kukiwasilisha.',
      'tls_alert_misc':
          'Seva imerudisha tahadhari ya TLS isiyohusu cheti wala toleo.',
      'tls_signature_algorithm_rejected':
          'Seva imekataa algoriti ya ECDSA P-256 ya ufunguo wa Android Keystore.',
      'tls_handshake_rejected':
          'Seva imekatiza mazungumzo ya TLS kabla ya muunganisho.',
      'tls_version_rejected':
          'Mteja na seva hawakupata toleo la TLS linalofanana.',
      'tls_certificate_expired':
          'Cheti kilichowasilishwa wakati wa muunganisho kimeisha muda.',
      'tls_certificate_revoked':
          'Cheti kilichowasilishwa wakati wa muunganisho kimebatilishwa.',
      'transport_failed':
          'Seva ya OpenVPN haijibu kwenye mtandao wa sasa. Jaribu tena baada ya muda mfupi.',
      'tun_configuration_rejected':
          'Android imekataa usanidi wa mtandao ulioombwa na OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core imekataa mpango wa mtandao kabla ya kuunda kiolesura cha Android.',
      'tun_interface_create_failed':
          'OpenVPN Core haikuweza kupata kiolesura cha TUN kutoka VpnService ya Android.',
      'tun_interface_disabled':
          'Android au OpenVPN Core imezima kiolesura cha TUN wakati wa muunganisho.',
      'tun_halted':
          'OpenVPN Core imepokea ombi la kusimamisha kiolesura cha TUN.',
      'tun_already_established':
          'OpenVPN iliomba kiolesura cha pili katika muunganisho uleule. Handaki limesimamishwa kwa usalama.',
      'tun_addresses_missing':
          'Seva haikutoa anwani inayoweza kutumika kwa handaki.',
      'tun_routes_missing':
          'Seva haikutoa njia zinazoweza kutumika kwa handaki.',
      'tun_dns_missing': 'Seva haikutoa seva ya DNS inayoweza kutumika.',
      'tun_permission_revoked':
          'Android imeondoa ruhusa ya VPN wakati wa muunganisho.',
      'tun_establish_returned_null':
          'Android haikuunda kiolesura, kwa kawaida kwa sababu VPN nyingine bado inatumika.',
      'openvpn_service_start_failed':
          'Android haikuweza kuanzisha huduma ya OpenVPN ya mbele.',
      'openvpn_operation_timeout':
          'Mwito wa JNI kwenda OpenVPN Core umezidi muda wake wa juu zaidi.',
      'openvpn_start_failed':
          'Huduma ya Android iko tayari, lakini OpenVPN Core haikukubali kuanzisha wasifu.',
      'openvpn_connection_failed':
          'OpenVPN Core imesimama kabla ya kutoa tukio la CONNECTED.',
      'openvpn_core_status_error':
          'Kitanzi asilia cha OpenVPN kimemaliza kwa hitilafu bila tukio maalum la mwisho.',
      'openvpn_stopped_before_connected':
          'Kitanzi asilia cha OpenVPN kimesimama kabla ya CONNECTED, bila hitilafu wazi ya Core.',
      'openvpn_auth_failed':
          'Seva ya OpenVPN imekataa uthibitishaji wa wasifu.',
      'openvpn_client_setup_failed':
          'OpenVPN Core haikuweza kuanzisha mteja kabla ya muunganisho wa mtandao.',
      'openvpn_client_halted':
          'OpenVPN Core imepokea amri ya mwisho ya kusimamisha mteja.',
      'openvpn_client_restart':
          'OpenVPN Core imeomba kuanzisha upya kipindi chake cha usafirishaji.',
      'openvpn_inactive_timeout':
          'OpenVPN Core imefunga kipindi baada ya muda wa kutotumika.',
      'openvpn_session_expired':
          'Seva imeripoti kwamba kipindi cha OpenVPN kimeisha muda.',
      'openvpn_credentials_required':
          'Seva au proksi inaomba vitambulisho vya kuingizwa na mtumiaji, visivyo sehemu ya wasifu huu wa cheti.',
      'openvpn_proxy_failed':
          'OpenVPN Core imeripoti kushindwa kwa proksi au kituo cha kupitisha kilichosanidiwa.',
      'openvpn_compression_failed':
          'OpenVPN Core imekataa hali ya ubanaji wa data iliyotangazwa na wasifu au seva.',
      'openvpn_ntlm_crypto_unavailable':
          'Wasifu unaomba usimbaji fiche wa NTLM usiopatikana katika toleo hili.',
      'openvpn_feature_unsupported':
          'Wasifu au seva inahitaji kipengele kisichopo kwenye mteja huu wa Android.',
      'network_unavailable': 'Hakuna mtandao halisi unaoweza kutumika.',
      'network_lost': 'Handaki limesimamishwa baada ya mtandao kupotea.',
      'certificate_validation_failed':
          'Utambulisho wa seva ya OpenVPN haukuweza kuthibitishwa.',
      'openvpn_certificate_expired':
          'Cheti cha OpenVPN kimeisha muda. Anzisha muunganisho mpya kwenye programu ili kukifanya upya.',
      'tunnel_active_for_another_account':
          'Handaki la akaunti nyingine lazima lisimamishwe kabla ya muunganisho huu.',
      'tunnel_already_active':
          'Android inaripoti kwamba kipindi kilichotangulia cha VPN bado kinatumia kiolesura.',
      'tunnel_stop_timeout':
          'Injini ya $protocol haikuthibitisha kuachilia kiolesura cha VPN ndani ya muda uliowekwa.',
      'tunnel_disconnected':
          'Injini asilia imeripoti kwamba handaki limeisha ghafla baada ya kuanza.',
      'native_bridge_unavailable':
          'Programu haiwezi kufikia huduma ya VPN ya Android. Funga programu, uifungue tena, kisha ujaribu tena.',
      'native_operation_failed':
          'Hitilafu ya programu imekatiza operesheni ya VPN. Jaribu tena. Tatizo likiendelea, endesha uchunguzi.',
      'invalid_arguments':
          'Taarifa zinazohitajika kwa operesheni hii ya VPN hazijakamilika. Jaribu tena. Tatizo likiendelea, endesha uchunguzi.',
      'invalid_account_id':
          'Operesheni asilia haihusiani na kitambulisho halali cha akaunti.',
      'invalid_device_id':
          'Kitambulisho cha kifaa kilichotumwa kwa injini asilia hakipo au si sahihi.',
      'storage_key_not_allowed':
          'Daraja la Android limezuia ufunguo ulio nje ya orodha ya hifadhi iliyoruhusiwa.',
      'secure_storage_read_failed':
          'Android Keystore haikuweza kusimbua data ya ndani ya akaunti hii.',
      'secure_storage_write_failed':
          'Android Keystore haikuweza kusimba au kuhifadhi data ya ndani.',
      'key_generation_failed':
          'Android haikuweza kuunda au kusoma ufunguo wa WireGuard kwenye hifadhi salama.',
      'csr_generation_failed':
          'Android Keystore haikuweza kuunda au kutia saini CSR ya OpenVPN P-256.',
      'other':
          'Hitilafu isiyoandikiwa nyaraka imetokea kwenye sehemu asilia. Tuma msimbo wa uchunguzi ulioonyeshwa hapa chini kwa usaidizi.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Ombi la ruhusa tayari limefunguliwa';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Ombi la ruhusa ya VPN ya Android tayari linaonyeshwa. Likamilishe kabla ya kujaribu tena.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Ombi la ruhusa ya VPN limekatizwa';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Skrini ya ruhusa ya VPN ilifungwa kabla programu haijapokea jibu.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Muunganisho wa OpenVPN haujathibitishwa';

  @override
  String get notice_openvpnProofMissing_message =>
      'Muunganisho wa OpenVPN haukuweza kuthibitishwa. Umesimamishwa kwa usalama. Jaribu tena.';

  @override
  String get openvpnCleanup_title => 'Wasifu wa OpenVPN umebatilishwa';

  @override
  String get openvpnCleanup_working =>
      'Inasimamisha na kuondoa wasifu wa OpenVPN uliobatilishwa…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Kusimamishwa kwa OpenVPN hakujathibitishwa. Jaribu tena kabla ya kuunda wasifu mpya.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Wasifu wa OpenVPN uliobatilishwa haukuweza kuondolewa kikamilifu. Jaribu kusafisha tena.';

  @override
  String get openvpnCleanup_complete =>
      'Wasifu wa OpenVPN uliobatilishwa umeondolewa. Gusa Unganisha ili kuunda mpya.';

  @override
  String get network_title => 'Usanidi wa mtandao';

  @override
  String get network_ipv4Fallback =>
      'IPv6 haipatikani kwa muda. Maandalizi yanaendelea kwa IPv4.';

  @override
  String get network_rejectedTitle => 'Usanidi wa mtandao umekataliwa';

  @override
  String get network_rejectedMessage =>
      'Usanidi wa handaki haujakamilika au hauendani na anwani zilizoidhinishwa. Jaribu tena kutoka kwenye programu.';

  @override
  String get network_unreadableTitle => 'Usanidi wa ndani hausomeki';

  @override
  String get network_unreadableMessage =>
      'Usanidi wa mtandao wa OpenVPN uliohifadhiwa hauwezi kutumika. Unganisha tena kutoka kwenye programu ili kuusasisha.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ulinzi wa mtandao';

  @override
  String get protection_subtitle =>
      'Zuia ufikiaji wa moja kwa moja wa intaneti ikiwa VPN itakatika.';

  @override
  String get protection_active => 'Ulinzi wa mfumo umewashwa';

  @override
  String get protection_alwaysOnOnly =>
      'VPN ya kila wakati imewashwa; washa kuzuia miunganisho bila VPN';

  @override
  String get protection_inactive => 'Ulinzi wa mfumo haujawashwa';

  @override
  String get protection_unknown => 'Angalia ulinzi wa mfumo';

  @override
  String get protection_openSettings => 'Fungua mipangilio ya Android';

  @override
  String get protection_dialogTitle => 'Sanidi ulinzi wa mtandao';

  @override
  String get protection_dialogMessage =>
      'Android hudhibiti VPN ya kila wakati na kuzuia miunganisho bila VPN. Hakikisha FuzeVPN imechaguliwa kisha uwashe kuzuia kwenye mipangilio ya mfumo.';

  @override
  String get protection_dialogOpen => 'Fungua mipangilio';

  @override
  String get session_systemProtectionNote =>
      'Ikiwa Android bado inazuia trafiki nje ya VPN, fungua mipangilio ya mfumo ili kuangalia au kubadilisha ulinzi huu.';

  @override
  String get diagnostics_title => 'Uchunguzi';

  @override
  String get diagnostics_settingsTitle => 'Uchunguzi wa programu';

  @override
  String get diagnostics_automaticTitle => 'Tuma hitilafu muhimu';

  @override
  String get diagnostics_automaticDescription =>
      'Shiriki ripoti fupi ya kiufundi pindi hitilafu muhimu inapotokea.';

  @override
  String get diagnostics_privacy =>
      'Ripoti zinazotumwa huhusishwa na akaunti uliyoingia nayo na huhifadhiwa kwa siku 30. Hazina historia ya kuvinjari, manenosiri wala funguo za VPN.';

  @override
  String get diagnostics_manualOpen => 'Endesha uchunguzi';

  @override
  String get diagnostics_localDescription =>
      'Unda ripoti ya hali ya programu na VPN. Muunganisho wako hautabadilika.';

  @override
  String get diagnostics_sendReport => 'Tuma ripoti';

  @override
  String get diagnostics_sendHint =>
      'Usiteue kisanduku hiki ili ripoti ibaki kwenye kifaa hiki.';

  @override
  String get diagnostics_signedOut =>
      'Ingia kwenye akaunti yako ili kutuma ripoti.';

  @override
  String get diagnostics_localLifetime =>
      'Hifadhi ripoti hii kwenye simu yako ili ibaki baada ya kufunga programu.';

  @override
  String get diagnostics_run => 'Endesha uchunguzi';

  @override
  String get diagnostics_rerun => 'Endesha uchunguzi tena';

  @override
  String get diagnostics_running => 'Inakagua…';

  @override
  String get diagnostics_sending => 'Inatuma ripoti…';

  @override
  String get diagnostics_prepared => 'Ripoti iko tayari kwenye kifaa hiki';

  @override
  String get diagnostics_queued => 'Ripoti inasubiri kutumwa';

  @override
  String get diagnostics_sent => 'Ripoti imepokelewa';

  @override
  String get diagnostics_failed =>
      'Kutuma kumeshindwa. Ripoti yako ya ndani bado inapatikana.';

  @override
  String get diagnostics_preparationFailed =>
      'Ripoti ya uchunguzi haikuweza kuandaliwa. Jaribu tena.';

  @override
  String get diagnostics_authenticationRequired =>
      'Ingia tena ili kutuma ripoti.';

  @override
  String get diagnostics_retry => 'Jaribu kutuma tena';

  @override
  String get diagnostics_export => 'Hifadhi ripoti';

  @override
  String get diagnostics_exportFailed =>
      'Kuhifadhi kumeshindwa. Jaribu tena kutoka kwenye ripoti ya ndani.';

  @override
  String get diagnostics_preferenceFailed =>
      'Mpangilio huu haukuweza kuhifadhiwa. Jaribu tena.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Marejeleo: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Imepokelewa tarehe $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Itahifadhiwa hadi $date';
  }

  @override
  String get diagnostics_duplicate => 'Ripoti hii ilikuwa imepokelewa tayari.';

  @override
  String get diagnostics_preview => 'Onyesho la awali la ripoti';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Matukio $count ya kiufundi yameambatishwa',
      one: 'Tukio 1 la kiufundi limeambatishwa',
      zero: 'Hakuna tukio la kiufundi lililoambatishwa',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Maelezo ya kiufundi';

  @override
  String get diagnostics_empty =>
      'Hakuna ripoti ya uchunguzi iliyoandaliwa bado.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Hali ya handaki',
      'handshake': 'Uthibitisho wa muunganisho',
      'certificate': 'Cheti cha VPN',
      'kill_switch': 'Ulinzi wa Android',
      'connectivity': 'Mtandao unaopatikana',
      'api_reachability': 'Ufikiaji wa huduma',
      'secure_storage': 'Hifadhi salama',
      'other': 'Ukaguzi wa ndani',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Imekaguliwa',
      'failed': 'Inahitaji uangalizi',
      'skipped': 'Haijajaribiwa — hakuna jaribio linalotumika',
      'unknown': 'Taarifa hazipatikani',
      'other': 'Taarifa hazipatikani',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Karibu kwenye FuzeVPN';

  @override
  String get connection_changeLocation => 'Badilisha eneo';

  @override
  String get connection_details => 'Maelezo ya muunganisho';

  @override
  String get locations_searchLabel => 'Tafuta mji au nchi';

  @override
  String get locations_clearSearch => 'Futa utafutaji';

  @override
  String get locations_filterAll => 'Yote';

  @override
  String get locations_filterFavorites => 'Vipendwa';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Maeneo $count',
      one: 'Eneo $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Hakuna eneo lililopatikana';

  @override
  String get locations_noResultsHint => 'Jaribu mji au nchi nyingine.';

  @override
  String get locations_noFavorites => 'Vipendwa vyako, mkononi mwako';

  @override
  String get locations_noFavoritesHint =>
      'Gusa nyota iliyo karibu na eneo ili uliweke hapa.';

  @override
  String get locations_showAll => 'Tazama maeneo yote';

  @override
  String locations_addFavorite(String name) {
    return 'Ongeza $name kwenye vipendwa';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Ondoa $name kutoka kwenye vipendwa';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Kipendwa hakikuweza kuhifadhiwa. Jaribu tena.';

  @override
  String get locations_emptyTitle => 'Hakuna maeneo yanayopatikana';

  @override
  String get locations_emptyHint => 'Onyesha upya orodha ili ujaribu tena.';

  @override
  String get devices_manage => 'Dhibiti vifaa vyangu';

  @override
  String get settings_personalization => 'Ifanye yako';

  @override
  String get settings_safety => 'Ulinzi';

  @override
  String get settings_help => 'Unahitaji msaada?';

  @override
  String get settings_about => 'Kuhusu FuzeVPN';

  @override
  String get diagnostics_heading => 'Elewa tatizo la muunganisho';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Inapatikana',
      'pending': 'Inajiandaa',
      'revoked': 'Imeondolewa',
      'expired': 'Imeisha muda',
      'other': 'Hali haipatikani',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Mapendeleo hayajahifadhiwa';

  @override
  String get notice_preferenceSave_message =>
      'Chaguo lako limetumika kwa sasa, lakini halikuweza kuhifadhiwa. Jaribu tena ili ubaki nalo baada ya kufunga programu.';

  @override
  String get connection_androidDisconnectHint =>
      'Android ikiendelea kuiweka VPN hai, zima “VPN ya kila wakati” kwenye mipangilio itakayofunguka.';

  @override
  String get connection_certificate => 'Cheti cha OpenVPN';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Halali hadi $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Kiliisha muda tarehe $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Kitafanywa upya kiotomatiki wakati wa muunganisho ujao.';

  @override
  String get protection_learnMore => 'Jifunze kuhusu ulinzi wa Android';

  @override
  String get protection_guideWhy =>
      'Ulinzi huu huzuia programu kutumia intaneti moja kwa moja VPN ikikatika. Husanidiwa katika Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN ya kila wakati';

  @override
  String get protection_guideAlwaysOn =>
      'Android huendelea kuendesha huduma ya VPN, na inaweza kuianzisha upya baada ya simu kuwashwa tena.';

  @override
  String get protection_guideBlockTitle => 'Zuia miunganisho bila VPN';

  @override
  String get protection_guideBlock =>
      'Mpangilio huu huzuia trafiki kupita nje ya VPN, ikiwemo wakati muunganisho umekatizwa.';

  @override
  String get protection_guideWarning =>
      'Kizuizi hiki kikiwashwa, ufikiaji wa intaneti utabaki umezimwa hadi VPN iunganishwe.';

  @override
  String get protection_guideStepsTitle => 'Washa ulinzi';

  @override
  String get protection_guideStep1 =>
      'Fungua mipangilio ya VPN ya Android kwa kitufe kilicho hapa chini.';

  @override
  String get protection_guideStep2 =>
      'Fungua chaguo kwa kutumia aikoni ya gia iliyo karibu na FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Washa “VPN ya kila wakati”, kisha “Zuia miunganisho bila VPN”, ikiwa chaguo hizi zinapatikana.';

  @override
  String get protection_guideManufacturers =>
      'Majina hutofautiana kulingana na simu. Ikihitajika, tafuta “VPN” katika Mipangilio, mara nyingi chini ya “Mtandao na intaneti”.';

  @override
  String get protection_guideDisableTitle => 'Zima ulinzi huu';

  @override
  String get protection_guideDisable =>
      'Katika mipangilio hiyo hiyo, zima “Zuia miunganisho bila VPN” ili kuruhusu intaneti bila VPN. Zima pia “VPN ya kila wakati” ikiwa hutaki tena Android iianzishe upya.';

  @override
  String get protection_guideManual =>
      'Unachagua mipangilio hii katika Android. FuzeVPN haibadilishi mipangilio hii kwa niaba yako.';

  @override
  String get locations_changeTitle => 'Badilisha eneo?';

  @override
  String locations_changeActive(String name) {
    return 'VPN itatenganishwa, kisha ijaribu kuunganisha kwenye $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN itajaribu kuunganisha kwenye $name.';
  }

  @override
  String get locations_confirmChange => 'Badilisha na uunganishe';

  @override
  String get locations_changeBusy =>
      'Mabadiliko yanaendelea. Subiri kabla ya kuchagua eneo lingine.';

  @override
  String get locations_automaticSelection => 'Uchaguzi wa kiotomatiki';

  @override
  String get locations_cities => 'Miji';

  @override
  String get locations_servers => 'Seva';

  @override
  String locations_viewCities(String name) {
    return 'Tazama miji ya $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Tazama seva za $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nchi',
      one: '$count nchi',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miji',
      one: '$count mji',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seva',
      one: '$count seva',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Nchi zote';

  @override
  String get locations_backToCountries => 'Rudi kwenye nchi';

  @override
  String locations_backToCities(String name) {
    return 'Rudi kwenye miji ya $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Chagua $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Chagua $name';
  }

  @override
  String get locations_noCompatibleServer => 'Hakuna seva inayooana kwa sasa.';

  @override
  String get externalLink_failed =>
      'Imeshindwa kufungua kiungo hiki. Unaweza kukinakili na kukifungua kwenye kivinjari chako.';

  @override
  String get externalLink_copy => 'Nakili kiungo';

  @override
  String get externalLink_copied => 'Kiungo kimenakiliwa';

  @override
  String get externalLink_copyFailed =>
      'Imeshindwa kunakili kiungo. Chagua anwani iliyo hapa chini.';

  @override
  String get settings_deleteAccount => 'Futa akaunti yangu';

  @override
  String get settings_deleteAccountDetail =>
      'Tazama utaratibu wa kuomba kufutwa kwa akaunti';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Chagua usajili wako wa VPN.';

  @override
  String get billing_subscribe => 'Jisajili';

  @override
  String get billing_choosePlan => 'Chagua mpango ili kuendelea.';

  @override
  String get billing_monthly => 'Kila mwezi';

  @override
  String get billing_yearly => 'Kila mwaka';

  @override
  String get billing_continue => 'Endelea na Google Play';

  @override
  String get billing_restore => 'Rejesha manunuzi';

  @override
  String get billing_manage => 'Dhibiti usajili';

  @override
  String get billing_deleteAccountWarning =>
      'Ukiwa na usajili wa Google Play, kufuta akaunti yako ya FuzeVPN hakughairi usasishaji wake. Dhibiti au ughairi usasishaji huo kando katika Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Endelea hadi kwenye ombi la kufuta akaunti';

  @override
  String get billing_refresh => 'Onyesha upya ufikiaji';

  @override
  String get billing_loadingPlans => 'Inapakia mipango…';

  @override
  String get billing_unavailable =>
      'Hakuna mipango inayopatikana kwa sasa. Jaribu tena baadaye.';

  @override
  String get billing_comingSoon => 'Usajili utapatikana hivi karibuni.';

  @override
  String get billing_priceDisclosure =>
      'Bei inatolewa na Google Play. Kiasi cha mwisho na kodi zinazotumika huthibitishwa kabla hujathibitisha.';

  @override
  String get billing_renewalMonthly =>
      'Husasishwa kiotomatiki kila mwezi isipokuwa ikighairiwa. Unaweza kughairi wakati wowote katika usajili wa Google Play.';

  @override
  String get billing_renewalYearly =>
      'Husasishwa kiotomatiki kila mwaka isipokuwa ikighairiwa. Unaweza kughairi wakati wowote katika usajili wa Google Play.';

  @override
  String get billing_active => 'Ufikiaji wako wa Premium unatumika';

  @override
  String billing_accessUntil(String date) {
    return 'Ufikiaji hadi $date.';
  }

  @override
  String get billing_webManaged =>
      'Usajili wako unasimamiwa kwenye tovuti ya FuzeVPN.';

  @override
  String get billing_playManaged => 'Usajili wako unasimamiwa na Google Play.';

  @override
  String get billing_playOnHold =>
      'Usajili wako wa Google Play umesimamishwa au unasubiri malipo. Fungua “Dhibiti usajili” ili kurekebisha hali yake katika Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Akaunti hii ya Google Play tayari ina usajili wa Fuze Premium ambao hautumiki kwa akaunti hii ya FuzeVPN. Fungua “Dhibiti usajili” ili kuukagua katika Google Play.';

  @override
  String get billing_inactive => 'Hakuna usajili unaotumika.';

  @override
  String get billing_checkingAccess => 'Inakagua ufikiaji wako…';

  @override
  String get billing_restoring => 'Inarejesha manunuzi…';

  @override
  String get billing_pending =>
      'Malipo yanasubiri. Ufikiaji wako utawashwa baada ya uthibitisho.';

  @override
  String get billing_cancelled =>
      'Ununuzi umeghairiwa. Hakuna usajili mpya uliowashwa.';

  @override
  String get billing_verifying => 'Inathibitisha ununuzi…';

  @override
  String get billing_success =>
      'Usajili umewashwa. Ufikiaji wako wa Premium uko tayari.';

  @override
  String get billing_restored => 'Manunuzi yako yamerejeshwa.';

  @override
  String get billing_restoreEmpty =>
      'Hakuna manunuzi ya kurejesha kwa akaunti hii ya Google Play.';

  @override
  String get billing_catalogError => 'Imeshindwa kupakia mipango. Jaribu tena.';

  @override
  String get billing_purchaseError => 'Imeshindwa kuanza ununuzi. Jaribu tena.';

  @override
  String get billing_verificationError =>
      'Uthibitishaji wa ununuzi haupatikani kwa muda. Rejesha manunuzi ili ujaribu tena.';

  @override
  String get billing_restoreError =>
      'Imeshindwa kurejesha manunuzi. Jaribu tena.';

  @override
  String get billing_managementError =>
      'Imeshindwa kufungua usimamizi wa usajili. Jaribu tena.';

  @override
  String get billing_storeUnavailable =>
      'Google Play haipatikani kwenye kifaa hiki.';

  @override
  String get welcome_title => 'VPN yako, kwa urahisi.';

  @override
  String get welcome_description =>
      'Linda muunganisho wako. Endelea kudhibiti faragha yako.';

  @override
  String get welcome_start => 'Anza';

  @override
  String get welcome_alreadyPurchased => 'Tayari umenunua?';

  @override
  String get welcome_noAccountRequired => 'Huhitaji akaunti ili kuanza.';

  @override
  String get guest_accountTitle => 'Akaunti haijaunganishwa';

  @override
  String get guest_accountDescription =>
      'Rejesha manunuzi yako ukitumia akaunti ile ile ya Google Play ili utumie usajili wako kwenye kifaa kingine.';

  @override
  String get guest_existingSubscriberSignIn => 'Tayari umejisajili? Ingia';

  @override
  String get guest_claimTitle => 'Tumia FuzeVPN popote';

  @override
  String get guest_claimDescription =>
      'Unda akaunti ili kupata usajili wako kwenye vifaa vyako vingine. Hatua hii ni ya hiari.';

  @override
  String get guest_skip => 'Labda baadaye';

  @override
  String get guest_activationTitle => 'Fuze Premium imewashwa';

  @override
  String get guest_activationDescription =>
      'Usajili wako uko tayari. Tumia VPN yako na uunde akaunti wakati wowote unapopenda.';

  @override
  String get guest_useVpn => 'Tumia VPN yangu';

  @override
  String get guest_loginRequired =>
      'Ununuzi huu tayari umeunganishwa na akaunti ya FuzeVPN. Ingia kwenye akaunti hiyo ili kupata usajili wako.';

  @override
  String get guest_signOutWarning =>
      'Unaweza kupata tena usajili wako kwa kurejesha manunuzi ukitumia akaunti ile ile ya Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Akaunti yako tayari imeunganishwa. Ingia ili kuona na kudhibiti maelezo yako.';

  @override
  String get billing_acceptance =>
      'Kwa kuendelea, unakubali Masharti ya matumizi na Sera ya faragha.';

  @override
  String get guest_verifyEmailReminder =>
      'Thibitisha anwani yako ya barua pepe ili kulinda akaunti yako. Unaweza kuendelea kutumia VPN yako.';

  @override
  String get guest_serviceUnavailable =>
      'Huduma haipatikani kwa muda. Jaribu tena baadaye kidogo.';

  @override
  String get guest_restoreError =>
      'Manunuzi yako hayakuweza kurejeshwa. Jaribu tena ukitumia akaunti ya Google Play uliyotumia kwa ununuzi.';

  @override
  String get guest_claimSuccess =>
      'Akaunti yako imeundwa. Usajili wako na ufikiaji wako wa VPN vimehifadhiwa.';

  @override
  String get guest_emailExists =>
      'Barua pepe hii tayari inatumika. Chagua anwani nyingine au ingia kwenye akaunti yako iliyopo. Ununuzi wako bado unapatikana kupitia Google Play.';

  @override
  String get guest_claimError =>
      'Akaunti yako haikuweza kuundwa. Unaweza kuendelea kutumia VPN yako na kujaribu tena baadaye.';

  @override
  String get guest_secureStorageError =>
      'Kipindi chako hakikuweza kulindwa kwenye kifaa hiki. Jaribu tena.';

  @override
  String get guest_premiumRequired => 'Chagua usajili ili kuwasha VPN yako.';

  @override
  String get welcome_viewPlans => 'Tazama mipango';

  @override
  String get google_continue => 'Endelea na Google';

  @override
  String get google_or => 'au';

  @override
  String get google_title => 'Akaunti yako ya FuzeVPN';

  @override
  String get google_settingUp => 'Kamilisha kuunda akaunti yako';

  @override
  String get google_country => 'Nchi ya makazi';

  @override
  String get google_profileDescription =>
      'Chagua nchi yako na usome hati zote mbili ili kuunda akaunti yako ya FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Unganisha akaunti yako ya mgeni na Google. Usajili wako na kifaa chako vitabaki vimeunganishwa kwenye akaunti hii.';

  @override
  String get google_linkTitle => 'Unganisha Google na FuzeVPN';

  @override
  String get google_linkDescription =>
      'Thibitisha ufikiaji wa akaunti yako ya FuzeVPN iliyopo. Hatua hii haikuombi nenosiri lako la Google.';

  @override
  String get google_password => 'Nenosiri la FuzeVPN';

  @override
  String get google_linkAccount => 'Thibitisha kuunganisha akaunti';

  @override
  String get google_requestEmail => 'Nitumie barua pepe ya uthibitisho';

  @override
  String get google_emailInstructions =>
      'Fungua barua pepe ya FuzeVPN kisha uweke msimbo wa uthibitisho.';

  @override
  String get google_emailCode => 'Msimbo wa uthibitisho wa barua pepe';

  @override
  String get google_confirmEmail => 'Thibitisha msimbo';

  @override
  String get google_restart => 'Chagua akaunti nyingine ya Google';

  @override
  String get google_resume => 'Kagua jaribio hili';

  @override
  String get google_unavailable =>
      'Kuingia kwa Google hakupatikani. Unaweza kutumia barua pepe na nenosiri.';

  @override
  String get google_expired =>
      'Jaribio hili limeisha muda. Ghairi kisha uanze upya.';

  @override
  String get google_conflict =>
      'Akaunti hii ya Google tayari imeunganishwa mahali pengine. Akaunti yako ya sasa na usajili wako vimehifadhiwa.';

  @override
  String get google_error =>
      'Kuingia kwa Google kumeshindwa. Jaribu tena; ufikiaji wako wa sasa umehifadhiwa.';

  @override
  String get google_uncertain =>
      'Matokeo hayakuweza kuthibitishwa. Kagua jaribio hili au ghairi kabla ya kuanza upya.';

  @override
  String get google_cancelFailed =>
      'Kughairi hakukuweza kuthibitishwa. Jaribu kughairi tena kabla ya kuondoka kwenye skrini hii.';

  @override
  String get google_cancelled => 'Kuingia kwa Google kumeghairiwa.';

  @override
  String get google_selecting => 'Chagua akaunti yako ya Google…';

  @override
  String get google_verifying => 'Inakagua akaunti yako…';

  @override
  String get google_emailUnavailable =>
      'Barua pepe ya uthibitisho haikuweza kutumwa. Jaribu tena baadaye.';

  @override
  String get google_emailSent =>
      'Barua pepe ya uthibitisho imetumwa. Angalia kikasha chako.';

  @override
  String get google_rateLimited => 'Tafadhali subiri kabla ya kujaribu tena.';

  @override
  String get google_busy =>
      'Google haipatikani wakati operesheni nyingine inaendelea (muunganisho wa VPN, akaunti au mgeni). Jaribu tena ikishakamilika; ufikiaji wako wa sasa umehifadhiwa.';

  @override
  String get google_invalidPassword =>
      'Nenosiri la FuzeVPN si sahihi. Akaunti yako ya sasa imehifadhiwa.';

  @override
  String get google_invalidCode =>
      'Msimbo wa uthibitisho si sahihi au umeisha muda.';

  @override
  String get google_accountChanged =>
      'Kipindi chako kimebadilika. Ghairi jaribio hili kabla ya kuanza upya.';

  @override
  String get google_invalidResponse =>
      'Jibu halikuweza kuthibitishwa. Ufikiaji wako wa sasa umehifadhiwa.';

  @override
  String get google_invalidRegistration =>
      'Angalia nchi yako na idhini zote mbili.';

  @override
  String get google_consentRequired =>
      'Chagua nchi yako na ukubali hati zote mbili ili kuendelea.';

  @override
  String get google_challengeRequired =>
      'Ukaguzi wa ziada wa usalama unahitajika. Ufikiaji wako wa sasa umehifadhiwa.';

  @override
  String get google_challengeUnavailable =>
      'Ukaguzi wa usalama haupatikani. Jaribu tena baadaye.';

  @override
  String get google_intentMismatch =>
      'Jaribio la awali la kuingia kwa Google bado linasubiri. Ghairi kabla ya kuanza operesheni hii.';

  @override
  String get google_challengeBlocked =>
      'Ukaguzi wa usalama unaohitajika haupatikani kwenye programu hii. Operesheni hii haiwezi kukamilika kwa sasa.';

  @override
  String get google_solveChallenge => 'Kamilisha ukaguzi wa usalama';

  @override
  String get google_challengeTitle => 'Ukaguzi wa usalama';

  @override
  String get google_challengeReady =>
      'Uthibitishaji umekamilika. Sasa unaweza kuthibitisha kuundwa kwa akaunti yako.';

  @override
  String get google_challengeExpired =>
      'Uthibitishaji umeisha muda. Fanya tena kabla ya kuthibitisha.';

  @override
  String get google_challengeCancelled =>
      'Uthibitishaji umeghairiwa. Unaweza kujaribu tena.';

  @override
  String get google_challengeFailed =>
      'Ukaguzi wa usalama umeshindwa. Jaribu tena.';

  @override
  String get billing_trialTitle => 'Jaribu Fuze Premium bila malipo';

  @override
  String get billing_trialSubtitle => 'Linda muunganisho wako kuanzia leo.';

  @override
  String get billing_trialWeeks => 'Jaribio la bure la wiki 2';

  @override
  String billing_trialDays(String days) {
    return 'Jaribio la bure la siku $days';
  }

  @override
  String get billing_trialStart => 'Anza jaribio langu la bure';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ukianza leo, malipo yako ya kwanza yanatarajiwa tarehe $date.';
  }

  @override
  String get billing_trialTerms =>
      'Husasishwa kiotomatiki kwa bei iliyoonyeshwa. Ili kuepuka malipo, ghairi katika Google Play kabla jaribio halijaisha.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Kisha $price kwa mwezi';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Kisha $price kwa mwaka';
  }

  @override
  String get billing_choosePeriod => 'Chagua mpango wako';

  @override
  String get billing_selectionHint => 'Chagua mpango ili kuendelea.';

  @override
  String get billing_benefitConnection => 'Muunganisho uliosimbwa';

  @override
  String get billing_benefitPrivacy => 'Faragha mtandaoni';

  @override
  String get billing_benefitNoAccount => 'Huhitaji akaunti';

  @override
  String get billing_cancellation => 'Ghairi katika Google Play';

  @override
  String get billing_premiumTitle => 'Muunganisho ulio salama zaidi.';

  @override
  String get billing_premiumSubtitle =>
      'Linda muunganisho wako kwa mwendo wako.';

  @override
  String get billing_priceMonthly => 'kwa mwezi';

  @override
  String get billing_priceYearly => 'kwa mwaka';

  @override
  String get billing_trialToday => 'Hakuna malipo leo';

  @override
  String get billing_trialConfirmation =>
      'Google Play huthibitisha tarehe, kiasi cha mwisho na kodi zinazotumika kabla hujathibitisha.';

  @override
  String get billing_offerChanged =>
      'Masharti ya ofa hii yamebadilika. Onyesha upya mipango kisha uchague tena.';

  @override
  String get status_waitingNetwork => 'Inasubiri mtandao';

  @override
  String get status_waitingNetworkDetail =>
      'Hakuna mtandao unaopatikana. VPN itathibitisha muunganisho mtandao utakaporudi.';

  @override
  String get locations_favoriteLoadFailed =>
      'Vipendwa havikuweza kupakiwa. Jaribu tena.';

  @override
  String get locations_favoritesLoading => 'Inapakia vipendwa…';
}
