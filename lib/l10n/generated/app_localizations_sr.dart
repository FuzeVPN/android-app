// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Заштитите своју везу';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN користи VPN услугу система Android (VpnService) да успостави шифровани тунел између овог уређаја и FuzeVPN сервера.';

  @override
  String get vpnDisclosure_dataBody =>
      'Док је VPN активан, интернет саобраћај ваших апликација, одредишне адресе и DNS захтеви пролазе кроз овај тунел ради усмеравања ваше везе, чак и када је FuzeVPN у позадини.';

  @override
  String get vpnDisclosure_statusBody =>
      'Апликација користи стање везе, њено трајање и количину пренетих података да прикаже вашу VPN везу. Можете је зауставити у било ком тренутку.';

  @override
  String get vpnDisclosure_privacy => 'Приватност';

  @override
  String get vpnDisclosure_accept => 'Прихвати и настави';

  @override
  String get vpnDisclosure_decline => 'Не сада';

  @override
  String get accountRestoration_title => 'Налог је привремено недоступан';

  @override
  String get accountRestoration_message =>
      'Ваша сесија је сачувана. Покушајте поново да вратите налог. И даље можете овде да управљате VPN везом.';

  @override
  String get action_retry => 'Покушај поново';

  @override
  String get session_endingTitle => 'Завршавање сесије';

  @override
  String get session_ending =>
      'Завршавање сесије: заустављање VPN-а и чишћење…';

  @override
  String get session_stopFailed =>
      'Заустављање VPN-а није потврђено. Покушајте поново пре поновне пријаве.';

  @override
  String get session_cleanupFailed =>
      'VPN је заустављен, али уклањање сесије није потврђено. Поновите чишћење.';

  @override
  String get session_retryStop => 'Понови заустављање';

  @override
  String get session_retryCleanup => 'Понови чишћење';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN се безбедно припрема…';

  @override
  String get nav_connection => 'Веза';

  @override
  String get nav_locations => 'Локације';

  @override
  String get nav_account => 'Налог';

  @override
  String get nav_devices => 'Уређаји';

  @override
  String get nav_settings => 'Подешавања';

  @override
  String get action_refresh => 'Освежи';

  @override
  String get auth_tab_login => 'Пријави се';

  @override
  String get auth_tab_register => 'Региструј се';

  @override
  String get auth_stepAccount => 'Налог';

  @override
  String get auth_stepIdentity => 'Идентитет';

  @override
  String get auth_stepAddress => 'Адреса и сагласности';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Корак $current од $total';
  }

  @override
  String get auth_tagline => 'Ваш VPN, једноставно.';

  @override
  String get auth_keysLocal =>
      'Ваши приватни VPN кључеви остају на овом уређају.';

  @override
  String get form_email => 'Имејл адреса';

  @override
  String get form_password => 'Лозинка';

  @override
  String get form_showPassword => 'Прикажи лозинку';

  @override
  String get form_hidePassword => 'Сакриј лозинку';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 бајта. Неки знакови заузимају више од једног бајта.';

  @override
  String get form_firstName => 'Име';

  @override
  String get form_lastName => 'Презиме';

  @override
  String get form_phone => 'Телефон (+33612345678)';

  @override
  String get form_address => 'Адреса';

  @override
  String get form_address2 => 'Адреса, ред 2 (необавезно)';

  @override
  String get form_postalCode => 'Поштански број';

  @override
  String get form_city => 'Град';

  @override
  String get form_country => 'Код државе (нпр. FR)';

  @override
  String get action_login => 'Пријави се';

  @override
  String get action_createAccount => 'Креирај налог';

  @override
  String get action_createMyAccount => 'Креирај мој налог';

  @override
  String get action_next => 'Настави';

  @override
  String get action_previous => 'Назад';

  @override
  String get action_forgotPassword => 'Заборавили сте лозинку?';

  @override
  String get auth_noAccount => 'Још немате налог?';

  @override
  String get auth_requiredInformation => 'Креирајте налог у три корака.';

  @override
  String get auth_termsPrefix => 'Прихватам ';

  @override
  String get auth_termsLink => 'услове коришћења';

  @override
  String get auth_privacyPrefix => 'Прихватам ';

  @override
  String get auth_privacyLink => 'политику приватности';

  @override
  String get auth_consentRequired =>
      'Ваша сагласност је потребна за креирање налога.';

  @override
  String get validation_required => 'Ово поље је обавезно.';

  @override
  String get validation_email => 'Унесите важећу имејл адресу.';

  @override
  String get validation_password =>
      'Лозинка је прекратка: најмање 8 UTF-8 бајтова.';

  @override
  String get validation_passwordTooLong =>
      'Лозинка је предуга: највише 72 UTF-8 бајта.';

  @override
  String get validation_phone =>
      'Користите међународни формат, на пример +33612345678.';

  @override
  String get validation_country =>
      'Користите двословни код државе, на пример FR.';

  @override
  String get passwordReset_title => 'Ресетовање лозинке';

  @override
  String get passwordReset_description =>
      'Унесите имејл адресу налога да бисте затражили линк за ресетовање лозинке.';

  @override
  String get passwordReset_send => 'Пошаљи линк';

  @override
  String get connection_title => 'Ваша веза';

  @override
  String get connection_subtitle => 'Изаберите локацију, па укључите VPN.';

  @override
  String get connection_prepare => 'Спремни за повезивање?';

  @override
  String get connection_advancedOptions => 'Напредне опције';

  @override
  String get connection_location => 'Локација';

  @override
  String get connection_chooseLocation => 'Изаберите локацију';

  @override
  String get connection_protocol => 'Протокол';

  @override
  String get connection_connect => 'Повежи се';

  @override
  String get connection_connecting => 'Повезивање…';

  @override
  String get connection_disconnect => 'Прекини везу';

  @override
  String get connection_disconnecting => 'Прекидање везе';

  @override
  String get connection_locationChange => 'Промена локације…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol није доступан';
  }

  @override
  String get connection_activeLocation => 'Активна локација';

  @override
  String get connection_duration => 'Трајање';

  @override
  String get connection_received => 'Примљено';

  @override
  String get connection_sent => 'Послато';

  @override
  String get connection_lastHandshake => 'Последња безбедна размена';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Пре $duration';
  }

  @override
  String get verification_title => 'Потврдите имејл адресу';

  @override
  String get verification_message =>
      'Потврдите имејл адресу да бисте користили VPN на овом телефону.';

  @override
  String get verification_resend => 'Пошаљи имејл поново';

  @override
  String get migration_title => 'Промена локације';

  @override
  String get migration_draining => 'Припрема промене локације…';

  @override
  String get migration_activating => 'Активирање новог сервера…';

  @override
  String get migration_ready => 'Локација је ажурирана.';

  @override
  String get migration_blocked =>
      'Промена локације захтева интервенцију на серверу. Покушајте поново касније или контактирајте подршку.';

  @override
  String get migration_progress => 'Напредак промене локације';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Размак између провера: $seconds с.';
  }

  @override
  String get migration_resume => 'Настави промену локације';

  @override
  String get status_authorizing => 'Потребна је дозвола';

  @override
  String get status_authorizingDetail =>
      'Прихватите Android захтев да бисте омогућили VPN.';

  @override
  String get status_preparing => 'Припрема се';

  @override
  String get status_preparingDetail => 'Припрема се ваша безбедна веза.';

  @override
  String get status_reconnecting => 'Поновно повезивање…';

  @override
  String get status_reconnectingDetail =>
      'Веза је прекинута. VPN покушава поново да се повеже.';

  @override
  String get status_connecting => 'Повезивање';

  @override
  String get status_connectingDetail => 'Повезивање са VPN сервером…';

  @override
  String get status_connected => 'Повезано';

  @override
  String get status_connectedDetail => 'Ваша VPN веза је активна.';

  @override
  String get status_disconnecting => 'Прекидање везе';

  @override
  String get status_disconnectingDetail => 'Ваша VPN веза се зауставља.';

  @override
  String get status_error => 'Веза није доступна';

  @override
  String get status_errorDetail => 'VPN веза није потврђена. Покушајте поново.';

  @override
  String get status_idle => 'Није повезано';

  @override
  String get status_idleDetail => 'Повежите VPN да бисте заштитили везу.';

  @override
  String get trust_note =>
      'Затварање апликације не зауставља VPN. Да га зауставите, користите опцију Прекини везу.';

  @override
  String get locations_none => 'Тренутно нема доступних локација.';

  @override
  String get locations_available => 'Изаберите следећу локацију.';

  @override
  String get locations_selected => 'Изабрана локација';

  @override
  String get locations_select => 'Изабери ову локацију';

  @override
  String get locations_lockedTunnel =>
      'Прекините VPN везу да бисте променили локацију.';

  @override
  String get locations_lockedMigration =>
      'Сачекајте да се промена локације заврши.';

  @override
  String get devices_title => 'Ваши уређаји';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit уређаја';
  }

  @override
  String get devices_refresh => 'Освежи уређаје';

  @override
  String get devices_empty => 'Још нема регистрованих VPN уређаја.';

  @override
  String get devices_firstConnection =>
      'Ваш телефон ће бити додат при првом повезивању.';

  @override
  String get devices_thisDevice => 'Овај уређај';

  @override
  String devices_added(Object date) {
    return 'Додат $date';
  }

  @override
  String get devices_unnamed => 'Уређај без имена';

  @override
  String get action_remove => 'Уклони';

  @override
  String get settings_title => 'Подешавања';

  @override
  String get settings_subtitle => 'Ваша подешавања и налог на једном месту.';

  @override
  String get settings_appearance => 'Изглед';

  @override
  String get settings_language => 'Језик';

  @override
  String get settings_languageDescription =>
      'Изабрани језик се примењује и на обавештења VPN-а.';

  @override
  String get settings_account => 'Налог';

  @override
  String get settings_signOut => 'Одјави се';

  @override
  String get settings_privacy => 'Политика приватности';

  @override
  String get settings_terms => 'Услови коришћења';

  @override
  String get settings_security => 'Безбедност и транспарентност';

  @override
  String get settings_licenses => 'Лиценце компонената';

  @override
  String get settings_licensesDetail => 'Софтвер који се користи у апликацији';

  @override
  String settings_licensesLegalese(String url) {
    return 'Изворни код апликације и њених MPL-2.0 компонената: $url';
  }

  @override
  String get settings_background =>
      'VPN остаје укључен када напустите апликацију. Да га зауставите, користите опцију Прекини везу на картици Веза.';

  @override
  String get theme_system => 'Системска';

  @override
  String get theme_light => 'Светла';

  @override
  String get theme_dark => 'Тамна';

  @override
  String get language_system => 'Језик телефона';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Уклонити овај уређај?';

  @override
  String get dialog_removeCurrent =>
      'Овај телефон ће прекинути везу са VPN-ом и изгубити приступ. Подаци о његовој VPN вези биће уклоњени када сервер потврди.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN приступ за „$name“ биће укинут. Ова радња се не може поништити.';
  }

  @override
  String get dialog_signOut => 'Одјавити се?';

  @override
  String get dialog_signOutMessage =>
      'VPN ће се зауставити и мораћете поново да се пријавите. Ваши шифровани VPN кључеви остаће на овом телефону за следеће повезивање.';

  @override
  String get action_cancel => 'Откажи';

  @override
  String get action_close => 'Затвори';

  @override
  String get action_copy => 'Копирај';

  @override
  String get action_signOut => 'Одјави се';

  @override
  String get notice_close => 'Затвори поруку';

  @override
  String get notice_sessionExpired_title => 'Сесија је истекла';

  @override
  String get notice_sessionExpired_message =>
      'Ваша сесија је истекла. Пријавите се поново.';

  @override
  String get notice_connectionFailed_title => 'Веза није успостављена';

  @override
  String get notice_invalidCredentials_message =>
      'Имејл адреса или лозинка нису тачне.';

  @override
  String get notice_emailVerification_title =>
      'Потребна је потврда имејл адресе';

  @override
  String get notice_emailVerification_message =>
      'Потврдите имејл адресу пре додавања VPN уређаја.';

  @override
  String get notice_rateLimited_title => 'Превише покушаја';

  @override
  String get notice_deviceLimit_title => 'Достигнуто је ограничење уређаја';

  @override
  String get notice_deviceLimit_message =>
      'Уклоните постојећи уређај пре додавања новог.';

  @override
  String get notice_identityRenewal_title => 'VPN идентитет треба обновити';

  @override
  String get notice_identityRenewal_message =>
      'Овај идентитет је уклоњен. Креирајте нови локални идентитет.';

  @override
  String get notice_migrationPending_title => 'Промена локације је у току';

  @override
  String get notice_migrationPending_message =>
      'Промена локације је већ у току.';

  @override
  String get notice_migrationBlocked_title => 'Промена локације је блокирана';

  @override
  String get notice_migrationBlocked_message =>
      'Промена локације захтева интервенцију на серверу. Покушајте поново касније или контактирајте подршку.';

  @override
  String get notice_targetUnavailable_title =>
      'Сервер је привремено недоступан';

  @override
  String get notice_targetUnavailable_message =>
      'Овај сервер је привремено недоступан.';

  @override
  String get notice_networkUnavailable_title => 'Интернет веза није доступна';

  @override
  String get notice_networkUnavailable_message =>
      'Проверите везу и покушајте поново.';

  @override
  String get notice_permissionDenied_title => 'VPN дозвола је одбијена';

  @override
  String get notice_permissionDenied_message =>
      'Поново покрените везу и прихватите Android захтев за дозволу.';

  @override
  String get notice_wireguardTimeout_title => 'Сервер не одговара';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard веза се предуго успостављала. Покушајте поново или изаберите другу локацију.';

  @override
  String get notice_tlsFailed_title => 'Безбедна веза је одбијена';

  @override
  String get notice_tlsFailed_message =>
      'Сервер није прихватио OpenVPN везу. Покушајте поново. Ако проблем и даље постоји, покрените дијагностику.';

  @override
  String get notice_tunRejected_title => 'Android је одбио VPN интерфејс';

  @override
  String get notice_tunRejected_message =>
      'Android је одбио мрежну конфигурацију коју је затражио OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN није могао да се покрене';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN мотор није могао да заврши покретање. Покушајте поново. Ако проблем и даље постоји, контактирајте подршку.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Дијагностички код: $code';
  }

  @override
  String get notice_generic_title => 'VPN веза није успостављена';

  @override
  String get notice_generic_message =>
      'Дошло је до грешке. Покушајте поново касније.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Налог је креиран',
      'password_reset_sent': 'Захтев за ресетовање лозинке је примљен',
      'verification_email_sent': 'Имејл за потврду је послат',
      'location_migration_pending': 'Промена локације је у току',
      'vpn_sign_in_required': 'Потребна је пријава',
      'protocol_unavailable_at_location': 'Протокол није доступан',
      'vpn_permission_denied': 'VPN дозвола је одбијена',
      'revoked_identity_device_limit': 'Достигнуто је ограничење уређаја',
      'tunnel_start_unexpected': 'VPN није могао да се покрене',
      'flutter_disconnect_timeout': 'Прекид везе није потврђен',
      'flutter_disconnect_unexpected': 'Није могуће прекинути везу',
      'device_revoked': 'Уређај је уклоњен',
      'revoke_unexpected': 'Није могуће уклонити уређај',
      'identity_renewal_unexpected': 'Није могуће обновити идентитет',
      'openvpn_renewal_unexpected': 'Није могуће обновити OpenVPN',
      'location_migration_blocked': 'Промена локације је блокирана',
      'location_migration_slow': 'Промена локације је и даље у току',
      'location_migration_conflict': 'Промена локације захтева освежавање',
      'location_migration_verification_failed':
          'Промена локације није потврђена',
      'location_migration_device_changed':
          'Уређај је промењен током промене локације',
      'tunnel_stop_failed': 'Промена локације није доступна',
      'device_clock_ahead': 'Сат уређаја је испред',
      'other': 'Операција није успела',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Налог је креиран, али имејл за потврду није могао да се пошаље. Користите опцију за поновно слање у апликацији.',
      'password_reset_sent':
          'Ваш захтев је примљен. Ако налог одговара овој адреси, можда ћете добити имејл. Проверите и фасциклу за нежељену пошту.',
      'verification_email_sent': 'Управо је послат нови имејл за потврду.',
      'location_migration_pending':
          'Премештање на нову локацију ($target) се још припрема. Можете га наставити без поновног креирања уређаја.',
      'vpn_sign_in_required': 'Пријавите се на свој налог пре покретања VPN-а.',
      'protocol_unavailable_at_location':
          'Изабрани протокол није доступан на овој локацији. Освежите локације или изаберите други протокол.',
      'vpn_permission_denied':
          'Android је одбио VPN дозволу. Поново покрените везу и прихватите системски захтев.',
      'revoked_identity_device_limit':
          'VPN приступ овом уређају је уклоњен и достигнуто је ограничење уређаја. Уклоните уређај у одељку Налог → Управљај мојим уређајима.',
      'tunnel_start_unexpected':
          'Неочекивана грешка је прекинула припрему тунела. Проверите дијагностички код и покушајте поново.',
      'flutter_disconnect_timeout':
          'Android није благовремено потврдио да је VPN заустављен. Покушајте поново да га зауставите.',
      'flutter_disconnect_unexpected':
          'Неочекивана грешка је спречила потврду да је тунел заустављен.',
      'device_revoked':
          'VPN приступ уређаја је укинут, а његови локални поверљиви подаци су уклоњени.',
      'revoke_unexpected':
          'Уређај није могуће уклонити. Освежите листу и покушајте поново.',
      'identity_renewal_unexpected':
          'Нови VPN идентитет није могуће креирати. Освежите уређаје и покушајте поново.',
      'openvpn_renewal_unexpected':
          'OpenVPN профил није могуће обновити. Покушајте поново или проверите дијагностички код.',
      'location_migration_blocked':
          'Сервер тренутно не може да заврши ову промену. Уређај и његов локални идентитет су задржани.',
      'location_migration_slow':
          'Сервер још припрема премештање на нову локацију ($target). За неколико тренутака користите опцију Настави.',
      'location_migration_conflict':
          'Стање уређаја је промењено на серверу. Освежите уређаје, па наставите промену.',
      'location_migration_verification_failed':
          'Сервер није потврдио нову локацију. Претходни локални идентитет је задржан.',
      'location_migration_device_changed':
          'Уређај који је вратио сервер више не одговара уређају који се мења. Освежите уређаје пре новог покушаја.',
      'tunnel_stop_failed':
          'Претходни тунел мора да буде потпуно заустављен пре нове везе.',
      'device_clock_ahead':
          'Чини се да је сат овог уређаја испред стварног времена. Укључите аутоматски датум и време да бисте остали пријављени.',
      'other':
          'Операција није могла да се заврши. Покушајте поново или пошаљите дијагностички код подршци.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Сесија је истекла',
      'invalid_credentials': 'Пријава није успела',
      'email_verification_required': 'Потребна је потврда имејл адресе',
      'verification_email_cooldown': 'Имејл је већ послат',
      'rate_limited': 'Превише покушаја',
      'invalid_registration': 'Податке треба исправити',
      'email_exists': 'Налог већ постоји',
      'invalid_profile': 'Неважећи профил',
      'invalid_device': 'Неважећи уређај',
      'invalid_location': 'Локација није доступна',
      'device_limit': 'Достигнуто је ограничење уређаја',
      'device_exists': 'VPN идентитет је већ у употреби',
      'device_identity_revoked': 'VPN идентитет треба обновити',
      'device_location_locked': 'Промену локације треба освежити',
      'location_migration_pending': 'Промена локације је у току',
      'location_migration_blocked': 'Промена локације је блокирана',
      'target_ca_mismatch': 'OpenVPN сервер није компатибилан',
      'location_migration_conflict': 'Промену локације треба освежити',
      'server_full': 'Сервер је попуњен',
      'capacity_unavailable': 'Локација је привремено недоступна',
      'target_unavailable': 'Сервер је привремено недоступан',
      'not_found': 'Ставка није пронађена',
      'invalid_openvpn_csr': 'Неважећи OpenVPN идентитет',
      'openvpn_profile_exists': 'OpenVPN профил већ постоји',
      'openvpn_profile_revoked': 'OpenVPN профил је опозван',
      'openvpn_operation_pending': 'OpenVPN операција је у току',
      'openvpn_operation_terminal': 'OpenVPN операција је прекинута',
      'openvpn_address_unavailable': 'OpenVPN адреса није доступна',
      'openvpn_profile_conflict': 'Сукоб у OpenVPN профилу',
      'openvpn_signer_unavailable': 'OpenVPN није доступан',
      'email_delivery_unavailable': 'Слање имејла није доступно',
      'invalid_token': 'Неважећи линк',
      'network_unavailable': 'Интернет веза није доступна',
      'invalid_json': 'Неважећи захтев',
      'invalid_api_response': 'Неважећи одговор сервера',
      'ipv6_unavailable': 'IPv6 није доступан',
      'invalid_ip_families': 'Мрежна конфигурација је одбијена',
      'other': 'Услуга није доступна',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Ваша сесија је истекла. Пријавите се поново.',
      'invalid_credentials': 'Имејл адреса или лозинка нису тачне.',
      'email_verification_required':
          'Потврдите имејл адресу пре додавања VPN уређаја.',
      'invalid_registration': 'Проверите тражене податке и сагласности.',
      'email_exists': 'Налог већ користи ову имејл адресу.',
      'invalid_profile': 'Проверите податке о профилу.',
      'invalid_device': 'Назив или локални идентитет овог уређаја није важећи.',
      'invalid_location': 'Освежите листу локација и покушајте поново.',
      'device_limit': 'Уклоните постојећи уређај пре додавања новог.',
      'device_exists': 'Овај VPN идентитет је већ повезан са другим налогом.',
      'device_identity_revoked':
          'Овај идентитет је уклоњен. Треба креирати нови локални идентитет.',
      'device_location_locked':
          'Локација овог уређаја је управо промењена. Апликација ће наставити промену која је у току.',
      'location_migration_pending': 'Промена локације је већ у току.',
      'location_migration_blocked':
          'Промена локације захтева интервенцију на серверу. Покушајте поново касније или контактирајте подршку.',
      'target_ca_mismatch':
          'Овај сервер још није компатибилан са тренутним OpenVPN профилом.',
      'location_migration_conflict':
          'Освежите уређаје, па покушајте промену локације поново.',
      'server_full':
          'Ова локација је достигла ограничење веза. Изаберите другу локацију или покушајте поново касније.',
      'capacity_unavailable':
          'Не можемо да потврдимо да је ова локација тренутно доступна. Изаберите другу локацију или покушајте поново касније.',
      'target_unavailable': 'Овај сервер је привремено недоступан.',
      'not_found': 'Ова ставка више није доступна на вашем налогу.',
      'invalid_openvpn_csr':
          'Креирајте нови OpenVPN идентитет и покушајте поново.',
      'openvpn_profile_exists': 'OpenVPN профил за овај уређај већ постоји.',
      'openvpn_profile_revoked': 'Обновите OpenVPN профил да бисте наставили.',
      'openvpn_operation_pending':
          'Промена се још увек примењује. Покушајте поново касније.',
      'openvpn_operation_terminal':
          'Креирајте нови OpenVPN идентитет и покушајте поново.',
      'openvpn_address_unavailable':
          'Тренутно није доступна ниједна OpenVPN адреса.',
      'openvpn_profile_conflict':
          'Профил је промењен. Освежите уређаје и покушајте поново.',
      'openvpn_signer_unavailable': 'OpenVPN услуга је привремено недоступна.',
      'email_delivery_unavailable':
          'Имејл није могао да се пошаље. Покушајте поново касније.',
      'invalid_token': 'Овај линк је неважећи или је истекао. Затражите нови.',
      'network_unavailable': 'Проверите интернет везу и покушајте поново.',
      'invalid_json': 'Проверите унете податке и покушајте поново.',
      'invalid_api_response':
          'Сервер је вратио неочекиван одговор. Покушајте поново касније.',
      'ipv6_unavailable':
          'Сервер тренутно не може да активира IPv6. Покушајте поново касније.',
      'invalid_ip_families':
          'Конфигурација тунела је непотпуна или не одговара овлашћеним адресама. Покушајте поново из апликације.',
      'other': 'Дошло је до грешке на серверу. Покушајте поново касније.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Покушајте поново за неколико тренутака.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Покушајте поново за $seconds секунди.',
      few: 'Покушајте поново за $seconds секунде.',
      one: 'Покушајте поново за $seconds секунду.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Покушајте поново за $minutes минута.',
      few: 'Покушајте поново за $minutes минута.',
      one: 'Покушајте поново за $minutes минут.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Покушајте поново за $hours сати.',
      few: 'Покушајте поново за $hours сата.',
      one: 'Покушајте поново за $hours сат.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Системски наставак VPN-а није доступан',
      'system_vpn_resume_corrupt': 'Неважећи системски наставак VPN-а',
      'system_vpn_resume_session_invalid': 'Неважећа сесија за наставак VPN-а',
      'system_vpn_resume_identity_changed': 'Идентитет VPN-а је промењен',
      'system_vpn_resume_identity_invalid':
          'Неважећи идентитет за наставак VPN-а',
      'system_vpn_resume_storage_failed':
          'Складиште за наставак VPN-а није доступно',
      'system_vpn_resume_network_timeout': 'Нема мреже за наставак VPN-а',
      'system_vpn_resume_blocked': 'Наставак VPN-а је блокиран',
      'system_vpn_resume_failed': 'Наставак VPN-а није успео',
      'system_vpn_resume_error_invalid': 'Неважећа грешка при наставку VPN-а',
      'wireguard_identity_store_failed': 'WireGuard идентитет није сачуван',
      'wireguard_identity_unavailable': 'WireGuard идентитет није доступан',
      'vpn_host_destroyed': 'Android VPN компонента је заустављена',
      'vpn_host_unavailable': 'Android VPN компонента није доступна',
      'vpn_permission_required': 'Потребна је дозвола за VPN',
      'vpn_permission_denied': 'VPN дозвола је одбијена',
      'vpn_permission_request_failed': 'Није могуће затражити дозволу',
      'wireguard_foreground_service_unavailable':
          'WireGuard услуга није доступна',
      'wireguard_identity_invalid': 'Неважећи локални WireGuard кључ',
      'wireguard_identity_in_use': 'WireGuard идентитет је већ у употреби',
      'wireguard_configuration_invalid': 'Неважећа WireGuard конфигурација',
      'wireguard_operation_pending': 'WireGuard операција је и даље активна',
      'wireguard_start_failed': 'Покретање WireGuard-а је одбијено',
      'wireguard_stop_timeout': 'Заустављање WireGuard-а није потврђено',
      'wireguard_handshake_timeout': 'WireGuard није одговорио',
      'openvpn_connection_timeout': 'OpenVPN није одговорио',
      'openvpn_core_unavailable': 'OpenVPN мотор није доступан',
      'openvpn_operation_pending': 'OpenVPN сесија је и даље активна',
      'openvpn_stop_timeout': 'Заустављање OpenVPN-а није потврђено',
      'openvpn_profile_unavailable': 'Локални OpenVPN профил недостаје',
      'openvpn_native_failed': 'Нативни OpenVPN позив је прекинут',
      'openvpn_key_generation_failed':
          'Није могуће креирати OpenVPN P-256 кључ',
      'openvpn_csr_generation_failed': 'Није могуће креирати OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN идентитет није сачуван',
      'openvpn_identity_clear_failed': 'Непотпуно уклањање OpenVPN-а',
      'openvpn_identity_in_use': 'OpenVPN идентитет се и даље користи',
      'openvpn_tls_verification_required': 'OpenVPN TLS верификација недостаје',
      'openvpn_cipher_invalid': 'Неважећи OpenVPN алгоритам шифровања',
      'openvpn_profile_rejected': 'OpenVPN профил је одбијен',
      'openvpn_identity_inconsistent': 'Несагласан OpenVPN идентитет',
      'tls_handshake_failed': 'OpenVPN преговарање је одбијено',
      'tls_alert_unknown_ca': 'OpenVPN клијентски сертификат није препознат',
      'tls_alert_bad_certificate': 'OpenVPN клијентски сертификат је одбијен',
      'tls_alert_unsupported_certificate': 'Неподржан OpenVPN сертификат',
      'tls_client_certificate_required':
          'Потребан је OpenVPN клијентски сертификат',
      'tls_alert_misc': 'OpenVPN TLS упозорење',
      'tls_signature_algorithm_rejected': 'Неподржан OpenVPN потпис',
      'tls_handshake_rejected': 'OpenVPN TLS преговарање је одбијено',
      'tls_version_rejected': 'Некомпатибилна OpenVPN TLS верзија',
      'tls_certificate_expired': 'TLS сертификат је истекао',
      'tls_certificate_revoked': 'TLS сертификат је опозван',
      'transport_failed': 'OpenVPN сервер није доступан',
      'tun_configuration_rejected': 'Није могуће креирати OpenVPN интерфејс',
      'tun_setup_failed': 'Подешавање OpenVPN TUN-а није успело',
      'tun_interface_create_failed': 'Креирање OpenVPN интерфејса није успело',
      'tun_interface_disabled': 'OpenVPN интерфејс је онемогућен',
      'tun_halted': 'OpenVPN интерфејс је прекинут',
      'tun_already_established': 'OpenVPN интерфејс је већ отворен',
      'tun_addresses_missing': 'Недостаје OpenVPN адреса',
      'tun_routes_missing': 'Недостају OpenVPN руте',
      'tun_dns_missing': 'Недостаје OpenVPN DNS',
      'tun_permission_revoked': 'Дозвола за VPN је опозвана',
      'tun_establish_returned_null': 'Android је одбио VPN интерфејс',
      'openvpn_service_start_failed': 'OpenVPN услуга није доступна',
      'openvpn_operation_timeout': 'OpenVPN позив је истекао',
      'openvpn_start_failed': 'Покретање OpenVPN-а је одбијено',
      'openvpn_connection_failed': 'OpenVPN веза је прекинута',
      'openvpn_core_status_error': 'OpenVPN Core се завршио грешком',
      'openvpn_stopped_before_connected': 'OpenVPN се зауставио пре повезивања',
      'openvpn_auth_failed': 'OpenVPN аутентификација је одбијена',
      'openvpn_client_setup_failed': 'Подешавање OpenVPN клијента није успело',
      'openvpn_client_halted': 'OpenVPN клијент је прекинут',
      'openvpn_client_restart': 'Затражено је поновно покретање OpenVPN-а',
      'openvpn_inactive_timeout': 'OpenVPN је предуго неактиван',
      'openvpn_session_expired': 'OpenVPN сесија је истекла',
      'openvpn_credentials_required': 'Неподржана OpenVPN аутентификација',
      'openvpn_proxy_failed': 'OpenVPN посредни транспорт није успео',
      'openvpn_compression_failed': 'OpenVPN компресија је одбијена',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM шифровање није доступно',
      'openvpn_feature_unsupported': 'Неподржана OpenVPN функција',
      'network_unavailable': 'Интернет веза није доступна',
      'network_lost': 'Мрежа није доступна',
      'certificate_validation_failed': 'Сертификат сервера је одбијен',
      'openvpn_certificate_expired': 'OpenVPN сертификат је истекао',
      'tunnel_active_for_another_account':
          'Тунел другог налога је и даље активан',
      'tunnel_already_active': 'Нативни тунел је већ активан',
      'tunnel_stop_timeout': '$protocol: заустављање није потврђено',
      'tunnel_disconnected': '$protocol је прекинут',
      'native_bridge_unavailable': 'Android мост није доступан',
      'native_operation_failed': 'Android операција је прекинута',
      'invalid_arguments': 'Непотпуни VPN параметри',
      'invalid_account_id': 'Неважећи VPN налог',
      'invalid_device_id': 'Неважећи идентификатор уређаја',
      'storage_key_not_allowed': 'Кључ складишта је одбијен',
      'secure_storage_read_failed': 'Безбедно читање није успело',
      'secure_storage_write_failed': 'Безбедно писање није успело',
      'key_generation_failed': 'Није могуће генерисати WireGuard кључ',
      'csr_generation_failed': 'Није могуће генерисати OpenVPN CSR',
      'openvpn_recovery_exhausted': 'Опоравак OpenVPN-а је већ искоришћен',
      'openvpn_recovery_failed': 'Опоравак OpenVPN-а није успео',
      'openvpn_renewal_required': 'Потребно је обнављање OpenVPN сертификата',
      'other': 'Неразврстана нативна VPN грешка',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android не може да пронађе сесију VPN-а која се може наставити. Покрените нову везу у апликацији.',
      'system_vpn_resume_corrupt':
          'Сачувани подаци за наставак VPN-а нису важећи и неће се користити. Покрените нову везу.',
      'system_vpn_resume_session_invalid':
          'Сачувана сесија више не може да настави VPN. Пријавите се поново у апликацији.',
      'system_vpn_resume_identity_changed':
          'Локални VPN идентитет је промењен. Наставак је заустављен; покрените нову везу.',
      'system_vpn_resume_identity_invalid':
          'Идентитет за наставак није важећи. Покрените нову везу.',
      'system_vpn_resume_storage_failed':
          'Android није могао да прочита или ажурира шифроване податке за наставак. Покрените нову везу.',
      'system_vpn_resume_network_timeout':
          'Android није на време пронашао мрежу за наставак VPN-а. Покушајте поново када мрежа буде доступна.',
      'system_vpn_resume_blocked':
          'Наставак VPN-а је блокиран. Проверите Android подешавања, па покрените нову везу.',
      'system_vpn_resume_failed':
          'Наставак Android VPN-а није успео. Покрените нову везу у апликацији.',
      'system_vpn_resume_error_invalid':
          'Android је вратио грешку при наставку која се не може користити. Покрените нову везу.',
      'wireguard_identity_store_failed':
          'Android није могао да сачува шифровани WireGuard идентитет овог налога.',
      'wireguard_identity_unavailable':
          'За ову везу није доступан употребљив WireGuard идентитет.',
      'vpn_host_destroyed':
          'Android компонента у којој ради VPN је заустављена. Покрените нову везу.',
      'vpn_host_unavailable':
          'Android не може да креира компоненту у којој ради VPN. Проверите подешавања VPN-а и покушајте поново.',
      'openvpn_renewal_required':
          'Сертификат захтева радњу у апликацији пре повезивања.',
      'openvpn_recovery_failed':
          'Аутоматски опоравак није успео. Покрените нову везу у апликацији.',
      'openvpn_recovery_exhausted':
          'Аутоматски опоравак је већ искоришћен. Покрените нову везу у апликацији.',
      'vpn_permission_required':
          'Android захтева нову VPN дозволу пре покретања тунела.',
      'vpn_permission_denied':
          'Дозволите FuzeVPN у Android захтеву да бисте наставили.',
      'vpn_permission_request_failed':
          'Android није могао да отвори екран за VPN дозволу.',
      'wireguard_foreground_service_unavailable':
          'Android није могао да задржи WireGuard услугу у првом плану.',
      'wireguard_identity_invalid':
          'Шифровани WireGuard кључ овог налога није читљив или је неважећи.',
      'wireguard_identity_in_use':
          'Друга операција и даље користи WireGuard кључ овог налога.',
      'wireguard_configuration_invalid':
          'Примљена WireGuard конфигурација (адреса, DNS, кључ сервера или руте) није исправна.',
      'wireguard_operation_pending':
          'Претходна WireGuard операција још није ослободила своју нативну услугу.',
      'wireguard_start_failed':
          'WireGuard мотор је одбио активирање конфигурације.',
      'wireguard_stop_timeout':
          'WireGuard услуга није потврдила ослобађање VPN интерфејса у предвиђеном року.',
      'wireguard_handshake_timeout':
          'Тунел на време није потврдио руковање са сервером.',
      'openvpn_connection_timeout':
          'OpenVPN на време није потврдио везу са сервером.',
      'openvpn_core_unavailable':
          'Ова верзија апликације не садржи употребљив OpenVPN мотор.',
      'openvpn_operation_pending':
          'Нативни мотор и даље држи претходну OpenVPN сесију и одбија да креира другу.',
      'openvpn_stop_timeout':
          'OpenVPN Core није потврдио да је његова нативна сесија заустављена и уништена у предвиђеном року.',
      'openvpn_profile_unavailable':
          'За ову везу не може да се прочита проверен OpenVPN профил.',
      'openvpn_native_failed':
          'Грешка у апликацији је прекинула OpenVPN. Покушајте поново да се повежете. Ако проблем и даље постоји, покрените дијагностику.',
      'openvpn_key_generation_failed':
          'Android Keystore није могао да креира или прочита приватни P-256 кључ који није могуће извозити.',
      'openvpn_csr_generation_failed':
          'Кључ Android Keystore-а није могао да потпише захтев за OpenVPN сертификат.',
      'openvpn_identity_store_failed':
          'OpenVPN сертификат или профил није могао да се сачува у шифрованом складишту.',
      'openvpn_identity_clear_failed':
          'Android није могао да уклони цео локални OpenVPN идентитет овог налога.',
      'openvpn_identity_in_use':
          'Нативна OpenVPN сесија и даље користи кључ или сертификат овог уређаја.',
      'openvpn_tls_verification_required':
          'Профил изричито не захтева верификацију сертификата сервера.',
      'openvpn_cipher_invalid':
          'Сервер је послао алгоритам шифровања који није на дозвољеној листи.',
      'openvpn_profile_rejected':
          'Профил примљен са сервера није компатибилан. Поново креирајте овај уређај, па покушајте још једном.',
      'openvpn_identity_inconsistent':
          'Сертификат се не подудара са безбедним идентитетом овог телефона. Ниједан локални профил није замењен.',
      'tls_handshake_failed':
          'Сервер је одбио TLS преговарање. Ако проблем и даље постоји, поново креирајте профил.',
      'tls_alert_unknown_ca':
          'Сервер не препознаје издавача сертификата овог уређаја. Потребно је проверити OpenVPN сервер.',
      'tls_alert_bad_certificate':
          'Сервер је одбио сертификат овог уређаја. Поново креирајте уређај пре новог покушаја.',
      'tls_alert_unsupported_certificate':
          'Сервер не подржава безбедни тип сертификата који користи Android.',
      'tls_client_certificate_required':
          'Сервер захтева клијентски сертификат, али OpenVPN Core није могао да га достави.',
      'tls_alert_misc':
          'Сервер је вратио TLS упозорење које не припада категоријама сертификата и верзије.',
      'tls_signature_algorithm_rejected':
          'Сервер је одбио ECDSA P-256 алгоритам Android Keystore кључа.',
      'tls_handshake_rejected':
          'Сервер је прекинуо TLS преговарање пре повезивања.',
      'tls_version_rejected':
          'Клијент и сервер нису пронашли заједничку TLS верзију.',
      'tls_certificate_expired':
          'Сертификат достављен током повезивања је истекао.',
      'tls_certificate_revoked':
          'Сертификат достављен током повезивања је опозван.',
      'transport_failed':
          'OpenVPN сервер не одговара на тренутној мрежи. Покушајте поново за неколико тренутака.',
      'tun_configuration_rejected':
          'Android је одбио мрежну конфигурацију коју је затражио OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core је одбио мрежни план пре креирања Android интерфејса.',
      'tun_interface_create_failed':
          'OpenVPN Core није могао да добије TUN интерфејс од Android VpnService-а.',
      'tun_interface_disabled':
          'Android или OpenVPN Core су онемогућили TUN интерфејс током повезивања.',
      'tun_halted':
          'OpenVPN Core је добио захтев за заустављање TUN интерфејса.',
      'tun_already_established':
          'OpenVPN је затражио други интерфејс у истој вези. Тунел је заустављен ради безбедности.',
      'tun_addresses_missing': 'Сервер није дао употребљиву адресу тунела.',
      'tun_routes_missing': 'Сервер није дао употребљиве руте за тунел.',
      'tun_dns_missing': 'Сервер није дао употребљив DNS сервер.',
      'tun_permission_revoked':
          'Android је опозвао VPN дозволу током повезивања.',
      'tun_establish_returned_null':
          'Android није креирао интерфејс, обично зато што је други VPN и даље активан.',
      'openvpn_service_start_failed':
          'Android није могао да покрене OpenVPN услугу у првом плану.',
      'openvpn_operation_timeout':
          'JNI позив ка OpenVPN Core-у је премашио максимално трајање.',
      'openvpn_start_failed':
          'Android услуга је спремна, али OpenVPN Core није прихватио покретање профила.',
      'openvpn_connection_failed':
          'OpenVPN Core се зауставио пре слања CONNECTED догађаја.',
      'openvpn_core_status_error':
          'Нативна OpenVPN петља се завршила грешком без прецизнијег завршног догађаја.',
      'openvpn_stopped_before_connected':
          'Нативна OpenVPN петља се зауставила пре CONNECTED догађаја, без експлицитне Core грешке.',
      'openvpn_auth_failed': 'OpenVPN сервер је одбио аутентификацију профила.',
      'openvpn_client_setup_failed':
          'OpenVPN Core није могао да иницијализује клијент пре мрежне везе.',
      'openvpn_client_halted':
          'OpenVPN Core је примио коначно заустављање клијента.',
      'openvpn_client_restart':
          'OpenVPN Core је затражио поновно покретање своје транспортне сесије.',
      'openvpn_inactive_timeout':
          'OpenVPN Core је затворио сесију након истека времена неактивности.',
      'openvpn_session_expired':
          'Сервер је известио да је OpenVPN сесија истекла.',
      'openvpn_credentials_required':
          'Сервер или прокси тражи интерактивне податке за пријаву који нису део овог профила сертификата.',
      'openvpn_proxy_failed':
          'OpenVPN Core је пријавио грешку подешеног прокси сервера или релеја.',
      'openvpn_compression_failed':
          'OpenVPN Core је одбио режим компресије који је најавио профил или сервер.',
      'openvpn_ntlm_crypto_unavailable':
          'Профил захтева NTLM шифровање које није доступно у овој верзији.',
      'openvpn_feature_unsupported':
          'Профил или сервер захтевају функцију која недостаје у овом Android клијенту.',
      'network_unavailable': 'Није доступна ниједна употребљива физичка мрежа.',
      'network_lost': 'Тунел је заустављен након губитка мреже.',
      'certificate_validation_failed':
          'Идентитет OpenVPN сервера није могао да се верификује.',
      'openvpn_certificate_expired':
          'Обновите OpenVPN профил пре поновног повезивања.',
      'tunnel_active_for_another_account':
          'Тунел који припада другом налогу мора да се заустави пре ове везе.',
      'tunnel_already_active':
          'Android пријављује да претходна VPN сесија и даље користи интерфејс.',
      'tunnel_stop_timeout':
          '$protocol мотор није потврдио ослобађање VPN интерфејса у предвиђеном року.',
      'tunnel_disconnected':
          'Нативни мотор је пријавио да се тунел неочекивано завршио након покретања.',
      'native_bridge_unavailable':
          'Апликација не може да приступи Android VPN услузи. Затворите и поново отворите апликацију, па покушајте поново.',
      'native_operation_failed':
          'Грешка у апликацији је прекинула VPN операцију. Покушајте поново. Ако проблем и даље постоји, покрените дијагностику.',
      'invalid_arguments':
          'Подаци потребни за ову VPN операцију нису потпуни. Покушајте поново. Ако проблем и даље постоји, покрените дијагностику.',
      'invalid_account_id':
          'Нативна операција није повезана са исправним идентификатором налога.',
      'invalid_device_id':
          'Идентификатор уређаја послат нативном мотору недостаје или није исправан.',
      'storage_key_not_allowed':
          'Android мост је блокирао кључ који није на дозвољеној листи складишта.',
      'secure_storage_read_failed':
          'Android Keystore није могао да дешифрује локалне податке овог налога.',
      'secure_storage_write_failed':
          'Android Keystore није могао да шифрује или сачува локалне податке.',
      'key_generation_failed':
          'Android није могао да креира или прочита WireGuard кључ у безбедном складишту.',
      'csr_generation_failed':
          'Android Keystore није могао да креира или потпише OpenVPN P-256 CSR.',
      'other':
          'Недокументована нативна грана није успела. Пошаљите дијагностички код приказан испод подршци.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Захтев за дозволу је већ отворен';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android захтев за VPN дозволу је већ приказан. Завршите га пре новог покушаја.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Захтев за VPN дозволу је прекинут';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Екран за VPN дозволу је затворен пре него што је апликација добила одговор.';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN веза није потврђена';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN везу није могуће потврдити. Заустављена је ради безбедности. Покушајте поново.';

  @override
  String get openvpnCleanup_title => 'OpenVPN профил је опозван';

  @override
  String get openvpnCleanup_working =>
      'Заустављање и уклањање опозваног OpenVPN профила…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Заустављање OpenVPN-а није потврђено. Покушајте поново пре креирања новог профила.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Опозвани OpenVPN профил није могуће у потпуности уклонити. Поновите чишћење.';

  @override
  String get openvpnCleanup_complete =>
      'Опозвани OpenVPN профил је уклоњен. Додирните „Повежи се“ да бисте креирали нови.';

  @override
  String get network_title => 'Мрежна конфигурација';

  @override
  String get network_ipv4Fallback =>
      'IPv6 је привремено недоступан. Припрема се наставља са IPv4.';

  @override
  String get network_rejectedTitle => 'Мрежна конфигурација је одбијена';

  @override
  String get network_rejectedMessage =>
      'Конфигурација тунела је непотпуна или не одговара овлашћеним адресама. Покушајте поново из апликације.';

  @override
  String get network_unreadableTitle => 'Локална конфигурација није читљива';

  @override
  String get network_unreadableMessage =>
      'Сачувана OpenVPN мрежна конфигурација не може да се користи. Поново се повежите из апликације да бисте је ажурирали.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Заштита мреже';

  @override
  String get protection_subtitle =>
      'Блокирајте директан приступ интернету ако се VPN прекине.';

  @override
  String get protection_active => 'Системска заштита је активна';

  @override
  String get protection_alwaysOnOnly =>
      'Увек укључен VPN је омогућен. Укључите „Блокирај везе без VPN-а“.';

  @override
  String get protection_inactive => 'Системска заштита није активна';

  @override
  String get protection_unknown => 'Проверите системску заштиту';

  @override
  String get protection_openSettings => 'Отвори Android подешавања';

  @override
  String get protection_dialogTitle => 'Подесите заштиту мреже';

  @override
  String get protection_dialogMessage =>
      'Android управља функцијама „Увек укључен VPN“ и „Блокирај везе без VPN-а“. Проверите да је FuzeVPN изабран и омогућите блокирање у системским подешавањима.';

  @override
  String get protection_dialogOpen => 'Отвори подешавања';

  @override
  String get session_systemProtectionNote =>
      'Ако Android и даље блокира саобраћај ван VPN-а, отворите системска подешавања да бисте проверили или променили ову заштиту.';

  @override
  String get diagnostics_title => 'Дијагностика';

  @override
  String get diagnostics_settingsTitle => 'Дијагностика апликације';

  @override
  String get diagnostics_automaticTitle => 'Слање важних грешака';

  @override
  String get diagnostics_automaticDescription =>
      'Делите кратак технички извештај када се догоди важна грешка.';

  @override
  String get diagnostics_privacy =>
      'Послати извештаји су повезани са пријављеним налогом и чувају се 30 дана. Не садрже историју прегледања, лозинке ни VPN кључеве.';

  @override
  String get diagnostics_manualOpen => 'Покрени дијагностику';

  @override
  String get diagnostics_localDescription =>
      'Креирајте извештај о стању апликације и VPN-а. Ваша веза остаје непромењена.';

  @override
  String get diagnostics_sendReport => 'Пошаљи извештај';

  @override
  String get diagnostics_sendHint =>
      'Ако ово поље не означите, извештај ће остати на овом уређају.';

  @override
  String get diagnostics_signedOut =>
      'Пријавите се на свој налог да бисте послали извештај.';

  @override
  String get diagnostics_localLifetime =>
      'Сачувајте овај извештај на телефону да бисте га задржали након затварања апликације.';

  @override
  String get diagnostics_run => 'Покрени дијагностику';

  @override
  String get diagnostics_rerun => 'Покрени дијагностику поново';

  @override
  String get diagnostics_running => 'Провера…';

  @override
  String get diagnostics_sending => 'Слање извештаја…';

  @override
  String get diagnostics_prepared => 'Извештај је спреман на овом уређају';

  @override
  String get diagnostics_queued => 'Извештај чека на слање';

  @override
  String get diagnostics_sent => 'Извештај је примљен';

  @override
  String get diagnostics_failed =>
      'Слање није успело. Ваш локални извештај је и даље доступан.';

  @override
  String get diagnostics_preparationFailed =>
      'Дијагностички извештај није могуће припремити. Покушајте поново.';

  @override
  String get diagnostics_authenticationRequired =>
      'Пријавите се поново да бисте послали извештај.';

  @override
  String get diagnostics_retry => 'Пошаљи поново';

  @override
  String get diagnostics_export => 'Сачувај извештај';

  @override
  String get diagnostics_exportFailed =>
      'Извоз није успео. Покушајте поново из локалног извештаја.';

  @override
  String get diagnostics_preferenceFailed =>
      'Ово подешавање није могуће сачувати. Покушајте поново.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Референца: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Примљено $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Чува се до $date';
  }

  @override
  String get diagnostics_duplicate => 'Овај извештај је већ био примљен.';

  @override
  String get diagnostics_preview => 'Преглед извештаја';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Приложено је $count техничких догађаја',
      few: 'Приложена су $count техничка догађаја',
      one: 'Приложен је $count технички догађај',
      zero: 'Нема приложених техничких догађаја',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Технички детаљи';

  @override
  String get diagnostics_empty =>
      'Још није припремљен ниједан дијагностички извештај.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Стање тунела',
      'handshake': 'Потврда везе',
      'certificate': 'VPN сертификат',
      'kill_switch': 'Android заштита',
      'connectivity': 'Доступна мрежа',
      'api_reachability': 'Приступ услузи',
      'secure_storage': 'Безбедно складиште',
      'other': 'Локална провера',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Проверено',
      'failed': 'Потребна пажња',
      'skipped': 'Није тестирано — нема активне провере',
      'unknown': 'Информација није доступна',
      'other': 'Информација није доступна',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Добродошли у FuzeVPN';

  @override
  String get connection_changeLocation => 'Промени локацију';

  @override
  String get connection_details => 'Детаљи везе';

  @override
  String get locations_searchLabel => 'Претражите град или државу';

  @override
  String get locations_clearSearch => 'Обриши претрагу';

  @override
  String get locations_filterAll => 'Све';

  @override
  String get locations_filterFavorites => 'Омиљене';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count локација',
      few: '$count локације',
      one: '$count локација',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Нису пронађене локације';

  @override
  String get locations_noResultsHint =>
      'Покушајте са другим градом или државом.';

  @override
  String get locations_noFavorites => 'Ваше омиљене локације, при руци';

  @override
  String get locations_noFavoritesHint =>
      'Додирните звездицу поред локације да бисте је сачували овде.';

  @override
  String get locations_showAll => 'Прикажи све локације';

  @override
  String locations_addFavorite(String name) {
    return 'Додај $name у омиљене';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Уклони $name из омиљених';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Омиљена локација није могла да се сачува. Покушајте поново.';

  @override
  String get locations_emptyTitle => 'Нема доступних локација';

  @override
  String get locations_emptyHint => 'Освежите листу да бисте покушали поново.';

  @override
  String get devices_manage => 'Управљај мојим уређајима';

  @override
  String get settings_personalization => 'По вашем укусу';

  @override
  String get settings_safety => 'Заштита';

  @override
  String get settings_help => 'Треба вам помоћ?';

  @override
  String get settings_about => 'О апликацији FuzeVPN';

  @override
  String get diagnostics_heading => 'Разумевање проблема са везом';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Доступан',
      'pending': 'Припрема се',
      'revoked': 'Уклоњен',
      'expired': 'Истекао',
      'other': 'Статус није доступан',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Подешавање није сачувано';

  @override
  String get notice_preferenceSave_message =>
      'Ваш избор је за сада примењен, али није могао да се сачува. Покушајте поново да бисте га задржали након затварања апликације.';

  @override
  String get connection_androidDisconnectHint =>
      'Ако Android и даље држи VPN активним, искључите „Увек укључен VPN“ у подешавањима која се отварају.';

  @override
  String get protection_learnMore => 'Сазнајте више о Android заштити';

  @override
  String get protection_guideWhy =>
      'Ова заштита спречава да апликације директно користе интернет ако се VPN веза прекине. Подешава се у систему Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Увек укључен VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android држи VPN услугу активном и може поново да је покрене након што се телефон рестартује.';

  @override
  String get protection_guideBlockTitle => 'Блокирај везе без VPN-а';

  @override
  String get protection_guideBlock =>
      'Ово подешавање спречава да саобраћај заобилази VPN, укључујући и време када је веза прекинута.';

  @override
  String get protection_guideWarning =>
      'Када је ово блокирање укључено, приступ интернету остаје искључен док се VPN не повеже.';

  @override
  String get protection_guideStepsTitle => 'Укључите заштиту';

  @override
  String get protection_guideStep1 =>
      'Отворите Android VPN подешавања помоћу дугмета испод.';

  @override
  String get protection_guideStep2 =>
      'Отворите опције помоћу иконе зупчаника поред FuzeVPN-а.';

  @override
  String get protection_guideStep3 =>
      'Укључите „Увек укључен VPN“, па „Блокирај везе без VPN-а“, ако су ове опције доступне.';

  @override
  String get protection_guideManufacturers =>
      'Називи се разликују у зависности од телефона. По потреби потражите VPN у подешавањима, обично у одељку Мрежа и интернет.';

  @override
  String get protection_guideDisableTitle => 'Искључите ову заштиту';

  @override
  String get protection_guideDisable =>
      'У истим подешавањима искључите блокирање веза без VPN-а да бисте дозволили приступ интернету без VPN-а. Искључите и опцију „Увек укључен VPN“ ако више не желите да га Android поново покреће.';

  @override
  String get protection_guideManual =>
      'Ова подешавања бирате у систему Android. FuzeVPN их не мења уместо вас.';

  @override
  String get locations_changeTitle => 'Променити локацију?';

  @override
  String locations_changeActive(String name) {
    return 'VPN веза ће се прекинути, а затим покушати да се повеже са локацијом $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN ће покушати да се повеже са локацијом $name.';
  }

  @override
  String get locations_confirmChange => 'Промени и повежи се';

  @override
  String get locations_changeBusy =>
      'Промена је у току. Сачекајте пре него што изаберете другу локацију.';

  @override
  String get locations_automaticSelection => 'Аутоматски избор';

  @override
  String get locations_cities => 'Градови';

  @override
  String get locations_servers => 'Сервери';

  @override
  String locations_viewCities(String name) {
    return 'Прикажи градове у држави $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Прикажи сервере у локацији $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count држава',
      few: '$count државе',
      one: '$count држава',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count градова',
      few: '$count града',
      one: '$count град',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сервера',
      few: '$count сервера',
      one: '$count сервер',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Све државе';

  @override
  String get locations_backToCountries => 'Назад на државе';

  @override
  String locations_backToCities(String name) {
    return 'Назад на градове у држави $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Изабери $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Изабери $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Нема доступног компатибилног сервера.';

  @override
  String get externalLink_failed =>
      'Није могуће отворити овај линк. Можете га копирати и отворити у прегледачу.';

  @override
  String get externalLink_copy => 'Копирај линк';

  @override
  String get externalLink_copied => 'Линк је копиран';

  @override
  String get externalLink_copyFailed =>
      'Није могуће копирати линк. Изаберите адресу испод.';

  @override
  String get settings_deleteAccount => 'Избриши мој налог';

  @override
  String get settings_deleteAccountDetail =>
      'Погледајте поступак за захтев за брисање налога';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Изаберите VPN претплату.';

  @override
  String get billing_subscribe => 'Претплати се';

  @override
  String get billing_choosePlan => 'Изаберите план да бисте наставили.';

  @override
  String get billing_monthly => 'Месечно';

  @override
  String get billing_yearly => 'Годишње';

  @override
  String get billing_continue => 'Настави преко Google Play-а';

  @override
  String get billing_restore => 'Врати куповине';

  @override
  String get billing_manage => 'Управљај претплатом';

  @override
  String get billing_deleteAccountWarning =>
      'Ако имате претплату у Google Play-у, брисање FuzeVPN налога не отказује њено обнављање. Управљајте обнављањем или га откажите одвојено у Google Play-у.';

  @override
  String get billing_deleteAccountContinue =>
      'Настави на захтев за брисање налога';

  @override
  String get billing_refresh => 'Освежи приступ';

  @override
  String get billing_loadingPlans => 'Учитавање планова…';

  @override
  String get billing_unavailable =>
      'Тренутно нема доступних планова. Покушајте поново касније.';

  @override
  String get billing_comingSoon => 'Претплате ће ускоро бити доступне.';

  @override
  String get billing_priceDisclosure =>
      'Цену обезбеђује Google Play. Коначан износ и важећи порези потврђују се пре него што потврдите куповину.';

  @override
  String get billing_renewalMonthly =>
      'Обнавља се аутоматски сваког месеца, осим ако се не откаже. Можете да је откажете у било ком тренутку у Google Play претплатама.';

  @override
  String get billing_renewalYearly =>
      'Обнавља се аутоматски сваке године, осим ако се не откаже. Можете да је откажете у било ком тренутку у Google Play претплатама.';

  @override
  String get billing_active => 'Ваш Premium приступ је активан';

  @override
  String billing_accessUntil(String date) {
    return 'Приступ до $date.';
  }

  @override
  String get billing_webManaged =>
      'Вашом претплатом се управља на веб-сајту FuzeVPN-а.';

  @override
  String get billing_playManaged => 'Вашом претплатом управља Google Play.';

  @override
  String get billing_playOnHold =>
      'Ваша Google Play претплата је обустављена или чека на плаћање. Отворите „Управљај претплатом“ да бисте то решили у Google Play-у.';

  @override
  String get billing_playReceiptUnlinked =>
      'Овај Google Play налог већ има Fuze Premium претплату која није активна за овај FuzeVPN налог. Отворите „Управљај претплатом“ да бисте је прегледали у Google Play-у.';

  @override
  String get billing_inactive => 'Нема активне претплате.';

  @override
  String get billing_checkingAccess => 'Провера вашег приступа…';

  @override
  String get billing_restoring => 'Враћање куповина…';

  @override
  String get billing_pending =>
      'Плаћање је на чекању. Ваш приступ ће се активирати након потврде.';

  @override
  String get billing_cancelled =>
      'Куповина је отказана. Нова претплата није активирана.';

  @override
  String get billing_verifying => 'Провера куповине…';

  @override
  String get billing_success =>
      'Претплата је активирана. Ваш Premium приступ је спреман.';

  @override
  String get billing_restored => 'Ваше куповине су враћене.';

  @override
  String get billing_restoreEmpty =>
      'Нема куповина које би могле да се врате за овај Google Play налог.';

  @override
  String get billing_catalogError =>
      'Није могуће учитати планове. Покушајте поново.';

  @override
  String get billing_purchaseError =>
      'Није могуће покренути куповину. Покушајте поново.';

  @override
  String get billing_verificationError =>
      'Провера куповине је привремено недоступна. Вратите куповине да бисте покушали поново.';

  @override
  String get billing_restoreError =>
      'Није могуће вратити куповине. Покушајте поново.';

  @override
  String get billing_managementError =>
      'Није могуће отворити управљање претплатама. Покушајте поново.';

  @override
  String get billing_storeUnavailable =>
      'Google Play није доступан на овом уређају.';

  @override
  String get welcome_title => 'Ваш VPN, једноставно.';

  @override
  String get welcome_description =>
      'Заштитите своју везу. Задржите контролу над својом приватношћу.';

  @override
  String get welcome_start => 'Започни';

  @override
  String get welcome_alreadyPurchased => 'Већ сте купили?';

  @override
  String get welcome_noAccountRequired => 'За почетак није потребан налог.';

  @override
  String get guest_accountTitle => 'Налог није повезан';

  @override
  String get guest_accountDescription =>
      'Вратите куповине помоћу истог Google Play налога да бисте претплату користили на другом уређају.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Већ сте претплаћени? Пријавите се';

  @override
  String get guest_claimTitle => 'Понесите FuzeVPN са собом';

  @override
  String get guest_claimDescription =>
      'Креирајте налог да бисте приступили својој претплати на другим уређајима. Овај корак није обавезан.';

  @override
  String get guest_skip => 'Можда касније';

  @override
  String get guest_activationTitle => 'Fuze Premium је активиран';

  @override
  String get guest_activationDescription =>
      'Ваша претплата је спремна. Користите VPN и креирајте налог кад год желите.';

  @override
  String get guest_useVpn => 'Користи мој VPN';

  @override
  String get guest_loginRequired =>
      'Ова куповина је већ повезана са FuzeVPN налогом. Пријавите се на тај налог да бисте приступили својој претплати.';

  @override
  String get guest_signOutWarning =>
      'Претплату можете повратити враћањем куповина помоћу истог Google Play налога.';

  @override
  String get guest_profileUnavailable =>
      'Ваш налог је већ повезан. Пријавите се да бисте прегледали и управљали својим подацима.';

  @override
  String get billing_acceptance =>
      'Настављањем прихватате Услове коришћења и Политику приватности.';

  @override
  String get guest_verifyEmailReminder =>
      'Потврдите своју имејл адресу да бисте заштитили налог. Можете и даље да користите VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Услуга је привремено недоступна. Покушајте поново за који тренутак.';

  @override
  String get guest_restoreError =>
      'Није могуће вратити ваше куповине. Покушајте поново са Google Play налогом који сте користили за куповину.';

  @override
  String get guest_claimSuccess =>
      'Ваш налог је креиран. Ваша претплата и приступ VPN-у су сачувани.';

  @override
  String get guest_emailExists =>
      'Ова имејл адреса се већ користи. Изаберите другу адресу или се пријавите на постојећи налог. Ваша куповина и даље је доступна преко Google Play-а.';

  @override
  String get guest_claimError =>
      'Налог није могуће креирати. Можете и даље да користите VPN и да покушате поново касније.';

  @override
  String get guest_secureStorageError =>
      'Сесију није могуће заштитити на овом уређају. Покушајте поново.';

  @override
  String get guest_premiumRequired =>
      'Изаберите претплату да бисте активирали VPN.';

  @override
  String get welcome_viewPlans => 'Прикажи планове';

  @override
  String get google_continue => 'Настави помоћу Google-а';

  @override
  String get google_or => 'или';

  @override
  String get google_title => 'Ваш FuzeVPN налог';

  @override
  String get google_settingUp => 'Довршите креирање налога';

  @override
  String get google_country => 'Држава пребивалишта';

  @override
  String get google_profileDescription =>
      'Изаберите државу и прегледајте два документа да бисте креирали FuzeVPN налог.';

  @override
  String get google_claimDescription =>
      'Повежите налог госта са Google-ом. Ваша претплата и уређај остају повезани са овим налогом.';

  @override
  String get google_linkTitle => 'Повежите Google са FuzeVPN-ом';

  @override
  String get google_linkDescription =>
      'Потврдите приступ постојећем FuzeVPN налогу. Овај корак не тражи вашу Google лозинку.';

  @override
  String get google_password => 'Лозинка за FuzeVPN';

  @override
  String get google_linkAccount => 'Потврди повезивање';

  @override
  String get google_requestEmail => 'Пошаљи ми имејл за потврду';

  @override
  String get google_emailInstructions =>
      'Отворите имејл од FuzeVPN-а и унесите код за потврду.';

  @override
  String get google_emailCode => 'Код за потврду из имејла';

  @override
  String get google_confirmEmail => 'Потврди код';

  @override
  String get google_restart => 'Изабери други Google налог';

  @override
  String get google_resume => 'Провери овај покушај';

  @override
  String get google_unavailable =>
      'Пријава помоћу Google-а није доступна. Можете да користите имејл и лозинку.';

  @override
  String get google_expired =>
      'Овај покушај је истекао. Откажите га и почните поново.';

  @override
  String get google_conflict =>
      'Овај Google налог је већ повезан на другом месту. Ваш тренутни налог и претплата су задржани.';

  @override
  String get google_error =>
      'Пријава помоћу Google-а није успела. Покушајте поново; ваш тренутни приступ је задржан.';

  @override
  String get google_uncertain =>
      'Резултат није могуће потврдити. Проверите овај покушај или га откажите пре него што почнете изнова.';

  @override
  String get google_cancelFailed =>
      'Отказивање није могуће потврдити. Покушајте поново да откажете пре него што напустите овај екран.';

  @override
  String get google_cancelled => 'Пријава помоћу Google-а је отказана.';

  @override
  String get google_selecting => 'Изаберите свој Google налог…';

  @override
  String get google_verifying => 'Провера вашег налога…';

  @override
  String get google_emailUnavailable =>
      'Имејл за потврду није могуће послати. Покушајте поново касније.';

  @override
  String get google_emailSent =>
      'Имејл за потврду је послат. Проверите пријемно сандуче.';

  @override
  String get google_rateLimited => 'Сачекајте пре него што покушате поново.';

  @override
  String get google_busy =>
      'Google није доступан док је у току друга операција (VPN веза, налог или гост). Покушајте поново када се заврши; ваш тренутни приступ је задржан.';

  @override
  String get google_invalidPassword =>
      'Лозинка за FuzeVPN није исправна. Ваш тренутни налог је задржан.';

  @override
  String get google_invalidCode => 'Код за потврду није важећи или је истекао.';

  @override
  String get google_accountChanged =>
      'Ваша сесија се променила. Откажите овај покушај пре него што почнете изнова.';

  @override
  String get google_invalidResponse =>
      'Одговор није могуће потврдити. Ваш тренутни приступ је задржан.';

  @override
  String get google_invalidRegistration =>
      'Проверите државу и обе сагласности.';

  @override
  String get google_consentRequired =>
      'Изаберите државу и прихватите оба документа да бисте наставили.';

  @override
  String get google_challengeRequired =>
      'Потребна је додатна безбедносна провера. Ваш тренутни приступ је задржан.';

  @override
  String get google_challengeUnavailable =>
      'Безбедносна провера није доступна. Покушајте поново касније.';

  @override
  String get google_intentMismatch =>
      'Претходни покушај пријаве помоћу Google-а је још на чекању. Откажите га пре него што покренете ову операцију.';

  @override
  String get google_challengeBlocked =>
      'Потребна безбедносна провера није доступна у овој апликацији. Ова операција се тренутно не може завршити.';

  @override
  String get google_solveChallenge => 'Заврши безбедносну проверу';

  @override
  String get google_challengeTitle => 'Безбедносна провера';

  @override
  String get google_challengeReady =>
      'Провера је завршена. Сада можете да потврдите креирање налога.';

  @override
  String get google_challengeExpired =>
      'Провера је истекла. Довршите је поново пре потврђивања.';

  @override
  String get google_challengeCancelled =>
      'Провера је отказана. Можете је покушати поново.';

  @override
  String get google_challengeFailed =>
      'Безбедносна провера није успела. Покушајте поново.';

  @override
  String get billing_trialTitle => 'Испробајте Fuze Premium бесплатно';

  @override
  String get billing_trialSubtitle => 'Заштитите своју везу већ данас.';

  @override
  String get billing_trialWeeks => '2-недељна бесплатна проба';

  @override
  String billing_trialDays(String days) {
    return '$days-дневна бесплатна проба';
  }

  @override
  String get billing_trialStart => 'Започни бесплатну пробу';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ако почнете данас, прво наплаћивање предвиђено је за $date.';
  }

  @override
  String get billing_trialTerms =>
      'Аутоматски се обнавља по наведеној цени. Да бисте избегли наплату, откажите у Google Play-у пре истека пробе.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Затим $price месечно';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Затим $price годишње';
  }

  @override
  String get billing_choosePeriod => 'Изаберите план';

  @override
  String get billing_selectionHint => 'Изаберите план да бисте наставили.';

  @override
  String get billing_benefitConnection => 'Шифрована веза';

  @override
  String get billing_benefitPrivacy => 'Приватност на интернету';

  @override
  String get billing_benefitNoAccount => 'Без обавезне регистрације';

  @override
  String get billing_cancellation => 'Отказивање у Google Play-у';

  @override
  String get billing_premiumTitle => 'Боље заштићена веза.';

  @override
  String get billing_premiumSubtitle => 'Заштитите своју везу у свом ритму.';

  @override
  String get billing_priceMonthly => 'месечно';

  @override
  String get billing_priceYearly => 'годишње';

  @override
  String get billing_trialToday => 'Данас ништа не плаћате';

  @override
  String get billing_trialConfirmation =>
      'Google Play потврђује датуме, коначан износ и важеће порезе пре него што потврдите куповину.';

  @override
  String get billing_offerChanged =>
      'Услови ове понуде су се променили. Освежите планове и изаберите поново.';

  @override
  String get status_waitingNetwork => 'Чека се мрежа';

  @override
  String get status_waitingNetworkDetail =>
      'Мрежа није доступна. VPN ће проверити везу када се мрежа поново успостави.';

  @override
  String get locations_favoriteLoadFailed =>
      'Омиљене није могуће учитати. Покушајте поново.';

  @override
  String get locations_favoritesLoading => 'Учитавање омиљених…';
}
