// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get accountRestoration_title => 'الحساب غير متاح مؤقتًا';

  @override
  String get accountRestoration_message =>
      'لقد حُفظت جلستك. أعد المحاولة لاستعادة حسابك؛ ولا يزال بإمكانك إدارة اتصال VPN من هنا.';

  @override
  String get action_retry => 'إعادة المحاولة';

  @override
  String get session_endingTitle => 'إنهاء الجلسة';

  @override
  String get session_ending => 'أُبطلت جلستك. جارٍ إيقاف VPN ومسح الجلسة…';

  @override
  String get session_stopFailed =>
      'لم يُؤكَّد إيقاف VPN. أعد المحاولة قبل تسجيل الدخول مرة أخرى.';

  @override
  String get session_cleanupFailed =>
      'تم إيقاف VPN، لكن لم يُؤكَّد حذف الجلسة. أعد محاولة التنظيف.';

  @override
  String get session_retryStop => 'إعادة محاولة الإيقاف';

  @override
  String get session_retryCleanup => 'إعادة محاولة التنظيف';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'جارٍ إعداد FuzeVPN بأمان…';

  @override
  String get nav_connection => 'الاتصال';

  @override
  String get nav_locations => 'المواقع';

  @override
  String get nav_account => 'الحساب';

  @override
  String get nav_devices => 'الأجهزة';

  @override
  String get nav_settings => 'الإعدادات';

  @override
  String get action_refresh => 'تحديث';

  @override
  String get auth_tab_login => 'تسجيل الدخول';

  @override
  String get auth_tab_register => 'إنشاء حساب';

  @override
  String get auth_stepAccount => 'الحساب';

  @override
  String get auth_stepIdentity => 'الهوية';

  @override
  String get auth_stepAddress => 'العنوان والموافقات';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get auth_tagline => 'VPN الخاص بك، أصبح بسيطًا.';

  @override
  String get auth_keysLocal => 'تبقى مفاتيح VPN الخاصة بك على هذا الجهاز.';

  @override
  String get form_email => 'عنوان البريد الإلكتروني';

  @override
  String get form_password => 'كلمة المرور';

  @override
  String get form_showPassword => 'إظهار كلمة المرور';

  @override
  String get form_hidePassword => 'إخفاء كلمة المرور';

  @override
  String get form_passwordMin =>
      'من 8 إلى 72 بايتًا بترميز UTF-8. تستخدم بعض الأحرف أكثر من بايت واحد.';

  @override
  String get form_firstName => 'الاسم الأول';

  @override
  String get form_lastName => 'اسم العائلة';

  @override
  String get form_phone => 'الهاتف (+33612345678)';

  @override
  String get form_address => 'العنوان';

  @override
  String get form_address2 => 'سطر العنوان 2 (اختياري)';

  @override
  String get form_postalCode => 'الرمز البريدي';

  @override
  String get form_city => 'المدينة';

  @override
  String get form_country => 'رمز الدولة (مثل FR)';

  @override
  String get action_login => 'تسجيل الدخول';

  @override
  String get action_createAccount => 'إنشاء حساب';

  @override
  String get action_createMyAccount => 'إنشاء حسابي';

  @override
  String get action_next => 'متابعة';

  @override
  String get action_previous => 'رجوع';

  @override
  String get action_forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get auth_noAccount => 'أليس لديك حساب بعد؟';

  @override
  String get auth_requiredInformation => 'أنشئ حسابك في ثلاث خطوات.';

  @override
  String get auth_termsPrefix => 'أوافق على ';

  @override
  String get auth_termsLink => 'شروط الاستخدام';

  @override
  String get auth_privacyPrefix => 'أوافق على ';

  @override
  String get auth_privacyLink => 'سياسة الخصوصية';

  @override
  String get auth_consentRequired => 'موافقتك مطلوبة لإنشاء حساب.';

  @override
  String get validation_required => 'هذا الحقل مطلوب.';

  @override
  String get validation_email => 'أدخل عنوان بريد إلكتروني صالحًا.';

  @override
  String get validation_password =>
      'كلمة المرور قصيرة جدًا: يجب ألا تقل عن 8 بايتات بترميز UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'كلمة المرور طويلة جدًا: يجب ألا تزيد على 72 بايتًا بترميز UTF-8.';

  @override
  String get validation_phone => 'استخدم الصيغة الدولية، مثل ‎+33612345678.';

  @override
  String get validation_country => 'استخدم رمز دولة من حرفين، مثل FR.';

  @override
  String get passwordReset_title => 'إعادة تعيين كلمة المرور';

  @override
  String get passwordReset_description =>
      'أدخل عنوان البريد الإلكتروني لحسابك لطلب رابط إعادة تعيين كلمة المرور.';

  @override
  String get passwordReset_send => 'إرسال الرابط';

  @override
  String get connection_title => 'اتصالك';

  @override
  String get connection_subtitle => 'اختر موقعًا، ثم شغّل VPN.';

  @override
  String get connection_prepare => 'هل أنت مستعد للاتصال؟';

  @override
  String get connection_advancedOptions => 'خيارات متقدمة';

  @override
  String get connection_location => 'الموقع';

  @override
  String get connection_chooseLocation => 'اختر موقعًا';

  @override
  String get connection_protocol => 'البروتوكول';

  @override
  String get connection_connect => 'اتصال';

  @override
  String get connection_connecting => 'جارٍ الاتصال…';

  @override
  String get connection_disconnect => 'قطع الاتصال';

  @override
  String get connection_disconnecting => 'جارٍ قطع الاتصال';

  @override
  String get connection_locationChange => 'جارٍ تغيير الموقع…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol غير متاح';
  }

  @override
  String get connection_activeLocation => 'الموقع النشط';

  @override
  String get connection_duration => 'المدة';

  @override
  String get connection_received => 'المستلم';

  @override
  String get connection_sent => 'المرسل';

  @override
  String get connection_lastHandshake => 'آخر تبادل آمن';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'منذ $duration';
  }

  @override
  String get verification_title => 'أكّد عنوان بريدك الإلكتروني';

  @override
  String get verification_message =>
      'أكّد عنوان بريدك الإلكتروني لاستخدام VPN على هذا الهاتف.';

  @override
  String get verification_resend => 'إعادة إرسال البريد الإلكتروني';

  @override
  String get migration_title => 'تغيير الموقع';

  @override
  String get migration_draining => 'جارٍ التحضير لتغيير الموقع…';

  @override
  String get migration_activating => 'جارٍ تفعيل الخادم الجديد…';

  @override
  String get migration_ready => 'تم تحديث الموقع.';

  @override
  String get migration_blocked =>
      'يتطلب تغيير الموقع تدخلًا من الخادم. حاول مرة أخرى لاحقًا أو تواصل مع الدعم.';

  @override
  String get migration_progress => 'تقدم تغيير الموقع';

  @override
  String migration_retryDelay(Object seconds) {
    return 'الفاصل بين عمليات التحقق: $seconds ثوانٍ.';
  }

  @override
  String get migration_resume => 'استئناف تغيير الموقع';

  @override
  String get status_authorizing => 'الإذن مطلوب';

  @override
  String get status_authorizingDetail =>
      'وافق على طلب Android للسماح باستخدام VPN.';

  @override
  String get status_preparing => 'جارٍ التحضير';

  @override
  String get status_preparingDetail => 'جارٍ إعداد اتصالك الآمن.';

  @override
  String get status_reconnecting => 'جارٍ إعادة الاتصال…';

  @override
  String get status_reconnectingDetail =>
      'انقطع الاتصال. يحاول VPN إعادة الاتصال.';

  @override
  String get status_connecting => 'جارٍ الاتصال';

  @override
  String get status_connectingDetail => 'جارٍ الاتصال بخادم VPN…';

  @override
  String get status_connected => 'متصل';

  @override
  String get status_connectedDetail => 'اتصال VPN نشط.';

  @override
  String get status_disconnecting => 'جارٍ قطع الاتصال';

  @override
  String get status_disconnectingDetail => 'جارٍ إيقاف اتصال VPN.';

  @override
  String get status_error => 'الاتصال غير متاح';

  @override
  String get status_errorDetail => 'لم يُؤكَّد اتصال VPN. حاول مرة أخرى.';

  @override
  String get status_idle => 'غير متصل';

  @override
  String get status_idleDetail => 'اتصل بـ VPN لحماية اتصالك.';

  @override
  String get trust_note =>
      'لا يؤدي إغلاق التطبيق إلى إيقاف VPN. لإيقافه، استخدم «قطع الاتصال».';

  @override
  String get locations_none => 'لا تتوفر أي مواقع حاليًا.';

  @override
  String get locations_available => 'اختر موقعك التالي.';

  @override
  String get locations_selected => 'الموقع المحدد';

  @override
  String get locations_select => 'اختيار هذا الموقع';

  @override
  String get locations_lockedTunnel => 'اقطع اتصال VPN لتغيير الموقع.';

  @override
  String get locations_lockedMigration => 'انتظر حتى يكتمل تغيير الموقع.';

  @override
  String get devices_title => 'أجهزتك';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit أجهزة';
  }

  @override
  String get devices_refresh => 'تحديث الأجهزة';

  @override
  String get devices_empty => 'لم يُسجَّل أي جهاز VPN بعد.';

  @override
  String get devices_firstConnection => 'ستتم إضافة هاتفك عند أول اتصال.';

  @override
  String get devices_thisDevice => 'هذا الجهاز';

  @override
  String devices_added(Object date) {
    return 'أُضيف في $date';
  }

  @override
  String get action_remove => 'إزالة';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get settings_subtitle => 'تفضيلاتك وحسابك، كلها في مكان واحد.';

  @override
  String get settings_appearance => 'المظهر';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_languageDescription =>
      'تنطبق اللغة التي اخترتها أيضًا على إشعارات VPN.';

  @override
  String get settings_account => 'الحساب';

  @override
  String get settings_signOut => 'تسجيل الخروج';

  @override
  String get settings_privacy => 'سياسة الخصوصية';

  @override
  String get settings_terms => 'شروط الاستخدام';

  @override
  String get settings_security => 'الأمان والشفافية';

  @override
  String get settings_licenses => 'تراخيص المكونات';

  @override
  String get settings_licensesDetail => 'البرامج المستخدمة في التطبيق';

  @override
  String get settings_background =>
      'يبقى VPN قيد التشغيل عند مغادرة التطبيق. لإيقافه، استخدم «قطع الاتصال» في علامة تبويب الاتصال.';

  @override
  String get theme_system => 'النظام';

  @override
  String get theme_light => 'فاتح';

  @override
  String get theme_dark => 'داكن';

  @override
  String get language_system => 'لغة الهاتف';

  @override
  String get language_fr => 'الفرنسية';

  @override
  String get language_en => 'الإنجليزية';

  @override
  String get language_es => 'الإسبانية';

  @override
  String get language_de => 'الألمانية';

  @override
  String get dialog_removeDevice => 'إزالة هذا الجهاز؟';

  @override
  String get dialog_removeCurrent =>
      'سينقطع هذا الهاتف عن VPN وسيفقد إمكانية الوصول. ستتم إزالة بيانات اتصال VPN الخاصة به بعد تأكيد الخادم.';

  @override
  String dialog_removeOther(Object name) {
    return 'سيُلغى وصول VPN لـ «$name». لا يمكن التراجع عن ذلك.';
  }

  @override
  String get dialog_signOut => 'تسجيل الخروج؟';

  @override
  String get dialog_signOutMessage =>
      'سيتوقف VPN، وستحتاج إلى تسجيل الدخول مرة أخرى. ستبقى مفاتيح VPN المشفرة على هذا الهاتف لاتصالك التالي.';

  @override
  String get action_cancel => 'إلغاء';

  @override
  String get action_signOut => 'تسجيل الخروج';

  @override
  String get notice_close => 'تجاهل الرسالة';

  @override
  String get notice_sessionExpired_title => 'انتهت الجلسة';

  @override
  String get notice_sessionExpired_message =>
      'انتهت جلستك. سجّل الدخول مرة أخرى.';

  @override
  String get notice_connectionFailed_title => 'فشل الاتصال';

  @override
  String get notice_invalidCredentials_message =>
      'عنوان البريد الإلكتروني أو كلمة المرور غير صحيح.';

  @override
  String get notice_emailVerification_title => 'تأكيد البريد الإلكتروني مطلوب';

  @override
  String get notice_emailVerification_message =>
      'أكّد عنوان بريدك الإلكتروني قبل إضافة جهاز VPN.';

  @override
  String get notice_rateLimited_title => 'محاولات كثيرة جدًا';

  @override
  String get notice_deviceLimit_title => 'تم بلوغ حد جهازين';

  @override
  String get notice_deviceLimit_message =>
      'أزل جهازًا موجودًا قبل إضافة جهاز آخر.';

  @override
  String get notice_identityRenewal_title => 'يجب تجديد هوية VPN';

  @override
  String get notice_identityRenewal_message =>
      'أُزيلت هذه الهوية. أنشئ هوية محلية جديدة.';

  @override
  String get notice_migrationPending_title => 'تغيير الموقع قيد التنفيذ';

  @override
  String get notice_migrationPending_message =>
      'هناك تغيير موقع قيد التنفيذ بالفعل.';

  @override
  String get notice_migrationBlocked_title => 'تغيير الموقع محظور';

  @override
  String get notice_migrationBlocked_message =>
      'يتطلب تغيير الموقع تدخلًا من الخادم. حاول مرة أخرى لاحقًا أو تواصل مع الدعم.';

  @override
  String get notice_targetUnavailable_title => 'الخادم غير متاح مؤقتًا';

  @override
  String get notice_targetUnavailable_message => 'هذا الخادم غير متاح مؤقتًا.';

  @override
  String get notice_networkUnavailable_title => 'اتصال الإنترنت غير متاح';

  @override
  String get notice_networkUnavailable_message =>
      'تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get notice_permissionDenied_title => 'رُفض إذن VPN';

  @override
  String get notice_permissionDenied_message =>
      'ابدأ الاتصال مرة أخرى ووافق على طلب إذن Android.';

  @override
  String get notice_wireguardTimeout_title => 'الخادم لا يستجيب';

  @override
  String get notice_wireguardTimeout_message =>
      'استغرق اتصال WireGuard وقتًا طويلًا جدًا. حاول مرة أخرى أو اختر موقعًا آخر.';

  @override
  String get notice_tlsFailed_title => 'رُفض الاتصال الآمن';

  @override
  String get notice_tlsFailed_message =>
      'لم يقبل الخادم اتصال OpenVPN. حاول مرة أخرى. إذا استمرت المشكلة، شغّل تشخيصًا.';

  @override
  String get notice_tunRejected_title => 'رفض Android واجهة VPN';

  @override
  String get notice_tunRejected_message =>
      'رفض Android إعداد الشبكة الذي طلبه OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'تعذر تشغيل OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'تعذر على محرك OpenVPN إكمال التشغيل. حاول مرة أخرى. إذا استمرت المشكلة، تواصل مع الدعم.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'رمز التشخيص: $code';
  }

  @override
  String get notice_generic_title => 'فشل اتصال VPN';

  @override
  String get notice_generic_message => 'حدث خطأ. حاول مرة أخرى لاحقًا.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'تم إنشاء الحساب',
      'password_reset_sent': 'تم استلام طلب إعادة تعيين كلمة المرور',
      'verification_email_sent': 'تم إرسال رسالة التحقق',
      'location_migration_pending': 'تغيير الموقع قيد التنفيذ',
      'vpn_sign_in_required': 'تسجيل الدخول مطلوب',
      'protocol_unavailable_at_location': 'البروتوكول غير متاح',
      'vpn_permission_denied': 'رُفض إذن VPN',
      'revoked_identity_device_limit': 'تم بلوغ حد جهازين',
      'tunnel_start_unexpected': 'تعذر تشغيل VPN',
      'flutter_disconnect_timeout': 'لم يُؤكَّد قطع الاتصال',
      'flutter_disconnect_unexpected': 'تعذر قطع الاتصال',
      'device_revoked': 'أُزيل الجهاز',
      'revoke_unexpected': 'تعذرت إزالة الجهاز',
      'identity_renewal_unexpected': 'تعذر تجديد الهوية',
      'openvpn_renewal_unexpected': 'تعذر تجديد OpenVPN',
      'location_migration_blocked': 'تغيير الموقع محظور',
      'location_migration_slow': 'لا يزال تغيير الموقع قيد التنفيذ',
      'location_migration_conflict': 'يحتاج تغيير الموقع إلى تحديث',
      'location_migration_verification_failed': 'لم يُؤكَّد تغيير الموقع',
      'location_migration_device_changed': 'تغيّر الجهاز أثناء تغيير الموقع',
      'tunnel_stop_failed': 'تغيير الموقع غير متاح',
      'other': 'فشلت العملية',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'تم إنشاء الحساب، لكن تعذر إرسال رسالة التحقق. استخدم خيار إعادة الإرسال في التطبيق.',
      'password_reset_sent':
          'تم استلام طلبك. إذا كان هناك حساب مرتبط بهذا العنوان، فقد تصلك رسالة إلكترونية. يُرجى التحقق أيضًا من مجلد البريد العشوائي.',
      'verification_email_sent': 'أُرسلت للتو رسالة تحقق جديدة.',
      'location_migration_pending':
          'لا يزال الانتقال إلى $target قيد التحضير. يمكنك استئنافه دون إعادة إنشاء الجهاز.',
      'vpn_sign_in_required': 'سجّل الدخول إلى حسابك قبل تشغيل VPN.',
      'protocol_unavailable_at_location':
          'البروتوكول المحدد غير مقدم في هذا الموقع. حدّث المواقع أو اختر بروتوكولًا آخر.',
      'vpn_permission_denied':
          'رفض Android إذن VPN. ابدأ الاتصال مرة أخرى ووافق على طلب النظام.',
      'revoked_identity_device_limit':
          'أُزيل وصول VPN لهذا الجهاز وتم بلوغ حد الأجهزة. أزل جهازًا من «الحساب ← إدارة أجهزتي».',
      'tunnel_start_unexpected':
          'أوقف خطأ غير متوقع إعداد النفق. تحقق من رمز التشخيص وحاول مرة أخرى.',
      'flutter_disconnect_timeout':
          'لم يؤكد Android إيقاف VPN في الوقت المحدد. حاول إيقافه مرة أخرى.',
      'flutter_disconnect_unexpected': 'منع خطأ غير متوقع تأكيد توقف النفق.',
      'device_revoked': 'أُلغي وصول VPN للجهاز وأُزيلت أسراره المحلية.',
      'revoke_unexpected': 'تعذرت إزالة الجهاز. حدّث القائمة وحاول مرة أخرى.',
      'identity_renewal_unexpected':
          'تعذر إنشاء هوية VPN الجديدة. حدّث الأجهزة وحاول مرة أخرى.',
      'openvpn_renewal_unexpected':
          'تعذر تجديد ملف OpenVPN. حاول مرة أخرى أو تحقق من رمز التشخيص.',
      'location_migration_blocked':
          'لا يستطيع الخادم إكمال هذا التغيير الآن. تم الاحتفاظ بالجهاز وهويته المحلية.',
      'location_migration_slow':
          'لا يزال الخادم يجهز الانتقال إلى $target. استخدم «استئناف» بعد لحظات.',
      'location_migration_conflict':
          'تغيرت حالة الجهاز على الخادم. حدّث الأجهزة، ثم استأنف التغيير.',
      'location_migration_verification_failed':
          'لم يؤكد الخادم الموقع الجديد. تم الاحتفاظ بالهوية المحلية السابقة.',
      'location_migration_device_changed':
          'لم يعد الجهاز الذي أعاده الخادم مطابقًا للجهاز الجاري تغييره. حدّث الأجهزة قبل المحاولة مرة أخرى.',
      'tunnel_stop_failed':
          'يجب إيقاف النفق السابق بالكامل قبل الاتصال الجديد.',
      'other':
          'تعذر إكمال العملية. حاول مرة أخرى أو أرسل رمز التشخيص إلى الدعم.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'انتهت الجلسة',
      'invalid_credentials': 'فشل تسجيل الدخول',
      'email_verification_required': 'تأكيد البريد الإلكتروني مطلوب',
      'verification_email_cooldown': 'تم إرسال البريد الإلكتروني بالفعل',
      'rate_limited': 'محاولات كثيرة جدًا',
      'invalid_registration': 'يجب تصحيح المعلومات',
      'email_exists': 'الحساب موجود بالفعل',
      'invalid_profile': 'الملف الشخصي غير صالح',
      'invalid_device': 'الجهاز غير صالح',
      'invalid_location': 'الموقع غير متاح',
      'device_limit': 'تم بلوغ حد جهازين',
      'device_exists': 'هوية VPN مستخدمة بالفعل',
      'device_identity_revoked': 'يجب تجديد هوية VPN',
      'device_location_locked': 'يحتاج تغيير الموقع إلى تحديث',
      'location_migration_pending': 'تغيير الموقع قيد التنفيذ',
      'location_migration_blocked': 'تغيير الموقع محظور',
      'target_ca_mismatch': 'خادم OpenVPN غير متوافق',
      'location_migration_conflict': 'يحتاج تغيير الموقع إلى تحديث',
      'server_full': 'الخادم ممتلئ',
      'capacity_unavailable': 'الموقع غير متاح مؤقتًا',
      'target_unavailable': 'الخادم غير متاح مؤقتًا',
      'not_found': 'العنصر غير موجود',
      'invalid_openvpn_csr': 'هوية OpenVPN غير صالحة',
      'openvpn_profile_exists': 'ملف OpenVPN موجود بالفعل',
      'openvpn_profile_revoked': 'أُلغي ملف OpenVPN',
      'openvpn_operation_pending': 'عملية OpenVPN قيد التنفيذ',
      'openvpn_operation_terminal': 'انقطعت عملية OpenVPN',
      'openvpn_address_unavailable': 'عنوان OpenVPN غير متاح',
      'openvpn_profile_conflict': 'تعارض في OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN غير متاح',
      'email_delivery_unavailable': 'البريد الإلكتروني غير متاح',
      'invalid_token': 'الرابط غير صالح',
      'network_unavailable': 'اتصال الإنترنت غير متاح',
      'invalid_json': 'الطلب غير صالح',
      'invalid_api_response': 'استجابة الخادم غير صالحة',
      'ipv6_unavailable': 'IPv6 غير متاح',
      'invalid_ip_families': 'رُفض إعداد الشبكة',
      'other': 'الخدمة غير متاحة',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'انتهت جلستك. سجّل الدخول مرة أخرى.',
      'invalid_credentials': 'عنوان البريد الإلكتروني أو كلمة المرور غير صحيح.',
      'email_verification_required':
          'أكّد عنوان بريدك الإلكتروني قبل إضافة جهاز VPN.',
      'invalid_registration': 'تحقق من المعلومات والموافقات المطلوبة.',
      'email_exists': 'هناك حساب يستخدم عنوان البريد الإلكتروني هذا بالفعل.',
      'invalid_profile': 'تحقق من معلومات ملفك الشخصي.',
      'invalid_device': 'اسم هذا الجهاز أو هويته المحلية غير صالح.',
      'invalid_location': 'حدّث قائمة المواقع وحاول مرة أخرى.',
      'device_limit': 'أزل جهازًا موجودًا قبل إضافة جهاز آخر.',
      'device_exists': 'هوية VPN هذه مرتبطة بالفعل بحساب آخر.',
      'device_identity_revoked':
          'أُزيلت هذه الهوية. يجب إنشاء هوية محلية جديدة.',
      'device_location_locked':
          'تغير موقع هذا الجهاز للتو. سيستأنف التطبيق التغيير الجاري.',
      'location_migration_pending': 'هناك تغيير موقع قيد التنفيذ بالفعل.',
      'location_migration_blocked':
          'يتطلب تغيير الموقع تدخلًا من الخادم. حاول مرة أخرى لاحقًا أو تواصل مع الدعم.',
      'target_ca_mismatch': 'هذا الخادم غير متوافق بعد مع ملف OpenVPN الحالي.',
      'location_migration_conflict':
          'حدّث الأجهزة، ثم حاول تغيير الموقع مرة أخرى.',
      'server_full':
          'بلغ هذا الموقع حد اتصالاته. اختر موقعًا آخر أو حاول مرة أخرى لاحقًا.',
      'capacity_unavailable':
          'لا يمكننا تأكيد توفر هذا الموقع الآن. اختر موقعًا آخر أو حاول مرة أخرى لاحقًا.',
      'target_unavailable': 'هذا الخادم غير متاح مؤقتًا.',
      'not_found': 'لم يعد هذا العنصر متاحًا في حسابك.',
      'invalid_openvpn_csr': 'أنشئ هوية OpenVPN جديدة وحاول مرة أخرى.',
      'openvpn_profile_exists': 'يوجد ملف OpenVPN لهذا الجهاز بالفعل.',
      'openvpn_profile_revoked': 'جدّد ملف OpenVPN للمتابعة.',
      'openvpn_operation_pending':
          'لا يزال التغيير قيد الانتشار. حاول مرة أخرى لاحقًا.',
      'openvpn_operation_terminal': 'أنشئ هوية OpenVPN جديدة وحاول مرة أخرى.',
      'openvpn_address_unavailable': 'لا يتوفر عنوان OpenVPN حاليًا.',
      'openvpn_profile_conflict': 'تغير الملف. حدّث الأجهزة وحاول مرة أخرى.',
      'openvpn_signer_unavailable': 'خدمة OpenVPN غير متاحة مؤقتًا.',
      'email_delivery_unavailable':
          'تعذر إرسال البريد الإلكتروني. حاول مرة أخرى لاحقًا.',
      'invalid_token':
          'هذا الرابط غير صالح أو انتهت صلاحيته. اطلب رابطًا جديدًا.',
      'network_unavailable': 'تحقق من اتصال الإنترنت وحاول مرة أخرى.',
      'invalid_json': 'تحقق من المعلومات المدخلة وحاول مرة أخرى.',
      'invalid_api_response':
          'أعاد الخادم استجابة غير متوقعة. حاول مرة أخرى لاحقًا.',
      'ipv6_unavailable':
          'لا يستطيع الخادم تفعيل IPv6 في الوقت الحالي. حاول مرة أخرى لاحقًا.',
      'invalid_ip_families':
          'إعداد النفق غير مكتمل أو لا يطابق العناوين المصرح بها. حاول مرة أخرى من التطبيق.',
      'other': 'حدث خطأ في الخادم. حاول مرة أخرى لاحقًا.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'حاول مرة أخرى بعد لحظات.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'حاول مرة أخرى بعد $seconds ثانية.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'استئناف VPN النظام غير متاح',
      'system_vpn_resume_corrupt': 'استئناف VPN النظام غير صالح',
      'system_vpn_resume_session_invalid': 'جلسة استئناف VPN غير صالحة',
      'system_vpn_resume_identity_changed': 'تغيرت هوية VPN',
      'system_vpn_resume_identity_invalid': 'هوية استئناف VPN غير صالحة',
      'system_vpn_resume_storage_failed': 'تخزين استئناف VPN غير متاح',
      'system_vpn_resume_network_timeout': 'لا توجد شبكة لاستئناف VPN',
      'system_vpn_resume_blocked': 'استئناف VPN محظور',
      'system_vpn_resume_failed': 'فشل استئناف VPN',
      'system_vpn_resume_error_invalid': 'خطأ استئناف VPN غير صالح',
      'wireguard_identity_store_failed': 'لم تُحفظ هوية WireGuard',
      'wireguard_identity_unavailable': 'هوية WireGuard غير متاحة',
      'vpn_host_destroyed': 'أوقف Android مضيف VPN',
      'vpn_host_unavailable': 'مضيف VPN في Android غير متاح',
      'vpn_permission_required': 'إذن VPN مطلوب',
      'vpn_permission_denied': 'رُفض إذن VPN',
      'vpn_permission_request_failed': 'تعذر طلب الإذن',
      'wireguard_foreground_service_unavailable': 'خدمة WireGuard غير متاحة',
      'wireguard_identity_invalid': 'مفتاح WireGuard المحلي غير صالح',
      'wireguard_identity_in_use': 'هوية WireGuard مستخدمة بالفعل',
      'wireguard_configuration_invalid': 'إعداد WireGuard غير صالح',
      'wireguard_operation_pending': 'لا تزال عملية WireGuard نشطة',
      'wireguard_start_failed': 'رُفض تشغيل WireGuard',
      'wireguard_stop_timeout': 'لم يُؤكَّد إيقاف WireGuard',
      'wireguard_handshake_timeout': 'لم يستجب WireGuard',
      'openvpn_connection_timeout': 'لم يستجب OpenVPN',
      'openvpn_core_unavailable': 'محرك OpenVPN غير متاح',
      'openvpn_operation_pending': 'لا تزال جلسة OpenVPN نشطة',
      'openvpn_stop_timeout': 'لم يُؤكَّد إيقاف OpenVPN',
      'openvpn_profile_unavailable': 'ملف OpenVPN المحلي مفقود',
      'openvpn_native_failed': 'انقطع استدعاء OpenVPN الأصلي',
      'openvpn_key_generation_failed': 'تعذر إنشاء مفتاح OpenVPN ‏P-256',
      'openvpn_csr_generation_failed': 'تعذر إنشاء CSR لـ OpenVPN',
      'openvpn_identity_store_failed': 'لم تُحفظ هوية OpenVPN',
      'openvpn_identity_clear_failed': 'إزالة OpenVPN غير مكتملة',
      'openvpn_identity_in_use': 'لا تزال هوية OpenVPN قيد الاستخدام',
      'openvpn_tls_verification_required': 'التحقق من OpenVPN TLS مفقود',
      'openvpn_cipher_invalid': 'شفرة OpenVPN غير صالحة',
      'openvpn_profile_rejected': 'رُفض ملف OpenVPN',
      'openvpn_identity_inconsistent': 'هوية OpenVPN غير متسقة',
      'tls_handshake_failed': 'رُفض تفاوض OpenVPN',
      'tls_alert_unknown_ca': 'لم يتم التعرف على شهادة عميل OpenVPN',
      'tls_alert_bad_certificate': 'رُفضت شهادة عميل OpenVPN',
      'tls_alert_unsupported_certificate': 'شهادة OpenVPN غير مدعومة',
      'tls_client_certificate_required': 'شهادة عميل OpenVPN مطلوبة',
      'tls_alert_misc': 'تنبيه OpenVPN TLS',
      'tls_signature_algorithm_rejected': 'توقيع OpenVPN غير مدعوم',
      'tls_handshake_rejected': 'رُفض تفاوض OpenVPN TLS',
      'tls_version_rejected': 'إصدار OpenVPN TLS غير متوافق',
      'tls_certificate_expired': 'انتهت صلاحية شهادة TLS',
      'tls_certificate_revoked': 'أُلغيت شهادة TLS',
      'transport_failed': 'لا يمكن الوصول إلى خادم OpenVPN',
      'tun_configuration_rejected': 'تعذر إنشاء واجهة OpenVPN',
      'tun_setup_failed': 'فشل إعداد TUN لـ OpenVPN',
      'tun_interface_create_failed': 'فشل إنشاء واجهة OpenVPN',
      'tun_interface_disabled': 'عُطّلت واجهة OpenVPN',
      'tun_halted': 'انقطعت واجهة OpenVPN',
      'tun_already_established': 'واجهة OpenVPN مفتوحة بالفعل',
      'tun_addresses_missing': 'عنوان OpenVPN مفقود',
      'tun_routes_missing': 'مسارات OpenVPN مفقودة',
      'tun_dns_missing': 'DNS الخاص بـ OpenVPN مفقود',
      'tun_permission_revoked': 'أُلغي إذن VPN',
      'tun_establish_returned_null': 'رفض Android واجهة VPN',
      'openvpn_service_start_failed': 'خدمة OpenVPN غير متاحة',
      'openvpn_operation_timeout': 'انتهت مهلة استدعاء OpenVPN',
      'openvpn_start_failed': 'رُفض تشغيل OpenVPN',
      'openvpn_connection_failed': 'انقطع اتصال OpenVPN',
      'openvpn_core_status_error': 'انتهى OpenVPN Core بخطأ',
      'openvpn_stopped_before_connected': 'توقف OpenVPN قبل الاتصال',
      'openvpn_auth_failed': 'رُفضت مصادقة OpenVPN',
      'openvpn_client_setup_failed': 'فشل إعداد عميل OpenVPN',
      'openvpn_client_halted': 'انقطع عميل OpenVPN',
      'openvpn_client_restart': 'طُلب إعادة تشغيل OpenVPN',
      'openvpn_inactive_timeout': 'ظل OpenVPN غير نشط مدة طويلة جدًا',
      'openvpn_session_expired': 'انتهت جلسة OpenVPN',
      'openvpn_credentials_required': 'مصادقة OpenVPN غير مدعومة',
      'openvpn_proxy_failed': 'فشل النقل الوسيط لـ OpenVPN',
      'openvpn_compression_failed': 'رُفض ضغط OpenVPN',
      'openvpn_ntlm_crypto_unavailable': 'تشفير OpenVPN ‏NTLM غير متاح',
      'openvpn_feature_unsupported': 'ميزة OpenVPN غير مدعومة',
      'network_unavailable': 'اتصال الإنترنت غير متاح',
      'network_lost': 'الشبكة غير متاحة',
      'certificate_validation_failed': 'رُفضت شهادة الخادم',
      'openvpn_certificate_expired': 'انتهت صلاحية شهادة OpenVPN',
      'tunnel_active_for_another_account': 'لا يزال نفق حساب آخر نشطًا',
      'tunnel_already_active': 'النفق الأصلي نشط بالفعل',
      'tunnel_stop_timeout': 'لم يُؤكَّد إيقاف $protocol',
      'tunnel_disconnected': 'انقطع $protocol',
      'native_bridge_unavailable': 'جسر Android غير متاح',
      'native_operation_failed': 'انقطعت عملية Android',
      'invalid_arguments': 'معلمات VPN غير مكتملة',
      'invalid_account_id': 'حساب VPN غير صالح',
      'invalid_device_id': 'معرّف الجهاز غير صالح',
      'storage_key_not_allowed': 'رُفض مفتاح التخزين',
      'secure_storage_read_failed': 'فشلت القراءة الآمنة',
      'secure_storage_write_failed': 'فشلت الكتابة الآمنة',
      'key_generation_failed': 'تعذر إنشاء مفتاح WireGuard',
      'csr_generation_failed': 'تعذر إنشاء CSR لـ OpenVPN',
      'other': 'خطأ غير مصنف في VPN الأصلي',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'لا يستطيع Android العثور على جلسة VPN قابلة للاستئناف. ابدأ اتصالًا جديدًا في التطبيق.',
      'system_vpn_resume_corrupt':
          'بيانات استئناف VPN المحفوظة غير صالحة ولن تُستخدم. ابدأ اتصالًا جديدًا.',
      'system_vpn_resume_session_invalid':
          'لم يعد بإمكان الجلسة المحفوظة استئناف VPN. سجّل الدخول مرة أخرى في التطبيق.',
      'system_vpn_resume_identity_changed':
          'تغيرت هوية VPN المحلية. أُوقف الاستئناف؛ ابدأ اتصالًا جديدًا.',
      'system_vpn_resume_identity_invalid':
          'الهوية اللازمة للاستئناف غير صالحة. ابدأ اتصالًا جديدًا.',
      'system_vpn_resume_storage_failed':
          'تعذر على Android قراءة بيانات الاستئناف المشفرة أو تحديثها. ابدأ اتصالًا جديدًا.',
      'system_vpn_resume_network_timeout':
          'لم يعثر Android على شبكة في الوقت المناسب لاستئناف VPN. حاول مرة أخرى عند توفر شبكة.',
      'system_vpn_resume_blocked':
          'استئناف VPN محظور. تحقق من إعدادات Android، ثم ابدأ اتصالًا جديدًا.',
      'system_vpn_resume_failed':
          'فشل استئناف VPN في Android. ابدأ اتصالًا جديدًا في التطبيق.',
      'system_vpn_resume_error_invalid':
          'أعاد Android خطأ استئناف غير قابل للاستخدام. ابدأ اتصالًا جديدًا.',
      'wireguard_identity_store_failed':
          'تعذر على Android حفظ هوية WireGuard المشفرة لهذا الحساب.',
      'wireguard_identity_unavailable':
          'لا تتوفر هوية WireGuard قابلة للاستخدام لهذا الاتصال.',
      'vpn_host_destroyed':
          'أُوقف مكوّن Android الذي يستضيف VPN. ابدأ اتصالًا جديدًا.',
      'vpn_host_unavailable':
          'لا يستطيع Android إنشاء المكوّن الذي يستضيف VPN. حاول مرة أخرى بعد التحقق من إعدادات VPN.',
      'openvpn_renewal_required':
          'تتطلب الشهادة إجراءً في التطبيق قبل الاتصال.',
      'openvpn_recovery_failed':
          'فشلت الاستعادة التلقائية. ابدأ اتصالًا جديدًا في التطبيق.',
      'openvpn_recovery_exhausted':
          'اُستخدمت الاستعادة التلقائية بالفعل. ابدأ اتصالًا جديدًا في التطبيق.',
      'vpn_permission_required':
          'يتطلب Android تفويضًا جديدًا لـ VPN قبل بدء النفق.',
      'vpn_permission_denied': 'اسمح لـ FuzeVPN في طلب Android للمتابعة.',
      'vpn_permission_request_failed': 'تعذر على Android فتح شاشة إذن VPN.',
      'wireguard_foreground_service_unavailable':
          'تعذر على Android إبقاء خدمة WireGuard في الواجهة الأمامية.',
      'wireguard_identity_invalid':
          'مفتاح WireGuard المشفر لهذا الحساب غير قابل للقراءة أو غير صالح.',
      'wireguard_identity_in_use':
          'لا تزال عملية أخرى تستخدم مفتاح WireGuard لهذا الحساب.',
      'wireguard_configuration_invalid':
          'عنوان WireGuard أو DNS أو مفتاح الخادم أو المسارات المستلمة غير صالحة.',
      'wireguard_operation_pending':
          'لم تُفرغ عملية WireGuard السابقة خدمتها الأصلية بعد.',
      'wireguard_start_failed': 'رفض محرك WireGuard تفعيل الإعداد.',
      'wireguard_stop_timeout':
          'لم تؤكد خدمة WireGuard تحرير واجهة VPN ضمن المهلة المحددة.',
      'wireguard_handshake_timeout':
          'لم يؤكد النفق إجراء مصافحة مع الخادم في الوقت المحدد.',
      'openvpn_connection_timeout':
          'لم يؤكد OpenVPN الاتصال بالخادم في الوقت المحدد.',
      'openvpn_core_unavailable':
          'لا يحتوي إصدار التطبيق هذا على محرك OpenVPN قابل للاستخدام.',
      'openvpn_operation_pending':
          'لا يزال المحرك الأصلي يحتفظ بجلسة OpenVPN السابقة ويرفض إنشاء جلسة ثانية.',
      'openvpn_stop_timeout':
          'لم يؤكد OpenVPN Core توقف جلسته الأصلية وتدميرها ضمن المهلة المحددة.',
      'openvpn_profile_unavailable':
          'لا يمكن قراءة أي ملف OpenVPN موثّق لهذا الاتصال.',
      'openvpn_native_failed':
          'أوقف خطأ في التطبيق OpenVPN. حاول الاتصال مرة أخرى. إذا استمرت المشكلة، شغّل تشخيصًا.',
      'openvpn_key_generation_failed':
          'تعذر على Android Keystore إنشاء مفتاح P-256 الخاص غير القابل للتصدير أو قراءته.',
      'openvpn_csr_generation_failed':
          'تعذر على مفتاح Android Keystore توقيع طلب شهادة OpenVPN.',
      'openvpn_identity_store_failed':
          'تعذر حفظ شهادة OpenVPN أو ملفه في التخزين المشفر.',
      'openvpn_identity_clear_failed':
          'تعذر على Android إزالة هوية OpenVPN المحلية بالكامل لهذا الحساب.',
      'openvpn_identity_in_use':
          'لا تزال جلسة OpenVPN أصلية تستخدم مفتاح هذا الجهاز أو شهادته.',
      'openvpn_tls_verification_required':
          'لا يتطلب الملف صراحةً التحقق من شهادة الخادم.',
      'openvpn_cipher_invalid':
          'قدم الخادم خوارزمية تشفير غير موجودة في القائمة المسموح بها.',
      'openvpn_profile_rejected':
          'الملف المستلم من الخادم غير متوافق. أعد إنشاء هذا الجهاز وحاول مرة أخرى.',
      'openvpn_identity_inconsistent':
          'لا تطابق الشهادة الهوية الآمنة لهذا الهاتف. لم يُستبدل أي ملف محلي.',
      'tls_handshake_failed':
          'رفض الخادم تفاوض TLS. أعد إنشاء الملف إذا استمرت المشكلة.',
      'tls_alert_unknown_ca':
          'لا يتعرف الخادم على سلطة شهادة هذا الجهاز. يجب التحقق من خادم OpenVPN.',
      'tls_alert_bad_certificate':
          'رفض الخادم شهادة هذا الجهاز. أعد إنشاء الجهاز قبل المحاولة مرة أخرى.',
      'tls_alert_unsupported_certificate':
          'لا يدعم الخادم نوع الشهادة الآمنة الذي يستخدمه Android.',
      'tls_client_certificate_required':
          'يتطلب الخادم شهادة عميل، لكن تعذر على OpenVPN Core تقديمها.',
      'tls_alert_misc': 'أعاد الخادم تنبيه TLS خارج فئتي الشهادة والإصدار.',
      'tls_signature_algorithm_rejected':
          'رفض الخادم خوارزمية ECDSA P-256 لمفتاح Android Keystore.',
      'tls_handshake_rejected': 'قاطع الخادم تفاوض TLS قبل الاتصال.',
      'tls_version_rejected': 'لم يعثر العميل والخادم على إصدار TLS مشترك.',
      'tls_certificate_expired': 'انتهت صلاحية الشهادة المقدمة أثناء الاتصال.',
      'tls_certificate_revoked': 'أُلغيت الشهادة المقدمة أثناء الاتصال.',
      'transport_failed':
          'لا يستجيب خادم OpenVPN على الشبكة الحالية. حاول مرة أخرى بعد قليل.',
      'tun_configuration_rejected':
          'رفض Android إعداد الشبكة الذي طلبه OpenVPN.',
      'tun_setup_failed':
          'رفض OpenVPN Core خطة الشبكة قبل إنشاء واجهة Android.',
      'tun_interface_create_failed':
          'تعذر على OpenVPN Core الحصول على واجهة TUN من Android VpnService.',
      'tun_interface_disabled':
          'عطّل Android أو OpenVPN Core واجهة TUN أثناء الاتصال.',
      'tun_halted': 'تلقى OpenVPN Core طلبًا لإيقاف واجهة TUN.',
      'tun_already_established':
          'طلب OpenVPN واجهة ثانية في الاتصال نفسه. أُوقف النفق لدواعي الأمان.',
      'tun_addresses_missing': 'لم يوفر الخادم عنوان نفق قابلًا للاستخدام.',
      'tun_routes_missing': 'لم يوفر الخادم مسارات نفق قابلة للاستخدام.',
      'tun_dns_missing': 'لم يوفر الخادم خادم DNS قابلًا للاستخدام.',
      'tun_permission_revoked': 'ألغى Android إذن VPN أثناء الاتصال.',
      'tun_establish_returned_null':
          'لم ينشئ Android الواجهة، عادةً لأن VPN آخر لا يزال نشطًا.',
      'openvpn_service_start_failed':
          'تعذر على Android تشغيل خدمة OpenVPN في الواجهة الأمامية.',
      'openvpn_operation_timeout':
          'تجاوز استدعاء JNI إلى OpenVPN Core أقصى مدة له.',
      'openvpn_start_failed':
          'خدمة Android جاهزة، لكن OpenVPN Core لم يقبل تشغيل الملف.',
      'openvpn_connection_failed': 'توقف OpenVPN Core قبل إصدار حدث CONNECTED.',
      'openvpn_core_status_error':
          'انتهت حلقة OpenVPN الأصلية بخطأ ومن دون حدث نهائي أكثر تحديدًا.',
      'openvpn_stopped_before_connected':
          'توقفت حلقة OpenVPN الأصلية قبل CONNECTED، من دون خطأ صريح من Core.',
      'openvpn_auth_failed': 'رفض خادم OpenVPN مصادقة الملف.',
      'openvpn_client_setup_failed':
          'تعذر على OpenVPN Core تهيئة العميل قبل اتصال الشبكة.',
      'openvpn_client_halted': 'تلقى OpenVPN Core أمرًا نهائيًا لإيقاف العميل.',
      'openvpn_client_restart':
          'طلب OpenVPN Core إعادة تشغيل جلسة النقل الخاصة به.',
      'openvpn_inactive_timeout':
          'أغلق OpenVPN Core الجلسة بعد انتهاء مهلة عدم النشاط.',
      'openvpn_session_expired': 'أفاد الخادم بانتهاء جلسة OpenVPN.',
      'openvpn_credentials_required':
          'يطلب الخادم أو وكيل وسيط بيانات اعتماد تفاعلية ليست جزءًا من ملف الشهادة هذا.',
      'openvpn_proxy_failed':
          'أبلغ OpenVPN Core عن فشل الوكيل أو المرحّل المُعد.',
      'openvpn_compression_failed':
          'رفض OpenVPN Core وضع الضغط الذي أعلنه الملف أو الخادم.',
      'openvpn_ntlm_crypto_unavailable':
          'يطلب الملف تشفير NTLM غير المتاح في هذا الإصدار.',
      'openvpn_feature_unsupported':
          'يتطلب الملف أو الخادم ميزة مفقودة من عميل Android هذا.',
      'network_unavailable': 'لا تتوفر شبكة فعلية قابلة للاستخدام.',
      'network_lost': 'أُوقف النفق بعد فقدان الشبكة.',
      'certificate_validation_failed': 'تعذر التحقق من هوية خادم OpenVPN.',
      'openvpn_certificate_expired': 'جدّد ملف OpenVPN قبل إعادة الاتصال.',
      'tunnel_active_for_another_account':
          'يجب إيقاف نفق تابع لحساب آخر قبل هذا الاتصال.',
      'tunnel_already_active':
          'يفيد Android بأن جلسة VPN سابقة لا تزال تستخدم الواجهة.',
      'tunnel_stop_timeout':
          'لم يؤكد محرك $protocol تحرير واجهة VPN ضمن المهلة المحددة.',
      'tunnel_disconnected':
          'أفاد المحرك الأصلي بأن النفق انتهى بشكل غير متوقع بعد تشغيله.',
      'native_bridge_unavailable':
          'لا يستطيع التطبيق الوصول إلى خدمة VPN في Android. أغلق التطبيق وافتحه مرة أخرى، ثم حاول مجددًا.',
      'native_operation_failed':
          'أوقف خطأ في التطبيق عملية VPN. حاول مرة أخرى. إذا استمرت المشكلة، شغّل تشخيصًا.',
      'invalid_arguments':
          'المعلومات اللازمة لعملية VPN هذه غير مكتملة. حاول مرة أخرى. إذا استمرت المشكلة، شغّل تشخيصًا.',
      'invalid_account_id': 'العملية الأصلية غير مرتبطة بمعرّف حساب صالح.',
      'invalid_device_id':
          'معرّف الجهاز المرسل إلى المحرك الأصلي مفقود أو غير صالح.',
      'storage_key_not_allowed':
          'حظر جسر Android مفتاحًا خارج قائمة التخزين المسموح بها.',
      'secure_storage_read_failed':
          'تعذر على Android Keystore فك تشفير البيانات المحلية لهذا الحساب.',
      'secure_storage_write_failed':
          'تعذر على Android Keystore تشفير البيانات المحلية أو حفظها.',
      'key_generation_failed':
          'تعذر على Android إنشاء مفتاح WireGuard في التخزين الآمن أو قراءته.',
      'csr_generation_failed':
          'تعذر على Android Keystore إنشاء CSR لـ OpenVPN أو توقيعه.',
      'other':
          'فشل فرع أصلي غير موثق. أرسل رمز التشخيص الظاهر أدناه إلى الدعم.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'طلب الإذن مفتوح بالفعل';

  @override
  String get notice_permissionRequestInProgress_message =>
      'طلب إذن VPN من Android معروض بالفعل. أكمله قبل المحاولة مرة أخرى.';

  @override
  String get notice_permissionRequestInterrupted_title => 'انقطع طلب إذن VPN';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'أُغلقت شاشة إذن VPN قبل أن يتلقى التطبيق ردًا.';

  @override
  String get notice_openvpnProofMissing_title => 'لم يُؤكَّد اتصال OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'تعذر تأكيد اتصال OpenVPN. أُوقف لدواعي الأمان. حاول مرة أخرى.';

  @override
  String get openvpnCleanup_title => 'أُلغي ملف OpenVPN';

  @override
  String get openvpnCleanup_working => 'جارٍ إيقاف ملف OpenVPN الملغى وإزالته…';

  @override
  String get openvpnCleanup_stopFailed =>
      'لم يُؤكَّد إيقاف OpenVPN. أعد المحاولة قبل إنشاء ملف جديد.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'تعذرت إزالة ملف OpenVPN الملغى بالكامل. أعد محاولة التنظيف.';

  @override
  String get openvpnCleanup_complete =>
      'أُزيل ملف OpenVPN الملغى. اضغط على «اتصال» لإنشاء ملف جديد.';

  @override
  String get network_title => 'إعداد الشبكة';

  @override
  String get network_ipv4Fallback =>
      'IPv6 غير متاح مؤقتًا. يستمر التحضير باستخدام IPv4.';

  @override
  String get network_rejectedTitle => 'رُفض إعداد الشبكة';

  @override
  String get network_rejectedMessage =>
      'إعداد النفق غير مكتمل أو لا يطابق العناوين المصرح بها. حاول مرة أخرى من التطبيق.';

  @override
  String get network_unreadableTitle => 'تعذرت قراءة الإعداد المحلي';

  @override
  String get network_unreadableMessage =>
      'لا يمكن استخدام إعداد شبكة OpenVPN المحفوظ. أعد الاتصال من التطبيق لتحديثه.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'حماية الشبكة';

  @override
  String get protection_subtitle =>
      'احظر الوصول المباشر إلى الإنترنت إذا انقطع اتصال VPN.';

  @override
  String get protection_active => 'حماية النظام نشطة';

  @override
  String get protection_alwaysOnOnly =>
      'تم تفعيل VPN الدائم؛ شغّل الحظر خارج VPN';

  @override
  String get protection_inactive => 'حماية النظام غير نشطة';

  @override
  String get protection_unknown => 'تحقق من حماية النظام';

  @override
  String get protection_openSettings => 'فتح إعدادات Android';

  @override
  String get protection_dialogTitle => 'إعداد حماية الشبكة';

  @override
  String get protection_dialogMessage =>
      'يدير Android VPN الدائم وحظر الاتصالات خارج VPN. تحقق من تحديد FuzeVPN وفعّل الحظر في إعدادات النظام.';

  @override
  String get protection_dialogOpen => 'فتح الإعدادات';

  @override
  String get session_systemProtectionNote =>
      'إذا ظل Android يحظر حركة المرور خارج VPN، فافتح إعدادات النظام للتحقق من هذه الحماية أو تغييرها.';

  @override
  String get diagnostics_title => 'التشخيص';

  @override
  String get diagnostics_settingsTitle => 'تشخيص التطبيق';

  @override
  String get diagnostics_automaticTitle => 'إرسال الأخطاء المهمة';

  @override
  String get diagnostics_automaticDescription =>
      'شارك تقريرًا تقنيًا موجزًا عند حدوث خطأ مهم.';

  @override
  String get diagnostics_privacy =>
      'ترتبط التقارير المرسلة بالحساب الذي سُجّل الدخول إليه وتُحفظ لمدة 30 يومًا. ولا تتضمن سجل التصفح أو كلمات المرور أو مفاتيح VPN.';

  @override
  String get diagnostics_manualOpen => 'تشغيل التشخيص';

  @override
  String get diagnostics_localDescription =>
      'أنشئ تقريرًا عن حالة التطبيق وVPN. يظل اتصالك دون تغيير.';

  @override
  String get diagnostics_sendReport => 'إرسال التقرير';

  @override
  String get diagnostics_sendHint =>
      'اترك هذا المربع دون تحديد للاحتفاظ بالتقرير على هذا الجهاز.';

  @override
  String get diagnostics_signedOut => 'سجّل الدخول إلى حسابك لإرسال تقرير.';

  @override
  String get diagnostics_localLifetime =>
      'احفظ هذا التقرير على هاتفك للاحتفاظ به بعد إغلاق التطبيق.';

  @override
  String get diagnostics_run => 'تشغيل التشخيص';

  @override
  String get diagnostics_rerun => 'تشغيل التشخيص مرة أخرى';

  @override
  String get diagnostics_running => 'جارٍ التحقق…';

  @override
  String get diagnostics_sending => 'جارٍ إرسال التقرير…';

  @override
  String get diagnostics_prepared => 'التقرير جاهز على هذا الجهاز';

  @override
  String get diagnostics_queued => 'التقرير في انتظار الإرسال';

  @override
  String get diagnostics_sent => 'تم استلام التقرير';

  @override
  String get diagnostics_failed => 'فشل الإرسال. لا يزال تقريرك المحلي متاحًا.';

  @override
  String get diagnostics_preparationFailed =>
      'تعذر إعداد تقرير التشخيص. حاول مرة أخرى.';

  @override
  String get diagnostics_authenticationRequired =>
      'سجّل الدخول مرة أخرى لإرسال التقرير.';

  @override
  String get diagnostics_retry => 'إعادة محاولة الإرسال';

  @override
  String get diagnostics_export => 'حفظ التقرير';

  @override
  String get diagnostics_exportFailed =>
      'فشل التصدير. حاول مرة أخرى من التقرير المحلي.';

  @override
  String get diagnostics_preferenceFailed =>
      'تعذر حفظ هذا الإعداد. حاول مرة أخرى.';

  @override
  String diagnostics_receipt(Object id) {
    return 'المرجع: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'تم الاستلام في $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'يُحفظ حتى $date';
  }

  @override
  String get diagnostics_duplicate => 'سبق استلام هذا التقرير.';

  @override
  String get diagnostics_preview => 'معاينة التقرير';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث تقني مرفق',
      many: '$count حدثًا تقنيًا مرفقًا',
      few: '$count أحداث تقنية مرفقة',
      two: '$count حدثان تقنيان مرفقان',
      one: '$count حدث تقني مرفق',
      zero: '$count أحداث تقنية مرفقة',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'التفاصيل التقنية';

  @override
  String get diagnostics_empty => 'لم يُعد أي تقرير تشخيص بعد.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'حالة النفق',
      'handshake': 'تأكيد الاتصال',
      'certificate': 'شهادة VPN',
      'kill_switch': 'حماية Android',
      'connectivity': 'الشبكة المتاحة',
      'api_reachability': 'الوصول إلى الخدمة',
      'secure_storage': 'التخزين الآمن',
      'other': 'فحص محلي',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'تم التحقق',
      'failed': 'يتطلب الانتباه',
      'skipped': 'لم يُختبر — لا يوجد فحص نشط',
      'unknown': 'المعلومات غير متاحة',
      'other': 'المعلومات غير متاحة',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'مرحبًا بك في FuzeVPN';

  @override
  String get connection_changeLocation => 'تغيير الموقع';

  @override
  String get connection_details => 'تفاصيل الاتصال';

  @override
  String get locations_searchLabel => 'ابحث عن مدينة أو دولة';

  @override
  String get locations_clearSearch => 'مسح البحث';

  @override
  String get locations_filterAll => 'الكل';

  @override
  String get locations_filterFavorites => 'المفضلة';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count موقع',
      many: '$count موقعًا',
      few: '$count مواقع',
      two: '$count موقعان',
      one: '$count موقع',
      zero: '$count موقع',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'لم يُعثر على مواقع';

  @override
  String get locations_noResultsHint => 'جرّب مدينة أو دولة أخرى.';

  @override
  String get locations_noFavorites => 'مفضلاتك في متناول يدك';

  @override
  String get locations_noFavoritesHint =>
      'اضغط على النجمة بجوار موقع لحفظه هنا.';

  @override
  String get locations_showAll => 'عرض جميع المواقع';

  @override
  String locations_addFavorite(String name) {
    return 'إضافة $name إلى المفضلة';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'إزالة $name من المفضلة';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'تعذر حفظ الموقع المفضل. حاول مرة أخرى.';

  @override
  String get locations_emptyTitle => 'لا تتوفر مواقع';

  @override
  String get locations_emptyHint => 'حدّث القائمة وحاول مرة أخرى.';

  @override
  String get devices_manage => 'إدارة أجهزتي';

  @override
  String get settings_personalization => 'اجعله على ذوقك';

  @override
  String get settings_safety => 'الحماية';

  @override
  String get settings_help => 'هل تحتاج إلى مساعدة؟';

  @override
  String get settings_about => 'حول FuzeVPN';

  @override
  String get diagnostics_heading => 'افهم مشكلة في الاتصال';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'متاح',
      'pending': 'جارٍ التحضير',
      'revoked': 'أُزيل',
      'expired': 'منتهي الصلاحية',
      'other': 'الحالة غير متاحة',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'لم تُحفظ التفضيلات';

  @override
  String get notice_preferenceSave_message =>
      'طُبّق اختيارك حاليًا، لكن تعذر حفظه. حاول مرة أخرى للاحتفاظ به بعد إغلاق التطبيق.';

  @override
  String get connection_androidDisconnectHint =>
      'إذا أبقى Android VPN نشطًا، فأوقف VPN الدائم في الإعدادات التي ستُفتح.';

  @override
  String get protection_learnMore => 'تعرّف على حماية Android';

  @override
  String get protection_guideWhy =>
      'تمنع هذه الحماية التطبيقات من استخدام الإنترنت مباشرة إذا انقطع VPN. ويُضبط ذلك في Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN الدائم';

  @override
  String get protection_guideAlwaysOn =>
      'يبقي Android خدمة VPN قيد التشغيل ويمكنه إعادة تشغيلها بعد إعادة تشغيل الهاتف.';

  @override
  String get protection_guideBlockTitle => 'حظر الاتصالات دون VPN';

  @override
  String get protection_guideBlock =>
      'يمنع هذا الإعداد حركة المرور من تجاوز VPN، بما في ذلك أثناء انقطاع الاتصال.';

  @override
  String get protection_guideWarning =>
      'عند تفعيل هذا الحظر، يظل الوصول إلى الإنترنت متوقفًا حتى يتم الاتصال بـ VPN.';

  @override
  String get protection_guideStepsTitle => 'تفعيل الحماية';

  @override
  String get protection_guideStep1 =>
      'افتح إعدادات VPN في Android باستخدام الزر أدناه.';

  @override
  String get protection_guideStep2 =>
      'افتح الخيارات باستخدام رمز الترس بجوار FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'فعّل VPN الدائم، ثم «حظر الاتصالات دون VPN» إذا كانت هذه الخيارات متاحة.';

  @override
  String get protection_guideManufacturers =>
      'تختلف الأسماء حسب الهاتف. عند الحاجة، ابحث عن VPN في الإعدادات، غالبًا ضمن الشبكة والإنترنت.';

  @override
  String get protection_guideDisableTitle => 'إيقاف هذه الحماية';

  @override
  String get protection_guideDisable =>
      'في الإعدادات نفسها، أوقف الحظر دون VPN للسماح بالوصول إلى الإنترنت من دون VPN. وأوقف VPN الدائم أيضًا إذا لم تعد تريد من Android إعادة تشغيله.';

  @override
  String get protection_guideManual =>
      'تختار هذه الإعدادات في Android. لا يغيرها FuzeVPN نيابةً عنك.';

  @override
  String get locations_changeTitle => 'هل تريد تغيير الموقع؟';

  @override
  String locations_changeActive(String name) {
    return 'سينقطع VPN، ثم سيحاول الاتصال بـ $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'سيحاول VPN الاتصال بـ $name.';
  }

  @override
  String get locations_confirmChange => 'تغيير والاتصال';

  @override
  String get locations_changeBusy =>
      'يوجد تغيير قيد التنفيذ. انتظر قبل اختيار موقع آخر.';

  @override
  String get locations_automaticSelection => 'اختيار تلقائي';

  @override
  String get locations_cities => 'المدن';

  @override
  String get locations_servers => 'الخوادم';

  @override
  String locations_viewCities(String name) {
    return 'عرض المدن في $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'عرض الخوادم في $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دولة',
      many: '$count دولة',
      few: '$count دول',
      two: '$count دولتان',
      one: '$count دولة',
      zero: '$count دولة',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مدينة',
      many: '$count مدينة',
      few: '$count مدن',
      two: '$count مدينتان',
      one: '$count مدينة',
      zero: '$count مدينة',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count خادم',
      many: '$count خادمًا',
      few: '$count خوادم',
      two: '$count خادمان',
      one: '$count خادم',
      zero: '$count خادم',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'جميع الدول';

  @override
  String get locations_backToCountries => 'العودة إلى الدول';

  @override
  String locations_backToCities(String name) {
    return 'العودة إلى مدن $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'اختيار $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'اختيار $name';
  }

  @override
  String get locations_noCompatibleServer => 'لا يتوفر خادم متوافق.';

  @override
  String get externalLink_failed =>
      'تعذر فتح هذا الرابط. يمكنك نسخه وفتحه في متصفحك.';

  @override
  String get externalLink_copy => 'نسخ الرابط';

  @override
  String get externalLink_copied => 'تم نسخ الرابط';

  @override
  String get externalLink_copyFailed => 'تعذر نسخ الرابط. حدد العنوان أدناه.';

  @override
  String get settings_deleteAccount => 'حذف حسابي';

  @override
  String get settings_deleteAccountDetail => 'عرض خطوات طلب حذف الحساب';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'اختر اشتراك VPN الخاص بك.';

  @override
  String get billing_subscribe => 'اشترك';

  @override
  String get billing_choosePlan => 'اختر خطة للمتابعة.';

  @override
  String get billing_monthly => 'شهري';

  @override
  String get billing_yearly => 'سنوي';

  @override
  String get billing_continue => 'المتابعة مع Google Play';

  @override
  String get billing_restore => 'استعادة المشتريات';

  @override
  String get billing_manage => 'إدارة الاشتراك';

  @override
  String get billing_deleteAccountWarning =>
      'إذا كان لديك اشتراك عبر Google Play، فإن حذف حسابك في FuzeVPN لا يلغي تجديد الاشتراك. أدِر تجديد الاشتراك أو ألغِه بشكل منفصل في Google Play.';

  @override
  String get billing_deleteAccountContinue => 'المتابعة إلى طلب حذف الحساب';

  @override
  String get billing_refresh => 'تحديث الوصول';

  @override
  String get billing_loadingPlans => 'جارٍ تحميل الخطط…';

  @override
  String get billing_unavailable => 'لا توجد خطط متاحة الآن. حاول لاحقًا.';

  @override
  String get billing_comingSoon => 'الاشتراكات متاحة قريبًا.';

  @override
  String get billing_priceDisclosure =>
      'السعر مقدّم من Google Play. يتم تأكيد المبلغ النهائي قبل الدفع.';

  @override
  String get billing_renewalMonthly =>
      'يتجدد تلقائيًا كل شهر ما لم يتم إلغاؤه. يمكنك الإلغاء في أي وقت من اشتراكات Google Play.';

  @override
  String get billing_renewalYearly =>
      'يتجدد تلقائيًا كل سنة ما لم يتم إلغاؤه. يمكنك الإلغاء في أي وقت من اشتراكات Google Play.';

  @override
  String get billing_active => 'وصولك إلى Premium نشط';

  @override
  String billing_accessUntil(String date) {
    return 'الوصول حتى $date.';
  }

  @override
  String get billing_webManaged => 'تتم إدارة اشتراكك على موقع FuzeVPN.';

  @override
  String get billing_playManaged => 'تتم إدارة اشتراكك عبر Google Play.';

  @override
  String get billing_inactive => 'لا يوجد اشتراك نشط.';

  @override
  String get billing_checkingAccess => 'جارٍ التحقق من وصولك…';

  @override
  String get billing_restoring => 'جارٍ استعادة المشتريات…';

  @override
  String get billing_pending =>
      'الدفع قيد الانتظار. سيتم تفعيل وصولك بعد التأكيد.';

  @override
  String get billing_cancelled => 'تم إلغاء الشراء. لم يتم تفعيل اشتراك جديد.';

  @override
  String get billing_verifying => 'جارٍ التحقق من الشراء…';

  @override
  String get billing_success => 'تم تفعيل الاشتراك. وصولك إلى Premium جاهز.';

  @override
  String get billing_restored => 'تمت استعادة مشترياتك.';

  @override
  String get billing_restoreEmpty =>
      'لا توجد مشتريات لاستعادتها لحساب Google Play هذا.';

  @override
  String get billing_catalogError => 'تعذّر تحميل الخطط. حاول مرة أخرى.';

  @override
  String get billing_purchaseError => 'تعذّر بدء الشراء. حاول مرة أخرى.';

  @override
  String get billing_verificationError =>
      'التحقق من الشراء غير متاح مؤقتًا. استعد المشتريات للمحاولة مرة أخرى.';

  @override
  String get billing_restoreError => 'تعذّرت استعادة المشتريات. حاول مرة أخرى.';

  @override
  String get billing_managementError =>
      'تعذّر فتح إدارة الاشتراكات. حاول مرة أخرى.';

  @override
  String get billing_storeUnavailable => 'Google Play غير متاح على هذا الجهاز.';

  @override
  String get welcome_title => 'شبكتك الخاصة، بكل بساطة.';

  @override
  String get welcome_description => 'احمِ اتصالك. تحكّم في خصوصيتك.';

  @override
  String get welcome_start => 'ابدأ';

  @override
  String get welcome_alreadyPurchased => 'اشتريت بالفعل؟';

  @override
  String get welcome_noAccountRequired => 'لا تحتاج إلى إنشاء حساب للبدء.';

  @override
  String get guest_accountTitle => 'الحساب غير مرتبط';

  @override
  String get guest_accountDescription =>
      'استعِد مشترياتك باستخدام حساب Google Play نفسه لاستخدام اشتراكك على جهاز آخر.';

  @override
  String get guest_existingSubscriberSignIn =>
      'هل لديك اشتراك بالفعل؟ تسجيل الدخول';

  @override
  String get guest_claimTitle => 'خذ FuzeVPN معك';

  @override
  String get guest_claimDescription =>
      'أنشئ حسابًا للوصول إلى اشتراكك على أجهزتك الأخرى. هذه الخطوة اختيارية.';

  @override
  String get guest_skip => 'لاحقًا';

  @override
  String get guest_activationTitle => 'Fuze Premium نشط';

  @override
  String get guest_activationDescription =>
      'اشتراكك جاهز. استخدم VPN وأنشئ حسابًا متى شئت.';

  @override
  String get guest_useVpn => 'استخدام VPN';

  @override
  String get guest_loginRequired =>
      'هذا الشراء مرتبط بالفعل بحساب FuzeVPN. سجّل الدخول إلى ذلك الحساب للوصول إلى اشتراكك.';

  @override
  String get guest_signOutWarning =>
      'يمكنك استعادة اشتراكك باستعادة المشتريات باستخدام حساب Google Play نفسه.';

  @override
  String get guest_profileUnavailable =>
      'حسابك مرتبط بالفعل. سجّل الدخول لعرض معلوماتك وإدارتها.';

  @override
  String get billing_acceptance =>
      'بالمتابعة، فإنك توافق على شروط الاستخدام وسياسة الخصوصية.';

  @override
  String get guest_verifyEmailReminder =>
      'أكّد عنوان بريدك الإلكتروني لتأمين حسابك. يمكنك الاستمرار في استخدام VPN.';

  @override
  String get guest_serviceUnavailable =>
      'الخدمة غير متاحة مؤقتًا. أعد المحاولة بعد قليل.';

  @override
  String get guest_restoreError =>
      'تعذّرت استعادة مشترياتك. أعد المحاولة باستخدام حساب Google Play الذي استخدمته للشراء.';

  @override
  String get guest_claimSuccess =>
      'تم إنشاء حسابك. اشتراكك وإمكانية استخدام VPN محفوظان.';

  @override
  String get guest_emailExists =>
      'عنوان البريد الإلكتروني هذا مستخدم بالفعل. اختر عنوانًا آخر أو سجّل الدخول إلى حسابك الحالي. يظل شراؤك متاحًا عبر Google Play.';

  @override
  String get guest_claimError =>
      'تعذّر إنشاء حسابك. يمكنك الاستمرار في استخدام VPN والمحاولة لاحقًا.';

  @override
  String get guest_secureStorageError =>
      'تعذّر تأمين جلستك على هذا الجهاز. أعد المحاولة.';

  @override
  String get guest_premiumRequired => 'اختر اشتراكًا لتفعيل VPN.';

  @override
  String get welcome_viewPlans => 'عرض الخطط';

  @override
  String get google_continue => 'المتابعة باستخدام Google';

  @override
  String get google_or => 'أو';

  @override
  String get google_title => 'حسابك في FuzeVPN';

  @override
  String get google_settingUp => 'أكمل إنشاء حسابك';

  @override
  String get google_country => 'بلد الإقامة';

  @override
  String get google_profileDescription =>
      'اختر بلدك وراجع المستندين لإنشاء حساب FuzeVPN.';

  @override
  String get google_claimDescription =>
      'اربط حساب الضيف بحساب Google. يبقى اشتراكك وجهازك مرتبطين بهذا الحساب.';

  @override
  String get google_linkTitle => 'ربط Google بحساب FuzeVPN';

  @override
  String get google_linkDescription =>
      'أكد الوصول إلى حساب FuzeVPN الحالي. لا تُطلب كلمة مرور Google.';

  @override
  String get google_password => 'كلمة مرور FuzeVPN';

  @override
  String get google_linkAccount => 'تأكيد الربط';

  @override
  String get google_requestEmail => 'إرسال رسالة تأكيد بالبريد';

  @override
  String get google_emailInstructions =>
      'افتح رسالة FuzeVPN وأدخل رمز التأكيد.';

  @override
  String get google_emailCode => 'رمز التأكيد عبر البريد';

  @override
  String get google_confirmEmail => 'تأكيد الرمز';

  @override
  String get google_restart => 'اختيار حساب Google آخر';

  @override
  String get google_resume => 'التحقق من هذه المحاولة';

  @override
  String get google_unavailable =>
      'تسجيل الدخول باستخدام Google غير متاح. يمكنك استخدام البريد وكلمة المرور.';

  @override
  String get google_expired =>
      'انتهت صلاحية هذه المحاولة. ألغها ثم ابدأ من جديد.';

  @override
  String get google_conflict =>
      'حساب Google هذا مرتبط بحساب آخر. يبقى حسابك واشتراكك الحاليان محفوظين.';

  @override
  String get google_error =>
      'تعذر تسجيل الدخول باستخدام Google. أعد المحاولة؛ وصولك الحالي محفوظ.';

  @override
  String get google_uncertain =>
      'تعذر تأكيد النتيجة. تحقق من هذه المحاولة أو ألغها قبل البدء من جديد.';

  @override
  String get google_cancelFailed =>
      'تعذر تأكيد الإلغاء. حاول الإلغاء مجددًا قبل مغادرة هذه الشاشة.';

  @override
  String get google_cancelled => 'تم إلغاء تسجيل الدخول باستخدام Google.';

  @override
  String get google_selecting => 'اختر حسابك في Google…';

  @override
  String get google_verifying => 'جارٍ التحقق من حسابك…';

  @override
  String get google_emailUnavailable =>
      'تعذر إرسال رسالة التأكيد. حاول لاحقًا.';

  @override
  String get google_emailSent => 'أُرسلت رسالة التأكيد. تحقق من بريدك الوارد.';

  @override
  String get google_rateLimited => 'يرجى الانتظار قبل المحاولة مجددًا.';

  @override
  String get google_invalidPassword =>
      'كلمة مرور FuzeVPN غير صحيحة. حسابك الحالي محفوظ.';

  @override
  String get google_invalidCode => 'رمز التأكيد غير صالح أو انتهت صلاحيته.';

  @override
  String get google_accountChanged =>
      'تغيرت الجلسة. ألغ هذه المحاولة قبل البدء من جديد.';

  @override
  String get google_invalidResponse =>
      'تعذر التحقق من الرد. وصولك الحالي محفوظ.';

  @override
  String get google_invalidRegistration => 'تحقق من البلد والموافقتين.';

  @override
  String get google_consentRequired =>
      'اختر بلدك ووافق على المستندين للمتابعة.';

  @override
  String get google_challengeRequired =>
      'يلزم تحقق أمني إضافي. وصولك الحالي محفوظ.';

  @override
  String get google_challengeUnavailable =>
      'التحقق الأمني غير متاح. حاول لاحقًا.';
}
