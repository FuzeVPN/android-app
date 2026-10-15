// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Lindungi koneksi Anda';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN menggunakan layanan VPN Android (VpnService) untuk membuat terowongan terenkripsi antara perangkat ini dan server FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Saat VPN aktif, lalu lintas Internet aplikasi Anda, alamat tujuan, dan permintaan DNS melewati terowongan ini untuk merutekan koneksi Anda, bahkan saat FuzeVPN berjalan di latar belakang.';

  @override
  String get vpnDisclosure_statusBody =>
      'Aplikasi menggunakan status koneksi, durasinya, dan jumlah data yang ditransfer untuk menampilkan koneksi VPN Anda. Anda dapat menghentikannya kapan saja.';

  @override
  String get vpnDisclosure_privacy => 'Privasi';

  @override
  String get vpnDisclosure_accept => 'Setujui dan lanjutkan';

  @override
  String get vpnDisclosure_decline => 'Tidak sekarang';

  @override
  String get accountRestoration_title => 'Akun untuk sementara tidak tersedia';

  @override
  String get accountRestoration_message =>
      'Sesi Anda tetap tersimpan. Coba lagi untuk memulihkan akun; Anda masih dapat mengelola koneksi VPN di sini.';

  @override
  String get action_retry => 'Coba lagi';

  @override
  String get session_endingTitle => 'Mengakhiri sesi';

  @override
  String get session_ending =>
      'Sesi Anda dibatalkan. Menghentikan VPN dan menghapus sesi…';

  @override
  String get session_stopFailed =>
      'Penghentian VPN belum dikonfirmasi. Coba lagi sebelum masuk kembali.';

  @override
  String get session_cleanupFailed =>
      'VPN sudah dihentikan, tetapi penghapusan sesi belum dikonfirmasi. Coba hapus sesi lagi.';

  @override
  String get session_retryStop => 'Coba hentikan lagi';

  @override
  String get session_retryCleanup => 'Coba hapus lagi';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Menyiapkan FuzeVPN dengan aman…';

  @override
  String get nav_connection => 'Koneksi';

  @override
  String get nav_locations => 'Lokasi';

  @override
  String get nav_account => 'Akun';

  @override
  String get nav_devices => 'Perangkat';

  @override
  String get nav_settings => 'Pengaturan';

  @override
  String get action_refresh => 'Segarkan';

  @override
  String get auth_tab_login => 'Masuk';

  @override
  String get auth_tab_register => 'Daftar';

  @override
  String get auth_stepAccount => 'Akun';

  @override
  String get auth_stepIdentity => 'Identitas';

  @override
  String get auth_stepAddress => 'Alamat dan persetujuan';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Langkah $current dari $total';
  }

  @override
  String get auth_tagline => 'VPN Anda, dibuat sederhana.';

  @override
  String get auth_keysLocal =>
      'Kunci VPN pribadi Anda tetap berada di perangkat ini.';

  @override
  String get form_email => 'Alamat email';

  @override
  String get form_password => 'Kata sandi';

  @override
  String get form_showPassword => 'Tampilkan kata sandi';

  @override
  String get form_hidePassword => 'Sembunyikan kata sandi';

  @override
  String get form_passwordMin =>
      '8–72 byte UTF-8. Beberapa karakter menggunakan lebih dari satu byte.';

  @override
  String get form_firstName => 'Nama depan';

  @override
  String get form_lastName => 'Nama belakang';

  @override
  String get form_phone => 'Telepon (+33612345678)';

  @override
  String get form_address => 'Alamat';

  @override
  String get form_address2 => 'Baris alamat 2 (opsional)';

  @override
  String get form_postalCode => 'Kode pos';

  @override
  String get form_city => 'Kota';

  @override
  String get form_country => 'Kode negara (misalnya FR)';

  @override
  String get action_login => 'Masuk';

  @override
  String get action_createAccount => 'Buat akun';

  @override
  String get action_createMyAccount => 'Buat akun saya';

  @override
  String get action_next => 'Lanjutkan';

  @override
  String get action_previous => 'Kembali';

  @override
  String get action_forgotPassword => 'Lupa kata sandi?';

  @override
  String get auth_noAccount => 'Belum memiliki akun?';

  @override
  String get auth_requiredInformation => 'Buat akun Anda dalam tiga langkah.';

  @override
  String get auth_termsPrefix => 'Saya menerima ';

  @override
  String get auth_termsLink => 'ketentuan penggunaan';

  @override
  String get auth_privacyPrefix => 'Saya menerima ';

  @override
  String get auth_privacyLink => 'kebijakan privasi';

  @override
  String get auth_consentRequired =>
      'Persetujuan Anda diperlukan untuk membuat akun.';

  @override
  String get validation_required => 'Kolom ini wajib diisi.';

  @override
  String get validation_email => 'Masukkan alamat email yang valid.';

  @override
  String get validation_password =>
      'Kata sandi terlalu pendek: minimal 8 byte UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Kata sandi terlalu panjang: maksimal 72 byte UTF-8.';

  @override
  String get validation_phone =>
      'Gunakan format internasional, misalnya +33612345678.';

  @override
  String get validation_country =>
      'Gunakan kode negara dua huruf, misalnya FR.';

  @override
  String get passwordReset_title => 'Atur ulang kata sandi';

  @override
  String get passwordReset_description =>
      'Masukkan alamat email akun Anda untuk meminta tautan pengaturan ulang kata sandi.';

  @override
  String get passwordReset_send => 'Kirim tautan';

  @override
  String get connection_title => 'Koneksi Anda';

  @override
  String get connection_subtitle => 'Pilih lokasi, lalu aktifkan VPN Anda.';

  @override
  String get connection_prepare => 'Siap terhubung?';

  @override
  String get connection_advancedOptions => 'Opsi lanjutan';

  @override
  String get connection_location => 'Lokasi';

  @override
  String get connection_chooseLocation => 'Pilih lokasi';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Hubungkan';

  @override
  String get connection_connecting => 'Menghubungkan…';

  @override
  String get connection_disconnect => 'Putuskan';

  @override
  String get connection_disconnecting => 'Memutuskan';

  @override
  String get connection_locationChange => 'Mengubah lokasi…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol tidak tersedia';
  }

  @override
  String get connection_activeLocation => 'Lokasi aktif';

  @override
  String get connection_duration => 'Durasi';

  @override
  String get connection_received => 'Diterima';

  @override
  String get connection_sent => 'Dikirim';

  @override
  String get connection_lastHandshake => 'Pertukaran aman terakhir';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration yang lalu';
  }

  @override
  String get verification_title => 'Konfirmasikan alamat email Anda';

  @override
  String get verification_message =>
      'Konfirmasikan alamat email Anda untuk menggunakan VPN di ponsel ini.';

  @override
  String get verification_resend => 'Kirim ulang email';

  @override
  String get migration_title => 'Perubahan lokasi';

  @override
  String get migration_draining => 'Menyiapkan perubahan lokasi…';

  @override
  String get migration_activating => 'Mengaktifkan server baru…';

  @override
  String get migration_ready => 'Lokasi diperbarui.';

  @override
  String get migration_blocked =>
      'Perubahan lokasi memerlukan tindakan dari server. Coba lagi nanti atau hubungi dukungan.';

  @override
  String get migration_progress => 'Kemajuan perubahan lokasi';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Jeda antar pemeriksaan: $seconds dtk.';
  }

  @override
  String get migration_resume => 'Lanjutkan perubahan lokasi';

  @override
  String get status_authorizing => 'Izin diperlukan';

  @override
  String get status_authorizingDetail =>
      'Terima permintaan Android untuk mengizinkan VPN.';

  @override
  String get status_preparing => 'Menyiapkan';

  @override
  String get status_preparingDetail => 'Menyiapkan koneksi aman Anda.';

  @override
  String get status_reconnecting => 'Menghubungkan kembali…';

  @override
  String get status_reconnectingDetail =>
      'Koneksi terputus. VPN sedang mencoba terhubung kembali.';

  @override
  String get status_connecting => 'Menghubungkan';

  @override
  String get status_connectingDetail => 'Menghubungkan ke server VPN…';

  @override
  String get status_connected => 'Terhubung';

  @override
  String get status_connectedDetail => 'Koneksi VPN Anda aktif.';

  @override
  String get status_disconnecting => 'Memutuskan';

  @override
  String get status_disconnectingDetail =>
      'Koneksi VPN Anda sedang dihentikan.';

  @override
  String get status_error => 'Koneksi tidak tersedia';

  @override
  String get status_errorDetail => 'Koneksi VPN belum dikonfirmasi. Coba lagi.';

  @override
  String get status_idle => 'Terputus';

  @override
  String get status_idleDetail =>
      'Hubungkan VPN untuk melindungi koneksi Anda.';

  @override
  String get trust_note =>
      'Menutup aplikasi tidak menghentikan VPN. Untuk menghentikannya, gunakan Putuskan.';

  @override
  String get locations_none => 'Saat ini tidak ada lokasi yang tersedia.';

  @override
  String get locations_available => 'Pilih lokasi berikutnya.';

  @override
  String get locations_selected => 'Lokasi yang dipilih';

  @override
  String get locations_select => 'Pilih lokasi ini';

  @override
  String get locations_lockedTunnel => 'Putuskan VPN untuk mengubah lokasi.';

  @override
  String get locations_lockedMigration =>
      'Tunggu hingga perubahan lokasi selesai.';

  @override
  String get devices_title => 'Perangkat Anda';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit perangkat';
  }

  @override
  String get devices_refresh => 'Segarkan perangkat';

  @override
  String get devices_empty => 'Belum ada perangkat VPN yang terdaftar.';

  @override
  String get devices_firstConnection =>
      'Ponsel Anda akan ditambahkan saat koneksi pertama.';

  @override
  String get devices_thisDevice => 'Perangkat ini';

  @override
  String devices_added(Object date) {
    return 'Ditambahkan pada $date';
  }

  @override
  String get action_remove => 'Hapus';

  @override
  String get settings_title => 'Pengaturan';

  @override
  String get settings_subtitle =>
      'Preferensi dan akun Anda, semuanya di satu tempat.';

  @override
  String get settings_appearance => 'Tampilan';

  @override
  String get settings_language => 'Bahasa';

  @override
  String get settings_languageDescription =>
      'Bahasa yang Anda pilih juga berlaku untuk notifikasi VPN.';

  @override
  String get settings_account => 'Akun';

  @override
  String get settings_signOut => 'Keluar';

  @override
  String get settings_privacy => 'Kebijakan privasi';

  @override
  String get settings_terms => 'Ketentuan penggunaan';

  @override
  String get settings_security => 'Keamanan dan transparansi';

  @override
  String get settings_licenses => 'Lisensi komponen';

  @override
  String get settings_licensesDetail =>
      'Perangkat lunak yang digunakan dalam aplikasi';

  @override
  String get settings_background =>
      'VPN tetap aktif saat Anda meninggalkan aplikasi. Untuk menghentikannya, gunakan Putuskan pada tab Koneksi.';

  @override
  String get theme_system => 'Sistem';

  @override
  String get theme_light => 'Terang';

  @override
  String get theme_dark => 'Gelap';

  @override
  String get language_system => 'Bahasa ponsel';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Hapus perangkat ini?';

  @override
  String get dialog_removeCurrent =>
      'Ponsel ini akan terputus dari VPN dan kehilangan akses. Data koneksi VPN-nya akan dihapus setelah server mengonfirmasi.';

  @override
  String dialog_removeOther(Object name) {
    return 'Akses VPN untuk “$name” akan dicabut. Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get dialog_signOut => 'Keluar?';

  @override
  String get dialog_signOutMessage =>
      'VPN akan dihentikan dan Anda harus masuk kembali. Kunci VPN terenkripsi Anda akan tetap berada di ponsel ini untuk koneksi berikutnya.';

  @override
  String get action_cancel => 'Batal';

  @override
  String get action_signOut => 'Keluar';

  @override
  String get notice_close => 'Tutup pesan';

  @override
  String get notice_sessionExpired_title => 'Sesi kedaluwarsa';

  @override
  String get notice_sessionExpired_message =>
      'Sesi Anda telah kedaluwarsa. Masuk kembali.';

  @override
  String get notice_connectionFailed_title => 'Koneksi gagal';

  @override
  String get notice_invalidCredentials_message =>
      'Alamat email atau kata sandi salah.';

  @override
  String get notice_emailVerification_title => 'Konfirmasi email diperlukan';

  @override
  String get notice_emailVerification_message =>
      'Konfirmasikan alamat email Anda sebelum menambahkan perangkat VPN.';

  @override
  String get notice_rateLimited_title => 'Terlalu banyak percobaan';

  @override
  String get notice_deviceLimit_title => 'Batas 2 perangkat tercapai';

  @override
  String get notice_deviceLimit_message =>
      'Hapus perangkat yang sudah ada sebelum menambahkan perangkat lain.';

  @override
  String get notice_identityRenewal_title => 'Identitas VPN harus diperbarui';

  @override
  String get notice_identityRenewal_message =>
      'Identitas ini telah dihapus. Buat identitas lokal baru.';

  @override
  String get notice_migrationPending_title =>
      'Perubahan lokasi sedang berlangsung';

  @override
  String get notice_migrationPending_message =>
      'Perubahan lokasi sudah sedang berlangsung.';

  @override
  String get notice_migrationBlocked_title => 'Perubahan lokasi terhalang';

  @override
  String get notice_migrationBlocked_message =>
      'Perubahan lokasi memerlukan tindakan dari server. Coba lagi nanti atau hubungi dukungan.';

  @override
  String get notice_targetUnavailable_title =>
      'Server untuk sementara tidak tersedia';

  @override
  String get notice_targetUnavailable_message =>
      'Server ini untuk sementara tidak tersedia.';

  @override
  String get notice_networkUnavailable_title =>
      'Koneksi internet tidak tersedia';

  @override
  String get notice_networkUnavailable_message =>
      'Periksa koneksi Anda dan coba lagi.';

  @override
  String get notice_permissionDenied_title => 'Izin VPN ditolak';

  @override
  String get notice_permissionDenied_message =>
      'Mulai kembali koneksi dan terima permintaan izin Android.';

  @override
  String get notice_wireguardTimeout_title => 'Server tidak merespons';

  @override
  String get notice_wireguardTimeout_message =>
      'Koneksi WireGuard memerlukan waktu terlalu lama. Coba lagi atau pilih lokasi lain.';

  @override
  String get notice_tlsFailed_title => 'Koneksi aman ditolak';

  @override
  String get notice_tlsFailed_message =>
      'Server tidak menerima koneksi OpenVPN. Coba lagi. Jika masalah berlanjut, jalankan diagnostik.';

  @override
  String get notice_tunRejected_title => 'Android menolak antarmuka VPN';

  @override
  String get notice_tunRejected_message =>
      'Android menolak konfigurasi jaringan yang diminta oleh OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN tidak dapat dimulai';

  @override
  String get notice_openvpnStart_message =>
      'Mesin OpenVPN tidak dapat menyelesaikan proses mulai. Coba lagi. Jika masalah berlanjut, hubungi dukungan.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kode diagnostik: $code';
  }

  @override
  String get notice_generic_title => 'Koneksi VPN gagal';

  @override
  String get notice_generic_message => 'Terjadi kesalahan. Coba lagi nanti.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Akun dibuat',
      'password_reset_sent': 'Permintaan pengaturan ulang kata sandi diterima',
      'verification_email_sent': 'Email verifikasi dikirim',
      'location_migration_pending': 'Perubahan lokasi sedang berlangsung',
      'vpn_sign_in_required': 'Harus masuk',
      'protocol_unavailable_at_location': 'Protokol tidak tersedia',
      'vpn_permission_denied': 'Izin VPN ditolak',
      'revoked_identity_device_limit': 'Batas 2 perangkat tercapai',
      'tunnel_start_unexpected': 'VPN tidak dapat dimulai',
      'flutter_disconnect_timeout': 'Pemutusan belum dikonfirmasi',
      'flutter_disconnect_unexpected': 'Tidak dapat memutuskan',
      'device_revoked': 'Perangkat dihapus',
      'revoke_unexpected': 'Tidak dapat menghapus perangkat',
      'identity_renewal_unexpected': 'Tidak dapat memperbarui identitas',
      'openvpn_renewal_unexpected': 'Tidak dapat memperbarui OpenVPN',
      'location_migration_blocked': 'Perubahan lokasi terhalang',
      'location_migration_slow': 'Perubahan lokasi masih berlangsung',
      'location_migration_conflict': 'Perubahan lokasi perlu disegarkan',
      'location_migration_verification_failed':
          'Perubahan lokasi belum dikonfirmasi',
      'location_migration_device_changed':
          'Perangkat berubah selama perubahan lokasi',
      'tunnel_stop_failed': 'Perubahan lokasi tidak tersedia',
      'other': 'Operasi gagal',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Akun telah dibuat, tetapi email verifikasi tidak dapat dikirim. Gunakan kirim ulang di aplikasi.',
      'password_reset_sent':
          'Permintaan Anda telah diterima. Jika ada akun yang cocok dengan alamat ini, Anda mungkin menerima email. Periksa juga folder spam Anda.',
      'verification_email_sent': 'Email verifikasi baru saja dikirim.',
      'location_migration_pending':
          'Pemindahan ke $target masih disiapkan. Anda dapat melanjutkannya tanpa membuat ulang perangkat.',
      'vpn_sign_in_required': 'Masuk ke akun Anda sebelum memulai VPN.',
      'protocol_unavailable_at_location':
          'Protokol yang dipilih tidak ditawarkan oleh lokasi ini. Segarkan lokasi atau pilih protokol lain.',
      'vpn_permission_denied':
          'Android menolak izin VPN. Mulai kembali koneksi dan terima permintaan sistem.',
      'revoked_identity_device_limit':
          'Akses VPN perangkat ini telah dihapus dan batas perangkat telah tercapai. Hapus perangkat melalui Akun → Kelola perangkat saya.',
      'tunnel_start_unexpected':
          'Kesalahan tak terduga menghentikan persiapan tunnel. Periksa kode diagnostik dan coba lagi.',
      'flutter_disconnect_timeout':
          'Android tidak mengonfirmasi bahwa VPN berhenti tepat waktu. Coba hentikan lagi.',
      'flutter_disconnect_unexpected':
          'Kesalahan tak terduga menghalangi konfirmasi bahwa tunnel telah berhenti.',
      'device_revoked':
          'Akses VPN perangkat telah dicabut dan rahasia lokalnya telah dihapus.',
      'revoke_unexpected':
          'Perangkat tidak dapat dihapus. Segarkan daftar dan coba lagi.',
      'identity_renewal_unexpected':
          'Identitas VPN baru tidak dapat dibuat. Segarkan perangkat dan coba lagi.',
      'openvpn_renewal_unexpected':
          'Profil OpenVPN tidak dapat diperbarui. Coba lagi atau periksa kode diagnostik.',
      'location_migration_blocked':
          'Server tidak dapat menyelesaikan perubahan ini sekarang. Perangkat dan identitas lokalnya tetap disimpan.',
      'location_migration_slow':
          'Server masih menyiapkan pemindahan ke $target. Gunakan Lanjutkan beberapa saat lagi.',
      'location_migration_conflict':
          'Status perangkat berubah di server. Segarkan perangkat, lalu lanjutkan perubahan.',
      'location_migration_verification_failed':
          'Server tidak mengonfirmasi lokasi baru. Identitas lokal sebelumnya tetap disimpan.',
      'location_migration_device_changed':
          'Perangkat yang dikembalikan server tidak lagi cocok dengan perangkat yang sedang diubah. Segarkan perangkat sebelum mencoba lagi.',
      'tunnel_stop_failed':
          'Tunnel sebelumnya harus dihentikan sepenuhnya sebelum koneksi baru dibuat.',
      'other':
          'Operasi tidak dapat diselesaikan. Coba lagi atau kirim kode diagnostik ke dukungan.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesi kedaluwarsa',
      'invalid_credentials': 'Gagal masuk',
      'email_verification_required': 'Konfirmasi email diperlukan',
      'verification_email_cooldown': 'Email sudah dikirim',
      'rate_limited': 'Terlalu banyak percobaan',
      'invalid_registration': 'Informasi harus diperbaiki',
      'email_exists': 'Akun sudah ada',
      'invalid_profile': 'Profil tidak valid',
      'invalid_device': 'Perangkat tidak valid',
      'invalid_location': 'Lokasi tidak tersedia',
      'device_limit': 'Batas perangkat tercapai',
      'device_exists': 'Identitas VPN sudah digunakan',
      'device_identity_revoked': 'Identitas VPN harus diperbarui',
      'device_location_locked': 'Perubahan lokasi perlu disegarkan',
      'location_migration_pending': 'Perubahan lokasi sedang berlangsung',
      'location_migration_blocked': 'Perubahan lokasi terhalang',
      'target_ca_mismatch': 'Server OpenVPN tidak kompatibel',
      'location_migration_conflict': 'Perubahan lokasi perlu disegarkan',
      'server_full': 'Server penuh',
      'capacity_unavailable': 'Lokasi untuk sementara tidak tersedia',
      'target_unavailable': 'Server untuk sementara tidak tersedia',
      'not_found': 'Item tidak ditemukan',
      'invalid_openvpn_csr': 'Identitas OpenVPN tidak valid',
      'openvpn_profile_exists': 'Profil OpenVPN sudah ada',
      'openvpn_profile_revoked': 'Profil OpenVPN dicabut',
      'openvpn_operation_pending': 'Operasi OpenVPN sedang berlangsung',
      'openvpn_operation_terminal': 'Operasi OpenVPN terputus',
      'openvpn_address_unavailable': 'Alamat OpenVPN tidak tersedia',
      'openvpn_profile_conflict': 'Konflik OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN tidak tersedia',
      'email_delivery_unavailable': 'Email tidak tersedia',
      'invalid_token': 'Tautan tidak valid',
      'network_unavailable': 'Koneksi internet tidak tersedia',
      'invalid_json': 'Permintaan tidak valid',
      'invalid_api_response': 'Respons server tidak valid',
      'ipv6_unavailable': 'IPv6 tidak tersedia',
      'invalid_ip_families': 'Konfigurasi jaringan ditolak',
      'other': 'Layanan tidak tersedia',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sesi Anda telah kedaluwarsa. Masuk kembali.',
      'invalid_credentials': 'Alamat email atau kata sandi salah.',
      'email_verification_required':
          'Konfirmasikan alamat email Anda sebelum menambahkan perangkat VPN.',
      'invalid_registration': 'Periksa informasi dan persetujuan yang diminta.',
      'email_exists': 'Sudah ada akun yang menggunakan alamat email ini.',
      'invalid_profile': 'Periksa informasi profil Anda.',
      'invalid_device':
          'Nama perangkat atau identitas lokal perangkat ini tidak valid.',
      'invalid_location': 'Segarkan daftar lokasi dan coba lagi.',
      'device_limit':
          'Hapus perangkat yang sudah ada sebelum menambahkan perangkat lain.',
      'device_exists': 'Identitas VPN ini sudah ditautkan ke akun lain.',
      'device_identity_revoked':
          'Identitas ini telah dihapus. Identitas lokal baru harus dibuat.',
      'device_location_locked':
          'Lokasi perangkat ini baru saja berubah. Aplikasi akan melanjutkan perubahan yang sedang berlangsung.',
      'location_migration_pending':
          'Perubahan lokasi sudah sedang berlangsung.',
      'location_migration_blocked':
          'Perubahan lokasi memerlukan tindakan dari server. Coba lagi nanti atau hubungi dukungan.',
      'target_ca_mismatch':
          'Server ini belum kompatibel dengan profil OpenVPN saat ini.',
      'location_migration_conflict':
          'Segarkan perangkat, lalu coba ubah lokasi lagi.',
      'server_full':
          'Lokasi ini telah mencapai batas koneksinya. Pilih lokasi lain atau coba lagi nanti.',
      'capacity_unavailable':
          'Kami tidak dapat mengonfirmasi apakah lokasi ini tersedia sekarang. Pilih lokasi lain atau coba lagi nanti.',
      'target_unavailable': 'Server ini untuk sementara tidak tersedia.',
      'not_found': 'Item ini tidak lagi tersedia di akun Anda.',
      'invalid_openvpn_csr': 'Buat identitas OpenVPN baru dan coba lagi.',
      'openvpn_profile_exists': 'Profil OpenVPN sudah ada untuk perangkat ini.',
      'openvpn_profile_revoked': 'Perbarui profil OpenVPN untuk melanjutkan.',
      'openvpn_operation_pending':
          'Perubahan masih disebarkan. Coba lagi nanti.',
      'openvpn_operation_terminal':
          'Buat identitas OpenVPN baru dan coba lagi.',
      'openvpn_address_unavailable':
          'Saat ini tidak ada alamat OpenVPN yang tersedia.',
      'openvpn_profile_conflict':
          'Profil telah berubah. Segarkan perangkat dan coba lagi.',
      'openvpn_signer_unavailable':
          'Layanan OpenVPN untuk sementara tidak tersedia.',
      'email_delivery_unavailable':
          'Email tidak dapat dikirim. Coba lagi nanti.',
      'invalid_token':
          'Tautan ini tidak valid atau telah kedaluwarsa. Minta tautan baru.',
      'network_unavailable': 'Periksa koneksi internet Anda dan coba lagi.',
      'invalid_json': 'Periksa informasi yang dimasukkan dan coba lagi.',
      'invalid_api_response':
          'Server mengembalikan respons yang tidak terduga. Coba lagi nanti.',
      'ipv6_unavailable':
          'Server tidak dapat mengaktifkan IPv6 saat ini. Coba lagi nanti.',
      'invalid_ip_families':
          'Konfigurasi tunnel tidak lengkap atau tidak cocok dengan alamat yang diizinkan. Coba lagi dari aplikasi.',
      'other': 'Terjadi kesalahan server. Coba lagi nanti.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Coba lagi beberapa saat lagi.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Coba lagi dalam $seconds detik.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Melanjutkan VPN sistem tidak tersedia',
      'system_vpn_resume_corrupt': 'Data lanjutan VPN sistem tidak valid',
      'system_vpn_resume_session_invalid': 'Sesi lanjutan VPN tidak valid',
      'system_vpn_resume_identity_changed': 'Identitas VPN berubah',
      'system_vpn_resume_identity_invalid':
          'Identitas lanjutan VPN tidak valid',
      'system_vpn_resume_storage_failed':
          'Penyimpanan lanjutan VPN tidak tersedia',
      'system_vpn_resume_network_timeout':
          'Tidak ada jaringan untuk melanjutkan VPN',
      'system_vpn_resume_blocked': 'Pelanjutan VPN diblokir',
      'system_vpn_resume_failed': 'Pelanjutan VPN gagal',
      'system_vpn_resume_error_invalid': 'Kesalahan pelanjutan VPN tidak valid',
      'wireguard_identity_store_failed': 'Identitas WireGuard tidak disimpan',
      'wireguard_identity_unavailable': 'Identitas WireGuard tidak tersedia',
      'vpn_host_destroyed': 'Host VPN Android dihentikan',
      'vpn_host_unavailable': 'Host VPN Android tidak tersedia',
      'vpn_permission_required': 'Izin VPN diperlukan',
      'vpn_permission_denied': 'Izin VPN ditolak',
      'vpn_permission_request_failed': 'Tidak dapat meminta izin',
      'wireguard_foreground_service_unavailable':
          'Layanan latar depan WireGuard tidak tersedia',
      'wireguard_identity_invalid': 'Kunci WireGuard lokal tidak valid',
      'wireguard_identity_in_use': 'Identitas WireGuard sudah digunakan',
      'wireguard_configuration_invalid': 'Konfigurasi WireGuard tidak valid',
      'wireguard_operation_pending': 'Operasi WireGuard masih aktif',
      'wireguard_start_failed': 'Pemulai WireGuard ditolak',
      'wireguard_stop_timeout': 'Penghentian WireGuard belum dikonfirmasi',
      'wireguard_handshake_timeout': 'WireGuard tidak merespons',
      'openvpn_connection_timeout': 'OpenVPN tidak merespons',
      'openvpn_core_unavailable': 'Mesin OpenVPN tidak tersedia',
      'openvpn_operation_pending': 'Sesi OpenVPN masih aktif',
      'openvpn_stop_timeout': 'Penghentian OpenVPN belum dikonfirmasi',
      'openvpn_profile_unavailable': 'Profil OpenVPN lokal tidak ada',
      'openvpn_native_failed': 'Panggilan OpenVPN asli terputus',
      'openvpn_key_generation_failed':
          'Tidak dapat membuat kunci OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Tidak dapat membuat CSR OpenVPN',
      'openvpn_identity_store_failed': 'Identitas OpenVPN tidak disimpan',
      'openvpn_identity_clear_failed': 'Penghapusan OpenVPN tidak lengkap',
      'openvpn_identity_in_use': 'Identitas OpenVPN masih digunakan',
      'openvpn_tls_verification_required': 'Verifikasi TLS OpenVPN tidak ada',
      'openvpn_cipher_invalid': 'Cipher OpenVPN tidak valid',
      'openvpn_profile_rejected': 'Profil OpenVPN ditolak',
      'openvpn_identity_inconsistent': 'Identitas OpenVPN tidak konsisten',
      'tls_handshake_failed': 'Negosiasi OpenVPN ditolak',
      'tls_alert_unknown_ca': 'Sertifikat klien OpenVPN tidak dikenali',
      'tls_alert_bad_certificate': 'Sertifikat klien OpenVPN ditolak',
      'tls_alert_unsupported_certificate': 'Sertifikat OpenVPN tidak didukung',
      'tls_client_certificate_required': 'Sertifikat klien OpenVPN diperlukan',
      'tls_alert_misc': 'Peringatan TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Tanda tangan OpenVPN tidak didukung',
      'tls_handshake_rejected': 'Negosiasi TLS OpenVPN ditolak',
      'tls_version_rejected': 'Versi TLS OpenVPN tidak kompatibel',
      'tls_certificate_expired': 'Sertifikat TLS kedaluwarsa',
      'tls_certificate_revoked': 'Sertifikat TLS dicabut',
      'transport_failed': 'Server OpenVPN tidak dapat dijangkau',
      'tun_configuration_rejected': 'Tidak dapat membuat antarmuka OpenVPN',
      'tun_setup_failed': 'Penyiapan TUN OpenVPN gagal',
      'tun_interface_create_failed': 'Pembuatan antarmuka OpenVPN gagal',
      'tun_interface_disabled': 'Antarmuka OpenVPN dinonaktifkan',
      'tun_halted': 'Antarmuka OpenVPN terputus',
      'tun_already_established': 'Antarmuka OpenVPN sudah terbuka',
      'tun_addresses_missing': 'Alamat OpenVPN tidak ada',
      'tun_routes_missing': 'Rute OpenVPN tidak ada',
      'tun_dns_missing': 'DNS OpenVPN tidak ada',
      'tun_permission_revoked': 'Izin VPN dicabut',
      'tun_establish_returned_null': 'Android menolak antarmuka VPN',
      'openvpn_service_start_failed': 'Layanan OpenVPN tidak tersedia',
      'openvpn_operation_timeout': 'Waktu panggilan OpenVPN habis',
      'openvpn_start_failed': 'Pemulai OpenVPN ditolak',
      'openvpn_connection_failed': 'Koneksi OpenVPN terputus',
      'openvpn_core_status_error': 'OpenVPN Core berakhir dengan kesalahan',
      'openvpn_stopped_before_connected': 'OpenVPN berhenti sebelum terhubung',
      'openvpn_auth_failed': 'Autentikasi OpenVPN ditolak',
      'openvpn_client_setup_failed': 'Penyiapan klien OpenVPN gagal',
      'openvpn_client_halted': 'Klien OpenVPN terputus',
      'openvpn_client_restart': 'Mulai ulang OpenVPN diminta',
      'openvpn_inactive_timeout': 'OpenVPN tidak aktif terlalu lama',
      'openvpn_session_expired': 'Sesi OpenVPN kedaluwarsa',
      'openvpn_credentials_required': 'Autentikasi OpenVPN tidak didukung',
      'openvpn_proxy_failed': 'Transport perantara OpenVPN gagal',
      'openvpn_compression_failed': 'Kompresi OpenVPN ditolak',
      'openvpn_ntlm_crypto_unavailable': 'Enkripsi NTLM OpenVPN tidak tersedia',
      'openvpn_feature_unsupported': 'Fitur OpenVPN tidak didukung',
      'network_unavailable': 'Koneksi internet tidak tersedia',
      'network_lost': 'Jaringan tidak tersedia',
      'certificate_validation_failed': 'Sertifikat server ditolak',
      'openvpn_certificate_expired': 'Sertifikat OpenVPN kedaluwarsa',
      'tunnel_active_for_another_account': 'Tunnel akun lain masih aktif',
      'tunnel_already_active': 'Tunnel asli sudah aktif',
      'tunnel_stop_timeout': 'Penghentian $protocol belum dikonfirmasi',
      'tunnel_disconnected': '$protocol terputus',
      'native_bridge_unavailable': 'Bridge Android tidak tersedia',
      'native_operation_failed': 'Operasi Android terputus',
      'invalid_arguments': 'Parameter VPN tidak lengkap',
      'invalid_account_id': 'Akun VPN tidak valid',
      'invalid_device_id': 'Pengenal perangkat tidak valid',
      'storage_key_not_allowed': 'Kunci penyimpanan ditolak',
      'secure_storage_read_failed': 'Pembacaan aman gagal',
      'secure_storage_write_failed': 'Penulisan aman gagal',
      'key_generation_failed': 'Tidak dapat membuat kunci WireGuard',
      'csr_generation_failed': 'Tidak dapat membuat CSR OpenVPN',
      'other': 'Kesalahan VPN asli yang tidak terklasifikasi',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android tidak dapat menemukan sesi VPN yang dapat dilanjutkan. Mulai koneksi baru di aplikasi.',
      'system_vpn_resume_corrupt':
          'Data lanjutan VPN yang tersimpan tidak valid dan tidak akan digunakan. Mulai koneksi baru.',
      'system_vpn_resume_session_invalid':
          'Sesi tersimpan tidak dapat lagi melanjutkan VPN. Masuk kembali di aplikasi.',
      'system_vpn_resume_identity_changed':
          'Identitas VPN lokal berubah. Pelanjutan dihentikan; mulai koneksi baru.',
      'system_vpn_resume_identity_invalid':
          'Identitas untuk melanjutkan tidak valid. Mulai koneksi baru.',
      'system_vpn_resume_storage_failed':
          'Android tidak dapat membaca atau memperbarui data lanjutan terenkripsi. Mulai koneksi baru.',
      'system_vpn_resume_network_timeout':
          'Android tidak menemukan jaringan tepat waktu untuk melanjutkan VPN. Coba lagi saat jaringan tersedia.',
      'system_vpn_resume_blocked':
          'Pelanjutan VPN diblokir. Periksa pengaturan Android, lalu mulai koneksi baru.',
      'system_vpn_resume_failed':
          'Pelanjutan VPN Android gagal. Mulai koneksi baru di aplikasi.',
      'system_vpn_resume_error_invalid':
          'Android mengembalikan kesalahan pelanjutan yang tidak dapat digunakan. Mulai koneksi baru.',
      'wireguard_identity_store_failed':
          'Android tidak dapat menyimpan identitas WireGuard terenkripsi akun ini.',
      'wireguard_identity_unavailable':
          'Tidak ada identitas WireGuard yang dapat digunakan untuk koneksi ini.',
      'vpn_host_destroyed':
          'Komponen Android yang menjadi host VPN dihentikan. Mulai koneksi baru.',
      'vpn_host_unavailable':
          'Android tidak dapat membuat komponen yang menjadi host VPN. Coba lagi setelah memeriksa pengaturan VPN.',
      'openvpn_renewal_required':
          'Sertifikat memerlukan tindakan di aplikasi sebelum terhubung.',
      'openvpn_recovery_failed':
          'Pemulihan otomatis gagal. Mulai koneksi baru di aplikasi.',
      'openvpn_recovery_exhausted':
          'Pemulihan otomatis sudah digunakan. Mulai koneksi baru di aplikasi.',
      'vpn_permission_required':
          'Android memerlukan otorisasi VPN baru sebelum memulai tunnel.',
      'vpn_permission_denied':
          'Izinkan FuzeVPN dalam permintaan Android untuk melanjutkan.',
      'vpn_permission_request_failed':
          'Android tidak dapat membuka layar izin VPN.',
      'wireguard_foreground_service_unavailable':
          'Android tidak dapat menjaga layanan WireGuard tetap berjalan di latar depan.',
      'wireguard_identity_invalid':
          'Kunci WireGuard terenkripsi akun ini tidak dapat dibaca atau tidak valid.',
      'wireguard_identity_in_use':
          'Operasi lain masih menggunakan kunci WireGuard akun ini.',
      'wireguard_configuration_invalid':
          'Alamat WireGuard, DNS, kunci server, atau rute yang diterima tidak valid.',
      'wireguard_operation_pending':
          'Operasi WireGuard sebelumnya belum melepaskan layanan aslinya.',
      'wireguard_start_failed': 'Mesin WireGuard menolak aktivasi konfigurasi.',
      'wireguard_stop_timeout':
          'Layanan WireGuard tidak mengonfirmasi pelepasan antarmuka VPN dalam batas waktu.',
      'wireguard_handshake_timeout':
          'Tunnel tidak mengonfirmasi handshake dengan server tepat waktu.',
      'openvpn_connection_timeout':
          'OpenVPN tidak mengonfirmasi koneksi ke server tepat waktu.',
      'openvpn_core_unavailable':
          'Versi aplikasi ini tidak berisi mesin OpenVPN yang dapat digunakan.',
      'openvpn_operation_pending':
          'Mesin asli masih menahan sesi OpenVPN sebelumnya dan menolak membuat sesi kedua.',
      'openvpn_stop_timeout':
          'OpenVPN Core tidak mengonfirmasi bahwa sesi aslinya berhenti dan dihancurkan dalam batas waktu.',
      'openvpn_profile_unavailable':
          'Tidak ada profil OpenVPN tervalidasi yang dapat dibaca untuk koneksi ini.',
      'openvpn_native_failed':
          'Kesalahan aplikasi mengganggu OpenVPN. Coba hubungkan lagi. Jika masalah berlanjut, jalankan diagnostik.',
      'openvpn_key_generation_failed':
          'Android Keystore tidak dapat membuat atau membaca kunci privat P-256 yang tidak dapat diekspor.',
      'openvpn_csr_generation_failed':
          'Kunci Android Keystore tidak dapat menandatangani permintaan sertifikat OpenVPN.',
      'openvpn_identity_store_failed':
          'Sertifikat atau profil OpenVPN tidak dapat disimpan dalam penyimpanan terenkripsi.',
      'openvpn_identity_clear_failed':
          'Android tidak dapat menghapus seluruh identitas OpenVPN lokal untuk akun ini.',
      'openvpn_identity_in_use':
          'Sesi OpenVPN asli masih menggunakan kunci atau sertifikat perangkat ini.',
      'openvpn_tls_verification_required':
          'Profil tidak secara eksplisit mewajibkan verifikasi sertifikat server.',
      'openvpn_cipher_invalid':
          'Server memberikan algoritme enkripsi yang tidak ada dalam daftar yang diizinkan.',
      'openvpn_profile_rejected':
          'Profil yang diterima dari server tidak kompatibel. Buat ulang perangkat ini dan coba lagi.',
      'openvpn_identity_inconsistent':
          'Sertifikat tidak cocok dengan identitas aman ponsel ini. Tidak ada profil lokal yang diganti.',
      'tls_handshake_failed':
          'Server menolak negosiasi TLS. Buat ulang profil jika masalah berlanjut.',
      'tls_alert_unknown_ca':
          'Server tidak mengenali otoritas sertifikat perangkat ini. Server OpenVPN harus diperiksa.',
      'tls_alert_bad_certificate':
          'Server menolak sertifikat perangkat ini. Buat ulang perangkat sebelum mencoba lagi.',
      'tls_alert_unsupported_certificate':
          'Server tidak mendukung jenis sertifikat aman yang digunakan Android.',
      'tls_client_certificate_required':
          'Server memerlukan sertifikat klien, tetapi OpenVPN Core tidak dapat menyediakannya.',
      'tls_alert_misc':
          'Server mengembalikan peringatan TLS di luar kategori sertifikat dan versi.',
      'tls_signature_algorithm_rejected':
          'Server menolak algoritme ECDSA P-256 dari kunci Android Keystore.',
      'tls_handshake_rejected':
          'Server menghentikan negosiasi TLS sebelum koneksi.',
      'tls_version_rejected':
          'Klien dan server tidak menemukan versi TLS yang sama.',
      'tls_certificate_expired':
          'Sertifikat yang ditampilkan saat koneksi telah kedaluwarsa.',
      'tls_certificate_revoked':
          'Sertifikat yang ditampilkan saat koneksi telah dicabut.',
      'transport_failed':
          'Server OpenVPN tidak merespons di jaringan saat ini. Coba lagi sebentar lagi.',
      'tun_configuration_rejected':
          'Android menolak konfigurasi jaringan yang diminta oleh OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core menolak rencana jaringan sebelum membuat antarmuka Android.',
      'tun_interface_create_failed':
          'OpenVPN Core tidak dapat memperoleh antarmuka TUN dari Android VpnService.',
      'tun_interface_disabled':
          'Android atau OpenVPN Core menonaktifkan antarmuka TUN selama koneksi.',
      'tun_halted':
          'OpenVPN Core menerima permintaan untuk menghentikan antarmuka TUN.',
      'tun_already_established':
          'OpenVPN meminta antarmuka kedua dalam koneksi yang sama. Tunnel dihentikan demi keamanan.',
      'tun_addresses_missing':
          'Server tidak memberikan alamat tunnel yang dapat digunakan.',
      'tun_routes_missing':
          'Server tidak memberikan rute tunnel yang dapat digunakan.',
      'tun_dns_missing':
          'Server tidak memberikan server DNS yang dapat digunakan.',
      'tun_permission_revoked': 'Android mencabut izin VPN selama koneksi.',
      'tun_establish_returned_null':
          'Android tidak membuat antarmuka, biasanya karena VPN lain masih aktif.',
      'openvpn_service_start_failed':
          'Android tidak dapat memulai layanan latar depan OpenVPN.',
      'openvpn_operation_timeout':
          'Panggilan JNI ke OpenVPN Core melampaui durasi maksimumnya.',
      'openvpn_start_failed':
          'Layanan Android siap, tetapi OpenVPN Core tidak menerima pemulaan profil.',
      'openvpn_connection_failed':
          'OpenVPN Core berhenti sebelum memancarkan peristiwa CONNECTED.',
      'openvpn_core_status_error':
          'Loop OpenVPN asli berakhir dengan kesalahan dan tanpa peristiwa terminal yang lebih spesifik.',
      'openvpn_stopped_before_connected':
          'Loop OpenVPN asli berhenti sebelum CONNECTED, tanpa kesalahan Core yang eksplisit.',
      'openvpn_auth_failed': 'Server OpenVPN menolak autentikasi profil.',
      'openvpn_client_setup_failed':
          'OpenVPN Core tidak dapat menginisialisasi klien sebelum koneksi jaringan.',
      'openvpn_client_halted':
          'OpenVPN Core menerima penghentian klien terminal.',
      'openvpn_client_restart':
          'OpenVPN Core meminta dimulainya ulang sesi transportasinya.',
      'openvpn_inactive_timeout':
          'OpenVPN Core menutup sesi setelah batas waktu tidak aktif.',
      'openvpn_session_expired':
          'Server melaporkan bahwa sesi OpenVPN telah kedaluwarsa.',
      'openvpn_credentials_required':
          'Server atau proksi meminta kredensial interaktif yang bukan bagian dari profil sertifikat ini.',
      'openvpn_proxy_failed':
          'OpenVPN Core melaporkan kegagalan proksi atau relai yang dikonfigurasi.',
      'openvpn_compression_failed':
          'OpenVPN Core menolak mode kompresi yang diumumkan oleh profil atau server.',
      'openvpn_ntlm_crypto_unavailable':
          'Profil meminta enkripsi NTLM yang tidak tersedia dalam versi ini.',
      'openvpn_feature_unsupported':
          'Profil atau server memerlukan fitur yang tidak tersedia di klien Android ini.',
      'network_unavailable': 'Tidak ada jaringan fisik yang dapat digunakan.',
      'network_lost': 'Tunnel dihentikan setelah jaringan terputus.',
      'certificate_validation_failed':
          'Identitas server OpenVPN tidak dapat diverifikasi.',
      'openvpn_certificate_expired':
          'Perbarui profil OpenVPN sebelum terhubung kembali.',
      'tunnel_active_for_another_account':
          'Tunnel milik akun lain harus dihentikan sebelum koneksi ini.',
      'tunnel_already_active':
          'Android melaporkan bahwa sesi VPN sebelumnya masih menggunakan antarmuka.',
      'tunnel_stop_timeout':
          'Mesin $protocol tidak mengonfirmasi pelepasan antarmuka VPN dalam batas waktu.',
      'tunnel_disconnected':
          'Mesin asli melaporkan bahwa tunnel berakhir secara tak terduga setelah dimulai.',
      'native_bridge_unavailable':
          'Aplikasi tidak dapat mengakses layanan VPN Android. Tutup dan buka kembali aplikasi, lalu coba lagi.',
      'native_operation_failed':
          'Kesalahan aplikasi mengganggu operasi VPN. Coba lagi. Jika masalah berlanjut, jalankan diagnostik.',
      'invalid_arguments':
          'Informasi yang diperlukan untuk operasi VPN ini tidak lengkap. Coba lagi. Jika masalah berlanjut, jalankan diagnostik.',
      'invalid_account_id':
          'Operasi asli tidak terkait dengan pengenal akun yang valid.',
      'invalid_device_id':
          'Pengenal perangkat yang dikirim ke mesin asli tidak ada atau tidak valid.',
      'storage_key_not_allowed':
          'Bridge Android memblokir kunci di luar daftar penyimpanan yang diizinkan.',
      'secure_storage_read_failed':
          'Android Keystore tidak dapat mendekripsi data lokal akun ini.',
      'secure_storage_write_failed':
          'Android Keystore tidak dapat mengenkripsi atau menyimpan data lokal.',
      'key_generation_failed':
          'Android tidak dapat membuat atau membaca kunci WireGuard di penyimpanan aman.',
      'csr_generation_failed':
          'Android Keystore tidak dapat membuat atau menandatangani CSR OpenVPN P-256.',
      'other':
          'Cabang asli yang tidak terdokumentasi gagal. Kirim kode diagnostik yang ditampilkan di bawah kepada dukungan.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Permintaan izin sudah terbuka';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Permintaan izin VPN Android sudah ditampilkan. Selesaikan permintaan tersebut sebelum mencoba lagi.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Permintaan izin VPN terputus';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Layar izin VPN tertutup sebelum aplikasi menerima respons.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Koneksi OpenVPN belum dikonfirmasi';

  @override
  String get notice_openvpnProofMissing_message =>
      'Koneksi OpenVPN tidak dapat dikonfirmasi. Koneksi dihentikan demi keamanan. Coba lagi.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN dicabut';

  @override
  String get openvpnCleanup_working =>
      'Menghentikan dan menghapus profil OpenVPN yang dicabut…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Penghentian OpenVPN belum dikonfirmasi. Coba lagi sebelum membuat profil baru.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Profil OpenVPN yang dicabut tidak dapat dihapus sepenuhnya. Coba hapus lagi.';

  @override
  String get openvpnCleanup_complete =>
      'Profil OpenVPN yang dicabut telah dihapus. Ketuk Hubungkan untuk membuat yang baru.';

  @override
  String get network_title => 'Konfigurasi jaringan';

  @override
  String get network_ipv4Fallback =>
      'IPv6 untuk sementara tidak tersedia. Persiapan dilanjutkan dengan IPv4.';

  @override
  String get network_rejectedTitle => 'Konfigurasi jaringan ditolak';

  @override
  String get network_rejectedMessage =>
      'Konfigurasi tunnel tidak lengkap atau tidak cocok dengan alamat yang diizinkan. Coba lagi dari aplikasi.';

  @override
  String get network_unreadableTitle => 'Konfigurasi lokal tidak dapat dibaca';

  @override
  String get network_unreadableMessage =>
      'Konfigurasi jaringan OpenVPN yang tersimpan tidak dapat digunakan. Hubungkan kembali dari aplikasi untuk memperbaruinya.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Perlindungan jaringan';

  @override
  String get protection_subtitle =>
      'Blokir akses internet langsung jika VPN terputus.';

  @override
  String get protection_active => 'Perlindungan sistem aktif';

  @override
  String get protection_alwaysOnOnly =>
      'VPN selalu aktif diaktifkan; aktifkan pemblokiran di luar VPN';

  @override
  String get protection_inactive => 'Perlindungan sistem tidak aktif';

  @override
  String get protection_unknown => 'Periksa perlindungan sistem';

  @override
  String get protection_openSettings => 'Buka pengaturan Android';

  @override
  String get protection_dialogTitle => 'Siapkan perlindungan jaringan';

  @override
  String get protection_dialogMessage =>
      'Android mengelola VPN selalu aktif dan pemblokiran koneksi di luar VPN. Pastikan FuzeVPN dipilih dan aktifkan pemblokiran di pengaturan sistem.';

  @override
  String get protection_dialogOpen => 'Buka pengaturan';

  @override
  String get session_systemProtectionNote =>
      'Jika Android masih memblokir lalu lintas di luar VPN, buka pengaturan sistem untuk memeriksa atau mengubah perlindungan ini.';

  @override
  String get diagnostics_title => 'Diagnostik';

  @override
  String get diagnostics_settingsTitle => 'Diagnostik aplikasi';

  @override
  String get diagnostics_automaticTitle => 'Kirim kesalahan penting';

  @override
  String get diagnostics_automaticDescription =>
      'Bagikan laporan teknis singkat saat terjadi kesalahan penting.';

  @override
  String get diagnostics_privacy =>
      'Laporan yang dikirim ditautkan ke akun yang digunakan untuk masuk dan disimpan selama 30 hari. Laporan tidak berisi riwayat penelusuran, kata sandi, atau kunci VPN.';

  @override
  String get diagnostics_manualOpen => 'Jalankan diagnostik';

  @override
  String get diagnostics_localDescription =>
      'Buat laporan tentang status aplikasi dan VPN. Koneksi Anda tetap tidak berubah.';

  @override
  String get diagnostics_sendReport => 'Kirim laporan';

  @override
  String get diagnostics_sendHint =>
      'Biarkan kotak ini tidak dicentang agar laporan tetap tersimpan di perangkat ini.';

  @override
  String get diagnostics_signedOut =>
      'Masuk ke akun Anda untuk mengirim laporan.';

  @override
  String get diagnostics_localLifetime =>
      'Simpan laporan ini di ponsel agar tetap ada setelah aplikasi ditutup.';

  @override
  String get diagnostics_run => 'Jalankan diagnostik';

  @override
  String get diagnostics_rerun => 'Jalankan diagnostik lagi';

  @override
  String get diagnostics_running => 'Memeriksa…';

  @override
  String get diagnostics_sending => 'Mengirim laporan…';

  @override
  String get diagnostics_prepared => 'Laporan siap di perangkat ini';

  @override
  String get diagnostics_queued => 'Laporan menunggu untuk dikirim';

  @override
  String get diagnostics_sent => 'Laporan diterima';

  @override
  String get diagnostics_failed =>
      'Pengiriman gagal. Laporan lokal Anda masih tersedia.';

  @override
  String get diagnostics_preparationFailed =>
      'Laporan diagnostik tidak dapat disiapkan. Coba lagi.';

  @override
  String get diagnostics_authenticationRequired =>
      'Masuk lagi untuk mengirim laporan.';

  @override
  String get diagnostics_retry => 'Coba kirim lagi';

  @override
  String get diagnostics_export => 'Simpan laporan';

  @override
  String get diagnostics_exportFailed =>
      'Ekspor gagal. Coba lagi dari laporan lokal.';

  @override
  String get diagnostics_preferenceFailed =>
      'Pengaturan ini tidak dapat disimpan. Coba lagi.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referensi: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Diterima pada $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Disimpan hingga $date';
  }

  @override
  String get diagnostics_duplicate => 'Laporan ini sudah pernah diterima.';

  @override
  String get diagnostics_preview => 'Pratinjau laporan';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peristiwa teknis dilampirkan',
      one: '1 peristiwa teknis dilampirkan',
      zero: 'Tidak ada peristiwa teknis yang dilampirkan',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Detail teknis';

  @override
  String get diagnostics_empty =>
      'Belum ada laporan diagnostik yang disiapkan.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Status tunnel',
      'handshake': 'Konfirmasi koneksi',
      'certificate': 'Sertifikat VPN',
      'kill_switch': 'Perlindungan Android',
      'connectivity': 'Jaringan yang tersedia',
      'api_reachability': 'Akses layanan',
      'secure_storage': 'Penyimpanan aman',
      'other': 'Pemeriksaan lokal',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Diperiksa',
      'failed': 'Memerlukan perhatian',
      'skipped': 'Tidak diuji — tidak ada pemeriksaan aktif',
      'unknown': 'Informasi tidak tersedia',
      'other': 'Informasi tidak tersedia',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Selamat datang di FuzeVPN';

  @override
  String get connection_changeLocation => 'Ubah lokasi';

  @override
  String get connection_details => 'Detail koneksi';

  @override
  String get locations_searchLabel => 'Cari kota atau negara';

  @override
  String get locations_clearSearch => 'Hapus pencarian';

  @override
  String get locations_filterAll => 'Semua';

  @override
  String get locations_filterFavorites => 'Favorit';

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
  String get locations_noResults => 'Tidak ada lokasi yang ditemukan';

  @override
  String get locations_noResultsHint => 'Coba kota atau negara lain.';

  @override
  String get locations_noFavorites => 'Favorit Anda, dekat di tangan';

  @override
  String get locations_noFavoritesHint =>
      'Ketuk bintang di samping lokasi untuk menyimpannya di sini.';

  @override
  String get locations_showAll => 'Lihat semua lokasi';

  @override
  String locations_addFavorite(String name) {
    return 'Tambahkan $name ke favorit';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Hapus $name dari favorit';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Favorit tidak dapat disimpan. Coba lagi.';

  @override
  String get locations_emptyTitle => 'Tidak ada lokasi yang tersedia';

  @override
  String get locations_emptyHint => 'Segarkan daftar untuk mencoba lagi.';

  @override
  String get devices_manage => 'Kelola perangkat saya';

  @override
  String get settings_personalization => 'Jadikan milik Anda';

  @override
  String get settings_safety => 'Perlindungan';

  @override
  String get settings_help => 'Perlu bantuan?';

  @override
  String get settings_about => 'Tentang FuzeVPN';

  @override
  String get diagnostics_heading => 'Pahami masalah koneksi';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Tersedia',
      'pending': 'Menyiapkan',
      'revoked': 'Dihapus',
      'expired': 'Kedaluwarsa',
      'other': 'Status tidak tersedia',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preferensi tidak disimpan';

  @override
  String get notice_preferenceSave_message =>
      'Pilihan Anda diterapkan untuk saat ini, tetapi tidak dapat disimpan. Coba lagi agar pilihan tetap tersimpan setelah aplikasi ditutup.';

  @override
  String get connection_androidDisconnectHint =>
      'Jika Android tetap mempertahankan VPN aktif, matikan VPN selalu aktif di pengaturan yang terbuka.';

  @override
  String get protection_learnMore => 'Pelajari perlindungan Android';

  @override
  String get protection_guideWhy =>
      'Perlindungan ini mencegah aplikasi menggunakan internet secara langsung jika VPN terputus. Perlindungan ini dikonfigurasi di Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN selalu aktif';

  @override
  String get protection_guideAlwaysOn =>
      'Android menjaga layanan VPN tetap berjalan dan dapat memulainya kembali setelah ponsel dimulai ulang.';

  @override
  String get protection_guideBlockTitle => 'Blokir koneksi tanpa VPN';

  @override
  String get protection_guideBlock =>
      'Pengaturan ini mencegah lalu lintas melewati VPN, termasuk saat koneksi terputus.';

  @override
  String get protection_guideWarning =>
      'Dengan pemblokiran ini diaktifkan, akses internet tetap nonaktif hingga VPN terhubung.';

  @override
  String get protection_guideStepsTitle => 'Aktifkan perlindungan';

  @override
  String get protection_guideStep1 =>
      'Buka pengaturan VPN Android dengan tombol di bawah.';

  @override
  String get protection_guideStep2 =>
      'Buka opsi menggunakan ikon roda gigi di samping FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Aktifkan VPN selalu aktif, lalu Blokir koneksi tanpa VPN, jika opsi tersebut tersedia.';

  @override
  String get protection_guideManufacturers =>
      'Nama dapat berbeda menurut ponsel. Jika perlu, cari VPN di Pengaturan, biasanya di bagian Jaringan & internet.';

  @override
  String get protection_guideDisableTitle => 'Matikan perlindungan ini';

  @override
  String get protection_guideDisable =>
      'Di pengaturan yang sama, matikan pemblokiran tanpa VPN untuk mengizinkan akses internet tanpa VPN. Matikan juga VPN selalu aktif jika Anda tidak ingin Android memulainya kembali.';

  @override
  String get protection_guideManual =>
      'Anda memilih pengaturan ini di Android. FuzeVPN tidak mengubahnya untuk Anda.';

  @override
  String get locations_changeTitle => 'Ubah lokasi?';

  @override
  String locations_changeActive(String name) {
    return 'VPN akan terputus, lalu mencoba terhubung ke $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN akan mencoba terhubung ke $name.';
  }

  @override
  String get locations_confirmChange => 'Ubah dan hubungkan';

  @override
  String get locations_changeBusy =>
      'Perubahan sedang berlangsung. Tunggu sebelum memilih lokasi lain.';

  @override
  String get locations_automaticSelection => 'Pilihan otomatis';

  @override
  String get locations_cities => 'Kota';

  @override
  String get locations_servers => 'Server';

  @override
  String locations_viewCities(String name) {
    return 'Lihat kota di $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Lihat server di $name';
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
      other: '$count kota',
      one: '$count kota',
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
  String get locations_allCountries => 'Semua negara';

  @override
  String get locations_backToCountries => 'Kembali ke negara';

  @override
  String locations_backToCities(String name) {
    return 'Kembali ke kota di $name';
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
  String get locations_noCompatibleServer =>
      'Tidak ada server yang kompatibel.';

  @override
  String get externalLink_failed =>
      'Tautan ini tidak dapat dibuka. Anda dapat menyalinnya dan membukanya di peramban.';

  @override
  String get externalLink_copy => 'Salin tautan';

  @override
  String get externalLink_copied => 'Tautan disalin';

  @override
  String get externalLink_copyFailed =>
      'Tautan tidak dapat disalin. Pilih alamat di bawah.';

  @override
  String get settings_deleteAccount => 'Hapus akun saya';

  @override
  String get settings_deleteAccountDetail =>
      'Lihat cara mengajukan penghapusan akun';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Pilih langganan VPN Anda.';

  @override
  String get billing_subscribe => 'Berlangganan';

  @override
  String get billing_choosePlan => 'Pilih paket untuk melanjutkan.';

  @override
  String get billing_monthly => 'Bulanan';

  @override
  String get billing_yearly => 'Tahunan';

  @override
  String get billing_continue => 'Lanjutkan dengan Google Play';

  @override
  String get billing_restore => 'Pulihkan pembelian';

  @override
  String get billing_manage => 'Kelola langganan';

  @override
  String get billing_deleteAccountWarning =>
      'Jika Anda memiliki langganan Google Play, menghapus akun FuzeVPN Anda tidak membatalkan perpanjangannya. Kelola atau batalkan perpanjangan secara terpisah di Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Lanjutkan ke permintaan penghapusan akun';

  @override
  String get billing_refresh => 'Perbarui akses';

  @override
  String get billing_loadingPlans => 'Memuat paket…';

  @override
  String get billing_unavailable =>
      'Belum ada paket yang tersedia. Coba lagi nanti.';

  @override
  String get billing_comingSoon => 'Langganan segera tersedia.';

  @override
  String get billing_priceDisclosure =>
      'Harga disediakan oleh Google Play. Jumlah akhir dan pajak yang berlaku dikonfirmasi sebelum Anda mengonfirmasi.';

  @override
  String get billing_renewalMonthly =>
      'Diperpanjang otomatis setiap bulan kecuali dibatalkan. Anda dapat membatalkan kapan saja di langganan Google Play.';

  @override
  String get billing_renewalYearly =>
      'Diperpanjang otomatis setiap tahun kecuali dibatalkan. Anda dapat membatalkan kapan saja di langganan Google Play.';

  @override
  String get billing_active => 'Akses Premium Anda aktif';

  @override
  String billing_accessUntil(String date) {
    return 'Akses hingga $date.';
  }

  @override
  String get billing_webManaged =>
      'Langganan Anda dikelola di situs web FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Langganan Anda dikelola melalui Google Play.';

  @override
  String get billing_inactive => 'Tidak ada langganan aktif.';

  @override
  String get billing_checkingAccess => 'Memeriksa akses Anda…';

  @override
  String get billing_restoring => 'Memulihkan pembelian…';

  @override
  String get billing_pending =>
      'Pembayaran tertunda. Akses akan diaktifkan setelah konfirmasi.';

  @override
  String get billing_cancelled =>
      'Pembelian dibatalkan. Tidak ada langganan baru yang diaktifkan.';

  @override
  String get billing_verifying => 'Memverifikasi pembelian…';

  @override
  String get billing_success =>
      'Langganan diaktifkan. Akses Premium Anda siap.';

  @override
  String get billing_restored => 'Pembelian Anda telah dipulihkan.';

  @override
  String get billing_restoreEmpty =>
      'Tidak ada pembelian untuk dipulihkan pada akun Google Play ini.';

  @override
  String get billing_catalogError => 'Tidak dapat memuat paket. Coba lagi.';

  @override
  String get billing_purchaseError =>
      'Tidak dapat memulai pembelian. Coba lagi.';

  @override
  String get billing_verificationError =>
      'Verifikasi pembelian sementara tidak tersedia. Pulihkan pembelian untuk mencoba lagi.';

  @override
  String get billing_restoreError =>
      'Tidak dapat memulihkan pembelian. Coba lagi.';

  @override
  String get billing_managementError =>
      'Tidak dapat membuka pengelolaan langganan. Coba lagi.';

  @override
  String get billing_storeUnavailable =>
      'Google Play tidak tersedia di perangkat ini.';

  @override
  String get welcome_title => 'VPN Anda, kini lebih mudah.';

  @override
  String get welcome_description =>
      'Lindungi koneksi Anda. Tetap kendalikan privasi Anda.';

  @override
  String get welcome_start => 'Mulai';

  @override
  String get welcome_alreadyPurchased => 'Sudah membeli?';

  @override
  String get welcome_noAccountRequired =>
      'Tidak perlu membuat akun untuk memulai.';

  @override
  String get guest_accountTitle => 'Akun belum ditautkan';

  @override
  String get guest_accountDescription =>
      'Pulihkan pembelian dengan akun Google Play yang sama untuk menggunakan langganan di perangkat lain.';

  @override
  String get guest_existingSubscriberSignIn => 'Sudah berlangganan? Masuk';

  @override
  String get guest_claimTitle => 'Gunakan FuzeVPN di mana saja';

  @override
  String get guest_claimDescription =>
      'Buat akun untuk mengakses langganan di perangkat Anda lainnya. Langkah ini opsional.';

  @override
  String get guest_skip => 'Nanti saja';

  @override
  String get guest_activationTitle => 'Fuze Premium aktif';

  @override
  String get guest_activationDescription =>
      'Langganan Anda siap. Gunakan VPN dan buat akun kapan saja.';

  @override
  String get guest_useVpn => 'Gunakan VPN saya';

  @override
  String get guest_loginRequired =>
      'Pembelian ini sudah ditautkan ke akun FuzeVPN. Masuk ke akun tersebut untuk mengakses langganan Anda.';

  @override
  String get guest_signOutWarning =>
      'Anda dapat memulihkan langganan dengan memulihkan pembelian menggunakan akun Google Play yang sama.';

  @override
  String get guest_profileUnavailable =>
      'Akun Anda sudah ditautkan. Masuk untuk melihat dan mengelola informasi Anda.';

  @override
  String get billing_acceptance =>
      'Dengan melanjutkan, Anda menyetujui Ketentuan Penggunaan dan Kebijakan Privasi.';

  @override
  String get guest_verifyEmailReminder =>
      'Konfirmasikan alamat email untuk melindungi akun Anda. Anda dapat terus menggunakan VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Layanan untuk sementara tidak tersedia. Coba lagi sebentar.';

  @override
  String get guest_restoreError =>
      'Pembelian Anda tidak dapat dipulihkan. Coba lagi dengan akun Google Play yang digunakan untuk membeli.';

  @override
  String get guest_claimSuccess =>
      'Akun Anda telah dibuat. Langganan dan akses VPN Anda tetap terjaga.';

  @override
  String get guest_emailExists =>
      'Email ini sudah digunakan. Pilih alamat lain atau masuk ke akun yang sudah ada. Pembelian Anda tetap tersedia melalui Google Play.';

  @override
  String get guest_claimError =>
      'Akun Anda tidak dapat dibuat. Anda dapat terus menggunakan VPN dan mencoba lagi nanti.';

  @override
  String get guest_secureStorageError =>
      'Sesi Anda tidak dapat diamankan di perangkat ini. Coba lagi.';

  @override
  String get guest_premiumRequired =>
      'Pilih langganan untuk mengaktifkan VPN Anda.';

  @override
  String get welcome_viewPlans => 'Lihat paket';

  @override
  String get google_continue => 'Lanjutkan dengan Google';

  @override
  String get google_or => 'atau';

  @override
  String get google_title => 'Akun FuzeVPN Anda';

  @override
  String get google_settingUp => 'Selesaikan akun Anda';

  @override
  String get google_country => 'Negara tempat tinggal';

  @override
  String get google_profileDescription =>
      'Pilih negara Anda dan tinjau kedua dokumen untuk membuat akun FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Tautkan akun tamu Anda ke Google. Langganan dan perangkat tetap terkait dengan akun ini.';

  @override
  String get google_linkTitle => 'Tautkan Google ke FuzeVPN';

  @override
  String get google_linkDescription =>
      'Konfirmasikan akses ke akun FuzeVPN Anda yang ada. Kata sandi Google tidak diminta.';

  @override
  String get google_password => 'Kata sandi FuzeVPN';

  @override
  String get google_linkAccount => 'Konfirmasi penautan';

  @override
  String get google_requestEmail => 'Kirim email konfirmasi';

  @override
  String get google_emailInstructions =>
      'Buka email FuzeVPN dan masukkan kode konfirmasi.';

  @override
  String get google_emailCode => 'Kode konfirmasi email';

  @override
  String get google_confirmEmail => 'Konfirmasi kode';

  @override
  String get google_restart => 'Pilih akun Google lain';

  @override
  String get google_resume => 'Periksa percobaan ini';

  @override
  String get google_unavailable =>
      'Login Google tidak tersedia. Anda dapat menggunakan email dan kata sandi.';

  @override
  String get google_expired =>
      'Percobaan ini kedaluwarsa. Batalkan lalu mulai lagi.';

  @override
  String get google_conflict =>
      'Akun Google ini sudah tertaut ke akun lain. Akun dan langganan Anda saat ini tetap disimpan.';

  @override
  String get google_error =>
      'Login Google gagal. Coba lagi; akses Anda saat ini tetap disimpan.';

  @override
  String get google_uncertain =>
      'Hasil belum dapat dikonfirmasi. Periksa percobaan ini atau batalkan sebelum memulai lagi.';

  @override
  String get google_cancelFailed =>
      'Pembatalan belum dapat dikonfirmasi. Coba batalkan lagi sebelum meninggalkan layar ini.';

  @override
  String get google_cancelled => 'Login Google dibatalkan.';

  @override
  String get google_selecting => 'Pilih akun Google Anda…';

  @override
  String get google_verifying => 'Memeriksa akun Anda…';

  @override
  String get google_emailUnavailable =>
      'Email konfirmasi tidak dapat dikirim. Coba lagi nanti.';

  @override
  String get google_emailSent =>
      'Email konfirmasi terkirim. Periksa kotak masuk Anda.';

  @override
  String get google_rateLimited => 'Harap tunggu sebelum mencoba lagi.';

  @override
  String get google_invalidPassword =>
      'Kata sandi FuzeVPN salah. Akun Anda saat ini tetap disimpan.';

  @override
  String get google_invalidCode =>
      'Kode konfirmasi tidak valid atau kedaluwarsa.';

  @override
  String get google_accountChanged =>
      'Sesi berubah. Batalkan percobaan ini sebelum memulai lagi.';

  @override
  String get google_invalidResponse =>
      'Respons tidak dapat divalidasi. Akses Anda saat ini tetap disimpan.';

  @override
  String get google_invalidRegistration =>
      'Periksa negara dan kedua persetujuan.';

  @override
  String get google_consentRequired =>
      'Pilih negara Anda dan setujui kedua dokumen untuk melanjutkan.';

  @override
  String get google_challengeRequired =>
      'Pemeriksaan keamanan tambahan diperlukan. Akses Anda saat ini tetap disimpan.';

  @override
  String get google_challengeUnavailable =>
      'Pemeriksaan keamanan tidak tersedia. Coba lagi nanti.';

  @override
  String get billing_trialTitle => 'Coba Fuze Premium gratis';

  @override
  String get billing_trialSubtitle => 'Lindungi koneksi Anda mulai hari ini.';

  @override
  String get billing_trialWeeks => 'Uji coba gratis 2 minggu';

  @override
  String billing_trialDays(String days) {
    return 'Uji coba gratis $days hari';
  }

  @override
  String get billing_trialStart => 'Mulai uji coba gratis saya';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Jika dimulai hari ini, tagihan pertama diperkirakan pada $date.';
  }

  @override
  String get billing_trialTerms =>
      'Diperpanjang otomatis dengan harga yang tertera. Untuk menghindari tagihan, batalkan di Google Play sebelum uji coba berakhir.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Lalu $price per bulan';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Lalu $price per tahun';
  }

  @override
  String get billing_choosePeriod => 'Pilih paket Anda';

  @override
  String get billing_selectionHint => 'Pilih paket untuk melanjutkan.';

  @override
  String get billing_benefitConnection => 'Koneksi terenkripsi';

  @override
  String get billing_benefitPrivacy => 'Privasi online';

  @override
  String get billing_benefitNoAccount => 'Tidak wajib mendaftar';

  @override
  String get billing_cancellation => 'Pembatalan di Google Play';

  @override
  String get billing_premiumTitle => 'Koneksi Anda lebih terlindungi.';

  @override
  String get billing_premiumSubtitle =>
      'Lindungi koneksi sesuai kebutuhan Anda.';

  @override
  String get billing_priceMonthly => 'per bulan';

  @override
  String get billing_priceYearly => 'per tahun';

  @override
  String get billing_trialToday => 'Tidak perlu membayar hari ini';

  @override
  String get billing_trialConfirmation =>
      'Google Play mengonfirmasi tanggal, jumlah akhir, dan pajak yang berlaku sebelum Anda mengonfirmasi.';

  @override
  String get billing_offerChanged =>
      'Ketentuan penawaran ini berubah. Muat ulang paket dan pilih kembali.';

  @override
  String get status_waitingNetwork => 'Menunggu jaringan';

  @override
  String get status_waitingNetworkDetail =>
      'Tidak ada jaringan tersedia. VPN akan memeriksa koneksi saat jaringan kembali.';

  @override
  String get locations_favoriteLoadFailed =>
      'Favorit tidak dapat dimuat. Coba lagi.';

  @override
  String get locations_favoritesLoading => 'Memuat favorit…';
}
