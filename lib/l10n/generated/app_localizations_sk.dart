// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Chráňte svoje pripojenie';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN používa službu VPN systému Android (VpnService) na vytvorenie šifrovaného tunela medzi týmto zariadením a servermi FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Keď je VPN aktívna, internetová komunikácia vašich aplikácií, cieľové adresy a požiadavky DNS prechádzajú týmto tunelom na smerovanie vášho pripojenia, a to aj vtedy, keď FuzeVPN beží na pozadí.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikácia používa stav pripojenia, jeho trvanie a objem prenesených údajov na zobrazenie vášho VPN pripojenia. Kedykoľvek ho môžete zastaviť.';

  @override
  String get vpnDisclosure_privacy => 'Ochrana súkromia';

  @override
  String get vpnDisclosure_accept => 'Prijať a pokračovať';

  @override
  String get vpnDisclosure_decline => 'Teraz nie';

  @override
  String get accountRestoration_title => 'Účet je dočasne nedostupný';

  @override
  String get accountRestoration_message =>
      'Vaša relácia zostala zachovaná. Ak chcete obnoviť účet, skúste to znova. VPN pripojenie môžete spravovať aj tu.';

  @override
  String get action_retry => 'Skúsiť znova';

  @override
  String get session_endingTitle => 'Ukončenie relácie';

  @override
  String get session_ending =>
      'Ukončuje sa relácia: VPN sa zastavuje a prebieha vyčistenie…';

  @override
  String get session_stopFailed =>
      'Vypnutie VPN nebolo potvrdené. Pred novým prihlásením to skúste znova.';

  @override
  String get session_cleanupFailed =>
      'VPN je zastavená, ale odstránenie relácie nebolo potvrdené. Skúste vyčistenie znova.';

  @override
  String get session_retryStop => 'Skúsiť vypnutie znova';

  @override
  String get session_retryCleanup => 'Skúsiť vyčistenie znova';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Bezpečne pripravujeme FuzeVPN…';

  @override
  String get nav_connection => 'Pripojenie';

  @override
  String get nav_locations => 'Lokality';

  @override
  String get nav_account => 'Účet';

  @override
  String get nav_devices => 'Zariadenia';

  @override
  String get nav_settings => 'Nastavenia';

  @override
  String get action_refresh => 'Obnoviť';

  @override
  String get auth_tab_login => 'Prihlásiť sa';

  @override
  String get auth_tab_register => 'Registrácia';

  @override
  String get auth_stepAccount => 'Účet';

  @override
  String get auth_stepIdentity => 'Identita';

  @override
  String get auth_stepAddress => 'Adresa a súhlasy';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Krok $current z $total';
  }

  @override
  String get auth_tagline => 'Vaša VPN, jednoducho.';

  @override
  String get auth_keysLocal =>
      'Vaše súkromné kľúče VPN zostávajú v tomto zariadení.';

  @override
  String get form_email => 'E-mailová adresa';

  @override
  String get form_password => 'Heslo';

  @override
  String get form_showPassword => 'Zobraziť heslo';

  @override
  String get form_hidePassword => 'Skryť heslo';

  @override
  String get form_passwordMin =>
      '8–72 bajtov UTF-8. Niektoré znaky zaberajú viac ako jeden bajt.';

  @override
  String get form_firstName => 'Meno';

  @override
  String get form_lastName => 'Priezvisko';

  @override
  String get form_phone => 'Telefón (+33612345678)';

  @override
  String get form_address => 'Adresa';

  @override
  String get form_address2 => 'Doplnok k adrese (nepovinné)';

  @override
  String get form_postalCode => 'PSČ';

  @override
  String get form_city => 'Mesto';

  @override
  String get form_country => 'Kód krajiny (napr. FR)';

  @override
  String get action_login => 'Prihlásiť sa';

  @override
  String get action_createAccount => 'Vytvoriť účet';

  @override
  String get action_createMyAccount => 'Vytvoriť môj účet';

  @override
  String get action_next => 'Pokračovať';

  @override
  String get action_previous => 'Späť';

  @override
  String get action_forgotPassword => 'Zabudli ste heslo?';

  @override
  String get auth_noAccount => 'Ešte nemáte účet?';

  @override
  String get auth_requiredInformation => 'Vytvorte si účet v troch krokoch.';

  @override
  String get auth_termsPrefix => 'Súhlasím s ';

  @override
  String get auth_termsLink => 'podmienkami používania';

  @override
  String get auth_privacyPrefix => 'Súhlasím so ';

  @override
  String get auth_privacyLink => 'zásadami ochrany osobných údajov';

  @override
  String get auth_consentRequired =>
      'Na vytvorenie účtu je potrebný váš súhlas.';

  @override
  String get validation_required => 'Toto pole je povinné.';

  @override
  String get validation_email => 'Zadajte platnú e-mailovú adresu.';

  @override
  String get validation_password =>
      'Heslo je príliš krátke: musí mať aspoň 8 bajtov UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Heslo je príliš dlhé: môže mať najviac 72 bajtov UTF-8.';

  @override
  String get validation_phone =>
      'Použite medzinárodný formát, napríklad +33612345678.';

  @override
  String get validation_country =>
      'Použite dvojpísmenový kód krajiny, napríklad FR.';

  @override
  String get passwordReset_title => 'Obnovenie hesla';

  @override
  String get passwordReset_description =>
      'Zadajte e-mailovú adresu svojho účtu a požiadajte o odkaz na obnovenie hesla.';

  @override
  String get passwordReset_send => 'Odoslať odkaz';

  @override
  String get connection_title => 'Vaše pripojenie';

  @override
  String get connection_subtitle => 'Vyberte lokalitu a potom zapnite VPN.';

  @override
  String get connection_prepare => 'Pripravení na pripojenie?';

  @override
  String get connection_advancedOptions => 'Rozšírené možnosti';

  @override
  String get connection_location => 'Lokalita';

  @override
  String get connection_chooseLocation => 'Vyberte lokalitu';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Pripojiť';

  @override
  String get connection_connecting => 'Pripájanie…';

  @override
  String get connection_disconnect => 'Odpojiť';

  @override
  String get connection_disconnecting => 'Odpájanie';

  @override
  String get connection_locationChange => 'Mení sa lokalita…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nie je k dispozícii';
  }

  @override
  String get connection_activeLocation => 'Aktívna lokalita';

  @override
  String get connection_duration => 'Trvanie';

  @override
  String get connection_received => 'Prijaté';

  @override
  String get connection_sent => 'Odoslané';

  @override
  String get connection_lastHandshake => 'Posledná bezpečná výmena';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'pred $duration';
  }

  @override
  String get verification_title => 'Potvrďte svoju e-mailovú adresu';

  @override
  String get verification_message =>
      'Potvrďte svoju e-mailovú adresu, aby ste mohli používať VPN v tomto telefóne.';

  @override
  String get verification_resend => 'Znova odoslať e-mail';

  @override
  String get migration_title => 'Zmena lokality';

  @override
  String get migration_draining => 'Pripravuje sa zmena lokality…';

  @override
  String get migration_activating => 'Aktivuje sa nový server…';

  @override
  String get migration_ready => 'Lokalita bola aktualizovaná.';

  @override
  String get migration_blocked =>
      'Zmena lokality vyžaduje zásah na serveri. Skúste to neskôr alebo kontaktujte podporu.';

  @override
  String get migration_progress => 'Priebeh zmeny lokality';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Čas medzi kontrolami: $seconds s.';
  }

  @override
  String get migration_resume => 'Pokračovať v zmene lokality';

  @override
  String get status_authorizing => 'Vyžaduje sa oprávnenie';

  @override
  String get status_authorizingDetail =>
      'Potvrďte žiadosť systému Android o povolenie VPN.';

  @override
  String get status_preparing => 'Príprava';

  @override
  String get status_preparingDetail =>
      'Pripravuje sa vaše zabezpečené pripojenie.';

  @override
  String get status_reconnecting => 'Opätovné pripájanie…';

  @override
  String get status_reconnectingDetail =>
      'Pripojenie bolo prerušené. VPN sa pokúša znova pripojiť.';

  @override
  String get status_connecting => 'Pripájanie';

  @override
  String get status_connectingDetail => 'Pripájanie k serveru VPN…';

  @override
  String get status_connected => 'Pripojené';

  @override
  String get status_connectedDetail => 'Vaše VPN pripojenie je aktívne.';

  @override
  String get status_disconnecting => 'Odpájanie';

  @override
  String get status_disconnectingDetail => 'Vaše VPN pripojenie sa ukončuje.';

  @override
  String get status_error => 'Pripojenie nie je k dispozícii';

  @override
  String get status_errorDetail =>
      'VPN pripojenie nebolo potvrdené. Skúste to znova.';

  @override
  String get status_idle => 'Odpojené';

  @override
  String get status_idleDetail => 'Pripojte VPN a chráňte svoje pripojenie.';

  @override
  String get trust_note =>
      'Zatvorenie aplikácie nezastaví VPN. Na zastavenie použite možnosť Odpojiť.';

  @override
  String get locations_none =>
      'Momentálne nie sú k dispozícii žiadne lokality.';

  @override
  String get locations_available => 'Vyberte ďalšiu lokalitu.';

  @override
  String get locations_selected => 'Vybraná lokalita';

  @override
  String get locations_select => 'Vybrať túto lokalitu';

  @override
  String get locations_lockedTunnel =>
      'Ak chcete zmeniť lokalitu, odpojte VPN.';

  @override
  String get locations_lockedMigration =>
      'Počkajte, kým sa zmena lokality dokončí.';

  @override
  String get devices_title => 'Vaše zariadenia';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit zariadení';
  }

  @override
  String get devices_refresh => 'Obnoviť zariadenia';

  @override
  String get devices_empty =>
      'Zatiaľ nie je zaregistrované žiadne zariadenie VPN.';

  @override
  String get devices_firstConnection =>
      'Váš telefón sa pridá pri prvom pripojení.';

  @override
  String get devices_thisDevice => 'Toto zariadenie';

  @override
  String devices_added(Object date) {
    return 'Pridané $date';
  }

  @override
  String get devices_unnamed => 'Nepomenované zariadenie';

  @override
  String get action_remove => 'Odstrániť';

  @override
  String get settings_title => 'Nastavenia';

  @override
  String get settings_subtitle => 'Vaše predvoľby a účet na jednom mieste.';

  @override
  String get settings_appearance => 'Vzhľad';

  @override
  String get settings_language => 'Jazyk';

  @override
  String get settings_languageDescription =>
      'Zvolený jazyk sa použije aj v upozorneniach VPN.';

  @override
  String get settings_account => 'Účet';

  @override
  String get settings_signOut => 'Odhlásiť sa';

  @override
  String get settings_privacy => 'Zásady ochrany osobných údajov';

  @override
  String get settings_terms => 'Podmienky používania';

  @override
  String get settings_security => 'Bezpečnosť a transparentnosť';

  @override
  String get settings_licenses => 'Licencie komponentov';

  @override
  String get settings_licensesDetail => 'Softvér použitý v aplikácii';

  @override
  String settings_licensesLegalese(String url) {
    return 'Zdrojový kód aplikácie a jej komponentov s licenciou MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN zostane zapnutá, keď opustíte aplikáciu. Na jej zastavenie použite možnosť Odpojiť na karte Pripojenie.';

  @override
  String get theme_system => 'Podľa systému';

  @override
  String get theme_light => 'Svetlý';

  @override
  String get theme_dark => 'Tmavý';

  @override
  String get language_system => 'Jazyk telefónu';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Odstrániť toto zariadenie?';

  @override
  String get dialog_removeCurrent =>
      'Tento telefón sa odpojí od VPN a stratí prístup. Údaje o jeho pripojení k VPN sa odstránia po potvrdení zo strany servera.';

  @override
  String dialog_removeOther(Object name) {
    return 'Prístup k VPN pre „$name“ bude odobratý. Túto akciu nie je možné vrátiť späť.';
  }

  @override
  String get dialog_signOut => 'Odhlásiť sa?';

  @override
  String get dialog_signOutMessage =>
      'VPN sa zastaví a budete sa musieť znova prihlásiť. Vaše šifrované kľúče VPN zostanú v tomto telefóne na ďalšie pripojenie.';

  @override
  String get action_cancel => 'Zrušiť';

  @override
  String get action_close => 'Zavrieť';

  @override
  String get action_copy => 'Kopírovať';

  @override
  String get action_renew => 'Obnoviť';

  @override
  String get action_signOut => 'Odhlásiť sa';

  @override
  String get notice_close => 'Zavrieť správu';

  @override
  String get notice_sessionExpired_title => 'Relácia vypršala';

  @override
  String get notice_sessionExpired_message =>
      'Vaša relácia vypršala. Prihláste sa znova.';

  @override
  String get notice_connectionFailed_title => 'Pripojenie zlyhalo';

  @override
  String get notice_invalidCredentials_message =>
      'Nesprávna e-mailová adresa alebo heslo.';

  @override
  String get notice_emailVerification_title => 'Vyžaduje sa potvrdenie e-mailu';

  @override
  String get notice_emailVerification_message =>
      'Pred pridaním zariadenia VPN potvrďte svoju e-mailovú adresu.';

  @override
  String get notice_rateLimited_title => 'Príliš veľa pokusov';

  @override
  String get notice_deviceLimit_title => 'Dosiahnutý limit zariadení';

  @override
  String get notice_deviceLimit_message =>
      'Pred pridaním ďalšieho zariadenia odstráňte jedno existujúce.';

  @override
  String get notice_identityRenewal_title => 'Identitu VPN je potrebné obnoviť';

  @override
  String get notice_identityRenewal_message =>
      'Táto identita bola odstránená. Vytvorte novú lokálnu identitu.';

  @override
  String get notice_migrationPending_title => 'Prebieha zmena lokality';

  @override
  String get notice_migrationPending_message => 'Zmena lokality už prebieha.';

  @override
  String get notice_migrationBlocked_title => 'Zmena lokality je zablokovaná';

  @override
  String get notice_migrationBlocked_message =>
      'Zmena lokality vyžaduje zásah na serveri. Skúste to neskôr alebo kontaktujte podporu.';

  @override
  String get notice_targetUnavailable_title => 'Server je dočasne nedostupný';

  @override
  String get notice_targetUnavailable_message =>
      'Tento server je dočasne nedostupný.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetové pripojenie nie je k dispozícii';

  @override
  String get notice_networkUnavailable_message =>
      'Skontrolujte pripojenie a skúste to znova.';

  @override
  String get notice_permissionDenied_title =>
      'Oprávnenie pre VPN bolo zamietnuté';

  @override
  String get notice_permissionDenied_message =>
      'Spustite pripojenie znova a potvrďte žiadosť systému Android o oprávnenie.';

  @override
  String get notice_wireguardTimeout_title => 'Server neodpovedá';

  @override
  String get notice_wireguardTimeout_message =>
      'Pripojenie WireGuard trvalo príliš dlho. Skúste to znova alebo vyberte inú lokalitu.';

  @override
  String get notice_tlsFailed_title => 'Zabezpečené pripojenie bolo odmietnuté';

  @override
  String get notice_tlsFailed_message =>
      'Server neprijal pripojenie OpenVPN. Skúste to znova. Ak problém pretrváva, spustite diagnostiku.';

  @override
  String get notice_tunRejected_title => 'Android odmietol rozhranie VPN';

  @override
  String get notice_tunRejected_message =>
      'Android odmietol sieťovú konfiguráciu, ktorú požadoval OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN sa nepodarilo spustiť';

  @override
  String get notice_openvpnStart_message =>
      'Modul OpenVPN sa nepodarilo úplne spustiť. Skúste to znova. Ak problém pretrváva, kontaktujte podporu.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostický kód: $code';
  }

  @override
  String get notice_generic_title => 'VPN pripojenie zlyhalo';

  @override
  String get notice_generic_message => 'Došlo k chybe. Skúste to neskôr.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Účet bol vytvorený',
      'password_reset_sent': 'Žiadosť o obnovenie hesla bola prijatá',
      'verification_email_sent': 'Overovací e-mail bol odoslaný',
      'location_migration_pending': 'Prebieha zmena lokality',
      'vpn_sign_in_required': 'Vyžaduje sa prihlásenie',
      'protocol_unavailable_at_location': 'Protokol nie je k dispozícii',
      'vpn_permission_denied': 'Oprávnenie pre VPN bolo zamietnuté',
      'revoked_identity_device_limit': 'Dosiahnutý limit zariadení',
      'tunnel_start_unexpected': 'VPN sa nepodarilo spustiť',
      'flutter_disconnect_timeout': 'Odpojenie nebolo potvrdené',
      'flutter_disconnect_unexpected': 'Nepodarilo sa odpojiť',
      'device_revoked': 'Zariadenie bolo odstránené',
      'revoke_unexpected': 'Zariadenie sa nepodarilo odstrániť',
      'identity_renewal_unexpected': 'Identitu sa nepodarilo obnoviť',
      'openvpn_renewal_unexpected': 'Profil OpenVPN sa nepodarilo obnoviť',
      'location_migration_blocked': 'Zmena lokality je zablokovaná',
      'location_migration_slow': 'Zmena lokality stále prebieha',
      'location_migration_conflict': 'Zmenu lokality je potrebné obnoviť',
      'location_migration_verification_failed':
          'Zmena lokality nebola potvrdená',
      'location_migration_device_changed':
          'Zariadenie sa počas zmeny lokality zmenilo',
      'tunnel_stop_failed': 'Zmena lokality nie je k dispozícii',
      'device_clock_ahead': 'Hodiny zariadenia idú napred',
      'other': 'Operácia zlyhala',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Účet bol vytvorený, ale overovací e-mail sa nepodarilo odoslať. V aplikácii použite možnosť Znova odoslať e-mail.',
      'password_reset_sent':
          'Vaša žiadosť bola prijatá. Ak k tejto adrese patrí účet, môžete dostať e-mail. Skontrolujte aj priečinok so spamom.',
      'verification_email_sent': 'Práve bol odoslaný nový overovací e-mail.',
      'location_migration_pending':
          'Presun na lokalitu $target sa stále pripravuje. Môžete v ňom pokračovať bez opätovného vytvárania zariadenia.',
      'vpn_sign_in_required': 'Pred spustením VPN sa prihláste do svojho účtu.',
      'protocol_unavailable_at_location':
          'Vybraný protokol táto lokalita neponúka. Obnovte lokality alebo vyberte iný protokol.',
      'vpn_permission_denied':
          'Android zamietol oprávnenie pre VPN. Spustite pripojenie znova a potvrďte systémovú žiadosť.',
      'revoked_identity_device_limit':
          'Prístup k VPN pre toto zariadenie bol odobratý a dosiahli ste limit zariadení. Odstráňte zariadenie v časti Účet → Spravovať moje zariadenia.',
      'tunnel_start_unexpected':
          'Neočakávaná chyba prerušila prípravu tunela. Skontrolujte diagnostický kód a skúste to znova.',
      'flutter_disconnect_timeout':
          'Android včas nepotvrdil zastavenie VPN. Skúste ju zastaviť znova.',
      'flutter_disconnect_unexpected':
          'Neočakávaná chyba zabránila potvrdeniu zastavenia tunela.',
      'device_revoked':
          'Prístup tohto zariadenia k VPN bol odobratý a jeho lokálne tajné údaje boli odstránené.',
      'revoke_unexpected':
          'Zariadenie sa nepodarilo odstrániť. Obnovte zoznam a skúste to znova.',
      'identity_renewal_unexpected':
          'Novú identitu VPN sa nepodarilo vytvoriť. Obnovte zariadenia a skúste to znova.',
      'openvpn_renewal_unexpected':
          'Profil OpenVPN sa nepodarilo obnoviť. Skúste to znova alebo skontrolujte diagnostický kód.',
      'location_migration_blocked':
          'Server momentálne nemôže túto zmenu dokončiť. Zariadenie a jeho lokálna identita boli zachované.',
      'location_migration_slow':
          'Server stále pripravuje presun na lokalitu $target. O chvíľu použite možnosť Pokračovať.',
      'location_migration_conflict':
          'Stav zariadenia sa na serveri zmenil. Obnovte zariadenia a potom pokračujte v zmene.',
      'location_migration_verification_failed':
          'Server nepotvrdil novú lokalitu. Predchádzajúca lokálna identita bola zachovaná.',
      'location_migration_device_changed':
          'Zariadenie vrátené serverom sa už nezhoduje so zariadením, pre ktoré sa lokalita mení. Pred ďalším pokusom obnovte zariadenia.',
      'tunnel_stop_failed':
          'Pred novým pripojením sa musí úplne zastaviť predchádzajúci tunel.',
      'device_clock_ahead':
          'Hodiny tohto zariadenia idú napred. Zapnite automatický dátum a čas, aby ste zostali prihlásení.',
      'other':
          'Operáciu sa nepodarilo dokončiť. Skúste to znova alebo odošlite diagnostický kód podpore.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Relácia vypršala',
      'invalid_credentials': 'Prihlásenie zlyhalo',
      'email_verification_required': 'Vyžaduje sa potvrdenie e-mailu',
      'verification_email_cooldown': 'E-mail už bol odoslaný',
      'rate_limited': 'Príliš veľa pokusov',
      'invalid_registration': 'Údaje treba opraviť',
      'email_exists': 'Účet už existuje',
      'invalid_profile': 'Neplatný profil',
      'invalid_device': 'Neplatné zariadenie',
      'invalid_location': 'Lokalita nie je k dispozícii',
      'device_limit': 'Dosiahnutý limit zariadení',
      'device_exists': 'Identita VPN sa už používa',
      'device_identity_revoked': 'Identitu VPN je potrebné obnoviť',
      'device_location_locked': 'Zmenu lokality je potrebné obnoviť',
      'location_migration_pending': 'Prebieha zmena lokality',
      'location_migration_blocked': 'Zmena lokality je zablokovaná',
      'target_ca_mismatch': 'Nekompatibilný server OpenVPN',
      'location_migration_conflict': 'Zmenu lokality je potrebné obnoviť',
      'server_full': 'Server je plný',
      'capacity_unavailable': 'Lokalita je dočasne nedostupná',
      'target_unavailable': 'Server je dočasne nedostupný',
      'not_found': 'Položka sa nenašla',
      'invalid_openvpn_csr': 'Neplatná identita OpenVPN',
      'openvpn_profile_exists': 'Profil OpenVPN už existuje',
      'openvpn_profile_revoked': 'Profil OpenVPN bol zrušený',
      'openvpn_operation_pending': 'Operácia OpenVPN prebieha',
      'openvpn_operation_terminal': 'Operácia OpenVPN bola prerušená',
      'openvpn_address_unavailable': 'Adresa OpenVPN nie je k dispozícii',
      'openvpn_profile_conflict': 'Konflikt OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN nie je k dispozícii',
      'email_delivery_unavailable': 'Odosielanie e-mailov nie je k dispozícii',
      'invalid_token': 'Neplatný odkaz',
      'network_unavailable': 'Internetové pripojenie nie je k dispozícii',
      'invalid_json': 'Neplatná požiadavka',
      'invalid_api_response': 'Neplatná odpoveď servera',
      'ipv6_unavailable': 'IPv6 nie je k dispozícii',
      'invalid_ip_families': 'Konfigurácia siete bola odmietnutá',
      'other': 'Služba nie je k dispozícii',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Vaša relácia vypršala. Prihláste sa znova.',
      'invalid_credentials': 'Nesprávna e-mailová adresa alebo heslo.',
      'email_verification_required':
          'Pred pridaním zariadenia VPN potvrďte svoju e-mailovú adresu.',
      'invalid_registration': 'Skontrolujte zadané údaje a súhlasy.',
      'email_exists': 'Účet s touto e-mailovou adresou už existuje.',
      'invalid_profile': 'Skontrolujte údaje svojho profilu.',
      'invalid_device':
          'Neplatný názov alebo lokálna identita tohto zariadenia.',
      'invalid_location': 'Obnovte zoznam lokalít a skúste to znova.',
      'device_limit':
          'Pred pridaním ďalšieho zariadenia odstráňte jedno existujúce.',
      'device_exists': 'Táto identita VPN je už prepojená s iným účtom.',
      'device_identity_revoked':
          'Táto identita bola odstránená. Je potrebné vytvoriť novú lokálnu identitu.',
      'device_location_locked':
          'Lokalita tohto zariadenia sa práve zmenila. Aplikácia bude pokračovať v prebiehajúcej zmene.',
      'location_migration_pending': 'Zmena lokality už prebieha.',
      'location_migration_blocked':
          'Zmena lokality vyžaduje zásah na serveri. Skúste to neskôr alebo kontaktujte podporu.',
      'target_ca_mismatch':
          'Tento server zatiaľ nie je kompatibilný s aktuálnym profilom OpenVPN.',
      'location_migration_conflict':
          'Obnovte zariadenia a potom skúste zmenu lokality znova.',
      'server_full':
          'Táto lokalita dosiahla limit pripojení. Vyberte inú lokalitu alebo to skúste neskôr.',
      'capacity_unavailable':
          'Momentálne sa nedá overiť, či je táto lokalita k dispozícii. Vyberte inú lokalitu alebo to skúste neskôr.',
      'target_unavailable': 'Tento server je dočasne nedostupný.',
      'not_found': 'Táto položka už nie je vo vašom účte k dispozícii.',
      'invalid_openvpn_csr':
          'Vytvorte novú identitu OpenVPN a skúste to znova.',
      'openvpn_profile_exists':
          'Pre toto zariadenie už existuje profil OpenVPN.',
      'openvpn_profile_revoked':
          'Ak chcete pokračovať, obnovte profil OpenVPN.',
      'openvpn_operation_pending': 'Zmena sa ešte uplatňuje. Skúste to neskôr.',
      'openvpn_operation_terminal':
          'Vytvorte novú identitu OpenVPN a skúste to znova.',
      'openvpn_address_unavailable':
          'Momentálne nie je k dispozícii žiadna adresa OpenVPN.',
      'openvpn_profile_conflict':
          'Profil sa zmenil. Obnovte zariadenia a skúste to znova.',
      'openvpn_signer_unavailable': 'Služba OpenVPN je dočasne nedostupná.',
      'email_delivery_unavailable':
          'E-mail sa nepodarilo odoslať. Skúste to neskôr.',
      'invalid_token':
          'Tento odkaz je neplatný alebo vypršal. Vyžiadajte si nový.',
      'network_unavailable':
          'Skontrolujte internetové pripojenie a skúste to znova.',
      'invalid_json': 'Skontrolujte zadané údaje a skúste to znova.',
      'invalid_api_response':
          'Server vrátil neočakávanú odpoveď. Skúste to neskôr.',
      'ipv6_unavailable':
          'Server momentálne nemôže aktivovať IPv6. Skúste to neskôr.',
      'invalid_ip_families':
          'Konfigurácia tunela je neúplná alebo nezodpovedá povoleným adresám. Skúste to znova z aplikácie.',
      'other': 'Došlo k chybe servera. Skúste to neskôr.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Skúste to znova o chvíľu.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Skúste to znova o $seconds sekúnd.',
      few: 'Skúste to znova o $seconds sekundy.',
      one: 'Skúste to znova o $seconds sekundu.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Skúste to znova o $minutes minút.',
      few: 'Skúste to znova o $minutes minúty.',
      one: 'Skúste to znova o $minutes minútu.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Skúste to znova o $hours hodín.',
      few: 'Skúste to znova o $hours hodiny.',
      one: 'Skúste to znova o $hours hodinu.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Obnovenie systémovej VPN nie je k dispozícii',
      'system_vpn_resume_corrupt': 'Neplatné obnovenie systémovej VPN',
      'system_vpn_resume_session_invalid': 'Neplatná relácia obnovenia VPN',
      'system_vpn_resume_identity_changed': 'Identita VPN sa zmenila',
      'system_vpn_resume_identity_invalid': 'Neplatná identita obnovenia VPN',
      'system_vpn_resume_storage_failed':
          'Úložisko obnovenia VPN nie je k dispozícii',
      'system_vpn_resume_network_timeout': 'Žiadna sieť pre obnovenie VPN',
      'system_vpn_resume_blocked': 'Obnovenie VPN je zablokované',
      'system_vpn_resume_failed': 'Obnovenie VPN zlyhalo',
      'system_vpn_resume_error_invalid': 'Neplatná chyba obnovenia VPN',
      'wireguard_identity_store_failed': 'Identita WireGuard sa neuložila',
      'wireguard_identity_unavailable':
          'Identita WireGuard nie je k dispozícii',
      'vpn_host_destroyed': 'Hostiteľ VPN v systéme Android bol zastavený',
      'vpn_host_unavailable':
          'Hostiteľ VPN v systéme Android nie je k dispozícii',
      'vpn_permission_required': 'Vyžaduje sa oprávnenie VPN',
      'vpn_permission_denied': 'Oprávnenie VPN bolo zamietnuté',
      'vpn_permission_request_failed': 'Nepodarilo sa požiadať o oprávnenie',
      'wireguard_foreground_service_unavailable':
          'Služba WireGuard nie je k dispozícii',
      'wireguard_identity_invalid': 'Neplatný lokálny kľúč WireGuard',
      'wireguard_identity_in_use': 'Identita WireGuard sa už používa',
      'wireguard_configuration_invalid': 'Neplatná konfigurácia WireGuard',
      'wireguard_operation_pending': 'Operácia WireGuard stále prebieha',
      'wireguard_start_failed': 'Spustenie WireGuard bolo odmietnuté',
      'wireguard_stop_timeout': 'Zastavenie WireGuard nebolo potvrdené',
      'wireguard_handshake_timeout': 'WireGuard neodpovedá',
      'openvpn_connection_timeout': 'OpenVPN neodpovedá',
      'openvpn_core_unavailable': 'Modul OpenVPN nie je k dispozícii',
      'openvpn_operation_pending': 'Relácia OpenVPN je stále aktívna',
      'openvpn_stop_timeout': 'Zastavenie OpenVPN nebolo potvrdené',
      'openvpn_profile_unavailable': 'Chýba lokálny profil OpenVPN',
      'openvpn_native_failed': 'Natívne volanie OpenVPN bolo prerušené',
      'openvpn_key_generation_failed':
          'Nepodarilo sa vytvoriť kľúč OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Nepodarilo sa vytvoriť CSR pre OpenVPN',
      'openvpn_identity_store_failed': 'Identita OpenVPN sa neuložila',
      'openvpn_identity_clear_failed': 'Odstránenie OpenVPN nebolo úplné',
      'openvpn_identity_in_use': 'Identita OpenVPN sa stále používa',
      'openvpn_tls_verification_required': 'Chýba overenie TLS pre OpenVPN',
      'openvpn_cipher_invalid': 'Neplatná šifra OpenVPN',
      'openvpn_profile_rejected': 'Profil OpenVPN bol odmietnutý',
      'openvpn_identity_inconsistent': 'Nezhodná identita OpenVPN',
      'tls_handshake_failed': 'Vyjednávanie OpenVPN bolo odmietnuté',
      'tls_alert_unknown_ca': 'Certifikát klienta OpenVPN nebol rozpoznaný',
      'tls_alert_bad_certificate': 'Certifikát klienta OpenVPN bol odmietnutý',
      'tls_alert_unsupported_certificate': 'Nepodporovaný certifikát OpenVPN',
      'tls_client_certificate_required':
          'Vyžaduje sa certifikát klienta OpenVPN',
      'tls_alert_misc': 'Výstraha TLS pre OpenVPN',
      'tls_signature_algorithm_rejected': 'Nepodporovaný podpis OpenVPN',
      'tls_handshake_rejected': 'Vyjednávanie TLS pre OpenVPN bolo odmietnuté',
      'tls_version_rejected': 'Nekompatibilná verzia TLS pre OpenVPN',
      'tls_certificate_expired': 'Platnosť certifikátu TLS vypršala',
      'tls_certificate_revoked': 'Certifikát TLS bol zrušený',
      'transport_failed': 'Server OpenVPN je nedostupný',
      'tun_configuration_rejected': 'Nepodarilo sa vytvoriť rozhranie OpenVPN',
      'tun_setup_failed': 'Nastavenie TUN pre OpenVPN zlyhalo',
      'tun_interface_create_failed': 'Vytvorenie rozhrania OpenVPN zlyhalo',
      'tun_interface_disabled': 'Rozhranie OpenVPN je vypnuté',
      'tun_halted': 'Rozhranie OpenVPN bolo prerušené',
      'tun_already_established': 'Rozhranie OpenVPN je už otvorené',
      'tun_addresses_missing': 'Chýba adresa OpenVPN',
      'tun_routes_missing': 'Chýbajú trasy OpenVPN',
      'tun_dns_missing': 'Chýba DNS pre OpenVPN',
      'tun_permission_revoked': 'Oprávnenie VPN bolo zrušené',
      'tun_establish_returned_null': 'Android odmietol rozhranie VPN',
      'openvpn_service_start_failed': 'Služba OpenVPN nie je k dispozícii',
      'openvpn_operation_timeout': 'Prekročený časový limit volania OpenVPN',
      'openvpn_start_failed': 'Spustenie OpenVPN bolo odmietnuté',
      'openvpn_connection_failed': 'Pripojenie OpenVPN bolo prerušené',
      'openvpn_core_status_error': 'OpenVPN Core skončil s chybou',
      'openvpn_stopped_before_connected': 'OpenVPN sa zastavil pred pripojením',
      'openvpn_auth_failed': 'Overenie OpenVPN bolo odmietnuté',
      'openvpn_client_setup_failed': 'Nastavenie klienta OpenVPN zlyhalo',
      'openvpn_client_halted': 'Klient OpenVPN bol prerušený',
      'openvpn_client_restart': 'Vyžiadané reštartovanie OpenVPN',
      'openvpn_inactive_timeout': 'Nečinnosť OpenVPN trvala príliš dlho',
      'openvpn_session_expired': 'Relácia OpenVPN vypršala',
      'openvpn_credentials_required': 'Nepodporované overenie OpenVPN',
      'openvpn_proxy_failed': 'Prenos OpenVPN cez sprostredkovateľa zlyhal',
      'openvpn_compression_failed': 'Kompresia OpenVPN bola odmietnutá',
      'openvpn_ntlm_crypto_unavailable':
          'Šifrovanie NTLM pre OpenVPN nie je k dispozícii',
      'openvpn_feature_unsupported': 'Nepodporovaná funkcia OpenVPN',
      'network_unavailable': 'Internetové pripojenie nie je k dispozícii',
      'network_lost': 'Sieť nie je k dispozícii',
      'certificate_validation_failed': 'Certifikát servera bol odmietnutý',
      'openvpn_certificate_expired': 'Platnosť certifikátu OpenVPN vypršala',
      'tunnel_active_for_another_account': 'Tunel iného účtu je stále aktívny',
      'tunnel_already_active': 'Natívny tunel je už aktívny',
      'tunnel_stop_timeout': 'Zastavenie $protocol nebolo potvrdené',
      'tunnel_disconnected': 'Pripojenie cez $protocol bolo prerušené',
      'native_bridge_unavailable':
          'Prepojenie so systémom Android nie je k dispozícii',
      'native_operation_failed': 'Operácia v systéme Android bola prerušená',
      'invalid_arguments': 'Neúplné parametre VPN',
      'invalid_account_id': 'Neplatný účet VPN',
      'invalid_device_id': 'Neplatný identifikátor zariadenia',
      'storage_key_not_allowed': 'Kľúč úložiska bol odmietnutý',
      'secure_storage_read_failed': 'Bezpečné čítanie zlyhalo',
      'secure_storage_write_failed': 'Bezpečný zápis zlyhal',
      'key_generation_failed': 'Nepodarilo sa vygenerovať kľúč WireGuard',
      'csr_generation_failed': 'Nepodarilo sa vygenerovať CSR pre OpenVPN',
      'openvpn_recovery_exhausted':
          'Automatické zotavenie OpenVPN už bolo použité',
      'openvpn_recovery_failed': 'Automatické zotavenie OpenVPN zlyhalo',
      'openvpn_renewal_required': 'Vyžaduje sa obnovenie certifikátu OpenVPN',
      'other': 'Nezaradená natívna chyba VPN',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android nenašiel žiadnu reláciu VPN, ktorú by bolo možné obnoviť. Spustite nové pripojenie v aplikácii.',
      'system_vpn_resume_corrupt':
          'Uložené údaje na obnovenie VPN sú neplatné a nebudú použité. Spustite nové pripojenie.',
      'system_vpn_resume_session_invalid':
          'Uložená relácia už nemôže obnoviť VPN. Prihláste sa znova v aplikácii.',
      'system_vpn_resume_identity_changed':
          'Lokálna identita VPN sa zmenila. Obnovenie bolo zastavené. Spustite nové pripojenie.',
      'system_vpn_resume_identity_invalid':
          'Identita na obnovenie je neplatná. Spustite nové pripojenie.',
      'system_vpn_resume_storage_failed':
          'Android nemohol prečítať ani aktualizovať zašifrované údaje na obnovenie. Spustite nové pripojenie.',
      'system_vpn_resume_network_timeout':
          'Android nenašiel včas sieť na obnovenie VPN. Skúste to znova, keď bude sieť k dispozícii.',
      'system_vpn_resume_blocked':
          'Obnovenie VPN je zablokované. Skontrolujte nastavenia systému Android a potom spustite nové pripojenie.',
      'system_vpn_resume_failed':
          'Obnovenie VPN systémom Android zlyhalo. Spustite nové pripojenie v aplikácii.',
      'system_vpn_resume_error_invalid':
          'Android vrátil nepoužiteľnú chybu obnovenia. Spustite nové pripojenie.',
      'wireguard_identity_store_failed':
          'Android nemohol uložiť zašifrovanú identitu WireGuard tohto účtu.',
      'wireguard_identity_unavailable':
          'Pre toto pripojenie nie je k dispozícii žiadna použiteľná identita WireGuard.',
      'vpn_host_destroyed':
          'Komponent systému Android, v ktorom beží VPN, bol zastavený. Spustite nové pripojenie.',
      'vpn_host_unavailable':
          'Android nemôže vytvoriť komponent, v ktorom beží VPN. Skúste to znova po kontrole nastavení VPN.',
      'openvpn_renewal_required':
          'Certifikát OpenVPN sa nepodarilo automaticky obnoviť. Spustite nové pripojenie v aplikácii.',
      'openvpn_recovery_failed':
          'Automatické zotavenie zlyhalo. Spustite nové pripojenie v aplikácii.',
      'openvpn_recovery_exhausted':
          'Automatické zotavenie už bolo použité. Spustite nové pripojenie v aplikácii.',
      'vpn_permission_required':
          'Pred spustením tunela vyžaduje Android nové povolenie VPN.',
      'vpn_permission_denied':
          'Ak chcete pokračovať, povoľte FuzeVPN v žiadosti systému Android.',
      'vpn_permission_request_failed':
          'Android nemohol otvoriť obrazovku povolenia VPN.',
      'wireguard_foreground_service_unavailable':
          'Android nemohol udržať službu WireGuard v popredí.',
      'wireguard_identity_invalid':
          'Zašifrovaný kľúč WireGuard tohto účtu je nečitateľný alebo neplatný.',
      'wireguard_identity_in_use':
          'Kľúč WireGuard tohto účtu stále používa iná operácia.',
      'wireguard_configuration_invalid':
          'Prijatá adresa, DNS, kľúč servera alebo trasy pre WireGuard sú neplatné.',
      'wireguard_operation_pending':
          'Predchádzajúca operácia WireGuard ešte neuvoľnila svoju natívnu službu.',
      'wireguard_start_failed':
          'Modul WireGuard odmietol aktiváciu konfigurácie.',
      'wireguard_stop_timeout':
          'Služba WireGuard v stanovenom čase nepotvrdila uvoľnenie rozhrania VPN.',
      'wireguard_handshake_timeout':
          'Tunel v stanovenom čase nepotvrdil bezpečnú výmenu so serverom.',
      'openvpn_connection_timeout':
          'OpenVPN v stanovenom čase nepotvrdil pripojenie k serveru.',
      'openvpn_core_unavailable':
          'Táto verzia aplikácie neobsahuje použiteľný modul OpenVPN.',
      'openvpn_operation_pending':
          'Natívny modul stále uchováva predchádzajúcu reláciu OpenVPN a odmieta vytvoriť druhú.',
      'openvpn_stop_timeout':
          'OpenVPN Core v stanovenom čase nepotvrdil, že jeho natívna relácia sa zastavila a bola zrušená.',
      'openvpn_profile_unavailable':
          'Pre toto pripojenie sa nedá načítať žiadny overený profil OpenVPN.',
      'openvpn_native_failed':
          'Chyba aplikácie prerušila OpenVPN. Skúste sa pripojiť znova. Ak problém pretrváva, spustite diagnostiku.',
      'openvpn_key_generation_failed':
          'Android Keystore nemohol vytvoriť ani prečítať neexportovateľný súkromný kľúč P-256.',
      'openvpn_csr_generation_failed':
          'Kľúč v Android Keystore nemohol podpísať žiadosť o certifikát OpenVPN.',
      'openvpn_identity_store_failed':
          'Certifikát alebo profil OpenVPN sa nepodarilo uložiť do zašifrovaného úložiska.',
      'openvpn_identity_clear_failed':
          'Android nemohol odstrániť celú lokálnu identitu OpenVPN tohto účtu.',
      'openvpn_identity_in_use':
          'Natívna relácia OpenVPN stále používa kľúč alebo certifikát tohto zariadenia.',
      'openvpn_tls_verification_required':
          'Profil výslovne nevyžaduje overenie certifikátu servera.',
      'openvpn_cipher_invalid':
          'Server poskytol šifrovací algoritmus, ktorý nie je v zozname povolených.',
      'openvpn_profile_rejected':
          'Profil prijatý od servera je nekompatibilný. Vytvorte toto zariadenie nanovo a skúste to znova.',
      'openvpn_identity_inconsistent':
          'Certifikát nezodpovedá bezpečnej identite tohto telefónu. Nebol nahradený žiadny lokálny profil.',
      'tls_handshake_failed':
          'Server odmietol vyjednávanie TLS. Ak problém pretrváva, znova vytvorte profil.',
      'tls_alert_unknown_ca':
          'Server nerozpoznáva certifikačnú autoritu certifikátu tohto zariadenia. Je potrebné skontrolovať server OpenVPN.',
      'tls_alert_bad_certificate':
          'Server odmietol certifikát tohto zariadenia. Pred ďalším pokusom zariadenie znova vytvorte.',
      'tls_alert_unsupported_certificate':
          'Server nepodporuje typ bezpečného certifikátu, ktorý používa Android.',
      'tls_client_certificate_required':
          'Server vyžaduje certifikát klienta, ale OpenVPN Core ho nedokázal predložiť.',
      'tls_alert_misc':
          'Server vrátil výstrahu TLS mimo kategórií certifikátu a verzie.',
      'tls_signature_algorithm_rejected':
          'Server odmietol algoritmus ECDSA P-256 kľúča z Android Keystore.',
      'tls_handshake_rejected':
          'Server prerušil vyjednávanie TLS pred pripojením.',
      'tls_version_rejected': 'Klient a server nenašli spoločnú verziu TLS.',
      'tls_certificate_expired':
          'Certifikát predložený počas pripojenia už stratil platnosť.',
      'tls_certificate_revoked':
          'Certifikát predložený počas pripojenia bol zrušený.',
      'transport_failed':
          'Server OpenVPN momentálne neodpovedá v aktuálnej sieti. Skúste to o chvíľu znova.',
      'tun_configuration_rejected':
          'Android odmietol sieťovú konfiguráciu, ktorú požadoval OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core odmietol sieťový plán pred vytvorením rozhrania v systéme Android.',
      'tun_interface_create_failed':
          'OpenVPN Core nemohol získať rozhranie TUN od VpnService systému Android.',
      'tun_interface_disabled':
          'Android alebo OpenVPN Core vypol rozhranie TUN počas pripojenia.',
      'tun_halted': 'OpenVPN Core dostal žiadosť o zastavenie rozhrania TUN.',
      'tun_already_established':
          'OpenVPN požiadal o druhé rozhranie v rovnakom pripojení. Tunel bol z bezpečnostných dôvodov zastavený.',
      'tun_addresses_missing': 'Server neposkytol použiteľnú adresu tunela.',
      'tun_routes_missing': 'Server neposkytol použiteľné trasy tunela.',
      'tun_dns_missing': 'Server neposkytol použiteľný server DNS.',
      'tun_permission_revoked':
          'Android počas pripojenia zrušil oprávnenie VPN.',
      'tun_establish_returned_null':
          'Android rozhranie nevytvoril, zvyčajne preto, že je stále aktívna iná VPN.',
      'openvpn_service_start_failed':
          'Android nemohol spustiť službu OpenVPN v popredí.',
      'openvpn_operation_timeout':
          'Volanie JNI na OpenVPN Core prekročilo maximálnu dobu trvania.',
      'openvpn_start_failed':
          'Služba systému Android je pripravená, ale OpenVPN Core neprijal spustenie profilu.',
      'openvpn_connection_failed':
          'OpenVPN Core sa zastavil skôr, ako vydal udalosť CONNECTED.',
      'openvpn_core_status_error':
          'Natívna slučka OpenVPN skončila chybou bez konkrétnejšej koncovej udalosti.',
      'openvpn_stopped_before_connected':
          'Natívna slučka OpenVPN sa zastavila pred pripojením bez výslovnej chyby OpenVPN Core.',
      'openvpn_auth_failed': 'Server OpenVPN odmietol overenie profilu.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nedokázal inicializovať klienta pred sieťovým pripojením.',
      'openvpn_client_halted':
          'OpenVPN Core dostal koncový príkaz na zastavenie klienta.',
      'openvpn_client_restart':
          'OpenVPN Core požiadal o reštart svojej transportnej relácie.',
      'openvpn_inactive_timeout':
          'OpenVPN Core ukončil reláciu po časovom limite nečinnosti.',
      'openvpn_session_expired': 'Server oznámil, že relácia OpenVPN vypršala.',
      'openvpn_credentials_required':
          'Server alebo proxy vyžaduje interaktívne prihlasovacie údaje, ktoré nie sú súčasťou tohto certifikačného profilu.',
      'openvpn_proxy_failed':
          'OpenVPN Core nahlásil zlyhanie nakonfigurovaného proxy servera alebo relé.',
      'openvpn_compression_failed':
          'OpenVPN Core odmietol režim kompresie oznámený profilom alebo serverom.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil vyžaduje šifrovanie NTLM, ktoré nie je v tejto verzii k dispozícii.',
      'openvpn_feature_unsupported':
          'Profil alebo server vyžaduje funkciu, ktorá v tomto klientovi pre Android chýba.',
      'network_unavailable':
          'Nie je k dispozícii žiadna použiteľná fyzická sieť.',
      'network_lost': 'Tunel bol zastavený po strate siete.',
      'certificate_validation_failed':
          'Identitu servera OpenVPN sa nepodarilo overiť.',
      'openvpn_certificate_expired':
          'Platnosť certifikátu OpenVPN vypršala. Ak ho chcete obnoviť, spustite nové pripojenie v aplikácii.',
      'tunnel_active_for_another_account':
          'Pred týmto pripojením musí byť zastavený tunel patriaci inému účtu.',
      'tunnel_already_active':
          'Android hlási, že predchádzajúca relácia VPN stále používa rozhranie.',
      'tunnel_stop_timeout':
          'Modul $protocol v stanovenom čase nepotvrdil uvoľnenie rozhrania VPN.',
      'tunnel_disconnected':
          'Natívny modul nahlásil, že tunel sa po spustení neočakávane ukončil.',
      'native_bridge_unavailable':
          'Aplikácia nemá prístup k službe VPN systému Android. Zatvorte aplikáciu, znova ju otvorte a skúste to znova.',
      'native_operation_failed':
          'Chyba aplikácie prerušila operáciu VPN. Skúste to znova. Ak problém pretrváva, spustite diagnostiku.',
      'invalid_arguments':
          'Informácie potrebné pre túto operáciu VPN sú neúplné. Skúste to znova. Ak problém pretrváva, spustite diagnostiku.',
      'invalid_account_id':
          'Natívna operácia nie je spojená s platným identifikátorom účtu.',
      'invalid_device_id':
          'Identifikátor zariadenia odoslaný natívnemu modulu chýba alebo je neplatný.',
      'storage_key_not_allowed':
          'Prepojenie so systémom Android zablokovalo kľúč, ktorý nie je v povolenom zozname úložiska.',
      'secure_storage_read_failed':
          'Android Keystore nedokázal dešifrovať lokálne údaje tohto účtu.',
      'secure_storage_write_failed':
          'Android Keystore nedokázal zašifrovať ani uložiť lokálne údaje.',
      'key_generation_failed':
          'Android nemohol vytvoriť ani prečítať kľúč WireGuard v zabezpečenom úložisku.',
      'csr_generation_failed':
          'Android Keystore nemohol vytvoriť ani podpísať žiadosť CSR P-256 pre OpenVPN.',
      'other':
          'Nezdokumentovaná natívna vetva zlyhala. Pošlite podpore diagnostický kód zobrazený nižšie.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Žiadosť o povolenie je už otvorená';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Žiadosť o povolenie VPN v systéme Android sa už zobrazuje. Dokončite ju a potom to skúste znova.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Žiadosť o povolenie VPN bola prerušená';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Obrazovka povolenia VPN sa zavrela skôr, než aplikácia dostala odpoveď.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Pripojenie OpenVPN nebolo potvrdené';

  @override
  String get notice_openvpnProofMissing_message =>
      'Pripojenie OpenVPN sa nepodarilo potvrdiť. Z bezpečnostných dôvodov bolo zastavené. Skúste to znova.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN bol zrušený';

  @override
  String get openvpnCleanup_working =>
      'Zastavovanie a odstraňovanie zrušeného profilu OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Vypnutie OpenVPN nebolo potvrdené. Pred vytvorením nového profilu to skúste znova.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Zrušený profil OpenVPN sa nepodarilo úplne odstrániť. Skúste vyčistenie znova.';

  @override
  String get openvpnCleanup_complete =>
      'Zrušený profil OpenVPN bol odstránený. Ak chcete vytvoriť nový, klepnite na tlačidlo Pripojiť.';

  @override
  String get network_title => 'Konfigurácia siete';

  @override
  String get network_ipv4Fallback =>
      'IPv6 je dočasne nedostupný. Príprava pokračuje pomocou IPv4.';

  @override
  String get network_rejectedTitle => 'Konfigurácia siete bola odmietnutá';

  @override
  String get network_rejectedMessage =>
      'Konfigurácia tunela je neúplná alebo nezodpovedá povoleným adresám. Skúste to znova z aplikácie.';

  @override
  String get network_unreadableTitle => 'Lokálna konfigurácia sa nedá prečítať';

  @override
  String get network_unreadableMessage =>
      'Uloženú konfiguráciu siete OpenVPN nie je možné použiť. Ak ju chcete aktualizovať, znova sa pripojte z aplikácie.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ochrana siete';

  @override
  String get protection_subtitle =>
      'Blokovať priamy prístup na internet, ak sa VPN odpojí.';

  @override
  String get protection_active => 'Ochrana systému je aktívna';

  @override
  String get protection_alwaysOnOnly =>
      'Funkcia Vždy zapnutá VPN je aktívna; zapnite blokovanie pripojení bez VPN';

  @override
  String get protection_inactive => 'Ochrana systému nie je aktívna';

  @override
  String get protection_unknown => 'Skontrolujte ochranu systému';

  @override
  String get protection_openSettings => 'Otvoriť nastavenia systému Android';

  @override
  String get protection_dialogTitle => 'Nastavenie ochrany siete';

  @override
  String get protection_dialogMessage =>
      'Systém Android spravuje vždy zapnutú VPN a blokovanie pripojení bez VPN. Skontrolujte, či je vybraná aplikácia FuzeVPN, a v systémových nastaveniach zapnite blokovanie.';

  @override
  String get protection_dialogOpen => 'Otvoriť nastavenia';

  @override
  String get session_systemProtectionNote =>
      'Ak Android stále blokuje komunikáciu mimo VPN, otvorte systémové nastavenia a skontrolujte alebo zmeňte túto ochranu.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Diagnostika aplikácie';

  @override
  String get diagnostics_automaticTitle => 'Odosielať dôležité chyby';

  @override
  String get diagnostics_automaticDescription =>
      'Zdieľať krátke technické hlásenie, keď nastane dôležitá chyba.';

  @override
  String get diagnostics_privacy =>
      'Odoslané hlásenia sa spájajú s prihláseným účtom a uchovávajú sa 30 dní. Neobsahujú históriu prehliadania, heslá ani kľúče VPN.';

  @override
  String get diagnostics_manualOpen => 'Spustiť diagnostiku';

  @override
  String get diagnostics_localDescription =>
      'Vytvorí sa hlásenie o stave aplikácie a VPN. Vaše pripojenie zostane nezmenené.';

  @override
  String get diagnostics_sendReport => 'Odoslať hlásenie';

  @override
  String get diagnostics_sendHint =>
      'Ak chcete hlásenie uchovať v tomto zariadení, nechajte toto políčko nezaškrtnuté.';

  @override
  String get diagnostics_signedOut =>
      'Ak chcete odoslať hlásenie, prihláste sa do svojho účtu.';

  @override
  String get diagnostics_localLifetime =>
      'Uložte toto hlásenie do telefónu, aby vám zostalo aj po zatvorení aplikácie.';

  @override
  String get diagnostics_run => 'Spustiť diagnostiku';

  @override
  String get diagnostics_rerun => 'Spustiť diagnostiku znova';

  @override
  String get diagnostics_running => 'Kontroluje sa…';

  @override
  String get diagnostics_sending => 'Odosielanie hlásenia…';

  @override
  String get diagnostics_prepared => 'Hlásenie je pripravené v tomto zariadení';

  @override
  String get diagnostics_queued => 'Hlásenie čaká na odoslanie';

  @override
  String get diagnostics_sent => 'Hlásenie bolo prijaté';

  @override
  String get diagnostics_failed =>
      'Odoslanie zlyhalo. Hlásenie uložené v zariadení je stále k dispozícii.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostické hlásenie sa nepodarilo pripraviť. Skúste to znova.';

  @override
  String get diagnostics_authenticationRequired =>
      'Ak chcete hlásenie odoslať, prihláste sa znova.';

  @override
  String get diagnostics_retry => 'Skúsiť odoslanie znova';

  @override
  String get diagnostics_export => 'Uložiť hlásenie';

  @override
  String get diagnostics_exportFailed =>
      'Hlásenie sa nepodarilo exportovať. Skúste to znova z lokálneho hlásenia.';

  @override
  String get diagnostics_preferenceFailed =>
      'Toto nastavenie sa nepodarilo uložiť. Skúste to znova.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referenčný kód: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Prijaté $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Uchované do $date';
  }

  @override
  String get diagnostics_duplicate => 'Toto hlásenie už bolo prijaté.';

  @override
  String get diagnostics_preview => 'Ukážka hlásenia';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Je priložených $count technických udalostí',
      few: 'Sú priložené $count technické udalosti',
      one: 'Je priložená 1 technická udalosť',
      zero: 'Nie sú priložené žiadne technické udalosti',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Technické podrobnosti';

  @override
  String get diagnostics_empty =>
      'Zatiaľ nebolo pripravené žiadne diagnostické hlásenie.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Stav tunela',
      'handshake': 'Potvrdenie pripojenia',
      'certificate': 'Certifikát VPN',
      'kill_switch': 'Ochrana systému Android',
      'connectivity': 'Dostupná sieť',
      'api_reachability': 'Prístup k službe',
      'secure_storage': 'Zabezpečené úložisko',
      'other': 'Lokálna kontrola',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Overené',
      'failed': 'Vyžaduje pozornosť',
      'skipped': 'Netestované – bez aktívnej kontroly',
      'unknown': 'Informácie nie sú k dispozícii',
      'other': 'Informácie nie sú k dispozícii',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Vitajte vo FuzeVPN';

  @override
  String get connection_changeLocation => 'Zmeniť lokalitu';

  @override
  String get connection_details => 'Podrobnosti o pripojení';

  @override
  String get locations_searchLabel => 'Hľadať mesto alebo krajinu';

  @override
  String get locations_clearSearch => 'Vymazať vyhľadávanie';

  @override
  String get locations_filterAll => 'Všetky';

  @override
  String get locations_filterFavorites => 'Obľúbené';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokalít',
      few: '$count lokality',
      one: '$count lokalita',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nenašli sa žiadne lokality';

  @override
  String get locations_noResultsHint => 'Skúste iné mesto alebo krajinu.';

  @override
  String get locations_noFavorites =>
      'Vaše obľúbené lokality máte vždy po ruke';

  @override
  String get locations_noFavoritesHint =>
      'Klepnite na hviezdičku vedľa lokality a uložte ju sem.';

  @override
  String get locations_showAll => 'Zobraziť všetky lokality';

  @override
  String locations_addFavorite(String name) {
    return 'Pridať $name medzi obľúbené';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Odstrániť $name z obľúbených';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Obľúbenú lokalitu sa nepodarilo uložiť. Skúste to znova.';

  @override
  String get locations_emptyTitle => 'Nie sú k dispozícii žiadne lokality';

  @override
  String get locations_emptyHint => 'Obnovte zoznam a skúste to znova.';

  @override
  String get devices_manage => 'Spravovať moje zariadenia';

  @override
  String get settings_personalization => 'Prispôsobte si aplikáciu';

  @override
  String get settings_safety => 'Ochrana';

  @override
  String get settings_help => 'Potrebujete pomoc?';

  @override
  String get settings_about => 'O aplikácii FuzeVPN';

  @override
  String get diagnostics_heading => 'Zistite príčinu problému s pripojením';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Dostupné',
      'pending': 'Príprava',
      'revoked': 'Odstránené',
      'expired': 'Platnosť vypršala',
      'other': 'Stav nie je k dispozícii',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Nastavenie sa neuložilo';

  @override
  String get notice_preferenceSave_message =>
      'Vaša voľba sa zatiaľ uplatňuje, ale nepodarilo sa ju uložiť. Skúste to znova, aby sa zachovala aj po zatvorení aplikácie.';

  @override
  String get connection_androidDisconnectHint =>
      'Ak Android ponecháva VPN aktívnu, v nastaveniach, ktoré sa otvoria, vypnite možnosť Vždy zapnutá VPN.';

  @override
  String get connection_certificate => 'Certifikát OpenVPN';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Platný do $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Platnosť vypršala $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Pri najbližšom pripojení sa automaticky obnoví.';

  @override
  String get protection_learnMore => 'Viac o ochrane systému Android';

  @override
  String get protection_guideWhy =>
      'Táto ochrana zabráni aplikáciám priamo používať internet, ak sa VPN odpojí. Nastavuje sa v systéme Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Vždy zapnutá VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android udržiava službu VPN v chode a po reštarte telefónu ju môže znova spustiť.';

  @override
  String get protection_guideBlockTitle => 'Blokovať pripojenia bez VPN';

  @override
  String get protection_guideBlock =>
      'Toto nastavenie zabraňuje tomu, aby komunikácia obchádzala VPN, a to aj pri prerušení pripojenia.';

  @override
  String get protection_guideWarning =>
      'Ak je toto blokovanie zapnuté, prístup na internet zostane vypnutý, kým sa nepripojíte k VPN.';

  @override
  String get protection_guideStepsTitle => 'Zapnutie ochrany';

  @override
  String get protection_guideStep1 =>
      'Tlačidlom nižšie otvorte nastavenia VPN v systéme Android.';

  @override
  String get protection_guideStep2 =>
      'Vedľa položky FuzeVPN otvorte možnosti pomocou ikony ozubeného kolieska.';

  @override
  String get protection_guideStep3 =>
      'Zapnite možnosť Vždy zapnutá VPN a potom Blokovať pripojenia bez VPN, ak sú tieto možnosti k dispozícii.';

  @override
  String get protection_guideManufacturers =>
      'Názvy sa líšia podľa telefónu. V prípade potreby vyhľadajte VPN v nastaveniach, zvyčajne v časti Sieť a internet.';

  @override
  String get protection_guideDisableTitle => 'Vypnutie tejto ochrany';

  @override
  String get protection_guideDisable =>
      'V rovnakých nastaveniach vypnite možnosť Blokovať pripojenia bez VPN, aby ste mohli používať internet aj bez VPN. Ak už nechcete, aby ju Android znova spúšťal, vypnite aj možnosť Vždy zapnutá VPN.';

  @override
  String get protection_guideManual =>
      'Tieto nastavenia určujete v systéme Android. Aplikácia FuzeVPN ich za vás nemení.';

  @override
  String get locations_changeTitle => 'Zmeniť lokalitu?';

  @override
  String locations_changeActive(String name) {
    return 'VPN sa odpojí a potom sa pokúsi pripojiť k lokalite $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN sa pokúsi pripojiť k lokalite $name.';
  }

  @override
  String get locations_confirmChange => 'Zmeniť a pripojiť';

  @override
  String get locations_changeBusy =>
      'Prebieha zmena. Pred výberom inej lokality počkajte.';

  @override
  String get locations_automaticSelection => 'Automatický výber';

  @override
  String get locations_cities => 'Mestá';

  @override
  String get locations_servers => 'Servery';

  @override
  String locations_viewCities(String name) {
    return 'Zobraziť mestá v krajine $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Zobraziť servery v lokalite $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count krajín',
      few: '$count krajiny',
      one: '$count krajina',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miest',
      few: '$count mestá',
      one: '$count mesto',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serverov',
      few: '$count servery',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Všetky krajiny';

  @override
  String get locations_backToCountries => 'Späť na krajiny';

  @override
  String locations_backToCities(String name) {
    return 'Späť na mestá v krajine $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Vybrať $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Vybrať $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nie je k dispozícii žiadny kompatibilný server.';

  @override
  String get externalLink_failed =>
      'Tento odkaz sa nepodarilo otvoriť. Môžete ho skopírovať a otvoriť vo svojom prehliadači.';

  @override
  String get externalLink_copy => 'Kopírovať odkaz';

  @override
  String get externalLink_copied => 'Odkaz bol skopírovaný';

  @override
  String get externalLink_copyFailed =>
      'Odkaz sa nepodarilo skopírovať. Označte adresu nižšie.';

  @override
  String get settings_deleteAccount => 'Odstrániť môj účet';

  @override
  String get settings_deleteAccountDetail =>
      'Zobraziť postup žiadosti o odstránenie účtu';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Vyberte si predplatné VPN.';

  @override
  String get billing_subscribe => 'Predplatiť';

  @override
  String get billing_choosePlan => 'Ak chcete pokračovať, vyberte si plán.';

  @override
  String get billing_monthly => 'Mesačne';

  @override
  String get billing_yearly => 'Ročne';

  @override
  String get billing_continue => 'Pokračovať cez Google Play';

  @override
  String get billing_restore => 'Obnoviť nákupy';

  @override
  String get billing_manage => 'Spravovať predplatné';

  @override
  String get billing_deleteAccountWarning =>
      'Ak máte predplatné cez Google Play, odstránenie účtu FuzeVPN jeho automatické obnovovanie nezruší. Obnovovanie spravujte alebo zrušte osobitne v Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Pokračovať k žiadosti o odstránenie účtu';

  @override
  String get billing_refresh => 'Obnoviť prístup';

  @override
  String get billing_loadingPlans => 'Načítavanie plánov…';

  @override
  String get billing_unavailable =>
      'Momentálne nie sú k dispozícii žiadne plány. Skúste to neskôr.';

  @override
  String get billing_comingSoon => 'Predplatné bude čoskoro k dispozícii.';

  @override
  String get billing_priceDisclosure =>
      'Cenu poskytuje Google Play. Konečná suma a príslušné dane sa zobrazia pred vaším potvrdením.';

  @override
  String get billing_renewalMonthly =>
      'Predplatné sa automaticky obnovuje každý mesiac, ak ho nezrušíte. Kedykoľvek ho môžete zrušiť v časti Predplatné v Google Play.';

  @override
  String get billing_renewalYearly =>
      'Predplatné sa automaticky obnovuje každý rok, ak ho nezrušíte. Kedykoľvek ho môžete zrušiť v časti Predplatné v Google Play.';

  @override
  String get billing_active => 'Váš prístup Premium je aktívny';

  @override
  String billing_accessUntil(String date) {
    return 'Prístup do $date.';
  }

  @override
  String get billing_webManaged =>
      'Vaše predplatné sa spravuje na webovej stránke FuzeVPN.';

  @override
  String get billing_playManaged => 'Vaše predplatné spravuje Google Play.';

  @override
  String get billing_playOnHold =>
      'Vaše predplatné v Google Play je pozastavené alebo čaká na platbu. Otvorte „Spravovať predplatné“ a vyriešte to v Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Tento účet Google Play už má predplatné Fuze Premium, ktoré nie je aktívne pre tento účet FuzeVPN. Otvorte „Spravovať predplatné“ a pozrite si ho v Google Play.';

  @override
  String get billing_inactive => 'Žiadne aktívne predplatné.';

  @override
  String get billing_checkingAccess => 'Overovanie vášho prístupu…';

  @override
  String get billing_restoring => 'Obnovovanie nákupov…';

  @override
  String get billing_pending =>
      'Platba čaká na spracovanie. Váš prístup sa aktivuje po potvrdení.';

  @override
  String get billing_cancelled =>
      'Nákup bol zrušený. Nové predplatné sa neaktivovalo.';

  @override
  String get billing_verifying => 'Overovanie nákupu…';

  @override
  String get billing_success =>
      'Predplatné je aktivované. Váš prístup Premium je pripravený.';

  @override
  String get billing_restored => 'Vaše nákupy boli obnovené.';

  @override
  String get billing_restoreEmpty =>
      'Pre tento účet Google Play nie sú žiadne nákupy na obnovenie.';

  @override
  String get billing_catalogError =>
      'Plány sa nepodarilo načítať. Skúste to znova.';

  @override
  String get billing_purchaseError =>
      'Nákup sa nepodarilo spustiť. Skúste to znova.';

  @override
  String get billing_verificationError =>
      'Overenie nákupu je dočasne nedostupné. Skúste to znova pomocou možnosti Obnoviť nákupy.';

  @override
  String get billing_restoreError =>
      'Nákupy sa nepodarilo obnoviť. Skúste to znova.';

  @override
  String get billing_managementError =>
      'Správu predplatného sa nepodarilo otvoriť. Skúste to znova.';

  @override
  String get billing_storeUnavailable =>
      'Google Play nie je v tomto zariadení k dispozícii.';

  @override
  String get welcome_title => 'Vaša VPN, jednoducho.';

  @override
  String get welcome_description =>
      'Chráňte svoje pripojenie. Majte kontrolu nad svojím súkromím.';

  @override
  String get welcome_start => 'Začať';

  @override
  String get welcome_alreadyPurchased => 'Už ste si zakúpili predplatné?';

  @override
  String get welcome_noAccountRequired => 'Na začiatok nepotrebujete účet.';

  @override
  String get guest_accountTitle => 'Účet nie je prepojený';

  @override
  String get guest_accountDescription =>
      'Obnovte svoje nákupy pomocou rovnakého účtu Google Play, aby ste mohli predplatné používať na inom zariadení.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Už ste predplatiteľ? Prihláste sa';

  @override
  String get guest_claimTitle => 'Používajte FuzeVPN všade';

  @override
  String get guest_claimDescription =>
      'Vytvorte si účet, aby ste mali prístup k predplatnému aj na ostatných zariadeniach. Tento krok je nepovinný.';

  @override
  String get guest_skip => 'Možno neskôr';

  @override
  String get guest_activationTitle => 'Fuze Premium je aktívny';

  @override
  String get guest_activationDescription =>
      'Vaše predplatné je pripravené. Používajte VPN a účet si vytvorte, kedykoľvek budete chcieť.';

  @override
  String get guest_useVpn => 'Použiť VPN';

  @override
  String get guest_loginRequired =>
      'Tento nákup je už prepojený s účtom FuzeVPN. Ak chcete získať prístup k predplatnému, prihláste sa do tohto účtu.';

  @override
  String get guest_signOutWarning =>
      'Predplatné získate späť obnovením nákupov pomocou rovnakého účtu Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Váš účet je už prepojený. Prihláste sa, aby ste si mohli zobraziť a spravovať svoje údaje.';

  @override
  String get billing_acceptance =>
      'Pokračovaním súhlasíte s podmienkami používania a zásadami ochrany osobných údajov.';

  @override
  String get guest_verifyEmailReminder =>
      'Potvrďte svoju e-mailovú adresu, aby bol váš účet zabezpečený. VPN môžete ďalej používať.';

  @override
  String get guest_serviceUnavailable =>
      'Služba je dočasne nedostupná. Skúste to o chvíľu znova.';

  @override
  String get guest_restoreError =>
      'Vaše nákupy sa nepodarilo obnoviť. Skúste to znova s účtom Google Play, ktorý ste použili na nákup.';

  @override
  String get guest_claimSuccess =>
      'Váš účet bol vytvorený. Vaše predplatné a prístup k VPN sú zachované.';

  @override
  String get guest_emailExists =>
      'Táto e-mailová adresa sa už používa. Použite inú adresu alebo sa prihláste do existujúceho účtu. Váš nákup zostáva dostupný cez Google Play.';

  @override
  String get guest_claimError =>
      'Účet sa nepodarilo vytvoriť. Môžete ďalej používať VPN a skúsiť to neskôr.';

  @override
  String get guest_secureStorageError =>
      'Reláciu sa na tomto zariadení nepodarilo zabezpečiť. Skúste to znova.';

  @override
  String get guest_premiumRequired =>
      'Ak chcete aktivovať VPN, vyberte si predplatné.';

  @override
  String get welcome_viewPlans => 'Zobraziť plány';

  @override
  String get google_continue => 'Pokračovať cez Google';

  @override
  String get google_or => 'alebo';

  @override
  String get google_title => 'Váš účet FuzeVPN';

  @override
  String get google_settingUp => 'Dokončite vytváranie účtu';

  @override
  String get google_country => 'Krajina bydliska';

  @override
  String get google_profileDescription =>
      'Vyberte svoju krajinu a prečítajte si dva dokumenty, aby ste mohli vytvoriť účet FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Prepojte svoj hosťovský účet s účtom Google. Vaše predplatné a zariadenie zostanú priradené k tomuto účtu.';

  @override
  String get google_linkTitle => 'Prepojiť účet Google s FuzeVPN';

  @override
  String get google_linkDescription =>
      'Potvrďte prístup k svojmu existujúcemu účtu FuzeVPN. Tento krok nevyžaduje heslo k vášmu účtu Google.';

  @override
  String get google_password => 'Heslo k účtu FuzeVPN';

  @override
  String get google_linkAccount => 'Potvrdiť prepojenie';

  @override
  String get google_requestEmail => 'Poslať mi potvrdzovací e-mail';

  @override
  String get google_emailInstructions =>
      'Otvorte e-mail od FuzeVPN a zadajte potvrdzovací kód.';

  @override
  String get google_emailCode => 'Potvrdzovací kód z e-mailu';

  @override
  String get google_confirmEmail => 'Potvrdiť kód';

  @override
  String get google_restart => 'Vybrať iný účet Google';

  @override
  String get google_resume => 'Skontrolovať tento pokus';

  @override
  String get google_unavailable =>
      'Prihlásenie cez Google nie je k dispozícii. Môžete použiť e-mail a heslo.';

  @override
  String get google_expired =>
      'Tento pokus vypršal. Zrušte ho a začnite znova.';

  @override
  String get google_conflict =>
      'Tento účet Google je už prepojený inde. Váš aktuálny účet a predplatné zostanú zachované.';

  @override
  String get google_error =>
      'Prihlásenie cez Google zlyhalo. Skúste to znova; váš aktuálny prístup zostáva zachovaný.';

  @override
  String get google_uncertain =>
      'Výsledok sa nepodarilo potvrdiť. Skontrolujte tento pokus alebo ho pred novým začatím zrušte.';

  @override
  String get google_cancelFailed =>
      'Zrušenie sa nepodarilo potvrdiť. Skúste zrušenie zopakovať, skôr než opustíte túto obrazovku.';

  @override
  String get google_cancelled => 'Prihlásenie cez Google bolo zrušené.';

  @override
  String get google_selecting => 'Vyberte si účet Google…';

  @override
  String get google_verifying => 'Kontrola vášho účtu…';

  @override
  String get google_emailUnavailable =>
      'Potvrdzovací e-mail sa nepodarilo odoslať. Skúste to neskôr.';

  @override
  String get google_emailSent =>
      'Potvrdzovací e-mail bol odoslaný. Skontrolujte si doručenú poštu.';

  @override
  String get google_rateLimited => 'Počkajte, prosím, a skúste to znova.';

  @override
  String get google_busy =>
      'Google nie je k dispozícii, kým prebieha iná operácia (pripojenie VPN, účet alebo hosť). Skúste to znova po jej dokončení; váš aktuálny prístup zostáva zachovaný.';

  @override
  String get google_invalidPassword =>
      'Heslo k účtu FuzeVPN nie je správne. Váš aktuálny účet zostáva zachovaný.';

  @override
  String get google_invalidCode =>
      'Potvrdzovací kód je neplatný alebo vypršal.';

  @override
  String get google_accountChanged =>
      'Vaša relácia sa zmenila. Pred novým začatím zrušte tento pokus.';

  @override
  String get google_invalidResponse =>
      'Odpoveď sa nepodarilo overiť. Váš aktuálny prístup zostáva zachovaný.';

  @override
  String get google_invalidRegistration =>
      'Skontrolujte svoju krajinu a oba súhlasy.';

  @override
  String get google_consentRequired =>
      'Ak chcete pokračovať, vyberte krajinu a súhlaste s oboma dokumentmi.';

  @override
  String get google_challengeRequired =>
      'Vyžaduje sa ďalšia bezpečnostná kontrola. Váš aktuálny prístup zostáva zachovaný.';

  @override
  String get google_challengeUnavailable =>
      'Bezpečnostná kontrola nie je k dispozícii. Skúste to neskôr.';

  @override
  String get google_intentMismatch =>
      'Predchádzajúci pokus o prihlásenie cez Google ešte čaká na vybavenie. Pred začatím tejto operácie ho zrušte.';

  @override
  String get google_challengeBlocked =>
      'Požadovaná bezpečnostná kontrola nie je v tejto aplikácii k dispozícii. Túto operáciu nie je momentálne možné dokončiť.';

  @override
  String get google_solveChallenge => 'Dokončite bezpečnostnú kontrolu';

  @override
  String get google_challengeTitle => 'Bezpečnostná kontrola';

  @override
  String get google_challengeReady =>
      'Overenie je dokončené. Teraz môžete potvrdiť vytvorenie účtu.';

  @override
  String get google_challengeExpired =>
      'Overenie vypršalo. Pred potvrdením ho dokončite znova.';

  @override
  String get google_challengeCancelled =>
      'Overenie bolo zrušené. Môžete ho skúsiť znova.';

  @override
  String get google_challengeFailed =>
      'Bezpečnostná kontrola zlyhala. Skúste to znova.';

  @override
  String get billing_trialTitle => 'Vyskúšajte Fuze Premium zadarmo';

  @override
  String get billing_trialSubtitle => 'Chráňte svoje pripojenie už dnes.';

  @override
  String get billing_trialWeeks => '2-týždňová bezplatná skúšobná verzia';

  @override
  String billing_trialDays(String days) {
    return '$days-dňová bezplatná skúšobná verzia';
  }

  @override
  String get billing_trialStart => 'Spustiť bezplatnú skúšobnú verziu';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ak začnete dnes, prvá platba by mala prebehnúť $date.';
  }

  @override
  String get billing_trialTerms =>
      'Automaticky sa obnovuje za uvedenú cenu. Ak sa chcete vyhnúť poplatku, zrušte predplatné v Google Play pred koncom skúšobnej verzie.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Potom $price mesačne';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Potom $price ročne';
  }

  @override
  String get billing_choosePeriod => 'Vyberte si plán';

  @override
  String get billing_selectionHint => 'Ak chcete pokračovať, vyberte plán.';

  @override
  String get billing_benefitConnection => 'Šifrované pripojenie';

  @override
  String get billing_benefitPrivacy => 'Ochrana súkromia online';

  @override
  String get billing_benefitNoAccount => 'Registrácia nie je potrebná';

  @override
  String get billing_cancellation => 'Zrušenie v Google Play';

  @override
  String get billing_premiumTitle => 'Lepšie chránené pripojenie.';

  @override
  String get billing_premiumSubtitle =>
      'Chráňte svoje pripojenie vlastným tempom.';

  @override
  String get billing_priceMonthly => 'mesačne';

  @override
  String get billing_priceYearly => 'ročne';

  @override
  String get billing_trialToday => 'Dnes nič neplatíte';

  @override
  String get billing_trialConfirmation =>
      'Pred vaším potvrdením Google Play zobrazí dátumy, konečnú sumu a príslušné dane.';

  @override
  String get billing_offerChanged =>
      'Podmienky tejto ponuky sa zmenili. Obnovte plány a vyberte si znova.';

  @override
  String get status_waitingNetwork => 'Čakanie na sieť';

  @override
  String get status_waitingNetworkDetail =>
      'Žiadna sieť nie je k dispozícii. Keď sa sieť obnoví, VPN overí pripojenie.';

  @override
  String get locations_favoriteLoadFailed =>
      'Obľúbené položky sa nepodarilo načítať. Skúste to znova.';

  @override
  String get locations_favoritesLoading => 'Načítavanie obľúbených položiek…';
}
