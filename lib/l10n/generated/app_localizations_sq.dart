// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Mbroni lidhjen tuaj';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN përdor shërbimin VPN të Android (VpnService) për të krijuar një tunel të enkriptuar midis kësaj pajisjeje dhe serverëve të FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Ndërsa VPN-ja është aktive, trafiku i internetit i aplikacioneve tuaja, adresat e destinacionit dhe kërkesat DNS kalojnë përmes këtij tuneli për ta drejtuar lidhjen tuaj, edhe kur FuzeVPN është në sfond.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikacioni përdor gjendjen e lidhjes, kohëzgjatjen e saj dhe sasinë e të dhënave të transferuara për të shfaqur lidhjen tuaj VPN. Mund ta ndaloni në çdo kohë.';

  @override
  String get vpnDisclosure_privacy => 'Privatësia';

  @override
  String get vpnDisclosure_accept => 'Prano dhe vazhdo';

  @override
  String get vpnDisclosure_decline => 'Jo tani';

  @override
  String get accountRestoration_title => 'Llogaria nuk disponohet përkohësisht';

  @override
  String get accountRestoration_message =>
      'Sesioni juaj është ruajtur. Provoni përsëri për ta rikthyer llogarinë tuaj; mund ta menaxhoni ende lidhjen VPN këtu.';

  @override
  String get action_retry => 'Provo përsëri';

  @override
  String get session_endingTitle => 'Përfundimi i sesionit';

  @override
  String get session_ending =>
      'Përfundimi i sesionit: ndalimi i VPN-së dhe pastrimi…';

  @override
  String get session_stopFailed =>
      'Ndalimi i VPN-së nuk u konfirmua. Provoni përsëri përpara se të hyni sërish.';

  @override
  String get session_cleanupFailed =>
      'VPN-ja u ndal, por heqja e sesionit nuk u konfirmua. Provoni përsëri pastrimin.';

  @override
  String get session_retryStop => 'Provo përsëri ndalimin';

  @override
  String get session_retryCleanup => 'Provo përsëri pastrimin';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Duke përgatitur FuzeVPN-in në mënyrë të sigurt…';

  @override
  String get nav_connection => 'Lidhja';

  @override
  String get nav_locations => 'Vendndodhjet';

  @override
  String get nav_account => 'Llogaria';

  @override
  String get nav_devices => 'Pajisjet';

  @override
  String get nav_settings => 'Cilësimet';

  @override
  String get action_refresh => 'Përditëso';

  @override
  String get auth_tab_login => 'Hyr';

  @override
  String get auth_tab_register => 'Regjistrohu';

  @override
  String get auth_stepAccount => 'Llogaria';

  @override
  String get auth_stepIdentity => 'Identiteti';

  @override
  String get auth_stepAddress => 'Adresa dhe marrëveshjet';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Hapi $current nga $total';
  }

  @override
  String get auth_tagline => 'VPN-ja juaj, e thjeshtë.';

  @override
  String get auth_keysLocal =>
      'Çelësat tuaj privatë të VPN-së mbeten në këtë pajisje.';

  @override
  String get form_email => 'Adresa e emailit';

  @override
  String get form_password => 'Fjalëkalimi';

  @override
  String get form_showPassword => 'Shfaq fjalëkalimin';

  @override
  String get form_hidePassword => 'Fshih fjalëkalimin';

  @override
  String get form_passwordMin =>
      '8–72 bajt UTF-8. Disa karaktere përdorin më shumë se një bajt.';

  @override
  String get form_firstName => 'Emri';

  @override
  String get form_lastName => 'Mbiemri';

  @override
  String get form_phone => 'Telefoni (+33612345678)';

  @override
  String get form_address => 'Adresa';

  @override
  String get form_address2 => 'Rreshti 2 i adresës (opsional)';

  @override
  String get form_postalCode => 'Kodi postar';

  @override
  String get form_city => 'Qyteti';

  @override
  String get form_country => 'Kodi i vendit (p.sh. FR)';

  @override
  String get action_login => 'Hyr';

  @override
  String get action_createAccount => 'Krijo një llogari';

  @override
  String get action_createMyAccount => 'Krijo llogarinë time';

  @override
  String get action_next => 'Vazhdo';

  @override
  String get action_previous => 'Kthehu';

  @override
  String get action_forgotPassword => 'Keni harruar fjalëkalimin?';

  @override
  String get auth_noAccount => 'Nuk keni ende një llogari?';

  @override
  String get auth_requiredInformation => 'Krijoni llogarinë tuaj në tri hapa.';

  @override
  String get auth_termsPrefix => 'Pranoj ';

  @override
  String get auth_termsLink => 'kushtet e përdorimit';

  @override
  String get auth_privacyPrefix => 'Pranoj ';

  @override
  String get auth_privacyLink => 'politikën e privatësisë';

  @override
  String get auth_consentRequired =>
      'Pëlqimi juaj është i nevojshëm për të krijuar një llogari.';

  @override
  String get validation_required => 'Kjo fushë është e detyrueshme.';

  @override
  String get validation_email => 'Shkruani një adresë emaili të vlefshme.';

  @override
  String get validation_password =>
      'Fjalëkalimi është shumë i shkurtër: të paktën 8 bajt UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Fjalëkalimi është shumë i gjatë: jo më shumë se 72 bajt UTF-8.';

  @override
  String get validation_phone =>
      'Përdorni formatin ndërkombëtar, për shembull +33612345678.';

  @override
  String get validation_country =>
      'Përdorni një kod vendi me dy shkronja, për shembull FR.';

  @override
  String get passwordReset_title => 'Rivendos fjalëkalimin';

  @override
  String get passwordReset_description =>
      'Shkruani adresën e emailit të llogarisë tuaj për të kërkuar një lidhje për rivendosjen e fjalëkalimit.';

  @override
  String get passwordReset_send => 'Dërgo lidhjen';

  @override
  String get connection_title => 'Lidhja juaj';

  @override
  String get connection_subtitle =>
      'Zgjidhni një vendndodhje, pastaj aktivizoni VPN-në.';

  @override
  String get connection_prepare => 'Gati për t’u lidhur?';

  @override
  String get connection_advancedOptions => 'Opsionet e avancuara';

  @override
  String get connection_location => 'Vendndodhja';

  @override
  String get connection_chooseLocation => 'Zgjidh një vendndodhje';

  @override
  String get connection_protocol => 'Protokolli';

  @override
  String get connection_connect => 'Lidhu';

  @override
  String get connection_connecting => 'Duke u lidhur…';

  @override
  String get connection_disconnect => 'Shkëputu';

  @override
  String get connection_disconnecting => 'Duke u shkëputur';

  @override
  String get connection_locationChange => 'Duke ndryshuar vendndodhjen…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nuk disponohet';
  }

  @override
  String get connection_activeLocation => 'Vendndodhja aktive';

  @override
  String get connection_duration => 'Kohëzgjatja';

  @override
  String get connection_received => 'Marrë';

  @override
  String get connection_sent => 'Dërguar';

  @override
  String get connection_lastHandshake => 'Shkëmbimi i fundit i sigurt';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration më parë';
  }

  @override
  String get verification_title => 'Konfirmoni adresën tuaj të emailit';

  @override
  String get verification_message =>
      'Konfirmoni adresën tuaj të emailit për ta përdorur VPN-në në këtë telefon.';

  @override
  String get verification_resend => 'Ridërgo emailin';

  @override
  String get migration_title => 'Ndryshimi i vendndodhjes';

  @override
  String get migration_draining => 'Duke përgatitur ndryshimin e vendndodhjes…';

  @override
  String get migration_activating => 'Duke aktivizuar serverin e ri…';

  @override
  String get migration_ready => 'Vendndodhja u përditësua.';

  @override
  String get migration_blocked =>
      'Ndryshimi i vendndodhjes kërkon ndërhyrje në anën e serverit. Provoni përsëri më vonë ose kontaktoni mbështetjen.';

  @override
  String get migration_progress => 'Progresi i ndryshimit të vendndodhjes';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Vonesa ndërmjet kontrolleve: $seconds s.';
  }

  @override
  String get migration_resume => 'Rifillo ndryshimin e vendndodhjes';

  @override
  String get status_authorizing => 'Kërkohet leje';

  @override
  String get status_authorizingDetail =>
      'Pranoni kërkesën e Android për të lejuar VPN-në.';

  @override
  String get status_preparing => 'Duke u përgatitur';

  @override
  String get status_preparingDetail =>
      'Duke përgatitur lidhjen tuaj të sigurt.';

  @override
  String get status_reconnecting => 'Duke u rilidhur…';

  @override
  String get status_reconnectingDetail =>
      'Lidhja u ndërpre. VPN-ja po përpiqet të rilidhet.';

  @override
  String get status_connecting => 'Duke u lidhur';

  @override
  String get status_connectingDetail => 'Duke u lidhur me serverin VPN…';

  @override
  String get status_connected => 'I lidhur';

  @override
  String get status_connectedDetail => 'Lidhja juaj VPN është aktive.';

  @override
  String get status_disconnecting => 'Duke u shkëputur';

  @override
  String get status_disconnectingDetail => 'Lidhja juaj VPN po ndalet.';

  @override
  String get status_error => 'Lidhja nuk disponohet';

  @override
  String get status_errorDetail =>
      'Lidhja VPN nuk është konfirmuar. Provoni përsëri.';

  @override
  String get status_idle => 'I shkëputur';

  @override
  String get status_idleDetail => 'Lidhni VPN-në për të mbrojtur lidhjen tuaj.';

  @override
  String get trust_note =>
      'Mbyllja e aplikacionit nuk e ndal VPN-në. Për ta ndaluar, përdorni «Shkëputu».';

  @override
  String get locations_none => 'Aktualisht nuk ka vendndodhje të disponueshme.';

  @override
  String get locations_available => 'Zgjidhni vendndodhjen tuaj të radhës.';

  @override
  String get locations_selected => 'Vendndodhja e zgjedhur';

  @override
  String get locations_select => 'Zgjidh këtë vendndodhje';

  @override
  String get locations_lockedTunnel =>
      'Shkëputni VPN-në për të ndryshuar vendndodhjen.';

  @override
  String get locations_lockedMigration =>
      'Prisni që ndryshimi i vendndodhjes të përfundojë.';

  @override
  String get devices_title => 'Pajisjet tuaja';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit pajisje';
  }

  @override
  String get devices_refresh => 'Përditëso pajisjet';

  @override
  String get devices_empty => 'Asnjë pajisje VPN nuk është regjistruar ende.';

  @override
  String get devices_firstConnection =>
      'Telefoni juaj do të shtohet gjatë lidhjes së parë.';

  @override
  String get devices_thisDevice => 'Kjo pajisje';

  @override
  String devices_added(Object date) {
    return 'Shtuar më $date';
  }

  @override
  String get devices_unnamed => 'Pajisje pa emër';

  @override
  String get action_remove => 'Hiq';

  @override
  String get settings_title => 'Cilësimet';

  @override
  String get settings_subtitle =>
      'Preferencat dhe llogaria juaj, të gjitha në një vend.';

  @override
  String get settings_appearance => 'Pamja';

  @override
  String get settings_language => 'Gjuha';

  @override
  String get settings_languageDescription =>
      'Gjuha e zgjedhur vlen edhe për njoftimet e VPN-së.';

  @override
  String get settings_account => 'Llogaria';

  @override
  String get settings_signOut => 'Dil';

  @override
  String get settings_privacy => 'Politika e privatësisë';

  @override
  String get settings_terms => 'Kushtet e përdorimit';

  @override
  String get settings_security => 'Siguria dhe transparenca';

  @override
  String get settings_licenses => 'Licencat e komponentëve';

  @override
  String get settings_licensesDetail => 'Softueri i përdorur në aplikacion';

  @override
  String settings_licensesLegalese(String url) {
    return 'Kodi burimor i aplikacionit dhe i komponentëve të tij nën licencën MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN-ja mbetet aktive kur largoheni nga aplikacioni. Për ta ndaluar, përdorni «Shkëputu» te skeda Lidhja.';

  @override
  String get theme_system => 'Sistemi';

  @override
  String get theme_light => 'E çelët';

  @override
  String get theme_dark => 'E errët';

  @override
  String get language_system => 'Gjuha e telefonit';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Të hiqet kjo pajisje?';

  @override
  String get dialog_removeCurrent =>
      'Ky telefon do të shkëputet nga VPN-ja dhe do të humbasë qasjen. Të dhënat e lidhjes VPN të tij do të hiqen pasi serveri ta konfirmojë.';

  @override
  String dialog_removeOther(Object name) {
    return 'Qasja VPN për «$name» do të revokohet. Kjo nuk mund të zhbëhet.';
  }

  @override
  String get dialog_signOut => 'Të dilni nga llogaria?';

  @override
  String get dialog_signOutMessage =>
      'VPN-ja do të ndalet dhe do t’ju duhet të hyni sërish. Çelësat tuaj të enkriptuar të VPN-së do të mbeten në këtë telefon për lidhjen e radhës.';

  @override
  String get action_cancel => 'Anulo';

  @override
  String get action_close => 'Mbyll';

  @override
  String get action_copy => 'Kopjo';

  @override
  String get action_signOut => 'Dil';

  @override
  String get notice_close => 'Mbyll mesazhin';

  @override
  String get notice_sessionExpired_title => 'Sesioni ka skaduar';

  @override
  String get notice_sessionExpired_message =>
      'Sesioni juaj ka skaduar. Hyni sërish.';

  @override
  String get notice_connectionFailed_title => 'Lidhja dështoi';

  @override
  String get notice_invalidCredentials_message =>
      'Adresa e emailit ose fjalëkalimi është i pasaktë.';

  @override
  String get notice_emailVerification_title => 'Kërkohet konfirmimi i emailit';

  @override
  String get notice_emailVerification_message =>
      'Konfirmoni adresën tuaj të emailit përpara se të shtoni një pajisje VPN.';

  @override
  String get notice_rateLimited_title => 'Shumë përpjekje';

  @override
  String get notice_deviceLimit_title => 'U arrit kufiri i pajisjeve';

  @override
  String get notice_deviceLimit_message =>
      'Hiqni një pajisje ekzistuese përpara se të shtoni një tjetër.';

  @override
  String get notice_identityRenewal_title =>
      'Identiteti VPN duhet të rinovohet';

  @override
  String get notice_identityRenewal_message =>
      'Ky identitet u hoq. Krijoni një identitet të ri lokal.';

  @override
  String get notice_migrationPending_title =>
      'Ndryshimi i vendndodhjes është në vazhdim';

  @override
  String get notice_migrationPending_message =>
      'Një ndryshim i vendndodhjes është tashmë në vazhdim.';

  @override
  String get notice_migrationBlocked_title =>
      'Ndryshimi i vendndodhjes u bllokua';

  @override
  String get notice_migrationBlocked_message =>
      'Ndryshimi i vendndodhjes kërkon ndërhyrje në anën e serverit. Provoni përsëri më vonë ose kontaktoni mbështetjen.';

  @override
  String get notice_targetUnavailable_title =>
      'Serveri nuk disponohet përkohësisht';

  @override
  String get notice_targetUnavailable_message =>
      'Ky server nuk disponohet përkohësisht.';

  @override
  String get notice_networkUnavailable_title =>
      'Lidhja me internetin nuk disponohet';

  @override
  String get notice_networkUnavailable_message =>
      'Kontrolloni lidhjen tuaj dhe provoni përsëri.';

  @override
  String get notice_permissionDenied_title => 'Leja VPN u refuzua';

  @override
  String get notice_permissionDenied_message =>
      'Nisni lidhjen sërish dhe pranoni kërkesën e lejes së Android.';

  @override
  String get notice_wireguardTimeout_title => 'Serveri nuk po përgjigjet';

  @override
  String get notice_wireguardTimeout_message =>
      'Lidhja WireGuard zgjati shumë kohë. Provoni përsëri ose zgjidhni një vendndodhje tjetër.';

  @override
  String get notice_tlsFailed_title => 'Lidhja e sigurt u refuzua';

  @override
  String get notice_tlsFailed_message =>
      'Serveri nuk e pranoi lidhjen OpenVPN. Provoni përsëri. Nëse problemi vazhdon, kryeni një diagnostikim.';

  @override
  String get notice_tunRejected_title => 'Android e refuzoi ndërfaqen VPN';

  @override
  String get notice_tunRejected_message =>
      'Android e refuzoi konfigurimin e rrjetit të kërkuar nga OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN nuk mund të nisej';

  @override
  String get notice_openvpnStart_message =>
      'Motori OpenVPN nuk arriti të niset plotësisht. Provoni përsëri. Nëse problemi vazhdon, kontaktoni mbështetjen.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kodi i diagnostikimit: $code';
  }

  @override
  String get notice_generic_title => 'Lidhja VPN dështoi';

  @override
  String get notice_generic_message =>
      'Ndodhi një gabim. Provoni përsëri më vonë.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Llogaria u krijua',
      'password_reset_sent': 'Kërkesa për rivendosjen e fjalëkalimit u pranua',
      'verification_email_sent': 'Emaili i verifikimit u dërgua',
      'location_migration_pending': 'Ndryshimi i vendndodhjes është në vazhdim',
      'vpn_sign_in_required': 'Kërkohet hyrja',
      'protocol_unavailable_at_location': 'Protokolli nuk disponohet',
      'vpn_permission_denied': 'Leja VPN u refuzua',
      'revoked_identity_device_limit': 'U arrit kufiri i pajisjeve',
      'tunnel_start_unexpected': 'VPN-ja nuk mund të nisej',
      'flutter_disconnect_timeout': 'Shkëputja nuk u konfirmua',
      'flutter_disconnect_unexpected': 'Shkëputja nuk u krye',
      'device_revoked': 'Pajisja u hoq',
      'revoke_unexpected': 'Pajisja nuk mund të hiqej',
      'identity_renewal_unexpected': 'Identiteti nuk mund të rinovohej',
      'openvpn_renewal_unexpected': 'OpenVPN nuk mund të rinovohej',
      'location_migration_blocked': 'Ndryshimi i vendndodhjes u bllokua',
      'location_migration_slow':
          'Ndryshimi i vendndodhjes është ende në vazhdim',
      'location_migration_conflict':
          'Ndryshimi i vendndodhjes duhet të përditësohet',
      'location_migration_verification_failed':
          'Ndryshimi i vendndodhjes nuk u konfirmua',
      'location_migration_device_changed':
          'Pajisja ndryshoi gjatë ndryshimit të vendndodhjes',
      'tunnel_stop_failed': 'Ndryshimi i vendndodhjes nuk disponohet',
      'device_clock_ahead': 'Ora e pajisjes është përpara',
      'other': 'Veprimi dështoi',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Llogaria u krijua, por emaili i verifikimit nuk mund të dërgohej. Përdorni opsionin për ridërgim në aplikacion.',
      'password_reset_sent':
          'Kërkesa juaj u pranua. Nëse një llogari përputhet me këtë adresë, mund të merrni një email. Kontrolloni edhe dosjen e postës së padëshiruar.',
      'verification_email_sent': 'Një email i ri verifikimi sapo u dërgua.',
      'location_migration_pending':
          'Zhvendosja te $target është ende në përgatitje. Mund ta rifilloni pa e krijuar sërish pajisjen.',
      'vpn_sign_in_required':
          'Hyni në llogarinë tuaj përpara se të nisni VPN-në.',
      'protocol_unavailable_at_location':
          'Kjo vendndodhje nuk e ofron protokollin e zgjedhur. Përditësoni vendndodhjet ose zgjidhni një protokoll tjetër.',
      'vpn_permission_denied':
          'Android e refuzoi lejen VPN. Nisni lidhjen sërish dhe pranoni kërkesën e sistemit.',
      'revoked_identity_device_limit':
          'Qasja VPN e kësaj pajisjeje u hoq dhe kufiri i pajisjeve u arrit. Hiqni një pajisje te Llogaria → Menaxho pajisjet e mia.',
      'tunnel_start_unexpected':
          'Një gabim i papritur ndërpreu përgatitjen e tunelit. Shihni kodin e diagnostikimit, pastaj provoni përsëri.',
      'flutter_disconnect_timeout':
          'Android nuk e konfirmoi ndalimin e VPN-së në kohë. Provoni ta ndaloni përsëri.',
      'flutter_disconnect_unexpected':
          'Një gabim i papritur pengoi konfirmimin e ndalimit të tunelit.',
      'device_revoked':
          'Qasja VPN e pajisjes u revokua dhe sekretet e saj lokale u hoqën.',
      'revoke_unexpected':
          'Pajisja nuk mund të hiqej. Përditësoni listën dhe provoni përsëri.',
      'identity_renewal_unexpected':
          'Nuk mund të krijohej identiteti i ri VPN. Përditësoni pajisjet dhe provoni përsëri.',
      'openvpn_renewal_unexpected':
          'Profili OpenVPN nuk mund të rinovohej. Provoni përsëri ose shihni kodin e diagnostikimit.',
      'location_migration_blocked':
          'Serveri nuk mund ta përfundojë këtë ndryshim tani. Pajisja dhe identiteti i saj lokal u ruajtën.',
      'location_migration_slow':
          'Serveri ende po e përgatit zhvendosjen te $target. Rifilloni ndryshimin pas disa çastesh.',
      'location_migration_conflict':
          'Gjendja e pajisjes ndryshoi në server. Përditësoni pajisjet, pastaj rifilloni ndryshimin.',
      'location_migration_verification_failed':
          'Serveri nuk e konfirmoi vendndodhjen e re. Identiteti i mëparshëm lokal u ruajt.',
      'location_migration_device_changed':
          'Pajisja e kthyer nga serveri nuk përputhet më me atë që po ndryshohet. Përditësoni pajisjet përpara se të provoni përsëri.',
      'tunnel_stop_failed':
          'Tuneli i mëparshëm duhet të ndalet plotësisht përpara lidhjes së re.',
      'device_clock_ahead':
          'Ora e kësaj pajisjeje duket se është përpara. Aktivizoni datën dhe orën automatike që të mos dilni nga llogaria.',
      'other':
          'Veprimi nuk mund të përfundohej. Provoni përsëri ose dërgoni kodin e diagnostikimit te mbështetja.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesioni ka skaduar',
      'invalid_credentials': 'Hyrja dështoi',
      'email_verification_required': 'Kërkohet konfirmimi i emailit',
      'verification_email_cooldown': 'Emaili u dërgua tashmë',
      'rate_limited': 'Shumë përpjekje',
      'invalid_registration': 'Informacioni duhet të korrigjohet',
      'email_exists': 'Llogaria ekziston tashmë',
      'invalid_profile': 'Profil i pavlefshëm',
      'invalid_device': 'Pajisje e pavlefshme',
      'invalid_location': 'Vendndodhja nuk disponohet',
      'device_limit': 'U arrit kufiri i pajisjeve',
      'device_exists': 'Identiteti VPN është në përdorim tashmë',
      'device_identity_revoked': 'Identiteti VPN duhet të rinovohet',
      'device_location_locked':
          'Ndryshimi i vendndodhjes duhet të përditësohet',
      'location_migration_pending': 'Ndryshimi i vendndodhjes është në vazhdim',
      'location_migration_blocked': 'Ndryshimi i vendndodhjes u bllokua',
      'target_ca_mismatch': 'Serveri OpenVPN nuk është i përputhshëm',
      'location_migration_conflict':
          'Ndryshimi i vendndodhjes duhet të përditësohet',
      'server_full': 'Serveri është plot',
      'capacity_unavailable': 'Vendndodhja nuk disponohet përkohësisht',
      'target_unavailable': 'Serveri nuk disponohet përkohësisht',
      'not_found': 'Elementi nuk u gjet',
      'invalid_openvpn_csr': 'Identiteti OpenVPN është i pavlefshëm',
      'openvpn_profile_exists': 'Profili OpenVPN ekziston tashmë',
      'openvpn_profile_revoked': 'Profili OpenVPN u revokua',
      'openvpn_operation_pending': 'Veprimi OpenVPN është në vazhdim',
      'openvpn_operation_terminal': 'Veprimi OpenVPN u ndërpre',
      'openvpn_address_unavailable': 'Adresa OpenVPN nuk disponohet',
      'openvpn_profile_conflict': 'Konflikt OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN nuk disponohet',
      'email_delivery_unavailable': 'Emaili nuk disponohet',
      'invalid_token': 'Lidhje e pavlefshme',
      'network_unavailable': 'Lidhja me internetin nuk disponohet',
      'invalid_json': 'Kërkesë e pavlefshme',
      'invalid_api_response': 'Përgjigje e pavlefshme nga serveri',
      'ipv6_unavailable': 'IPv6 nuk disponohet',
      'invalid_ip_families': 'Konfigurimi i rrjetit u refuzua',
      'other': 'Shërbimi nuk disponohet',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesioni juaj ka skaduar. Hyni sërish.',
      'invalid_credentials':
          'Adresa e emailit ose fjalëkalimi është i pasaktë.',
      'email_verification_required':
          'Konfirmoni adresën tuaj të emailit përpara se të shtoni një pajisje VPN.',
      'invalid_registration':
          'Kontrolloni informacionin dhe pëlqimet e kërkuara.',
      'email_exists': 'Një llogari përdor tashmë këtë adresë emaili.',
      'invalid_profile': 'Kontrolloni informacionin e profilit tuaj.',
      'invalid_device':
          'Emri ose identiteti lokal i kësaj pajisjeje është i pavlefshëm.',
      'invalid_location':
          'Përditësoni listën e vendndodhjeve dhe provoni përsëri.',
      'device_limit':
          'Hiqni një pajisje ekzistuese përpara se të shtoni një tjetër.',
      'device_exists':
          'Ky identitet VPN është lidhur tashmë me një llogari tjetër.',
      'device_identity_revoked':
          'Ky identitet u hoq. Duhet të krijoni një identitet të ri lokal.',
      'device_location_locked':
          'Vendndodhja e kësaj pajisjeje sapo ndryshoi. Aplikacioni do ta rifillojë ndryshimin që është në vazhdim.',
      'location_migration_pending':
          'Një ndryshim i vendndodhjes është tashmë në vazhdim.',
      'location_migration_blocked':
          'Ndryshimi i vendndodhjes kërkon ndërhyrje në anën e serverit. Provoni përsëri më vonë ose kontaktoni mbështetjen.',
      'target_ca_mismatch':
          'Ky server nuk është ende i përputhshëm me profilin aktual të OpenVPN.',
      'location_migration_conflict':
          'Përditësoni pajisjet, pastaj provoni përsëri ndryshimin e vendndodhjes.',
      'server_full':
          'Kjo vendndodhje ka arritur kufirin e lidhjeve. Zgjidhni një vendndodhje tjetër ose provoni përsëri më vonë.',
      'capacity_unavailable':
          'Nuk mund të konfirmojmë nëse kjo vendndodhje disponohet tani. Zgjidhni një vendndodhje tjetër ose provoni përsëri më vonë.',
      'target_unavailable': 'Ky server nuk disponohet përkohësisht.',
      'not_found': 'Ky element nuk disponohet më në llogarinë tuaj.',
      'invalid_openvpn_csr':
          'Krijoni një identitet të ri OpenVPN dhe provoni përsëri.',
      'openvpn_profile_exists':
          'Ekziston tashmë një profil OpenVPN për këtë pajisje.',
      'openvpn_profile_revoked': 'Rinovoni profilin OpenVPN për të vazhduar.',
      'openvpn_operation_pending':
          'Ndryshimi po përhapet ende. Provoni përsëri më vonë.',
      'openvpn_operation_terminal':
          'Krijoni një identitet të ri OpenVPN dhe provoni përsëri.',
      'openvpn_address_unavailable':
          'Aktualisht nuk ka asnjë adresë OpenVPN të disponueshme.',
      'openvpn_profile_conflict':
          'Profili ka ndryshuar. Përditësoni pajisjet dhe provoni përsëri.',
      'openvpn_signer_unavailable':
          'Shërbimi OpenVPN nuk disponohet përkohësisht.',
      'email_delivery_unavailable':
          'Emaili nuk mund të dërgohej. Provoni përsëri më vonë.',
      'invalid_token':
          'Kjo lidhje nuk është e vlefshme ose ka skaduar. Kërkoni një të re.',
      'network_unavailable':
          'Kontrolloni lidhjen tuaj me internetin dhe provoni përsëri.',
      'invalid_json': 'Kontrolloni të dhënat e futura dhe provoni përsëri.',
      'invalid_api_response':
          'Serveri ktheu një përgjigje të papritur. Provoni përsëri më vonë.',
      'ipv6_unavailable':
          'Serveri nuk mund ta aktivizojë IPv6 për momentin. Provoni përsëri më vonë.',
      'invalid_ip_families':
          'Konfigurimi i tunelit është i paplotë ose nuk përputhet me adresat e autorizuara. Provoni përsëri nga aplikacioni.',
      'other': 'Ndodhi një gabim i serverit. Provoni përsëri më vonë.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Provoni përsëri pas disa çastesh.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Provoni përsëri pas $seconds sekondash.',
      one: 'Provoni përsëri pas $seconds sekonde.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Provoni përsëri pas $minutes minutash.',
      one: 'Provoni përsëri pas $minutes minute.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Provoni përsëri pas $hours orësh.',
      one: 'Provoni përsëri pas $hours ore.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Rifillimi i VPN-së së sistemit nuk disponohet',
      'system_vpn_resume_corrupt': 'Rifillim i pavlefshëm i VPN-së së sistemit',
      'system_vpn_resume_session_invalid':
          'Sesioni i rifillimit të VPN-së është i pavlefshëm',
      'system_vpn_resume_identity_changed': 'Identiteti i VPN-së ndryshoi',
      'system_vpn_resume_identity_invalid':
          'Identiteti i rifillimit të VPN-së është i pavlefshëm',
      'system_vpn_resume_storage_failed':
          'Ruajtja e rifillimit të VPN-së nuk disponohet',
      'system_vpn_resume_network_timeout': 'Rifillimi i VPN-së nuk ka rrjet',
      'system_vpn_resume_blocked': 'Rifillimi i VPN-së u bllokua',
      'system_vpn_resume_failed': 'Rifillimi i VPN-së dështoi',
      'system_vpn_resume_error_invalid':
          'Gabim i pavlefshëm i rifillimit të VPN-së',
      'wireguard_identity_store_failed': 'Identiteti WireGuard nuk u ruajt',
      'wireguard_identity_unavailable': 'Identiteti WireGuard nuk disponohet',
      'vpn_host_destroyed': 'Komponenti VPN i Android u ndal',
      'vpn_host_unavailable': 'Komponenti VPN i Android nuk disponohet',
      'vpn_permission_required': 'Kërkohet leja VPN',
      'vpn_permission_denied': 'Leja VPN u refuzua',
      'vpn_permission_request_failed': 'Leja nuk mund të kërkohej',
      'wireguard_foreground_service_unavailable':
          'Shërbimi WireGuard nuk disponohet',
      'wireguard_identity_invalid': 'Çelësi lokal WireGuard është i pavlefshëm',
      'wireguard_identity_in_use':
          'Identiteti WireGuard është tashmë në përdorim',
      'wireguard_configuration_invalid':
          'Konfigurimi WireGuard është i pavlefshëm',
      'wireguard_operation_pending': 'Veprimi WireGuard është ende aktiv',
      'wireguard_start_failed': 'Nisja e WireGuard u refuzua',
      'wireguard_stop_timeout': 'Ndalimi i WireGuard nuk u konfirmua',
      'wireguard_handshake_timeout': 'WireGuard nuk u përgjigj',
      'openvpn_connection_timeout': 'OpenVPN nuk u përgjigj',
      'openvpn_core_unavailable': 'Motori OpenVPN nuk disponohet',
      'openvpn_operation_pending': 'Sesioni OpenVPN është ende aktiv',
      'openvpn_stop_timeout': 'Ndalimi i OpenVPN nuk u konfirmua',
      'openvpn_profile_unavailable': 'Profili lokal OpenVPN mungon',
      'openvpn_native_failed': 'Thirrja native e OpenVPN u ndërpre',
      'openvpn_key_generation_failed': 'Nuk u krijua çelësi P-256 i OpenVPN',
      'openvpn_csr_generation_failed': 'Nuk u krijua CSR-i i OpenVPN',
      'openvpn_identity_store_failed': 'Identiteti OpenVPN nuk u ruajt',
      'openvpn_identity_clear_failed': 'Heqja e OpenVPN nuk u krye plotësisht',
      'openvpn_identity_in_use': 'Identiteti OpenVPN është ende në përdorim',
      'openvpn_tls_verification_required': 'Verifikimi TLS i OpenVPN mungon',
      'openvpn_cipher_invalid': 'Shifra e OpenVPN është e pavlefshme',
      'openvpn_profile_rejected': 'Profili OpenVPN u refuzua',
      'openvpn_identity_inconsistent':
          'Identiteti OpenVPN është i papërputhshëm',
      'tls_handshake_failed': 'Negocimi i OpenVPN u refuzua',
      'tls_alert_unknown_ca': 'Certifikata e klientit OpenVPN nuk njihet',
      'tls_alert_bad_certificate': 'Certifikata e klientit OpenVPN u refuzua',
      'tls_alert_unsupported_certificate': 'Certifikatë OpenVPN e pambështetur',
      'tls_client_certificate_required':
          'Kërkohet certifikata e klientit OpenVPN',
      'tls_alert_misc': 'Sinjalizim TLS i OpenVPN',
      'tls_signature_algorithm_rejected': 'Nënshkrim OpenVPN i pambështetur',
      'tls_handshake_rejected': 'Negocimi TLS i OpenVPN u refuzua',
      'tls_version_rejected': 'Versioni TLS i OpenVPN është i papërputhshëm',
      'tls_certificate_expired': 'Certifikata TLS ka skaduar',
      'tls_certificate_revoked': 'Certifikata TLS u revokua',
      'transport_failed': 'Serveri OpenVPN nuk arrihet',
      'tun_configuration_rejected': 'Nuk u krijua ndërfaqja OpenVPN',
      'tun_setup_failed': 'Konfigurimi i TUN të OpenVPN dështoi',
      'tun_interface_create_failed': 'Krijimi i ndërfaqes OpenVPN dështoi',
      'tun_interface_disabled': 'Ndërfaqja OpenVPN u çaktivizua',
      'tun_halted': 'Ndërfaqja OpenVPN u ndërpre',
      'tun_already_established': 'Ndërfaqja OpenVPN është hapur tashmë',
      'tun_addresses_missing': 'Adresa e OpenVPN mungon',
      'tun_routes_missing': 'Rrugët e OpenVPN mungojnë',
      'tun_dns_missing': 'DNS-i i OpenVPN mungon',
      'tun_permission_revoked': 'Leja VPN u revokua',
      'tun_establish_returned_null': 'Android e refuzoi ndërfaqen VPN',
      'openvpn_service_start_failed': 'Shërbimi OpenVPN nuk disponohet',
      'openvpn_operation_timeout': 'Thirrja OpenVPN skadoi',
      'openvpn_start_failed': 'Nisja e OpenVPN u refuzua',
      'openvpn_connection_failed': 'Lidhja OpenVPN u ndërpre',
      'openvpn_core_status_error': 'OpenVPN Core përfundoi me gabim',
      'openvpn_stopped_before_connected': 'OpenVPN u ndal përpara lidhjes',
      'openvpn_auth_failed': 'Autentifikimi i OpenVPN u refuzua',
      'openvpn_client_setup_failed': 'Konfigurimi i klientit OpenVPN dështoi',
      'openvpn_client_halted': 'Klienti OpenVPN u ndërpre',
      'openvpn_client_restart': 'U kërkua rinisja e OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN ka qenë joaktiv shumë kohë',
      'openvpn_session_expired': 'Sesioni OpenVPN ka skaduar',
      'openvpn_credentials_required': 'Autentifikim OpenVPN i pambështetur',
      'openvpn_proxy_failed': 'Transporti ndërmjetës i OpenVPN dështoi',
      'openvpn_compression_failed': 'Kompresimi i OpenVPN u refuzua',
      'openvpn_ntlm_crypto_unavailable':
          'Enkriptimi NTLM i OpenVPN nuk disponohet',
      'openvpn_feature_unsupported': 'Veçori OpenVPN e pambështetur',
      'network_unavailable': 'Lidhja me internetin nuk disponohet',
      'network_lost': 'Rrjeti nuk disponohet',
      'certificate_validation_failed': 'Certifikata e serverit u refuzua',
      'openvpn_certificate_expired': 'Certifikata OpenVPN ka skaduar',
      'tunnel_active_for_another_account':
          'Tuneli i një llogarie tjetër është ende aktiv',
      'tunnel_already_active': 'Tuneli nativ është tashmë aktiv',
      'tunnel_stop_timeout': 'Ndalimi i $protocol nuk u konfirmua',
      'tunnel_disconnected': '$protocol u ndërpre',
      'native_bridge_unavailable': 'Ura Android nuk disponohet',
      'native_operation_failed': 'Veprimi Android u ndërpre',
      'invalid_arguments': 'Parametrat e VPN-së janë të paplotë',
      'invalid_account_id': 'Llogaria VPN është e pavlefshme',
      'invalid_device_id': 'Identifikuesi i pajisjes është i pavlefshëm',
      'storage_key_not_allowed': 'Çelësi i ruajtjes u refuzua',
      'secure_storage_read_failed': 'Leximi i sigurt dështoi',
      'secure_storage_write_failed': 'Shkrimi i sigurt dështoi',
      'key_generation_failed': 'Nuk u gjenerua çelësi WireGuard',
      'csr_generation_failed': 'Nuk u gjenerua CSR-i i OpenVPN',
      'openvpn_recovery_exhausted':
          'Rikuperimi i OpenVPN është përdorur tashmë',
      'openvpn_recovery_failed': 'Rikuperimi i OpenVPN dështoi',
      'openvpn_renewal_required': 'Kërkohet rinovimi i certifikatës OpenVPN',
      'other': 'Gabim nativ i paklasifikuar i VPN-së',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android nuk gjen asnjë sesion VPN që mund të rifillohet. Nisni një lidhje të re në aplikacion.',
      'system_vpn_resume_corrupt':
          'Të dhënat e ruajtura për rifillimin e VPN-së janë të pavlefshme dhe nuk do të përdoren. Nisni një lidhje të re.',
      'system_vpn_resume_session_invalid':
          'Sesioni i ruajtur nuk mund ta rifillojë më VPN-në. Hyni sërish në aplikacion.',
      'system_vpn_resume_identity_changed':
          'Identiteti lokal i VPN-së ndryshoi. Rifillimi u ndal; nisni një lidhje të re.',
      'system_vpn_resume_identity_invalid':
          'Identiteti për rifillim është i pavlefshëm. Nisni një lidhje të re.',
      'system_vpn_resume_storage_failed':
          'Android nuk arriti të lexojë ose të përditësojë të dhënat e enkriptuara të rifillimit. Nisni një lidhje të re.',
      'system_vpn_resume_network_timeout':
          'Android nuk gjeti një rrjet në kohë për të rifilluar VPN-në. Provoni përsëri kur të ketë një rrjet të disponueshëm.',
      'system_vpn_resume_blocked':
          'Rifillimi i VPN-së është bllokuar. Kontrolloni cilësimet e Android, pastaj nisni një lidhje të re.',
      'system_vpn_resume_failed':
          'Rifillimi i VPN-së nga Android dështoi. Nisni një lidhje të re në aplikacion.',
      'system_vpn_resume_error_invalid':
          'Android ktheu një gabim rifillimi të papërdorshëm. Nisni një lidhje të re.',
      'wireguard_identity_store_failed':
          'Android nuk arriti ta ruajë identitetin e enkriptuar WireGuard të kësaj llogarie.',
      'wireguard_identity_unavailable':
          'Për këtë lidhje nuk ka identitet WireGuard të përdorshëm.',
      'vpn_host_destroyed':
          'Komponenti Android që strehon VPN-në u ndal. Nisni një lidhje të re.',
      'vpn_host_unavailable':
          'Android nuk mund ta krijojë komponentin që strehon VPN-në. Provoni përsëri pasi të kontrolloni cilësimet e VPN-së.',
      'openvpn_renewal_required':
          'Certifikata kërkon një veprim në aplikacion përpara lidhjes.',
      'openvpn_recovery_failed':
          'Rikuperimi automatik dështoi. Nisni një lidhje të re në aplikacion.',
      'openvpn_recovery_exhausted':
          'Rikuperimi automatik është përdorur tashmë. Nisni një lidhje të re në aplikacion.',
      'vpn_permission_required':
          'Android kërkon një autorizim të ri VPN përpara nisjes së tunelit.',
      'vpn_permission_denied':
          'Lejoni FuzeVPN në kërkesën e Android për të vazhduar.',
      'vpn_permission_request_failed':
          'Android nuk arriti të hapë ekranin e lejes VPN.',
      'wireguard_foreground_service_unavailable':
          'Android nuk arriti ta mbajë shërbimin WireGuard në plan të parë.',
      'wireguard_identity_invalid':
          'Çelësi i enkriptuar WireGuard i kësaj llogarie nuk mund të lexohet ose është i pavlefshëm.',
      'wireguard_identity_in_use':
          'Një veprim tjetër po e përdor ende çelësin WireGuard të kësaj llogarie.',
      'wireguard_configuration_invalid':
          'Adresa, DNS-i, çelësi i serverit ose rrugët WireGuard të marra janë të pavlefshme.',
      'wireguard_operation_pending':
          'Veprimi i mëparshëm WireGuard nuk e ka liruar ende shërbimin e tij nativ.',
      'wireguard_start_failed':
          'Motori WireGuard refuzoi aktivizimin e konfigurimit.',
      'wireguard_stop_timeout':
          'Shërbimi WireGuard nuk konfirmoi lirimin e ndërfaqes VPN brenda kohës së caktuar.',
      'wireguard_handshake_timeout':
          'Tuneli nuk konfirmoi në kohë shkëmbimin e sigurt me serverin.',
      'openvpn_connection_timeout':
          'OpenVPN nuk e konfirmoi në kohë lidhjen me serverin.',
      'openvpn_core_unavailable':
          'Ky version i aplikacionit nuk përmban një motor OpenVPN të përdorshëm.',
      'openvpn_operation_pending':
          'Motori nativ e mban ende sesionin e mëparshëm OpenVPN dhe refuzon të krijojë një të dytë.',
      'openvpn_stop_timeout':
          'OpenVPN Core nuk konfirmoi që sesioni i tij nativ u ndal dhe u shkatërrua brenda kohës së caktuar.',
      'openvpn_profile_unavailable':
          'Për këtë lidhje nuk mund të lexohet asnjë profil OpenVPN i vlefshëm.',
      'openvpn_native_failed':
          'Një gabim i aplikacionit ndërpreu OpenVPN. Provoni të lidheni përsëri. Nëse problemi vazhdon, kryeni një diagnostikim.',
      'openvpn_key_generation_failed':
          'Android Keystore nuk arriti të krijojë ose të lexojë çelësin privat P-256 që nuk mund të eksportohet.',
      'openvpn_csr_generation_failed':
          'Çelësi i Android Keystore nuk arriti ta nënshkruajë kërkesën për certifikatë OpenVPN.',
      'openvpn_identity_store_failed':
          'Certifikata ose profili OpenVPN nuk u ruajt dot në ruajtjen e enkriptuar.',
      'openvpn_identity_clear_failed':
          'Android nuk arriti të heqë tërë identitetin lokal OpenVPN të kësaj llogarie.',
      'openvpn_identity_in_use':
          'Një sesion nativ OpenVPN po e përdor ende çelësin ose certifikatën e kësaj pajisjeje.',
      'openvpn_tls_verification_required':
          'Profili nuk kërkon shprehimisht verifikimin e certifikatës së serverit.',
      'openvpn_cipher_invalid':
          'Serveri ofroi një algoritëm enkriptimi që nuk është në listën e lejuar.',
      'openvpn_profile_rejected':
          'Profili i marrë nga serveri është i papërputhshëm. Rikrijoni këtë pajisje dhe provoni përsëri.',
      'openvpn_identity_inconsistent':
          'Certifikata nuk përputhet me identitetin e sigurt të këtij telefoni. Asnjë profil lokal nuk u zëvendësua.',
      'tls_handshake_failed':
          'Serveri refuzoi negocimin TLS. Rikrijoni profilin nëse problemi vazhdon.',
      'tls_alert_unknown_ca':
          'Serveri nuk e njeh autoritetin e certifikatës së kësaj pajisjeje. Duhet të kontrollohet serveri OpenVPN.',
      'tls_alert_bad_certificate':
          'Serveri e refuzoi certifikatën e kësaj pajisjeje. Rikrijoni pajisjen përpara se të provoni përsëri.',
      'tls_alert_unsupported_certificate':
          'Serveri nuk e mbështet llojin e certifikatës së sigurt që përdor Android.',
      'tls_client_certificate_required':
          'Serveri kërkon një certifikatë klienti, por OpenVPN Core nuk arriti të paraqesë një të tillë.',
      'tls_alert_misc':
          'Serveri ktheu një sinjalizim TLS që nuk bën pjesë te kategoritë e certifikatës ose të versionit.',
      'tls_signature_algorithm_rejected':
          'Serveri e refuzoi algoritmin ECDSA P-256 të çelësit të Android Keystore.',
      'tls_handshake_rejected': 'Serveri ndërpreu negocimin TLS para lidhjes.',
      'tls_version_rejected':
          'Klienti dhe serveri nuk gjetën një version të përbashkët TLS.',
      'tls_certificate_expired':
          'Certifikata e paraqitur gjatë lidhjes ka skaduar.',
      'tls_certificate_revoked':
          'Certifikata e paraqitur gjatë lidhjes është revokuar.',
      'transport_failed':
          'Serveri OpenVPN nuk përgjigjet në rrjetin aktual. Provoni përsëri pas pak.',
      'tun_configuration_rejected':
          'Android e refuzoi konfigurimin e rrjetit të kërkuar nga OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core e refuzoi planin e rrjetit përpara krijimit të ndërfaqes Android.',
      'tun_interface_create_failed':
          'OpenVPN Core nuk arriti të marrë ndërfaqen TUN nga VpnService i Android.',
      'tun_interface_disabled':
          'Android ose OpenVPN Core e çaktivizoi ndërfaqen TUN gjatë lidhjes.',
      'tun_halted':
          'OpenVPN Core mori një kërkesë për ndalimin e ndërfaqes TUN.',
      'tun_already_established':
          'OpenVPN kërkoi një ndërfaqe të dytë në të njëjtën lidhje. Tuneli u ndal për siguri.',
      'tun_addresses_missing':
          'Serveri nuk ofroi një adresë tuneli të përdorshme.',
      'tun_routes_missing': 'Serveri nuk ofroi rrugë tuneli të përdorshme.',
      'tun_dns_missing': 'Serveri nuk ofroi një server DNS të përdorshëm.',
      'tun_permission_revoked': 'Android e revokoi lejen VPN gjatë lidhjes.',
      'tun_establish_returned_null':
          'Android nuk e krijoi ndërfaqen, zakonisht sepse një VPN tjetër është ende aktiv.',
      'openvpn_service_start_failed':
          'Android nuk arriti ta nisë shërbimin OpenVPN në plan të parë.',
      'openvpn_operation_timeout':
          'Një thirrje JNI te OpenVPN Core e kaloi kohëzgjatjen maksimale.',
      'openvpn_start_failed':
          'Shërbimi Android është gati, por OpenVPN Core nuk pranoi nisjen e profilit.',
      'openvpn_connection_failed':
          'OpenVPN Core u ndal përpara se të emetonte ngjarjen CONNECTED.',
      'openvpn_core_status_error':
          'Cikli nativ i OpenVPN përfundoi me gabim, pa një ngjarje përfundimtare më specifike.',
      'openvpn_stopped_before_connected':
          'Cikli nativ i OpenVPN u ndal përpara CONNECTED, pa një gabim të qartë të Core.',
      'openvpn_auth_failed':
          'Serveri OpenVPN e refuzoi autentifikimin e profilit.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nuk arriti ta inicializojë klientin para lidhjes me rrjetin.',
      'openvpn_client_halted':
          'OpenVPN Core mori një ndalim përfundimtar të klientit.',
      'openvpn_client_restart':
          'OpenVPN Core kërkoi rinisjen e sesionit të transportit.',
      'openvpn_inactive_timeout':
          'OpenVPN Core e mbylli sesionin pas skadimit të kohës së joaktivitetit.',
      'openvpn_session_expired':
          'Serveri njoftoi se sesioni OpenVPN ka skaduar.',
      'openvpn_credentials_required':
          'Serveri ose një proxy kërkon kredenciale interaktive që nuk janë pjesë e këtij profili certifikate.',
      'openvpn_proxy_failed':
          'OpenVPN Core njoftoi një dështim në proxy ose rele të konfiguruar.',
      'openvpn_compression_failed':
          'OpenVPN Core e refuzoi modalitetin e kompresimit të njoftuar nga profili ose serveri.',
      'openvpn_ntlm_crypto_unavailable':
          'Profili kërkon enkriptim NTLM që nuk disponohet në këtë version.',
      'openvpn_feature_unsupported':
          'Profili ose serveri kërkon një veçori që mungon në këtë klient Android.',
      'network_unavailable': 'Nuk ka asnjë rrjet fizik të përdorshëm.',
      'network_lost': 'Tuneli u ndal pasi humbi rrjeti.',
      'certificate_validation_failed':
          'Identiteti i serverit OpenVPN nuk mund të verifikohej.',
      'openvpn_certificate_expired':
          'Rinovoni profilin OpenVPN përpara se të lidheni përsëri.',
      'tunnel_active_for_another_account':
          'Një tunel që i përket një llogarie tjetër duhet të ndalet përpara kësaj lidhjeje.',
      'tunnel_already_active':
          'Android raporton se një sesion i mëparshëm VPN po e përdor ende ndërfaqen.',
      'tunnel_stop_timeout':
          'Motori $protocol nuk konfirmoi lirimin e ndërfaqes VPN brenda kohës së caktuar.',
      'tunnel_disconnected':
          'Motori nativ raportoi se tuneli u mbyll papritur pas nisjes.',
      'native_bridge_unavailable':
          'Aplikacioni nuk ka qasje te shërbimi VPN i Android. Mbyllni dhe rihapni aplikacionin, pastaj provoni përsëri.',
      'native_operation_failed':
          'Një gabim i aplikacionit ndërpreu veprimin VPN. Provoni përsëri. Nëse problemi vazhdon, kryeni një diagnostikim.',
      'invalid_arguments':
          'Informacioni i nevojshëm për këtë veprim VPN është i paplotë. Provoni përsëri. Nëse problemi vazhdon, kryeni një diagnostikim.',
      'invalid_account_id':
          'Veprimi nativ nuk është i lidhur me një identifikues të vlefshëm llogarie.',
      'invalid_device_id':
          'Identifikuesi i pajisjes i dërguar te motori nativ mungon ose është i pavlefshëm.',
      'storage_key_not_allowed':
          'Ura Android bllokoi një çelës jashtë listës së lejuar të ruajtjes.',
      'secure_storage_read_failed':
          'Android Keystore nuk arriti të dekriptojë të dhënat lokale të kësaj llogarie.',
      'secure_storage_write_failed':
          'Android Keystore nuk arriti të enkriptojë ose të ruajë të dhënat lokale.',
      'key_generation_failed':
          'Android nuk arriti të krijojë ose të lexojë çelësin WireGuard në ruajtjen e sigurt.',
      'csr_generation_failed':
          'Android Keystore nuk arriti të krijojë ose të nënshkruajë CSR-në P-256 të OpenVPN.',
      'other':
          'Një degë native e padokumentuar dështoi. Dërgoni kodin e diagnostikimit të shfaqur më poshtë te mbështetja.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Kërkesa për leje është tashmë e hapur';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Kërkesa për lejen VPN në Android është tashmë e shfaqur. Përfundojeni përpara se të provoni përsëri.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Kërkesa për lejen VPN u ndërpre';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Ekrani i lejes VPN u mbyll përpara se aplikacioni të merrte një përgjigje.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Lidhja OpenVPN nuk u konfirmua';

  @override
  String get notice_openvpnProofMissing_message =>
      'Lidhja OpenVPN nuk mund të konfirmohej. U ndal për siguri. Provoni përsëri.';

  @override
  String get openvpnCleanup_title => 'Profili OpenVPN u revokua';

  @override
  String get openvpnCleanup_working =>
      'Duke ndaluar dhe duke hequr profilin OpenVPN të revokuar…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Ndalimi i OpenVPN nuk është konfirmuar. Provoni përsëri përpara se të krijoni një profil të ri.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Profili OpenVPN i revokuar nuk mund të hiqej plotësisht. Provoni përsëri pastrimin.';

  @override
  String get openvpnCleanup_complete =>
      'Profili OpenVPN i revokuar u hoq. Prekni «Lidhu» për të krijuar një të ri.';

  @override
  String get network_title => 'Konfigurimi i rrjetit';

  @override
  String get network_ipv4Fallback =>
      'IPv6 nuk disponohet përkohësisht. Përgatitja vazhdon me IPv4.';

  @override
  String get network_rejectedTitle => 'Konfigurimi i rrjetit u refuzua';

  @override
  String get network_rejectedMessage =>
      'Konfigurimi i tunelit është i paplotë ose nuk përputhet me adresat e autorizuara. Provoni përsëri nga aplikacioni.';

  @override
  String get network_unreadableTitle => 'Konfigurimi lokal nuk mund të lexohet';

  @override
  String get network_unreadableMessage =>
      'Konfigurimi i ruajtur i rrjetit OpenVPN nuk mund të përdoret. Lidhuni sërish nga aplikacioni për ta përditësuar.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Mbrojtja e rrjetit';

  @override
  String get protection_subtitle =>
      'Bllokoni hyrjen direkte në internet nëse VPN-ja shkëputet.';

  @override
  String get protection_active => 'Mbrojtja e sistemit është aktive';

  @override
  String get protection_alwaysOnOnly =>
      'VPN gjithmonë aktive është aktivizuar; aktivizoni bllokimin jashtë VPN-së';

  @override
  String get protection_inactive => 'Mbrojtja e sistemit nuk është aktive';

  @override
  String get protection_unknown => 'Kontrolloni mbrojtjen e sistemit';

  @override
  String get protection_openSettings => 'Hap cilësimet e Android';

  @override
  String get protection_dialogTitle => 'Konfiguroni mbrojtjen e rrjetit';

  @override
  String get protection_dialogMessage =>
      'Android menaxhon VPN-në gjithmonë aktive dhe bllokimin e lidhjeve jashtë VPN-së. Kontrolloni që FuzeVPN të jetë zgjedhur dhe aktivizoni bllokimin te cilësimet e sistemit.';

  @override
  String get protection_dialogOpen => 'Hap cilësimet';

  @override
  String get session_systemProtectionNote =>
      'Nëse Android vazhdon të bllokojë trafikun jashtë VPN-së, hapni cilësimet e sistemit për ta kontrolluar ose ndryshuar këtë mbrojtje.';

  @override
  String get diagnostics_title => 'Diagnostikimi';

  @override
  String get diagnostics_settingsTitle => 'Diagnostikimi i aplikacionit';

  @override
  String get diagnostics_automaticTitle => 'Dërgo gabimet e rëndësishme';

  @override
  String get diagnostics_automaticDescription =>
      'Ndani një raport të shkurtër teknik kur ndodh një gabim i rëndësishëm.';

  @override
  String get diagnostics_privacy =>
      'Raportet e dërguara lidhen me llogarinë në të cilën keni hyrë dhe mbahen për 30 ditë. Ato nuk përmbajnë historikun e shfletimit, fjalëkalime ose çelësa VPN.';

  @override
  String get diagnostics_manualOpen => 'Nis diagnostikimin';

  @override
  String get diagnostics_localDescription =>
      'Krijoni një raport për gjendjen e aplikacionit dhe të VPN-së. Lidhja juaj mbetet e pandryshuar.';

  @override
  String get diagnostics_sendReport => 'Dërgo raportin';

  @override
  String get diagnostics_sendHint =>
      'Lëreni këtë kutizë të pazgjedhur për ta mbajtur raportin në këtë pajisje.';

  @override
  String get diagnostics_signedOut =>
      'Hyni në llogarinë tuaj për të dërguar një raport.';

  @override
  String get diagnostics_localLifetime =>
      'Ruajeni këtë raport në telefon për ta mbajtur edhe pasi mbyllni aplikacionin.';

  @override
  String get diagnostics_run => 'Nis diagnostikimin';

  @override
  String get diagnostics_rerun => 'Nis përsëri diagnostikimin';

  @override
  String get diagnostics_running => 'Duke kontrolluar…';

  @override
  String get diagnostics_sending => 'Duke dërguar raportin…';

  @override
  String get diagnostics_prepared => 'Raporti është gati në këtë pajisje';

  @override
  String get diagnostics_queued => 'Raporti pret të dërgohet';

  @override
  String get diagnostics_sent => 'Raporti u pranua';

  @override
  String get diagnostics_failed =>
      'Dërgimi dështoi. Raporti juaj lokal është ende i disponueshëm.';

  @override
  String get diagnostics_preparationFailed =>
      'Raporti i diagnostikimit nuk mund të përgatitej. Provoni përsëri.';

  @override
  String get diagnostics_authenticationRequired =>
      'Hyni sërish për të dërguar raportin.';

  @override
  String get diagnostics_retry => 'Provo përsëri dërgimin';

  @override
  String get diagnostics_export => 'Ruaj raportin';

  @override
  String get diagnostics_exportFailed =>
      'Eksportimi dështoi. Provoni përsëri nga raporti lokal.';

  @override
  String get diagnostics_preferenceFailed =>
      'Ky cilësim nuk mund të ruhej. Provoni përsëri.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referenca: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'U pranua më $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Mbahet deri më $date';
  }

  @override
  String get diagnostics_duplicate => 'Ky raport ishte pranuar tashmë.';

  @override
  String get diagnostics_preview => 'Pamja paraprake e raportit';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngjarje teknike janë bashkangjitur',
      one: '1 ngjarje teknike është bashkangjitur',
      zero: 'Nuk është bashkangjitur asnjë ngjarje teknike',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Detajet teknike';

  @override
  String get diagnostics_empty =>
      'Asnjë raport diagnostikimi nuk është përgatitur ende.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Gjendja e tunelit',
      'handshake': 'Konfirmimi i lidhjes',
      'certificate': 'Certifikata VPN',
      'kill_switch': 'Mbrojtja e Android',
      'connectivity': 'Rrjeti i disponueshëm',
      'api_reachability': 'Qasja te shërbimi',
      'secure_storage': 'Ruajtja e sigurt',
      'other': 'Kontroll lokal',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Kontrolluar',
      'failed': 'Kërkon vëmendje',
      'skipped': 'Nuk u testua — pa provë aktive',
      'unknown': 'Informacioni nuk disponohet',
      'other': 'Informacioni nuk disponohet',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Mirë se vini në FuzeVPN';

  @override
  String get connection_changeLocation => 'Ndrysho vendndodhjen';

  @override
  String get connection_details => 'Detajet e lidhjes';

  @override
  String get locations_searchLabel => 'Kërko një qytet ose vend';

  @override
  String get locations_clearSearch => 'Pastro kërkimin';

  @override
  String get locations_filterAll => 'Të gjitha';

  @override
  String get locations_filterFavorites => 'Të preferuarat';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vendndodhje',
      one: '$count vendndodhje',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nuk u gjet asnjë vendndodhje';

  @override
  String get locations_noResultsHint => 'Provoni një qytet ose vend tjetër.';

  @override
  String get locations_noFavorites => 'Të preferuarat tuaja, gjithmonë pranë';

  @override
  String get locations_noFavoritesHint =>
      'Prekni yllin pranë një vendndodhjeje për ta ruajtur këtu.';

  @override
  String get locations_showAll => 'Shiko të gjitha vendndodhjet';

  @override
  String locations_addFavorite(String name) {
    return 'Shto $name te të preferuarat';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Hiq $name nga të preferuarat';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Vendndodhja e preferuar nuk u ruajt. Provoni përsëri.';

  @override
  String get locations_emptyTitle => 'Nuk ka vendndodhje të disponueshme';

  @override
  String get locations_emptyHint =>
      'Përditësoni listën për të provuar përsëri.';

  @override
  String get devices_manage => 'Menaxho pajisjet e mia';

  @override
  String get settings_personalization => 'Sipas shijes suaj';

  @override
  String get settings_safety => 'Mbrojtja';

  @override
  String get settings_help => 'Keni nevojë për ndihmë?';

  @override
  String get settings_about => 'Rreth FuzeVPN';

  @override
  String get diagnostics_heading => 'Kuptoni një problem lidhjeje';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Në dispozicion',
      'pending': 'Duke u përgatitur',
      'revoked': 'Hequr',
      'expired': 'Skaduar',
      'other': 'Gjendja nuk disponohet',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preferenca nuk u ruajt';

  @override
  String get notice_preferenceSave_message =>
      'Zgjedhja juaj është aplikuar për momentin, por nuk mund të ruhej. Provoni përsëri që të mbahet edhe pasi të mbyllet aplikacioni.';

  @override
  String get connection_androidDisconnectHint =>
      'Nëse Android e mban VPN-në aktive, çaktivizoni «VPN gjithmonë aktive» te cilësimet që hapen.';

  @override
  String get protection_learnMore => 'Mëso më shumë për mbrojtjen e Android';

  @override
  String get protection_guideWhy =>
      'Kjo mbrojtje i pengon aplikacionet të përdorin internetin drejtpërdrejt nëse VPN-ja shkëputet. Ajo konfigurohet në Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN gjithmonë aktive';

  @override
  String get protection_guideAlwaysOn =>
      'Android e mban shërbimin VPN aktiv dhe mund ta rinisë pasi të riniset telefoni.';

  @override
  String get protection_guideBlockTitle => 'Blloko lidhjet pa VPN';

  @override
  String get protection_guideBlock =>
      'Ky cilësim parandalon që trafiku të anashkalojë VPN-në, edhe kur lidhja ndërpritet.';

  @override
  String get protection_guideWarning =>
      'Me këtë bllokim të aktivizuar, qasja në internet mbetet e bllokuar derisa të lidhet VPN-ja.';

  @override
  String get protection_guideStepsTitle => 'Aktivizoni mbrojtjen';

  @override
  String get protection_guideStep1 =>
      'Hapni cilësimet VPN të Android me butonin më poshtë.';

  @override
  String get protection_guideStep2 =>
      'Hapni opsionet me ikonën e ingranazhit pranë FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Aktivizoni «VPN gjithmonë aktive», pastaj «Blloko lidhjet pa VPN», nëse këto opsione janë të disponueshme.';

  @override
  String get protection_guideManufacturers =>
      'Emrat ndryshojnë sipas telefonit. Nëse është e nevojshme, kërkoni «VPN» te Cilësimet, shpesh nën «Rrjeti dhe interneti».';

  @override
  String get protection_guideDisableTitle => 'Çaktivizoni këtë mbrojtje';

  @override
  String get protection_guideDisable =>
      'Në të njëjtat cilësime, çaktivizoni bllokimin e lidhjeve pa VPN për të lejuar qasjen në internet pa VPN. Çaktivizoni gjithashtu «VPN gjithmonë aktive» nëse nuk dëshironi që Android ta rinisë më.';

  @override
  String get protection_guideManual =>
      'Ju zgjidhni këto cilësime në Android. FuzeVPN nuk i ndryshon ato për ju.';

  @override
  String get locations_changeTitle => 'Të ndryshohet vendndodhja?';

  @override
  String locations_changeActive(String name) {
    return 'VPN-ja do të shkëputet, pastaj do të përpiqet të lidhet me $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN-ja do të përpiqet të lidhet me $name.';
  }

  @override
  String get locations_confirmChange => 'Ndrysho dhe lidhu';

  @override
  String get locations_changeBusy =>
      'Një ndryshim është në vazhdim. Prisni përpara se të zgjidhni një vendndodhje tjetër.';

  @override
  String get locations_automaticSelection => 'Zgjedhje automatike';

  @override
  String get locations_cities => 'Qytetet';

  @override
  String get locations_servers => 'Serverët';

  @override
  String locations_viewCities(String name) {
    return 'Shiko qytetet në $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Shiko serverët në $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vende',
      one: '$count vend',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count qytete',
      one: '$count qytet',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serverë',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Të gjitha vendet';

  @override
  String get locations_backToCountries => 'Kthehu te vendet';

  @override
  String locations_backToCities(String name) {
    return 'Kthehu te qytetet në $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Zgjidh $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Zgjidh $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nuk ka asnjë server të përputhshëm në dispozicion.';

  @override
  String get externalLink_failed =>
      'Kjo lidhje nuk mund të hapet. Mund ta kopjoni dhe ta hapni në shfletuesin tuaj.';

  @override
  String get externalLink_copy => 'Kopjo lidhjen';

  @override
  String get externalLink_copied => 'Lidhja u kopjua';

  @override
  String get externalLink_copyFailed =>
      'Lidhja nuk mund të kopjohet. Zgjidhni adresën më poshtë.';

  @override
  String get settings_deleteAccount => 'Fshi llogarinë time';

  @override
  String get settings_deleteAccountDetail =>
      'Shihni procedurën e kërkesës për fshirjen e llogarisë';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Zgjidhni abonimin tuaj VPN.';

  @override
  String get billing_subscribe => 'Abonohu';

  @override
  String get billing_choosePlan => 'Zgjidhni një plan për të vazhduar.';

  @override
  String get billing_monthly => 'Mujore';

  @override
  String get billing_yearly => 'Vjetore';

  @override
  String get billing_continue => 'Vazhdo me Google Play';

  @override
  String get billing_restore => 'Rikthe blerjet';

  @override
  String get billing_manage => 'Menaxho abonimin';

  @override
  String get billing_deleteAccountWarning =>
      'Nëse keni një abonim në Google Play, fshirja e llogarisë tuaj FuzeVPN nuk e anulon rinovimin e tij. Menaxhoni ose anuloni rinovimin veçmas në Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Vazhdo te kërkesa për fshirjen e llogarisë';

  @override
  String get billing_refresh => 'Përditëso qasjen';

  @override
  String get billing_loadingPlans => 'Duke ngarkuar planet…';

  @override
  String get billing_unavailable =>
      'Për momentin nuk ka plane në dispozicion. Provoni përsëri më vonë.';

  @override
  String get billing_comingSoon => 'Abonimet vijnë së shpejti.';

  @override
  String get billing_priceDisclosure =>
      'Çmimi jepet nga Google Play. Shuma përfundimtare dhe taksat e zbatueshme konfirmohen përpara se ta konfirmoni.';

  @override
  String get billing_renewalMonthly =>
      'Rinovohet automatikisht çdo muaj, përveç nëse anulohet. Mund ta anuloni në çdo kohë te abonimet e Google Play.';

  @override
  String get billing_renewalYearly =>
      'Rinovohet automatikisht çdo vit, përveç nëse anulohet. Mund ta anuloni në çdo kohë te abonimet e Google Play.';

  @override
  String get billing_active => 'Qasja juaj Premium është aktive';

  @override
  String billing_accessUntil(String date) {
    return 'Qasja deri më $date.';
  }

  @override
  String get billing_webManaged =>
      'Abonimi juaj menaxhohet në faqen e internetit të FuzeVPN.';

  @override
  String get billing_playManaged => 'Abonimi juaj menaxhohet nga Google Play.';

  @override
  String get billing_playOnHold =>
      'Abonimi juaj në Google Play është pezulluar ose në pritje të pagesës. Hapni «Menaxho abonimin» për ta rregulluar në Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Kjo llogari Google Play ka tashmë një abonim Fuze Premium që nuk është aktiv për këtë llogari FuzeVPN. Hapni «Menaxho abonimin» për ta parë në Google Play.';

  @override
  String get billing_inactive => 'Nuk ka abonim aktiv.';

  @override
  String get billing_checkingAccess => 'Duke kontrolluar qasjen tuaj…';

  @override
  String get billing_restoring => 'Duke rikthyer blerjet…';

  @override
  String get billing_pending =>
      'Pagesa është në pritje. Qasja juaj do të aktivizohet pas konfirmimit.';

  @override
  String get billing_cancelled =>
      'Blerja u anulua. Nuk u aktivizua asnjë abonim i ri.';

  @override
  String get billing_verifying => 'Duke verifikuar blerjen…';

  @override
  String get billing_success =>
      'Abonimi u aktivizua. Qasja juaj Premium është gati.';

  @override
  String get billing_restored => 'Blerjet tuaja u rikthyen.';

  @override
  String get billing_restoreEmpty =>
      'Nuk ka blerje për t’u rikthyer në këtë llogari Google Play.';

  @override
  String get billing_catalogError =>
      'Nuk mund të ngarkohen planet. Provoni përsëri.';

  @override
  String get billing_purchaseError =>
      'Nuk mund të nisë blerja. Provoni përsëri.';

  @override
  String get billing_verificationError =>
      'Verifikimi i blerjes nuk disponohet përkohësisht. Riktheni blerjet për të provuar përsëri.';

  @override
  String get billing_restoreError =>
      'Nuk mund të rikthehen blerjet. Provoni përsëri.';

  @override
  String get billing_managementError =>
      'Nuk mund të hapet menaxhimi i abonimit. Provoni përsëri.';

  @override
  String get billing_storeUnavailable =>
      'Google Play nuk disponohet në këtë pajisje.';

  @override
  String get welcome_title => 'VPN-ja juaj, e thjeshtë.';

  @override
  String get welcome_description =>
      'Mbroni lidhjen tuaj. Mbetuni në kontroll të privatësisë suaj.';

  @override
  String get welcome_start => 'Fillo';

  @override
  String get welcome_alreadyPurchased => 'E keni blerë tashmë?';

  @override
  String get welcome_noAccountRequired =>
      'Nuk nevojitet llogari për të filluar.';

  @override
  String get guest_accountTitle => 'Llogaria nuk është e lidhur';

  @override
  String get guest_accountDescription =>
      'Riktheni blerjet me të njëjtën llogari Google Play për të përdorur abonimin tuaj në një pajisje tjetër.';

  @override
  String get guest_existingSubscriberSignIn => 'Jeni abonuar tashmë? Hyni';

  @override
  String get guest_claimTitle => 'Përdoreni FuzeVPN kudo';

  @override
  String get guest_claimDescription =>
      'Krijoni një llogari për të përdorur abonimin tuaj në pajisjet e tjera. Ky hap është opsional.';

  @override
  String get guest_skip => 'Ndoshta më vonë';

  @override
  String get guest_activationTitle => 'Fuze Premium është aktiv';

  @override
  String get guest_activationDescription =>
      'Abonimi juaj është gati. Përdorni VPN-në tuaj dhe krijoni llogarinë kur të doni.';

  @override
  String get guest_useVpn => 'Përdor VPN-në time';

  @override
  String get guest_loginRequired =>
      'Kjo blerje është tashmë e lidhur me një llogari FuzeVPN. Hyni në atë llogari për të përdorur abonimin tuaj.';

  @override
  String get guest_signOutWarning =>
      'Mund ta rikuperoni abonimin tuaj duke rikthyer blerjet me të njëjtën llogari Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Llogaria juaj është tashmë e lidhur. Hyni për të parë dhe menaxhuar të dhënat tuaja.';

  @override
  String get billing_acceptance =>
      'Duke vazhduar, pranoni Kushtet e përdorimit dhe Politikën e privatësisë.';

  @override
  String get guest_verifyEmailReminder =>
      'Konfirmoni adresën e emailit për ta mbrojtur llogarinë tuaj. Mund të vazhdoni ta përdorni VPN-në.';

  @override
  String get guest_serviceUnavailable =>
      'Shërbimi nuk disponohet përkohësisht. Provoni përsëri pas pak.';

  @override
  String get guest_restoreError =>
      'Blerjet tuaja nuk u rikthyen. Provoni përsëri me llogarinë Google Play të përdorur për blerjen.';

  @override
  String get guest_claimSuccess =>
      'Llogaria juaj u krijua. Abonimi dhe qasja juaj në VPN u ruajtën.';

  @override
  String get guest_emailExists =>
      'Ky email është tashmë në përdorim. Zgjidhni një adresë tjetër ose hyni në llogarinë tuaj ekzistuese. Blerja juaj mbetet e disponueshme përmes Google Play.';

  @override
  String get guest_claimError =>
      'Llogaria juaj nuk mund të krijohej. Mund të vazhdoni të përdorni VPN-në tuaj dhe të provoni përsëri më vonë.';

  @override
  String get guest_secureStorageError =>
      'Sesioni juaj nuk mund të mbrohej në këtë pajisje. Provoni përsëri.';

  @override
  String get guest_premiumRequired =>
      'Zgjidhni një abonim për të aktivizuar VPN-në tuaj.';

  @override
  String get welcome_viewPlans => 'Shiko planet';

  @override
  String get google_continue => 'Vazhdo me Google';

  @override
  String get google_or => 'ose';

  @override
  String get google_title => 'Llogaria juaj FuzeVPN';

  @override
  String get google_settingUp => 'Përfundoni krijimin e llogarisë';

  @override
  String get google_country => 'Vendi i banimit';

  @override
  String get google_profileDescription =>
      'Zgjidhni vendin tuaj dhe shqyrtoni dy dokumentet për të krijuar llogarinë tuaj FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Lidhni llogarinë tuaj të mysafirit me Google. Abonimi dhe pajisja juaj mbeten të lidhura me këtë llogari.';

  @override
  String get google_linkTitle => 'Lidhni Google me FuzeVPN';

  @override
  String get google_linkDescription =>
      'Konfirmoni qasjen në llogarinë tuaj ekzistuese FuzeVPN. Ky hap nuk kërkon fjalëkalimin tuaj Google.';

  @override
  String get google_password => 'Fjalëkalimi FuzeVPN';

  @override
  String get google_linkAccount => 'Konfirmo lidhjen';

  @override
  String get google_requestEmail => 'Më dërgo një email konfirmimi';

  @override
  String get google_emailInstructions =>
      'Hapni emailin nga FuzeVPN dhe shkruani kodin e konfirmimit.';

  @override
  String get google_emailCode => 'Kodi i konfirmimit me email';

  @override
  String get google_confirmEmail => 'Konfirmo kodin';

  @override
  String get google_restart => 'Zgjidh një llogari tjetër Google';

  @override
  String get google_resume => 'Kontrollo këtë përpjekje';

  @override
  String get google_unavailable =>
      'Hyrja me Google nuk disponohet. Mund të përdorni emailin dhe fjalëkalimin.';

  @override
  String get google_expired =>
      'Kjo përpjekje ka skaduar. Anuloni atë dhe filloni përsëri.';

  @override
  String get google_conflict =>
      'Kjo llogari Google është tashmë e lidhur diku tjetër. Llogaria dhe abonimi juaj aktual ruhen.';

  @override
  String get google_error =>
      'Hyrja me Google dështoi. Provoni përsëri; qasja juaj aktuale ruhet.';

  @override
  String get google_uncertain =>
      'Rezultati nuk mund të konfirmohej. Kontrolloni këtë përpjekje ose anuloni përpara se të filloni përsëri.';

  @override
  String get google_cancelFailed =>
      'Anulimi nuk mund të konfirmohej. Provoni të anuloni përsëri përpara se të largoheni nga ky ekran.';

  @override
  String get google_cancelled => 'Hyrja me Google u anulua.';

  @override
  String get google_selecting => 'Zgjidhni llogarinë tuaj Google…';

  @override
  String get google_verifying => 'Duke kontrolluar llogarinë tuaj…';

  @override
  String get google_emailUnavailable =>
      'Emaili i konfirmimit nuk mund të dërgohej. Provoni përsëri më vonë.';

  @override
  String get google_emailSent =>
      'Emaili i konfirmimit u dërgua. Kontrolloni kutinë tuaj hyrëse.';

  @override
  String get google_rateLimited =>
      'Ju lutemi prisni përpara se të provoni përsëri.';

  @override
  String get google_busy =>
      'Google nuk disponohet ndërkohë që është në vazhdim një veprim tjetër (lidhje VPN, llogari ose mysafir). Provoni përsëri kur të përfundojë; qasja juaj aktuale ruhet.';

  @override
  String get google_invalidPassword =>
      'Fjalëkalimi FuzeVPN është i pasaktë. Llogaria juaj aktuale ruhet.';

  @override
  String get google_invalidCode =>
      'Kodi i konfirmimit është i pavlefshëm ose ka skaduar.';

  @override
  String get google_accountChanged =>
      'Sesioni juaj ka ndryshuar. Anuloni këtë përpjekje përpara se të filloni përsëri.';

  @override
  String get google_invalidResponse =>
      'Përgjigja nuk mund të verifikohej. Qasja juaj aktuale ruhet.';

  @override
  String get google_invalidRegistration =>
      'Kontrolloni vendin tuaj dhe të dy pëlqimet.';

  @override
  String get google_consentRequired =>
      'Zgjidhni vendin tuaj dhe pranoni të dy dokumentet për të vazhduar.';

  @override
  String get google_challengeRequired =>
      'Nevojitet një verifikim shtesë sigurie. Qasja juaj aktuale ruhet.';

  @override
  String get google_challengeUnavailable =>
      'Verifikimi i sigurisë nuk disponohet. Provoni përsëri më vonë.';

  @override
  String get google_intentMismatch =>
      'Një përpjekje e mëparshme për hyrje me Google është ende në pritje. Anuloni atë përpara se të filloni këtë veprim.';

  @override
  String get google_challengeBlocked =>
      'Verifikimi i kërkuar i sigurisë nuk disponohet në këtë aplikacion. Ky veprim nuk mund të përfundojë tani.';

  @override
  String get google_solveChallenge => 'Plotëso verifikimin e sigurisë';

  @override
  String get google_challengeTitle => 'Verifikim sigurie';

  @override
  String get google_challengeReady =>
      'Verifikimi përfundoi. Tani mund të konfirmoni krijimin e llogarisë tuaj.';

  @override
  String get google_challengeExpired =>
      'Verifikimi ka skaduar. Plotësojeni përsëri përpara se ta konfirmoni.';

  @override
  String get google_challengeCancelled =>
      'Verifikimi u anulua. Mund ta provoni përsëri.';

  @override
  String get google_challengeFailed =>
      'Verifikimi i sigurisë dështoi. Provoni përsëri.';

  @override
  String get billing_trialTitle => 'Provoni Fuze Premium falas';

  @override
  String get billing_trialSubtitle => 'Mbroni lidhjen tuaj që nga sot.';

  @override
  String get billing_trialWeeks => 'Provë falas për 2 javë';

  @override
  String billing_trialDays(String days) {
    return 'Provë falas për $days ditë';
  }

  @override
  String get billing_trialStart => 'Fillo provën time falas';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Nëse filloni sot, pagesa e parë pritet më $date.';
  }

  @override
  String get billing_trialTerms =>
      'Rinovohet automatikisht me çmimin e treguar. Për të shmangur një pagesë, anuloni në Google Play përpara se të përfundojë prova.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Më pas $price në muaj';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Më pas $price në vit';
  }

  @override
  String get billing_choosePeriod => 'Zgjidhni planin tuaj';

  @override
  String get billing_selectionHint => 'Zgjidhni një plan për të vazhduar.';

  @override
  String get billing_benefitConnection => 'Lidhje e enkriptuar';

  @override
  String get billing_benefitPrivacy => 'Privatësi në internet';

  @override
  String get billing_benefitNoAccount => 'Nuk kërkohet regjistrim';

  @override
  String get billing_cancellation => 'Anulo në Google Play';

  @override
  String get billing_premiumTitle => 'Një lidhje më e mbrojtur.';

  @override
  String get billing_premiumSubtitle => 'Mbroni lidhjen tuaj, në ritmin tuaj.';

  @override
  String get billing_priceMonthly => 'në muaj';

  @override
  String get billing_priceYearly => 'në vit';

  @override
  String get billing_trialToday => 'Sot nuk paguani asgjë';

  @override
  String get billing_trialConfirmation =>
      'Google Play konfirmon datat, shumën përfundimtare dhe taksat e zbatueshme përpara konfirmimit tuaj.';

  @override
  String get billing_offerChanged =>
      'Kushtet e kësaj oferte kanë ndryshuar. Përditësoni planet dhe zgjidhni përsëri.';

  @override
  String get status_waitingNetwork => 'Në pritje të rrjetit';

  @override
  String get status_waitingNetworkDetail =>
      'Nuk ka rrjet të disponueshëm. VPN-ja do të verifikojë lidhjen kur të kthehet rrjeti.';

  @override
  String get locations_favoriteLoadFailed =>
      'Të preferuarat nuk mund të ngarkoheshin. Provoni përsëri.';

  @override
  String get locations_favoritesLoading => 'Duke ngarkuar të preferuarat…';
}
