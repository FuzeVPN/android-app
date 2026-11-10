// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Қосылымыңызды қорғаңыз';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN осы құрылғы мен FuzeVPN серверлері арасында шифрланған туннель құру үшін Android жүйесінің VPN қызметін (VpnService) пайдаланады.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN белсенді болған кезде қолданбаларыңыздың интернет трафигі, межелі мекенжайлары және DNS сұраулары қосылымыңызды бағыттау үшін осы туннель арқылы өтеді, тіпті FuzeVPN фондық режимде болса да.';

  @override
  String get vpnDisclosure_statusBody =>
      'Қолданба VPN қосылымыңызды көрсету үшін қосылым күйін, оның ұзақтығын және тасымалданған деректер көлемін пайдаланады. Оны кез келген уақытта тоқтата аласыз.';

  @override
  String get vpnDisclosure_privacy => 'Құпиялылық';

  @override
  String get vpnDisclosure_accept => 'Қабылдап, жалғастыру';

  @override
  String get vpnDisclosure_decline => 'Қазір емес';

  @override
  String get accountRestoration_title => 'Аккаунт уақытша қолжетімсіз';

  @override
  String get accountRestoration_message =>
      'Сеансыңыз сақталды. Аккаунтыңызды қалпына келтіру үшін қайталап көріңіз; VPN қосылымын осы жерде әлі де басқаруға болады.';

  @override
  String get action_retry => 'Қайталау';

  @override
  String get session_endingTitle => 'Сеансты аяқтау';

  @override
  String get session_ending => 'Сеанс аяқталуда: VPN тоқтатылып, тазалануда…';

  @override
  String get session_stopFailed =>
      'VPN тоқтатылғаны расталмады. Қайта кірмес бұрын қайталап көріңіз.';

  @override
  String get session_cleanupFailed =>
      'VPN тоқтатылды, бірақ сеансты өшіру расталмады. Тазалауды қайталап көріңіз.';

  @override
  String get session_retryStop => 'Тоқтатуды қайталау';

  @override
  String get session_retryCleanup => 'Тазалауды қайталау';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN қауіпсіз түрде дайындалуда…';

  @override
  String get nav_connection => 'Қосылым';

  @override
  String get nav_locations => 'Орындар';

  @override
  String get nav_account => 'Аккаунт';

  @override
  String get nav_devices => 'Құрылғылар';

  @override
  String get nav_settings => 'Параметрлер';

  @override
  String get action_refresh => 'Жаңарту';

  @override
  String get auth_tab_login => 'Кіру';

  @override
  String get auth_tab_register => 'Тіркелу';

  @override
  String get auth_stepAccount => 'Аккаунт';

  @override
  String get auth_stepIdentity => 'Жеке деректер';

  @override
  String get auth_stepAddress => 'Мекенжай және келісімдер';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Қадам $current / $total';
  }

  @override
  String get auth_tagline => 'Сіздің VPN — қарапайым әрі оңай.';

  @override
  String get auth_keysLocal => 'Жеке VPN кілттеріңіз осы құрылғыда қалады.';

  @override
  String get form_email => 'Электрондық пошта мекенжайы';

  @override
  String get form_password => 'Құпия сөз';

  @override
  String get form_showPassword => 'Құпия сөзді көрсету';

  @override
  String get form_hidePassword => 'Құпия сөзді жасыру';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 байт. Кейбір таңбалар бірнеше байт алады.';

  @override
  String get form_firstName => 'Аты';

  @override
  String get form_lastName => 'Тегі';

  @override
  String get form_phone => 'Телефон (+33612345678)';

  @override
  String get form_address => 'Мекенжай';

  @override
  String get form_address2 => 'Мекенжай, 2-жол (міндетті емес)';

  @override
  String get form_postalCode => 'Пошта индексі';

  @override
  String get form_city => 'Қала';

  @override
  String get form_country => 'Ел коды (мысалы, FR)';

  @override
  String get action_login => 'Кіру';

  @override
  String get action_createAccount => 'Аккаунт жасау';

  @override
  String get action_createMyAccount => 'Аккаунтымды жасау';

  @override
  String get action_next => 'Жалғастыру';

  @override
  String get action_previous => 'Артқа';

  @override
  String get action_forgotPassword => 'Құпия сөзді ұмыттыңыз ба?';

  @override
  String get auth_noAccount => 'Әлі аккаунтыңыз жоқ па?';

  @override
  String get auth_requiredInformation => 'Аккаунтыңызды үш қадамда жасаңыз.';

  @override
  String get auth_termsPrefix => 'Мен келісемін: ';

  @override
  String get auth_termsLink => 'пайдалану шарттары';

  @override
  String get auth_privacyPrefix => 'Мен келісемін: ';

  @override
  String get auth_privacyLink => 'құпиялылық саясаты';

  @override
  String get auth_consentRequired => 'Аккаунт жасау үшін келісіміңіз қажет.';

  @override
  String get validation_required => 'Бұл өріс міндетті.';

  @override
  String get validation_email =>
      'Жарамды электрондық пошта мекенжайын енгізіңіз.';

  @override
  String get validation_password =>
      'Құпия сөз тым қысқа: кемінде 8 UTF-8 байт болуы керек.';

  @override
  String get validation_passwordTooLong =>
      'Құпия сөз тым ұзын: ең көбі 72 UTF-8 байт болуы керек.';

  @override
  String get validation_phone =>
      'Халықаралық пішімді пайдаланыңыз, мысалы, +33612345678.';

  @override
  String get validation_country =>
      'Екі әріптен тұратын ел кодын пайдаланыңыз, мысалы, FR.';

  @override
  String get passwordReset_title => 'Құпия сөзді қалпына келтіру';

  @override
  String get passwordReset_description =>
      'Құпия сөзді қалпына келтіру сілтемесін сұрау үшін аккаунтыңыздың электрондық пошта мекенжайын енгізіңіз.';

  @override
  String get passwordReset_send => 'Сілтемені жіберу';

  @override
  String get connection_title => 'Қосылымыңыз';

  @override
  String get connection_subtitle =>
      'Орынды таңдаңыз, содан кейін VPN-ді қосыңыз.';

  @override
  String get connection_prepare => 'Қосылуға дайынсыз ба?';

  @override
  String get connection_advancedOptions => 'Қосымша параметрлер';

  @override
  String get connection_location => 'Орын';

  @override
  String get connection_chooseLocation => 'Орынды таңдаңыз';

  @override
  String get connection_protocol => 'Протокол';

  @override
  String get connection_connect => 'Қосылу';

  @override
  String get connection_connecting => 'Қосылып жатыр…';

  @override
  String get connection_disconnect => 'Ажырату';

  @override
  String get connection_disconnecting => 'Ажыратылып жатыр';

  @override
  String get connection_locationChange => 'Орын өзгертілуде…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol қолжетімсіз';
  }

  @override
  String get connection_activeLocation => 'Белсенді орын';

  @override
  String get connection_duration => 'Ұзақтығы';

  @override
  String get connection_received => 'Қабылданған';

  @override
  String get connection_sent => 'Жіберілген';

  @override
  String get connection_lastHandshake => 'Соңғы қауіпсіз алмасу';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration бұрын';
  }

  @override
  String get verification_title => 'Электрондық пошта мекенжайыңызды растаңыз';

  @override
  String get verification_message =>
      'Осы телефонда VPN-ді пайдалану үшін электрондық пошта мекенжайыңызды растаңыз.';

  @override
  String get verification_resend => 'Хатты қайта жіберу';

  @override
  String get migration_title => 'Орынды өзгерту';

  @override
  String get migration_draining => 'Орынды өзгертуге дайындалуда…';

  @override
  String get migration_activating => 'Жаңа сервер іске қосылуда…';

  @override
  String get migration_ready => 'Орын жаңартылды.';

  @override
  String get migration_blocked =>
      'Орынды өзгерту үшін сервер тарапынан араласу қажет. Кейінірек қайталап көріңіз немесе қолдау қызметіне хабарласыңыз.';

  @override
  String get migration_progress => 'Орынды өзгерту барысы';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Тексерулер арасындағы кідіріс: $seconds с.';
  }

  @override
  String get migration_resume => 'Орынды өзгертуді жалғастыру';

  @override
  String get status_authorizing => 'Рұқсат қажет';

  @override
  String get status_authorizingDetail =>
      'VPN-ге рұқсат беру үшін Android сұрауын қабылдаңыз.';

  @override
  String get status_preparing => 'Дайындалуда';

  @override
  String get status_preparingDetail => 'Қауіпсіз қосылымыңыз дайындалуда.';

  @override
  String get status_reconnecting => 'Қайта қосылуда…';

  @override
  String get status_reconnectingDetail =>
      'Қосылым үзілді. VPN қайта қосылуға тырысуда.';

  @override
  String get status_connecting => 'Қосылып жатыр';

  @override
  String get status_connectingDetail => 'VPN серверіне қосылып жатыр…';

  @override
  String get status_connected => 'Қосылды';

  @override
  String get status_connectedDetail => 'VPN қосылымыңыз белсенді.';

  @override
  String get status_disconnecting => 'Ажыратылып жатыр';

  @override
  String get status_disconnectingDetail => 'VPN қосылымыңыз тоқтатылып жатыр.';

  @override
  String get status_error => 'Қосылым қолжетімсіз';

  @override
  String get status_errorDetail => 'VPN қосылымы расталмады. Қайталап көріңіз.';

  @override
  String get status_idle => 'Ажыратылды';

  @override
  String get status_idleDetail => 'Қосылымыңызды қорғау үшін VPN-ді қосыңыз.';

  @override
  String get trust_note =>
      'Қолданбаны жапқан кезде VPN тоқтамайды. Оны тоқтату үшін Ажырату түймесін пайдаланыңыз.';

  @override
  String get locations_none => 'Қазір қолжетімді орындар жоқ.';

  @override
  String get locations_available => 'Келесі орныңызды таңдаңыз.';

  @override
  String get locations_selected => 'Таңдалған орын';

  @override
  String get locations_select => 'Осы орынды таңдау';

  @override
  String get locations_lockedTunnel => 'Орынды өзгерту үшін VPN-ді ажыратыңыз.';

  @override
  String get locations_lockedMigration => 'Орынды өзгерту аяқталғанша күтіңіз.';

  @override
  String get devices_title => 'Құрылғыларыңыз';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit құрылғы';
  }

  @override
  String get devices_refresh => 'Құрылғыларды жаңарту';

  @override
  String get devices_empty => 'Әлі VPN құрылғысы тіркелмеген.';

  @override
  String get devices_firstConnection =>
      'Телефоныңыз алғашқы қосылым кезінде тізімге қосылады.';

  @override
  String get devices_thisDevice => 'Осы құрылғы';

  @override
  String devices_added(Object date) {
    return '$date күні қосылған';
  }

  @override
  String get devices_unnamed => 'Атаусыз құрылғы';

  @override
  String get action_remove => 'Алып тастау';

  @override
  String get settings_title => 'Параметрлер';

  @override
  String get settings_subtitle => 'Параметрлеріңіз бен аккаунтыңыз бір жерде.';

  @override
  String get settings_appearance => 'Сыртқы түрі';

  @override
  String get settings_language => 'Тіл';

  @override
  String get settings_languageDescription =>
      'Таңдаған тіліңіз VPN хабарландыруларына да қолданылады.';

  @override
  String get settings_account => 'Аккаунт';

  @override
  String get settings_signOut => 'Шығу';

  @override
  String get settings_privacy => 'Құпиялылық саясаты';

  @override
  String get settings_terms => 'Пайдалану шарттары';

  @override
  String get settings_security => 'Қауіпсіздік және ашықтық';

  @override
  String get settings_licenses => 'Компоненттер лицензиялары';

  @override
  String get settings_licensesDetail =>
      'Қолданбада пайдаланылатын бағдарламалық жасақтама';

  @override
  String settings_licensesLegalese(String url) {
    return 'Қолданба мен оның MPL-2.0 компоненттерінің бастапқы коды: $url';
  }

  @override
  String get settings_background =>
      'Қолданбадан шыққан кезде VPN қосулы күйінде қалады. Оны тоқтату үшін Қосылым қойындысындағы Ажырату түймесін пайдаланыңыз.';

  @override
  String get theme_system => 'Жүйелік';

  @override
  String get theme_light => 'Ашық';

  @override
  String get theme_dark => 'Қараңғы';

  @override
  String get language_system => 'Телефон тілі';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Осы құрылғыны алып тастайсыз ба?';

  @override
  String get dialog_removeCurrent =>
      'Бұл телефон VPN-нен ажырап, қолжетімділігін жоғалтады. Оның VPN қосылымының деректері сервер растағаннан кейін өшіріледі.';

  @override
  String dialog_removeOther(Object name) {
    return '«$name» құрылғысының VPN қолжетімділігі жойылады. Бұл әрекетті болдырмау мүмкін емес.';
  }

  @override
  String get dialog_signOut => 'Аккаунттан шығасыз ба?';

  @override
  String get dialog_signOutMessage =>
      'VPN тоқтайды, ал аккаунтыңызға қайтадан кіру қажет болады. Шифрланған VPN кілттеріңіз келесі қосылым үшін осы телефонда сақталады.';

  @override
  String get action_cancel => 'Бас тарту';

  @override
  String get action_close => 'Жабу';

  @override
  String get action_copy => 'Көшіру';

  @override
  String get action_signOut => 'Шығу';

  @override
  String get notice_close => 'Хабарламаны жабу';

  @override
  String get notice_sessionExpired_title => 'Сеанс мерзімі аяқталды';

  @override
  String get notice_sessionExpired_message =>
      'Сеансыңыздың мерзімі аяқталды. Қайтадан кіріңіз.';

  @override
  String get notice_connectionFailed_title => 'Қосылым орнатылмады';

  @override
  String get notice_invalidCredentials_message =>
      'Электрондық пошта мекенжайы немесе құпия сөз дұрыс емес.';

  @override
  String get notice_emailVerification_title =>
      'Электрондық поштаны растау қажет';

  @override
  String get notice_emailVerification_message =>
      'VPN құрылғысын қосар алдында электрондық пошта мекенжайыңызды растаңыз.';

  @override
  String get notice_rateLimited_title => 'Тым көп әрекет жасалды';

  @override
  String get notice_deviceLimit_title => 'Құрылғы шегіне жетті';

  @override
  String get notice_deviceLimit_message =>
      'Басқа құрылғы қосар алдында бар құрылғыны алып тастаңыз.';

  @override
  String get notice_identityRenewal_title =>
      'VPN сәйкестендіруін жаңарту қажет';

  @override
  String get notice_identityRenewal_message =>
      'Бұл сәйкестендіру жойылды. Жаңа жергілікті сәйкестендіру жасаңыз.';

  @override
  String get notice_migrationPending_title => 'Орынды өзгерту жүріп жатыр';

  @override
  String get notice_migrationPending_message =>
      'Орынды өзгерту қазірдің өзінде жүріп жатыр.';

  @override
  String get notice_migrationBlocked_title => 'Орынды өзгерту бұғатталды';

  @override
  String get notice_migrationBlocked_message =>
      'Орынды өзгерту үшін сервер тарапынан араласу қажет. Кейінірек қайталап көріңіз немесе қолдау қызметіне хабарласыңыз.';

  @override
  String get notice_targetUnavailable_title => 'Сервер уақытша қолжетімсіз';

  @override
  String get notice_targetUnavailable_message =>
      'Бұл сервер уақытша қолжетімсіз.';

  @override
  String get notice_networkUnavailable_title => 'Интернет қосылымы қолжетімсіз';

  @override
  String get notice_networkUnavailable_message =>
      'Қосылымыңызды тексеріп, қайталап көріңіз.';

  @override
  String get notice_permissionDenied_title => 'VPN рұқсаты берілмеді';

  @override
  String get notice_permissionDenied_message =>
      'Қосылымды қайтадан бастап, Android рұқсат сұрауын қабылдаңыз.';

  @override
  String get notice_wireguardTimeout_title => 'Сервер жауап бермейді';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard қосылымы тым ұзаққа созылды. Қайталап көріңіз немесе басқа орынды таңдаңыз.';

  @override
  String get notice_tlsFailed_title => 'Қауіпсіз қосылым қабылданбады';

  @override
  String get notice_tlsFailed_message =>
      'Сервер OpenVPN қосылымын қабылдамады. Қайталап көріңіз. Мәселе сақталса, диагностиканы іске қосыңыз.';

  @override
  String get notice_tunRejected_title => 'Android VPN интерфейсін қабылдамады';

  @override
  String get notice_tunRejected_message =>
      'Android OpenVPN сұраған желі конфигурациясын қабылдамады.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN іске қосылмады';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN қозғалтқышын толық іске қосу мүмкін болмады. Қайталап көріңіз. Мәселе сақталса, қолдау қызметіне хабарласыңыз.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Диагностика коды: $code';
  }

  @override
  String get notice_generic_title => 'VPN қосылымы орнатылмады';

  @override
  String get notice_generic_message =>
      'Қате орын алды. Кейінірек қайталап көріңіз.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Аккаунт жасалды',
      'password_reset_sent': 'Құпия сөзді қалпына келтіру сұрауы қабылданды',
      'verification_email_sent': 'Растау хаты жіберілді',
      'location_migration_pending': 'Орынды өзгерту жүріп жатыр',
      'vpn_sign_in_required': 'Кіру қажет',
      'protocol_unavailable_at_location': 'Протокол қолжетімсіз',
      'vpn_permission_denied': 'VPN рұқсаты берілмеді',
      'revoked_identity_device_limit': 'Құрылғы шегіне жетті',
      'tunnel_start_unexpected': 'VPN іске қосылмады',
      'flutter_disconnect_timeout': 'Ажырату расталмады',
      'flutter_disconnect_unexpected': 'Ажырату мүмкін болмады',
      'device_revoked': 'Құрылғы алынып тасталды',
      'revoke_unexpected': 'Құрылғыны алып тастау мүмкін болмады',
      'identity_renewal_unexpected': 'Сәйкестендіруді жаңарту мүмкін болмады',
      'openvpn_renewal_unexpected': 'OpenVPN-ді жаңарту мүмкін болмады',
      'location_migration_blocked': 'Орынды өзгерту бұғатталды',
      'location_migration_slow': 'Орынды өзгерту әлі жүріп жатыр',
      'location_migration_conflict': 'Орынды өзгертуді жаңарту қажет',
      'location_migration_verification_failed': 'Орынды өзгерту расталмады',
      'location_migration_device_changed':
          'Орынды өзгерту кезінде құрылғы өзгерді',
      'tunnel_stop_failed': 'Орынды өзгерту қолжетімсіз',
      'device_clock_ahead': 'Құрылғы уақыты алға кеткен',
      'other': 'Операция орындалмады',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Аккаунт жасалды, бірақ растау хатын жіберу мүмкін болмады. Қолданбадағы «Хатты қайта жіберу» түймесін пайдаланыңыз.',
      'password_reset_sent':
          'Сұрауыңыз қабылданды. Осы мекенжайға сәйкес аккаунт болса, хат келуі мүмкін. «Спам» қалтасын да тексеріңіз.',
      'verification_email_sent': 'Жаңа растау хаты жіберілді.',
      'location_migration_pending':
          'Мына орынға көшу әлі дайындалуда: $target. Құрылғыны қайта жасамай-ақ жалғастыра аласыз.',
      'vpn_sign_in_required': 'VPN-ді іске қоспас бұрын аккаунтыңызға кіріңіз.',
      'protocol_unavailable_at_location':
          'Таңдалған протокол бұл орында ұсынылмайды. Орындарды жаңартыңыз немесе басқа протоколды таңдаңыз.',
      'vpn_permission_denied':
          'Android VPN рұқсатын бермеді. Қосылымды қайтадан бастап, жүйелік сұрауды қабылдаңыз.',
      'revoked_identity_device_limit':
          'Осы құрылғының VPN қолжетімділігі жойылды және құрылғы шегіне жетті. Аккаунт → Құрылғыларымды басқару бөлімінен бір құрылғыны алып тастаңыз.',
      'tunnel_start_unexpected':
          'Күтпеген қате туннельді дайындауды үзді. Диагностика кодын тексеріп, қайталап көріңіз.',
      'flutter_disconnect_timeout':
          'Android VPN-нің уақытында тоқтағанын растамады. Оны қайтадан тоқтатып көріңіз.',
      'flutter_disconnect_unexpected':
          'Күтпеген қате туннельдің тоқтағанын растауға кедергі болды.',
      'device_revoked':
          'Құрылғының VPN қолжетімділігі жойылды, оның жергілікті құпия деректері өшірілді.',
      'revoke_unexpected':
          'Құрылғыны алып тастау мүмкін болмады. Тізімді жаңартып, қайталап көріңіз.',
      'identity_renewal_unexpected':
          'Жаңа VPN сәйкестендіруін жасау мүмкін болмады. Құрылғыларды жаңартып, қайталап көріңіз.',
      'openvpn_renewal_unexpected':
          'OpenVPN профилін жаңарту мүмкін болмады. Қайталап көріңіз немесе диагностика кодын тексеріңіз.',
      'location_migration_blocked':
          'Сервер бұл өзгерісті қазір аяқтай алмайды. Құрылғы мен оның жергілікті сәйкестендіруі сақталды.',
      'location_migration_slow':
          'Сервер мына орынға көшуді әлі дайындап жатыр: $target. Біраз уақыттан кейін «Орынды өзгертуді жалғастыру» түймесін пайдаланыңыз.',
      'location_migration_conflict':
          'Құрылғы күйі серверде өзгерді. Құрылғыларды жаңартып, өзгерісті жалғастырыңыз.',
      'location_migration_verification_failed':
          'Сервер жаңа орынды растамады. Бұрынғы жергілікті сәйкестендіру сақталды.',
      'location_migration_device_changed':
          'Сервер қайтарған құрылғы өзгертіліп жатқан құрылғыға сәйкес емес. Қайталап көрмес бұрын құрылғыларды жаңартыңыз.',
      'tunnel_stop_failed':
          'Жаңа қосылымға дейін алдыңғы туннель толық тоқтатылуы керек.',
      'device_clock_ahead':
          'Бұл құрылғының уақыты алға кеткен сияқты. Аккаунттан шығып қалмау үшін күн мен уақытты автоматты түрде орнатуды қосыңыз.',
      'other':
          'Операцияны аяқтау мүмкін болмады. Қайталап көріңіз немесе диагностика кодын қолдау қызметіне жіберіңіз.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Сеанс мерзімі аяқталды',
      'invalid_credentials': 'Кіру сәтсіз аяқталды',
      'email_verification_required': 'Электрондық поштаны растау қажет',
      'verification_email_cooldown': 'Хат бұрын жіберілген',
      'rate_limited': 'Тым көп әрекет жасалды',
      'invalid_registration': 'Ақпаратты түзету қажет',
      'email_exists': 'Аккаунт бұрыннан бар',
      'invalid_profile': 'Профиль жарамсыз',
      'invalid_device': 'Құрылғы жарамсыз',
      'invalid_location': 'Орын қолжетімсіз',
      'device_limit': 'Құрылғы шегіне жетті',
      'device_exists': 'VPN сәйкестендіруі қолданыста',
      'device_identity_revoked': 'VPN сәйкестендіруін жаңарту қажет',
      'device_location_locked': 'Орынды өзгертуді жаңарту қажет',
      'location_migration_pending': 'Орынды өзгерту жүріп жатыр',
      'location_migration_blocked': 'Орынды өзгерту бұғатталды',
      'target_ca_mismatch': 'OpenVPN сервері үйлесімсіз',
      'location_migration_conflict': 'Орынды өзгертуді жаңарту қажет',
      'server_full': 'Сервер толы',
      'capacity_unavailable': 'Орын уақытша қолжетімсіз',
      'target_unavailable': 'Сервер уақытша қолжетімсіз',
      'not_found': 'Элемент табылмады',
      'invalid_openvpn_csr': 'OpenVPN сәйкестендіруі жарамсыз',
      'openvpn_profile_exists': 'OpenVPN профилі бұрыннан бар',
      'openvpn_profile_revoked': 'OpenVPN профилінің күші жойылды',
      'openvpn_operation_pending': 'OpenVPN операциясы орындалуда',
      'openvpn_operation_terminal': 'OpenVPN операциясы үзілді',
      'openvpn_address_unavailable': 'OpenVPN мекенжайы қолжетімсіз',
      'openvpn_profile_conflict': 'OpenVPN қақтығысы',
      'openvpn_signer_unavailable': 'OpenVPN қолжетімсіз',
      'email_delivery_unavailable': 'Электрондық пошта қолжетімсіз',
      'invalid_token': 'Сілтеме жарамсыз',
      'network_unavailable': 'Интернет қосылымы қолжетімсіз',
      'invalid_json': 'Сұрау жарамсыз',
      'invalid_api_response': 'Сервердің жауабы жарамсыз',
      'ipv6_unavailable': 'IPv6 қолжетімсіз',
      'invalid_ip_families': 'Желі конфигурациясы қабылданбады',
      'other': 'Қызмет қолжетімсіз',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Сеансыңыздың мерзімі аяқталды. Қайтадан кіріңіз.',
      'invalid_credentials':
          'Электрондық пошта мекенжайы немесе құпия сөз дұрыс емес.',
      'email_verification_required':
          'VPN құрылғысын қосар алдында электрондық пошта мекенжайыңызды растаңыз.',
      'invalid_registration':
          'Сұралған ақпаратты және келісімдерді тексеріңіз.',
      'email_exists':
          'Бұл электрондық пошта мекенжайымен аккаунт бұрыннан бар.',
      'invalid_profile': 'Профиль ақпаратын тексеріңіз.',
      'invalid_device':
          'Осы құрылғының атауы немесе жергілікті сәйкестендіруі жарамсыз.',
      'invalid_location': 'Орындар тізімін жаңартып, қайталап көріңіз.',
      'device_limit': 'Жаңа құрылғы қосар алдында бар құрылғыны алып тастаңыз.',
      'device_exists':
          'Бұл VPN сәйкестендіруі басқа аккаунтқа байланыстырылған.',
      'device_identity_revoked':
          'Бұл сәйкестендіру жойылды. Жаңа жергілікті сәйкестендіру жасалуы қажет.',
      'device_location_locked':
          'Осы құрылғының орны жаңа ғана өзгерді. Қолданба орындалып жатқан өзгерісті жалғастырады.',
      'location_migration_pending':
          'Орынды өзгерту қазірдің өзінде жүріп жатыр.',
      'location_migration_blocked':
          'Орынды өзгерту үшін сервер тарапынан араласу қажет. Кейінірек қайталап көріңіз немесе қолдау қызметіне хабарласыңыз.',
      'target_ca_mismatch':
          'Бұл сервер ағымдағы OpenVPN профилімен әлі үйлеспейді.',
      'location_migration_conflict':
          'Құрылғылар тізімін жаңартып, орынды өзгертуді қайталап көріңіз.',
      'server_full':
          'Бұл орын қосылымдар шегіне жетті. Басқа орынды таңдаңыз немесе кейінірек қайталап көріңіз.',
      'capacity_unavailable':
          'Бұл орынның қазір қолжетімді екенін растай алмаймыз. Басқа орынды таңдаңыз немесе кейінірек қайталап көріңіз.',
      'target_unavailable': 'Бұл сервер уақытша қолжетімсіз.',
      'not_found': 'Бұл элемент енді аккаунтыңызда қолжетімсіз.',
      'invalid_openvpn_csr':
          'Жаңа OpenVPN сәйкестендіруін жасап, қайталап көріңіз.',
      'openvpn_profile_exists':
          'Бұл құрылғы үшін OpenVPN профилі бұрыннан бар.',
      'openvpn_profile_revoked': 'Жалғастыру үшін OpenVPN профилін жаңартыңыз.',
      'openvpn_operation_pending':
          'Өзгеріс әлі таралып жатыр. Кейінірек қайталап көріңіз.',
      'openvpn_operation_terminal':
          'Жаңа OpenVPN сәйкестендіруін жасап, қайталап көріңіз.',
      'openvpn_address_unavailable': 'Қазір қолжетімді OpenVPN мекенжайы жоқ.',
      'openvpn_profile_conflict':
          'Профиль өзгерді. Құрылғылар тізімін жаңартып, қайталап көріңіз.',
      'openvpn_signer_unavailable': 'OpenVPN қызметі уақытша қолжетімсіз.',
      'email_delivery_unavailable':
          'Хатты жіберу мүмкін болмады. Кейінірек қайталап көріңіз.',
      'invalid_token':
          'Бұл сілтеме жарамсыз немесе мерзімі аяқталды. Жаңасын сұраңыз.',
      'network_unavailable': 'Интернет қосылымын тексеріп, қайталап көріңіз.',
      'invalid_json': 'Енгізілген ақпаратты тексеріп, қайталап көріңіз.',
      'invalid_api_response':
          'Сервер күтпеген жауап қайтарды. Кейінірек қайталап көріңіз.',
      'ipv6_unavailable':
          'Сервер қазір IPv6 протоколын белсендіре алмайды. Кейінірек қайталап көріңіз.',
      'invalid_ip_families':
          'Туннель конфигурациясы толық емес немесе рұқсат етілген мекенжайларға сәйкес келмейді. Қолданбадан қайталап көріңіз.',
      'other': 'Сервер қатесі орын алды. Кейінірек қайталап көріңіз.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Бірнеше сәттен кейін қайталап көріңіз.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds секундтан кейін қайталап көріңіз.',
      one: '$seconds секундтан кейін қайталап көріңіз.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes минуттан кейін қайталап көріңіз.',
      one: '$minutes минуттан кейін қайталап көріңіз.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours сағаттан кейін қайталап көріңіз.',
      one: '$hours сағаттан кейін қайталап көріңіз.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Жүйелік VPN жалғастыру мүмкін емес',
      'system_vpn_resume_corrupt': 'Жүйелік VPN жалғастыру жарамсыз',
      'system_vpn_resume_session_invalid': 'VPN жалғастыру сеансы жарамсыз',
      'system_vpn_resume_identity_changed': 'VPN сәйкестендіруі өзгерді',
      'system_vpn_resume_identity_invalid':
          'VPN жалғастыру сәйкестендіруі жарамсыз',
      'system_vpn_resume_storage_failed':
          'VPN жалғастыру деректерін сақтау қолжетімсіз',
      'system_vpn_resume_network_timeout': 'VPN жалғастыру үшін желі жоқ',
      'system_vpn_resume_blocked': 'VPN жалғастыру бұғатталды',
      'system_vpn_resume_failed': 'VPN жалғастыру сәтсіз аяқталды',
      'system_vpn_resume_error_invalid': 'VPN жалғастыру қатесі жарамсыз',
      'wireguard_identity_store_failed': 'WireGuard сәйкестендіруі сақталмады',
      'wireguard_identity_unavailable': 'WireGuard сәйкестендіруі қолжетімсіз',
      'vpn_host_destroyed': 'Android VPN компоненті тоқтатылды',
      'vpn_host_unavailable': 'Android VPN компоненті қолжетімсіз',
      'vpn_permission_required': 'VPN рұқсаты қажет',
      'vpn_permission_denied': 'VPN рұқсаты берілмеді',
      'vpn_permission_request_failed': 'Рұқсат сұрау мүмкін болмады',
      'wireguard_foreground_service_unavailable':
          'WireGuard қызметі қолжетімсіз',
      'wireguard_identity_invalid': 'Жергілікті WireGuard кілті жарамсыз',
      'wireguard_identity_in_use': 'WireGuard сәйкестендіруі қолданыста',
      'wireguard_configuration_invalid': 'WireGuard конфигурациясы жарамсыз',
      'wireguard_operation_pending': 'WireGuard әрекеті әлі орындалуда',
      'wireguard_start_failed': 'WireGuard іске қосу қабылданбады',
      'wireguard_stop_timeout': 'WireGuard тоқтатылуы расталмады',
      'wireguard_handshake_timeout': 'WireGuard жауап бермеді',
      'openvpn_connection_timeout': 'OpenVPN жауап бермеді',
      'openvpn_core_unavailable': 'OpenVPN қозғалтқышы қолжетімсіз',
      'openvpn_operation_pending': 'OpenVPN сеансы әлі белсенді',
      'openvpn_stop_timeout': 'OpenVPN тоқтатылуы расталмады',
      'openvpn_profile_unavailable': 'Жергілікті OpenVPN профилі жоқ',
      'openvpn_native_failed': 'OpenVPN шақыруы үзілді',
      'openvpn_key_generation_failed':
          'OpenVPN P-256 кілтін жасау мүмкін болмады',
      'openvpn_csr_generation_failed': 'OpenVPN CSR жасау мүмкін болмады',
      'openvpn_identity_store_failed': 'OpenVPN сәйкестендіруі сақталмады',
      'openvpn_identity_clear_failed': 'OpenVPN толық жойылмады',
      'openvpn_identity_in_use': 'OpenVPN сәйкестендіруі әлі қолданыста',
      'openvpn_tls_verification_required': 'OpenVPN TLS тексеруі жоқ',
      'openvpn_cipher_invalid': 'OpenVPN шифрі жарамсыз',
      'openvpn_profile_rejected': 'OpenVPN профилі қабылданбады',
      'openvpn_identity_inconsistent': 'OpenVPN сәйкестендіруі үйлеспейді',
      'tls_handshake_failed': 'OpenVPN келіссөзі қабылданбады',
      'tls_alert_unknown_ca': 'OpenVPN клиент сертификаты танылмады',
      'tls_alert_bad_certificate': 'OpenVPN клиент сертификаты қабылданбады',
      'tls_alert_unsupported_certificate':
          'Қолдау көрсетілмейтін OpenVPN сертификаты',
      'tls_client_certificate_required': 'OpenVPN клиент сертификаты қажет',
      'tls_alert_misc': 'OpenVPN TLS ескертуі',
      'tls_signature_algorithm_rejected':
          'Қолдау көрсетілмейтін OpenVPN қолтаңбасы',
      'tls_handshake_rejected': 'OpenVPN TLS келіссөзі қабылданбады',
      'tls_version_rejected': 'OpenVPN TLS нұсқасы сәйкес келмейді',
      'tls_certificate_expired': 'TLS сертификатының мерзімі аяқталды',
      'tls_certificate_revoked': 'TLS сертификатының күші жойылды',
      'transport_failed': 'OpenVPN сервері қолжетімсіз',
      'tun_configuration_rejected': 'OpenVPN интерфейсін жасау мүмкін болмады',
      'tun_setup_failed': 'OpenVPN TUN орнату сәтсіз аяқталды',
      'tun_interface_create_failed':
          'OpenVPN интерфейсін жасау сәтсіз аяқталды',
      'tun_interface_disabled': 'OpenVPN интерфейсі өшірілді',
      'tun_halted': 'OpenVPN интерфейсі үзілді',
      'tun_already_established': 'OpenVPN интерфейсі қазірдің өзінде ашық',
      'tun_addresses_missing': 'OpenVPN мекенжайы жоқ',
      'tun_routes_missing': 'OpenVPN бағыттары жоқ',
      'tun_dns_missing': 'OpenVPN DNS жоқ',
      'tun_permission_revoked': 'VPN рұқсаты қайтарып алынды',
      'tun_establish_returned_null': 'Android VPN интерфейсін қабылдамады',
      'openvpn_service_start_failed': 'OpenVPN қызметі қолжетімсіз',
      'openvpn_operation_timeout': 'OpenVPN шақыруының күту уақыты аяқталды',
      'openvpn_start_failed': 'OpenVPN іске қосу қабылданбады',
      'openvpn_connection_failed': 'OpenVPN қосылымы үзілді',
      'openvpn_core_status_error': 'OpenVPN қозғалтқышықатемен аяқталды',
      'openvpn_stopped_before_connected': 'OpenVPN қосылмай тұрып тоқтады',
      'openvpn_auth_failed': 'OpenVPN аутентификациясы қабылданбады',
      'openvpn_client_setup_failed': 'OpenVPN клиентін орнату сәтсіз аяқталды',
      'openvpn_client_halted': 'OpenVPN клиенті үзілді',
      'openvpn_client_restart': 'OpenVPN қайта іске қосу сұралды',
      'openvpn_inactive_timeout': 'OpenVPN тым ұзақ белсенді емес',
      'openvpn_session_expired': 'OpenVPN сеансының мерзімі аяқталды',
      'openvpn_credentials_required':
          'Қолдау көрсетілмейтін OpenVPN аутентификациясы',
      'openvpn_proxy_failed': 'OpenVPN аралық қосылымы сәтсіз',
      'openvpn_compression_failed': 'OpenVPN сығымдауы қабылданбады',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM шифрлауы қолжетімсіз',
      'openvpn_feature_unsupported': 'Қолдау көрсетілмейтін OpenVPN мүмкіндігі',
      'network_unavailable': 'Интернет қосылымы қолжетімсіз',
      'network_lost': 'Желі қолжетімсіз',
      'certificate_validation_failed': 'Сервер сертификаты қабылданбады',
      'openvpn_certificate_expired': 'OpenVPN сертификатының мерзімі аяқталды',
      'tunnel_active_for_another_account':
          'Басқа аккаунттың туннелі әлі белсенді',
      'tunnel_already_active': 'Туннель қазірдің өзінде белсенді',
      'tunnel_stop_timeout': '$protocol тоқтатылуы расталмады',
      'tunnel_disconnected': '$protocol үзілді',
      'native_bridge_unavailable': 'Android көпірі қолжетімсіз',
      'native_operation_failed': 'Android операциясы үзілді',
      'invalid_arguments': 'VPN параметрлері толық емес',
      'invalid_account_id': 'VPN аккаунты жарамсыз',
      'invalid_device_id': 'Құрылғы идентификаторы жарамсыз',
      'storage_key_not_allowed': 'Сақтау кілті қабылданбады',
      'secure_storage_read_failed': 'Қауіпсіз оқу сәтсіз аяқталды',
      'secure_storage_write_failed': 'Қауіпсіз жазу сәтсіз аяқталды',
      'key_generation_failed': 'WireGuard кілтін жасау мүмкін болмады',
      'csr_generation_failed': 'OpenVPN CSR жасау мүмкін болмады',
      'openvpn_recovery_exhausted':
          'OpenVPN қалпына келтіру қазірдің өзінде пайдаланылды',
      'openvpn_recovery_failed': 'OpenVPN қалпына келтіру сәтсіз аяқталды',
      'openvpn_renewal_required': 'OpenVPN сертификатын жаңарту қажет',
      'other': 'Жіктелмеген VPN қатесі',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android жалғастыруға болатын VPN сеансын таппады. Қолданбада жаңа қосылымды бастаңыз.',
      'system_vpn_resume_corrupt':
          'Сақталған VPN жалғастыру деректері жарамсыз, сондықтан пайдаланылмайды. Жаңа қосылымды бастаңыз.',
      'system_vpn_resume_session_invalid':
          'Сақталған сеанс енді VPN-ді жалғастыра алмайды. Қолданбаға қайта кіріңіз.',
      'system_vpn_resume_identity_changed':
          'Жергілікті VPN сәйкестендіруі өзгерді. Жалғастыру тоқтатылды; жаңа қосылымды бастаңыз.',
      'system_vpn_resume_identity_invalid':
          'Жалғастыруға арналған сәйкестендіру жарамсыз. Жаңа қосылымды бастаңыз.',
      'system_vpn_resume_storage_failed':
          'Android шифрланған жалғастыру деректерін оқи немесе жаңарта алмады. Жаңа қосылымды бастаңыз.',
      'system_vpn_resume_network_timeout':
          'Android VPN-ді жалғастыру үшін уақтылы желі таппады. Желі қолжетімді болғанда қайталап көріңіз.',
      'system_vpn_resume_blocked':
          'VPN жалғастыру бұғатталды. Android параметрлерін тексеріңіз, содан кейін жаңа қосылымды бастаңыз.',
      'system_vpn_resume_failed':
          'Android VPN жалғастыру сәтсіз аяқталды. Қолданбада жаңа қосылымды бастаңыз.',
      'system_vpn_resume_error_invalid':
          'Android жарамсыз жалғастыру қатесін қайтарды. Жаңа қосылымды бастаңыз.',
      'wireguard_identity_store_failed':
          'Android осы аккаунттың шифрланған WireGuard сәйкестендіруін сақтай алмады.',
      'wireguard_identity_unavailable':
          'Бұл қосылым үшін пайдалануға болатын WireGuard сәйкестендіруі жоқ.',
      'vpn_host_destroyed':
          'VPN-ді қамтитын Android компоненті тоқтатылды. Жаңа қосылымды бастаңыз.',
      'vpn_host_unavailable':
          'Android VPN-ді қамтитын компонентті жасай алмайды. VPN параметрлерін тексергеннен кейін қайталап көріңіз.',
      'openvpn_renewal_required':
          'Сертификат үшін қосылмас бұрын қолданбада әрекет ету қажет.',
      'openvpn_recovery_failed':
          'Автоматты қалпына келтіру сәтсіз аяқталды. Қолданбада жаңа қосылымды бастаңыз.',
      'openvpn_recovery_exhausted':
          'Автоматты қалпына келтіру қазірдің өзінде пайдаланылды. Қолданбада жаңа қосылымды бастаңыз.',
      'vpn_permission_required':
          'Туннельді іске қосар алдында Android жаңа VPN рұқсатын талап етеді.',
      'vpn_permission_denied':
          'Жалғастыру үшін Android сұрауында FuzeVPN-ге рұқсат беріңіз.',
      'vpn_permission_request_failed': 'Android VPN рұқсат экранын аша алмады.',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard қызметін алдыңғы планда ұстай алмады.',
      'wireguard_identity_invalid':
          'Бұл аккаунттың шифрланған WireGuard кілті оқылмайды немесе жарамсыз.',
      'wireguard_identity_in_use':
          'Басқа әрекет әлі бұл аккаунттың WireGuard кілтін пайдаланып жатыр.',
      'wireguard_configuration_invalid':
          'Алынған WireGuard мекенжайы, DNS, сервер кілті немесе бағыттар жарамсыз.',
      'wireguard_operation_pending':
          'Алдыңғы WireGuard әрекеті жергілікті қызметін әлі босатқан жоқ.',
      'wireguard_start_failed':
          'WireGuard қозғалтқышы конфигурацияны іске қосудан бас тартты.',
      'wireguard_stop_timeout':
          'WireGuard қызметі белгіленген уақыт ішінде VPN интерфейсінің босатылғанын растаған жоқ.',
      'wireguard_handshake_timeout':
          'Туннель сервермен уақтылы байланыс орнатуды растаған жоқ.',
      'openvpn_connection_timeout':
          'OpenVPN серверге қосылуды уақтылы растаған жоқ.',
      'openvpn_core_unavailable':
          'Бұл қолданба нұсқасында пайдалануға болатын OpenVPN қозғалтқышы жоқ.',
      'openvpn_operation_pending':
          'Жергілікті қозғалтқыш әлі алдыңғы OpenVPN сеансын ұстап тұр және екінші сеансты жасаудан бас тартады.',
      'openvpn_stop_timeout':
          'OpenVPN қозғалтқышыбелгіленген уақыт ішінде өзінің жергілікті сеансы тоқтатылып, жойылғанын растаған жоқ.',
      'openvpn_profile_unavailable':
          'Бұл қосылым үшін расталған OpenVPN профилін оқу мүмкін емес.',
      'openvpn_native_failed':
          'Қолданба қатесі OpenVPN жұмысын үзді. Қайтадан қосылып көріңіз. Мәселе сақталса, диагностиканы іске қосыңыз.',
      'openvpn_key_generation_failed':
          'Android Keystore экспортталмайтын P-256 жеке кілтін жасай немесе оқи алмады.',
      'openvpn_csr_generation_failed':
          'Android Keystore кілті OpenVPN сертификаты сұрауына қол қоя алмады.',
      'openvpn_identity_store_failed':
          'OpenVPN сертификатын немесе профилін шифрланған сақтау орнына сақтау мүмкін болмады.',
      'openvpn_identity_clear_failed':
          'Android осы аккаунттың жергілікті OpenVPN сәйкестендіруін толық жоя алмады.',
      'openvpn_identity_in_use':
          'Жергілікті OpenVPN сеансы әлі осы құрылғының кілтін немесе сертификатын пайдаланып жатыр.',
      'openvpn_tls_verification_required':
          'Профиль сервер сертификатын тексеруді анық талап етпейді.',
      'openvpn_cipher_invalid':
          'Сервер рұқсат етілген тізімде жоқ шифрлау алгоритмін жіберді.',
      'openvpn_profile_rejected':
          'Серверден алынған профиль үйлеспейді. Осы құрылғыны қайта жасап, қайталап көріңіз.',
      'openvpn_identity_inconsistent':
          'Сертификат осы телефонның қауіпсіз сәйкестендіруіне сәйкес келмейді. Жергілікті профиль ауыстырылмады.',
      'tls_handshake_failed':
          'Сервер TLS келіссөзін қабылдамады. Мәселе сақталса, профильді қайта жасаңыз.',
      'tls_alert_unknown_ca':
          'Сервер осы құрылғының сертификатын берген орталықты танымайды. OpenVPN серверін тексеру қажет.',
      'tls_alert_bad_certificate':
          'Сервер осы құрылғының сертификатын қабылдамады. Қайталап көрмес бұрын құрылғыны қайта жасаңыз.',
      'tls_alert_unsupported_certificate':
          'Сервер Android пайдаланатын қауіпсіз сертификат түрін қолдамайды.',
      'tls_client_certificate_required':
          'Сервер клиент сертификатын талап етеді, бірақ OpenVPN қозғалтқышыоны көрсете алмады.',
      'tls_alert_misc':
          'Сервер сертификат пен нұсқа санаттарынан тыс TLS ескертуін қайтарды.',
      'tls_signature_algorithm_rejected':
          'Сервер Android Keystore кілтінің ECDSA P-256 алгоритмін қабылдамады.',
      'tls_handshake_rejected': 'Сервер қосылудан бұрын TLS келіссөзін үзді.',
      'tls_version_rejected': 'Клиент пен сервер ортақ TLS нұсқасын таппады.',
      'tls_certificate_expired':
          'Қосылу кезінде көрсетілген сертификаттың мерзімі аяқталды.',
      'tls_certificate_revoked':
          'Қосылу кезінде көрсетілген сертификаттың күші жойылған.',
      'transport_failed':
          'OpenVPN сервері ағымдағы желіде жауап бермейді. Біраздан кейін қайталап көріңіз.',
      'tun_configuration_rejected':
          'Android OpenVPN сұраған желі конфигурациясын қабылдамады.',
      'tun_setup_failed':
          'OpenVPN қозғалтқышыAndroid интерфейсін жасамас бұрын желі жоспарын қабылдамады.',
      'tun_interface_create_failed':
          'OpenVPN қозғалтқышыAndroid VpnService-тен TUN интерфейсін ала алмады.',
      'tun_interface_disabled':
          'Қосылу кезінде Android немесе OpenVPN қозғалтқышыTUN интерфейсін өшірді.',
      'tun_halted':
          'OpenVPN қозғалтқышыTUN интерфейсін тоқтату туралы сұрау алды.',
      'tun_already_established':
          'OpenVPN бір қосылымда екінші интерфейсті сұрады. Қауіпсіздік үшін туннель тоқтатылды.',
      'tun_addresses_missing':
          'Сервер пайдалануға болатын туннель мекенжайын бермеді.',
      'tun_routes_missing':
          'Сервер пайдалануға болатын туннель бағыттарын бермеді.',
      'tun_dns_missing': 'Сервер пайдалануға болатын DNS серверін бермеді.',
      'tun_permission_revoked':
          'Қосылу кезінде Android VPN рұқсатын қайтарып алды.',
      'tun_establish_returned_null':
          'Android интерфейсті жасаған жоқ, әдетте басқа VPN әлі белсенді болғандықтан.',
      'openvpn_service_start_failed':
          'Android OpenVPN қызметін алдыңғы планда іске қоса алмады.',
      'openvpn_operation_timeout':
          'OpenVPN қозғалтқышына жасалған JNI шақыруы рұқсат етілген ең ұзақ уақыттан асып кетті.',
      'openvpn_start_failed':
          'Android қызметі дайын, бірақ OpenVPN қозғалтқышыпрофильді іске қосуды қабылдамады.',
      'openvpn_connection_failed':
          'OpenVPN қозғалтқышыCONNECTED оқиғасын шығармай тұрып тоқтады.',
      'openvpn_core_status_error':
          'Жергілікті OpenVPN циклі қатемен аяқталды, нақтырақ соңғы оқиға жоқ.',
      'openvpn_stopped_before_connected':
          'Жергілікті OpenVPN циклі CONNECTED күйіне жетпей тоқтады, қозғалтқыштың анық қатесінсіз.',
      'openvpn_auth_failed':
          'OpenVPN сервері профильдің аутентификациясын қабылдамады.',
      'openvpn_client_setup_failed':
          'OpenVPN қозғалтқышыжелі қосылымына дейін клиентті іске қоса алмады.',
      'openvpn_client_halted':
          'OpenVPN қозғалтқышыклиентті толық тоқтату туралы сұрау алды.',
      'openvpn_client_restart':
          'OpenVPN қозғалтқышыөзінің тасымалдау сеансын қайта бастауды сұрады.',
      'openvpn_inactive_timeout':
          'OpenVPN қозғалтқышыбелсенді емес уақыт өткеннен кейін сеансты жапты.',
      'openvpn_session_expired':
          'Сервер OpenVPN сеансының мерзімі аяқталғанын хабарлады.',
      'openvpn_credentials_required':
          'Сервер немесе прокси осы сертификат профиліне кірмейтін интерактивті кіру деректерін сұрайды.',
      'openvpn_proxy_failed':
          'OpenVPN қозғалтқышыбаптанған прокси немесе аралық сервердің қатесін хабарлады.',
      'openvpn_compression_failed':
          'OpenVPN қозғалтқышыпрофиль немесе сервер хабарлаған сығымдау режимін қабылдамады.',
      'openvpn_ntlm_crypto_unavailable':
          'Профиль осы нұсқада қолжетімсіз NTLM шифрлауын сұрайды.',
      'openvpn_feature_unsupported':
          'Профиль немесе сервер осы Android клиентінде жоқ мүмкіндікті талап етеді.',
      'network_unavailable': 'Пайдалануға болатын физикалық желі жоқ.',
      'network_lost': 'Желі байланысы үзілгеннен кейін туннель тоқтатылды.',
      'certificate_validation_failed':
          'OpenVPN серверінің түпнұсқалығын тексеру мүмкін болмады.',
      'openvpn_certificate_expired':
          'Қайта қосылмас бұрын OpenVPN профилін жаңартыңыз.',
      'tunnel_active_for_another_account':
          'Бұл қосылым алдында басқа аккаунтқа тиесілі туннель тоқтатылуы керек.',
      'tunnel_already_active':
          'Android алдыңғы VPN сеансы әлі интерфейсті пайдаланып тұрғанын хабарлайды.',
      'tunnel_stop_timeout':
          '$protocol қозғалтқышы белгіленген уақыт ішінде VPN интерфейсінің босатылғанын растаған жоқ.',
      'tunnel_disconnected':
          'Жергілікті қозғалтқыш туннельдің іске қосылғаннан кейін күтпеген жерден аяқталғанын хабарлады.',
      'native_bridge_unavailable':
          'Қолданба Android VPN қызметіне кіре алмайды. Қолданбаны жабыңыз, қайта ашыңыз, содан кейін қайталап көріңіз.',
      'native_operation_failed':
          'Қолданба қатесі VPN әрекетін үзді. Қайталап көріңіз. Мәселе сақталса, диагностиканы іске қосыңыз.',
      'invalid_arguments':
          'Осы VPN әрекетіне қажетті ақпарат толық емес. Қайталап көріңіз. Мәселе сақталса, диагностиканы іске қосыңыз.',
      'invalid_account_id':
          'Жергілікті әрекет жарамды аккаунт идентификаторымен байланысты емес.',
      'invalid_device_id':
          'Жергілікті қозғалтқышқа жіберілген құрылғы идентификаторы жоқ немесе жарамсыз.',
      'storage_key_not_allowed':
          'Android көпірі рұқсат етілген сақтау тізімінен тыс кілтті бұғаттады.',
      'secure_storage_read_failed':
          'Android Keystore осы аккаунттың жергілікті деректерінің шифрын аша алмады.',
      'secure_storage_write_failed':
          'Android Keystore жергілікті деректерді шифрлай немесе сақтай алмады.',
      'key_generation_failed':
          'Android қауіпсіз сақтауда WireGuard кілтін жасай немесе оқи алмады.',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR жасай немесе қол қоя алмады.',
      'other':
          'Құжатталмаған жергілікті бөлім сәтсіз аяқталды. Төменде көрсетілген диагностика кодын қолдау қызметіне жіберіңіз.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Рұқсат сұрауы бұрыннан ашық';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN рұқсатының сұрауы әлі көрсетіліп тұр. Қайталамас бұрын оны аяқтаңыз.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN рұқсатын сұрау үзілді';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Қолданба жауап алғанға дейін VPN рұқсаты экраны жабылды.';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN қосылымы расталмады';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN қосылымын растау мүмкін болмады. Қауіпсіздік үшін ол тоқтатылды. Қайталап көріңіз.';

  @override
  String get openvpnCleanup_title => 'OpenVPN профилінің күші жойылды';

  @override
  String get openvpnCleanup_working =>
      'Күші жойылған OpenVPN профилі тоқтатылып, өшірілуде…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN тоқтатылғаны расталмады. Жаңа профиль жасамас бұрын қайталап көріңіз.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Күші жойылған OpenVPN профилі толық өшірілмеді. Тазалауды қайталап көріңіз.';

  @override
  String get openvpnCleanup_complete =>
      'Күші жойылған OpenVPN профилі өшірілді. Жаңасын жасау үшін «Қосылу» түймесін басыңыз.';

  @override
  String get network_title => 'Желі конфигурациясы';

  @override
  String get network_ipv4Fallback =>
      'IPv6 уақытша қолжетімсіз. Дайындық IPv4 арқылы жалғасады.';

  @override
  String get network_rejectedTitle => 'Желі конфигурациясы қабылданбады';

  @override
  String get network_rejectedMessage =>
      'Туннель конфигурациясы толық емес немесе рұқсат етілген мекенжайларға сәйкес келмейді. Қолданбадан қайталап көріңіз.';

  @override
  String get network_unreadableTitle => 'Жергілікті конфигурация оқылмайды';

  @override
  String get network_unreadableMessage =>
      'Сақталған OpenVPN желі конфигурациясын пайдалану мүмкін емес. Оны жаңарту үшін қолданбадан қайта қосылыңыз.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Желіні қорғау';

  @override
  String get protection_subtitle =>
      'VPN ажыраса, интернетке тікелей қолжетімділікті бұғаттаңыз.';

  @override
  String get protection_active => 'Жүйелік қорғау белсенді';

  @override
  String get protection_alwaysOnOnly =>
      'Үнемі қосулы VPN белсенді; VPN-сіз қосылымдарды бұғаттауды қосыңыз';

  @override
  String get protection_inactive => 'Жүйелік қорғау белсенді емес';

  @override
  String get protection_unknown => 'Жүйелік қорғауды тексеріңіз';

  @override
  String get protection_openSettings => 'Android параметрлерін ашу';

  @override
  String get protection_dialogTitle => 'Желіні қорғауды орнату';

  @override
  String get protection_dialogMessage =>
      'Android үнемі қосулы VPN-ді және VPN-сіз қосылымдарды бұғаттауды басқарады. FuzeVPN таңдалғанын тексеріп, жүйелік параметрлерде бұғаттауды қосыңыз.';

  @override
  String get protection_dialogOpen => 'Параметрлерді ашу';

  @override
  String get session_systemProtectionNote =>
      'Android VPN-сіз трафикті әлі де бұғаттап тұрса, бұл қорғанысты тексеру немесе өзгерту үшін жүйелік параметрлерді ашыңыз.';

  @override
  String get diagnostics_title => 'Диагностика';

  @override
  String get diagnostics_settingsTitle => 'Қолданба диагностикасы';

  @override
  String get diagnostics_automaticTitle => 'Маңызды қателерді жіберу';

  @override
  String get diagnostics_automaticDescription =>
      'Маңызды қате орын алғанда шағын техникалық есеп жіберіледі.';

  @override
  String get diagnostics_privacy =>
      'Жіберілген есептер кірген аккаунтпен байланысты және 30 күн бойы сақталады. Олар шолу тарихын, құпия сөздерді немесе VPN кілттерін қамтымайды.';

  @override
  String get diagnostics_manualOpen => 'Диагностиканы іске қосу';

  @override
  String get diagnostics_localDescription =>
      'Қолданба мен VPN күйі туралы есеп жасаңыз. Қосылымыңыз өзгеріссіз қалады.';

  @override
  String get diagnostics_sendReport => 'Есепті жіберу';

  @override
  String get diagnostics_sendHint =>
      'Есепті осы құрылғыда қалдыру үшін бұл құсбелгіні қоймаңыз.';

  @override
  String get diagnostics_signedOut => 'Есеп жіберу үшін аккаунтыңызға кіріңіз.';

  @override
  String get diagnostics_localLifetime =>
      'Есеп қолданбаны жапқаннан кейін де сақталуы үшін оны телефонға сақтаңыз.';

  @override
  String get diagnostics_run => 'Диагностиканы іске қосу';

  @override
  String get diagnostics_rerun => 'Диагностиканы қайта іске қосу';

  @override
  String get diagnostics_running => 'Тексерілуде…';

  @override
  String get diagnostics_sending => 'Есеп жіберілуде…';

  @override
  String get diagnostics_prepared => 'Есеп осы құрылғыда дайын';

  @override
  String get diagnostics_queued => 'Есеп жіберілуін күтуде';

  @override
  String get diagnostics_sent => 'Есеп алынды';

  @override
  String get diagnostics_failed =>
      'Жіберу сәтсіз аяқталды. Жергілікті есеп әлі қолжетімді.';

  @override
  String get diagnostics_preparationFailed =>
      'Диагностика есебін дайындау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get diagnostics_authenticationRequired =>
      'Есепті жіберу үшін қайта кіріңіз.';

  @override
  String get diagnostics_retry => 'Жіберуді қайталау';

  @override
  String get diagnostics_export => 'Есепті сақтау';

  @override
  String get diagnostics_exportFailed =>
      'Экспорттау мүмкін болмады. Жергілікті есептен қайталап көріңіз.';

  @override
  String get diagnostics_preferenceFailed =>
      'Бұл параметрді сақтау мүмкін болмады. Қайталап көріңіз.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Анықтамалық код: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date күні алынды';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date күніне дейін сақталады';
  }

  @override
  String get diagnostics_duplicate => 'Бұл есеп бұрын алынған.';

  @override
  String get diagnostics_preview => 'Есепті алдын ала қарау';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count техникалық оқиға тіркелген',
      one: '1 техникалық оқиға тіркелген',
      zero: 'Техникалық оқиғалар тіркелмеген',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Техникалық мәліметтер';

  @override
  String get diagnostics_empty => 'Диагностика есебі әлі дайындалған жоқ.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Туннель күйі',
      'handshake': 'Қосылымды растау',
      'certificate': 'VPN сертификаты',
      'kill_switch': 'Android қорғанысы',
      'connectivity': 'Қолжетімді желі',
      'api_reachability': 'Қызметке қолжетімділік',
      'secure_storage': 'Қауіпсіз сақтау',
      'other': 'Жергілікті тексеру',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Тексерілді',
      'failed': 'Назар аудару қажет',
      'skipped': 'Сыналмады — белсенді тексеру жоқ',
      'unknown': 'Ақпарат қолжетімсіз',
      'other': 'Ақпарат қолжетімсіз',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN-ге қош келдіңіз';

  @override
  String get connection_changeLocation => 'Орынды өзгерту';

  @override
  String get connection_details => 'Қосылым мәліметтері';

  @override
  String get locations_searchLabel => 'Қаланы немесе елді іздеу';

  @override
  String get locations_clearSearch => 'Іздеуді тазалау';

  @override
  String get locations_filterAll => 'Барлығы';

  @override
  String get locations_filterFavorites => 'Таңдаулылар';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count орын',
      one: '$count орын',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Орын табылмады';

  @override
  String get locations_noResultsHint => 'Басқа қала немесе ел іздеп көріңіз.';

  @override
  String get locations_noFavorites => 'Таңдаулыларыңыз қолыңыздың ұшында';

  @override
  String get locations_noFavoritesHint =>
      'Осы жерде сақтау үшін орынның жанындағы жұлдызшаны түртіңіз.';

  @override
  String get locations_showAll => 'Барлық орындарды көру';

  @override
  String locations_addFavorite(String name) {
    return 'Таңдаулыларға қосу: $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Таңдаулылардан алып тастау: $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Таңдаулыны сақтау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get locations_emptyTitle => 'Қолжетімді орындар жоқ';

  @override
  String get locations_emptyHint => 'Қайталап көру үшін тізімді жаңартыңыз.';

  @override
  String get devices_manage => 'Құрылғыларымды басқару';

  @override
  String get settings_personalization => 'Өзіңізге ыңғайлы етіңіз';

  @override
  String get settings_safety => 'Қорғаныс';

  @override
  String get settings_help => 'Көмек қажет пе?';

  @override
  String get settings_about => 'FuzeVPN туралы';

  @override
  String get diagnostics_heading => 'Қосылым мәселесін түсіну';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Қолжетімді',
      'pending': 'Дайындалуда',
      'revoked': 'Алып тасталды',
      'expired': 'Мерзімі аяқталды',
      'other': 'Күйі қолжетімсіз',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Параметр сақталмады';

  @override
  String get notice_preferenceSave_message =>
      'Таңдауыңыз қазір қолданылып тұр, бірақ сақталмады. Қолданбаны жапқаннан кейін де сақтау үшін қайталап көріңіз.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPN-ді белсенді ұстап тұрса, ашылатын параметрлерде «Үнемі қосулы VPN» опциясын өшіріңіз.';

  @override
  String get protection_learnMore => 'Android қорғанысы туралы толығырақ білу';

  @override
  String get protection_guideWhy =>
      'Бұл қорғаныс VPN ажыратылған кезде қолданбалардың интернетке тікелей қосылуына жол бермейді. Ол Android жүйесінде реттеледі.';

  @override
  String get protection_guideAlwaysOnTitle => 'Үнемі қосулы VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN қызметін іске қосулы ұстайды және телефон қайта жүктелгеннен кейін оны қайта іске қоса алады.';

  @override
  String get protection_guideBlockTitle => 'VPN-сіз қосылымдарды бұғаттау';

  @override
  String get protection_guideBlock =>
      'Бұл параметр қосылым үзілген кезде де трафиктің VPN-ді айналып өтуіне жол бермейді.';

  @override
  String get protection_guideWarning =>
      'Бұл бұғаттау қосулы болса, VPN қосылғанға дейін интернетке қосылу мүмкін болмайды.';

  @override
  String get protection_guideStepsTitle => 'Қорғанысты қосу';

  @override
  String get protection_guideStep1 =>
      'Төмендегі түйме арқылы Android VPN параметрлерін ашыңыз.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN атауының жанындағы тісті доңғалақ белгішесі арқылы опцияларды ашыңыз.';

  @override
  String get protection_guideStep3 =>
      'Қолжетімді болса, алдымен «Үнемі қосулы VPN», содан кейін «VPN-сіз қосылымдарды бұғаттау» опцияларын қосыңыз.';

  @override
  String get protection_guideManufacturers =>
      'Атаулар телефонға байланысты әртүрлі болады. Қажет болса, параметрлерде «VPN» деп іздеңіз, көбінесе «Желі және интернет» бөлімінде болады.';

  @override
  String get protection_guideDisableTitle => 'Бұл қорғанысты өшіру';

  @override
  String get protection_guideDisable =>
      'Сол параметрлерде VPN-сіз интернетті пайдалану үшін «VPN-сіз қосылымдарды бұғаттау» опциясын өшіріңіз. Егер Android VPN қызметін қайта іске қоспауын қаласаңыз, «Үнемі қосулы VPN» опциясын да өшіріңіз.';

  @override
  String get protection_guideManual =>
      'Бұл параметрлерді Android жүйесінде өзіңіз таңдайсыз. FuzeVPN оларды сіз үшін өзгертпейді.';

  @override
  String get locations_changeTitle => 'Орынды өзгертесіз бе?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ажыратылады, содан кейін мына орынға қосылуға тырысады: $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN мына орынға қосылуға тырысады: $name.';
  }

  @override
  String get locations_confirmChange => 'Өзгертіп, қосылу';

  @override
  String get locations_changeBusy =>
      'Өзгерту жүріп жатыр. Басқа орынды таңдау үшін аяқталуын күтіңіз.';

  @override
  String get locations_automaticSelection => 'Автоматты таңдау';

  @override
  String get locations_cities => 'Қалалар';

  @override
  String get locations_servers => 'Серверлер';

  @override
  String locations_viewCities(String name) {
    return '$name қалаларын көру';
  }

  @override
  String locations_viewServers(String name) {
    return '$name серверлерін көру';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ел',
      one: '$count ел',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count қала',
      one: '$count қала',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сервер',
      one: '$count сервер',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Барлық елдер';

  @override
  String get locations_backToCountries => 'Елдерге оралу';

  @override
  String locations_backToCities(String name) {
    return '$name қалаларына оралу';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Таңдау: $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Таңдау: $name';
  }

  @override
  String get locations_noCompatibleServer => 'Сәйкес келетін сервер жоқ.';

  @override
  String get externalLink_failed =>
      'Бұл сілтемені ашу мүмкін емес. Оны көшіріп, браузеріңізде ашуыңызға болады.';

  @override
  String get externalLink_copy => 'Сілтемені көшіру';

  @override
  String get externalLink_copied => 'Сілтеме көшірілді';

  @override
  String get externalLink_copyFailed =>
      'Сілтемені көшіру мүмкін болмады. Төмендегі мекенжайды таңдаңыз.';

  @override
  String get settings_deleteAccount => 'Аккаунтымды жою';

  @override
  String get settings_deleteAccountDetail =>
      'Аккаунтты жою сұрауының рәсімін көру';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'VPN жазылымыңызды таңдаңыз.';

  @override
  String get billing_subscribe => 'Жазылу';

  @override
  String get billing_choosePlan => 'Жалғастыру үшін тарифті таңдаңыз.';

  @override
  String get billing_monthly => 'Айлық';

  @override
  String get billing_yearly => 'Жылдық';

  @override
  String get billing_continue => 'Google Play арқылы жалғастыру';

  @override
  String get billing_restore => 'Сатып алуларды қалпына келтіру';

  @override
  String get billing_manage => 'Жазылымды басқару';

  @override
  String get billing_deleteAccountWarning =>
      'Google Play жазылымыңыз болса, FuzeVPN аккаунтыңызды жою оның ұзартылуын тоқтатпайды. Ұзартуды Google Play арқылы бөлек басқарыңыз немесе тоқтатыңыз.';

  @override
  String get billing_deleteAccountContinue => 'Аккаунтты жою сұрауына өту';

  @override
  String get billing_refresh => 'Қолжетімділікті жаңарту';

  @override
  String get billing_loadingPlans => 'Тарифтер жүктелуде…';

  @override
  String get billing_unavailable =>
      'Қазір тарифтер қолжетімсіз. Кейінірек қайталап көріңіз.';

  @override
  String get billing_comingSoon => 'Жазылымдар жақында қолжетімді болады.';

  @override
  String get billing_priceDisclosure =>
      'Бағаны Google Play ұсынады. Соңғы сома мен қолданылатын салықтар сіз растамас бұрын нақтыланады.';

  @override
  String get billing_renewalMonthly =>
      'Бас тартылмаса, ай сайын автоматты түрде ұзартылады. Жазылымнан Google Play ішінде кез келген уақытта бас тарта аласыз.';

  @override
  String get billing_renewalYearly =>
      'Бас тартылмаса, жыл сайын автоматты түрде ұзартылады. Жазылымнан Google Play ішінде кез келген уақытта бас тарта аласыз.';

  @override
  String get billing_active => 'Premium қолжетімділігіңіз белсенді';

  @override
  String billing_accessUntil(String date) {
    return 'Қолжетімділік $date күніне дейін.';
  }

  @override
  String get billing_webManaged =>
      'Жазылымыңыз FuzeVPN веб-сайтында басқарылады.';

  @override
  String get billing_playManaged =>
      'Жазылымыңыз Google Play арқылы басқарылады.';

  @override
  String get billing_playOnHold =>
      'Google Play жазылымыңыз кідіртілген немесе төлемді күтуде. Оны Google Play ішінде түзету үшін «Жазылымды басқару» бөлімін ашыңыз.';

  @override
  String get billing_playReceiptUnlinked =>
      'Бұл Google Play аккаунтында осы FuzeVPN аккаунты үшін белсенді емес Fuze Premium жазылымы бар. Оны Google Play ішінде қарау үшін «Жазылымды басқару» бөлімін ашыңыз.';

  @override
  String get billing_inactive => 'Белсенді жазылым жоқ.';

  @override
  String get billing_checkingAccess => 'Қолжетімділігіңіз тексерілуде…';

  @override
  String get billing_restoring => 'Сатып алулар қалпына келтірілуде…';

  @override
  String get billing_pending =>
      'Төлем күтілуде. Растағаннан кейін қолжетімділігіңіз белсендіріледі.';

  @override
  String get billing_cancelled =>
      'Сатып алудан бас тартылды. Жаңа жазылым белсендірілмеді.';

  @override
  String get billing_verifying => 'Сатып алу тексерілуде…';

  @override
  String get billing_success =>
      'Жазылым белсендірілді. Premium қолжетімділігіңіз дайын.';

  @override
  String get billing_restored => 'Сатып алуларыңыз қалпына келтірілді.';

  @override
  String get billing_restoreEmpty =>
      'Бұл Google Play аккаунты үшін қалпына келтіретін сатып алулар жоқ.';

  @override
  String get billing_catalogError =>
      'Тарифтерді жүктеу мүмкін болмады. Қайталап көріңіз.';

  @override
  String get billing_purchaseError =>
      'Сатып алуды бастау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get billing_verificationError =>
      'Сатып алуды тексеру уақытша қолжетімсіз. Қайталап көру үшін сатып алуларды қалпына келтіріңіз.';

  @override
  String get billing_restoreError =>
      'Сатып алуларды қалпына келтіру мүмкін болмады. Қайталап көріңіз.';

  @override
  String get billing_managementError =>
      'Жазылымды басқару бетін ашу мүмкін болмады. Қайталап көріңіз.';

  @override
  String get billing_storeUnavailable =>
      'Бұл құрылғыда Google Play қолжетімсіз.';

  @override
  String get welcome_title => 'Сіздің VPN — қарапайым әрі оңай.';

  @override
  String get welcome_description =>
      'Қосылымыңызды қорғаңыз. Құпиялылығыңызды өз бақылауыңызда ұстаңыз.';

  @override
  String get welcome_start => 'Бастау';

  @override
  String get welcome_alreadyPurchased => 'Бұрын сатып алғансыз ба?';

  @override
  String get welcome_noAccountRequired => 'Бастау үшін аккаунт қажет емес.';

  @override
  String get guest_accountTitle => 'Аккаунт байланыстырылмаған';

  @override
  String get guest_accountDescription =>
      'Жазылымыңызды басқа құрылғыда пайдалану үшін сол Google Play аккаунтымен сатып алуларыңызды қалпына келтіріңіз.';

  @override
  String get guest_existingSubscriberSignIn => 'Жазылғансыз ба? Кіріңіз';

  @override
  String get guest_claimTitle => 'FuzeVPN-ді өзіңізбен бірге алыңыз';

  @override
  String get guest_claimDescription =>
      'Жазылымыңызға басқа құрылғыларыңызда қол жеткізу үшін аккаунт жасаңыз. Бұл қадам міндетті емес.';

  @override
  String get guest_skip => 'Кейінірек';

  @override
  String get guest_activationTitle => 'Fuze Premium белсенді';

  @override
  String get guest_activationDescription =>
      'Жазылымыңыз дайын. VPN-ді пайдаланыңыз және қалаған уақытта аккаунт жасаңыз.';

  @override
  String get guest_useVpn => 'VPN-ді пайдалану';

  @override
  String get guest_loginRequired =>
      'Бұл сатып алу бұрыннан FuzeVPN аккаунтына байланыстырылған. Жазылымыңызға қол жеткізу үшін сол аккаунтқа кіріңіз.';

  @override
  String get guest_signOutWarning =>
      'Сол Google Play аккаунтымен сатып алуларыңызды қалпына келтіру арқылы жазылымыңызды қайта алуға болады.';

  @override
  String get guest_profileUnavailable =>
      'Аккаунтыңыз бұрыннан байланыстырылған. Мәліметтеріңізді көру және басқару үшін кіріңіз.';

  @override
  String get billing_acceptance =>
      'Жалғастыру арқылы Пайдалану шарттарын және Құпиялылық саясатын қабылдайсыз.';

  @override
  String get guest_verifyEmailReminder =>
      'Аккаунтыңызды қорғау үшін электрондық пошта мекенжайыңызды растаңыз. VPN-ді пайдалануды жалғастыра аласыз.';

  @override
  String get guest_serviceUnavailable =>
      'Қызмет уақытша қолжетімсіз. Біраздан кейін қайталап көріңіз.';

  @override
  String get guest_restoreError =>
      'Сатып алуларыңызды қалпына келтіру мүмкін болмады. Сатып алу үшін пайдаланылған Google Play аккаунтымен қайталап көріңіз.';

  @override
  String get guest_claimSuccess =>
      'Аккаунтыңыз жасалды. Жазылымыңыз бен VPN қолжетімділігіңіз сақталды.';

  @override
  String get guest_emailExists =>
      'Бұл электрондық пошта мекенжайы бұрыннан пайдаланылып жатыр. Басқа мекенжай таңдаңыз немесе бар аккаунтыңызға кіріңіз. Сатып алуыңыз Google Play арқылы қолжетімді күйде қалады.';

  @override
  String get guest_claimError =>
      'Аккаунтыңызды жасау мүмкін болмады. VPN-ді пайдалануды жалғастыра аласыз және кейінірек қайталап көре аласыз.';

  @override
  String get guest_secureStorageError =>
      'Бұл құрылғыда сеансыңызды қорғау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get guest_premiumRequired =>
      'VPN-ді белсендіру үшін жазылымды таңдаңыз.';

  @override
  String get welcome_viewPlans => 'Тарифтерді көру';

  @override
  String get google_continue => 'Google арқылы жалғастыру';

  @override
  String get google_or => 'немесе';

  @override
  String get google_title => 'FuzeVPN аккаунтыңыз';

  @override
  String get google_settingUp => 'Аккаунтты жасауды аяқтаңыз';

  @override
  String get google_country => 'Тұрғылықты ел';

  @override
  String get google_profileDescription =>
      'FuzeVPN аккаунтын жасау үшін еліңізді таңдап, екі құжатпен танысыңыз.';

  @override
  String get google_claimDescription =>
      'Қонақ аккаунтыңызды Google аккаунтына байланыстырыңыз. Жазылымыңыз бен құрылғыңыз осы аккаунтқа байланысты болып қалады.';

  @override
  String get google_linkTitle => 'Google аккаунтын FuzeVPN-мен байланыстыру';

  @override
  String get google_linkDescription =>
      'Қолданыстағы FuzeVPN аккаунтыңызға қол жеткізуді растаңыз. Бұл қадам Google құпия сөзіңізді сұрамайды.';

  @override
  String get google_password => 'FuzeVPN құпия сөзі';

  @override
  String get google_linkAccount => 'Байланыстыруды растау';

  @override
  String get google_requestEmail => 'Растау хатын жіберу';

  @override
  String get google_emailInstructions =>
      'FuzeVPN хатын ашып, растау кодын енгізіңіз.';

  @override
  String get google_emailCode => 'Электрондық поштаны растау коды';

  @override
  String get google_confirmEmail => 'Кодты растау';

  @override
  String get google_restart => 'Басқа Google аккаунтын таңдау';

  @override
  String get google_resume => 'Осы әрекетті тексеру';

  @override
  String get google_unavailable =>
      'Google арқылы кіру қолжетімсіз. Электрондық пошта мен құпия сөз арқылы кіре аласыз.';

  @override
  String get google_expired =>
      'Бұл әрекеттің мерзімі аяқталды. Бас тартып, қайтадан бастаңыз.';

  @override
  String get google_conflict =>
      'Бұл Google аккаунты басқа жерде бұрыннан байланыстырылған. Ағымдағы аккаунтыңыз бен жазылымыңыз сақталады.';

  @override
  String get google_error =>
      'Google арқылы кіру сәтсіз аяқталды. Қайталап көріңіз; ағымдағы қолжетімділігіңіз сақталады.';

  @override
  String get google_uncertain =>
      'Нәтиже расталмады. Қайтадан бастамас бұрын осы әрекетті тексеріңіз немесе одан бас тартыңыз.';

  @override
  String get google_cancelFailed =>
      'Бас тарту расталмады. Осы экраннан шықпас бұрын қайтадан бас тартып көріңіз.';

  @override
  String get google_cancelled => 'Google арқылы кіруден бас тартылды.';

  @override
  String get google_selecting => 'Google аккаунтыңызды таңдаңыз…';

  @override
  String get google_verifying => 'Аккаунтыңыз тексерілуде…';

  @override
  String get google_emailUnavailable =>
      'Растау хатын жіберу мүмкін болмады. Кейінірек қайталап көріңіз.';

  @override
  String get google_emailSent =>
      'Растау хаты жіберілді. Кіріс хаттарыңызды тексеріңіз.';

  @override
  String get google_rateLimited => 'Қайтадан әрекет жасамас бұрын күтіңіз.';

  @override
  String get google_busy =>
      'Басқа операция орындалып жатқан кезде (VPN қосылымы, аккаунт немесе қонақ) Google қолжетімсіз. Ол аяқталғаннан кейін қайталап көріңіз; ағымдағы қолжетімділігіңіз сақталады.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN құпия сөзі дұрыс емес. Ағымдағы аккаунтыңыз сақталады.';

  @override
  String get google_invalidCode =>
      'Растау коды жарамсыз немесе мерзімі аяқталған.';

  @override
  String get google_accountChanged =>
      'Сеансыңыз өзгерді. Қайтадан бастамас бұрын осы әрекеттен бас тартыңыз.';

  @override
  String get google_invalidResponse =>
      'Жауапты растау мүмкін болмады. Ағымдағы қолжетімділігіңіз сақталады.';

  @override
  String get google_invalidRegistration =>
      'Еліңізді және екі келісімді тексеріңіз.';

  @override
  String get google_consentRequired =>
      'Жалғастыру үшін еліңізді таңдап, екі құжатты қабылдаңыз.';

  @override
  String get google_challengeRequired =>
      'Қосымша қауіпсіздік тексеруі қажет. Ағымдағы қолжетімділігіңіз сақталады.';

  @override
  String get google_challengeUnavailable =>
      'Қауіпсіздік тексеруі қолжетімсіз. Кейінірек қайталап көріңіз.';

  @override
  String get google_intentMismatch =>
      'Google арқылы кірудің алдыңғы әрекеті әлі күтуде. Бұл операцияны бастамас бұрын одан бас тартыңыз.';

  @override
  String get google_challengeBlocked =>
      'Қажетті қауіпсіздік тексеруі осы қолданбада қолжетімсіз. Бұл операцияны қазір аяқтау мүмкін емес.';

  @override
  String get google_solveChallenge => 'Қауіпсіздік тексеруін аяқтау';

  @override
  String get google_challengeTitle => 'Қауіпсіздік тексеруі';

  @override
  String get google_challengeReady =>
      'Тексеру аяқталды. Енді аккаунтыңызды жасауды растай аласыз.';

  @override
  String get google_challengeExpired =>
      'Тексеру мерзімі аяқталды. Растамас бұрын оны қайтадан аяқтаңыз.';

  @override
  String get google_challengeCancelled =>
      'Тексеруден бас тартылды. Қайталап көре аласыз.';

  @override
  String get google_challengeFailed =>
      'Қауіпсіздік тексеруі сәтсіз аяқталды. Қайталап көріңіз.';

  @override
  String get billing_trialTitle => 'Fuze Premium-ды тегін көріңіз';

  @override
  String get billing_trialSubtitle => 'Бүгіннен бастап қосылымыңызды қорғаңыз.';

  @override
  String get billing_trialWeeks => '2 апталық тегін сынақ';

  @override
  String billing_trialDays(String days) {
    return '$days күндік тегін сынақ';
  }

  @override
  String get billing_trialStart => 'Тегін сынақты бастау';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Бүгін бастасаңыз, алғашқы төлем $date күні күтіледі.';
  }

  @override
  String get billing_trialTerms =>
      'Көрсетілген бағамен автоматты түрде ұзартылады. Төлем алынбауы үшін сынақ мерзімі аяқталғанға дейін Google Play ішінде жазылымнан бас тартыңыз.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Содан кейін айына $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Содан кейін жылына $price';
  }

  @override
  String get billing_choosePeriod => 'Тарифті таңдаңыз';

  @override
  String get billing_selectionHint => 'Жалғастыру үшін бір тарифті таңдаңыз.';

  @override
  String get billing_benefitConnection => 'Шифрланған қосылым';

  @override
  String get billing_benefitPrivacy => 'Желідегі құпиялылық';

  @override
  String get billing_benefitNoAccount => 'Тіркелу қажет емес';

  @override
  String get billing_cancellation => 'Google Play ішінде бас тарту';

  @override
  String get billing_premiumTitle => 'Анағұрлым қорғалған қосылым.';

  @override
  String get billing_premiumSubtitle =>
      'Қосылымыңызды өз қарқыныңызбен қорғаңыз.';

  @override
  String get billing_priceMonthly => 'айына';

  @override
  String get billing_priceYearly => 'жылына';

  @override
  String get billing_trialToday => 'Бүгін төлейтін ештеңе жоқ';

  @override
  String get billing_trialConfirmation =>
      'Сіз растамас бұрын Google Play күндерді, соңғы соманы және қолданылатын салықтарды растайды.';

  @override
  String get billing_offerChanged =>
      'Бұл ұсыныстың шарттары өзгерді. Тарифтерді жаңартып, қайтадан таңдаңыз.';

  @override
  String get status_waitingNetwork => 'Желіні күтуде';

  @override
  String get status_waitingNetworkDetail =>
      'Желі қолжетімсіз. Желі қайтып келгенде VPN қосылымды тексереді.';

  @override
  String get locations_favoriteLoadFailed =>
      'Таңдаулыларды жүктеу мүмкін болмады. Қайталап көріңіз.';

  @override
  String get locations_favoritesLoading => 'Таңдаулылар жүктелуде…';
}
