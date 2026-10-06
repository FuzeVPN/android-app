// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get accountRestoration_title => 'اکاؤنٹ عارضی طور پر دستیاب نہیں ہے';

  @override
  String get accountRestoration_message =>
      'آپ کا سیشن محفوظ رکھا گیا ہے۔ اپنا اکاؤنٹ بحال کرنے کے لیے دوبارہ کوشش کریں؛ آپ یہاں VPN کنکشن کا انتظام اب بھی کر سکتے ہیں۔';

  @override
  String get action_retry => 'دوبارہ کوشش کریں';

  @override
  String get session_endingTitle => 'سیشن ختم کیا جا رہا ہے';

  @override
  String get session_ending =>
      'آپ کا سیشن غیر مؤثر کر دیا گیا ہے۔ VPN روکا جا رہا ہے اور سیشن صاف کیا جا رہا ہے…';

  @override
  String get session_stopFailed =>
      'VPN بند ہونے کی تصدیق نہیں ہوئی۔ دوبارہ سائن اِن کرنے سے پہلے دوبارہ کوشش کریں۔';

  @override
  String get session_cleanupFailed =>
      'VPN رک گیا ہے، لیکن سیشن ہٹانے کی تصدیق نہیں ہوئی۔ صفائی کے لیے دوبارہ کوشش کریں۔';

  @override
  String get session_retryStop => 'بند کرنے کے لیے دوبارہ کوشش کریں';

  @override
  String get session_retryCleanup => 'صفائی کے لیے دوبارہ کوشش کریں';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN کو محفوظ طریقے سے تیار کیا جا رہا ہے…';

  @override
  String get nav_connection => 'کنکشن';

  @override
  String get nav_locations => 'مقامات';

  @override
  String get nav_account => 'اکاؤنٹ';

  @override
  String get nav_devices => 'آلات';

  @override
  String get nav_settings => 'ترتیبات';

  @override
  String get action_refresh => 'تازہ کریں';

  @override
  String get auth_tab_login => 'سائن اِن کریں';

  @override
  String get auth_tab_register => 'سائن اپ کریں';

  @override
  String get auth_stepAccount => 'اکاؤنٹ';

  @override
  String get auth_stepIdentity => 'شناخت';

  @override
  String get auth_stepAddress => 'پتہ اور معاہدے';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'مرحلہ $current از $total';
  }

  @override
  String get auth_tagline => 'آپ کا VPN، آسان انداز میں۔';

  @override
  String get auth_keysLocal => 'آپ کی نجی VPN کلیدیں اسی ڈیوائس پر رہتی ہیں۔';

  @override
  String get form_email => 'ای میل پتہ';

  @override
  String get form_password => 'پاس ورڈ';

  @override
  String get form_showPassword => 'پاس ورڈ دکھائیں';

  @override
  String get form_hidePassword => 'پاس ورڈ چھپائیں';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 بائٹس۔ کچھ حروف ایک سے زیادہ بائٹس استعمال کرتے ہیں۔';

  @override
  String get form_firstName => 'پہلا نام';

  @override
  String get form_lastName => 'آخری نام';

  @override
  String get form_phone => 'فون (+33612345678)';

  @override
  String get form_address => 'پتہ';

  @override
  String get form_address2 => 'پتے کی دوسری سطر (اختیاری)';

  @override
  String get form_postalCode => 'پوسٹل کوڈ';

  @override
  String get form_city => 'شہر';

  @override
  String get form_country => 'ملکی کوڈ (مثلاً FR)';

  @override
  String get action_login => 'سائن اِن کریں';

  @override
  String get action_createAccount => 'اکاؤنٹ بنائیں';

  @override
  String get action_createMyAccount => 'میرا اکاؤنٹ بنائیں';

  @override
  String get action_next => 'جاری رکھیں';

  @override
  String get action_previous => 'واپس';

  @override
  String get action_forgotPassword => 'پاس ورڈ بھول گئے؟';

  @override
  String get auth_noAccount => 'ابھی تک اکاؤنٹ نہیں ہے؟';

  @override
  String get auth_requiredInformation => 'تین مرحلوں میں اپنا اکاؤنٹ بنائیں۔';

  @override
  String get auth_termsPrefix => 'میں استعمال کی ';

  @override
  String get auth_termsLink => 'شرائط قبول کرتا ہوں';

  @override
  String get auth_privacyPrefix => 'میں رازداری کی ';

  @override
  String get auth_privacyLink => 'پالیسی قبول کرتا ہوں';

  @override
  String get auth_consentRequired =>
      'اکاؤنٹ بنانے کے لیے آپ کی رضامندی ضروری ہے۔';

  @override
  String get validation_required => 'یہ خانہ پُر کرنا ضروری ہے۔';

  @override
  String get validation_email => 'درست ای میل پتہ درج کریں۔';

  @override
  String get validation_password =>
      'پاس ورڈ بہت مختصر ہے: کم از کم 8 UTF-8 بائٹس درکار ہیں۔';

  @override
  String get validation_passwordTooLong =>
      'پاس ورڈ بہت طویل ہے: زیادہ سے زیادہ 72 UTF-8 بائٹس کی اجازت ہے۔';

  @override
  String get validation_phone =>
      'بین الاقوامی فارمیٹ استعمال کریں، مثلاً +33612345678۔';

  @override
  String get validation_country =>
      'دو حروف پر مشتمل ملکی کوڈ استعمال کریں، مثلاً FR۔';

  @override
  String get passwordReset_title => 'پاس ورڈ دوبارہ ترتیب دیں';

  @override
  String get passwordReset_description =>
      'پاس ورڈ دوبارہ ترتیب دینے کا لنک حاصل کرنے کے لیے اپنے اکاؤنٹ کا ای میل پتہ درج کریں۔';

  @override
  String get passwordReset_send => 'لنک بھیجیں';

  @override
  String get connection_title => 'آپ کا کنکشن';

  @override
  String get connection_subtitle =>
      'ایک مقام منتخب کریں، پھر اپنا VPN آن کریں۔';

  @override
  String get connection_prepare => 'کنیکٹ ہونے کے لیے تیار ہیں؟';

  @override
  String get connection_advancedOptions => 'اعلیٰ ترتیبات';

  @override
  String get connection_location => 'مقام';

  @override
  String get connection_chooseLocation => 'مقام منتخب کریں';

  @override
  String get connection_protocol => 'پروٹوکول';

  @override
  String get connection_connect => 'کنیکٹ کریں';

  @override
  String get connection_connecting => 'کنیکٹ کیا جا رہا ہے…';

  @override
  String get connection_disconnect => 'ڈسکنیکٹ کریں';

  @override
  String get connection_disconnecting => 'ڈسکنیکٹ کیا جا رہا ہے';

  @override
  String get connection_locationChange => 'مقام تبدیل کیا جا رہا ہے…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol دستیاب نہیں ہے';
  }

  @override
  String get connection_activeLocation => 'فعال مقام';

  @override
  String get connection_duration => 'دورانیہ';

  @override
  String get connection_received => 'موصول شدہ';

  @override
  String get connection_sent => 'بھیجا گیا';

  @override
  String get connection_lastHandshake => 'آخری محفوظ تبادلہ';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration پہلے';
  }

  @override
  String get verification_title => 'اپنے ای میل پتے کی تصدیق کریں';

  @override
  String get verification_message =>
      'اس فون پر VPN استعمال کرنے کے لیے اپنے ای میل پتے کی تصدیق کریں۔';

  @override
  String get verification_resend => 'ای میل دوبارہ بھیجیں';

  @override
  String get migration_title => 'مقام کی تبدیلی';

  @override
  String get migration_draining => 'مقام کی تبدیلی تیار کی جا رہی ہے…';

  @override
  String get migration_activating => 'نیا سرور فعال کیا جا رہا ہے…';

  @override
  String get migration_ready => 'مقام اپ ڈیٹ ہو گیا ہے۔';

  @override
  String get migration_blocked =>
      'مقام کی تبدیلی کے لیے سرور کی مداخلت ضروری ہے۔ بعد میں دوبارہ کوشش کریں یا معاونت سے رابطہ کریں۔';

  @override
  String get migration_progress => 'مقام کی تبدیلی کی پیش رفت';

  @override
  String migration_retryDelay(Object seconds) {
    return 'جانچ کے درمیان وقفہ: $seconds سیکنڈ۔';
  }

  @override
  String get migration_resume => 'مقام کی تبدیلی جاری رکھیں';

  @override
  String get status_authorizing => 'اجازت درکار ہے';

  @override
  String get status_authorizingDetail =>
      'VPN کی اجازت دینے کے لیے Android کی درخواست قبول کریں۔';

  @override
  String get status_preparing => 'تیاری جاری ہے';

  @override
  String get status_preparingDetail => 'آپ کا محفوظ کنکشن تیار کیا جا رہا ہے۔';

  @override
  String get status_reconnecting => 'دوبارہ کنیکٹ کیا جا رہا ہے…';

  @override
  String get status_reconnectingDetail =>
      'کنکشن منقطع ہو گیا ہے۔ VPN دوبارہ کنیکٹ ہونے کی کوشش کر رہا ہے۔';

  @override
  String get status_connecting => 'کنیکٹ کیا جا رہا ہے';

  @override
  String get status_connectingDetail => 'VPN سرور سے کنیکٹ کیا جا رہا ہے…';

  @override
  String get status_connected => 'کنیکٹ ہو گیا ہے';

  @override
  String get status_connectedDetail => 'آپ کا VPN کنکشن فعال ہے۔';

  @override
  String get status_disconnecting => 'ڈسکنیکٹ کیا جا رہا ہے';

  @override
  String get status_disconnectingDetail => 'آپ کا VPN کنکشن روکا جا رہا ہے۔';

  @override
  String get status_error => 'کنکشن دستیاب نہیں ہے';

  @override
  String get status_errorDetail =>
      'VPN کنکشن کی تصدیق نہیں ہوئی۔ دوبارہ کوشش کریں۔';

  @override
  String get status_idle => 'ڈسکنیکٹ ہو گیا ہے';

  @override
  String get status_idleDetail =>
      'اپنے کنکشن کو محفوظ رکھنے کے لیے VPN کنیکٹ کریں۔';

  @override
  String get trust_note =>
      'ایپ بند کرنے سے VPN نہیں رکتا۔ اسے روکنے کے لیے ڈسکنیکٹ استعمال کریں۔';

  @override
  String get locations_none => 'فی الحال کوئی مقام دستیاب نہیں ہے۔';

  @override
  String get locations_available => 'اپنا اگلا مقام منتخب کریں۔';

  @override
  String get locations_selected => 'منتخب مقام';

  @override
  String get locations_select => 'یہ مقام منتخب کریں';

  @override
  String get locations_lockedTunnel =>
      'مقام تبدیل کرنے کے لیے VPN ڈسکنیکٹ کریں۔';

  @override
  String get locations_lockedMigration =>
      'مقام کی تبدیلی مکمل ہونے کا انتظار کریں۔';

  @override
  String get devices_title => 'آپ کے آلات';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit آلات';
  }

  @override
  String get devices_refresh => 'آلات تازہ کریں';

  @override
  String get devices_empty => 'ابھی تک کوئی VPN ڈیوائس رجسٹر نہیں ہوئی۔';

  @override
  String get devices_firstConnection =>
      'پہلی بار کنیکٹ ہونے پر آپ کا فون شامل کر دیا جائے گا۔';

  @override
  String get devices_thisDevice => 'یہ ڈیوائس';

  @override
  String devices_added(Object date) {
    return '$date کو شامل کیا گیا';
  }

  @override
  String get action_remove => 'ہٹائیں';

  @override
  String get settings_title => 'ترتیبات';

  @override
  String get settings_subtitle => 'آپ کی ترجیحات اور اکاؤنٹ، سب ایک ہی جگہ۔';

  @override
  String get settings_appearance => 'ظاہری شکل';

  @override
  String get settings_language => 'زبان';

  @override
  String get settings_languageDescription =>
      'آپ کی منتخب زبان VPN کی اطلاعات پر بھی لاگو ہوتی ہے۔';

  @override
  String get settings_account => 'اکاؤنٹ';

  @override
  String get settings_signOut => 'سائن آؤٹ کریں';

  @override
  String get settings_privacy => 'رازداری کی پالیسی';

  @override
  String get settings_terms => 'استعمال کی شرائط';

  @override
  String get settings_security => 'سکیورٹی اور شفافیت';

  @override
  String get settings_licenses => 'اجزا کے لائسنس';

  @override
  String get settings_licensesDetail => 'ایپ میں استعمال ہونے والا سافٹ ویئر';

  @override
  String get settings_background =>
      'ایپ سے باہر جانے پر VPN چلتا رہتا ہے۔ اسے روکنے کے لیے کنکشن ٹیب میں ڈسکنیکٹ استعمال کریں۔';

  @override
  String get theme_system => 'سسٹم کے مطابق';

  @override
  String get theme_light => 'روشن';

  @override
  String get theme_dark => 'تاریک';

  @override
  String get language_system => 'فون کی زبان';

  @override
  String get language_fr => 'فرانسیسی';

  @override
  String get language_en => 'انگریزی';

  @override
  String get language_es => 'ہسپانوی';

  @override
  String get language_de => 'جرمن';

  @override
  String get dialog_removeDevice => 'یہ ڈیوائس ہٹائیں؟';

  @override
  String get dialog_removeCurrent =>
      'یہ فون VPN سے ڈسکنیکٹ ہو جائے گا اور رسائی کھو دے گا۔ سرور کی تصدیق کے بعد اس کا VPN کنکشن ڈیٹا ہٹا دیا جائے گا۔';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” کے لیے VPN رسائی منسوخ کر دی جائے گی۔ اسے واپس نہیں لایا جا سکتا۔';
  }

  @override
  String get dialog_signOut => 'سائن آؤٹ کریں؟';

  @override
  String get dialog_signOutMessage =>
      'VPN رک جائے گا اور آپ کو دوبارہ سائن اِن کرنا ہوگا۔ آپ کی خفیہ کردہ VPN کلیدیں اگلے کنکشن کے لیے اسی فون پر رہیں گی۔';

  @override
  String get action_cancel => 'منسوخ کریں';

  @override
  String get action_signOut => 'سائن آؤٹ کریں';

  @override
  String get notice_close => 'پیغام بند کریں';

  @override
  String get notice_sessionExpired_title => 'سیشن کی میعاد ختم ہو گئی';

  @override
  String get notice_sessionExpired_message =>
      'آپ کے سیشن کی میعاد ختم ہو گئی ہے۔ دوبارہ سائن اِن کریں۔';

  @override
  String get notice_connectionFailed_title => 'کنکشن ناکام ہو گیا';

  @override
  String get notice_invalidCredentials_message =>
      'ای میل پتہ یا پاس ورڈ غلط ہے۔';

  @override
  String get notice_emailVerification_title => 'ای میل کی تصدیق ضروری ہے';

  @override
  String get notice_emailVerification_message =>
      'VPN ڈیوائس شامل کرنے سے پہلے اپنے ای میل پتے کی تصدیق کریں۔';

  @override
  String get notice_rateLimited_title => 'بہت زیادہ کوششیں';

  @override
  String get notice_deviceLimit_title => '2 ڈیوائسز کی حد پوری ہو گئی';

  @override
  String get notice_deviceLimit_message =>
      'دوسری ڈیوائس شامل کرنے سے پہلے کوئی موجودہ ڈیوائس ہٹائیں۔';

  @override
  String get notice_identityRenewal_title => 'VPN شناخت کی تجدید ضروری ہے';

  @override
  String get notice_identityRenewal_message =>
      'یہ شناخت ہٹا دی گئی ہے۔ نئی مقامی شناخت بنائیں۔';

  @override
  String get notice_migrationPending_title => 'مقام کی تبدیلی جاری ہے';

  @override
  String get notice_migrationPending_message =>
      'مقام کی تبدیلی پہلے ہی جاری ہے۔';

  @override
  String get notice_migrationBlocked_title => 'مقام کی تبدیلی روک دی گئی';

  @override
  String get notice_migrationBlocked_message =>
      'مقام کی تبدیلی کے لیے سرور کی مداخلت ضروری ہے۔ بعد میں دوبارہ کوشش کریں یا معاونت سے رابطہ کریں۔';

  @override
  String get notice_targetUnavailable_title =>
      'سرور عارضی طور پر دستیاب نہیں ہے';

  @override
  String get notice_targetUnavailable_message =>
      'یہ سرور عارضی طور پر دستیاب نہیں ہے۔';

  @override
  String get notice_networkUnavailable_title => 'انٹرنیٹ کنکشن دستیاب نہیں ہے';

  @override
  String get notice_networkUnavailable_message =>
      'اپنا کنکشن چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get notice_permissionDenied_title => 'VPN کی اجازت مسترد کر دی گئی';

  @override
  String get notice_permissionDenied_message =>
      'کنکشن دوبارہ شروع کریں اور Android کی اجازت کی درخواست قبول کریں۔';

  @override
  String get notice_wireguardTimeout_title => 'سرور جواب نہیں دے رہا';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard کنکشن میں بہت زیادہ وقت لگ گیا۔ دوبارہ کوشش کریں یا کوئی دوسرا مقام منتخب کریں۔';

  @override
  String get notice_tlsFailed_title => 'محفوظ کنکشن مسترد کر دیا گیا';

  @override
  String get notice_tlsFailed_message =>
      'سرور نے OpenVPN کنکشن قبول نہیں کیا۔ دوبارہ کوشش کریں۔ اگر مسئلہ برقرار رہے تو تشخیصی عمل چلائیں۔';

  @override
  String get notice_tunRejected_title => 'Android نے VPN انٹرفیس مسترد کر دیا';

  @override
  String get notice_tunRejected_message =>
      'Android نے OpenVPN کی درخواست کردہ نیٹ ورک ترتیب مسترد کر دی۔';

  @override
  String get notice_openvpnStart_title => 'OpenVPN شروع نہیں ہو سکا';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN انجن شروع ہونے کا عمل مکمل نہیں کر سکا۔ دوبارہ کوشش کریں۔ اگر مسئلہ برقرار رہے تو معاونت سے رابطہ کریں۔';

  @override
  String notice_diagnosticCode(Object code) {
    return 'تشخیصی کوڈ: $code';
  }

  @override
  String get notice_generic_title => 'VPN کنکشن ناکام ہو گیا';

  @override
  String get notice_generic_message =>
      'ایک خرابی پیش آ گئی۔ بعد میں دوبارہ کوشش کریں۔';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'اکاؤنٹ بن گیا',
      'password_reset_sent':
          'پاس ورڈ دوبارہ ترتیب دینے کی درخواست موصول ہو گئی',
      'verification_email_sent': 'تصدیقی ای میل بھیج دی گئی',
      'location_migration_pending': 'مقام کی تبدیلی جاری ہے',
      'vpn_sign_in_required': 'سائن اِن ضروری ہے',
      'protocol_unavailable_at_location': 'پروٹوکول دستیاب نہیں ہے',
      'vpn_permission_denied': 'VPN کی اجازت مسترد کر دی گئی',
      'revoked_identity_device_limit': '2 ڈیوائسز کی حد پوری ہو گئی',
      'tunnel_start_unexpected': 'VPN شروع نہیں ہو سکا',
      'flutter_disconnect_timeout': 'ڈسکنکشن کی تصدیق نہیں ہوئی',
      'flutter_disconnect_unexpected': 'ڈسکنیکٹ نہیں ہو سکا',
      'device_revoked': 'ڈیوائس ہٹا دی گئی',
      'revoke_unexpected': 'ڈیوائس ہٹائی نہیں جا سکی',
      'identity_renewal_unexpected': 'شناخت کی تجدید نہیں ہو سکی',
      'openvpn_renewal_unexpected': 'OpenVPN کی تجدید نہیں ہو سکی',
      'location_migration_blocked': 'مقام کی تبدیلی روک دی گئی',
      'location_migration_slow': 'مقام کی تبدیلی اب بھی جاری ہے',
      'location_migration_conflict': 'مقام کی تبدیلی کے لیے تازہ کاری ضروری ہے',
      'location_migration_verification_failed':
          'مقام کی تبدیلی کی تصدیق نہیں ہوئی',
      'location_migration_device_changed':
          'مقام کی تبدیلی کے دوران ڈیوائس بدل گئی',
      'tunnel_stop_failed': 'مقام کی تبدیلی دستیاب نہیں ہے',
      'other': 'کارروائی ناکام ہو گئی',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'اکاؤنٹ بن گیا، لیکن تصدیقی ای میل نہیں بھیجی جا سکی۔ ایپ میں دوبارہ بھیجنے کا اختیار استعمال کریں۔',
      'password_reset_sent':
          'آپ کی درخواست موصول ہو گئی۔ اگر اس پتے سے کوئی اکاؤنٹ منسلک ہے تو آپ کو ای میل موصول ہو سکتی ہے۔ اپنا اسپیم فولڈر بھی چیک کریں۔',
      'verification_email_sent': 'نئی تصدیقی ای میل ابھی بھیجی گئی ہے۔',
      'location_migration_pending':
          '$target پر منتقلی ابھی تیار کی جا رہی ہے۔ ڈیوائس دوبارہ بنائے بغیر اسے جاری رکھ سکتے ہیں۔',
      'vpn_sign_in_required':
          'VPN شروع کرنے سے پہلے اپنے اکاؤنٹ میں سائن اِن کریں۔',
      'protocol_unavailable_at_location':
          'منتخب پروٹوکول اس مقام پر پیش نہیں کیا جاتا۔ مقامات تازہ کریں یا کوئی دوسرا پروٹوکول منتخب کریں۔',
      'vpn_permission_denied':
          'Android نے VPN کی اجازت مسترد کر دی۔ کنکشن دوبارہ شروع کریں اور سسٹم کی درخواست قبول کریں۔',
      'revoked_identity_device_limit':
          'اس ڈیوائس کی VPN رسائی ہٹا دی گئی ہے اور ڈیوائس کی حد پوری ہو گئی ہے۔ اکاؤنٹ → میرے آلات کا انتظام کریں میں جا کر کوئی ڈیوائس ہٹائیں۔',
      'tunnel_start_unexpected':
          'ایک غیر متوقع خرابی نے ٹَنل کی تیاری میں خلل ڈالا۔ تشخیصی کوڈ چیک کریں اور دوبارہ کوشش کریں۔',
      'flutter_disconnect_timeout':
          'Android نے بروقت VPN کے رکنے کی تصدیق نہیں کی۔ اسے دوبارہ روکنے کی کوشش کریں۔',
      'flutter_disconnect_unexpected':
          'ایک غیر متوقع خرابی نے ٹَنل کے رکنے کی تصدیق روک دی۔',
      'device_revoked':
          'ڈیوائس کی VPN رسائی منسوخ کر دی گئی اور اس کے مقامی راز ہٹا دیے گئے۔',
      'revoke_unexpected':
          'ڈیوائس ہٹائی نہیں جا سکی۔ فہرست تازہ کریں اور دوبارہ کوشش کریں۔',
      'identity_renewal_unexpected':
          'نئی VPN شناخت نہیں بنائی جا سکی۔ آلات تازہ کریں اور دوبارہ کوشش کریں۔',
      'openvpn_renewal_unexpected':
          'OpenVPN پروفائل کی تجدید نہیں ہو سکی۔ دوبارہ کوشش کریں یا تشخیصی کوڈ چیک کریں۔',
      'location_migration_blocked':
          'سرور اس وقت یہ تبدیلی مکمل نہیں کر سکتا۔ ڈیوائس اور اس کی مقامی شناخت محفوظ رکھی گئی ہے۔',
      'location_migration_slow':
          'سرور اب بھی $target پر منتقلی تیار کر رہا ہے۔ چند لمحوں بعد جاری رکھیں استعمال کریں۔',
      'location_migration_conflict':
          'سرور پر ڈیوائس کی حالت بدل گئی ہے۔ آلات تازہ کریں، پھر تبدیلی جاری رکھیں۔',
      'location_migration_verification_failed':
          'سرور نے نئے مقام کی تصدیق نہیں کی۔ پچھلی مقامی شناخت محفوظ رکھی گئی ہے۔',
      'location_migration_device_changed':
          'سرور کی جانب سے واپس کی گئی ڈیوائس تبدیل کی جانے والی ڈیوائس سے مطابقت نہیں رکھتی۔ دوبارہ کوشش سے پہلے آلات تازہ کریں۔',
      'tunnel_stop_failed':
          'نیا کنکشن شروع کرنے سے پہلے پچھلا ٹَنل مکمل طور پر رکنا ضروری ہے۔',
      'other':
          'کارروائی مکمل نہیں کی جا سکی۔ دوبارہ کوشش کریں یا تشخیصی کوڈ معاونت کو بھیجیں۔',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'سیشن کی میعاد ختم ہو گئی',
      'invalid_credentials': 'سائن اِن ناکام ہو گیا',
      'email_verification_required': 'ای میل کی تصدیق ضروری ہے',
      'verification_email_cooldown': 'ای میل پہلے ہی بھیجی جا چکی ہے',
      'rate_limited': 'بہت زیادہ کوششیں',
      'invalid_registration': 'معلومات درست کرنا ضروری ہے',
      'email_exists': 'اکاؤنٹ پہلے ہی موجود ہے',
      'invalid_profile': 'پروفائل درست نہیں ہے',
      'invalid_device': 'ڈیوائس درست نہیں ہے',
      'invalid_location': 'مقام دستیاب نہیں ہے',
      'device_limit': '2 ڈیوائسز کی حد پوری ہو گئی',
      'device_exists': 'VPN شناخت پہلے ہی استعمال میں ہے',
      'device_identity_revoked': 'VPN شناخت کی تجدید ضروری ہے',
      'device_location_locked': 'مقام کی تبدیلی کے لیے تازہ کاری ضروری ہے',
      'location_migration_pending': 'مقام کی تبدیلی جاری ہے',
      'location_migration_blocked': 'مقام کی تبدیلی روک دی گئی',
      'target_ca_mismatch': 'OpenVPN سرور مطابقت نہیں رکھتا',
      'location_migration_conflict': 'مقام کی تبدیلی کے لیے تازہ کاری ضروری ہے',
      'server_full': 'سرور بھر چکا ہے',
      'capacity_unavailable': 'مقام عارضی طور پر دستیاب نہیں ہے',
      'target_unavailable': 'سرور عارضی طور پر دستیاب نہیں ہے',
      'not_found': 'آئٹم نہیں ملا',
      'invalid_openvpn_csr': 'OpenVPN شناخت درست نہیں ہے',
      'openvpn_profile_exists': 'OpenVPN پروفائل پہلے ہی موجود ہے',
      'openvpn_profile_revoked': 'OpenVPN پروفائل منسوخ کر دیا گیا',
      'openvpn_operation_pending': 'OpenVPN کارروائی جاری ہے',
      'openvpn_operation_terminal': 'OpenVPN کارروائی میں خلل پڑا',
      'openvpn_address_unavailable': 'OpenVPN پتہ دستیاب نہیں ہے',
      'openvpn_profile_conflict': 'OpenVPN تنازع',
      'openvpn_signer_unavailable': 'OpenVPN دستیاب نہیں ہے',
      'email_delivery_unavailable': 'ای میل دستیاب نہیں ہے',
      'invalid_token': 'لنک درست نہیں ہے',
      'network_unavailable': 'انٹرنیٹ کنکشن دستیاب نہیں ہے',
      'invalid_json': 'درخواست درست نہیں ہے',
      'invalid_api_response': 'سرور کا جواب درست نہیں ہے',
      'ipv6_unavailable': 'IPv6 دستیاب نہیں ہے',
      'invalid_ip_families': 'نیٹ ورک کی ترتیب مسترد کر دی گئی',
      'other': 'سروس دستیاب نہیں ہے',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized':
          'آپ کے سیشن کی میعاد ختم ہو گئی ہے۔ دوبارہ سائن اِن کریں۔',
      'invalid_credentials': 'ای میل پتہ یا پاس ورڈ غلط ہے۔',
      'email_verification_required':
          'VPN ڈیوائس شامل کرنے سے پہلے اپنے ای میل پتے کی تصدیق کریں۔',
      'invalid_registration': 'درکار معلومات اور رضامندیوں کو چیک کریں۔',
      'email_exists': 'اس ای میل پتے سے ایک اکاؤنٹ پہلے ہی موجود ہے۔',
      'invalid_profile': 'اپنے پروفائل کی معلومات چیک کریں۔',
      'invalid_device': 'اس ڈیوائس کا نام یا مقامی شناخت درست نہیں ہے۔',
      'invalid_location': 'مقامات کی فہرست تازہ کریں اور دوبارہ کوشش کریں۔',
      'device_limit':
          'دوسری ڈیوائس شامل کرنے سے پہلے کوئی موجودہ ڈیوائس ہٹائیں۔',
      'device_exists': 'یہ VPN شناخت پہلے ہی کسی دوسرے اکاؤنٹ سے منسلک ہے۔',
      'device_identity_revoked':
          'یہ شناخت ہٹا دی گئی ہے۔ نئی مقامی شناخت بنانا ضروری ہے۔',
      'device_location_locked':
          'اس ڈیوائس کا مقام ابھی تبدیل ہوا ہے۔ ایپ جاری تبدیلی کو دوبارہ شروع کر دے گی۔',
      'location_migration_pending': 'مقام کی تبدیلی پہلے ہی جاری ہے۔',
      'location_migration_blocked':
          'مقام کی تبدیلی کے لیے سرور کی مداخلت ضروری ہے۔ بعد میں دوبارہ کوشش کریں یا معاونت سے رابطہ کریں۔',
      'target_ca_mismatch':
          'یہ سرور موجودہ OpenVPN پروفائل کے ساتھ ابھی مطابقت نہیں رکھتا۔',
      'location_migration_conflict':
          'آلات تازہ کریں، پھر مقام کی تبدیلی دوبارہ آزمائیں۔',
      'server_full':
          'اس مقام نے اپنی کنکشن حد پوری کر لی ہے۔ کوئی دوسرا مقام منتخب کریں یا بعد میں دوبارہ کوشش کریں۔',
      'capacity_unavailable':
          'ہم اس وقت تصدیق نہیں کر سکتے کہ یہ مقام دستیاب ہے یا نہیں۔ کوئی دوسرا مقام منتخب کریں یا بعد میں دوبارہ کوشش کریں۔',
      'target_unavailable': 'یہ سرور عارضی طور پر دستیاب نہیں ہے۔',
      'not_found': 'یہ آئٹم اب آپ کے اکاؤنٹ میں دستیاب نہیں ہے۔',
      'invalid_openvpn_csr': 'نئی OpenVPN شناخت بنائیں اور دوبارہ کوشش کریں۔',
      'openvpn_profile_exists':
          'اس ڈیوائس کے لیے OpenVPN پروفائل پہلے ہی موجود ہے۔',
      'openvpn_profile_revoked':
          'جاری رکھنے کے لیے OpenVPN پروفائل کی تجدید کریں۔',
      'openvpn_operation_pending':
          'تبدیلی ابھی پھیل رہی ہے۔ بعد میں دوبارہ کوشش کریں۔',
      'openvpn_operation_terminal':
          'نئی OpenVPN شناخت بنائیں اور دوبارہ کوشش کریں۔',
      'openvpn_address_unavailable':
          'فی الحال کوئی OpenVPN پتہ دستیاب نہیں ہے۔',
      'openvpn_profile_conflict':
          'پروفائل تبدیل ہو گیا ہے۔ آلات تازہ کریں اور دوبارہ کوشش کریں۔',
      'openvpn_signer_unavailable': 'OpenVPN سروس عارضی طور پر دستیاب نہیں ہے۔',
      'email_delivery_unavailable':
          'ای میل نہیں بھیجی جا سکی۔ بعد میں دوبارہ کوشش کریں۔',
      'invalid_token':
          'یہ لنک غلط ہے یا اس کی میعاد ختم ہو گئی ہے۔ نیا لنک طلب کریں۔',
      'network_unavailable':
          'اپنا انٹرنیٹ کنکشن چیک کریں اور دوبارہ کوشش کریں۔',
      'invalid_json': 'درج کی گئی معلومات چیک کریں اور دوبارہ کوشش کریں۔',
      'invalid_api_response':
          'سرور نے غیر متوقع جواب دیا۔ بعد میں دوبارہ کوشش کریں۔',
      'ipv6_unavailable':
          'سرور اس وقت IPv6 فعال نہیں کر سکتا۔ بعد میں دوبارہ کوشش کریں۔',
      'invalid_ip_families':
          'ٹَنل کی ترتیب نامکمل ہے یا مجاز پتوں سے مطابقت نہیں رکھتی۔ ایپ سے دوبارہ کوشش کریں۔',
      'other': 'سرور میں خرابی پیش آ گئی۔ بعد میں دوبارہ کوشش کریں۔',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'چند لمحوں بعد دوبارہ کوشش کریں۔';

  @override
  String notice_retryAfter(Object seconds) {
    return '$seconds سیکنڈ بعد دوبارہ کوشش کریں۔';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'سسٹم VPN دوبارہ شروع کرنا دستیاب نہیں ہے',
      'system_vpn_resume_corrupt': 'سسٹم VPN دوبارہ شروع کرنے کا ڈیٹا غلط ہے',
      'system_vpn_resume_session_invalid':
          'VPN دوبارہ شروع کرنے کا سیشن غلط ہے',
      'system_vpn_resume_identity_changed': 'VPN شناخت تبدیل ہو گئی',
      'system_vpn_resume_identity_invalid':
          'VPN دوبارہ شروع کرنے کی شناخت غلط ہے',
      'system_vpn_resume_storage_failed':
          'VPN دوبارہ شروع کرنے کا ذخیرہ دستیاب نہیں ہے',
      'system_vpn_resume_network_timeout':
          'VPN دوبارہ شروع کرنے کے لیے نیٹ ورک موجود نہیں ہے',
      'system_vpn_resume_blocked': 'VPN دوبارہ شروع کرنا روک دیا گیا',
      'system_vpn_resume_failed': 'VPN دوبارہ شروع نہیں ہو سکا',
      'system_vpn_resume_error_invalid': 'VPN دوبارہ شروع کرنے کی خرابی غلط ہے',
      'wireguard_identity_store_failed': 'WireGuard شناخت محفوظ نہیں ہوئی',
      'wireguard_identity_unavailable': 'WireGuard شناخت دستیاب نہیں ہے',
      'vpn_host_destroyed': 'Android VPN میزبان رک گیا',
      'vpn_host_unavailable': 'Android VPN میزبان دستیاب نہیں ہے',
      'vpn_permission_required': 'VPN کی اجازت ضروری ہے',
      'vpn_permission_denied': 'VPN کی اجازت مسترد کر دی گئی',
      'vpn_permission_request_failed': 'اجازت طلب نہیں کی جا سکی',
      'wireguard_foreground_service_unavailable':
          'WireGuard سروس دستیاب نہیں ہے',
      'wireguard_identity_invalid': 'مقامی WireGuard کلید غلط ہے',
      'wireguard_identity_in_use': 'WireGuard شناخت پہلے ہی استعمال میں ہے',
      'wireguard_configuration_invalid': 'WireGuard کی ترتیب غلط ہے',
      'wireguard_operation_pending': 'WireGuard کارروائی اب بھی فعال ہے',
      'wireguard_start_failed': 'WireGuard شروع کرنا مسترد کر دیا گیا',
      'wireguard_stop_timeout': 'WireGuard کے رکنے کی تصدیق نہیں ہوئی',
      'wireguard_handshake_timeout': 'WireGuard نے جواب نہیں دیا',
      'openvpn_connection_timeout': 'OpenVPN نے جواب نہیں دیا',
      'openvpn_core_unavailable': 'OpenVPN انجن دستیاب نہیں ہے',
      'openvpn_operation_pending': 'OpenVPN سیشن اب بھی فعال ہے',
      'openvpn_stop_timeout': 'OpenVPN کے رکنے کی تصدیق نہیں ہوئی',
      'openvpn_profile_unavailable': 'مقامی OpenVPN پروفائل موجود نہیں ہے',
      'openvpn_native_failed': 'مقامی OpenVPN کال میں خلل پڑا',
      'openvpn_key_generation_failed': 'OpenVPN P-256 کلید نہیں بنائی جا سکی',
      'openvpn_csr_generation_failed': 'OpenVPN CSR نہیں بنایا جا سکا',
      'openvpn_identity_store_failed': 'OpenVPN شناخت محفوظ نہیں ہوئی',
      'openvpn_identity_clear_failed':
          'OpenVPN کو مکمل طور پر ہٹایا نہیں جا سکا',
      'openvpn_identity_in_use': 'OpenVPN شناخت اب بھی استعمال میں ہے',
      'openvpn_tls_verification_required': 'OpenVPN TLS تصدیق موجود نہیں ہے',
      'openvpn_cipher_invalid': 'OpenVPN سائفر غلط ہے',
      'openvpn_profile_rejected': 'OpenVPN پروفائل مسترد کر دیا گیا',
      'openvpn_identity_inconsistent': 'OpenVPN شناخت میں تضاد ہے',
      'tls_handshake_failed': 'OpenVPN مذاکرات مسترد کر دیے گئے',
      'tls_alert_unknown_ca': 'OpenVPN کلائنٹ سرٹیفکیٹ پہچانا نہیں گیا',
      'tls_alert_bad_certificate': 'OpenVPN کلائنٹ سرٹیفکیٹ مسترد کر دیا گیا',
      'tls_alert_unsupported_certificate':
          'OpenVPN سرٹیفکیٹ معاونت یافتہ نہیں ہے',
      'tls_client_certificate_required': 'OpenVPN کلائنٹ سرٹیفکیٹ ضروری ہے',
      'tls_alert_misc': 'OpenVPN TLS انتباہ',
      'tls_signature_algorithm_rejected': 'OpenVPN دستخط معاونت یافتہ نہیں ہیں',
      'tls_handshake_rejected': 'OpenVPN TLS مذاکرات مسترد کر دیے گئے',
      'tls_version_rejected': 'OpenVPN TLS ورژن مطابقت نہیں رکھتا',
      'tls_certificate_expired': 'TLS سرٹیفکیٹ کی میعاد ختم ہو گئی',
      'tls_certificate_revoked': 'TLS سرٹیفکیٹ منسوخ کر دیا گیا',
      'transport_failed': 'OpenVPN سرور تک رسائی نہیں ہو سکی',
      'tun_configuration_rejected': 'OpenVPN انٹرفیس نہیں بنایا جا سکا',
      'tun_setup_failed': 'OpenVPN TUN ترتیب ناکام ہو گئی',
      'tun_interface_create_failed': 'OpenVPN انٹرفیس نہیں بنایا جا سکا',
      'tun_interface_disabled': 'OpenVPN انٹرفیس غیر فعال ہے',
      'tun_halted': 'OpenVPN انٹرفیس میں خلل پڑا',
      'tun_already_established': 'OpenVPN انٹرفیس پہلے ہی کھلا ہے',
      'tun_addresses_missing': 'OpenVPN پتہ موجود نہیں ہے',
      'tun_routes_missing': 'OpenVPN راستے موجود نہیں ہیں',
      'tun_dns_missing': 'OpenVPN DNS موجود نہیں ہے',
      'tun_permission_revoked': 'VPN کی اجازت منسوخ کر دی گئی',
      'tun_establish_returned_null': 'Android نے VPN انٹرفیس مسترد کر دیا',
      'openvpn_service_start_failed': 'OpenVPN سروس دستیاب نہیں ہے',
      'openvpn_operation_timeout': 'OpenVPN کال کا وقت ختم ہو گیا',
      'openvpn_start_failed': 'OpenVPN شروع کرنا مسترد کر دیا گیا',
      'openvpn_connection_failed': 'OpenVPN کنکشن میں خلل پڑا',
      'openvpn_core_status_error': 'OpenVPN Core خرابی کے ساتھ ختم ہوا',
      'openvpn_stopped_before_connected': 'OpenVPN کنیکٹ ہونے سے پہلے رک گیا',
      'openvpn_auth_failed': 'OpenVPN تصدیق مسترد کر دی گئی',
      'openvpn_client_setup_failed': 'OpenVPN کلائنٹ ترتیب ناکام ہو گئی',
      'openvpn_client_halted': 'OpenVPN کلائنٹ میں خلل پڑا',
      'openvpn_client_restart': 'OpenVPN دوبارہ شروع کرنے کی درخواست کی گئی',
      'openvpn_inactive_timeout': 'OpenVPN بہت دیر تک غیر فعال رہا',
      'openvpn_session_expired': 'OpenVPN سیشن کی میعاد ختم ہو گئی',
      'openvpn_credentials_required': 'OpenVPN تصدیق معاونت یافتہ نہیں ہے',
      'openvpn_proxy_failed': 'OpenVPN درمیانی ترسیل ناکام ہو گئی',
      'openvpn_compression_failed': 'OpenVPN کمپریشن مسترد کر دی گئی',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM خفیہ کاری دستیاب نہیں ہے',
      'openvpn_feature_unsupported': 'OpenVPN خصوصیت معاونت یافتہ نہیں ہے',
      'network_unavailable': 'انٹرنیٹ کنکشن دستیاب نہیں ہے',
      'network_lost': 'نیٹ ورک دستیاب نہیں ہے',
      'certificate_validation_failed': 'سرور سرٹیفکیٹ مسترد کر دیا گیا',
      'openvpn_certificate_expired': 'OpenVPN سرٹیفکیٹ کی میعاد ختم ہو گئی',
      'tunnel_active_for_another_account':
          'دوسرے اکاؤنٹ کا ٹَنل اب بھی فعال ہے',
      'tunnel_already_active': 'مقامی ٹَنل پہلے ہی فعال ہے',
      'tunnel_stop_timeout': '$protocol کے رکنے کی تصدیق نہیں ہوئی',
      'tunnel_disconnected': '$protocol میں خلل پڑا',
      'native_bridge_unavailable': 'Android برج دستیاب نہیں ہے',
      'native_operation_failed': 'Android کارروائی میں خلل پڑا',
      'invalid_arguments': 'VPN پیرامیٹرز نامکمل ہیں',
      'invalid_account_id': 'VPN اکاؤنٹ درست نہیں ہے',
      'invalid_device_id': 'ڈیوائس شناخت کنندہ درست نہیں ہے',
      'storage_key_not_allowed': 'ذخیرے کی کلید مسترد کر دی گئی',
      'secure_storage_read_failed': 'محفوظ پڑھائی ناکام ہو گئی',
      'secure_storage_write_failed': 'محفوظ تحریر ناکام ہو گئی',
      'key_generation_failed': 'WireGuard کلید نہیں بنائی جا سکی',
      'csr_generation_failed': 'OpenVPN CSR نہیں بنایا جا سکا',
      'other': 'غیر درجہ بند مقامی VPN خرابی',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android کو دوبارہ شروع کیے جانے کے قابل VPN سیشن نہیں مل سکا۔ ایپ میں نیا کنکشن شروع کریں۔',
      'system_vpn_resume_corrupt':
          'محفوظ VPN دوبارہ شروع کرنے کا ڈیٹا غلط ہے اور استعمال نہیں ہوگا۔ نیا کنکشن شروع کریں۔',
      'system_vpn_resume_session_invalid':
          'محفوظ سیشن اب VPN دوبارہ شروع نہیں کر سکتا۔ ایپ میں دوبارہ سائن اِن کریں۔',
      'system_vpn_resume_identity_changed':
          'مقامی VPN شناخت بدل گئی ہے۔ دوبارہ شروع کرنا روک دیا گیا؛ نیا کنکشن شروع کریں۔',
      'system_vpn_resume_identity_invalid':
          'دوبارہ شروع کرنے کی شناخت غلط ہے۔ نیا کنکشن شروع کریں۔',
      'system_vpn_resume_storage_failed':
          'Android خفیہ کردہ دوبارہ شروع کرنے کا ڈیٹا پڑھ یا اپ ڈیٹ نہیں کر سکا۔ نیا کنکشن شروع کریں۔',
      'system_vpn_resume_network_timeout':
          'Android کو VPN دوبارہ شروع کرنے کے لیے وقت پر نیٹ ورک نہیں ملا۔ نیٹ ورک دستیاب ہونے پر دوبارہ کوشش کریں۔',
      'system_vpn_resume_blocked':
          'VPN دوبارہ شروع کرنا بلاک ہے۔ Android کی ترتیبات چیک کریں، پھر نیا کنکشن شروع کریں۔',
      'system_vpn_resume_failed':
          'Android VPN دوبارہ شروع نہیں ہو سکا۔ ایپ میں نیا کنکشن شروع کریں۔',
      'system_vpn_resume_error_invalid':
          'Android نے ناقابل استعمال دوبارہ شروع کرنے کی خرابی لوٹائی۔ نیا کنکشن شروع کریں۔',
      'wireguard_identity_store_failed':
          'Android اس اکاؤنٹ کی خفیہ کردہ WireGuard شناخت محفوظ نہیں کر سکا۔',
      'wireguard_identity_unavailable':
          'اس کنکشن کے لیے کوئی قابل استعمال WireGuard شناخت دستیاب نہیں ہے۔',
      'vpn_host_destroyed':
          'VPN کی میزبانی کرنے والا Android جزو روک دیا گیا۔ نیا کنکشن شروع کریں۔',
      'vpn_host_unavailable':
          'Android VPN کی میزبانی کرنے والا جزو نہیں بنا سکتا۔ VPN ترتیبات چیک کرنے کے بعد دوبارہ کوشش کریں۔',
      'openvpn_renewal_required':
          'کنیکٹ کرنے سے پہلے سرٹیفکیٹ کے لیے ایپ میں کارروائی ضروری ہے۔',
      'openvpn_recovery_failed':
          'خودکار بحالی ناکام ہو گئی۔ ایپ میں نیا کنکشن شروع کریں۔',
      'openvpn_recovery_exhausted':
          'خودکار بحالی پہلے ہی استعمال ہو چکی ہے۔ ایپ میں نیا کنکشن شروع کریں۔',
      'vpn_permission_required':
          'ٹَنل شروع کرنے سے پہلے Android کو VPN کی نئی اجازت درکار ہے۔',
      'vpn_permission_denied':
          'جاری رکھنے کے لیے Android کی درخواست میں FuzeVPN کی اجازت دیں۔',
      'vpn_permission_request_failed':
          'Android VPN کی اجازت والی اسکرین نہیں کھول سکا۔',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard سروس کو پیش منظر میں برقرار نہیں رکھ سکا۔',
      'wireguard_identity_invalid':
          'اس اکاؤنٹ کی خفیہ کردہ WireGuard کلید پڑھی نہیں جا سکتی یا غلط ہے۔',
      'wireguard_identity_in_use':
          'ایک اور کارروائی اب بھی اس اکاؤنٹ کی WireGuard کلید استعمال کر رہی ہے۔',
      'wireguard_configuration_invalid':
          'موصول شدہ WireGuard پتہ، DNS، سرور کلید یا راستے غلط ہیں۔',
      'wireguard_operation_pending':
          'پچھلی WireGuard کارروائی نے ابھی مقامی سروس جاری نہیں کی۔',
      'wireguard_start_failed':
          'WireGuard انجن نے ترتیب فعال کرنا مسترد کر دیا۔',
      'wireguard_stop_timeout':
          'WireGuard سروس نے مقررہ وقت میں VPN انٹرفیس جاری کرنے کی تصدیق نہیں کی۔',
      'wireguard_handshake_timeout':
          'ٹَنل نے وقت پر سرور کے ساتھ مصافحے کی تصدیق نہیں کی۔',
      'openvpn_connection_timeout':
          'OpenVPN نے وقت پر سرور سے کنکشن کی تصدیق نہیں کی۔',
      'openvpn_core_unavailable':
          'اس ایپ ورژن میں قابل استعمال OpenVPN انجن شامل نہیں ہے۔',
      'openvpn_operation_pending':
          'مقامی انجن اب بھی پچھلا OpenVPN سیشن رکھے ہوئے ہے اور دوسرا بنانے سے انکار کر رہا ہے۔',
      'openvpn_stop_timeout':
          'OpenVPN Core نے مقررہ وقت میں اپنے مقامی سیشن کے رکنے اور ختم ہونے کی تصدیق نہیں کی۔',
      'openvpn_profile_unavailable':
          'اس کنکشن کے لیے کوئی تصدیق شدہ OpenVPN پروفائل پڑھا نہیں جا سکتا۔',
      'openvpn_native_failed':
          'ایپ کی خرابی نے OpenVPN میں خلل ڈالا۔ دوبارہ کنیکٹ کریں۔ مسئلہ برقرار رہے تو تشخیص چلائیں۔',
      'openvpn_key_generation_failed':
          'Android Keystore ناقابل برآمد P-256 نجی کلید بنا یا پڑھ نہیں سکا۔',
      'openvpn_csr_generation_failed':
          'Android Keystore کلید OpenVPN سرٹیفکیٹ درخواست پر دستخط نہیں کر سکی۔',
      'openvpn_identity_store_failed':
          'OpenVPN سرٹیفکیٹ یا پروفائل خفیہ کردہ ذخیرے میں محفوظ نہیں ہو سکا۔',
      'openvpn_identity_clear_failed':
          'Android اس اکاؤنٹ کی پوری مقامی OpenVPN شناخت نہیں ہٹا سکا۔',
      'openvpn_identity_in_use':
          'مقامی OpenVPN سیشن اب بھی اس ڈیوائس کی کلید یا سرٹیفکیٹ استعمال کر رہا ہے۔',
      'openvpn_tls_verification_required':
          'پروفائل میں سرور سرٹیفکیٹ کی تصدیق واضح طور پر ضروری نہیں کی گئی۔',
      'openvpn_cipher_invalid':
          'سرور نے ایسی خفیہ کاری الگورتھم دی جو مجاز فہرست میں نہیں ہے۔',
      'openvpn_profile_rejected':
          'سرور سے موصول پروفائل مطابقت نہیں رکھتا۔ اس ڈیوائس کو دوبارہ بنائیں اور کوشش کریں۔',
      'openvpn_identity_inconsistent':
          'سرٹیفکیٹ اس فون کی محفوظ شناخت سے مطابقت نہیں رکھتا۔ کوئی مقامی پروفائل تبدیل نہیں کیا گیا۔',
      'tls_handshake_failed':
          'سرور نے TLS مذاکرات مسترد کر دیے۔ مسئلہ برقرار رہے تو پروفائل دوبارہ بنائیں۔',
      'tls_alert_unknown_ca':
          'سرور اس ڈیوائس سرٹیفکیٹ کے اختیار کو نہیں پہچانتا۔ OpenVPN سرور چیک کرنا ضروری ہے۔',
      'tls_alert_bad_certificate':
          'سرور نے یہ ڈیوائس سرٹیفکیٹ مسترد کر دیا۔ دوبارہ کوشش سے پہلے ڈیوائس بنائیں۔',
      'tls_alert_unsupported_certificate':
          'سرور Android کے استعمال کردہ محفوظ سرٹیفکیٹ کی قسم کو معاونت نہیں دیتا۔',
      'tls_client_certificate_required':
          'سرور کو کلائنٹ سرٹیفکیٹ درکار ہے، لیکن OpenVPN Core اسے پیش نہیں کر سکا۔',
      'tls_alert_misc':
          'سرور نے سرٹیفکیٹ اور ورژن کے زمروں سے باہر TLS انتباہ لوٹایا۔',
      'tls_signature_algorithm_rejected':
          'سرور نے Android Keystore کلید کا ECDSA P-256 الگورتھم مسترد کر دیا۔',
      'tls_handshake_rejected': 'سرور نے کنکشن سے پہلے TLS مذاکرات روک دیے۔',
      'tls_version_rejected': 'کلائنٹ اور سرور کو مشترک TLS ورژن نہیں ملا۔',
      'tls_certificate_expired':
          'کنکشن کے دوران پیش کیا گیا سرٹیفکیٹ میعاد ختم ہو چکا ہے۔',
      'tls_certificate_revoked':
          'کنکشن کے دوران پیش کیا گیا سرٹیفکیٹ منسوخ ہو چکا ہے۔',
      'transport_failed':
          'موجودہ نیٹ ورک پر OpenVPN سرور جواب نہیں دے رہا۔ کچھ دیر بعد دوبارہ کوشش کریں۔',
      'tun_configuration_rejected':
          'Android نے OpenVPN کی درخواست کردہ نیٹ ورک ترتیب مسترد کر دی۔',
      'tun_setup_failed':
          'Android انٹرفیس بنانے سے پہلے OpenVPN Core نے نیٹ ورک منصوبہ مسترد کر دیا۔',
      'tun_interface_create_failed':
          'OpenVPN Core Android VpnService سے TUN انٹرفیس حاصل نہیں کر سکا۔',
      'tun_interface_disabled':
          'کنکشن کے دوران Android یا OpenVPN Core نے TUN انٹرفیس غیر فعال کر دیا۔',
      'tun_halted': 'OpenVPN Core کو TUN انٹرفیس روکنے کی درخواست موصول ہوئی۔',
      'tun_already_established':
          'OpenVPN نے اسی کنکشن میں دوسرا انٹرفیس طلب کیا۔ حفاظت کے لیے ٹَنل روک دیا گیا۔',
      'tun_addresses_missing': 'سرور نے قابل استعمال ٹَنل پتہ فراہم نہیں کیا۔',
      'tun_routes_missing': 'سرور نے قابل استعمال ٹَنل راستے فراہم نہیں کیے۔',
      'tun_dns_missing': 'سرور نے قابل استعمال DNS سرور فراہم نہیں کیا۔',
      'tun_permission_revoked':
          'کنکشن کے دوران Android نے VPN کی اجازت منسوخ کر دی۔',
      'tun_establish_returned_null':
          'Android نے انٹرفیس نہیں بنایا، عموماً اس لیے کہ کوئی دوسرا VPN اب بھی فعال ہے۔',
      'openvpn_service_start_failed':
          'Android OpenVPN پیش منظر سروس شروع نہیں کر سکا۔',
      'openvpn_operation_timeout':
          'OpenVPN Core کو کی گئی JNI کال زیادہ سے زیادہ وقت سے تجاوز کر گئی۔',
      'openvpn_start_failed':
          'Android سروس تیار ہے، لیکن OpenVPN Core نے پروفائل شروع کرنا قبول نہیں کیا۔',
      'openvpn_connection_failed':
          'CONNECTED واقعہ جاری کرنے سے پہلے OpenVPN Core رک گیا۔',
      'openvpn_core_status_error':
          'مقامی OpenVPN لوپ خرابی کے ساتھ ختم ہوا اور کوئی زیادہ مخصوص اختتامی واقعہ نہیں ملا۔',
      'openvpn_stopped_before_connected':
          'CONNECTED سے پہلے مقامی OpenVPN لوپ رک گیا، جبکہ Core کی کوئی واضح خرابی نہیں تھی۔',
      'openvpn_auth_failed': 'OpenVPN سرور نے پروفائل کی تصدیق مسترد کر دی۔',
      'openvpn_client_setup_failed':
          'OpenVPN Core نیٹ ورک کنکشن سے پہلے کلائنٹ شروع نہیں کر سکا۔',
      'openvpn_client_halted':
          'OpenVPN Core کو کلائنٹ روکنے کا اختتامی حکم موصول ہوا۔',
      'openvpn_client_restart':
          'OpenVPN Core نے اپنی ترسیلی نشست دوبارہ شروع کرنے کی درخواست کی۔',
      'openvpn_inactive_timeout':
          'غیر فعالی کا وقت ختم ہونے کے بعد OpenVPN Core نے سیشن بند کر دیا۔',
      'openvpn_session_expired':
          'سرور نے بتایا کہ OpenVPN سیشن کی میعاد ختم ہو گئی ہے۔',
      'openvpn_credentials_required':
          'سرور یا پراکسی ایسی انٹرایکٹو اسناد طلب کرتی ہے جو اس سرٹیفکیٹ پروفائل کا حصہ نہیں ہیں۔',
      'openvpn_proxy_failed':
          'OpenVPN Core نے ترتیب شدہ پراکسی یا ریلے کی خرابی کی اطلاع دی۔',
      'openvpn_compression_failed':
          'OpenVPN Core نے پروفائل یا سرور کی اعلان کردہ کمپریشن قسم مسترد کر دی۔',
      'openvpn_ntlm_crypto_unavailable':
          'پروفائل NTLM خفیہ کاری طلب کرتا ہے جو اس ورژن میں دستیاب نہیں ہے۔',
      'openvpn_feature_unsupported':
          'پروفائل یا سرور کو ایسی خصوصیت درکار ہے جو اس Android کلائنٹ میں موجود نہیں۔',
      'network_unavailable': 'کوئی قابل استعمال طبعی نیٹ ورک دستیاب نہیں ہے۔',
      'network_lost': 'نیٹ ورک ختم ہونے کے بعد ٹَنل روک دیا گیا۔',
      'certificate_validation_failed':
          'OpenVPN سرور کی شناخت کی تصدیق نہیں ہو سکی۔',
      'openvpn_certificate_expired':
          'دوبارہ کنیکٹ کرنے سے پہلے OpenVPN پروفائل کی تجدید کریں۔',
      'tunnel_active_for_another_account':
          'اس کنکشن سے پہلے دوسرے اکاؤنٹ سے متعلق ٹَنل رکنا ضروری ہے۔',
      'tunnel_already_active':
          'Android کے مطابق پچھلا VPN سیشن اب بھی انٹرفیس استعمال کر رہا ہے۔',
      'tunnel_stop_timeout':
          '$protocol انجن نے مقررہ وقت میں VPN انٹرفیس جاری کرنے کی تصدیق نہیں کی۔',
      'tunnel_disconnected':
          'مقامی انجن نے بتایا کہ شروع ہونے کے بعد ٹَنل غیر متوقع طور پر ختم ہو گیا۔',
      'native_bridge_unavailable':
          'ایپ Android VPN سروس تک رسائی نہیں کر سکتی۔ ایپ بند کر کے دوبارہ کھولیں، پھر کوشش کریں۔',
      'native_operation_failed':
          'ایپ کی خرابی نے VPN کارروائی میں خلل ڈالا۔ دوبارہ کوشش کریں۔ مسئلہ برقرار رہے تو تشخیص چلائیں۔',
      'invalid_arguments':
          'اس VPN کارروائی کے لیے درکار معلومات نامکمل ہیں۔ دوبارہ کوشش کریں۔ مسئلہ برقرار رہے تو تشخیص چلائیں۔',
      'invalid_account_id':
          'مقامی کارروائی درست اکاؤنٹ شناخت کنندہ سے منسلک نہیں ہے۔',
      'invalid_device_id':
          'مقامی انجن کو بھیجا گیا ڈیوائس شناخت کنندہ غائب یا غلط ہے۔',
      'storage_key_not_allowed':
          'Android برج نے مجاز فہرست سے باہر کی کلید روک دی۔',
      'secure_storage_read_failed':
          'Android Keystore اس اکاؤنٹ کا مقامی ڈیٹا decrypt نہیں کر سکا۔',
      'secure_storage_write_failed':
          'Android Keystore مقامی ڈیٹا encrypt یا محفوظ نہیں کر سکا۔',
      'key_generation_failed':
          'Android محفوظ ذخیرے میں WireGuard کلید بنا یا پڑھ نہیں سکا۔',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR بنا یا اس پر دستخط نہیں کر سکا۔',
      'other':
          'ایک غیر دستاویزی مقامی شاخ ناکام ہو گئی۔ نیچے دکھایا گیا تشخیصی کوڈ معاونت کو بھیجیں۔',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'اجازت کی درخواست پہلے ہی کھلی ہے';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN کی اجازت کی درخواست پہلے ہی دکھائی جا رہی ہے۔ دوبارہ کوشش کرنے سے پہلے اسے مکمل کریں۔';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN کی اجازت کی درخواست میں خلل پڑا';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ایپ کو جواب موصول ہونے سے پہلے VPN کی اجازت والی اسکرین بند ہو گئی۔';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN کنکشن کی تصدیق نہیں ہوئی';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN کنکشن کی تصدیق نہیں ہو سکی۔ حفاظت کے لیے اسے روک دیا گیا ہے۔ دوبارہ کوشش کریں۔';

  @override
  String get openvpnCleanup_title => 'OpenVPN پروفائل منسوخ کر دیا گیا';

  @override
  String get openvpnCleanup_working =>
      'منسوخ شدہ OpenVPN پروفائل روکا اور ہٹایا جا رہا ہے…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN کے بند ہونے کی تصدیق نہیں ہوئی۔ نیا پروفائل بنانے سے پہلے دوبارہ کوشش کریں۔';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'منسوخ شدہ OpenVPN پروفائل مکمل طور پر ہٹایا نہیں جا سکا۔ صفائی کے لیے دوبارہ کوشش کریں۔';

  @override
  String get openvpnCleanup_complete =>
      'منسوخ شدہ OpenVPN پروفائل ہٹا دیا گیا ہے۔ نیا پروفائل بنانے کے لیے کنیکٹ پر ٹیپ کریں۔';

  @override
  String get network_title => 'نیٹ ورک کی ترتیب';

  @override
  String get network_ipv4Fallback =>
      'IPv6 عارضی طور پر دستیاب نہیں ہے۔ IPv4 کے ساتھ تیاری جاری ہے۔';

  @override
  String get network_rejectedTitle => 'نیٹ ورک کی ترتیب مسترد کر دی گئی';

  @override
  String get network_rejectedMessage =>
      'ٹَنل کی ترتیب نامکمل ہے یا مجاز پتوں سے مطابقت نہیں رکھتی۔ ایپ سے دوبارہ کوشش کریں۔';

  @override
  String get network_unreadableTitle => 'مقامی ترتیب پڑھی نہیں جا سکتی';

  @override
  String get network_unreadableMessage =>
      'محفوظ شدہ OpenVPN نیٹ ورک ترتیب استعمال نہیں کی جا سکتی۔ اسے اپ ڈیٹ کرنے کے لیے ایپ سے دوبارہ کنیکٹ کریں۔';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'نیٹ ورک کا تحفظ';

  @override
  String get protection_subtitle =>
      'VPN ڈسکنیکٹ ہونے پر براہِ راست انٹرنیٹ رسائی روکیں۔';

  @override
  String get protection_active => 'سسٹم کا تحفظ فعال ہے';

  @override
  String get protection_alwaysOnOnly =>
      'ہمیشہ فعال VPN جاری ہے؛ VPN سے باہر بلاکنگ آن کریں';

  @override
  String get protection_inactive => 'سسٹم کا تحفظ غیر فعال ہے';

  @override
  String get protection_unknown => 'سسٹم کا تحفظ چیک کریں';

  @override
  String get protection_openSettings => 'Android کی ترتیبات کھولیں';

  @override
  String get protection_dialogTitle => 'نیٹ ورک کا تحفظ ترتیب دیں';

  @override
  String get protection_dialogMessage =>
      'Android ہمیشہ فعال VPN اور VPN سے باہر کنکشنز کی بلاکنگ کا انتظام کرتا ہے۔ چیک کریں کہ FuzeVPN منتخب ہے اور سسٹم کی ترتیبات میں بلاکنگ فعال کریں۔';

  @override
  String get protection_dialogOpen => 'ترتیبات کھولیں';

  @override
  String get session_systemProtectionNote =>
      'اگر Android اب بھی VPN سے باہر ٹریفک روک رہا ہے تو اس تحفظ کو چیک یا تبدیل کرنے کے لیے سسٹم کی ترتیبات کھولیں۔';

  @override
  String get diagnostics_title => 'تشخیص';

  @override
  String get diagnostics_settingsTitle => 'ایپ کی تشخیص';

  @override
  String get diagnostics_automaticTitle => 'اہم خرابیوں کی اطلاع بھیجیں';

  @override
  String get diagnostics_automaticDescription =>
      'اہم خرابی پیش آنے پر مختصر تکنیکی رپورٹ شیئر کریں۔';

  @override
  String get diagnostics_privacy =>
      'بھیجی گئی رپورٹس سائن اِن شدہ اکاؤنٹ سے منسلک ہوتی ہیں اور 30 دن تک محفوظ رہتی ہیں۔ ان میں براؤزنگ ہسٹری، پاس ورڈ یا VPN کلیدیں شامل نہیں ہوتیں۔';

  @override
  String get diagnostics_manualOpen => 'تشخیص چلائیں';

  @override
  String get diagnostics_localDescription =>
      'ایپ اور VPN کی حالت کی رپورٹ بنائیں۔ آپ کا کنکشن تبدیل نہیں ہوگا۔';

  @override
  String get diagnostics_sendReport => 'رپورٹ بھیجیں';

  @override
  String get diagnostics_sendHint =>
      'رپورٹ اسی ڈیوائس پر رکھنے کے لیے اس خانے کو غیر منتخب چھوڑ دیں۔';

  @override
  String get diagnostics_signedOut =>
      'رپورٹ بھیجنے کے لیے اپنے اکاؤنٹ میں سائن اِن کریں۔';

  @override
  String get diagnostics_localLifetime =>
      'ایپ بند کرنے کے بعد بھی رپورٹ رکھنے کے لیے اسے اپنے فون پر محفوظ کریں۔';

  @override
  String get diagnostics_run => 'تشخیص چلائیں';

  @override
  String get diagnostics_rerun => 'تشخیص دوبارہ چلائیں';

  @override
  String get diagnostics_running => 'جانچ جاری ہے…';

  @override
  String get diagnostics_sending => 'رپورٹ بھیجی جا رہی ہے…';

  @override
  String get diagnostics_prepared => 'رپورٹ اس ڈیوائس پر تیار ہے';

  @override
  String get diagnostics_queued => 'رپورٹ بھیجے جانے کے انتظار میں ہے';

  @override
  String get diagnostics_sent => 'رپورٹ موصول ہو گئی';

  @override
  String get diagnostics_failed =>
      'بھیجنا ناکام ہو گیا۔ آپ کی مقامی رپورٹ اب بھی دستیاب ہے۔';

  @override
  String get diagnostics_preparationFailed =>
      'تشخیصی رپورٹ تیار نہیں کی جا سکی۔ دوبارہ کوشش کریں۔';

  @override
  String get diagnostics_authenticationRequired =>
      'رپورٹ بھیجنے کے لیے دوبارہ سائن اِن کریں۔';

  @override
  String get diagnostics_retry => 'بھیجنے کے لیے دوبارہ کوشش کریں';

  @override
  String get diagnostics_export => 'رپورٹ محفوظ کریں';

  @override
  String get diagnostics_exportFailed =>
      'برآمد ناکام ہو گئی۔ مقامی رپورٹ سے دوبارہ کوشش کریں۔';

  @override
  String get diagnostics_preferenceFailed =>
      'یہ ترتیب محفوظ نہیں کی جا سکی۔ دوبارہ کوشش کریں۔';

  @override
  String diagnostics_receipt(Object id) {
    return 'حوالہ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date کو موصول ہوئی';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date تک محفوظ رہے گی';
  }

  @override
  String get diagnostics_duplicate => 'یہ رپورٹ پہلے ہی موصول ہو چکی تھی۔';

  @override
  String get diagnostics_preview => 'رپورٹ کا پیش منظر';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تکنیکی واقعات منسلک ہیں',
      one: '1 تکنیکی واقعہ منسلک ہے',
      zero: 'کوئی تکنیکی واقعہ منسلک نہیں',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'تکنیکی تفصیلات';

  @override
  String get diagnostics_empty => 'ابھی تک کوئی تشخیصی رپورٹ تیار نہیں کی گئی۔';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ٹَنل کی حالت',
      'handshake': 'کنکشن کی تصدیق',
      'certificate': 'VPN سرٹیفکیٹ',
      'kill_switch': 'Android تحفظ',
      'connectivity': 'دستیاب نیٹ ورک',
      'api_reachability': 'سروس تک رسائی',
      'secure_storage': 'محفوظ ذخیرہ',
      'other': 'مقامی جانچ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'چیک ہو گیا',
      'failed': 'توجہ درکار ہے',
      'skipped': 'جانچ نہیں ہوئی — کوئی فعال پروب نہیں',
      'unknown': 'معلومات دستیاب نہیں ہیں',
      'other': 'معلومات دستیاب نہیں ہیں',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN میں خوش آمدید';

  @override
  String get connection_changeLocation => 'مقام تبدیل کریں';

  @override
  String get connection_details => 'کنکشن کی تفصیلات';

  @override
  String get locations_searchLabel => 'شہر یا ملک تلاش کریں';

  @override
  String get locations_clearSearch => 'تلاش صاف کریں';

  @override
  String get locations_filterAll => 'سب';

  @override
  String get locations_filterFavorites => 'پسندیدہ';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقامات',
      one: '$count مقام',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'کوئی مقام نہیں ملا';

  @override
  String get locations_noResultsHint => 'کوئی دوسرا شہر یا ملک آزمائیں۔';

  @override
  String get locations_noFavorites => 'آپ کے پسندیدہ، آسان رسائی میں';

  @override
  String get locations_noFavoritesHint =>
      'کسی مقام کو یہاں محفوظ کرنے کے لیے اس کے ساتھ موجود ستارے پر ٹیپ کریں۔';

  @override
  String get locations_showAll => 'تمام مقامات دیکھیں';

  @override
  String locations_addFavorite(String name) {
    return '$name کو پسندیدہ میں شامل کریں';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name کو پسندیدہ سے ہٹائیں';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'پسندیدہ محفوظ نہیں کیا جا سکا۔ دوبارہ کوشش کریں۔';

  @override
  String get locations_emptyTitle => 'کوئی مقام دستیاب نہیں';

  @override
  String get locations_emptyHint => 'دوبارہ کوشش کرنے کے لیے فہرست تازہ کریں۔';

  @override
  String get devices_manage => 'میرے آلات کا انتظام کریں';

  @override
  String get settings_personalization => 'اسے اپنی پسند کا بنائیں';

  @override
  String get settings_safety => 'تحفظ';

  @override
  String get settings_help => 'مدد چاہیے؟';

  @override
  String get settings_about => 'FuzeVPN کے بارے میں';

  @override
  String get diagnostics_heading => 'کنکشن کا مسئلہ سمجھیں';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'دستیاب',
      'pending': 'تیاری جاری ہے',
      'revoked': 'ہٹا دیا گیا',
      'expired': 'میعاد ختم',
      'other': 'حالت دستیاب نہیں ہے',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ترجیح محفوظ نہیں ہوئی';

  @override
  String get notice_preferenceSave_message =>
      'آپ کی پسند فی الحال لاگو ہے، لیکن محفوظ نہیں کی جا سکی۔ ایپ بند کرنے کے بعد بھی اسے رکھنے کے لیے دوبارہ کوشش کریں۔';

  @override
  String get connection_androidDisconnectHint =>
      'اگر Android VPN کو فعال رکھتا ہے تو کھلنے والی ترتیبات میں ہمیشہ فعال VPN بند کریں۔';

  @override
  String get protection_learnMore => 'Android کے تحفظ کے بارے میں مزید جانیں';

  @override
  String get protection_guideWhy =>
      'یہ تحفظ VPN ڈسکنیکٹ ہونے پر ایپس کو براہِ راست انٹرنیٹ استعمال کرنے سے روکتا ہے۔ اسے Android میں ترتیب دیا جاتا ہے۔';

  @override
  String get protection_guideAlwaysOnTitle => 'ہمیشہ فعال VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN سروس کو چلتا رکھتا ہے اور فون دوبارہ شروع ہونے کے بعد اسے دوبارہ چلا سکتا ہے۔';

  @override
  String get protection_guideBlockTitle => 'VPN کے بغیر کنکشنز بلاک کریں';

  @override
  String get protection_guideBlock =>
      'یہ ترتیب ٹریفک کو VPN سے بچ کر گزرنے سے روکتی ہے، بشمول کنکشن میں خلل کے دوران۔';

  @override
  String get protection_guideWarning =>
      'یہ بلاکنگ فعال ہونے پر VPN کنیکٹ ہونے تک انٹرنیٹ رسائی بند رہتی ہے۔';

  @override
  String get protection_guideStepsTitle => 'تحفظ آن کریں';

  @override
  String get protection_guideStep1 =>
      'نیچے موجود بٹن سے Android کی VPN ترتیبات کھولیں۔';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN کے ساتھ موجود گیئر آئیکن سے اختیارات کھولیں۔';

  @override
  String get protection_guideStep3 =>
      'ہمیشہ فعال VPN فعال کریں، پھر VPN کے بغیر کنکشنز بلاک کریں، اگر یہ اختیارات دستیاب ہوں۔';

  @override
  String get protection_guideManufacturers =>
      'نام فون کے لحاظ سے مختلف ہوتے ہیں۔ ضرورت پڑنے پر ترتیبات میں VPN تلاش کریں، جو اکثر نیٹ ورک اور انٹرنیٹ کے تحت ہوتا ہے۔';

  @override
  String get protection_guideDisableTitle => 'یہ تحفظ بند کریں';

  @override
  String get protection_guideDisable =>
      'انہی ترتیبات میں VPN کے بغیر بلاکنگ بند کریں تاکہ VPN کے بغیر انٹرنیٹ رسائی کی اجازت ملے۔ اگر آپ مزید نہیں چاہتے کہ Android اسے دوبارہ شروع کرے تو ہمیشہ فعال VPN بھی بند کریں۔';

  @override
  String get protection_guideManual =>
      'آپ یہ ترتیبات Android میں خود منتخب کرتے ہیں۔ FuzeVPN انہیں آپ کی طرف سے تبدیل نہیں کرتا۔';

  @override
  String get locations_changeTitle => 'مقام تبدیل کریں؟';

  @override
  String locations_changeActive(String name) {
    return 'VPN ڈسکنیکٹ ہوگا، پھر $name سے کنیکٹ ہونے کی کوشش کرے گا۔';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name سے کنیکٹ ہونے کی کوشش کرے گا۔';
  }

  @override
  String get locations_confirmChange => 'تبدیل کر کے کنیکٹ کریں';

  @override
  String get locations_changeBusy =>
      'ایک تبدیلی جاری ہے۔ دوسرا مقام منتخب کرنے سے پہلے انتظار کریں۔';

  @override
  String get locations_automaticSelection => 'خودکار انتخاب';

  @override
  String get locations_cities => 'شہر';

  @override
  String get locations_servers => 'سرورز';

  @override
  String locations_viewCities(String name) {
    return '$name کے شہر دیکھیں';
  }

  @override
  String locations_viewServers(String name) {
    return '$name کے سرورز دیکھیں';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ممالک',
      one: '$count ملک',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شہر',
      one: '$count شہر',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سرورز',
      one: '$count سرور',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'تمام ممالک';

  @override
  String get locations_backToCountries => 'ممالک پر واپس جائیں';

  @override
  String locations_backToCities(String name) {
    return '$name کے شہروں پر واپس جائیں';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name منتخب کریں';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name منتخب کریں';
  }

  @override
  String get locations_noCompatibleServer =>
      'کوئی مطابقت رکھنے والا سرور دستیاب نہیں ہے۔';

  @override
  String get externalLink_failed =>
      'یہ لنک نہیں کھل سکا۔ آپ اسے کاپی کرکے اپنے براؤزر میں کھول سکتے ہیں۔';

  @override
  String get externalLink_copy => 'لنک کاپی کریں';

  @override
  String get externalLink_copied => 'لنک کاپی ہوگیا';

  @override
  String get externalLink_copyFailed =>
      'لنک کاپی نہیں ہوسکا۔ نیچے دیا گیا پتہ منتخب کریں۔';

  @override
  String get settings_deleteAccount => 'میرا اکاؤنٹ حذف کریں';

  @override
  String get settings_deleteAccountDetail =>
      'اکاؤنٹ حذف کرنے کی درخواست کا طریقہ دیکھیں';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'اپنی VPN رکنیت منتخب کریں۔';

  @override
  String get billing_subscribe => 'رکنیت لیں';

  @override
  String get billing_choosePlan => 'جاری رکھنے کے لیے ایک پلان منتخب کریں۔';

  @override
  String get billing_monthly => 'ماہانہ';

  @override
  String get billing_yearly => 'سالانہ';

  @override
  String get billing_continue => 'Google Play کے ساتھ جاری رکھیں';

  @override
  String get billing_restore => 'خریداریاں بحال کریں';

  @override
  String get billing_manage => 'رکنیت کا انتظام کریں';

  @override
  String get billing_deleteAccountWarning =>
      'اگر آپ کے پاس Google Play کی رکنیت ہے تو اپنا FuzeVPN اکاؤنٹ حذف کرنے سے اس کی تجدید منسوخ نہیں ہوتی۔ Google Play میں تجدید کا الگ سے انتظام کریں یا اسے منسوخ کریں۔';

  @override
  String get billing_deleteAccountContinue =>
      'اکاؤنٹ حذف کرنے کی درخواست پر آگے بڑھیں';

  @override
  String get billing_refresh => 'رسائی تازہ کریں';

  @override
  String get billing_loadingPlans => 'پلان لوڈ ہو رہے ہیں…';

  @override
  String get billing_unavailable =>
      'فی الحال کوئی پلان دستیاب نہیں۔ بعد میں دوبارہ کوشش کریں۔';

  @override
  String get billing_comingSoon => 'رکنیتیں جلد دستیاب ہوں گی۔';

  @override
  String get billing_priceDisclosure =>
      'قیمت Google Play سے فراہم کی گئی ہے۔ حتمی رقم کی تصدیق ادائیگی سے پہلے ہوگی۔';

  @override
  String get billing_renewalMonthly =>
      'منسوخ نہ کرنے پر ہر ماہ خودکار تجدید ہوگی۔ Google Play کی رکنیتوں میں کسی بھی وقت منسوخ کر سکتے ہیں۔';

  @override
  String get billing_renewalYearly =>
      'منسوخ نہ کرنے پر ہر سال خودکار تجدید ہوگی۔ Google Play کی رکنیتوں میں کسی بھی وقت منسوخ کر سکتے ہیں۔';

  @override
  String get billing_active => 'آپ کی Premium رسائی فعال ہے';

  @override
  String billing_accessUntil(String date) {
    return '$date تک رسائی۔';
  }

  @override
  String get billing_webManaged =>
      'آپ کی رکنیت کا انتظام FuzeVPN ویب سائٹ پر ہوتا ہے۔';

  @override
  String get billing_playManaged =>
      'آپ کی رکنیت کا انتظام Google Play سے ہوتا ہے۔';

  @override
  String get billing_inactive => 'کوئی فعال رکنیت نہیں۔';

  @override
  String get billing_checkingAccess => 'آپ کی رسائی کی جانچ ہو رہی ہے…';

  @override
  String get billing_restoring => 'خریداریاں بحال ہو رہی ہیں…';

  @override
  String get billing_pending =>
      'ادائیگی زیر التوا ہے۔ تصدیق کے بعد آپ کی رسائی فعال ہوگی۔';

  @override
  String get billing_cancelled =>
      'خریداری منسوخ ہوگئی۔ کوئی نئی رکنیت فعال نہیں ہوئی۔';

  @override
  String get billing_verifying => 'خریداری کی تصدیق ہو رہی ہے…';

  @override
  String get billing_success =>
      'رکنیت فعال ہوگئی۔ آپ کی Premium رسائی تیار ہے۔';

  @override
  String get billing_restored => 'آپ کی خریداریاں بحال ہوگئی ہیں۔';

  @override
  String get billing_restoreEmpty =>
      'اس Google Play اکاؤنٹ کے لیے بحال کرنے کو کوئی خریداری نہیں۔';

  @override
  String get billing_catalogError => 'پلان لوڈ نہیں ہو سکے۔ دوبارہ کوشش کریں۔';

  @override
  String get billing_purchaseError =>
      'خریداری شروع نہیں ہو سکی۔ دوبارہ کوشش کریں۔';

  @override
  String get billing_verificationError =>
      'خریداری کی تصدیق عارضی طور پر دستیاب نہیں۔ دوبارہ کوشش کے لیے خریداریاں بحال کریں۔';

  @override
  String get billing_restoreError =>
      'خریداریاں بحال نہیں ہو سکیں۔ دوبارہ کوشش کریں۔';

  @override
  String get billing_managementError =>
      'رکنیت کا انتظام نہیں کھل سکا۔ دوبارہ کوشش کریں۔';

  @override
  String get billing_storeUnavailable => 'اس آلے پر Google Play دستیاب نہیں۔';

  @override
  String get welcome_title => 'آپ کا VPN، بالکل آسان۔';

  @override
  String get welcome_description =>
      'اپنا کنکشن محفوظ رکھیں۔ اپنی رازداری پر اختیار رکھیں۔';

  @override
  String get welcome_start => 'شروع کریں';

  @override
  String get welcome_alreadyPurchased => 'پہلے ہی خرید چکے ہیں؟';

  @override
  String get welcome_noAccountRequired =>
      'شروع کرنے کے لیے اکاؤنٹ بنانے کی ضرورت نہیں۔';

  @override
  String get guest_accountTitle => 'اکاؤنٹ منسلک نہیں ہے';

  @override
  String get guest_accountDescription =>
      'دوسرے آلے پر اپنی رکنیت استعمال کرنے کے لیے اسی Google Play اکاؤنٹ سے خریداری بحال کریں۔';

  @override
  String get guest_existingSubscriberSignIn =>
      'پہلے سے سبسکرائب کیا ہوا ہے؟ سائن ان کریں';

  @override
  String get guest_claimTitle => 'FuzeVPN ہر جگہ آپ کے ساتھ';

  @override
  String get guest_claimDescription =>
      'اپنے دوسرے آلات پر رکنیت تک رسائی کے لیے اکاؤنٹ بنائیں۔ یہ مرحلہ اختیاری ہے۔';

  @override
  String get guest_skip => 'بعد میں';

  @override
  String get guest_activationTitle => 'Fuze Premium فعال ہے';

  @override
  String get guest_activationDescription =>
      'آپ کی رکنیت تیار ہے۔ اپنا VPN استعمال کریں اور جب چاہیں اکاؤنٹ بنائیں۔';

  @override
  String get guest_useVpn => 'میرا VPN استعمال کریں';

  @override
  String get guest_loginRequired =>
      'یہ خریداری پہلے ہی ایک FuzeVPN اکاؤنٹ سے منسلک ہے۔ اپنی رکنیت تک رسائی کے لیے اسی اکاؤنٹ میں سائن ان کریں۔';

  @override
  String get guest_signOutWarning =>
      'آپ اسی Google Play اکاؤنٹ سے خریداری بحال کرکے اپنی رکنیت واپس حاصل کر سکتے ہیں۔';

  @override
  String get guest_profileUnavailable =>
      'آپ کا اکاؤنٹ پہلے ہی منسلک ہے۔ اپنی معلومات دیکھنے اور ان کا نظم کرنے کے لیے سائن ان کریں۔';

  @override
  String get billing_acceptance =>
      'جاری رکھنے پر آپ استعمال کی شرائط اور رازداری کی پالیسی قبول کرتے ہیں۔';

  @override
  String get guest_verifyEmailReminder =>
      'اپنا اکاؤنٹ محفوظ کرنے کے لیے ای میل پتے کی تصدیق کریں۔ آپ اپنا VPN استعمال کرتے رہ سکتے ہیں۔';

  @override
  String get guest_serviceUnavailable =>
      'سروس عارضی طور پر دستیاب نہیں ہے۔ تھوڑی دیر میں دوبارہ کوشش کریں۔';

  @override
  String get guest_restoreError =>
      'آپ کی خریداری بحال نہیں ہو سکی۔ خریداری کے لیے استعمال کیے گئے Google Play اکاؤنٹ سے دوبارہ کوشش کریں۔';

  @override
  String get guest_claimSuccess =>
      'آپ کا اکاؤنٹ بنا دیا گیا ہے۔ آپ کی رکنیت اور VPN تک رسائی برقرار ہیں۔';

  @override
  String get guest_emailExists =>
      'یہ ای میل پہلے سے استعمال ہو رہی ہے۔ کوئی دوسرا پتہ منتخب کریں یا اپنے موجودہ اکاؤنٹ میں سائن ان کریں۔ آپ کی خریداری Google Play کے ذریعے دستیاب رہے گی۔';

  @override
  String get guest_claimError =>
      'آپ کا اکاؤنٹ نہیں بن سکا۔ آپ اپنا VPN استعمال کرتے رہ سکتے ہیں اور بعد میں دوبارہ کوشش کر سکتے ہیں۔';

  @override
  String get guest_secureStorageError =>
      'اس آلے پر آپ کا سیشن محفوظ نہیں کیا جا سکا۔ دوبارہ کوشش کریں۔';

  @override
  String get guest_premiumRequired =>
      'اپنا VPN فعال کرنے کے لیے رکنیت منتخب کریں۔';

  @override
  String get welcome_viewPlans => 'پلان دیکھیں';

  @override
  String get google_continue => 'Google کے ساتھ جاری رکھیں';

  @override
  String get google_or => 'یا';

  @override
  String get google_title => 'آپ کا FuzeVPN اکاؤنٹ';

  @override
  String get google_settingUp => 'اپنا اکاؤنٹ مکمل کریں';

  @override
  String get google_country => 'رہائش کا ملک';

  @override
  String get google_profileDescription =>
      'FuzeVPN اکاؤنٹ بنانے کے لیے اپنا ملک منتخب کریں اور دونوں دستاویزات پڑھیں۔';

  @override
  String get google_claimDescription =>
      'مہمان اکاؤنٹ کو Google سے منسلک کریں۔ رکنیت اور آلہ اسی اکاؤنٹ سے منسلک رہیں گے۔';

  @override
  String get google_linkTitle => 'Google کو FuzeVPN سے منسلک کریں';

  @override
  String get google_linkDescription =>
      'موجودہ FuzeVPN اکاؤنٹ تک رسائی کی تصدیق کریں۔ Google پاس ورڈ نہیں مانگا جائے گا۔';

  @override
  String get google_password => 'FuzeVPN پاس ورڈ';

  @override
  String get google_linkAccount => 'لنک کی تصدیق کریں';

  @override
  String get google_requestEmail => 'تصدیقی ای میل بھیجیں';

  @override
  String get google_emailInstructions =>
      'FuzeVPN کی ای میل کھولیں اور تصدیقی کوڈ درج کریں۔';

  @override
  String get google_emailCode => 'ای میل کا تصدیقی کوڈ';

  @override
  String get google_confirmEmail => 'کوڈ کی تصدیق کریں';

  @override
  String get google_restart => 'دوسرا Google اکاؤنٹ منتخب کریں';

  @override
  String get google_resume => 'اس کوشش کی جانچ کریں';

  @override
  String get google_unavailable =>
      'Google سائن ان دستیاب نہیں۔ آپ ای میل اور پاس ورڈ استعمال کر سکتے ہیں۔';

  @override
  String get google_expired =>
      'اس کوشش کی مدت ختم ہو گئی ہے۔ اسے منسوخ کر کے دوبارہ شروع کریں۔';

  @override
  String get google_conflict =>
      'یہ Google اکاؤنٹ پہلے ہی دوسرے اکاؤنٹ سے منسلک ہے۔ موجودہ اکاؤنٹ اور رکنیت محفوظ رہیں گے۔';

  @override
  String get google_error =>
      'Google سائن ان ناکام ہوا۔ دوبارہ کوشش کریں؛ موجودہ رسائی محفوظ رہے گی۔';

  @override
  String get google_uncertain =>
      'نتیجے کی تصدیق نہیں ہو سکی۔ اس کوشش کی جانچ کریں یا دوبارہ شروع کرنے سے پہلے اسے منسوخ کریں۔';

  @override
  String get google_cancelFailed =>
      'منسوخی کی تصدیق نہیں ہو سکی۔ یہ اسکرین چھوڑنے سے پہلے دوبارہ منسوخ کرنے کی کوشش کریں۔';

  @override
  String get google_cancelled => 'Google سائن ان منسوخ ہو گیا۔';

  @override
  String get google_selecting => 'اپنا Google اکاؤنٹ منتخب کریں…';

  @override
  String get google_verifying => 'اکاؤنٹ کی جانچ ہو رہی ہے…';

  @override
  String get google_emailUnavailable =>
      'تصدیقی ای میل نہیں بھیجی جا سکی۔ بعد میں کوشش کریں۔';

  @override
  String get google_emailSent =>
      'تصدیقی ای میل بھیج دی گئی۔ اپنا ان باکس دیکھیں۔';

  @override
  String get google_rateLimited => 'دوبارہ کوشش کرنے سے پہلے انتظار کریں۔';

  @override
  String get google_invalidPassword =>
      'FuzeVPN پاس ورڈ غلط ہے۔ موجودہ اکاؤنٹ محفوظ رہے گا۔';

  @override
  String get google_invalidCode =>
      'تصدیقی کوڈ غلط ہے یا اس کی مدت ختم ہو گئی ہے۔';

  @override
  String get google_accountChanged =>
      'سیشن بدل گیا ہے۔ دوبارہ شروع کرنے سے پہلے اس کوشش کو منسوخ کریں۔';

  @override
  String get google_invalidResponse =>
      'جواب کی تصدیق نہیں ہو سکی۔ موجودہ رسائی محفوظ رہے گی۔';

  @override
  String get google_invalidRegistration =>
      'ملک اور دونوں رضامندیوں کی جانچ کریں۔';

  @override
  String get google_consentRequired =>
      'جاری رکھنے کے لیے ملک منتخب کریں اور دونوں دستاویزات قبول کریں۔';

  @override
  String get google_challengeRequired =>
      'اضافی سیکیورٹی جانچ ضروری ہے۔ موجودہ رسائی محفوظ رہے گی۔';

  @override
  String get google_challengeUnavailable =>
      'سیکیورٹی جانچ دستیاب نہیں۔ بعد میں کوشش کریں۔';
}
