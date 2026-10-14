// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Beskytt forbindelsen din';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN bruker Androids VPN-tjeneste (VpnService) til å opprette en kryptert tunnel mellom denne enheten og FuzeVPN-serverne.';

  @override
  String get vpnDisclosure_dataBody =>
      'Når VPN er aktiv, går appenes Internett-trafikk, destinasjonsadresser og DNS-forespørsler gjennom denne tunnelen for å rute forbindelsen din, også når FuzeVPN kjører i bakgrunnen.';

  @override
  String get vpnDisclosure_statusBody =>
      'Appen bruker forbindelsesstatusen, varigheten og mengden overførte data til å vise VPN-forbindelsen din. Du kan stoppe den når som helst.';

  @override
  String get vpnDisclosure_privacy => 'Personvern';

  @override
  String get vpnDisclosure_accept => 'Godta og fortsett';

  @override
  String get vpnDisclosure_decline => 'Ikke nå';

  @override
  String get accountRestoration_title => 'Konto midlertidig utilgjengelig';

  @override
  String get accountRestoration_message =>
      'Økten din er bevart. Prøv igjen for å gjenopprette kontoen; du kan fortsatt administrere VPN-tilkoblingen her.';

  @override
  String get action_retry => 'Prøv igjen';

  @override
  String get session_endingTitle => 'Avslutter økten';

  @override
  String get session_ending =>
      'Økten din er ugyldiggjort. Stopper VPN og sletter økten…';

  @override
  String get session_stopFailed =>
      'VPN-avslutningen er ikke bekreftet. Prøv igjen før du logger inn på nytt.';

  @override
  String get session_cleanupFailed =>
      'VPN er stoppet, men fjerningen av økten er ikke bekreftet. Prøv å rydde opp på nytt.';

  @override
  String get session_retryStop => 'Prøv å stoppe på nytt';

  @override
  String get session_retryCleanup => 'Prøv å rydde opp på nytt';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Gjør FuzeVPN klar på en sikker måte…';

  @override
  String get nav_connection => 'Tilkobling';

  @override
  String get nav_locations => 'Lokasjoner';

  @override
  String get nav_account => 'Konto';

  @override
  String get nav_devices => 'Enheter';

  @override
  String get nav_settings => 'Innstillinger';

  @override
  String get action_refresh => 'Oppdater';

  @override
  String get auth_tab_login => 'Logg inn';

  @override
  String get auth_tab_register => 'Registrer deg';

  @override
  String get auth_stepAccount => 'Konto';

  @override
  String get auth_stepIdentity => 'Identitet';

  @override
  String get auth_stepAddress => 'Adresse og avtaler';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Trinn $current av $total';
  }

  @override
  String get auth_tagline => 'VPN-en din, gjort enkelt.';

  @override
  String get auth_keysLocal =>
      'De private VPN-nøklene dine forblir på denne enheten.';

  @override
  String get form_email => 'E-postadresse';

  @override
  String get form_password => 'Passord';

  @override
  String get form_showPassword => 'Vis passord';

  @override
  String get form_hidePassword => 'Skjul passord';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8-byte. Noen tegn bruker mer enn én byte.';

  @override
  String get form_firstName => 'Fornavn';

  @override
  String get form_lastName => 'Etternavn';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adresse';

  @override
  String get form_address2 => 'Adresselinje 2 (valgfritt)';

  @override
  String get form_postalCode => 'Postnummer';

  @override
  String get form_city => 'By';

  @override
  String get form_country => 'Landskode (f.eks. FR)';

  @override
  String get action_login => 'Logg inn';

  @override
  String get action_createAccount => 'Opprett en konto';

  @override
  String get action_createMyAccount => 'Opprett kontoen min';

  @override
  String get action_next => 'Fortsett';

  @override
  String get action_previous => 'Tilbake';

  @override
  String get action_forgotPassword => 'Glemt passordet?';

  @override
  String get auth_noAccount => 'Har du ikke en konto ennå?';

  @override
  String get auth_requiredInformation => 'Opprett kontoen din i tre trinn.';

  @override
  String get auth_termsPrefix => 'Jeg godtar ';

  @override
  String get auth_termsLink => 'bruksvilkårene';

  @override
  String get auth_privacyPrefix => 'Jeg godtar ';

  @override
  String get auth_privacyLink => 'personvernerklæringen';

  @override
  String get auth_consentRequired => 'Du må samtykke for å opprette en konto.';

  @override
  String get validation_required => 'Dette feltet er obligatorisk.';

  @override
  String get validation_email => 'Skriv inn en gyldig e-postadresse.';

  @override
  String get validation_password =>
      'Passordet er for kort: minst 8 UTF-8-byte.';

  @override
  String get validation_passwordTooLong =>
      'Passordet er for langt: høyst 72 UTF-8-byte.';

  @override
  String get validation_phone =>
      'Bruk internasjonalt format, for eksempel +33612345678.';

  @override
  String get validation_country =>
      'Bruk en landskode med to bokstaver, for eksempel FR.';

  @override
  String get passwordReset_title => 'Tilbakestill passordet';

  @override
  String get passwordReset_description =>
      'Skriv inn e-postadressen til kontoen din for å be om en lenke for tilbakestilling av passordet.';

  @override
  String get passwordReset_send => 'Send lenke';

  @override
  String get connection_title => 'Tilkoblingen din';

  @override
  String get connection_subtitle => 'Velg en lokasjon, og slå deretter på VPN.';

  @override
  String get connection_prepare => 'Klar til å koble til?';

  @override
  String get connection_advancedOptions => 'Avanserte alternativer';

  @override
  String get connection_location => 'Lokasjon';

  @override
  String get connection_chooseLocation => 'Velg en lokasjon';

  @override
  String get connection_protocol => 'Protokoll';

  @override
  String get connection_connect => 'Koble til';

  @override
  String get connection_connecting => 'Kobler til…';

  @override
  String get connection_disconnect => 'Koble fra';

  @override
  String get connection_disconnecting => 'Kobler fra';

  @override
  String get connection_locationChange => 'Endrer lokasjon…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol er utilgjengelig';
  }

  @override
  String get connection_activeLocation => 'Aktiv lokasjon';

  @override
  String get connection_duration => 'Varighet';

  @override
  String get connection_received => 'Mottatt';

  @override
  String get connection_sent => 'Sendt';

  @override
  String get connection_lastHandshake => 'Siste sikre utveksling';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'for $duration siden';
  }

  @override
  String get verification_title => 'Bekreft e-postadressen din';

  @override
  String get verification_message =>
      'Bekreft e-postadressen din for å bruke VPN på denne telefonen.';

  @override
  String get verification_resend => 'Send e-post på nytt';

  @override
  String get migration_title => 'Endring av lokasjon';

  @override
  String get migration_draining => 'Forbereder endringen av lokasjon…';

  @override
  String get migration_activating => 'Aktiverer den nye serveren…';

  @override
  String get migration_ready => 'Lokasjonen er oppdatert.';

  @override
  String get migration_blocked =>
      'Endringen av lokasjon krever inngrep på serversiden. Prøv igjen senere eller kontakt kundestøtte.';

  @override
  String get migration_progress => 'Fremdrift for endring av lokasjon';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Tid mellom kontrollene: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Fortsett endringen av lokasjon';

  @override
  String get status_authorizing => 'Tillatelse kreves';

  @override
  String get status_authorizingDetail =>
      'Godta Android-forespørselen for å tillate VPN.';

  @override
  String get status_preparing => 'Forbereder';

  @override
  String get status_preparingDetail => 'Forbereder den sikre tilkoblingen din.';

  @override
  String get status_reconnecting => 'Kobler til på nytt…';

  @override
  String get status_reconnectingDetail =>
      'Tilkoblingen ble avbrutt. VPN prøver å koble til på nytt.';

  @override
  String get status_connecting => 'Kobler til';

  @override
  String get status_connectingDetail => 'Kobler til VPN-serveren…';

  @override
  String get status_connected => 'Tilkoblet';

  @override
  String get status_connectedDetail => 'VPN-tilkoblingen din er aktiv.';

  @override
  String get status_disconnecting => 'Kobler fra';

  @override
  String get status_disconnectingDetail => 'VPN-tilkoblingen din stoppes.';

  @override
  String get status_error => 'Tilkobling utilgjengelig';

  @override
  String get status_errorDetail =>
      'VPN-tilkoblingen er ikke bekreftet. Prøv igjen.';

  @override
  String get status_idle => 'Frakoblet';

  @override
  String get status_idleDetail =>
      'Koble til VPN for å beskytte tilkoblingen din.';

  @override
  String get trust_note =>
      'Hvis du lukker appen, stoppes ikke VPN. Bruk Koble fra for å stoppe den.';

  @override
  String get locations_none =>
      'Ingen lokasjoner er tilgjengelige for øyeblikket.';

  @override
  String get locations_available => 'Velg din neste lokasjon.';

  @override
  String get locations_selected => 'Valgt lokasjon';

  @override
  String get locations_select => 'Velg denne lokasjonen';

  @override
  String get locations_lockedTunnel => 'Koble fra VPN for å endre lokasjon.';

  @override
  String get locations_lockedMigration =>
      'Vent til endringen av lokasjon er fullført.';

  @override
  String get devices_title => 'Enhetene dine';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit enheter';
  }

  @override
  String get devices_refresh => 'Oppdater enheter';

  @override
  String get devices_empty => 'Ingen VPN-enhet er registrert ennå.';

  @override
  String get devices_firstConnection =>
      'Telefonen din blir lagt til ved første tilkobling.';

  @override
  String get devices_thisDevice => 'Denne enheten';

  @override
  String devices_added(Object date) {
    return 'Lagt til $date';
  }

  @override
  String get action_remove => 'Fjern';

  @override
  String get settings_title => 'Innstillinger';

  @override
  String get settings_subtitle => 'Preferansene og kontoen din på ett sted.';

  @override
  String get settings_appearance => 'Utseende';

  @override
  String get settings_language => 'Språk';

  @override
  String get settings_languageDescription =>
      'Språket du velger, brukes også i VPN-varsler.';

  @override
  String get settings_account => 'Konto';

  @override
  String get settings_signOut => 'Logg ut';

  @override
  String get settings_privacy => 'Personvernerklæring';

  @override
  String get settings_terms => 'Bruksvilkår';

  @override
  String get settings_security => 'Sikkerhet og åpenhet';

  @override
  String get settings_licenses => 'Komponentlisenser';

  @override
  String get settings_licensesDetail => 'Programvare som brukes i appen';

  @override
  String get settings_background =>
      'VPN forblir på når du forlater appen. Bruk Koble fra på fanen Tilkobling for å stoppe den.';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Lys';

  @override
  String get theme_dark => 'Mørk';

  @override
  String get language_system => 'Telefonspråk';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Fjerne denne enheten?';

  @override
  String get dialog_removeCurrent =>
      'Denne telefonen kobles fra VPN og mister tilgangen. VPN-tilkoblingsdataene fjernes når serveren har bekreftet det.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN-tilgangen for «$name» tilbakekalles. Dette kan ikke angres.';
  }

  @override
  String get dialog_signOut => 'Logge ut?';

  @override
  String get dialog_signOutMessage =>
      'VPN stoppes, og du må logge inn på nytt. De krypterte VPN-nøklene dine blir på denne telefonen til neste tilkobling.';

  @override
  String get action_cancel => 'Avbryt';

  @override
  String get action_signOut => 'Logg ut';

  @override
  String get notice_close => 'Lukk meldingen';

  @override
  String get notice_sessionExpired_title => 'Økten er utløpt';

  @override
  String get notice_sessionExpired_message =>
      'Økten din er utløpt. Logg inn på nytt.';

  @override
  String get notice_connectionFailed_title => 'Tilkoblingen mislyktes';

  @override
  String get notice_invalidCredentials_message =>
      'E-postadressen eller passordet er feil.';

  @override
  String get notice_emailVerification_title => 'E-postbekreftelse kreves';

  @override
  String get notice_emailVerification_message =>
      'Bekreft e-postadressen din før du legger til en VPN-enhet.';

  @override
  String get notice_rateLimited_title => 'For mange forsøk';

  @override
  String get notice_deviceLimit_title => 'Grensen på 2 enheter er nådd';

  @override
  String get notice_deviceLimit_message =>
      'Fjern en eksisterende enhet før du legger til en ny.';

  @override
  String get notice_identityRenewal_title => 'VPN-identiteten må fornyes';

  @override
  String get notice_identityRenewal_message =>
      'Denne identiteten ble fjernet. Opprett en ny lokal identitet.';

  @override
  String get notice_migrationPending_title => 'Endring av lokasjon pågår';

  @override
  String get notice_migrationPending_message =>
      'En endring av lokasjon pågår allerede.';

  @override
  String get notice_migrationBlocked_title => 'Endring av lokasjon blokkert';

  @override
  String get notice_migrationBlocked_message =>
      'Endringen av lokasjon krever inngrep på serversiden. Prøv igjen senere eller kontakt kundestøtte.';

  @override
  String get notice_targetUnavailable_title =>
      'Serveren er midlertidig utilgjengelig';

  @override
  String get notice_targetUnavailable_message =>
      'Denne serveren er midlertidig utilgjengelig.';

  @override
  String get notice_networkUnavailable_title =>
      'Internett-tilkobling utilgjengelig';

  @override
  String get notice_networkUnavailable_message =>
      'Kontroller tilkoblingen din og prøv igjen.';

  @override
  String get notice_permissionDenied_title => 'VPN-tillatelse avslått';

  @override
  String get notice_permissionDenied_message =>
      'Start tilkoblingen på nytt og godta Android-tillatelsesforespørselen.';

  @override
  String get notice_wireguardTimeout_title => 'Serveren svarer ikke';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard-tilkoblingen tok for lang tid. Prøv igjen eller velg en annen lokasjon.';

  @override
  String get notice_tlsFailed_title => 'Sikker tilkobling avvist';

  @override
  String get notice_tlsFailed_message =>
      'Serveren godtok ikke OpenVPN-tilkoblingen. Prøv igjen. Hvis problemet fortsetter, kjør en diagnostikk.';

  @override
  String get notice_tunRejected_title => 'Android avviste VPN-grensesnittet';

  @override
  String get notice_tunRejected_message =>
      'Android avviste nettverkskonfigurasjonen som OpenVPN ba om.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN kunne ikke starte';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN-motoren klarte ikke å fullføre oppstarten. Prøv igjen. Kontakt kundestøtte hvis problemet fortsetter.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostikkode: $code';
  }

  @override
  String get notice_generic_title => 'VPN-tilkoblingen mislyktes';

  @override
  String get notice_generic_message =>
      'Det oppstod en feil. Prøv igjen senere.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konto opprettet',
      'password_reset_sent':
          'Forespørsel om tilbakestilling av passord mottatt',
      'verification_email_sent': 'Bekreftelses-e-post sendt',
      'location_migration_pending': 'Endring av lokasjon pågår',
      'vpn_sign_in_required': 'Innlogging kreves',
      'protocol_unavailable_at_location': 'Protokollen er utilgjengelig',
      'vpn_permission_denied': 'VPN-tillatelse avslått',
      'revoked_identity_device_limit': 'Grensen på 2 enheter er nådd',
      'tunnel_start_unexpected': 'VPN kunne ikke starte',
      'flutter_disconnect_timeout': 'Frakoblingen er ikke bekreftet',
      'flutter_disconnect_unexpected': 'Kunne ikke koble fra',
      'device_revoked': 'Enhet fjernet',
      'revoke_unexpected': 'Kunne ikke fjerne enheten',
      'identity_renewal_unexpected': 'Kunne ikke fornye identiteten',
      'openvpn_renewal_unexpected': 'Kunne ikke fornye OpenVPN',
      'location_migration_blocked': 'Endring av lokasjon blokkert',
      'location_migration_slow': 'Endringen av lokasjon pågår fortsatt',
      'location_migration_conflict': 'Endringen av lokasjon må oppdateres',
      'location_migration_verification_failed':
          'Endringen av lokasjon er ikke bekreftet',
      'location_migration_device_changed':
          'Enheten ble endret under endringen av lokasjon',
      'tunnel_stop_failed': 'Endring av lokasjon utilgjengelig',
      'other': 'Operasjonen mislyktes',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Kontoen ble opprettet, men bekreftelses-e-posten kunne ikke sendes. Bruk Send på nytt i appen.',
      'password_reset_sent':
          'Forespørselen din er mottatt. Hvis en konto samsvarer med denne adressen, kan du motta en e-post. Sjekk også søppelpostmappen.',
      'verification_email_sent': 'En ny bekreftelses-e-post er nettopp sendt.',
      'location_migration_pending':
          'Flyttingen til $target klargjøres fortsatt. Du kan fortsette den uten å opprette enheten på nytt.',
      'vpn_sign_in_required': 'Logg inn på kontoen din før du starter VPN.',
      'protocol_unavailable_at_location':
          'Den valgte protokollen tilbys ikke på denne lokasjonen. Oppdater lokasjonene eller velg en annen protokoll.',
      'vpn_permission_denied':
          'Android avslo VPN-tillatelsen. Start tilkoblingen på nytt og godta systemforespørselen.',
      'revoked_identity_device_limit':
          'VPN-tilgangen til denne enheten ble fjernet, og enhetsgrensen er nådd. Fjern en enhet under Konto → Administrer enhetene mine.',
      'tunnel_start_unexpected':
          'En uventet feil avbrøt forberedelsen av tunnelen. Sjekk diagnostikkoden og prøv igjen.',
      'flutter_disconnect_timeout':
          'Android bekreftet ikke i tide at VPN ble stoppet. Prøv å stoppe den igjen.',
      'flutter_disconnect_unexpected':
          'En uventet feil hindret bekreftelsen på at tunnelen ble stoppet.',
      'device_revoked':
          'VPN-tilgangen til enheten ble tilbakekalt, og de lokale hemmelighetene ble fjernet.',
      'revoke_unexpected':
          'Enheten kunne ikke fjernes. Oppdater listen og prøv igjen.',
      'identity_renewal_unexpected':
          'Den nye VPN-identiteten kunne ikke opprettes. Oppdater enhetene og prøv igjen.',
      'openvpn_renewal_unexpected':
          'OpenVPN-profilen kunne ikke fornyes. Prøv igjen eller sjekk diagnostikkoden.',
      'location_migration_blocked':
          'Serveren kan ikke fullføre denne endringen nå. Enheten og den lokale identiteten er beholdt.',
      'location_migration_slow':
          'Serveren klargjør fortsatt flyttingen til $target. Bruk Fortsett om noen øyeblikk.',
      'location_migration_conflict':
          'Enhetstilstanden ble endret på serveren. Oppdater enhetene, og fortsett deretter endringen.',
      'location_migration_verification_failed':
          'Serveren bekreftet ikke den nye lokasjonen. Den forrige lokale identiteten er beholdt.',
      'location_migration_device_changed':
          'Enheten som serveren returnerte, samsvarer ikke lenger med enheten som endres. Oppdater enhetene før du prøver igjen.',
      'tunnel_stop_failed':
          'Den forrige tunnelen må være helt stoppet før den nye tilkoblingen opprettes.',
      'other':
          'Operasjonen kunne ikke fullføres. Prøv igjen eller send diagnostikkoden til kundestøtte.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Økten er utløpt',
      'invalid_credentials': 'Innlogging mislyktes',
      'email_verification_required': 'E-postbekreftelse kreves',
      'verification_email_cooldown': 'E-post allerede sendt',
      'rate_limited': 'For mange forsøk',
      'invalid_registration': 'Informasjonen må korrigeres',
      'email_exists': 'Kontoen finnes allerede',
      'invalid_profile': 'Ugyldig profil',
      'invalid_device': 'Ugyldig enhet',
      'invalid_location': 'Lokasjonen er utilgjengelig',
      'device_limit': 'Enhetsgrensen er nådd',
      'device_exists': 'VPN-identiteten er allerede i bruk',
      'device_identity_revoked': 'VPN-identiteten må fornyes',
      'device_location_locked': 'Endringen av lokasjon må oppdateres',
      'location_migration_pending': 'Endring av lokasjon pågår',
      'location_migration_blocked': 'Endring av lokasjon blokkert',
      'target_ca_mismatch': 'OpenVPN-serveren er ikke kompatibel',
      'location_migration_conflict': 'Endringen av lokasjon må oppdateres',
      'server_full': 'Serveren er full',
      'capacity_unavailable': 'Lokasjonen er midlertidig utilgjengelig',
      'target_unavailable': 'Serveren er midlertidig utilgjengelig',
      'not_found': 'Fant ikke elementet',
      'invalid_openvpn_csr': 'Ugyldig OpenVPN-identitet',
      'openvpn_profile_exists': 'OpenVPN-profilen finnes allerede',
      'openvpn_profile_revoked': 'OpenVPN-profil tilbakekalt',
      'openvpn_operation_pending': 'OpenVPN-operasjon pågår',
      'openvpn_operation_terminal': 'OpenVPN-operasjonen ble avbrutt',
      'openvpn_address_unavailable': 'OpenVPN-adressen er utilgjengelig',
      'openvpn_profile_conflict': 'OpenVPN-konflikt',
      'openvpn_signer_unavailable': 'OpenVPN er utilgjengelig',
      'email_delivery_unavailable': 'E-post er utilgjengelig',
      'invalid_token': 'Ugyldig lenke',
      'network_unavailable': 'Internett-tilkobling utilgjengelig',
      'invalid_json': 'Ugyldig forespørsel',
      'invalid_api_response': 'Ugyldig serversvar',
      'ipv6_unavailable': 'IPv6 er utilgjengelig',
      'invalid_ip_families': 'Nettverkskonfigurasjonen ble avvist',
      'other': 'Tjenesten er utilgjengelig',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Økten din er utløpt. Logg inn på nytt.',
      'invalid_credentials': 'E-postadressen eller passordet er feil.',
      'email_verification_required':
          'Bekreft e-postadressen din før du legger til en VPN-enhet.',
      'invalid_registration':
          'Kontroller den etterspurte informasjonen og samtykkene.',
      'email_exists': 'En konto bruker allerede denne e-postadressen.',
      'invalid_profile': 'Kontroller profilinformasjonen din.',
      'invalid_device':
          'Navnet på denne enheten eller den lokale identiteten er ugyldig.',
      'invalid_location': 'Oppdater lokasjonslisten og prøv igjen.',
      'device_limit': 'Fjern en eksisterende enhet før du legger til en ny.',
      'device_exists':
          'Denne VPN-identiteten er allerede knyttet til en annen konto.',
      'device_identity_revoked':
          'Denne identiteten ble fjernet. En ny lokal identitet må opprettes.',
      'device_location_locked':
          'Lokasjonen til denne enheten ble nettopp endret. Appen fortsetter endringen som pågår.',
      'location_migration_pending': 'En endring av lokasjon pågår allerede.',
      'location_migration_blocked':
          'Endringen av lokasjon krever inngrep på serversiden. Prøv igjen senere eller kontakt kundestøtte.',
      'target_ca_mismatch':
          'Denne serveren er ennå ikke kompatibel med den nåværende OpenVPN-profilen.',
      'location_migration_conflict':
          'Oppdater enhetene, og prøv deretter endringen av lokasjon på nytt.',
      'server_full':
          'Denne lokasjonen har nådd tilkoblingsgrensen. Velg en annen lokasjon eller prøv igjen senere.',
      'capacity_unavailable':
          'Vi kan ikke bekrefte om denne lokasjonen er tilgjengelig akkurat nå. Velg en annen lokasjon eller prøv igjen senere.',
      'target_unavailable': 'Denne serveren er midlertidig utilgjengelig.',
      'not_found':
          'Dette elementet er ikke lenger tilgjengelig på kontoen din.',
      'invalid_openvpn_csr': 'Opprett en ny OpenVPN-identitet og prøv igjen.',
      'openvpn_profile_exists':
          'Det finnes allerede en OpenVPN-profil for denne enheten.',
      'openvpn_profile_revoked': 'Forny OpenVPN-profilen for å fortsette.',
      'openvpn_operation_pending':
          'Endringen er fortsatt på vei ut. Prøv igjen senere.',
      'openvpn_operation_terminal':
          'Opprett en ny OpenVPN-identitet og prøv igjen.',
      'openvpn_address_unavailable':
          'Ingen OpenVPN-adresse er tilgjengelig for øyeblikket.',
      'openvpn_profile_conflict':
          'Profilen ble endret. Oppdater enhetene og prøv igjen.',
      'openvpn_signer_unavailable':
          'OpenVPN-tjenesten er midlertidig utilgjengelig.',
      'email_delivery_unavailable':
          'E-posten kunne ikke sendes. Prøv igjen senere.',
      'invalid_token': 'Denne lenken er ugyldig eller utløpt. Be om en ny.',
      'network_unavailable': 'Kontroller internettforbindelsen og prøv igjen.',
      'invalid_json': 'Kontroller den angitte informasjonen og prøv igjen.',
      'invalid_api_response':
          'Serveren returnerte et uventet svar. Prøv igjen senere.',
      'ipv6_unavailable':
          'Serveren kan ikke aktivere IPv6 akkurat nå. Prøv igjen senere.',
      'invalid_ip_families':
          'Tunnelkonfigurasjonen er ufullstendig eller samsvarer ikke med de autoriserte adressene. Prøv igjen fra appen.',
      'other': 'Det oppstod en serverfeil. Prøv igjen senere.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Prøv igjen om noen øyeblikk.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Prøv igjen om $seconds sekunder.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Fortsettelse av system-VPN utilgjengelig',
      'system_vpn_resume_corrupt': 'Ugyldig fortsettelse av system-VPN',
      'system_vpn_resume_session_invalid':
          'Ugyldig økt for fortsettelse av VPN',
      'system_vpn_resume_identity_changed': 'VPN-identiteten ble endret',
      'system_vpn_resume_identity_invalid':
          'Ugyldig VPN-identitet for fortsettelse',
      'system_vpn_resume_storage_failed':
          'Lagring for fortsettelse av VPN utilgjengelig',
      'system_vpn_resume_network_timeout':
          'Fortsettelse av VPN har ikke nettverk',
      'system_vpn_resume_blocked': 'Fortsettelse av VPN blokkert',
      'system_vpn_resume_failed': 'Fortsettelse av VPN mislyktes',
      'system_vpn_resume_error_invalid': 'Ugyldig feil ved fortsettelse av VPN',
      'wireguard_identity_store_failed':
          'WireGuard-identiteten ble ikke lagret',
      'wireguard_identity_unavailable': 'WireGuard-identitet utilgjengelig',
      'vpn_host_destroyed': 'Android-verten for VPN ble stoppet',
      'vpn_host_unavailable': 'Android-verten for VPN utilgjengelig',
      'vpn_permission_required': 'VPN-tillatelse kreves',
      'vpn_permission_denied': 'VPN-tillatelse avslått',
      'vpn_permission_request_failed': 'Kunne ikke be om tillatelse',
      'wireguard_foreground_service_unavailable':
          'WireGuard-tjenesten utilgjengelig',
      'wireguard_identity_invalid': 'Ugyldig lokal WireGuard-nøkkel',
      'wireguard_identity_in_use': 'WireGuard-identiteten er allerede i bruk',
      'wireguard_configuration_invalid': 'Ugyldig WireGuard-konfigurasjon',
      'wireguard_operation_pending': 'WireGuard-operasjonen er fortsatt aktiv',
      'wireguard_start_failed': 'WireGuard-start ble avvist',
      'wireguard_stop_timeout': 'WireGuard-stoppet er ikke bekreftet',
      'wireguard_handshake_timeout': 'WireGuard svarte ikke',
      'openvpn_connection_timeout': 'OpenVPN svarte ikke',
      'openvpn_core_unavailable': 'OpenVPN-motoren er utilgjengelig',
      'openvpn_operation_pending': 'OpenVPN-økten er fortsatt aktiv',
      'openvpn_stop_timeout': 'OpenVPN-stoppet er ikke bekreftet',
      'openvpn_profile_unavailable': 'Lokal OpenVPN-profil mangler',
      'openvpn_native_failed': 'Det opprinnelige OpenVPN-kallet ble avbrutt',
      'openvpn_key_generation_failed':
          'Kunne ikke opprette OpenVPN P-256-nøkkel',
      'openvpn_csr_generation_failed': 'Kunne ikke opprette OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN-identiteten ble ikke lagret',
      'openvpn_identity_clear_failed': 'OpenVPN-fjerningen er ufullstendig',
      'openvpn_identity_in_use': 'OpenVPN-identiteten er fortsatt i bruk',
      'openvpn_tls_verification_required': 'OpenVPN TLS-bekreftelse mangler',
      'openvpn_cipher_invalid': 'Ugyldig OpenVPN-krypteringsalgoritme',
      'openvpn_profile_rejected': 'OpenVPN-profilen ble avvist',
      'openvpn_identity_inconsistent': 'OpenVPN-identiteten er inkonsekvent',
      'tls_handshake_failed': 'OpenVPN-forhandlingen ble avvist',
      'tls_alert_unknown_ca': 'OpenVPN-klientsertifikatet er ikke gjenkjent',
      'tls_alert_bad_certificate': 'OpenVPN-klientsertifikatet ble avvist',
      'tls_alert_unsupported_certificate': 'OpenVPN-sertifikatet støttes ikke',
      'tls_client_certificate_required': 'OpenVPN-klientsertifikat kreves',
      'tls_alert_misc': 'OpenVPN TLS-varsel',
      'tls_signature_algorithm_rejected': 'OpenVPN-signaturen støttes ikke',
      'tls_handshake_rejected': 'OpenVPN TLS-forhandlingen ble avvist',
      'tls_version_rejected': 'OpenVPN TLS-versjonen er inkompatibel',
      'tls_certificate_expired': 'TLS-sertifikatet er utløpt',
      'tls_certificate_revoked': 'TLS-sertifikatet er tilbakekalt',
      'transport_failed': 'OpenVPN-serveren kan ikke nås',
      'tun_configuration_rejected': 'Kunne ikke opprette OpenVPN-grensesnitt',
      'tun_setup_failed': 'Oppsett av OpenVPN TUN mislyktes',
      'tun_interface_create_failed':
          'Oppretting av OpenVPN-grensesnitt mislyktes',
      'tun_interface_disabled': 'OpenVPN-grensesnitt deaktivert',
      'tun_halted': 'OpenVPN-grensesnitt avbrutt',
      'tun_already_established': 'OpenVPN-grensesnittet er allerede åpent',
      'tun_addresses_missing': 'OpenVPN-adresse mangler',
      'tun_routes_missing': 'OpenVPN-ruter mangler',
      'tun_dns_missing': 'OpenVPN-DNS mangler',
      'tun_permission_revoked': 'VPN-tillatelsen ble tilbakekalt',
      'tun_establish_returned_null': 'Android avviste VPN-grensesnittet',
      'openvpn_service_start_failed': 'OpenVPN-tjenesten er utilgjengelig',
      'openvpn_operation_timeout': 'OpenVPN-kallet fikk tidsavbrudd',
      'openvpn_start_failed': 'OpenVPN-start ble avvist',
      'openvpn_connection_failed': 'OpenVPN-tilkoblingen ble avbrutt',
      'openvpn_core_status_error': 'OpenVPN Core avsluttet med en feil',
      'openvpn_stopped_before_connected': 'OpenVPN ble stoppet før tilkobling',
      'openvpn_auth_failed': 'OpenVPN-godkjenning avvist',
      'openvpn_client_setup_failed': 'Oppsett av OpenVPN-klient mislyktes',
      'openvpn_client_halted': 'OpenVPN-klienten ble avbrutt',
      'openvpn_client_restart': 'OpenVPN-omstart forespurt',
      'openvpn_inactive_timeout': 'OpenVPN var inaktiv for lenge',
      'openvpn_session_expired': 'OpenVPN-økten er utløpt',
      'openvpn_credentials_required': 'OpenVPN-godkjenning støttes ikke',
      'openvpn_proxy_failed': 'OpenVPN-mellomtransport mislyktes',
      'openvpn_compression_failed': 'OpenVPN-komprimering avvist',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM-kryptering utilgjengelig',
      'openvpn_feature_unsupported': 'OpenVPN-funksjonen støttes ikke',
      'network_unavailable': 'Internett-tilkobling utilgjengelig',
      'network_lost': 'Nettverk utilgjengelig',
      'certificate_validation_failed': 'Serversertifikatet ble avvist',
      'openvpn_certificate_expired': 'OpenVPN-sertifikatet er utløpt',
      'tunnel_active_for_another_account':
          'En annen kontos tunnel er fortsatt aktiv',
      'tunnel_already_active': 'Opprinnelig tunnel er allerede aktiv',
      'tunnel_stop_timeout': 'Stopp av $protocol er ikke bekreftet',
      'tunnel_disconnected': '$protocol ble avbrutt',
      'native_bridge_unavailable': 'Android-broen er utilgjengelig',
      'native_operation_failed': 'Android-operasjonen ble avbrutt',
      'invalid_arguments': 'Ufullstendige VPN-parametere',
      'invalid_account_id': 'Ugyldig VPN-konto',
      'invalid_device_id': 'Ugyldig enhetsidentifikator',
      'storage_key_not_allowed': 'Lagringsnøkkel avvist',
      'secure_storage_read_failed': 'Sikker lesing mislyktes',
      'secure_storage_write_failed': 'Sikker skriving mislyktes',
      'key_generation_failed': 'Kunne ikke generere WireGuard-nøkkel',
      'csr_generation_failed': 'Kunne ikke generere OpenVPN CSR',
      'other': 'Uklassifisert opprinnelig VPN-feil',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android finner ingen VPN-økt som kan fortsettes. Start en ny tilkobling i appen.',
      'system_vpn_resume_corrupt':
          'De lagrede dataene for fortsettelse av VPN er ugyldige og vil ikke brukes. Start en ny tilkobling.',
      'system_vpn_resume_session_invalid':
          'Den lagrede økten kan ikke lenger fortsette VPN. Logg inn på nytt i appen.',
      'system_vpn_resume_identity_changed':
          'Den lokale VPN-identiteten ble endret. Fortsettelsen ble stoppet; start en ny tilkobling.',
      'system_vpn_resume_identity_invalid':
          'Identiteten for fortsettelse er ugyldig. Start en ny tilkobling.',
      'system_vpn_resume_storage_failed':
          'Android kunne ikke lese eller oppdatere krypterte data for fortsettelse. Start en ny tilkobling.',
      'system_vpn_resume_network_timeout':
          'Android fant ikke et nettverk i tide til å fortsette VPN. Prøv igjen når et nettverk er tilgjengelig.',
      'system_vpn_resume_blocked':
          'Fortsettelse av VPN er blokkert. Kontroller Android-innstillingene, og start deretter en ny tilkobling.',
      'system_vpn_resume_failed':
          'Fortsettelse av Android-VPN mislyktes. Start en ny tilkobling i appen.',
      'system_vpn_resume_error_invalid':
          'Android returnerte en ubrukelig feil ved fortsettelse. Start en ny tilkobling.',
      'wireguard_identity_store_failed':
          'Android kunne ikke lagre denne kontoens krypterte WireGuard-identitet.',
      'wireguard_identity_unavailable':
          'Ingen brukbar WireGuard-identitet er tilgjengelig for denne tilkoblingen.',
      'vpn_host_destroyed':
          'Android-komponenten som er vert for VPN, ble stoppet. Start en ny tilkobling.',
      'vpn_host_unavailable':
          'Android kan ikke opprette komponenten som er vert for VPN. Prøv igjen etter å ha kontrollert VPN-innstillingene.',
      'openvpn_renewal_required':
          'Sertifikatet krever en handling i appen før tilkobling.',
      'openvpn_recovery_failed':
          'Automatisk gjenoppretting mislyktes. Start en ny tilkobling i appen.',
      'openvpn_recovery_exhausted':
          'Automatisk gjenoppretting er allerede brukt. Start en ny tilkobling i appen.',
      'vpn_permission_required':
          'Android krever en ny VPN-godkjenning før tunnelen startes.',
      'vpn_permission_denied':
          'Tillat FuzeVPN i Android-forespørselen for å fortsette.',
      'vpn_permission_request_failed':
          'Android kunne ikke åpne VPN-tillatelsessiden.',
      'wireguard_foreground_service_unavailable':
          'Android kunne ikke holde WireGuard-tjenesten i forgrunnen.',
      'wireguard_identity_invalid':
          'Denne kontoens krypterte WireGuard-nøkkel kan ikke leses eller er ugyldig.',
      'wireguard_identity_in_use':
          'En annen operasjon bruker fortsatt denne kontoens WireGuard-nøkkel.',
      'wireguard_configuration_invalid':
          'Den mottatte WireGuard-adressen, DNS-en, servernøkkelen eller rutene er ugyldige.',
      'wireguard_operation_pending':
          'Den forrige WireGuard-operasjonen har ennå ikke frigitt den opprinnelige tjenesten.',
      'wireguard_start_failed':
          'WireGuard-motoren avviste aktiveringen av konfigurasjonen.',
      'wireguard_stop_timeout':
          'WireGuard-tjenesten bekreftet ikke frigjøringen av VPN-grensesnittet innen tidsfristen.',
      'wireguard_handshake_timeout':
          'Tunnelen bekreftet ikke et håndtrykk med serveren i tide.',
      'openvpn_connection_timeout':
          'OpenVPN bekreftet ikke tilkoblingen til serveren i tide.',
      'openvpn_core_unavailable':
          'Denne appversjonen inneholder ingen brukbar OpenVPN-motor.',
      'openvpn_operation_pending':
          'Den opprinnelige motoren holder fortsatt den forrige OpenVPN-økten og nekter å opprette en ny.',
      'openvpn_stop_timeout':
          'OpenVPN Core bekreftet ikke at den opprinnelige økten ble stoppet og ødelagt innen tidsfristen.',
      'openvpn_profile_unavailable':
          'Ingen godkjent OpenVPN-profil kan leses for denne tilkoblingen.',
      'openvpn_native_failed':
          'En appfeil avbrøt OpenVPN. Prøv å koble til på nytt. Kjør diagnostikk hvis problemet fortsetter.',
      'openvpn_key_generation_failed':
          'Android Keystore kunne ikke opprette eller lese den ikke-eksporterbare private P-256-nøkkelen.',
      'openvpn_csr_generation_failed':
          'Android Keystore-nøkkelen kunne ikke signere OpenVPN-sertifikatforespørselen.',
      'openvpn_identity_store_failed':
          'OpenVPN-sertifikatet eller profilen kunne ikke lagres i kryptert lagring.',
      'openvpn_identity_clear_failed':
          'Android kunne ikke fjerne hele den lokale OpenVPN-identiteten for denne kontoen.',
      'openvpn_identity_in_use':
          'En opprinnelig OpenVPN-økt bruker fortsatt enhetens nøkkel eller sertifikat.',
      'openvpn_tls_verification_required':
          'Profilen krever ikke uttrykkelig bekreftelse av serversertifikatet.',
      'openvpn_cipher_invalid':
          'Serveren oppga en krypteringsalgoritme som ikke finnes i listen over tillatte algoritmer.',
      'openvpn_profile_rejected':
          'Profilen som ble mottatt fra serveren, er inkompatibel. Opprett denne enheten på nytt og prøv igjen.',
      'openvpn_identity_inconsistent':
          'Sertifikatet samsvarer ikke med telefonens sikre identitet. Ingen lokal profil ble erstattet.',
      'tls_handshake_failed':
          'Serveren avviste TLS-forhandlingen. Opprett profilen på nytt hvis problemet fortsetter.',
      'tls_alert_unknown_ca':
          'Serveren kjenner ikke igjen sertifikatmyndigheten til denne enheten. OpenVPN-serveren må kontrolleres.',
      'tls_alert_bad_certificate':
          'Serveren avviste dette enhetssertifikatet. Opprett enheten på nytt før du prøver igjen.',
      'tls_alert_unsupported_certificate':
          'Serveren støtter ikke den sikre sertifikattypen som Android bruker.',
      'tls_client_certificate_required':
          'Serveren krever et klientsertifikat, men OpenVPN Core kunne ikke legge frem et.',
      'tls_alert_misc':
          'Serveren returnerte et TLS-varsel utenfor sertifikat- og versjonskategoriene.',
      'tls_signature_algorithm_rejected':
          'Serveren avviste ECDSA P-256-algoritmen til Android Keystore-nøkkelen.',
      'tls_handshake_rejected':
          'Serveren avbrøt TLS-forhandlingen før tilkobling.',
      'tls_version_rejected':
          'Klienten og serveren fant ingen felles TLS-versjon.',
      'tls_certificate_expired':
          'Sertifikatet som ble lagt frem under tilkoblingen, er utløpt.',
      'tls_certificate_revoked':
          'Sertifikatet som ble lagt frem under tilkoblingen, er tilbakekalt.',
      'transport_failed':
          'OpenVPN-serveren svarer ikke på det nåværende nettverket. Prøv igjen om litt.',
      'tun_configuration_rejected':
          'Android avviste nettverkskonfigurasjonen som OpenVPN ba om.',
      'tun_setup_failed':
          'OpenVPN Core avviste nettverksplanen før Android-grensesnittet ble opprettet.',
      'tun_interface_create_failed':
          'OpenVPN Core kunne ikke hente TUN-grensesnittet fra Android VpnService.',
      'tun_interface_disabled':
          'Android eller OpenVPN Core deaktiverte TUN-grensesnittet under tilkoblingen.',
      'tun_halted':
          'OpenVPN Core mottok en forespørsel om å stoppe TUN-grensesnittet.',
      'tun_already_established':
          'OpenVPN ba om et ekstra grensesnitt i samme tilkobling. Tunnelen ble stoppet av sikkerhetshensyn.',
      'tun_addresses_missing': 'Serveren oppga ingen brukbar tunneladresse.',
      'tun_routes_missing': 'Serveren oppga ingen brukbare tunnelruter.',
      'tun_dns_missing': 'Serveren oppga ingen brukbar DNS-server.',
      'tun_permission_revoked':
          'Android tilbakekalte VPN-tillatelsen under tilkoblingen.',
      'tun_establish_returned_null':
          'Android opprettet ikke grensesnittet, vanligvis fordi en annen VPN fortsatt er aktiv.',
      'openvpn_service_start_failed':
          'Android kunne ikke starte OpenVPN-forgrunnstjenesten.',
      'openvpn_operation_timeout':
          'Et JNI-kall til OpenVPN Core overskred maksimal varighet.',
      'openvpn_start_failed':
          'Android-tjenesten er klar, men OpenVPN Core godtok ikke å starte profilen.',
      'openvpn_connection_failed':
          'OpenVPN Core stoppet før CONNECTED-hendelsen ble sendt.',
      'openvpn_core_status_error':
          'Den opprinnelige OpenVPN-løkken avsluttet med en feil uten en mer spesifikk slutthendelse.',
      'openvpn_stopped_before_connected':
          'Den opprinnelige OpenVPN-løkken stoppet før CONNECTED, uten en uttrykkelig Core-feil.',
      'openvpn_auth_failed': 'OpenVPN-serveren avviste profilgodkjenningen.',
      'openvpn_client_setup_failed':
          'OpenVPN Core kunne ikke klargjøre klienten før nettverkstilkoblingen.',
      'openvpn_client_halted':
          'OpenVPN Core mottok en avsluttende stoppkommando for klienten.',
      'openvpn_client_restart': 'OpenVPN Core ba om omstart av transportøkten.',
      'openvpn_inactive_timeout':
          'OpenVPN Core lukket økten etter tidsavbrudd på grunn av inaktivitet.',
      'openvpn_session_expired':
          'Serveren rapporterte at OpenVPN-økten er utløpt.',
      'openvpn_credentials_required':
          'Serveren eller en proxy ber om interaktive innloggingsopplysninger som ikke inngår i denne sertifikatprofilen.',
      'openvpn_proxy_failed':
          'OpenVPN Core rapporterte en feil i den konfigurerte proxyen eller reléet.',
      'openvpn_compression_failed':
          'OpenVPN Core avviste komprimeringsmodusen som profilen eller serveren oppga.',
      'openvpn_ntlm_crypto_unavailable':
          'Profilen ber om NTLM-kryptering som ikke er tilgjengelig i denne versjonen.',
      'openvpn_feature_unsupported':
          'Profilen eller serveren krever en funksjon som mangler i denne Android-klienten.',
      'network_unavailable':
          'Ingen brukbar fysisk nettverkstilkobling er tilgjengelig.',
      'network_lost': 'Tunnelen ble stoppet etter at nettverket gikk tapt.',
      'certificate_validation_failed':
          'OpenVPN-serverens identitet kunne ikke bekreftes.',
      'openvpn_certificate_expired':
          'Forny OpenVPN-profilen før du kobler til på nytt.',
      'tunnel_active_for_another_account':
          'En tunnel som tilhører en annen konto, må stoppes før denne tilkoblingen.',
      'tunnel_already_active':
          'Android rapporterer at en tidligere VPN-økt fortsatt bruker grensesnittet.',
      'tunnel_stop_timeout':
          '$protocol-motoren bekreftet ikke frigjøringen av VPN-grensesnittet innen tidsfristen.',
      'tunnel_disconnected':
          'Den opprinnelige motoren rapporterte at tunnelen ble avsluttet uventet etter oppstart.',
      'native_bridge_unavailable':
          'Appen får ikke tilgang til Androids VPN-tjeneste. Lukk og åpne appen på nytt, og prøv igjen.',
      'native_operation_failed':
          'En appfeil avbrøt VPN-operasjonen. Prøv igjen. Kjør diagnostikk hvis problemet fortsetter.',
      'invalid_arguments':
          'Informasjonen som trengs for denne VPN-operasjonen, er ufullstendig. Prøv igjen. Kjør diagnostikk hvis problemet fortsetter.',
      'invalid_account_id':
          'Den opprinnelige operasjonen er ikke knyttet til en gyldig kontoidentifikator.',
      'invalid_device_id':
          'Enhetsidentifikatoren som ble sendt til den opprinnelige motoren, mangler eller er ugyldig.',
      'storage_key_not_allowed':
          'Android-broen blokkerte en nøkkel utenfor listen over tillatt lagring.',
      'secure_storage_read_failed':
          'Android Keystore kunne ikke dekryptere de lokale dataene til denne kontoen.',
      'secure_storage_write_failed':
          'Android Keystore kunne ikke kryptere eller lagre de lokale dataene.',
      'key_generation_failed':
          'Android kunne ikke opprette eller lese WireGuard-nøkkelen i sikker lagring.',
      'csr_generation_failed':
          'Android Keystore kunne ikke opprette eller signere OpenVPN P-256-CSR-en.',
      'other':
          'En udokumentert opprinnelig gren mislyktes. Send diagnostikkoden som vises nedenfor, til kundestøtte.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Tillatelsesforespørselen er allerede åpen';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Androids VPN-tillatelsesforespørsel vises allerede. Fullfør den før du prøver igjen.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-tillatelsesforespørselen ble avbrutt';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN-tillatelsessiden ble lukket før appen mottok et svar.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-tilkoblingen er ikke bekreftet';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN-tilkoblingen kunne ikke bekreftes. Den ble stoppet av sikkerhetshensyn. Prøv igjen.';

  @override
  String get openvpnCleanup_title => 'OpenVPN-profil tilbakekalt';

  @override
  String get openvpnCleanup_working =>
      'Stopper og fjerner den tilbakekalte OpenVPN-profilen…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-avslutningen er ikke bekreftet. Prøv igjen før du oppretter en ny profil.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Den tilbakekalte OpenVPN-profilen kunne ikke fjernes helt. Prøv å rydde opp på nytt.';

  @override
  String get openvpnCleanup_complete =>
      'Den tilbakekalte OpenVPN-profilen er fjernet. Trykk på Koble til for å opprette en ny.';

  @override
  String get network_title => 'Nettverkskonfigurasjon';

  @override
  String get network_ipv4Fallback =>
      'IPv6 er midlertidig utilgjengelig. Forberedelsen fortsetter med IPv4.';

  @override
  String get network_rejectedTitle => 'Nettverkskonfigurasjonen ble avvist';

  @override
  String get network_rejectedMessage =>
      'Tunnelkonfigurasjonen er ufullstendig eller samsvarer ikke med de autoriserte adressene. Prøv igjen fra appen.';

  @override
  String get network_unreadableTitle => 'Lokal konfigurasjon kan ikke leses';

  @override
  String get network_unreadableMessage =>
      'Den lagrede OpenVPN-nettverkskonfigurasjonen kan ikke brukes. Koble til på nytt fra appen for å oppdatere den.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Nettverksbeskyttelse';

  @override
  String get protection_subtitle =>
      'Blokker direkte internettilgang hvis VPN kobles fra.';

  @override
  String get protection_active => 'Systembeskyttelse aktiv';

  @override
  String get protection_alwaysOnOnly =>
      'Alltid på-VPN er aktivert; slå på blokkering utenfor VPN';

  @override
  String get protection_inactive => 'Systembeskyttelse inaktiv';

  @override
  String get protection_unknown => 'Kontroller systembeskyttelsen';

  @override
  String get protection_openSettings => 'Åpne Android-innstillinger';

  @override
  String get protection_dialogTitle => 'Konfigurer nettverksbeskyttelse';

  @override
  String get protection_dialogMessage =>
      'Android styrer alltid på-VPN og blokkering av tilkoblinger utenfor VPN. Kontroller at FuzeVPN er valgt, og aktiver blokkering i systeminnstillingene.';

  @override
  String get protection_dialogOpen => 'Åpne innstillinger';

  @override
  String get session_systemProtectionNote =>
      'Hvis Android fortsatt blokkerer trafikk utenfor VPN, åpner du systeminnstillingene for å kontrollere eller endre denne beskyttelsen.';

  @override
  String get diagnostics_title => 'Diagnostikk';

  @override
  String get diagnostics_settingsTitle => 'Appdiagnostikk';

  @override
  String get diagnostics_automaticTitle => 'Send viktige feil';

  @override
  String get diagnostics_automaticDescription =>
      'Del en kort teknisk rapport når det oppstår en viktig feil.';

  @override
  String get diagnostics_privacy =>
      'Sendte rapporter er knyttet til den innloggede kontoen og oppbevares i 30 dager. De inneholder ingen nettleserhistorikk, passord eller VPN-nøkler.';

  @override
  String get diagnostics_manualOpen => 'Kjør diagnostikk';

  @override
  String get diagnostics_localDescription =>
      'Opprett en rapport om appen og VPN-statusen. Tilkoblingen din forblir uendret.';

  @override
  String get diagnostics_sendReport => 'Send rapporten';

  @override
  String get diagnostics_sendHint =>
      'La denne boksen være umerket for å beholde rapporten på denne enheten.';

  @override
  String get diagnostics_signedOut =>
      'Logg inn på kontoen din for å sende en rapport.';

  @override
  String get diagnostics_localLifetime =>
      'Lagre denne rapporten på telefonen for å beholde den etter at appen lukkes.';

  @override
  String get diagnostics_run => 'Kjør diagnostikk';

  @override
  String get diagnostics_rerun => 'Kjør diagnostikk på nytt';

  @override
  String get diagnostics_running => 'Kontrollerer…';

  @override
  String get diagnostics_sending => 'Sender rapport…';

  @override
  String get diagnostics_prepared => 'Rapporten er klar på denne enheten';

  @override
  String get diagnostics_queued => 'Rapporten venter på å bli sendt';

  @override
  String get diagnostics_sent => 'Rapporten er mottatt';

  @override
  String get diagnostics_failed =>
      'Sendingen mislyktes. Den lokale rapporten er fortsatt tilgjengelig.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostikkrapporten kunne ikke klargjøres. Prøv igjen.';

  @override
  String get diagnostics_authenticationRequired =>
      'Logg inn på nytt for å sende rapporten.';

  @override
  String get diagnostics_retry => 'Prøv å sende på nytt';

  @override
  String get diagnostics_export => 'Lagre rapport';

  @override
  String get diagnostics_exportFailed =>
      'Eksporten mislyktes. Prøv igjen fra den lokale rapporten.';

  @override
  String get diagnostics_preferenceFailed =>
      'Denne innstillingen kunne ikke lagres. Prøv igjen.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referanse: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Mottatt $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Oppbevares til $date';
  }

  @override
  String get diagnostics_duplicate => 'Denne rapporten var allerede mottatt.';

  @override
  String get diagnostics_preview => 'Forhåndsvisning av rapport';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tekniske hendelser er vedlagt',
      one: 'Én teknisk hendelse er vedlagt',
      zero: 'Ingen tekniske hendelser er vedlagt',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tekniske detaljer';

  @override
  String get diagnostics_empty => 'Ingen diagnostikkrapport er klargjort ennå.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunneltilstand',
      'handshake': 'Tilkoblingsbekreftelse',
      'certificate': 'VPN-sertifikat',
      'kill_switch': 'Android-beskyttelse',
      'connectivity': 'Tilgjengelig nettverk',
      'api_reachability': 'Tjenestetilgang',
      'secure_storage': 'Sikker lagring',
      'other': 'Lokal kontroll',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Kontrollert',
      'failed': 'Krever oppmerksomhet',
      'skipped': 'Ikke testet — ingen aktiv kontroll',
      'unknown': 'Informasjon utilgjengelig',
      'other': 'Informasjon utilgjengelig',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Velkommen til FuzeVPN';

  @override
  String get connection_changeLocation => 'Endre lokasjon';

  @override
  String get connection_details => 'Tilkoblingsdetaljer';

  @override
  String get locations_searchLabel => 'Søk etter en by eller et land';

  @override
  String get locations_clearSearch => 'Tøm søket';

  @override
  String get locations_filterAll => 'Alle';

  @override
  String get locations_filterFavorites => 'Favoritter';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokasjoner',
      one: '$count lokasjon',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Fant ingen lokasjoner';

  @override
  String get locations_noResultsHint => 'Prøv en annen by eller et annet land.';

  @override
  String get locations_noFavorites => 'Favorittene dine, lett tilgjengelige';

  @override
  String get locations_noFavoritesHint =>
      'Trykk på stjernen ved siden av en lokasjon for å lagre den her.';

  @override
  String get locations_showAll => 'Se alle lokasjoner';

  @override
  String locations_addFavorite(String name) {
    return 'Legg $name til i favorittene';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Fjern $name fra favorittene';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Favoritten kunne ikke lagres. Prøv igjen.';

  @override
  String get locations_emptyTitle => 'Ingen lokasjoner tilgjengelige';

  @override
  String get locations_emptyHint => 'Oppdater listen for å prøve igjen.';

  @override
  String get devices_manage => 'Administrer enhetene mine';

  @override
  String get settings_personalization => 'Gjør det til ditt';

  @override
  String get settings_safety => 'Beskyttelse';

  @override
  String get settings_help => 'Trenger du hjelp?';

  @override
  String get settings_about => 'Om FuzeVPN';

  @override
  String get diagnostics_heading => 'Forstå et tilkoblingsproblem';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Tilgjengelig',
      'pending': 'Forbereder',
      'revoked': 'Fjernet',
      'expired': 'Utløpt',
      'other': 'Status utilgjengelig',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preferansen ble ikke lagret';

  @override
  String get notice_preferenceSave_message =>
      'Valget ditt brukes nå, men kunne ikke lagres. Prøv igjen for å beholde det etter at appen lukkes.';

  @override
  String get connection_androidDisconnectHint =>
      'Hvis Android holder VPN aktiv, slår du av Alltid på-VPN i innstillingene som åpnes.';

  @override
  String get protection_learnMore => 'Lær mer om Android-beskyttelse';

  @override
  String get protection_guideWhy =>
      'Denne beskyttelsen hindrer apper i å bruke internett direkte hvis VPN kobles fra. Den konfigureres i Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Alltid på-VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android holder VPN-tjenesten i gang og kan starte den på nytt etter at telefonen starter på nytt.';

  @override
  String get protection_guideBlockTitle => 'Blokker tilkoblinger uten VPN';

  @override
  String get protection_guideBlock =>
      'Denne innstillingen hindrer trafikk i å omgå VPN, også mens tilkoblingen er avbrutt.';

  @override
  String get protection_guideWarning =>
      'Når denne blokkeringen er aktivert, er internettilgangen slått av til VPN er tilkoblet.';

  @override
  String get protection_guideStepsTitle => 'Slå på beskyttelse';

  @override
  String get protection_guideStep1 =>
      'Åpne Androids VPN-innstillinger med knappen nedenfor.';

  @override
  String get protection_guideStep2 =>
      'Åpne alternativene med tannhjulikonet ved siden av FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Aktiver Alltid på-VPN og deretter Blokker tilkoblinger uten VPN, hvis disse alternativene er tilgjengelige.';

  @override
  String get protection_guideManufacturers =>
      'Navnene varierer mellom telefoner. Søk etter VPN i Innstillinger ved behov, ofte under Nettverk og internett.';

  @override
  String get protection_guideDisableTitle => 'Slå av denne beskyttelsen';

  @override
  String get protection_guideDisable =>
      'I de samme innstillingene slår du av blokkering uten VPN for å tillate internettilgang uten VPN. Slå også av Alltid på-VPN hvis du ikke lenger vil at Android skal starte den på nytt.';

  @override
  String get protection_guideManual =>
      'Du velger disse innstillingene i Android. FuzeVPN endrer dem ikke for deg.';

  @override
  String get locations_changeTitle => 'Endre lokasjon?';

  @override
  String locations_changeActive(String name) {
    return 'VPN kobles fra, og prøver deretter å koble til $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN prøver å koble til $name.';
  }

  @override
  String get locations_confirmChange => 'Endre og koble til';

  @override
  String get locations_changeBusy =>
      'En endring pågår. Vent før du velger en annen lokasjon.';

  @override
  String get locations_automaticSelection => 'Automatisk valg';

  @override
  String get locations_cities => 'Byer';

  @override
  String get locations_servers => 'Servere';

  @override
  String locations_viewCities(String name) {
    return 'Vis byer i $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Vis servere i $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count land',
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
  String get locations_allCountries => 'Alle land';

  @override
  String get locations_backToCountries => 'Tilbake til landene';

  @override
  String locations_backToCities(String name) {
    return 'Tilbake til byene i $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Velg $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Velg $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Ingen kompatibel server er tilgjengelig.';

  @override
  String get externalLink_failed =>
      'Lenken kunne ikke åpnes. Du kan kopiere den og åpne den i nettleseren.';

  @override
  String get externalLink_copy => 'Kopier lenke';

  @override
  String get externalLink_copied => 'Lenke kopiert';

  @override
  String get externalLink_copyFailed =>
      'Lenken kunne ikke kopieres. Merk adressen nedenfor.';

  @override
  String get settings_deleteAccount => 'Slett kontoen min';

  @override
  String get settings_deleteAccountDetail =>
      'Se hvordan du ber om å få slettet kontoen';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Velg VPN-abonnementet ditt.';

  @override
  String get billing_subscribe => 'Abonner';

  @override
  String get billing_choosePlan => 'Velg et abonnement for å fortsette.';

  @override
  String get billing_monthly => 'Månedlig';

  @override
  String get billing_yearly => 'Årlig';

  @override
  String get billing_continue => 'Fortsett med Google Play';

  @override
  String get billing_restore => 'Gjenopprett kjøp';

  @override
  String get billing_manage => 'Administrer abonnement';

  @override
  String get billing_deleteAccountWarning =>
      'Hvis du har et abonnement via Google Play, stopper ikke sletting av FuzeVPN-kontoen din fornyelsen. Administrer eller stopp fornyelsen separat i Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Fortsett til forespørsel om sletting av konto';

  @override
  String get billing_refresh => 'Oppdater tilgang';

  @override
  String get billing_loadingPlans => 'Laster abonnementer…';

  @override
  String get billing_unavailable =>
      'Ingen abonnementer er tilgjengelige nå. Prøv igjen senere.';

  @override
  String get billing_comingSoon => 'Abonnementer kommer snart.';

  @override
  String get billing_priceDisclosure =>
      'Pris fra Google Play. Sluttbeløp og gjeldende avgifter vises før du bekrefter.';

  @override
  String get billing_renewalMonthly =>
      'Fornyes automatisk hver måned hvis det ikke sies opp. Du kan si opp når som helst under Google Play-abonnementer.';

  @override
  String get billing_renewalYearly =>
      'Fornyes automatisk hvert år hvis det ikke sies opp. Du kan si opp når som helst under Google Play-abonnementer.';

  @override
  String get billing_active => 'Premium-tilgangen din er aktiv';

  @override
  String billing_accessUntil(String date) {
    return 'Tilgang til $date.';
  }

  @override
  String get billing_webManaged =>
      'Abonnementet ditt administreres på FuzeVPN-nettstedet.';

  @override
  String get billing_playManaged =>
      'Abonnementet ditt administreres via Google Play.';

  @override
  String get billing_inactive => 'Ingen aktive abonnementer.';

  @override
  String get billing_checkingAccess => 'Sjekker tilgangen din…';

  @override
  String get billing_restoring => 'Gjenoppretter kjøp…';

  @override
  String get billing_pending =>
      'Betalingen venter. Tilgangen din aktiveres etter bekreftelse.';

  @override
  String get billing_cancelled =>
      'Kjøpet ble avbrutt. Ingen nye abonnementer ble aktivert.';

  @override
  String get billing_verifying => 'Bekrefter kjøp…';

  @override
  String get billing_success =>
      'Abonnementet er aktivert. Premium-tilgangen din er klar.';

  @override
  String get billing_restored => 'Kjøpene dine er gjenopprettet.';

  @override
  String get billing_restoreEmpty =>
      'Ingen kjøp å gjenopprette for denne Google Play-kontoen.';

  @override
  String get billing_catalogError =>
      'Kunne ikke laste abonnementer. Prøv igjen.';

  @override
  String get billing_purchaseError => 'Kunne ikke starte kjøpet. Prøv igjen.';

  @override
  String get billing_verificationError =>
      'Bekreftelse av kjøp er midlertidig utilgjengelig. Gjenopprett kjøp for å prøve igjen.';

  @override
  String get billing_restoreError =>
      'Kunne ikke gjenopprette kjøp. Prøv igjen.';

  @override
  String get billing_managementError =>
      'Kunne ikke åpne abonnementsadministrasjonen. Prøv igjen.';

  @override
  String get billing_storeUnavailable =>
      'Google Play er utilgjengelig på denne enheten.';

  @override
  String get welcome_title => 'Din VPN, helt enkelt.';

  @override
  String get welcome_description =>
      'Beskytt tilkoblingen din. Behold kontrollen over personvernet ditt.';

  @override
  String get welcome_start => 'Kom i gang';

  @override
  String get welcome_alreadyPurchased => 'Har du allerede kjøpt?';

  @override
  String get welcome_noAccountRequired =>
      'Du trenger ikke å opprette en konto for å begynne.';

  @override
  String get guest_accountTitle => 'Kontoen er ikke tilknyttet';

  @override
  String get guest_accountDescription =>
      'Gjenopprett kjøpene dine med den samme Google Play-kontoen for å bruke abonnementet på en annen enhet.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Har du allerede et abonnement? Logg inn';

  @override
  String get guest_claimTitle => 'Ta med FuzeVPN overalt';

  @override
  String get guest_claimDescription =>
      'Opprett en konto for å bruke abonnementet på de andre enhetene dine. Dette trinnet er valgfritt.';

  @override
  String get guest_skip => 'Senere';

  @override
  String get guest_activationTitle => 'Fuze Premium er aktivt';

  @override
  String get guest_activationDescription =>
      'Abonnementet ditt er klart. Bruk VPN-en og opprett en konto når du vil.';

  @override
  String get guest_useVpn => 'Bruk min VPN';

  @override
  String get guest_loginRequired =>
      'Dette kjøpet er allerede knyttet til en FuzeVPN-konto. Logg inn på den kontoen for å bruke abonnementet ditt.';

  @override
  String get guest_signOutWarning =>
      'Du kan få tilbake abonnementet ved å gjenopprette kjøp med den samme Google Play-kontoen.';

  @override
  String get guest_profileUnavailable =>
      'Kontoen din er allerede tilknyttet. Logg inn for å se og administrere opplysningene dine.';

  @override
  String get billing_acceptance =>
      'Ved å fortsette godtar du Bruksvilkårene og Personvernerklæringen.';

  @override
  String get guest_verifyEmailReminder =>
      'Bekreft e-postadressen for å sikre kontoen din. Du kan fortsette å bruke VPN-en.';

  @override
  String get guest_serviceUnavailable =>
      'Tjenesten er midlertidig utilgjengelig. Prøv igjen om litt.';

  @override
  String get guest_restoreError =>
      'Kjøpene dine kunne ikke gjenopprettes. Prøv igjen med Google Play-kontoen du brukte til kjøpet.';

  @override
  String get guest_claimSuccess =>
      'Kontoen din er opprettet. Abonnementet og VPN-tilgangen din er beholdt.';

  @override
  String get guest_emailExists =>
      'Denne e-postadressen er allerede i bruk. Velg en annen adresse eller logg inn på den eksisterende kontoen. Kjøpet ditt er fortsatt tilgjengelig via Google Play.';

  @override
  String get guest_claimError =>
      'Kontoen din kunne ikke opprettes. Du kan fortsette å bruke VPN-en og prøve igjen senere.';

  @override
  String get guest_secureStorageError =>
      'Økten din kunne ikke lagres sikkert på denne enheten. Prøv igjen.';

  @override
  String get guest_premiumRequired =>
      'Velg et abonnement for å aktivere VPN-en.';

  @override
  String get welcome_viewPlans => 'Se abonnementer';

  @override
  String get google_continue => 'Fortsett med Google';

  @override
  String get google_or => 'eller';

  @override
  String get google_title => 'FuzeVPN-kontoen din';

  @override
  String get google_settingUp => 'Fullfør kontoen din';

  @override
  String get google_country => 'Bostedsland';

  @override
  String get google_profileDescription =>
      'Velg landet ditt og les begge dokumentene for å opprette FuzeVPN-kontoen.';

  @override
  String get google_claimDescription =>
      'Knytt gjestekontoen til Google. Abonnement og enhet forblir knyttet til denne kontoen.';

  @override
  String get google_linkTitle => 'Knytt Google til FuzeVPN';

  @override
  String get google_linkDescription =>
      'Bekreft tilgang til din eksisterende FuzeVPN-konto. Google-passordet ditt blir ikke etterspurt.';

  @override
  String get google_password => 'FuzeVPN-passord';

  @override
  String get google_linkAccount => 'Bekreft tilknytning';

  @override
  String get google_requestEmail => 'Motta en bekreftelsesmail';

  @override
  String get google_emailInstructions =>
      'Åpne e-posten fra FuzeVPN og skriv inn bekreftelseskoden.';

  @override
  String get google_emailCode => 'Bekreftelseskode fra e-post';

  @override
  String get google_confirmEmail => 'Bekreft koden';

  @override
  String get google_restart => 'Velg en annen Google-konto';

  @override
  String get google_resume => 'Kontroller dette forsøket';

  @override
  String get google_unavailable =>
      'Google-pålogging er ikke tilgjengelig. Du kan bruke e-post og passord.';

  @override
  String get google_expired =>
      'Dette forsøket er utløpt. Avbryt og start på nytt.';

  @override
  String get google_conflict =>
      'Denne Google-kontoen er allerede knyttet til en annen konto. Nåværende konto og abonnement beholdes.';

  @override
  String get google_error =>
      'Google-pålogging mislyktes. Prøv igjen; nåværende tilgang beholdes.';

  @override
  String get google_uncertain =>
      'Resultatet kunne ikke bekreftes. Kontroller forsøket eller avbryt før du starter på nytt.';

  @override
  String get google_cancelFailed =>
      'Avbruddet kunne ikke bekreftes. Prøv å avbryte igjen før du forlater skjermen.';

  @override
  String get google_cancelled => 'Google-pålogging avbrutt.';

  @override
  String get google_selecting => 'Velg Google-kontoen din…';

  @override
  String get google_verifying => 'Kontrollerer kontoen din…';

  @override
  String get google_emailUnavailable =>
      'Bekreftelsesmailen kunne ikke sendes. Prøv senere.';

  @override
  String get google_emailSent =>
      'Bekreftelsesmail sendt. Kontroller innboksen din.';

  @override
  String get google_rateLimited => 'Vent før du prøver igjen.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN-passordet er feil. Nåværende konto beholdes.';

  @override
  String get google_invalidCode => 'Bekreftelseskoden er ugyldig eller utløpt.';

  @override
  String get google_accountChanged =>
      'Økten er endret. Avbryt dette forsøket før du starter på nytt.';

  @override
  String get google_invalidResponse =>
      'Svaret kunne ikke valideres. Nåværende tilgang beholdes.';

  @override
  String get google_invalidRegistration =>
      'Kontroller landet og begge samtykkene.';

  @override
  String get google_consentRequired =>
      'Velg landet ditt og godta begge dokumentene for å fortsette.';

  @override
  String get google_challengeRequired =>
      'En ekstra sikkerhetskontroll kreves. Nåværende tilgang beholdes.';

  @override
  String get google_challengeUnavailable =>
      'Sikkerhetskontrollen er ikke tilgjengelig. Prøv senere.';

  @override
  String get billing_trialTitle => 'Prøv Fuze Premium gratis';

  @override
  String get billing_trialSubtitle => 'Beskytt tilkoblingen din fra i dag.';

  @override
  String get billing_trialWeeks => '2 ukers gratis prøveperiode';

  @override
  String billing_trialDays(String days) {
    return '$days dagers gratis prøveperiode';
  }

  @override
  String get billing_trialStart => 'Start min gratis prøveperiode';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Hvis du starter i dag, forventes første belastning den $date.';
  }

  @override
  String get billing_trialTerms =>
      'Fornyes automatisk til oppgitt pris. Avslutt i Google Play før prøveperioden utløper for å unngå en belastning.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Deretter $price per måned';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Deretter $price per år';
  }

  @override
  String get billing_choosePeriod => 'Velg abonnement';

  @override
  String get billing_selectionHint => 'Velg et abonnement for å fortsette.';

  @override
  String get billing_benefitConnection => 'Kryptert tilkobling';

  @override
  String get billing_benefitPrivacy => 'Personvern på nettet';

  @override
  String get billing_benefitNoAccount => 'Registrering er ikke påkrevd';

  @override
  String get billing_cancellation => 'Avslutt i Google Play';

  @override
  String get billing_premiumTitle => 'Tilkoblingen din, bedre beskyttet.';

  @override
  String get billing_premiumSubtitle =>
      'Beskytt tilkoblingen i ditt eget tempo.';

  @override
  String get billing_priceMonthly => 'per måned';

  @override
  String get billing_priceYearly => 'per år';

  @override
  String get billing_trialToday => 'Ingenting å betale i dag';

  @override
  String get billing_trialConfirmation =>
      'Google Play bekrefter datoer, sluttbeløp og gjeldende avgifter før du bekrefter.';

  @override
  String get billing_offerChanged =>
      'Vilkårene for dette tilbudet har endret seg. Oppdater abonnementene og velg på nytt.';

  @override
  String get status_waitingNetwork => 'Venter på nettverk';

  @override
  String get status_waitingNetworkDetail =>
      'Ingen nettverk tilgjengelig. VPN kontrollerer tilkoblingen når nettverket kommer tilbake.';

  @override
  String get locations_favoriteLoadFailed =>
      'Favoritter kunne ikke lastes inn. Prøv igjen.';

  @override
  String get locations_favoritesLoading => 'Laster inn favoritter…';
}
