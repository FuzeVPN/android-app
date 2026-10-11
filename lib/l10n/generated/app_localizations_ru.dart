// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Защитите своё подключение';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN использует службу VPN Android (VpnService), чтобы создать зашифрованный туннель между этим устройством и серверами FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Когда VPN активен, интернет-трафик ваших приложений, адреса назначения и DNS-запросы проходят через этот туннель для маршрутизации подключения, даже когда FuzeVPN работает в фоновом режиме.';

  @override
  String get vpnDisclosure_statusBody =>
      'Приложение использует состояние подключения, его длительность и объём переданных данных для отображения вашего VPN-подключения. Вы можете остановить его в любой момент.';

  @override
  String get vpnDisclosure_privacy => 'Конфиденциальность';

  @override
  String get vpnDisclosure_accept => 'Принять и продолжить';

  @override
  String get vpnDisclosure_decline => 'Не сейчас';

  @override
  String get accountRestoration_title => 'Учётная запись временно недоступна';

  @override
  String get accountRestoration_message =>
      'Ваша сессия сохранена. Повторите попытку, чтобы восстановить учётную запись; здесь вы по-прежнему можете управлять VPN-подключением.';

  @override
  String get action_retry => 'Повторить';

  @override
  String get session_endingTitle => 'Завершение сессии';

  @override
  String get session_ending =>
      'Ваша сессия признана недействительной. Остановка VPN и очистка сессии…';

  @override
  String get session_stopFailed =>
      'Остановка VPN не подтверждена. Повторите попытку перед повторным входом.';

  @override
  String get session_cleanupFailed =>
      'VPN остановлен, но удаление сессии не подтверждено. Повторите очистку.';

  @override
  String get session_retryStop => 'Повторить остановку';

  @override
  String get session_retryCleanup => 'Повторить очистку';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Безопасная подготовка FuzeVPN…';

  @override
  String get nav_connection => 'Подключение';

  @override
  String get nav_locations => 'Локации';

  @override
  String get nav_account => 'Учётная запись';

  @override
  String get nav_devices => 'Устройства';

  @override
  String get nav_settings => 'Настройки';

  @override
  String get action_refresh => 'Обновить';

  @override
  String get auth_tab_login => 'Войти';

  @override
  String get auth_tab_register => 'Зарегистрироваться';

  @override
  String get auth_stepAccount => 'Учётная запись';

  @override
  String get auth_stepIdentity => 'Личность';

  @override
  String get auth_stepAddress => 'Адрес и соглашения';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Шаг $current из $total';
  }

  @override
  String get auth_tagline => 'Ваш VPN — это просто.';

  @override
  String get auth_keysLocal =>
      'Ваши закрытые ключи VPN остаются на этом устройстве.';

  @override
  String get form_email => 'Адрес электронной почты';

  @override
  String get form_password => 'Пароль';

  @override
  String get form_showPassword => 'Показать пароль';

  @override
  String get form_hidePassword => 'Скрыть пароль';

  @override
  String get form_passwordMin =>
      '8–72 байта UTF-8. Некоторые символы занимают больше одного байта.';

  @override
  String get form_firstName => 'Имя';

  @override
  String get form_lastName => 'Фамилия';

  @override
  String get form_phone => 'Телефон (+33612345678)';

  @override
  String get form_address => 'Адрес';

  @override
  String get form_address2 => 'Дополнительная строка адреса (необязательно)';

  @override
  String get form_postalCode => 'Почтовый индекс';

  @override
  String get form_city => 'Город';

  @override
  String get form_country => 'Код страны (например, FR)';

  @override
  String get action_login => 'Войти';

  @override
  String get action_createAccount => 'Создать учётную запись';

  @override
  String get action_createMyAccount => 'Создать мою учётную запись';

  @override
  String get action_next => 'Продолжить';

  @override
  String get action_previous => 'Назад';

  @override
  String get action_forgotPassword => 'Забыли пароль?';

  @override
  String get auth_noAccount => 'У вас ещё нет учётной записи?';

  @override
  String get auth_requiredInformation => 'Создайте учётную запись за три шага.';

  @override
  String get auth_termsPrefix => 'Я принимаю ';

  @override
  String get auth_termsLink => 'условия использования';

  @override
  String get auth_privacyPrefix => 'Я принимаю ';

  @override
  String get auth_privacyLink => 'политику конфиденциальности';

  @override
  String get auth_consentRequired =>
      'Для создания учётной записи необходимо ваше согласие.';

  @override
  String get validation_required => 'Это поле обязательно.';

  @override
  String get validation_email =>
      'Введите действительный адрес электронной почты.';

  @override
  String get validation_password =>
      'Пароль слишком короткий: не менее 8 байт UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Пароль слишком длинный: не более 72 байт UTF-8.';

  @override
  String get validation_phone =>
      'Используйте международный формат, например +33612345678.';

  @override
  String get validation_country =>
      'Используйте двухбуквенный код страны, например FR.';

  @override
  String get passwordReset_title => 'Сброс пароля';

  @override
  String get passwordReset_description =>
      'Введите адрес электронной почты своей учётной записи, чтобы запросить ссылку для сброса пароля.';

  @override
  String get passwordReset_send => 'Отправить ссылку';

  @override
  String get connection_title => 'Ваше подключение';

  @override
  String get connection_subtitle => 'Выберите локацию, затем включите VPN.';

  @override
  String get connection_prepare => 'Готовы подключиться?';

  @override
  String get connection_advancedOptions => 'Расширенные параметры';

  @override
  String get connection_location => 'Локация';

  @override
  String get connection_chooseLocation => 'Выберите локацию';

  @override
  String get connection_protocol => 'Протокол';

  @override
  String get connection_connect => 'Подключиться';

  @override
  String get connection_connecting => 'Подключение…';

  @override
  String get connection_disconnect => 'Отключиться';

  @override
  String get connection_disconnecting => 'Отключение';

  @override
  String get connection_locationChange => 'Изменение локации…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol недоступен';
  }

  @override
  String get connection_activeLocation => 'Активная локация';

  @override
  String get connection_duration => 'Длительность';

  @override
  String get connection_received => 'Получено';

  @override
  String get connection_sent => 'Отправлено';

  @override
  String get connection_lastHandshake => 'Последний защищённый обмен';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration назад';
  }

  @override
  String get verification_title => 'Подтвердите адрес электронной почты';

  @override
  String get verification_message =>
      'Подтвердите адрес электронной почты, чтобы использовать VPN на этом телефоне.';

  @override
  String get verification_resend => 'Отправить письмо повторно';

  @override
  String get migration_title => 'Изменение локации';

  @override
  String get migration_draining => 'Подготовка к изменению локации…';

  @override
  String get migration_activating => 'Активация нового сервера…';

  @override
  String get migration_ready => 'Локация обновлена.';

  @override
  String get migration_blocked =>
      'Для изменения локации требуется вмешательство сервера. Повторите попытку позже или обратитесь в службу поддержки.';

  @override
  String get migration_progress => 'Ход изменения локации';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Задержка между проверками: $seconds с.';
  }

  @override
  String get migration_resume => 'Продолжить изменение локации';

  @override
  String get status_authorizing => 'Требуется разрешение';

  @override
  String get status_authorizingDetail =>
      'Примите запрос Android, чтобы разрешить VPN.';

  @override
  String get status_preparing => 'Подготовка';

  @override
  String get status_preparingDetail => 'Подготовка защищённого подключения.';

  @override
  String get status_reconnecting => 'Повторное подключение…';

  @override
  String get status_reconnectingDetail =>
      'Подключение прервано. VPN пытается подключиться снова.';

  @override
  String get status_connecting => 'Подключение';

  @override
  String get status_connectingDetail => 'Подключение к VPN-серверу…';

  @override
  String get status_connected => 'Подключено';

  @override
  String get status_connectedDetail => 'Ваше VPN-подключение активно.';

  @override
  String get status_disconnecting => 'Отключение';

  @override
  String get status_disconnectingDetail => 'Остановка вашего VPN-подключения.';

  @override
  String get status_error => 'Подключение недоступно';

  @override
  String get status_errorDetail =>
      'VPN-подключение не подтверждено. Повторите попытку.';

  @override
  String get status_idle => 'Отключено';

  @override
  String get status_idleDetail =>
      'Подключите VPN, чтобы защитить своё подключение.';

  @override
  String get trust_note =>
      'Закрытие приложения не останавливает VPN. Чтобы остановить его, нажмите «Отключиться».';

  @override
  String get locations_none => 'В настоящее время доступных локаций нет.';

  @override
  String get locations_available => 'Выберите следующую локацию.';

  @override
  String get locations_selected => 'Выбранная локация';

  @override
  String get locations_select => 'Выбрать эту локацию';

  @override
  String get locations_lockedTunnel => 'Отключите VPN, чтобы изменить локацию.';

  @override
  String get locations_lockedMigration =>
      'Дождитесь завершения изменения локации.';

  @override
  String get devices_title => 'Ваши устройства';

  @override
  String devices_used(Object count, Object limit) {
    return 'Устройств: $count / $limit';
  }

  @override
  String get devices_refresh => 'Обновить устройства';

  @override
  String get devices_empty => 'Пока нет зарегистрированных VPN-устройств.';

  @override
  String get devices_firstConnection =>
      'Ваш телефон будет добавлен при первом подключении.';

  @override
  String get devices_thisDevice => 'Это устройство';

  @override
  String devices_added(Object date) {
    return 'Добавлено $date';
  }

  @override
  String get action_remove => 'Удалить';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_subtitle =>
      'Все ваши предпочтения и данные учётной записи в одном месте.';

  @override
  String get settings_appearance => 'Внешний вид';

  @override
  String get settings_language => 'Язык';

  @override
  String get settings_languageDescription =>
      'Выбранный язык также используется в уведомлениях VPN.';

  @override
  String get settings_account => 'Учётная запись';

  @override
  String get settings_signOut => 'Выйти';

  @override
  String get settings_privacy => 'Политика конфиденциальности';

  @override
  String get settings_terms => 'Условия использования';

  @override
  String get settings_security => 'Безопасность и прозрачность';

  @override
  String get settings_licenses => 'Лицензии компонентов';

  @override
  String get settings_licensesDetail =>
      'Программное обеспечение, используемое в приложении';

  @override
  String get settings_background =>
      'VPN остаётся включённым, когда вы покидаете приложение. Чтобы остановить его, нажмите «Отключиться» на вкладке «Подключение».';

  @override
  String get theme_system => 'Системная';

  @override
  String get theme_light => 'Светлая';

  @override
  String get theme_dark => 'Тёмная';

  @override
  String get language_system => 'Язык телефона';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Удалить это устройство?';

  @override
  String get dialog_removeCurrent =>
      'Этот телефон отключится от VPN и потеряет доступ. Данные его VPN-подключения будут удалены после подтверждения сервера.';

  @override
  String dialog_removeOther(Object name) {
    return 'Доступ устройства «$name» к VPN будет отозван. Это действие нельзя отменить.';
  }

  @override
  String get dialog_signOut => 'Выйти?';

  @override
  String get dialog_signOutMessage =>
      'VPN будет остановлен, и вам потребуется войти снова. Ваши зашифрованные ключи VPN останутся на этом телефоне для следующего подключения.';

  @override
  String get action_cancel => 'Отмена';

  @override
  String get action_signOut => 'Выйти';

  @override
  String get notice_close => 'Закрыть сообщение';

  @override
  String get notice_sessionExpired_title => 'Сессия истекла';

  @override
  String get notice_sessionExpired_message =>
      'Срок действия вашей сессии истёк. Войдите снова.';

  @override
  String get notice_connectionFailed_title => 'Не удалось подключиться';

  @override
  String get notice_invalidCredentials_message =>
      'Неверный адрес электронной почты или пароль.';

  @override
  String get notice_emailVerification_title =>
      'Требуется подтверждение электронной почты';

  @override
  String get notice_emailVerification_message =>
      'Подтвердите адрес электронной почты перед добавлением VPN-устройства.';

  @override
  String get notice_rateLimited_title => 'Слишком много попыток';

  @override
  String get notice_deviceLimit_title => 'Достигнут лимит в 2 устройства';

  @override
  String get notice_deviceLimit_message =>
      'Удалите существующее устройство перед добавлением другого.';

  @override
  String get notice_identityRenewal_title =>
      'Необходимо обновить VPN-идентичность';

  @override
  String get notice_identityRenewal_message =>
      'Эта идентичность удалена. Создайте новую локальную идентичность.';

  @override
  String get notice_migrationPending_title => 'Изменение локации выполняется';

  @override
  String get notice_migrationPending_message =>
      'Изменение локации уже выполняется.';

  @override
  String get notice_migrationBlocked_title => 'Изменение локации заблокировано';

  @override
  String get notice_migrationBlocked_message =>
      'Для изменения локации требуется вмешательство сервера. Повторите попытку позже или обратитесь в службу поддержки.';

  @override
  String get notice_targetUnavailable_title => 'Сервер временно недоступен';

  @override
  String get notice_targetUnavailable_message =>
      'Этот сервер временно недоступен.';

  @override
  String get notice_networkUnavailable_title =>
      'Подключение к интернету недоступно';

  @override
  String get notice_networkUnavailable_message =>
      'Проверьте подключение и повторите попытку.';

  @override
  String get notice_permissionDenied_title => 'В разрешении VPN отказано';

  @override
  String get notice_permissionDenied_message =>
      'Запустите подключение снова и примите запрос разрешения Android.';

  @override
  String get notice_wireguardTimeout_title => 'Сервер не отвечает';

  @override
  String get notice_wireguardTimeout_message =>
      'Подключение WireGuard выполнялось слишком долго. Повторите попытку или выберите другую локацию.';

  @override
  String get notice_tlsFailed_title => 'В защищённом подключении отказано';

  @override
  String get notice_tlsFailed_message =>
      'Сервер не принял подключение OpenVPN. Повторите попытку. Если проблема сохраняется, запустите диагностику.';

  @override
  String get notice_tunRejected_title => 'Android отклонил VPN-интерфейс';

  @override
  String get notice_tunRejected_message =>
      'Android отклонил сетевую конфигурацию, запрошенную OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Не удалось запустить OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'Ядро OpenVPN не смогло завершить запуск. Повторите попытку. Если проблема сохраняется, обратитесь в службу поддержки.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Диагностический код: $code';
  }

  @override
  String get notice_generic_title => 'Не удалось подключиться к VPN';

  @override
  String get notice_generic_message =>
      'Произошла ошибка. Повторите попытку позже.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Учётная запись создана',
      'password_reset_sent': 'Запрос на сброс пароля получен',
      'verification_email_sent': 'Письмо для подтверждения отправлено',
      'location_migration_pending': 'Изменение локации выполняется',
      'vpn_sign_in_required': 'Требуется вход',
      'protocol_unavailable_at_location': 'Протокол недоступен',
      'vpn_permission_denied': 'В разрешении VPN отказано',
      'revoked_identity_device_limit': 'Достигнут лимит в 2 устройства',
      'tunnel_start_unexpected': 'Не удалось запустить VPN',
      'flutter_disconnect_timeout': 'Отключение не подтверждено',
      'flutter_disconnect_unexpected': 'Не удалось отключиться',
      'device_revoked': 'Устройство удалено',
      'revoke_unexpected': 'Не удалось удалить устройство',
      'identity_renewal_unexpected': 'Не удалось обновить идентичность',
      'openvpn_renewal_unexpected': 'Не удалось обновить OpenVPN',
      'location_migration_blocked': 'Изменение локации заблокировано',
      'location_migration_slow': 'Изменение локации всё ещё выполняется',
      'location_migration_conflict': 'Необходимо обновить изменение локации',
      'location_migration_verification_failed':
          'Изменение локации не подтверждено',
      'location_migration_device_changed':
          'Устройство изменилось во время смены локации',
      'tunnel_stop_failed': 'Изменение локации недоступно',
      'other': 'Операция не выполнена',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Учётная запись создана, но письмо для подтверждения не удалось отправить. Используйте повторную отправку в приложении.',
      'password_reset_sent':
          'Ваш запрос получен. Если этой почте соответствует учётная запись, вы можете получить письмо. Также проверьте папку со спамом.',
      'verification_email_sent':
          'Новое письмо для подтверждения только что отправлено.',
      'location_migration_pending':
          'Перемещение в $target всё ещё подготавливается. Вы можете продолжить его без повторного создания устройства.',
      'vpn_sign_in_required':
          'Войдите в свою учётную запись перед запуском VPN.',
      'protocol_unavailable_at_location':
          'Выбранный протокол не предлагается в этой локации. Обновите список локаций или выберите другой протокол.',
      'vpn_permission_denied':
          'Android отклонил разрешение VPN. Запустите подключение снова и примите системный запрос.',
      'revoked_identity_device_limit':
          'Доступ этого устройства к VPN удалён, и лимит устройств достигнут. Удалите устройство в разделе «Учётная запись» → «Управление моими устройствами».',
      'tunnel_start_unexpected':
          'Непредвиденная ошибка прервала подготовку туннеля. Проверьте диагностический код и повторите попытку.',
      'flutter_disconnect_timeout':
          'Android вовремя не подтвердил остановку VPN. Попробуйте остановить его снова.',
      'flutter_disconnect_unexpected':
          'Непредвиденная ошибка не позволила подтвердить остановку туннеля.',
      'device_revoked':
          'Доступ устройства к VPN отозван, а его локальные секреты удалены.',
      'revoke_unexpected':
          'Не удалось удалить устройство. Обновите список и повторите попытку.',
      'identity_renewal_unexpected':
          'Не удалось создать новую VPN-идентичность. Обновите список устройств и повторите попытку.',
      'openvpn_renewal_unexpected':
          'Не удалось обновить профиль OpenVPN. Повторите попытку или проверьте диагностический код.',
      'location_migration_blocked':
          'Сервер не может завершить это изменение сейчас. Устройство и его локальная идентичность сохранены.',
      'location_migration_slow':
          'Сервер всё ещё подготавливает перемещение в $target. Через несколько минут нажмите «Продолжить».',
      'location_migration_conflict':
          'Состояние устройства изменилось на сервере. Обновите список устройств, затем продолжите изменение.',
      'location_migration_verification_failed':
          'Сервер не подтвердил новую локацию. Предыдущая локальная идентичность сохранена.',
      'location_migration_device_changed':
          'Устройство, возвращённое сервером, больше не совпадает с изменяемым устройством. Обновите список устройств перед новой попыткой.',
      'tunnel_stop_failed':
          'Перед новым подключением предыдущий туннель необходимо полностью остановить.',
      'other':
          'Не удалось завершить операцию. Повторите попытку или отправьте диагностический код в службу поддержки.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Сессия истекла',
      'invalid_credentials': 'Не удалось войти',
      'email_verification_required':
          'Требуется подтверждение электронной почты',
      'verification_email_cooldown': 'Письмо уже отправлено',
      'rate_limited': 'Слишком много попыток',
      'invalid_registration': 'Необходимо исправить сведения',
      'email_exists': 'Учётная запись уже существует',
      'invalid_profile': 'Недействительный профиль',
      'invalid_device': 'Недействительное устройство',
      'invalid_location': 'Локация недоступна',
      'device_limit': 'Достигнут лимит устройств',
      'device_exists': 'VPN-идентичность уже используется',
      'device_identity_revoked': 'Необходимо обновить VPN-идентичность',
      'device_location_locked': 'Необходимо обновить изменение локации',
      'location_migration_pending': 'Изменение локации выполняется',
      'location_migration_blocked': 'Изменение локации заблокировано',
      'target_ca_mismatch': 'Несовместимый сервер OpenVPN',
      'location_migration_conflict': 'Необходимо обновить изменение локации',
      'server_full': 'Сервер заполнен',
      'capacity_unavailable': 'Локация временно недоступна',
      'target_unavailable': 'Сервер временно недоступен',
      'not_found': 'Элемент не найден',
      'invalid_openvpn_csr': 'Недействительная идентичность OpenVPN',
      'openvpn_profile_exists': 'Профиль OpenVPN уже существует',
      'openvpn_profile_revoked': 'Профиль OpenVPN отозван',
      'openvpn_operation_pending': 'Операция OpenVPN выполняется',
      'openvpn_operation_terminal': 'Операция OpenVPN прервана',
      'openvpn_address_unavailable': 'Адрес OpenVPN недоступен',
      'openvpn_profile_conflict': 'Конфликт OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN недоступен',
      'email_delivery_unavailable': 'Электронная почта недоступна',
      'invalid_token': 'Недействительная ссылка',
      'network_unavailable': 'Подключение к интернету недоступно',
      'invalid_json': 'Недействительный запрос',
      'invalid_api_response': 'Недействительный ответ сервера',
      'ipv6_unavailable': 'IPv6 недоступен',
      'invalid_ip_families': 'Конфигурация сети отклонена',
      'other': 'Служба недоступна',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Срок действия вашей сессии истёк. Войдите снова.',
      'invalid_credentials': 'Неверный адрес электронной почты или пароль.',
      'email_verification_required':
          'Подтвердите адрес электронной почты перед добавлением VPN-устройства.',
      'invalid_registration': 'Проверьте запрошенные сведения и согласия.',
      'email_exists':
          'Этим адресом электронной почты уже пользуется другая учётная запись.',
      'invalid_profile': 'Проверьте сведения профиля.',
      'invalid_device':
          'Имя или локальная идентичность этого устройства недействительны.',
      'invalid_location': 'Обновите список локаций и повторите попытку.',
      'device_limit':
          'Удалите существующее устройство перед добавлением другого.',
      'device_exists':
          'Эта VPN-идентичность уже связана с другой учётной записью.',
      'device_identity_revoked':
          'Эта идентичность удалена. Необходимо создать новую локальную идентичность.',
      'device_location_locked':
          'Локация этого устройства только что изменилась. Приложение продолжит выполняющееся изменение.',
      'location_migration_pending': 'Изменение локации уже выполняется.',
      'location_migration_blocked':
          'Для изменения локации требуется вмешательство сервера. Повторите попытку позже или обратитесь в службу поддержки.',
      'target_ca_mismatch':
          'Этот сервер пока несовместим с текущим профилем OpenVPN.',
      'location_migration_conflict':
          'Обновите список устройств, затем снова попробуйте изменить локацию.',
      'server_full':
          'Эта локация достигла лимита подключений. Выберите другую локацию или повторите попытку позже.',
      'capacity_unavailable':
          'Сейчас мы не можем подтвердить доступность этой локации. Выберите другую локацию или повторите попытку позже.',
      'target_unavailable': 'Этот сервер временно недоступен.',
      'not_found': 'Этот элемент больше недоступен в вашей учётной записи.',
      'invalid_openvpn_csr':
          'Создайте новую идентичность OpenVPN и повторите попытку.',
      'openvpn_profile_exists':
          'Для этого устройства уже существует профиль OpenVPN.',
      'openvpn_profile_revoked': 'Обновите профиль OpenVPN, чтобы продолжить.',
      'openvpn_operation_pending':
          'Изменение всё ещё распространяется. Повторите попытку позже.',
      'openvpn_operation_terminal':
          'Создайте новую идентичность OpenVPN и повторите попытку.',
      'openvpn_address_unavailable':
          'В настоящее время адрес OpenVPN недоступен.',
      'openvpn_profile_conflict':
          'Профиль изменился. Обновите устройства и повторите попытку.',
      'openvpn_signer_unavailable': 'Служба OpenVPN временно недоступна.',
      'email_delivery_unavailable':
          'Не удалось отправить письмо. Повторите попытку позже.',
      'invalid_token':
          'Эта ссылка недействительна или просрочена. Запросите новую.',
      'network_unavailable':
          'Проверьте подключение к интернету и повторите попытку.',
      'invalid_json': 'Проверьте введённые сведения и повторите попытку.',
      'invalid_api_response':
          'Сервер вернул неожиданный ответ. Повторите попытку позже.',
      'ipv6_unavailable':
          'Сервер не может активировать IPv6 сейчас. Повторите попытку позже.',
      'invalid_ip_families':
          'Конфигурация туннеля неполна или не соответствует разрешённым адресам. Повторите попытку из приложения.',
      'other': 'Произошла ошибка сервера. Повторите попытку позже.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Повторите попытку через несколько минут.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Повторите попытку через $seconds секунд.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Возобновление системного VPN недоступно',
      'system_vpn_resume_corrupt':
          'Недействительное возобновление системного VPN',
      'system_vpn_resume_session_invalid':
          'Недействительная сессия возобновления VPN',
      'system_vpn_resume_identity_changed': 'Идентичность VPN изменилась',
      'system_vpn_resume_identity_invalid':
          'Недействительная идентичность для возобновления VPN',
      'system_vpn_resume_storage_failed':
          'Хранилище возобновления VPN недоступно',
      'system_vpn_resume_network_timeout': 'Для возобновления VPN нет сети',
      'system_vpn_resume_blocked': 'Возобновление VPN заблокировано',
      'system_vpn_resume_failed': 'Не удалось возобновить VPN',
      'system_vpn_resume_error_invalid':
          'Недействительная ошибка возобновления VPN',
      'wireguard_identity_store_failed': 'Идентичность WireGuard не сохранена',
      'wireguard_identity_unavailable': 'Идентичность WireGuard недоступна',
      'vpn_host_destroyed': 'Хост Android VPN остановлен',
      'vpn_host_unavailable': 'Хост Android VPN недоступен',
      'vpn_permission_required': 'Требуется разрешение VPN',
      'vpn_permission_denied': 'В разрешении VPN отказано',
      'vpn_permission_request_failed': 'Не удалось запросить разрешение',
      'wireguard_foreground_service_unavailable': 'Служба WireGuard недоступна',
      'wireguard_identity_invalid': 'Недействительный локальный ключ WireGuard',
      'wireguard_identity_in_use': 'Идентичность WireGuard уже используется',
      'wireguard_configuration_invalid':
          'Недействительная конфигурация WireGuard',
      'wireguard_operation_pending': 'Операция WireGuard всё ещё выполняется',
      'wireguard_start_failed': 'Запуск WireGuard отклонён',
      'wireguard_stop_timeout': 'Остановка WireGuard не подтверждена',
      'wireguard_handshake_timeout': 'WireGuard не ответил',
      'openvpn_connection_timeout': 'OpenVPN не ответил',
      'openvpn_core_unavailable': 'Ядро OpenVPN недоступно',
      'openvpn_operation_pending': 'Сессия OpenVPN всё ещё активна',
      'openvpn_stop_timeout': 'Остановка OpenVPN не подтверждена',
      'openvpn_profile_unavailable': 'Локальный профиль OpenVPN отсутствует',
      'openvpn_native_failed': 'Вызов OpenVPN прерван',
      'openvpn_key_generation_failed': 'Не удалось создать ключ OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Не удалось создать CSR OpenVPN',
      'openvpn_identity_store_failed': 'Идентичность OpenVPN не сохранена',
      'openvpn_identity_clear_failed': 'Неполное удаление OpenVPN',
      'openvpn_identity_in_use': 'Идентичность OpenVPN всё ещё используется',
      'openvpn_tls_verification_required': 'Отсутствует проверка TLS OpenVPN',
      'openvpn_cipher_invalid': 'Недействительный шифр OpenVPN',
      'openvpn_profile_rejected': 'Профиль OpenVPN отклонён',
      'openvpn_identity_inconsistent': 'Несогласованная идентичность OpenVPN',
      'tls_handshake_failed': 'Согласование OpenVPN отклонено',
      'tls_alert_unknown_ca': 'Сертификат клиента OpenVPN не распознан',
      'tls_alert_bad_certificate': 'Сертификат клиента OpenVPN отклонён',
      'tls_alert_unsupported_certificate':
          'Неподдерживаемый сертификат OpenVPN',
      'tls_client_certificate_required': 'Требуется сертификат клиента OpenVPN',
      'tls_alert_misc': 'Оповещение TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Неподдерживаемая подпись OpenVPN',
      'tls_handshake_rejected': 'Согласование TLS OpenVPN отклонено',
      'tls_version_rejected': 'Несовместимая версия TLS OpenVPN',
      'tls_certificate_expired': 'Срок действия сертификата TLS истёк',
      'tls_certificate_revoked': 'Сертификат TLS отозван',
      'transport_failed': 'Сервер OpenVPN недоступен',
      'tun_configuration_rejected': 'Не удалось создать интерфейс OpenVPN',
      'tun_setup_failed': 'Не удалось настроить TUN OpenVPN',
      'tun_interface_create_failed': 'Не удалось создать интерфейс OpenVPN',
      'tun_interface_disabled': 'Интерфейс OpenVPN отключён',
      'tun_halted': 'Интерфейс OpenVPN прерван',
      'tun_already_established': 'Интерфейс OpenVPN уже открыт',
      'tun_addresses_missing': 'Адрес OpenVPN отсутствует',
      'tun_routes_missing': 'Маршруты OpenVPN отсутствуют',
      'tun_dns_missing': 'DNS OpenVPN отсутствует',
      'tun_permission_revoked': 'Разрешение VPN отозвано',
      'tun_establish_returned_null': 'Android отклонил интерфейс VPN',
      'openvpn_service_start_failed': 'Служба OpenVPN недоступна',
      'openvpn_operation_timeout': 'Время ожидания вызова OpenVPN истекло',
      'openvpn_start_failed': 'Запуск OpenVPN отклонён',
      'openvpn_connection_failed': 'Подключение OpenVPN прервано',
      'openvpn_core_status_error': 'Работа ядра OpenVPN завершилась с ошибкой',
      'openvpn_stopped_before_connected': 'OpenVPN остановлен до подключения',
      'openvpn_auth_failed': 'Аутентификация OpenVPN отклонена',
      'openvpn_client_setup_failed': 'Не удалось настроить клиент OpenVPN',
      'openvpn_client_halted': 'Клиент OpenVPN прерван',
      'openvpn_client_restart': 'Запрошен перезапуск OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN слишком долго бездействовал',
      'openvpn_session_expired': 'Сессия OpenVPN истекла',
      'openvpn_credentials_required': 'Неподдерживаемая аутентификация OpenVPN',
      'openvpn_proxy_failed': 'Промежуточный транспорт OpenVPN не работает',
      'openvpn_compression_failed': 'Сжатие OpenVPN отклонено',
      'openvpn_ntlm_crypto_unavailable': 'Шифрование NTLM OpenVPN недоступно',
      'openvpn_feature_unsupported': 'Неподдерживаемая функция OpenVPN',
      'network_unavailable': 'Подключение к интернету недоступно',
      'network_lost': 'Сеть недоступна',
      'certificate_validation_failed': 'Сертификат сервера отклонён',
      'openvpn_certificate_expired': 'Сертификат OpenVPN истёк',
      'tunnel_active_for_another_account':
          'Туннель другой учётной записи всё ещё активен',
      'tunnel_already_active': 'Нативный туннель уже активен',
      'tunnel_stop_timeout': 'Остановка $protocol не подтверждена',
      'tunnel_disconnected': '$protocol прерван',
      'native_bridge_unavailable': 'Мост Android недоступен',
      'native_operation_failed': 'Операция Android прервана',
      'invalid_arguments': 'Неполные параметры VPN',
      'invalid_account_id': 'Недействительная учётная запись VPN',
      'invalid_device_id': 'Недействительный идентификатор устройства',
      'storage_key_not_allowed': 'Ключ хранилища отклонён',
      'secure_storage_read_failed': 'Не удалось безопасно прочитать данные',
      'secure_storage_write_failed': 'Не удалось безопасно записать данные',
      'key_generation_failed': 'Не удалось создать ключ WireGuard',
      'csr_generation_failed': 'Не удалось создать CSR OpenVPN',
      'other': 'Не классифицированная нативная ошибка VPN',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android не может найти сессию VPN, которую можно возобновить. Запустите новое подключение в приложении.',
      'system_vpn_resume_corrupt':
          'Сохранённые данные для возобновления VPN недействительны и использоваться не будут. Запустите новое подключение.',
      'system_vpn_resume_session_invalid':
          'Сохранённая сессия больше не может возобновить VPN. Войдите снова в приложении.',
      'system_vpn_resume_identity_changed':
          'Локальная идентичность VPN изменилась. Возобновление остановлено; запустите новое подключение.',
      'system_vpn_resume_identity_invalid':
          'Идентичность для возобновления недействительна. Запустите новое подключение.',
      'system_vpn_resume_storage_failed':
          'Android не смог прочитать или обновить зашифрованные данные для возобновления. Запустите новое подключение.',
      'system_vpn_resume_network_timeout':
          'Android не нашёл сеть вовремя, чтобы возобновить VPN. Повторите попытку, когда сеть станет доступна.',
      'system_vpn_resume_blocked':
          'Возобновление VPN заблокировано. Проверьте настройки Android, затем запустите новое подключение.',
      'system_vpn_resume_failed':
          'Не удалось возобновить VPN Android. Запустите новое подключение в приложении.',
      'system_vpn_resume_error_invalid':
          'Android вернул непригодную для использования ошибку возобновления. Запустите новое подключение.',
      'wireguard_identity_store_failed':
          'Android не смог сохранить зашифрованную идентичность WireGuard этой учётной записи.',
      'wireguard_identity_unavailable':
          'Для этого подключения нет пригодной к использованию идентичности WireGuard.',
      'vpn_host_destroyed':
          'Компонент Android, обслуживающий VPN, был остановлен. Запустите новое подключение.',
      'vpn_host_unavailable':
          'Android не может создать компонент, обслуживающий VPN. Повторите попытку после проверки настроек VPN.',
      'openvpn_renewal_required':
          'Перед подключением сертификат требует действия в приложении.',
      'openvpn_recovery_failed':
          'Автоматическое восстановление не удалось. Запустите новое подключение в приложении.',
      'openvpn_recovery_exhausted':
          'Автоматическое восстановление уже использовано. Запустите новое подключение в приложении.',
      'vpn_permission_required':
          'Перед запуском туннеля Android требует нового разрешения VPN.',
      'vpn_permission_denied':
          'Разрешите FuzeVPN в запросе Android, чтобы продолжить.',
      'vpn_permission_request_failed':
          'Android не смог открыть экран разрешения VPN.',
      'wireguard_foreground_service_unavailable':
          'Android не смог оставить службу WireGuard работающей на переднем плане.',
      'wireguard_identity_invalid':
          'Зашифрованный ключ WireGuard этой учётной записи не читается или недействителен.',
      'wireguard_identity_in_use':
          'Другая операция всё ещё использует ключ WireGuard этой учётной записи.',
      'wireguard_configuration_invalid':
          'Полученные адрес WireGuard, DNS, ключ сервера или маршруты недействительны.',
      'wireguard_operation_pending':
          'Предыдущая операция WireGuard ещё не освободила нативную службу.',
      'wireguard_start_failed':
          'Ядро WireGuard отклонило активацию конфигурации.',
      'wireguard_stop_timeout':
          'Служба WireGuard не подтвердила освобождение интерфейса VPN в течение установленного времени.',
      'wireguard_handshake_timeout':
          'Туннель не подтвердил рукопожатие с сервером вовремя.',
      'openvpn_connection_timeout':
          'OpenVPN вовремя не подтвердил подключение к серверу.',
      'openvpn_core_unavailable':
          'Эта версия приложения не содержит пригодного к использованию ядра OpenVPN.',
      'openvpn_operation_pending':
          'Нативное ядро всё ещё удерживает предыдущую сессию OpenVPN и отказывается создавать вторую.',
      'openvpn_stop_timeout':
          'Ядро OpenVPN не подтвердило остановку и уничтожение своей нативной сессии в течение установленного времени.',
      'openvpn_profile_unavailable':
          'Для этого подключения нет проверенного профиля OpenVPN, доступного для чтения.',
      'openvpn_native_failed':
          'Ошибка приложения прервала работу OpenVPN. Попробуйте подключиться снова. Если проблема сохраняется, запустите диагностику.',
      'openvpn_key_generation_failed':
          'Android Keystore не смог создать или прочитать неэкспортируемый закрытый ключ P-256.',
      'openvpn_csr_generation_failed':
          'Ключ Android Keystore не смог подписать запрос сертификата OpenVPN.',
      'openvpn_identity_store_failed':
          'Не удалось сохранить сертификат или профиль OpenVPN в зашифрованном хранилище.',
      'openvpn_identity_clear_failed':
          'Android не смог удалить всю локальную идентичность OpenVPN этой учётной записи.',
      'openvpn_identity_in_use':
          'Нативная сессия OpenVPN всё ещё использует ключ или сертификат этого устройства.',
      'openvpn_tls_verification_required':
          'Профиль явно не требует проверки сертификата сервера.',
      'openvpn_cipher_invalid':
          'Сервер предоставил алгоритм шифрования, которого нет в разрешённом списке.',
      'openvpn_profile_rejected':
          'Профиль, полученный от сервера, несовместим. Создайте это устройство заново и повторите попытку.',
      'openvpn_identity_inconsistent':
          'Сертификат не соответствует защищённой идентичности этого телефона. Локальный профиль не заменён.',
      'tls_handshake_failed':
          'Сервер отклонил согласование TLS. Если проблема сохраняется, создайте профиль заново.',
      'tls_alert_unknown_ca':
          'Сервер не признаёт полномочия центра сертификации сертификата этого устройства. Необходимо проверить сервер OpenVPN.',
      'tls_alert_bad_certificate':
          'Сервер отклонил сертификат этого устройства. Перед новой попыткой создайте устройство заново.',
      'tls_alert_unsupported_certificate':
          'Сервер не поддерживает тип защищённого сертификата, используемый Android.',
      'tls_client_certificate_required':
          'Сервер требует сертификат клиента, но ядро OpenVPN не смогло его предъявить.',
      'tls_alert_misc':
          'Сервер вернул оповещение TLS, не относящееся к категориям сертификата или версии.',
      'tls_signature_algorithm_rejected':
          'Сервер отклонил алгоритм ECDSA P-256 ключа Android Keystore.',
      'tls_handshake_rejected':
          'Сервер прервал согласование TLS до подключения.',
      'tls_version_rejected': 'Клиент и сервер не нашли общую версию TLS.',
      'tls_certificate_expired':
          'Срок действия сертификата, предъявленного при подключении, истёк.',
      'tls_certificate_revoked':
          'Сертификат, предъявленный при подключении, отозван.',
      'transport_failed':
          'Сервер OpenVPN не отвечает в текущей сети. Повторите попытку через несколько секунд.',
      'tun_configuration_rejected':
          'Android отклонил сетевую конфигурацию, запрошенную OpenVPN.',
      'tun_setup_failed':
          'Ядро OpenVPN отклонило план сети до создания интерфейса Android.',
      'tun_interface_create_failed':
          'Ядро OpenVPN не смогло получить интерфейс TUN от Android VpnService.',
      'tun_interface_disabled':
          'Android или ядро OpenVPN отключило интерфейс TUN во время подключения.',
      'tun_halted': 'Ядро OpenVPN получило запрос на остановку интерфейса TUN.',
      'tun_already_established':
          'OpenVPN запросил второй интерфейс в том же подключении. В целях безопасности туннель остановлен.',
      'tun_addresses_missing': 'Сервер не предоставил пригодный адрес туннеля.',
      'tun_routes_missing': 'Сервер не предоставил пригодные маршруты туннеля.',
      'tun_dns_missing': 'Сервер не предоставил пригодный DNS-сервер.',
      'tun_permission_revoked':
          'Android отозвал разрешение VPN во время подключения.',
      'tun_establish_returned_null':
          'Android не создал интерфейс, обычно потому, что другой VPN всё ещё активен.',
      'openvpn_service_start_failed':
          'Android не смог запустить фоновую службу OpenVPN.',
      'openvpn_operation_timeout':
          'Вызов JNI к ядру OpenVPN превысил максимально допустимую длительность.',
      'openvpn_start_failed':
          'Служба Android готова, но ядро OpenVPN не приняло запуск профиля.',
      'openvpn_connection_failed':
          'Ядро OpenVPN остановилось до отправки события CONNECTED.',
      'openvpn_core_status_error':
          'Нативный цикл OpenVPN завершился с ошибкой без более конкретного конечного события.',
      'openvpn_stopped_before_connected':
          'Нативный цикл OpenVPN остановился до CONNECTED без явной ошибки ядра.',
      'openvpn_auth_failed': 'Сервер OpenVPN отклонил аутентификацию профиля.',
      'openvpn_client_setup_failed':
          'Ядро OpenVPN не смогло инициализировать клиент до подключения к сети.',
      'openvpn_client_halted':
          'Ядро OpenVPN получило конечный запрос на остановку клиента.',
      'openvpn_client_restart':
          'Ядро OpenVPN запросило перезапуск транспортной сессии.',
      'openvpn_inactive_timeout':
          'Ядро OpenVPN закрыло сессию после истечения времени бездействия.',
      'openvpn_session_expired':
          'Сервер сообщил, что срок действия сессии OpenVPN истёк.',
      'openvpn_credentials_required':
          'Сервер или прокси запрашивает интерактивные учётные данные, не входящие в этот профиль сертификата.',
      'openvpn_proxy_failed':
          'Ядро OpenVPN сообщило о сбое настроенного прокси или ретранслятора.',
      'openvpn_compression_failed':
          'Ядро OpenVPN отклонило режим сжатия, объявленный профилем или сервером.',
      'openvpn_ntlm_crypto_unavailable':
          'Профиль запрашивает шифрование NTLM, недоступное в этой версии.',
      'openvpn_feature_unsupported':
          'Профиль или сервер требует функцию, отсутствующую в этом клиенте Android.',
      'network_unavailable': 'Нет доступной пригодной физической сети.',
      'network_lost': 'Туннель остановлен после потери сети.',
      'certificate_validation_failed':
          'Не удалось проверить идентичность сервера OpenVPN.',
      'openvpn_certificate_expired':
          'Обновите профиль OpenVPN перед повторным подключением.',
      'tunnel_active_for_another_account':
          'Перед этим подключением необходимо остановить туннель другой учётной записи.',
      'tunnel_already_active':
          'Android сообщает, что предыдущая сессия VPN всё ещё использует интерфейс.',
      'tunnel_stop_timeout':
          'Ядро $protocol не подтвердило освобождение интерфейса VPN в течение установленного времени.',
      'tunnel_disconnected':
          'Нативное ядро сообщило, что после запуска туннель неожиданно завершился.',
      'native_bridge_unavailable':
          'Приложение не может получить доступ к службе Android VPN. Закройте и снова откройте приложение, затем повторите попытку.',
      'native_operation_failed':
          'Ошибка приложения прервала операцию VPN. Повторите попытку. Если проблема сохраняется, запустите диагностику.',
      'invalid_arguments':
          'Сведения, необходимые для этой операции VPN, неполны. Повторите попытку. Если проблема сохраняется, запустите диагностику.',
      'invalid_account_id':
          'Нативная операция не связана с действительным идентификатором учётной записи.',
      'invalid_device_id':
          'Идентификатор устройства, отправленный нативному ядру, отсутствует или недействителен.',
      'storage_key_not_allowed':
          'Мост Android заблокировал ключ, отсутствующий в разрешённом списке хранилища.',
      'secure_storage_read_failed':
          'Android Keystore не смог расшифровать локальные данные этой учётной записи.',
      'secure_storage_write_failed':
          'Android Keystore не смог зашифровать или сохранить локальные данные.',
      'key_generation_failed':
          'Android не смог создать или прочитать ключ WireGuard в защищённом хранилище.',
      'csr_generation_failed':
          'Android Keystore не смог создать или подписать CSR OpenVPN P-256.',
      'other':
          'Не задокументированная нативная ветвь завершилась с ошибкой. Отправьте показанный ниже диагностический код в службу поддержки.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Запрос разрешения уже открыт';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Запрос разрешения Android на VPN уже отображается. Завершите его перед новой попыткой.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Запрос разрешения VPN прерван';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Экран запроса разрешения VPN закрылся до того, как приложение получило ответ.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Подключение OpenVPN не подтверждено';

  @override
  String get notice_openvpnProofMissing_message =>
      'Не удалось подтвердить подключение OpenVPN. В целях безопасности оно остановлено. Повторите попытку.';

  @override
  String get openvpnCleanup_title => 'Профиль OpenVPN отозван';

  @override
  String get openvpnCleanup_working =>
      'Остановка и удаление отозванного профиля OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Остановка OpenVPN не подтверждена. Повторите попытку перед созданием нового профиля.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Не удалось полностью удалить отозванный профиль OpenVPN. Повторите очистку.';

  @override
  String get openvpnCleanup_complete =>
      'Отозванный профиль OpenVPN удалён. Нажмите «Подключиться», чтобы создать новый.';

  @override
  String get network_title => 'Конфигурация сети';

  @override
  String get network_ipv4Fallback =>
      'IPv6 временно недоступен. Подготовка продолжается с IPv4.';

  @override
  String get network_rejectedTitle => 'Конфигурация сети отклонена';

  @override
  String get network_rejectedMessage =>
      'Конфигурация туннеля неполна или не соответствует разрешённым адресам. Повторите попытку из приложения.';

  @override
  String get network_unreadableTitle => 'Локальная конфигурация не читается';

  @override
  String get network_unreadableMessage =>
      'Сохранённую сетевую конфигурацию OpenVPN нельзя использовать. Подключитесь снова из приложения, чтобы обновить её.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Защита сети';

  @override
  String get protection_subtitle =>
      'Блокировать прямой доступ к интернету при отключении VPN.';

  @override
  String get protection_active => 'Системная защита включена';

  @override
  String get protection_alwaysOnOnly =>
      'VPN всегда включён; включите блокировку вне VPN';

  @override
  String get protection_inactive => 'Системная защита отключена';

  @override
  String get protection_unknown => 'Проверить системную защиту';

  @override
  String get protection_openSettings => 'Открыть настройки Android';

  @override
  String get protection_dialogTitle => 'Настройка защиты сети';

  @override
  String get protection_dialogMessage =>
      'Android управляет постоянно включённым VPN и блокировкой подключений вне VPN. Убедитесь, что выбран FuzeVPN, и включите блокировку в системных настройках.';

  @override
  String get protection_dialogOpen => 'Открыть настройки';

  @override
  String get session_systemProtectionNote =>
      'Если Android по-прежнему блокирует трафик вне VPN, откройте системные настройки, чтобы проверить или изменить эту защиту.';

  @override
  String get diagnostics_title => 'Диагностика';

  @override
  String get diagnostics_settingsTitle => 'Диагностика приложения';

  @override
  String get diagnostics_automaticTitle => 'Отправлять важные ошибки';

  @override
  String get diagnostics_automaticDescription =>
      'Отправлять небольшой технический отчёт при возникновении важной ошибки.';

  @override
  String get diagnostics_privacy =>
      'Отправленные отчёты связаны с учётной записью, в которую выполнен вход, и хранятся 30 дней. Они не содержат историю просмотров, пароли или ключи VPN.';

  @override
  String get diagnostics_manualOpen => 'Запустить диагностику';

  @override
  String get diagnostics_localDescription =>
      'Создать отчёт о состоянии приложения и VPN. Ваше подключение не изменится.';

  @override
  String get diagnostics_sendReport => 'Отправить отчёт';

  @override
  String get diagnostics_sendHint =>
      'Оставьте этот флажок снятым, чтобы сохранить отчёт на этом устройстве.';

  @override
  String get diagnostics_signedOut =>
      'Войдите в свою учётную запись, чтобы отправить отчёт.';

  @override
  String get diagnostics_localLifetime =>
      'Сохраните этот отчёт на телефоне, чтобы он остался после закрытия приложения.';

  @override
  String get diagnostics_run => 'Запустить диагностику';

  @override
  String get diagnostics_rerun => 'Запустить диагностику снова';

  @override
  String get diagnostics_running => 'Проверка…';

  @override
  String get diagnostics_sending => 'Отправка отчёта…';

  @override
  String get diagnostics_prepared => 'Отчёт готов на этом устройстве';

  @override
  String get diagnostics_queued => 'Отчёт ожидает отправки';

  @override
  String get diagnostics_sent => 'Отчёт получен';

  @override
  String get diagnostics_failed =>
      'Не удалось отправить. Локальный отчёт по-прежнему доступен.';

  @override
  String get diagnostics_preparationFailed =>
      'Не удалось подготовить диагностический отчёт. Повторите попытку.';

  @override
  String get diagnostics_authenticationRequired =>
      'Войдите снова, чтобы отправить отчёт.';

  @override
  String get diagnostics_retry => 'Повторить отправку';

  @override
  String get diagnostics_export => 'Сохранить отчёт';

  @override
  String get diagnostics_exportFailed =>
      'Не удалось экспортировать. Повторите попытку из локального отчёта.';

  @override
  String get diagnostics_preferenceFailed =>
      'Не удалось сохранить эту настройку. Повторите попытку.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Идентификатор: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Получен $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Хранится до $date';
  }

  @override
  String get diagnostics_duplicate => 'Этот отчёт уже был получен.';

  @override
  String get diagnostics_preview => 'Предварительный просмотр отчёта';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикреплено $count технического события',
      many: 'Прикреплено $count технических событий',
      few: 'Прикреплено $count технических события',
      one: 'Прикреплено $count техническое событие',
      zero: 'Технические события не прикреплены',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Технические сведения';

  @override
  String get diagnostics_empty => 'Диагностический отчёт ещё не подготовлен.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Состояние туннеля',
      'handshake': 'Подтверждение подключения',
      'certificate': 'Сертификат VPN',
      'kill_switch': 'Защита Android',
      'connectivity': 'Доступная сеть',
      'api_reachability': 'Доступ к службе',
      'secure_storage': 'Защищённое хранилище',
      'other': 'Локальная проверка',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Проверено',
      'failed': 'Требует внимания',
      'skipped': 'Не проверено — активная проверка отсутствует',
      'unknown': 'Сведения недоступны',
      'other': 'Сведения недоступны',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Добро пожаловать в FuzeVPN';

  @override
  String get connection_changeLocation => 'Изменить локацию';

  @override
  String get connection_details => 'Сведения о подключении';

  @override
  String get locations_searchLabel => 'Найти город или страну';

  @override
  String get locations_clearSearch => 'Очистить поиск';

  @override
  String get locations_filterAll => 'Все';

  @override
  String get locations_filterFavorites => 'Избранные';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count локации',
      many: '$count локаций',
      few: '$count локации',
      one: '$count локация',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Локации не найдены';

  @override
  String get locations_noResultsHint => 'Попробуйте другой город или страну.';

  @override
  String get locations_noFavorites => 'Ваши избранные — всегда под рукой';

  @override
  String get locations_noFavoritesHint =>
      'Нажмите на звезду рядом с локацией, чтобы сохранить её здесь.';

  @override
  String get locations_showAll => 'Показать все локации';

  @override
  String locations_addFavorite(String name) {
    return 'Добавить $name в избранное';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Удалить $name из избранного';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Не удалось сохранить локацию в избранное. Повторите попытку.';

  @override
  String get locations_emptyTitle => 'Нет доступных локаций';

  @override
  String get locations_emptyHint => 'Обновите список и повторите попытку.';

  @override
  String get devices_manage => 'Управление моими устройствами';

  @override
  String get settings_personalization => 'Настроить под себя';

  @override
  String get settings_safety => 'Защита';

  @override
  String get settings_help => 'Нужна помощь?';

  @override
  String get settings_about => 'О FuzeVPN';

  @override
  String get diagnostics_heading => 'Разобраться с проблемой подключения';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Доступно',
      'pending': 'Подготовка',
      'revoked': 'Удалено',
      'expired': 'Истёк срок действия',
      'other': 'Статус недоступен',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Настройка не сохранена';

  @override
  String get notice_preferenceSave_message =>
      'Ваш выбор пока применён, но сохранить его не удалось. Повторите попытку, чтобы он сохранился после закрытия приложения.';

  @override
  String get connection_androidDisconnectHint =>
      'Если Android продолжает поддерживать VPN активным, отключите постоянно включённый VPN в открывшихся настройках.';

  @override
  String get protection_learnMore => 'Подробнее о защите Android';

  @override
  String get protection_guideWhy =>
      'Эта защита не позволяет приложениям использовать интернет напрямую при отключении VPN. Она настраивается в Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN всегда включён';

  @override
  String get protection_guideAlwaysOn =>
      'Android поддерживает работу службы VPN и может перезапустить её после перезагрузки телефона.';

  @override
  String get protection_guideBlockTitle => 'Блокировать подключения без VPN';

  @override
  String get protection_guideBlock =>
      'Эта настройка не позволяет трафику обходить VPN, в том числе при прерывании подключения.';

  @override
  String get protection_guideWarning =>
      'При включённой блокировке доступ к интернету остаётся отключённым, пока VPN не подключится.';

  @override
  String get protection_guideStepsTitle => 'Включить защиту';

  @override
  String get protection_guideStep1 =>
      'Откройте настройки VPN Android с помощью кнопки ниже.';

  @override
  String get protection_guideStep2 =>
      'Откройте параметры с помощью значка шестерёнки рядом с FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Включите «VPN всегда включён», а затем «Блокировать подключения без VPN», если эти параметры доступны.';

  @override
  String get protection_guideManufacturers =>
      'Названия зависят от телефона. При необходимости найдите VPN в настройках, обычно в разделе «Сеть и интернет».';

  @override
  String get protection_guideDisableTitle => 'Отключить эту защиту';

  @override
  String get protection_guideDisable =>
      'В тех же настройках отключите блокировку подключений без VPN, чтобы разрешить доступ к интернету без VPN. Также отключите «VPN всегда включён», если больше не хотите, чтобы Android перезапускал его.';

  @override
  String get protection_guideManual =>
      'Эти настройки выбираются в Android. FuzeVPN не изменяет их за вас.';

  @override
  String get locations_changeTitle => 'Изменить локацию?';

  @override
  String locations_changeActive(String name) {
    return 'VPN отключится, затем попытается подключиться к $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN попытается подключиться к $name.';
  }

  @override
  String get locations_confirmChange => 'Изменить и подключиться';

  @override
  String get locations_changeBusy =>
      'Изменение уже выполняется. Дождитесь завершения перед выбором другой локации.';

  @override
  String get locations_automaticSelection => 'Автоматический выбор';

  @override
  String get locations_cities => 'Города';

  @override
  String get locations_servers => 'Серверы';

  @override
  String locations_viewCities(String name) {
    return 'Посмотреть города в $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Посмотреть серверы в $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count страны',
      many: '$count стран',
      few: '$count страны',
      one: '$count страна',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count города',
      many: '$count городов',
      few: '$count города',
      one: '$count город',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сервера',
      many: '$count серверов',
      few: '$count сервера',
      one: '$count сервер',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Все страны';

  @override
  String get locations_backToCountries => 'Назад к странам';

  @override
  String locations_backToCities(String name) {
    return 'Назад к городам в $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Выбрать $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Выбрать $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Нет доступного совместимого сервера.';

  @override
  String get externalLink_failed =>
      'Не удалось открыть ссылку. Вы можете скопировать её и открыть в браузере.';

  @override
  String get externalLink_copy => 'Скопировать ссылку';

  @override
  String get externalLink_copied => 'Ссылка скопирована';

  @override
  String get externalLink_copyFailed =>
      'Не удалось скопировать ссылку. Выделите адрес ниже.';

  @override
  String get settings_deleteAccount => 'Удалить мой аккаунт';

  @override
  String get settings_deleteAccountDetail =>
      'Посмотреть порядок запроса на удаление аккаунта';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Выберите подписку VPN.';

  @override
  String get billing_subscribe => 'Подписаться';

  @override
  String get billing_choosePlan => 'Выберите план, чтобы продолжить.';

  @override
  String get billing_monthly => 'На месяц';

  @override
  String get billing_yearly => 'На год';

  @override
  String get billing_continue => 'Продолжить через Google Play';

  @override
  String get billing_restore => 'Восстановить покупки';

  @override
  String get billing_manage => 'Управлять подпиской';

  @override
  String get billing_deleteAccountWarning =>
      'Если у вас есть подписка Google Play, удаление аккаунта FuzeVPN не отменяет её продление. Управляйте продлением или отмените его отдельно в Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Перейти к запросу на удаление аккаунта';

  @override
  String get billing_refresh => 'Обновить доступ';

  @override
  String get billing_loadingPlans => 'Загрузка планов…';

  @override
  String get billing_unavailable =>
      'Сейчас нет доступных планов. Попробуйте позже.';

  @override
  String get billing_comingSoon => 'Подписки скоро появятся.';

  @override
  String get billing_priceDisclosure =>
      'Цена предоставлена Google Play. Итоговая сумма подтверждается перед оплатой.';

  @override
  String get billing_renewalMonthly =>
      'Автоматическое продление каждый месяц, если подписка не отменена. Вы можете отменить её в любое время в подписках Google Play.';

  @override
  String get billing_renewalYearly =>
      'Автоматическое продление каждый год, если подписка не отменена. Вы можете отменить её в любое время в подписках Google Play.';

  @override
  String get billing_active => 'Ваш доступ Premium активен';

  @override
  String billing_accessUntil(String date) {
    return 'Доступ до $date.';
  }

  @override
  String get billing_webManaged =>
      'Ваша подписка управляется на сайте FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Ваша подписка управляется через Google Play.';

  @override
  String get billing_inactive => 'Нет активной подписки.';

  @override
  String get billing_checkingAccess => 'Проверка доступа…';

  @override
  String get billing_restoring => 'Восстановление покупок…';

  @override
  String get billing_pending =>
      'Платёж ожидает обработки. Доступ будет активирован после подтверждения.';

  @override
  String get billing_cancelled =>
      'Покупка отменена. Новая подписка не активирована.';

  @override
  String get billing_verifying => 'Проверка покупки…';

  @override
  String get billing_success =>
      'Подписка активирована. Ваш доступ Premium готов.';

  @override
  String get billing_restored => 'Ваши покупки восстановлены.';

  @override
  String get billing_restoreEmpty =>
      'Для этого аккаунта Google Play нет покупок для восстановления.';

  @override
  String get billing_catalogError =>
      'Не удалось загрузить планы. Повторите попытку.';

  @override
  String get billing_purchaseError =>
      'Не удалось начать покупку. Повторите попытку.';

  @override
  String get billing_verificationError =>
      'Проверка покупки временно недоступна. Восстановите покупки, чтобы повторить попытку.';

  @override
  String get billing_restoreError =>
      'Не удалось восстановить покупки. Повторите попытку.';

  @override
  String get billing_managementError =>
      'Не удалось открыть управление подписками. Повторите попытку.';

  @override
  String get billing_storeUnavailable =>
      'Google Play недоступен на этом устройстве.';

  @override
  String get welcome_title => 'Ваш VPN — это просто.';

  @override
  String get welcome_description =>
      'Защитите соединение. Управляйте своей конфиденциальностью.';

  @override
  String get welcome_start => 'Начать';

  @override
  String get welcome_alreadyPurchased => 'Уже купили?';

  @override
  String get welcome_noAccountRequired =>
      'Для начала не нужно создавать аккаунт.';

  @override
  String get guest_accountTitle => 'Аккаунт не привязан';

  @override
  String get guest_accountDescription =>
      'Восстановите покупки через тот же аккаунт Google Play, чтобы пользоваться подпиской на другом устройстве.';

  @override
  String get guest_existingSubscriberSignIn => 'Уже подписаны? Войти';

  @override
  String get guest_claimTitle => 'FuzeVPN всегда с вами';

  @override
  String get guest_claimDescription =>
      'Создайте аккаунт, чтобы пользоваться подпиской на других устройствах. Этот шаг необязателен.';

  @override
  String get guest_skip => 'Позже';

  @override
  String get guest_activationTitle => 'Fuze Premium активен';

  @override
  String get guest_activationDescription =>
      'Подписка готова. Пользуйтесь VPN и создайте аккаунт, когда захотите.';

  @override
  String get guest_useVpn => 'Использовать VPN';

  @override
  String get guest_loginRequired =>
      'Эта покупка уже привязана к аккаунту FuzeVPN. Войдите в него, чтобы получить доступ к подписке.';

  @override
  String get guest_signOutWarning =>
      'Вы можете восстановить подписку, восстановив покупки через тот же аккаунт Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Ваш аккаунт уже привязан. Войдите, чтобы просматривать свои данные и управлять ими.';

  @override
  String get billing_acceptance =>
      'Продолжая, вы принимаете Условия использования и Политику конфиденциальности.';

  @override
  String get guest_verifyEmailReminder =>
      'Подтвердите адрес электронной почты для защиты аккаунта. Вы можете продолжать пользоваться VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Сервис временно недоступен. Повторите попытку чуть позже.';

  @override
  String get guest_restoreError =>
      'Не удалось восстановить покупки. Повторите попытку с аккаунтом Google Play, использованным для покупки.';

  @override
  String get guest_claimSuccess =>
      'Ваш аккаунт создан. Подписка и доступ к VPN сохранены.';

  @override
  String get guest_emailExists =>
      'Этот адрес электронной почты уже используется. Выберите другой адрес или войдите в существующий аккаунт. Покупка остаётся доступной через Google Play.';

  @override
  String get guest_claimError =>
      'Не удалось создать аккаунт. Вы можете продолжать пользоваться VPN и повторить попытку позже.';

  @override
  String get guest_secureStorageError =>
      'Не удалось безопасно сохранить сеанс на этом устройстве. Повторите попытку.';

  @override
  String get guest_premiumRequired =>
      'Выберите подписку, чтобы активировать VPN.';

  @override
  String get welcome_viewPlans => 'Посмотреть тарифы';

  @override
  String get google_continue => 'Продолжить с Google';

  @override
  String get google_or => 'или';

  @override
  String get google_title => 'Ваш аккаунт FuzeVPN';

  @override
  String get google_settingUp => 'Завершите создание аккаунта';

  @override
  String get google_country => 'Страна проживания';

  @override
  String get google_profileDescription =>
      'Выберите страну и ознакомьтесь с двумя документами для создания аккаунта FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Свяжите гостевой аккаунт с Google. Подписка и устройство останутся привязаны к этому аккаунту.';

  @override
  String get google_linkTitle => 'Связать Google с FuzeVPN';

  @override
  String get google_linkDescription =>
      'Подтвердите доступ к существующему аккаунту FuzeVPN. Пароль Google не требуется.';

  @override
  String get google_password => 'Пароль FuzeVPN';

  @override
  String get google_linkAccount => 'Подтвердить привязку';

  @override
  String get google_requestEmail => 'Получить письмо подтверждения';

  @override
  String get google_emailInstructions =>
      'Откройте письмо от FuzeVPN и введите код подтверждения.';

  @override
  String get google_emailCode => 'Код из письма';

  @override
  String get google_confirmEmail => 'Подтвердить код';

  @override
  String get google_restart => 'Выбрать другой аккаунт Google';

  @override
  String get google_resume => 'Проверить эту попытку';

  @override
  String get google_unavailable =>
      'Вход через Google недоступен. Можно использовать почту и пароль.';

  @override
  String get google_expired =>
      'Срок этой попытки истёк. Отмените её и начните снова.';

  @override
  String get google_conflict =>
      'Этот аккаунт Google уже связан с другим аккаунтом. Текущий аккаунт и подписка сохраняются.';

  @override
  String get google_error =>
      'Вход через Google не удался. Повторите попытку; текущий доступ сохраняется.';

  @override
  String get google_uncertain =>
      'Результат не подтверждён. Проверьте эту попытку или отмените её перед повтором.';

  @override
  String get google_cancelFailed =>
      'Отмена не подтверждена. Попробуйте отменить ещё раз перед выходом из этого экрана.';

  @override
  String get google_cancelled => 'Вход через Google отменён.';

  @override
  String get google_selecting => 'Выберите аккаунт Google…';

  @override
  String get google_verifying => 'Проверяем ваш аккаунт…';

  @override
  String get google_emailUnavailable =>
      'Не удалось отправить письмо подтверждения. Попробуйте позже.';

  @override
  String get google_emailSent =>
      'Письмо подтверждения отправлено. Проверьте входящие.';

  @override
  String get google_rateLimited => 'Подождите перед повторной попыткой.';

  @override
  String get google_invalidPassword =>
      'Неверный пароль FuzeVPN. Текущий аккаунт сохраняется.';

  @override
  String get google_invalidCode =>
      'Код подтверждения недействителен или просрочен.';

  @override
  String get google_accountChanged =>
      'Сессия изменилась. Отмените эту попытку перед повтором.';

  @override
  String get google_invalidResponse =>
      'Не удалось проверить ответ. Текущий доступ сохраняется.';

  @override
  String get google_invalidRegistration => 'Проверьте страну и оба согласия.';

  @override
  String get google_consentRequired =>
      'Выберите страну и примите оба документа, чтобы продолжить.';

  @override
  String get google_challengeRequired =>
      'Требуется дополнительная проверка безопасности. Текущий доступ сохраняется.';

  @override
  String get google_challengeUnavailable =>
      'Проверка безопасности недоступна. Попробуйте позже.';
}
