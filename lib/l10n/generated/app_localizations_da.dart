// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Beskyt din forbindelse';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN bruger Androids VPN-tjeneste (VpnService) til at oprette en krypteret tunnel mellem denne enhed og FuzeVPNs servere.';

  @override
  String get vpnDisclosure_dataBody =>
      'Når VPN er aktiv, føres dine apps’ internettrafik, destinationsadresser og DNS-anmodninger gennem tunnelen for at videresende din forbindelse, også når FuzeVPN kører i baggrunden.';

  @override
  String get vpnDisclosure_statusBody =>
      'Appen bruger forbindelsens status, varighed og mængden af overførte data til at vise din VPN-forbindelse. Du kan stoppe den når som helst.';

  @override
  String get vpnDisclosure_privacy => 'Privatliv';

  @override
  String get vpnDisclosure_accept => 'Acceptér og fortsæt';

  @override
  String get vpnDisclosure_decline => 'Ikke nu';

  @override
  String get accountRestoration_title =>
      'Kontoet er midlertidigt utilgængeligt';

  @override
  String get accountRestoration_message =>
      'Din session er bevaret. Prøv igen for at gendanne din konto; du kan stadig administrere VPN-forbindelsen her.';

  @override
  String get action_retry => 'Prøv igen';

  @override
  String get session_endingTitle => 'Sessionen afsluttes';

  @override
  String get session_ending =>
      'Din session er ugyldiggjort. VPN-forbindelsen stoppes, og sessionen ryddes…';

  @override
  String get session_stopFailed =>
      'VPN-nedlukningen er ikke bekræftet. Prøv igen, før du logger ind på ny.';

  @override
  String get session_cleanupFailed =>
      'VPN-forbindelsen er stoppet, men fjernelsen af sessionen er ikke bekræftet. Prøv at rydde op igen.';

  @override
  String get session_retryStop => 'Prøv at lukke ned igen';

  @override
  String get session_retryCleanup => 'Prøv at rydde op igen';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN klargøres sikkert…';

  @override
  String get nav_connection => 'Forbindelse';

  @override
  String get nav_locations => 'Placeringer';

  @override
  String get nav_account => 'Konto';

  @override
  String get nav_devices => 'Enheder';

  @override
  String get nav_settings => 'Indstillinger';

  @override
  String get action_refresh => 'Opdater';

  @override
  String get auth_tab_login => 'Log ind';

  @override
  String get auth_tab_register => 'Opret konto';

  @override
  String get auth_stepAccount => 'Konto';

  @override
  String get auth_stepIdentity => 'Identitet';

  @override
  String get auth_stepAddress => 'Adresse og aftaler';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Trin $current af $total';
  }

  @override
  String get auth_tagline => 'Din VPN gjort enkel.';

  @override
  String get auth_keysLocal => 'Dine private VPN-nøgler bliver på denne enhed.';

  @override
  String get form_email => 'E-mailadresse';

  @override
  String get form_password => 'Adgangskode';

  @override
  String get form_showPassword => 'Vis adgangskode';

  @override
  String get form_hidePassword => 'Skjul adgangskode';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8-bytes. Nogle tegn bruger mere end én byte.';

  @override
  String get form_firstName => 'Fornavn';

  @override
  String get form_lastName => 'Efternavn';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adresse';

  @override
  String get form_address2 => 'Adresselinje 2 (valgfri)';

  @override
  String get form_postalCode => 'Postnummer';

  @override
  String get form_city => 'By';

  @override
  String get form_country => 'Landekode (f.eks. FR)';

  @override
  String get action_login => 'Log ind';

  @override
  String get action_createAccount => 'Opret en konto';

  @override
  String get action_createMyAccount => 'Opret min konto';

  @override
  String get action_next => 'Fortsæt';

  @override
  String get action_previous => 'Tilbage';

  @override
  String get action_forgotPassword => 'Glemt adgangskode?';

  @override
  String get auth_noAccount => 'Har du ikke en konto endnu?';

  @override
  String get auth_requiredInformation => 'Opret din konto i tre trin.';

  @override
  String get auth_termsPrefix => 'Jeg accepterer ';

  @override
  String get auth_termsLink => 'brugsbetingelserne';

  @override
  String get auth_privacyPrefix => 'Jeg accepterer ';

  @override
  String get auth_privacyLink => 'privatlivspolitikken';

  @override
  String get auth_consentRequired =>
      'Dit samtykke er nødvendigt for at oprette en konto.';

  @override
  String get validation_required => 'Dette felt er påkrævet.';

  @override
  String get validation_email => 'Indtast en gyldig e-mailadresse.';

  @override
  String get validation_password =>
      'Adgangskoden er for kort: mindst 8 UTF-8-bytes.';

  @override
  String get validation_passwordTooLong =>
      'Adgangskoden er for lang: højst 72 UTF-8-bytes.';

  @override
  String get validation_phone =>
      'Brug internationalt format, f.eks. +33612345678.';

  @override
  String get validation_country =>
      'Brug en landekode på to bogstaver, f.eks. FR.';

  @override
  String get passwordReset_title => 'Nulstil adgangskode';

  @override
  String get passwordReset_description =>
      'Indtast e-mailadressen til din konto for at anmode om et link til nulstilling af adgangskoden.';

  @override
  String get passwordReset_send => 'Send link';

  @override
  String get connection_title => 'Din forbindelse';

  @override
  String get connection_subtitle =>
      'Vælg en placering, og slå derefter din VPN til.';

  @override
  String get connection_prepare => 'Klar til at oprette forbindelse?';

  @override
  String get connection_advancedOptions => 'Avancerede indstillinger';

  @override
  String get connection_location => 'Placering';

  @override
  String get connection_chooseLocation => 'Vælg en placering';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Opret forbindelse';

  @override
  String get connection_connecting => 'Opretter forbindelse…';

  @override
  String get connection_disconnect => 'Afbryd forbindelsen';

  @override
  String get connection_disconnecting => 'Afbryder forbindelsen';

  @override
  String get connection_locationChange => 'Skifter placering…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol er ikke tilgængelig';
  }

  @override
  String get connection_activeLocation => 'Aktiv placering';

  @override
  String get connection_duration => 'Varighed';

  @override
  String get connection_received => 'Modtaget';

  @override
  String get connection_sent => 'Sendt';

  @override
  String get connection_lastHandshake => 'Seneste sikre udveksling';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'for $duration siden';
  }

  @override
  String get verification_title => 'Bekræft din e-mailadresse';

  @override
  String get verification_message =>
      'Bekræft din e-mailadresse for at bruge VPN på denne telefon.';

  @override
  String get verification_resend => 'Send e-mail igen';

  @override
  String get migration_title => 'Skift placering';

  @override
  String get migration_draining => 'Forbereder skift af placering…';

  @override
  String get migration_activating => 'Aktiverer den nye server…';

  @override
  String get migration_ready => 'Placeringen er opdateret.';

  @override
  String get migration_blocked =>
      'Skift af placering kræver indgriben fra serveren. Prøv igen senere, eller kontakt support.';

  @override
  String get migration_progress => 'Fremskridt for skift af placering';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Forsinkelse mellem kontroller: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Fortsæt skift af placering';

  @override
  String get status_authorizing => 'Tilladelse påkrævet';

  @override
  String get status_authorizingDetail =>
      'Accepter Android-anmodningen for at tillade VPN.';

  @override
  String get status_preparing => 'Forbereder';

  @override
  String get status_preparingDetail => 'Forbereder din sikre forbindelse.';

  @override
  String get status_reconnecting => 'Opretter forbindelse igen…';

  @override
  String get status_reconnectingDetail =>
      'Forbindelsen blev afbrudt. VPN forsøger at oprette forbindelse igen.';

  @override
  String get status_connecting => 'Opretter forbindelse';

  @override
  String get status_connectingDetail =>
      'Opretter forbindelse til VPN-serveren…';

  @override
  String get status_connected => 'Forbundet';

  @override
  String get status_connectedDetail => 'Din VPN-forbindelse er aktiv.';

  @override
  String get status_disconnecting => 'Afbryder forbindelsen';

  @override
  String get status_disconnectingDetail => 'Din VPN-forbindelse stoppes.';

  @override
  String get status_error => 'Forbindelsen er utilgængelig';

  @override
  String get status_errorDetail =>
      'VPN-forbindelsen er ikke bekræftet. Prøv igen.';

  @override
  String get status_idle => 'Ikke forbundet';

  @override
  String get status_idleDetail =>
      'Opret forbindelse til VPN for at beskytte din forbindelse.';

  @override
  String get trust_note =>
      'Når du lukker appen, stopper VPN ikke. Brug Afbryd forbindelsen for at stoppe den.';

  @override
  String get locations_none => 'Ingen placeringer er tilgængelige lige nu.';

  @override
  String get locations_available => 'Vælg din næste placering.';

  @override
  String get locations_selected => 'Valgt placering';

  @override
  String get locations_select => 'Vælg denne placering';

  @override
  String get locations_lockedTunnel =>
      'Afbryd VPN-forbindelsen for at skifte placering.';

  @override
  String get locations_lockedMigration =>
      'Vent, indtil skiftet af placering er færdigt.';

  @override
  String get devices_title => 'Dine enheder';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit enheder';
  }

  @override
  String get devices_refresh => 'Opdater enheder';

  @override
  String get devices_empty => 'Ingen VPN-enhed er registreret endnu.';

  @override
  String get devices_firstConnection =>
      'Din telefon bliver tilføjet ved den første forbindelse.';

  @override
  String get devices_thisDevice => 'Denne enhed';

  @override
  String devices_added(Object date) {
    return 'Tilføjet $date';
  }

  @override
  String get action_remove => 'Fjern';

  @override
  String get settings_title => 'Indstillinger';

  @override
  String get settings_subtitle =>
      'Dine præferencer og din konto samlet ét sted.';

  @override
  String get settings_appearance => 'Udseende';

  @override
  String get settings_language => 'Sprog';

  @override
  String get settings_languageDescription =>
      'Det valgte sprog gælder også for VPN-meddelelser.';

  @override
  String get settings_account => 'Konto';

  @override
  String get settings_signOut => 'Log ud';

  @override
  String get settings_privacy => 'Privatlivspolitik';

  @override
  String get settings_terms => 'Brugsbetingelser';

  @override
  String get settings_security => 'Sikkerhed og gennemsigtighed';

  @override
  String get settings_licenses => 'Komponentlicenser';

  @override
  String get settings_licensesDetail => 'Software, der bruges i appen';

  @override
  String get settings_background =>
      'VPN forbliver aktiv, når du forlader appen. Brug Afbryd forbindelsen under fanen Forbindelse for at stoppe den.';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Lys';

  @override
  String get theme_dark => 'Mørk';

  @override
  String get language_system => 'Telefonsprog';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Fjern denne enhed?';

  @override
  String get dialog_removeCurrent =>
      'Denne telefon afbrydes fra VPN og mister adgangen. Dens VPN-forbindelsesdata fjernes, når serveren har bekræftet det.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN-adgangen for “$name” tilbagekaldes. Dette kan ikke fortrydes.';
  }

  @override
  String get dialog_signOut => 'Log ud?';

  @override
  String get dialog_signOutMessage =>
      'VPN stoppes, og du skal logge ind igen. Dine krypterede VPN-nøgler bliver på denne telefon til din næste forbindelse.';

  @override
  String get action_cancel => 'Annuller';

  @override
  String get action_signOut => 'Log ud';

  @override
  String get notice_close => 'Afvis meddelelse';

  @override
  String get notice_sessionExpired_title => 'Sessionen er udløbet';

  @override
  String get notice_sessionExpired_message =>
      'Din session er udløbet. Log ind igen.';

  @override
  String get notice_connectionFailed_title => 'Forbindelsen mislykkedes';

  @override
  String get notice_invalidCredentials_message =>
      'E-mailadressen eller adgangskoden er forkert.';

  @override
  String get notice_emailVerification_title => 'E-mailbekræftelse påkrævet';

  @override
  String get notice_emailVerification_message =>
      'Bekræft din e-mailadresse, før du tilføjer en VPN-enhed.';

  @override
  String get notice_rateLimited_title => 'For mange forsøg';

  @override
  String get notice_deviceLimit_title => 'Grænsen på 2 enheder er nået';

  @override
  String get notice_deviceLimit_message =>
      'Fjern en eksisterende enhed, før du tilføjer en anden.';

  @override
  String get notice_identityRenewal_title => 'VPN-identiteten skal fornyes';

  @override
  String get notice_identityRenewal_message =>
      'Denne identitet blev fjernet. Opret en ny lokal identitet.';

  @override
  String get notice_migrationPending_title => 'Skift af placering er i gang';

  @override
  String get notice_migrationPending_message =>
      'Et skift af placering er allerede i gang.';

  @override
  String get notice_migrationBlocked_title => 'Skift af placering blokeret';

  @override
  String get notice_migrationBlocked_message =>
      'Skift af placering kræver indgriben fra serveren. Prøv igen senere, eller kontakt support.';

  @override
  String get notice_targetUnavailable_title =>
      'Serveren er midlertidigt utilgængelig';

  @override
  String get notice_targetUnavailable_message =>
      'Denne server er midlertidigt utilgængelig.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetforbindelsen er utilgængelig';

  @override
  String get notice_networkUnavailable_message =>
      'Kontroller din forbindelse, og prøv igen.';

  @override
  String get notice_permissionDenied_title => 'VPN-tilladelse afvist';

  @override
  String get notice_permissionDenied_message =>
      'Start forbindelsen igen, og accepter Android-tilladelsesanmodningen.';

  @override
  String get notice_wireguardTimeout_title => 'Serveren svarer ikke';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard-forbindelsen tog for lang tid. Prøv igen, eller vælg en anden placering.';

  @override
  String get notice_tlsFailed_title => 'Sikker forbindelse afvist';

  @override
  String get notice_tlsFailed_message =>
      'Serveren accepterede ikke OpenVPN-forbindelsen. Prøv igen. Hvis problemet fortsætter, skal du køre en diagnosticering.';

  @override
  String get notice_tunRejected_title => 'Android afviste VPN-grænsefladen';

  @override
  String get notice_tunRejected_message =>
      'Android afviste den netværkskonfiguration, som OpenVPN anmodede om.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN kunne ikke starte';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN-motoren kunne ikke færdiggøre opstarten. Prøv igen. Hvis problemet fortsætter, skal du kontakte support.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnosticeringskode: $code';
  }

  @override
  String get notice_generic_title => 'VPN-forbindelsen mislykkedes';

  @override
  String get notice_generic_message => 'Der opstod en fejl. Prøv igen senere.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konto oprettet',
      'password_reset_sent': 'Anmodning om nulstilling af adgangskode modtaget',
      'verification_email_sent': 'Bekræftelses-e-mail sendt',
      'location_migration_pending': 'Skift af placering er i gang',
      'vpn_sign_in_required': 'Login påkrævet',
      'protocol_unavailable_at_location': 'Protokol ikke tilgængelig',
      'vpn_permission_denied': 'VPN-tilladelse afvist',
      'revoked_identity_device_limit': 'Grænsen på 2 enheder er nået',
      'tunnel_start_unexpected': 'VPN kunne ikke starte',
      'flutter_disconnect_timeout': 'Afbrydelse ikke bekræftet',
      'flutter_disconnect_unexpected': 'Kunne ikke afbryde forbindelsen',
      'device_revoked': 'Enhed fjernet',
      'revoke_unexpected': 'Enheden kunne ikke fjernes',
      'identity_renewal_unexpected': 'Identiteten kunne ikke fornyes',
      'openvpn_renewal_unexpected': 'OpenVPN kunne ikke fornyes',
      'location_migration_blocked': 'Skift af placering blokeret',
      'location_migration_slow': 'Skift af placering er stadig i gang',
      'location_migration_conflict': 'Skift af placering skal opdateres',
      'location_migration_verification_failed':
          'Skift af placering ikke bekræftet',
      'location_migration_device_changed':
          'Enheden blev ændret under skift af placering',
      'tunnel_stop_failed': 'Skift af placering er ikke tilgængeligt',
      'other': 'Handlingen mislykkedes',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Kontoen blev oprettet, men bekræftelses-e-mailen kunne ikke sendes. Brug Send igen i appen.',
      'password_reset_sent':
          'Din anmodning blev modtaget. Hvis en konto matcher denne adresse, modtager du muligvis en e-mail. Tjek også din spammappe.',
      'verification_email_sent': 'En ny bekræftelses-e-mail er netop sendt.',
      'location_migration_pending':
          'Flytningen til $target forberedes stadig. Du kan fortsætte den uden at oprette enheden igen.',
      'vpn_sign_in_required': 'Log ind på din konto, før du starter VPN.',
      'protocol_unavailable_at_location':
          'Den valgte protokol tilbydes ikke på denne placering. Opdater placeringerne, eller vælg en anden protokol.',
      'vpn_permission_denied':
          'Android afviste VPN-tilladelsen. Start forbindelsen igen, og accepter systemanmodningen.',
      'revoked_identity_device_limit':
          'Denne enheds VPN-adgang blev fjernet, og enhedsgrænsen er nået. Fjern en enhed under Konto → Administrer mine enheder.',
      'tunnel_start_unexpected':
          'En uventet fejl afbrød klargøringen af tunnelen. Kontroller diagnosticeringskoden, og prøv igen.',
      'flutter_disconnect_timeout':
          'Android bekræftede ikke i tide, at VPN var stoppet. Prøv at stoppe den igen.',
      'flutter_disconnect_unexpected':
          'En uventet fejl forhindrede bekræftelsen af, at tunnelen var stoppet.',
      'device_revoked':
          'Enhedens VPN-adgang blev tilbagekaldt, og dens lokale hemmeligheder blev fjernet.',
      'revoke_unexpected':
          'Enheden kunne ikke fjernes. Opdater listen, og prøv igen.',
      'identity_renewal_unexpected':
          'Den nye VPN-identitet kunne ikke oprettes. Opdater enhederne, og prøv igen.',
      'openvpn_renewal_unexpected':
          'OpenVPN-profilen kunne ikke fornyes. Prøv igen, eller kontroller diagnosticeringskoden.',
      'location_migration_blocked':
          'Serveren kan ikke gennemføre dette skift lige nu. Enheden og dens lokale identitet er bevaret.',
      'location_migration_slow':
          'Serveren forbereder stadig flytningen til $target. Brug Fortsæt om et øjeblik.',
      'location_migration_conflict':
          'Enhedens tilstand blev ændret på serveren. Opdater enhederne, og fortsæt derefter skiftet.',
      'location_migration_verification_failed':
          'Serveren bekræftede ikke den nye placering. Den tidligere lokale identitet er bevaret.',
      'location_migration_device_changed':
          'Den enhed, serveren returnerede, matcher ikke længere den enhed, der ændres. Opdater enhederne, før du prøver igen.',
      'tunnel_stop_failed':
          'Den tidligere tunnel skal stoppes helt, før den nye forbindelse kan oprettes.',
      'other':
          'Handlingen kunne ikke gennemføres. Prøv igen, eller send diagnosticeringskoden til support.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessionen er udløbet',
      'invalid_credentials': 'Login mislykkedes',
      'email_verification_required': 'E-mailbekræftelse påkrævet',
      'verification_email_cooldown': 'E-mail allerede sendt',
      'rate_limited': 'For mange forsøg',
      'invalid_registration': 'Oplysningerne skal rettes',
      'email_exists': 'Kontoen findes allerede',
      'invalid_profile': 'Ugyldig profil',
      'invalid_device': 'Ugyldig enhed',
      'invalid_location': 'Placering ikke tilgængelig',
      'device_limit': 'Enhedsgrænsen er nået',
      'device_exists': 'VPN-identiteten er allerede i brug',
      'device_identity_revoked': 'VPN-identiteten skal fornyes',
      'device_location_locked': 'Skift af placering skal opdateres',
      'location_migration_pending': 'Skift af placering er i gang',
      'location_migration_blocked': 'Skift af placering blokeret',
      'target_ca_mismatch': 'OpenVPN-serveren er inkompatibel',
      'location_migration_conflict': 'Skift af placering skal opdateres',
      'server_full': 'Serveren er fuld',
      'capacity_unavailable': 'Placeringen er midlertidigt utilgængelig',
      'target_unavailable': 'Serveren er midlertidigt utilgængelig',
      'not_found': 'Elementet blev ikke fundet',
      'invalid_openvpn_csr': 'Ugyldig OpenVPN-identitet',
      'openvpn_profile_exists': 'OpenVPN-profilen findes allerede',
      'openvpn_profile_revoked': 'OpenVPN-profil tilbagekaldt',
      'openvpn_operation_pending': 'OpenVPN-handling er i gang',
      'openvpn_operation_terminal': 'OpenVPN-handlingen blev afbrudt',
      'openvpn_address_unavailable': 'OpenVPN-adresse ikke tilgængelig',
      'openvpn_profile_conflict': 'OpenVPN-konflikt',
      'openvpn_signer_unavailable': 'OpenVPN ikke tilgængelig',
      'email_delivery_unavailable': 'E-mail ikke tilgængelig',
      'invalid_token': 'Ugyldigt link',
      'network_unavailable': 'Internetforbindelsen er utilgængelig',
      'invalid_json': 'Ugyldig anmodning',
      'invalid_api_response': 'Ugyldigt serversvar',
      'ipv6_unavailable': 'IPv6 ikke tilgængelig',
      'invalid_ip_families': 'Netværkskonfiguration afvist',
      'other': 'Tjenesten er utilgængelig',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Din session er udløbet. Log ind igen.',
      'invalid_credentials': 'E-mailadressen eller adgangskoden er forkert.',
      'email_verification_required':
          'Bekræft din e-mailadresse, før du tilføjer en VPN-enhed.',
      'invalid_registration': 'Kontroller de ønskede oplysninger og samtykker.',
      'email_exists': 'En konto bruger allerede denne e-mailadresse.',
      'invalid_profile': 'Kontroller dine profiloplysninger.',
      'invalid_device': 'Denne enheds navn eller lokale identitet er ugyldig.',
      'invalid_location': 'Opdater listen over placeringer, og prøv igen.',
      'device_limit': 'Fjern en eksisterende enhed, før du tilføjer en anden.',
      'device_exists':
          'Denne VPN-identitet er allerede knyttet til en anden konto.',
      'device_identity_revoked':
          'Denne identitet blev fjernet. Der skal oprettes en ny lokal identitet.',
      'device_location_locked':
          'Denne enheds placering blev netop ændret. Appen fortsætter det igangværende skift.',
      'location_migration_pending': 'Et skift af placering er allerede i gang.',
      'location_migration_blocked':
          'Skift af placering kræver indgriben fra serveren. Prøv igen senere, eller kontakt support.',
      'target_ca_mismatch':
          'Denne server er endnu ikke kompatibel med den aktuelle OpenVPN-profil.',
      'location_migration_conflict':
          'Opdater enhederne, og prøv derefter at skifte placering igen.',
      'server_full':
          'Denne placering har nået sin forbindelsesgrænse. Vælg en anden placering, eller prøv igen senere.',
      'capacity_unavailable':
          'Vi kan ikke bekræfte, om denne placering er tilgængelig lige nu. Vælg en anden placering, eller prøv igen senere.',
      'target_unavailable': 'Denne server er midlertidigt utilgængelig.',
      'not_found': 'Dette element er ikke længere tilgængeligt på din konto.',
      'invalid_openvpn_csr': 'Opret en ny OpenVPN-identitet, og prøv igen.',
      'openvpn_profile_exists':
          'Der findes allerede en OpenVPN-profil til denne enhed.',
      'openvpn_profile_revoked': 'Forny OpenVPN-profilen for at fortsætte.',
      'openvpn_operation_pending':
          'Ændringen er stadig ved at blive udbredt. Prøv igen senere.',
      'openvpn_operation_terminal':
          'Opret en ny OpenVPN-identitet, og prøv igen.',
      'openvpn_address_unavailable':
          'Ingen OpenVPN-adresse er tilgængelig lige nu.',
      'openvpn_profile_conflict':
          'Profilen blev ændret. Opdater enhederne, og prøv igen.',
      'openvpn_signer_unavailable':
          'OpenVPN-tjenesten er midlertidigt utilgængelig.',
      'email_delivery_unavailable':
          'E-mailen kunne ikke sendes. Prøv igen senere.',
      'invalid_token': 'Dette link er ugyldigt eller udløbet. Anmod om et nyt.',
      'network_unavailable':
          'Kontroller din internetforbindelse, og prøv igen.',
      'invalid_json': 'Kontroller de indtastede oplysninger, og prøv igen.',
      'invalid_api_response':
          'Serveren returnerede et uventet svar. Prøv igen senere.',
      'ipv6_unavailable':
          'Serveren kan ikke aktivere IPv6 lige nu. Prøv igen senere.',
      'invalid_ip_families':
          'Tunnelkonfigurationen er ufuldstændig eller stemmer ikke overens med de godkendte adresser. Prøv igen fra appen.',
      'other': 'Der opstod en serverfejl. Prøv igen senere.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Prøv igen om et øjeblik.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Prøv igen om $seconds sekunder.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Genoptagelse af system-VPN ikke tilgængelig',
      'system_vpn_resume_corrupt': 'Ugyldig genoptagelse af system-VPN',
      'system_vpn_resume_session_invalid':
          'Ugyldig session til genoptagelse af VPN',
      'system_vpn_resume_identity_changed': 'VPN-identiteten blev ændret',
      'system_vpn_resume_identity_invalid':
          'Ugyldig VPN-identitet til genoptagelse',
      'system_vpn_resume_storage_failed':
          'Lager til genoptagelse af VPN er ikke tilgængeligt',
      'system_vpn_resume_network_timeout':
          'Genoptagelse af VPN har intet netværk',
      'system_vpn_resume_blocked': 'Genoptagelse af VPN blokeret',
      'system_vpn_resume_failed': 'Genoptagelse af VPN mislykkedes',
      'system_vpn_resume_error_invalid': 'Ugyldig fejl ved genoptagelse af VPN',
      'wireguard_identity_store_failed': 'WireGuard-identiteten blev ikke gemt',
      'wireguard_identity_unavailable': 'WireGuard-identitet ikke tilgængelig',
      'vpn_host_destroyed': 'Androids VPN-vært stoppet',
      'vpn_host_unavailable': 'Androids VPN-vært ikke tilgængelig',
      'vpn_permission_required': 'VPN-tilladelse påkrævet',
      'vpn_permission_denied': 'VPN-tilladelse afvist',
      'vpn_permission_request_failed': 'Tilladelsen kunne ikke anmodes',
      'wireguard_foreground_service_unavailable':
          'WireGuard-tjeneste ikke tilgængelig',
      'wireguard_identity_invalid': 'Ugyldig lokal WireGuard-nøgle',
      'wireguard_identity_in_use': 'WireGuard-identiteten er allerede i brug',
      'wireguard_configuration_invalid': 'Ugyldig WireGuard-konfiguration',
      'wireguard_operation_pending': 'WireGuard-handling stadig aktiv',
      'wireguard_start_failed': 'WireGuard-start afvist',
      'wireguard_stop_timeout': 'WireGuard-stop ikke bekræftet',
      'wireguard_handshake_timeout': 'WireGuard svarede ikke',
      'openvpn_connection_timeout': 'OpenVPN svarede ikke',
      'openvpn_core_unavailable': 'OpenVPN-motor ikke tilgængelig',
      'openvpn_operation_pending': 'OpenVPN-session stadig aktiv',
      'openvpn_stop_timeout': 'OpenVPN-stop ikke bekræftet',
      'openvpn_profile_unavailable': 'Lokal OpenVPN-profil mangler',
      'openvpn_native_failed': 'Indbygget OpenVPN-kald afbrudt',
      'openvpn_key_generation_failed':
          'OpenVPN P-256-nøglen kunne ikke oprettes',
      'openvpn_csr_generation_failed': 'OpenVPN-CSR kunne ikke oprettes',
      'openvpn_identity_store_failed': 'OpenVPN-identiteten blev ikke gemt',
      'openvpn_identity_clear_failed': 'Ufuldstændig fjernelse af OpenVPN',
      'openvpn_identity_in_use': 'OpenVPN-identiteten er stadig i brug',
      'openvpn_tls_verification_required': 'OpenVPN TLS-bekræftelse mangler',
      'openvpn_cipher_invalid': 'Ugyldig OpenVPN-kryptering',
      'openvpn_profile_rejected': 'OpenVPN-profil afvist',
      'openvpn_identity_inconsistent': 'OpenVPN-identiteten er inkonsekvent',
      'tls_handshake_failed': 'OpenVPN-forhandling afvist',
      'tls_alert_unknown_ca': 'OpenVPN-klientcertifikat ikke genkendt',
      'tls_alert_bad_certificate': 'OpenVPN-klientcertifikat afvist',
      'tls_alert_unsupported_certificate':
          'OpenVPN-certifikat understøttes ikke',
      'tls_client_certificate_required': 'OpenVPN-klientcertifikat påkrævet',
      'tls_alert_misc': 'OpenVPN TLS-alarm',
      'tls_signature_algorithm_rejected': 'OpenVPN-signatur understøttes ikke',
      'tls_handshake_rejected': 'OpenVPN TLS-forhandling afvist',
      'tls_version_rejected': 'Inkompatibel OpenVPN TLS-version',
      'tls_certificate_expired': 'TLS-certifikat udløbet',
      'tls_certificate_revoked': 'TLS-certifikat tilbagekaldt',
      'transport_failed': 'OpenVPN-server ikke tilgængelig',
      'tun_configuration_rejected': 'OpenVPN-grænseflade kunne ikke oprettes',
      'tun_setup_failed': 'OpenVPN TUN-konfiguration mislykkedes',
      'tun_interface_create_failed':
          'Oprettelse af OpenVPN-grænseflade mislykkedes',
      'tun_interface_disabled': 'OpenVPN-grænseflade deaktiveret',
      'tun_halted': 'OpenVPN-grænseflade afbrudt',
      'tun_already_established': 'OpenVPN-grænseflade allerede åben',
      'tun_addresses_missing': 'OpenVPN-adresse mangler',
      'tun_routes_missing': 'OpenVPN-ruter mangler',
      'tun_dns_missing': 'OpenVPN-DNS mangler',
      'tun_permission_revoked': 'VPN-tilladelse tilbagekaldt',
      'tun_establish_returned_null': 'Android afviste VPN-grænsefladen',
      'openvpn_service_start_failed': 'OpenVPN-tjeneste ikke tilgængelig',
      'openvpn_operation_timeout': 'OpenVPN-kald fik timeout',
      'openvpn_start_failed': 'OpenVPN-start afvist',
      'openvpn_connection_failed': 'OpenVPN-forbindelse afbrudt',
      'openvpn_core_status_error': 'OpenVPN Core afsluttede med en fejl',
      'openvpn_stopped_before_connected': 'OpenVPN stoppede før forbindelse',
      'openvpn_auth_failed': 'OpenVPN-godkendelse afvist',
      'openvpn_client_setup_failed': 'OpenVPN-klientopsætning mislykkedes',
      'openvpn_client_halted': 'OpenVPN-klient afbrudt',
      'openvpn_client_restart': 'OpenVPN-genstart anmodet',
      'openvpn_inactive_timeout': 'OpenVPN inaktiv for længe',
      'openvpn_session_expired': 'OpenVPN-session udløbet',
      'openvpn_credentials_required': 'OpenVPN-godkendelse understøttes ikke',
      'openvpn_proxy_failed': 'OpenVPN-mellemtransport mislykkedes',
      'openvpn_compression_failed': 'OpenVPN-komprimering afvist',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM-kryptering ikke tilgængelig',
      'openvpn_feature_unsupported': 'OpenVPN-funktion understøttes ikke',
      'network_unavailable': 'Internetforbindelsen er utilgængelig',
      'network_lost': 'Netværk ikke tilgængeligt',
      'certificate_validation_failed': 'Servercertifikat afvist',
      'openvpn_certificate_expired': 'OpenVPN-certifikat udløbet',
      'tunnel_active_for_another_account':
          'En anden kontos tunnel er stadig aktiv',
      'tunnel_already_active': 'Indbygget tunnel allerede aktiv',
      'tunnel_stop_timeout': '$protocol-stop ikke bekræftet',
      'tunnel_disconnected': '$protocol afbrudt',
      'native_bridge_unavailable': 'Android-bro ikke tilgængelig',
      'native_operation_failed': 'Android-handling afbrudt',
      'invalid_arguments': 'Ufuldstændige VPN-parametre',
      'invalid_account_id': 'Ugyldig VPN-konto',
      'invalid_device_id': 'Ugyldig enhedsidentifikator',
      'storage_key_not_allowed': 'Lager-nøgle afvist',
      'secure_storage_read_failed': 'Sikker læsning mislykkedes',
      'secure_storage_write_failed': 'Sikker skrivning mislykkedes',
      'key_generation_failed': 'WireGuard-nøgle kunne ikke genereres',
      'csr_generation_failed': 'OpenVPN-CSR kunne ikke genereres',
      'other': 'Uklassificeret indbygget VPN-fejl',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android kan ikke finde en VPN-session, der kan genoptages. Start en ny forbindelse i appen.',
      'system_vpn_resume_corrupt':
          'De gemte data til genoptagelse af VPN er ugyldige og vil ikke blive brugt. Start en ny forbindelse.',
      'system_vpn_resume_session_invalid':
          'Den gemte session kan ikke længere genoptage VPN. Log ind igen i appen.',
      'system_vpn_resume_identity_changed':
          'Den lokale VPN-identitet blev ændret. Genoptagelsen blev stoppet; start en ny forbindelse.',
      'system_vpn_resume_identity_invalid':
          'Identiteten til genoptagelse er ugyldig. Start en ny forbindelse.',
      'system_vpn_resume_storage_failed':
          'Android kunne ikke læse eller opdatere krypterede data til genoptagelse. Start en ny forbindelse.',
      'system_vpn_resume_network_timeout':
          'Android fandt ikke et netværk i tide til at genoptage VPN. Prøv igen, når et netværk er tilgængeligt.',
      'system_vpn_resume_blocked':
          'Genoptagelse af VPN er blokeret. Kontroller Android-indstillingerne, og start derefter en ny forbindelse.',
      'system_vpn_resume_failed':
          'Genoptagelse af Android-VPN mislykkedes. Start en ny forbindelse i appen.',
      'system_vpn_resume_error_invalid':
          'Android returnerede en ubrugelig fejl ved genoptagelse. Start en ny forbindelse.',
      'wireguard_identity_store_failed':
          'Android kunne ikke gemme denne kontos krypterede WireGuard-identitet.',
      'wireguard_identity_unavailable':
          'Ingen brugbar WireGuard-identitet er tilgængelig for denne forbindelse.',
      'vpn_host_destroyed':
          'Android-komponenten, der var vært for VPN, blev stoppet. Start en ny forbindelse.',
      'vpn_host_unavailable':
          'Android kan ikke oprette komponenten, der er vært for VPN. Prøv igen efter at have kontrolleret VPN-indstillingerne.',
      'openvpn_renewal_required':
          'Certifikatet kræver en handling i appen, før der kan oprettes forbindelse.',
      'openvpn_recovery_failed':
          'Automatisk gendannelse mislykkedes. Start en ny forbindelse i appen.',
      'openvpn_recovery_exhausted':
          'Automatisk gendannelse er allerede brugt. Start en ny forbindelse i appen.',
      'vpn_permission_required':
          'Android kræver en ny VPN-godkendelse, før tunnelen kan startes.',
      'vpn_permission_denied':
          'Tillad FuzeVPN i Android-anmodningen for at fortsætte.',
      'vpn_permission_request_failed':
          'Android kunne ikke åbne VPN-tilladelsesskærmen.',
      'wireguard_foreground_service_unavailable':
          'Android kunne ikke holde WireGuard-tjenesten i forgrunden.',
      'wireguard_identity_invalid':
          'Denne kontos krypterede WireGuard-nøgle kan ikke læses eller er ugyldig.',
      'wireguard_identity_in_use':
          'En anden handling bruger stadig denne kontos WireGuard-nøgle.',
      'wireguard_configuration_invalid':
          'Den modtagne WireGuard-adresse, DNS, servernøgle eller ruter er ugyldige.',
      'wireguard_operation_pending':
          'Den forrige WireGuard-handling har endnu ikke frigivet sin indbyggede tjeneste.',
      'wireguard_start_failed':
          'WireGuard-motoren afviste aktivering af konfigurationen.',
      'wireguard_stop_timeout':
          'WireGuard-tjenesten bekræftede ikke frigivelsen af VPN-grænsefladen inden for tidsgrænsen.',
      'wireguard_handshake_timeout':
          'Tunnelen bekræftede ikke et håndtryk med serveren i tide.',
      'openvpn_connection_timeout':
          'OpenVPN bekræftede ikke forbindelsen til serveren i tide.',
      'openvpn_core_unavailable':
          'Denne appversion indeholder ikke en brugbar OpenVPN-motor.',
      'openvpn_operation_pending':
          'Den indbyggede motor holder stadig den forrige OpenVPN-session og nægter at oprette en ny.',
      'openvpn_stop_timeout':
          'OpenVPN Core bekræftede ikke, at den indbyggede session blev stoppet og ødelagt inden for tidsgrænsen.',
      'openvpn_profile_unavailable':
          'Ingen valideret OpenVPN-profil kan læses til denne forbindelse.',
      'openvpn_native_failed':
          'En appfejl afbrød OpenVPN. Prøv at oprette forbindelse igen. Hvis problemet fortsætter, skal du køre en diagnosticering.',
      'openvpn_key_generation_failed':
          'Android Keystore kunne ikke oprette eller læse den ikke-eksporterbare private P-256-nøgle.',
      'openvpn_csr_generation_failed':
          'Android Keystore-nøglen kunne ikke signere OpenVPN-certifikatanmodningen.',
      'openvpn_identity_store_failed':
          'OpenVPN-certifikatet eller profilen kunne ikke gemmes i krypteret lager.',
      'openvpn_identity_clear_failed':
          'Android kunne ikke fjerne hele den lokale OpenVPN-identitet for denne konto.',
      'openvpn_identity_in_use':
          'En indbygget OpenVPN-session bruger stadig denne enheds nøgle eller certifikat.',
      'openvpn_tls_verification_required':
          'Profilen kræver ikke udtrykkeligt bekræftelse af servercertifikatet.',
      'openvpn_cipher_invalid':
          'Serveren angav en krypteringsalgoritme, der ikke er på den tilladte liste.',
      'openvpn_profile_rejected':
          'Profilen fra serveren er inkompatibel. Opret denne enhed igen, og prøv igen.',
      'openvpn_identity_inconsistent':
          'Certifikatet matcher ikke denne telefons sikre identitet. Ingen lokal profil blev erstattet.',
      'tls_handshake_failed':
          'Serveren afviste TLS-forhandlingen. Opret profilen igen, hvis problemet fortsætter.',
      'tls_alert_unknown_ca':
          'Serveren genkender ikke denne enhedscertifikats certifikatmyndighed. OpenVPN-serveren skal kontrolleres.',
      'tls_alert_bad_certificate':
          'Serveren afviste dette enhedscertifikat. Opret enheden igen, før du prøver igen.',
      'tls_alert_unsupported_certificate':
          'Serveren understøtter ikke den sikre certifikattype, som Android bruger.',
      'tls_client_certificate_required':
          'Serveren kræver et klientcertifikat, men OpenVPN Core kunne ikke præsentere et.',
      'tls_alert_misc':
          'Serveren returnerede en TLS-alarm uden for kategorierne certifikat og version.',
      'tls_signature_algorithm_rejected':
          'Serveren afviste Android Keystore-nøglens ECDSA P-256-algoritme.',
      'tls_handshake_rejected':
          'Serveren afbrød TLS-forhandlingen før forbindelsen.',
      'tls_version_rejected':
          'Klienten og serveren fandt ingen fælles TLS-version.',
      'tls_certificate_expired':
          'Certifikatet, der blev præsenteret under forbindelsen, er udløbet.',
      'tls_certificate_revoked':
          'Certifikatet, der blev præsenteret under forbindelsen, er tilbagekaldt.',
      'transport_failed':
          'OpenVPN-serveren svarer ikke på det aktuelle netværk. Prøv igen om lidt.',
      'tun_configuration_rejected':
          'Android afviste den netværkskonfiguration, som OpenVPN anmodede om.',
      'tun_setup_failed':
          'OpenVPN Core afviste netværksplanen, før Android-grænsefladen blev oprettet.',
      'tun_interface_create_failed':
          'OpenVPN Core kunne ikke få TUN-grænsefladen fra Android VpnService.',
      'tun_interface_disabled':
          'Android eller OpenVPN Core deaktiverede TUN-grænsefladen under forbindelsen.',
      'tun_halted':
          'OpenVPN Core modtog en anmodning om at stoppe TUN-grænsefladen.',
      'tun_already_established':
          'OpenVPN anmodede om en ekstra grænseflade i den samme forbindelse. Tunnelen blev stoppet af sikkerhedshensyn.',
      'tun_addresses_missing':
          'Serveren leverede ikke en brugbar tunneladresse.',
      'tun_routes_missing': 'Serveren leverede ikke brugbare tunnelruter.',
      'tun_dns_missing': 'Serveren leverede ikke en brugbar DNS-server.',
      'tun_permission_revoked':
          'Android tilbagekaldte VPN-tilladelsen under forbindelsen.',
      'tun_establish_returned_null':
          'Android oprettede ikke grænsefladen, normalt fordi en anden VPN stadig er aktiv.',
      'openvpn_service_start_failed':
          'Android kunne ikke starte OpenVPN-forgrundstjenesten.',
      'openvpn_operation_timeout':
          'Et JNI-kald til OpenVPN Core overskred sin maksimale varighed.',
      'openvpn_start_failed':
          'Android-tjenesten er klar, men OpenVPN Core accepterede ikke at starte profilen.',
      'openvpn_connection_failed':
          'OpenVPN Core stoppede, før CONNECTED-hændelsen blev sendt.',
      'openvpn_core_status_error':
          'Den indbyggede OpenVPN-løkke sluttede med en fejl uden en mere specifik afsluttende hændelse.',
      'openvpn_stopped_before_connected':
          'Den indbyggede OpenVPN-løkke stoppede før CONNECTED uden en eksplicit Core-fejl.',
      'openvpn_auth_failed': 'OpenVPN-serveren afviste profilens godkendelse.',
      'openvpn_client_setup_failed':
          'OpenVPN Core kunne ikke initialisere klienten før netværksforbindelsen.',
      'openvpn_client_halted':
          'OpenVPN Core modtog en afsluttende klientstopanmodning.',
      'openvpn_client_restart':
          'OpenVPN Core anmodede om genstart af sin transportsession.',
      'openvpn_inactive_timeout':
          'OpenVPN Core lukkede sessionen efter timeout for inaktivitet.',
      'openvpn_session_expired':
          'Serveren oplyste, at OpenVPN-sessionen er udløbet.',
      'openvpn_credentials_required':
          'Serveren eller en proxy anmoder om interaktive legitimationsoplysninger, som ikke er en del af denne certifikatprofil.',
      'openvpn_proxy_failed':
          'OpenVPN Core rapporterede en fejl i den konfigurerede proxy eller relay.',
      'openvpn_compression_failed':
          'OpenVPN Core afviste den komprimeringstilstand, som profilen eller serveren annoncerede.',
      'openvpn_ntlm_crypto_unavailable':
          'Profilen anmoder om NTLM-kryptering, som ikke er tilgængelig i denne version.',
      'openvpn_feature_unsupported':
          'Profilen eller serveren kræver en funktion, der mangler i denne Android-klient.',
      'network_unavailable': 'Intet brugbart fysisk netværk er tilgængeligt.',
      'network_lost': 'Tunnelen blev stoppet, efter netværket gik tabt.',
      'certificate_validation_failed':
          'OpenVPN-serverens identitet kunne ikke bekræftes.',
      'openvpn_certificate_expired':
          'Forny OpenVPN-profilen, før du opretter forbindelse igen.',
      'tunnel_active_for_another_account':
          'En tunnel, der tilhører en anden konto, skal stoppes, før denne forbindelse kan oprettes.',
      'tunnel_already_active':
          'Android rapporterer, at en tidligere VPN-session stadig bruger grænsefladen.',
      'tunnel_stop_timeout':
          '$protocol-motoren bekræftede ikke frigivelsen af VPN-grænsefladen inden for tidsgrænsen.',
      'tunnel_disconnected':
          'Den indbyggede motor rapporterede, at tunnelen sluttede uventet efter start.',
      'native_bridge_unavailable':
          'Appen kan ikke få adgang til Androids VPN-tjeneste. Luk og åbn appen igen, og prøv derefter.',
      'native_operation_failed':
          'En appfejl afbrød VPN-handlingen. Prøv igen. Hvis problemet fortsætter, skal du køre en diagnosticering.',
      'invalid_arguments':
          'Oplysningerne til denne VPN-handling er ufuldstændige. Prøv igen. Hvis problemet fortsætter, skal du køre en diagnosticering.',
      'invalid_account_id':
          'Den indbyggede handling er ikke knyttet til en gyldig kontoidentifikator.',
      'invalid_device_id':
          'Den enhedsidentifikator, der blev sendt til den indbyggede motor, mangler eller er ugyldig.',
      'storage_key_not_allowed':
          'Android-broen blokerede en nøgle uden for den tilladte lagerliste.',
      'secure_storage_read_failed':
          'Android Keystore kunne ikke dekryptere denne kontos lokale data.',
      'secure_storage_write_failed':
          'Android Keystore kunne ikke kryptere eller gemme de lokale data.',
      'key_generation_failed':
          'Android kunne ikke oprette eller læse WireGuard-nøglen i det sikre lager.',
      'csr_generation_failed':
          'Android Keystore kunne ikke oprette eller signere OpenVPN P-256-CSR\'en.',
      'other':
          'En udokumenteret indbygget gren mislykkedes. Send diagnosticeringskoden nedenfor til support.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Tilladelsesanmodningen er allerede åben';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Androids VPN-tilladelsesanmodning vises allerede. Gennemfør den, før du prøver igen.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-tilladelsesanmodningen blev afbrudt';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN-tilladelsesskærmen blev lukket, før appen modtog et svar.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-forbindelsen er ikke bekræftet';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN-forbindelsen kunne ikke bekræftes. Den blev stoppet af sikkerhedshensyn. Prøv igen.';

  @override
  String get openvpnCleanup_title => 'OpenVPN-profil tilbagekaldt';

  @override
  String get openvpnCleanup_working =>
      'Stopper og fjerner den tilbagekaldte OpenVPN-profil…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-nedlukningen er ikke bekræftet. Prøv igen, før du opretter en ny profil.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Den tilbagekaldte OpenVPN-profil kunne ikke fjernes helt. Prøv at rydde op igen.';

  @override
  String get openvpnCleanup_complete =>
      'Den tilbagekaldte OpenVPN-profil er fjernet. Tryk på Opret forbindelse for at oprette en ny.';

  @override
  String get network_title => 'Netværkskonfiguration';

  @override
  String get network_ipv4Fallback =>
      'IPv6 er midlertidigt utilgængelig. Klargøringen fortsætter med IPv4.';

  @override
  String get network_rejectedTitle => 'Netværkskonfiguration afvist';

  @override
  String get network_rejectedMessage =>
      'Tunnelkonfigurationen er ufuldstændig eller stemmer ikke overens med de godkendte adresser. Prøv igen fra appen.';

  @override
  String get network_unreadableTitle => 'Lokal konfiguration kan ikke læses';

  @override
  String get network_unreadableMessage =>
      'Den gemte OpenVPN-netværkskonfiguration kan ikke bruges. Opret forbindelse igen fra appen for at opdatere den.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Netværksbeskyttelse';

  @override
  String get protection_subtitle =>
      'Bloker direkte internetadgang, hvis VPN-forbindelsen afbrydes.';

  @override
  String get protection_active => 'Systembeskyttelse aktiv';

  @override
  String get protection_alwaysOnOnly =>
      'VPN altid til er aktiveret; slå blokering uden for VPN til';

  @override
  String get protection_inactive => 'Systembeskyttelse inaktiv';

  @override
  String get protection_unknown => 'Kontroller systembeskyttelsen';

  @override
  String get protection_openSettings => 'Åbn Android-indstillinger';

  @override
  String get protection_dialogTitle => 'Konfigurer netværksbeskyttelse';

  @override
  String get protection_dialogMessage =>
      'Android administrerer VPN altid til og blokering af forbindelser uden for VPN. Kontroller, at FuzeVPN er valgt, og aktivér blokering i systemindstillingerne.';

  @override
  String get protection_dialogOpen => 'Åbn indstillinger';

  @override
  String get session_systemProtectionNote =>
      'Hvis Android stadig blokerer trafik uden for VPN, skal du åbne systemindstillingerne for at kontrollere eller ændre denne beskyttelse.';

  @override
  String get diagnostics_title => 'Diagnosticering';

  @override
  String get diagnostics_settingsTitle => 'Appdiagnosticering';

  @override
  String get diagnostics_automaticTitle => 'Send vigtige fejl';

  @override
  String get diagnostics_automaticDescription =>
      'Del en kort teknisk rapport, når der opstår en vigtig fejl.';

  @override
  String get diagnostics_privacy =>
      'Sendte rapporter er knyttet til den konto, du er logget ind på, og opbevares i 30 dage. De indeholder ingen browserhistorik, adgangskoder eller VPN-nøgler.';

  @override
  String get diagnostics_manualOpen => 'Kør diagnosticering';

  @override
  String get diagnostics_localDescription =>
      'Opret en rapport om appens og VPN-forbindelsens status. Din forbindelse forbliver uændret.';

  @override
  String get diagnostics_sendReport => 'Send rapporten';

  @override
  String get diagnostics_sendHint =>
      'Lad dette felt være umarkeret for at beholde rapporten på denne enhed.';

  @override
  String get diagnostics_signedOut =>
      'Log ind på din konto for at sende en rapport.';

  @override
  String get diagnostics_localLifetime =>
      'Gem denne rapport på din telefon for at beholde den, efter appen er lukket.';

  @override
  String get diagnostics_run => 'Kør diagnosticering';

  @override
  String get diagnostics_rerun => 'Kør diagnosticering igen';

  @override
  String get diagnostics_running => 'Kontrollerer…';

  @override
  String get diagnostics_sending => 'Sender rapport…';

  @override
  String get diagnostics_prepared => 'Rapport klar på denne enhed';

  @override
  String get diagnostics_queued => 'Rapport afventer afsendelse';

  @override
  String get diagnostics_sent => 'Rapport modtaget';

  @override
  String get diagnostics_failed =>
      'Afsendelsen mislykkedes. Din lokale rapport er stadig tilgængelig.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnosticeringsrapporten kunne ikke klargøres. Prøv igen.';

  @override
  String get diagnostics_authenticationRequired =>
      'Log ind igen for at sende rapporten.';

  @override
  String get diagnostics_retry => 'Prøv at sende igen';

  @override
  String get diagnostics_export => 'Gem rapport';

  @override
  String get diagnostics_exportFailed =>
      'Eksporten mislykkedes. Prøv igen fra den lokale rapport.';

  @override
  String get diagnostics_preferenceFailed =>
      'Denne indstilling kunne ikke gemmes. Prøv igen.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Reference: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Modtaget $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Opbevares indtil $date';
  }

  @override
  String get diagnostics_duplicate => 'Denne rapport var allerede modtaget.';

  @override
  String get diagnostics_preview => 'Forhåndsvisning af rapport';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tekniske hændelser vedhæftet',
      one: '$count teknisk hændelse vedhæftet',
      zero: '$count tekniske hændelser vedhæftet',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tekniske detaljer';

  @override
  String get diagnostics_empty =>
      'Der er endnu ikke klargjort nogen diagnosticeringsrapport.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunneltilstand',
      'handshake': 'Forbindelsesbekræftelse',
      'certificate': 'VPN-certifikat',
      'kill_switch': 'Android-beskyttelse',
      'connectivity': 'Tilgængeligt netværk',
      'api_reachability': 'Tjenesteadgang',
      'secure_storage': 'Sikkert lager',
      'other': 'Lokal kontrol',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Kontrolleret',
      'failed': 'Kræver opmærksomhed',
      'skipped': 'Ikke testet — ingen aktiv kontrol',
      'unknown': 'Oplysninger ikke tilgængelige',
      'other': 'Oplysninger ikke tilgængelige',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Velkommen til FuzeVPN';

  @override
  String get connection_changeLocation => 'Skift placering';

  @override
  String get connection_details => 'Forbindelsesoplysninger';

  @override
  String get locations_searchLabel => 'Søg efter en by eller et land';

  @override
  String get locations_clearSearch => 'Ryd søgning';

  @override
  String get locations_filterAll => 'Alle';

  @override
  String get locations_filterFavorites => 'Favoritter';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count placeringer',
      one: '$count placering',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Ingen placeringer fundet';

  @override
  String get locations_noResultsHint => 'Prøv en anden by eller et andet land.';

  @override
  String get locations_noFavorites => 'Dine favoritter lige ved hånden';

  @override
  String get locations_noFavoritesHint =>
      'Tryk på stjernen ved siden af en placering for at gemme den her.';

  @override
  String get locations_showAll => 'Se alle placeringer';

  @override
  String locations_addFavorite(String name) {
    return 'Føj $name til favoritter';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Fjern $name fra favoritter';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Favoritten kunne ikke gemmes. Prøv igen.';

  @override
  String get locations_emptyTitle => 'Ingen placeringer tilgængelige';

  @override
  String get locations_emptyHint => 'Opdater listen for at prøve igen.';

  @override
  String get devices_manage => 'Administrer mine enheder';

  @override
  String get settings_personalization => 'Gør den til din egen';

  @override
  String get settings_safety => 'Beskyttelse';

  @override
  String get settings_help => 'Har du brug for hjælp?';

  @override
  String get settings_about => 'Om FuzeVPN';

  @override
  String get diagnostics_heading => 'Forstå et forbindelsesproblem';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Tilgængelig',
      'pending': 'Forbereder',
      'revoked': 'Fjernet',
      'expired': 'Udløbet',
      'other': 'Status ikke tilgængelig',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Præference ikke gemt';

  @override
  String get notice_preferenceSave_message =>
      'Dit valg er anvendt indtil videre, men kunne ikke gemmes. Prøv igen for at beholde det, efter appen er lukket.';

  @override
  String get connection_androidDisconnectHint =>
      'Hvis Android holder VPN aktiv, skal du slå VPN altid til fra i de indstillinger, der åbnes.';

  @override
  String get protection_learnMore => 'Læs om Android-beskyttelse';

  @override
  String get protection_guideWhy =>
      'Denne beskyttelse forhindrer apps i at bruge internettet direkte, hvis VPN-forbindelsen afbrydes. Den konfigureres i Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN altid til';

  @override
  String get protection_guideAlwaysOn =>
      'Android holder VPN-tjenesten kørende og kan genstarte den, efter telefonen genstartes.';

  @override
  String get protection_guideBlockTitle => 'Bloker forbindelser uden VPN';

  @override
  String get protection_guideBlock =>
      'Denne indstilling forhindrer trafik i at omgå VPN, også mens forbindelsen er afbrudt.';

  @override
  String get protection_guideWarning =>
      'Når denne blokering er aktiveret, forbliver internetadgangen slået fra, indtil VPN er forbundet.';

  @override
  String get protection_guideStepsTitle => 'Slå beskyttelse til';

  @override
  String get protection_guideStep1 =>
      'Åbn Androids VPN-indstillinger med knappen nedenfor.';

  @override
  String get protection_guideStep2 =>
      'Åbn indstillingerne med tandhjulsikonet ved siden af FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Aktivér VPN altid til og derefter Bloker forbindelser uden VPN, hvis disse indstillinger er tilgængelige.';

  @override
  String get protection_guideManufacturers =>
      'Navnene varierer fra telefon til telefon. Søg om nødvendigt efter VPN i Indstillinger, ofte under Netværk og internet.';

  @override
  String get protection_guideDisableTitle => 'Slå denne beskyttelse fra';

  @override
  String get protection_guideDisable =>
      'Slå blokering uden VPN fra i de samme indstillinger for at tillade internetadgang uden VPN. Slå også VPN altid til fra, hvis du ikke længere ønsker, at Android genstarter den.';

  @override
  String get protection_guideManual =>
      'Du vælger disse indstillinger i Android. FuzeVPN ændrer dem ikke for dig.';

  @override
  String get locations_changeTitle => 'Skift placering?';

  @override
  String locations_changeActive(String name) {
    return 'VPN afbryder forbindelsen og forsøger derefter at oprette forbindelse til $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN forsøger at oprette forbindelse til $name.';
  }

  @override
  String get locations_confirmChange => 'Skift og opret forbindelse';

  @override
  String get locations_changeBusy =>
      'Et skift er i gang. Vent, før du vælger en anden placering.';

  @override
  String get locations_automaticSelection => 'Automatisk valg';

  @override
  String get locations_cities => 'Byer';

  @override
  String get locations_servers => 'Servere';

  @override
  String locations_viewCities(String name) {
    return 'Se byer i $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Se servere i $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lande',
      one: '$count land',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count byer',
      one: '$count by',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servere',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Alle lande';

  @override
  String get locations_backToCountries => 'Tilbage til lande';

  @override
  String locations_backToCities(String name) {
    return 'Tilbage til byer i $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Vælg $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Vælg $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Ingen kompatibel server er tilgængelig.';

  @override
  String get externalLink_failed =>
      'Linket kunne ikke åbnes. Du kan kopiere det og åbne det i din browser.';

  @override
  String get externalLink_copy => 'Kopiér link';

  @override
  String get externalLink_copied => 'Link kopieret';

  @override
  String get externalLink_copyFailed =>
      'Linket kunne ikke kopieres. Markér adressen nedenfor.';

  @override
  String get settings_deleteAccount => 'Slet min konto';

  @override
  String get settings_deleteAccountDetail =>
      'Se, hvordan du anmoder om at få slettet kontoen';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Vælg dit VPN-abonnement.';

  @override
  String get billing_subscribe => 'Abonner';

  @override
  String get billing_choosePlan => 'Vælg et abonnement for at fortsætte.';

  @override
  String get billing_monthly => 'Månedligt';

  @override
  String get billing_yearly => 'Årligt';

  @override
  String get billing_continue => 'Fortsæt med Google Play';

  @override
  String get billing_restore => 'Gendan køb';

  @override
  String get billing_manage => 'Administrer abonnement';

  @override
  String get billing_deleteAccountWarning =>
      'Hvis du har et abonnement via Google Play, stopper sletning af din FuzeVPN-konto ikke fornyelsen. Administrer eller stop fornyelsen separat i Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Fortsæt til anmodning om kontosletning';

  @override
  String get billing_refresh => 'Opdater adgang';

  @override
  String get billing_loadingPlans => 'Indlæser abonnementer…';

  @override
  String get billing_unavailable =>
      'Ingen abonnementer er tilgængelige lige nu. Prøv igen senere.';

  @override
  String get billing_comingSoon => 'Abonnementer kommer snart.';

  @override
  String get billing_priceDisclosure =>
      'Pris fra Google Play. Slutbeløb og gældende afgifter vises, før du bekræfter.';

  @override
  String get billing_renewalMonthly =>
      'Fornyes automatisk hver måned, medmindre det opsiges. Du kan opsige når som helst under Google Play-abonnementer.';

  @override
  String get billing_renewalYearly =>
      'Fornyes automatisk hvert år, medmindre det opsiges. Du kan opsige når som helst under Google Play-abonnementer.';

  @override
  String get billing_active => 'Din Premium-adgang er aktiv';

  @override
  String billing_accessUntil(String date) {
    return 'Adgang indtil $date.';
  }

  @override
  String get billing_webManaged =>
      'Dit abonnement administreres på FuzeVPNs hjemmeside.';

  @override
  String get billing_playManaged =>
      'Dit abonnement administreres via Google Play.';

  @override
  String get billing_inactive => 'Intet aktivt abonnement.';

  @override
  String get billing_checkingAccess => 'Kontrollerer din adgang…';

  @override
  String get billing_restoring => 'Gendanner køb…';

  @override
  String get billing_pending =>
      'Betalingen afventer. Din adgang aktiveres efter bekræftelse.';

  @override
  String get billing_cancelled =>
      'Købet blev annulleret. Intet nyt abonnement blev aktiveret.';

  @override
  String get billing_verifying => 'Bekræfter køb…';

  @override
  String get billing_success =>
      'Abonnementet er aktiveret. Din Premium-adgang er klar.';

  @override
  String get billing_restored => 'Dine køb er gendannet.';

  @override
  String get billing_restoreEmpty =>
      'Ingen køb at gendanne for denne Google Play-konto.';

  @override
  String get billing_catalogError =>
      'Kunne ikke indlæse abonnementer. Prøv igen.';

  @override
  String get billing_purchaseError => 'Kunne ikke starte købet. Prøv igen.';

  @override
  String get billing_verificationError =>
      'Bekræftelse af køb er midlertidigt utilgængelig. Gendan køb for at prøve igen.';

  @override
  String get billing_restoreError => 'Kunne ikke gendanne køb. Prøv igen.';

  @override
  String get billing_managementError =>
      'Kunne ikke åbne abonnementsadministration. Prøv igen.';

  @override
  String get billing_storeUnavailable =>
      'Google Play er ikke tilgængelig på denne enhed.';

  @override
  String get welcome_title => 'Din VPN, helt enkelt.';

  @override
  String get welcome_description =>
      'Beskyt din forbindelse. Bevar kontrollen over dit privatliv.';

  @override
  String get welcome_start => 'Kom i gang';

  @override
  String get welcome_alreadyPurchased => 'Har du allerede købt?';

  @override
  String get welcome_noAccountRequired =>
      'Du behøver ikke oprette en konto for at komme i gang.';

  @override
  String get guest_accountTitle => 'Kontoen er ikke tilknyttet';

  @override
  String get guest_accountDescription =>
      'Gendan dine køb med den samme Google Play-konto for at bruge abonnementet på en anden enhed.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Har du allerede et abonnement? Log ind';

  @override
  String get guest_claimTitle => 'Tag FuzeVPN med dig';

  @override
  String get guest_claimDescription =>
      'Opret en konto for at bruge dit abonnement på dine andre enheder. Dette trin er valgfrit.';

  @override
  String get guest_skip => 'Senere';

  @override
  String get guest_activationTitle => 'Fuze Premium er aktivt';

  @override
  String get guest_activationDescription =>
      'Dit abonnement er klar. Brug din VPN, og opret en konto, når du har lyst.';

  @override
  String get guest_useVpn => 'Brug min VPN';

  @override
  String get guest_loginRequired =>
      'Dette køb er allerede tilknyttet en FuzeVPN-konto. Log ind på den konto for at bruge dit abonnement.';

  @override
  String get guest_signOutWarning =>
      'Du kan få dit abonnement tilbage ved at gendanne køb med den samme Google Play-konto.';

  @override
  String get guest_profileUnavailable =>
      'Din konto er allerede tilknyttet. Log ind for at se og administrere dine oplysninger.';

  @override
  String get billing_acceptance =>
      'Ved at fortsætte accepterer du Brugsvilkårene og Privatlivspolitikken.';

  @override
  String get guest_verifyEmailReminder =>
      'Bekræft din e-mailadresse for at beskytte din konto. Du kan fortsætte med at bruge din VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Tjenesten er midlertidigt utilgængelig. Prøv igen om lidt.';

  @override
  String get guest_restoreError =>
      'Dine køb kunne ikke gendannes. Prøv igen med den Google Play-konto, du brugte til købet.';

  @override
  String get guest_claimSuccess =>
      'Din konto er oprettet. Dit abonnement og din VPN-adgang er bevaret.';

  @override
  String get guest_emailExists =>
      'Denne e-mailadresse er allerede i brug. Vælg en anden adresse, eller log ind på din eksisterende konto. Dit køb er stadig tilgængeligt via Google Play.';

  @override
  String get guest_claimError =>
      'Din konto kunne ikke oprettes. Du kan fortsætte med at bruge din VPN og prøve igen senere.';

  @override
  String get guest_secureStorageError =>
      'Din session kunne ikke gemmes sikkert på denne enhed. Prøv igen.';

  @override
  String get guest_premiumRequired =>
      'Vælg et abonnement for at aktivere din VPN.';

  @override
  String get welcome_viewPlans => 'Se abonnementer';

  @override
  String get google_continue => 'Fortsæt med Google';

  @override
  String get google_or => 'eller';

  @override
  String get google_title => 'Din FuzeVPN-konto';

  @override
  String get google_settingUp => 'Færdiggør din konto';

  @override
  String get google_country => 'Bopælsland';

  @override
  String get google_profileDescription =>
      'Vælg dit land og læs begge dokumenter for at oprette din FuzeVPN-konto.';

  @override
  String get google_claimDescription =>
      'Knyt din gæstekonto til Google. Abonnement og enhed forbliver knyttet til denne konto.';

  @override
  String get google_linkTitle => 'Knyt Google til FuzeVPN';

  @override
  String get google_linkDescription =>
      'Bekræft adgang til din eksisterende FuzeVPN-konto. Din Google-adgangskode efterspørges ikke.';

  @override
  String get google_password => 'FuzeVPN-adgangskode';

  @override
  String get google_linkAccount => 'Bekræft tilknytning';

  @override
  String get google_requestEmail => 'Modtag en bekræftelsesmail';

  @override
  String get google_emailInstructions =>
      'Åbn mailen fra FuzeVPN og indtast bekræftelseskoden.';

  @override
  String get google_emailCode => 'Bekræftelseskode fra mail';

  @override
  String get google_confirmEmail => 'Bekræft koden';

  @override
  String get google_restart => 'Vælg en anden Google-konto';

  @override
  String get google_resume => 'Kontrollér dette forsøg';

  @override
  String get google_unavailable =>
      'Google-login er ikke tilgængeligt. Du kan bruge e-mail og adgangskode.';

  @override
  String get google_expired =>
      'Dette forsøg er udløbet. Annuller det og begynd igen.';

  @override
  String get google_conflict =>
      'Denne Google-konto er allerede knyttet til en anden konto. Din nuværende konto og dit abonnement bevares.';

  @override
  String get google_error =>
      'Google-login mislykkedes. Prøv igen; din nuværende adgang bevares.';

  @override
  String get google_uncertain =>
      'Resultatet kunne ikke bekræftes. Kontrollér forsøget eller annuller før du begynder igen.';

  @override
  String get google_cancelFailed =>
      'Annulleringen kunne ikke bekræftes. Prøv at annullere igen, før du forlader skærmen.';

  @override
  String get google_cancelled => 'Google-login annulleret.';

  @override
  String get google_selecting => 'Vælg din Google-konto…';

  @override
  String get google_verifying => 'Kontrollerer din konto…';

  @override
  String get google_emailUnavailable =>
      'Bekræftelsesmailen kunne ikke sendes. Prøv senere.';

  @override
  String get google_emailSent =>
      'Bekræftelsesmail sendt. Kontrollér din indbakke.';

  @override
  String get google_rateLimited => 'Vent før du prøver igen.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN-adgangskoden er forkert. Din nuværende konto bevares.';

  @override
  String get google_invalidCode =>
      'Bekræftelseskoden er ugyldig eller udløbet.';

  @override
  String get google_accountChanged =>
      'Sessionen er ændret. Annuller dette forsøg, før du begynder igen.';

  @override
  String get google_invalidResponse =>
      'Svaret kunne ikke valideres. Din nuværende adgang bevares.';

  @override
  String get google_invalidRegistration =>
      'Kontrollér landet og begge samtykker.';

  @override
  String get google_consentRequired =>
      'Vælg dit land og accepter begge dokumenter for at fortsætte.';

  @override
  String get google_challengeRequired =>
      'En yderligere sikkerhedskontrol er nødvendig. Din nuværende adgang bevares.';

  @override
  String get google_challengeUnavailable =>
      'Sikkerhedskontrollen er ikke tilgængelig. Prøv senere.';

  @override
  String get billing_trialTitle => 'Prøv Fuze Premium gratis';

  @override
  String get billing_trialSubtitle => 'Beskyt din forbindelse fra i dag.';

  @override
  String get billing_trialWeeks => '2 ugers gratis prøveperiode';

  @override
  String billing_trialDays(String days) {
    return '$days dages gratis prøveperiode';
  }

  @override
  String get billing_trialStart => 'Start min gratis prøveperiode';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Hvis du starter i dag, forventes den første opkrævning den $date.';
  }

  @override
  String get billing_trialTerms =>
      'Fornyes automatisk til den viste pris. Opsig i Google Play, før prøveperioden slutter, for at undgå en opkrævning.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Derefter $price pr. måned';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Derefter $price pr. år';
  }

  @override
  String get billing_choosePeriod => 'Vælg dit abonnement';

  @override
  String get billing_selectionHint => 'Vælg et abonnement for at fortsætte.';

  @override
  String get billing_benefitConnection => 'Krypteret forbindelse';

  @override
  String get billing_benefitPrivacy => 'Privatliv på nettet';

  @override
  String get billing_benefitNoAccount => 'Ingen tilmelding påkrævet';

  @override
  String get billing_cancellation => 'Opsigelse i Google Play';

  @override
  String get billing_premiumTitle => 'Din forbindelse, bedre beskyttet.';

  @override
  String get billing_premiumSubtitle =>
      'Beskyt din forbindelse i dit eget tempo.';

  @override
  String get billing_priceMonthly => 'pr. måned';

  @override
  String get billing_priceYearly => 'pr. år';

  @override
  String get billing_trialToday => 'Intet at betale i dag';

  @override
  String get billing_trialConfirmation =>
      'Google Play bekræfter datoer, slutbeløb og gældende afgifter, før du bekræfter.';

  @override
  String get billing_offerChanged =>
      'Vilkårene for dette tilbud har ændret sig. Opdater abonnementerne, og vælg igen.';
}
