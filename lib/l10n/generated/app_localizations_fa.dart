// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get vpnDisclosure_title => 'از اتصال خود محافظت کنید';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN از سرویس VPN اندروید (VpnService) برای ایجاد تونلی رمزگذاری‌شده بین این دستگاه و سرورهای FuzeVPN استفاده می‌کند.';

  @override
  String get vpnDisclosure_dataBody =>
      'وقتی VPN فعال است، ترافیک اینترنت برنامه‌های شما، نشانی‌های مقصد و درخواست‌های DNS از این تونل عبور می‌کنند تا اتصال شما مسیریابی شود، حتی وقتی FuzeVPN در پس‌زمینه اجرا می‌شود.';

  @override
  String get vpnDisclosure_statusBody =>
      'برنامه از وضعیت اتصال، مدت آن و حجم داده‌های منتقل‌شده برای نمایش اتصال VPN شما استفاده می‌کند. می‌توانید هر زمان آن را متوقف کنید.';

  @override
  String get vpnDisclosure_privacy => 'حریم خصوصی';

  @override
  String get vpnDisclosure_accept => 'پذیرش و ادامه';

  @override
  String get vpnDisclosure_decline => 'الان نه';

  @override
  String get accountRestoration_title => 'حساب موقتاً در دسترس نیست';

  @override
  String get accountRestoration_message =>
      'نشست شما حفظ شده است. برای بازیابی حساب دوباره تلاش کنید؛ همچنان می‌توانید اتصال وی‌پی‌ان را از اینجا مدیریت کنید.';

  @override
  String get action_retry => 'دوباره تلاش کنید';

  @override
  String get session_endingTitle => 'در حال پایان دادن به نشست';

  @override
  String get session_ending =>
      'نشست شما باطل شده است. وی‌پی‌ان متوقف و نشست پاک می‌شود…';

  @override
  String get session_stopFailed =>
      'خاموش شدن وی‌پی‌ان تأیید نشد. پیش از ورود دوباره تلاش کنید.';

  @override
  String get session_cleanupFailed =>
      'وی‌پی‌ان متوقف شده است، اما حذف نشست تأیید نشد. پاک‌سازی را دوباره انجام دهید.';

  @override
  String get session_retryStop => 'تلاش دوباره برای خاموش کردن';

  @override
  String get session_retryCleanup => 'تلاش دوباره برای پاک‌سازی';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'در حال آماده‌سازی امن FuzeVPN…';

  @override
  String get nav_connection => 'اتصال';

  @override
  String get nav_locations => 'مکان‌ها';

  @override
  String get nav_account => 'حساب';

  @override
  String get nav_devices => 'دستگاه‌ها';

  @override
  String get nav_settings => 'تنظیمات';

  @override
  String get action_refresh => 'تازه‌سازی';

  @override
  String get auth_tab_login => 'ورود';

  @override
  String get auth_tab_register => 'ثبت‌نام';

  @override
  String get auth_stepAccount => 'حساب';

  @override
  String get auth_stepIdentity => 'هویت';

  @override
  String get auth_stepAddress => 'نشانی و توافق‌ها';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'مرحله $current از $total';
  }

  @override
  String get auth_tagline => 'وی‌پی‌ان شما، ساده و بی‌دردسر.';

  @override
  String get auth_keysLocal =>
      'کلیدهای خصوصی وی‌پی‌ان شما روی همین دستگاه باقی می‌مانند.';

  @override
  String get form_email => 'نشانی ایمیل';

  @override
  String get form_password => 'گذرواژه';

  @override
  String get form_showPassword => 'نمایش گذرواژه';

  @override
  String get form_hidePassword => 'پنهان کردن گذرواژه';

  @override
  String get form_passwordMin =>
      '۸ تا ۷۲ بایت UTF-8. بعضی نویسه‌ها بیش از یک بایت مصرف می‌کنند.';

  @override
  String get form_firstName => 'نام';

  @override
  String get form_lastName => 'نام خانوادگی';

  @override
  String get form_phone => 'تلفن (+33612345678)';

  @override
  String get form_address => 'نشانی';

  @override
  String get form_address2 => 'خط دوم نشانی (اختیاری)';

  @override
  String get form_postalCode => 'کد پستی';

  @override
  String get form_city => 'شهر';

  @override
  String get form_country => 'کد کشور (برای نمونه FR)';

  @override
  String get action_login => 'ورود';

  @override
  String get action_createAccount => 'ایجاد حساب';

  @override
  String get action_createMyAccount => 'ایجاد حساب من';

  @override
  String get action_next => 'ادامه';

  @override
  String get action_previous => 'بازگشت';

  @override
  String get action_forgotPassword => 'گذرواژه را فراموش کرده‌اید؟';

  @override
  String get auth_noAccount => 'هنوز حسابی ندارید؟';

  @override
  String get auth_requiredInformation => 'حساب خود را در سه مرحله ایجاد کنید.';

  @override
  String get auth_termsPrefix => 'من موافقم با ';

  @override
  String get auth_termsLink => 'شرایط استفاده';

  @override
  String get auth_privacyPrefix => 'من موافقم با ';

  @override
  String get auth_privacyLink => 'سیاست حفظ حریم خصوصی';

  @override
  String get auth_consentRequired => 'برای ایجاد حساب، موافقت شما لازم است.';

  @override
  String get validation_required => 'پر کردن این فیلد الزامی است.';

  @override
  String get validation_email => 'یک نشانی ایمیل معتبر وارد کنید.';

  @override
  String get validation_password =>
      'گذرواژه بیش از حد کوتاه است: حداقل ۸ بایت UTF-8 لازم است.';

  @override
  String get validation_passwordTooLong =>
      'گذرواژه بیش از حد طولانی است: حداکثر ۷۲ بایت UTF-8 مجاز است.';

  @override
  String get validation_phone =>
      'از قالب بین‌المللی استفاده کنید؛ برای نمونه +33612345678.';

  @override
  String get validation_country =>
      'از کد دوحرفی کشور استفاده کنید؛ برای نمونه FR.';

  @override
  String get passwordReset_title => 'بازنشانی گذرواژه';

  @override
  String get passwordReset_description =>
      'نشانی ایمیل حساب خود را وارد کنید تا پیوند بازنشانی گذرواژه برایتان ارسال شود.';

  @override
  String get passwordReset_send => 'ارسال پیوند';

  @override
  String get connection_title => 'اتصال شما';

  @override
  String get connection_subtitle =>
      'یک مکان انتخاب کنید، سپس وی‌پی‌ان خود را روشن کنید.';

  @override
  String get connection_prepare => 'برای اتصال آماده‌اید؟';

  @override
  String get connection_advancedOptions => 'گزینه‌های پیشرفته';

  @override
  String get connection_location => 'مکان';

  @override
  String get connection_chooseLocation => 'انتخاب مکان';

  @override
  String get connection_protocol => 'پروتکل';

  @override
  String get connection_connect => 'اتصال';

  @override
  String get connection_connecting => 'در حال اتصال…';

  @override
  String get connection_disconnect => 'قطع اتصال';

  @override
  String get connection_disconnecting => 'در حال قطع اتصال';

  @override
  String get connection_locationChange => 'در حال تغییر مکان…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol در دسترس نیست';
  }

  @override
  String get connection_activeLocation => 'مکان فعال';

  @override
  String get connection_duration => 'مدت';

  @override
  String get connection_received => 'دریافت‌شده';

  @override
  String get connection_sent => 'ارسال‌شده';

  @override
  String get connection_lastHandshake => 'آخرین تبادل امن';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration پیش';
  }

  @override
  String get verification_title => 'نشانی ایمیل خود را تأیید کنید';

  @override
  String get verification_message =>
      'برای استفاده از وی‌پی‌ان در این تلفن، نشانی ایمیل خود را تأیید کنید.';

  @override
  String get verification_resend => 'ارسال دوباره ایمیل';

  @override
  String get migration_title => 'تغییر مکان';

  @override
  String get migration_draining => 'در حال آماده‌سازی تغییر مکان…';

  @override
  String get migration_activating => 'در حال فعال‌سازی سرور جدید…';

  @override
  String get migration_ready => 'مکان به‌روزرسانی شد.';

  @override
  String get migration_blocked =>
      'تغییر مکان به مداخله سرور نیاز دارد. بعداً دوباره تلاش کنید یا با پشتیبانی تماس بگیرید.';

  @override
  String get migration_progress => 'پیشرفت تغییر مکان';

  @override
  String migration_retryDelay(Object seconds) {
    return 'فاصله بین بررسی‌ها: $seconds ثانیه.';
  }

  @override
  String get migration_resume => 'ادامه تغییر مکان';

  @override
  String get status_authorizing => 'اجازه لازم است';

  @override
  String get status_authorizingDetail =>
      'درخواست Android را بپذیرید تا وی‌پی‌ان مجاز شود.';

  @override
  String get status_preparing => 'در حال آماده‌سازی';

  @override
  String get status_preparingDetail => 'در حال آماده‌سازی اتصال امن شما.';

  @override
  String get status_reconnecting => 'در حال اتصال دوباره…';

  @override
  String get status_reconnectingDetail =>
      'اتصال قطع شده است. وی‌پی‌ان در حال تلاش برای اتصال دوباره است.';

  @override
  String get status_connecting => 'در حال اتصال';

  @override
  String get status_connectingDetail => 'در حال اتصال به سرور وی‌پی‌ان…';

  @override
  String get status_connected => 'متصل';

  @override
  String get status_connectedDetail => 'اتصال وی‌پی‌ان شما فعال است.';

  @override
  String get status_disconnecting => 'در حال قطع اتصال';

  @override
  String get status_disconnectingDetail =>
      'اتصال وی‌پی‌ان شما در حال متوقف شدن است.';

  @override
  String get status_error => 'اتصال در دسترس نیست';

  @override
  String get status_errorDetail =>
      'اتصال وی‌پی‌ان تأیید نشد. دوباره تلاش کنید.';

  @override
  String get status_idle => 'قطع‌شده';

  @override
  String get status_idleDetail =>
      'برای محافظت از اتصال خود، وی‌پی‌ان را متصل کنید.';

  @override
  String get trust_note =>
      'بستن برنامه وی‌پی‌ان را متوقف نمی‌کند. برای توقف آن، از «قطع اتصال» استفاده کنید.';

  @override
  String get locations_none => 'در حال حاضر هیچ مکانی در دسترس نیست.';

  @override
  String get locations_available => 'مکان بعدی خود را انتخاب کنید.';

  @override
  String get locations_selected => 'مکان انتخاب‌شده';

  @override
  String get locations_select => 'انتخاب این مکان';

  @override
  String get locations_lockedTunnel =>
      'برای تغییر مکان، اتصال وی‌پی‌ان را قطع کنید.';

  @override
  String get locations_lockedMigration => 'صبر کنید تا تغییر مکان تمام شود.';

  @override
  String get devices_title => 'دستگاه‌های شما';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit دستگاه';
  }

  @override
  String get devices_refresh => 'تازه‌سازی دستگاه‌ها';

  @override
  String get devices_empty => 'هنوز هیچ دستگاه وی‌پی‌انی ثبت نشده است.';

  @override
  String get devices_firstConnection =>
      'تلفن شما در نخستین اتصال اضافه می‌شود.';

  @override
  String get devices_thisDevice => 'این دستگاه';

  @override
  String devices_added(Object date) {
    return 'در $date اضافه شد';
  }

  @override
  String get action_remove => 'حذف';

  @override
  String get settings_title => 'تنظیمات';

  @override
  String get settings_subtitle => 'ترجیحات و حساب شما، همه در یک مکان.';

  @override
  String get settings_appearance => 'ظاهر';

  @override
  String get settings_language => 'زبان';

  @override
  String get settings_languageDescription =>
      'زبان انتخابی شما برای اعلان‌های وی‌پی‌ان نیز اعمال می‌شود.';

  @override
  String get settings_account => 'حساب';

  @override
  String get settings_signOut => 'خروج';

  @override
  String get settings_privacy => 'سیاست حفظ حریم خصوصی';

  @override
  String get settings_terms => 'شرایط استفاده';

  @override
  String get settings_security => 'امنیت و شفافیت';

  @override
  String get settings_licenses => 'مجوزهای مؤلفه‌ها';

  @override
  String get settings_licensesDetail => 'نرم‌افزار استفاده‌شده در برنامه';

  @override
  String get settings_background =>
      'وقتی برنامه را ترک می‌کنید، وی‌پی‌ان روشن می‌ماند. برای توقف آن، در زبانه اتصال گزینه «قطع اتصال» را بزنید.';

  @override
  String get theme_system => 'سیستم';

  @override
  String get theme_light => 'روشن';

  @override
  String get theme_dark => 'تیره';

  @override
  String get language_system => 'زبان تلفن';

  @override
  String get language_fr => 'فرانسوی';

  @override
  String get language_en => 'انگلیسی';

  @override
  String get language_es => 'اسپانیایی';

  @override
  String get language_de => 'آلمانی';

  @override
  String get dialog_removeDevice => 'این دستگاه حذف شود؟';

  @override
  String get dialog_removeCurrent =>
      'اتصال این تلفن به وی‌پی‌ان قطع و دسترسی آن لغو می‌شود. داده‌های اتصال وی‌پی‌ان پس از تأیید سرور حذف خواهند شد.';

  @override
  String dialog_removeOther(Object name) {
    return 'دسترسی وی‌پی‌ان برای «$name» لغو می‌شود. این کار قابل بازگشت نیست.';
  }

  @override
  String get dialog_signOut => 'خارج شوید؟';

  @override
  String get dialog_signOutMessage =>
      'وی‌پی‌ان متوقف می‌شود و باید دوباره وارد شوید. کلیدهای رمزگذاری‌شده وی‌پی‌ان شما برای اتصال بعدی روی این تلفن باقی می‌مانند.';

  @override
  String get action_cancel => 'لغو';

  @override
  String get action_signOut => 'خروج';

  @override
  String get notice_close => 'بستن پیام';

  @override
  String get notice_sessionExpired_title => 'نشست منقضی شد';

  @override
  String get notice_sessionExpired_message =>
      'نشست شما منقضی شده است. دوباره وارد شوید.';

  @override
  String get notice_connectionFailed_title => 'اتصال ناموفق بود';

  @override
  String get notice_invalidCredentials_message =>
      'نشانی ایمیل یا گذرواژه نادرست است.';

  @override
  String get notice_emailVerification_title => 'تأیید ایمیل لازم است';

  @override
  String get notice_emailVerification_message =>
      'پیش از افزودن دستگاه وی‌پی‌ان، نشانی ایمیل خود را تأیید کنید.';

  @override
  String get notice_rateLimited_title => 'تلاش‌های بیش از حد';

  @override
  String get notice_deviceLimit_title => 'محدودیت دو دستگاه به پایان رسید';

  @override
  String get notice_deviceLimit_message =>
      'پیش از افزودن دستگاه دیگر، یک دستگاه موجود را حذف کنید.';

  @override
  String get notice_identityRenewal_title => 'هویت وی‌پی‌ان باید نوسازی شود';

  @override
  String get notice_identityRenewal_message =>
      'این هویت حذف شده است. یک هویت محلی جدید ایجاد کنید.';

  @override
  String get notice_migrationPending_title => 'تغییر مکان در حال انجام است';

  @override
  String get notice_migrationPending_message =>
      'تغییر مکان از قبل در حال انجام است.';

  @override
  String get notice_migrationBlocked_title => 'تغییر مکان مسدود شد';

  @override
  String get notice_migrationBlocked_message =>
      'تغییر مکان به مداخله سرور نیاز دارد. بعداً دوباره تلاش کنید یا با پشتیبانی تماس بگیرید.';

  @override
  String get notice_targetUnavailable_title => 'سرور موقتاً در دسترس نیست';

  @override
  String get notice_targetUnavailable_message =>
      'این سرور موقتاً در دسترس نیست.';

  @override
  String get notice_networkUnavailable_title => 'اتصال اینترنت در دسترس نیست';

  @override
  String get notice_networkUnavailable_message =>
      'اتصال خود را بررسی و دوباره تلاش کنید.';

  @override
  String get notice_permissionDenied_title => 'اجازه وی‌پی‌ان رد شد';

  @override
  String get notice_permissionDenied_message =>
      'اتصال را دوباره آغاز و درخواست اجازه Android را بپذیرید.';

  @override
  String get notice_wireguardTimeout_title => 'سرور پاسخ نمی‌دهد';

  @override
  String get notice_wireguardTimeout_message =>
      'اتصال WireGuard بیش از حد طول کشید. دوباره تلاش کنید یا مکان دیگری انتخاب کنید.';

  @override
  String get notice_tlsFailed_title => 'اتصال امن رد شد';

  @override
  String get notice_tlsFailed_message =>
      'سرور اتصال OpenVPN را نپذیرفت. دوباره تلاش کنید. اگر مشکل ادامه داشت، یک تشخیص اجرا کنید.';

  @override
  String get notice_tunRejected_title => 'Android رابط وی‌پی‌ان را رد کرد';

  @override
  String get notice_tunRejected_message =>
      'Android پیکربندی شبکه درخواستی OpenVPN را رد کرد.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN نتوانست شروع شود';

  @override
  String get notice_openvpnStart_message =>
      'موتور OpenVPN نتوانست فرایند شروع را کامل کند. دوباره تلاش کنید. اگر مشکل ادامه داشت، با پشتیبانی تماس بگیرید.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'کد تشخیص: $code';
  }

  @override
  String get notice_generic_title => 'اتصال وی‌پی‌ان ناموفق بود';

  @override
  String get notice_generic_message => 'خطایی رخ داد. بعداً دوباره تلاش کنید.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'حساب ایجاد شد',
      'password_reset_sent': 'درخواست بازنشانی گذرواژه دریافت شد',
      'verification_email_sent': 'ایمیل تأیید ارسال شد',
      'location_migration_pending': 'تغییر مکان در حال انجام است',
      'vpn_sign_in_required': 'ورود لازم است',
      'protocol_unavailable_at_location': 'پروتکل در دسترس نیست',
      'vpn_permission_denied': 'اجازه وی‌پی‌ان رد شد',
      'revoked_identity_device_limit': 'محدودیت دو دستگاه به پایان رسید',
      'tunnel_start_unexpected': 'وی‌پی‌ان شروع نشد',
      'flutter_disconnect_timeout': 'قطع اتصال تأیید نشد',
      'flutter_disconnect_unexpected': 'قطع اتصال ممکن نشد',
      'device_revoked': 'دستگاه حذف شد',
      'revoke_unexpected': 'دستگاه حذف نشد',
      'identity_renewal_unexpected': 'نوسازی هویت ممکن نشد',
      'openvpn_renewal_unexpected': 'OpenVPN نوسازی نشد',
      'location_migration_blocked': 'تغییر مکان مسدود شد',
      'location_migration_slow': 'تغییر مکان همچنان در حال انجام است',
      'location_migration_conflict': 'تغییر مکان به تازه‌سازی نیاز دارد',
      'location_migration_verification_failed': 'تغییر مکان تأیید نشد',
      'location_migration_device_changed': 'دستگاه هنگام تغییر مکان عوض شد',
      'tunnel_stop_failed': 'تغییر مکان در دسترس نیست',
      'other': 'عملیات ناموفق بود',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'حساب ایجاد شد، اما ایمیل تأیید ارسال نشد. از گزینه ارسال دوباره در برنامه استفاده کنید.',
      'password_reset_sent':
          'درخواست شما دریافت شد. اگر حسابی با این نشانی مطابقت داشته باشد، ممکن است ایمیلی دریافت کنید. پوشه هرزنامه را هم بررسی کنید.',
      'verification_email_sent': 'یک ایمیل تأیید جدید همین حالا ارسال شد.',
      'location_migration_pending':
          'انتقال به $target همچنان در حال آماده‌سازی است. می‌توانید بدون ایجاد دوباره دستگاه، آن را ادامه دهید.',
      'vpn_sign_in_required': 'پیش از راه‌اندازی وی‌پی‌ان وارد حساب خود شوید.',
      'protocol_unavailable_at_location':
          'پروتکل انتخاب‌شده در این مکان ارائه نمی‌شود. مکان‌ها را تازه‌سازی کنید یا پروتکل دیگری انتخاب کنید.',
      'vpn_permission_denied':
          'Android اجازه وی‌پی‌ان را رد کرد. اتصال را دوباره آغاز و درخواست سیستم را بپذیرید.',
      'revoked_identity_device_limit':
          'دسترسی وی‌پی‌ان این دستگاه حذف شده و محدودیت دستگاه‌ها به پایان رسیده است. یک دستگاه را از مسیر حساب ← مدیریت دستگاه‌های من حذف کنید.',
      'tunnel_start_unexpected':
          'خطایی پیش‌بینی‌نشده آماده‌سازی تونل را قطع کرد. کد تشخیص را بررسی و دوباره تلاش کنید.',
      'flutter_disconnect_timeout':
          'Android به‌موقع توقف وی‌پی‌ان را تأیید نکرد. دوباره تلاش کنید آن را متوقف کنید.',
      'flutter_disconnect_unexpected':
          'خطایی پیش‌بینی‌نشده مانع تأیید توقف تونل شد.',
      'device_revoked':
          'دسترسی وی‌پی‌ان دستگاه لغو شد و اسرار محلی آن حذف شدند.',
      'revoke_unexpected':
          'دستگاه حذف نشد. فهرست را تازه‌سازی و دوباره تلاش کنید.',
      'identity_renewal_unexpected':
          'هویت جدید وی‌پی‌ان ایجاد نشد. دستگاه‌ها را تازه‌سازی و دوباره تلاش کنید.',
      'openvpn_renewal_unexpected':
          'نمایه OpenVPN نوسازی نشد. دوباره تلاش کنید یا کد تشخیص را بررسی کنید.',
      'location_migration_blocked':
          'سرور فعلاً نمی‌تواند این تغییر را کامل کند. دستگاه و هویت محلی آن حفظ شدند.',
      'location_migration_slow':
          'سرور همچنان در حال آماده‌سازی انتقال به $target است. چند لحظه دیگر از گزینه ادامه استفاده کنید.',
      'location_migration_conflict':
          'وضعیت دستگاه در سرور تغییر کرده است. دستگاه‌ها را تازه‌سازی و سپس تغییر را ادامه دهید.',
      'location_migration_verification_failed':
          'سرور مکان جدید را تأیید نکرد. هویت محلی قبلی حفظ شد.',
      'location_migration_device_changed':
          'دستگاهی که سرور برگردانده با دستگاه در حال تغییر مطابقت ندارد. پیش از تلاش دوباره دستگاه‌ها را تازه‌سازی کنید.',
      'tunnel_stop_failed':
          'پیش از اتصال جدید، تونل قبلی باید کاملاً متوقف شود.',
      'other':
          'عملیات کامل نشد. دوباره تلاش کنید یا کد تشخیص را برای پشتیبانی ارسال کنید.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'نشست منقضی شد',
      'invalid_credentials': 'ورود ناموفق بود',
      'email_verification_required': 'تأیید ایمیل لازم است',
      'verification_email_cooldown': 'ایمیل قبلاً ارسال شده است',
      'rate_limited': 'تلاش‌های بیش از حد',
      'invalid_registration': 'اطلاعات باید اصلاح شود',
      'email_exists': 'حساب از قبل وجود دارد',
      'invalid_profile': 'نمایه نامعتبر است',
      'invalid_device': 'دستگاه نامعتبر است',
      'invalid_location': 'مکان در دسترس نیست',
      'device_limit': 'محدودیت دستگاه‌ها به پایان رسید',
      'device_exists': 'هویت وی‌پی‌ان از قبل استفاده شده است',
      'device_identity_revoked': 'هویت وی‌پی‌ان باید نوسازی شود',
      'device_location_locked': 'تغییر مکان به تازه‌سازی نیاز دارد',
      'location_migration_pending': 'تغییر مکان در حال انجام است',
      'location_migration_blocked': 'تغییر مکان مسدود شد',
      'target_ca_mismatch': 'سرور OpenVPN ناسازگار است',
      'location_migration_conflict': 'تغییر مکان به تازه‌سازی نیاز دارد',
      'server_full': 'سرور پر است',
      'capacity_unavailable': 'مکان موقتاً در دسترس نیست',
      'target_unavailable': 'سرور موقتاً در دسترس نیست',
      'not_found': 'مورد پیدا نشد',
      'invalid_openvpn_csr': 'هویت OpenVPN نامعتبر است',
      'openvpn_profile_exists': 'نمایه OpenVPN از قبل وجود دارد',
      'openvpn_profile_revoked': 'نمایه OpenVPN لغو شده است',
      'openvpn_operation_pending': 'عملیات OpenVPN در حال انجام است',
      'openvpn_operation_terminal': 'عملیات OpenVPN قطع شد',
      'openvpn_address_unavailable': 'نشانی OpenVPN در دسترس نیست',
      'openvpn_profile_conflict': 'تعارض OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN در دسترس نیست',
      'email_delivery_unavailable': 'ایمیل در دسترس نیست',
      'invalid_token': 'پیوند نامعتبر است',
      'network_unavailable': 'اتصال اینترنت در دسترس نیست',
      'invalid_json': 'درخواست نامعتبر است',
      'invalid_api_response': 'پاسخ سرور نامعتبر است',
      'ipv6_unavailable': 'IPv6 در دسترس نیست',
      'invalid_ip_families': 'پیکربندی شبکه رد شد',
      'other': 'سرویس در دسترس نیست',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'نشست شما منقضی شده است. دوباره وارد شوید.',
      'invalid_credentials': 'نشانی ایمیل یا گذرواژه نادرست است.',
      'email_verification_required':
          'پیش از افزودن دستگاه وی‌پی‌ان، نشانی ایمیل خود را تأیید کنید.',
      'invalid_registration': 'اطلاعات و موافقت‌های درخواستی را بررسی کنید.',
      'email_exists': 'حسابی از قبل از این نشانی ایمیل استفاده می‌کند.',
      'invalid_profile': 'اطلاعات نمایه خود را بررسی کنید.',
      'invalid_device': 'نام یا هویت محلی این دستگاه نامعتبر است.',
      'invalid_location': 'فهرست مکان‌ها را تازه‌سازی و دوباره تلاش کنید.',
      'device_limit': 'پیش از افزودن دستگاه دیگر، یک دستگاه موجود را حذف کنید.',
      'device_exists': 'این هویت وی‌پی‌ان از قبل به حساب دیگری پیوند دارد.',
      'device_identity_revoked':
          'این هویت حذف شده است. باید یک هویت محلی جدید ایجاد شود.',
      'device_location_locked':
          'مکان این دستگاه همین حالا تغییر کرده است. برنامه تغییر در حال انجام را ادامه می‌دهد.',
      'location_migration_pending': 'تغییر مکان از قبل در حال انجام است.',
      'location_migration_blocked':
          'تغییر مکان به مداخله سرور نیاز دارد. بعداً دوباره تلاش کنید یا با پشتیبانی تماس بگیرید.',
      'target_ca_mismatch': 'این سرور هنوز با نمایه OpenVPN فعلی سازگار نیست.',
      'location_migration_conflict':
          'دستگاه‌ها را تازه‌سازی و سپس دوباره تغییر مکان را امتحان کنید.',
      'server_full':
          'این مکان به سقف اتصال خود رسیده است. مکان دیگری انتخاب کنید یا بعداً دوباره تلاش کنید.',
      'capacity_unavailable':
          'اکنون نمی‌توانیم در دسترس بودن این مکان را تأیید کنیم. مکان دیگری انتخاب کنید یا بعداً دوباره تلاش کنید.',
      'target_unavailable': 'این سرور موقتاً در دسترس نیست.',
      'not_found': 'این مورد دیگر در حساب شما در دسترس نیست.',
      'invalid_openvpn_csr': 'یک هویت جدید OpenVPN ایجاد و دوباره تلاش کنید.',
      'openvpn_profile_exists':
          'یک نمایه OpenVPN از قبل برای این دستگاه وجود دارد.',
      'openvpn_profile_revoked': 'برای ادامه، نمایه OpenVPN را نوسازی کنید.',
      'openvpn_operation_pending':
          'تغییر هنوز در حال انتشار است. بعداً دوباره تلاش کنید.',
      'openvpn_operation_terminal':
          'یک هویت جدید OpenVPN ایجاد و دوباره تلاش کنید.',
      'openvpn_address_unavailable':
          'در حال حاضر هیچ نشانی OpenVPN در دسترس نیست.',
      'openvpn_profile_conflict':
          'نمایه تغییر کرده است. دستگاه‌ها را تازه‌سازی و دوباره تلاش کنید.',
      'openvpn_signer_unavailable': 'سرویس OpenVPN موقتاً در دسترس نیست.',
      'email_delivery_unavailable': 'ایمیل ارسال نشد. بعداً دوباره تلاش کنید.',
      'invalid_token':
          'این پیوند نامعتبر است یا منقضی شده. پیوند جدیدی درخواست کنید.',
      'network_unavailable': 'اتصال اینترنت خود را بررسی و دوباره تلاش کنید.',
      'invalid_json': 'اطلاعات واردشده را بررسی و دوباره تلاش کنید.',
      'invalid_api_response':
          'سرور پاسخی غیرمنتظره برگرداند. بعداً دوباره تلاش کنید.',
      'ipv6_unavailable':
          'سرور در حال حاضر نمی‌تواند IPv6 را فعال کند. بعداً دوباره تلاش کنید.',
      'invalid_ip_families':
          'پیکربندی تونل ناقص است یا با نشانی‌های مجاز مطابقت ندارد. از داخل برنامه دوباره تلاش کنید.',
      'other': 'خطایی در سرور رخ داد. بعداً دوباره تلاش کنید.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'چند لحظه دیگر دوباره تلاش کنید.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'پس از $seconds ثانیه دوباره تلاش کنید.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'ادامه وی‌پی‌ان سیستمی در دسترس نیست',
      'system_vpn_resume_corrupt': 'ادامه وی‌پی‌ان سیستمی نامعتبر است',
      'system_vpn_resume_session_invalid': 'نشست ادامه وی‌پی‌ان نامعتبر است',
      'system_vpn_resume_identity_changed': 'هویت وی‌پی‌ان تغییر کرده است',
      'system_vpn_resume_identity_invalid': 'هویت ادامه وی‌پی‌ان نامعتبر است',
      'system_vpn_resume_storage_failed':
          'فضای ذخیره ادامه وی‌پی‌ان در دسترس نیست',
      'system_vpn_resume_network_timeout': 'ادامه وی‌پی‌ان شبکه ندارد',
      'system_vpn_resume_blocked': 'ادامه وی‌پی‌ان مسدود شد',
      'system_vpn_resume_failed': 'ادامه وی‌پی‌ان ناموفق بود',
      'system_vpn_resume_error_invalid': 'خطای ادامه وی‌پی‌ان نامعتبر است',
      'wireguard_identity_store_failed': 'هویت WireGuard ذخیره نشد',
      'wireguard_identity_unavailable': 'هویت WireGuard در دسترس نیست',
      'vpn_host_destroyed': 'میزبان وی‌پی‌ان Android متوقف شد',
      'vpn_host_unavailable': 'میزبان وی‌پی‌ان Android در دسترس نیست',
      'vpn_permission_required': 'اجازه وی‌پی‌ان لازم است',
      'vpn_permission_denied': 'اجازه وی‌پی‌ان رد شد',
      'vpn_permission_request_failed': 'درخواست اجازه ممکن نشد',
      'wireguard_foreground_service_unavailable':
          'سرویس WireGuard در دسترس نیست',
      'wireguard_identity_invalid': 'کلید محلی WireGuard نامعتبر است',
      'wireguard_identity_in_use': 'هویت WireGuard از قبل در حال استفاده است',
      'wireguard_configuration_invalid': 'پیکربندی WireGuard نامعتبر است',
      'wireguard_operation_pending': 'عملیات WireGuard همچنان فعال است',
      'wireguard_start_failed': 'شروع WireGuard رد شد',
      'wireguard_stop_timeout': 'توقف WireGuard تأیید نشد',
      'wireguard_handshake_timeout': 'WireGuard پاسخ نداد',
      'openvpn_connection_timeout': 'OpenVPN پاسخ نداد',
      'openvpn_core_unavailable': 'موتور OpenVPN در دسترس نیست',
      'openvpn_operation_pending': 'نشست OpenVPN همچنان فعال است',
      'openvpn_stop_timeout': 'توقف OpenVPN تأیید نشد',
      'openvpn_profile_unavailable': 'نمایه محلی OpenVPN وجود ندارد',
      'openvpn_native_failed': 'فراخوانی محلی OpenVPN قطع شد',
      'openvpn_key_generation_failed': 'ایجاد کلید P-256 برای OpenVPN ممکن نشد',
      'openvpn_csr_generation_failed': 'ایجاد CSR برای OpenVPN ممکن نشد',
      'openvpn_identity_store_failed': 'هویت OpenVPN ذخیره نشد',
      'openvpn_identity_clear_failed': 'حذف OpenVPN کامل نشد',
      'openvpn_identity_in_use': 'هویت OpenVPN همچنان در حال استفاده است',
      'openvpn_tls_verification_required': 'تأیید TLS برای OpenVPN وجود ندارد',
      'openvpn_cipher_invalid': 'رمزنگار OpenVPN نامعتبر است',
      'openvpn_profile_rejected': 'نمایه OpenVPN رد شد',
      'openvpn_identity_inconsistent': 'هویت OpenVPN ناسازگار است',
      'tls_handshake_failed': 'مذاکره OpenVPN رد شد',
      'tls_alert_unknown_ca': 'گواهی کلاینت OpenVPN شناخته نشد',
      'tls_alert_bad_certificate': 'گواهی کلاینت OpenVPN رد شد',
      'tls_alert_unsupported_certificate': 'گواهی OpenVPN پشتیبانی نمی‌شود',
      'tls_client_certificate_required': 'گواهی کلاینت OpenVPN لازم است',
      'tls_alert_misc': 'هشدار TLS در OpenVPN',
      'tls_signature_algorithm_rejected': 'امضای OpenVPN پشتیبانی نمی‌شود',
      'tls_handshake_rejected': 'مذاکره TLS در OpenVPN رد شد',
      'tls_version_rejected': 'نسخه TLS در OpenVPN ناسازگار است',
      'tls_certificate_expired': 'گواهی TLS منقضی شده است',
      'tls_certificate_revoked': 'گواهی TLS لغو شده است',
      'transport_failed': 'سرور OpenVPN در دسترس نیست',
      'tun_configuration_rejected': 'ایجاد رابط OpenVPN ممکن نشد',
      'tun_setup_failed': 'راه‌اندازی TUN در OpenVPN ناموفق بود',
      'tun_interface_create_failed': 'ایجاد رابط OpenVPN ناموفق بود',
      'tun_interface_disabled': 'رابط OpenVPN غیرفعال شد',
      'tun_halted': 'رابط OpenVPN قطع شد',
      'tun_already_established': 'رابط OpenVPN از قبل باز است',
      'tun_addresses_missing': 'نشانی OpenVPN وجود ندارد',
      'tun_routes_missing': 'مسیری برای OpenVPN وجود ندارد',
      'tun_dns_missing': 'DNS برای OpenVPN وجود ندارد',
      'tun_permission_revoked': 'اجازه وی‌پی‌ان لغو شد',
      'tun_establish_returned_null': 'Android رابط وی‌پی‌ان را رد کرد',
      'openvpn_service_start_failed': 'سرویس OpenVPN در دسترس نیست',
      'openvpn_operation_timeout': 'زمان فراخوانی OpenVPN تمام شد',
      'openvpn_start_failed': 'شروع OpenVPN رد شد',
      'openvpn_connection_failed': 'اتصال OpenVPN قطع شد',
      'openvpn_core_status_error': 'هسته OpenVPN با خطا پایان یافت',
      'openvpn_stopped_before_connected': 'OpenVPN پیش از اتصال متوقف شد',
      'openvpn_auth_failed': 'احراز هویت OpenVPN رد شد',
      'openvpn_client_setup_failed': 'راه‌اندازی کلاینت OpenVPN ناموفق بود',
      'openvpn_client_halted': 'کلاینت OpenVPN قطع شد',
      'openvpn_client_restart': 'درخواست راه‌اندازی دوباره OpenVPN صادر شد',
      'openvpn_inactive_timeout': 'OpenVPN بیش از حد غیرفعال بود',
      'openvpn_session_expired': 'نشست OpenVPN منقضی شد',
      'openvpn_credentials_required': 'احراز هویت OpenVPN پشتیبانی نمی‌شود',
      'openvpn_proxy_failed': 'انتقال واسط OpenVPN ناموفق بود',
      'openvpn_compression_failed': 'فشرده‌سازی OpenVPN رد شد',
      'openvpn_ntlm_crypto_unavailable':
          'رمزگذاری NTLM در OpenVPN در دسترس نیست',
      'openvpn_feature_unsupported': 'قابلیت OpenVPN پشتیبانی نمی‌شود',
      'network_unavailable': 'اتصال اینترنت در دسترس نیست',
      'network_lost': 'شبکه در دسترس نیست',
      'certificate_validation_failed': 'گواهی سرور رد شد',
      'openvpn_certificate_expired': 'گواهی OpenVPN منقضی شده است',
      'tunnel_active_for_another_account': 'تونل حساب دیگری همچنان فعال است',
      'tunnel_already_active': 'تونل محلی از قبل فعال است',
      'tunnel_stop_timeout': 'توقف $protocol تأیید نشد',
      'tunnel_disconnected': '$protocol قطع شد',
      'native_bridge_unavailable': 'پل Android در دسترس نیست',
      'native_operation_failed': 'عملیات Android قطع شد',
      'invalid_arguments': 'پارامترهای وی‌پی‌ان ناقص‌اند',
      'invalid_account_id': 'حساب وی‌پی‌ان نامعتبر است',
      'invalid_device_id': 'شناسه دستگاه نامعتبر است',
      'storage_key_not_allowed': 'کلید ذخیره‌سازی رد شد',
      'secure_storage_read_failed': 'خواندن امن ناموفق بود',
      'secure_storage_write_failed': 'نوشتن امن ناموفق بود',
      'key_generation_failed': 'ایجاد کلید WireGuard ممکن نشد',
      'csr_generation_failed': 'ایجاد CSR برای OpenVPN ممکن نشد',
      'other': 'خطای طبقه‌بندی‌نشده وی‌پی‌ان محلی',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android نشست وی‌پی‌ان قابل ادامه‌ای پیدا نکرد. اتصال جدیدی در برنامه آغاز کنید.',
      'system_vpn_resume_corrupt':
          'داده ذخیره‌شده ادامه وی‌پی‌ان نامعتبر است و استفاده نمی‌شود. اتصال جدیدی آغاز کنید.',
      'system_vpn_resume_session_invalid':
          'نشست ذخیره‌شده دیگر نمی‌تواند وی‌پی‌ان را ادامه دهد. دوباره در برنامه وارد شوید.',
      'system_vpn_resume_identity_changed':
          'هویت محلی وی‌پی‌ان تغییر کرده است. ادامه متوقف شد؛ اتصال جدیدی آغاز کنید.',
      'system_vpn_resume_identity_invalid':
          'هویت ادامه دادن نامعتبر است. اتصال جدیدی آغاز کنید.',
      'system_vpn_resume_storage_failed':
          'Android نتوانست داده رمزگذاری‌شده ادامه را بخواند یا به‌روزرسانی کند. اتصال جدیدی آغاز کنید.',
      'system_vpn_resume_network_timeout':
          'Android به‌موقع شبکه‌ای برای ادامه وی‌پی‌ان پیدا نکرد. وقتی شبکه در دسترس بود دوباره تلاش کنید.',
      'system_vpn_resume_blocked':
          'ادامه وی‌پی‌ان مسدود است. تنظیمات Android را بررسی و سپس اتصال جدیدی آغاز کنید.',
      'system_vpn_resume_failed':
          'ادامه وی‌پی‌ان Android ناموفق بود. اتصال جدیدی در برنامه آغاز کنید.',
      'system_vpn_resume_error_invalid':
          'Android خطای ادامه غیرقابل‌استفاده‌ای برگرداند. اتصال جدیدی آغاز کنید.',
      'wireguard_identity_store_failed':
          'Android نتوانست هویت رمزگذاری‌شده WireGuard این حساب را ذخیره کند.',
      'wireguard_identity_unavailable':
          'هویت قابل‌استفاده‌ای از WireGuard برای این اتصال در دسترس نیست.',
      'vpn_host_destroyed':
          'مؤلفه Android میزبان وی‌پی‌ان متوقف شد. اتصال جدیدی آغاز کنید.',
      'vpn_host_unavailable':
          'Android نمی‌تواند مؤلفه میزبان وی‌پی‌ان را ایجاد کند. پس از بررسی تنظیمات وی‌پی‌ان دوباره تلاش کنید.',
      'openvpn_renewal_required':
          'گواهی پیش از اتصال به اقدامی در برنامه نیاز دارد.',
      'openvpn_recovery_failed':
          'بازیابی خودکار ناموفق بود. اتصال جدیدی در برنامه آغاز کنید.',
      'openvpn_recovery_exhausted':
          'بازیابی خودکار قبلاً استفاده شده است. اتصال جدیدی در برنامه آغاز کنید.',
      'vpn_permission_required':
          'Android پیش از آغاز تونل به مجوز جدید وی‌پی‌ان نیاز دارد.',
      'vpn_permission_denied':
          'برای ادامه، FuzeVPN را در درخواست Android مجاز کنید.',
      'vpn_permission_request_failed':
          'Android نتوانست صفحه اجازه وی‌پی‌ان را باز کند.',
      'wireguard_foreground_service_unavailable':
          'Android نتوانست سرویس WireGuard را در پیش‌زمینه نگه دارد.',
      'wireguard_identity_invalid':
          'کلید رمزگذاری‌شده WireGuard این حساب خوانده نمی‌شود یا نامعتبر است.',
      'wireguard_identity_in_use':
          'عملیات دیگری همچنان از کلید WireGuard این حساب استفاده می‌کند.',
      'wireguard_configuration_invalid':
          'نشانی WireGuard، DNS، کلید سرور یا مسیرهای دریافت‌شده نامعتبرند.',
      'wireguard_operation_pending':
          'عملیات قبلی WireGuard هنوز سرویس محلی خود را آزاد نکرده است.',
      'wireguard_start_failed': 'موتور WireGuard فعال‌سازی پیکربندی را رد کرد.',
      'wireguard_stop_timeout':
          'سرویس WireGuard آزادسازی رابط وی‌پی‌ان را در مهلت مقرر تأیید نکرد.',
      'wireguard_handshake_timeout':
          'تونل به‌موقع برقراری دست‌دهی با سرور را تأیید نکرد.',
      'openvpn_connection_timeout':
          'OpenVPN به‌موقع اتصال به سرور را تأیید نکرد.',
      'openvpn_core_unavailable':
          'این نسخه از برنامه موتور قابل‌استفاده OpenVPN ندارد.',
      'openvpn_operation_pending':
          'موتور محلی هنوز نشست قبلی OpenVPN را نگه داشته و از ایجاد نشست دوم خودداری می‌کند.',
      'openvpn_stop_timeout':
          'هسته OpenVPN توقف و نابودی نشست محلی خود را در مهلت مقرر تأیید نکرد.',
      'openvpn_profile_unavailable':
          'هیچ نمایه تأییدشده OpenVPN برای این اتصال خوانده نمی‌شود.',
      'openvpn_native_failed':
          'خطای برنامه OpenVPN را قطع کرد. دوباره وصل شوید. اگر مشکل ادامه داشت، یک تشخیص اجرا کنید.',
      'openvpn_key_generation_failed':
          'Android Keystore نتوانست کلید خصوصی غیرقابل‌صدور P-256 را ایجاد یا بخواند.',
      'openvpn_csr_generation_failed':
          'کلید Android Keystore نتوانست درخواست گواهی OpenVPN را امضا کند.',
      'openvpn_identity_store_failed':
          'گواهی یا نمایه OpenVPN در فضای ذخیره‌سازی رمزگذاری‌شده ذخیره نشد.',
      'openvpn_identity_clear_failed':
          'Android نتوانست هویت محلی کامل OpenVPN این حساب را حذف کند.',
      'openvpn_identity_in_use':
          'یک نشست محلی OpenVPN همچنان از کلید یا گواهی این دستگاه استفاده می‌کند.',
      'openvpn_tls_verification_required':
          'نمایه صراحتاً تأیید گواهی سرور را لازم نمی‌داند.',
      'openvpn_cipher_invalid':
          'سرور الگوریتم رمزگذاری خارج از فهرست مجاز را ارائه کرد.',
      'openvpn_profile_rejected':
          'نمایه دریافت‌شده از سرور ناسازگار است. این دستگاه را دوباره ایجاد و تلاش کنید.',
      'openvpn_identity_inconsistent':
          'گواهی با هویت امن این تلفن مطابقت ندارد. هیچ نمایه محلی جایگزین نشد.',
      'tls_handshake_failed':
          'سرور مذاکره TLS را رد کرد. اگر مشکل ادامه داشت، نمایه را دوباره ایجاد کنید.',
      'tls_alert_unknown_ca':
          'سرور مرجع گواهی این دستگاه را نمی‌شناسد. سرور OpenVPN باید بررسی شود.',
      'tls_alert_bad_certificate':
          'سرور گواهی این دستگاه را رد کرد. پیش از تلاش دوباره دستگاه را دوباره ایجاد کنید.',
      'tls_alert_unsupported_certificate':
          'سرور از نوع گواهی امن استفاده‌شده توسط Android پشتیبانی نمی‌کند.',
      'tls_client_certificate_required':
          'سرور به گواهی کلاینت نیاز دارد، اما هسته OpenVPN نتوانست آن را ارائه کند.',
      'tls_alert_misc':
          'سرور هشداری TLS خارج از دسته‌های گواهی و نسخه برگرداند.',
      'tls_signature_algorithm_rejected':
          'سرور الگوریتم ECDSA P-256 کلید Android Keystore را رد کرد.',
      'tls_handshake_rejected': 'سرور پیش از اتصال، مذاکره TLS را قطع کرد.',
      'tls_version_rejected': 'کلاینت و سرور نسخه مشترکی از TLS پیدا نکردند.',
      'tls_certificate_expired': 'گواهی ارائه‌شده هنگام اتصال منقضی شده است.',
      'tls_certificate_revoked': 'گواهی ارائه‌شده هنگام اتصال لغو شده است.',
      'transport_failed':
          'سرور OpenVPN در شبکه فعلی پاسخ نمی‌دهد. کمی بعد دوباره تلاش کنید.',
      'tun_configuration_rejected':
          'Android پیکربندی شبکه درخواستی OpenVPN را رد کرد.',
      'tun_setup_failed':
          'هسته OpenVPN پیش از ایجاد رابط Android طرح شبکه را رد کرد.',
      'tun_interface_create_failed':
          'هسته OpenVPN نتوانست رابط TUN را از Android VpnService دریافت کند.',
      'tun_interface_disabled':
          'Android یا هسته OpenVPN رابط TUN را هنگام اتصال غیرفعال کرد.',
      'tun_halted': 'هسته OpenVPN درخواست توقف رابط TUN را دریافت کرد.',
      'tun_already_established':
          'OpenVPN در همان اتصال رابط دومی درخواست کرد. تونل برای ایمنی متوقف شد.',
      'tun_addresses_missing':
          'سرور نشانی قابل‌استفاده‌ای برای تونل ارائه نکرد.',
      'tun_routes_missing':
          'سرور مسیرهای قابل‌استفاده‌ای برای تونل ارائه نکرد.',
      'tun_dns_missing': 'سرور DNS قابل‌استفاده‌ای ارائه نکرد.',
      'tun_permission_revoked':
          'Android هنگام اتصال اجازه وی‌پی‌ان را لغو کرد.',
      'tun_establish_returned_null':
          'Android رابط را ایجاد نکرد؛ معمولاً به این دلیل که وی‌پی‌ان دیگری همچنان فعال است.',
      'openvpn_service_start_failed':
          'Android نتوانست سرویس پیش‌زمینه OpenVPN را آغاز کند.',
      'openvpn_operation_timeout':
          'فراخوانی JNI به هسته OpenVPN از حداکثر زمان مجاز فراتر رفت.',
      'openvpn_start_failed':
          'سرویس Android آماده است، اما هسته OpenVPN شروع نمایه را نپذیرفت.',
      'openvpn_connection_failed':
          'هسته OpenVPN پیش از انتشار رویداد CONNECTED متوقف شد.',
      'openvpn_core_status_error':
          'حلقه محلی OpenVPN با خطا و بدون رویداد پایانی مشخص‌تری پایان یافت.',
      'openvpn_stopped_before_connected':
          'حلقه محلی OpenVPN پیش از CONNECTED و بدون خطای صریح هسته متوقف شد.',
      'openvpn_auth_failed': 'سرور OpenVPN احراز هویت نمایه را رد کرد.',
      'openvpn_client_setup_failed':
          'هسته OpenVPN نتوانست پیش از اتصال شبکه کلاینت را راه‌اندازی کند.',
      'openvpn_client_halted': 'هسته OpenVPN توقف پایانی کلاینت را دریافت کرد.',
      'openvpn_client_restart':
          'هسته OpenVPN درخواست راه‌اندازی دوباره نشست انتقال را صادر کرد.',
      'openvpn_inactive_timeout':
          'هسته OpenVPN پس از پایان مهلت غیرفعال‌بودن نشست را بست.',
      'openvpn_session_expired':
          'سرور گزارش داد که نشست OpenVPN منقضی شده است.',
      'openvpn_credentials_required':
          'سرور یا واسط، اطلاعات ورود تعاملی درخواست می‌کند که بخشی از این نمایه گواهی نیست.',
      'openvpn_proxy_failed':
          'هسته OpenVPN از ناموفق بودن واسط یا رله پیکربندی‌شده خبر داد.',
      'openvpn_compression_failed':
          'هسته OpenVPN حالت فشرده‌سازی اعلام‌شده توسط نمایه یا سرور را رد کرد.',
      'openvpn_ntlm_crypto_unavailable':
          'نمایه رمزگذاری NTLM را درخواست می‌کند که در این نسخه در دسترس نیست.',
      'openvpn_feature_unsupported':
          'نمایه یا سرور به قابلیتی نیاز دارد که در این کلاینت Android وجود ندارد.',
      'network_unavailable': 'هیچ شبکه فیزیکی قابل‌استفاده‌ای در دسترس نیست.',
      'network_lost': 'پس از قطع شبکه، تونل متوقف شد.',
      'certificate_validation_failed': 'هویت سرور OpenVPN تأیید نشد.',
      'openvpn_certificate_expired':
          'پیش از اتصال دوباره، نمایه OpenVPN را نوسازی کنید.',
      'tunnel_active_for_another_account':
          'پیش از این اتصال، تونل متعلق به حساب دیگری باید متوقف شود.',
      'tunnel_already_active':
          'Android گزارش می‌دهد که نشست قبلی وی‌پی‌ان همچنان از رابط استفاده می‌کند.',
      'tunnel_stop_timeout':
          'موتور $protocol آزادسازی رابط وی‌پی‌ان را در مهلت مقرر تأیید نکرد.',
      'tunnel_disconnected':
          'موتور محلی گزارش داد که تونل پس از شروع، به‌طور غیرمنتظره پایان یافت.',
      'native_bridge_unavailable':
          'برنامه نمی‌تواند به سرویس وی‌پی‌ان Android دسترسی پیدا کند. برنامه را ببندید و دوباره باز کنید، سپس تلاش کنید.',
      'native_operation_failed':
          'خطای برنامه عملیات وی‌پی‌ان را قطع کرد. دوباره تلاش کنید. اگر مشکل ادامه داشت، یک تشخیص اجرا کنید.',
      'invalid_arguments':
          'اطلاعات لازم برای این عملیات وی‌پی‌ان ناقص است. دوباره تلاش کنید. اگر مشکل ادامه داشت، یک تشخیص اجرا کنید.',
      'invalid_account_id': 'عملیات محلی به شناسه حساب معتبری پیوند ندارد.',
      'invalid_device_id':
          'شناسه دستگاه ارسال‌شده به موتور محلی وجود ندارد یا نامعتبر است.',
      'storage_key_not_allowed':
          'پل Android کلیدی خارج از فهرست ذخیره‌سازی مجاز را مسدود کرد.',
      'secure_storage_read_failed':
          'Android Keystore نتوانست داده محلی این حساب را رمزگشایی کند.',
      'secure_storage_write_failed':
          'Android Keystore نتوانست داده محلی را رمزگذاری یا ذخیره کند.',
      'key_generation_failed':
          'Android نتوانست کلید WireGuard را در فضای امن ایجاد یا بخواند.',
      'csr_generation_failed':
          'Android Keystore نتوانست CSR مربوط به OpenVPN P-256 را ایجاد یا امضا کند.',
      'other':
          'یک شاخه محلی مستندنشده ناموفق بود. کد تشخیص نمایش‌داده‌شده در زیر را برای پشتیبانی ارسال کنید.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'درخواست اجازه از قبل باز است';

  @override
  String get notice_permissionRequestInProgress_message =>
      'درخواست اجازه وی‌پی‌ان Android از قبل نمایش داده شده است. پیش از تلاش دوباره، آن را کامل کنید.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'درخواست اجازه وی‌پی‌ان قطع شد';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'صفحه اجازه وی‌پی‌ان پیش از دریافت پاسخ توسط برنامه بسته شد.';

  @override
  String get notice_openvpnProofMissing_title => 'اتصال OpenVPN تأیید نشد';

  @override
  String get notice_openvpnProofMissing_message =>
      'اتصال OpenVPN تأیید نشد. برای ایمنی متوقف شد. دوباره تلاش کنید.';

  @override
  String get openvpnCleanup_title => 'نمایه OpenVPN لغوشده';

  @override
  String get openvpnCleanup_working =>
      'در حال توقف و حذف نمایه لغوشده OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'خاموش شدن OpenVPN تأیید نشد. پیش از ایجاد نمایه جدید دوباره تلاش کنید.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'نمایه لغوشده OpenVPN به‌طور کامل حذف نشد. پاک‌سازی را دوباره انجام دهید.';

  @override
  String get openvpnCleanup_complete =>
      'نمایه لغوشده OpenVPN حذف شد. برای ایجاد نمایه جدید روی «اتصال» بزنید.';

  @override
  String get network_title => 'پیکربندی شبکه';

  @override
  String get network_ipv4Fallback =>
      'IPv6 موقتاً در دسترس نیست. آماده‌سازی با IPv4 ادامه می‌یابد.';

  @override
  String get network_rejectedTitle => 'پیکربندی شبکه رد شد';

  @override
  String get network_rejectedMessage =>
      'پیکربندی تونل ناقص است یا با نشانی‌های مجاز مطابقت ندارد. از داخل برنامه دوباره تلاش کنید.';

  @override
  String get network_unreadableTitle => 'پیکربندی محلی خوانده نمی‌شود';

  @override
  String get network_unreadableMessage =>
      'پیکربندی شبکه OpenVPN ذخیره‌شده قابل استفاده نیست. برای به‌روزرسانی آن از داخل برنامه دوباره متصل شوید.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'محافظت از شبکه';

  @override
  String get protection_subtitle =>
      'اگر وی‌پی‌ان قطع شد، دسترسی مستقیم به اینترنت را مسدود کنید.';

  @override
  String get protection_active => 'محافظت سیستمی فعال است';

  @override
  String get protection_alwaysOnOnly =>
      'وی‌پی‌ان همیشه‌روشن فعال است؛ مسدودسازی خارج از وی‌پی‌ان را روشن کنید';

  @override
  String get protection_inactive => 'محافظت سیستمی غیرفعال است';

  @override
  String get protection_unknown => 'محافظت سیستمی را بررسی کنید';

  @override
  String get protection_openSettings => 'باز کردن تنظیمات Android';

  @override
  String get protection_dialogTitle => 'راه‌اندازی محافظت از شبکه';

  @override
  String get protection_dialogMessage =>
      'Android وی‌پی‌ان همیشه‌روشن و مسدودسازی اتصال‌های خارج از وی‌پی‌ان را مدیریت می‌کند. بررسی کنید FuzeVPN انتخاب شده باشد و مسدودسازی را در تنظیمات سیستم فعال کنید.';

  @override
  String get protection_dialogOpen => 'باز کردن تنظیمات';

  @override
  String get session_systemProtectionNote =>
      'اگر Android همچنان ترافیک خارج از وی‌پی‌ان را مسدود می‌کند، برای بررسی یا تغییر این محافظت، تنظیمات سیستم را باز کنید.';

  @override
  String get diagnostics_title => 'تشخیص‌ها';

  @override
  String get diagnostics_settingsTitle => 'تشخیص‌های برنامه';

  @override
  String get diagnostics_automaticTitle => 'ارسال خطاهای مهم';

  @override
  String get diagnostics_automaticDescription =>
      'هنگام رخ دادن خطای مهم، یک گزارش فنی کوتاه به اشتراک بگذارید.';

  @override
  String get diagnostics_privacy =>
      'گزارش‌های ارسال‌شده به حساب واردشده پیوند می‌خورند و به مدت ۳۰ روز نگهداری می‌شوند. آن‌ها شامل سابقه مرور، گذرواژه‌ها یا کلیدهای وی‌پی‌ان نیستند.';

  @override
  String get diagnostics_manualOpen => 'اجرای تشخیص‌ها';

  @override
  String get diagnostics_localDescription =>
      'گزارشی از وضعیت برنامه و وی‌پی‌ان ایجاد کنید. اتصال شما بدون تغییر باقی می‌ماند.';

  @override
  String get diagnostics_sendReport => 'ارسال گزارش';

  @override
  String get diagnostics_sendHint =>
      'برای نگه داشتن گزارش روی این دستگاه، این کادر را علامت نزنید.';

  @override
  String get diagnostics_signedOut => 'برای ارسال گزارش وارد حساب خود شوید.';

  @override
  String get diagnostics_localLifetime =>
      'برای نگه داشتن این گزارش پس از بستن برنامه، آن را روی تلفن خود ذخیره کنید.';

  @override
  String get diagnostics_run => 'اجرای تشخیص‌ها';

  @override
  String get diagnostics_rerun => 'اجرای دوباره تشخیص‌ها';

  @override
  String get diagnostics_running => 'در حال بررسی…';

  @override
  String get diagnostics_sending => 'در حال ارسال گزارش…';

  @override
  String get diagnostics_prepared => 'گزارش روی این دستگاه آماده است';

  @override
  String get diagnostics_queued => 'گزارش در انتظار ارسال است';

  @override
  String get diagnostics_sent => 'گزارش دریافت شد';

  @override
  String get diagnostics_failed =>
      'ارسال ناموفق بود. گزارش محلی شما همچنان در دسترس است.';

  @override
  String get diagnostics_preparationFailed =>
      'گزارش تشخیص آماده نشد. دوباره تلاش کنید.';

  @override
  String get diagnostics_authenticationRequired =>
      'برای ارسال گزارش دوباره وارد شوید.';

  @override
  String get diagnostics_retry => 'تلاش دوباره برای ارسال';

  @override
  String get diagnostics_export => 'ذخیره گزارش';

  @override
  String get diagnostics_exportFailed =>
      'خروجی گرفتن ناموفق بود. از گزارش محلی دوباره تلاش کنید.';

  @override
  String get diagnostics_preferenceFailed =>
      'این تنظیم ذخیره نشد. دوباره تلاش کنید.';

  @override
  String diagnostics_receipt(Object id) {
    return 'مرجع: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'دریافت‌شده در $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'نگهداری تا $date';
  }

  @override
  String get diagnostics_duplicate => 'این گزارش قبلاً دریافت شده بود.';

  @override
  String get diagnostics_preview => 'پیش‌نمایش گزارش';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count رویداد فنی پیوست شده است',
      one: '$count رویداد فنی پیوست شده است',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'جزئیات فنی';

  @override
  String get diagnostics_empty => 'هنوز هیچ گزارش تشخیصی آماده نشده است.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'وضعیت تونل',
      'handshake': 'تأیید اتصال',
      'certificate': 'گواهی وی‌پی‌ان',
      'kill_switch': 'محافظت Android',
      'connectivity': 'شبکه در دسترس',
      'api_reachability': 'دسترسی به سرویس',
      'secure_storage': 'فضای ذخیره امن',
      'other': 'بررسی محلی',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'بررسی شد',
      'failed': 'نیازمند توجه',
      'skipped': 'آزمایش نشد — کاوشگر فعالی وجود ندارد',
      'unknown': 'اطلاعات در دسترس نیست',
      'other': 'اطلاعات در دسترس نیست',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'به FuzeVPN خوش آمدید';

  @override
  String get connection_changeLocation => 'تغییر مکان';

  @override
  String get connection_details => 'جزئیات اتصال';

  @override
  String get locations_searchLabel => 'جست‌وجوی شهر یا کشور';

  @override
  String get locations_clearSearch => 'پاک کردن جست‌وجو';

  @override
  String get locations_filterAll => 'همه';

  @override
  String get locations_filterFavorites => 'موردعلاقه‌ها';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مکان',
      one: '$count مکان',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'مکانی پیدا نشد';

  @override
  String get locations_noResultsHint => 'شهر یا کشور دیگری را امتحان کنید.';

  @override
  String get locations_noFavorites => 'موردعلاقه‌های شما، همیشه در دسترس';

  @override
  String get locations_noFavoritesHint =>
      'برای ذخیره کردن مکان در اینجا، روی ستاره کنار آن بزنید.';

  @override
  String get locations_showAll => 'دیدن همه مکان‌ها';

  @override
  String locations_addFavorite(String name) {
    return 'افزودن $name به موردعلاقه‌ها';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'حذف $name از موردعلاقه‌ها';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'موردعلاقه ذخیره نشد. دوباره تلاش کنید.';

  @override
  String get locations_emptyTitle => 'مکانی در دسترس نیست';

  @override
  String get locations_emptyHint =>
      'برای تلاش دوباره، فهرست را تازه‌سازی کنید.';

  @override
  String get devices_manage => 'مدیریت دستگاه‌های من';

  @override
  String get settings_personalization => 'شخصی‌سازی';

  @override
  String get settings_safety => 'محافظت';

  @override
  String get settings_help => 'کمک لازم دارید؟';

  @override
  String get settings_about => 'درباره FuzeVPN';

  @override
  String get diagnostics_heading => 'درک مشکل اتصال';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'در دسترس',
      'pending': 'در حال آماده‌سازی',
      'revoked': 'حذف‌شده',
      'expired': 'منقضی‌شده',
      'other': 'وضعیت در دسترس نیست',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ترجیح ذخیره نشد';

  @override
  String get notice_preferenceSave_message =>
      'انتخاب شما فعلاً اعمال شده است، اما ذخیره نشد. برای نگه داشتن آن پس از بستن برنامه دوباره تلاش کنید.';

  @override
  String get connection_androidDisconnectHint =>
      'اگر Android وی‌پی‌ان را فعال نگه می‌دارد، وی‌پی‌ان همیشه‌روشن را در تنظیماتی که باز می‌شوند خاموش کنید.';

  @override
  String get protection_learnMore => 'آشنایی بیشتر با محافظت Android';

  @override
  String get protection_guideWhy =>
      'این محافظت مانع استفاده مستقیم برنامه‌ها از اینترنت در صورت قطع شدن وی‌پی‌ان می‌شود. این قابلیت در Android پیکربندی می‌شود.';

  @override
  String get protection_guideAlwaysOnTitle => 'وی‌پی‌ان همیشه‌روشن';

  @override
  String get protection_guideAlwaysOn =>
      'Android سرویس وی‌پی‌ان را در حال اجرا نگه می‌دارد و می‌تواند پس از راه‌اندازی دوباره تلفن آن را دوباره اجرا کند.';

  @override
  String get protection_guideBlockTitle => 'مسدود کردن اتصال‌ها بدون وی‌پی‌ان';

  @override
  String get protection_guideBlock =>
      'این تنظیم مانع دور زدن وی‌پی‌ان توسط ترافیک می‌شود، حتی هنگام قطع بودن اتصال.';

  @override
  String get protection_guideWarning =>
      'با فعال بودن این مسدودسازی، دسترسی به اینترنت تا اتصال وی‌پی‌ان خاموش می‌ماند.';

  @override
  String get protection_guideStepsTitle => 'روشن کردن محافظت';

  @override
  String get protection_guideStep1 =>
      'با دکمه زیر، تنظیمات وی‌پی‌ان Android را باز کنید.';

  @override
  String get protection_guideStep2 =>
      'گزینه‌ها را با استفاده از نماد چرخ‌دنده کنار FuzeVPN باز کنید.';

  @override
  String get protection_guideStep3 =>
      'وی‌پی‌ان همیشه‌روشن و سپس مسدود کردن اتصال‌ها بدون وی‌پی‌ان را فعال کنید، اگر این گزینه‌ها در دسترس هستند.';

  @override
  String get protection_guideManufacturers =>
      'نام‌ها بر اساس تلفن متفاوت‌اند. در صورت نیاز، در تنظیمات عبارت وی‌پی‌ان را جست‌وجو کنید؛ این گزینه معمولاً زیر «شبکه و اینترنت» است.';

  @override
  String get protection_guideDisableTitle => 'خاموش کردن این محافظت';

  @override
  String get protection_guideDisable =>
      'در همان تنظیمات، مسدودسازی بدون وی‌پی‌ان را خاموش کنید تا دسترسی به اینترنت بدون وی‌پی‌ان مجاز شود. اگر دیگر نمی‌خواهید Android آن را دوباره اجرا کند، وی‌پی‌ان همیشه‌روشن را هم خاموش کنید.';

  @override
  String get protection_guideManual =>
      'این تنظیمات را خودتان در Android انتخاب می‌کنید. FuzeVPN آن‌ها را به جای شما تغییر نمی‌دهد.';

  @override
  String get locations_changeTitle => 'مکان تغییر کند؟';

  @override
  String locations_changeActive(String name) {
    return 'اتصال وی‌پی‌ان قطع می‌شود، سپس تلاش می‌کند به $name متصل شود.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'وی‌پی‌ان تلاش می‌کند به $name متصل شود.';
  }

  @override
  String get locations_confirmChange => 'تغییر و اتصال';

  @override
  String get locations_changeBusy =>
      'تغییری در حال انجام است. پیش از انتخاب مکان دیگر صبر کنید.';

  @override
  String get locations_automaticSelection => 'انتخاب خودکار';

  @override
  String get locations_cities => 'شهرها';

  @override
  String get locations_servers => 'سرورها';

  @override
  String locations_viewCities(String name) {
    return 'دیدن شهرهای $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'دیدن سرورهای $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count کشور',
      one: '$count کشور',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شهر',
      one: '$count شهر',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سرور',
      one: '$count سرور',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'همه کشورها';

  @override
  String get locations_backToCountries => 'بازگشت به کشورها';

  @override
  String locations_backToCities(String name) {
    return 'بازگشت به شهرهای $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'انتخاب $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'انتخاب $name';
  }

  @override
  String get locations_noCompatibleServer => 'هیچ سرور سازگاری در دسترس نیست.';

  @override
  String get externalLink_failed =>
      'این پیوند باز نشد. می‌توانید آن را کپی کرده و در مرورگر خود باز کنید.';

  @override
  String get externalLink_copy => 'کپی پیوند';

  @override
  String get externalLink_copied => 'پیوند کپی شد';

  @override
  String get externalLink_copyFailed =>
      'پیوند کپی نشد. نشانی زیر را انتخاب کنید.';

  @override
  String get settings_deleteAccount => 'حذف حساب من';

  @override
  String get settings_deleteAccountDetail => 'مشاهده مراحل درخواست حذف حساب';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'اشتراک VPN خود را انتخاب کنید.';

  @override
  String get billing_subscribe => 'اشتراک بگیرید';

  @override
  String get billing_choosePlan => 'برای ادامه یک طرح انتخاب کنید.';

  @override
  String get billing_monthly => 'ماهانه';

  @override
  String get billing_yearly => 'سالانه';

  @override
  String get billing_continue => 'ادامه با Google Play';

  @override
  String get billing_restore => 'بازیابی خریدها';

  @override
  String get billing_manage => 'مدیریت اشتراک';

  @override
  String get billing_deleteAccountWarning =>
      'اگر اشتراک Google Play دارید، حذف حساب FuzeVPN شما تمدید آن را لغو نمی‌کند. تمدید اشتراک را جداگانه در Google Play مدیریت یا لغو کنید.';

  @override
  String get billing_deleteAccountContinue => 'ادامه به درخواست حذف حساب';

  @override
  String get billing_refresh => 'تازه‌سازی دسترسی';

  @override
  String get billing_loadingPlans => 'در حال بارگیری طرح‌ها…';

  @override
  String get billing_unavailable =>
      'فعلاً طرحی موجود نیست. بعداً دوباره تلاش کنید.';

  @override
  String get billing_comingSoon => 'اشتراک‌ها به‌زودی در دسترس خواهند بود.';

  @override
  String get billing_priceDisclosure =>
      'قیمت را Google Play ارائه می‌کند. مبلغ نهایی و مالیات‌های مربوط پیش از تأیید شما مشخص می‌شوند.';

  @override
  String get billing_renewalMonthly =>
      'در صورت لغو نکردن، هر ماه خودکار تمدید می‌شود. می‌توانید هر زمان از بخش اشتراک‌های Google Play لغو کنید.';

  @override
  String get billing_renewalYearly =>
      'در صورت لغو نکردن، هر سال خودکار تمدید می‌شود. می‌توانید هر زمان از بخش اشتراک‌های Google Play لغو کنید.';

  @override
  String get billing_active => 'دسترسی Premium شما فعال است';

  @override
  String billing_accessUntil(String date) {
    return 'دسترسی تا $date.';
  }

  @override
  String get billing_webManaged =>
      'اشتراک شما در وب‌سایت FuzeVPN مدیریت می‌شود.';

  @override
  String get billing_playManaged =>
      'اشتراک شما از طریق Google Play مدیریت می‌شود.';

  @override
  String get billing_inactive => 'اشتراک فعالی وجود ندارد.';

  @override
  String get billing_checkingAccess => 'در حال بررسی دسترسی شما…';

  @override
  String get billing_restoring => 'در حال بازیابی خریدها…';

  @override
  String get billing_pending =>
      'پرداخت در انتظار است. دسترسی شما پس از تأیید فعال می‌شود.';

  @override
  String get billing_cancelled => 'خرید لغو شد. اشتراک جدیدی فعال نشد.';

  @override
  String get billing_verifying => 'در حال تأیید خرید…';

  @override
  String get billing_success => 'اشتراک فعال شد. دسترسی Premium شما آماده است.';

  @override
  String get billing_restored => 'خریدهای شما بازیابی شدند.';

  @override
  String get billing_restoreEmpty =>
      'برای این حساب Google Play خریدی جهت بازیابی وجود ندارد.';

  @override
  String get billing_catalogError =>
      'بارگیری طرح‌ها ممکن نیست. دوباره تلاش کنید.';

  @override
  String get billing_purchaseError => 'شروع خرید ممکن نیست. دوباره تلاش کنید.';

  @override
  String get billing_verificationError =>
      'تأیید خرید موقتاً در دسترس نیست. برای تلاش دوباره، خریدها را بازیابی کنید.';

  @override
  String get billing_restoreError =>
      'بازیابی خریدها ممکن نیست. دوباره تلاش کنید.';

  @override
  String get billing_managementError =>
      'باز کردن مدیریت اشتراک ممکن نیست. دوباره تلاش کنید.';

  @override
  String get billing_storeUnavailable =>
      'Google Play در این دستگاه در دسترس نیست.';

  @override
  String get welcome_title => 'VPN شما، به همین سادگی.';

  @override
  String get welcome_description =>
      'از اتصال خود محافظت کنید. کنترل حریم خصوصی‌تان را در دست داشته باشید.';

  @override
  String get welcome_start => 'شروع';

  @override
  String get welcome_alreadyPurchased => 'قبلاً خرید کرده‌اید؟';

  @override
  String get welcome_noAccountRequired => 'برای شروع نیازی به ساخت حساب نیست.';

  @override
  String get guest_accountTitle => 'حساب پیوند داده نشده';

  @override
  String get guest_accountDescription =>
      'برای استفاده از اشتراک در دستگاه دیگر، خریدهای خود را با همان حساب Google Play بازیابی کنید.';

  @override
  String get guest_existingSubscriberSignIn => 'قبلاً مشترک شده‌اید؟ وارد شوید';

  @override
  String get guest_claimTitle => 'FuzeVPN در همه‌جا با شماست';

  @override
  String get guest_claimDescription =>
      'برای دسترسی به اشتراک در دستگاه‌های دیگر، حساب بسازید. این مرحله اختیاری است.';

  @override
  String get guest_skip => 'بعداً';

  @override
  String get guest_activationTitle => 'Fuze Premium فعال است';

  @override
  String get guest_activationDescription =>
      'اشتراک شما آماده است. از VPN استفاده کنید و هر زمان خواستید حساب بسازید.';

  @override
  String get guest_useVpn => 'استفاده از VPN';

  @override
  String get guest_loginRequired =>
      'این خرید قبلاً به یک حساب FuzeVPN پیوند داده شده است. برای دسترسی به اشتراک، وارد همان حساب شوید.';

  @override
  String get guest_signOutWarning =>
      'می‌توانید با بازیابی خریدها از طریق همان حساب Google Play، اشتراک خود را بازیابی کنید.';

  @override
  String get guest_profileUnavailable =>
      'حساب شما قبلاً پیوند داده شده است. برای مشاهده و مدیریت اطلاعات خود وارد شوید.';

  @override
  String get billing_acceptance =>
      'با ادامه دادن، شرایط استفاده و سیاست حفظ حریم خصوصی را می‌پذیرید.';

  @override
  String get guest_verifyEmailReminder =>
      'برای ایمن کردن حساب، نشانی ایمیل خود را تأیید کنید. می‌توانید همچنان از VPN استفاده کنید.';

  @override
  String get guest_serviceUnavailable =>
      'سرویس موقتاً در دسترس نیست. کمی بعد دوباره تلاش کنید.';

  @override
  String get guest_restoreError =>
      'خریدهای شما بازیابی نشد. با حساب Google Play که برای خرید استفاده کرده‌اید دوباره تلاش کنید.';

  @override
  String get guest_claimSuccess =>
      'حساب شما ساخته شد. اشتراک و دسترسی شما به VPN حفظ شده است.';

  @override
  String get guest_emailExists =>
      'این نشانی ایمیل قبلاً استفاده شده است. نشانی دیگری انتخاب کنید یا وارد حساب موجود خود شوید. خرید شما همچنان از طریق Google Play در دسترس است.';

  @override
  String get guest_claimError =>
      'حساب شما ساخته نشد. می‌توانید همچنان از VPN استفاده کنید و بعداً دوباره تلاش کنید.';

  @override
  String get guest_secureStorageError =>
      'نشست شما روی این دستگاه به‌صورت امن ذخیره نشد. دوباره تلاش کنید.';

  @override
  String get guest_premiumRequired =>
      'برای فعال کردن VPN، یک اشتراک انتخاب کنید.';

  @override
  String get welcome_viewPlans => 'مشاهده طرح‌ها';

  @override
  String get google_continue => 'ادامه با Google';

  @override
  String get google_or => 'یا';

  @override
  String get google_title => 'حساب FuzeVPN شما';

  @override
  String get google_settingUp => 'ساخت حساب را تکمیل کنید';

  @override
  String get google_country => 'کشور محل اقامت';

  @override
  String get google_profileDescription =>
      'برای ساخت حساب FuzeVPN، کشور خود را انتخاب کنید و دو سند را بخوانید.';

  @override
  String get google_claimDescription =>
      'حساب مهمان را به Google پیوند دهید. اشتراک و دستگاه به همین حساب متصل می‌مانند.';

  @override
  String get google_linkTitle => 'پیوند Google به FuzeVPN';

  @override
  String get google_linkDescription =>
      'دسترسی به حساب موجود FuzeVPN را تأیید کنید. گذرواژه Google درخواست نمی‌شود.';

  @override
  String get google_password => 'گذرواژه FuzeVPN';

  @override
  String get google_linkAccount => 'تأیید پیوند';

  @override
  String get google_requestEmail => 'دریافت ایمیل تأیید';

  @override
  String get google_emailInstructions =>
      'ایمیل FuzeVPN را باز کنید و کد تأیید را وارد کنید.';

  @override
  String get google_emailCode => 'کد تأیید ایمیل';

  @override
  String get google_confirmEmail => 'تأیید کد';

  @override
  String get google_restart => 'انتخاب حساب Google دیگر';

  @override
  String get google_resume => 'بررسی این تلاش';

  @override
  String get google_unavailable =>
      'ورود با Google در دسترس نیست. می‌توانید از ایمیل و گذرواژه استفاده کنید.';

  @override
  String get google_expired =>
      'این تلاش منقضی شده است. آن را لغو کنید و دوباره شروع کنید.';

  @override
  String get google_conflict =>
      'این حساب Google به حساب دیگری متصل است. حساب و اشتراک فعلی شما حفظ می‌شوند.';

  @override
  String get google_error =>
      'ورود با Google ناموفق بود. دوباره تلاش کنید؛ دسترسی فعلی شما حفظ می‌شود.';

  @override
  String get google_uncertain =>
      'نتیجه تأیید نشد. این تلاش را بررسی کنید یا پیش از شروع دوباره آن را لغو کنید.';

  @override
  String get google_cancelFailed =>
      'لغو تأیید نشد. پیش از خروج از این صفحه دوباره برای لغو تلاش کنید.';

  @override
  String get google_cancelled => 'ورود با Google لغو شد.';

  @override
  String get google_selecting => 'حساب Google خود را انتخاب کنید…';

  @override
  String get google_verifying => 'در حال بررسی حساب…';

  @override
  String get google_emailUnavailable =>
      'ایمیل تأیید ارسال نشد. بعداً دوباره تلاش کنید.';

  @override
  String get google_emailSent =>
      'ایمیل تأیید ارسال شد. صندوق ورودی خود را بررسی کنید.';

  @override
  String get google_rateLimited => 'پیش از تلاش دوباره کمی صبر کنید.';

  @override
  String get google_invalidPassword =>
      'گذرواژه FuzeVPN نادرست است. حساب فعلی شما حفظ می‌شود.';

  @override
  String get google_invalidCode => 'کد تأیید نامعتبر یا منقضی شده است.';

  @override
  String get google_accountChanged =>
      'نشست تغییر کرده است. پیش از شروع دوباره این تلاش را لغو کنید.';

  @override
  String get google_invalidResponse =>
      'پاسخ تأیید نشد. دسترسی فعلی شما حفظ می‌شود.';

  @override
  String get google_invalidRegistration => 'کشور و هر دو رضایت را بررسی کنید.';

  @override
  String get google_consentRequired =>
      'برای ادامه کشور خود را انتخاب کنید و هر دو سند را بپذیرید.';

  @override
  String get google_challengeRequired =>
      'بررسی امنیتی دیگری لازم است. دسترسی فعلی شما حفظ می‌شود.';

  @override
  String get google_challengeUnavailable =>
      'بررسی امنیتی در دسترس نیست. بعداً دوباره تلاش کنید.';

  @override
  String get billing_trialTitle => 'Fuze Premium را رایگان امتحان کنید';

  @override
  String get billing_trialSubtitle => 'از همین امروز از اتصال خود محافظت کنید.';

  @override
  String get billing_trialWeeks => '۲ هفته دورهٔ آزمایشی رایگان';

  @override
  String billing_trialDays(String days) {
    return '$days روز دورهٔ آزمایشی رایگان';
  }

  @override
  String get billing_trialStart => 'شروع دورهٔ آزمایشی رایگان';

  @override
  String billing_trialFirstCharge(String date) {
    return 'اگر امروز شروع کنید، اولین برداشت وجه برای $date پیش‌بینی می‌شود.';
  }

  @override
  String get billing_trialTerms =>
      'با قیمت اعلام‌شده به‌طور خودکار تمدید می‌شود. برای جلوگیری از برداشت وجه، پیش از پایان دورهٔ آزمایشی در Google Play لغو کنید.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'سپس $price در ماه';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'سپس $price در سال';
  }

  @override
  String get billing_choosePeriod => 'طرح خود را انتخاب کنید';

  @override
  String get billing_selectionHint => 'برای ادامه یک طرح انتخاب کنید.';

  @override
  String get billing_benefitConnection => 'اتصال رمزگذاری‌شده';

  @override
  String get billing_benefitPrivacy => 'حریم خصوصی آنلاین';

  @override
  String get billing_benefitNoAccount => 'ثبت‌نام اجباری نیست';

  @override
  String get billing_cancellation => 'لغو در Google Play';

  @override
  String get billing_premiumTitle => 'اتصال شما با محافظت بهتر.';

  @override
  String get billing_premiumSubtitle =>
      'با طرح مناسب خود از اتصال محافظت کنید.';

  @override
  String get billing_priceMonthly => 'در ماه';

  @override
  String get billing_priceYearly => 'در سال';

  @override
  String get billing_trialToday => 'امروز پرداختی ندارید';

  @override
  String get billing_trialConfirmation =>
      'Google Play تاریخ‌ها، مبلغ نهایی و مالیات‌های مربوط را پیش از تأیید شما مشخص می‌کند.';

  @override
  String get billing_offerChanged =>
      'شرایط این پیشنهاد تغییر کرده است. طرح‌ها را تازه‌سازی کنید و دوباره انتخاب کنید.';
}
