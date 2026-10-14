// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Захистіть своє з’єднання';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN використовує службу VPN Android (VpnService), щоб створити зашифрований тунель між цим пристроєм і серверами FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Коли VPN активний, інтернет-трафік ваших застосунків, адреси призначення та DNS-запити проходять через цей тунель для маршрутизації з’єднання, навіть коли FuzeVPN працює у фоновому режимі.';

  @override
  String get vpnDisclosure_statusBody =>
      'Застосунок використовує стан з’єднання, його тривалість і обсяг переданих даних, щоб відображати ваше VPN-з’єднання. Ви можете зупинити його будь-коли.';

  @override
  String get vpnDisclosure_privacy => 'Конфіденційність';

  @override
  String get vpnDisclosure_accept => 'Прийняти й продовжити';

  @override
  String get vpnDisclosure_decline => 'Не зараз';

  @override
  String get accountRestoration_title =>
      'Обліковий запис тимчасово недоступний';

  @override
  String get accountRestoration_message =>
      'Ваш сеанс збережено. Повторіть спробу, щоб відновити обліковий запис; тут ви все ще можете керувати VPN-з’єднанням.';

  @override
  String get action_retry => 'Повторити';

  @override
  String get session_endingTitle => 'Завершення сеансу';

  @override
  String get session_ending =>
      'Ваш сеанс недійсний. Зупинення VPN і очищення даних сеансу…';

  @override
  String get session_stopFailed =>
      'Завершення роботи VPN не підтверджено. Повторіть спробу перед новим входом.';

  @override
  String get session_cleanupFailed =>
      'VPN зупинено, але видалення сеансу не підтверджено. Повторіть очищення.';

  @override
  String get session_retryStop => 'Повторити зупинення';

  @override
  String get session_retryCleanup => 'Повторити очищення';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Безпечна підготовка FuzeVPN…';

  @override
  String get nav_connection => 'З’єднання';

  @override
  String get nav_locations => 'Розташування';

  @override
  String get nav_account => 'Обліковий запис';

  @override
  String get nav_devices => 'Пристрої';

  @override
  String get nav_settings => 'Налаштування';

  @override
  String get action_refresh => 'Оновити';

  @override
  String get auth_tab_login => 'Увійти';

  @override
  String get auth_tab_register => 'Зареєструватися';

  @override
  String get auth_stepAccount => 'Обліковий запис';

  @override
  String get auth_stepIdentity => 'Ідентифікація';

  @override
  String get auth_stepAddress => 'Адреса та угоди';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Крок $current із $total';
  }

  @override
  String get auth_tagline => 'Ваш VPN — просто й зрозуміло.';

  @override
  String get auth_keysLocal =>
      'Ваші приватні ключі VPN залишаються на цьому пристрої.';

  @override
  String get form_email => 'Електронна адреса';

  @override
  String get form_password => 'Пароль';

  @override
  String get form_showPassword => 'Показати пароль';

  @override
  String get form_hidePassword => 'Приховати пароль';

  @override
  String get form_passwordMin =>
      '8–72 байти UTF-8. Деякі символи займають більше одного байта.';

  @override
  String get form_firstName => 'Ім’я';

  @override
  String get form_lastName => 'Прізвище';

  @override
  String get form_phone => 'Телефон (+33612345678)';

  @override
  String get form_address => 'Адреса';

  @override
  String get form_address2 => 'Рядок адреси 2 (необов’язково)';

  @override
  String get form_postalCode => 'Поштовий індекс';

  @override
  String get form_city => 'Місто';

  @override
  String get form_country => 'Код країни (наприклад, FR)';

  @override
  String get action_login => 'Увійти';

  @override
  String get action_createAccount => 'Створити обліковий запис';

  @override
  String get action_createMyAccount => 'Створити мій обліковий запис';

  @override
  String get action_next => 'Продовжити';

  @override
  String get action_previous => 'Назад';

  @override
  String get action_forgotPassword => 'Забули пароль?';

  @override
  String get auth_noAccount => 'Ще не маєте облікового запису?';

  @override
  String get auth_requiredInformation =>
      'Створіть обліковий запис у три кроки.';

  @override
  String get auth_termsPrefix => 'Я приймаю ';

  @override
  String get auth_termsLink => 'умови використання';

  @override
  String get auth_privacyPrefix => 'Я приймаю ';

  @override
  String get auth_privacyLink => 'політику конфіденційності';

  @override
  String get auth_consentRequired =>
      'Для створення облікового запису потрібна ваша згода.';

  @override
  String get validation_required => 'Це поле обов’язкове.';

  @override
  String get validation_email => 'Введіть дійсну електронну адресу.';

  @override
  String get validation_password =>
      'Пароль надто короткий: щонайменше 8 байтів UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Пароль надто довгий: щонайбільше 72 байти UTF-8.';

  @override
  String get validation_phone =>
      'Використовуйте міжнародний формат, наприклад +33612345678.';

  @override
  String get validation_country =>
      'Використовуйте дволітерний код країни, наприклад FR.';

  @override
  String get passwordReset_title => 'Скидання пароля';

  @override
  String get passwordReset_description =>
      'Введіть електронну адресу свого облікового запису, щоб запросити посилання для скидання пароля.';

  @override
  String get passwordReset_send => 'Надіслати посилання';

  @override
  String get connection_title => 'Ваше з’єднання';

  @override
  String get connection_subtitle =>
      'Виберіть розташування, а потім увімкніть VPN.';

  @override
  String get connection_prepare => 'Готові підключитися?';

  @override
  String get connection_advancedOptions => 'Розширені параметри';

  @override
  String get connection_location => 'Розташування';

  @override
  String get connection_chooseLocation => 'Виберіть розташування';

  @override
  String get connection_protocol => 'Протокол';

  @override
  String get connection_connect => 'Підключити';

  @override
  String get connection_connecting => 'Підключення…';

  @override
  String get connection_disconnect => 'Відключити';

  @override
  String get connection_disconnecting => 'Відключення';

  @override
  String get connection_locationChange => 'Зміна розташування…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol недоступний';
  }

  @override
  String get connection_activeLocation => 'Активне розташування';

  @override
  String get connection_duration => 'Тривалість';

  @override
  String get connection_received => 'Отримано';

  @override
  String get connection_sent => 'Надіслано';

  @override
  String get connection_lastHandshake => 'Останній захищений обмін';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration тому';
  }

  @override
  String get verification_title => 'Підтвердьте свою електронну адресу';

  @override
  String get verification_message =>
      'Підтвердьте свою електронну адресу, щоб користуватися VPN на цьому телефоні.';

  @override
  String get verification_resend => 'Надіслати лист повторно';

  @override
  String get migration_title => 'Зміна розташування';

  @override
  String get migration_draining => 'Підготовка до зміни розташування…';

  @override
  String get migration_activating => 'Активація нового сервера…';

  @override
  String get migration_ready => 'Розташування оновлено.';

  @override
  String get migration_blocked =>
      'Для зміни розташування потрібне втручання сервера. Спробуйте пізніше або зверніться до служби підтримки.';

  @override
  String get migration_progress => 'Перебіг зміни розташування';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Затримка між перевірками: $seconds с.';
  }

  @override
  String get migration_resume => 'Продовжити зміну розташування';

  @override
  String get status_authorizing => 'Потрібен дозвіл';

  @override
  String get status_authorizingDetail =>
      'Прийміть запит Android, щоб дозволити VPN.';

  @override
  String get status_preparing => 'Підготовка';

  @override
  String get status_preparingDetail => 'Підготовка безпечного з’єднання.';

  @override
  String get status_reconnecting => 'Повторне підключення…';

  @override
  String get status_reconnectingDetail =>
      'З’єднання перервано. VPN намагається підключитися знову.';

  @override
  String get status_connecting => 'Підключення';

  @override
  String get status_connectingDetail => 'Підключення до VPN-сервера…';

  @override
  String get status_connected => 'Підключено';

  @override
  String get status_connectedDetail => 'Ваше VPN-з’єднання активне.';

  @override
  String get status_disconnecting => 'Відключення';

  @override
  String get status_disconnectingDetail => 'Ваше VPN-з’єднання зупиняється.';

  @override
  String get status_error => 'З’єднання недоступне';

  @override
  String get status_errorDetail =>
      'VPN-з’єднання не підтверджено. Спробуйте ще раз.';

  @override
  String get status_idle => 'Відключено';

  @override
  String get status_idleDetail =>
      'Підключіть VPN, щоб захистити своє з’єднання.';

  @override
  String get trust_note =>
      'Закриття програми не зупиняє VPN. Щоб зупинити його, натисніть «Відключити».';

  @override
  String get locations_none => 'Наразі немає доступних розташувань.';

  @override
  String get locations_available => 'Виберіть наступне розташування.';

  @override
  String get locations_selected => 'Вибране розташування';

  @override
  String get locations_select => 'Вибрати це розташування';

  @override
  String get locations_lockedTunnel =>
      'Відключіть VPN, щоб змінити розташування.';

  @override
  String get locations_lockedMigration =>
      'Зачекайте, доки зміна розташування завершиться.';

  @override
  String get devices_title => 'Ваші пристрої';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit пристроїв';
  }

  @override
  String get devices_refresh => 'Оновити пристрої';

  @override
  String get devices_empty => 'Ще не зареєстровано жодного VPN-пристрою.';

  @override
  String get devices_firstConnection =>
      'Ваш телефон буде додано під час першого підключення.';

  @override
  String get devices_thisDevice => 'Цей пристрій';

  @override
  String devices_added(Object date) {
    return 'Додано $date';
  }

  @override
  String get action_remove => 'Видалити';

  @override
  String get settings_title => 'Налаштування';

  @override
  String get settings_subtitle =>
      'Ваші параметри та обліковий запис в одному місці.';

  @override
  String get settings_appearance => 'Вигляд';

  @override
  String get settings_language => 'Мова';

  @override
  String get settings_languageDescription =>
      'Вибрана мова також застосовується до сповіщень VPN.';

  @override
  String get settings_account => 'Обліковий запис';

  @override
  String get settings_signOut => 'Вийти';

  @override
  String get settings_privacy => 'Політика конфіденційності';

  @override
  String get settings_terms => 'Умови використання';

  @override
  String get settings_security => 'Безпека та прозорість';

  @override
  String get settings_licenses => 'Ліцензії компонентів';

  @override
  String get settings_licensesDetail =>
      'Програмне забезпечення, використане в програмі';

  @override
  String get settings_background =>
      'VPN залишається увімкненим, коли ви залишаєте програму. Щоб зупинити його, натисніть «Відключити» на вкладці «З’єднання».';

  @override
  String get theme_system => 'Системна';

  @override
  String get theme_light => 'Світла';

  @override
  String get theme_dark => 'Темна';

  @override
  String get language_system => 'Мова телефону';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Видалити цей пристрій?';

  @override
  String get dialog_removeCurrent =>
      'Цей телефон буде відключено від VPN, і він втратить доступ. Дані його VPN-з’єднання буде видалено після підтвердження сервером.';

  @override
  String dialog_removeOther(Object name) {
    return 'Доступ VPN для «$name» буде відкликано. Цю дію неможливо скасувати.';
  }

  @override
  String get dialog_signOut => 'Вийти?';

  @override
  String get dialog_signOutMessage =>
      'VPN буде зупинено, і вам доведеться ввійти знову. Ваші зашифровані ключі VPN залишаться на цьому телефоні для наступного підключення.';

  @override
  String get action_cancel => 'Скасувати';

  @override
  String get action_signOut => 'Вийти';

  @override
  String get notice_close => 'Закрити повідомлення';

  @override
  String get notice_sessionExpired_title => 'Термін дії сеансу минув';

  @override
  String get notice_sessionExpired_message =>
      'Термін дії вашого сеансу минув. Увійдіть знову.';

  @override
  String get notice_connectionFailed_title => 'Не вдалося підключитися';

  @override
  String get notice_invalidCredentials_message =>
      'Електронна адреса або пароль неправильні.';

  @override
  String get notice_emailVerification_title =>
      'Потрібне підтвердження електронної адреси';

  @override
  String get notice_emailVerification_message =>
      'Підтвердьте свою електронну адресу, перш ніж додавати VPN-пристрій.';

  @override
  String get notice_rateLimited_title => 'Забагато спроб';

  @override
  String get notice_deviceLimit_title => 'Досягнуто обмеження у 2 пристрої';

  @override
  String get notice_deviceLimit_message =>
      'Видаліть наявний пристрій, перш ніж додавати інший.';

  @override
  String get notice_identityRenewal_title =>
      'Потрібно оновити ідентифікацію VPN';

  @override
  String get notice_identityRenewal_message =>
      'Цю ідентифікацію видалено. Створіть нову локальну ідентифікацію.';

  @override
  String get notice_migrationPending_title => 'Триває зміна розташування';

  @override
  String get notice_migrationPending_message =>
      'Зміна розташування вже триває.';

  @override
  String get notice_migrationBlocked_title => 'Зміну розташування заблоковано';

  @override
  String get notice_migrationBlocked_message =>
      'Для зміни розташування потрібне втручання сервера. Спробуйте пізніше або зверніться до служби підтримки.';

  @override
  String get notice_targetUnavailable_title => 'Сервер тимчасово недоступний';

  @override
  String get notice_targetUnavailable_message =>
      'Цей сервер тимчасово недоступний.';

  @override
  String get notice_networkUnavailable_title =>
      'Підключення до інтернету недоступне';

  @override
  String get notice_networkUnavailable_message =>
      'Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get notice_permissionDenied_title => 'У дозволі на VPN відмовлено';

  @override
  String get notice_permissionDenied_message =>
      'Почніть підключення знову та прийміть запит Android на дозвіл.';

  @override
  String get notice_wireguardTimeout_title => 'Сервер не відповідає';

  @override
  String get notice_wireguardTimeout_message =>
      'З’єднання WireGuard тривало надто довго. Спробуйте ще раз або виберіть інше розташування.';

  @override
  String get notice_tlsFailed_title => 'У захищеному з’єднанні відмовлено';

  @override
  String get notice_tlsFailed_message =>
      'Сервер не прийняв з’єднання OpenVPN. Спробуйте ще раз. Якщо проблема не зникне, запустіть діагностику.';

  @override
  String get notice_tunRejected_title => 'Android відхилив VPN-інтерфейс';

  @override
  String get notice_tunRejected_message =>
      'Android відхилив мережеву конфігурацію, яку запросив OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Не вдалося запустити OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'Механізм OpenVPN не зміг завершити запуск. Спробуйте ще раз. Якщо проблема не зникне, зверніться до служби підтримки.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Код діагностики: $code';
  }

  @override
  String get notice_generic_title => 'Не вдалося підключитися до VPN';

  @override
  String get notice_generic_message => 'Сталася помилка. Спробуйте пізніше.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Обліковий запис створено',
      'password_reset_sent': 'Запит на скидання пароля отримано',
      'verification_email_sent': 'Лист для підтвердження надіслано',
      'location_migration_pending': 'Триває зміна розташування',
      'vpn_sign_in_required': 'Потрібен вхід',
      'protocol_unavailable_at_location': 'Протокол недоступний',
      'vpn_permission_denied': 'У дозволі на VPN відмовлено',
      'revoked_identity_device_limit': 'Досягнуто обмеження у 2 пристрої',
      'tunnel_start_unexpected': 'Не вдалося запустити VPN',
      'flutter_disconnect_timeout': 'Відключення не підтверджено',
      'flutter_disconnect_unexpected': 'Не вдалося відключитися',
      'device_revoked': 'Пристрій видалено',
      'revoke_unexpected': 'Не вдалося видалити пристрій',
      'identity_renewal_unexpected': 'Не вдалося оновити ідентифікацію',
      'openvpn_renewal_unexpected': 'Не вдалося оновити OpenVPN',
      'location_migration_blocked': 'Зміну розташування заблоковано',
      'location_migration_slow': 'Зміна розташування все ще триває',
      'location_migration_conflict': 'Зміну розташування потрібно оновити',
      'location_migration_verification_failed':
          'Зміну розташування не підтверджено',
      'location_migration_device_changed':
          'Під час зміни розташування пристрій змінився',
      'tunnel_stop_failed': 'Розташування недоступне для зміни',
      'other': 'Не вдалося виконати операцію',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Обліковий запис створено, але не вдалося надіслати лист для підтвердження. Скористайтеся повторним надсиланням у програмі.',
      'password_reset_sent':
          'Ваш запит отримано. Якщо цій адресі відповідає обліковий запис, ви можете отримати лист. Також перевірте папку зі спамом.',
      'verification_email_sent':
          'Новий лист для підтвердження щойно надіслано.',
      'location_migration_pending':
          'Переміщення до $target ще готується. Ви можете продовжити його без повторного створення пристрою.',
      'vpn_sign_in_required':
          'Увійдіть у свій обліковий запис перед запуском VPN.',
      'protocol_unavailable_at_location':
          'Вибраний протокол не пропонується в цьому розташуванні. Оновіть список розташувань або виберіть інший протокол.',
      'vpn_permission_denied':
          'Android відмовив у дозволі на VPN. Почніть підключення знову та прийміть системний запит.',
      'revoked_identity_device_limit':
          'Доступ цього пристрою до VPN видалено, а ліміт пристроїв досягнуто. Видаліть пристрій у розділі «Обліковий запис» → «Керувати моїми пристроями».',
      'tunnel_start_unexpected':
          'Несподівана помилка перервала підготовку тунелю. Перевірте код діагностики та спробуйте ще раз.',
      'flutter_disconnect_timeout':
          'Android вчасно не підтвердив, що VPN зупинено. Спробуйте зупинити його ще раз.',
      'flutter_disconnect_unexpected':
          'Несподівана помилка завадила підтвердити зупинення тунелю.',
      'device_revoked':
          'Доступ пристрою до VPN відкликано, а його локальні секрети видалено.',
      'revoke_unexpected':
          'Не вдалося видалити пристрій. Оновіть список і спробуйте ще раз.',
      'identity_renewal_unexpected':
          'Не вдалося створити нову ідентифікацію VPN. Оновіть список пристроїв і спробуйте ще раз.',
      'openvpn_renewal_unexpected':
          'Не вдалося оновити профіль OpenVPN. Спробуйте ще раз або перевірте код діагностики.',
      'location_migration_blocked':
          'Сервер не може завершити цю зміну зараз. Пристрій і його локальну ідентифікацію збережено.',
      'location_migration_slow':
          'Сервер усе ще готує переміщення до $target. Скористайтеся «Продовжити» за кілька хвилин.',
      'location_migration_conflict':
          'Стан пристрою на сервері змінився. Оновіть список пристроїв, а потім продовжіть зміну.',
      'location_migration_verification_failed':
          'Сервер не підтвердив нове розташування. Попередню локальну ідентифікацію збережено.',
      'location_migration_device_changed':
          'Пристрій, повернутий сервером, більше не відповідає пристрою, який змінюється. Оновіть список пристроїв перед новою спробою.',
      'tunnel_stop_failed':
          'Попередній тунель потрібно повністю зупинити перед новим підключенням.',
      'other':
          'Не вдалося завершити операцію. Спробуйте ще раз або надішліть код діагностики до служби підтримки.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Термін дії сеансу минув',
      'invalid_credentials': 'Не вдалося ввійти',
      'email_verification_required':
          'Потрібне підтвердження електронної адреси',
      'verification_email_cooldown': 'Лист уже надіслано',
      'rate_limited': 'Забагато спроб',
      'invalid_registration': 'Інформацію потрібно виправити',
      'email_exists': 'Обліковий запис уже існує',
      'invalid_profile': 'Недійсний профіль',
      'invalid_device': 'Недійсний пристрій',
      'invalid_location': 'Розташування недоступне',
      'device_limit': 'Досягнуто обмеження пристроїв',
      'device_exists': 'Ідентифікація VPN уже використовується',
      'device_identity_revoked': 'Потрібно оновити ідентифікацію VPN',
      'device_location_locked': 'Зміну розташування потрібно оновити',
      'location_migration_pending': 'Триває зміна розташування',
      'location_migration_blocked': 'Зміну розташування заблоковано',
      'target_ca_mismatch': 'Несумісний сервер OpenVPN',
      'location_migration_conflict': 'Зміну розташування потрібно оновити',
      'server_full': 'Сервер заповнений',
      'capacity_unavailable': 'Розташування тимчасово недоступне',
      'target_unavailable': 'Сервер тимчасово недоступний',
      'not_found': 'Елемент не знайдено',
      'invalid_openvpn_csr': 'Недійсна ідентифікація OpenVPN',
      'openvpn_profile_exists': 'Профіль OpenVPN уже існує',
      'openvpn_profile_revoked': 'Профіль OpenVPN відкликано',
      'openvpn_operation_pending': 'Операція OpenVPN триває',
      'openvpn_operation_terminal': 'Операцію OpenVPN перервано',
      'openvpn_address_unavailable': 'Адреса OpenVPN недоступна',
      'openvpn_profile_conflict': 'Конфлікт OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN недоступний',
      'email_delivery_unavailable': 'Електронна пошта недоступна',
      'invalid_token': 'Недійсне посилання',
      'network_unavailable': 'Підключення до інтернету недоступне',
      'invalid_json': 'Недійсний запит',
      'invalid_api_response': 'Недійсна відповідь сервера',
      'ipv6_unavailable': 'IPv6 недоступний',
      'invalid_ip_families': 'Конфігурацію мережі відхилено',
      'other': 'Служба недоступна',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Термін дії вашого сеансу минув. Увійдіть знову.',
      'invalid_credentials': 'Електронна адреса або пароль неправильні.',
      'email_verification_required':
          'Підтвердьте свою електронну адресу, перш ніж додавати VPN-пристрій.',
      'invalid_registration': 'Перевірте запитувану інформацію та згоди.',
      'email_exists':
          'Для цієї електронної адреси вже використовується обліковий запис.',
      'invalid_profile': 'Перевірте дані свого профілю.',
      'invalid_device':
          'Назва цього пристрою або його локальна ідентифікація недійсні.',
      'invalid_location': 'Оновіть список розташувань і спробуйте ще раз.',
      'device_limit': 'Видаліть наявний пристрій, перш ніж додавати інший.',
      'device_exists':
          'Цю ідентифікацію VPN уже пов’язано з іншим обліковим записом.',
      'device_identity_revoked':
          'Цю ідентифікацію видалено. Потрібно створити нову локальну ідентифікацію.',
      'device_location_locked':
          'Розташування цього пристрою щойно змінилося. Програма продовжить незавершену зміну.',
      'location_migration_pending': 'Зміна розташування вже триває.',
      'location_migration_blocked':
          'Для зміни розташування потрібне втручання сервера. Спробуйте пізніше або зверніться до служби підтримки.',
      'target_ca_mismatch':
          'Цей сервер ще несумісний із поточним профілем OpenVPN.',
      'location_migration_conflict':
          'Оновіть список пристроїв, а потім знову спробуйте змінити розташування.',
      'server_full':
          'Це розташування досягло ліміту підключень. Виберіть інше розташування або спробуйте пізніше.',
      'capacity_unavailable':
          'Ми не можемо підтвердити, чи доступне це розташування зараз. Виберіть інше розташування або спробуйте пізніше.',
      'target_unavailable': 'Цей сервер тимчасово недоступний.',
      'not_found': 'Цей елемент більше недоступний у вашому обліковому записі.',
      'invalid_openvpn_csr':
          'Створіть нову ідентифікацію OpenVPN і спробуйте ще раз.',
      'openvpn_profile_exists': 'Для цього пристрою вже існує профіль OpenVPN.',
      'openvpn_profile_revoked': 'Оновіть профіль OpenVPN, щоб продовжити.',
      'openvpn_operation_pending': 'Зміна ще поширюється. Спробуйте пізніше.',
      'openvpn_operation_terminal':
          'Створіть нову ідентифікацію OpenVPN і спробуйте ще раз.',
      'openvpn_address_unavailable': 'Наразі немає доступної адреси OpenVPN.',
      'openvpn_profile_conflict':
          'Профіль змінився. Оновіть список пристроїв і спробуйте ще раз.',
      'openvpn_signer_unavailable': 'Служба OpenVPN тимчасово недоступна.',
      'email_delivery_unavailable':
          'Не вдалося надіслати лист. Спробуйте пізніше.',
      'invalid_token':
          'Це посилання недійсне або термін його дії минув. Запросіть нове.',
      'network_unavailable':
          'Перевірте підключення до інтернету та спробуйте ще раз.',
      'invalid_json': 'Перевірте введену інформацію та спробуйте ще раз.',
      'invalid_api_response':
          'Сервер повернув несподівану відповідь. Спробуйте пізніше.',
      'ipv6_unavailable':
          'Сервер наразі не може активувати IPv6. Спробуйте пізніше.',
      'invalid_ip_families':
          'Конфігурація тунелю неповна або не відповідає дозволеним адресам. Спробуйте ще раз із програми.',
      'other': 'Сталася помилка сервера. Спробуйте пізніше.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Спробуйте ще раз за кілька хвилин.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Спробуйте ще раз через $seconds секунд.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Відновлення системного VPN недоступне',
      'system_vpn_resume_corrupt': 'Недійсне відновлення системного VPN',
      'system_vpn_resume_session_invalid': 'Недійсний сеанс відновлення VPN',
      'system_vpn_resume_identity_changed': 'Ідентифікацію VPN змінено',
      'system_vpn_resume_identity_invalid':
          'Недійсна ідентифікація для відновлення VPN',
      'system_vpn_resume_storage_failed': 'Сховище відновлення VPN недоступне',
      'system_vpn_resume_network_timeout':
          'Під час відновлення VPN мережу не знайдено',
      'system_vpn_resume_blocked': 'Відновлення VPN заблоковано',
      'system_vpn_resume_failed': 'Не вдалося відновити VPN',
      'system_vpn_resume_error_invalid': 'Недійсна помилка відновлення VPN',
      'wireguard_identity_store_failed': 'Ідентифікацію WireGuard не збережено',
      'wireguard_identity_unavailable': 'Ідентифікація WireGuard недоступна',
      'vpn_host_destroyed': 'Хост Android VPN зупинено',
      'vpn_host_unavailable': 'Хост Android VPN недоступний',
      'vpn_permission_required': 'Потрібен дозвіл на VPN',
      'vpn_permission_denied': 'У дозволі на VPN відмовлено',
      'vpn_permission_request_failed': 'Не вдалося запросити дозвіл',
      'wireguard_foreground_service_unavailable': 'Служба WireGuard недоступна',
      'wireguard_identity_invalid': 'Недійсний локальний ключ WireGuard',
      'wireguard_identity_in_use':
          'Ідентифікація WireGuard уже використовується',
      'wireguard_configuration_invalid': 'Недійсна конфігурація WireGuard',
      'wireguard_operation_pending': 'Операція WireGuard усе ще активна',
      'wireguard_start_failed': 'Запуск WireGuard відхилено',
      'wireguard_stop_timeout': 'Зупинення WireGuard не підтверджено',
      'wireguard_handshake_timeout': 'WireGuard не відповів',
      'openvpn_connection_timeout': 'OpenVPN не відповів',
      'openvpn_core_unavailable': 'Механізм OpenVPN недоступний',
      'openvpn_operation_pending': 'Сеанс OpenVPN усе ще активний',
      'openvpn_stop_timeout': 'Зупинення OpenVPN не підтверджено',
      'openvpn_profile_unavailable': 'Локальний профіль OpenVPN відсутній',
      'openvpn_native_failed': 'Виклик OpenVPN перервано',
      'openvpn_key_generation_failed': 'Не вдалося створити ключ OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Не вдалося створити CSR OpenVPN',
      'openvpn_identity_store_failed': 'Ідентифікацію OpenVPN не збережено',
      'openvpn_identity_clear_failed': 'Неповне видалення OpenVPN',
      'openvpn_identity_in_use':
          'Ідентифікація OpenVPN усе ще використовується',
      'openvpn_tls_verification_required': 'Відсутня перевірка TLS OpenVPN',
      'openvpn_cipher_invalid': 'Недійсний шифр OpenVPN',
      'openvpn_profile_rejected': 'Профіль OpenVPN відхилено',
      'openvpn_identity_inconsistent': 'Суперечлива ідентифікація OpenVPN',
      'tls_handshake_failed': 'Узгодження OpenVPN відхилено',
      'tls_alert_unknown_ca': 'Сертифікат клієнта OpenVPN не розпізнано',
      'tls_alert_bad_certificate': 'Сертифікат клієнта OpenVPN відхилено',
      'tls_alert_unsupported_certificate': 'Непідтримуваний сертифікат OpenVPN',
      'tls_client_certificate_required': 'Потрібен сертифікат клієнта OpenVPN',
      'tls_alert_misc': 'Сповіщення TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Непідтримуваний підпис OpenVPN',
      'tls_handshake_rejected': 'Узгодження TLS OpenVPN відхилено',
      'tls_version_rejected': 'Несумісна версія TLS OpenVPN',
      'tls_certificate_expired': 'Термін дії сертифіката TLS минув',
      'tls_certificate_revoked': 'Сертифікат TLS відкликано',
      'transport_failed': 'Сервер OpenVPN недоступний',
      'tun_configuration_rejected': 'Не вдалося створити інтерфейс OpenVPN',
      'tun_setup_failed': 'Не вдалося налаштувати TUN OpenVPN',
      'tun_interface_create_failed': 'Не вдалося створити інтерфейс OpenVPN',
      'tun_interface_disabled': 'Інтерфейс OpenVPN вимкнено',
      'tun_halted': 'Інтерфейс OpenVPN перервано',
      'tun_already_established': 'Інтерфейс OpenVPN уже відкрито',
      'tun_addresses_missing': 'Адреса OpenVPN відсутня',
      'tun_routes_missing': 'Маршрути OpenVPN відсутні',
      'tun_dns_missing': 'DNS OpenVPN відсутній',
      'tun_permission_revoked': 'Дозвіл на VPN відкликано',
      'tun_establish_returned_null': 'Android відхилив інтерфейс VPN',
      'openvpn_service_start_failed': 'Служба OpenVPN недоступна',
      'openvpn_operation_timeout': 'Час очікування виклику OpenVPN минув',
      'openvpn_start_failed': 'Запуск OpenVPN відхилено',
      'openvpn_connection_failed': 'З’єднання OpenVPN перервано',
      'openvpn_core_status_error': 'OpenVPN Core завершився з помилкою',
      'openvpn_stopped_before_connected': 'OpenVPN зупинено до підключення',
      'openvpn_auth_failed': 'Автентифікацію OpenVPN відхилено',
      'openvpn_client_setup_failed': 'Не вдалося налаштувати клієнт OpenVPN',
      'openvpn_client_halted': 'Клієнт OpenVPN перервано',
      'openvpn_client_restart': 'Запитано перезапуск OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN надто довго був неактивним',
      'openvpn_session_expired': 'Термін дії сеансу OpenVPN минув',
      'openvpn_credentials_required': 'Непідтримувана автентифікація OpenVPN',
      'openvpn_proxy_failed':
          'Не вдалося виконати проміжне передавання OpenVPN',
      'openvpn_compression_failed': 'Стиснення OpenVPN відхилено',
      'openvpn_ntlm_crypto_unavailable': 'Шифрування NTLM OpenVPN недоступне',
      'openvpn_feature_unsupported': 'Непідтримувана функція OpenVPN',
      'network_unavailable': 'Підключення до інтернету недоступне',
      'network_lost': 'Мережа недоступна',
      'certificate_validation_failed': 'Сертифікат сервера відхилено',
      'openvpn_certificate_expired': 'Термін дії сертифіката OpenVPN минув',
      'tunnel_active_for_another_account':
          'Тунель іншого облікового запису все ще активний',
      'tunnel_already_active': 'Власний тунель уже активний',
      'tunnel_stop_timeout': 'Зупинення $protocol не підтверджено',
      'tunnel_disconnected': '$protocol перервано',
      'native_bridge_unavailable': 'Міст Android недоступний',
      'native_operation_failed': 'Операцію Android перервано',
      'invalid_arguments': 'Неповні параметри VPN',
      'invalid_account_id': 'Недійсний обліковий запис VPN',
      'invalid_device_id': 'Недійсний ідентифікатор пристрою',
      'storage_key_not_allowed': 'Ключ сховища відхилено',
      'secure_storage_read_failed': 'Не вдалося безпечно прочитати дані',
      'secure_storage_write_failed': 'Не вдалося безпечно записати дані',
      'key_generation_failed': 'Не вдалося створити ключ WireGuard',
      'csr_generation_failed': 'Не вдалося створити CSR OpenVPN',
      'other': 'Некласифікована власна помилка VPN',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android не може знайти сеанс VPN, який можна відновити. Почніть нове підключення у програмі.',
      'system_vpn_resume_corrupt':
          'Збережені дані відновлення VPN недійсні й не використовуватимуться. Почніть нове підключення.',
      'system_vpn_resume_session_invalid':
          'Збережений сеанс більше не може відновити VPN. Увійдіть знову в програмі.',
      'system_vpn_resume_identity_changed':
          'Локальну ідентифікацію VPN змінено. Відновлення зупинено; почніть нове підключення.',
      'system_vpn_resume_identity_invalid':
          'Ідентифікація для відновлення недійсна. Почніть нове підключення.',
      'system_vpn_resume_storage_failed':
          'Android не зміг прочитати або оновити зашифровані дані відновлення. Почніть нове підключення.',
      'system_vpn_resume_network_timeout':
          'Android вчасно не знайшов мережу для відновлення VPN. Спробуйте ще раз, коли мережа буде доступна.',
      'system_vpn_resume_blocked':
          'Відновлення VPN заблоковано. Перевірте налаштування Android, а потім почніть нове підключення.',
      'system_vpn_resume_failed':
          'Не вдалося відновити Android VPN. Почніть нове підключення у програмі.',
      'system_vpn_resume_error_invalid':
          'Android повернув непридатну помилку відновлення. Почніть нове підключення.',
      'wireguard_identity_store_failed':
          'Android не зміг зберегти зашифровану ідентифікацію WireGuard цього облікового запису.',
      'wireguard_identity_unavailable':
          'Для цього підключення немає доступної придатної ідентифікації WireGuard.',
      'vpn_host_destroyed':
          'Компонент Android, на якому працював VPN, зупинено. Почніть нове підключення.',
      'vpn_host_unavailable':
          'Android не може створити компонент, на якому працює VPN. Спробуйте ще раз після перевірки налаштувань VPN.',
      'openvpn_renewal_required':
          'Перед підключенням сертифікат потребує дії в програмі.',
      'openvpn_recovery_failed':
          'Автоматичне відновлення не вдалося. Почніть нове підключення у програмі.',
      'openvpn_recovery_exhausted':
          'Автоматичне відновлення вже використано. Почніть нове підключення у програмі.',
      'vpn_permission_required':
          'Android потребує нової авторизації VPN перед запуском тунелю.',
      'vpn_permission_denied':
          'Дозвольте FuzeVPN у запиті Android, щоб продовжити.',
      'vpn_permission_request_failed':
          'Android не зміг відкрити екран дозволу VPN.',
      'wireguard_foreground_service_unavailable':
          'Android не зміг залишити службу WireGuard на передньому плані.',
      'wireguard_identity_invalid':
          'Зашифрований ключ WireGuard цього облікового запису неможливо прочитати або він недійсний.',
      'wireguard_identity_in_use':
          'Інша операція все ще використовує ключ WireGuard цього облікового запису.',
      'wireguard_configuration_invalid':
          'Отримана адреса WireGuard, DNS, ключ сервера або маршрути недійсні.',
      'wireguard_operation_pending':
          'Попередня операція WireGuard ще не звільнила власну службу.',
      'wireguard_start_failed':
          'Механізм WireGuard відхилив активацію конфігурації.',
      'wireguard_stop_timeout':
          'Служба WireGuard не підтвердила звільнення інтерфейсу VPN у встановлений час.',
      'wireguard_handshake_timeout':
          'Тунель вчасно не підтвердив рукостискання із сервером.',
      'openvpn_connection_timeout':
          'OpenVPN вчасно не підтвердив підключення до сервера.',
      'openvpn_core_unavailable':
          'Ця версія програми не містить придатного механізму OpenVPN.',
      'openvpn_operation_pending':
          'Власний механізм усе ще утримує попередній сеанс OpenVPN і відмовляється створювати другий.',
      'openvpn_stop_timeout':
          'OpenVPN Core не підтвердив, що його власний сеанс зупинено й знищено у встановлений час.',
      'openvpn_profile_unavailable':
          'Для цього підключення неможливо прочитати жодного перевіреного профілю OpenVPN.',
      'openvpn_native_failed':
          'Помилка програми перервала роботу OpenVPN. Спробуйте підключитися знову. Якщо проблема не зникне, запустіть діагностику.',
      'openvpn_key_generation_failed':
          'Android Keystore не зміг створити або прочитати приватний ключ P-256, який не можна експортувати.',
      'openvpn_csr_generation_failed':
          'Ключ Android Keystore не зміг підписати запит на сертифікат OpenVPN.',
      'openvpn_identity_store_failed':
          'Не вдалося зберегти сертифікат або профіль OpenVPN у зашифрованому сховищі.',
      'openvpn_identity_clear_failed':
          'Android не зміг видалити всю локальну ідентифікацію OpenVPN цього облікового запису.',
      'openvpn_identity_in_use':
          'Власний сеанс OpenVPN усе ще використовує ключ або сертифікат цього пристрою.',
      'openvpn_tls_verification_required':
          'Профіль явно не вимагає перевірки сертифіката сервера.',
      'openvpn_cipher_invalid':
          'Сервер надав алгоритм шифрування, якого немає в дозволеному списку.',
      'openvpn_profile_rejected':
          'Профіль, отриманий від сервера, несумісний. Створіть цей пристрій знову й спробуйте ще раз.',
      'openvpn_identity_inconsistent':
          'Сертифікат не відповідає захищеній ідентифікації цього телефона. Локальний профіль не замінено.',
      'tls_handshake_failed':
          'Сервер відхилив узгодження TLS. Якщо проблема не зникне, створіть профіль знову.',
      'tls_alert_unknown_ca':
          'Сервер не визнає повноваження центру сертифікації цього сертифіката пристрою. Потрібно перевірити сервер OpenVPN.',
      'tls_alert_bad_certificate':
          'Сервер відхилив цей сертифікат пристрою. Створіть пристрій знову перед новою спробою.',
      'tls_alert_unsupported_certificate':
          'Сервер не підтримує тип захищеного сертифіката, який використовує Android.',
      'tls_client_certificate_required':
          'Сервер потребує сертифікат клієнта, але OpenVPN Core не зміг його надати.',
      'tls_alert_misc':
          'Сервер повернув сповіщення TLS поза категоріями сертифіката та версії.',
      'tls_signature_algorithm_rejected':
          'Сервер відхилив алгоритм ECDSA P-256 ключа Android Keystore.',
      'tls_handshake_rejected':
          'Сервер перервав узгодження TLS до підключення.',
      'tls_version_rejected': 'Клієнт і сервер не знайшли спільної версії TLS.',
      'tls_certificate_expired':
          'Термін дії сертифіката, наданого під час підключення, минув.',
      'tls_certificate_revoked':
          'Сертифікат, наданий під час підключення, відкликано.',
      'transport_failed':
          'Сервер OpenVPN не відповідає в поточній мережі. Спробуйте ще раз невдовзі.',
      'tun_configuration_rejected':
          'Android відхилив мережеву конфігурацію, яку запросив OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core відхилив план мережі до створення інтерфейсу Android.',
      'tun_interface_create_failed':
          'OpenVPN Core не зміг отримати інтерфейс TUN від Android VpnService.',
      'tun_interface_disabled':
          'Android або OpenVPN Core вимкнув інтерфейс TUN під час підключення.',
      'tun_halted': 'OpenVPN Core отримав запит на зупинення інтерфейсу TUN.',
      'tun_already_established':
          'OpenVPN запросив другий інтерфейс у тому самому підключенні. Для безпеки тунель зупинено.',
      'tun_addresses_missing': 'Сервер не надав придатної адреси тунелю.',
      'tun_routes_missing': 'Сервер не надав придатних маршрутів тунелю.',
      'tun_dns_missing': 'Сервер не надав придатного DNS-сервера.',
      'tun_permission_revoked':
          'Android відкликав дозвіл на VPN під час підключення.',
      'tun_establish_returned_null':
          'Android не створив інтерфейс, зазвичай через те, що інший VPN усе ще активний.',
      'openvpn_service_start_failed':
          'Android не зміг запустити фонову службу OpenVPN.',
      'openvpn_operation_timeout':
          'Виклик JNI до OpenVPN Core перевищив максимальну тривалість.',
      'openvpn_start_failed':
          'Служба Android готова, але OpenVPN Core не прийняв запуск профілю.',
      'openvpn_connection_failed':
          'OpenVPN Core зупинився до надсилання події CONNECTED.',
      'openvpn_core_status_error':
          'Власний цикл OpenVPN завершився з помилкою без конкретнішої кінцевої події.',
      'openvpn_stopped_before_connected':
          'Власний цикл OpenVPN зупинився до CONNECTED без явної помилки Core.',
      'openvpn_auth_failed': 'Сервер OpenVPN відхилив автентифікацію профілю.',
      'openvpn_client_setup_failed':
          'OpenVPN Core не зміг ініціалізувати клієнт до підключення до мережі.',
      'openvpn_client_halted':
          'OpenVPN Core отримав кінцевий запит на зупинення клієнта.',
      'openvpn_client_restart':
          'OpenVPN Core запросив перезапуск транспортного сеансу.',
      'openvpn_inactive_timeout':
          'OpenVPN Core закрив сеанс після завершення часу очікування неактивності.',
      'openvpn_session_expired':
          'Сервер повідомив, що термін дії сеансу OpenVPN минув.',
      'openvpn_credentials_required':
          'Сервер або проксі запитує інтерактивні облікові дані, яких немає в цьому профілі сертифіката.',
      'openvpn_proxy_failed':
          'OpenVPN Core повідомив про помилку налаштованого проксі або ретранслятора.',
      'openvpn_compression_failed':
          'OpenVPN Core відхилив режим стиснення, оголошений профілем або сервером.',
      'openvpn_ntlm_crypto_unavailable':
          'Профіль запитує шифрування NTLM, недоступне в цій версії.',
      'openvpn_feature_unsupported':
          'Профіль або сервер потребує функції, якої немає в цьому клієнті Android.',
      'network_unavailable': 'Немає доступної придатної фізичної мережі.',
      'network_lost': 'Тунель зупинено після втрати мережі.',
      'certificate_validation_failed':
          'Не вдалося перевірити ідентифікацію сервера OpenVPN.',
      'openvpn_certificate_expired':
          'Оновіть профіль OpenVPN перед повторним підключенням.',
      'tunnel_active_for_another_account':
          'Перед цим підключенням потрібно зупинити тунель іншого облікового запису.',
      'tunnel_already_active':
          'Android повідомляє, що попередній сеанс VPN усе ще використовує інтерфейс.',
      'tunnel_stop_timeout':
          'Механізм $protocol не підтвердив звільнення інтерфейсу VPN у встановлений час.',
      'tunnel_disconnected':
          'Власний механізм повідомив, що тунель несподівано завершився після запуску.',
      'native_bridge_unavailable':
          'Програма не може отримати доступ до служби Android VPN. Закрийте й знову відкрийте програму, а потім спробуйте ще раз.',
      'native_operation_failed':
          'Помилка програми перервала операцію VPN. Спробуйте ще раз. Якщо проблема не зникне, запустіть діагностику.',
      'invalid_arguments':
          'Інформація, потрібна для цієї операції VPN, неповна. Спробуйте ще раз. Якщо проблема не зникне, запустіть діагностику.',
      'invalid_account_id':
          'Власну операцію не пов’язано з дійсним ідентифікатором облікового запису.',
      'invalid_device_id':
          'Ідентифікатор пристрою, надісланий власному механізму, відсутній або недійсний.',
      'storage_key_not_allowed':
          'Міст Android заблокував ключ поза дозволеним списком сховища.',
      'secure_storage_read_failed':
          'Android Keystore не зміг розшифрувати локальні дані цього облікового запису.',
      'secure_storage_write_failed':
          'Android Keystore не зміг зашифрувати або зберегти локальні дані.',
      'key_generation_failed':
          'Android не зміг створити або прочитати ключ WireGuard у захищеному сховищі.',
      'csr_generation_failed':
          'Android Keystore не зміг створити або підписати CSR OpenVPN P-256.',
      'other':
          'Не задокументована власна гілка завершилася помилкою. Надішліть показаний нижче код діагностики до служби підтримки.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Запит на дозвіл уже відкрито';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Запит Android на дозвіл VPN уже відображається. Завершіть його перед новою спробою.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Запит на дозвіл VPN перервано';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Екран запиту дозволу VPN закрився до того, як програма отримала відповідь.';

  @override
  String get notice_openvpnProofMissing_title =>
      'З’єднання OpenVPN не підтверджено';

  @override
  String get notice_openvpnProofMissing_message =>
      'Не вдалося підтвердити з’єднання OpenVPN. Для безпеки його зупинено. Спробуйте ще раз.';

  @override
  String get openvpnCleanup_title => 'Профіль OpenVPN відкликано';

  @override
  String get openvpnCleanup_working =>
      'Зупинення та видалення відкликаного профілю OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Завершення роботи OpenVPN не підтверджено. Повторіть спробу перед створенням нового профілю.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Не вдалося повністю видалити відкликаний профіль OpenVPN. Повторіть очищення.';

  @override
  String get openvpnCleanup_complete =>
      'Відкликаний профіль OpenVPN видалено. Натисніть «Підключити», щоб створити новий.';

  @override
  String get network_title => 'Конфігурація мережі';

  @override
  String get network_ipv4Fallback =>
      'IPv6 тимчасово недоступний. Підготовка триває з IPv4.';

  @override
  String get network_rejectedTitle => 'Конфігурацію мережі відхилено';

  @override
  String get network_rejectedMessage =>
      'Конфігурація тунелю неповна або не відповідає дозволеним адресам. Спробуйте ще раз із програми.';

  @override
  String get network_unreadableTitle =>
      'Локальну конфігурацію неможливо прочитати';

  @override
  String get network_unreadableMessage =>
      'Збережену мережеву конфігурацію OpenVPN неможливо використати. Повторно підключіться із програми, щоб оновити її.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Захист мережі';

  @override
  String get protection_subtitle =>
      'Блокуйте прямий доступ до інтернету, якщо VPN відключиться.';

  @override
  String get protection_active => 'Системний захист активний';

  @override
  String get protection_alwaysOnOnly =>
      'VPN у режимі постійного підключення увімкнено; увімкніть блокування поза VPN';

  @override
  String get protection_inactive => 'Системний захист неактивний';

  @override
  String get protection_unknown => 'Перевірити системний захист';

  @override
  String get protection_openSettings => 'Відкрити налаштування Android';

  @override
  String get protection_dialogTitle => 'Налаштувати захист мережі';

  @override
  String get protection_dialogMessage =>
      'Android керує VPN у режимі постійного підключення та блокуванням з’єднань поза VPN. Переконайтеся, що вибрано FuzeVPN, і ввімкніть блокування в системних налаштуваннях.';

  @override
  String get protection_dialogOpen => 'Відкрити налаштування';

  @override
  String get session_systemProtectionNote =>
      'Якщо Android і далі блокує трафік поза VPN, відкрийте системні налаштування, щоб перевірити або змінити цей захист.';

  @override
  String get diagnostics_title => 'Діагностика';

  @override
  String get diagnostics_settingsTitle => 'Діагностика програми';

  @override
  String get diagnostics_automaticTitle => 'Надсилати важливі помилки';

  @override
  String get diagnostics_automaticDescription =>
      'Надсилати невеликий технічний звіт, коли виникає важлива помилка.';

  @override
  String get diagnostics_privacy =>
      'Надіслані звіти пов’язані з обліковим записом, у який ви ввійшли, і зберігаються 30 днів. Вони не містять історії перегляду, паролів або ключів VPN.';

  @override
  String get diagnostics_manualOpen => 'Запустити діагностику';

  @override
  String get diagnostics_localDescription =>
      'Створити звіт про стан програми та VPN. Ваше з’єднання не зміниться.';

  @override
  String get diagnostics_sendReport => 'Надіслати звіт';

  @override
  String get diagnostics_sendHint =>
      'Залиште цей прапорець знятим, щоб зберегти звіт на цьому пристрої.';

  @override
  String get diagnostics_signedOut =>
      'Увійдіть у свій обліковий запис, щоб надіслати звіт.';

  @override
  String get diagnostics_localLifetime =>
      'Збережіть цей звіт на телефоні, щоб він залишився після закриття програми.';

  @override
  String get diagnostics_run => 'Запустити діагностику';

  @override
  String get diagnostics_rerun => 'Запустити діагностику знову';

  @override
  String get diagnostics_running => 'Перевірка…';

  @override
  String get diagnostics_sending => 'Надсилання звіту…';

  @override
  String get diagnostics_prepared => 'Звіт готовий на цьому пристрої';

  @override
  String get diagnostics_queued => 'Звіт очікує надсилання';

  @override
  String get diagnostics_sent => 'Звіт отримано';

  @override
  String get diagnostics_failed =>
      'Не вдалося надіслати. Ваш локальний звіт досі доступний.';

  @override
  String get diagnostics_preparationFailed =>
      'Не вдалося підготувати діагностичний звіт. Спробуйте ще раз.';

  @override
  String get diagnostics_authenticationRequired =>
      'Увійдіть знову, щоб надіслати звіт.';

  @override
  String get diagnostics_retry => 'Повторити надсилання';

  @override
  String get diagnostics_export => 'Зберегти звіт';

  @override
  String get diagnostics_exportFailed =>
      'Не вдалося експортувати. Спробуйте ще раз із локального звіту.';

  @override
  String get diagnostics_preferenceFailed =>
      'Не вдалося зберегти це налаштування. Спробуйте ще раз.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Ідентифікатор: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Отримано $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Зберігається до $date';
  }

  @override
  String get diagnostics_duplicate => 'Цей звіт уже було отримано.';

  @override
  String get diagnostics_preview => 'Попередній перегляд звіту';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count технічних подій додано',
      many: '$count технічних подій додано',
      few: '$count технічні події додані',
      one: '$count технічна подія додана',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Технічні відомості';

  @override
  String get diagnostics_empty => 'Діагностичний звіт ще не підготовлено.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Стан тунелю',
      'handshake': 'Підтвердження з’єднання',
      'certificate': 'Сертифікат VPN',
      'kill_switch': 'Захист Android',
      'connectivity': 'Доступна мережа',
      'api_reachability': 'Доступ до служби',
      'secure_storage': 'Захищене сховище',
      'other': 'Локальна перевірка',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Перевірено',
      'failed': 'Потребує уваги',
      'skipped': 'Не перевірено — активної перевірки немає',
      'unknown': 'Інформація недоступна',
      'other': 'Інформація недоступна',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Вітаємо у FuzeVPN';

  @override
  String get connection_changeLocation => 'Змінити розташування';

  @override
  String get connection_details => 'Відомості про з’єднання';

  @override
  String get locations_searchLabel => 'Пошук міста або країни';

  @override
  String get locations_clearSearch => 'Очистити пошук';

  @override
  String get locations_filterAll => 'Усі';

  @override
  String get locations_filterFavorites => 'Вибране';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count розташування',
      many: '$count розташувань',
      few: '$count розташування',
      one: '$count розташування',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Розташувань не знайдено';

  @override
  String get locations_noResultsHint => 'Спробуйте інше місто або країну.';

  @override
  String get locations_noFavorites => 'Ваше вибране завжди під рукою';

  @override
  String get locations_noFavoritesHint =>
      'Натисніть зірочку поруч із розташуванням, щоб зберегти його тут.';

  @override
  String get locations_showAll => 'Переглянути всі розташування';

  @override
  String locations_addFavorite(String name) {
    return 'Додати $name до вибраного';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Видалити $name з вибраного';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Не вдалося зберегти вибране. Спробуйте ще раз.';

  @override
  String get locations_emptyTitle => 'Немає доступних розташувань';

  @override
  String get locations_emptyHint => 'Оновіть список і спробуйте ще раз.';

  @override
  String get devices_manage => 'Керувати моїми пристроями';

  @override
  String get settings_personalization => 'Зробіть усе по-своєму';

  @override
  String get settings_safety => 'Захист';

  @override
  String get settings_help => 'Потрібна допомога?';

  @override
  String get settings_about => 'Про FuzeVPN';

  @override
  String get diagnostics_heading => 'Зрозуміти проблему зі з’єднанням';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Доступний',
      'pending': 'Підготовка',
      'revoked': 'Видалено',
      'expired': 'Термін дії минув',
      'other': 'Статус недоступний',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Налаштування не збережено';

  @override
  String get notice_preferenceSave_message =>
      'Ваш вибір наразі застосовано, але його не вдалося зберегти. Спробуйте ще раз, щоб він зберігся після закриття програми.';

  @override
  String get connection_androidDisconnectHint =>
      'Якщо Android не вимикає VPN, вимкніть VPN у режимі постійного підключення у відкритих налаштуваннях.';

  @override
  String get protection_learnMore => 'Дізнатися більше про захист Android';

  @override
  String get protection_guideWhy =>
      'Цей захист не дає програмам напряму використовувати інтернет, якщо VPN відключиться. Його налаштовано в Android.';

  @override
  String get protection_guideAlwaysOnTitle =>
      'VPN у режимі постійного підключення';

  @override
  String get protection_guideAlwaysOn =>
      'Android підтримує роботу служби VPN і може перезапустити її після перезавантаження телефона.';

  @override
  String get protection_guideBlockTitle => 'Блокувати з’єднання без VPN';

  @override
  String get protection_guideBlock =>
      'Це налаштування не дає трафіку обходити VPN, зокрема під час переривання з’єднання.';

  @override
  String get protection_guideWarning =>
      'Якщо блокування ввімкнено, доступ до інтернету залишатиметься вимкненим, доки VPN не підключиться.';

  @override
  String get protection_guideStepsTitle => 'Увімкнути захист';

  @override
  String get protection_guideStep1 =>
      'Відкрийте налаштування VPN Android за допомогою кнопки нижче.';

  @override
  String get protection_guideStep2 =>
      'Відкрийте параметри за допомогою значка шестерні поруч із FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Увімкніть VPN у режимі постійного підключення, а потім «Блокувати з’єднання без VPN», якщо ці параметри доступні.';

  @override
  String get protection_guideManufacturers =>
      'Назви залежать від телефона. За потреби знайдіть VPN у налаштуваннях, зазвичай у розділі «Мережа й інтернет».';

  @override
  String get protection_guideDisableTitle => 'Вимкнути цей захист';

  @override
  String get protection_guideDisable =>
      'У тих самих налаштуваннях вимкніть блокування без VPN, щоб дозволити доступ до інтернету без VPN. Також вимкніть VPN у режимі постійного підключення, якщо більше не хочете, щоб Android перезапускав його.';

  @override
  String get protection_guideManual =>
      'Ви самі вибираєте ці налаштування в Android. FuzeVPN не змінює їх за вас.';

  @override
  String get locations_changeTitle => 'Змінити розташування?';

  @override
  String locations_changeActive(String name) {
    return 'VPN відключиться, а потім спробує підключитися до $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN спробує підключитися до $name.';
  }

  @override
  String get locations_confirmChange => 'Змінити й підключитися';

  @override
  String get locations_changeBusy =>
      'Зміна триває. Зачекайте, перш ніж вибирати інше розташування.';

  @override
  String get locations_automaticSelection => 'Автоматичний вибір';

  @override
  String get locations_cities => 'Міста';

  @override
  String get locations_servers => 'Сервери';

  @override
  String locations_viewCities(String name) {
    return 'Переглянути міста в $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Переглянути сервери в $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count країни',
      many: '$count країн',
      few: '$count країни',
      one: '$count країна',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count міста',
      many: '$count міст',
      few: '$count міста',
      one: '$count місто',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сервери',
      many: '$count серверів',
      few: '$count сервери',
      one: '$count сервер',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Усі країни';

  @override
  String get locations_backToCountries => 'Назад до країн';

  @override
  String locations_backToCities(String name) {
    return 'Назад до міст у $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Вибрати $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Вибрати $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Немає сумісного доступного сервера.';

  @override
  String get externalLink_failed =>
      'Не вдалося відкрити посилання. Ви можете скопіювати його та відкрити в браузері.';

  @override
  String get externalLink_copy => 'Копіювати посилання';

  @override
  String get externalLink_copied => 'Посилання скопійовано';

  @override
  String get externalLink_copyFailed =>
      'Не вдалося скопіювати посилання. Виділіть адресу нижче.';

  @override
  String get settings_deleteAccount => 'Видалити мій обліковий запис';

  @override
  String get settings_deleteAccountDetail =>
      'Переглянути порядок запиту на видалення облікового запису';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Виберіть підписку VPN.';

  @override
  String get billing_subscribe => 'Підписатися';

  @override
  String get billing_choosePlan => 'Виберіть план, щоб продовжити.';

  @override
  String get billing_monthly => 'Щомісячний';

  @override
  String get billing_yearly => 'Щорічний';

  @override
  String get billing_continue => 'Продовжити через Google Play';

  @override
  String get billing_restore => 'Відновити покупки';

  @override
  String get billing_manage => 'Керувати підпискою';

  @override
  String get billing_deleteAccountWarning =>
      'Якщо у вас є підписка Google Play, видалення облікового запису FuzeVPN не скасовує її поновлення. Керуйте поновленням або скасуйте його окремо в Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Перейти до запиту на видалення облікового запису';

  @override
  String get billing_refresh => 'Оновити доступ';

  @override
  String get billing_loadingPlans => 'Завантаження планів…';

  @override
  String get billing_unavailable =>
      'Зараз немає доступних планів. Спробуйте пізніше.';

  @override
  String get billing_comingSoon => 'Підписки незабаром з’являться.';

  @override
  String get billing_priceDisclosure =>
      'Ціну надано Google Play. Кінцева сума та застосовні податки підтверджуються перед вашим підтвердженням.';

  @override
  String get billing_renewalMonthly =>
      'Автоматичне поновлення щомісяця, якщо не скасовано. Ви можете скасувати будь-коли в підписках Google Play.';

  @override
  String get billing_renewalYearly =>
      'Автоматичне поновлення щороку, якщо не скасовано. Ви можете скасувати будь-коли в підписках Google Play.';

  @override
  String get billing_active => 'Ваш доступ Premium активний';

  @override
  String billing_accessUntil(String date) {
    return 'Доступ до $date.';
  }

  @override
  String get billing_webManaged =>
      'Вашою підпискою можна керувати на сайті FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Вашою підпискою можна керувати через Google Play.';

  @override
  String get billing_inactive => 'Немає активної підписки.';

  @override
  String get billing_checkingAccess => 'Перевірка доступу…';

  @override
  String get billing_restoring => 'Відновлення покупок…';

  @override
  String get billing_pending =>
      'Оплата очікується. Доступ активується після підтвердження.';

  @override
  String get billing_cancelled =>
      'Покупку скасовано. Нову підписку не активовано.';

  @override
  String get billing_verifying => 'Перевірка покупки…';

  @override
  String get billing_success =>
      'Підписку активовано. Ваш доступ Premium готовий.';

  @override
  String get billing_restored => 'Ваші покупки відновлено.';

  @override
  String get billing_restoreEmpty =>
      'Для цього облікового запису Google Play немає покупок для відновлення.';

  @override
  String get billing_catalogError =>
      'Не вдалося завантажити плани. Спробуйте ще раз.';

  @override
  String get billing_purchaseError =>
      'Не вдалося почати покупку. Спробуйте ще раз.';

  @override
  String get billing_verificationError =>
      'Перевірка покупки тимчасово недоступна. Відновіть покупки, щоб спробувати ще раз.';

  @override
  String get billing_restoreError =>
      'Не вдалося відновити покупки. Спробуйте ще раз.';

  @override
  String get billing_managementError =>
      'Не вдалося відкрити керування підписками. Спробуйте ще раз.';

  @override
  String get billing_storeUnavailable =>
      'Google Play недоступний на цьому пристрої.';

  @override
  String get welcome_title => 'Ваш VPN — це просто.';

  @override
  String get welcome_description =>
      'Захистіть з’єднання. Контролюйте свою приватність.';

  @override
  String get welcome_start => 'Почати';

  @override
  String get welcome_alreadyPurchased => 'Уже придбали?';

  @override
  String get welcome_noAccountRequired =>
      'Для початку не потрібно створювати обліковий запис.';

  @override
  String get guest_accountTitle => 'Обліковий запис не прив’язано';

  @override
  String get guest_accountDescription =>
      'Відновіть покупки через той самий обліковий запис Google Play, щоб користуватися підпискою на іншому пристрої.';

  @override
  String get guest_existingSubscriberSignIn => 'Уже маєте підписку? Увійти';

  @override
  String get guest_claimTitle => 'FuzeVPN завжди з вами';

  @override
  String get guest_claimDescription =>
      'Створіть обліковий запис, щоб користуватися підпискою на інших пристроях. Цей крок необов’язковий.';

  @override
  String get guest_skip => 'Пізніше';

  @override
  String get guest_activationTitle => 'Fuze Premium активовано';

  @override
  String get guest_activationDescription =>
      'Ваша підписка готова. Користуйтеся VPN і створіть обліковий запис, коли захочете.';

  @override
  String get guest_useVpn => 'Використовувати VPN';

  @override
  String get guest_loginRequired =>
      'Цю покупку вже прив’язано до облікового запису FuzeVPN. Увійдіть до нього, щоб користуватися підпискою.';

  @override
  String get guest_signOutWarning =>
      'Ви можете відновити підписку, відновивши покупки через той самий обліковий запис Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Ваш обліковий запис уже прив’язано. Увійдіть, щоб переглядати свої дані й керувати ними.';

  @override
  String get billing_acceptance =>
      'Продовжуючи, ви приймаєте Умови використання та Політику конфіденційності.';

  @override
  String get guest_verifyEmailReminder =>
      'Підтвердьте адресу електронної пошти, щоб захистити обліковий запис. Ви можете й далі користуватися VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Сервіс тимчасово недоступний. Спробуйте ще раз трохи пізніше.';

  @override
  String get guest_restoreError =>
      'Не вдалося відновити покупки. Спробуйте ще раз з обліковим записом Google Play, використаним для покупки.';

  @override
  String get guest_claimSuccess =>
      'Ваш обліковий запис створено. Підписку та доступ до VPN збережено.';

  @override
  String get guest_emailExists =>
      'Ця електронна адреса вже використовується. Виберіть іншу адресу або увійдіть до наявного облікового запису. Покупка залишається доступною через Google Play.';

  @override
  String get guest_claimError =>
      'Не вдалося створити обліковий запис. Ви можете й далі користуватися VPN та спробувати ще раз пізніше.';

  @override
  String get guest_secureStorageError =>
      'Не вдалося безпечно зберегти сеанс на цьому пристрої. Спробуйте ще раз.';

  @override
  String get guest_premiumRequired => 'Виберіть підписку, щоб активувати VPN.';

  @override
  String get welcome_viewPlans => 'Переглянути тарифи';

  @override
  String get google_continue => 'Продовжити з Google';

  @override
  String get google_or => 'або';

  @override
  String get google_title => 'Ваш обліковий запис FuzeVPN';

  @override
  String get google_settingUp => 'Завершіть створення облікового запису';

  @override
  String get google_country => 'Країна проживання';

  @override
  String get google_profileDescription =>
      'Виберіть країну та ознайомтеся з двома документами, щоб створити обліковий запис FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Пов’яжіть гостьовий обліковий запис із Google. Підписка та пристрій залишаться пов’язаними з цим записом.';

  @override
  String get google_linkTitle => 'Пов’язати Google з FuzeVPN';

  @override
  String get google_linkDescription =>
      'Підтвердьте доступ до наявного облікового запису FuzeVPN. Пароль Google не потрібен.';

  @override
  String get google_password => 'Пароль FuzeVPN';

  @override
  String get google_linkAccount => 'Підтвердити зв’язування';

  @override
  String get google_requestEmail => 'Отримати лист підтвердження';

  @override
  String get google_emailInstructions =>
      'Відкрийте лист від FuzeVPN і введіть код підтвердження.';

  @override
  String get google_emailCode => 'Код підтвердження з листа';

  @override
  String get google_confirmEmail => 'Підтвердити код';

  @override
  String get google_restart => 'Вибрати інший обліковий запис Google';

  @override
  String get google_resume => 'Перевірити цю спробу';

  @override
  String get google_unavailable =>
      'Вхід через Google недоступний. Можна використати пошту й пароль.';

  @override
  String get google_expired =>
      'Термін цієї спроби минув. Скасуйте її та почніть знову.';

  @override
  String get google_conflict =>
      'Цей обліковий запис Google уже пов’язаний з іншим записом. Поточний обліковий запис і підписку збережено.';

  @override
  String get google_error =>
      'Вхід через Google не вдався. Спробуйте знову; поточний доступ збережено.';

  @override
  String get google_uncertain =>
      'Результат не підтверджено. Перевірте цю спробу або скасуйте її перед повтором.';

  @override
  String get google_cancelFailed =>
      'Скасування не підтверджено. Спробуйте скасувати ще раз перед виходом із цього екрана.';

  @override
  String get google_cancelled => 'Вхід через Google скасовано.';

  @override
  String get google_selecting => 'Виберіть обліковий запис Google…';

  @override
  String get google_verifying => 'Перевіряємо обліковий запис…';

  @override
  String get google_emailUnavailable =>
      'Не вдалося надіслати лист підтвердження. Спробуйте пізніше.';

  @override
  String get google_emailSent =>
      'Лист підтвердження надіслано. Перевірте вхідні.';

  @override
  String get google_rateLimited => 'Зачекайте перед повторною спробою.';

  @override
  String get google_invalidPassword =>
      'Неправильний пароль FuzeVPN. Поточний обліковий запис збережено.';

  @override
  String get google_invalidCode =>
      'Код підтвердження недійсний або прострочений.';

  @override
  String get google_accountChanged =>
      'Сеанс змінився. Скасуйте цю спробу перед повтором.';

  @override
  String get google_invalidResponse =>
      'Не вдалося перевірити відповідь. Поточний доступ збережено.';

  @override
  String get google_invalidRegistration => 'Перевірте країну та обидві згоди.';

  @override
  String get google_consentRequired =>
      'Виберіть країну та прийміть обидва документи, щоб продовжити.';

  @override
  String get google_challengeRequired =>
      'Потрібна додаткова перевірка безпеки. Поточний доступ збережено.';

  @override
  String get google_challengeUnavailable =>
      'Перевірка безпеки недоступна. Спробуйте пізніше.';

  @override
  String get billing_trialTitle => 'Спробуйте Fuze Premium безкоштовно';

  @override
  String get billing_trialSubtitle => 'Захистіть з’єднання вже сьогодні.';

  @override
  String get billing_trialWeeks => '2 тижні безкоштовного пробного періоду';

  @override
  String billing_trialDays(String days) {
    return 'Безкоштовний пробний період: $days днів';
  }

  @override
  String get billing_trialStart => 'Розпочати безкоштовний пробний період';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Якщо розпочати сьогодні, перше списання очікується $date.';
  }

  @override
  String get billing_trialTerms =>
      'Автоматичне поновлення за вказаною ціною. Щоб уникнути списання, скасуйте підписку в Google Play до завершення пробного періоду.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Потім $price на місяць';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Потім $price на рік';
  }

  @override
  String get billing_choosePeriod => 'Виберіть тариф';

  @override
  String get billing_selectionHint => 'Виберіть тариф, щоб продовжити.';

  @override
  String get billing_benefitConnection => 'Зашифроване з’єднання';

  @override
  String get billing_benefitPrivacy => 'Конфіденційність в інтернеті';

  @override
  String get billing_benefitNoAccount => 'Реєстрація необов’язкова';

  @override
  String get billing_cancellation => 'Скасування в Google Play';

  @override
  String get billing_premiumTitle => 'Ваше з’єднання під кращим захистом.';

  @override
  String get billing_premiumSubtitle =>
      'Захистіть з’єднання на зручних умовах.';

  @override
  String get billing_priceMonthly => 'на місяць';

  @override
  String get billing_priceYearly => 'на рік';

  @override
  String get billing_trialToday => 'Сьогодні платити не потрібно';

  @override
  String get billing_trialConfirmation =>
      'Google Play підтвердить дати, кінцеву суму та застосовні податки перед вашим підтвердженням.';

  @override
  String get billing_offerChanged =>
      'Умови цієї пропозиції змінилися. Оновіть тарифи та виберіть знову.';

  @override
  String get status_waitingNetwork => 'Очікування мережі';

  @override
  String get status_waitingNetworkDetail =>
      'Немає доступної мережі. VPN перевірить з’єднання після відновлення мережі.';

  @override
  String get locations_favoriteLoadFailed =>
      'Не вдалося завантажити обране. Спробуйте ще раз.';

  @override
  String get locations_favoritesLoading => 'Завантаження обраного…';
}
