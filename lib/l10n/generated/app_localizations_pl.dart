// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get accountRestoration_title => 'Konto tymczasowo niedostępne';

  @override
  String get accountRestoration_message =>
      'Twoja sesja została zachowana. Spróbuj ponownie, aby przywrócić konto; nadal możesz tutaj zarządzać połączeniem VPN.';

  @override
  String get action_retry => 'Spróbuj ponownie';

  @override
  String get session_endingTitle => 'Kończenie sesji';

  @override
  String get session_ending =>
      'Twoja sesja została unieważniona. Zatrzymywanie VPN i czyszczenie sesji…';

  @override
  String get session_stopFailed =>
      'Zatrzymanie VPN nie zostało potwierdzone. Spróbuj ponownie przed kolejnym logowaniem.';

  @override
  String get session_cleanupFailed =>
      'VPN jest zatrzymany, ale usunięcie sesji nie zostało potwierdzone. Spróbuj ponownie wyczyścić sesję.';

  @override
  String get session_retryStop => 'Spróbuj ponownie zatrzymać';

  @override
  String get session_retryCleanup => 'Spróbuj ponownie wyczyścić';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Bezpieczne przygotowywanie FuzeVPN…';

  @override
  String get nav_connection => 'Połączenie';

  @override
  String get nav_locations => 'Lokalizacje';

  @override
  String get nav_account => 'Konto';

  @override
  String get nav_devices => 'Urządzenia';

  @override
  String get nav_settings => 'Ustawienia';

  @override
  String get action_refresh => 'Odśwież';

  @override
  String get auth_tab_login => 'Zaloguj się';

  @override
  String get auth_tab_register => 'Zarejestruj się';

  @override
  String get auth_stepAccount => 'Konto';

  @override
  String get auth_stepIdentity => 'Tożsamość';

  @override
  String get auth_stepAddress => 'Adres i zgody';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Krok $current z $total';
  }

  @override
  String get auth_tagline => 'Twój VPN, po prostu.';

  @override
  String get auth_keysLocal =>
      'Twoje prywatne klucze VPN pozostają na tym urządzeniu.';

  @override
  String get form_email => 'Adres e-mail';

  @override
  String get form_password => 'Hasło';

  @override
  String get form_showPassword => 'Pokaż hasło';

  @override
  String get form_hidePassword => 'Ukryj hasło';

  @override
  String get form_passwordMin =>
      '8–72 bajty UTF-8. Niektóre znaki zajmują więcej niż jeden bajt.';

  @override
  String get form_firstName => 'Imię';

  @override
  String get form_lastName => 'Nazwisko';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adres';

  @override
  String get form_address2 => 'Drugi wiersz adresu (opcjonalnie)';

  @override
  String get form_postalCode => 'Kod pocztowy';

  @override
  String get form_city => 'Miasto';

  @override
  String get form_country => 'Kod kraju (np. PL)';

  @override
  String get action_login => 'Zaloguj się';

  @override
  String get action_createAccount => 'Utwórz konto';

  @override
  String get action_createMyAccount => 'Utwórz moje konto';

  @override
  String get action_next => 'Dalej';

  @override
  String get action_previous => 'Wstecz';

  @override
  String get action_forgotPassword => 'Nie pamiętasz hasła?';

  @override
  String get auth_noAccount => 'Nie masz jeszcze konta?';

  @override
  String get auth_requiredInformation => 'Utwórz konto w trzech krokach.';

  @override
  String get auth_termsPrefix => 'Akceptuję ';

  @override
  String get auth_termsLink => 'warunki korzystania';

  @override
  String get auth_privacyPrefix => 'Akceptuję ';

  @override
  String get auth_privacyLink => 'politykę prywatności';

  @override
  String get auth_consentRequired =>
      'Aby utworzyć konto, wymagana jest Twoja zgoda.';

  @override
  String get validation_required => 'To pole jest wymagane.';

  @override
  String get validation_email => 'Wpisz prawidłowy adres e-mail.';

  @override
  String get validation_password =>
      'Hasło jest za krótkie: musi mieć co najmniej 8 bajtów UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Hasło jest za długie: może mieć najwyżej 72 bajty UTF-8.';

  @override
  String get validation_phone =>
      'Użyj formatu międzynarodowego, na przykład +33612345678.';

  @override
  String get validation_country =>
      'Użyj dwuliterowego kodu kraju, na przykład PL.';

  @override
  String get passwordReset_title => 'Resetowanie hasła';

  @override
  String get passwordReset_description =>
      'Wpisz adres e-mail powiązany z kontem, aby poprosić o link do zresetowania hasła.';

  @override
  String get passwordReset_send => 'Wyślij link';

  @override
  String get connection_title => 'Twoje połączenie';

  @override
  String get connection_subtitle =>
      'Wybierz lokalizację, a następnie włącz VPN.';

  @override
  String get connection_prepare => 'Gotowy, aby się połączyć?';

  @override
  String get connection_advancedOptions => 'Opcje zaawansowane';

  @override
  String get connection_location => 'Lokalizacja';

  @override
  String get connection_chooseLocation => 'Wybierz lokalizację';

  @override
  String get connection_protocol => 'Protokół';

  @override
  String get connection_connect => 'Połącz';

  @override
  String get connection_connecting => 'Łączenie…';

  @override
  String get connection_disconnect => 'Rozłącz';

  @override
  String get connection_disconnecting => 'Rozłączanie';

  @override
  String get connection_locationChange => 'Zmiana lokalizacji…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol niedostępny';
  }

  @override
  String get connection_activeLocation => 'Aktywna lokalizacja';

  @override
  String get connection_duration => 'Czas trwania';

  @override
  String get connection_received => 'Odebrane';

  @override
  String get connection_sent => 'Wysłane';

  @override
  String get connection_lastHandshake => 'Ostatnia bezpieczna wymiana';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration temu';
  }

  @override
  String get verification_title => 'Potwierdź swój adres e-mail';

  @override
  String get verification_message =>
      'Potwierdź swój adres e-mail, aby korzystać z VPN na tym telefonie.';

  @override
  String get verification_resend => 'Wyślij e-mail ponownie';

  @override
  String get migration_title => 'Zmiana lokalizacji';

  @override
  String get migration_draining => 'Przygotowywanie zmiany lokalizacji…';

  @override
  String get migration_activating => 'Aktywowanie nowego serwera…';

  @override
  String get migration_ready => 'Lokalizacja została zaktualizowana.';

  @override
  String get migration_blocked =>
      'Zmiana lokalizacji wymaga interwencji serwera. Spróbuj ponownie później lub skontaktuj się z pomocą techniczną.';

  @override
  String get migration_progress => 'Postęp zmiany lokalizacji';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Opóźnienie między sprawdzeniami: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Wznów zmianę lokalizacji';

  @override
  String get status_authorizing => 'Wymagane uprawnienie';

  @override
  String get status_authorizingDetail =>
      'Zaakceptuj żądanie Androida, aby zezwolić na VPN.';

  @override
  String get status_preparing => 'Przygotowywanie';

  @override
  String get status_preparingDetail =>
      'Przygotowywanie bezpiecznego połączenia.';

  @override
  String get status_reconnecting => 'Ponowne łączenie…';

  @override
  String get status_reconnectingDetail =>
      'Połączenie zostało przerwane. VPN próbuje połączyć się ponownie.';

  @override
  String get status_connecting => 'Łączenie';

  @override
  String get status_connectingDetail => 'Łączenie z serwerem VPN…';

  @override
  String get status_connected => 'Połączono';

  @override
  String get status_connectedDetail => 'Twoje połączenie VPN jest aktywne.';

  @override
  String get status_disconnecting => 'Rozłączanie';

  @override
  String get status_disconnectingDetail =>
      'Twoje połączenie VPN jest zatrzymywane.';

  @override
  String get status_error => 'Połączenie niedostępne';

  @override
  String get status_errorDetail =>
      'Połączenie VPN nie zostało potwierdzone. Spróbuj ponownie.';

  @override
  String get status_idle => 'Rozłączono';

  @override
  String get status_idleDetail => 'Połącz VPN, aby chronić swoje połączenie.';

  @override
  String get trust_note =>
      'Zamknięcie aplikacji nie zatrzymuje VPN. Aby go zatrzymać, użyj opcji Rozłącz.';

  @override
  String get locations_none => 'Obecnie nie ma dostępnych lokalizacji.';

  @override
  String get locations_available => 'Wybierz następną lokalizację.';

  @override
  String get locations_selected => 'Wybrana lokalizacja';

  @override
  String get locations_select => 'Wybierz tę lokalizację';

  @override
  String get locations_lockedTunnel => 'Rozłącz VPN, aby zmienić lokalizację.';

  @override
  String get locations_lockedMigration =>
      'Poczekaj na zakończenie zmiany lokalizacji.';

  @override
  String get devices_title => 'Twoje urządzenia';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit urządzeń';
  }

  @override
  String get devices_refresh => 'Odśwież urządzenia';

  @override
  String get devices_empty =>
      'Nie zarejestrowano jeszcze żadnego urządzenia VPN.';

  @override
  String get devices_firstConnection =>
      'Twój telefon zostanie dodany przy pierwszym połączeniu.';

  @override
  String get devices_thisDevice => 'To urządzenie';

  @override
  String devices_added(Object date) {
    return 'Dodano $date';
  }

  @override
  String get action_remove => 'Usuń';

  @override
  String get settings_title => 'Ustawienia';

  @override
  String get settings_subtitle => 'Twoje preferencje i konto w jednym miejscu.';

  @override
  String get settings_appearance => 'Wygląd';

  @override
  String get settings_language => 'Język';

  @override
  String get settings_languageDescription =>
      'Wybrany język dotyczy również powiadomień VPN.';

  @override
  String get settings_account => 'Konto';

  @override
  String get settings_signOut => 'Wyloguj się';

  @override
  String get settings_privacy => 'Polityka prywatności';

  @override
  String get settings_terms => 'Warunki korzystania';

  @override
  String get settings_security => 'Bezpieczeństwo i przejrzystość';

  @override
  String get settings_licenses => 'Licencje komponentów';

  @override
  String get settings_licensesDetail => 'Oprogramowanie używane w aplikacji';

  @override
  String get settings_background =>
      'VPN pozostaje włączony po opuszczeniu aplikacji. Aby go zatrzymać, użyj opcji Rozłącz na karcie Połączenie.';

  @override
  String get theme_system => 'Systemowy';

  @override
  String get theme_light => 'Jasny';

  @override
  String get theme_dark => 'Ciemny';

  @override
  String get language_system => 'Język telefonu';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Usunąć to urządzenie?';

  @override
  String get dialog_removeCurrent =>
      'Ten telefon zostanie rozłączony z VPN i utraci dostęp. Dane jego połączenia VPN zostaną usunięte po potwierdzeniu przez serwer.';

  @override
  String dialog_removeOther(Object name) {
    return 'Dostęp VPN dla „$name” zostanie odebrany. Tej czynności nie można cofnąć.';
  }

  @override
  String get dialog_signOut => 'Wylogować się?';

  @override
  String get dialog_signOutMessage =>
      'VPN zostanie zatrzymany i trzeba będzie zalogować się ponownie. Twoje zaszyfrowane klucze VPN pozostaną na tym telefonie na potrzeby następnego połączenia.';

  @override
  String get action_cancel => 'Anuluj';

  @override
  String get action_signOut => 'Wyloguj się';

  @override
  String get notice_close => 'Odrzuć komunikat';

  @override
  String get notice_sessionExpired_title => 'Sesja wygasła';

  @override
  String get notice_sessionExpired_message =>
      'Twoja sesja wygasła. Zaloguj się ponownie.';

  @override
  String get notice_connectionFailed_title => 'Połączenie nie powiodło się';

  @override
  String get notice_invalidCredentials_message =>
      'Adres e-mail lub hasło są nieprawidłowe.';

  @override
  String get notice_emailVerification_title =>
      'Wymagane potwierdzenie adresu e-mail';

  @override
  String get notice_emailVerification_message =>
      'Potwierdź swój adres e-mail przed dodaniem urządzenia VPN.';

  @override
  String get notice_rateLimited_title => 'Zbyt wiele prób';

  @override
  String get notice_deviceLimit_title => 'Osiągnięto limit 2 urządzeń';

  @override
  String get notice_deviceLimit_message =>
      'Usuń istniejące urządzenie przed dodaniem kolejnego.';

  @override
  String get notice_identityRenewal_title => 'Tożsamość VPN wymaga odnowienia';

  @override
  String get notice_identityRenewal_message =>
      'Ta tożsamość została usunięta. Utwórz nową tożsamość lokalną.';

  @override
  String get notice_migrationPending_title => 'Trwa zmiana lokalizacji';

  @override
  String get notice_migrationPending_message => 'Zmiana lokalizacji już trwa.';

  @override
  String get notice_migrationBlocked_title => 'Zmiana lokalizacji zablokowana';

  @override
  String get notice_migrationBlocked_message =>
      'Zmiana lokalizacji wymaga interwencji serwera. Spróbuj ponownie później lub skontaktuj się z pomocą techniczną.';

  @override
  String get notice_targetUnavailable_title => 'Serwer tymczasowo niedostępny';

  @override
  String get notice_targetUnavailable_message =>
      'Ten serwer jest tymczasowo niedostępny.';

  @override
  String get notice_networkUnavailable_title =>
      'Połączenie z internetem niedostępne';

  @override
  String get notice_networkUnavailable_message =>
      'Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get notice_permissionDenied_title => 'Odmowa uprawnienia VPN';

  @override
  String get notice_permissionDenied_message =>
      'Uruchom połączenie ponownie i zaakceptuj żądanie uprawnienia Androida.';

  @override
  String get notice_wireguardTimeout_title => 'Serwer nie odpowiada';

  @override
  String get notice_wireguardTimeout_message =>
      'Połączenie WireGuard trwało zbyt długo. Spróbuj ponownie lub wybierz inną lokalizację.';

  @override
  String get notice_tlsFailed_title => 'Odmowa bezpiecznego połączenia';

  @override
  String get notice_tlsFailed_message =>
      'Serwer nie zaakceptował połączenia OpenVPN. Spróbuj ponownie. Jeśli problem będzie się powtarzał, uruchom diagnostykę.';

  @override
  String get notice_tunRejected_title => 'Android odrzucił interfejs VPN';

  @override
  String get notice_tunRejected_message =>
      'Android odrzucił konfigurację sieci żądaną przez OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Nie można uruchomić OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'Silnik OpenVPN nie zdołał dokończyć uruchamiania. Spróbuj ponownie. Jeśli problem będzie się powtarzał, skontaktuj się z pomocą techniczną.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kod diagnostyczny: $code';
  }

  @override
  String get notice_generic_title => 'Połączenie VPN nie powiodło się';

  @override
  String get notice_generic_message =>
      'Wystąpił błąd. Spróbuj ponownie później.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Konto utworzone',
      'password_reset_sent': 'Otrzymano prośbę o zresetowanie hasła',
      'verification_email_sent': 'Wysłano e-mail weryfikacyjny',
      'location_migration_pending': 'Trwa zmiana lokalizacji',
      'vpn_sign_in_required': 'Wymagane logowanie',
      'protocol_unavailable_at_location': 'Protokół niedostępny',
      'vpn_permission_denied': 'Odmowa uprawnienia VPN',
      'revoked_identity_device_limit': 'Osiągnięto limit 2 urządzeń',
      'tunnel_start_unexpected': 'Nie można uruchomić VPN',
      'flutter_disconnect_timeout': 'Nie potwierdzono rozłączenia',
      'flutter_disconnect_unexpected': 'Nie można rozłączyć',
      'device_revoked': 'Urządzenie usunięte',
      'revoke_unexpected': 'Nie można usunąć urządzenia',
      'identity_renewal_unexpected': 'Nie można odnowić tożsamości',
      'openvpn_renewal_unexpected': 'Nie można odnowić OpenVPN',
      'location_migration_blocked': 'Zmiana lokalizacji zablokowana',
      'location_migration_slow': 'Zmiana lokalizacji nadal trwa',
      'location_migration_conflict': 'Zmiana lokalizacji wymaga odświeżenia',
      'location_migration_verification_failed':
          'Nie potwierdzono zmiany lokalizacji',
      'location_migration_device_changed':
          'Urządzenie zmieniło się podczas zmiany lokalizacji',
      'tunnel_stop_failed': 'Zmiana lokalizacji niedostępna',
      'other': 'Operacja nie powiodła się',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Konto zostało utworzone, ale nie można było wysłać e-maila weryfikacyjnego. Użyj opcji ponownego wysłania w aplikacji.',
      'password_reset_sent':
          'Otrzymaliśmy Twoją prośbę. Jeśli konto jest powiązane z tym adresem, możesz otrzymać e-mail. Sprawdź również folder spamu.',
      'verification_email_sent': 'Właśnie wysłano nowy e-mail weryfikacyjny.',
      'location_migration_pending':
          'Przygotowanie przeniesienia do $target nadal trwa. Możesz je wznowić bez ponownego tworzenia urządzenia.',
      'vpn_sign_in_required': 'Zaloguj się na konto przed uruchomieniem VPN.',
      'protocol_unavailable_at_location':
          'Wybrany protokół nie jest oferowany w tej lokalizacji. Odśwież lokalizacje lub wybierz inny protokół.',
      'vpn_permission_denied':
          'Android odmówił uprawnienia VPN. Uruchom połączenie ponownie i zaakceptuj żądanie systemu.',
      'revoked_identity_device_limit':
          'Dostęp VPN tego urządzenia został usunięty, a limit urządzeń został osiągnięty. Usuń urządzenie w sekcji Konto → Zarządzaj moimi urządzeniami.',
      'tunnel_start_unexpected':
          'Nieoczekiwany błąd przerwał przygotowanie tunelu. Sprawdź kod diagnostyczny i spróbuj ponownie.',
      'flutter_disconnect_timeout':
          'Android nie potwierdził na czas zatrzymania VPN. Spróbuj zatrzymać go ponownie.',
      'flutter_disconnect_unexpected':
          'Nieoczekiwany błąd uniemożliwił potwierdzenie zatrzymania tunelu.',
      'device_revoked':
          'Dostęp VPN urządzenia został odebrany, a jego lokalne dane poufne usunięto.',
      'revoke_unexpected':
          'Nie można było usunąć urządzenia. Odśwież listę i spróbuj ponownie.',
      'identity_renewal_unexpected':
          'Nie można było utworzyć nowej tożsamości VPN. Odśwież urządzenia i spróbuj ponownie.',
      'openvpn_renewal_unexpected':
          'Nie można było odnowić profilu OpenVPN. Spróbuj ponownie lub sprawdź kod diagnostyczny.',
      'location_migration_blocked':
          'Serwer nie może teraz dokończyć tej zmiany. Urządzenie i jego lokalna tożsamość zostały zachowane.',
      'location_migration_slow':
          'Serwer nadal przygotowuje przeniesienie do $target. Za chwilę użyj opcji Wznów.',
      'location_migration_conflict':
          'Stan urządzenia zmienił się na serwerze. Odśwież urządzenia, a następnie wznów zmianę.',
      'location_migration_verification_failed':
          'Serwer nie potwierdził nowej lokalizacji. Poprzednia lokalna tożsamość została zachowana.',
      'location_migration_device_changed':
          'Urządzenie zwrócone przez serwer nie jest już zgodne ze zmienianym urządzeniem. Odśwież urządzenia przed ponowną próbą.',
      'tunnel_stop_failed':
          'Poprzedni tunel musi zostać całkowicie zatrzymany przed nawiązaniem nowego połączenia.',
      'other':
          'Nie można było ukończyć operacji. Spróbuj ponownie lub wyślij kod diagnostyczny do pomocy technicznej.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesja wygasła',
      'invalid_credentials': 'Logowanie nie powiodło się',
      'email_verification_required': 'Wymagane potwierdzenie adresu e-mail',
      'verification_email_cooldown': 'E-mail został już wysłany',
      'rate_limited': 'Zbyt wiele prób',
      'invalid_registration': 'Należy poprawić informacje',
      'email_exists': 'Konto już istnieje',
      'invalid_profile': 'Nieprawidłowy profil',
      'invalid_device': 'Nieprawidłowe urządzenie',
      'invalid_location': 'Lokalizacja niedostępna',
      'device_limit': 'Osiągnięto limit 2 urządzeń',
      'device_exists': 'Tożsamość VPN jest już używana',
      'device_identity_revoked': 'Tożsamość VPN wymaga odnowienia',
      'device_location_locked': 'Zmiana lokalizacji wymaga odświeżenia',
      'location_migration_pending': 'Trwa zmiana lokalizacji',
      'location_migration_blocked': 'Zmiana lokalizacji zablokowana',
      'target_ca_mismatch': 'Niekompatybilny serwer OpenVPN',
      'location_migration_conflict': 'Zmiana lokalizacji wymaga odświeżenia',
      'server_full': 'Serwer jest pełny',
      'capacity_unavailable': 'Lokalizacja tymczasowo niedostępna',
      'target_unavailable': 'Serwer tymczasowo niedostępny',
      'not_found': 'Nie znaleziono elementu',
      'invalid_openvpn_csr': 'Nieprawidłowa tożsamość OpenVPN',
      'openvpn_profile_exists': 'Profil OpenVPN już istnieje',
      'openvpn_profile_revoked': 'Profil OpenVPN odebrany',
      'openvpn_operation_pending': 'Trwa operacja OpenVPN',
      'openvpn_operation_terminal': 'Operacja OpenVPN przerwana',
      'openvpn_address_unavailable': 'Adres OpenVPN niedostępny',
      'openvpn_profile_conflict': 'Konflikt OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN niedostępny',
      'email_delivery_unavailable': 'E-mail niedostępny',
      'invalid_token': 'Nieprawidłowy link',
      'network_unavailable': 'Połączenie z internetem niedostępne',
      'invalid_json': 'Nieprawidłowe żądanie',
      'invalid_api_response': 'Nieprawidłowa odpowiedź serwera',
      'ipv6_unavailable': 'IPv6 niedostępny',
      'invalid_ip_families': 'Odrzucono konfigurację sieci',
      'other': 'Usługa niedostępna',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Twoja sesja wygasła. Zaloguj się ponownie.',
      'invalid_credentials': 'Adres e-mail lub hasło są nieprawidłowe.',
      'email_verification_required':
          'Potwierdź swój adres e-mail przed dodaniem urządzenia VPN.',
      'invalid_registration': 'Sprawdź wymagane informacje i zgody.',
      'email_exists': 'Z tym adresem e-mail jest już powiązane konto.',
      'invalid_profile': 'Sprawdź informacje w swoim profilu.',
      'invalid_device':
          'Nazwa tego urządzenia lub jego lokalna tożsamość jest nieprawidłowa.',
      'invalid_location': 'Odśwież listę lokalizacji i spróbuj ponownie.',
      'device_limit': 'Usuń istniejące urządzenie przed dodaniem kolejnego.',
      'device_exists': 'Ta tożsamość VPN jest już powiązana z innym kontem.',
      'device_identity_revoked':
          'Ta tożsamość została usunięta. Należy utworzyć nową tożsamość lokalną.',
      'device_location_locked':
          'Lokalizacja tego urządzenia właśnie się zmieniła. Aplikacja wznowi trwającą zmianę.',
      'location_migration_pending': 'Zmiana lokalizacji już trwa.',
      'location_migration_blocked':
          'Zmiana lokalizacji wymaga interwencji serwera. Spróbuj ponownie później lub skontaktuj się z pomocą techniczną.',
      'target_ca_mismatch':
          'Ten serwer nie jest jeszcze zgodny z bieżącym profilem OpenVPN.',
      'location_migration_conflict':
          'Odśwież urządzenia, a następnie spróbuj ponownie zmienić lokalizację.',
      'server_full':
          'Ta lokalizacja osiągnęła limit połączeń. Wybierz inną lokalizację lub spróbuj ponownie później.',
      'capacity_unavailable':
          'Nie możemy teraz potwierdzić, czy ta lokalizacja jest dostępna. Wybierz inną lokalizację lub spróbuj ponownie później.',
      'target_unavailable': 'Ten serwer jest tymczasowo niedostępny.',
      'not_found': 'Ten element nie jest już dostępny na Twoim koncie.',
      'invalid_openvpn_csr':
          'Utwórz nową tożsamość OpenVPN i spróbuj ponownie.',
      'openvpn_profile_exists':
          'Profil OpenVPN już istnieje dla tego urządzenia.',
      'openvpn_profile_revoked': 'Odnów profil OpenVPN, aby kontynuować.',
      'openvpn_operation_pending':
          'Zmiana jest nadal wdrażana. Spróbuj ponownie później.',
      'openvpn_operation_terminal':
          'Utwórz nową tożsamość OpenVPN i spróbuj ponownie.',
      'openvpn_address_unavailable':
          'Obecnie nie ma dostępnego adresu OpenVPN.',
      'openvpn_profile_conflict':
          'Profil został zmieniony. Odśwież urządzenia i spróbuj ponownie.',
      'openvpn_signer_unavailable':
          'Usługa OpenVPN jest tymczasowo niedostępna.',
      'email_delivery_unavailable':
          'Nie można było wysłać e-maila. Spróbuj ponownie później.',
      'invalid_token': 'Ten link jest nieprawidłowy lub wygasł. Poproś o nowy.',
      'network_unavailable':
          'Sprawdź połączenie z internetem i spróbuj ponownie.',
      'invalid_json': 'Sprawdź wprowadzone informacje i spróbuj ponownie.',
      'invalid_api_response':
          'Serwer zwrócił nieoczekiwaną odpowiedź. Spróbuj ponownie później.',
      'ipv6_unavailable':
          'Serwer nie może obecnie aktywować IPv6. Spróbuj ponownie później.',
      'invalid_ip_families':
          'Konfiguracja tunelu jest niekompletna lub nie pasuje do autoryzowanych adresów. Spróbuj ponownie z poziomu aplikacji.',
      'other': 'Wystąpił błąd serwera. Spróbuj ponownie później.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Spróbuj ponownie za chwilę.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Spróbuj ponownie za $seconds sekund.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Wznowienie systemowego VPN niedostępne',
      'system_vpn_resume_corrupt': 'Nieprawidłowe wznowienie systemowego VPN',
      'system_vpn_resume_session_invalid': 'Nieprawidłowa sesja wznowienia VPN',
      'system_vpn_resume_identity_changed': 'Tożsamość VPN zmieniona',
      'system_vpn_resume_identity_invalid':
          'Nieprawidłowa tożsamość wznowienia VPN',
      'system_vpn_resume_storage_failed': 'Pamięć wznowienia VPN niedostępna',
      'system_vpn_resume_network_timeout':
          'Wznowienie VPN bez dostępu do sieci',
      'system_vpn_resume_blocked': 'Wznowienie VPN zablokowane',
      'system_vpn_resume_failed': 'Wznowienie VPN nie powiodło się',
      'system_vpn_resume_error_invalid': 'Nieprawidłowy błąd wznowienia VPN',
      'wireguard_identity_store_failed': 'Nie zapisano tożsamości WireGuard',
      'wireguard_identity_unavailable': 'Tożsamość WireGuard niedostępna',
      'vpn_host_destroyed': 'Host VPN systemu Android zatrzymany',
      'vpn_host_unavailable': 'Host VPN systemu Android niedostępny',
      'vpn_permission_required': 'Wymagane uprawnienie VPN',
      'vpn_permission_denied': 'Odmowa uprawnienia VPN',
      'vpn_permission_request_failed': 'Nie można było poprosić o uprawnienie',
      'wireguard_foreground_service_unavailable':
          'Usługa WireGuard niedostępna',
      'wireguard_identity_invalid': 'Nieprawidłowy lokalny klucz WireGuard',
      'wireguard_identity_in_use': 'Tożsamość WireGuard jest już używana',
      'wireguard_configuration_invalid': 'Nieprawidłowa konfiguracja WireGuard',
      'wireguard_operation_pending': 'Operacja WireGuard nadal trwa',
      'wireguard_start_failed': 'Odrzucono uruchomienie WireGuard',
      'wireguard_stop_timeout': 'Nie potwierdzono zatrzymania WireGuard',
      'wireguard_handshake_timeout': 'WireGuard nie odpowiedział',
      'openvpn_connection_timeout': 'OpenVPN nie odpowiedział',
      'openvpn_core_unavailable': 'Silnik OpenVPN niedostępny',
      'openvpn_operation_pending': 'Sesja OpenVPN nadal trwa',
      'openvpn_stop_timeout': 'Nie potwierdzono zatrzymania OpenVPN',
      'openvpn_profile_unavailable': 'Brak lokalnego profilu OpenVPN',
      'openvpn_native_failed': 'Przerwano natywne wywołanie OpenVPN',
      'openvpn_key_generation_failed':
          'Nie można było utworzyć klucza OpenVPN P-256',
      'openvpn_csr_generation_failed':
          'Nie można było utworzyć żądania CSR OpenVPN',
      'openvpn_identity_store_failed': 'Nie zapisano tożsamości OpenVPN',
      'openvpn_identity_clear_failed': 'Niepełne usunięcie OpenVPN',
      'openvpn_identity_in_use': 'Tożsamość OpenVPN jest nadal używana',
      'openvpn_tls_verification_required': 'Brak weryfikacji TLS OpenVPN',
      'openvpn_cipher_invalid': 'Nieprawidłowy szyfr OpenVPN',
      'openvpn_profile_rejected': 'Odrzucono profil OpenVPN',
      'openvpn_identity_inconsistent': 'Niespójna tożsamość OpenVPN',
      'tls_handshake_failed': 'Odrzucono negocjację OpenVPN',
      'tls_alert_unknown_ca': 'Nie rozpoznano certyfikatu klienta OpenVPN',
      'tls_alert_bad_certificate': 'Odrzucono certyfikat klienta OpenVPN',
      'tls_alert_unsupported_certificate': 'Nieobsługiwany certyfikat OpenVPN',
      'tls_client_certificate_required': 'Wymagany certyfikat klienta OpenVPN',
      'tls_alert_misc': 'Alert TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Nieobsługiwany podpis OpenVPN',
      'tls_handshake_rejected': 'Odrzucono negocjację TLS OpenVPN',
      'tls_version_rejected': 'Niekompatybilna wersja TLS OpenVPN',
      'tls_certificate_expired': 'Certyfikat TLS wygasł',
      'tls_certificate_revoked': 'Certyfikat TLS został odebrany',
      'transport_failed': 'Serwer OpenVPN nieosiągalny',
      'tun_configuration_rejected':
          'Nie można było utworzyć interfejsu OpenVPN',
      'tun_setup_failed': 'Konfiguracja TUN OpenVPN nie powiodła się',
      'tun_interface_create_failed':
          'Nie można było utworzyć interfejsu OpenVPN',
      'tun_interface_disabled': 'Interfejs OpenVPN wyłączony',
      'tun_halted': 'Interfejs OpenVPN przerwany',
      'tun_already_established': 'Interfejs OpenVPN jest już otwarty',
      'tun_addresses_missing': 'Brak adresu OpenVPN',
      'tun_routes_missing': 'Brak tras OpenVPN',
      'tun_dns_missing': 'Brak DNS OpenVPN',
      'tun_permission_revoked': 'Uprawnienie VPN odebrane',
      'tun_establish_returned_null': 'Android odrzucił interfejs VPN',
      'openvpn_service_start_failed': 'Usługa OpenVPN niedostępna',
      'openvpn_operation_timeout': 'Upłynął limit czasu wywołania OpenVPN',
      'openvpn_start_failed': 'Odrzucono uruchomienie OpenVPN',
      'openvpn_connection_failed': 'Połączenie OpenVPN przerwane',
      'openvpn_core_status_error': 'OpenVPN Core zakończył działanie z błędem',
      'openvpn_stopped_before_connected':
          'OpenVPN zatrzymany przed połączeniem',
      'openvpn_auth_failed': 'Odrzucono uwierzytelnianie OpenVPN',
      'openvpn_client_setup_failed':
          'Konfiguracja klienta OpenVPN nie powiodła się',
      'openvpn_client_halted': 'Klient OpenVPN przerwany',
      'openvpn_client_restart': 'Zażądano ponownego uruchomienia OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN był nieaktywny zbyt długo',
      'openvpn_session_expired': 'Sesja OpenVPN wygasła',
      'openvpn_credentials_required': 'Nieobsługiwane uwierzytelnianie OpenVPN',
      'openvpn_proxy_failed': 'Transport pośredniczący OpenVPN nie powiódł się',
      'openvpn_compression_failed': 'Odrzucono kompresję OpenVPN',
      'openvpn_ntlm_crypto_unavailable': 'Szyfrowanie NTLM OpenVPN niedostępne',
      'openvpn_feature_unsupported': 'Nieobsługiwana funkcja OpenVPN',
      'network_unavailable': 'Połączenie z internetem niedostępne',
      'network_lost': 'Sieć niedostępna',
      'certificate_validation_failed': 'Odrzucono certyfikat serwera',
      'openvpn_certificate_expired': 'Certyfikat OpenVPN wygasł',
      'tunnel_active_for_another_account':
          'Tunel innego konta jest nadal aktywny',
      'tunnel_already_active': 'Natywny tunel jest już aktywny',
      'tunnel_stop_timeout': 'Nie potwierdzono zatrzymania $protocol',
      'tunnel_disconnected': '$protocol przerwany',
      'native_bridge_unavailable': 'Most systemu Android niedostępny',
      'native_operation_failed': 'Operacja systemu Android przerwana',
      'invalid_arguments': 'Niepełne parametry VPN',
      'invalid_account_id': 'Nieprawidłowe konto VPN',
      'invalid_device_id': 'Nieprawidłowy identyfikator urządzenia',
      'storage_key_not_allowed': 'Odrzucono klucz pamięci',
      'secure_storage_read_failed':
          'Nie można było odczytać bezpiecznej pamięci',
      'secure_storage_write_failed':
          'Nie można było zapisać w bezpiecznej pamięci',
      'key_generation_failed': 'Nie można było wygenerować klucza WireGuard',
      'csr_generation_failed': 'Nie można było wygenerować żądania CSR OpenVPN',
      'other': 'Niesklasyfikowany natywny błąd VPN',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android nie może znaleźć sesji VPN, którą można wznowić. Rozpocznij nowe połączenie w aplikacji.',
      'system_vpn_resume_corrupt':
          'Zapisane dane wznowienia VPN są nieprawidłowe i nie zostaną użyte. Rozpocznij nowe połączenie.',
      'system_vpn_resume_session_invalid':
          'Zapisana sesja nie może już wznowić VPN. Zaloguj się ponownie w aplikacji.',
      'system_vpn_resume_identity_changed':
          'Lokalna tożsamość VPN zmieniła się. Wznowienie zatrzymano; rozpocznij nowe połączenie.',
      'system_vpn_resume_identity_invalid':
          'Tożsamość używana do wznowienia jest nieprawidłowa. Rozpocznij nowe połączenie.',
      'system_vpn_resume_storage_failed':
          'Android nie mógł odczytać ani zaktualizować zaszyfrowanych danych wznowienia. Rozpocznij nowe połączenie.',
      'system_vpn_resume_network_timeout':
          'Android nie znalazł na czas sieci, aby wznowić VPN. Spróbuj ponownie, gdy sieć będzie dostępna.',
      'system_vpn_resume_blocked':
          'Wznowienie VPN jest zablokowane. Sprawdź ustawienia Androida, a następnie rozpocznij nowe połączenie.',
      'system_vpn_resume_failed':
          'Wznowienie VPN systemu Android nie powiodło się. Rozpocznij nowe połączenie w aplikacji.',
      'system_vpn_resume_error_invalid':
          'Android zwrócił nieużyteczny błąd wznowienia. Rozpocznij nowe połączenie.',
      'wireguard_identity_store_failed':
          'Android nie mógł zapisać zaszyfrowanej tożsamości WireGuard tego konta.',
      'wireguard_identity_unavailable':
          'Dla tego połączenia nie ma dostępnej użytecznej tożsamości WireGuard.',
      'vpn_host_destroyed':
          'Zatrzymano komponent Androida obsługujący VPN. Rozpocznij nowe połączenie.',
      'vpn_host_unavailable':
          'Android nie może utworzyć komponentu obsługującego VPN. Spróbuj ponownie po sprawdzeniu ustawień VPN.',
      'openvpn_renewal_required':
          'Przed połączeniem certyfikat wymaga działania w aplikacji.',
      'openvpn_recovery_failed':
          'Automatyczne odzyskiwanie nie powiodło się. Rozpocznij nowe połączenie w aplikacji.',
      'openvpn_recovery_exhausted':
          'Automatyczne odzyskiwanie zostało już użyte. Rozpocznij nowe połączenie w aplikacji.',
      'vpn_permission_required':
          'Android wymaga nowej autoryzacji VPN przed uruchomieniem tunelu.',
      'vpn_permission_denied':
          'Zezwól aplikacji FuzeVPN w żądaniu Androida, aby kontynuować.',
      'vpn_permission_request_failed':
          'Android nie mógł otworzyć ekranu uprawnienia VPN.',
      'wireguard_foreground_service_unavailable':
          'Android nie mógł utrzymać usługi WireGuard na pierwszym planie.',
      'wireguard_identity_invalid':
          'Zaszyfrowany klucz WireGuard tego konta jest nieczytelny lub nieprawidłowy.',
      'wireguard_identity_in_use':
          'Inna operacja nadal używa klucza WireGuard tego konta.',
      'wireguard_configuration_invalid':
          'Otrzymany adres WireGuard, DNS, klucz serwera lub trasy są nieprawidłowe.',
      'wireguard_operation_pending':
          'Poprzednia operacja WireGuard nie zwolniła jeszcze natywnej usługi.',
      'wireguard_start_failed':
          'Silnik WireGuard odrzucił aktywację konfiguracji.',
      'wireguard_stop_timeout':
          'Usługa WireGuard nie potwierdziła zwolnienia interfejsu VPN w wyznaczonym czasie.',
      'wireguard_handshake_timeout':
          'Tunel nie potwierdził na czas uzgodnienia z serwerem.',
      'openvpn_connection_timeout':
          'OpenVPN nie potwierdził na czas połączenia z serwerem.',
      'openvpn_core_unavailable':
          'Ta wersja aplikacji nie zawiera użytecznego silnika OpenVPN.',
      'openvpn_operation_pending':
          'Natywny silnik nadal utrzymuje poprzednią sesję OpenVPN i odmawia utworzenia drugiej.',
      'openvpn_stop_timeout':
          'OpenVPN Core nie potwierdził zatrzymania i zniszczenia swojej natywnej sesji w wyznaczonym czasie.',
      'openvpn_profile_unavailable':
          'Nie można odczytać zweryfikowanego profilu OpenVPN dla tego połączenia.',
      'openvpn_native_failed':
          'Błąd aplikacji przerwał działanie OpenVPN. Spróbuj połączyć się ponownie. Jeśli problem będzie się powtarzał, uruchom diagnostykę.',
      'openvpn_key_generation_failed':
          'Android Keystore nie mógł utworzyć ani odczytać nieeksportowalnego klucza prywatnego P-256.',
      'openvpn_csr_generation_failed':
          'Klucz Android Keystore nie mógł podpisać żądania certyfikatu OpenVPN.',
      'openvpn_identity_store_failed':
          'Nie można było zapisać certyfikatu ani profilu OpenVPN w zaszyfrowanej pamięci.',
      'openvpn_identity_clear_failed':
          'Android nie mógł usunąć całej lokalnej tożsamości OpenVPN tego konta.',
      'openvpn_identity_in_use':
          'Natywna sesja OpenVPN nadal używa klucza lub certyfikatu tego urządzenia.',
      'openvpn_tls_verification_required':
          'Profil nie wymaga jawnie weryfikacji certyfikatu serwera.',
      'openvpn_cipher_invalid':
          'Serwer podał algorytm szyfrowania, którego nie ma na dozwolonej liście.',
      'openvpn_profile_rejected':
          'Profil otrzymany z serwera jest niezgodny. Utwórz urządzenie ponownie i spróbuj ponownie.',
      'openvpn_identity_inconsistent':
          'Certyfikat nie pasuje do bezpiecznej tożsamości tego telefonu. Nie zastąpiono lokalnego profilu.',
      'tls_handshake_failed':
          'Serwer odrzucił negocjację TLS. Jeśli problem będzie się powtarzał, utwórz profil ponownie.',
      'tls_alert_unknown_ca':
          'Serwer nie rozpoznaje urzędu certyfikacji tego certyfikatu urządzenia. Należy sprawdzić serwer OpenVPN.',
      'tls_alert_bad_certificate':
          'Serwer odrzucił ten certyfikat urządzenia. Przed ponowną próbą utwórz urządzenie ponownie.',
      'tls_alert_unsupported_certificate':
          'Serwer nie obsługuje bezpiecznego typu certyfikatu używanego przez Androida.',
      'tls_client_certificate_required':
          'Serwer wymaga certyfikatu klienta, ale OpenVPN Core nie mógł go przedstawić.',
      'tls_alert_misc':
          'Serwer zwrócił alert TLS spoza kategorii certyfikatu i wersji.',
      'tls_signature_algorithm_rejected':
          'Serwer odrzucił algorytm ECDSA P-256 klucza Android Keystore.',
      'tls_handshake_rejected':
          'Serwer przerwał negocjację TLS przed połączeniem.',
      'tls_version_rejected':
          'Klient i serwer nie znalazły wspólnej wersji TLS.',
      'tls_certificate_expired':
          'Certyfikat przedstawiony podczas połączenia wygasł.',
      'tls_certificate_revoked':
          'Certyfikat przedstawiony podczas połączenia został odebrany.',
      'transport_failed':
          'Serwer OpenVPN nie odpowiada w bieżącej sieci. Spróbuj ponownie za chwilę.',
      'tun_configuration_rejected':
          'Android odrzucił konfigurację sieci żądaną przez OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core odrzucił plan sieci przed utworzeniem interfejsu Androida.',
      'tun_interface_create_failed':
          'OpenVPN Core nie mógł uzyskać interfejsu TUN z Android VpnService.',
      'tun_interface_disabled':
          'Android lub OpenVPN Core wyłączył interfejs TUN podczas połączenia.',
      'tun_halted': 'OpenVPN Core otrzymał żądanie zatrzymania interfejsu TUN.',
      'tun_already_established':
          'OpenVPN zażądał drugiego interfejsu w tym samym połączeniu. Tunel zatrzymano dla bezpieczeństwa.',
      'tun_addresses_missing': 'Serwer nie podał użytecznego adresu tunelu.',
      'tun_routes_missing': 'Serwer nie podał użytecznych tras tunelu.',
      'tun_dns_missing': 'Serwer nie podał użytecznego serwera DNS.',
      'tun_permission_revoked':
          'Android odebrał uprawnienie VPN podczas połączenia.',
      'tun_establish_returned_null':
          'Android nie utworzył interfejsu, zwykle dlatego, że inny VPN jest nadal aktywny.',
      'openvpn_service_start_failed':
          'Android nie mógł uruchomić usługi OpenVPN na pierwszym planie.',
      'openvpn_operation_timeout':
          'Wywołanie JNI do OpenVPN Core przekroczyło maksymalny czas trwania.',
      'openvpn_start_failed':
          'Usługa Androida jest gotowa, ale OpenVPN Core nie zaakceptował uruchomienia profilu.',
      'openvpn_connection_failed':
          'OpenVPN Core zatrzymał się przed wygenerowaniem zdarzenia CONNECTED.',
      'openvpn_core_status_error':
          'Natywna pętla OpenVPN zakończyła się błędem bez bardziej szczegółowego zdarzenia końcowego.',
      'openvpn_stopped_before_connected':
          'Natywna pętla OpenVPN zatrzymała się przed CONNECTED, bez jawnego błędu Core.',
      'openvpn_auth_failed':
          'Serwer OpenVPN odrzucił uwierzytelnianie profilu.',
      'openvpn_client_setup_failed':
          'OpenVPN Core nie mógł zainicjować klienta przed połączeniem sieciowym.',
      'openvpn_client_halted':
          'OpenVPN Core otrzymał końcowe żądanie zatrzymania klienta.',
      'openvpn_client_restart':
          'OpenVPN Core zażądał ponownego uruchomienia swojej sesji transportowej.',
      'openvpn_inactive_timeout':
          'OpenVPN Core zamknął sesję po upływie limitu nieaktywności.',
      'openvpn_session_expired': 'Serwer zgłosił wygaśnięcie sesji OpenVPN.',
      'openvpn_credentials_required':
          'Serwer lub serwer proxy żąda danych uwierzytelniających wymagających interakcji, których nie ma w tym profilu certyfikatu.',
      'openvpn_proxy_failed':
          'OpenVPN Core zgłosił błąd skonfigurowanego serwera proxy lub przekaźnika.',
      'openvpn_compression_failed':
          'OpenVPN Core odrzucił tryb kompresji ogłoszony przez profil lub serwer.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil żąda szyfrowania NTLM, które nie jest dostępne w tej wersji.',
      'openvpn_feature_unsupported':
          'Profil lub serwer wymaga funkcji niedostępnej w tym kliencie Androida.',
      'network_unavailable': 'Nie ma dostępnej użytecznej sieci fizycznej.',
      'network_lost': 'Tunel zatrzymano po utracie sieci.',
      'certificate_validation_failed':
          'Nie można było zweryfikować tożsamości serwera OpenVPN.',
      'openvpn_certificate_expired':
          'Odnów profil OpenVPN przed ponownym połączeniem.',
      'tunnel_active_for_another_account':
          'Tunel należący do innego konta musi zostać zatrzymany przed tym połączeniem.',
      'tunnel_already_active':
          'Android zgłasza, że poprzednia sesja VPN nadal używa interfejsu.',
      'tunnel_stop_timeout':
          'Silnik $protocol nie potwierdził zwolnienia interfejsu VPN w wyznaczonym czasie.',
      'tunnel_disconnected':
          'Natywny silnik zgłosił nieoczekiwane zakończenie tunelu po uruchomieniu.',
      'native_bridge_unavailable':
          'Aplikacja nie może uzyskać dostępu do usługi VPN systemu Android. Zamknij i otwórz aplikację ponownie, a następnie spróbuj jeszcze raz.',
      'native_operation_failed':
          'Błąd aplikacji przerwał operację VPN. Spróbuj ponownie. Jeśli problem będzie się powtarzał, uruchom diagnostykę.',
      'invalid_arguments':
          'Informacje potrzebne do tej operacji VPN są niekompletne. Spróbuj ponownie. Jeśli problem będzie się powtarzał, uruchom diagnostykę.',
      'invalid_account_id':
          'Operacja natywna nie jest powiązana z prawidłowym identyfikatorem konta.',
      'invalid_device_id':
          'Identyfikator urządzenia wysłany do silnika natywnego jest pusty lub nieprawidłowy.',
      'storage_key_not_allowed':
          'Most Androida zablokował klucz spoza dozwolonej listy pamięci.',
      'secure_storage_read_failed':
          'Android Keystore nie mógł odszyfrować lokalnych danych tego konta.',
      'secure_storage_write_failed':
          'Android Keystore nie mógł zaszyfrować ani zapisać lokalnych danych.',
      'key_generation_failed':
          'Android nie mógł utworzyć ani odczytać klucza WireGuard w bezpiecznej pamięci.',
      'csr_generation_failed':
          'Android Keystore nie mógł utworzyć ani podpisać żądania CSR OpenVPN P-256.',
      'other':
          'Nieudokumentowana natywna gałąź zakończyła się błędem. Wyślij pokazany poniżej kod diagnostyczny do pomocy technicznej.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Żądanie uprawnienia jest już otwarte';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Żądanie uprawnienia VPN systemu Android jest już wyświetlone. Zakończ je przed ponowną próbą.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Przerwano żądanie uprawnienia VPN';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Ekran uprawnienia VPN został zamknięty, zanim aplikacja otrzymała odpowiedź.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Nie potwierdzono połączenia OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'Nie można było potwierdzić połączenia OpenVPN. Zostało ono zatrzymane dla bezpieczeństwa. Spróbuj ponownie.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN odebrany';

  @override
  String get openvpnCleanup_working =>
      'Zatrzymywanie i usuwanie odebranego profilu OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Zatrzymanie OpenVPN nie zostało potwierdzone. Spróbuj ponownie przed utworzeniem nowego profilu.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Nie można było całkowicie usunąć odebranego profilu OpenVPN. Spróbuj ponownie wyczyścić profil.';

  @override
  String get openvpnCleanup_complete =>
      'Odebrany profil OpenVPN został usunięty. Dotknij opcji Połącz, aby utworzyć nowy profil.';

  @override
  String get network_title => 'Konfiguracja sieci';

  @override
  String get network_ipv4Fallback =>
      'IPv6 jest tymczasowo niedostępny. Przygotowanie jest kontynuowane z użyciem IPv4.';

  @override
  String get network_rejectedTitle => 'Odrzucono konfigurację sieci';

  @override
  String get network_rejectedMessage =>
      'Konfiguracja tunelu jest niekompletna lub nie pasuje do autoryzowanych adresów. Spróbuj ponownie z poziomu aplikacji.';

  @override
  String get network_unreadableTitle =>
      'Nie można odczytać lokalnej konfiguracji';

  @override
  String get network_unreadableMessage =>
      'Zapisanej konfiguracji sieci OpenVPN nie można użyć. Połącz się ponownie z poziomu aplikacji, aby ją zaktualizować.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ochrona sieci';

  @override
  String get protection_subtitle =>
      'Blokuj bezpośredni dostęp do internetu po rozłączeniu VPN.';

  @override
  String get protection_active => 'Ochrona systemu aktywna';

  @override
  String get protection_alwaysOnOnly =>
      'VPN zawsze włączony; włącz blokowanie połączeń poza VPN';

  @override
  String get protection_inactive => 'Ochrona systemu nieaktywna';

  @override
  String get protection_unknown => 'Sprawdź ochronę systemu';

  @override
  String get protection_openSettings => 'Otwórz ustawienia Androida';

  @override
  String get protection_dialogTitle => 'Skonfiguruj ochronę sieci';

  @override
  String get protection_dialogMessage =>
      'Android zarządza funkcją VPN zawsze włączony oraz blokowaniem połączeń poza VPN. Sprawdź, czy wybrano FuzeVPN, i włącz blokowanie w ustawieniach systemu.';

  @override
  String get protection_dialogOpen => 'Otwórz ustawienia';

  @override
  String get session_systemProtectionNote =>
      'Jeśli Android nadal blokuje ruch poza VPN, otwórz ustawienia systemu, aby sprawdzić lub zmienić tę ochronę.';

  @override
  String get diagnostics_title => 'Diagnostyka';

  @override
  String get diagnostics_settingsTitle => 'Diagnostyka aplikacji';

  @override
  String get diagnostics_automaticTitle => 'Wysyłaj ważne błędy';

  @override
  String get diagnostics_automaticDescription =>
      'Udostępniaj mały raport techniczny po wystąpieniu ważnego błędu.';

  @override
  String get diagnostics_privacy =>
      'Wysłane raporty są powiązane z zalogowanym kontem i przechowywane przez 30 dni. Nie zawierają historii przeglądania, haseł ani kluczy VPN.';

  @override
  String get diagnostics_manualOpen => 'Uruchom diagnostykę';

  @override
  String get diagnostics_localDescription =>
      'Utwórz raport o stanie aplikacji i VPN. Twoje połączenie pozostanie bez zmian.';

  @override
  String get diagnostics_sendReport => 'Wyślij raport';

  @override
  String get diagnostics_sendHint =>
      'Pozostaw to pole niezaznaczone, aby zachować raport na tym urządzeniu.';

  @override
  String get diagnostics_signedOut =>
      'Zaloguj się na swoje konto, aby wysłać raport.';

  @override
  String get diagnostics_localLifetime =>
      'Zapisz ten raport na telefonie, aby zachować go po zamknięciu aplikacji.';

  @override
  String get diagnostics_run => 'Uruchom diagnostykę';

  @override
  String get diagnostics_rerun => 'Uruchom diagnostykę ponownie';

  @override
  String get diagnostics_running => 'Sprawdzanie…';

  @override
  String get diagnostics_sending => 'Wysyłanie raportu…';

  @override
  String get diagnostics_prepared => 'Raport gotowy na tym urządzeniu';

  @override
  String get diagnostics_queued => 'Raport oczekuje na wysłanie';

  @override
  String get diagnostics_sent => 'Raport otrzymany';

  @override
  String get diagnostics_failed =>
      'Wysyłanie nie powiodło się. Twój raport lokalny jest nadal dostępny.';

  @override
  String get diagnostics_preparationFailed =>
      'Nie można było przygotować raportu diagnostycznego. Spróbuj ponownie.';

  @override
  String get diagnostics_authenticationRequired =>
      'Zaloguj się ponownie, aby wysłać raport.';

  @override
  String get diagnostics_retry => 'Spróbuj wysłać ponownie';

  @override
  String get diagnostics_export => 'Zapisz raport';

  @override
  String get diagnostics_exportFailed =>
      'Eksportowanie nie powiodło się. Spróbuj ponownie z poziomu raportu lokalnego.';

  @override
  String get diagnostics_preferenceFailed =>
      'Nie można było zapisać tego ustawienia. Spróbuj ponownie.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Numer referencyjny: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Otrzymano $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Przechowywany do $date';
  }

  @override
  String get diagnostics_duplicate => 'Ten raport został już otrzymany.';

  @override
  String get diagnostics_preview => 'Podgląd raportu';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dołączono $count zdarzeń technicznych',
      many: 'Dołączono $count zdarzeń technicznych',
      few: 'Dołączono $count zdarzenia techniczne',
      one: 'Dołączono $count zdarzenie techniczne',
      zero: 'Nie dołączono żadnych zdarzeń technicznych',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Szczegóły techniczne';

  @override
  String get diagnostics_empty =>
      'Nie przygotowano jeszcze żadnego raportu diagnostycznego.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Stan tunelu',
      'handshake': 'Potwierdzenie połączenia',
      'certificate': 'Certyfikat VPN',
      'kill_switch': 'Ochrona Androida',
      'connectivity': 'Dostępna sieć',
      'api_reachability': 'Dostęp do usługi',
      'secure_storage': 'Bezpieczna pamięć',
      'other': 'Sprawdzenie lokalne',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Sprawdzono',
      'failed': 'Wymaga uwagi',
      'skipped': 'Nie przetestowano — brak aktywnego testu',
      'unknown': 'Informacje niedostępne',
      'other': 'Informacje niedostępne',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Witamy w FuzeVPN';

  @override
  String get connection_changeLocation => 'Zmień lokalizację';

  @override
  String get connection_details => 'Szczegóły połączenia';

  @override
  String get locations_searchLabel => 'Wyszukaj miasto lub kraj';

  @override
  String get locations_clearSearch => 'Wyczyść wyszukiwanie';

  @override
  String get locations_filterAll => 'Wszystkie';

  @override
  String get locations_filterFavorites => 'Ulubione';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokalizacji',
      many: '$count lokalizacji',
      few: '$count lokalizacje',
      one: '$count lokalizacja',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nie znaleziono lokalizacji';

  @override
  String get locations_noResultsHint =>
      'Spróbuj wyszukać inne miasto lub kraj.';

  @override
  String get locations_noFavorites => 'Twoje ulubione zawsze pod ręką';

  @override
  String get locations_noFavoritesHint =>
      'Dotknij gwiazdki obok lokalizacji, aby zapisać ją tutaj.';

  @override
  String get locations_showAll => 'Wyświetl wszystkie lokalizacje';

  @override
  String locations_addFavorite(String name) {
    return 'Dodaj $name do ulubionych';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Usuń $name z ulubionych';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Nie można było zapisać ulubionej lokalizacji. Spróbuj ponownie.';

  @override
  String get locations_emptyTitle => 'Brak dostępnych lokalizacji';

  @override
  String get locations_emptyHint => 'Odśwież listę i spróbuj ponownie.';

  @override
  String get devices_manage => 'Zarządzaj moimi urządzeniami';

  @override
  String get settings_personalization => 'Dostosuj do siebie';

  @override
  String get settings_safety => 'Ochrona';

  @override
  String get settings_help => 'Potrzebujesz pomocy?';

  @override
  String get settings_about => 'Informacje o FuzeVPN';

  @override
  String get diagnostics_heading => 'Zrozum problem z połączeniem';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Dostępny',
      'pending': 'Przygotowywanie',
      'revoked': 'Usunięty',
      'expired': 'Wygasł',
      'other': 'Stan niedostępny',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Nie zapisano preferencji';

  @override
  String get notice_preferenceSave_message =>
      'Twój wybór jest teraz zastosowany, ale nie można go było zapisać. Spróbuj ponownie, aby zachować go po zamknięciu aplikacji.';

  @override
  String get connection_androidDisconnectHint =>
      'Jeśli Android utrzymuje VPN aktywny, wyłącz opcję VPN zawsze włączony w otwartych ustawieniach.';

  @override
  String get protection_learnMore => 'Dowiedz się więcej o ochronie Androida';

  @override
  String get protection_guideWhy =>
      'Ta ochrona uniemożliwia aplikacjom bezpośrednie korzystanie z internetu po rozłączeniu VPN. Jest konfigurowana w systemie Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN zawsze włączony';

  @override
  String get protection_guideAlwaysOn =>
      'Android utrzymuje usługę VPN uruchomioną i może uruchomić ją ponownie po ponownym uruchomieniu telefonu.';

  @override
  String get protection_guideBlockTitle => 'Blokuj połączenia bez VPN';

  @override
  String get protection_guideBlock =>
      'To ustawienie zapobiega omijaniu VPN przez ruch sieciowy, również podczas przerwania połączenia.';

  @override
  String get protection_guideWarning =>
      'Po włączeniu tego blokowania dostęp do internetu pozostanie wyłączony do czasu połączenia z VPN.';

  @override
  String get protection_guideStepsTitle => 'Włącz ochronę';

  @override
  String get protection_guideStep1 =>
      'Otwórz ustawienia VPN systemu Android za pomocą przycisku poniżej.';

  @override
  String get protection_guideStep2 =>
      'Otwórz opcje za pomocą ikony koła zębatego obok FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Włącz opcję VPN zawsze włączony, a następnie Blokuj połączenia bez VPN, jeśli te opcje są dostępne.';

  @override
  String get protection_guideManufacturers =>
      'Nazwy różnią się zależnie od telefonu. W razie potrzeby wyszukaj VPN w Ustawieniach, często w sekcji Sieć i internet.';

  @override
  String get protection_guideDisableTitle => 'Wyłącz tę ochronę';

  @override
  String get protection_guideDisable =>
      'W tych samych ustawieniach wyłącz blokowanie połączeń bez VPN, aby zezwolić na dostęp do internetu bez VPN. Wyłącz także opcję VPN zawsze włączony, jeśli nie chcesz już, aby Android uruchamiał VPN ponownie.';

  @override
  String get protection_guideManual =>
      'Te ustawienia wybierasz w systemie Android. FuzeVPN nie zmienia ich za Ciebie.';

  @override
  String get locations_changeTitle => 'Zmienić lokalizację?';

  @override
  String locations_changeActive(String name) {
    return 'VPN zostanie rozłączony, a następnie spróbuje połączyć się z $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN spróbuje połączyć się z $name.';
  }

  @override
  String get locations_confirmChange => 'Zmień i połącz';

  @override
  String get locations_changeBusy =>
      'Trwa zmiana. Poczekaj przed wybraniem innej lokalizacji.';

  @override
  String get locations_automaticSelection => 'Wybór automatyczny';

  @override
  String get locations_cities => 'Miasta';

  @override
  String get locations_servers => 'Serwery';

  @override
  String locations_viewCities(String name) {
    return 'Wyświetl miasta w $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Wyświetl serwery w $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count krajów',
      many: '$count krajów',
      few: '$count kraje',
      one: '$count kraj',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miast',
      many: '$count miast',
      few: '$count miasta',
      one: '$count miasto',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serwerów',
      many: '$count serwerów',
      few: '$count serwery',
      one: '$count serwer',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Wszystkie kraje';

  @override
  String get locations_backToCountries => 'Wróć do krajów';

  @override
  String locations_backToCities(String name) {
    return 'Wróć do miast w $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Wybierz $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Wybierz $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Brak dostępnego kompatybilnego serwera.';

  @override
  String get externalLink_failed =>
      'Nie można otworzyć tego linku. Możesz go skopiować i otworzyć w przeglądarce.';

  @override
  String get externalLink_copy => 'Kopiuj link';

  @override
  String get externalLink_copied => 'Link skopiowany';

  @override
  String get externalLink_copyFailed =>
      'Nie można skopiować linku. Zaznacz adres poniżej.';

  @override
  String get settings_deleteAccount => 'Usuń moje konto';

  @override
  String get settings_deleteAccountDetail =>
      'Sprawdź, jak złożyć wniosek o usunięcie konta';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Wybierz subskrypcję VPN.';

  @override
  String get billing_subscribe => 'Subskrybuj';

  @override
  String get billing_choosePlan => 'Wybierz plan, aby kontynuować.';

  @override
  String get billing_monthly => 'Miesięczny';

  @override
  String get billing_yearly => 'Roczny';

  @override
  String get billing_continue => 'Kontynuuj z Google Play';

  @override
  String get billing_restore => 'Przywróć zakupy';

  @override
  String get billing_manage => 'Zarządzaj subskrypcją';

  @override
  String get billing_deleteAccountWarning =>
      'Jeśli masz subskrypcję Google Play, usunięcie konta FuzeVPN nie anuluje jej odnawiania. Zarządzaj odnawianiem lub anuluj je osobno w Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Przejdź do wniosku o usunięcie konta';

  @override
  String get billing_refresh => 'Odśwież dostęp';

  @override
  String get billing_loadingPlans => 'Ładowanie planów…';

  @override
  String get billing_unavailable =>
      'Obecnie nie ma dostępnych planów. Spróbuj później.';

  @override
  String get billing_comingSoon => 'Subskrypcje będą dostępne wkrótce.';

  @override
  String get billing_priceDisclosure =>
      'Cena pochodzi z Google Play. Ostateczna kwota jest potwierdzana przed płatnością.';

  @override
  String get billing_renewalMonthly =>
      'Automatyczne odnawianie co miesiąc, chyba że anulujesz. Możesz anulować w dowolnym momencie w subskrypcjach Google Play.';

  @override
  String get billing_renewalYearly =>
      'Automatyczne odnawianie co rok, chyba że anulujesz. Możesz anulować w dowolnym momencie w subskrypcjach Google Play.';

  @override
  String get billing_active => 'Twój dostęp Premium jest aktywny';

  @override
  String billing_accessUntil(String date) {
    return 'Dostęp do $date.';
  }

  @override
  String get billing_webManaged =>
      'Twoją subskrypcją zarządzasz na stronie FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Twoją subskrypcją zarządzasz w Google Play.';

  @override
  String get billing_inactive => 'Brak aktywnej subskrypcji.';

  @override
  String get billing_checkingAccess => 'Sprawdzanie dostępu…';

  @override
  String get billing_restoring => 'Przywracanie zakupów…';

  @override
  String get billing_pending =>
      'Płatność oczekuje. Dostęp zostanie aktywowany po potwierdzeniu.';

  @override
  String get billing_cancelled =>
      'Zakup anulowany. Nie aktywowano nowej subskrypcji.';

  @override
  String get billing_verifying => 'Weryfikacja zakupu…';

  @override
  String get billing_success =>
      'Subskrypcja aktywowana. Twój dostęp Premium jest gotowy.';

  @override
  String get billing_restored => 'Zakupy zostały przywrócone.';

  @override
  String get billing_restoreEmpty =>
      'Brak zakupów do przywrócenia dla tego konta Google Play.';

  @override
  String get billing_catalogError =>
      'Nie można załadować planów. Spróbuj ponownie.';

  @override
  String get billing_purchaseError =>
      'Nie można rozpocząć zakupu. Spróbuj ponownie.';

  @override
  String get billing_verificationError =>
      'Weryfikacja zakupu jest chwilowo niedostępna. Przywróć zakupy, aby spróbować ponownie.';

  @override
  String get billing_restoreError =>
      'Nie można przywrócić zakupów. Spróbuj ponownie.';

  @override
  String get billing_managementError =>
      'Nie można otworzyć zarządzania subskrypcjami. Spróbuj ponownie.';

  @override
  String get billing_storeUnavailable =>
      'Google Play jest niedostępny na tym urządzeniu.';

  @override
  String get welcome_title => 'Twój VPN, bez komplikacji.';

  @override
  String get welcome_description =>
      'Chroń swoje połączenie. Zachowaj kontrolę nad prywatnością.';

  @override
  String get welcome_start => 'Rozpocznij';

  @override
  String get welcome_alreadyPurchased => 'Już kupione?';

  @override
  String get welcome_noAccountRequired =>
      'Nie musisz tworzyć konta, aby rozpocząć.';

  @override
  String get guest_accountTitle => 'Konto niepowiązane';

  @override
  String get guest_accountDescription =>
      'Przywróć zakupy na tym samym koncie Google Play, aby korzystać z subskrypcji na innym urządzeniu.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Masz już subskrypcję? Zaloguj się';

  @override
  String get guest_claimTitle => 'Korzystaj z FuzeVPN wszędzie';

  @override
  String get guest_claimDescription =>
      'Utwórz konto, aby korzystać z subskrypcji na pozostałych urządzeniach. Ten krok jest opcjonalny.';

  @override
  String get guest_skip => 'Później';

  @override
  String get guest_activationTitle => 'Fuze Premium jest aktywne';

  @override
  String get guest_activationDescription =>
      'Twoja subskrypcja jest gotowa. Korzystaj z VPN i utwórz konto, kiedy chcesz.';

  @override
  String get guest_useVpn => 'Użyj mojego VPN';

  @override
  String get guest_loginRequired =>
      'Ten zakup jest już powiązany z kontem FuzeVPN. Zaloguj się na to konto, aby korzystać z subskrypcji.';

  @override
  String get guest_signOutWarning =>
      'Możesz odzyskać subskrypcję, przywracając zakupy na tym samym koncie Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Twoje konto jest już powiązane. Zaloguj się, aby wyświetlać swoje dane i nimi zarządzać.';

  @override
  String get billing_acceptance =>
      'Kontynuując, akceptujesz Warunki korzystania i Politykę prywatności.';

  @override
  String get guest_verifyEmailReminder =>
      'Potwierdź adres e-mail, aby zabezpieczyć konto. Możesz nadal korzystać z VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Usługa jest tymczasowo niedostępna. Spróbuj ponownie za chwilę.';

  @override
  String get guest_restoreError =>
      'Nie udało się przywrócić zakupów. Spróbuj ponownie na koncie Google Play użytym do zakupu.';

  @override
  String get guest_claimSuccess =>
      'Twoje konto zostało utworzone. Subskrypcja i dostęp do VPN zostały zachowane.';

  @override
  String get guest_emailExists =>
      'Ten adres e-mail jest już używany. Wybierz inny adres lub zaloguj się na istniejące konto. Twój zakup pozostaje dostępny przez Google Play.';

  @override
  String get guest_claimError =>
      'Nie udało się utworzyć konta. Możesz nadal korzystać z VPN i spróbować ponownie później.';

  @override
  String get guest_secureStorageError =>
      'Nie udało się zabezpieczyć sesji na tym urządzeniu. Spróbuj ponownie.';

  @override
  String get guest_premiumRequired => 'Wybierz subskrypcję, aby aktywować VPN.';

  @override
  String get welcome_viewPlans => 'Zobacz plany';

  @override
  String get google_continue => 'Kontynuuj z Google';

  @override
  String get google_or => 'lub';

  @override
  String get google_title => 'Twoje konto FuzeVPN';

  @override
  String get google_settingUp => 'Dokończ tworzenie konta';

  @override
  String get google_country => 'Kraj zamieszkania';

  @override
  String get google_profileDescription =>
      'Wybierz kraj i zapoznaj się z oboma dokumentami, aby utworzyć konto FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Połącz konto gościa z Google. Subskrypcja i urządzenie pozostaną przypisane do tego konta.';

  @override
  String get google_linkTitle => 'Połącz Google z FuzeVPN';

  @override
  String get google_linkDescription =>
      'Potwierdź dostęp do istniejącego konta FuzeVPN. Hasło Google nie jest wymagane.';

  @override
  String get google_password => 'Hasło FuzeVPN';

  @override
  String get google_linkAccount => 'Potwierdź połączenie';

  @override
  String get google_requestEmail => 'Wyślij e-mail potwierdzający';

  @override
  String get google_emailInstructions =>
      'Otwórz e-mail od FuzeVPN i wpisz kod potwierdzenia.';

  @override
  String get google_emailCode => 'Kod potwierdzenia z e-maila';

  @override
  String get google_confirmEmail => 'Potwierdź kod';

  @override
  String get google_restart => 'Wybierz inne konto Google';

  @override
  String get google_resume => 'Sprawdź tę próbę';

  @override
  String get google_unavailable =>
      'Logowanie Google jest niedostępne. Możesz użyć e-maila i hasła.';

  @override
  String get google_expired =>
      'Ta próba wygasła. Anuluj ją i rozpocznij ponownie.';

  @override
  String get google_conflict =>
      'To konto Google jest już połączone z innym kontem. Twoje obecne konto i subskrypcja pozostają zachowane.';

  @override
  String get google_error =>
      'Logowanie Google nie powiodło się. Spróbuj ponownie; obecny dostęp pozostaje zachowany.';

  @override
  String get google_uncertain =>
      'Nie można potwierdzić wyniku. Sprawdź tę próbę lub anuluj ją przed ponownym rozpoczęciem.';

  @override
  String get google_cancelFailed =>
      'Nie można potwierdzić anulowania. Spróbuj anulować ponownie przed opuszczeniem tego ekranu.';

  @override
  String get google_cancelled => 'Logowanie Google anulowane.';

  @override
  String get google_selecting => 'Wybierz konto Google…';

  @override
  String get google_verifying => 'Sprawdzanie konta…';

  @override
  String get google_emailUnavailable =>
      'Nie można wysłać e-maila potwierdzającego. Spróbuj później.';

  @override
  String get google_emailSent =>
      'E-mail potwierdzający wysłany. Sprawdź skrzynkę odbiorczą.';

  @override
  String get google_rateLimited => 'Zaczekaj przed ponowną próbą.';

  @override
  String get google_invalidPassword =>
      'Hasło FuzeVPN jest nieprawidłowe. Obecne konto pozostaje zachowane.';

  @override
  String get google_invalidCode =>
      'Kod potwierdzenia jest nieprawidłowy lub wygasł.';

  @override
  String get google_accountChanged =>
      'Sesja się zmieniła. Anuluj tę próbę przed ponownym rozpoczęciem.';

  @override
  String get google_invalidResponse =>
      'Nie można zweryfikować odpowiedzi. Obecny dostęp pozostaje zachowany.';

  @override
  String get google_invalidRegistration => 'Sprawdź kraj i obie zgody.';

  @override
  String get google_consentRequired =>
      'Wybierz kraj i zaakceptuj oba dokumenty, aby kontynuować.';

  @override
  String get google_challengeRequired =>
      'Wymagana jest dodatkowa kontrola bezpieczeństwa. Obecny dostęp pozostaje zachowany.';

  @override
  String get google_challengeUnavailable =>
      'Kontrola bezpieczeństwa jest niedostępna. Spróbuj później.';
}
