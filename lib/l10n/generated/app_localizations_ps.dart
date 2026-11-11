// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Pushto Pashto (`ps`).
class AppLocalizationsPs extends AppLocalizations {
  AppLocalizationsPs([String locale = 'ps']) : super(locale);

  @override
  String get vpnDisclosure_title => 'خپل اتصال خوندي کړئ';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN د Android د VPN خدمت (VpnService) کاروي، ترڅو د دې وسیلې او د FuzeVPN د سرورونو ترمنځ کوډ شوی تونل جوړ کړي.';

  @override
  String get vpnDisclosure_dataBody =>
      'کله چې VPN فعال وي، ستاسو د اپلیکیشنونو د انټرنېټ ټرافیک، د منزل پتې او د DNS غوښتنې ستاسو د اتصال د مسیر ټاکلو لپاره د دې تونل له لارې تېرېږي، حتی کله چې FuzeVPN په شالید کې وي.';

  @override
  String get vpnDisclosure_statusBody =>
      'اپلیکیشن ستاسو د VPN اتصال د ښودلو لپاره د اتصال حالت، موده او د لېږدول شویو ډېټا اندازه کاروي. تاسو کولای شئ هر وخت یې ودروئ.';

  @override
  String get vpnDisclosure_privacy => 'محرمیت';

  @override
  String get vpnDisclosure_accept => 'ومنئ او دوام ورکړئ';

  @override
  String get vpnDisclosure_decline => 'اوس نه';

  @override
  String get accountRestoration_title => 'حساب د لنډ وخت لپاره شتون نلري';

  @override
  String get accountRestoration_message =>
      'ستاسو ناسته ساتل شوې ده. د خپل حساب د بېرته رغولو لپاره بیا هڅه وکړئ؛ تاسو لا هم کولای شئ دلته د VPN اتصال اداره کړئ.';

  @override
  String get action_retry => 'بیا هڅه وکړئ';

  @override
  String get session_endingTitle => 'ناسته پای ته رسېږي';

  @override
  String get session_ending =>
      'ناسته پای ته رسېږي: VPN بندېږي او پاکول ترسره کېږي…';

  @override
  String get session_stopFailed =>
      'د VPN بندېدل تایید نشو. مخکې له دې چې بیا ننوځئ، بیا هڅه وکړئ.';

  @override
  String get session_cleanupFailed =>
      'VPN بند شوی دی، مګر د ناستې لرې کېدل تایید نشو. د پاکولو بیا هڅه وکړئ.';

  @override
  String get session_retryStop => 'د بندولو بیا هڅه';

  @override
  String get session_retryCleanup => 'د پاکولو بیا هڅه';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN په خوندي ډول چمتو کېږي…';

  @override
  String get nav_connection => 'اتصال';

  @override
  String get nav_locations => 'ځایونه';

  @override
  String get nav_account => 'حساب';

  @override
  String get nav_devices => 'وسایل';

  @override
  String get nav_settings => 'تنظیمات';

  @override
  String get action_refresh => 'تازه کړئ';

  @override
  String get auth_tab_login => 'ننوځئ';

  @override
  String get auth_tab_register => 'نوم لیکنه';

  @override
  String get auth_stepAccount => 'حساب';

  @override
  String get auth_stepIdentity => 'هویت';

  @override
  String get auth_stepAddress => 'پته او موافقې';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'ګام $current له $total څخه';
  }

  @override
  String get auth_tagline => 'ستاسو VPN، په ساده ډول.';

  @override
  String get auth_keysLocal =>
      'ستاسو خصوصي VPN کلیډونه په دې وسیله کې پاتې کېږي.';

  @override
  String get form_email => 'د برېښنالیک پته';

  @override
  String get form_password => 'پټنوم';

  @override
  String get form_showPassword => 'پټنوم ښکاره کړئ';

  @override
  String get form_hidePassword => 'پټنوم پټ کړئ';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 بایټه. ځینې توري له یو بایټ څخه ډېر ځای نیسي.';

  @override
  String get form_firstName => 'لومړی نوم';

  @override
  String get form_lastName => 'وروستی نوم';

  @override
  String get form_phone => 'تلیفون (+33612345678)';

  @override
  String get form_address => 'پته';

  @override
  String get form_address2 => 'د پتې دویمه کرښه (اختیاري)';

  @override
  String get form_postalCode => 'پوستي کوډ';

  @override
  String get form_city => 'ښار';

  @override
  String get form_country => 'د هېواد کوډ (لکه FR)';

  @override
  String get action_login => 'ننوځئ';

  @override
  String get action_createAccount => 'حساب جوړ کړئ';

  @override
  String get action_createMyAccount => 'خپل حساب جوړ کړئ';

  @override
  String get action_next => 'دوام ورکړئ';

  @override
  String get action_previous => 'شاته';

  @override
  String get action_forgotPassword => 'پټنوم مو هېر شو؟';

  @override
  String get auth_noAccount => 'تر اوسه حساب نه لرئ؟';

  @override
  String get auth_requiredInformation => 'خپل حساب په درېو ګامونو کې جوړ کړئ.';

  @override
  String get auth_termsPrefix => 'زه ';

  @override
  String get auth_termsLink => 'د کارونې شرایط منم';

  @override
  String get auth_privacyPrefix => 'زه ';

  @override
  String get auth_privacyLink => 'د محرمیت پالیسي منم';

  @override
  String get auth_consentRequired =>
      'د حساب جوړولو لپاره ستاسو موافقه اړینه ده.';

  @override
  String get validation_required => 'دا ساحه اړینه ده.';

  @override
  String get validation_email => 'د برېښنالیک سمه پته ولیکئ.';

  @override
  String get validation_password => 'پټنوم ډېر لنډ دی: لږترلږه 8 UTF-8 بایټه.';

  @override
  String get validation_passwordTooLong =>
      'پټنوم ډېر اوږد دی: تر ډېره 72 UTF-8 بایټه.';

  @override
  String get validation_phone =>
      'نړیواله بڼه وکاروئ، د بېلګې په توګه +33612345678.';

  @override
  String get validation_country =>
      'د هېواد دوه حرفي کوډ وکاروئ، د بېلګې په توګه FR.';

  @override
  String get passwordReset_title => 'پټنوم بیا تنظیم کړئ';

  @override
  String get passwordReset_description =>
      'د پټنوم د بیا تنظیمولو لینک غوښتلو لپاره د خپل حساب د برېښنالیک پته ولیکئ.';

  @override
  String get passwordReset_send => 'لینک ولېږئ';

  @override
  String get connection_title => 'ستاسو اتصال';

  @override
  String get connection_subtitle => 'یو ځای وټاکئ، بیا خپل VPN فعال کړئ.';

  @override
  String get connection_prepare => 'د وصلېدو لپاره چمتو یاست؟';

  @override
  String get connection_advancedOptions => 'پرمختللي اختیارونه';

  @override
  String get connection_location => 'ځای';

  @override
  String get connection_chooseLocation => 'یو ځای وټاکئ';

  @override
  String get connection_protocol => 'پروتوکول';

  @override
  String get connection_connect => 'وصل کړئ';

  @override
  String get connection_connecting => 'وصلېږي…';

  @override
  String get connection_disconnect => 'قطع کړئ';

  @override
  String get connection_disconnecting => 'قطع کېږي';

  @override
  String get connection_locationChange => 'ځای بدلېږي…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol شتون نلري';
  }

  @override
  String get connection_activeLocation => 'فعال ځای';

  @override
  String get connection_duration => 'موده';

  @override
  String get connection_received => 'ترلاسه شوي';

  @override
  String get connection_sent => 'لېږل شوي';

  @override
  String get connection_lastHandshake => 'وروستۍ خوندي تبادله';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration مخکې';
  }

  @override
  String get verification_title => 'د خپل برېښنالیک پته تایید کړئ';

  @override
  String get verification_message =>
      'په دې تلیفون کې د VPN کارولو لپاره د خپل برېښنالیک پته تایید کړئ.';

  @override
  String get verification_resend => 'برېښنالیک بیا ولېږئ';

  @override
  String get migration_title => 'د ځای بدلون';

  @override
  String get migration_draining => 'د ځای بدلون چمتو کېږي…';

  @override
  String get migration_activating => 'نوی سرور فعالېږي…';

  @override
  String get migration_ready => 'ځای تازه شو.';

  @override
  String get migration_blocked =>
      'د ځای بدلون ته د سرور مداخله اړینه ده. وروسته بیا هڅه وکړئ یا له ملاتړ سره اړیکه ونیسئ.';

  @override
  String get migration_progress => 'د ځای بدلون پرمختګ';

  @override
  String migration_retryDelay(Object seconds) {
    return 'د کتنو ترمنځ ځنډ: $seconds ثانیې.';
  }

  @override
  String get migration_resume => 'د ځای بدلون بیا پیل کړئ';

  @override
  String get status_authorizing => 'اجازه اړینه ده';

  @override
  String get status_authorizingDetail =>
      'د VPN د اجازې لپاره د Android غوښتنه ومنئ.';

  @override
  String get status_preparing => 'چمتو کېږي';

  @override
  String get status_preparingDetail => 'ستاسو خوندي اتصال چمتو کېږي.';

  @override
  String get status_reconnecting => 'بیا وصلېږي…';

  @override
  String get status_reconnectingDetail =>
      'اتصال ګډوډ شو. VPN د بیا وصلېدو هڅه کوي.';

  @override
  String get status_connecting => 'وصلېږي';

  @override
  String get status_connectingDetail => 'د VPN سرور سره وصلېږي…';

  @override
  String get status_connected => 'وصل شوی';

  @override
  String get status_connectedDetail => 'ستاسو د VPN اتصال فعال دی.';

  @override
  String get status_disconnecting => 'قطع کېږي';

  @override
  String get status_disconnectingDetail => 'ستاسو د VPN اتصال بندېږي.';

  @override
  String get status_error => 'اتصال شتون نلري';

  @override
  String get status_errorDetail => 'د VPN اتصال تایید نشو. بیا هڅه وکړئ.';

  @override
  String get status_idle => 'قطع شوی';

  @override
  String get status_idleDetail => 'د خپل اتصال د خوندي کولو لپاره VPN وصل کړئ.';

  @override
  String get trust_note =>
      'د اپلیکیشن تړل VPN نه بندوي. د بندولو لپاره «قطع کړئ» وکاروئ.';

  @override
  String get locations_none => 'اوس مهال هېڅ ځای شتون نلري.';

  @override
  String get locations_available => 'خپل بل ځای وټاکئ.';

  @override
  String get locations_selected => 'ټاکل شوی ځای';

  @override
  String get locations_select => 'دا ځای وټاکئ';

  @override
  String get locations_lockedTunnel => 'د ځای بدلولو لپاره VPN قطع کړئ.';

  @override
  String get locations_lockedMigration =>
      'د ځای بدلون تر بشپړېدو پورې انتظار وکړئ.';

  @override
  String get devices_title => 'ستاسو وسایل';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit وسایل';
  }

  @override
  String get devices_refresh => 'وسایل تازه کړئ';

  @override
  String get devices_empty => 'تر اوسه هېڅ VPN وسیله ثبت شوې نه ده.';

  @override
  String get devices_firstConnection =>
      'ستاسو تلیفون به د لومړي اتصال پر مهال اضافه شي.';

  @override
  String get devices_thisDevice => 'دا وسیله';

  @override
  String devices_added(Object date) {
    return 'په $date اضافه شوې';
  }

  @override
  String get devices_unnamed => 'بې نومه وسیله';

  @override
  String get action_remove => 'لرې کړئ';

  @override
  String get settings_title => 'تنظیمات';

  @override
  String get settings_subtitle =>
      'ستاسو غوره توبونه او حساب، ټول په یو ځای کې.';

  @override
  String get settings_appearance => 'ظاهري بڼه';

  @override
  String get settings_language => 'ژبه';

  @override
  String get settings_languageDescription =>
      'ستاسو ټاکل شوې ژبه د VPN خبرتیاوو لپاره هم کارول کېږي.';

  @override
  String get settings_account => 'حساب';

  @override
  String get settings_signOut => 'له حساب ووځئ';

  @override
  String get settings_privacy => 'د محرمیت پالیسي';

  @override
  String get settings_terms => 'د کارونې شرایط';

  @override
  String get settings_security => 'امنیت او شفافیت';

  @override
  String get settings_licenses => 'د برخو جوازونه';

  @override
  String get settings_licensesDetail => 'په اپلیکیشن کې کارېدونکی سافټویر';

  @override
  String settings_licensesLegalese(String url) {
    return 'د اپلیکیشن او د هغې د MPL-2.0 برخو د سرچینې کوډ: $url';
  }

  @override
  String get settings_background =>
      'کله چې اپلیکیشن پرېږدئ، VPN فعال پاتې کېږي. د بندولو لپاره د اتصال په ټب کې «قطع کړئ» وکاروئ.';

  @override
  String get theme_system => 'سیسټم';

  @override
  String get theme_light => 'روښانه';

  @override
  String get theme_dark => 'تیاره';

  @override
  String get language_system => 'د تلیفون ژبه';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'دا وسیله لرې کړئ؟';

  @override
  String get dialog_removeCurrent =>
      'دا تلیفون به له VPN څخه قطع شي او لاسرسی به له لاسه ورکړي. د VPN د اتصال معلومات به د سرور له تایید وروسته لرې شي.';

  @override
  String dialog_removeOther(Object name) {
    return 'د «$name» لپاره د VPN لاسرسی به لغوه شي. دا کړنه نشي بېرته ګرځول کېدای.';
  }

  @override
  String get dialog_signOut => 'له حساب ووځئ؟';

  @override
  String get dialog_signOutMessage =>
      'VPN به بند شي او تاسو به بیا ننوتلو ته اړتیا ولرئ. ستاسو کوډ شوي VPN کلیډونه به د راتلونکي اتصال لپاره په همدې تلیفون کې پاتې شي.';

  @override
  String get action_cancel => 'لغوه کړئ';

  @override
  String get action_close => 'تړل';

  @override
  String get action_copy => 'کاپی';

  @override
  String get action_renew => 'نوی کړئ';

  @override
  String get action_signOut => 'ووځئ';

  @override
  String get notice_close => 'پیغام وتړئ';

  @override
  String get notice_sessionExpired_title => 'ناسته ختمه شوه';

  @override
  String get notice_sessionExpired_message =>
      'ستاسو ناسته ختمه شوه. بیا ننوځئ.';

  @override
  String get notice_connectionFailed_title => 'اتصال ناکام شو';

  @override
  String get notice_invalidCredentials_message =>
      'د برېښنالیک پته یا پټنوم سم نه دی.';

  @override
  String get notice_emailVerification_title => 'د برېښنالیک تایید اړین دی';

  @override
  String get notice_emailVerification_message =>
      'د VPN د وسیلې له اضافه کولو مخکې د خپل برېښنالیک پته تایید کړئ.';

  @override
  String get notice_rateLimited_title => 'ډېرې هڅې';

  @override
  String get notice_deviceLimit_title => 'د وسیلو حد پوره شو';

  @override
  String get notice_deviceLimit_message =>
      'د بلې وسیلې له اضافه کولو مخکې یوه شته وسیله لرې کړئ.';

  @override
  String get notice_identityRenewal_title => 'د VPN هویت باید نوی شي';

  @override
  String get notice_identityRenewal_message =>
      'دا هویت لرې شوی دی. نوی محلي هویت جوړ کړئ.';

  @override
  String get notice_migrationPending_title => 'د ځای بدلون روان دی';

  @override
  String get notice_migrationPending_message => 'د ځای بدلون لا دمخه روان دی.';

  @override
  String get notice_migrationBlocked_title => 'د ځای بدلون مسدود شو';

  @override
  String get notice_migrationBlocked_message =>
      'د ځای بدلون ته د سرور مداخله اړینه ده. وروسته بیا هڅه وکړئ یا له ملاتړ سره اړیکه ونیسئ.';

  @override
  String get notice_targetUnavailable_title => 'سرور د لنډ وخت لپاره شتون نلري';

  @override
  String get notice_targetUnavailable_message =>
      'دا سرور د لنډ وخت لپاره شتون نلري.';

  @override
  String get notice_networkUnavailable_title => 'د انټرنېټ اتصال شتون نلري';

  @override
  String get notice_networkUnavailable_message =>
      'خپل اتصال وګورئ او بیا هڅه وکړئ.';

  @override
  String get notice_permissionDenied_title => 'د VPN اجازه رد شوه';

  @override
  String get notice_permissionDenied_message =>
      'اتصال بیا پیل کړئ او د Android اجازې غوښتنه ومنئ.';

  @override
  String get notice_wireguardTimeout_title => 'سرور ځواب نه ورکوي';

  @override
  String get notice_wireguardTimeout_message =>
      'د WireGuard اتصال ډېر وخت ونیوه. بیا هڅه وکړئ یا بل ځای وټاکئ.';

  @override
  String get notice_tlsFailed_title => 'خوندي اتصال رد شو';

  @override
  String get notice_tlsFailed_message =>
      'سرور د OpenVPN اتصال رد کړ. بیا هڅه وکړئ. که ستونزه دوام وکړي، تشخیص پیل کړئ.';

  @override
  String get notice_tunRejected_title => 'Android د VPN انټرفېس رد کړ';

  @override
  String get notice_tunRejected_message =>
      'Android د OpenVPN لخوا غوښتل شوي د شبکې تنظیمات رد کړل.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN پیل نشو';

  @override
  String get notice_openvpnStart_message =>
      'د OpenVPN انجن پیل بشپړ نشو. بیا هڅه وکړئ. که ستونزه دوام وکړي، له ملاتړ سره اړیکه ونیسئ.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'د تشخیص کوډ: $code';
  }

  @override
  String get notice_generic_title => 'د VPN اتصال ناکام شو';

  @override
  String get notice_generic_message =>
      'یوه تېروتنه رامنځته شوه. وروسته بیا هڅه وکړئ.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'حساب جوړ شو',
      'password_reset_sent': 'د پټنوم د بیا تنظیمولو غوښتنه ترلاسه شوه',
      'verification_email_sent': 'د تایید برېښنالیک ولېږل شو',
      'location_migration_pending': 'د ځای بدلون روان دی',
      'vpn_sign_in_required': 'ننوتل اړین دی',
      'protocol_unavailable_at_location': 'پروتوکول شتون نلري',
      'vpn_permission_denied': 'د VPN اجازه رد شوه',
      'revoked_identity_device_limit': 'د وسیلو حد پوره شو',
      'tunnel_start_unexpected': 'VPN پیل نشو',
      'flutter_disconnect_timeout': 'قطع کېدل تایید نشو',
      'flutter_disconnect_unexpected': 'قطع کېدل ناکام شو',
      'device_revoked': 'وسیله لرې شوه',
      'revoke_unexpected': 'وسیله لرې نشوه',
      'identity_renewal_unexpected': 'هویت نوی نشو',
      'openvpn_renewal_unexpected': 'OpenVPN نوی نشو',
      'location_migration_blocked': 'د ځای بدلون مسدود شو',
      'location_migration_slow': 'د ځای بدلون لا هم روان دی',
      'location_migration_conflict': 'د ځای بدلون تازه کولو ته اړتیا لري',
      'location_migration_verification_failed': 'د ځای بدلون تایید نشو',
      'location_migration_device_changed': 'د ځای بدلون پر مهال وسیله بدله شوه',
      'tunnel_stop_failed': 'د ځای بدلون شتون نلري',
      'device_clock_ahead': 'د وسیلې ساعت مخکې دی',
      'other': 'عملیه ناکامه شوه',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'حساب جوړ شو، مګر د تایید برېښنالیک ونه لېږل شو. په اپلیکیشن کې د بیا لېږلو اختیار وکاروئ.',
      'password_reset_sent':
          'ستاسو غوښتنه ترلاسه شوه. که له دې پتې سره یو حساب مطابقت ولري، ښايي برېښنالیک ترلاسه کړئ. مهرباني وکړئ د هرزه برېښنالیکونو فولډر هم وګورئ.',
      'verification_email_sent': 'د تایید نوی برېښنالیک همدا اوس ولېږل شو.',
      'location_migration_pending':
          '$target ته د لېږد چمتووالی لا روان دی. تاسو کولای شئ وسیله له سره جوړولو پرته دا بیا پیل کړئ.',
      'vpn_sign_in_required': 'د VPN له پیلولو مخکې خپل حساب ته ننوځئ.',
      'protocol_unavailable_at_location':
          'ټاکل شوی پروتوکول په دې ځای کې وړاندې نه کېږي. ځایونه تازه کړئ یا بل پروتوکول وټاکئ.',
      'vpn_permission_denied':
          'Android د VPN اجازه رد کړه. اتصال بیا پیل کړئ او د سیسټم غوښتنه ومنئ.',
      'revoked_identity_device_limit':
          'د دې وسیلې د VPN لاسرسی لرې شو او د وسیلو حد پوره شوی دی. په حساب ← «خپلې وسیلې اداره کړئ» کې یوه وسیله لرې کړئ.',
      'tunnel_start_unexpected':
          'یوې ناڅاپي تېروتنې د تونل چمتووالی ګډوډ کړ. د تشخیص کوډ وګورئ او بیا هڅه وکړئ.',
      'flutter_disconnect_timeout':
          'Android په ټاکلي وخت کې تایید نه کړ چې VPN بند شو. بیا یې د بندولو هڅه وکړئ.',
      'flutter_disconnect_unexpected':
          'یوې ناڅاپي تېروتنې د تونل د بندېدو د تایید مخه ونیوله.',
      'device_revoked':
          'د وسیلې د VPN لاسرسی لغوه شو او محلي پټ معلومات لرې شول.',
      'revoke_unexpected':
          'وسیله نشي لرې کېدای. لېست تازه کړئ او بیا هڅه وکړئ.',
      'identity_renewal_unexpected':
          'د VPN نوی هویت جوړ نشو. وسایل تازه کړئ او بیا هڅه وکړئ.',
      'openvpn_renewal_unexpected':
          'د OpenVPN پروفایل نوی نشو. بیا هڅه وکړئ یا د تشخیص کوډ وګورئ.',
      'location_migration_blocked':
          'سرور همدا اوس دا بدلون بشپړولای نشي. وسیله او د هغې محلي هویت وساتل شول.',
      'location_migration_slow':
          'سرور لا هم $target ته لېږد چمتو کوي. څو شېبې وروسته «بیا پیل» وکاروئ.',
      'location_migration_conflict':
          'د وسیلې حالت په سرور کې بدل شو. وسایل تازه کړئ او وروسته دا بدلون بیا پیل کړئ.',
      'location_migration_verification_failed':
          'سرور نوی ځای تایید نه کړ. پخوانی محلي هویت وساتل شو.',
      'location_migration_device_changed':
          'هغه وسیله چې سرور بېرته ورکړه، نور له هغې وسیلې سره نه سمېږي چې بدلېږي. له بیا هڅې مخکې وسایل تازه کړئ.',
      'tunnel_stop_failed':
          'پخوانی تونل باید له نوي اتصال مخکې په بشپړه توګه بند شي.',
      'device_clock_ahead':
          'د دې وسیلې ساعت مخکې ښکاري. ترڅو ننوتي پاتې شئ، د نېټې او وخت اتوماتیک تنظیم فعال کړئ.',
      'other': 'عملیه بشپړه نشوه. بیا هڅه وکړئ یا د تشخیص کوډ ملاتړ ته ولېږئ.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ناسته ختمه شوه',
      'invalid_credentials': 'ننوتل ناکام شو',
      'email_verification_required': 'د برېښنالیک تایید اړین دی',
      'verification_email_cooldown': 'برېښنالیک لا دمخه لېږل شوی دی',
      'rate_limited': 'ډېرې هڅې',
      'invalid_registration': 'معلومات باید سم شي',
      'email_exists': 'حساب لا دمخه شتون لري',
      'invalid_profile': 'ناسم پروفایل',
      'invalid_device': 'ناسمه وسیله',
      'invalid_location': 'ځای شتون نلري',
      'device_limit': 'د وسیلو حد پوره شو',
      'device_exists': 'د VPN هویت لا دمخه کارول کېږي',
      'device_identity_revoked': 'د VPN هویت باید نوی شي',
      'device_location_locked': 'د ځای بدلون تازه کولو ته اړتیا لري',
      'location_migration_pending': 'د ځای بدلون روان دی',
      'location_migration_blocked': 'د ځای بدلون مسدود شو',
      'target_ca_mismatch': 'ناسازګار OpenVPN سرور',
      'location_migration_conflict': 'د ځای بدلون تازه کولو ته اړتیا لري',
      'server_full': 'سرور ډک دی',
      'capacity_unavailable': 'ځای د لنډ وخت لپاره شتون نلري',
      'target_unavailable': 'سرور د لنډ وخت لپاره شتون نلري',
      'not_found': 'توکی ونه موندل شو',
      'invalid_openvpn_csr': 'ناسم OpenVPN هویت',
      'openvpn_profile_exists': 'د OpenVPN پروفایل لا دمخه شتون لري',
      'openvpn_profile_revoked': 'د OpenVPN پروفایل لغوه شو',
      'openvpn_operation_pending': 'د OpenVPN عملیه روانه ده',
      'openvpn_operation_terminal': 'د OpenVPN عملیه ګډوډه شوه',
      'openvpn_address_unavailable': 'د OpenVPN پته شتون نلري',
      'openvpn_profile_conflict': 'د OpenVPN ټکر',
      'openvpn_signer_unavailable': 'OpenVPN شتون نلري',
      'email_delivery_unavailable': 'برېښنالیک شتون نلري',
      'invalid_token': 'ناسم لینک',
      'network_unavailable': 'د انټرنېټ اتصال شتون نلري',
      'invalid_json': 'ناسمه غوښتنه',
      'invalid_api_response': 'د سرور ناسم ځواب',
      'ipv6_unavailable': 'IPv6 شتون نلري',
      'invalid_ip_families': 'د شبکې تنظیمات رد شول',
      'other': 'خدمت شتون نلري',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ستاسو ناسته ختمه شوه. بیا ننوځئ.',
      'invalid_credentials': 'د برېښنالیک پته یا پټنوم سم نه دی.',
      'email_verification_required':
          'د VPN د وسیلې له اضافه کولو مخکې د خپل برېښنالیک پته تایید کړئ.',
      'invalid_registration': 'غوښتل شوي معلومات او موافقې وګورئ.',
      'email_exists': 'دا د برېښنالیک پته لا دمخه د یو حساب لخوا کارول کېږي.',
      'invalid_profile': 'د خپل پروفایل معلومات وګورئ.',
      'invalid_device': 'د دې وسیلې نوم یا محلي هویت ناسم دی.',
      'invalid_location': 'د ځایونو لېست تازه کړئ او بیا هڅه وکړئ.',
      'device_limit': 'د بلې وسیلې له اضافه کولو مخکې یوه شته وسیله لرې کړئ.',
      'device_exists': 'دا د VPN هویت لا دمخه له بل حساب سره تړل شوی دی.',
      'device_identity_revoked': 'دا هویت لرې شو. نوی محلي هویت باید جوړ شي.',
      'device_location_locked':
          'د دې وسیلې ځای همدا اوس بدل شو. اپلیکیشن به روان بدلون بیا پیل کړي.',
      'location_migration_pending': 'د ځای بدلون لا دمخه روان دی.',
      'location_migration_blocked':
          'د ځای بدلون ته د سرور مداخله اړینه ده. وروسته بیا هڅه وکړئ یا له ملاتړ سره اړیکه ونیسئ.',
      'target_ca_mismatch':
          'دا سرور لا د اوسني OpenVPN پروفایل سره سازګار نه دی.',
      'location_migration_conflict':
          'وسایل تازه کړئ، بیا د ځای بدلولو هڅه یو ځل بیا وکړئ.',
      'server_full':
          'دا ځای د اتصالاتو حد ته رسېدلی دی. بل ځای وټاکئ یا وروسته بیا هڅه وکړئ.',
      'capacity_unavailable':
          'موږ نشو کولای تایید کړو چې دا ځای همدا اوس شتون لري. بل ځای وټاکئ یا وروسته بیا هڅه وکړئ.',
      'target_unavailable': 'دا سرور د لنډ وخت لپاره شتون نلري.',
      'not_found': 'دا توکی نور ستاسو په حساب کې شتون نلري.',
      'invalid_openvpn_csr': 'نوی OpenVPN هویت جوړ کړئ او بیا هڅه وکړئ.',
      'openvpn_profile_exists':
          'د دې وسیلې لپاره لا دمخه د OpenVPN پروفایل شتون لري.',
      'openvpn_profile_revoked': 'د دوام لپاره د OpenVPN پروفایل نوی کړئ.',
      'openvpn_operation_pending': 'بدلون لا خپرېږي. وروسته بیا هڅه وکړئ.',
      'openvpn_operation_terminal': 'نوی OpenVPN هویت جوړ کړئ او بیا هڅه وکړئ.',
      'openvpn_address_unavailable': 'اوس مهال هېڅ د OpenVPN پته شتون نلري.',
      'openvpn_profile_conflict':
          'پروفایل بدل شو. وسایل تازه کړئ او بیا هڅه وکړئ.',
      'openvpn_signer_unavailable': 'د OpenVPN خدمت د لنډ وخت لپاره شتون نلري.',
      'email_delivery_unavailable':
          'برېښنالیک ونه لېږل شو. وروسته بیا هڅه وکړئ.',
      'invalid_token': 'دا لینک ناسم دی یا وخت یې ختم شوی دی. نوی یې وغواړئ.',
      'network_unavailable': 'د خپل انټرنېټ اتصال وګورئ او بیا هڅه وکړئ.',
      'invalid_json': 'لیکل شوي معلومات وګورئ او بیا هڅه وکړئ.',
      'invalid_api_response':
          'سرور یو غیرمنتظره ځواب بېرته ورکړ. وروسته بیا هڅه وکړئ.',
      'ipv6_unavailable':
          'سرور همدا اوس IPv6 فعالولای نشي. وروسته بیا هڅه وکړئ.',
      'invalid_ip_families':
          'د تونل تنظیمات نابشپړ دي یا له اجازه ورکړل شویو پتو سره نه سمېږي. له اپلیکیشن څخه بیا هڅه وکړئ.',
      'other': 'د سرور تېروتنه رامنځته شوه. وروسته بیا هڅه وکړئ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'څو شېبې وروسته بیا هڅه وکړئ.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds ثانیې وروسته بیا هڅه وکړئ.',
      one: '$seconds ثانیه وروسته بیا هڅه وکړئ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes دقیقې وروسته بیا هڅه وکړئ.',
      one: '$minutes دقیقه وروسته بیا هڅه وکړئ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ساعتونه وروسته بیا هڅه وکړئ.',
      one: '$hours ساعت وروسته بیا هڅه وکړئ.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'د سیسټم VPN بیا پیلول شتون نلري',
      'system_vpn_resume_corrupt': 'د سیسټم VPN بیا پیلول ناسم دی',
      'system_vpn_resume_session_invalid': 'د VPN د بیا پیلولو ناسته ناسمه ده',
      'system_vpn_resume_identity_changed': 'د VPN هویت بدل شو',
      'system_vpn_resume_identity_invalid': 'د VPN د بیا پیلولو هویت ناسم دی',
      'system_vpn_resume_storage_failed': 'د VPN د بیا پیلولو ذخیره شتون نلري',
      'system_vpn_resume_network_timeout': 'د VPN د بیا پیلولو لپاره شبکه نشته',
      'system_vpn_resume_blocked': 'د VPN بیا پیلول مسدود شو',
      'system_vpn_resume_failed': 'د VPN بیا پیلول ناکام شو',
      'system_vpn_resume_error_invalid': 'د VPN د بیا پیلولو تېروتنه ناسمه ده',
      'wireguard_identity_store_failed': 'د WireGuard هویت ونه ساتل شو',
      'wireguard_identity_unavailable': 'د WireGuard هویت شتون نلري',
      'vpn_host_destroyed': 'د Android VPN کوربه ودرېد',
      'vpn_host_unavailable': 'د Android VPN کوربه شتون نلري',
      'vpn_permission_required': 'د VPN اجازه اړینه ده',
      'vpn_permission_denied': 'د VPN اجازه رد شوه',
      'vpn_permission_request_failed': 'د اجازې غوښتنه ونه شوه',
      'wireguard_foreground_service_unavailable': 'د WireGuard خدمت شتون نلري',
      'wireguard_identity_invalid': 'د WireGuard محلي کلیډ ناسم دی',
      'wireguard_identity_in_use': 'د WireGuard هویت لا دمخه کارول کېږي',
      'wireguard_configuration_invalid': 'د WireGuard تنظیمات ناسم دي',
      'wireguard_operation_pending': 'د WireGuard عملیه لا فعاله ده',
      'wireguard_start_failed': 'د WireGuard پیل رد شو',
      'wireguard_stop_timeout': 'د WireGuard ودرېدل تایید نشو',
      'wireguard_handshake_timeout': 'WireGuard ځواب ورنکړ',
      'openvpn_connection_timeout': 'OpenVPN ځواب ورنکړ',
      'openvpn_core_unavailable': 'د OpenVPN انجن شتون نلري',
      'openvpn_operation_pending': 'د OpenVPN ناسته لا فعاله ده',
      'openvpn_stop_timeout': 'د OpenVPN ودرېدل تایید نشو',
      'openvpn_profile_unavailable': 'د OpenVPN محلي پروفایل نشته',
      'openvpn_native_failed': 'د OpenVPN بومي غوښتنه ګډوډه شوه',
      'openvpn_key_generation_failed': 'د OpenVPN P-256 کلیډ جوړ نشو',
      'openvpn_csr_generation_failed': 'د OpenVPN CSR جوړ نشو',
      'openvpn_identity_store_failed': 'د OpenVPN هویت ونه ساتل شو',
      'openvpn_identity_clear_failed': 'د OpenVPN هویت لرې کول بشپړ نشو',
      'openvpn_identity_in_use': 'د OpenVPN هویت لا کارول کېږي',
      'openvpn_tls_verification_required': 'د OpenVPN د TLS تایید نشته',
      'openvpn_cipher_invalid': 'د OpenVPN د کوډ کولو الګوریتم ناسم دی',
      'openvpn_profile_rejected': 'د OpenVPN پروفایل رد شو',
      'openvpn_identity_inconsistent': 'د OpenVPN هویت نه سمېږي',
      'tls_handshake_failed': 'د OpenVPN خبرې اترې رد شوې',
      'tls_alert_unknown_ca': 'د OpenVPN د کلاینټ سرټیفیکېټ نه پیژندل کېږي',
      'tls_alert_bad_certificate': 'د OpenVPN د کلاینټ سرټیفیکېټ رد شو',
      'tls_alert_unsupported_certificate': 'د OpenVPN سرټیفیکېټ ملاتړ نه کېږي',
      'tls_client_certificate_required': 'د OpenVPN د کلاینټ سرټیفیکېټ اړین دی',
      'tls_alert_misc': 'د OpenVPN TLS خبرداری',
      'tls_signature_algorithm_rejected': 'د OpenVPN لاسلیک ملاتړ نه کېږي',
      'tls_handshake_rejected': 'د OpenVPN TLS خبرې اترې رد شوې',
      'tls_version_rejected': 'د OpenVPN TLS نسخه ناسازګاره ده',
      'tls_certificate_expired': 'د TLS سرټیفیکېټ ختم شوی دی',
      'tls_certificate_revoked': 'د TLS سرټیفیکېټ لغوه شو',
      'transport_failed': 'د OpenVPN سرور ته لاسرسی نشته',
      'tun_configuration_rejected': 'د OpenVPN انټرفېس جوړ نشو',
      'tun_setup_failed': 'د OpenVPN TUN تنظیم ناکام شو',
      'tun_interface_create_failed': 'د OpenVPN انټرفېس جوړول ناکام شو',
      'tun_interface_disabled': 'د OpenVPN انټرفېس غیرفعال شو',
      'tun_halted': 'د OpenVPN انټرفېس ګډوډ شو',
      'tun_already_established': 'د OpenVPN انټرفېس لا دمخه پرانستل شوی دی',
      'tun_addresses_missing': 'د OpenVPN پته نشته',
      'tun_routes_missing': 'د OpenVPN لارې نشته',
      'tun_dns_missing': 'د OpenVPN DNS نشته',
      'tun_permission_revoked': 'د VPN اجازه لغوه شوه',
      'tun_establish_returned_null': 'Android د VPN انټرفېس رد کړ',
      'openvpn_service_start_failed': 'د OpenVPN خدمت شتون نلري',
      'openvpn_operation_timeout': 'د OpenVPN د غوښتنې وخت ختم شو',
      'openvpn_start_failed': 'د OpenVPN پیل رد شو',
      'openvpn_connection_failed': 'د OpenVPN اتصال ګډوډ شو',
      'openvpn_core_status_error': 'OpenVPN انجن په تېروتنه پای ته ورسېد',
      'openvpn_stopped_before_connected': 'OpenVPN له وصلېدو مخکې ودرېد',
      'openvpn_auth_failed': 'د OpenVPN تصدیق رد شو',
      'openvpn_client_setup_failed': 'د OpenVPN د کلاینټ تنظیم ناکام شو',
      'openvpn_client_halted': 'د OpenVPN کلاینټ ګډوډ شو',
      'openvpn_client_restart': 'د OpenVPN د بیا پیلولو غوښتنه وشوه',
      'openvpn_inactive_timeout': 'OpenVPN ډېر وخت غیرفعال و',
      'openvpn_session_expired': 'د OpenVPN ناسته ختمه شوه',
      'openvpn_credentials_required': 'د OpenVPN تصدیق ملاتړ نه کېږي',
      'openvpn_proxy_failed': 'د OpenVPN منځګړي لېږد ناکام شو',
      'openvpn_compression_failed': 'د OpenVPN فشرول رد شو',
      'openvpn_ntlm_crypto_unavailable': 'د OpenVPN NTLM کوډ کول شتون نلري',
      'openvpn_feature_unsupported': 'د OpenVPN ځانګړتیا ملاتړ نه کېږي',
      'network_unavailable': 'د انټرنېټ اتصال شتون نلري',
      'network_lost': 'شبکه شتون نلري',
      'certificate_validation_failed': 'د سرور سرټیفیکېټ رد شو',
      'openvpn_certificate_expired': 'د OpenVPN سرټیفیکېټ ختم شوی دی',
      'tunnel_active_for_another_account': 'د بل حساب تونل لا فعال دی',
      'tunnel_already_active': 'بومي تونل لا دمخه فعال دی',
      'tunnel_stop_timeout': 'د $protocol ودرېدل تایید نشو',
      'tunnel_disconnected': '$protocol ګډوډ شو',
      'native_bridge_unavailable': 'د Android پل شتون نلري',
      'native_operation_failed': 'د Android عملیه ګډوډه شوه',
      'invalid_arguments': 'د VPN پارامترونه نابشپړ دي',
      'invalid_account_id': 'د VPN حساب ناسم دی',
      'invalid_device_id': 'د وسیلې پېژندګر ناسم دی',
      'storage_key_not_allowed': 'د ذخیرې کلیډ رد شو',
      'secure_storage_read_failed': 'خوندي لوستل ناکام شو',
      'secure_storage_write_failed': 'خوندي لیکل ناکام شو',
      'key_generation_failed': 'د WireGuard کلیډ جوړ نشو',
      'csr_generation_failed': 'د OpenVPN CSR جوړ نشو',
      'openvpn_recovery_exhausted': 'د OpenVPN بیا رغونه مخکې کارول شوې ده',
      'openvpn_recovery_failed': 'د OpenVPN بیا رغونه ناکامه شوه',
      'openvpn_renewal_required': 'د OpenVPN سرټیفیکېټ نوي کول اړین دي',
      'other': 'نامعلومه بومي VPN تېروتنه',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android د بیا پیلولو وړ VPN ناسته نشي موندلای. په اپلیکیشن کې نوی اتصال پیل کړئ.',
      'system_vpn_resume_corrupt':
          'د VPN د بیا پیلولو ساتل شوي معلومات ناسم دي او نه به کارول کېږي. نوی اتصال پیل کړئ.',
      'system_vpn_resume_session_invalid':
          'ساتل شوې ناسته نور نشي کولای VPN بیا پیل کړي. په اپلیکیشن کې بیا ننوځئ.',
      'system_vpn_resume_identity_changed':
          'د VPN محلي هویت بدل شو. بیا پیلول ودرول شو؛ نوی اتصال پیل کړئ.',
      'system_vpn_resume_identity_invalid':
          'د بیا پیلولو هویت ناسم دی. نوی اتصال پیل کړئ.',
      'system_vpn_resume_storage_failed':
          'Android ونه توانېد چې د بیا پیلولو کوډ شوي معلومات ولولي یا تازه کړي. نوی اتصال پیل کړئ.',
      'system_vpn_resume_network_timeout':
          'Android د VPN د بیا پیلولو لپاره په وخت کې شبکه ونه موندله. کله چې شبکه شتون ولري، بیا هڅه وکړئ.',
      'system_vpn_resume_blocked':
          'د VPN بیا پیلول مسدود شوی دی. د Android تنظیمات وګورئ، بیا نوی اتصال پیل کړئ.',
      'system_vpn_resume_failed':
          'د Android لخوا د VPN بیا پیلول ناکام شو. په اپلیکیشن کې نوی اتصال پیل کړئ.',
      'system_vpn_resume_error_invalid':
          'Android د بیا پیلولو داسې تېروتنه بېرته ورکړه چې نشي کارول کېدای. نوی اتصال پیل کړئ.',
      'wireguard_identity_store_failed':
          'Android ونه توانېد چې د دې حساب کوډ شوی WireGuard هویت وساتي.',
      'wireguard_identity_unavailable':
          'د دې اتصال لپاره هېڅ د کارولو وړ WireGuard هویت شتون نلري.',
      'vpn_host_destroyed':
          'د Android هغه برخه چې VPN یې کوربه توب کاوه، ودرېده. نوی اتصال پیل کړئ.',
      'vpn_host_unavailable':
          'Android نشي کولای هغه برخه جوړه کړي چې VPN کوربه توب کوي. د VPN تنظیمات وګورئ او بیا هڅه وکړئ.',
      'openvpn_renewal_required':
          'د OpenVPN سرټیفیکېټ په اتوماتیک ډول نوی نه شو کړای. په اپلیکیشن کې نوی اتصال پیل کړئ.',
      'openvpn_recovery_failed':
          'اتوماتیک بیا رغونه ناکامه شوه. په اپلیکیشن کې نوی اتصال پیل کړئ.',
      'openvpn_recovery_exhausted':
          'اتوماتیک بیا رغونه مخکې کارول شوې ده. په اپلیکیشن کې نوی اتصال پیل کړئ.',
      'vpn_permission_required':
          'Android د تونل له پیلېدو مخکې نوې VPN اجازه غواړي.',
      'vpn_permission_denied':
          'د دوام لپاره د Android په غوښتنه کې FuzeVPN ته اجازه ورکړئ.',
      'vpn_permission_request_failed':
          'Android ونه توانېد چې د VPN د اجازې سکرین خلاص کړي.',
      'wireguard_foreground_service_unavailable':
          'Android ونه توانېد چې د WireGuard خدمت په مخکینۍ بڼه وساتي.',
      'wireguard_identity_invalid':
          'د دې حساب کوډ شوی WireGuard کلیډ نه لوستل کېږي یا ناسم دی.',
      'wireguard_identity_in_use':
          'بله عملیه لا هم د دې حساب WireGuard کلیډ کاروي.',
      'wireguard_configuration_invalid':
          'ترلاسه شوې WireGuard پته، DNS، د سرور کلیډ یا لارې ناسمې دي.',
      'wireguard_operation_pending':
          'د WireGuard پخوانۍ عملیې خپل بومي خدمت لا نه دی خوشې کړی.',
      'wireguard_start_failed': 'د WireGuard انجن د تنظیماتو فعالول رد کړل.',
      'wireguard_stop_timeout':
          'د WireGuard خدمت په ټاکلې موده کې د VPN د انټرفېس خوشې کېدل تایید نه کړ.',
      'wireguard_handshake_timeout':
          'تونل په ټاکلې موده کې د سرور سره هینډشیک تایید نه کړ.',
      'openvpn_connection_timeout':
          'OpenVPN په ټاکلې موده کې له سرور سره اتصال تایید نه کړ.',
      'openvpn_core_unavailable':
          'د دې اپلیکیشن نسخه د کارولو وړ OpenVPN انجن نه لري.',
      'openvpn_operation_pending':
          'بومي انجن لا هم پخوانۍ OpenVPN ناسته ساتي او دویمه ناسته جوړولو ته انکار کوي.',
      'openvpn_stop_timeout':
          'OpenVPN انجن په ټاکلې موده کې دا تایید نه کړ چې د هغه بومي ناسته ودرېده او له منځه لاړه.',
      'openvpn_profile_unavailable':
          'د دې اتصال لپاره هېڅ تایید شوی OpenVPN پروفایل نه لوستل کېږي.',
      'openvpn_native_failed':
          'د اپلیکیشن یوې تېروتنې OpenVPN ګډوډ کړ. بیا د وصلېدو هڅه وکړئ. که ستونزه دوام وکړي، تشخیص پیل کړئ.',
      'openvpn_key_generation_failed':
          'Android Keystore ونه توانېد چې نه صادرېدونکی P-256 خصوصي کلیډ جوړ کړي یا ولولي.',
      'openvpn_csr_generation_failed':
          'د Android Keystore کلیډ ونه توانېد چې د OpenVPN د سرټیفیکېټ غوښتنه لاسلیک کړي.',
      'openvpn_identity_store_failed':
          'د OpenVPN سرټیفیکېټ یا پروفایل په کوډ شوې ذخیره کې ونه ساتل شو.',
      'openvpn_identity_clear_failed':
          'Android ونه توانېد چې د دې حساب ټول محلي OpenVPN هویت لرې کړي.',
      'openvpn_identity_in_use':
          'یوه بومي OpenVPN ناسته لا هم د دې وسیلې کلیډ یا سرټیفیکېټ کاروي.',
      'openvpn_tls_verification_required':
          'پروفایل په څرګند ډول د سرور د سرټیفیکېټ تایید نه غواړي.',
      'openvpn_cipher_invalid':
          'سرور داسې د کوډ کولو الګوریتم وړاندې کړ چې په اجازه ورکړل شوي لېست کې نشته.',
      'openvpn_profile_rejected':
          'له سرور څخه ترلاسه شوی پروفایل ناسازګار دی. دا وسیله بیا جوړه کړئ او بیا هڅه وکړئ.',
      'openvpn_identity_inconsistent':
          'سرټیفیکېټ د دې تلیفون له خوندي هویت سره نه سمېږي. هېڅ محلي پروفایل نه دی بدل شوی.',
      'tls_handshake_failed':
          'سرور د TLS خبرې اترې رد کړې. که ستونزه دوام وکړي، پروفایل بیا جوړ کړئ.',
      'tls_alert_unknown_ca':
          'سرور د دې وسیلې د سرټیفیکېټ مرجع نه پیژني. د OpenVPN سرور باید وکتل شي.',
      'tls_alert_bad_certificate':
          'سرور د دې وسیلې سرټیفیکېټ رد کړ. له بیا هڅې مخکې وسیله بیا جوړه کړئ.',
      'tls_alert_unsupported_certificate':
          'سرور د هغه خوندي سرټیفیکېټ ډول ملاتړ نه کوي چې Android یې کاروي.',
      'tls_client_certificate_required':
          'سرور د کلاینټ سرټیفیکېټ غواړي، خو OpenVPN انجن ونه توانېد چې یو وړاندې کړي.',
      'tls_alert_misc':
          'سرور یو TLS خبرداری راستون کړ چې د سرټیفیکېټ او نسخې له کټګوریو بهر دی.',
      'tls_signature_algorithm_rejected':
          'سرور د Android Keystore د کلیډ ECDSA P-256 الګوریتم رد کړ.',
      'tls_handshake_rejected': 'سرور له اتصال مخکې د TLS خبرې اترې ګډوډې کړې.',
      'tls_version_rejected': 'کلاینټ او سرور ګډه TLS نسخه ونه موندله.',
      'tls_certificate_expired':
          'هغه سرټیفیکېټ چې د اتصال پر مهال وړاندې شو، ختم شوی دی.',
      'tls_certificate_revoked':
          'هغه سرټیفیکېټ چې د اتصال پر مهال وړاندې شو، لغوه شوی دی.',
      'transport_failed':
          'د OpenVPN سرور په اوسنۍ شبکه کې ځواب نه ورکوي. لږ وروسته بیا هڅه وکړئ.',
      'tun_configuration_rejected':
          'Android د OpenVPN لخوا غوښتل شوي د شبکې تنظیمات رد کړل.',
      'tun_setup_failed':
          'OpenVPN انجن د Android د انټرفېس له جوړولو مخکې د شبکې پلان رد کړ.',
      'tun_interface_create_failed':
          'OpenVPN انجن ونه توانېد چې له Android VpnService څخه TUN انټرفېس ترلاسه کړي.',
      'tun_interface_disabled':
          'Android یا OpenVPN انجن د اتصال پر مهال TUN انټرفېس غیرفعال کړ.',
      'tun_halted': 'OpenVPN انجن د TUN انټرفېس د ودرولو غوښتنه ترلاسه کړه.',
      'tun_already_established':
          'OpenVPN په همدې اتصال کې دویم انټرفېس وغوښت. تونل د خوندیتوب لپاره ودرول شو.',
      'tun_addresses_missing': 'سرور د تونل لپاره د کارولو وړ پته ونه ورکړه.',
      'tun_routes_missing': 'سرور د تونل لپاره د کارولو وړ لارې ونه ورکړې.',
      'tun_dns_missing': 'سرور د کارولو وړ DNS سرور ونه ورکړ.',
      'tun_permission_revoked': 'Android د اتصال پر مهال د VPN اجازه لغوه کړه.',
      'tun_establish_returned_null':
          'Android انټرفېس جوړ نه کړ، معمولاً ځکه چې بل VPN لا هم فعال دی.',
      'openvpn_service_start_failed':
          'Android ونه توانېد چې د OpenVPN د مخکینۍ بڼې خدمت پیل کړي.',
      'openvpn_operation_timeout':
          'OpenVPN انجن ته د JNI غوښتنې خپله اعظمي موده تېره کړه.',
      'openvpn_start_failed':
          'د Android خدمت چمتو دی، خو OpenVPN انجن د پروفایل پیلول ونه منل.',
      'openvpn_connection_failed':
          'OpenVPN انجن د CONNECTED پېښې له خپرولو مخکې ودرېد.',
      'openvpn_core_status_error':
          'بومي OpenVPN لوپ په تېروتنه پای ته ورسېد او بله دقیقه پای پېښه نه وه.',
      'openvpn_stopped_before_connected':
          'بومي OpenVPN لوپ د CONNECTED له پېښې مخکې ودرېد، پرته له څرګندې د انجن تېروتنې.',
      'openvpn_auth_failed': 'د OpenVPN سرور د پروفایل تصدیق رد کړ.',
      'openvpn_client_setup_failed':
          'OpenVPN انجن ونه توانېد چې د شبکې له اتصال مخکې کلاینټ چمتو کړي.',
      'openvpn_client_halted':
          'OpenVPN انجن د کلاینټ وروستۍ ودرېدنه ترلاسه کړه.',
      'openvpn_client_restart':
          'OpenVPN انجن د خپلې لېږد ناستې بیا پیلول وغوښتل.',
      'openvpn_inactive_timeout':
          'OpenVPN انجن د بې فعالیتۍ د مودې تر پای وروسته ناسته وتړله.',
      'openvpn_session_expired': 'سرور راپور ورکړ چې د OpenVPN ناسته ختمه شوه.',
      'openvpn_credentials_required':
          'سرور یا پروکسي داسې لاسي تصدیقي معلومات غواړي چې د دې سرټیفیکېټ پروفایل برخه نه دي.',
      'openvpn_proxy_failed':
          'OpenVPN انجن د تنظیم شوي پروکسي یا منځګړي د ناکامۍ راپور ورکړ.',
      'openvpn_compression_failed':
          'OpenVPN انجن هغه فشرولو حالت رد کړ چې پروفایل یا سرور اعلان کړ.',
      'openvpn_ntlm_crypto_unavailable':
          'پروفایل داسې NTLM کوډ کول غواړي چې په دې نسخه کې شتون نلري.',
      'openvpn_feature_unsupported':
          'پروفایل یا سرور داسې ځانګړتیا غواړي چې په دې Android کلاینټ کې نشته.',
      'network_unavailable': 'هېڅ د کارولو وړ فزیکي شبکه شتون نلري.',
      'network_lost': 'د شبکې له لاسه ورکولو وروسته تونل ودرول شو.',
      'certificate_validation_failed': 'د OpenVPN سرور هویت تایید نشو.',
      'openvpn_certificate_expired':
          'د OpenVPN سرټیفیکېټ ختم شوی دی. د نوي کولو لپاره یې په اپلیکیشن کې نوی اتصال پیل کړئ.',
      'tunnel_active_for_another_account':
          'له دې اتصال مخکې باید د بل حساب تونل ودرول شي.',
      'tunnel_already_active':
          'Android راپور ورکوي چې پخوانۍ VPN ناسته لا هم انټرفېس کاروي.',
      'tunnel_stop_timeout':
          'د $protocol انجن په ټاکلې موده کې د VPN د انټرفېس خوشې کېدل تایید نه کړ.',
      'tunnel_disconnected':
          'بومي انجن راپور ورکړ چې تونل له پیل وروسته په ناڅاپي ډول پای ته ورسېد.',
      'native_bridge_unavailable':
          'اپلیکیشن د Android VPN خدمت ته لاسرسی نه لري. اپلیکیشن وتړئ، بیا یې خلاص کړئ او بیا هڅه وکړئ.',
      'native_operation_failed':
          'د اپلیکیشن یوې تېروتنې د VPN عملیه ګډوډه کړه. بیا هڅه وکړئ. که ستونزه دوام وکړي، تشخیص پیل کړئ.',
      'invalid_arguments':
          'د دې VPN عملیې لپاره اړین معلومات نابشپړ دي. بیا هڅه وکړئ. که ستونزه دوام وکړي، تشخیص پیل کړئ.',
      'invalid_account_id': 'بومي عملیه د سم حساب پېژندګر سره نه ده تړل شوې.',
      'invalid_device_id':
          'بومي انجن ته لېږل شوی د وسیلې پېژندګر نشته یا ناسم دی.',
      'storage_key_not_allowed':
          'د Android پل داسې کلیډ مسدود کړ چې د اجازه ورکړل شوي ذخیرې په لېست کې نه و.',
      'secure_storage_read_failed':
          'Android Keystore ونه توانېد چې د دې حساب محلي معلومات د کوډ له حالت څخه راوباسي.',
      'secure_storage_write_failed':
          'Android Keystore ونه توانېد چې محلي معلومات کوډ کړي یا وساتي.',
      'key_generation_failed':
          'Android ونه توانېد چې په خوندي ذخیره کې WireGuard کلیډ جوړ کړي یا ولولي.',
      'csr_generation_failed':
          'Android Keystore ونه توانېد چې د OpenVPN P-256 CSR جوړ یا لاسلیک کړي.',
      'other':
          'یوه نامستند بومي برخه ناکامه شوه. لاندې ښودل شوی د تشخیص کوډ ملاتړ ته ولېږئ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'د اجازې غوښتنه لا دمخه خلاصه ده';

  @override
  String get notice_permissionRequestInProgress_message =>
      'د Android د VPN د اجازې غوښتنه لا دمخه ښودل شوې ده. له بیا هڅې مخکې یې بشپړه کړئ.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'د VPN د اجازې غوښتنه ګډوډه شوه';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'د VPN د اجازې سکرین له دې مخکې وتړل شو چې اپلیکیشن ځواب ترلاسه کړي.';

  @override
  String get notice_openvpnProofMissing_title => 'د OpenVPN اتصال تایید نشو';

  @override
  String get notice_openvpnProofMissing_message =>
      'د OpenVPN اتصال تایید نشو. د خوندیتوب لپاره ودرول شو. بیا هڅه وکړئ.';

  @override
  String get openvpnCleanup_title => 'د OpenVPN پروفایل لغوه شو';

  @override
  String get openvpnCleanup_working =>
      'لغوه شوی OpenVPN پروفایل ودرول کېږي او لرې کېږي…';

  @override
  String get openvpnCleanup_stopFailed =>
      'د OpenVPN بندېدل تایید نشو. له دې مخکې چې نوی پروفایل جوړ کړئ، بیا هڅه وکړئ.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'لغوه شوی OpenVPN پروفایل په بشپړه توګه لرې نشو. د پاکولو بیا هڅه وکړئ.';

  @override
  String get openvpnCleanup_complete =>
      'لغوه شوی OpenVPN پروفایل لرې شو. د نوي جوړولو لپاره «وصل کړئ» ټچ کړئ.';

  @override
  String get network_title => 'د شبکې تنظیمات';

  @override
  String get network_ipv4Fallback =>
      'IPv6 د لنډ وخت لپاره شتون نلري. چمتووالی د IPv4 سره دوام کوي.';

  @override
  String get network_rejectedTitle => 'د شبکې تنظیمات رد شول';

  @override
  String get network_rejectedMessage =>
      'د تونل تنظیمات نابشپړ دي یا له اجازه ورکړل شویو پتو سره نه سمېږي. له اپلیکیشن څخه بیا هڅه وکړئ.';

  @override
  String get network_unreadableTitle => 'محلي تنظیمات نه لوستل کېږي';

  @override
  String get network_unreadableMessage =>
      'د OpenVPN د شبکې ساتل شوي تنظیمات نشي کارول کېدای. د تازه کولو لپاره له اپلیکیشن څخه بیا وصل شئ.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'د شبکې ساتنه';

  @override
  String get protection_subtitle =>
      'که VPN قطع شي، مستقیم انټرنېټ لاسرسی مسدود کړئ.';

  @override
  String get protection_active => 'د سیسټم ساتنه فعاله ده';

  @override
  String get protection_alwaysOnOnly =>
      'همېشه فعال VPN فعال دی؛ له VPN بهر د اتصالاتو مسدودول فعال کړئ';

  @override
  String get protection_inactive => 'د سیسټم ساتنه غیرفعاله ده';

  @override
  String get protection_unknown => 'د سیسټم ساتنه وګورئ';

  @override
  String get protection_openSettings => 'د Android تنظیمات خلاص کړئ';

  @override
  String get protection_dialogTitle => 'د شبکې ساتنه تنظیم کړئ';

  @override
  String get protection_dialogMessage =>
      'Android د همېشه فعال VPN او له VPN بهر د اتصالاتو د مسدودولو اداره کوي. وګورئ چې FuzeVPN ټاکل شوی وي او د سیسټم په تنظیماتو کې مسدودول فعال کړئ.';

  @override
  String get protection_dialogOpen => 'تنظیمات خلاص کړئ';

  @override
  String get session_systemProtectionNote =>
      'که Android لا هم له VPN بهر ټرافیک مسدودوي، د دې ساتنې د کتلو یا بدلولو لپاره د سیسټم تنظیمات خلاص کړئ.';

  @override
  String get diagnostics_title => 'تشخیص';

  @override
  String get diagnostics_settingsTitle => 'د اپلیکیشن تشخیص';

  @override
  String get diagnostics_automaticTitle => 'مهمې تېروتنې ولېږئ';

  @override
  String get diagnostics_automaticDescription =>
      'کله چې مهمه تېروتنه رامنځته شي، یو کوچنی تخنیکي راپور شریک کړئ.';

  @override
  String get diagnostics_privacy =>
      'لېږل شوي راپورونه له ننوتي حساب سره تړلي دي او 30 ورځې ساتل کېږي. دوی د انټرنېټ د کتنې تاریخچه، پټنومونه یا VPN کلیډونه نه لري.';

  @override
  String get diagnostics_manualOpen => 'تشخیص پیل کړئ';

  @override
  String get diagnostics_localDescription =>
      'د اپلیکیشن او VPN د حالت راپور جوړ کړئ. ستاسو اتصال نه بدلېږي.';

  @override
  String get diagnostics_sendReport => 'راپور ولېږئ';

  @override
  String get diagnostics_sendHint =>
      'دا خانه نښه مه کوئ، ترڅو راپور په دې وسیله کې پاتې شي.';

  @override
  String get diagnostics_signedOut => 'د راپور لېږلو لپاره خپل حساب ته ننوځئ.';

  @override
  String get diagnostics_localLifetime =>
      'د اپلیکیشن له تړلو وروسته د ساتلو لپاره دا راپور په خپل تلیفون کې وساتئ.';

  @override
  String get diagnostics_run => 'تشخیص پیل کړئ';

  @override
  String get diagnostics_rerun => 'تشخیص بیا پیل کړئ';

  @override
  String get diagnostics_running => 'کتنه روانه ده…';

  @override
  String get diagnostics_sending => 'راپور لېږل کېږي…';

  @override
  String get diagnostics_prepared => 'راپور په دې وسیله کې چمتو دی';

  @override
  String get diagnostics_queued => 'راپور د لېږلو په تمه دی';

  @override
  String get diagnostics_sent => 'راپور ترلاسه شو';

  @override
  String get diagnostics_failed =>
      'لېږل ناکام شو. ستاسو محلي راپور لا هم شتون لري.';

  @override
  String get diagnostics_preparationFailed =>
      'د تشخیص راپور چمتو نشو. بیا هڅه وکړئ.';

  @override
  String get diagnostics_authenticationRequired =>
      'د راپور لېږلو لپاره بیا ننوځئ.';

  @override
  String get diagnostics_retry => 'بیا ولېږئ';

  @override
  String get diagnostics_export => 'راپور وساتئ';

  @override
  String get diagnostics_exportFailed =>
      'ساتل ناکام شو. له محلي راپور څخه بیا هڅه وکړئ.';

  @override
  String get diagnostics_preferenceFailed =>
      'دا تنظیم ونه ساتل شو. بیا هڅه وکړئ.';

  @override
  String diagnostics_receipt(Object id) {
    return 'ماخذ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'په $date ترلاسه شو';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'تر $date پورې ساتل کېږي';
  }

  @override
  String get diagnostics_duplicate => 'دا راپور لا دمخه ترلاسه شوی و.';

  @override
  String get diagnostics_preview => 'د راپور مخکتنه';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تخنیکي پېښې ضمیمه شوې دي',
      one: '1 تخنیکي پېښه ضمیمه شوې ده',
      zero: 'هېڅ تخنیکي پېښه ضمیمه شوې نه ده',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'تخنیکي جزئیات';

  @override
  String get diagnostics_empty => 'تر اوسه هېڅ تشخیصي راپور چمتو شوی نه دی.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'د تونل حالت',
      'handshake': 'د اتصال تایید',
      'certificate': 'د VPN سرټیفیکېټ',
      'kill_switch': 'د Android ساتنه',
      'connectivity': 'شته شبکه',
      'api_reachability': 'د خدمت لاسرسی',
      'secure_storage': 'خوندي ذخیره',
      'other': 'محلي کتنه',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'تایید شو',
      'failed': 'پاملرنې ته اړتیا لري',
      'skipped': 'ازمویل شوی نه دی — فعاله ازموینه نشته',
      'unknown': 'معلومات شتون نلري',
      'other': 'معلومات شتون نلري',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN ته ښه راغلاست';

  @override
  String get connection_changeLocation => 'ځای بدل کړئ';

  @override
  String get connection_details => 'د اتصال جزئیات';

  @override
  String get locations_searchLabel => 'ښار یا هېواد ولټوئ';

  @override
  String get locations_clearSearch => 'لټون پاک کړئ';

  @override
  String get locations_filterAll => 'ټول';

  @override
  String get locations_filterFavorites => 'خوښې';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ځایونه',
      one: '$count ځای',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'هېڅ ځای ونه موندل شو';

  @override
  String get locations_noResultsHint => 'بل ښار یا هېواد وازمویئ.';

  @override
  String get locations_noFavorites => 'ستاسو خوښې، ستاسو لاس ته نږدې';

  @override
  String get locations_noFavoritesHint =>
      'د ځای ترڅنګ ستوری ټچ کړئ، ترڅو دلته وساتل شي.';

  @override
  String get locations_showAll => 'ټول ځایونه وګورئ';

  @override
  String locations_addFavorite(String name) {
    return '$name خوښو ته اضافه کړئ';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name له خوښو لرې کړئ';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'دا خوښه ونه ساتل شوه. بیا هڅه وکړئ.';

  @override
  String get locations_emptyTitle => 'هېڅ ځای شتون نلري';

  @override
  String get locations_emptyHint => 'د بیا هڅې لپاره لېست تازه کړئ.';

  @override
  String get devices_manage => 'خپلې وسیلې اداره کړئ';

  @override
  String get settings_personalization => 'ستاسو د خوښې سره سم';

  @override
  String get settings_safety => 'ساتنه';

  @override
  String get settings_help => 'مرستې ته اړتیا لرئ؟';

  @override
  String get settings_about => 'د FuzeVPN په اړه';

  @override
  String get diagnostics_heading => 'د اتصال ستونزه درک کړئ';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'شتون لري',
      'pending': 'چمتو کېږي',
      'revoked': 'لرې شو',
      'expired': 'ختم شوی',
      'other': 'حالت شتون نلري',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'غوره توب ونه ساتل شو';

  @override
  String get notice_preferenceSave_message =>
      'ستاسو ټاکنه اوس پلی شوې ده، خو ونه ساتل شوه. د اپلیکیشن له تړلو وروسته د ساتلو لپاره بیا هڅه وکړئ.';

  @override
  String get connection_androidDisconnectHint =>
      'که Android VPN فعال وساتي، په هغو تنظیماتو کې چې خلاصېږي، همېشه فعال VPN غیرفعال کړئ.';

  @override
  String get connection_certificate => 'د OpenVPN سرټیفیکېټ';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'تر $date پورې اعتبار لري';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'په $date ختم شوی';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'په راتلونکي اتصال کې په اتوماتیک ډول نوی کېږي.';

  @override
  String get protection_learnMore => 'د Android د ساتنې په اړه زده کړئ';

  @override
  String get protection_guideWhy =>
      'دا ساتنه د دې مخه نیسي چې که VPN قطع شي، اپلیکیشنونه مستقیم انټرنېټ وکاروي. دا په Android کې تنظیمېږي.';

  @override
  String get protection_guideAlwaysOnTitle => 'همېشه فعال VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android د VPN خدمت فعال ساتي او د تلیفون له بیا پیلېدو وروسته یې بیا پیلولای شي.';

  @override
  String get protection_guideBlockTitle => 'له VPN پرته اتصالات مسدود کړئ';

  @override
  String get protection_guideBlock =>
      'دا تنظیم د دې مخه نیسي چې ټرافیک له VPN بهر تېر شي، حتی هغه مهال چې اتصال ګډوډ وي.';

  @override
  String get protection_guideWarning =>
      'کله چې دا مسدودول فعال وي، تر هغه مهاله چې VPN وصل نه شي، انټرنېټ بند پاتې کېږي.';

  @override
  String get protection_guideStepsTitle => 'ساتنه فعاله کړئ';

  @override
  String get protection_guideStep1 =>
      'د لاندې تڼۍ په مرسته د Android VPN تنظیمات خلاص کړئ.';

  @override
  String get protection_guideStep2 =>
      'د FuzeVPN ترڅنګ د ګیر آیکن په مرسته اختیارونه خلاص کړئ.';

  @override
  String get protection_guideStep3 =>
      'که دا اختیارونه شتون ولري، «همېشه فعال VPN» او بیا «له VPN پرته اتصالات مسدود کړئ» فعال کړئ.';

  @override
  String get protection_guideManufacturers =>
      'نومونه د تلیفون له مخې توپیر لري. که اړتیا وي، په تنظیماتو کې VPN ولټوئ؛ ډېری وخت دا د «شبکه او انټرنېټ» په برخه کې وي.';

  @override
  String get protection_guideDisableTitle => 'دا ساتنه غیرفعاله کړئ';

  @override
  String get protection_guideDisable =>
      'په همدې تنظیماتو کې، که غواړئ له VPN پرته انټرنېټ وکاروئ، له VPN پرته د اتصالاتو مسدودول غیرفعال کړئ. که نور نه غواړئ چې Android یې بیا پیل کړي، همېشه فعال VPN هم غیرفعال کړئ.';

  @override
  String get protection_guideManual =>
      'دا تنظیمات تاسو په Android کې ټاکئ. FuzeVPN دا ستاسو پر ځای نه بدلوي.';

  @override
  String get locations_changeTitle => 'ځای بدل کړئ؟';

  @override
  String locations_changeActive(String name) {
    return 'VPN به قطع شي، بیا به د $name سره د وصلېدو هڅه وکړي.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN به د $name سره د وصلېدو هڅه وکړي.';
  }

  @override
  String get locations_confirmChange => 'بدل کړئ او وصل کړئ';

  @override
  String get locations_changeBusy =>
      'بدلون روان دی. بل ځای له ټاکلو مخکې انتظار وکړئ.';

  @override
  String get locations_automaticSelection => 'اتوماتیک ټاکنه';

  @override
  String get locations_cities => 'ښارونه';

  @override
  String get locations_servers => 'سرورونه';

  @override
  String locations_viewCities(String name) {
    return 'د $name ښارونه وګورئ';
  }

  @override
  String locations_viewServers(String name) {
    return 'د $name سرورونه وګورئ';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count هېوادونه',
      one: '$count هېواد',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ښارونه',
      one: '$count ښار',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سرورونه',
      one: '$count سرور',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ټول هېوادونه';

  @override
  String get locations_backToCountries => 'بېرته هېوادونو ته';

  @override
  String locations_backToCities(String name) {
    return 'بېرته د $name ښارونو ته';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name وټاکئ';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name وټاکئ';
  }

  @override
  String get locations_noCompatibleServer => 'هېڅ سازګار سرور شتون نلري.';

  @override
  String get externalLink_failed =>
      'دا لینک خلاص نشو. تاسو کولای شئ دا کاپي کړئ او په خپل براوزر کې یې خلاص کړئ.';

  @override
  String get externalLink_copy => 'لینک کاپي کړئ';

  @override
  String get externalLink_copied => 'لینک کاپي شو';

  @override
  String get externalLink_copyFailed => 'لینک کاپي نشو. لاندې پته وټاکئ.';

  @override
  String get settings_deleteAccount => 'خپل حساب حذف کړئ';

  @override
  String get settings_deleteAccountDetail =>
      'د حساب د حذف کولو د غوښتنې پروسه وګورئ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'خپل VPN ګډون وټاکئ.';

  @override
  String get billing_subscribe => 'ګډون وکړئ';

  @override
  String get billing_choosePlan => 'د دوام لپاره یو پلان وټاکئ.';

  @override
  String get billing_monthly => 'میاشتنی';

  @override
  String get billing_yearly => 'کلنی';

  @override
  String get billing_continue => 'د Google Play سره دوام ورکړئ';

  @override
  String get billing_restore => 'پیرودنې بېرته راوړئ';

  @override
  String get billing_manage => 'ګډون اداره کړئ';

  @override
  String get billing_deleteAccountWarning =>
      'که تاسو د Google Play ګډون لرئ، ستاسو د FuzeVPN حساب حذف کول د هغه تمدید نه لغوه کوي. تمدید په Google Play کې په جلا توګه اداره یا لغوه کړئ.';

  @override
  String get billing_deleteAccountContinue =>
      'د حساب د حذف غوښتنې ته دوام ورکړئ';

  @override
  String get billing_refresh => 'لاسرسی تازه کړئ';

  @override
  String get billing_loadingPlans => 'پلانونه بارول کېږي…';

  @override
  String get billing_unavailable =>
      'اوس مهال هېڅ پلان شتون نلري. وروسته بیا هڅه وکړئ.';

  @override
  String get billing_comingSoon => 'ګډونونه ډېر ژر راتلونکي دي.';

  @override
  String get billing_priceDisclosure =>
      'بیه د Google Play لخوا ورکول کېږي. وروستی مبلغ او پلي کېدونکي مالیات ستاسو له تایید مخکې تاییدېږي.';

  @override
  String get billing_renewalMonthly =>
      'که لغوه نه شي، هره میاشت په اتوماتیک ډول تمدیدېږي. تاسو کولای شئ هر وخت د Google Play په ګډونونو کې دا لغوه کړئ.';

  @override
  String get billing_renewalYearly =>
      'که لغوه نه شي، هر کال په اتوماتیک ډول تمدیدېږي. تاسو کولای شئ هر وخت د Google Play په ګډونونو کې دا لغوه کړئ.';

  @override
  String get billing_active => 'ستاسو د Premium لاسرسی فعال دی';

  @override
  String billing_accessUntil(String date) {
    return 'لاسرسی تر $date پورې.';
  }

  @override
  String get billing_webManaged =>
      'ستاسو ګډون د FuzeVPN په وېب پاڼه کې اداره کېږي.';

  @override
  String get billing_playManaged => 'ستاسو ګډون د Google Play لخوا اداره کېږي.';

  @override
  String get billing_playOnHold =>
      'ستاسو د Google Play ګډون ځنډول شوی دی یا د تادیې په تمه دی. د سمولو لپاره په Google Play کې «ګډون اداره کړئ» خلاص کړئ.';

  @override
  String get billing_playReceiptUnlinked =>
      'دا Google Play حساب لا دمخه د Fuze Premium ګډون لري چې د دې FuzeVPN حساب لپاره فعال نه دی. د کتلو لپاره په Google Play کې «ګډون اداره کړئ» خلاص کړئ.';

  @override
  String get billing_inactive => 'هېڅ فعال ګډون نشته.';

  @override
  String get billing_checkingAccess => 'ستاسو د لاسرسي کتنه روانه ده…';

  @override
  String get billing_restoring => 'پیرودنې بېرته راوړل کېږي…';

  @override
  String get billing_pending =>
      'تادیه په انتظار کې ده. ستاسو لاسرسی به له تایید وروسته فعال شي.';

  @override
  String get billing_cancelled => 'پیرود لغوه شو. هېڅ نوی ګډون فعال نشو.';

  @override
  String get billing_verifying => 'پیرود تاییدېږي…';

  @override
  String get billing_success => 'ګډون فعال شو. ستاسو د Premium لاسرسی چمتو دی.';

  @override
  String get billing_restored => 'ستاسو پیرودنې بېرته راوړل شوې دي.';

  @override
  String get billing_restoreEmpty =>
      'د دې Google Play حساب لپاره د بېرته راوړلو وړ پیرودنې نشته.';

  @override
  String get billing_catalogError => 'پلانونه بار نشول. بیا هڅه وکړئ.';

  @override
  String get billing_purchaseError => 'پیرود پیل نشو. بیا هڅه وکړئ.';

  @override
  String get billing_verificationError =>
      'د پیرود تایید د لنډ وخت لپاره شتون نلري. د بیا هڅې لپاره پیرودنې بېرته راوړئ.';

  @override
  String get billing_restoreError => 'پیرودنې بېرته راوړل نشوې. بیا هڅه وکړئ.';

  @override
  String get billing_managementError =>
      'د ګډون د اداره کولو پاڼه خلاصه نشوه. بیا هڅه وکړئ.';

  @override
  String get billing_storeUnavailable => 'Google Play پر دې وسیله شتون نلري.';

  @override
  String get welcome_title => 'ستاسو VPN، په ساده ډول.';

  @override
  String get welcome_description =>
      'خپل اتصال خوندي کړئ. خپل محرمیت په خپل واک کې وساتئ.';

  @override
  String get welcome_start => 'پیل کړئ';

  @override
  String get welcome_alreadyPurchased => 'مخکې مو پیرود کړی دی؟';

  @override
  String get welcome_noAccountRequired => 'د پیل لپاره حساب ته اړتیا نشته.';

  @override
  String get guest_accountTitle => 'حساب نه دی تړل شوی';

  @override
  String get guest_accountDescription =>
      'په بلې وسیله کې د خپل ګډون د کارولو لپاره، له همدې Google Play حساب سره خپلې پیرودنې بېرته راوړئ.';

  @override
  String get guest_existingSubscriberSignIn => 'مخکې مو ګډون کړی دی؟ ننوځئ';

  @override
  String get guest_claimTitle => 'FuzeVPN له ځان سره واخلئ';

  @override
  String get guest_claimDescription =>
      'په خپلو نورو وسیلو کې د خپل ګډون د کارولو لپاره یو حساب جوړ کړئ. دا ګام اختیاري دی.';

  @override
  String get guest_skip => 'وروسته';

  @override
  String get guest_activationTitle => 'Fuze Premium فعال دی';

  @override
  String get guest_activationDescription =>
      'ستاسو ګډون چمتو دی. خپل VPN وکاروئ او هر کله چې وغواړئ، حساب جوړ کړئ.';

  @override
  String get guest_useVpn => 'خپل VPN وکاروئ';

  @override
  String get guest_loginRequired =>
      'دا پیرود لا دمخه د FuzeVPN له یو حساب سره تړل شوی دی. خپل ګډون ته د لاسرسي لپاره همدې حساب ته ننوځئ.';

  @override
  String get guest_signOutWarning =>
      'تاسو کولای شئ له همدې Google Play حساب سره د پیرودنو په بېرته راوړلو سره خپل ګډون بېرته ترلاسه کړئ.';

  @override
  String get guest_profileUnavailable =>
      'ستاسو حساب لا دمخه تړل شوی دی. د خپلو معلوماتو د کتلو او اداره کولو لپاره ننوځئ.';

  @override
  String get billing_acceptance =>
      'په دوام ورکولو سره، تاسو د کارونې شرایط او د محرمیت پالیسي منئ.';

  @override
  String get guest_verifyEmailReminder =>
      'د خپل حساب د خوندي کولو لپاره د خپل برېښنالیک پته تایید کړئ. تاسو کولای شئ خپل VPN کارولو ته دوام ورکړئ.';

  @override
  String get guest_serviceUnavailable =>
      'دا خدمت د لنډ وخت لپاره شتون نلري. لږ وروسته بیا هڅه وکړئ.';

  @override
  String get guest_restoreError =>
      'ستاسو پیرودنې بېرته راوړل نشوې. له هغه Google Play حساب سره بیا هڅه وکړئ چې د پیرود لپاره مو کارولی و.';

  @override
  String get guest_claimSuccess =>
      'ستاسو حساب جوړ شو. ستاسو ګډون او VPN ته لاسرسی ساتل شوي دي.';

  @override
  String get guest_emailExists =>
      'دا برېښنالیک لا دمخه کارول شوی دی. بله پته وټاکئ یا خپل شته حساب ته ننوځئ. ستاسو پیرود بیا هم د Google Play له لارې شتون لري.';

  @override
  String get guest_claimError =>
      'ستاسو حساب جوړ نشو. تاسو کولای شئ خپل VPN کارولو ته دوام ورکړئ او وروسته بیا هڅه وکړئ.';

  @override
  String get guest_secureStorageError =>
      'ستاسو ناسته په دې وسیله کې خوندي نشوه. بیا هڅه وکړئ.';

  @override
  String get guest_premiumRequired =>
      'د خپل VPN د فعالولو لپاره یو ګډون وټاکئ.';

  @override
  String get welcome_viewPlans => 'پلانونه وګورئ';

  @override
  String get google_continue => 'د Google سره دوام ورکړئ';

  @override
  String get google_or => 'یا';

  @override
  String get google_title => 'ستاسو FuzeVPN حساب';

  @override
  String get google_settingUp => 'خپل حساب جوړول بشپړ کړئ';

  @override
  String get google_country => 'د استوګنې هېواد';

  @override
  String get google_profileDescription =>
      'خپل هېواد وټاکئ او د FuzeVPN د حساب د جوړولو لپاره دواړه اسناد وګورئ.';

  @override
  String get google_claimDescription =>
      'خپل میلمه حساب له Google سره وتړئ. ستاسو ګډون او وسیله به له همدې حساب سره تړلي پاتې شي.';

  @override
  String get google_linkTitle => 'Google له FuzeVPN سره وتړئ';

  @override
  String get google_linkDescription =>
      'خپل شته FuzeVPN حساب ته لاسرسی تایید کړئ. دا ګام ستاسو د Google پټنوم نه غواړي.';

  @override
  String get google_password => 'د FuzeVPN پټنوم';

  @override
  String get google_linkAccount => 'تړل تایید کړئ';

  @override
  String get google_requestEmail => 'ما ته د تایید برېښنالیک ولېږئ';

  @override
  String get google_emailInstructions =>
      'د FuzeVPN برېښنالیک خلاص کړئ او د تایید کوډ ولیکئ.';

  @override
  String get google_emailCode => 'د برېښنالیک د تایید کوډ';

  @override
  String get google_confirmEmail => 'کوډ تایید کړئ';

  @override
  String get google_restart => 'بل Google حساب وټاکئ';

  @override
  String get google_resume => 'دا هڅه وګورئ';

  @override
  String get google_unavailable =>
      'د Google له لارې ننوتل شتون نلري. تاسو کولای شئ برېښنالیک او پټنوم وکاروئ.';

  @override
  String get google_expired =>
      'دا هڅه ختمه شوې ده. دا لغوه کړئ او بیا پیل کړئ.';

  @override
  String get google_conflict =>
      'دا Google حساب لا دمخه بل ځای تړل شوی دی. ستاسو اوسنی حساب او ګډون ساتل شوي دي.';

  @override
  String get google_error =>
      'د Google له لارې ننوتل ناکام شو. بیا هڅه وکړئ؛ ستاسو اوسنی لاسرسی ساتل شوی دی.';

  @override
  String get google_uncertain =>
      'پایله تایید نشوه. دا هڅه وګورئ یا له بیا پیل مخکې یې لغوه کړئ.';

  @override
  String get google_cancelFailed =>
      'لغوه کول تایید نشو. له دې سکرین څخه د وتلو مخکې بیا د لغوه کولو هڅه وکړئ.';

  @override
  String get google_cancelled => 'د Google له لارې ننوتل لغوه شو.';

  @override
  String get google_selecting => 'خپل Google حساب وټاکئ…';

  @override
  String get google_verifying => 'ستاسو د حساب کتنه روانه ده…';

  @override
  String get google_emailUnavailable =>
      'د تایید برېښنالیک ونه لېږل شو. وروسته بیا هڅه وکړئ.';

  @override
  String get google_emailSent =>
      'د تایید برېښنالیک ولېږل شو. خپل ان باکس وګورئ.';

  @override
  String get google_rateLimited =>
      'مهرباني وکړئ، له بیا هڅې مخکې یو څه انتظار وکړئ.';

  @override
  String get google_busy =>
      'Google هغه مهال شتون نلري چې بله عملیه روانه وي (د VPN اتصال، حساب یا میلمه). کله چې بشپړه شي، بیا هڅه وکړئ؛ ستاسو اوسنی لاسرسی ساتل شوی دی.';

  @override
  String get google_invalidPassword =>
      'د FuzeVPN پټنوم ناسم دی. ستاسو اوسنی حساب ساتل شوی دی.';

  @override
  String get google_invalidCode => 'د تایید کوډ ناسم یا ختم شوی دی.';

  @override
  String get google_accountChanged =>
      'ستاسو ناسته بدله شوې ده. له بیا پیل مخکې دا هڅه لغوه کړئ.';

  @override
  String get google_invalidResponse =>
      'ځواب تایید نشو. ستاسو اوسنی لاسرسی ساتل شوی دی.';

  @override
  String get google_invalidRegistration => 'خپل هېواد او دواړه موافقې وګورئ.';

  @override
  String get google_consentRequired =>
      'د دوام لپاره خپل هېواد وټاکئ او دواړه اسناد ومنئ.';

  @override
  String get google_challengeRequired =>
      'یوه اضافي امنیتي کتنه اړینه ده. ستاسو اوسنی لاسرسی ساتل شوی دی.';

  @override
  String get google_challengeUnavailable =>
      'امنیتي کتنه شتون نلري. وروسته بیا هڅه وکړئ.';

  @override
  String get google_intentMismatch =>
      'د Google له لارې د ننوتلو یوه پخوانۍ هڅه لا هم په انتظار کې ده. له دې عملیې د پیلولو مخکې یې لغوه کړئ.';

  @override
  String get google_challengeBlocked =>
      'اړینه امنیتي کتنه په دې اپلیکیشن کې شتون نلري. دا عملیه اوس نشي بشپړېدای.';

  @override
  String get google_solveChallenge => 'امنیتي کتنه بشپړه کړئ';

  @override
  String get google_challengeTitle => 'امنیتي کتنه';

  @override
  String get google_challengeReady =>
      'کتنه بشپړه شوه. اوس تاسو کولای شئ د خپل حساب جوړېدل تایید کړئ.';

  @override
  String get google_challengeExpired =>
      'کتنه ختمه شوې ده. له تایید مخکې یې بیا بشپړه کړئ.';

  @override
  String get google_challengeCancelled =>
      'کتنه لغوه شوه. تاسو کولای شئ بیا یې هڅه وکړئ.';

  @override
  String get google_challengeFailed => 'امنیتي کتنه ناکامه شوه. بیا هڅه وکړئ.';

  @override
  String get billing_trialTitle => 'Fuze Premium وړیا وازمویئ';

  @override
  String get billing_trialSubtitle => 'له نن څخه خپل اتصال خوندي کړئ.';

  @override
  String get billing_trialWeeks => 'د 2 اونیو وړیا ازموینه';

  @override
  String billing_trialDays(String days) {
    return 'د $days ورځو وړیا ازموینه';
  }

  @override
  String get billing_trialStart => 'خپله وړیا ازموینه پیل کړئ';

  @override
  String billing_trialFirstCharge(String date) {
    return 'که نن پیل کړئ، ستاسو لومړۍ تادیه د $date په نېټه تمه کېږي.';
  }

  @override
  String get billing_trialTerms =>
      'په ښودل شوې بیه په اتوماتیک ډول تمدیدېږي. د تادیې د مخنیوي لپاره، د ازموینې له پای مخکې په Google Play کې لغوه کړئ.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'بیا $price په میاشت کې';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'بیا $price په کال کې';
  }

  @override
  String get billing_choosePeriod => 'خپل پلان وټاکئ';

  @override
  String get billing_selectionHint => 'د دوام لپاره یو پلان وټاکئ.';

  @override
  String get billing_benefitConnection => 'کوډ شوی اتصال';

  @override
  String get billing_benefitPrivacy => 'آنلاین محرمیت';

  @override
  String get billing_benefitNoAccount => 'نوم لیکنې ته اړتیا نشته';

  @override
  String get billing_cancellation => 'په Google Play کې لغوه کړئ';

  @override
  String get billing_premiumTitle => 'یو ښه خوندي اتصال.';

  @override
  String get billing_premiumSubtitle => 'خپل اتصال خوندي کړئ، په خپل وخت.';

  @override
  String get billing_priceMonthly => 'په میاشت کې';

  @override
  String get billing_priceYearly => 'په کال کې';

  @override
  String get billing_trialToday => 'نن هېڅ تادیه نشته';

  @override
  String get billing_trialConfirmation =>
      'Google Play ستاسو له تایید مخکې نېټې، وروستی مبلغ او پلي کېدونکي مالیات تاییدوي.';

  @override
  String get billing_offerChanged =>
      'د دې وړاندیز شرایط بدل شوي دي. پلانونه تازه کړئ او بیا وټاکئ.';

  @override
  String get status_waitingNetwork => 'د شبکې په تمه';

  @override
  String get status_waitingNetworkDetail =>
      'هېڅ شبکه شتون نلري. کله چې شبکه بېرته راشي، VPN به اتصال تایید کړي.';

  @override
  String get locations_favoriteLoadFailed => 'خوښې بار نشوې. بیا هڅه وکړئ.';

  @override
  String get locations_favoritesLoading => 'خوښې بارول کېږي…';
}
