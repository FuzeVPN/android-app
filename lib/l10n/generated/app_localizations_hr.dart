// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Zaštitite svoju vezu';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN koristi Androidovu VPN uslugu (VpnService) za stvaranje šifriranog tunela između ovog uređaja i FuzeVPN poslužitelja.';

  @override
  String get vpnDisclosure_dataBody =>
      'Dok je VPN aktivan, internetski promet vaših aplikacija, odredišne adrese i DNS zahtjevi prolaze kroz ovaj tunel radi usmjeravanja vaše veze, čak i kada je FuzeVPN u pozadini.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikacija koristi stanje veze, njezino trajanje i količinu prenesenih podataka za prikaz vaše VPN veze. Možete je zaustaviti u bilo kojem trenutku.';

  @override
  String get vpnDisclosure_privacy => 'Privatnost';

  @override
  String get vpnDisclosure_accept => 'Prihvati i nastavi';

  @override
  String get vpnDisclosure_decline => 'Ne sada';

  @override
  String get accountRestoration_title => 'Račun je privremeno nedostupan';

  @override
  String get accountRestoration_message =>
      'Vaša je sesija zadržana. Pokušajte ponovo kako biste vratili račun; ovdje i dalje možete upravljati VPN vezom.';

  @override
  String get action_retry => 'Pokušaj ponovo';

  @override
  String get session_endingTitle => 'Završavanje sesije';

  @override
  String get session_ending =>
      'Završavanje sesije: zaustavljanje VPN-a i čišćenje…';

  @override
  String get session_stopFailed =>
      'Zaustavljanje VPN-a nije potvrđeno. Pokušajte ponovo prije ponovne prijave.';

  @override
  String get session_cleanupFailed =>
      'VPN je zaustavljen, ali uklanjanje sesije nije potvrđeno. Ponovite čišćenje.';

  @override
  String get session_retryStop => 'Ponovi zaustavljanje';

  @override
  String get session_retryCleanup => 'Ponovi čišćenje';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Sigurna priprema aplikacije FuzeVPN…';

  @override
  String get nav_connection => 'Veza';

  @override
  String get nav_locations => 'Lokacije';

  @override
  String get nav_account => 'Račun';

  @override
  String get nav_devices => 'Uređaji';

  @override
  String get nav_settings => 'Postavke';

  @override
  String get action_refresh => 'Osvježi';

  @override
  String get auth_tab_login => 'Prijava';

  @override
  String get auth_tab_register => 'Registracija';

  @override
  String get auth_stepAccount => 'Račun';

  @override
  String get auth_stepIdentity => 'Identitet';

  @override
  String get auth_stepAddress => 'Adresa i suglasnosti';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Korak $current od $total';
  }

  @override
  String get auth_tagline => 'Vaš VPN, jednostavno.';

  @override
  String get auth_keysLocal =>
      'Vaši privatni VPN ključevi ostaju na ovom uređaju.';

  @override
  String get form_email => 'Adresa e-pošte';

  @override
  String get form_password => 'Lozinka';

  @override
  String get form_showPassword => 'Prikaži lozinku';

  @override
  String get form_hidePassword => 'Sakrij lozinku';

  @override
  String get form_passwordMin =>
      'Od 8 do 72 UTF-8 bajta. Neki znakovi zauzimaju više bajtova.';

  @override
  String get form_firstName => 'Ime';

  @override
  String get form_lastName => 'Prezime';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adresa';

  @override
  String get form_address2 => 'Dodatak adresi (neobavezno)';

  @override
  String get form_postalCode => 'Poštanski broj';

  @override
  String get form_city => 'Grad';

  @override
  String get form_country => 'Kôd države (npr. FR)';

  @override
  String get action_login => 'Prijavi se';

  @override
  String get action_createAccount => 'Izradi račun';

  @override
  String get action_createMyAccount => 'Izradi moj račun';

  @override
  String get action_next => 'Nastavi';

  @override
  String get action_previous => 'Natrag';

  @override
  String get action_forgotPassword => 'Zaboravili ste lozinku?';

  @override
  String get auth_noAccount => 'Još nemate račun?';

  @override
  String get auth_requiredInformation => 'Izradite račun u tri koraka.';

  @override
  String get auth_termsPrefix => 'Prihvaćam ';

  @override
  String get auth_termsLink => 'uvjete korištenja';

  @override
  String get auth_privacyPrefix => 'Prihvaćam ';

  @override
  String get auth_privacyLink => 'pravila o privatnosti';

  @override
  String get auth_consentRequired =>
      'Za izradu računa potrebna je vaša suglasnost.';

  @override
  String get validation_required => 'Ovo je polje obavezno.';

  @override
  String get validation_email => 'Unesite valjanu adresu e-pošte.';

  @override
  String get validation_password =>
      'Lozinka je prekratka: potrebno je najmanje 8 UTF-8 bajtova.';

  @override
  String get validation_passwordTooLong =>
      'Lozinka je predugačka: najviše 72 UTF-8 bajta.';

  @override
  String get validation_phone =>
      'Upotrijebite međunarodni format, na primjer +33612345678.';

  @override
  String get validation_country =>
      'Upotrijebite dvoslovni kôd države, na primjer FR.';

  @override
  String get passwordReset_title => 'Poništavanje lozinke';

  @override
  String get passwordReset_description =>
      'Unesite adresu e-pošte svog računa da biste zatražili poveznicu za poništavanje lozinke.';

  @override
  String get passwordReset_send => 'Pošalji poveznicu';

  @override
  String get connection_title => 'Vaša veza';

  @override
  String get connection_subtitle =>
      'Odaberite lokaciju, a zatim uključite VPN.';

  @override
  String get connection_prepare => 'Spremni za povezivanje?';

  @override
  String get connection_advancedOptions => 'Napredne opcije';

  @override
  String get connection_location => 'Lokacija';

  @override
  String get connection_chooseLocation => 'Odaberite lokaciju';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Poveži';

  @override
  String get connection_connecting => 'Povezivanje…';

  @override
  String get connection_disconnect => 'Prekini vezu';

  @override
  String get connection_disconnecting => 'Prekidanje veze';

  @override
  String get connection_locationChange => 'Promjena lokacije…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nije dostupan';
  }

  @override
  String get connection_activeLocation => 'Aktivna lokacija';

  @override
  String get connection_duration => 'Trajanje';

  @override
  String get connection_received => 'Primljeno';

  @override
  String get connection_sent => 'Poslano';

  @override
  String get connection_lastHandshake => 'Posljednja sigurna razmjena';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Prije $duration';
  }

  @override
  String get verification_title => 'Potvrdite adresu e-pošte';

  @override
  String get verification_message =>
      'Potvrdite adresu e-pošte da biste na ovom telefonu upotrebljavali VPN.';

  @override
  String get verification_resend => 'Ponovno pošalji e-poruku';

  @override
  String get migration_title => 'Promjena lokacije';

  @override
  String get migration_draining => 'Priprema promjene lokacije…';

  @override
  String get migration_activating => 'Aktiviranje novog poslužitelja…';

  @override
  String get migration_ready => 'Lokacija je ažurirana.';

  @override
  String get migration_blocked =>
      'Promjena lokacije zahtijeva intervenciju poslužitelja. Pokušajte ponovo kasnije ili se obratite podršci.';

  @override
  String get migration_progress => 'Napredak promjene lokacije';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Razmak između provjera: $seconds s.';
  }

  @override
  String get migration_resume => 'Nastavi promjenu lokacije';

  @override
  String get status_authorizing => 'Potrebno je dopuštenje';

  @override
  String get status_authorizingDetail =>
      'Prihvatite Androidov zahtjev kako biste dopustili VPN.';

  @override
  String get status_preparing => 'Priprema';

  @override
  String get status_preparingDetail => 'Priprema se vaša sigurna veza.';

  @override
  String get status_reconnecting => 'Ponovno povezivanje…';

  @override
  String get status_reconnectingDetail =>
      'Veza je prekinuta. VPN pokušava ponovno uspostaviti vezu.';

  @override
  String get status_connecting => 'Povezivanje';

  @override
  String get status_connectingDetail => 'Povezivanje s VPN poslužiteljem…';

  @override
  String get status_connected => 'Povezano';

  @override
  String get status_connectedDetail => 'Vaša VPN veza je aktivna.';

  @override
  String get status_disconnecting => 'Prekidanje veze';

  @override
  String get status_disconnectingDetail => 'Vaša se VPN veza zaustavlja.';

  @override
  String get status_error => 'Veza nije dostupna';

  @override
  String get status_errorDetail => 'VPN veza nije potvrđena. Pokušajte ponovo.';

  @override
  String get status_idle => 'Nije povezano';

  @override
  String get status_idleDetail => 'Povežite VPN da biste zaštitili svoju vezu.';

  @override
  String get trust_note =>
      'Zatvaranje aplikacije ne zaustavlja VPN. Da biste ga zaustavili, upotrijebite Prekini vezu.';

  @override
  String get locations_none => 'Trenutačno nema dostupnih lokacija.';

  @override
  String get locations_available => 'Odaberite sljedeću lokaciju.';

  @override
  String get locations_selected => 'Odabrana lokacija';

  @override
  String get locations_select => 'Odaberi ovu lokaciju';

  @override
  String get locations_lockedTunnel =>
      'Da biste promijenili lokaciju, prekinite VPN vezu.';

  @override
  String get locations_lockedMigration =>
      'Pričekajte da se promjena lokacije završi.';

  @override
  String get devices_title => 'Vaši uređaji';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit uređaja';
  }

  @override
  String get devices_refresh => 'Osvježi uređaje';

  @override
  String get devices_empty => 'Još nije registriran nijedan VPN uređaj.';

  @override
  String get devices_firstConnection =>
      'Vaš će telefon biti dodan pri prvom povezivanju.';

  @override
  String get devices_thisDevice => 'Ovaj uređaj';

  @override
  String devices_added(Object date) {
    return 'Dodano $date';
  }

  @override
  String get devices_unnamed => 'Uređaj bez naziva';

  @override
  String get action_remove => 'Ukloni';

  @override
  String get settings_title => 'Postavke';

  @override
  String get settings_subtitle => 'Vaše postavke i račun, na jednom mjestu.';

  @override
  String get settings_appearance => 'Izgled';

  @override
  String get settings_language => 'Jezik';

  @override
  String get settings_languageDescription =>
      'Odabrani jezik primjenjuje se i na VPN obavijesti.';

  @override
  String get settings_account => 'Račun';

  @override
  String get settings_signOut => 'Odjavi se';

  @override
  String get settings_privacy => 'Pravila o privatnosti';

  @override
  String get settings_terms => 'Uvjeti korištenja';

  @override
  String get settings_security => 'Sigurnost i transparentnost';

  @override
  String get settings_licenses => 'Licence komponenti';

  @override
  String get settings_licensesDetail => 'Softver koji se koristi u aplikaciji';

  @override
  String settings_licensesLegalese(String url) {
    return 'Izvorni kod aplikacije i njezinih komponenti pod licencom MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN ostaje uključen kada napustite aplikaciju. Da biste ga zaustavili, upotrijebite Prekini vezu na kartici Veza.';

  @override
  String get theme_system => 'Sustav';

  @override
  String get theme_light => 'Svijetla';

  @override
  String get theme_dark => 'Tamna';

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
  String get dialog_removeDevice => 'Ukloniti ovaj uređaj?';

  @override
  String get dialog_removeCurrent =>
      'Veza ovog telefona s VPN-om bit će prekinuta i telefon će izgubiti pristup. Podaci o VPN vezi ovog telefona bit će uklonjeni nakon što poslužitelj to potvrdi.';

  @override
  String dialog_removeOther(Object name) {
    return 'Pristup VPN-u za „$name” bit će opozvan. Ova se radnja ne može poništiti.';
  }

  @override
  String get dialog_signOut => 'Odjaviti se?';

  @override
  String get dialog_signOutMessage =>
      'VPN će se zaustaviti, a morat ćete se ponovno prijaviti. Šifrirani VPN ključevi ostat će na ovom telefonu za vašu sljedeću vezu.';

  @override
  String get action_cancel => 'Odustani';

  @override
  String get action_close => 'Zatvori';

  @override
  String get action_copy => 'Kopiraj';

  @override
  String get action_renew => 'Obnovi';

  @override
  String get action_signOut => 'Odjavi se';

  @override
  String get notice_close => 'Zatvori poruku';

  @override
  String get notice_sessionExpired_title => 'Sesija je istekla';

  @override
  String get notice_sessionExpired_message =>
      'Vaša sesija je istekla. Ponovno se prijavite.';

  @override
  String get notice_connectionFailed_title => 'Povezivanje nije uspjelo';

  @override
  String get notice_invalidCredentials_message =>
      'Adresa e-pošte ili lozinka nije točna.';

  @override
  String get notice_emailVerification_title => 'Potrebna je potvrda e-pošte';

  @override
  String get notice_emailVerification_message =>
      'Potvrdite adresu e-pošte prije dodavanja VPN uređaja.';

  @override
  String get notice_rateLimited_title => 'Previše pokušaja';

  @override
  String get notice_deviceLimit_title => 'Dosegnuto je ograničenje uređaja';

  @override
  String get notice_deviceLimit_message =>
      'Prije dodavanja drugog uređaja uklonite postojeći uređaj.';

  @override
  String get notice_identityRenewal_title => 'VPN identitet treba obnoviti';

  @override
  String get notice_identityRenewal_message =>
      'Ovaj identitet je uklonjen. Stvorite novi lokalni identitet.';

  @override
  String get notice_migrationPending_title => 'Promjena lokacije je u tijeku';

  @override
  String get notice_migrationPending_message =>
      'Promjena lokacije već je u tijeku.';

  @override
  String get notice_migrationBlocked_title => 'Promjena lokacije je blokirana';

  @override
  String get notice_migrationBlocked_message =>
      'Promjena lokacije zahtijeva intervenciju poslužitelja. Pokušajte ponovo kasnije ili se obratite podršci.';

  @override
  String get notice_targetUnavailable_title =>
      'Poslužitelj privremeno nije dostupan';

  @override
  String get notice_targetUnavailable_message =>
      'Ovaj poslužitelj privremeno nije dostupan.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetska veza nije dostupna';

  @override
  String get notice_networkUnavailable_message =>
      'Provjerite vezu i pokušajte ponovo.';

  @override
  String get notice_permissionDenied_title => 'Dopuštenje za VPN je odbijeno';

  @override
  String get notice_permissionDenied_message =>
      'Ponovno pokrenite vezu i prihvatite Androidov zahtjev za dopuštenje.';

  @override
  String get notice_wireguardTimeout_title => 'Poslužitelj ne odgovara';

  @override
  String get notice_wireguardTimeout_message =>
      'Uspostava WireGuard veze trajala je predugo. Pokušajte ponovo ili odaberite drugu lokaciju.';

  @override
  String get notice_tlsFailed_title => 'Sigurna veza je odbijena';

  @override
  String get notice_tlsFailed_message =>
      'Poslužitelj nije prihvatio OpenVPN vezu. Pokušajte ponovo. Ako se problem nastavi, pokrenite dijagnostiku.';

  @override
  String get notice_tunRejected_title => 'Android je odbio VPN sučelje';

  @override
  String get notice_tunRejected_message =>
      'Android je odbio mrežnu konfiguraciju koju je zatražio OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN se nije mogao pokrenuti';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN motor nije uspio dovršiti pokretanje. Pokušajte ponovo. Ako se problem nastavi, obratite se podršci.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Dijagnostički kôd: $code';
  }

  @override
  String get notice_generic_title => 'VPN veza nije uspjela';

  @override
  String get notice_generic_message =>
      'Dogodila se pogreška. Pokušajte ponovo kasnije.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Račun je izrađen',
      'password_reset_sent': 'Zahtjev za poništavanje lozinke je primljen',
      'verification_email_sent': 'Poslana je e-poruka za potvrdu',
      'location_migration_pending': 'Promjena lokacije je u tijeku',
      'vpn_sign_in_required': 'Potrebna je prijava',
      'protocol_unavailable_at_location': 'Protokol nije dostupan',
      'vpn_permission_denied': 'Dopuštenje za VPN je odbijeno',
      'revoked_identity_device_limit': 'Dosegnuto je ograničenje uređaja',
      'tunnel_start_unexpected': 'VPN se nije mogao pokrenuti',
      'flutter_disconnect_timeout': 'Prekid veze nije potvrđen',
      'flutter_disconnect_unexpected': 'Prekidanje veze nije uspjelo',
      'device_revoked': 'Uređaj je uklonjen',
      'revoke_unexpected': 'Uređaj nije bilo moguće ukloniti',
      'identity_renewal_unexpected': 'Identitet nije bilo moguće obnoviti',
      'openvpn_renewal_unexpected': 'OpenVPN profil nije bilo moguće obnoviti',
      'location_migration_blocked': 'Promjena lokacije je blokirana',
      'location_migration_slow': 'Promjena lokacije još je u tijeku',
      'location_migration_conflict': 'Promjena lokacije zahtijeva osvježavanje',
      'location_migration_verification_failed':
          'Promjena lokacije nije potvrđena',
      'location_migration_device_changed':
          'Uređaj se promijenio tijekom promjene lokacije',
      'tunnel_stop_failed': 'Promjena lokacije nije dostupna',
      'device_clock_ahead': 'Sat uređaja žuri',
      'other': 'Radnja nije uspjela',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Račun je izrađen, ali e-poruku za potvrdu nije bilo moguće poslati. Upotrijebite opciju ponovnog slanja u aplikaciji.',
      'password_reset_sent':
          'Vaš je zahtjev primljen. Ako račun s ovom adresom postoji, možda ćete dobiti e-poruku. Provjerite i mapu neželjene pošte.',
      'verification_email_sent': 'Upravo je poslana nova e-poruka za potvrdu.',
      'location_migration_pending':
          'Priprema prelaska na lokaciju $target još je u tijeku. Možete je nastaviti bez ponovnog stvaranja uređaja.',
      'vpn_sign_in_required':
          'Prijavite se na svoj račun prije pokretanja VPN-a.',
      'protocol_unavailable_at_location':
          'Ova lokacija ne nudi odabrani protokol. Osvježite lokacije ili odaberite drugi protokol.',
      'vpn_permission_denied':
          'Android je odbio dopuštenje za VPN. Ponovno pokrenite vezu i prihvatite zahtjev sustava.',
      'revoked_identity_device_limit':
          'Pristup VPN-u ovog uređaja je uklonjen, a ograničenje uređaja je dosegnuto. Uklonite uređaj u odjeljku Račun → Upravljaj mojim uređajima.',
      'tunnel_start_unexpected':
          'Neočekivana pogreška prekinula je pripremu tunela. Provjerite dijagnostički kôd i pokušajte ponovo.',
      'flutter_disconnect_timeout':
          'Android nije na vrijeme potvrdio da je VPN zaustavljen. Pokušajte ga ponovo zaustaviti.',
      'flutter_disconnect_unexpected':
          'Neočekivana pogreška spriječila je potvrdu da je tunel zaustavljen.',
      'device_revoked':
          'Pristup VPN-u za ovaj uređaj je opozvan, a njegovi lokalni sigurnosni podaci su uklonjeni.',
      'revoke_unexpected':
          'Uređaj nije bilo moguće ukloniti. Osvježite popis i pokušajte ponovo.',
      'identity_renewal_unexpected':
          'Novi VPN identitet nije bilo moguće stvoriti. Osvježite uređaje i pokušajte ponovo.',
      'openvpn_renewal_unexpected':
          'OpenVPN profil nije bilo moguće obnoviti. Pokušajte ponovo ili provjerite dijagnostički kôd.',
      'location_migration_blocked':
          'Poslužitelj trenutačno ne može dovršiti ovu promjenu. Uređaj i njegov lokalni identitet ostali su nepromijenjeni.',
      'location_migration_slow':
          'Poslužitelj još priprema prelazak na lokaciju $target. Za nekoliko trenutaka upotrijebite gumb Nastavi.',
      'location_migration_conflict':
          'Stanje uređaja na poslužitelju se promijenilo. Osvježite uređaje, zatim nastavite promjenu.',
      'location_migration_verification_failed':
          'Poslužitelj nije potvrdio novu lokaciju. Prethodni lokalni identitet ostao je nepromijenjen.',
      'location_migration_device_changed':
          'Uređaj koji je vratio poslužitelj više ne odgovara onome koji se mijenja. Osvježite uređaje prije novog pokušaja.',
      'tunnel_stop_failed':
          'Prethodni tunel mora biti potpuno zaustavljen prije nove veze.',
      'device_clock_ahead':
          'Čini se da sat ovog uređaja žuri. Uključite automatski datum i vrijeme da biste ostali prijavljeni.',
      'other':
          'Radnju nije bilo moguće dovršiti. Pokušajte ponovo ili pošaljite dijagnostički kôd podršci.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesija je istekla',
      'invalid_credentials': 'Prijava nije uspjela',
      'email_verification_required': 'Potrebna je potvrda e-pošte',
      'verification_email_cooldown': 'E-poruka je već poslana',
      'rate_limited': 'Previše pokušaja',
      'invalid_registration': 'Podatke treba ispraviti',
      'email_exists': 'Račun već postoji',
      'invalid_profile': 'Nevažeći profil',
      'invalid_device': 'Nevažeći uređaj',
      'invalid_location': 'Lokacija nije dostupna',
      'device_limit': 'Dosegnuto je ograničenje uređaja',
      'device_exists': 'VPN identitet već se koristi',
      'device_identity_revoked': 'VPN identitet treba obnoviti',
      'device_location_locked': 'Promjenu lokacije treba osvježiti',
      'location_migration_pending': 'Promjena lokacije je u tijeku',
      'location_migration_blocked': 'Promjena lokacije je blokirana',
      'target_ca_mismatch': 'Nekompatibilan OpenVPN poslužitelj',
      'location_migration_conflict': 'Promjenu lokacije treba osvježiti',
      'server_full': 'Poslužitelj je popunjen',
      'capacity_unavailable': 'Lokacija privremeno nije dostupna',
      'target_unavailable': 'Poslužitelj privremeno nije dostupan',
      'not_found': 'Stavka nije pronađena',
      'invalid_openvpn_csr': 'Nevažeći OpenVPN identitet',
      'openvpn_profile_exists': 'OpenVPN profil već postoji',
      'openvpn_profile_revoked': 'OpenVPN profil je opozvan',
      'openvpn_operation_pending': 'OpenVPN radnja je u tijeku',
      'openvpn_operation_terminal': 'OpenVPN radnja je prekinuta',
      'openvpn_address_unavailable': 'OpenVPN adresa nije dostupna',
      'openvpn_profile_conflict': 'Sukob OpenVPN profila',
      'openvpn_signer_unavailable': 'OpenVPN nije dostupan',
      'email_delivery_unavailable': 'Slanje e-pošte nije dostupno',
      'invalid_token': 'Nevažeća poveznica',
      'network_unavailable': 'Internetska veza nije dostupna',
      'invalid_json': 'Nevažeći zahtjev',
      'invalid_api_response': 'Nevažeći odgovor poslužitelja',
      'ipv6_unavailable': 'IPv6 nije dostupan',
      'invalid_ip_families': 'Mrežna konfiguracija odbijena',
      'other': 'Usluga nije dostupna',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Vaša sesija je istekla. Ponovno se prijavite.',
      'invalid_credentials': 'Adresa e-pošte ili lozinka nije točna.',
      'email_verification_required':
          'Prije dodavanja VPN uređaja potvrdite adresu e-pošte.',
      'invalid_registration': 'Provjerite tražene podatke i suglasnosti.',
      'email_exists': 'Za ovu adresu e-pošte već postoji račun.',
      'invalid_profile': 'Provjerite podatke o profilu.',
      'invalid_device':
          'Naziv ovog uređaja ili lokalni identitet nisu ispravni.',
      'invalid_location': 'Osvježite popis lokacija i pokušajte ponovo.',
      'device_limit': 'Prije dodavanja novog uređaja uklonite postojeći.',
      'device_exists': 'Ovaj VPN identitet već je povezan s drugim računom.',
      'device_identity_revoked':
          'Ovaj identitet je uklonjen. Potrebno je stvoriti novi lokalni identitet.',
      'device_location_locked':
          'Lokacija ovog uređaja upravo se promijenila. Aplikacija će nastaviti promjenu koja je u tijeku.',
      'location_migration_pending': 'Promjena lokacije već je u tijeku.',
      'location_migration_blocked':
          'Promjena lokacije zahtijeva intervenciju poslužitelja. Pokušajte ponovo kasnije ili se obratite podršci.',
      'target_ca_mismatch':
          'Ovaj poslužitelj još nije kompatibilan s trenutačnim OpenVPN profilom.',
      'location_migration_conflict':
          'Osvježite uređaje, zatim ponovo pokušajte promijeniti lokaciju.',
      'server_full':
          'Ova je lokacija dosegnula ograničenje broja veza. Odaberite drugu lokaciju ili pokušajte ponovo kasnije.',
      'capacity_unavailable':
          'Trenutačno nije moguće potvrditi je li ova lokacija dostupna. Odaberite drugu lokaciju ili pokušajte ponovo kasnije.',
      'target_unavailable': 'Ovaj poslužitelj privremeno nije dostupan.',
      'not_found': 'Ova stavka više nije dostupna na vašem računu.',
      'invalid_openvpn_csr':
          'Stvorite novi OpenVPN identitet i pokušajte ponovo.',
      'openvpn_profile_exists': 'Za ovaj uređaj već postoji OpenVPN profil.',
      'openvpn_profile_revoked': 'Za nastavak obnovite OpenVPN profil.',
      'openvpn_operation_pending':
          'Promjena se još primjenjuje. Pokušajte ponovo kasnije.',
      'openvpn_operation_terminal':
          'Stvorite novi OpenVPN identitet i pokušajte ponovo.',
      'openvpn_address_unavailable':
          'Trenutačno nije dostupna nijedna OpenVPN adresa.',
      'openvpn_profile_conflict':
          'Profil se promijenio. Osvježite uređaje i pokušajte ponovo.',
      'openvpn_signer_unavailable': 'Usluga OpenVPN privremeno nije dostupna.',
      'email_delivery_unavailable':
          'E-poruku nije bilo moguće poslati. Pokušajte ponovo kasnije.',
      'invalid_token':
          'Ova poveznica nije valjana ili je istekla. Zatražite novu.',
      'network_unavailable': 'Provjerite internetsku vezu i pokušajte ponovo.',
      'invalid_json': 'Provjerite unesene podatke i pokušajte ponovo.',
      'invalid_api_response':
          'Poslužitelj je vratio neočekivan odgovor. Pokušajte ponovo kasnije.',
      'ipv6_unavailable':
          'Poslužitelj trenutačno ne može aktivirati IPv6. Pokušajte ponovo kasnije.',
      'invalid_ip_families':
          'Konfiguracija tunela je nepotpuna ili ne odgovara odobrenim adresama. Pokušajte ponovo iz aplikacije.',
      'other': 'Došlo je do pogreške poslužitelja. Pokušajte ponovo kasnije.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Pokušajte ponovo za nekoliko trenutaka.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Pokušajte ponovo za $seconds sekundi.',
      few: 'Pokušajte ponovo za $seconds sekunde.',
      one: 'Pokušajte ponovo za $seconds sekundu.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Pokušajte ponovo za $minutes minuta.',
      few: 'Pokušajte ponovo za $minutes minute.',
      one: 'Pokušajte ponovo za $minutes minutu.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Pokušajte ponovo za $hours sati.',
      few: 'Pokušajte ponovo za $hours sata.',
      one: 'Pokušajte ponovo za $hours sat.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Nastavak VPN-a sustava nije dostupan',
      'system_vpn_resume_corrupt': 'Nevažeći nastavak VPN-a sustava',
      'system_vpn_resume_session_invalid': 'Nevažeća sesija nastavka VPN-a',
      'system_vpn_resume_identity_changed': 'VPN identitet se promijenio',
      'system_vpn_resume_identity_invalid': 'Nevažeći identitet nastavka VPN-a',
      'system_vpn_resume_storage_failed':
          'Pohrana za nastavak VPN-a nije dostupna',
      'system_vpn_resume_network_timeout': 'Nema mreže za nastavak VPN-a',
      'system_vpn_resume_blocked': 'Nastavak VPN-a je blokiran',
      'system_vpn_resume_failed': 'Nastavak VPN-a nije uspio',
      'system_vpn_resume_error_invalid': 'Nevažeća pogreška nastavka VPN-a',
      'wireguard_identity_store_failed': 'WireGuard identitet nije spremljen',
      'wireguard_identity_unavailable': 'WireGuard identitet nije dostupan',
      'vpn_host_destroyed': 'Android komponenta VPN-a je zaustavljena',
      'vpn_host_unavailable': 'Android komponenta VPN-a nije dostupna',
      'vpn_permission_required': 'Potrebno je dopuštenje za VPN',
      'vpn_permission_denied': 'Dopuštenje za VPN je odbijeno',
      'vpn_permission_request_failed': 'Nije moguće zatražiti dopuštenje',
      'wireguard_foreground_service_unavailable':
          'WireGuard usluga nije dostupna',
      'wireguard_identity_invalid': 'Nevažeći lokalni WireGuard ključ',
      'wireguard_identity_in_use': 'WireGuard identitet je već u upotrebi',
      'wireguard_configuration_invalid': 'Nevažeća WireGuard konfiguracija',
      'wireguard_operation_pending': 'WireGuard radnja je još aktivna',
      'wireguard_start_failed': 'Pokretanje WireGuarda je odbijeno',
      'wireguard_stop_timeout': 'Zaustavljanje WireGuarda nije potvrđeno',
      'wireguard_handshake_timeout': 'WireGuard ne odgovara',
      'openvpn_connection_timeout': 'OpenVPN ne odgovara',
      'openvpn_core_unavailable': 'OpenVPN motor nije dostupan',
      'openvpn_operation_pending': 'OpenVPN sesija je još aktivna',
      'openvpn_stop_timeout': 'Zaustavljanje OpenVPN-a nije potvrđeno',
      'openvpn_profile_unavailable': 'Lokalni OpenVPN profil nedostaje',
      'openvpn_native_failed': 'Izvorni OpenVPN poziv je prekinut',
      'openvpn_key_generation_failed':
          'Nije moguće stvoriti OpenVPN P-256 ključ',
      'openvpn_csr_generation_failed': 'Nije moguće stvoriti OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN identitet nije spremljen',
      'openvpn_identity_clear_failed':
          'Nepotpuno uklanjanje OpenVPN identiteta',
      'openvpn_identity_in_use': 'OpenVPN identitet je još u upotrebi',
      'openvpn_tls_verification_required': 'Nedostaje provjera OpenVPN TLS-a',
      'openvpn_cipher_invalid': 'Nevažeći OpenVPN algoritam šifriranja',
      'openvpn_profile_rejected': 'OpenVPN profil je odbijen',
      'openvpn_identity_inconsistent': 'Nedosljedan OpenVPN identitet',
      'tls_handshake_failed': 'OpenVPN pregovaranje je odbijeno',
      'tls_alert_unknown_ca': 'OpenVPN klijentski certifikat nije prepoznat',
      'tls_alert_bad_certificate': 'OpenVPN klijentski certifikat je odbijen',
      'tls_alert_unsupported_certificate': 'Nepodržani OpenVPN certifikat',
      'tls_client_certificate_required':
          'Potreban je OpenVPN klijentski certifikat',
      'tls_alert_misc': 'OpenVPN TLS upozorenje',
      'tls_signature_algorithm_rejected': 'Nepodržani OpenVPN potpis',
      'tls_handshake_rejected': 'OpenVPN TLS pregovaranje je odbijeno',
      'tls_version_rejected': 'Nekompatibilna OpenVPN TLS verzija',
      'tls_certificate_expired': 'TLS certifikat je istekao',
      'tls_certificate_revoked': 'TLS certifikat je opozvan',
      'transport_failed': 'OpenVPN poslužitelj nije dostupan',
      'tun_configuration_rejected': 'Nije moguće stvoriti OpenVPN sučelje',
      'tun_setup_failed': 'Postavljanje OpenVPN TUN-a nije uspjelo',
      'tun_interface_create_failed': 'Stvaranje OpenVPN sučelja nije uspjelo',
      'tun_interface_disabled': 'OpenVPN sučelje je onemogućeno',
      'tun_halted': 'OpenVPN sučelje je prekinuto',
      'tun_already_established': 'OpenVPN sučelje je već otvoreno',
      'tun_addresses_missing': 'Nedostaje OpenVPN adresa',
      'tun_routes_missing': 'Nedostaju OpenVPN rute',
      'tun_dns_missing': 'Nedostaje OpenVPN DNS',
      'tun_permission_revoked': 'Dopuštenje za VPN je opozvano',
      'tun_establish_returned_null': 'Android je odbio VPN sučelje',
      'openvpn_service_start_failed': 'OpenVPN usluga nije dostupna',
      'openvpn_operation_timeout': 'OpenVPN poziv je istekao',
      'openvpn_start_failed': 'Pokretanje OpenVPN-a je odbijeno',
      'openvpn_connection_failed': 'OpenVPN veza je prekinuta',
      'openvpn_core_status_error': 'OpenVPN Core je završio s pogreškom',
      'openvpn_stopped_before_connected':
          'OpenVPN je zaustavljen prije povezivanja',
      'openvpn_auth_failed': 'OpenVPN autentifikacija je odbijena',
      'openvpn_client_setup_failed': 'Priprema OpenVPN klijenta nije uspjela',
      'openvpn_client_halted': 'OpenVPN klijent je prekinut',
      'openvpn_client_restart': 'Zatraženo je ponovno pokretanje OpenVPN-a',
      'openvpn_inactive_timeout': 'OpenVPN je predugo neaktivan',
      'openvpn_session_expired': 'OpenVPN sesija je istekla',
      'openvpn_credentials_required': 'Nepodržana OpenVPN autentifikacija',
      'openvpn_proxy_failed': 'Posrednički prijenos OpenVPN-a nije uspio',
      'openvpn_compression_failed': 'OpenVPN kompresija je odbijena',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM šifriranje nije dostupno',
      'openvpn_feature_unsupported': 'Nepodržana OpenVPN značajka',
      'network_unavailable': 'Internetska veza nije dostupna',
      'network_lost': 'Mreža nije dostupna',
      'certificate_validation_failed': 'Certifikat poslužitelja je odbijen',
      'openvpn_certificate_expired': 'OpenVPN certifikat je istekao',
      'tunnel_active_for_another_account': 'Tunel drugog računa je još aktivan',
      'tunnel_already_active': 'Izvorni tunel je već aktivan',
      'tunnel_stop_timeout': '$protocol: zaustavljanje nije potvrđeno',
      'tunnel_disconnected': '$protocol: veza je prekinuta',
      'native_bridge_unavailable': 'Android most nije dostupan',
      'native_operation_failed': 'Android radnja je prekinuta',
      'invalid_arguments': 'Nepotpuni VPN parametri',
      'invalid_account_id': 'Nevažeći VPN račun',
      'invalid_device_id': 'Nevažeći identifikator uređaja',
      'storage_key_not_allowed': 'Ključ pohrane je odbijen',
      'secure_storage_read_failed': 'Sigurno čitanje nije uspjelo',
      'secure_storage_write_failed': 'Sigurno spremanje nije uspjelo',
      'key_generation_failed': 'Nije moguće stvoriti WireGuard ključ',
      'csr_generation_failed': 'Nije moguće stvoriti OpenVPN CSR',
      'openvpn_recovery_exhausted': 'Oporavak OpenVPN-a je već iskorišten',
      'openvpn_recovery_failed': 'Oporavak OpenVPN-a nije uspio',
      'openvpn_renewal_required': 'Potrebno je obnoviti OpenVPN certifikat',
      'other': 'Nerazvrstana izvorna VPN pogreška',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ne može pronaći VPN sesiju koju je moguće nastaviti. Pokrenite novu vezu u aplikaciji.',
      'system_vpn_resume_corrupt':
          'Spremljeni podaci za nastavak VPN-a su nevažeći i neće se koristiti. Pokrenite novu vezu.',
      'system_vpn_resume_session_invalid':
          'Spremljena sesija više ne može nastaviti VPN. Ponovno se prijavite u aplikaciji.',
      'system_vpn_resume_identity_changed':
          'Lokalni VPN identitet se promijenio. Nastavak je zaustavljen; pokrenite novu vezu.',
      'system_vpn_resume_identity_invalid':
          'Identitet za nastavak nije ispravan. Pokrenite novu vezu.',
      'system_vpn_resume_storage_failed':
          'Android nije mogao pročitati ili ažurirati šifrirane podatke za nastavak. Pokrenite novu vezu.',
      'system_vpn_resume_network_timeout':
          'Android na vrijeme nije pronašao mrežu za nastavak VPN-a. Pokušajte ponovo kada mreža bude dostupna.',
      'system_vpn_resume_blocked':
          'Nastavak VPN-a je blokiran. Provjerite Android postavke, zatim pokrenite novu vezu.',
      'system_vpn_resume_failed':
          'Android nije uspio nastaviti VPN. Pokrenite novu vezu u aplikaciji.',
      'system_vpn_resume_error_invalid':
          'Android je vratio neupotrebljivu pogrešku nastavka. Pokrenite novu vezu.',
      'wireguard_identity_store_failed':
          'Android nije mogao spremiti šifrirani WireGuard identitet ovog računa.',
      'wireguard_identity_unavailable':
          'Za ovu vezu nije dostupan nijedan upotrebljiv WireGuard identitet.',
      'vpn_host_destroyed':
          'Android komponenta koja je pokretala VPN je zaustavljena. Pokrenite novu vezu.',
      'vpn_host_unavailable':
          'Android ne može stvoriti komponentu koja pokreće VPN. Pokušajte ponovo nakon provjere VPN postavki.',
      'openvpn_renewal_required':
          'Automatska obnova OpenVPN certifikata nije uspjela. Pokrenite novu vezu u aplikaciji.',
      'openvpn_recovery_failed':
          'Automatski oporavak nije uspio. Pokrenite novu vezu u aplikaciji.',
      'openvpn_recovery_exhausted':
          'Automatski oporavak je već iskorišten. Pokrenite novu vezu u aplikaciji.',
      'vpn_permission_required':
          'Android zahtijeva novo dopuštenje za VPN prije pokretanja tunela.',
      'vpn_permission_denied':
          'Dopustite FuzeVPN-u u Androidovu zahtjevu da biste nastavili.',
      'vpn_permission_request_failed':
          'Android nije mogao otvoriti zaslon za dopuštenje za VPN.',
      'wireguard_foreground_service_unavailable':
          'Android nije mogao održati WireGuard uslugu u prvom planu.',
      'wireguard_identity_invalid':
          'Šifrirani WireGuard ključ ovog računa nije čitljiv ili nije ispravan.',
      'wireguard_identity_in_use':
          'Druga radnja još koristi WireGuard ključ ovog računa.',
      'wireguard_configuration_invalid':
          'Primljena WireGuard adresa, DNS, ključ poslužitelja ili rute nisu ispravni.',
      'wireguard_operation_pending':
          'Prethodna WireGuard radnja još nije oslobodila izvornu uslugu.',
      'wireguard_start_failed':
          'WireGuard motor je odbio aktivaciju konfiguracije.',
      'wireguard_stop_timeout':
          'WireGuard usluga nije u zadanom roku potvrdila oslobađanje VPN sučelja.',
      'wireguard_handshake_timeout':
          'Tunel nije na vrijeme potvrdio rukovanje s poslužiteljem.',
      'openvpn_connection_timeout':
          'OpenVPN nije na vrijeme potvrdio vezu s poslužiteljem.',
      'openvpn_core_unavailable':
          'Ova verzija aplikacije ne sadrži upotrebljiv OpenVPN motor.',
      'openvpn_operation_pending':
          'Izvorni motor još drži prethodnu OpenVPN sesiju i odbija stvoriti drugu.',
      'openvpn_stop_timeout':
          'OpenVPN Core nije u zadanom roku potvrdio da je njegova izvorna sesija zaustavljena i uništena.',
      'openvpn_profile_unavailable':
          'Za ovu vezu nije moguće pročitati provjereni OpenVPN profil.',
      'openvpn_native_failed':
          'Pogreška aplikacije prekinula je OpenVPN. Pokušajte se ponovno povezati. Ako se problem nastavi, pokrenite dijagnostiku.',
      'openvpn_key_generation_failed':
          'Android Keystore nije mogao stvoriti ni pročitati privatni P-256 ključ koji se ne može izvesti.',
      'openvpn_csr_generation_failed':
          'Android Keystore ključ nije mogao potpisati zahtjev za OpenVPN certifikat.',
      'openvpn_identity_store_failed':
          'OpenVPN certifikat ili profil nije bilo moguće spremiti u šifriranu pohranu.',
      'openvpn_identity_clear_failed':
          'Android nije mogao ukloniti cijeli lokalni OpenVPN identitet ovog računa.',
      'openvpn_identity_in_use':
          'Izvorna OpenVPN sesija još koristi ključ ili certifikat ovog uređaja.',
      'openvpn_tls_verification_required':
          'Profil izričito ne zahtijeva provjeru certifikata poslužitelja.',
      'openvpn_cipher_invalid':
          'Poslužitelj je poslao algoritam šifriranja koji nije na popisu dopuštenih.',
      'openvpn_profile_rejected':
          'Profil primljen od poslužitelja nije kompatibilan. Ponovno stvorite uređaj i pokušajte ponovo.',
      'openvpn_identity_inconsistent':
          'Certifikat ne odgovara sigurnom identitetu ovog telefona. Nijedan lokalni profil nije zamijenjen.',
      'tls_handshake_failed':
          'Poslužitelj je odbio TLS pregovaranje. Ako se problem nastavi, ponovno stvorite profil.',
      'tls_alert_unknown_ca':
          'Poslužitelj ne prepoznaje izdavatelja certifikata ovog uređaja. Potrebno je provjeriti OpenVPN poslužitelj.',
      'tls_alert_bad_certificate':
          'Poslužitelj je odbio certifikat ovog uređaja. Ponovno stvorite uređaj prije novog pokušaja.',
      'tls_alert_unsupported_certificate':
          'Poslužitelj ne podržava sigurni tip certifikata koji koristi Android.',
      'tls_client_certificate_required':
          'Poslužitelj zahtijeva klijentski certifikat, ali ga OpenVPN Core nije mogao predočiti.',
      'tls_alert_misc':
          'Poslužitelj je vratio TLS upozorenje izvan kategorija certifikata i verzije.',
      'tls_signature_algorithm_rejected':
          'Poslužitelj je odbio algoritam ECDSA P-256 ključa Android Keystore.',
      'tls_handshake_rejected':
          'Poslužitelj je prekinuo TLS pregovaranje prije povezivanja.',
      'tls_version_rejected':
          'Klijent i poslužitelj nisu pronašli zajedničku TLS verziju.',
      'tls_certificate_expired':
          'Certifikat predočen tijekom povezivanja istekao je.',
      'tls_certificate_revoked':
          'Certifikat predočen tijekom povezivanja opozvan je.',
      'transport_failed':
          'OpenVPN poslužitelj trenutno ne odgovara na ovoj mreži. Pokušajte ponovo za nekoliko trenutaka.',
      'tun_configuration_rejected':
          'Android je odbio mrežnu konfiguraciju koju je zatražio OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core je odbio mrežni plan prije stvaranja Android sučelja.',
      'tun_interface_create_failed':
          'OpenVPN Core nije mogao dobiti TUN sučelje preko VpnService-a.',
      'tun_interface_disabled':
          'Android ili OpenVPN Core onemogućio je TUN sučelje tijekom povezivanja.',
      'tun_halted':
          'OpenVPN Core primio je zahtjev za zaustavljanje TUN sučelja.',
      'tun_already_established':
          'OpenVPN je zatražio drugo sučelje u istoj vezi. Tunel je zaustavljen radi sigurnosti.',
      'tun_addresses_missing':
          'Poslužitelj nije poslao upotrebljivu adresu tunela.',
      'tun_routes_missing': 'Poslužitelj nije poslao upotrebljive rute tunela.',
      'tun_dns_missing': 'Poslužitelj nije poslao upotrebljiv DNS poslužitelj.',
      'tun_permission_revoked':
          'Android je opozvao dopuštenje za VPN tijekom povezivanja.',
      'tun_establish_returned_null':
          'Android nije stvorio sučelje, obično zato što je druga VPN veza još aktivna.',
      'openvpn_service_start_failed':
          'Android nije mogao pokrenuti OpenVPN uslugu u prvom planu.',
      'openvpn_operation_timeout':
          'JNI poziv za OpenVPN Core premašio je najdulje dopušteno trajanje.',
      'openvpn_start_failed':
          'Android usluga je spremna, ali OpenVPN Core nije prihvatio pokretanje profila.',
      'openvpn_connection_failed':
          'OpenVPN Core zaustavio se prije slanja događaja CONNECTED.',
      'openvpn_core_status_error':
          'Izvorna OpenVPN petlja završila je s pogreškom bez preciznijeg završnog događaja.',
      'openvpn_stopped_before_connected':
          'Izvorna OpenVPN petlja zaustavila se prije događaja CONNECTED, bez izričite Core pogreške.',
      'openvpn_auth_failed':
          'OpenVPN poslužitelj je odbio autentifikaciju profila.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nije mogao pripremiti klijent prije mrežne veze.',
      'openvpn_client_halted':
          'OpenVPN Core primio je završni zahtjev za zaustavljanje klijenta.',
      'openvpn_client_restart':
          'OpenVPN Core zatražio je ponovno pokretanje svoje prijenosne sesije.',
      'openvpn_inactive_timeout':
          'OpenVPN Core zatvorio je sesiju nakon isteka vremena neaktivnosti.',
      'openvpn_session_expired':
          'Poslužitelj je javio da je OpenVPN sesija istekla.',
      'openvpn_credentials_required':
          'Poslužitelj ili posrednik traži interaktivne podatke za prijavu koji nisu dio ovog profila s certifikatom.',
      'openvpn_proxy_failed':
          'OpenVPN Core prijavio je pogrešku konfiguriranog posrednika ili releja.',
      'openvpn_compression_failed':
          'OpenVPN Core odbio je način kompresije koji je najavio profil ili poslužitelj.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil traži NTLM šifriranje koje nije dostupno u ovoj verziji.',
      'openvpn_feature_unsupported':
          'Profil ili poslužitelj zahtijeva značajku koju ovaj Android klijent nema.',
      'network_unavailable':
          'Nije dostupna nijedna upotrebljiva fizička mreža.',
      'network_lost': 'Tunel je zaustavljen nakon gubitka mreže.',
      'certificate_validation_failed':
          'Identitet OpenVPN poslužitelja nije mogao biti provjeren.',
      'openvpn_certificate_expired':
          'OpenVPN certifikat je istekao. Pokrenite novu vezu u aplikaciji da biste ga obnovili.',
      'tunnel_active_for_another_account':
          'Tunel koji pripada drugom računu mora biti zaustavljen prije ove veze.',
      'tunnel_already_active':
          'Android javlja da prethodna VPN sesija još koristi sučelje.',
      'tunnel_stop_timeout':
          'Motor $protocol nije u zadanom roku potvrdio oslobađanje VPN sučelja.',
      'tunnel_disconnected':
          'Izvorni motor javio je da je tunel neočekivano završio nakon pokretanja.',
      'native_bridge_unavailable':
          'Aplikacija nema pristup Android VPN usluzi. Zatvorite i ponovno otvorite aplikaciju, zatim pokušajte ponovo.',
      'native_operation_failed':
          'Pogreška aplikacije prekinula je VPN radnju. Pokušajte ponovo. Ako se problem nastavi, pokrenite dijagnostiku.',
      'invalid_arguments':
          'Podaci potrebni za ovu VPN radnju nisu potpuni. Pokušajte ponovo. Ako se problem nastavi, pokrenite dijagnostiku.',
      'invalid_account_id':
          'Izvorna radnja nije povezana s valjanim identifikatorom računa.',
      'invalid_device_id':
          'Identifikator uređaja poslan izvornom motoru nedostaje ili nije ispravan.',
      'storage_key_not_allowed':
          'Android most je blokirao ključ koji nije na popisu dopuštenih ključeva za pohranu.',
      'secure_storage_read_failed':
          'Android Keystore nije mogao dešifrirati lokalne podatke ovog računa.',
      'secure_storage_write_failed':
          'Android Keystore nije mogao šifrirati ili spremiti lokalne podatke.',
      'key_generation_failed':
          'Android nije mogao stvoriti ili pročitati WireGuard ključ u sigurnoj pohrani.',
      'csr_generation_failed':
          'Android Keystore nije mogao stvoriti ili potpisati OpenVPN P-256 CSR.',
      'other':
          'Nedokumentirana izvorna grana nije uspjela. Pošaljite dijagnostički kôd prikazan u nastavku podršci.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Zahtjev za dopuštenje već je otvoren';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Androidov zahtjev za dopuštenje za VPN već je prikazan. Dovršite ga prije ponovnog pokušaja.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Zahtjev za dopuštenje za VPN je prekinut';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Zaslon za dopuštenje za VPN zatvoren je prije nego što je aplikacija primila odgovor.';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN veza nije potvrđena';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN vezu nije bilo moguće potvrditi. Zaustavljena je radi sigurnosti. Pokušajte ponovo.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profil je opozvan';

  @override
  String get openvpnCleanup_working =>
      'Zaustavljanje i uklanjanje opozvanog OpenVPN profila…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Zaustavljanje OpenVPN-a nije potvrđeno. Pokušajte ponovo prije stvaranja novog profila.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Opozvani OpenVPN profil nije bilo moguće u potpunosti ukloniti. Ponovite čišćenje.';

  @override
  String get openvpnCleanup_complete =>
      'Opozvani OpenVPN profil je uklonjen. Dodirnite Poveži da biste stvorili novi.';

  @override
  String get network_title => 'Mrežna konfiguracija';

  @override
  String get network_ipv4Fallback =>
      'IPv6 je privremeno nedostupan. Priprema se nastavlja s IPv4.';

  @override
  String get network_rejectedTitle => 'Mrežna konfiguracija odbijena';

  @override
  String get network_rejectedMessage =>
      'Konfiguracija tunela je nepotpuna ili ne odgovara odobrenim adresama. Pokušajte ponovo iz aplikacije.';

  @override
  String get network_unreadableTitle => 'Lokalna konfiguracija nije čitljiva';

  @override
  String get network_unreadableMessage =>
      'Spremljena OpenVPN mrežna konfiguracija ne može se upotrijebiti. Ponovo se povežite iz aplikacije kako biste je ažurirali.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Mrežna zaštita';

  @override
  String get protection_subtitle =>
      'Blokira izravan pristup internetu ako se VPN veza prekine.';

  @override
  String get protection_active => 'Zaštita sustava je aktivna';

  @override
  String get protection_alwaysOnOnly =>
      'Uvijek uključen VPN je omogućen; uključite blokiranje izvan VPN-a';

  @override
  String get protection_inactive => 'Zaštita sustava nije aktivna';

  @override
  String get protection_unknown => 'Provjerite zaštitu sustava';

  @override
  String get protection_openSettings => 'Otvori postavke Androida';

  @override
  String get protection_dialogTitle => 'Postavljanje mrežne zaštite';

  @override
  String get protection_dialogMessage =>
      'Android upravlja uvijek uključenim VPN-om i blokiranjem veza izvan VPN-a. Provjerite je li odabran FuzeVPN i uključite blokiranje u postavkama sustava.';

  @override
  String get protection_dialogOpen => 'Otvori postavke';

  @override
  String get session_systemProtectionNote =>
      'Ako Android i dalje blokira promet izvan VPN-a, otvorite postavke sustava kako biste provjerili ili promijenili tu zaštitu.';

  @override
  String get diagnostics_title => 'Dijagnostika';

  @override
  String get diagnostics_settingsTitle => 'Dijagnostika aplikacije';

  @override
  String get diagnostics_automaticTitle => 'Slanje važnih pogrešaka';

  @override
  String get diagnostics_automaticDescription =>
      'Pošaljite kratko tehničko izvješće kada se dogodi važna pogreška.';

  @override
  String get diagnostics_privacy =>
      'Poslana izvješća povezana su s prijavljenim računom i čuvaju se 30 dana. Ne sadrže povijest pregledavanja, lozinke ni VPN ključeve.';

  @override
  String get diagnostics_manualOpen => 'Pokreni dijagnostiku';

  @override
  String get diagnostics_localDescription =>
      'Izradite izvješće o stanju aplikacije i VPN-a. Vaša veza ostaje nepromijenjena.';

  @override
  String get diagnostics_sendReport => 'Pošalji izvješće';

  @override
  String get diagnostics_sendHint =>
      'Ostavite ovaj okvir neoznačen kako biste izvješće zadržali na ovom uređaju.';

  @override
  String get diagnostics_signedOut =>
      'Prijavite se na svoj račun kako biste poslali izvješće.';

  @override
  String get diagnostics_localLifetime =>
      'Spremite ovo izvješće na telefon kako biste ga zadržali nakon zatvaranja aplikacije.';

  @override
  String get diagnostics_run => 'Pokreni dijagnostiku';

  @override
  String get diagnostics_rerun => 'Ponovo pokreni dijagnostiku';

  @override
  String get diagnostics_running => 'Provjera u tijeku…';

  @override
  String get diagnostics_sending => 'Slanje izvješća…';

  @override
  String get diagnostics_prepared => 'Izvješće je spremno na ovom uređaju';

  @override
  String get diagnostics_queued => 'Izvješće čeka slanje';

  @override
  String get diagnostics_sent => 'Izvješće je primljeno';

  @override
  String get diagnostics_failed =>
      'Slanje nije uspjelo. Vaše lokalno izvješće i dalje je dostupno.';

  @override
  String get diagnostics_preparationFailed =>
      'Dijagnostičko izvješće nije bilo moguće pripremiti. Pokušajte ponovo.';

  @override
  String get diagnostics_authenticationRequired =>
      'Prijavite se ponovo kako biste poslali izvješće.';

  @override
  String get diagnostics_retry => 'Pošalji ponovo';

  @override
  String get diagnostics_export => 'Spremi izvješće';

  @override
  String get diagnostics_exportFailed =>
      'Izvoz nije uspio. Pokušajte ponovo iz lokalnog izvješća.';

  @override
  String get diagnostics_preferenceFailed =>
      'Ovu postavku nije bilo moguće spremiti. Pokušajte ponovo.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referenca: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Primljeno $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Čuva se do $date';
  }

  @override
  String get diagnostics_duplicate => 'Ovo je izvješće već primljeno.';

  @override
  String get diagnostics_preview => 'Pregled izvješća';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priloženo je $count tehničkih događaja',
      few: 'Priložena su $count tehnička događaja',
      one: 'Priložen je $count tehnički događaj',
      zero: 'Nije priložen nijedan tehnički događaj',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tehnički detalji';

  @override
  String get diagnostics_empty =>
      'Dijagnostičko izvješće još nije pripremljeno.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Stanje tunela',
      'handshake': 'Potvrda veze',
      'certificate': 'VPN certifikat',
      'kill_switch': 'Zaštita Androida',
      'connectivity': 'Dostupnost mreže',
      'api_reachability': 'Pristup usluzi',
      'secure_storage': 'Sigurna pohrana',
      'other': 'Lokalna provjera',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Provjereno',
      'failed': 'Potrebna je pozornost',
      'skipped': 'Nije testirano — nema aktivne provjere',
      'unknown': 'Podaci nisu dostupni',
      'other': 'Podaci nisu dostupni',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Dobro došli u FuzeVPN';

  @override
  String get connection_changeLocation => 'Promijeni lokaciju';

  @override
  String get connection_details => 'Pojedinosti veze';

  @override
  String get locations_searchLabel => 'Pretražite grad ili državu';

  @override
  String get locations_clearSearch => 'Obriši pretragu';

  @override
  String get locations_filterAll => 'Sve';

  @override
  String get locations_filterFavorites => 'Favoriti';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokacija',
      few: '$count lokacije',
      one: '$count lokacija',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nema pronađenih lokacija';

  @override
  String get locations_noResultsHint =>
      'Pokušajte s drugim gradom ili državom.';

  @override
  String get locations_noFavorites => 'Vaši favoriti, nadohvat ruke';

  @override
  String get locations_noFavoritesHint =>
      'Dodirnite zvjezdicu uz lokaciju da biste je spremili ovdje.';

  @override
  String get locations_showAll => 'Prikaži sve lokacije';

  @override
  String locations_addFavorite(String name) {
    return 'Dodaj u favorite: $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Ukloni iz favorita: $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Favorit nije bilo moguće spremiti. Pokušajte ponovo.';

  @override
  String get locations_emptyTitle => 'Nema dostupnih lokacija';

  @override
  String get locations_emptyHint => 'Osvježite popis i pokušajte ponovo.';

  @override
  String get devices_manage => 'Upravljaj mojim uređajima';

  @override
  String get settings_personalization => 'Po vašoj mjeri';

  @override
  String get settings_safety => 'Zaštita';

  @override
  String get settings_help => 'Trebate li pomoć?';

  @override
  String get settings_about => 'O aplikaciji FuzeVPN';

  @override
  String get diagnostics_heading => 'Razumijevanje problema s vezom';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Dostupno',
      'pending': 'Priprema se',
      'revoked': 'Uklonjeno',
      'expired': 'Isteklo',
      'other': 'Stanje nije dostupno',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Postavka nije spremljena';

  @override
  String get notice_preferenceSave_message =>
      'Vaš je izbor za sada primijenjen, ali ga nije bilo moguće spremiti. Pokušajte ponovo kako biste ga zadržali nakon zatvaranja aplikacije.';

  @override
  String get connection_androidDisconnectHint =>
      'Ako Android održava VPN aktivnim, isključite opciju „Uvijek uključen VPN” u postavkama koje se otvore.';

  @override
  String get connection_certificate => 'OpenVPN certifikat';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Vrijedi do $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Istekao $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Automatski će se obnoviti pri sljedećem povezivanju.';

  @override
  String get protection_learnMore => 'Saznajte više o zaštiti u Androidu';

  @override
  String get protection_guideWhy =>
      'Ova zaštita sprječava da aplikacije izravno koriste internet ako se VPN prekine. Postavlja se u Androidu.';

  @override
  String get protection_guideAlwaysOnTitle => 'Uvijek uključen VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android održava VPN uslugu aktivnom i može je ponovno pokrenuti nakon restarta telefona.';

  @override
  String get protection_guideBlockTitle => 'Blokiraj veze bez VPN-a';

  @override
  String get protection_guideBlock =>
      'Ova postavka sprječava da promet zaobiđe VPN, čak i dok je veza prekinuta.';

  @override
  String get protection_guideWarning =>
      'Kad je ovo blokiranje uključeno, pristup internetu ostaje isključen dok se VPN ne poveže.';

  @override
  String get protection_guideStepsTitle => 'Uključite zaštitu';

  @override
  String get protection_guideStep1 =>
      'Otvorite Androidove postavke VPN-a pomoću gumba u nastavku.';

  @override
  String get protection_guideStep2 =>
      'Dodirnite ikonu zupčanika pokraj FuzeVPN-a da biste otvorili opcije.';

  @override
  String get protection_guideStep3 =>
      'Uključite „Uvijek uključen VPN”, a zatim „Blokiraj veze bez VPN-a”, ako su te opcije dostupne.';

  @override
  String get protection_guideManufacturers =>
      'Nazivi se razlikuju ovisno o telefonu. Ako je potrebno, potražite „VPN” u postavkama, obično u odjeljku Mreža i internet.';

  @override
  String get protection_guideDisableTitle => 'Isključite ovu zaštitu';

  @override
  String get protection_guideDisable =>
      'U istim postavkama isključite blokiranje veza bez VPN-a da biste dopustili pristup internetu bez VPN-a. Isključite i „Uvijek uključen VPN” ako više ne želite da ga Android ponovno pokreće.';

  @override
  String get protection_guideManual =>
      'Ove postavke određujete u Androidu. FuzeVPN ih ne mijenja umjesto vas.';

  @override
  String get locations_changeTitle => 'Promijeniti lokaciju?';

  @override
  String locations_changeActive(String name) {
    return 'Veza s VPN-om bit će prekinuta, a zatim će se VPN pokušati povezati s lokacijom $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN će se pokušati povezati s lokacijom $name.';
  }

  @override
  String get locations_confirmChange => 'Promijeni i poveži';

  @override
  String get locations_changeBusy =>
      'Promjena je u tijeku. Pričekajte prije odabira druge lokacije.';

  @override
  String get locations_automaticSelection => 'Automatski odabir';

  @override
  String get locations_cities => 'Gradovi';

  @override
  String get locations_servers => 'Poslužitelji';

  @override
  String locations_viewCities(String name) {
    return 'Prikaži gradove: $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Prikaži poslužitelje: $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count država',
      few: '$count države',
      one: '$count država',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gradova',
      few: '$count grada',
      one: '$count grad',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poslužitelja',
      few: '$count poslužitelja',
      one: '$count poslužitelj',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Sve države';

  @override
  String get locations_backToCountries => 'Natrag na države';

  @override
  String locations_backToCities(String name) {
    return 'Natrag na gradove: $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Odaberi: $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Odaberi: $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nije dostupan nijedan kompatibilan poslužitelj.';

  @override
  String get externalLink_failed =>
      'Nije moguće otvoriti ovu poveznicu. Možete je kopirati i otvoriti u pregledniku.';

  @override
  String get externalLink_copy => 'Kopiraj poveznicu';

  @override
  String get externalLink_copied => 'Poveznica je kopirana';

  @override
  String get externalLink_copyFailed =>
      'Nije moguće kopirati poveznicu. Odaberite adresu u nastavku.';

  @override
  String get settings_deleteAccount => 'Izbriši moj račun';

  @override
  String get settings_deleteAccountDetail =>
      'Pogledajte postupak za podnošenje zahtjeva za brisanje računa';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Odaberite pretplatu za VPN.';

  @override
  String get billing_subscribe => 'Pretplati se';

  @override
  String get billing_choosePlan => 'Za nastavak odaberite paket.';

  @override
  String get billing_monthly => 'Mjesečno';

  @override
  String get billing_yearly => 'Godišnje';

  @override
  String get billing_continue => 'Nastavi uz Google Play';

  @override
  String get billing_restore => 'Vrati kupnje';

  @override
  String get billing_manage => 'Upravljaj pretplatom';

  @override
  String get billing_deleteAccountWarning =>
      'Ako imate pretplatu u Google Playu, brisanje računa FuzeVPN ne otkazuje njezinu obnovu. Obnovom možete upravljati ili je otkazati zasebno u Google Playu.';

  @override
  String get billing_deleteAccountContinue =>
      'Nastavi na zahtjev za brisanje računa';

  @override
  String get billing_refresh => 'Osvježi pristup';

  @override
  String get billing_loadingPlans => 'Učitavanje paketa…';

  @override
  String get billing_unavailable =>
      'Trenutačno nema dostupnih paketa. Pokušajte ponovo kasnije.';

  @override
  String get billing_comingSoon => 'Pretplate će uskoro biti dostupne.';

  @override
  String get billing_priceDisclosure =>
      'Cijenu određuje Google Play. Konačni iznos i primjenjivi porezi potvrđuju se prije nego što potvrdite kupnju.';

  @override
  String get billing_renewalMonthly =>
      'Pretplata se automatski obnavlja svaki mjesec dok je ne otkažete. Možete je otkazati bilo kada u pretplatama u Google Playu.';

  @override
  String get billing_renewalYearly =>
      'Pretplata se automatski obnavlja svake godine dok je ne otkažete. Možete je otkazati bilo kada u pretplatama u Google Playu.';

  @override
  String get billing_active => 'Vaš pristup Premiumu je aktivan';

  @override
  String billing_accessUntil(String date) {
    return 'Pristup do $date.';
  }

  @override
  String get billing_webManaged =>
      'Vašom pretplatom upravlja se na web-stranici FuzeVPN.';

  @override
  String get billing_playManaged => 'Vašom pretplatom upravlja Google Play.';

  @override
  String get billing_playOnHold =>
      'Vaša pretplata u Google Playu je na čekanju ili čeka plaćanje. Otvorite „Upravljaj pretplatom” da biste to riješili u Google Playu.';

  @override
  String get billing_playReceiptUnlinked =>
      'Ovaj Google Play račun već ima pretplatu Fuze Premium koja nije aktivna za ovaj FuzeVPN račun. Otvorite „Upravljaj pretplatom” da biste je pregledali u Google Playu.';

  @override
  String get billing_inactive => 'Nema aktivne pretplate.';

  @override
  String get billing_checkingAccess => 'Provjera vašeg pristupa…';

  @override
  String get billing_restoring => 'Vraćanje kupnji…';

  @override
  String get billing_pending =>
      'Plaćanje je na čekanju. Vaš će pristup biti aktiviran nakon potvrde.';

  @override
  String get billing_cancelled =>
      'Kupnja je otkazana. Nijedna nova pretplata nije aktivirana.';

  @override
  String get billing_verifying => 'Provjera kupnje…';

  @override
  String get billing_success =>
      'Pretplata je aktivirana. Vaš pristup Premiumu je spreman.';

  @override
  String get billing_restored => 'Vaše su kupnje vraćene.';

  @override
  String get billing_restoreEmpty =>
      'Za ovaj Google Play račun nema kupnji za vraćanje.';

  @override
  String get billing_catalogError =>
      'Paketi se ne mogu učitati. Pokušajte ponovo.';

  @override
  String get billing_purchaseError =>
      'Kupnju nije moguće pokrenuti. Pokušajte ponovo.';

  @override
  String get billing_verificationError =>
      'Provjera kupnje privremeno nije dostupna. Vratite kupnje da biste pokušali ponovo.';

  @override
  String get billing_restoreError =>
      'Kupnje nije moguće vratiti. Pokušajte ponovo.';

  @override
  String get billing_managementError =>
      'Nije moguće otvoriti upravljanje pretplatom. Pokušajte ponovo.';

  @override
  String get billing_storeUnavailable =>
      'Google Play nije dostupan na ovom uređaju.';

  @override
  String get welcome_title => 'Vaš VPN, jednostavno.';

  @override
  String get welcome_description =>
      'Zaštitite svoju vezu. Zadržite kontrolu nad svojom privatnošću.';

  @override
  String get welcome_start => 'Započni';

  @override
  String get welcome_alreadyPurchased => 'Već ste kupili?';

  @override
  String get welcome_noAccountRequired => 'Za početak nije potreban račun.';

  @override
  String get guest_accountTitle => 'Račun nije povezan';

  @override
  String get guest_accountDescription =>
      'Vratite kupnje s istim Google Play računom da biste pretplatu koristili na drugom uređaju.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Već ste pretplaćeni? Prijavite se';

  @override
  String get guest_claimTitle => 'Ponesite FuzeVPN sa sobom';

  @override
  String get guest_claimDescription =>
      'Izradite račun da biste pretplatu koristili na ostalim uređajima. Ovaj korak nije obavezan.';

  @override
  String get guest_skip => 'Možda kasnije';

  @override
  String get guest_activationTitle => 'Fuze Premium je aktivan';

  @override
  String get guest_activationDescription =>
      'Vaša je pretplata spremna. Možete koristiti VPN i izraditi račun kad god želite.';

  @override
  String get guest_useVpn => 'Koristi moj VPN';

  @override
  String get guest_loginRequired =>
      'Ova je kupnja već povezana s računom FuzeVPN. Prijavite se na taj račun da biste pristupili pretplati.';

  @override
  String get guest_signOutWarning =>
      'Pretplatu možete vratiti vraćanjem kupnji s istim Google Play računom.';

  @override
  String get guest_profileUnavailable =>
      'Vaš je račun već povezan. Prijavite se da biste pregledali svoje podatke i upravljali njima.';

  @override
  String get billing_acceptance =>
      'Nastavkom prihvaćate Uvjete korištenja i Pravila o privatnosti.';

  @override
  String get guest_verifyEmailReminder =>
      'Potvrdite svoju adresu e-pošte da biste osigurali račun. Možete nastaviti koristiti VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Usluga privremeno nije dostupna. Pokušajte ponovo za nekoliko trenutaka.';

  @override
  String get guest_restoreError =>
      'Vaše kupnje nije bilo moguće vratiti. Pokušajte ponovo s Google Play računom koji ste upotrijebili za kupnju.';

  @override
  String get guest_claimSuccess =>
      'Vaš je račun izrađen. Vaša su pretplata i pristup VPN-u zadržani.';

  @override
  String get guest_emailExists =>
      'Ova adresa e-pošte već se koristi. Odaberite drugu adresu ili se prijavite na postojeći račun. Vaša kupnja ostaje dostupna putem Google Playa.';

  @override
  String get guest_claimError =>
      'Vaš račun nije bilo moguće izraditi. Možete nastaviti koristiti VPN i pokušati ponovo kasnije.';

  @override
  String get guest_secureStorageError =>
      'Vašu sesiju nije bilo moguće zaštititi na ovom uređaju. Pokušajte ponovo.';

  @override
  String get guest_premiumRequired =>
      'Odaberite pretplatu da biste aktivirali VPN.';

  @override
  String get welcome_viewPlans => 'Pregledaj pakete';

  @override
  String get google_continue => 'Nastavi s Googleom';

  @override
  String get google_or => 'ili';

  @override
  String get google_title => 'Vaš račun FuzeVPN';

  @override
  String get google_settingUp => 'Dovršite izradu računa';

  @override
  String get google_country => 'Država prebivališta';

  @override
  String get google_profileDescription =>
      'Odaberite državu i pregledajte oba dokumenta za izradu računa FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Povežite svoj gostujući račun s Googleom. Vaša pretplata i uređaj ostaju povezani s ovim računom.';

  @override
  String get google_linkTitle => 'Povežite Google s FuzeVPN-om';

  @override
  String get google_linkDescription =>
      'Potvrdite pristup svom postojećem računu FuzeVPN. Ovaj korak ne traži vašu Google lozinku.';

  @override
  String get google_password => 'Lozinka za FuzeVPN';

  @override
  String get google_linkAccount => 'Potvrdi povezivanje';

  @override
  String get google_requestEmail => 'Pošalji mi e-poruku za potvrdu';

  @override
  String get google_emailInstructions =>
      'Otvorite e-poruku koju je poslao FuzeVPN i unesite kôd za potvrdu.';

  @override
  String get google_emailCode => 'Kôd za potvrdu iz e-poruke';

  @override
  String get google_confirmEmail => 'Potvrdi kôd';

  @override
  String get google_restart => 'Odaberi drugi Google račun';

  @override
  String get google_resume => 'Provjeri ovaj pokušaj';

  @override
  String get google_unavailable =>
      'Prijava putem Googlea nije dostupna. Možete se prijaviti e-poštom i lozinkom.';

  @override
  String get google_expired =>
      'Ovaj je pokušaj istekao. Otkažite ga i počnite ponovo.';

  @override
  String get google_conflict =>
      'Ovaj je Google račun već povezan drugdje. Vaš trenutačni račun i pretplata ostaju nepromijenjeni.';

  @override
  String get google_error =>
      'Prijava putem Googlea nije uspjela. Pokušajte ponovo; vaš trenutačni pristup ostaje nepromijenjen.';

  @override
  String get google_uncertain =>
      'Rezultat nije bilo moguće potvrditi. Provjerite ovaj pokušaj ili ga otkažite prije nego što ponovno počnete.';

  @override
  String get google_cancelFailed =>
      'Otkazivanje nije bilo moguće potvrditi. Pokušajte ponovo otkazati prije napuštanja ovog zaslona.';

  @override
  String get google_cancelled => 'Prijava putem Googlea je otkazana.';

  @override
  String get google_selecting => 'Odaberite svoj Google račun…';

  @override
  String get google_verifying => 'Provjera vašeg računa…';

  @override
  String get google_emailUnavailable =>
      'E-poruku za potvrdu nije bilo moguće poslati. Pokušajte ponovo kasnije.';

  @override
  String get google_emailSent =>
      'E-poruka za potvrdu je poslana. Provjerite pristiglu poštu.';

  @override
  String get google_rateLimited => 'Pričekajte prije novog pokušaja.';

  @override
  String get google_busy =>
      'Google nije dostupan dok je u tijeku druga radnja (VPN veza, račun ili gostujući račun). Pokušajte ponovo kad ona završi; vaš trenutačni pristup ostaje nepromijenjen.';

  @override
  String get google_invalidPassword =>
      'Lozinka za FuzeVPN nije ispravna. Vaš trenutačni račun ostaje nepromijenjen.';

  @override
  String get google_invalidCode => 'Kôd za potvrdu nije valjan ili je istekao.';

  @override
  String get google_accountChanged =>
      'Vaša se sesija promijenila. Otkažite ovaj pokušaj prije nego što ponovno počnete.';

  @override
  String get google_invalidResponse =>
      'Valjanost odgovora nije bilo moguće potvrditi. Vaš trenutačni pristup ostaje nepromijenjen.';

  @override
  String get google_invalidRegistration =>
      'Provjerite državu i obje suglasnosti.';

  @override
  String get google_consentRequired =>
      'Odaberite državu i prihvatite oba dokumenta da biste nastavili.';

  @override
  String get google_challengeRequired =>
      'Potrebna je dodatna sigurnosna provjera. Vaš trenutačni pristup ostaje nepromijenjen.';

  @override
  String get google_challengeUnavailable =>
      'Sigurnosna provjera nije dostupna. Pokušajte ponovo kasnije.';

  @override
  String get google_intentMismatch =>
      'Prethodna prijava putem Googlea još je na čekanju. Otkažite je prije pokretanja ove radnje.';

  @override
  String get google_challengeBlocked =>
      'Potrebna sigurnosna provjera nije dostupna u ovoj aplikaciji. Ova se radnja trenutačno ne može dovršiti.';

  @override
  String get google_solveChallenge => 'Dovrši sigurnosnu provjeru';

  @override
  String get google_challengeTitle => 'Sigurnosna provjera';

  @override
  String get google_challengeReady =>
      'Provjera je dovršena. Sada možete potvrditi izradu računa.';

  @override
  String get google_challengeExpired =>
      'Provjera je istekla. Ponovite je prije potvrde.';

  @override
  String get google_challengeCancelled =>
      'Provjera je otkazana. Možete je ponoviti.';

  @override
  String get google_challengeFailed =>
      'Sigurnosna provjera nije uspjela. Pokušajte ponovo.';

  @override
  String get billing_trialTitle => 'Isprobajte Fuze Premium besplatno';

  @override
  String get billing_trialSubtitle => 'Zaštitite svoju vezu već od danas.';

  @override
  String get billing_trialWeeks => 'Besplatno probno razdoblje od 2 tjedna';

  @override
  String billing_trialDays(String days) {
    return 'Besplatno probno razdoblje od $days dana';
  }

  @override
  String get billing_trialStart => 'Započni besplatno probno razdoblje';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ako počnete danas, prva naplata predviđena je za $date.';
  }

  @override
  String get billing_trialTerms =>
      'Pretplata se automatski obnavlja po navedenoj cijeni. Da biste izbjegli naplatu, otkažite je u Google Playu prije kraja probnog razdoblja.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Zatim $price mjesečno';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Zatim $price godišnje';
  }

  @override
  String get billing_choosePeriod => 'Odaberite paket';

  @override
  String get billing_selectionHint => 'Odaberite paket za nastavak.';

  @override
  String get billing_benefitConnection => 'Šifrirana veza';

  @override
  String get billing_benefitPrivacy => 'Privatnost na internetu';

  @override
  String get billing_benefitNoAccount => 'Nije potrebna registracija';

  @override
  String get billing_cancellation => 'Otkazivanje u Google Playu';

  @override
  String get billing_premiumTitle => 'Bolje zaštićena veza.';

  @override
  String get billing_premiumSubtitle =>
      'Zaštitite svoju vezu vlastitim tempom.';

  @override
  String get billing_priceMonthly => 'mjesečno';

  @override
  String get billing_priceYearly => 'godišnje';

  @override
  String get billing_trialToday => 'Danas ništa ne plaćate';

  @override
  String get billing_trialConfirmation =>
      'Google Play potvrđuje datume, konačni iznos i primjenjive poreze prije nego što potvrdite.';

  @override
  String get billing_offerChanged =>
      'Uvjeti ove ponude promijenili su se. Osvježite pakete i odaberite ponovo.';

  @override
  String get status_waitingNetwork => 'Čeka se mreža';

  @override
  String get status_waitingNetworkDetail =>
      'Mreža nije dostupna. VPN će provjeriti vezu kad mreža ponovno bude dostupna.';

  @override
  String get locations_favoriteLoadFailed =>
      'Favorite nije bilo moguće učitati. Pokušajte ponovo.';

  @override
  String get locations_favoritesLoading => 'Učitavanje favorita…';
}
