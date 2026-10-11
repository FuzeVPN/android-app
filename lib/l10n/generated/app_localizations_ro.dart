// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Protejează-ți conexiunea';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN folosește serviciul VPN din Android (VpnService) pentru a crea un tunel criptat între acest dispozitiv și serverele FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Cât timp VPN-ul este activ, traficul de Internet al aplicațiilor tale, adresele de destinație și solicitările DNS trec prin acest tunel pentru a ruta conexiunea, chiar și atunci când FuzeVPN rulează în fundal.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplicația folosește starea conexiunii, durata acesteia și volumul de date transferate pentru a afișa conexiunea VPN. O poți opri oricând.';

  @override
  String get vpnDisclosure_privacy => 'Confidențialitate';

  @override
  String get vpnDisclosure_accept => 'Acceptă și continuă';

  @override
  String get vpnDisclosure_decline => 'Nu acum';

  @override
  String get accountRestoration_title => 'Cont indisponibil temporar';

  @override
  String get accountRestoration_message =>
      'Sesiunea a fost păstrată. Încearcă din nou pentru a-ți restaura contul; poți gestiona în continuare conexiunea VPN aici.';

  @override
  String get action_retry => 'Încearcă din nou';

  @override
  String get session_endingTitle => 'Încheierea sesiunii';

  @override
  String get session_ending =>
      'Sesiunea ta a fost invalidată. VPN-ul este oprit, iar sesiunea este ștearsă…';

  @override
  String get session_stopFailed =>
      'Oprirea VPN-ului nu este confirmată. Încearcă din nou înainte de a te autentifica.';

  @override
  String get session_cleanupFailed =>
      'VPN-ul este oprit, dar eliminarea sesiunii nu este confirmată. Încearcă din nou curățarea.';

  @override
  String get session_retryStop => 'Încearcă din nou oprirea';

  @override
  String get session_retryCleanup => 'Încearcă din nou curățarea';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Se pregătește FuzeVPN în siguranță…';

  @override
  String get nav_connection => 'Conexiune';

  @override
  String get nav_locations => 'Locații';

  @override
  String get nav_account => 'Cont';

  @override
  String get nav_devices => 'Dispozitive';

  @override
  String get nav_settings => 'Setări';

  @override
  String get action_refresh => 'Reîmprospătează';

  @override
  String get auth_tab_login => 'Autentificare';

  @override
  String get auth_tab_register => 'Înregistrare';

  @override
  String get auth_stepAccount => 'Cont';

  @override
  String get auth_stepIdentity => 'Identitate';

  @override
  String get auth_stepAddress => 'Adresă și acorduri';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Pasul $current din $total';
  }

  @override
  String get auth_tagline => 'VPN-ul tău, simplificat.';

  @override
  String get auth_keysLocal =>
      'Cheile tale VPN private rămân pe acest dispozitiv.';

  @override
  String get form_email => 'Adresă de e-mail';

  @override
  String get form_password => 'Parolă';

  @override
  String get form_showPassword => 'Afișează parola';

  @override
  String get form_hidePassword => 'Ascunde parola';

  @override
  String get form_passwordMin =>
      '8–72 de octeți UTF-8. Unele caractere folosesc mai mult de un octet.';

  @override
  String get form_firstName => 'Prenume';

  @override
  String get form_lastName => 'Nume';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adresă';

  @override
  String get form_address2 => 'A doua linie a adresei (opțional)';

  @override
  String get form_postalCode => 'Cod poștal';

  @override
  String get form_city => 'Oraș';

  @override
  String get form_country => 'Codul țării (de ex. FR)';

  @override
  String get action_login => 'Autentificare';

  @override
  String get action_createAccount => 'Creează un cont';

  @override
  String get action_createMyAccount => 'Creează-mi contul';

  @override
  String get action_next => 'Continuă';

  @override
  String get action_previous => 'Înapoi';

  @override
  String get action_forgotPassword => 'Ai uitat parola?';

  @override
  String get auth_noAccount => 'Nu ai încă un cont?';

  @override
  String get auth_requiredInformation => 'Creează-ți contul în trei pași.';

  @override
  String get auth_termsPrefix => 'Accept ';

  @override
  String get auth_termsLink => 'termenii de utilizare';

  @override
  String get auth_privacyPrefix => 'Accept ';

  @override
  String get auth_privacyLink => 'politica de confidențialitate';

  @override
  String get auth_consentRequired =>
      'Consimțământul tău este necesar pentru a crea un cont.';

  @override
  String get validation_required => 'Acest câmp este obligatoriu.';

  @override
  String get validation_email => 'Introdu o adresă de e-mail validă.';

  @override
  String get validation_password =>
      'Parola este prea scurtă: cel puțin 8 octeți UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Parola este prea lungă: cel mult 72 de octeți UTF-8.';

  @override
  String get validation_phone =>
      'Folosește formatul internațional, de exemplu +33612345678.';

  @override
  String get validation_country =>
      'Folosește un cod de țară din două litere, de exemplu FR.';

  @override
  String get passwordReset_title => 'Resetează parola';

  @override
  String get passwordReset_description =>
      'Introdu adresa de e-mail a contului pentru a solicita un link de resetare a parolei.';

  @override
  String get passwordReset_send => 'Trimite linkul';

  @override
  String get connection_title => 'Conexiunea ta';

  @override
  String get connection_subtitle => 'Alege o locație, apoi pornește VPN-ul.';

  @override
  String get connection_prepare => 'Ești gata să te conectezi?';

  @override
  String get connection_advancedOptions => 'Opțiuni avansate';

  @override
  String get connection_location => 'Locație';

  @override
  String get connection_chooseLocation => 'Alege o locație';

  @override
  String get connection_protocol => 'Protocol';

  @override
  String get connection_connect => 'Conectează-te';

  @override
  String get connection_connecting => 'Se conectează…';

  @override
  String get connection_disconnect => 'Deconectează-te';

  @override
  String get connection_disconnecting => 'Se deconectează';

  @override
  String get connection_locationChange => 'Se schimbă locația…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol indisponibil';
  }

  @override
  String get connection_activeLocation => 'Locație activă';

  @override
  String get connection_duration => 'Durată';

  @override
  String get connection_received => 'Primit';

  @override
  String get connection_sent => 'Trimis';

  @override
  String get connection_lastHandshake => 'Ultimul schimb securizat';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'acum $duration';
  }

  @override
  String get verification_title => 'Confirmă-ți adresa de e-mail';

  @override
  String get verification_message =>
      'Confirmă-ți adresa de e-mail pentru a folosi VPN-ul pe acest telefon.';

  @override
  String get verification_resend => 'Retrimite e-mailul';

  @override
  String get migration_title => 'Schimbarea locației';

  @override
  String get migration_draining => 'Se pregătește schimbarea locației…';

  @override
  String get migration_activating => 'Se activează noul server…';

  @override
  String get migration_ready => 'Locația a fost actualizată.';

  @override
  String get migration_blocked =>
      'Schimbarea locației necesită intervenția serverului. Încearcă din nou mai târziu sau contactează serviciul de asistență.';

  @override
  String get migration_progress => 'Progresul schimbării locației';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Întârziere între verificări: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Reia schimbarea locației';

  @override
  String get status_authorizing => 'Este necesară permisiunea';

  @override
  String get status_authorizingDetail =>
      'Acceptă solicitarea Android pentru a permite VPN-ul.';

  @override
  String get status_preparing => 'Se pregătește';

  @override
  String get status_preparingDetail =>
      'Se pregătește conexiunea ta securizată.';

  @override
  String get status_reconnecting => 'Se reconectează…';

  @override
  String get status_reconnectingDetail =>
      'Conexiunea a fost întreruptă. VPN-ul încearcă să se reconecteze.';

  @override
  String get status_connecting => 'Se conectează';

  @override
  String get status_connectingDetail => 'Se conectează la serverul VPN…';

  @override
  String get status_connected => 'Conectat';

  @override
  String get status_connectedDetail => 'Conexiunea ta VPN este activă.';

  @override
  String get status_disconnecting => 'Se deconectează';

  @override
  String get status_disconnectingDetail => 'Conexiunea ta VPN se oprește.';

  @override
  String get status_error => 'Conexiune indisponibilă';

  @override
  String get status_errorDetail =>
      'Conexiunea VPN nu este confirmată. Încearcă din nou.';

  @override
  String get status_idle => 'Deconectat';

  @override
  String get status_idleDetail =>
      'Conectează VPN-ul pentru a-ți proteja conexiunea.';

  @override
  String get trust_note =>
      'Închiderea aplicației nu oprește VPN-ul. Pentru a-l opri, folosește Deconectare.';

  @override
  String get locations_none => 'Momentan nu există locații disponibile.';

  @override
  String get locations_available => 'Alege următoarea locație.';

  @override
  String get locations_selected => 'Locație selectată';

  @override
  String get locations_select => 'Alege această locație';

  @override
  String get locations_lockedTunnel =>
      'Deconectează VPN-ul pentru a schimba locația.';

  @override
  String get locations_lockedMigration =>
      'Așteaptă finalizarea schimbării locației.';

  @override
  String get devices_title => 'Dispozitivele tale';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit dispozitive';
  }

  @override
  String get devices_refresh => 'Reîmprospătează dispozitivele';

  @override
  String get devices_empty => 'Încă nu este înregistrat niciun dispozitiv VPN.';

  @override
  String get devices_firstConnection =>
      'Telefonul tău va fi adăugat la prima conexiune.';

  @override
  String get devices_thisDevice => 'Acest dispozitiv';

  @override
  String devices_added(Object date) {
    return 'Adăugat la $date';
  }

  @override
  String get action_remove => 'Elimină';

  @override
  String get settings_title => 'Setări';

  @override
  String get settings_subtitle =>
      'Preferințele și contul tău, toate într-un singur loc.';

  @override
  String get settings_appearance => 'Aspect';

  @override
  String get settings_language => 'Limbă';

  @override
  String get settings_languageDescription =>
      'Limba aleasă de tine se aplică și notificărilor VPN.';

  @override
  String get settings_account => 'Cont';

  @override
  String get settings_signOut => 'Deconectare';

  @override
  String get settings_privacy => 'Politica de confidențialitate';

  @override
  String get settings_terms => 'Termenii de utilizare';

  @override
  String get settings_security => 'Securitate și transparență';

  @override
  String get settings_licenses => 'Licențele componentelor';

  @override
  String get settings_licensesDetail => 'Software folosit în aplicație';

  @override
  String get settings_background =>
      'VPN-ul rămâne pornit când părăsești aplicația. Pentru a-l opri, folosește Deconectare din fila Conexiune.';

  @override
  String get theme_system => 'Sistem';

  @override
  String get theme_light => 'Deschis';

  @override
  String get theme_dark => 'Închis';

  @override
  String get language_system => 'Limba telefonului';

  @override
  String get language_fr => 'Franceză';

  @override
  String get language_en => 'Engleză';

  @override
  String get language_es => 'Spaniolă';

  @override
  String get language_de => 'Germană';

  @override
  String get dialog_removeDevice => 'Elimini acest dispozitiv?';

  @override
  String get dialog_removeCurrent =>
      'Acest telefon se va deconecta de la VPN și va pierde accesul. Datele conexiunii VPN vor fi eliminate după confirmarea serverului.';

  @override
  String dialog_removeOther(Object name) {
    return 'Accesul VPN pentru „$name” va fi revocat. Această acțiune nu poate fi anulată.';
  }

  @override
  String get dialog_signOut => 'Te deconectezi?';

  @override
  String get dialog_signOutMessage =>
      'VPN-ul se va opri și va trebui să te autentifici din nou. Cheile tale VPN criptate vor rămâne pe acest telefon pentru următoarea conexiune.';

  @override
  String get action_cancel => 'Anulează';

  @override
  String get action_signOut => 'Deconectare';

  @override
  String get notice_close => 'Închide mesajul';

  @override
  String get notice_sessionExpired_title => 'Sesiune expirată';

  @override
  String get notice_sessionExpired_message =>
      'Sesiunea ta a expirat. Autentifică-te din nou.';

  @override
  String get notice_connectionFailed_title => 'Conexiunea a eșuat';

  @override
  String get notice_invalidCredentials_message =>
      'Adresa de e-mail sau parola este incorectă.';

  @override
  String get notice_emailVerification_title =>
      'Este necesară confirmarea e-mailului';

  @override
  String get notice_emailVerification_message =>
      'Confirmă-ți adresa de e-mail înainte de a adăuga un dispozitiv VPN.';

  @override
  String get notice_rateLimited_title => 'Prea multe încercări';

  @override
  String get notice_deviceLimit_title =>
      'Limita de 2 dispozitive a fost atinsă';

  @override
  String get notice_deviceLimit_message =>
      'Elimină un dispozitiv existent înainte de a adăuga altul.';

  @override
  String get notice_identityRenewal_title =>
      'Identitatea VPN trebuie reînnoită';

  @override
  String get notice_identityRenewal_message =>
      'Această identitate a fost eliminată. Creează o identitate locală nouă.';

  @override
  String get notice_migrationPending_title =>
      'Schimbarea locației este în curs';

  @override
  String get notice_migrationPending_message =>
      'O schimbare a locației este deja în curs.';

  @override
  String get notice_migrationBlocked_title =>
      'Schimbarea locației este blocată';

  @override
  String get notice_migrationBlocked_message =>
      'Schimbarea locației necesită intervenția serverului. Încearcă din nou mai târziu sau contactează serviciul de asistență.';

  @override
  String get notice_targetUnavailable_title => 'Server indisponibil temporar';

  @override
  String get notice_targetUnavailable_message =>
      'Acest server este indisponibil temporar.';

  @override
  String get notice_networkUnavailable_title =>
      'Conexiune la internet indisponibilă';

  @override
  String get notice_networkUnavailable_message =>
      'Verifică-ți conexiunea și încearcă din nou.';

  @override
  String get notice_permissionDenied_title => 'Permisiunea VPN a fost refuzată';

  @override
  String get notice_permissionDenied_message =>
      'Pornește din nou conexiunea și acceptă solicitarea de permisiune Android.';

  @override
  String get notice_wireguardTimeout_title => 'Serverul nu răspunde';

  @override
  String get notice_wireguardTimeout_message =>
      'Conexiunea WireGuard a durat prea mult. Încearcă din nou sau alege o altă locație.';

  @override
  String get notice_tlsFailed_title => 'Conexiunea securizată a fost refuzată';

  @override
  String get notice_tlsFailed_message =>
      'Serverul nu a acceptat conexiunea OpenVPN. Încearcă din nou. Dacă problema continuă, rulează un diagnostic.';

  @override
  String get notice_tunRejected_title => 'Android a respins interfața VPN';

  @override
  String get notice_tunRejected_message =>
      'Android a respins configurația de rețea solicitată de OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN nu a putut porni';

  @override
  String get notice_openvpnStart_message =>
      'Motorul OpenVPN nu a putut finaliza pornirea. Încearcă din nou. Dacă problema persistă, contactează serviciul de asistență.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Cod de diagnosticare: $code';
  }

  @override
  String get notice_generic_title => 'Conexiunea VPN a eșuat';

  @override
  String get notice_generic_message =>
      'A apărut o eroare. Încearcă din nou mai târziu.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Cont creat',
      'password_reset_sent': 'Solicitarea de resetare a parolei a fost primită',
      'verification_email_sent': 'E-mailul de verificare a fost trimis',
      'location_migration_pending': 'Schimbarea locației este în curs',
      'vpn_sign_in_required': 'Este necesară autentificarea',
      'protocol_unavailable_at_location': 'Protocol indisponibil',
      'vpn_permission_denied': 'Permisiunea VPN a fost refuzată',
      'revoked_identity_device_limit': 'Limita de 2 dispozitive a fost atinsă',
      'tunnel_start_unexpected': 'VPN-ul nu a putut porni',
      'flutter_disconnect_timeout': 'Deconectarea nu este confirmată',
      'flutter_disconnect_unexpected': 'Deconectarea nu a reușit',
      'device_revoked': 'Dispozitiv eliminat',
      'revoke_unexpected': 'Dispozitivul nu a putut fi eliminat',
      'identity_renewal_unexpected': 'Identitatea nu a putut fi reînnoită',
      'openvpn_renewal_unexpected': 'OpenVPN nu a putut fi reînnoit',
      'location_migration_blocked': 'Schimbarea locației este blocată',
      'location_migration_slow': 'Schimbarea locației este încă în curs',
      'location_migration_conflict':
          'Schimbarea locației necesită reîmprospătarea',
      'location_migration_verification_failed':
          'Schimbarea locației nu este confirmată',
      'location_migration_device_changed':
          'Dispozitivul s-a schimbat în timpul schimbării locației',
      'tunnel_stop_failed': 'Schimbarea locației nu este disponibilă',
      'other': 'Operațiunea a eșuat',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Contul a fost creat, dar e-mailul de verificare nu a putut fi trimis. Folosește retrimiterea din aplicație.',
      'password_reset_sent':
          'Solicitarea ta a fost primită. Dacă există un cont asociat acestei adrese, este posibil să primești un e-mail. Verifică și dosarul de spam.',
      'verification_email_sent':
          'Un e-mail nou de verificare tocmai a fost trimis.',
      'location_migration_pending':
          'Mutarea la $target este încă în pregătire. O poți relua fără să recreezi dispozitivul.',
      'vpn_sign_in_required':
          'Autentifică-te în cont înainte de a porni VPN-ul.',
      'protocol_unavailable_at_location':
          'Protocolul selectat nu este oferit de această locație. Reîmprospătează locațiile sau alege un alt protocol.',
      'vpn_permission_denied':
          'Android a refuzat permisiunea VPN. Pornește din nou conexiunea și acceptă solicitarea sistemului.',
      'revoked_identity_device_limit':
          'Accesul VPN al acestui dispozitiv a fost eliminat, iar limita de dispozitive a fost atinsă. Elimină un dispozitiv din Cont → Gestionează dispozitivele mele.',
      'tunnel_start_unexpected':
          'O eroare neașteptată a întrerupt pregătirea tunelului. Verifică codul de diagnosticare și încearcă din nou.',
      'flutter_disconnect_timeout':
          'Android nu a confirmat la timp că VPN-ul s-a oprit. Încearcă să îl oprești din nou.',
      'flutter_disconnect_unexpected':
          'O eroare neașteptată a împiedicat confirmarea opririi tunelului.',
      'device_revoked':
          'Accesul VPN al dispozitivului a fost revocat, iar secretele sale locale au fost eliminate.',
      'revoke_unexpected':
          'Dispozitivul nu a putut fi eliminat. Reîmprospătează lista și încearcă din nou.',
      'identity_renewal_unexpected':
          'Noua identitate VPN nu a putut fi creată. Reîmprospătează dispozitivele și încearcă din nou.',
      'openvpn_renewal_unexpected':
          'Profilul OpenVPN nu a putut fi reînnoit. Încearcă din nou sau verifică codul de diagnosticare.',
      'location_migration_blocked':
          'Serverul nu poate finaliza această schimbare acum. Dispozitivul și identitatea sa locală au fost păstrate.',
      'location_migration_slow':
          'Serverul încă pregătește mutarea la $target. Folosește Reluare peste câteva momente.',
      'location_migration_conflict':
          'Starea dispozitivului s-a schimbat pe server. Reîmprospătează dispozitivele, apoi reia schimbarea.',
      'location_migration_verification_failed':
          'Serverul nu a confirmat noua locație. Identitatea locală anterioară a fost păstrată.',
      'location_migration_device_changed':
          'Dispozitivul returnat de server nu mai corespunde celui modificat. Reîmprospătează dispozitivele înainte de a încerca din nou.',
      'tunnel_stop_failed':
          'Tunelul anterior trebuie oprit complet înainte de noua conexiune.',
      'other':
          'Operațiunea nu a putut fi finalizată. Încearcă din nou sau trimite codul de diagnosticare serviciului de asistență.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesiune expirată',
      'invalid_credentials': 'Autentificarea a eșuat',
      'email_verification_required': 'Este necesară confirmarea e-mailului',
      'verification_email_cooldown': 'E-mailul a fost deja trimis',
      'rate_limited': 'Prea multe încercări',
      'invalid_registration': 'Informațiile trebuie corectate',
      'email_exists': 'Contul există deja',
      'invalid_profile': 'Profil nevalid',
      'invalid_device': 'Dispozitiv nevalid',
      'invalid_location': 'Locație indisponibilă',
      'device_limit': 'Limita de dispozitive a fost atinsă',
      'device_exists': 'Identitatea VPN este deja utilizată',
      'device_identity_revoked': 'Identitatea VPN trebuie reînnoită',
      'device_location_locked': 'Schimbarea locației necesită reîmprospătarea',
      'location_migration_pending': 'Schimbarea locației este în curs',
      'location_migration_blocked': 'Schimbarea locației este blocată',
      'target_ca_mismatch': 'Server OpenVPN incompatibil',
      'location_migration_conflict':
          'Schimbarea locației necesită reîmprospătarea',
      'server_full': 'Serverul este plin',
      'capacity_unavailable': 'Locație indisponibilă temporar',
      'target_unavailable': 'Server indisponibil temporar',
      'not_found': 'Element negăsit',
      'invalid_openvpn_csr': 'Identitate OpenVPN nevalidă',
      'openvpn_profile_exists': 'Profilul OpenVPN există deja',
      'openvpn_profile_revoked': 'Profilul OpenVPN a fost revocat',
      'openvpn_operation_pending': 'Operațiunea OpenVPN este în curs',
      'openvpn_operation_terminal': 'Operațiunea OpenVPN a fost întreruptă',
      'openvpn_address_unavailable': 'Adresă OpenVPN indisponibilă',
      'openvpn_profile_conflict': 'Conflict OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN indisponibil',
      'email_delivery_unavailable': 'E-mail indisponibil',
      'invalid_token': 'Link nevalid',
      'network_unavailable': 'Conexiune la internet indisponibilă',
      'invalid_json': 'Solicitare nevalidă',
      'invalid_api_response': 'Răspuns nevalid al serverului',
      'ipv6_unavailable': 'IPv6 indisponibil',
      'invalid_ip_families': 'Configurarea rețelei a fost respinsă',
      'other': 'Serviciu indisponibil',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesiunea ta a expirat. Autentifică-te din nou.',
      'invalid_credentials': 'Adresa de e-mail sau parola este incorectă.',
      'email_verification_required':
          'Confirmă-ți adresa de e-mail înainte de a adăuga un dispozitiv VPN.',
      'invalid_registration':
          'Verifică informațiile și consimțămintele solicitate.',
      'email_exists': 'Un cont folosește deja această adresă de e-mail.',
      'invalid_profile': 'Verifică informațiile profilului tău.',
      'invalid_device':
          'Numele sau identitatea locală a acestui dispozitiv este nevalidă.',
      'invalid_location':
          'Reîmprospătează lista locațiilor și încearcă din nou.',
      'device_limit':
          'Elimină un dispozitiv existent înainte de a adăuga altul.',
      'device_exists': 'Această identitate VPN este deja asociată altui cont.',
      'device_identity_revoked':
          'Această identitate a fost eliminată. Trebuie creată o identitate locală nouă.',
      'device_location_locked':
          'Locația acestui dispozitiv tocmai s-a schimbat. Aplicația va relua schimbarea în curs.',
      'location_migration_pending': 'O schimbare a locației este deja în curs.',
      'location_migration_blocked':
          'Schimbarea locației necesită intervenția serverului. Încearcă din nou mai târziu sau contactează serviciul de asistență.',
      'target_ca_mismatch':
          'Acest server nu este încă compatibil cu profilul OpenVPN actual.',
      'location_migration_conflict':
          'Reîmprospătează dispozitivele, apoi încearcă din nou schimbarea locației.',
      'server_full':
          'Această locație și-a atins limita de conexiuni. Alege o altă locație sau încearcă din nou mai târziu.',
      'capacity_unavailable':
          'Nu putem confirma dacă această locație este disponibilă acum. Alege o altă locație sau încearcă din nou mai târziu.',
      'target_unavailable': 'Acest server este indisponibil temporar.',
      'not_found': 'Acest element nu mai este disponibil în contul tău.',
      'invalid_openvpn_csr':
          'Creează o identitate OpenVPN nouă și încearcă din nou.',
      'openvpn_profile_exists':
          'Există deja un profil OpenVPN pentru acest dispozitiv.',
      'openvpn_profile_revoked':
          'Reînnoiește profilul OpenVPN pentru a continua.',
      'openvpn_operation_pending':
          'Schimbarea este încă în curs de propagare. Încearcă din nou mai târziu.',
      'openvpn_operation_terminal':
          'Creează o identitate OpenVPN nouă și încearcă din nou.',
      'openvpn_address_unavailable':
          'Momentan nu este disponibilă nicio adresă OpenVPN.',
      'openvpn_profile_conflict':
          'Profilul s-a schimbat. Reîmprospătează dispozitivele și încearcă din nou.',
      'openvpn_signer_unavailable':
          'Serviciul OpenVPN este indisponibil temporar.',
      'email_delivery_unavailable':
          'E-mailul nu a putut fi trimis. Încearcă din nou mai târziu.',
      'invalid_token':
          'Acest link este nevalid sau a expirat. Solicită unul nou.',
      'network_unavailable':
          'Verifică-ți conexiunea la internet și încearcă din nou.',
      'invalid_json': 'Verifică informațiile introduse și încearcă din nou.',
      'invalid_api_response':
          'Serverul a returnat un răspuns neașteptat. Încearcă din nou mai târziu.',
      'ipv6_unavailable':
          'Serverul nu poate activa IPv6 momentan. Încearcă din nou mai târziu.',
      'invalid_ip_families':
          'Configurația tunelului este incompletă sau nu corespunde adreselor autorizate. Încearcă din nou din aplicație.',
      'other': 'A apărut o eroare a serverului. Încearcă din nou mai târziu.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Încearcă din nou peste câteva momente.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Încearcă din nou peste $seconds secunde.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Reluarea VPN-ului de sistem nu este disponibilă',
      'system_vpn_resume_corrupt': 'Reluare nevalidă a VPN-ului de sistem',
      'system_vpn_resume_session_invalid':
          'Sesiune nevalidă pentru reluarea VPN-ului',
      'system_vpn_resume_identity_changed': 'Identitatea VPN s-a schimbat',
      'system_vpn_resume_identity_invalid':
          'Identitate nevalidă pentru reluarea VPN-ului',
      'system_vpn_resume_storage_failed':
          'Stocarea pentru reluarea VPN-ului nu este disponibilă',
      'system_vpn_resume_network_timeout':
          'Reluarea VPN-ului nu are acces la rețea',
      'system_vpn_resume_blocked': 'Reluarea VPN-ului este blocată',
      'system_vpn_resume_failed': 'Reluarea VPN-ului a eșuat',
      'system_vpn_resume_error_invalid': 'Eroare nevalidă la reluarea VPN-ului',
      'wireguard_identity_store_failed':
          'Identitatea WireGuard nu a fost salvată',
      'wireguard_identity_unavailable':
          'Identitatea WireGuard nu este disponibilă',
      'vpn_host_destroyed': 'Gazda VPN Android s-a oprit',
      'vpn_host_unavailable': 'Gazda VPN Android nu este disponibilă',
      'vpn_permission_required': 'Este necesară permisiunea VPN',
      'vpn_permission_denied': 'Permisiunea VPN a fost refuzată',
      'vpn_permission_request_failed': 'Permisiunea nu a putut fi solicitată',
      'wireguard_foreground_service_unavailable':
          'Serviciul WireGuard nu este disponibil',
      'wireguard_identity_invalid': 'Cheie locală WireGuard nevalidă',
      'wireguard_identity_in_use': 'Identitatea WireGuard este deja utilizată',
      'wireguard_configuration_invalid': 'Configurație WireGuard nevalidă',
      'wireguard_operation_pending': 'Operațiunea WireGuard este încă activă',
      'wireguard_start_failed': 'Pornirea WireGuard a fost respinsă',
      'wireguard_stop_timeout': 'Oprirea WireGuard nu este confirmată',
      'wireguard_handshake_timeout': 'WireGuard nu a răspuns',
      'openvpn_connection_timeout': 'OpenVPN nu a răspuns',
      'openvpn_core_unavailable': 'Motorul OpenVPN nu este disponibil',
      'openvpn_operation_pending': 'Sesiunea OpenVPN este încă activă',
      'openvpn_stop_timeout': 'Oprirea OpenVPN nu este confirmată',
      'openvpn_profile_unavailable': 'Profilul local OpenVPN lipsește',
      'openvpn_native_failed': 'Apelul OpenVPN nativ a fost întrerupt',
      'openvpn_key_generation_failed':
          'Cheia OpenVPN P-256 nu a putut fi creată',
      'openvpn_csr_generation_failed': 'CSR-ul OpenVPN nu a putut fi creat',
      'openvpn_identity_store_failed': 'Identitatea OpenVPN nu a fost salvată',
      'openvpn_identity_clear_failed': 'Eliminarea OpenVPN a fost incompletă',
      'openvpn_identity_in_use': 'Identitatea OpenVPN este încă utilizată',
      'openvpn_tls_verification_required': 'Verificarea TLS OpenVPN lipsește',
      'openvpn_cipher_invalid': 'Cifrul OpenVPN este nevalid',
      'openvpn_profile_rejected': 'Profilul OpenVPN a fost respins',
      'openvpn_identity_inconsistent': 'Identitatea OpenVPN este inconsistentă',
      'tls_handshake_failed': 'Negocierea OpenVPN a fost respinsă',
      'tls_alert_unknown_ca':
          'Certificatul clientului OpenVPN nu este recunoscut',
      'tls_alert_bad_certificate':
          'Certificatul clientului OpenVPN a fost respins',
      'tls_alert_unsupported_certificate': 'Certificat OpenVPN incompatibil',
      'tls_client_certificate_required':
          'Este necesar certificatul clientului OpenVPN',
      'tls_alert_misc': 'Alertă TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Semnătură OpenVPN incompatibilă',
      'tls_handshake_rejected': 'Negocierea TLS OpenVPN a fost respinsă',
      'tls_version_rejected': 'Versiune TLS OpenVPN incompatibilă',
      'tls_certificate_expired': 'Certificatul TLS a expirat',
      'tls_certificate_revoked': 'Certificatul TLS a fost revocat',
      'transport_failed': 'Serverul OpenVPN nu poate fi accesat',
      'tun_configuration_rejected': 'Interfața OpenVPN nu a putut fi creată',
      'tun_setup_failed': 'Configurarea TUN OpenVPN a eșuat',
      'tun_interface_create_failed': 'Crearea interfeței OpenVPN a eșuat',
      'tun_interface_disabled': 'Interfața OpenVPN este dezactivată',
      'tun_halted': 'Interfața OpenVPN a fost întreruptă',
      'tun_already_established': 'Interfața OpenVPN este deja deschisă',
      'tun_addresses_missing': 'Adresa OpenVPN lipsește',
      'tun_routes_missing': 'Rutele OpenVPN lipsesc',
      'tun_dns_missing': 'DNS-ul OpenVPN lipsește',
      'tun_permission_revoked': 'Permisiunea VPN a fost revocată',
      'tun_establish_returned_null': 'Android a respins interfața VPN',
      'openvpn_service_start_failed': 'Serviciul OpenVPN nu este disponibil',
      'openvpn_operation_timeout': 'Apelul OpenVPN a expirat',
      'openvpn_start_failed': 'Pornirea OpenVPN a fost respinsă',
      'openvpn_connection_failed': 'Conexiunea OpenVPN a fost întreruptă',
      'openvpn_core_status_error': 'OpenVPN Core s-a încheiat cu o eroare',
      'openvpn_stopped_before_connected':
          'OpenVPN s-a oprit înainte de conectare',
      'openvpn_auth_failed': 'Autentificarea OpenVPN a fost respinsă',
      'openvpn_client_setup_failed': 'Configurarea clientului OpenVPN a eșuat',
      'openvpn_client_halted': 'Clientul OpenVPN a fost întrerupt',
      'openvpn_client_restart': 'A fost solicitată repornirea OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN a fost inactiv prea mult timp',
      'openvpn_session_expired': 'Sesiunea OpenVPN a expirat',
      'openvpn_credentials_required': 'Autentificare OpenVPN incompatibilă',
      'openvpn_proxy_failed': 'Transportul intermediar OpenVPN a eșuat',
      'openvpn_compression_failed': 'Compresia OpenVPN a fost respinsă',
      'openvpn_ntlm_crypto_unavailable':
          'Criptarea NTLM OpenVPN nu este disponibilă',
      'openvpn_feature_unsupported': 'Funcție OpenVPN incompatibilă',
      'network_unavailable': 'Conexiunea la internet nu este disponibilă',
      'network_lost': 'Rețeaua nu este disponibilă',
      'certificate_validation_failed': 'Certificatul serverului a fost respins',
      'openvpn_certificate_expired': 'Certificatul OpenVPN a expirat',
      'tunnel_active_for_another_account': 'Tunelul altui cont este încă activ',
      'tunnel_already_active': 'Tunelul nativ este deja activ',
      'tunnel_stop_timeout': 'Oprirea $protocol nu este confirmată',
      'tunnel_disconnected': '$protocol a fost întrerupt',
      'native_bridge_unavailable': 'Puntea Android nu este disponibilă',
      'native_operation_failed': 'Operațiunea Android a fost întreruptă',
      'invalid_arguments': 'Parametrii VPN sunt incompleți',
      'invalid_account_id': 'Cont VPN nevalid',
      'invalid_device_id': 'Identificator de dispozitiv nevalid',
      'storage_key_not_allowed': 'Cheia de stocare a fost respinsă',
      'secure_storage_read_failed': 'Citirea securizată a eșuat',
      'secure_storage_write_failed': 'Scrierea securizată a eșuat',
      'key_generation_failed': 'Cheia WireGuard nu a putut fi generată',
      'csr_generation_failed': 'CSR-ul OpenVPN nu a putut fi generat',
      'other': 'Eroare VPN nativă neclasificată',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android nu găsește o sesiune VPN care poate fi reluată. Pornește o conexiune nouă din aplicație.',
      'system_vpn_resume_corrupt':
          'Datele salvate pentru reluarea VPN-ului sunt nevalide și nu vor fi folosite. Pornește o conexiune nouă.',
      'system_vpn_resume_session_invalid':
          'Sesiunea salvată nu mai poate relua VPN-ul. Autentifică-te din nou în aplicație.',
      'system_vpn_resume_identity_changed':
          'Identitatea locală VPN s-a schimbat. Reluarea a fost oprită; pornește o conexiune nouă.',
      'system_vpn_resume_identity_invalid':
          'Identitatea pentru reluare este nevalidă. Pornește o conexiune nouă.',
      'system_vpn_resume_storage_failed':
          'Android nu a putut citi sau actualiza datele criptate pentru reluare. Pornește o conexiune nouă.',
      'system_vpn_resume_network_timeout':
          'Android nu a găsit la timp o rețea pentru a relua VPN-ul. Încearcă din nou când este disponibilă o rețea.',
      'system_vpn_resume_blocked':
          'Reluarea VPN-ului este blocată. Verifică setările Android, apoi pornește o conexiune nouă.',
      'system_vpn_resume_failed':
          'Reluarea VPN-ului Android a eșuat. Pornește o conexiune nouă din aplicație.',
      'system_vpn_resume_error_invalid':
          'Android a returnat o eroare de reluare inutilizabilă. Pornește o conexiune nouă.',
      'wireguard_identity_store_failed':
          'Android nu a putut salva identitatea WireGuard criptată a acestui cont.',
      'wireguard_identity_unavailable':
          'Nu este disponibilă nicio identitate WireGuard utilizabilă pentru această conexiune.',
      'vpn_host_destroyed':
          'Componenta Android care găzduia VPN-ul a fost oprită. Pornește o conexiune nouă.',
      'vpn_host_unavailable':
          'Android nu poate crea componenta care găzduiește VPN-ul. Încearcă din nou după ce verifici setările VPN.',
      'openvpn_renewal_required':
          'Certificatul necesită o acțiune în aplicație înainte de conectare.',
      'openvpn_recovery_failed':
          'Recuperarea automată a eșuat. Pornește o conexiune nouă din aplicație.',
      'openvpn_recovery_exhausted':
          'Recuperarea automată a fost deja folosită. Pornește o conexiune nouă din aplicație.',
      'vpn_permission_required':
          'Android necesită o nouă autorizare VPN înainte de pornirea tunelului.',
      'vpn_permission_denied':
          'Permite accesul FuzeVPN în solicitarea Android pentru a continua.',
      'vpn_permission_request_failed':
          'Android nu a putut deschide ecranul permisiunii VPN.',
      'wireguard_foreground_service_unavailable':
          'Android nu a putut menține serviciul WireGuard în prim-plan.',
      'wireguard_identity_invalid':
          'Cheia WireGuard criptată a acestui cont nu poate fi citită sau este nevalidă.',
      'wireguard_identity_in_use':
          'O altă operațiune folosește încă cheia WireGuard a acestui cont.',
      'wireguard_configuration_invalid':
          'Adresa WireGuard, DNS-ul, cheia serverului sau rutele primite sunt nevalide.',
      'wireguard_operation_pending':
          'Operațiunea WireGuard anterioară nu și-a eliberat încă serviciul nativ.',
      'wireguard_start_failed':
          'Motorul WireGuard a respins activarea configurației.',
      'wireguard_stop_timeout':
          'Serviciul WireGuard nu a confirmat eliberarea interfeței VPN în limita de timp.',
      'wireguard_handshake_timeout':
          'Tunelul nu a confirmat la timp schimbul de mesaje cu serverul.',
      'openvpn_connection_timeout':
          'OpenVPN nu a confirmat la timp conexiunea la server.',
      'openvpn_core_unavailable':
          'Această versiune a aplicației nu conține un motor OpenVPN utilizabil.',
      'openvpn_operation_pending':
          'Motorul nativ păstrează încă sesiunea OpenVPN anterioară și refuză să creeze una a doua.',
      'openvpn_stop_timeout':
          'OpenVPN Core nu a confirmat că sesiunea sa nativă s-a oprit și a fost eliminată în limita de timp.',
      'openvpn_profile_unavailable':
          'Nu poate fi citit niciun profil OpenVPN validat pentru această conexiune.',
      'openvpn_native_failed':
          'O eroare a aplicației a întrerupt OpenVPN. Încearcă să te conectezi din nou. Dacă problema continuă, rulează o diagnosticare.',
      'openvpn_key_generation_failed':
          'Android Keystore nu a putut crea sau citi cheia privată P-256 care nu poate fi exportată.',
      'openvpn_csr_generation_failed':
          'Cheia Android Keystore nu a putut semna cererea de certificat OpenVPN.',
      'openvpn_identity_store_failed':
          'Certificatul sau profilul OpenVPN nu a putut fi salvat în stocarea criptată.',
      'openvpn_identity_clear_failed':
          'Android nu a putut elimina întreaga identitate locală OpenVPN a acestui cont.',
      'openvpn_identity_in_use':
          'O sesiune OpenVPN nativă folosește încă cheia sau certificatul acestui dispozitiv.',
      'openvpn_tls_verification_required':
          'Profilul nu solicită explicit verificarea certificatului serverului.',
      'openvpn_cipher_invalid':
          'Serverul a furnizat un algoritm de criptare care nu se află în lista permisă.',
      'openvpn_profile_rejected':
          'Profilul primit de la server este incompatibil. Recreează acest dispozitiv și încearcă din nou.',
      'openvpn_identity_inconsistent':
          'Certificatul nu corespunde identității securizate a acestui telefon. Niciun profil local nu a fost înlocuit.',
      'tls_handshake_failed':
          'Serverul a respins negocierea TLS. Recreează profilul dacă problema persistă.',
      'tls_alert_unknown_ca':
          'Serverul nu recunoaște autoritatea certificatului acestui dispozitiv. Serverul OpenVPN trebuie verificat.',
      'tls_alert_bad_certificate':
          'Serverul a respins certificatul acestui dispozitiv. Recreează dispozitivul înainte de a încerca din nou.',
      'tls_alert_unsupported_certificate':
          'Serverul nu acceptă tipul de certificat securizat folosit de Android.',
      'tls_client_certificate_required':
          'Serverul necesită un certificat de client, dar OpenVPN Core nu a putut prezenta unul.',
      'tls_alert_misc':
          'Serverul a returnat o alertă TLS din afara categoriilor certificat și versiune.',
      'tls_signature_algorithm_rejected':
          'Serverul a respins algoritmul ECDSA P-256 al cheii Android Keystore.',
      'tls_handshake_rejected':
          'Serverul a întrerupt negocierea TLS înainte de conectare.',
      'tls_version_rejected':
          'Clientul și serverul nu au găsit o versiune TLS comună.',
      'tls_certificate_expired':
          'Certificatul prezentat în timpul conectării a expirat.',
      'tls_certificate_revoked':
          'Certificatul prezentat în timpul conectării a fost revocat.',
      'transport_failed':
          'Serverul OpenVPN nu răspunde în rețeaua actuală. Încearcă din nou în scurt timp.',
      'tun_configuration_rejected':
          'Android a respins configurația de rețea solicitată de OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core a respins planul de rețea înainte de a crea interfața Android.',
      'tun_interface_create_failed':
          'OpenVPN Core nu a putut obține interfața TUN de la Android VpnService.',
      'tun_interface_disabled':
          'Android sau OpenVPN Core a dezactivat interfața TUN în timpul conexiunii.',
      'tun_halted':
          'OpenVPN Core a primit o solicitare de oprire a interfeței TUN.',
      'tun_already_established':
          'OpenVPN a solicitat o a doua interfață în aceeași conexiune. Tunelul a fost oprit pentru siguranță.',
      'tun_addresses_missing':
          'Serverul nu a furnizat o adresă utilizabilă pentru tunel.',
      'tun_routes_missing':
          'Serverul nu a furnizat rute utilizabile pentru tunel.',
      'tun_dns_missing': 'Serverul nu a furnizat un server DNS utilizabil.',
      'tun_permission_revoked':
          'Android a revocat permisiunea VPN în timpul conexiunii.',
      'tun_establish_returned_null':
          'Android nu a creat interfața, de obicei deoarece un alt VPN este încă activ.',
      'openvpn_service_start_failed':
          'Android nu a putut porni serviciul OpenVPN din prim-plan.',
      'openvpn_operation_timeout':
          'Un apel JNI către OpenVPN Core a depășit durata maximă.',
      'openvpn_start_failed':
          'Serviciul Android este pregătit, dar OpenVPN Core nu a acceptat pornirea profilului.',
      'openvpn_connection_failed':
          'OpenVPN Core s-a oprit înainte de a emite evenimentul CONNECTED.',
      'openvpn_core_status_error':
          'Bucla OpenVPN nativă s-a încheiat cu o eroare și fără un eveniment terminal mai specific.',
      'openvpn_stopped_before_connected':
          'Bucla OpenVPN nativă s-a oprit înainte de CONNECTED, fără o eroare Core explicită.',
      'openvpn_auth_failed':
          'Serverul OpenVPN a respins autentificarea profilului.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nu a putut inițializa clientul înainte de conectarea la rețea.',
      'openvpn_client_halted':
          'OpenVPN Core a primit o comandă terminală de oprire a clientului.',
      'openvpn_client_restart':
          'OpenVPN Core a solicitat repornirea sesiunii de transport.',
      'openvpn_inactive_timeout':
          'OpenVPN Core a închis sesiunea după expirarea intervalului de inactivitate.',
      'openvpn_session_expired':
          'Serverul a raportat că sesiunea OpenVPN a expirat.',
      'openvpn_credentials_required':
          'Serverul sau un proxy solicită date de autentificare interactive care nu fac parte din acest profil de certificat.',
      'openvpn_proxy_failed':
          'OpenVPN Core a raportat o eroare a proxy-ului sau releului configurat.',
      'openvpn_compression_failed':
          'OpenVPN Core a respins modul de comprimare anunțat de profil sau server.',
      'openvpn_ntlm_crypto_unavailable':
          'Profilul solicită criptare NTLM, indisponibilă în această versiune.',
      'openvpn_feature_unsupported':
          'Profilul sau serverul necesită o funcție care lipsește din acest client Android.',
      'network_unavailable':
          'Nu este disponibilă nicio rețea fizică utilizabilă.',
      'network_lost': 'Tunelul a fost oprit după pierderea rețelei.',
      'certificate_validation_failed':
          'Identitatea serverului OpenVPN nu a putut fi verificată.',
      'openvpn_certificate_expired':
          'Reînnoiește profilul OpenVPN înainte de reconectare.',
      'tunnel_active_for_another_account':
          'Un tunel care aparține altui cont trebuie oprit înainte de această conexiune.',
      'tunnel_already_active':
          'Android raportează că o sesiune VPN anterioară folosește încă interfața.',
      'tunnel_stop_timeout':
          'Motorul $protocol nu a confirmat eliberarea interfeței VPN în limita de timp.',
      'tunnel_disconnected':
          'Motorul nativ a raportat că tunelul s-a încheiat neașteptat după pornire.',
      'native_bridge_unavailable':
          'Aplicația nu poate accesa serviciul VPN Android. Închide și redeschide aplicația, apoi încearcă din nou.',
      'native_operation_failed':
          'O eroare a aplicației a întrerupt operațiunea VPN. Încearcă din nou. Dacă problema continuă, rulează o diagnosticare.',
      'invalid_arguments':
          'Informațiile necesare pentru această operațiune VPN sunt incomplete. Încearcă din nou. Dacă problema continuă, rulează o diagnosticare.',
      'invalid_account_id':
          'Operațiunea nativă nu este asociată unui identificator de cont valid.',
      'invalid_device_id':
          'Identificatorul dispozitivului trimis motorului nativ lipsește sau este nevalid.',
      'storage_key_not_allowed':
          'Puntea Android a blocat o cheie din afara listei de stocare permise.',
      'secure_storage_read_failed':
          'Android Keystore nu a putut decripta datele locale ale acestui cont.',
      'secure_storage_write_failed':
          'Android Keystore nu a putut cripta sau salva datele locale.',
      'key_generation_failed':
          'Android nu a putut crea sau citi cheia WireGuard din stocarea securizată.',
      'csr_generation_failed':
          'Android Keystore nu a putut crea sau semna CSR-ul OpenVPN P-256.',
      'other':
          'O ramură nativă nedocumentată a eșuat. Trimite codul de diagnosticare afișat mai jos serviciului de asistență.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Solicitarea de permisiune este deja deschisă';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Solicitarea de permisiune VPN Android este deja afișată. Finalizeaz-o înainte de a încerca din nou.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Solicitarea permisiunii VPN a fost întreruptă';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Ecranul permisiunii VPN s-a închis înainte ca aplicația să primească un răspuns.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Conexiunea OpenVPN nu este confirmată';

  @override
  String get notice_openvpnProofMissing_message =>
      'Conexiunea OpenVPN nu a putut fi confirmată. A fost oprită pentru siguranță. Încearcă din nou.';

  @override
  String get openvpnCleanup_title => 'Profilul OpenVPN a fost revocat';

  @override
  String get openvpnCleanup_working =>
      'Se oprește și se elimină profilul OpenVPN revocat…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Oprirea OpenVPN nu a fost confirmată. Încearcă din nou înainte de a crea un profil nou.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Profilul OpenVPN revocat nu a putut fi eliminat complet. Încearcă din nou curățarea.';

  @override
  String get openvpnCleanup_complete =>
      'Profilul OpenVPN revocat a fost eliminat. Apasă Conectare pentru a crea unul nou.';

  @override
  String get network_title => 'Configurarea rețelei';

  @override
  String get network_ipv4Fallback =>
      'IPv6 este indisponibil temporar. Pregătirea continuă cu IPv4.';

  @override
  String get network_rejectedTitle => 'Configurarea rețelei a fost respinsă';

  @override
  String get network_rejectedMessage =>
      'Configurarea tunelului este incompletă sau nu corespunde adreselor autorizate. Încearcă din nou din aplicație.';

  @override
  String get network_unreadableTitle =>
      'Configurația locală nu poate fi citită';

  @override
  String get network_unreadableMessage =>
      'Configurația de rețea OpenVPN salvată nu poate fi folosită. Reconectează-te din aplicație pentru a o actualiza.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Protecția rețelei';

  @override
  String get protection_subtitle =>
      'Blochează accesul direct la internet dacă VPN-ul se deconectează.';

  @override
  String get protection_active => 'Protecția sistemului este activă';

  @override
  String get protection_alwaysOnOnly =>
      'VPN-ul permanent este activat; activează blocarea în afara VPN-ului';

  @override
  String get protection_inactive => 'Protecția sistemului este inactivă';

  @override
  String get protection_unknown => 'Verifică protecția sistemului';

  @override
  String get protection_openSettings => 'Deschide setările Android';

  @override
  String get protection_dialogTitle => 'Configurează protecția rețelei';

  @override
  String get protection_dialogMessage =>
      'Android gestionează VPN-ul permanent și blocarea conexiunilor din afara VPN-ului. Verifică dacă FuzeVPN este selectat și activează blocarea în setările sistemului.';

  @override
  String get protection_dialogOpen => 'Deschide setările';

  @override
  String get session_systemProtectionNote =>
      'Dacă Android încă blochează traficul din afara VPN-ului, deschide setările sistemului pentru a verifica sau modifica această protecție.';

  @override
  String get diagnostics_title => 'Diagnosticare';

  @override
  String get diagnostics_settingsTitle => 'Diagnosticarea aplicației';

  @override
  String get diagnostics_automaticTitle => 'Trimite erorile importante';

  @override
  String get diagnostics_automaticDescription =>
      'Partajează un raport tehnic scurt când apare o eroare importantă.';

  @override
  String get diagnostics_privacy =>
      'Rapoartele trimise sunt asociate contului autentificat și păstrate timp de 30 de zile. Nu conțin istoricul navigării, parole sau chei VPN.';

  @override
  String get diagnostics_manualOpen => 'Rulează diagnosticarea';

  @override
  String get diagnostics_localDescription =>
      'Creează un raport despre starea aplicației și a VPN-ului. Conexiunea ta rămâne neschimbată.';

  @override
  String get diagnostics_sendReport => 'Trimite raportul';

  @override
  String get diagnostics_sendHint =>
      'Lasă această casetă nebifată pentru a păstra raportul pe acest dispozitiv.';

  @override
  String get diagnostics_signedOut =>
      'Autentifică-te în cont pentru a trimite un raport.';

  @override
  String get diagnostics_localLifetime =>
      'Salvează acest raport pe telefon pentru a-l păstra după închiderea aplicației.';

  @override
  String get diagnostics_run => 'Rulează diagnosticarea';

  @override
  String get diagnostics_rerun => 'Rulează din nou diagnosticarea';

  @override
  String get diagnostics_running => 'Se verifică…';

  @override
  String get diagnostics_sending => 'Se trimite raportul…';

  @override
  String get diagnostics_prepared => 'Raport pregătit pe acest dispozitiv';

  @override
  String get diagnostics_queued => 'Raport în așteptarea trimiterii';

  @override
  String get diagnostics_sent => 'Raport primit';

  @override
  String get diagnostics_failed =>
      'Trimiterea a eșuat. Raportul local este încă disponibil.';

  @override
  String get diagnostics_preparationFailed =>
      'Raportul de diagnosticare nu a putut fi pregătit. Încearcă din nou.';

  @override
  String get diagnostics_authenticationRequired =>
      'Autentifică-te din nou pentru a trimite raportul.';

  @override
  String get diagnostics_retry => 'Încearcă din nou trimiterea';

  @override
  String get diagnostics_export => 'Salvează raportul';

  @override
  String get diagnostics_exportFailed =>
      'Exportul a eșuat. Încearcă din nou din raportul local.';

  @override
  String get diagnostics_preferenceFailed =>
      'Această setare nu a putut fi salvată. Încearcă din nou.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referință: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Primit la $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Păstrat până la $date';
  }

  @override
  String get diagnostics_duplicate => 'Acest raport fusese deja primit.';

  @override
  String get diagnostics_preview => 'Previzualizarea raportului';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de evenimente tehnice atașate',
      few: '$count evenimente tehnice atașate',
      one: '$count eveniment tehnic atașat',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Detalii tehnice';

  @override
  String get diagnostics_empty =>
      'Încă nu a fost pregătit niciun raport de diagnosticare.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Starea tunelului',
      'handshake': 'Confirmarea conexiunii',
      'certificate': 'Certificatul VPN',
      'kill_switch': 'Protecția Android',
      'connectivity': 'Rețea disponibilă',
      'api_reachability': 'Acces la serviciu',
      'secure_storage': 'Stocare securizată',
      'other': 'Verificare locală',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Verificat',
      'failed': 'Necesită atenție',
      'skipped': 'Neverificat — nicio verificare activă',
      'unknown': 'Informații indisponibile',
      'other': 'Informații indisponibile',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Bun venit la FuzeVPN';

  @override
  String get connection_changeLocation => 'Schimbă locația';

  @override
  String get connection_details => 'Detaliile conexiunii';

  @override
  String get locations_searchLabel => 'Caută un oraș sau o țară';

  @override
  String get locations_clearSearch => 'Șterge căutarea';

  @override
  String get locations_filterAll => 'Toate';

  @override
  String get locations_filterFavorites => 'Preferate';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de locații',
      few: '$count locații',
      one: '$count locație',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nu a fost găsită nicio locație';

  @override
  String get locations_noResultsHint => 'Încearcă un alt oraș sau o altă țară.';

  @override
  String get locations_noFavorites => 'Preferatele tale, la îndemână';

  @override
  String get locations_noFavoritesHint =>
      'Apasă steaua de lângă o locație pentru a o salva aici.';

  @override
  String get locations_showAll => 'Vezi toate locațiile';

  @override
  String locations_addFavorite(String name) {
    return 'Adaugă $name la preferate';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Elimină $name din preferate';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Locația preferată nu a putut fi salvată. Încearcă din nou.';

  @override
  String get locations_emptyTitle => 'Nu există locații disponibile';

  @override
  String get locations_emptyHint =>
      'Reîmprospătează lista pentru a încerca din nou.';

  @override
  String get devices_manage => 'Gestionează dispozitivele mele';

  @override
  String get settings_personalization => 'Fă-l al tău';

  @override
  String get settings_safety => 'Protecție';

  @override
  String get settings_help => 'Ai nevoie de ajutor?';

  @override
  String get settings_about => 'Despre FuzeVPN';

  @override
  String get diagnostics_heading => 'Înțelege o problemă de conexiune';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Disponibil',
      'pending': 'Se pregătește',
      'revoked': 'Eliminat',
      'expired': 'Expirat',
      'other': 'Stare indisponibilă',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preferința nu a fost salvată';

  @override
  String get notice_preferenceSave_message =>
      'Alegerea ta se aplică momentan, dar nu a putut fi salvată. Încearcă din nou pentru a o păstra după închiderea aplicației.';

  @override
  String get connection_androidDisconnectHint =>
      'Dacă Android menține VPN-ul activ, dezactivează VPN-ul permanent din setările care se deschid.';

  @override
  String get protection_learnMore => 'Află mai multe despre protecția Android';

  @override
  String get protection_guideWhy =>
      'Această protecție împiedică aplicațiile să folosească direct internetul dacă VPN-ul se deconectează. Este configurată în Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN permanent';

  @override
  String get protection_guideAlwaysOn =>
      'Android menține serviciul VPN în funcțiune și îl poate reporni după repornirea telefonului.';

  @override
  String get protection_guideBlockTitle => 'Blochează conexiunile fără VPN';

  @override
  String get protection_guideBlock =>
      'Această setare împiedică ocolirea VPN-ului de către trafic, inclusiv atunci când conexiunea este întreruptă.';

  @override
  String get protection_guideWarning =>
      'Cu această blocare activată, accesul la internet rămâne oprit până când VPN-ul se conectează.';

  @override
  String get protection_guideStepsTitle => 'Activează protecția';

  @override
  String get protection_guideStep1 =>
      'Deschide setările VPN Android folosind butonul de mai jos.';

  @override
  String get protection_guideStep2 =>
      'Deschide opțiunile folosind pictograma rotiță de lângă FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Activează VPN permanent, apoi Blochează conexiunile fără VPN, dacă aceste opțiuni sunt disponibile.';

  @override
  String get protection_guideManufacturers =>
      'Denumirile diferă în funcție de telefon. Dacă este necesar, caută VPN în Setări, de obicei la Rețea și internet.';

  @override
  String get protection_guideDisableTitle => 'Dezactivează această protecție';

  @override
  String get protection_guideDisable =>
      'În aceleași setări, dezactivează blocarea fără VPN pentru a permite accesul la internet fără VPN. Dezactivează și VPN-ul permanent dacă nu mai vrei ca Android să îl repornească.';

  @override
  String get protection_guideManual =>
      'Alegi aceste setări în Android. FuzeVPN nu le modifică în locul tău.';

  @override
  String get locations_changeTitle => 'Schimbi locația?';

  @override
  String locations_changeActive(String name) {
    return 'VPN-ul se va deconecta, apoi va încerca să se conecteze la $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN-ul va încerca să se conecteze la $name.';
  }

  @override
  String get locations_confirmChange => 'Schimbă și conectează-te';

  @override
  String get locations_changeBusy =>
      'O schimbare este în curs. Așteaptă înainte de a alege o altă locație.';

  @override
  String get locations_automaticSelection => 'Selecție automată';

  @override
  String get locations_cities => 'Orașe';

  @override
  String get locations_servers => 'Servere';

  @override
  String locations_viewCities(String name) {
    return 'Vezi orașele din $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Vezi serverele din $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de țări',
      few: '$count țări',
      one: '$count țară',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de orașe',
      few: '$count orașe',
      one: '$count oraș',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de servere',
      few: '$count servere',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Toate țările';

  @override
  String get locations_backToCountries => 'Înapoi la țări';

  @override
  String locations_backToCities(String name) {
    return 'Înapoi la orașele din $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Alege $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Alege $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nu există niciun server compatibil disponibil.';

  @override
  String get externalLink_failed =>
      'Acest link nu poate fi deschis. Îl poți copia și deschide în browser.';

  @override
  String get externalLink_copy => 'Copiază linkul';

  @override
  String get externalLink_copied => 'Link copiat';

  @override
  String get externalLink_copyFailed =>
      'Linkul nu poate fi copiat. Selectează adresa de mai jos.';

  @override
  String get settings_deleteAccount => 'Șterge contul meu';

  @override
  String get settings_deleteAccountDetail =>
      'Vezi cum poți solicita ștergerea contului';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Alege abonamentul VPN.';

  @override
  String get billing_subscribe => 'Abonează-te';

  @override
  String get billing_choosePlan => 'Alege un plan pentru a continua.';

  @override
  String get billing_monthly => 'Lunar';

  @override
  String get billing_yearly => 'Anual';

  @override
  String get billing_continue => 'Continuă cu Google Play';

  @override
  String get billing_restore => 'Restabilește achizițiile';

  @override
  String get billing_manage => 'Gestionează abonamentul';

  @override
  String get billing_deleteAccountWarning =>
      'Dacă ai un abonament Google Play, ștergerea contului FuzeVPN nu anulează reînnoirea acestuia. Gestionează sau anulează reînnoirea separat în Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Continuă către cererea de ștergere a contului';

  @override
  String get billing_refresh => 'Actualizează accesul';

  @override
  String get billing_loadingPlans => 'Se încarcă planurile…';

  @override
  String get billing_unavailable =>
      'Nu există planuri disponibile acum. Încearcă mai târziu.';

  @override
  String get billing_comingSoon => 'Abonamente disponibile în curând.';

  @override
  String get billing_priceDisclosure =>
      'Preț furnizat de Google Play. Suma finală și taxele aplicabile sunt confirmate înainte de confirmarea ta.';

  @override
  String get billing_renewalMonthly =>
      'Se reînnoiește automat în fiecare lună, dacă nu este anulat. Poți anula oricând din abonamentele Google Play.';

  @override
  String get billing_renewalYearly =>
      'Se reînnoiește automat în fiecare an, dacă nu este anulat. Poți anula oricând din abonamentele Google Play.';

  @override
  String get billing_active => 'Accesul tău Premium este activ';

  @override
  String billing_accessUntil(String date) {
    return 'Acces până la $date.';
  }

  @override
  String get billing_webManaged =>
      'Abonamentul tău este gestionat pe site-ul FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Abonamentul tău este gestionat prin Google Play.';

  @override
  String get billing_inactive => 'Niciun abonament activ.';

  @override
  String get billing_checkingAccess => 'Se verifică accesul…';

  @override
  String get billing_restoring => 'Se restabilesc achizițiile…';

  @override
  String get billing_pending =>
      'Plata este în așteptare. Accesul se va activa după confirmare.';

  @override
  String get billing_cancelled =>
      'Achiziție anulată. Nu a fost activat niciun abonament nou.';

  @override
  String get billing_verifying => 'Se verifică achiziția…';

  @override
  String get billing_success =>
      'Abonament activat. Accesul tău Premium este pregătit.';

  @override
  String get billing_restored => 'Achizițiile tale au fost restabilite.';

  @override
  String get billing_restoreEmpty =>
      'Nu există achiziții de restabilit pentru acest cont Google Play.';

  @override
  String get billing_catalogError =>
      'Planurile nu pot fi încărcate. Încearcă din nou.';

  @override
  String get billing_purchaseError =>
      'Achiziția nu poate fi inițiată. Încearcă din nou.';

  @override
  String get billing_verificationError =>
      'Verificarea achiziției este temporar indisponibilă. Restabilește achizițiile pentru a reîncerca.';

  @override
  String get billing_restoreError =>
      'Achizițiile nu pot fi restabilite. Încearcă din nou.';

  @override
  String get billing_managementError =>
      'Gestionarea abonamentelor nu poate fi deschisă. Încearcă din nou.';

  @override
  String get billing_storeUnavailable =>
      'Google Play nu este disponibil pe acest dispozitiv.';

  @override
  String get welcome_title => 'VPN-ul tău, fără complicații.';

  @override
  String get welcome_description =>
      'Protejează-ți conexiunea. Păstrează controlul asupra confidențialității.';

  @override
  String get welcome_start => 'Începe';

  @override
  String get welcome_alreadyPurchased => 'Ai cumpărat deja?';

  @override
  String get welcome_noAccountRequired =>
      'Nu trebuie să creezi un cont pentru a începe.';

  @override
  String get guest_accountTitle => 'Cont neasociat';

  @override
  String get guest_accountDescription =>
      'Restaurează achizițiile cu același cont Google Play pentru a folosi abonamentul pe alt dispozitiv.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Ai deja un abonament? Conectează-te';

  @override
  String get guest_claimTitle => 'Ia FuzeVPN cu tine';

  @override
  String get guest_claimDescription =>
      'Creează un cont pentru a accesa abonamentul pe celelalte dispozitive. Acest pas este opțional.';

  @override
  String get guest_skip => 'Mai târziu';

  @override
  String get guest_activationTitle => 'Fuze Premium este activ';

  @override
  String get guest_activationDescription =>
      'Abonamentul tău este pregătit. Folosește VPN-ul și creează un cont când dorești.';

  @override
  String get guest_useVpn => 'Folosește VPN-ul meu';

  @override
  String get guest_loginRequired =>
      'Această achiziție este deja asociată unui cont FuzeVPN. Conectează-te la acel cont pentru a accesa abonamentul.';

  @override
  String get guest_signOutWarning =>
      'Poți recupera abonamentul restaurând achizițiile cu același cont Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Contul tău este deja asociat. Conectează-te pentru a vedea și gestiona informațiile tale.';

  @override
  String get billing_acceptance =>
      'Continuând, accepți Condițiile de utilizare și Politica de confidențialitate.';

  @override
  String get guest_verifyEmailReminder =>
      'Confirmă adresa de e-mail pentru a-ți proteja contul. Poți continua să folosești VPN-ul.';

  @override
  String get guest_serviceUnavailable =>
      'Serviciul este temporar indisponibil. Încearcă din nou în scurt timp.';

  @override
  String get guest_restoreError =>
      'Achizițiile nu au putut fi restaurate. Încearcă din nou cu contul Google Play folosit pentru achiziție.';

  @override
  String get guest_claimSuccess =>
      'Contul tău a fost creat. Abonamentul și accesul la VPN sunt păstrate.';

  @override
  String get guest_emailExists =>
      'Această adresă de e-mail este deja folosită. Alege altă adresă sau conectează-te la contul existent. Achiziția rămâne disponibilă prin Google Play.';

  @override
  String get guest_claimError =>
      'Contul tău nu a putut fi creat. Poți continua să folosești VPN-ul și să încerci din nou mai târziu.';

  @override
  String get guest_secureStorageError =>
      'Sesiunea nu a putut fi salvată în siguranță pe acest dispozitiv. Încearcă din nou.';

  @override
  String get guest_premiumRequired =>
      'Alege un abonament pentru a activa VPN-ul.';

  @override
  String get welcome_viewPlans => 'Vezi planurile';

  @override
  String get google_continue => 'Continuă cu Google';

  @override
  String get google_or => 'sau';

  @override
  String get google_title => 'Contul tău FuzeVPN';

  @override
  String get google_settingUp => 'Finalizează contul';

  @override
  String get google_country => 'Țara de reședință';

  @override
  String get google_profileDescription =>
      'Alege țara și citește ambele documente pentru a crea contul FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Asociază contul de oaspete cu Google. Abonamentul și dispozitivul rămân asociate acestui cont.';

  @override
  String get google_linkTitle => 'Asociază Google cu FuzeVPN';

  @override
  String get google_linkDescription =>
      'Confirmă accesul la contul FuzeVPN existent. Nu se solicită parola Google.';

  @override
  String get google_password => 'Parola FuzeVPN';

  @override
  String get google_linkAccount => 'Confirmă asocierea';

  @override
  String get google_requestEmail => 'Primește un e-mail de confirmare';

  @override
  String get google_emailInstructions =>
      'Deschide e-mailul FuzeVPN și introdu codul de confirmare.';

  @override
  String get google_emailCode => 'Codul de confirmare din e-mail';

  @override
  String get google_confirmEmail => 'Confirmă codul';

  @override
  String get google_restart => 'Alege alt cont Google';

  @override
  String get google_resume => 'Verifică această încercare';

  @override
  String get google_unavailable =>
      'Autentificarea Google nu este disponibilă. Poți folosi e-mailul și parola.';

  @override
  String get google_expired =>
      'Această încercare a expirat. Anuleaz-o și începe din nou.';

  @override
  String get google_conflict =>
      'Acest cont Google este deja asociat altui cont. Contul și abonamentul actuale sunt păstrate.';

  @override
  String get google_error =>
      'Autentificarea Google a eșuat. Încearcă din nou; accesul actual este păstrat.';

  @override
  String get google_uncertain =>
      'Rezultatul nu a putut fi confirmat. Verifică această încercare sau anuleaz-o înainte de a reîncepe.';

  @override
  String get google_cancelFailed =>
      'Anularea nu a putut fi confirmată. Încearcă să anulezi din nou înainte de a părăsi ecranul.';

  @override
  String get google_cancelled => 'Autentificare Google anulată.';

  @override
  String get google_selecting => 'Alege contul Google…';

  @override
  String get google_verifying => 'Se verifică contul…';

  @override
  String get google_emailUnavailable =>
      'E-mailul de confirmare nu a putut fi trimis. Încearcă mai târziu.';

  @override
  String get google_emailSent =>
      'E-mail de confirmare trimis. Verifică mesajele primite.';

  @override
  String get google_rateLimited => 'Așteaptă înainte de a încerca din nou.';

  @override
  String get google_invalidPassword =>
      'Parola FuzeVPN este incorectă. Contul actual este păstrat.';

  @override
  String get google_invalidCode =>
      'Codul de confirmare este invalid sau a expirat.';

  @override
  String get google_accountChanged =>
      'Sesiunea s-a schimbat. Anulează această încercare înainte de a reîncepe.';

  @override
  String get google_invalidResponse =>
      'Răspunsul nu a putut fi validat. Accesul actual este păstrat.';

  @override
  String get google_invalidRegistration => 'Verifică țara și ambele acorduri.';

  @override
  String get google_consentRequired =>
      'Alege țara și acceptă ambele documente pentru a continua.';

  @override
  String get google_challengeRequired =>
      'Este necesară o verificare suplimentară de securitate. Accesul actual este păstrat.';

  @override
  String get google_challengeUnavailable =>
      'Verificarea de securitate nu este disponibilă. Încearcă mai târziu.';

  @override
  String get billing_trialTitle => 'Încearcă Fuze Premium gratuit';

  @override
  String get billing_trialSubtitle =>
      'Protejează-ți conexiunea începând de azi.';

  @override
  String get billing_trialWeeks => '2 săptămâni de probă gratuită';

  @override
  String billing_trialDays(String days) {
    return '$days zile de probă gratuită';
  }

  @override
  String get billing_trialStart => 'Începe perioada mea de probă gratuită';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Dacă începi azi, prima debitare este estimată pentru $date.';
  }

  @override
  String get billing_trialTerms =>
      'Se reînnoiește automat la prețul afișat. Pentru a evita debitarea, anulează în Google Play înainte de sfârșitul perioadei de probă.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Apoi $price pe lună';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Apoi $price pe an';
  }

  @override
  String get billing_choosePeriod => 'Alege-ți planul';

  @override
  String get billing_selectionHint => 'Selectează un plan pentru a continua.';

  @override
  String get billing_benefitConnection => 'Conexiune criptată';

  @override
  String get billing_benefitPrivacy => 'Confidențialitate online';

  @override
  String get billing_benefitNoAccount => 'Înregistrarea nu este obligatorie';

  @override
  String get billing_cancellation => 'Anulare în Google Play';

  @override
  String get billing_premiumTitle => 'Conexiunea ta, mai bine protejată.';

  @override
  String get billing_premiumSubtitle => 'Protejează conexiunea în ritmul tău.';

  @override
  String get billing_priceMonthly => 'pe lună';

  @override
  String get billing_priceYearly => 'pe an';

  @override
  String get billing_trialToday => 'Azi nu ai nimic de plătit';

  @override
  String get billing_trialConfirmation =>
      'Google Play confirmă datele, suma finală și taxele aplicabile înainte de confirmarea ta.';

  @override
  String get billing_offerChanged =>
      'Condițiile acestei oferte s-au schimbat. Reîmprospătează planurile și alege din nou.';
}
