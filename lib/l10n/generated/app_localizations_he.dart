// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get vpnDisclosure_title => 'הגנה על החיבור שלך';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN משתמשת בשירות ה-VPN של Android (VpnService) כדי ליצור מנהרה מוצפנת בין המכשיר הזה לבין השרתים של FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'בזמן שה-VPN פעיל, תעבורת האינטרנט של האפליקציות שלך, כתובות היעד ובקשות ה-DNS עוברות דרך המנהרה הזו כדי לנתב את החיבור שלך, גם כש-FuzeVPN פועלת ברקע.';

  @override
  String get vpnDisclosure_statusBody =>
      'האפליקציה משתמשת במצב החיבור, במשך החיבור ובכמות הנתונים שהועברו כדי להציג את חיבור ה-VPN שלך. אפשר לעצור אותו בכל עת.';

  @override
  String get vpnDisclosure_privacy => 'פרטיות';

  @override
  String get vpnDisclosure_accept => 'אשר והמשך';

  @override
  String get vpnDisclosure_decline => 'לא עכשיו';

  @override
  String get accountRestoration_title => 'החשבון אינו זמין כרגע';

  @override
  String get accountRestoration_message =>
      'ההפעלה שלך נשמרה. נסה שוב כדי לשחזר את החשבון שלך. עדיין אפשר לנהל את חיבור ה-VPN מכאן.';

  @override
  String get action_retry => 'נסה שוב';

  @override
  String get session_endingTitle => 'סיום ההפעלה';

  @override
  String get session_ending => 'מסיימים את ההפעלה: עוצרים את ה-VPN ומנקים…';

  @override
  String get session_stopFailed =>
      'עצירת ה-VPN לא אושרה. נסה שוב לפני שתיכנס מחדש לחשבון.';

  @override
  String get session_cleanupFailed =>
      'ה-VPN נעצר, אבל הסרת ההפעלה לא אושרה. נסה לנקות שוב.';

  @override
  String get session_retryStop => 'נסה לעצור שוב';

  @override
  String get session_retryCleanup => 'נסה לנקות שוב';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'מכינים את FuzeVPN בצורה מאובטחת…';

  @override
  String get nav_connection => 'חיבור';

  @override
  String get nav_locations => 'מיקומים';

  @override
  String get nav_account => 'חשבון';

  @override
  String get nav_devices => 'מכשירים';

  @override
  String get nav_settings => 'הגדרות';

  @override
  String get action_refresh => 'רענן';

  @override
  String get auth_tab_login => 'כניסה';

  @override
  String get auth_tab_register => 'הרשמה';

  @override
  String get auth_stepAccount => 'חשבון';

  @override
  String get auth_stepIdentity => 'זהות';

  @override
  String get auth_stepAddress => 'כתובת והסכמות';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'שלב $current מתוך $total';
  }

  @override
  String get auth_tagline => 'ה-VPN שלך, בפשטות.';

  @override
  String get auth_keysLocal => 'מפתחות ה-VPN הפרטיים שלך נשארים במכשיר הזה.';

  @override
  String get form_email => 'כתובת אימייל';

  @override
  String get form_password => 'סיסמה';

  @override
  String get form_showPassword => 'הצג סיסמה';

  @override
  String get form_hidePassword => 'הסתר סיסמה';

  @override
  String get form_passwordMin =>
      'בין 8 ל-72 בייטים ב-UTF-8. יש תווים שתופסים יותר מבייט אחד.';

  @override
  String get form_firstName => 'שם פרטי';

  @override
  String get form_lastName => 'שם משפחה';

  @override
  String get form_phone => 'טלפון (‎+33612345678)';

  @override
  String get form_address => 'כתובת';

  @override
  String get form_address2 => 'שורה נוספת בכתובת (אופציונלי)';

  @override
  String get form_postalCode => 'מיקוד';

  @override
  String get form_city => 'עיר';

  @override
  String get form_country => 'קוד מדינה (לדוגמה FR)';

  @override
  String get action_login => 'היכנס';

  @override
  String get action_createAccount => 'צור חשבון';

  @override
  String get action_createMyAccount => 'צור את החשבון שלי';

  @override
  String get action_next => 'המשך';

  @override
  String get action_previous => 'חזור';

  @override
  String get action_forgotPassword => 'שכחת סיסמה?';

  @override
  String get auth_noAccount => 'אין לך עדיין חשבון?';

  @override
  String get auth_requiredInformation => 'צור את החשבון שלך בשלושה שלבים.';

  @override
  String get auth_termsPrefix => 'אני מאשר/ת את ';

  @override
  String get auth_termsLink => 'תנאי השימוש';

  @override
  String get auth_privacyPrefix => 'אני מאשר/ת את ';

  @override
  String get auth_privacyLink => 'מדיניות הפרטיות';

  @override
  String get auth_consentRequired => 'נדרשת הסכמתך כדי ליצור חשבון.';

  @override
  String get validation_required => 'זהו שדה חובה.';

  @override
  String get validation_email => 'הזן כתובת אימייל תקינה.';

  @override
  String get validation_password => 'הסיסמה קצרה מדי: לפחות 8 בייטים ב-UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'הסיסמה ארוכה מדי: לכל היותר 72 בייטים ב-UTF-8.';

  @override
  String get validation_phone => 'השתמש בפורמט בינלאומי, לדוגמה ‎+33612345678.';

  @override
  String get validation_country => 'השתמש בקוד מדינה בן שתי אותיות, לדוגמה FR.';

  @override
  String get passwordReset_title => 'איפוס סיסמה';

  @override
  String get passwordReset_description =>
      'הזן את כתובת האימייל של החשבון שלך כדי לבקש קישור לאיפוס סיסמה.';

  @override
  String get passwordReset_send => 'שלח קישור';

  @override
  String get connection_title => 'החיבור שלך';

  @override
  String get connection_subtitle => 'בחר מיקום, ואז הפעל את ה-VPN.';

  @override
  String get connection_prepare => 'מוכן להתחבר?';

  @override
  String get connection_advancedOptions => 'אפשרויות מתקדמות';

  @override
  String get connection_location => 'מיקום';

  @override
  String get connection_chooseLocation => 'בחר מיקום';

  @override
  String get connection_protocol => 'פרוטוקול';

  @override
  String get connection_connect => 'התחבר';

  @override
  String get connection_connecting => 'מתחבר…';

  @override
  String get connection_disconnect => 'נתק';

  @override
  String get connection_disconnecting => 'מתנתק';

  @override
  String get connection_locationChange => 'משנה מיקום…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol אינו זמין';
  }

  @override
  String get connection_activeLocation => 'מיקום פעיל';

  @override
  String get connection_duration => 'משך';

  @override
  String get connection_received => 'התקבלו';

  @override
  String get connection_sent => 'נשלחו';

  @override
  String get connection_lastHandshake => 'חילופי הנתונים המאובטחים האחרונים';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'לפני $duration';
  }

  @override
  String get verification_title => 'אשר את כתובת האימייל שלך';

  @override
  String get verification_message =>
      'אשר את כתובת האימייל שלך כדי להפעיל את ה-VPN בטלפון הזה.';

  @override
  String get verification_resend => 'שלח שוב אימייל';

  @override
  String get migration_title => 'שינוי מיקום';

  @override
  String get migration_draining => 'מכינים את שינוי המיקום…';

  @override
  String get migration_activating => 'מפעילים את השרת החדש…';

  @override
  String get migration_ready => 'המיקום עודכן.';

  @override
  String get migration_blocked =>
      'שינוי המיקום דורש התערבות של השרת. נסה שוב מאוחר יותר או פנה לתמיכה.';

  @override
  String get migration_progress => 'התקדמות שינוי המיקום';

  @override
  String migration_retryDelay(Object seconds) {
    return 'זמן ההמתנה בין בדיקות (בשניות): $seconds.';
  }

  @override
  String get migration_resume => 'המשך את שינוי המיקום';

  @override
  String get status_authorizing => 'נדרשת הרשאה';

  @override
  String get status_authorizingDetail =>
      'אשר את בקשת Android כדי לאפשר את ה-VPN.';

  @override
  String get status_preparing => 'בהכנה';

  @override
  String get status_preparingDetail => 'החיבור המאובטח שלך בהכנה.';

  @override
  String get status_reconnecting => 'מתחבר מחדש…';

  @override
  String get status_reconnectingDetail =>
      'החיבור נקטע. ה-VPN מנסה להתחבר מחדש.';

  @override
  String get status_connecting => 'מתחבר';

  @override
  String get status_connectingDetail => 'מתחבר לשרת ה-VPN…';

  @override
  String get status_connected => 'מחובר';

  @override
  String get status_connectedDetail => 'חיבור ה-VPN שלך פעיל.';

  @override
  String get status_disconnecting => 'מתנתק';

  @override
  String get status_disconnectingDetail => 'חיבור ה-VPN שלך נעצר.';

  @override
  String get status_error => 'החיבור אינו זמין';

  @override
  String get status_errorDetail => 'חיבור ה-VPN לא אושר. נסה שוב.';

  @override
  String get status_idle => 'מנותק';

  @override
  String get status_idleDetail => 'התחבר ל-VPN כדי להגן על החיבור שלך.';

  @override
  String get trust_note =>
      'סגירת האפליקציה לא עוצרת את ה-VPN. כדי לעצור אותו, הקש על “נתק”.';

  @override
  String get locations_none => 'אין כרגע מיקומים זמינים.';

  @override
  String get locations_available => 'בחר את המיקום הבא שלך.';

  @override
  String get locations_selected => 'מיקום שנבחר';

  @override
  String get locations_select => 'בחר מיקום זה';

  @override
  String get locations_lockedTunnel => 'נתק את ה-VPN כדי לשנות מיקום.';

  @override
  String get locations_lockedMigration => 'המתן לסיום שינוי המיקום.';

  @override
  String get devices_title => 'המכשירים שלך';

  @override
  String devices_used(Object count, Object limit) {
    return '$count מתוך $limit מכשירים';
  }

  @override
  String get devices_refresh => 'רענן מכשירים';

  @override
  String get devices_empty => 'עדיין לא נרשם מכשיר VPN.';

  @override
  String get devices_firstConnection => 'הטלפון שלך יתווסף בחיבור הראשון.';

  @override
  String get devices_thisDevice => 'המכשיר הזה';

  @override
  String devices_added(Object date) {
    return 'נוסף ב-$date';
  }

  @override
  String get devices_unnamed => 'מכשיר ללא שם';

  @override
  String get action_remove => 'הסר';

  @override
  String get settings_title => 'הגדרות';

  @override
  String get settings_subtitle => 'ההעדפות והחשבון שלך, במקום אחד.';

  @override
  String get settings_appearance => 'מראה';

  @override
  String get settings_language => 'שפה';

  @override
  String get settings_languageDescription =>
      'השפה שבחרת חלה גם על התראות ה-VPN.';

  @override
  String get settings_account => 'חשבון';

  @override
  String get settings_signOut => 'התנתק מהחשבון';

  @override
  String get settings_privacy => 'מדיניות הפרטיות';

  @override
  String get settings_terms => 'תנאי השימוש';

  @override
  String get settings_security => 'אבטחה ושקיפות';

  @override
  String get settings_licenses => 'רישיונות רכיבים';

  @override
  String get settings_licensesDetail => 'תוכנות שבהן נעשה שימוש באפליקציה';

  @override
  String settings_licensesLegalese(String url) {
    return 'קוד המקור של האפליקציה ושל הרכיבים שלה ברישיון MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'ה-VPN נשאר פעיל כשיוצאים מהאפליקציה. כדי לעצור אותו, הקש על “נתק” בלשונית החיבור.';

  @override
  String get theme_system => 'מערכת';

  @override
  String get theme_light => 'בהיר';

  @override
  String get theme_dark => 'כהה';

  @override
  String get language_system => 'שפת הטלפון';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'להסיר את המכשיר הזה?';

  @override
  String get dialog_removeCurrent =>
      'הטלפון הזה ינותק מה-VPN ויאבד את הגישה. נתוני חיבור ה-VPN שלו יימחקו לאחר שהשרת יאשר.';

  @override
  String dialog_removeOther(Object name) {
    return 'הגישה ל-VPN של “$name” תבוטל. לא ניתן לבטל פעולה זו.';
  }

  @override
  String get dialog_signOut => 'להתנתק מהחשבון?';

  @override
  String get dialog_signOutMessage =>
      'ה-VPN ייעצר, ותצטרך להיכנס שוב. מפתחות ה-VPN המוצפנים יישארו בטלפון הזה לחיבור הבא שלך.';

  @override
  String get action_cancel => 'ביטול';

  @override
  String get action_close => 'סגירה';

  @override
  String get action_copy => 'העתקה';

  @override
  String get action_signOut => 'התנתק מהחשבון';

  @override
  String get notice_close => 'סגור הודעה';

  @override
  String get notice_sessionExpired_title => 'פג תוקף ההפעלה';

  @override
  String get notice_sessionExpired_message => 'פג תוקף ההפעלה שלך. היכנס שוב.';

  @override
  String get notice_connectionFailed_title => 'החיבור נכשל';

  @override
  String get notice_invalidCredentials_message =>
      'כתובת האימייל או הסיסמה שגויים.';

  @override
  String get notice_emailVerification_title => 'נדרש אישור אימייל';

  @override
  String get notice_emailVerification_message =>
      'אשר את כתובת האימייל שלך לפני הוספת מכשיר VPN.';

  @override
  String get notice_rateLimited_title => 'יותר מדי ניסיונות';

  @override
  String get notice_deviceLimit_title => 'הגעת למגבלת המכשירים';

  @override
  String get notice_deviceLimit_message =>
      'הסר מכשיר קיים לפני הוספת מכשיר נוסף.';

  @override
  String get notice_identityRenewal_title => 'יש לחדש את זהות ה-VPN';

  @override
  String get notice_identityRenewal_message =>
      'הזהות הזו הוסרה. צור זהות מקומית חדשה.';

  @override
  String get notice_migrationPending_title => 'שינוי מיקום מתבצע';

  @override
  String get notice_migrationPending_message => 'שינוי מיקום כבר מתבצע.';

  @override
  String get notice_migrationBlocked_title => 'שינוי המיקום נחסם';

  @override
  String get notice_migrationBlocked_message =>
      'שינוי המיקום דורש התערבות של השרת. נסה שוב מאוחר יותר או פנה לתמיכה.';

  @override
  String get notice_targetUnavailable_title => 'השרת אינו זמין זמנית';

  @override
  String get notice_targetUnavailable_message => 'השרת הזה אינו זמין זמנית.';

  @override
  String get notice_networkUnavailable_title => 'חיבור האינטרנט אינו זמין';

  @override
  String get notice_networkUnavailable_message => 'בדוק את החיבור ונסה שוב.';

  @override
  String get notice_permissionDenied_title => 'הרשאת ה-VPN נדחתה';

  @override
  String get notice_permissionDenied_message =>
      'התחל שוב את החיבור ואשר את בקשת ההרשאה של Android.';

  @override
  String get notice_wireguardTimeout_title => 'השרת לא מגיב';

  @override
  String get notice_wireguardTimeout_message =>
      'חיבור WireGuard ארך זמן רב מדי. נסה שוב או בחר מיקום אחר.';

  @override
  String get notice_tlsFailed_title => 'החיבור המאובטח נדחה';

  @override
  String get notice_tlsFailed_message =>
      'השרת לא קיבל את חיבור OpenVPN. נסה שוב. אם הבעיה נמשכת, הפעל אבחון.';

  @override
  String get notice_tunRejected_title => 'Android דחה את ממשק ה-VPN';

  @override
  String get notice_tunRejected_message =>
      'Android דחה את הגדרות הרשת שביקש OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'לא ניתן היה להפעיל את OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'מנוע OpenVPN לא הצליח לסיים את ההפעלה. נסה שוב. אם הבעיה נמשכת, פנה לתמיכה.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'קוד אבחון: $code';
  }

  @override
  String get notice_generic_title => 'חיבור ה-VPN נכשל';

  @override
  String get notice_generic_message => 'אירעה שגיאה. נסה שוב מאוחר יותר.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'החשבון נוצר',
      'password_reset_sent': 'בקשת איפוס הסיסמה התקבלה',
      'verification_email_sent': 'אימייל האימות נשלח',
      'location_migration_pending': 'שינוי מיקום מתבצע',
      'vpn_sign_in_required': 'נדרשת כניסה',
      'protocol_unavailable_at_location': 'הפרוטוקול אינו זמין',
      'vpn_permission_denied': 'הרשאת ה-VPN נדחתה',
      'revoked_identity_device_limit': 'הגעת למגבלת המכשירים',
      'tunnel_start_unexpected': 'לא ניתן להפעיל את ה-VPN',
      'flutter_disconnect_timeout': 'הניתוק לא אושר',
      'flutter_disconnect_unexpected': 'לא ניתן לנתק',
      'device_revoked': 'המכשיר הוסר',
      'revoke_unexpected': 'לא ניתן להסיר את המכשיר',
      'identity_renewal_unexpected': 'לא ניתן לחדש את הזהות',
      'openvpn_renewal_unexpected': 'לא ניתן לחדש את OpenVPN',
      'location_migration_blocked': 'שינוי המיקום נחסם',
      'location_migration_slow': 'שינוי המיקום עדיין מתבצע',
      'location_migration_conflict': 'שינוי המיקום דורש רענון',
      'location_migration_verification_failed': 'שינוי המיקום לא אושר',
      'location_migration_device_changed': 'המכשיר השתנה במהלך שינוי המיקום',
      'tunnel_stop_failed': 'שינוי המיקום אינו זמין',
      'device_clock_ahead': 'השעון במכשיר מקדים',
      'other': 'הפעולה נכשלה',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'החשבון נוצר, אבל לא ניתן היה לשלוח את אימייל האימות. השתמש באפשרות “שלח שוב אימייל” באפליקציה.',
      'password_reset_sent':
          'הבקשה שלך התקבלה. אם כתובת זו שייכת לחשבון, ייתכן שתקבל אימייל. בדוק גם בתיקיית הספאם.',
      'verification_email_sent': 'אימייל אימות חדש נשלח זה עתה.',
      'location_migration_pending':
          'המעבר אל $target עדיין בהכנה. אפשר להמשיך אותו בלי ליצור מחדש את המכשיר.',
      'vpn_sign_in_required': 'היכנס לחשבון שלך לפני הפעלת ה-VPN.',
      'protocol_unavailable_at_location':
          'הפרוטוקול שנבחר אינו מוצע במיקום הזה. רענן את המיקומים או בחר פרוטוקול אחר.',
      'vpn_permission_denied':
          'Android דחה את הרשאת ה-VPN. התחל שוב את החיבור ואשר את בקשת המערכת.',
      'revoked_identity_device_limit':
          'גישת ה-VPN של המכשיר הזה הוסרה, והגעת למגבלת המכשירים. הסר מכשיר בקטע חשבון ← נהל את המכשירים שלי.',
      'tunnel_start_unexpected':
          'שגיאה לא צפויה קטעה את הכנת המנהרה. בדוק את קוד האבחון ונסה שוב.',
      'flutter_disconnect_timeout':
          'Android לא אישר שה-VPN נעצר בזמן. נסה לעצור אותו שוב.',
      'flutter_disconnect_unexpected':
          'שגיאה לא צפויה מנעה אישור של עצירת המנהרה.',
      'device_revoked':
          'גישת ה-VPN של המכשיר בוטלה, והנתונים הסודיים המקומיים שלו נמחקו.',
      'revoke_unexpected':
          'לא ניתן היה להסיר את המכשיר. רענן את הרשימה ונסה שוב.',
      'identity_renewal_unexpected':
          'לא ניתן היה ליצור זהות VPN חדשה. רענן את המכשירים ונסה שוב.',
      'openvpn_renewal_unexpected':
          'לא ניתן היה לחדש את פרופיל OpenVPN. נסה שוב או בדוק את קוד האבחון.',
      'location_migration_blocked':
          'השרת לא יכול להשלים את השינוי כרגע. המכשיר והזהות המקומית שלו נשמרו.',
      'location_migration_slow':
          'השרת עדיין מכין את המעבר אל $target. הקש על “המשך את שינוי המיקום” בעוד כמה רגעים.',
      'location_migration_conflict':
          'מצב המכשיר השתנה בשרת. רענן את המכשירים, ואז המשך את השינוי.',
      'location_migration_verification_failed':
          'השרת לא אישר את המיקום החדש. הזהות המקומית הקודמת נשמרה.',
      'location_migration_device_changed':
          'המכשיר שהשרת החזיר כבר לא תואם למכשיר שבשינוי. רענן את המכשירים לפני שתנסה שוב.',
      'tunnel_stop_failed': 'יש לעצור לגמרי את המנהרה הקודמת לפני החיבור החדש.',
      'device_clock_ahead':
          'נראה שהשעון של המכשיר הזה מקדים. הפעל תאריך ושעה אוטומטיים כדי להישאר מחובר.',
      'other':
          'לא ניתן היה להשלים את הפעולה. נסה שוב או שלח את קוד האבחון לתמיכה.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'פג תוקף ההפעלה',
      'invalid_credentials': 'הכניסה נכשלה',
      'email_verification_required': 'נדרש אישור כתובת האימייל',
      'verification_email_cooldown': 'האימייל כבר נשלח',
      'rate_limited': 'יותר מדי ניסיונות',
      'invalid_registration': 'יש לתקן את הפרטים',
      'email_exists': 'החשבון כבר קיים',
      'invalid_profile': 'פרופיל לא תקין',
      'invalid_device': 'מכשיר לא תקין',
      'invalid_location': 'המיקום אינו זמין',
      'device_limit': 'הגעת למגבלת המכשירים',
      'device_exists': 'זהות ה-VPN כבר בשימוש',
      'device_identity_revoked': 'יש לחדש את זהות ה-VPN',
      'device_location_locked': 'שינוי המיקום דורש רענון',
      'location_migration_pending': 'שינוי מיקום מתבצע',
      'location_migration_blocked': 'שינוי המיקום נחסם',
      'target_ca_mismatch': 'שרת OpenVPN אינו תואם',
      'location_migration_conflict': 'שינוי המיקום דורש רענון',
      'server_full': 'השרת מלא',
      'capacity_unavailable': 'המיקום אינו זמין זמנית',
      'target_unavailable': 'השרת אינו זמין זמנית',
      'not_found': 'הפריט לא נמצא',
      'invalid_openvpn_csr': 'זהות OpenVPN לא תקינה',
      'openvpn_profile_exists': 'פרופיל OpenVPN כבר קיים',
      'openvpn_profile_revoked': 'פרופיל OpenVPN בוטל',
      'openvpn_operation_pending': 'פעולת OpenVPN בתהליך',
      'openvpn_operation_terminal': 'פעולת OpenVPN נקטעה',
      'openvpn_address_unavailable': 'כתובת OpenVPN אינה זמינה',
      'openvpn_profile_conflict': 'התנגשות ב-OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN אינו זמין',
      'email_delivery_unavailable': 'שליחת האימייל אינה זמינה',
      'invalid_token': 'קישור לא תקין',
      'network_unavailable': 'חיבור האינטרנט אינו זמין',
      'invalid_json': 'בקשה לא תקינה',
      'invalid_api_response': 'תגובת שרת לא תקינה',
      'ipv6_unavailable': 'IPv6 אינו זמין',
      'invalid_ip_families': 'הגדרות הרשת נדחו',
      'other': 'השירות אינו זמין',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'פג תוקף ההפעלה שלך. היכנס שוב.',
      'invalid_credentials': 'כתובת האימייל או הסיסמה שגויות.',
      'email_verification_required':
          'אשר את כתובת האימייל שלך לפני הוספת מכשיר VPN.',
      'invalid_registration': 'בדוק את המידע וההסכמות המבוקשים.',
      'email_exists': 'כתובת האימייל הזו כבר משויכת לחשבון.',
      'invalid_profile': 'בדוק את פרטי הפרופיל שלך.',
      'invalid_device': 'שם המכשיר או הזהות המקומית שלו אינם תקינים.',
      'invalid_location': 'רענן את רשימת המיקומים ונסה שוב.',
      'device_limit': 'הסר מכשיר קיים לפני הוספת מכשיר נוסף.',
      'device_exists': 'זהות ה-VPN הזו כבר מקושרת לחשבון אחר.',
      'device_identity_revoked': 'הזהות הזו הוסרה. יש ליצור זהות מקומית חדשה.',
      'device_location_locked':
          'המיקום של המכשיר הזה השתנה זה עתה. האפליקציה תמשיך את שינוי המיקום שבתהליך.',
      'location_migration_pending': 'שינוי מיקום כבר מתבצע.',
      'location_migration_blocked':
          'שינוי המיקום דורש התערבות של השרת. נסה שוב מאוחר יותר או פנה לתמיכה.',
      'target_ca_mismatch': 'השרת הזה עדיין אינו תואם לפרופיל OpenVPN הנוכחי.',
      'location_migration_conflict':
          'רענן את המכשירים ונסה לבצע שוב את שינוי המיקום.',
      'server_full':
          'המיקום הזה הגיע למספר החיבורים המרבי. בחר מיקום אחר או נסה שוב מאוחר יותר.',
      'capacity_unavailable':
          'לא ניתן לאשר כרגע אם המיקום הזה זמין. בחר מיקום אחר או נסה שוב מאוחר יותר.',
      'target_unavailable': 'השרת הזה אינו זמין זמנית.',
      'not_found': 'הפריט הזה כבר אינו זמין בחשבון שלך.',
      'invalid_openvpn_csr': 'צור זהות OpenVPN חדשה ונסה שוב.',
      'openvpn_profile_exists': 'כבר קיים פרופיל OpenVPN למכשיר הזה.',
      'openvpn_profile_revoked': 'חדש את פרופיל OpenVPN כדי להמשיך.',
      'openvpn_operation_pending': 'השינוי עדיין מתעדכן. נסה שוב מאוחר יותר.',
      'openvpn_operation_terminal': 'צור זהות OpenVPN חדשה ונסה שוב.',
      'openvpn_address_unavailable': 'אין כרגע כתובת OpenVPN זמינה.',
      'openvpn_profile_conflict': 'הפרופיל השתנה. רענן את המכשירים ונסה שוב.',
      'openvpn_signer_unavailable': 'שירות OpenVPN אינו זמין זמנית.',
      'email_delivery_unavailable':
          'לא ניתן היה לשלוח את האימייל. נסה שוב מאוחר יותר.',
      'invalid_token': 'הקישור אינו תקין או שפג תוקפו. בקש קישור חדש.',
      'network_unavailable': 'בדוק את חיבור האינטרנט שלך ונסה שוב.',
      'invalid_json': 'בדוק את המידע שהזנת ונסה שוב.',
      'invalid_api_response': 'השרת החזיר תגובה לא צפויה. נסה שוב מאוחר יותר.',
      'ipv6_unavailable': 'השרת לא יכול להפעיל IPv6 כרגע. נסה שוב מאוחר יותר.',
      'invalid_ip_families':
          'הגדרות המנהרה חסרות או אינן תואמות לכתובות המורשות. נסה שוב מהאפליקציה.',
      'other': 'אירעה שגיאה בשרת. נסה שוב מאוחר יותר.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'נסה שוב בעוד כמה רגעים.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'נסה שוב בעוד $seconds שניות.',
      two: 'נסה שוב בעוד $seconds שניות.',
      one: 'נסה שוב בעוד $seconds שנייה.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'נסה שוב בעוד $minutes דקות.',
      two: 'נסה שוב בעוד $minutes דקות.',
      one: 'נסה שוב בעוד $minutes דקה.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'נסה שוב בעוד $hours שעות.',
      two: 'נסה שוב בעוד $hours שעות.',
      one: 'נסה שוב בעוד $hours שעה.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'חידוש VPN של המערכת אינו זמין',
      'system_vpn_resume_corrupt': 'חידוש VPN של המערכת אינו תקין',
      'system_vpn_resume_session_invalid': 'הפעלה לא תקינה לחידוש VPN',
      'system_vpn_resume_identity_changed': 'זהות ה-VPN השתנתה',
      'system_vpn_resume_identity_invalid': 'זהות לחידוש VPN אינה תקינה',
      'system_vpn_resume_storage_failed': 'אחסון חידוש ה-VPN אינו זמין',
      'system_vpn_resume_network_timeout': 'אין רשת לחידוש ה-VPN',
      'system_vpn_resume_blocked': 'חידוש ה-VPN חסום',
      'system_vpn_resume_failed': 'חידוש ה-VPN נכשל',
      'system_vpn_resume_error_invalid': 'שגיאת חידוש VPN אינה תקינה',
      'wireguard_identity_store_failed': 'זהות WireGuard לא נשמרה',
      'wireguard_identity_unavailable': 'זהות WireGuard אינה זמינה',
      'vpn_host_destroyed': 'מארח ה-VPN של Android הופסק',
      'vpn_host_unavailable': 'מארח ה-VPN של Android אינו זמין',
      'vpn_permission_required': 'נדרשת הרשאת VPN',
      'vpn_permission_denied': 'הרשאת VPN נדחתה',
      'vpn_permission_request_failed': 'לא ניתן לבקש הרשאה',
      'wireguard_foreground_service_unavailable': 'שירות WireGuard אינו זמין',
      'wireguard_identity_invalid': 'מפתח WireGuard מקומי אינו תקין',
      'wireguard_identity_in_use': 'זהות WireGuard כבר בשימוש',
      'wireguard_configuration_invalid': 'הגדרות WireGuard אינן תקינות',
      'wireguard_operation_pending': 'פעולת WireGuard עדיין פעילה',
      'wireguard_start_failed': 'הפעלת WireGuard נדחתה',
      'wireguard_stop_timeout': 'עצירת WireGuard לא אושרה',
      'wireguard_handshake_timeout': 'WireGuard לא הגיב',
      'openvpn_connection_timeout': 'OpenVPN לא הגיב',
      'openvpn_core_unavailable': 'מנוע OpenVPN אינו זמין',
      'openvpn_operation_pending': 'ההפעלה של OpenVPN עדיין פעילה',
      'openvpn_stop_timeout': 'עצירת OpenVPN לא אושרה',
      'openvpn_profile_unavailable': 'פרופיל OpenVPN מקומי חסר',
      'openvpn_native_failed': 'הקריאה המקומית ל-OpenVPN הופסקה',
      'openvpn_key_generation_failed': 'לא ניתן ליצור מפתח P-256 של OpenVPN',
      'openvpn_csr_generation_failed': 'לא ניתן ליצור CSR של OpenVPN',
      'openvpn_identity_store_failed': 'זהות OpenVPN לא נשמרה',
      'openvpn_identity_clear_failed': 'הסרת OpenVPN לא הושלמה',
      'openvpn_identity_in_use': 'זהות OpenVPN עדיין בשימוש',
      'openvpn_tls_verification_required': 'אימות TLS של OpenVPN חסר',
      'openvpn_cipher_invalid': 'הצופן של OpenVPN אינו תקין',
      'openvpn_profile_rejected': 'פרופיל OpenVPN נדחה',
      'openvpn_identity_inconsistent': 'זהות OpenVPN אינה עקבית',
      'tls_handshake_failed': 'המשא ומתן של OpenVPN נדחה',
      'tls_alert_unknown_ca': 'תעודת הלקוח של OpenVPN לא זוהתה',
      'tls_alert_bad_certificate': 'תעודת הלקוח של OpenVPN נדחתה',
      'tls_alert_unsupported_certificate': 'תעודת OpenVPN אינה נתמכת',
      'tls_client_certificate_required': 'נדרשת תעודת לקוח של OpenVPN',
      'tls_alert_misc': 'התראת TLS של OpenVPN',
      'tls_signature_algorithm_rejected': 'חתימת OpenVPN אינה נתמכת',
      'tls_handshake_rejected': 'המשא ומתן TLS של OpenVPN נדחה',
      'tls_version_rejected': 'גרסת TLS של OpenVPN אינה תואמת',
      'tls_certificate_expired': 'פג תוקף תעודת TLS',
      'tls_certificate_revoked': 'תעודת TLS בוטלה',
      'transport_failed': 'שרת OpenVPN אינו נגיש',
      'tun_configuration_rejected': 'לא ניתן ליצור ממשק OpenVPN',
      'tun_setup_failed': 'הגדרת TUN של OpenVPN נכשלה',
      'tun_interface_create_failed': 'יצירת ממשק OpenVPN נכשלה',
      'tun_interface_disabled': 'ממשק OpenVPN הושבת',
      'tun_halted': 'ממשק OpenVPN הופסק',
      'tun_already_established': 'ממשק OpenVPN כבר פתוח',
      'tun_addresses_missing': 'כתובת OpenVPN חסרה',
      'tun_routes_missing': 'נתיבי OpenVPN חסרים',
      'tun_dns_missing': 'DNS של OpenVPN חסר',
      'tun_permission_revoked': 'הרשאת VPN בוטלה',
      'tun_establish_returned_null': 'Android דחה את ממשק ה-VPN',
      'openvpn_service_start_failed': 'שירות OpenVPN אינו זמין',
      'openvpn_operation_timeout': 'תם הזמן הקצוב לקריאת OpenVPN',
      'openvpn_start_failed': 'הפעלת OpenVPN נדחתה',
      'openvpn_connection_failed': 'החיבור ל-OpenVPN הופסק',
      'openvpn_core_status_error': 'ליבת OpenVPN הסתיימה בשגיאה',
      'openvpn_stopped_before_connected': 'OpenVPN הופסק לפני החיבור',
      'openvpn_auth_failed': 'אימות OpenVPN נדחה',
      'openvpn_client_setup_failed': 'הגדרת לקוח OpenVPN נכשלה',
      'openvpn_client_halted': 'לקוח OpenVPN הופסק',
      'openvpn_client_restart': 'התבקשה הפעלה מחדש של OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN לא היה פעיל זמן רב מדי',
      'openvpn_session_expired': 'פג תוקף ההפעלה של OpenVPN',
      'openvpn_credentials_required': 'אימות OpenVPN אינו נתמך',
      'openvpn_proxy_failed': 'הפרוקסי של OpenVPN נכשל',
      'openvpn_compression_failed': 'הדחיסה של OpenVPN נדחתה',
      'openvpn_ntlm_crypto_unavailable': 'הצפנת NTLM של OpenVPN אינה זמינה',
      'openvpn_feature_unsupported': 'תכונת OpenVPN אינה נתמכת',
      'network_unavailable': 'חיבור האינטרנט אינו זמין',
      'network_lost': 'הרשת אינה זמינה',
      'certificate_validation_failed': 'תעודת השרת נדחתה',
      'openvpn_certificate_expired': 'פג תוקף תעודת OpenVPN',
      'tunnel_active_for_another_account': 'המנהרה של חשבון אחר עדיין פעילה',
      'tunnel_already_active': 'המנהרה המקומית כבר פעילה',
      'tunnel_stop_timeout': 'עצירת $protocol לא אושרה',
      'tunnel_disconnected': '$protocol הופסק',
      'native_bridge_unavailable': 'הגשר ל-Android אינו זמין',
      'native_operation_failed': 'פעולת Android הופסקה',
      'invalid_arguments': 'פרמטרים של VPN חסרים',
      'invalid_account_id': 'חשבון VPN אינו תקין',
      'invalid_device_id': 'מזהה המכשיר אינו תקין',
      'storage_key_not_allowed': 'מפתח האחסון נדחה',
      'secure_storage_read_failed': 'קריאה מאובטחת נכשלה',
      'secure_storage_write_failed': 'כתיבה מאובטחת נכשלה',
      'key_generation_failed': 'לא ניתן ליצור מפתח WireGuard',
      'csr_generation_failed': 'לא ניתן ליצור CSR של OpenVPN',
      'openvpn_recovery_exhausted': 'שחזור OpenVPN כבר נוצל',
      'openvpn_recovery_failed': 'שחזור OpenVPN נכשל',
      'openvpn_renewal_required': 'נדרש חידוש של תעודת OpenVPN',
      'other': 'שגיאת VPN מקומית לא מסווגת',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android לא מצא הפעלת VPN שניתן לחדש. התחל חיבור חדש באפליקציה.',
      'system_vpn_resume_corrupt':
          'נתוני החידוש השמורים של ה-VPN אינם תקינים ולא יבוצע בהם שימוש. התחל חיבור חדש.',
      'system_vpn_resume_session_invalid':
          'ההפעלה השמורה כבר אינה יכולה לחדש את ה-VPN. היכנס שוב באפליקציה.',
      'system_vpn_resume_identity_changed':
          'זהות ה-VPN המקומית השתנתה. החידוש הופסק; התחל חיבור חדש.',
      'system_vpn_resume_identity_invalid':
          'זהות החידוש אינה תקינה. התחל חיבור חדש.',
      'system_vpn_resume_storage_failed':
          'Android לא הצליח לקרוא או לעדכן את נתוני החידוש המוצפנים. התחל חיבור חדש.',
      'system_vpn_resume_network_timeout':
          'Android לא מצא רשת בזמן כדי לחדש את ה-VPN. נסה שוב כשתהיה רשת זמינה.',
      'system_vpn_resume_blocked':
          'חידוש ה-VPN חסום. בדוק את הגדרות Android, ואז התחל חיבור חדש.',
      'system_vpn_resume_failed':
          'חידוש ה-VPN של Android נכשל. התחל חיבור חדש באפליקציה.',
      'system_vpn_resume_error_invalid':
          'Android החזיר שגיאת חידוש לא תקינה. התחל חיבור חדש.',
      'wireguard_identity_store_failed':
          'Android לא הצליח לשמור את זהות ה-WireGuard המוצפנת של החשבון הזה.',
      'wireguard_identity_unavailable':
          'אין זהות WireGuard תקינה זמינה לחיבור הזה.',
      'vpn_host_destroyed':
          'רכיב Android שמארח את ה-VPN הופסק. התחל חיבור חדש.',
      'vpn_host_unavailable':
          'Android לא יכול ליצור את הרכיב שמארח את ה-VPN. נסה שוב לאחר בדיקת הגדרות ה-VPN.',
      'openvpn_renewal_required': 'התעודה דורשת פעולה באפליקציה לפני החיבור.',
      'openvpn_recovery_failed':
          'השחזור האוטומטי נכשל. התחל חיבור חדש באפליקציה.',
      'openvpn_recovery_exhausted':
          'השחזור האוטומטי כבר נוצל. התחל חיבור חדש באפליקציה.',
      'vpn_permission_required':
          'Android דורש הרשאת VPN חדשה לפני הפעלת המנהרה.',
      'vpn_permission_denied': 'אשר את FuzeVPN בבקשת Android כדי להמשיך.',
      'vpn_permission_request_failed':
          'Android לא הצליח לפתוח את מסך הרשאת ה-VPN.',
      'wireguard_foreground_service_unavailable':
          'Android לא הצליח להשאיר את שירות WireGuard בחזית.',
      'wireguard_identity_invalid':
          'מפתח WireGuard המוצפן של החשבון הזה אינו קריא או אינו תקין.',
      'wireguard_identity_in_use':
          'פעולה אחרת עדיין משתמשת במפתח WireGuard של החשבון הזה.',
      'wireguard_configuration_invalid':
          'כתובת WireGuard, DNS, מפתח שרת או נתיבים שהתקבלו אינם תקינים.',
      'wireguard_operation_pending':
          'הפעולה הקודמת של WireGuard עדיין לא שחררה את השירות המקומי שלה.',
      'wireguard_start_failed': 'מנוע WireGuard דחה את הפעלת ההגדרות.',
      'wireguard_stop_timeout':
          'שירות WireGuard לא אישר את שחרור ממשק ה-VPN בתוך פרק הזמן המותר.',
      'wireguard_handshake_timeout': 'המנהרה לא אישרה לחיצת יד עם השרת בזמן.',
      'openvpn_connection_timeout': 'OpenVPN לא אישר את החיבור לשרת בזמן.',
      'openvpn_core_unavailable':
          'גרסת האפליקציה הזו אינה כוללת מנוע OpenVPN זמין.',
      'openvpn_operation_pending':
          'המנוע המקומי עדיין מחזיק בהפעלת OpenVPN הקודמת ומסרב ליצור הפעלה שנייה.',
      'openvpn_stop_timeout':
          'ליבת OpenVPN לא אישרה שההפעלה המקומית שלה הופסקה והוסרה בתוך פרק הזמן המותר.',
      'openvpn_profile_unavailable':
          'לא ניתן לקרוא פרופיל OpenVPN מאומת לחיבור הזה.',
      'openvpn_native_failed':
          'שגיאה באפליקציה הפסיקה את OpenVPN. נסה להתחבר שוב. אם הבעיה נמשכת, הפעל אבחון.',
      'openvpn_key_generation_failed':
          'Android Keystore לא הצליח ליצור או לקרוא את מפתח P-256 הפרטי שאינו ניתן לייצוא.',
      'openvpn_csr_generation_failed':
          'מפתח Android Keystore לא הצליח לחתום על בקשת התעודה של OpenVPN.',
      'openvpn_identity_store_failed':
          'לא ניתן לשמור את תעודת OpenVPN או את הפרופיל באחסון המוצפן.',
      'openvpn_identity_clear_failed':
          'Android לא הצליח להסיר במלואה את זהות OpenVPN המקומית של החשבון הזה.',
      'openvpn_identity_in_use':
          'הפעלה מקומית של OpenVPN עדיין משתמשת במפתח או בתעודה של המכשיר הזה.',
      'openvpn_tls_verification_required':
          'הפרופיל אינו דורש במפורש אימות של תעודת השרת.',
      'openvpn_cipher_invalid': 'השרת סיפק אלגוריתם הצפנה שאינו ברשימה המותרת.',
      'openvpn_profile_rejected':
          'הפרופיל שהתקבל מהשרת אינו תואם. צור מחדש את המכשיר הזה ונסה שוב.',
      'openvpn_identity_inconsistent':
          'התעודה אינה תואמת את הזהות המאובטחת של הטלפון הזה. לא הוחלף פרופיל מקומי.',
      'tls_handshake_failed':
          'השרת דחה את המשא ומתן של TLS. צור מחדש את הפרופיל אם הבעיה נמשכת.',
      'tls_alert_unknown_ca':
          'השרת אינו מכיר את רשות האישורים של תעודת המכשיר הזו. יש לבדוק את שרת OpenVPN.',
      'tls_alert_bad_certificate':
          'השרת דחה את תעודת המכשיר הזה. צור מחדש את המכשיר לפני ניסיון נוסף.',
      'tls_alert_unsupported_certificate':
          'השרת אינו תומך בסוג התעודה המאובטח שבו משתמש Android.',
      'tls_client_certificate_required':
          'השרת דורש תעודת לקוח, אך ליבת OpenVPN לא הצליחה להציג תעודה כזו.',
      'tls_alert_misc':
          'השרת החזיר התראת TLS שאינה שייכת לקטגוריות התעודה או הגרסה.',
      'tls_signature_algorithm_rejected':
          'השרת דחה את אלגוריתם ECDSA P-256 של מפתח Android Keystore.',
      'tls_handshake_rejected': 'השרת הפסיק את המשא ומתן של TLS לפני החיבור.',
      'tls_version_rejected': 'הלקוח והשרת לא מצאו גרסת TLS משותפת.',
      'tls_certificate_expired': 'פג תוקפה של התעודה שהוצגה במהלך החיבור.',
      'tls_certificate_revoked': 'התעודה שהוצגה במהלך החיבור בוטלה.',
      'transport_failed':
          'שרת OpenVPN אינו מגיב ברשת הנוכחית. נסה שוב בעוד רגע.',
      'tun_configuration_rejected': 'Android דחה את הגדרות הרשת שביקש OpenVPN.',
      'tun_setup_failed':
          'ליבת OpenVPN דחתה את תוכנית הרשת לפני יצירת הממשק ב-Android.',
      'tun_interface_create_failed':
          'ליבת OpenVPN לא הצליחה לקבל את ממשק ה-TUN מ-VpnService של Android.',
      'tun_interface_disabled':
          'Android או ליבת OpenVPN השביתו את ממשק ה-TUN במהלך החיבור.',
      'tun_halted': 'ליבת OpenVPN קיבלה בקשה לעצור את ממשק ה-TUN.',
      'tun_already_established':
          'OpenVPN ביקש ממשק שני באותו חיבור. המנהרה הופסקה מטעמי אבטחה.',
      'tun_addresses_missing': 'השרת לא סיפק כתובת מנהרה תקינה.',
      'tun_routes_missing': 'השרת לא סיפק נתיבי מנהרה תקינים.',
      'tun_dns_missing': 'השרת לא סיפק שרת DNS תקין.',
      'tun_permission_revoked': 'Android ביטל את הרשאת ה-VPN במהלך החיבור.',
      'tun_establish_returned_null':
          'Android לא יצר את הממשק, בדרך כלל משום ש-VPN אחר עדיין פעיל.',
      'openvpn_service_start_failed':
          'Android לא הצליח להפעיל את שירות OpenVPN בחזית.',
      'openvpn_operation_timeout':
          'קריאת JNI אל ליבת OpenVPN חרגה ממשך הזמן המרבי שלה.',
      'openvpn_start_failed':
          'שירות Android מוכן, אך ליבת OpenVPN לא קיבלה את הפעלת הפרופיל.',
      'openvpn_connection_failed':
          'ליבת OpenVPN הופסקה לפני שהפיקה את אירוע CONNECTED.',
      'openvpn_core_status_error':
          'הלולאה המקומית של OpenVPN הסתיימה בשגיאה, ללא אירוע סיום מפורט יותר.',
      'openvpn_stopped_before_connected':
          'הלולאה המקומית של OpenVPN הופסקה לפני CONNECTED, ללא שגיאת ליבה מפורשת.',
      'openvpn_auth_failed': 'שרת OpenVPN דחה את האימות של הפרופיל.',
      'openvpn_client_setup_failed':
          'ליבת OpenVPN לא הצליחה לאתחל את הלקוח לפני החיבור לרשת.',
      'openvpn_client_halted': 'ליבת OpenVPN קיבלה עצירה סופית של הלקוח.',
      'openvpn_client_restart':
          'ליבת OpenVPN ביקשה לאתחל מחדש את הפעלת התעבורה שלו.',
      'openvpn_inactive_timeout':
          'ליבת OpenVPN סגרה את ההפעלה לאחר פרק זמן של חוסר פעילות.',
      'openvpn_session_expired': 'השרת דיווח שפג תוקף ההפעלה של OpenVPN.',
      'openvpn_credentials_required':
          'השרת או פרוקסי מבקשים פרטי הזדהות אינטראקטיביים שאינם חלק מפרופיל התעודה הזה.',
      'openvpn_proxy_failed':
          'ליבת OpenVPN דיווחה על כשל בפרוקסי או בממסר שהוגדר.',
      'openvpn_compression_failed':
          'ליבת OpenVPN דחתה את מצב הדחיסה שהוכרז על ידי הפרופיל או השרת.',
      'openvpn_ntlm_crypto_unavailable':
          'הפרופיל מבקש הצפנת NTLM שאינה זמינה בגרסה זו.',
      'openvpn_feature_unsupported':
          'הפרופיל או השרת דורשים תכונה שחסרה בלקוח Android הזה.',
      'network_unavailable': 'אין רשת פיזית זמינה.',
      'network_lost': 'המנהרה הופסקה לאחר שהרשת נותקה.',
      'certificate_validation_failed': 'לא ניתן לאמת את זהות שרת OpenVPN.',
      'openvpn_certificate_expired': 'חדש את פרופיל OpenVPN לפני החיבור מחדש.',
      'tunnel_active_for_another_account':
          'מנהרה ששייכת לחשבון אחר חייבת להיעצר לפני החיבור הזה.',
      'tunnel_already_active':
          'Android מדווח שהפעלת VPN קודמת עדיין משתמשת בממשק.',
      'tunnel_stop_timeout':
          'מנוע $protocol לא אישר את שחרור ממשק ה-VPN בתוך פרק הזמן המותר.',
      'tunnel_disconnected':
          'המנוע המקומי דיווח שהמנהרה הסתיימה באופן בלתי צפוי לאחר ההפעלה.',
      'native_bridge_unavailable':
          'האפליקציה אינה יכולה לגשת לשירות ה-VPN של Android. סגור ופתח את האפליקציה מחדש, ואז נסה שוב.',
      'native_operation_failed':
          'שגיאה באפליקציה הפסיקה את פעולת ה-VPN. נסה שוב. אם הבעיה נמשכת, הפעל אבחון.',
      'invalid_arguments':
          'המידע הנדרש לפעולת ה-VPN הזו אינו שלם. נסה שוב. אם הבעיה נמשכת, הפעל אבחון.',
      'invalid_account_id': 'הפעולה המקומית אינה משויכת למזהה חשבון תקין.',
      'invalid_device_id': 'מזהה המכשיר שנשלח למנוע המקומי חסר או אינו תקין.',
      'storage_key_not_allowed':
          'הגשר ל-Android חסם מפתח שאינו ברשימת האחסון המותרת.',
      'secure_storage_read_failed':
          'Android Keystore לא הצליח לפענח את הנתונים המקומיים של החשבון הזה.',
      'secure_storage_write_failed':
          'Android Keystore לא הצליח להצפין או לשמור את הנתונים המקומיים.',
      'key_generation_failed':
          'Android לא הצליח ליצור או לקרוא את מפתח WireGuard באחסון המאובטח.',
      'csr_generation_failed':
          'Android Keystore לא הצליח ליצור או לחתום על CSR P-256 של OpenVPN.',
      'other':
          'אירעה שגיאה מקומית לא מתועדת. שלח לתמיכה את קוד האבחון המוצג למטה.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'בקשת ההרשאה כבר פתוחה';

  @override
  String get notice_permissionRequestInProgress_message =>
      'בקשת ההרשאה ל-VPN של Android כבר מוצגת. השלם אותה לפני שתנסה שוב.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'בקשת ההרשאה ל-VPN הופסקה';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'מסך ההרשאה ל-VPN נסגר לפני שהאפליקציה קיבלה תשובה.';

  @override
  String get notice_openvpnProofMissing_title => 'חיבור OpenVPN לא אושר';

  @override
  String get notice_openvpnProofMissing_message =>
      'לא ניתן היה לאשר את חיבור OpenVPN. החיבור הופסק מטעמי אבטחה. נסה שוב.';

  @override
  String get openvpnCleanup_title => 'פרופיל OpenVPN בוטל';

  @override
  String get openvpnCleanup_working =>
      'עוצרים ומסירים את פרופיל OpenVPN שבוטל…';

  @override
  String get openvpnCleanup_stopFailed =>
      'עצירת OpenVPN לא אושרה. נסה שוב לפני יצירת פרופיל חדש.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'לא ניתן היה להסיר לגמרי את פרופיל OpenVPN שבוטל. נסה לנקות שוב.';

  @override
  String get openvpnCleanup_complete =>
      'פרופיל OpenVPN שבוטל הוסר. הקש על “התחבר” כדי ליצור פרופיל חדש.';

  @override
  String get network_title => 'הגדרות רשת';

  @override
  String get network_ipv4Fallback =>
      'IPv6 אינו זמין זמנית. ההכנה ממשיכה ב-IPv4.';

  @override
  String get network_rejectedTitle => 'הגדרות הרשת נדחו';

  @override
  String get network_rejectedMessage =>
      'הגדרות המנהרה חסרות או אינן תואמות לכתובות המורשות. נסה שוב מהאפליקציה.';

  @override
  String get network_unreadableTitle => 'ההגדרות המקומיות אינן קריאות';

  @override
  String get network_unreadableMessage =>
      'לא ניתן להשתמש בהגדרות הרשת השמורות של OpenVPN. התחבר מחדש דרך האפליקציה כדי לעדכן אותן.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'הגנת רשת';

  @override
  String get protection_subtitle => 'חסום גישה ישירה לאינטרנט אם ה-VPN מתנתק.';

  @override
  String get protection_active => 'הגנת המערכת פעילה';

  @override
  String get protection_alwaysOnOnly =>
      '“VPN תמיד פעיל” מופעל; יש להפעיל את חסימת החיבורים ללא VPN';

  @override
  String get protection_inactive => 'הגנת המערכת אינה פעילה';

  @override
  String get protection_unknown => 'בדוק את הגנת המערכת';

  @override
  String get protection_openSettings => 'פתח הגדרות Android';

  @override
  String get protection_dialogTitle => 'הגדר את הגנת הרשת';

  @override
  String get protection_dialogMessage =>
      'Android מנהל את ההגדרה “VPN תמיד פעיל” ואת חסימת החיבורים ללא VPN. ודא ש-FuzeVPN נבחר והפעל את החסימה בהגדרות המערכת.';

  @override
  String get protection_dialogOpen => 'פתח הגדרות';

  @override
  String get session_systemProtectionNote =>
      'אם Android עדיין חוסם תעבורה מחוץ ל-VPN, פתח את הגדרות המערכת כדי לבדוק או לשנות את ההגנה הזו.';

  @override
  String get diagnostics_title => 'אבחון';

  @override
  String get diagnostics_settingsTitle => 'אבחון האפליקציה';

  @override
  String get diagnostics_automaticTitle => 'שלח שגיאות חשובות';

  @override
  String get diagnostics_automaticDescription =>
      'שתף דוח טכני קצר כשמתרחשת שגיאה חשובה.';

  @override
  String get diagnostics_privacy =>
      'הדוחות שנשלחו מקושרים לחשבון המחובר ונשמרים 30 יום. הם אינם מכילים היסטוריית גלישה, סיסמאות או מפתחות VPN.';

  @override
  String get diagnostics_manualOpen => 'הפעל אבחון';

  @override
  String get diagnostics_localDescription =>
      'צור דוח על מצב האפליקציה וה-VPN. החיבור שלך יישאר ללא שינוי.';

  @override
  String get diagnostics_sendReport => 'שלח את הדוח';

  @override
  String get diagnostics_sendHint =>
      'השאר את התיבה לא מסומנת כדי לשמור את הדוח במכשיר הזה.';

  @override
  String get diagnostics_signedOut => 'היכנס לחשבון שלך כדי לשלוח דוח.';

  @override
  String get diagnostics_localLifetime =>
      'שמור את הדוח בטלפון כדי שיישאר זמין גם אחרי סגירת האפליקציה.';

  @override
  String get diagnostics_run => 'הפעל אבחון';

  @override
  String get diagnostics_rerun => 'הפעל אבחון שוב';

  @override
  String get diagnostics_running => 'בודק…';

  @override
  String get diagnostics_sending => 'שולח את הדוח…';

  @override
  String get diagnostics_prepared => 'הדוח מוכן במכשיר הזה';

  @override
  String get diagnostics_queued => 'הדוח ממתין לשליחה';

  @override
  String get diagnostics_sent => 'הדוח התקבל';

  @override
  String get diagnostics_failed => 'השליחה נכשלה. הדוח המקומי שלך עדיין זמין.';

  @override
  String get diagnostics_preparationFailed =>
      'לא ניתן היה להכין את דוח האבחון. נסה שוב.';

  @override
  String get diagnostics_authenticationRequired =>
      'היכנס שוב כדי לשלוח את הדוח.';

  @override
  String get diagnostics_retry => 'נסה לשלוח שוב';

  @override
  String get diagnostics_export => 'שמור דוח';

  @override
  String get diagnostics_exportFailed => 'הייצוא נכשל. נסה שוב מהדוח המקומי.';

  @override
  String get diagnostics_preferenceFailed =>
      'לא ניתן לשמור את ההגדרה הזו. נסה שוב.';

  @override
  String diagnostics_receipt(Object id) {
    return 'אסמכתא: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'התקבל ב-$date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'נשמר עד $date';
  }

  @override
  String get diagnostics_duplicate => 'דוח זה כבר התקבל בעבר.';

  @override
  String get diagnostics_preview => 'תצוגה מקדימה של הדוח';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'צורפו $count אירועים טכניים',
      one: 'צורף אירוע טכני 1',
      zero: 'לא צורף אירוע טכני',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'פרטים טכניים';

  @override
  String get diagnostics_empty => 'עדיין לא הוכן דוח אבחון.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'מצב המנהרה',
      'handshake': 'אישור החיבור',
      'certificate': 'תעודת ה-VPN',
      'kill_switch': 'הגנת Android',
      'connectivity': 'רשת זמינה',
      'api_reachability': 'גישה לשירות',
      'secure_storage': 'אחסון מאובטח',
      'other': 'בדיקה מקומית',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'נבדק',
      'failed': 'דורש תשומת לב',
      'skipped': 'לא נבדק — אין בדיקה פעילה',
      'unknown': 'המידע אינו זמין',
      'other': 'המידע אינו זמין',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'ברוכים הבאים ל-FuzeVPN';

  @override
  String get connection_changeLocation => 'שנה מיקום';

  @override
  String get connection_details => 'פרטי החיבור';

  @override
  String get locations_searchLabel => 'חפש עיר או מדינה';

  @override
  String get locations_clearSearch => 'נקה חיפוש';

  @override
  String get locations_filterAll => 'הכול';

  @override
  String get locations_filterFavorites => 'מועדפים';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count מיקומים',
      two: '$count מיקומים',
      one: '$count מיקום',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'לא נמצאו מיקומים';

  @override
  String get locations_noResultsHint => 'נסה עיר או מדינה אחרת.';

  @override
  String get locations_noFavorites => 'המועדפים שלך, בהישג יד';

  @override
  String get locations_noFavoritesHint =>
      'הקש על הכוכב שליד מיקום כדי לשמור אותו כאן.';

  @override
  String get locations_showAll => 'הצג את כל המיקומים';

  @override
  String locations_addFavorite(String name) {
    return 'הוסף את $name למועדפים';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'הסר את $name מהמועדפים';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'לא ניתן היה לשמור את המועדף. נסה שוב.';

  @override
  String get locations_emptyTitle => 'אין מיקומים זמינים';

  @override
  String get locations_emptyHint => 'רענן את הרשימה כדי לנסות שוב.';

  @override
  String get devices_manage => 'נהל את המכשירים שלי';

  @override
  String get settings_personalization => 'התאמה אישית';

  @override
  String get settings_safety => 'הגנה';

  @override
  String get settings_help => 'צריך עזרה?';

  @override
  String get settings_about => 'אודות FuzeVPN';

  @override
  String get diagnostics_heading => 'הבנת בעיית חיבור';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'זמין',
      'pending': 'בהכנה',
      'revoked': 'הוסר',
      'expired': 'פג תוקף',
      'other': 'הסטטוס אינו זמין',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ההעדפה לא נשמרה';

  @override
  String get notice_preferenceSave_message =>
      'הבחירה שלך הופעלה לעת עתה, אך לא ניתן היה לשמור אותה. נסה שוב כדי שתישמר גם אחרי סגירת האפליקציה.';

  @override
  String get connection_androidDisconnectHint =>
      'אם Android משאיר את ה-VPN פעיל, כבה את “VPN תמיד פעיל” בהגדרות שייפתחו.';

  @override
  String get protection_learnMore => 'מידע נוסף על הגנת Android';

  @override
  String get protection_guideWhy =>
      'הגנה זו מונעת מאפליקציות להשתמש ישירות באינטרנט אם ה-VPN מתנתק. היא מוגדרת ב-Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN תמיד פעיל';

  @override
  String get protection_guideAlwaysOn =>
      'Android משאיר את שירות ה-VPN פעיל ויכול להפעיל אותו מחדש לאחר אתחול הטלפון.';

  @override
  String get protection_guideBlockTitle => 'חסום חיבורים ללא VPN';

  @override
  String get protection_guideBlock =>
      'הגדרה זו מונעת מהתעבורה לעקוף את ה-VPN, גם בזמן שהחיבור נקטע.';

  @override
  String get protection_guideWarning =>
      'כשהחסימה הזו פעילה, הגישה לאינטרנט תישאר כבויה עד שה-VPN יתחבר.';

  @override
  String get protection_guideStepsTitle => 'הפעל את ההגנה';

  @override
  String get protection_guideStep1 =>
      'פתח את הגדרות ה-VPN של Android באמצעות הלחצן שלמטה.';

  @override
  String get protection_guideStep2 =>
      'פתח את האפשרויות באמצעות סמל גלגל השיניים שליד FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'הפעל את “VPN תמיד פעיל”, ואז את “חסום חיבורים ללא VPN”, אם האפשרויות האלה מוצעות.';

  @override
  String get protection_guideManufacturers =>
      'שמות האפשרויות משתנים לפי הטלפון. במידת הצורך, חפש VPN בהגדרות, לרוב תחת רשת ואינטרנט.';

  @override
  String get protection_guideDisableTitle => 'כבה את ההגנה הזו';

  @override
  String get protection_guideDisable =>
      'באותן הגדרות, כבה את חסימת החיבורים ללא VPN כדי לאפשר גישה לאינטרנט בלי VPN. כבה גם את “VPN תמיד פעיל”, אם אינך רוצה ש-Android יפעיל אותו מחדש.';

  @override
  String get protection_guideManual =>
      'ההגדרות האלה נבחרות ב-Android. FuzeVPN לא משנה אותן עבורך.';

  @override
  String get locations_changeTitle => 'לשנות מיקום?';

  @override
  String locations_changeActive(String name) {
    return 'ה-VPN ינותק, ואז ינסה להתחבר אל $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'ה-VPN ינסה להתחבר אל $name.';
  }

  @override
  String get locations_confirmChange => 'שנה והתחבר';

  @override
  String get locations_changeBusy =>
      'שינוי מיקום מתבצע כעת. המתן לפני בחירת מיקום אחר.';

  @override
  String get locations_automaticSelection => 'בחירה אוטומטית';

  @override
  String get locations_cities => 'ערים';

  @override
  String get locations_servers => 'שרתים';

  @override
  String locations_viewCities(String name) {
    return 'הצג את הערים של $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'הצג את השרתים של $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count מדינות',
      two: '$count מדינות',
      one: '$count מדינה',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ערים',
      two: '$count ערים',
      one: '$count עיר',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count שרתים',
      two: '$count שרתים',
      one: '$count שרת',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'כל המדינות';

  @override
  String get locations_backToCountries => 'חזרה למדינות';

  @override
  String locations_backToCities(String name) {
    return 'חזרה לערים של $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'בחר את $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'בחר את $name';
  }

  @override
  String get locations_noCompatibleServer => 'אין שרת תואם זמין.';

  @override
  String get externalLink_failed =>
      'לא ניתן לפתוח את הקישור הזה. אפשר להעתיק אותו ולפתוח אותו בדפדפן.';

  @override
  String get externalLink_copy => 'העתק קישור';

  @override
  String get externalLink_copied => 'הקישור הועתק';

  @override
  String get externalLink_copyFailed =>
      'לא ניתן להעתיק את הקישור. בחר את הכתובת שלמטה.';

  @override
  String get settings_deleteAccount => 'מחק את החשבון שלי';

  @override
  String get settings_deleteAccountDetail => 'הצג את הנוהל לבקשת מחיקת חשבון';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'בחר את מנוי ה-VPN שלך.';

  @override
  String get billing_subscribe => 'הצטרף למנוי';

  @override
  String get billing_choosePlan => 'בחר תוכנית כדי להמשיך.';

  @override
  String get billing_monthly => 'חודשי';

  @override
  String get billing_yearly => 'שנתי';

  @override
  String get billing_continue => 'המשך עם Google Play';

  @override
  String get billing_restore => 'שחזר רכישות';

  @override
  String get billing_manage => 'נהל מנוי';

  @override
  String get billing_deleteAccountWarning =>
      'אם יש לך מנוי Google Play, מחיקת חשבון FuzeVPN אינה מבטלת את החידוש שלו. נהל או בטל את החידוש בנפרד ב-Google Play.';

  @override
  String get billing_deleteAccountContinue => 'המשך לבקשת מחיקת החשבון';

  @override
  String get billing_refresh => 'רענן גישה';

  @override
  String get billing_loadingPlans => 'טוען תוכניות…';

  @override
  String get billing_unavailable =>
      'אין תוכניות זמינות כרגע. נסה שוב מאוחר יותר.';

  @override
  String get billing_comingSoon => 'מנויים יהיו זמינים בקרוב.';

  @override
  String get billing_priceDisclosure =>
      'המחיר מסופק על ידי Google Play. הסכום הסופי והמסים החלים יוצגו לאישורך לפני השלמת הרכישה.';

  @override
  String get billing_renewalMonthly =>
      'מתחדש אוטומטית מדי חודש, אלא אם מבטלים. אפשר לבטל בכל עת במנויים של Google Play.';

  @override
  String get billing_renewalYearly =>
      'מתחדש אוטומטית מדי שנה, אלא אם מבטלים. אפשר לבטל בכל עת במנויים של Google Play.';

  @override
  String get billing_active => 'הגישה שלך ל-Premium פעילה';

  @override
  String billing_accessUntil(String date) {
    return 'גישה עד $date.';
  }

  @override
  String get billing_webManaged => 'המנוי שלך מנוהל באתר של FuzeVPN.';

  @override
  String get billing_playManaged => 'המנוי שלך מנוהל על ידי Google Play.';

  @override
  String get billing_playOnHold =>
      'המנוי שלך ב-Google Play מושהה או ממתין לתשלום. פתח את “נהל מנוי” כדי לתקן זאת ב-Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'לחשבון Google Play הזה כבר יש מנוי Fuze Premium שאינו פעיל עבור חשבון FuzeVPN זה. פתח את “נהל מנוי” כדי לבדוק אותו ב-Google Play.';

  @override
  String get billing_inactive => 'אין מנוי פעיל.';

  @override
  String get billing_checkingAccess => 'בודק את הגישה שלך…';

  @override
  String get billing_restoring => 'משחזר רכישות…';

  @override
  String get billing_pending => 'התשלום בהמתנה. הגישה שלך תופעל לאחר האישור.';

  @override
  String get billing_cancelled => 'הרכישה בוטלה. לא הופעל מנוי חדש.';

  @override
  String get billing_verifying => 'מאמת את הרכישה…';

  @override
  String get billing_success => 'המנוי הופעל. הגישה שלך ל-Premium מוכנה.';

  @override
  String get billing_restored => 'הרכישות שלך שוחזרו.';

  @override
  String get billing_restoreEmpty =>
      'אין רכישות לשחזור עבור חשבון Google Play הזה.';

  @override
  String get billing_catalogError => 'לא ניתן לטעון תוכניות. נסה שוב.';

  @override
  String get billing_purchaseError => 'לא ניתן להתחיל את הרכישה. נסה שוב.';

  @override
  String get billing_verificationError =>
      'אימות הרכישה אינו זמין כרגע. שחזר רכישות כדי לנסות שוב.';

  @override
  String get billing_restoreError => 'לא ניתן לשחזר רכישות. נסה שוב.';

  @override
  String get billing_managementError =>
      'לא ניתן לפתוח את ניהול המנויים. נסה שוב.';

  @override
  String get billing_storeUnavailable => 'Google Play אינו זמין במכשיר הזה.';

  @override
  String get welcome_title => 'ה-VPN שלך, בפשטות.';

  @override
  String get welcome_description =>
      'הגן על החיבור שלך. שמור על השליטה בפרטיות שלך.';

  @override
  String get welcome_start => 'התחל';

  @override
  String get welcome_alreadyPurchased => 'כבר רכשת?';

  @override
  String get welcome_noAccountRequired => 'אין צורך בחשבון כדי להתחיל.';

  @override
  String get guest_accountTitle => 'החשבון לא מקושר';

  @override
  String get guest_accountDescription =>
      'שחזר את הרכישות שלך עם אותו חשבון Google Play כדי להשתמש במנוי שלך במכשיר אחר.';

  @override
  String get guest_existingSubscriberSignIn => 'כבר יש לך מנוי? היכנס';

  @override
  String get guest_claimTitle => 'FuzeVPN איתך בכל מקום';

  @override
  String get guest_claimDescription =>
      'צור חשבון כדי לגשת למנוי שלך במכשירים האחרים שלך. שלב זה אופציונלי.';

  @override
  String get guest_skip => 'אולי אחר כך';

  @override
  String get guest_activationTitle => 'Fuze Premium פעיל';

  @override
  String get guest_activationDescription =>
      'המנוי שלך מוכן. אפשר להשתמש ב-VPN וליצור חשבון בכל עת.';

  @override
  String get guest_useVpn => 'השתמש ב-VPN שלי';

  @override
  String get guest_loginRequired =>
      'הרכישה הזו כבר מקושרת לחשבון FuzeVPN. היכנס לחשבון הזה כדי לגשת למנוי שלך.';

  @override
  String get guest_signOutWarning =>
      'אפשר לשחזר את המנוי שלך על ידי שחזור הרכישות עם אותו חשבון Google Play.';

  @override
  String get guest_profileUnavailable =>
      'החשבון שלך כבר מקושר. היכנס כדי להציג ולנהל את הפרטים שלך.';

  @override
  String get billing_acceptance =>
      'המשך התהליך מהווה הסכמה לתנאי השימוש ולמדיניות הפרטיות.';

  @override
  String get guest_verifyEmailReminder =>
      'אשר את כתובת האימייל שלך כדי לאבטח את החשבון. אפשר להמשיך להשתמש ב-VPN.';

  @override
  String get guest_serviceUnavailable =>
      'השירות אינו זמין כרגע. נסה שוב בעוד רגע.';

  @override
  String get guest_restoreError =>
      'לא ניתן לשחזר את הרכישות שלך. נסה שוב עם חשבון Google Play שבו בוצעה הרכישה.';

  @override
  String get guest_claimSuccess =>
      'החשבון שלך נוצר. המנוי והגישה שלך ל-VPN נשמרו.';

  @override
  String get guest_emailExists =>
      'כתובת האימייל הזו כבר בשימוש. בחר כתובת אחרת או היכנס לחשבון הקיים שלך. הרכישה שלך נשארת זמינה דרך Google Play.';

  @override
  String get guest_claimError =>
      'לא ניתן ליצור את החשבון. אפשר להמשיך להשתמש ב-VPN ולנסות שוב מאוחר יותר.';

  @override
  String get guest_secureStorageError =>
      'לא ניתן לאבטח את ההפעלה במכשיר הזה. נסה שוב.';

  @override
  String get guest_premiumRequired => 'בחר מנוי כדי להפעיל את ה-VPN שלך.';

  @override
  String get welcome_viewPlans => 'הצג תוכניות';

  @override
  String get google_continue => 'המשך עם Google';

  @override
  String get google_or => 'או';

  @override
  String get google_title => 'החשבון שלך ב-FuzeVPN';

  @override
  String get google_settingUp => 'סיים את יצירת החשבון';

  @override
  String get google_country => 'מדינת מגורים';

  @override
  String get google_profileDescription =>
      'בחר את המדינה שלך ועיין בשני המסמכים כדי ליצור את חשבון FuzeVPN שלך.';

  @override
  String get google_claimDescription =>
      'קשר את חשבון האורח שלך ל-Google. המנוי והמכשיר שלך יישארו משויכים לחשבון הזה.';

  @override
  String get google_linkTitle => 'קשר את Google ל-FuzeVPN';

  @override
  String get google_linkDescription =>
      'אשר גישה לחשבון FuzeVPN הקיים שלך. שלב זה לא מבקש את סיסמת Google שלך.';

  @override
  String get google_password => 'סיסמת FuzeVPN';

  @override
  String get google_linkAccount => 'אשר את הקישור';

  @override
  String get google_requestEmail => 'שלח לי אימייל לאישור';

  @override
  String get google_emailInstructions =>
      'פתח את האימייל מ-FuzeVPN והזן את קוד האישור.';

  @override
  String get google_emailCode => 'קוד אישור באימייל';

  @override
  String get google_confirmEmail => 'אשר את הקוד';

  @override
  String get google_restart => 'בחר חשבון Google אחר';

  @override
  String get google_resume => 'בדוק את הניסיון הזה';

  @override
  String get google_unavailable =>
      'כניסה עם Google אינה זמינה. אפשר להשתמש באימייל ובסיסמה.';

  @override
  String get google_expired => 'פג תוקף הניסיון. בטל אותו והתחל מחדש.';

  @override
  String get google_conflict =>
      'חשבון Google הזה כבר מקושר לחשבון אחר. החשבון והמנוי הנוכחיים שלך נשמרים.';

  @override
  String get google_error =>
      'הכניסה עם Google נכשלה. נסה שוב; הגישה הנוכחית שלך נשמרת.';

  @override
  String get google_uncertain =>
      'לא ניתן לאשר את התוצאה. בדוק את הניסיון הזה או בטל אותו לפני שתתחיל מחדש.';

  @override
  String get google_cancelFailed =>
      'לא ניתן לאשר את הביטול. נסה לבטל שוב לפני שתצא ממסך זה.';

  @override
  String get google_cancelled => 'הכניסה עם Google בוטלה.';

  @override
  String get google_selecting => 'בחר את חשבון Google שלך…';

  @override
  String get google_verifying => 'בודק את החשבון שלך…';

  @override
  String get google_emailUnavailable =>
      'לא ניתן לשלוח את אימייל האישור. נסה שוב מאוחר יותר.';

  @override
  String get google_emailSent =>
      'אימייל האישור נשלח. בדוק את תיבת הדואר הנכנס שלך.';

  @override
  String get google_rateLimited => 'המתן לפני שתנסה שוב.';

  @override
  String get google_busy =>
      'Google אינו זמין בזמן שפעולה אחרת מתבצעת (חיבור VPN, חשבון או אורח). נסה שוב אחרי שהיא תסתיים; הגישה הנוכחית שלך נשמרת.';

  @override
  String get google_invalidPassword =>
      'סיסמת FuzeVPN שגויה. החשבון הנוכחי שלך נשמר.';

  @override
  String get google_invalidCode => 'קוד האישור שגוי או שפג תוקפו.';

  @override
  String get google_accountChanged =>
      'ההפעלה שלך השתנתה. בטל את הניסיון הזה לפני שתתחיל מחדש.';

  @override
  String get google_invalidResponse =>
      'לא ניתן לאמת את התשובה. הגישה הנוכחית שלך נשמרת.';

  @override
  String get google_invalidRegistration => 'בדוק את המדינה ואת שתי ההסכמות.';

  @override
  String get google_consentRequired =>
      'בחר את המדינה שלך ואשר את שני המסמכים כדי להמשיך.';

  @override
  String get google_challengeRequired =>
      'נדרש אימות אבטחה נוסף. הגישה הנוכחית שלך נשמרת.';

  @override
  String get google_challengeUnavailable =>
      'בדיקת האבטחה אינה זמינה. נסה שוב מאוחר יותר.';

  @override
  String get google_intentMismatch =>
      'ניסיון כניסה קודם עם Google עדיין ממתין. בטל אותו לפני שתתחיל את הפעולה הזו.';

  @override
  String get google_challengeBlocked =>
      'בדיקת האבטחה הנדרשת אינה זמינה באפליקציה הזו. לא ניתן להשלים את הפעולה כרגע.';

  @override
  String get google_solveChallenge => 'השלם את בדיקת האבטחה';

  @override
  String get google_challengeTitle => 'בדיקת אבטחה';

  @override
  String get google_challengeReady =>
      'האימות הושלם. אפשר עכשיו לאשר את יצירת החשבון.';

  @override
  String get google_challengeExpired =>
      'פג תוקף האימות. השלם אותו שוב לפני האישור.';

  @override
  String get google_challengeCancelled => 'האימות בוטל. אפשר לנסות שוב.';

  @override
  String get google_challengeFailed => 'בדיקת האבטחה נכשלה. נסה שוב.';

  @override
  String get billing_trialTitle => 'נסה את Fuze Premium בחינם';

  @override
  String get billing_trialSubtitle => 'הגן על החיבור שלך החל מהיום.';

  @override
  String get billing_trialWeeks => 'ניסיון חינם של שבועיים';

  @override
  String billing_trialDays(String days) {
    return 'ניסיון חינם של $days ימים';
  }

  @override
  String get billing_trialStart => 'התחל את הניסיון החינם שלי';

  @override
  String billing_trialFirstCharge(String date) {
    return 'אם תתחיל היום, החיוב הראשון צפוי ב-$date.';
  }

  @override
  String get billing_trialTerms =>
      'מתחדש אוטומטית במחיר המצוין. כדי להימנע מחיוב, בטל ב-Google Play לפני סיום הניסיון.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'לאחר מכן $price לחודש';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'לאחר מכן $price לשנה';
  }

  @override
  String get billing_choosePeriod => 'בחר את התוכנית שלך';

  @override
  String get billing_selectionHint => 'בחר תוכנית כדי להמשיך.';

  @override
  String get billing_benefitConnection => 'חיבור מוצפן';

  @override
  String get billing_benefitPrivacy => 'פרטיות באינטרנט';

  @override
  String get billing_benefitNoAccount => 'ללא צורך בהרשמה';

  @override
  String get billing_cancellation => 'ביטול ב-Google Play';

  @override
  String get billing_premiumTitle => 'חיבור מוגן יותר.';

  @override
  String get billing_premiumSubtitle => 'הגן על החיבור שלך, בקצב שלך.';

  @override
  String get billing_priceMonthly => 'לחודש';

  @override
  String get billing_priceYearly => 'לשנה';

  @override
  String get billing_trialToday => 'אין תשלום היום';

  @override
  String get billing_trialConfirmation =>
      'Google Play מציג לאישורך את התאריכים, הסכום הסופי והמסים החלים לפני השלמת הרכישה.';

  @override
  String get billing_offerChanged =>
      'תנאי ההצעה הזו השתנו. רענן את התוכניות ובחר שוב.';

  @override
  String get status_waitingNetwork => 'ממתין לרשת';

  @override
  String get status_waitingNetworkDetail =>
      'אין רשת זמינה. ה-VPN יבדוק את החיבור כשהרשת תחזור.';

  @override
  String get locations_favoriteLoadFailed =>
      'לא ניתן לטעון את המועדפים. נסה שוב.';

  @override
  String get locations_favoritesLoading => 'טוען מועדפים…';
}
