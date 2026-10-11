// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Bescherm uw verbinding';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN gebruikt de VPN-service van Android (VpnService) om een versleutelde tunnel te maken tussen dit apparaat en de FuzeVPN-servers.';

  @override
  String get vpnDisclosure_dataBody =>
      'Wanneer de VPN actief is, lopen het internetverkeer van uw apps, bestemmingsadressen en DNS-verzoeken door deze tunnel om uw verbinding te routeren, ook wanneer FuzeVPN op de achtergrond draait.';

  @override
  String get vpnDisclosure_statusBody =>
      'De app gebruikt de verbindingsstatus, de duur en de hoeveelheid overgedragen gegevens om uw VPN-verbinding weer te geven. U kunt deze op elk moment stoppen.';

  @override
  String get vpnDisclosure_privacy => 'Privacy';

  @override
  String get vpnDisclosure_accept => 'Accepteren en doorgaan';

  @override
  String get vpnDisclosure_decline => 'Niet nu';

  @override
  String get accountRestoration_title => 'Account tijdelijk niet beschikbaar';

  @override
  String get accountRestoration_message =>
      'Je sessie is bewaard. Probeer het opnieuw om je account te herstellen; je kunt de VPN-verbinding hier nog steeds beheren.';

  @override
  String get action_retry => 'Opnieuw proberen';

  @override
  String get session_endingTitle => 'Sessie wordt beëindigd';

  @override
  String get session_ending =>
      'Je sessie is ongeldig gemaakt. De VPN wordt gestopt en de sessie wordt gewist…';

  @override
  String get session_stopFailed =>
      'Het afsluiten van de VPN is niet bevestigd. Probeer het opnieuw voordat je je weer aanmeldt.';

  @override
  String get session_cleanupFailed =>
      'De VPN is gestopt, maar het verwijderen van de sessie is niet bevestigd. Probeer het opschonen opnieuw.';

  @override
  String get session_retryStop => 'Afsluiten opnieuw proberen';

  @override
  String get session_retryCleanup => 'Opschonen opnieuw proberen';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN veilig voorbereiden…';

  @override
  String get nav_connection => 'Verbinding';

  @override
  String get nav_locations => 'Locaties';

  @override
  String get nav_account => 'Account';

  @override
  String get nav_devices => 'Apparaten';

  @override
  String get nav_settings => 'Instellingen';

  @override
  String get action_refresh => 'Vernieuwen';

  @override
  String get auth_tab_login => 'Aanmelden';

  @override
  String get auth_tab_register => 'Registreren';

  @override
  String get auth_stepAccount => 'Account';

  @override
  String get auth_stepIdentity => 'Identiteit';

  @override
  String get auth_stepAddress => 'Adres en overeenkomsten';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Stap $current van $total';
  }

  @override
  String get auth_tagline => 'Je VPN, eenvoudig gemaakt.';

  @override
  String get auth_keysLocal =>
      'Je persoonlijke VPN-sleutels blijven op dit apparaat.';

  @override
  String get form_email => 'E-mailadres';

  @override
  String get form_password => 'Wachtwoord';

  @override
  String get form_showPassword => 'Wachtwoord tonen';

  @override
  String get form_hidePassword => 'Wachtwoord verbergen';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8-bytes. Sommige tekens gebruiken meer dan één byte.';

  @override
  String get form_firstName => 'Voornaam';

  @override
  String get form_lastName => 'Achternaam';

  @override
  String get form_phone => 'Telefoon (+33612345678)';

  @override
  String get form_address => 'Adres';

  @override
  String get form_address2 => 'Adresregel 2 (optioneel)';

  @override
  String get form_postalCode => 'Postcode';

  @override
  String get form_city => 'Plaats';

  @override
  String get form_country => 'Landcode (bijv. FR)';

  @override
  String get action_login => 'Aanmelden';

  @override
  String get action_createAccount => 'Account aanmaken';

  @override
  String get action_createMyAccount => 'Mijn account aanmaken';

  @override
  String get action_next => 'Doorgaan';

  @override
  String get action_previous => 'Terug';

  @override
  String get action_forgotPassword => 'Wachtwoord vergeten?';

  @override
  String get auth_noAccount => 'Heb je nog geen account?';

  @override
  String get auth_requiredInformation => 'Maak je account aan in drie stappen.';

  @override
  String get auth_termsPrefix => 'Ik accepteer de ';

  @override
  String get auth_termsLink => 'gebruiksvoorwaarden';

  @override
  String get auth_privacyPrefix => 'Ik accepteer het ';

  @override
  String get auth_privacyLink => 'privacybeleid';

  @override
  String get auth_consentRequired =>
      'Je toestemming is vereist om een account aan te maken.';

  @override
  String get validation_required => 'Dit veld is verplicht.';

  @override
  String get validation_email => 'Voer een geldig e-mailadres in.';

  @override
  String get validation_password =>
      'Wachtwoord is te kort: minimaal 8 UTF-8-bytes.';

  @override
  String get validation_passwordTooLong =>
      'Wachtwoord is te lang: maximaal 72 UTF-8-bytes.';

  @override
  String get validation_phone =>
      'Gebruik de internationale notatie, bijvoorbeeld +33612345678.';

  @override
  String get validation_country =>
      'Gebruik een tweeletterige landcode, bijvoorbeeld FR.';

  @override
  String get passwordReset_title => 'Wachtwoord opnieuw instellen';

  @override
  String get passwordReset_description =>
      'Voer het e-mailadres van je account in om een link voor het opnieuw instellen van je wachtwoord aan te vragen.';

  @override
  String get passwordReset_send => 'Link verzenden';

  @override
  String get connection_title => 'Je verbinding';

  @override
  String get connection_subtitle =>
      'Kies een locatie en zet vervolgens je VPN aan.';

  @override
  String get connection_prepare => 'Klaar om verbinding te maken?';

  @override
  String get connection_advancedOptions => 'Geavanceerde opties';

  @override
  String get connection_location => 'Locatie';

  @override
  String get connection_chooseLocation => 'Kies een locatie';

  @override
  String get connection_protocol => 'Protocol';

  @override
  String get connection_connect => 'Verbinden';

  @override
  String get connection_connecting => 'Bezig met verbinden…';

  @override
  String get connection_disconnect => 'Verbinding verbreken';

  @override
  String get connection_disconnecting => 'Verbinding wordt verbroken';

  @override
  String get connection_locationChange => 'Locatie wordt gewijzigd…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol niet beschikbaar';
  }

  @override
  String get connection_activeLocation => 'Actieve locatie';

  @override
  String get connection_duration => 'Duur';

  @override
  String get connection_received => 'Ontvangen';

  @override
  String get connection_sent => 'Verzonden';

  @override
  String get connection_lastHandshake => 'Laatste beveiligde uitwisseling';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration geleden';
  }

  @override
  String get verification_title => 'Bevestig je e-mailadres';

  @override
  String get verification_message =>
      'Bevestig je e-mailadres om de VPN op deze telefoon te gebruiken.';

  @override
  String get verification_resend => 'E-mail opnieuw verzenden';

  @override
  String get migration_title => 'Locatie wijzigen';

  @override
  String get migration_draining => 'Locatiewijziging voorbereiden…';

  @override
  String get migration_activating => 'Nieuwe server activeren…';

  @override
  String get migration_ready => 'Locatie bijgewerkt.';

  @override
  String get migration_blocked =>
      'Voor de locatiewijziging is ingrijpen op de server nodig. Probeer het later opnieuw of neem contact op met de ondersteuning.';

  @override
  String get migration_progress => 'Voortgang van locatiewijziging';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Tijd tussen controles: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Locatiewijziging hervatten';

  @override
  String get status_authorizing => 'Toestemming vereist';

  @override
  String get status_authorizingDetail =>
      'Accepteer het Android-verzoek om de VPN toe te staan.';

  @override
  String get status_preparing => 'Voorbereiden';

  @override
  String get status_preparingDetail => 'Je beveiligde verbinding voorbereiden.';

  @override
  String get status_reconnecting => 'Opnieuw verbinden…';

  @override
  String get status_reconnectingDetail =>
      'De verbinding is onderbroken. De VPN probeert opnieuw verbinding te maken.';

  @override
  String get status_connecting => 'Verbinden';

  @override
  String get status_connectingDetail => 'Verbinding maken met de VPN-server…';

  @override
  String get status_connected => 'Verbonden';

  @override
  String get status_connectedDetail => 'Je VPN-verbinding is actief.';

  @override
  String get status_disconnecting => 'Verbinding verbreken';

  @override
  String get status_disconnectingDetail => 'Je VPN-verbinding wordt gestopt.';

  @override
  String get status_error => 'Verbinding niet beschikbaar';

  @override
  String get status_errorDetail =>
      'De VPN-verbinding is niet bevestigd. Probeer het opnieuw.';

  @override
  String get status_idle => 'Verbinding verbroken';

  @override
  String get status_idleDetail =>
      'Maak verbinding met de VPN om je verbinding te beschermen.';

  @override
  String get trust_note =>
      'Als je de app sluit, wordt de VPN niet gestopt. Gebruik Verbinding verbreken om de VPN te stoppen.';

  @override
  String get locations_none => 'Er zijn momenteel geen locaties beschikbaar.';

  @override
  String get locations_available => 'Kies je volgende locatie.';

  @override
  String get locations_selected => 'Geselecteerde locatie';

  @override
  String get locations_select => 'Deze locatie kiezen';

  @override
  String get locations_lockedTunnel =>
      'Verbreek de VPN-verbinding om de locatie te wijzigen.';

  @override
  String get locations_lockedMigration =>
      'Wacht tot de locatiewijziging is voltooid.';

  @override
  String get devices_title => 'Je apparaten';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit apparaten';
  }

  @override
  String get devices_refresh => 'Apparaten vernieuwen';

  @override
  String get devices_empty => 'Er is nog geen VPN-apparaat geregistreerd.';

  @override
  String get devices_firstConnection =>
      'Je telefoon wordt bij de eerste verbinding toegevoegd.';

  @override
  String get devices_thisDevice => 'Dit apparaat';

  @override
  String devices_added(Object date) {
    return 'Toegevoegd op $date';
  }

  @override
  String get action_remove => 'Verwijderen';

  @override
  String get settings_title => 'Instellingen';

  @override
  String get settings_subtitle =>
      'Je voorkeuren en account, allemaal op één plek.';

  @override
  String get settings_appearance => 'Weergave';

  @override
  String get settings_language => 'Taal';

  @override
  String get settings_languageDescription =>
      'De taal die je kiest, geldt ook voor VPN-meldingen.';

  @override
  String get settings_account => 'Account';

  @override
  String get settings_signOut => 'Afmelden';

  @override
  String get settings_privacy => 'Privacybeleid';

  @override
  String get settings_terms => 'Gebruiksvoorwaarden';

  @override
  String get settings_security => 'Beveiliging en transparantie';

  @override
  String get settings_licenses => 'Licenties van componenten';

  @override
  String get settings_licensesDetail => 'Software die in de app wordt gebruikt';

  @override
  String get settings_background =>
      'De VPN blijft actief wanneer je de app verlaat. Gebruik Verbinding verbreken op het tabblad Verbinding om de VPN te stoppen.';

  @override
  String get theme_system => 'Systeem';

  @override
  String get theme_light => 'Licht';

  @override
  String get theme_dark => 'Donker';

  @override
  String get language_system => 'Telefoontaal';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Dit apparaat verwijderen?';

  @override
  String get dialog_removeCurrent =>
      'De verbinding van deze telefoon met de VPN wordt verbroken en de toegang gaat verloren. De VPN-verbindingsgegevens worden verwijderd nadat de server dit heeft bevestigd.';

  @override
  String dialog_removeOther(Object name) {
    return 'De VPN-toegang voor ‘$name’ wordt ingetrokken. Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get dialog_signOut => 'Afmelden?';

  @override
  String get dialog_signOutMessage =>
      'De VPN wordt gestopt en je moet je opnieuw aanmelden. Je versleutelde VPN-sleutels blijven op deze telefoon staan voor je volgende verbinding.';

  @override
  String get action_cancel => 'Annuleren';

  @override
  String get action_signOut => 'Afmelden';

  @override
  String get notice_close => 'Melding sluiten';

  @override
  String get notice_sessionExpired_title => 'Sessie verlopen';

  @override
  String get notice_sessionExpired_message =>
      'Je sessie is verlopen. Meld je opnieuw aan.';

  @override
  String get notice_connectionFailed_title => 'Verbinding mislukt';

  @override
  String get notice_invalidCredentials_message =>
      'Het e-mailadres of wachtwoord is onjuist.';

  @override
  String get notice_emailVerification_title => 'E-mailbevestiging vereist';

  @override
  String get notice_emailVerification_message =>
      'Bevestig je e-mailadres voordat je een VPN-apparaat toevoegt.';

  @override
  String get notice_rateLimited_title => 'Te veel pogingen';

  @override
  String get notice_deviceLimit_title => 'Limiet van 2 apparaten bereikt';

  @override
  String get notice_deviceLimit_message =>
      'Verwijder een bestaand apparaat voordat je een ander apparaat toevoegt.';

  @override
  String get notice_identityRenewal_title =>
      'VPN-identiteit moet worden vernieuwd';

  @override
  String get notice_identityRenewal_message =>
      'Deze identiteit is verwijderd. Maak een nieuwe lokale identiteit aan.';

  @override
  String get notice_migrationPending_title =>
      'Locatiewijziging wordt uitgevoerd';

  @override
  String get notice_migrationPending_message =>
      'Er wordt al een locatiewijziging uitgevoerd.';

  @override
  String get notice_migrationBlocked_title => 'Locatiewijziging geblokkeerd';

  @override
  String get notice_migrationBlocked_message =>
      'Voor de locatiewijziging is ingrijpen op de server nodig. Probeer het later opnieuw of neem contact op met de ondersteuning.';

  @override
  String get notice_targetUnavailable_title =>
      'Server tijdelijk niet beschikbaar';

  @override
  String get notice_targetUnavailable_message =>
      'Deze server is tijdelijk niet beschikbaar.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetverbinding niet beschikbaar';

  @override
  String get notice_networkUnavailable_message =>
      'Controleer je verbinding en probeer het opnieuw.';

  @override
  String get notice_permissionDenied_title => 'VPN-toestemming geweigerd';

  @override
  String get notice_permissionDenied_message =>
      'Start de verbinding opnieuw en accepteer het Android-toestemmingsverzoek.';

  @override
  String get notice_wireguardTimeout_title => 'De server reageert niet';

  @override
  String get notice_wireguardTimeout_message =>
      'Het maken van de WireGuard-verbinding duurde te lang. Probeer het opnieuw of kies een andere locatie.';

  @override
  String get notice_tlsFailed_title => 'Beveiligde verbinding geweigerd';

  @override
  String get notice_tlsFailed_message =>
      'De server heeft de OpenVPN-verbinding niet geaccepteerd. Probeer het opnieuw. Als het probleem blijft bestaan, voer dan een diagnose uit.';

  @override
  String get notice_tunRejected_title =>
      'Android heeft de VPN-interface geweigerd';

  @override
  String get notice_tunRejected_message =>
      'Android heeft de door OpenVPN aangevraagde netwerkconfiguratie geweigerd.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN kon niet starten';

  @override
  String get notice_openvpnStart_message =>
      'De OpenVPN-engine kon het opstarten niet voltooien. Probeer het opnieuw. Als het probleem blijft bestaan, neem dan contact op met de ondersteuning.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnosecode: $code';
  }

  @override
  String get notice_generic_title => 'VPN-verbinding mislukt';

  @override
  String get notice_generic_message =>
      'Er is een fout opgetreden. Probeer het later opnieuw.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Account aangemaakt',
      'password_reset_sent':
          'Aanvraag voor opnieuw instellen van wachtwoord ontvangen',
      'verification_email_sent': 'Verificatie-e-mail verzonden',
      'location_migration_pending': 'Locatiewijziging wordt uitgevoerd',
      'vpn_sign_in_required': 'Aanmelden vereist',
      'protocol_unavailable_at_location': 'Protocol niet beschikbaar',
      'vpn_permission_denied': 'VPN-toestemming geweigerd',
      'revoked_identity_device_limit': 'Limiet van 2 apparaten bereikt',
      'tunnel_start_unexpected': 'VPN kon niet starten',
      'flutter_disconnect_timeout': 'Verbreking niet bevestigd',
      'flutter_disconnect_unexpected': 'Verbinding kon niet worden verbroken',
      'device_revoked': 'Apparaat verwijderd',
      'revoke_unexpected': 'Apparaat kon niet worden verwijderd',
      'identity_renewal_unexpected': 'Identiteit kon niet worden vernieuwd',
      'openvpn_renewal_unexpected': 'OpenVPN kon niet worden vernieuwd',
      'location_migration_blocked': 'Locatiewijziging geblokkeerd',
      'location_migration_slow': 'Locatiewijziging nog steeds bezig',
      'location_migration_conflict': 'Locatiewijziging moet worden vernieuwd',
      'location_migration_verification_failed':
          'Locatiewijziging niet bevestigd',
      'location_migration_device_changed':
          'Apparaat gewijzigd tijdens locatiewijziging',
      'tunnel_stop_failed': 'Locatiewijziging niet beschikbaar',
      'other': 'Bewerking mislukt',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Het account is aangemaakt, maar de verificatie-e-mail kon niet worden verzonden. Gebruik Opnieuw verzenden in de app.',
      'password_reset_sent':
          'Je aanvraag is ontvangen. Als er een account bij dit adres hoort, ontvang je mogelijk een e-mail. Controleer ook je spammap.',
      'verification_email_sent':
          'Er is zojuist een nieuwe verificatie-e-mail verzonden.',
      'location_migration_pending':
          'De verplaatsing naar $target wordt nog voorbereid. Je kunt deze hervatten zonder het apparaat opnieuw aan te maken.',
      'vpn_sign_in_required':
          'Meld je aan bij je account voordat je de VPN start.',
      'protocol_unavailable_at_location':
          'Het geselecteerde protocol wordt niet aangeboden op deze locatie. Vernieuw de locaties of kies een ander protocol.',
      'vpn_permission_denied':
          'Android heeft de VPN-toestemming geweigerd. Start de verbinding opnieuw en accepteer het systeemverzoek.',
      'revoked_identity_device_limit':
          'De VPN-toegang van dit apparaat is verwijderd en de apparaatlimiet is bereikt. Verwijder een apparaat via Account → Mijn apparaten beheren.',
      'tunnel_start_unexpected':
          'Een onverwachte fout heeft de voorbereiding van de tunnel onderbroken. Controleer de diagnosecode en probeer het opnieuw.',
      'flutter_disconnect_timeout':
          'Android heeft niet op tijd bevestigd dat de VPN is gestopt. Probeer deze opnieuw te stoppen.',
      'flutter_disconnect_unexpected':
          'Een onverwachte fout verhinderde de bevestiging dat de tunnel is gestopt.',
      'device_revoked':
          'De VPN-toegang van het apparaat is ingetrokken en de lokale geheimen zijn verwijderd.',
      'revoke_unexpected':
          'Het apparaat kon niet worden verwijderd. Vernieuw de lijst en probeer het opnieuw.',
      'identity_renewal_unexpected':
          'De nieuwe VPN-identiteit kon niet worden aangemaakt. Vernieuw de apparaten en probeer het opnieuw.',
      'openvpn_renewal_unexpected':
          'Het OpenVPN-profiel kon niet worden vernieuwd. Probeer het opnieuw of controleer de diagnosecode.',
      'location_migration_blocked':
          'De server kan deze wijziging momenteel niet voltooien. Het apparaat en de lokale identiteit zijn behouden.',
      'location_migration_slow':
          'De server bereidt de verplaatsing naar $target nog steeds voor. Gebruik Hervatten over enkele ogenblikken.',
      'location_migration_conflict':
          'De apparaatstatus is op de server gewijzigd. Vernieuw de apparaten en hervat daarna de wijziging.',
      'location_migration_verification_failed':
          'De server heeft de nieuwe locatie niet bevestigd. De vorige lokale identiteit is behouden.',
      'location_migration_device_changed':
          'Het apparaat dat door de server is teruggegeven, komt niet meer overeen met het apparaat dat wordt gewijzigd. Vernieuw de apparaten voordat je het opnieuw probeert.',
      'tunnel_stop_failed':
          'De vorige tunnel moet volledig zijn gestopt voordat de nieuwe verbinding wordt gemaakt.',
      'other':
          'De bewerking kon niet worden voltooid. Probeer het opnieuw of stuur de diagnosecode naar de ondersteuning.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessie verlopen',
      'invalid_credentials': 'Aanmelden mislukt',
      'email_verification_required': 'E-mailbevestiging vereist',
      'verification_email_cooldown': 'E-mail al verzonden',
      'rate_limited': 'Te veel pogingen',
      'invalid_registration': 'Gegevens moeten worden gecorrigeerd',
      'email_exists': 'Account bestaat al',
      'invalid_profile': 'Ongeldig profiel',
      'invalid_device': 'Ongeldig apparaat',
      'invalid_location': 'Locatie niet beschikbaar',
      'device_limit': 'Apparaatlimiet bereikt',
      'device_exists': 'VPN-identiteit al in gebruik',
      'device_identity_revoked': 'VPN-identiteit moet worden vernieuwd',
      'device_location_locked': 'Locatiewijziging moet worden vernieuwd',
      'location_migration_pending': 'Locatiewijziging wordt uitgevoerd',
      'location_migration_blocked': 'Locatiewijziging geblokkeerd',
      'target_ca_mismatch': 'Incompatibele OpenVPN-server',
      'location_migration_conflict': 'Locatiewijziging moet worden vernieuwd',
      'server_full': 'Server vol',
      'capacity_unavailable': 'Locatie tijdelijk niet beschikbaar',
      'target_unavailable': 'Server tijdelijk niet beschikbaar',
      'not_found': 'Item niet gevonden',
      'invalid_openvpn_csr': 'Ongeldige OpenVPN-identiteit',
      'openvpn_profile_exists': 'OpenVPN-profiel bestaat al',
      'openvpn_profile_revoked': 'OpenVPN-profiel ingetrokken',
      'openvpn_operation_pending': 'OpenVPN-bewerking wordt uitgevoerd',
      'openvpn_operation_terminal': 'OpenVPN-bewerking onderbroken',
      'openvpn_address_unavailable': 'OpenVPN-adres niet beschikbaar',
      'openvpn_profile_conflict': 'OpenVPN-conflict',
      'openvpn_signer_unavailable': 'OpenVPN niet beschikbaar',
      'email_delivery_unavailable': 'E-mail niet beschikbaar',
      'invalid_token': 'Ongeldige link',
      'network_unavailable': 'Internetverbinding niet beschikbaar',
      'invalid_json': 'Ongeldig verzoek',
      'invalid_api_response': 'Ongeldig serverantwoord',
      'ipv6_unavailable': 'IPv6 niet beschikbaar',
      'invalid_ip_families': 'Netwerkconfiguratie geweigerd',
      'other': 'Service niet beschikbaar',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Je sessie is verlopen. Meld je opnieuw aan.',
      'invalid_credentials': 'Het e-mailadres of wachtwoord is onjuist.',
      'email_verification_required':
          'Bevestig je e-mailadres voordat je een VPN-apparaat toevoegt.',
      'invalid_registration':
          'Controleer de gevraagde gegevens en toestemmingen.',
      'email_exists': 'Er is al een account met dit e-mailadres.',
      'invalid_profile': 'Controleer je profielgegevens.',
      'invalid_device':
          'De naam of lokale identiteit van dit apparaat is ongeldig.',
      'invalid_location': 'Vernieuw de locatielijst en probeer het opnieuw.',
      'device_limit':
          'Verwijder een bestaand apparaat voordat je een ander apparaat toevoegt.',
      'device_exists':
          'Deze VPN-identiteit is al aan een ander account gekoppeld.',
      'device_identity_revoked':
          'Deze identiteit is verwijderd. Er moet een nieuwe lokale identiteit worden aangemaakt.',
      'device_location_locked':
          'De locatie van dit apparaat is zojuist gewijzigd. De app hervat de lopende wijziging.',
      'location_migration_pending':
          'Er wordt al een locatiewijziging uitgevoerd.',
      'location_migration_blocked':
          'Voor de locatiewijziging is ingrijpen op de server nodig. Probeer het later opnieuw of neem contact op met de ondersteuning.',
      'target_ca_mismatch':
          'Deze server is nog niet compatibel met het huidige OpenVPN-profiel.',
      'location_migration_conflict':
          'Vernieuw de apparaten en probeer de locatiewijziging daarna opnieuw.',
      'server_full':
          'Deze locatie heeft de verbindingslimiet bereikt. Kies een andere locatie of probeer het later opnieuw.',
      'capacity_unavailable':
          'We kunnen momenteel niet bevestigen of deze locatie beschikbaar is. Kies een andere locatie of probeer het later opnieuw.',
      'target_unavailable': 'Deze server is tijdelijk niet beschikbaar.',
      'not_found': 'Dit item is niet langer beschikbaar in je account.',
      'invalid_openvpn_csr':
          'Maak een nieuwe OpenVPN-identiteit aan en probeer het opnieuw.',
      'openvpn_profile_exists':
          'Er bestaat al een OpenVPN-profiel voor dit apparaat.',
      'openvpn_profile_revoked':
          'Vernieuw het OpenVPN-profiel om door te gaan.',
      'openvpn_operation_pending':
          'De wijziging wordt nog doorgevoerd. Probeer het later opnieuw.',
      'openvpn_operation_terminal':
          'Maak een nieuwe OpenVPN-identiteit aan en probeer het opnieuw.',
      'openvpn_address_unavailable':
          'Er is momenteel geen OpenVPN-adres beschikbaar.',
      'openvpn_profile_conflict':
          'Het profiel is gewijzigd. Vernieuw de apparaten en probeer het opnieuw.',
      'openvpn_signer_unavailable':
          'De OpenVPN-service is tijdelijk niet beschikbaar.',
      'email_delivery_unavailable':
          'De e-mail kon niet worden verzonden. Probeer het later opnieuw.',
      'invalid_token':
          'Deze link is ongeldig of verlopen. Vraag een nieuwe link aan.',
      'network_unavailable':
          'Controleer je internetverbinding en probeer het opnieuw.',
      'invalid_json':
          'Controleer de ingevoerde gegevens en probeer het opnieuw.',
      'invalid_api_response':
          'De server gaf een onverwacht antwoord. Probeer het later opnieuw.',
      'ipv6_unavailable':
          'De server kan IPv6 momenteel niet activeren. Probeer het later opnieuw.',
      'invalid_ip_families':
          'De tunnelconfiguratie is onvolledig of komt niet overeen met de geautoriseerde adressen. Probeer het opnieuw vanuit de app.',
      'other': 'Er is een serverfout opgetreden. Probeer het later opnieuw.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater =>
      'Probeer het over enkele ogenblikken opnieuw.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Probeer het over $seconds seconden opnieuw.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Hervatten van systeem-VPN niet beschikbaar',
      'system_vpn_resume_corrupt': 'Ongeldig hervatten van systeem-VPN',
      'system_vpn_resume_session_invalid':
          'Ongeldige VPN-sessie voor hervatten',
      'system_vpn_resume_identity_changed': 'VPN-identiteit gewijzigd',
      'system_vpn_resume_identity_invalid':
          'Ongeldige VPN-identiteit voor hervatten',
      'system_vpn_resume_storage_failed':
          'Opslag voor hervatten van VPN niet beschikbaar',
      'system_vpn_resume_network_timeout':
          'Hervatten van VPN heeft geen netwerk',
      'system_vpn_resume_blocked': 'Hervatten van VPN geblokkeerd',
      'system_vpn_resume_failed': 'Hervatten van VPN mislukt',
      'system_vpn_resume_error_invalid': 'Ongeldige fout bij hervatten van VPN',
      'wireguard_identity_store_failed': 'WireGuard-identiteit niet opgeslagen',
      'wireguard_identity_unavailable': 'WireGuard-identiteit niet beschikbaar',
      'vpn_host_destroyed': 'Android-VPN-host gestopt',
      'vpn_host_unavailable': 'Android-VPN-host niet beschikbaar',
      'vpn_permission_required': 'VPN-toestemming vereist',
      'vpn_permission_denied': 'VPN-toestemming geweigerd',
      'vpn_permission_request_failed':
          'Toestemming kon niet worden aangevraagd',
      'wireguard_foreground_service_unavailable':
          'WireGuard-service niet beschikbaar',
      'wireguard_identity_invalid': 'Ongeldige lokale WireGuard-sleutel',
      'wireguard_identity_in_use': 'WireGuard-identiteit al in gebruik',
      'wireguard_configuration_invalid': 'Ongeldige WireGuard-configuratie',
      'wireguard_operation_pending': 'WireGuard-bewerking nog actief',
      'wireguard_start_failed': 'Start van WireGuard geweigerd',
      'wireguard_stop_timeout': 'Stoppen van WireGuard niet bevestigd',
      'wireguard_handshake_timeout': 'WireGuard reageerde niet',
      'openvpn_connection_timeout': 'OpenVPN reageerde niet',
      'openvpn_core_unavailable': 'OpenVPN-engine niet beschikbaar',
      'openvpn_operation_pending': 'OpenVPN-sessie nog actief',
      'openvpn_stop_timeout': 'Stoppen van OpenVPN niet bevestigd',
      'openvpn_profile_unavailable': 'Lokaal OpenVPN-profiel ontbreekt',
      'openvpn_native_failed': 'Native OpenVPN-aanroep onderbroken',
      'openvpn_key_generation_failed':
          'OpenVPN P-256-sleutel kon niet worden aangemaakt',
      'openvpn_csr_generation_failed': 'OpenVPN-CSR kon niet worden aangemaakt',
      'openvpn_identity_store_failed': 'OpenVPN-identiteit niet opgeslagen',
      'openvpn_identity_clear_failed': 'OpenVPN-verwijdering onvolledig',
      'openvpn_identity_in_use': 'OpenVPN-identiteit nog in gebruik',
      'openvpn_tls_verification_required': 'OpenVPN TLS-verificatie ontbreekt',
      'openvpn_cipher_invalid': 'Ongeldige OpenVPN-versleuteling',
      'openvpn_profile_rejected': 'OpenVPN-profiel geweigerd',
      'openvpn_identity_inconsistent': 'Inconsistente OpenVPN-identiteit',
      'tls_handshake_failed': 'OpenVPN-onderhandeling geweigerd',
      'tls_alert_unknown_ca': 'OpenVPN-clientcertificaat niet herkend',
      'tls_alert_bad_certificate': 'OpenVPN-clientcertificaat geweigerd',
      'tls_alert_unsupported_certificate':
          'Niet-ondersteund OpenVPN-certificaat',
      'tls_client_certificate_required': 'OpenVPN-clientcertificaat vereist',
      'tls_alert_misc': 'OpenVPN TLS-melding',
      'tls_signature_algorithm_rejected':
          'Niet-ondersteunde OpenVPN-handtekening',
      'tls_handshake_rejected': 'OpenVPN TLS-onderhandeling geweigerd',
      'tls_version_rejected': 'Incompatibele OpenVPN TLS-versie',
      'tls_certificate_expired': 'TLS-certificaat verlopen',
      'tls_certificate_revoked': 'TLS-certificaat ingetrokken',
      'transport_failed': 'OpenVPN-server onbereikbaar',
      'tun_configuration_rejected':
          'OpenVPN-interface kon niet worden aangemaakt',
      'tun_setup_failed': 'OpenVPN TUN-configuratie mislukt',
      'tun_interface_create_failed': 'Aanmaken van OpenVPN-interface mislukt',
      'tun_interface_disabled': 'OpenVPN-interface uitgeschakeld',
      'tun_halted': 'OpenVPN-interface onderbroken',
      'tun_already_established': 'OpenVPN-interface al geopend',
      'tun_addresses_missing': 'OpenVPN-adres ontbreekt',
      'tun_routes_missing': 'OpenVPN-routes ontbreken',
      'tun_dns_missing': 'OpenVPN-DNS ontbreekt',
      'tun_permission_revoked': 'VPN-toestemming ingetrokken',
      'tun_establish_returned_null': 'Android heeft de VPN-interface geweigerd',
      'openvpn_service_start_failed': 'OpenVPN-service niet beschikbaar',
      'openvpn_operation_timeout': 'Time-out bij OpenVPN-aanroep',
      'openvpn_start_failed': 'Start van OpenVPN geweigerd',
      'openvpn_connection_failed': 'OpenVPN-verbinding onderbroken',
      'openvpn_core_status_error': 'OpenVPN Core is met een fout beëindigd',
      'openvpn_stopped_before_connected':
          'OpenVPN gestopt voordat verbinding was gemaakt',
      'openvpn_auth_failed': 'OpenVPN-authenticatie geweigerd',
      'openvpn_client_setup_failed': 'OpenVPN-clientconfiguratie mislukt',
      'openvpn_client_halted': 'OpenVPN-client onderbroken',
      'openvpn_client_restart': 'Herstart van OpenVPN aangevraagd',
      'openvpn_inactive_timeout': 'OpenVPN te lang inactief',
      'openvpn_session_expired': 'OpenVPN-sessie verlopen',
      'openvpn_credentials_required': 'Niet-ondersteunde OpenVPN-authenticatie',
      'openvpn_proxy_failed': 'Transport via OpenVPN-tussenpersoon mislukt',
      'openvpn_compression_failed': 'OpenVPN-compressie geweigerd',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM-versleuteling niet beschikbaar',
      'openvpn_feature_unsupported': 'Niet-ondersteunde OpenVPN-functie',
      'network_unavailable': 'Internetverbinding niet beschikbaar',
      'network_lost': 'Netwerk niet beschikbaar',
      'certificate_validation_failed': 'Servercertificaat geweigerd',
      'openvpn_certificate_expired': 'OpenVPN-certificaat verlopen',
      'tunnel_active_for_another_account':
          'Tunnel van een ander account nog actief',
      'tunnel_already_active': 'Native tunnel al actief',
      'tunnel_stop_timeout': 'Stoppen van $protocol niet bevestigd',
      'tunnel_disconnected': '$protocol onderbroken',
      'native_bridge_unavailable': 'Android-bridge niet beschikbaar',
      'native_operation_failed': 'Android-bewerking onderbroken',
      'invalid_arguments': 'Onvolledige VPN-parameters',
      'invalid_account_id': 'Ongeldig VPN-account',
      'invalid_device_id': 'Ongeldige apparaat-ID',
      'storage_key_not_allowed': 'Opslagsleutel geweigerd',
      'secure_storage_read_failed': 'Beveiligd lezen mislukt',
      'secure_storage_write_failed': 'Beveiligd schrijven mislukt',
      'key_generation_failed': 'WireGuard-sleutel kon niet worden gegenereerd',
      'csr_generation_failed': 'OpenVPN-CSR kon niet worden gegenereerd',
      'other': 'Niet-geclassificeerde native VPN-fout',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android kan geen hervatbare VPN-sessie vinden. Start een nieuwe verbinding in de app.',
      'system_vpn_resume_corrupt':
          'De opgeslagen VPN-gegevens voor hervatten zijn ongeldig en worden niet gebruikt. Start een nieuwe verbinding.',
      'system_vpn_resume_session_invalid':
          'De opgeslagen sessie kan de VPN niet meer hervatten. Meld je opnieuw aan in de app.',
      'system_vpn_resume_identity_changed':
          'De lokale VPN-identiteit is gewijzigd. Hervatten is gestopt; start een nieuwe verbinding.',
      'system_vpn_resume_identity_invalid':
          'De identiteit voor hervatten is ongeldig. Start een nieuwe verbinding.',
      'system_vpn_resume_storage_failed':
          'Android kon de versleutelde gegevens voor hervatten niet lezen of bijwerken. Start een nieuwe verbinding.',
      'system_vpn_resume_network_timeout':
          'Android heeft niet op tijd een netwerk gevonden om de VPN te hervatten. Probeer het opnieuw wanneer er een netwerk beschikbaar is.',
      'system_vpn_resume_blocked':
          'Hervatten van de VPN is geblokkeerd. Controleer de Android-instellingen en start daarna een nieuwe verbinding.',
      'system_vpn_resume_failed':
          'Hervatten van de Android-VPN is mislukt. Start een nieuwe verbinding in de app.',
      'system_vpn_resume_error_invalid':
          'Android gaf een onbruikbare fout bij het hervatten terug. Start een nieuwe verbinding.',
      'wireguard_identity_store_failed':
          'Android kon de versleutelde WireGuard-identiteit van dit account niet opslaan.',
      'wireguard_identity_unavailable':
          'Er is geen bruikbare WireGuard-identiteit beschikbaar voor deze verbinding.',
      'vpn_host_destroyed':
          'Het Android-component dat de VPN hostte, is gestopt. Start een nieuwe verbinding.',
      'vpn_host_unavailable':
          'Android kan het component dat de VPN host niet aanmaken. Probeer het opnieuw nadat je de VPN-instellingen hebt gecontroleerd.',
      'openvpn_renewal_required':
          'Het certificaat vereist een handeling in de app voordat je verbinding maakt.',
      'openvpn_recovery_failed':
          'Automatisch herstel mislukt. Start een nieuwe verbinding in de app.',
      'openvpn_recovery_exhausted':
          'Automatisch herstel is al gebruikt. Start een nieuwe verbinding in de app.',
      'vpn_permission_required':
          'Android vereist nieuwe VPN-autorisatie voordat de tunnel wordt gestart.',
      'vpn_permission_denied':
          'Sta FuzeVPN toe in het Android-verzoek om door te gaan.',
      'vpn_permission_request_failed':
          'Android kon het VPN-toestemmingsscherm niet openen.',
      'wireguard_foreground_service_unavailable':
          'Android kon de WireGuard-service niet op de voorgrond houden.',
      'wireguard_identity_invalid':
          'De versleutelde WireGuard-sleutel van dit account is onleesbaar of ongeldig.',
      'wireguard_identity_in_use':
          'Een andere bewerking gebruikt de WireGuard-sleutel van dit account nog.',
      'wireguard_configuration_invalid':
          'Het ontvangen WireGuard-adres, de DNS, serversleutel of routes zijn ongeldig.',
      'wireguard_operation_pending':
          'De vorige WireGuard-bewerking heeft de native service nog niet vrijgegeven.',
      'wireguard_start_failed':
          'De WireGuard-engine heeft activering van de configuratie geweigerd.',
      'wireguard_stop_timeout':
          'De WireGuard-service heeft niet binnen de tijdslimiet bevestigd dat de VPN-interface is vrijgegeven.',
      'wireguard_handshake_timeout':
          'De tunnel heeft niet op tijd bevestigd dat er een handshake met de server is uitgevoerd.',
      'openvpn_connection_timeout':
          'OpenVPN heeft niet op tijd bevestigd dat er verbinding met de server is gemaakt.',
      'openvpn_core_unavailable':
          'Deze app-versie bevat geen bruikbare OpenVPN-engine.',
      'openvpn_operation_pending':
          'De native engine houdt de vorige OpenVPN-sessie nog vast en weigert een tweede sessie aan te maken.',
      'openvpn_stop_timeout':
          'OpenVPN Core heeft niet binnen de tijdslimiet bevestigd dat de native sessie is gestopt en vernietigd.',
      'openvpn_profile_unavailable':
          'Er kan geen gevalideerd OpenVPN-profiel voor deze verbinding worden gelezen.',
      'openvpn_native_failed':
          'Een app-fout heeft OpenVPN onderbroken. Probeer opnieuw verbinding te maken. Als het probleem blijft bestaan, voer dan een diagnose uit.',
      'openvpn_key_generation_failed':
          'Android Keystore kon de niet-exporteerbare P-256-privésleutel niet aanmaken of lezen.',
      'openvpn_csr_generation_failed':
          'De Android Keystore-sleutel kon de OpenVPN-certificaataanvraag niet ondertekenen.',
      'openvpn_identity_store_failed':
          'Het OpenVPN-certificaat of -profiel kon niet in versleutelde opslag worden opgeslagen.',
      'openvpn_identity_clear_failed':
          'Android kon de volledige lokale OpenVPN-identiteit voor dit account niet verwijderen.',
      'openvpn_identity_in_use':
          'Een native OpenVPN-sessie gebruikt de sleutel of het certificaat van dit apparaat nog.',
      'openvpn_tls_verification_required':
          'Het profiel vereist niet expliciet verificatie van het servercertificaat.',
      'openvpn_cipher_invalid':
          'De server leverde een versleutelingsalgoritme dat niet in de toegestane lijst staat.',
      'openvpn_profile_rejected':
          'Het van de server ontvangen profiel is incompatibel. Maak dit apparaat opnieuw aan en probeer het opnieuw.',
      'openvpn_identity_inconsistent':
          'Het certificaat komt niet overeen met de beveiligde identiteit van deze telefoon. Geen lokaal profiel is vervangen.',
      'tls_handshake_failed':
          'De server heeft de TLS-onderhandeling geweigerd. Maak het profiel opnieuw aan als het probleem blijft bestaan.',
      'tls_alert_unknown_ca':
          'De server herkent de certificaatautoriteit van dit apparaat niet. De OpenVPN-server moet worden gecontroleerd.',
      'tls_alert_bad_certificate':
          'De server heeft dit apparaatcertificaat geweigerd. Maak het apparaat opnieuw aan voordat je het opnieuw probeert.',
      'tls_alert_unsupported_certificate':
          'De server ondersteunt het beveiligde certificaattype dat Android gebruikt niet.',
      'tls_client_certificate_required':
          'De server vereist een clientcertificaat, maar OpenVPN Core kon er geen aanbieden.',
      'tls_alert_misc':
          'De server gaf een TLS-melding buiten de categorieën certificaat en versie terug.',
      'tls_signature_algorithm_rejected':
          'De server heeft het ECDSA P-256-algoritme van de Android Keystore-sleutel geweigerd.',
      'tls_handshake_rejected':
          'De server heeft de TLS-onderhandeling vóór de verbinding onderbroken.',
      'tls_version_rejected':
          'De client en server konden geen gemeenschappelijke TLS-versie vinden.',
      'tls_certificate_expired':
          'Het certificaat dat tijdens de verbinding werd aangeboden, is verlopen.',
      'tls_certificate_revoked':
          'Het certificaat dat tijdens de verbinding werd aangeboden, is ingetrokken.',
      'transport_failed':
          'De OpenVPN-server reageert niet op het huidige netwerk. Probeer het zo opnieuw.',
      'tun_configuration_rejected':
          'Android heeft de door OpenVPN aangevraagde netwerkconfiguratie geweigerd.',
      'tun_setup_failed':
          'OpenVPN Core heeft het netwerkplan geweigerd voordat de Android-interface werd aangemaakt.',
      'tun_interface_create_failed':
          'OpenVPN Core kon de TUN-interface niet verkrijgen van Android VpnService.',
      'tun_interface_disabled':
          'Android of OpenVPN Core heeft de TUN-interface tijdens de verbinding uitgeschakeld.',
      'tun_halted':
          'OpenVPN Core heeft een verzoek ontvangen om de TUN-interface te stoppen.',
      'tun_already_established':
          'OpenVPN vroeg om een tweede interface binnen dezelfde verbinding. De tunnel is om veiligheidsredenen gestopt.',
      'tun_addresses_missing':
          'De server heeft geen bruikbaar tunneladres verstrekt.',
      'tun_routes_missing':
          'De server heeft geen bruikbare tunnelroutes verstrekt.',
      'tun_dns_missing': 'De server heeft geen bruikbare DNS-server verstrekt.',
      'tun_permission_revoked':
          'Android heeft de VPN-toestemming tijdens de verbinding ingetrokken.',
      'tun_establish_returned_null':
          'Android heeft de interface niet aangemaakt, meestal omdat er nog een andere VPN actief is.',
      'openvpn_service_start_failed':
          'Android kon de OpenVPN-service op de voorgrond niet starten.',
      'openvpn_operation_timeout':
          'Een JNI-aanroep naar OpenVPN Core overschreed de maximale duur.',
      'openvpn_start_failed':
          'De Android-service is klaar, maar OpenVPN Core accepteerde het starten van het profiel niet.',
      'openvpn_connection_failed':
          'OpenVPN Core is gestopt voordat de gebeurtenis CONNECTED werd uitgegeven.',
      'openvpn_core_status_error':
          'De native OpenVPN-lus eindigde met een fout zonder specifiekere eindgebeurtenis.',
      'openvpn_stopped_before_connected':
          'De native OpenVPN-lus stopte vóór CONNECTED, zonder expliciete Core-fout.',
      'openvpn_auth_failed':
          'De OpenVPN-server heeft de profielauthenticatie geweigerd.',
      'openvpn_client_setup_failed':
          'OpenVPN Core kon de client niet initialiseren vóór de netwerkverbinding.',
      'openvpn_client_halted':
          'OpenVPN Core heeft een definitieve clientstop ontvangen.',
      'openvpn_client_restart':
          'OpenVPN Core vroeg om een herstart van de transportsessie.',
      'openvpn_inactive_timeout':
          'OpenVPN Core heeft de sessie gesloten na de time-out wegens inactiviteit.',
      'openvpn_session_expired':
          'De server meldde dat de OpenVPN-sessie is verlopen.',
      'openvpn_credentials_required':
          'De server of een proxy vraagt interactieve inloggegevens die geen deel uitmaken van dit certificaatprofiel.',
      'openvpn_proxy_failed':
          'OpenVPN Core meldde een fout in de geconfigureerde proxy of relay.',
      'openvpn_compression_failed':
          'OpenVPN Core heeft de compressiemodus die door het profiel of de server is aangekondigd geweigerd.',
      'openvpn_ntlm_crypto_unavailable':
          'Het profiel vraagt NTLM-versleuteling die in deze versie niet beschikbaar is.',
      'openvpn_feature_unsupported':
          'Het profiel of de server vereist een functie die in deze Android-client ontbreekt.',
      'network_unavailable': 'Er is geen bruikbaar fysiek netwerk beschikbaar.',
      'network_lost': 'De tunnel is gestopt nadat het netwerk verloren ging.',
      'certificate_validation_failed':
          'De identiteit van de OpenVPN-server kon niet worden geverifieerd.',
      'openvpn_certificate_expired':
          'Vernieuw het OpenVPN-profiel voordat je opnieuw verbinding maakt.',
      'tunnel_active_for_another_account':
          'Een tunnel van een ander account moet stoppen voordat deze verbinding kan worden gemaakt.',
      'tunnel_already_active':
          'Android meldt dat een vorige VPN-sessie de interface nog gebruikt.',
      'tunnel_stop_timeout':
          'De $protocol-engine heeft niet binnen de tijdslimiet bevestigd dat de VPN-interface is vrijgegeven.',
      'tunnel_disconnected':
          'De native engine meldde dat de tunnel na het starten onverwacht is beëindigd.',
      'native_bridge_unavailable':
          'De app heeft geen toegang tot de Android-VPN-service. Sluit de app en open deze opnieuw; probeer het daarna opnieuw.',
      'native_operation_failed':
          'Een app-fout heeft de VPN-bewerking onderbroken. Probeer het opnieuw. Als het probleem blijft bestaan, voer dan een diagnose uit.',
      'invalid_arguments':
          'De informatie die voor deze VPN-bewerking nodig is, is onvolledig. Probeer het opnieuw. Als het probleem blijft bestaan, voer dan een diagnose uit.',
      'invalid_account_id':
          'De native bewerking is niet gekoppeld aan een geldige account-ID.',
      'invalid_device_id':
          'De naar de native engine verzonden apparaat-ID ontbreekt of is ongeldig.',
      'storage_key_not_allowed':
          'De Android-bridge blokkeerde een sleutel buiten de toegestane lijst met opslagsleutels.',
      'secure_storage_read_failed':
          'Android Keystore kon de lokale gegevens van dit account niet ontsleutelen.',
      'secure_storage_write_failed':
          'Android Keystore kon de lokale gegevens niet versleutelen of opslaan.',
      'key_generation_failed':
          'Android kon de WireGuard-sleutel niet aanmaken of uit de beveiligde opslag lezen.',
      'csr_generation_failed':
          'Android Keystore kon de OpenVPN P-256-CSR niet aanmaken of ondertekenen.',
      'other':
          'Een niet-gedocumenteerde native tak is mislukt. Stuur de hieronder weergegeven diagnosecode naar de ondersteuning.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Toestemmingsverzoek al geopend';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Het Android-VPN-toestemmingsverzoek wordt al weergegeven. Rond dit eerst af voordat je het opnieuw probeert.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-toestemmingsverzoek onderbroken';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Het VPN-toestemmingsscherm is gesloten voordat de app een antwoord ontving.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-verbinding niet bevestigd';

  @override
  String get notice_openvpnProofMissing_message =>
      'De OpenVPN-verbinding kon niet worden bevestigd. Om veiligheidsredenen is deze gestopt. Probeer het opnieuw.';

  @override
  String get openvpnCleanup_title => 'OpenVPN-profiel ingetrokken';

  @override
  String get openvpnCleanup_working =>
      'Ingetrokken OpenVPN-profiel stoppen en verwijderen…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Het afsluiten van OpenVPN is niet bevestigd. Probeer het opnieuw voordat je een nieuw profiel aanmaakt.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Het ingetrokken OpenVPN-profiel kon niet volledig worden verwijderd. Probeer het opschonen opnieuw.';

  @override
  String get openvpnCleanup_complete =>
      'Het ingetrokken OpenVPN-profiel is verwijderd. Tik op Verbinden om een nieuw profiel aan te maken.';

  @override
  String get network_title => 'Netwerkconfiguratie';

  @override
  String get network_ipv4Fallback =>
      'IPv6 is tijdelijk niet beschikbaar. De voorbereiding gaat verder met IPv4.';

  @override
  String get network_rejectedTitle => 'Netwerkconfiguratie geweigerd';

  @override
  String get network_rejectedMessage =>
      'De tunnelconfiguratie is onvolledig of komt niet overeen met de geautoriseerde adressen. Probeer het opnieuw vanuit de app.';

  @override
  String get network_unreadableTitle => 'Lokale configuratie onleesbaar';

  @override
  String get network_unreadableMessage =>
      'De opgeslagen OpenVPN-netwerkconfiguratie kan niet worden gebruikt. Maak vanuit de app opnieuw verbinding om deze bij te werken.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Netwerkbeveiliging';

  @override
  String get protection_subtitle =>
      'Blokkeer directe internettoegang als de VPN-verbinding wordt verbroken.';

  @override
  String get protection_active => 'Systeembeveiliging actief';

  @override
  String get protection_alwaysOnOnly =>
      'Altijd ingeschakelde VPN actief; schakel blokkeren buiten de VPN in';

  @override
  String get protection_inactive => 'Systeembeveiliging inactief';

  @override
  String get protection_unknown => 'Systeembeveiliging controleren';

  @override
  String get protection_openSettings => 'Android-instellingen openen';

  @override
  String get protection_dialogTitle => 'Netwerkbeveiliging instellen';

  @override
  String get protection_dialogMessage =>
      'Android beheert de altijd ingeschakelde VPN en het blokkeren van verbindingen buiten de VPN. Controleer of FuzeVPN is geselecteerd en schakel blokkeren in via de systeeminstellingen.';

  @override
  String get protection_dialogOpen => 'Instellingen openen';

  @override
  String get session_systemProtectionNote =>
      'Als Android verkeer buiten de VPN nog steeds blokkeert, open dan de systeeminstellingen om deze beveiliging te controleren of te wijzigen.';

  @override
  String get diagnostics_title => 'Diagnose';

  @override
  String get diagnostics_settingsTitle => 'App-diagnose';

  @override
  String get diagnostics_automaticTitle => 'Belangrijke fouten verzenden';

  @override
  String get diagnostics_automaticDescription =>
      'Deel een klein technisch rapport wanneer er een belangrijke fout optreedt.';

  @override
  String get diagnostics_privacy =>
      'Verzonden rapporten zijn gekoppeld aan het aangemelde account en worden 30 dagen bewaard. Ze bevatten geen browsegeschiedenis, wachtwoorden of VPN-sleutels.';

  @override
  String get diagnostics_manualOpen => 'Diagnose uitvoeren';

  @override
  String get diagnostics_localDescription =>
      'Maak een rapport van de app- en VPN-status. Je verbinding blijft ongewijzigd.';

  @override
  String get diagnostics_sendReport => 'Rapport verzenden';

  @override
  String get diagnostics_sendHint =>
      'Laat dit vakje uitgeschakeld om het rapport op dit apparaat te bewaren.';

  @override
  String get diagnostics_signedOut =>
      'Meld je aan bij je account om een rapport te verzenden.';

  @override
  String get diagnostics_localLifetime =>
      'Sla dit rapport op je telefoon op om het te bewaren nadat je de app hebt gesloten.';

  @override
  String get diagnostics_run => 'Diagnose uitvoeren';

  @override
  String get diagnostics_rerun => 'Diagnose opnieuw uitvoeren';

  @override
  String get diagnostics_running => 'Controleren…';

  @override
  String get diagnostics_sending => 'Rapport verzenden…';

  @override
  String get diagnostics_prepared => 'Rapport klaar op dit apparaat';

  @override
  String get diagnostics_queued => 'Rapport wacht om te worden verzonden';

  @override
  String get diagnostics_sent => 'Rapport ontvangen';

  @override
  String get diagnostics_failed =>
      'Verzenden mislukt. Je lokale rapport is nog beschikbaar.';

  @override
  String get diagnostics_preparationFailed =>
      'Het diagnoserapport kon niet worden voorbereid. Probeer het opnieuw.';

  @override
  String get diagnostics_authenticationRequired =>
      'Meld je opnieuw aan om het rapport te verzenden.';

  @override
  String get diagnostics_retry => 'Verzenden opnieuw proberen';

  @override
  String get diagnostics_export => 'Rapport opslaan';

  @override
  String get diagnostics_exportFailed =>
      'Exporteren mislukt. Probeer het opnieuw vanuit het lokale rapport.';

  @override
  String get diagnostics_preferenceFailed =>
      'Deze instelling kon niet worden opgeslagen. Probeer het opnieuw.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referentie: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Ontvangen op $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Bewaard tot $date';
  }

  @override
  String get diagnostics_duplicate => 'Dit rapport was al ontvangen.';

  @override
  String get diagnostics_preview => 'Voorbeeld van rapport';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count technische gebeurtenissen bijgevoegd',
      one: '1 technische gebeurtenis bijgevoegd',
      zero: 'Geen technische gebeurtenissen bijgevoegd',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Technische details';

  @override
  String get diagnostics_empty => 'Er is nog geen diagnoserapport voorbereid.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunnelstatus',
      'handshake': 'Bevestiging van verbinding',
      'certificate': 'VPN-certificaat',
      'kill_switch': 'Android-beveiliging',
      'connectivity': 'Beschikbaar netwerk',
      'api_reachability': 'Toegang tot service',
      'secure_storage': 'Beveiligde opslag',
      'other': 'Lokale controle',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Gecontroleerd',
      'failed': 'Aandacht vereist',
      'skipped': 'Niet getest — geen actieve controle',
      'unknown': 'Informatie niet beschikbaar',
      'other': 'Informatie niet beschikbaar',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Welkom bij FuzeVPN';

  @override
  String get connection_changeLocation => 'Locatie wijzigen';

  @override
  String get connection_details => 'Verbindingsdetails';

  @override
  String get locations_searchLabel => 'Zoek een stad of land';

  @override
  String get locations_clearSearch => 'Zoekopdracht wissen';

  @override
  String get locations_filterAll => 'Alle';

  @override
  String get locations_filterFavorites => 'Favorieten';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locaties',
      one: '$count locatie',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Geen locaties gevonden';

  @override
  String get locations_noResultsHint =>
      'Probeer een andere stad of een ander land.';

  @override
  String get locations_noFavorites => 'Je favorieten binnen handbereik';

  @override
  String get locations_noFavoritesHint =>
      'Tik op de ster naast een locatie om deze hier op te slaan.';

  @override
  String get locations_showAll => 'Alle locaties bekijken';

  @override
  String locations_addFavorite(String name) {
    return '$name aan favorieten toevoegen';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name uit favorieten verwijderen';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'De favoriet kon niet worden opgeslagen. Probeer het opnieuw.';

  @override
  String get locations_emptyTitle => 'Geen locaties beschikbaar';

  @override
  String get locations_emptyHint =>
      'Vernieuw de lijst om het opnieuw te proberen.';

  @override
  String get devices_manage => 'Mijn apparaten beheren';

  @override
  String get settings_personalization => 'Maak het persoonlijk';

  @override
  String get settings_safety => 'Beveiliging';

  @override
  String get settings_help => 'Hulp nodig?';

  @override
  String get settings_about => 'Over FuzeVPN';

  @override
  String get diagnostics_heading => 'Een verbindingsprobleem begrijpen';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Beschikbaar',
      'pending': 'Voorbereiden',
      'revoked': 'Verwijderd',
      'expired': 'Verlopen',
      'other': 'Status niet beschikbaar',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Voorkeur niet opgeslagen';

  @override
  String get notice_preferenceSave_message =>
      'Je keuze is voorlopig toegepast, maar kon niet worden opgeslagen. Probeer het opnieuw om deze te behouden nadat je de app hebt gesloten.';

  @override
  String get connection_androidDisconnectHint =>
      'Als Android de VPN actief houdt, schakel dan Altijd ingeschakelde VPN uit in de instellingen die worden geopend.';

  @override
  String get protection_learnMore => 'Meer informatie over Android-beveiliging';

  @override
  String get protection_guideWhy =>
      'Deze beveiliging voorkomt dat apps rechtstreeks internet gebruiken als de VPN-verbinding wordt verbroken. Dit wordt in Android ingesteld.';

  @override
  String get protection_guideAlwaysOnTitle => 'Altijd ingeschakelde VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android houdt de VPN-service actief en kan deze opnieuw starten nadat de telefoon opnieuw is opgestart.';

  @override
  String get protection_guideBlockTitle => 'Verbindingen zonder VPN blokkeren';

  @override
  String get protection_guideBlock =>
      'Deze instelling voorkomt dat verkeer de VPN omzeilt, ook wanneer de verbinding is onderbroken.';

  @override
  String get protection_guideWarning =>
      'Wanneer dit blokkeren is ingeschakeld, blijft internettoegang uitgeschakeld totdat de VPN is verbonden.';

  @override
  String get protection_guideStepsTitle => 'Beveiliging inschakelen';

  @override
  String get protection_guideStep1 =>
      'Open de Android-VPN-instellingen met de knop hieronder.';

  @override
  String get protection_guideStep2 =>
      'Open de opties met het tandwielpictogram naast FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Schakel Altijd ingeschakelde VPN in en daarna Verbindingen zonder VPN blokkeren, als deze opties beschikbaar zijn.';

  @override
  String get protection_guideManufacturers =>
      'De namen verschillen per telefoon. Zoek indien nodig naar VPN in Instellingen, meestal onder Netwerk en internet.';

  @override
  String get protection_guideDisableTitle => 'Deze beveiliging uitschakelen';

  @override
  String get protection_guideDisable =>
      'Schakel in dezelfde instellingen het blokkeren zonder VPN uit om internettoegang zonder de VPN toe te staan. Schakel Altijd ingeschakelde VPN ook uit als je niet meer wilt dat Android deze opnieuw start.';

  @override
  String get protection_guideManual =>
      'Je kiest deze instellingen in Android. FuzeVPN wijzigt ze niet voor je.';

  @override
  String get locations_changeTitle => 'Locatie wijzigen?';

  @override
  String locations_changeActive(String name) {
    return 'De VPN-verbinding wordt verbroken en probeert daarna verbinding te maken met $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'De VPN probeert verbinding te maken met $name.';
  }

  @override
  String get locations_confirmChange => 'Wijzigen en verbinden';

  @override
  String get locations_changeBusy =>
      'Er wordt al een wijziging uitgevoerd. Wacht voordat je een andere locatie kiest.';

  @override
  String get locations_automaticSelection => 'Automatische selectie';

  @override
  String get locations_cities => 'Steden';

  @override
  String get locations_servers => 'Servers';

  @override
  String locations_viewCities(String name) {
    return 'Steden in $name bekijken';
  }

  @override
  String locations_viewServers(String name) {
    return 'Servers in $name bekijken';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count landen',
      one: '$count land',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steden',
      one: '$count stad',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servers',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Alle landen';

  @override
  String get locations_backToCountries => 'Terug naar landen';

  @override
  String locations_backToCities(String name) {
    return 'Terug naar steden in $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name kiezen';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name kiezen';
  }

  @override
  String get locations_noCompatibleServer =>
      'Geen compatibele server beschikbaar.';

  @override
  String get externalLink_failed =>
      'Deze link kan niet worden geopend. Je kunt hem kopiëren en in je browser openen.';

  @override
  String get externalLink_copy => 'Link kopiëren';

  @override
  String get externalLink_copied => 'Link gekopieerd';

  @override
  String get externalLink_copyFailed =>
      'De link kan niet worden gekopieerd. Selecteer het adres hieronder.';

  @override
  String get settings_deleteAccount => 'Mijn account verwijderen';

  @override
  String get settings_deleteAccountDetail =>
      'Bekijk hoe je accountverwijdering aanvraagt';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Kies je VPN-abonnement.';

  @override
  String get billing_subscribe => 'Abonneren';

  @override
  String get billing_choosePlan => 'Kies een abonnement om door te gaan.';

  @override
  String get billing_monthly => 'Maandelijks';

  @override
  String get billing_yearly => 'Jaarlijks';

  @override
  String get billing_continue => 'Doorgaan met Google Play';

  @override
  String get billing_restore => 'Aankopen herstellen';

  @override
  String get billing_manage => 'Abonnement beheren';

  @override
  String get billing_deleteAccountWarning =>
      'Als je een abonnement via Google Play hebt, stopt het verwijderen van je FuzeVPN-account de verlenging niet. Beheer of stop de verlenging afzonderlijk in Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Doorgaan naar het verzoek om accountverwijdering';

  @override
  String get billing_refresh => 'Toegang vernieuwen';

  @override
  String get billing_loadingPlans => 'Abonnementen laden…';

  @override
  String get billing_unavailable =>
      'Er zijn nu geen abonnementen beschikbaar. Probeer het later opnieuw.';

  @override
  String get billing_comingSoon => 'Abonnementen zijn binnenkort beschikbaar.';

  @override
  String get billing_priceDisclosure =>
      'Prijs verstrekt door Google Play. Het definitieve bedrag wordt vóór betaling bevestigd.';

  @override
  String get billing_renewalMonthly =>
      'Wordt elke maand automatisch verlengd, tenzij opgezegd. Je kunt op elk moment opzeggen via Google Play-abonnementen.';

  @override
  String get billing_renewalYearly =>
      'Wordt elk jaar automatisch verlengd, tenzij opgezegd. Je kunt op elk moment opzeggen via Google Play-abonnementen.';

  @override
  String get billing_active => 'Je Premium-toegang is actief';

  @override
  String billing_accessUntil(String date) {
    return 'Toegang tot $date.';
  }

  @override
  String get billing_webManaged =>
      'Je abonnement wordt beheerd op de FuzeVPN-website.';

  @override
  String get billing_playManaged =>
      'Je abonnement wordt beheerd via Google Play.';

  @override
  String get billing_inactive => 'Geen actief abonnement.';

  @override
  String get billing_checkingAccess => 'Je toegang controleren…';

  @override
  String get billing_restoring => 'Aankopen herstellen…';

  @override
  String get billing_pending =>
      'De betaling is in behandeling. Je toegang wordt na bevestiging geactiveerd.';

  @override
  String get billing_cancelled =>
      'Aankoop geannuleerd. Er is geen nieuw abonnement geactiveerd.';

  @override
  String get billing_verifying => 'Aankoop controleren…';

  @override
  String get billing_success =>
      'Abonnement geactiveerd. Je Premium-toegang is gereed.';

  @override
  String get billing_restored => 'Je aankopen zijn hersteld.';

  @override
  String get billing_restoreEmpty =>
      'Geen aankopen om te herstellen voor dit Google Play-account.';

  @override
  String get billing_catalogError =>
      'Abonnementen kunnen niet worden geladen. Probeer het opnieuw.';

  @override
  String get billing_purchaseError =>
      'De aankoop kan niet worden gestart. Probeer het opnieuw.';

  @override
  String get billing_verificationError =>
      'Aankoopverificatie is tijdelijk niet beschikbaar. Herstel aankopen om het opnieuw te proberen.';

  @override
  String get billing_restoreError =>
      'Aankopen kunnen niet worden hersteld. Probeer het opnieuw.';

  @override
  String get billing_managementError =>
      'Abonnementbeheer kan niet worden geopend. Probeer het opnieuw.';

  @override
  String get billing_storeUnavailable =>
      'Google Play is niet beschikbaar op dit apparaat.';

  @override
  String get welcome_title => 'Je VPN, eenvoudig geregeld.';

  @override
  String get welcome_description =>
      'Bescherm je verbinding. Houd controle over je privacy.';

  @override
  String get welcome_start => 'Aan de slag';

  @override
  String get welcome_alreadyPurchased => 'Al gekocht?';

  @override
  String get welcome_noAccountRequired =>
      'Je hoeft geen account te maken om te beginnen.';

  @override
  String get guest_accountTitle => 'Account niet gekoppeld';

  @override
  String get guest_accountDescription =>
      'Herstel je aankopen met hetzelfde Google Play-account om je abonnement op een ander apparaat te gebruiken.';

  @override
  String get guest_existingSubscriberSignIn => 'Al een abonnement? Inloggen';

  @override
  String get guest_claimTitle => 'Neem FuzeVPN overal mee';

  @override
  String get guest_claimDescription =>
      'Maak een account om je abonnement op je andere apparaten te gebruiken. Deze stap is optioneel.';

  @override
  String get guest_skip => 'Later';

  @override
  String get guest_activationTitle => 'Fuze Premium is actief';

  @override
  String get guest_activationDescription =>
      'Je abonnement is klaar. Gebruik je VPN en maak een account wanneer je wilt.';

  @override
  String get guest_useVpn => 'Mijn VPN gebruiken';

  @override
  String get guest_loginRequired =>
      'Deze aankoop is al gekoppeld aan een FuzeVPN-account. Meld je aan bij dat account om je abonnement te gebruiken.';

  @override
  String get guest_signOutWarning =>
      'Je kunt je abonnement herstellen door je aankopen met hetzelfde Google Play-account te herstellen.';

  @override
  String get guest_profileUnavailable =>
      'Je account is al gekoppeld. Meld je aan om je gegevens te bekijken en te beheren.';

  @override
  String get billing_acceptance =>
      'Door verder te gaan, accepteer je de Gebruiksvoorwaarden en het Privacybeleid.';

  @override
  String get guest_verifyEmailReminder =>
      'Bevestig je e-mailadres om je account te beveiligen. Je kunt je VPN blijven gebruiken.';

  @override
  String get guest_serviceUnavailable =>
      'De dienst is tijdelijk niet beschikbaar. Probeer het zo nog eens.';

  @override
  String get guest_restoreError =>
      'Je aankopen konden niet worden hersteld. Probeer het opnieuw met het Google Play-account waarmee je de aankoop hebt gedaan.';

  @override
  String get guest_claimSuccess =>
      'Je account is aangemaakt. Je abonnement en VPN-toegang blijven behouden.';

  @override
  String get guest_emailExists =>
      'Dit e-mailadres is al in gebruik. Kies een ander adres of meld je aan bij je bestaande account. Je aankoop blijft beschikbaar via Google Play.';

  @override
  String get guest_claimError =>
      'Je account kon niet worden aangemaakt. Je kunt je VPN blijven gebruiken en het later opnieuw proberen.';

  @override
  String get guest_secureStorageError =>
      'Je sessie kon niet veilig worden opgeslagen op dit apparaat. Probeer het opnieuw.';

  @override
  String get guest_premiumRequired =>
      'Kies een abonnement om je VPN te activeren.';

  @override
  String get welcome_viewPlans => 'Abonnementen bekijken';

  @override
  String get google_continue => 'Doorgaan met Google';

  @override
  String get google_or => 'of';

  @override
  String get google_title => 'Uw FuzeVPN-account';

  @override
  String get google_settingUp => 'Maak uw account compleet';

  @override
  String get google_country => 'Woonland';

  @override
  String get google_profileDescription =>
      'Kies uw land en lees beide documenten om uw FuzeVPN-account te maken.';

  @override
  String get google_claimDescription =>
      'Koppel uw gastaccount aan Google. Uw abonnement en apparaat blijven aan dit account gekoppeld.';

  @override
  String get google_linkTitle => 'Google aan FuzeVPN koppelen';

  @override
  String get google_linkDescription =>
      'Bevestig toegang tot uw bestaande FuzeVPN-account. Uw Google-wachtwoord wordt niet gevraagd.';

  @override
  String get google_password => 'FuzeVPN-wachtwoord';

  @override
  String get google_linkAccount => 'Koppeling bevestigen';

  @override
  String get google_requestEmail => 'Een bevestigingsmail ontvangen';

  @override
  String get google_emailInstructions =>
      'Open de e-mail van FuzeVPN en voer de bevestigingscode in.';

  @override
  String get google_emailCode => 'Bevestigingscode uit e-mail';

  @override
  String get google_confirmEmail => 'Code bevestigen';

  @override
  String get google_restart => 'Ander Google-account kiezen';

  @override
  String get google_resume => 'Deze poging controleren';

  @override
  String get google_unavailable =>
      'Aanmelden met Google is niet beschikbaar. U kunt e-mail en wachtwoord gebruiken.';

  @override
  String get google_expired =>
      'Deze poging is verlopen. Annuleer en begin opnieuw.';

  @override
  String get google_conflict =>
      'Dit Google-account is al elders gekoppeld. Uw huidige account en abonnement blijven behouden.';

  @override
  String get google_error =>
      'Aanmelden met Google is mislukt. Probeer opnieuw; uw huidige toegang blijft behouden.';

  @override
  String get google_uncertain =>
      'Het resultaat kon niet worden bevestigd. Controleer deze poging of annuleer voordat u opnieuw begint.';

  @override
  String get google_cancelFailed =>
      'De annulering kon niet worden bevestigd. Probeer opnieuw te annuleren voordat u dit scherm verlaat.';

  @override
  String get google_cancelled => 'Aanmelden met Google geannuleerd.';

  @override
  String get google_selecting => 'Kies uw Google-account…';

  @override
  String get google_verifying => 'Uw account wordt gecontroleerd…';

  @override
  String get google_emailUnavailable =>
      'De bevestigingsmail kon niet worden verzonden. Probeer later opnieuw.';

  @override
  String get google_emailSent =>
      'Bevestigingsmail verzonden. Controleer uw inbox.';

  @override
  String get google_rateLimited => 'Wacht even voordat u opnieuw probeert.';

  @override
  String get google_invalidPassword =>
      'Het FuzeVPN-wachtwoord is onjuist. Uw huidige account blijft behouden.';

  @override
  String get google_invalidCode =>
      'De bevestigingscode is ongeldig of verlopen.';

  @override
  String get google_accountChanged =>
      'De sessie is gewijzigd. Annuleer deze poging voordat u opnieuw begint.';

  @override
  String get google_invalidResponse =>
      'Het antwoord kon niet worden gevalideerd. Uw huidige toegang blijft behouden.';

  @override
  String get google_invalidRegistration =>
      'Controleer uw land en beide toestemmingen.';

  @override
  String get google_consentRequired =>
      'Kies uw land en accepteer beide documenten om door te gaan.';

  @override
  String get google_challengeRequired =>
      'Een extra beveiligingscontrole is vereist. Uw huidige toegang blijft behouden.';

  @override
  String get google_challengeUnavailable =>
      'De beveiligingscontrole is niet beschikbaar. Probeer later opnieuw.';
}
