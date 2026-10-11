// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Skydda din anslutning';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN använder Androids VPN-tjänst (VpnService) för att skapa en krypterad tunnel mellan den här enheten och FuzeVPNs servrar.';

  @override
  String get vpnDisclosure_dataBody =>
      'När VPN är aktivt går dina appars internettrafik, destinationsadresser och DNS-förfrågningar genom tunneln för att routa din anslutning, även när FuzeVPN körs i bakgrunden.';

  @override
  String get vpnDisclosure_statusBody =>
      'Appen använder anslutningens status, varaktighet och mängden överförda data för att visa din VPN-anslutning. Du kan stoppa den när som helst.';

  @override
  String get vpnDisclosure_privacy => 'Integritet';

  @override
  String get vpnDisclosure_accept => 'Godkänn och fortsätt';

  @override
  String get vpnDisclosure_decline => 'Inte nu';

  @override
  String get accountRestoration_title => 'Kontot är tillfälligt otillgängligt';

  @override
  String get accountRestoration_message =>
      'Din session har sparats. Försök igen för att återställa kontot; du kan fortfarande hantera VPN-anslutningen här.';

  @override
  String get action_retry => 'Försök igen';

  @override
  String get session_endingTitle => 'Sessionen avslutas';

  @override
  String get session_ending =>
      'Din session har ogiltigförklarats. VPN stängs av och sessionen rensas…';

  @override
  String get session_stopFailed =>
      'VPN-avstängningen har inte bekräftats. Försök igen innan du loggar in på nytt.';

  @override
  String get session_cleanupFailed =>
      'VPN är avstängt, men borttagningen av sessionen har inte bekräftats. Försök rensa igen.';

  @override
  String get session_retryStop => 'Försök stänga av igen';

  @override
  String get session_retryCleanup => 'Försök rensa igen';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Förbereder FuzeVPN säkert…';

  @override
  String get nav_connection => 'Anslutning';

  @override
  String get nav_locations => 'Platser';

  @override
  String get nav_account => 'Konto';

  @override
  String get nav_devices => 'Enheter';

  @override
  String get nav_settings => 'Inställningar';

  @override
  String get action_refresh => 'Uppdatera';

  @override
  String get auth_tab_login => 'Logga in';

  @override
  String get auth_tab_register => 'Registrera dig';

  @override
  String get auth_stepAccount => 'Konto';

  @override
  String get auth_stepIdentity => 'Identitet';

  @override
  String get auth_stepAddress => 'Adress och avtal';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Steg $current av $total';
  }

  @override
  String get auth_tagline => 'Ditt VPN, enkelt gjort.';

  @override
  String get auth_keysLocal =>
      'Dina privata VPN-nycklar stannar på den här enheten.';

  @override
  String get form_email => 'E-postadress';

  @override
  String get form_password => 'Lösenord';

  @override
  String get form_showPassword => 'Visa lösenord';

  @override
  String get form_hidePassword => 'Dölj lösenord';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8-byte. Vissa tecken använder mer än en byte.';

  @override
  String get form_firstName => 'Förnamn';

  @override
  String get form_lastName => 'Efternamn';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adress';

  @override
  String get form_address2 => 'Adressrad 2 (valfritt)';

  @override
  String get form_postalCode => 'Postnummer';

  @override
  String get form_city => 'Ort';

  @override
  String get form_country => 'Landskod (t.ex. FR)';

  @override
  String get action_login => 'Logga in';

  @override
  String get action_createAccount => 'Skapa ett konto';

  @override
  String get action_createMyAccount => 'Skapa mitt konto';

  @override
  String get action_next => 'Fortsätt';

  @override
  String get action_previous => 'Tillbaka';

  @override
  String get action_forgotPassword => 'Glömt lösenordet?';

  @override
  String get auth_noAccount => 'Har du inget konto än?';

  @override
  String get auth_requiredInformation => 'Skapa ditt konto i tre steg.';

  @override
  String get auth_termsPrefix => 'Jag godkänner ';

  @override
  String get auth_termsLink => 'användarvillkoren';

  @override
  String get auth_privacyPrefix => 'Jag godkänner ';

  @override
  String get auth_privacyLink => 'integritetspolicyn';

  @override
  String get auth_consentRequired =>
      'Ditt samtycke krävs för att skapa ett konto.';

  @override
  String get validation_required => 'Det här fältet är obligatoriskt.';

  @override
  String get validation_email => 'Ange en giltig e-postadress.';

  @override
  String get validation_password =>
      'Lösenordet är för kort: minst 8 UTF-8-byte.';

  @override
  String get validation_passwordTooLong =>
      'Lösenordet är för långt: högst 72 UTF-8-byte.';

  @override
  String get validation_phone =>
      'Använd internationellt format, till exempel +33612345678.';

  @override
  String get validation_country =>
      'Använd en landskod med två bokstäver, till exempel FR.';

  @override
  String get passwordReset_title => 'Återställ lösenord';

  @override
  String get passwordReset_description =>
      'Ange e-postadressen till ditt konto för att begära en länk för återställning av lösenordet.';

  @override
  String get passwordReset_send => 'Skicka länk';

  @override
  String get connection_title => 'Din anslutning';

  @override
  String get connection_subtitle => 'Välj en plats och slå sedan på VPN.';

  @override
  String get connection_prepare => 'Redo att ansluta?';

  @override
  String get connection_advancedOptions => 'Avancerade alternativ';

  @override
  String get connection_location => 'Plats';

  @override
  String get connection_chooseLocation => 'Välj en plats';

  @override
  String get connection_protocol => 'Protokoll';

  @override
  String get connection_connect => 'Anslut';

  @override
  String get connection_connecting => 'Ansluter…';

  @override
  String get connection_disconnect => 'Koppla från';

  @override
  String get connection_disconnecting => 'Kopplar från';

  @override
  String get connection_locationChange => 'Byter plats…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol är inte tillgängligt';
  }

  @override
  String get connection_activeLocation => 'Aktiv plats';

  @override
  String get connection_duration => 'Varaktighet';

  @override
  String get connection_received => 'Mottaget';

  @override
  String get connection_sent => 'Skickat';

  @override
  String get connection_lastHandshake => 'Senaste säkra handskakning';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'för $duration sedan';
  }

  @override
  String get verification_title => 'Bekräfta din e-postadress';

  @override
  String get verification_message =>
      'Bekräfta din e-postadress för att använda VPN på den här telefonen.';

  @override
  String get verification_resend => 'Skicka e-post igen';

  @override
  String get migration_title => 'Platsbyte';

  @override
  String get migration_draining => 'Förbereder platsbytet…';

  @override
  String get migration_activating => 'Aktiverar den nya servern…';

  @override
  String get migration_ready => 'Platsen har uppdaterats.';

  @override
  String get migration_blocked =>
      'Platsbytet kräver en åtgärd på servern. Försök igen senare eller kontakta supporten.';

  @override
  String get migration_progress => 'Förlopp för platsbyte';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Fördröjning mellan kontroller: $seconds sek.';
  }

  @override
  String get migration_resume => 'Fortsätt platsbytet';

  @override
  String get status_authorizing => 'Behörighet krävs';

  @override
  String get status_authorizingDetail =>
      'Godkänn Android-begäran för att tillåta VPN.';

  @override
  String get status_preparing => 'Förbereder';

  @override
  String get status_preparingDetail => 'Förbereder din säkra anslutning.';

  @override
  String get status_reconnecting => 'Ansluter igen…';

  @override
  String get status_reconnectingDetail =>
      'Anslutningen avbröts. VPN försöker ansluta igen.';

  @override
  String get status_connecting => 'Ansluter';

  @override
  String get status_connectingDetail => 'Ansluter till VPN-servern…';

  @override
  String get status_connected => 'Ansluten';

  @override
  String get status_connectedDetail => 'Din VPN-anslutning är aktiv.';

  @override
  String get status_disconnecting => 'Kopplar från';

  @override
  String get status_disconnectingDetail => 'Din VPN-anslutning stängs av.';

  @override
  String get status_error => 'Anslutningen är inte tillgänglig';

  @override
  String get status_errorDetail =>
      'VPN-anslutningen har inte bekräftats. Försök igen.';

  @override
  String get status_idle => 'Frånkopplad';

  @override
  String get status_idleDetail => 'Anslut VPN för att skydda din anslutning.';

  @override
  String get trust_note =>
      'Att stänga appen stänger inte av VPN. Använd Koppla från för att stänga av det.';

  @override
  String get locations_none => 'Inga platser är tillgängliga just nu.';

  @override
  String get locations_available => 'Välj din nästa plats.';

  @override
  String get locations_selected => 'Vald plats';

  @override
  String get locations_select => 'Välj den här platsen';

  @override
  String get locations_lockedTunnel => 'Koppla från VPN för att byta plats.';

  @override
  String get locations_lockedMigration => 'Vänta tills platsbytet är klart.';

  @override
  String get devices_title => 'Dina enheter';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit enheter';
  }

  @override
  String get devices_refresh => 'Uppdatera enheter';

  @override
  String get devices_empty => 'Ingen VPN-enhet är registrerad ännu.';

  @override
  String get devices_firstConnection =>
      'Din telefon läggs till vid den första anslutningen.';

  @override
  String get devices_thisDevice => 'Den här enheten';

  @override
  String devices_added(Object date) {
    return 'Tillagd $date';
  }

  @override
  String get action_remove => 'Ta bort';

  @override
  String get settings_title => 'Inställningar';

  @override
  String get settings_subtitle =>
      'Dina inställningar och ditt konto på ett och samma ställe.';

  @override
  String get settings_appearance => 'Utseende';

  @override
  String get settings_language => 'Språk';

  @override
  String get settings_languageDescription =>
      'Det språk du väljer används även i VPN-aviseringar.';

  @override
  String get settings_account => 'Konto';

  @override
  String get settings_signOut => 'Logga ut';

  @override
  String get settings_privacy => 'Integritetspolicy';

  @override
  String get settings_terms => 'Användarvillkor';

  @override
  String get settings_security => 'Säkerhet och transparens';

  @override
  String get settings_licenses => 'Komponentlicenser';

  @override
  String get settings_licensesDetail => 'Programvara som används i appen';

  @override
  String get settings_background =>
      'VPN förblir aktivt när du lämnar appen. Använd Koppla från på fliken Anslutning för att stänga av det.';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Ljust';

  @override
  String get theme_dark => 'Mörkt';

  @override
  String get language_system => 'Telefonens språk';

  @override
  String get language_fr => 'Franska';

  @override
  String get language_en => 'Engelska';

  @override
  String get language_es => 'Spanska';

  @override
  String get language_de => 'Tyska';

  @override
  String get dialog_removeDevice => 'Ta bort den här enheten?';

  @override
  String get dialog_removeCurrent =>
      'Den här telefonen kopplas från VPN och förlorar åtkomsten. Telefonens VPN-anslutningsdata tas bort när servern har bekräftat det.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN-åtkomsten för ”$name” återkallas. Det går inte att ångra.';
  }

  @override
  String get dialog_signOut => 'Logga ut?';

  @override
  String get dialog_signOutMessage =>
      'VPN stängs av och du måste logga in igen. Dina krypterade VPN-nycklar stannar på den här telefonen inför nästa anslutning.';

  @override
  String get action_cancel => 'Avbryt';

  @override
  String get action_signOut => 'Logga ut';

  @override
  String get notice_close => 'Stäng meddelandet';

  @override
  String get notice_sessionExpired_title => 'Sessionen har löpt ut';

  @override
  String get notice_sessionExpired_message =>
      'Din session har löpt ut. Logga in igen.';

  @override
  String get notice_connectionFailed_title => 'Anslutningen misslyckades';

  @override
  String get notice_invalidCredentials_message =>
      'E-postadressen eller lösenordet är felaktigt.';

  @override
  String get notice_emailVerification_title => 'E-postbekräftelse krävs';

  @override
  String get notice_emailVerification_message =>
      'Bekräfta din e-postadress innan du lägger till en VPN-enhet.';

  @override
  String get notice_rateLimited_title => 'För många försök';

  @override
  String get notice_deviceLimit_title => 'Gränsen på två enheter har nåtts';

  @override
  String get notice_deviceLimit_message =>
      'Ta bort en befintlig enhet innan du lägger till en till.';

  @override
  String get notice_identityRenewal_title => 'VPN-identiteten måste förnyas';

  @override
  String get notice_identityRenewal_message =>
      'Den här identiteten har tagits bort. Skapa en ny lokal identitet.';

  @override
  String get notice_migrationPending_title => 'Platsbyte pågår';

  @override
  String get notice_migrationPending_message => 'Ett platsbyte pågår redan.';

  @override
  String get notice_migrationBlocked_title => 'Platsbytet har blockerats';

  @override
  String get notice_migrationBlocked_message =>
      'Platsbytet kräver en åtgärd på servern. Försök igen senare eller kontakta supporten.';

  @override
  String get notice_targetUnavailable_title =>
      'Servern är tillfälligt otillgänglig';

  @override
  String get notice_targetUnavailable_message =>
      'Den här servern är tillfälligt otillgänglig.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetanslutningen är inte tillgänglig';

  @override
  String get notice_networkUnavailable_message =>
      'Kontrollera anslutningen och försök igen.';

  @override
  String get notice_permissionDenied_title => 'VPN-behörighet nekades';

  @override
  String get notice_permissionDenied_message =>
      'Starta anslutningen igen och godkänn Androids behörighetsbegäran.';

  @override
  String get notice_wireguardTimeout_title => 'Servern svarar inte';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard-anslutningen tog för lång tid. Försök igen eller välj en annan plats.';

  @override
  String get notice_tlsFailed_title => 'Den säkra anslutningen nekades';

  @override
  String get notice_tlsFailed_message =>
      'Servern accepterade inte OpenVPN-anslutningen. Försök igen. Om problemet fortsätter, kör en diagnostik.';

  @override
  String get notice_tunRejected_title => 'Android nekade VPN-gränssnittet';

  @override
  String get notice_tunRejected_message =>
      'Android nekade nätverkskonfigurationen som begärdes av OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN kunde inte starta';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN-motorn kunde inte slutföra starten. Försök igen. Om problemet kvarstår, kontakta supporten.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostikkod: $code';
  }

  @override
  String get notice_generic_title => 'VPN-anslutningen misslyckades';

  @override
  String get notice_generic_message =>
      'Ett fel inträffade. Försök igen senare.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Kontot har skapats',
      'password_reset_sent':
          'Begäran om lösenordsåterställning har tagits emot',
      'verification_email_sent': 'Verifieringsmeddelandet har skickats',
      'location_migration_pending': 'Platsbyte pågår',
      'vpn_sign_in_required': 'Inloggning krävs',
      'protocol_unavailable_at_location': 'Protokollet är inte tillgängligt',
      'vpn_permission_denied': 'VPN-behörighet nekades',
      'revoked_identity_device_limit': 'Gränsen på två enheter har nåtts',
      'tunnel_start_unexpected': 'VPN kunde inte starta',
      'flutter_disconnect_timeout': 'Frånkopplingen har inte bekräftats',
      'flutter_disconnect_unexpected': 'Det gick inte att koppla från',
      'device_revoked': 'Enheten har tagits bort',
      'revoke_unexpected': 'Det gick inte att ta bort enheten',
      'identity_renewal_unexpected': 'Det gick inte att förnya identiteten',
      'openvpn_renewal_unexpected': 'Det gick inte att förnya OpenVPN',
      'location_migration_blocked': 'Platsbytet har blockerats',
      'location_migration_slow': 'Platsbytet pågår fortfarande',
      'location_migration_conflict': 'Platsbytet behöver uppdateras',
      'location_migration_verification_failed':
          'Platsbytet har inte bekräftats',
      'location_migration_device_changed': 'Enheten ändrades under platsbytet',
      'tunnel_stop_failed': 'Platsbyte är inte tillgängligt',
      'other': 'Åtgärden misslyckades',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Kontot skapades, men verifieringsmeddelandet kunde inte skickas. Använd Skicka igen i appen.',
      'password_reset_sent':
          'Din begäran har tagits emot. Om ett konto matchar den här adressen kan du få ett e-postmeddelande. Kontrollera även skräppostmappen.',
      'verification_email_sent':
          'Ett nytt verifieringsmeddelande har precis skickats.',
      'location_migration_pending':
          'Flytten till $target förbereds fortfarande. Du kan fortsätta den utan att skapa om enheten.',
      'vpn_sign_in_required': 'Logga in på ditt konto innan du startar VPN.',
      'protocol_unavailable_at_location':
          'Det valda protokollet erbjuds inte på den här platsen. Uppdatera platserna eller välj ett annat protokoll.',
      'vpn_permission_denied':
          'Android nekade VPN-behörigheten. Starta anslutningen igen och godkänn systembegäran.',
      'revoked_identity_device_limit':
          'Den här enhetens VPN-åtkomst togs bort och enhetsgränsen har nåtts. Ta bort en enhet under Konto → Hantera mina enheter.',
      'tunnel_start_unexpected':
          'Ett oväntat fel avbröt förberedelsen av tunneln. Kontrollera diagnostikkoden och försök igen.',
      'flutter_disconnect_timeout':
          'Android bekräftade inte i tid att VPN stängdes av. Försök stänga av det igen.',
      'flutter_disconnect_unexpected':
          'Ett oväntat fel hindrade bekräftelsen av att tunneln stängdes av.',
      'device_revoked':
          'Enhetens VPN-åtkomst återkallades och dess lokala hemligheter togs bort.',
      'revoke_unexpected':
          'Enheten kunde inte tas bort. Uppdatera listan och försök igen.',
      'identity_renewal_unexpected':
          'Den nya VPN-identiteten kunde inte skapas. Uppdatera enheterna och försök igen.',
      'openvpn_renewal_unexpected':
          'OpenVPN-profilen kunde inte förnyas. Försök igen eller kontrollera diagnostikkoden.',
      'location_migration_blocked':
          'Servern kan inte slutföra det här bytet just nu. Enheten och dess lokala identitet har behållits.',
      'location_migration_slow':
          'Servern förbereder fortfarande flytten till $target. Använd Fortsätt om en liten stund.',
      'location_migration_conflict':
          'Enhetens status ändrades på servern. Uppdatera enheterna och fortsätt sedan bytet.',
      'location_migration_verification_failed':
          'Servern bekräftade inte den nya platsen. Den tidigare lokala identiteten har behållits.',
      'location_migration_device_changed':
          'Enheten som servern returnerade stämmer inte längre överens med den som ändras. Uppdatera enheterna innan du försöker igen.',
      'tunnel_stop_failed':
          'Den tidigare tunneln måste vara helt avstängd innan den nya anslutningen kan startas.',
      'other':
          'Åtgärden kunde inte slutföras. Försök igen eller skicka diagnostikkoden till supporten.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessionen har löpt ut',
      'invalid_credentials': 'Inloggningen misslyckades',
      'email_verification_required': 'E-postbekräftelse krävs',
      'verification_email_cooldown': 'E-postmeddelandet har redan skickats',
      'rate_limited': 'För många försök',
      'invalid_registration': 'Informationen måste korrigeras',
      'email_exists': 'Kontot finns redan',
      'invalid_profile': 'Ogiltig profil',
      'invalid_device': 'Ogiltig enhet',
      'invalid_location': 'Platsen är inte tillgänglig',
      'device_limit': 'Enhetsgränsen har nåtts',
      'device_exists': 'VPN-identiteten används redan',
      'device_identity_revoked': 'VPN-identiteten måste förnyas',
      'device_location_locked': 'Platsbytet behöver uppdateras',
      'location_migration_pending': 'Platsbyte pågår',
      'location_migration_blocked': 'Platsbytet har blockerats',
      'target_ca_mismatch': 'OpenVPN-servern är inkompatibel',
      'location_migration_conflict': 'Platsbytet behöver uppdateras',
      'server_full': 'Servern är full',
      'capacity_unavailable': 'Platsen är tillfälligt otillgänglig',
      'target_unavailable': 'Servern är tillfälligt otillgänglig',
      'not_found': 'Objektet hittades inte',
      'invalid_openvpn_csr': 'Ogiltig OpenVPN-identitet',
      'openvpn_profile_exists': 'OpenVPN-profilen finns redan',
      'openvpn_profile_revoked': 'OpenVPN-profilen har återkallats',
      'openvpn_operation_pending': 'OpenVPN-åtgärd pågår',
      'openvpn_operation_terminal': 'OpenVPN-åtgärden avbröts',
      'openvpn_address_unavailable': 'OpenVPN-adressen är inte tillgänglig',
      'openvpn_profile_conflict': 'OpenVPN-konflikt',
      'openvpn_signer_unavailable': 'OpenVPN är inte tillgängligt',
      'email_delivery_unavailable': 'E-post är inte tillgänglig',
      'invalid_token': 'Ogiltig länk',
      'network_unavailable': 'Internetanslutningen är inte tillgänglig',
      'invalid_json': 'Ogiltig begäran',
      'invalid_api_response': 'Ogiltigt serversvar',
      'ipv6_unavailable': 'IPv6 är inte tillgängligt',
      'invalid_ip_families': 'Nätverkskonfigurationen nekades',
      'other': 'Tjänsten är inte tillgänglig',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Din session har löpt ut. Logga in igen.',
      'invalid_credentials': 'E-postadressen eller lösenordet är felaktigt.',
      'email_verification_required':
          'Bekräfta din e-postadress innan du lägger till en VPN-enhet.',
      'invalid_registration':
          'Kontrollera den begärda informationen och samtyckena.',
      'email_exists': 'Ett konto använder redan den här e-postadressen.',
      'invalid_profile': 'Kontrollera profilinformationen.',
      'invalid_device': 'Enhetens namn eller lokala identitet är ogiltig.',
      'invalid_location': 'Uppdatera platslistan och försök igen.',
      'device_limit':
          'Ta bort en befintlig enhet innan du lägger till en till.',
      'device_exists':
          'Den här VPN-identiteten är redan kopplad till ett annat konto.',
      'device_identity_revoked':
          'Den här identiteten har tagits bort. En ny lokal identitet måste skapas.',
      'device_location_locked':
          'Den här enhetens plats ändrades precis. Appen fortsätter det pågående bytet.',
      'location_migration_pending': 'Ett platsbyte pågår redan.',
      'location_migration_blocked':
          'Platsbytet kräver en åtgärd på servern. Försök igen senare eller kontakta supporten.',
      'target_ca_mismatch':
          'Den här servern är ännu inte kompatibel med den aktuella OpenVPN-profilen.',
      'location_migration_conflict':
          'Uppdatera enheterna och försök sedan byta plats igen.',
      'server_full':
          'Den här platsen har nått sin anslutningsgräns. Välj en annan plats eller försök igen senare.',
      'capacity_unavailable':
          'Vi kan inte bekräfta om den här platsen är tillgänglig just nu. Välj en annan plats eller försök igen senare.',
      'target_unavailable': 'Den här servern är tillfälligt otillgänglig.',
      'not_found':
          'Det här objektet är inte längre tillgängligt på ditt konto.',
      'invalid_openvpn_csr': 'Skapa en ny OpenVPN-identitet och försök igen.',
      'openvpn_profile_exists':
          'Det finns redan en OpenVPN-profil för den här enheten.',
      'openvpn_profile_revoked': 'Förnya OpenVPN-profilen för att fortsätta.',
      'openvpn_operation_pending':
          'Ändringen håller fortfarande på att spridas. Försök igen senare.',
      'openvpn_operation_terminal':
          'Skapa en ny OpenVPN-identitet och försök igen.',
      'openvpn_address_unavailable':
          'Ingen OpenVPN-adress är tillgänglig just nu.',
      'openvpn_profile_conflict':
          'Profilen ändrades. Uppdatera enheterna och försök igen.',
      'openvpn_signer_unavailable':
          'OpenVPN-tjänsten är tillfälligt otillgänglig.',
      'email_delivery_unavailable':
          'E-postmeddelandet kunde inte skickas. Försök igen senare.',
      'invalid_token':
          'Den här länken är ogiltig eller har löpt ut. Begär en ny.',
      'network_unavailable':
          'Kontrollera internetanslutningen och försök igen.',
      'invalid_json': 'Kontrollera den angivna informationen och försök igen.',
      'invalid_api_response':
          'Servern returnerade ett oväntat svar. Försök igen senare.',
      'ipv6_unavailable':
          'Servern kan inte aktivera IPv6 just nu. Försök igen senare.',
      'invalid_ip_families':
          'Tunnelkonfigurationen är ofullständig eller stämmer inte med de godkända adresserna. Försök igen från appen.',
      'other': 'Ett serverfel inträffade. Försök igen senare.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Försök igen om en liten stund.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Försök igen om $seconds sekunder.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Det går inte att återuppta system-VPN',
      'system_vpn_resume_corrupt': 'Ogiltigt återupptagande av system-VPN',
      'system_vpn_resume_session_invalid':
          'Ogiltig session för återupptagande av VPN',
      'system_vpn_resume_identity_changed': 'VPN-identiteten ändrades',
      'system_vpn_resume_identity_invalid':
          'Ogiltig VPN-identitet för återupptagande',
      'system_vpn_resume_storage_failed':
          'Lagring för återupptagande av VPN är inte tillgänglig',
      'system_vpn_resume_network_timeout':
          'Återupptagandet av VPN saknar nätverk',
      'system_vpn_resume_blocked': 'Återupptagande av VPN blockerades',
      'system_vpn_resume_failed': 'Det gick inte att återuppta VPN',
      'system_vpn_resume_error_invalid':
          'Ogiltigt fel vid återupptagande av VPN',
      'wireguard_identity_store_failed': 'WireGuard-identiteten sparades inte',
      'wireguard_identity_unavailable':
          'WireGuard-identiteten är inte tillgänglig',
      'vpn_host_destroyed': 'Androids VPN-värd stoppades',
      'vpn_host_unavailable': 'Androids VPN-värd är inte tillgänglig',
      'vpn_permission_required': 'VPN-behörighet krävs',
      'vpn_permission_denied': 'VPN-behörighet nekades',
      'vpn_permission_request_failed': 'Det gick inte att begära behörighet',
      'wireguard_foreground_service_unavailable':
          'WireGuard-tjänsten är inte tillgänglig',
      'wireguard_identity_invalid': 'Ogiltig lokal WireGuard-nyckel',
      'wireguard_identity_in_use': 'WireGuard-identiteten används redan',
      'wireguard_configuration_invalid': 'Ogiltig WireGuard-konfiguration',
      'wireguard_operation_pending': 'WireGuard-åtgärden är fortfarande aktiv',
      'wireguard_start_failed': 'WireGuard-starten nekades',
      'wireguard_stop_timeout': 'WireGuard-avstängningen bekräftades inte',
      'wireguard_handshake_timeout': 'WireGuard svarade inte',
      'openvpn_connection_timeout': 'OpenVPN svarade inte',
      'openvpn_core_unavailable': 'OpenVPN-motorn är inte tillgänglig',
      'openvpn_operation_pending': 'OpenVPN-sessionen är fortfarande aktiv',
      'openvpn_stop_timeout': 'OpenVPN-avstängningen bekräftades inte',
      'openvpn_profile_unavailable': 'Lokal OpenVPN-profil saknas',
      'openvpn_native_failed': 'Det inbyggda OpenVPN-anropet avbröts',
      'openvpn_key_generation_failed':
          'Det gick inte att skapa OpenVPN P-256-nyckeln',
      'openvpn_csr_generation_failed': 'Det gick inte att skapa OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN-identiteten sparades inte',
      'openvpn_identity_clear_failed': 'Ofullständig borttagning av OpenVPN',
      'openvpn_identity_in_use': 'OpenVPN-identiteten används fortfarande',
      'openvpn_tls_verification_required': 'OpenVPN TLS-verifiering saknas',
      'openvpn_cipher_invalid': 'Ogiltigt OpenVPN-krypteringschiffer',
      'openvpn_profile_rejected': 'OpenVPN-profilen nekades',
      'openvpn_identity_inconsistent': 'OpenVPN-identiteten är inkonsekvent',
      'tls_handshake_failed': 'OpenVPN-förhandlingen nekades',
      'tls_alert_unknown_ca': 'OpenVPN-klientcertifikatet känns inte igen',
      'tls_alert_bad_certificate': 'OpenVPN-klientcertifikatet nekades',
      'tls_alert_unsupported_certificate': 'OpenVPN-certifikatet stöds inte',
      'tls_client_certificate_required': 'OpenVPN-klientcertifikat krävs',
      'tls_alert_misc': 'OpenVPN TLS-varning',
      'tls_signature_algorithm_rejected': 'OpenVPN-signaturen stöds inte',
      'tls_handshake_rejected': 'OpenVPN TLS-förhandlingen nekades',
      'tls_version_rejected': 'OpenVPN TLS-versionen är inkompatibel',
      'tls_certificate_expired': 'TLS-certifikatet har löpt ut',
      'tls_certificate_revoked': 'TLS-certifikatet har återkallats',
      'transport_failed': 'OpenVPN-servern kan inte nås',
      'tun_configuration_rejected':
          'Det gick inte att skapa OpenVPN-gränssnittet',
      'tun_setup_failed': 'OpenVPN TUN-konfigurationen misslyckades',
      'tun_interface_create_failed':
          'Det gick inte att skapa OpenVPN-gränssnittet',
      'tun_interface_disabled': 'OpenVPN-gränssnittet är inaktiverat',
      'tun_halted': 'OpenVPN-gränssnittet avbröts',
      'tun_already_established': 'OpenVPN-gränssnittet är redan öppet',
      'tun_addresses_missing': 'OpenVPN-adress saknas',
      'tun_routes_missing': 'OpenVPN-rutter saknas',
      'tun_dns_missing': 'OpenVPN-DNS saknas',
      'tun_permission_revoked': 'VPN-behörigheten återkallades',
      'tun_establish_returned_null': 'Android nekade VPN-gränssnittet',
      'openvpn_service_start_failed': 'OpenVPN-tjänsten är inte tillgänglig',
      'openvpn_operation_timeout': 'OpenVPN-anropet tog för lång tid',
      'openvpn_start_failed': 'OpenVPN-starten nekades',
      'openvpn_connection_failed': 'OpenVPN-anslutningen avbröts',
      'openvpn_core_status_error': 'OpenVPN Core avslutades med ett fel',
      'openvpn_stopped_before_connected':
          'OpenVPN stoppades innan anslutningen upprättades',
      'openvpn_auth_failed': 'OpenVPN-autentiseringen nekades',
      'openvpn_client_setup_failed':
          'OpenVPN-klientkonfigurationen misslyckades',
      'openvpn_client_halted': 'OpenVPN-klienten avbröts',
      'openvpn_client_restart': 'OpenVPN-omstart begärdes',
      'openvpn_inactive_timeout': 'OpenVPN var inaktivt för länge',
      'openvpn_session_expired': 'OpenVPN-sessionen har löpt ut',
      'openvpn_credentials_required': 'OpenVPN-autentiseringen stöds inte',
      'openvpn_proxy_failed': 'OpenVPN-mellantransporten misslyckades',
      'openvpn_compression_failed': 'OpenVPN-komprimeringen nekades',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM-kryptering är inte tillgänglig',
      'openvpn_feature_unsupported': 'OpenVPN-funktionen stöds inte',
      'network_unavailable': 'Internetanslutningen är inte tillgänglig',
      'network_lost': 'Nätverket är inte tillgängligt',
      'certificate_validation_failed': 'Servercertifikatet nekades',
      'openvpn_certificate_expired': 'OpenVPN-certifikatet har löpt ut',
      'tunnel_active_for_another_account':
          'Ett annat kontos tunnel är fortfarande aktiv',
      'tunnel_already_active': 'En inbyggd tunnel är redan aktiv',
      'tunnel_stop_timeout': '$protocol-avstängningen bekräftades inte',
      'tunnel_disconnected': '$protocol avbröts',
      'native_bridge_unavailable': 'Android-bryggan är inte tillgänglig',
      'native_operation_failed': 'Android-åtgärden avbröts',
      'invalid_arguments': 'Ofullständiga VPN-parametrar',
      'invalid_account_id': 'Ogiltigt VPN-konto',
      'invalid_device_id': 'Ogiltig enhetsidentifierare',
      'storage_key_not_allowed': 'Lagringsnyckeln nekades',
      'secure_storage_read_failed': 'Säker läsning misslyckades',
      'secure_storage_write_failed': 'Säker skrivning misslyckades',
      'key_generation_failed': 'Det gick inte att skapa WireGuard-nyckeln',
      'csr_generation_failed': 'Det gick inte att skapa OpenVPN CSR',
      'other': 'Okategoriserat inbyggt VPN-fel',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android hittar ingen VPN-session som kan återupptas. Starta en ny anslutning i appen.',
      'system_vpn_resume_corrupt':
          'De sparade VPN-data för återupptagande är ogiltiga och kommer inte att användas. Starta en ny anslutning.',
      'system_vpn_resume_session_invalid':
          'Den sparade sessionen kan inte längre återuppta VPN. Logga in igen i appen.',
      'system_vpn_resume_identity_changed':
          'Den lokala VPN-identiteten ändrades. Återupptagandet stoppades; starta en ny anslutning.',
      'system_vpn_resume_identity_invalid':
          'Identiteten för återupptagande är ogiltig. Starta en ny anslutning.',
      'system_vpn_resume_storage_failed':
          'Android kunde inte läsa eller uppdatera krypterade data för återupptagande. Starta en ny anslutning.',
      'system_vpn_resume_network_timeout':
          'Android hittade inget nätverk i tid för att återuppta VPN. Försök igen när ett nätverk är tillgängligt.',
      'system_vpn_resume_blocked':
          'Återupptagande av VPN är blockerat. Kontrollera Android-inställningarna och starta sedan en ny anslutning.',
      'system_vpn_resume_failed':
          'Android kunde inte återuppta VPN. Starta en ny anslutning i appen.',
      'system_vpn_resume_error_invalid':
          'Android returnerade ett oanvändbart fel vid återupptagande. Starta en ny anslutning.',
      'wireguard_identity_store_failed':
          'Android kunde inte spara det här kontots krypterade WireGuard-identitet.',
      'wireguard_identity_unavailable':
          'Ingen användbar WireGuard-identitet är tillgänglig för den här anslutningen.',
      'vpn_host_destroyed':
          'Android-komponenten som är värd för VPN stoppades. Starta en ny anslutning.',
      'vpn_host_unavailable':
          'Android kan inte skapa komponenten som är värd för VPN. Försök igen efter att ha kontrollerat VPN-inställningarna.',
      'openvpn_renewal_required':
          'Certifikatet kräver en åtgärd i appen innan anslutning.',
      'openvpn_recovery_failed':
          'Den automatiska återställningen misslyckades. Starta en ny anslutning i appen.',
      'openvpn_recovery_exhausted':
          'Den automatiska återställningen har redan använts. Starta en ny anslutning i appen.',
      'vpn_permission_required':
          'Android kräver en ny VPN-auktorisering innan tunneln startas.',
      'vpn_permission_denied':
          'Tillåt FuzeVPN i Android-begäran för att fortsätta.',
      'vpn_permission_request_failed':
          'Android kunde inte öppna skärmen för VPN-behörighet.',
      'wireguard_foreground_service_unavailable':
          'Android kunde inte hålla WireGuard-tjänsten i förgrunden.',
      'wireguard_identity_invalid':
          'Det här kontots krypterade WireGuard-nyckel kan inte läsas eller är ogiltig.',
      'wireguard_identity_in_use':
          'En annan åtgärd använder fortfarande det här kontots WireGuard-nyckel.',
      'wireguard_configuration_invalid':
          'Den mottagna WireGuard-adressen, DNS-servern, servernyckeln eller rutterna är ogiltiga.',
      'wireguard_operation_pending':
          'Den tidigare WireGuard-åtgärden har ännu inte släppt sin inbyggda tjänst.',
      'wireguard_start_failed':
          'WireGuard-motorn nekade aktivering av konfigurationen.',
      'wireguard_stop_timeout':
          'WireGuard-tjänsten bekräftade inte att VPN-gränssnittet släpptes inom tidsgränsen.',
      'wireguard_handshake_timeout':
          'Tunneln bekräftade inte en handskakning med servern i tid.',
      'openvpn_connection_timeout':
          'OpenVPN bekräftade inte anslutningen till servern i tid.',
      'openvpn_core_unavailable':
          'Den här appversionen innehåller ingen användbar OpenVPN-motor.',
      'openvpn_operation_pending':
          'Den inbyggda motorn håller fortfarande den tidigare OpenVPN-sessionen och vägrar skapa en till.',
      'openvpn_stop_timeout':
          'OpenVPN Core bekräftade inte att den inbyggda sessionen stoppades och förstördes inom tidsgränsen.',
      'openvpn_profile_unavailable':
          'Ingen validerad OpenVPN-profil kan läsas för den här anslutningen.',
      'openvpn_native_failed':
          'Ett appfel avbröt OpenVPN. Försök ansluta igen. Om problemet fortsätter, kör en diagnostik.',
      'openvpn_key_generation_failed':
          'Android Keystore kunde inte skapa eller läsa den icke-exporterbara privata P-256-nyckeln.',
      'openvpn_csr_generation_failed':
          'Android Keystore-nyckeln kunde inte signera OpenVPN-certifikatbegäran.',
      'openvpn_identity_store_failed':
          'OpenVPN-certifikatet eller profilen kunde inte sparas i krypterad lagring.',
      'openvpn_identity_clear_failed':
          'Android kunde inte ta bort hela den lokala OpenVPN-identiteten för det här kontot.',
      'openvpn_identity_in_use':
          'En inbyggd OpenVPN-session använder fortfarande enhetens nyckel eller certifikat.',
      'openvpn_tls_verification_required':
          'Profilen kräver inte uttryckligen verifiering av servercertifikatet.',
      'openvpn_cipher_invalid':
          'Servern angav en krypteringsalgoritm som inte finns i listan över tillåtna algoritmer.',
      'openvpn_profile_rejected':
          'Profilen från servern är inkompatibel. Skapa om den här enheten och försök igen.',
      'openvpn_identity_inconsistent':
          'Certifikatet stämmer inte med telefonens säkra identitet. Ingen lokal profil ersattes.',
      'tls_handshake_failed':
          'Servern nekade TLS-förhandlingen. Skapa om profilen om problemet kvarstår.',
      'tls_alert_unknown_ca':
          'Servern känner inte igen auktoriteten för det här enhetscertifikatet. OpenVPN-servern måste kontrolleras.',
      'tls_alert_bad_certificate':
          'Servern nekade det här enhetscertifikatet. Skapa om enheten innan du försöker igen.',
      'tls_alert_unsupported_certificate':
          'Servern stöder inte den säkra certifikattyp som Android använder.',
      'tls_client_certificate_required':
          'Servern kräver ett klientcertifikat, men OpenVPN Core kunde inte visa upp något.',
      'tls_alert_misc':
          'Servern returnerade en TLS-varning utanför kategorierna certifikat och version.',
      'tls_signature_algorithm_rejected':
          'Servern nekade Android Keystore-nyckelns ECDSA P-256-algoritm.',
      'tls_handshake_rejected':
          'Servern avbröt TLS-förhandlingen före anslutningen.',
      'tls_version_rejected':
          'Klienten och servern hittade ingen gemensam TLS-version.',
      'tls_certificate_expired':
          'Certifikatet som visades under anslutningen har löpt ut.',
      'tls_certificate_revoked':
          'Certifikatet som visades under anslutningen har återkallats.',
      'transport_failed':
          'OpenVPN-servern svarar inte på det aktuella nätverket. Försök igen snart.',
      'tun_configuration_rejected':
          'Android nekade nätverkskonfigurationen som begärdes av OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core nekade nätverksplanen innan Android-gränssnittet skapades.',
      'tun_interface_create_failed':
          'OpenVPN Core kunde inte få TUN-gränssnittet från Android VpnService.',
      'tun_interface_disabled':
          'Android eller OpenVPN Core inaktiverade TUN-gränssnittet under anslutningen.',
      'tun_halted':
          'OpenVPN Core tog emot en begäran om att stoppa TUN-gränssnittet.',
      'tun_already_established':
          'OpenVPN begärde ett andra gränssnitt i samma anslutning. Tunneln stoppades av säkerhetsskäl.',
      'tun_addresses_missing':
          'Servern tillhandahöll ingen användbar tunneladress.',
      'tun_routes_missing':
          'Servern tillhandahöll inga användbara tunnelrutter.',
      'tun_dns_missing': 'Servern tillhandahöll ingen användbar DNS-server.',
      'tun_permission_revoked':
          'Android återkallade VPN-behörigheten under anslutningen.',
      'tun_establish_returned_null':
          'Android skapade inte gränssnittet, vanligtvis eftersom ett annat VPN fortfarande är aktivt.',
      'openvpn_service_start_failed':
          'Android kunde inte starta OpenVPN-tjänsten i förgrunden.',
      'openvpn_operation_timeout':
          'Ett JNI-anrop till OpenVPN Core överskred sin maximala varaktighet.',
      'openvpn_start_failed':
          'Android-tjänsten är klar, men OpenVPN Core godkände inte att profilen startades.',
      'openvpn_connection_failed':
          'OpenVPN Core stoppades innan CONNECTED-händelsen skickades.',
      'openvpn_core_status_error':
          'Den inbyggda OpenVPN-loopen avslutades med ett fel utan någon mer specifik sluthändelse.',
      'openvpn_stopped_before_connected':
          'Den inbyggda OpenVPN-loopen stoppades före CONNECTED utan ett uttryckligt Core-fel.',
      'openvpn_auth_failed': 'OpenVPN-servern nekade profilens autentisering.',
      'openvpn_client_setup_failed':
          'OpenVPN Core kunde inte initiera klienten före nätverksanslutningen.',
      'openvpn_client_halted':
          'OpenVPN Core tog emot ett slutgiltigt stopp av klienten.',
      'openvpn_client_restart':
          'OpenVPN Core begärde en omstart av transportsessionen.',
      'openvpn_inactive_timeout':
          'OpenVPN Core stängde sessionen efter tidsgränsen för inaktivitet.',
      'openvpn_session_expired':
          'Servern rapporterade att OpenVPN-sessionen har löpt ut.',
      'openvpn_credentials_required':
          'Servern eller en proxy begär interaktiva inloggningsuppgifter som inte ingår i den här certifikatprofilen.',
      'openvpn_proxy_failed':
          'OpenVPN Core rapporterade ett fel i den konfigurerade proxyn eller reläet.',
      'openvpn_compression_failed':
          'OpenVPN Core nekade det komprimeringsläge som profilen eller servern meddelade.',
      'openvpn_ntlm_crypto_unavailable':
          'Profilen begär NTLM-kryptering som inte är tillgänglig i den här versionen.',
      'openvpn_feature_unsupported':
          'Profilen eller servern kräver en funktion som saknas i den här Android-klienten.',
      'network_unavailable':
          'Inget användbart fysiskt nätverk är tillgängligt.',
      'network_lost': 'Tunneln stoppades efter att nätverket försvann.',
      'certificate_validation_failed':
          'OpenVPN-serverns identitet kunde inte verifieras.',
      'openvpn_certificate_expired':
          'Förnya OpenVPN-profilen innan du ansluter igen.',
      'tunnel_active_for_another_account':
          'En tunnel som tillhör ett annat konto måste stoppas innan den här anslutningen kan startas.',
      'tunnel_already_active':
          'Android rapporterar att en tidigare VPN-session fortfarande använder gränssnittet.',
      'tunnel_stop_timeout':
          '$protocol-motorn bekräftade inte att VPN-gränssnittet släpptes inom tidsgränsen.',
      'tunnel_disconnected':
          'Den inbyggda motorn rapporterade att tunneln avslutades oväntat efter starten.',
      'native_bridge_unavailable':
          'Appen kan inte komma åt Androids VPN-tjänst. Stäng och öppna appen igen och försök sedan.',
      'native_operation_failed':
          'Ett appfel avbröt VPN-åtgärden. Försök igen. Om problemet fortsätter, kör en diagnostik.',
      'invalid_arguments':
          'Informationen som behövs för den här VPN-åtgärden är ofullständig. Försök igen. Om problemet fortsätter, kör en diagnostik.',
      'invalid_account_id':
          'Den inbyggda åtgärden är inte kopplad till en giltig kontoidentifierare.',
      'invalid_device_id':
          'Enhetsidentifieraren som skickades till den inbyggda motorn saknas eller är ogiltig.',
      'storage_key_not_allowed':
          'Android-bryggan blockerade en nyckel utanför listan över tillåten lagring.',
      'secure_storage_read_failed':
          'Android Keystore kunde inte dekryptera kontots lokala data.',
      'secure_storage_write_failed':
          'Android Keystore kunde inte kryptera eller spara de lokala uppgifterna.',
      'key_generation_failed':
          'Android kunde inte skapa eller läsa WireGuard-nyckeln i säker lagring.',
      'csr_generation_failed':
          'Android Keystore kunde inte skapa eller signera OpenVPN P-256 CSR.',
      'other':
          'En odokumenterad inbyggd gren misslyckades. Skicka diagnostikkoden som visas nedan till supporten.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Behörighetsbegäran redan öppen';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Androids begäran om VPN-behörighet visas redan. Slutför den innan du försöker igen.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-behörighetsbegäran avbröts';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN-behörighetsskärmen stängdes innan appen fick ett svar.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-anslutningen har inte bekräftats';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN-anslutningen kunde inte bekräftas. Den stoppades av säkerhetsskäl. Försök igen.';

  @override
  String get openvpnCleanup_title => 'OpenVPN-profilen har återkallats';

  @override
  String get openvpnCleanup_working =>
      'Stoppar och tar bort den återkallade OpenVPN-profilen…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-avstängningen har inte bekräftats. Försök igen innan du skapar en ny profil.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Den återkallade OpenVPN-profilen kunde inte tas bort helt. Försök rensa igen.';

  @override
  String get openvpnCleanup_complete =>
      'Den återkallade OpenVPN-profilen har tagits bort. Tryck på Anslut för att skapa en ny.';

  @override
  String get network_title => 'Nätverkskonfiguration';

  @override
  String get network_ipv4Fallback =>
      'IPv6 är tillfälligt otillgängligt. Förberedelsen fortsätter med IPv4.';

  @override
  String get network_rejectedTitle => 'Nätverkskonfigurationen nekades';

  @override
  String get network_rejectedMessage =>
      'Tunnelkonfigurationen är ofullständig eller stämmer inte överens med de godkända adresserna. Försök igen från appen.';

  @override
  String get network_unreadableTitle =>
      'Den lokala konfigurationen kan inte läsas';

  @override
  String get network_unreadableMessage =>
      'Den sparade OpenVPN-nätverkskonfigurationen kan inte användas. Anslut igen från appen för att uppdatera den.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Nätverksskydd';

  @override
  String get protection_subtitle =>
      'Blockera direktåtkomst till internet om VPN kopplas från.';

  @override
  String get protection_active => 'Systemskydd aktivt';

  @override
  String get protection_alwaysOnOnly =>
      'VPN alltid på är aktiverat; slå på blockering utanför VPN';

  @override
  String get protection_inactive => 'Systemskydd inaktivt';

  @override
  String get protection_unknown => 'Kontrollera systemskyddet';

  @override
  String get protection_openSettings => 'Öppna Android-inställningar';

  @override
  String get protection_dialogTitle => 'Konfigurera nätverksskydd';

  @override
  String get protection_dialogMessage =>
      'Android hanterar VPN alltid på och blockering av anslutningar utanför VPN. Kontrollera att FuzeVPN är valt och aktivera blockering i systeminställningarna.';

  @override
  String get protection_dialogOpen => 'Öppna inställningar';

  @override
  String get session_systemProtectionNote =>
      'Om Android fortfarande blockerar trafik utanför VPN kan du öppna systeminställningarna för att kontrollera eller ändra det här skyddet.';

  @override
  String get diagnostics_title => 'Diagnostik';

  @override
  String get diagnostics_settingsTitle => 'Appdiagnostik';

  @override
  String get diagnostics_automaticTitle => 'Skicka viktiga fel';

  @override
  String get diagnostics_automaticDescription =>
      'Dela en kort teknisk rapport när ett viktigt fel inträffar.';

  @override
  String get diagnostics_privacy =>
      'Skickade rapporter kopplas till det inloggade kontot och sparas i 30 dagar. De innehåller ingen webbhistorik, inga lösenord och inga VPN-nycklar.';

  @override
  String get diagnostics_manualOpen => 'Kör diagnostik';

  @override
  String get diagnostics_localDescription =>
      'Skapa en rapport om appens och VPN:s status. Din anslutning påverkas inte.';

  @override
  String get diagnostics_sendReport => 'Skicka rapporten';

  @override
  String get diagnostics_sendHint =>
      'Lämna den här rutan avmarkerad för att behålla rapporten på den här enheten.';

  @override
  String get diagnostics_signedOut =>
      'Logga in på ditt konto för att skicka en rapport.';

  @override
  String get diagnostics_localLifetime =>
      'Spara rapporten på telefonen så att den finns kvar när appen stängs.';

  @override
  String get diagnostics_run => 'Kör diagnostik';

  @override
  String get diagnostics_rerun => 'Kör diagnostik igen';

  @override
  String get diagnostics_running => 'Kontrollerar…';

  @override
  String get diagnostics_sending => 'Skickar rapport…';

  @override
  String get diagnostics_prepared => 'Rapporten är klar på den här enheten';

  @override
  String get diagnostics_queued => 'Rapporten väntar på att skickas';

  @override
  String get diagnostics_sent => 'Rapporten har tagits emot';

  @override
  String get diagnostics_failed =>
      'Det gick inte att skicka. Din lokala rapport är fortfarande tillgänglig.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostikrapporten kunde inte förberedas. Försök igen.';

  @override
  String get diagnostics_authenticationRequired =>
      'Logga in igen för att skicka rapporten.';

  @override
  String get diagnostics_retry => 'Försök skicka igen';

  @override
  String get diagnostics_export => 'Spara rapport';

  @override
  String get diagnostics_exportFailed =>
      'Exporten misslyckades. Försök igen från den lokala rapporten.';

  @override
  String get diagnostics_preferenceFailed =>
      'Den här inställningen kunde inte sparas. Försök igen.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referens: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Togs emot $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Sparas till $date';
  }

  @override
  String get diagnostics_duplicate =>
      'Den här rapporten hade redan tagits emot.';

  @override
  String get diagnostics_preview => 'Förhandsvisning av rapport';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tekniska händelser bifogade',
      one: '1 teknisk händelse bifogad',
      zero: 'Inga tekniska händelser bifogade',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tekniska detaljer';

  @override
  String get diagnostics_empty =>
      'Ingen diagnostikrapport har förberetts ännu.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunnelstatus',
      'handshake': 'Anslutningsbekräftelse',
      'certificate': 'VPN-certifikat',
      'kill_switch': 'Android-skydd',
      'connectivity': 'Tillgängligt nätverk',
      'api_reachability': 'Tjänsteåtkomst',
      'secure_storage': 'Säker lagring',
      'other': 'Lokal kontroll',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Kontrollerad',
      'failed': 'Kräver åtgärd',
      'skipped': 'Testades inte — ingen aktiv kontroll',
      'unknown': 'Informationen är inte tillgänglig',
      'other': 'Informationen är inte tillgänglig',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Välkommen till FuzeVPN';

  @override
  String get connection_changeLocation => 'Byt plats';

  @override
  String get connection_details => 'Anslutningsdetaljer';

  @override
  String get locations_searchLabel => 'Sök efter en stad eller ett land';

  @override
  String get locations_clearSearch => 'Rensa sökning';

  @override
  String get locations_filterAll => 'Alla';

  @override
  String get locations_filterFavorites => 'Favoriter';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count platser',
      one: '$count plats',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Inga platser hittades';

  @override
  String get locations_noResultsHint =>
      'Försök med en annan stad eller ett annat land.';

  @override
  String get locations_noFavorites => 'Dina favoriter nära till hands';

  @override
  String get locations_noFavoritesHint =>
      'Tryck på stjärnan bredvid en plats för att spara den här.';

  @override
  String get locations_showAll => 'Visa alla platser';

  @override
  String locations_addFavorite(String name) {
    return 'Lägg till $name i favoriter';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Ta bort $name från favoriter';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Favoriten kunde inte sparas. Försök igen.';

  @override
  String get locations_emptyTitle => 'Inga platser tillgängliga';

  @override
  String get locations_emptyHint => 'Uppdatera listan och försök igen.';

  @override
  String get devices_manage => 'Hantera mina enheter';

  @override
  String get settings_personalization => 'Gör det till ditt';

  @override
  String get settings_safety => 'Skydd';

  @override
  String get settings_help => 'Behöver du hjälp?';

  @override
  String get settings_about => 'Om FuzeVPN';

  @override
  String get diagnostics_heading => 'Förstå ett anslutningsproblem';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Tillgänglig',
      'pending': 'Förbereder',
      'revoked': 'Borttagen',
      'expired': 'Utgången',
      'other': 'Statusen är inte tillgänglig',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Inställningen sparades inte';

  @override
  String get notice_preferenceSave_message =>
      'Ditt val används nu, men kunde inte sparas. Försök igen för att behålla det när appen stängs.';

  @override
  String get connection_androidDisconnectHint =>
      'Om Android låter VPN vara aktivt kan du stänga av VPN alltid på i inställningarna som öppnas.';

  @override
  String get protection_learnMore => 'Läs mer om Android-skydd';

  @override
  String get protection_guideWhy =>
      'Det här skyddet hindrar appar från att använda internet direkt om VPN kopplas från. Det konfigureras i Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN alltid på';

  @override
  String get protection_guideAlwaysOn =>
      'Android håller VPN-tjänsten igång och kan starta om den efter att telefonen startats om.';

  @override
  String get protection_guideBlockTitle => 'Blockera anslutningar utan VPN';

  @override
  String get protection_guideBlock =>
      'Den här inställningen hindrar trafik från att kringgå VPN, även när anslutningen är avbruten.';

  @override
  String get protection_guideWarning =>
      'När den här blockeringen är aktiverad förblir internetåtkomsten avstängd tills VPN är anslutet.';

  @override
  String get protection_guideStepsTitle => 'Aktivera skyddet';

  @override
  String get protection_guideStep1 =>
      'Öppna Androids VPN-inställningar med knappen nedan.';

  @override
  String get protection_guideStep2 =>
      'Öppna alternativen med kugghjulsikonen bredvid FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Aktivera VPN alltid på och sedan Blockera anslutningar utan VPN, om alternativen finns.';

  @override
  String get protection_guideManufacturers =>
      'Namnen varierar mellan telefoner. Sök vid behov efter VPN i Inställningar, ofta under Nätverk och internet.';

  @override
  String get protection_guideDisableTitle => 'Stäng av det här skyddet';

  @override
  String get protection_guideDisable =>
      'Stäng av blockering utan VPN i samma inställningar för att tillåta internetåtkomst utan VPN. Stäng också av VPN alltid på om du inte längre vill att Android ska starta om det.';

  @override
  String get protection_guideManual =>
      'Du väljer de här inställningarna i Android. FuzeVPN ändrar dem inte åt dig.';

  @override
  String get locations_changeTitle => 'Byta plats?';

  @override
  String locations_changeActive(String name) {
    return 'VPN kopplas från och försöker sedan ansluta till $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN försöker ansluta till $name.';
  }

  @override
  String get locations_confirmChange => 'Byt och anslut';

  @override
  String get locations_changeBusy =>
      'Ett byte pågår. Vänta innan du väljer en annan plats.';

  @override
  String get locations_automaticSelection => 'Automatiskt val';

  @override
  String get locations_cities => 'Städer';

  @override
  String get locations_servers => 'Servrar';

  @override
  String locations_viewCities(String name) {
    return 'Visa städer i $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Visa servrar i $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count länder',
      one: '$count land',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count städer',
      one: '$count stad',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servrar',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Alla länder';

  @override
  String get locations_backToCountries => 'Tillbaka till länder';

  @override
  String locations_backToCities(String name) {
    return 'Tillbaka till städer i $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Välj $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Välj $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Ingen kompatibel server är tillgänglig.';

  @override
  String get externalLink_failed =>
      'Det gick inte att öppna länken. Du kan kopiera den och öppna den i webbläsaren.';

  @override
  String get externalLink_copy => 'Kopiera länk';

  @override
  String get externalLink_copied => 'Länken kopierades';

  @override
  String get externalLink_copyFailed =>
      'Det gick inte att kopiera länken. Markera adressen nedan.';

  @override
  String get settings_deleteAccount => 'Radera mitt konto';

  @override
  String get settings_deleteAccountDetail =>
      'Se hur du begär att kontot raderas';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Välj ditt VPN-abonnemang.';

  @override
  String get billing_subscribe => 'Prenumerera';

  @override
  String get billing_choosePlan => 'Välj ett abonnemang för att fortsätta.';

  @override
  String get billing_monthly => 'Månadsvis';

  @override
  String get billing_yearly => 'Årsvis';

  @override
  String get billing_continue => 'Fortsätt med Google Play';

  @override
  String get billing_restore => 'Återställ köp';

  @override
  String get billing_manage => 'Hantera abonnemang';

  @override
  String get billing_deleteAccountWarning =>
      'Om du har ett abonnemang via Google Play stoppar inte radering av ditt FuzeVPN-konto förnyelsen. Hantera eller stoppa förnyelsen separat i Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Fortsätt till begäran om att radera kontot';

  @override
  String get billing_refresh => 'Uppdatera åtkomst';

  @override
  String get billing_loadingPlans => 'Läser in abonnemang…';

  @override
  String get billing_unavailable =>
      'Inga abonnemang är tillgängliga just nu. Försök igen senare.';

  @override
  String get billing_comingSoon => 'Abonnemang kommer snart.';

  @override
  String get billing_priceDisclosure =>
      'Pris från Google Play. Slutbelopp och tillämpliga skatter visas innan du bekräftar.';

  @override
  String get billing_renewalMonthly =>
      'Förnyas automatiskt varje månad om du inte säger upp det. Du kan säga upp när som helst i Google Play-abonnemang.';

  @override
  String get billing_renewalYearly =>
      'Förnyas automatiskt varje år om du inte säger upp det. Du kan säga upp när som helst i Google Play-abonnemang.';

  @override
  String get billing_active => 'Din Premium-åtkomst är aktiv';

  @override
  String billing_accessUntil(String date) {
    return 'Åtkomst till $date.';
  }

  @override
  String get billing_webManaged =>
      'Ditt abonnemang hanteras på FuzeVPN:s webbplats.';

  @override
  String get billing_playManaged => 'Ditt abonnemang hanteras via Google Play.';

  @override
  String get billing_inactive => 'Inget aktivt abonnemang.';

  @override
  String get billing_checkingAccess => 'Kontrollerar din åtkomst…';

  @override
  String get billing_restoring => 'Återställer köp…';

  @override
  String get billing_pending =>
      'Betalningen väntar. Din åtkomst aktiveras efter bekräftelse.';

  @override
  String get billing_cancelled =>
      'Köpet avbröts. Inget nytt abonnemang aktiverades.';

  @override
  String get billing_verifying => 'Verifierar köpet…';

  @override
  String get billing_success =>
      'Abonnemanget är aktiverat. Din Premium-åtkomst är klar.';

  @override
  String get billing_restored => 'Dina köp har återställts.';

  @override
  String get billing_restoreEmpty =>
      'Inga köp att återställa för detta Google Play-konto.';

  @override
  String get billing_catalogError =>
      'Det gick inte att läsa in abonnemang. Försök igen.';

  @override
  String get billing_purchaseError =>
      'Det gick inte att starta köpet. Försök igen.';

  @override
  String get billing_verificationError =>
      'Köpverifiering är tillfälligt otillgänglig. Återställ köp för att försöka igen.';

  @override
  String get billing_restoreError =>
      'Det gick inte att återställa köp. Försök igen.';

  @override
  String get billing_managementError =>
      'Det gick inte att öppna abonnemangshantering. Försök igen.';

  @override
  String get billing_storeUnavailable =>
      'Google Play är inte tillgängligt på den här enheten.';

  @override
  String get welcome_title => 'Din VPN, enkelt och smidigt.';

  @override
  String get welcome_description =>
      'Skydda din anslutning. Behåll kontrollen över din integritet.';

  @override
  String get welcome_start => 'Kom igång';

  @override
  String get welcome_alreadyPurchased => 'Har du redan köpt?';

  @override
  String get welcome_noAccountRequired =>
      'Du behöver inte skapa ett konto för att börja.';

  @override
  String get guest_accountTitle => 'Kontot är inte kopplat';

  @override
  String get guest_accountDescription =>
      'Återställ dina köp med samma Google Play-konto för att använda prenumerationen på en annan enhet.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Har du redan en prenumeration? Logga in';

  @override
  String get guest_claimTitle => 'Ta med FuzeVPN överallt';

  @override
  String get guest_claimDescription =>
      'Skapa ett konto för att använda din prenumeration på fler enheter. Det här steget är valfritt.';

  @override
  String get guest_skip => 'Senare';

  @override
  String get guest_activationTitle => 'Fuze Premium är aktivt';

  @override
  String get guest_activationDescription =>
      'Din prenumeration är klar. Använd din VPN och skapa ett konto när du vill.';

  @override
  String get guest_useVpn => 'Använd min VPN';

  @override
  String get guest_loginRequired =>
      'Det här köpet är redan kopplat till ett FuzeVPN-konto. Logga in på det kontot för att använda din prenumeration.';

  @override
  String get guest_signOutWarning =>
      'Du kan återfå din prenumeration genom att återställa köp med samma Google Play-konto.';

  @override
  String get guest_profileUnavailable =>
      'Ditt konto är redan kopplat. Logga in för att visa och hantera dina uppgifter.';

  @override
  String get billing_acceptance =>
      'Genom att fortsätta godkänner du Användarvillkoren och Integritetspolicyn.';

  @override
  String get guest_verifyEmailReminder =>
      'Bekräfta din e-postadress för att skydda ditt konto. Du kan fortsätta använda din VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Tjänsten är tillfälligt otillgänglig. Försök igen om en stund.';

  @override
  String get guest_restoreError =>
      'Dina köp kunde inte återställas. Försök igen med Google Play-kontot som användes för köpet.';

  @override
  String get guest_claimSuccess =>
      'Ditt konto har skapats. Din prenumeration och VPN-åtkomst är kvar.';

  @override
  String get guest_emailExists =>
      'Den här e-postadressen används redan. Välj en annan adress eller logga in på ditt befintliga konto. Ditt köp är fortfarande tillgängligt via Google Play.';

  @override
  String get guest_claimError =>
      'Ditt konto kunde inte skapas. Du kan fortsätta använda din VPN och försöka igen senare.';

  @override
  String get guest_secureStorageError =>
      'Din session kunde inte sparas säkert på den här enheten. Försök igen.';

  @override
  String get guest_premiumRequired =>
      'Välj en prenumeration för att aktivera din VPN.';

  @override
  String get welcome_viewPlans => 'Visa abonnemang';

  @override
  String get google_continue => 'Fortsätt med Google';

  @override
  String get google_or => 'eller';

  @override
  String get google_title => 'Ditt FuzeVPN-konto';

  @override
  String get google_settingUp => 'Slutför ditt konto';

  @override
  String get google_country => 'Bosättningsland';

  @override
  String get google_profileDescription =>
      'Välj ditt land och läs båda dokumenten för att skapa ditt FuzeVPN-konto.';

  @override
  String get google_claimDescription =>
      'Koppla ditt gästkonto till Google. Abonnemang och enhet förblir kopplade till detta konto.';

  @override
  String get google_linkTitle => 'Koppla Google till FuzeVPN';

  @override
  String get google_linkDescription =>
      'Bekräfta åtkomst till ditt befintliga FuzeVPN-konto. Ditt Google-lösenord efterfrågas inte.';

  @override
  String get google_password => 'FuzeVPN-lösenord';

  @override
  String get google_linkAccount => 'Bekräfta kopplingen';

  @override
  String get google_requestEmail => 'Få ett bekräftelsemejl';

  @override
  String get google_emailInstructions =>
      'Öppna mejlet från FuzeVPN och ange bekräftelsekoden.';

  @override
  String get google_emailCode => 'Bekräftelsekod från mejlet';

  @override
  String get google_confirmEmail => 'Bekräfta koden';

  @override
  String get google_restart => 'Välj ett annat Google-konto';

  @override
  String get google_resume => 'Kontrollera detta försök';

  @override
  String get google_unavailable =>
      'Google-inloggning är inte tillgänglig. Du kan använda e-post och lösenord.';

  @override
  String get google_expired => 'Detta försök har löpt ut. Avbryt och börja om.';

  @override
  String get google_conflict =>
      'Detta Google-konto är redan kopplat någon annanstans. Ditt nuvarande konto och abonnemang behålls.';

  @override
  String get google_error =>
      'Google-inloggningen misslyckades. Försök igen; din nuvarande åtkomst behålls.';

  @override
  String get google_uncertain =>
      'Resultatet kunde inte bekräftas. Kontrollera försöket eller avbryt innan du börjar om.';

  @override
  String get google_cancelFailed =>
      'Avbrottet kunde inte bekräftas. Försök avbryta igen innan du lämnar skärmen.';

  @override
  String get google_cancelled => 'Google-inloggning avbruten.';

  @override
  String get google_selecting => 'Välj ditt Google-konto…';

  @override
  String get google_verifying => 'Kontrollerar ditt konto…';

  @override
  String get google_emailUnavailable =>
      'Bekräftelsemejlet kunde inte skickas. Försök senare.';

  @override
  String get google_emailSent =>
      'Bekräftelsemejl skickat. Kontrollera din inkorg.';

  @override
  String get google_rateLimited => 'Vänta innan du försöker igen.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN-lösenordet är fel. Ditt nuvarande konto behålls.';

  @override
  String get google_invalidCode =>
      'Bekräftelsekoden är ogiltig eller har löpt ut.';

  @override
  String get google_accountChanged =>
      'Sessionen har ändrats. Avbryt försöket innan du börjar om.';

  @override
  String get google_invalidResponse =>
      'Svaret kunde inte valideras. Din nuvarande åtkomst behålls.';

  @override
  String get google_invalidRegistration =>
      'Kontrollera landet och båda samtyckena.';

  @override
  String get google_consentRequired =>
      'Välj ditt land och godkänn båda dokumenten för att fortsätta.';

  @override
  String get google_challengeRequired =>
      'En ytterligare säkerhetskontroll krävs. Din nuvarande åtkomst behålls.';

  @override
  String get google_challengeUnavailable =>
      'Säkerhetskontrollen är inte tillgänglig. Försök senare.';

  @override
  String get billing_trialTitle => 'Prova Fuze Premium gratis';

  @override
  String get billing_trialSubtitle =>
      'Skydda din anslutning från och med idag.';

  @override
  String get billing_trialWeeks => '2 veckors gratis provperiod';

  @override
  String billing_trialDays(String days) {
    return '$days dagars gratis provperiod';
  }

  @override
  String get billing_trialStart => 'Starta min gratis provperiod';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Om du börjar idag väntas den första debiteringen den $date.';
  }

  @override
  String get billing_trialTerms =>
      'Förnyas automatiskt till angivet pris. Avsluta i Google Play innan provperioden tar slut för att undvika en debitering.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Därefter $price per månad';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Därefter $price per år';
  }

  @override
  String get billing_choosePeriod => 'Välj ditt abonnemang';

  @override
  String get billing_selectionHint => 'Välj ett abonnemang för att fortsätta.';

  @override
  String get billing_benefitConnection => 'Krypterad anslutning';

  @override
  String get billing_benefitPrivacy => 'Integritet på nätet';

  @override
  String get billing_benefitNoAccount => 'Ingen registrering krävs';

  @override
  String get billing_cancellation => 'Avsluta i Google Play';

  @override
  String get billing_premiumTitle => 'Din anslutning, bättre skyddad.';

  @override
  String get billing_premiumSubtitle =>
      'Skydda din anslutning i din egen takt.';

  @override
  String get billing_priceMonthly => 'per månad';

  @override
  String get billing_priceYearly => 'per år';

  @override
  String get billing_trialToday => 'Inget att betala idag';

  @override
  String get billing_trialConfirmation =>
      'Google Play bekräftar datum, slutbelopp och tillämpliga skatter innan du bekräftar.';

  @override
  String get billing_offerChanged =>
      'Villkoren för erbjudandet har ändrats. Uppdatera abonnemangen och välj igen.';
}
