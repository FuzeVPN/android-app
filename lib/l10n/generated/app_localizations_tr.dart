// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Bağlantınızı koruyun';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN, bu cihaz ile FuzeVPN sunucuları arasında şifreli bir tünel oluşturmak için Android’in VPN hizmetini (VpnService) kullanır.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN etkinken uygulamalarınızın İnternet trafiği, hedef adresleri ve DNS istekleri bağlantınızı yönlendirmek için bu tünelden geçer. FuzeVPN arka planda çalışırken de bu işlem devam eder.';

  @override
  String get vpnDisclosure_statusBody =>
      'Uygulama, VPN bağlantınızı göstermek için bağlantı durumunu, süresini ve aktarılan veri miktarını kullanır. Bağlantıyı istediğiniz zaman durdurabilirsiniz.';

  @override
  String get vpnDisclosure_privacy => 'Gizlilik';

  @override
  String get vpnDisclosure_accept => 'Kabul et ve devam et';

  @override
  String get vpnDisclosure_decline => 'Şimdi değil';

  @override
  String get accountRestoration_title => 'Hesap geçici olarak kullanılamıyor';

  @override
  String get accountRestoration_message =>
      'Oturumunuz korundu. Hesabınızı geri yüklemek için yeniden deneyin; VPN bağlantısını burada hâlâ yönetebilirsiniz.';

  @override
  String get action_retry => 'Yeniden dene';

  @override
  String get session_endingTitle => 'Oturum sonlandırılıyor';

  @override
  String get session_ending =>
      'Oturumunuz geçersiz kılındı. VPN durduruluyor ve oturum temizleniyor…';

  @override
  String get session_stopFailed =>
      'VPN\'in kapatıldığı doğrulanamadı. Yeniden oturum açmadan önce tekrar deneyin.';

  @override
  String get session_cleanupFailed =>
      'VPN durduruldu, ancak oturumun kaldırıldığı doğrulanamadı. Temizleme işlemini yeniden deneyin.';

  @override
  String get session_retryStop => 'Kapatmayı yeniden dene';

  @override
  String get session_retryCleanup => 'Temizlemeyi yeniden dene';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN güvenli bir şekilde hazırlanıyor…';

  @override
  String get nav_connection => 'Bağlantı';

  @override
  String get nav_locations => 'Konumlar';

  @override
  String get nav_account => 'Hesap';

  @override
  String get nav_devices => 'Cihazlar';

  @override
  String get nav_settings => 'Ayarlar';

  @override
  String get action_refresh => 'Yenile';

  @override
  String get auth_tab_login => 'Oturum aç';

  @override
  String get auth_tab_register => 'Kaydol';

  @override
  String get auth_stepAccount => 'Hesap';

  @override
  String get auth_stepIdentity => 'Kimlik';

  @override
  String get auth_stepAddress => 'Adres ve sözleşmeler';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$current/$total. adım';
  }

  @override
  String get auth_tagline => 'VPN\'inizi kullanmak artık çok kolay.';

  @override
  String get auth_keysLocal => 'Özel VPN anahtarlarınız bu cihazda kalır.';

  @override
  String get form_email => 'E-posta adresi';

  @override
  String get form_password => 'Şifre';

  @override
  String get form_showPassword => 'Şifreyi göster';

  @override
  String get form_hidePassword => 'Şifreyi gizle';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 baytı. Bazı karakterler birden fazla bayt kullanır.';

  @override
  String get form_firstName => 'Ad';

  @override
  String get form_lastName => 'Soyadı';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Adres';

  @override
  String get form_address2 => 'Adres satırı 2 (isteğe bağlı)';

  @override
  String get form_postalCode => 'Posta kodu';

  @override
  String get form_city => 'Şehir';

  @override
  String get form_country => 'Ülke kodu (örn. FR)';

  @override
  String get action_login => 'Oturum aç';

  @override
  String get action_createAccount => 'Hesap oluştur';

  @override
  String get action_createMyAccount => 'Hesabımı oluştur';

  @override
  String get action_next => 'Devam et';

  @override
  String get action_previous => 'Geri';

  @override
  String get action_forgotPassword => 'Şifrenizi mi unuttunuz?';

  @override
  String get auth_noAccount => 'Henüz hesabınız yok mu?';

  @override
  String get auth_requiredInformation => 'Hesabınızı üç adımda oluşturun.';

  @override
  String get auth_termsPrefix => 'Şunları kabul ediyorum: ';

  @override
  String get auth_termsLink => 'kullanım koşulları';

  @override
  String get auth_privacyPrefix => 'Şunu kabul ediyorum: ';

  @override
  String get auth_privacyLink => 'gizlilik politikası';

  @override
  String get auth_consentRequired =>
      'Hesap oluşturmak için onayınız gerekiyor.';

  @override
  String get validation_required => 'Bu alan zorunludur.';

  @override
  String get validation_email => 'Geçerli bir e-posta adresi girin.';

  @override
  String get validation_password =>
      'Şifre çok kısa: en az 8 UTF-8 baytı olmalıdır.';

  @override
  String get validation_passwordTooLong =>
      'Şifre çok uzun: en fazla 72 UTF-8 baytı olabilir.';

  @override
  String get validation_phone =>
      'Uluslararası biçimi kullanın; örneğin +33612345678.';

  @override
  String get validation_country =>
      'İki harfli ülke kodunu kullanın; örneğin FR.';

  @override
  String get passwordReset_title => 'Şifreyi sıfırla';

  @override
  String get passwordReset_description =>
      'Şifre sıfırlama bağlantısı istemek için hesap e-posta adresinizi girin.';

  @override
  String get passwordReset_send => 'Bağlantıyı gönder';

  @override
  String get connection_title => 'Bağlantınız';

  @override
  String get connection_subtitle =>
      'Bir konum seçin, ardından VPN\'inizi açın.';

  @override
  String get connection_prepare => 'Bağlanmaya hazır mısınız?';

  @override
  String get connection_advancedOptions => 'Gelişmiş seçenekler';

  @override
  String get connection_location => 'Konum';

  @override
  String get connection_chooseLocation => 'Konum seçin';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Bağlan';

  @override
  String get connection_connecting => 'Bağlanıyor…';

  @override
  String get connection_disconnect => 'Bağlantıyı kes';

  @override
  String get connection_disconnecting => 'Bağlantı kesiliyor';

  @override
  String get connection_locationChange => 'Konum değiştiriliyor…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol kullanılamıyor';
  }

  @override
  String get connection_activeLocation => 'Etkin konum';

  @override
  String get connection_duration => 'Süre';

  @override
  String get connection_received => 'Alınan';

  @override
  String get connection_sent => 'Gönderilen';

  @override
  String get connection_lastHandshake => 'Son güvenli alışveriş';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration önce';
  }

  @override
  String get verification_title => 'E-posta adresinizi doğrulayın';

  @override
  String get verification_message =>
      'VPN\'i bu telefonda kullanmak için e-posta adresinizi doğrulayın.';

  @override
  String get verification_resend => 'E-postayı yeniden gönder';

  @override
  String get migration_title => 'Konum değişikliği';

  @override
  String get migration_draining => 'Konum değişikliği hazırlanıyor…';

  @override
  String get migration_activating => 'Yeni sunucu etkinleştiriliyor…';

  @override
  String get migration_ready => 'Konum güncellendi.';

  @override
  String get migration_blocked =>
      'Konum değişikliği için sunucu müdahalesi gerekiyor. Daha sonra tekrar deneyin veya destek ekibiyle iletişime geçin.';

  @override
  String get migration_progress => 'Konum değişikliği ilerlemesi';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Kontroller arasındaki gecikme: $seconds sn.';
  }

  @override
  String get migration_resume => 'Konum değişikliğine devam et';

  @override
  String get status_authorizing => 'İzin gerekiyor';

  @override
  String get status_authorizingDetail =>
      'VPN\'e izin vermek için Android isteğini kabul edin.';

  @override
  String get status_preparing => 'Hazırlanıyor';

  @override
  String get status_preparingDetail => 'Güvenli bağlantınız hazırlanıyor.';

  @override
  String get status_reconnecting => 'Yeniden bağlanıyor…';

  @override
  String get status_reconnectingDetail =>
      'Bağlantı kesildi. VPN yeniden bağlanmayı deniyor.';

  @override
  String get status_connecting => 'Bağlanıyor';

  @override
  String get status_connectingDetail => 'VPN sunucusuna bağlanıyor…';

  @override
  String get status_connected => 'Bağlandı';

  @override
  String get status_connectedDetail => 'VPN bağlantınız etkin.';

  @override
  String get status_disconnecting => 'Bağlantı kesiliyor';

  @override
  String get status_disconnectingDetail => 'VPN bağlantınız durduruluyor.';

  @override
  String get status_error => 'Bağlantı kullanılamıyor';

  @override
  String get status_errorDetail =>
      'VPN bağlantısı doğrulanamadı. Tekrar deneyin.';

  @override
  String get status_idle => 'Bağlantı kesildi';

  @override
  String get status_idleDetail => 'Bağlantınızı korumak için VPN\'e bağlanın.';

  @override
  String get trust_note =>
      'Uygulamayı kapatmak VPN\'i durdurmaz. Durdurmak için Bağlantıyı kes seçeneğini kullanın.';

  @override
  String get locations_none => 'Şu anda kullanılabilir konum yok.';

  @override
  String get locations_available => 'Sonraki konumunuzu seçin.';

  @override
  String get locations_selected => 'Seçilen konum';

  @override
  String get locations_select => 'Bu konumu seç';

  @override
  String get locations_lockedTunnel =>
      'Konum değiştirmek için VPN bağlantısını kesin.';

  @override
  String get locations_lockedMigration =>
      'Konum değişikliğinin tamamlanmasını bekleyin.';

  @override
  String get devices_title => 'Cihazlarınız';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit cihaz';
  }

  @override
  String get devices_refresh => 'Cihazları yenile';

  @override
  String get devices_empty => 'Henüz kayıtlı bir VPN cihazı yok.';

  @override
  String get devices_firstConnection => 'Telefonunuz ilk bağlantıda eklenecek.';

  @override
  String get devices_thisDevice => 'Bu cihaz';

  @override
  String devices_added(Object date) {
    return '$date tarihinde eklendi';
  }

  @override
  String get action_remove => 'Kaldır';

  @override
  String get settings_title => 'Ayarlar';

  @override
  String get settings_subtitle => 'Tercihleriniz ve hesabınız tek bir yerde.';

  @override
  String get settings_appearance => 'Görünüm';

  @override
  String get settings_language => 'Dil';

  @override
  String get settings_languageDescription =>
      'Seçtiğiniz dil VPN bildirimleri için de geçerlidir.';

  @override
  String get settings_account => 'Hesap';

  @override
  String get settings_signOut => 'Oturumu kapat';

  @override
  String get settings_privacy => 'Gizlilik politikası';

  @override
  String get settings_terms => 'Kullanım koşulları';

  @override
  String get settings_security => 'Güvenlik ve şeffaflık';

  @override
  String get settings_licenses => 'Bileşen lisansları';

  @override
  String get settings_licensesDetail => 'Uygulamada kullanılan yazılım';

  @override
  String get settings_background =>
      'Uygulamadan çıktığınızda VPN açık kalır. Durdurmak için Bağlantı sekmesindeki Bağlantıyı kes seçeneğini kullanın.';

  @override
  String get theme_system => 'Sistem';

  @override
  String get theme_light => 'Açık';

  @override
  String get theme_dark => 'Koyu';

  @override
  String get language_system => 'Telefon dili';

  @override
  String get language_fr => 'Fransızca';

  @override
  String get language_en => 'İngilizce';

  @override
  String get language_es => 'İspanyolca';

  @override
  String get language_de => 'Almanca';

  @override
  String get dialog_removeDevice => 'Bu cihaz kaldırılsın mı?';

  @override
  String get dialog_removeCurrent =>
      'Bu telefonun VPN bağlantısı kesilecek ve erişimi kaldırılacak. VPN bağlantı verileri, sunucu onayladıktan sonra silinecek.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” için VPN erişimi iptal edilecek. Bu işlem geri alınamaz.';
  }

  @override
  String get dialog_signOut => 'Oturum kapatılsın mı?';

  @override
  String get dialog_signOutMessage =>
      'VPN durdurulacak ve yeniden oturum açmanız gerekecek. Şifrelenmiş VPN anahtarlarınız bir sonraki bağlantınız için bu telefonda kalacak.';

  @override
  String get action_cancel => 'İptal';

  @override
  String get action_signOut => 'Oturumu kapat';

  @override
  String get notice_close => 'Mesajı kapat';

  @override
  String get notice_sessionExpired_title => 'Oturumun süresi doldu';

  @override
  String get notice_sessionExpired_message =>
      'Oturumunuzun süresi doldu. Yeniden oturum açın.';

  @override
  String get notice_connectionFailed_title => 'Bağlantı başarısız oldu';

  @override
  String get notice_invalidCredentials_message =>
      'E-posta adresi veya şifre yanlış.';

  @override
  String get notice_emailVerification_title => 'E-posta doğrulaması gerekiyor';

  @override
  String get notice_emailVerification_message =>
      'VPN cihazı eklemeden önce e-posta adresinizi doğrulayın.';

  @override
  String get notice_rateLimited_title => 'Çok fazla deneme yapıldı';

  @override
  String get notice_deviceLimit_title => '2 cihaz sınırına ulaşıldı';

  @override
  String get notice_deviceLimit_message =>
      'Başka bir cihaz eklemeden önce mevcut bir cihazı kaldırın.';

  @override
  String get notice_identityRenewal_title =>
      'VPN kimliğinin yenilenmesi gerekiyor';

  @override
  String get notice_identityRenewal_message =>
      'Bu kimlik kaldırıldı. Yeni bir yerel kimlik oluşturun.';

  @override
  String get notice_migrationPending_title => 'Konum değişikliği sürüyor';

  @override
  String get notice_migrationPending_message =>
      'Devam eden bir konum değişikliği zaten var.';

  @override
  String get notice_migrationBlocked_title => 'Konum değişikliği engellendi';

  @override
  String get notice_migrationBlocked_message =>
      'Konum değişikliği için sunucu müdahalesi gerekiyor. Daha sonra tekrar deneyin veya destek ekibiyle iletişime geçin.';

  @override
  String get notice_targetUnavailable_title =>
      'Sunucu geçici olarak kullanılamıyor';

  @override
  String get notice_targetUnavailable_message =>
      'Bu sunucu geçici olarak kullanılamıyor.';

  @override
  String get notice_networkUnavailable_title =>
      'İnternet bağlantısı kullanılamıyor';

  @override
  String get notice_networkUnavailable_message =>
      'Bağlantınızı kontrol edin ve tekrar deneyin.';

  @override
  String get notice_permissionDenied_title => 'VPN izni reddedildi';

  @override
  String get notice_permissionDenied_message =>
      'Bağlantıyı yeniden başlatın ve Android izin isteğini kabul edin.';

  @override
  String get notice_wireguardTimeout_title => 'Sunucu yanıt vermiyor';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard bağlantısı çok uzun sürdü. Tekrar deneyin veya başka bir konum seçin.';

  @override
  String get notice_tlsFailed_title => 'Güvenli bağlantı reddedildi';

  @override
  String get notice_tlsFailed_message =>
      'Sunucu OpenVPN bağlantısını kabul etmedi. Tekrar deneyin. Sorun devam ederse tanılama çalıştırın.';

  @override
  String get notice_tunRejected_title => 'Android VPN arayüzünü reddetti';

  @override
  String get notice_tunRejected_message =>
      'Android, OpenVPN tarafından istenen ağ yapılandırmasını reddetti.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN başlatılamadı';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN altyapısı başlatmayı tamamlayamadı. Tekrar deneyin. Sorun devam ederse destek ekibiyle iletişime geçin.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Tanılama kodu: $code';
  }

  @override
  String get notice_generic_title => 'VPN bağlantısı başarısız oldu';

  @override
  String get notice_generic_message =>
      'Bir hata oluştu. Daha sonra tekrar deneyin.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Hesap oluşturuldu',
      'password_reset_sent': 'Şifre sıfırlama isteği alındı',
      'verification_email_sent': 'Doğrulama e-postası gönderildi',
      'location_migration_pending': 'Konum değişikliği sürüyor',
      'vpn_sign_in_required': 'Oturum açmanız gerekiyor',
      'protocol_unavailable_at_location': 'Protokol kullanılamıyor',
      'vpn_permission_denied': 'VPN izni reddedildi',
      'revoked_identity_device_limit': '2 cihaz sınırına ulaşıldı',
      'tunnel_start_unexpected': 'VPN başlatılamadı',
      'flutter_disconnect_timeout': 'Bağlantının kesildiği doğrulanamadı',
      'flutter_disconnect_unexpected': 'Bağlantı kesilemedi',
      'device_revoked': 'Cihaz kaldırıldı',
      'revoke_unexpected': 'Cihaz kaldırılamadı',
      'identity_renewal_unexpected': 'Kimlik yenilenemedi',
      'openvpn_renewal_unexpected': 'OpenVPN yenilenemedi',
      'location_migration_blocked': 'Konum değişikliği engellendi',
      'location_migration_slow': 'Konum değişikliği hâlâ sürüyor',
      'location_migration_conflict':
          'Konum değişikliğinin yenilenmesi gerekiyor',
      'location_migration_verification_failed':
          'Konum değişikliği doğrulanamadı',
      'location_migration_device_changed':
          'Konum değişikliği sırasında cihaz değişti',
      'tunnel_stop_failed': 'Konum değişikliği kullanılamıyor',
      'other': 'İşlem başarısız oldu',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Hesap oluşturuldu ancak doğrulama e-postası gönderilemedi. Uygulamada yeniden gönder seçeneğini kullanın.',
      'password_reset_sent':
          'İsteğiniz alındı. Bu adresle eşleşen bir hesap varsa e-posta alabilirsiniz. Spam klasörünüzü de kontrol edin.',
      'verification_email_sent':
          'Yeni bir doğrulama e-postası az önce gönderildi.',
      'location_migration_pending':
          '$target konumuna geçiş hâlâ hazırlanıyor. Cihazı yeniden oluşturmadan devam edebilirsiniz.',
      'vpn_sign_in_required': 'VPN\'i başlatmadan önce hesabınıza giriş yapın.',
      'protocol_unavailable_at_location':
          'Seçilen protokol bu konumda sunulmuyor. Konumları yenileyin veya başka bir protokol seçin.',
      'vpn_permission_denied':
          'Android VPN iznini reddetti. Bağlantıyı yeniden başlatın ve sistem isteğini kabul edin.',
      'revoked_identity_device_limit':
          'Bu cihazın VPN erişimi kaldırıldı ve cihaz sınırına ulaşıldı. Hesap → Cihazlarımı yönet bölümünden bir cihaz kaldırın.',
      'tunnel_start_unexpected':
          'Beklenmeyen bir hata tünel hazırlığını kesintiye uğrattı. Tanılama kodunu kontrol edin ve tekrar deneyin.',
      'flutter_disconnect_timeout':
          'Android, VPN\'in zamanında durdurulduğunu doğrulamadı. Yeniden durdurmayı deneyin.',
      'flutter_disconnect_unexpected':
          'Beklenmeyen bir hata tünelin durduğunun doğrulanmasını engelledi.',
      'device_revoked':
          'Cihazın VPN erişimi iptal edildi ve yerel gizli bilgileri kaldırıldı.',
      'revoke_unexpected':
          'Cihaz kaldırılamadı. Listeyi yenileyin ve tekrar deneyin.',
      'identity_renewal_unexpected':
          'Yeni VPN kimliği oluşturulamadı. Cihazları yenileyin ve tekrar deneyin.',
      'openvpn_renewal_unexpected':
          'OpenVPN profili yenilenemedi. Tekrar deneyin veya tanılama kodunu kontrol edin.',
      'location_migration_blocked':
          'Sunucu bu değişikliği şu anda tamamlayamıyor. Cihaz ve yerel kimliği korundu.',
      'location_migration_slow':
          'Sunucu $target konumuna geçişi hâlâ hazırlıyor. Birkaç dakika sonra Devam et seçeneğini kullanın.',
      'location_migration_conflict':
          'Cihaz durumu sunucuda değişti. Cihazları yenileyin, ardından değişikliğe devam edin.',
      'location_migration_verification_failed':
          'Sunucu yeni konumu doğrulamadı. Önceki yerel kimlik korundu.',
      'location_migration_device_changed':
          'Sunucunun döndürdüğü cihaz artık değiştirilen cihazla eşleşmiyor. Tekrar denemeden önce cihazları yenileyin.',
      'tunnel_stop_failed':
          'Yeni bağlantıdan önce önceki tünel tamamen durdurulmalıdır.',
      'other':
          'İşlem tamamlanamadı. Tekrar deneyin veya tanılama kodunu desteğe gönderin.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Oturumun süresi doldu',
      'invalid_credentials': 'Oturum açılamadı',
      'email_verification_required': 'E-posta doğrulaması gerekiyor',
      'verification_email_cooldown': 'E-posta zaten gönderildi',
      'rate_limited': 'Çok fazla deneme yapıldı',
      'invalid_registration': 'Bilgiler düzeltilmeli',
      'email_exists': 'Hesap zaten mevcut',
      'invalid_profile': 'Geçersiz profil',
      'invalid_device': 'Geçersiz cihaz',
      'invalid_location': 'Konum kullanılamıyor',
      'device_limit': 'Cihaz sınırına ulaşıldı',
      'device_exists': 'VPN kimliği zaten kullanımda',
      'device_identity_revoked': 'VPN kimliği yenilenmeli',
      'device_location_locked': 'Konum değişikliğinin yenilenmesi gerekiyor',
      'location_migration_pending': 'Konum değişikliği sürüyor',
      'location_migration_blocked': 'Konum değişikliği engellendi',
      'target_ca_mismatch': 'Uyumsuz OpenVPN sunucusu',
      'location_migration_conflict':
          'Konum değişikliğinin yenilenmesi gerekiyor',
      'server_full': 'Sunucu dolu',
      'capacity_unavailable': 'Konum geçici olarak kullanılamıyor',
      'target_unavailable': 'Sunucu geçici olarak kullanılamıyor',
      'not_found': 'Öğe bulunamadı',
      'invalid_openvpn_csr': 'Geçersiz OpenVPN kimliği',
      'openvpn_profile_exists': 'OpenVPN profili zaten mevcut',
      'openvpn_profile_revoked': 'OpenVPN profili iptal edildi',
      'openvpn_operation_pending': 'OpenVPN işlemi sürüyor',
      'openvpn_operation_terminal': 'OpenVPN işlemi kesintiye uğradı',
      'openvpn_address_unavailable': 'OpenVPN adresi kullanılamıyor',
      'openvpn_profile_conflict': 'OpenVPN çakışması',
      'openvpn_signer_unavailable': 'OpenVPN kullanılamıyor',
      'email_delivery_unavailable': 'E-posta kullanılamıyor',
      'invalid_token': 'Geçersiz bağlantı',
      'network_unavailable': 'İnternet bağlantısı kullanılamıyor',
      'invalid_json': 'Geçersiz istek',
      'invalid_api_response': 'Geçersiz sunucu yanıtı',
      'ipv6_unavailable': 'IPv6 kullanılamıyor',
      'invalid_ip_families': 'Ağ yapılandırması reddedildi',
      'other': 'Hizmet kullanılamıyor',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Oturumunuzun süresi doldu. Yeniden oturum açın.',
      'invalid_credentials': 'E-posta adresi veya şifre yanlış.',
      'email_verification_required':
          'VPN cihazı eklemeden önce e-posta adresinizi doğrulayın.',
      'invalid_registration': 'İstenen bilgileri ve onayları kontrol edin.',
      'email_exists': 'Bu e-posta adresini zaten bir hesap kullanıyor.',
      'invalid_profile': 'Profil bilgilerinizi kontrol edin.',
      'invalid_device': 'Bu cihazın adı veya yerel kimliği geçersiz.',
      'invalid_location': 'Konum listesini yenileyin ve tekrar deneyin.',
      'device_limit':
          'Başka bir cihaz eklemeden önce mevcut bir cihazı kaldırın.',
      'device_exists': 'Bu VPN kimliği zaten başka bir hesaba bağlı.',
      'device_identity_revoked':
          'Bu kimlik kaldırıldı. Yeni bir yerel kimlik oluşturulmalı.',
      'device_location_locked':
          'Bu cihazın konumu az önce değişti. Uygulama devam eden değişikliği sürdürecek.',
      'location_migration_pending':
          'Devam eden bir konum değişikliği zaten var.',
      'location_migration_blocked':
          'Konum değişikliği için sunucu müdahalesi gerekiyor. Daha sonra tekrar deneyin veya destek ekibiyle iletişime geçin.',
      'target_ca_mismatch':
          'Bu sunucu henüz mevcut OpenVPN profiliyle uyumlu değil.',
      'location_migration_conflict':
          'Cihazları yenileyin, ardından konum değişikliğini tekrar deneyin.',
      'server_full':
          'Bu konum bağlantı sınırına ulaştı. Başka bir konum seçin veya daha sonra tekrar deneyin.',
      'capacity_unavailable':
          'Bu konumun şu anda kullanılabilir olup olmadığını doğrulayamıyoruz. Başka bir konum seçin veya daha sonra tekrar deneyin.',
      'target_unavailable': 'Bu sunucu geçici olarak kullanılamıyor.',
      'not_found': 'Bu öğe artık hesabınızda kullanılamıyor.',
      'invalid_openvpn_csr':
          'Yeni bir OpenVPN kimliği oluşturun ve tekrar deneyin.',
      'openvpn_profile_exists': 'Bu cihaz için zaten bir OpenVPN profili var.',
      'openvpn_profile_revoked':
          'Devam etmek için OpenVPN profilini yenileyin.',
      'openvpn_operation_pending':
          'Değişiklik hâlâ yayılıyor. Daha sonra tekrar deneyin.',
      'openvpn_operation_terminal':
          'Yeni bir OpenVPN kimliği oluşturun ve tekrar deneyin.',
      'openvpn_address_unavailable':
          'Şu anda kullanılabilir bir OpenVPN adresi yok.',
      'openvpn_profile_conflict':
          'Profil değişti. Cihazları yenileyin ve tekrar deneyin.',
      'openvpn_signer_unavailable':
          'OpenVPN hizmeti geçici olarak kullanılamıyor.',
      'email_delivery_unavailable':
          'E-posta gönderilemedi. Daha sonra tekrar deneyin.',
      'invalid_token':
          'Bu bağlantı geçersiz veya süresi dolmuş. Yeni bir bağlantı isteyin.',
      'network_unavailable':
          'İnternet bağlantınızı kontrol edin ve tekrar deneyin.',
      'invalid_json': 'Girilen bilgileri kontrol edin ve tekrar deneyin.',
      'invalid_api_response':
          'Sunucu beklenmeyen bir yanıt verdi. Daha sonra tekrar deneyin.',
      'ipv6_unavailable':
          'Sunucu şu anda IPv6\'yı etkinleştiremiyor. Daha sonra tekrar deneyin.',
      'invalid_ip_families':
          'Tünel yapılandırması eksik veya izin verilen adreslerle eşleşmiyor. Uygulamadan tekrar deneyin.',
      'other': 'Bir sunucu hatası oluştu. Daha sonra tekrar deneyin.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Birkaç dakika sonra tekrar deneyin.';

  @override
  String notice_retryAfter(Object seconds) {
    return '$seconds saniye sonra tekrar deneyin.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Sistem VPN\'i sürdürülemiyor',
      'system_vpn_resume_corrupt': 'Geçersiz sistem VPN\'i sürdürme işlemi',
      'system_vpn_resume_session_invalid': 'Geçersiz VPN sürdürme oturumu',
      'system_vpn_resume_identity_changed': 'VPN kimliği değişti',
      'system_vpn_resume_identity_invalid': 'Geçersiz VPN sürdürme kimliği',
      'system_vpn_resume_storage_failed':
          'VPN sürdürme depolaması kullanılamıyor',
      'system_vpn_resume_network_timeout': 'VPN sürdürme işlemi için ağ yok',
      'system_vpn_resume_blocked': 'VPN sürdürme işlemi engellendi',
      'system_vpn_resume_failed': 'VPN sürdürülemedi',
      'system_vpn_resume_error_invalid': 'Geçersiz VPN sürdürme hatası',
      'wireguard_identity_store_failed': 'WireGuard kimliği kaydedilemedi',
      'wireguard_identity_unavailable': 'WireGuard kimliği kullanılamıyor',
      'vpn_host_destroyed': 'Android VPN ana bilgisayarı durdu',
      'vpn_host_unavailable': 'Android VPN ana bilgisayarı kullanılamıyor',
      'vpn_permission_required': 'VPN izni gerekiyor',
      'vpn_permission_denied': 'VPN izni reddedildi',
      'vpn_permission_request_failed': 'İzin istenemedi',
      'wireguard_foreground_service_unavailable':
          'WireGuard hizmeti kullanılamıyor',
      'wireguard_identity_invalid': 'Geçersiz yerel WireGuard anahtarı',
      'wireguard_identity_in_use': 'WireGuard kimliği zaten kullanımda',
      'wireguard_configuration_invalid': 'Geçersiz WireGuard yapılandırması',
      'wireguard_operation_pending': 'WireGuard işlemi hâlâ etkin',
      'wireguard_start_failed': 'WireGuard başlatılması reddedildi',
      'wireguard_stop_timeout': 'WireGuard\'ın durduğu doğrulanamadı',
      'wireguard_handshake_timeout': 'WireGuard yanıt vermedi',
      'openvpn_connection_timeout': 'OpenVPN yanıt vermedi',
      'openvpn_core_unavailable': 'OpenVPN altyapısı kullanılamıyor',
      'openvpn_operation_pending': 'OpenVPN oturumu hâlâ etkin',
      'openvpn_stop_timeout': 'OpenVPN\'in durduğu doğrulanamadı',
      'openvpn_profile_unavailable': 'Yerel OpenVPN profili eksik',
      'openvpn_native_failed': 'Yerel OpenVPN çağrısı kesintiye uğradı',
      'openvpn_key_generation_failed': 'OpenVPN P-256 anahtarı oluşturulamadı',
      'openvpn_csr_generation_failed': 'OpenVPN CSR oluşturulamadı',
      'openvpn_identity_store_failed': 'OpenVPN kimliği kaydedilemedi',
      'openvpn_identity_clear_failed': 'OpenVPN tamamen kaldırılamadı',
      'openvpn_identity_in_use': 'OpenVPN kimliği hâlâ kullanımda',
      'openvpn_tls_verification_required': 'OpenVPN TLS doğrulaması eksik',
      'openvpn_cipher_invalid': 'Geçersiz OpenVPN şifreleme yöntemi',
      'openvpn_profile_rejected': 'OpenVPN profili reddedildi',
      'openvpn_identity_inconsistent': 'Tutarsız OpenVPN kimliği',
      'tls_handshake_failed': 'OpenVPN anlaşması reddedildi',
      'tls_alert_unknown_ca': 'OpenVPN istemci sertifikası tanınmadı',
      'tls_alert_bad_certificate': 'OpenVPN istemci sertifikası reddedildi',
      'tls_alert_unsupported_certificate': 'Desteklenmeyen OpenVPN sertifikası',
      'tls_client_certificate_required':
          'OpenVPN istemci sertifikası gerekiyor',
      'tls_alert_misc': 'OpenVPN TLS uyarısı',
      'tls_signature_algorithm_rejected': 'Desteklenmeyen OpenVPN imzası',
      'tls_handshake_rejected': 'OpenVPN TLS anlaşması reddedildi',
      'tls_version_rejected': 'Uyumsuz OpenVPN TLS sürümü',
      'tls_certificate_expired': 'TLS sertifikasının süresi doldu',
      'tls_certificate_revoked': 'TLS sertifikası iptal edildi',
      'transport_failed': 'OpenVPN sunucusuna ulaşılamıyor',
      'tun_configuration_rejected': 'OpenVPN arayüzü oluşturulamadı',
      'tun_setup_failed': 'OpenVPN TUN kurulumu başarısız oldu',
      'tun_interface_create_failed': 'OpenVPN arayüzü oluşturulamadı',
      'tun_interface_disabled': 'OpenVPN arayüzü devre dışı',
      'tun_halted': 'OpenVPN arayüzü kesintiye uğradı',
      'tun_already_established': 'OpenVPN arayüzü zaten açık',
      'tun_addresses_missing': 'OpenVPN adresi eksik',
      'tun_routes_missing': 'OpenVPN rotaları eksik',
      'tun_dns_missing': 'OpenVPN DNS\'i eksik',
      'tun_permission_revoked': 'VPN izni iptal edildi',
      'tun_establish_returned_null': 'Android VPN arayüzünü reddetti',
      'openvpn_service_start_failed': 'OpenVPN hizmeti kullanılamıyor',
      'openvpn_operation_timeout': 'OpenVPN çağrısının süresi doldu',
      'openvpn_start_failed': 'OpenVPN başlatılması reddedildi',
      'openvpn_connection_failed': 'OpenVPN bağlantısı kesintiye uğradı',
      'openvpn_core_status_error': 'OpenVPN Core bir hatayla sonlandı',
      'openvpn_stopped_before_connected': 'OpenVPN bağlanmadan önce durdu',
      'openvpn_auth_failed': 'OpenVPN kimlik doğrulaması reddedildi',
      'openvpn_client_setup_failed': 'OpenVPN istemcisi kurulamadı',
      'openvpn_client_halted': 'OpenVPN istemcisi kesintiye uğradı',
      'openvpn_client_restart': 'OpenVPN\'in yeniden başlatılması istendi',
      'openvpn_inactive_timeout': 'OpenVPN çok uzun süre etkin değildi',
      'openvpn_session_expired': 'OpenVPN oturumunun süresi doldu',
      'openvpn_credentials_required':
          'Desteklenmeyen OpenVPN kimlik doğrulaması',
      'openvpn_proxy_failed': 'OpenVPN aracı aktarımı başarısız oldu',
      'openvpn_compression_failed': 'OpenVPN sıkıştırması reddedildi',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM şifrelemesi kullanılamıyor',
      'openvpn_feature_unsupported': 'Desteklenmeyen OpenVPN özelliği',
      'network_unavailable': 'İnternet bağlantısı kullanılamıyor',
      'network_lost': 'Ağ kullanılamıyor',
      'certificate_validation_failed': 'Sunucu sertifikası reddedildi',
      'openvpn_certificate_expired': 'OpenVPN sertifikasının süresi doldu',
      'tunnel_active_for_another_account':
          'Başka bir hesabın tüneli hâlâ etkin',
      'tunnel_already_active': 'Yerel tünel zaten etkin',
      'tunnel_stop_timeout': '$protocol durdurulamadı',
      'tunnel_disconnected': '$protocol kesintiye uğradı',
      'native_bridge_unavailable': 'Android köprüsü kullanılamıyor',
      'native_operation_failed': 'Android işlemi kesintiye uğradı',
      'invalid_arguments': 'VPN parametreleri eksik',
      'invalid_account_id': 'Geçersiz VPN hesabı',
      'invalid_device_id': 'Geçersiz cihaz tanımlayıcısı',
      'storage_key_not_allowed': 'Depolama anahtarı reddedildi',
      'secure_storage_read_failed': 'Güvenli okuma başarısız oldu',
      'secure_storage_write_failed': 'Güvenli yazma başarısız oldu',
      'key_generation_failed': 'WireGuard anahtarı oluşturulamadı',
      'csr_generation_failed': 'OpenVPN CSR oluşturulamadı',
      'other': 'Sınıflandırılmamış yerel VPN hatası',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android sürdürülebilir bir VPN oturumu bulamıyor. Uygulamada yeni bir bağlantı başlatın.',
      'system_vpn_resume_corrupt':
          'Kayıtlı VPN sürdürme verileri geçersiz ve kullanılmayacak. Yeni bir bağlantı başlatın.',
      'system_vpn_resume_session_invalid':
          'Kayıtlı oturum artık VPN\'i sürdüremiyor. Uygulamada yeniden oturum açın.',
      'system_vpn_resume_identity_changed':
          'Yerel VPN kimliği değişti. Sürdürme durduruldu; yeni bir bağlantı başlatın.',
      'system_vpn_resume_identity_invalid':
          'Sürdürme kimliği geçersiz. Yeni bir bağlantı başlatın.',
      'system_vpn_resume_storage_failed':
          'Android şifrelenmiş sürdürme verilerini okuyamadı veya güncelleyemedi. Yeni bir bağlantı başlatın.',
      'system_vpn_resume_network_timeout':
          'Android, VPN\'i sürdürmek için zamanında ağ bulamadı. Ağ kullanılabilir olduğunda tekrar deneyin.',
      'system_vpn_resume_blocked':
          'VPN sürdürme işlemi engellendi. Android ayarlarını kontrol edin, ardından yeni bağlantı başlatın.',
      'system_vpn_resume_failed':
          'Android VPN sürdürülemedi. Uygulamada yeni bir bağlantı başlatın.',
      'system_vpn_resume_error_invalid':
          'Android kullanılamaz bir sürdürme hatası döndürdü. Yeni bir bağlantı başlatın.',
      'wireguard_identity_store_failed':
          'Android bu hesabın şifrelenmiş WireGuard kimliğini kaydedemedi.',
      'wireguard_identity_unavailable':
          'Bu bağlantı için kullanılabilir bir WireGuard kimliği yok.',
      'vpn_host_destroyed':
          'VPN\'i barındıran Android bileşeni durduruldu. Yeni bir bağlantı başlatın.',
      'vpn_host_unavailable':
          'Android VPN\'i barındıran bileşeni oluşturamıyor. VPN ayarlarını kontrol ettikten sonra tekrar deneyin.',
      'openvpn_renewal_required':
          'Bağlanmadan önce sertifika için uygulamada işlem yapılması gerekiyor.',
      'openvpn_recovery_failed':
          'Otomatik kurtarma başarısız oldu. Uygulamada yeni bir bağlantı başlatın.',
      'openvpn_recovery_exhausted':
          'Otomatik kurtarma zaten kullanıldı. Uygulamada yeni bir bağlantı başlatın.',
      'vpn_permission_required':
          'Tüneli başlatmadan önce Android yeni bir VPN yetkilendirmesi istiyor.',
      'vpn_permission_denied':
          'Devam etmek için Android isteğinde FuzeVPN\'e izin verin.',
      'vpn_permission_request_failed': 'Android VPN izin ekranını açamadı.',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard hizmetini ön planda tutamadı.',
      'wireguard_identity_invalid':
          'Bu hesabın şifrelenmiş WireGuard anahtarı okunamıyor veya geçersiz.',
      'wireguard_identity_in_use':
          'Başka bir işlem hâlâ bu hesabın WireGuard anahtarını kullanıyor.',
      'wireguard_configuration_invalid':
          'Alınan WireGuard adresi, DNS\'i, sunucu anahtarı veya rotaları geçersiz.',
      'wireguard_operation_pending':
          'Önceki WireGuard işlemi yerel hizmetini henüz serbest bırakmadı.',
      'wireguard_start_failed':
          'WireGuard altyapısı yapılandırmanın etkinleştirilmesini reddetti.',
      'wireguard_stop_timeout':
          'WireGuard hizmeti, VPN arayüzünün süre sınırı içinde serbest bırakıldığını doğrulamadı.',
      'wireguard_handshake_timeout':
          'Tünel, sunucuyla el sıkışmayı zamanında doğrulamadı.',
      'openvpn_connection_timeout':
          'OpenVPN sunucu bağlantısını zamanında doğrulamadı.',
      'openvpn_core_unavailable':
          'Bu uygulama sürümünde kullanılabilir bir OpenVPN altyapısı yok.',
      'openvpn_operation_pending':
          'Yerel altyapı önceki OpenVPN oturumunu hâlâ tutuyor ve ikincisini oluşturmayı reddediyor.',
      'openvpn_stop_timeout':
          'OpenVPN Core, yerel oturumunun süre sınırı içinde durup yok edildiğini doğrulamadı.',
      'openvpn_profile_unavailable':
          'Bu bağlantı için doğrulanmış bir OpenVPN profili okunamıyor.',
      'openvpn_native_failed':
          'Bir uygulama hatası OpenVPN\'i kesintiye uğrattı. Yeniden bağlanmayı deneyin. Sorun devam ederse tanılama çalıştırın.',
      'openvpn_key_generation_failed':
          'Android Keystore dışa aktarılamayan P-256 özel anahtarını oluşturamadı veya okuyamadı.',
      'openvpn_csr_generation_failed':
          'Android Keystore anahtarı OpenVPN sertifika isteğini imzalayamadı.',
      'openvpn_identity_store_failed':
          'OpenVPN sertifikası veya profili şifrelenmiş depolamaya kaydedilemedi.',
      'openvpn_identity_clear_failed':
          'Android bu hesabın yerel OpenVPN kimliğinin tamamını kaldıramadı.',
      'openvpn_identity_in_use':
          'Yerel bir OpenVPN oturumu hâlâ bu cihazın anahtarını veya sertifikasını kullanıyor.',
      'openvpn_tls_verification_required':
          'Profil, sunucu sertifikası doğrulamasını açıkça istemiyor.',
      'openvpn_cipher_invalid':
          'Sunucu izin verilen listede bulunmayan bir şifreleme algoritması sağladı.',
      'openvpn_profile_rejected':
          'Sunucudan alınan profil uyumsuz. Bu cihazı yeniden oluşturun ve tekrar deneyin.',
      'openvpn_identity_inconsistent':
          'Sertifika bu telefonun güvenli kimliğiyle eşleşmiyor. Yerel profil değiştirilmedi.',
      'tls_handshake_failed':
          'Sunucu TLS anlaşmasını reddetti. Sorun devam ederse profili yeniden oluşturun.',
      'tls_alert_unknown_ca':
          'Sunucu bu cihaz sertifikasının yetkilisini tanımıyor. OpenVPN sunucusu kontrol edilmeli.',
      'tls_alert_bad_certificate':
          'Sunucu bu cihaz sertifikasını reddetti. Tekrar denemeden önce cihazı yeniden oluşturun.',
      'tls_alert_unsupported_certificate':
          'Sunucu Android\'in kullandığı güvenli sertifika türünü desteklemiyor.',
      'tls_client_certificate_required':
          'Sunucu istemci sertifikası istiyor ancak OpenVPN Core bunu sunamadı.',
      'tls_alert_misc':
          'Sunucu sertifika ve sürüm kategorileri dışından bir TLS uyarısı döndürdü.',
      'tls_signature_algorithm_rejected':
          'Sunucu Android Keystore anahtarının ECDSA P-256 algoritmasını reddetti.',
      'tls_handshake_rejected':
          'Sunucu bağlantıdan önce TLS anlaşmasını kesintiye uğrattı.',
      'tls_version_rejected':
          'İstemci ve sunucu ortak bir TLS sürümü bulamadı.',
      'tls_certificate_expired':
          'Bağlantı sırasında sunulan sertifikanın süresi doldu.',
      'tls_certificate_revoked':
          'Bağlantı sırasında sunulan sertifika iptal edildi.',
      'transport_failed':
          'OpenVPN sunucusu mevcut ağda yanıt vermiyor. Kısa süre sonra tekrar deneyin.',
      'tun_configuration_rejected':
          'Android, OpenVPN tarafından istenen ağ yapılandırmasını reddetti.',
      'tun_setup_failed':
          'OpenVPN Core, Android arayüzünü oluşturmadan önce ağ planını reddetti.',
      'tun_interface_create_failed':
          'OpenVPN Core, Android VpnService üzerinden TUN arayüzünü alamadı.',
      'tun_interface_disabled':
          'Android veya OpenVPN Core bağlantı sırasında TUN arayüzünü devre dışı bıraktı.',
      'tun_halted': 'OpenVPN Core, TUN arayüzünü durdurma isteği aldı.',
      'tun_already_established':
          'OpenVPN aynı bağlantıda ikinci bir arayüz istedi. Tünel güvenlik amacıyla durduruldu.',
      'tun_addresses_missing':
          'Sunucu kullanılabilir bir tünel adresi sağlamadı.',
      'tun_routes_missing': 'Sunucu kullanılabilir tünel rotaları sağlamadı.',
      'tun_dns_missing': 'Sunucu kullanılabilir bir DNS sunucusu sağlamadı.',
      'tun_permission_revoked':
          'Android bağlantı sırasında VPN iznini iptal etti.',
      'tun_establish_returned_null':
          'Android arayüzü oluşturmadı; bunun nedeni genellikle başka bir VPN\'in hâlâ etkin olmasıdır.',
      'openvpn_service_start_failed':
          'Android OpenVPN ön plan hizmetini başlatamadı.',
      'openvpn_operation_timeout':
          'OpenVPN Core\'a yapılan JNI çağrısı izin verilen süreyi aştı.',
      'openvpn_start_failed':
          'Android hizmeti hazır ancak OpenVPN Core profili başlatmayı kabul etmedi.',
      'openvpn_connection_failed':
          'OpenVPN Core CONNECTED olayını yayınlamadan durdu.',
      'openvpn_core_status_error':
          'Yerel OpenVPN döngüsü bir hatayla ve daha özel bir son olay olmadan sona erdi.',
      'openvpn_stopped_before_connected':
          'Yerel OpenVPN döngüsü CONNECTED durumundan önce, açık bir Core hatası olmadan durdu.',
      'openvpn_auth_failed':
          'OpenVPN sunucusu profil kimlik doğrulamasını reddetti.',
      'openvpn_client_setup_failed':
          'OpenVPN Core ağ bağlantısından önce istemciyi başlatamadı.',
      'openvpn_client_halted':
          'OpenVPN Core istemcinin sonlandırılmasını istedi.',
      'openvpn_client_restart':
          'OpenVPN Core aktarım oturumunun yeniden başlatılmasını istedi.',
      'openvpn_inactive_timeout':
          'OpenVPN Core etkin olmama süresi dolduktan sonra oturumu kapattı.',
      'openvpn_session_expired':
          'Sunucu OpenVPN oturumunun süresinin dolduğunu bildirdi.',
      'openvpn_credentials_required':
          'Sunucu veya proxy, bu sertifika profilinde bulunmayan etkileşimli kimlik bilgileri istiyor.',
      'openvpn_proxy_failed':
          'OpenVPN Core yapılandırılmış proxy veya aktarıcıda hata bildirdi.',
      'openvpn_compression_failed':
          'OpenVPN Core, profil veya sunucu tarafından bildirilen sıkıştırma kipini reddetti.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil, bu sürümde kullanılamayan NTLM şifrelemesi istiyor.',
      'openvpn_feature_unsupported':
          'Profil veya sunucu, bu Android istemcisinde bulunmayan bir özellik istiyor.',
      'network_unavailable': 'Kullanılabilir fiziksel ağ yok.',
      'network_lost': 'Ağ kaybolduktan sonra tünel durduruldu.',
      'certificate_validation_failed':
          'OpenVPN sunucusunun kimliği doğrulanamadı.',
      'openvpn_certificate_expired':
          'Yeniden bağlanmadan önce OpenVPN profilini yenileyin.',
      'tunnel_active_for_another_account':
          'Bu bağlantıdan önce başka bir hesaba ait tünel durdurulmalı.',
      'tunnel_already_active':
          'Android, önceki bir VPN oturumunun hâlâ arayüzü kullandığını bildiriyor.',
      'tunnel_stop_timeout':
          '$protocol altyapısı, VPN arayüzünün süre sınırı içinde serbest bırakıldığını doğrulamadı.',
      'tunnel_disconnected':
          'Yerel altyapı, tünelin başladıktan sonra beklenmedik şekilde sona erdiğini bildirdi.',
      'native_bridge_unavailable':
          'Uygulama Android VPN hizmetine erişemiyor. Uygulamayı kapatıp yeniden açın ve tekrar deneyin.',
      'native_operation_failed':
          'Bir uygulama hatası VPN işlemini kesintiye uğrattı. Tekrar deneyin. Sorun devam ederse tanılama çalıştırın.',
      'invalid_arguments':
          'Bu VPN işlemi için gereken bilgiler eksik. Tekrar deneyin. Sorun devam ederse tanılama çalıştırın.',
      'invalid_account_id':
          'Yerel işlem geçerli bir hesap tanımlayıcısıyla ilişkilendirilmemiş.',
      'invalid_device_id':
          'Yerel altyapıya gönderilen cihaz tanımlayıcısı eksik veya geçersiz.',
      'storage_key_not_allowed':
          'Android köprüsü, izin verilen depolama listesinin dışındaki bir anahtarı engelledi.',
      'secure_storage_read_failed':
          'Android Keystore bu hesabın yerel verilerinin şifresini çözemedi.',
      'secure_storage_write_failed':
          'Android Keystore yerel verileri şifreleyemedi veya kaydedemedi.',
      'key_generation_failed':
          'Android, WireGuard anahtarını güvenli depolamada oluşturamadı veya okuyamadı.',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR\'ını oluşturamadı veya imzalayamadı.',
      'other':
          'Belgelenmemiş bir yerel dal başarısız oldu. Aşağıda gösterilen tanılama kodunu desteğe gönderin.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'İzin isteği zaten açık';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN izin isteği zaten görüntüleniyor. Tekrar denemeden önce işlemi tamamlayın.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN izin isteği kesintiye uğradı';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Uygulama yanıtı almadan önce VPN izin ekranı kapandı.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN bağlantısı doğrulanamadı';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN bağlantısı doğrulanamadı. Güvenlik amacıyla durduruldu. Tekrar deneyin.';

  @override
  String get openvpnCleanup_title => 'OpenVPN profili iptal edildi';

  @override
  String get openvpnCleanup_working =>
      'İptal edilen OpenVPN profili durduruluyor ve kaldırılıyor…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN\'in kapatıldığı doğrulanamadı. Yeni profil oluşturmadan önce tekrar deneyin.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'İptal edilen OpenVPN profili tamamen kaldırılamadı. Temizleme işlemini yeniden deneyin.';

  @override
  String get openvpnCleanup_complete =>
      'İptal edilen OpenVPN profili kaldırıldı. Yeni bir profil oluşturmak için Bağlan\'a dokunun.';

  @override
  String get network_title => 'Ağ yapılandırması';

  @override
  String get network_ipv4Fallback =>
      'IPv6 geçici olarak kullanılamıyor. Hazırlık IPv4 ile devam ediyor.';

  @override
  String get network_rejectedTitle => 'Ağ yapılandırması reddedildi';

  @override
  String get network_rejectedMessage =>
      'Tünel yapılandırması eksik veya izin verilen adreslerle eşleşmiyor. Uygulamadan tekrar deneyin.';

  @override
  String get network_unreadableTitle => 'Yerel yapılandırma okunamıyor';

  @override
  String get network_unreadableMessage =>
      'Kayıtlı OpenVPN ağ yapılandırması kullanılamıyor. Güncellemek için uygulamadan yeniden bağlanın.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ağ koruması';

  @override
  String get protection_subtitle =>
      'VPN bağlantısı kesilirse doğrudan internet erişimini engelleyin.';

  @override
  String get protection_active => 'Sistem koruması etkin';

  @override
  String get protection_alwaysOnOnly =>
      'Her zaman açık VPN etkin; VPN dışındaki bağlantıları engellemeyi açın';

  @override
  String get protection_inactive => 'Sistem koruması etkin değil';

  @override
  String get protection_unknown => 'Sistem korumasını kontrol et';

  @override
  String get protection_openSettings => 'Android ayarlarını aç';

  @override
  String get protection_dialogTitle => 'Ağ korumasını ayarla';

  @override
  String get protection_dialogMessage =>
      'Android, her zaman açık VPN\'i ve VPN dışındaki bağlantıların engellenmesini yönetir. FuzeVPN\'in seçili olduğunu kontrol edin ve sistem ayarlarında engellemeyi etkinleştirin.';

  @override
  String get protection_dialogOpen => 'Ayarları aç';

  @override
  String get session_systemProtectionNote =>
      'Android VPN dışındaki trafiği hâlâ engelliyorsa bu korumayı kontrol etmek veya değiştirmek için sistem ayarlarını açın.';

  @override
  String get diagnostics_title => 'Tanılama';

  @override
  String get diagnostics_settingsTitle => 'Uygulama tanılaması';

  @override
  String get diagnostics_automaticTitle => 'Önemli hataları gönder';

  @override
  String get diagnostics_automaticDescription =>
      'Önemli bir hata oluştuğunda küçük bir teknik rapor paylaşın.';

  @override
  String get diagnostics_privacy =>
      'Gönderilen raporlar oturum açılmış hesaba bağlanır ve 30 gün saklanır. Bu raporlar tarama geçmişi, şifre veya VPN anahtarı içermez.';

  @override
  String get diagnostics_manualOpen => 'Tanılama çalıştır';

  @override
  String get diagnostics_localDescription =>
      'Uygulama ve VPN durumu hakkında rapor oluşturun. Bağlantınız değişmeden kalır.';

  @override
  String get diagnostics_sendReport => 'Raporu gönder';

  @override
  String get diagnostics_sendHint =>
      'Raporu bu cihazda tutmak için bu kutuyu işaretlemeden bırakın.';

  @override
  String get diagnostics_signedOut =>
      'Rapor göndermek için hesabınıza giriş yapın.';

  @override
  String get diagnostics_localLifetime =>
      'Uygulamayı kapattıktan sonra da saklamak için bu raporu telefonunuza kaydedin.';

  @override
  String get diagnostics_run => 'Tanılama çalıştır';

  @override
  String get diagnostics_rerun => 'Tanılamayı yeniden çalıştır';

  @override
  String get diagnostics_running => 'Kontrol ediliyor…';

  @override
  String get diagnostics_sending => 'Rapor gönderiliyor…';

  @override
  String get diagnostics_prepared => 'Rapor bu cihazda hazır';

  @override
  String get diagnostics_queued => 'Rapor gönderilmeyi bekliyor';

  @override
  String get diagnostics_sent => 'Rapor alındı';

  @override
  String get diagnostics_failed =>
      'Gönderme başarısız oldu. Yerel raporunuz hâlâ kullanılabilir.';

  @override
  String get diagnostics_preparationFailed =>
      'Tanılama raporu hazırlanamadı. Tekrar deneyin.';

  @override
  String get diagnostics_authenticationRequired =>
      'Raporu göndermek için yeniden oturum açın.';

  @override
  String get diagnostics_retry => 'Göndermeyi yeniden dene';

  @override
  String get diagnostics_export => 'Raporu kaydet';

  @override
  String get diagnostics_exportFailed =>
      'Dışa aktarma başarısız oldu. Yerel rapordan tekrar deneyin.';

  @override
  String get diagnostics_preferenceFailed =>
      'Bu ayar kaydedilemedi. Tekrar deneyin.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referans: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date tarihinde alındı';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date tarihine kadar saklanır';
  }

  @override
  String get diagnostics_duplicate => 'Bu rapor daha önce alınmış.';

  @override
  String get diagnostics_preview => 'Rapor önizlemesi';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teknik olay eklendi',
      one: '1 teknik olay eklendi',
      zero: 'Eklenmiş teknik olay yok',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Teknik ayrıntılar';

  @override
  String get diagnostics_empty => 'Henüz hiçbir tanılama raporu hazırlanmadı.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Tünel durumu',
      'handshake': 'Bağlantı doğrulaması',
      'certificate': 'VPN sertifikası',
      'kill_switch': 'Android koruması',
      'connectivity': 'Kullanılabilir ağ',
      'api_reachability': 'Hizmete erişim',
      'secure_storage': 'Güvenli depolama',
      'other': 'Yerel kontrol',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Kontrol edildi',
      'failed': 'İncelenmeli',
      'skipped': 'Test edilmedi — etkin denetim yok',
      'unknown': 'Bilgi kullanılamıyor',
      'other': 'Bilgi kullanılamıyor',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN\'e hoş geldiniz';

  @override
  String get connection_changeLocation => 'Konumu değiştir';

  @override
  String get connection_details => 'Bağlantı ayrıntıları';

  @override
  String get locations_searchLabel => 'Şehir veya ülke arayın';

  @override
  String get locations_clearSearch => 'Aramayı temizle';

  @override
  String get locations_filterAll => 'Tümü';

  @override
  String get locations_filterFavorites => 'Favoriler';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konum',
      one: '$count konum',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Konum bulunamadı';

  @override
  String get locations_noResultsHint => 'Başka bir şehir veya ülke deneyin.';

  @override
  String get locations_noFavorites => 'Favorileriniz elinizin altında';

  @override
  String get locations_noFavoritesHint =>
      'Buraya kaydetmek için bir konumun yanındaki yıldıza dokunun.';

  @override
  String get locations_showAll => 'Tüm konumları gör';

  @override
  String locations_addFavorite(String name) {
    return '$name konumunu favorilere ekle';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name konumunu favorilerden kaldır';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Favori kaydedilemedi. Tekrar deneyin.';

  @override
  String get locations_emptyTitle => 'Kullanılabilir konum yok';

  @override
  String get locations_emptyHint => 'Tekrar denemek için listeyi yenileyin.';

  @override
  String get devices_manage => 'Cihazlarımı yönet';

  @override
  String get settings_personalization => 'Kişiselleştir';

  @override
  String get settings_safety => 'Koruma';

  @override
  String get settings_help => 'Yardıma mı ihtiyacınız var?';

  @override
  String get settings_about => 'FuzeVPN hakkında';

  @override
  String get diagnostics_heading => 'Bağlantı sorununu anlayın';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Kullanılabilir',
      'pending': 'Hazırlanıyor',
      'revoked': 'Kaldırıldı',
      'expired': 'Süresi doldu',
      'other': 'Durum kullanılamıyor',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Tercih kaydedilmedi';

  @override
  String get notice_preferenceSave_message =>
      'Seçiminiz şimdilik uygulandı ancak kaydedilemedi. Uygulamayı kapattıktan sonra da korunması için tekrar deneyin.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPN\'i etkin tutmaya devam ederse açılan ayarlardan Her zaman açık VPN\'i kapatın.';

  @override
  String get protection_learnMore => 'Android koruması hakkında bilgi alın';

  @override
  String get protection_guideWhy =>
      'Bu koruma, VPN bağlantısı kesilirse uygulamaların doğrudan interneti kullanmasını önler. Android\'de yapılandırılır.';

  @override
  String get protection_guideAlwaysOnTitle => 'Her zaman açık VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN hizmetini çalışır durumda tutar ve telefon yeniden başlatıldıktan sonra yeniden başlatabilir.';

  @override
  String get protection_guideBlockTitle => 'VPN olmadan bağlantıları engelle';

  @override
  String get protection_guideBlock =>
      'Bu ayar, bağlantı kesintiye uğradığında da dâhil olmak üzere trafiğin VPN\'i atlamasını önler.';

  @override
  String get protection_guideWarning =>
      'Bu engelleme etkin olduğunda, VPN bağlanana kadar internet erişimi kapalı kalır.';

  @override
  String get protection_guideStepsTitle => 'Korumayı aç';

  @override
  String get protection_guideStep1 =>
      'Aşağıdaki düğmeyle Android VPN ayarlarını açın.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN\'in yanındaki dişli simgesini kullanarak seçenekleri açın.';

  @override
  String get protection_guideStep3 =>
      'Varsa Her zaman açık VPN\'i, ardından VPN olmadan bağlantıları engelle seçeneğini etkinleştirin.';

  @override
  String get protection_guideManufacturers =>
      'Adlar telefona göre değişir. Gerekirse Ayarlar\'da, genellikle Ağ ve internet bölümünün altında VPN\'i arayın.';

  @override
  String get protection_guideDisableTitle => 'Bu korumayı kapat';

  @override
  String get protection_guideDisable =>
      'Aynı ayarlarda, VPN olmadan internet erişimine izin vermek için VPN olmadan engellemeyi kapatın. Android\'in artık yeniden başlatmasını istemiyorsanız Her zaman açık VPN\'i de kapatın.';

  @override
  String get protection_guideManual =>
      'Bu ayarları Android\'de siz seçersiniz. FuzeVPN bunları sizin için değiştirmez.';

  @override
  String get locations_changeTitle => 'Konum değiştirilsin mi?';

  @override
  String locations_changeActive(String name) {
    return 'VPN bağlantısı kesilecek, ardından $name konumuna bağlanmaya çalışılacak.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN, $name konumuna bağlanmaya çalışacak.';
  }

  @override
  String get locations_confirmChange => 'Değiştir ve bağlan';

  @override
  String get locations_changeBusy =>
      'Bir değişiklik devam ediyor. Başka bir konum seçmeden önce bekleyin.';

  @override
  String get locations_automaticSelection => 'Otomatik seçim';

  @override
  String get locations_cities => 'Şehirler';

  @override
  String get locations_servers => 'Sunucular';

  @override
  String locations_viewCities(String name) {
    return '$name içindeki şehirleri gör';
  }

  @override
  String locations_viewServers(String name) {
    return '$name içindeki sunucuları gör';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ülke',
      one: '$count ülke',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count şehir',
      one: '$count şehir',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sunucu',
      one: '$count sunucu',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Tüm ülkeler';

  @override
  String get locations_backToCountries => 'Ülkelere dön';

  @override
  String locations_backToCities(String name) {
    return '$name içindeki şehirlere dön';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name seç';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name seç';
  }

  @override
  String get locations_noCompatibleServer => 'Uyumlu sunucu yok.';

  @override
  String get externalLink_failed =>
      'Bu bağlantı açılamadı. Bağlantıyı kopyalayıp tarayıcınızda açabilirsiniz.';

  @override
  String get externalLink_copy => 'Bağlantıyı kopyala';

  @override
  String get externalLink_copied => 'Bağlantı kopyalandı';

  @override
  String get externalLink_copyFailed =>
      'Bağlantı kopyalanamadı. Aşağıdaki adresi seçin.';

  @override
  String get settings_deleteAccount => 'Hesabımı sil';

  @override
  String get settings_deleteAccountDetail =>
      'Hesap silme talebi adımlarını görüntüle';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'VPN aboneliğinizi seçin.';

  @override
  String get billing_subscribe => 'Abone ol';

  @override
  String get billing_choosePlan => 'Devam etmek için bir plan seçin.';

  @override
  String get billing_monthly => 'Aylık';

  @override
  String get billing_yearly => 'Yıllık';

  @override
  String get billing_continue => 'Google Play ile devam et';

  @override
  String get billing_restore => 'Satın alımları geri yükle';

  @override
  String get billing_manage => 'Aboneliği yönet';

  @override
  String get billing_deleteAccountWarning =>
      'Google Play aboneliğiniz varsa FuzeVPN hesabınızı silmek aboneliğin yenilenmesini iptal etmez. Yenilemeyi Google Play\'de ayrıca yönetin veya iptal edin.';

  @override
  String get billing_deleteAccountContinue => 'Hesap silme talebine devam et';

  @override
  String get billing_refresh => 'Erişimi yenile';

  @override
  String get billing_loadingPlans => 'Planlar yükleniyor…';

  @override
  String get billing_unavailable =>
      'Şu anda kullanılabilir plan yok. Daha sonra tekrar deneyin.';

  @override
  String get billing_comingSoon => 'Abonelikler yakında kullanıma sunulacak.';

  @override
  String get billing_priceDisclosure =>
      'Fiyat Google Play tarafından sağlanır. Son tutar ve geçerli vergiler, onayınızdan önce doğrulanır.';

  @override
  String get billing_renewalMonthly =>
      'İptal edilmezse her ay otomatik yenilenir. Google Play aboneliklerinden istediğiniz zaman iptal edebilirsiniz.';

  @override
  String get billing_renewalYearly =>
      'İptal edilmezse her yıl otomatik yenilenir. Google Play aboneliklerinden istediğiniz zaman iptal edebilirsiniz.';

  @override
  String get billing_active => 'Premium erişiminiz etkin';

  @override
  String billing_accessUntil(String date) {
    return '$date tarihine kadar erişim.';
  }

  @override
  String get billing_webManaged =>
      'Aboneliğiniz FuzeVPN web sitesinden yönetilir.';

  @override
  String get billing_playManaged =>
      'Aboneliğiniz Google Play üzerinden yönetilir.';

  @override
  String get billing_inactive => 'Etkin abonelik yok.';

  @override
  String get billing_checkingAccess => 'Erişiminiz kontrol ediliyor…';

  @override
  String get billing_restoring => 'Satın alımlar geri yükleniyor…';

  @override
  String get billing_pending =>
      'Ödeme beklemede. Erişiminiz onaydan sonra etkinleştirilecek.';

  @override
  String get billing_cancelled =>
      'Satın alma iptal edildi. Yeni abonelik etkinleştirilmedi.';

  @override
  String get billing_verifying => 'Satın alma doğrulanıyor…';

  @override
  String get billing_success =>
      'Abonelik etkinleştirildi. Premium erişiminiz hazır.';

  @override
  String get billing_restored => 'Satın alımlarınız geri yüklendi.';

  @override
  String get billing_restoreEmpty =>
      'Bu Google Play hesabında geri yüklenecek satın alma yok.';

  @override
  String get billing_catalogError => 'Planlar yüklenemedi. Tekrar deneyin.';

  @override
  String get billing_purchaseError =>
      'Satın alma başlatılamadı. Tekrar deneyin.';

  @override
  String get billing_verificationError =>
      'Satın alma doğrulaması geçici olarak kullanılamıyor. Tekrar denemek için satın alımları geri yükleyin.';

  @override
  String get billing_restoreError =>
      'Satın alımlar geri yüklenemedi. Tekrar deneyin.';

  @override
  String get billing_managementError =>
      'Abonelik yönetimi açılamadı. Tekrar deneyin.';

  @override
  String get billing_storeUnavailable =>
      'Google Play bu cihazda kullanılamıyor.';

  @override
  String get welcome_title => 'VPN’iniz, artık daha kolay.';

  @override
  String get welcome_description =>
      'Bağlantınızı koruyun. Gizliliğinizin kontrolünü elinizde tutun.';

  @override
  String get welcome_start => 'Başlayın';

  @override
  String get welcome_alreadyPurchased => 'Zaten satın aldınız mı?';

  @override
  String get welcome_noAccountRequired =>
      'Başlamak için hesap oluşturmanız gerekmez.';

  @override
  String get guest_accountTitle => 'Hesap bağlanmadı';

  @override
  String get guest_accountDescription =>
      'Aboneliğinizi başka bir cihazda kullanmak için aynı Google Play hesabıyla satın alımlarınızı geri yükleyin.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Zaten abone misiniz? Giriş yapın';

  @override
  String get guest_claimTitle => 'FuzeVPN her yerde yanınızda';

  @override
  String get guest_claimDescription =>
      'Aboneliğinize diğer cihazlarınızdan erişmek için hesap oluşturun. Bu adım isteğe bağlıdır.';

  @override
  String get guest_skip => 'Daha sonra';

  @override
  String get guest_activationTitle => 'Fuze Premium etkin';

  @override
  String get guest_activationDescription =>
      'Aboneliğiniz hazır. VPN’inizi kullanın ve istediğiniz zaman hesap oluşturun.';

  @override
  String get guest_useVpn => 'VPN’imi kullan';

  @override
  String get guest_loginRequired =>
      'Bu satın alım zaten bir FuzeVPN hesabına bağlı. Aboneliğinize erişmek için o hesapta oturum açın.';

  @override
  String get guest_signOutWarning =>
      'Aynı Google Play hesabıyla satın alımları geri yükleyerek aboneliğinizi kurtarabilirsiniz.';

  @override
  String get guest_profileUnavailable =>
      'Hesabınız zaten bağlı. Bilgilerinizi görmek ve yönetmek için oturum açın.';

  @override
  String get billing_acceptance =>
      'Devam ederek Kullanım Koşullarını ve Gizlilik Politikasını kabul edersiniz.';

  @override
  String get guest_verifyEmailReminder =>
      'Hesabınızı güvene almak için e-posta adresinizi doğrulayın. VPN’inizi kullanmaya devam edebilirsiniz.';

  @override
  String get guest_serviceUnavailable =>
      'Hizmet geçici olarak kullanılamıyor. Birazdan tekrar deneyin.';

  @override
  String get guest_restoreError =>
      'Satın alımlarınız geri yüklenemedi. Satın alımda kullandığınız Google Play hesabıyla tekrar deneyin.';

  @override
  String get guest_claimSuccess =>
      'Hesabınız oluşturuldu. Aboneliğiniz ve VPN erişiminiz korunuyor.';

  @override
  String get guest_emailExists =>
      'Bu e-posta adresi zaten kullanılıyor. Başka bir adres seçin veya mevcut hesabınızda oturum açın. Satın alımınız Google Play üzerinden kullanılabilir durumda kalır.';

  @override
  String get guest_claimError =>
      'Hesabınız oluşturulamadı. VPN’inizi kullanmaya devam edebilir ve daha sonra tekrar deneyebilirsiniz.';

  @override
  String get guest_secureStorageError =>
      'Oturumunuz bu cihazda güvene alınamadı. Tekrar deneyin.';

  @override
  String get guest_premiumRequired =>
      'VPN’inizi etkinleştirmek için bir abonelik seçin.';

  @override
  String get welcome_viewPlans => 'Planları görüntüle';

  @override
  String get google_continue => 'Google ile devam et';

  @override
  String get google_or => 'veya';

  @override
  String get google_title => 'FuzeVPN hesabınız';

  @override
  String get google_settingUp => 'Hesabınızı tamamlayın';

  @override
  String get google_country => 'İkamet edilen ülke';

  @override
  String get google_profileDescription =>
      'FuzeVPN hesabınızı oluşturmak için ülkenizi seçin ve iki belgeyi inceleyin.';

  @override
  String get google_claimDescription =>
      'Misafir hesabınızı Google ile bağlayın. Aboneliğiniz ve cihazınız bu hesaba bağlı kalır.';

  @override
  String get google_linkTitle => 'Google hesabını FuzeVPN ile bağla';

  @override
  String get google_linkDescription =>
      'Mevcut FuzeVPN hesabınıza erişimi doğrulayın. Google şifreniz istenmez.';

  @override
  String get google_password => 'FuzeVPN şifresi';

  @override
  String get google_linkAccount => 'Bağlantıyı onayla';

  @override
  String get google_requestEmail => 'Onay e-postası gönder';

  @override
  String get google_emailInstructions =>
      'FuzeVPN e-postasını açın ve onay kodunu girin.';

  @override
  String get google_emailCode => 'E-posta onay kodu';

  @override
  String get google_confirmEmail => 'Kodu onayla';

  @override
  String get google_restart => 'Başka bir Google hesabı seç';

  @override
  String get google_resume => 'Bu denemeyi kontrol et';

  @override
  String get google_unavailable =>
      'Google ile giriş kullanılamıyor. E-posta ve şifrenizi kullanabilirsiniz.';

  @override
  String get google_expired =>
      'Bu denemenin süresi doldu. İptal edip yeniden başlayın.';

  @override
  String get google_conflict =>
      'Bu Google hesabı başka bir hesaba bağlı. Mevcut hesabınız ve aboneliğiniz korunur.';

  @override
  String get google_error =>
      'Google ile giriş başarısız. Tekrar deneyin; mevcut erişiminiz korunur.';

  @override
  String get google_uncertain =>
      'Sonuç doğrulanamadı. Bu denemeyi kontrol edin veya yeniden başlamadan önce iptal edin.';

  @override
  String get google_cancelFailed =>
      'İptal doğrulanamadı. Bu ekrandan çıkmadan önce yeniden iptal etmeyi deneyin.';

  @override
  String get google_cancelled => 'Google ile giriş iptal edildi.';

  @override
  String get google_selecting => 'Google hesabınızı seçin…';

  @override
  String get google_verifying => 'Hesabınız kontrol ediliyor…';

  @override
  String get google_emailUnavailable =>
      'Onay e-postası gönderilemedi. Daha sonra deneyin.';

  @override
  String get google_emailSent =>
      'Onay e-postası gönderildi. Gelen kutunuzu kontrol edin.';

  @override
  String get google_rateLimited => 'Tekrar denemeden önce lütfen bekleyin.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN şifresi yanlış. Mevcut hesabınız korunur.';

  @override
  String get google_invalidCode => 'Onay kodu geçersiz veya süresi dolmuş.';

  @override
  String get google_accountChanged =>
      'Oturum değişti. Yeniden başlamadan önce bu denemeyi iptal edin.';

  @override
  String get google_invalidResponse =>
      'Yanıt doğrulanamadı. Mevcut erişiminiz korunur.';

  @override
  String get google_invalidRegistration => 'Ülkeyi ve iki onayı kontrol edin.';

  @override
  String get google_consentRequired =>
      'Devam etmek için ülkenizi seçip iki belgeyi kabul edin.';

  @override
  String get google_challengeRequired =>
      'Ek güvenlik doğrulaması gerekiyor. Mevcut erişiminiz korunur.';

  @override
  String get google_challengeUnavailable =>
      'Güvenlik doğrulaması kullanılamıyor. Daha sonra deneyin.';

  @override
  String get billing_trialTitle => 'Fuze Premium’u ücretsiz deneyin';

  @override
  String get billing_trialSubtitle => 'Bağlantınızı bugünden itibaren koruyun.';

  @override
  String get billing_trialWeeks => '2 haftalık ücretsiz deneme';

  @override
  String billing_trialDays(String days) {
    return '$days günlük ücretsiz deneme';
  }

  @override
  String get billing_trialStart => 'Ücretsiz denememi başlat';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Bugün başlarsanız ilk tahsilatın $date tarihinde yapılması beklenir.';
  }

  @override
  String get billing_trialTerms =>
      'Belirtilen fiyatla otomatik olarak yenilenir. Ücret alınmaması için deneme bitmeden Google Play’den iptal edin.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Ardından ayda $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Ardından yılda $price';
  }

  @override
  String get billing_choosePeriod => 'Planınızı seçin';

  @override
  String get billing_selectionHint => 'Devam etmek için bir plan seçin.';

  @override
  String get billing_benefitConnection => 'Şifreli bağlantı';

  @override
  String get billing_benefitPrivacy => 'Çevrimiçi gizlilik';

  @override
  String get billing_benefitNoAccount => 'Kayıt zorunlu değil';

  @override
  String get billing_cancellation => 'Google Play’den iptal';

  @override
  String get billing_premiumTitle => 'Bağlantınız daha iyi korunsun.';

  @override
  String get billing_premiumSubtitle =>
      'Bağlantınızı size uygun şekilde koruyun.';

  @override
  String get billing_priceMonthly => 'aylık';

  @override
  String get billing_priceYearly => 'yıllık';

  @override
  String get billing_trialToday => 'Bugün ödeme yok';

  @override
  String get billing_trialConfirmation =>
      'Google Play, onayınızdan önce tarihleri, son tutarı ve geçerli vergileri doğrular.';

  @override
  String get billing_offerChanged =>
      'Bu teklifin koşulları değişti. Planları yenileyip tekrar seçin.';

  @override
  String get status_waitingNetwork => 'Ağ bekleniyor';

  @override
  String get status_waitingNetworkDetail =>
      'Kullanılabilir ağ yok. Ağ geri geldiğinde VPN bağlantıyı doğrulayacak.';

  @override
  String get locations_favoriteLoadFailed =>
      'Favoriler yüklenemedi. Tekrar deneyin.';

  @override
  String get locations_favoritesLoading => 'Favoriler yükleniyor…';
}
