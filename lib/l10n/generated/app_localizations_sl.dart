// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Zaščitite svojo povezavo';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN uporablja storitev VPN sistema Android (VpnService), da ustvari šifriran tunel med to napravo in strežniki FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Ko je VPN aktiven, internetni promet vaših aplikacij, ciljni naslovi in poizvedbe DNS potekajo prek tega tunela za usmerjanje vaše povezave, tudi ko je FuzeVPN v ozadju.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikacija uporablja stanje povezave, njeno trajanje in količino prenesenih podatkov za prikaz vaše povezave VPN. Povezavo lahko kadar koli prekinete.';

  @override
  String get vpnDisclosure_privacy => 'Zasebnost';

  @override
  String get vpnDisclosure_accept => 'Sprejmi in nadaljuj';

  @override
  String get vpnDisclosure_decline => 'Ne zdaj';

  @override
  String get accountRestoration_title => 'Račun začasno ni na voljo';

  @override
  String get accountRestoration_message =>
      'Vaša seja je ohranjena. Poskusite znova, da obnovite račun. Povezavo VPN lahko še vedno upravljate tukaj.';

  @override
  String get action_retry => 'Poskusi znova';

  @override
  String get session_endingTitle => 'Zaključevanje seje';

  @override
  String get session_ending =>
      'Zaključevanje seje: ustavljanje VPN-ja in čiščenje…';

  @override
  String get session_stopFailed =>
      'Ustavitev VPN-ja ni potrjena. Pred ponovno prijavo poskusite znova.';

  @override
  String get session_cleanupFailed =>
      'VPN je ustavljen, vendar odstranitev seje ni potrjena. Ponovite čiščenje.';

  @override
  String get session_retryStop => 'Ponovi ustavitev';

  @override
  String get session_retryCleanup => 'Ponovi čiščenje';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN se varno pripravlja…';

  @override
  String get nav_connection => 'Povezava';

  @override
  String get nav_locations => 'Lokacije';

  @override
  String get nav_account => 'Račun';

  @override
  String get nav_devices => 'Naprave';

  @override
  String get nav_settings => 'Nastavitve';

  @override
  String get action_refresh => 'Osveži';

  @override
  String get auth_tab_login => 'Prijava';

  @override
  String get auth_tab_register => 'Registracija';

  @override
  String get auth_stepAccount => 'Račun';

  @override
  String get auth_stepIdentity => 'Identiteta';

  @override
  String get auth_stepAddress => 'Naslov in soglasja';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Korak $current od $total';
  }

  @override
  String get auth_tagline => 'Vaš VPN, brez zapletov.';

  @override
  String get auth_keysLocal =>
      'Vaši zasebni ključi VPN ostanejo v tej napravi.';

  @override
  String get form_email => 'E-poštni naslov';

  @override
  String get form_password => 'Geslo';

  @override
  String get form_showPassword => 'Prikaži geslo';

  @override
  String get form_hidePassword => 'Skrij geslo';

  @override
  String get form_passwordMin =>
      '8–72 bajtov UTF-8. Nekateri znaki zasedejo več bajtov.';

  @override
  String get form_firstName => 'Ime';

  @override
  String get form_lastName => 'Priimek';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Naslov';

  @override
  String get form_address2 => 'Dodatek k naslovu (neobvezno)';

  @override
  String get form_postalCode => 'Poštna številka';

  @override
  String get form_city => 'Mesto';

  @override
  String get form_country => 'Oznaka države (npr. FR)';

  @override
  String get action_login => 'Prijava';

  @override
  String get action_createAccount => 'Ustvari račun';

  @override
  String get action_createMyAccount => 'Ustvari moj račun';

  @override
  String get action_next => 'Nadaljuj';

  @override
  String get action_previous => 'Nazaj';

  @override
  String get action_forgotPassword => 'Ste pozabili geslo?';

  @override
  String get auth_noAccount => 'Še nimate računa?';

  @override
  String get auth_requiredInformation => 'Ustvarite račun v treh korakih.';

  @override
  String get auth_termsPrefix => 'Sprejemam ';

  @override
  String get auth_termsLink => 'pogoje uporabe';

  @override
  String get auth_privacyPrefix => 'Sprejemam ';

  @override
  String get auth_privacyLink => 'politiko zasebnosti';

  @override
  String get auth_consentRequired =>
      'Za ustvarjanje računa je potrebno vaše soglasje.';

  @override
  String get validation_required => 'To polje je obvezno.';

  @override
  String get validation_email => 'Vnesite veljaven e-poštni naslov.';

  @override
  String get validation_password => 'Geslo je prekratko: vsaj 8 bajtov UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Geslo je predolgo: največ 72 bajtov UTF-8.';

  @override
  String get validation_phone =>
      'Uporabite mednarodno obliko, na primer +33612345678.';

  @override
  String get validation_country =>
      'Uporabite dvočrkovno oznako države, na primer FR.';

  @override
  String get passwordReset_title => 'Ponastavitev gesla';

  @override
  String get passwordReset_description =>
      'Vnesite e-poštni naslov svojega računa, da zahtevate povezavo za ponastavitev gesla.';

  @override
  String get passwordReset_send => 'Pošlji povezavo';

  @override
  String get connection_title => 'Vaša povezava';

  @override
  String get connection_subtitle => 'Izberite lokacijo in nato vklopite VPN.';

  @override
  String get connection_prepare => 'Ste pripravljeni na povezavo?';

  @override
  String get connection_advancedOptions => 'Napredne možnosti';

  @override
  String get connection_location => 'Lokacija';

  @override
  String get connection_chooseLocation => 'Izberite lokacijo';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Poveži';

  @override
  String get connection_connecting => 'Povezovanje…';

  @override
  String get connection_disconnect => 'Prekini povezavo';

  @override
  String get connection_disconnecting => 'Prekinjanje povezave';

  @override
  String get connection_locationChange => 'Spreminjanje lokacije…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ni na voljo';
  }

  @override
  String get connection_activeLocation => 'Aktivna lokacija';

  @override
  String get connection_duration => 'Trajanje';

  @override
  String get connection_received => 'Prejeto';

  @override
  String get connection_sent => 'Poslano';

  @override
  String get connection_lastHandshake => 'Zadnja varna izmenjava';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Pred $duration';
  }

  @override
  String get verification_title => 'Potrdite svoj e-poštni naslov';

  @override
  String get verification_message =>
      'Potrdite svoj e-poštni naslov, če želite v tem telefonu uporabljati VPN.';

  @override
  String get verification_resend => 'Pošlji e-pošto znova';

  @override
  String get migration_title => 'Sprememba lokacije';

  @override
  String get migration_draining => 'Priprava spremembe lokacije…';

  @override
  String get migration_activating => 'Aktiviranje novega strežnika…';

  @override
  String get migration_ready => 'Lokacija je posodobljena.';

  @override
  String get migration_blocked =>
      'Za spremembo lokacije je potreben poseg na strežniku. Poskusite znova pozneje ali se obrnite na podporo.';

  @override
  String get migration_progress => 'Napredek spremembe lokacije';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Zamik med preverjanji: $seconds s.';
  }

  @override
  String get migration_resume => 'Nadaljuj spremembo lokacije';

  @override
  String get status_authorizing => 'Potrebno dovoljenje';

  @override
  String get status_authorizingDetail =>
      'Sprejmite zahtevo sistema Android, da dovolite VPN.';

  @override
  String get status_preparing => 'Priprava';

  @override
  String get status_preparingDetail => 'Vaša varna povezava se pripravlja.';

  @override
  String get status_reconnecting => 'Ponovno povezovanje…';

  @override
  String get status_reconnectingDetail =>
      'Povezava je prekinjena. VPN se poskuša ponovno povezati.';

  @override
  String get status_connecting => 'Povezovanje';

  @override
  String get status_connectingDetail => 'Povezovanje s strežnikom VPN…';

  @override
  String get status_connected => 'Povezano';

  @override
  String get status_connectedDetail => 'Vaša povezava VPN je aktivna.';

  @override
  String get status_disconnecting => 'Prekinjanje povezave';

  @override
  String get status_disconnectingDetail => 'Vaša povezava VPN se prekinja.';

  @override
  String get status_error => 'Povezava ni na voljo';

  @override
  String get status_errorDetail => 'Povezava VPN ni potrjena. Poskusite znova.';

  @override
  String get status_idle => 'Ni povezano';

  @override
  String get status_idleDetail => 'Povežite VPN, da zaščitite svojo povezavo.';

  @override
  String get trust_note =>
      'Zapiranje aplikacije ne ustavi VPN-ja. Če ga želite ustaviti, uporabite možnost Prekini povezavo.';

  @override
  String get locations_none => 'Trenutno ni na voljo nobene lokacije.';

  @override
  String get locations_available => 'Izberite naslednjo lokacijo.';

  @override
  String get locations_selected => 'Izbrana lokacija';

  @override
  String get locations_select => 'Izberi to lokacijo';

  @override
  String get locations_lockedTunnel =>
      'Za spremembo lokacije prekinite povezavo VPN.';

  @override
  String get locations_lockedMigration =>
      'Počakajte, da se sprememba lokacije konča.';

  @override
  String get devices_title => 'Vaše naprave';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit naprav';
  }

  @override
  String get devices_refresh => 'Osveži naprave';

  @override
  String get devices_empty => 'Še ni registrirane nobene naprave VPN.';

  @override
  String get devices_firstConnection =>
      'Vaš telefon bo dodan ob prvi povezavi.';

  @override
  String get devices_thisDevice => 'Ta naprava';

  @override
  String devices_added(Object date) {
    return 'Dodano $date';
  }

  @override
  String get devices_unnamed => 'Naprava brez imena';

  @override
  String get action_remove => 'Odstrani';

  @override
  String get settings_title => 'Nastavitve';

  @override
  String get settings_subtitle => 'Vaše nastavitve in račun na enem mestu.';

  @override
  String get settings_appearance => 'Videz';

  @override
  String get settings_language => 'Jezik';

  @override
  String get settings_languageDescription =>
      'Izbrani jezik velja tudi za obvestila VPN.';

  @override
  String get settings_account => 'Račun';

  @override
  String get settings_signOut => 'Odjava';

  @override
  String get settings_privacy => 'Politika zasebnosti';

  @override
  String get settings_terms => 'Pogoji uporabe';

  @override
  String get settings_security => 'Varnost in preglednost';

  @override
  String get settings_licenses => 'Licence komponent';

  @override
  String get settings_licensesDetail =>
      'Programska oprema, uporabljena v aplikaciji';

  @override
  String settings_licensesLegalese(String url) {
    return 'Izvorna koda aplikacije in njenih komponent z licenco MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN ostane vklopljen, ko zapustite aplikacijo. Če ga želite ustaviti, na zavihku Povezava uporabite možnost Prekini povezavo.';

  @override
  String get theme_system => 'Sistemska';

  @override
  String get theme_light => 'Svetla';

  @override
  String get theme_dark => 'Temna';

  @override
  String get language_system => 'Jezik telefona';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Želite odstraniti to napravo?';

  @override
  String get dialog_removeCurrent =>
      'Ta telefon bo prekinil povezavo z VPN-jem in izgubil dostop. Podatki njegove povezave VPN bodo odstranjeni, ko strežnik to potrdi.';

  @override
  String dialog_removeOther(Object name) {
    return 'Dostop do VPN-ja za „$name“ bo preklican. Tega dejanja ni mogoče razveljaviti.';
  }

  @override
  String get dialog_signOut => 'Želite se odjaviti?';

  @override
  String get dialog_signOutMessage =>
      'VPN se bo ustavil, zato se boste morali znova prijaviti. Šifrirani ključi VPN bodo za vašo naslednjo povezavo ostali v tem telefonu.';

  @override
  String get action_cancel => 'Prekliči';

  @override
  String get action_close => 'Zapri';

  @override
  String get action_copy => 'Kopiraj';

  @override
  String get action_signOut => 'Odjava';

  @override
  String get notice_close => 'Zapri sporočilo';

  @override
  String get notice_sessionExpired_title => 'Seja je potekla';

  @override
  String get notice_sessionExpired_message =>
      'Vaša seja je potekla. Znova se prijavite.';

  @override
  String get notice_connectionFailed_title => 'Povezava ni uspela';

  @override
  String get notice_invalidCredentials_message =>
      'Napačen e-poštni naslov ali geslo.';

  @override
  String get notice_emailVerification_title =>
      'Potrebna je potrditev e-poštnega naslova';

  @override
  String get notice_emailVerification_message =>
      'Pred dodajanjem naprave VPN potrdite svoj e-poštni naslov.';

  @override
  String get notice_rateLimited_title => 'Preveč poskusov';

  @override
  String get notice_deviceLimit_title => 'Dosežena omejitev naprav';

  @override
  String get notice_deviceLimit_message =>
      'Pred dodajanjem nove naprave odstranite eno obstoječo.';

  @override
  String get notice_identityRenewal_title => 'Identiteto VPN je treba obnoviti';

  @override
  String get notice_identityRenewal_message =>
      'Ta identiteta je bila odstranjena. Ustvarite novo lokalno identiteto.';

  @override
  String get notice_migrationPending_title => 'Sprememba lokacije poteka';

  @override
  String get notice_migrationPending_message => 'Sprememba lokacije že poteka.';

  @override
  String get notice_migrationBlocked_title => 'Sprememba lokacije je blokirana';

  @override
  String get notice_migrationBlocked_message =>
      'Za spremembo lokacije je potreben poseg na strežniku. Poskusite znova pozneje ali se obrnite na podporo.';

  @override
  String get notice_targetUnavailable_title => 'Strežnik začasno ni na voljo';

  @override
  String get notice_targetUnavailable_message =>
      'Ta strežnik začasno ni na voljo.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetna povezava ni na voljo';

  @override
  String get notice_networkUnavailable_message =>
      'Preverite povezavo in poskusite znova.';

  @override
  String get notice_permissionDenied_title => 'Dovoljenje za VPN je zavrnjeno';

  @override
  String get notice_permissionDenied_message =>
      'Znova vzpostavite povezavo in sprejmite zahtevo za dovoljenje sistema Android.';

  @override
  String get notice_wireguardTimeout_title => 'Strežnik se ne odziva';

  @override
  String get notice_wireguardTimeout_message =>
      'Povezava WireGuard je trajala predolgo. Poskusite znova ali izberite drugo lokacijo.';

  @override
  String get notice_tlsFailed_title => 'Varna povezava je zavrnjena';

  @override
  String get notice_tlsFailed_message =>
      'Strežnik ni sprejel povezave OpenVPN. Poskusite znova. Če težava ostaja, zaženite diagnostiko.';

  @override
  String get notice_tunRejected_title => 'Android je zavrnil vmesnik VPN';

  @override
  String get notice_tunRejected_message =>
      'Android je zavrnil omrežno konfiguracijo, ki jo je zahteval OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN se ni mogel zagnati';

  @override
  String get notice_openvpnStart_message =>
      'Pogon OpenVPN se ni mogel zagnati do konca. Poskusite znova. Če težava ostaja, se obrnite na podporo.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostična koda: $code';
  }

  @override
  String get notice_generic_title => 'Povezava VPN ni uspela';

  @override
  String get notice_generic_message =>
      'Prišlo je do napake. Poskusite znova pozneje.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Račun je ustvarjen',
      'password_reset_sent': 'Zahteva za ponastavitev gesla je prejeta',
      'verification_email_sent': 'Potrditveno e-poštno sporočilo je poslano',
      'location_migration_pending': 'Sprememba lokacije poteka',
      'vpn_sign_in_required': 'Potrebna je prijava',
      'protocol_unavailable_at_location': 'Protokol ni na voljo',
      'vpn_permission_denied': 'Dovoljenje za VPN je zavrnjeno',
      'revoked_identity_device_limit': 'Dosežena omejitev naprav',
      'tunnel_start_unexpected': 'VPN se ni mogel zagnati',
      'flutter_disconnect_timeout': 'Prekinitev povezave ni potrjena',
      'flutter_disconnect_unexpected': 'Povezave ni bilo mogoče prekiniti',
      'device_revoked': 'Naprava je odstranjena',
      'revoke_unexpected': 'Naprave ni bilo mogoče odstraniti',
      'identity_renewal_unexpected': 'Identitete ni bilo mogoče obnoviti',
      'openvpn_renewal_unexpected': 'OpenVPN ni bilo mogoče obnoviti',
      'location_migration_blocked': 'Sprememba lokacije je blokirana',
      'location_migration_slow': 'Sprememba lokacije še vedno poteka',
      'location_migration_conflict': 'Spremembo lokacije je treba osvežiti',
      'location_migration_verification_failed':
          'Sprememba lokacije ni potrjena',
      'location_migration_device_changed':
          'Naprava se je med spremembo lokacije spremenila',
      'tunnel_stop_failed': 'Sprememba lokacije ni na voljo',
      'device_clock_ahead': 'Ura naprave prehiteva',
      'other': 'Dejanje ni uspelo',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Račun je bil ustvarjen, vendar potrditvenega e-poštnega sporočila ni bilo mogoče poslati. V aplikaciji uporabite možnost za ponovno pošiljanje.',
      'password_reset_sent':
          'Vašo zahtevo smo prejeli. Če s tem naslovom obstaja račun, boste morda prejeli e-poštno sporočilo. Preverite tudi mapo z neželeno pošto.',
      'verification_email_sent':
          'Pravkar je bilo poslano novo potrditveno e-poštno sporočilo.',
      'location_migration_pending':
          'Premik na lokacijo $target se še vedno pripravlja. Nadaljujete ga lahko brez ponovnega ustvarjanja naprave.',
      'vpn_sign_in_required': 'Pred zagonom VPN-ja se prijavite v svoj račun.',
      'protocol_unavailable_at_location':
          'Izbrani protokol na tej lokaciji ni na voljo. Osvežite lokacije ali izberite drug protokol.',
      'vpn_permission_denied':
          'Android je zavrnil dovoljenje za VPN. Znova vzpostavite povezavo in sprejmite zahtevo sistema.',
      'revoked_identity_device_limit':
          'Dostop te naprave do VPN-ja je bil odstranjen, omejitev števila naprav pa je dosežena. Odstranite napravo v razdelku Račun → Upravljaj moje naprave.',
      'tunnel_start_unexpected':
          'Nepričakovana napaka je prekinila pripravo tunela. Preverite diagnostično kodo in poskusite znova.',
      'flutter_disconnect_timeout':
          'Android ni pravočasno potrdil, da se je VPN ustavil. Poskusite ga znova ustaviti.',
      'flutter_disconnect_unexpected':
          'Nepričakovana napaka je preprečila potrditev, da se je tunel ustavil.',
      'device_revoked':
          'Dostop naprave do VPN-ja je bil preklican, njeni lokalni skrivni podatki pa so bili odstranjeni.',
      'revoke_unexpected':
          'Naprave ni bilo mogoče odstraniti. Osvežite seznam in poskusite znova.',
      'identity_renewal_unexpected':
          'Nove identitete VPN ni bilo mogoče ustvariti. Osvežite naprave in poskusite znova.',
      'openvpn_renewal_unexpected':
          'Profila OpenVPN ni bilo mogoče obnoviti. Poskusite znova ali preverite diagnostično kodo.',
      'location_migration_blocked':
          'Strežnik trenutno ne more dokončati te spremembe. Naprava in njena lokalna identiteta sta bili ohranjeni.',
      'location_migration_slow':
          'Strežnik še vedno pripravlja premik na lokacijo $target. Čez nekaj trenutkov izberite „Nadaljuj spremembo lokacije“.',
      'location_migration_conflict':
          'Stanje naprave se je na strežniku spremenilo. Osvežite naprave in nato nadaljujte spremembo.',
      'location_migration_verification_failed':
          'Strežnik ni potrdil nove lokacije. Prejšnja lokalna identiteta je bila ohranjena.',
      'location_migration_device_changed':
          'Naprava, ki jo je vrnil strežnik, se ne ujema več z napravo, ki se spreminja. Pred ponovnim poskusom osvežite naprave.',
      'tunnel_stop_failed':
          'Prejšnji tunel mora biti pred novo povezavo popolnoma ustavljen.',
      'device_clock_ahead':
          'Zdi se, da ura te naprave prehiteva. Vklopite samodejni datum in čas, da ostanete prijavljeni.',
      'other':
          'Dejanja ni bilo mogoče dokončati. Poskusite znova ali posredujte diagnostično kodo podpori.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Seja je potekla',
      'invalid_credentials': 'Prijava ni uspela',
      'email_verification_required': 'Potrebna je potrditev e-poštnega naslova',
      'verification_email_cooldown': 'E-poštno sporočilo je že poslano',
      'rate_limited': 'Preveč poskusov',
      'invalid_registration': 'Podatke je treba popraviti',
      'email_exists': 'Račun že obstaja',
      'invalid_profile': 'Neveljaven profil',
      'invalid_device': 'Neveljavna naprava',
      'invalid_location': 'Lokacija ni na voljo',
      'device_limit': 'Dosežena omejitev naprav',
      'device_exists': 'Identiteta VPN je že v uporabi',
      'device_identity_revoked': 'Identiteto VPN je treba obnoviti',
      'device_location_locked': 'Spremembo lokacije je treba osvežiti',
      'location_migration_pending': 'Sprememba lokacije poteka',
      'location_migration_blocked': 'Sprememba lokacije je blokirana',
      'target_ca_mismatch': 'Nezdružljiv strežnik OpenVPN',
      'location_migration_conflict': 'Spremembo lokacije je treba osvežiti',
      'server_full': 'Strežnik je poln',
      'capacity_unavailable': 'Lokacija začasno ni na voljo',
      'target_unavailable': 'Strežnik začasno ni na voljo',
      'not_found': 'Elementa ni mogoče najti',
      'invalid_openvpn_csr': 'Neveljavna identiteta OpenVPN',
      'openvpn_profile_exists': 'Profil OpenVPN že obstaja',
      'openvpn_profile_revoked': 'Profil OpenVPN je preklican',
      'openvpn_operation_pending': 'Operacija OpenVPN poteka',
      'openvpn_operation_terminal': 'Operacija OpenVPN je prekinjena',
      'openvpn_address_unavailable': 'Naslov OpenVPN ni na voljo',
      'openvpn_profile_conflict': 'Konflikt pri OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN ni na voljo',
      'email_delivery_unavailable': 'E-pošta ni na voljo',
      'invalid_token': 'Neveljavna povezava',
      'network_unavailable': 'Internetna povezava ni na voljo',
      'invalid_json': 'Neveljavna zahteva',
      'invalid_api_response': 'Neveljaven odgovor strežnika',
      'ipv6_unavailable': 'IPv6 ni na voljo',
      'invalid_ip_families': 'Omrežna konfiguracija je zavrnjena',
      'other': 'Storitev ni na voljo',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Vaša seja je potekla. Znova se prijavite.',
      'invalid_credentials': 'Napačen e-poštni naslov ali geslo.',
      'email_verification_required':
          'Pred dodajanjem naprave VPN potrdite svoj e-poštni naslov.',
      'invalid_registration': 'Preverite zahtevane podatke in soglasja.',
      'email_exists': 'Ta e-poštni naslov je že povezan z računom.',
      'invalid_profile': 'Preverite podatke v svojem profilu.',
      'invalid_device':
          'Ime te naprave ali njena lokalna identiteta ni veljavna.',
      'invalid_location': 'Osvežite seznam lokacij in poskusite znova.',
      'device_limit': 'Pred dodajanjem nove naprave odstranite eno obstoječo.',
      'device_exists': 'Ta identiteta VPN je že povezana z drugim računom.',
      'device_identity_revoked':
          'Ta identiteta je bila odstranjena. Ustvariti je treba novo lokalno identiteto.',
      'device_location_locked':
          'Lokacija te naprave se je pravkar spremenila. Aplikacija bo nadaljevala spremembo, ki je v teku.',
      'location_migration_pending': 'Sprememba lokacije že poteka.',
      'location_migration_blocked':
          'Za spremembo lokacije je potreben poseg na strežniku. Poskusite znova pozneje ali se obrnite na podporo.',
      'target_ca_mismatch':
          'Ta strežnik še ni združljiv s trenutnim profilom OpenVPN.',
      'location_migration_conflict':
          'Osvežite naprave in nato znova poskusite spremeniti lokacijo.',
      'server_full':
          'Ta lokacija je dosegla omejitev povezav. Izberite drugo lokacijo ali poskusite znova pozneje.',
      'capacity_unavailable':
          'Trenutno ne moremo potrditi, ali je ta lokacija na voljo. Izberite drugo lokacijo ali poskusite znova pozneje.',
      'target_unavailable': 'Ta strežnik začasno ni na voljo.',
      'not_found': 'Ta element na vašem računu ni več na voljo.',
      'invalid_openvpn_csr':
          'Ustvarite novo identiteto OpenVPN in poskusite znova.',
      'openvpn_profile_exists': 'Za to napravo že obstaja profil OpenVPN.',
      'openvpn_profile_revoked': 'Za nadaljevanje obnovite profil OpenVPN.',
      'openvpn_operation_pending':
          'Sprememba se še uveljavlja. Poskusite znova pozneje.',
      'openvpn_operation_terminal':
          'Ustvarite novo identiteto OpenVPN in poskusite znova.',
      'openvpn_address_unavailable':
          'Trenutno ni na voljo noben naslov OpenVPN.',
      'openvpn_profile_conflict':
          'Profil se je spremenil. Osvežite naprave in poskusite znova.',
      'openvpn_signer_unavailable': 'Storitev OpenVPN začasno ni na voljo.',
      'email_delivery_unavailable':
          'E-poštnega sporočila ni bilo mogoče poslati. Poskusite znova pozneje.',
      'invalid_token':
          'Ta povezava ni veljavna ali je potekla. Zahtevajte novo.',
      'network_unavailable':
          'Preverite internetno povezavo in poskusite znova.',
      'invalid_json': 'Preverite vnesene podatke in poskusite znova.',
      'invalid_api_response':
          'Strežnik je vrnil nepričakovan odgovor. Poskusite znova pozneje.',
      'ipv6_unavailable':
          'Strežnik trenutno ne more aktivirati IPv6. Poskusite znova pozneje.',
      'invalid_ip_families':
          'Konfiguracija tunela je nepopolna ali se ne ujema z odobrenimi naslovi. Poskusite znova v aplikaciji.',
      'other': 'Prišlo je do napake strežnika. Poskusite znova pozneje.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Poskusite znova čez nekaj trenutkov.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Poskusite znova čez $seconds sekund.',
      few: 'Poskusite znova čez $seconds sekunde.',
      two: 'Poskusite znova čez $seconds sekundi.',
      one: 'Poskusite znova čez $seconds sekundo.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Poskusite znova čez $minutes minut.',
      few: 'Poskusite znova čez $minutes minute.',
      two: 'Poskusite znova čez $minutes minuti.',
      one: 'Poskusite znova čez $minutes minuto.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Poskusite znova čez $hours ur.',
      few: 'Poskusite znova čez $hours ure.',
      two: 'Poskusite znova čez $hours uri.',
      one: 'Poskusite znova čez $hours uro.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Obnovitev sistemskega VPN-ja ni na voljo',
      'system_vpn_resume_corrupt': 'Neveljavna obnovitev sistemskega VPN-ja',
      'system_vpn_resume_session_invalid':
          'Neveljavna seja za obnovitev VPN-ja',
      'system_vpn_resume_identity_changed':
          'Identiteta VPN-ja je bila spremenjena',
      'system_vpn_resume_identity_invalid':
          'Neveljavna identiteta za obnovitev VPN-ja',
      'system_vpn_resume_storage_failed':
          'Shramba za obnovitev VPN-ja ni na voljo',
      'system_vpn_resume_network_timeout': 'Ni omrežja za obnovitev VPN-ja',
      'system_vpn_resume_blocked': 'Obnovitev VPN-ja je blokirana',
      'system_vpn_resume_failed': 'Obnovitev VPN-ja ni uspela',
      'system_vpn_resume_error_invalid':
          'Neveljavna napaka pri obnovitvi VPN-ja',
      'wireguard_identity_store_failed': 'Identiteta WireGuard ni shranjena',
      'wireguard_identity_unavailable': 'Identiteta WireGuard ni na voljo',
      'vpn_host_destroyed': 'Gostitelj VPN-ja v Androidu je ustavljen',
      'vpn_host_unavailable': 'Gostitelj VPN-ja v Androidu ni na voljo',
      'vpn_permission_required': 'Potrebno je dovoljenje za VPN',
      'vpn_permission_denied': 'Dovoljenje za VPN je zavrnjeno',
      'vpn_permission_request_failed': 'Dovoljenja ni mogoče zahtevati',
      'wireguard_foreground_service_unavailable':
          'Storitev WireGuard ni na voljo',
      'wireguard_identity_invalid': 'Neveljaven lokalni ključ WireGuard',
      'wireguard_identity_in_use': 'Identiteta WireGuard je že v uporabi',
      'wireguard_configuration_invalid': 'Neveljavna konfiguracija WireGuard',
      'wireguard_operation_pending': 'Operacija WireGuard je še vedno aktivna',
      'wireguard_start_failed': 'Zagon WireGuard je zavrnjen',
      'wireguard_stop_timeout': 'Ustavitev WireGuard ni potrjena',
      'wireguard_handshake_timeout': 'WireGuard se ni odzval',
      'openvpn_connection_timeout': 'OpenVPN se ni odzval',
      'openvpn_core_unavailable': 'Pogon OpenVPN ni na voljo',
      'openvpn_operation_pending': 'Seja OpenVPN je še vedno aktivna',
      'openvpn_stop_timeout': 'Ustavitev OpenVPN ni potrjena',
      'openvpn_profile_unavailable': 'Lokalni profil OpenVPN manjka',
      'openvpn_native_failed': 'Nativni klic OpenVPN je prekinjen',
      'openvpn_key_generation_failed':
          'Ključa P-256 za OpenVPN ni mogoče ustvariti',
      'openvpn_csr_generation_failed':
          'Zahteve CSR za OpenVPN ni mogoče ustvariti',
      'openvpn_identity_store_failed': 'Identiteta OpenVPN ni shranjena',
      'openvpn_identity_clear_failed': 'Odstranitev OpenVPN ni popolna',
      'openvpn_identity_in_use': 'Identiteta OpenVPN je še vedno v uporabi',
      'openvpn_tls_verification_required': 'Preverjanje TLS za OpenVPN manjka',
      'openvpn_cipher_invalid': 'Neveljaven šifrirni algoritem OpenVPN',
      'openvpn_profile_rejected': 'Profil OpenVPN je zavrnjen',
      'openvpn_identity_inconsistent': 'Nedosledna identiteta OpenVPN',
      'tls_handshake_failed': 'Pogajanje OpenVPN je zavrnjeno',
      'tls_alert_unknown_ca': 'Potrdilo odjemalca OpenVPN ni prepoznano',
      'tls_alert_bad_certificate': 'Potrdilo odjemalca OpenVPN je zavrnjeno',
      'tls_alert_unsupported_certificate': 'Nepodprto potrdilo OpenVPN',
      'tls_client_certificate_required':
          'Potrebno je potrdilo odjemalca OpenVPN',
      'tls_alert_misc': 'Opozorilo TLS za OpenVPN',
      'tls_signature_algorithm_rejected': 'Nepodprt podpisni algoritem OpenVPN',
      'tls_handshake_rejected': 'Pogajanje TLS za OpenVPN je zavrnjeno',
      'tls_version_rejected': 'Nezdružljiva različica TLS za OpenVPN',
      'tls_certificate_expired': 'Potrdilo TLS je poteklo',
      'tls_certificate_revoked': 'Potrdilo TLS je preklicano',
      'transport_failed': 'Strežnik OpenVPN ni dosegljiv',
      'tun_configuration_rejected': 'Vmesnika OpenVPN ni mogoče ustvariti',
      'tun_setup_failed': 'Nastavitev TUN za OpenVPN ni uspela',
      'tun_interface_create_failed': 'Ustvarjanje vmesnika OpenVPN ni uspelo',
      'tun_interface_disabled': 'Vmesnik OpenVPN je onemogočen',
      'tun_halted': 'Vmesnik OpenVPN je bil prekinjen',
      'tun_already_established': 'Vmesnik OpenVPN je že odprt',
      'tun_addresses_missing': 'Naslov OpenVPN manjka',
      'tun_routes_missing': 'Manjkajo poti OpenVPN',
      'tun_dns_missing': 'DNS za OpenVPN manjka',
      'tun_permission_revoked': 'Dovoljenje za VPN je odvzeto',
      'tun_establish_returned_null': 'Android je zavrnil vmesnik VPN',
      'openvpn_service_start_failed': 'Storitev OpenVPN ni na voljo',
      'openvpn_operation_timeout': 'Čas za klic OpenVPN je potekel',
      'openvpn_start_failed': 'Zagon OpenVPN je zavrnjen',
      'openvpn_connection_failed': 'Povezava OpenVPN je prekinjena',
      'openvpn_core_status_error': 'OpenVPN Core se je končal z napako',
      'openvpn_stopped_before_connected':
          'OpenVPN se je ustavil pred vzpostavitvijo povezave',
      'openvpn_auth_failed': 'Overitev OpenVPN je zavrnjena',
      'openvpn_client_setup_failed': 'Priprava odjemalca OpenVPN ni uspela',
      'openvpn_client_halted': 'Odjemalec OpenVPN je bil prekinjen',
      'openvpn_client_restart': 'Zahtevan je ponovni zagon OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN je predolgo neaktiven',
      'openvpn_session_expired': 'Seja OpenVPN je potekla',
      'openvpn_credentials_required': 'Nepodprta overitev OpenVPN',
      'openvpn_proxy_failed': 'Posredniški prenos OpenVPN ni uspel',
      'openvpn_compression_failed': 'Stiskanje OpenVPN je zavrnjeno',
      'openvpn_ntlm_crypto_unavailable':
          'Šifriranje NTLM za OpenVPN ni na voljo',
      'openvpn_feature_unsupported': 'Nepodprta funkcija OpenVPN',
      'network_unavailable': 'Internetna povezava ni na voljo',
      'network_lost': 'Omrežje ni na voljo',
      'certificate_validation_failed': 'Potrdilo strežnika je zavrnjeno',
      'openvpn_certificate_expired': 'Potrdilo OpenVPN je poteklo',
      'tunnel_active_for_another_account':
          'Tunel drugega računa je še vedno aktiven',
      'tunnel_already_active': 'Nativni tunel je že aktiven',
      'tunnel_stop_timeout': 'Ustavitev $protocol ni potrjena',
      'tunnel_disconnected': '$protocol je bil prekinjen',
      'native_bridge_unavailable': 'Most za Android ni na voljo',
      'native_operation_failed': 'Operacija v Androidu je bila prekinjena',
      'invalid_arguments': 'Parametri VPN-ja so nepopolni',
      'invalid_account_id': 'Neveljaven račun za VPN',
      'invalid_device_id': 'Neveljaven identifikator naprave',
      'storage_key_not_allowed': 'Ključ za shrambo je zavrnjen',
      'secure_storage_read_failed': 'Varno branje ni uspelo',
      'secure_storage_write_failed': 'Varno shranjevanje ni uspelo',
      'key_generation_failed': 'Ključa WireGuard ni mogoče ustvariti',
      'csr_generation_failed': 'Zahteve CSR za OpenVPN ni mogoče ustvariti',
      'openvpn_recovery_exhausted':
          'Samodejna obnovitev OpenVPN je že uporabljena',
      'openvpn_recovery_failed': 'Samodejna obnovitev OpenVPN ni uspela',
      'openvpn_renewal_required': 'Potrebna je obnova potrdila OpenVPN',
      'other': 'Neopredeljena nativna napaka VPN-ja',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ne najde seje VPN-ja, ki bi jo bilo mogoče obnoviti. V aplikaciji vzpostavite novo povezavo.',
      'system_vpn_resume_corrupt':
          'Shranjeni podatki za obnovitev VPN-ja so neveljavni in ne bodo uporabljeni. Vzpostavite novo povezavo.',
      'system_vpn_resume_session_invalid':
          'Shranjena seja ne more več obnoviti VPN-ja. V aplikaciji se znova prijavite.',
      'system_vpn_resume_identity_changed':
          'Lokalna identiteta VPN-ja se je spremenila. Obnovitev je bila ustavljena. Vzpostavite novo povezavo.',
      'system_vpn_resume_identity_invalid':
          'Identiteta za obnovitev je neveljavna. Vzpostavite novo povezavo.',
      'system_vpn_resume_storage_failed':
          'Android ni mogel prebrati ali posodobiti šifriranih podatkov za obnovitev. Vzpostavite novo povezavo.',
      'system_vpn_resume_network_timeout':
          'Android ni pravočasno našel omrežja za obnovitev VPN-ja. Poskusite znova, ko bo omrežje na voljo.',
      'system_vpn_resume_blocked':
          'Obnovitev VPN-ja je blokirana. Preverite nastavitve Androida in nato vzpostavite novo povezavo.',
      'system_vpn_resume_failed':
          'Obnovitev VPN-ja v Androidu ni uspela. V aplikaciji vzpostavite novo povezavo.',
      'system_vpn_resume_error_invalid':
          'Android je vrnil neuporabno napako pri obnovitvi. Vzpostavite novo povezavo.',
      'wireguard_identity_store_failed':
          'Android ni mogel shraniti šifrirane identitete WireGuard za ta račun.',
      'wireguard_identity_unavailable':
          'Za to povezavo ni na voljo uporabne identitete WireGuard.',
      'vpn_host_destroyed':
          'Komponenta Androida, ki gosti VPN, je bila ustavljena. Vzpostavite novo povezavo.',
      'vpn_host_unavailable':
          'Android ne more ustvariti komponente, ki gosti VPN. Preverite nastavitve VPN-ja in poskusite znova.',
      'openvpn_renewal_required':
          'Potrdilo pred povezavo zahteva ukrep v aplikaciji.',
      'openvpn_recovery_failed':
          'Samodejna obnovitev ni uspela. V aplikaciji vzpostavite novo povezavo.',
      'openvpn_recovery_exhausted':
          'Samodejna obnovitev je bila že uporabljena. V aplikaciji vzpostavite novo povezavo.',
      'vpn_permission_required':
          'Android pred zagonom tunela zahteva novo dovoljenje za VPN.',
      'vpn_permission_denied':
          'Za nadaljevanje v zahtevi Androida dovolite FuzeVPN.',
      'vpn_permission_request_failed':
          'Android ni mogel odpreti zaslona za dovoljenje za VPN.',
      'wireguard_foreground_service_unavailable':
          'Android ni mogel ohraniti storitve WireGuard v ospredju.',
      'wireguard_identity_invalid':
          'Šifrirani ključ WireGuard za ta račun ni berljiv ali je neveljaven.',
      'wireguard_identity_in_use':
          'Druga operacija še vedno uporablja ključ WireGuard za ta račun.',
      'wireguard_configuration_invalid':
          'Prejeti naslov WireGuard, DNS, ključ strežnika ali poti so neveljavni.',
      'wireguard_operation_pending':
          'Prejšnja operacija WireGuard še ni sprostila svoje nativne storitve.',
      'wireguard_start_failed':
          'Pogon WireGuard je zavrnil aktivacijo konfiguracije.',
      'wireguard_stop_timeout':
          'Storitev WireGuard v dovoljenem času ni potrdila sprostitve vmesnika VPN.',
      'wireguard_handshake_timeout':
          'Tunel pravočasno ni potrdil rokovanja s strežnikom.',
      'openvpn_connection_timeout':
          'OpenVPN pravočasno ni potrdil povezave s strežnikom.',
      'openvpn_core_unavailable':
          'Ta različica aplikacije ne vsebuje uporabnega pogona OpenVPN.',
      'openvpn_operation_pending':
          'Nativni pogon še vedno vzdržuje prejšnjo sejo OpenVPN in ne dovoli ustvarjanja druge.',
      'openvpn_stop_timeout':
          'OpenVPN Core v dovoljenem času ni potrdil, da je bila njegova nativna seja ustavljena in uničena.',
      'openvpn_profile_unavailable':
          'Za to povezavo ni mogoče prebrati nobenega preverjenega profila OpenVPN.',
      'openvpn_native_failed':
          'Napaka v aplikaciji je prekinila OpenVPN. Poskusite se znova povezati. Če težava ostaja, zaženite diagnostiko.',
      'openvpn_key_generation_failed':
          'Android Keystore ni mogel ustvariti ali prebrati zasebnega ključa P-256, ki ga ni mogoče izvoziti.',
      'openvpn_csr_generation_failed':
          'Ključ Android Keystore ni mogel podpisati zahteve za potrdilo OpenVPN.',
      'openvpn_identity_store_failed':
          'Potrdila ali profila OpenVPN ni bilo mogoče shraniti v šifrirano shrambo.',
      'openvpn_identity_clear_failed':
          'Android ni mogel v celoti odstraniti lokalne identitete OpenVPN za ta račun.',
      'openvpn_identity_in_use':
          'Nativna seja OpenVPN še vedno uporablja ključ ali potrdilo te naprave.',
      'openvpn_tls_verification_required':
          'Profil izrecno ne zahteva preverjanja potrdila strežnika.',
      'openvpn_cipher_invalid':
          'Strežnik je poslal šifrirni algoritem, ki ni na dovoljenem seznamu.',
      'openvpn_profile_rejected':
          'Profil, prejet s strežnika, ni združljiv. Ponovno ustvarite to napravo in poskusite znova.',
      'openvpn_identity_inconsistent':
          'Potrdilo se ne ujema z varno identiteto tega telefona. Noben lokalni profil ni bil zamenjan.',
      'tls_handshake_failed':
          'Strežnik je zavrnil pogajanje TLS. Če težava ostaja, ponovno ustvarite profil.',
      'tls_alert_unknown_ca':
          'Strežnik ne prepozna izdajatelja potrdila te naprave. Preveriti je treba strežnik OpenVPN.',
      'tls_alert_bad_certificate':
          'Strežnik je zavrnil potrdilo te naprave. Pred ponovnim poskusom ponovno ustvarite napravo.',
      'tls_alert_unsupported_certificate':
          'Strežnik ne podpira vrste varnega potrdila, ki jo uporablja Android.',
      'tls_client_certificate_required':
          'Strežnik zahteva potrdilo odjemalca, OpenVPN Core pa ga ni mogel predložiti.',
      'tls_alert_misc':
          'Strežnik je vrnil opozorilo TLS, ki ne spada med kategorije potrdil in različic.',
      'tls_signature_algorithm_rejected':
          'Strežnik je zavrnil algoritem ECDSA P-256 ključa Android Keystore.',
      'tls_handshake_rejected':
          'Strežnik je pred vzpostavitvijo povezave prekinil pogajanje TLS.',
      'tls_version_rejected':
          'Odjemalec in strežnik nista našla skupne različice TLS.',
      'tls_certificate_expired':
          'Potrdilo, predloženo med povezavo, je poteklo.',
      'tls_certificate_revoked':
          'Potrdilo, predloženo med povezavo, je bilo preklicano.',
      'transport_failed':
          'Strežnik OpenVPN se na trenutnem omrežju ne odziva. Poskusite znova čez nekaj trenutkov.',
      'tun_configuration_rejected':
          'Android je zavrnil omrežno konfiguracijo, ki jo je zahteval OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core je zavrnil omrežni načrt, preden je ustvaril vmesnik Androida.',
      'tun_interface_create_failed':
          'OpenVPN Core ni mogel pridobiti vmesnika TUN iz storitve Android VpnService.',
      'tun_interface_disabled':
          'Android ali OpenVPN Core je med povezavo onemogočil vmesnik TUN.',
      'tun_halted': 'OpenVPN Core je prejel zahtevo za ustavitev vmesnika TUN.',
      'tun_already_established':
          'OpenVPN je v isti povezavi zahteval drugi vmesnik. Tunel je bil zaradi varnosti ustavljen.',
      'tun_addresses_missing':
          'Strežnik ni posredoval uporabnega naslova tunela.',
      'tun_routes_missing': 'Strežnik ni posredoval uporabnih poti tunela.',
      'tun_dns_missing': 'Strežnik ni posredoval uporabnega strežnika DNS.',
      'tun_permission_revoked':
          'Android je med povezavo odvzel dovoljenje za VPN.',
      'tun_establish_returned_null':
          'Android ni ustvaril vmesnika, običajno zato, ker je še vedno aktiven drug VPN.',
      'openvpn_service_start_failed':
          'Android ni mogel zagnati storitve OpenVPN v ospredju.',
      'openvpn_operation_timeout':
          'Klic JNI za OpenVPN Core je presegel največje dovoljeno trajanje.',
      'openvpn_start_failed':
          'Storitev Androida je pripravljena, vendar OpenVPN Core ni sprejel zagona profila.',
      'openvpn_connection_failed':
          'OpenVPN Core se je ustavil, preden je sprožil dogodek CONNECTED.',
      'openvpn_core_status_error':
          'Nativna zanka OpenVPN se je končala z napako, brez natančnejšega končnega dogodka.',
      'openvpn_stopped_before_connected':
          'Nativna zanka OpenVPN se je ustavila pred dogodkom CONNECTED, brez izrecne napake Core.',
      'openvpn_auth_failed': 'Strežnik OpenVPN je zavrnil overitev profila.',
      'openvpn_client_setup_failed':
          'OpenVPN Core ni mogel inicializirati odjemalca pred omrežno povezavo.',
      'openvpn_client_halted':
          'OpenVPN Core je prejel končno ustavitev odjemalca.',
      'openvpn_client_restart':
          'OpenVPN Core je zahteval ponovni zagon svoje prenosne seje.',
      'openvpn_inactive_timeout':
          'OpenVPN Core je po časovni omejitvi za neaktivnost zaprl sejo.',
      'openvpn_session_expired':
          'Strežnik je sporočil, da je seja OpenVPN potekla.',
      'openvpn_credentials_required':
          'Strežnik ali posredniški strežnik zahteva interaktivne prijavne podatke, ki niso del tega profila s potrdilom.',
      'openvpn_proxy_failed':
          'OpenVPN Core je javil napako nastavljenega posredniškega strežnika ali releja.',
      'openvpn_compression_failed':
          'OpenVPN Core je zavrnil način stiskanja, ki ga je napovedal profil ali strežnik.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil zahteva šifriranje NTLM, ki v tej različici ni na voljo.',
      'openvpn_feature_unsupported':
          'Profil ali strežnik zahteva funkcijo, ki v tem odjemalcu za Android manjka.',
      'network_unavailable':
          'Ni na voljo nobenega uporabnega fizičnega omrežja.',
      'network_lost': 'Tunel je bil ustavljen po izgubi omrežja.',
      'certificate_validation_failed':
          'Identitete strežnika OpenVPN ni bilo mogoče preveriti.',
      'openvpn_certificate_expired':
          'Pred ponovno povezavo obnovite profil OpenVPN.',
      'tunnel_active_for_another_account':
          'Tunel, ki pripada drugemu računu, se mora pred to povezavo ustaviti.',
      'tunnel_already_active':
          'Android poroča, da prejšnja seja VPN-ja še vedno uporablja vmesnik.',
      'tunnel_stop_timeout':
          'Pogon $protocol v dovoljenem času ni potrdil sprostitve vmesnika VPN.',
      'tunnel_disconnected':
          'Nativni pogon je sporočil, da se je tunel po zagonu nepričakovano končal.',
      'native_bridge_unavailable':
          'Aplikacija ne more dostopati do storitve VPN v Androidu. Zaprite in znova odprite aplikacijo ter poskusite znova.',
      'native_operation_failed':
          'Napaka v aplikaciji je prekinila operacijo VPN. Poskusite znova. Če težava ostaja, zaženite diagnostiko.',
      'invalid_arguments':
          'Podatki, potrebni za to operacijo VPN, so nepopolni. Poskusite znova. Če težava ostaja, zaženite diagnostiko.',
      'invalid_account_id':
          'Nativna operacija ni povezana z veljavnim identifikatorjem računa.',
      'invalid_device_id':
          'Identifikator naprave, poslan nativnemu pogonu, manjka ali je neveljaven.',
      'storage_key_not_allowed':
          'Most za Android je blokiral ključ, ki ni na dovoljenem seznamu shrambe.',
      'secure_storage_read_failed':
          'Android Keystore ni mogel dešifrirati lokalnih podatkov tega računa.',
      'secure_storage_write_failed':
          'Android Keystore ni mogel šifrirati ali shraniti lokalnih podatkov.',
      'key_generation_failed':
          'Android ni mogel ustvariti ali prebrati ključa WireGuard v varni shrambi.',
      'csr_generation_failed':
          'Android Keystore ni mogel ustvariti ali podpisati zahteve CSR P-256 za OpenVPN.',
      'other':
          'Pri nativni operaciji je prišlo do nedokumentirane napake. Podpori pošljite diagnostično kodo, prikazano spodaj.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Zahteva za dovoljenje je že odprta';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Zahteva za dovoljenje za VPN v Androidu je že prikazana. Pred ponovnim poskusom jo dokončajte.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Zahteva za dovoljenje za VPN je bila prekinjena';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Zaslon za dovoljenje za VPN se je zaprl, preden je aplikacija prejela odgovor.';

  @override
  String get notice_openvpnProofMissing_title => 'Povezava OpenVPN ni potrjena';

  @override
  String get notice_openvpnProofMissing_message =>
      'Povezave OpenVPN ni bilo mogoče potrditi. Zaradi varnosti je bila ustavljena. Poskusite znova.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN je preklican';

  @override
  String get openvpnCleanup_working =>
      'Ustavljanje in odstranjevanje preklicanega profila OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Ustavitev OpenVPN ni potrjena. Pred ustvarjanjem novega profila poskusite znova.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Preklicanega profila OpenVPN ni bilo mogoče v celoti odstraniti. Ponovite čiščenje.';

  @override
  String get openvpnCleanup_complete =>
      'Preklicani profil OpenVPN je bil odstranjen. Za ustvarjanje novega se dotaknite „Poveži“.';

  @override
  String get network_title => 'Omrežna konfiguracija';

  @override
  String get network_ipv4Fallback =>
      'IPv6 začasno ni na voljo. Priprava se nadaljuje z IPv4.';

  @override
  String get network_rejectedTitle => 'Omrežna konfiguracija je zavrnjena';

  @override
  String get network_rejectedMessage =>
      'Konfiguracija tunela je nepopolna ali se ne ujema z odobrenimi naslovi. Poskusite znova v aplikaciji.';

  @override
  String get network_unreadableTitle => 'Lokalna konfiguracija ni berljiva';

  @override
  String get network_unreadableMessage =>
      'Shranjene omrežne konfiguracije OpenVPN ni mogoče uporabiti. Za njeno posodobitev se znova povežite v aplikaciji.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Zaščita omrežja';

  @override
  String get protection_subtitle =>
      'Blokirajte neposreden dostop do interneta, če se VPN prekine.';

  @override
  String get protection_active => 'Sistemska zaščita je aktivna';

  @override
  String get protection_alwaysOnOnly =>
      'Vedno vklopljen VPN je omogočen; vklopite blokiranje zunaj VPN-ja';

  @override
  String get protection_inactive => 'Sistemska zaščita ni aktivna';

  @override
  String get protection_unknown => 'Preverite sistemsko zaščito';

  @override
  String get protection_openSettings => 'Odpri nastavitve Androida';

  @override
  String get protection_dialogTitle => 'Nastavite zaščito omrežja';

  @override
  String get protection_dialogMessage =>
      'Android upravlja vedno vklopljen VPN in blokiranje povezav zunaj VPN-ja. Preverite, ali je izbran FuzeVPN, nato pa v sistemskih nastavitvah vklopite blokiranje.';

  @override
  String get protection_dialogOpen => 'Odpri nastavitve';

  @override
  String get session_systemProtectionNote =>
      'Če Android še vedno blokira promet zunaj VPN-ja, odprite sistemske nastavitve, da to zaščito preverite ali spremenite.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Diagnostika aplikacije';

  @override
  String get diagnostics_automaticTitle => 'Pošiljanje pomembnih napak';

  @override
  String get diagnostics_automaticDescription =>
      'Ob pomembni napaki delite kratko tehnično poročilo.';

  @override
  String get diagnostics_privacy =>
      'Poslana poročila so povezana s prijavljenim računom in se hranijo 30 dni. Ne vsebujejo zgodovine brskanja, gesel ali ključev VPN.';

  @override
  String get diagnostics_manualOpen => 'Zaženi diagnostiko';

  @override
  String get diagnostics_localDescription =>
      'Ustvarite poročilo o stanju aplikacije in VPN-ja. Vaša povezava ostane nespremenjena.';

  @override
  String get diagnostics_sendReport => 'Pošlji poročilo';

  @override
  String get diagnostics_sendHint =>
      'Če želite poročilo obdržati v tej napravi, pustite potrditveno polje neizbrano.';

  @override
  String get diagnostics_signedOut =>
      'Za pošiljanje poročila se prijavite v svoj račun.';

  @override
  String get diagnostics_localLifetime =>
      'Če želite poročilo obdržati tudi po zaprtju aplikacije, ga shranite v telefon.';

  @override
  String get diagnostics_run => 'Zaženi diagnostiko';

  @override
  String get diagnostics_rerun => 'Ponovno zaženi diagnostiko';

  @override
  String get diagnostics_running => 'Preverjanje…';

  @override
  String get diagnostics_sending => 'Pošiljanje poročila…';

  @override
  String get diagnostics_prepared => 'Poročilo je pripravljeno v tej napravi';

  @override
  String get diagnostics_queued => 'Poročilo čaka na pošiljanje';

  @override
  String get diagnostics_sent => 'Poročilo je prejeto';

  @override
  String get diagnostics_failed =>
      'Pošiljanje ni uspelo. Vaše lokalno poročilo je še vedno na voljo.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostičnega poročila ni bilo mogoče pripraviti. Poskusite znova.';

  @override
  String get diagnostics_authenticationRequired =>
      'Za pošiljanje poročila se znova prijavite.';

  @override
  String get diagnostics_retry => 'Ponovno pošlji';

  @override
  String get diagnostics_export => 'Shrani poročilo';

  @override
  String get diagnostics_exportFailed =>
      'Izvoz ni uspel. Poskusite znova iz lokalnega poročila.';

  @override
  String get diagnostics_preferenceFailed =>
      'Te nastavitve ni bilo mogoče shraniti. Poskusite znova.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referenca: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Prejeto $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Shranjeno do $date';
  }

  @override
  String get diagnostics_duplicate => 'To poročilo je bilo že prejeto.';

  @override
  String get diagnostics_preview => 'Predogled poročila';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priloženih je $count tehničnih dogodkov',
      few: 'Priloženi so $count tehnični dogodki',
      two: 'Priložena sta $count tehnična dogodka',
      one: 'Priložen je $count tehnični dogodek',
      zero: 'Brez priloženih tehničnih dogodkov',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tehnične podrobnosti';

  @override
  String get diagnostics_empty =>
      'Diagnostično poročilo še ni bilo pripravljeno.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Stanje tunela',
      'handshake': 'Potrditev povezave',
      'certificate': 'Potrdilo VPN',
      'kill_switch': 'Zaščita Androida',
      'connectivity': 'Razpoložljivo omrežje',
      'api_reachability': 'Dostop do storitve',
      'secure_storage': 'Varno shranjevanje',
      'other': 'Lokalno preverjanje',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Preverjeno',
      'failed': 'Zahteva pozornost',
      'skipped': 'Ni preizkušeno – brez aktivnega preverjanja',
      'unknown': 'Podatek ni na voljo',
      'other': 'Podatek ni na voljo',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Dobrodošli v aplikaciji FuzeVPN';

  @override
  String get connection_changeLocation => 'Spremeni lokacijo';

  @override
  String get connection_details => 'Podrobnosti povezave';

  @override
  String get locations_searchLabel => 'Poiščite mesto ali državo';

  @override
  String get locations_clearSearch => 'Počisti iskanje';

  @override
  String get locations_filterAll => 'Vse';

  @override
  String get locations_filterFavorites => 'Priljubljene';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokacij',
      few: '$count lokacije',
      two: '$count lokaciji',
      one: '$count lokacija',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Ni najdenih lokacij';

  @override
  String get locations_noResultsHint => 'Poskusite z drugim mestom ali državo.';

  @override
  String get locations_noFavorites => 'Vaše priljubljene so vedno pri roki';

  @override
  String get locations_noFavoritesHint =>
      'Dotaknite se zvezdice ob lokaciji, da jo shranite tukaj.';

  @override
  String get locations_showAll => 'Prikaži vse lokacije';

  @override
  String locations_addFavorite(String name) {
    return 'Dodaj med priljubljene: $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Odstrani iz priljubljenih: $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Priljubljene lokacije ni bilo mogoče shraniti. Poskusite znova.';

  @override
  String get locations_emptyTitle => 'Ni razpoložljivih lokacij';

  @override
  String get locations_emptyHint => 'Osvežite seznam in poskusite znova.';

  @override
  String get devices_manage => 'Upravljaj moje naprave';

  @override
  String get settings_personalization => 'Prilagodite po svoje';

  @override
  String get settings_safety => 'Zaščita';

  @override
  String get settings_help => 'Potrebujete pomoč?';

  @override
  String get settings_about => 'O aplikaciji FuzeVPN';

  @override
  String get diagnostics_heading => 'Razumevanje težav s povezavo';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Na voljo',
      'pending': 'Priprava',
      'revoked': 'Odstranjeno',
      'expired': 'Poteklo',
      'other': 'Stanje ni na voljo',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Nastavitev ni shranjena';

  @override
  String get notice_preferenceSave_message =>
      'Vaša izbira je za zdaj uporabljena, vendar je ni bilo mogoče shraniti. Poskusite znova, da jo boste obdržali tudi po zaprtju aplikacije.';

  @override
  String get connection_androidDisconnectHint =>
      'Če Android ohranja VPN aktiven, v nastavitvah, ki se odprejo, izklopite „Vedno vklopljen VPN“.';

  @override
  String get protection_learnMore => 'Preberite več o zaščiti Androida';

  @override
  String get protection_guideWhy =>
      'Ta zaščita preprečuje, da bi aplikacije uporabljale internet neposredno, če se VPN prekine. Nastavi se v sistemu Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Vedno vklopljen VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android ohranja storitev VPN aktivno in jo lahko po ponovnem zagonu telefona znova zažene.';

  @override
  String get protection_guideBlockTitle => 'Blokiraj povezave brez VPN-ja';

  @override
  String get protection_guideBlock =>
      'Ta nastavitev preprečuje, da bi promet šel mimo VPN-ja, tudi med prekinitvijo povezave.';

  @override
  String get protection_guideWarning =>
      'Če je to blokiranje vklopljeno, dostop do interneta ostane izklopljen, dokler VPN ni povezan.';

  @override
  String get protection_guideStepsTitle => 'Vklopite zaščito';

  @override
  String get protection_guideStep1 =>
      'Z gumbom spodaj odprite nastavitve VPN-ja v sistemu Android.';

  @override
  String get protection_guideStep2 =>
      'Z ikono zobnika poleg vnosa FuzeVPN odprite možnosti.';

  @override
  String get protection_guideStep3 =>
      'Vklopite možnost „Vedno vklopljen VPN“ in nato „Blokiraj povezave brez VPN-ja“, če sta na voljo.';

  @override
  String get protection_guideManufacturers =>
      'Imena se razlikujejo glede na telefon. Če je treba, v nastavitvah poiščite „VPN“, pogosto v razdelku Omrežje in internet.';

  @override
  String get protection_guideDisableTitle => 'Izklopite to zaščito';

  @override
  String get protection_guideDisable =>
      'V istih nastavitvah izklopite blokiranje brez VPN-ja, če želite dostop do interneta brez VPN-ja. Če ne želite več, da Android VPN samodejno znova zažene, izklopite tudi „Vedno vklopljen VPN“.';

  @override
  String get protection_guideManual =>
      'Te nastavitve izberete v sistemu Android. FuzeVPN jih ne spreminja namesto vas.';

  @override
  String get locations_changeTitle => 'Želite spremeniti lokacijo?';

  @override
  String locations_changeActive(String name) {
    return 'VPN se bo prekinil, nato pa se bo poskusil povezati z lokacijo $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN se bo poskusil povezati z lokacijo $name.';
  }

  @override
  String get locations_confirmChange => 'Spremeni in poveži';

  @override
  String get locations_changeBusy =>
      'Sprememba poteka. Počakajte, preden izberete drugo lokacijo.';

  @override
  String get locations_automaticSelection => 'Samodejna izbira';

  @override
  String get locations_cities => 'Mesta';

  @override
  String get locations_servers => 'Strežniki';

  @override
  String locations_viewCities(String name) {
    return 'Oglej si mesta: $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Oglej si strežnike: $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count držav',
      few: '$count države',
      two: '$count državi',
      one: '$count država',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mest',
      few: '$count mesta',
      two: '$count mesti',
      one: '$count mesto',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strežnikov',
      few: '$count strežniki',
      two: '$count strežnika',
      one: '$count strežnik',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Vse države';

  @override
  String get locations_backToCountries => 'Nazaj na države';

  @override
  String locations_backToCities(String name) {
    return 'Nazaj na mesta: $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Izberi: $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Izberi: $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Na voljo ni nobenega združljivega strežnika.';

  @override
  String get externalLink_failed =>
      'Te povezave ni mogoče odpreti. Lahko jo kopirate in odprete v brskalniku.';

  @override
  String get externalLink_copy => 'Kopiraj povezavo';

  @override
  String get externalLink_copied => 'Povezava je kopirana';

  @override
  String get externalLink_copyFailed =>
      'Povezave ni mogoče kopirati. Izberite naslov spodaj.';

  @override
  String get settings_deleteAccount => 'Izbriši moj račun';

  @override
  String get settings_deleteAccountDetail =>
      'Oglejte si postopek zahteve za izbris računa';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Izberite naročnino za VPN.';

  @override
  String get billing_subscribe => 'Naroči se';

  @override
  String get billing_choosePlan => 'Za nadaljevanje izberite paket.';

  @override
  String get billing_monthly => 'Mesečno';

  @override
  String get billing_yearly => 'Letno';

  @override
  String get billing_continue => 'Nadaljuj z Google Play';

  @override
  String get billing_restore => 'Obnovi nakupe';

  @override
  String get billing_manage => 'Upravljaj naročnino';

  @override
  String get billing_deleteAccountWarning =>
      'Če imate naročnino Google Play, izbris računa FuzeVPN ne prekliče njenega podaljšanja. Podaljšanje upravljajte ali prekličite ločeno v Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Nadaljuj na zahtevo za izbris računa';

  @override
  String get billing_refresh => 'Osveži dostop';

  @override
  String get billing_loadingPlans => 'Nalaganje paketov…';

  @override
  String get billing_unavailable =>
      'Trenutno ni na voljo nobenega paketa. Poskusite znova pozneje.';

  @override
  String get billing_comingSoon => 'Naročnine bodo kmalu na voljo.';

  @override
  String get billing_priceDisclosure =>
      'Ceno zagotavlja Google Play. Končni znesek in veljavne davke boste videli, preden nakup potrdite.';

  @override
  String get billing_renewalMonthly =>
      'Naročnina se vsak mesec samodejno obnovi, razen če jo prekličete. Kadar koli jo lahko prekličete med naročninami v Google Play.';

  @override
  String get billing_renewalYearly =>
      'Naročnina se vsako leto samodejno obnovi, razen če jo prekličete. Kadar koli jo lahko prekličete med naročninami v Google Play.';

  @override
  String get billing_active => 'Vaš dostop Premium je aktiven';

  @override
  String billing_accessUntil(String date) {
    return 'Dostop velja do $date.';
  }

  @override
  String get billing_webManaged =>
      'Vašo naročnino upravljate na spletnem mestu FuzeVPN.';

  @override
  String get billing_playManaged => 'Vašo naročnino upravlja Google Play.';

  @override
  String get billing_playOnHold =>
      'Vaša naročnina Google Play je zadržana ali čaka na plačilo. Odprite „Upravljaj naročnino“ in težavo odpravite v Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Ta račun Google Play že ima naročnino Fuze Premium, ki za vaš račun FuzeVPN ni aktivna. Odprite „Upravljaj naročnino“ in si jo oglejte v Google Play.';

  @override
  String get billing_inactive => 'Ni aktivne naročnine.';

  @override
  String get billing_checkingAccess => 'Preverjanje dostopa…';

  @override
  String get billing_restoring => 'Obnavljanje nakupov…';

  @override
  String get billing_pending =>
      'Plačilo je na čakanju. Vaš dostop se bo aktiviral po potrditvi.';

  @override
  String get billing_cancelled =>
      'Nakup je preklican. Nobena nova naročnina ni bila aktivirana.';

  @override
  String get billing_verifying => 'Preverjanje nakupa…';

  @override
  String get billing_success =>
      'Naročnina je aktivirana. Vaš dostop Premium je pripravljen.';

  @override
  String get billing_restored => 'Vaši nakupi so bili obnovljeni.';

  @override
  String get billing_restoreEmpty =>
      'Za ta račun Google Play ni nakupov za obnovitev.';

  @override
  String get billing_catalogError =>
      'Paketov ni mogoče naložiti. Poskusite znova.';

  @override
  String get billing_purchaseError =>
      'Nakupa ni mogoče začeti. Poskusite znova.';

  @override
  String get billing_verificationError =>
      'Preverjanje nakupa je začasno nedosegljivo. Če želite poskusiti znova, obnovite nakupe.';

  @override
  String get billing_restoreError =>
      'Nakupov ni mogoče obnoviti. Poskusite znova.';

  @override
  String get billing_managementError =>
      'Upravljanja naročnine ni mogoče odpreti. Poskusite znova.';

  @override
  String get billing_storeUnavailable =>
      'Google Play na tej napravi ni na voljo.';

  @override
  String get welcome_title => 'Vaš VPN, brez zapletov.';

  @override
  String get welcome_description =>
      'Zaščitite svojo povezavo. Ohranite nadzor nad zasebnostjo.';

  @override
  String get welcome_start => 'Začni';

  @override
  String get welcome_alreadyPurchased => 'Ste že opravili nakup?';

  @override
  String get welcome_noAccountRequired => 'Za začetek račun ni potreben.';

  @override
  String get guest_accountTitle => 'Račun ni povezan';

  @override
  String get guest_accountDescription =>
      'Nakupe obnovite z istim računom Google Play, če želite naročnino uporabljati v drugi napravi.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Že imate naročnino? Prijavite se';

  @override
  String get guest_claimTitle => 'Vzemite FuzeVPN s seboj';

  @override
  String get guest_claimDescription =>
      'Ustvarite račun, da boste naročnino lahko uporabljali na drugih napravah. Ta korak je neobvezen.';

  @override
  String get guest_skip => 'Morda pozneje';

  @override
  String get guest_activationTitle => 'Fuze Premium je aktiven';

  @override
  String get guest_activationDescription =>
      'Vaša naročnina je pripravljena. VPN lahko uporabljate, račun pa ustvarite, kadar koli želite.';

  @override
  String get guest_useVpn => 'Uporabi moj VPN';

  @override
  String get guest_loginRequired =>
      'Ta nakup je že povezan z računom FuzeVPN. Prijavite se v ta račun za dostop do naročnine.';

  @override
  String get guest_signOutWarning =>
      'Naročnino lahko obnovite tako, da z istim računom Google Play obnovite nakupe.';

  @override
  String get guest_profileUnavailable =>
      'Vaš račun je že povezan. Prijavite se, da si ogledate in upravljate svoje podatke.';

  @override
  String get billing_acceptance =>
      'Z nadaljevanjem sprejemate pogoje uporabe in politiko zasebnosti.';

  @override
  String get guest_verifyEmailReminder =>
      'Potrdite e-poštni naslov, da zaščitite račun. VPN lahko še naprej uporabljate.';

  @override
  String get guest_serviceUnavailable =>
      'Storitev je začasno nedosegljiva. Poskusite znova čez nekaj trenutkov.';

  @override
  String get guest_restoreError =>
      'Nakupov ni bilo mogoče obnoviti. Poskusite znova z računom Google Play, ki ste ga uporabili za nakup.';

  @override
  String get guest_claimSuccess =>
      'Vaš račun je bil ustvarjen. Vaša naročnina in dostop do VPN-ja sta ohranjena.';

  @override
  String get guest_emailExists =>
      'Ta e-poštni naslov je že v uporabi. Izberite drug naslov ali se prijavite v obstoječi račun. Nakup ostaja na voljo prek Google Play.';

  @override
  String get guest_claimError =>
      'Vašega računa ni bilo mogoče ustvariti. VPN lahko še naprej uporabljate, poskusite pa znova pozneje.';

  @override
  String get guest_secureStorageError =>
      'Vaše seje na tej napravi ni bilo mogoče zaščititi. Poskusite znova.';

  @override
  String get guest_premiumRequired =>
      'Za aktivacijo VPN-ja izberite naročnino.';

  @override
  String get welcome_viewPlans => 'Oglej si pakete';

  @override
  String get google_continue => 'Nadaljuj z računom Google';

  @override
  String get google_or => 'ali';

  @override
  String get google_title => 'Vaš račun FuzeVPN';

  @override
  String get google_settingUp => 'Dokončajte ustvarjanje računa';

  @override
  String get google_country => 'Država prebivališča';

  @override
  String get google_profileDescription =>
      'Izberite državo in preglejte oba dokumenta, da ustvarite račun FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Gostujoči račun povežite z računom Google. Naročnina in naprava ostaneta povezani s tem računom.';

  @override
  String get google_linkTitle => 'Povežite račun Google z računom FuzeVPN';

  @override
  String get google_linkDescription =>
      'Potrdite dostop do obstoječega računa FuzeVPN. Ta korak ne zahteva vašega gesla za Google.';

  @override
  String get google_password => 'Geslo FuzeVPN';

  @override
  String get google_linkAccount => 'Potrdi povezavo';

  @override
  String get google_requestEmail => 'Pošlji mi potrditveno e-pošto';

  @override
  String get google_emailInstructions =>
      'Odprite e-pošto FuzeVPN in vnesite potrditveno kodo.';

  @override
  String get google_emailCode => 'Potrditvena koda iz e-pošte';

  @override
  String get google_confirmEmail => 'Potrdi kodo';

  @override
  String get google_restart => 'Izberi drug račun Google';

  @override
  String get google_resume => 'Preveri ta poskus';

  @override
  String get google_unavailable =>
      'Prijava z računom Google ni na voljo. Lahko uporabite e-poštni naslov in geslo.';

  @override
  String get google_expired =>
      'Ta poskus je potekel. Prekličite ga in začnite znova.';

  @override
  String get google_conflict =>
      'Ta račun Google je že povezan drugje. Vaš trenutni račun in naročnina ostaneta nespremenjena.';

  @override
  String get google_error =>
      'Prijava z računom Google ni uspela. Poskusite znova; vaš trenutni dostop ostane nespremenjen.';

  @override
  String get google_uncertain =>
      'Rezultata ni bilo mogoče potrditi. Preverite ta poskus ali ga prekličite, preden začnete znova.';

  @override
  String get google_cancelFailed =>
      'Preklica ni bilo mogoče potrditi. Poskusite preklicati še enkrat, preden zapustite ta zaslon.';

  @override
  String get google_cancelled => 'Prijava z računom Google je preklicana.';

  @override
  String get google_selecting => 'Izberite svoj račun Google…';

  @override
  String get google_verifying => 'Preverjanje vašega računa…';

  @override
  String get google_emailUnavailable =>
      'Potrditvene e-pošte ni bilo mogoče poslati. Poskusite znova pozneje.';

  @override
  String get google_emailSent =>
      'Potrditvena e-pošta je poslana. Preverite nabiralnik.';

  @override
  String get google_rateLimited => 'Počakajte, preden poskusite znova.';

  @override
  String get google_busy =>
      'Prijava z računom Google ni na voljo, medtem ko poteka drug postopek (povezava VPN, račun ali gost). Poskusite znova, ko bo končan; vaš trenutni dostop ostane nespremenjen.';

  @override
  String get google_invalidPassword =>
      'Geslo FuzeVPN je napačno. Vaš trenutni račun ostane nespremenjen.';

  @override
  String get google_invalidCode =>
      'Potrditvena koda je neveljavna ali je potekla.';

  @override
  String get google_accountChanged =>
      'Vaša seja se je spremenila. Prekličite ta poskus, preden začnete znova.';

  @override
  String get google_invalidResponse =>
      'Odgovora ni bilo mogoče preveriti. Vaš trenutni dostop ostane nespremenjen.';

  @override
  String get google_invalidRegistration => 'Preverite državo in obe soglasji.';

  @override
  String get google_consentRequired =>
      'Za nadaljevanje izberite državo in sprejmite oba dokumenta.';

  @override
  String get google_challengeRequired =>
      'Potrebno je dodatno varnostno preverjanje. Vaš trenutni dostop ostane nespremenjen.';

  @override
  String get google_challengeUnavailable =>
      'Varnostno preverjanje ni na voljo. Poskusite znova pozneje.';

  @override
  String get google_intentMismatch =>
      'Prejšnji poskus prijave z računom Google je še v teku. Prekličite ga, preden začnete ta postopek.';

  @override
  String get google_challengeBlocked =>
      'Zahtevano varnostno preverjanje v tej aplikaciji ni na voljo. Tega postopka trenutno ni mogoče dokončati.';

  @override
  String get google_solveChallenge => 'Dokončaj varnostno preverjanje';

  @override
  String get google_challengeTitle => 'Varnostno preverjanje';

  @override
  String get google_challengeReady =>
      'Preverjanje je dokončano. Zdaj lahko potrdite ustvarjanje računa.';

  @override
  String get google_challengeExpired =>
      'Preverjanje je poteklo. Pred potrditvijo ga dokončajte znova.';

  @override
  String get google_challengeCancelled =>
      'Preverjanje je preklicano. Lahko ga poskusite znova.';

  @override
  String get google_challengeFailed =>
      'Varnostno preverjanje ni uspelo. Poskusite znova.';

  @override
  String get billing_trialTitle => 'Preizkusite Fuze Premium brezplačno';

  @override
  String get billing_trialSubtitle => 'Zaščitite svojo povezavo že danes.';

  @override
  String get billing_trialWeeks => '2-tedenski brezplačni preizkus';

  @override
  String billing_trialDays(String days) {
    return '$days-dnevni brezplačni preizkus';
  }

  @override
  String get billing_trialStart => 'Začni brezplačni preizkus';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Če začnete danes, je prvo plačilo predvideno za $date.';
  }

  @override
  String get billing_trialTerms =>
      'Samodejno se obnovi po navedeni ceni. Če se želite izogniti plačilu, prekličite v Google Play, preden se preizkus konča.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Nato $price na mesec';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Nato $price na leto';
  }

  @override
  String get billing_choosePeriod => 'Izberite paket';

  @override
  String get billing_selectionHint => 'Za nadaljevanje izberite paket.';

  @override
  String get billing_benefitConnection => 'Šifrirana povezava';

  @override
  String get billing_benefitPrivacy => 'Zasebnost na spletu';

  @override
  String get billing_benefitNoAccount => 'Registracija ni potrebna';

  @override
  String get billing_cancellation => 'Preklic v Google Play';

  @override
  String get billing_premiumTitle => 'Bolj zaščitena povezava.';

  @override
  String get billing_premiumSubtitle =>
      'Zaščitite svojo povezavo v svojem tempu.';

  @override
  String get billing_priceMonthly => 'na mesec';

  @override
  String get billing_priceYearly => 'na leto';

  @override
  String get billing_trialToday => 'Danes ni treba plačati ničesar';

  @override
  String get billing_trialConfirmation =>
      'Google Play pred vašo potrditvijo prikaže datume, končni znesek in veljavne davke.';

  @override
  String get billing_offerChanged =>
      'Pogoji te ponudbe so se spremenili. Osvežite pakete in izberite znova.';

  @override
  String get status_waitingNetwork => 'Čakanje na omrežje';

  @override
  String get status_waitingNetworkDetail =>
      'Omrežje ni na voljo. Povezava se bo preverila, ko bo omrežje spet na voljo.';

  @override
  String get locations_favoriteLoadFailed =>
      'Priljubljenih ni mogoče naložiti. Poskusite znova.';

  @override
  String get locations_favoritesLoading => 'Nalaganje priljubljenih…';
}
