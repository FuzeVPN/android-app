// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Apsaugokite savo ryšį';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN naudoja Android VPN paslaugą (VpnService), kad tarp šio įrenginio ir FuzeVPN serverių sukurtų šifruotą tunelį.';

  @override
  String get vpnDisclosure_dataBody =>
      'Kol VPN aktyvus, jūsų programų interneto srautas, paskirties adresai ir DNS užklausos siunčiami šiuo tuneliu, kad būtų nukreiptas jūsų ryšys, net kai FuzeVPN veikia fone.';

  @override
  String get vpnDisclosure_statusBody =>
      'Programa naudoja ryšio būseną, jo trukmę ir perduotų duomenų kiekį, kad rodytų jūsų VPN ryšį. Galite jį sustabdyti bet kada.';

  @override
  String get vpnDisclosure_privacy => 'Privatumas';

  @override
  String get vpnDisclosure_accept => 'Sutikti ir tęsti';

  @override
  String get vpnDisclosure_decline => 'Ne dabar';

  @override
  String get accountRestoration_title => 'Paskyra laikinai nepasiekiama';

  @override
  String get accountRestoration_message =>
      'Jūsų sesija išsaugota. Bandykite dar kartą, kad atkurtumėte paskyrą; VPN ryšį čia vis tiek galite valdyti.';

  @override
  String get action_retry => 'Bandyti dar kartą';

  @override
  String get session_endingTitle => 'Baigiama sesija';

  @override
  String get session_ending =>
      'Baigiama sesija: stabdomas VPN ir atliekamas valymas…';

  @override
  String get session_stopFailed =>
      'VPN sustabdymas nepatvirtintas. Prieš vėl prisijungdami prie paskyros, bandykite dar kartą.';

  @override
  String get session_cleanupFailed =>
      'VPN sustabdytas, tačiau sesijos pašalinimas nepatvirtintas. Bandykite išvalyti dar kartą.';

  @override
  String get session_retryStop => 'Bandyti sustabdyti dar kartą';

  @override
  String get session_retryCleanup => 'Bandyti išvalyti dar kartą';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Saugiai ruošiamas FuzeVPN…';

  @override
  String get nav_connection => 'Ryšys';

  @override
  String get nav_locations => 'Vietos';

  @override
  String get nav_account => 'Paskyra';

  @override
  String get nav_devices => 'Įrenginiai';

  @override
  String get nav_settings => 'Nustatymai';

  @override
  String get action_refresh => 'Atnaujinti';

  @override
  String get auth_tab_login => 'Prisijungimas';

  @override
  String get auth_tab_register => 'Registracija';

  @override
  String get auth_stepAccount => 'Paskyra';

  @override
  String get auth_stepIdentity => 'Tapatybė';

  @override
  String get auth_stepAddress => 'Adresas ir sutikimai';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Žingsnis $current iš $total';
  }

  @override
  String get auth_tagline => 'Jūsų VPN – paprasta.';

  @override
  String get auth_keysLocal =>
      'Jūsų privatūs VPN raktai lieka šiame įrenginyje.';

  @override
  String get form_email => 'El. pašto adresas';

  @override
  String get form_password => 'Slaptažodis';

  @override
  String get form_showPassword => 'Rodyti slaptažodį';

  @override
  String get form_hidePassword => 'Slėpti slaptažodį';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 baitai. Kai kurie simboliai užima daugiau nei vieną baitą.';

  @override
  String get form_firstName => 'Vardas';

  @override
  String get form_lastName => 'Pavardė';

  @override
  String get form_phone => 'Telefono numeris (+33612345678)';

  @override
  String get form_address => 'Adresas';

  @override
  String get form_address2 => 'Adreso 2 eilutė (neprivaloma)';

  @override
  String get form_postalCode => 'Pašto kodas';

  @override
  String get form_city => 'Miestas';

  @override
  String get form_country => 'Šalies kodas (pvz., FR)';

  @override
  String get action_login => 'Prisijungti prie paskyros';

  @override
  String get action_createAccount => 'Sukurti paskyrą';

  @override
  String get action_createMyAccount => 'Sukurti mano paskyrą';

  @override
  String get action_next => 'Tęsti';

  @override
  String get action_previous => 'Atgal';

  @override
  String get action_forgotPassword => 'Pamiršote slaptažodį?';

  @override
  String get auth_noAccount => 'Dar neturite paskyros?';

  @override
  String get auth_requiredInformation =>
      'Sukurkite paskyrą per tris žingsnius.';

  @override
  String get auth_termsPrefix => 'Sutinku su ';

  @override
  String get auth_termsLink => 'naudojimo sąlygomis';

  @override
  String get auth_privacyPrefix => 'Sutinku su ';

  @override
  String get auth_privacyLink => 'privatumo politika';

  @override
  String get auth_consentRequired =>
      'Norint sukurti paskyrą, reikia jūsų sutikimo.';

  @override
  String get validation_required => 'Šį lauką būtina užpildyti.';

  @override
  String get validation_email => 'Įveskite tinkamą el. pašto adresą.';

  @override
  String get validation_password =>
      'Slaptažodis per trumpas: reikia bent 8 UTF-8 baitų.';

  @override
  String get validation_passwordTooLong =>
      'Slaptažodis per ilgas: ne daugiau kaip 72 UTF-8 baitų.';

  @override
  String get validation_phone =>
      'Naudokite tarptautinį formatą, pvz., +33612345678.';

  @override
  String get validation_country =>
      'Naudokite dviejų raidžių šalies kodą, pvz., FR.';

  @override
  String get passwordReset_title => 'Slaptažodžio atkūrimas';

  @override
  String get passwordReset_description =>
      'Įveskite savo paskyros el. pašto adresą, kad gautumėte slaptažodžio atkūrimo nuorodą.';

  @override
  String get passwordReset_send => 'Siųsti nuorodą';

  @override
  String get connection_title => 'Jūsų ryšys';

  @override
  String get connection_subtitle => 'Pasirinkite vietą, tada įjunkite VPN.';

  @override
  String get connection_prepare => 'Pasiruošę prisijungti?';

  @override
  String get connection_advancedOptions => 'Išplėstinės parinktys';

  @override
  String get connection_location => 'Vieta';

  @override
  String get connection_chooseLocation => 'Pasirinkite vietą';

  @override
  String get connection_protocol => 'Protokolas';

  @override
  String get connection_connect => 'Prisijungti';

  @override
  String get connection_connecting => 'Jungiamasi…';

  @override
  String get connection_disconnect => 'Atjungti';

  @override
  String get connection_disconnecting => 'Atjungiama';

  @override
  String get connection_locationChange => 'Keičiama vieta…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nepasiekiamas';
  }

  @override
  String get connection_activeLocation => 'Aktyvi vieta';

  @override
  String get connection_duration => 'Trukmė';

  @override
  String get connection_received => 'Gauta';

  @override
  String get connection_sent => 'Išsiųsta';

  @override
  String get connection_lastHandshake => 'Paskutinis saugus ryšio užmezgimas';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Prieš $duration';
  }

  @override
  String get verification_title => 'Patvirtinkite savo el. pašto adresą';

  @override
  String get verification_message =>
      'Patvirtinkite el. pašto adresą, kad galėtumėte naudoti VPN šiame telefone.';

  @override
  String get verification_resend => 'Siųsti laišką iš naujo';

  @override
  String get migration_title => 'Vietos keitimas';

  @override
  String get migration_draining => 'Ruošiamas vietos keitimas…';

  @override
  String get migration_activating => 'Aktyvinamas naujas serveris…';

  @override
  String get migration_ready => 'Vieta atnaujinta.';

  @override
  String get migration_blocked =>
      'Vietos keitimui reikia veiksmų serverio pusėje. Bandykite vėliau arba susisiekite su palaikymo tarnyba.';

  @override
  String get migration_progress => 'Vietos keitimo eiga';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Pauzė tarp patikrinimų: $seconds s.';
  }

  @override
  String get migration_resume => 'Tęsti vietos keitimą';

  @override
  String get status_authorizing => 'Reikalingas leidimas';

  @override
  String get status_authorizingDetail =>
      'Patvirtinkite Android užklausą, kad leistumėte naudoti VPN.';

  @override
  String get status_preparing => 'Ruošiamasi';

  @override
  String get status_preparingDetail => 'Jūsų saugus ryšys ruošiamas.';

  @override
  String get status_reconnecting => 'Jungiamasi iš naujo…';

  @override
  String get status_reconnectingDetail =>
      'Ryšys nutrūko. VPN bando prisijungti iš naujo.';

  @override
  String get status_connecting => 'Jungiamasi';

  @override
  String get status_connectingDetail => 'Jungiamasi prie VPN serverio…';

  @override
  String get status_connected => 'Prisijungta';

  @override
  String get status_connectedDetail => 'Jūsų VPN ryšys aktyvus.';

  @override
  String get status_disconnecting => 'Atjungiama';

  @override
  String get status_disconnectingDetail => 'Jūsų VPN ryšys stabdomas.';

  @override
  String get status_error => 'Ryšys nepasiekiamas';

  @override
  String get status_errorDetail =>
      'VPN ryšys nepatvirtintas. Bandykite dar kartą.';

  @override
  String get status_idle => 'Atjungta';

  @override
  String get status_idleDetail =>
      'Prisijunkite prie VPN, kad apsaugotumėte savo ryšį.';

  @override
  String get trust_note =>
      'Uždarius programą, VPN nesustoja. Norėdami jį sustabdyti, naudokite mygtuką „Atjungti“.';

  @override
  String get locations_none => 'Šiuo metu nėra pasiekiamų vietų.';

  @override
  String get locations_available => 'Pasirinkite kitą vietą.';

  @override
  String get locations_selected => 'Pasirinkta vieta';

  @override
  String get locations_select => 'Pasirinkti šią vietą';

  @override
  String get locations_lockedTunnel => 'Norėdami keisti vietą, atjunkite VPN.';

  @override
  String get locations_lockedMigration =>
      'Palaukite, kol baigsis vietos keitimas.';

  @override
  String get devices_title => 'Jūsų įrenginiai';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit įrenginių';
  }

  @override
  String get devices_refresh => 'Atnaujinti įrenginius';

  @override
  String get devices_empty => 'Dar neužregistruotas nė vienas VPN įrenginys.';

  @override
  String get devices_firstConnection =>
      'Jūsų telefonas bus pridėtas pirmą kartą prisijungus.';

  @override
  String get devices_thisDevice => 'Šis įrenginys';

  @override
  String devices_added(Object date) {
    return 'Pridėtas $date';
  }

  @override
  String get devices_unnamed => 'Įrenginys be pavadinimo';

  @override
  String get action_remove => 'Pašalinti';

  @override
  String get settings_title => 'Nustatymai';

  @override
  String get settings_subtitle =>
      'Jūsų nuostatos ir paskyra – vienoje vietoje.';

  @override
  String get settings_appearance => 'Išvaizda';

  @override
  String get settings_language => 'Kalba';

  @override
  String get settings_languageDescription =>
      'Pasirinkta kalba taip pat taikoma VPN pranešimams.';

  @override
  String get settings_account => 'Paskyra';

  @override
  String get settings_signOut => 'Atsijungti nuo paskyros';

  @override
  String get settings_privacy => 'Privatumo politika';

  @override
  String get settings_terms => 'Naudojimo sąlygos';

  @override
  String get settings_security => 'Saugumas ir skaidrumas';

  @override
  String get settings_licenses => 'Komponentų licencijos';

  @override
  String get settings_licensesDetail =>
      'Programoje naudojama programinė įranga';

  @override
  String settings_licensesLegalese(String url) {
    return 'Programos ir jos MPL-2.0 komponentų pirminis kodas: $url';
  }

  @override
  String get settings_background =>
      'VPN lieka įjungtas, kai išeinate iš programos. Norėdami jį sustabdyti, naudokite mygtuką „Atjungti“ skirtuke „Ryšys“.';

  @override
  String get theme_system => 'Pagal sistemą';

  @override
  String get theme_light => 'Šviesi';

  @override
  String get theme_dark => 'Tamsi';

  @override
  String get language_system => 'Telefono kalba';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Pašalinti šį įrenginį?';

  @override
  String get dialog_removeCurrent =>
      'Šis telefonas bus atjungtas nuo VPN ir neteks prieigos. Jo VPN ryšio duomenys bus pašalinti po serverio patvirtinimo.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN prieiga įrenginiui „$name“ bus panaikinta. Šio veiksmo nebus galima atšaukti.';
  }

  @override
  String get dialog_signOut => 'Atsijungti nuo paskyros?';

  @override
  String get dialog_signOutMessage =>
      'VPN bus sustabdytas, o jums reikės prisijungti dar kartą. Užšifruoti VPN raktai liks šiame telefone kitam prisijungimui.';

  @override
  String get action_cancel => 'Atšaukti';

  @override
  String get action_close => 'Uždaryti';

  @override
  String get action_copy => 'Kopijuoti';

  @override
  String get action_renew => 'Atnaujinti';

  @override
  String get action_signOut => 'Atsijungti nuo paskyros';

  @override
  String get notice_close => 'Uždaryti pranešimą';

  @override
  String get notice_sessionExpired_title => 'Sesija baigėsi';

  @override
  String get notice_sessionExpired_message =>
      'Jūsų sesija baigėsi. Prisijunkite dar kartą.';

  @override
  String get notice_connectionFailed_title => 'Nepavyko prisijungti';

  @override
  String get notice_invalidCredentials_message =>
      'Neteisingas el. pašto adresas arba slaptažodis.';

  @override
  String get notice_emailVerification_title =>
      'Reikia patvirtinti el. pašto adresą';

  @override
  String get notice_emailVerification_message =>
      'Prieš pridėdami VPN įrenginį, patvirtinkite el. pašto adresą.';

  @override
  String get notice_rateLimited_title => 'Per daug bandymų';

  @override
  String get notice_deviceLimit_title => 'Pasiekta įrenginių riba';

  @override
  String get notice_deviceLimit_message =>
      'Prieš pridėdami kitą įrenginį, pašalinkite esamą.';

  @override
  String get notice_identityRenewal_title => 'Reikia atnaujinti VPN tapatybę';

  @override
  String get notice_identityRenewal_message =>
      'Ši tapatybė pašalinta. Sukurkite naują vietinę tapatybę.';

  @override
  String get notice_migrationPending_title => 'Vyksta vietos keitimas';

  @override
  String get notice_migrationPending_message => 'Vietos keitimas jau vyksta.';

  @override
  String get notice_migrationBlocked_title => 'Vietos keitimas užblokuotas';

  @override
  String get notice_migrationBlocked_message =>
      'Vietos keitimui reikia veiksmų serverio pusėje. Bandykite vėliau arba susisiekite su palaikymo tarnyba.';

  @override
  String get notice_targetUnavailable_title =>
      'Serveris laikinai nepasiekiamas';

  @override
  String get notice_targetUnavailable_message =>
      'Šis serveris laikinai nepasiekiamas.';

  @override
  String get notice_networkUnavailable_title => 'Nėra interneto ryšio';

  @override
  String get notice_networkUnavailable_message =>
      'Patikrinkite ryšį ir bandykite dar kartą.';

  @override
  String get notice_permissionDenied_title => 'VPN leidimas atmestas';

  @override
  String get notice_permissionDenied_message =>
      'Pradėkite prisijungimą iš naujo ir patvirtinkite Android leidimo užklausą.';

  @override
  String get notice_wireguardTimeout_title => 'Serveris neatsako';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard ryšys užtruko per ilgai. Bandykite dar kartą arba pasirinkite kitą vietą.';

  @override
  String get notice_tlsFailed_title => 'Saugus ryšys atmestas';

  @override
  String get notice_tlsFailed_message =>
      'Serveris nepriėmė OpenVPN ryšio. Bandykite dar kartą. Jei problema išlieka, paleiskite diagnostiką.';

  @override
  String get notice_tunRejected_title => 'Android atmetė VPN sąsają';

  @override
  String get notice_tunRejected_message =>
      'Android atmetė tinklo konfigūraciją, kurios prašė OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN nepavyko paleisti';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN variklio nepavyko visiškai paleisti. Bandykite dar kartą. Jei problema išlieka, susisiekite su palaikymo tarnyba.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostikos kodas: $code';
  }

  @override
  String get notice_generic_title => 'Nepavyko užmegzti VPN ryšio';

  @override
  String get notice_generic_message => 'Įvyko klaida. Bandykite vėliau.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Paskyra sukurta',
      'password_reset_sent': 'Gauta slaptažodžio atkūrimo užklausa',
      'verification_email_sent': 'Patvirtinimo laiškas išsiųstas',
      'location_migration_pending': 'Vyksta vietos keitimas',
      'vpn_sign_in_required': 'Reikia prisijungti prie paskyros',
      'protocol_unavailable_at_location': 'Protokolas nepasiekiamas',
      'vpn_permission_denied': 'VPN leidimas atmestas',
      'revoked_identity_device_limit': 'Pasiekta įrenginių riba',
      'tunnel_start_unexpected': 'VPN nepavyko paleisti',
      'flutter_disconnect_timeout': 'Atjungimas nepatvirtintas',
      'flutter_disconnect_unexpected': 'Nepavyko atjungti',
      'device_revoked': 'Įrenginys pašalintas',
      'revoke_unexpected': 'Nepavyko pašalinti įrenginio',
      'identity_renewal_unexpected': 'Nepavyko atnaujinti tapatybės',
      'openvpn_renewal_unexpected': 'Nepavyko atnaujinti OpenVPN',
      'location_migration_blocked': 'Vietos keitimas užblokuotas',
      'location_migration_slow': 'Vietos keitimas vis dar vyksta',
      'location_migration_conflict': 'Vietos keitimą reikia atnaujinti',
      'location_migration_verification_failed':
          'Vietos keitimas nepatvirtintas',
      'location_migration_device_changed': 'Keičiant vietą įrenginys pasikeitė',
      'tunnel_stop_failed': 'Vietos keitimas nepasiekiamas',
      'device_clock_ahead': 'Įrenginio laikrodis skuba',
      'other': 'Nepavyko atlikti veiksmo',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Paskyra sukurta, tačiau patvirtinimo laiško išsiųsti nepavyko. Programoje pasirinkite „Siųsti laišką iš naujo“.',
      'password_reset_sent':
          'Jūsų užklausa gauta. Jei su šiuo adresu susieta paskyra, galite gauti el. laišką. Taip pat patikrinkite šlamšto aplanką.',
      'verification_email_sent':
          'Ką tik išsiųstas naujas patvirtinimo laiškas.',
      'location_migration_pending':
          'Perkėlimas į $target dar ruošiamas. Galite tęsti jį nekurdami įrenginio iš naujo.',
      'vpn_sign_in_required':
          'Prieš paleisdami VPN, prisijunkite prie paskyros.',
      'protocol_unavailable_at_location':
          'Šioje vietoje pasirinkto protokolo nėra. Atnaujinkite vietas arba pasirinkite kitą protokolą.',
      'vpn_permission_denied':
          'Android nesuteikė VPN leidimo. Pradėkite prisijungimą iš naujo ir patvirtinkite sistemos užklausą.',
      'revoked_identity_device_limit':
          'Šio įrenginio VPN prieiga pašalinta, o įrenginių riba pasiekta. Pašalinkite įrenginį skiltyje „Paskyra“ → „Tvarkyti mano įrenginius“.',
      'tunnel_start_unexpected':
          'Netikėta klaida nutraukė tunelio ruošimą. Patikrinkite diagnostikos kodą ir bandykite dar kartą.',
      'flutter_disconnect_timeout':
          'Android laiku nepatvirtino, kad VPN sustojo. Bandykite jį sustabdyti dar kartą.',
      'flutter_disconnect_unexpected':
          'Dėl netikėtos klaidos nepavyko patvirtinti, kad tunelis sustojo.',
      'device_revoked':
          'Įrenginio VPN prieiga panaikinta, o jo vietiniai slaptieji duomenys pašalinti.',
      'revoke_unexpected':
          'Įrenginio nepavyko pašalinti. Atnaujinkite sąrašą ir bandykite dar kartą.',
      'identity_renewal_unexpected':
          'Nepavyko sukurti naujos VPN tapatybės. Atnaujinkite įrenginius ir bandykite dar kartą.',
      'openvpn_renewal_unexpected':
          'Nepavyko atnaujinti OpenVPN profilio. Bandykite dar kartą arba patikrinkite diagnostikos kodą.',
      'location_migration_blocked':
          'Serveris šiuo metu negali užbaigti šio pakeitimo. Įrenginys ir jo vietinė tapatybė išsaugoti.',
      'location_migration_slow':
          'Serveris vis dar ruošia perkėlimą į $target. Po kelių akimirkų pasirinkite „Tęsti“.',
      'location_migration_conflict':
          'Serveryje pasikeitė įrenginio būsena. Atnaujinkite įrenginius, tada tęskite keitimą.',
      'location_migration_verification_failed':
          'Serveris nepatvirtino naujos vietos. Ankstesnė vietinė tapatybė išsaugota.',
      'location_migration_device_changed':
          'Serverio grąžintas įrenginys nebeatitinka keičiamo įrenginio. Prieš bandydami dar kartą, atnaujinkite įrenginius.',
      'tunnel_stop_failed':
          'Prieš naują ryšį ankstesnis tunelis turi būti visiškai sustabdytas.',
      'device_clock_ahead':
          'Atrodo, kad šio įrenginio laikrodis skuba. Įjunkite automatinę datą ir laiką, kad liktumėte prisijungę.',
      'other':
          'Veiksmo nepavyko užbaigti. Bandykite dar kartą arba palaikymo tarnybai nusiųskite diagnostikos kodą.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesija baigėsi',
      'invalid_credentials': 'Prisijungti nepavyko',
      'email_verification_required': 'Reikia patvirtinti el. pašto adresą',
      'verification_email_cooldown': 'El. laiškas jau išsiųstas',
      'rate_limited': 'Per daug bandymų',
      'invalid_registration': 'Informaciją reikia ištaisyti',
      'email_exists': 'Paskyra jau egzistuoja',
      'invalid_profile': 'Netinkamas profilis',
      'invalid_device': 'Netinkamas įrenginys',
      'invalid_location': 'Vieta nepasiekiama',
      'device_limit': 'Pasiekta įrenginių riba',
      'device_exists': 'VPN tapatybė jau naudojama',
      'device_identity_revoked': 'VPN tapatybę reikia atnaujinti',
      'device_location_locked': 'Vietos keitimą reikia atnaujinti',
      'location_migration_pending': 'Vyksta vietos keitimas',
      'location_migration_blocked': 'Vietos keitimas užblokuotas',
      'target_ca_mismatch': 'Nesuderinamas OpenVPN serveris',
      'location_migration_conflict': 'Vietos keitimą reikia atnaujinti',
      'server_full': 'Serveris pilnas',
      'capacity_unavailable': 'Vieta laikinai nepasiekiama',
      'target_unavailable': 'Serveris laikinai nepasiekiamas',
      'not_found': 'Elementas nerastas',
      'invalid_openvpn_csr': 'Neteisinga OpenVPN tapatybė',
      'openvpn_profile_exists': 'OpenVPN profilis jau yra',
      'openvpn_profile_revoked': 'OpenVPN profilis panaikintas',
      'openvpn_operation_pending': 'OpenVPN veiksmas vykdomas',
      'openvpn_operation_terminal': 'OpenVPN veiksmas nutrauktas',
      'openvpn_address_unavailable': 'OpenVPN adresas nepasiekiamas',
      'openvpn_profile_conflict': 'OpenVPN konfliktas',
      'openvpn_signer_unavailable': 'OpenVPN nepasiekiamas',
      'email_delivery_unavailable': 'El. paštas nepasiekiamas',
      'invalid_token': 'Neteisinga nuoroda',
      'network_unavailable': 'Nėra interneto ryšio',
      'invalid_json': 'Netinkama užklausa',
      'invalid_api_response': 'Netinkamas serverio atsakas',
      'ipv6_unavailable': 'IPv6 nepasiekiamas',
      'invalid_ip_families': 'Tinklo konfigūracija atmesta',
      'other': 'Paslauga nepasiekiama',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Jūsų sesija baigėsi. Prisijunkite dar kartą.',
      'invalid_credentials': 'Neteisingas el. pašto adresas arba slaptažodis.',
      'email_verification_required':
          'Prieš pridėdami VPN įrenginį, patvirtinkite el. pašto adresą.',
      'invalid_registration': 'Patikrinkite pateiktą informaciją ir sutikimus.',
      'email_exists': 'Su šiuo el. pašto adresu jau yra paskyra.',
      'invalid_profile': 'Patikrinkite profilio informaciją.',
      'invalid_device':
          'Šio įrenginio pavadinimas arba vietinė tapatybė netinkami.',
      'invalid_location': 'Atnaujinkite vietų sąrašą ir bandykite dar kartą.',
      'device_limit': 'Prieš pridėdami kitą įrenginį, pašalinkite esamą.',
      'device_exists': 'Ši VPN tapatybė jau susieta su kita paskyra.',
      'device_identity_revoked':
          'Ši tapatybė buvo pašalinta. Reikia sukurti naują vietinę tapatybę.',
      'device_location_locked':
          'Šio įrenginio vieta ką tik pasikeitė. Programa tęs vykstantį vietos keitimą.',
      'location_migration_pending': 'Vietos keitimas jau vyksta.',
      'location_migration_blocked':
          'Vietos keitimui reikia veiksmų serverio pusėje. Bandykite vėliau arba susisiekite su palaikymo tarnyba.',
      'target_ca_mismatch':
          'Šis serveris dar nesuderinamas su dabartiniu OpenVPN profiliu.',
      'location_migration_conflict':
          'Atnaujinkite įrenginius, tada bandykite vietos keitimą dar kartą.',
      'server_full':
          'Ši vieta pasiekė ryšių ribą. Pasirinkite kitą vietą arba bandykite vėliau.',
      'capacity_unavailable':
          'Dabar negalime patvirtinti, ar ši vieta pasiekiama. Pasirinkite kitą vietą arba bandykite vėliau.',
      'target_unavailable': 'Šis serveris laikinai nepasiekiamas.',
      'not_found': 'Šis elementas jūsų paskyroje nebepasiekiamas.',
      'invalid_openvpn_csr':
          'Sukurkite naują OpenVPN tapatybę ir bandykite dar kartą.',
      'openvpn_profile_exists': 'Šiam įrenginiui jau yra OpenVPN profilis.',
      'openvpn_profile_revoked':
          'Atnaujinkite OpenVPN profilį, kad galėtumėte tęsti.',
      'openvpn_operation_pending':
          'Pakeitimas dar įsigalioja. Bandykite vėliau.',
      'openvpn_operation_terminal':
          'Sukurkite naują OpenVPN tapatybę ir bandykite dar kartą.',
      'openvpn_address_unavailable':
          'Šiuo metu nėra pasiekiamo OpenVPN adreso.',
      'openvpn_profile_conflict':
          'Profilis pasikeitė. Atnaujinkite įrenginius ir bandykite dar kartą.',
      'openvpn_signer_unavailable': 'OpenVPN paslauga laikinai nepasiekiama.',
      'email_delivery_unavailable':
          'El. laiško nepavyko išsiųsti. Bandykite vėliau.',
      'invalid_token':
          'Ši nuoroda neteisinga arba nebegalioja. Paprašykite naujos.',
      'network_unavailable':
          'Patikrinkite interneto ryšį ir bandykite dar kartą.',
      'invalid_json': 'Patikrinkite įvestą informaciją ir bandykite dar kartą.',
      'invalid_api_response':
          'Serveris grąžino netikėtą atsakymą. Bandykite vėliau.',
      'ipv6_unavailable':
          'Serveris šiuo metu negali įjungti IPv6. Bandykite vėliau.',
      'invalid_ip_families':
          'Tunelio konfigūracija neišsami arba neatitinka leistinų adresų. Bandykite dar kartą programoje.',
      'other': 'Įvyko serverio klaida. Bandykite vėliau.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Bandykite dar kartą po kelių akimirkų.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Bandykite dar kartą po $seconds sekundžių.',
      one: 'Bandykite dar kartą po $seconds sekundės.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Bandykite dar kartą po $minutes minučių.',
      one: 'Bandykite dar kartą po $minutes minutės.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Bandykite dar kartą po $hours valandų.',
      one: 'Bandykite dar kartą po $hours valandos.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Sistemos VPN tęsimas nepasiekiamas',
      'system_vpn_resume_corrupt': 'Netinkamas sistemos VPN tęsimas',
      'system_vpn_resume_session_invalid': 'Netinkama VPN tęsimo sesija',
      'system_vpn_resume_identity_changed': 'VPN tapatybė pakeista',
      'system_vpn_resume_identity_invalid': 'Netinkama VPN tęsimo tapatybė',
      'system_vpn_resume_storage_failed': 'VPN tęsimo saugykla nepasiekiama',
      'system_vpn_resume_network_timeout': 'Nėra tinklo VPN tęsimui',
      'system_vpn_resume_blocked': 'VPN tęsimas užblokuotas',
      'system_vpn_resume_failed': 'Nepavyko tęsti VPN',
      'system_vpn_resume_error_invalid': 'Netinkama VPN tęsimo klaida',
      'wireguard_identity_store_failed': 'WireGuard tapatybė neišsaugota',
      'wireguard_identity_unavailable': 'WireGuard tapatybė nepasiekiama',
      'vpn_host_destroyed': 'Android VPN komponentas sustabdytas',
      'vpn_host_unavailable': 'Android VPN komponentas nepasiekiamas',
      'vpn_permission_required': 'Reikalingas VPN leidimas',
      'vpn_permission_denied': 'VPN leidimas atmestas',
      'vpn_permission_request_failed': 'Nepavyko paprašyti leidimo',
      'wireguard_foreground_service_unavailable':
          'WireGuard paslauga nepasiekiama',
      'wireguard_identity_invalid': 'Netinkamas vietinis WireGuard raktas',
      'wireguard_identity_in_use': 'WireGuard tapatybė jau naudojama',
      'wireguard_configuration_invalid': 'Netinkama WireGuard konfigūracija',
      'wireguard_operation_pending': 'WireGuard veiksmas dar vykdomas',
      'wireguard_start_failed': 'WireGuard paleidimas atmestas',
      'wireguard_stop_timeout': 'WireGuard sustabdymas nepatvirtintas',
      'wireguard_handshake_timeout': 'WireGuard neatsako',
      'openvpn_connection_timeout': 'OpenVPN neatsako',
      'openvpn_core_unavailable': 'OpenVPN variklis nepasiekiamas',
      'openvpn_operation_pending': 'OpenVPN sesija dar aktyvi',
      'openvpn_stop_timeout': 'OpenVPN sustabdymas nepatvirtintas',
      'openvpn_profile_unavailable': 'Trūksta vietinio OpenVPN profilio',
      'openvpn_native_failed': 'Vietinis OpenVPN iškvietimas nutrūko',
      'openvpn_key_generation_failed': 'Nepavyko sukurti OpenVPN P-256 rakto',
      'openvpn_csr_generation_failed': 'Nepavyko sukurti OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN tapatybė neišsaugota',
      'openvpn_identity_clear_failed': 'Neužbaigtas OpenVPN pašalinimas',
      'openvpn_identity_in_use': 'OpenVPN tapatybė dar naudojama',
      'openvpn_tls_verification_required': 'Trūksta OpenVPN TLS patikros',
      'openvpn_cipher_invalid': 'Netinkamas OpenVPN šifras',
      'openvpn_profile_rejected': 'OpenVPN profilis atmestas',
      'openvpn_identity_inconsistent': 'Neatitinkama OpenVPN tapatybė',
      'tls_handshake_failed': 'OpenVPN derybos atmestos',
      'tls_alert_unknown_ca': 'OpenVPN kliento sertifikatas nepripažintas',
      'tls_alert_bad_certificate': 'OpenVPN kliento sertifikatas atmestas',
      'tls_alert_unsupported_certificate': 'Nepalaikomas OpenVPN sertifikatas',
      'tls_client_certificate_required':
          'Reikalingas OpenVPN kliento sertifikatas',
      'tls_alert_misc': 'OpenVPN TLS įspėjimas',
      'tls_signature_algorithm_rejected': 'Nepalaikomas OpenVPN parašas',
      'tls_handshake_rejected': 'OpenVPN TLS derybos atmestos',
      'tls_version_rejected': 'Nesuderinama OpenVPN TLS versija',
      'tls_certificate_expired': 'TLS sertifikato galiojimas baigėsi',
      'tls_certificate_revoked': 'TLS sertifikatas atšauktas',
      'transport_failed': 'OpenVPN serveris nepasiekiamas',
      'tun_configuration_rejected': 'Nepavyko sukurti OpenVPN sąsajos',
      'tun_setup_failed': 'OpenVPN TUN paruošimo klaida',
      'tun_interface_create_failed': 'OpenVPN sąsajos kūrimo klaida',
      'tun_interface_disabled': 'OpenVPN sąsaja išjungta',
      'tun_halted': 'OpenVPN sąsaja nutrūko',
      'tun_already_established': 'OpenVPN sąsaja jau atidaryta',
      'tun_addresses_missing': 'Trūksta OpenVPN adreso',
      'tun_routes_missing': 'Trūksta OpenVPN maršrutų',
      'tun_dns_missing': 'Trūksta OpenVPN DNS',
      'tun_permission_revoked': 'VPN leidimas panaikintas',
      'tun_establish_returned_null': 'Android atmetė VPN sąsają',
      'openvpn_service_start_failed': 'OpenVPN paslauga nepasiekiama',
      'openvpn_operation_timeout': 'OpenVPN iškvietimas užtruko per ilgai',
      'openvpn_start_failed': 'OpenVPN paleidimas atmestas',
      'openvpn_connection_failed': 'OpenVPN ryšys nutrūko',
      'openvpn_core_status_error': 'OpenVPN Core užbaigė darbą su klaida',
      'openvpn_stopped_before_connected': 'OpenVPN sustojo prieš prisijungiant',
      'openvpn_auth_failed': 'OpenVPN autentifikavimas atmestas',
      'openvpn_client_setup_failed': 'Nepavyko paruošti OpenVPN kliento',
      'openvpn_client_halted': 'OpenVPN klientas nutrūko',
      'openvpn_client_restart': 'Prašoma iš naujo paleisti OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN per ilgai neaktyvus',
      'openvpn_session_expired': 'OpenVPN sesijos galiojimas baigėsi',
      'openvpn_credentials_required': 'Nepalaikomas OpenVPN autentifikavimas',
      'openvpn_proxy_failed': 'OpenVPN tarpinio perdavimo klaida',
      'openvpn_compression_failed': 'OpenVPN suspaudimas atmestas',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM šifravimas nepasiekiamas',
      'openvpn_feature_unsupported': 'Nepalaikoma OpenVPN funkcija',
      'network_unavailable': 'Nėra interneto ryšio',
      'network_lost': 'Tinklas nepasiekiamas',
      'certificate_validation_failed': 'Serverio sertifikatas atmestas',
      'openvpn_certificate_expired': 'OpenVPN sertifikato galiojimas baigėsi',
      'tunnel_active_for_another_account': 'Kitos paskyros tunelis dar aktyvus',
      'tunnel_already_active': 'Vietinis tunelis jau aktyvus',
      'tunnel_stop_timeout': '$protocol sustabdymas nepatvirtintas',
      'tunnel_disconnected': '$protocol ryšys nutrūko',
      'native_bridge_unavailable': 'Android tiltas nepasiekiamas',
      'native_operation_failed': 'Android veiksmas nutrūko',
      'invalid_arguments': 'Neišsamūs VPN parametrai',
      'invalid_account_id': 'Netinkama VPN paskyra',
      'invalid_device_id': 'Netinkamas įrenginio identifikatorius',
      'storage_key_not_allowed': 'Saugyklos raktas atmestas',
      'secure_storage_read_failed': 'Nepavyko saugiai nuskaityti',
      'secure_storage_write_failed': 'Nepavyko saugiai įrašyti',
      'key_generation_failed': 'Nepavyko sukurti WireGuard rakto',
      'csr_generation_failed': 'Nepavyko sukurti OpenVPN CSR',
      'openvpn_recovery_exhausted': 'OpenVPN atkūrimas jau panaudotas',
      'openvpn_recovery_failed': 'Nepavyko atkurti OpenVPN',
      'openvpn_renewal_required': 'Reikia atnaujinti OpenVPN sertifikatą',
      'other': 'Neklasifikuota vietinė VPN klaida',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android negali rasti VPN sesijos, kurią būtų galima tęsti. Programoje pradėkite naują ryšį.',
      'system_vpn_resume_corrupt':
          'Išsaugoti VPN tęsimo duomenys yra netinkami ir nebus naudojami. Pradėkite naują ryšį.',
      'system_vpn_resume_session_invalid':
          'Išsaugota sesija nebegali tęsti VPN. Programoje prisijunkite prie paskyros dar kartą.',
      'system_vpn_resume_identity_changed':
          'Vietinė VPN tapatybė pakeista. Tęsimas sustabdytas; pradėkite naują ryšį.',
      'system_vpn_resume_identity_invalid':
          'Tęsimui skirta tapatybė netinkama. Pradėkite naują ryšį.',
      'system_vpn_resume_storage_failed':
          'Android negalėjo perskaityti arba atnaujinti šifruotų tęsimo duomenų. Pradėkite naują ryšį.',
      'system_vpn_resume_network_timeout':
          'Android per nustatytą laiką nerado tinklo VPN tęsimui. Bandykite dar kartą, kai bus pasiekiamas tinklas.',
      'system_vpn_resume_blocked':
          'VPN tęsimas užblokuotas. Patikrinkite Android nustatymus, tada pradėkite naują ryšį.',
      'system_vpn_resume_failed':
          'Android nepavyko tęsti VPN. Programoje pradėkite naują ryšį.',
      'system_vpn_resume_error_invalid':
          'Android grąžino netinkamą tęsimo klaidą. Pradėkite naują ryšį.',
      'wireguard_identity_store_failed':
          'Android negalėjo išsaugoti šios paskyros šifruotos WireGuard tapatybės.',
      'wireguard_identity_unavailable':
          'Šiam ryšiui nėra tinkamos WireGuard tapatybės.',
      'vpn_host_destroyed':
          'Android komponentas, kuriame veikė VPN, buvo sustabdytas. Pradėkite naują ryšį.',
      'vpn_host_unavailable':
          'Android negali sukurti komponento, kuriame veiktų VPN. Patikrinę VPN nustatymus, bandykite dar kartą.',
      'openvpn_renewal_required':
          'Nepavyko automatiškai atnaujinti OpenVPN sertifikato. Programoje pradėkite naują ryšį.',
      'openvpn_recovery_failed':
          'Automatinis atkūrimas nepavyko. Programoje pradėkite naują ryšį.',
      'openvpn_recovery_exhausted':
          'Automatinis atkūrimas jau buvo panaudotas. Programoje pradėkite naują ryšį.',
      'vpn_permission_required':
          'Prieš paleisdamas tunelį Android reikalauja naujo VPN leidimo.',
      'vpn_permission_denied':
          'Norėdami tęsti, Android užklausoje leiskite FuzeVPN.',
      'vpn_permission_request_failed':
          'Android nepavyko atidaryti VPN leidimo ekrano.',
      'wireguard_foreground_service_unavailable':
          'Android nepavyko išlaikyti WireGuard paslaugos pirmame plane.',
      'wireguard_identity_invalid':
          'Šios paskyros šifruotas WireGuard raktas nenuskaitomas arba netinkamas.',
      'wireguard_identity_in_use':
          'Kitas veiksmas vis dar naudoja šios paskyros WireGuard raktą.',
      'wireguard_configuration_invalid':
          'Gautas WireGuard adresas, DNS, serverio raktas arba maršrutai yra netinkami.',
      'wireguard_operation_pending':
          'Ankstesnis WireGuard veiksmas dar neatlaisvino savo vietinės paslaugos.',
      'wireguard_start_failed':
          'WireGuard variklis atmetė konfigūracijos aktyvavimą.',
      'wireguard_stop_timeout':
          'WireGuard paslauga per nustatytą laiką nepatvirtino VPN sąsajos atlaisvinimo.',
      'wireguard_handshake_timeout':
          'Tunelis per nustatytą laiką nepatvirtino ryšio užmezgimo su serveriu.',
      'openvpn_connection_timeout':
          'OpenVPN per nustatytą laiką nepatvirtino ryšio su serveriu.',
      'openvpn_core_unavailable':
          'Šioje programos versijoje nėra tinkamo OpenVPN variklio.',
      'openvpn_operation_pending':
          'Vietinis variklis vis dar laiko ankstesnę OpenVPN sesiją ir atsisako sukurti antrą.',
      'openvpn_stop_timeout':
          'OpenVPN Core per nustatytą laiką nepatvirtino, kad jo vietinė sesija sustojo ir buvo sunaikinta.',
      'openvpn_profile_unavailable':
          'Šiam ryšiui negalima nuskaityti patikrinto OpenVPN profilio.',
      'openvpn_native_failed':
          'Programos klaida nutraukė OpenVPN. Bandykite prisijungti dar kartą. Jei problema išlieka, paleiskite diagnostiką.',
      'openvpn_key_generation_failed':
          'Android Keystore negalėjo sukurti arba perskaityti neeksportuojamo P-256 privataus rakto.',
      'openvpn_csr_generation_failed':
          'Android Keystore raktu nepavyko pasirašyti OpenVPN sertifikato užklausos.',
      'openvpn_identity_store_failed':
          'OpenVPN sertifikato ar profilio nepavyko išsaugoti šifruotoje saugykloje.',
      'openvpn_identity_clear_failed':
          'Android nepavyko pašalinti visos vietinės šios paskyros OpenVPN tapatybės.',
      'openvpn_identity_in_use':
          'Vietinė OpenVPN sesija vis dar naudoja šio įrenginio raktą arba sertifikatą.',
      'openvpn_tls_verification_required':
          'Profilyje aiškiai nenurodyta, kad reikia tikrinti serverio sertifikatą.',
      'openvpn_cipher_invalid':
          'Serveris pateikė šifravimo algoritmą, kurio nėra leidžiamų algoritmų sąraše.',
      'openvpn_profile_rejected':
          'Iš serverio gautas profilis nesuderinamas. Sukurkite šį įrenginį iš naujo ir bandykite dar kartą.',
      'openvpn_identity_inconsistent':
          'Sertifikatas neatitinka šio telefono saugios tapatybės. Vietinis profilis nebuvo pakeistas.',
      'tls_handshake_failed':
          'Serveris atmetė TLS derybas. Jei problema išlieka, sukurkite profilį iš naujo.',
      'tls_alert_unknown_ca':
          'Serveris nepripažįsta šio įrenginio sertifikato išdavėjo. Reikia patikrinti OpenVPN serverį.',
      'tls_alert_bad_certificate':
          'Serveris atmetė šį įrenginio sertifikatą. Prieš bandydami dar kartą, sukurkite įrenginį iš naujo.',
      'tls_alert_unsupported_certificate':
          'Serveris nepalaiko saugaus sertifikato tipo, kurį naudoja Android.',
      'tls_client_certificate_required':
          'Serveriui reikalingas kliento sertifikatas, bet OpenVPN Core nepavyko jo pateikti.',
      'tls_alert_misc':
          'Serveris grąžino TLS įspėjimą, kuris nepriklauso nei sertifikato, nei versijos kategorijai.',
      'tls_signature_algorithm_rejected':
          'Serveris atmetė Android Keystore rakto ECDSA P-256 algoritmą.',
      'tls_handshake_rejected':
          'Serveris nutraukė TLS derybas prieš prisijungiant.',
      'tls_version_rejected':
          'Klientas ir serveris nerado bendros TLS versijos.',
      'tls_certificate_expired':
          'Prisijungimo metu pateiktas sertifikatas jau nebegalioja.',
      'tls_certificate_revoked':
          'Prisijungimo metu pateiktas sertifikatas buvo atšauktas.',
      'transport_failed':
          'OpenVPN serveris dabartiniame tinkle neatsako. Netrukus bandykite dar kartą.',
      'tun_configuration_rejected':
          'Android atmetė tinklo konfigūraciją, kurios prašė OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core atmetė tinklo planą prieš kurdamas Android sąsają.',
      'tun_interface_create_failed':
          'OpenVPN Core nepavyko gauti TUN sąsajos iš Android VpnService.',
      'tun_interface_disabled':
          'Ryšio metu Android arba OpenVPN Core išjungė TUN sąsają.',
      'tun_halted': 'OpenVPN Core gavo užklausą sustabdyti TUN sąsają.',
      'tun_already_established':
          'OpenVPN tame pačiame ryšyje paprašė antros sąsajos. Saugumo sumetimais tunelis sustabdytas.',
      'tun_addresses_missing': 'Serveris nepateikė tinkamo tunelio adreso.',
      'tun_routes_missing': 'Serveris nepateikė tinkamų tunelio maršrutų.',
      'tun_dns_missing': 'Serveris nepateikė tinkamo DNS serverio.',
      'tun_permission_revoked': 'Ryšio metu Android panaikino VPN leidimą.',
      'tun_establish_returned_null':
          'Android nesukūrė sąsajos, dažniausiai todėl, kad kitas VPN vis dar aktyvus.',
      'openvpn_service_start_failed':
          'Android nepavyko paleisti OpenVPN paslaugos pirmame plane.',
      'openvpn_operation_timeout':
          'JNI iškvietimas į OpenVPN Core viršijo didžiausią leistiną trukmę.',
      'openvpn_start_failed':
          'Android paslauga paruošta, bet OpenVPN Core nepriėmė profilio paleidimo.',
      'openvpn_connection_failed':
          'OpenVPN Core sustojo prieš pateikdamas CONNECTED įvykį.',
      'openvpn_core_status_error':
          'Vietinis OpenVPN ciklas baigėsi klaida, nepateikdamas konkretesnio galutinio įvykio.',
      'openvpn_stopped_before_connected':
          'Vietinis OpenVPN ciklas sustojo prieš CONNECTED, be aiškios OpenVPN Core klaidos.',
      'openvpn_auth_failed':
          'OpenVPN serveris atmetė profilio autentifikavimą.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nepavyko paruošti kliento prieš prisijungiant prie tinklo.',
      'openvpn_client_halted':
          'OpenVPN Core gavo galutinę kliento sustabdymo užklausą.',
      'openvpn_client_restart':
          'OpenVPN Core paprašė iš naujo paleisti savo perdavimo sesiją.',
      'openvpn_inactive_timeout':
          'OpenVPN Core uždarė sesiją pasibaigus neveiklumo laikui.',
      'openvpn_session_expired':
          'Serveris pranešė, kad OpenVPN sesijos galiojimas baigėsi.',
      'openvpn_credentials_required':
          'Serveris arba tarpinis serveris reikalauja interaktyvių prisijungimo duomenų, kurių nėra šiame sertifikato profilyje.',
      'openvpn_proxy_failed':
          'OpenVPN Core pranešė apie sukonfigūruoto tarpinio serverio arba retransliatoriaus gedimą.',
      'openvpn_compression_failed':
          'OpenVPN Core atmetė profilio ar serverio paskelbtą suspaudimo režimą.',
      'openvpn_ntlm_crypto_unavailable':
          'Profilyje prašomas NTLM šifravimas šioje versijoje nepasiekiamas.',
      'openvpn_feature_unsupported':
          'Profiliui ar serveriui reikalinga funkcija, kurios nėra šiame Android kliente.',
      'network_unavailable': 'Nėra tinkamo fizinio tinklo.',
      'network_lost': 'Tunelis sustabdytas po to, kai prarastas tinklas.',
      'certificate_validation_failed':
          'Nepavyko patikrinti OpenVPN serverio tapatybės.',
      'openvpn_certificate_expired':
          'OpenVPN sertifikato galiojimas baigėsi. Norėdami atnaujinti sertifikatą, programoje pradėkite naują ryšį.',
      'tunnel_active_for_another_account':
          'Prieš šį ryšį turi būti sustabdytas kitos paskyros tunelis.',
      'tunnel_already_active':
          'Android praneša, kad ankstesnė VPN sesija vis dar naudoja sąsają.',
      'tunnel_stop_timeout':
          '$protocol variklis per nustatytą laiką nepatvirtino VPN sąsajos atlaisvinimo.',
      'tunnel_disconnected':
          'Vietinis variklis pranešė, kad tunelis netikėtai nutrūko po paleidimo.',
      'native_bridge_unavailable':
          'Programa negali pasiekti Android VPN paslaugos. Uždarykite ir iš naujo atidarykite programą, tada bandykite dar kartą.',
      'native_operation_failed':
          'Programos klaida nutraukė VPN veiksmą. Bandykite dar kartą. Jei problema išlieka, paleiskite diagnostiką.',
      'invalid_arguments':
          'Šiam VPN veiksmui reikalinga informacija yra neišsami. Bandykite dar kartą. Jei problema išlieka, paleiskite diagnostiką.',
      'invalid_account_id':
          'Vietinis veiksmas nesusietas su tinkamu paskyros identifikatoriumi.',
      'invalid_device_id':
          'Vietiniam varikliui perduoto įrenginio identifikatoriaus nėra arba jis netinkamas.',
      'storage_key_not_allowed':
          'Android tiltas užblokavo raktą, kurio nėra leidžiamų saugyklos raktų sąraše.',
      'secure_storage_read_failed':
          'Android Keystore negalėjo iššifruoti šios paskyros vietinių duomenų.',
      'secure_storage_write_failed':
          'Android Keystore negalėjo užšifruoti arba išsaugoti vietinių duomenų.',
      'key_generation_failed':
          'Android nepavyko sukurti arba perskaityti WireGuard rakto saugioje saugykloje.',
      'csr_generation_failed':
          'Android Keystore nepavyko sukurti arba pasirašyti OpenVPN P-256 CSR.',
      'other':
          'Įvyko nedokumentuota vietinė klaida. Išsiųskite toliau rodomą diagnostikos kodą palaikymo tarnybai.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Leidimo užklausa jau rodoma';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN leidimo užklausa jau rodoma. Prieš bandydami dar kartą, ją užbaikite.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN leidimo užklausa nutrūko';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN leidimo ekranas užsidarė, o programa nespėjo gauti atsakymo.';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN ryšys nepatvirtintas';

  @override
  String get notice_openvpnProofMissing_message =>
      'Nepavyko patvirtinti OpenVPN ryšio. Saugumo sumetimais jis sustabdytas. Bandykite dar kartą.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profilis panaikintas';

  @override
  String get openvpnCleanup_working =>
      'Sustabdomas ir pašalinamas panaikintas OpenVPN profilis…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN sustabdymas nepatvirtintas. Prieš kurdami naują profilį, bandykite dar kartą.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Panaikinto OpenVPN profilio nepavyko visiškai pašalinti. Bandykite išvalyti dar kartą.';

  @override
  String get openvpnCleanup_complete =>
      'Panaikintas OpenVPN profilis pašalintas. Palieskite „Prisijungti“, kad sukurtumėte naują.';

  @override
  String get network_title => 'Tinklo konfigūracija';

  @override
  String get network_ipv4Fallback =>
      'IPv6 laikinai nepasiekiamas. Ruošimas tęsiamas naudojant IPv4.';

  @override
  String get network_rejectedTitle => 'Tinklo konfigūracija atmesta';

  @override
  String get network_rejectedMessage =>
      'Tunelio konfigūracija neišsami arba neatitinka leistinų adresų. Bandykite dar kartą programoje.';

  @override
  String get network_unreadableTitle =>
      'Vietinės konfigūracijos nepavyksta nuskaityti';

  @override
  String get network_unreadableMessage =>
      'Išsaugotos OpenVPN tinklo konfigūracijos naudoti nepavyksta. Prisijunkite iš naujo programoje, kad ją atnaujintumėte.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Tinklo apsauga';

  @override
  String get protection_subtitle =>
      'Blokuoti tiesioginę prieigą prie interneto, jei VPN atsijungia.';

  @override
  String get protection_active => 'Sistemos apsauga įjungta';

  @override
  String get protection_alwaysOnOnly =>
      'Įjungta funkcija „Visada įjungtas VPN“; įjunkite blokavimą be VPN';

  @override
  String get protection_inactive => 'Sistemos apsauga išjungta';

  @override
  String get protection_unknown => 'Patikrinkite sistemos apsaugą';

  @override
  String get protection_openSettings => 'Atidaryti Android nustatymus';

  @override
  String get protection_dialogTitle => 'Nustatykite tinklo apsaugą';

  @override
  String get protection_dialogMessage =>
      'Android valdo funkciją „Visada įjungtas VPN“ ir ryšių blokavimą be VPN. Patikrinkite, ar pasirinktas FuzeVPN, ir sistemos nustatymuose įjunkite blokavimą.';

  @override
  String get protection_dialogOpen => 'Atidaryti nustatymus';

  @override
  String get session_systemProtectionNote =>
      'Jei Android vis dar blokuoja srautą be VPN, atidarykite sistemos nustatymus, kad patikrintumėte arba pakeistumėte šią apsaugą.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Programos diagnostika';

  @override
  String get diagnostics_automaticTitle => 'Siųsti svarbias klaidas';

  @override
  String get diagnostics_automaticDescription =>
      'Kai įvyksta svarbi klaida, išsiunčiama trumpa techninė ataskaita.';

  @override
  String get diagnostics_privacy =>
      'Išsiųstos ataskaitos susietos su prisijungusia paskyra ir saugomos 30 dienų. Jose nėra naršymo istorijos, slaptažodžių ar VPN raktų.';

  @override
  String get diagnostics_manualOpen => 'Paleisti diagnostiką';

  @override
  String get diagnostics_localDescription =>
      'Sukurkite programos ir VPN būsenos ataskaitą. Jūsų ryšys nepakis.';

  @override
  String get diagnostics_sendReport => 'Siųsti ataskaitą';

  @override
  String get diagnostics_sendHint =>
      'Palikite šį langelį nepažymėtą, kad ataskaita liktų šiame įrenginyje.';

  @override
  String get diagnostics_signedOut =>
      'Norėdami siųsti ataskaitą, prisijunkite prie paskyros.';

  @override
  String get diagnostics_localLifetime =>
      'Išsaugokite šią ataskaitą telefone, kad ji liktų uždarius programą.';

  @override
  String get diagnostics_run => 'Paleisti diagnostiką';

  @override
  String get diagnostics_rerun => 'Paleisti diagnostiką dar kartą';

  @override
  String get diagnostics_running => 'Tikrinama…';

  @override
  String get diagnostics_sending => 'Siunčiama ataskaita…';

  @override
  String get diagnostics_prepared => 'Ataskaita paruošta šiame įrenginyje';

  @override
  String get diagnostics_queued => 'Ataskaita laukia siuntimo';

  @override
  String get diagnostics_sent => 'Ataskaita gauta';

  @override
  String get diagnostics_failed =>
      'Nepavyko išsiųsti. Vietinė ataskaita vis dar pasiekiama.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostikos ataskaitos nepavyko paruošti. Bandykite dar kartą.';

  @override
  String get diagnostics_authenticationRequired =>
      'Prisijunkite dar kartą, kad išsiųstumėte ataskaitą.';

  @override
  String get diagnostics_retry => 'Bandyti siųsti dar kartą';

  @override
  String get diagnostics_export => 'Išsaugoti ataskaitą';

  @override
  String get diagnostics_exportFailed =>
      'Eksportuoti nepavyko. Bandykite dar kartą iš vietinės ataskaitos.';

  @override
  String get diagnostics_preferenceFailed =>
      'Šio nustatymo nepavyko išsaugoti. Bandykite dar kartą.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Ataskaitos numeris: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Gauta $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Saugoma iki $date';
  }

  @override
  String get diagnostics_duplicate => 'Ši ataskaita jau buvo gauta.';

  @override
  String get diagnostics_preview => 'Ataskaitos peržiūra';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pridėta $count techninių įvykių',
      few: 'Pridėti $count techniniai įvykiai',
      one: 'Pridėtas $count techninis įvykis',
      zero: 'Techninių įvykių nepridėta',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Techninė informacija';

  @override
  String get diagnostics_empty => 'Diagnostikos ataskaita dar nebuvo paruošta.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunelio būsena',
      'handshake': 'Ryšio patvirtinimas',
      'certificate': 'VPN sertifikatas',
      'kill_switch': 'Android apsauga',
      'connectivity': 'Pasiekiamas tinklas',
      'api_reachability': 'Prieiga prie paslaugos',
      'secure_storage': 'Saugi saugykla',
      'other': 'Vietinis patikrinimas',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Patikrinta',
      'failed': 'Reikia dėmesio',
      'skipped': 'Netestuota, aktyvaus patikrinimo nėra',
      'unknown': 'Informacija nepasiekiama',
      'other': 'Informacija nepasiekiama',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Sveiki atvykę į FuzeVPN';

  @override
  String get connection_changeLocation => 'Keisti vietą';

  @override
  String get connection_details => 'Ryšio informacija';

  @override
  String get locations_searchLabel => 'Ieškoti miesto ar šalies';

  @override
  String get locations_clearSearch => 'Išvalyti paiešką';

  @override
  String get locations_filterAll => 'Visos';

  @override
  String get locations_filterFavorites => 'Mėgstamiausios';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vietų',
      few: '$count vietos',
      one: '$count vieta',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Vietų nerasta';

  @override
  String get locations_noResultsHint => 'Pabandykite kitą miestą arba šalį.';

  @override
  String get locations_noFavorites => 'Mėgstamiausios vietos visada po ranka';

  @override
  String get locations_noFavoritesHint =>
      'Palieskite žvaigždutę šalia vietos, kad ji būtų išsaugota čia.';

  @override
  String get locations_showAll => 'Rodyti visas vietas';

  @override
  String locations_addFavorite(String name) {
    return 'Pridėti prie mėgstamiausių: $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Pašalinti iš mėgstamiausių: $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Mėgstamiausios vietos nepavyko išsaugoti. Bandykite dar kartą.';

  @override
  String get locations_emptyTitle => 'Vietų nėra';

  @override
  String get locations_emptyHint =>
      'Atnaujinkite sąrašą ir bandykite dar kartą.';

  @override
  String get devices_manage => 'Tvarkyti mano įrenginius';

  @override
  String get settings_personalization => 'Pritaikykite sau';

  @override
  String get settings_safety => 'Apsauga';

  @override
  String get settings_help => 'Reikia pagalbos?';

  @override
  String get settings_about => 'Apie FuzeVPN';

  @override
  String get diagnostics_heading => 'Išsiaiškinkite ryšio problemą';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Pasiekiamas',
      'pending': 'Ruošiamas',
      'revoked': 'Pašalintas',
      'expired': 'Nebegalioja',
      'other': 'Būsena nepasiekiama',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Nuostata neišsaugota';

  @override
  String get notice_preferenceSave_message =>
      'Jūsų pasirinkimas kol kas taikomas, bet nepavyko jo išsaugoti. Bandykite dar kartą, kad jis liktų uždarius programą.';

  @override
  String get connection_androidDisconnectHint =>
      'Jei Android palieka VPN aktyvų, atsidariusiuose nustatymuose išjunkite „Visada įjungtas VPN“.';

  @override
  String get connection_certificate => 'OpenVPN sertifikatas';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Galioja iki $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Galiojimas baigėsi $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Bus automatiškai atnaujintas kitą kartą prisijungiant.';

  @override
  String get protection_learnMore => 'Sužinokite daugiau apie Android apsaugą';

  @override
  String get protection_guideWhy =>
      'Ši apsauga neleidžia programoms tiesiogiai naudotis internetu, jei VPN atsijungia. Ji nustatoma Android sistemoje.';

  @override
  String get protection_guideAlwaysOnTitle => 'Visada įjungtas VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android nuolat laiko VPN paslaugą įjungtą ir gali ją vėl paleisti perkrovus telefoną.';

  @override
  String get protection_guideBlockTitle => 'Blokuoti ryšius be VPN';

  @override
  String get protection_guideBlock =>
      'Šis nustatymas neleidžia srautui apeiti VPN, taip pat ir tada, kai ryšys nutrūksta.';

  @override
  String get protection_guideWarning =>
      'Įjungus šį blokavimą, internetas neveiks, kol nebus prisijungta prie VPN.';

  @override
  String get protection_guideStepsTitle => 'Įjunkite apsaugą';

  @override
  String get protection_guideStep1 =>
      'Žemiau esančiu mygtuku atidarykite Android VPN nustatymus.';

  @override
  String get protection_guideStep2 =>
      'Palieskite krumpliaračio piktogramą šalia FuzeVPN, kad atidarytumėte parinktis.';

  @override
  String get protection_guideStep3 =>
      'Įjunkite „Visada įjungtas VPN“, tada – „Blokuoti ryšius be VPN“, jei šios parinktys pasiekiamos.';

  @override
  String get protection_guideManufacturers =>
      'Pavadinimai skiriasi priklausomai nuo telefono. Jei reikia, nustatymuose ieškokite „VPN“, dažniausiai skiltyje „Tinklas ir internetas“.';

  @override
  String get protection_guideDisableTitle => 'Išjunkite šią apsaugą';

  @override
  String get protection_guideDisable =>
      'Tuose pačiuose nustatymuose išjunkite blokavimą be VPN, kad būtų galima naudotis internetu be VPN. Taip pat išjunkite „Visada įjungtas VPN“, jei nebenorite, kad Android jį paleistų iš naujo.';

  @override
  String get protection_guideManual =>
      'Šiuos nustatymus pasirenkate Android sistemoje. FuzeVPN jų už jus nekeičia.';

  @override
  String get locations_changeTitle => 'Keisti vietą?';

  @override
  String locations_changeActive(String name) {
    return 'VPN atsijungs, tada bandys prisijungti prie vietos: $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN bandys prisijungti prie vietos: $name.';
  }

  @override
  String get locations_confirmChange => 'Keisti ir prisijungti';

  @override
  String get locations_changeBusy =>
      'Vyksta vietos keitimas. Prieš pasirinkdami kitą vietą, palaukite.';

  @override
  String get locations_automaticSelection => 'Automatinis pasirinkimas';

  @override
  String get locations_cities => 'Miestai';

  @override
  String get locations_servers => 'Serveriai';

  @override
  String locations_viewCities(String name) {
    return 'Peržiūrėti miestus: $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Peržiūrėti serverius: $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count šalių',
      few: '$count šalys',
      one: '$count šalis',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miestų',
      few: '$count miestai',
      one: '$count miestas',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serverių',
      few: '$count serveriai',
      one: '$count serveris',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Visos šalys';

  @override
  String get locations_backToCountries => 'Grįžti į šalis';

  @override
  String locations_backToCities(String name) {
    return 'Grįžti į miestus: $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Pasirinkti: $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Pasirinkti: $name';
  }

  @override
  String get locations_noCompatibleServer => 'Nėra suderinamo serverio.';

  @override
  String get externalLink_failed =>
      'Nepavyko atidaryti šios nuorodos. Ją galite nukopijuoti ir atidaryti naršyklėje.';

  @override
  String get externalLink_copy => 'Kopijuoti nuorodą';

  @override
  String get externalLink_copied => 'Nuoroda nukopijuota';

  @override
  String get externalLink_copyFailed =>
      'Nepavyko nukopijuoti nuorodos. Pažymėkite toliau pateiktą adresą.';

  @override
  String get settings_deleteAccount => 'Ištrinti mano paskyrą';

  @override
  String get settings_deleteAccountDetail =>
      'Peržiūrėkite paskyros ištrynimo prašymo tvarką';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Pasirinkite VPN prenumeratą.';

  @override
  String get billing_subscribe => 'Prenumeruoti';

  @override
  String get billing_choosePlan => 'Norėdami tęsti, pasirinkite planą.';

  @override
  String get billing_monthly => 'Mėnesinis';

  @override
  String get billing_yearly => 'Metinis';

  @override
  String get billing_continue => 'Tęsti naudojant Google Play';

  @override
  String get billing_restore => 'Atkurti pirkinius';

  @override
  String get billing_manage => 'Tvarkyti prenumeratą';

  @override
  String get billing_deleteAccountWarning =>
      'Jei turite Google Play prenumeratą, ištrynus FuzeVPN paskyrą, jos atnaujinimas nebus atšauktas. Atnaujinimą tvarkykite arba atšaukite atskirai Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Pereiti prie paskyros ištrynimo prašymo';

  @override
  String get billing_refresh => 'Atnaujinti prieigą';

  @override
  String get billing_loadingPlans => 'Įkeliami planai…';

  @override
  String get billing_unavailable =>
      'Šiuo metu planai nepasiekiami. Bandykite vėliau.';

  @override
  String get billing_comingSoon => 'Prenumeratos netrukus bus galimos.';

  @override
  String get billing_priceDisclosure =>
      'Kainą pateikia Google Play. Galutinė suma ir taikomi mokesčiai nurodomi prieš jums patvirtinant pirkimą.';

  @override
  String get billing_renewalMonthly =>
      'Prenumerata automatiškai atnaujinama kas mėnesį, nebent ją atšauksite. Galite ją bet kada atšaukti Google Play prenumeratų skiltyje.';

  @override
  String get billing_renewalYearly =>
      'Prenumerata automatiškai atnaujinama kas metus, nebent ją atšauksite. Galite ją bet kada atšaukti Google Play prenumeratų skiltyje.';

  @override
  String get billing_active => 'Jūsų Premium prieiga aktyvi';

  @override
  String billing_accessUntil(String date) {
    return 'Prieiga galioja iki $date.';
  }

  @override
  String get billing_webManaged =>
      'Jūsų prenumerata tvarkoma FuzeVPN svetainėje.';

  @override
  String get billing_playManaged => 'Jūsų prenumerata tvarkoma Google Play.';

  @override
  String get billing_playOnHold =>
      'Jūsų Google Play prenumerata sustabdyta arba laukia mokėjimo. Atidarykite „Tvarkyti prenumeratą“, kad tai ištaisytumėte Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Šioje Google Play paskyroje jau yra Fuze Premium prenumerata, kuri nėra aktyvi šiai FuzeVPN paskyrai. Atidarykite „Tvarkyti prenumeratą“, kad ją peržiūrėtumėte Google Play.';

  @override
  String get billing_inactive => 'Aktyvios prenumeratos nėra.';

  @override
  String get billing_checkingAccess => 'Tikrinama jūsų prieiga…';

  @override
  String get billing_restoring => 'Atkuriami pirkiniai…';

  @override
  String get billing_pending =>
      'Laukiama mokėjimo patvirtinimo. Jūsų prieiga bus aktyvuota jį patvirtinus.';

  @override
  String get billing_cancelled =>
      'Pirkimas atšauktas. Nauja prenumerata nebuvo aktyvuota.';

  @override
  String get billing_verifying => 'Tikrinamas pirkimas…';

  @override
  String get billing_success =>
      'Prenumerata aktyvuota. Jūsų Premium prieiga paruošta.';

  @override
  String get billing_restored => 'Jūsų pirkiniai atkurti.';

  @override
  String get billing_restoreEmpty =>
      'Šioje Google Play paskyroje nėra pirkinių, kuriuos būtų galima atkurti.';

  @override
  String get billing_catalogError =>
      'Nepavyko įkelti planų. Bandykite dar kartą.';

  @override
  String get billing_purchaseError =>
      'Nepavyko pradėti pirkimo. Bandykite dar kartą.';

  @override
  String get billing_verificationError =>
      'Pirkimo patikra laikinai nepasiekiama. Norėdami bandyti dar kartą, atkurkite pirkinius.';

  @override
  String get billing_restoreError =>
      'Nepavyko atkurti pirkinių. Bandykite dar kartą.';

  @override
  String get billing_managementError =>
      'Nepavyko atidaryti prenumeratos tvarkymo. Bandykite dar kartą.';

  @override
  String get billing_storeUnavailable =>
      'Šiame įrenginyje Google Play nepasiekiama.';

  @override
  String get welcome_title => 'Jūsų VPN – paprasta.';

  @override
  String get welcome_description =>
      'Apsaugokite savo ryšį. Kontroliuokite savo privatumą.';

  @override
  String get welcome_start => 'Pradėti';

  @override
  String get welcome_alreadyPurchased => 'Jau įsigijote?';

  @override
  String get welcome_noAccountRequired => 'Norint pradėti, paskyros nereikia.';

  @override
  String get guest_accountTitle => 'Paskyra nesusieta';

  @override
  String get guest_accountDescription =>
      'Atkurkite pirkinius naudodami tą pačią Google Play paskyrą, kad galėtumėte prenumeratą naudoti kitame įrenginyje.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Jau prenumeruojate? Prisijunkite prie paskyros';

  @override
  String get guest_claimTitle => 'Naudokite FuzeVPN visur';

  @override
  String get guest_claimDescription =>
      'Sukurkite paskyrą, kad prenumeratą galėtumėte naudoti kituose įrenginiuose. Šis žingsnis neprivalomas.';

  @override
  String get guest_skip => 'Galbūt vėliau';

  @override
  String get guest_activationTitle => 'Fuze Premium aktyvuotas';

  @override
  String get guest_activationDescription =>
      'Jūsų prenumerata paruošta. Naudokite VPN ir sukurkite paskyrą, kada tik norite.';

  @override
  String get guest_useVpn => 'Naudoti VPN';

  @override
  String get guest_loginRequired =>
      'Šis pirkinys jau susietas su FuzeVPN paskyra. Prisijunkite prie tos paskyros, kad pasiektumėte prenumeratą.';

  @override
  String get guest_signOutWarning =>
      'Prenumeratą galite atgauti atkurdami pirkinius su ta pačia Google Play paskyra.';

  @override
  String get guest_profileUnavailable =>
      'Jūsų paskyra jau susieta. Prisijunkite, kad galėtumėte peržiūrėti ir tvarkyti savo duomenis.';

  @override
  String get billing_acceptance =>
      'Tęsdami sutinkate su naudojimo sąlygomis ir privatumo politika.';

  @override
  String get guest_verifyEmailReminder =>
      'Patvirtinkite el. pašto adresą, kad apsaugotumėte paskyrą. VPN galite toliau naudoti.';

  @override
  String get guest_serviceUnavailable =>
      'Paslauga laikinai nepasiekiama. Netrukus bandykite dar kartą.';

  @override
  String get guest_restoreError =>
      'Nepavyko atkurti pirkinių. Bandykite dar kartą su ta Google Play paskyra, kuria atliktas pirkimas.';

  @override
  String get guest_claimSuccess =>
      'Paskyra sukurta. Jūsų prenumerata ir VPN prieiga išlieka.';

  @override
  String get guest_emailExists =>
      'Šis el. paštas jau naudojamas. Pasirinkite kitą adresą arba prisijunkite prie esamos paskyros. Jūsų pirkinys ir toliau pasiekiamas per Google Play.';

  @override
  String get guest_claimError =>
      'Nepavyko sukurti paskyros. VPN galite toliau naudoti ir bandyti vėliau.';

  @override
  String get guest_secureStorageError =>
      'Šiame įrenginyje nepavyko apsaugoti sesijos. Bandykite dar kartą.';

  @override
  String get guest_premiumRequired =>
      'Pasirinkite prenumeratą, kad aktyvuotumėte VPN.';

  @override
  String get welcome_viewPlans => 'Peržiūrėti planus';

  @override
  String get google_continue => 'Tęsti naudojant Google';

  @override
  String get google_or => 'arba';

  @override
  String get google_title => 'Jūsų FuzeVPN paskyra';

  @override
  String get google_settingUp => 'Užbaikite paskyros kūrimą';

  @override
  String get google_country => 'Gyvenamoji šalis';

  @override
  String get google_profileDescription =>
      'Pasirinkite savo šalį ir peržiūrėkite du dokumentus, kad sukurtumėte FuzeVPN paskyrą.';

  @override
  String get google_claimDescription =>
      'Susiekite svečio paskyrą su Google. Jūsų prenumerata ir įrenginys lieka susieti su šia paskyra.';

  @override
  String get google_linkTitle => 'Susieti Google su FuzeVPN';

  @override
  String get google_linkDescription =>
      'Patvirtinkite prieigą prie esamos FuzeVPN paskyros. Šis žingsnis nereikalauja jūsų Google slaptažodžio.';

  @override
  String get google_password => 'FuzeVPN slaptažodis';

  @override
  String get google_linkAccount => 'Patvirtinti susiejimą';

  @override
  String get google_requestEmail => 'Siųsti man patvirtinimo el. laišką';

  @override
  String get google_emailInstructions =>
      'Atidarykite FuzeVPN el. laišką ir įveskite patvirtinimo kodą.';

  @override
  String get google_emailCode => 'El. laiško patvirtinimo kodas';

  @override
  String get google_confirmEmail => 'Patvirtinti kodą';

  @override
  String get google_restart => 'Pasirinkti kitą Google paskyrą';

  @override
  String get google_resume => 'Patikrinti šį bandymą';

  @override
  String get google_unavailable =>
      'Prisijungimas per Google nepasiekiamas. Galite naudoti el. paštą ir slaptažodį.';

  @override
  String get google_expired =>
      'Šio bandymo galiojimas baigėsi. Atšaukite jį ir pradėkite iš naujo.';

  @override
  String get google_conflict =>
      'Ši Google paskyra jau susieta kitur. Jūsų dabartinė paskyra ir prenumerata išlieka.';

  @override
  String get google_error =>
      'Prisijungti per Google nepavyko. Bandykite dar kartą; dabartinė prieiga išlieka.';

  @override
  String get google_uncertain =>
      'Rezultato nepavyko patvirtinti. Patikrinkite šį bandymą arba jį atšaukite prieš pradėdami iš naujo.';

  @override
  String get google_cancelFailed =>
      'Atšaukimo nepavyko patvirtinti. Prieš išeidami iš šio ekrano, bandykite atšaukti dar kartą.';

  @override
  String get google_cancelled => 'Prisijungimas per Google atšauktas.';

  @override
  String get google_selecting => 'Pasirinkite savo Google paskyrą…';

  @override
  String get google_verifying => 'Tikrinama jūsų paskyra…';

  @override
  String get google_emailUnavailable =>
      'Patvirtinimo laiško nepavyko išsiųsti. Bandykite vėliau.';

  @override
  String get google_emailSent =>
      'Patvirtinimo laiškas išsiųstas. Patikrinkite gautuosius.';

  @override
  String get google_rateLimited => 'Prieš bandydami dar kartą, palaukite.';

  @override
  String get google_busy =>
      'Google nepasiekiama, kol vykdomas kitas veiksmas (VPN ryšys, paskyra arba svečio paskyra). Bandykite dar kartą, kai jis bus baigtas; dabartinė prieiga išlieka.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN slaptažodis neteisingas. Jūsų dabartinė paskyra išlieka.';

  @override
  String get google_invalidCode =>
      'Patvirtinimo kodas neteisingas arba nebegalioja.';

  @override
  String get google_accountChanged =>
      'Jūsų sesija pasikeitė. Prieš pradėdami iš naujo, atšaukite šį bandymą.';

  @override
  String get google_invalidResponse =>
      'Atsakymo nepavyko patikrinti. Jūsų dabartinė prieiga išlieka.';

  @override
  String get google_invalidRegistration =>
      'Patikrinkite šalį ir abu sutikimus.';

  @override
  String get google_consentRequired =>
      'Norėdami tęsti, pasirinkite šalį ir sutikite su abiem dokumentais.';

  @override
  String get google_challengeRequired =>
      'Reikalinga papildoma saugumo patikra. Jūsų dabartinė prieiga išlieka.';

  @override
  String get google_challengeUnavailable =>
      'Saugumo patikra nepasiekiama. Bandykite vėliau.';

  @override
  String get google_intentMismatch =>
      'Ankstesnis prisijungimo per Google bandymas vis dar neužbaigtas. Prieš pradėdami šį veiksmą, atšaukite jį.';

  @override
  String get google_challengeBlocked =>
      'Šioje programoje nepasiekiama reikiama saugumo patikra. Šio veiksmo šiuo metu negalima užbaigti.';

  @override
  String get google_solveChallenge => 'Atlikti saugumo patikrą';

  @override
  String get google_challengeTitle => 'Saugumo patikra';

  @override
  String get google_challengeReady =>
      'Patikra atlikta. Dabar galite patvirtinti paskyros kūrimą.';

  @override
  String get google_challengeExpired =>
      'Patikros galiojimas baigėsi. Prieš patvirtindami, atlikite ją dar kartą.';

  @override
  String get google_challengeCancelled =>
      'Patikra atšaukta. Galite bandyti dar kartą.';

  @override
  String get google_challengeFailed =>
      'Nepavyko atlikti saugumo patikros. Bandykite dar kartą.';

  @override
  String get billing_trialTitle => 'Išbandykite Fuze Premium nemokamai';

  @override
  String get billing_trialSubtitle => 'Apsaugokite savo ryšį jau šiandien.';

  @override
  String get billing_trialWeeks =>
      '2 savaičių nemokamas bandomasis laikotarpis';

  @override
  String billing_trialDays(String days) {
    return 'Nemokamas bandomasis laikotarpis: $days d.';
  }

  @override
  String get billing_trialStart => 'Pradėti nemokamą bandymą';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Jei pradėsite šiandien, pirmasis mokėjimas numatomas $date.';
  }

  @override
  String get billing_trialTerms =>
      'Prenumerata automatiškai atnaujinama nurodyta kaina. Kad išvengtumėte mokėjimo, atšaukite ją Google Play prieš pasibaigiant bandomajam laikotarpiui.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Vėliau $price per mėnesį';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Vėliau $price per metus';
  }

  @override
  String get billing_choosePeriod => 'Pasirinkite planą';

  @override
  String get billing_selectionHint => 'Norėdami tęsti, pasirinkite planą.';

  @override
  String get billing_benefitConnection => 'Šifruotas ryšys';

  @override
  String get billing_benefitPrivacy => 'Privatumas internete';

  @override
  String get billing_benefitNoAccount => 'Registracijos nereikia';

  @override
  String get billing_cancellation => 'Atšaukimas per Google Play';

  @override
  String get billing_premiumTitle => 'Geriau apsaugotas ryšys.';

  @override
  String get billing_premiumSubtitle => 'Apsaugokite ryšį savo tempu.';

  @override
  String get billing_priceMonthly => 'per mėnesį';

  @override
  String get billing_priceYearly => 'per metus';

  @override
  String get billing_trialToday => 'Šiandien mokėti nereikia';

  @override
  String get billing_trialConfirmation =>
      'Prieš jums patvirtinant, Google Play nurodo datas, galutinę sumą ir taikomus mokesčius.';

  @override
  String get billing_offerChanged =>
      'Šio pasiūlymo sąlygos pasikeitė. Atnaujinkite planus ir pasirinkite iš naujo.';

  @override
  String get status_waitingNetwork => 'Laukiama tinklo';

  @override
  String get status_waitingNetworkDetail =>
      'Nėra pasiekiamo tinklo. VPN patikrins ryšį, kai tinklas vėl bus pasiekiamas.';

  @override
  String get locations_favoriteLoadFailed =>
      'Mėgstamiausių vietų nepavyko įkelti. Bandykite dar kartą.';

  @override
  String get locations_favoritesLoading => 'Įkeliamos mėgstamiausios vietos…';
}
