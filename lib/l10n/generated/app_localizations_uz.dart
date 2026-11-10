// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Ulanishingizni himoya qiling';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ushbu qurilma bilan FuzeVPN serverlari oʻrtasida shifrlangan tunnel yaratish uchun Android’ning VPN xizmatidan (VpnService) foydalanadi.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN faol boʻlganda, ilovalaringizning Internet trafigi, maqsad manzillari va DNS soʻrovlari ulanishingizni yoʻnaltirish uchun shu tunnel orqali oʻtadi, hatto FuzeVPN fonda ishlayotgan boʻlsa ham.';

  @override
  String get vpnDisclosure_statusBody =>
      'Ilova VPN ulanishingizni koʻrsatish uchun ulanish holati, uning davomiyligi va uzatilgan maʼlumot hajmidan foydalanadi. Uni istalgan vaqtda toʻxtatishingiz mumkin.';

  @override
  String get vpnDisclosure_privacy => 'Maxfiylik';

  @override
  String get vpnDisclosure_accept => 'Qabul qilish va davom etish';

  @override
  String get vpnDisclosure_decline => 'Hozir emas';

  @override
  String get accountRestoration_title => 'Hisob vaqtincha mavjud emas';

  @override
  String get accountRestoration_message =>
      'Seansingiz saqlab qolindi. Hisobingizni tiklash uchun qayta urinib koʻring. VPN ulanishini bu yerda hamon boshqarishingiz mumkin.';

  @override
  String get action_retry => 'Qayta urinish';

  @override
  String get session_endingTitle => 'Seans yakunlanmoqda';

  @override
  String get session_ending =>
      'Seans yakunlanmoqda: VPN toʻxtatilmoqda va tozalanmoqda…';

  @override
  String get session_stopFailed =>
      'VPN’ning toʻxtatilishi tasdiqlanmadi. Hisobga yana kirishdan oldin qayta urinib koʻring.';

  @override
  String get session_cleanupFailed =>
      'VPN toʻxtatildi, ammo seansni oʻchirish tasdiqlanmadi. Tozalashni takrorlang.';

  @override
  String get session_retryStop => 'Toʻxtatishni takrorlash';

  @override
  String get session_retryCleanup => 'Tozalashni takrorlash';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN xavfsiz tayyorlanmoqda…';

  @override
  String get nav_connection => 'Ulanish';

  @override
  String get nav_locations => 'Joylashuvlar';

  @override
  String get nav_account => 'Hisob';

  @override
  String get nav_devices => 'Qurilmalar';

  @override
  String get nav_settings => 'Sozlamalar';

  @override
  String get action_refresh => 'Yangilash';

  @override
  String get auth_tab_login => 'Hisobga kirish';

  @override
  String get auth_tab_register => 'Roʻyxatdan oʻtish';

  @override
  String get auth_stepAccount => 'Hisob';

  @override
  String get auth_stepIdentity => 'Shaxsiy maʼlumot';

  @override
  String get auth_stepAddress => 'Manzil va roziliklar';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$total qadamdan $current-qadam';
  }

  @override
  String get auth_tagline => 'VPN’ingiz — sodda va qulay.';

  @override
  String get auth_keysLocal =>
      'Shaxsiy VPN kalitlaringiz shu qurilmada saqlanadi.';

  @override
  String get form_email => 'E-pochta manzili';

  @override
  String get form_password => 'Parol';

  @override
  String get form_showPassword => 'Parolni koʻrsatish';

  @override
  String get form_hidePassword => 'Parolni yashirish';

  @override
  String get form_passwordMin =>
      '8–72 ta UTF-8 bayt. Baʼzi belgilar bir necha bayt egallaydi.';

  @override
  String get form_firstName => 'Ism';

  @override
  String get form_lastName => 'Familiya';

  @override
  String get form_phone => 'Telefon raqami (+33612345678)';

  @override
  String get form_address => 'Manzil';

  @override
  String get form_address2 => 'Manzilning 2-qatori (ixtiyoriy)';

  @override
  String get form_postalCode => 'Pochta indeksi';

  @override
  String get form_city => 'Shahar';

  @override
  String get form_country => 'Mamlakat kodi (masalan, FR)';

  @override
  String get action_login => 'Hisobga kirish';

  @override
  String get action_createAccount => 'Hisob yaratish';

  @override
  String get action_createMyAccount => 'Hisobimni yaratish';

  @override
  String get action_next => 'Davom etish';

  @override
  String get action_previous => 'Orqaga';

  @override
  String get action_forgotPassword => 'Parolni unutdingizmi?';

  @override
  String get auth_noAccount => 'Hali hisobingiz yoʻqmi?';

  @override
  String get auth_requiredInformation => 'Hisobingizni uch qadamda yarating.';

  @override
  String get auth_termsPrefix => 'Men ';

  @override
  String get auth_termsLink => 'foydalanish shartlarini qabul qilaman';

  @override
  String get auth_privacyPrefix => 'Men ';

  @override
  String get auth_privacyLink => 'maxfiylik siyosatini qabul qilaman';

  @override
  String get auth_consentRequired =>
      'Hisob yaratish uchun roziligingiz talab qilinadi.';

  @override
  String get validation_required => 'Bu maydon toʻldirilishi shart.';

  @override
  String get validation_email => 'Toʻgʻri e-pochta manzilini kiriting.';

  @override
  String get validation_password =>
      'Parol juda qisqa: kamida 8 ta UTF-8 bayt boʻlishi kerak.';

  @override
  String get validation_passwordTooLong =>
      'Parol juda uzun: eng koʻpi bilan 72 ta UTF-8 bayt boʻlishi kerak.';

  @override
  String get validation_phone =>
      'Xalqaro formatdan foydalaning, masalan, +33612345678.';

  @override
  String get validation_country =>
      'Ikki harfli mamlakat kodidan foydalaning, masalan, FR.';

  @override
  String get passwordReset_title => 'Parolni tiklash';

  @override
  String get passwordReset_description =>
      'Parolni tiklash havolasini olish uchun hisobingizga bogʻlangan e-pochta manzilini kiriting.';

  @override
  String get passwordReset_send => 'Havolani yuborish';

  @override
  String get connection_title => 'Ulanishingiz';

  @override
  String get connection_subtitle => 'Joylashuvni tanlang, soʻng VPN’ni yoqing.';

  @override
  String get connection_prepare => 'Ulanishga tayyormisiz?';

  @override
  String get connection_advancedOptions => 'Qoʻshimcha sozlamalar';

  @override
  String get connection_location => 'Joylashuv';

  @override
  String get connection_chooseLocation => 'Joylashuvni tanlang';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Ulanish';

  @override
  String get connection_connecting => 'Ulanmoqda…';

  @override
  String get connection_disconnect => 'Uzish';

  @override
  String get connection_disconnecting => 'Uzilmoqda';

  @override
  String get connection_locationChange => 'Joylashuv oʻzgartirilmoqda…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol mavjud emas';
  }

  @override
  String get connection_activeLocation => 'Faol joylashuv';

  @override
  String get connection_duration => 'Davomiyligi';

  @override
  String get connection_received => 'Qabul qilingan';

  @override
  String get connection_sent => 'Yuborilgan';

  @override
  String get connection_lastHandshake => 'Oxirgi xavfsiz almashinuv';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration oldin';
  }

  @override
  String get verification_title => 'E-pochta manzilingizni tasdiqlang';

  @override
  String get verification_message =>
      'Bu telefonda VPN’dan foydalanish uchun e-pochta manzilingizni tasdiqlang.';

  @override
  String get verification_resend => 'Xatni qayta yuborish';

  @override
  String get migration_title => 'Joylashuvni oʻzgartirish';

  @override
  String get migration_draining => 'Joylashuvni oʻzgartirish tayyorlanmoqda…';

  @override
  String get migration_activating => 'Yangi server faollashtirilmoqda…';

  @override
  String get migration_ready => 'Joylashuv yangilandi.';

  @override
  String get migration_blocked =>
      'Joylashuvni oʻzgartirish uchun server aralashuvi talab qilinadi. Keyinroq qayta urinib koʻring yoki qoʻllab-quvvatlash xizmatiga murojaat qiling.';

  @override
  String get migration_progress => 'Joylashuvni oʻzgartirish jarayoni';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Tekshiruvlar oraligʻi: $seconds s.';
  }

  @override
  String get migration_resume => 'Davom ettirish';

  @override
  String get status_authorizing => 'Ruxsat talab qilinadi';

  @override
  String get status_authorizingDetail =>
      'VPN’ga ruxsat berish uchun Android soʻrovini qabul qiling.';

  @override
  String get status_preparing => 'Tayyorlanmoqda';

  @override
  String get status_preparingDetail => 'Xavfsiz ulanishingiz tayyorlanmoqda.';

  @override
  String get status_reconnecting => 'Qayta ulanmoqda…';

  @override
  String get status_reconnectingDetail =>
      'Ulanish uzildi. VPN qayta ulanishga urinmoqda.';

  @override
  String get status_connecting => 'Ulanmoqda';

  @override
  String get status_connectingDetail => 'VPN serveriga ulanmoqda…';

  @override
  String get status_connected => 'Ulangan';

  @override
  String get status_connectedDetail => 'VPN ulanishingiz faol.';

  @override
  String get status_disconnecting => 'Uzilmoqda';

  @override
  String get status_disconnectingDetail => 'VPN ulanishingiz toʻxtatilmoqda.';

  @override
  String get status_error => 'Ulanish mavjud emas';

  @override
  String get status_errorDetail =>
      'VPN ulanishi tasdiqlanmadi. Qayta urinib koʻring.';

  @override
  String get status_idle => 'Uzilgan';

  @override
  String get status_idleDetail =>
      'Ulanishingizni himoya qilish uchun VPN’ga ulaning.';

  @override
  String get trust_note =>
      'Ilovani yopish VPN’ni toʻxtatmaydi. Uni toʻxtatish uchun Uzish tugmasidan foydalaning.';

  @override
  String get locations_none => 'Hozircha mavjud joylashuvlar yoʻq.';

  @override
  String get locations_available => 'Keyingi joylashuvingizni tanlang.';

  @override
  String get locations_selected => 'Tanlangan joylashuv';

  @override
  String get locations_select => 'Bu joylashuvni tanlash';

  @override
  String get locations_lockedTunnel =>
      'Joylashuvni oʻzgartirish uchun VPN’ni uzing.';

  @override
  String get locations_lockedMigration =>
      'Joylashuvni oʻzgartirish tugashini kuting.';

  @override
  String get devices_title => 'Qurilmalaringiz';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ta qurilma';
  }

  @override
  String get devices_refresh => 'Qurilmalarni yangilash';

  @override
  String get devices_empty =>
      'Hali hech qanday VPN qurilmasi roʻyxatdan oʻtmagan.';

  @override
  String get devices_firstConnection =>
      'Telefoningiz birinchi ulanishda qoʻshiladi.';

  @override
  String get devices_thisDevice => 'Bu qurilma';

  @override
  String devices_added(Object date) {
    return '$date kuni qoʻshilgan';
  }

  @override
  String get devices_unnamed => 'Nomsiz qurilma';

  @override
  String get action_remove => 'Olib tashlash';

  @override
  String get settings_title => 'Sozlamalar';

  @override
  String get settings_subtitle => 'Sozlamalaringiz va hisobingiz — bir joyda.';

  @override
  String get settings_appearance => 'Koʻrinish';

  @override
  String get settings_language => 'Til';

  @override
  String get settings_languageDescription =>
      'Tanlangan til VPN bildirishnomalariga ham qoʻllanadi.';

  @override
  String get settings_account => 'Hisob';

  @override
  String get settings_signOut => 'Hisobdan chiqish';

  @override
  String get settings_privacy => 'Maxfiylik siyosati';

  @override
  String get settings_terms => 'Foydalanish shartlari';

  @override
  String get settings_security => 'Xavfsizlik va shaffoflik';

  @override
  String get settings_licenses => 'Komponent litsenziyalari';

  @override
  String get settings_licensesDetail => 'Ilovada ishlatilgan dasturiy taʼminot';

  @override
  String settings_licensesLegalese(String url) {
    return 'Ilova va uning MPL-2.0 komponentlarining manba kodi: $url';
  }

  @override
  String get settings_background =>
      'Ilovadan chiqqaningizda ham VPN ishlashda davom etadi. Uni toʻxtatish uchun Ulanish boʻlimidagi Uzish tugmasidan foydalaning.';

  @override
  String get theme_system => 'Tizim';

  @override
  String get theme_light => 'Yorugʻ';

  @override
  String get theme_dark => 'Qorongʻi';

  @override
  String get language_system => 'Telefon tili';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Bu qurilmani olib tashlaysizmi?';

  @override
  String get dialog_removeCurrent =>
      'Bu telefon VPN’dan uziladi va kirish huquqini yoʻqotadi. Uning VPN ulanish maʼlumotlari server tasdiqlaganidan soʻng oʻchiriladi.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” uchun VPN kirish huquqi bekor qilinadi. Bu amalni qaytarib boʻlmaydi.';
  }

  @override
  String get dialog_signOut => 'Hisobdan chiqasizmi?';

  @override
  String get dialog_signOutMessage =>
      'VPN toʻxtaydi va hisobingizga qaytadan kirishingiz kerak boʻladi. Shifrlangan VPN kalitlaringiz keyingi ulanish uchun shu telefonda qoladi.';

  @override
  String get action_cancel => 'Bekor qilish';

  @override
  String get action_close => 'Yopish';

  @override
  String get action_copy => 'Nusxa olish';

  @override
  String get action_signOut => 'Hisobdan chiqish';

  @override
  String get notice_close => 'Xabarni yopish';

  @override
  String get notice_sessionExpired_title => 'Seans muddati tugadi';

  @override
  String get notice_sessionExpired_message =>
      'Seansingiz muddati tugadi. Qaytadan hisobga kiring.';

  @override
  String get notice_connectionFailed_title => 'Ulanib boʻlmadi';

  @override
  String get notice_invalidCredentials_message =>
      'E-pochta manzili yoki parol notoʻgʻri.';

  @override
  String get notice_emailVerification_title =>
      'E-pochtani tasdiqlash talab qilinadi';

  @override
  String get notice_emailVerification_message =>
      'VPN qurilmasini qoʻshishdan oldin e-pochta manzilingizni tasdiqlang.';

  @override
  String get notice_rateLimited_title => 'Urinishlar juda koʻp';

  @override
  String get notice_deviceLimit_title => 'Qurilmalar limitiga yetildi';

  @override
  String get notice_deviceLimit_message =>
      'Yangi qurilma qoʻshishdan oldin mavjud qurilmalardan birini olib tashlang.';

  @override
  String get notice_identityRenewal_title =>
      'VPN identifikatori yangilanishi kerak';

  @override
  String get notice_identityRenewal_message =>
      'Bu identifikator olib tashlandi. Yangi mahalliy identifikator yarating.';

  @override
  String get notice_migrationPending_title =>
      'Joylashuvni oʻzgartirish davom etmoqda';

  @override
  String get notice_migrationPending_message =>
      'Joylashuvni oʻzgartirish allaqachon davom etmoqda.';

  @override
  String get notice_migrationBlocked_title =>
      'Joylashuvni oʻzgartirish bloklandi';

  @override
  String get notice_migrationBlocked_message =>
      'Joylashuvni oʻzgartirish uchun server aralashuvi talab qilinadi. Keyinroq qayta urinib koʻring yoki qoʻllab-quvvatlash xizmatiga murojaat qiling.';

  @override
  String get notice_targetUnavailable_title => 'Server vaqtincha mavjud emas';

  @override
  String get notice_targetUnavailable_message =>
      'Bu server vaqtincha mavjud emas.';

  @override
  String get notice_networkUnavailable_title => 'Internet ulanishi mavjud emas';

  @override
  String get notice_networkUnavailable_message =>
      'Ulanishingizni tekshirib, qayta urinib koʻring.';

  @override
  String get notice_permissionDenied_title => 'VPN uchun ruxsat rad etildi';

  @override
  String get notice_permissionDenied_message =>
      'Ulanishni qaytadan boshlang va Android ruxsat soʻrovini qabul qiling.';

  @override
  String get notice_wireguardTimeout_title => 'Server javob bermayapti';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard ulanishi juda uzoq davom etdi. Qayta urinib koʻring yoki boshqa joylashuvni tanlang.';

  @override
  String get notice_tlsFailed_title => 'Xavfsiz ulanish rad etildi';

  @override
  String get notice_tlsFailed_message =>
      'Server OpenVPN ulanishini qabul qilmadi. Qayta urinib koʻring. Muammo davom etsa, diagnostikani ishga tushiring.';

  @override
  String get notice_tunRejected_title => 'Android VPN interfeysini rad etdi';

  @override
  String get notice_tunRejected_message =>
      'Android OpenVPN soʻragan tarmoq sozlamalarini rad etdi.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN ishga tushmadi';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN dvigateli ishga tushishni yakunlay olmadi. Qayta urinib koʻring. Muammo davom etsa, qoʻllab-quvvatlash xizmatiga murojaat qiling.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diagnostika kodi: $code';
  }

  @override
  String get notice_generic_title => 'VPN’ga ulanib boʻlmadi';

  @override
  String get notice_generic_message =>
      'Xatolik yuz berdi. Keyinroq qayta urinib koʻring.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Hisob yaratildi',
      'password_reset_sent': 'Parolni tiklash soʻrovi qabul qilindi',
      'verification_email_sent': 'Tasdiqlash xati yuborildi',
      'location_migration_pending': 'Joylashuvni oʻzgartirish davom etmoqda',
      'vpn_sign_in_required': 'Hisobga kirish talab qilinadi',
      'protocol_unavailable_at_location': 'Protokol mavjud emas',
      'vpn_permission_denied': 'VPN uchun ruxsat rad etildi',
      'revoked_identity_device_limit': 'Qurilmalar limitiga yetildi',
      'tunnel_start_unexpected': 'VPN ishga tushmadi',
      'flutter_disconnect_timeout': 'Uzilish tasdiqlanmadi',
      'flutter_disconnect_unexpected': 'Uzib boʻlmadi',
      'device_revoked': 'Qurilma olib tashlandi',
      'revoke_unexpected': 'Qurilmani olib tashlab boʻlmadi',
      'identity_renewal_unexpected': 'Identifikatorni yangilab boʻlmadi',
      'openvpn_renewal_unexpected': 'OpenVPN’ni yangilab boʻlmadi',
      'location_migration_blocked': 'Joylashuvni oʻzgartirish bloklandi',
      'location_migration_slow': 'Joylashuvni oʻzgartirish hali davom etmoqda',
      'location_migration_conflict':
          'Joylashuvni oʻzgartirishni yangilash kerak',
      'location_migration_verification_failed':
          'Joylashuvni oʻzgartirish tasdiqlanmadi',
      'location_migration_device_changed':
          'Joylashuvni oʻzgartirish vaqtida qurilma oʻzgardi',
      'tunnel_stop_failed': 'Joylashuvni oʻzgartirib boʻlmaydi',
      'device_clock_ahead': 'Qurilma soati oldinga ketgan',
      'other': 'Amal bajarilmadi',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Hisob yaratildi, ammo tasdiqlash xatini yuborib boʻlmadi. Ilovadagi qayta yuborish tugmasidan foydalaning.',
      'password_reset_sent':
          'Soʻrovingiz qabul qilindi. Agar bu manzilga mos hisob mavjud boʻlsa, sizga xat kelishi mumkin. Spam jildini ham tekshiring.',
      'verification_email_sent': 'Yangi tasdiqlash xati hozirgina yuborildi.',
      'location_migration_pending':
          '$target joylashuviga oʻtish hali tayyorlanmoqda. Qurilmani qayta yaratmasdan davom ettirishingiz mumkin.',
      'vpn_sign_in_required':
          'VPN’ni ishga tushirishdan oldin hisobingizga kiring.',
      'protocol_unavailable_at_location':
          'Tanlangan protokol bu joylashuvda taklif etilmaydi. Joylashuvlarni yangilang yoki boshqa protokolni tanlang.',
      'vpn_permission_denied':
          'Android VPN uchun ruxsat bermadi. Ulanishni qaytadan boshlang va tizim soʻrovini qabul qiling.',
      'revoked_identity_device_limit':
          'Bu qurilmaning VPN kirish huquqi olib tashlandi va qurilmalar limitiga yetildi. Hisob → Qurilmalarimni boshqarish boʻlimida qurilmani olib tashlang.',
      'tunnel_start_unexpected':
          'Kutilmagan xatolik tunnelni tayyorlashni toʻxtatdi. Diagnostika kodini tekshirib, qayta urinib koʻring.',
      'flutter_disconnect_timeout':
          'Android VPN’ning oʻz vaqtida toʻxtaganini tasdiqlamadi. Uni qayta toʻxtatib koʻring.',
      'flutter_disconnect_unexpected':
          'Kutilmagan xatolik tunnel toʻxtaganini tasdiqlashga toʻsqinlik qildi.',
      'device_revoked':
          'Qurilmaning VPN kirish huquqi bekor qilindi va uning mahalliy maxfiy maʼlumotlari oʻchirildi.',
      'revoke_unexpected':
          'Qurilmani olib tashlab boʻlmadi. Roʻyxatni yangilab, qayta urinib koʻring.',
      'identity_renewal_unexpected':
          'Yangi VPN identifikatorini yaratib boʻlmadi. Qurilmalarni yangilab, qayta urinib koʻring.',
      'openvpn_renewal_unexpected':
          'OpenVPN profilini yangilab boʻlmadi. Qayta urinib koʻring yoki diagnostika kodini tekshiring.',
      'location_migration_blocked':
          'Server bu oʻzgarishni hozir amalga oshira olmaydi. Qurilma va uning mahalliy identifikatori saqlab qolindi.',
      'location_migration_slow':
          'Server hali $target joylashuviga oʻtishni tayyorlamoqda. Bir ozdan soʻng “Davom ettirish” tugmasidan foydalaning.',
      'location_migration_conflict':
          'Qurilma holati serverda oʻzgardi. Qurilmalarni yangilab, soʻng joylashuvni oʻzgartirishni davom ettiring.',
      'location_migration_verification_failed':
          'Server yangi joylashuvni tasdiqlamadi. Oldingi mahalliy identifikator saqlab qolindi.',
      'location_migration_device_changed':
          'Server qaytargan qurilma oʻzgartirilayotgan qurilmaga mos kelmaydi. Qaytadan urinishdan oldin qurilmalarni yangilang.',
      'tunnel_stop_failed':
          'Yangi ulanishdan oldin avvalgi tunnel butunlay toʻxtatilishi kerak.',
      'device_clock_ahead':
          'Qurilma soati oldinga ketgan koʻrinadi. Hisobingizga kirgan holda qolish uchun avtomatik sana va vaqtni yoqing.',
      'other':
          'Amalni bajarib boʻlmadi. Qayta urinib koʻring yoki diagnostika kodini qoʻllab-quvvatlash xizmatiga yuboring.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Seans muddati tugadi',
      'invalid_credentials': 'Hisobga kirib boʻlmadi',
      'email_verification_required': 'E-pochtani tasdiqlash talab qilinadi',
      'verification_email_cooldown': 'Xat allaqachon yuborilgan',
      'rate_limited': 'Urinishlar juda koʻp',
      'invalid_registration': 'Maʼlumotlarni tuzatish kerak',
      'email_exists': 'Hisob allaqachon mavjud',
      'invalid_profile': 'Profil notoʻgʻri',
      'invalid_device': 'Qurilma notoʻgʻri',
      'invalid_location': 'Joylashuv mavjud emas',
      'device_limit': 'Qurilmalar limitiga yetildi',
      'device_exists': 'VPN identifikatori allaqachon ishlatilmoqda',
      'device_identity_revoked': 'VPN identifikatorini yangilash kerak',
      'device_location_locked': 'Joylashuvni oʻzgartirishni yangilash kerak',
      'location_migration_pending': 'Joylashuvni oʻzgartirish davom etmoqda',
      'location_migration_blocked': 'Joylashuvni oʻzgartirish bloklandi',
      'target_ca_mismatch': 'OpenVPN serveri mos emas',
      'location_migration_conflict':
          'Joylashuvni oʻzgartirishni yangilash kerak',
      'server_full': 'Server toʻla',
      'capacity_unavailable': 'Joylashuv vaqtincha mavjud emas',
      'target_unavailable': 'Server vaqtincha mavjud emas',
      'not_found': 'Element topilmadi',
      'invalid_openvpn_csr': 'OpenVPN identifikatori notoʻgʻri',
      'openvpn_profile_exists': 'OpenVPN profili allaqachon mavjud',
      'openvpn_profile_revoked': 'OpenVPN profili bekor qilingan',
      'openvpn_operation_pending': 'OpenVPN amali bajarilmoqda',
      'openvpn_operation_terminal': 'OpenVPN amali uzildi',
      'openvpn_address_unavailable': 'OpenVPN manzili mavjud emas',
      'openvpn_profile_conflict': 'OpenVPN ziddiyati',
      'openvpn_signer_unavailable': 'OpenVPN mavjud emas',
      'email_delivery_unavailable': 'E-pochta xizmati mavjud emas',
      'invalid_token': 'Havola yaroqsiz',
      'network_unavailable': 'Internet ulanishi mavjud emas',
      'invalid_json': 'Soʻrov notoʻgʻri',
      'invalid_api_response': 'Server javobi notoʻgʻri',
      'ipv6_unavailable': 'IPv6 mavjud emas',
      'invalid_ip_families': 'Tarmoq sozlamasi rad etildi',
      'other': 'Xizmat mavjud emas',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Seansingiz muddati tugadi. Qaytadan hisobga kiring.',
      'invalid_credentials': 'E-pochta manzili yoki parol notoʻgʻri.',
      'email_verification_required':
          'VPN qurilmasini qoʻshishdan oldin e-pochta manzilingizni tasdiqlang.',
      'invalid_registration':
          'Soʻralgan maʼlumotlar va roziliklarni tekshiring.',
      'email_exists': 'Bu e-pochta manzili bilan allaqachon hisob mavjud.',
      'invalid_profile': 'Profil maʼlumotlaringizni tekshiring.',
      'invalid_device':
          'Bu qurilmaning nomi yoki mahalliy identifikatori notoʻgʻri.',
      'invalid_location':
          'Joylashuvlar roʻyxatini yangilab, qayta urinib koʻring.',
      'device_limit':
          'Boshqa qurilma qoʻshishdan oldin mavjud qurilmalardan birini olib tashlang.',
      'device_exists': 'Bu VPN identifikatori boshqa hisobga bogʻlangan.',
      'device_identity_revoked':
          'Bu identifikator olib tashlangan. Yangi mahalliy identifikator yaratish kerak.',
      'device_location_locked':
          'Bu qurilmaning joylashuvi endigina oʻzgardi. Ilova jarayondagi oʻzgartirishni davom ettiradi.',
      'location_migration_pending':
          'Joylashuvni oʻzgartirish allaqachon davom etmoqda.',
      'location_migration_blocked':
          'Joylashuvni oʻzgartirish uchun server aralashuvi talab qilinadi. Keyinroq qayta urinib koʻring yoki qoʻllab-quvvatlash xizmatiga murojaat qiling.',
      'target_ca_mismatch':
          'Bu server hozircha joriy OpenVPN profiliga mos emas.',
      'location_migration_conflict':
          'Qurilmalar roʻyxatini yangilab, joylashuvni qayta oʻzgartirib koʻring.',
      'server_full':
          'Bu joylashuvda ulanishlar limitiga yetilgan. Boshqa joylashuvni tanlang yoki keyinroq qayta urinib koʻring.',
      'capacity_unavailable':
          'Bu joylashuvning hozir mavjudligini tasdiqlab boʻlmayapti. Boshqa joylashuvni tanlang yoki keyinroq qayta urinib koʻring.',
      'target_unavailable': 'Bu server vaqtincha mavjud emas.',
      'not_found': 'Bu element hisobingizda endi mavjud emas.',
      'invalid_openvpn_csr':
          'Yangi OpenVPN identifikatorini yarating va qayta urinib koʻring.',
      'openvpn_profile_exists':
          'Bu qurilma uchun OpenVPN profili allaqachon mavjud.',
      'openvpn_profile_revoked':
          'Davom etish uchun OpenVPN profilini yangilang.',
      'openvpn_operation_pending':
          'Oʻzgarish hali tarqalmoqda. Keyinroq qayta urinib koʻring.',
      'openvpn_operation_terminal':
          'Yangi OpenVPN identifikatorini yarating va qayta urinib koʻring.',
      'openvpn_address_unavailable': 'Hozirda OpenVPN manzili mavjud emas.',
      'openvpn_profile_conflict':
          'Profil oʻzgardi. Qurilmalar roʻyxatini yangilab, qayta urinib koʻring.',
      'openvpn_signer_unavailable': 'OpenVPN xizmati vaqtincha mavjud emas.',
      'email_delivery_unavailable':
          'Xatni yuborib boʻlmadi. Keyinroq qayta urinib koʻring.',
      'invalid_token':
          'Bu havola yaroqsiz yoki muddati tugagan. Yangisini soʻrang.',
      'network_unavailable':
          'Internet ulanishingizni tekshirib, qayta urinib koʻring.',
      'invalid_json':
          'Kiritilgan maʼlumotlarni tekshirib, qayta urinib koʻring.',
      'invalid_api_response':
          'Server kutilmagan javob qaytardi. Keyinroq qayta urinib koʻring.',
      'ipv6_unavailable':
          'Server hozir IPv6’ni faollashtira olmaydi. Keyinroq qayta urinib koʻring.',
      'invalid_ip_families':
          'Tunnel sozlamasi toʻliq emas yoki ruxsat etilgan manzillarga mos kelmaydi. Ilovadan qayta urinib koʻring.',
      'other': 'Serverda xatolik yuz berdi. Keyinroq qayta urinib koʻring.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Bir ozdan soʻng qayta urinib koʻring.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds soniyadan keyin qayta urinib koʻring.',
      one: '$seconds soniyadan keyin qayta urinib koʻring.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes daqiqadan keyin qayta urinib koʻring.',
      one: '$minutes daqiqadan keyin qayta urinib koʻring.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours soatdan keyin qayta urinib koʻring.',
      one: '$hours soatdan keyin qayta urinib koʻring.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Tizim VPN’ini davom ettirib boʻlmaydi',
      'system_vpn_resume_corrupt':
          'Tizim VPN’ini davom ettirish maʼlumotlari notoʻgʻri',
      'system_vpn_resume_session_invalid':
          'VPN’ni davom ettirish seansi notoʻgʻri',
      'system_vpn_resume_identity_changed': 'VPN identifikatori oʻzgardi',
      'system_vpn_resume_identity_invalid':
          'VPN’ni davom ettirish identifikatori notoʻgʻri',
      'system_vpn_resume_storage_failed':
          'VPN’ni davom ettirish xotirasi mavjud emas',
      'system_vpn_resume_network_timeout':
          'VPN’ni davom ettirish uchun tarmoq yoʻq',
      'system_vpn_resume_blocked': 'VPN’ni davom ettirish bloklandi',
      'system_vpn_resume_failed': 'VPN’ni davom ettirib boʻlmadi',
      'system_vpn_resume_error_invalid':
          'VPN’ni davom ettirish xatosi notoʻgʻri',
      'wireguard_identity_store_failed': 'WireGuard identifikatori saqlanmadi',
      'wireguard_identity_unavailable': 'WireGuard identifikatori mavjud emas',
      'vpn_host_destroyed': 'Android VPN komponenti toʻxtatildi',
      'vpn_host_unavailable': 'Android VPN komponenti mavjud emas',
      'vpn_permission_required': 'VPN ruxsati talab qilinadi',
      'vpn_permission_denied': 'VPN ruxsati rad etildi',
      'vpn_permission_request_failed': 'Ruxsat soʻrab boʻlmadi',
      'wireguard_foreground_service_unavailable':
          'WireGuard xizmati mavjud emas',
      'wireguard_identity_invalid': 'Mahalliy WireGuard kaliti notoʻgʻri',
      'wireguard_identity_in_use':
          'WireGuard identifikatori allaqachon ishlatilmoqda',
      'wireguard_configuration_invalid': 'WireGuard sozlamalari notoʻgʻri',
      'wireguard_operation_pending': 'WireGuard amali hali faol',
      'wireguard_start_failed': 'WireGuard’ni ishga tushirish rad etildi',
      'wireguard_stop_timeout': 'WireGuard toʻxtatilishi tasdiqlanmadi',
      'wireguard_handshake_timeout': 'WireGuard javob bermadi',
      'openvpn_connection_timeout': 'OpenVPN javob bermadi',
      'openvpn_core_unavailable': 'OpenVPN dvigateli mavjud emas',
      'openvpn_operation_pending': 'OpenVPN seansi hali faol',
      'openvpn_stop_timeout': 'OpenVPN toʻxtatilishi tasdiqlanmadi',
      'openvpn_profile_unavailable': 'Mahalliy OpenVPN profili topilmadi',
      'openvpn_native_failed': 'OpenVPN ichki chaqiruvi uzildi',
      'openvpn_key_generation_failed':
          'OpenVPN P-256 kalitini yaratib boʻlmadi',
      'openvpn_csr_generation_failed': 'OpenVPN CSR’ni yaratib boʻlmadi',
      'openvpn_identity_store_failed': 'OpenVPN identifikatori saqlanmadi',
      'openvpn_identity_clear_failed':
          'OpenVPN identifikatori toʻliq oʻchirilmadi',
      'openvpn_identity_in_use': 'OpenVPN identifikatori hali ishlatilmoqda',
      'openvpn_tls_verification_required': 'OpenVPN TLS tekshiruvi yoʻq',
      'openvpn_cipher_invalid': 'OpenVPN shifri notoʻgʻri',
      'openvpn_profile_rejected': 'OpenVPN profili rad etildi',
      'openvpn_identity_inconsistent': 'OpenVPN identifikatori mos emas',
      'tls_handshake_failed': 'OpenVPN muzokarasi rad etildi',
      'tls_alert_unknown_ca': 'OpenVPN mijoz sertifikati tanilmadi',
      'tls_alert_bad_certificate': 'OpenVPN mijoz sertifikati rad etildi',
      'tls_alert_unsupported_certificate':
          'OpenVPN sertifikati qoʻllab-quvvatlanmaydi',
      'tls_client_certificate_required':
          'OpenVPN mijoz sertifikati talab qilinadi',
      'tls_alert_misc': 'OpenVPN TLS ogohlantirishi',
      'tls_signature_algorithm_rejected':
          'OpenVPN imzosi qoʻllab-quvvatlanmaydi',
      'tls_handshake_rejected': 'OpenVPN TLS muzokarasi rad etildi',
      'tls_version_rejected': 'OpenVPN TLS versiyasi mos emas',
      'tls_certificate_expired': 'TLS sertifikati muddati tugagan',
      'tls_certificate_revoked': 'TLS sertifikati bekor qilingan',
      'transport_failed': 'OpenVPN serveriga ulanib boʻlmadi',
      'tun_configuration_rejected': 'OpenVPN interfeysini yaratib boʻlmadi',
      'tun_setup_failed': 'OpenVPN TUN sozlamasi bajarilmadi',
      'tun_interface_create_failed': 'OpenVPN interfeysi yaratilmadi',
      'tun_interface_disabled': 'OpenVPN interfeysi oʻchirilgan',
      'tun_halted': 'OpenVPN interfeysi uzildi',
      'tun_already_established': 'OpenVPN interfeysi allaqachon ochiq',
      'tun_addresses_missing': 'OpenVPN manzili yoʻq',
      'tun_routes_missing': 'OpenVPN marshrutlari yoʻq',
      'tun_dns_missing': 'OpenVPN DNS’i yoʻq',
      'tun_permission_revoked': 'VPN ruxsati bekor qilingan',
      'tun_establish_returned_null': 'Android VPN interfeysini rad etdi',
      'openvpn_service_start_failed': 'OpenVPN xizmati mavjud emas',
      'openvpn_operation_timeout': 'OpenVPN chaqiruvi vaqti tugadi',
      'openvpn_start_failed': 'OpenVPN’ni ishga tushirish rad etildi',
      'openvpn_connection_failed': 'OpenVPN ulanishi uzildi',
      'openvpn_core_status_error': 'OpenVPN Core xato bilan tugadi',
      'openvpn_stopped_before_connected': 'OpenVPN ulanishdan oldin toʻxtadi',
      'openvpn_auth_failed': 'OpenVPN autentifikatsiyasi rad etildi',
      'openvpn_client_setup_failed': 'OpenVPN mijozini sozlab boʻlmadi',
      'openvpn_client_halted': 'OpenVPN mijozi uzildi',
      'openvpn_client_restart': 'OpenVPN qayta ishga tushirilishi soʻraldi',
      'openvpn_inactive_timeout': 'OpenVPN uzoq vaqt faol emas',
      'openvpn_session_expired': 'OpenVPN seansi muddati tugagan',
      'openvpn_credentials_required':
          'OpenVPN autentifikatsiyasi qoʻllab-quvvatlanmaydi',
      'openvpn_proxy_failed': 'OpenVPN oraliq transporti ishlamadi',
      'openvpn_compression_failed': 'OpenVPN siqish rad etildi',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM shifrlash mavjud emas',
      'openvpn_feature_unsupported':
          'OpenVPN funksiyasi qoʻllab-quvvatlanmaydi',
      'network_unavailable': 'Internet ulanishi mavjud emas',
      'network_lost': 'Tarmoq mavjud emas',
      'certificate_validation_failed': 'Server sertifikati rad etildi',
      'openvpn_certificate_expired': 'OpenVPN sertifikati muddati tugagan',
      'tunnel_active_for_another_account': 'Boshqa hisobning tunneli hali faol',
      'tunnel_already_active': 'Ichki tunnel allaqachon faol',
      'tunnel_stop_timeout': '$protocol toʻxtatilishi tasdiqlanmadi',
      'tunnel_disconnected': '$protocol uzildi',
      'native_bridge_unavailable': 'Android koʻprigi mavjud emas',
      'native_operation_failed': 'Android amali uzildi',
      'invalid_arguments': 'VPN parametrlari toʻliq emas',
      'invalid_account_id': 'VPN hisobi notoʻgʻri',
      'invalid_device_id': 'Qurilma identifikatori notoʻgʻri',
      'storage_key_not_allowed': 'Xotira kaliti rad etildi',
      'secure_storage_read_failed': 'Xavfsiz oʻqib boʻlmadi',
      'secure_storage_write_failed': 'Xavfsiz yozib boʻlmadi',
      'key_generation_failed': 'WireGuard kalitini yaratib boʻlmadi',
      'csr_generation_failed': 'OpenVPN CSR’ni yaratib boʻlmadi',
      'openvpn_recovery_exhausted': 'OpenVPN’ni tiklash allaqachon ishlatilgan',
      'openvpn_recovery_failed': 'OpenVPN’ni tiklab boʻlmadi',
      'openvpn_renewal_required':
          'OpenVPN sertifikatini yangilash talab qilinadi',
      'other': 'Tasniflanmagan ichki VPN xatosi',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android davom ettirish mumkin boʻlgan VPN seansini topa olmadi. Ilovada yangi ulanishni boshlang.',
      'system_vpn_resume_corrupt':
          'VPN’ni davom ettirish uchun saqlangan maʼlumotlar notoʻgʻri va ishlatilmaydi. Yangi ulanishni boshlang.',
      'system_vpn_resume_session_invalid':
          'Saqlangan seans endi VPN’ni davom ettira olmaydi. Ilovada hisobga qayta kiring.',
      'system_vpn_resume_identity_changed':
          'Mahalliy VPN identifikatori oʻzgardi. Davom ettirish toʻxtatildi; yangi ulanishni boshlang.',
      'system_vpn_resume_identity_invalid':
          'Davom ettirish uchun identifikator notoʻgʻri. Yangi ulanishni boshlang.',
      'system_vpn_resume_storage_failed':
          'Android davom ettirish uchun shifrlangan maʼlumotlarni oʻqiy yoki yangilay olmadi. Yangi ulanishni boshlang.',
      'system_vpn_resume_network_timeout':
          'Android VPN’ni davom ettirish uchun vaqtida tarmoq topa olmadi. Tarmoq mavjud boʻlganda qayta urinib koʻring.',
      'system_vpn_resume_blocked':
          'VPN’ni davom ettirish bloklangan. Android sozlamalarini tekshiring, soʻng yangi ulanishni boshlang.',
      'system_vpn_resume_failed':
          'Android VPN’ni davom ettira olmadi. Ilovada yangi ulanishni boshlang.',
      'system_vpn_resume_error_invalid':
          'Android yaroqsiz davom ettirish xatosini qaytardi. Yangi ulanishni boshlang.',
      'wireguard_identity_store_failed':
          'Android bu hisobning shifrlangan WireGuard identifikatorini saqlay olmadi.',
      'wireguard_identity_unavailable':
          'Bu ulanish uchun yaroqli WireGuard identifikatori mavjud emas.',
      'vpn_host_destroyed':
          'VPN’ni boshqaradigan Android komponenti toʻxtatildi. Yangi ulanishni boshlang.',
      'vpn_host_unavailable':
          'Android VPN’ni boshqaradigan komponentni yarata olmaydi. VPN sozlamalarini tekshirib, qayta urinib koʻring.',
      'openvpn_renewal_required':
          'Ulanishdan oldin sertifikat boʻyicha ilovada amal bajarish talab qilinadi.',
      'openvpn_recovery_failed':
          'Avtomatik tiklab boʻlmadi. Ilovada yangi ulanishni boshlang.',
      'openvpn_recovery_exhausted':
          'Avtomatik tiklash allaqachon ishlatilgan. Ilovada yangi ulanishni boshlang.',
      'vpn_permission_required':
          'Tunnelni ishga tushirishdan oldin Android yangi VPN ruxsatini talab qiladi.',
      'vpn_permission_denied':
          'Davom etish uchun Android soʻrovida FuzeVPN’ga ruxsat bering.',
      'vpn_permission_request_failed':
          'Android VPN ruxsati ekranini ocha olmadi.',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard xizmatini oldingi planda saqlay olmadi.',
      'wireguard_identity_invalid':
          'Bu hisobning shifrlangan WireGuard kaliti oʻqib boʻlmaydigan yoki notoʻgʻri.',
      'wireguard_identity_in_use':
          'Boshqa amal hali bu hisobning WireGuard kalitidan foydalanmoqda.',
      'wireguard_configuration_invalid':
          'Qabul qilingan WireGuard manzili, DNS, server kaliti yoki marshrutlari notoʻgʻri.',
      'wireguard_operation_pending':
          'Oldingi WireGuard amali hali ichki xizmatini boʻshatmagan.',
      'wireguard_start_failed':
          'WireGuard dvigateli sozlamani faollashtirishni rad etdi.',
      'wireguard_stop_timeout':
          'WireGuard xizmati belgilangan vaqt ichida VPN interfeysini boʻshatganini tasdiqlamadi.',
      'wireguard_handshake_timeout':
          'Tunnel belgilangan vaqtda server bilan xavfsiz almashinuvni tasdiqlamadi.',
      'openvpn_connection_timeout':
          'OpenVPN belgilangan vaqtda serverga ulanishni tasdiqlamadi.',
      'openvpn_core_unavailable':
          'Bu ilova versiyasida yaroqli OpenVPN dvigateli mavjud emas.',
      'openvpn_operation_pending':
          'Ichki dvigatel hali oldingi OpenVPN seansini ushlab turibdi va ikkinchisini yaratishni rad etadi.',
      'openvpn_stop_timeout':
          'OpenVPN Core belgilangan vaqt ichida ichki seansi toʻxtaganini va yoʻq qilinganini tasdiqlamadi.',
      'openvpn_profile_unavailable':
          'Bu ulanish uchun tasdiqlangan OpenVPN profilini oʻqib boʻlmaydi.',
      'openvpn_native_failed':
          'Ilova xatosi OpenVPN’ni uzdi. Qayta ulanib koʻring. Muammo davom etsa, diagnostikani ishga tushiring.',
      'openvpn_key_generation_failed':
          'Android Keystore eksport qilib boʻlmaydigan P-256 shaxsiy kalitini yarata yoki oʻqiy olmadi.',
      'openvpn_csr_generation_failed':
          'Android Keystore kaliti OpenVPN sertifikat soʻrovini imzolay olmadi.',
      'openvpn_identity_store_failed':
          'OpenVPN sertifikati yoki profili shifrlangan xotirada saqlanmadi.',
      'openvpn_identity_clear_failed':
          'Android bu hisob uchun mahalliy OpenVPN identifikatorining hammasini oʻchira olmadi.',
      'openvpn_identity_in_use':
          'Ichki OpenVPN seansi hali bu qurilmaning kaliti yoki sertifikatidan foydalanmoqda.',
      'openvpn_tls_verification_required':
          'Profilda server sertifikatini tekshirish aniq talab qilinmagan.',
      'openvpn_cipher_invalid':
          'Server ruxsat etilgan roʻyxatda boʻlmagan shifrlash algoritmini yubordi.',
      'openvpn_profile_rejected':
          'Serverdan olingan profil mos emas. Qurilmani qayta yaratib, yana urinib koʻring.',
      'openvpn_identity_inconsistent':
          'Sertifikat bu telefonning xavfsiz identifikatoriga mos kelmaydi. Mahalliy profil almashtirilmadi.',
      'tls_handshake_failed':
          'Server TLS muzokarasini rad etdi. Muammo davom etsa, profilni qayta yarating.',
      'tls_alert_unknown_ca':
          'Server bu qurilma sertifikatini chiqargan sertifikat organini (CA) tanimaydi. OpenVPN serverini tekshirish kerak.',
      'tls_alert_bad_certificate':
          'Server bu qurilma sertifikatini rad etdi. Qayta urinishdan oldin qurilmani qayta yarating.',
      'tls_alert_unsupported_certificate':
          'Server Android ishlatadigan xavfsiz sertifikat turini qoʻllab-quvvatlamaydi.',
      'tls_client_certificate_required':
          'Server mijoz sertifikatini talab qiladi, ammo OpenVPN Core uni taqdim eta olmadi.',
      'tls_alert_misc':
          'Server sertifikat va versiya toifalariga kirmaydigan TLS ogohlantirishini qaytardi.',
      'tls_signature_algorithm_rejected':
          'Server Android Keystore kalitining ECDSA P-256 algoritmini rad etdi.',
      'tls_handshake_rejected':
          'Server ulanishdan oldin TLS muzokarasini uzdi.',
      'tls_version_rejected':
          'Mijoz va server umumiy TLS versiyasini topa olmadi.',
      'tls_certificate_expired':
          'Ulanish vaqtida taqdim etilgan sertifikat muddati tugagan.',
      'tls_certificate_revoked':
          'Ulanish vaqtida taqdim etilgan sertifikat bekor qilingan.',
      'transport_failed':
          'OpenVPN serveri joriy tarmoqda javob bermayapti. Bir ozdan soʻng qayta urinib koʻring.',
      'tun_configuration_rejected':
          'Android OpenVPN soʻragan tarmoq sozlamasini rad etdi.',
      'tun_setup_failed':
          'OpenVPN Core Android interfeysini yaratishdan oldin tarmoq rejasini rad etdi.',
      'tun_interface_create_failed':
          'OpenVPN Core Android VpnService’dan TUN interfeysini ola olmadi.',
      'tun_interface_disabled':
          'Ulanish vaqtida Android yoki OpenVPN Core TUN interfeysini oʻchirib qoʻydi.',
      'tun_halted': 'OpenVPN Core TUN interfeysini toʻxtatish soʻrovini oldi.',
      'tun_already_established':
          'OpenVPN bir xil ulanishda ikkinchi interfeysni soʻradi. Xavfsizlik uchun tunnel toʻxtatildi.',
      'tun_addresses_missing': 'Server yaroqli tunnel manzilini bermadi.',
      'tun_routes_missing': 'Server yaroqli tunnel marshrutlarini bermadi.',
      'tun_dns_missing': 'Server yaroqli DNS serverini bermadi.',
      'tun_permission_revoked':
          'Android ulanish vaqtida VPN ruxsatini bekor qildi.',
      'tun_establish_returned_null':
          'Android interfeysni yaratmadi, odatda boshqa VPN hali faol boʻlgani uchun.',
      'openvpn_service_start_failed':
          'Android OpenVPN xizmatini oldingi planda ishga tushira olmadi.',
      'openvpn_operation_timeout':
          'OpenVPN Core’ga JNI chaqiruvi belgilangan maksimal vaqtdan oshib ketdi.',
      'openvpn_start_failed':
          'Android xizmati tayyor, ammo OpenVPN Core profilni ishga tushirishni qabul qilmadi.',
      'openvpn_connection_failed':
          'OpenVPN Core CONNECTED hodisasini yuborishdan oldin toʻxtadi.',
      'openvpn_core_status_error':
          'Ichki OpenVPN sikli xato bilan tugadi va aniqroq yakuniy hodisa boʻlmadi.',
      'openvpn_stopped_before_connected':
          'Ichki OpenVPN sikli CONNECTED holatidan oldin, aniq Core xatosisiz toʻxtadi.',
      'openvpn_auth_failed':
          'OpenVPN serveri profil autentifikatsiyasini rad etdi.',
      'openvpn_client_setup_failed':
          'OpenVPN Core tarmoq ulanishidan oldin mijozni ishga tushira olmadi.',
      'openvpn_client_halted':
          'OpenVPN Core mijozni yakuniy toʻxtatish buyrugʻini oldi.',
      'openvpn_client_restart':
          'OpenVPN Core transport seansini qayta ishga tushirishni soʻradi.',
      'openvpn_inactive_timeout':
          'OpenVPN Core faolsizlik vaqti tugagach seansni yopdi.',
      'openvpn_session_expired':
          'Server OpenVPN seansi muddati tugaganini xabar qildi.',
      'openvpn_credentials_required':
          'Server yoki proksi bu sertifikat profiliga kirmaydigan interaktiv kirish maʼlumotlarini soʻramoqda.',
      'openvpn_proxy_failed':
          'OpenVPN Core sozlangan proksi yoki oraliq uzatgich ishlamayotganini xabar qildi.',
      'openvpn_compression_failed':
          'OpenVPN Core profil yoki server eʼlon qilgan siqish rejimini rad etdi.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil bu versiyada mavjud boʻlmagan NTLM shifrlashni soʻraydi.',
      'openvpn_feature_unsupported':
          'Profil yoki server bu Android mijozida mavjud boʻlmagan funksiyani talab qiladi.',
      'network_unavailable':
          'Foydalanish mumkin boʻlgan jismoniy tarmoq mavjud emas.',
      'network_lost': 'Tarmoq uzilgandan soʻng tunnel toʻxtatildi.',
      'certificate_validation_failed':
          'OpenVPN serverining identifikatori tasdiqlanmadi.',
      'openvpn_certificate_expired':
          'Qayta ulanishdan oldin OpenVPN profilini yangilang.',
      'tunnel_active_for_another_account':
          'Bu ulanishdan oldin boshqa hisobga tegishli tunnel toʻxtatilishi kerak.',
      'tunnel_already_active':
          'Android oldingi VPN seansi hali interfeysdan foydalanayotganini xabar qiladi.',
      'tunnel_stop_timeout':
          '$protocol dvigateli belgilangan vaqt ichida VPN interfeysini boʻshatganini tasdiqlamadi.',
      'tunnel_disconnected':
          'Ichki dvigatel ishga tushgandan soʻng tunnel kutilmaganda tugaganini xabar qildi.',
      'native_bridge_unavailable':
          'Ilova Android VPN xizmatiga kira olmaydi. Ilovani yopib, qayta oching va yana urinib koʻring.',
      'native_operation_failed':
          'Ilova xatosi VPN amalini uzdi. Qayta urinib koʻring. Muammo davom etsa, diagnostikani ishga tushiring.',
      'invalid_arguments':
          'Bu VPN amali uchun zarur maʼlumotlar toʻliq emas. Qayta urinib koʻring. Muammo davom etsa, diagnostikani ishga tushiring.',
      'invalid_account_id':
          'Ichki amal yaroqli hisob identifikatoriga bogʻlanmagan.',
      'invalid_device_id':
          'Ichki dvigatelga yuborilgan qurilma identifikatori yoʻq yoki notoʻgʻri.',
      'storage_key_not_allowed':
          'Android koʻprigi ruxsat etilgan xotira roʻyxatidan tashqaridagi kalitni blokladi.',
      'secure_storage_read_failed':
          'Android Keystore bu hisobning mahalliy maʼlumotlarini deshifrlay olmadi.',
      'secure_storage_write_failed':
          'Android Keystore mahalliy maʼlumotlarni shifrlay yoki saqlay olmadi.',
      'key_generation_failed':
          'Android xavfsiz xotirada WireGuard kalitini yarata yoki oʻqiy olmadi.',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR’ni yarata yoki imzolay olmadi.',
      'other':
          'Hujjatlashtirilmagan ichki kod yoʻli ishlamay qoldi. Quyida koʻrsatilgan diagnostika kodini qoʻllab-quvvatlash xizmatiga yuboring.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Ruxsat soʻrovi allaqachon ochiq';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN ruxsati soʻrovi allaqachon koʻrsatilmoqda. Qayta urinishdan oldin uni yakunlang.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN ruxsati soʻrovi toʻxtatildi';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Ilova javobni olishdan oldin VPN ruxsati oynasi yopildi.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN ulanishi tasdiqlanmadi';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN ulanishini tasdiqlab boʻlmadi. Xavfsizlik uchun u toʻxtatildi. Qayta urinib koʻring.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profili bekor qilindi';

  @override
  String get openvpnCleanup_working =>
      'Bekor qilingan OpenVPN profili toʻxtatilmoqda va oʻchirilmoqda…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN’ning toʻxtatilishi tasdiqlanmadi. Yangi profil yaratishdan oldin qayta urinib koʻring.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Bekor qilingan OpenVPN profilini toʻliq oʻchirib boʻlmadi. Tozalashni takrorlang.';

  @override
  String get openvpnCleanup_complete =>
      'Bekor qilingan OpenVPN profili oʻchirildi. Yangisini yaratish uchun Ulanish tugmasini bosing.';

  @override
  String get network_title => 'Tarmoq sozlamalari';

  @override
  String get network_ipv4Fallback =>
      'IPv6 vaqtincha mavjud emas. Tayyorlash IPv4 bilan davom etmoqda.';

  @override
  String get network_rejectedTitle => 'Tarmoq sozlamasi rad etildi';

  @override
  String get network_rejectedMessage =>
      'Tunnel sozlamasi toʻliq emas yoki ruxsat etilgan manzillarga mos kelmaydi. Ilovadan qayta urinib koʻring.';

  @override
  String get network_unreadableTitle => 'Mahalliy sozlamani oʻqib boʻlmaydi';

  @override
  String get network_unreadableMessage =>
      'Saqlangan OpenVPN tarmoq sozlamasidan foydalanib boʻlmaydi. Uni yangilash uchun ilovadan qayta ulaning.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Tarmoq himoyasi';

  @override
  String get protection_subtitle =>
      'VPN uzilsa, Internetga toʻgʻridan-toʻgʻri kirishni bloklang.';

  @override
  String get protection_active => 'Tizim himoyasi faol';

  @override
  String get protection_alwaysOnOnly =>
      'Doimiy VPN yoqilgan; VPN’siz ulanishlarni bloklashni yoqing';

  @override
  String get protection_inactive => 'Tizim himoyasi faol emas';

  @override
  String get protection_unknown => 'Tizim himoyasini tekshiring';

  @override
  String get protection_openSettings => 'Android sozlamalarini ochish';

  @override
  String get protection_dialogTitle => 'Tarmoq himoyasini sozlang';

  @override
  String get protection_dialogMessage =>
      'Android doimiy VPN va VPN’siz ulanishlarni bloklashni boshqaradi. FuzeVPN tanlanganini tekshiring va tizim sozlamalarida bloklashni yoqing.';

  @override
  String get protection_dialogOpen => 'Sozlamalarni ochish';

  @override
  String get session_systemProtectionNote =>
      'Agar Android hali ham VPN’siz trafikni bloklayotgan boʻlsa, bu himoyani tekshirish yoki oʻzgartirish uchun tizim sozlamalarini oching.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Ilova diagnostikasi';

  @override
  String get diagnostics_automaticTitle => 'Muhim xatolarni yuborish';

  @override
  String get diagnostics_automaticDescription =>
      'Muhim xato yuz berganda qisqa texnik hisobot yuboriladi.';

  @override
  String get diagnostics_privacy =>
      'Yuborilgan hisobotlar hisobingizga bogʻlanadi va 30 kun davomida saqlanadi. Ularda brauzer tarixi, parollar yoki VPN kalitlari boʻlmaydi.';

  @override
  String get diagnostics_manualOpen => 'Diagnostikani ishga tushirish';

  @override
  String get diagnostics_localDescription =>
      'Ilova va VPN holati hisobotini yarating. Ulanishingiz oʻzgarmaydi.';

  @override
  String get diagnostics_sendReport => 'Hisobotni yuborish';

  @override
  String get diagnostics_sendHint =>
      'Hisobotni shu qurilmada saqlash uchun bu katakchani belgilamasdan qoldiring.';

  @override
  String get diagnostics_signedOut =>
      'Hisobot yuborish uchun hisobingizga kiring.';

  @override
  String get diagnostics_localLifetime =>
      'Ilova yopilgandan keyin ham saqlanib qolishi uchun hisobotni telefoningizga saqlang.';

  @override
  String get diagnostics_run => 'Diagnostikani ishga tushirish';

  @override
  String get diagnostics_rerun => 'Diagnostikani qayta ishga tushirish';

  @override
  String get diagnostics_running => 'Tekshirilmoqda…';

  @override
  String get diagnostics_sending => 'Hisobot yuborilmoqda…';

  @override
  String get diagnostics_prepared => 'Hisobot shu qurilmada tayyor';

  @override
  String get diagnostics_queued => 'Hisobot yuborilishni kutmoqda';

  @override
  String get diagnostics_sent => 'Hisobot qabul qilindi';

  @override
  String get diagnostics_failed =>
      'Yuborish amalga oshmadi. Mahalliy hisobot hali ham mavjud.';

  @override
  String get diagnostics_preparationFailed =>
      'Diagnostika hisobotini tayyorlab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get diagnostics_authenticationRequired =>
      'Hisobotni yuborish uchun qayta kiring.';

  @override
  String get diagnostics_retry => 'Qayta yuborish';

  @override
  String get diagnostics_export => 'Hisobotni saqlash';

  @override
  String get diagnostics_exportFailed =>
      'Eksport qilib boʻlmadi. Mahalliy hisobotdan qayta urinib koʻring.';

  @override
  String get diagnostics_preferenceFailed =>
      'Bu sozlamani saqlab boʻlmadi. Qayta urinib koʻring.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Hisobot kodi: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date kuni qabul qilingan';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date gacha saqlanadi';
  }

  @override
  String get diagnostics_duplicate => 'Bu hisobot avval qabul qilingan edi.';

  @override
  String get diagnostics_preview => 'Hisobotni oldindan koʻrish';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ta texnik hodisa biriktirilgan',
      one: '1 ta texnik hodisa biriktirilgan',
      zero: 'Texnik hodisalar biriktirilmagan',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Texnik tafsilotlar';

  @override
  String get diagnostics_empty => 'Hali diagnostika hisoboti tayyorlanmagan.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunnel holati',
      'handshake': 'Ulanishni tasdiqlash',
      'certificate': 'VPN sertifikati',
      'kill_switch': 'Android himoyasi',
      'connectivity': 'Mavjud tarmoq',
      'api_reachability': 'Xizmatga ulanish',
      'secure_storage': 'Xavfsiz saqlash',
      'other': 'Mahalliy tekshiruv',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Tekshirildi',
      'failed': 'Diqqat talab qiladi',
      'skipped': 'Sinalmagan — faol tekshiruv yoʻq',
      'unknown': 'Maʼlumot mavjud emas',
      'other': 'Maʼlumot mavjud emas',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN’ga xush kelibsiz';

  @override
  String get connection_changeLocation => 'Joylashuvni oʻzgartirish';

  @override
  String get connection_details => 'Ulanish tafsilotlari';

  @override
  String get locations_searchLabel => 'Shahar yoki mamlakatni qidirish';

  @override
  String get locations_clearSearch => 'Qidiruvni tozalash';

  @override
  String get locations_filterAll => 'Barchasi';

  @override
  String get locations_filterFavorites => 'Sevimlilar';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ta joylashuv',
      one: '$count ta joylashuv',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Joylashuvlar topilmadi';

  @override
  String get locations_noResultsHint =>
      'Boshqa shahar yoki mamlakatni sinab koʻring.';

  @override
  String get locations_noFavorites => 'Sevimli joylashuvlaringiz shu yerda';

  @override
  String get locations_noFavoritesHint =>
      'Joylashuv yonidagi yulduzchani bosib, uni shu yerda saqlang.';

  @override
  String get locations_showAll => 'Barcha joylashuvlarni koʻrish';

  @override
  String locations_addFavorite(String name) {
    return 'Sevimlilarga qoʻshish: $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Sevimlilardan olib tashlash: $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Sevimli joylashuvni saqlab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get locations_emptyTitle => 'Joylashuvlar mavjud emas';

  @override
  String get locations_emptyHint =>
      'Qayta urinib koʻrish uchun roʻyxatni yangilang.';

  @override
  String get devices_manage => 'Qurilmalarimni boshqarish';

  @override
  String get settings_personalization => 'Oʻzingizga moslang';

  @override
  String get settings_safety => 'Himoya';

  @override
  String get settings_help => 'Yordam kerakmi?';

  @override
  String get settings_about => 'FuzeVPN haqida';

  @override
  String get diagnostics_heading => 'Ulanish muammosini tushunish';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Mavjud',
      'pending': 'Tayyorlanmoqda',
      'revoked': 'Olib tashlangan',
      'expired': 'Muddati tugagan',
      'other': 'Holat mavjud emas',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Sozlama saqlanmadi';

  @override
  String get notice_preferenceSave_message =>
      'Tanlovingiz hozircha qoʻllanilgan, ammo saqlanmadi. Ilovani yopgandan keyin ham saqlab qolish uchun qayta urinib koʻring.';

  @override
  String get connection_androidDisconnectHint =>
      'Agar Android VPN’ni faol holda ushlab tursa, ochiladigan sozlamalarda Doimiy VPN’ni oʻchiring.';

  @override
  String get protection_learnMore => 'Android himoyasi haqida bilib oling';

  @override
  String get protection_guideWhy =>
      'Bu himoya VPN uzilganda ilovalarning Internetga toʻgʻridan-toʻgʻri ulanishiga yoʻl qoʻymaydi. U Android’da sozlanadi.';

  @override
  String get protection_guideAlwaysOnTitle => 'Doimiy VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN xizmatini doimiy yoniq saqlaydi va telefon qayta yoqilgandan keyin uni qayta ishga tushirishi mumkin.';

  @override
  String get protection_guideBlockTitle => 'VPN’siz ulanishlarni bloklash';

  @override
  String get protection_guideBlock =>
      'Bu sozlama ulanish uzilib qolgan vaqtda ham trafikning VPN’siz oʻtib ketishiga yoʻl qoʻymaydi.';

  @override
  String get protection_guideWarning =>
      'Bu bloklash yoqilgan boʻlsa, VPN ulanmaguncha Internetga kirib boʻlmaydi.';

  @override
  String get protection_guideStepsTitle => 'Himoyani yoqish';

  @override
  String get protection_guideStep1 =>
      'Quyidagi tugma orqali Android VPN sozlamalarini oching.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN yonidagi tishli gʻildirak belgisi orqali sozlamalarni oching.';

  @override
  String get protection_guideStep3 =>
      'Agar mavjud boʻlsa, “Doimiy VPN”ni, soʻng “VPN’siz ulanishlarni bloklash”ni yoqing.';

  @override
  String get protection_guideManufacturers =>
      'Nomlar telefon modeliga qarab farq qilishi mumkin. Kerak boʻlsa, “Sozlamalar”da “VPN”ni qidiring — odatda “Tarmoq va internet” boʻlimida boʻladi.';

  @override
  String get protection_guideDisableTitle => 'Bu himoyani oʻchirish';

  @override
  String get protection_guideDisable =>
      'Xuddi shu sozlamalarda VPN’siz ulanishlarni bloklashni oʻchiring, shunda VPN’siz Internetdan foydalanish mumkin boʻladi. Agar Android uni qayta ishga tushirishini istamasangiz, “Doimiy VPN”ni ham oʻchiring.';

  @override
  String get protection_guideManual =>
      'Bu sozlamalarni Android’da oʻzingiz tanlaysiz. FuzeVPN ularni siz uchun oʻzgartirmaydi.';

  @override
  String get locations_changeTitle => 'Joylashuvni oʻzgartirasizmi?';

  @override
  String locations_changeActive(String name) {
    return 'VPN uziladi, soʻng $name joylashuviga ulanishga urinadi.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name joylashuviga ulanishga urinadi.';
  }

  @override
  String get locations_confirmChange => 'Oʻzgartirish va ulanish';

  @override
  String get locations_changeBusy =>
      'Oʻzgartirish davom etmoqda. Boshqa joylashuvni tanlashdan oldin kuting.';

  @override
  String get locations_automaticSelection => 'Avtomatik tanlash';

  @override
  String get locations_cities => 'Shaharlar';

  @override
  String get locations_servers => 'Serverlar';

  @override
  String locations_viewCities(String name) {
    return '$name shaharlarini koʻrish';
  }

  @override
  String locations_viewServers(String name) {
    return '$name serverlarini koʻrish';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ta mamlakat',
      one: '$count ta mamlakat',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ta shahar',
      one: '$count ta shahar',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ta server',
      one: '$count ta server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Barcha mamlakatlar';

  @override
  String get locations_backToCountries => 'Mamlakatlarga qaytish';

  @override
  String locations_backToCities(String name) {
    return '$name shaharlariga qaytish';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Tanlash: $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Tanlash: $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Mos keladigan server mavjud emas.';

  @override
  String get externalLink_failed =>
      'Bu havolani ochib boʻlmadi. Uni nusxalab, brauzeringizda ochishingiz mumkin.';

  @override
  String get externalLink_copy => 'Havolani nusxalash';

  @override
  String get externalLink_copied => 'Havola nusxalandi';

  @override
  String get externalLink_copyFailed =>
      'Havolani nusxalab boʻlmadi. Quyidagi manzilni belgilang.';

  @override
  String get settings_deleteAccount => 'Hisobimni oʻchirish';

  @override
  String get settings_deleteAccountDetail =>
      'Hisobni oʻchirish soʻrovi tartibini koʻrish';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'VPN obunangizni tanlang.';

  @override
  String get billing_subscribe => 'Obuna boʻlish';

  @override
  String get billing_choosePlan => 'Davom etish uchun tarifni tanlang.';

  @override
  String get billing_monthly => 'Oylik';

  @override
  String get billing_yearly => 'Yillik';

  @override
  String get billing_continue => 'Google Play orqali davom etish';

  @override
  String get billing_restore => 'Xaridlarni tiklash';

  @override
  String get billing_manage => 'Obunani boshqarish';

  @override
  String get billing_deleteAccountWarning =>
      'Agar Google Play obunangiz boʻlsa, FuzeVPN hisobingizni oʻchirish uning avtomatik yangilanishini bekor qilmaydi. Yangilanishni Google Play’da alohida boshqaring yoki bekor qiling.';

  @override
  String get billing_deleteAccountContinue =>
      'Hisobni oʻchirish soʻroviga oʻtish';

  @override
  String get billing_refresh => 'Kirish huquqini yangilash';

  @override
  String get billing_loadingPlans => 'Tariflar yuklanmoqda…';

  @override
  String get billing_unavailable =>
      'Hozircha tariflar mavjud emas. Keyinroq qayta urinib koʻring.';

  @override
  String get billing_comingSoon => 'Obunalar tez orada mavjud boʻladi.';

  @override
  String get billing_priceDisclosure =>
      'Narx Google Play tomonidan taqdim etiladi. Yakuniy summa va amaldagi soliqlar tasdiqlashdan oldin koʻrsatiladi.';

  @override
  String get billing_renewalMonthly =>
      'Bekor qilinmasa, har oy avtomatik yangilanadi. Istalgan vaqtda Google Play obunalarida bekor qilishingiz mumkin.';

  @override
  String get billing_renewalYearly =>
      'Bekor qilinmasa, har yili avtomatik yangilanadi. Istalgan vaqtda Google Play obunalarida bekor qilishingiz mumkin.';

  @override
  String get billing_active => 'Premium kirish huquqingiz faol';

  @override
  String billing_accessUntil(String date) {
    return 'Kirish huquqi $date gacha amal qiladi.';
  }

  @override
  String get billing_webManaged =>
      'Obunangiz FuzeVPN veb-saytida boshqariladi.';

  @override
  String get billing_playManaged =>
      'Obunangiz Google Play tomonidan boshqariladi.';

  @override
  String get billing_playOnHold =>
      'Google Play obunangiz toʻxtatilgan yoki toʻlovni kutmoqda. Uni Google Play’da tuzatish uchun “Obunani boshqarish”ni oching.';

  @override
  String get billing_playReceiptUnlinked =>
      'Bu Google Play hisobida FuzeVPN hisobingiz uchun faol boʻlmagan Fuze Premium obunasi bor. Uni Google Play’da koʻrib chiqish uchun “Obunani boshqarish”ni oching.';

  @override
  String get billing_inactive => 'Faol obuna yoʻq.';

  @override
  String get billing_checkingAccess => 'Kirish huquqingiz tekshirilmoqda…';

  @override
  String get billing_restoring => 'Xaridlar tiklanmoqda…';

  @override
  String get billing_pending =>
      'Toʻlov kutilmoqda. Tasdiqlangandan soʻng kirish huquqingiz faollashadi.';

  @override
  String get billing_cancelled =>
      'Xarid bekor qilindi. Yangi obuna faollashtirilmadi.';

  @override
  String get billing_verifying => 'Xarid tekshirilmoqda…';

  @override
  String get billing_success =>
      'Obuna faollashtirildi. Premium kirish huquqingiz tayyor.';

  @override
  String get billing_restored => 'Xaridlaringiz tiklandi.';

  @override
  String get billing_restoreEmpty =>
      'Bu Google Play hisobi uchun tiklanadigan xaridlar yoʻq.';

  @override
  String get billing_catalogError =>
      'Tariflarni yuklab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get billing_purchaseError =>
      'Xaridni boshlab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get billing_verificationError =>
      'Xaridni tekshirish vaqtincha mavjud emas. Qayta urinish uchun xaridlarni tiklang.';

  @override
  String get billing_restoreError =>
      'Xaridlarni tiklab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get billing_managementError =>
      'Obunani boshqarishni ochib boʻlmadi. Qayta urinib koʻring.';

  @override
  String get billing_storeUnavailable =>
      'Bu qurilmada Google Play mavjud emas.';

  @override
  String get welcome_title => 'VPN’ingiz — sodda va qulay.';

  @override
  String get welcome_description =>
      'Ulanishingizni himoya qiling. Maxfiyligingizni oʻz nazoratingizda saqlang.';

  @override
  String get welcome_start => 'Boshlash';

  @override
  String get welcome_alreadyPurchased => 'Allaqachon sotib olganmisiz?';

  @override
  String get welcome_noAccountRequired => 'Boshlash uchun hisob kerak emas.';

  @override
  String get guest_accountTitle => 'Hisob bogʻlanmagan';

  @override
  String get guest_accountDescription =>
      'Obunangizdan boshqa qurilmada foydalanish uchun xuddi shu Google Play hisobi bilan xaridlaringizni tiklang.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Allaqachon obunachimisiz? Hisobga kiring';

  @override
  String get guest_claimTitle => 'FuzeVPN’ni hamma joyda ishlating';

  @override
  String get guest_claimDescription =>
      'Obunangizdan boshqa qurilmalaringizda foydalanish uchun hisob yarating. Bu qadam ixtiyoriy.';

  @override
  String get guest_skip => 'Keyinroq';

  @override
  String get guest_activationTitle => 'Fuze Premium faol';

  @override
  String get guest_activationDescription =>
      'Obunangiz tayyor. VPN’dan foydalaning va istalgan vaqtda hisob yarating.';

  @override
  String get guest_useVpn => 'VPN’dan foydalanish';

  @override
  String get guest_loginRequired =>
      'Bu xarid allaqachon FuzeVPN hisobiga bogʻlangan. Obunangizdan foydalanish uchun oʻsha hisobga kiring.';

  @override
  String get guest_signOutWarning =>
      'Xuddi shu Google Play hisobi bilan xaridlarni tiklab, obunangizni qaytarib olishingiz mumkin.';

  @override
  String get guest_profileUnavailable =>
      'Hisobingiz allaqachon bogʻlangan. Tafsilotlarni koʻrish va boshqarish uchun hisobga kiring.';

  @override
  String get billing_acceptance =>
      'Davom etish orqali foydalanish shartlari va maxfiylik siyosatiga rozilik bildirasiz.';

  @override
  String get guest_verifyEmailReminder =>
      'Hisobingizni himoyalash uchun e-pochta manzilingizni tasdiqlang. VPN’dan foydalanishda davom etishingiz mumkin.';

  @override
  String get guest_serviceUnavailable =>
      'Xizmat vaqtincha mavjud emas. Biroz vaqtdan soʻng qayta urinib koʻring.';

  @override
  String get guest_restoreError =>
      'Xaridlaringizni tiklab boʻlmadi. Xarid uchun ishlatilgan Google Play hisobi bilan qayta urinib koʻring.';

  @override
  String get guest_claimSuccess =>
      'Hisobingiz yaratildi. Obunangiz va VPN’ga kirish huquqingiz saqlanib qoldi.';

  @override
  String get guest_emailExists =>
      'Bu e-pochta manzili allaqachon band. Boshqa manzil tanlang yoki mavjud hisobingizga kiring. Xaridingiz Google Play orqali mavjud boʻlib qoladi.';

  @override
  String get guest_claimError =>
      'Hisobingizni yaratib boʻlmadi. VPN’dan foydalanishda davom etishingiz va keyinroq qayta urinib koʻrishingiz mumkin.';

  @override
  String get guest_secureStorageError =>
      'Seansingizni bu qurilmada himoyalab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get guest_premiumRequired =>
      'VPN’ni faollashtirish uchun obunani tanlang.';

  @override
  String get welcome_viewPlans => 'Tariflarni koʻrish';

  @override
  String get google_continue => 'Google orqali davom etish';

  @override
  String get google_or => 'yoki';

  @override
  String get google_title => 'FuzeVPN hisobingiz';

  @override
  String get google_settingUp => 'Hisobingizni yaratishni yakunlang';

  @override
  String get google_country => 'Yashash mamlakati';

  @override
  String get google_profileDescription =>
      'FuzeVPN hisobingizni yaratish uchun mamlakatingizni tanlang va ikkala hujjat bilan tanishib chiqing.';

  @override
  String get google_claimDescription =>
      'Mehmon hisobingizni Google’ga bogʻlang. Obunangiz va qurilmangiz shu hisobga bogʻlangan holda qoladi.';

  @override
  String get google_linkTitle => 'Google’ni FuzeVPN’ga bogʻlash';

  @override
  String get google_linkDescription =>
      'Mavjud FuzeVPN hisobingizga kirishni tasdiqlang. Bu qadamda Google parolingiz soʻralmaydi.';

  @override
  String get google_password => 'FuzeVPN paroli';

  @override
  String get google_linkAccount => 'Bogʻlashni tasdiqlash';

  @override
  String get google_requestEmail => 'Tasdiqlash xatini yuborish';

  @override
  String get google_emailInstructions =>
      'FuzeVPN’dan kelgan e-pochtani oching va tasdiqlash kodini kiriting.';

  @override
  String get google_emailCode => 'E-pochta tasdiqlash kodi';

  @override
  String get google_confirmEmail => 'Kodni tasdiqlash';

  @override
  String get google_restart => 'Boshqa Google hisobini tanlash';

  @override
  String get google_resume => 'Bu urinishni tekshirish';

  @override
  String get google_unavailable =>
      'Google orqali kirish mavjud emas. E-pochta va parol orqali kirishingiz mumkin.';

  @override
  String get google_expired =>
      'Bu urinish muddati tugagan. Uni bekor qilib, qaytadan boshlang.';

  @override
  String get google_conflict =>
      'Bu Google hisobi boshqa joyda allaqachon bogʻlangan. Joriy hisobingiz va obunangiz saqlanib qoladi.';

  @override
  String get google_error =>
      'Google orqali kirib boʻlmadi. Qayta urinib koʻring; joriy kirish huquqingiz saqlanib qoladi.';

  @override
  String get google_uncertain =>
      'Natija tasdiqlanmadi. Qayta boshlashdan oldin bu urinishni tekshiring yoki bekor qiling.';

  @override
  String get google_cancelFailed =>
      'Bekor qilish tasdiqlanmadi. Bu ekrandan chiqishdan oldin yana bekor qilib koʻring.';

  @override
  String get google_cancelled => 'Google orqali kirish bekor qilindi.';

  @override
  String get google_selecting => 'Google hisobingizni tanlang…';

  @override
  String get google_verifying => 'Hisobingiz tekshirilmoqda…';

  @override
  String get google_emailUnavailable =>
      'Tasdiqlash xatini yuborib boʻlmadi. Keyinroq qayta urinib koʻring.';

  @override
  String get google_emailSent =>
      'Tasdiqlash xati yuborildi. Pochta qutingizni tekshiring.';

  @override
  String get google_rateLimited =>
      'Iltimos, qayta urinishdan oldin biroz kuting.';

  @override
  String get google_busy =>
      'Boshqa amal bajarilayotganda (VPN ulanishi, hisob yoki mehmon) Google mavjud emas. Amal tugagach, qayta urinib koʻring; joriy kirish huquqingiz saqlanib qoladi.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN paroli notoʻgʻri. Joriy hisobingiz saqlanib qoladi.';

  @override
  String get google_invalidCode =>
      'Tasdiqlash kodi notoʻgʻri yoki muddati tugagan.';

  @override
  String get google_accountChanged =>
      'Seansingiz oʻzgardi. Qayta boshlashdan oldin bu urinishni bekor qiling.';

  @override
  String get google_invalidResponse =>
      'Javobni tasdiqlab boʻlmadi. Joriy kirish huquqingiz saqlanib qoladi.';

  @override
  String get google_invalidRegistration =>
      'Mamlakatingizni va ikkala rozilikni tekshiring.';

  @override
  String get google_consentRequired =>
      'Davom etish uchun mamlakatingizni tanlang va ikkala hujjatni qabul qiling.';

  @override
  String get google_challengeRequired =>
      'Qoʻshimcha xavfsizlik tekshiruvi talab qilinadi. Joriy kirish huquqingiz saqlanib qoladi.';

  @override
  String get google_challengeUnavailable =>
      'Xavfsizlik tekshiruvi mavjud emas. Keyinroq qayta urinib koʻring.';

  @override
  String get google_intentMismatch =>
      'Oldingi Google orqali kirish urinishi hali kutilmoqda. Bu amalni boshlashdan oldin uni bekor qiling.';

  @override
  String get google_challengeBlocked =>
      'Talab qilinadigan xavfsizlik tekshiruvi bu ilovada mavjud emas. Bu amalni hozir yakunlab boʻlmaydi.';

  @override
  String get google_solveChallenge => 'Xavfsizlik tekshiruvidan oʻting';

  @override
  String get google_challengeTitle => 'Xavfsizlik tekshiruvi';

  @override
  String get google_challengeReady =>
      'Tekshiruv yakunlandi. Endi hisob yaratishni tasdiqlashingiz mumkin.';

  @override
  String get google_challengeExpired =>
      'Tekshiruv muddati tugadi. Tasdiqlashdan oldin uni qayta bajaring.';

  @override
  String get google_challengeCancelled =>
      'Tekshiruv bekor qilindi. Uni qayta bajarishingiz mumkin.';

  @override
  String get google_challengeFailed =>
      'Xavfsizlik tekshiruvi amalga oshmadi. Qayta urinib koʻring.';

  @override
  String get billing_trialTitle => 'Fuze Premium’ni bepul sinab koʻring';

  @override
  String get billing_trialSubtitle =>
      'Ulanishingizni bugundan boshlab himoya qiling.';

  @override
  String get billing_trialWeeks => '2 haftalik bepul sinov';

  @override
  String billing_trialDays(String days) {
    return '$days kunlik bepul sinov';
  }

  @override
  String get billing_trialStart => 'Bepul sinovni boshlash';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Bugun boshlasangiz, birinchi toʻlov $date sanasida kutiladi.';
  }

  @override
  String get billing_trialTerms =>
      'Koʻrsatilgan narxda avtomatik yangilanadi. Toʻlov yechilmasligi uchun sinov muddati tugashidan oldin Google Play’da bekor qiling.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Keyin oyiga $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Keyin yiliga $price';
  }

  @override
  String get billing_choosePeriod => 'Tarifingizni tanlang';

  @override
  String get billing_selectionHint => 'Davom etish uchun tarifni tanlang.';

  @override
  String get billing_benefitConnection => 'Shifrlangan ulanish';

  @override
  String get billing_benefitPrivacy => 'Onlayn maxfiylik';

  @override
  String get billing_benefitNoAccount => 'Roʻyxatdan oʻtish shart emas';

  @override
  String get billing_cancellation => 'Google Play’da bekor qilish';

  @override
  String get billing_premiumTitle => 'Yaxshiroq himoyalangan ulanish.';

  @override
  String get billing_premiumSubtitle =>
      'Ulanishingizni oʻzingizga qulay tarzda himoya qiling.';

  @override
  String get billing_priceMonthly => 'oyiga';

  @override
  String get billing_priceYearly => 'yiliga';

  @override
  String get billing_trialToday => 'Bugun toʻlash shart emas';

  @override
  String get billing_trialConfirmation =>
      'Google Play sanalar, yakuniy summa va amaldagi soliqlarni tasdiqlashdan oldin koʻrsatadi.';

  @override
  String get billing_offerChanged =>
      'Bu taklifning shartlari oʻzgardi. Tariflarni yangilab, yana tanlang.';

  @override
  String get status_waitingNetwork => 'Tarmoq kutilmoqda';

  @override
  String get status_waitingNetworkDetail =>
      'Tarmoq mavjud emas. Tarmoq qaytgach, VPN ulanishni tekshiradi.';

  @override
  String get locations_favoriteLoadFailed =>
      'Sevimlilarni yuklab boʻlmadi. Qayta urinib koʻring.';

  @override
  String get locations_favoritesLoading => 'Sevimlilar yuklanmoqda…';
}
