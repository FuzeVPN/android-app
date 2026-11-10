// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kinyarwanda (`rw`).
class AppLocalizationsRw extends AppLocalizations {
  AppLocalizationsRw([String locale = 'rw']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Kurinda ihuza ryanyu';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ikoresha serivisi ya VPN ya Android (VpnService) kugira ngo ikore umuyoboro w’ibanga hagati y’iki gikoresho na seriveri za FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Igihe VPN ikora, urujya n’uruza rw’interineti rwa porogaramu zanyu, aderesi z’aho zerekeza n’ibyifuzo bya DNS binyura muri uyu muyoboro kugira ngo ihuza ryanyu riyoborwe, n’iyo FuzeVPN ikorera inyuma.';

  @override
  String get vpnDisclosure_statusBody =>
      'Porogaramu ikoresha uko ihuza rihagaze, igihe rimaze n’ingano y’amakuru yahererekanyijwe kugira ngo igaragaze ihuza ryanyu rya VPN. Mushobora guhagarika VPN igihe icyo ari cyo cyose.';

  @override
  String get vpnDisclosure_privacy => 'Ubuzima bwite';

  @override
  String get vpnDisclosure_accept => 'Kwemera no gukomeza';

  @override
  String get vpnDisclosure_decline => 'Si ubu';

  @override
  String get accountRestoration_title => 'Konti ntiboneka by’agateganyo';

  @override
  String get accountRestoration_message =>
      'Igihe cyanyu cyo kwinjira cyabitswe. Mwongere mugerageze kugarura konti yanyu. Mushobora gukomeza gucunga ihuza rya VPN hano.';

  @override
  String get action_retry => 'Kongera kugerageza';

  @override
  String get session_endingTitle => 'Gusoza igihe cyo kwinjira';

  @override
  String get session_ending =>
      'Igihe cyo kwinjira kirimo gusozwa: guhagarika VPN no gusukura…';

  @override
  String get session_stopFailed =>
      'Guhagarika VPN ntibyemejwe. Mwongere mugerageze mbere yo kongera kwinjira.';

  @override
  String get session_cleanupFailed =>
      'VPN yahagaritswe, ariko gukuraho igihe cyo kwinjira ntibyemejwe. Mwongere mugerageze gusukura.';

  @override
  String get session_retryStop => 'Kongera guhagarika';

  @override
  String get session_retryCleanup => 'Kongera gusukura';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN irimo gutegurwa mu buryo butekanye…';

  @override
  String get nav_connection => 'Ihuza';

  @override
  String get nav_locations => 'Ahantu';

  @override
  String get nav_account => 'Konti';

  @override
  String get nav_devices => 'Ibikoresho';

  @override
  String get nav_settings => 'Igenamiterere';

  @override
  String get action_refresh => 'Kuvugurura';

  @override
  String get auth_tab_login => 'Kwinjira';

  @override
  String get auth_tab_register => 'Kwiyandikisha';

  @override
  String get auth_stepAccount => 'Konti';

  @override
  String get auth_stepIdentity => 'Umwirondoro';

  @override
  String get auth_stepAddress => 'Aderesi n’amasezerano';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Intambwe ya $current kuri $total';
  }

  @override
  String get auth_tagline => 'VPN yanyu, mu buryo bworoshye.';

  @override
  String get auth_keysLocal =>
      'Imfunguzo zanyu z’ibanga za VPN ziguma kuri iki gikoresho.';

  @override
  String get form_email => 'Aderesi y’imeyili';

  @override
  String get form_password => 'Ijambobanga';

  @override
  String get form_showPassword => 'Kwerekana ijambobanga';

  @override
  String get form_hidePassword => 'Guhisha ijambobanga';

  @override
  String get form_passwordMin =>
      'Bayiti 8–72 za UTF-8. Inyuguti zimwe zikoresha bayiti zirenze imwe.';

  @override
  String get form_firstName => 'Izina rya mbere';

  @override
  String get form_lastName => 'Izina ry’umuryango';

  @override
  String get form_phone => 'Telefoni (+33612345678)';

  @override
  String get form_address => 'Aderesi';

  @override
  String get form_address2 => 'Umurongo wa kabiri wa aderesi (si ngombwa)';

  @override
  String get form_postalCode => 'Kode y’iposita';

  @override
  String get form_city => 'Umujyi';

  @override
  String get form_country => 'Kode y’igihugu (urugero: FR)';

  @override
  String get action_login => 'Kwinjira';

  @override
  String get action_createAccount => 'Gukora konti';

  @override
  String get action_createMyAccount => 'Gukora konti yanjye';

  @override
  String get action_next => 'Gukomeza';

  @override
  String get action_previous => 'Gusubira inyuma';

  @override
  String get action_forgotPassword => 'Mwibagiwe ijambobanga?';

  @override
  String get auth_noAccount => 'Nta konti mufite?';

  @override
  String get auth_requiredInformation =>
      'Mukore konti yanyu mu ntambwe eshatu.';

  @override
  String get auth_termsPrefix => 'Nemera ';

  @override
  String get auth_termsLink => 'amabwiriza yo gukoresha';

  @override
  String get auth_privacyPrefix => 'Nemera ';

  @override
  String get auth_privacyLink => 'politiki y’ubuzima bwite';

  @override
  String get auth_consentRequired =>
      'Kwemera kwanyu birakenewe kugira ngo mukore konti.';

  @override
  String get validation_required => 'Uyu mwanya ugomba kuzuzwa.';

  @override
  String get validation_email => 'Mwinjize aderesi y’imeyili yemewe.';

  @override
  String get validation_password =>
      'Ijambobanga rigufi cyane: nibura bayiti 8 za UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Ijambobanga rirerire cyane: ntirigomba kurenza bayiti 72 za UTF-8.';

  @override
  String get validation_phone =>
      'Mukoreshe imiterere mpuzamahanga, urugero: +33612345678.';

  @override
  String get validation_country =>
      'Mukoreshe kode y’igihugu y’inyuguti ebyiri, urugero: FR.';

  @override
  String get passwordReset_title => 'Gushyiraho ijambobanga rishya';

  @override
  String get passwordReset_description =>
      'Mwinjize aderesi y’imeyili ya konti yanyu kugira ngo musabe umurongo wo gushyiraho ijambobanga rishya.';

  @override
  String get passwordReset_send => 'Kohereza umurongo';

  @override
  String get connection_title => 'Ihuza ryanyu';

  @override
  String get connection_subtitle =>
      'Muhitemo ahantu, hanyuma mufungure VPN yanyu.';

  @override
  String get connection_prepare => 'Mwiteguye guhuza?';

  @override
  String get connection_advancedOptions => 'Amahitamo y’inyongera';

  @override
  String get connection_location => 'Ahantu';

  @override
  String get connection_chooseLocation => 'Guhitamo ahantu';

  @override
  String get connection_protocol => 'Protokole';

  @override
  String get connection_connect => 'Guhuza';

  @override
  String get connection_connecting => 'Irimo guhuza…';

  @override
  String get connection_disconnect => 'Guhagarika';

  @override
  String get connection_disconnecting => 'Irimo guhagarika';

  @override
  String get connection_locationChange => 'Irimo guhindura ahantu…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ntiboneka';
  }

  @override
  String get connection_activeLocation => 'Ahantu hakoreshwa ubu';

  @override
  String get connection_duration => 'Igihe kimaze';

  @override
  String get connection_received => 'Byakiriwe';

  @override
  String get connection_sent => 'Byoherejwe';

  @override
  String get connection_lastHandshake =>
      'Ihererekanyamakuru ritekanye riheruka';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Hashize $duration';
  }

  @override
  String get verification_title => 'Mwemeze aderesi y’imeyili yanyu';

  @override
  String get verification_message =>
      'Mwemeze aderesi y’imeyili yanyu kugira ngo mukoreshe VPN kuri iyi telefoni.';

  @override
  String get verification_resend => 'Kongera kohereza imeyili';

  @override
  String get migration_title => 'Guhindura ahantu';

  @override
  String get migration_draining => 'Irimo gutegura guhindura ahantu…';

  @override
  String get migration_activating => 'Irimo gutangiza seriveri nshya…';

  @override
  String get migration_ready => 'Ahantu hahinduwe.';

  @override
  String get migration_blocked =>
      'Guhindura ahantu bisaba ko hagira igikorwa kuri seriveri. Mwongere mugerageze nyuma cyangwa muvugane n’ubufasha.';

  @override
  String get migration_progress => 'Aho guhindura ahantu bigeze';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Igihe cyo gutegereza hagati y’amagenzura: amasegonda $seconds.';
  }

  @override
  String get migration_resume => 'Gusubukura guhindura ahantu';

  @override
  String get status_authorizing => 'Uruhushya rurakenewe';

  @override
  String get status_authorizingDetail =>
      'Mwemere icyifuzo cya Android kugira ngo VPN yemererwe gukora.';

  @override
  String get status_preparing => 'Irategurwa';

  @override
  String get status_preparingDetail => 'Ihuza ryanyu ritekanye rirategurwa.';

  @override
  String get status_reconnecting => 'Irongera guhuza…';

  @override
  String get status_reconnectingDetail =>
      'Ihuza ryacitse. VPN irimo kugerageza kongera guhuza.';

  @override
  String get status_connecting => 'Irimo guhuza';

  @override
  String get status_connectingDetail => 'Irimo guhuza na seriveri ya VPN…';

  @override
  String get status_connected => 'Byahujwe';

  @override
  String get status_connectedDetail => 'Ihuza ryanyu rya VPN rirakora.';

  @override
  String get status_disconnecting => 'Irimo guhagarika';

  @override
  String get status_disconnectingDetail =>
      'Ihuza ryanyu rya VPN ririmo guhagarara.';

  @override
  String get status_error => 'Ihuza ntiriboneka';

  @override
  String get status_errorDetail =>
      'Ihuza rya VPN ntiryemejwe. Mwongere mugerageze.';

  @override
  String get status_idle => 'Ntibyahujwe';

  @override
  String get status_idleDetail => 'Muhuze VPN kugira ngo murinde ihuza ryanyu.';

  @override
  String get trust_note =>
      'Gufunga porogaramu ntibihagarika VPN. Kugira ngo muyihagarike, mukoreshe Guhagarika.';

  @override
  String get locations_none => 'Nta hantu haboneka ubu.';

  @override
  String get locations_available => 'Muhitemo ahantu hakurikira.';

  @override
  String get locations_selected => 'Ahantu hatoranyijwe';

  @override
  String get locations_select => 'Guhitamo aha hantu';

  @override
  String get locations_lockedTunnel =>
      'Muhagarike VPN kugira ngo muhindure ahantu.';

  @override
  String get locations_lockedMigration =>
      'Mutegereze ko guhindura ahantu birangira.';

  @override
  String get devices_title => 'Ibikoresho byanyu';

  @override
  String devices_used(Object count, Object limit) {
    return 'Ibikoresho $count kuri $limit';
  }

  @override
  String get devices_refresh => 'Kuvugurura ibikoresho';

  @override
  String get devices_empty => 'Nta gikoresho cya VPN kiranditswe kugeza ubu.';

  @override
  String get devices_firstConnection =>
      'Telefoni yanyu izongerwamo igihe muzahuza bwa mbere.';

  @override
  String get devices_thisDevice => 'Iki gikoresho';

  @override
  String devices_added(Object date) {
    return 'Cyongewe tariki $date';
  }

  @override
  String get devices_unnamed => 'Igikoresho kitagira izina';

  @override
  String get action_remove => 'Gukuraho';

  @override
  String get settings_title => 'Igenamiterere';

  @override
  String get settings_subtitle =>
      'Ibyo mwihitiyemo na konti yanyu, byose biri ahantu hamwe.';

  @override
  String get settings_appearance => 'Isura';

  @override
  String get settings_language => 'Ururimi';

  @override
  String get settings_languageDescription =>
      'Ururimi mwahisemo ruzakoreshwa no mu menyesha ya VPN.';

  @override
  String get settings_account => 'Konti';

  @override
  String get settings_signOut => 'Gusohoka';

  @override
  String get settings_privacy => 'Politiki y’ubuzima bwite';

  @override
  String get settings_terms => 'Amabwiriza yo gukoresha';

  @override
  String get settings_security => 'Umutekano no gukorera mu mucyo';

  @override
  String get settings_licenses => 'Impushya z’ibice bya porogaramu';

  @override
  String get settings_licensesDetail =>
      'Porogaramu mudasobwa zikoreshwa muri iyi porogaramu';

  @override
  String settings_licensesLegalese(String url) {
    return 'Kode y’inkomoko ya porogaramu n’iy’ibice byayo bifite uruhushya rwa MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'Igihe muvuye muri porogaramu, VPN ikomeza gukora. Kugira ngo muyihagarike, mukoreshe Guhagarika ku gice cy’Ihuza.';

  @override
  String get theme_system => 'Sisitemu';

  @override
  String get theme_light => 'Umucyo';

  @override
  String get theme_dark => 'Umwijima';

  @override
  String get language_system => 'Ururimi rwa telefoni';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Gukuraho iki gikoresho?';

  @override
  String get dialog_removeCurrent =>
      'Iyi telefoni izavanwa kuri VPN kandi izatakaza uburenganzira bwo kuyikoresha. Amakuru y’ihuza rya VPN yayo azakurwaho seriveri imaze kubyemeza.';

  @override
  String dialog_removeOther(Object name) {
    return 'Uburenganzira bwa VPN bwa “$name” buzakurwaho. Ibi ntibishobora gusubizwa inyuma.';
  }

  @override
  String get dialog_signOut => 'Gusohoka muri konti?';

  @override
  String get dialog_signOutMessage =>
      'VPN izahagarara kandi muzakenera kongera kwinjira. Imfunguzo zanyu za VPN zibitswe mu buryo bw’ibanga zizaguma kuri iyi telefoni kugira ngo muzazikoreshe ubutaha muzahuza.';

  @override
  String get action_cancel => 'Kureka';

  @override
  String get action_close => 'Funga';

  @override
  String get action_copy => 'Koporora';

  @override
  String get action_signOut => 'Gusohoka';

  @override
  String get notice_close => 'Gufunga ubutumwa';

  @override
  String get notice_sessionExpired_title => 'Igihe cyo kwinjira cyarangiye';

  @override
  String get notice_sessionExpired_message =>
      'Igihe cyanyu cyo kwinjira cyarangiye. Mwongere mwinjire.';

  @override
  String get notice_connectionFailed_title => 'Guhuza ntibyashobotse';

  @override
  String get notice_invalidCredentials_message =>
      'Aderesi y’imeyili cyangwa ijambobanga si byo.';

  @override
  String get notice_emailVerification_title => 'Birakenewe kwemeza imeyili';

  @override
  String get notice_emailVerification_message =>
      'Mwemeze aderesi y’imeyili yanyu mbere yo kongeramo igikoresho cya VPN.';

  @override
  String get notice_rateLimited_title => 'Mwagerageje inshuro nyinshi';

  @override
  String get notice_deviceLimit_title =>
      'Umubare ntarengwa w’ibikoresho wagezweho';

  @override
  String get notice_deviceLimit_message =>
      'Mubanze mukureho igikoresho gisanzweho mbere yo kongeraho ikindi.';

  @override
  String get notice_identityRenewal_title =>
      'Umwirondoro wa VPN ugomba kuvugururwa';

  @override
  String get notice_identityRenewal_message =>
      'Uyu mwirondoro wakuweho. Mukore umwirondoro mushya wo kuri iki gikoresho.';

  @override
  String get notice_migrationPending_title => 'Guhindura ahantu birimo gukorwa';

  @override
  String get notice_migrationPending_message =>
      'Hari uguhindura ahantu kurimo gukorwa.';

  @override
  String get notice_migrationBlocked_title => 'Guhindura ahantu byahagaritswe';

  @override
  String get notice_migrationBlocked_message =>
      'Guhindura ahantu bisaba ko hagira igikorwa kuri seriveri. Mwongere mugerageze nyuma cyangwa muvugane n’ubufasha.';

  @override
  String get notice_targetUnavailable_title =>
      'Seriveri ntiboneka by’agateganyo';

  @override
  String get notice_targetUnavailable_message =>
      'Iyi seriveri ntiboneka by’agateganyo.';

  @override
  String get notice_networkUnavailable_title =>
      'Ihuza ry’interineti ntiriboneka';

  @override
  String get notice_networkUnavailable_message =>
      'Mugenzure ihuza ryanyu, hanyuma mwongere mugerageze.';

  @override
  String get notice_permissionDenied_title => 'Uruhushya rwa VPN rwanzwe';

  @override
  String get notice_permissionDenied_message =>
      'Mwongere mutangire ihuza, hanyuma mwemere icyifuzo cy’uruhushya rwa Android.';

  @override
  String get notice_wireguardTimeout_title => 'Seriveri ntisubiza';

  @override
  String get notice_wireguardTimeout_message =>
      'Ihuza rya WireGuard ryafashe igihe kirekire cyane. Mwongere mugerageze cyangwa muhitemo ahandi hantu.';

  @override
  String get notice_tlsFailed_title => 'Ihuza ritekanye ryanzwe';

  @override
  String get notice_tlsFailed_message =>
      'Seriveri ntiyemeye ihuza rya OpenVPN. Mwongere mugerageze. Niba ikibazo gikomeje, mukore isuzuma.';

  @override
  String get notice_tunRejected_title => 'Android yanze interfase ya VPN';

  @override
  String get notice_tunRejected_message =>
      'Android yanze igenamiterere ry’urusobe OpenVPN yasabye.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN ntiyashoboye gutangira';

  @override
  String get notice_openvpnStart_message =>
      'Moteri ya OpenVPN ntiyashoboye kurangiza gutangira. Mwongere mugerageze. Niba ikibazo gikomeje, muvugane n’ubufasha.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kode y’isuzuma: $code';
  }

  @override
  String get notice_generic_title => 'Ihuza rya VPN ntiryashobotse';

  @override
  String get notice_generic_message =>
      'Habaye ikosa. Mwongere mugerageze nyuma.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konti yakozwe',
      'password_reset_sent':
          'Ubusabe bwo gushyiraho ijambobanga rishya bwakiriwe',
      'verification_email_sent': 'Imeyili yo kwemeza yoherejwe',
      'location_migration_pending': 'Guhindura ahantu birimo gukorwa',
      'vpn_sign_in_required': 'Birakenewe kwinjira',
      'protocol_unavailable_at_location': 'Protokole ntiboneka aha hantu',
      'vpn_permission_denied': 'Uruhushya rwa VPN rwanzwe',
      'revoked_identity_device_limit':
          'Umubare ntarengwa w’ibikoresho wagezweho',
      'tunnel_start_unexpected': 'VPN ntiyashoboye gutangira',
      'flutter_disconnect_timeout': 'Guhagarika ntibyemejwe',
      'flutter_disconnect_unexpected': 'Guhagarika ntibyashobotse',
      'device_revoked': 'Igikoresho cyakuweho',
      'revoke_unexpected': 'Ntibyashobotse gukuraho igikoresho',
      'identity_renewal_unexpected': 'Ntibyashobotse kuvugurura umwirondoro',
      'openvpn_renewal_unexpected': 'Ntibyashobotse kuvugurura OpenVPN',
      'location_migration_blocked': 'Guhindura ahantu byahagaritswe',
      'location_migration_slow': 'Guhindura ahantu biracyakomeje',
      'location_migration_conflict': 'Guhindura ahantu bisaba kuvugururwa',
      'location_migration_verification_failed': 'Guhindura ahantu ntibyemejwe',
      'location_migration_device_changed':
          'Igikoresho cyahindutse mu gihe cyo guhindura ahantu',
      'tunnel_stop_failed': 'Guhindura ahantu ntibishoboka',
      'device_clock_ahead': 'Isaha y’igikoresho iri imbere',
      'other': 'Igikorwa ntikigenze neza',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Konti yakozwe, ariko imeyili yo kwemeza ntiyashoboye koherezwa. Mukoreshe uburyo bwo kongera kohereza muri porogaramu.',
      'password_reset_sent':
          'Ubusabe bwanyu bwakiriwe. Niba hari konti ihuye n’iyi aderesi, mushobora kubona imeyili. Mugenzure no mu bubiko bw’imeyili zitifuzwa (spam).',
      'verification_email_sent': 'Imeyili nshya yo kwemeza imaze koherezwa.',
      'location_migration_pending':
          'Kwimukira kuri $target biracyategurwa. Mushobora kubisubukura mudakoze igikoresho bundi bushya.',
      'vpn_sign_in_required':
          'Mwinjire muri konti yanyu mbere yo gutangiza VPN.',
      'protocol_unavailable_at_location':
          'Protokole mwahisemo ntitangwa n’aha hantu. Muvugurure ahantu cyangwa muhitemo indi protokole.',
      'vpn_permission_denied':
          'Android yanze uruhushya rwa VPN. Mwongere mutangire ihuza, hanyuma mwemere icyifuzo cya sisitemu.',
      'revoked_identity_device_limit':
          'Uburenganzira bwa VPN bw’iki gikoresho bwakuweho, kandi umubare ntarengwa w’ibikoresho wagezweho. Mukureho igikoresho muri Konti → Gucunga ibikoresho byanyu.',
      'tunnel_start_unexpected':
          'Ikosa ritunguranye ryahagaritse gutegura umuyoboro. Mugenzure kode y’isuzuma hanyuma mwongere mugerageze.',
      'flutter_disconnect_timeout':
          'Android ntiyemeje ko VPN yahagaze mu gihe cyagenwe. Mwongere mugerageze kuyihagarika.',
      'flutter_disconnect_unexpected':
          'Ikosa ritunguranye ryabujije kwemeza ko umuyoboro wahagaze.',
      'device_revoked':
          'Uburenganzira bwa VPN bw’iki gikoresho bwakuweho kandi amabanga yacyo abitswe ku gikoresho yakuweho.',
      'revoke_unexpected':
          'Ntibyashobotse gukuraho igikoresho. Muvugurure urutonde hanyuma mwongere mugerageze.',
      'identity_renewal_unexpected':
          'Ntibyashobotse gukora umwirondoro mushya wa VPN. Muvugurure ibikoresho hanyuma mwongere mugerageze.',
      'openvpn_renewal_unexpected':
          'Ntibyashobotse kuvugurura profayili ya OpenVPN. Mwongere mugerageze cyangwa mugenzure kode y’isuzuma.',
      'location_migration_blocked':
          'Seriveri ntishobora kurangiza uku guhindura ubu. Igikoresho n’umwirondoro wacyo wo kuri cyo byarabitswe.',
      'location_migration_slow':
          'Seriveri iracyategura kwimukira kuri $target. Mukoreshe Gusubukura nyuma y’akanya gato.',
      'location_migration_conflict':
          'Imiterere y’igikoresho yahindutse kuri seriveri. Muvugurure ibikoresho, hanyuma musubukure guhindura ahantu.',
      'location_migration_verification_failed':
          'Seriveri ntiyemeje ahantu hashya. Umwirondoro wabanje wo ku gikoresho wabitswe.',
      'location_migration_device_changed':
          'Igikoresho seriveri yagaruye ntigihuye n’icyari gihindurwa. Muvugurure ibikoresho mbere yo kongera kugerageza.',
      'tunnel_stop_failed':
          'Umuyoboro wabanje ugomba guhagarikwa burundu mbere y’ihuza rishya.',
      'device_clock_ahead':
          'Isaha y’iki gikoresho isa n’iri imbere. Mufungure itariki n’isaha byikora kugira ngo mukomeze kwinjira.',
      'other':
          'Igikorwa ntikirangiye. Mwongere mugerageze cyangwa mwohereze kode y’isuzuma ku bufasha.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Igihe cyo kwinjira cyarangiye',
      'invalid_credentials': 'Kwinjira ntibyashobotse',
      'email_verification_required': 'Birakenewe kwemeza imeyili',
      'verification_email_cooldown': 'Imeyili yamaze koherezwa',
      'rate_limited': 'Mwagerageje inshuro nyinshi',
      'invalid_registration': 'Amakuru agomba gukosorwa',
      'email_exists': 'Konti isanzwe ihari',
      'invalid_profile': 'Umwirondoro ntiwemewe',
      'invalid_device': 'Igikoresho ntikemewe',
      'invalid_location': 'Ahantu ntihaboneka',
      'device_limit': 'Umubare ntarengwa w’ibikoresho wagezweho',
      'device_exists': 'Umwirondoro wa VPN usanzwe ukoreshwa',
      'device_identity_revoked': 'Umwirondoro wa VPN ugomba kuvugururwa',
      'device_location_locked': 'Guhindura ahantu bisaba kuvugururwa',
      'location_migration_pending': 'Guhindura ahantu birimo gukorwa',
      'location_migration_blocked': 'Guhindura ahantu byahagaritswe',
      'target_ca_mismatch': 'Seriveri ya OpenVPN ntihuye',
      'location_migration_conflict': 'Guhindura ahantu bisaba kuvugururwa',
      'server_full': 'Seriveri yuzuye',
      'capacity_unavailable': 'Ahantu ntihaboneka by’agateganyo',
      'target_unavailable': 'Seriveri ntiboneka by’agateganyo',
      'not_found': 'Ikintu ntikiboneka',
      'invalid_openvpn_csr': 'Umwirondoro wa OpenVPN ntiwemewe',
      'openvpn_profile_exists': 'Profayili ya OpenVPN isanzweho',
      'openvpn_profile_revoked': 'Profayili ya OpenVPN yakuweho',
      'openvpn_operation_pending': 'Igikorwa cya OpenVPN kirimo gukorwa',
      'openvpn_operation_terminal': 'Igikorwa cya OpenVPN cyahagaze',
      'openvpn_address_unavailable': 'Aderesi ya OpenVPN ntiboneka',
      'openvpn_profile_conflict': 'Ukudahuza kwa OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN ntiboneka',
      'email_delivery_unavailable': 'Imeyili ntiboneka',
      'invalid_token': 'Umurongo ntiwemewe',
      'network_unavailable': 'Ihuza ry’interineti ntiriboneka',
      'invalid_json': 'Icyifuzo ntikemewe',
      'invalid_api_response': 'Igisubizo cya seriveri ntikemewe',
      'ipv6_unavailable': 'IPv6 ntiboneka',
      'invalid_ip_families': 'Igenamiterere ry’urusobe ryanzwe',
      'other': 'Serivisi ntiboneka',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized':
          'Igihe cyanyu cyo kwinjira cyarangiye. Mwongere mwinjire.',
      'invalid_credentials': 'Aderesi y’imeyili cyangwa ijambobanga si byo.',
      'email_verification_required':
          'Mwemeze aderesi y’imeyili yanyu mbere yo kongeramo igikoresho cya VPN.',
      'invalid_registration': 'Mugenzure amakuru asabwa n’ibyo mwemeye.',
      'email_exists': 'Hari konti isanzwe ikoresha iyi aderesi y’imeyili.',
      'invalid_profile': 'Mugenzure amakuru y’umwirondoro wanyu.',
      'invalid_device':
          'Izina ry’iki gikoresho cyangwa umwirondoro wacyo wo kuri cyo ntibyemewe.',
      'invalid_location':
          'Muvugurure urutonde rw’ahantu, hanyuma mwongere mugerageze.',
      'device_limit':
          'Mubanze mukureho igikoresho gisanzweho mbere yo kongeraho ikindi.',
      'device_exists': 'Uyu mwirondoro wa VPN usanzwe uhujwe n’indi konti.',
      'device_identity_revoked':
          'Uyu mwirondoro wakuweho. Hagomba gukorwa umwirondoro mushya wo kuri iki gikoresho.',
      'device_location_locked':
          'Ahantu h’iki gikoresho hahinduwe vuba aha. Porogaramu izakomeza impinduka yari irimo gukorwa.',
      'location_migration_pending': 'Hari uguhindura ahantu kurimo gukorwa.',
      'location_migration_blocked':
          'Guhindura ahantu bisaba ko hagira igikorwa kuri seriveri. Mwongere mugerageze nyuma cyangwa muvugane n’ubufasha.',
      'target_ca_mismatch':
          'Iyi seriveri ntirahuza na profayili ya OpenVPN iriho.',
      'location_migration_conflict':
          'Muvugurure ibikoresho, hanyuma mwongere mugerageze guhindura ahantu.',
      'server_full':
          'Aha hantu hageze ku mubare ntarengwa w’ihuza. Muhitemo ahandi hantu cyangwa mwongere mugerageze nyuma.',
      'capacity_unavailable':
          'Ntidushobora kwemeza niba aha hantu haboneka ubu. Muhitemo ahandi hantu cyangwa mwongere mugerageze nyuma.',
      'target_unavailable': 'Iyi seriveri ntiboneka by’agateganyo.',
      'not_found': 'Iki kintu ntikikiboneka kuri konti yanyu.',
      'invalid_openvpn_csr':
          'Mukore umwirondoro mushya wa OpenVPN, hanyuma mwongere mugerageze.',
      'openvpn_profile_exists':
          'Hari profayili ya OpenVPN isanzweho kuri iki gikoresho.',
      'openvpn_profile_revoked':
          'Muvugurure profayili ya OpenVPN kugira ngo mukomeze.',
      'openvpn_operation_pending':
          'Impinduka iracyakwirakwira. Mwongere mugerageze nyuma.',
      'openvpn_operation_terminal':
          'Mukore umwirondoro mushya wa OpenVPN, hanyuma mwongere mugerageze.',
      'openvpn_address_unavailable': 'Nta aderesi ya OpenVPN iboneka ubu.',
      'openvpn_profile_conflict':
          'Profayili yahindutse. Muvugurure ibikoresho, hanyuma mwongere mugerageze.',
      'openvpn_signer_unavailable':
          'Serivisi ya OpenVPN ntiboneka by’agateganyo.',
      'email_delivery_unavailable':
          'Imeyili ntiyashoboye koherezwa. Mwongere mugerageze nyuma.',
      'invalid_token':
          'Uyu murongo ntiwemewe cyangwa warangije igihe. Musabe undi.',
      'network_unavailable':
          'Mugenzure ihuza ryanyu ry’interineti, hanyuma mwongere mugerageze.',
      'invalid_json':
          'Mugenzure amakuru mwinjije, hanyuma mwongere mugerageze.',
      'invalid_api_response':
          'Seriveri yasubije igisubizo kitari giteganyijwe. Mwongere mugerageze nyuma.',
      'ipv6_unavailable':
          'Seriveri ntishobora gukoresha IPv6 ubu. Mwongere mugerageze nyuma.',
      'invalid_ip_families':
          'Igenamiterere ry’umuyoboro ntiryuzuye cyangwa ntirihuza n’aderesi zemewe. Mwongere mugerageze muri porogaramu.',
      'other': 'Habaye ikosa rya seriveri. Mwongere mugerageze nyuma.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Mwongere mugerageze nyuma y’akanya gato.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Mwongere mugerageze nyuma y’amasegonda $seconds.',
      one: 'Mwongere mugerageze nyuma y’isegonda $seconds.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Mwongere mugerageze nyuma y’iminota $minutes.',
      one: 'Mwongere mugerageze nyuma y’umunota $minutes.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Mwongere mugerageze nyuma y’amasaha $hours.',
      one: 'Mwongere mugerageze nyuma y’isaha $hours.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Gusubukura VPN ya sisitemu ntibiboneka',
      'system_vpn_resume_corrupt': 'Gusubukura VPN ya sisitemu ntibyemewe',
      'system_vpn_resume_session_invalid':
          'Igihe cyo kwinjira cyo gusubukura VPN ntikemewe',
      'system_vpn_resume_identity_changed': 'Umwirondoro wa VPN wahindutse',
      'system_vpn_resume_identity_invalid':
          'Umwirondoro wo gusubukura VPN ntiwemewe',
      'system_vpn_resume_storage_failed':
          'Ububiko bwo gusubukura VPN ntibuboneka',
      'system_vpn_resume_network_timeout':
          'Nta rusobe rwabonetse mu gusubukura VPN',
      'system_vpn_resume_blocked': 'Gusubukura VPN birabujijwe',
      'system_vpn_resume_failed': 'Gusubukura VPN ntibyashobotse',
      'system_vpn_resume_error_invalid': 'Ikosa ryo gusubukura VPN ntiryemewe',
      'wireguard_identity_store_failed': 'Umwirondoro wa WireGuard ntiwabitswe',
      'wireguard_identity_unavailable': 'Nta mwirondoro wa WireGuard uboneka',
      'vpn_host_destroyed': 'Igice cya Android cyakira VPN cyarahagaze',
      'vpn_host_unavailable': 'Igice cya Android cyakira VPN ntikiboneka',
      'vpn_permission_required': 'Hakenewe uruhushya rwa VPN',
      'vpn_permission_denied': 'Uruhushya rwa VPN rwanzwe',
      'vpn_permission_request_failed': 'Gusaba uruhushya ntibyashobotse',
      'wireguard_foreground_service_unavailable':
          'Serivisi ya WireGuard ntiboneka',
      'wireguard_identity_invalid':
          'Urufunguzo rwa WireGuard rwo ku gikoresho ntirwemewe',
      'wireguard_identity_in_use': 'Umwirondoro wa WireGuard uracyakoreshwa',
      'wireguard_configuration_invalid':
          'Igenamiterere rya WireGuard ntirikwiye',
      'wireguard_operation_pending': 'Igikorwa cya WireGuard kiracyakora',
      'wireguard_start_failed': 'WireGuard yanze gutangira',
      'wireguard_stop_timeout': 'WireGuard ntiyemeje guhagarara',
      'wireguard_handshake_timeout': 'WireGuard ntiyasubije',
      'openvpn_connection_timeout': 'OpenVPN ntiyasubije',
      'openvpn_core_unavailable': 'Moteri ya OpenVPN ntiboneka',
      'openvpn_operation_pending': 'OpenVPN iracyakora',
      'openvpn_stop_timeout': 'OpenVPN ntiyemeje guhagarara',
      'openvpn_profile_unavailable':
          'Profayili ya OpenVPN yo ku gikoresho ntiboneka',
      'openvpn_native_failed': 'Guhamagara OpenVPN byahagaritswe',
      'openvpn_key_generation_failed':
          'Ntibyashobotse gukora urufunguzo rwa OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Ntibyashobotse gukora CSR ya OpenVPN',
      'openvpn_identity_store_failed': 'Umwirondoro wa OpenVPN ntiwabitswe',
      'openvpn_identity_clear_failed': 'Gukuraho OpenVPN ntibyuzuye',
      'openvpn_identity_in_use': 'Umwirondoro wa OpenVPN uracyakoreshwa',
      'openvpn_tls_verification_required': 'Kugenzura TLS kwa OpenVPN kubuze',
      'openvpn_cipher_invalid': 'Algoritimu ya OpenVPN ntiyemewe',
      'openvpn_profile_rejected': 'Profayili ya OpenVPN yanzwe',
      'openvpn_identity_inconsistent': 'Umwirondoro wa OpenVPN udahuye',
      'tls_handshake_failed': 'Kumvikana kwa OpenVPN kwanzwe',
      'tls_alert_unknown_ca': 'Icyemezo cy’igikoresho cya OpenVPN ntikizwi',
      'tls_alert_bad_certificate': 'Icyemezo cy’igikoresho cya OpenVPN cyanzwe',
      'tls_alert_unsupported_certificate':
          'Icyemezo cya OpenVPN ntigishyigikirwa',
      'tls_client_certificate_required':
          'Icyemezo cy’igikoresho cya OpenVPN kirakenewe',
      'tls_alert_misc': 'Ikimenyetso cya TLS cya OpenVPN',
      'tls_signature_algorithm_rejected': 'Umukono wa OpenVPN ntushyigikirwa',
      'tls_handshake_rejected': 'Kumvikana kwa TLS kwa OpenVPN kwanzwe',
      'tls_version_rejected': 'Verisiyo ya TLS ya OpenVPN ntihuye',
      'tls_certificate_expired': 'Icyemezo cya TLS cyarangiye',
      'tls_certificate_revoked': 'Icyemezo cya TLS cyakuweho',
      'transport_failed': 'Seriveri ya OpenVPN ntiyagerwaho',
      'tun_configuration_rejected':
          'Ntibyashobotse gukora interfase ya OpenVPN',
      'tun_setup_failed': 'Gutegura TUN ya OpenVPN ntibyashobotse',
      'tun_interface_create_failed':
          'Gukora interfase ya OpenVPN ntibyashobotse',
      'tun_interface_disabled': 'Interfase ya OpenVPN yarazimijwe',
      'tun_halted': 'Interfase ya OpenVPN yarahagaritswe',
      'tun_already_established': 'Interfase ya OpenVPN isanzwe ifunguye',
      'tun_addresses_missing': 'Aderesi ya OpenVPN ntiboneka',
      'tun_routes_missing': 'Inzira za OpenVPN ntizihari',
      'tun_dns_missing': 'DNS ya OpenVPN ntihari',
      'tun_permission_revoked': 'Uruhushya rwa VPN rwakuweho',
      'tun_establish_returned_null': 'Android yanze interfase ya VPN',
      'openvpn_service_start_failed': 'Serivisi ya OpenVPN ntiboneka',
      'openvpn_operation_timeout': 'Guhamagara OpenVPN byarenze igihe',
      'openvpn_start_failed': 'OpenVPN yanze gutangira',
      'openvpn_connection_failed': 'Ihuza rya OpenVPN ryacitse',
      'openvpn_core_status_error': 'OpenVPN Core yarangiye ifite ikosa',
      'openvpn_stopped_before_connected': 'OpenVPN yahagaze mbere yo guhuza',
      'openvpn_auth_failed': 'Kwemezwa kwa OpenVPN kwanzwe',
      'openvpn_client_setup_failed': 'Gutegura OpenVPN ntibyashobotse',
      'openvpn_client_halted': 'OpenVPN yarahagaritswe',
      'openvpn_client_restart': 'Kongera gutangira OpenVPN byasabwe',
      'openvpn_inactive_timeout': 'OpenVPN yamaze igihe kirekire idakora',
      'openvpn_session_expired': 'Igihe cyo kwinjira cya OpenVPN cyarangiye',
      'openvpn_credentials_required':
          'Uburyo bwo kwemeza OpenVPN ntibushyigikirwa',
      'openvpn_proxy_failed': 'Proxy ya OpenVPN ntiyakoze',
      'openvpn_compression_failed':
          'Kugabanya ingano y’amakuru ya OpenVPN byanzwe',
      'openvpn_ntlm_crypto_unavailable':
          'Ibanga rya NTLM rya OpenVPN ntiriboneka',
      'openvpn_feature_unsupported': 'Ikiranga cya OpenVPN ntigishyigikirwa',
      'network_unavailable': 'Ihuza ry’interineti ntiriboneka',
      'network_lost': 'Urusobe ntirukiboneka',
      'certificate_validation_failed': 'Icyemezo cya seriveri cyanzwe',
      'openvpn_certificate_expired': 'Icyemezo cya OpenVPN cyarangiye',
      'tunnel_active_for_another_account': 'Umuyoboro w’indi konti uracyakora',
      'tunnel_already_active': 'Umuyoboro kavukire usanzwe ukora',
      'tunnel_stop_timeout': 'Guhagarika $protocol ntibyemejwe',
      'tunnel_disconnected': 'Ihuza rya $protocol ryacitse',
      'native_bridge_unavailable': 'Ikiraro cya Android ntikiboneka',
      'native_operation_failed': 'Igikorwa cya Android cyahagaritswe',
      'invalid_arguments': 'Amakuru ya VPN ntiyuzuye',
      'invalid_account_id': 'Konti ya VPN ntiyemewe',
      'invalid_device_id': 'Nimero iranga igikoresho ntiyemewe',
      'storage_key_not_allowed': 'Urufunguzo rwo kubika rwanzwe',
      'secure_storage_read_failed': 'Gusoma mu bubiko butekanye ntibyashobotse',
      'secure_storage_write_failed':
          'Kwandika mu bubiko butekanye ntibyashobotse',
      'key_generation_failed': 'Ntibyashobotse gukora urufunguzo rwa WireGuard',
      'csr_generation_failed': 'Ntibyashobotse gukora CSR ya OpenVPN',
      'openvpn_recovery_exhausted': 'Kugarura OpenVPN byamaze gukoreshwa',
      'openvpn_recovery_failed': 'Kugarura OpenVPN ntibyashobotse',
      'openvpn_renewal_required': 'Kuvugurura icyemezo cya OpenVPN birakenewe',
      'other': 'Ikosa kavukire rya VPN ritashyizwe mu byiciro',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ntishobora kubona igihe cya VPN gishobora gusubukurwa. Mutangire ihuza rishya muri porogaramu.',
      'system_vpn_resume_corrupt':
          'Amakuru yabitswe yo gusubukura VPN ntiyemewe kandi ntazakoreshwa. Mutangire ihuza rishya.',
      'system_vpn_resume_session_invalid':
          'Igihe cyo kwinjira cyabitswe ntikigishobora gusubukura VPN. Mwongere mwinjire muri porogaramu.',
      'system_vpn_resume_identity_changed':
          'Umwirondoro wa VPN wo ku gikoresho wahindutse. Gusubukura VPN byahagaritswe. Mutangire ihuza rishya.',
      'system_vpn_resume_identity_invalid':
          'Umwirondoro wo gusubukura VPN ntiwemewe. Mutangire ihuza rishya.',
      'system_vpn_resume_storage_failed':
          'Android ntiyashoboye gusoma cyangwa kuvugurura amakuru y’ibanga yo gusubukura VPN. Mutangire ihuza rishya.',
      'system_vpn_resume_network_timeout':
          'Android ntiyabonye urusobe mu gihe gikwiye cyo gusubukura VPN. Mwongere mugerageze igihe urusobe ruboneka.',
      'system_vpn_resume_blocked':
          'Gusubukura VPN birabujijwe. Murebe igenamiterere rya Android, hanyuma mutangire ihuza rishya.',
      'system_vpn_resume_failed':
          'Android ntiyashoboye gusubukura VPN. Mutangire ihuza rishya muri porogaramu.',
      'system_vpn_resume_error_invalid':
          'Android yasubije ikosa ryo gusubukura ridashobora gukoreshwa. Mutangire ihuza rishya.',
      'wireguard_identity_store_failed':
          'Android ntiyashoboye kubika umwirondoro wa WireGuard w’iyi konti mu buryo bw’ibanga.',
      'wireguard_identity_unavailable':
          'Nta mwirondoro wa WireGuard ukoreshwa uboneka kuri iri huza.',
      'vpn_host_destroyed':
          'Igice cya Android cyakiraga VPN cyarahagaritswe. Mutangire ihuza rishya.',
      'vpn_host_unavailable':
          'Android ntishobora gukora igice cyakira VPN. Mwongere mugerageze nyuma yo kureba igenamiterere rya VPN.',
      'openvpn_renewal_required':
          'Icyemezo gisaba igikorwa muri porogaramu mbere yo guhuza.',
      'openvpn_recovery_failed':
          'Kugarura mu buryo bwikora ntibyashobotse. Mutangire ihuza rishya muri porogaramu.',
      'openvpn_recovery_exhausted':
          'Kugarura mu buryo bwikora byamaze gukoreshwa. Mutangire ihuza rishya muri porogaramu.',
      'vpn_permission_required':
          'Android isaba uruhushya rushya rwa VPN mbere yo gutangira umuyoboro.',
      'vpn_permission_denied':
          'Mwemerere FuzeVPN mu cyifuzo cya Android kugira ngo mukomeze.',
      'vpn_permission_request_failed':
          'Android ntiyashoboye gufungura urupapuro rw’uruhushya rwa VPN.',
      'wireguard_foreground_service_unavailable':
          'Android ntiyashoboye gutuma serivisi ya WireGuard ikora ku isonga.',
      'wireguard_identity_invalid':
          'Urufunguzo rwa WireGuard rw’iyi konti rwabitswe mu buryo bw’ibanga ntirusomeka cyangwa ntirwemewe.',
      'wireguard_identity_in_use':
          'Ikindi gikorwa kiracyakoresha urufunguzo rwa WireGuard rw’iyi konti.',
      'wireguard_configuration_invalid':
          'Aderesi, DNS, urufunguzo rwa seriveri cyangwa inzira bya WireGuard byakiriwe ntibyemewe.',
      'wireguard_operation_pending':
          'Igikorwa cya WireGuard cyabanje ntikirarekura serivisi yacyo kavukire.',
      'wireguard_start_failed':
          'Moteri ya WireGuard yanze gutangiza igenamiterere.',
      'wireguard_stop_timeout':
          'Serivisi ya WireGuard ntiyemeje ko interfase ya VPN yarekuwe mu gihe cyagenwe.',
      'wireguard_handshake_timeout':
          'Umuyoboro ntiwemeje kumvikana na seriveri mu gihe gikwiye.',
      'openvpn_connection_timeout':
          'OpenVPN ntiyemeje ihuza na seriveri mu gihe gikwiye.',
      'openvpn_core_unavailable':
          'Iyi verisiyo ya porogaramu ntirimo moteri ya OpenVPN ikora.',
      'openvpn_operation_pending':
          'Moteri kavukire iracyafite igihe cyo kwinjira cya OpenVPN cyabanje kandi ntiyemera gukora ikindi.',
      'openvpn_stop_timeout':
          'OpenVPN Core ntiyemeje ko igihe cyayo cyo kwinjira kavukire cyahagaze kandi cyasenywe mu gihe cyagenwe.',
      'openvpn_profile_unavailable':
          'Nta profayili ya OpenVPN yemewe ishobora gusomwa kuri iri huza.',
      'openvpn_native_failed':
          'Ikosa rya porogaramu ryahagaritse OpenVPN. Mwongere mugerageze guhuza. Niba ikibazo gikomeje, mukore isuzuma.',
      'openvpn_key_generation_failed':
          'Android Keystore ntiyashoboye gukora cyangwa gusoma urufunguzo rw’ibanga rwa P-256 rudashobora koherezwa hanze.',
      'openvpn_csr_generation_failed':
          'Urufunguzo rwa Android Keystore ntirwashoboye gusinya icyifuzo cy’icyemezo cya OpenVPN.',
      'openvpn_identity_store_failed':
          'Icyemezo cya OpenVPN cyangwa profayili ntibyashoboye kubikwa mu bubiko bw’ibanga.',
      'openvpn_identity_clear_failed':
          'Android ntiyashoboye gukuraho umwirondoro wose wa OpenVPN w’iyi konti kuri iki gikoresho.',
      'openvpn_identity_in_use':
          'Igihe cyo kwinjira kavukire cya OpenVPN kiracyakoresha urufunguzo cyangwa icyemezo by’iki gikoresho.',
      'openvpn_tls_verification_required':
          'Profayili ntisaba mu buryo bweruye ko icyemezo cya seriveri kigenzurwa.',
      'openvpn_cipher_invalid':
          'Seriveri yatanze algoritimu y’ibanga itari ku rutonde rwemewe.',
      'openvpn_profile_rejected':
          'Profayili yakiriwe ivuye kuri seriveri ntihuye. Mukore igikoresho bundi bushya, hanyuma mwongere mugerageze.',
      'openvpn_identity_inconsistent':
          'Icyemezo ntigihuye n’umwirondoro w’umutekano w’iki gikoresho. Nta profayili yo ku gikoresho yasimbuwe.',
      'tls_handshake_failed':
          'Seriveri yanze kumvikana kwa TLS. Mukore profayili bundi bushya niba ikibazo gikomeje.',
      'tls_alert_unknown_ca':
          'Seriveri ntimenya ikigo gitanga icyemezo cy’iki gikoresho. Seriveri ya OpenVPN igomba kugenzurwa.',
      'tls_alert_bad_certificate':
          'Seriveri yanze icyemezo cy’iki gikoresho. Mukore igikoresho bundi bushya mbere yo kongera kugerageza.',
      'tls_alert_unsupported_certificate':
          'Seriveri ntishyigikira ubwoko bw’icyemezo cy’umutekano Android ikoresha.',
      'tls_client_certificate_required':
          'Seriveri isaba icyemezo cy’igikoresho, ariko OpenVPN Core ntiyashoboye kukiyereka.',
      'tls_alert_misc':
          'Seriveri yohereje ikimenyetso cya TLS kitari mu byiciro by’icyemezo cyangwa verisiyo.',
      'tls_signature_algorithm_rejected':
          'Seriveri yanze algoritimu ECDSA P-256 y’urufunguzo rwa Android Keystore.',
      'tls_handshake_rejected':
          'Seriveri yahagaritse kumvikana kwa TLS mbere yo guhuza.',
      'tls_version_rejected':
          'Porogaramu na seriveri ntibyabonye verisiyo ya TLS bihuriyeho.',
      'tls_certificate_expired':
          'Icyemezo cyerekanwe mu gihe cyo guhuza cyarangiye.',
      'tls_certificate_revoked':
          'Icyemezo cyerekanwe mu gihe cyo guhuza cyahagaritswe.',
      'transport_failed':
          'Seriveri ya OpenVPN ntisubiza ku rusobe ruriho ubu. Mwongere mugerageze mu kanya gato.',
      'tun_configuration_rejected':
          'Android yanze igenamiterere ry’urusobe OpenVPN yasabye.',
      'tun_setup_failed':
          'OpenVPN Core yanze gahunda y’urusobe mbere yo gukora interfase ya Android.',
      'tun_interface_create_failed':
          'OpenVPN Core ntiyashoboye kubona interfase ya TUN ivuye muri VpnService ya Android.',
      'tun_interface_disabled':
          'Android cyangwa OpenVPN Core yazimije interfase ya TUN mu gihe cyo guhuza.',
      'tun_halted':
          'OpenVPN Core yakiriye icyifuzo cyo guhagarika interfase ya TUN.',
      'tun_already_established':
          'OpenVPN yasabye interfase ya kabiri muri iryo huza rimwe. Umuyoboro wahagaritswe kubera umutekano.',
      'tun_addresses_missing':
          'Seriveri ntiyatanze aderesi yemewe y’umuyoboro.',
      'tun_routes_missing': 'Seriveri ntiyatanze inzira zemewe z’umuyoboro.',
      'tun_dns_missing': 'Seriveri ntiyatanze seriveri ya DNS yemewe.',
      'tun_permission_revoked':
          'Android yakuyeho uruhushya rwa VPN mu gihe cyo guhuza.',
      'tun_establish_returned_null':
          'Android ntiyakoze interfase, akenshi kubera ko indi VPN ikiri gukora.',
      'openvpn_service_start_failed':
          'Android ntiyashoboye gutangiza serivisi ya OpenVPN ikora ku isonga.',
      'openvpn_operation_timeout':
          'Ihamagarwa rya JNI rya OpenVPN Core ryarenze igihe ntarengwa.',
      'openvpn_start_failed':
          'Serivisi ya Android iteguye, ariko OpenVPN Core ntiyemeye gutangiza profayili.',
      'openvpn_connection_failed':
          'OpenVPN Core yahagaze mbere yo kohereza ikimenyetso CONNECTED.',
      'openvpn_core_status_error':
          'Umuzingo kavukire wa OpenVPN warangiye ufite ikosa kandi nta kimenyetso cyihariye cy’iherezo cyabonetse.',
      'openvpn_stopped_before_connected':
          'Umuzingo kavukire wa OpenVPN wahagaze mbere ya CONNECTED, nta kosa ryihariye rya Core ryagaragaye.',
      'openvpn_auth_failed': 'Seriveri ya OpenVPN yanze kwemeza profayili.',
      'openvpn_client_setup_failed':
          'OpenVPN Core ntiyashoboye gutegura umukiriya mbere yo guhuza n’urusobe.',
      'openvpn_client_halted':
          'OpenVPN Core yakiriye ikimenyetso cyo guhagarika burundu umukiriya.',
      'openvpn_client_restart':
          'OpenVPN Core yasabye gutangiza bundi bushya igihe cyayo cyo kohereza amakuru.',
      'openvpn_inactive_timeout':
          'OpenVPN Core yafunze igihe cyo kwinjira nyuma y’igihe kinini kidakoreshwa.',
      'openvpn_session_expired':
          'Seriveri yatangaje ko igihe cyo kwinjira cya OpenVPN cyarangiye.',
      'openvpn_credentials_required':
          'Seriveri cyangwa proxy isaba amakuru yo kwinjira agomba kwinjizwa n’umukoresha, atari mu profayili y’icyemezo.',
      'openvpn_proxy_failed':
          'OpenVPN Core yatangaje ko proxy cyangwa umuhuza washyizweho utakoze.',
      'openvpn_compression_failed':
          'OpenVPN Core yanze uburyo bwo kugabanya ingano y’amakuru bwatangajwe na profayili cyangwa seriveri.',
      'openvpn_ntlm_crypto_unavailable':
          'Profayili isaba ibanga rya NTLM ritaboneka muri iyi verisiyo.',
      'openvpn_feature_unsupported':
          'Profayili cyangwa seriveri bisaba ikiranga kitari muri iyi porogaramu ya Android.',
      'network_unavailable': 'Nta rusobe nyakuri rukoreshwa ruboneka.',
      'network_lost': 'Umuyoboro wahagaritswe nyuma yo gutakaza urusobe.',
      'certificate_validation_failed':
          'Ntibyashobotse kugenzura umwirondoro wa seriveri ya OpenVPN.',
      'openvpn_certificate_expired':
          'Muvugurure profayili ya OpenVPN mbere yo kongera guhuza.',
      'tunnel_active_for_another_account':
          'Umuyoboro w’indi konti ugomba guhagarara mbere y’iri huza.',
      'tunnel_already_active':
          'Android ivuga ko igihe cyo kwinjira cya VPN cyabanje kiracyakoresha interfase.',
      'tunnel_stop_timeout':
          'Moteri ya $protocol ntiyemeje ko interfase ya VPN yarekuwe mu gihe cyagenwe.',
      'tunnel_disconnected':
          'Moteri kavukire yavuze ko umuyoboro warangiye mu buryo butunguranye nyuma yo gutangira.',
      'native_bridge_unavailable':
          'Porogaramu ntishobora kugera kuri serivisi ya VPN ya Android. Mufunge porogaramu, mwongere muyifungure, hanyuma mwongere mugerageze.',
      'native_operation_failed':
          'Ikosa rya porogaramu ryahagaritse igikorwa cya VPN. Mwongere mugerageze. Niba ikibazo gikomeje, mukore isuzuma.',
      'invalid_arguments':
          'Amakuru akenewe kuri iki gikorwa cya VPN ntiyuzuye. Mwongere mugerageze. Niba ikibazo gikomeje, mukore isuzuma.',
      'invalid_account_id':
          'Igikorwa kavukire ntikifitanye isano na nimero iranga konti yemewe.',
      'invalid_device_id':
          'Nimero iranga igikoresho yoherejwe kuri moteri kavukire irabuze cyangwa ntiyemewe.',
      'storage_key_not_allowed':
          'Ikiraro cya Android cyabujije urufunguzo rutari ku rutonde rwemewe rwo kubika.',
      'secure_storage_read_failed':
          'Android Keystore ntiyashoboye gufungura amakuru y’iyi konti yo ku gikoresho.',
      'secure_storage_write_failed':
          'Android Keystore ntiyashoboye gushyira amakuru yo ku gikoresho mu ibanga cyangwa kuyabika.',
      'key_generation_failed':
          'Android ntiyashoboye gukora cyangwa gusoma urufunguzo rwa WireGuard mu bubiko butekanye.',
      'csr_generation_failed':
          'Android Keystore ntiyashoboye gukora cyangwa gusinya CSR ya OpenVPN P-256.',
      'other':
          'Igice kavukire kitari cyanditswe ntikigenze neza. Mwohereze ku bufasha kode y’isuzuma iri hepfo.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Icyifuzo cy’uruhushya kimaze gufungurwa';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Icyifuzo cy’uruhushya rwa VPN ya Android kimaze kwerekanwa. Mukirangize mbere yo kongera kugerageza.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Icyifuzo cy’uruhushya rwa VPN cyahagaze';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Urupapuro rw’uruhushya rwa VPN rwafunzwe mbere y’uko porogaramu ibona igisubizo.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Ihuza rya OpenVPN ntiryemejwe';

  @override
  String get notice_openvpnProofMissing_message =>
      'Ihuza rya OpenVPN ntiryemejwe. Ryahagaritswe kubera umutekano. Mwongere mugerageze.';

  @override
  String get openvpnCleanup_title => 'Profayili ya OpenVPN yakuweho';

  @override
  String get openvpnCleanup_working =>
      'Guhagarika no gukuraho profayili ya OpenVPN yakuweho…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Guhagarika OpenVPN ntibyemejwe. Mwongere mugerageze mbere yo gukora profayili nshya.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Profayili ya OpenVPN yakuweho ntiyashoboye gukurwaho burundu. Mwongere mugerageze gusukura.';

  @override
  String get openvpnCleanup_complete =>
      'Profayili ya OpenVPN yakuweho yamaze gukurwaho. Mukande “Guhuza” kugira ngo mukore indi nshya.';

  @override
  String get network_title => 'Igenamiterere ry’urusobe';

  @override
  String get network_ipv4Fallback =>
      'IPv6 ntiboneka by’agateganyo. Gutegura bikomeza hakoreshejwe IPv4.';

  @override
  String get network_rejectedTitle => 'Igenamiterere ry’urusobe ryanzwe';

  @override
  String get network_rejectedMessage =>
      'Igenamiterere ry’umuyoboro ntiryuzuye cyangwa ntirihuza n’aderesi zemewe. Mwongere mugerageze muri porogaramu.';

  @override
  String get network_unreadableTitle =>
      'Igenamiterere ryo kuri iki gikoresho ntirisomeka';

  @override
  String get network_unreadableMessage =>
      'Igenamiterere ry’urusobe rya OpenVPN ryabitswe ntirishobora gukoreshwa. Mwongere muhuze muri porogaramu kugira ngo rivugururwe.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Uburinzi bw’urusobe';

  @override
  String get protection_subtitle =>
      'Guhagarika kugera kuri interineti mu buryo butaziguye igihe VPN itakiri gukora.';

  @override
  String get protection_active => 'Uburinzi bwa sisitemu burakora';

  @override
  String get protection_alwaysOnOnly =>
      'VPN ihora ikora irafunguye. Mufungure uburyo bwo guhagarika ihuza ridafite VPN.';

  @override
  String get protection_inactive => 'Uburinzi bwa sisitemu ntibukora';

  @override
  String get protection_unknown => 'Mugenzure uburinzi bwa sisitemu';

  @override
  String get protection_openSettings => 'Gufungura igenamiterere rya Android';

  @override
  String get protection_dialogTitle => 'Gushyiraho uburinzi bw’urusobe';

  @override
  String get protection_dialogMessage =>
      'Android icunga VPN ihora ikora n’uburyo bwo guhagarika ihuza ridafite VPN. Mugenzure ko FuzeVPN yatoranyijwe, hanyuma mufungure uburyo bwo guhagarika mu igenamiterere rya sisitemu.';

  @override
  String get protection_dialogOpen => 'Gufungura igenamiterere';

  @override
  String get session_systemProtectionNote =>
      'Niba Android ikomeje guhagarika urujya n’uruza hanze ya VPN, mufungure igenamiterere rya sisitemu kugira ngo mugenzure cyangwa muhindure ubu burinzi.';

  @override
  String get diagnostics_title => 'Isuzuma';

  @override
  String get diagnostics_settingsTitle => 'Isuzuma rya porogaramu';

  @override
  String get diagnostics_automaticTitle => 'Kohereza amakosa y’ingenzi';

  @override
  String get diagnostics_automaticDescription =>
      'Raporo ntoya ya tekiniki isangizwa igihe habaye ikosa ry’ingenzi.';

  @override
  String get diagnostics_privacy =>
      'Raporo zoherejwe zihuzwa na konti mwinjiyemo kandi zibikwa iminsi 30. Nta mateka y’imbuga zasuwe, amagambobanga cyangwa imfunguzo za VPN zirimo.';

  @override
  String get diagnostics_manualOpen => 'Gukora isuzuma';

  @override
  String get diagnostics_localDescription =>
      'Mukore raporo y’uko porogaramu na VPN bimeze. Ihuza ryanyu ntirihinduka.';

  @override
  String get diagnostics_sendReport => 'Kohereza raporo';

  @override
  String get diagnostics_sendHint =>
      'Mureke iki gisanduku kitarimo ikimenyetso kugira ngo raporo igume kuri iki gikoresho.';

  @override
  String get diagnostics_signedOut =>
      'Mwinjire muri konti yanyu kugira ngo mwohereze raporo.';

  @override
  String get diagnostics_localLifetime =>
      'Mubike iyi raporo kuri telefoni yanyu kugira ngo ikomeze kuboneka nyuma yo gufunga porogaramu.';

  @override
  String get diagnostics_run => 'Gukora isuzuma';

  @override
  String get diagnostics_rerun => 'Kongera gukora isuzuma';

  @override
  String get diagnostics_running => 'Irimo kugenzura…';

  @override
  String get diagnostics_sending => 'Irimo kohereza raporo…';

  @override
  String get diagnostics_prepared => 'Raporo yiteguye kuri iki gikoresho';

  @override
  String get diagnostics_queued => 'Raporo itegereje koherezwa';

  @override
  String get diagnostics_sent => 'Raporo yakiriwe';

  @override
  String get diagnostics_failed =>
      'Kohereza ntibyashobotse. Raporo yanyu yo kuri iki gikoresho iracyaboneka.';

  @override
  String get diagnostics_preparationFailed =>
      'Ntibyashobotse gutegura raporo y’isuzuma. Mwongere mugerageze.';

  @override
  String get diagnostics_authenticationRequired =>
      'Mwongere mwinjire kugira ngo mwohereze raporo.';

  @override
  String get diagnostics_retry => 'Kongera kohereza';

  @override
  String get diagnostics_export => 'Kubika raporo';

  @override
  String get diagnostics_exportFailed =>
      'Kubika raporo ntibyashobotse. Mwongere mugerageze mukoresheje raporo yo kuri iki gikoresho.';

  @override
  String get diagnostics_preferenceFailed =>
      'Iri genamiterere ntiryashoboye kubikwa. Mwongere mugerageze.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Nimero y’ikurikirana: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Yakiriwe tariki $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Izabikwa kugeza tariki $date';
  }

  @override
  String get diagnostics_duplicate => 'Iyi raporo yari yakiriwe mbere.';

  @override
  String get diagnostics_preview => 'Incamake ya raporo';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ibyabaye bya tekiniki $count byashyizwemo',
      one: 'Icyabaye kimwe cya tekiniki cyashyizwemo',
      zero: 'Nta byabaye bya tekiniki byashyizwemo',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Ibisobanuro bya tekiniki';

  @override
  String get diagnostics_empty => 'Nta raporo y’isuzuma irateguwe kugeza ubu.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Uko umuyoboro uhagaze',
      'handshake': 'Kwemeza ihuza',
      'certificate': 'Icyemezo cya VPN',
      'kill_switch': 'Uburinzi bwa Android',
      'connectivity': 'Urusobe ruboneka',
      'api_reachability': 'Kugera kuri serivisi',
      'secure_storage': 'Ububiko butekanye',
      'other': 'Isuzuma ryo kuri iki gikoresho',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Byasuzumwe',
      'failed': 'Hakenewe kwitabwaho',
      'skipped': 'Ntibyapimwe — nta kizamini cyakozwe',
      'unknown': 'Amakuru ntaboneka',
      'other': 'Amakuru ntaboneka',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Murakaza neza kuri FuzeVPN';

  @override
  String get connection_changeLocation => 'Guhindura ahantu';

  @override
  String get connection_details => 'Ibisobanuro by’ihuza';

  @override
  String get locations_searchLabel => 'Gushakisha umujyi cyangwa igihugu';

  @override
  String get locations_clearSearch => 'Gusiba ibyashakishijwe';

  @override
  String get locations_filterAll => 'Byose';

  @override
  String get locations_filterFavorites => 'Ibyakunzwe';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ahantu $count',
      one: 'Ahantu $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nta hantu habonetse';

  @override
  String get locations_noResultsHint =>
      'Mugerageze undi mujyi cyangwa irindi gihugu.';

  @override
  String get locations_noFavorites => 'Ibyakunzwe byanyu, biri hafi yanyu';

  @override
  String get locations_noFavoritesHint =>
      'Mukande inyenyeri iri iruhande rw’ahantu kugira ngo habikwe hano.';

  @override
  String get locations_showAll => 'Kureba ahantu hose';

  @override
  String locations_addFavorite(String name) {
    return 'Kongeraho $name mu byakunzwe';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Gukuraho $name mu byakunzwe';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Ntibyashobotse kubika ahantu mu byakunzwe. Mwongere mugerageze.';

  @override
  String get locations_emptyTitle => 'Nta hantu haboneka';

  @override
  String get locations_emptyHint =>
      'Muvugurure urutonde kugira ngo mwongere mugerageze.';

  @override
  String get devices_manage => 'Gucunga ibikoresho byanyu';

  @override
  String get settings_personalization => 'Gutunganya uko mubishaka';

  @override
  String get settings_safety => 'Uburinzi';

  @override
  String get settings_help => 'Mukeneye ubufasha?';

  @override
  String get settings_about => 'Ibyerekeye FuzeVPN';

  @override
  String get diagnostics_heading => 'Gusobanukirwa ikibazo cy’ihuza';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Iraboneka',
      'pending': 'Irategurwa',
      'revoked': 'Yakuweho',
      'expired': 'Yarangiye',
      'other': 'Imiterere ntiboneka',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Ihitamo ntiryabitswe';

  @override
  String get notice_preferenceSave_message =>
      'Ihitamo ryanyu rikoreshwa ubu, ariko ntiryabitswe. Mwongere mugerageze kugira ngo rikomeze nyuma yo gufunga porogaramu.';

  @override
  String get connection_androidDisconnectHint =>
      'Niba Android ikomeje gutuma VPN ikora, muzimye “VPN ihora ikora” mu igenamiterere rifunguka.';

  @override
  String get protection_learnMore => 'Mumenye byinshi ku burinzi bwa Android';

  @override
  String get protection_guideWhy =>
      'Ubu burinzi bubuza porogaramu gukoresha interineti mu buryo butanyuze muri VPN, iyo VPN ihagaze. Bushyirwaho muri Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN ihora ikora';

  @override
  String get protection_guideAlwaysOn =>
      'Android ituma serivisi ya VPN ikomeza gukora, kandi ishobora kongera kuyitangiza telefoni imaze gutangira bundi bushya.';

  @override
  String get protection_guideBlockTitle => 'Guhagarika ihuza ridafite VPN';

  @override
  String get protection_guideBlock =>
      'Iri genamiterere ribuza urujya n’uruza kunyura hanze ya VPN, harimo n’igihe ihuza ryacitse.';

  @override
  String get protection_guideWarning =>
      'Iyo ubu buryo bwo guhagarika bufunguye, interineti ntiboneka kugeza VPN ihujwe.';

  @override
  String get protection_guideStepsTitle => 'Gufungura ubu burinzi';

  @override
  String get protection_guideStep1 =>
      'Mufungure igenamiterere rya VPN ya Android mukoresheje buto iri hasi.';

  @override
  String get protection_guideStep2 =>
      'Mufungure amahitamo mukoresheje agashushanyo k’igenamiterere kari hafi ya FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Mufungure “VPN ihora ikora”, hanyuma “Guhagarika ihuza ridafite VPN”, niba ayo mahitamo ahari.';

  @override
  String get protection_guideManufacturers =>
      'Amazina aratandukana bitewe na telefoni. Nibiba ngombwa, mushakishe VPN mu Igenamiterere, akenshi munsi ya Urusobe n’interineti.';

  @override
  String get protection_guideDisableTitle => 'Kuzimya ubu burinzi';

  @override
  String get protection_guideDisable =>
      'Muri ayo magenamiterere, muzimye “Guhagarika ihuza ridafite VPN” kugira ngo mushobore gukoresha interineti nta VPN. Muzimye kandi “VPN ihora ikora” niba mutagishaka ko Android yongera kuyitangiza.';

  @override
  String get protection_guideManual =>
      'Ayo magenamiterere muyahitamo ubwanyu muri Android. FuzeVPN ntihindura ayo magenamiterere mu cyimbo cyanyu.';

  @override
  String get locations_changeTitle => 'Guhindura ahantu?';

  @override
  String locations_changeActive(String name) {
    return 'VPN izahagarika guhuza, hanyuma igerageze guhuza na $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN izagerageza guhuza na $name.';
  }

  @override
  String get locations_confirmChange => 'Guhindura no guhuza';

  @override
  String get locations_changeBusy =>
      'Hari impinduka irimo gukorwa. Mutegereze mbere yo guhitamo ahandi hantu.';

  @override
  String get locations_automaticSelection => 'Guhitamo mu buryo bwikora';

  @override
  String get locations_cities => 'Imijyi';

  @override
  String get locations_servers => 'Seriveri';

  @override
  String locations_viewCities(String name) {
    return 'Kureba imijyi muri $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Kureba seriveri muri $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ibihugu $count',
      one: 'igihugu $count',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imijyi $count',
      one: 'umujyi $count',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'seriveri $count',
      one: 'seriveri $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Ibihugu byose';

  @override
  String get locations_backToCountries => 'Gusubira ku bihugu';

  @override
  String locations_backToCities(String name) {
    return 'Gusubira ku mijyi muri $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Guhitamo $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Guhitamo $name';
  }

  @override
  String get locations_noCompatibleServer => 'Nta seriveri ihuje iboneka.';

  @override
  String get externalLink_failed =>
      'Ntibyashobotse gufungura uyu murongo. Mushobora kuwukopera mukawufungurira muri mushakisha yanyu.';

  @override
  String get externalLink_copy => 'Gukopera umurongo';

  @override
  String get externalLink_copied => 'Umurongo wakoperwe';

  @override
  String get externalLink_copyFailed =>
      'Ntibyashobotse gukopera umurongo. Muhitemo aderesi iri hasi.';

  @override
  String get settings_deleteAccount => 'Gusiba konti yanjye';

  @override
  String get settings_deleteAccountDetail =>
      'Kureba uburyo bwo gusaba gusiba konti';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Muhitemo ifatabuguzi ryanyu rya VPN.';

  @override
  String get billing_subscribe => 'Gufata ifatabuguzi';

  @override
  String get billing_choosePlan =>
      'Muhitemo ubwoko bw’ifatabuguzi kugira ngo mukomeze.';

  @override
  String get billing_monthly => 'Buri kwezi';

  @override
  String get billing_yearly => 'Buri mwaka';

  @override
  String get billing_continue => 'Gukomeza binyuze kuri Google Play';

  @override
  String get billing_restore => 'Gusubizaho ibyaguzwe';

  @override
  String get billing_manage => 'Gucunga ifatabuguzi';

  @override
  String get billing_deleteAccountWarning =>
      'Niba mufite ifatabuguzi rya Google Play, iyo musibye konti yanyu ya FuzeVPN, ivugururwa ryaryo ntirihagarara. Mucunge cyangwa muhagarike ivugururwa ryaryo ukwaryo muri Google Play.';

  @override
  String get billing_deleteAccountContinue => 'Gukomeza gusaba gusiba konti';

  @override
  String get billing_refresh => 'Kuvugurura uburenganzira';

  @override
  String get billing_loadingPlans => 'Irimo kuzana ubwoko bw’ifatabuguzi…';

  @override
  String get billing_unavailable =>
      'Nta bwoko bw’ifatabuguzi buboneka ubu. Mwongere mugerageze nyuma.';

  @override
  String get billing_comingSoon => 'Amafatabuguzi azaboneka vuba.';

  @override
  String get billing_priceDisclosure =>
      'Igiciro gitangwa na Google Play. Amafaranga yose hamwe n’imisoro ikurikizwa azemezwa mbere y’uko mwemeza.';

  @override
  String get billing_renewalMonthly =>
      'Ifatabuguzi rivugururwa ryikora buri kwezi, keretse ryahagaritswe. Mushobora guhagarika igihe cyose mu mafatabuguzi ya Google Play.';

  @override
  String get billing_renewalYearly =>
      'Ifatabuguzi rivugururwa ryikora buri mwaka, keretse ryahagaritswe. Mushobora guhagarika igihe cyose mu mafatabuguzi ya Google Play.';

  @override
  String get billing_active => 'Uburenganzira bwanyu bwa Premium burakora';

  @override
  String billing_accessUntil(String date) {
    return 'Uburenganzira bukora kugeza tariki $date.';
  }

  @override
  String get billing_webManaged =>
      'Ifatabuguzi ryanyu ricungirwa ku rubuga rwa FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Ifatabuguzi ryanyu ricungwa na Google Play.';

  @override
  String get billing_playOnHold =>
      'Ifatabuguzi ryanyu rya Google Play rirahagaritswe cyangwa rirategereje kwishyurwa. Mufungure “Gucunga ifatabuguzi” kugira ngo mukosore ikibazo muri Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Iyi konti ya Google Play isanzwe ifite ifatabuguzi rya Fuze Premium ritakora kuri iyi konti ya FuzeVPN. Mufungure “Gucunga ifatabuguzi” kugira ngo murisuzume muri Google Play.';

  @override
  String get billing_inactive => 'Nta fatabuguzi rikora.';

  @override
  String get billing_checkingAccess => 'Kugenzura uburenganzira bwanyu…';

  @override
  String get billing_restoring => 'Gusubizaho ibyaguzwe…';

  @override
  String get billing_pending =>
      'Ukwishyura kurategereje. Uburenganzira bwanyu buzatangira nyuma yo kwemezwa.';

  @override
  String get billing_cancelled =>
      'Ukugura kwahagaritswe. Nta fatabuguzi rishya ryatangiye gukora.';

  @override
  String get billing_verifying => 'Kugenzura ukugura…';

  @override
  String get billing_success =>
      'Ifatabuguzi ryatangiye gukora. Uburenganzira bwanyu bwa Premium bwiteguye.';

  @override
  String get billing_restored => 'Ibyaguzwe byanyu byasubijweho.';

  @override
  String get billing_restoreEmpty =>
      'Nta byaguzwe bisubizwaho kuri iyi konti ya Google Play.';

  @override
  String get billing_catalogError =>
      'Ntibyashobotse kuzana ubwoko bw’ifatabuguzi. Mwongere mugerageze.';

  @override
  String get billing_purchaseError =>
      'Ntibyashobotse gutangira ukugura. Mwongere mugerageze.';

  @override
  String get billing_verificationError =>
      'Kugenzura ukugura ntibiboneka by’agateganyo. Musubizeho ibyaguzwe kugira ngo mwongere mugerageze.';

  @override
  String get billing_restoreError =>
      'Ntibyashobotse gusubizaho ibyaguzwe. Mwongere mugerageze.';

  @override
  String get billing_managementError =>
      'Ntibyashobotse gufungura uburyo bwo gucunga ifatabuguzi. Mwongere mugerageze.';

  @override
  String get billing_storeUnavailable =>
      'Google Play ntiboneka kuri iki gikoresho.';

  @override
  String get welcome_title => 'VPN yanyu, mu buryo bworoshye.';

  @override
  String get welcome_description =>
      'Murinde ihuza ryanyu. Mukomeze kugenzura ubuzima bwanyu bwite.';

  @override
  String get welcome_start => 'Gutangira';

  @override
  String get welcome_alreadyPurchased => 'Mwamaze kugura?';

  @override
  String get welcome_noAccountRequired =>
      'Nta konti ikenewe kugira ngo mutangire.';

  @override
  String get guest_accountTitle => 'Konti ntiyahujwe';

  @override
  String get guest_accountDescription =>
      'Mushobora gusubizaho ibyaguzwe byanyu mukoresheje konti imwe ya Google Play, kugira ngo mukoreshe ifatabuguzi ryanyu ku kindi gikoresho.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Mwamaze gufata ifatabuguzi? Kwinjira';

  @override
  String get guest_claimTitle => 'Mujyane FuzeVPN aho mujya hose';

  @override
  String get guest_claimDescription =>
      'Mukore konti kugira ngo mubone ifatabuguzi ryanyu ku bindi bikoresho byanyu. Iyi ntambwe si itegeko.';

  @override
  String get guest_skip => 'Nyuma';

  @override
  String get guest_activationTitle => 'Fuze Premium irakora';

  @override
  String get guest_activationDescription =>
      'Ifatabuguzi ryanyu ryiteguye. Mushobora gukoresha VPN yanyu kandi mugakora konti igihe mubishakiye.';

  @override
  String get guest_useVpn => 'Gukoresha VPN yanjye';

  @override
  String get guest_loginRequired =>
      'Uku kugura kumaze guhuzwa na konti ya FuzeVPN. Mwinjire muri iyo konti kugira ngo mubone ifatabuguzi ryanyu.';

  @override
  String get guest_signOutWarning =>
      'Mushobora kugarura ifatabuguzi ryanyu mu gusubizaho ibyaguzwe mukoresheje konti imwe ya Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Konti yanyu imaze guhuzwa. Mwinjire kugira ngo murebe kandi mucunge amakuru yanyu.';

  @override
  String get billing_acceptance =>
      'Mu gukomeza, mwemera Amabwiriza yo gukoresha na Politiki y’ubuzima bwite.';

  @override
  String get guest_verifyEmailReminder =>
      'Mwemeze aderesi y’imeyili yanyu kugira ngo murinde konti yanyu. Mushobora gukomeza gukoresha VPN yanyu.';

  @override
  String get guest_serviceUnavailable =>
      'Serivisi ntiboneka by’agateganyo. Mwongere mugerageze mu kanya gato.';

  @override
  String get guest_restoreError =>
      'Ibyaguzwe byanyu ntibyashoboye gusubizwaho. Mwongere mugerageze mukoresheje konti ya Google Play mwakoresheje mu kugura.';

  @override
  String get guest_claimSuccess =>
      'Konti yanyu yakozwe. Ifatabuguzi ryanyu n’uburenganzira bwanyu bwa VPN birabitswe.';

  @override
  String get guest_emailExists =>
      'Iyi aderesi y’imeyili isanzwe ikoreshwa. Muhitemo indi aderesi cyangwa mwinjire muri konti yanyu isanzwe ihari. Ukugura kwanyu kuracyaboneka binyuze kuri Google Play.';

  @override
  String get guest_claimError =>
      'Ntibyashobotse gukora konti yanyu. Mushobora gukomeza gukoresha VPN yanyu, hanyuma mwongere mugerageze nyuma.';

  @override
  String get guest_secureStorageError =>
      'Ntibyashobotse kurinda igihe cyanyu cyo kwinjira kuri iki gikoresho. Mwongere mugerageze.';

  @override
  String get guest_premiumRequired =>
      'Muhitemo ifatabuguzi kugira ngo VPN yanyu ikore.';

  @override
  String get welcome_viewPlans => 'Kureba ubwoko bw’ifatabuguzi';

  @override
  String get google_continue => 'Gukomeza binyuze kuri Google';

  @override
  String get google_or => 'cyangwa';

  @override
  String get google_title => 'Konti yanyu ya FuzeVPN';

  @override
  String get google_settingUp => 'Kurangiza gukora konti yanyu';

  @override
  String get google_country => 'Igihugu cy’aho mutuye';

  @override
  String get google_profileDescription =>
      'Muhitemo igihugu cyanyu kandi musuzume inyandiko ebyiri kugira ngo mukore konti yanyu ya FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Muhuze konti yanyu y’umushyitsi na Google. Ifatabuguzi ryanyu n’igikoresho cyanyu bikomeza guhuzwa n’iyi konti.';

  @override
  String get google_linkTitle => 'Guhuza Google na FuzeVPN';

  @override
  String get google_linkDescription =>
      'Mwemeze uburenganzira bwanyu bwo kwinjira muri konti yanyu isanzwe ya FuzeVPN. Iyi ntambwe ntisaba ijambobanga ryanyu rya Google.';

  @override
  String get google_password => 'Ijambobanga rya FuzeVPN';

  @override
  String get google_linkAccount => 'Kwemeza ihuza';

  @override
  String get google_requestEmail => 'Kunyoherereza imeyili yo kwemeza';

  @override
  String get google_emailInstructions =>
      'Mufungure imeyili ya FuzeVPN, mwinjize kode yo kwemeza.';

  @override
  String get google_emailCode => 'Kode yo kwemeza y’imeyili';

  @override
  String get google_confirmEmail => 'Kwemeza kode';

  @override
  String get google_restart => 'Guhitamo indi konti ya Google';

  @override
  String get google_resume => 'Kugenzura iri gerageza';

  @override
  String get google_unavailable =>
      'Kwinjira ukoresheje Google ntibiboneka. Mushobora gukoresha imeyili n’ijambobanga.';

  @override
  String get google_expired =>
      'Iri gerageza ryarangiye igihe. Murireke, hanyuma mutangire bundi bushya.';

  @override
  String get google_conflict =>
      'Iyi konti ya Google isanzwe ihujwe ahandi. Konti yanyu iriho n’ifatabuguzi ryanyu birabitswe.';

  @override
  String get google_error =>
      'Kwinjira ukoresheje Google ntibyashobotse. Mwongere mugerageze. Uburenganzira bwanyu bugumaho.';

  @override
  String get google_uncertain =>
      'Ibyavuye ntibyashobotse kwemezwa. Mugenzure iri gerageza cyangwa murireke mbere yo gutangira bundi bushya.';

  @override
  String get google_cancelFailed =>
      'Ntibyashobotse kwemeza ko byahagaritswe. Mwongere mugerageze kureka mbere yo kuva kuri uru rupapuro.';

  @override
  String get google_cancelled => 'Kwinjira ukoresheje Google kwahagaritswe.';

  @override
  String get google_selecting => 'Muhitemo konti yanyu ya Google…';

  @override
  String get google_verifying => 'Kugenzura konti yanyu…';

  @override
  String get google_emailUnavailable =>
      'Imeyili yo kwemeza ntiyashoboye koherezwa. Mwongere mugerageze nyuma.';

  @override
  String get google_emailSent =>
      'Imeyili yo kwemeza yoherejwe. Mugenzure agasanduku k’imeyili yanyu.';

  @override
  String get google_rateLimited => 'Mutegereze mbere yo kongera kugerageza.';

  @override
  String get google_busy =>
      'Google ntiboneka mu gihe ikindi gikorwa kirimo gukorwa (guhuza VPN, konti cyangwa umushyitsi). Mwongere mugerageze nyuma y’uko kirangiye. Uburenganzira bwanyu bugumaho.';

  @override
  String get google_invalidPassword =>
      'Ijambobanga rya FuzeVPN si ryo. Konti yanyu iriho irabitswe.';

  @override
  String get google_invalidCode =>
      'Kode yo kwemeza ntiyemewe cyangwa yararangiye.';

  @override
  String get google_accountChanged =>
      'Igihe cyanyu cyo kwinjira cyarahindutse. Mureke iri gerageza mbere yo gutangira bundi bushya.';

  @override
  String get google_invalidResponse =>
      'Igisubizo ntigishobora kwemezwa. Uburenganzira bwanyu bugumaho.';

  @override
  String get google_invalidRegistration =>
      'Mugenzure igihugu cyanyu n’ibyo mwemeye byombi.';

  @override
  String get google_consentRequired =>
      'Muhitemo igihugu cyanyu kandi mwemere inyandiko zombi kugira ngo mukomeze.';

  @override
  String get google_challengeRequired =>
      'Hakenewe irindi genzura ry’umutekano. Uburenganzira bwanyu bugumaho.';

  @override
  String get google_challengeUnavailable =>
      'Igenzura ry’umutekano ntiriboneka. Mwongere mugerageze nyuma.';

  @override
  String get google_intentMismatch =>
      'Igerageza ryabanje ryo kwinjira ukoresheje Google riracyategereje. Murireke mbere yo gutangira iki gikorwa.';

  @override
  String get google_challengeBlocked =>
      'Igenzura ry’umutekano risabwa ntiriboneka muri iyi porogaramu. Iki gikorwa ntigishobora kurangira ubu.';

  @override
  String get google_solveChallenge => 'Kurangiza igenzura ry’umutekano';

  @override
  String get google_challengeTitle => 'Igenzura ry’umutekano';

  @override
  String get google_challengeReady =>
      'Igenzura ryarangiye. Ubu mushobora kwemeza gukora konti yanyu.';

  @override
  String get google_challengeExpired =>
      'Igenzura ryarangiye igihe. Mukore irindi genzura mbere yo kwemeza.';

  @override
  String get google_challengeCancelled =>
      'Igenzura ryahagaritswe. Mushobora kongera kurigerageza.';

  @override
  String get google_challengeFailed =>
      'Igenzura ry’umutekano ntiryagenze neza. Mwongere mugerageze.';

  @override
  String get billing_trialTitle => 'Kugerageza Fuze Premium ku buntu';

  @override
  String get billing_trialSubtitle => 'Murinde ihuza ryanyu guhera uyu munsi.';

  @override
  String get billing_trialWeeks => 'Igeragezwa ry’ubuntu ry’ibyumweru bibiri';

  @override
  String billing_trialDays(String days) {
    return 'Igeragezwa ry’ubuntu ry’iminsi $days';
  }

  @override
  String get billing_trialStart => 'Gutangira igeragezwa ryanjye ry’ubuntu';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Niba mutangiye uyu munsi, kwishyuzwa kwa mbere kuteganyijwe tariki $date.';
  }

  @override
  String get billing_trialTerms =>
      'Ifatabuguzi rivugururwa ryikora ku giciro cyavuzwe. Kugira ngo mwirinde kwishyuzwa, muhagarike muri Google Play mbere y’uko igeragezwa rirangira.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Hanyuma $price buri kwezi';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Hanyuma $price buri mwaka';
  }

  @override
  String get billing_choosePeriod => 'Guhitamo ubwoko bw’ifatabuguzi ryanyu';

  @override
  String get billing_selectionHint =>
      'Mutoranye ubwoko bw’ifatabuguzi kugira ngo mukomeze.';

  @override
  String get billing_benefitConnection => 'Ihuza ry’ibanga';

  @override
  String get billing_benefitPrivacy => 'Ubuzima bwite kuri interineti';

  @override
  String get billing_benefitNoAccount => 'Ntibisaba kwiyandikisha';

  @override
  String get billing_cancellation => 'Guhagarika ifatabuguzi muri Google Play';

  @override
  String get billing_premiumTitle => 'Ihuza rirushijeho kurindwa.';

  @override
  String get billing_premiumSubtitle =>
      'Murinde ihuza ryanyu ku muvuduko wanyu.';

  @override
  String get billing_priceMonthly => 'buri kwezi';

  @override
  String get billing_priceYearly => 'buri mwaka';

  @override
  String get billing_trialToday => 'Nta cyo mwishyura uyu munsi';

  @override
  String get billing_trialConfirmation =>
      'Google Play yemeza amatariki, amafaranga yose hamwe n’imisoro ikurikizwa mbere y’uko mwemeza.';

  @override
  String get billing_offerChanged =>
      'Amabwiriza y’iyi promosiyo yarahindutse. Muvugurure ubwoko bw’ifatabuguzi, hanyuma mwongere mutoranye.';

  @override
  String get status_waitingNetwork => 'Irategereje urusobe';

  @override
  String get status_waitingNetworkDetail =>
      'Nta rusobe ruboneka. VPN izagenzura ihuza igihe urusobe ruzagaruka.';

  @override
  String get locations_favoriteLoadFailed =>
      'Ntibyashobotse kuzana ibyakunzwe. Mwongere mugerageze.';

  @override
  String get locations_favoritesLoading => 'Irimo kuzana ibyakunzwe…';
}
