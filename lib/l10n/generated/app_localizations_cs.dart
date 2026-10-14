// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Chraňte své připojení';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN využívá službu VPN systému Android (VpnService) k vytvoření šifrovaného tunelu mezi tímto zařízením a servery FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Když je VPN aktivní, internetový provoz vašich aplikací, cílové adresy a požadavky DNS procházejí tímto tunelem, aby bylo vaše připojení směrováno, i když FuzeVPN běží na pozadí.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikace používá stav připojení, jeho délku a objem přenesených dat k zobrazení vašeho připojení VPN. Připojení můžete kdykoli ukončit.';

  @override
  String get vpnDisclosure_privacy => 'Soukromí';

  @override
  String get vpnDisclosure_accept => 'Přijmout a pokračovat';

  @override
  String get vpnDisclosure_decline => 'Teď ne';

  @override
  String get accountRestoration_title => 'Účet je dočasně nedostupný';

  @override
  String get accountRestoration_message =>
      'Vaše relace byla zachována. Opakováním obnovte účet; připojení VPN můžete stále spravovat zde.';

  @override
  String get action_retry => 'Opakovat';

  @override
  String get session_endingTitle => 'Ukončování relace';

  @override
  String get session_ending =>
      'Vaše relace je neplatná. Zastavuji VPN a odstraňuji relaci…';

  @override
  String get session_stopFailed =>
      'Vypnutí VPN není potvrzeno. Před dalším přihlášením to zkuste znovu.';

  @override
  String get session_cleanupFailed =>
      'VPN je zastavena, ale odstranění relace není potvrzeno. Zkuste vyčištění znovu.';

  @override
  String get session_retryStop => 'Zkusit vypnutí znovu';

  @override
  String get session_retryCleanup => 'Zkusit vyčištění znovu';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Bezpečně připravuji FuzeVPN…';

  @override
  String get nav_connection => 'Připojení';

  @override
  String get nav_locations => 'Lokality';

  @override
  String get nav_account => 'Účet';

  @override
  String get nav_devices => 'Zařízení';

  @override
  String get nav_settings => 'Nastavení';

  @override
  String get action_refresh => 'Obnovit';

  @override
  String get auth_tab_login => 'Přihlásit se';

  @override
  String get auth_tab_register => 'Zaregistrovat se';

  @override
  String get auth_stepAccount => 'Účet';

  @override
  String get auth_stepIdentity => 'Identita';

  @override
  String get auth_stepAddress => 'Adresa a souhlasy';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Krok $current z $total';
  }

  @override
  String get auth_tagline => 'Vaše VPN jednoduše.';

  @override
  String get auth_keysLocal =>
      'Vaše soukromé klíče VPN zůstávají v tomto zařízení.';

  @override
  String get form_email => 'E-mailová adresa';

  @override
  String get form_password => 'Heslo';

  @override
  String get form_showPassword => 'Zobrazit heslo';

  @override
  String get form_hidePassword => 'Skrýt heslo';

  @override
  String get form_passwordMin =>
      '8–72 bajtů UTF-8. Některé znaky zabírají více než jeden bajt.';

  @override
  String get form_firstName => 'Jméno';

  @override
  String get form_lastName => 'Příjmení';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adresa';

  @override
  String get form_address2 => 'Druhý řádek adresy (volitelné)';

  @override
  String get form_postalCode => 'PSČ';

  @override
  String get form_city => 'Město';

  @override
  String get form_country => 'Kód země (např. FR)';

  @override
  String get action_login => 'Přihlásit se';

  @override
  String get action_createAccount => 'Vytvořit účet';

  @override
  String get action_createMyAccount => 'Vytvořit můj účet';

  @override
  String get action_next => 'Pokračovat';

  @override
  String get action_previous => 'Zpět';

  @override
  String get action_forgotPassword => 'Zapomněli jste heslo?';

  @override
  String get auth_noAccount => 'Ještě nemáte účet?';

  @override
  String get auth_requiredInformation => 'Vytvořte si účet ve třech krocích.';

  @override
  String get auth_termsPrefix => 'Souhlasím s ';

  @override
  String get auth_termsLink => 'podmínkami použití';

  @override
  String get auth_privacyPrefix => 'Souhlasím se ';

  @override
  String get auth_privacyLink => 'zásadami ochrany soukromí';

  @override
  String get auth_consentRequired =>
      'K vytvoření účtu je vyžadován váš souhlas.';

  @override
  String get validation_required => 'Toto pole je povinné.';

  @override
  String get validation_email => 'Zadejte platnou e-mailovou adresu.';

  @override
  String get validation_password =>
      'Heslo je příliš krátké: musí mít alespoň 8 bajtů UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Heslo je příliš dlouhé: může mít nejvýše 72 bajtů UTF-8.';

  @override
  String get validation_phone =>
      'Použijte mezinárodní formát, například +33612345678.';

  @override
  String get validation_country =>
      'Použijte dvoupísmenný kód země, například FR.';

  @override
  String get passwordReset_title => 'Obnovení hesla';

  @override
  String get passwordReset_description =>
      'Zadejte e-mailovou adresu svého účtu a požádejte o odkaz pro obnovení hesla.';

  @override
  String get passwordReset_send => 'Odeslat odkaz';

  @override
  String get connection_title => 'Vaše připojení';

  @override
  String get connection_subtitle => 'Vyberte lokalitu a poté zapněte VPN.';

  @override
  String get connection_prepare => 'Jste připraveni se připojit?';

  @override
  String get connection_advancedOptions => 'Pokročilé možnosti';

  @override
  String get connection_location => 'Lokalita';

  @override
  String get connection_chooseLocation => 'Vyberte lokalitu';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Připojit';

  @override
  String get connection_connecting => 'Připojování…';

  @override
  String get connection_disconnect => 'Odpojit';

  @override
  String get connection_disconnecting => 'Odpojování';

  @override
  String get connection_locationChange => 'Změna lokality…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol není k dispozici';
  }

  @override
  String get connection_activeLocation => 'Aktivní lokalita';

  @override
  String get connection_duration => 'Doba trvání';

  @override
  String get connection_received => 'Přijato';

  @override
  String get connection_sent => 'Odesláno';

  @override
  String get connection_lastHandshake => 'Poslední zabezpečená výměna';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'před $duration';
  }

  @override
  String get verification_title => 'Potvrďte svou e-mailovou adresu';

  @override
  String get verification_message =>
      'Potvrďte svou e-mailovou adresu, abyste mohli VPN používat na tomto telefonu.';

  @override
  String get verification_resend => 'Odeslat e-mail znovu';

  @override
  String get migration_title => 'Změna lokality';

  @override
  String get migration_draining => 'Příprava změny lokality…';

  @override
  String get migration_activating => 'Aktivace nového serveru…';

  @override
  String get migration_ready => 'Lokalita byla aktualizována.';

  @override
  String get migration_blocked =>
      'Změna lokality vyžaduje zásah serveru. Zkuste to později nebo kontaktujte podporu.';

  @override
  String get migration_progress => 'Průběh změny lokality';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Prodleva mezi kontrolami: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Pokračovat ve změně lokality';

  @override
  String get status_authorizing => 'Vyžadováno oprávnění';

  @override
  String get status_authorizingDetail =>
      'Povolte VPN přijetím požadavku systému Android.';

  @override
  String get status_preparing => 'Příprava';

  @override
  String get status_preparingDetail => 'Připravuji vaše zabezpečené připojení.';

  @override
  String get status_reconnecting => 'Opětovné připojování…';

  @override
  String get status_reconnectingDetail =>
      'Připojení bylo přerušeno. VPN se pokouší znovu připojit.';

  @override
  String get status_connecting => 'Připojování';

  @override
  String get status_connectingDetail => 'Připojování k serveru VPN…';

  @override
  String get status_connected => 'Připojeno';

  @override
  String get status_connectedDetail => 'Vaše připojení VPN je aktivní.';

  @override
  String get status_disconnecting => 'Odpojování';

  @override
  String get status_disconnectingDetail => 'Vaše připojení VPN se ukončuje.';

  @override
  String get status_error => 'Připojení není k dispozici';

  @override
  String get status_errorDetail =>
      'Připojení VPN není potvrzeno. Zkuste to znovu.';

  @override
  String get status_idle => 'Odpojeno';

  @override
  String get status_idleDetail => 'Připojte VPN a ochraňte své připojení.';

  @override
  String get trust_note =>
      'Zavření aplikace VPN nezastaví. Zastavíte ji pomocí možnosti Odpojit.';

  @override
  String get locations_none =>
      'V tuto chvíli nejsou k dispozici žádné lokality.';

  @override
  String get locations_available => 'Vyberte svou další lokalitu.';

  @override
  String get locations_selected => 'Vybraná lokalita';

  @override
  String get locations_select => 'Vybrat tuto lokalitu';

  @override
  String get locations_lockedTunnel =>
      'Chcete-li změnit lokalitu, odpojte VPN.';

  @override
  String get locations_lockedMigration =>
      'Počkejte na dokončení změny lokality.';

  @override
  String get devices_title => 'Vaše zařízení';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit zařízení';
  }

  @override
  String get devices_refresh => 'Obnovit zařízení';

  @override
  String get devices_empty => 'Zatím není zaregistrováno žádné zařízení VPN.';

  @override
  String get devices_firstConnection =>
      'Telefon bude přidán při prvním připojení.';

  @override
  String get devices_thisDevice => 'Toto zařízení';

  @override
  String devices_added(Object date) {
    return 'Přidáno $date';
  }

  @override
  String get action_remove => 'Odebrat';

  @override
  String get settings_title => 'Nastavení';

  @override
  String get settings_subtitle => 'Vaše předvolby a účet na jednom místě.';

  @override
  String get settings_appearance => 'Vzhled';

  @override
  String get settings_language => 'Jazyk';

  @override
  String get settings_languageDescription =>
      'Vybraný jazyk se použije i pro oznámení VPN.';

  @override
  String get settings_account => 'Účet';

  @override
  String get settings_signOut => 'Odhlásit se';

  @override
  String get settings_privacy => 'Zásady ochrany soukromí';

  @override
  String get settings_terms => 'Podmínky použití';

  @override
  String get settings_security => 'Bezpečnost a transparentnost';

  @override
  String get settings_licenses => 'Licence komponent';

  @override
  String get settings_licensesDetail => 'Software použitý v aplikaci';

  @override
  String get settings_background =>
      'VPN zůstává zapnutá, i když aplikaci opustíte. Zastavíte ji pomocí možnosti Odpojit na kartě Připojení.';

  @override
  String get theme_system => 'Systémové';

  @override
  String get theme_light => 'Světlý';

  @override
  String get theme_dark => 'Tmavý';

  @override
  String get language_system => 'Jazyk telefonu';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Odebrat toto zařízení?';

  @override
  String get dialog_removeCurrent =>
      'Tento telefon se odpojí od VPN a ztratí přístup. Data jeho připojení VPN budou odstraněna po potvrzení serverem.';

  @override
  String dialog_removeOther(Object name) {
    return 'Přístup VPN pro zařízení „$name“ bude zrušen. Tuto akci nelze vrátit.';
  }

  @override
  String get dialog_signOut => 'Odhlásit se?';

  @override
  String get dialog_signOutMessage =>
      'VPN se zastaví a budete se muset znovu přihlásit. Vaše šifrované klíče VPN zůstanou v tomto telefonu pro příští připojení.';

  @override
  String get action_cancel => 'Zrušit';

  @override
  String get action_signOut => 'Odhlásit se';

  @override
  String get notice_close => 'Zavřít oznámení';

  @override
  String get notice_sessionExpired_title => 'Relace vypršela';

  @override
  String get notice_sessionExpired_message =>
      'Platnost vaší relace vypršela. Přihlaste se znovu.';

  @override
  String get notice_connectionFailed_title => 'Připojení se nezdařilo';

  @override
  String get notice_invalidCredentials_message =>
      'E-mailová adresa nebo heslo jsou nesprávné.';

  @override
  String get notice_emailVerification_title => 'Vyžadováno potvrzení e-mailu';

  @override
  String get notice_emailVerification_message =>
      'Před přidáním zařízení VPN potvrďte svou e-mailovou adresu.';

  @override
  String get notice_rateLimited_title => 'Příliš mnoho pokusů';

  @override
  String get notice_deviceLimit_title => 'Dosažen limit 2 zařízení';

  @override
  String get notice_deviceLimit_message =>
      'Před přidáním dalšího zařízení odeberte některé stávající zařízení.';

  @override
  String get notice_identityRenewal_title => 'Identitu VPN je nutné obnovit';

  @override
  String get notice_identityRenewal_message =>
      'Tato identita byla odstraněna. Vytvořte novou místní identitu.';

  @override
  String get notice_migrationPending_title => 'Probíhá změna lokality';

  @override
  String get notice_migrationPending_message => 'Změna lokality již probíhá.';

  @override
  String get notice_migrationBlocked_title => 'Změna lokality zablokována';

  @override
  String get notice_migrationBlocked_message =>
      'Změna lokality vyžaduje zásah serveru. Zkuste to později nebo kontaktujte podporu.';

  @override
  String get notice_targetUnavailable_title => 'Server je dočasně nedostupný';

  @override
  String get notice_targetUnavailable_message =>
      'Tento server je dočasně nedostupný.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetové připojení není k dispozici';

  @override
  String get notice_networkUnavailable_message =>
      'Zkontrolujte své připojení a zkuste to znovu.';

  @override
  String get notice_permissionDenied_title => 'Oprávnění VPN zamítnuto';

  @override
  String get notice_permissionDenied_message =>
      'Spusťte připojení znovu a přijměte požadavek systému Android na oprávnění.';

  @override
  String get notice_wireguardTimeout_title => 'Server neodpovídá';

  @override
  String get notice_wireguardTimeout_message =>
      'Připojení WireGuard trvalo příliš dlouho. Zkuste to znovu nebo vyberte jinou lokalitu.';

  @override
  String get notice_tlsFailed_title => 'Zabezpečené připojení odmítnuto';

  @override
  String get notice_tlsFailed_message =>
      'Server nepřijal připojení OpenVPN. Zkuste to znovu. Pokud problém přetrvá, spusťte diagnostiku.';

  @override
  String get notice_tunRejected_title => 'Android odmítl rozhraní VPN';

  @override
  String get notice_tunRejected_message =>
      'Android odmítl síťovou konfiguraci požadovanou OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN se nepodařilo spustit';

  @override
  String get notice_openvpnStart_message =>
      'Modul OpenVPN nedokázal dokončit spouštění. Zkuste to znovu. Pokud problém přetrvá, kontaktujte podporu.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostický kód: $code';
  }

  @override
  String get notice_generic_title => 'Připojení VPN se nezdařilo';

  @override
  String get notice_generic_message => 'Došlo k chybě. Zkuste to později.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Účet byl vytvořen',
      'password_reset_sent': 'Žádost o obnovení hesla přijata',
      'verification_email_sent': 'Ověřovací e-mail odeslán',
      'location_migration_pending': 'Probíhá změna lokality',
      'vpn_sign_in_required': 'Vyžadováno přihlášení',
      'protocol_unavailable_at_location': 'Protokol není k dispozici',
      'vpn_permission_denied': 'Oprávnění VPN zamítnuto',
      'revoked_identity_device_limit': 'Dosažen limit 2 zařízení',
      'tunnel_start_unexpected': 'VPN se nepodařilo spustit',
      'flutter_disconnect_timeout': 'Odpojení nebylo potvrzeno',
      'flutter_disconnect_unexpected': 'Odpojení se nezdařilo',
      'device_revoked': 'Zařízení odebráno',
      'revoke_unexpected': 'Zařízení se nepodařilo odebrat',
      'identity_renewal_unexpected': 'Identitu se nepodařilo obnovit',
      'openvpn_renewal_unexpected': 'OpenVPN se nepodařilo obnovit',
      'location_migration_blocked': 'Změna lokality zablokována',
      'location_migration_slow': 'Změna lokality stále probíhá',
      'location_migration_conflict': 'Změnu lokality je nutné obnovit',
      'location_migration_verification_failed':
          'Změna lokality nebyla potvrzena',
      'location_migration_device_changed':
          'Během změny lokality se zařízení změnilo',
      'tunnel_stop_failed': 'Změna lokality není k dispozici',
      'other': 'Operace se nezdařila',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Účet byl vytvořen, ale ověřovací e-mail se nepodařilo odeslat. V aplikaci použijte možnost odeslat znovu.',
      'password_reset_sent':
          'Vaše žádost byla přijata. Pokud této adrese odpovídá účet, můžete obdržet e-mail. Zkontrolujte také složku se spamem.',
      'verification_email_sent': 'Právě byl odeslán nový ověřovací e-mail.',
      'location_migration_pending':
          'Přesun do lokality $target se stále připravuje. Můžete v něm pokračovat bez opětovného vytváření zařízení.',
      'vpn_sign_in_required': 'Před spuštěním VPN se přihlaste ke svému účtu.',
      'protocol_unavailable_at_location':
          'Vybraný protokol tato lokalita nenabízí. Obnovte seznam lokalit nebo vyberte jiný protokol.',
      'vpn_permission_denied':
          'Android zamítl oprávnění VPN. Spusťte připojení znovu a přijměte systémový požadavek.',
      'revoked_identity_device_limit':
          'Přístup tohoto zařízení k VPN byl odebrán a byl dosažen limit zařízení. Odeberte zařízení v části Účet → Spravovat moje zařízení.',
      'tunnel_start_unexpected':
          'Neočekávaná chyba přerušila přípravu tunelu. Zkontrolujte diagnostický kód a zkuste to znovu.',
      'flutter_disconnect_timeout':
          'Android včas nepotvrdil zastavení VPN. Zkuste ji zastavit znovu.',
      'flutter_disconnect_unexpected':
          'Neočekávaná chyba zabránila potvrzení zastavení tunelu.',
      'device_revoked':
          'Přístup zařízení k VPN byl zrušen a jeho místní tajné údaje byly odstraněny.',
      'revoke_unexpected':
          'Zařízení se nepodařilo odebrat. Obnovte seznam a zkuste to znovu.',
      'identity_renewal_unexpected':
          'Novou identitu VPN se nepodařilo vytvořit. Obnovte zařízení a zkuste to znovu.',
      'openvpn_renewal_unexpected':
          'Profil OpenVPN se nepodařilo obnovit. Zkuste to znovu nebo zkontrolujte diagnostický kód.',
      'location_migration_blocked':
          'Server tuto změnu nyní nemůže dokončit. Zařízení a jeho místní identita byly zachovány.',
      'location_migration_slow':
          'Server stále připravuje přesun do lokality $target. Za chvíli použijte možnost Pokračovat.',
      'location_migration_conflict':
          'Stav zařízení se na serveru změnil. Obnovte zařízení a poté pokračujte ve změně.',
      'location_migration_verification_failed':
          'Server nepotvrdil novou lokalitu. Předchozí místní identita byla zachována.',
      'location_migration_device_changed':
          'Zařízení vrácené serverem již neodpovídá zařízení, u kterého probíhá změna. Před dalším pokusem obnovte zařízení.',
      'tunnel_stop_failed':
          'Předchozí tunel musí být před novým připojením zcela zastaven.',
      'other':
          'Operaci se nepodařilo dokončit. Zkuste to znovu nebo odešlete diagnostický kód podpoře.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Relace vypršela',
      'invalid_credentials': 'Přihlášení se nezdařilo',
      'email_verification_required': 'Vyžadováno potvrzení e-mailu',
      'verification_email_cooldown': 'E-mail již byl odeslán',
      'rate_limited': 'Příliš mnoho pokusů',
      'invalid_registration': 'Informace je nutné opravit',
      'email_exists': 'Účet již existuje',
      'invalid_profile': 'Neplatný profil',
      'invalid_device': 'Neplatné zařízení',
      'invalid_location': 'Lokalita není k dispozici',
      'device_limit': 'Dosažen limit zařízení',
      'device_exists': 'Identita VPN se již používá',
      'device_identity_revoked': 'Identitu VPN je nutné obnovit',
      'device_location_locked': 'Změnu lokality je nutné obnovit',
      'location_migration_pending': 'Probíhá změna lokality',
      'location_migration_blocked': 'Změna lokality zablokována',
      'target_ca_mismatch': 'Nekompatibilní server OpenVPN',
      'location_migration_conflict': 'Změnu lokality je nutné obnovit',
      'server_full': 'Server je plný',
      'capacity_unavailable': 'Lokalita je dočasně nedostupná',
      'target_unavailable': 'Server je dočasně nedostupný',
      'not_found': 'Položka nebyla nalezena',
      'invalid_openvpn_csr': 'Neplatná identita OpenVPN',
      'openvpn_profile_exists': 'Profil OpenVPN již existuje',
      'openvpn_profile_revoked': 'Profil OpenVPN byl zrušen',
      'openvpn_operation_pending': 'Probíhá operace OpenVPN',
      'openvpn_operation_terminal': 'Operace OpenVPN byla přerušena',
      'openvpn_address_unavailable': 'Adresa OpenVPN není k dispozici',
      'openvpn_profile_conflict': 'Konflikt OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN není k dispozici',
      'email_delivery_unavailable': 'E-mail není k dispozici',
      'invalid_token': 'Neplatný odkaz',
      'network_unavailable': 'Internetové připojení není k dispozici',
      'invalid_json': 'Neplatný požadavek',
      'invalid_api_response': 'Neplatná odpověď serveru',
      'ipv6_unavailable': 'IPv6 není k dispozici',
      'invalid_ip_families': 'Konfigurace sítě odmítnuta',
      'other': 'Služba není k dispozici',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Platnost vaší relace vypršela. Přihlaste se znovu.',
      'invalid_credentials': 'E-mailová adresa nebo heslo jsou nesprávné.',
      'email_verification_required':
          'Před přidáním zařízení VPN potvrďte svou e-mailovou adresu.',
      'invalid_registration': 'Zkontrolujte požadované informace a souhlasy.',
      'email_exists': 'Tuto e-mailovou adresu již používá jiný účet.',
      'invalid_profile': 'Zkontrolujte údaje svého profilu.',
      'invalid_device':
          'Název tohoto zařízení nebo jeho místní identita jsou neplatné.',
      'invalid_location': 'Obnovte seznam lokalit a zkuste to znovu.',
      'device_limit':
          'Před přidáním dalšího zařízení odeberte některé stávající zařízení.',
      'device_exists': 'Tato identita VPN je již propojena s jiným účtem.',
      'device_identity_revoked':
          'Tato identita byla odstraněna. Je nutné vytvořit novou místní identitu.',
      'device_location_locked':
          'Lokalita tohoto zařízení se právě změnila. Aplikace bude pokračovat v probíhající změně.',
      'location_migration_pending': 'Změna lokality již probíhá.',
      'location_migration_blocked':
          'Změna lokality vyžaduje zásah serveru. Zkuste to později nebo kontaktujte podporu.',
      'target_ca_mismatch':
          'Tento server zatím není kompatibilní s aktuálním profilem OpenVPN.',
      'location_migration_conflict':
          'Obnovte zařízení a poté změnu lokality zkuste znovu.',
      'server_full':
          'Tato lokalita dosáhla svého limitu připojení. Vyberte jinou lokalitu nebo to zkuste později.',
      'capacity_unavailable':
          'Nelze potvrdit, zda je tato lokalita právě dostupná. Vyberte jinou lokalitu nebo to zkuste později.',
      'target_unavailable': 'Tento server je dočasně nedostupný.',
      'not_found': 'Tato položka již není ve vašem účtu k dispozici.',
      'invalid_openvpn_csr':
          'Vytvořte novou identitu OpenVPN a zkuste to znovu.',
      'openvpn_profile_exists':
          'Pro toto zařízení již existuje profil OpenVPN.',
      'openvpn_profile_revoked': 'Pro pokračování obnovte profil OpenVPN.',
      'openvpn_operation_pending': 'Změna se stále šíří. Zkuste to později.',
      'openvpn_operation_terminal':
          'Vytvořte novou identitu OpenVPN a zkuste to znovu.',
      'openvpn_address_unavailable':
          'V tuto chvíli není k dispozici žádná adresa OpenVPN.',
      'openvpn_profile_conflict':
          'Profil se změnil. Obnovte zařízení a zkuste to znovu.',
      'openvpn_signer_unavailable': 'Služba OpenVPN je dočasně nedostupná.',
      'email_delivery_unavailable':
          'E-mail se nepodařilo odeslat. Zkuste to později.',
      'invalid_token':
          'Tento odkaz je neplatný nebo jeho platnost vypršela. Požádejte o nový.',
      'network_unavailable':
          'Zkontrolujte připojení k internetu a zkuste to znovu.',
      'invalid_json': 'Zkontrolujte zadané údaje a zkuste to znovu.',
      'invalid_api_response':
          'Server vrátil neočekávanou odpověď. Zkuste to později.',
      'ipv6_unavailable':
          'Server momentálně nemůže aktivovat IPv6. Zkuste to později.',
      'invalid_ip_families':
          'Konfigurace tunelu je neúplná nebo neodpovídá autorizovaným adresám. Zkuste to znovu z aplikace.',
      'other': 'Došlo k chybě serveru. Zkuste to později.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Zkuste to znovu za chvíli.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Zkuste to znovu za $seconds sekund.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Obnovení systémové VPN není k dispozici',
      'system_vpn_resume_corrupt': 'Neplatné obnovení systémové VPN',
      'system_vpn_resume_session_invalid': 'Neplatná relace obnovení VPN',
      'system_vpn_resume_identity_changed': 'Identita VPN se změnila',
      'system_vpn_resume_identity_invalid': 'Neplatná identita obnovení VPN',
      'system_vpn_resume_storage_failed':
          'Úložiště pro obnovení VPN není k dispozici',
      'system_vpn_resume_network_timeout': 'Obnovení VPN nemá připojení k síti',
      'system_vpn_resume_blocked': 'Obnovení VPN je zablokováno',
      'system_vpn_resume_failed': 'Obnovení VPN se nezdařilo',
      'system_vpn_resume_error_invalid': 'Neplatná chyba obnovení VPN',
      'wireguard_identity_store_failed': 'Identita WireGuard nebyla uložena',
      'wireguard_identity_unavailable': 'Identita WireGuard není k dispozici',
      'vpn_host_destroyed': 'Hostitel VPN v Androidu byl zastaven',
      'vpn_host_unavailable': 'Hostitel VPN v Androidu není k dispozici',
      'vpn_permission_required': 'Vyžadováno oprávnění VPN',
      'vpn_permission_denied': 'Oprávnění VPN zamítnuto',
      'vpn_permission_request_failed':
          'Požadavek na oprávnění se nepodařilo odeslat',
      'wireguard_foreground_service_unavailable':
          'Služba WireGuard není k dispozici',
      'wireguard_identity_invalid': 'Neplatný místní klíč WireGuard',
      'wireguard_identity_in_use': 'Identita WireGuard se již používá',
      'wireguard_configuration_invalid': 'Neplatná konfigurace WireGuard',
      'wireguard_operation_pending': 'Operace WireGuard je stále aktivní',
      'wireguard_start_failed': 'Spuštění WireGuard odmítnuto',
      'wireguard_stop_timeout': 'Zastavení WireGuard nebylo potvrzeno',
      'wireguard_handshake_timeout': 'WireGuard neodpověděl',
      'openvpn_connection_timeout': 'OpenVPN neodpověděla',
      'openvpn_core_unavailable': 'Modul OpenVPN není k dispozici',
      'openvpn_operation_pending': 'Relace OpenVPN je stále aktivní',
      'openvpn_stop_timeout': 'Zastavení OpenVPN nebylo potvrzeno',
      'openvpn_profile_unavailable': 'Místní profil OpenVPN chybí',
      'openvpn_native_failed': 'Nativní volání OpenVPN bylo přerušeno',
      'openvpn_key_generation_failed':
          'Klíč OpenVPN P-256 se nepodařilo vytvořit',
      'openvpn_csr_generation_failed': 'CSR OpenVPN se nepodařilo vytvořit',
      'openvpn_identity_store_failed': 'Identita OpenVPN nebyla uložena',
      'openvpn_identity_clear_failed': 'Odstranění OpenVPN nebylo dokončeno',
      'openvpn_identity_in_use': 'Identita OpenVPN se stále používá',
      'openvpn_tls_verification_required': 'Chybí ověření TLS OpenVPN',
      'openvpn_cipher_invalid': 'Neplatná šifra OpenVPN',
      'openvpn_profile_rejected': 'Profil OpenVPN odmítnut',
      'openvpn_identity_inconsistent': 'Nekonzistentní identita OpenVPN',
      'tls_handshake_failed': 'Vyjednávání OpenVPN odmítnuto',
      'tls_alert_unknown_ca': 'Certifikát klienta OpenVPN nebyl rozpoznán',
      'tls_alert_bad_certificate': 'Certifikát klienta OpenVPN odmítnut',
      'tls_alert_unsupported_certificate': 'Nepodporovaný certifikát OpenVPN',
      'tls_client_certificate_required': 'Vyžadován certifikát klienta OpenVPN',
      'tls_alert_misc': 'Upozornění TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Nepodporovaný podpis OpenVPN',
      'tls_handshake_rejected': 'Vyjednávání TLS OpenVPN odmítnuto',
      'tls_version_rejected': 'Nekompatibilní verze TLS OpenVPN',
      'tls_certificate_expired': 'Platnost certifikátu TLS vypršela',
      'tls_certificate_revoked': 'Certifikát TLS byl zrušen',
      'transport_failed': 'Server OpenVPN není dostupný',
      'tun_configuration_rejected': 'Rozhraní OpenVPN se nepodařilo vytvořit',
      'tun_setup_failed': 'Nastavení TUN OpenVPN se nezdařilo',
      'tun_interface_create_failed': 'Vytvoření rozhraní OpenVPN se nezdařilo',
      'tun_interface_disabled': 'Rozhraní OpenVPN bylo zakázáno',
      'tun_halted': 'Rozhraní OpenVPN bylo přerušeno',
      'tun_already_established': 'Rozhraní OpenVPN je již otevřené',
      'tun_addresses_missing': 'Chybí adresa OpenVPN',
      'tun_routes_missing': 'Chybí trasy OpenVPN',
      'tun_dns_missing': 'Chybí DNS OpenVPN',
      'tun_permission_revoked': 'Oprávnění VPN bylo zrušeno',
      'tun_establish_returned_null': 'Android odmítl rozhraní VPN',
      'openvpn_service_start_failed': 'Služba OpenVPN není k dispozici',
      'openvpn_operation_timeout': 'Volání OpenVPN vypršel časový limit',
      'openvpn_start_failed': 'Spuštění OpenVPN odmítnuto',
      'openvpn_connection_failed': 'Připojení OpenVPN bylo přerušeno',
      'openvpn_core_status_error': 'Modul OpenVPN skončil s chybou',
      'openvpn_stopped_before_connected':
          'OpenVPN se zastavila před připojením',
      'openvpn_auth_failed': 'Ověření OpenVPN odmítnuto',
      'openvpn_client_setup_failed': 'Nastavení klienta OpenVPN se nezdařilo',
      'openvpn_client_halted': 'Klient OpenVPN byl přerušen',
      'openvpn_client_restart': 'Vyžadován restart OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN byla příliš dlouho neaktivní',
      'openvpn_session_expired': 'Relace OpenVPN vypršela',
      'openvpn_credentials_required': 'Nepodporované ověření OpenVPN',
      'openvpn_proxy_failed': 'Přenos přes prostředníka OpenVPN se nezdařil',
      'openvpn_compression_failed': 'Komprese OpenVPN odmítnuta',
      'openvpn_ntlm_crypto_unavailable':
          'Šifrování NTLM OpenVPN není k dispozici',
      'openvpn_feature_unsupported': 'Nepodporovaná funkce OpenVPN',
      'network_unavailable': 'Internetové připojení není k dispozici',
      'network_lost': 'Síť není k dispozici',
      'certificate_validation_failed': 'Certifikát serveru odmítnut',
      'openvpn_certificate_expired': 'Platnost certifikátu OpenVPN vypršela',
      'tunnel_active_for_another_account': 'Tunel jiného účtu je stále aktivní',
      'tunnel_already_active': 'Nativní tunel je již aktivní',
      'tunnel_stop_timeout': 'Zastavení $protocol nebylo potvrzeno',
      'tunnel_disconnected': '$protocol bylo přerušeno',
      'native_bridge_unavailable': 'Most Androidu není k dispozici',
      'native_operation_failed': 'Operace Androidu byla přerušena',
      'invalid_arguments': 'Neúplné parametry VPN',
      'invalid_account_id': 'Neplatný účet VPN',
      'invalid_device_id': 'Neplatný identifikátor zařízení',
      'storage_key_not_allowed': 'Klíč úložiště odmítnut',
      'secure_storage_read_failed': 'Bezpečné čtení se nezdařilo',
      'secure_storage_write_failed': 'Bezpečný zápis se nezdařil',
      'key_generation_failed': 'Klíč WireGuard se nepodařilo vygenerovat',
      'csr_generation_failed': 'CSR OpenVPN se nepodařilo vygenerovat',
      'other': 'Neklasifikovaná nativní chyba VPN',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android nemůže najít obnovitelnou relaci VPN. Spusťte nové připojení v aplikaci.',
      'system_vpn_resume_corrupt':
          'Uložená data obnovení VPN jsou neplatná a nebudou použita. Spusťte nové připojení.',
      'system_vpn_resume_session_invalid':
          'Uložená relace již nemůže obnovit VPN. Přihlaste se znovu v aplikaci.',
      'system_vpn_resume_identity_changed':
          'Místní identita VPN se změnila. Obnovení bylo zastaveno; spusťte nové připojení.',
      'system_vpn_resume_identity_invalid':
          'Identita pro obnovení je neplatná. Spusťte nové připojení.',
      'system_vpn_resume_storage_failed':
          'Android nemohl přečíst ani aktualizovat šifrovaná data obnovení. Spusťte nové připojení.',
      'system_vpn_resume_network_timeout':
          'Android včas nenašel síť pro obnovení VPN. Zkuste to znovu, až bude síť k dispozici.',
      'system_vpn_resume_blocked':
          'Obnovení VPN je zablokováno. Zkontrolujte nastavení Androidu a poté spusťte nové připojení.',
      'system_vpn_resume_failed':
          'Obnovení VPN v Androidu se nezdařilo. Spusťte nové připojení v aplikaci.',
      'system_vpn_resume_error_invalid':
          'Android vrátil nepoužitelnou chybu obnovení. Spusťte nové připojení.',
      'wireguard_identity_store_failed':
          'Android nemohl uložit šifrovanou identitu WireGuard tohoto účtu.',
      'wireguard_identity_unavailable':
          'Pro toto připojení není k dispozici použitelná identita WireGuard.',
      'vpn_host_destroyed':
          'Komponenta Androidu hostující VPN byla zastavena. Spusťte nové připojení.',
      'vpn_host_unavailable':
          'Android nemůže vytvořit komponentu hostující VPN. Po kontrole nastavení VPN to zkuste znovu.',
      'openvpn_renewal_required':
          'Před připojením je nutné provést akci v aplikaci kvůli certifikátu.',
      'openvpn_recovery_failed':
          'Automatické obnovení se nezdařilo. Spusťte nové připojení v aplikaci.',
      'openvpn_recovery_exhausted':
          'Automatické obnovení již bylo použito. Spusťte nové připojení v aplikaci.',
      'vpn_permission_required':
          'Android před spuštěním tunelu vyžaduje nové oprávnění VPN.',
      'vpn_permission_denied':
          'Pro pokračování povolte FuzeVPN v požadavku Androidu.',
      'vpn_permission_request_failed':
          'Android nemohl otevřít obrazovku s oprávněním VPN.',
      'wireguard_foreground_service_unavailable':
          'Android nemohl udržet službu WireGuard v popředí.',
      'wireguard_identity_invalid':
          'Šifrovaný klíč WireGuard tohoto účtu nelze přečíst nebo je neplatný.',
      'wireguard_identity_in_use':
          'Klíč WireGuard tohoto účtu stále používá jiná operace.',
      'wireguard_configuration_invalid':
          'Přijatá adresa WireGuard, DNS, klíč serveru nebo trasy jsou neplatné.',
      'wireguard_operation_pending':
          'Předchozí operace WireGuard dosud neuvolnila svou nativní službu.',
      'wireguard_start_failed': 'Modul WireGuard odmítl aktivaci konfigurace.',
      'wireguard_stop_timeout':
          'Služba WireGuard v časovém limitu nepotvrdila uvolnění rozhraní VPN.',
      'wireguard_handshake_timeout':
          'Tunel včas nepotvrdil navázání spojení se serverem.',
      'openvpn_connection_timeout':
          'OpenVPN včas nepotvrdila připojení k serveru.',
      'openvpn_core_unavailable':
          'Tato verze aplikace neobsahuje použitelný modul OpenVPN.',
      'openvpn_operation_pending':
          'Nativní modul stále drží předchozí relaci OpenVPN a odmítá vytvořit druhou.',
      'openvpn_stop_timeout':
          'Modul OpenVPN Core v časovém limitu nepotvrdil zastavení a zničení své nativní relace.',
      'openvpn_profile_unavailable':
          'Pro toto připojení nelze načíst žádný ověřený profil OpenVPN.',
      'openvpn_native_failed':
          'Chyba aplikace přerušila OpenVPN. Zkuste se připojit znovu. Pokud problém přetrvá, spusťte diagnostiku.',
      'openvpn_key_generation_failed':
          'Android Keystore nemohl vytvořit ani přečíst neexportovatelný soukromý klíč P-256.',
      'openvpn_csr_generation_failed':
          'Klíč Android Keystore nemohl podepsat žádost o certifikát OpenVPN.',
      'openvpn_identity_store_failed':
          'Certifikát nebo profil OpenVPN se nepodařilo uložit do šifrovaného úložiště.',
      'openvpn_identity_clear_failed':
          'Android nemohl odstranit celou místní identitu OpenVPN tohoto účtu.',
      'openvpn_identity_in_use':
          'Nativní relace OpenVPN stále používá klíč nebo certifikát tohoto zařízení.',
      'openvpn_tls_verification_required':
          'Profil výslovně nevyžaduje ověření certifikátu serveru.',
      'openvpn_cipher_invalid':
          'Server poskytl šifrovací algoritmus, který není na seznamu povolených.',
      'openvpn_profile_rejected':
          'Profil přijatý ze serveru není kompatibilní. Vytvořte zařízení znovu a zkuste to znovu.',
      'openvpn_identity_inconsistent':
          'Certifikát neodpovídá zabezpečené identitě tohoto telefonu. Žádný místní profil nebyl nahrazen.',
      'tls_handshake_failed':
          'Server odmítl vyjednávání TLS. Pokud problém přetrvá, vytvořte profil znovu.',
      'tls_alert_unknown_ca':
          'Server neuznává autoritu certifikátu tohoto zařízení. Server OpenVPN je nutné zkontrolovat.',
      'tls_alert_bad_certificate':
          'Server odmítl certifikát tohoto zařízení. Před dalším pokusem zařízení vytvořte znovu.',
      'tls_alert_unsupported_certificate':
          'Server nepodporuje typ zabezpečeného certifikátu používaný Androidem.',
      'tls_client_certificate_required':
          'Server vyžaduje certifikát klienta, ale OpenVPN Core jej nemohl předložit.',
      'tls_alert_misc':
          'Server vrátil upozornění TLS mimo kategorie certifikátu a verze.',
      'tls_signature_algorithm_rejected':
          'Server odmítl algoritmus ECDSA P-256 klíče Android Keystore.',
      'tls_handshake_rejected':
          'Server přerušil vyjednávání TLS před připojením.',
      'tls_version_rejected': 'Klient a server nenašli společnou verzi TLS.',
      'tls_certificate_expired':
          'Platnost certifikátu předloženého při připojení vypršela.',
      'tls_certificate_revoked':
          'Certifikát předložený při připojení byl zrušen.',
      'transport_failed':
          'Server OpenVPN na aktuální síti neodpovídá. Zkuste to za chvíli.',
      'tun_configuration_rejected':
          'Android odmítl síťovou konfiguraci požadovanou OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core odmítl plán sítě před vytvořením rozhraní Androidu.',
      'tun_interface_create_failed':
          'OpenVPN Core nemohl získat rozhraní TUN ze služby Android VpnService.',
      'tun_interface_disabled':
          'Android nebo OpenVPN Core během připojování zakázal rozhraní TUN.',
      'tun_halted': 'OpenVPN Core obdržel požadavek na zastavení rozhraní TUN.',
      'tun_already_established':
          'OpenVPN požadovala druhé rozhraní ve stejném připojení. Tunel byl z bezpečnostních důvodů zastaven.',
      'tun_addresses_missing': 'Server neposkytl použitelnou adresu tunelu.',
      'tun_routes_missing': 'Server neposkytl použitelné trasy tunelu.',
      'tun_dns_missing': 'Server neposkytl použitelný server DNS.',
      'tun_permission_revoked': 'Android během připojení zrušil oprávnění VPN.',
      'tun_establish_returned_null':
          'Android nevytvořil rozhraní, obvykle proto, že je stále aktivní jiná VPN.',
      'openvpn_service_start_failed':
          'Android nemohl spustit službu OpenVPN v popředí.',
      'openvpn_operation_timeout':
          'Volání JNI do OpenVPN Core překročilo maximální dobu trvání.',
      'openvpn_start_failed':
          'Služba Androidu je připravena, ale OpenVPN Core odmítl spustit profil.',
      'openvpn_connection_failed':
          'OpenVPN Core se zastavil před vysláním události CONNECTED.',
      'openvpn_core_status_error':
          'Smyčka nativního OpenVPN skončila s chybou bez konkrétnější koncové události.',
      'openvpn_stopped_before_connected':
          'Smyčka nativního OpenVPN se zastavila před CONNECTED bez výslovné chyby Core.',
      'openvpn_auth_failed': 'Server OpenVPN odmítl ověření profilu.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nemohl inicializovat klienta před připojením k síti.',
      'openvpn_client_halted':
          'OpenVPN Core obdržel koncový požadavek na zastavení klienta.',
      'openvpn_client_restart':
          'OpenVPN Core požádal o restart své transportní relace.',
      'openvpn_inactive_timeout':
          'OpenVPN Core zavřel relaci po vypršení časového limitu neaktivity.',
      'openvpn_session_expired': 'Server oznámil, že relace OpenVPN vypršela.',
      'openvpn_credentials_required':
          'Server nebo proxy požaduje interaktivní přihlašovací údaje, které nejsou součástí tohoto profilu certifikátu.',
      'openvpn_proxy_failed':
          'OpenVPN Core oznámil selhání nakonfigurované proxy nebo přenosového prostředníka.',
      'openvpn_compression_failed':
          'OpenVPN Core odmítl režim komprese oznámený profilem nebo serverem.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil požaduje šifrování NTLM, které v této verzi není k dispozici.',
      'openvpn_feature_unsupported':
          'Profil nebo server vyžaduje funkci, která v tomto klientovi Androidu chybí.',
      'network_unavailable': 'Není k dispozici žádná použitelná fyzická síť.',
      'network_lost': 'Tunel byl po ztrátě sítě zastaven.',
      'certificate_validation_failed':
          'Identitu serveru OpenVPN se nepodařilo ověřit.',
      'openvpn_certificate_expired':
          'Před opětovným připojením obnovte profil OpenVPN.',
      'tunnel_active_for_another_account':
          'Před tímto připojením je nutné zastavit tunel patřící jinému účtu.',
      'tunnel_already_active':
          'Android hlásí, že rozhraní stále používá předchozí relace VPN.',
      'tunnel_stop_timeout':
          'Modul $protocol v časovém limitu nepotvrdil uvolnění rozhraní VPN.',
      'tunnel_disconnected':
          'Nativní modul oznámil, že tunel se po spuštění neočekávaně ukončil.',
      'native_bridge_unavailable':
          'Aplikace nemůže přistupovat ke službě Android VPN. Zavřete a znovu otevřete aplikaci a zkuste to znovu.',
      'native_operation_failed':
          'Chyba aplikace přerušila operaci VPN. Zkuste to znovu. Pokud problém přetrvá, spusťte diagnostiku.',
      'invalid_arguments':
          'Informace potřebné k této operaci VPN jsou neúplné. Zkuste to znovu. Pokud problém přetrvá, spusťte diagnostiku.',
      'invalid_account_id':
          'Nativní operace není spojena s platným identifikátorem účtu.',
      'invalid_device_id':
          'Identifikátor zařízení odeslaný nativnímu modulu chybí nebo je neplatný.',
      'storage_key_not_allowed':
          'Most Androidu zablokoval klíč mimo povolený seznam úložiště.',
      'secure_storage_read_failed':
          'Android Keystore nemohl dešifrovat místní data tohoto účtu.',
      'secure_storage_write_failed':
          'Android Keystore nemohl zašifrovat ani uložit místní data.',
      'key_generation_failed':
          'Android nemohl vytvořit ani přečíst klíč WireGuard v zabezpečeném úložišti.',
      'csr_generation_failed':
          'Android Keystore nemohl vytvořit ani podepsat CSR OpenVPN P-256.',
      'other':
          'Selhala nezdokumentovaná nativní větev. Odešlete níže zobrazený diagnostický kód podpoře.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Požadavek na oprávnění je již otevřený';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Požadavek systému Android na oprávnění VPN je již zobrazen. Dokončete jej, než to zkusíte znovu.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Požadavek na oprávnění VPN byl přerušen';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Obrazovka s požadavkem na oprávnění VPN se zavřela dříve, než aplikace obdržela odpověď.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Připojení OpenVPN nebylo potvrzeno';

  @override
  String get notice_openvpnProofMissing_message =>
      'Připojení OpenVPN se nepodařilo potvrdit. Z bezpečnostních důvodů bylo zastaveno. Zkuste to znovu.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN byl zrušen';

  @override
  String get openvpnCleanup_working =>
      'Zastavuji a odstraňuji zrušený profil OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Vypnutí OpenVPN nebylo potvrzeno. Před vytvořením nového profilu to zkuste znovu.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Zrušený profil OpenVPN se nepodařilo zcela odstranit. Zkuste vyčištění znovu.';

  @override
  String get openvpnCleanup_complete =>
      'Zrušený profil OpenVPN byl odstraněn. Klepnutím na Připojit vytvoříte nový.';

  @override
  String get network_title => 'Konfigurace sítě';

  @override
  String get network_ipv4Fallback =>
      'IPv6 je dočasně nedostupné. Příprava pokračuje pomocí IPv4.';

  @override
  String get network_rejectedTitle => 'Konfigurace sítě odmítnuta';

  @override
  String get network_rejectedMessage =>
      'Konfigurace tunelu je neúplná nebo neodpovídá autorizovaným adresám. Zkuste to znovu z aplikace.';

  @override
  String get network_unreadableTitle => 'Místní konfiguraci nelze přečíst';

  @override
  String get network_unreadableMessage =>
      'Uloženou síťovou konfiguraci OpenVPN nelze použít. Aktualizujte ji opětovným připojením z aplikace.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ochrana sítě';

  @override
  String get protection_subtitle =>
      'Zablokujte přímý přístup k internetu při odpojení VPN.';

  @override
  String get protection_active => 'Systémová ochrana je aktivní';

  @override
  String get protection_alwaysOnOnly =>
      'VPN stále zapnutá; zapněte blokování mimo VPN';

  @override
  String get protection_inactive => 'Systémová ochrana je neaktivní';

  @override
  String get protection_unknown => 'Zkontrolovat systémovou ochranu';

  @override
  String get protection_openSettings => 'Otevřít nastavení Androidu';

  @override
  String get protection_dialogTitle => 'Nastavení ochrany sítě';

  @override
  String get protection_dialogMessage =>
      'Android spravuje VPN stále zapnutou a blokování připojení mimo VPN. Zkontrolujte, že je vybrána FuzeVPN, a zapněte blokování v nastavení systému.';

  @override
  String get protection_dialogOpen => 'Otevřít nastavení';

  @override
  String get session_systemProtectionNote =>
      'Pokud Android stále blokuje provoz mimo VPN, otevřete nastavení systému a tuto ochranu zkontrolujte nebo změňte.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Diagnostika aplikace';

  @override
  String get diagnostics_automaticTitle => 'Odesílat důležité chyby';

  @override
  String get diagnostics_automaticDescription =>
      'Při výskytu důležité chyby sdílet stručný technický protokol.';

  @override
  String get diagnostics_privacy =>
      'Odeslané protokoly jsou spojeny s přihlášeným účtem a uchovávány 30 dní. Neobsahují historii prohlížení, hesla ani klíče VPN.';

  @override
  String get diagnostics_manualOpen => 'Spustit diagnostiku';

  @override
  String get diagnostics_localDescription =>
      'Vytvořte protokol o stavu aplikace a VPN. Vaše připojení zůstane beze změny.';

  @override
  String get diagnostics_sendReport => 'Odeslat protokol';

  @override
  String get diagnostics_sendHint =>
      'Ponechte toto políčko nezaškrtnuté, aby protokol zůstal v tomto zařízení.';

  @override
  String get diagnostics_signedOut =>
      'Chcete-li odeslat protokol, přihlaste se ke svému účtu.';

  @override
  String get diagnostics_localLifetime =>
      'Uložte tento protokol do telefonu, aby zůstal zachován i po zavření aplikace.';

  @override
  String get diagnostics_run => 'Spustit diagnostiku';

  @override
  String get diagnostics_rerun => 'Spustit diagnostiku znovu';

  @override
  String get diagnostics_running => 'Kontrola…';

  @override
  String get diagnostics_sending => 'Odesílání protokolu…';

  @override
  String get diagnostics_prepared => 'Protokol je v tomto zařízení připraven';

  @override
  String get diagnostics_queued => 'Protokol čeká na odeslání';

  @override
  String get diagnostics_sent => 'Protokol byl přijat';

  @override
  String get diagnostics_failed =>
      'Odeslání se nezdařilo. Váš místní protokol je stále k dispozici.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostický protokol se nepodařilo připravit. Zkuste to znovu.';

  @override
  String get diagnostics_authenticationRequired =>
      'Pro odeslání protokolu se znovu přihlaste.';

  @override
  String get diagnostics_retry => 'Zkusit odeslání znovu';

  @override
  String get diagnostics_export => 'Uložit protokol';

  @override
  String get diagnostics_exportFailed =>
      'Export se nezdařil. Zkuste to znovu z místního protokolu.';

  @override
  String get diagnostics_preferenceFailed =>
      'Toto nastavení se nepodařilo uložit. Zkuste to znovu.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Reference: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Přijato $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Uchováno do $date';
  }

  @override
  String get diagnostics_duplicate => 'Tento protokol již byl přijat.';

  @override
  String get diagnostics_preview => 'Náhled protokolu';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count připojených technických událostí',
      few: '$count připojené technické události',
      one: '$count připojená technická událost',
      zero: 'Nejsou připojeny žádné technické události',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Technické podrobnosti';

  @override
  String get diagnostics_empty =>
      'Zatím nebyl připraven žádný diagnostický protokol.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Stav tunelu',
      'handshake': 'Potvrzení připojení',
      'certificate': 'Certifikát VPN',
      'kill_switch': 'Ochrana Androidu',
      'connectivity': 'Dostupná síť',
      'api_reachability': 'Přístup ke službě',
      'secure_storage': 'Zabezpečené úložiště',
      'other': 'Místní kontrola',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Zkontrolováno',
      'failed': 'Vyžaduje pozornost',
      'skipped': 'Netestováno — žádná aktivní kontrola',
      'unknown': 'Informace není k dispozici',
      'other': 'Informace není k dispozici',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Vítejte ve FuzeVPN';

  @override
  String get connection_changeLocation => 'Změnit lokalitu';

  @override
  String get connection_details => 'Podrobnosti připojení';

  @override
  String get locations_searchLabel => 'Hledat město nebo zemi';

  @override
  String get locations_clearSearch => 'Vymazat hledání';

  @override
  String get locations_filterAll => 'Vše';

  @override
  String get locations_filterFavorites => 'Oblíbené';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokalit',
      few: '$count lokality',
      one: '$count lokalita',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nebyly nalezeny žádné lokality';

  @override
  String get locations_noResultsHint => 'Zkuste jiné město nebo zemi.';

  @override
  String get locations_noFavorites => 'Vaše oblíbené lokality na dosah';

  @override
  String get locations_noFavoritesHint =>
      'Klepnutím na hvězdičku vedle lokality ji uložíte sem.';

  @override
  String get locations_showAll => 'Zobrazit všechny lokality';

  @override
  String locations_addFavorite(String name) {
    return 'Přidat $name k oblíbeným';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Odebrat $name z oblíbených';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Oblíbenou položku se nepodařilo uložit. Zkuste to znovu.';

  @override
  String get locations_emptyTitle => 'Nejsou k dispozici žádné lokality';

  @override
  String get locations_emptyHint => 'Obnovte seznam a zkuste to znovu.';

  @override
  String get devices_manage => 'Spravovat moje zařízení';

  @override
  String get settings_personalization => 'Přizpůsobte si aplikaci';

  @override
  String get settings_safety => 'Ochrana';

  @override
  String get settings_help => 'Potřebujete pomoc?';

  @override
  String get settings_about => 'O aplikaci FuzeVPN';

  @override
  String get diagnostics_heading => 'Zjistěte příčinu problému s připojením';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'K dispozici',
      'pending': 'Příprava',
      'revoked': 'Odebráno',
      'expired': 'Platnost vypršela',
      'other': 'Stav není k dispozici',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Předvolba nebyla uložena';

  @override
  String get notice_preferenceSave_message =>
      'Vaše volba se nyní používá, ale nepodařilo se ji uložit. Zkuste to znovu, aby zůstala zachována po zavření aplikace.';

  @override
  String get connection_androidDisconnectHint =>
      'Pokud Android udržuje VPN aktivní, vypněte v otevřeném nastavení možnost VPN stále zapnutá.';

  @override
  String get protection_learnMore => 'Další informace o ochraně Androidu';

  @override
  String get protection_guideWhy =>
      'Tato ochrana zabrání aplikacím v přímém používání internetu při odpojení VPN. Konfiguruje se v Androidu.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN stále zapnutá';

  @override
  String get protection_guideAlwaysOn =>
      'Android udržuje službu VPN spuštěnou a může ji po restartu telefonu znovu spustit.';

  @override
  String get protection_guideBlockTitle => 'Blokovat připojení bez VPN';

  @override
  String get protection_guideBlock =>
      'Toto nastavení brání provozu obejít VPN, včetně doby, kdy je připojení přerušeno.';

  @override
  String get protection_guideWarning =>
      'Při zapnutém blokování zůstane přístup k internetu vypnutý, dokud se VPN nepřipojí.';

  @override
  String get protection_guideStepsTitle => 'Zapnout ochranu';

  @override
  String get protection_guideStep1 =>
      'Pomocí tlačítka níže otevřete nastavení VPN v Androidu.';

  @override
  String get protection_guideStep2 =>
      'Otevřete možnosti pomocí ikony ozubeného kola vedle FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Zapněte VPN stále zapnutou a poté Blokovat připojení bez VPN, pokud jsou tyto možnosti k dispozici.';

  @override
  String get protection_guideManufacturers =>
      'Názvy se liší podle telefonu. V případě potřeby vyhledejte v Nastavení položku VPN, často v části Síť a internet.';

  @override
  String get protection_guideDisableTitle => 'Vypnout tuto ochranu';

  @override
  String get protection_guideDisable =>
      'Ve stejném nastavení vypněte blokování bez VPN, aby byl povolen přístup k internetu bez VPN. Pokud už nechcete, aby ji Android znovu spouštěl, vypněte také VPN stále zapnutou.';

  @override
  String get protection_guideManual =>
      'Tato nastavení vybíráte v Androidu. FuzeVPN je za vás nemění.';

  @override
  String get locations_changeTitle => 'Změnit lokalitu?';

  @override
  String locations_changeActive(String name) {
    return 'VPN se odpojí a poté se pokusí připojit k $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN se pokusí připojit k $name.';
  }

  @override
  String get locations_confirmChange => 'Změnit a připojit';

  @override
  String get locations_changeBusy =>
      'Probíhá změna. Před výběrem jiné lokality počkejte.';

  @override
  String get locations_automaticSelection => 'Automatický výběr';

  @override
  String get locations_cities => 'Města';

  @override
  String get locations_servers => 'Servery';

  @override
  String locations_viewCities(String name) {
    return 'Zobrazit města v zemi $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Zobrazit servery v zemi $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zemí',
      few: '$count země',
      one: '$count země',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count měst',
      few: '$count města',
      one: '$count město',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serverů',
      few: '$count servery',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Všechny země';

  @override
  String get locations_backToCountries => 'Zpět na země';

  @override
  String locations_backToCities(String name) {
    return 'Zpět na města v zemi $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Vybrat $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Vybrat $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Není k dispozici žádný kompatibilní server.';

  @override
  String get externalLink_failed =>
      'Tento odkaz se nepodařilo otevřít. Můžete ho zkopírovat a otevřít v prohlížeči.';

  @override
  String get externalLink_copy => 'Kopírovat odkaz';

  @override
  String get externalLink_copied => 'Odkaz zkopírován';

  @override
  String get externalLink_copyFailed =>
      'Odkaz se nepodařilo zkopírovat. Vyberte adresu níže.';

  @override
  String get settings_deleteAccount => 'Smazat můj účet';

  @override
  String get settings_deleteAccountDetail =>
      'Zobrazit postup žádosti o smazání účtu';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Vyberte si předplatné VPN.';

  @override
  String get billing_subscribe => 'Předplatit';

  @override
  String get billing_choosePlan => 'Pokračujte výběrem tarifu.';

  @override
  String get billing_monthly => 'Měsíční';

  @override
  String get billing_yearly => 'Roční';

  @override
  String get billing_continue => 'Pokračovat přes Google Play';

  @override
  String get billing_restore => 'Obnovit nákupy';

  @override
  String get billing_manage => 'Spravovat předplatné';

  @override
  String get billing_deleteAccountWarning =>
      'Pokud máte předplatné přes Google Play, smazání účtu FuzeVPN nezruší jeho obnovování. Obnovování spravujte nebo zrušte samostatně v Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Pokračovat k žádosti o smazání účtu';

  @override
  String get billing_refresh => 'Aktualizovat přístup';

  @override
  String get billing_loadingPlans => 'Načítání tarifů…';

  @override
  String get billing_unavailable =>
      'Momentálně nejsou dostupné žádné tarify. Zkuste to později.';

  @override
  String get billing_comingSoon => 'Předplatné bude brzy dostupné.';

  @override
  String get billing_priceDisclosure =>
      'Cena poskytovaná službou Google Play. Konečná částka a příslušné daně se zobrazí před vaším potvrzením.';

  @override
  String get billing_renewalMonthly =>
      'Automatické obnovení každý měsíc, pokud předplatné nezrušíte. Zrušit jej můžete kdykoli v předplatných Google Play.';

  @override
  String get billing_renewalYearly =>
      'Automatické obnovení každý rok, pokud předplatné nezrušíte. Zrušit jej můžete kdykoli v předplatných Google Play.';

  @override
  String get billing_active => 'Váš přístup Premium je aktivní';

  @override
  String billing_accessUntil(String date) {
    return 'Přístup do $date.';
  }

  @override
  String get billing_webManaged =>
      'Vaše předplatné se spravuje na webu FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Vaše předplatné se spravuje přes Google Play.';

  @override
  String get billing_inactive => 'Žádné aktivní předplatné.';

  @override
  String get billing_checkingAccess => 'Ověřování přístupu…';

  @override
  String get billing_restoring => 'Obnovování nákupů…';

  @override
  String get billing_pending =>
      'Platba čeká na vyřízení. Přístup bude aktivován po potvrzení.';

  @override
  String get billing_cancelled =>
      'Nákup zrušen. Nebylo aktivováno nové předplatné.';

  @override
  String get billing_verifying => 'Ověřování nákupu…';

  @override
  String get billing_success =>
      'Předplatné aktivováno. Váš přístup Premium je připraven.';

  @override
  String get billing_restored => 'Vaše nákupy byly obnoveny.';

  @override
  String get billing_restoreEmpty =>
      'Pro tento účet Google Play nejsou žádné nákupy k obnovení.';

  @override
  String get billing_catalogError => 'Tarify nelze načíst. Zkuste to znovu.';

  @override
  String get billing_purchaseError => 'Nákup nelze zahájit. Zkuste to znovu.';

  @override
  String get billing_verificationError =>
      'Ověření nákupu je dočasně nedostupné. Obnovte nákupy a zkuste to znovu.';

  @override
  String get billing_restoreError => 'Nákupy nelze obnovit. Zkuste to znovu.';

  @override
  String get billing_managementError =>
      'Správu předplatného nelze otevřít. Zkuste to znovu.';

  @override
  String get billing_storeUnavailable =>
      'Google Play není na tomto zařízení dostupný.';

  @override
  String get welcome_title => 'Vaše VPN, jednoduše.';

  @override
  String get welcome_description =>
      'Chraňte své připojení. Mějte své soukromí pod kontrolou.';

  @override
  String get welcome_start => 'Začít';

  @override
  String get welcome_alreadyPurchased => 'Už jste zakoupili?';

  @override
  String get welcome_noAccountRequired => 'Pro začátek nemusíte vytvářet účet.';

  @override
  String get guest_accountTitle => 'Účet není propojen';

  @override
  String get guest_accountDescription =>
      'Obnovte nákupy pomocí stejného účtu Google Play, abyste mohli předplatné používat na jiném zařízení.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Už máte předplatné? Přihlásit se';

  @override
  String get guest_claimTitle => 'FuzeVPN všude s vámi';

  @override
  String get guest_claimDescription =>
      'Vytvořte účet pro přístup k předplatnému na dalších zařízeních. Tento krok je volitelný.';

  @override
  String get guest_skip => 'Později';

  @override
  String get guest_activationTitle => 'Fuze Premium je aktivní';

  @override
  String get guest_activationDescription =>
      'Vaše předplatné je připraveno. Používejte VPN a účet si vytvořte, kdykoli budete chtít.';

  @override
  String get guest_useVpn => 'Použít mou VPN';

  @override
  String get guest_loginRequired =>
      'Tento nákup je již propojen s účtem FuzeVPN. Přihlaste se k tomuto účtu a využijte své předplatné.';

  @override
  String get guest_signOutWarning =>
      'Předplatné můžete obnovit obnovením nákupů pomocí stejného účtu Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Váš účet je již propojen. Přihlaste se a zobrazte nebo spravujte své údaje.';

  @override
  String get billing_acceptance =>
      'Pokračováním přijímáte Podmínky používání a Zásady ochrany osobních údajů.';

  @override
  String get guest_verifyEmailReminder =>
      'Potvrďte e-mailovou adresu a zabezpečte svůj účet. VPN můžete používat i nadále.';

  @override
  String get guest_serviceUnavailable =>
      'Služba je dočasně nedostupná. Zkuste to znovu za chvíli.';

  @override
  String get guest_restoreError =>
      'Nákupy se nepodařilo obnovit. Zkuste to znovu s účtem Google Play použitým při nákupu.';

  @override
  String get guest_claimSuccess =>
      'Váš účet byl vytvořen. Předplatné a přístup k VPN zůstávají zachovány.';

  @override
  String get guest_emailExists =>
      'Tato e-mailová adresa se již používá. Vyberte jinou nebo se přihlaste ke stávajícímu účtu. Nákup zůstává dostupný přes Google Play.';

  @override
  String get guest_claimError =>
      'Účet se nepodařilo vytvořit. VPN můžete používat i nadále a zkusit to znovu později.';

  @override
  String get guest_secureStorageError =>
      'Relaci se nepodařilo bezpečně uložit v tomto zařízení. Zkuste to znovu.';

  @override
  String get guest_premiumRequired => 'Vyberte předplatné a aktivujte VPN.';

  @override
  String get welcome_viewPlans => 'Zobrazit plány';

  @override
  String get google_continue => 'Pokračovat přes Google';

  @override
  String get google_or => 'nebo';

  @override
  String get google_title => 'Váš účet FuzeVPN';

  @override
  String get google_settingUp => 'Dokončete svůj účet';

  @override
  String get google_country => 'Země bydliště';

  @override
  String get google_profileDescription =>
      'Vyberte zemi a přečtěte si oba dokumenty pro vytvoření účtu FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Propojte účet hosta s Googlem. Předplatné i zařízení zůstanou přiřazené k tomuto účtu.';

  @override
  String get google_linkTitle => 'Propojit Google s FuzeVPN';

  @override
  String get google_linkDescription =>
      'Potvrďte přístup ke svému existujícímu účtu FuzeVPN. Heslo Google není požadováno.';

  @override
  String get google_password => 'Heslo FuzeVPN';

  @override
  String get google_linkAccount => 'Potvrdit propojení';

  @override
  String get google_requestEmail => 'Poslat potvrzovací e-mail';

  @override
  String get google_emailInstructions =>
      'Otevřete e-mail od FuzeVPN a zadejte potvrzovací kód.';

  @override
  String get google_emailCode => 'Potvrzovací kód z e-mailu';

  @override
  String get google_confirmEmail => 'Potvrdit kód';

  @override
  String get google_restart => 'Vybrat jiný účet Google';

  @override
  String get google_resume => 'Ověřit tento pokus';

  @override
  String get google_unavailable =>
      'Přihlášení Google není dostupné. Můžete použít e-mail a heslo.';

  @override
  String get google_expired =>
      'Platnost tohoto pokusu vypršela. Zrušte jej a začněte znovu.';

  @override
  String get google_conflict =>
      'Tento účet Google je již propojen s jiným účtem. Současný účet a předplatné zůstávají zachovány.';

  @override
  String get google_error =>
      'Přihlášení Google se nezdařilo. Zkuste to znovu; současný přístup zůstává zachován.';

  @override
  String get google_uncertain =>
      'Výsledek nelze potvrdit. Ověřte tento pokus nebo jej zrušte před novým začátkem.';

  @override
  String get google_cancelFailed =>
      'Zrušení nelze potvrdit. Před opuštěním obrazovky zkuste znovu zrušit.';

  @override
  String get google_cancelled => 'Přihlášení Google zrušeno.';

  @override
  String get google_selecting => 'Vyberte účet Google…';

  @override
  String get google_verifying => 'Ověřování účtu…';

  @override
  String get google_emailUnavailable =>
      'Potvrzovací e-mail nelze odeslat. Zkuste to později.';

  @override
  String get google_emailSent =>
      'Potvrzovací e-mail odeslán. Zkontrolujte doručenou poštu.';

  @override
  String get google_rateLimited => 'Před dalším pokusem vyčkejte.';

  @override
  String get google_invalidPassword =>
      'Heslo FuzeVPN je nesprávné. Současný účet zůstává zachován.';

  @override
  String get google_invalidCode => 'Potvrzovací kód je neplatný nebo vypršel.';

  @override
  String get google_accountChanged =>
      'Relace se změnila. Zrušte tento pokus před novým začátkem.';

  @override
  String get google_invalidResponse =>
      'Odpověď nelze ověřit. Současný přístup zůstává zachován.';

  @override
  String get google_invalidRegistration => 'Zkontrolujte zemi a oba souhlasy.';

  @override
  String get google_consentRequired =>
      'Vyberte zemi a přijměte oba dokumenty pro pokračování.';

  @override
  String get google_challengeRequired =>
      'Je nutná další bezpečnostní kontrola. Současný přístup zůstává zachován.';

  @override
  String get google_challengeUnavailable =>
      'Bezpečnostní kontrola není dostupná. Zkuste to později.';

  @override
  String get billing_trialTitle => 'Vyzkoušejte Fuze Premium zdarma';

  @override
  String get billing_trialSubtitle => 'Chraňte své připojení už dnes.';

  @override
  String get billing_trialWeeks => '2 týdny zkušební doby zdarma';

  @override
  String billing_trialDays(String days) {
    return '$days dní zkušební doby zdarma';
  }

  @override
  String get billing_trialStart => 'Začít zkušební dobu zdarma';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Pokud začnete dnes, první platba se očekává dne $date.';
  }

  @override
  String get billing_trialTerms =>
      'Automaticky se obnovuje za uvedenou cenu. Aby nedošlo k platbě, zrušte předplatné v Google Play před koncem zkušební doby.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Poté $price měsíčně';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Poté $price ročně';
  }

  @override
  String get billing_choosePeriod => 'Vyberte si tarif';

  @override
  String get billing_selectionHint => 'Pro pokračování vyberte tarif.';

  @override
  String get billing_benefitConnection => 'Šifrované připojení';

  @override
  String get billing_benefitPrivacy => 'Soukromí na internetu';

  @override
  String get billing_benefitNoAccount => 'Registrace není povinná';

  @override
  String get billing_cancellation => 'Zrušení v Google Play';

  @override
  String get billing_premiumTitle => 'Vaše připojení, lépe chráněné.';

  @override
  String get billing_premiumSubtitle => 'Chraňte připojení podle svých potřeb.';

  @override
  String get billing_priceMonthly => 'měsíčně';

  @override
  String get billing_priceYearly => 'ročně';

  @override
  String get billing_trialToday => 'Dnes nic neplatíte';

  @override
  String get billing_trialConfirmation =>
      'Google Play před vaším potvrzením potvrdí data, konečnou částku a příslušné daně.';

  @override
  String get billing_offerChanged =>
      'Podmínky této nabídky se změnily. Obnovte tarify a vyberte znovu.';

  @override
  String get status_waitingNetwork => 'Čekání na síť';

  @override
  String get status_waitingNetworkDetail =>
      'Žádná síť není dostupná. VPN ověří připojení po obnovení sítě.';

  @override
  String get locations_favoriteLoadFailed =>
      'Oblíbené se nepodařilo načíst. Zkuste to znovu.';

  @override
  String get locations_favoritesLoading => 'Načítání oblíbených…';
}
