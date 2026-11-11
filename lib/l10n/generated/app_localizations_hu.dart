// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Kapcsolat védelme';

  @override
  String get vpnDisclosure_body =>
      'A FuzeVPN az Android VPN-szolgáltatását (VpnService) használja, hogy titkosított alagutat hozzon létre az eszköz és a FuzeVPN-szerverek között.';

  @override
  String get vpnDisclosure_dataBody =>
      'Amíg a VPN aktív, az Ön alkalmazásainak internetes forgalma, a célcímek és a DNS-kérések ezen az alagúton haladnak át a kapcsolat továbbításához, még akkor is, ha a FuzeVPN a háttérben fut.';

  @override
  String get vpnDisclosure_statusBody =>
      'Az alkalmazás a kapcsolat állapotát, időtartamát és az átvitt adatmennyiséget használja fel a VPN-kapcsolat megjelenítéséhez. Bármikor leállíthatja a VPN-t.';

  @override
  String get vpnDisclosure_privacy => 'Adatvédelem';

  @override
  String get vpnDisclosure_accept => 'Elfogadás és folytatás';

  @override
  String get vpnDisclosure_decline => 'Most nem';

  @override
  String get accountRestoration_title => 'A fiók átmenetileg nem érhető el';

  @override
  String get accountRestoration_message =>
      'A munkamenete megmaradt. Próbálja újra a fiók visszaállítását; a VPN-kapcsolatot továbbra is itt kezelheti.';

  @override
  String get action_retry => 'Újrapróbálkozás';

  @override
  String get session_endingTitle => 'Munkamenet lezárása';

  @override
  String get session_ending =>
      'Munkamenet lezárása: a VPN leállítása és az adatok törlése…';

  @override
  String get session_stopFailed =>
      'A VPN leállítását nem sikerült megerősíteni. Próbálja újra, mielőtt ismét bejelentkezne.';

  @override
  String get session_cleanupFailed =>
      'A VPN leállt, de a munkamenet törlését nem sikerült megerősíteni. Próbálja újra a törlést.';

  @override
  String get session_retryStop => 'Leállítás újrapróbálása';

  @override
  String get session_retryCleanup => 'Törlés újrapróbálása';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'A FuzeVPN biztonságos előkészítése…';

  @override
  String get nav_connection => 'Kapcsolat';

  @override
  String get nav_locations => 'Helyek';

  @override
  String get nav_account => 'Fiók';

  @override
  String get nav_devices => 'Eszközök';

  @override
  String get nav_settings => 'Beállítások';

  @override
  String get action_refresh => 'Frissítés';

  @override
  String get auth_tab_login => 'Bejelentkezés';

  @override
  String get auth_tab_register => 'Regisztráció';

  @override
  String get auth_stepAccount => 'Fiók';

  @override
  String get auth_stepIdentity => 'Személyes adatok';

  @override
  String get auth_stepAddress => 'Cím és hozzájárulások';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$current. lépés / $total';
  }

  @override
  String get auth_tagline => 'Az Ön VPN-je, egyszerűen.';

  @override
  String get auth_keysLocal =>
      'Az Ön privát VPN-kulcsai ezen az eszközön maradnak.';

  @override
  String get form_email => 'E-mail-cím';

  @override
  String get form_password => 'Jelszó';

  @override
  String get form_showPassword => 'Jelszó megjelenítése';

  @override
  String get form_hidePassword => 'Jelszó elrejtése';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 bájt. Egyes karakterek több bájtot foglalnak el.';

  @override
  String get form_firstName => 'Keresztnév';

  @override
  String get form_lastName => 'Vezetéknév';

  @override
  String get form_phone => 'Telefonszám (+33612345678)';

  @override
  String get form_address => 'Cím';

  @override
  String get form_address2 => 'Cím kiegészítése (nem kötelező)';

  @override
  String get form_postalCode => 'Irányítószám';

  @override
  String get form_city => 'Város';

  @override
  String get form_country => 'Országkód (pl. FR)';

  @override
  String get action_login => 'Bejelentkezés';

  @override
  String get action_createAccount => 'Fiók létrehozása';

  @override
  String get action_createMyAccount => 'Fiókom létrehozása';

  @override
  String get action_next => 'Folytatás';

  @override
  String get action_previous => 'Vissza';

  @override
  String get action_forgotPassword => 'Elfelejtette a jelszavát?';

  @override
  String get auth_noAccount => 'Még nincs fiókja?';

  @override
  String get auth_requiredInformation => 'Hozza létre fiókját három lépésben.';

  @override
  String get auth_termsPrefix => 'Elfogadom a ';

  @override
  String get auth_termsLink => 'felhasználási feltételeket';

  @override
  String get auth_privacyPrefix => 'Elfogadom az ';

  @override
  String get auth_privacyLink => 'adatvédelmi szabályzatot';

  @override
  String get auth_consentRequired =>
      'A fiók létrehozásához hozzájárulása szükséges.';

  @override
  String get validation_required => 'Ez a mező kötelező.';

  @override
  String get validation_email => 'Adjon meg egy érvényes e-mail-címet.';

  @override
  String get validation_password =>
      'A jelszó túl rövid: legalább 8 UTF-8 bájt szükséges.';

  @override
  String get validation_passwordTooLong =>
      'A jelszó túl hosszú: legfeljebb 72 UTF-8 bájt lehet.';

  @override
  String get validation_phone =>
      'Használjon nemzetközi formátumot, például +33612345678.';

  @override
  String get validation_country =>
      'Használjon kétbetűs országkódot, például FR.';

  @override
  String get passwordReset_title => 'Jelszó visszaállítása';

  @override
  String get passwordReset_description =>
      'Adja meg fiókja e-mail-címét, és kérjen jelszó-visszaállító hivatkozást.';

  @override
  String get passwordReset_send => 'Hivatkozás küldése';

  @override
  String get connection_title => 'Az Ön kapcsolata';

  @override
  String get connection_subtitle =>
      'Válasszon helyet, majd kapcsolja be a VPN-t.';

  @override
  String get connection_prepare => 'Készen áll a csatlakozásra?';

  @override
  String get connection_advancedOptions => 'Speciális beállítások';

  @override
  String get connection_location => 'Hely';

  @override
  String get connection_chooseLocation => 'Válasszon helyet';

  @override
  String get connection_protocol => 'Protokoll';

  @override
  String get connection_connect => 'Csatlakozás';

  @override
  String get connection_connecting => 'Csatlakozás…';

  @override
  String get connection_disconnect => 'Leválasztás';

  @override
  String get connection_disconnecting => 'Leválasztás folyamatban';

  @override
  String get connection_locationChange => 'Hely váltása…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol nem elérhető';
  }

  @override
  String get connection_activeLocation => 'Aktív hely';

  @override
  String get connection_duration => 'Időtartam';

  @override
  String get connection_received => 'Fogadott';

  @override
  String get connection_sent => 'Elküldött';

  @override
  String get connection_lastHandshake => 'Utolsó biztonságos adatcsere';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ezelőtt';
  }

  @override
  String get verification_title => 'Erősítse meg e-mail-címét';

  @override
  String get verification_message =>
      'Erősítse meg e-mail-címét, hogy használhassa a VPN-t ezen a telefonon.';

  @override
  String get verification_resend => 'E-mail újraküldése';

  @override
  String get migration_title => 'Hely váltása';

  @override
  String get migration_draining => 'A hely váltásának előkészítése…';

  @override
  String get migration_activating => 'Az új szerver aktiválása…';

  @override
  String get migration_ready => 'A hely frissült.';

  @override
  String get migration_blocked =>
      'A hely váltása szerveroldali beavatkozást igényel. Próbálja újra később, vagy forduljon az ügyfélszolgálathoz.';

  @override
  String get migration_progress => 'A hely váltásának folyamata';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Ellenőrzések közötti várakozás: $seconds mp.';
  }

  @override
  String get migration_resume => 'Váltás folytatása';

  @override
  String get status_authorizing => 'Engedély szükséges';

  @override
  String get status_authorizingDetail =>
      'Fogadja el az Android-kérést a VPN engedélyezéséhez.';

  @override
  String get status_preparing => 'Előkészítés';

  @override
  String get status_preparingDetail =>
      'A biztonságos kapcsolat előkészítése folyamatban.';

  @override
  String get status_reconnecting => 'Újracsatlakozás…';

  @override
  String get status_reconnectingDetail =>
      'A kapcsolat megszakadt. A VPN megpróbál újracsatlakozni.';

  @override
  String get status_connecting => 'Csatlakozás folyamatban';

  @override
  String get status_connectingDetail => 'Csatlakozás a VPN-szerverhez…';

  @override
  String get status_connected => 'Csatlakoztatva';

  @override
  String get status_connectedDetail => 'Az Ön VPN-kapcsolata aktív.';

  @override
  String get status_disconnecting => 'Leválasztás folyamatban';

  @override
  String get status_disconnectingDetail => 'Az Ön VPN-kapcsolata éppen leáll.';

  @override
  String get status_error => 'A kapcsolat nem érhető el';

  @override
  String get status_errorDetail =>
      'A VPN-kapcsolat nincs megerősítve. Próbálja újra.';

  @override
  String get status_idle => 'Nincs csatlakoztatva';

  @override
  String get status_idleDetail =>
      'Csatlakozzon a VPN-hez, hogy megvédje kapcsolatát.';

  @override
  String get trust_note =>
      'Az alkalmazás bezárása nem állítja le a VPN-t. A leállításhoz használja a Leválasztás gombot.';

  @override
  String get locations_none => 'Jelenleg nincs elérhető hely.';

  @override
  String get locations_available => 'Válassza ki a következő helyet.';

  @override
  String get locations_selected => 'Kiválasztott hely';

  @override
  String get locations_select => 'Hely kiválasztása';

  @override
  String get locations_lockedTunnel => 'A hely váltásához válassza le a VPN-t.';

  @override
  String get locations_lockedMigration =>
      'Várja meg, amíg befejeződik a hely váltása.';

  @override
  String get devices_title => 'Az Ön eszközei';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit eszköz';
  }

  @override
  String get devices_refresh => 'Eszközök frissítése';

  @override
  String get devices_empty => 'Még nincs regisztrált VPN-eszköz.';

  @override
  String get devices_firstConnection =>
      'A telefonja az első csatlakozáskor kerül az eszközei közé.';

  @override
  String get devices_thisDevice => 'Ez az eszköz';

  @override
  String devices_added(Object date) {
    return 'Hozzáadva: $date';
  }

  @override
  String get devices_unnamed => 'Névtelen eszköz';

  @override
  String get action_remove => 'Eltávolítás';

  @override
  String get settings_title => 'Beállítások';

  @override
  String get settings_subtitle => 'Beállításai és fiókja egy helyen.';

  @override
  String get settings_appearance => 'Megjelenés';

  @override
  String get settings_language => 'Nyelv';

  @override
  String get settings_languageDescription =>
      'A kiválasztott nyelv a VPN-értesítésekre is vonatkozik.';

  @override
  String get settings_account => 'Fiók';

  @override
  String get settings_signOut => 'Kijelentkezés';

  @override
  String get settings_privacy => 'Adatvédelmi szabályzat';

  @override
  String get settings_terms => 'Felhasználási feltételek';

  @override
  String get settings_security => 'Biztonság és átláthatóság';

  @override
  String get settings_licenses => 'Összetevők licencei';

  @override
  String get settings_licensesDetail => 'Az alkalmazásban használt szoftverek';

  @override
  String settings_licensesLegalese(String url) {
    return 'Az alkalmazás és az MPL-2.0 licenc alá tartozó összetevők forráskódja: $url';
  }

  @override
  String get settings_background =>
      'A VPN az alkalmazás elhagyása után is bekapcsolva marad. A leállításhoz használja a Kapcsolat lapon lévő Leválasztás gombot.';

  @override
  String get theme_system => 'Rendszer';

  @override
  String get theme_light => 'Világos';

  @override
  String get theme_dark => 'Sötét';

  @override
  String get language_system => 'A telefon nyelve';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Eltávolítja ezt az eszközt?';

  @override
  String get dialog_removeCurrent =>
      'Ez a telefon lekapcsolódik a VPN-ről, és elveszíti a hozzáférését. A VPN-kapcsolat adatai a szerver megerősítése után törlődnek.';

  @override
  String dialog_removeOther(Object name) {
    return 'A(z) „$name” VPN-hozzáférését visszavonjuk. Ez a művelet nem vonható vissza.';
  }

  @override
  String get dialog_signOut => 'Kijelentkezik?';

  @override
  String get dialog_signOutMessage =>
      'A VPN leáll, és újra be kell jelentkeznie. A titkosított VPN-kulcsai a következő csatlakozáshoz ezen a telefonon maradnak.';

  @override
  String get action_cancel => 'Mégse';

  @override
  String get action_close => 'Bezárás';

  @override
  String get action_copy => 'Másolás';

  @override
  String get action_renew => 'Megújítás';

  @override
  String get action_signOut => 'Kijelentkezés';

  @override
  String get notice_close => 'Üzenet bezárása';

  @override
  String get notice_sessionExpired_title => 'A munkamenet lejárt';

  @override
  String get notice_sessionExpired_message =>
      'A munkamenete lejárt. Jelentkezzen be újra.';

  @override
  String get notice_connectionFailed_title => 'Csatlakozás sikertelen';

  @override
  String get notice_invalidCredentials_message =>
      'Az e-mail-cím vagy a jelszó helytelen.';

  @override
  String get notice_emailVerification_title =>
      'E-mail-cím megerősítése szükséges';

  @override
  String get notice_emailVerification_message =>
      'Erősítse meg e-mail-címét, mielőtt VPN-eszközt adna hozzá.';

  @override
  String get notice_rateLimited_title => 'Túl sok próbálkozás';

  @override
  String get notice_deviceLimit_title => 'Elérte az eszközkorlátot';

  @override
  String get notice_deviceLimit_message =>
      'Távolítson el egy meglévő eszközt, mielőtt másikat adna hozzá.';

  @override
  String get notice_identityRenewal_title =>
      'A VPN-identitást meg kell újítani';

  @override
  String get notice_identityRenewal_message =>
      'Ezt az identitást eltávolították. Hozzon létre új helyi identitást.';

  @override
  String get notice_migrationPending_title => 'Hely váltása folyamatban';

  @override
  String get notice_migrationPending_message =>
      'A hely váltása már folyamatban van.';

  @override
  String get notice_migrationBlocked_title => 'Hely váltása blokkolva';

  @override
  String get notice_migrationBlocked_message =>
      'A hely váltásához szerveroldali beavatkozás szükséges. Próbálja újra később, vagy forduljon az ügyfélszolgálathoz.';

  @override
  String get notice_targetUnavailable_title =>
      'A szerver átmenetileg nem elérhető';

  @override
  String get notice_targetUnavailable_message =>
      'Ez a szerver átmenetileg nem elérhető.';

  @override
  String get notice_networkUnavailable_title =>
      'Az internetkapcsolat nem elérhető';

  @override
  String get notice_networkUnavailable_message =>
      'Ellenőrizze a kapcsolatát, és próbálja újra.';

  @override
  String get notice_permissionDenied_title => 'VPN-engedély megtagadva';

  @override
  String get notice_permissionDenied_message =>
      'Indítsa újra a csatlakozást, és fogadja el az Android-engedélykérést.';

  @override
  String get notice_wireguardTimeout_title => 'A szerver nem válaszol';

  @override
  String get notice_wireguardTimeout_message =>
      'A WireGuard-kapcsolat túl sokáig tartott. Próbálja újra, vagy válasszon másik helyet.';

  @override
  String get notice_tlsFailed_title => 'Biztonságos kapcsolat elutasítva';

  @override
  String get notice_tlsFailed_message =>
      'A szerver nem fogadta el az OpenVPN-kapcsolatot. Próbálja újra. Ha a probléma továbbra is fennáll, futtasson diagnosztikát.';

  @override
  String get notice_tunRejected_title =>
      'Az Android elutasította a VPN-interfészt';

  @override
  String get notice_tunRejected_message =>
      'Az Android elutasította az OpenVPN által kért hálózati konfigurációt.';

  @override
  String get notice_openvpnStart_title => 'Az OpenVPN nem tudott elindulni';

  @override
  String get notice_openvpnStart_message =>
      'Az OpenVPN motorja nem tudott teljesen elindulni. Próbálja újra. Ha a probléma továbbra is fennáll, forduljon az ügyfélszolgálathoz.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnosztikai kód: $code';
  }

  @override
  String get notice_generic_title => 'A VPN-kapcsolat sikertelen';

  @override
  String get notice_generic_message =>
      'Hiba történt. Próbálja meg később újra.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Fiók létrehozva',
      'password_reset_sent': 'Jelszó-visszaállítási kérés megérkezett',
      'verification_email_sent': 'Ellenőrző e-mail elküldve',
      'location_migration_pending': 'Hely váltása folyamatban',
      'vpn_sign_in_required': 'Bejelentkezés szükséges',
      'protocol_unavailable_at_location': 'Protokoll nem elérhető',
      'vpn_permission_denied': 'VPN-engedély megtagadva',
      'revoked_identity_device_limit': 'Elérte az eszközkorlátot',
      'tunnel_start_unexpected': 'A VPN nem tudott elindulni',
      'flutter_disconnect_timeout': 'A leválasztás nincs megerősítve',
      'flutter_disconnect_unexpected': 'Nem sikerült a leválasztás',
      'device_revoked': 'Eszköz eltávolítva',
      'revoke_unexpected': 'Az eszközt nem sikerült eltávolítani',
      'identity_renewal_unexpected': 'Az identitás megújítása nem sikerült',
      'openvpn_renewal_unexpected': 'Az OpenVPN-profil megújítása nem sikerült',
      'location_migration_blocked': 'Hely váltása blokkolva',
      'location_migration_slow': 'Hely váltása még folyamatban',
      'location_migration_conflict': 'Hely váltása frissítést igényel',
      'location_migration_verification_failed':
          'A hely váltása nincs megerősítve',
      'location_migration_device_changed':
          'Az eszköz megváltozott a hely váltása közben',
      'tunnel_stop_failed': 'Hely váltása nem lehetséges',
      'device_clock_ahead': 'Az eszköz órája siet',
      'other': 'A művelet sikertelen',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'A fiók létrejött, de az ellenőrző e-mailt nem lehetett elküldeni. Az alkalmazásban kérje az e-mail újraküldését.',
      'password_reset_sent':
          'Megkaptuk a kérését. Ha ehhez a címhez tartozik fiók, e-mailt kaphat. Ellenőrizze a levélszemét mappát is.',
      'verification_email_sent': 'Új ellenőrző e-mailt küldtünk.',
      'location_migration_pending':
          'A(z) $target helyre történő váltás még előkészítés alatt áll. Az eszköz újbóli létrehozása nélkül folytathatja.',
      'vpn_sign_in_required':
          'Jelentkezzen be a fiókjába, mielőtt elindítja a VPN-t.',
      'protocol_unavailable_at_location':
          'Ez a hely nem kínálja a kiválasztott protokollt. Frissítse a helyeket, vagy válasszon másik protokollt.',
      'vpn_permission_denied':
          'Az Android megtagadta a VPN-engedélyt. Indítsa újra a csatlakozást, és fogadja el a rendszerkérést.',
      'revoked_identity_device_limit':
          'Ennek az eszköznek a VPN-hozzáférését eltávolították, az eszközkorlát pedig betelt. Távolítson el egy eszközt a Fiók → Eszközeim kezelése menüpontban.',
      'tunnel_start_unexpected':
          'Váratlan hiba szakította meg az alagút előkészítését. Ellenőrizze a diagnosztikai kódot, majd próbálja újra.',
      'flutter_disconnect_timeout':
          'Az Android nem erősítette meg időben, hogy a VPN leállt. Próbálja meg újra leállítani.',
      'flutter_disconnect_unexpected':
          'Váratlan hiba miatt nem lehetett megerősíteni, hogy az alagút leállt.',
      'device_revoked':
          'Az eszköz VPN-hozzáférését visszavonták, a helyi titkos adatait pedig eltávolították.',
      'revoke_unexpected':
          'Az eszközt nem sikerült eltávolítani. Frissítse a listát, és próbálja újra.',
      'identity_renewal_unexpected':
          'Az új VPN-identitást nem sikerült létrehozni. Frissítse az eszközöket, és próbálja újra.',
      'openvpn_renewal_unexpected':
          'Az OpenVPN-profilt nem sikerült megújítani. Próbálja újra, vagy ellenőrizze a diagnosztikai kódot.',
      'location_migration_blocked':
          'A szerver jelenleg nem tudja befejezni ezt a váltást. Az eszköz és a helyi identitása megmaradt.',
      'location_migration_slow':
          'A szerver még előkészíti a váltást a(z) $target helyre. Néhány pillanat múlva használja a Váltás folytatása gombot.',
      'location_migration_conflict':
          'Az eszköz állapota megváltozott a szerveren. Frissítse az eszközöket, majd folytassa a váltást.',
      'location_migration_verification_failed':
          'A szerver nem erősítette meg az új helyet. A korábbi helyi identitás megmaradt.',
      'location_migration_device_changed':
          'A szerver által visszaadott eszköz már nem egyezik a módosítandó eszközzel. Frissítse az eszközöket, és próbálja újra.',
      'tunnel_stop_failed':
          'Az új csatlakozás előtt az előző alagutat teljesen le kell állítani.',
      'device_clock_ahead':
          'Ennek az eszköznek az órája sietni látszik. Kapcsolja be az automatikus dátum és idő beállítást, hogy bejelentkezve maradhasson.',
      'other':
          'A műveletet nem sikerült befejezni. Próbálja újra, vagy küldje el a diagnosztikai kódot az ügyfélszolgálatnak.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'A munkamenet lejárt',
      'invalid_credentials': 'Sikertelen bejelentkezés',
      'email_verification_required': 'E-mail-cím megerősítése szükséges',
      'verification_email_cooldown': 'Az e-mailt már elküldtük',
      'rate_limited': 'Túl sok próbálkozás',
      'invalid_registration': 'Az adatokat javítani kell',
      'email_exists': 'A fiók már létezik',
      'invalid_profile': 'Érvénytelen profil',
      'invalid_device': 'Érvénytelen eszköz',
      'invalid_location': 'A hely nem érhető el',
      'device_limit': 'Elérte az eszközkorlátot',
      'device_exists': 'A VPN-identitás már használatban van',
      'device_identity_revoked': 'A VPN-identitást meg kell újítani',
      'device_location_locked': 'Hely váltása frissítést igényel',
      'location_migration_pending': 'Hely váltása folyamatban',
      'location_migration_blocked': 'Hely váltása blokkolva',
      'target_ca_mismatch': 'Nem kompatibilis OpenVPN-szerver',
      'location_migration_conflict': 'Hely váltása frissítést igényel',
      'server_full': 'A szerver megtelt',
      'capacity_unavailable': 'A hely átmenetileg nem érhető el',
      'target_unavailable': 'A szerver átmenetileg nem érhető el',
      'not_found': 'Az elem nem található',
      'invalid_openvpn_csr': 'Érvénytelen OpenVPN-identitás',
      'openvpn_profile_exists': 'Az OpenVPN-profil már létezik',
      'openvpn_profile_revoked': 'Az OpenVPN-profil visszavonva',
      'openvpn_operation_pending': 'Az OpenVPN-művelet folyamatban van',
      'openvpn_operation_terminal': 'Az OpenVPN-művelet megszakadt',
      'openvpn_address_unavailable': 'Az OpenVPN-cím nem érhető el',
      'openvpn_profile_conflict': 'OpenVPN-ütközés',
      'openvpn_signer_unavailable': 'Az OpenVPN nem érhető el',
      'email_delivery_unavailable': 'Az e-mail-küldés nem érhető el',
      'invalid_token': 'Érvénytelen hivatkozás',
      'network_unavailable': 'Az internetkapcsolat nem érhető el',
      'invalid_json': 'Érvénytelen kérés',
      'invalid_api_response': 'Érvénytelen szerverválasz',
      'ipv6_unavailable': 'Az IPv6 nem érhető el',
      'invalid_ip_families': 'A hálózati konfigurációt elutasították',
      'other': 'A szolgáltatás nem érhető el',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'A munkamenet lejárt. Jelentkezzen be újra.',
      'invalid_credentials': 'Az e-mail-cím vagy a jelszó helytelen.',
      'email_verification_required':
          'Erősítse meg e-mail-címét, mielőtt VPN-eszközt adna hozzá.',
      'invalid_registration':
          'Ellenőrizze a kért adatokat és a hozzájárulásokat.',
      'email_exists': 'Ezt az e-mail-címet már egy fiók használja.',
      'invalid_profile': 'Ellenőrizze a profiladatait.',
      'invalid_device': 'Az eszköz neve vagy helyi identitása érvénytelen.',
      'invalid_location': 'Frissítse a helyek listáját, majd próbálja újra.',
      'device_limit':
          'Távolítson el egy meglévő eszközt, mielőtt másikat adna hozzá.',
      'device_exists':
          'Ez a VPN-identitás már egy másik fiókhoz van kapcsolva.',
      'device_identity_revoked':
          'Ezt az identitást eltávolították. Új helyi identitást kell létrehozni.',
      'device_location_locked':
          'Ennek az eszköznek a helye éppen megváltozott. Az alkalmazás folytatja a folyamatban lévő váltást.',
      'location_migration_pending': 'A hely váltása már folyamatban van.',
      'location_migration_blocked':
          'A hely váltásához szerveroldali beavatkozás szükséges. Próbálja újra később, vagy forduljon az ügyfélszolgálathoz.',
      'target_ca_mismatch':
          'Ez a szerver még nem kompatibilis a jelenlegi OpenVPN-profillal.',
      'location_migration_conflict':
          'Frissítse az eszközöket, majd próbálja újra a hely váltását.',
      'server_full':
          'Ez a hely elérte a kapcsolatkorlátját. Válasszon másik helyet, vagy próbálja újra később.',
      'capacity_unavailable':
          'Most nem tudjuk megerősíteni, hogy ez a hely elérhető-e. Válasszon másik helyet, vagy próbálja újra később.',
      'target_unavailable': 'Ez a szerver átmenetileg nem érhető el.',
      'not_found': 'Ez az elem már nem érhető el a fiókjában.',
      'invalid_openvpn_csr':
          'Hozzon létre új OpenVPN-identitást, majd próbálja újra.',
      'openvpn_profile_exists':
          'Ehhez az eszközhöz már létezik OpenVPN-profil.',
      'openvpn_profile_revoked':
          'A folytatáshoz újítsa meg az OpenVPN-profilt.',
      'openvpn_operation_pending':
          'A módosítás még nem lépett életbe mindenhol. Próbálja újra később.',
      'openvpn_operation_terminal':
          'Hozzon létre új OpenVPN-identitást, majd próbálja újra.',
      'openvpn_address_unavailable': 'Jelenleg nincs elérhető OpenVPN-cím.',
      'openvpn_profile_conflict':
          'A profil megváltozott. Frissítse az eszközöket, és próbálja újra.',
      'openvpn_signer_unavailable':
          'Az OpenVPN-szolgáltatás átmenetileg nem érhető el.',
      'email_delivery_unavailable':
          'Az e-mailt nem sikerült elküldeni. Próbálja újra később.',
      'invalid_token': 'Ez a hivatkozás érvénytelen vagy lejárt. Kérjen újat.',
      'network_unavailable':
          'Ellenőrizze az internetkapcsolatot, és próbálja újra.',
      'invalid_json': 'Ellenőrizze a megadott adatokat, és próbálja újra.',
      'invalid_api_response':
          'A szerver váratlan választ küldött. Próbálja újra később.',
      'ipv6_unavailable':
          'A szerver jelenleg nem tudja aktiválni az IPv6-ot. Próbálja újra később.',
      'invalid_ip_families':
          'Az alagút beállítása hiányos, vagy nem egyezik a jóváhagyott címekkel. Próbálja újra az alkalmazásból.',
      'other': 'Szerverhiba történt. Próbálja újra később.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Próbálja újra néhány pillanat múlva.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Próbálja újra $seconds másodperc múlva.',
      one: 'Próbálja újra $seconds másodperc múlva.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Próbálja újra $minutes perc múlva.',
      one: 'Próbálja újra $minutes perc múlva.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Próbálja újra $hours óra múlva.',
      one: 'Próbálja újra $hours óra múlva.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Rendszerszintű VPN-folytatás nem érhető el',
      'system_vpn_resume_corrupt': 'Érvénytelen rendszerszintű VPN-folytatás',
      'system_vpn_resume_session_invalid':
          'Érvénytelen VPN-folytatási munkamenet',
      'system_vpn_resume_identity_changed': 'A VPN-identitás megváltozott',
      'system_vpn_resume_identity_invalid':
          'Érvénytelen VPN-folytatási identitás',
      'system_vpn_resume_storage_failed':
          'A VPN-folytatás tárolója nem érhető el',
      'system_vpn_resume_network_timeout': 'Nincs hálózat a VPN-folytatáshoz',
      'system_vpn_resume_blocked': 'A VPN-folytatás blokkolva',
      'system_vpn_resume_failed': 'A VPN-folytatás sikertelen',
      'system_vpn_resume_error_invalid': 'Érvénytelen VPN-folytatási hiba',
      'wireguard_identity_store_failed': 'A WireGuard-identitás nincs mentve',
      'wireguard_identity_unavailable': 'A WireGuard-identitás nem érhető el',
      'vpn_host_destroyed': 'Az Android VPN-összetevő leállt',
      'vpn_host_unavailable': 'Az Android VPN-összetevő nem érhető el',
      'vpn_permission_required': 'VPN-engedély szükséges',
      'vpn_permission_denied': 'VPN-engedély megtagadva',
      'vpn_permission_request_failed': 'Az engedélykérés sikertelen',
      'wireguard_foreground_service_unavailable':
          'A WireGuard-szolgáltatás nem érhető el',
      'wireguard_identity_invalid': 'Érvénytelen helyi WireGuard-kulcs',
      'wireguard_identity_in_use': 'A WireGuard-identitás már használatban van',
      'wireguard_configuration_invalid': 'Érvénytelen WireGuard-konfiguráció',
      'wireguard_operation_pending': 'A WireGuard-művelet még folyamatban van',
      'wireguard_start_failed': 'A WireGuard indítása elutasítva',
      'wireguard_stop_timeout': 'A WireGuard leállítása nincs megerősítve',
      'wireguard_handshake_timeout': 'A WireGuard nem válaszolt',
      'openvpn_connection_timeout': 'Az OpenVPN nem válaszolt',
      'openvpn_core_unavailable': 'Az OpenVPN-motor nem érhető el',
      'openvpn_operation_pending': 'Az OpenVPN-munkamenet még aktív',
      'openvpn_stop_timeout': 'Az OpenVPN leállítása nincs megerősítve',
      'openvpn_profile_unavailable': 'Hiányzik a helyi OpenVPN-profil',
      'openvpn_native_failed': 'Az OpenVPN natív hívása megszakadt',
      'openvpn_key_generation_failed':
          'Az OpenVPN P-256 kulcsot nem sikerült létrehozni',
      'openvpn_csr_generation_failed':
          'Az OpenVPN CSR-t nem sikerült létrehozni',
      'openvpn_identity_store_failed': 'Az OpenVPN-identitás nincs mentve',
      'openvpn_identity_clear_failed': 'Az OpenVPN eltávolítása nem teljes',
      'openvpn_identity_in_use': 'Az OpenVPN-identitás még használatban van',
      'openvpn_tls_verification_required': 'Hiányzik az OpenVPN TLS-ellenőrzés',
      'openvpn_cipher_invalid': 'Érvénytelen OpenVPN-titkosítás',
      'openvpn_profile_rejected': 'Az OpenVPN-profilt elutasították',
      'openvpn_identity_inconsistent': 'Nem egyező OpenVPN-identitás',
      'tls_handshake_failed': 'Az OpenVPN-egyeztetést elutasították',
      'tls_alert_unknown_ca': 'Az OpenVPN-ügyféltanúsítványt nem ismerték fel',
      'tls_alert_bad_certificate':
          'Az OpenVPN-ügyféltanúsítványt elutasították',
      'tls_alert_unsupported_certificate': 'Nem támogatott OpenVPN-tanúsítvány',
      'tls_client_certificate_required': 'OpenVPN-ügyféltanúsítvány szükséges',
      'tls_alert_misc': 'OpenVPN TLS-riasztás',
      'tls_signature_algorithm_rejected': 'Nem támogatott OpenVPN-aláírás',
      'tls_handshake_rejected': 'Az OpenVPN TLS-egyeztetést elutasították',
      'tls_version_rejected': 'Nem kompatibilis OpenVPN TLS-verzió',
      'tls_certificate_expired': 'A TLS-tanúsítvány lejárt',
      'tls_certificate_revoked': 'A TLS-tanúsítványt visszavonták',
      'transport_failed': 'Az OpenVPN-szerver nem érhető el',
      'tun_configuration_rejected':
          'Az OpenVPN-interfészt nem sikerült létrehozni',
      'tun_setup_failed': 'Az OpenVPN TUN-beállítása sikertelen',
      'tun_interface_create_failed':
          'Az OpenVPN-interfész létrehozása sikertelen',
      'tun_interface_disabled': 'Az OpenVPN-interfész letiltva',
      'tun_halted': 'Az OpenVPN-interfész megszakadt',
      'tun_already_established': 'Az OpenVPN-interfész már nyitva van',
      'tun_addresses_missing': 'Hiányzik az OpenVPN-cím',
      'tun_routes_missing': 'Hiányoznak az OpenVPN-útvonalak',
      'tun_dns_missing': 'Hiányzik az OpenVPN DNS-beállítás',
      'tun_permission_revoked': 'A VPN-engedélyt visszavonták',
      'tun_establish_returned_null': 'Az Android elutasította a VPN-interfészt',
      'openvpn_service_start_failed': 'Az OpenVPN-szolgáltatás nem érhető el',
      'openvpn_operation_timeout': 'Időtúllépés az OpenVPN-hívásnál',
      'openvpn_start_failed': 'Az OpenVPN indítása elutasítva',
      'openvpn_connection_failed': 'Az OpenVPN-kapcsolat megszakadt',
      'openvpn_core_status_error': 'Az OpenVPN Core hibával leállt',
      'openvpn_stopped_before_connected':
          'Az OpenVPN a csatlakozás előtt leállt',
      'openvpn_auth_failed': 'Az OpenVPN-hitelesítést elutasították',
      'openvpn_client_setup_failed': 'Az OpenVPN-kliens beállítása sikertelen',
      'openvpn_client_halted': 'Az OpenVPN-kliens megszakadt',
      'openvpn_client_restart': 'Az OpenVPN újraindítását kérték',
      'openvpn_inactive_timeout': 'Az OpenVPN túl sokáig inaktív',
      'openvpn_session_expired': 'Az OpenVPN-munkamenet lejárt',
      'openvpn_credentials_required': 'Nem támogatott OpenVPN-hitelesítés',
      'openvpn_proxy_failed': 'Az OpenVPN-közvetítés sikertelen',
      'openvpn_compression_failed': 'Az OpenVPN-tömörítést elutasították',
      'openvpn_ntlm_crypto_unavailable':
          'Az OpenVPN NTLM-titkosítás nem érhető el',
      'openvpn_feature_unsupported': 'Nem támogatott OpenVPN-funkció',
      'network_unavailable': 'Az internetkapcsolat nem érhető el',
      'network_lost': 'A hálózat nem érhető el',
      'certificate_validation_failed': 'A szerver tanúsítványát elutasították',
      'openvpn_certificate_expired': 'Az OpenVPN-tanúsítvány lejárt',
      'tunnel_active_for_another_account': 'Egy másik fiók alagútja még aktív',
      'tunnel_already_active': 'A natív alagút már aktív',
      'tunnel_stop_timeout': 'A(z) $protocol leállítása nincs megerősítve',
      'tunnel_disconnected': 'A(z) $protocol megszakadt',
      'native_bridge_unavailable': 'Az Android-híd nem érhető el',
      'native_operation_failed': 'Az Android-művelet megszakadt',
      'invalid_arguments': 'Hiányos VPN-paraméterek',
      'invalid_account_id': 'Érvénytelen VPN-fiók',
      'invalid_device_id': 'Érvénytelen eszközazonosító',
      'storage_key_not_allowed': 'A tárolókulcsot elutasították',
      'secure_storage_read_failed': 'A biztonságos olvasás sikertelen',
      'secure_storage_write_failed': 'A biztonságos írás sikertelen',
      'key_generation_failed': 'A WireGuard-kulcsot nem sikerült létrehozni',
      'csr_generation_failed': 'Az OpenVPN CSR-t nem sikerült létrehozni',
      'openvpn_recovery_exhausted':
          'Az OpenVPN-helyreállítást már igénybe vették',
      'openvpn_recovery_failed': 'Az OpenVPN-helyreállítás sikertelen',
      'openvpn_renewal_required': 'Az OpenVPN-tanúsítványt meg kell újítani',
      'other': 'Besorolatlan natív VPN-hiba',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Az Android nem talál folytatható VPN-munkamenetet. Indítson új kapcsolatot az alkalmazásban.',
      'system_vpn_resume_corrupt':
          'A mentett VPN-folytatási adatok érvénytelenek, ezért nem lesznek felhasználva. Indítson új kapcsolatot.',
      'system_vpn_resume_session_invalid':
          'A mentett munkamenettel már nem lehet folytatni a VPN-t. Jelentkezzen be újra az alkalmazásban.',
      'system_vpn_resume_identity_changed':
          'A helyi VPN-identitás megváltozott. A folytatás leállt; indítson új kapcsolatot.',
      'system_vpn_resume_identity_invalid':
          'A folytatáshoz használt identitás érvénytelen. Indítson új kapcsolatot.',
      'system_vpn_resume_storage_failed':
          'Az Android nem tudta beolvasni vagy frissíteni a titkosított folytatási adatokat. Indítson új kapcsolatot.',
      'system_vpn_resume_network_timeout':
          'Az Android nem talált hálózatot időben a VPN folytatásához. Próbálja újra, amikor elérhető a hálózat.',
      'system_vpn_resume_blocked':
          'A VPN-folytatás blokkolva van. Ellenőrizze az Android-beállításokat, majd indítson új kapcsolatot.',
      'system_vpn_resume_failed':
          'Az Android VPN-folytatása sikertelen. Indítson új kapcsolatot az alkalmazásban.',
      'system_vpn_resume_error_invalid':
          'Az Android értelmezhetetlen folytatási hibát jelzett. Indítson új kapcsolatot.',
      'wireguard_identity_store_failed':
          'Az Android nem tudta elmenteni ennek a fióknak a titkosított WireGuard-identitását.',
      'wireguard_identity_unavailable':
          'Ehhez a kapcsolathoz nincs használható WireGuard-identitás.',
      'vpn_host_destroyed':
          'A VPN-t futtató Android-összetevő leállt. Indítson új kapcsolatot.',
      'vpn_host_unavailable':
          'Az Android nem tudja létrehozni a VPN-t futtató összetevőt. Ellenőrizze a VPN-beállításokat, majd próbálja újra.',
      'openvpn_renewal_required':
          'Az OpenVPN-tanúsítványt nem sikerült automatikusan megújítani. Indítson új kapcsolatot az alkalmazásban.',
      'openvpn_recovery_failed':
          'Az automatikus helyreállítás sikertelen. Indítson új kapcsolatot az alkalmazásban.',
      'openvpn_recovery_exhausted':
          'Az automatikus helyreállítást már igénybe vették. Indítson új kapcsolatot az alkalmazásban.',
      'vpn_permission_required':
          'Az Android új VPN-engedélyt kér az alagút indítása előtt.',
      'vpn_permission_denied':
          'A folytatáshoz engedélyezze a FuzeVPN-t az Android kérésében.',
      'vpn_permission_request_failed':
          'Az Android nem tudta megnyitni a VPN-engedély képernyőjét.',
      'wireguard_foreground_service_unavailable':
          'Az Android nem tudta az előtérben tartani a WireGuard-szolgáltatást.',
      'wireguard_identity_invalid':
          'Ennek a fióknak a titkosított WireGuard-kulcsa olvashatatlan vagy érvénytelen.',
      'wireguard_identity_in_use':
          'Egy másik művelet még használja ennek a fióknak a WireGuard-kulcsát.',
      'wireguard_configuration_invalid':
          'A kapott WireGuard-cím, DNS, szerverkulcs vagy útvonalak érvénytelenek.',
      'wireguard_operation_pending':
          'Az előző WireGuard-művelet még nem szabadította fel a natív szolgáltatását.',
      'wireguard_start_failed':
          'A WireGuard-motor elutasította a konfiguráció aktiválását.',
      'wireguard_stop_timeout':
          'A WireGuard-szolgáltatás a megadott időn belül nem erősítette meg a VPN-interfész felszabadítását.',
      'wireguard_handshake_timeout':
          'Az alagút nem erősítette meg időben a kézfogást a szerverrel.',
      'openvpn_connection_timeout':
          'Az OpenVPN nem erősítette meg időben a kapcsolatot a szerverrel.',
      'openvpn_core_unavailable':
          'Ez az alkalmazásverzió nem tartalmaz használható OpenVPN-motort.',
      'openvpn_operation_pending':
          'A natív motor még tartja az előző OpenVPN-munkamenetet, ezért nem hoz létre másodikat.',
      'openvpn_stop_timeout':
          'Az OpenVPN Core a megadott időn belül nem erősítette meg, hogy natív munkamenete leállt és megsemmisült.',
      'openvpn_profile_unavailable':
          'Ehhez a kapcsolathoz nem olvasható be ellenőrzött OpenVPN-profil.',
      'openvpn_native_failed':
          'Az alkalmazás hibája megszakította az OpenVPN-t. Próbáljon meg újra csatlakozni. Ha a probléma továbbra is fennáll, futtasson diagnosztikát.',
      'openvpn_key_generation_failed':
          'Az Android Keystore nem tudta létrehozni vagy beolvasni a nem exportálható P-256 privát kulcsot.',
      'openvpn_csr_generation_failed':
          'Az Android Keystore kulcsa nem tudta aláírni az OpenVPN-tanúsítványkérelmet.',
      'openvpn_identity_store_failed':
          'Az OpenVPN-tanúsítványt vagy -profilt nem sikerült titkosított tárolóban elmenteni.',
      'openvpn_identity_clear_failed':
          'Az Android nem tudta teljesen eltávolítani ennek a fióknak a helyi OpenVPN-identitását.',
      'openvpn_identity_in_use':
          'Egy natív OpenVPN-munkamenet még használja ennek az eszköznek a kulcsát vagy tanúsítványát.',
      'openvpn_tls_verification_required':
          'A profil nem kéri kifejezetten a szerver tanúsítványának ellenőrzését.',
      'openvpn_cipher_invalid':
          'A szerver az engedélyezett listán nem szereplő titkosítási algoritmust adott meg.',
      'openvpn_profile_rejected':
          'A szervertől kapott profil nem kompatibilis. Hozza létre újra ezt az eszközt, és próbálja újra.',
      'openvpn_identity_inconsistent':
          'A tanúsítvány nem egyezik ennek a telefonnak a biztonságos identitásával. Egyik helyi profilt sem cserélték le.',
      'tls_handshake_failed':
          'A szerver elutasította a TLS-egyeztetést. Ha a probléma továbbra is fennáll, hozza létre újra a profilt.',
      'tls_alert_unknown_ca':
          'A szerver nem ismeri fel ennek az eszköznek a tanúsítványát kibocsátó hatóságot. Az OpenVPN-szervert ellenőrizni kell.',
      'tls_alert_bad_certificate':
          'A szerver elutasította ennek az eszköznek a tanúsítványát. Mielőtt újra próbálkozna, hozza létre újra az eszközt.',
      'tls_alert_unsupported_certificate':
          'A szerver nem támogatja az Android által használt biztonságos tanúsítványtípust.',
      'tls_client_certificate_required':
          'A szerver ügyféltanúsítványt igényel, de az OpenVPN Core nem tudott ilyet bemutatni.',
      'tls_alert_misc':
          'A szerver a tanúsítvány- és verziókategórián kívül eső TLS-riasztást küldött.',
      'tls_signature_algorithm_rejected':
          'A szerver elutasította az Android Keystore-kulcs ECDSA P-256 algoritmusát.',
      'tls_handshake_rejected':
          'A szerver a csatlakozás előtt megszakította a TLS-egyeztetést.',
      'tls_version_rejected':
          'A kliens és a szerver nem talált közös TLS-verziót.',
      'tls_certificate_expired':
          'A csatlakozás során bemutatott tanúsítvány lejárt.',
      'tls_certificate_revoked':
          'A csatlakozás során bemutatott tanúsítványt visszavonták.',
      'transport_failed':
          'Az OpenVPN-szerver nem válaszol a jelenlegi hálózaton. Próbálja újra kis idő múlva.',
      'tun_configuration_rejected':
          'Az Android elutasította az OpenVPN által kért hálózati konfigurációt.',
      'tun_setup_failed':
          'Az OpenVPN Core elutasította a hálózati konfigurációt, mielőtt létrehozta volna az Android-interfészt.',
      'tun_interface_create_failed':
          'Az OpenVPN Core nem tudta megszerezni a TUN-interfészt az Android VpnService-től.',
      'tun_interface_disabled':
          'Az Android vagy az OpenVPN Core letiltotta a TUN-interfészt a kapcsolat során.',
      'tun_halted':
          'Az OpenVPN Core kérést kapott a TUN-interfész leállítására.',
      'tun_already_established':
          'Az OpenVPN második interfészt kért ugyanabban a kapcsolatban. Biztonsági okokból az alagút leállt.',
      'tun_addresses_missing':
          'A szerver nem adott meg használható alagútcímet.',
      'tun_routes_missing':
          'A szerver nem adott meg használható alagútútvonalakat.',
      'tun_dns_missing': 'A szerver nem adott meg használható DNS-szervert.',
      'tun_permission_revoked':
          'Az Android a kapcsolat során visszavonta a VPN-engedélyt.',
      'tun_establish_returned_null':
          'Az Android nem hozta létre az interfészt, általában azért, mert egy másik VPN még aktív.',
      'openvpn_service_start_failed':
          'Az Android nem tudta elindítani az OpenVPN előtérszolgáltatását.',
      'openvpn_operation_timeout':
          'A JNI-hívás az OpenVPN Core felé meghaladta a maximális időtartamot.',
      'openvpn_start_failed':
          'Az Android-szolgáltatás kész, de az OpenVPN Core nem fogadta el a profil indítását.',
      'openvpn_connection_failed':
          'Az OpenVPN Core a CONNECTED esemény kiadása előtt leállt.',
      'openvpn_core_status_error':
          'A natív OpenVPN-ciklus hibával ért véget, pontosabb záró esemény nélkül.',
      'openvpn_stopped_before_connected':
          'A natív OpenVPN-ciklus a CONNECTED előtt leállt, kifejezett Core-hiba nélkül.',
      'openvpn_auth_failed':
          'Az OpenVPN-szerver elutasította a profil hitelesítését.',
      'openvpn_client_setup_failed':
          'Az OpenVPN Core nem tudta inicializálni a klienst a hálózati kapcsolat előtt.',
      'openvpn_client_halted':
          'Az OpenVPN Core végleges kliensleállítást kapott.',
      'openvpn_client_restart':
          'Az OpenVPN Core az átviteli munkamenet újraindítását kérte.',
      'openvpn_inactive_timeout':
          'Az OpenVPN Core az inaktivitási időkorlát után lezárta a munkamenetet.',
      'openvpn_session_expired':
          'A szerver jelezte, hogy az OpenVPN-munkamenet lejárt.',
      'openvpn_credentials_required':
          'A szerver vagy egy proxy olyan interaktív hitelesítő adatokat kér, amelyek nem részei ennek a tanúsítványprofilnak.',
      'openvpn_proxy_failed':
          'Az OpenVPN Core a beállított proxy vagy közvetítő hibáját jelezte.',
      'openvpn_compression_failed':
          'Az OpenVPN Core elutasította a profil vagy a szerver által jelzett tömörítési módot.',
      'openvpn_ntlm_crypto_unavailable':
          'A profil olyan NTLM-titkosítást kér, amely ebben a verzióban nem érhető el.',
      'openvpn_feature_unsupported':
          'A profil vagy a szerver olyan funkciót igényel, amely ebből az Android-kliensből hiányzik.',
      'network_unavailable': 'Nincs használható fizikai hálózat.',
      'network_lost': 'Az alagút leállt, miután megszakadt a hálózat.',
      'certificate_validation_failed':
          'Az OpenVPN-szerver azonosságát nem sikerült ellenőrizni.',
      'openvpn_certificate_expired':
          'Az OpenVPN-tanúsítvány lejárt. A megújításához indítson új kapcsolatot az alkalmazásban.',
      'tunnel_active_for_another_account':
          'Egy másik fiókhoz tartozó alagútnak le kell állnia, mielőtt ez a kapcsolat létrejön.',
      'tunnel_already_active':
          'Az Android jelzi, hogy egy korábbi VPN-munkamenet még használja az interfészt.',
      'tunnel_stop_timeout':
          'A(z) $protocol-motor nem erősítette meg a VPN-interfész felszabadítását a megadott időn belül.',
      'tunnel_disconnected':
          'A natív motor jelezte, hogy az alagút az indítás után váratlanul megszakadt.',
      'native_bridge_unavailable':
          'Az alkalmazás nem fér hozzá az Android VPN-szolgáltatáshoz. Zárja be és nyissa meg újra az alkalmazást, majd próbálja újra.',
      'native_operation_failed':
          'Az alkalmazás hibája megszakította a VPN-műveletet. Próbálja újra. Ha a probléma továbbra is fennáll, futtasson diagnosztikát.',
      'invalid_arguments':
          'A VPN-művelethez szükséges adatok hiányosak. Próbálja újra. Ha a probléma továbbra is fennáll, futtasson diagnosztikát.',
      'invalid_account_id':
          'A natív művelet nem kapcsolódik érvényes fiókazonosítóhoz.',
      'invalid_device_id':
          'A natív motornak küldött eszközazonosító hiányzik vagy érvénytelen.',
      'storage_key_not_allowed':
          'Az Android-híd letiltott egy kulcsot, amely nem szerepel az engedélyezett tárolólistán.',
      'secure_storage_read_failed':
          'Az Android Keystore nem tudta visszafejteni ennek a fióknak a helyi adatait.',
      'secure_storage_write_failed':
          'Az Android Keystore nem tudta titkosítani vagy menteni a helyi adatokat.',
      'key_generation_failed':
          'Az Android nem tudta létrehozni vagy beolvasni a WireGuard-kulcsot a biztonságos tárolóban.',
      'csr_generation_failed':
          'Az Android Keystore nem tudta létrehozni vagy aláírni az OpenVPN P-256 CSR-t.',
      'other':
          'Egy dokumentálatlan natív ágban hiba történt. Küldje el az alábbi diagnosztikai kódot az ügyfélszolgálatnak.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Az engedélykérés már nyitva van';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Az Android VPN-engedélykérés már látható. Fejezze be, mielőtt újra próbálkozna.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'A VPN-engedélykérés megszakadt';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'A VPN-engedély képernyője bezárult, mielőtt az alkalmazás választ kapott volna.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Az OpenVPN-kapcsolat nincs megerősítve';

  @override
  String get notice_openvpnProofMissing_message =>
      'Az OpenVPN-kapcsolatot nem sikerült megerősíteni. Biztonsági okokból leállítottuk. Próbálja újra.';

  @override
  String get openvpnCleanup_title => 'Az OpenVPN-profil visszavonva';

  @override
  String get openvpnCleanup_working =>
      'A visszavont OpenVPN-profil leállítása és eltávolítása…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Az OpenVPN leállítása nincs megerősítve. Új profil létrehozása előtt próbálja újra.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'A visszavont OpenVPN-profilt nem sikerült teljesen eltávolítani. Próbálja újra az eltávolítást.';

  @override
  String get openvpnCleanup_complete =>
      'A visszavont OpenVPN-profilt eltávolítottuk. Új profil létrehozásához koppintson a Csatlakozás gombra.';

  @override
  String get network_title => 'Hálózati konfiguráció';

  @override
  String get network_ipv4Fallback =>
      'Az IPv6 átmenetileg nem érhető el. Az előkészítés IPv4-gyel folytatódik.';

  @override
  String get network_rejectedTitle => 'A hálózati konfigurációt elutasították';

  @override
  String get network_rejectedMessage =>
      'Az alagút beállítása hiányos, vagy nem egyezik a jóváhagyott címekkel. Próbálja újra az alkalmazásból.';

  @override
  String get network_unreadableTitle => 'A helyi konfiguráció olvashatatlan';

  @override
  String get network_unreadableMessage =>
      'A mentett OpenVPN-hálózati konfiguráció nem használható. Csatlakozzon újra az alkalmazásból a frissítéshez.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Hálózati védelem';

  @override
  String get protection_subtitle =>
      'Tiltsa le a közvetlen internet-hozzáférést, ha a VPN megszakad.';

  @override
  String get protection_active => 'A rendszervédelem aktív';

  @override
  String get protection_alwaysOnOnly =>
      'A Mindig bekapcsolt VPN engedélyezve van; kapcsolja be a VPN nélküli kapcsolatok letiltását is';

  @override
  String get protection_inactive => 'A rendszervédelem inaktív';

  @override
  String get protection_unknown => 'Ellenőrizze a rendszervédelmet';

  @override
  String get protection_openSettings => 'Android-beállítások megnyitása';

  @override
  String get protection_dialogTitle => 'Hálózati védelem beállítása';

  @override
  String get protection_dialogMessage =>
      'Az Android kezeli a Mindig bekapcsolt VPN funkciót és a VPN nélküli kapcsolatok letiltását. Ellenőrizze, hogy a FuzeVPN van-e kiválasztva, és kapcsolja be a letiltást a rendszerbeállításokban.';

  @override
  String get protection_dialogOpen => 'Beállítások megnyitása';

  @override
  String get session_systemProtectionNote =>
      'Ha az Android még mindig blokkolja a VPN-en kívüli forgalmat, nyissa meg a rendszerbeállításokat, és ellenőrizze vagy módosítsa ezt a védelmet.';

  @override
  String get diagnostics_title => 'Diagnosztika';

  @override
  String get diagnostics_settingsTitle => 'Alkalmazásdiagnosztika';

  @override
  String get diagnostics_automaticTitle => 'Fontos hibák küldése';

  @override
  String get diagnostics_automaticDescription =>
      'Rövid műszaki jelentés megosztása, ha fontos hiba történik.';

  @override
  String get diagnostics_privacy =>
      'Az elküldött jelentések a bejelentkezett fiókhoz kapcsolódnak, és 30 napig megőrizzük őket. Nem tartalmaznak böngészési előzményeket, jelszavakat vagy VPN-kulcsokat.';

  @override
  String get diagnostics_manualOpen => 'Diagnosztika futtatása';

  @override
  String get diagnostics_localDescription =>
      'Készítsen jelentést az alkalmazás és a VPN állapotáról. A kapcsolata nem változik.';

  @override
  String get diagnostics_sendReport => 'Jelentés küldése';

  @override
  String get diagnostics_sendHint =>
      'Hagyja ezt a jelölőnégyzetet üresen, hogy a jelentés ezen az eszközön maradjon.';

  @override
  String get diagnostics_signedOut =>
      'Jelentkezzen be fiókjába a jelentés elküldéséhez.';

  @override
  String get diagnostics_localLifetime =>
      'Mentse el a jelentést a telefonjára, hogy az alkalmazás bezárása után is megmaradjon.';

  @override
  String get diagnostics_run => 'Diagnosztika futtatása';

  @override
  String get diagnostics_rerun => 'Diagnosztika újrafuttatása';

  @override
  String get diagnostics_running => 'Ellenőrzés…';

  @override
  String get diagnostics_sending => 'Jelentés küldése…';

  @override
  String get diagnostics_prepared => 'A jelentés elkészült ezen az eszközön';

  @override
  String get diagnostics_queued => 'A jelentés elküldésre vár';

  @override
  String get diagnostics_sent => 'A jelentés megérkezett';

  @override
  String get diagnostics_failed =>
      'A küldés sikertelen. A helyi jelentés továbbra is elérhető.';

  @override
  String get diagnostics_preparationFailed =>
      'A diagnosztikai jelentést nem sikerült elkészíteni. Próbálja újra.';

  @override
  String get diagnostics_authenticationRequired =>
      'A jelentés elküldéséhez jelentkezzen be újra.';

  @override
  String get diagnostics_retry => 'Küldés újrapróbálása';

  @override
  String get diagnostics_export => 'Jelentés mentése';

  @override
  String get diagnostics_exportFailed =>
      'Az exportálás sikertelen. Próbálja újra a helyi jelentésből.';

  @override
  String get diagnostics_preferenceFailed =>
      'Ezt a beállítást nem sikerült menteni. Próbálja újra.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Azonosító: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Beérkezett: $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Megőrizve eddig: $date';
  }

  @override
  String get diagnostics_duplicate => 'Ez a jelentés már korábban beérkezett.';

  @override
  String get diagnostics_preview => 'A jelentés előnézete';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count csatolt műszaki esemény',
      one: '1 csatolt műszaki esemény',
      zero: 'Nincs csatolt műszaki esemény',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Műszaki részletek';

  @override
  String get diagnostics_empty => 'Még nem készült diagnosztikai jelentés.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Alagút állapota',
      'handshake': 'Kapcsolat megerősítése',
      'certificate': 'VPN-tanúsítvány',
      'kill_switch': 'Android-védelem',
      'connectivity': 'Elérhető hálózat',
      'api_reachability': 'Szolgáltatás elérése',
      'secure_storage': 'Biztonságos tárolás',
      'other': 'Helyi ellenőrzés',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Ellenőrizve',
      'failed': 'Figyelmet igényel',
      'skipped': 'Nem tesztelve – nincs aktív próba',
      'unknown': 'Az információ nem érhető el',
      'other': 'Az információ nem érhető el',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Üdvözöljük a FuzeVPN-ben';

  @override
  String get connection_changeLocation => 'Hely váltása';

  @override
  String get connection_details => 'Kapcsolat részletei';

  @override
  String get locations_searchLabel => 'Város vagy ország keresése';

  @override
  String get locations_clearSearch => 'Keresés törlése';

  @override
  String get locations_filterAll => 'Összes';

  @override
  String get locations_filterFavorites => 'Kedvencek';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hely',
      one: '$count hely',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nem található hely';

  @override
  String get locations_noResultsHint => 'Próbáljon másik várost vagy országot.';

  @override
  String get locations_noFavorites => 'Kedvencei mindig kéznél';

  @override
  String get locations_noFavoritesHint =>
      'Koppintson egy hely melletti csillagra, hogy itt mentse el.';

  @override
  String get locations_showAll => 'Összes hely megtekintése';

  @override
  String locations_addFavorite(String name) {
    return '$name hozzáadása a kedvencekhez';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name eltávolítása a kedvencekből';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'A kedvencet nem sikerült menteni. Próbálja újra.';

  @override
  String get locations_emptyTitle => 'Nincs elérhető hely';

  @override
  String get locations_emptyHint => 'Az újrapróbálkozáshoz frissítse a listát.';

  @override
  String get devices_manage => 'Eszközeim kezelése';

  @override
  String get settings_personalization => 'Személyre szabás';

  @override
  String get settings_safety => 'Védelem';

  @override
  String get settings_help => 'Segítségre van szüksége?';

  @override
  String get settings_about => 'A FuzeVPN-ről';

  @override
  String get diagnostics_heading => 'Kapcsolati probléma kivizsgálása';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Elérhető',
      'pending': 'Előkészítés alatt',
      'revoked': 'Eltávolítva',
      'expired': 'Lejárt',
      'other': 'Az állapot nem érhető el',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'A beállítás nincs mentve';

  @override
  String get notice_preferenceSave_message =>
      'A választása egyelőre érvényben van, de nem sikerült elmenteni. Próbálja újra, hogy az alkalmazás bezárása után is megmaradjon.';

  @override
  String get connection_androidDisconnectHint =>
      'Ha az Android továbbra is aktívan tartja a VPN-t, kapcsolja ki a megnyíló beállításokban a „Mindig bekapcsolt VPN” lehetőséget.';

  @override
  String get connection_certificate => 'OpenVPN-tanúsítvány';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Érvényes eddig: $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Lejárt: $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'A következő csatlakozáskor automatikusan megújul.';

  @override
  String get protection_learnMore => 'Tudjon meg többet az Android-védelemről';

  @override
  String get protection_guideWhy =>
      'Ez a védelem megakadályozza, hogy az alkalmazások közvetlenül az internetet használjanak, ha a VPN-kapcsolat megszakad. Ezt az Android rendszerben lehet beállítani.';

  @override
  String get protection_guideAlwaysOnTitle => 'Mindig bekapcsolt VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Az Android folyamatosan futtatja a VPN-szolgáltatást, és a telefon újraindítása után újra el tudja indítani.';

  @override
  String get protection_guideBlockTitle => 'VPN nélküli kapcsolatok letiltása';

  @override
  String get protection_guideBlock =>
      'Ez a beállítás megakadályozza, hogy az adatforgalom megkerülje a VPN-t, még akkor is, ha a kapcsolat megszakad.';

  @override
  String get protection_guideWarning =>
      'Ha ez a letiltás be van kapcsolva, az internet nem érhető el, amíg a VPN nem csatlakozik.';

  @override
  String get protection_guideStepsTitle => 'Védelem bekapcsolása';

  @override
  String get protection_guideStep1 =>
      'Nyissa meg az Android VPN-beállításait az alábbi gombbal.';

  @override
  String get protection_guideStep2 =>
      'A FuzeVPN mellett lévő fogaskerék ikonra koppintva nyissa meg a beállításokat.';

  @override
  String get protection_guideStep3 =>
      'Ha elérhetők, kapcsolja be a „Mindig bekapcsolt VPN”, majd a „VPN nélküli kapcsolatok letiltása” beállítást.';

  @override
  String get protection_guideManufacturers =>
      'A nevek telefononként eltérhetnek. Ha szükséges, keressen rá a „VPN” kifejezésre a Beállításokban, gyakran a Hálózat és internet menüpontban.';

  @override
  String get protection_guideDisableTitle => 'Védelem kikapcsolása';

  @override
  String get protection_guideDisable =>
      'Ugyanezekben a beállításokban kapcsolja ki a VPN nélküli kapcsolatok letiltását, hogy VPN nélkül is elérhető legyen az internet. Ha már nem szeretné, hogy az Android újraindítsa, a Mindig bekapcsolt VPN beállítást is kapcsolja ki.';

  @override
  String get protection_guideManual =>
      'Ezeket a beállításokat Androidban adhatja meg. A FuzeVPN nem módosítja őket Ön helyett.';

  @override
  String get locations_changeTitle => 'Hely váltása?';

  @override
  String locations_changeActive(String name) {
    return 'A VPN lekapcsolódik, majd megpróbál csatlakozni ide: $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'A VPN megpróbál csatlakozni ide: $name.';
  }

  @override
  String get locations_confirmChange => 'Váltás és csatlakozás';

  @override
  String get locations_changeBusy =>
      'Éppen váltás zajlik. Várjon, mielőtt másik helyet választana.';

  @override
  String get locations_automaticSelection => 'Automatikus kiválasztás';

  @override
  String get locations_cities => 'Városok';

  @override
  String get locations_servers => 'Szerverek';

  @override
  String locations_viewCities(String name) {
    return 'Városok megtekintése: $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Szerverek megtekintése: $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ország',
      one: '$count ország',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count város',
      one: '$count város',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count szerver',
      one: '$count szerver',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Összes ország';

  @override
  String get locations_backToCountries => 'Vissza az országokhoz';

  @override
  String locations_backToCities(String name) {
    return 'Vissza a városokhoz: $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name kiválasztása';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name kiválasztása';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nincs elérhető kompatibilis szerver.';

  @override
  String get externalLink_failed =>
      'A hivatkozást nem lehet megnyitni. Másolja ki, és nyissa meg a böngészőben.';

  @override
  String get externalLink_copy => 'Hivatkozás másolása';

  @override
  String get externalLink_copied => 'Hivatkozás másolva';

  @override
  String get externalLink_copyFailed =>
      'A hivatkozást nem lehet másolni. Jelölje ki az alábbi címet.';

  @override
  String get settings_deleteAccount => 'Fiókom törlése';

  @override
  String get settings_deleteAccountDetail =>
      'A fióktörlési kérelem menetének megtekintése';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Válassza ki a VPN-előfizetését.';

  @override
  String get billing_subscribe => 'Előfizetés';

  @override
  String get billing_choosePlan => 'Válasszon csomagot a folytatáshoz.';

  @override
  String get billing_monthly => 'Havi';

  @override
  String get billing_yearly => 'Éves';

  @override
  String get billing_continue => 'Folytatás a Google Play-en keresztül';

  @override
  String get billing_restore => 'Vásárlások visszaállítása';

  @override
  String get billing_manage => 'Előfizetés kezelése';

  @override
  String get billing_deleteAccountWarning =>
      'Ha van Google Play-előfizetése, a FuzeVPN-fiók törlése nem szünteti meg annak megújulását. A megújulást külön kezelheti vagy mondhatja le a Google Play-ben.';

  @override
  String get billing_deleteAccountContinue => 'Tovább a fióktörlési kérelemhez';

  @override
  String get billing_refresh => 'Hozzáférés frissítése';

  @override
  String get billing_loadingPlans => 'Csomagok betöltése…';

  @override
  String get billing_unavailable =>
      'Jelenleg nincs elérhető csomag. Próbálja újra később.';

  @override
  String get billing_comingSoon => 'Az előfizetések hamarosan érkeznek.';

  @override
  String get billing_priceDisclosure =>
      'Az árat a Google Play adja meg. A végső összeget és az alkalmazandó adókat a rendszer a jóváhagyás előtt visszaigazolja.';

  @override
  String get billing_renewalMonthly =>
      'Havonta automatikusan megújul, amíg le nem mondja. Bármikor lemondhatja a Google Play Előfizetések menüpontjában.';

  @override
  String get billing_renewalYearly =>
      'Évente automatikusan megújul, amíg le nem mondja. Bármikor lemondhatja a Google Play Előfizetések menüpontjában.';

  @override
  String get billing_active => 'A Premium-hozzáférése aktív';

  @override
  String billing_accessUntil(String date) {
    return 'A hozzáférés eddig: $date.';
  }

  @override
  String get billing_webManaged =>
      'Az előfizetését a FuzeVPN weboldalán kezelik.';

  @override
  String get billing_playManaged => 'Az előfizetését a Google Play kezeli.';

  @override
  String get billing_playOnHold =>
      'A Google Play-előfizetése felfüggesztve van, vagy fizetésre vár. A rendezéshez nyissa meg az „Előfizetés kezelése” lehetőséget a Google Play-ben.';

  @override
  String get billing_playReceiptUnlinked =>
      'Ehhez a Google Play-fiókhoz már tartozik egy Fuze Premium-előfizetés, amely ehhez a FuzeVPN-fiókhoz nem aktív. Az áttekintéshez nyissa meg az „Előfizetés kezelése” lehetőséget a Google Play-ben.';

  @override
  String get billing_inactive => 'Nincs aktív előfizetés.';

  @override
  String get billing_checkingAccess => 'Hozzáférés ellenőrzése…';

  @override
  String get billing_restoring => 'Vásárlások visszaállítása…';

  @override
  String get billing_pending =>
      'A fizetés függőben van. A hozzáférés a megerősítés után aktiválódik.';

  @override
  String get billing_cancelled =>
      'A vásárlás megszakítva. Nem aktiválódott új előfizetés.';

  @override
  String get billing_verifying => 'Vásárlás ellenőrzése…';

  @override
  String get billing_success =>
      'Az előfizetés aktiválva. A Premium-hozzáférése készen áll.';

  @override
  String get billing_restored => 'A vásárlásai visszaállítva.';

  @override
  String get billing_restoreEmpty =>
      'Ehhez a Google Play-fiókhoz nincs visszaállítandó vásárlás.';

  @override
  String get billing_catalogError =>
      'A csomagokat nem lehet betölteni. Próbálja újra.';

  @override
  String get billing_purchaseError =>
      'A vásárlást nem lehet elindítani. Próbálja újra.';

  @override
  String get billing_verificationError =>
      'A vásárlás ellenőrzése átmenetileg nem érhető el. Az újrapróbálkozáshoz állítsa vissza a vásárlásokat.';

  @override
  String get billing_restoreError =>
      'A vásárlásokat nem lehet visszaállítani. Próbálja újra.';

  @override
  String get billing_managementError =>
      'Az előfizetéskezelést nem lehet megnyitni. Próbálja újra.';

  @override
  String get billing_storeUnavailable =>
      'A Google Play nem érhető el ezen az eszközön.';

  @override
  String get welcome_title => 'Az Ön VPN-je, egyszerűen.';

  @override
  String get welcome_description =>
      'Védje a kapcsolatát. Tartsa kézben az adatvédelmét.';

  @override
  String get welcome_start => 'Kezdés';

  @override
  String get welcome_alreadyPurchased => 'Már vásárolt?';

  @override
  String get welcome_noAccountRequired => 'A kezdéshez nincs szükség fiókra.';

  @override
  String get guest_accountTitle => 'A fiók nincs összekapcsolva';

  @override
  String get guest_accountDescription =>
      'Állítsa vissza a vásárlásait ugyanazzal a Google Play-fiókkal, hogy másik eszközén is használhassa az előfizetését.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Már előfizetett? Jelentkezzen be';

  @override
  String get guest_claimTitle => 'Vigye magával a FuzeVPN-t';

  @override
  String get guest_claimDescription =>
      'Hozzon létre fiókot, hogy más eszközein is elérhesse az előfizetését. Ez a lépés nem kötelező.';

  @override
  String get guest_skip => 'Majd később';

  @override
  String get guest_activationTitle => 'A Fuze Premium aktív';

  @override
  String get guest_activationDescription =>
      'Az előfizetése készen áll. Használja a VPN-t, és amikor szeretné, hozzon létre fiókot.';

  @override
  String get guest_useVpn => 'VPN használata';

  @override
  String get guest_loginRequired =>
      'Ez a vásárlás már egy FuzeVPN-fiókhoz tartozik. Az előfizetés eléréséhez jelentkezzen be abba a fiókba.';

  @override
  String get guest_signOutWarning =>
      'Visszanyerheti előfizetését, ha ugyanazzal a Google Play-fiókkal visszaállítja a vásárlásait.';

  @override
  String get guest_profileUnavailable =>
      'A fiókja már össze van kapcsolva. Jelentkezzen be az adatai megtekintéséhez és kezeléséhez.';

  @override
  String get billing_acceptance =>
      'A folytatással elfogadja a felhasználási feltételeket és az adatvédelmi szabályzatot.';

  @override
  String get guest_verifyEmailReminder =>
      'Erősítse meg e-mail-címét a fiókja védelme érdekében. A VPN-t továbbra is használhatja.';

  @override
  String get guest_serviceUnavailable =>
      'A szolgáltatás átmenetileg nem érhető el. Próbálja újra kis idő múlva.';

  @override
  String get guest_restoreError =>
      'A vásárlásait nem lehetett visszaállítani. Próbálja újra azzal a Google Play-fiókkal, amellyel a vásárlás történt.';

  @override
  String get guest_claimSuccess =>
      'A fiókja létrejött. Előfizetése és VPN-hozzáférése megmarad.';

  @override
  String get guest_emailExists =>
      'Ez az e-mail-cím már használatban van. Válasszon másik címet, vagy jelentkezzen be meglévő fiókjába. A vásárlása továbbra is elérhető a Google Play-en keresztül.';

  @override
  String get guest_claimError =>
      'A fiókját nem sikerült létrehozni. Továbbra is használhatja a VPN-t, és később újra próbálkozhat.';

  @override
  String get guest_secureStorageError =>
      'A munkamenetet nem sikerült biztonságosan tárolni ezen az eszközön. Próbálja újra.';

  @override
  String get guest_premiumRequired =>
      'Válasszon előfizetést a VPN aktiválásához.';

  @override
  String get welcome_viewPlans => 'Csomagok megtekintése';

  @override
  String get google_continue => 'Folytatás Google-lal';

  @override
  String get google_or => 'vagy';

  @override
  String get google_title => 'Az Ön FuzeVPN-fiókja';

  @override
  String get google_settingUp => 'Fejezze be a fiók létrehozását';

  @override
  String get google_country => 'Lakóhely szerinti ország';

  @override
  String get google_profileDescription =>
      'Válassza ki az országát, és tekintse át a két dokumentumot a FuzeVPN-fiókja létrehozásához.';

  @override
  String get google_claimDescription =>
      'Kapcsolja össze vendégfiókját a Google-lal. Előfizetése és eszköze továbbra is ehhez a fiókhoz tartozik.';

  @override
  String get google_linkTitle => 'Google összekapcsolása a FuzeVPN-nel';

  @override
  String get google_linkDescription =>
      'Erősítse meg a hozzáférést meglévő FuzeVPN-fiókjához. Ez a lépés nem kéri el a Google-jelszavát.';

  @override
  String get google_password => 'FuzeVPN-jelszó';

  @override
  String get google_linkAccount => 'Összekapcsolás megerősítése';

  @override
  String get google_requestEmail => 'Megerősítő e-mail küldése';

  @override
  String get google_emailInstructions =>
      'Nyissa meg a FuzeVPN e-mailjét, és adja meg a megerősítő kódot.';

  @override
  String get google_emailCode => 'E-mailben kapott megerősítő kód';

  @override
  String get google_confirmEmail => 'Kód megerősítése';

  @override
  String get google_restart => 'Másik Google-fiók választása';

  @override
  String get google_resume => 'Próbálkozás ellenőrzése';

  @override
  String get google_unavailable =>
      'A Google-bejelentkezés nem érhető el. E-mail-címmel és jelszóval is bejelentkezhet.';

  @override
  String get google_expired =>
      'Ez a próbálkozás lejárt. Szakítsa meg, és kezdje újra.';

  @override
  String get google_conflict =>
      'Ez a Google-fiók már máshol össze van kapcsolva. Jelenlegi fiókja és előfizetése megmarad.';

  @override
  String get google_error =>
      'A Google-bejelentkezés nem sikerült. Próbálja újra; jelenlegi hozzáférése megmarad.';

  @override
  String get google_uncertain =>
      'Az eredményt nem sikerült megerősíteni. Ellenőrizze ezt a próbálkozást, vagy szakítsa meg, mielőtt újrakezdi.';

  @override
  String get google_cancelFailed =>
      'A megszakítást nem sikerült megerősíteni. Próbálja meg újra megszakítani, mielőtt elhagyja ezt a képernyőt.';

  @override
  String get google_cancelled => 'A Google-bejelentkezés megszakítva.';

  @override
  String get google_selecting => 'Válassza ki a Google-fiókját…';

  @override
  String get google_verifying => 'Fiókja ellenőrzése…';

  @override
  String get google_emailUnavailable =>
      'A megerősítő e-mailt nem sikerült elküldeni. Próbálja újra később.';

  @override
  String get google_emailSent =>
      'A megerősítő e-mail elküldve. Nézze meg beérkező leveleit.';

  @override
  String get google_rateLimited => 'Kérjük, várjon, mielőtt újra megpróbálja.';

  @override
  String get google_busy =>
      'A Google nem érhető el, amíg másik művelet van folyamatban (VPN-kapcsolat, fiók vagy vendég). Próbálja újra, amint az befejeződött; jelenlegi hozzáférése megmarad.';

  @override
  String get google_invalidPassword =>
      'A FuzeVPN-jelszó helytelen. Jelenlegi fiókja megmarad.';

  @override
  String get google_invalidCode => 'A megerősítő kód érvénytelen vagy lejárt.';

  @override
  String get google_accountChanged =>
      'A munkamenete megváltozott. Szakítsa meg ezt a próbálkozást, mielőtt újrakezdi.';

  @override
  String get google_invalidResponse =>
      'A választ nem sikerült ellenőrizni. Jelenlegi hozzáférése megmarad.';

  @override
  String get google_invalidRegistration =>
      'Ellenőrizze az országát és mindkét hozzájárulást.';

  @override
  String get google_consentRequired =>
      'Válassza ki az országát, és fogadja el mindkét dokumentumot a folytatáshoz.';

  @override
  String get google_challengeRequired =>
      'További biztonsági ellenőrzés szükséges. Jelenlegi hozzáférése megmarad.';

  @override
  String get google_challengeUnavailable =>
      'A biztonsági ellenőrzés nem érhető el. Próbálja újra később.';

  @override
  String get google_intentMismatch =>
      'Egy korábbi Google-bejelentkezési próbálkozás még függőben van. Szakítsa meg, mielőtt elindítja ezt a műveletet.';

  @override
  String get google_challengeBlocked =>
      'A szükséges biztonsági ellenőrzés nem érhető el ebben az alkalmazásban. Ez a művelet jelenleg nem fejezhető be.';

  @override
  String get google_solveChallenge => 'Végezze el a biztonsági ellenőrzést';

  @override
  String get google_challengeTitle => 'Biztonsági ellenőrzés';

  @override
  String get google_challengeReady =>
      'Az ellenőrzés befejeződött. Most megerősítheti a fiók létrehozását.';

  @override
  String get google_challengeExpired =>
      'Az ellenőrzés lejárt. A megerősítés előtt végezze el újra.';

  @override
  String get google_challengeCancelled =>
      'Az ellenőrzés megszakítva. Újra megpróbálhatja.';

  @override
  String get google_challengeFailed =>
      'A biztonsági ellenőrzés nem sikerült. Próbálja újra.';

  @override
  String get billing_trialTitle => 'Próbálja ki ingyen a Fuze Premiumot';

  @override
  String get billing_trialSubtitle => 'Védje kapcsolatát már ma.';

  @override
  String get billing_trialWeeks => '2 hetes ingyenes próbaidőszak';

  @override
  String billing_trialDays(String days) {
    return '$days napos ingyenes próbaidőszak';
  }

  @override
  String get billing_trialStart => 'Ingyenes próbaidőszak indítása';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ha ma kezdi, az első terhelés várhatóan ekkor lesz: $date.';
  }

  @override
  String get billing_trialTerms =>
      'Automatikusan megújul a feltüntetett áron. A terhelés elkerüléséhez mondja le az előfizetést a Google Play-ben a próbaidőszak vége előtt.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Ezt követően havonta $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Ezt követően évente $price';
  }

  @override
  String get billing_choosePeriod => 'Válassza ki a csomagot';

  @override
  String get billing_selectionHint => 'Válasszon csomagot a folytatáshoz.';

  @override
  String get billing_benefitConnection => 'Titkosított kapcsolat';

  @override
  String get billing_benefitPrivacy => 'Online adatvédelem';

  @override
  String get billing_benefitNoAccount => 'Regisztráció nem szükséges';

  @override
  String get billing_cancellation => 'Lemondás a Google Play-ben';

  @override
  String get billing_premiumTitle => 'Jobban védett kapcsolat.';

  @override
  String get billing_premiumSubtitle => 'Védje kapcsolatát a saját tempójában.';

  @override
  String get billing_priceMonthly => 'havonta';

  @override
  String get billing_priceYearly => 'évente';

  @override
  String get billing_trialToday => 'Ma semmit sem kell fizetnie';

  @override
  String get billing_trialConfirmation =>
      'A Google Play a jóváhagyás előtt visszaigazolja a dátumokat, a végső összeget és az alkalmazandó adókat.';

  @override
  String get billing_offerChanged =>
      'Az ajánlat feltételei megváltoztak. Frissítse a csomagokat, és válasszon újra.';

  @override
  String get status_waitingNetwork => 'Várakozás a hálózatra';

  @override
  String get status_waitingNetworkDetail =>
      'Nincs elérhető hálózat. A hálózat újbóli elérhetővé válásakor a VPN ellenőrzi a kapcsolatot.';

  @override
  String get locations_favoriteLoadFailed =>
      'A kedvenceket nem sikerült betölteni. Próbálja újra.';

  @override
  String get locations_favoritesLoading => 'Kedvencek betöltése…';
}
