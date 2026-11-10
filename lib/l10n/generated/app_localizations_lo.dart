// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lao (`lo`).
class AppLocalizationsLo extends AppLocalizations {
  AppLocalizationsLo([String locale = 'lo']) : super(locale);

  @override
  String get vpnDisclosure_title => 'ປົກປ້ອງການເຊື່ອມຕໍ່ຂອງທ່ານ';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ໃຊ້ບໍລິການ VPN ຂອງ Android (VpnService) ເພື່ອສ້າງອຸໂມງທີ່ເຂົ້າລະຫັດລະຫວ່າງອຸປະກອນນີ້ ແລະ ເຊີບເວີຂອງ FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'ໃນຂະນະທີ່ VPN ເປີດໃຊ້ງານຢູ່, ທຣາຟິກອິນເຕີເນັດຂອງແອັບຕ່າງໆຂອງທ່ານ, ທີ່ຢູ່ປາຍທາງ ແລະ ຄຳຂໍ DNS ຈະຜ່ານອຸໂມງນີ້ ເພື່ອກຳນົດເສັ້ນທາງການເຊື່ອມຕໍ່ຂອງທ່ານ ເຖິງແມ່ນວ່າ FuzeVPN ຈະຢູ່ເບື້ອງຫຼັງກໍຕາມ.';

  @override
  String get vpnDisclosure_statusBody =>
      'ແອັບໃຊ້ສະຖານະການເຊື່ອມຕໍ່, ໄລຍະເວລາ ແລະ ປະລິມານຂໍ້ມູນທີ່ຖ່າຍໂອນ ເພື່ອສະແດງການເຊື່ອມຕໍ່ VPN ຂອງທ່ານ. ທ່ານສາມາດຢຸດໄດ້ທຸກເວລາ.';

  @override
  String get vpnDisclosure_privacy => 'ຄວາມເປັນສ່ວນຕົວ';

  @override
  String get vpnDisclosure_accept => 'ຍອມຮັບ ແລະ ສືບຕໍ່';

  @override
  String get vpnDisclosure_decline => 'ບໍ່ຕອນນີ້';

  @override
  String get accountRestoration_title => 'ບັນຊີບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ';

  @override
  String get accountRestoration_message =>
      'ເຊດຊັນຂອງທ່ານຖືກເກັບໄວ້ແລ້ວ. ລອງໃໝ່ເພື່ອກູ້ຄືນບັນຊີຂອງທ່ານ. ທ່ານຍັງສາມາດຈັດການການເຊື່ອມຕໍ່ VPN ທີ່ນີ້ໄດ້.';

  @override
  String get action_retry => 'ລອງໃໝ່';

  @override
  String get session_endingTitle => 'ກຳລັງສິ້ນສຸດເຊດຊັນ';

  @override
  String get session_ending =>
      'ກຳລັງສິ້ນສຸດເຊດຊັນ: ກຳລັງຢຸດ VPN ແລະ ເຮັດຄວາມສະອາດ…';

  @override
  String get session_stopFailed =>
      'ຍັງບໍ່ໄດ້ຢືນຢັນການຢຸດ VPN. ກະລຸນາລອງໃໝ່ກ່ອນເຂົ້າສູ່ລະບົບອີກຄັ້ງ.';

  @override
  String get session_cleanupFailed =>
      'VPN ຢຸດແລ້ວ ແຕ່ຍັງບໍ່ໄດ້ຢືນຢັນການລຶບເຊດຊັນ. ກະລຸນາລອງເຮັດຄວາມສະອາດໃໝ່.';

  @override
  String get session_retryStop => 'ລອງຢຸດໃໝ່';

  @override
  String get session_retryCleanup => 'ລອງເຮັດຄວາມສະອາດໃໝ່';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'ກຳລັງກຽມ FuzeVPN ຢ່າງປອດໄພ…';

  @override
  String get nav_connection => 'ການເຊື່ອມຕໍ່';

  @override
  String get nav_locations => 'ສະຖານທີ່';

  @override
  String get nav_account => 'ບັນຊີ';

  @override
  String get nav_devices => 'ອຸປະກອນ';

  @override
  String get nav_settings => 'ການຕັ້ງຄ່າ';

  @override
  String get action_refresh => 'ໂຫຼດໃໝ່';

  @override
  String get auth_tab_login => 'ເຂົ້າສູ່ລະບົບ';

  @override
  String get auth_tab_register => 'ລົງທະບຽນ';

  @override
  String get auth_stepAccount => 'ບັນຊີ';

  @override
  String get auth_stepIdentity => 'ຂໍ້ມູນຕົວຕົນ';

  @override
  String get auth_stepAddress => 'ທີ່ຢູ່ ແລະ ຂໍ້ຕົກລົງ';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'ຂັ້ນຕອນທີ່ $current ຈາກ $total';
  }

  @override
  String get auth_tagline => 'ເຮັດໃຫ້ VPN ຂອງທ່ານງ່າຍດາຍ.';

  @override
  String get auth_keysLocal => 'ກະແຈ VPN ສ່ວນຕົວຂອງທ່ານຈະຢູ່ໃນອຸປະກອນນີ້.';

  @override
  String get form_email => 'ທີ່ຢູ່ອີເມວ';

  @override
  String get form_password => 'ລະຫັດຜ່ານ';

  @override
  String get form_showPassword => 'ສະແດງລະຫັດຜ່ານ';

  @override
  String get form_hidePassword => 'ເຊື່ອງລະຫັດຜ່ານ';

  @override
  String get form_passwordMin =>
      '8–72 ໄບຕ໌ UTF-8. ບາງຕົວອັກສອນໃຊ້ຫຼາຍກວ່າໜຶ່ງໄບຕ໌.';

  @override
  String get form_firstName => 'ຊື່';

  @override
  String get form_lastName => 'ນາມສະກຸນ';

  @override
  String get form_phone => 'ເບີໂທລະສັບ (+33612345678)';

  @override
  String get form_address => 'ທີ່ຢູ່';

  @override
  String get form_address2 => 'ທີ່ຢູ່ແຖວທີ 2 (ບໍ່ບັງຄັບ)';

  @override
  String get form_postalCode => 'ລະຫັດໄປສະນີ';

  @override
  String get form_city => 'ເມືອງ';

  @override
  String get form_country => 'ລະຫັດປະເທດ (ເຊັ່ນ FR)';

  @override
  String get action_login => 'ເຂົ້າສູ່ລະບົບ';

  @override
  String get action_createAccount => 'ສ້າງບັນຊີ';

  @override
  String get action_createMyAccount => 'ສ້າງບັນຊີຂອງຂ້ອຍ';

  @override
  String get action_next => 'ສືບຕໍ່';

  @override
  String get action_previous => 'ກັບຄືນ';

  @override
  String get action_forgotPassword => 'ລືມລະຫັດຜ່ານ?';

  @override
  String get auth_noAccount => 'ຍັງບໍ່ມີບັນຊີບໍ?';

  @override
  String get auth_requiredInformation => 'ສ້າງບັນຊີຂອງທ່ານໃນສາມຂັ້ນຕອນ.';

  @override
  String get auth_termsPrefix => 'ຂ້ອຍຍອມຮັບ ';

  @override
  String get auth_termsLink => 'ເງື່ອນໄຂການໃຊ້ງານ';

  @override
  String get auth_privacyPrefix => 'ຂ້ອຍຍອມຮັບ ';

  @override
  String get auth_privacyLink => 'ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ';

  @override
  String get auth_consentRequired =>
      'ຕ້ອງໄດ້ຮັບການຍິນຍອມຂອງທ່ານເພື່ອສ້າງບັນຊີ.';

  @override
  String get validation_required => 'ຈຳເປັນຕ້ອງຕື່ມຊ່ອງນີ້.';

  @override
  String get validation_email => 'ກະລຸນາປ້ອນທີ່ຢູ່ອີເມວທີ່ຖືກຕ້ອງ.';

  @override
  String get validation_password =>
      'ລະຫັດຜ່ານສັ້ນເກີນໄປ: ຢ່າງໜ້ອຍ 8 ໄບຕ໌ UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'ລະຫັດຜ່ານຍາວເກີນໄປ: ສູງສຸດ 72 ໄບຕ໌ UTF-8.';

  @override
  String get validation_phone => 'ກະລຸນາໃຊ້ຮູບແບບສາກົນ, ເຊັ່ນ +33612345678.';

  @override
  String get validation_country => 'ກະລຸນາໃຊ້ລະຫັດປະເທດ 2 ຕົວອັກສອນ ເຊັ່ນ FR.';

  @override
  String get passwordReset_title => 'ຕັ້ງລະຫັດຜ່ານໃໝ່';

  @override
  String get passwordReset_description =>
      'ກະລຸນາປ້ອນທີ່ຢູ່ອີເມວຂອງບັນຊີຂອງທ່ານ ເພື່ອຂໍລິ້ງຕັ້ງລະຫັດຜ່ານໃໝ່.';

  @override
  String get passwordReset_send => 'ສົ່ງລິ້ງ';

  @override
  String get connection_title => 'ການເຊື່ອມຕໍ່ຂອງທ່ານ';

  @override
  String get connection_subtitle => 'ເລືອກສະຖານທີ່, ແລ້ວເປີດ VPN ຂອງທ່ານ.';

  @override
  String get connection_prepare => 'ພ້ອມເຊື່ອມຕໍ່ບໍ?';

  @override
  String get connection_advancedOptions => 'ຕົວເລືອກຂັ້ນສູງ';

  @override
  String get connection_location => 'ສະຖານທີ່';

  @override
  String get connection_chooseLocation => 'ເລືອກສະຖານທີ່';

  @override
  String get connection_protocol => 'ໂປຣໂຕຄໍ';

  @override
  String get connection_connect => 'ເຊື່ອມຕໍ່';

  @override
  String get connection_connecting => 'ກຳລັງເຊື່ອມຕໍ່…';

  @override
  String get connection_disconnect => 'ຕັດການເຊື່ອມຕໍ່';

  @override
  String get connection_disconnecting => 'ກຳລັງຕັດການເຊື່ອມຕໍ່';

  @override
  String get connection_locationChange => 'ກຳລັງປ່ຽນສະຖານທີ່…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ບໍ່ພ້ອມໃຊ້ງານ';
  }

  @override
  String get connection_activeLocation => 'ສະຖານທີ່ທີ່ໃຊ້ງານຢູ່';

  @override
  String get connection_duration => 'ໄລຍະເວລາ';

  @override
  String get connection_received => 'ໄດ້ຮັບແລ້ວ';

  @override
  String get connection_sent => 'ສົ່ງແລ້ວ';

  @override
  String get connection_lastHandshake => 'ການແລກປ່ຽນທີ່ປອດໄພຄັ້ງລ່າສຸດ';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ກ່ອນ';
  }

  @override
  String get verification_title => 'ຢືນຢັນທີ່ຢູ່ອີເມວຂອງທ່ານ';

  @override
  String get verification_message =>
      'ກະລຸນາຢືນຢັນທີ່ຢູ່ອີເມວຂອງທ່ານ ເພື່ອໃຊ້ VPN ໃນໂທລະສັບນີ້.';

  @override
  String get verification_resend => 'ສົ່ງອີເມວອີກຄັ້ງ';

  @override
  String get migration_title => 'ການປ່ຽນສະຖານທີ່';

  @override
  String get migration_draining => 'ກຳລັງກຽມການປ່ຽນສະຖານທີ່…';

  @override
  String get migration_activating => 'ກຳລັງເປີດໃຊ້ເຊີບເວີໃໝ່…';

  @override
  String get migration_ready => 'ອັບເດດສະຖານທີ່ແລ້ວ.';

  @override
  String get migration_blocked =>
      'ການປ່ຽນສະຖານທີ່ຕ້ອງໃຫ້ເຊີບເວີແກ້ໄຂ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ ຫຼື ຕິດຕໍ່ຝ່າຍສະໜັບສະໜູນ.';

  @override
  String get migration_progress => 'ຄວາມຄືບໜ້າການປ່ຽນສະຖານທີ່';

  @override
  String migration_retryDelay(Object seconds) {
    return 'ໄລຍະເວລາລະຫວ່າງການກວດສອບ: $seconds ວິນາທີ.';
  }

  @override
  String get migration_resume => 'ສືບຕໍ່ການປ່ຽນສະຖານທີ່';

  @override
  String get status_authorizing => 'ຕ້ອງໄດ້ຮັບອະນຸຍາດ';

  @override
  String get status_authorizingDetail =>
      'ກະລຸນາຍອມຮັບຄຳຂໍຂອງ Android ເພື່ອອະນຸຍາດໃຫ້ VPN ເຮັດວຽກ.';

  @override
  String get status_preparing => 'ກຳລັງກຽມ';

  @override
  String get status_preparingDetail => 'ກຳລັງກຽມການເຊື່ອມຕໍ່ທີ່ປອດໄພຂອງທ່ານ.';

  @override
  String get status_reconnecting => 'ກຳລັງເຊື່ອມຕໍ່ໃໝ່…';

  @override
  String get status_reconnectingDetail =>
      'ການເຊື່ອມຕໍ່ຖືກຂັດຂວາງ. VPN ກຳລັງພະຍາຍາມເຊື່ອມຕໍ່ໃໝ່.';

  @override
  String get status_connecting => 'ກຳລັງເຊື່ອມຕໍ່';

  @override
  String get status_connectingDetail => 'ກຳລັງເຊື່ອມຕໍ່ກັບເຊີບເວີ VPN…';

  @override
  String get status_connected => 'ເຊື່ອມຕໍ່ແລ້ວ';

  @override
  String get status_connectedDetail =>
      'ການເຊື່ອມຕໍ່ VPN ຂອງທ່ານເປີດໃຊ້ງານຢູ່ແລ້ວ.';

  @override
  String get status_disconnecting => 'ກຳລັງຕັດການເຊື່ອມຕໍ່';

  @override
  String get status_disconnectingDetail => 'ການເຊື່ອມຕໍ່ VPN ຂອງທ່ານກຳລັງຢຸດ.';

  @override
  String get status_error => 'ການເຊື່ອມຕໍ່ບໍ່ພ້ອມໃຊ້ງານ';

  @override
  String get status_errorDetail =>
      'ຍັງບໍ່ໄດ້ຢືນຢັນການເຊື່ອມຕໍ່ VPN. ກະລຸນາລອງໃໝ່.';

  @override
  String get status_idle => 'ຕັດການເຊື່ອມຕໍ່ແລ້ວ';

  @override
  String get status_idleDetail =>
      'ເຊື່ອມຕໍ່ VPN ເພື່ອປົກປ້ອງການເຊື່ອມຕໍ່ຂອງທ່ານ.';

  @override
  String get trust_note =>
      'ການປິດແອັບບໍ່ໄດ້ຢຸດ VPN. ເພື່ອຢຸດ, ກະລຸນາໃຊ້ປຸ່ມຕັດການເຊື່ອມຕໍ່.';

  @override
  String get locations_none => 'ຕອນນີ້ບໍ່ມີສະຖານທີ່ທີ່ພ້ອມໃຊ້ງານ.';

  @override
  String get locations_available => 'ເລືອກສະຖານທີ່ຕໍ່ໄປຂອງທ່ານ.';

  @override
  String get locations_selected => 'ສະຖານທີ່ທີ່ເລືອກ';

  @override
  String get locations_select => 'ເລືອກສະຖານທີ່ນີ້';

  @override
  String get locations_lockedTunnel =>
      'ກະລຸນາຕັດການເຊື່ອມຕໍ່ VPN ເພື່ອປ່ຽນສະຖານທີ່.';

  @override
  String get locations_lockedMigration =>
      'ກະລຸນາລໍຖ້າໃຫ້ການປ່ຽນສະຖານທີ່ສຳເລັດກ່ອນ.';

  @override
  String get devices_title => 'ອຸປະກອນຂອງທ່ານ';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ອຸປະກອນ';
  }

  @override
  String get devices_refresh => 'ໂຫຼດອຸປະກອນໃໝ່';

  @override
  String get devices_empty => 'ຍັງບໍ່ມີອຸປະກອນ VPN ທີ່ລົງທະບຽນ.';

  @override
  String get devices_firstConnection =>
      'ໂທລະສັບຂອງທ່ານຈະຖືກເພີ່ມໃນການເຊື່ອມຕໍ່ຄັ້ງທຳອິດ.';

  @override
  String get devices_thisDevice => 'ອຸປະກອນນີ້';

  @override
  String devices_added(Object date) {
    return 'ເພີ່ມເມື່ອ $date';
  }

  @override
  String get devices_unnamed => 'ອຸປະກອນທີ່ບໍ່ມີຊື່';

  @override
  String get action_remove => 'ລຶບອອກ';

  @override
  String get settings_title => 'ການຕັ້ງຄ່າ';

  @override
  String get settings_subtitle =>
      'ການຕັ້ງຄ່າ ແລະ ບັນຊີຂອງທ່ານ, ທັງໝົດຢູ່ບ່ອນດຽວ.';

  @override
  String get settings_appearance => 'ຮູບລັກສະນະ';

  @override
  String get settings_language => 'ພາສາ';

  @override
  String get settings_languageDescription =>
      'ພາສາທີ່ທ່ານເລືອກຈະນຳໃຊ້ກັບການແຈ້ງເຕືອນ VPN ເຊັ່ນກັນ.';

  @override
  String get settings_account => 'ບັນຊີ';

  @override
  String get settings_signOut => 'ອອກຈາກລະບົບ';

  @override
  String get settings_privacy => 'ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ';

  @override
  String get settings_terms => 'ເງື່ອນໄຂການໃຊ້ງານ';

  @override
  String get settings_security => 'ຄວາມປອດໄພ ແລະ ຄວາມໂປ່ງໃສ';

  @override
  String get settings_licenses => 'ໃບອະນຸຍາດຂອງສ່ວນປະກອບ';

  @override
  String get settings_licensesDetail => 'ຊອບແວທີ່ໃຊ້ໃນແອັບ';

  @override
  String settings_licensesLegalese(String url) {
    return 'ໂຄດຕົ້ນສະບັບຂອງແອັບ ແລະ ສ່ວນປະກອບທີ່ມີໃບອະນຸຍາດ MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN ຈະຍັງເປີດຢູ່ເມື່ອທ່ານອອກຈາກແອັບ. ເພື່ອຢຸດ, ກະລຸນາໃຊ້ປຸ່ມຕັດການເຊື່ອມຕໍ່ໃນແຖບການເຊື່ອມຕໍ່.';

  @override
  String get theme_system => 'ຕາມລະບົບ';

  @override
  String get theme_light => 'ສະຫວ່າງ';

  @override
  String get theme_dark => 'ມືດ';

  @override
  String get language_system => 'ພາສາຂອງໂທລະສັບ';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'ລຶບອຸປະກອນນີ້ອອກບໍ?';

  @override
  String get dialog_removeCurrent =>
      'ໂທລະສັບນີ້ຈະຖືກຕັດການເຊື່ອມຕໍ່ຈາກ VPN ແລະ ສູນເສຍການເຂົ້າເຖິງ. ຂໍ້ມູນການເຊື່ອມຕໍ່ VPN ຂອງມັນຈະຖືກລຶບອອກຫຼັງຈາກເຊີບເວີຢືນຢັນ.';

  @override
  String dialog_removeOther(Object name) {
    return 'ການເຂົ້າເຖິງ VPN ຂອງ “$name” ຈະຖືກເພີກຖອນ. ການກະທຳນີ້ບໍ່ສາມາດຍົກເລີກໄດ້.';
  }

  @override
  String get dialog_signOut => 'ອອກຈາກລະບົບບໍ?';

  @override
  String get dialog_signOutMessage =>
      'VPN ຈະຢຸດ ແລະ ທ່ານຈະຕ້ອງເຂົ້າສູ່ລະບົບອີກຄັ້ງ. ກະແຈ VPN ທີ່ເຂົ້າລະຫັດຂອງທ່ານຈະຍັງຄົງຢູ່ໃນໂທລະສັບນີ້ ສຳລັບການເຊື່ອມຕໍ່ຄັ້ງຕໍ່ໄປ.';

  @override
  String get action_cancel => 'ຍົກເລີກ';

  @override
  String get action_close => 'ປິດ';

  @override
  String get action_copy => 'ສຳເນົາ';

  @override
  String get action_signOut => 'ອອກຈາກລະບົບ';

  @override
  String get notice_close => 'ປິດຂໍ້ຄວາມ';

  @override
  String get notice_sessionExpired_title => 'ເຊດຊັນໝົດອາຍຸ';

  @override
  String get notice_sessionExpired_message =>
      'ເຊດຊັນຂອງທ່ານໝົດອາຍຸແລ້ວ. ກະລຸນາເຂົ້າສູ່ລະບົບອີກຄັ້ງ.';

  @override
  String get notice_connectionFailed_title => 'ການເຊື່ອມຕໍ່ລົ້ມເຫຼວ';

  @override
  String get notice_invalidCredentials_message =>
      'ທີ່ຢູ່ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ.';

  @override
  String get notice_emailVerification_title => 'ຕ້ອງຢືນຢັນອີເມວ';

  @override
  String get notice_emailVerification_message =>
      'ກະລຸນາຢືນຢັນທີ່ຢູ່ອີເມວຂອງທ່ານ ກ່ອນເພີ່ມອຸປະກອນ VPN.';

  @override
  String get notice_rateLimited_title => 'ພະຍາຍາມຫຼາຍເກີນໄປ';

  @override
  String get notice_deviceLimit_title => 'ຮອດຂີດຈຳກັດອຸປະກອນແລ້ວ';

  @override
  String get notice_deviceLimit_message =>
      'ກະລຸນາລຶບອຸປະກອນທີ່ມີຢູ່ອອກກ່ອນເພີ່ມອຸປະກອນອື່ນ.';

  @override
  String get notice_identityRenewal_title => 'ຕ້ອງຕໍ່ອາຍຸຕົວຕົນ VPN';

  @override
  String get notice_identityRenewal_message =>
      'ຕົວຕົນນີ້ຖືກລຶບອອກແລ້ວ. ກະລຸນາສ້າງຕົວຕົນໃນເຄື່ອງໃໝ່.';

  @override
  String get notice_migrationPending_title => 'ກຳລັງປ່ຽນສະຖານທີ່';

  @override
  String get notice_migrationPending_message =>
      'ມີການປ່ຽນສະຖານທີ່ກຳລັງດຳເນີນຢູ່ແລ້ວ.';

  @override
  String get notice_migrationBlocked_title => 'ການປ່ຽນສະຖານທີ່ຖືກບລັອກ';

  @override
  String get notice_migrationBlocked_message =>
      'ການປ່ຽນສະຖານທີ່ຕ້ອງໃຫ້ເຊີບເວີແກ້ໄຂ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ ຫຼື ຕິດຕໍ່ຝ່າຍສະໜັບສະໜູນ.';

  @override
  String get notice_targetUnavailable_title => 'ເຊີບເວີບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ';

  @override
  String get notice_targetUnavailable_message =>
      'ເຊີບເວີນີ້ບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ.';

  @override
  String get notice_networkUnavailable_title => 'ບໍ່ມີການເຊື່ອມຕໍ່ອິນເຕີເນັດ';

  @override
  String get notice_networkUnavailable_message =>
      'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ຂອງທ່ານ ແລ້ວລອງໃໝ່.';

  @override
  String get notice_permissionDenied_title => 'ການອະນຸຍາດ VPN ຖືກປະຕິເສດ';

  @override
  String get notice_permissionDenied_message =>
      'ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່ ແລະ ຍອມຮັບຄຳຂໍອະນຸຍາດຂອງ Android.';

  @override
  String get notice_wireguardTimeout_title => 'ເຊີບເວີບໍ່ຕອບສະໜອງ';

  @override
  String get notice_wireguardTimeout_message =>
      'ການເຊື່ອມຕໍ່ WireGuard ໃຊ້ເວລາດົນເກີນໄປ. ກະລຸນາລອງໃໝ່ ຫຼື ເລືອກສະຖານທີ່ອື່ນ.';

  @override
  String get notice_tlsFailed_title => 'ການເຊື່ອມຕໍ່ທີ່ປອດໄພຖືກປະຕິເສດ';

  @override
  String get notice_tlsFailed_message =>
      'ເຊີບເວີບໍ່ໄດ້ຍອມຮັບການເຊື່ອມຕໍ່ OpenVPN. ກະລຸນາລອງໃໝ່. ຖ້າບັນຫາຍັງຄົງຢູ່, ກະລຸນາເລີ່ມການວິນິດໄສ.';

  @override
  String get notice_tunRejected_title => 'Android ປະຕິເສດອິນເຕີເຟດ VPN';

  @override
  String get notice_tunRejected_message =>
      'Android ປະຕິເສດການຕັ້ງຄ່າເຄືອຂ່າຍທີ່ OpenVPN ຮ້ອງຂໍ.';

  @override
  String get notice_openvpnStart_title => 'ບໍ່ສາມາດເລີ່ມ OpenVPN ໄດ້';

  @override
  String get notice_openvpnStart_message =>
      'ເຄື່ອງຈັກ OpenVPN ເລີ່ມເຮັດວຽກບໍ່ສຳເລັດ. ກະລຸນາລອງໃໝ່. ຖ້າບັນຫາຍັງຄົງຢູ່, ກະລຸນາຕິດຕໍ່ຝ່າຍສະໜັບສະໜູນ.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'ລະຫັດວິນິດໄສ: $code';
  }

  @override
  String get notice_generic_title => 'ການເຊື່ອມຕໍ່ VPN ລົ້ມເຫຼວ';

  @override
  String get notice_generic_message => 'ເກີດຂໍ້ຜິດພາດ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'ສ້າງບັນຊີແລ້ວ',
      'password_reset_sent': 'ໄດ້ຮັບຄຳຂໍຕັ້ງລະຫັດຜ່ານໃໝ່ແລ້ວ',
      'verification_email_sent': 'ສົ່ງອີເມວຢືນຢັນແລ້ວ',
      'location_migration_pending': 'ກຳລັງປ່ຽນສະຖານທີ່',
      'vpn_sign_in_required': 'ຕ້ອງເຂົ້າສູ່ລະບົບ',
      'protocol_unavailable_at_location': 'ໂປຣໂຕຄໍບໍ່ພ້ອມໃຊ້ງານ',
      'vpn_permission_denied': 'ການອະນຸຍາດ VPN ຖືກປະຕິເສດ',
      'revoked_identity_device_limit': 'ຮອດຂີດຈຳກັດອຸປະກອນແລ້ວ',
      'tunnel_start_unexpected': 'ບໍ່ສາມາດເລີ່ມ VPN ໄດ້',
      'flutter_disconnect_timeout': 'ຍັງບໍ່ໄດ້ຢືນຢັນການຕັດການເຊື່ອມຕໍ່',
      'flutter_disconnect_unexpected': 'ບໍ່ສາມາດຕັດການເຊື່ອມຕໍ່ໄດ້',
      'device_revoked': 'ລຶບອຸປະກອນແລ້ວ',
      'revoke_unexpected': 'ບໍ່ສາມາດລຶບອຸປະກອນໄດ້',
      'identity_renewal_unexpected': 'ບໍ່ສາມາດຕໍ່ອາຍຸຕົວຕົນໄດ້',
      'openvpn_renewal_unexpected': 'ບໍ່ສາມາດຕໍ່ອາຍຸ OpenVPN ໄດ້',
      'location_migration_blocked': 'ການປ່ຽນສະຖານທີ່ຖືກບລັອກ',
      'location_migration_slow': 'ການປ່ຽນສະຖານທີ່ຍັງດຳເນີນຢູ່',
      'location_migration_conflict': 'ການປ່ຽນສະຖານທີ່ຕ້ອງໂຫຼດໃໝ່',
      'location_migration_verification_failed':
          'ຍັງບໍ່ໄດ້ຢືນຢັນການປ່ຽນສະຖານທີ່',
      'location_migration_device_changed':
          'ອຸປະກອນປ່ຽນແປງໃນລະຫວ່າງການປ່ຽນສະຖານທີ່',
      'tunnel_stop_failed': 'ການປ່ຽນສະຖານທີ່ບໍ່ພ້ອມໃຊ້ງານ',
      'device_clock_ahead': 'ໂມງຂອງອຸປະກອນໄວເກີນໄປ',
      'other': 'ການດຳເນີນການລົ້ມເຫຼວ',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'ສ້າງບັນຊີແລ້ວ ແຕ່ບໍ່ສາມາດສົ່ງອີເມວຢືນຢັນໄດ້. ກະລຸນາໃຊ້ປຸ່ມສົ່ງອີເມວອີກຄັ້ງໃນແອັບ.',
      'password_reset_sent':
          'ໄດ້ຮັບຄຳຂໍຂອງທ່ານແລ້ວ. ຖ້າມີບັນຊີທີ່ກົງກັບທີ່ຢູ່ນີ້, ທ່ານອາດຈະໄດ້ຮັບອີເມວ. ກະລຸນາກວດເບິ່ງໂຟນເດີສະແປມນຳ.',
      'verification_email_sent': 'ສົ່ງອີເມວຢືນຢັນໃໝ່ແລ້ວ.',
      'location_migration_pending':
          'ການຍ້າຍໄປ $target ຍັງຢູ່ໃນຂັ້ນຕອນການກຽມ. ທ່ານສາມາດສືບຕໍ່ໄດ້ໂດຍບໍ່ຕ້ອງສ້າງອຸປະກອນໃໝ່.',
      'vpn_sign_in_required': 'ກະລຸນາເຂົ້າສູ່ລະບົບບັນຊີຂອງທ່ານກ່ອນເລີ່ມ VPN.',
      'protocol_unavailable_at_location':
          'ສະຖານທີ່ນີ້ບໍ່ຮອງຮັບໂປຣໂຕຄໍທີ່ເລືອກ. ກະລຸນາໂຫຼດສະຖານທີ່ໃໝ່ ຫຼື ເລືອກໂປຣໂຕຄໍອື່ນ.',
      'vpn_permission_denied':
          'Android ປະຕິເສດການອະນຸຍາດ VPN. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່ ແລະ ຍອມຮັບຄຳຂໍຂອງລະບົບ.',
      'revoked_identity_device_limit':
          'ການເຂົ້າເຖິງ VPN ຂອງອຸປະກອນນີ້ຖືກລຶບອອກແລ້ວ ແລະ ຮອດຂີດຈຳກັດອຸປະກອນແລ້ວ. ກະລຸນາລຶບອຸປະກອນໜຶ່ງໃນ ບັນຊີ → ຈັດການອຸປະກອນຂອງຂ້ອຍ.',
      'tunnel_start_unexpected':
          'ເກີດຂໍ້ຜິດພາດທີ່ບໍ່ຄາດຄິດຂັດຂວາງການກຽມອຸໂມງ. ກະລຸນາກວດລະຫັດວິນິດໄສ ແລ້ວລອງໃໝ່.',
      'flutter_disconnect_timeout':
          'Android ບໍ່ໄດ້ຢືນຢັນວ່າ VPN ຢຸດທັນເວລາ. ກະລຸນາລອງຢຸດອີກຄັ້ງ.',
      'flutter_disconnect_unexpected':
          'ເກີດຂໍ້ຜິດພາດທີ່ບໍ່ຄາດຄິດ ເຮັດໃຫ້ບໍ່ສາມາດຢືນຢັນວ່າອຸໂມງຢຸດແລ້ວ.',
      'device_revoked':
          'ການເຂົ້າເຖິງ VPN ຂອງອຸປະກອນຖືກເພີກຖອນແລ້ວ ແລະ ຂໍ້ມູນລັບໃນເຄື່ອງຖືກລຶບອອກແລ້ວ.',
      'revoke_unexpected':
          'ບໍ່ສາມາດລຶບອຸປະກອນໄດ້. ກະລຸນາໂຫຼດລາຍການໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'identity_renewal_unexpected':
          'ບໍ່ສາມາດສ້າງຕົວຕົນ VPN ໃໝ່ໄດ້. ກະລຸນາໂຫຼດອຸປະກອນໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'openvpn_renewal_unexpected':
          'ບໍ່ສາມາດຕໍ່ອາຍຸໂປຣໄຟລ໌ OpenVPN ໄດ້. ກະລຸນາລອງອີກຄັ້ງ ຫຼື ກວດລະຫັດວິນິດໄສ.',
      'location_migration_blocked':
          'ເຊີບເວີບໍ່ສາມາດສຳເລັດການປ່ຽນແປງນີ້ໄດ້ໃນຕອນນີ້. ອຸປະກອນ ແລະ ຕົວຕົນໃນເຄື່ອງຍັງຖືກເກັບໄວ້.',
      'location_migration_slow':
          'ເຊີບເວີຍັງກຽມການຍ້າຍໄປ $target ຢູ່. ກະລຸນາໃຊ້ປຸ່ມສືບຕໍ່ໃນອີກບໍ່ດົນ.',
      'location_migration_conflict':
          'ສະຖານະອຸປະກອນໄດ້ປ່ຽນແປງຢູ່ເຊີບເວີ. ກະລຸນາໂຫຼດອຸປະກອນໃໝ່ ແລ້ວສືບຕໍ່ການປ່ຽນແປງ.',
      'location_migration_verification_failed':
          'ເຊີບເວີບໍ່ໄດ້ຢືນຢັນສະຖານທີ່ໃໝ່. ຕົວຕົນໃນເຄື່ອງເດີມຍັງຖືກເກັບໄວ້.',
      'location_migration_device_changed':
          'ອຸປະກອນທີ່ເຊີບເວີສົ່ງກັບມາບໍ່ກົງກັບອຸປະກອນທີ່ກຳລັງປ່ຽນແປງອີກຕໍ່ໄປ. ກະລຸນາໂຫຼດອຸປະກອນໃໝ່ກ່ອນລອງອີກຄັ້ງ.',
      'tunnel_stop_failed': 'ອຸໂມງກ່ອນໜ້າຕ້ອງຢຸດໃຫ້ສົມບູນກ່ອນການເຊື່ອມຕໍ່ໃໝ່.',
      'device_clock_ahead':
          'ໂມງຂອງອຸປະກອນນີ້ເບິ່ງຄືວ່າໄວເກີນໄປ. ກະລຸນາເປີດວັນທີ ແລະ ເວລາອັດຕະໂນມັດ ເພື່ອບໍ່ໃຫ້ຖືກອອກຈາກລະບົບ.',
      'other':
          'ບໍ່ສາມາດດຳເນີນການໃຫ້ສຳເລັດໄດ້. ກະລຸນາລອງອີກຄັ້ງ ຫຼື ສົ່ງລະຫັດວິນິດໄສໃຫ້ຝ່າຍສະໜັບສະໜູນ.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ເຊດຊັນໝົດອາຍຸແລ້ວ',
      'invalid_credentials': 'ເຂົ້າສູ່ລະບົບບໍ່ສຳເລັດ',
      'email_verification_required': 'ຕ້ອງຢືນຢັນອີເມວ',
      'verification_email_cooldown': 'ສົ່ງອີເມວແລ້ວ',
      'rate_limited': 'ພະຍາຍາມຫຼາຍເກີນໄປ',
      'invalid_registration': 'ຕ້ອງແກ້ໄຂຂໍ້ມູນ',
      'email_exists': 'ມີບັນຊີຢູ່ແລ້ວ',
      'invalid_profile': 'ໂປຣໄຟລ໌ບໍ່ຖືກຕ້ອງ',
      'invalid_device': 'ອຸປະກອນບໍ່ຖືກຕ້ອງ',
      'invalid_location': 'ສະຖານທີ່ບໍ່ພ້ອມໃຊ້ງານ',
      'device_limit': 'ຮອດຂີດຈຳກັດອຸປະກອນແລ້ວ',
      'device_exists': 'ຕົວຕົນ VPN ຖືກໃຊ້ແລ້ວ',
      'device_identity_revoked': 'ຕ້ອງຕໍ່ອາຍຸຕົວຕົນ VPN',
      'device_location_locked': 'ການປ່ຽນສະຖານທີ່ຕ້ອງໂຫຼດໃໝ່',
      'location_migration_pending': 'ກຳລັງປ່ຽນສະຖານທີ່',
      'location_migration_blocked': 'ການປ່ຽນສະຖານທີ່ຖືກບລັອກ',
      'target_ca_mismatch': 'ເຊີບເວີ OpenVPN ບໍ່ເຂົ້າກັນໄດ້',
      'location_migration_conflict': 'ການປ່ຽນສະຖານທີ່ຕ້ອງໂຫຼດໃໝ່',
      'server_full': 'ເຊີບເວີເຕັມແລ້ວ',
      'capacity_unavailable': 'ສະຖານທີ່ບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ',
      'target_unavailable': 'ເຊີບເວີບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ',
      'not_found': 'ບໍ່ພົບລາຍການ',
      'invalid_openvpn_csr': 'ຕົວຕົນ OpenVPN ບໍ່ຖືກຕ້ອງ',
      'openvpn_profile_exists': 'ມີໂປຣໄຟລ໌ OpenVPN ແລ້ວ',
      'openvpn_profile_revoked': 'ໂປຣໄຟລ໌ OpenVPN ຖືກເພີກຖອນແລ້ວ',
      'openvpn_operation_pending': 'ກຳລັງດຳເນີນການ OpenVPN',
      'openvpn_operation_terminal': 'ການດຳເນີນການ OpenVPN ຖືກຢຸດ',
      'openvpn_address_unavailable': 'ທີ່ຢູ່ OpenVPN ບໍ່ພ້ອມໃຊ້ງານ',
      'openvpn_profile_conflict': 'OpenVPN ມີຄວາມຂັດແຍ້ງ',
      'openvpn_signer_unavailable': 'OpenVPN ບໍ່ພ້ອມໃຊ້ງານ',
      'email_delivery_unavailable': 'ອີເມວບໍ່ພ້ອມໃຊ້ງານ',
      'invalid_token': 'ລິ້ງບໍ່ຖືກຕ້ອງ',
      'network_unavailable': 'ບໍ່ມີການເຊື່ອມຕໍ່ອິນເຕີເນັດ',
      'invalid_json': 'ຄຳຂໍບໍ່ຖືກຕ້ອງ',
      'invalid_api_response': 'ການຕອບກັບຂອງເຊີບເວີບໍ່ຖືກຕ້ອງ',
      'ipv6_unavailable': 'IPv6 ບໍ່ພ້ອມໃຊ້ງານ',
      'invalid_ip_families': 'ການຕັ້ງຄ່າເຄືອຂ່າຍຖືກປະຕິເສດ',
      'other': 'ບໍລິການບໍ່ພ້ອມໃຊ້ງານ',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ເຊດຊັນຂອງທ່ານໝົດອາຍຸແລ້ວ. ກະລຸນາເຂົ້າສູ່ລະບົບອີກຄັ້ງ.',
      'invalid_credentials': 'ທີ່ຢູ່ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ.',
      'email_verification_required':
          'ກະລຸນາຢືນຢັນທີ່ຢູ່ອີເມວຂອງທ່ານກ່ອນເພີ່ມອຸປະກອນ VPN.',
      'invalid_registration': 'ກະລຸນາກວດສອບຂໍ້ມູນ ແລະ ການຍິນຍອມທີ່ຕ້ອງການ.',
      'email_exists': 'ມີບັນຊີທີ່ໃຊ້ທີ່ຢູ່ອີເມວນີ້ຢູ່ແລ້ວ.',
      'invalid_profile': 'ກະລຸນາກວດສອບຂໍ້ມູນໂປຣໄຟລ໌ຂອງທ່ານ.',
      'invalid_device': 'ຊື່ ຫຼື ຕົວຕົນໃນເຄື່ອງຂອງອຸປະກອນນີ້ບໍ່ຖືກຕ້ອງ.',
      'invalid_location': 'ກະລຸນາໂຫຼດລາຍການສະຖານທີ່ໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'device_limit': 'ກະລຸນາລຶບອຸປະກອນທີ່ມີຢູ່ອອກກ່ອນເພີ່ມອຸປະກອນອື່ນ.',
      'device_exists': 'ຕົວຕົນ VPN ນີ້ຖືກເຊື່ອມໂຍງກັບບັນຊີອື່ນແລ້ວ.',
      'device_identity_revoked':
          'ຕົວຕົນນີ້ຖືກລຶບອອກແລ້ວ. ຕ້ອງສ້າງຕົວຕົນໃນເຄື່ອງໃໝ່.',
      'device_location_locked':
          'ສະຖານທີ່ຂອງອຸປະກອນນີ້ຫາກໍປ່ຽນແປງ. ແອັບຈະສືບຕໍ່ການປ່ຽນສະຖານທີ່ທີ່ກຳລັງດຳເນີນຢູ່.',
      'location_migration_pending': 'ມີການປ່ຽນສະຖານທີ່ກຳລັງດຳເນີນຢູ່ແລ້ວ.',
      'location_migration_blocked':
          'ການປ່ຽນສະຖານທີ່ຕ້ອງໃຫ້ເຊີບເວີແກ້ໄຂ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ ຫຼື ຕິດຕໍ່ຝ່າຍສະໜັບສະໜູນ.',
      'target_ca_mismatch':
          'ເຊີບເວີນີ້ຍັງບໍ່ເຂົ້າກັນໄດ້ກັບໂປຣໄຟລ໌ OpenVPN ປັດຈຸບັນ.',
      'location_migration_conflict':
          'ກະລຸນາໂຫຼດອຸປະກອນໃໝ່ ແລ້ວລອງປ່ຽນສະຖານທີ່ອີກຄັ້ງ.',
      'server_full':
          'ສະຖານທີ່ນີ້ເຕັມຂີດຈຳກັດການເຊື່ອມຕໍ່ແລ້ວ. ກະລຸນາເລືອກສະຖານທີ່ອື່ນ ຫຼື ລອງໃໝ່ໃນພາຍຫຼັງ.',
      'capacity_unavailable':
          'ຕອນນີ້ຢືນຢັນບໍ່ໄດ້ວ່າສະຖານທີ່ນີ້ພ້ອມໃຊ້ງານຫຼືບໍ່. ກະລຸນາເລືອກສະຖານທີ່ອື່ນ ຫຼື ລອງໃໝ່ໃນພາຍຫຼັງ.',
      'target_unavailable': 'ເຊີບເວີນີ້ບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ.',
      'not_found': 'ລາຍການນີ້ບໍ່ສາມາດໃຊ້ໄດ້ໃນບັນຊີຂອງທ່ານອີກຕໍ່ໄປ.',
      'invalid_openvpn_csr': 'ກະລຸນາສ້າງຕົວຕົນ OpenVPN ໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'openvpn_profile_exists': 'ມີໂປຣໄຟລ໌ OpenVPN ສຳລັບອຸປະກອນນີ້ແລ້ວ.',
      'openvpn_profile_revoked': 'ກະລຸນາຕໍ່ອາຍຸໂປຣໄຟລ໌ OpenVPN ເພື່ອສືບຕໍ່.',
      'openvpn_operation_pending':
          'ການປ່ຽນແປງຍັງກຳລັງອັບເດດ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.',
      'openvpn_operation_terminal':
          'ກະລຸນາສ້າງຕົວຕົນ OpenVPN ໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'openvpn_address_unavailable': 'ຕອນນີ້ບໍ່ມີທີ່ຢູ່ OpenVPN ໃຫ້ໃຊ້.',
      'openvpn_profile_conflict':
          'ໂປຣໄຟລ໌ມີການປ່ຽນແປງ. ກະລຸນາໂຫຼດອຸປະກອນໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'openvpn_signer_unavailable': 'ບໍລິການ OpenVPN ບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ.',
      'email_delivery_unavailable':
          'ບໍ່ສາມາດສົ່ງອີເມວໄດ້. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.',
      'invalid_token': 'ລິ້ງນີ້ບໍ່ຖືກຕ້ອງ ຫຼື ໝົດອາຍຸແລ້ວ. ກະລຸນາຂໍລິ້ງໃໝ່.',
      'network_unavailable':
          'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດຂອງທ່ານ ແລ້ວລອງໃໝ່.',
      'invalid_json': 'ກະລຸນາກວດສອບຂໍ້ມູນທີ່ປ້ອນ ແລ້ວລອງໃໝ່.',
      'invalid_api_response':
          'ເຊີບເວີສົ່ງການຕອບກັບທີ່ບໍ່ຄາດຄິດກັບມາ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.',
      'ipv6_unavailable':
          'ຕອນນີ້ເຊີບເວີເປີດໃຊ້ IPv6 ບໍ່ໄດ້. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.',
      'invalid_ip_families':
          'ການຕັ້ງຄ່າອຸໂມງບໍ່ສົມບູນ ຫຼື ບໍ່ກົງກັບທີ່ຢູ່ທີ່ໄດ້ຮັບອະນຸຍາດ. ກະລຸນາລອງໃໝ່ຈາກແອັບ.',
      'other': 'ເກີດຂໍ້ຜິດພາດຂອງເຊີບເວີ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'ກະລຸນາລອງໃໝ່ໃນອີກບໍ່ດົນ.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'ລອງໃໝ່ໃນອີກ $seconds ວິນາທີ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'ລອງໃໝ່ໃນອີກ $minutes ນາທີ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ລອງໃໝ່ໃນອີກ $hours ຊົ່ວໂມງ.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'ບໍ່ສາມາດສືບຕໍ່ VPN ຂອງລະບົບໄດ້',
      'system_vpn_resume_corrupt': 'ການສືບຕໍ່ VPN ຂອງລະບົບບໍ່ຖືກຕ້ອງ',
      'system_vpn_resume_session_invalid': 'ເຊດຊັນສືບຕໍ່ VPN ບໍ່ຖືກຕ້ອງ',
      'system_vpn_resume_identity_changed': 'ຕົວຕົນ VPN ມີການປ່ຽນແປງ',
      'system_vpn_resume_identity_invalid': 'ຕົວຕົນສຳລັບສືບຕໍ່ VPN ບໍ່ຖືກຕ້ອງ',
      'system_vpn_resume_storage_failed':
          'ບ່ອນເກັບຂໍ້ມູນການສືບຕໍ່ VPN ບໍ່ພ້ອມໃຊ້ງານ',
      'system_vpn_resume_network_timeout': 'ບໍ່ມີເຄືອຂ່າຍເພື່ອສືບຕໍ່ VPN',
      'system_vpn_resume_blocked': 'ການສືບຕໍ່ VPN ຖືກບລັອກ',
      'system_vpn_resume_failed': 'ການສືບຕໍ່ VPN ລົ້ມເຫຼວ',
      'system_vpn_resume_error_invalid': 'ຂໍ້ຜິດພາດການສືບຕໍ່ VPN ບໍ່ຖືກຕ້ອງ',
      'wireguard_identity_store_failed': 'ຕົວຕົນ WireGuard ບໍ່ໄດ້ຖືກບັນທຶກ',
      'wireguard_identity_unavailable': 'ຕົວຕົນ WireGuard ບໍ່ພ້ອມໃຊ້ງານ',
      'vpn_host_destroyed': 'ໂຮສ VPN ຂອງ Android ຖືກຢຸດແລ້ວ',
      'vpn_host_unavailable': 'ໂຮສ VPN ຂອງ Android ບໍ່ພ້ອມໃຊ້ງານ',
      'vpn_permission_required': 'ຕ້ອງການການອະນຸຍາດ VPN',
      'vpn_permission_denied': 'ການອະນຸຍາດ VPN ຖືກປະຕິເສດ',
      'vpn_permission_request_failed': 'ບໍ່ສາມາດຮ້ອງຂໍການອະນຸຍາດໄດ້',
      'wireguard_foreground_service_unavailable':
          'ບໍລິການ WireGuard ບໍ່ພ້ອມໃຊ້ງານ',
      'wireguard_identity_invalid': 'ກະແຈ WireGuard ໃນເຄື່ອງບໍ່ຖືກຕ້ອງ',
      'wireguard_identity_in_use': 'ຕົວຕົນ WireGuard ກຳລັງຖືກໃຊ້ຢູ່ແລ້ວ',
      'wireguard_configuration_invalid': 'ການຕັ້ງຄ່າ WireGuard ບໍ່ຖືກຕ້ອງ',
      'wireguard_operation_pending': 'ການດຳເນີນການ WireGuard ຍັງໃຊ້ງານຢູ່',
      'wireguard_start_failed': 'ການເລີ່ມ WireGuard ຖືກປະຕິເສດ',
      'wireguard_stop_timeout': 'ການຢຸດ WireGuard ຍັງບໍ່ໄດ້ຮັບການຢືນຢັນ',
      'wireguard_handshake_timeout': 'WireGuard ບໍ່ຕອບສະໜອງ',
      'openvpn_connection_timeout': 'OpenVPN ບໍ່ຕອບສະໜອງ',
      'openvpn_core_unavailable': 'ເຄື່ອງຈັກ OpenVPN ບໍ່ພ້ອມໃຊ້ງານ',
      'openvpn_operation_pending': 'ເຊດຊັນ OpenVPN ຍັງເຮັດວຽກຢູ່',
      'openvpn_stop_timeout': 'ການຢຸດ OpenVPN ຍັງບໍ່ໄດ້ຮັບການຢືນຢັນ',
      'openvpn_profile_unavailable': 'ບໍ່ພົບໂປຣໄຟລ໌ OpenVPN ໃນເຄື່ອງ',
      'openvpn_native_failed': 'ການເອີ້ນ OpenVPN ເນທີຟຖືກຂັດຂວາງ',
      'openvpn_key_generation_failed': 'ບໍ່ສາມາດສ້າງກະແຈ OpenVPN P-256 ໄດ້',
      'openvpn_csr_generation_failed': 'ບໍ່ສາມາດສ້າງ CSR ຂອງ OpenVPN ໄດ້',
      'openvpn_identity_store_failed': 'ຕົວຕົນ OpenVPN ບໍ່ໄດ້ຖືກບັນທຶກ',
      'openvpn_identity_clear_failed': 'ການລຶບ OpenVPN ບໍ່ສົມບູນ',
      'openvpn_identity_in_use': 'ຕົວຕົນ OpenVPN ຍັງຖືກໃຊ້ຢູ່',
      'openvpn_tls_verification_required': 'ຂາດການກວດສອບ TLS ຂອງ OpenVPN',
      'openvpn_cipher_invalid': 'ການເຂົ້າລະຫັດ OpenVPN ບໍ່ຖືກຕ້ອງ',
      'openvpn_profile_rejected': 'ໂປຣໄຟລ໌ OpenVPN ຖືກປະຕິເສດ',
      'openvpn_identity_inconsistent': 'ຕົວຕົນ OpenVPN ບໍ່ສອດຄ່ອງກັນ',
      'tls_handshake_failed': 'ການເຈລະຈາ OpenVPN ຖືກປະຕິເສດ',
      'tls_alert_unknown_ca': 'ໃບຮັບຮອງໄຄລເອັນ OpenVPN ບໍ່ຮູ້ຈັກ',
      'tls_alert_bad_certificate': 'ໃບຮັບຮອງໄຄລເອັນ OpenVPN ຖືກປະຕິເສດ',
      'tls_alert_unsupported_certificate': 'ໃບຮັບຮອງ OpenVPN ບໍ່ຮອງຮັບ',
      'tls_client_certificate_required': 'ຕ້ອງການໃບຮັບຮອງໄຄລເອັນ OpenVPN',
      'tls_alert_misc': 'ການແຈ້ງເຕືອນ TLS ຂອງ OpenVPN',
      'tls_signature_algorithm_rejected': 'ລາຍເຊັນ OpenVPN ບໍ່ຮອງຮັບ',
      'tls_handshake_rejected': 'ການເຈລະຈາ TLS ຂອງ OpenVPN ຖືກປະຕິເສດ',
      'tls_version_rejected': 'ເວີຊັນ TLS ຂອງ OpenVPN ບໍ່ເຂົ້າກັນໄດ້',
      'tls_certificate_expired': 'ໃບຮັບຮອງ TLS ໝົດອາຍຸແລ້ວ',
      'tls_certificate_revoked': 'ໃບຮັບຮອງ TLS ຖືກເພີກຖອນແລ້ວ',
      'transport_failed': 'ບໍ່ສາມາດເຂົ້າເຖິງເຊີບເວີ OpenVPN ໄດ້',
      'tun_configuration_rejected': 'ບໍ່ສາມາດສ້າງອິນເຕີເຟດ OpenVPN ໄດ້',
      'tun_setup_failed': 'ການຕັ້ງຄ່າ TUN ຂອງ OpenVPN ລົ້ມເຫຼວ',
      'tun_interface_create_failed': 'ການສ້າງອິນເຕີເຟດ OpenVPN ລົ້ມເຫຼວ',
      'tun_interface_disabled': 'ອິນເຕີເຟດ OpenVPN ຖືກປິດການໃຊ້ງານ',
      'tun_halted': 'ອິນເຕີເຟດ OpenVPN ຖືກຂັດຂວາງ',
      'tun_already_established': 'ອິນເຕີເຟດ OpenVPN ເປີດຢູ່ແລ້ວ',
      'tun_addresses_missing': 'ຂາດທີ່ຢູ່ OpenVPN',
      'tun_routes_missing': 'ຂາດເສັ້ນທາງ OpenVPN',
      'tun_dns_missing': 'ຂາດ DNS ຂອງ OpenVPN',
      'tun_permission_revoked': 'ການອະນຸຍາດ VPN ຖືກຖອນແລ້ວ',
      'tun_establish_returned_null': 'Android ປະຕິເສດອິນເຕີເຟດ VPN',
      'openvpn_service_start_failed': 'ບໍລິການ OpenVPN ບໍ່ພ້ອມໃຊ້ງານ',
      'openvpn_operation_timeout': 'ການເອີ້ນ OpenVPN ໝົດເວລາ',
      'openvpn_start_failed': 'ການເລີ່ມ OpenVPN ຖືກປະຕິເສດ',
      'openvpn_connection_failed': 'ການເຊື່ອມຕໍ່ OpenVPN ຖືກຂັດຂວາງ',
      'openvpn_core_status_error': 'ແກນຫຼັກ OpenVPN ສິ້ນສຸດດ້ວຍຂໍ້ຜິດພາດ',
      'openvpn_stopped_before_connected': 'OpenVPN ຢຸດກ່ອນເຊື່ອມຕໍ່',
      'openvpn_auth_failed': 'ການຢືນຢັນຕົວຕົນ OpenVPN ຖືກປະຕິເສດ',
      'openvpn_client_setup_failed': 'ການຕັ້ງຄ່າໄຄລເອັນ OpenVPN ລົ້ມເຫຼວ',
      'openvpn_client_halted': 'ໄຄລເອັນ OpenVPN ຖືກຂັດຂວາງ',
      'openvpn_client_restart': 'ມີການຮ້ອງຂໍເລີ່ມ OpenVPN ໃໝ່',
      'openvpn_inactive_timeout': 'OpenVPN ບໍ່ໄດ້ໃຊ້ງານດົນເກີນໄປ',
      'openvpn_session_expired': 'ເຊດຊັນ OpenVPN ໝົດອາຍຸແລ້ວ',
      'openvpn_credentials_required': 'ການຢືນຢັນຕົວຕົນ OpenVPN ບໍ່ຮອງຮັບ',
      'openvpn_proxy_failed': 'ການສົ່ງຜ່ານຕົວກາງ OpenVPN ລົ້ມເຫຼວ',
      'openvpn_compression_failed': 'ການບີບອັດ OpenVPN ຖືກປະຕິເສດ',
      'openvpn_ntlm_crypto_unavailable':
          'ການເຂົ້າລະຫັດ NTLM ຂອງ OpenVPN ບໍ່ພ້ອມໃຊ້ງານ',
      'openvpn_feature_unsupported': 'ຟີເຈີ OpenVPN ບໍ່ຮອງຮັບ',
      'network_unavailable': 'ບໍ່ມີການເຊື່ອມຕໍ່ອິນເຕີເນັດ',
      'network_lost': 'ເຄືອຂ່າຍບໍ່ພ້ອມໃຊ້ງານ',
      'certificate_validation_failed': 'ໃບຮັບຮອງເຊີບເວີຖືກປະຕິເສດ',
      'openvpn_certificate_expired': 'ໃບຮັບຮອງ OpenVPN ໝົດອາຍຸແລ້ວ',
      'tunnel_active_for_another_account': 'ອຸໂມງຂອງບັນຊີອື່ນຍັງເຮັດວຽກຢູ່',
      'tunnel_already_active': 'ອຸໂມງເນທີຟເຮັດວຽກຢູ່ແລ້ວ',
      'tunnel_stop_timeout': 'ການຢຸດ $protocol ຍັງບໍ່ໄດ້ຮັບການຢືນຢັນ',
      'tunnel_disconnected': '$protocol ຖືກຂັດຂວາງ',
      'native_bridge_unavailable': 'ຂົວເຊື່ອມຕໍ່ຂອງ Android ບໍ່ພ້ອມໃຊ້ງານ',
      'native_operation_failed': 'ການດຳເນີນການຂອງ Android ຖືກຂັດຂວາງ',
      'invalid_arguments': 'ພາຣາມິເຕີ VPN ບໍ່ສົມບູນ',
      'invalid_account_id': 'ບັນຊີ VPN ບໍ່ຖືກຕ້ອງ',
      'invalid_device_id': 'ຕົວລະບຸອຸປະກອນບໍ່ຖືກຕ້ອງ',
      'storage_key_not_allowed': 'ກະແຈບ່ອນເກັບຂໍ້ມູນຖືກປະຕິເສດ',
      'secure_storage_read_failed': 'ການອ່ານຂໍ້ມູນທີ່ປອດໄພລົ້ມເຫຼວ',
      'secure_storage_write_failed': 'ການບັນທຶກຂໍ້ມູນທີ່ປອດໄພລົ້ມເຫຼວ',
      'key_generation_failed': 'ບໍ່ສາມາດສ້າງກະແຈ WireGuard ໄດ້',
      'csr_generation_failed': 'ບໍ່ສາມາດສ້າງ CSR ຂອງ OpenVPN ໄດ້',
      'openvpn_recovery_exhausted': 'ການກູ້ຄືນ OpenVPN ຖືກໃຊ້ໄປແລ້ວ',
      'openvpn_recovery_failed': 'ການກູ້ຄືນ OpenVPN ລົ້ມເຫຼວ',
      'openvpn_renewal_required': 'ຕ້ອງຕໍ່ອາຍຸໃບຮັບຮອງ OpenVPN',
      'other': 'ຂໍ້ຜິດພາດ VPN ເນທີຟທີ່ບໍ່ໄດ້ຈັດປະເພດ',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ບໍ່ພົບເຊດຊັນ VPN ທີ່ສືບຕໍ່ໄດ້. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່ໃນແອັບ.',
      'system_vpn_resume_corrupt':
          'ຂໍ້ມູນການສືບຕໍ່ VPN ທີ່ບັນທຶກໄວ້ບໍ່ຖືກຕ້ອງ ແລະ ຈະບໍ່ຖືກນຳໃຊ້. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'system_vpn_resume_session_invalid':
          'ເຊດຊັນທີ່ບັນທຶກໄວ້ບໍ່ສາມາດສືບຕໍ່ VPN ໄດ້ອີກແລ້ວ. ກະລຸນາເຂົ້າສູ່ລະບົບອີກຄັ້ງໃນແອັບ.',
      'system_vpn_resume_identity_changed':
          'ຕົວຕົນ VPN ໃນເຄື່ອງມີການປ່ຽນແປງ. ການສືບຕໍ່ຖືກຢຸດແລ້ວ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'system_vpn_resume_identity_invalid':
          'ຕົວຕົນສຳລັບສືບຕໍ່ບໍ່ຖືກຕ້ອງ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'system_vpn_resume_storage_failed':
          'Android ບໍ່ສາມາດອ່ານ ຫຼື ອັບເດດຂໍ້ມູນການສືບຕໍ່ທີ່ເຂົ້າລະຫັດໄວ້ໄດ້. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'system_vpn_resume_network_timeout':
          'Android ບໍ່ພົບເຄືອຂ່າຍທັນເວລາເພື່ອສືບຕໍ່ VPN. ກະລຸນາລອງໃໝ່ເມື່ອມີເຄືອຂ່າຍ.',
      'system_vpn_resume_blocked':
          'ການສືບຕໍ່ VPN ຖືກບລັອກ. ກະລຸນາກວດສອບການຕັ້ງຄ່າ Android ແລ້ວເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'system_vpn_resume_failed':
          'ການສືບຕໍ່ VPN ຂອງ Android ລົ້ມເຫຼວ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່ໃນແອັບ.',
      'system_vpn_resume_error_invalid':
          'Android ສົ່ງຂໍ້ຜິດພາດການສືບຕໍ່ທີ່ໃຊ້ບໍ່ໄດ້ກັບມາ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'wireguard_identity_store_failed':
          'Android ບໍ່ສາມາດບັນທຶກຕົວຕົນ WireGuard ທີ່ເຂົ້າລະຫັດຂອງບັນຊີນີ້ໄດ້.',
      'wireguard_identity_unavailable':
          'ບໍ່ມີຕົວຕົນ WireGuard ທີ່ໃຊ້ໄດ້ສຳລັບການເຊື່ອມຕໍ່ນີ້.',
      'vpn_host_destroyed':
          'ສ່ວນປະກອບຂອງ Android ທີ່ໂຮສ VPN ຖືກຢຸດແລ້ວ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່.',
      'vpn_host_unavailable':
          'Android ບໍ່ສາມາດສ້າງສ່ວນປະກອບທີ່ໂຮສ VPN ໄດ້. ກະລຸນາລອງໃໝ່ຫຼັງຈາກກວດສອບການຕັ້ງຄ່າ VPN.',
      'openvpn_renewal_required':
          'ໃບຮັບຮອງຕ້ອງການການດຳເນີນການໃນແອັບກ່ອນເຊື່ອມຕໍ່.',
      'openvpn_recovery_failed':
          'ການກູ້ຄືນອັດຕະໂນມັດລົ້ມເຫຼວ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່ໃນແອັບ.',
      'openvpn_recovery_exhausted':
          'ການກູ້ຄືນອັດຕະໂນມັດຖືກໃຊ້ໄປແລ້ວ. ກະລຸນາເລີ່ມການເຊື່ອມຕໍ່ໃໝ່ໃນແອັບ.',
      'vpn_permission_required':
          'Android ຕ້ອງການການອະນຸຍາດ VPN ໃໝ່ກ່ອນເລີ່ມອຸໂມງ.',
      'vpn_permission_denied':
          'ກະລຸນາອະນຸຍາດ FuzeVPN ໃນຄຳຂໍຂອງ Android ເພື່ອສືບຕໍ່.',
      'vpn_permission_request_failed':
          'Android ບໍ່ສາມາດເປີດໜ້າການອະນຸຍາດ VPN ໄດ້.',
      'wireguard_foreground_service_unavailable':
          'Android ບໍ່ສາມາດຮັກສາບໍລິການ WireGuard ໃຫ້ເຮັດວຽກຢູ່ເບື້ອງໜ້າໄດ້.',
      'wireguard_identity_invalid':
          'ກະແຈ WireGuard ທີ່ເຂົ້າລະຫັດຂອງບັນຊີນີ້ອ່ານບໍ່ໄດ້ ຫຼື ບໍ່ຖືກຕ້ອງ.',
      'wireguard_identity_in_use':
          'ມີການດຳເນີນການອື່ນຍັງໃຊ້ກະແຈ WireGuard ຂອງບັນຊີນີ້ຢູ່.',
      'wireguard_configuration_invalid':
          'ທີ່ຢູ່, DNS, ກະແຈເຊີບເວີ ຫຼື ເສັ້ນທາງ WireGuard ທີ່ໄດ້ຮັບບໍ່ຖືກຕ້ອງ.',
      'wireguard_operation_pending':
          'ການດຳເນີນການ WireGuard ກ່ອນໜ້ານີ້ຍັງບໍ່ໄດ້ປ່ອຍບໍລິການເນທີຟຂອງມັນ.',
      'wireguard_start_failed':
          'ເຄື່ອງຈັກ WireGuard ປະຕິເສດການເປີດໃຊ້ການຕັ້ງຄ່າ.',
      'wireguard_stop_timeout':
          'ບໍລິການ WireGuard ບໍ່ໄດ້ຢືນຢັນການປ່ອຍອິນເຕີເຟດ VPN ພາຍໃນເວລາທີ່ກຳນົດ.',
      'wireguard_handshake_timeout':
          'ອຸໂມງບໍ່ໄດ້ຢືນຢັນການຈັບມືກັບເຊີບເວີທັນເວລາ.',
      'openvpn_connection_timeout':
          'OpenVPN ບໍ່ໄດ້ຢືນຢັນການເຊື່ອມຕໍ່ກັບເຊີບເວີທັນເວລາ.',
      'openvpn_core_unavailable':
          'ເວີຊັນແອັບນີ້ບໍ່ມີເຄື່ອງຈັກ OpenVPN ທີ່ໃຊ້ໄດ້.',
      'openvpn_operation_pending':
          'ເຄື່ອງຈັກເນທີຟຍັງຖືເຊດຊັນ OpenVPN ກ່ອນໜ້າໄວ້ ແລະ ປະຕິເສດການສ້າງເຊດຊັນທີສອງ.',
      'openvpn_stop_timeout':
          'ແກນຫຼັກ OpenVPN ບໍ່ໄດ້ຢືນຢັນວ່າເຊດຊັນເນທີຟຂອງມັນຢຸດ ແລະ ຖືກທຳລາຍພາຍໃນເວລາທີ່ກຳນົດ.',
      'openvpn_profile_unavailable':
          'ບໍ່ສາມາດອ່ານໂປຣໄຟລ໌ OpenVPN ທີ່ຜ່ານການກວດສອບສຳລັບການເຊື່ອມຕໍ່ນີ້ໄດ້.',
      'openvpn_native_failed':
          'ຂໍ້ຜິດພາດຂອງແອັບໄດ້ຂັດຂວາງ OpenVPN. ກະລຸນາລອງເຊື່ອມຕໍ່ອີກຄັ້ງ. ຫາກບັນຫານີ້ຍັງຄົງຢູ່, ກະລຸນາເລີ່ມການວິນິດໄສ.',
      'openvpn_key_generation_failed':
          'Android Keystore ບໍ່ສາມາດສ້າງ ຫຼື ອ່ານກະແຈສ່ວນຕົວ P-256 ທີ່ບໍ່ສາມາດສົ່ງອອກໄດ້.',
      'openvpn_csr_generation_failed':
          'ກະແຈ Android Keystore ບໍ່ສາມາດເຊັນຄຳຮ້ອງຂໍໃບຮັບຮອງ OpenVPN ໄດ້.',
      'openvpn_identity_store_failed':
          'ໃບຮັບຮອງ ຫຼື ໂປຣໄຟລ໌ OpenVPN ບໍ່ສາມາດບັນທຶກໃນບ່ອນເກັບຂໍ້ມູນທີ່ເຂົ້າລະຫັດໄວ້ໄດ້.',
      'openvpn_identity_clear_failed':
          'Android ບໍ່ສາມາດລຶບຕົວຕົນ OpenVPN ໃນເຄື່ອງທັງໝົດຂອງບັນຊີນີ້ໄດ້.',
      'openvpn_identity_in_use':
          'ເຊດຊັນ OpenVPN ເນທີຟຍັງໃຊ້ກະແຈ ຫຼື ໃບຮັບຮອງຂອງອຸປະກອນນີ້ຢູ່.',
      'openvpn_tls_verification_required':
          'ໂປຣໄຟລ໌ນີ້ບໍ່ໄດ້ກຳນົດໃຫ້ກວດສອບໃບຮັບຮອງເຊີບເວີຢ່າງຊັດເຈນ.',
      'openvpn_cipher_invalid':
          'ເຊີບເວີສົ່ງອັລກໍຣິທຶມການເຂົ້າລະຫັດທີ່ບໍ່ຢູ່ໃນລາຍການທີ່ອະນຸຍາດ.',
      'openvpn_profile_rejected':
          'ໂປຣໄຟລ໌ທີ່ໄດ້ຮັບຈາກເຊີບເວີບໍ່ເຂົ້າກັນໄດ້. ກະລຸນາສ້າງອຸປະກອນນີ້ໃໝ່ ແລ້ວລອງອີກຄັ້ງ.',
      'openvpn_identity_inconsistent':
          'ໃບຮັບຮອງບໍ່ກົງກັບຕົວຕົນທີ່ປອດໄພຂອງໂທລະສັບນີ້. ບໍ່ມີໂປຣໄຟລ໌ໃນເຄື່ອງທີ່ຖືກປ່ຽນແທນ.',
      'tls_handshake_failed':
          'ເຊີບເວີປະຕິເສດການເຈລະຈາ TLS. ຫາກບັນຫາຍັງຄົງຢູ່, ກະລຸນາສ້າງໂປຣໄຟລ໌ໃໝ່.',
      'tls_alert_unknown_ca':
          'ເຊີບເວີບໍ່ຮູ້ຈັກຜູ້ອອກໃບຮັບຮອງຂອງອຸປະກອນນີ້. ຕ້ອງກວດສອບເຊີບເວີ OpenVPN.',
      'tls_alert_bad_certificate':
          'ເຊີບເວີປະຕິເສດໃບຮັບຮອງຂອງອຸປະກອນນີ້. ກະລຸນາສ້າງອຸປະກອນໃໝ່ກ່ອນລອງອີກຄັ້ງ.',
      'tls_alert_unsupported_certificate':
          'ເຊີບເວີບໍ່ຮອງຮັບປະເພດໃບຮັບຮອງທີ່ປອດໄພທີ່ Android ໃຊ້.',
      'tls_client_certificate_required':
          'ເຊີບເວີຕ້ອງການໃບຮັບຮອງໄຄລເອັນ ແຕ່ແກນຫຼັກ OpenVPN ບໍ່ສາມາດສະເໜີໃບຮັບຮອງໄດ້.',
      'tls_alert_misc':
          'ເຊີບເວີສົ່ງການແຈ້ງເຕືອນ TLS ທີ່ບໍ່ຢູ່ໃນປະເພດໃບຮັບຮອງ ຫຼື ເວີຊັນ.',
      'tls_signature_algorithm_rejected':
          'ເຊີບເວີປະຕິເສດອັລກໍຣິທຶມ ECDSA P-256 ຂອງກະແຈ Android Keystore.',
      'tls_handshake_rejected': 'ເຊີບເວີຂັດຂວາງການເຈລະຈາ TLS ກ່ອນເຊື່ອມຕໍ່.',
      'tls_version_rejected': 'ໄຄລເອັນ ແລະ ເຊີບເວີບໍ່ພົບເວີຊັນ TLS ທີ່ກົງກັນ.',
      'tls_certificate_expired':
          'ໃບຮັບຮອງທີ່ສະເໜີໃນລະຫວ່າງການເຊື່ອມຕໍ່ໄດ້ໝົດອາຍຸແລ້ວ.',
      'tls_certificate_revoked':
          'ໃບຮັບຮອງທີ່ສະເໜີໃນລະຫວ່າງການເຊື່ອມຕໍ່ໄດ້ຖືກເພີກຖອນແລ້ວ.',
      'transport_failed':
          'ເຊີບເວີ OpenVPN ບໍ່ຕອບສະໜອງໃນເຄືອຂ່າຍປັດຈຸບັນ. ກະລຸນາລອງໃໝ່ໃນອີກບໍ່ດົນ.',
      'tun_configuration_rejected':
          'Android ປະຕິເສດການຕັ້ງຄ່າເຄືອຂ່າຍທີ່ OpenVPN ຮ້ອງຂໍ.',
      'tun_setup_failed':
          'ແກນຫຼັກ OpenVPN ປະຕິເສດແຜນເຄືອຂ່າຍກ່ອນສ້າງອິນເຕີເຟດ Android.',
      'tun_interface_create_failed':
          'ແກນຫຼັກ OpenVPN ບໍ່ສາມາດຮັບອິນເຕີເຟດ TUN ຈາກ VpnService ຂອງ Android ໄດ້.',
      'tun_interface_disabled':
          'Android ຫຼື ແກນຫຼັກ OpenVPN ໄດ້ປິດການໃຊ້ງານອິນເຕີເຟດ TUN ໃນລະຫວ່າງການເຊື່ອມຕໍ່.',
      'tun_halted': 'ແກນຫຼັກ OpenVPN ໄດ້ຮັບຄຳຂໍໃຫ້ຢຸດອິນເຕີເຟດ TUN.',
      'tun_already_established':
          'OpenVPN ຮ້ອງຂໍອິນເຕີເຟດທີສອງໃນການເຊື່ອມຕໍ່ດຽວກັນ. ອຸໂມງຖືກຢຸດເພື່ອຄວາມປອດໄພ.',
      'tun_addresses_missing': 'ເຊີບເວີບໍ່ໄດ້ໃຫ້ທີ່ຢູ່ອຸໂມງທີ່ໃຊ້ໄດ້.',
      'tun_routes_missing': 'ເຊີບເວີບໍ່ໄດ້ໃຫ້ເສັ້ນທາງອຸໂມງທີ່ໃຊ້ໄດ້.',
      'tun_dns_missing': 'ເຊີບເວີບໍ່ໄດ້ໃຫ້ເຊີບເວີ DNS ທີ່ໃຊ້ໄດ້.',
      'tun_permission_revoked':
          'Android ໄດ້ຖອນການອະນຸຍາດ VPN ໃນລະຫວ່າງການເຊື່ອມຕໍ່.',
      'tun_establish_returned_null':
          'Android ບໍ່ໄດ້ສ້າງອິນເຕີເຟດ, ໂດຍປົກກະຕິເນື່ອງຈາກ VPN ອື່ນຍັງເຮັດວຽກຢູ່.',
      'openvpn_service_start_failed':
          'Android ບໍ່ສາມາດເລີ່ມບໍລິການ OpenVPN ເບື້ອງໜ້າໄດ້.',
      'openvpn_operation_timeout':
          'ການເອີ້ນ JNI ໄປຫາແກນຫຼັກ OpenVPN ເກີນໄລຍະເວລາສູງສຸດ.',
      'openvpn_start_failed':
          'ບໍລິການ Android ພ້ອມແລ້ວ, ແຕ່ແກນຫຼັກ OpenVPN ບໍ່ຍອມຮັບການເລີ່ມໂປຣໄຟລ໌.',
      'openvpn_connection_failed':
          'ແກນຫຼັກ OpenVPN ຢຸດກ່ອນສົ່ງເຫດການ CONNECTED.',
      'openvpn_core_status_error':
          'ວົງຈອນ OpenVPN ເນທີຟສິ້ນສຸດດ້ວຍຂໍ້ຜິດພາດ ໂດຍບໍ່ມີເຫດການສຸດທ້າຍທີ່ລະບຸເຈາະຈົງກວ່ານີ້.',
      'openvpn_stopped_before_connected':
          'ວົງຈອນ OpenVPN ເນທີຟຢຸດກ່ອນ CONNECTED ໂດຍບໍ່ມີຂໍ້ຜິດພາດຈາກແກນຫຼັກທີ່ຊັດເຈນ.',
      'openvpn_auth_failed':
          'ເຊີບເວີ OpenVPN ປະຕິເສດການຢືນຢັນຕົວຕົນຂອງໂປຣໄຟລ໌.',
      'openvpn_client_setup_failed':
          'ແກນຫຼັກ OpenVPN ບໍ່ສາມາດເລີ່ມຕົ້ນໄຄລເອັນກ່ອນການເຊື່ອມຕໍ່ເຄືອຂ່າຍໄດ້.',
      'openvpn_client_halted': 'ແກນຫຼັກ OpenVPN ໄດ້ຮັບຄຳສັ່ງຢຸດໄຄລເອັນສຸດທ້າຍ.',
      'openvpn_client_restart':
          'ແກນຫຼັກ OpenVPN ຮ້ອງຂໍໃຫ້ເລີ່ມເຊດຊັນການສົ່ງຂໍ້ມູນໃໝ່.',
      'openvpn_inactive_timeout':
          'ແກນຫຼັກ OpenVPN ປິດເຊດຊັນຫຼັງຈາກໝົດເວລາບໍ່ໃຊ້ງານ.',
      'openvpn_session_expired': 'ເຊີບເວີແຈ້ງວ່າເຊດຊັນ OpenVPN ໝົດອາຍຸແລ້ວ.',
      'openvpn_credentials_required':
          'ເຊີບເວີ ຫຼື ພຣັອກຊີຮ້ອງຂໍຂໍ້ມູນຢືນຢັນແບບໂຕ້ຕອບ ທີ່ບໍ່ໄດ້ຢູ່ໃນໂປຣໄຟລ໌ໃບຮັບຮອງນີ້.',
      'openvpn_proxy_failed':
          'ແກນຫຼັກ OpenVPN ລາຍງານວ່າພຣັອກຊີ ຫຼື ຕົວສົ່ງຕໍ່ທີ່ຕັ້ງຄ່າໄວ້ລົ້ມເຫຼວ.',
      'openvpn_compression_failed':
          'ແກນຫຼັກ OpenVPN ປະຕິເສດໂໝດການບີບອັດທີ່ໂປຣໄຟລ໌ ຫຼື ເຊີບເວີປະກາດ.',
      'openvpn_ntlm_crypto_unavailable':
          'ໂປຣໄຟລ໌ຮ້ອງຂໍການເຂົ້າລະຫັດ NTLM ທີ່ບໍ່ມີໃນເວີຊັນນີ້.',
      'openvpn_feature_unsupported':
          'ໂປຣໄຟລ໌ ຫຼື ເຊີບເວີຕ້ອງການຟີເຈີທີ່ບໍ່ມີໃນໄຄລເອັນ Android ນີ້.',
      'network_unavailable': 'ບໍ່ມີເຄືອຂ່າຍທາງກາຍະພາບທີ່ໃຊ້ໄດ້.',
      'network_lost': 'ອຸໂມງຖືກຢຸດຫຼັງຈາກເຄືອຂ່າຍຂາດຫາຍໄປ.',
      'certificate_validation_failed':
          'ບໍ່ສາມາດກວດສອບຕົວຕົນຂອງເຊີບເວີ OpenVPN ໄດ້.',
      'openvpn_certificate_expired':
          'ກະລຸນາຕໍ່ອາຍຸໂປຣໄຟລ໌ OpenVPN ກ່ອນເຊື່ອມຕໍ່ໃໝ່.',
      'tunnel_active_for_another_account':
          'ອຸໂມງຂອງບັນຊີອື່ນຕ້ອງຢຸດກ່ອນການເຊື່ອມຕໍ່ນີ້.',
      'tunnel_already_active':
          'Android ລາຍງານວ່າເຊດຊັນ VPN ກ່ອນໜ້ານີ້ຍັງໃຊ້ອິນເຕີເຟດຢູ່.',
      'tunnel_stop_timeout':
          'ເຄື່ອງຈັກ $protocol ບໍ່ໄດ້ຢືນຢັນການປ່ອຍອິນເຕີເຟດ VPN ພາຍໃນເວລາທີ່ກຳນົດ.',
      'tunnel_disconnected':
          'ເຄື່ອງຈັກເນທີຟລາຍງານວ່າອຸໂມງສິ້ນສຸດລົງຢ່າງບໍ່ຄາດຄິດຫຼັງຈາກເລີ່ມແລ້ວ.',
      'native_bridge_unavailable':
          'ແອັບບໍ່ສາມາດເຂົ້າເຖິງບໍລິການ VPN ຂອງ Android ໄດ້. ກະລຸນາປິດ ແລ້ວເປີດແອັບອີກຄັ້ງ ຈາກນັ້ນລອງໃໝ່.',
      'native_operation_failed':
          'ຂໍ້ຜິດພາດຂອງແອັບໄດ້ຂັດຂວາງການດຳເນີນການ VPN. ກະລຸນາລອງໃໝ່. ຫາກບັນຫາຍັງຄົງຢູ່, ກະລຸນາເລີ່ມການວິນິດໄສ.',
      'invalid_arguments':
          'ຂໍ້ມູນທີ່ຕ້ອງການສຳລັບການດຳເນີນການ VPN ນີ້ບໍ່ສົມບູນ. ກະລຸນາລອງໃໝ່. ຫາກບັນຫາຍັງຄົງຢູ່, ກະລຸນາເລີ່ມການວິນິດໄສ.',
      'invalid_account_id':
          'ການດຳເນີນການເນທີຟນີ້ບໍ່ກ່ຽວຂ້ອງກັບຕົວລະບຸບັນຊີທີ່ຖືກຕ້ອງ.',
      'invalid_device_id':
          'ຕົວລະບຸອຸປະກອນທີ່ສົ່ງໄປເຄື່ອງຈັກເນທີຟຂາດຫາຍ ຫຼື ບໍ່ຖືກຕ້ອງ.',
      'storage_key_not_allowed':
          'ຂົວເຊື່ອມຕໍ່ຂອງ Android ໄດ້ບລັອກກະແຈທີ່ຢູ່ນອກລາຍການບ່ອນເກັບຂໍ້ມູນທີ່ອະນຸຍາດ.',
      'secure_storage_read_failed':
          'Android Keystore ບໍ່ສາມາດຖອດລະຫັດຂໍ້ມູນໃນເຄື່ອງຂອງບັນຊີນີ້ໄດ້.',
      'secure_storage_write_failed':
          'Android Keystore ບໍ່ສາມາດເຂົ້າລະຫັດ ຫຼື ບັນທຶກຂໍ້ມູນໃນເຄື່ອງໄດ້.',
      'key_generation_failed':
          'Android ບໍ່ສາມາດສ້າງ ຫຼື ອ່ານກະແຈ WireGuard ໃນບ່ອນເກັບຂໍ້ມູນທີ່ປອດໄພໄດ້.',
      'csr_generation_failed':
          'Android Keystore ບໍ່ສາມາດສ້າງ ຫຼື ເຊັນ CSR P-256 ຂອງ OpenVPN ໄດ້.',
      'other':
          'ເສັ້ນທາງໂຄດເນທີຟທີ່ບໍ່ມີໃນເອກະສານລົ້ມເຫຼວ. ກະລຸນາສົ່ງລະຫັດວິນິດໄສທີ່ສະແດງດ້ານລຸ່ມໃຫ້ຝ່າຍສະໜັບສະໜູນ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'ມີຄຳຂໍອະນຸຍາດເປີດຢູ່ແລ້ວ';

  @override
  String get notice_permissionRequestInProgress_message =>
      'ໜ້າຂໍອະນຸຍາດ VPN ຂອງ Android ສະແດງຢູ່ແລ້ວ. ກະລຸນາດຳເນີນການໃຫ້ສຳເລັດກ່ອນລອງໃໝ່.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'ການຂໍອະນຸຍາດ VPN ຖືກຢຸດ';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ໜ້າຈໍອະນຸຍາດ VPN ປິດລົງກ່ອນທີ່ແອັບຈະໄດ້ຮັບການຕອບກັບ.';

  @override
  String get notice_openvpnProofMissing_title =>
      'ຍັງບໍ່ໄດ້ຢືນຢັນການເຊື່ອມຕໍ່ OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'ບໍ່ສາມາດຢືນຢັນການເຊື່ອມຕໍ່ OpenVPN ໄດ້. ໄດ້ຢຸດການເຊື່ອມຕໍ່ເພື່ອຄວາມປອດໄພ. ກະລຸນາລອງໃໝ່.';

  @override
  String get openvpnCleanup_title => 'ໂປຣໄຟລ໌ OpenVPN ຖືກເພີກຖອນແລ້ວ';

  @override
  String get openvpnCleanup_working =>
      'ກຳລັງຢຸດ ແລະ ລຶບໂປຣໄຟລ໌ OpenVPN ທີ່ຖືກເພີກຖອນ…';

  @override
  String get openvpnCleanup_stopFailed =>
      'ຍັງບໍ່ໄດ້ຢືນຢັນການປິດ OpenVPN. ກະລຸນາລອງໃໝ່ກ່ອນສ້າງໂປຣໄຟລ໌ໃໝ່.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'ບໍ່ສາມາດລຶບໂປຣໄຟລ໌ OpenVPN ທີ່ຖືກເພີກຖອນອອກໄດ້ໝົດ. ກະລຸນາລອງລຶບອີກຄັ້ງ.';

  @override
  String get openvpnCleanup_complete =>
      'ລຶບໂປຣໄຟລ໌ OpenVPN ທີ່ຖືກເພີກຖອນອອກແລ້ວ. ແຕະເຊື່ອມຕໍ່ເພື່ອສ້າງໃໝ່.';

  @override
  String get network_title => 'ການຕັ້ງຄ່າເຄືອຂ່າຍ';

  @override
  String get network_ipv4Fallback =>
      'IPv6 ບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ. ການກຽມພ້ອມຈະດຳເນີນຕໍ່ດ້ວຍ IPv4.';

  @override
  String get network_rejectedTitle => 'ການຕັ້ງຄ່າເຄືອຂ່າຍຖືກປະຕິເສດ';

  @override
  String get network_rejectedMessage =>
      'ການຕັ້ງຄ່າອຸໂມງບໍ່ສົມບູນ ຫຼື ບໍ່ກົງກັບທີ່ຢູ່ທີ່ໄດ້ຮັບອະນຸຍາດ. ກະລຸນາລອງໃໝ່ຈາກແອັບ.';

  @override
  String get network_unreadableTitle => 'ອ່ານການຕັ້ງຄ່າໃນເຄື່ອງບໍ່ໄດ້';

  @override
  String get network_unreadableMessage =>
      'ການຕັ້ງຄ່າເຄືອຂ່າຍ OpenVPN ທີ່ບັນທຶກໄວ້ບໍ່ສາມາດໃຊ້ໄດ້. ກະລຸນາເຊື່ອມຕໍ່ໃໝ່ຈາກແອັບເພື່ອອັບເດດ.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ການປົກປ້ອງເຄືອຂ່າຍ';

  @override
  String get protection_subtitle =>
      'ບລັອກການເຂົ້າອິນເຕີເນັດໂດຍກົງ ຖ້າ VPN ຕັດການເຊື່ອມຕໍ່.';

  @override
  String get protection_active => 'ການປົກປ້ອງລະບົບເປີດໃຊ້ງານແລ້ວ';

  @override
  String get protection_alwaysOnOnly =>
      'ເປີດໃຊ້ VPN ເປີດຕະຫຼອດເວລາແລ້ວ. ກະລຸນາເປີດການບລັອກນອກ VPN';

  @override
  String get protection_inactive => 'ການປົກປ້ອງລະບົບບໍ່ໄດ້ເປີດໃຊ້ງານ';

  @override
  String get protection_unknown => 'ກວດສອບການປົກປ້ອງລະບົບ';

  @override
  String get protection_openSettings => 'ເປີດການຕັ້ງຄ່າ Android';

  @override
  String get protection_dialogTitle => 'ຕັ້ງຄ່າການປົກປ້ອງເຄືອຂ່າຍ';

  @override
  String get protection_dialogMessage =>
      'Android ຈັດການ VPN ເປີດຕະຫຼອດເວລາ ແລະ ການບລັອກການເຊື່ອມຕໍ່ນອກ VPN. ກະລຸນາກວດສອບວ່າ FuzeVPN ຖືກເລືອກຢູ່ ແລະ ເປີດການບລັອກໃນການຕັ້ງຄ່າລະບົບ.';

  @override
  String get protection_dialogOpen => 'ເປີດການຕັ້ງຄ່າ';

  @override
  String get session_systemProtectionNote =>
      'ຫາກ Android ຍັງບລັອກທຣາຟິກນອກ VPN ຢູ່, ກະລຸນາເປີດການຕັ້ງຄ່າລະບົບເພື່ອກວດສອບ ຫຼື ປ່ຽນການປົກປ້ອງນີ້.';

  @override
  String get diagnostics_title => 'ການວິນິດໄສ';

  @override
  String get diagnostics_settingsTitle => 'ການວິນິດໄສແອັບ';

  @override
  String get diagnostics_automaticTitle => 'ສົ່ງຂໍ້ຜິດພາດສຳຄັນ';

  @override
  String get diagnostics_automaticDescription =>
      'ແບ່ງປັນລາຍງານທາງເຕັກນິກສັ້ນໆ ເມື່ອເກີດຂໍ້ຜິດພາດສຳຄັນ.';

  @override
  String get diagnostics_privacy =>
      'ລາຍງານທີ່ສົ່ງແລ້ວຈະຖືກເຊື່ອມໂຍງກັບບັນຊີທີ່ເຂົ້າສູ່ລະບົບຢູ່ ແລະ ຈະເກັບໄວ້ 30 ວັນ. ລາຍງານເຫຼົ່ານີ້ບໍ່ມີປະຫວັດການທ່ອງເວັບ, ລະຫັດຜ່ານ ຫຼື ກະແຈ VPN.';

  @override
  String get diagnostics_manualOpen => 'ເລີ່ມການວິນິດໄສ';

  @override
  String get diagnostics_localDescription =>
      'ສ້າງລາຍງານສະຖານະຂອງແອັບ ແລະ VPN. ການເຊື່ອມຕໍ່ຂອງທ່ານຍັງຄົງເດີມ.';

  @override
  String get diagnostics_sendReport => 'ສົ່ງລາຍງານ';

  @override
  String get diagnostics_sendHint =>
      'ຫາກບໍ່ເລືອກຊ່ອງນີ້, ລາຍງານຈະຖືກເກັບໄວ້ໃນອຸປະກອນນີ້.';

  @override
  String get diagnostics_signedOut =>
      'ກະລຸນາເຂົ້າສູ່ລະບົບບັນຊີຂອງທ່ານເພື່ອສົ່ງລາຍງານ.';

  @override
  String get diagnostics_localLifetime =>
      'ບັນທຶກລາຍງານນີ້ໄວ້ໃນໂທລະສັບຂອງທ່ານ ເພື່ອໃຫ້ຍັງມີຢູ່ຫຼັງຈາກປິດແອັບ.';

  @override
  String get diagnostics_run => 'ເລີ່ມການວິນິດໄສ';

  @override
  String get diagnostics_rerun => 'ເລີ່ມການວິນິດໄສອີກຄັ້ງ';

  @override
  String get diagnostics_running => 'ກຳລັງກວດສອບ…';

  @override
  String get diagnostics_sending => 'ກຳລັງສົ່ງລາຍງານ…';

  @override
  String get diagnostics_prepared => 'ລາຍງານພ້ອມແລ້ວໃນອຸປະກອນນີ້';

  @override
  String get diagnostics_queued => 'ລາຍງານກຳລັງລໍຖ້າການສົ່ງ';

  @override
  String get diagnostics_sent => 'ໄດ້ຮັບລາຍງານແລ້ວ';

  @override
  String get diagnostics_failed =>
      'ການສົ່ງບໍ່ສຳເລັດ. ລາຍງານໃນອຸປະກອນຂອງທ່ານຍັງສາມາດໃຊ້ໄດ້.';

  @override
  String get diagnostics_preparationFailed =>
      'ບໍ່ສາມາດກຽມລາຍງານການວິນິດໄສໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get diagnostics_authenticationRequired =>
      'ກະລຸນາເຂົ້າສູ່ລະບົບອີກຄັ້ງເພື່ອສົ່ງລາຍງານ.';

  @override
  String get diagnostics_retry => 'ລອງສົ່ງໃໝ່';

  @override
  String get diagnostics_export => 'ບັນທຶກລາຍງານ';

  @override
  String get diagnostics_exportFailed =>
      'ການສົ່ງອອກບໍ່ສຳເລັດ. ກະລຸນາລອງໃໝ່ຈາກລາຍງານໃນອຸປະກອນ.';

  @override
  String get diagnostics_preferenceFailed =>
      'ບໍ່ສາມາດບັນທຶກການຕັ້ງຄ່ານີ້ໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String diagnostics_receipt(Object id) {
    return 'ເລກອ້າງອີງ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'ໄດ້ຮັບເມື່ອ $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'ເກັບໄວ້ຈົນເຖິງ $date';
  }

  @override
  String get diagnostics_duplicate => 'ລາຍງານນີ້ເຄີຍໄດ້ຮັບແລ້ວ.';

  @override
  String get diagnostics_preview => 'ຕົວຢ່າງລາຍງານ';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ມີເຫດການທາງເຕັກນິກແນບມາ $count ລາຍການ',
      one: 'ມີເຫດການທາງເຕັກນິກແນບມາ 1 ລາຍການ',
      zero: 'ບໍ່ມີເຫດການທາງເຕັກນິກແນບມາ',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'ລາຍລະອຽດທາງເຕັກນິກ';

  @override
  String get diagnostics_empty => 'ຍັງບໍ່ມີລາຍງານການວິນິດໄສທີ່ກຽມໄວ້.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ສະຖານະອຸໂມງ',
      'handshake': 'ການຢືນຢັນການເຊື່ອມຕໍ່',
      'certificate': 'ໃບຮັບຮອງ VPN',
      'kill_switch': 'ການປົກປ້ອງ Android',
      'connectivity': 'ເຄືອຂ່າຍທີ່ໃຊ້ໄດ້',
      'api_reachability': 'ການເຂົ້າເຖິງບໍລິການ',
      'secure_storage': 'ບ່ອນເກັບຂໍ້ມູນທີ່ປອດໄພ',
      'other': 'ການກວດສອບໃນເຄື່ອງ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'ກວດສອບແລ້ວ',
      'failed': 'ຄວນກວດສອບ',
      'skipped': 'ຍັງບໍ່ໄດ້ທົດສອບ — ບໍ່ມີການກວດສອບໂດຍກົງ',
      'unknown': 'ບໍ່ມີຂໍ້ມູນ',
      'other': 'ບໍ່ມີຂໍ້ມູນ',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'ຍິນດີຕ້ອນຮັບສູ່ FuzeVPN';

  @override
  String get connection_changeLocation => 'ປ່ຽນສະຖານທີ່';

  @override
  String get connection_details => 'ລາຍລະອຽດການເຊື່ອມຕໍ່';

  @override
  String get locations_searchLabel => 'ຄົ້ນຫາເມືອງ ຫຼື ປະເທດ';

  @override
  String get locations_clearSearch => 'ລ້າງການຄົ້ນຫາ';

  @override
  String get locations_filterAll => 'ທັງໝົດ';

  @override
  String get locations_filterFavorites => 'ລາຍການທີ່ມັກ';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ສະຖານທີ່',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'ບໍ່ພົບສະຖານທີ່';

  @override
  String get locations_noResultsHint => 'ລອງຄົ້ນຫາເມືອງ ຫຼື ປະເທດອື່ນ.';

  @override
  String get locations_noFavorites => 'ລາຍການທີ່ມັກຂອງທ່ານ ຢູ່ໃກ້ມືສະເໝີ';

  @override
  String get locations_noFavoritesHint =>
      'ແຕະດາວຂ້າງສະຖານທີ່ເພື່ອບັນທຶກໄວ້ບ່ອນນີ້.';

  @override
  String get locations_showAll => 'ເບິ່ງສະຖານທີ່ທັງໝົດ';

  @override
  String locations_addFavorite(String name) {
    return 'ເພີ່ມ $name ເຂົ້າລາຍການທີ່ມັກ';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'ລຶບ $name ອອກຈາກລາຍການທີ່ມັກ';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'ບໍ່ສາມາດບັນທຶກລາຍການທີ່ມັກໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get locations_emptyTitle => 'ບໍ່ມີສະຖານທີ່ໃຫ້ໃຊ້';

  @override
  String get locations_emptyHint => 'ກະລຸນາໂຫຼດລາຍການໃໝ່ເພື່ອລອງອີກຄັ້ງ.';

  @override
  String get devices_manage => 'ຈັດການອຸປະກອນຂອງຂ້ອຍ';

  @override
  String get settings_personalization => 'ປັບແຕ່ງຕາມໃຈທ່ານ';

  @override
  String get settings_safety => 'ການປົກປ້ອງ';

  @override
  String get settings_help => 'ຕ້ອງການຄວາມຊ່ວຍເຫຼືອບໍ?';

  @override
  String get settings_about => 'ກ່ຽວກັບ FuzeVPN';

  @override
  String get diagnostics_heading => 'ເຂົ້າໃຈບັນຫາການເຊື່ອມຕໍ່';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ພ້ອມໃຊ້ງານ',
      'pending': 'ກຳລັງກຽມ',
      'revoked': 'ຖືກລຶບອອກແລ້ວ',
      'expired': 'ໝົດອາຍຸແລ້ວ',
      'other': 'ບໍ່ມີຂໍ້ມູນສະຖານະ',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ບໍ່ໄດ້ບັນທຶກການຕັ້ງຄ່າ';

  @override
  String get notice_preferenceSave_message =>
      'ການເລືອກຂອງທ່ານຖືກນຳໃຊ້ຊົ່ວຄາວແລ້ວ, ແຕ່ບໍ່ສາມາດບັນທຶກໄດ້. ກະລຸນາລອງອີກຄັ້ງເພື່ອເກັບໄວ້ຫຼັງຈາກປິດແອັບ.';

  @override
  String get connection_androidDisconnectHint =>
      'ຖ້າ Android ຍັງເປີດ VPN ຢູ່, ກະລຸນາປິດ VPN ເປີດຕະຫຼອດເວລາໃນການຕັ້ງຄ່າທີ່ເປີດຂຶ້ນມາ.';

  @override
  String get protection_learnMore => 'ຮຽນຮູ້ກ່ຽວກັບການປົກປ້ອງ Android';

  @override
  String get protection_guideWhy =>
      'ການປົກປ້ອງນີ້ຈະບໍ່ໃຫ້ແອັບໃຊ້ອິນເຕີເນັດໂດຍກົງ ຖ້າ VPN ຕັດການເຊື່ອມຕໍ່. ຕັ້ງຄ່າໄດ້ໃນ Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN ເປີດຕະຫຼອດເວລາ';

  @override
  String get protection_guideAlwaysOn =>
      'Android ຮັກສາບໍລິການ VPN ໃຫ້ເຮັດວຽກຢູ່ ແລະ ສາມາດເລີ່ມມັນຄືນໃໝ່ໄດ້ຫຼັງຈາກໂທລະສັບເລີ່ມເຄື່ອງໃໝ່.';

  @override
  String get protection_guideBlockTitle => 'ບລັອກການເຊື່ອມຕໍ່ທີ່ບໍ່ມີ VPN';

  @override
  String get protection_guideBlock =>
      'ການຕັ້ງຄ່ານີ້ຈະບໍ່ໃຫ້ທຣາຟິກຜ່ານໄປນອກ VPN, ລວມທັງໃນຂະນະທີ່ການເຊື່ອມຕໍ່ຖືກຂັດຂວາງ.';

  @override
  String get protection_guideWarning =>
      'ເມື່ອເປີດການບລັອກນີ້, ການເຂົ້າເຖິງອິນເຕີເນັດຈະຖືກປິດໄວ້ ຈົນກວ່າ VPN ຈະເຊື່ອມຕໍ່ແລ້ວ.';

  @override
  String get protection_guideStepsTitle => 'ເປີດການປົກປ້ອງ';

  @override
  String get protection_guideStep1 =>
      'ເປີດການຕັ້ງຄ່າ VPN ຂອງ Android ດ້ວຍປຸ່ມຂ້າງລຸ່ມນີ້.';

  @override
  String get protection_guideStep2 =>
      'ເປີດຕົວເລືອກດ້ວຍໄອຄອນຮູບເຟືອງຢູ່ຂ້າງ FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'ເປີດ “VPN ເປີດຕະຫຼອດເວລາ” ຈາກນັ້ນເປີດ “ບລັອກການເຊື່ອມຕໍ່ທີ່ບໍ່ມີ VPN” ຖ້າມີຕົວເລືອກເຫຼົ່ານີ້.';

  @override
  String get protection_guideManufacturers =>
      'ຊື່ຕ່າງໆອາດແຕກຕ່າງກັນຕາມແຕ່ລະໂທລະສັບ. ຖ້າຈຳເປັນ ໃຫ້ຄົ້ນຫາ VPN ໃນການຕັ້ງຄ່າ ເຊິ່ງມັກຢູ່ໃນ “ເຄືອຂ່າຍ ແລະ ອິນເຕີເນັດ”.';

  @override
  String get protection_guideDisableTitle => 'ປິດການປົກປ້ອງນີ້';

  @override
  String get protection_guideDisable =>
      'ໃນການຕັ້ງຄ່າດຽວກັນ ໃຫ້ປິດການບລັອກການເຊື່ອມຕໍ່ທີ່ບໍ່ມີ VPN ເພື່ອໃຫ້ເຂົ້າອິນເຕີເນັດໄດ້ໂດຍບໍ່ໃຊ້ VPN. ນອກຈາກນີ້ ໃຫ້ປິດ VPN ເປີດຕະຫຼອດເວລາ ຖ້າທ່ານບໍ່ຕ້ອງການໃຫ້ Android ເລີ່ມມັນໃໝ່ອີກ.';

  @override
  String get protection_guideManual =>
      'ທ່ານກຳນົດການຕັ້ງຄ່າເຫຼົ່ານີ້ເອງໃນ Android. FuzeVPN ຈະບໍ່ປ່ຽນແປງການຕັ້ງຄ່າເຫຼົ່ານີ້ແທນທ່ານ.';

  @override
  String get locations_changeTitle => 'ປ່ຽນສະຖານທີ່ບໍ?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ຈະຕັດການເຊື່ອມຕໍ່ ຈາກນັ້ນພະຍາຍາມເຊື່ອມຕໍ່ກັບ $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN ຈະພະຍາຍາມເຊື່ອມຕໍ່ກັບ $name.';
  }

  @override
  String get locations_confirmChange => 'ປ່ຽນ ແລະ ເຊື່ອມຕໍ່';

  @override
  String get locations_changeBusy =>
      'ກຳລັງມີການປ່ຽນແປງຢູ່. ກະລຸນາລໍຖ້າກ່ອນເລືອກສະຖານທີ່ອື່ນ.';

  @override
  String get locations_automaticSelection => 'ເລືອກອັດຕະໂນມັດ';

  @override
  String get locations_cities => 'ເມືອງ';

  @override
  String get locations_servers => 'ເຊີບເວີ';

  @override
  String locations_viewCities(String name) {
    return 'ເບິ່ງເມືອງໃນ $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'ເບິ່ງເຊີບເວີໃນ $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ປະເທດ',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ເມືອງ',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ເຊີບເວີ',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ທຸກປະເທດ';

  @override
  String get locations_backToCountries => 'ກັບໄປຫາປະເທດ';

  @override
  String locations_backToCities(String name) {
    return 'ກັບໄປຫາເມືອງໃນ $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'ເລືອກ $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'ເລືອກ $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'ບໍ່ມີເຊີບເວີທີ່ເຂົ້າກັນໄດ້ໃຫ້ໃຊ້ງານ.';

  @override
  String get externalLink_failed =>
      'ບໍ່ສາມາດເປີດລິ້ງນີ້ໄດ້. ທ່ານສາມາດສຳເນົາລິ້ງ ແລ້ວເປີດໃນເວັບບຣາວເຊີຂອງທ່ານ.';

  @override
  String get externalLink_copy => 'ສຳເນົາລິ້ງ';

  @override
  String get externalLink_copied => 'ສຳເນົາລິ້ງແລ້ວ';

  @override
  String get externalLink_copyFailed =>
      'ບໍ່ສາມາດສຳເນົາລິ້ງໄດ້. ກະລຸນາເລືອກທີ່ຢູ່ຂ້າງລຸ່ມນີ້.';

  @override
  String get settings_deleteAccount => 'ລຶບບັນຊີຂອງຂ້ອຍ';

  @override
  String get settings_deleteAccountDetail => 'ເບິ່ງຂັ້ນຕອນການຮ້ອງຂໍລຶບບັນຊີ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'ເລືອກການສະໝັກໃຊ້ງານ VPN ຂອງທ່ານ.';

  @override
  String get billing_subscribe => 'ສະໝັກໃຊ້ງານ';

  @override
  String get billing_choosePlan => 'ເລືອກແຜນເພື່ອດຳເນີນການຕໍ່.';

  @override
  String get billing_monthly => 'ລາຍເດືອນ';

  @override
  String get billing_yearly => 'ລາຍປີ';

  @override
  String get billing_continue => 'ສືບຕໍ່ດ້ວຍ Google Play';

  @override
  String get billing_restore => 'ກູ້ຄືນການຊື້';

  @override
  String get billing_manage => 'ຈັດການການສະໝັກໃຊ້ງານ';

  @override
  String get billing_deleteAccountWarning =>
      'ຖ້າທ່ານມີການສະໝັກໃຊ້ງານ Google Play, ການລຶບບັນຊີ FuzeVPN ຂອງທ່ານຈະບໍ່ຍົກເລີກການຕໍ່ອາຍຸ. ກະລຸນາຈັດການ ຫຼື ຍົກເລີກການຕໍ່ອາຍຸແຍກຕ່າງຫາກໃນ Google Play.';

  @override
  String get billing_deleteAccountContinue => 'ສືບຕໍ່ໄປຫາການຮ້ອງຂໍລຶບບັນຊີ';

  @override
  String get billing_refresh => 'ໂຫຼດສິດການເຂົ້າເຖິງໃໝ່';

  @override
  String get billing_loadingPlans => 'ກຳລັງໂຫຼດແຜນ…';

  @override
  String get billing_unavailable =>
      'ຕອນນີ້ບໍ່ມີແຜນໃຫ້ໃຊ້ງານ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.';

  @override
  String get billing_comingSoon => 'ການສະໝັກໃຊ້ງານຈະມາໃນໄວໆນີ້.';

  @override
  String get billing_priceDisclosure =>
      'ລາຄາມາຈາກ Google Play. ຈຳນວນເງິນສຸດທ້າຍ ແລະ ພາສີທີ່ນຳໃຊ້ ຈະສະແດງໃຫ້ເຫັນກ່ອນທີ່ທ່ານຈະຢືນຢັນ.';

  @override
  String get billing_renewalMonthly =>
      'ຕໍ່ອາຍຸອັດຕະໂນມັດທຸກເດືອນ ເວັ້ນເສຍແຕ່ທ່ານຈະຍົກເລີກ. ທ່ານສາມາດຍົກເລີກໄດ້ທຸກເວລາໃນການສະໝັກໃຊ້ງານ Google Play.';

  @override
  String get billing_renewalYearly =>
      'ຕໍ່ອາຍຸອັດຕະໂນມັດທຸກປີ ເວັ້ນເສຍແຕ່ທ່ານຈະຍົກເລີກ. ທ່ານສາມາດຍົກເລີກໄດ້ທຸກເວລາໃນການສະໝັກໃຊ້ງານ Google Play.';

  @override
  String get billing_active => 'ການເຂົ້າເຖິງ Premium ຂອງທ່ານເປີດໃຊ້ງານແລ້ວ';

  @override
  String billing_accessUntil(String date) {
    return 'ເຂົ້າເຖິງໄດ້ຈົນເຖິງ $date.';
  }

  @override
  String get billing_webManaged =>
      'ການສະໝັກໃຊ້ງານຂອງທ່ານຖືກຈັດການຢູ່ເວັບໄຊ FuzeVPN.';

  @override
  String get billing_playManaged =>
      'ການສະໝັກໃຊ້ງານຂອງທ່ານຖືກຈັດການໂດຍ Google Play.';

  @override
  String get billing_playOnHold =>
      'ການສະໝັກໃຊ້ງານ Google Play ຂອງທ່ານຖືກພັກໄວ້ ຫຼື ກຳລັງລໍຖ້າການຊຳລະ. ເປີດ “ຈັດການການສະໝັກໃຊ້ງານ” ເພື່ອແກ້ໄຂໃນ Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'ບັນຊີ Google Play ນີ້ມີການສະໝັກໃຊ້ງານ Fuze Premium ຢູ່ແລ້ວ ເຊິ່ງບໍ່ໄດ້ເປີດໃຊ້ງານສຳລັບບັນຊີ FuzeVPN ນີ້. ເປີດ “ຈັດການການສະໝັກໃຊ້ງານ” ເພື່ອກວດສອບໃນ Google Play.';

  @override
  String get billing_inactive => 'ບໍ່ມີການສະໝັກໃຊ້ງານທີ່ຍັງມີຜົນ.';

  @override
  String get billing_checkingAccess => 'ກຳລັງກວດສອບການເຂົ້າເຖິງຂອງທ່ານ…';

  @override
  String get billing_restoring => 'ກຳລັງກູ້ຄືນການຊື້…';

  @override
  String get billing_pending =>
      'ການຊຳລະເງິນກຳລັງລໍຖ້າ. ການເຂົ້າເຖິງຂອງທ່ານຈະເປີດໃຊ້ງານຫຼັງຈາກຢືນຢັນແລ້ວ.';

  @override
  String get billing_cancelled =>
      'ຍົກເລີກການຊື້ແລ້ວ. ບໍ່ມີການສະໝັກໃຊ້ງານໃໝ່ຖືກເປີດໃຊ້ງານ.';

  @override
  String get billing_verifying => 'ກຳລັງກວດສອບການຊື້…';

  @override
  String get billing_success =>
      'ເປີດໃຊ້ການສະໝັກໃຊ້ງານແລ້ວ. ການເຂົ້າເຖິງ Premium ຂອງທ່ານພ້ອມແລ້ວ.';

  @override
  String get billing_restored => 'ການຊື້ຂອງທ່ານຖືກກູ້ຄືນແລ້ວ.';

  @override
  String get billing_restoreEmpty =>
      'ບໍ່ມີການຊື້ໃຫ້ກູ້ຄືນສຳລັບບັນຊີ Google Play ນີ້.';

  @override
  String get billing_catalogError => 'ບໍ່ສາມາດໂຫຼດແຜນໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get billing_purchaseError => 'ບໍ່ສາມາດເລີ່ມການຊື້ໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get billing_verificationError =>
      'ການກວດສອບການຊື້ບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ. ກະລຸນາກູ້ຄືນການຊື້ເພື່ອລອງໃໝ່.';

  @override
  String get billing_restoreError => 'ບໍ່ສາມາດກູ້ຄືນການຊື້ໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get billing_managementError =>
      'ບໍ່ສາມາດເປີດການຈັດການການສະໝັກໃຊ້ງານໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get billing_storeUnavailable =>
      'Google Play ບໍ່ພ້ອມໃຊ້ງານໃນອຸປະກອນນີ້.';

  @override
  String get welcome_title => 'ເຮັດໃຫ້ VPN ຂອງທ່ານງ່າຍດາຍ.';

  @override
  String get welcome_description =>
      'ປົກປ້ອງການເຊື່ອມຕໍ່ຂອງທ່ານ ແລະ ຄວບຄຸມຄວາມເປັນສ່ວນຕົວຂອງທ່ານ.';

  @override
  String get welcome_start => 'ເລີ່ມຕົ້ນ';

  @override
  String get welcome_alreadyPurchased => 'ຊື້ແລ້ວບໍ?';

  @override
  String get welcome_noAccountRequired => 'ບໍ່ຕ້ອງໃຊ້ບັນຊີເພື່ອເລີ່ມຕົ້ນ.';

  @override
  String get guest_accountTitle => 'ບັນຊີຍັງບໍ່ໄດ້ເຊື່ອມໂຍງ';

  @override
  String get guest_accountDescription =>
      'ກູ້ຄືນການຊື້ຂອງທ່ານດ້ວຍບັນຊີ Google Play ດຽວກັນ ເພື່ອໃຊ້ການສະໝັກໃຊ້ງານຂອງທ່ານໃນອຸປະກອນອື່ນ.';

  @override
  String get guest_existingSubscriberSignIn =>
      'ສະໝັກໃຊ້ງານແລ້ວບໍ? ເຂົ້າສູ່ລະບົບ';

  @override
  String get guest_claimTitle => 'ເອົາ FuzeVPN ໄປກັບທ່ານ';

  @override
  String get guest_claimDescription =>
      'ສ້າງບັນຊີເພື່ອເຂົ້າເຖິງການສະໝັກໃຊ້ງານຂອງທ່ານໃນອຸປະກອນອື່ນໆ. ຂັ້ນຕອນນີ້ບໍ່ບັງຄັບ.';

  @override
  String get guest_skip => 'ໄວ້ພາຍຫຼັງ';

  @override
  String get guest_activationTitle => 'Fuze Premium ເປີດໃຊ້ງານແລ້ວ';

  @override
  String get guest_activationDescription =>
      'ການສະໝັກໃຊ້ງານຂອງທ່ານພ້ອມແລ້ວ. ທ່ານສາມາດໃຊ້ VPN ແລະ ສ້າງບັນຊີເມື່ອໃດກໍໄດ້ທີ່ທ່ານຕ້ອງການ.';

  @override
  String get guest_useVpn => 'ໃຊ້ VPN ຂອງຂ້ອຍ';

  @override
  String get guest_loginRequired =>
      'ການຊື້ນີ້ເຊື່ອມໂຍງກັບບັນຊີ FuzeVPN ແລ້ວ. ກະລຸນາເຂົ້າສູ່ລະບົບບັນຊີນັ້ນເພື່ອເຂົ້າເຖິງການສະໝັກໃຊ້ງານຂອງທ່ານ.';

  @override
  String get guest_signOutWarning =>
      'ທ່ານສາມາດກູ້ຄືນການສະໝັກໃຊ້ງານໄດ້ໂດຍກູ້ຄືນການຊື້ດ້ວຍບັນຊີ Google Play ດຽວກັນ.';

  @override
  String get guest_profileUnavailable =>
      'ບັນຊີຂອງທ່ານເຊື່ອມໂຍງແລ້ວ. ກະລຸນາເຂົ້າສູ່ລະບົບເພື່ອເບິ່ງ ແລະ ຈັດການຂໍ້ມູນຂອງທ່ານ.';

  @override
  String get billing_acceptance =>
      'ເມື່ອສືບຕໍ່, ທ່ານຍອມຮັບເງື່ອນໄຂການໃຊ້ງານ ແລະ ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ.';

  @override
  String get guest_verifyEmailReminder =>
      'ກະລຸນາຢືນຢັນທີ່ຢູ່ອີເມວຂອງທ່ານເພື່ອຮັກສາຄວາມປອດໄພບັນຊີ. ທ່ານສາມາດສືບຕໍ່ໃຊ້ VPN ໄດ້.';

  @override
  String get guest_serviceUnavailable =>
      'ບໍລິການບໍ່ພ້ອມໃຊ້ງານຊົ່ວຄາວ. ກະລຸນາລອງໃໝ່ໃນບໍ່ດົນນີ້.';

  @override
  String get guest_restoreError =>
      'ບໍ່ສາມາດກູ້ຄືນການຊື້ຂອງທ່ານໄດ້. ກະລຸນາລອງໃໝ່ດ້ວຍບັນຊີ Google Play ທີ່ໃຊ້ໃນການຊື້.';

  @override
  String get guest_claimSuccess =>
      'ສ້າງບັນຊີຂອງທ່ານແລ້ວ. ການສະໝັກໃຊ້ງານ ແລະ ການເຂົ້າເຖິງ VPN ຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get guest_emailExists =>
      'ອີເມວນີ້ຖືກໃຊ້ແລ້ວ. ກະລຸນາເລືອກທີ່ຢູ່ອື່ນ ຫຼື ເຂົ້າສູ່ລະບົບບັນຊີທີ່ມີຢູ່ແລ້ວ. ການຊື້ຂອງທ່ານຍັງສາມາດໃຊ້ໄດ້ຜ່ານ Google Play.';

  @override
  String get guest_claimError =>
      'ບໍ່ສາມາດສ້າງບັນຊີຂອງທ່ານໄດ້. ທ່ານສາມາດສືບຕໍ່ໃຊ້ VPN ແລະ ລອງໃໝ່ໃນພາຍຫຼັງ.';

  @override
  String get guest_secureStorageError =>
      'ບໍ່ສາມາດຮັກສາຄວາມປອດໄພເຊດຊັນຂອງທ່ານໃນອຸປະກອນນີ້ໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get guest_premiumRequired =>
      'ເລືອກການສະໝັກໃຊ້ງານເພື່ອເປີດໃຊ້ VPN ຂອງທ່ານ.';

  @override
  String get welcome_viewPlans => 'ເບິ່ງແຜນ';

  @override
  String get google_continue => 'ສືບຕໍ່ດ້ວຍ Google';

  @override
  String get google_or => 'ຫຼື';

  @override
  String get google_title => 'ບັນຊີ FuzeVPN ຂອງທ່ານ';

  @override
  String get google_settingUp => 'ສ້າງບັນຊີຂອງທ່ານໃຫ້ສຳເລັດ';

  @override
  String get google_country => 'ປະເທດທີ່ອາໄສຢູ່';

  @override
  String get google_profileDescription =>
      'ເລືອກປະເທດຂອງທ່ານ ແລະ ກວດສອບເອກະສານທັງສອງສະບັບເພື່ອສ້າງບັນຊີ FuzeVPN ຂອງທ່ານ.';

  @override
  String get google_claimDescription =>
      'ເຊື່ອມໂຍງບັນຊີແຂກຂອງທ່ານກັບ Google. ການສະໝັກໃຊ້ງານ ແລະ ອຸປະກອນຂອງທ່ານຍັງຄົງຜູກກັບບັນຊີນີ້.';

  @override
  String get google_linkTitle => 'ເຊື່ອມໂຍງ Google ກັບ FuzeVPN';

  @override
  String get google_linkDescription =>
      'ຢືນຢັນການເຂົ້າເຖິງບັນຊີ FuzeVPN ທີ່ມີຢູ່ແລ້ວຂອງທ່ານ. ຂັ້ນຕອນນີ້ຈະບໍ່ຂໍລະຫັດຜ່ານ Google ຂອງທ່ານ.';

  @override
  String get google_password => 'ລະຫັດຜ່ານ FuzeVPN';

  @override
  String get google_linkAccount => 'ຢືນຢັນການເຊື່ອມໂຍງ';

  @override
  String get google_requestEmail => 'ສົ່ງອີເມວຢືນຢັນໃຫ້ຂ້ອຍ';

  @override
  String get google_emailInstructions =>
      'ເປີດອີເມວຈາກ FuzeVPN ແລ້ວປ້ອນລະຫັດຢືນຢັນ.';

  @override
  String get google_emailCode => 'ລະຫັດຢືນຢັນທາງອີເມວ';

  @override
  String get google_confirmEmail => 'ຢືນຢັນລະຫັດ';

  @override
  String get google_restart => 'ເລືອກບັນຊີ Google ອື່ນ';

  @override
  String get google_resume => 'ກວດສອບການພະຍາຍາມນີ້';

  @override
  String get google_unavailable =>
      'ການເຂົ້າສູ່ລະບົບດ້ວຍ Google ບໍ່ພ້ອມໃຊ້ງານ. ທ່ານສາມາດໃຊ້ອີເມວ ແລະ ລະຫັດຜ່ານໄດ້.';

  @override
  String get google_expired =>
      'ການພະຍາຍາມນີ້ໝົດອາຍຸແລ້ວ. ກະລຸນາຍົກເລີກ ແລ້ວເລີ່ມໃໝ່.';

  @override
  String get google_conflict =>
      'ບັນຊີ Google ນີ້ຖືກເຊື່ອມໂຍງຢູ່ບ່ອນອື່ນແລ້ວ. ບັນຊີ ແລະ ການສະໝັກໃຊ້ງານປັດຈຸບັນຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get google_error =>
      'ການເຂົ້າສູ່ລະບົບດ້ວຍ Google ລົ້ມເຫຼວ. ກະລຸນາລອງໃໝ່. ການເຂົ້າເຖິງປັດຈຸບັນຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get google_uncertain =>
      'ບໍ່ສາມາດຢືນຢັນຜົນໄດ້. ກະລຸນາກວດສອບການພະຍາຍາມນີ້ ຫຼື ຍົກເລີກກ່ອນເລີ່ມໃໝ່.';

  @override
  String get google_cancelFailed =>
      'ບໍ່ສາມາດຢືນຢັນການຍົກເລີກໄດ້. ກະລຸນາລອງຍົກເລີກອີກຄັ້ງກ່ອນອອກຈາກໜ້ານີ້.';

  @override
  String get google_cancelled => 'ຍົກເລີກການເຂົ້າສູ່ລະບົບດ້ວຍ Google ແລ້ວ.';

  @override
  String get google_selecting => 'ເລືອກບັນຊີ Google ຂອງທ່ານ…';

  @override
  String get google_verifying => 'ກຳລັງກວດສອບບັນຊີຂອງທ່ານ…';

  @override
  String get google_emailUnavailable =>
      'ບໍ່ສາມາດສົ່ງອີເມວຢືນຢັນໄດ້. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.';

  @override
  String get google_emailSent =>
      'ສົ່ງອີເມວຢືນຢັນແລ້ວ. ກະລຸນາກວດສອບກ່ອງຈົດໝາຍຂອງທ່ານ.';

  @override
  String get google_rateLimited => 'ກະລຸນາລໍຖ້າກ່ອນລອງໃໝ່.';

  @override
  String get google_busy =>
      'Google ບໍ່ພ້ອມໃຊ້ງານໃນຂະນະທີ່ມີການດຳເນີນການອື່ນຢູ່ (ການເຊື່ອມຕໍ່ VPN, ບັນຊີ ຫຼື ແຂກ). ກະລຸນາລອງໃໝ່ເມື່ອການດຳເນີນການນັ້ນສຳເລັດແລ້ວ. ການເຂົ້າເຖິງປັດຈຸບັນຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get google_invalidPassword =>
      'ລະຫັດຜ່ານ FuzeVPN ບໍ່ຖືກຕ້ອງ. ບັນຊີປັດຈຸບັນຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get google_invalidCode => 'ລະຫັດຢືນຢັນບໍ່ຖືກຕ້ອງ ຫຼື ໝົດອາຍຸແລ້ວ.';

  @override
  String get google_accountChanged =>
      'ເຊດຊັນຂອງທ່ານປ່ຽນແປງແລ້ວ. ກະລຸນາຍົກເລີກການພະຍາຍາມນີ້ກ່ອນເລີ່ມໃໝ່.';

  @override
  String get google_invalidResponse =>
      'ບໍ່ສາມາດກວດສອບການຕອບກັບໄດ້. ການເຂົ້າເຖິງປັດຈຸບັນຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get google_invalidRegistration =>
      'ກະລຸນາກວດສອບປະເທດ ແລະ ການຍິນຍອມທັງສອງຢ່າງຂອງທ່ານ.';

  @override
  String get google_consentRequired =>
      'ກະລຸນາເລືອກປະເທດຂອງທ່ານ ແລະ ຍອມຮັບເອກະສານທັງສອງສະບັບເພື່ອດຳເນີນການຕໍ່.';

  @override
  String get google_challengeRequired =>
      'ຕ້ອງມີການກວດສອບຄວາມປອດໄພເພີ່ມເຕີມ. ການເຂົ້າເຖິງປັດຈຸບັນຂອງທ່ານຍັງຄົງຢູ່.';

  @override
  String get google_challengeUnavailable =>
      'ການກວດສອບຄວາມປອດໄພບໍ່ພ້ອມໃຊ້ງານ. ກະລຸນາລອງໃໝ່ໃນພາຍຫຼັງ.';

  @override
  String get google_intentMismatch =>
      'ການພະຍາຍາມເຂົ້າສູ່ລະບົບດ້ວຍ Google ກ່ອນໜ້ານີ້ຍັງລໍຖ້າຢູ່. ກະລຸນາຍົກເລີກກ່ອນເລີ່ມການດຳເນີນການນີ້.';

  @override
  String get google_challengeBlocked =>
      'ການກວດສອບຄວາມປອດໄພທີ່ຕ້ອງການບໍ່ມີໃຫ້ໃນແອັບນີ້. ການດຳເນີນການນີ້ບໍ່ສາມາດສຳເລັດໄດ້ໃນຕອນນີ້.';

  @override
  String get google_solveChallenge => 'ດຳເນີນການກວດສອບຄວາມປອດໄພ';

  @override
  String get google_challengeTitle => 'ການກວດສອບຄວາມປອດໄພ';

  @override
  String get google_challengeReady =>
      'ການຢືນຢັນສຳເລັດແລ້ວ. ທ່ານສາມາດຢືນຢັນການສ້າງບັນຊີຂອງທ່ານໄດ້ດຽວນີ້.';

  @override
  String get google_challengeExpired =>
      'ການຢືນຢັນໝົດອາຍຸແລ້ວ. ກະລຸນາດຳເນີນການອີກຄັ້ງກ່ອນຢືນຢັນ.';

  @override
  String get google_challengeCancelled =>
      'ຍົກເລີກການຢືນຢັນແລ້ວ. ທ່ານສາມາດລອງໃໝ່ໄດ້.';

  @override
  String get google_challengeFailed =>
      'ການກວດສອບຄວາມປອດໄພລົ້ມເຫຼວ. ກະລຸນາລອງໃໝ່.';

  @override
  String get billing_trialTitle => 'ທົດລອງໃຊ້ Fuze Premium ຟຣີ';

  @override
  String get billing_trialSubtitle =>
      'ປົກປ້ອງການເຊື່ອມຕໍ່ຂອງທ່ານຕັ້ງແຕ່ມື້ນີ້.';

  @override
  String get billing_trialWeeks => 'ທົດລອງໃຊ້ຟຣີ 2 ອາທິດ';

  @override
  String billing_trialDays(String days) {
    return 'ທົດລອງໃຊ້ຟຣີ $days ວັນ';
  }

  @override
  String get billing_trialStart => 'ເລີ່ມການທົດລອງໃຊ້ຟຣີ';

  @override
  String billing_trialFirstCharge(String date) {
    return 'ຖ້າທ່ານເລີ່ມມື້ນີ້, ຄາດວ່າຈະເກັບເງິນຄັ້ງທຳອິດໃນວັນທີ $date.';
  }

  @override
  String get billing_trialTerms =>
      'ຕໍ່ອາຍຸອັດຕະໂນມັດໃນລາຄາທີ່ລະບຸໄວ້. ເພື່ອຫຼີກລ່ຽງການຖືກເກັບເງິນ ກະລຸນາຍົກເລີກໃນ Google Play ກ່ອນການທົດລອງໃຊ້ໝົດລົງ.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'ຫຼັງຈາກນັ້ນ $price ຕໍ່ເດືອນ';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'ຫຼັງຈາກນັ້ນ $price ຕໍ່ປີ';
  }

  @override
  String get billing_choosePeriod => 'ເລືອກແຜນຂອງທ່ານ';

  @override
  String get billing_selectionHint => 'ເລືອກແຜນເພື່ອດຳເນີນການຕໍ່.';

  @override
  String get billing_benefitConnection => 'ການເຊື່ອມຕໍ່ທີ່ເຂົ້າລະຫັດ';

  @override
  String get billing_benefitPrivacy => 'ຄວາມເປັນສ່ວນຕົວອອນລາຍ';

  @override
  String get billing_benefitNoAccount => 'ບໍ່ຕ້ອງລົງທະບຽນ';

  @override
  String get billing_cancellation => 'ຍົກເລີກໃນ Google Play';

  @override
  String get billing_premiumTitle => 'ການເຊື່ອມຕໍ່ທີ່ປອດໄພກວ່າເກົ່າ.';

  @override
  String get billing_premiumSubtitle =>
      'ປົກປ້ອງການເຊື່ອມຕໍ່ຂອງທ່ານ ຕາມຈັງຫວະຂອງທ່ານ.';

  @override
  String get billing_priceMonthly => 'ຕໍ່ເດືອນ';

  @override
  String get billing_priceYearly => 'ຕໍ່ປີ';

  @override
  String get billing_trialToday => 'ມື້ນີ້ບໍ່ຕ້ອງຊຳລະຫຍັງ';

  @override
  String get billing_trialConfirmation =>
      'Google Play ຈະຢືນຢັນວັນທີ, ຈຳນວນເງິນສຸດທ້າຍ ແລະ ພາສີທີ່ນຳໃຊ້ ກ່ອນທີ່ທ່ານຈະຢືນຢັນ.';

  @override
  String get billing_offerChanged =>
      'ເງື່ອນໄຂຂອງໂປຣໂມຊັນນີ້ປ່ຽນແປງແລ້ວ. ກະລຸນາໂຫຼດແຜນໃໝ່ ແລ້ວເລືອກອີກຄັ້ງ.';

  @override
  String get status_waitingNetwork => 'ກຳລັງລໍຖ້າເຄືອຂ່າຍ';

  @override
  String get status_waitingNetworkDetail =>
      'ບໍ່ມີເຄືອຂ່າຍໃຫ້ໃຊ້ງານ. VPN ຈະກວດສອບການເຊື່ອມຕໍ່ເມື່ອເຄືອຂ່າຍກັບມາ.';

  @override
  String get locations_favoriteLoadFailed =>
      'ບໍ່ສາມາດໂຫຼດລາຍການທີ່ມັກໄດ້. ກະລຸນາລອງໃໝ່.';

  @override
  String get locations_favoritesLoading => 'ກຳລັງໂຫຼດລາຍການທີ່ມັກ…';
}
