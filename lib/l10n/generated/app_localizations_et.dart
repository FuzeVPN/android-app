// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Kaitse oma ühendust';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN kasutab Androidi VPN-teenust (VpnService), et luua selle seadme ja FuzeVPN-serverite vahel krüpteeritud tunnel.';

  @override
  String get vpnDisclosure_dataBody =>
      'Kui VPN on aktiivne, liiguvad sinu rakenduste internetiliiklus, sihtaadressid ja DNS-päringud läbi selle tunneli, et ühendust suunata – ka siis, kui FuzeVPN töötab taustal.';

  @override
  String get vpnDisclosure_statusBody =>
      'Rakendus kasutab ühenduse olekut, kestust ja edastatud andmemahtu, et kuvada sinu VPN-ühendust. Ühenduse saad igal ajal peatada.';

  @override
  String get vpnDisclosure_privacy => 'Privaatsus';

  @override
  String get vpnDisclosure_accept => 'Nõustu ja jätka';

  @override
  String get vpnDisclosure_decline => 'Mitte praegu';

  @override
  String get accountRestoration_title => 'Konto on ajutiselt kättesaamatu';

  @override
  String get accountRestoration_message =>
      'Sinu seanss on säilitatud. Konto taastamiseks proovi uuesti. VPN-ühendust saad siin endiselt hallata.';

  @override
  String get action_retry => 'Proovi uuesti';

  @override
  String get session_endingTitle => 'Seansi lõpetamine';

  @override
  String get session_ending =>
      'Seansi lõpetamine: VPN-i peatamine ja puhastamine…';

  @override
  String get session_stopFailed =>
      'VPN-i peatamine pole kinnitatud. Tee enne uuesti sisselogimist uus katse.';

  @override
  String get session_cleanupFailed =>
      'VPN on peatatud, kuid seansi eemaldamine pole kinnitatud. Proovi puhastamist uuesti.';

  @override
  String get session_retryStop => 'Proovi peatamist uuesti';

  @override
  String get session_retryCleanup => 'Proovi puhastamist uuesti';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN-i turvaline ettevalmistamine…';

  @override
  String get nav_connection => 'Ühendus';

  @override
  String get nav_locations => 'Asukohad';

  @override
  String get nav_account => 'Konto';

  @override
  String get nav_devices => 'Seadmed';

  @override
  String get nav_settings => 'Seaded';

  @override
  String get action_refresh => 'Värskenda';

  @override
  String get auth_tab_login => 'Logi sisse';

  @override
  String get auth_tab_register => 'Registreeru';

  @override
  String get auth_stepAccount => 'Konto';

  @override
  String get auth_stepIdentity => 'Isikuandmed';

  @override
  String get auth_stepAddress => 'Aadress ja nõusolekud';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Samm $current / $total';
  }

  @override
  String get auth_tagline => 'Sinu VPN, lihtsaks tehtud.';

  @override
  String get auth_keysLocal =>
      'Sinu privaatsed VPN-võtmed jäävad sellesse seadmesse.';

  @override
  String get form_email => 'E-posti aadress';

  @override
  String get form_password => 'Parool';

  @override
  String get form_showPassword => 'Näita parooli';

  @override
  String get form_hidePassword => 'Peida parool';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 baiti. Mõned märgid kasutavad rohkem kui ühte baiti.';

  @override
  String get form_firstName => 'Eesnimi';

  @override
  String get form_lastName => 'Perekonnanimi';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Aadress';

  @override
  String get form_address2 => 'Aadressi 2. rida (valikuline)';

  @override
  String get form_postalCode => 'Postiindeks';

  @override
  String get form_city => 'Linn';

  @override
  String get form_country => 'Riigikood (nt FR)';

  @override
  String get action_login => 'Logi sisse';

  @override
  String get action_createAccount => 'Loo konto';

  @override
  String get action_createMyAccount => 'Loo oma konto';

  @override
  String get action_next => 'Jätka';

  @override
  String get action_previous => 'Tagasi';

  @override
  String get action_forgotPassword => 'Unustasid parooli?';

  @override
  String get auth_noAccount => 'Kas sul pole veel kontot?';

  @override
  String get auth_requiredInformation => 'Loo oma konto kolme sammuga.';

  @override
  String get auth_termsPrefix => 'Nõustun ';

  @override
  String get auth_termsLink => 'kasutustingimustega';

  @override
  String get auth_privacyPrefix => 'Nõustun ';

  @override
  String get auth_privacyLink => 'privaatsuspoliitikaga';

  @override
  String get auth_consentRequired => 'Konto loomiseks on vaja sinu nõusolekut.';

  @override
  String get validation_required => 'See väli on kohustuslik.';

  @override
  String get validation_email => 'Sisesta kehtiv e-posti aadress.';

  @override
  String get validation_password =>
      'Parool on liiga lühike: vähemalt 8 UTF-8 baiti.';

  @override
  String get validation_passwordTooLong =>
      'Parool on liiga pikk: kuni 72 UTF-8 baiti.';

  @override
  String get validation_phone =>
      'Kasuta rahvusvahelist vormingut, näiteks +33612345678.';

  @override
  String get validation_country =>
      'Kasuta kahetähelist riigikoodi, näiteks FR.';

  @override
  String get passwordReset_title => 'Lähtesta parool';

  @override
  String get passwordReset_description =>
      'Parooli lähtestamise lingi taotlemiseks sisesta oma konto e-posti aadress.';

  @override
  String get passwordReset_send => 'Saada link';

  @override
  String get connection_title => 'Sinu ühendus';

  @override
  String get connection_subtitle =>
      'Vali asukoht ja lülita seejärel VPN sisse.';

  @override
  String get connection_prepare => 'Kas oled valmis ühenduma?';

  @override
  String get connection_advancedOptions => 'Täpsemad valikud';

  @override
  String get connection_location => 'Asukoht';

  @override
  String get connection_chooseLocation => 'Vali asukoht';

  @override
  String get connection_protocol => 'Protokoll';

  @override
  String get connection_connect => 'Ühenda';

  @override
  String get connection_connecting => 'Ühendamine…';

  @override
  String get connection_disconnect => 'Katkesta ühendus';

  @override
  String get connection_disconnecting => 'Ühenduse katkestamine';

  @override
  String get connection_locationChange => 'Asukoha muutmine…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol pole saadaval';
  }

  @override
  String get connection_activeLocation => 'Aktiivne asukoht';

  @override
  String get connection_duration => 'Kestus';

  @override
  String get connection_received => 'Saadud';

  @override
  String get connection_sent => 'Saadetud';

  @override
  String get connection_lastHandshake => 'Viimane turvaline andmevahetus';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration tagasi';
  }

  @override
  String get verification_title => 'Kinnita oma e-posti aadress';

  @override
  String get verification_message =>
      'Kinnita oma e-posti aadress, et kasutada VPN-i sellel telefonil.';

  @override
  String get verification_resend => 'Saada e-kiri uuesti';

  @override
  String get migration_title => 'Asukoha muutmine';

  @override
  String get migration_draining => 'Asukoha muutmise ettevalmistamine…';

  @override
  String get migration_activating => 'Uue serveri aktiveerimine…';

  @override
  String get migration_ready => 'Asukoht on uuendatud.';

  @override
  String get migration_blocked =>
      'Asukoha muutmine nõuab serveripoolset sekkumist. Proovi hiljem uuesti või võta ühendust klienditoega.';

  @override
  String get migration_progress => 'Asukoha muutmise edenemine';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Kontrollide vaheline viivitus: $seconds s.';
  }

  @override
  String get migration_resume => 'Jätka asukoha muutmist';

  @override
  String get status_authorizing => 'Vaja on luba';

  @override
  String get status_authorizingDetail =>
      'VPN-i lubamiseks nõustu Androidi taotlusega.';

  @override
  String get status_preparing => 'Ettevalmistamine';

  @override
  String get status_preparingDetail =>
      'Sinu turvaline ühendus valmistatakse ette.';

  @override
  String get status_reconnecting => 'Uuesti ühendamine…';

  @override
  String get status_reconnectingDetail =>
      'Ühendus katkes. VPN proovib uuesti ühenduda.';

  @override
  String get status_connecting => 'Ühendamine';

  @override
  String get status_connectingDetail => 'Ühendatakse VPN-serveriga…';

  @override
  String get status_connected => 'Ühendatud';

  @override
  String get status_connectedDetail => 'Sinu VPN-ühendus on aktiivne.';

  @override
  String get status_disconnecting => 'Ühenduse katkestamine';

  @override
  String get status_disconnectingDetail => 'Sinu VPN-ühendus peatub.';

  @override
  String get status_error => 'Ühendus pole saadaval';

  @override
  String get status_errorDetail =>
      'VPN-ühendus pole kinnitatud. Proovi uuesti.';

  @override
  String get status_idle => 'Ühendus katkestatud';

  @override
  String get status_idleDetail => 'Ühenda VPN, et kaitsta oma ühendust.';

  @override
  String get trust_note =>
      'Rakenduse sulgemine ei peata VPN-i. Peatamiseks kasuta nuppu „Katkesta ühendus“.';

  @override
  String get locations_none => 'Praegu pole ühtegi asukohta saadaval.';

  @override
  String get locations_available => 'Vali järgmine asukoht.';

  @override
  String get locations_selected => 'Valitud asukoht';

  @override
  String get locations_select => 'Vali see asukoht';

  @override
  String get locations_lockedTunnel =>
      'Asukoha muutmiseks katkesta VPN-i ühendus.';

  @override
  String get locations_lockedMigration => 'Oota, kuni asukoha muutmine lõpeb.';

  @override
  String get devices_title => 'Sinu seadmed';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit seadet';
  }

  @override
  String get devices_refresh => 'Värskenda seadmeid';

  @override
  String get devices_empty => 'Ühtegi VPN-seadet pole veel registreeritud.';

  @override
  String get devices_firstConnection =>
      'Sinu telefon lisatakse esimesel ühendamisel.';

  @override
  String get devices_thisDevice => 'See seade';

  @override
  String devices_added(Object date) {
    return 'Lisatud $date';
  }

  @override
  String get devices_unnamed => 'Nimetu seade';

  @override
  String get action_remove => 'Eemalda';

  @override
  String get settings_title => 'Seaded';

  @override
  String get settings_subtitle => 'Sinu eelistused ja konto ühes kohas.';

  @override
  String get settings_appearance => 'Välimus';

  @override
  String get settings_language => 'Keel';

  @override
  String get settings_languageDescription =>
      'Valitud keelt kasutatakse ka VPN-i teavitustes.';

  @override
  String get settings_account => 'Konto';

  @override
  String get settings_signOut => 'Logi välja';

  @override
  String get settings_privacy => 'Privaatsuspoliitika';

  @override
  String get settings_terms => 'Kasutustingimused';

  @override
  String get settings_security => 'Turvalisus ja läbipaistvus';

  @override
  String get settings_licenses => 'Komponentide litsentsid';

  @override
  String get settings_licensesDetail => 'Rakenduses kasutatav tarkvara';

  @override
  String settings_licensesLegalese(String url) {
    return 'Rakenduse ja selle MPL-2.0 komponentide lähtekood: $url';
  }

  @override
  String get settings_background =>
      'VPN jääb tööle ka siis, kui rakendusest lahkud. Peatamiseks kasuta vahekaardil „Ühendus“ nuppu „Katkesta ühendus“.';

  @override
  String get theme_system => 'Süsteem';

  @override
  String get theme_light => 'Hele';

  @override
  String get theme_dark => 'Tume';

  @override
  String get language_system => 'Telefoni keel';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Kas eemaldada see seade?';

  @override
  String get dialog_removeCurrent =>
      'See telefon katkestab VPN-ühenduse ja kaotab juurdepääsu. Selle VPN-ühenduse andmed eemaldatakse pärast serveri kinnitust.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN-juurdepääs seadmele „$name“ tühistatakse. Seda ei saa tagasi võtta.';
  }

  @override
  String get dialog_signOut => 'Kas logida välja?';

  @override
  String get dialog_signOutMessage =>
      'VPN peatatakse ja pead uuesti sisse logima. Sinu krüpteeritud VPN-võtmed jäävad järgmiseks ühenduseks sellele telefonile.';

  @override
  String get action_cancel => 'Tühista';

  @override
  String get action_close => 'Sule';

  @override
  String get action_copy => 'Kopeeri';

  @override
  String get action_signOut => 'Logi välja';

  @override
  String get notice_close => 'Sulge teade';

  @override
  String get notice_sessionExpired_title => 'Seanss on aegunud';

  @override
  String get notice_sessionExpired_message =>
      'Sinu seanss on aegunud. Logi uuesti sisse.';

  @override
  String get notice_connectionFailed_title => 'Ühenduse loomine ebaõnnestus';

  @override
  String get notice_invalidCredentials_message =>
      'E-posti aadress või parool on vale.';

  @override
  String get notice_emailVerification_title =>
      'E-posti aadress tuleb kinnitada';

  @override
  String get notice_emailVerification_message =>
      'Kinnita oma e-posti aadress enne VPN-seadme lisamist.';

  @override
  String get notice_rateLimited_title => 'Liiga palju katseid';

  @override
  String get notice_deviceLimit_title => 'Seadmete limiit on täis';

  @override
  String get notice_deviceLimit_message =>
      'Eemalda enne uue seadme lisamist üks olemasolev seade.';

  @override
  String get notice_identityRenewal_title => 'VPN-i identiteet tuleb uuendada';

  @override
  String get notice_identityRenewal_message =>
      'See identiteet eemaldati. Loo uus kohalik identiteet.';

  @override
  String get notice_migrationPending_title => 'Asukoha muutmine on pooleli';

  @override
  String get notice_migrationPending_message =>
      'Asukoha muutmine on juba pooleli.';

  @override
  String get notice_migrationBlocked_title => 'Asukoha muutmine on blokeeritud';

  @override
  String get notice_migrationBlocked_message =>
      'Asukoha muutmine nõuab serveripoolset sekkumist. Proovi hiljem uuesti või võta ühendust klienditoega.';

  @override
  String get notice_targetUnavailable_title =>
      'Server on ajutiselt kättesaamatu';

  @override
  String get notice_targetUnavailable_message =>
      'See server on ajutiselt kättesaamatu.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetiühendus pole saadaval';

  @override
  String get notice_networkUnavailable_message =>
      'Kontrolli oma ühendust ja proovi uuesti.';

  @override
  String get notice_permissionDenied_title => 'VPN-i luba pole antud';

  @override
  String get notice_permissionDenied_message =>
      'Alusta ühendamist uuesti ja nõustu Androidi loataotlusega.';

  @override
  String get notice_wireguardTimeout_title => 'Server ei vasta';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard-ühendus võttis liiga kaua aega. Proovi uuesti või vali teine asukoht.';

  @override
  String get notice_tlsFailed_title => 'Turvaline ühendus lükati tagasi';

  @override
  String get notice_tlsFailed_message =>
      'Server ei võtnud OpenVPN-ühendust vastu. Proovi uuesti. Kui probleem jätkub, käivita diagnostika.';

  @override
  String get notice_tunRejected_title => 'Android lükkas VPN-liidese tagasi';

  @override
  String get notice_tunRejected_message =>
      'Android lükkas OpenVPN-i taotletud võrgukonfiguratsiooni tagasi.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN-i ei õnnestunud käivitada';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN-i mootori käivitamist ei õnnestunud lõpule viia. Proovi uuesti. Kui probleem püsib, võta ühendust klienditoega.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostikakood: $code';
  }

  @override
  String get notice_generic_title => 'VPN-ühenduse loomine ebaõnnestus';

  @override
  String get notice_generic_message => 'Tekkis viga. Proovi hiljem uuesti.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konto loodud',
      'password_reset_sent': 'Parooli lähtestamise taotlus vastu võetud',
      'verification_email_sent': 'Kinnituskiri saadetud',
      'location_migration_pending': 'Asukoha muutmine on pooleli',
      'vpn_sign_in_required': 'Sisselogimine on vajalik',
      'protocol_unavailable_at_location': 'Protokoll pole saadaval',
      'vpn_permission_denied': 'VPN-i luba pole antud',
      'revoked_identity_device_limit': 'Seadmete limiit on täis',
      'tunnel_start_unexpected': 'VPN-i ei õnnestunud käivitada',
      'flutter_disconnect_timeout': 'Ühenduse katkestamine pole kinnitatud',
      'flutter_disconnect_unexpected': 'Ühenduse katkestamine ebaõnnestus',
      'device_revoked': 'Seade eemaldatud',
      'revoke_unexpected': 'Seadet ei õnnestunud eemaldada',
      'identity_renewal_unexpected': 'Identiteeti ei õnnestunud uuendada',
      'openvpn_renewal_unexpected': 'OpenVPN-i ei õnnestunud uuendada',
      'location_migration_blocked': 'Asukoha muutmine blokeeritud',
      'location_migration_slow': 'Asukoha muutmine on endiselt pooleli',
      'location_migration_conflict': 'Asukoha muutmine vajab värskendamist',
      'location_migration_verification_failed':
          'Asukoha muutmine pole kinnitatud',
      'location_migration_device_changed': 'Seade muutus asukoha muutmise ajal',
      'tunnel_stop_failed': 'Asukoha muutmine pole saadaval',
      'device_clock_ahead': 'Seadme kell on ees',
      'other': 'Toiming ebaõnnestus',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Konto loodi, kuid kinnituskirja ei õnnestunud saata. Saada kiri rakenduses uuesti.',
      'password_reset_sent':
          'Taotlus on vastu võetud. Kui sellele aadressile vastab konto, võid saada e-kirja. Kontrolli ka rämpsposti kausta.',
      'verification_email_sent': 'Uus kinnituskiri on just saadetud.',
      'location_migration_pending':
          'Üleminek asukohta $target on endiselt ettevalmistamisel. Saad jätkata ilma seadet uuesti loomata.',
      'vpn_sign_in_required': 'Logi enne VPN-i käivitamist oma kontole sisse.',
      'protocol_unavailable_at_location':
          'See asukoht ei paku valitud protokolli. Värskenda asukohti või vali teine protokoll.',
      'vpn_permission_denied':
          'Android ei andnud VPN-i luba. Alusta ühendamist uuesti ja nõustu süsteemi taotlusega.',
      'revoked_identity_device_limit':
          'Selle seadme VPN-juurdepääs eemaldati ja seadmete limiit on täis. Eemalda mõni seade jaotises Konto → Halda minu seadmeid.',
      'tunnel_start_unexpected':
          'Ootamatu viga katkestas tunneli ettevalmistamise. Kontrolli diagnostikakoodi ja proovi uuesti.',
      'flutter_disconnect_timeout':
          'Android ei kinnitanud õigeaegselt, et VPN peatus. Proovi see uuesti peatada.',
      'flutter_disconnect_unexpected':
          'Ootamatu viga takistas tunneli peatumise kinnitamist.',
      'device_revoked':
          'Seadme VPN-juurdepääs tühistati ja selle kohalikud salaandmed eemaldati.',
      'revoke_unexpected':
          'Seadet ei õnnestunud eemaldada. Värskenda loendit ja proovi uuesti.',
      'identity_renewal_unexpected':
          'Uut VPN-i identiteeti ei õnnestunud luua. Värskenda seadmeid ja proovi uuesti.',
      'openvpn_renewal_unexpected':
          'OpenVPN-i profiili ei õnnestunud uuendada. Proovi uuesti või kontrolli diagnostikakoodi.',
      'location_migration_blocked':
          'Server ei saa seda muudatust praegu lõpule viia. Seade ja selle kohalik identiteet jäeti alles.',
      'location_migration_slow':
          'Server valmistab üleminekut asukohta $target endiselt ette. Mõne hetke pärast kasuta nuppu „Jätka asukoha muutmist“.',
      'location_migration_conflict':
          'Seadme olek muutus serveris. Värskenda seadmeid ja jätka seejärel asukoha muutmist.',
      'location_migration_verification_failed':
          'Server ei kinnitanud uut asukohta. Eelmine kohalik identiteet jäeti alles.',
      'location_migration_device_changed':
          'Serveri tagastatud seade ei vasta enam seadmele, mida muudetakse. Värskenda seadmeid enne uuesti proovimist.',
      'tunnel_stop_failed':
          'Eelmine tunnel tuleb enne uut ühendust täielikult peatada.',
      'device_clock_ahead':
          'Selle seadme kell näib ees olevat. Sisselogituna püsimiseks lülita sisse automaatne kuupäev ja kellaaeg.',
      'other':
          'Toimingut ei õnnestunud lõpule viia. Proovi uuesti või saada diagnostikakood klienditoele.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Seanss on aegunud',
      'invalid_credentials': 'Sisselogimine ebaõnnestus',
      'email_verification_required': 'E-posti aadress tuleb kinnitada',
      'verification_email_cooldown': 'E-kiri on juba saadetud',
      'rate_limited': 'Liiga palju katseid',
      'invalid_registration': 'Andmeid tuleb parandada',
      'email_exists': 'Konto on juba olemas',
      'invalid_profile': 'Vigane profiil',
      'invalid_device': 'Vigane seade',
      'invalid_location': 'Asukoht pole saadaval',
      'device_limit': 'Seadmete limiit on täis',
      'device_exists': 'VPN-i identiteet on juba kasutusel',
      'device_identity_revoked': 'VPN-i identiteet tuleb uuendada',
      'device_location_locked': 'Asukoha muutmine vajab värskendamist',
      'location_migration_pending': 'Asukoha muutmine on pooleli',
      'location_migration_blocked': 'Asukoha muutmine blokeeritud',
      'target_ca_mismatch': 'Ühildumatu OpenVPN-server',
      'location_migration_conflict': 'Asukoha muutmine vajab värskendamist',
      'server_full': 'Server on täis',
      'capacity_unavailable': 'Asukoht on ajutiselt kättesaamatu',
      'target_unavailable': 'Server on ajutiselt kättesaamatu',
      'not_found': 'Üksust ei leitud',
      'invalid_openvpn_csr': 'Vigane OpenVPN-i identiteet',
      'openvpn_profile_exists': 'OpenVPN-i profiil on juba olemas',
      'openvpn_profile_revoked': 'OpenVPN-i profiil on tühistatud',
      'openvpn_operation_pending': 'OpenVPN-i toiming on pooleli',
      'openvpn_operation_terminal': 'OpenVPN-i toiming katkestati',
      'openvpn_address_unavailable': 'OpenVPN-i aadress pole saadaval',
      'openvpn_profile_conflict': 'OpenVPN-i konflikt',
      'openvpn_signer_unavailable': 'OpenVPN pole saadaval',
      'email_delivery_unavailable': 'E-kirja saatmine pole saadaval',
      'invalid_token': 'Kehtetu link',
      'network_unavailable': 'Internetiühendus pole saadaval',
      'invalid_json': 'Vigane päring',
      'invalid_api_response': 'Vigane serveri vastus',
      'ipv6_unavailable': 'IPv6 pole saadaval',
      'invalid_ip_families': 'Võrgukonfiguratsioon lükati tagasi',
      'other': 'Teenus pole saadaval',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sinu seanss on aegunud. Logi uuesti sisse.',
      'invalid_credentials': 'E-posti aadress või parool on vale.',
      'email_verification_required':
          'Kinnita enne VPN-seadme lisamist oma e-posti aadress.',
      'invalid_registration': 'Kontrolli nõutud andmeid ja nõusolekuid.',
      'email_exists': 'Selle e-posti aadressiga on juba konto.',
      'invalid_profile': 'Kontrolli oma profiili andmeid.',
      'invalid_device': 'Selle seadme nimi või kohalik identiteet on vigane.',
      'invalid_location': 'Värskenda asukohtade loendit ja proovi uuesti.',
      'device_limit': 'Eemalda enne uue seadme lisamist üks olemasolev seade.',
      'device_exists': 'See VPN-i identiteet on juba seotud teise kontoga.',
      'device_identity_revoked':
          'See identiteet eemaldati. Tuleb luua uus kohalik identiteet.',
      'device_location_locked':
          'Selle seadme asukoht on just muutunud. Rakendus jätkab pooleli oleva muutmisega.',
      'location_migration_pending': 'Asukoha muutmine on juba pooleli.',
      'location_migration_blocked':
          'Asukoha muutmine nõuab serveripoolset sekkumist. Proovi hiljem uuesti või võta ühendust klienditoega.',
      'target_ca_mismatch':
          'See server ei ühildu veel praeguse OpenVPN-i profiiliga.',
      'location_migration_conflict':
          'Värskenda seadmeid ja proovi asukoha muutmist uuesti.',
      'server_full':
          'Selles asukohas on ühenduste limiit täis. Vali teine asukoht või proovi hiljem uuesti.',
      'capacity_unavailable':
          'Praegu ei saa kinnitada, kas see asukoht on saadaval. Vali teine asukoht või proovi hiljem uuesti.',
      'target_unavailable': 'See server on ajutiselt kättesaamatu.',
      'not_found': 'See üksus ei ole enam sinu kontol saadaval.',
      'invalid_openvpn_csr': 'Loo uus OpenVPN-i identiteet ja proovi uuesti.',
      'openvpn_profile_exists':
          'Selle seadme jaoks on OpenVPN-i profiil juba olemas.',
      'openvpn_profile_revoked': 'Jätkamiseks uuenda OpenVPN-i profiili.',
      'openvpn_operation_pending':
          'Muudatus on veel rakendumas. Proovi hiljem uuesti.',
      'openvpn_operation_terminal':
          'Loo uus OpenVPN-i identiteet ja proovi uuesti.',
      'openvpn_address_unavailable':
          'Praegu pole ühtegi OpenVPN-i aadressi saadaval.',
      'openvpn_profile_conflict':
          'Profiil on muutunud. Värskenda seadmeid ja proovi uuesti.',
      'openvpn_signer_unavailable':
          'OpenVPN-i teenus on ajutiselt kättesaamatu.',
      'email_delivery_unavailable':
          'E-kirja ei õnnestunud saata. Proovi hiljem uuesti.',
      'invalid_token': 'See link on kehtetu või aegunud. Taotle uus.',
      'network_unavailable':
          'Kontrolli oma internetiühendust ja proovi uuesti.',
      'invalid_json': 'Kontrolli sisestatud andmeid ja proovi uuesti.',
      'invalid_api_response':
          'Server saatis ootamatu vastuse. Proovi hiljem uuesti.',
      'ipv6_unavailable':
          'Server ei saa praegu IPv6 aktiveerida. Proovi hiljem uuesti.',
      'invalid_ip_families':
          'Tunneli konfiguratsioon on puudulik või ei vasta lubatud aadressidele. Proovi rakendusest uuesti.',
      'other': 'Tekkis serveri viga. Proovi hiljem uuesti.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Proovi mõne hetke pärast uuesti.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Proovi $seconds sekundi pärast uuesti.',
      one: 'Proovi $seconds sekundi pärast uuesti.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Proovi $minutes minuti pärast uuesti.',
      one: 'Proovi $minutes minuti pärast uuesti.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Proovi $hours tunni pärast uuesti.',
      one: 'Proovi $hours tunni pärast uuesti.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Süsteemi VPN-i jätkamine pole saadaval',
      'system_vpn_resume_corrupt': 'Vigane süsteemi VPN-i jätkamine',
      'system_vpn_resume_session_invalid': 'Vigane VPN-i jätkamise seanss',
      'system_vpn_resume_identity_changed': 'VPN-i identiteet on muutunud',
      'system_vpn_resume_identity_invalid': 'Vigane VPN-i jätkamise identiteet',
      'system_vpn_resume_storage_failed':
          'VPN-i jätkamise hoidla pole saadaval',
      'system_vpn_resume_network_timeout': 'VPN-i jätkamiseks puudub võrk',
      'system_vpn_resume_blocked': 'VPN-i jätkamine on blokeeritud',
      'system_vpn_resume_failed': 'VPN-i jätkamine ebaõnnestus',
      'system_vpn_resume_error_invalid': 'Vigane VPN-i jätkamise viga',
      'wireguard_identity_store_failed':
          'WireGuardi identiteeti ei salvestatud',
      'wireguard_identity_unavailable': 'WireGuardi identiteet pole saadaval',
      'vpn_host_destroyed': 'Androidi VPN-i komponent on peatatud',
      'vpn_host_unavailable': 'Androidi VPN-i komponent pole saadaval',
      'vpn_permission_required': 'VPN-i luba on vajalik',
      'vpn_permission_denied': 'VPN-i luba pole antud',
      'vpn_permission_request_failed': 'Luba ei õnnestunud taotleda',
      'wireguard_foreground_service_unavailable':
          'WireGuardi teenus pole saadaval',
      'wireguard_identity_invalid': 'Kohalik WireGuardi võti on vigane',
      'wireguard_identity_in_use': 'WireGuardi identiteet on juba kasutusel',
      'wireguard_configuration_invalid': 'Vigane WireGuardi konfiguratsioon',
      'wireguard_operation_pending': 'WireGuardi toiming on veel käimas',
      'wireguard_start_failed': 'WireGuardi käivitamine lükati tagasi',
      'wireguard_stop_timeout': 'WireGuardi peatamist ei kinnitatud',
      'wireguard_handshake_timeout': 'WireGuard ei vastanud',
      'openvpn_connection_timeout': 'OpenVPN ei vastanud',
      'openvpn_core_unavailable': 'OpenVPN-i mootor pole saadaval',
      'openvpn_operation_pending': 'OpenVPN-i seanss on veel aktiivne',
      'openvpn_stop_timeout': 'OpenVPN-i peatamist ei kinnitatud',
      'openvpn_profile_unavailable': 'Kohalik OpenVPN-i profiil puudub',
      'openvpn_native_failed': 'OpenVPN-i natiivne päring katkes',
      'openvpn_key_generation_failed':
          'OpenVPN-i P-256 võtit ei õnnestunud luua',
      'openvpn_csr_generation_failed': 'OpenVPN-i CSR-i ei õnnestunud luua',
      'openvpn_identity_store_failed': 'OpenVPN-i identiteeti ei salvestatud',
      'openvpn_identity_clear_failed': 'OpenVPN-i eemaldamine jäi pooleli',
      'openvpn_identity_in_use': 'OpenVPN-i identiteet on veel kasutusel',
      'openvpn_tls_verification_required': 'OpenVPN-i TLS-kontroll puudub',
      'openvpn_cipher_invalid': 'Vigane OpenVPN-i šiffer',
      'openvpn_profile_rejected': 'OpenVPN-i profiil lükati tagasi',
      'openvpn_identity_inconsistent': 'OpenVPN-i identiteet on vastuolus',
      'tls_handshake_failed': 'OpenVPN-i läbirääkimine lükati tagasi',
      'tls_alert_unknown_ca': 'OpenVPN-i kliendisertifikaati ei tuvastatud',
      'tls_alert_bad_certificate': 'OpenVPN-i kliendisertifikaat lükati tagasi',
      'tls_alert_unsupported_certificate':
          'OpenVPN-i sertifikaat pole toetatud',
      'tls_client_certificate_required':
          'OpenVPN-i kliendisertifikaat on vajalik',
      'tls_alert_misc': 'OpenVPN-i TLS-hoiatus',
      'tls_signature_algorithm_rejected':
          'OpenVPN-i allkirjastusalgoritm pole toetatud',
      'tls_handshake_rejected': 'OpenVPN-i TLS-läbirääkimine lükati tagasi',
      'tls_version_rejected': 'OpenVPN-i TLS-versioon ei ühildu',
      'tls_certificate_expired': 'TLS-sertifikaat on aegunud',
      'tls_certificate_revoked': 'TLS-sertifikaat on tühistatud',
      'transport_failed': 'OpenVPN-i server pole kättesaadav',
      'tun_configuration_rejected': 'OpenVPN-liidest ei õnnestunud luua',
      'tun_setup_failed': 'OpenVPN-i TUN-i seadistamine ebaõnnestus',
      'tun_interface_create_failed': 'OpenVPN-liidese loomine ebaõnnestus',
      'tun_interface_disabled': 'OpenVPN-liides on keelatud',
      'tun_halted': 'OpenVPN-liides katkes',
      'tun_already_established': 'OpenVPN-liides on juba avatud',
      'tun_addresses_missing': 'OpenVPN-i aadress puudub',
      'tun_routes_missing': 'OpenVPN-i marsruudid puuduvad',
      'tun_dns_missing': 'OpenVPN-i DNS puudub',
      'tun_permission_revoked': 'VPN-i luba tühistati',
      'tun_establish_returned_null': 'Android lükkas VPN-liidese tagasi',
      'openvpn_service_start_failed': 'OpenVPN-i teenus pole saadaval',
      'openvpn_operation_timeout': 'OpenVPN-i päring aegus',
      'openvpn_start_failed': 'OpenVPN-i käivitamine lükati tagasi',
      'openvpn_connection_failed': 'OpenVPN-i ühendus katkes',
      'openvpn_core_status_error': 'OpenVPN Core lõppes veaga',
      'openvpn_stopped_before_connected':
          'OpenVPN peatus enne ühenduse loomist',
      'openvpn_auth_failed': 'OpenVPN-i autentimine lükati tagasi',
      'openvpn_client_setup_failed':
          'OpenVPN-i kliendi seadistamine ebaõnnestus',
      'openvpn_client_halted': 'OpenVPN-i klient katkes',
      'openvpn_client_restart': 'OpenVPN-i taaskäivitamist taotleti',
      'openvpn_inactive_timeout': 'OpenVPN on liiga kaua passiivne',
      'openvpn_session_expired': 'OpenVPN-i seanss aegus',
      'openvpn_credentials_required': 'OpenVPN-i autentimine pole toetatud',
      'openvpn_proxy_failed': 'OpenVPN-i puhverserveri tõrge',
      'openvpn_compression_failed': 'OpenVPN-i tihendus lükati tagasi',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN-i NTLM-krüpteerimine pole saadaval',
      'openvpn_feature_unsupported': 'OpenVPN-i funktsioon pole toetatud',
      'network_unavailable': 'Internetiühendus pole saadaval',
      'network_lost': 'Võrk pole saadaval',
      'certificate_validation_failed': 'Serveri sertifikaat lükati tagasi',
      'openvpn_certificate_expired': 'OpenVPN-i sertifikaat on aegunud',
      'tunnel_active_for_another_account':
          'Teise konto tunnel on veel aktiivne',
      'tunnel_already_active': 'Natiivne tunnel on juba aktiivne',
      'tunnel_stop_timeout': '$protocol: peatamine pole kinnitatud',
      'tunnel_disconnected': '$protocol katkes',
      'native_bridge_unavailable': 'Androidi sild pole saadaval',
      'native_operation_failed': 'Androidi toiming katkes',
      'invalid_arguments': 'VPN-i parameetrid on puudulikud',
      'invalid_account_id': 'Vigane VPN-i konto',
      'invalid_device_id': 'Vigane seadme identifikaator',
      'storage_key_not_allowed': 'Hoidla võti lükati tagasi',
      'secure_storage_read_failed': 'Turvalisest hoidlast lugemine ebaõnnestus',
      'secure_storage_write_failed':
          'Turvalisse hoidlasse kirjutamine ebaõnnestus',
      'key_generation_failed': 'WireGuardi võtme loomine ebaõnnestus',
      'csr_generation_failed': 'OpenVPN-i CSR-i ei õnnestunud luua',
      'openvpn_recovery_exhausted': 'OpenVPN-i taastamine on juba kasutatud',
      'openvpn_recovery_failed': 'OpenVPN-i taastamine ebaõnnestus',
      'openvpn_renewal_required':
          'OpenVPN-i sertifikaadi uuendamine on vajalik',
      'other': 'Liigitamata natiivne VPN-i viga',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ei leia jätkatavat VPN-i seanssi. Loo rakenduses uus ühendus.',
      'system_vpn_resume_corrupt':
          'Salvestatud VPN-i jätkamise andmed on vigased ja neid ei kasutata. Loo uus ühendus.',
      'system_vpn_resume_session_invalid':
          'Salvestatud seanss ei saa enam VPN-i jätkata. Logi rakenduses uuesti sisse.',
      'system_vpn_resume_identity_changed':
          'Kohalik VPN-i identiteet on muutunud. Jätkamine peatati; loo uus ühendus.',
      'system_vpn_resume_identity_invalid':
          'Jätkamiseks kasutatav identiteet on vigane. Loo uus ühendus.',
      'system_vpn_resume_storage_failed':
          'Android ei saanud krüpteeritud jätkamisandmeid lugeda ega uuendada. Loo uus ühendus.',
      'system_vpn_resume_network_timeout':
          'Android ei leidnud VPN-i jätkamiseks õigeaegselt võrku. Proovi uuesti, kui võrk on saadaval.',
      'system_vpn_resume_blocked':
          'VPN-i jätkamine on blokeeritud. Kontrolli Androidi seadeid ja loo seejärel uus ühendus.',
      'system_vpn_resume_failed':
          'Androidi VPN-i jätkamine ebaõnnestus. Loo rakenduses uus ühendus.',
      'system_vpn_resume_error_invalid':
          'Android tagastas kasutuskõlbmatu jätkamisvea. Loo uus ühendus.',
      'wireguard_identity_store_failed':
          'Android ei saanud selle konto krüpteeritud WireGuardi identiteeti salvestada.',
      'wireguard_identity_unavailable':
          'Selle ühenduse jaoks pole kasutatavat WireGuardi identiteeti saadaval.',
      'vpn_host_destroyed':
          'VPN-i käitav Androidi komponent peatati. Loo uus ühendus.',
      'vpn_host_unavailable':
          'Android ei saa luua VPN-i käitavat komponenti. Kontrolli VPN-i seadeid ja proovi uuesti.',
      'openvpn_renewal_required':
          'Sertifikaat nõuab enne ühendamist toimingut rakenduses.',
      'openvpn_recovery_failed':
          'Automaatne taastamine ebaõnnestus. Loo rakenduses uus ühendus.',
      'openvpn_recovery_exhausted':
          'Automaatset taastamist on juba kasutatud. Loo rakenduses uus ühendus.',
      'vpn_permission_required':
          'Android nõuab enne tunneli käivitamist uut VPN-i luba.',
      'vpn_permission_denied':
          'Jätkamiseks anna Androidi taotluses FuzeVPN-ile luba.',
      'vpn_permission_request_failed':
          'Android ei saanud avada VPN-i loa ekraani.',
      'wireguard_foreground_service_unavailable':
          'Android ei saanud WireGuardi teenust esiplaanil hoida.',
      'wireguard_identity_invalid':
          'Selle konto krüpteeritud WireGuardi võti on loetamatu või vigane.',
      'wireguard_identity_in_use':
          'Teine toiming kasutab veel selle konto WireGuardi võtit.',
      'wireguard_configuration_invalid':
          'Saadud WireGuardi aadress, DNS, serveri võti või marsruudid on vigased.',
      'wireguard_operation_pending':
          'Eelmine WireGuardi toiming pole veel oma natiivset teenust vabastanud.',
      'wireguard_start_failed':
          'WireGuardi mootor lükkas konfiguratsiooni aktiveerimise tagasi.',
      'wireguard_stop_timeout':
          'WireGuardi teenus ei kinnitanud VPN-liidese vabastamist ettenähtud aja jooksul.',
      'wireguard_handshake_timeout':
          'Tunnel ei kinnitanud serveriga käepigistust õigeaegselt.',
      'openvpn_connection_timeout':
          'OpenVPN ei kinnitanud ühendust serveriga õigeaegselt.',
      'openvpn_core_unavailable':
          'See rakenduse versioon ei sisalda kasutatavat OpenVPN-i mootorit.',
      'openvpn_operation_pending':
          'Natiivne mootor hoiab veel eelmist OpenVPN-i seanssi ega luba luua teist.',
      'openvpn_stop_timeout':
          'OpenVPN Core ei kinnitanud ettenähtud aja jooksul, et selle natiivne seanss peatati ja hävitati.',
      'openvpn_profile_unavailable':
          'Selle ühenduse jaoks pole võimalik lugeda kontrollitud OpenVPN-i profiili.',
      'openvpn_native_failed':
          'Rakenduse viga katkestas OpenVPN-i. Proovi ühendust uuesti luua. Kui probleem jätkub, käivita diagnostika.',
      'openvpn_key_generation_failed':
          'Android Keystore ei saanud luua ega lugeda eksportimatut P-256 privaatvõtit.',
      'openvpn_csr_generation_failed':
          'Android Keystore’i võti ei saanud OpenVPN-i sertifikaaditaotlust allkirjastada.',
      'openvpn_identity_store_failed':
          'OpenVPN-i sertifikaati või profiili ei õnnestunud krüpteeritult salvestada.',
      'openvpn_identity_clear_failed':
          'Android ei saanud selle konto kogu kohalikku OpenVPN-i identiteeti eemaldada.',
      'openvpn_identity_in_use':
          'Natiivne OpenVPN-i seanss kasutab veel selle seadme võtit või sertifikaati.',
      'openvpn_tls_verification_required':
          'Profiil ei nõua selgesõnaliselt serveri sertifikaadi kontrollimist.',
      'openvpn_cipher_invalid':
          'Server pakkus krüpteerimisalgoritmi, mida lubatud loendis pole.',
      'openvpn_profile_rejected':
          'Serverist saadud profiil ei ühildu. Loo see seade uuesti ja proovi siis uuesti.',
      'openvpn_identity_inconsistent':
          'Sertifikaat ei vasta selle telefoni turvalisele identiteedile. Ühtegi kohalikku profiili ei asendatud.',
      'tls_handshake_failed':
          'Server lükkas TLS-läbirääkimise tagasi. Kui probleem püsib, loo profiil uuesti.',
      'tls_alert_unknown_ca':
          'Server ei tunne selle seadme sertifikaadi väljaandjat ära. OpenVPN-i server tuleb üle kontrollida.',
      'tls_alert_bad_certificate':
          'Server lükkas selle seadme sertifikaadi tagasi. Enne uut katset loo seade uuesti.',
      'tls_alert_unsupported_certificate':
          'Server ei toeta Androidi kasutatavat turvalist sertifikaaditüüpi.',
      'tls_client_certificate_required':
          'Server nõuab kliendisertifikaati, kuid OpenVPN Core ei saanud seda esitada.',
      'tls_alert_misc':
          'Server tagastas TLS-hoiatuse, mis ei kuulu sertifikaadi ega versiooni kategooriasse.',
      'tls_signature_algorithm_rejected':
          'Server lükkas Android Keystore’i võtme ECDSA P-256 algoritmi tagasi.',
      'tls_handshake_rejected':
          'Server katkestas TLS-läbirääkimise enne ühenduse loomist.',
      'tls_version_rejected':
          'Klient ja server ei leidnud ühist TLS-versiooni.',
      'tls_certificate_expired':
          'Ühenduse ajal esitatud sertifikaat on aegunud.',
      'tls_certificate_revoked':
          'Ühenduse ajal esitatud sertifikaat on tühistatud.',
      'transport_failed':
          'OpenVPN-i server ei vasta praeguses võrgus. Proovi mõne hetke pärast uuesti.',
      'tun_configuration_rejected':
          'Android lükkas OpenVPN-i taotletud võrgukonfiguratsiooni tagasi.',
      'tun_setup_failed':
          'OpenVPN Core lükkas võrguplaani tagasi enne Androidi liidese loomist.',
      'tun_interface_create_failed':
          'OpenVPN Core ei saanud Android VpnService’ilt TUN-liidest kätte.',
      'tun_interface_disabled':
          'Android või OpenVPN Core keelas ühenduse ajal TUN-liidese.',
      'tun_halted': 'OpenVPN Core sai taotluse TUN-liidese peatamiseks.',
      'tun_already_established':
          'OpenVPN taotles samas ühenduses teist liidest. Tunnel peatati turvalisuse huvides.',
      'tun_addresses_missing':
          'Server ei esitanud kasutatavat tunneli aadressi.',
      'tun_routes_missing':
          'Server ei esitanud kasutatavaid tunneli marsruute.',
      'tun_dns_missing': 'Server ei esitanud kasutatavat DNS-serverit.',
      'tun_permission_revoked': 'Android tühistas ühenduse ajal VPN-i loa.',
      'tun_establish_returned_null':
          'Android ei loonud liidest, tavaliselt seetõttu, et mõni teine VPN on veel aktiivne.',
      'openvpn_service_start_failed':
          'Android ei saanud OpenVPN-i esiplaaniteenust käivitada.',
      'openvpn_operation_timeout':
          'JNI-päring OpenVPN Core’ile ületas maksimaalse kestuse.',
      'openvpn_start_failed':
          'Androidi teenus on valmis, kuid OpenVPN Core ei võtnud profiili käivitamist vastu.',
      'openvpn_connection_failed':
          'OpenVPN Core peatus enne CONNECTED-sündmuse väljastamist.',
      'openvpn_core_status_error':
          'Natiivne OpenVPN-i tsükkel lõppes veaga, ilma täpsema lõppsündmuseta.',
      'openvpn_stopped_before_connected':
          'Natiivne OpenVPN-i tsükkel peatus enne olekut CONNECTED, ilma selge Core’i veata.',
      'openvpn_auth_failed':
          'OpenVPN-i server lükkas profiili autentimise tagasi.',
      'openvpn_client_setup_failed':
          'OpenVPN Core ei suutnud klienti enne võrguühendust lähtestada.',
      'openvpn_client_halted':
          'OpenVPN Core sai kliendi lõpliku peatamise käsu.',
      'openvpn_client_restart':
          'OpenVPN Core palus oma edastusseansi taaskäivitamist.',
      'openvpn_inactive_timeout':
          'OpenVPN Core sulges seansi pärast tegevusetuse aegumist.',
      'openvpn_session_expired':
          'Server teatas, et OpenVPN-i seanss on aegunud.',
      'openvpn_credentials_required':
          'Server või puhverserver nõuab interaktiivseid sisselogimisandmeid, mida see sertifikaadiprofiil ei sisalda.',
      'openvpn_proxy_failed':
          'OpenVPN Core teatas seadistatud puhverserveri või relee tõrkest.',
      'openvpn_compression_failed':
          'OpenVPN Core lükkas profiili või serveri teatatud tihendusrežiimi tagasi.',
      'openvpn_ntlm_crypto_unavailable':
          'Profiil nõuab NTLM-krüpteerimist, mis pole selles versioonis saadaval.',
      'openvpn_feature_unsupported':
          'Profiil või server nõuab funktsiooni, mida selles Androidi kliendis pole.',
      'network_unavailable': 'Kasutatavat füüsilist võrku pole saadaval.',
      'network_lost': 'Tunnel peatati pärast võrgu kadumist.',
      'certificate_validation_failed':
          'OpenVPN-i serveri identiteeti ei õnnestunud kontrollida.',
      'openvpn_certificate_expired':
          'Uuenda enne uuesti ühendamist OpenVPN-i profiili.',
      'tunnel_active_for_another_account':
          'Enne selle ühenduse loomist tuleb peatada teise konto tunnel.',
      'tunnel_already_active':
          'Android teatab, et eelmine VPN-i seanss kasutab liidest veel.',
      'tunnel_stop_timeout':
          '$protocol-mootor ei kinnitanud ettenähtud aja jooksul VPN-liidese vabastamist.',
      'tunnel_disconnected':
          'Natiivne mootor teatas, et tunnel lõppes pärast käivitamist ootamatult.',
      'native_bridge_unavailable':
          'Rakendus ei pääse Androidi VPN-teenusele ligi. Sulge rakendus ja ava see uuesti, seejärel proovi veel kord.',
      'native_operation_failed':
          'Rakenduse viga katkestas VPN-i toimingu. Proovi uuesti. Kui probleem jätkub, käivita diagnostika.',
      'invalid_arguments':
          'Selle VPN-i toimingu jaoks vajalik teave on puudulik. Proovi uuesti. Kui probleem jätkub, käivita diagnostika.',
      'invalid_account_id':
          'Natiivne toiming ei ole seotud kehtiva konto identifikaatoriga.',
      'invalid_device_id':
          'Natiivsele mootorile saadetud seadme identifikaator puudub või on vigane.',
      'storage_key_not_allowed':
          'Androidi sild blokeeris võtme, mis ei kuulu lubatud salvestusvõtmete loendisse.',
      'secure_storage_read_failed':
          'Android Keystore ei saanud selle konto kohalikke andmeid dekrüpteerida.',
      'secure_storage_write_failed':
          'Android Keystore ei saanud kohalikke andmeid krüpteerida ega salvestada.',
      'key_generation_failed':
          'Android ei saanud turvalises hoidlas WireGuardi võtit luua ega lugeda.',
      'csr_generation_failed':
          'Android Keystore ei saanud luua ega allkirjastada OpenVPN-i P-256 CSR-i.',
      'other':
          'Dokumenteerimata natiivne koodiharu ebaõnnestus. Saada allpool kuvatud diagnostikakood klienditoele.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Loataotlus on juba avatud';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Androidi VPN-i loataotlus on juba kuvatud. Lõpeta see enne uuesti proovimist.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-i loataotlus katkestati';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN-i loa ekraan suleti enne, kui rakendus vastuse sai.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-i ühendust ei kinnitatud';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN-i ühendust ei õnnestunud kinnitada. Turvalisuse huvides see peatati. Proovi uuesti.';

  @override
  String get openvpnCleanup_title => 'OpenVPN-i profiil tühistatud';

  @override
  String get openvpnCleanup_working =>
      'Tühistatud OpenVPN-i profiili peatamine ja eemaldamine…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-i peatamine pole kinnitatud. Enne uue profiili loomist proovi uuesti.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Tühistatud OpenVPN-i profiili ei õnnestunud täielikult eemaldada. Proovi puhastamist uuesti.';

  @override
  String get openvpnCleanup_complete =>
      'Tühistatud OpenVPN-i profiil on eemaldatud. Uue loomiseks puuduta nuppu „Ühenda“.';

  @override
  String get network_title => 'Võrgukonfiguratsioon';

  @override
  String get network_ipv4Fallback =>
      'IPv6 on ajutiselt kättesaamatu. Ettevalmistamist jätkatakse IPv4-ga.';

  @override
  String get network_rejectedTitle => 'Võrgukonfiguratsioon lükati tagasi';

  @override
  String get network_rejectedMessage =>
      'Tunneli konfiguratsioon on puudulik või ei vasta lubatud aadressidele. Proovi rakendusest uuesti.';

  @override
  String get network_unreadableTitle => 'Kohalik konfiguratsioon on loetamatu';

  @override
  String get network_unreadableMessage =>
      'Salvestatud OpenVPN-i võrgukonfiguratsiooni ei saa kasutada. Värskendamiseks ühenda rakendusest uuesti.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Võrgukaitse';

  @override
  String get protection_subtitle =>
      'Blokeeri otsene juurdepääs internetile, kui VPN katkeb.';

  @override
  String get protection_active => 'Süsteemikaitse on aktiivne';

  @override
  String get protection_alwaysOnOnly =>
      'Alati sees VPN on lubatud; lülita sisse blokeerimine ilma VPN-ita';

  @override
  String get protection_inactive => 'Süsteemikaitse pole aktiivne';

  @override
  String get protection_unknown => 'Kontrolli süsteemikaitset';

  @override
  String get protection_openSettings => 'Ava Androidi seaded';

  @override
  String get protection_dialogTitle => 'Võrgukaitse seadistamine';

  @override
  String get protection_dialogMessage =>
      'Android haldab alati sees VPN-i ja ühenduste blokeerimist ilma VPN-ita. Kontrolli, et valitud oleks FuzeVPN, ja luba blokeerimine süsteemiseadetes.';

  @override
  String get protection_dialogOpen => 'Ava seaded';

  @override
  String get session_systemProtectionNote =>
      'Kui Android blokeerib endiselt liiklust ilma VPN-ita, ava süsteemiseaded, et seda kaitset kontrollida või muuta.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Rakenduse diagnostika';

  @override
  String get diagnostics_automaticTitle => 'Saada olulised vead';

  @override
  String get diagnostics_automaticDescription =>
      'Jaga väikest tehnilist aruannet, kui ilmneb oluline viga.';

  @override
  String get diagnostics_privacy =>
      'Saadetud aruanded seostatakse sisselogitud kontoga ja neid hoitakse 30 päeva. Need ei sisalda sirvimisajalugu, paroole ega VPN-i võtmeid.';

  @override
  String get diagnostics_manualOpen => 'Käivita diagnostika';

  @override
  String get diagnostics_localDescription =>
      'Koosta rakenduse ja VPN-i oleku aruanne. Sinu ühendus jääb muutmata.';

  @override
  String get diagnostics_sendReport => 'Saada aruanne';

  @override
  String get diagnostics_sendHint =>
      'Jäta see märkeruut märkimata, et aruanne jääks sellesse seadmesse.';

  @override
  String get diagnostics_signedOut =>
      'Aruande saatmiseks logi oma kontole sisse.';

  @override
  String get diagnostics_localLifetime =>
      'Et aruanne jääks alles ka pärast rakenduse sulgemist, salvesta see oma telefoni.';

  @override
  String get diagnostics_run => 'Käivita diagnostika';

  @override
  String get diagnostics_rerun => 'Käivita diagnostika uuesti';

  @override
  String get diagnostics_running => 'Kontrollimine…';

  @override
  String get diagnostics_sending => 'Aruande saatmine…';

  @override
  String get diagnostics_prepared => 'Aruanne on selles seadmes valmis';

  @override
  String get diagnostics_queued => 'Aruanne ootab saatmist';

  @override
  String get diagnostics_sent => 'Aruanne on vastu võetud';

  @override
  String get diagnostics_failed =>
      'Saatmine ebaõnnestus. Kohalik aruanne on endiselt saadaval.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostikaaruannet ei õnnestunud koostada. Proovi uuesti.';

  @override
  String get diagnostics_authenticationRequired =>
      'Aruande saatmiseks logi uuesti sisse.';

  @override
  String get diagnostics_retry => 'Proovi saatmist uuesti';

  @override
  String get diagnostics_export => 'Salvesta aruanne';

  @override
  String get diagnostics_exportFailed =>
      'Eksportimine ebaõnnestus. Proovi uuesti kohalikust aruandest.';

  @override
  String get diagnostics_preferenceFailed =>
      'Seda seadistust ei õnnestunud salvestada. Proovi uuesti.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Viide: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Vastu võetud $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Hoitakse kuni $date';
  }

  @override
  String get diagnostics_duplicate => 'See aruanne oli juba vastu võetud.';

  @override
  String get diagnostics_preview => 'Aruande eelvaade';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lisatud on $count tehnilist sündmust',
      one: 'Lisatud on 1 tehniline sündmus',
      zero: 'Tehnilisi sündmusi pole lisatud',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Tehnilised üksikasjad';

  @override
  String get diagnostics_empty => 'Diagnostikaaruannet pole veel koostatud.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunneli olek',
      'handshake': 'Ühenduse kinnitamine',
      'certificate': 'VPN-i sertifikaat',
      'kill_switch': 'Androidi kaitse',
      'connectivity': 'Saadaolev võrk',
      'api_reachability': 'Juurdepääs teenusele',
      'secure_storage': 'Turvaline hoidla',
      'other': 'Kohalik kontroll',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Kontrollitud',
      'failed': 'Vajab tähelepanu',
      'skipped': 'Pole testitud – aktiivset kontrolli ei tehtud',
      'unknown': 'Teave pole saadaval',
      'other': 'Teave pole saadaval',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Tere tulemast FuzeVPN-i';

  @override
  String get connection_changeLocation => 'Muuda asukohta';

  @override
  String get connection_details => 'Ühenduse üksikasjad';

  @override
  String get locations_searchLabel => 'Otsi linna või riiki';

  @override
  String get locations_clearSearch => 'Tühjenda otsing';

  @override
  String get locations_filterAll => 'Kõik';

  @override
  String get locations_filterFavorites => 'Lemmikud';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count asukohta',
      one: '$count asukoht',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Asukohti ei leitud';

  @override
  String get locations_noResultsHint => 'Proovi teist linna või riiki.';

  @override
  String get locations_noFavorites => 'Sinu lemmikud käeulatuses';

  @override
  String get locations_noFavoritesHint =>
      'Asukoha siia salvestamiseks puuduta selle kõrval olevat tärni.';

  @override
  String get locations_showAll => 'Vaata kõiki asukohti';

  @override
  String locations_addFavorite(String name) {
    return 'Lisa $name lemmikute hulka';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Eemalda $name lemmikute hulgast';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Lemmikut ei õnnestunud salvestada. Proovi uuesti.';

  @override
  String get locations_emptyTitle => 'Asukohti pole saadaval';

  @override
  String get locations_emptyHint => 'Värskenda loendit ja proovi uuesti.';

  @override
  String get devices_manage => 'Halda minu seadmeid';

  @override
  String get settings_personalization => 'Isikupärastamine';

  @override
  String get settings_safety => 'Kaitse';

  @override
  String get settings_help => 'Vajad abi?';

  @override
  String get settings_about => 'Teave FuzeVPN-i kohta';

  @override
  String get diagnostics_heading => 'Ühendusprobleemi mõistmine';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Saadaval',
      'pending': 'Ettevalmistamine',
      'revoked': 'Eemaldatud',
      'expired': 'Aegunud',
      'other': 'Olek pole saadaval',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Eelistust ei salvestatud';

  @override
  String get notice_preferenceSave_message =>
      'Sinu valik on praegu rakendatud, kuid seda ei õnnestunud salvestada. Proovi uuesti, et see jääks alles ka pärast rakenduse sulgemist.';

  @override
  String get connection_androidDisconnectHint =>
      'Kui Android hoiab VPN-i aktiivsena, lülita avanevates seadetes välja „Alati sees VPN“.';

  @override
  String get protection_learnMore => 'Lisateave Androidi kaitse kohta';

  @override
  String get protection_guideWhy =>
      'See kaitse takistab rakendustel internetti otse kasutamast, kui VPN-ühendus katkeb. Seda seadistatakse Androidis.';

  @override
  String get protection_guideAlwaysOnTitle => 'Alati sees VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android hoiab VPN-teenuse töös ja saab selle pärast telefoni taaskäivitamist uuesti käivitada.';

  @override
  String get protection_guideBlockTitle => 'Blokeeri ühendused ilma VPN-ita';

  @override
  String get protection_guideBlock =>
      'See seadistus takistab andmeliiklusel VPN-ist mööda minna, ka ühenduse katkemise ajal.';

  @override
  String get protection_guideWarning =>
      'Kui blokeerimine on sisse lülitatud, pole internet kättesaadav, kuni VPN on ühendatud.';

  @override
  String get protection_guideStepsTitle => 'Lülita kaitse sisse';

  @override
  String get protection_guideStep1 =>
      'Ava Androidi VPN-i seaded allolevat nuppu puudutades.';

  @override
  String get protection_guideStep2 =>
      'Ava valikud FuzeVPN-i kõrval oleva hammasrattaikooni abil.';

  @override
  String get protection_guideStep3 =>
      'Lülita sisse „Alati sees VPN“ ning seejärel „Blokeeri ühendused ilma VPN-ita“, kui need valikud on saadaval.';

  @override
  String get protection_guideManufacturers =>
      'Nimetused erinevad telefoniti. Vajadusel otsi seadetest „VPN“, sageli jaotisest „Võrk ja internet“.';

  @override
  String get protection_guideDisableTitle => 'Lülita see kaitse välja';

  @override
  String get protection_guideDisable =>
      'Lülita samades seadetes blokeerimine ilma VPN-ita välja, et saaksid internetti kasutada ka ilma VPN-ita. Kui sa ei soovi enam, et Android VPN-i uuesti käivitaks, lülita välja ka „Alati sees VPN“.';

  @override
  String get protection_guideManual =>
      'Need seaded valid sa ise Androidis. FuzeVPN ei muuda neid sinu eest.';

  @override
  String get locations_changeTitle => 'Kas muuta asukohta?';

  @override
  String locations_changeActive(String name) {
    return 'VPN katkestab ühenduse ja proovib seejärel ühenduda asukohaga $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN proovib ühenduda asukohaga $name.';
  }

  @override
  String get locations_confirmChange => 'Muuda ja ühenda';

  @override
  String get locations_changeBusy =>
      'Muutmine on pooleli. Oota enne teise asukoha valimist.';

  @override
  String get locations_automaticSelection => 'Automaatne valik';

  @override
  String get locations_cities => 'Linnad';

  @override
  String get locations_servers => 'Serverid';

  @override
  String locations_viewCities(String name) {
    return 'Vaata linnu riigis $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Vaata servereid riigis $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count riiki',
      one: '$count riik',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linna',
      one: '$count linn',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serverit',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Kõik riigid';

  @override
  String get locations_backToCountries => 'Tagasi riikide juurde';

  @override
  String locations_backToCities(String name) {
    return 'Tagasi linnade juurde riigis $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Vali $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Vali $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Ühilduvat serverit pole saadaval.';

  @override
  String get externalLink_failed =>
      'Linki ei õnnestunud avada. Saad selle kopeerida ja avada brauseris.';

  @override
  String get externalLink_copy => 'Kopeeri link';

  @override
  String get externalLink_copied => 'Link kopeeritud';

  @override
  String get externalLink_copyFailed =>
      'Linki ei õnnestunud kopeerida. Vali allolev aadress.';

  @override
  String get settings_deleteAccount => 'Kustuta minu konto';

  @override
  String get settings_deleteAccountDetail =>
      'Vaata konto kustutamise taotlemise juhiseid';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Vali oma VPN-i tellimus.';

  @override
  String get billing_subscribe => 'Telli';

  @override
  String get billing_choosePlan => 'Jätkamiseks vali pakett.';

  @override
  String get billing_monthly => 'Igakuine';

  @override
  String get billing_yearly => 'Iga-aastane';

  @override
  String get billing_continue => 'Jätka Google Play kaudu';

  @override
  String get billing_restore => 'Taasta ostud';

  @override
  String get billing_manage => 'Halda tellimust';

  @override
  String get billing_deleteAccountWarning =>
      'Kui sul on Google Play tellimus, ei tühista FuzeVPN-i konto kustutamine selle automaatset uuendamist. Halda või tühista uuendamine eraldi Google Play kaudu.';

  @override
  String get billing_deleteAccountContinue =>
      'Jätka konto kustutamise taotluse juurde';

  @override
  String get billing_refresh => 'Värskenda juurdepääsu';

  @override
  String get billing_loadingPlans => 'Pakettide laadimine…';

  @override
  String get billing_unavailable =>
      'Praegu pole ühtegi paketti saadaval. Proovi hiljem uuesti.';

  @override
  String get billing_comingSoon => 'Tellimused on peagi saadaval.';

  @override
  String get billing_priceDisclosure =>
      'Hinna esitab Google Play. Lõplik summa ja kehtivad maksud kinnitatakse enne, kui sa ostu kinnitad.';

  @override
  String get billing_renewalMonthly =>
      'Uueneb automaatselt iga kuu, kui seda ei tühistata. Saad tellimuse igal ajal tühistada Google Play tellimuste jaotises.';

  @override
  String get billing_renewalYearly =>
      'Uueneb automaatselt igal aastal, kui seda ei tühistata. Saad tellimuse igal ajal tühistada Google Play tellimuste jaotises.';

  @override
  String get billing_active => 'Sinu Premium-juurdepääs on aktiivne';

  @override
  String billing_accessUntil(String date) {
    return 'Juurdepääs kuni $date.';
  }

  @override
  String get billing_webManaged =>
      'Sinu tellimust hallatakse FuzeVPN-i veebisaidil.';

  @override
  String get billing_playManaged =>
      'Sinu tellimust hallatakse Google Play kaudu.';

  @override
  String get billing_playOnHold =>
      'Sinu Google Play tellimus on peatatud või ootab makset. Ava „Halda tellimust“, et probleem Google Play kaudu lahendada.';

  @override
  String get billing_playReceiptUnlinked =>
      'Sellel Google Play kontol on juba Fuze Premium tellimus, mis ei ole selle FuzeVPN-i konto jaoks aktiivne. Ava „Halda tellimust“, et seda Google Play kaudu üle vaadata.';

  @override
  String get billing_inactive => 'Aktiivset tellimust pole.';

  @override
  String get billing_checkingAccess => 'Juurdepääsu kontrollimine…';

  @override
  String get billing_restoring => 'Ostude taastamine…';

  @override
  String get billing_pending =>
      'Makse on ootel. Sinu juurdepääs aktiveeritakse pärast kinnitamist.';

  @override
  String get billing_cancelled =>
      'Ost tühistati. Uut tellimust ei aktiveeritud.';

  @override
  String get billing_verifying => 'Ostu kontrollimine…';

  @override
  String get billing_success =>
      'Tellimus on aktiveeritud. Sinu Premium-juurdepääs on valmis.';

  @override
  String get billing_restored => 'Sinu ostud on taastatud.';

  @override
  String get billing_restoreEmpty =>
      'Selle Google Play konto jaoks pole taastamiseks ühtegi ostu.';

  @override
  String get billing_catalogError =>
      'Pakettide laadimine ebaõnnestus. Proovi uuesti.';

  @override
  String get billing_purchaseError =>
      'Ostu alustamine ebaõnnestus. Proovi uuesti.';

  @override
  String get billing_verificationError =>
      'Ostu kontrollimine pole ajutiselt saadaval. Uuesti proovimiseks taasta ostud.';

  @override
  String get billing_restoreError =>
      'Ostude taastamine ebaõnnestus. Proovi uuesti.';

  @override
  String get billing_managementError =>
      'Tellimuse haldamise avamine ebaõnnestus. Proovi uuesti.';

  @override
  String get billing_storeUnavailable =>
      'Google Play pole selles seadmes saadaval.';

  @override
  String get welcome_title => 'Sinu VPN, lihtsaks tehtud.';

  @override
  String get welcome_description =>
      'Kaitse oma ühendust. Hoia oma privaatsus enda kontrolli all.';

  @override
  String get welcome_start => 'Alusta';

  @override
  String get welcome_alreadyPurchased => 'Kas oled juba ostnud?';

  @override
  String get welcome_noAccountRequired => 'Alustamiseks pole kontot vaja.';

  @override
  String get guest_accountTitle => 'Konto pole seotud';

  @override
  String get guest_accountDescription =>
      'Taasta oma ostud sama Google Play kontoga, et kasutada tellimust teises seadmes.';

  @override
  String get guest_existingSubscriberSignIn => 'Juba tellija? Logi sisse';

  @override
  String get guest_claimTitle => 'Võta FuzeVPN endaga kaasa';

  @override
  String get guest_claimDescription =>
      'Loo konto, et kasutada oma tellimust ka teistes seadmetes. See samm on valikuline.';

  @override
  String get guest_skip => 'Hiljem';

  @override
  String get guest_activationTitle => 'Fuze Premium on aktiivne';

  @override
  String get guest_activationDescription =>
      'Sinu tellimus on valmis. Kasuta oma VPN-i ja loo konto siis, kui soovid.';

  @override
  String get guest_useVpn => 'Kasuta oma VPN-i';

  @override
  String get guest_loginRequired =>
      'See ost on juba seotud FuzeVPN-i kontoga. Tellimuse kasutamiseks logi sellele kontole sisse.';

  @override
  String get guest_signOutWarning =>
      'Tellimuse saad taastada, kui taastad ostud sama Google Play kontoga.';

  @override
  String get guest_profileUnavailable =>
      'Sinu konto on juba seotud. Logi sisse, et oma andmeid vaadata ja hallata.';

  @override
  String get billing_acceptance =>
      'Jätkates nõustud kasutustingimuste ja privaatsuspoliitikaga.';

  @override
  String get guest_verifyEmailReminder =>
      'Konto turvamiseks kinnita oma e-posti aadress. VPN-i saad jätkuvalt kasutada.';

  @override
  String get guest_serviceUnavailable =>
      'Teenus on ajutiselt kättesaamatu. Proovi mõne hetke pärast uuesti.';

  @override
  String get guest_restoreError =>
      'Sinu oste ei õnnestunud taastada. Proovi uuesti Google Play kontoga, millega ostu tegid.';

  @override
  String get guest_claimSuccess =>
      'Sinu konto on loodud. Sinu tellimus ja VPN-i juurdepääs on säilinud.';

  @override
  String get guest_emailExists =>
      'See e-posti aadress on juba kasutusel. Vali teine aadress või logi sisse oma olemasolevale kontole. Sinu ost jääb kättesaadavaks Google Play kaudu.';

  @override
  String get guest_claimError =>
      'Kontot ei õnnestunud luua. Saad VPN-i edasi kasutada ja hiljem uuesti proovida.';

  @override
  String get guest_secureStorageError =>
      'Seanssi ei õnnestunud selles seadmes turvata. Proovi uuesti.';

  @override
  String get guest_premiumRequired => 'Vali VPN-i aktiveerimiseks tellimus.';

  @override
  String get welcome_viewPlans => 'Vaata pakette';

  @override
  String get google_continue => 'Jätka Google’iga';

  @override
  String get google_or => 'või';

  @override
  String get google_title => 'Sinu FuzeVPN-i konto';

  @override
  String get google_settingUp => 'Lõpeta konto loomine';

  @override
  String get google_country => 'Elukohariik';

  @override
  String get google_profileDescription =>
      'Vali oma riik ja tutvu kahe dokumendiga, et luua FuzeVPN-i konto.';

  @override
  String get google_claimDescription =>
      'Seo oma külalisekonto Google’iga. Sinu tellimus ja seade jäävad selle kontoga seotuks.';

  @override
  String get google_linkTitle => 'Seo Google FuzeVPN-iga';

  @override
  String get google_linkDescription =>
      'Kinnita juurdepääs oma olemasolevale FuzeVPN-i kontole. See samm ei küsi sinu Google’i parooli.';

  @override
  String get google_password => 'FuzeVPN-i parool';

  @override
  String get google_linkAccount => 'Kinnita sidumine';

  @override
  String get google_requestEmail => 'Saada mulle kinnituskiri';

  @override
  String get google_emailInstructions =>
      'Ava FuzeVPN-i e-kiri ja sisesta kinnituskood.';

  @override
  String get google_emailCode => 'E-posti kinnituskood';

  @override
  String get google_confirmEmail => 'Kinnita kood';

  @override
  String get google_restart => 'Vali teine Google’i konto';

  @override
  String get google_resume => 'Kontrolli seda katset';

  @override
  String get google_unavailable =>
      'Google’iga sisselogimine pole saadaval. Saad kasutada e-posti aadressi ja parooli.';

  @override
  String get google_expired =>
      'See katse on aegunud. Tühista see ja alusta uuesti.';

  @override
  String get google_conflict =>
      'See Google’i konto on juba mujal seotud. Sinu praegune konto ja tellimus jäävad alles.';

  @override
  String get google_error =>
      'Google’iga sisselogimine ebaõnnestus. Proovi uuesti; sinu praegune juurdepääs jääb alles.';

  @override
  String get google_uncertain =>
      'Tulemust ei õnnestunud kinnitada. Enne uuesti alustamist kontrolli seda katset või tühista see.';

  @override
  String get google_cancelFailed =>
      'Tühistamist ei õnnestunud kinnitada. Enne sellelt ekraanilt lahkumist proovi tühistada uuesti.';

  @override
  String get google_cancelled => 'Google’iga sisselogimine tühistati.';

  @override
  String get google_selecting => 'Vali oma Google’i konto…';

  @override
  String get google_verifying => 'Konto kontrollimine…';

  @override
  String get google_emailUnavailable =>
      'Kinnituskirja ei õnnestunud saata. Proovi hiljem uuesti.';

  @override
  String get google_emailSent =>
      'Kinnituskiri on saadetud. Kontrolli oma postkasti.';

  @override
  String get google_rateLimited => 'Palun oota enne uuesti proovimist.';

  @override
  String get google_busy =>
      'Google pole saadaval, kui on pooleli mõni muu toiming (VPN-ühendus, konto või külalisekonto). Proovi uuesti pärast selle lõppemist; sinu praegune juurdepääs jääb alles.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN-i parool on vale. Sinu praegune konto jääb alles.';

  @override
  String get google_invalidCode => 'Kinnituskood on vale või aegunud.';

  @override
  String get google_accountChanged =>
      'Sinu seanss on muutunud. Tühista see katse enne uuesti alustamist.';

  @override
  String get google_invalidResponse =>
      'Vastuse kehtivust ei õnnestunud kontrollida. Sinu praegune juurdepääs jääb alles.';

  @override
  String get google_invalidRegistration =>
      'Kontrolli oma riiki ja mõlemat nõusolekut.';

  @override
  String get google_consentRequired =>
      'Jätkamiseks vali oma riik ja nõustu mõlema dokumendiga.';

  @override
  String get google_challengeRequired =>
      'Nõutav on täiendav turvakontroll. Sinu praegune juurdepääs jääb alles.';

  @override
  String get google_challengeUnavailable =>
      'Turvakontroll pole saadaval. Proovi hiljem uuesti.';

  @override
  String get google_intentMismatch =>
      'Eelmine Google’iga sisselogimise katse on endiselt ootel. Tühista see enne selle toimingu alustamist.';

  @override
  String get google_challengeBlocked =>
      'Nõutav turvakontroll pole selles rakenduses saadaval. Seda toimingut ei saa praegu lõpule viia.';

  @override
  String get google_solveChallenge => 'Tee turvakontroll läbi';

  @override
  String get google_challengeTitle => 'Turvakontroll';

  @override
  String get google_challengeReady =>
      'Kontroll on lõpule viidud. Nüüd saad konto loomise kinnitada.';

  @override
  String get google_challengeExpired =>
      'Kontroll on aegunud. Tee see enne kinnitamist uuesti.';

  @override
  String get google_challengeCancelled =>
      'Kontroll tühistati. Saad selle uuesti teha.';

  @override
  String get google_challengeFailed =>
      'Turvakontroll ebaõnnestus. Proovi uuesti.';

  @override
  String get billing_trialTitle => 'Proovi Fuze Premium tasuta';

  @override
  String get billing_trialSubtitle => 'Kaitse oma ühendust juba täna.';

  @override
  String get billing_trialWeeks => '2-nädalane tasuta prooviperiood';

  @override
  String billing_trialDays(String days) {
    return '$days-päevane tasuta prooviperiood';
  }

  @override
  String get billing_trialStart => 'Alusta tasuta prooviperioodi';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Kui alustad täna, on esimese makse eeldatav kuupäev $date.';
  }

  @override
  String get billing_trialTerms =>
      'Uueneb automaatselt märgitud hinnaga. Tasu vältimiseks tühista tellimus Google Play kaudu enne prooviperioodi lõppu.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Seejärel $price kuus';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Seejärel $price aastas';
  }

  @override
  String get billing_choosePeriod => 'Vali oma pakett';

  @override
  String get billing_selectionHint => 'Jätkamiseks vali pakett.';

  @override
  String get billing_benefitConnection => 'Krüpteeritud ühendus';

  @override
  String get billing_benefitPrivacy => 'Privaatsus internetis';

  @override
  String get billing_benefitNoAccount => 'Registreerimine pole nõutav';

  @override
  String get billing_cancellation => 'Tühista Google Play kaudu';

  @override
  String get billing_premiumTitle => 'Paremini kaitstud ühendus.';

  @override
  String get billing_premiumSubtitle => 'Kaitse oma ühendust omas tempos.';

  @override
  String get billing_priceMonthly => 'kuus';

  @override
  String get billing_priceYearly => 'aastas';

  @override
  String get billing_trialToday => 'Täna pole midagi maksta';

  @override
  String get billing_trialConfirmation =>
      'Google Play kinnitab kuupäevad, lõpliku summa ja kehtivad maksud enne, kui sa kinnitad.';

  @override
  String get billing_offerChanged =>
      'Selle pakkumise tingimused on muutunud. Värskenda pakette ja vali uuesti.';

  @override
  String get status_waitingNetwork => 'Võrgu ootamine';

  @override
  String get status_waitingNetworkDetail =>
      'Võrku pole saadaval. VPN kontrollib ühendust, kui võrk taastub.';

  @override
  String get locations_favoriteLoadFailed =>
      'Lemmikute laadimine ebaõnnestus. Proovi uuesti.';

  @override
  String get locations_favoritesLoading => 'Lemmikute laadimine…';
}
