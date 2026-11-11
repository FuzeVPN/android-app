// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Aizsargājiet savu savienojumu';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN izmanto Android VPN pakalpojumu (VpnService), lai izveidotu šifrētu tuneli starp šo ierīci un FuzeVPN serveriem.';

  @override
  String get vpnDisclosure_dataBody =>
      'Kamēr VPN ir aktīvs, jūsu lietotņu interneta datplūsma, galamērķa adreses un DNS pieprasījumi tiek virzīti caur šo tuneli savienojuma maršrutēšanai, arī tad, ja FuzeVPN darbojas fonā.';

  @override
  String get vpnDisclosure_statusBody =>
      'Lietotne izmanto savienojuma statusu, tā ilgumu un pārsūtīto datu apjomu, lai attēlotu jūsu VPN savienojumu. Varat to apturēt jebkurā laikā.';

  @override
  String get vpnDisclosure_privacy => 'Privātums';

  @override
  String get vpnDisclosure_accept => 'Piekrist un turpināt';

  @override
  String get vpnDisclosure_decline => 'Ne tagad';

  @override
  String get accountRestoration_title => 'Konts īslaicīgi nav pieejams';

  @override
  String get accountRestoration_message =>
      'Jūsu sesija ir saglabāta. Lai atjaunotu kontu, mēģiniet vēlreiz; VPN savienojumu joprojām varat pārvaldīt šeit.';

  @override
  String get action_retry => 'Mēģināt vēlreiz';

  @override
  String get session_endingTitle => 'Sesijas beigšana';

  @override
  String get session_ending =>
      'Notiek sesijas beigšana: tiek apturēts VPN un veikta tīrīšana…';

  @override
  String get session_stopFailed =>
      'VPN apturēšana nav apstiprināta. Pirms atkārtotas pierakstīšanās mēģiniet vēlreiz.';

  @override
  String get session_cleanupFailed =>
      'VPN ir apturēts, taču sesijas dzēšana nav apstiprināta. Mēģiniet tīrīšanu vēlreiz.';

  @override
  String get session_retryStop => 'Mēģināt apturēt vēlreiz';

  @override
  String get session_retryCleanup => 'Mēģināt tīrīšanu vēlreiz';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Notiek droša FuzeVPN sagatavošana…';

  @override
  String get nav_connection => 'Savienojums';

  @override
  String get nav_locations => 'Vietas';

  @override
  String get nav_account => 'Konts';

  @override
  String get nav_devices => 'Ierīces';

  @override
  String get nav_settings => 'Iestatījumi';

  @override
  String get action_refresh => 'Atsvaidzināt';

  @override
  String get auth_tab_login => 'Pierakstīties';

  @override
  String get auth_tab_register => 'Reģistrēties';

  @override
  String get auth_stepAccount => 'Konts';

  @override
  String get auth_stepIdentity => 'Identitāte';

  @override
  String get auth_stepAddress => 'Adrese un piekrišana';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Solis $current no $total';
  }

  @override
  String get auth_tagline => 'Jūsu VPN — vienkārši.';

  @override
  String get auth_keysLocal => 'Jūsu privātās VPN atslēgas paliek šajā ierīcē.';

  @override
  String get form_email => 'E-pasta adrese';

  @override
  String get form_password => 'Parole';

  @override
  String get form_showPassword => 'Rādīt paroli';

  @override
  String get form_hidePassword => 'Paslēpt paroli';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 baiti. Dažas rakstzīmes aizņem vairāk nekā vienu baitu.';

  @override
  String get form_firstName => 'Vārds';

  @override
  String get form_lastName => 'Uzvārds';

  @override
  String get form_phone => 'Tālrunis (+33612345678)';

  @override
  String get form_address => 'Adrese';

  @override
  String get form_address2 => 'Adreses 2. rindiņa (neobligāti)';

  @override
  String get form_postalCode => 'Pasta indekss';

  @override
  String get form_city => 'Pilsēta';

  @override
  String get form_country => 'Valsts kods (piem., FR)';

  @override
  String get action_login => 'Pierakstīties';

  @override
  String get action_createAccount => 'Izveidot kontu';

  @override
  String get action_createMyAccount => 'Izveidot manu kontu';

  @override
  String get action_next => 'Turpināt';

  @override
  String get action_previous => 'Atpakaļ';

  @override
  String get action_forgotPassword => 'Aizmirsāt paroli?';

  @override
  String get auth_noAccount => 'Vēl nav konta?';

  @override
  String get auth_requiredInformation => 'Izveidojiet kontu trīs soļos.';

  @override
  String get auth_termsPrefix => 'Piekrītu ';

  @override
  String get auth_termsLink => 'lietošanas noteikumiem';

  @override
  String get auth_privacyPrefix => 'Piekrītu ';

  @override
  String get auth_privacyLink => 'privātuma politikai';

  @override
  String get auth_consentRequired =>
      'Lai izveidotu kontu, nepieciešama jūsu piekrišana.';

  @override
  String get validation_required => 'Šis lauks ir obligāts.';

  @override
  String get validation_email => 'Ievadiet derīgu e-pasta adresi.';

  @override
  String get validation_password =>
      'Parole ir pārāk īsa: vismaz 8 UTF-8 baiti.';

  @override
  String get validation_passwordTooLong =>
      'Parole ir pārāk gara: ne vairāk kā 72 UTF-8 baiti.';

  @override
  String get validation_phone =>
      'Izmantojiet starptautisko formātu, piemēram, +33612345678.';

  @override
  String get validation_country =>
      'Izmantojiet divburtu valsts kodu, piemēram, FR.';

  @override
  String get passwordReset_title => 'Atiestatīt paroli';

  @override
  String get passwordReset_description =>
      'Ievadiet konta e-pasta adresi, lai pieprasītu paroles atiestatīšanas saiti.';

  @override
  String get passwordReset_send => 'Nosūtīt saiti';

  @override
  String get connection_title => 'Jūsu savienojums';

  @override
  String get connection_subtitle =>
      'Izvēlieties atrašanās vietu un pēc tam ieslēdziet VPN.';

  @override
  String get connection_prepare => 'Gatavi savienoties?';

  @override
  String get connection_advancedOptions => 'Papildu opcijas';

  @override
  String get connection_location => 'Atrašanās vieta';

  @override
  String get connection_chooseLocation => 'Izvēlieties atrašanās vietu';

  @override
  String get connection_protocol => 'Protokols';

  @override
  String get connection_connect => 'Savienot';

  @override
  String get connection_connecting => 'Notiek savienošana…';

  @override
  String get connection_disconnect => 'Atvienot';

  @override
  String get connection_disconnecting => 'Notiek atvienošana';

  @override
  String get connection_locationChange => 'Notiek atrašanās vietas maiņa…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nav pieejams';
  }

  @override
  String get connection_activeLocation => 'Aktīvā atrašanās vieta';

  @override
  String get connection_duration => 'Ilgums';

  @override
  String get connection_received => 'Saņemts';

  @override
  String get connection_sent => 'Nosūtīts';

  @override
  String get connection_lastHandshake => 'Pēdējā drošā apmaiņa';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Pirms $duration';
  }

  @override
  String get verification_title => 'Apstipriniet savu e-pasta adresi';

  @override
  String get verification_message =>
      'Apstipriniet e-pasta adresi, lai šajā tālrunī izmantotu VPN.';

  @override
  String get verification_resend => 'Nosūtīt e-pastu vēlreiz';

  @override
  String get migration_title => 'Atrašanās vietas maiņa';

  @override
  String get migration_draining =>
      'Notiek atrašanās vietas maiņas sagatavošana…';

  @override
  String get migration_activating => 'Notiek jaunā servera aktivizēšana…';

  @override
  String get migration_ready => 'Atrašanās vieta ir atjaunināta.';

  @override
  String get migration_blocked =>
      'Atrašanās vietas maiņai nepieciešama darbība servera pusē. Mēģiniet vēlāk vai sazinieties ar atbalsta dienestu.';

  @override
  String get migration_progress => 'Atrašanās vietas maiņas norise';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Pārbaužu intervāls: $seconds s.';
  }

  @override
  String get migration_resume => 'Turpināt atrašanās vietas maiņu';

  @override
  String get status_authorizing => 'Nepieciešama atļauja';

  @override
  String get status_authorizingDetail =>
      'Apstipriniet Android pieprasījumu, lai atļautu VPN.';

  @override
  String get status_preparing => 'Notiek sagatavošana';

  @override
  String get status_preparingDetail =>
      'Jūsu drošais savienojums tiek sagatavots.';

  @override
  String get status_reconnecting => 'Notiek atkārtota savienošana…';

  @override
  String get status_reconnectingDetail =>
      'Savienojums pārtraukts. VPN mēģina atkārtoti savienoties.';

  @override
  String get status_connecting => 'Notiek savienošana';

  @override
  String get status_connectingDetail => 'Notiek savienošana ar VPN serveri…';

  @override
  String get status_connected => 'Savienots';

  @override
  String get status_connectedDetail => 'Jūsu VPN savienojums ir aktīvs.';

  @override
  String get status_disconnecting => 'Notiek atvienošana';

  @override
  String get status_disconnectingDetail =>
      'Jūsu VPN savienojums tiek apturēts.';

  @override
  String get status_error => 'Savienojums nav pieejams';

  @override
  String get status_errorDetail =>
      'VPN savienojums nav apstiprināts. Mēģiniet vēlreiz.';

  @override
  String get status_idle => 'Atvienots';

  @override
  String get status_idleDetail =>
      'Savienojiet VPN, lai aizsargātu savienojumu.';

  @override
  String get trust_note =>
      'Lietotnes aizvēršana neaptur VPN. Lai to apturētu, izmantojiet pogu Atvienot.';

  @override
  String get locations_none => 'Pašlaik nav pieejamu atrašanās vietu.';

  @override
  String get locations_available => 'Izvēlieties nākamo atrašanās vietu.';

  @override
  String get locations_selected => 'Izvēlētā atrašanās vieta';

  @override
  String get locations_select => 'Izvēlēties šo atrašanās vietu';

  @override
  String get locations_lockedTunnel =>
      'Lai mainītu atrašanās vietu, atvienojiet VPN.';

  @override
  String get locations_lockedMigration =>
      'Pagaidiet, līdz atrašanās vietas maiņa ir pabeigta.';

  @override
  String get devices_title => 'Jūsu ierīces';

  @override
  String devices_used(Object count, Object limit) {
    return 'Ierīces: $count / $limit';
  }

  @override
  String get devices_refresh => 'Atsvaidzināt ierīces';

  @override
  String get devices_empty => 'Vēl nav reģistrēta neviena VPN ierīce.';

  @override
  String get devices_firstConnection =>
      'Jūsu tālrunis tiks pievienots pirmā savienojuma laikā.';

  @override
  String get devices_thisDevice => 'Šī ierīce';

  @override
  String devices_added(Object date) {
    return 'Pievienota $date';
  }

  @override
  String get devices_unnamed => 'Ierīce bez nosaukuma';

  @override
  String get action_remove => 'Noņemt';

  @override
  String get settings_title => 'Iestatījumi';

  @override
  String get settings_subtitle => 'Jūsu preferences un konts vienuviet.';

  @override
  String get settings_appearance => 'Izskats';

  @override
  String get settings_language => 'Valoda';

  @override
  String get settings_languageDescription =>
      'Izvēlētā valoda attiecas arī uz VPN paziņojumiem.';

  @override
  String get settings_account => 'Konts';

  @override
  String get settings_signOut => 'Izrakstīties';

  @override
  String get settings_privacy => 'Privātuma politika';

  @override
  String get settings_terms => 'Lietošanas noteikumi';

  @override
  String get settings_security => 'Drošība un pārredzamība';

  @override
  String get settings_licenses => 'Komponentu licences';

  @override
  String get settings_licensesDetail => 'Lietotnē izmantotā programmatūra';

  @override
  String settings_licensesLegalese(String url) {
    return 'Lietotnes un tās MPL-2.0 komponentu pirmkods: $url';
  }

  @override
  String get settings_background =>
      'VPN paliek ieslēgts, kad aizverat lietotni. Lai to apturētu, izmantojiet pogu Atvienot cilnē Savienojums.';

  @override
  String get theme_system => 'Sistēma';

  @override
  String get theme_light => 'Gaišs';

  @override
  String get theme_dark => 'Tumšs';

  @override
  String get language_system => 'Tālruņa valoda';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Noņemt šo ierīci?';

  @override
  String get dialog_removeCurrent =>
      'Šis tālrunis tiks atvienots no VPN un zaudēs piekļuvi. Tā VPN savienojuma dati tiks noņemti pēc servera apstiprinājuma.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN piekļuve ierīcei „$name“ tiks atsaukta. Šo darbību nevar atcelt.';
  }

  @override
  String get dialog_signOut => 'Vai izrakstīties?';

  @override
  String get dialog_signOutMessage =>
      'VPN tiks apturēts, un jums būs jāpierakstās vēlreiz. Šifrētās VPN atslēgas paliks šajā tālrunī nākamajam savienojumam.';

  @override
  String get action_cancel => 'Atcelt';

  @override
  String get action_close => 'Aizvērt';

  @override
  String get action_copy => 'Kopēt';

  @override
  String get action_renew => 'Atjaunot';

  @override
  String get action_signOut => 'Izrakstīties';

  @override
  String get notice_close => 'Aizvērt ziņojumu';

  @override
  String get notice_sessionExpired_title => 'Sesija beigusies';

  @override
  String get notice_sessionExpired_message =>
      'Jūsu sesija ir beigusies. Pierakstieties vēlreiz.';

  @override
  String get notice_connectionFailed_title => 'Neizdevās izveidot savienojumu';

  @override
  String get notice_invalidCredentials_message =>
      'E-pasta adrese vai parole ir nepareiza.';

  @override
  String get notice_emailVerification_title =>
      'Nepieciešams e-pasta apstiprinājums';

  @override
  String get notice_emailVerification_message =>
      'Pirms VPN ierīces pievienošanas apstipriniet e-pasta adresi.';

  @override
  String get notice_rateLimited_title => 'Pārāk daudz mēģinājumu';

  @override
  String get notice_deviceLimit_title => 'Sasniegts ierīču limits';

  @override
  String get notice_deviceLimit_message =>
      'Pirms citas ierīces pievienošanas noņemiet esošu ierīci.';

  @override
  String get notice_identityRenewal_title => 'Jāatjauno VPN identitāte';

  @override
  String get notice_identityRenewal_message =>
      'Šī identitāte tika noņemta. Izveidojiet jaunu vietējo identitāti.';

  @override
  String get notice_migrationPending_title => 'Notiek atrašanās vietas maiņa';

  @override
  String get notice_migrationPending_message =>
      'Atrašanās vietas maiņa jau notiek.';

  @override
  String get notice_migrationBlocked_title => 'Atrašanās vietas maiņa bloķēta';

  @override
  String get notice_migrationBlocked_message =>
      'Atrašanās vietas maiņai nepieciešama darbība servera pusē. Mēģiniet vēlāk vai sazinieties ar atbalsta dienestu.';

  @override
  String get notice_targetUnavailable_title =>
      'Serveris īslaicīgi nav pieejams';

  @override
  String get notice_targetUnavailable_message =>
      'Šis serveris īslaicīgi nav pieejams.';

  @override
  String get notice_networkUnavailable_title =>
      'Interneta savienojums nav pieejams';

  @override
  String get notice_networkUnavailable_message =>
      'Pārbaudiet savienojumu un mēģiniet vēlreiz.';

  @override
  String get notice_permissionDenied_title => 'VPN atļauja noraidīta';

  @override
  String get notice_permissionDenied_message =>
      'Sāciet savienojumu vēlreiz un apstipriniet Android atļaujas pieprasījumu.';

  @override
  String get notice_wireguardTimeout_title => 'Serveris neatbild';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard savienojuma izveide aizņēma pārāk ilgu laiku. Mēģiniet vēlreiz vai izvēlieties citu atrašanās vietu.';

  @override
  String get notice_tlsFailed_title => 'Drošais savienojums noraidīts';

  @override
  String get notice_tlsFailed_message =>
      'Serveris nepieņēma OpenVPN savienojumu. Mēģiniet vēlreiz. Ja problēma saglabājas, palaidiet diagnostiku.';

  @override
  String get notice_tunRejected_title => 'Android noraidīja VPN saskarni';

  @override
  String get notice_tunRejected_message =>
      'Android noraidīja OpenVPN pieprasīto tīkla konfigurāciju.';

  @override
  String get notice_openvpnStart_title => 'Neizdevās palaist OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN dzinējs nevarēja pabeigt palaišanu. Mēģiniet vēlreiz. Ja problēma saglabājas, sazinieties ar atbalsta dienestu.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostikas kods: $code';
  }

  @override
  String get notice_generic_title => 'Neizdevās izveidot VPN savienojumu';

  @override
  String get notice_generic_message => 'Radās kļūda. Mēģiniet vēlāk.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konts izveidots',
      'password_reset_sent': 'Paroles atiestatīšanas pieprasījums saņemts',
      'verification_email_sent': 'Apstiprinājuma e-pasts nosūtīts',
      'location_migration_pending': 'Notiek atrašanās vietas maiņa',
      'vpn_sign_in_required': 'Nepieciešama pierakstīšanās',
      'protocol_unavailable_at_location': 'Protokols nav pieejams',
      'vpn_permission_denied': 'VPN atļauja noraidīta',
      'revoked_identity_device_limit': 'Sasniegts ierīču limits',
      'tunnel_start_unexpected': 'Neizdevās palaist VPN',
      'flutter_disconnect_timeout': 'Atvienošana nav apstiprināta',
      'flutter_disconnect_unexpected': 'Neizdevās atvienot',
      'device_revoked': 'Ierīce noņemta',
      'revoke_unexpected': 'Neizdevās noņemt ierīci',
      'identity_renewal_unexpected': 'Neizdevās atjaunot identitāti',
      'openvpn_renewal_unexpected': 'Neizdevās atjaunot OpenVPN',
      'location_migration_blocked': 'Atrašanās vietas maiņa bloķēta',
      'location_migration_slow': 'Atrašanās vietas maiņa vēl notiek',
      'location_migration_conflict': 'Atrašanās vietas maiņa jāatsvaidzina',
      'location_migration_verification_failed':
          'Atrašanās vietas maiņa nav apstiprināta',
      'location_migration_device_changed':
          'Ierīce mainījās atrašanās vietas maiņas laikā',
      'tunnel_stop_failed': 'Atrašanās vietas maiņa nav pieejama',
      'device_clock_ahead': 'Ierīces pulkstenis steidzas',
      'other': 'Darbība neizdevās',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Konts ir izveidots, taču apstiprinājuma e-pastu neizdevās nosūtīt. Lietotnē izmantojiet atkārtotu nosūtīšanu.',
      'password_reset_sent':
          'Jūsu pieprasījums ir saņemts. Ja šai adresei ir piesaistīts konts, varat saņemt e-pasta ziņojumu. Pārbaudiet arī surogātpasta mapi.',
      'verification_email_sent': 'Tikko nosūtīts jauns apstiprinājuma e-pasts.',
      'location_migration_pending':
          'Pāreja uz $target vēl tiek sagatavota. Varat to turpināt, neveidojot ierīci no jauna.',
      'vpn_sign_in_required': 'Pirms VPN palaišanas pierakstieties savā kontā.',
      'protocol_unavailable_at_location':
          'Šajā atrašanās vietā nav pieejams izvēlētais protokols. Atsvaidziniet atrašanās vietas vai izvēlieties citu protokolu.',
      'vpn_permission_denied':
          'Android noraidīja VPN atļauju. Sāciet savienojumu vēlreiz un apstipriniet sistēmas pieprasījumu.',
      'revoked_identity_device_limit':
          'Šīs ierīces VPN piekļuve tika noņemta, un ierīču limits ir sasniegts. Noņemiet ierīci sadaļā Konts → Pārvaldīt manas ierīces.',
      'tunnel_start_unexpected':
          'Negaidīta kļūda pārtrauca tuneļa sagatavošanu. Pārbaudiet diagnostikas kodu un mēģiniet vēlreiz.',
      'flutter_disconnect_timeout':
          'Android noteiktajā laikā neapstiprināja VPN apturēšanu. Mēģiniet to apturēt vēlreiz.',
      'flutter_disconnect_unexpected':
          'Negaidīta kļūda neļāva apstiprināt, ka tunelis ir apturēts.',
      'device_revoked':
          'Ierīces VPN piekļuve tika atsaukta, un tās vietējie drošības dati tika noņemti.',
      'revoke_unexpected':
          'Ierīci neizdevās noņemt. Atsvaidziniet sarakstu un mēģiniet vēlreiz.',
      'identity_renewal_unexpected':
          'Jauno VPN identitāti neizdevās izveidot. Atsvaidziniet ierīces un mēģiniet vēlreiz.',
      'openvpn_renewal_unexpected':
          'OpenVPN profilu neizdevās atjaunot. Mēģiniet vēlreiz vai pārbaudiet diagnostikas kodu.',
      'location_migration_blocked':
          'Serveris pašlaik nevar pabeigt šo maiņu. Ierīce un tās vietējā identitāte tika saglabātas.',
      'location_migration_slow':
          'Serveris joprojām sagatavo pāreju uz $target. Pēc dažiem brīžiem izmantojiet pogu Turpināt.',
      'location_migration_conflict':
          'Ierīces stāvoklis serverī ir mainījies. Atsvaidziniet ierīces un pēc tam turpiniet maiņu.',
      'location_migration_verification_failed':
          'Serveris neapstiprināja jauno atrašanās vietu. Iepriekšējā vietējā identitāte tika saglabāta.',
      'location_migration_device_changed':
          'No servera atgrieztā ierīce vairs neatbilst ierīcei, kurai tiek veikta maiņa. Pirms atkārtota mēģinājuma atsvaidziniet ierīču sarakstu.',
      'tunnel_stop_failed':
          'Pirms jaunā savienojuma iepriekšējais tunelis ir pilnībā jāaptur.',
      'device_clock_ahead':
          'Šīs ierīces pulkstenis, šķiet, steidzas. Ieslēdziet automātisko datumu un laiku, lai saglabātu aktīvu sesiju.',
      'other':
          'Darbību neizdevās pabeigt. Mēģiniet vēlreiz vai nosūtiet diagnostikas kodu atbalsta dienestam.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesija beigusies',
      'invalid_credentials': 'Pierakstīšanās neizdevās',
      'email_verification_required': 'Nepieciešams e-pasta apstiprinājums',
      'verification_email_cooldown': 'E-pasts jau nosūtīts',
      'rate_limited': 'Pārāk daudz mēģinājumu',
      'invalid_registration': 'Informācija jāizlabo',
      'email_exists': 'Konts jau pastāv',
      'invalid_profile': 'Nederīgs profils',
      'invalid_device': 'Nederīga ierīce',
      'invalid_location': 'Atrašanās vieta nav pieejama',
      'device_limit': 'Sasniegts ierīču limits',
      'device_exists': 'VPN identitāte jau tiek izmantota',
      'device_identity_revoked': 'Jāatjauno VPN identitāte',
      'device_location_locked': 'Atrašanās vietas maiņa jāatsvaidzina',
      'location_migration_pending': 'Notiek atrašanās vietas maiņa',
      'location_migration_blocked': 'Atrašanās vietas maiņa bloķēta',
      'target_ca_mismatch': 'Nesaderīgs OpenVPN serveris',
      'location_migration_conflict': 'Atrašanās vietas maiņa jāatsvaidzina',
      'server_full': 'Serveris ir pilns',
      'capacity_unavailable': 'Atrašanās vieta īslaicīgi nav pieejama',
      'target_unavailable': 'Serveris īslaicīgi nav pieejams',
      'not_found': 'Vienums nav atrasts',
      'invalid_openvpn_csr': 'Nederīga OpenVPN identitāte',
      'openvpn_profile_exists': 'OpenVPN profils jau pastāv',
      'openvpn_profile_revoked': 'OpenVPN profils atsaukts',
      'openvpn_operation_pending': 'Notiek OpenVPN darbība',
      'openvpn_operation_terminal': 'OpenVPN darbība pārtraukta',
      'openvpn_address_unavailable': 'OpenVPN adrese nav pieejama',
      'openvpn_profile_conflict': 'OpenVPN konflikts',
      'openvpn_signer_unavailable': 'OpenVPN nav pieejams',
      'email_delivery_unavailable': 'E-pasta sūtīšana nav pieejama',
      'invalid_token': 'Nederīga saite',
      'network_unavailable': 'Interneta savienojums nav pieejams',
      'invalid_json': 'Nederīgs pieprasījums',
      'invalid_api_response': 'Nederīga servera atbilde',
      'ipv6_unavailable': 'IPv6 nav pieejams',
      'invalid_ip_families': 'Tīkla konfigurācija noraidīta',
      'other': 'Pakalpojums nav pieejams',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Jūsu sesija ir beigusies. Pierakstieties vēlreiz.',
      'invalid_credentials': 'E-pasta adrese vai parole ir nepareiza.',
      'email_verification_required':
          'Pirms VPN ierīces pievienošanas apstipriniet e-pasta adresi.',
      'invalid_registration':
          'Pārbaudiet pieprasīto informāciju un piekrišanas.',
      'email_exists': 'Šo e-pasta adresi jau izmanto cits konts.',
      'invalid_profile': 'Pārbaudiet profila informāciju.',
      'invalid_device':
          'Šīs ierīces nosaukums vai vietējā identitāte ir nederīga.',
      'invalid_location':
          'Atsvaidziniet atrašanās vietu sarakstu un mēģiniet vēlreiz.',
      'device_limit':
          'Pirms citas ierīces pievienošanas noņemiet esošu ierīci.',
      'device_exists': 'Šī VPN identitāte jau ir saistīta ar citu kontu.',
      'device_identity_revoked':
          'Šī identitāte ir noņemta. Jāizveido jauna vietējā identitāte.',
      'device_location_locked':
          'Šīs ierīces atrašanās vieta tikko mainījās. Lietotne atsāks notiekošo maiņu.',
      'location_migration_pending': 'Atrašanās vietas maiņa jau notiek.',
      'location_migration_blocked':
          'Atrašanās vietas maiņai nepieciešama darbība servera pusē. Mēģiniet vēlāk vai sazinieties ar atbalsta dienestu.',
      'target_ca_mismatch':
          'Šis serveris vēl nav saderīgs ar pašreizējo OpenVPN profilu.',
      'location_migration_conflict':
          'Atsvaidziniet ierīces un pēc tam mēģiniet atrašanās vietas maiņu vēlreiz.',
      'server_full':
          'Šajā atrašanās vietā ir sasniegts savienojumu limits. Izvēlieties citu atrašanās vietu vai mēģiniet vēlāk.',
      'capacity_unavailable':
          'Pašlaik nevaram apstiprināt, vai šī atrašanās vieta ir pieejama. Izvēlieties citu atrašanās vietu vai mēģiniet vēlāk.',
      'target_unavailable': 'Šis serveris īslaicīgi nav pieejams.',
      'not_found': 'Šis vienums vairs nav pieejams jūsu kontā.',
      'invalid_openvpn_csr':
          'Izveidojiet jaunu OpenVPN identitāti un mēģiniet vēlreiz.',
      'openvpn_profile_exists': 'Šai ierīcei jau ir OpenVPN profils.',
      'openvpn_profile_revoked': 'Lai turpinātu, atjaunojiet OpenVPN profilu.',
      'openvpn_operation_pending':
          'Izmaiņas vēl tiek izplatītas. Mēģiniet vēlāk.',
      'openvpn_operation_terminal':
          'Izveidojiet jaunu OpenVPN identitāti un mēģiniet vēlreiz.',
      'openvpn_address_unavailable':
          'Pašlaik nav pieejama neviena OpenVPN adrese.',
      'openvpn_profile_conflict':
          'Profils ir mainījies. Atsvaidziniet ierīces un mēģiniet vēlreiz.',
      'openvpn_signer_unavailable':
          'OpenVPN pakalpojums īslaicīgi nav pieejams.',
      'email_delivery_unavailable':
          'Neizdevās nosūtīt e-pasta ziņojumu. Mēģiniet vēlāk.',
      'invalid_token':
          'Šī saite nav derīga vai tās derīguma termiņš ir beidzies. Pieprasiet jaunu.',
      'network_unavailable':
          'Pārbaudiet interneta savienojumu un mēģiniet vēlreiz.',
      'invalid_json': 'Pārbaudiet ievadīto informāciju un mēģiniet vēlreiz.',
      'invalid_api_response':
          'Serveris atgrieza negaidītu atbildi. Mēģiniet vēlāk.',
      'ipv6_unavailable':
          'Serveris pašlaik nevar aktivizēt IPv6. Mēģiniet vēlāk.',
      'invalid_ip_families':
          'Tuneļa konfigurācija ir nepilnīga vai neatbilst atļautajām adresēm. Mēģiniet vēlreiz no lietotnes.',
      'other': 'Radās servera kļūda. Mēģiniet vēlāk.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Mēģiniet vēlreiz pēc dažiem brīžiem.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Mēģiniet vēlreiz pēc $seconds sekundēm.',
      one: 'Mēģiniet vēlreiz pēc $seconds sekundes.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Mēģiniet vēlreiz pēc $minutes minūtēm.',
      one: 'Mēģiniet vēlreiz pēc $minutes minūtes.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Mēģiniet vēlreiz pēc $hours stundām.',
      one: 'Mēģiniet vēlreiz pēc $hours stundas.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Sistēmas VPN atsākšana nav pieejama',
      'system_vpn_resume_corrupt': 'Nederīga sistēmas VPN atsākšana',
      'system_vpn_resume_session_invalid': 'Nederīga VPN atsākšanas sesija',
      'system_vpn_resume_identity_changed': 'VPN identitāte ir mainījusies',
      'system_vpn_resume_identity_invalid':
          'Nederīga VPN atsākšanas identitāte',
      'system_vpn_resume_storage_failed': 'VPN atsākšanas krātuve nav pieejama',
      'system_vpn_resume_network_timeout': 'VPN atsākšanai nav tīkla',
      'system_vpn_resume_blocked': 'VPN atsākšana bloķēta',
      'system_vpn_resume_failed': 'VPN atsākšana neizdevās',
      'system_vpn_resume_error_invalid': 'Nederīga VPN atsākšanas kļūda',
      'wireguard_identity_store_failed': 'WireGuard identitāte nav saglabāta',
      'wireguard_identity_unavailable': 'WireGuard identitāte nav pieejama',
      'vpn_host_destroyed': 'Android VPN komponents apturēts',
      'vpn_host_unavailable': 'Android VPN komponents nav pieejams',
      'vpn_permission_required': 'Nepieciešama VPN atļauja',
      'vpn_permission_denied': 'VPN atļauja noraidīta',
      'vpn_permission_request_failed': 'Neizdevās pieprasīt atļauju',
      'wireguard_foreground_service_unavailable':
          'WireGuard pakalpojums nav pieejams',
      'wireguard_identity_invalid': 'Nederīga vietējā WireGuard atslēga',
      'wireguard_identity_in_use': 'WireGuard identitāte jau tiek izmantota',
      'wireguard_configuration_invalid': 'Nederīga WireGuard konfigurācija',
      'wireguard_operation_pending': 'WireGuard darbība joprojām aktīva',
      'wireguard_start_failed': 'WireGuard palaišana noraidīta',
      'wireguard_stop_timeout': 'WireGuard apturēšana nav apstiprināta',
      'wireguard_handshake_timeout': 'WireGuard neatbild',
      'openvpn_connection_timeout': 'OpenVPN neatbild',
      'openvpn_core_unavailable': 'OpenVPN dzinējs nav pieejams',
      'openvpn_operation_pending': 'OpenVPN sesija joprojām aktīva',
      'openvpn_stop_timeout': 'OpenVPN apturēšana nav apstiprināta',
      'openvpn_profile_unavailable': 'Vietējais OpenVPN profils nav atrasts',
      'openvpn_native_failed': 'Natīvais OpenVPN izsaukums pārtraukts',
      'openvpn_key_generation_failed':
          'Neizdevās izveidot OpenVPN P-256 atslēgu',
      'openvpn_csr_generation_failed': 'Neizdevās izveidot OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN identitāte nav saglabāta',
      'openvpn_identity_clear_failed':
          'OpenVPN identitātes noņemšana nav pabeigta',
      'openvpn_identity_in_use': 'OpenVPN identitāte joprojām tiek izmantota',
      'openvpn_tls_verification_required': 'Trūkst OpenVPN TLS pārbaudes',
      'openvpn_cipher_invalid': 'Nederīgs OpenVPN šifrs',
      'openvpn_profile_rejected': 'OpenVPN profils noraidīts',
      'openvpn_identity_inconsistent': 'Neatbilstoša OpenVPN identitāte',
      'tls_handshake_failed': 'OpenVPN saskaņošana noraidīta',
      'tls_alert_unknown_ca': 'OpenVPN klienta sertifikāts nav atpazīts',
      'tls_alert_bad_certificate': 'OpenVPN klienta sertifikāts noraidīts',
      'tls_alert_unsupported_certificate': 'Neatbalstīts OpenVPN sertifikāts',
      'tls_client_certificate_required':
          'Nepieciešams OpenVPN klienta sertifikāts',
      'tls_alert_misc': 'OpenVPN TLS brīdinājums',
      'tls_signature_algorithm_rejected': 'Neatbalstīts OpenVPN paraksts',
      'tls_handshake_rejected': 'OpenVPN TLS saskaņošana noraidīta',
      'tls_version_rejected': 'Nesaderīga OpenVPN TLS versija',
      'tls_certificate_expired': 'TLS sertifikāta derīgums beidzies',
      'tls_certificate_revoked': 'TLS sertifikāts anulēts',
      'transport_failed': 'OpenVPN serveris nav sasniedzams',
      'tun_configuration_rejected': 'Neizdevās izveidot OpenVPN saskarni',
      'tun_setup_failed': 'OpenVPN TUN iestatīšana neizdevās',
      'tun_interface_create_failed': 'OpenVPN saskarnes izveide neizdevās',
      'tun_interface_disabled': 'OpenVPN saskarne atspējota',
      'tun_halted': 'OpenVPN saskarne pārtraukta',
      'tun_already_established': 'OpenVPN saskarne jau ir atvērta',
      'tun_addresses_missing': 'Trūkst OpenVPN adreses',
      'tun_routes_missing': 'Trūkst OpenVPN maršrutu',
      'tun_dns_missing': 'Trūkst OpenVPN DNS',
      'tun_permission_revoked': 'VPN atļauja atsaukta',
      'tun_establish_returned_null': 'Android noraidīja VPN saskarni',
      'openvpn_service_start_failed': 'OpenVPN pakalpojums nav pieejams',
      'openvpn_operation_timeout': 'OpenVPN izsaukuma laiks beidzies',
      'openvpn_start_failed': 'OpenVPN palaišana noraidīta',
      'openvpn_connection_failed': 'OpenVPN savienojums pārtraukts',
      'openvpn_core_status_error': 'OpenVPN Core beidza darbību ar kļūdu',
      'openvpn_stopped_before_connected': 'OpenVPN apturēts pirms savienošanas',
      'openvpn_auth_failed': 'OpenVPN autentifikācija noraidīta',
      'openvpn_client_setup_failed': 'OpenVPN klienta iestatīšana neizdevās',
      'openvpn_client_halted': 'OpenVPN klients pārtraukts',
      'openvpn_client_restart': 'Pieprasīta OpenVPN atkārtota palaišana',
      'openvpn_inactive_timeout': 'OpenVPN bija neaktīvs pārāk ilgi',
      'openvpn_session_expired': 'OpenVPN sesijas derīgums beidzies',
      'openvpn_credentials_required': 'Neatbalstīta OpenVPN autentifikācija',
      'openvpn_proxy_failed': 'OpenVPN starpnieka savienojums neizdevās',
      'openvpn_compression_failed': 'OpenVPN saspiešana noraidīta',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM šifrēšana nav pieejama',
      'openvpn_feature_unsupported': 'Neatbalstīta OpenVPN funkcija',
      'network_unavailable': 'Interneta savienojums nav pieejams',
      'network_lost': 'Tīkls nav pieejams',
      'certificate_validation_failed': 'Servera sertifikāts noraidīts',
      'openvpn_certificate_expired': 'OpenVPN sertifikāta derīgums beidzies',
      'tunnel_active_for_another_account':
          'Cita konta tunelis joprojām ir aktīvs',
      'tunnel_already_active': 'Natīvais tunelis jau ir aktīvs',
      'tunnel_stop_timeout': '$protocol apturēšana nav apstiprināta',
      'tunnel_disconnected': '$protocol pārtraukts',
      'native_bridge_unavailable': 'Android tilts nav pieejams',
      'native_operation_failed': 'Android darbība pārtraukta',
      'invalid_arguments': 'Nepilnīgi VPN parametri',
      'invalid_account_id': 'Nederīgs VPN konts',
      'invalid_device_id': 'Nederīgs ierīces identifikators',
      'storage_key_not_allowed': 'Krātuves atslēga noraidīta',
      'secure_storage_read_failed': 'Drošās krātuves nolasīšana neizdevās',
      'secure_storage_write_failed': 'Drošās krātuves ierakstīšana neizdevās',
      'key_generation_failed': 'Neizdevās ģenerēt WireGuard atslēgu',
      'csr_generation_failed': 'Neizdevās ģenerēt OpenVPN CSR',
      'openvpn_recovery_exhausted': 'OpenVPN atkopšana jau izmantota',
      'openvpn_recovery_failed': 'OpenVPN atkopšana neizdevās',
      'openvpn_renewal_required': 'Nepieciešams atjaunot OpenVPN sertifikātu',
      'other': 'Neklasificēta natīvā VPN kļūda',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android nevar atrast VPN sesiju, ko var atsākt. Lietotnē sāciet jaunu savienojumu.',
      'system_vpn_resume_corrupt':
          'Saglabātie VPN atsākšanas dati ir nederīgi, tāpēc tie netiks izmantoti. Sāciet jaunu savienojumu.',
      'system_vpn_resume_session_invalid':
          'Saglabātā sesija vairs nevar atsākt VPN. Lietotnē pierakstieties vēlreiz.',
      'system_vpn_resume_identity_changed':
          'Vietējā VPN identitāte ir mainījusies. Atsākšana tika apturēta; sāciet jaunu savienojumu.',
      'system_vpn_resume_identity_invalid':
          'Atsākšanai paredzētā identitāte ir nederīga. Sāciet jaunu savienojumu.',
      'system_vpn_resume_storage_failed':
          'Android nevarēja nolasīt vai atjaunināt šifrētos atsākšanas datus. Sāciet jaunu savienojumu.',
      'system_vpn_resume_network_timeout':
          'Android noteiktajā laikā neatrada tīklu, lai atsāktu VPN. Mēģiniet vēlreiz, kad ir pieejams tīkls.',
      'system_vpn_resume_blocked':
          'VPN atsākšana ir bloķēta. Pārbaudiet Android iestatījumus un pēc tam sāciet jaunu savienojumu.',
      'system_vpn_resume_failed':
          'Android VPN atsākšana neizdevās. Lietotnē sāciet jaunu savienojumu.',
      'system_vpn_resume_error_invalid':
          'Android atgrieza neizmantojamu atsākšanas kļūdu. Sāciet jaunu savienojumu.',
      'wireguard_identity_store_failed':
          'Android nevarēja saglabāt šī konta šifrēto WireGuard identitāti.',
      'wireguard_identity_unavailable':
          'Šim savienojumam nav pieejama izmantojama WireGuard identitāte.',
      'vpn_host_destroyed':
          'Android komponents, kas darbina VPN, tika apturēts. Sāciet jaunu savienojumu.',
      'vpn_host_unavailable':
          'Android nevar izveidot komponentu, kas darbina VPN. Pārbaudiet VPN iestatījumus un mēģiniet vēlreiz.',
      'openvpn_renewal_required':
          'OpenVPN sertifikātu neizdevās atjaunot automātiski. Lietotnē sāciet jaunu savienojumu.',
      'openvpn_recovery_failed':
          'Automātiskā atkopšana neizdevās. Lietotnē sāciet jaunu savienojumu.',
      'openvpn_recovery_exhausted':
          'Automātiskā atkopšana jau ir izmantota. Lietotnē sāciet jaunu savienojumu.',
      'vpn_permission_required':
          'Pirms tuneļa palaišanas Android pieprasa jaunu VPN atļauju.',
      'vpn_permission_denied':
          'Lai turpinātu, Android pieprasījumā atļaujiet FuzeVPN.',
      'vpn_permission_request_failed':
          'Android nevarēja atvērt VPN atļaujas ekrānu.',
      'wireguard_foreground_service_unavailable':
          'Android nevarēja uzturēt WireGuard pakalpojumu priekšplānā.',
      'wireguard_identity_invalid':
          'Šī konta šifrētā WireGuard atslēga nav nolasāma vai ir nederīga.',
      'wireguard_identity_in_use':
          'Cita darbība joprojām izmanto šī konta WireGuard atslēgu.',
      'wireguard_configuration_invalid':
          'Saņemtā WireGuard adrese, DNS, servera atslēga vai maršruti ir nederīgi.',
      'wireguard_operation_pending':
          'Iepriekšējā WireGuard darbība vēl nav atbrīvojusi savu natīvo pakalpojumu.',
      'wireguard_start_failed':
          'WireGuard dzinējs noraidīja konfigurācijas aktivizēšanu.',
      'wireguard_stop_timeout':
          'WireGuard pakalpojums noteiktajā laikā neapstiprināja VPN saskarnes atbrīvošanu.',
      'wireguard_handshake_timeout':
          'Tunelis noteiktajā laikā neapstiprināja rokasspiedienu ar serveri.',
      'openvpn_connection_timeout':
          'OpenVPN noteiktajā laikā neapstiprināja savienojumu ar serveri.',
      'openvpn_core_unavailable':
          'Šajā lietotnes versijā nav iekļauts izmantojams OpenVPN dzinējs.',
      'openvpn_operation_pending':
          'Natīvais dzinējs joprojām uztur iepriekšējo OpenVPN sesiju un neļauj izveidot otru.',
      'openvpn_stop_timeout':
          'OpenVPN Core noteiktajā laikā neapstiprināja, ka tā natīvā sesija ir apturēta un iznīcināta.',
      'openvpn_profile_unavailable':
          'Šim savienojumam nevar nolasīt pārbaudītu OpenVPN profilu.',
      'openvpn_native_failed':
          'Lietotnes kļūda pārtrauca OpenVPN. Mēģiniet savienoties vēlreiz. Ja problēma saglabājas, palaidiet diagnostiku.',
      'openvpn_key_generation_failed':
          'Android Keystore nevarēja izveidot vai nolasīt neeksportējamo P-256 privāto atslēgu.',
      'openvpn_csr_generation_failed':
          'Android Keystore atslēga nevarēja parakstīt OpenVPN sertifikāta pieprasījumu.',
      'openvpn_identity_store_failed':
          'OpenVPN sertifikātu vai profilu nevarēja saglabāt šifrētajā krātuvē.',
      'openvpn_identity_clear_failed':
          'Android nevarēja pilnībā noņemt šī konta vietējo OpenVPN identitāti.',
      'openvpn_identity_in_use':
          'Natīvā OpenVPN sesija joprojām izmanto šīs ierīces atslēgu vai sertifikātu.',
      'openvpn_tls_verification_required':
          'Profilā nav skaidri prasīta servera sertifikāta pārbaude.',
      'openvpn_cipher_invalid':
          'Serveris piedāvāja šifrēšanas algoritmu, kura nav atļauto sarakstā.',
      'openvpn_profile_rejected':
          'No servera saņemtais profils nav saderīgs. Atkārtoti izveidojiet šo ierīci un mēģiniet vēlreiz.',
      'openvpn_identity_inconsistent':
          'Sertifikāts neatbilst šī tālruņa drošajai identitātei. Neviens vietējais profils netika aizstāts.',
      'tls_handshake_failed':
          'Serveris noraidīja TLS saskaņošanu. Ja problēma saglabājas, atkārtoti izveidojiet profilu.',
      'tls_alert_unknown_ca':
          'Serveris neatpazīst šīs ierīces sertifikāta izdevēju. OpenVPN serveris ir jāpārbauda.',
      'tls_alert_bad_certificate':
          'Serveris noraidīja šīs ierīces sertifikātu. Pirms mēģināt vēlreiz, atkārtoti izveidojiet šo ierīci.',
      'tls_alert_unsupported_certificate':
          'Serveris neatbalsta drošo sertifikāta veidu, ko izmanto Android.',
      'tls_client_certificate_required':
          'Serveris pieprasa klienta sertifikātu, taču OpenVPN Core nevarēja to uzrādīt.',
      'tls_alert_misc':
          'Serveris atgrieza TLS brīdinājumu, kas neietilpst sertifikāta vai versijas kategorijās.',
      'tls_signature_algorithm_rejected':
          'Serveris noraidīja Android Keystore atslēgas ECDSA P-256 algoritmu.',
      'tls_handshake_rejected':
          'Serveris pārtrauca TLS saskaņošanu pirms savienojuma izveides.',
      'tls_version_rejected':
          'Klients un serveris neatrada kopīgu TLS versiju.',
      'tls_certificate_expired':
          'Savienojuma laikā uzrādītā sertifikāta derīgums ir beidzies.',
      'tls_certificate_revoked':
          'Savienojuma laikā uzrādītais sertifikāts ir anulēts.',
      'transport_failed':
          'OpenVPN serveris pašreizējā tīklā neatbild. Mēģiniet vēlreiz pēc brīža.',
      'tun_configuration_rejected':
          'Android noraidīja tīkla konfigurāciju, ko pieprasīja OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core noraidīja tīkla plānu pirms Android saskarnes izveides.',
      'tun_interface_create_failed':
          'OpenVPN Core nevarēja iegūt TUN saskarni no Android VpnService.',
      'tun_interface_disabled':
          'Android vai OpenVPN Core savienojuma laikā atspējoja TUN saskarni.',
      'tun_halted': 'OpenVPN Core saņēma pieprasījumu apturēt TUN saskarni.',
      'tun_already_established':
          'OpenVPN vienā savienojumā pieprasīja otru saskarni. Drošības nolūkos tunelis tika apturēts.',
      'tun_addresses_missing':
          'Serveris nenodrošināja izmantojamu tuneļa adresi.',
      'tun_routes_missing':
          'Serveris nenodrošināja izmantojamus tuneļa maršrutus.',
      'tun_dns_missing': 'Serveris nenodrošināja izmantojamu DNS serveri.',
      'tun_permission_revoked':
          'Android savienojuma laikā atsauca VPN atļauju.',
      'tun_establish_returned_null':
          'Android neizveidoja saskarni, parasti tāpēc, ka joprojām ir aktīvs cits VPN.',
      'openvpn_service_start_failed':
          'Android nevarēja palaist OpenVPN priekšplāna pakalpojumu.',
      'openvpn_operation_timeout':
          'JNI izsaukums OpenVPN Core pārsniedza maksimāli pieļaujamo ilgumu.',
      'openvpn_start_failed':
          'Android pakalpojums ir gatavs, taču OpenVPN Core nepieņēma profila palaišanu.',
      'openvpn_connection_failed':
          'OpenVPN Core apturēja darbību, pirms nosūtīja notikumu CONNECTED.',
      'openvpn_core_status_error':
          'Natīvais OpenVPN cikls beidzās ar kļūdu, bez konkrētāka noslēguma notikuma.',
      'openvpn_stopped_before_connected':
          'Natīvais OpenVPN cikls apstājās pirms CONNECTED, bez skaidras Core kļūdas.',
      'openvpn_auth_failed':
          'OpenVPN serveris noraidīja profila autentifikāciju.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nevarēja inicializēt klientu pirms tīkla savienojuma izveides.',
      'openvpn_client_halted':
          'OpenVPN Core saņēma klienta galīgu apturēšanas pieprasījumu.',
      'openvpn_client_restart':
          'OpenVPN Core pieprasīja savas pārraides sesijas atkārtotu palaišanu.',
      'openvpn_inactive_timeout':
          'OpenVPN Core aizvēra sesiju pēc neaktivitātes laika ierobežojuma.',
      'openvpn_session_expired':
          'Serveris ziņoja, ka OpenVPN sesijas derīgums ir beidzies.',
      'openvpn_credentials_required':
          'Serveris vai starpnieks pieprasa interaktīvus pierakstīšanās datus, kas nav iekļauti šajā sertifikāta profilā.',
      'openvpn_proxy_failed':
          'OpenVPN Core ziņoja par konfigurētā starpnieka vai releja kļūmi.',
      'openvpn_compression_failed':
          'OpenVPN Core noraidīja saspiešanas režīmu, ko paziņoja profils vai serveris.',
      'openvpn_ntlm_crypto_unavailable':
          'Profils pieprasa NTLM šifrēšanu, kas šajā versijā nav pieejama.',
      'openvpn_feature_unsupported':
          'Profilam vai serverim nepieciešama funkcija, kas šajā Android klientā nav pieejama.',
      'network_unavailable':
          'Nav pieejams neviens izmantojams fiziskais tīkls.',
      'network_lost': 'Tīkls tika zaudēts, tāpēc tunelis tika apturēts.',
      'certificate_validation_failed':
          'OpenVPN servera identitāti nevarēja pārbaudīt.',
      'openvpn_certificate_expired':
          'OpenVPN sertifikāta derīgums ir beidzies. Lai atjaunotu sertifikātu, lietotnē sāciet jaunu savienojumu.',
      'tunnel_active_for_another_account':
          'Pirms šī savienojuma jāaptur cita konta tunelis.',
      'tunnel_already_active':
          'Android ziņo, ka iepriekšējā VPN sesija joprojām izmanto saskarni.',
      'tunnel_stop_timeout':
          '$protocol dzinējs noteiktajā laikā neapstiprināja VPN saskarnes atbrīvošanu.',
      'tunnel_disconnected':
          'Natīvais dzinējs ziņoja, ka tunelis pēc palaišanas negaidīti beidza darbību.',
      'native_bridge_unavailable':
          'Lietotne nevar piekļūt Android VPN pakalpojumam. Aizveriet un atkārtoti atveriet lietotni, pēc tam mēģiniet vēlreiz.',
      'native_operation_failed':
          'Lietotnes kļūda pārtrauca VPN darbību. Mēģiniet vēlreiz. Ja problēma saglabājas, palaidiet diagnostiku.',
      'invalid_arguments':
          'Šai VPN darbībai nepieciešamā informācija ir nepilnīga. Mēģiniet vēlreiz. Ja problēma saglabājas, palaidiet diagnostiku.',
      'invalid_account_id':
          'Natīvā darbība nav saistīta ar derīgu konta identifikatoru.',
      'invalid_device_id':
          'Natīvajam dzinējam nosūtītais ierīces identifikators ir tukšs vai nederīgs.',
      'storage_key_not_allowed':
          'Android tilts bloķēja atslēgu, kas nav atļauto krātuves atslēgu sarakstā.',
      'secure_storage_read_failed':
          'Android Keystore nevarēja atšifrēt šī konta vietējos datus.',
      'secure_storage_write_failed':
          'Android Keystore nevarēja šifrēt vai saglabāt vietējos datus.',
      'key_generation_failed':
          'Android nevarēja izveidot vai nolasīt WireGuard atslēgu drošajā krātuvē.',
      'csr_generation_failed':
          'Android Keystore nevarēja izveidot vai parakstīt OpenVPN P-256 CSR.',
      'other':
          'Kļūda nedokumentētā natīvā koda zarā. Nosūtiet tālāk redzamo diagnostikas kodu atbalsta dienestam.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Atļaujas pieprasījums jau ir atvērts';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN atļaujas pieprasījums jau ir parādīts. Pirms mēģināt vēlreiz, pabeidziet to.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN atļaujas pieprasījums ir pārtraukts';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN atļaujas ekrāns tika aizvērts, pirms lietotne saņēma atbildi.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN savienojums nav apstiprināts';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN savienojumu nevarēja apstiprināt. Drošības nolūkos tas tika apturēts. Mēģiniet vēlreiz.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profils atsaukts';

  @override
  String get openvpnCleanup_working =>
      'Tiek apturēts un noņemts atsauktais OpenVPN profils…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN apturēšana nav apstiprināta. Pirms jauna profila izveides mēģiniet vēlreiz.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Atsauktais OpenVPN profils nav pilnībā noņemts. Mēģiniet tīrīšanu vēlreiz.';

  @override
  String get openvpnCleanup_complete =>
      'Atsauktais OpenVPN profils ir noņemts. Lai izveidotu jaunu, pieskarieties pogai Savienot.';

  @override
  String get network_title => 'Tīkla konfigurācija';

  @override
  String get network_ipv4Fallback =>
      'IPv6 īslaicīgi nav pieejams. Sagatavošana turpinās ar IPv4.';

  @override
  String get network_rejectedTitle => 'Tīkla konfigurācija noraidīta';

  @override
  String get network_rejectedMessage =>
      'Tuneļa konfigurācija ir nepilnīga vai neatbilst atļautajām adresēm. Mēģiniet vēlreiz no lietotnes.';

  @override
  String get network_unreadableTitle => 'Vietējā konfigurācija nav nolasāma';

  @override
  String get network_unreadableMessage =>
      'Saglabāto OpenVPN tīkla konfigurāciju nevar izmantot. Lai to atjauninātu, savienojieties vēlreiz no lietotnes.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Tīkla aizsardzība';

  @override
  String get protection_subtitle =>
      'Bloķēt tiešu piekļuvi internetam, ja VPN savienojums pārtrūkst.';

  @override
  String get protection_active => 'Sistēmas aizsardzība ir aktīva';

  @override
  String get protection_alwaysOnOnly =>
      'Vienmēr ieslēgts VPN ir aktivizēts; ieslēdziet „Bloķēt savienojumus bez VPN“';

  @override
  String get protection_inactive => 'Sistēmas aizsardzība nav aktīva';

  @override
  String get protection_unknown => 'Pārbaudiet sistēmas aizsardzību';

  @override
  String get protection_openSettings => 'Atvērt Android iestatījumus';

  @override
  String get protection_dialogTitle => 'Iestatiet tīkla aizsardzību';

  @override
  String get protection_dialogMessage =>
      'Android pārvalda vienmēr ieslēgtu VPN un savienojumu bloķēšanu ārpus VPN. Pārliecinieties, ka ir izvēlēts FuzeVPN, un sistēmas iestatījumos ieslēdziet bloķēšanu.';

  @override
  String get protection_dialogOpen => 'Atvērt iestatījumus';

  @override
  String get session_systemProtectionNote =>
      'Ja Android joprojām bloķē datplūsmu ārpus VPN, atveriet sistēmas iestatījumus, lai pārbaudītu vai mainītu šo aizsardzību.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Lietotnes diagnostika';

  @override
  String get diagnostics_automaticTitle => 'Sūtīt svarīgas kļūdas';

  @override
  String get diagnostics_automaticDescription =>
      'Kad rodas svarīga kļūda, tiek nosūtīts neliels tehnisks pārskats.';

  @override
  String get diagnostics_privacy =>
      'Nosūtītie pārskati ir saistīti ar kontu, kurā esat pierakstījies, un tiek glabāti 30 dienas. Tajos nav pārlūkošanas vēstures, paroļu vai VPN atslēgu.';

  @override
  String get diagnostics_manualOpen => 'Palaist diagnostiku';

  @override
  String get diagnostics_localDescription =>
      'Izveidojiet pārskatu par lietotnes un VPN stāvokli. Jūsu savienojums paliek nemainīts.';

  @override
  String get diagnostics_sendReport => 'Nosūtīt pārskatu';

  @override
  String get diagnostics_sendHint =>
      'Atstājiet šo rūtiņu neatzīmētu, lai pārskats paliktu šajā ierīcē.';

  @override
  String get diagnostics_signedOut =>
      'Lai nosūtītu pārskatu, pierakstieties savā kontā.';

  @override
  String get diagnostics_localLifetime =>
      'Saglabājiet šo pārskatu tālrunī, lai tas būtu pieejams arī pēc lietotnes aizvēršanas.';

  @override
  String get diagnostics_run => 'Palaist diagnostiku';

  @override
  String get diagnostics_rerun => 'Palaist diagnostiku vēlreiz';

  @override
  String get diagnostics_running => 'Notiek pārbaude…';

  @override
  String get diagnostics_sending => 'Notiek pārskata nosūtīšana…';

  @override
  String get diagnostics_prepared => 'Pārskats ir gatavs šajā ierīcē';

  @override
  String get diagnostics_queued => 'Pārskats gaida nosūtīšanu';

  @override
  String get diagnostics_sent => 'Pārskats saņemts';

  @override
  String get diagnostics_failed =>
      'Nosūtīšana neizdevās. Vietējais pārskats joprojām ir pieejams.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostikas pārskatu nevarēja sagatavot. Mēģiniet vēlreiz.';

  @override
  String get diagnostics_authenticationRequired =>
      'Lai nosūtītu pārskatu, pierakstieties vēlreiz.';

  @override
  String get diagnostics_retry => 'Mēģināt nosūtīt vēlreiz';

  @override
  String get diagnostics_export => 'Saglabāt pārskatu';

  @override
  String get diagnostics_exportFailed =>
      'Eksportēšana neizdevās. Mēģiniet vēlreiz no vietējā pārskata.';

  @override
  String get diagnostics_preferenceFailed =>
      'Šo iestatījumu nevarēja saglabāt. Mēģiniet vēlreiz.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Atsauce: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Saņemts $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Glabājas līdz $date';
  }

  @override
  String get diagnostics_duplicate => 'Šis pārskats jau bija saņemts.';

  @override
  String get diagnostics_preview => 'Pārskata priekšskatījums';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pievienotie tehniskie notikumi: $count',
      zero: 'Nav pievienotu tehnisku notikumu',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tehniskā informācija';

  @override
  String get diagnostics_empty => 'Diagnostikas pārskats vēl nav sagatavots.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tuneļa stāvoklis',
      'handshake': 'Savienojuma apstiprinājums',
      'certificate': 'VPN sertifikāts',
      'kill_switch': 'Android aizsardzība',
      'connectivity': 'Pieejamais tīkls',
      'api_reachability': 'Piekļuve pakalpojumam',
      'secure_storage': 'Drošā krātuve',
      'other': 'Vietējā pārbaude',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Pārbaudīts',
      'failed': 'Nepieciešama uzmanība',
      'skipped': 'Netestēts — nav aktīvas pārbaudes',
      'unknown': 'Informācija nav pieejama',
      'other': 'Informācija nav pieejama',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Laipni lūdzam lietotnē FuzeVPN';

  @override
  String get connection_changeLocation => 'Mainīt atrašanās vietu';

  @override
  String get connection_details => 'Savienojuma informācija';

  @override
  String get locations_searchLabel => 'Meklēt pilsētu vai valsti';

  @override
  String get locations_clearSearch => 'Notīrīt meklēšanu';

  @override
  String get locations_filterAll => 'Visas';

  @override
  String get locations_filterFavorites => 'Izlase';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atrašanās vietas',
      one: '$count atrašanās vieta',
      zero: '$count atrašanās vietu',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Atrašanās vietas nav atrastas';

  @override
  String get locations_noResultsHint => 'Mēģiniet citu pilsētu vai valsti.';

  @override
  String get locations_noFavorites => 'Jūsu izlase vienmēr pa rokai';

  @override
  String get locations_noFavoritesHint =>
      'Pieskarieties zvaigznītei blakus atrašanās vietai, lai to saglabātu šeit.';

  @override
  String get locations_showAll => 'Skatīt visas atrašanās vietas';

  @override
  String locations_addFavorite(String name) {
    return 'Pievienot $name izlasei';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Noņemt $name no izlases';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Atrašanās vietu nevarēja saglabāt izlasē. Mēģiniet vēlreiz.';

  @override
  String get locations_emptyTitle => 'Nav pieejamu atrašanās vietu';

  @override
  String get locations_emptyHint =>
      'Lai mēģinātu vēlreiz, atsvaidziniet sarakstu.';

  @override
  String get devices_manage => 'Pārvaldīt manas ierīces';

  @override
  String get settings_personalization => 'Pielāgojiet pēc savas gaumes';

  @override
  String get settings_safety => 'Aizsardzība';

  @override
  String get settings_help => 'Nepieciešama palīdzība?';

  @override
  String get settings_about => 'Par FuzeVPN';

  @override
  String get diagnostics_heading => 'Izprotiet savienojuma problēmu';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Pieejams',
      'pending': 'Tiek sagatavots',
      'revoked': 'Noņemts',
      'expired': 'Beidzies termiņš',
      'other': 'Statuss nav pieejams',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Iestatījums nav saglabāts';

  @override
  String get notice_preferenceSave_message =>
      'Jūsu izvēle pašlaik ir piemērota, taču to neizdevās saglabāt. Mēģiniet vēlreiz, lai tā saglabātos arī pēc lietotnes aizvēršanas.';

  @override
  String get connection_androidDisconnectHint =>
      'Ja Android uztur VPN aktīvu, atvērtajos iestatījumos izslēdziet „Vienmēr ieslēgts VPN“.';

  @override
  String get connection_certificate => 'OpenVPN sertifikāts';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Derīgs līdz $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Derīgums beidzās $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Tiks automātiski atjaunots nākamajā savienošanās reizē.';

  @override
  String get protection_learnMore => 'Uzziniet par Android aizsardzību';

  @override
  String get protection_guideWhy =>
      'Šī aizsardzība neļauj lietotnēm izmantot internetu tieši, ja VPN savienojums tiek pārtraukts. To konfigurē Android iestatījumos.';

  @override
  String get protection_guideAlwaysOnTitle => 'Vienmēr ieslēgts VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android uztur VPN pakalpojumu darbībā un pēc tālruņa restartēšanas var to palaist atkārtoti.';

  @override
  String get protection_guideBlockTitle => 'Bloķēt savienojumus bez VPN';

  @override
  String get protection_guideBlock =>
      'Šis iestatījums neļauj datplūsmai apiet VPN, arī savienojuma pārtraukuma laikā.';

  @override
  String get protection_guideWarning =>
      'Ja šis bloķējums ir ieslēgts, interneta piekļuve paliek izslēgta, kamēr VPN nav savienots.';

  @override
  String get protection_guideStepsTitle => 'Ieslēdziet aizsardzību';

  @override
  String get protection_guideStep1 =>
      'Atveriet Android VPN iestatījumus, izmantojot tālāk redzamo pogu.';

  @override
  String get protection_guideStep2 =>
      'Atveriet opcijas, izmantojot zobrata ikonu blakus FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Ja šīs opcijas ir pieejamas, ieslēdziet „Vienmēr ieslēgts VPN“, pēc tam „Bloķēt savienojumus bez VPN“.';

  @override
  String get protection_guideManufacturers =>
      'Nosaukumi dažādos tālruņos atšķiras. Ja nepieciešams, iestatījumos meklējiet „VPN“, bieži sadaļā „Tīkls un internets“.';

  @override
  String get protection_guideDisableTitle => 'Izslēdziet šo aizsardzību';

  @override
  String get protection_guideDisable =>
      'Tajos pašos iestatījumos izslēdziet „Bloķēt savienojumus bez VPN“, lai atļautu piekļuvi internetam bez VPN. Ja vairs nevēlaties, lai Android to atkārtoti palaiž, izslēdziet arī „Vienmēr ieslēgts VPN“.';

  @override
  String get protection_guideManual =>
      'Šos iestatījumus izvēlaties paši Android sistēmā. FuzeVPN tos nemaina jūsu vietā.';

  @override
  String get locations_changeTitle => 'Mainīt atrašanās vietu?';

  @override
  String locations_changeActive(String name) {
    return 'VPN atvienosies un pēc tam mēģinās izveidot savienojumu ar $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN mēģinās izveidot savienojumu ar $name.';
  }

  @override
  String get locations_confirmChange => 'Mainīt un savienot';

  @override
  String get locations_changeBusy =>
      'Notiek maiņa. Pagaidiet, pirms izvēlaties citu atrašanās vietu.';

  @override
  String get locations_automaticSelection => 'Automātiska izvēle';

  @override
  String get locations_cities => 'Pilsētas';

  @override
  String get locations_servers => 'Serveri';

  @override
  String locations_viewCities(String name) {
    return 'Skatīt pilsētas valstī $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Skatīt serverus: $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count valstis',
      one: '$count valsts',
      zero: '$count valstu',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pilsētas',
      one: '$count pilsēta',
      zero: '$count pilsētu',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serveri',
      one: '$count serveris',
      zero: '$count serveru',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Visas valstis';

  @override
  String get locations_backToCountries => 'Atpakaļ uz valstīm';

  @override
  String locations_backToCities(String name) {
    return 'Atpakaļ uz pilsētām valstī $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Izvēlēties $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Izvēlēties $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nav pieejams neviens saderīgs serveris.';

  @override
  String get externalLink_failed =>
      'Nevar atvērt šo saiti. Varat to nokopēt un atvērt pārlūkprogrammā.';

  @override
  String get externalLink_copy => 'Kopēt saiti';

  @override
  String get externalLink_copied => 'Saite nokopēta';

  @override
  String get externalLink_copyFailed =>
      'Nevar nokopēt saiti. Atlasiet tālāk esošo adresi.';

  @override
  String get settings_deleteAccount => 'Dzēst manu kontu';

  @override
  String get settings_deleteAccountDetail =>
      'Skatīt konta dzēšanas pieprasījuma kārtību';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Izvēlieties VPN abonementu.';

  @override
  String get billing_subscribe => 'Abonēt';

  @override
  String get billing_choosePlan => 'Lai turpinātu, izvēlieties plānu.';

  @override
  String get billing_monthly => 'Ik mēnesi';

  @override
  String get billing_yearly => 'Ik gadu';

  @override
  String get billing_continue => 'Turpināt ar Google Play';

  @override
  String get billing_restore => 'Atjaunot pirkumus';

  @override
  String get billing_manage => 'Pārvaldīt abonementu';

  @override
  String get billing_deleteAccountWarning =>
      'Ja jums ir Google Play abonements, FuzeVPN konta dzēšana neatceļ tā automātisko atjaunošanu. Pārvaldiet vai atceliet atjaunošanu atsevišķi Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Pāriet uz konta dzēšanas pieprasījumu';

  @override
  String get billing_refresh => 'Atsvaidzināt piekļuvi';

  @override
  String get billing_loadingPlans => 'Ielādē plānus…';

  @override
  String get billing_unavailable =>
      'Pašlaik nav pieejams neviens plāns. Mēģiniet vēlāk.';

  @override
  String get billing_comingSoon => 'Abonementi drīz būs pieejami.';

  @override
  String get billing_priceDisclosure =>
      'Cenu nodrošina Google Play. Galīgā summa un piemērojamie nodokļi tiek apstiprināti pirms pirkuma apstiprināšanas.';

  @override
  String get billing_renewalMonthly =>
      'Automātiski atjaunojas katru mēnesi, ja vien to neatceļat. Jebkurā laikā varat atcelt Google Play sadaļā Abonementi.';

  @override
  String get billing_renewalYearly =>
      'Automātiski atjaunojas katru gadu, ja vien to neatceļat. Jebkurā laikā varat atcelt Google Play sadaļā Abonementi.';

  @override
  String get billing_active => 'Jūsu Premium piekļuve ir aktīva';

  @override
  String billing_accessUntil(String date) {
    return 'Piekļuve līdz $date.';
  }

  @override
  String get billing_webManaged =>
      'Jūsu abonements tiek pārvaldīts FuzeVPN vietnē.';

  @override
  String get billing_playManaged =>
      'Jūsu abonements tiek pārvaldīts Google Play.';

  @override
  String get billing_playOnHold =>
      'Jūsu Google Play abonements ir apturēts vai gaida maksājumu. Lai to nokārtotu Google Play, atveriet „Pārvaldīt abonementu“.';

  @override
  String get billing_playReceiptUnlinked =>
      'Šajā Google Play kontā jau ir Fuze Premium abonements, kas šajā FuzeVPN kontā nav aktīvs. Lai to pārskatītu Google Play, atveriet „Pārvaldīt abonementu“.';

  @override
  String get billing_inactive => 'Nav aktīva abonementa.';

  @override
  String get billing_checkingAccess => 'Notiek piekļuves pārbaude…';

  @override
  String get billing_restoring => 'Notiek pirkumu atjaunošana…';

  @override
  String get billing_pending =>
      'Maksājums vēl tiek apstrādāts. Jūsu piekļuve tiks aktivizēta pēc apstiprinājuma.';

  @override
  String get billing_cancelled =>
      'Pirkums atcelts. Neviens jauns abonements netika aktivizēts.';

  @override
  String get billing_verifying => 'Notiek pirkuma pārbaude…';

  @override
  String get billing_success =>
      'Abonements ir aktivizēts. Jūsu Premium piekļuve ir gatava.';

  @override
  String get billing_restored => 'Jūsu pirkumi ir atjaunoti.';

  @override
  String get billing_restoreEmpty =>
      'Šim Google Play kontam nav pirkumu, ko atjaunot.';

  @override
  String get billing_catalogError => 'Nevar ielādēt plānus. Mēģiniet vēlreiz.';

  @override
  String get billing_purchaseError => 'Nevar sākt pirkumu. Mēģiniet vēlreiz.';

  @override
  String get billing_verificationError =>
      'Pirkuma pārbaude īslaicīgi nav pieejama. Lai mēģinātu vēlreiz, atjaunojiet pirkumus.';

  @override
  String get billing_restoreError =>
      'Nevar atjaunot pirkumus. Mēģiniet vēlreiz.';

  @override
  String get billing_managementError =>
      'Nevar atvērt abonementa pārvaldību. Mēģiniet vēlreiz.';

  @override
  String get billing_storeUnavailable =>
      'Google Play šajā ierīcē nav pieejams.';

  @override
  String get welcome_title => 'Jūsu VPN — vienkārši.';

  @override
  String get welcome_description =>
      'Aizsargājiet savienojumu. Saglabājiet kontroli pār savu privātumu.';

  @override
  String get welcome_start => 'Sākt';

  @override
  String get welcome_alreadyPurchased => 'Jau iegādājāties?';

  @override
  String get welcome_noAccountRequired => 'Lai sāktu, konts nav vajadzīgs.';

  @override
  String get guest_accountTitle => 'Konts nav saistīts';

  @override
  String get guest_accountDescription =>
      'Atjaunojiet pirkumus ar to pašu Google Play kontu, lai izmantotu abonementu citā ierīcē.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Jau ir abonements? Pierakstīties';

  @override
  String get guest_claimTitle => 'Izmantojiet FuzeVPN visur';

  @override
  String get guest_claimDescription =>
      'Izveidojiet kontu, lai piekļūtu savam abonementam citās ierīcēs. Šis solis ir neobligāts.';

  @override
  String get guest_skip => 'Varbūt vēlāk';

  @override
  String get guest_activationTitle => 'Fuze Premium ir aktivizēts';

  @override
  String get guest_activationDescription =>
      'Jūsu abonements ir gatavs. Varat izmantot VPN un izveidot kontu, kad vien vēlaties.';

  @override
  String get guest_useVpn => 'Izmantot manu VPN';

  @override
  String get guest_loginRequired =>
      'Šis pirkums jau ir saistīts ar FuzeVPN kontu. Lai piekļūtu abonementam, pierakstieties šajā kontā.';

  @override
  String get guest_signOutWarning =>
      'Abonementu varēsiet atgūt, atjaunojot pirkumus ar to pašu Google Play kontu.';

  @override
  String get guest_profileUnavailable =>
      'Jūsu konts jau ir saistīts. Pierakstieties, lai skatītu un pārvaldītu savu informāciju.';

  @override
  String get billing_acceptance =>
      'Turpinot, jūs piekrītat lietošanas noteikumiem un privātuma politikai.';

  @override
  String get guest_verifyEmailReminder =>
      'Apstipriniet e-pasta adresi, lai nodrošinātu sava konta drošību. Varat turpināt izmantot VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Pakalpojums īslaicīgi nav pieejams. Mēģiniet vēlreiz pēc brīža.';

  @override
  String get guest_restoreError =>
      'Jūsu pirkumus neizdevās atjaunot. Mēģiniet vēlreiz ar to Google Play kontu, ar kuru veicāt pirkumu.';

  @override
  String get guest_claimSuccess =>
      'Jūsu konts ir izveidots. Jūsu abonements un VPN piekļuve ir saglabāti.';

  @override
  String get guest_emailExists =>
      'Šī e-pasta adrese jau tiek izmantota. Izvēlieties citu adresi vai pierakstieties esošajā kontā. Jūsu pirkums joprojām ir pieejams pakalpojumā Google Play.';

  @override
  String get guest_claimError =>
      'Neizdevās izveidot kontu. Varat turpināt izmantot VPN un mēģināt vēlāk.';

  @override
  String get guest_secureStorageError =>
      'Šajā ierīcē neizdevās nodrošināt jūsu sesijas drošību. Mēģiniet vēlreiz.';

  @override
  String get guest_premiumRequired =>
      'Izvēlieties abonementu, lai aktivizētu VPN.';

  @override
  String get welcome_viewPlans => 'Skatīt plānus';

  @override
  String get google_continue => 'Turpināt ar Google';

  @override
  String get google_or => 'vai';

  @override
  String get google_title => 'Jūsu FuzeVPN konts';

  @override
  String get google_settingUp => 'Pabeidziet konta izveidi';

  @override
  String get google_country => 'Dzīvesvietas valsts';

  @override
  String get google_profileDescription =>
      'Izvēlieties savu valsti un pārskatiet abus dokumentus, lai izveidotu FuzeVPN kontu.';

  @override
  String get google_claimDescription =>
      'Saistiet savu viesa kontu ar Google. Jūsu abonements un ierīce paliek saistīti ar šo kontu.';

  @override
  String get google_linkTitle => 'Saistīt Google ar FuzeVPN';

  @override
  String get google_linkDescription =>
      'Apstipriniet piekļuvi savam esošajam FuzeVPN kontam. Šis solis neprasa jūsu Google paroli.';

  @override
  String get google_password => 'FuzeVPN parole';

  @override
  String get google_linkAccount => 'Apstiprināt saistīšanu';

  @override
  String get google_requestEmail => 'Nosūtīt man apstiprinājuma e-pastu';

  @override
  String get google_emailInstructions =>
      'Atveriet FuzeVPN e-pastu un ievadiet apstiprinājuma kodu.';

  @override
  String get google_emailCode => 'E-pasta apstiprinājuma kods';

  @override
  String get google_confirmEmail => 'Apstiprināt kodu';

  @override
  String get google_restart => 'Izvēlēties citu Google kontu';

  @override
  String get google_resume => 'Pārbaudīt šo mēģinājumu';

  @override
  String get google_unavailable =>
      'Pierakstīšanās ar Google nav pieejama. Varat izmantot e-pastu un paroli.';

  @override
  String get google_expired =>
      'Šī mēģinājuma derīguma termiņš ir beidzies. Atceliet to un sāciet vēlreiz.';

  @override
  String get google_conflict =>
      'Šis Google konts jau ir saistīts citur. Jūsu pašreizējais konts un abonements tiek saglabāti.';

  @override
  String get google_error =>
      'Pierakstīšanās ar Google neizdevās. Mēģiniet vēlreiz; jūsu pašreizējā piekļuve tiek saglabāta.';

  @override
  String get google_uncertain =>
      'Rezultātu nevarēja apstiprināt. Pārbaudiet šo mēģinājumu vai atceliet to, pirms sākat vēlreiz.';

  @override
  String get google_cancelFailed =>
      'Atcelšanu nevarēja apstiprināt. Mēģiniet atcelt vēlreiz, pirms pametat šo ekrānu.';

  @override
  String get google_cancelled => 'Pierakstīšanās ar Google ir atcelta.';

  @override
  String get google_selecting => 'Izvēlieties savu Google kontu…';

  @override
  String get google_verifying => 'Notiek konta pārbaude…';

  @override
  String get google_emailUnavailable =>
      'Apstiprinājuma e-pastu neizdevās nosūtīt. Mēģiniet vēlāk.';

  @override
  String get google_emailSent =>
      'Apstiprinājuma e-pasts nosūtīts. Pārbaudiet savu iesūtni.';

  @override
  String get google_rateLimited => 'Lūdzu, pagaidiet, pirms mēģināt vēlreiz.';

  @override
  String get google_busy =>
      'Google nav pieejams, kamēr notiek cita darbība (VPN savienojums, konts vai viesa režīms). Mēģiniet vēlreiz, kad tā būs pabeigta; jūsu pašreizējā piekļuve tiek saglabāta.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN parole ir nepareiza. Jūsu pašreizējais konts tiek saglabāts.';

  @override
  String get google_invalidCode =>
      'Apstiprinājuma kods nav derīgs vai tā derīguma termiņš ir beidzies.';

  @override
  String get google_accountChanged =>
      'Jūsu sesija ir mainījusies. Pirms sākat vēlreiz, atceliet šo mēģinājumu.';

  @override
  String get google_invalidResponse =>
      'Atbildi nevarēja pārbaudīt. Jūsu pašreizējā piekļuve tiek saglabāta.';

  @override
  String get google_invalidRegistration =>
      'Pārbaudiet valsti un abas piekrišanas.';

  @override
  String get google_consentRequired =>
      'Lai turpinātu, izvēlieties savu valsti un piekrītiet abiem dokumentiem.';

  @override
  String get google_challengeRequired =>
      'Nepieciešama papildu drošības pārbaude. Jūsu pašreizējā piekļuve tiek saglabāta.';

  @override
  String get google_challengeUnavailable =>
      'Drošības pārbaude nav pieejama. Mēģiniet vēlāk.';

  @override
  String get google_intentMismatch =>
      'Iepriekšējais Google pierakstīšanās mēģinājums vēl nav pabeigts. Atceliet to, pirms sākat šo darbību.';

  @override
  String get google_challengeBlocked =>
      'Šajā lietotnē nav pieejama nepieciešamā drošības pārbaude. Šo darbību pašlaik nevar pabeigt.';

  @override
  String get google_solveChallenge => 'Veikt drošības pārbaudi';

  @override
  String get google_challengeTitle => 'Drošības pārbaude';

  @override
  String get google_challengeReady =>
      'Pārbaude ir pabeigta. Tagad varat apstiprināt sava konta izveidi.';

  @override
  String get google_challengeExpired =>
      'Pārbaudes derīguma termiņš ir beidzies. Pirms apstiprināšanas veiciet to vēlreiz.';

  @override
  String get google_challengeCancelled =>
      'Pārbaude ir atcelta. Varat to mēģināt vēlreiz.';

  @override
  String get google_challengeFailed =>
      'Drošības pārbaude neizdevās. Mēģiniet vēlreiz.';

  @override
  String get billing_trialTitle => 'Izmēģiniet Fuze Premium bez maksas';

  @override
  String get billing_trialSubtitle => 'Aizsargājiet savienojumu jau šodien.';

  @override
  String get billing_trialWeeks => '2 nedēļu bezmaksas izmēģinājums';

  @override
  String billing_trialDays(String days) {
    return '$days dienu bezmaksas izmēģinājums';
  }

  @override
  String get billing_trialStart => 'Sākt bezmaksas izmēģinājumu';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ja sāksiet šodien, pirmais maksājums paredzams $date.';
  }

  @override
  String get billing_trialTerms =>
      'Automātiski atjaunojas par norādīto cenu. Lai izvairītos no maksas, atceliet to pakalpojumā Google Play, pirms beidzas izmēģinājums.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Pēc tam $price mēnesī';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Pēc tam $price gadā';
  }

  @override
  String get billing_choosePeriod => 'Izvēlieties plānu';

  @override
  String get billing_selectionHint => 'Lai turpinātu, izvēlieties plānu.';

  @override
  String get billing_benefitConnection => 'Šifrēts savienojums';

  @override
  String get billing_benefitPrivacy => 'Privātums tiešsaistē';

  @override
  String get billing_benefitNoAccount => 'Reģistrācija nav obligāta';

  @override
  String get billing_cancellation => 'Atcelšana pakalpojumā Google Play';

  @override
  String get billing_premiumTitle => 'Labāk aizsargāts savienojums.';

  @override
  String get billing_premiumSubtitle => 'Aizsargājiet savienojumu savā tempā.';

  @override
  String get billing_priceMonthly => 'mēnesī';

  @override
  String get billing_priceYearly => 'gadā';

  @override
  String get billing_trialToday => 'Šodien nav jāmaksā';

  @override
  String get billing_trialConfirmation =>
      'Pirms pirkuma apstiprināšanas Google Play apstiprina datumus, galīgo summu un piemērojamos nodokļus.';

  @override
  String get billing_offerChanged =>
      'Šī piedāvājuma nosacījumi ir mainījušies. Atsvaidziniet plānus un izvēlieties vēlreiz.';

  @override
  String get status_waitingNetwork => 'Gaida tīklu';

  @override
  String get status_waitingNetworkDetail =>
      'Tīkls nav pieejams. VPN pārbaudīs savienojumu, kad tīkls atgriezīsies.';

  @override
  String get locations_favoriteLoadFailed =>
      'Nevar ielādēt izlasi. Mēģiniet vēlreiz.';

  @override
  String get locations_favoritesLoading => 'Ielādē izlasi…';
}
