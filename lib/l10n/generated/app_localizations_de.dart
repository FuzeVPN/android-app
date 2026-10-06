// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get accountRestoration_title => 'Konto vorübergehend nicht verfügbar';

  @override
  String get accountRestoration_message =>
      'Deine Sitzung wurde gespeichert. Versuche erneut, dein Konto zu laden. Du kannst die VPN-Verbindung hier weiterhin verwalten.';

  @override
  String get action_retry => 'Erneut versuchen';

  @override
  String get session_endingTitle => 'Sitzung wird beendet';

  @override
  String get session_ending =>
      'Deine Sitzung ist ungültig. VPN wird beendet und die Sitzung gelöscht…';

  @override
  String get session_stopFailed =>
      'Das Beenden des VPN ist nicht bestätigt. Versuche es vor der erneuten Anmeldung noch einmal.';

  @override
  String get session_cleanupFailed =>
      'Das VPN ist beendet, aber das Löschen der Sitzung ist nicht bestätigt. Wiederhole die Bereinigung.';

  @override
  String get session_retryStop => 'Beenden erneut versuchen';

  @override
  String get session_retryCleanup => 'Bereinigung wiederholen';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN wird sicher vorbereitet…';

  @override
  String get nav_connection => 'Verbindung';

  @override
  String get nav_locations => 'Standorte';

  @override
  String get nav_account => 'Konto';

  @override
  String get nav_devices => 'Geräte';

  @override
  String get nav_settings => 'Einstellungen';

  @override
  String get action_refresh => 'Aktualisieren';

  @override
  String get auth_tab_login => 'Anmelden';

  @override
  String get auth_tab_register => 'Registrieren';

  @override
  String get auth_stepAccount => 'Konto';

  @override
  String get auth_stepIdentity => 'Identität';

  @override
  String get auth_stepAddress => 'Adresse und Zustimmungen';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Schritt $current von $total';
  }

  @override
  String get auth_tagline => 'Dein VPN. Ganz einfach.';

  @override
  String get auth_keysLocal =>
      'Deine privaten VPN-Schlüssel bleiben auf diesem Gerät.';

  @override
  String get form_email => 'E-Mail-Adresse';

  @override
  String get form_password => 'Passwort';

  @override
  String get form_showPassword => 'Passwort anzeigen';

  @override
  String get form_hidePassword => 'Passwort verbergen';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8-Bytes. Manche Zeichen belegen mehrere Bytes.';

  @override
  String get form_firstName => 'Vorname';

  @override
  String get form_lastName => 'Nachname';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adresse';

  @override
  String get form_address2 => 'Adresszusatz (optional)';

  @override
  String get form_postalCode => 'Postleitzahl';

  @override
  String get form_city => 'Stadt';

  @override
  String get form_country => 'Ländercode (z. B. DE)';

  @override
  String get action_login => 'Anmelden';

  @override
  String get action_createAccount => 'Konto erstellen';

  @override
  String get action_createMyAccount => 'Mein Konto erstellen';

  @override
  String get action_next => 'Weiter';

  @override
  String get action_previous => 'Zurück';

  @override
  String get action_forgotPassword => 'Passwort vergessen?';

  @override
  String get auth_noAccount => 'Noch kein Konto?';

  @override
  String get auth_requiredInformation =>
      'Erstelle dein Konto in drei Schritten.';

  @override
  String get auth_termsPrefix => 'Ich akzeptiere die ';

  @override
  String get auth_termsLink => 'Nutzungsbedingungen';

  @override
  String get auth_privacyPrefix => 'Ich akzeptiere die ';

  @override
  String get auth_privacyLink => 'Datenschutzerklärung';

  @override
  String get auth_consentRequired =>
      'Ihre Zustimmung ist erforderlich, um ein Konto zu erstellen.';

  @override
  String get validation_required => 'Dieses Feld ist erforderlich.';

  @override
  String get validation_email => 'Geben Sie eine gültige E-Mail-Adresse ein.';

  @override
  String get validation_password =>
      'Passwort zu kurz: mindestens 8 UTF-8-Bytes.';

  @override
  String get validation_passwordTooLong =>
      'Passwort zu lang: höchstens 72 UTF-8-Bytes.';

  @override
  String get validation_phone =>
      'Verwenden Sie das internationale Format, z. B. +33612345678.';

  @override
  String get validation_country =>
      'Verwenden Sie einen zweistelligen Ländercode, z. B. FR.';

  @override
  String get passwordReset_title => 'Passwort zurücksetzen';

  @override
  String get passwordReset_description =>
      'Gib die E-Mail-Adresse deines Kontos ein, um einen Link zum Zurücksetzen anzufordern.';

  @override
  String get passwordReset_send => 'Link senden';

  @override
  String get connection_title => 'Ihre Verbindung';

  @override
  String get connection_subtitle =>
      'Wähle einen Standort und aktiviere dein VPN.';

  @override
  String get connection_prepare => 'Bereit zum Verbinden?';

  @override
  String get connection_advancedOptions => 'Erweiterte Optionen';

  @override
  String get connection_location => 'Standort';

  @override
  String get connection_chooseLocation => 'Standort auswählen';

  @override
  String get connection_protocol => 'Protokoll';

  @override
  String get connection_connect => 'Verbinden';

  @override
  String get connection_connecting => 'Verbindung wird hergestellt…';

  @override
  String get connection_disconnect => 'Trennen';

  @override
  String get connection_disconnecting => 'Trennung läuft';

  @override
  String get connection_locationChange => 'Standort wird gewechselt…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nicht verfügbar';
  }

  @override
  String get connection_activeLocation => 'Aktiver Standort';

  @override
  String get connection_duration => 'Dauer';

  @override
  String get connection_received => 'Empfangen';

  @override
  String get connection_sent => 'Gesendet';

  @override
  String get connection_lastHandshake => 'Letzter sicherer Austausch';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Vor $duration';
  }

  @override
  String get verification_title => 'Bestätigen Sie Ihre E-Mail-Adresse';

  @override
  String get verification_message =>
      'Bestätige deine E-Mail-Adresse, um das VPN auf diesem Telefon zu nutzen.';

  @override
  String get verification_resend => 'E-Mail erneut senden';

  @override
  String get migration_title => 'Standortwechsel';

  @override
  String get migration_draining => 'Standortwechsel wird vorbereitet…';

  @override
  String get migration_activating => 'Neuer Server wird aktiviert…';

  @override
  String get migration_ready => 'Standort aktualisiert.';

  @override
  String get migration_blocked =>
      'Der Standortwechsel erfordert einen Servereingriff. Versuchen Sie es später erneut oder kontaktieren Sie den Support.';

  @override
  String get migration_progress => 'Fortschritt des Standortwechsels';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Wartezeit zwischen Prüfungen: $seconds Sek.';
  }

  @override
  String get migration_resume => 'Standortwechsel fortsetzen';

  @override
  String get status_authorizing => 'Berechtigung erforderlich';

  @override
  String get status_authorizingDetail =>
      'Bestätige die Android-Anfrage, um das VPN zuzulassen.';

  @override
  String get status_preparing => 'Vorbereitung';

  @override
  String get status_preparingDetail =>
      'Deine sichere Verbindung wird vorbereitet.';

  @override
  String get status_reconnecting => 'Verbindung wird wiederhergestellt…';

  @override
  String get status_reconnectingDetail =>
      'Verbindung unterbrochen. Das VPN versucht, die Verbindung wiederherzustellen.';

  @override
  String get status_connecting => 'Verbindung wird hergestellt';

  @override
  String get status_connectingDetail =>
      'Verbindung zum VPN-Server wird hergestellt…';

  @override
  String get status_connected => 'Verbunden';

  @override
  String get status_connectedDetail => 'Deine VPN-Verbindung ist aktiv.';

  @override
  String get status_disconnecting => 'Trennung läuft';

  @override
  String get status_disconnectingDetail => 'Deine VPN-Verbindung wird beendet.';

  @override
  String get status_error => 'Verbindung nicht verfügbar';

  @override
  String get status_errorDetail =>
      'Die VPN-Verbindung wurde nicht bestätigt. Versuche es erneut.';

  @override
  String get status_idle => 'Getrennt';

  @override
  String get status_idleDetail =>
      'Verbinde das VPN, um deine Verbindung zu schützen.';

  @override
  String get trust_note =>
      'Das Schließen der App beendet das VPN nicht. Tippe auf Trennen, um es zu beenden.';

  @override
  String get locations_none => 'Derzeit sind keine Standorte verfügbar.';

  @override
  String get locations_available => 'Wähle deinen nächsten Standort.';

  @override
  String get locations_selected => 'Ausgewählter Standort';

  @override
  String get locations_select => 'Diesen Standort wählen';

  @override
  String get locations_lockedTunnel =>
      'Trenne das VPN, um den Standort zu ändern.';

  @override
  String get locations_lockedMigration =>
      'Warte, bis der Standortwechsel abgeschlossen ist.';

  @override
  String get devices_title => 'Ihre Geräte';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit Geräte';
  }

  @override
  String get devices_refresh => 'Geräte aktualisieren';

  @override
  String get devices_empty => 'Noch kein VPN-Gerät registriert.';

  @override
  String get devices_firstConnection =>
      'Ihr Telefon wird bei der ersten Verbindung hinzugefügt.';

  @override
  String get devices_thisDevice => 'Dieses Gerät';

  @override
  String devices_added(Object date) {
    return 'Hinzugefügt am $date';
  }

  @override
  String get action_remove => 'Entfernen';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_subtitle =>
      'Deine Einstellungen und dein Konto an einem Ort.';

  @override
  String get settings_appearance => 'Darstellung';

  @override
  String get settings_language => 'Sprache';

  @override
  String get settings_languageDescription =>
      'Die gewählte Sprache gilt auch für VPN-Benachrichtigungen.';

  @override
  String get settings_account => 'Konto';

  @override
  String get settings_signOut => 'Abmelden';

  @override
  String get settings_privacy => 'Datenschutzerklärung';

  @override
  String get settings_terms => 'Nutzungsbedingungen';

  @override
  String get settings_security => 'Sicherheit und Transparenz';

  @override
  String get settings_licenses => 'Komponentenlizenzen';

  @override
  String get settings_licensesDetail => 'In der App verwendete Software';

  @override
  String get settings_background =>
      'Das VPN bleibt aktiv, wenn du die App verlässt. Tippe im Tab Verbindung auf Trennen, um es zu beenden.';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Hell';

  @override
  String get theme_dark => 'Dunkel';

  @override
  String get language_system => 'Sprache des Telefons';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Dieses Gerät entfernen?';

  @override
  String get dialog_removeCurrent =>
      'Dieses Telefon wird vom VPN getrennt und verliert den Zugang. Seine VPN-Verbindungsdaten werden nach Bestätigung durch den Server gelöscht.';

  @override
  String dialog_removeOther(Object name) {
    return 'Der VPN-Zugang von „$name“ wird widerrufen. Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get dialog_signOut => 'Abmelden?';

  @override
  String get dialog_signOutMessage =>
      'Das VPN wird beendet und du musst dich erneut anmelden. Deine verschlüsselten VPN-Schlüssel bleiben für die nächste Verbindung auf diesem Telefon.';

  @override
  String get action_cancel => 'Abbrechen';

  @override
  String get action_signOut => 'Abmelden';

  @override
  String get notice_close => 'Meldung schließen';

  @override
  String get notice_sessionExpired_title => 'Sitzung abgelaufen';

  @override
  String get notice_sessionExpired_message =>
      'Ihre Sitzung ist abgelaufen. Melden Sie sich erneut an.';

  @override
  String get notice_connectionFailed_title => 'Verbindung fehlgeschlagen';

  @override
  String get notice_invalidCredentials_message =>
      'E-Mail-Adresse oder Passwort sind falsch.';

  @override
  String get notice_emailVerification_title =>
      'E-Mail-Bestätigung erforderlich';

  @override
  String get notice_emailVerification_message =>
      'Bestätigen Sie Ihre E-Mail-Adresse, bevor Sie ein VPN-Gerät hinzufügen.';

  @override
  String get notice_rateLimited_title => 'Zu viele Versuche';

  @override
  String get notice_deviceLimit_title => 'Limit von 2 Geräten erreicht';

  @override
  String get notice_deviceLimit_message =>
      'Entfernen Sie ein vorhandenes Gerät, bevor Sie ein weiteres hinzufügen.';

  @override
  String get notice_identityRenewal_title =>
      'VPN-Identität muss erneuert werden';

  @override
  String get notice_identityRenewal_message =>
      'Diese Identität wurde entfernt. Erstellen Sie eine neue lokale Identität.';

  @override
  String get notice_migrationPending_title => 'Standortwechsel läuft';

  @override
  String get notice_migrationPending_message =>
      'Ein Standortwechsel läuft bereits.';

  @override
  String get notice_migrationBlocked_title => 'Standortwechsel blockiert';

  @override
  String get notice_migrationBlocked_message =>
      'Der Standortwechsel erfordert einen Servereingriff. Versuchen Sie es später erneut oder kontaktieren Sie den Support.';

  @override
  String get notice_targetUnavailable_title =>
      'Server vorübergehend nicht verfügbar';

  @override
  String get notice_targetUnavailable_message =>
      'Dieser Server ist vorübergehend nicht verfügbar.';

  @override
  String get notice_networkUnavailable_title =>
      'Internetverbindung nicht verfügbar';

  @override
  String get notice_networkUnavailable_message =>
      'Prüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get notice_permissionDenied_title => 'VPN-Berechtigung verweigert';

  @override
  String get notice_permissionDenied_message =>
      'Starte die Verbindung erneut und bestätige die Android-Berechtigung.';

  @override
  String get notice_wireguardTimeout_title => 'Der Server antwortet nicht';

  @override
  String get notice_wireguardTimeout_message =>
      'Die WireGuard-Verbindung hat zu lange gedauert. Versuche es erneut oder wähle einen anderen Standort.';

  @override
  String get notice_tlsFailed_title => 'Sichere Verbindung abgelehnt';

  @override
  String get notice_tlsFailed_message =>
      'Der Server hat die OpenVPN-Verbindung nicht akzeptiert. Versuche es erneut. Wenn das Problem bleibt, starte eine Diagnose.';

  @override
  String get notice_tunRejected_title =>
      'Android hat die VPN-Schnittstelle abgelehnt';

  @override
  String get notice_tunRejected_message =>
      'Android hat die von OpenVPN angeforderte Netzwerkkonfiguration abgelehnt.';

  @override
  String get notice_openvpnStart_title =>
      'OpenVPN konnte nicht gestartet werden';

  @override
  String get notice_openvpnStart_message =>
      'Die OpenVPN-Engine konnte nicht vollständig starten. Versuchen Sie es erneut. Falls das Problem bestehen bleibt, wenden Sie sich an den Support.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnosecode: $code';
  }

  @override
  String get notice_generic_title => 'VPN-Verbindung fehlgeschlagen';

  @override
  String get notice_generic_message =>
      'Ein Fehler ist aufgetreten. Versuchen Sie es später erneut.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konto erstellt',
      'password_reset_sent': 'Anfrage zum Zurücksetzen erhalten',
      'verification_email_sent': 'Bestätigungs-E-Mail gesendet',
      'location_migration_pending': 'Standortwechsel läuft',
      'vpn_sign_in_required': 'Anmeldung erforderlich',
      'protocol_unavailable_at_location': 'Protokoll nicht verfügbar',
      'vpn_permission_denied': 'VPN-Berechtigung abgelehnt',
      'revoked_identity_device_limit': 'Limit von 2 Geräten erreicht',
      'tunnel_start_unexpected': 'VPN konnte nicht gestartet werden',
      'flutter_disconnect_timeout': 'Trennung nicht bestätigt',
      'flutter_disconnect_unexpected': 'Trennung fehlgeschlagen',
      'device_revoked': 'Gerät entfernt',
      'revoke_unexpected': 'Gerät konnte nicht entfernt werden',
      'identity_renewal_unexpected': 'Identität konnte nicht erneuert werden',
      'openvpn_renewal_unexpected': 'OpenVPN konnte nicht erneuert werden',
      'location_migration_blocked': 'Standortwechsel blockiert',
      'location_migration_slow': 'Standortwechsel läuft noch',
      'location_migration_conflict': 'Standortwechsel muss aktualisiert werden',
      'location_migration_verification_failed':
          'Standortwechsel nicht bestätigt',
      'location_migration_device_changed':
          'Gerät während des Wechsels geändert',
      'tunnel_stop_failed': 'Wechsel nicht möglich',
      'other': 'Vorgang fehlgeschlagen',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Das Konto wurde erstellt, aber die Bestätigungs-E-Mail konnte nicht gesendet werden. Nutzen Sie die erneute Zusendung in der App.',
      'password_reset_sent':
          'Ihre Anfrage ist eingegangen. Falls ein Konto zu dieser Adresse gehört, erhalten Sie möglicherweise eine E-Mail. Prüfen Sie auch Ihren Spamordner.',
      'verification_email_sent':
          'Eine neue Bestätigungs-E-Mail wurde soeben gesendet.',
      'location_migration_pending':
          'Der Wechsel zu $target wird noch vorbereitet. Sie können ihn fortsetzen, ohne das Gerät neu anzulegen.',
      'vpn_sign_in_required': 'Melden Sie sich an, bevor Sie das VPN starten.',
      'protocol_unavailable_at_location':
          'Das gewählte Protokoll wird an diesem Standort nicht angeboten. Aktualisieren Sie die Standorte oder wählen Sie ein anderes Protokoll.',
      'vpn_permission_denied':
          'Android hat die VPN-Berechtigung abgelehnt. Starten Sie die Verbindung erneut und bestätigen Sie die Systemanfrage.',
      'revoked_identity_device_limit':
          'Der VPN-Zugang dieses Geräts wurde entfernt und das Gerätelimit ist erreicht. Entferne ein Gerät unter Konto → Meine Geräte verwalten.',
      'tunnel_start_unexpected':
          'Ein unerwarteter Fehler hat die Tunnelvorbereitung unterbrochen. Prüfen Sie den Diagnosecode und versuchen Sie es erneut.',
      'flutter_disconnect_timeout':
          'Android hat das Beenden des VPN nicht rechtzeitig bestätigt. Versuche erneut, es zu beenden.',
      'flutter_disconnect_unexpected':
          'Ein unerwarteter Fehler hat die Bestätigung des Tunnelstopps verhindert.',
      'device_revoked':
          'Der VPN-Zugriff des Geräts wurde widerrufen und seine lokalen Geheimnisse wurden gelöscht.',
      'revoke_unexpected':
          'Das Gerät konnte nicht entfernt werden. Aktualisieren Sie die Liste und versuchen Sie es erneut.',
      'identity_renewal_unexpected':
          'Die neue VPN-Identität konnte nicht erstellt werden. Aktualisieren Sie die Geräte und versuchen Sie es erneut.',
      'openvpn_renewal_unexpected':
          'Das OpenVPN-Profil konnte nicht erneuert werden. Versuchen Sie es erneut oder prüfen Sie den Diagnosecode.',
      'location_migration_blocked':
          'Der Server kann diesen Wechsel derzeit nicht abschließen. Gerät und lokale Identität wurden beibehalten.',
      'location_migration_slow':
          'Der Server bereitet den Wechsel zu $target noch vor. Verwenden Sie in Kürze Fortsetzen.',
      'location_migration_conflict':
          'Der Gerätestatus auf dem Server hat sich geändert. Aktualisieren Sie die Geräte und setzen Sie den Wechsel fort.',
      'location_migration_verification_failed':
          'Der Server hat den neuen Standort nicht bestätigt. Die bisherige lokale Identität wurde beibehalten.',
      'location_migration_device_changed':
          'Das vom Server zurückgegebene Gerät entspricht nicht mehr dem Gerät des Wechsels. Aktualisieren Sie die Geräte vor einem neuen Versuch.',
      'tunnel_stop_failed':
          'Der vorherige Tunnel muss vor der neuen Verbindung vollständig beendet sein.',
      'other':
          'Der Vorgang konnte nicht abgeschlossen werden. Versuchen Sie es erneut oder senden Sie den Diagnosecode an den Support.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sitzung abgelaufen',
      'invalid_credentials': 'Anmeldung fehlgeschlagen',
      'email_verification_required': 'E-Mail-Bestätigung erforderlich',
      'verification_email_cooldown': 'E-Mail bereits gesendet',
      'rate_limited': 'Zu viele Versuche',
      'invalid_registration': 'Angaben müssen korrigiert werden',
      'email_exists': 'Konto bereits vorhanden',
      'invalid_profile': 'Ungültiges Profil',
      'invalid_device': 'Ungültiges Gerät',
      'invalid_location': 'Standort nicht verfügbar',
      'device_limit': 'Limit von 2 Geräten erreicht',
      'device_exists': 'VPN-Identität bereits verwendet',
      'device_identity_revoked': 'VPN-Identität muss erneuert werden',
      'device_location_locked': 'Standortwechsel muss aktualisiert werden',
      'location_migration_pending': 'Standortwechsel läuft',
      'location_migration_blocked': 'Standortwechsel blockiert',
      'target_ca_mismatch': 'OpenVPN-Server nicht kompatibel',
      'location_migration_conflict': 'Standortwechsel muss aktualisiert werden',
      'server_full': 'Server voll',
      'capacity_unavailable': 'Standort vorübergehend nicht verfügbar',
      'target_unavailable': 'Server vorübergehend nicht verfügbar',
      'not_found': 'Element nicht gefunden',
      'invalid_openvpn_csr': 'Ungültige OpenVPN-Identität',
      'openvpn_profile_exists': 'OpenVPN-Profil bereits vorhanden',
      'openvpn_profile_revoked': 'OpenVPN-Profil widerrufen',
      'openvpn_operation_pending': 'OpenVPN-Vorgang läuft',
      'openvpn_operation_terminal': 'OpenVPN-Vorgang unterbrochen',
      'openvpn_address_unavailable': 'OpenVPN-Adresse nicht verfügbar',
      'openvpn_profile_conflict': 'OpenVPN-Konflikt',
      'openvpn_signer_unavailable': 'OpenVPN nicht verfügbar',
      'email_delivery_unavailable': 'E-Mail nicht verfügbar',
      'invalid_token': 'Ungültiger Link',
      'network_unavailable': 'Internetverbindung nicht verfügbar',
      'invalid_json': 'Ungültige Anfrage',
      'invalid_api_response': 'Ungültige Serverantwort',
      'ipv6_unavailable': 'IPv6 nicht verfügbar',
      'invalid_ip_families': 'Netzwerkkonfiguration abgelehnt',
      'other': 'Dienst nicht verfügbar',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Ihre Sitzung ist abgelaufen. Melden Sie sich erneut an.',
      'invalid_credentials': 'E-Mail-Adresse oder Passwort ist falsch.',
      'email_verification_required':
          'Bestätigen Sie Ihre E-Mail-Adresse, bevor Sie ein VPN-Gerät hinzufügen.',
      'invalid_registration':
          'Prüfen Sie die verlangten Angaben und Einwilligungen.',
      'email_exists': 'Für diese E-Mail-Adresse besteht bereits ein Konto.',
      'invalid_profile': 'Prüfen Sie Ihre Profilangaben.',
      'invalid_device':
          'Name oder lokale Identität dieses Geräts ist ungültig.',
      'invalid_location':
          'Aktualisieren Sie die Standortliste und versuchen Sie es erneut.',
      'device_limit':
          'Entfernen Sie ein vorhandenes Gerät, bevor Sie ein weiteres hinzufügen.',
      'device_exists':
          'Diese VPN-Identität ist bereits mit einem anderen Konto verknüpft.',
      'device_identity_revoked':
          'Diese Identität wurde entfernt. Eine neue lokale Identität muss erstellt werden.',
      'device_location_locked':
          'Der Standort dieses Geräts wurde gerade geändert. Die App setzt den laufenden Wechsel fort.',
      'location_migration_pending': 'Ein Standortwechsel läuft bereits.',
      'location_migration_blocked':
          'Der Standortwechsel erfordert einen Eingriff am Server. Versuchen Sie es später erneut oder wenden Sie sich an den Support.',
      'target_ca_mismatch':
          'Dieser Server ist noch nicht mit dem aktuellen OpenVPN-Profil kompatibel.',
      'location_migration_conflict':
          'Aktualisieren Sie die Geräte und versuchen Sie den Standortwechsel erneut.',
      'server_full':
          'Dieser Standort hat sein Verbindungslimit erreicht. Wähle einen anderen Standort oder versuche es später erneut.',
      'capacity_unavailable':
          'Die Verfügbarkeit dieses Standorts kann gerade nicht bestätigt werden. Wähle einen anderen Standort oder versuche es später erneut.',
      'target_unavailable': 'Dieser Server ist vorübergehend nicht verfügbar.',
      'not_found': 'Dieses Element ist in Ihrem Konto nicht mehr verfügbar.',
      'invalid_openvpn_csr':
          'Erstellen Sie eine neue OpenVPN-Identität und versuchen Sie es erneut.',
      'openvpn_profile_exists':
          'Für dieses Gerät besteht bereits ein OpenVPN-Profil.',
      'openvpn_profile_revoked':
          'Erneuern Sie das OpenVPN-Profil, um fortzufahren.',
      'openvpn_operation_pending':
          'Die Änderung wird noch verteilt. Versuchen Sie es später erneut.',
      'openvpn_operation_terminal':
          'Erstellen Sie eine neue OpenVPN-Identität und versuchen Sie es erneut.',
      'openvpn_address_unavailable':
          'Derzeit ist keine OpenVPN-Adresse verfügbar.',
      'openvpn_profile_conflict':
          'Das Profil wurde geändert. Aktualisieren Sie die Geräte und versuchen Sie es erneut.',
      'openvpn_signer_unavailable':
          'Der OpenVPN-Dienst ist vorübergehend nicht verfügbar.',
      'email_delivery_unavailable':
          'Die E-Mail konnte nicht gesendet werden. Versuchen Sie es später erneut.',
      'invalid_token':
          'Dieser Link ist ungültig oder abgelaufen. Fordern Sie einen neuen an.',
      'network_unavailable':
          'Prüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.',
      'invalid_json':
          'Prüfen Sie die eingegebenen Angaben und versuchen Sie es erneut.',
      'invalid_api_response':
          'Der Server hat unerwartet geantwortet. Versuchen Sie es später erneut.',
      'ipv6_unavailable':
          'Der Server kann IPv6 derzeit nicht aktivieren. Versuchen Sie es später erneut.',
      'invalid_ip_families':
          'Die Tunnelkonfiguration ist unvollständig oder entspricht nicht den autorisierten Adressen. Versuchen Sie es erneut in der App.',
      'other':
          'Ein Serverfehler ist aufgetreten. Versuchen Sie es später erneut.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Versuchen Sie es in Kürze erneut.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Versuchen Sie es in $seconds Sekunden erneut.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'System-VPN-Wiederaufnahme nicht verfügbar',
      'system_vpn_resume_corrupt': 'Ungültige System-VPN-Wiederaufnahme',
      'system_vpn_resume_session_invalid':
          'Ungültige VPN-Wiederaufnahmesitzung',
      'system_vpn_resume_identity_changed': 'VPN-Identität geändert',
      'system_vpn_resume_identity_invalid':
          'Ungültige VPN-Wiederaufnahmeidentität',
      'system_vpn_resume_storage_failed':
          'VPN-Wiederaufnahmespeicher nicht verfügbar',
      'system_vpn_resume_network_timeout': 'VPN-Wiederaufnahme ohne Netzwerk',
      'system_vpn_resume_blocked': 'VPN-Wiederaufnahme blockiert',
      'system_vpn_resume_failed': 'VPN-Wiederaufnahme fehlgeschlagen',
      'system_vpn_resume_error_invalid': 'Ungültiger VPN-Wiederaufnahmefehler',
      'wireguard_identity_store_failed':
          'WireGuard-Identität nicht gespeichert',
      'wireguard_identity_unavailable': 'WireGuard-Identität nicht verfügbar',
      'vpn_host_destroyed': 'Android-VPN-Host beendet',
      'vpn_host_unavailable': 'Android-VPN-Host nicht verfügbar',
      'vpn_permission_required': 'VPN-Berechtigung erforderlich',
      'vpn_permission_denied': 'VPN-Berechtigung abgelehnt',
      'vpn_permission_request_failed':
          'Berechtigung konnte nicht angefragt werden',
      'wireguard_foreground_service_unavailable':
          'WireGuard-Dienst nicht verfügbar',
      'wireguard_identity_invalid': 'Ungültiger lokaler WireGuard-Schlüssel',
      'wireguard_identity_in_use': 'WireGuard-Identität bereits verwendet',
      'wireguard_configuration_invalid': 'Ungültige WireGuard-Konfiguration',
      'wireguard_operation_pending': 'WireGuard-Vorgang noch aktiv',
      'wireguard_start_failed': 'WireGuard-Start abgelehnt',
      'wireguard_stop_timeout': 'WireGuard-Stopp nicht bestätigt',
      'wireguard_handshake_timeout': 'WireGuard antwortet nicht',
      'openvpn_connection_timeout': 'OpenVPN antwortet nicht',
      'openvpn_core_unavailable': 'OpenVPN-Engine nicht verfügbar',
      'openvpn_operation_pending': 'OpenVPN-Sitzung noch aktiv',
      'openvpn_stop_timeout': 'OpenVPN-Stopp nicht bestätigt',
      'openvpn_profile_unavailable': 'Lokales OpenVPN-Profil fehlt',
      'openvpn_native_failed': 'Nativer OpenVPN-Aufruf unterbrochen',
      'openvpn_key_generation_failed':
          'OpenVPN-P-256-Schlüssel konnte nicht erstellt werden',
      'openvpn_csr_generation_failed':
          'OpenVPN-CSR konnte nicht erstellt werden',
      'openvpn_identity_store_failed': 'OpenVPN-Identität nicht gespeichert',
      'openvpn_identity_clear_failed': 'OpenVPN unvollständig entfernt',
      'openvpn_identity_in_use': 'OpenVPN-Identität noch in Verwendung',
      'openvpn_tls_verification_required': 'OpenVPN-TLS-Prüfung fehlt',
      'openvpn_cipher_invalid': 'Ungültige OpenVPN-Verschlüsselung',
      'openvpn_profile_rejected': 'OpenVPN-Profil abgelehnt',
      'openvpn_identity_inconsistent': 'Inkonsistente OpenVPN-Identität',
      'tls_handshake_failed': 'OpenVPN-Aushandlung abgelehnt',
      'tls_alert_unknown_ca': 'OpenVPN-Clientzertifikat nicht erkannt',
      'tls_alert_bad_certificate': 'OpenVPN-Clientzertifikat abgelehnt',
      'tls_alert_unsupported_certificate':
          'OpenVPN-Zertifikat nicht unterstützt',
      'tls_client_certificate_required':
          'OpenVPN-Clientzertifikat erforderlich',
      'tls_alert_misc': 'OpenVPN-TLS-Warnung',
      'tls_signature_algorithm_rejected': 'OpenVPN-Signatur nicht unterstützt',
      'tls_handshake_rejected': 'OpenVPN-TLS-Aushandlung abgelehnt',
      'tls_version_rejected': 'OpenVPN-TLS-Version nicht kompatibel',
      'tls_certificate_expired': 'TLS-Zertifikat abgelaufen',
      'tls_certificate_revoked': 'TLS-Zertifikat widerrufen',
      'transport_failed': 'OpenVPN-Server nicht erreichbar',
      'tun_configuration_rejected':
          'OpenVPN-Schnittstelle konnte nicht erstellt werden',
      'tun_setup_failed': 'OpenVPN-TUN-Einrichtung fehlgeschlagen',
      'tun_interface_create_failed':
          'Erstellen der OpenVPN-Schnittstelle fehlgeschlagen',
      'tun_interface_disabled': 'OpenVPN-Schnittstelle deaktiviert',
      'tun_halted': 'OpenVPN-Schnittstelle unterbrochen',
      'tun_already_established': 'OpenVPN-Schnittstelle bereits geöffnet',
      'tun_addresses_missing': 'OpenVPN-Adresse fehlt',
      'tun_routes_missing': 'OpenVPN-Routen fehlen',
      'tun_dns_missing': 'OpenVPN-DNS fehlt',
      'tun_permission_revoked': 'VPN-Berechtigung widerrufen',
      'tun_establish_returned_null':
          'Android hat die VPN-Schnittstelle abgelehnt',
      'openvpn_service_start_failed': 'OpenVPN-Dienst nicht verfügbar',
      'openvpn_operation_timeout': 'OpenVPN-Aufruf abgelaufen',
      'openvpn_start_failed': 'OpenVPN-Start abgelehnt',
      'openvpn_connection_failed': 'OpenVPN-Verbindung unterbrochen',
      'openvpn_core_status_error': 'OpenVPN Core mit Fehler beendet',
      'openvpn_stopped_before_connected': 'OpenVPN vor der Verbindung beendet',
      'openvpn_auth_failed': 'OpenVPN-Authentifizierung abgelehnt',
      'openvpn_client_setup_failed':
          'OpenVPN-Clientvorbereitung fehlgeschlagen',
      'openvpn_client_halted': 'OpenVPN-Client unterbrochen',
      'openvpn_client_restart': 'OpenVPN-Neustart angefordert',
      'openvpn_inactive_timeout': 'OpenVPN zu lange inaktiv',
      'openvpn_session_expired': 'OpenVPN-Sitzung abgelaufen',
      'openvpn_credentials_required':
          'OpenVPN-Authentifizierung nicht unterstützt',
      'openvpn_proxy_failed': 'OpenVPN-Zwischentransport fehlgeschlagen',
      'openvpn_compression_failed': 'OpenVPN-Komprimierung abgelehnt',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN-NTLM-Verschlüsselung nicht verfügbar',
      'openvpn_feature_unsupported': 'OpenVPN-Funktion nicht unterstützt',
      'network_unavailable': 'Internetverbindung nicht verfügbar',
      'network_lost': 'Netzwerk nicht verfügbar',
      'certificate_validation_failed': 'Serverzertifikat abgelehnt',
      'openvpn_certificate_expired': 'OpenVPN-Zertifikat abgelaufen',
      'tunnel_active_for_another_account':
          'Tunnel eines anderen Kontos noch aktiv',
      'tunnel_already_active': 'Nativer Tunnel bereits aktiv',
      'tunnel_stop_timeout': 'Stopp von $protocol nicht bestätigt',
      'tunnel_disconnected': '$protocol unterbrochen',
      'native_bridge_unavailable': 'Android-Bridge nicht verfügbar',
      'native_operation_failed': 'Android-Vorgang unterbrochen',
      'invalid_arguments': 'Unvollständige VPN-Parameter',
      'invalid_account_id': 'Ungültiges VPN-Konto',
      'invalid_device_id': 'Ungültige Gerätekennung',
      'storage_key_not_allowed': 'Speicherschlüssel abgelehnt',
      'secure_storage_read_failed': 'Sicheres Lesen fehlgeschlagen',
      'secure_storage_write_failed': 'Sicheres Schreiben fehlgeschlagen',
      'key_generation_failed':
          'WireGuard-Schlüssel konnte nicht erstellt werden',
      'csr_generation_failed': 'OpenVPN-CSR konnte nicht erstellt werden',
      'other': 'Nicht klassifizierter nativer VPN-Fehler',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android findet keine fortsetzbare VPN-Sitzung. Starten Sie in der App eine neue Verbindung.',
      'system_vpn_resume_corrupt':
          'Die gespeicherten VPN-Wiederaufnahmedaten sind ungültig und werden nicht verwendet. Starten Sie eine neue Verbindung.',
      'system_vpn_resume_session_invalid':
          'Die gespeicherte Sitzung kann das VPN nicht mehr fortsetzen. Melden Sie sich in der App erneut an.',
      'system_vpn_resume_identity_changed':
          'Die lokale VPN-Identität wurde geändert. Die Wiederaufnahme wurde beendet; starten Sie eine neue Verbindung.',
      'system_vpn_resume_identity_invalid':
          'Die Identität für die Wiederaufnahme ist ungültig. Starten Sie eine neue Verbindung.',
      'system_vpn_resume_storage_failed':
          'Android konnte die verschlüsselten Wiederaufnahmedaten nicht lesen oder aktualisieren. Starten Sie eine neue Verbindung.',
      'system_vpn_resume_network_timeout':
          'Android hat nicht rechtzeitig ein Netzwerk gefunden, um das VPN fortzusetzen. Versuchen Sie es bei verfügbarem Netzwerk erneut.',
      'system_vpn_resume_blocked':
          'Die VPN-Wiederaufnahme ist blockiert. Prüfen Sie die Android-Einstellungen und starten Sie eine neue Verbindung.',
      'system_vpn_resume_failed':
          'Die Android-VPN-Wiederaufnahme ist fehlgeschlagen. Starten Sie in der App eine neue Verbindung.',
      'system_vpn_resume_error_invalid':
          'Android hat einen nicht verwendbaren Wiederaufnahmefehler zurückgegeben. Starten Sie eine neue Verbindung.',
      'wireguard_identity_store_failed':
          'Android konnte die verschlüsselte WireGuard-Identität dieses Kontos nicht speichern.',
      'wireguard_identity_unavailable':
          'Für diese Verbindung ist keine verwendbare WireGuard-Identität verfügbar.',
      'vpn_host_destroyed':
          'Die Android-Komponente für das VPN wurde beendet. Starten Sie eine neue Verbindung.',
      'vpn_host_unavailable':
          'Android kann die Komponente für das VPN nicht erstellen. Prüfen Sie die VPN-Einstellungen und versuchen Sie es erneut.',
      'openvpn_renewal_required':
          'Das Zertifikat erfordert vor dem Verbinden eine Aktion in der App.',
      'openvpn_recovery_failed':
          'Die automatische Wiederverbindung ist fehlgeschlagen. Starte eine neue Verbindung in der App.',
      'openvpn_recovery_exhausted':
          'Die automatische Wiederverbindung wurde bereits genutzt. Starte eine neue Verbindung in der App.',
      'vpn_permission_required':
          'Android verlangt vor dem Tunnelstart eine neue VPN-Berechtigung.',
      'vpn_permission_denied':
          'Erlauben Sie FuzeVPN in der Android-Anfrage, um fortzufahren.',
      'vpn_permission_request_failed':
          'Android konnte den Bildschirm für die VPN-Berechtigung nicht öffnen.',
      'wireguard_foreground_service_unavailable':
          'Android konnte den WireGuard-Dienst nicht im Vordergrund halten.',
      'wireguard_identity_invalid':
          'Der verschlüsselte WireGuard-Schlüssel dieses Kontos ist unlesbar oder ungültig.',
      'wireguard_identity_in_use':
          'Ein anderer Vorgang verwendet noch den WireGuard-Schlüssel dieses Kontos.',
      'wireguard_configuration_invalid':
          'Die empfangene WireGuard-Adresse, DNS-Angabe, Serverschlüssel oder Routen sind ungültig.',
      'wireguard_operation_pending':
          'Der vorherige WireGuard-Vorgang hat seinen nativen Dienst noch nicht freigegeben.',
      'wireguard_start_failed':
          'Die WireGuard-Engine hat die Aktivierung der Konfiguration abgelehnt.',
      'wireguard_stop_timeout':
          'Der WireGuard-Dienst hat die Freigabe der VPN-Schnittstelle nicht rechtzeitig bestätigt.',
      'wireguard_handshake_timeout':
          'Der Tunnel hat den Handshake mit dem Server nicht rechtzeitig bestätigt.',
      'openvpn_connection_timeout':
          'OpenVPN hat die Verbindung mit dem Server nicht rechtzeitig bestätigt.',
      'openvpn_core_unavailable':
          'Diese App-Version enthält keine verwendbare OpenVPN-Engine.',
      'openvpn_operation_pending':
          'Die native Engine hält die vorherige OpenVPN-Sitzung und verweigert eine zweite.',
      'openvpn_stop_timeout':
          'OpenVPN Core hat das Beenden und Zerstören seiner nativen Sitzung nicht rechtzeitig bestätigt.',
      'openvpn_profile_unavailable':
          'Für diese Verbindung kann kein geprüftes OpenVPN-Profil gelesen werden.',
      'openvpn_native_failed':
          'Ein App-Fehler hat OpenVPN unterbrochen. Versuche erneut, eine Verbindung herzustellen. Wenn das Problem bleibt, starte eine Diagnose.',
      'openvpn_key_generation_failed':
          'Android Keystore konnte den nicht exportierbaren privaten P-256-Schlüssel nicht erstellen oder lesen.',
      'openvpn_csr_generation_failed':
          'Der Android-Keystore-Schlüssel konnte die OpenVPN-Zertifikatsanforderung nicht signieren.',
      'openvpn_identity_store_failed':
          'OpenVPN-Zertifikat oder -Profil konnte nicht verschlüsselt gespeichert werden.',
      'openvpn_identity_clear_failed':
          'Android konnte die lokale OpenVPN-Identität dieses Kontos nicht vollständig löschen.',
      'openvpn_identity_in_use':
          'Eine native OpenVPN-Sitzung verwendet noch Schlüssel oder Zertifikat dieses Geräts.',
      'openvpn_tls_verification_required':
          'Das Profil verlangt nicht ausdrücklich die Prüfung des Serverzertifikats.',
      'openvpn_cipher_invalid':
          'Der Server hat einen Verschlüsselungsalgorithmus außerhalb der erlaubten Liste geliefert.',
      'openvpn_profile_rejected':
          'Das vom Server empfangene Profil ist nicht kompatibel. Legen Sie dieses Gerät neu an und versuchen Sie es erneut.',
      'openvpn_identity_inconsistent':
          'Das Zertifikat passt nicht zur sicheren Identität dieses Telefons. Kein lokales Profil wurde ersetzt.',
      'tls_handshake_failed':
          'Der Server hat die TLS-Aushandlung abgelehnt. Erstellen Sie das Profil neu, falls das Problem fortbesteht.',
      'tls_alert_unknown_ca':
          'Der Server erkennt die Zertifizierungsstelle dieses Gerätezertifikats nicht. Der OpenVPN-Server muss geprüft werden.',
      'tls_alert_bad_certificate':
          'Der Server hat das Zertifikat dieses Geräts abgelehnt. Legen Sie das Gerät vor einem neuen Versuch neu an.',
      'tls_alert_unsupported_certificate':
          'Der Server unterstützt den von Android verwendeten sicheren Zertifikatstyp nicht.',
      'tls_client_certificate_required':
          'Der Server verlangt ein Clientzertifikat, aber OpenVPN Core konnte keines vorlegen.',
      'tls_alert_misc':
          'Der Server hat eine TLS-Warnung außerhalb der Kategorien Zertifikat und Version geliefert.',
      'tls_signature_algorithm_rejected':
          'Der Server hat den ECDSA-P-256-Algorithmus des Android-Keystore-Schlüssels abgelehnt.',
      'tls_handshake_rejected':
          'Der Server hat die TLS-Aushandlung vor der Verbindung abgebrochen.',
      'tls_version_rejected':
          'Client und Server haben keine gemeinsame TLS-Version gefunden.',
      'tls_certificate_expired':
          'Das bei der Verbindung vorgelegte Zertifikat ist abgelaufen.',
      'tls_certificate_revoked':
          'Das bei der Verbindung vorgelegte Zertifikat wurde widerrufen.',
      'transport_failed':
          'Der OpenVPN-Server antwortet im aktuellen Netzwerk nicht. Versuchen Sie es in Kürze erneut.',
      'tun_configuration_rejected':
          'Android hat die von OpenVPN angeforderte Netzwerkkonfiguration abgelehnt.',
      'tun_setup_failed':
          'OpenVPN Core hat den Netzwerkplan vor dem Erstellen der Android-Schnittstelle abgelehnt.',
      'tun_interface_create_failed':
          'OpenVPN Core konnte die TUN-Schnittstelle nicht vom Android VpnService erhalten.',
      'tun_interface_disabled':
          'Android oder OpenVPN Core hat die TUN-Schnittstelle während der Verbindung deaktiviert.',
      'tun_halted':
          'OpenVPN Core hat eine Anforderung zum Beenden der TUN-Schnittstelle erhalten.',
      'tun_already_established':
          'OpenVPN hat in derselben Verbindung eine zweite Schnittstelle angefordert. Der Tunnel wurde zur Sicherheit beendet.',
      'tun_addresses_missing':
          'Der Server hat keine verwendbare Tunneladresse geliefert.',
      'tun_routes_missing':
          'Der Server hat keine verwendbaren Tunnelrouten geliefert.',
      'tun_dns_missing':
          'Der Server hat keinen verwendbaren DNS-Server geliefert.',
      'tun_permission_revoked':
          'Android hat die VPN-Berechtigung während der Verbindung entzogen.',
      'tun_establish_returned_null':
          'Android hat die Schnittstelle nicht erstellt, meist weil noch ein anderes VPN aktiv ist.',
      'openvpn_service_start_failed':
          'Android konnte den OpenVPN-Vordergrunddienst nicht starten.',
      'openvpn_operation_timeout':
          'Ein JNI-Aufruf an OpenVPN Core hat seine maximale Dauer überschritten.',
      'openvpn_start_failed':
          'Der Android-Dienst ist bereit, aber OpenVPN Core hat den Profilstart nicht akzeptiert.',
      'openvpn_connection_failed':
          'OpenVPN Core wurde beendet, bevor das Ereignis CONNECTED ausgegeben wurde.',
      'openvpn_core_status_error':
          'Die native OpenVPN-Schleife endete mit einem Fehler ohne genaueres Endereignis.',
      'openvpn_stopped_before_connected':
          'Die native OpenVPN-Schleife wurde vor CONNECTED ohne ausdrücklichen Core-Fehler beendet.',
      'openvpn_auth_failed':
          'Der OpenVPN-Server hat die Profilauthentifizierung abgelehnt.',
      'openvpn_client_setup_failed':
          'OpenVPN Core konnte den Client vor der Netzwerkverbindung nicht initialisieren.',
      'openvpn_client_halted':
          'OpenVPN Core hat einen endgültigen Clientstopp erhalten.',
      'openvpn_client_restart':
          'OpenVPN Core hat einen Neustart seiner Transportsitzung angefordert.',
      'openvpn_inactive_timeout':
          'OpenVPN Core hat die Sitzung nach Ablauf des Inaktivitätslimits beendet.',
      'openvpn_session_expired':
          'Der Server hat den Ablauf der OpenVPN-Sitzung gemeldet.',
      'openvpn_credentials_required':
          'Server oder Proxy verlangt interaktive Zugangsdaten, die in diesem Zertifikatsprofil fehlen.',
      'openvpn_proxy_failed':
          'OpenVPN Core hat einen Fehler des eingerichteten Proxys oder Relays gemeldet.',
      'openvpn_compression_failed':
          'OpenVPN Core hat den vom Profil oder Server angekündigten Komprimierungsmodus abgelehnt.',
      'openvpn_ntlm_crypto_unavailable':
          'Das Profil verlangt eine NTLM-Verschlüsselung, die in dieser Version nicht verfügbar ist.',
      'openvpn_feature_unsupported':
          'Profil oder Server verlangt eine Funktion, die diesem Android-Client fehlt.',
      'network_unavailable':
          'Es ist kein verwendbares physisches Netzwerk verfügbar.',
      'network_lost':
          'Der Tunnel wurde nach dem Verlust des Netzwerks beendet.',
      'certificate_validation_failed':
          'Die Identität des OpenVPN-Servers konnte nicht geprüft werden.',
      'openvpn_certificate_expired':
          'Erneuern Sie das OpenVPN-Profil vor der nächsten Verbindung.',
      'tunnel_active_for_another_account':
          'Ein Tunnel eines anderen Kontos muss vor dieser Verbindung beendet werden.',
      'tunnel_already_active':
          'Android meldet, dass eine vorherige VPN-Sitzung die Schnittstelle noch verwendet.',
      'tunnel_stop_timeout':
          'Die $protocol-Engine hat die Freigabe der VPN-Schnittstelle nicht rechtzeitig bestätigt.',
      'tunnel_disconnected':
          'Die native Engine meldete nach dem Start ein unerwartetes Ende des Tunnels.',
      'native_bridge_unavailable':
          'Die App kann nicht auf den Android-VPN-Dienst zugreifen. Schließe die App, öffne sie erneut und versuche es noch einmal.',
      'native_operation_failed':
          'Ein App-Fehler hat den VPN-Vorgang unterbrochen. Versuche es erneut. Wenn das Problem bleibt, starte eine Diagnose.',
      'invalid_arguments':
          'Die für diesen VPN-Vorgang benötigten Angaben sind unvollständig. Versuche es erneut. Wenn das Problem bleibt, starte eine Diagnose.',
      'invalid_account_id':
          'Der native Vorgang ist keiner gültigen Kontokennung zugeordnet.',
      'invalid_device_id':
          'Die an die native Engine übertragene Gerätekennung fehlt oder ist ungültig.',
      'storage_key_not_allowed':
          'Die Android-Bridge hat einen Schlüssel außerhalb der erlaubten Speicherliste blockiert.',
      'secure_storage_read_failed':
          'Android Keystore konnte die lokalen Daten dieses Kontos nicht entschlüsseln.',
      'secure_storage_write_failed':
          'Android Keystore konnte die lokalen Daten nicht verschlüsseln oder speichern.',
      'key_generation_failed':
          'Android konnte den WireGuard-Schlüssel im sicheren Speicher nicht erstellen oder lesen.',
      'csr_generation_failed':
          'Android Keystore konnte den OpenVPN-P-256-CSR nicht erstellen oder signieren.',
      'other':
          'Ein nicht dokumentierter nativer Zweig ist fehlgeschlagen. Senden Sie den unten angezeigten Diagnosecode an den Support.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Berechtigungsanfrage bereits geöffnet';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Die Android-Anfrage zur VPN-Berechtigung wird bereits angezeigt. Schließen Sie sie vor einem neuen Versuch ab.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-Berechtigungsanfrage unterbrochen';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Der Bildschirm zur VPN-Berechtigung wurde geschlossen, bevor die App eine Antwort erhielt.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-Verbindung nicht bestätigt';

  @override
  String get notice_openvpnProofMissing_message =>
      'Die OpenVPN-Verbindung konnte nicht bestätigt werden. Sie wurde aus Sicherheitsgründen beendet. Versuche es erneut.';

  @override
  String get openvpnCleanup_title => 'OpenVPN-Profil widerrufen';

  @override
  String get openvpnCleanup_working =>
      'Das widerrufene OpenVPN-Profil wird beendet und entfernt…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Das Beenden von OpenVPN wurde nicht bestätigt. Versuchen Sie es erneut, bevor Sie ein neues Profil erstellen.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Das widerrufene OpenVPN-Profil konnte nicht vollständig entfernt werden. Wiederholen Sie die Bereinigung.';

  @override
  String get openvpnCleanup_complete =>
      'Das widerrufene OpenVPN-Profil wurde entfernt. Tippen Sie auf Verbinden, um ein neues zu erstellen.';

  @override
  String get network_title => 'Netzwerkkonfiguration';

  @override
  String get network_ipv4Fallback =>
      'IPv6 ist vorübergehend nicht verfügbar. Die Vorbereitung wird mit IPv4 fortgesetzt.';

  @override
  String get network_rejectedTitle => 'Netzwerkkonfiguration abgelehnt';

  @override
  String get network_rejectedMessage =>
      'Die Tunnelkonfiguration ist unvollständig oder entspricht nicht den autorisierten Adressen. Versuchen Sie es erneut in der App.';

  @override
  String get network_unreadableTitle => 'Lokale Konfiguration nicht lesbar';

  @override
  String get network_unreadableMessage =>
      'Die gespeicherte OpenVPN-Netzwerkkonfiguration kann nicht verwendet werden. Verbinden Sie sich erneut über die App, um sie zu aktualisieren.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Netzwerkschutz';

  @override
  String get protection_subtitle =>
      'Blockiere den direkten Internetzugang, wenn das VPN unterbrochen wird.';

  @override
  String get protection_active => 'Systemschutz aktiv';

  @override
  String get protection_alwaysOnOnly =>
      'Dauerhaftes VPN aktiv; Blockierung außerhalb des VPN einschalten';

  @override
  String get protection_inactive => 'Systemschutz inaktiv';

  @override
  String get protection_unknown => 'Systemschutz prüfen';

  @override
  String get protection_openSettings => 'Android-Einstellungen öffnen';

  @override
  String get protection_dialogTitle => 'Netzwerkschutz einrichten';

  @override
  String get protection_dialogMessage =>
      'Android verwaltet das dauerhafte VPN und das Blockieren von Verbindungen außerhalb des VPN. Prüfen Sie, dass FuzeVPN ausgewählt ist, und aktivieren Sie die Blockierung in den Systemeinstellungen.';

  @override
  String get protection_dialogOpen => 'Einstellungen öffnen';

  @override
  String get session_systemProtectionNote =>
      'Wenn Android den Verkehr außerhalb des VPN weiterhin blockiert, öffnen Sie die Systemeinstellungen, um diesen Schutz zu prüfen oder zu ändern.';

  @override
  String get diagnostics_title => 'Diagnose';

  @override
  String get diagnostics_settingsTitle => 'App-Diagnose';

  @override
  String get diagnostics_automaticTitle => 'Wichtige Fehler senden';

  @override
  String get diagnostics_automaticDescription =>
      'Teile einen kurzen technischen Bericht, wenn ein wichtiger Fehler auftritt.';

  @override
  String get diagnostics_privacy =>
      'Gesendete Berichte sind mit dem angemeldeten Konto verknüpft und werden 30 Tage gespeichert. Sie enthalten keinen Browserverlauf, keine Passwörter und keine VPN-Schlüssel.';

  @override
  String get diagnostics_manualOpen => 'Diagnose starten';

  @override
  String get diagnostics_localDescription =>
      'Erstelle einen Bericht zum Zustand der App und des VPN. Deine Verbindung bleibt unverändert.';

  @override
  String get diagnostics_sendReport => 'Bericht senden';

  @override
  String get diagnostics_sendHint =>
      'Lassen Sie dieses Feld deaktiviert, um den Bericht auf diesem Gerät zu behalten.';

  @override
  String get diagnostics_signedOut =>
      'Melden Sie sich an, um einen Bericht zu senden.';

  @override
  String get diagnostics_localLifetime =>
      'Speichere diesen Bericht auf deinem Telefon, um ihn nach dem Schließen der App zu behalten.';

  @override
  String get diagnostics_run => 'Diagnose starten';

  @override
  String get diagnostics_rerun => 'Diagnose wiederholen';

  @override
  String get diagnostics_running => 'Prüfung läuft…';

  @override
  String get diagnostics_sending => 'Bericht wird gesendet…';

  @override
  String get diagnostics_prepared => 'Bericht auf diesem Gerät bereit';

  @override
  String get diagnostics_queued => 'Bericht wartet auf Versand';

  @override
  String get diagnostics_sent => 'Bericht erhalten';

  @override
  String get diagnostics_failed =>
      'Senden fehlgeschlagen. Der lokale Bericht ist weiterhin verfügbar.';

  @override
  String get diagnostics_preparationFailed =>
      'Der Diagnosebericht konnte nicht erstellt werden. Versuchen Sie es erneut.';

  @override
  String get diagnostics_authenticationRequired =>
      'Melden Sie sich erneut an, um den Bericht zu senden.';

  @override
  String get diagnostics_retry => 'Senden wiederholen';

  @override
  String get diagnostics_export => 'Bericht speichern';

  @override
  String get diagnostics_exportFailed =>
      'Export fehlgeschlagen. Versuchen Sie es mit dem lokalen Bericht erneut.';

  @override
  String get diagnostics_preferenceFailed =>
      'Diese Einstellung konnte nicht gespeichert werden. Versuchen Sie es erneut.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referenz: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Erhalten am $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Gespeichert bis $date';
  }

  @override
  String get diagnostics_duplicate => 'Dieser Bericht wurde bereits erhalten.';

  @override
  String get diagnostics_preview => 'Berichtsvorschau';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count technische Ereignisse angehängt',
      one: '1 technisches Ereignis angehängt',
      zero: 'Keine technischen Ereignisse angehängt',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Technische Details';

  @override
  String get diagnostics_empty =>
      'Es wurde noch kein Diagnosebericht erstellt.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunnelstatus',
      'handshake': 'Verbindungsbestätigung',
      'certificate': 'VPN-Zertifikat',
      'kill_switch': 'Android-Schutz',
      'connectivity': 'Verfügbares Netzwerk',
      'api_reachability': 'Dienstzugriff',
      'secure_storage': 'Sicherer Speicher',
      'other': 'Lokale Prüfung',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Geprüft',
      'failed': 'Prüfung erforderlich',
      'skipped': 'Nicht getestet — keine aktive Prüfung',
      'unknown': 'Information nicht verfügbar',
      'other': 'Information nicht verfügbar',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Willkommen bei FuzeVPN';

  @override
  String get connection_changeLocation => 'Standort ändern';

  @override
  String get connection_details => 'Verbindungsdetails';

  @override
  String get locations_searchLabel => 'Stadt oder Land suchen';

  @override
  String get locations_clearSearch => 'Suche löschen';

  @override
  String get locations_filterAll => 'Alle';

  @override
  String get locations_filterFavorites => 'Favoriten';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Standorte',
      one: '$count Standort',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Keine Standorte gefunden';

  @override
  String get locations_noResultsHint =>
      'Versuche eine andere Stadt oder ein anderes Land.';

  @override
  String get locations_noFavorites => 'Deine Favoriten, schnell erreichbar';

  @override
  String get locations_noFavoritesHint =>
      'Tippe auf den Stern neben einem Standort, um ihn hier zu speichern.';

  @override
  String get locations_showAll => 'Alle Standorte anzeigen';

  @override
  String locations_addFavorite(String name) {
    return '$name zu Favoriten hinzufügen';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name aus Favoriten entfernen';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Der Favorit konnte nicht gespeichert werden. Versuche es erneut.';

  @override
  String get locations_emptyTitle => 'Keine Standorte verfügbar';

  @override
  String get locations_emptyHint =>
      'Aktualisiere die Liste, um es erneut zu versuchen.';

  @override
  String get devices_manage => 'Meine Geräte verwalten';

  @override
  String get settings_personalization => 'Ganz nach deinem Geschmack';

  @override
  String get settings_safety => 'Schutz';

  @override
  String get settings_help => 'Brauchst du Hilfe?';

  @override
  String get settings_about => 'Über FuzeVPN';

  @override
  String get diagnostics_heading => 'Ein Verbindungsproblem verstehen';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Verfügbar',
      'pending': 'Wird vorbereitet',
      'revoked': 'Entfernt',
      'expired': 'Abgelaufen',
      'other': 'Status nicht verfügbar',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Einstellung nicht gespeichert';

  @override
  String get notice_preferenceSave_message =>
      'Deine Auswahl gilt vorerst, konnte aber nicht gespeichert werden. Versuche es erneut, damit sie nach dem Schließen der App erhalten bleibt.';

  @override
  String get connection_androidDisconnectHint =>
      'Wenn Android das VPN aktiv hält, deaktiviere „Durchgehend aktives VPN“ in den Einstellungen, die sich öffnen.';

  @override
  String get protection_learnMore => 'Android-Schutz verstehen';

  @override
  String get protection_guideWhy =>
      'Dieser Schutz verhindert, dass Apps bei einer VPN-Unterbrechung direkt auf das Internet zugreifen. Du richtest ihn in Android ein.';

  @override
  String get protection_guideAlwaysOnTitle => 'Durchgehend aktives VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android hält den VPN-Dienst aktiv und kann ihn nach einem Neustart des Telefons erneut starten.';

  @override
  String get protection_guideBlockTitle => 'Verbindungen ohne VPN blockieren';

  @override
  String get protection_guideBlock =>
      'Diese Einstellung verhindert, dass Daten am VPN vorbeigeleitet werden, auch während einer Verbindungsunterbrechung.';

  @override
  String get protection_guideWarning =>
      'Wenn diese Sperre aktiviert ist, bleibt der Internetzugang gesperrt, bis das VPN verbunden ist.';

  @override
  String get protection_guideStepsTitle => 'Schutz aktivieren';

  @override
  String get protection_guideStep1 =>
      'Öffne die Android-VPN-Einstellungen mit der Schaltfläche unten.';

  @override
  String get protection_guideStep2 =>
      'Öffne die Optionen über das Zahnradsymbol neben FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Aktiviere „Durchgehend aktives VPN“ und dann „Verbindungen ohne VPN blockieren“, sofern diese Optionen verfügbar sind.';

  @override
  String get protection_guideManufacturers =>
      'Die Bezeichnungen unterscheiden sich je nach Telefon. Suche bei Bedarf in den Einstellungen nach „VPN“, häufig unter Netzwerk & Internet.';

  @override
  String get protection_guideDisableTitle => 'Diesen Schutz deaktivieren';

  @override
  String get protection_guideDisable =>
      'Deaktiviere dort die Sperre ohne VPN, um Internetzugang ohne VPN zuzulassen. Deaktiviere auch das durchgehend aktive VPN, wenn Android es nicht mehr neu starten soll.';

  @override
  String get protection_guideManual =>
      'Du wählst diese Einstellungen in Android. FuzeVPN ändert sie nicht für dich.';

  @override
  String get locations_changeTitle => 'Standort wechseln?';

  @override
  String locations_changeActive(String name) {
    return 'Das VPN wird getrennt und versucht dann, eine Verbindung zu $name herzustellen.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'Das VPN versucht, eine Verbindung zu $name herzustellen.';
  }

  @override
  String get locations_confirmChange => 'Wechseln und verbinden';

  @override
  String get locations_changeBusy =>
      'Ein Wechsel läuft bereits. Warte, bevor du einen anderen Standort auswählst.';

  @override
  String get locations_automaticSelection => 'Automatische Auswahl';

  @override
  String get locations_cities => 'Städte';

  @override
  String get locations_servers => 'Server';

  @override
  String locations_viewCities(String name) {
    return 'Städte in $name anzeigen';
  }

  @override
  String locations_viewServers(String name) {
    return 'Server in $name anzeigen';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Länder',
      one: '$count Land',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Städte',
      one: '$count Stadt',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Server',
      one: '$count Server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Alle Länder';

  @override
  String get locations_backToCountries => 'Zurück zu den Ländern';

  @override
  String locations_backToCities(String name) {
    return 'Zurück zu den Städten in $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name auswählen';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name auswählen';
  }

  @override
  String get locations_noCompatibleServer =>
      'Kein kompatibler Server verfügbar.';

  @override
  String get externalLink_failed =>
      'Dieser Link konnte nicht geöffnet werden. Sie können ihn kopieren und im Browser öffnen.';

  @override
  String get externalLink_copy => 'Link kopieren';

  @override
  String get externalLink_copied => 'Link kopiert';

  @override
  String get externalLink_copyFailed =>
      'Der Link konnte nicht kopiert werden. Wählen Sie die Adresse unten aus.';

  @override
  String get settings_deleteAccount => 'Mein Konto löschen';

  @override
  String get settings_deleteAccountDetail =>
      'Anleitung zum Beantragen der Kontolöschung ansehen';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Wählen Sie Ihr VPN-Abonnement.';

  @override
  String get billing_subscribe => 'Abonnieren';

  @override
  String get billing_choosePlan => 'Wählen Sie einen Tarif, um fortzufahren.';

  @override
  String get billing_monthly => 'Monatlich';

  @override
  String get billing_yearly => 'Jährlich';

  @override
  String get billing_continue => 'Mit Google Play fortfahren';

  @override
  String get billing_restore => 'Käufe wiederherstellen';

  @override
  String get billing_manage => 'Abonnement verwalten';

  @override
  String get billing_deleteAccountWarning =>
      'Wenn Sie ein Google Play-Abonnement haben, deaktiviert das Löschen Ihres FuzeVPN-Kontos dessen Verlängerung nicht. Verwalten oder deaktivieren Sie die Verlängerung separat in Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Weiter zur Anfrage zur Kontolöschung';

  @override
  String get billing_refresh => 'Zugriff aktualisieren';

  @override
  String get billing_loadingPlans => 'Tarife werden geladen…';

  @override
  String get billing_unavailable =>
      'Derzeit sind keine Tarife verfügbar. Versuchen Sie es später erneut.';

  @override
  String get billing_comingSoon => 'Abonnements sind bald verfügbar.';

  @override
  String get billing_priceDisclosure =>
      'Preis von Google Play. Der endgültige Betrag wird vor der Zahlung bestätigt.';

  @override
  String get billing_renewalMonthly =>
      'Automatische Verlängerung jeden Monat, sofern nicht gekündigt. Sie können jederzeit in den Google Play-Abonnements kündigen.';

  @override
  String get billing_renewalYearly =>
      'Automatische Verlängerung jedes Jahr, sofern nicht gekündigt. Sie können jederzeit in den Google Play-Abonnements kündigen.';

  @override
  String get billing_active => 'Ihr Premium-Zugriff ist aktiv';

  @override
  String billing_accessUntil(String date) {
    return 'Zugriff bis $date.';
  }

  @override
  String get billing_webManaged =>
      'Ihr Abonnement wird auf der FuzeVPN-Website verwaltet.';

  @override
  String get billing_playManaged =>
      'Ihr Abonnement wird über Google Play verwaltet.';

  @override
  String get billing_inactive => 'Kein aktives Abonnement.';

  @override
  String get billing_checkingAccess => 'Zugriff wird geprüft…';

  @override
  String get billing_restoring => 'Käufe werden wiederhergestellt…';

  @override
  String get billing_pending =>
      'Die Zahlung steht aus. Ihr Zugriff wird nach der Bestätigung aktiviert.';

  @override
  String get billing_cancelled =>
      'Kauf abgebrochen. Kein neues Abonnement wurde aktiviert.';

  @override
  String get billing_verifying => 'Kauf wird geprüft…';

  @override
  String get billing_success =>
      'Abonnement aktiviert. Ihr Premium-Zugriff ist bereit.';

  @override
  String get billing_restored => 'Ihre Käufe wurden wiederhergestellt.';

  @override
  String get billing_restoreEmpty =>
      'Keine Käufe für dieses Google Play-Konto wiederherzustellen.';

  @override
  String get billing_catalogError =>
      'Tarife konnten nicht geladen werden. Versuchen Sie es erneut.';

  @override
  String get billing_purchaseError =>
      'Kauf konnte nicht gestartet werden. Versuchen Sie es erneut.';

  @override
  String get billing_verificationError =>
      'Die Kaufprüfung ist vorübergehend nicht verfügbar. Stellen Sie die Käufe wieder her, um es erneut zu versuchen.';

  @override
  String get billing_restoreError =>
      'Käufe konnten nicht wiederhergestellt werden. Versuchen Sie es erneut.';

  @override
  String get billing_managementError =>
      'Abonnementverwaltung konnte nicht geöffnet werden. Versuchen Sie es erneut.';

  @override
  String get billing_storeUnavailable =>
      'Google Play ist auf diesem Gerät nicht verfügbar.';

  @override
  String get welcome_title => 'Dein VPN, ganz einfach.';

  @override
  String get welcome_description =>
      'Schütze deine Verbindung. Behalte die Kontrolle über deine Privatsphäre.';

  @override
  String get welcome_start => 'Loslegen';

  @override
  String get welcome_alreadyPurchased => 'Bereits gekauft?';

  @override
  String get welcome_noAccountRequired => 'Zum Starten brauchst du kein Konto.';

  @override
  String get guest_accountTitle => 'Konto nicht verknüpft';

  @override
  String get guest_accountDescription =>
      'Stelle deine Käufe mit demselben Google Play-Konto wieder her, um dein Abo auf einem anderen Gerät zu nutzen.';

  @override
  String get guest_existingSubscriberSignIn => 'Bereits abonniert? Anmelden';

  @override
  String get guest_claimTitle => 'FuzeVPN überall nutzen';

  @override
  String get guest_claimDescription =>
      'Erstelle ein Konto, um dein Abo auf weiteren Geräten zu nutzen. Dieser Schritt ist optional.';

  @override
  String get guest_skip => 'Später';

  @override
  String get guest_activationTitle => 'Fuze Premium ist aktiv';

  @override
  String get guest_activationDescription =>
      'Dein Abo ist bereit. Nutze dein VPN und erstelle ein Konto, wann du möchtest.';

  @override
  String get guest_useVpn => 'Mein VPN nutzen';

  @override
  String get guest_loginRequired =>
      'Dieser Kauf ist bereits mit einem FuzeVPN-Konto verknüpft. Melde dich bei diesem Konto an, um dein Abo zu nutzen.';

  @override
  String get guest_signOutWarning =>
      'Du kannst dein Abo wiederherstellen, indem du deine Käufe mit demselben Google Play-Konto wiederherstellst.';

  @override
  String get guest_profileUnavailable =>
      'Dein Konto ist bereits verknüpft. Melde dich an, um deine Daten anzuzeigen und zu verwalten.';

  @override
  String get billing_acceptance =>
      'Indem du fortfährst, akzeptierst du die Nutzungsbedingungen und die Datenschutzerklärung.';

  @override
  String get guest_verifyEmailReminder =>
      'Bestätige deine E-Mail-Adresse, um dein Konto abzusichern. Du kannst dein VPN weiterhin nutzen.';

  @override
  String get guest_serviceUnavailable =>
      'Der Dienst ist vorübergehend nicht verfügbar. Versuche es gleich noch einmal.';

  @override
  String get guest_restoreError =>
      'Deine Käufe konnten nicht wiederhergestellt werden. Versuche es mit dem Google Play-Konto, das du für den Kauf verwendet hast.';

  @override
  String get guest_claimSuccess =>
      'Dein Konto wurde erstellt. Dein Abo und dein VPN-Zugang bleiben erhalten.';

  @override
  String get guest_emailExists =>
      'Diese E-Mail-Adresse wird bereits verwendet. Wähle eine andere Adresse oder melde dich bei deinem vorhandenen Konto an. Dein Kauf bleibt über Google Play verfügbar.';

  @override
  String get guest_claimError =>
      'Dein Konto konnte nicht erstellt werden. Du kannst dein VPN weiterhin nutzen und es später noch einmal versuchen.';

  @override
  String get guest_secureStorageError =>
      'Deine Sitzung konnte auf diesem Gerät nicht abgesichert werden. Versuche es erneut.';

  @override
  String get guest_premiumRequired =>
      'Wähle ein Abo, um dein VPN zu aktivieren.';

  @override
  String get welcome_viewPlans => 'Tarife ansehen';

  @override
  String get google_continue => 'Mit Google fortfahren';

  @override
  String get google_or => 'oder';

  @override
  String get google_title => 'Ihr FuzeVPN-Konto';

  @override
  String get google_settingUp => 'Konto fertigstellen';

  @override
  String get google_country => 'Wohnsitzland';

  @override
  String get google_profileDescription =>
      'Wählen Sie Ihr Land und lesen Sie beide Dokumente, um Ihr FuzeVPN-Konto zu erstellen.';

  @override
  String get google_claimDescription =>
      'Verknüpfen Sie Ihr Gastkonto mit Google. Abonnement und Gerät bleiben diesem Konto zugeordnet.';

  @override
  String get google_linkTitle => 'Google mit FuzeVPN verknüpfen';

  @override
  String get google_linkDescription =>
      'Bestätigen Sie den Zugriff auf Ihr bestehendes FuzeVPN-Konto. Ihr Google-Passwort wird nicht abgefragt.';

  @override
  String get google_password => 'FuzeVPN-Passwort';

  @override
  String get google_linkAccount => 'Verknüpfung bestätigen';

  @override
  String get google_requestEmail => 'Bestätigungs-E-Mail erhalten';

  @override
  String get google_emailInstructions =>
      'Öffnen Sie die E-Mail von FuzeVPN und geben Sie den Bestätigungscode ein.';

  @override
  String get google_emailCode => 'Bestätigungscode aus der E-Mail';

  @override
  String get google_confirmEmail => 'Code bestätigen';

  @override
  String get google_restart => 'Anderes Google-Konto wählen';

  @override
  String get google_resume => 'Diesen Versuch prüfen';

  @override
  String get google_unavailable =>
      'Die Google-Anmeldung ist nicht verfügbar. Sie können E-Mail und Passwort verwenden.';

  @override
  String get google_expired =>
      'Dieser Versuch ist abgelaufen. Brechen Sie ihn ab und beginnen Sie erneut.';

  @override
  String get google_conflict =>
      'Dieses Google-Konto ist bereits anderweitig verknüpft. Ihr aktuelles Konto und Abonnement bleiben erhalten.';

  @override
  String get google_error =>
      'Die Google-Anmeldung ist fehlgeschlagen. Versuchen Sie es erneut; Ihr aktueller Zugriff bleibt erhalten.';

  @override
  String get google_uncertain =>
      'Das Ergebnis konnte nicht bestätigt werden. Prüfen Sie diesen Versuch oder brechen Sie ihn vor einem Neustart ab.';

  @override
  String get google_cancelFailed =>
      'Der Abbruch konnte nicht bestätigt werden. Versuchen Sie erneut abzubrechen, bevor Sie diese Seite verlassen.';

  @override
  String get google_cancelled => 'Google-Anmeldung abgebrochen.';

  @override
  String get google_selecting => 'Wählen Sie Ihr Google-Konto…';

  @override
  String get google_verifying => 'Konto wird geprüft…';

  @override
  String get google_emailUnavailable =>
      'Die Bestätigungs-E-Mail konnte nicht gesendet werden. Versuchen Sie es später erneut.';

  @override
  String get google_emailSent =>
      'Bestätigungs-E-Mail gesendet. Prüfen Sie Ihren Posteingang.';

  @override
  String get google_rateLimited => 'Bitte warten Sie vor einem neuen Versuch.';

  @override
  String get google_invalidPassword =>
      'Das FuzeVPN-Passwort ist falsch. Ihr aktuelles Konto bleibt erhalten.';

  @override
  String get google_invalidCode =>
      'Der Bestätigungscode ist ungültig oder abgelaufen.';

  @override
  String get google_accountChanged =>
      'Die Sitzung hat sich geändert. Brechen Sie diesen Versuch vor einem Neustart ab.';

  @override
  String get google_invalidResponse =>
      'Die Antwort konnte nicht geprüft werden. Ihr aktueller Zugriff bleibt erhalten.';

  @override
  String get google_invalidRegistration =>
      'Prüfen Sie das Land und beide Zustimmungen.';

  @override
  String get google_consentRequired =>
      'Wählen Sie Ihr Land und stimmen Sie beiden Dokumenten zu, um fortzufahren.';

  @override
  String get google_challengeRequired =>
      'Eine zusätzliche Sicherheitsprüfung ist erforderlich. Ihr aktueller Zugriff bleibt erhalten.';

  @override
  String get google_challengeUnavailable =>
      'Die Sicherheitsprüfung ist nicht verfügbar. Versuchen Sie es später erneut.';
}
