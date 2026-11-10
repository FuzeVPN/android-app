// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Igbo (`ig`).
class AppLocalizationsIg extends AppLocalizations {
  AppLocalizationsIg([String locale = 'ig']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Chebe njikọ gị';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN na-eji ọrụ VPN nke Android (VpnService) mepụta tunnel e zoro ezo n’etiti ngwaọrụ a na sava FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Mgbe VPN na-arụ ọrụ, data ịntanetị nke ngwa gị, adreesị ebe ha na-aga na arịrịọ DNS na-agafe site na tunnel a iji duzie njikọ gị, ọ bụlagodi mgbe FuzeVPN nọ n’azụ.';

  @override
  String get vpnDisclosure_statusBody =>
      'Ngwa a na-eji ọnọdụ njikọ, ogologo oge ọ dị na ọnụọgụ data e bufere iji gosi njikọ VPN gị. Ị nwere ike ịkwụsị ya mgbe ọ bụla.';

  @override
  String get vpnDisclosure_privacy => 'Nzuzo';

  @override
  String get vpnDisclosure_accept => 'Nabata ma gaa n’ihu';

  @override
  String get vpnDisclosure_decline => 'Ọ bụghị ugbu a';

  @override
  String get accountRestoration_title => 'Akaụntụ adịghị dị nwa oge';

  @override
  String get accountRestoration_message =>
      'Echekwara oge ịbanye gị. Nwaa ọzọ iji weghachi akaụntụ gị; ị ka nwere ike ijikwa njikọ VPN ebe a.';

  @override
  String get action_retry => 'Nwaa ọzọ';

  @override
  String get session_endingTitle => 'Na-akwụsị oge ịbanye';

  @override
  String get session_ending =>
      'Na-akwụsị oge ịbanye: na-akwụsị VPN ma na-ehicha ihe fọdụrụ…';

  @override
  String get session_stopFailed =>
      'Akwadoghị na VPN akwụsịla. Nwaa ọzọ tupu ị banye ọzọ.';

  @override
  String get session_cleanupFailed =>
      'VPN akwụsịla, mana akwadoghị iwepụ oge ịbanye. Nwaa ihicha ọzọ.';

  @override
  String get session_retryStop => 'Nwaa ịkwụsị ọzọ';

  @override
  String get session_retryCleanup => 'Nwaa ihicha ọzọ';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Na-akwadebe FuzeVPN n’ụzọ dị nchekwa…';

  @override
  String get nav_connection => 'Njikọ';

  @override
  String get nav_locations => 'Ebe';

  @override
  String get nav_account => 'Akaụntụ';

  @override
  String get nav_devices => 'Ngwaọrụ';

  @override
  String get nav_settings => 'Ntọala';

  @override
  String get action_refresh => 'Melite';

  @override
  String get auth_tab_login => 'Banye n’akaụntụ';

  @override
  String get auth_tab_register => 'Debanye aha';

  @override
  String get auth_stepAccount => 'Akaụntụ';

  @override
  String get auth_stepIdentity => 'Njirimara';

  @override
  String get auth_stepAddress => 'Adreesị na nkwekọrịta';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Nzọụkwụ $current n’ime $total';
  }

  @override
  String get auth_tagline => 'VPN gị, dị mfe.';

  @override
  String get auth_keysLocal => 'Igodo VPN nzuzo gị na-anọgide na ngwaọrụ a.';

  @override
  String get form_email => 'Adreesị e-mail';

  @override
  String get form_password => 'Paswọọdụ';

  @override
  String get form_showPassword => 'Gosi paswọọdụ';

  @override
  String get form_hidePassword => 'Zoo paswọọdụ';

  @override
  String get form_passwordMin =>
      '8–72 byte UTF-8. Mkpụrụedemede ụfọdụ na-eji karịa otu byte.';

  @override
  String get form_firstName => 'Aha mbụ';

  @override
  String get form_lastName => 'Aha ikpeazụ';

  @override
  String get form_phone => 'Ekwentị (+33612345678)';

  @override
  String get form_address => 'Adreesị';

  @override
  String get form_address2 => 'Ahịrị adreesị nke abụọ (nhọrọ)';

  @override
  String get form_postalCode => 'Koodu ozi';

  @override
  String get form_city => 'Obodo';

  @override
  String get form_country => 'Koodu mba (dịka ọmụmaatụ FR)';

  @override
  String get action_login => 'Banye n’akaụntụ';

  @override
  String get action_createAccount => 'Mepụta akaụntụ';

  @override
  String get action_createMyAccount => 'Mepụta akaụntụ m';

  @override
  String get action_next => 'Gaa n’ihu';

  @override
  String get action_previous => 'Laghachi azụ';

  @override
  String get action_forgotPassword => 'Chefuru paswọọdụ?';

  @override
  String get auth_noAccount => 'Ị nwebeghị akaụntụ?';

  @override
  String get auth_requiredInformation =>
      'Mepụta akaụntụ gị site na nzọụkwụ atọ.';

  @override
  String get auth_termsPrefix => 'Anabatara m ';

  @override
  String get auth_termsLink => 'ụkpụrụ ojiji';

  @override
  String get auth_privacyPrefix => 'Anabatara m ';

  @override
  String get auth_privacyLink => 'iwu nzuzo';

  @override
  String get auth_consentRequired => 'Nkwenye gị dị mkpa iji mepụta akaụntụ.';

  @override
  String get validation_required => 'Ebe a dị mkpa.';

  @override
  String get validation_email => 'Tinye adreesị e-mail ziri ezi.';

  @override
  String get validation_password =>
      'Paswọọdụ dị mkpụmkpụ nke ukwuu: opekata mpe byte UTF-8 dị 8.';

  @override
  String get validation_passwordTooLong =>
      'Paswọọdụ dị ogologo nke ukwuu: byte UTF-8 dị 72 kachasị.';

  @override
  String get validation_phone =>
      'Jiri usoro mba ụwa niile, dịka ọmụmaatụ +33612345678.';

  @override
  String get validation_country =>
      'Jiri koodu mba nwere mkpụrụedemede abụọ, dịka ọmụmaatụ FR.';

  @override
  String get passwordReset_title => 'Tọgharịa paswọọdụ';

  @override
  String get passwordReset_description =>
      'Tinye adreesị e-mail akaụntụ gị iji rịọ njikọ ịtọgharị paswọọdụ.';

  @override
  String get passwordReset_send => 'Zipụ njikọ';

  @override
  String get connection_title => 'Njikọ gị';

  @override
  String get connection_subtitle => 'Họrọ ebe, mgbe ahụ gbanye VPN gị.';

  @override
  String get connection_prepare => 'Ị dị njikere ijikọ?';

  @override
  String get connection_advancedOptions => 'Nhọrọ dị elu';

  @override
  String get connection_location => 'Ebe';

  @override
  String get connection_chooseLocation => 'Họrọ ebe';

  @override
  String get connection_protocol => 'Usoro';

  @override
  String get connection_connect => 'Jikọọ';

  @override
  String get connection_connecting => 'Na-ejikọ…';

  @override
  String get connection_disconnect => 'Kwụsị njikọ';

  @override
  String get connection_disconnecting => 'Na-akwụsị njikọ';

  @override
  String get connection_locationChange => 'Na-agbanwe ebe…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol adịghị dị';
  }

  @override
  String get connection_activeLocation => 'Ebe na-arụ ọrụ';

  @override
  String get connection_duration => 'Ogologo oge';

  @override
  String get connection_received => 'Natara';

  @override
  String get connection_sent => 'Ezipụrụ';

  @override
  String get connection_lastHandshake => 'Mgbanwe ozi dị nchekwa ikpeazụ';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration gara aga';
  }

  @override
  String get verification_title => 'Kwado adreesị e-mail gị';

  @override
  String get verification_message =>
      'Kwado adreesị e-mail gị ka ị nwee ike iji VPN na ekwentị a.';

  @override
  String get verification_resend => 'Zipụ e-mail ọzọ';

  @override
  String get migration_title => 'Mgbanwe ebe';

  @override
  String get migration_draining => 'Na-akwadebe mgbanwe ebe…';

  @override
  String get migration_activating => 'Na-eme ka sava ọhụrụ rụọ ọrụ…';

  @override
  String get migration_ready => 'Agbanwere ebe.';

  @override
  String get migration_blocked =>
      'Mgbanwe ebe chọrọ ka e tinye aka n’akụkụ sava. Nwaa ọzọ mgbe e mesịrị ma ọ bụ kpọtụrụ ndị nkwado.';

  @override
  String get migration_progress => 'Ọganihu mgbanwe ebe';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Oge dị n’etiti nyocha: $seconds sekọnd.';
  }

  @override
  String get migration_resume => 'Gaa n’ihu na mgbanwe ebe';

  @override
  String get status_authorizing => 'Achọrọ ikike';

  @override
  String get status_authorizingDetail =>
      'Nabata arịrịọ Android iji kwe ka VPN rụọ ọrụ.';

  @override
  String get status_preparing => 'Na-akwadebe';

  @override
  String get status_preparingDetail => 'Na-akwadebe njikọ gị dị nchekwa.';

  @override
  String get status_reconnecting => 'Na-ejikọ ọzọ…';

  @override
  String get status_reconnectingDetail =>
      'Njikọ kwụsịrị. VPN na-anwa ijikọ ọzọ.';

  @override
  String get status_connecting => 'Na-ejikọ';

  @override
  String get status_connectingDetail => 'Na-ejikọ na sava VPN…';

  @override
  String get status_connected => 'Ejikọrọ';

  @override
  String get status_connectedDetail => 'Njikọ VPN gị na-arụ ọrụ.';

  @override
  String get status_disconnecting => 'Na-akwụsị njikọ';

  @override
  String get status_disconnectingDetail => 'Njikọ VPN gị na-akwụsị.';

  @override
  String get status_error => 'Njikọ adịghị dị';

  @override
  String get status_errorDetail => 'Akwadoghị njikọ VPN. Nwaa ọzọ.';

  @override
  String get status_idle => 'Ejikọghị';

  @override
  String get status_idleDetail => 'Jikọọ VPN iji chebe njikọ gị.';

  @override
  String get trust_note =>
      'Imechi ngwa a anaghị akwụsị VPN. Iji kwụsị ya, jiri “Kwụsị njikọ”.';

  @override
  String get locations_none => 'Enweghị ebe dị ugbu a.';

  @override
  String get locations_available => 'Họrọ ebe ọzọ ị chọrọ ịga.';

  @override
  String get locations_selected => 'Ebe ahọpụtara';

  @override
  String get locations_select => 'Họrọ ebe a';

  @override
  String get locations_lockedTunnel => 'Kwụsị njikọ VPN iji gbanwee ebe.';

  @override
  String get locations_lockedMigration => 'Chere ka mgbanwe ebe gwụchaa.';

  @override
  String get devices_title => 'Ngwaọrụ gị';

  @override
  String devices_used(Object count, Object limit) {
    return 'Ngwaọrụ $count n’ime $limit';
  }

  @override
  String get devices_refresh => 'Melite ngwaọrụ';

  @override
  String get devices_empty => 'Enweghị ngwaọrụ VPN e debanyere aha ruo ugbu a.';

  @override
  String get devices_firstConnection =>
      'A ga-agbakwunye ekwentị gị n’oge njikọ mbụ.';

  @override
  String get devices_thisDevice => 'Ngwaọrụ a';

  @override
  String devices_added(Object date) {
    return 'Agbakwunyere na $date';
  }

  @override
  String get devices_unnamed => 'Ngwaọrụ na-enweghị aha';

  @override
  String get action_remove => 'Wepụ';

  @override
  String get settings_title => 'Ntọala';

  @override
  String get settings_subtitle => 'Nhọrọ gị na akaụntụ gị niile n’otu ebe.';

  @override
  String get settings_appearance => 'Ọdịdị';

  @override
  String get settings_language => 'Asụsụ';

  @override
  String get settings_languageDescription =>
      'Asụsụ ị họọrọ na-emetụtakwa ọkwa VPN.';

  @override
  String get settings_account => 'Akaụntụ';

  @override
  String get settings_signOut => 'Pụọ n’akaụntụ';

  @override
  String get settings_privacy => 'Iwu nzuzo';

  @override
  String get settings_terms => 'Ụkpụrụ ojiji';

  @override
  String get settings_security => 'Nchekwa na ịdị doro anya';

  @override
  String get settings_licenses => 'Ikike ojiji nke akụkụ ngwa';

  @override
  String get settings_licensesDetail => 'Sọftụwia e ji na ngwa a';

  @override
  String settings_licensesLegalese(String url) {
    return 'Koodu isi mmalite nke ngwa a na akụkụ ya dị n’okpuru MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN na-anọgide na-arụ ọrụ mgbe ị hapụrụ ngwa a. Iji kwụsị ya, jiri “Kwụsị njikọ” na taabụ Njikọ.';

  @override
  String get theme_system => 'Sistemu';

  @override
  String get theme_light => 'Ọcha';

  @override
  String get theme_dark => 'Ọchịchịrị';

  @override
  String get language_system => 'Asụsụ ekwentị';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Wepụ ngwaọrụ a?';

  @override
  String get dialog_removeCurrent =>
      'Ekwentị a ga-akwụsị njikọ VPN ma ghara inwe ike inweta ya ọzọ. A ga-ewepụ data njikọ VPN ya mgbe sava kwadoro.';

  @override
  String dialog_removeOther(Object name) {
    return 'A ga-akagbu inweta VPN nke “$name”. Enweghị ike ịlaghachi azụ.';
  }

  @override
  String get dialog_signOut => 'Pụọ n’akaụntụ?';

  @override
  String get dialog_signOutMessage =>
      'VPN ga-akwụsị, ị ga-achọkwa ịbanye ọzọ. Igodo VPN gị e zoro ezo ga-anọgide na ekwentị a maka njikọ gị ọzọ.';

  @override
  String get action_cancel => 'Kagbuo';

  @override
  String get action_close => 'Mechie';

  @override
  String get action_copy => 'Depụta';

  @override
  String get action_signOut => 'Pụọ n’akaụntụ';

  @override
  String get notice_close => 'Mechie ozi';

  @override
  String get notice_sessionExpired_title => 'Oge ịbanye agwụla';

  @override
  String get notice_sessionExpired_message =>
      'Oge ịbanye gị agwụla. Banye ọzọ.';

  @override
  String get notice_connectionFailed_title => 'Njikọ dara';

  @override
  String get notice_invalidCredentials_message =>
      'Adreesị e-mail ma ọ bụ paswọọdụ ezighị ezi.';

  @override
  String get notice_emailVerification_title => 'Achọrọ nkwado e-mail';

  @override
  String get notice_emailVerification_message =>
      'Kwado adreesị e-mail gị tupu ịgbakwunye ngwaọrụ VPN.';

  @override
  String get notice_rateLimited_title => 'Mbọ gafere oke';

  @override
  String get notice_deviceLimit_title => 'Oke ngwaọrụ eruola';

  @override
  String get notice_deviceLimit_message =>
      'Wepụ ngwaọrụ dị adị tupu ịgbakwunye ọzọ.';

  @override
  String get notice_identityRenewal_title => 'Achọrọ imegharị njirimara VPN';

  @override
  String get notice_identityRenewal_message =>
      'Ewepụla njirimara a. Mepụta njirimara ọhụrụ na ngwaọrụ a.';

  @override
  String get notice_migrationPending_title => 'Mgbanwe ebe na-aga n’ihu';

  @override
  String get notice_migrationPending_message =>
      'Mgbanwe ebe na-aga n’ihu ugbu a.';

  @override
  String get notice_migrationBlocked_title => 'Egbochiri mgbanwe ebe';

  @override
  String get notice_migrationBlocked_message =>
      'Mgbanwe ebe chọrọ ka e tinye aka n’akụkụ sava. Nwaa ọzọ mgbe e mesịrị ma ọ bụ kpọtụrụ ndị nkwado.';

  @override
  String get notice_targetUnavailable_title => 'Sava adịghị dị nwa oge';

  @override
  String get notice_targetUnavailable_message => 'Sava a adịghị dị nwa oge.';

  @override
  String get notice_networkUnavailable_title => 'Njikọ ịntanetị adịghị dị';

  @override
  String get notice_networkUnavailable_message => 'Lelee njikọ gị ma nwaa ọzọ.';

  @override
  String get notice_permissionDenied_title => 'Ajụrụ ikike VPN';

  @override
  String get notice_permissionDenied_message =>
      'Malite njikọ ọzọ ma nabata arịrịọ ikike Android.';

  @override
  String get notice_wireguardTimeout_title => 'Sava anaghị aza';

  @override
  String get notice_wireguardTimeout_message =>
      'Njikọ WireGuard were oge karịrị oke. Nwaa ọzọ ma ọ bụ họrọ ebe ọzọ.';

  @override
  String get notice_tlsFailed_title => 'Ajụrụ njikọ dị nchekwa';

  @override
  String get notice_tlsFailed_message =>
      'Sava anabataghị njikọ OpenVPN. Nwaa ọzọ. Ọ bụrụ na nsogbu ahụ na-aga n’ihu, mee nyocha nsogbu.';

  @override
  String get notice_tunRejected_title => 'Android jụrụ ọdụ netwọkụ VPN';

  @override
  String get notice_tunRejected_message =>
      'Android jụrụ nhazi netwọkụ OpenVPN rịọrọ.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN enweghị ike ịmalite';

  @override
  String get notice_openvpnStart_message =>
      'Injin OpenVPN enweghị ike imecha ịmalite. Nwaa ọzọ. Ọ bụrụ na nsogbu ahụ adịgide, kpọtụrụ ndị nkwado.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Koodu nyocha nsogbu: $code';
  }

  @override
  String get notice_generic_title => 'Njikọ VPN dara';

  @override
  String get notice_generic_message => 'Njehie mere. Nwaa ọzọ mgbe e mesịrị.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Emepụtala akaụntụ',
      'password_reset_sent': 'Natara arịrịọ ịtọgharị paswọọdụ',
      'verification_email_sent': 'Ezipụrụ e-mail nkwado',
      'location_migration_pending': 'Mgbanwe ebe na-aga n’ihu',
      'vpn_sign_in_required': 'Achọrọ ịbanye n’akaụntụ',
      'protocol_unavailable_at_location': 'Usoro adịghị dị',
      'vpn_permission_denied': 'Ajụrụ ikike VPN',
      'revoked_identity_device_limit': 'Oke ngwaọrụ eruola',
      'tunnel_start_unexpected': 'VPN enweghị ike ịmalite',
      'flutter_disconnect_timeout': 'Akwadoghị ịkwụsị njikọ',
      'flutter_disconnect_unexpected': 'Enweghị ike ịkwụsị njikọ',
      'device_revoked': 'Ewepụrụ ngwaọrụ',
      'revoke_unexpected': 'Enweghị ike iwepụ ngwaọrụ',
      'identity_renewal_unexpected': 'Enweghị ike imegharị njirimara',
      'openvpn_renewal_unexpected': 'Enweghị ike imegharị OpenVPN',
      'location_migration_blocked': 'Egbochiri mgbanwe ebe',
      'location_migration_slow': 'Mgbanwe ebe ka na-aga n’ihu',
      'location_migration_conflict': 'Mgbanwe ebe chọrọ ka e melite ya',
      'location_migration_verification_failed': 'Akwadoghị mgbanwe ebe',
      'location_migration_device_changed':
          'Ngwaọrụ agbanwere n’oge mgbanwe ebe',
      'tunnel_stop_failed': 'Mgbanwe ebe adịghị dị',
      'device_clock_ahead': 'Elekere ngwaọrụ dị n’ihu',
      'other': 'Ọrụ dara',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Emepụtala akaụntụ ahụ, mana enweghị ike izipụ e-mail nkwado. Jiri nhọrọ izipụ ọzọ na ngwa a.',
      'password_reset_sent':
          'Natara arịrịọ gị. Ọ bụrụ na akaụntụ dabara na adreesị a, ị nwere ike inweta e-mail. Biko lelee igbe spam gị kwa.',
      'verification_email_sent': 'Ezipụla e-mail nkwado ọhụrụ ugbu a.',
      'location_migration_pending':
          'A ka na-akwadebe mgbanwe gaa $target. Ị nwere ike ịga n’ihu na ya n’enweghị imepụta ngwaọrụ ahụ ọzọ.',
      'vpn_sign_in_required': 'Banye n’akaụntụ gị tupu ịmalite VPN.',
      'protocol_unavailable_at_location':
          'Ebe a anaghị enye usoro ahọpụtara. Melite ebe ndị ahụ ma ọ bụ họrọ usoro ọzọ.',
      'vpn_permission_denied':
          'Android jụrụ ikike VPN. Malite njikọ ọzọ ma nabata arịrịọ sistemu.',
      'revoked_identity_device_limit':
          'Ewepụrụ inweta VPN nke ngwaọrụ a ma oke ngwaọrụ eruola. Wepụ otu ngwaọrụ n’okpuru Akaụntụ → Jikwaa ngwaọrụ m.',
      'tunnel_start_unexpected':
          'Njehie a na-atụghị anya kwụsịrị nkwadebe tunnel. Lelee koodu nyocha nsogbu ma nwaa ọzọ.',
      'flutter_disconnect_timeout':
          'Android akwadoghị n’oge na VPN akwụsịrị. Nwaa ịkwụsị ya ọzọ.',
      'flutter_disconnect_unexpected':
          'Njehie a na-atụghị anya gbochiri nkwado na tunnel akwụsịrị.',
      'device_revoked':
          'Akagbuola inweta VPN nke ngwaọrụ ahụ, e wepụkwara ihe nzuzo ya dị na ngwaọrụ a.',
      'revoke_unexpected':
          'Enweghị ike iwepụ ngwaọrụ ahụ. Melite ndepụta ahụ ma nwaa ọzọ.',
      'identity_renewal_unexpected':
          'Enweghị ike imepụta njirimara VPN ọhụrụ ahụ. Melite ngwaọrụ ma nwaa ọzọ.',
      'openvpn_renewal_unexpected':
          'Enweghị ike imegharị profaịlụ OpenVPN. Nwaa ọzọ ma ọ bụ lelee koodu nyocha nsogbu.',
      'location_migration_blocked':
          'Sava enweghị ike imecha mgbanwe a ugbu a. Echekwara ngwaọrụ ahụ na njirimara ya dị na ngwaọrụ a.',
      'location_migration_slow':
          'Sava ka na-akwadebe mgbanwe gaa $target. Jiri “Gaa n’ihu” mgbe obere oge gasịrị.',
      'location_migration_conflict':
          'Ọnọdụ ngwaọrụ agbanweela na sava. Melite ngwaọrụ, wee gaa n’ihu na mgbanwe ahụ.',
      'location_migration_verification_failed':
          'Sava akwadoghị ebe ọhụrụ ahụ. Echekwara njirimara mbụ dị na ngwaọrụ a.',
      'location_migration_device_changed':
          'Ngwaọrụ sava weghachiri adabaghịzi na nke a na-agbanwe. Melite ngwaọrụ tupu ị nwaa ọzọ.',
      'tunnel_stop_failed':
          'A ghaghị ịkwụsị tunnel nke gara aga kpamkpam tupu njikọ ọhụrụ.',
      'device_clock_ahead':
          'Elekere ngwaọrụ a yiri ka ọ dị n’ihu oge. Gbanye ụbọchị na oge akpaaka iji nọgide n’akaụntụ gị.',
      'other':
          'Enweghị ike imecha ọrụ ahụ. Nwaa ọzọ ma ọ bụ zipụrụ ndị nkwado koodu nyocha nsogbu ahụ.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Oge ịbanye agwụla',
      'invalid_credentials': 'Ịbanye dara',
      'email_verification_required': 'Achọrọ nkwado e-mail',
      'verification_email_cooldown': 'Ezipụlarị e-mail',
      'rate_limited': 'Mbọ gafere oke',
      'invalid_registration': 'Ozi chọrọ ndozi',
      'email_exists': 'Akaụntụ adịlarị',
      'invalid_profile': 'Profaịlụ ezighị ezi',
      'invalid_device': 'Ngwaọrụ ezighị ezi',
      'invalid_location': 'Ebe adịghị dị',
      'device_limit': 'Oke ngwaọrụ eruola',
      'device_exists': 'Njirimara VPN ejirilarị',
      'device_identity_revoked': 'Achọrọ imegharị njirimara VPN',
      'device_location_locked': 'Mgbanwe ebe chọrọ ka e melite ya',
      'location_migration_pending': 'Mgbanwe ebe na-aga n’ihu',
      'location_migration_blocked': 'Egbochiri mgbanwe ebe',
      'target_ca_mismatch': 'Sava OpenVPN adakọtaghị',
      'location_migration_conflict': 'Mgbanwe ebe chọrọ ka e melite ya',
      'server_full': 'Sava jupụtara',
      'capacity_unavailable': 'Ebe adịghị dị nwa oge',
      'target_unavailable': 'Sava adịghị dị nwa oge',
      'not_found': 'Ahụghị ihe ahụ',
      'invalid_openvpn_csr': 'Njirimara OpenVPN ezighị ezi',
      'openvpn_profile_exists': 'Profaịlụ OpenVPN adịlarị',
      'openvpn_profile_revoked': 'Akagbuola profaịlụ OpenVPN',
      'openvpn_operation_pending': 'Ọrụ OpenVPN na-aga n’ihu',
      'openvpn_operation_terminal': 'Ọrụ OpenVPN kwụsịrị',
      'openvpn_address_unavailable': 'Adreesị OpenVPN adịghị dị',
      'openvpn_profile_conflict': 'Esemokwu OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN adịghị dị',
      'email_delivery_unavailable': 'E-mail adịghị dị',
      'invalid_token': 'Njikọ ezighị ezi',
      'network_unavailable': 'Njikọ ịntanetị adịghị dị',
      'invalid_json': 'Arịrịọ ezighị ezi',
      'invalid_api_response': 'Nzaghachi sava ezighị ezi',
      'ipv6_unavailable': 'IPv6 adịghị dị',
      'invalid_ip_families': 'Ajụrụ nhazi netwọkụ',
      'other': 'Ọrụ adịghị dị',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Oge ịbanye gị agwụla. Banye ọzọ.',
      'invalid_credentials': 'Adreesị e-mail ma ọ bụ paswọọdụ ezighị ezi.',
      'email_verification_required':
          'Kwado adreesị e-mail gị tupu ịgbakwunye ngwaọrụ VPN.',
      'invalid_registration': 'Lelee ozi a rịọrọ na nkwenye ndị ahụ.',
      'email_exists': 'Akaụntụ na-eji adreesị e-mail a ugbu a.',
      'invalid_profile': 'Lelee ozi profaịlụ gị.',
      'invalid_device': 'Aha ma ọ bụ njirimara dị na ngwaọrụ a ezighị ezi.',
      'invalid_location': 'Melite ndepụta ebe ahụ ma nwaa ọzọ.',
      'device_limit': 'Wepụ ngwaọrụ dị adị tupu ịgbakwunye ọzọ.',
      'device_exists': 'Njirimara VPN a jikọtalarị na akaụntụ ọzọ.',
      'device_identity_revoked':
          'Ewepụla njirimara a. A ghaghị imepụta njirimara ọhụrụ na ngwaọrụ a.',
      'device_location_locked':
          'Ebe ngwaọrụ a agbanweela ugbu a. Ngwa ahụ ga-aga n’ihu na mgbanwe na-aga.',
      'location_migration_pending': 'Mgbanwe ebe na-aga n’ihu ugbu a.',
      'location_migration_blocked':
          'Mgbanwe ebe chọrọ ka e tinye aka n’akụkụ sava. Nwaa ọzọ mgbe e mesịrị ma ọ bụ kpọtụrụ ndị nkwado.',
      'target_ca_mismatch':
          'Sava a adakọtabeghị na profaịlụ OpenVPN dị ugbu a.',
      'location_migration_conflict':
          'Melite ngwaọrụ, wee nwaa mgbanwe ebe ọzọ.',
      'server_full':
          'Ebe a eruola oke njikọ ya. Họrọ ebe ọzọ ma ọ bụ nwaa ọzọ mgbe e mesịrị.',
      'capacity_unavailable':
          'Anyị enweghị ike ịchọpụta ma ebe a dị ugbu a. Họrọ ebe ọzọ ma ọ bụ nwaa ọzọ mgbe e mesịrị.',
      'target_unavailable': 'Sava a adịghị dị nwa oge.',
      'not_found': 'Ihe a adịghịzi na akaụntụ gị.',
      'invalid_openvpn_csr': 'Mepụta njirimara OpenVPN ọhụrụ ma nwaa ọzọ.',
      'openvpn_profile_exists': 'Profaịlụ OpenVPN adịlarị maka ngwaọrụ a.',
      'openvpn_profile_revoked': 'Megharịa profaịlụ OpenVPN iji gaa n’ihu.',
      'openvpn_operation_pending':
          'Mgbanwe ahụ ka na-agbasa. Nwaa ọzọ mgbe e mesịrị.',
      'openvpn_operation_terminal':
          'Mepụta njirimara OpenVPN ọhụrụ ma nwaa ọzọ.',
      'openvpn_address_unavailable': 'Enweghị adreesị OpenVPN dị ugbu a.',
      'openvpn_profile_conflict':
          'Profaịlụ agbanweela. Melite ngwaọrụ ma nwaa ọzọ.',
      'openvpn_signer_unavailable': 'Ọrụ OpenVPN adịghị dị nwa oge.',
      'email_delivery_unavailable':
          'Enweghị ike izipụ e-mail ahụ. Nwaa ọzọ mgbe e mesịrị.',
      'invalid_token': 'Njikọ a ezighị ezi ma ọ bụ agwụla oge. Rịọ nke ọhụrụ.',
      'network_unavailable': 'Lelee njikọ ịntanetị gị ma nwaa ọzọ.',
      'invalid_json': 'Lelee ozi ndị ị tinyere ma nwaa ọzọ.',
      'invalid_api_response':
          'Sava weghachiri nzaghachi a na-atụghị anya. Nwaa ọzọ mgbe e mesịrị.',
      'ipv6_unavailable':
          'Sava enweghị ike ịgbanye IPv6 ugbu a. Nwaa ọzọ mgbe e mesịrị.',
      'invalid_ip_families':
          'Nhazi tunnel ezughị oke ma ọ bụ ọ dabaghị na adreesị e nyere ikike. Nwaa ọzọ site na ngwa a.',
      'other': 'Njehie sava mere. Nwaa ọzọ mgbe e mesịrị.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Nwaa ọzọ n’oge na-adịghị anya.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Nwaa ọzọ mgbe sekọnd $seconds gasịrị.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Nwaa ọzọ mgbe nkeji $minutes gasịrị.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Nwaa ọzọ mgbe awa $hours gasịrị.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Ịmalitegharị VPN sistemu adịghị dị',
      'system_vpn_resume_corrupt': 'Ịmalitegharị VPN sistemu ezighị ezi',
      'system_vpn_resume_session_invalid': 'Oge ịmalitegharị VPN ezighị ezi',
      'system_vpn_resume_identity_changed': 'Njirimara VPN agbanweela',
      'system_vpn_resume_identity_invalid':
          'Njirimara ịmalitegharị VPN ezighị ezi',
      'system_vpn_resume_storage_failed': 'Nchekwa ịmalitegharị VPN adịghị dị',
      'system_vpn_resume_network_timeout': 'Ịmalitegharị VPN enweghị netwọkụ',
      'system_vpn_resume_blocked': 'Egbochiri ịmalitegharị VPN',
      'system_vpn_resume_failed': 'Ịmalitegharị VPN dara',
      'system_vpn_resume_error_invalid': 'Njehie ịmalitegharị VPN ezighị ezi',
      'wireguard_identity_store_failed': 'Echekwaghị njirimara WireGuard',
      'wireguard_identity_unavailable': 'Njirimara WireGuard adịghị dị',
      'vpn_host_destroyed': 'Akụkụ VPN Android kwụsịrị',
      'vpn_host_unavailable': 'Akụkụ VPN Android adịghị dị',
      'openvpn_renewal_required': 'Achọrọ imegharị asambodo OpenVPN',
      'openvpn_recovery_failed': 'Mgbake OpenVPN dara',
      'openvpn_recovery_exhausted': 'Ejirilarị mgbake OpenVPN',
      'vpn_permission_required': 'Achọrọ ikike VPN',
      'vpn_permission_denied': 'Ajụrụ ikike VPN',
      'vpn_permission_request_failed': 'Enweghị ike ịrịọ ikike',
      'wireguard_foreground_service_unavailable': 'Ọrụ WireGuard adịghị dị',
      'wireguard_identity_invalid': 'Igodo WireGuard dị na ngwaọrụ ezighị ezi',
      'wireguard_identity_in_use': 'Njirimara WireGuard ejirilarị',
      'wireguard_configuration_invalid': 'Nhazi WireGuard ezighị ezi',
      'wireguard_operation_pending': 'Ọrụ WireGuard ka na-arụ',
      'wireguard_start_failed': 'Ajụrụ ịmalite WireGuard',
      'wireguard_stop_timeout': 'Akwadoghị ịkwụsị WireGuard',
      'wireguard_handshake_timeout': 'WireGuard enweghị nzaghachi',
      'openvpn_connection_timeout': 'OpenVPN enweghị nzaghachi',
      'openvpn_core_unavailable': 'Injin OpenVPN adịghị dị',
      'openvpn_operation_pending': 'Oge njikọ OpenVPN ka na-arụ ọrụ',
      'openvpn_stop_timeout': 'Akwadoghị ịkwụsị OpenVPN',
      'openvpn_profile_unavailable': 'Profaịlụ OpenVPN dị na ngwaọrụ adịghị',
      'openvpn_native_failed': 'Oku injin OpenVPN kwụsịrị',
      'openvpn_key_generation_failed':
          'Enweghị ike imepụta igodo OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Enweghị ike imepụta CSR OpenVPN',
      'openvpn_identity_store_failed': 'Echekwaghị njirimara OpenVPN',
      'openvpn_identity_clear_failed': 'Iwepụ OpenVPN ezughị oke',
      'openvpn_identity_in_use': 'A ka na-eji njirimara OpenVPN',
      'openvpn_tls_verification_required': 'Nyocha TLS OpenVPN adịghị',
      'openvpn_cipher_invalid': 'Algoridịm nzuzo OpenVPN ezighị ezi',
      'openvpn_profile_rejected': 'Ajụrụ profaịlụ OpenVPN',
      'openvpn_identity_inconsistent': 'Njirimara OpenVPN adakọtaghị',
      'tls_handshake_failed': 'Ajụrụ nkwekọrịta OpenVPN',
      'tls_alert_unknown_ca': 'Asambodo ngwa OpenVPN amataghị',
      'tls_alert_bad_certificate': 'Ajụrụ asambodo ngwa OpenVPN',
      'tls_alert_unsupported_certificate': 'Asambodo OpenVPN enweghị nkwado',
      'tls_client_certificate_required': 'Achọrọ asambodo ngwa OpenVPN',
      'tls_alert_misc': 'Ịdọ aka ná ntị TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Mbinye aka OpenVPN enweghị nkwado',
      'tls_handshake_rejected': 'Ajụrụ nkwekọrịta TLS OpenVPN',
      'tls_version_rejected': 'Ụdị TLS OpenVPN adakọtaghị',
      'tls_certificate_expired': 'Asambodo TLS agwụla oge',
      'tls_certificate_revoked': 'Akagbuola asambodo TLS',
      'transport_failed': 'Enweghị ike iru sava OpenVPN',
      'tun_configuration_rejected': 'Enweghị ike imepụta ọdụ netwọkụ OpenVPN',
      'tun_setup_failed': 'Nhazi TUN OpenVPN dara',
      'tun_interface_create_failed': 'Mmepụta ọdụ netwọkụ OpenVPN dara',
      'tun_interface_disabled': 'Egbanyụrụ ọdụ netwọkụ OpenVPN',
      'tun_halted': 'Ọdụ netwọkụ OpenVPN kwụsịrị',
      'tun_already_established': 'Ọdụ netwọkụ OpenVPN emeghelarị',
      'tun_addresses_missing': 'Adreesị OpenVPN adịghị',
      'tun_routes_missing': 'Ụzọ OpenVPN adịghị',
      'tun_dns_missing': 'DNS OpenVPN adịghị',
      'tun_permission_revoked': 'Akagbuola ikike VPN',
      'tun_establish_returned_null': 'Android jụrụ ọdụ netwọkụ VPN',
      'openvpn_service_start_failed': 'Ọrụ OpenVPN adịghị dị',
      'openvpn_operation_timeout': 'Oku OpenVPN gafere oge',
      'openvpn_start_failed': 'Ajụrụ ịmalite OpenVPN',
      'openvpn_connection_failed': 'Njikọ OpenVPN kwụsịrị',
      'openvpn_core_status_error': 'OpenVPN Core kwụsịrị n’ihi njehie',
      'openvpn_stopped_before_connected': 'OpenVPN kwụsịrị tupu ọ jikọọ',
      'openvpn_auth_failed': 'Ajụrụ nyocha njirimara OpenVPN',
      'openvpn_client_setup_failed': 'Nhazi ngwa OpenVPN dara',
      'openvpn_client_halted': 'Ngwa OpenVPN kwụsịrị',
      'openvpn_client_restart': 'A rịọrọ ịmalitegharị OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN adịghị arụ ọrụ ogologo oge',
      'openvpn_session_expired': 'Oge njikọ OpenVPN agwụla',
      'openvpn_credentials_required': 'Nyocha njirimara OpenVPN enweghị nkwado',
      'openvpn_proxy_failed': 'Nnyefe proxy OpenVPN dara',
      'openvpn_compression_failed': 'Ajụrụ mkpakọ OpenVPN',
      'openvpn_ntlm_crypto_unavailable': 'Nzuzo NTLM OpenVPN adịghị dị',
      'openvpn_feature_unsupported': 'Atụmatụ OpenVPN enweghị nkwado',
      'network_unavailable': 'Njikọ ịntanetị adịghị dị',
      'network_lost': 'Netwọkụ adịghị dị',
      'certificate_validation_failed': 'Ajụrụ asambodo sava',
      'openvpn_certificate_expired': 'Asambodo OpenVPN agwụla oge',
      'tunnel_active_for_another_account':
          'Tunnel nke akaụntụ ọzọ ka na-arụ ọrụ',
      'tunnel_already_active': 'Tunnel nke injin na-arụlarị ọrụ',
      'tunnel_stop_timeout': 'Akwadoghị ịkwụsị $protocol',
      'tunnel_disconnected': '$protocol kwụsịrị',
      'native_bridge_unavailable': 'Ihe njikọ Android adịghị dị',
      'native_operation_failed': 'Ọrụ Android kwụsịrị',
      'invalid_arguments': 'Paramita VPN ezughị oke',
      'invalid_account_id': 'Akaụntụ VPN ezighị ezi',
      'invalid_device_id': 'Njirimara ngwaọrụ ezighị ezi',
      'storage_key_not_allowed': 'Ajụrụ igodo nchekwa',
      'secure_storage_read_failed': 'Ịgụ n’ebe nchekwa e chebere dara',
      'secure_storage_write_failed': 'Ide n’ebe nchekwa e chebere dara',
      'key_generation_failed': 'Enweghị ike imepụta igodo WireGuard',
      'csr_generation_failed': 'Enweghị ike imepụta CSR OpenVPN',
      'other': 'Njehie VPN nke injin amataghị ụdị ya',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android enweghị ike ịchọta oge njikọ VPN nke a pụrụ ịmalitegharị. Malite njikọ ọhụrụ na ngwa ahụ.',
      'system_vpn_resume_corrupt':
          'Data ịmalitegharị VPN echekwara ezighị ezi, a gaghị eji ya. Malite njikọ ọhụrụ.',
      'system_vpn_resume_session_invalid':
          'Oge ịbanye echekwara apụghịzi ịmalitegharị VPN. Banye ọzọ na ngwa ahụ.',
      'system_vpn_resume_identity_changed':
          'Njirimara VPN dị na ngwaọrụ agbanweela. A kwụsịrị ịmalitegharị; malite njikọ ọhụrụ.',
      'system_vpn_resume_identity_invalid':
          'Njirimara e ji malitegharị ezighị ezi. Malite njikọ ọhụrụ.',
      'system_vpn_resume_storage_failed':
          'Android enweghị ike ịgụ ma ọ bụ melite data ịmalitegharị e zoro ezo. Malite njikọ ọhụrụ.',
      'system_vpn_resume_network_timeout':
          'Android achọtaghị netwọkụ n’oge iji malitegharị VPN. Nwaa ọzọ mgbe netwọkụ dị.',
      'system_vpn_resume_blocked':
          'Egbochiri ịmalitegharị VPN. Lelee ntọala Android, wee malite njikọ ọhụrụ.',
      'system_vpn_resume_failed':
          'Ịmalitegharị VPN nke Android emeghị nke ọma. Malite njikọ ọhụrụ na ngwa ahụ.',
      'system_vpn_resume_error_invalid':
          'Android weghachiri njehie ịmalitegharị nke apụghị iji. Malite njikọ ọhụrụ.',
      'wireguard_identity_store_failed':
          'Android enweghị ike ichekwa njirimara WireGuard e zoro ezo nke akaụntụ a.',
      'wireguard_identity_unavailable':
          'Enweghị njirimara WireGuard a pụrụ iji maka njikọ a.',
      'vpn_host_destroyed':
          'Akụkụ Android na-ebu VPN kwụsịrị. Malite njikọ ọhụrụ.',
      'vpn_host_unavailable':
          'Android enweghị ike imepụta akụkụ na-ebu VPN. Nwaa ọzọ mgbe ị lelechara ntọala VPN.',
      'openvpn_renewal_required':
          'Asambodo ahụ chọrọ ka ị mee ihe na ngwa ahụ tupu ijikọ.',
      'openvpn_recovery_failed':
          'Mgbake akpaaka emeghị nke ọma. Malite njikọ ọhụrụ na ngwa ahụ.',
      'openvpn_recovery_exhausted':
          'Ejirilarị mgbake akpaaka. Malite njikọ ọhụrụ na ngwa ahụ.',
      'vpn_permission_required':
          'Android chọrọ ikike VPN ọhụrụ tupu ịmalite tunnel.',
      'vpn_permission_denied': 'Kwere FuzeVPN na arịrịọ Android iji gaa n’ihu.',
      'vpn_permission_request_failed':
          'Android enweghị ike imepe ihuenyo ikike VPN.',
      'wireguard_foreground_service_unavailable':
          'Android enweghị ike idobe ọrụ WireGuard n’ihu ihuenyo.',
      'wireguard_identity_invalid':
          'Igodo WireGuard e zoro ezo nke akaụntụ a agụghị ma ọ bụ ezighị ezi.',
      'wireguard_identity_in_use':
          'Ọrụ ọzọ ka na-eji igodo WireGuard nke akaụntụ a.',
      'wireguard_configuration_invalid':
          'Adreesị WireGuard, DNS, igodo sava ma ọ bụ ụzọ ndị e nwetara ezighị ezi.',
      'wireguard_operation_pending':
          'Ọrụ WireGuard gara aga ahapụbeghị ọrụ injin ya.',
      'wireguard_start_failed': 'Injin WireGuard jụrụ ịgbanye nhazi ahụ.',
      'wireguard_stop_timeout':
          'Ọrụ WireGuard akwadoghị ịhapụ ọdụ netwọkụ VPN n’ime oge e kpebiri.',
      'wireguard_handshake_timeout':
          'Tunnel akwadoghị nkwekọrịta njikọ na sava n’oge.',
      'openvpn_connection_timeout': 'OpenVPN akwadoghị njikọ na sava n’oge.',
      'openvpn_core_unavailable':
          'Ụdị ngwa a enweghị injin OpenVPN a pụrụ iji.',
      'openvpn_operation_pending':
          'Injin ahụ ka na-ejide oge njikọ OpenVPN gara aga ma jụ imepụta nke abụọ.',
      'openvpn_stop_timeout':
          'OpenVPN Core akwadoghị n’ime oge e kpebiri na oge njikọ ya kwụsịrị ma e bibiri ya.',
      'openvpn_profile_unavailable':
          'Enweghị profaịlụ OpenVPN e kwadoro a pụrụ ịgụ maka njikọ a.',
      'openvpn_native_failed':
          'Njehie ngwa kwụsịrị OpenVPN. Nwaa ijikọ ọzọ. Ọ bụrụ na nsogbu ahụ aga n’ihu, mee nyocha nsogbu.',
      'openvpn_key_generation_failed':
          'Android Keystore enweghị ike imepụta ma ọ bụ ịgụ igodo nzuzo P-256 nke a pụghị ibupụ.',
      'openvpn_csr_generation_failed':
          'Igodo Android Keystore enweghị ike ibinye aka na arịrịọ asambodo OpenVPN.',
      'openvpn_identity_store_failed':
          'Enweghị ike ichekwa asambodo ma ọ bụ profaịlụ OpenVPN n’ime nchekwa e zoro ezo.',
      'openvpn_identity_clear_failed':
          'Android enweghị ike iwepụ njirimara OpenVPN niile dị na ngwaọrụ nke akaụntụ a.',
      'openvpn_identity_in_use':
          'Oge njikọ OpenVPN nke injin ka na-eji igodo ma ọ bụ asambodo nke ngwaọrụ a.',
      'openvpn_tls_verification_required':
          'Profaịlụ ahụ achọghị nyocha asambodo sava n’ụzọ doro anya.',
      'openvpn_cipher_invalid':
          'Sava nyere algoridịm nzuzo nke na-adịghị na ndepụta e kwere ekwe.',
      'openvpn_profile_rejected':
          'Profaịlụ e nwetara site na sava adakọtaghị. Mepụta ngwaọrụ a ọzọ, wee nwaa ọzọ.',
      'openvpn_identity_inconsistent':
          'Asambodo ahụ adakọtaghị na njirimara nchekwa nke ekwentị a. E dochighị profaịlụ ọ bụla dị na ngwaọrụ.',
      'tls_handshake_failed':
          'Sava jụrụ nkwekọrịta TLS. Mepụta profaịlụ ọzọ ma ọ bụrụ na nsogbu ahụ adịgide.',
      'tls_alert_unknown_ca':
          'Sava amataghị onye nyere asambodo ngwaọrụ a. A ghaghị ilele sava OpenVPN.',
      'tls_alert_bad_certificate':
          'Sava jụrụ asambodo ngwaọrụ a. Mepụta ngwaọrụ ọzọ tupu ị nwaa ọzọ.',
      'tls_alert_unsupported_certificate':
          'Sava anaghị akwado ụdị asambodo nchekwa Android na-eji.',
      'tls_client_certificate_required':
          'Sava chọrọ asambodo ngwa, mana OpenVPN Core enweghị ike inye otu.',
      'tls_alert_misc':
          'Sava weghachiri ịdọ aka ná ntị TLS nke na-abụghị maka asambodo ma ọ bụ ụdị TLS.',
      'tls_signature_algorithm_rejected':
          'Sava jụrụ algoridịm ECDSA P-256 nke igodo Android Keystore.',
      'tls_handshake_rejected': 'Sava kwụsịrị nkwekọrịta TLS tupu njikọ.',
      'tls_version_rejected':
          'Ngwa ahụ na sava achọtaghị ụdị TLS ha abụọ na-akwado.',
      'tls_certificate_expired':
          'Asambodo e gosipụtara n’oge njikọ agwụla oge.',
      'tls_certificate_revoked': 'Akagbuola asambodo e gosipụtara n’oge njikọ.',
      'transport_failed':
          'Sava OpenVPN anaghị aza na netwọkụ dị ugbu a. Nwaa ọzọ n’oge na-adịghị anya.',
      'tun_configuration_rejected': 'Android jụrụ nhazi netwọkụ OpenVPN rịọrọ.',
      'tun_setup_failed':
          'OpenVPN Core jụrụ atụmatụ netwọkụ tupu e mepụta ọdụ netwọkụ Android.',
      'tun_interface_create_failed':
          'OpenVPN Core enweghị ike inweta ọdụ netwọkụ TUN site na Android VpnService.',
      'tun_interface_disabled':
          'Android ma ọ bụ OpenVPN Core gbanyụrụ ọdụ netwọkụ TUN n’oge njikọ.',
      'tun_halted': 'OpenVPN Core natara arịrịọ ịkwụsị ọdụ netwọkụ TUN.',
      'tun_already_established':
          'OpenVPN rịọrọ ọdụ netwọkụ nke abụọ n’otu njikọ ahụ. A kwụsịrị tunnel maka nchekwa.',
      'tun_addresses_missing': 'Sava enyeghị adreesị tunnel a pụrụ iji.',
      'tun_routes_missing': 'Sava enyeghị ụzọ tunnel a pụrụ iji.',
      'tun_dns_missing': 'Sava enyeghị sava DNS a pụrụ iji.',
      'tun_permission_revoked': 'Android kagburu ikike VPN n’oge njikọ.',
      'tun_establish_returned_null':
          'Android emepụghị ọdụ netwọkụ ahụ, n’ọtụtụ oge n’ihi na VPN ọzọ ka na-arụ ọrụ.',
      'openvpn_service_start_failed':
          'Android enweghị ike ịmalite ọrụ OpenVPN n’ihu ihuenyo.',
      'openvpn_operation_timeout':
          'Oku JNI gaa OpenVPN Core gafere oge kachasị ya.',
      'openvpn_start_failed':
          'Ọrụ Android dị njikere, mana OpenVPN Core anabataghị ịmalite profaịlụ ahụ.',
      'openvpn_connection_failed':
          'OpenVPN Core kwụsịrị tupu ọ wepụta ihe omume CONNECTED.',
      'openvpn_core_status_error':
          'Okirikiri ọrụ OpenVPN nke injin kwụsịrị n’ihi njehie, na-enweghị ihe omume ikpeazụ ka doro anya.',
      'openvpn_stopped_before_connected':
          'Okirikiri ọrụ OpenVPN nke injin kwụsịrị tupu CONNECTED, na-enweghị njehie Core doro anya.',
      'openvpn_auth_failed':
          'Sava OpenVPN jụrụ nyocha njirimara nke profaịlụ ahụ.',
      'openvpn_client_setup_failed':
          'OpenVPN Core enweghị ike ịkwadebe ngwa ahụ tupu njikọ netwọkụ.',
      'openvpn_client_halted':
          'OpenVPN Core natara arịrịọ ikpeazụ ịkwụsị ngwa ahụ.',
      'openvpn_client_restart':
          'OpenVPN Core rịọrọ ịmalitegharị oge nnyefe ya.',
      'openvpn_inactive_timeout':
          'OpenVPN Core mechiri oge njikọ ahụ mgbe oge adịghị arụ ọrụ gasịrị.',
      'openvpn_session_expired': 'Sava kọrọ na oge njikọ OpenVPN agwụla.',
      'openvpn_credentials_required':
          'Sava ma ọ bụ proxy na-arịọ ozi nbanye ị ga-etinye ozugbo, nke na-abụghị akụkụ nke profaịlụ asambodo a.',
      'openvpn_proxy_failed':
          'OpenVPN Core kọrọ na proxy ma ọ bụ relay e haziri dara.',
      'openvpn_compression_failed':
          'OpenVPN Core jụrụ ụdị mkpakọ profaịlụ ma ọ bụ sava kwupụtara.',
      'openvpn_ntlm_crypto_unavailable':
          'Profaịlụ ahụ na-arịọ nzuzo NTLM nke adịghị n’ụdị a.',
      'openvpn_feature_unsupported':
          'Profaịlụ ma ọ bụ sava chọrọ atụmatụ nke adịghị na ngwa Android a.',
      'network_unavailable': 'Enweghị netwọkụ anụ ahụ a pụrụ iji.',
      'network_lost': 'A kwụsịrị tunnel mgbe netwọkụ furu efu.',
      'certificate_validation_failed':
          'Enweghị ike inyocha njirimara sava OpenVPN.',
      'openvpn_certificate_expired':
          'Megharịa profaịlụ OpenVPN tupu ijikọ ọzọ.',
      'tunnel_active_for_another_account':
          'A ghaghị ịkwụsị tunnel nke akaụntụ ọzọ tupu njikọ a.',
      'tunnel_already_active':
          'Android kọrọ na oge njikọ VPN gara aga ka na-eji ọdụ netwọkụ ahụ.',
      'tunnel_stop_timeout':
          'Injin $protocol akwadoghị ịhapụ ọdụ netwọkụ VPN n’ime oge e kpebiri.',
      'tunnel_disconnected':
          'Injin ahụ kọrọ na tunnel kwụsịrị n’enweghị atụmanya mgbe ọ malitechara.',
      'native_bridge_unavailable':
          'Ngwa ahụ enweghị ike inweta ọrụ VPN Android. Mechie ngwa ahụ, meghee ya ọzọ, wee nwaa ọzọ.',
      'native_operation_failed':
          'Njehie ngwa kwụsịrị ọrụ VPN ahụ. Nwaa ọzọ. Ọ bụrụ na nsogbu ahụ aga n’ihu, mee nyocha nsogbu.',
      'invalid_arguments':
          'Ozi achọrọ maka ọrụ VPN a ezughị oke. Nwaa ọzọ. Ọ bụrụ na nsogbu ahụ aga n’ihu, mee nyocha nsogbu.',
      'invalid_account_id':
          'Ọrụ injin ahụ ejikọtaghị na njirimara akaụntụ ziri ezi.',
      'invalid_device_id':
          'Njirimara ngwaọrụ e zigara injin ahụ adịghị ma ọ bụ ezighị ezi.',
      'storage_key_not_allowed':
          'Ihe njikọ Android gbochiri igodo nke na-adịghị na ndepụta nchekwa e kwere ekwe.',
      'secure_storage_read_failed':
          'Android Keystore enweghị ike imeghe data e zoro ezo nke akaụntụ a dị na ngwaọrụ.',
      'secure_storage_write_failed':
          'Android Keystore enweghị ike izo ezo ma ọ bụ ichekwa data dị na ngwaọrụ.',
      'key_generation_failed':
          'Android enweghị ike imepụta ma ọ bụ ịgụ igodo WireGuard n’ime nchekwa e chebere.',
      'csr_generation_failed':
          'Android Keystore enweghị ike imepụta ma ọ bụ ibinye aka na CSR OpenVPN P-256.',
      'other':
          'Otu ngalaba injin nke enweghị akwụkwọ nkọwa dara. Zipụrụ ndị nkwado koodu nyocha nsogbu egosiri n’okpuru.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Arịrịọ ikike emeghelarị';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Arịrịọ ikike VPN Android egosilarị. Mezuo ya tupu ị nwaa ọzọ.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Arịrịọ ikike VPN kwụsịrị';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Ihuenyo ikike VPN mechiri tupu ngwa ahụ anata nzaghachi.';

  @override
  String get notice_openvpnProofMissing_title => 'Akwadoghị njikọ OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'Enweghị ike ịkwado njikọ OpenVPN. A kwụsịrị ya maka nchekwa. Nwaa ọzọ.';

  @override
  String get openvpnCleanup_title => 'Akagbuola profaịlụ OpenVPN';

  @override
  String get openvpnCleanup_working =>
      'Na-akwụsị ma na-ewepụ profaịlụ OpenVPN akagburu…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Akwadoghị ịkwụsị OpenVPN. Nwaa ọzọ tupu imepụta profaịlụ ọhụrụ.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Enweghị ike iwepụ kpamkpam profaịlụ OpenVPN akagburu. Nwaa ihicha ọzọ.';

  @override
  String get openvpnCleanup_complete =>
      'Ewepụla profaịlụ OpenVPN akagburu ahụ. Pịa “Jikọọ” iji mepụta nke ọhụrụ.';

  @override
  String get network_title => 'Nhazi netwọkụ';

  @override
  String get network_ipv4Fallback =>
      'IPv6 adịghị dị nwa oge. Nkwadebe na-aga n’ihu site na IPv4.';

  @override
  String get network_rejectedTitle => 'Ajụrụ nhazi netwọkụ';

  @override
  String get network_rejectedMessage =>
      'Nhazi tunnel ezughị oke ma ọ bụ ọ dabaghị na adreesị e nyere ikike. Nwaa ọzọ site na ngwa a.';

  @override
  String get network_unreadableTitle => 'Enweghị ike ịgụ nhazi dị na ngwaọrụ';

  @override
  String get network_unreadableMessage =>
      'Enweghị ike iji nhazi netwọkụ OpenVPN echekwara. Jikọọ ọzọ site na ngwa a iji melite ya.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Nchebe netwọkụ';

  @override
  String get protection_subtitle =>
      'Gbochie inweta ịntanetị n’enweghị VPN ma ọ bụrụ na VPN kwụsịrị.';

  @override
  String get protection_active => 'Nchebe sistemu na-arụ ọrụ';

  @override
  String get protection_alwaysOnOnly =>
      'Egbanyela VPN na-arụ ọrụ mgbe niile; gbanye igbochi njikọ na-enweghị VPN';

  @override
  String get protection_inactive => 'Nchebe sistemu adịghị arụ ọrụ';

  @override
  String get protection_unknown => 'Lelee nchebe sistemu';

  @override
  String get protection_openSettings => 'Mepee ntọala Android';

  @override
  String get protection_dialogTitle => 'Hazie nchebe netwọkụ';

  @override
  String get protection_dialogMessage =>
      'Android na-ejikwa VPN na-arụ ọrụ mgbe niile na igbochi njikọ na-enweghị VPN. Lelee na a họọrọla FuzeVPN, ma gbanye igbochi na ntọala sistemu.';

  @override
  String get protection_dialogOpen => 'Mepee ntọala';

  @override
  String get session_systemProtectionNote =>
      'Ọ bụrụ na Android ka na-egbochi data na-enweghị VPN, mepee ntọala sistemu iji lelee ma ọ bụ gbanwee nchebe a.';

  @override
  String get diagnostics_title => 'Nyocha nsogbu';

  @override
  String get diagnostics_settingsTitle => 'Nyocha nsogbu ngwa';

  @override
  String get diagnostics_automaticTitle => 'Zipụ njehie dị mkpa';

  @override
  String get diagnostics_automaticDescription =>
      'Kekọrịta obere akụkọ teknụzụ mgbe njehie dị mkpa mere.';

  @override
  String get diagnostics_privacy =>
      'Akụkọ ndị e zipụrụ jikọtara na akaụntụ ị banyere n’ime ya, a na-echekwa ha ruo ụbọchị 30. Ha enweghị akụkọ nchọgharị, paswọọdụ ma ọ bụ igodo VPN.';

  @override
  String get diagnostics_manualOpen => 'Mee nyocha nsogbu';

  @override
  String get diagnostics_localDescription =>
      'Mepụta akụkọ banyere ọnọdụ ngwa na VPN. Njikọ gị agaghị agbanwe.';

  @override
  String get diagnostics_sendReport => 'Zipụ akụkọ ahụ';

  @override
  String get diagnostics_sendHint =>
      'Hapụ igbe a n’enweghị akara iji chekwa akụkọ ahụ na ngwaọrụ a.';

  @override
  String get diagnostics_signedOut => 'Banye n’akaụntụ gị iji zipụ akụkọ.';

  @override
  String get diagnostics_localLifetime =>
      'Chekwaa akụkọ a na ekwentị gị iji debe ya mgbe ị mechiri ngwa ahụ.';

  @override
  String get diagnostics_run => 'Mee nyocha nsogbu';

  @override
  String get diagnostics_rerun => 'Mee nyocha nsogbu ọzọ';

  @override
  String get diagnostics_running => 'Na-enyocha…';

  @override
  String get diagnostics_sending => 'Na-ezipụ akụkọ…';

  @override
  String get diagnostics_prepared => 'Akụkọ dị njikere na ngwaọrụ a';

  @override
  String get diagnostics_queued => 'Akụkọ na-echere izipụ';

  @override
  String get diagnostics_sent => 'Natara akụkọ ahụ';

  @override
  String get diagnostics_failed =>
      'Izipụ emeghị nke ọma. Akụkọ dị na ngwaọrụ gị ka dị.';

  @override
  String get diagnostics_preparationFailed =>
      'Enweghị ike ịkwadebe akụkọ nyocha nsogbu. Nwaa ọzọ.';

  @override
  String get diagnostics_authenticationRequired =>
      'Banye ọzọ iji zipụ akụkọ ahụ.';

  @override
  String get diagnostics_retry => 'Nwaa izipụ ọzọ';

  @override
  String get diagnostics_export => 'Chekwaa akụkọ';

  @override
  String get diagnostics_exportFailed =>
      'Mbupụ emeghị nke ọma. Nwaa ọzọ site na akụkọ dị na ngwaọrụ.';

  @override
  String get diagnostics_preferenceFailed =>
      'Enweghị ike ichekwa ntọala a. Nwaa ọzọ.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Ntụaka: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Natara na $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Echekwara ruo $date';
  }

  @override
  String get diagnostics_duplicate => 'Natarala akụkọ a na mbụ.';

  @override
  String get diagnostics_preview => 'Nlele akụkọ';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ihe omume teknụzụ $count e jikọtara',
      one: 'Ihe omume teknụzụ 1 e jikọtara',
      zero: 'Enweghị ihe omume teknụzụ e jikọtara',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Nkọwa teknụzụ';

  @override
  String get diagnostics_empty => 'Enweghị akụkọ nyocha nsogbu e kwadebeworo.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Ọnọdụ tunnel',
      'handshake': 'Nkwado njikọ',
      'certificate': 'Asambodo VPN',
      'kill_switch': 'Nchebe Android',
      'connectivity': 'Netwọkụ dị',
      'api_reachability': 'Inweta ọrụ',
      'secure_storage': 'Ebe nchekwa e chebere',
      'other': 'Nyocha dị na ngwaọrụ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Enyochala',
      'failed': 'Chọrọ nlebara anya',
      'skipped': 'Anwaghị ule — enweghị nyocha na-arụ ọrụ',
      'unknown': 'Ozi adịghị dị',
      'other': 'Ozi adịghị dị',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Nnọọ na FuzeVPN';

  @override
  String get connection_changeLocation => 'Gbanwee ebe';

  @override
  String get connection_details => 'Nkọwa njikọ';

  @override
  String get locations_searchLabel => 'Chọọ obodo ma ọ bụ mba';

  @override
  String get locations_clearSearch => 'Hichapụ nchọ';

  @override
  String get locations_filterAll => 'Niile';

  @override
  String get locations_filterFavorites => 'Ndị kacha amasị';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ebe $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Ahụghị ebe ọ bụla';

  @override
  String get locations_noResultsHint => 'Nwaa obodo ma ọ bụ mba ọzọ.';

  @override
  String get locations_noFavorites => 'Ndị kacha amasị gị, dị nso';

  @override
  String get locations_noFavoritesHint =>
      'Pịa kpakpando dị n’akụkụ ebe iji chekwa ya ebe a.';

  @override
  String get locations_showAll => 'Lee ebe niile';

  @override
  String locations_addFavorite(String name) {
    return 'Tinye $name na ndị kacha amasị';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Wepụ $name n’ime ndị kacha amasị';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Enweghị ike ichekwa ya na ndị kacha amasị. Nwaa ọzọ.';

  @override
  String get locations_emptyTitle => 'Enweghị ebe dị';

  @override
  String get locations_emptyHint => 'Melite ndepụta ahụ iji nwaa ọzọ.';

  @override
  String get devices_manage => 'Jikwaa ngwaọrụ m';

  @override
  String get settings_personalization => 'Mee ka ọ bụrụ nke gị';

  @override
  String get settings_safety => 'Nchebe';

  @override
  String get settings_help => 'Ị chọrọ enyemaka?';

  @override
  String get settings_about => 'Banyere FuzeVPN';

  @override
  String get diagnostics_heading => 'Ghọta nsogbu njikọ';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Dị',
      'pending': 'Na-akwadebe',
      'revoked': 'Ewepụrụ',
      'expired': 'Agwụla oge',
      'other': 'Ọnọdụ adịghị dị',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Nhọrọ echekwabeghị';

  @override
  String get notice_preferenceSave_message =>
      'A na-eji nhọrọ gị ugbu a, mana enweghị ike ichekwa ya. Nwaa ọzọ iji debe ya mgbe ị mechiri ngwa ahụ.';

  @override
  String get connection_androidDisconnectHint =>
      'Ọ bụrụ na Android ka na-edobe VPN n’ọrụ, gbanyụọ VPN na-arụ ọrụ mgbe niile na ntọala ndị ga-emeghe.';

  @override
  String get protection_learnMore => 'Mụta banyere nchebe Android';

  @override
  String get protection_guideWhy =>
      'Nchebe a na-egbochi ngwa iji ịntanetị n’enweghị VPN ma ọ bụrụ na VPN kwụsịrị. A na-ahazi ya na Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN na-arụ ọrụ mgbe niile';

  @override
  String get protection_guideAlwaysOn =>
      'Android na-edobe ọrụ VPN n’ọrụ ma nwee ike ịmalitegharị ya mgbe ekwentị malitere ọzọ.';

  @override
  String get protection_guideBlockTitle => 'Gbochie njikọ na-enweghị VPN';

  @override
  String get protection_guideBlock =>
      'Ntọala a na-egbochi data ịgafe n’enweghị VPN, gụnyere mgbe njikọ kwụsịrị.';

  @override
  String get protection_guideWarning =>
      'Mgbe mgbochi a dị n’ọrụ, inweta ịntanetị agaghị adị ruo mgbe VPN jikọrọ.';

  @override
  String get protection_guideStepsTitle => 'Gbanye nchebe';

  @override
  String get protection_guideStep1 =>
      'Jiri bọtịnụ dị n’okpuru mepee ntọala VPN Android.';

  @override
  String get protection_guideStep2 =>
      'Mepee nhọrọ site na akara ntọala (gia) dị n’akụkụ FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Gbanye “VPN na-arụ ọrụ mgbe niile”, mgbe ahụ “Gbochie njikọ na-enweghị VPN”, ọ bụrụ na nhọrọ ndị a dị.';

  @override
  String get protection_guideManufacturers =>
      'Aha ndị a dị iche n’ekwentị ọ bụla. Ọ bụrụ na ọ dị mkpa, chọọ VPN na Ntọala, nke a na-ahụkarị n’okpuru Netwọkụ na ịntanetị.';

  @override
  String get protection_guideDisableTitle => 'Gbanyụọ nchebe a';

  @override
  String get protection_guideDisable =>
      'Na otu ntọala ahụ, gbanyụọ “Gbochie njikọ na-enweghị VPN” iji kwe ka inweta ịntanetị dị n’enweghị VPN. Gbanyụkwa “VPN na-arụ ọrụ mgbe niile” ma ọ bụrụ na ịchọghịzi ka Android malitegharịa ya.';

  @override
  String get protection_guideManual =>
      'Ị na-ahọrọ ntọala ndị a na Android. FuzeVPN anaghị agbanwe ha maka gị.';

  @override
  String get locations_changeTitle => 'Gbanwee ebe?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ga-akwụsị njikọ, mgbe ahụ ọ ga-anwa ijikọ na $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN ga-anwa ijikọ na $name.';
  }

  @override
  String get locations_confirmChange => 'Gbanwee ma jikọọ';

  @override
  String get locations_changeBusy =>
      'A na-agbanwe ebe ugbu a. Chere tupu ị họrọ ebe ọzọ.';

  @override
  String get locations_automaticSelection => 'Nhọrọ akpaaka';

  @override
  String get locations_cities => 'Obodo';

  @override
  String get locations_servers => 'Sava';

  @override
  String locations_viewCities(String name) {
    return 'Lee obodo dị na $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Lee sava dị na $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mba $count',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'obodo $count',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sava $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Mba niile';

  @override
  String get locations_backToCountries => 'Laghachi na mba';

  @override
  String locations_backToCities(String name) {
    return 'Laghachi na obodo dị na $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Họrọ $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Họrọ $name';
  }

  @override
  String get locations_noCompatibleServer => 'Enweghị sava kwekọrọ dị.';

  @override
  String get externalLink_failed =>
      'Enweghị ike imepe njikọ a. Ị nwere ike ịkọpịa ya ma mepee ya na ihe nchọgharị gị.';

  @override
  String get externalLink_copy => 'Kọpịa njikọ';

  @override
  String get externalLink_copied => 'Ekọpịrị njikọ';

  @override
  String get externalLink_copyFailed =>
      'Enweghị ike ịkọpịa njikọ ahụ. Họrọ adreesị dị n’okpuru.';

  @override
  String get settings_deleteAccount => 'Hichapụ akaụntụ m';

  @override
  String get settings_deleteAccountDetail =>
      'Lee usoro arịrịọ ihichapụ akaụntụ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Họrọ ndebanye VPN gị.';

  @override
  String get billing_subscribe => 'Debanye';

  @override
  String get billing_choosePlan => 'Họrọ atụmatụ iji gaa n’ihu.';

  @override
  String get billing_monthly => 'Kwa ọnwa';

  @override
  String get billing_yearly => 'Kwa afọ';

  @override
  String get billing_continue => 'Gaa n’ihu na Google Play';

  @override
  String get billing_restore => 'Weghachi ihe ị zụtara';

  @override
  String get billing_manage => 'Jikwaa ndebanye';

  @override
  String get billing_deleteAccountWarning =>
      'Ọ bụrụ na ị nwere ndebanye Google Play, ihichapụ akaụntụ FuzeVPN gị anaghị akagbu mmegharị ya. Jikwaa ma ọ bụ kagbuo mmegharị ahụ n’ụzọ dị iche na Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Gaa n’ihu na arịrịọ ihichapụ akaụntụ';

  @override
  String get billing_refresh => 'Melite inweta';

  @override
  String get billing_loadingPlans => 'Na-ebudata atụmatụ…';

  @override
  String get billing_unavailable =>
      'Enweghị atụmatụ dị ugbu a. Nwaa ọzọ mgbe e mesịrị.';

  @override
  String get billing_comingSoon => 'Ndebanye na-abịa n’oge na-adịghị anya.';

  @override
  String get billing_priceDisclosure =>
      'Google Play na-enye ọnụahịa a. A na-ekwado ọnụ ego ikpeazụ na ụtụ isi metụtara ya tupu ị kwado.';

  @override
  String get billing_renewalMonthly =>
      'A na-emegharị ya akpaaka kwa ọnwa, belụsọ ma e kagbuo ya. Ị nwere ike ịkagbu ya mgbe ọ bụla na ndebanye Google Play.';

  @override
  String get billing_renewalYearly =>
      'A na-emegharị ya akpaaka kwa afọ, belụsọ ma e kagbuo ya. Ị nwere ike ịkagbu ya mgbe ọ bụla na ndebanye Google Play.';

  @override
  String get billing_active => 'Inweta Premium gị na-arụ ọrụ';

  @override
  String billing_accessUntil(String date) {
    return 'Inweta ruo $date.';
  }

  @override
  String get billing_webManaged =>
      'A na-ejikwa ndebanye gị na weebụsaịtị FuzeVPN.';

  @override
  String get billing_playManaged => 'Google Play na-ejikwa ndebanye gị.';

  @override
  String get billing_playOnHold =>
      'Ndebanye Google Play gị kwụsịrị nwa oge ma ọ bụ na-echere ịkwụ ụgwọ. Mepee “Jikwaa ndebanye” iji dozie ya na Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Akaụntụ Google Play a nwerelarị ndebanye Fuze Premium nke na-adịghị arụ ọrụ maka akaụntụ FuzeVPN a. Mepee “Jikwaa ndebanye” iji lelee ya na Google Play.';

  @override
  String get billing_inactive => 'Enweghị ndebanye na-arụ ọrụ.';

  @override
  String get billing_checkingAccess => 'Na-enyocha inweta gị…';

  @override
  String get billing_restoring => 'Na-eweghachi ihe ị zụtara…';

  @override
  String get billing_pending =>
      'Ịkwụ ụgwọ na-echere. Inweta gị ga-amalite mgbe a kwadoro ya.';

  @override
  String get billing_cancelled =>
      'Akagbuola nzụta. Enweghị ndebanye ọhụrụ e mere ka ọ rụọ ọrụ.';

  @override
  String get billing_verifying => 'Na-enyocha nzụta…';

  @override
  String get billing_success =>
      'Emeela ka ndebanye rụọ ọrụ. Inweta Premium gị dị njikere.';

  @override
  String get billing_restored => 'Eweghachila ihe ị zụtara.';

  @override
  String get billing_restoreEmpty =>
      'Enweghị ihe e zụtara a ga-eweghachi maka akaụntụ Google Play a.';

  @override
  String get billing_catalogError => 'Enweghị ike ibudata atụmatụ. Nwaa ọzọ.';

  @override
  String get billing_purchaseError => 'Enweghị ike ibido nzụta. Nwaa ọzọ.';

  @override
  String get billing_verificationError =>
      'Nyocha nzụta adịghị dị nwa oge. Weghachi ihe ị zụtara iji nwaa ọzọ.';

  @override
  String get billing_restoreError =>
      'Enweghị ike iweghachi ihe ị zụtara. Nwaa ọzọ.';

  @override
  String get billing_managementError =>
      'Enweghị ike imepe njikwa ndebanye. Nwaa ọzọ.';

  @override
  String get billing_storeUnavailable => 'Google Play adịghị dị na ngwaọrụ a.';

  @override
  String get welcome_title => 'VPN gị, dị mfe.';

  @override
  String get welcome_description =>
      'Chebe njikọ gị. Nọgide na-achịkwa nzuzo gị.';

  @override
  String get welcome_start => 'Malite';

  @override
  String get welcome_alreadyPurchased => 'Ị zụtalarị ya?';

  @override
  String get welcome_noAccountRequired => 'Ị chọghị akaụntụ iji malite.';

  @override
  String get guest_accountTitle => 'Akaụntụ ejikọtaghị';

  @override
  String get guest_accountDescription =>
      'Weghachi ihe ị zụtara site n’otu akaụntụ Google Play ahụ ka ị nwee ike iji ndebanye gị na ngwaọrụ ọzọ.';

  @override
  String get guest_existingSubscriberSignIn => 'Ị debanyelarị? Banye n’akaụntụ';

  @override
  String get guest_claimTitle => 'Were FuzeVPN gaa ebe ọ bụla';

  @override
  String get guest_claimDescription =>
      'Mepụta akaụntụ iji nweta ndebanye gị na ngwaọrụ gị ndị ọzọ. Nzọụkwụ a bụ nhọrọ.';

  @override
  String get guest_skip => 'Mgbe e mesịrị';

  @override
  String get guest_activationTitle => 'Fuze Premium na-arụ ọrụ';

  @override
  String get guest_activationDescription =>
      'Ndebanye gị dị njikere. Jiri VPN gị ma mepụta akaụntụ mgbe ọ bụla ịchọrọ.';

  @override
  String get guest_useVpn => 'Jiri VPN m';

  @override
  String get guest_loginRequired =>
      'Nzụta a jikọtalarị na akaụntụ FuzeVPN. Banye n’akaụntụ ahụ iji nweta ndebanye gị.';

  @override
  String get guest_signOutWarning =>
      'Ị nwere ike iweghachite ndebanye gị site n’iweghachi ihe ị zụtara na otu akaụntụ Google Play ahụ.';

  @override
  String get guest_profileUnavailable =>
      'Akaụntụ gị jikọtalarị. Banye n’akaụntụ iji lee ma jikwaa ozi gị.';

  @override
  String get billing_acceptance =>
      'Site n’ịga n’ihu, ị na-anabata ụkpụrụ ojiji na iwu nzuzo.';

  @override
  String get guest_verifyEmailReminder =>
      'Kwado adreesị e-mail gị iji chebe akaụntụ gị. Ị nwere ike ịga n’ihu na-eji VPN gị.';

  @override
  String get guest_serviceUnavailable =>
      'Ọrụ ahụ adịghị dị nwa oge. Nwaa ọzọ n’oge na-adịghị anya.';

  @override
  String get guest_restoreError =>
      'Enweghị ike iweghachi ihe ị zụtara. Nwaa ọzọ site na akaụntụ Google Play ị jiri zụta ya.';

  @override
  String get guest_claimSuccess =>
      'Emepụtala akaụntụ gị. Echekwara ndebanye gị na inweta VPN gị.';

  @override
  String get guest_emailExists =>
      'E-mail a ejirilarị. Họrọ adreesị ọzọ ma ọ bụ banye n’akaụntụ gị dị adị. Nzụta gị ka dị site na Google Play.';

  @override
  String get guest_claimError =>
      'Enweghị ike imepụta akaụntụ gị. Ị nwere ike ịga n’ihu na-eji VPN gị ma nwaa ọzọ mgbe e mesịrị.';

  @override
  String get guest_secureStorageError =>
      'Enweghị ike ichebe oge ịbanye gị na ngwaọrụ a. Nwaa ọzọ.';

  @override
  String get guest_premiumRequired =>
      'Họrọ ndebanye iji mee ka VPN gị rụọ ọrụ.';

  @override
  String get welcome_viewPlans => 'Lee atụmatụ';

  @override
  String get google_continue => 'Gaa n’ihu na Google';

  @override
  String get google_or => 'ma ọ bụ';

  @override
  String get google_title => 'Akaụntụ FuzeVPN gị';

  @override
  String get google_settingUp => 'Mechaa imepụta akaụntụ gị';

  @override
  String get google_country => 'Mba ebe ị bi';

  @override
  String get google_profileDescription =>
      'Họrọ mba gị ma lelee akwụkwọ abụọ ahụ iji mepụta akaụntụ FuzeVPN gị.';

  @override
  String get google_claimDescription =>
      'Jikọta akaụntụ onye ọbịa gị na Google. Ndebanye gị na ngwaọrụ gị ga-anọgide jikọtara na akaụntụ a.';

  @override
  String get google_linkTitle => 'Jikọta Google na FuzeVPN';

  @override
  String get google_linkDescription =>
      'Kwado inweta akaụntụ FuzeVPN gị dị adị. Nzọụkwụ a anaghị arịọ paswọọdụ Google gị.';

  @override
  String get google_password => 'Paswọọdụ FuzeVPN';

  @override
  String get google_linkAccount => 'Kwado njikọta';

  @override
  String get google_requestEmail => 'Zipụrụ m e-mail nkwado';

  @override
  String get google_emailInstructions =>
      'Mepee e-mail FuzeVPN ma tinye koodu nkwado ahụ.';

  @override
  String get google_emailCode => 'Koodu nkwado e-mail';

  @override
  String get google_confirmEmail => 'Kwado koodu ahụ';

  @override
  String get google_restart => 'Họrọ akaụntụ Google ọzọ';

  @override
  String get google_resume => 'Nyochaa mbọ a';

  @override
  String get google_unavailable =>
      'Ịbanye na Google adịghị dị. Ị nwere ike iji e-mail na paswọọdụ.';

  @override
  String get google_expired => 'Mbọ a agwụla oge. Kagbuo ya ma malite ọzọ.';

  @override
  String get google_conflict =>
      'Akaụntụ Google a jikọtalarị ebe ọzọ. Akaụntụ gị na ndebanye gị dị ugbu a ka echekwara.';

  @override
  String get google_error =>
      'Ịbanye na Google emeghị nke ọma. Nwaa ọzọ; inweta gị dị ugbu a ka echekwara.';

  @override
  String get google_uncertain =>
      'Enweghị ike ịkwado nsonaazụ ahụ. Nyochaa mbọ a ma ọ bụ kagbuo ya tupu ị malite ọzọ.';

  @override
  String get google_cancelFailed =>
      'Enweghị ike ịkwado nkagbu ahụ. Nwaa ịkagbu ya ọzọ tupu ị hapụ ihuenyo a.';

  @override
  String get google_cancelled => 'Akagbuola ịbanye na Google.';

  @override
  String get google_selecting => 'Họrọ akaụntụ Google gị…';

  @override
  String get google_verifying => 'Na-enyocha akaụntụ gị…';

  @override
  String get google_emailUnavailable =>
      'Enweghị ike izipụ e-mail nkwado ahụ. Nwaa ọzọ mgbe e mesịrị.';

  @override
  String get google_emailSent => 'Ezipụla e-mail nkwado. Lelee igbe ozi gị.';

  @override
  String get google_rateLimited => 'Biko chere tupu ị nwaa ọzọ.';

  @override
  String get google_busy =>
      'Google adịghị dị mgbe ọrụ ọzọ na-aga n’ihu (njikọ VPN, akaụntụ ma ọ bụ onye ọbịa). Nwaa ọzọ mgbe ọ gwụchara; inweta gị dị ugbu a ka echekwara.';

  @override
  String get google_invalidPassword =>
      'Paswọọdụ FuzeVPN ezighị ezi. Akaụntụ gị dị ugbu a ka echekwara.';

  @override
  String get google_invalidCode =>
      'Koodu nkwado ezighị ezi ma ọ bụ agwụla oge.';

  @override
  String get google_accountChanged =>
      'Oge ịbanye gị agbanweela. Kagbuo mbọ a tupu ị malite ọzọ.';

  @override
  String get google_invalidResponse =>
      'Enweghị ike ịkwado nzaghachi ahụ. Inweta gị dị ugbu a ka echekwara.';

  @override
  String get google_invalidRegistration => 'Lelee mba gị na nkwenye abụọ ahụ.';

  @override
  String get google_consentRequired =>
      'Họrọ mba gị ma nabata akwụkwọ abụọ ahụ iji gaa n’ihu.';

  @override
  String get google_challengeRequired =>
      'Achọrọ nyocha nchekwa ọzọ. Inweta gị dị ugbu a ka echekwara.';

  @override
  String get google_challengeUnavailable =>
      'Nyocha nchekwa adịghị dị. Nwaa ọzọ mgbe e mesịrị.';

  @override
  String get google_intentMismatch =>
      'Mbọ ịbanye na Google gara aga ka na-echere. Kagbuo ya tupu ị malite ọrụ a.';

  @override
  String get google_challengeBlocked =>
      'Nyocha nchekwa achọrọ adịghị na ngwa a. Enweghị ike imecha ọrụ a ugbu a.';

  @override
  String get google_solveChallenge => 'Mezuo nyocha nchekwa';

  @override
  String get google_challengeTitle => 'Nyocha nchekwa';

  @override
  String get google_challengeReady =>
      'Emechala nyocha ahụ. Ị nwere ike ịkwado imepụta akaụntụ gị ugbu a.';

  @override
  String get google_challengeExpired =>
      'Nyocha ahụ agwụla oge. Mezuo ya ọzọ tupu ị kwado.';

  @override
  String get google_challengeCancelled =>
      'Akagbuola nyocha ahụ. Ị nwere ike ịnwa ya ọzọ.';

  @override
  String get google_challengeFailed =>
      'Nyocha nchekwa emeghị nke ọma. Nwaa ọzọ.';

  @override
  String get billing_trialTitle => 'Nwalee Fuze Premium n’efu';

  @override
  String get billing_trialSubtitle => 'Malite taa, chebe njikọ gị.';

  @override
  String get billing_trialWeeks => 'Nnwale efu izu abụọ';

  @override
  String billing_trialDays(String days) {
    return 'Nnwale efu ụbọchị $days';
  }

  @override
  String get billing_trialStart => 'Malite nnwale efu m';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Ọ bụrụ na ị malite taa, a na-atụ anya ịkwụ ụgwọ nke mbụ na $date.';
  }

  @override
  String get billing_trialTerms =>
      'A na-emegharị ya akpaaka n’ọnụahịa e kwuru. Iji zere ịkwụ ụgwọ, kagbuo na Google Play tupu nnwale ahụ agwụ.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Mgbe ahụ, $price kwa ọnwa';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Mgbe ahụ, $price kwa afọ';
  }

  @override
  String get billing_choosePeriod => 'Họrọ atụmatụ gị';

  @override
  String get billing_selectionHint => 'Họrọ otu atụmatụ iji gaa n’ihu.';

  @override
  String get billing_benefitConnection => 'Njikọ e zoro ezo';

  @override
  String get billing_benefitPrivacy => 'Nzuzo n’ịntanetị';

  @override
  String get billing_benefitNoAccount => 'Achọghị idebanye aha';

  @override
  String get billing_cancellation => 'Nkagbu na Google Play';

  @override
  String get billing_premiumTitle => 'Njikọ e chebere nke ọma karịa.';

  @override
  String get billing_premiumSubtitle => 'Chebe njikọ gị n’ọsọ nke gị.';

  @override
  String get billing_priceMonthly => 'kwa ọnwa';

  @override
  String get billing_priceYearly => 'kwa afọ';

  @override
  String get billing_trialToday => 'Enweghị ihe ị ga-akwụ taa';

  @override
  String get billing_trialConfirmation =>
      'Google Play na-ekwado ụbọchị, ọnụ ego ikpeazụ na ụtụ isi metụtara ya tupu ị kwado.';

  @override
  String get billing_offerChanged =>
      'Ụkpụrụ nke onyinye a agbanweela. Melite atụmatụ ndị ahụ ma họrọ ọzọ.';

  @override
  String get status_waitingNetwork => 'Na-echere netwọkụ';

  @override
  String get status_waitingNetworkDetail =>
      'Enweghị netwọkụ dị. VPN ga-enyocha njikọ mgbe netwọkụ laghachiri.';

  @override
  String get locations_favoriteLoadFailed =>
      'Enweghị ike ibudata ndị kacha amasị. Nwaa ọzọ.';

  @override
  String get locations_favoritesLoading => 'Na-ebudata ndị kacha amasị…';
}
