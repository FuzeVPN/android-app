// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Bağlantınızı qoruyun';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN bu cihaz ilə FuzeVPN serverləri arasında şifrələnmiş tunel yaratmaq üçün Android-in VPN xidmətindən (VpnService) istifadə edir.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN aktiv olduqda, tətbiqlərinizin internet trafiki, təyinat ünvanları və DNS sorğuları bağlantınızı yönləndirmək üçün bu tunel vasitəsilə ötürülür, hətta FuzeVPN arxa planda olduqda da.';

  @override
  String get vpnDisclosure_statusBody =>
      'Tətbiq VPN bağlantınızı göstərmək üçün bağlantı vəziyyətindən, müddətindən və ötürülən məlumat həcmindən istifadə edir. Onu istənilən vaxt dayandıra bilərsiniz.';

  @override
  String get vpnDisclosure_privacy => 'Məxfilik';

  @override
  String get vpnDisclosure_accept => 'Qəbul edin və davam edin';

  @override
  String get vpnDisclosure_decline => 'İndi yox';

  @override
  String get accountRestoration_title => 'Hesab müvəqqəti əlçatan deyil';

  @override
  String get accountRestoration_message =>
      'Sessiyanız saxlanılıb. Hesabınızı bərpa etmək üçün yenidən cəhd edin. VPN bağlantısını buradan yenə də idarə edə bilərsiniz.';

  @override
  String get action_retry => 'Yenidən cəhd edin';

  @override
  String get session_endingTitle => 'Sessiya sonlandırılır';

  @override
  String get session_ending =>
      'Sessiya sonlandırılır: VPN dayandırılır və təmizlənir…';

  @override
  String get session_stopFailed =>
      'VPN-in dayandırılması təsdiqlənməyib. Yenidən daxil olmazdan əvvəl bir daha cəhd edin.';

  @override
  String get session_cleanupFailed =>
      'VPN dayandırılıb, lakin sessiyanın silinməsi təsdiqlənməyib. Təmizləməni təkrarlayın.';

  @override
  String get session_retryStop => 'Dayandırmanı təkrarlayın';

  @override
  String get session_retryCleanup => 'Təmizləməni təkrarlayın';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN təhlükəsiz şəkildə hazırlanır…';

  @override
  String get nav_connection => 'Bağlantı';

  @override
  String get nav_locations => 'Məkanlar';

  @override
  String get nav_account => 'Hesab';

  @override
  String get nav_devices => 'Cihazlar';

  @override
  String get nav_settings => 'Ayarlar';

  @override
  String get action_refresh => 'Yeniləyin';

  @override
  String get auth_tab_login => 'Daxil olun';

  @override
  String get auth_tab_register => 'Qeydiyyatdan keçin';

  @override
  String get auth_stepAccount => 'Hesab';

  @override
  String get auth_stepIdentity => 'Şəxsi məlumatlar';

  @override
  String get auth_stepAddress => 'Ünvan və razılıqlar';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Addım $current / $total';
  }

  @override
  String get auth_tagline => 'VPN-iniz sadə və rahatdır.';

  @override
  String get auth_keysLocal => 'Şəxsi VPN açarlarınız bu cihazda qalır.';

  @override
  String get form_email => 'E-poçt ünvanı';

  @override
  String get form_password => 'Parol';

  @override
  String get form_showPassword => 'Parolu göstərin';

  @override
  String get form_hidePassword => 'Parolu gizlədin';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 bayt. Bəzi simvollar birdən çox bayt tutur.';

  @override
  String get form_firstName => 'Ad';

  @override
  String get form_lastName => 'Soyad';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Ünvan';

  @override
  String get form_address2 => 'Ünvanın 2-ci sətri (ixtiyari)';

  @override
  String get form_postalCode => 'Poçt indeksi';

  @override
  String get form_city => 'Şəhər';

  @override
  String get form_country => 'Ölkə kodu (məs., FR)';

  @override
  String get action_login => 'Daxil olun';

  @override
  String get action_createAccount => 'Hesab yaradın';

  @override
  String get action_createMyAccount => 'Hesabımı yaradın';

  @override
  String get action_next => 'Davam edin';

  @override
  String get action_previous => 'Geri';

  @override
  String get action_forgotPassword => 'Parolu unutmusunuz?';

  @override
  String get auth_noAccount => 'Hələ hesabınız yoxdur?';

  @override
  String get auth_requiredInformation => 'Hesabınızı üç addımda yaradın.';

  @override
  String get auth_termsPrefix => 'Qəbul edirəm: ';

  @override
  String get auth_termsLink => 'istifadə şərtləri';

  @override
  String get auth_privacyPrefix => 'Qəbul edirəm: ';

  @override
  String get auth_privacyLink => 'məxfilik siyasəti';

  @override
  String get auth_consentRequired =>
      'Hesab yaratmaq üçün razılığınız tələb olunur.';

  @override
  String get validation_required => 'Bu sahə məcburidir.';

  @override
  String get validation_email => 'Düzgün e-poçt ünvanı daxil edin.';

  @override
  String get validation_password =>
      'Parol çox qısadır: ən azı 8 UTF-8 bayt olmalıdır.';

  @override
  String get validation_passwordTooLong =>
      'Parol çox uzundur: ən çox 72 UTF-8 bayt ola bilər.';

  @override
  String get validation_phone =>
      'Beynəlxalq formatdan istifadə edin, məsələn, +33612345678.';

  @override
  String get validation_country =>
      'İki hərfli ölkə kodundan istifadə edin, məsələn, FR.';

  @override
  String get passwordReset_title => 'Parolu sıfırlayın';

  @override
  String get passwordReset_description =>
      'Parol sıfırlama keçidini istəmək üçün hesabınızın e-poçt ünvanını daxil edin.';

  @override
  String get passwordReset_send => 'Keçidi göndərin';

  @override
  String get connection_title => 'Bağlantınız';

  @override
  String get connection_subtitle => 'Məkan seçin, sonra VPN-i işə salın.';

  @override
  String get connection_prepare => 'Qoşulmağa hazırsınız?';

  @override
  String get connection_advancedOptions => 'Qabaqcıl seçimlər';

  @override
  String get connection_location => 'Məkan';

  @override
  String get connection_chooseLocation => 'Məkan seçin';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Qoşulun';

  @override
  String get connection_connecting => 'Qoşulur…';

  @override
  String get connection_disconnect => 'Bağlantını kəsin';

  @override
  String get connection_disconnecting => 'Bağlantı kəsilir';

  @override
  String get connection_locationChange => 'Məkan dəyişdirilir…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol əlçatan deyil';
  }

  @override
  String get connection_activeLocation => 'Aktiv məkan';

  @override
  String get connection_duration => 'Müddət';

  @override
  String get connection_received => 'Alınıb';

  @override
  String get connection_sent => 'Göndərilib';

  @override
  String get connection_lastHandshake => 'Son təhlükəsiz mübadilə';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration əvvəl';
  }

  @override
  String get verification_title => 'E-poçt ünvanınızı təsdiqləyin';

  @override
  String get verification_message =>
      'Bu telefonda VPN-dən istifadə etmək üçün e-poçt ünvanınızı təsdiqləyin.';

  @override
  String get verification_resend => 'E-poçtu yenidən göndərin';

  @override
  String get migration_title => 'Məkan dəyişikliyi';

  @override
  String get migration_draining => 'Məkan dəyişikliyi hazırlanır…';

  @override
  String get migration_activating => 'Yeni server aktivləşdirilir…';

  @override
  String get migration_ready => 'Məkan yeniləndi.';

  @override
  String get migration_blocked =>
      'Məkan dəyişikliyi server tərəfində müdaxilə tələb edir. Daha sonra yenidən cəhd edin və ya dəstək xidməti ilə əlaqə saxlayın.';

  @override
  String get migration_progress => 'Məkan dəyişikliyinin gedişi';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Yoxlamalar arasındakı fasilə: $seconds san.';
  }

  @override
  String get migration_resume => 'Məkan dəyişikliyini davam etdirin';

  @override
  String get status_authorizing => 'İcazə tələb olunur';

  @override
  String get status_authorizingDetail =>
      'VPN-ə icazə vermək üçün Android sorğusunu qəbul edin.';

  @override
  String get status_preparing => 'Hazırlanır';

  @override
  String get status_preparingDetail => 'Təhlükəsiz bağlantınız hazırlanır.';

  @override
  String get status_reconnecting => 'Yenidən qoşulur…';

  @override
  String get status_reconnectingDetail =>
      'Bağlantı pozuldu. VPN yenidən qoşulmağa çalışır.';

  @override
  String get status_connecting => 'Qoşulur';

  @override
  String get status_connectingDetail => 'VPN serverinə qoşulur…';

  @override
  String get status_connected => 'Qoşulub';

  @override
  String get status_connectedDetail => 'VPN bağlantınız aktivdir.';

  @override
  String get status_disconnecting => 'Bağlantı kəsilir';

  @override
  String get status_disconnectingDetail => 'VPN bağlantınız dayandırılır.';

  @override
  String get status_error => 'Bağlantı əlçatan deyil';

  @override
  String get status_errorDetail =>
      'VPN bağlantısı təsdiqlənməyib. Yenidən cəhd edin.';

  @override
  String get status_idle => 'Bağlantı kəsilib';

  @override
  String get status_idleDetail => 'Bağlantınızı qorumaq üçün VPN-ə qoşulun.';

  @override
  String get trust_note =>
      'Tətbiqi bağlamaq VPN-i dayandırmır. Onu dayandırmaq üçün Bağlantını kəsin düyməsindən istifadə edin.';

  @override
  String get locations_none => 'Hazırda əlçatan məkan yoxdur.';

  @override
  String get locations_available => 'Növbəti məkanınızı seçin.';

  @override
  String get locations_selected => 'Seçilmiş məkan';

  @override
  String get locations_select => 'Bu məkanı seçin';

  @override
  String get locations_lockedTunnel =>
      'Məkanı dəyişmək üçün VPN bağlantısını kəsin.';

  @override
  String get locations_lockedMigration =>
      'Məkan dəyişikliyi başa çatana qədər gözləyin.';

  @override
  String get devices_title => 'Cihazlarınız';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit cihaz';
  }

  @override
  String get devices_refresh => 'Cihazları yeniləyin';

  @override
  String get devices_empty => 'Hələ heç bir VPN cihazı qeydiyyatdan keçməyib.';

  @override
  String get devices_firstConnection =>
      'Telefonunuz ilk qoşulmada əlavə ediləcək.';

  @override
  String get devices_thisDevice => 'Bu cihaz';

  @override
  String devices_added(Object date) {
    return '$date tarixində əlavə edilib';
  }

  @override
  String get devices_unnamed => 'Adsız cihaz';

  @override
  String get action_remove => 'Çıxarın';

  @override
  String get settings_title => 'Ayarlar';

  @override
  String get settings_subtitle => 'Seçimləriniz və hesabınız bir yerdə.';

  @override
  String get settings_appearance => 'Görünüş';

  @override
  String get settings_language => 'Dil';

  @override
  String get settings_languageDescription =>
      'Seçdiyiniz dil VPN bildirişlərinə də tətbiq olunur.';

  @override
  String get settings_account => 'Hesab';

  @override
  String get settings_signOut => 'Hesabdan çıxın';

  @override
  String get settings_privacy => 'Məxfilik siyasəti';

  @override
  String get settings_terms => 'İstifadə şərtləri';

  @override
  String get settings_security => 'Təhlükəsizlik və şəffaflıq';

  @override
  String get settings_licenses => 'Komponent lisenziyaları';

  @override
  String get settings_licensesDetail =>
      'Tətbiqdə istifadə olunan proqram təminatı';

  @override
  String settings_licensesLegalese(String url) {
    return 'Tətbiqin və onun MPL-2.0 komponentlərinin mənbə kodu: $url';
  }

  @override
  String get settings_background =>
      'Tətbiqdən çıxdıqda VPN aktiv qalır. Onu dayandırmaq üçün Bağlantı sekməsindəki Bağlantını kəsin düyməsindən istifadə edin.';

  @override
  String get theme_system => 'Sistem';

  @override
  String get theme_light => 'Açıq';

  @override
  String get theme_dark => 'Tünd';

  @override
  String get language_system => 'Telefonun dili';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Bu cihazı çıxarmaq istəyirsiniz?';

  @override
  String get dialog_removeCurrent =>
      'Bu telefonun VPN bağlantısı kəsiləcək və girişi itiriləcək. Server təsdiq etdikdən sonra onun VPN bağlantı məlumatları silinəcək.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” üçün VPN girişi ləğv ediləcək. Bu əməliyyatı geri qaytarmaq mümkün deyil.';
  }

  @override
  String get dialog_signOut => 'Hesabdan çıxmaq istəyirsiniz?';

  @override
  String get dialog_signOutMessage =>
      'VPN dayandırılacaq və yenidən daxil olmalı olacaqsınız. Şifrələnmiş VPN açarlarınız növbəti qoşulmanız üçün bu telefonda qalacaq.';

  @override
  String get action_cancel => 'Ləğv edin';

  @override
  String get action_close => 'Bağlayın';

  @override
  String get action_copy => 'Kopyalayın';

  @override
  String get action_signOut => 'Hesabdan çıxın';

  @override
  String get notice_close => 'Mesajı bağlayın';

  @override
  String get notice_sessionExpired_title => 'Sessiyanın müddəti bitib';

  @override
  String get notice_sessionExpired_message =>
      'Sessiyanızın müddəti bitib. Yenidən daxil olun.';

  @override
  String get notice_connectionFailed_title => 'Bağlantı qurulmadı';

  @override
  String get notice_invalidCredentials_message =>
      'E-poçt ünvanı və ya parol yanlışdır.';

  @override
  String get notice_emailVerification_title => 'E-poçt təsdiqi tələb olunur';

  @override
  String get notice_emailVerification_message =>
      'VPN cihazı əlavə etməzdən əvvəl e-poçt ünvanınızı təsdiqləyin.';

  @override
  String get notice_rateLimited_title => 'Çox sayda cəhd';

  @override
  String get notice_deviceLimit_title => 'Cihaz limitinə çatılıb';

  @override
  String get notice_deviceLimit_message =>
      'Başqa cihaz əlavə etməzdən əvvəl mövcud cihazlardan birini çıxarın.';

  @override
  String get notice_identityRenewal_title => 'VPN kimliyi yenilənməlidir';

  @override
  String get notice_identityRenewal_message =>
      'Bu kimlik ləğv edilib. Yeni yerli kimlik yaradın.';

  @override
  String get notice_migrationPending_title => 'Məkan dəyişikliyi davam edir';

  @override
  String get notice_migrationPending_message =>
      'Məkan dəyişikliyi artıq davam edir.';

  @override
  String get notice_migrationBlocked_title => 'Məkan dəyişikliyi bloklanıb';

  @override
  String get notice_migrationBlocked_message =>
      'Məkan dəyişikliyi server tərəfində müdaxilə tələb edir. Daha sonra yenidən cəhd edin və ya dəstək xidməti ilə əlaqə saxlayın.';

  @override
  String get notice_targetUnavailable_title => 'Server müvəqqəti əlçatan deyil';

  @override
  String get notice_targetUnavailable_message =>
      'Bu server müvəqqəti əlçatan deyil.';

  @override
  String get notice_networkUnavailable_title => 'İnternet bağlantısı yoxdur';

  @override
  String get notice_networkUnavailable_message =>
      'Bağlantınızı yoxlayın və yenidən cəhd edin.';

  @override
  String get notice_permissionDenied_title => 'VPN icazəsi rədd edildi';

  @override
  String get notice_permissionDenied_message =>
      'Qoşulmanı yenidən başladın və Android icazə sorğusunu qəbul edin.';

  @override
  String get notice_wireguardTimeout_title => 'Server cavab vermir';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard bağlantısı çox uzun çəkdi. Yenidən cəhd edin və ya başqa məkan seçin.';

  @override
  String get notice_tlsFailed_title => 'Təhlükəsiz bağlantı rədd edildi';

  @override
  String get notice_tlsFailed_message =>
      'Server OpenVPN bağlantısını qəbul etmədi. Yenidən cəhd edin. Problem davam edərsə, diaqnostika aparın.';

  @override
  String get notice_tunRejected_title => 'Android VPN interfeysini rədd etdi';

  @override
  String get notice_tunRejected_message =>
      'Android OpenVPN-in tələb etdiyi şəbəkə konfiqurasiyasını rədd etdi.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN başlaya bilmədi';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN mühərrikinin işə salınması tamamlana bilmədi. Yenidən cəhd edin. Problem davam edərsə, dəstək xidməti ilə əlaqə saxlayın.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Diaqnostika kodu: $code';
  }

  @override
  String get notice_generic_title => 'VPN bağlantısı qurulmadı';

  @override
  String get notice_generic_message =>
      'Xəta baş verdi. Daha sonra yenidən cəhd edin.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Hesab yaradıldı',
      'password_reset_sent': 'Parolun sıfırlanması sorğusu alındı',
      'verification_email_sent': 'Təsdiq e-poçtu göndərildi',
      'location_migration_pending': 'Məkan dəyişikliyi davam edir',
      'vpn_sign_in_required': 'Daxil olmaq tələb olunur',
      'protocol_unavailable_at_location': 'Protokol əlçatan deyil',
      'vpn_permission_denied': 'VPN icazəsi rədd edildi',
      'revoked_identity_device_limit': 'Cihaz limitinə çatılıb',
      'tunnel_start_unexpected': 'VPN başlaya bilmədi',
      'flutter_disconnect_timeout': 'Bağlantının kəsilməsi təsdiqlənmədi',
      'flutter_disconnect_unexpected': 'Bağlantı kəsilə bilmədi',
      'device_revoked': 'Cihaz çıxarıldı',
      'revoke_unexpected': 'Cihaz çıxarıla bilmədi',
      'identity_renewal_unexpected': 'VPN kimliyi yenilənə bilmədi',
      'openvpn_renewal_unexpected': 'OpenVPN yenilənə bilmədi',
      'location_migration_blocked': 'Məkan dəyişikliyi bloklanıb',
      'location_migration_slow': 'Məkan dəyişikliyi hələ davam edir',
      'location_migration_conflict': 'Məkan dəyişikliyi yenilənməlidir',
      'location_migration_verification_failed':
          'Məkan dəyişikliyi təsdiqlənmədi',
      'location_migration_device_changed':
          'Məkan dəyişikliyi zamanı cihaz dəyişdi',
      'tunnel_stop_failed': 'Məkan dəyişikliyi əlçatan deyil',
      'device_clock_ahead': 'Cihazın saatı irəlidədir',
      'other': 'Əməliyyat uğursuz oldu',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Hesab yaradıldı, lakin təsdiq e-poçtu göndərilə bilmədi. Tətbiqdə e-poçtu yenidən göndərin.',
      'password_reset_sent':
          'Sorğunuz alındı. Bu ünvana uyğun hesab varsa, sizə e-poçt göndərilə bilər. Spam qovluğunu da yoxlayın.',
      'verification_email_sent': 'Yeni təsdiq e-poçtu indicə göndərildi.',
      'location_migration_pending':
          '$target məkanına keçid hələ hazırlanır. Cihazı yenidən yaratmadan davam etdirə bilərsiniz.',
      'vpn_sign_in_required': 'VPN-i başlatmazdan əvvəl hesabınıza daxil olun.',
      'protocol_unavailable_at_location':
          'Seçilmiş protokol bu məkanda mövcud deyil. Məkanları yeniləyin və ya başqa protokol seçin.',
      'vpn_permission_denied':
          'Android VPN icazəsini rədd etdi. Qoşulmanı yenidən başladın və sistem sorğusunu qəbul edin.',
      'revoked_identity_device_limit':
          'Bu cihazın VPN girişi ləğv edilib və cihaz limitinə çatılıb. Hesab → Cihazlarımı idarə edin bölməsində cihaz çıxarın.',
      'tunnel_start_unexpected':
          'Gözlənilməz xəta tunelin hazırlanmasına mane oldu. Diaqnostika kodunu yoxlayın və yenidən cəhd edin.',
      'flutter_disconnect_timeout':
          'Android VPN-in vaxtında dayandığını təsdiq etmədi. Yenidən dayandırmağa cəhd edin.',
      'flutter_disconnect_unexpected':
          'Gözlənilməz xəta tunelin dayandığını təsdiqləməyə imkan vermədi.',
      'device_revoked':
          'Cihazın VPN girişi ləğv edildi və onun yerli məxfi məlumatları silindi.',
      'revoke_unexpected':
          'Cihaz çıxarıla bilmədi. Siyahını yeniləyin və yenidən cəhd edin.',
      'identity_renewal_unexpected':
          'Yeni VPN kimliyi yaradıla bilmədi. Cihazları yeniləyin və yenidən cəhd edin.',
      'openvpn_renewal_unexpected':
          'OpenVPN profili yenilənə bilmədi. Yenidən cəhd edin və ya diaqnostika kodunu yoxlayın.',
      'location_migration_blocked':
          'Server bu dəyişikliyi hazırda tamamlaya bilməz. Cihaz və onun yerli kimliyi saxlanılıb.',
      'location_migration_slow':
          'Server hələ $target məkanına keçidi hazırlayır. Bir neçə andan sonra davam etdirin.',
      'location_migration_conflict':
          'Serverdə cihazın vəziyyəti dəyişib. Cihazları yeniləyin, sonra dəyişikliyi davam etdirin.',
      'location_migration_verification_failed':
          'Server yeni məkanı təsdiqləmədi. Əvvəlki yerli kimlik saxlanılıb.',
      'location_migration_device_changed':
          'Serverin qaytardığı cihaz dəyişdiriləcək cihaza artıq uyğun gəlmir. Yenidən cəhd etməzdən əvvəl cihazları yeniləyin.',
      'tunnel_stop_failed':
          'Yeni bağlantıdan əvvəl əvvəlki tunel tamamilə dayandırılmalıdır.',
      'device_clock_ahead':
          'Bu cihazın saatı irəli getmiş kimi görünür. Hesabda qalmaq üçün avtomatik tarix və vaxtı aktivləşdirin.',
      'other':
          'Əməliyyat tamamlana bilmədi. Yenidən cəhd edin və ya diaqnostika kodunu dəstək xidmətinə göndərin.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessiyanın müddəti bitib',
      'invalid_credentials': 'Giriş uğursuz oldu',
      'email_verification_required': 'E-poçt təsdiqi tələb olunur',
      'verification_email_cooldown': 'E-poçt artıq göndərilib',
      'rate_limited': 'Çox sayda cəhd',
      'invalid_registration': 'Məlumatları düzəldin',
      'email_exists': 'Hesab artıq mövcuddur',
      'invalid_profile': 'Etibarsız profil',
      'invalid_device': 'Etibarsız cihaz',
      'invalid_location': 'Məkan əlçatan deyil',
      'device_limit': 'Cihaz limitinə çatılıb',
      'device_exists': 'VPN kimliyi artıq istifadə olunur',
      'device_identity_revoked': 'VPN kimliyi yenilənməlidir',
      'device_location_locked': 'Məkan dəyişikliyi yenilənməlidir',
      'location_migration_pending': 'Məkan dəyişikliyi davam edir',
      'location_migration_blocked': 'Məkan dəyişikliyi bloklanıb',
      'target_ca_mismatch': 'Uyğunsuz OpenVPN serveri',
      'location_migration_conflict': 'Məkan dəyişikliyi yenilənməlidir',
      'server_full': 'Server doludur',
      'capacity_unavailable': 'Məkan müvəqqəti əlçatan deyil',
      'target_unavailable': 'Server müvəqqəti əlçatan deyil',
      'not_found': 'Element tapılmadı',
      'invalid_openvpn_csr': 'Etibarsız OpenVPN kimliyi',
      'openvpn_profile_exists': 'OpenVPN profili artıq mövcuddur',
      'openvpn_profile_revoked': 'OpenVPN profili ləğv edilib',
      'openvpn_operation_pending': 'OpenVPN əməliyyatı davam edir',
      'openvpn_operation_terminal': 'OpenVPN əməliyyatı kəsildi',
      'openvpn_address_unavailable': 'OpenVPN ünvanı əlçatan deyil',
      'openvpn_profile_conflict': 'OpenVPN konflikti',
      'openvpn_signer_unavailable': 'OpenVPN əlçatan deyil',
      'email_delivery_unavailable': 'E-poçt əlçatan deyil',
      'invalid_token': 'Etibarsız keçid',
      'network_unavailable': 'İnternet bağlantısı yoxdur',
      'invalid_json': 'Etibarsız sorğu',
      'invalid_api_response': 'Etibarsız server cavabı',
      'ipv6_unavailable': 'IPv6 əlçatan deyil',
      'invalid_ip_families': 'Şəbəkə konfiqurasiyası rədd edildi',
      'other': 'Xidmət əlçatan deyil',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessiyanızın müddəti bitib. Yenidən daxil olun.',
      'invalid_credentials': 'E-poçt ünvanı və ya parol yanlışdır.',
      'email_verification_required':
          'VPN cihazı əlavə etməzdən əvvəl e-poçt ünvanınızı təsdiqləyin.',
      'invalid_registration':
          'Tələb olunan məlumatları və razılıqları yoxlayın.',
      'email_exists': 'Bu e-poçt ünvanı ilə artıq hesab mövcuddur.',
      'invalid_profile': 'Profil məlumatlarınızı yoxlayın.',
      'invalid_device': 'Bu cihazın adı və ya yerli kimliyi etibarsızdır.',
      'invalid_location': 'Məkanlar siyahısını yeniləyin və yenidən cəhd edin.',
      'device_limit':
          'Başqa cihaz əlavə etməzdən əvvəl mövcud cihazlardan birini çıxarın.',
      'device_exists': 'Bu VPN kimliyi artıq başqa hesaba bağlıdır.',
      'device_identity_revoked':
          'Bu kimlik ləğv edilib. Yeni yerli kimlik yaradılmalıdır.',
      'device_location_locked':
          'Bu cihazın məkanı indicə dəyişib. Tətbiq hazırkı dəyişikliyi davam etdirəcək.',
      'location_migration_pending': 'Məkan dəyişikliyi artıq davam edir.',
      'location_migration_blocked':
          'Məkan dəyişikliyi server tərəfində müdaxilə tələb edir. Daha sonra yenidən cəhd edin və ya dəstək xidməti ilə əlaqə saxlayın.',
      'target_ca_mismatch':
          'Bu server hələ cari OpenVPN profili ilə uyğun gəlmir.',
      'location_migration_conflict':
          'Cihazları yeniləyin, sonra məkanı yenidən dəyişməyə çalışın.',
      'server_full':
          'Bu məkan bağlantı limitinə çatıb. Başqa məkan seçin və ya daha sonra yenidən cəhd edin.',
      'capacity_unavailable':
          'Bu məkanın hazırda əlçatan olub-olmadığını təsdiqləyə bilmirik. Başqa məkan seçin və ya daha sonra yenidən cəhd edin.',
      'target_unavailable': 'Bu server müvəqqəti əlçatan deyil.',
      'not_found': 'Bu element artıq hesabınızda əlçatan deyil.',
      'invalid_openvpn_csr':
          'Yeni OpenVPN kimliyi yaradın və yenidən cəhd edin.',
      'openvpn_profile_exists':
          'Bu cihaz üçün artıq OpenVPN profili mövcuddur.',
      'openvpn_profile_revoked':
          'Davam etmək üçün OpenVPN profilini yeniləyin.',
      'openvpn_operation_pending':
          'Dəyişiklik hələ yayılır. Daha sonra yenidən cəhd edin.',
      'openvpn_operation_terminal':
          'Yeni OpenVPN kimliyi yaradın və yenidən cəhd edin.',
      'openvpn_address_unavailable':
          'Hazırda heç bir OpenVPN ünvanı əlçatan deyil.',
      'openvpn_profile_conflict':
          'Profil dəyişib. Cihazları yeniləyin və yenidən cəhd edin.',
      'openvpn_signer_unavailable': 'OpenVPN xidməti müvəqqəti əlçatan deyil.',
      'email_delivery_unavailable':
          'E-poçt göndərilə bilmədi. Daha sonra yenidən cəhd edin.',
      'invalid_token':
          'Bu keçid etibarsızdır və ya müddəti bitib. Yenisini tələb edin.',
      'network_unavailable':
          'İnternet bağlantınızı yoxlayın və yenidən cəhd edin.',
      'invalid_json':
          'Daxil edilmiş məlumatları yoxlayın və yenidən cəhd edin.',
      'invalid_api_response':
          'Server gözlənilməz cavab qaytardı. Daha sonra yenidən cəhd edin.',
      'ipv6_unavailable':
          'Server hazırda IPv6-nı aktivləşdirə bilmir. Daha sonra yenidən cəhd edin.',
      'invalid_ip_families':
          'Tunel konfiqurasiyası natamamdır və ya icazəli ünvanlara uyğun gəlmir. Tətbiqdən yenidən cəhd edin.',
      'other': 'Server xətası baş verdi. Daha sonra yenidən cəhd edin.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Bir az sonra yenidən cəhd edin.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds saniyə sonra yenidən cəhd edin.',
      one: '$seconds saniyə sonra yenidən cəhd edin.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes dəqiqə sonra yenidən cəhd edin.',
      one: '$minutes dəqiqə sonra yenidən cəhd edin.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours saat sonra yenidən cəhd edin.',
      one: '$hours saat sonra yenidən cəhd edin.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Sistem VPN-in davam etdirilməsi əlçatan deyil',
      'system_vpn_resume_corrupt':
          'Sistem VPN-in davam etdirilməsi etibarsızdır',
      'system_vpn_resume_session_invalid':
          'VPN-in davam etdirilməsi üçün etibarsız sessiya',
      'system_vpn_resume_identity_changed': 'VPN kimliyi dəyişib',
      'system_vpn_resume_identity_invalid':
          'VPN-in davam etdirilməsi üçün etibarsız kimlik',
      'system_vpn_resume_storage_failed':
          'VPN-in davam etdirilməsi üçün yaddaş əlçatan deyil',
      'system_vpn_resume_network_timeout':
          'VPN-in davam etdirilməsi üçün şəbəkə yoxdur',
      'system_vpn_resume_blocked': 'VPN-in davam etdirilməsi bloklanıb',
      'system_vpn_resume_failed': 'VPN-in davam etdirilməsi uğursuz oldu',
      'system_vpn_resume_error_invalid':
          'VPN-in davam etdirilməsində etibarsız xəta',
      'wireguard_identity_store_failed': 'WireGuard kimliyi saxlanılmadı',
      'wireguard_identity_unavailable': 'WireGuard kimliyi əlçatan deyil',
      'vpn_host_destroyed': 'Android VPN komponenti dayandırılıb',
      'vpn_host_unavailable': 'Android VPN komponenti əlçatan deyil',
      'vpn_permission_required': 'VPN icazəsi tələb olunur',
      'vpn_permission_denied': 'VPN icazəsi rədd edildi',
      'vpn_permission_request_failed': 'İcazə sorğusu göndərilə bilmədi',
      'wireguard_foreground_service_unavailable':
          'WireGuard xidməti əlçatan deyil',
      'wireguard_identity_invalid': 'Etibarsız yerli WireGuard açarı',
      'wireguard_identity_in_use': 'WireGuard kimliyi artıq istifadə olunur',
      'wireguard_configuration_invalid': 'Etibarsız WireGuard konfiqurasiyası',
      'wireguard_operation_pending': 'WireGuard əməliyyatı hələ aktivdir',
      'wireguard_start_failed': 'WireGuard-ın işə salınması rədd edildi',
      'wireguard_stop_timeout': 'WireGuard-ın dayandırılması təsdiqlənmədi',
      'wireguard_handshake_timeout': 'WireGuard cavab vermədi',
      'openvpn_connection_timeout': 'OpenVPN cavab vermədi',
      'openvpn_core_unavailable': 'OpenVPN mühərriki əlçatan deyil',
      'openvpn_operation_pending': 'OpenVPN sessiyası hələ aktivdir',
      'openvpn_stop_timeout': 'OpenVPN-in dayandırılması təsdiqlənmədi',
      'openvpn_profile_unavailable': 'Yerli OpenVPN profili tapılmadı',
      'openvpn_native_failed': 'Daxili OpenVPN çağırışı kəsildi',
      'openvpn_key_generation_failed': 'OpenVPN P-256 açarı yaradıla bilmədi',
      'openvpn_csr_generation_failed': 'OpenVPN CSR yaradıla bilmədi',
      'openvpn_identity_store_failed': 'OpenVPN kimliyi saxlanılmadı',
      'openvpn_identity_clear_failed': 'OpenVPN-in silinməsi tamamlanmadı',
      'openvpn_identity_in_use': 'OpenVPN kimliyi hələ istifadə olunur',
      'openvpn_tls_verification_required': 'OpenVPN TLS yoxlaması yoxdur',
      'openvpn_cipher_invalid': 'Etibarsız OpenVPN şifrələmə üsulu',
      'openvpn_profile_rejected': 'OpenVPN profili rədd edildi',
      'openvpn_identity_inconsistent': 'Uyğunsuz OpenVPN kimliyi',
      'tls_handshake_failed': 'OpenVPN danışıqları rədd edildi',
      'tls_alert_unknown_ca': 'OpenVPN müştəri sertifikatı tanınmır',
      'tls_alert_bad_certificate': 'OpenVPN müştəri sertifikatı rədd edildi',
      'tls_alert_unsupported_certificate': 'Dəstəklənməyən OpenVPN sertifikatı',
      'tls_client_certificate_required':
          'OpenVPN müştəri sertifikatı tələb olunur',
      'tls_alert_misc': 'OpenVPN TLS xəbərdarlığı',
      'tls_signature_algorithm_rejected': 'Dəstəklənməyən OpenVPN imzası',
      'tls_handshake_rejected': 'OpenVPN TLS danışıqları rədd edildi',
      'tls_version_rejected': 'Uyğunsuz OpenVPN TLS versiyası',
      'tls_certificate_expired': 'TLS sertifikatının müddəti bitib',
      'tls_certificate_revoked': 'TLS sertifikatı ləğv edilib',
      'transport_failed': 'OpenVPN serverinə çatmaq mümkün deyil',
      'tun_configuration_rejected': 'OpenVPN interfeysi yaradıla bilmədi',
      'tun_setup_failed': 'OpenVPN TUN quraşdırması uğursuz oldu',
      'tun_interface_create_failed':
          'OpenVPN interfeysinin yaradılması uğursuz oldu',
      'tun_interface_disabled': 'OpenVPN interfeysi söndürülüb',
      'tun_halted': 'OpenVPN interfeysi kəsildi',
      'tun_already_established': 'OpenVPN interfeysi artıq açıqdır',
      'tun_addresses_missing': 'OpenVPN ünvanı yoxdur',
      'tun_routes_missing': 'OpenVPN marşrutları yoxdur',
      'tun_dns_missing': 'OpenVPN DNS-i yoxdur',
      'tun_permission_revoked': 'VPN icazəsi ləğv edilib',
      'tun_establish_returned_null': 'Android VPN interfeysini rədd etdi',
      'openvpn_service_start_failed': 'OpenVPN xidməti əlçatan deyil',
      'openvpn_operation_timeout': 'OpenVPN çağırışının vaxtı bitdi',
      'openvpn_start_failed': 'OpenVPN-in işə salınması rədd edildi',
      'openvpn_connection_failed': 'OpenVPN bağlantısı pozuldu',
      'openvpn_core_status_error': 'OpenVPN Core xəta ilə bitdi',
      'openvpn_stopped_before_connected': 'OpenVPN qoşulmadan dayandırıldı',
      'openvpn_auth_failed': 'OpenVPN autentifikasiyası rədd edildi',
      'openvpn_client_setup_failed':
          'OpenVPN müştərisinin hazırlanması uğursuz oldu',
      'openvpn_client_halted': 'OpenVPN müştərisi kəsildi',
      'openvpn_client_restart': 'OpenVPN-in yenidən başladılması tələb olunur',
      'openvpn_inactive_timeout': 'OpenVPN uzun müddət qeyri-aktiv qaldı',
      'openvpn_session_expired': 'OpenVPN sessiyasının müddəti bitib',
      'openvpn_credentials_required':
          'Dəstəklənməyən OpenVPN autentifikasiyası',
      'openvpn_proxy_failed': 'OpenVPN vasitəçi bağlantısı uğursuz oldu',
      'openvpn_compression_failed': 'OpenVPN sıxılma rejimi rədd edildi',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM şifrələməsi əlçatan deyil',
      'openvpn_feature_unsupported': 'Dəstəklənməyən OpenVPN funksiyası',
      'network_unavailable': 'İnternet bağlantısı yoxdur',
      'network_lost': 'Şəbəkə əlçatan deyil',
      'certificate_validation_failed': 'Server sertifikatı rədd edildi',
      'openvpn_certificate_expired': 'OpenVPN sertifikatının müddəti bitib',
      'tunnel_active_for_another_account': 'Başqa hesabın tuneli hələ aktivdir',
      'tunnel_already_active': 'Daxili tunel artıq aktivdir',
      'tunnel_stop_timeout':
          '$protocol bağlantısının dayandırılması təsdiqlənmədi',
      'tunnel_disconnected': '$protocol bağlantısı pozuldu',
      'native_bridge_unavailable': 'Android körpüsü əlçatan deyil',
      'native_operation_failed': 'Android əməliyyatı kəsildi',
      'invalid_arguments': 'Natamam VPN parametrləri',
      'invalid_account_id': 'Etibarsız VPN hesabı',
      'invalid_device_id': 'Etibarsız cihaz identifikatoru',
      'storage_key_not_allowed': 'Yaddaş açarı rədd edildi',
      'secure_storage_read_failed': 'Təhlükəsiz oxuma uğursuz oldu',
      'secure_storage_write_failed': 'Təhlükəsiz yazma uğursuz oldu',
      'key_generation_failed': 'WireGuard açarı yaradıla bilmədi',
      'csr_generation_failed': 'OpenVPN CSR yaradıla bilmədi',
      'openvpn_recovery_exhausted': 'OpenVPN bərpası artıq istifadə edilib',
      'openvpn_recovery_failed': 'OpenVPN bərpası uğursuz oldu',
      'openvpn_renewal_required':
          'OpenVPN sertifikatının yenilənməsi tələb olunur',
      'other': 'Təsnif edilməmiş daxili VPN xətası',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android davam etdirilə bilən VPN sessiyası tapa bilmir. Tətbiqdə yeni bağlantı başladın.',
      'system_vpn_resume_corrupt':
          'Saxlanılmış VPN davam etdirmə məlumatları etibarsızdır və istifadə edilməyəcək. Yeni bağlantı başladın.',
      'system_vpn_resume_session_invalid':
          'Saxlanılmış sessiya VPN-i artıq davam etdirə bilmir. Tətbiqdə yenidən daxil olun.',
      'system_vpn_resume_identity_changed':
          'Yerli VPN kimliyi dəyişib. Davam etdirmə dayandırıldı; yeni bağlantı başladın.',
      'system_vpn_resume_identity_invalid':
          'Davam etdirmək üçün kimlik etibarsızdır. Yeni bağlantı başladın.',
      'system_vpn_resume_storage_failed':
          'Android şifrələnmiş davam etdirmə məlumatlarını oxuya və ya yeniləyə bilmədi. Yeni bağlantı başladın.',
      'system_vpn_resume_network_timeout':
          'Android VPN-i davam etdirmək üçün vaxtında şəbəkə tapa bilmədi. Şəbəkə əlçatan olduqda yenidən cəhd edin.',
      'system_vpn_resume_blocked':
          'VPN-in davam etdirilməsi bloklanıb. Android ayarlarını yoxlayın, sonra yeni bağlantı başladın.',
      'system_vpn_resume_failed':
          'Android VPN-i davam etdirə bilmədi. Tətbiqdə yeni bağlantı başladın.',
      'system_vpn_resume_error_invalid':
          'Android istifadə oluna bilməyən davam etdirmə xətası qaytardı. Yeni bağlantı başladın.',
      'wireguard_identity_store_failed':
          'Android bu hesabın şifrələnmiş WireGuard kimliyini saxlaya bilmədi.',
      'wireguard_identity_unavailable':
          'Bu bağlantı üçün istifadə oluna bilən WireGuard kimliyi yoxdur.',
      'vpn_host_destroyed':
          'VPN-i işlədən Android komponenti dayandırıldı. Yeni bağlantı başladın.',
      'vpn_host_unavailable':
          'Android VPN-i işlədən komponenti yarada bilmir. VPN ayarlarını yoxladıqdan sonra yenidən cəhd edin.',
      'openvpn_renewal_required':
          'Qoşulmazdan əvvəl tətbiqdə sertifikat üçün tələb olunan addımı tamamlayın.',
      'openvpn_recovery_failed':
          'Avtomatik bərpa uğursuz oldu. Tətbiqdə yeni bağlantı başladın.',
      'openvpn_recovery_exhausted':
          'Avtomatik bərpa artıq istifadə edilib. Tətbiqdə yeni bağlantı başladın.',
      'vpn_permission_required':
          'Tuneli başlatmazdan əvvəl Android yeni VPN icazəsi tələb edir.',
      'vpn_permission_denied':
          'Davam etmək üçün Android sorğusunda FuzeVPN-ə icazə verin.',
      'vpn_permission_request_failed':
          'Android VPN icazə ekranını aça bilmədi.',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard xidmətini ön planda saxlaya bilmədi.',
      'wireguard_identity_invalid':
          'Bu hesabın şifrələnmiş WireGuard açarı oxuna bilmir və ya etibarsızdır.',
      'wireguard_identity_in_use':
          'Bu hesabın WireGuard açarından hələ başqa əməliyyat istifadə edir.',
      'wireguard_configuration_invalid':
          'Alınan WireGuard ünvanı, DNS, server açarı və ya marşrutlar etibarsızdır.',
      'wireguard_operation_pending':
          'Əvvəlki WireGuard əməliyyatı daxili xidməti hələ azad etməyib.',
      'wireguard_start_failed':
          'WireGuard mühərriki konfiqurasiyanın aktivləşdirilməsini rədd etdi.',
      'wireguard_stop_timeout':
          'WireGuard xidməti VPN interfeysinin azad edilməsini vaxt limitində təsdiqləmədi.',
      'wireguard_handshake_timeout':
          'Tunel serverlə əlaqənin qurulduğunu vaxtında təsdiqləmədi.',
      'openvpn_connection_timeout':
          'OpenVPN serverlə bağlantını vaxtında təsdiqləmədi.',
      'openvpn_core_unavailable':
          'Bu tətbiq versiyasında istifadə oluna bilən OpenVPN mühərriki yoxdur.',
      'openvpn_operation_pending':
          'Daxili mühərrik əvvəlki OpenVPN sessiyasını hələ saxlayır və ikinci sessiya yaratmağı rədd edir.',
      'openvpn_stop_timeout':
          'OpenVPN Core daxili sessiyanın dayandırıldığını və sonlandırıldığını vaxt limitində təsdiqləyə bilmədi.',
      'openvpn_profile_unavailable':
          'Bu bağlantı üçün oxuna bilən etibarlı OpenVPN profili yoxdur.',
      'openvpn_native_failed':
          'Tətbiqdəki xəta OpenVPN-i kəsdi. Yenidən qoşulmağa cəhd edin. Problem davam edərsə, diaqnostikanı işə salın.',
      'openvpn_key_generation_failed':
          'Android Keystore ixrac edilə bilməyən P-256 şəxsi açarını yarada və ya oxuya bilmədi.',
      'openvpn_csr_generation_failed':
          'Android Keystore açarı OpenVPN sertifikat sorğusunu (CSR) imzalaya bilmədi.',
      'openvpn_identity_store_failed':
          'OpenVPN sertifikatı və ya profili şifrələnmiş yaddaşda saxlanıla bilmədi.',
      'openvpn_identity_clear_failed':
          'Android bu hesabın yerli OpenVPN kimliyini tam silə bilmədi.',
      'openvpn_identity_in_use':
          'Daxili OpenVPN sessiyası hələ də bu cihazın açarından və ya sertifikatından istifadə edir.',
      'openvpn_tls_verification_required':
          'Profil server sertifikatının yoxlanılmasını açıq şəkildə tələb etmir.',
      'openvpn_cipher_invalid':
          'Server icazə verilən siyahıda olmayan şifrələmə alqoritmi təqdim etdi.',
      'openvpn_profile_rejected':
          'Serverdən alınan profil uyğun gəlmir. Bu cihazı yenidən yaradın və yenidən cəhd edin.',
      'openvpn_identity_inconsistent':
          'Sertifikat bu telefonun təhlükəsiz kimliyi ilə uyğun gəlmir. Heç bir yerli profil dəyişdirilmədi.',
      'tls_handshake_failed':
          'Server TLS danışıqlarını rədd etdi. Problem davam edərsə, profili yenidən yaradın.',
      'tls_alert_unknown_ca':
          'Server bu cihaz sertifikatını verən sertifikat orqanını tanımır. OpenVPN serveri yoxlanılmalıdır.',
      'tls_alert_bad_certificate':
          'Server bu cihaz sertifikatını rədd etdi. Yenidən cəhd etməzdən əvvəl cihazı yenidən yaradın.',
      'tls_alert_unsupported_certificate':
          'Server Android tərəfindən istifadə olunan təhlükəsiz sertifikat növünü dəstəkləmir.',
      'tls_client_certificate_required':
          'Server müştəri sertifikatı tələb edir, lakin OpenVPN Core onu təqdim edə bilmədi.',
      'tls_alert_misc':
          'Server sertifikat və versiya kateqoriyalarından kənar TLS xəbərdarlığı qaytardı.',
      'tls_signature_algorithm_rejected':
          'Server Android Keystore açarının ECDSA P-256 alqoritmini rədd etdi.',
      'tls_handshake_rejected':
          'Server qoşulmadan əvvəl TLS danışıqlarını yarımçıq kəsdi.',
      'tls_version_rejected':
          'Müştəri və server ortaq TLS versiyası tapa bilmədi.',
      'tls_certificate_expired':
          'Bağlantı zamanı təqdim edilən sertifikatın müddəti bitib.',
      'tls_certificate_revoked':
          'Bağlantı zamanı təqdim edilən sertifikat ləğv edilib.',
      'transport_failed':
          'OpenVPN serveri cari şəbəkədə cavab vermir. Bir az sonra yenidən cəhd edin.',
      'tun_configuration_rejected':
          'Android OpenVPN-in tələb etdiyi şəbəkə konfiqurasiyasını rədd etdi.',
      'tun_setup_failed':
          'OpenVPN Core Android interfeysini yaratmazdan əvvəl şəbəkə planını rədd etdi.',
      'tun_interface_create_failed':
          'OpenVPN Core Android VpnService-dən TUN interfeysini ala bilmədi.',
      'tun_interface_disabled':
          'Android və ya OpenVPN Core bağlantı zamanı TUN interfeysini söndürdü.',
      'tun_halted':
          'OpenVPN Core TUN interfeysini dayandırmaq üçün sorğu aldı.',
      'tun_already_established':
          'OpenVPN eyni bağlantıda ikinci interfeys tələb etdi. Təhlükəsizlik üçün tunel dayandırıldı.',
      'tun_addresses_missing':
          'Server istifadə oluna bilən tunel ünvanı təqdim etməyib.',
      'tun_routes_missing':
          'Server istifadə oluna bilən tunel marşrutları təqdim etməyib.',
      'tun_dns_missing':
          'Server istifadə oluna bilən DNS serveri təqdim etməyib.',
      'tun_permission_revoked':
          'Bağlantı zamanı Android VPN icazəsini ləğv etdi.',
      'tun_establish_returned_null':
          'Android interfeysi yaratmadı; adətən bunun səbəbi başqa VPN-in hələ də aktiv olmasıdır.',
      'openvpn_service_start_failed':
          'Android OpenVPN ön plan xidmətini işə sala bilmədi.',
      'openvpn_operation_timeout':
          'OpenVPN Core-a JNI çağırışı icazə verilən maksimum müddəti aşdı.',
      'openvpn_start_failed':
          'Android xidməti hazırdır, lakin OpenVPN Core profilin işə salınmasını qəbul etmədi.',
      'openvpn_connection_failed':
          'OpenVPN Core CONNECTED hadisəsi göndərilməzdən əvvəl dayandı.',
      'openvpn_core_status_error':
          'Daxili OpenVPN dövrü daha dəqiq yekun hadisə olmadan xəta ilə başa çatdı.',
      'openvpn_stopped_before_connected':
          'Daxili OpenVPN dövrü açıq Core xətası olmadan, CONNECTED hadisəsindən əvvəl dayandı.',
      'openvpn_auth_failed':
          'OpenVPN serveri profilin autentifikasiyasını rədd etdi.',
      'openvpn_client_setup_failed':
          'OpenVPN Core şəbəkə bağlantısından əvvəl müştərini hazırlaya bilmədi.',
      'openvpn_client_halted':
          'OpenVPN Core müştəridən son dayandırma sorğusu aldı.',
      'openvpn_client_restart':
          'OpenVPN Core ötürmə sessiyasının yenidən başladılmasını tələb etdi.',
      'openvpn_inactive_timeout':
          'OpenVPN Core qeyri-aktivlik müddətindən sonra sessiyanı bağladı.',
      'openvpn_session_expired':
          'Server OpenVPN sessiyasının müddətinin bitdiyini bildirdi.',
      'openvpn_credentials_required':
          'Server və ya proksi bu sertifikat profilinə daxil olmayan interaktiv giriş məlumatları tələb edir.',
      'openvpn_proxy_failed':
          'OpenVPN Core konfiqurasiya olunmuş proksi və ya ötürücünün uğursuz olduğunu bildirdi.',
      'openvpn_compression_failed':
          'OpenVPN Core profil və ya server tərəfindən elan olunan sıxılma rejimini rədd etdi.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil bu versiyada mövcud olmayan NTLM şifrələməsi tələb edir.',
      'openvpn_feature_unsupported':
          'Profil və ya server bu Android müştərisində olmayan funksiya tələb edir.',
      'network_unavailable': 'İstifadə oluna bilən fiziki şəbəkə yoxdur.',
      'network_lost': 'Şəbəkə itirildikdən sonra tunel dayandırıldı.',
      'certificate_validation_failed':
          'OpenVPN serverinin kimliyi təsdiqlənə bilmədi.',
      'openvpn_certificate_expired':
          'Yenidən qoşulmazdan əvvəl OpenVPN profilini yeniləyin.',
      'tunnel_active_for_another_account':
          'Bu bağlantıdan əvvəl başqa hesaba aid tunel dayandırılmalıdır.',
      'tunnel_already_active':
          'Android əvvəlki VPN sessiyasının hələ də interfeysdən istifadə etdiyini bildirir.',
      'tunnel_stop_timeout':
          '$protocol mühərriki VPN interfeysinin azad edilməsini vaxt limitində təsdiqləmədi.',
      'tunnel_disconnected':
          'Daxili mühərrik tunelin işə düşdükdən sonra gözlənilmədən dayandığını bildirdi.',
      'native_bridge_unavailable':
          'Tətbiq Android VPN xidmətinə daxil ola bilmir. Tətbiqi bağlayıb yenidən açın, sonra yenidən cəhd edin.',
      'native_operation_failed':
          'Tətbiqdəki xəta VPN əməliyyatını kəsdi. Yenidən cəhd edin. Problem davam edərsə, diaqnostikanı işə salın.',
      'invalid_arguments':
          'Bu VPN əməliyyatı üçün lazım olan məlumat natamamdır. Yenidən cəhd edin. Problem davam edərsə, diaqnostikanı işə salın.',
      'invalid_account_id':
          'Daxili əməliyyat etibarlı hesab identifikatoru ilə əlaqəli deyil.',
      'invalid_device_id':
          'Daxili mühərrikə göndərilən cihaz identifikatoru yoxdur və ya etibarsızdır.',
      'storage_key_not_allowed':
          'Android körpüsü icazə verilən siyahıdan kənar yaddaş açarını bloklayıb.',
      'secure_storage_read_failed':
          'Android Keystore bu hesabın yerli məlumatlarının şifrəsini aça bilmədi.',
      'secure_storage_write_failed':
          'Android Keystore yerli məlumatları şifrələyə və ya saxlaya bilmədi.',
      'key_generation_failed':
          'Android təhlükəsiz yaddaşda WireGuard açarını yarada və ya oxuya bilmədi.',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR sorğusunu yarada və ya imzalaya bilmədi.',
      'other':
          'Sənədləşdirilməmiş daxili kod bölməsi uğursuz oldu. Aşağıda göstərilən diaqnostika kodunu dəstək xidmətinə göndərin.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'İcazə sorğusu artıq açıqdır';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN icazə sorğusu artıq göstərilir. Yenidən cəhd etməzdən əvvəl onu tamamlayın.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN icazə sorğusu yarımçıq qaldı';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN icazə ekranı tətbiq cavab almazdan əvvəl bağlandı.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN bağlantısı təsdiqlənmədi';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN bağlantısı təsdiqlənə bilmədi. Təhlükəsizlik üçün dayandırıldı. Yenidən cəhd edin.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profili ləğv edilib';

  @override
  String get openvpnCleanup_working =>
      'Ləğv edilmiş OpenVPN profili dayandırılır və silinir…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-in dayandırılması təsdiqlənməyib. Yeni profil yaratmazdan əvvəl təkrar cəhd edin.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Ləğv edilmiş OpenVPN profili tam silinə bilmədi. Təmizləməni təkrarlayın.';

  @override
  String get openvpnCleanup_complete =>
      'Ləğv edilmiş OpenVPN profili silindi. Yenisini yaratmaq üçün Qoşulun düyməsinə toxunun.';

  @override
  String get network_title => 'Şəbəkə konfiqurasiyası';

  @override
  String get network_ipv4Fallback =>
      'IPv6 müvəqqəti əlçatan deyil. Hazırlıq IPv4 ilə davam edir.';

  @override
  String get network_rejectedTitle => 'Şəbəkə konfiqurasiyası rədd edildi';

  @override
  String get network_rejectedMessage =>
      'Tunel konfiqurasiyası natamamdır və ya icazəli ünvanlara uyğun gəlmir. Tətbiqdən yenidən cəhd edin.';

  @override
  String get network_unreadableTitle => 'Yerli konfiqurasiya oxuna bilmir';

  @override
  String get network_unreadableMessage =>
      'Saxlanılmış OpenVPN şəbəkə konfiqurasiyasından istifadə etmək mümkün deyil. Onu yeniləmək üçün tətbiqdən yenidən qoşulun.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Şəbəkə qorunması';

  @override
  String get protection_subtitle =>
      'VPN bağlantısı kəsilərsə, birbaşa internetə çıxışı blok edin.';

  @override
  String get protection_active => 'Sistem qorunması aktivdir';

  @override
  String get protection_alwaysOnOnly =>
      'Həmişə aktiv VPN işə salınıb; VPN xaricindəki bağlantıların bloklanmasını aktivləşdirin';

  @override
  String get protection_inactive => 'Sistem qorunması aktiv deyil';

  @override
  String get protection_unknown => 'Sistem qorunmasını yoxlayın';

  @override
  String get protection_openSettings => 'Android ayarlarını açın';

  @override
  String get protection_dialogTitle => 'Şəbəkə qorunmasını qurun';

  @override
  String get protection_dialogMessage =>
      'Android həmişə aktiv VPN-i və VPN xaricindəki bağlantıların bloklanmasını idarə edir. FuzeVPN-in seçildiyini yoxlayın və sistem ayarlarında bloklamanı aktivləşdirin.';

  @override
  String get protection_dialogOpen => 'Ayarları açın';

  @override
  String get session_systemProtectionNote =>
      'Android hələ də VPN xaricindəki trafiki blok edirsə, bu qorunmanı yoxlamaq və ya dəyişdirmək üçün sistem ayarlarını açın.';

  @override
  String get diagnostics_title => 'Diaqnostika';

  @override
  String get diagnostics_settingsTitle => 'Tətbiq diaqnostikası';

  @override
  String get diagnostics_automaticTitle => 'Vacib xətaları göndərin';

  @override
  String get diagnostics_automaticDescription =>
      'Vacib xəta baş verdikdə qısa texniki hesabat göndərin.';

  @override
  String get diagnostics_privacy =>
      'Göndərilən hesabatlar daxil olduğunuz hesaba bağlanır və 30 gün saxlanılır. Onlara baxış tarixçəsi, parollar və VPN açarları daxil edilmir.';

  @override
  String get diagnostics_manualOpen => 'Diaqnostikanı işə salın';

  @override
  String get diagnostics_localDescription =>
      'Tətbiqin və VPN-in vəziyyəti barədə hesabat yaradın. Bağlantınız dəyişməz qalır.';

  @override
  String get diagnostics_sendReport => 'Hesabatı göndərin';

  @override
  String get diagnostics_sendHint =>
      'Hesabatı bu cihazda saxlamaq üçün bu xananı işarələməyin.';

  @override
  String get diagnostics_signedOut =>
      'Hesabat göndərmək üçün hesabınıza daxil olun.';

  @override
  String get diagnostics_localLifetime =>
      'Tətbiq bağlandıqdan sonra da qalması üçün bu hesabatı telefonunuza saxlayın.';

  @override
  String get diagnostics_run => 'Diaqnostikanı işə salın';

  @override
  String get diagnostics_rerun => 'Diaqnostikanı yenidən işə salın';

  @override
  String get diagnostics_running => 'Yoxlanılır…';

  @override
  String get diagnostics_sending => 'Hesabat göndərilir…';

  @override
  String get diagnostics_prepared => 'Hesabat bu cihazda hazırdır';

  @override
  String get diagnostics_queued => 'Hesabat göndərilməyi gözləyir';

  @override
  String get diagnostics_sent => 'Hesabat alındı';

  @override
  String get diagnostics_failed =>
      'Göndərmə uğursuz oldu. Yerli hesabatınız hələ də əlçatandır.';

  @override
  String get diagnostics_preparationFailed =>
      'Diaqnostika hesabatı hazırlana bilmədi. Yenidən cəhd edin.';

  @override
  String get diagnostics_authenticationRequired =>
      'Hesabatı göndərmək üçün yenidən daxil olun.';

  @override
  String get diagnostics_retry => 'Yenidən göndərin';

  @override
  String get diagnostics_export => 'Hesabatı saxlayın';

  @override
  String get diagnostics_exportFailed =>
      'Hesabat saxlanılmadı. Yerli hesabatdan yenidən cəhd edin.';

  @override
  String get diagnostics_preferenceFailed =>
      'Bu ayar saxlanıla bilmədi. Yenidən cəhd edin.';

  @override
  String diagnostics_receipt(Object id) {
    return 'İstinad: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date tarixində alındı';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date tarixinə qədər saxlanılır';
  }

  @override
  String get diagnostics_duplicate => 'Bu hesabat artıq alınmışdı.';

  @override
  String get diagnostics_preview => 'Hesabatın önizləməsi';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count texniki hadisə əlavə edilib',
      one: '1 texniki hadisə əlavə edilib',
      zero: 'Əlavə edilmiş texniki hadisə yoxdur',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Texniki təfərrüatlar';

  @override
  String get diagnostics_empty =>
      'Hələ heç bir diaqnostika hesabatı hazırlanmayıb.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tunel vəziyyəti',
      'handshake': 'Bağlantının təsdiqi',
      'certificate': 'VPN sertifikatı',
      'kill_switch': 'Android qorunması',
      'connectivity': 'Əlçatan şəbəkə',
      'api_reachability': 'Xidmətə çıxış',
      'secure_storage': 'Təhlükəsiz yaddaş',
      'other': 'Yerli yoxlama',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Yoxlanılıb',
      'failed': 'Diqqət tələb edir',
      'skipped': 'Yoxlanılmayıb — aktiv test aparılmayıb',
      'unknown': 'Məlumat əlçatan deyil',
      'other': 'Məlumat əlçatan deyil',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN-ə xoş gəlmisiniz';

  @override
  String get connection_changeLocation => 'Məkanı dəyişin';

  @override
  String get connection_details => 'Bağlantı təfərrüatları';

  @override
  String get locations_searchLabel => 'Şəhər və ya ölkə axtarın';

  @override
  String get locations_clearSearch => 'Axtarışı təmizləyin';

  @override
  String get locations_filterAll => 'Hamısı';

  @override
  String get locations_filterFavorites => 'Sevimlilər';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count məkan',
      one: '$count məkan',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Məkan tapılmadı';

  @override
  String get locations_noResultsHint => 'Başqa şəhər və ya ölkə sınayın.';

  @override
  String get locations_noFavorites => 'Sevimliləriniz əlinizin altında';

  @override
  String get locations_noFavoritesHint =>
      'Məkanın yanındakı ulduza toxunaraq onu burada saxlayın.';

  @override
  String get locations_showAll => 'Bütün məkanlara baxın';

  @override
  String locations_addFavorite(String name) {
    return 'Sevimlilərə əlavə edin: $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Sevimlilərdən çıxarın: $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Sevimli məkan saxlanıla bilmədi. Yenidən cəhd edin.';

  @override
  String get locations_emptyTitle => 'Əlçatan məkan yoxdur';

  @override
  String get locations_emptyHint =>
      'Yenidən cəhd etmək üçün siyahını yeniləyin.';

  @override
  String get devices_manage => 'Cihazlarımı idarə edin';

  @override
  String get settings_personalization => 'Özünüzə uyğunlaşdırın';

  @override
  String get settings_safety => 'Qorunma';

  @override
  String get settings_help => 'Kömək lazımdır?';

  @override
  String get settings_about => 'FuzeVPN haqqında';

  @override
  String get diagnostics_heading => 'Bağlantı problemini anlayın';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Əlçatandır',
      'pending': 'Hazırlanır',
      'revoked': 'Çıxarılıb',
      'expired': 'Müddəti bitib',
      'other': 'Vəziyyət əlçatan deyil',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Seçim saxlanmadı';

  @override
  String get notice_preferenceSave_message =>
      'Seçiminiz hazırda tətbiq olunub, lakin saxlanıla bilməyib. Tətbiqi bağladıqdan sonra da saxlamaq üçün yenidən cəhd edin.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPN-i aktiv saxlayırsa, açılan ayarlarda Həmişə aktiv VPN-i söndürün.';

  @override
  String get protection_learnMore =>
      'Android qorunması haqqında ətraflı məlumat';

  @override
  String get protection_guideWhy =>
      'Bu qorunma VPN bağlantısı kəsildikdə tətbiqlərin birbaşa internetdən istifadə etməsinin qarşısını alır. Bu, Android-də tənzimlənir.';

  @override
  String get protection_guideAlwaysOnTitle => 'Həmişə aktiv VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN xidmətini işlək saxlayır və telefon yenidən başladıqdan sonra onu yenidən işə sala bilər.';

  @override
  String get protection_guideBlockTitle => 'VPN olmadan bağlantıları blok edin';

  @override
  String get protection_guideBlock =>
      'Bu ayar bağlantı pozulduqda da trafikin VPN-dən yan keçməsinin qarşısını alır.';

  @override
  String get protection_guideWarning =>
      'Bu blokləmə aktiv olduqda, VPN qoşulana qədər internetə giriş bağlı qalır.';

  @override
  String get protection_guideStepsTitle => 'Qorunmanı aktivləşdirin';

  @override
  String get protection_guideStep1 =>
      'Aşağıdakı düymə ilə Android VPN ayarlarını açın.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN-in yanındakı dişli çarx işarəsinə toxunaraq seçimləri açın.';

  @override
  String get protection_guideStep3 =>
      'Mümkündürsə, “Həmişə aktiv VPN” və sonra “VPN olmadan bağlantıları blok edin” seçimlərini aktivləşdirin.';

  @override
  String get protection_guideManufacturers =>
      'Adlar telefondan asılı olaraq dəyişir. Lazım gələrsə, Ayarlarda VPN sözünü axtarın; adətən Şəbəkə və internet bölməsindədir.';

  @override
  String get protection_guideDisableTitle => 'Bu qorunmanı söndürün';

  @override
  String get protection_guideDisable =>
      'Eyni ayarlarda VPN olmadan bloklamanı söndürün ki, VPN olmadan internetə giriş mümkün olsun. Android-in VPN-i yenidən işə salmasını istəmirsinizsə, Həmişə aktiv VPN seçimini də söndürün.';

  @override
  String get protection_guideManual =>
      'Bu ayarları Android-də özünüz seçirsiniz. FuzeVPN onları sizin əvəzinizə dəyişmir.';

  @override
  String get locations_changeTitle => 'Məkanı dəyişmək istəyirsiniz?';

  @override
  String locations_changeActive(String name) {
    return 'VPN bağlantısı kəsiləcək, sonra $name məkanına qoşulmağa çalışacaq.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name məkanına qoşulmağa çalışacaq.';
  }

  @override
  String get locations_confirmChange => 'Dəyişin və qoşulun';

  @override
  String get locations_changeBusy =>
      'Dəyişiklik davam edir. Başqa məkan seçməzdən əvvəl gözləyin.';

  @override
  String get locations_automaticSelection => 'Avtomatik seçim';

  @override
  String get locations_cities => 'Şəhərlər';

  @override
  String get locations_servers => 'Serverlər';

  @override
  String locations_viewCities(String name) {
    return '$name şəhərlərinə baxın';
  }

  @override
  String locations_viewServers(String name) {
    return '$name serverlərinə baxın';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ölkə',
      one: '$count ölkə',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count şəhər',
      one: '$count şəhər',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count server',
      one: '$count server',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Bütün ölkələr';

  @override
  String get locations_backToCountries => 'Ölkələrə qayıdın';

  @override
  String locations_backToCities(String name) {
    return '$name şəhərlərinə qayıdın';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name seçin';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name seçin';
  }

  @override
  String get locations_noCompatibleServer => 'Uyğun server mövcud deyil.';

  @override
  String get externalLink_failed =>
      'Bu keçidi açmaq mümkün olmadı. Onu kopyalayıb brauzerinizdə aça bilərsiniz.';

  @override
  String get externalLink_copy => 'Keçidi kopyalayın';

  @override
  String get externalLink_copied => 'Keçid kopyalandı';

  @override
  String get externalLink_copyFailed =>
      'Keçidi kopyalamaq mümkün olmadı. Aşağıdakı ünvanı seçin.';

  @override
  String get settings_deleteAccount => 'Hesabımı silin';

  @override
  String get settings_deleteAccountDetail =>
      'Hesabın silinməsini tələb etmə qaydasına baxın';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'VPN abunəliyinizi seçin.';

  @override
  String get billing_subscribe => 'Abunə olun';

  @override
  String get billing_choosePlan => 'Davam etmək üçün tarif seçin.';

  @override
  String get billing_monthly => 'Aylıq';

  @override
  String get billing_yearly => 'İllik';

  @override
  String get billing_continue => 'Google Play ilə davam edin';

  @override
  String get billing_restore => 'Alışları bərpa edin';

  @override
  String get billing_manage => 'Abunəliyi idarə edin';

  @override
  String get billing_deleteAccountWarning =>
      'Google Play abunəliyiniz varsa, FuzeVPN hesabınızı silmək onun yenilənməsini ləğv etmir. Yenilənməni Google Play-də ayrıca idarə edin və ya ləğv edin.';

  @override
  String get billing_deleteAccountContinue =>
      'Hesabın silinməsi sorğusuna keçin';

  @override
  String get billing_refresh => 'Girişi yeniləyin';

  @override
  String get billing_loadingPlans => 'Tariflər yüklənir…';

  @override
  String get billing_unavailable =>
      'Hazırda heç bir tarif mövcud deyil. Daha sonra yenidən cəhd edin.';

  @override
  String get billing_comingSoon => 'Abunəliklər tezliklə əlçatan olacaq.';

  @override
  String get billing_priceDisclosure =>
      'Qiymət Google Play tərəfindən təqdim olunur. Son məbləğ və tətbiq olunan vergilər siz təsdiq etməzdən əvvəl göstərilir.';

  @override
  String get billing_renewalMonthly =>
      'Ləğv edilmədiyi təqdirdə hər ay avtomatik yenilənir. İstənilən vaxt Google Play abunəliklərində ləğv edə bilərsiniz.';

  @override
  String get billing_renewalYearly =>
      'Ləğv edilmədiyi təqdirdə hər il avtomatik yenilənir. İstənilən vaxt Google Play abunəliklərində ləğv edə bilərsiniz.';

  @override
  String get billing_active => 'Premium girişiniz aktivdir';

  @override
  String billing_accessUntil(String date) {
    return 'Giriş $date tarixinə qədər.';
  }

  @override
  String get billing_webManaged =>
      'Abunəliyiniz FuzeVPN veb-saytında idarə olunur.';

  @override
  String get billing_playManaged =>
      'Abunəliyiniz Google Play tərəfindən idarə olunur.';

  @override
  String get billing_playOnHold =>
      'Google Play abunəliyiniz dayandırılıb və ya ödəniş gözləyir. Google Play-də düzəltmək üçün “Abunəliyi idarə edin” seçimini açın.';

  @override
  String get billing_playReceiptUnlinked =>
      'Bu Google Play hesabında bu FuzeVPN hesabı üçün aktiv olmayan Fuze Premium abunəliyi artıq var. Onu Google Play-də yoxlamaq üçün “Abunəliyi idarə edin” seçimini açın.';

  @override
  String get billing_inactive => 'Aktiv abunəlik yoxdur.';

  @override
  String get billing_checkingAccess => 'Girişiniz yoxlanılır…';

  @override
  String get billing_restoring => 'Alışlar bərpa olunur…';

  @override
  String get billing_pending =>
      'Ödəniş gözlənilir. Təsdiqləndikdən sonra girişiniz aktivləşəcək.';

  @override
  String get billing_cancelled =>
      'Alış ləğv edildi. Yeni abunəlik aktivləşdirilmədi.';

  @override
  String get billing_verifying => 'Alış yoxlanılır…';

  @override
  String get billing_success =>
      'Abunəlik aktivləşdirildi. Premium girişiniz hazırdır.';

  @override
  String get billing_restored => 'Alışlarınız bərpa edildi.';

  @override
  String get billing_restoreEmpty =>
      'Bu Google Play hesabı üçün bərpa ediləcək alış yoxdur.';

  @override
  String get billing_catalogError =>
      'Tarifləri yükləmək mümkün olmadı. Yenidən cəhd edin.';

  @override
  String get billing_purchaseError =>
      'Alışı başlatmaq mümkün olmadı. Yenidən cəhd edin.';

  @override
  String get billing_verificationError =>
      'Alışın yoxlanılması müvəqqəti olaraq əlçatan deyil. Yenidən cəhd etmək üçün alışları bərpa edin.';

  @override
  String get billing_restoreError =>
      'Alışları bərpa etmək mümkün olmadı. Yenidən cəhd edin.';

  @override
  String get billing_managementError =>
      'Abunəliyin idarə edilməsini açmaq mümkün olmadı. Yenidən cəhd edin.';

  @override
  String get billing_storeUnavailable =>
      'Google Play bu cihazda əlçatan deyil.';

  @override
  String get welcome_title => 'VPN-iniz sadə və rahatdır.';

  @override
  String get welcome_description =>
      'Bağlantınızı qoruyun. Məxfiliyinizi öz nəzarətinizdə saxlayın.';

  @override
  String get welcome_start => 'Başlayın';

  @override
  String get welcome_alreadyPurchased => 'Artıq satın almısınız?';

  @override
  String get welcome_noAccountRequired =>
      'Başlamaq üçün hesab yaratmaq lazım deyil.';

  @override
  String get guest_accountTitle => 'Hesab əlaqələndirilməyib';

  @override
  String get guest_accountDescription =>
      'Abunəliyinizi başqa cihazda istifadə etmək üçün eyni Google Play hesabı ilə alışlarınızı bərpa edin.';

  @override
  String get guest_existingSubscriberSignIn => 'Artıq abunəsiniz? Daxil olun';

  @override
  String get guest_claimTitle => 'FuzeVPN-i özünüzlə aparın';

  @override
  String get guest_claimDescription =>
      'Abunəliyinizdən digər cihazlarınızda istifadə etmək üçün hesab yaradın. Bu addım ixtiyaridir.';

  @override
  String get guest_skip => 'Bəlkə sonra';

  @override
  String get guest_activationTitle => 'Fuze Premium aktivdir';

  @override
  String get guest_activationDescription =>
      'Abunəliyiniz hazırdır. VPN-dən istifadə edin və istədiyiniz zaman hesab yaradın.';

  @override
  String get guest_useVpn => 'VPN-dən istifadə edin';

  @override
  String get guest_loginRequired =>
      'Bu alış artıq FuzeVPN hesabı ilə əlaqələndirilib. Abunəliyinizdən istifadə etmək üçün həmin hesaba daxil olun.';

  @override
  String get guest_signOutWarning =>
      'Eyni Google Play hesabı ilə alışlarınızı bərpa edərək abunəliyinizi geri qaytara bilərsiniz.';

  @override
  String get guest_profileUnavailable =>
      'Hesabınız artıq əlaqələndirilib. Məlumatlarınıza baxmaq və onları idarə etmək üçün daxil olun.';

  @override
  String get billing_acceptance =>
      'Davam etməklə İstifadə şərtlərini və Məxfilik siyasətini qəbul edirsiniz.';

  @override
  String get guest_verifyEmailReminder =>
      'Hesabınızı qorumaq üçün e-poçt ünvanınızı təsdiqləyin. VPN-dən istifadəni davam etdirə bilərsiniz.';

  @override
  String get guest_serviceUnavailable =>
      'Xidmət müvəqqəti əlçatan deyil. Qısa müddətdən sonra yenidən cəhd edin.';

  @override
  String get guest_restoreError =>
      'Alışlarınızı bərpa etmək mümkün olmadı. Alış üçün istifadə olunan Google Play hesabı ilə yenidən cəhd edin.';

  @override
  String get guest_claimSuccess =>
      'Hesabınız yaradıldı. Abunəliyiniz və VPN girişiniz saxlanılıb.';

  @override
  String get guest_emailExists =>
      'Bu e-poçt ünvanı artıq istifadə olunur. Başqa ünvan seçin və ya mövcud hesabınıza daxil olun. Alışınız Google Play vasitəsilə əlçatan qalır.';

  @override
  String get guest_claimError =>
      'Hesabınızı yaratmaq mümkün olmadı. VPN-dən istifadəni davam etdirə və daha sonra yenidən cəhd edə bilərsiniz.';

  @override
  String get guest_secureStorageError =>
      'Sessiyanızı bu cihazda qorumaq mümkün olmadı. Yenidən cəhd edin.';

  @override
  String get guest_premiumRequired =>
      'VPN-inizi aktivləşdirmək üçün abunəlik seçin.';

  @override
  String get welcome_viewPlans => 'Tariflərə baxın';

  @override
  String get google_continue => 'Google ilə davam edin';

  @override
  String get google_or => 'və ya';

  @override
  String get google_title => 'FuzeVPN hesabınız';

  @override
  String get google_settingUp => 'Hesabınızın yaradılmasını tamamlayın';

  @override
  String get google_country => 'Yaşayış ölkəsi';

  @override
  String get google_profileDescription =>
      'FuzeVPN hesabınızı yaratmaq üçün ölkənizi seçin və iki sənədlə tanış olun.';

  @override
  String get google_claimDescription =>
      'Qonaq hesabınızı Google ilə əlaqələndirin. Abunəliyiniz və cihazınız bu hesaba bağlı qalacaq.';

  @override
  String get google_linkTitle => 'Google hesabını FuzeVPN ilə əlaqələndirin';

  @override
  String get google_linkDescription =>
      'Mövcud FuzeVPN hesabınıza girişi təsdiqləyin. Bu addımda Google parolunuz tələb olunmur.';

  @override
  String get google_password => 'FuzeVPN parolu';

  @override
  String get google_linkAccount => 'Əlaqələndirməni təsdiqləyin';

  @override
  String get google_requestEmail => 'Mənə təsdiq e-poçtu göndərin';

  @override
  String get google_emailInstructions =>
      'FuzeVPN-dən gələn e-poçtu açın və təsdiq kodunu daxil edin.';

  @override
  String get google_emailCode => 'E-poçt təsdiq kodu';

  @override
  String get google_confirmEmail => 'Kodu təsdiqləyin';

  @override
  String get google_restart => 'Başqa Google hesabı seçin';

  @override
  String get google_resume => 'Bu cəhdi yoxlayın';

  @override
  String get google_unavailable =>
      'Google ilə daxil olmaq əlçatan deyil. E-poçt və parolla daxil ola bilərsiniz.';

  @override
  String get google_expired =>
      'Bu cəhdin müddəti bitib. Onu ləğv edin və yenidən başlayın.';

  @override
  String get google_conflict =>
      'Bu Google hesabı artıq başqa hesaba bağlıdır. Cari hesabınız və abunəliyiniz saxlanılır.';

  @override
  String get google_error =>
      'Google ilə giriş uğursuz oldu. Yenidən cəhd edin; cari girişiniz saxlanılır.';

  @override
  String get google_uncertain =>
      'Nəticəni təsdiq etmək mümkün olmadı. Bu cəhdi yoxlayın və ya yenidən başlamazdan əvvəl ləğv edin.';

  @override
  String get google_cancelFailed =>
      'Ləğv etmə təsdiqlənə bilmədi. Bu ekrandan çıxmazdan əvvəl ləğv etməyə yenidən cəhd edin.';

  @override
  String get google_cancelled => 'Google ilə giriş ləğv edildi.';

  @override
  String get google_selecting => 'Google hesabınızı seçin…';

  @override
  String get google_verifying => 'Hesabınız yoxlanılır…';

  @override
  String get google_emailUnavailable =>
      'Təsdiq e-poçtu göndərilə bilmədi. Daha sonra yenidən cəhd edin.';

  @override
  String get google_emailSent =>
      'Təsdiq e-poçtu göndərildi. Gələnlər qutusunu yoxlayın.';

  @override
  String get google_rateLimited =>
      'Yenidən cəhd etməzdən əvvəl bir az gözləyin.';

  @override
  String get google_busy =>
      'Başqa əməliyyat davam etdiyi üçün (VPN bağlantısı, hesab və ya qonaq) Google əlçatan deyil. Həmin əməliyyat başa çatdıqdan sonra yenidən cəhd edin; cari girişiniz saxlanılır.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN parolu yanlışdır. Cari hesabınız saxlanılır.';

  @override
  String get google_invalidCode =>
      'Təsdiq kodu etibarsızdır və ya müddəti bitib.';

  @override
  String get google_accountChanged =>
      'Sessiyanız dəyişib. Yenidən başlamazdan əvvəl bu cəhdi ləğv edin.';

  @override
  String get google_invalidResponse =>
      'Cavab təsdiqlənə bilmədi. Cari girişiniz saxlanılır.';

  @override
  String get google_invalidRegistration =>
      'Ölkənizi və hər iki razılığı yoxlayın.';

  @override
  String get google_consentRequired =>
      'Davam etmək üçün ölkənizi seçin və hər iki sənədi qəbul edin.';

  @override
  String get google_challengeRequired =>
      'Əlavə təhlükəsizlik yoxlaması tələb olunur. Cari girişiniz saxlanılır.';

  @override
  String get google_challengeUnavailable =>
      'Təhlükəsizlik yoxlaması əlçatan deyil. Daha sonra yenidən cəhd edin.';

  @override
  String get google_intentMismatch =>
      'Əvvəlki Google giriş cəhdi hələ də gözləyir. Bu əməliyyatı başlatmazdan əvvəl onu ləğv edin.';

  @override
  String get google_challengeBlocked =>
      'Tələb olunan təhlükəsizlik yoxlaması bu tətbiqdə əlçatan deyil. Bu əməliyyat hazırda tamamlana bilməz.';

  @override
  String get google_solveChallenge => 'Təhlükəsizlik yoxlamasını tamamlayın';

  @override
  String get google_challengeTitle => 'Təhlükəsizlik yoxlaması';

  @override
  String get google_challengeReady =>
      'Yoxlama tamamlandı. İndi hesabınızın yaradılmasını təsdiqləyə bilərsiniz.';

  @override
  String get google_challengeExpired =>
      'Yoxlamanın müddəti bitib. Təsdiqləməzdən əvvəl onu yenidən tamamlayın.';

  @override
  String get google_challengeCancelled =>
      'Yoxlama ləğv edildi. Yenidən cəhd edə bilərsiniz.';

  @override
  String get google_challengeFailed =>
      'Təhlükəsizlik yoxlaması uğursuz oldu. Yenidən cəhd edin.';

  @override
  String get billing_trialTitle => 'Fuze Premium-u pulsuz sınayın';

  @override
  String get billing_trialSubtitle => 'Bağlantınızı bu gündən qoruyun.';

  @override
  String get billing_trialWeeks => '2 həftəlik pulsuz sınaq';

  @override
  String billing_trialDays(String days) {
    return '$days günlük pulsuz sınaq';
  }

  @override
  String get billing_trialStart => 'Pulsuz sınağa başlayın';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Bu gün başlasanız, ilk ödəniş $date tarixində gözlənilir.';
  }

  @override
  String get billing_trialTerms =>
      'Göstərilən qiymətlə avtomatik yenilənir. Ödəniş tutulmaması üçün sınaq müddəti bitməzdən əvvəl Google Play-də ləğv edin.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Sonra ayda $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Sonra ildə $price';
  }

  @override
  String get billing_choosePeriod => 'Tarifinizi seçin';

  @override
  String get billing_selectionHint => 'Davam etmək üçün tarif seçin.';

  @override
  String get billing_benefitConnection => 'Şifrələnmiş bağlantı';

  @override
  String get billing_benefitPrivacy => 'Onlayn məxfilik';

  @override
  String get billing_benefitNoAccount => 'Qeydiyyat tələb olunmur';

  @override
  String get billing_cancellation => 'Google Play-də ləğv edin';

  @override
  String get billing_premiumTitle => 'Daha yaxşı qorunan bağlantı.';

  @override
  String get billing_premiumSubtitle =>
      'Bağlantınızı özünüzə uyğun templə qoruyun.';

  @override
  String get billing_priceMonthly => 'ayda';

  @override
  String get billing_priceYearly => 'ildə';

  @override
  String get billing_trialToday => 'Bu gün ödəniləcək məbləğ yoxdur';

  @override
  String get billing_trialConfirmation =>
      'Google Play siz təsdiq etməzdən əvvəl tarixləri, son məbləği və tətbiq olunan vergiləri təsdiqləyir.';

  @override
  String get billing_offerChanged =>
      'Bu təklifin şərtləri dəyişib. Tarifləri yeniləyin və yenidən seçin.';

  @override
  String get status_waitingNetwork => 'Şəbəkə gözlənilir';

  @override
  String get status_waitingNetworkDetail =>
      'Şəbəkə əlçatan deyil. Şəbəkə bərpa olunduqda VPN bağlantını yoxlayacaq.';

  @override
  String get locations_favoriteLoadFailed =>
      'Sevimlilər yüklənə bilmədi. Yenidən cəhd edin.';

  @override
  String get locations_favoritesLoading => 'Sevimlilər yüklənir…';
}
