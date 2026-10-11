// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Lindungi sambungan anda';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN menggunakan perkhidmatan VPN Android (VpnService) untuk mewujudkan terowong disulitkan antara peranti ini dengan pelayan FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Semasa VPN aktif, trafik Internet aplikasi anda, alamat destinasi dan permintaan DNS melalui terowong ini untuk menghalakan sambungan anda, walaupun FuzeVPN berjalan di latar belakang.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikasi menggunakan status sambungan, tempohnya dan jumlah data yang dipindahkan untuk memaparkan sambungan VPN anda. Anda boleh menghentikannya pada bila-bila masa.';

  @override
  String get vpnDisclosure_privacy => 'Privasi';

  @override
  String get vpnDisclosure_accept => 'Terima dan teruskan';

  @override
  String get vpnDisclosure_decline => 'Bukan sekarang';

  @override
  String get accountRestoration_title => 'Akaun tidak tersedia buat sementara';

  @override
  String get accountRestoration_message =>
      'Sesi anda telah disimpan. Cuba lagi untuk memulihkan akaun; anda masih boleh mengurus sambungan VPN di sini.';

  @override
  String get action_retry => 'Cuba lagi';

  @override
  String get session_endingTitle => 'Menamatkan sesi';

  @override
  String get session_ending =>
      'Sesi anda telah dibatalkan. Menghentikan VPN dan mengosongkan sesi…';

  @override
  String get session_stopFailed =>
      'Penutupan VPN belum disahkan. Cuba lagi sebelum log masuk semula.';

  @override
  String get session_cleanupFailed =>
      'VPN telah dihentikan, tetapi penghapusan sesi belum disahkan. Cuba bersihkan lagi.';

  @override
  String get session_retryStop => 'Cuba tutup lagi';

  @override
  String get session_retryCleanup => 'Cuba bersihkan lagi';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Menyediakan FuzeVPN dengan selamat…';

  @override
  String get nav_connection => 'Sambungan';

  @override
  String get nav_locations => 'Lokasi';

  @override
  String get nav_account => 'Akaun';

  @override
  String get nav_devices => 'Peranti';

  @override
  String get nav_settings => 'Tetapan';

  @override
  String get action_refresh => 'Muat semula';

  @override
  String get auth_tab_login => 'Log masuk';

  @override
  String get auth_tab_register => 'Daftar';

  @override
  String get auth_stepAccount => 'Akaun';

  @override
  String get auth_stepIdentity => 'Identiti';

  @override
  String get auth_stepAddress => 'Alamat dan perjanjian';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Langkah $current daripada $total';
  }

  @override
  String get auth_tagline => 'VPN anda, dipermudahkan.';

  @override
  String get auth_keysLocal =>
      'Kunci VPN peribadi anda kekal pada peranti ini.';

  @override
  String get form_email => 'Alamat e-mel';

  @override
  String get form_password => 'Kata laluan';

  @override
  String get form_showPassword => 'Tunjukkan kata laluan';

  @override
  String get form_hidePassword => 'Sembunyikan kata laluan';

  @override
  String get form_passwordMin =>
      '8–72 bait UTF-8. Sesetengah aksara menggunakan lebih daripada satu bait.';

  @override
  String get form_firstName => 'Nama pertama';

  @override
  String get form_lastName => 'Nama keluarga';

  @override
  String get form_phone => 'Telefon (+33612345678)';

  @override
  String get form_address => 'Alamat';

  @override
  String get form_address2 => 'Baris alamat 2 (pilihan)';

  @override
  String get form_postalCode => 'Poskod';

  @override
  String get form_city => 'Bandar';

  @override
  String get form_country => 'Kod negara (contohnya FR)';

  @override
  String get action_login => 'Log masuk';

  @override
  String get action_createAccount => 'Cipta akaun';

  @override
  String get action_createMyAccount => 'Cipta akaun saya';

  @override
  String get action_next => 'Teruskan';

  @override
  String get action_previous => 'Kembali';

  @override
  String get action_forgotPassword => 'Lupa kata laluan?';

  @override
  String get auth_noAccount => 'Belum mempunyai akaun?';

  @override
  String get auth_requiredInformation => 'Cipta akaun anda dalam tiga langkah.';

  @override
  String get auth_termsPrefix => 'Saya menerima ';

  @override
  String get auth_termsLink => 'syarat penggunaan';

  @override
  String get auth_privacyPrefix => 'Saya menerima ';

  @override
  String get auth_privacyLink => 'dasar privasi';

  @override
  String get auth_consentRequired =>
      'Persetujuan anda diperlukan untuk mencipta akaun.';

  @override
  String get validation_required => 'Medan ini wajib diisi.';

  @override
  String get validation_email => 'Masukkan alamat e-mel yang sah.';

  @override
  String get validation_password =>
      'Kata laluan terlalu pendek: sekurang-kurangnya 8 bait UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Kata laluan terlalu panjang: maksimum 72 bait UTF-8.';

  @override
  String get validation_phone =>
      'Gunakan format antarabangsa, contohnya +33612345678.';

  @override
  String get validation_country =>
      'Gunakan kod negara dua huruf, contohnya FR.';

  @override
  String get passwordReset_title => 'Tetapkan semula kata laluan';

  @override
  String get passwordReset_description =>
      'Masukkan alamat e-mel akaun anda untuk meminta pautan tetapan semula kata laluan.';

  @override
  String get passwordReset_send => 'Hantar pautan';

  @override
  String get connection_title => 'Sambungan anda';

  @override
  String get connection_subtitle => 'Pilih lokasi, kemudian hidupkan VPN anda.';

  @override
  String get connection_prepare => 'Bersedia untuk bersambung?';

  @override
  String get connection_advancedOptions => 'Pilihan lanjutan';

  @override
  String get connection_location => 'Lokasi';

  @override
  String get connection_chooseLocation => 'Pilih lokasi';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Sambung';

  @override
  String get connection_connecting => 'Sedang menyambung…';

  @override
  String get connection_disconnect => 'Putuskan sambungan';

  @override
  String get connection_disconnecting => 'Sedang memutuskan sambungan';

  @override
  String get connection_locationChange => 'Menukar lokasi…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol tidak tersedia';
  }

  @override
  String get connection_activeLocation => 'Lokasi aktif';

  @override
  String get connection_duration => 'Tempoh';

  @override
  String get connection_received => 'Diterima';

  @override
  String get connection_sent => 'Dihantar';

  @override
  String get connection_lastHandshake => 'Pertukaran selamat terakhir';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration yang lalu';
  }

  @override
  String get verification_title => 'Sahkan alamat e-mel anda';

  @override
  String get verification_message =>
      'Sahkan alamat e-mel anda untuk menggunakan VPN pada telefon ini.';

  @override
  String get verification_resend => 'Hantar semula e-mel';

  @override
  String get migration_title => 'Perubahan lokasi';

  @override
  String get migration_draining => 'Menyediakan perubahan lokasi…';

  @override
  String get migration_activating => 'Mengaktifkan pelayan baharu…';

  @override
  String get migration_ready => 'Lokasi dikemas kini.';

  @override
  String get migration_blocked =>
      'Perubahan lokasi memerlukan campur tangan pelayan. Cuba lagi kemudian atau hubungi sokongan.';

  @override
  String get migration_progress => 'Kemajuan perubahan lokasi';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Tempoh antara pemeriksaan: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Sambung semula perubahan lokasi';

  @override
  String get status_authorizing => 'Kebenaran diperlukan';

  @override
  String get status_authorizingDetail =>
      'Terima permintaan Android untuk membenarkan VPN.';

  @override
  String get status_preparing => 'Menyediakan';

  @override
  String get status_preparingDetail => 'Menyediakan sambungan selamat anda.';

  @override
  String get status_reconnecting => 'Menyambung semula…';

  @override
  String get status_reconnectingDetail =>
      'Sambungan terganggu. VPN sedang cuba menyambung semula.';

  @override
  String get status_connecting => 'Menyambung';

  @override
  String get status_connectingDetail => 'Menyambung ke pelayan VPN…';

  @override
  String get status_connected => 'Disambungkan';

  @override
  String get status_connectedDetail => 'Sambungan VPN anda aktif.';

  @override
  String get status_disconnecting => 'Memutuskan sambungan';

  @override
  String get status_disconnectingDetail =>
      'Sambungan VPN anda sedang dihentikan.';

  @override
  String get status_error => 'Sambungan tidak tersedia';

  @override
  String get status_errorDetail => 'Sambungan VPN belum disahkan. Cuba lagi.';

  @override
  String get status_idle => 'Diputuskan';

  @override
  String get status_idleDetail =>
      'Sambungkan VPN untuk melindungi sambungan anda.';

  @override
  String get trust_note =>
      'Menutup aplikasi tidak menghentikan VPN. Untuk menghentikannya, gunakan Putuskan sambungan.';

  @override
  String get locations_none => 'Tiada lokasi yang tersedia pada masa ini.';

  @override
  String get locations_available => 'Pilih lokasi anda yang seterusnya.';

  @override
  String get locations_selected => 'Lokasi dipilih';

  @override
  String get locations_select => 'Pilih lokasi ini';

  @override
  String get locations_lockedTunnel => 'Putuskan VPN untuk menukar lokasi.';

  @override
  String get locations_lockedMigration =>
      'Tunggu sehingga perubahan lokasi selesai.';

  @override
  String get devices_title => 'Peranti anda';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit peranti';
  }

  @override
  String get devices_refresh => 'Muat semula peranti';

  @override
  String get devices_empty => 'Tiada peranti VPN didaftarkan lagi.';

  @override
  String get devices_firstConnection =>
      'Telefon anda akan ditambah pada sambungan pertama.';

  @override
  String get devices_thisDevice => 'Peranti ini';

  @override
  String devices_added(Object date) {
    return 'Ditambah pada $date';
  }

  @override
  String get action_remove => 'Alih keluar';

  @override
  String get settings_title => 'Tetapan';

  @override
  String get settings_subtitle =>
      'Keutamaan dan akaun anda, semuanya di satu tempat.';

  @override
  String get settings_appearance => 'Penampilan';

  @override
  String get settings_language => 'Bahasa';

  @override
  String get settings_languageDescription =>
      'Bahasa yang anda pilih juga digunakan untuk pemberitahuan VPN.';

  @override
  String get settings_account => 'Akaun';

  @override
  String get settings_signOut => 'Log keluar';

  @override
  String get settings_privacy => 'Dasar privasi';

  @override
  String get settings_terms => 'Syarat penggunaan';

  @override
  String get settings_security => 'Keselamatan dan ketelusan';

  @override
  String get settings_licenses => 'Lesen komponen';

  @override
  String get settings_licensesDetail =>
      'Perisian yang digunakan dalam aplikasi';

  @override
  String get settings_background =>
      'VPN kekal hidup apabila anda meninggalkan aplikasi. Untuk menghentikannya, gunakan Putuskan sambungan pada tab Sambungan.';

  @override
  String get theme_system => 'Sistem';

  @override
  String get theme_light => 'Cerah';

  @override
  String get theme_dark => 'Gelap';

  @override
  String get language_system => 'Bahasa telefon';

  @override
  String get language_fr => 'Bahasa Perancis';

  @override
  String get language_en => 'Bahasa Inggeris';

  @override
  String get language_es => 'Bahasa Sepanyol';

  @override
  String get language_de => 'Bahasa Jerman';

  @override
  String get dialog_removeDevice => 'Alih keluar peranti ini?';

  @override
  String get dialog_removeCurrent =>
      'Telefon ini akan diputuskan daripada VPN dan kehilangan akses. Data sambungan VPNnya akan dialih keluar selepas pelayan mengesahkannya.';

  @override
  String dialog_removeOther(Object name) {
    return 'Akses VPN untuk “$name” akan dibatalkan. Tindakan ini tidak boleh dibuat asal.';
  }

  @override
  String get dialog_signOut => 'Log keluar?';

  @override
  String get dialog_signOutMessage =>
      'VPN akan dihentikan dan anda perlu log masuk semula. Kunci VPN anda yang disulitkan akan kekal pada telefon ini untuk sambungan anda yang seterusnya.';

  @override
  String get action_cancel => 'Batal';

  @override
  String get action_signOut => 'Log keluar';

  @override
  String get notice_close => 'Tutup mesej';

  @override
  String get notice_sessionExpired_title => 'Sesi tamat tempoh';

  @override
  String get notice_sessionExpired_message =>
      'Sesi anda telah tamat tempoh. Log masuk semula.';

  @override
  String get notice_connectionFailed_title => 'Sambungan gagal';

  @override
  String get notice_invalidCredentials_message =>
      'Alamat e-mel atau kata laluan tidak betul.';

  @override
  String get notice_emailVerification_title => 'Pengesahan e-mel diperlukan';

  @override
  String get notice_emailVerification_message =>
      'Sahkan alamat e-mel anda sebelum menambah peranti VPN.';

  @override
  String get notice_rateLimited_title => 'Terlalu banyak percubaan';

  @override
  String get notice_deviceLimit_title => 'Had 2 peranti dicapai';

  @override
  String get notice_deviceLimit_message =>
      'Alih keluar peranti sedia ada sebelum menambah peranti lain.';

  @override
  String get notice_identityRenewal_title => 'Identiti VPN mesti diperbaharui';

  @override
  String get notice_identityRenewal_message =>
      'Identiti ini telah dialih keluar. Cipta identiti setempat baharu.';

  @override
  String get notice_migrationPending_title =>
      'Perubahan lokasi sedang dijalankan';

  @override
  String get notice_migrationPending_message =>
      'Perubahan lokasi sedang dijalankan.';

  @override
  String get notice_migrationBlocked_title => 'Perubahan lokasi disekat';

  @override
  String get notice_migrationBlocked_message =>
      'Perubahan lokasi memerlukan campur tangan pelayan. Cuba lagi kemudian atau hubungi sokongan.';

  @override
  String get notice_targetUnavailable_title =>
      'Pelayan tidak tersedia buat sementara';

  @override
  String get notice_targetUnavailable_message =>
      'Pelayan ini tidak tersedia buat sementara.';

  @override
  String get notice_networkUnavailable_title =>
      'Sambungan Internet tidak tersedia';

  @override
  String get notice_networkUnavailable_message =>
      'Semak sambungan anda dan cuba lagi.';

  @override
  String get notice_permissionDenied_title => 'Kebenaran VPN ditolak';

  @override
  String get notice_permissionDenied_message =>
      'Mulakan semula sambungan dan terima permintaan kebenaran Android.';

  @override
  String get notice_wireguardTimeout_title => 'Pelayan tidak memberi respons';

  @override
  String get notice_wireguardTimeout_message =>
      'Sambungan WireGuard mengambil masa terlalu lama. Cuba lagi atau pilih lokasi lain.';

  @override
  String get notice_tlsFailed_title => 'Sambungan selamat ditolak';

  @override
  String get notice_tlsFailed_message =>
      'Pelayan tidak menerima sambungan OpenVPN. Cuba lagi. Jika masalah berterusan, jalankan diagnostik.';

  @override
  String get notice_tunRejected_title => 'Android menolak antara muka VPN';

  @override
  String get notice_tunRejected_message =>
      'Android menolak konfigurasi rangkaian yang diminta oleh OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN tidak dapat dimulakan';

  @override
  String get notice_openvpnStart_message =>
      'Enjin OpenVPN tidak dapat selesai dimulakan. Cuba lagi. Jika masalah berterusan, hubungi sokongan.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kod diagnostik: $code';
  }

  @override
  String get notice_generic_title => 'Sambungan VPN gagal';

  @override
  String get notice_generic_message => 'Ralat berlaku. Cuba lagi kemudian.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Akaun dicipta',
      'password_reset_sent': 'Permintaan tetapan semula kata laluan diterima',
      'verification_email_sent': 'E-mel pengesahan dihantar',
      'location_migration_pending': 'Perubahan lokasi sedang dijalankan',
      'vpn_sign_in_required': 'Log masuk diperlukan',
      'protocol_unavailable_at_location': 'Protokol tidak tersedia',
      'vpn_permission_denied': 'Kebenaran VPN ditolak',
      'revoked_identity_device_limit': 'Had 2 peranti dicapai',
      'tunnel_start_unexpected': 'VPN tidak dapat dimulakan',
      'flutter_disconnect_timeout': 'Pemutusan sambungan belum disahkan',
      'flutter_disconnect_unexpected': 'Tidak dapat memutuskan sambungan',
      'device_revoked': 'Peranti dialih keluar',
      'revoke_unexpected': 'Tidak dapat mengalih keluar peranti',
      'identity_renewal_unexpected': 'Tidak dapat memperbaharui identiti',
      'openvpn_renewal_unexpected': 'Tidak dapat memperbaharui OpenVPN',
      'location_migration_blocked': 'Perubahan lokasi disekat',
      'location_migration_slow': 'Perubahan lokasi masih dijalankan',
      'location_migration_conflict': 'Perubahan lokasi memerlukan penyegaran',
      'location_migration_verification_failed':
          'Perubahan lokasi belum disahkan',
      'location_migration_device_changed':
          'Peranti berubah semasa perubahan lokasi',
      'tunnel_stop_failed': 'Perubahan lokasi tidak tersedia',
      'other': 'Operasi gagal',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Akaun telah dicipta, tetapi e-mel pengesahan tidak dapat dihantar. Gunakan hantar semula dalam aplikasi.',
      'password_reset_sent':
          'Permintaan anda telah diterima. Jika ada akaun yang sepadan dengan alamat ini, anda mungkin menerima e-mel. Sila semak folder spam anda juga.',
      'verification_email_sent':
          'E-mel pengesahan baharu baru sahaja dihantar.',
      'location_migration_pending':
          'Perpindahan ke $target masih sedang disediakan. Anda boleh menyambungnya semula tanpa mencipta semula peranti.',
      'vpn_sign_in_required': 'Log masuk ke akaun anda sebelum memulakan VPN.',
      'protocol_unavailable_at_location':
          'Protokol yang dipilih tidak ditawarkan oleh lokasi ini. Muat semula lokasi atau pilih protokol lain.',
      'vpn_permission_denied':
          'Android menolak kebenaran VPN. Mulakan semula sambungan dan terima permintaan sistem.',
      'revoked_identity_device_limit':
          'Akses VPN peranti ini telah dialih keluar dan had peranti telah dicapai. Alih keluar peranti di bawah Akaun → Urus peranti saya.',
      'tunnel_start_unexpected':
          'Ralat tidak dijangka mengganggu persediaan terowong. Semak kod diagnostik dan cuba lagi.',
      'flutter_disconnect_timeout':
          'Android tidak mengesahkan bahawa VPN berhenti tepat pada masanya. Cuba hentikannya lagi.',
      'flutter_disconnect_unexpected':
          'Ralat tidak dijangka menghalang pengesahan bahawa terowong telah berhenti.',
      'device_revoked':
          'Akses VPN peranti telah dibatalkan dan rahsia setempatnya telah dialih keluar.',
      'revoke_unexpected':
          'Peranti tidak dapat dialih keluar. Muat semula senarai dan cuba lagi.',
      'identity_renewal_unexpected':
          'Identiti VPN baharu tidak dapat dicipta. Muat semula peranti dan cuba lagi.',
      'openvpn_renewal_unexpected':
          'Profil OpenVPN tidak dapat diperbaharui. Cuba lagi atau semak kod diagnostik.',
      'location_migration_blocked':
          'Pelayan tidak dapat melengkapkan perubahan ini sekarang. Peranti dan identiti setempatnya telah disimpan.',
      'location_migration_slow':
          'Pelayan masih menyediakan perpindahan ke $target. Gunakan Sambung semula selepas beberapa ketika.',
      'location_migration_conflict':
          'Keadaan peranti berubah pada pelayan. Muat semula peranti, kemudian sambung semula perubahan.',
      'location_migration_verification_failed':
          'Pelayan tidak mengesahkan lokasi baharu. Identiti setempat sebelumnya telah disimpan.',
      'location_migration_device_changed':
          'Peranti yang dikembalikan oleh pelayan tidak lagi sepadan dengan peranti yang sedang diubah. Muat semula peranti sebelum cuba lagi.',
      'tunnel_stop_failed':
          'Terowong sebelumnya mesti dihentikan sepenuhnya sebelum sambungan baharu dibuat.',
      'other':
          'Operasi tidak dapat diselesaikan. Cuba lagi atau hantar kod diagnostik kepada sokongan.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesi tamat tempoh',
      'invalid_credentials': 'Log masuk gagal',
      'email_verification_required': 'Pengesahan e-mel diperlukan',
      'verification_email_cooldown': 'E-mel telah dihantar',
      'rate_limited': 'Terlalu banyak percubaan',
      'invalid_registration': 'Maklumat mesti dibetulkan',
      'email_exists': 'Akaun sudah wujud',
      'invalid_profile': 'Profil tidak sah',
      'invalid_device': 'Peranti tidak sah',
      'invalid_location': 'Lokasi tidak tersedia',
      'device_limit': 'Had peranti dicapai',
      'device_exists': 'Identiti VPN sudah digunakan',
      'device_identity_revoked': 'Identiti VPN mesti diperbaharui',
      'device_location_locked': 'Perubahan lokasi memerlukan penyegaran',
      'location_migration_pending': 'Perubahan lokasi sedang dijalankan',
      'location_migration_blocked': 'Perubahan lokasi disekat',
      'target_ca_mismatch': 'Pelayan OpenVPN tidak serasi',
      'location_migration_conflict': 'Perubahan lokasi memerlukan penyegaran',
      'server_full': 'Pelayan penuh',
      'capacity_unavailable': 'Lokasi tidak tersedia buat sementara',
      'target_unavailable': 'Pelayan tidak tersedia buat sementara',
      'not_found': 'Item tidak ditemui',
      'invalid_openvpn_csr': 'Identiti OpenVPN tidak sah',
      'openvpn_profile_exists': 'Profil OpenVPN sudah wujud',
      'openvpn_profile_revoked': 'Profil OpenVPN dibatalkan',
      'openvpn_operation_pending': 'Operasi OpenVPN sedang dijalankan',
      'openvpn_operation_terminal': 'Operasi OpenVPN terganggu',
      'openvpn_address_unavailable': 'Alamat OpenVPN tidak tersedia',
      'openvpn_profile_conflict': 'Konflik OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN tidak tersedia',
      'email_delivery_unavailable': 'E-mel tidak tersedia',
      'invalid_token': 'Pautan tidak sah',
      'network_unavailable': 'Sambungan Internet tidak tersedia',
      'invalid_json': 'Permintaan tidak sah',
      'invalid_api_response': 'Respons pelayan tidak sah',
      'ipv6_unavailable': 'IPv6 tidak tersedia',
      'invalid_ip_families': 'Konfigurasi rangkaian ditolak',
      'other': 'Perkhidmatan tidak tersedia',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesi anda telah tamat tempoh. Log masuk semula.',
      'invalid_credentials': 'Alamat e-mel atau kata laluan tidak betul.',
      'email_verification_required':
          'Sahkan alamat e-mel anda sebelum menambah peranti VPN.',
      'invalid_registration': 'Semak maklumat dan persetujuan yang diminta.',
      'email_exists': 'Sebuah akaun sudah menggunakan alamat e-mel ini.',
      'invalid_profile': 'Semak maklumat profil anda.',
      'invalid_device': 'Nama peranti atau identiti setempat ini tidak sah.',
      'invalid_location': 'Muat semula senarai lokasi dan cuba lagi.',
      'device_limit':
          'Alih keluar peranti sedia ada sebelum menambah peranti lain.',
      'device_exists': 'Identiti VPN ini sudah dipautkan kepada akaun lain.',
      'device_identity_revoked':
          'Identiti ini telah dialih keluar. Identiti setempat baharu mesti dicipta.',
      'device_location_locked':
          'Lokasi peranti ini baru sahaja berubah. Aplikasi akan menyambung semula perubahan yang sedang dijalankan.',
      'location_migration_pending': 'Perubahan lokasi sedang dijalankan.',
      'location_migration_blocked':
          'Perubahan lokasi memerlukan campur tangan pelayan. Cuba lagi kemudian atau hubungi sokongan.',
      'target_ca_mismatch':
          'Pelayan ini belum serasi dengan profil OpenVPN semasa.',
      'location_migration_conflict':
          'Muat semula peranti, kemudian cuba perubahan lokasi lagi.',
      'server_full':
          'Lokasi ini telah mencapai had sambungannya. Pilih lokasi lain atau cuba lagi kemudian.',
      'capacity_unavailable':
          'Kami tidak dapat mengesahkan sama ada lokasi ini tersedia sekarang. Pilih lokasi lain atau cuba lagi kemudian.',
      'target_unavailable': 'Pelayan ini tidak tersedia buat sementara.',
      'not_found': 'Item ini tidak lagi tersedia pada akaun anda.',
      'invalid_openvpn_csr': 'Cipta identiti OpenVPN baharu dan cuba lagi.',
      'openvpn_profile_exists': 'Profil OpenVPN sudah wujud untuk peranti ini.',
      'openvpn_profile_revoked': 'Perbaharui profil OpenVPN untuk meneruskan.',
      'openvpn_operation_pending':
          'Perubahan masih sedang disebarkan. Cuba lagi kemudian.',
      'openvpn_operation_terminal':
          'Cipta identiti OpenVPN baharu dan cuba lagi.',
      'openvpn_address_unavailable':
          'Tiada alamat OpenVPN tersedia pada masa ini.',
      'openvpn_profile_conflict':
          'Profil telah berubah. Muat semula peranti dan cuba lagi.',
      'openvpn_signer_unavailable':
          'Perkhidmatan OpenVPN tidak tersedia buat sementara.',
      'email_delivery_unavailable':
          'E-mel tidak dapat dihantar. Cuba lagi kemudian.',
      'invalid_token':
          'Pautan ini tidak sah atau telah tamat tempoh. Minta pautan baharu.',
      'network_unavailable': 'Semak sambungan Internet anda dan cuba lagi.',
      'invalid_json': 'Semak maklumat yang dimasukkan dan cuba lagi.',
      'invalid_api_response':
          'Pelayan mengembalikan respons yang tidak dijangka. Cuba lagi kemudian.',
      'ipv6_unavailable':
          'Pelayan tidak dapat mengaktifkan IPv6 buat masa ini. Cuba lagi kemudian.',
      'invalid_ip_families':
          'Konfigurasi terowong tidak lengkap atau tidak sepadan dengan alamat yang dibenarkan. Cuba lagi dari aplikasi.',
      'other': 'Ralat pelayan berlaku. Cuba lagi kemudian.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Cuba lagi dalam beberapa ketika.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Cuba lagi dalam $seconds saat.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Penyambungan semula VPN sistem tidak tersedia',
      'system_vpn_resume_corrupt': 'Penyambungan semula VPN sistem tidak sah',
      'system_vpn_resume_session_invalid':
          'Sesi penyambungan semula VPN tidak sah',
      'system_vpn_resume_identity_changed': 'Identiti VPN berubah',
      'system_vpn_resume_identity_invalid':
          'Identiti penyambungan semula VPN tidak sah',
      'system_vpn_resume_storage_failed':
          'Storan penyambungan semula VPN tidak tersedia',
      'system_vpn_resume_network_timeout':
          'Penyambungan semula VPN tiada rangkaian',
      'system_vpn_resume_blocked': 'Penyambungan semula VPN disekat',
      'system_vpn_resume_failed': 'Penyambungan semula VPN gagal',
      'system_vpn_resume_error_invalid':
          'Ralat penyambungan semula VPN tidak sah',
      'wireguard_identity_store_failed': 'Identiti WireGuard tidak disimpan',
      'wireguard_identity_unavailable': 'Identiti WireGuard tidak tersedia',
      'vpn_host_destroyed': 'Hos VPN Android dihentikan',
      'vpn_host_unavailable': 'Hos VPN Android tidak tersedia',
      'vpn_permission_required': 'Kebenaran VPN diperlukan',
      'vpn_permission_denied': 'Kebenaran VPN ditolak',
      'vpn_permission_request_failed': 'Tidak dapat meminta kebenaran',
      'wireguard_foreground_service_unavailable':
          'Perkhidmatan WireGuard tidak tersedia',
      'wireguard_identity_invalid': 'Kunci WireGuard setempat tidak sah',
      'wireguard_identity_in_use': 'Identiti WireGuard sudah digunakan',
      'wireguard_configuration_invalid': 'Konfigurasi WireGuard tidak sah',
      'wireguard_operation_pending': 'Operasi WireGuard masih aktif',
      'wireguard_start_failed': 'Permulaan WireGuard ditolak',
      'wireguard_stop_timeout': 'Pemberhentian WireGuard belum disahkan',
      'wireguard_handshake_timeout': 'WireGuard tidak memberi respons',
      'openvpn_connection_timeout': 'OpenVPN tidak memberi respons',
      'openvpn_core_unavailable': 'Enjin OpenVPN tidak tersedia',
      'openvpn_operation_pending': 'Sesi OpenVPN masih aktif',
      'openvpn_stop_timeout': 'Pemberhentian OpenVPN belum disahkan',
      'openvpn_profile_unavailable': 'Profil OpenVPN setempat tiada',
      'openvpn_native_failed': 'Panggilan OpenVPN asli terganggu',
      'openvpn_key_generation_failed':
          'Tidak dapat mencipta kunci OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Tidak dapat mencipta CSR OpenVPN',
      'openvpn_identity_store_failed': 'Identiti OpenVPN tidak disimpan',
      'openvpn_identity_clear_failed': 'Penghapusan OpenVPN tidak lengkap',
      'openvpn_identity_in_use': 'Identiti OpenVPN masih digunakan',
      'openvpn_tls_verification_required': 'Pengesahan TLS OpenVPN tiada',
      'openvpn_cipher_invalid': 'Sifir OpenVPN tidak sah',
      'openvpn_profile_rejected': 'Profil OpenVPN ditolak',
      'openvpn_identity_inconsistent': 'Identiti OpenVPN tidak konsisten',
      'tls_handshake_failed': 'Rundingan OpenVPN ditolak',
      'tls_alert_unknown_ca': 'Sijil klien OpenVPN tidak dikenali',
      'tls_alert_bad_certificate': 'Sijil klien OpenVPN ditolak',
      'tls_alert_unsupported_certificate': 'Sijil OpenVPN tidak disokong',
      'tls_client_certificate_required': 'Sijil klien OpenVPN diperlukan',
      'tls_alert_misc': 'Amaran TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Tandatangan OpenVPN tidak disokong',
      'tls_handshake_rejected': 'Rundingan TLS OpenVPN ditolak',
      'tls_version_rejected': 'Versi TLS OpenVPN tidak serasi',
      'tls_certificate_expired': 'Sijil TLS telah tamat tempoh',
      'tls_certificate_revoked': 'Sijil TLS dibatalkan',
      'transport_failed': 'Pelayan OpenVPN tidak dapat dicapai',
      'tun_configuration_rejected': 'Tidak dapat mencipta antara muka OpenVPN',
      'tun_setup_failed': 'Persediaan TUN OpenVPN gagal',
      'tun_interface_create_failed': 'Penciptaan antara muka OpenVPN gagal',
      'tun_interface_disabled': 'Antara muka OpenVPN dilumpuhkan',
      'tun_halted': 'Antara muka OpenVPN terganggu',
      'tun_already_established': 'Antara muka OpenVPN sudah dibuka',
      'tun_addresses_missing': 'Alamat OpenVPN tiada',
      'tun_routes_missing': 'Laluan OpenVPN tiada',
      'tun_dns_missing': 'DNS OpenVPN tiada',
      'tun_permission_revoked': 'Kebenaran VPN dibatalkan',
      'tun_establish_returned_null': 'Android menolak antara muka VPN',
      'openvpn_service_start_failed': 'Perkhidmatan OpenVPN tidak tersedia',
      'openvpn_operation_timeout': 'Panggilan OpenVPN tamat masa',
      'openvpn_start_failed': 'Permulaan OpenVPN ditolak',
      'openvpn_connection_failed': 'Sambungan OpenVPN terganggu',
      'openvpn_core_status_error': 'OpenVPN Core berakhir dengan ralat',
      'openvpn_stopped_before_connected': 'OpenVPN berhenti sebelum bersambung',
      'openvpn_auth_failed': 'Pengesahan OpenVPN ditolak',
      'openvpn_client_setup_failed': 'Persediaan klien OpenVPN gagal',
      'openvpn_client_halted': 'Klien OpenVPN terganggu',
      'openvpn_client_restart': 'Permulaan semula OpenVPN diminta',
      'openvpn_inactive_timeout': 'OpenVPN tidak aktif terlalu lama',
      'openvpn_session_expired': 'Sesi OpenVPN tamat tempoh',
      'openvpn_credentials_required': 'Pengesahan OpenVPN tidak disokong',
      'openvpn_proxy_failed': 'Pengangkutan perantara OpenVPN gagal',
      'openvpn_compression_failed': 'Pemampatan OpenVPN ditolak',
      'openvpn_ntlm_crypto_unavailable':
          'Penyulitan NTLM OpenVPN tidak tersedia',
      'openvpn_feature_unsupported': 'Ciri OpenVPN tidak disokong',
      'network_unavailable': 'Sambungan Internet tidak tersedia',
      'network_lost': 'Rangkaian tidak tersedia',
      'certificate_validation_failed': 'Sijil pelayan ditolak',
      'openvpn_certificate_expired': 'Sijil OpenVPN tamat tempoh',
      'tunnel_active_for_another_account': 'Terowong akaun lain masih aktif',
      'tunnel_already_active': 'Terowong asli sudah aktif',
      'tunnel_stop_timeout': 'Pemberhentian $protocol belum disahkan',
      'tunnel_disconnected': '$protocol terganggu',
      'native_bridge_unavailable': 'Jambatan Android tidak tersedia',
      'native_operation_failed': 'Operasi Android terganggu',
      'invalid_arguments': 'Parameter VPN tidak lengkap',
      'invalid_account_id': 'Akaun VPN tidak sah',
      'invalid_device_id': 'Pengecam peranti tidak sah',
      'storage_key_not_allowed': 'Kunci storan ditolak',
      'secure_storage_read_failed': 'Pembacaan selamat gagal',
      'secure_storage_write_failed': 'Penulisan selamat gagal',
      'key_generation_failed': 'Tidak dapat menjana kunci WireGuard',
      'csr_generation_failed': 'Tidak dapat menjana CSR OpenVPN',
      'other': 'Ralat VPN asli tidak diklasifikasikan',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android tidak menemui sesi VPN yang boleh disambung semula. Mulakan sambungan baharu dalam aplikasi.',
      'system_vpn_resume_corrupt':
          'Data penyambungan semula VPN yang disimpan tidak sah dan tidak akan digunakan. Mulakan sambungan baharu.',
      'system_vpn_resume_session_invalid':
          'Sesi yang disimpan tidak lagi boleh menyambung semula VPN. Log masuk semula dalam aplikasi.',
      'system_vpn_resume_identity_changed':
          'Identiti VPN setempat berubah. Penyambungan semula dihentikan; mulakan sambungan baharu.',
      'system_vpn_resume_identity_invalid':
          'Identiti untuk penyambungan semula tidak sah. Mulakan sambungan baharu.',
      'system_vpn_resume_storage_failed':
          'Android tidak dapat membaca atau mengemas kini data penyambungan semula yang disulitkan. Mulakan sambungan baharu.',
      'system_vpn_resume_network_timeout':
          'Android tidak menemui rangkaian tepat pada masanya untuk menyambung semula VPN. Cuba lagi apabila rangkaian tersedia.',
      'system_vpn_resume_blocked':
          'Penyambungan semula VPN disekat. Semak tetapan Android, kemudian mulakan sambungan baharu.',
      'system_vpn_resume_failed':
          'Penyambungan semula VPN Android gagal. Mulakan sambungan baharu dalam aplikasi.',
      'system_vpn_resume_error_invalid':
          'Android mengembalikan ralat penyambungan semula yang tidak boleh digunakan. Mulakan sambungan baharu.',
      'wireguard_identity_store_failed':
          'Android tidak dapat menyimpan identiti WireGuard akaun ini yang disulitkan.',
      'wireguard_identity_unavailable':
          'Tiada identiti WireGuard yang boleh digunakan untuk sambungan ini.',
      'vpn_host_destroyed':
          'Komponen Android yang menjadi hos VPN telah dihentikan. Mulakan sambungan baharu.',
      'vpn_host_unavailable':
          'Android tidak dapat mencipta komponen yang menjadi hos VPN. Cuba lagi selepas menyemak tetapan VPN.',
      'openvpn_renewal_required':
          'Sijil memerlukan tindakan dalam aplikasi sebelum menyambung.',
      'openvpn_recovery_failed':
          'Pemulihan automatik gagal. Mulakan sambungan baharu dalam aplikasi.',
      'openvpn_recovery_exhausted':
          'Pemulihan automatik telah digunakan. Mulakan sambungan baharu dalam aplikasi.',
      'vpn_permission_required':
          'Android memerlukan kebenaran VPN baharu sebelum memulakan terowong.',
      'vpn_permission_denied':
          'Benarkan FuzeVPN dalam permintaan Android untuk meneruskan.',
      'vpn_permission_request_failed':
          'Android tidak dapat membuka skrin kebenaran VPN.',
      'wireguard_foreground_service_unavailable':
          'Android tidak dapat mengekalkan perkhidmatan WireGuard di latar hadapan.',
      'wireguard_identity_invalid':
          'Kunci WireGuard akaun ini yang disulitkan tidak boleh dibaca atau tidak sah.',
      'wireguard_identity_in_use':
          'Operasi lain masih menggunakan kunci WireGuard akaun ini.',
      'wireguard_configuration_invalid':
          'Alamat WireGuard, DNS, kunci pelayan atau laluan yang diterima tidak sah.',
      'wireguard_operation_pending':
          'Operasi WireGuard sebelumnya masih belum melepaskan perkhidmatan aslinya.',
      'wireguard_start_failed':
          'Enjin WireGuard menolak pengaktifan konfigurasi.',
      'wireguard_stop_timeout':
          'Perkhidmatan WireGuard tidak mengesahkan pelepasan antara muka VPN dalam had masa.',
      'wireguard_handshake_timeout':
          'Terowong tidak mengesahkan jabat tangan dengan pelayan tepat pada masanya.',
      'openvpn_connection_timeout':
          'OpenVPN tidak mengesahkan sambungan ke pelayan tepat pada masanya.',
      'openvpn_core_unavailable':
          'Versi aplikasi ini tidak mengandungi enjin OpenVPN yang boleh digunakan.',
      'openvpn_operation_pending':
          'Enjin asli masih memegang sesi OpenVPN sebelumnya dan enggan mencipta sesi kedua.',
      'openvpn_stop_timeout':
          'OpenVPN Core tidak mengesahkan bahawa sesi aslinya berhenti dan dimusnahkan dalam had masa.',
      'openvpn_profile_unavailable':
          'Tiada profil OpenVPN yang disahkan boleh dibaca untuk sambungan ini.',
      'openvpn_native_failed':
          'Ralat aplikasi mengganggu OpenVPN. Cuba sambung lagi. Jika masalah berterusan, jalankan diagnostik.',
      'openvpn_key_generation_failed':
          'Android Keystore tidak dapat mencipta atau membaca kunci peribadi P-256 yang tidak boleh dieksport.',
      'openvpn_csr_generation_failed':
          'Kunci Android Keystore tidak dapat menandatangani permintaan sijil OpenVPN.',
      'openvpn_identity_store_failed':
          'Sijil atau profil OpenVPN tidak dapat disimpan dalam storan yang disulitkan.',
      'openvpn_identity_clear_failed':
          'Android tidak dapat mengalih keluar keseluruhan identiti OpenVPN setempat untuk akaun ini.',
      'openvpn_identity_in_use':
          'Sesi OpenVPN asli masih menggunakan kunci atau sijil peranti ini.',
      'openvpn_tls_verification_required':
          'Profil tidak secara jelas memerlukan pengesahan sijil pelayan.',
      'openvpn_cipher_invalid':
          'Pelayan membekalkan algoritma penyulitan yang tiada dalam senarai yang dibenarkan.',
      'openvpn_profile_rejected':
          'Profil yang diterima daripada pelayan tidak serasi. Cipta semula peranti ini dan cuba lagi.',
      'openvpn_identity_inconsistent':
          'Sijil tidak sepadan dengan identiti selamat telefon ini. Tiada profil setempat diganti.',
      'tls_handshake_failed':
          'Pelayan menolak rundingan TLS. Cipta semula profil jika masalah berterusan.',
      'tls_alert_unknown_ca':
          'Pelayan tidak mengenali pihak berkuasa sijil peranti ini. Pelayan OpenVPN mesti diperiksa.',
      'tls_alert_bad_certificate':
          'Pelayan menolak sijil peranti ini. Cipta semula peranti sebelum cuba lagi.',
      'tls_alert_unsupported_certificate':
          'Pelayan tidak menyokong jenis sijil selamat yang digunakan oleh Android.',
      'tls_client_certificate_required':
          'Pelayan memerlukan sijil klien, tetapi OpenVPN Core tidak dapat mengemukakannya.',
      'tls_alert_misc':
          'Pelayan mengembalikan amaran TLS di luar kategori sijil dan versi.',
      'tls_signature_algorithm_rejected':
          'Pelayan menolak algoritma ECDSA P-256 kunci Android Keystore.',
      'tls_handshake_rejected':
          'Pelayan mengganggu rundingan TLS sebelum sambungan dibuat.',
      'tls_version_rejected':
          'Klien dan pelayan tidak menemui versi TLS yang sama.',
      'tls_certificate_expired':
          'Sijil yang dikemukakan semasa sambungan telah tamat tempoh.',
      'tls_certificate_revoked':
          'Sijil yang dikemukakan semasa sambungan telah dibatalkan.',
      'transport_failed':
          'Pelayan OpenVPN tidak memberi respons pada rangkaian semasa. Cuba lagi sebentar lagi.',
      'tun_configuration_rejected':
          'Android menolak konfigurasi rangkaian yang diminta oleh OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core menolak pelan rangkaian sebelum mencipta antara muka Android.',
      'tun_interface_create_failed':
          'OpenVPN Core tidak dapat memperoleh antara muka TUN daripada Android VpnService.',
      'tun_interface_disabled':
          'Android atau OpenVPN Core melumpuhkan antara muka TUN semasa sambungan.',
      'tun_halted':
          'OpenVPN Core menerima permintaan untuk menghentikan antara muka TUN.',
      'tun_already_established':
          'OpenVPN meminta antara muka kedua dalam sambungan yang sama. Terowong dihentikan demi keselamatan.',
      'tun_addresses_missing':
          'Pelayan tidak memberikan alamat terowong yang boleh digunakan.',
      'tun_routes_missing':
          'Pelayan tidak memberikan laluan terowong yang boleh digunakan.',
      'tun_dns_missing':
          'Pelayan tidak memberikan pelayan DNS yang boleh digunakan.',
      'tun_permission_revoked':
          'Android membatalkan kebenaran VPN semasa sambungan.',
      'tun_establish_returned_null':
          'Android tidak mencipta antara muka, biasanya kerana VPN lain masih aktif.',
      'openvpn_service_start_failed':
          'Android tidak dapat memulakan perkhidmatan latar hadapan OpenVPN.',
      'openvpn_operation_timeout':
          'Panggilan JNI ke OpenVPN Core melebihi tempoh maksimumnya.',
      'openvpn_start_failed':
          'Perkhidmatan Android sedia, tetapi OpenVPN Core tidak menerima permulaan profil.',
      'openvpn_connection_failed':
          'OpenVPN Core berhenti sebelum mengeluarkan peristiwa CONNECTED.',
      'openvpn_core_status_error':
          'Gelung OpenVPN asli berakhir dengan ralat dan tiada peristiwa terminal yang lebih khusus.',
      'openvpn_stopped_before_connected':
          'Gelung OpenVPN asli berhenti sebelum CONNECTED, tanpa ralat Core yang jelas.',
      'openvpn_auth_failed': 'Pelayan OpenVPN menolak pengesahan profil.',
      'openvpn_client_setup_failed':
          'OpenVPN Core tidak dapat memulakan klien sebelum sambungan rangkaian.',
      'openvpn_client_halted':
          'OpenVPN Core menerima arahan berhenti klien yang muktamad.',
      'openvpn_client_restart':
          'OpenVPN Core meminta permulaan semula sesi pengangkutannya.',
      'openvpn_inactive_timeout':
          'OpenVPN Core menutup sesi selepas tempoh tidak aktif tamat.',
      'openvpn_session_expired':
          'Pelayan melaporkan bahawa sesi OpenVPN telah tamat tempoh.',
      'openvpn_credentials_required':
          'Pelayan atau proksi meminta kelayakan interaktif yang bukan sebahagian daripada profil sijil ini.',
      'openvpn_proxy_failed':
          'OpenVPN Core melaporkan kegagalan proksi atau geganti yang dikonfigurasikan.',
      'openvpn_compression_failed':
          'OpenVPN Core menolak mod pemampatan yang diumumkan oleh profil atau pelayan.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil meminta penyulitan NTLM yang tidak tersedia dalam versi ini.',
      'openvpn_feature_unsupported':
          'Profil atau pelayan memerlukan ciri yang tiada dalam klien Android ini.',
      'network_unavailable':
          'Tiada rangkaian fizikal yang boleh digunakan tersedia.',
      'network_lost': 'Terowong dihentikan selepas rangkaian terputus.',
      'certificate_validation_failed':
          'Identiti pelayan OpenVPN tidak dapat disahkan.',
      'openvpn_certificate_expired':
          'Perbaharui profil OpenVPN sebelum menyambung semula.',
      'tunnel_active_for_another_account':
          'Terowong milik akaun lain mesti dihentikan sebelum sambungan ini.',
      'tunnel_already_active':
          'Android melaporkan bahawa sesi VPN sebelumnya masih menggunakan antara muka.',
      'tunnel_stop_timeout':
          'Enjin $protocol tidak mengesahkan pelepasan antara muka VPN dalam had masa.',
      'tunnel_disconnected':
          'Enjin asli melaporkan bahawa terowong berakhir tanpa dijangka selepas dimulakan.',
      'native_bridge_unavailable':
          'Aplikasi tidak dapat mengakses perkhidmatan VPN Android. Tutup dan buka semula aplikasi, kemudian cuba lagi.',
      'native_operation_failed':
          'Ralat aplikasi mengganggu operasi VPN. Cuba lagi. Jika masalah berterusan, jalankan diagnostik.',
      'invalid_arguments':
          'Maklumat yang diperlukan untuk operasi VPN ini tidak lengkap. Cuba lagi. Jika masalah berterusan, jalankan diagnostik.',
      'invalid_account_id':
          'Operasi asli tidak dikaitkan dengan pengecam akaun yang sah.',
      'invalid_device_id':
          'Pengecam peranti yang dihantar kepada enjin asli tiada atau tidak sah.',
      'storage_key_not_allowed':
          'Jambatan Android menyekat kunci di luar senarai storan yang dibenarkan.',
      'secure_storage_read_failed':
          'Android Keystore tidak dapat menyahsulit data setempat akaun ini.',
      'secure_storage_write_failed':
          'Android Keystore tidak dapat menyulitkan atau menyimpan data setempat.',
      'key_generation_failed':
          'Android tidak dapat mencipta atau membaca kunci WireGuard dalam storan selamat.',
      'csr_generation_failed':
          'Android Keystore tidak dapat mencipta atau menandatangani CSR OpenVPN P-256.',
      'other':
          'Cabang asli yang tidak didokumenkan gagal. Hantar kod diagnostik yang dipaparkan di bawah kepada sokongan.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Permintaan kebenaran sudah dibuka';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Permintaan kebenaran VPN Android sudah dipaparkan. Lengkapkannya sebelum cuba lagi.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Permintaan kebenaran VPN terganggu';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Skrin kebenaran VPN ditutup sebelum aplikasi menerima respons.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Sambungan OpenVPN belum disahkan';

  @override
  String get notice_openvpnProofMissing_message =>
      'Sambungan OpenVPN tidak dapat disahkan. Sambungan itu dihentikan demi keselamatan. Cuba lagi.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN dibatalkan';

  @override
  String get openvpnCleanup_working =>
      'Menghentikan dan mengalih keluar profil OpenVPN yang dibatalkan…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Penutupan OpenVPN belum disahkan. Cuba lagi sebelum mencipta profil baharu.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Profil OpenVPN yang dibatalkan tidak dapat dialih keluar sepenuhnya. Cuba bersihkan lagi.';

  @override
  String get openvpnCleanup_complete =>
      'Profil OpenVPN yang dibatalkan telah dialih keluar. Tekan Sambung untuk mencipta profil baharu.';

  @override
  String get network_title => 'Konfigurasi rangkaian';

  @override
  String get network_ipv4Fallback =>
      'IPv6 tidak tersedia buat sementara. Persediaan diteruskan dengan IPv4.';

  @override
  String get network_rejectedTitle => 'Konfigurasi rangkaian ditolak';

  @override
  String get network_rejectedMessage =>
      'Konfigurasi terowong tidak lengkap atau tidak sepadan dengan alamat yang dibenarkan. Cuba lagi dari aplikasi.';

  @override
  String get network_unreadableTitle =>
      'Konfigurasi setempat tidak dapat dibaca';

  @override
  String get network_unreadableMessage =>
      'Konfigurasi rangkaian OpenVPN yang disimpan tidak boleh digunakan. Sambung semula dari aplikasi untuk mengemas kininya.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Perlindungan rangkaian';

  @override
  String get protection_subtitle =>
      'Sekat akses Internet terus jika VPN terputus.';

  @override
  String get protection_active => 'Perlindungan sistem aktif';

  @override
  String get protection_alwaysOnOnly =>
      'VPN sentiasa hidup didayakan; hidupkan penyekatan di luar VPN';

  @override
  String get protection_inactive => 'Perlindungan sistem tidak aktif';

  @override
  String get protection_unknown => 'Semak perlindungan sistem';

  @override
  String get protection_openSettings => 'Buka tetapan Android';

  @override
  String get protection_dialogTitle => 'Sediakan perlindungan rangkaian';

  @override
  String get protection_dialogMessage =>
      'Android mengurus VPN sentiasa hidup dan penyekatan sambungan di luar VPN. Pastikan FuzeVPN dipilih dan hidupkan penyekatan dalam tetapan sistem.';

  @override
  String get protection_dialogOpen => 'Buka tetapan';

  @override
  String get session_systemProtectionNote =>
      'Jika Android masih menyekat trafik di luar VPN, buka tetapan sistem untuk menyemak atau menukar perlindungan ini.';

  @override
  String get diagnostics_title => 'Diagnostik';

  @override
  String get diagnostics_settingsTitle => 'Diagnostik aplikasi';

  @override
  String get diagnostics_automaticTitle => 'Hantar ralat penting';

  @override
  String get diagnostics_automaticDescription =>
      'Kongsi laporan teknikal ringkas apabila ralat penting berlaku.';

  @override
  String get diagnostics_privacy =>
      'Laporan yang dihantar dipautkan kepada akaun yang dilog masuk dan disimpan selama 30 hari. Laporan tidak mengandungi sejarah pelayaran, kata laluan atau kunci VPN.';

  @override
  String get diagnostics_manualOpen => 'Jalankan diagnostik';

  @override
  String get diagnostics_localDescription =>
      'Cipta laporan tentang status aplikasi dan VPN. Sambungan anda kekal tidak berubah.';

  @override
  String get diagnostics_sendReport => 'Hantar laporan';

  @override
  String get diagnostics_sendHint =>
      'Biarkan kotak ini tidak ditanda untuk menyimpan laporan pada peranti ini.';

  @override
  String get diagnostics_signedOut =>
      'Log masuk ke akaun anda untuk menghantar laporan.';

  @override
  String get diagnostics_localLifetime =>
      'Simpan laporan ini pada telefon anda supaya kekal selepas aplikasi ditutup.';

  @override
  String get diagnostics_run => 'Jalankan diagnostik';

  @override
  String get diagnostics_rerun => 'Jalankan diagnostik lagi';

  @override
  String get diagnostics_running => 'Menyemak…';

  @override
  String get diagnostics_sending => 'Menghantar laporan…';

  @override
  String get diagnostics_prepared => 'Laporan sedia pada peranti ini';

  @override
  String get diagnostics_queued => 'Laporan menunggu untuk dihantar';

  @override
  String get diagnostics_sent => 'Laporan diterima';

  @override
  String get diagnostics_failed =>
      'Penghantaran gagal. Laporan setempat anda masih tersedia.';

  @override
  String get diagnostics_preparationFailed =>
      'Laporan diagnostik tidak dapat disediakan. Cuba lagi.';

  @override
  String get diagnostics_authenticationRequired =>
      'Log masuk semula untuk menghantar laporan.';

  @override
  String get diagnostics_retry => 'Cuba hantar lagi';

  @override
  String get diagnostics_export => 'Simpan laporan';

  @override
  String get diagnostics_exportFailed =>
      'Eksport gagal. Cuba lagi dari laporan setempat.';

  @override
  String get diagnostics_preferenceFailed =>
      'Tetapan ini tidak dapat disimpan. Cuba lagi.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Rujukan: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Diterima pada $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Disimpan sehingga $date';
  }

  @override
  String get diagnostics_duplicate => 'Laporan ini telah diterima sebelum ini.';

  @override
  String get diagnostics_preview => 'Pratonton laporan';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peristiwa teknikal dilampirkan',
      one: '1 peristiwa teknikal dilampirkan',
      zero: 'Tiada peristiwa teknikal dilampirkan',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Butiran teknikal';

  @override
  String get diagnostics_empty => 'Tiada laporan diagnostik disediakan lagi.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Keadaan terowong',
      'handshake': 'Pengesahan sambungan',
      'certificate': 'Sijil VPN',
      'kill_switch': 'Perlindungan Android',
      'connectivity': 'Rangkaian tersedia',
      'api_reachability': 'Akses perkhidmatan',
      'secure_storage': 'Storan selamat',
      'other': 'Pemeriksaan setempat',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Disemak',
      'failed': 'Memerlukan perhatian',
      'skipped': 'Tidak diuji — tiada pemeriksaan aktif',
      'unknown': 'Maklumat tidak tersedia',
      'other': 'Maklumat tidak tersedia',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Selamat datang ke FuzeVPN';

  @override
  String get connection_changeLocation => 'Tukar lokasi';

  @override
  String get connection_details => 'Butiran sambungan';

  @override
  String get locations_searchLabel => 'Cari bandar atau negara';

  @override
  String get locations_clearSearch => 'Kosongkan carian';

  @override
  String get locations_filterAll => 'Semua';

  @override
  String get locations_filterFavorites => 'Kegemaran';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokasi',
      one: '$count lokasi',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Tiada lokasi ditemui';

  @override
  String get locations_noResultsHint => 'Cuba bandar atau negara lain.';

  @override
  String get locations_noFavorites => 'Kegemaran anda, sentiasa dekat';

  @override
  String get locations_noFavoritesHint =>
      'Tekan bintang di sebelah lokasi untuk menyimpannya di sini.';

  @override
  String get locations_showAll => 'Lihat semua lokasi';

  @override
  String locations_addFavorite(String name) {
    return 'Tambah $name kepada kegemaran';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Alih keluar $name daripada kegemaran';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Kegemaran tidak dapat disimpan. Cuba lagi.';

  @override
  String get locations_emptyTitle => 'Tiada lokasi tersedia';

  @override
  String get locations_emptyHint => 'Muat semula senarai untuk cuba lagi.';

  @override
  String get devices_manage => 'Urus peranti saya';

  @override
  String get settings_personalization => 'Jadikan ia milik anda';

  @override
  String get settings_safety => 'Perlindungan';

  @override
  String get settings_help => 'Perlukan bantuan?';

  @override
  String get settings_about => 'Tentang FuzeVPN';

  @override
  String get diagnostics_heading => 'Fahami masalah sambungan';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Tersedia',
      'pending': 'Menyediakan',
      'revoked': 'Dialih keluar',
      'expired': 'Tamat tempoh',
      'other': 'Status tidak tersedia',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Keutamaan tidak disimpan';

  @override
  String get notice_preferenceSave_message =>
      'Pilihan anda digunakan buat masa ini tetapi tidak dapat disimpan. Cuba lagi supaya pilihan itu kekal selepas aplikasi ditutup.';

  @override
  String get connection_androidDisconnectHint =>
      'Jika Android mengekalkan VPN aktif, matikan VPN sentiasa hidup dalam tetapan yang dibuka.';

  @override
  String get protection_learnMore => 'Ketahui tentang perlindungan Android';

  @override
  String get protection_guideWhy =>
      'Perlindungan ini menghalang aplikasi daripada menggunakan Internet secara terus jika VPN terputus. Perlindungan ini dikonfigurasikan dalam Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN sentiasa hidup';

  @override
  String get protection_guideAlwaysOn =>
      'Android mengekalkan perkhidmatan VPN berjalan dan boleh memulakannya semula selepas telefon dihidupkan semula.';

  @override
  String get protection_guideBlockTitle => 'Sekat sambungan tanpa VPN';

  @override
  String get protection_guideBlock =>
      'Tetapan ini menghalang trafik daripada memintas VPN, termasuk ketika sambungan terganggu.';

  @override
  String get protection_guideWarning =>
      'Apabila penyekatan ini didayakan, akses Internet kekal dimatikan sehingga VPN disambungkan.';

  @override
  String get protection_guideStepsTitle => 'Hidupkan perlindungan';

  @override
  String get protection_guideStep1 =>
      'Buka tetapan VPN Android menggunakan butang di bawah.';

  @override
  String get protection_guideStep2 =>
      'Buka pilihan menggunakan ikon gear di sebelah FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Dayakan VPN sentiasa hidup, kemudian Sekat sambungan tanpa VPN, jika pilihan ini tersedia.';

  @override
  String get protection_guideManufacturers =>
      'Nama berbeza mengikut telefon. Jika perlu, cari VPN dalam Tetapan, biasanya di bawah Rangkaian & Internet.';

  @override
  String get protection_guideDisableTitle => 'Matikan perlindungan ini';

  @override
  String get protection_guideDisable =>
      'Dalam tetapan yang sama, matikan penyekatan tanpa VPN untuk membenarkan akses Internet tanpa VPN. Matikan juga VPN sentiasa hidup jika anda tidak lagi mahu Android memulakannya semula.';

  @override
  String get protection_guideManual =>
      'Anda memilih tetapan ini dalam Android. FuzeVPN tidak mengubahnya untuk anda.';

  @override
  String get locations_changeTitle => 'Tukar lokasi?';

  @override
  String locations_changeActive(String name) {
    return 'VPN akan terputus, kemudian cuba bersambung ke $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN akan cuba bersambung ke $name.';
  }

  @override
  String get locations_confirmChange => 'Tukar dan sambung';

  @override
  String get locations_changeBusy =>
      'Perubahan sedang dijalankan. Tunggu sebelum memilih lokasi lain.';

  @override
  String get locations_automaticSelection => 'Pemilihan automatik';

  @override
  String get locations_cities => 'Bandar';

  @override
  String get locations_servers => 'Pelayan';

  @override
  String locations_viewCities(String name) {
    return 'Lihat bandar di $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Lihat pelayan di $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count negara',
      one: '$count negara',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bandar',
      one: '$count bandar',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pelayan',
      one: '$count pelayan',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Semua negara';

  @override
  String get locations_backToCountries => 'Kembali ke negara';

  @override
  String locations_backToCities(String name) {
    return 'Kembali ke bandar di $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Pilih $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Pilih $name';
  }

  @override
  String get locations_noCompatibleServer => 'Tiada pelayan serasi tersedia.';

  @override
  String get externalLink_failed =>
      'Pautan ini tidak dapat dibuka. Anda boleh menyalinnya dan membukanya dalam pelayar.';

  @override
  String get externalLink_copy => 'Salin pautan';

  @override
  String get externalLink_copied => 'Pautan disalin';

  @override
  String get externalLink_copyFailed =>
      'Pautan tidak dapat disalin. Pilih alamat di bawah.';

  @override
  String get settings_deleteAccount => 'Padam akaun saya';

  @override
  String get settings_deleteAccountDetail =>
      'Lihat cara memohon pemadaman akaun';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Pilih langganan VPN anda.';

  @override
  String get billing_subscribe => 'Langgan';

  @override
  String get billing_choosePlan => 'Pilih pelan untuk meneruskan.';

  @override
  String get billing_monthly => 'Bulanan';

  @override
  String get billing_yearly => 'Tahunan';

  @override
  String get billing_continue => 'Teruskan dengan Google Play';

  @override
  String get billing_restore => 'Pulihkan pembelian';

  @override
  String get billing_manage => 'Urus langganan';

  @override
  String get billing_deleteAccountWarning =>
      'Jika anda mempunyai langganan Google Play, memadam akaun FuzeVPN anda tidak membatalkan pembaharuannya. Urus atau batalkan pembaharuan langganan secara berasingan dalam Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Teruskan ke permohonan pemadaman akaun';

  @override
  String get billing_refresh => 'Segarkan akses';

  @override
  String get billing_loadingPlans => 'Memuatkan pelan…';

  @override
  String get billing_unavailable =>
      'Tiada pelan tersedia sekarang. Cuba lagi kemudian.';

  @override
  String get billing_comingSoon => 'Langganan akan tersedia tidak lama lagi.';

  @override
  String get billing_priceDisclosure =>
      'Harga disediakan oleh Google Play. Jumlah akhir dan cukai yang dikenakan disahkan sebelum pengesahan anda.';

  @override
  String get billing_renewalMonthly =>
      'Diperbaharui secara automatik setiap bulan kecuali dibatalkan. Anda boleh membatalkan pada bila-bila masa dalam langganan Google Play.';

  @override
  String get billing_renewalYearly =>
      'Diperbaharui secara automatik setiap tahun kecuali dibatalkan. Anda boleh membatalkan pada bila-bila masa dalam langganan Google Play.';

  @override
  String get billing_active => 'Akses Premium anda aktif';

  @override
  String billing_accessUntil(String date) {
    return 'Akses sehingga $date.';
  }

  @override
  String get billing_webManaged =>
      'Langganan anda diurus di laman web FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Langganan anda diurus melalui Google Play.';

  @override
  String get billing_inactive => 'Tiada langganan aktif.';

  @override
  String get billing_checkingAccess => 'Menyemak akses anda…';

  @override
  String get billing_restoring => 'Memulihkan pembelian…';

  @override
  String get billing_pending =>
      'Pembayaran belum selesai. Akses akan diaktifkan selepas pengesahan.';

  @override
  String get billing_cancelled =>
      'Pembelian dibatalkan. Tiada langganan baharu diaktifkan.';

  @override
  String get billing_verifying => 'Mengesahkan pembelian…';

  @override
  String get billing_success =>
      'Langganan diaktifkan. Akses Premium anda sedia.';

  @override
  String get billing_restored => 'Pembelian anda telah dipulihkan.';

  @override
  String get billing_restoreEmpty =>
      'Tiada pembelian untuk dipulihkan bagi akaun Google Play ini.';

  @override
  String get billing_catalogError => 'Tidak dapat memuatkan pelan. Cuba lagi.';

  @override
  String get billing_purchaseError =>
      'Tidak dapat memulakan pembelian. Cuba lagi.';

  @override
  String get billing_verificationError =>
      'Pengesahan pembelian tidak tersedia buat sementara waktu. Pulihkan pembelian untuk mencuba lagi.';

  @override
  String get billing_restoreError =>
      'Tidak dapat memulihkan pembelian. Cuba lagi.';

  @override
  String get billing_managementError =>
      'Tidak dapat membuka pengurusan langganan. Cuba lagi.';

  @override
  String get billing_storeUnavailable =>
      'Google Play tidak tersedia pada peranti ini.';

  @override
  String get welcome_title => 'VPN anda, lebih mudah.';

  @override
  String get welcome_description =>
      'Lindungi sambungan anda. Kekalkan kawalan terhadap privasi anda.';

  @override
  String get welcome_start => 'Mula';

  @override
  String get welcome_alreadyPurchased => 'Sudah membeli?';

  @override
  String get welcome_noAccountRequired =>
      'Tidak perlu mencipta akaun untuk bermula.';

  @override
  String get guest_accountTitle => 'Akaun belum dipautkan';

  @override
  String get guest_accountDescription =>
      'Pulihkan pembelian dengan akaun Google Play yang sama untuk menggunakan langganan pada peranti lain.';

  @override
  String get guest_existingSubscriberSignIn => 'Sudah melanggan? Log masuk';

  @override
  String get guest_claimTitle => 'Gunakan FuzeVPN di mana-mana';

  @override
  String get guest_claimDescription =>
      'Cipta akaun untuk mengakses langganan pada peranti anda yang lain. Langkah ini pilihan.';

  @override
  String get guest_skip => 'Kemudian';

  @override
  String get guest_activationTitle => 'Fuze Premium aktif';

  @override
  String get guest_activationDescription =>
      'Langganan anda sudah sedia. Gunakan VPN dan cipta akaun bila-bila masa anda mahu.';

  @override
  String get guest_useVpn => 'Gunakan VPN saya';

  @override
  String get guest_loginRequired =>
      'Pembelian ini sudah dipautkan kepada akaun FuzeVPN. Log masuk ke akaun tersebut untuk mengakses langganan anda.';

  @override
  String get guest_signOutWarning =>
      'Anda boleh mendapatkan semula langganan dengan memulihkan pembelian menggunakan akaun Google Play yang sama.';

  @override
  String get guest_profileUnavailable =>
      'Akaun anda sudah dipautkan. Log masuk untuk melihat dan mengurus maklumat anda.';

  @override
  String get billing_acceptance =>
      'Dengan meneruskan, anda menerima Syarat Penggunaan dan Dasar Privasi.';

  @override
  String get guest_verifyEmailReminder =>
      'Sahkan alamat e-mel untuk melindungi akaun anda. Anda boleh terus menggunakan VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Perkhidmatan tidak tersedia buat sementara waktu. Cuba lagi sebentar.';

  @override
  String get guest_restoreError =>
      'Pembelian anda tidak dapat dipulihkan. Cuba lagi dengan akaun Google Play yang digunakan untuk pembelian.';

  @override
  String get guest_claimSuccess =>
      'Akaun anda telah dicipta. Langganan dan akses VPN anda dikekalkan.';

  @override
  String get guest_emailExists =>
      'E-mel ini sudah digunakan. Pilih alamat lain atau log masuk ke akaun sedia ada. Pembelian anda masih tersedia melalui Google Play.';

  @override
  String get guest_claimError =>
      'Akaun anda tidak dapat dicipta. Anda boleh terus menggunakan VPN dan cuba lagi kemudian.';

  @override
  String get guest_secureStorageError =>
      'Sesi anda tidak dapat disimpan dengan selamat pada peranti ini. Cuba lagi.';

  @override
  String get guest_premiumRequired =>
      'Pilih langganan untuk mengaktifkan VPN anda.';

  @override
  String get welcome_viewPlans => 'Lihat pelan';

  @override
  String get google_continue => 'Teruskan dengan Google';

  @override
  String get google_or => 'atau';

  @override
  String get google_title => 'Akaun FuzeVPN anda';

  @override
  String get google_settingUp => 'Lengkapkan akaun anda';

  @override
  String get google_country => 'Negara kediaman';

  @override
  String get google_profileDescription =>
      'Pilih negara anda dan baca kedua-dua dokumen untuk mencipta akaun FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Pautkan akaun tetamu kepada Google. Langganan dan peranti kekal dikaitkan dengan akaun ini.';

  @override
  String get google_linkTitle => 'Pautkan Google kepada FuzeVPN';

  @override
  String get google_linkDescription =>
      'Sahkan akses ke akaun FuzeVPN sedia ada. Kata laluan Google tidak diminta.';

  @override
  String get google_password => 'Kata laluan FuzeVPN';

  @override
  String get google_linkAccount => 'Sahkan pautan';

  @override
  String get google_requestEmail => 'Terima e-mel pengesahan';

  @override
  String get google_emailInstructions =>
      'Buka e-mel FuzeVPN dan masukkan kod pengesahan.';

  @override
  String get google_emailCode => 'Kod pengesahan e-mel';

  @override
  String get google_confirmEmail => 'Sahkan kod';

  @override
  String get google_restart => 'Pilih akaun Google lain';

  @override
  String get google_resume => 'Semak percubaan ini';

  @override
  String get google_unavailable =>
      'Log masuk Google tidak tersedia. Anda boleh menggunakan e-mel dan kata laluan.';

  @override
  String get google_expired =>
      'Percubaan ini tamat tempoh. Batalkan kemudian mulakan semula.';

  @override
  String get google_conflict =>
      'Akaun Google ini sudah dipautkan kepada akaun lain. Akaun dan langganan semasa dikekalkan.';

  @override
  String get google_error =>
      'Log masuk Google gagal. Cuba lagi; akses semasa dikekalkan.';

  @override
  String get google_uncertain =>
      'Hasil tidak dapat disahkan. Semak percubaan ini atau batalkan sebelum bermula semula.';

  @override
  String get google_cancelFailed =>
      'Pembatalan tidak dapat disahkan. Cuba batalkan lagi sebelum meninggalkan skrin ini.';

  @override
  String get google_cancelled => 'Log masuk Google dibatalkan.';

  @override
  String get google_selecting => 'Pilih akaun Google anda…';

  @override
  String get google_verifying => 'Menyemak akaun anda…';

  @override
  String get google_emailUnavailable =>
      'E-mel pengesahan tidak dapat dihantar. Cuba lagi kemudian.';

  @override
  String get google_emailSent =>
      'E-mel pengesahan dihantar. Semak peti masuk anda.';

  @override
  String get google_rateLimited => 'Sila tunggu sebelum mencuba lagi.';

  @override
  String get google_invalidPassword =>
      'Kata laluan FuzeVPN tidak betul. Akaun semasa dikekalkan.';

  @override
  String get google_invalidCode =>
      'Kod pengesahan tidak sah atau tamat tempoh.';

  @override
  String get google_accountChanged =>
      'Sesi telah berubah. Batalkan percubaan ini sebelum bermula semula.';

  @override
  String get google_invalidResponse =>
      'Respons tidak dapat disahkan. Akses semasa dikekalkan.';

  @override
  String get google_invalidRegistration =>
      'Semak negara dan kedua-dua persetujuan.';

  @override
  String get google_consentRequired =>
      'Pilih negara dan terima kedua-dua dokumen untuk meneruskan.';

  @override
  String get google_challengeRequired =>
      'Semakan keselamatan tambahan diperlukan. Akses semasa dikekalkan.';

  @override
  String get google_challengeUnavailable =>
      'Semakan keselamatan tidak tersedia. Cuba lagi kemudian.';

  @override
  String get billing_trialTitle => 'Cuba Fuze Premium secara percuma';

  @override
  String get billing_trialSubtitle => 'Lindungi sambungan anda mulai hari ini.';

  @override
  String get billing_trialWeeks => 'Percubaan percuma 2 minggu';

  @override
  String billing_trialDays(String days) {
    return 'Percubaan percuma $days hari';
  }

  @override
  String get billing_trialStart => 'Mulakan percubaan percuma saya';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Jika bermula hari ini, caj pertama dijangka pada $date.';
  }

  @override
  String get billing_trialTerms =>
      'Diperbaharui secara automatik pada harga yang dinyatakan. Untuk mengelakkan caj, batalkan di Google Play sebelum percubaan tamat.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Kemudian $price sebulan';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Kemudian $price setahun';
  }

  @override
  String get billing_choosePeriod => 'Pilih pelan anda';

  @override
  String get billing_selectionHint => 'Pilih pelan untuk meneruskan.';

  @override
  String get billing_benefitConnection => 'Sambungan disulitkan';

  @override
  String get billing_benefitPrivacy => 'Privasi dalam talian';

  @override
  String get billing_benefitNoAccount => 'Pendaftaran tidak diwajibkan';

  @override
  String get billing_cancellation => 'Pembatalan di Google Play';

  @override
  String get billing_premiumTitle => 'Sambungan anda lebih terlindung.';

  @override
  String get billing_premiumSubtitle =>
      'Lindungi sambungan mengikut keperluan anda.';

  @override
  String get billing_priceMonthly => 'sebulan';

  @override
  String get billing_priceYearly => 'setahun';

  @override
  String get billing_trialToday => 'Tiada bayaran hari ini';

  @override
  String get billing_trialConfirmation =>
      'Google Play mengesahkan tarikh, jumlah akhir dan cukai yang dikenakan sebelum pengesahan anda.';

  @override
  String get billing_offerChanged =>
      'Syarat tawaran ini telah berubah. Muat semula pelan dan pilih semula.';
}
