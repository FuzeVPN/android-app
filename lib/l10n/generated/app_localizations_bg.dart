// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Защитете връзката си';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN използва VPN услугата на Android (VpnService), за да създаде криптиран тунел между това устройство и сървърите на FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Докато VPN е активен, интернет трафикът на приложенията ви, адресите на местоназначение и DNS заявките преминават през този тунел, за да се насочва връзката ви, дори когато FuzeVPN е във фонов режим.';

  @override
  String get vpnDisclosure_statusBody =>
      'Приложението използва състоянието на връзката, нейната продължителност и обема на прехвърлените данни, за да показва VPN връзката ви. Можете да я спрете по всяко време.';

  @override
  String get vpnDisclosure_privacy => 'Поверителност';

  @override
  String get vpnDisclosure_accept => 'Приемане и продължаване';

  @override
  String get vpnDisclosure_decline => 'Не сега';

  @override
  String get accountRestoration_title => 'Акаунтът временно не е достъпен';

  @override
  String get accountRestoration_message =>
      'Сесията ви е запазена. Опитайте отново, за да възстановите акаунта си. Все още можете да управлявате VPN връзката оттук.';

  @override
  String get action_retry => 'Опитайте отново';

  @override
  String get session_endingTitle => 'Прекратяване на сесията';

  @override
  String get session_ending =>
      'Прекратяване на сесията: спиране на VPN и почистване…';

  @override
  String get session_stopFailed =>
      'Спирането на VPN не е потвърдено. Повторете опита, преди да влезете отново в акаунта си.';

  @override
  String get session_cleanupFailed =>
      'VPN е спрян, но премахването на сесията не е потвърдено. Опитайте почистването отново.';

  @override
  String get session_retryStop => 'Повторно спиране';

  @override
  String get session_retryCleanup => 'Повторно почистване';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Сигурна подготовка на FuzeVPN…';

  @override
  String get nav_connection => 'Връзка';

  @override
  String get nav_locations => 'Местоположения';

  @override
  String get nav_account => 'Акаунт';

  @override
  String get nav_devices => 'Устройства';

  @override
  String get nav_settings => 'Настройки';

  @override
  String get action_refresh => 'Обновяване';

  @override
  String get auth_tab_login => 'Вход в акаунт';

  @override
  String get auth_tab_register => 'Регистрация';

  @override
  String get auth_stepAccount => 'Акаунт';

  @override
  String get auth_stepIdentity => 'Лични данни';

  @override
  String get auth_stepAddress => 'Адрес и съгласия';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Стъпка $current от $total';
  }

  @override
  String get auth_tagline => 'Вашият VPN – просто и лесно.';

  @override
  String get auth_keysLocal =>
      'Вашите частни VPN ключове остават на това устройство.';

  @override
  String get form_email => 'Имейл адрес';

  @override
  String get form_password => 'Парола';

  @override
  String get form_showPassword => 'Показване на паролата';

  @override
  String get form_hidePassword => 'Скриване на паролата';

  @override
  String get form_passwordMin =>
      'От 8 до 72 байта в UTF-8. Някои знаци заемат повече от един байт.';

  @override
  String get form_firstName => 'Собствено име';

  @override
  String get form_lastName => 'Фамилия';

  @override
  String get form_phone => 'Телефон (+33612345678)';

  @override
  String get form_address => 'Адрес';

  @override
  String get form_address2 => 'Допълнение към адреса (по избор)';

  @override
  String get form_postalCode => 'Пощенски код';

  @override
  String get form_city => 'Град';

  @override
  String get form_country => 'Код на държава (напр. FR)';

  @override
  String get action_login => 'Вход в акаунт';

  @override
  String get action_createAccount => 'Създаване на акаунт';

  @override
  String get action_createMyAccount => 'Създайте акаунта си';

  @override
  String get action_next => 'Продължете';

  @override
  String get action_previous => 'Назад';

  @override
  String get action_forgotPassword => 'Забравена парола?';

  @override
  String get auth_noAccount => 'Все още нямате акаунт?';

  @override
  String get auth_requiredInformation => 'Създайте акаунта си в три стъпки.';

  @override
  String get auth_termsPrefix => 'Приемам ';

  @override
  String get auth_termsLink => 'условията за ползване';

  @override
  String get auth_privacyPrefix => 'Приемам ';

  @override
  String get auth_privacyLink => 'политиката за поверителност';

  @override
  String get auth_consentRequired =>
      'Необходимо е вашето съгласие, за да създадете акаунт.';

  @override
  String get validation_required => 'Това поле е задължително.';

  @override
  String get validation_email => 'Въведете валиден имейл адрес.';

  @override
  String get validation_password =>
      'Паролата е твърде кратка: поне 8 байта в UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Паролата е твърде дълга: най-много 72 байта в UTF-8.';

  @override
  String get validation_phone =>
      'Използвайте международен формат, например +33612345678.';

  @override
  String get validation_country =>
      'Използвайте двубуквен код на държава, например FR.';

  @override
  String get passwordReset_title => 'Нулиране на паролата';

  @override
  String get passwordReset_description =>
      'Въведете имейл адреса на акаунта си, за да заявите линк за нулиране на паролата.';

  @override
  String get passwordReset_send => 'Изпратете линк';

  @override
  String get connection_title => 'Вашата връзка';

  @override
  String get connection_subtitle =>
      'Изберете местоположение и след това включете VPN.';

  @override
  String get connection_prepare => 'Готови ли сте да се свържете?';

  @override
  String get connection_advancedOptions => 'Разширени опции';

  @override
  String get connection_location => 'Местоположение';

  @override
  String get connection_chooseLocation => 'Изберете местоположение';

  @override
  String get connection_protocol => 'Протокол';

  @override
  String get connection_connect => 'Свързване';

  @override
  String get connection_connecting => 'Свързване…';

  @override
  String get connection_disconnect => 'Прекъсване на връзката';

  @override
  String get connection_disconnecting => 'Прекъсване на връзката';

  @override
  String get connection_locationChange => 'Смяна на местоположението…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol е недостъпен';
  }

  @override
  String get connection_activeLocation => 'Активно местоположение';

  @override
  String get connection_duration => 'Продължителност';

  @override
  String get connection_received => 'Получени';

  @override
  String get connection_sent => 'Изпратени';

  @override
  String get connection_lastHandshake => 'Последен защитен обмен';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Преди $duration';
  }

  @override
  String get verification_title => 'Потвърдете имейл адреса си';

  @override
  String get verification_message =>
      'Потвърдете имейл адреса си, за да използвате VPN на този телефон.';

  @override
  String get verification_resend => 'Изпратете имейла отново';

  @override
  String get migration_title => 'Смяна на местоположението';

  @override
  String get migration_draining => 'Подготовка на смяната на местоположението…';

  @override
  String get migration_activating => 'Активиране на новия сървър…';

  @override
  String get migration_ready => 'Местоположението е актуализирано.';

  @override
  String get migration_blocked =>
      'Смяната на местоположението изисква намеса от сървъра. Опитайте отново по-късно или се свържете с поддръжката.';

  @override
  String get migration_progress => 'Напредък на смяната на местоположението';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Интервал между проверките: $seconds сек.';
  }

  @override
  String get migration_resume => 'Възобновяване на смяната';

  @override
  String get status_authorizing => 'Необходимо е разрешение';

  @override
  String get status_authorizingDetail =>
      'Приемете заявката на Android, за да разрешите VPN.';

  @override
  String get status_preparing => 'Подготовка';

  @override
  String get status_preparingDetail => 'Защитената ви връзка се подготвя.';

  @override
  String get status_reconnecting => 'Повторно свързване…';

  @override
  String get status_reconnectingDetail =>
      'Връзката е прекъсната. VPN се опитва да се свърже отново.';

  @override
  String get status_connecting => 'Свързване';

  @override
  String get status_connectingDetail => 'Свързване със сървъра на VPN…';

  @override
  String get status_connected => 'Свързан';

  @override
  String get status_connectedDetail => 'VPN връзката ви е активна.';

  @override
  String get status_disconnecting => 'Прекъсване на връзката';

  @override
  String get status_disconnectingDetail => 'VPN връзката ви се прекъсва.';

  @override
  String get status_error => 'Връзката е недостъпна';

  @override
  String get status_errorDetail =>
      'VPN връзката не е потвърдена. Опитайте отново.';

  @override
  String get status_idle => 'Не е свързан';

  @override
  String get status_idleDetail => 'Свържете VPN, за да защитите връзката си.';

  @override
  String get trust_note =>
      'Затварянето на приложението не спира VPN. За да го спрете, използвайте „Прекъсване на връзката“.';

  @override
  String get locations_none => 'В момента няма налични местоположения.';

  @override
  String get locations_available => 'Изберете следващото си местоположение.';

  @override
  String get locations_selected => 'Избрано местоположение';

  @override
  String get locations_select => 'Изберете това местоположение';

  @override
  String get locations_lockedTunnel =>
      'Прекъснете VPN връзката, за да смените местоположението.';

  @override
  String get locations_lockedMigration =>
      'Изчакайте смяната на местоположението да приключи.';

  @override
  String get devices_title => 'Вашите устройства';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit устройства';
  }

  @override
  String get devices_refresh => 'Обновяване на устройствата';

  @override
  String get devices_empty => 'Все още няма регистрирано VPN устройство.';

  @override
  String get devices_firstConnection =>
      'Телефонът ви ще бъде добавен при първата връзка.';

  @override
  String get devices_thisDevice => 'Това устройство';

  @override
  String devices_added(Object date) {
    return 'Добавено на $date';
  }

  @override
  String get devices_unnamed => 'Устройство без име';

  @override
  String get action_remove => 'Премахване';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_subtitle =>
      'Вашите предпочитания и акаунт на едно място.';

  @override
  String get settings_appearance => 'Външен вид';

  @override
  String get settings_language => 'Език';

  @override
  String get settings_languageDescription =>
      'Избраният език важи и за VPN известията.';

  @override
  String get settings_account => 'Акаунт';

  @override
  String get settings_signOut => 'Изход от акаунт';

  @override
  String get settings_privacy => 'Политика за поверителност';

  @override
  String get settings_terms => 'Условия за ползване';

  @override
  String get settings_security => 'Сигурност и прозрачност';

  @override
  String get settings_licenses => 'Лицензи на компонентите';

  @override
  String get settings_licensesDetail => 'Софтуер, използван в приложението';

  @override
  String settings_licensesLegalese(String url) {
    return 'Изходен код на приложението и на неговите компоненти с лиценз MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN остава включен, когато напуснете приложението. За да го спрете, използвайте „Прекъсване на връзката“ в раздела „Връзка“.';

  @override
  String get theme_system => 'Системна';

  @override
  String get theme_light => 'Светла';

  @override
  String get theme_dark => 'Тъмна';

  @override
  String get language_system => 'Език на телефона';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Премахване на това устройство?';

  @override
  String get dialog_removeCurrent =>
      'Този телефон ще прекъсне връзката с VPN и ще загуби достъп. Данните за VPN връзката му ще бъдат премахнати, след като сървърът потвърди.';

  @override
  String dialog_removeOther(Object name) {
    return 'VPN достъпът за „$name“ ще бъде отнет. Това действие не може да бъде отменено.';
  }

  @override
  String get dialog_signOut => 'Изход от акаунта?';

  @override
  String get dialog_signOutMessage =>
      'VPN ще спре и ще трябва отново да влезете в акаунта си. Криптираните ви VPN ключове ще останат на този телефон за следващата ви връзка.';

  @override
  String get action_cancel => 'Отказ';

  @override
  String get action_close => 'Затваряне';

  @override
  String get action_copy => 'Копиране';

  @override
  String get action_renew => 'Подновяване';

  @override
  String get action_signOut => 'Изход от акаунт';

  @override
  String get notice_close => 'Затваряне на съобщението';

  @override
  String get notice_sessionExpired_title => 'Сесията е изтекла';

  @override
  String get notice_sessionExpired_message =>
      'Сесията ви е изтекла. Влезте отново в акаунта си.';

  @override
  String get notice_connectionFailed_title => 'Неуспешно свързване';

  @override
  String get notice_invalidCredentials_message =>
      'Имейл адресът или паролата са неправилни.';

  @override
  String get notice_emailVerification_title =>
      'Необходимо е потвърждение на имейл';

  @override
  String get notice_emailVerification_message =>
      'Потвърдете имейл адреса си, преди да добавите VPN устройство.';

  @override
  String get notice_rateLimited_title => 'Твърде много опити';

  @override
  String get notice_deviceLimit_title => 'Достигнат е лимитът за устройства';

  @override
  String get notice_deviceLimit_message =>
      'Премахнете съществуващо устройство, преди да добавите друго.';

  @override
  String get notice_identityRenewal_title =>
      'VPN идентичността трябва да бъде подновена';

  @override
  String get notice_identityRenewal_message =>
      'Тази идентичност е премахната. Създайте нова локална идентичност.';

  @override
  String get notice_migrationPending_title =>
      'Смяната на местоположението е в ход';

  @override
  String get notice_migrationPending_message =>
      'Вече е в ход смяна на местоположението.';

  @override
  String get notice_migrationBlocked_title =>
      'Смяната на местоположението е блокирана';

  @override
  String get notice_migrationBlocked_message =>
      'Смяната на местоположението изисква намеса от сървъра. Опитайте отново по-късно или се свържете с поддръжката.';

  @override
  String get notice_targetUnavailable_title => 'Сървърът временно е недостъпен';

  @override
  String get notice_targetUnavailable_message =>
      'Този сървър временно е недостъпен.';

  @override
  String get notice_networkUnavailable_title =>
      'Интернет връзката е недостъпна';

  @override
  String get notice_networkUnavailable_message =>
      'Проверете връзката си и опитайте отново.';

  @override
  String get notice_permissionDenied_title => 'VPN разрешението е отказано';

  @override
  String get notice_permissionDenied_message =>
      'Стартирайте отново връзката и приемете заявката за разрешение на Android.';

  @override
  String get notice_wireguardTimeout_title => 'Сървърът не отговаря';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard връзката отне твърде дълго. Опитайте отново или изберете друго местоположение.';

  @override
  String get notice_tlsFailed_title => 'Защитената връзка е отказана';

  @override
  String get notice_tlsFailed_message =>
      'Сървърът не прие OpenVPN връзката. Опитайте отново. Ако проблемът продължава, стартирайте диагностика.';

  @override
  String get notice_tunRejected_title => 'Android отхвърли VPN интерфейса';

  @override
  String get notice_tunRejected_message =>
      'Android отхвърли мрежовата конфигурация, поискана от OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN не можа да се стартира';

  @override
  String get notice_openvpnStart_message =>
      'Ядрото на OpenVPN не успя да завърши стартирането. Опитайте отново. Ако проблемът продължава, свържете се с поддръжката.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Диагностичен код: $code';
  }

  @override
  String get notice_generic_title => 'Неуспешна VPN връзка';

  @override
  String get notice_generic_message =>
      'Възникна грешка. Опитайте отново по-късно.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Акаунтът е създаден',
      'password_reset_sent': 'Заявката за нулиране на паролата е получена',
      'verification_email_sent': 'Имейлът за потвърждение е изпратен',
      'location_migration_pending': 'Смяната на местоположението е в ход',
      'vpn_sign_in_required': 'Необходим е вход',
      'protocol_unavailable_at_location': 'Протоколът не е наличен',
      'vpn_permission_denied': 'VPN разрешението е отказано',
      'revoked_identity_device_limit': 'Достигнат е лимитът за устройства',
      'tunnel_start_unexpected': 'VPN не можа да стартира',
      'flutter_disconnect_timeout': 'Прекъсването не е потвърдено',
      'flutter_disconnect_unexpected': 'Връзката не можа да бъде прекъсната',
      'device_revoked': 'Устройството е премахнато',
      'revoke_unexpected': 'Устройството не можа да бъде премахнато',
      'identity_renewal_unexpected': 'Идентичността не можа да бъде подновена',
      'openvpn_renewal_unexpected': 'OpenVPN не можа да бъде подновен',
      'location_migration_blocked': 'Смяната на местоположението е блокирана',
      'location_migration_slow': 'Смяната на местоположението все още е в ход',
      'location_migration_conflict':
          'Смяната на местоположението изисква обновяване',
      'location_migration_verification_failed':
          'Смяната на местоположението не е потвърдена',
      'location_migration_device_changed':
          'Устройството е променено при смяната на местоположението',
      'tunnel_stop_failed': 'Смяната на местоположението е недостъпна',
      'device_clock_ahead': 'Часовникът на устройството избързва',
      'other': 'Операцията е неуспешна',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Акаунтът е създаден, но имейлът за потвърждение не можа да бъде изпратен. Използвайте опцията за повторно изпращане в приложението.',
      'password_reset_sent':
          'Заявката ви е получена. Ако има акаунт с този адрес, може да получите имейл. Проверете и папката със спам.',
      'verification_email_sent':
          'Току-що изпратихме нов имейл за потвърждение.',
      'location_migration_pending':
          'Преместването към $target все още се подготвя. Можете да го възобновите, без да създавате отново устройството.',
      'vpn_sign_in_required': 'Влезте в акаунта си, преди да стартирате VPN.',
      'protocol_unavailable_at_location':
          'Избраният протокол не се предлага на това местоположение. Обновете местоположенията или изберете друг протокол.',
      'vpn_permission_denied':
          'Android отказа VPN разрешението. Стартирайте отново връзката и приемете системната заявка.',
      'revoked_identity_device_limit':
          'VPN достъпът на това устройство е премахнат и е достигнат лимитът за устройства. Премахнете устройство в Акаунт → Управление на устройствата ми.',
      'tunnel_start_unexpected':
          'Непредвидена грешка прекъсна подготовката на тунела. Проверете диагностичния код и опитайте отново.',
      'flutter_disconnect_timeout':
          'Android не потвърди навреме, че VPN е спрян. Опитайте да го спрете отново.',
      'flutter_disconnect_unexpected':
          'Непредвидена грешка попречи да се потвърди спирането на тунела.',
      'device_revoked':
          'VPN достъпът на устройството е отнет и локалните му секретни данни са премахнати.',
      'revoke_unexpected':
          'Устройството не можа да бъде премахнато. Обновете списъка и опитайте отново.',
      'identity_renewal_unexpected':
          'Новата VPN идентичност не можа да бъде създадена. Обновете устройствата и опитайте отново.',
      'openvpn_renewal_unexpected':
          'OpenVPN профилът не можа да бъде подновен. Опитайте отново или проверете диагностичния код.',
      'location_migration_blocked':
          'Сървърът не може да завърши тази промяна в момента. Устройството и локалната му идентичност бяха запазени.',
      'location_migration_slow':
          'Сървърът все още подготвя преместването към $target. След малко използвайте „Възобновяване“.',
      'location_migration_conflict':
          'Състоянието на устройството се промени на сървъра. Обновете устройствата и след това възобновете смяната.',
      'location_migration_verification_failed':
          'Сървърът не потвърди новото местоположение. Предишната локална идентичност беше запазена.',
      'location_migration_device_changed':
          'Устройството, върнато от сървъра, вече не съвпада с устройството, което се променя. Обновете устройствата, преди да опитате отново.',
      'tunnel_stop_failed':
          'Предишният тунел трябва да бъде напълно спрян, преди да се установи новата връзка.',
      'device_clock_ahead':
          'Изглежда, че часовникът на това устройство избързва. Включете автоматичните дата и час, за да останете в акаунта си.',
      'other':
          'Операцията не можа да бъде завършена. Опитайте отново или изпратете диагностичния код до поддръжката.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Сесията е изтекла',
      'invalid_credentials': 'Неуспешен вход',
      'email_verification_required': 'Необходимо е потвърждение на имейла',
      'verification_email_cooldown': 'Имейлът вече е изпратен',
      'rate_limited': 'Твърде много опити',
      'invalid_registration': 'Информацията трябва да бъде коригирана',
      'email_exists': 'Акаунтът вече съществува',
      'invalid_profile': 'Невалиден профил',
      'invalid_device': 'Невалидно устройство',
      'invalid_location': 'Местоположението не е налично',
      'device_limit': 'Достигнат е лимитът за устройства',
      'device_exists': 'VPN идентичността вече се използва',
      'device_identity_revoked': 'VPN идентичността трябва да бъде подновена',
      'device_location_locked':
          'Смяната на местоположението изисква обновяване',
      'location_migration_pending': 'Смяната на местоположението е в ход',
      'location_migration_blocked': 'Смяната на местоположението е блокирана',
      'target_ca_mismatch': 'Несъвместим OpenVPN сървър',
      'location_migration_conflict':
          'Смяната на местоположението изисква обновяване',
      'server_full': 'Сървърът е пълен',
      'capacity_unavailable': 'Местоположението е временно недостъпно',
      'target_unavailable': 'Сървърът е временно недостъпен',
      'not_found': 'Елементът не е намерен',
      'invalid_openvpn_csr': 'Невалидна OpenVPN идентичност',
      'openvpn_profile_exists': 'OpenVPN профилът вече съществува',
      'openvpn_profile_revoked': 'OpenVPN профилът е отменен',
      'openvpn_operation_pending': 'OpenVPN операция в ход',
      'openvpn_operation_terminal': 'OpenVPN операцията е прекъсната',
      'openvpn_address_unavailable': 'OpenVPN адресът е недостъпен',
      'openvpn_profile_conflict': 'Конфликт в OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN е недостъпен',
      'email_delivery_unavailable': 'Имейл услугата е недостъпна',
      'invalid_token': 'Невалиден линк',
      'network_unavailable': 'Интернет връзката е недостъпна',
      'invalid_json': 'Невалидна заявка',
      'invalid_api_response': 'Невалиден отговор от сървъра',
      'ipv6_unavailable': 'IPv6 е недостъпен',
      'invalid_ip_families': 'Мрежовата конфигурация е отхвърлена',
      'other': 'Услугата е недостъпна',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Сесията ви е изтекла. Влезте отново в акаунта си.',
      'invalid_credentials': 'Имейл адресът или паролата са неправилни.',
      'email_verification_required':
          'Потвърдете имейл адреса си, преди да добавите VPN устройство.',
      'invalid_registration': 'Проверете исканата информация и съгласията.',
      'email_exists': 'Вече има акаунт с този имейл адрес.',
      'invalid_profile': 'Проверете информацията за профила си.',
      'invalid_device':
          'Името или локалната идентичност на това устройство са невалидни.',
      'invalid_location':
          'Обновете списъка с местоположения и опитайте отново.',
      'device_limit':
          'Премахнете съществуващо устройство, преди да добавите друго.',
      'device_exists': 'Тази VPN идентичност вече е свързана с друг акаунт.',
      'device_identity_revoked':
          'Тази идентичност е премахната. Трябва да се създаде нова локална идентичност.',
      'device_location_locked':
          'Местоположението на това устройство току-що се промени. Приложението ще възобнови смяната, която е в ход.',
      'location_migration_pending': 'Вече е в ход смяна на местоположението.',
      'location_migration_blocked':
          'Смяната на местоположението изисква намеса от сървъра. Опитайте отново по-късно или се свържете с поддръжката.',
      'target_ca_mismatch':
          'Този сървър все още не е съвместим с текущия OpenVPN профил.',
      'location_migration_conflict':
          'Обновете устройствата, след което опитайте смяната на местоположението отново.',
      'server_full':
          'Това местоположение е достигнало лимита си за връзки. Изберете друго местоположение или опитайте отново по-късно.',
      'capacity_unavailable':
          'Не можем да потвърдим дали това местоположение е налично в момента. Изберете друго местоположение или опитайте отново по-късно.',
      'target_unavailable': 'Този сървър е временно недостъпен.',
      'not_found': 'Този елемент вече не е наличен във вашия акаунт.',
      'invalid_openvpn_csr':
          'Създайте нова OpenVPN идентичност и опитайте отново.',
      'openvpn_profile_exists': 'За това устройство вече има OpenVPN профил.',
      'openvpn_profile_revoked': 'За да продължите, подновете OpenVPN профила.',
      'openvpn_operation_pending':
          'Промяната все още се прилага. Опитайте отново по-късно.',
      'openvpn_operation_terminal':
          'Създайте нова OpenVPN идентичност и опитайте отново.',
      'openvpn_address_unavailable': 'В момента няма наличен OpenVPN адрес.',
      'openvpn_profile_conflict':
          'Профилът се промени. Обновете устройствата и опитайте отново.',
      'openvpn_signer_unavailable': 'Услугата OpenVPN е временно недостъпна.',
      'email_delivery_unavailable':
          'Имейлът не можа да бъде изпратен. Опитайте отново по-късно.',
      'invalid_token': 'Този линк е невалиден или е изтекъл. Заявете нов.',
      'network_unavailable':
          'Проверете интернет връзката си и опитайте отново.',
      'invalid_json': 'Проверете въведената информация и опитайте отново.',
      'invalid_api_response':
          'Сървърът върна неочакван отговор. Опитайте отново по-късно.',
      'ipv6_unavailable':
          'Сървърът не може да активира IPv6 в момента. Опитайте отново по-късно.',
      'invalid_ip_families':
          'Конфигурацията на тунела е непълна или не съответства на разрешените адреси. Опитайте отново от приложението.',
      'other': 'Възникна грешка в сървъра. Опитайте отново по-късно.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Опитайте отново след малко.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Опитайте отново след $seconds секунди.',
      one: 'Опитайте отново след $seconds секунда.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Опитайте отново след $minutes минути.',
      one: 'Опитайте отново след $minutes минута.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Опитайте отново след $hours часа.',
      one: 'Опитайте отново след $hours час.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Системното възобновяване на VPN не е налично',
      'system_vpn_resume_corrupt': 'Невалидно системно възобновяване на VPN',
      'system_vpn_resume_session_invalid':
          'Невалидна сесия за възобновяване на VPN',
      'system_vpn_resume_identity_changed': 'Идентичността на VPN се промени',
      'system_vpn_resume_identity_invalid':
          'Невалидна идентичност за възобновяване на VPN',
      'system_vpn_resume_storage_failed':
          'Хранилището за възобновяване на VPN не е налично',
      'system_vpn_resume_network_timeout': 'Няма мрежа за възобновяване на VPN',
      'system_vpn_resume_blocked': 'Възобновяването на VPN е блокирано',
      'system_vpn_resume_failed': 'Възобновяването на VPN не успя',
      'system_vpn_resume_error_invalid':
          'Невалидна грешка при възобновяване на VPN',
      'wireguard_identity_store_failed':
          'Идентичността на WireGuard не е запазена',
      'wireguard_identity_unavailable':
          'Идентичността на WireGuard не е налична',
      'vpn_host_destroyed': 'Компонентът за VPN на Android е спрян',
      'vpn_host_unavailable': 'Компонентът за VPN на Android не е наличен',
      'vpn_permission_required': 'Изисква се разрешение за VPN',
      'vpn_permission_denied': 'Разрешението за VPN е отказано',
      'vpn_permission_request_failed': 'Не може да се поиска разрешение',
      'wireguard_foreground_service_unavailable':
          'Услугата WireGuard не е налична',
      'wireguard_identity_invalid': 'Невалиден локален ключ за WireGuard',
      'wireguard_identity_in_use':
          'Идентичността на WireGuard вече се използва',
      'wireguard_configuration_invalid': 'Невалидна конфигурация на WireGuard',
      'wireguard_operation_pending':
          'Операцията на WireGuard все още е активна',
      'wireguard_start_failed': 'Стартирането на WireGuard е отхвърлено',
      'wireguard_stop_timeout': 'Спирането на WireGuard не е потвърдено',
      'wireguard_handshake_timeout': 'WireGuard не отговори',
      'openvpn_connection_timeout': 'OpenVPN не отговори',
      'openvpn_core_unavailable': 'Ядрото на OpenVPN не е налично',
      'openvpn_operation_pending': 'Сесията на OpenVPN все още е активна',
      'openvpn_stop_timeout': 'Спирането на OpenVPN не е потвърдено',
      'openvpn_profile_unavailable': 'Локалният профил на OpenVPN липсва',
      'openvpn_native_failed': 'Нативното извикване на OpenVPN е прекъснато',
      'openvpn_key_generation_failed':
          'Не може да се създаде P-256 ключ за OpenVPN',
      'openvpn_csr_generation_failed': 'Не може да се създаде CSR за OpenVPN',
      'openvpn_identity_store_failed': 'Идентичността на OpenVPN не е запазена',
      'openvpn_identity_clear_failed': 'Премахването на OpenVPN е непълно',
      'openvpn_identity_in_use': 'Идентичността на OpenVPN все още се използва',
      'openvpn_tls_verification_required': 'Липсва TLS проверка за OpenVPN',
      'openvpn_cipher_invalid': 'Невалиден шифър за OpenVPN',
      'openvpn_profile_rejected': 'Профилът на OpenVPN е отхвърлен',
      'openvpn_identity_inconsistent': 'Несъответстваща идентичност за OpenVPN',
      'tls_handshake_failed': 'Договарянето за OpenVPN е отхвърлено',
      'tls_alert_unknown_ca':
          'Клиентският сертификат за OpenVPN не е разпознат',
      'tls_alert_bad_certificate':
          'Клиентският сертификат за OpenVPN е отхвърлен',
      'tls_alert_unsupported_certificate': 'Неподдържан сертификат за OpenVPN',
      'tls_client_certificate_required':
          'Изисква се клиентски сертификат за OpenVPN',
      'tls_alert_misc': 'TLS предупреждение за OpenVPN',
      'tls_signature_algorithm_rejected': 'Неподдържан подпис за OpenVPN',
      'tls_handshake_rejected': 'Договарянето на TLS за OpenVPN е отхвърлено',
      'tls_version_rejected': 'Несъвместима TLS версия за OpenVPN',
      'tls_certificate_expired': 'TLS сертификатът е изтекъл',
      'tls_certificate_revoked': 'TLS сертификатът е отменен',
      'transport_failed': 'Сървърът на OpenVPN е недостъпен',
      'tun_configuration_rejected':
          'Интерфейсът за OpenVPN не може да се създаде',
      'tun_setup_failed': 'Настройката на TUN за OpenVPN не успя',
      'tun_interface_create_failed':
          'Създаването на интерфейс за OpenVPN не успя',
      'tun_interface_disabled': 'Интерфейсът за OpenVPN е деактивиран',
      'tun_halted': 'Интерфейсът за OpenVPN е прекъснат',
      'tun_already_established': 'Интерфейсът за OpenVPN вече е отворен',
      'tun_addresses_missing': 'Липсва адрес за OpenVPN',
      'tun_routes_missing': 'Липсват маршрути за OpenVPN',
      'tun_dns_missing': 'Липсва DNS за OpenVPN',
      'tun_permission_revoked': 'Разрешението за VPN е отнето',
      'tun_establish_returned_null': 'Android отхвърли VPN интерфейса',
      'openvpn_service_start_failed': 'Услугата за OpenVPN не е налична',
      'openvpn_operation_timeout': 'Времето за извикване на OpenVPN изтече',
      'openvpn_start_failed': 'Стартирането на OpenVPN е отхвърлено',
      'openvpn_connection_failed': 'OpenVPN връзката е прекъсната',
      'openvpn_core_status_error': 'Ядрото на OpenVPN приключи с грешка',
      'openvpn_stopped_before_connected': 'OpenVPN спря преди свързване',
      'openvpn_auth_failed': 'Удостоверяването за OpenVPN е отхвърлено',
      'openvpn_client_setup_failed':
          'Настройката на клиента за OpenVPN не успя',
      'openvpn_client_halted': 'Клиентът на OpenVPN е прекъснат',
      'openvpn_client_restart': 'Поискано е рестартиране на OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN е неактивен твърде дълго',
      'openvpn_session_expired': 'Сесията на OpenVPN изтече',
      'openvpn_credentials_required': 'Неподдържано удостоверяване за OpenVPN',
      'openvpn_proxy_failed': 'Транспортът през посредник за OpenVPN не успя',
      'openvpn_compression_failed': 'Компресията за OpenVPN е отхвърлена',
      'openvpn_ntlm_crypto_unavailable':
          'NTLM криптирането за OpenVPN не е налично',
      'openvpn_feature_unsupported': 'Неподдържана функция за OpenVPN',
      'network_unavailable': 'Интернет връзката е недостъпна',
      'network_lost': 'Мрежата не е налична',
      'certificate_validation_failed': 'Сертификатът на сървъра е отхвърлен',
      'openvpn_certificate_expired': 'Сертификатът за OpenVPN е изтекъл',
      'tunnel_active_for_another_account':
          'Тунелът на друг акаунт все още е активен',
      'tunnel_already_active': 'Нативният тунел вече е активен',
      'tunnel_stop_timeout': 'Спирането на $protocol не е потвърдено',
      'tunnel_disconnected': 'Връзката $protocol е прекъсната',
      'native_bridge_unavailable': 'Мостът към Android не е наличен',
      'native_operation_failed': 'Операцията в Android е прекъсната',
      'invalid_arguments': 'Непълни параметри за VPN',
      'invalid_account_id': 'Невалиден акаунт за VPN',
      'invalid_device_id': 'Невалиден идентификатор на устройство',
      'storage_key_not_allowed': 'Ключът за съхранение е отхвърлен',
      'secure_storage_read_failed': 'Четенето от защитеното хранилище не успя',
      'secure_storage_write_failed':
          'Записването в защитеното хранилище не успя',
      'key_generation_failed': 'Не може да се генерира ключ за WireGuard',
      'csr_generation_failed': 'Не може да се генерира CSR за OpenVPN',
      'openvpn_recovery_exhausted':
          'Възстановяването на OpenVPN вече е използвано',
      'openvpn_recovery_failed': 'Възстановяването на OpenVPN не успя',
      'openvpn_renewal_required':
          'Изисква се подновяване на сертификата за OpenVPN',
      'other': 'Некласифицирана нативна VPN грешка',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android не намира VPN сесия, която може да се възобнови. Стартирайте нова връзка в приложението.',
      'system_vpn_resume_corrupt':
          'Запазените данни за възобновяване на VPN са невалидни и няма да се използват. Стартирайте нова връзка.',
      'system_vpn_resume_session_invalid':
          'Запазената сесия вече не може да възобнови VPN. Влезте отново в акаунта си в приложението.',
      'system_vpn_resume_identity_changed':
          'Локалната идентичност на VPN се промени. Възобновяването е спряно. Стартирайте нова връзка.',
      'system_vpn_resume_identity_invalid':
          'Идентичността за възобновяване е невалидна. Стартирайте нова връзка.',
      'system_vpn_resume_storage_failed':
          'Android не можа да прочете или актуализира криптираните данни за възобновяване. Стартирайте нова връзка.',
      'system_vpn_resume_network_timeout':
          'Android не намери мрежа навреме, за да възобнови VPN. Опитайте отново, когато има налична мрежа.',
      'system_vpn_resume_blocked':
          'Възобновяването на VPN е блокирано. Проверете настройките на Android и след това стартирайте нова връзка.',
      'system_vpn_resume_failed':
          'Възобновяването на VPN от Android не успя. Стартирайте нова връзка в приложението.',
      'system_vpn_resume_error_invalid':
          'Android върна неизползваема грешка при възобновяване. Стартирайте нова връзка.',
      'wireguard_identity_store_failed':
          'Android не можа да запази криптираната идентичност на WireGuard за този акаунт.',
      'wireguard_identity_unavailable':
          'Няма използваема идентичност на WireGuard за тази връзка.',
      'vpn_host_destroyed':
          'Компонентът на Android, който хоства VPN, е спрян. Стартирайте нова връзка.',
      'vpn_host_unavailable':
          'Android не може да създаде компонента, който хоства VPN. Опитайте отново, след като проверите настройките на VPN.',
      'openvpn_renewal_required':
          'Сертификатът за OpenVPN не можа да бъде подновен автоматично. Стартирайте нова връзка в приложението.',
      'openvpn_recovery_failed':
          'Автоматичното възстановяване не успя. Стартирайте нова връзка в приложението.',
      'openvpn_recovery_exhausted':
          'Автоматичното възстановяване вече е използвано. Стартирайте нова връзка в приложението.',
      'vpn_permission_required':
          'Android изисква ново разрешение за VPN, преди да стартира тунела.',
      'vpn_permission_denied':
          'Разрешете FuzeVPN в заявката на Android, за да продължите.',
      'vpn_permission_request_failed':
          'Android не можа да отвори екрана за разрешение за VPN.',
      'wireguard_foreground_service_unavailable':
          'Android не можа да задържи услугата WireGuard на преден план.',
      'wireguard_identity_invalid':
          'Криптираният ключ на WireGuard за този акаунт е нечетим или невалиден.',
      'wireguard_identity_in_use':
          'Друга операция все още използва ключа на WireGuard за този акаунт.',
      'wireguard_configuration_invalid':
          'Получените адрес, DNS, ключ на сървъра или маршрути за WireGuard са невалидни.',
      'wireguard_operation_pending':
          'Предишната операция на WireGuard все още не е освободила нативната си услуга.',
      'wireguard_start_failed':
          'Ядрото на WireGuard отхвърли активирането на конфигурацията.',
      'wireguard_stop_timeout':
          'Услугата WireGuard не потвърди освобождаването на VPN интерфейса в рамките на допустимото време.',
      'wireguard_handshake_timeout':
          'Тунелът не потвърди ръкостискане със сървъра навреме.',
      'openvpn_connection_timeout':
          'OpenVPN не потвърди връзката със сървъра навреме.',
      'openvpn_core_unavailable':
          'Тази версия на приложението не съдържа работещо ядро за OpenVPN.',
      'openvpn_operation_pending':
          'Нативното ядро все още държи предишната сесия на OpenVPN и отказва да създаде втора.',
      'openvpn_stop_timeout':
          'Ядрото на OpenVPN не потвърди, че нативната му сесия е спряна и унищожена в рамките на допустимото време.',
      'openvpn_profile_unavailable':
          'За тази връзка не може да се прочете валидиран профил на OpenVPN.',
      'openvpn_native_failed':
          'Грешка в приложението прекъсна OpenVPN. Опитайте да се свържете отново. Ако проблемът продължава, стартирайте диагностика.',
      'openvpn_key_generation_failed':
          'Android Keystore не можа да създаде или прочете частния P-256 ключ, който не може да се експортира.',
      'openvpn_csr_generation_failed':
          'Ключът в Android Keystore не можа да подпише заявката за сертификат на OpenVPN.',
      'openvpn_identity_store_failed':
          'Сертификатът или профилът на OpenVPN не можа да бъде запазен в криптираното хранилище.',
      'openvpn_identity_clear_failed':
          'Android не можа да премахне цялата локална идентичност на OpenVPN за този акаунт.',
      'openvpn_identity_in_use':
          'Нативна сесия на OpenVPN все още използва ключа или сертификата на това устройство.',
      'openvpn_tls_verification_required':
          'Профилът не изисква изрично проверка на сертификата на сървъра.',
      'openvpn_cipher_invalid':
          'Сървърът предостави алгоритъм за криптиране, който не е в списъка с разрешените.',
      'openvpn_profile_rejected':
          'Профилът, получен от сървъра, е несъвместим. Създайте отново устройството и опитайте пак.',
      'openvpn_identity_inconsistent':
          'Сертификатът не съответства на защитената идентичност на този телефон. Не е заменен локален профил.',
      'tls_handshake_failed':
          'Сървърът отхвърли TLS договарянето. Ако проблемът продължава, създайте отново профила.',
      'tls_alert_unknown_ca':
          'Сървърът не разпознава издаващия орган на сертификата на това устройство. Трябва да се провери сървърът на OpenVPN.',
      'tls_alert_bad_certificate':
          'Сървърът отхвърли сертификата на това устройство. Създайте отново устройството, преди да опитате пак.',
      'tls_alert_unsupported_certificate':
          'Сървърът не поддържа защитения тип сертификат, използван от Android.',
      'tls_client_certificate_required':
          'Сървърът изисква клиентски сертификат, но ядрото на OpenVPN не можа да го представи.',
      'tls_alert_misc':
          'Сървърът върна TLS предупреждение, което не попада в категориите за сертификат или версия.',
      'tls_signature_algorithm_rejected':
          'Сървърът отхвърли алгоритъма ECDSA P-256 на ключа от Android Keystore.',
      'tls_handshake_rejected':
          'Сървърът прекъсна TLS договарянето преди свързването.',
      'tls_version_rejected':
          'Клиентът и сървърът не намериха обща TLS версия.',
      'tls_certificate_expired':
          'Сертификатът, представен по време на връзката, е изтекъл.',
      'tls_certificate_revoked':
          'Сертификатът, представен по време на връзката, е отменен.',
      'transport_failed':
          'Сървърът на OpenVPN не отговаря в текущата мрежа. Опитайте отново след малко.',
      'tun_configuration_rejected':
          'Android отхвърли мрежовата конфигурация, поискана от OpenVPN.',
      'tun_setup_failed':
          'Ядрото на OpenVPN отхвърли мрежовия план, преди да създаде интерфейса на Android.',
      'tun_interface_create_failed':
          'Ядрото на OpenVPN не можа да получи TUN интерфейса от VpnService на Android.',
      'tun_interface_disabled':
          'Android или ядрото на OpenVPN деактивира TUN интерфейса по време на връзката.',
      'tun_halted':
          'Ядрото на OpenVPN получи заявка за спиране на TUN интерфейса.',
      'tun_already_established':
          'OpenVPN поиска втори интерфейс в същата връзка. Тунелът е спрян от съображения за сигурност.',
      'tun_addresses_missing':
          'Сървърът не предостави използваем адрес за тунела.',
      'tun_routes_missing':
          'Сървърът не предостави използваеми маршрути за тунела.',
      'tun_dns_missing': 'Сървърът не предостави използваем DNS сървър.',
      'tun_permission_revoked':
          'Android отне разрешението за VPN по време на връзката.',
      'tun_establish_returned_null':
          'Android не създаде интерфейса, обикновено защото друг VPN все още е активен.',
      'openvpn_service_start_failed':
          'Android не можа да стартира услугата OpenVPN на преден план.',
      'openvpn_operation_timeout':
          'Извикване през JNI към ядрото на OpenVPN надхвърли максималната си продължителност.',
      'openvpn_start_failed':
          'Услугата на Android е готова, но ядрото на OpenVPN не прие стартирането на профила.',
      'openvpn_connection_failed':
          'Ядрото на OpenVPN спря, преди да изпрати събитието CONNECTED.',
      'openvpn_core_status_error':
          'Нативният цикъл на OpenVPN приключи с грешка, без по-конкретно крайно събитие.',
      'openvpn_stopped_before_connected':
          'Нативният цикъл на OpenVPN спря, преди да се свърже, без изрична грешка от ядрото.',
      'openvpn_auth_failed':
          'Сървърът на OpenVPN отхвърли удостоверяването на профила.',
      'openvpn_client_setup_failed':
          'Ядрото на OpenVPN не можа да инициализира клиента преди мрежовата връзка.',
      'openvpn_client_halted':
          'Ядрото на OpenVPN получи окончателна заявка за спиране на клиента.',
      'openvpn_client_restart':
          'Ядрото на OpenVPN поиска рестартиране на транспортната си сесия.',
      'openvpn_inactive_timeout':
          'Ядрото на OpenVPN затвори сесията след изтичане на времето за неактивност.',
      'openvpn_session_expired':
          'Сървърът съобщи, че сесията на OpenVPN е изтекла.',
      'openvpn_credentials_required':
          'Сървърът или прокси сървърът изисква интерактивни данни за вход, които не са част от този профил със сертификат.',
      'openvpn_proxy_failed':
          'Ядрото на OpenVPN съобщи за грешка в конфигурирания прокси или релей.',
      'openvpn_compression_failed':
          'Ядрото на OpenVPN отхвърли режима на компресия, обявен от профила или сървъра.',
      'openvpn_ntlm_crypto_unavailable':
          'Профилът изисква NTLM криптиране, което не е налично в тази версия.',
      'openvpn_feature_unsupported':
          'Профилът или сървърът изисква функция, която липсва в този Android клиент.',
      'network_unavailable': 'Няма използваема физическа мрежа.',
      'network_lost': 'Тунелът беше спрян, след като мрежата се загуби.',
      'certificate_validation_failed':
          'Идентичността на сървъра на OpenVPN не можа да бъде потвърдена.',
      'openvpn_certificate_expired':
          'Сертификатът за OpenVPN е изтекъл. За да го подновите, стартирайте нова връзка в приложението.',
      'tunnel_active_for_another_account':
          'Тунел, принадлежащ на друг акаунт, трябва да бъде спрян, преди тази връзка.',
      'tunnel_already_active':
          'Android съобщава, че предишна VPN сесия все още използва интерфейса.',
      'tunnel_stop_timeout':
          'Ядрото на $protocol не потвърди освобождаването на VPN интерфейса в рамките на допустимото време.',
      'tunnel_disconnected':
          'Нативното ядро съобщи, че тунелът приключи неочаквано след стартирането.',
      'native_bridge_unavailable':
          'Приложението няма достъп до VPN услугата на Android. Затворете и отворете отново приложението, след което опитайте пак.',
      'native_operation_failed':
          'Грешка в приложението прекъсна VPN операцията. Опитайте отново. Ако проблемът продължава, стартирайте диагностика.',
      'invalid_arguments':
          'Информацията, нужна за тази VPN операция, е непълна. Опитайте отново. Ако проблемът продължава, стартирайте диагностика.',
      'invalid_account_id':
          'Нативната операция не е свързана с валиден идентификатор на акаунт.',
      'invalid_device_id':
          'Идентификаторът на устройството, изпратен към нативното ядро, липсва или е невалиден.',
      'storage_key_not_allowed':
          'Мостът към Android блокира ключ извън разрешения списък за съхранение.',
      'secure_storage_read_failed':
          'Android Keystore не можа да декриптира локалните данни на този акаунт.',
      'secure_storage_write_failed':
          'Android Keystore не можа да криптира или запази локалните данни.',
      'key_generation_failed':
          'Android не можа да създаде или прочете ключа на WireGuard в защитеното хранилище.',
      'csr_generation_failed':
          'Android Keystore не можа да създаде или подпише P-256 CSR заявката за OpenVPN.',
      'other':
          'Възникна грешка в недокументиран нативен клон на кода. Изпратете диагностичния код, показан по-долу, до поддръжката.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Заявката за разрешение вече е отворена';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Заявката за VPN разрешение на Android вече е показана. Довършете я, преди да опитате отново.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Заявката за VPN разрешение е прекъсната';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Екранът за VPN разрешение е затворен, преди приложението да получи отговор.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN връзката не е потвърдена';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN връзката не можа да бъде потвърдена. Тя е спряна от съображения за сигурност. Опитайте отново.';

  @override
  String get openvpnCleanup_title => 'OpenVPN профилът е отменен';

  @override
  String get openvpnCleanup_working =>
      'Спиране и премахване на отменения OpenVPN профил…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Спирането на OpenVPN не е потвърдено. Опитайте отново, преди да създадете нов профил.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Отмененият OpenVPN профил не можа да бъде премахнат напълно. Опитайте почистването отново.';

  @override
  String get openvpnCleanup_complete =>
      'Отмененият OpenVPN профил е премахнат. Докоснете „Свързване“, за да създадете нов.';

  @override
  String get network_title => 'Мрежова конфигурация';

  @override
  String get network_ipv4Fallback =>
      'IPv6 е временно недостъпен. Подготовката продължава с IPv4.';

  @override
  String get network_rejectedTitle => 'Мрежовата конфигурация е отхвърлена';

  @override
  String get network_rejectedMessage =>
      'Конфигурацията на тунела е непълна или не съответства на разрешените адреси. Опитайте отново от приложението.';

  @override
  String get network_unreadableTitle =>
      'Локалната конфигурация не може да се прочете';

  @override
  String get network_unreadableMessage =>
      'Запазената OpenVPN мрежова конфигурация не може да се използва. Свържете се отново от приложението, за да я актуализирате.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Мрежова защита';

  @override
  String get protection_subtitle =>
      'Блокирайте директния достъп до интернет, ако VPN връзката прекъсне.';

  @override
  String get protection_active => 'Системната защита е активна';

  @override
  String get protection_alwaysOnOnly =>
      'Функцията „Винаги включен VPN“ е активирана; включете блокирането извън VPN';

  @override
  String get protection_inactive => 'Системната защита е неактивна';

  @override
  String get protection_unknown => 'Проверете системната защита';

  @override
  String get protection_openSettings => 'Отворете настройките на Android';

  @override
  String get protection_dialogTitle => 'Настройте мрежовата защита';

  @override
  String get protection_dialogMessage =>
      'Android управлява функцията „Винаги включен VPN“ и блокирането на връзки извън VPN. Проверете дали е избрано FuzeVPN и включете блокирането в системните настройки.';

  @override
  String get protection_dialogOpen => 'Отворете настройките';

  @override
  String get session_systemProtectionNote =>
      'Ако Android все още блокира трафика извън VPN, отворете системните настройки, за да проверите или промените тази защита.';

  @override
  String get diagnostics_title => 'Диагностика';

  @override
  String get diagnostics_settingsTitle => 'Диагностика на приложението';

  @override
  String get diagnostics_automaticTitle => 'Изпращане на важни грешки';

  @override
  String get diagnostics_automaticDescription =>
      'Споделяйте кратък технически доклад, когато възникне важна грешка.';

  @override
  String get diagnostics_privacy =>
      'Изпратените доклади се свързват с акаунта, в който сте влезли, и се съхраняват 30 дни. Те не съдържат история на сърфиране, пароли или VPN ключове.';

  @override
  String get diagnostics_manualOpen => 'Стартиране на диагностика';

  @override
  String get diagnostics_localDescription =>
      'Създайте доклад за състоянието на приложението и VPN. Връзката ви остава непроменена.';

  @override
  String get diagnostics_sendReport => 'Изпращане на доклада';

  @override
  String get diagnostics_sendHint =>
      'Оставете квадратчето неотбелязано, за да запазите доклада на това устройство.';

  @override
  String get diagnostics_signedOut =>
      'Влезте в акаунта си, за да изпратите доклад.';

  @override
  String get diagnostics_localLifetime =>
      'Запазете този доклад на телефона си, за да остане след затваряне на приложението.';

  @override
  String get diagnostics_run => 'Стартиране на диагностика';

  @override
  String get diagnostics_rerun => 'Стартиране на диагностиката отново';

  @override
  String get diagnostics_running => 'Проверка…';

  @override
  String get diagnostics_sending => 'Изпращане на доклада…';

  @override
  String get diagnostics_prepared => 'Докладът е готов на това устройство';

  @override
  String get diagnostics_queued => 'Докладът чака да бъде изпратен';

  @override
  String get diagnostics_sent => 'Докладът е получен';

  @override
  String get diagnostics_failed =>
      'Неуспешно изпращане. Локалният ви доклад все още е наличен.';

  @override
  String get diagnostics_preparationFailed =>
      'Диагностичният доклад не можа да бъде подготвен. Опитайте отново.';

  @override
  String get diagnostics_authenticationRequired =>
      'Влезте отново, за да изпратите доклада.';

  @override
  String get diagnostics_retry => 'Опитайте изпращането отново';

  @override
  String get diagnostics_export => 'Запазване на доклада';

  @override
  String get diagnostics_exportFailed =>
      'Неуспешно експортиране. Опитайте отново от локалния доклад.';

  @override
  String get diagnostics_preferenceFailed =>
      'Тази настройка не можа да бъде запазена. Опитайте отново.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Референтен номер: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Получен на $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Съхранява се до $date';
  }

  @override
  String get diagnostics_duplicate => 'Този доклад вече е получен.';

  @override
  String get diagnostics_preview => 'Преглед на доклада';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикачени са $count технически събития',
      one: 'Прикачено е 1 техническо събитие',
      zero: 'Няма прикачени технически събития',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Технически подробности';

  @override
  String get diagnostics_empty => 'Все още няма подготвен диагностичен доклад.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Състояние на тунела',
      'handshake': 'Потвърждение на връзката',
      'certificate': 'VPN сертификат',
      'kill_switch': 'Защита на Android',
      'connectivity': 'Налична мрежа',
      'api_reachability': 'Достъп до услугата',
      'secure_storage': 'Защитено хранилище',
      'other': 'Локална проверка',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Проверено',
      'failed': 'Изисква внимание',
      'skipped': 'Не е тествано – няма активна проверка',
      'unknown': 'Информацията не е налична',
      'other': 'Информацията не е налична',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Добре дошли във FuzeVPN';

  @override
  String get connection_changeLocation => 'Смяна на местоположението';

  @override
  String get connection_details => 'Подробности за връзката';

  @override
  String get locations_searchLabel => 'Търсене на град или държава';

  @override
  String get locations_clearSearch => 'Изчистване на търсенето';

  @override
  String get locations_filterAll => 'Всички';

  @override
  String get locations_filterFavorites => 'Любими';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count местоположения',
      one: '$count местоположение',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Няма намерени местоположения';

  @override
  String get locations_noResultsHint => 'Опитайте с друг град или държава.';

  @override
  String get locations_noFavorites => 'Любимите ви – винаги под ръка';

  @override
  String get locations_noFavoritesHint =>
      'Докоснете звездичката до местоположение, за да го запазите тук.';

  @override
  String get locations_showAll => 'Преглед на всички местоположения';

  @override
  String locations_addFavorite(String name) {
    return 'Добавяне на $name към любимите';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Премахване на $name от любимите';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Промяната в любимите не можа да бъде запазена. Опитайте отново.';

  @override
  String get locations_emptyTitle => 'Няма налични местоположения';

  @override
  String get locations_emptyHint => 'Обновете списъка, за да опитате отново.';

  @override
  String get devices_manage => 'Управление на устройствата ми';

  @override
  String get settings_personalization => 'По ваш вкус';

  @override
  String get settings_safety => 'Защита';

  @override
  String get settings_help => 'Нужна ли ви е помощ?';

  @override
  String get settings_about => 'За FuzeVPN';

  @override
  String get diagnostics_heading => 'Разбиране на проблем с връзката';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Наличен',
      'pending': 'Подготвя се',
      'revoked': 'Премахнат',
      'expired': 'Изтекъл',
      'other': 'Състоянието не е налично',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Предпочитанието не е запазено';

  @override
  String get notice_preferenceSave_message =>
      'Изборът ви се прилага засега, но не можа да бъде запазен. Опитайте отново, за да го запазите след затваряне на приложението.';

  @override
  String get connection_androidDisconnectHint =>
      'Ако Android поддържа VPN връзката активна, изключете „Винаги включен VPN“ в настройките, които ще се отворят.';

  @override
  String get connection_certificate => 'Сертификат за OpenVPN';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Валиден до $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Изтекъл на $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Ще се поднови автоматично при следващото свързване.';

  @override
  String get protection_learnMore => 'Научете повече за защитата на Android';

  @override
  String get protection_guideWhy =>
      'Тази защита предотвратява директното използване на интернет от приложенията, ако VPN връзката се прекъсне. Настройва се в Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Винаги включен VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android поддържа работата на VPN услугата и може да я стартира отново след рестартиране на телефона.';

  @override
  String get protection_guideBlockTitle => 'Блокиране на връзки без VPN';

  @override
  String get protection_guideBlock =>
      'Тази настройка не позволява трафикът да заобикаля VPN връзката, включително докато връзката е прекъсната.';

  @override
  String get protection_guideWarning =>
      'Когато това блокиране е включено, достъпът до интернет остава изключен, докато VPN връзката не бъде установена.';

  @override
  String get protection_guideStepsTitle => 'Включване на защитата';

  @override
  String get protection_guideStep1 =>
      'Отворете настройките на VPN в Android с бутона по-долу.';

  @override
  String get protection_guideStep2 =>
      'Отворете опциите с иконата на зъбно колело до FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Включете „Винаги включен VPN“, след това „Блокиране на връзки без VPN“, ако тези опции са налични.';

  @override
  String get protection_guideManufacturers =>
      'Имената варират в зависимост от телефона. При нужда потърсете VPN в настройките, често в „Мрежа и интернет“.';

  @override
  String get protection_guideDisableTitle => 'Изключване на тази защита';

  @override
  String get protection_guideDisable =>
      'В същите настройки изключете блокирането без VPN, за да разрешите достъп до интернет без VPN. Изключете и „Винаги включен VPN“, ако не искате Android да го стартира отново.';

  @override
  String get protection_guideManual =>
      'Тези настройки се задават в Android. FuzeVPN не ги променя вместо вас.';

  @override
  String get locations_changeTitle => 'Смяна на местоположението?';

  @override
  String locations_changeActive(String name) {
    return 'VPN връзката ще се прекъсне, след което ще бъде направен опит за свързване към $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'Ще бъде направен опит за свързване на VPN към $name.';
  }

  @override
  String get locations_confirmChange => 'Смяна и свързване';

  @override
  String get locations_changeBusy =>
      'Смяната вече е в ход. Изчакайте, преди да изберете друго местоположение.';

  @override
  String get locations_automaticSelection => 'Автоматичен избор';

  @override
  String get locations_cities => 'Градове';

  @override
  String get locations_servers => 'Сървъри';

  @override
  String locations_viewCities(String name) {
    return 'Преглед на градовете на $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Преглед на сървърите на $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count държави',
      one: '$count държава',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count града',
      one: '$count град',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сървъра',
      one: '$count сървър',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Всички държави';

  @override
  String get locations_backToCountries => 'Назад към държавите';

  @override
  String locations_backToCities(String name) {
    return 'Назад към градовете на $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Изберете $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Изберете $name';
  }

  @override
  String get locations_noCompatibleServer => 'Няма налични съвместими сървъри.';

  @override
  String get externalLink_failed =>
      'Този линк не може да се отвори. Можете да го копирате и да го отворите в браузъра си.';

  @override
  String get externalLink_copy => 'Копиране на линка';

  @override
  String get externalLink_copied => 'Линкът е копиран';

  @override
  String get externalLink_copyFailed =>
      'Линкът не може да се копира. Изберете адреса по-долу.';

  @override
  String get settings_deleteAccount => 'Изтриване на акаунта ми';

  @override
  String get settings_deleteAccountDetail =>
      'Преглед на процедурата за заявка за изтриване на акаунт';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Изберете абонамента си за VPN.';

  @override
  String get billing_subscribe => 'Абониране';

  @override
  String get billing_choosePlan => 'Изберете план, за да продължите.';

  @override
  String get billing_monthly => 'Месечен';

  @override
  String get billing_yearly => 'Годишен';

  @override
  String get billing_continue => 'Продължете с Google Play';

  @override
  String get billing_restore => 'Възстановяване на покупки';

  @override
  String get billing_manage => 'Управление на абонамента';

  @override
  String get billing_deleteAccountWarning =>
      'Ако имате абонамент в Google Play, изтриването на вашия FuzeVPN акаунт не отменя подновяването му. Управлявайте или отменете подновяването отделно в Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Продължете към заявката за изтриване на акаунт';

  @override
  String get billing_refresh => 'Обновяване на достъпа';

  @override
  String get billing_loadingPlans => 'Зареждане на плановете…';

  @override
  String get billing_unavailable =>
      'В момента няма налични планове. Опитайте отново по-късно.';

  @override
  String get billing_comingSoon => 'Абонаментите ще бъдат налични скоро.';

  @override
  String get billing_priceDisclosure =>
      'Цената се предоставя от Google Play. Крайната сума и приложимите данъци се потвърждават преди финализиране на покупката.';

  @override
  String get billing_renewalMonthly =>
      'Подновява се автоматично всеки месец, освен ако не бъде отменен. Можете да го отмените по всяко време от абонаментите си в Google Play.';

  @override
  String get billing_renewalYearly =>
      'Подновява се автоматично всяка година, освен ако не бъде отменен. Можете да го отмените по всяко време от абонаментите си в Google Play.';

  @override
  String get billing_active => 'Вашият достъп до Premium е активен';

  @override
  String billing_accessUntil(String date) {
    return 'Достъп до $date.';
  }

  @override
  String get billing_webManaged =>
      'Вашият абонамент се управлява на уебсайта на FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Вашият абонамент се управлява от Google Play.';

  @override
  String get billing_playOnHold =>
      'Вашият абонамент в Google Play е временно спрян или очаква плащане. Отворете „Управление на абонамента“, за да го уредите в Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Този акаунт в Google Play вече има абонамент за Fuze Premium, който не е активен за този FuzeVPN акаунт. Отворете „Управление на абонамента“, за да го прегледате в Google Play.';

  @override
  String get billing_inactive => 'Няма активен абонамент.';

  @override
  String get billing_checkingAccess => 'Проверка на достъпа ви…';

  @override
  String get billing_restoring => 'Възстановяване на покупките…';

  @override
  String get billing_pending =>
      'Плащането е в процес на обработка. Достъпът ви ще се активира след потвърждение.';

  @override
  String get billing_cancelled =>
      'Покупката е отменена. Не е активиран нов абонамент.';

  @override
  String get billing_verifying => 'Проверка на покупката…';

  @override
  String get billing_success =>
      'Абонаментът е активиран. Достъпът ви до Premium е готов.';

  @override
  String get billing_restored => 'Покупките ви са възстановени.';

  @override
  String get billing_restoreEmpty =>
      'В този акаунт в Google Play няма покупки за възстановяване.';

  @override
  String get billing_catalogError =>
      'Плановете не могат да се заредят. Опитайте отново.';

  @override
  String get billing_purchaseError =>
      'Покупката не може да започне. Опитайте отново.';

  @override
  String get billing_verificationError =>
      'Проверката на покупката е временно недостъпна. Възстановете покупките, за да опитате отново.';

  @override
  String get billing_restoreError =>
      'Покупките не могат да се възстановят. Опитайте отново.';

  @override
  String get billing_managementError =>
      'Управлението на абонаментите не може да се отвори. Опитайте отново.';

  @override
  String get billing_storeUnavailable =>
      'Google Play не е наличен на това устройство.';

  @override
  String get welcome_title => 'Вашият VPN – просто и лесно.';

  @override
  String get welcome_description =>
      'Защитете връзката си. Запазете контрола върху поверителността си.';

  @override
  String get welcome_start => 'Започнете';

  @override
  String get welcome_alreadyPurchased => 'Вече имате покупка?';

  @override
  String get welcome_noAccountRequired => 'За начало не е нужен акаунт.';

  @override
  String get guest_accountTitle => 'Акаунтът не е свързан';

  @override
  String get guest_accountDescription =>
      'Възстановете покупките си със същия акаунт в Google Play, за да използвате абонамента си на друго устройство.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Вече сте абонирани? Влезте в акаунта си';

  @override
  String get guest_claimTitle => 'Вземете FuzeVPN със себе си';

  @override
  String get guest_claimDescription =>
      'Създайте акаунт, за да получите достъп до абонамента си на другите си устройства. Тази стъпка е незадължителна.';

  @override
  String get guest_skip => 'Може би по-късно';

  @override
  String get guest_activationTitle => 'Абонаментът Fuze Premium е активен';

  @override
  String get guest_activationDescription =>
      'Абонаментът ви е готов. Използвайте VPN и създайте акаунт, когато поискате.';

  @override
  String get guest_useVpn => 'Използване на VPN';

  @override
  String get guest_loginRequired =>
      'Тази покупка вече е свързана с FuzeVPN акаунт. Влезте в този акаунт, за да получите достъп до абонамента си.';

  @override
  String get guest_signOutWarning =>
      'Можете да си върнете абонамента, като възстановите покупките със същия акаунт в Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Акаунтът ви вече е свързан. Влезте, за да преглеждате и управлявате данните си.';

  @override
  String get billing_acceptance =>
      'Като продължите, приемате Условията за ползване и Политиката за поверителност.';

  @override
  String get guest_verifyEmailReminder =>
      'Потвърдете имейл адреса си, за да защитите акаунта си. Можете да продължите да използвате VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Услугата временно не е налична. Опитайте отново след малко.';

  @override
  String get guest_restoreError =>
      'Покупките ви не могат да бъдат възстановени. Опитайте отново с акаунта в Google Play, с който е направена покупката.';

  @override
  String get guest_claimSuccess =>
      'Акаунтът ви е създаден. Абонаментът и достъпът ви до VPN са запазени.';

  @override
  String get guest_emailExists =>
      'Този имейл вече се използва. Изберете друг адрес или влезте в съществуващия си акаунт. Покупката ви остава достъпна чрез Google Play.';

  @override
  String get guest_claimError =>
      'Акаунтът ви не можа да бъде създаден. Можете да продължите да използвате VPN и да опитате отново по-късно.';

  @override
  String get guest_secureStorageError =>
      'Сесията ви не можа да бъде защитена на това устройство. Опитайте отново.';

  @override
  String get guest_premiumRequired =>
      'Изберете абонамент, за да активирате VPN.';

  @override
  String get welcome_viewPlans => 'Преглед на плановете';

  @override
  String get google_continue => 'Продължете с Google';

  @override
  String get google_or => 'или';

  @override
  String get google_title => 'Вашият FuzeVPN акаунт';

  @override
  String get google_settingUp => 'Завършете създаването на акаунта си';

  @override
  String get google_country => 'Държава на пребиваване';

  @override
  String get google_profileDescription =>
      'Изберете държавата си и прегледайте двата документа, за да създадете FuzeVPN акаунт.';

  @override
  String get google_claimDescription =>
      'Свържете гост акаунта си с Google. Абонаментът и устройството ви остават свързани с този акаунт.';

  @override
  String get google_linkTitle => 'Свържете Google с FuzeVPN';

  @override
  String get google_linkDescription =>
      'Потвърдете достъпа до съществуващия си FuzeVPN акаунт. Тази стъпка не изисква паролата ви за Google.';

  @override
  String get google_password => 'Парола за FuzeVPN';

  @override
  String get google_linkAccount => 'Потвърдете свързването';

  @override
  String get google_requestEmail => 'Изпратете ми имейл за потвърждение';

  @override
  String get google_emailInstructions =>
      'Отворете имейла от FuzeVPN и въведете кода за потвърждение.';

  @override
  String get google_emailCode => 'Код за потвърждение по имейл';

  @override
  String get google_confirmEmail => 'Потвърдете кода';

  @override
  String get google_restart => 'Изберете друг акаунт в Google';

  @override
  String get google_resume => 'Проверете този опит';

  @override
  String get google_unavailable =>
      'Входът с Google не е наличен. Можете да използвате имейл и парола.';

  @override
  String get google_expired =>
      'Този опит е изтекъл. Отменете го и започнете отново.';

  @override
  String get google_conflict =>
      'Този акаунт в Google вече е свързан другаде. Текущият ви акаунт и абонаментът се запазват.';

  @override
  String get google_error =>
      'Неуспешен вход с Google. Опитайте отново; текущият ви достъп се запазва.';

  @override
  String get google_uncertain =>
      'Резултатът не можа да бъде потвърден. Проверете този опит или го отменете, преди да започнете отново.';

  @override
  String get google_cancelFailed =>
      'Отмяната не можа да бъде потвърдена. Опитайте да отмените отново, преди да напуснете този екран.';

  @override
  String get google_cancelled => 'Входът с Google е отменен.';

  @override
  String get google_selecting => 'Изберете вашия акаунт в Google…';

  @override
  String get google_verifying => 'Проверка на акаунта ви…';

  @override
  String get google_emailUnavailable =>
      'Имейлът за потвърждение не можа да бъде изпратен. Опитайте отново по-късно.';

  @override
  String get google_emailSent =>
      'Имейлът за потвърждение е изпратен. Проверете входящата си поща.';

  @override
  String get google_rateLimited => 'Моля, изчакайте, преди да опитате отново.';

  @override
  String get google_busy =>
      'Google не е наличен, докато друга операция е в ход (VPN връзка, акаунт или гост). Опитайте отново, след като тя приключи; текущият ви достъп се запазва.';

  @override
  String get google_invalidPassword =>
      'Паролата за FuzeVPN е неправилна. Текущият ви акаунт се запазва.';

  @override
  String get google_invalidCode =>
      'Кодът за потвърждение е невалиден или е изтекъл.';

  @override
  String get google_accountChanged =>
      'Сесията ви се промени. Отменете този опит, преди да започнете отново.';

  @override
  String get google_invalidResponse =>
      'Отговорът не можа да бъде проверен. Текущият ви достъп се запазва.';

  @override
  String get google_invalidRegistration =>
      'Проверете държавата си и двете съгласия.';

  @override
  String get google_consentRequired =>
      'Изберете държавата си и приемете двата документа, за да продължите.';

  @override
  String get google_challengeRequired =>
      'Изисква се допълнителна проверка за сигурност. Текущият ви достъп се запазва.';

  @override
  String get google_challengeUnavailable =>
      'Проверката за сигурност не е налична. Опитайте отново по-късно.';

  @override
  String get google_intentMismatch =>
      'Предишен опит за вход с Google все още не е приключил. Отменете го, преди да започнете тази операция.';

  @override
  String get google_challengeBlocked =>
      'Необходимата проверка за сигурност не е налична в това приложение. Тази операция не може да бъде завършена в момента.';

  @override
  String get google_solveChallenge => 'Преминете проверката за сигурност';

  @override
  String get google_challengeTitle => 'Проверка за сигурност';

  @override
  String get google_challengeReady =>
      'Проверката е завършена. Вече можете да потвърдите създаването на акаунта си.';

  @override
  String get google_challengeExpired =>
      'Проверката е изтекла. Извършете я отново, преди да потвърдите.';

  @override
  String get google_challengeCancelled =>
      'Проверката е отменена. Можете да я опитате отново.';

  @override
  String get google_challengeFailed =>
      'Неуспешна проверка за сигурност. Опитайте отново.';

  @override
  String get billing_trialTitle => 'Изпробвайте Fuze Premium безплатно';

  @override
  String get billing_trialSubtitle => 'Защитете връзката си от днес.';

  @override
  String get billing_trialWeeks => '2-седмичен безплатен пробен период';

  @override
  String billing_trialDays(String days) {
    return '$days-дневен безплатен пробен период';
  }

  @override
  String get billing_trialStart => 'Започнете безплатния си пробен период';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ако започнете днес, първото плащане е предвидено за $date.';
  }

  @override
  String get billing_trialTerms =>
      'Подновява се автоматично на посочената цена. За да избегнете таксуване, отменете абонамента в Google Play преди края на пробния период.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'След това $price на месец';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'След това $price на година';
  }

  @override
  String get billing_choosePeriod => 'Изберете плана си';

  @override
  String get billing_selectionHint => 'Изберете план, за да продължите.';

  @override
  String get billing_benefitConnection => 'Криптирана връзка';

  @override
  String get billing_benefitPrivacy => 'Поверителност онлайн';

  @override
  String get billing_benefitNoAccount => 'Не е необходима регистрация';

  @override
  String get billing_cancellation => 'Отмяна в Google Play';

  @override
  String get billing_premiumTitle => 'По-добре защитена връзка.';

  @override
  String get billing_premiumSubtitle =>
      'Защитете връзката си в удобно за вас темпо.';

  @override
  String get billing_priceMonthly => 'на месец';

  @override
  String get billing_priceYearly => 'на година';

  @override
  String get billing_trialToday => 'Днес не плащате нищо';

  @override
  String get billing_trialConfirmation =>
      'Google Play потвърждава датите, крайната сума и приложимите данъци преди финализиране на покупката.';

  @override
  String get billing_offerChanged =>
      'Условията на това предложение са се променили. Обновете плановете и изберете отново.';

  @override
  String get status_waitingNetwork => 'Изчакване на мрежата';

  @override
  String get status_waitingNetworkDetail =>
      'Няма налична мрежа. VPN ще провери връзката, когато мрежата се възстанови.';

  @override
  String get locations_favoriteLoadFailed =>
      'Любимите не могат да се заредят. Опитайте отново.';

  @override
  String get locations_favoritesLoading => 'Зареждане на любимите…';
}
