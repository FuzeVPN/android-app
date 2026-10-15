// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Protektahan ang iyong koneksyon';

  @override
  String get vpnDisclosure_body =>
      'Ginagamit ng FuzeVPN ang serbisyo ng VPN ng Android (VpnService) upang gumawa ng naka-encrypt na tunnel sa pagitan ng device na ito at ng mga server ng FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Habang aktibo ang VPN, dumadaan sa tunnel na ito ang trapiko sa Internet ng iyong mga app, mga address ng destinasyon at mga DNS request upang iruta ang iyong koneksyon, kahit nasa background ang FuzeVPN.';

  @override
  String get vpnDisclosure_statusBody =>
      'Ginagamit ng app ang status ng koneksyon, tagal nito at dami ng nailipat na data upang ipakita ang iyong koneksyon sa VPN. Maaari mo itong ihinto anumang oras.';

  @override
  String get vpnDisclosure_privacy => 'Privacy';

  @override
  String get vpnDisclosure_accept => 'Tanggapin at magpatuloy';

  @override
  String get vpnDisclosure_decline => 'Hindi ngayon';

  @override
  String get accountRestoration_title =>
      'Pansamantalang hindi magagamit ang account';

  @override
  String get accountRestoration_message =>
      'Napanatili ang iyong session. Subukang muli upang maibalik ang iyong account; maaari mo pa ring pamahalaan dito ang koneksyon ng VPN.';

  @override
  String get action_retry => 'Subukang muli';

  @override
  String get session_endingTitle => 'Tinatapos ang session';

  @override
  String get session_ending =>
      'Pinawalang-bisa ang iyong session. Ihihinto ang VPN at lilinisin ang session…';

  @override
  String get session_stopFailed =>
      'Hindi nakumpirma ang pagsasara ng VPN. Subukang muli bago muling mag-sign in.';

  @override
  String get session_cleanupFailed =>
      'Naihinto ang VPN, ngunit hindi nakumpirma ang pag-alis ng session. Subukang muli ang paglilinis.';

  @override
  String get session_retryStop => 'Subukang muli ang pagsasara';

  @override
  String get session_retryCleanup => 'Subukang muli ang paglilinis';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Ligtas na inihahanda ang FuzeVPN…';

  @override
  String get nav_connection => 'Koneksyon';

  @override
  String get nav_locations => 'Mga lokasyon';

  @override
  String get nav_account => 'Account';

  @override
  String get nav_devices => 'Mga device';

  @override
  String get nav_settings => 'Mga setting';

  @override
  String get action_refresh => 'I-refresh';

  @override
  String get auth_tab_login => 'Mag-sign in';

  @override
  String get auth_tab_register => 'Mag-sign up';

  @override
  String get auth_stepAccount => 'Account';

  @override
  String get auth_stepIdentity => 'Pagkakakilanlan';

  @override
  String get auth_stepAddress => 'Address at mga kasunduan';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Hakbang $current sa $total';
  }

  @override
  String get auth_tagline => 'Pinadali ang iyong VPN.';

  @override
  String get auth_keysLocal =>
      'Nananatili sa device na ito ang iyong mga pribadong VPN key.';

  @override
  String get form_email => 'Email address';

  @override
  String get form_password => 'Password';

  @override
  String get form_showPassword => 'Ipakita ang password';

  @override
  String get form_hidePassword => 'Itago ang password';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 byte. May ilang character na gumagamit ng higit sa isang byte.';

  @override
  String get form_firstName => 'Pangalan';

  @override
  String get form_lastName => 'Apelyido';

  @override
  String get form_phone => 'Telepono (+33612345678)';

  @override
  String get form_address => 'Address';

  @override
  String get form_address2 => 'Ikalawang linya ng address (opsyonal)';

  @override
  String get form_postalCode => 'Postal code';

  @override
  String get form_city => 'Lungsod';

  @override
  String get form_country => 'Code ng bansa (hal. FR)';

  @override
  String get action_login => 'Mag-sign in';

  @override
  String get action_createAccount => 'Gumawa ng account';

  @override
  String get action_createMyAccount => 'Gawin ang aking account';

  @override
  String get action_next => 'Magpatuloy';

  @override
  String get action_previous => 'Bumalik';

  @override
  String get action_forgotPassword => 'Nakalimutan ang password?';

  @override
  String get auth_noAccount => 'Wala ka pa bang account?';

  @override
  String get auth_requiredInformation =>
      'Gawin ang iyong account sa tatlong hakbang.';

  @override
  String get auth_termsPrefix => 'Tinatanggap ko ang ';

  @override
  String get auth_termsLink => 'mga tuntunin ng paggamit';

  @override
  String get auth_privacyPrefix => 'Tinatanggap ko ang ';

  @override
  String get auth_privacyLink => 'patakaran sa privacy';

  @override
  String get auth_consentRequired =>
      'Kailangan ang iyong pahintulot upang makagawa ng account.';

  @override
  String get validation_required => 'Kinakailangan ang field na ito.';

  @override
  String get validation_email => 'Maglagay ng wastong email address.';

  @override
  String get validation_password =>
      'Masyadong maikli ang password: hindi bababa sa 8 UTF-8 byte.';

  @override
  String get validation_passwordTooLong =>
      'Masyadong mahaba ang password: hanggang 72 UTF-8 byte lamang.';

  @override
  String get validation_phone =>
      'Gamitin ang internasyonal na format, halimbawa +33612345678.';

  @override
  String get validation_country =>
      'Gumamit ng dalawang titik na code ng bansa, halimbawa FR.';

  @override
  String get passwordReset_title => 'I-reset ang password';

  @override
  String get passwordReset_description =>
      'Ilagay ang email address ng iyong account upang humiling ng link para i-reset ang password.';

  @override
  String get passwordReset_send => 'Ipadala ang link';

  @override
  String get connection_title => 'Ang iyong koneksyon';

  @override
  String get connection_subtitle =>
      'Pumili ng lokasyon, pagkatapos ay i-on ang iyong VPN.';

  @override
  String get connection_prepare => 'Handa ka na bang kumonekta?';

  @override
  String get connection_advancedOptions => 'Mga advanced na opsyon';

  @override
  String get connection_location => 'Lokasyon';

  @override
  String get connection_chooseLocation => 'Pumili ng lokasyon';

  @override
  String get connection_protocol => 'Protocol';

  @override
  String get connection_connect => 'Kumonekta';

  @override
  String get connection_connecting => 'Kumokonekta…';

  @override
  String get connection_disconnect => 'Idiskonekta';

  @override
  String get connection_disconnecting => 'Dinidiskonekta';

  @override
  String get connection_locationChange => 'Binabago ang lokasyon…';

  @override
  String connection_unavailable(Object protocol) {
    return 'Hindi magagamit ang $protocol';
  }

  @override
  String get connection_activeLocation => 'Aktibong lokasyon';

  @override
  String get connection_duration => 'Tagal';

  @override
  String get connection_received => 'Natanggap';

  @override
  String get connection_sent => 'Naipadala';

  @override
  String get connection_lastHandshake => 'Huling ligtas na palitan';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ang nakalipas';
  }

  @override
  String get verification_title => 'Kumpirmahin ang iyong email address';

  @override
  String get verification_message =>
      'Kumpirmahin ang iyong email address upang magamit ang VPN sa teleponong ito.';

  @override
  String get verification_resend => 'Ipadala muli ang email';

  @override
  String get migration_title => 'Pagbabago ng lokasyon';

  @override
  String get migration_draining => 'Inihahanda ang pagbabago ng lokasyon…';

  @override
  String get migration_activating => 'Ina-activate ang bagong server…';

  @override
  String get migration_ready => 'Na-update ang lokasyon.';

  @override
  String get migration_blocked =>
      'Nangangailangan ng interbensyon ng server ang pagbabago ng lokasyon. Subukan muli mamaya o makipag-ugnayan sa suporta.';

  @override
  String get migration_progress => 'Pag-usad ng pagbabago ng lokasyon';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Pagitan ng mga pagsusuri: $seconds segundo.';
  }

  @override
  String get migration_resume => 'Ipagpatuloy ang pagbabago ng lokasyon';

  @override
  String get status_authorizing => 'Kailangan ng pahintulot';

  @override
  String get status_authorizingDetail =>
      'Tanggapin ang kahilingan ng Android upang payagan ang VPN.';

  @override
  String get status_preparing => 'Inihahanda';

  @override
  String get status_preparingDetail =>
      'Inihahanda ang iyong ligtas na koneksyon.';

  @override
  String get status_reconnecting => 'Muling kumokonekta…';

  @override
  String get status_reconnectingDetail =>
      'Naantala ang koneksyon. Sinusubukan ng VPN na muling kumonekta.';

  @override
  String get status_connecting => 'Kumokonekta';

  @override
  String get status_connectingDetail => 'Kumokonekta sa VPN server…';

  @override
  String get status_connected => 'Nakakonekta';

  @override
  String get status_connectedDetail => 'Aktibo ang iyong koneksyon sa VPN.';

  @override
  String get status_disconnecting => 'Dinidiskonekta';

  @override
  String get status_disconnectingDetail =>
      'Ihihinto ang iyong koneksyon sa VPN.';

  @override
  String get status_error => 'Hindi magagamit ang koneksyon';

  @override
  String get status_errorDetail =>
      'Hindi nakumpirma ang koneksyon sa VPN. Subukan muli.';

  @override
  String get status_idle => 'Nakadiskonekta';

  @override
  String get status_idleDetail =>
      'Ikonekta ang VPN upang maprotektahan ang iyong koneksyon.';

  @override
  String get trust_note =>
      'Hindi ihihinto ng pagsasara ng app ang VPN. Para ihinto ito, gamitin ang Idiskonekta.';

  @override
  String get locations_none => 'Kasalukuyang walang magagamit na lokasyon.';

  @override
  String get locations_available => 'Pumili ng iyong susunod na lokasyon.';

  @override
  String get locations_selected => 'Napiling lokasyon';

  @override
  String get locations_select => 'Gamitin ang lokasyong ito';

  @override
  String get locations_lockedTunnel =>
      'Idiskonekta ang VPN upang magpalit ng lokasyon.';

  @override
  String get locations_lockedMigration =>
      'Hintaying matapos ang pagbabago ng lokasyon.';

  @override
  String get devices_title => 'Ang iyong mga device';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit device';
  }

  @override
  String get devices_refresh => 'I-refresh ang mga device';

  @override
  String get devices_empty => 'Wala pang nakarehistrong VPN device.';

  @override
  String get devices_firstConnection =>
      'Idaragdag ang iyong telepono sa unang koneksyon.';

  @override
  String get devices_thisDevice => 'Device na ito';

  @override
  String devices_added(Object date) {
    return 'Idinagdag noong $date';
  }

  @override
  String get action_remove => 'Alisin';

  @override
  String get settings_title => 'Mga setting';

  @override
  String get settings_subtitle =>
      'Nasa iisang lugar ang iyong mga kagustuhan at account.';

  @override
  String get settings_appearance => 'Hitsura';

  @override
  String get settings_language => 'Wika';

  @override
  String get settings_languageDescription =>
      'Ang pinili mong wika ay ginagamit din sa mga notification ng VPN.';

  @override
  String get settings_account => 'Account';

  @override
  String get settings_signOut => 'Mag-sign out';

  @override
  String get settings_privacy => 'Patakaran sa privacy';

  @override
  String get settings_terms => 'Mga tuntunin ng paggamit';

  @override
  String get settings_security => 'Seguridad at transparency';

  @override
  String get settings_licenses => 'Mga lisensya ng component';

  @override
  String get settings_licensesDetail => 'Software na ginagamit sa app';

  @override
  String get settings_background =>
      'Mananatiling naka-on ang VPN kapag umalis ka sa app. Para ihinto ito, gamitin ang Idiskonekta sa tab na Koneksyon.';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Maliwanag';

  @override
  String get theme_dark => 'Madilim';

  @override
  String get language_system => 'Wika ng telepono';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Alisin ang device na ito?';

  @override
  String get dialog_removeCurrent =>
      'Mawawala sa VPN ang koneksyon ng teleponong ito at ang access nito. Aalisin ang datos ng koneksyon ng VPN kapag nakumpirma ng server.';

  @override
  String dialog_removeOther(Object name) {
    return 'Bawiin ang access sa VPN para kay “$name”. Hindi na ito maibabalik.';
  }

  @override
  String get dialog_signOut => 'Mag-sign out?';

  @override
  String get dialog_signOutMessage =>
      'Ihihinto ang VPN at kakailanganin mong mag-sign in muli. Mananatili sa teleponong ito ang iyong mga naka-encrypt na VPN key para sa susunod mong koneksyon.';

  @override
  String get action_cancel => 'Kanselahin';

  @override
  String get action_signOut => 'Mag-sign out';

  @override
  String get notice_close => 'I-dismiss ang mensahe';

  @override
  String get notice_sessionExpired_title => 'Nag-expire ang session';

  @override
  String get notice_sessionExpired_message =>
      'Nag-expire na ang iyong session. Mag-sign in muli.';

  @override
  String get notice_connectionFailed_title => 'Hindi nakakonekta';

  @override
  String get notice_invalidCredentials_message =>
      'Mali ang email address o password.';

  @override
  String get notice_emailVerification_title =>
      'Kailangang kumpirmahin ang email';

  @override
  String get notice_emailVerification_message =>
      'Kumpirmahin ang iyong email address bago magdagdag ng VPN device.';

  @override
  String get notice_rateLimited_title => 'Napakaraming pagtatangka';

  @override
  String get notice_deviceLimit_title => 'Naabot ang limitasyong 2 device';

  @override
  String get notice_deviceLimit_message =>
      'Alisin ang isang kasalukuyang device bago magdagdag ng isa pa.';

  @override
  String get notice_identityRenewal_title =>
      'Kailangang i-renew ang pagkakakilanlan ng VPN';

  @override
  String get notice_identityRenewal_message =>
      'Inalis ang pagkakakilanlang ito. Gumawa ng bagong lokal na pagkakakilanlan.';

  @override
  String get notice_migrationPending_title =>
      'Isinasagawa ang pagbabago ng lokasyon';

  @override
  String get notice_migrationPending_message =>
      'May isinasagawa nang pagbabago ng lokasyon.';

  @override
  String get notice_migrationBlocked_title =>
      'Na-block ang pagbabago ng lokasyon';

  @override
  String get notice_migrationBlocked_message =>
      'Nangangailangan ng interbensyon ng server ang pagbabago ng lokasyon. Subukan muli mamaya o makipag-ugnayan sa suporta.';

  @override
  String get notice_targetUnavailable_title =>
      'Pansamantalang hindi magagamit ang server';

  @override
  String get notice_targetUnavailable_message =>
      'Pansamantalang hindi magagamit ang server na ito.';

  @override
  String get notice_networkUnavailable_title =>
      'Hindi magagamit ang koneksyon sa internet';

  @override
  String get notice_networkUnavailable_message =>
      'Suriin ang iyong koneksyon at subukan muli.';

  @override
  String get notice_permissionDenied_title =>
      'Tinanggihan ang pahintulot sa VPN';

  @override
  String get notice_permissionDenied_message =>
      'Simulan muli ang koneksyon at tanggapin ang kahilingan sa pahintulot ng Android.';

  @override
  String get notice_wireguardTimeout_title => 'Hindi tumutugon ang server';

  @override
  String get notice_wireguardTimeout_message =>
      'Masyadong matagal ang koneksyon ng WireGuard. Subukan muli o pumili ng ibang lokasyon.';

  @override
  String get notice_tlsFailed_title => 'Tinanggihan ang ligtas na koneksyon';

  @override
  String get notice_tlsFailed_message =>
      'Hindi tinanggap ng server ang koneksyon ng OpenVPN. Subukan muli. Kung magpatuloy ang problema, magpatakbo ng diagnostic.';

  @override
  String get notice_tunRejected_title =>
      'Tinanggihan ng Android ang interface ng VPN';

  @override
  String get notice_tunRejected_message =>
      'Tinanggihan ng Android ang configuration ng network na hiningi ng OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Hindi masimulan ang OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'Hindi natapos ng OpenVPN engine ang pagsisimula. Subukan muli. Kung magpatuloy ang problema, makipag-ugnayan sa suporta.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Code ng diagnostic: $code';
  }

  @override
  String get notice_generic_title => 'Nabigo ang koneksyon ng VPN';

  @override
  String get notice_generic_message =>
      'May naganap na error. Subukan muli mamaya.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Nagawa ang account',
      'password_reset_sent':
          'Natanggap ang kahilingan para i-reset ang password',
      'verification_email_sent': 'Naipadala ang email ng kumpirmasyon',
      'location_migration_pending': 'Isinasagawa ang pagbabago ng lokasyon',
      'vpn_sign_in_required': 'Kailangang mag-sign in',
      'protocol_unavailable_at_location': 'Hindi magagamit ang protocol',
      'vpn_permission_denied': 'Tinanggihan ang pahintulot sa VPN',
      'revoked_identity_device_limit': 'Naabot ang limitasyong 2 device',
      'tunnel_start_unexpected': 'Hindi masimulan ang VPN',
      'flutter_disconnect_timeout': 'Hindi nakumpirma ang pagdiskonekta',
      'flutter_disconnect_unexpected': 'Hindi makapagdiskonekta',
      'device_revoked': 'Inalis ang device',
      'revoke_unexpected': 'Hindi maalis ang device',
      'identity_renewal_unexpected': 'Hindi ma-renew ang pagkakakilanlan',
      'openvpn_renewal_unexpected': 'Hindi ma-renew ang OpenVPN',
      'location_migration_blocked': 'Na-block ang pagbabago ng lokasyon',
      'location_migration_slow': 'Isinasagawa pa rin ang pagbabago ng lokasyon',
      'location_migration_conflict':
          'Kailangang i-refresh ang pagbabago ng lokasyon',
      'location_migration_verification_failed':
          'Hindi nakumpirma ang pagbabago ng lokasyon',
      'location_migration_device_changed':
          'Nagbago ang device habang binabago ang lokasyon',
      'tunnel_stop_failed': 'Hindi magagamit ang pagbabago ng lokasyon',
      'other': 'Nabigo ang operasyon',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Nagawa ang account, ngunit hindi naipadala ang email ng kumpirmasyon. Gamitin ang muling pagpapadala sa app.',
      'password_reset_sent':
          'Natanggap ang iyong kahilingan. Kung may account na tumutugma sa address na ito, maaari kang makatanggap ng email. Suriin din ang iyong spam folder.',
      'verification_email_sent':
          'Kakapadala lang ng bagong email ng kumpirmasyon.',
      'location_migration_pending':
          'Inihahanda pa rin ang paglipat sa $target. Maaari mo itong ipagpatuloy nang hindi muling ginagawa ang device.',
      'vpn_sign_in_required':
          'Mag-sign in sa iyong account bago simulan ang VPN.',
      'protocol_unavailable_at_location':
          'Hindi inaalok ng lokasyong ito ang napiling protocol. I-refresh ang mga lokasyon o pumili ng ibang protocol.',
      'vpn_permission_denied':
          'Tinanggihan ng Android ang pahintulot sa VPN. Simulan muli ang koneksyon at tanggapin ang kahilingan ng system.',
      'revoked_identity_device_limit':
          'Inalis ang access ng device na ito sa VPN at naabot na ang limitasyon ng device. Mag-alis ng device sa Account → Pamahalaan ang aking mga device.',
      'tunnel_start_unexpected':
          'Isang hindi inaasahang error ang nakaantala sa paghahanda ng tunnel. Suriin ang diagnostic code at subukan muli.',
      'flutter_disconnect_timeout':
          'Hindi nakumpirma ng Android sa tamang oras na nahinto ang VPN. Subukang ihinto itong muli.',
      'flutter_disconnect_unexpected':
          'Isang hindi inaasahang error ang pumigil sa pagkumpirma na nahinto ang tunnel.',
      'device_revoked':
          'Binawi ang access ng device sa VPN at inalis ang mga lokal na lihim nito.',
      'revoke_unexpected':
          'Hindi maalis ang device. I-refresh ang listahan at subukan muli.',
      'identity_renewal_unexpected':
          'Hindi nagawa ang bagong pagkakakilanlan ng VPN. I-refresh ang mga device at subukan muli.',
      'openvpn_renewal_unexpected':
          'Hindi ma-renew ang profile ng OpenVPN. Subukan muli o tingnan ang diagnostic code.',
      'location_migration_blocked':
          'Hindi makumpleto ng server ang pagbabagong ito sa ngayon. Pinanatili ang device at lokal na pagkakakilanlan nito.',
      'location_migration_slow':
          'Inihahanda pa rin ng server ang paglipat sa $target. Gamitin ang Ipagpatuloy pagkalipas ng ilang sandali.',
      'location_migration_conflict':
          'Nagbago ang estado ng device sa server. I-refresh ang mga device, pagkatapos ay ipagpatuloy ang pagbabago.',
      'location_migration_verification_failed':
          'Hindi kinumpirma ng server ang bagong lokasyon. Pinanatili ang dating lokal na pagkakakilanlan.',
      'location_migration_device_changed':
          'Hindi na tumutugma ang device na ibinalik ng server sa binabago. I-refresh ang mga device bago subukan muli.',
      'tunnel_stop_failed':
          'Dapat lubusang mahinto ang dating tunnel bago ang bagong koneksyon.',
      'other':
          'Hindi nakumpleto ang operasyon. Subukan muli o ipadala ang diagnostic code sa suporta.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Nag-expire ang session',
      'invalid_credentials': 'Nabigo ang pag-sign in',
      'email_verification_required': 'Kailangang kumpirmahin ang email',
      'verification_email_cooldown': 'Naipadala na ang email',
      'rate_limited': 'Napakaraming pagtatangka',
      'invalid_registration': 'Kailangang itama ang impormasyon',
      'email_exists': 'May account na',
      'invalid_profile': 'Hindi wastong profile',
      'invalid_device': 'Hindi wastong device',
      'invalid_location': 'Hindi magagamit ang lokasyon',
      'device_limit': 'Naabot ang limitasyon ng device',
      'device_exists': 'Ginagamit na ang pagkakakilanlan ng VPN',
      'device_identity_revoked':
          'Kailangang i-renew ang pagkakakilanlan ng VPN',
      'device_location_locked':
          'Kailangang i-refresh ang pagbabago ng lokasyon',
      'location_migration_pending': 'Isinasagawa ang pagbabago ng lokasyon',
      'location_migration_blocked': 'Na-block ang pagbabago ng lokasyon',
      'target_ca_mismatch': 'Hindi compatible na OpenVPN server',
      'location_migration_conflict':
          'Kailangang i-refresh ang pagbabago ng lokasyon',
      'server_full': 'Puno ang server',
      'capacity_unavailable': 'Pansamantalang hindi magagamit ang lokasyon',
      'target_unavailable': 'Pansamantalang hindi magagamit ang server',
      'not_found': 'Hindi nahanap ang item',
      'invalid_openvpn_csr': 'Hindi wastong pagkakakilanlan ng OpenVPN',
      'openvpn_profile_exists': 'May profile na ng OpenVPN',
      'openvpn_profile_revoked': 'Binawi ang profile ng OpenVPN',
      'openvpn_operation_pending': 'Isinasagawa ang operasyon ng OpenVPN',
      'openvpn_operation_terminal': 'Naantala ang operasyon ng OpenVPN',
      'openvpn_address_unavailable': 'Hindi magagamit ang address ng OpenVPN',
      'openvpn_profile_conflict': 'Salungatan sa OpenVPN',
      'openvpn_signer_unavailable': 'Hindi magagamit ang OpenVPN',
      'email_delivery_unavailable': 'Hindi magagamit ang email',
      'invalid_token': 'Hindi wastong link',
      'network_unavailable': 'Hindi magagamit ang koneksyon sa internet',
      'invalid_json': 'Hindi wastong kahilingan',
      'invalid_api_response': 'Hindi wastong tugon ng server',
      'ipv6_unavailable': 'Hindi magagamit ang IPv6',
      'invalid_ip_families': 'Tinanggihan ang configuration ng network',
      'other': 'Hindi magagamit ang serbisyo',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Nag-expire na ang iyong session. Mag-sign in muli.',
      'invalid_credentials': 'Mali ang email address o password.',
      'email_verification_required':
          'Kumpirmahin ang iyong email address bago magdagdag ng VPN device.',
      'invalid_registration':
          'Suriin ang hinihinging impormasyon at mga pahintulot.',
      'email_exists': 'May account nang gumagamit ng email address na ito.',
      'invalid_profile': 'Suriin ang impormasyon ng iyong profile.',
      'invalid_device':
          'Hindi wasto ang pangalan o lokal na pagkakakilanlan ng device na ito.',
      'invalid_location': 'I-refresh ang listahan ng lokasyon at subukan muli.',
      'device_limit':
          'Alisin ang isang kasalukuyang device bago magdagdag ng isa pa.',
      'device_exists':
          'Naka-link na ang pagkakakilanlan ng VPN na ito sa ibang account.',
      'device_identity_revoked':
          'Inalis ang pagkakakilanlang ito. Kailangang gumawa ng bagong lokal na pagkakakilanlan.',
      'device_location_locked':
          'Kakabago lang ng lokasyon ng device na ito. Ipagpapatuloy ng app ang pagbabagong isinasagawa.',
      'location_migration_pending':
          'May isinasagawa nang pagbabago ng lokasyon.',
      'location_migration_blocked':
          'Nangangailangan ng interbensyon ng server ang pagbabago ng lokasyon. Subukan muli mamaya o makipag-ugnayan sa suporta.',
      'target_ca_mismatch':
          'Hindi pa compatible ang server na ito sa kasalukuyang profile ng OpenVPN.',
      'location_migration_conflict':
          'I-refresh ang mga device, pagkatapos ay subukang muli ang pagbabago ng lokasyon.',
      'server_full':
          'Naabot na ng lokasyong ito ang limitasyon ng koneksyon. Pumili ng ibang lokasyon o subukan muli mamaya.',
      'capacity_unavailable':
          'Hindi namin makumpirma kung magagamit ang lokasyong ito ngayon. Pumili ng ibang lokasyon o subukan muli mamaya.',
      'target_unavailable': 'Pansamantalang hindi magagamit ang server na ito.',
      'not_found': 'Hindi na magagamit ang item na ito sa iyong account.',
      'invalid_openvpn_csr':
          'Gumawa ng bagong pagkakakilanlan ng OpenVPN at subukan muli.',
      'openvpn_profile_exists':
          'May profile na ng OpenVPN para sa device na ito.',
      'openvpn_profile_revoked':
          'I-renew ang profile ng OpenVPN upang magpatuloy.',
      'openvpn_operation_pending':
          'Ipinapamahagi pa rin ang pagbabago. Subukan muli mamaya.',
      'openvpn_operation_terminal':
          'Gumawa ng bagong pagkakakilanlan ng OpenVPN at subukan muli.',
      'openvpn_address_unavailable':
          'Kasalukuyang walang magagamit na address ng OpenVPN.',
      'openvpn_profile_conflict':
          'Nagbago ang profile. I-refresh ang mga device at subukan muli.',
      'openvpn_signer_unavailable':
          'Pansamantalang hindi magagamit ang serbisyo ng OpenVPN.',
      'email_delivery_unavailable':
          'Hindi maipadala ang email. Subukan muli mamaya.',
      'invalid_token':
          'Hindi wasto o nag-expire na ang link na ito. Humiling ng bago.',
      'network_unavailable':
          'Suriin ang iyong koneksyon sa internet at subukan muli.',
      'invalid_json': 'Suriin ang inilagay na impormasyon at subukan muli.',
      'invalid_api_response':
          'Nagbalik ang server ng hindi inaasahang tugon. Subukan muli mamaya.',
      'ipv6_unavailable':
          'Hindi ma-activate ng server ang IPv6 sa ngayon. Subukan muli mamaya.',
      'invalid_ip_families':
          'Hindi kumpleto ang configuration ng tunnel o hindi ito tumutugma sa mga awtorisadong address. Subukan muli mula sa app.',
      'other': 'May naganap na error sa server. Subukan muli mamaya.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Subukan muli pagkalipas ng ilang sandali.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Subukan muli pagkalipas ng $seconds segundo.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Hindi magagamit ang pagpapatuloy ng system VPN',
      'system_vpn_resume_corrupt': 'Hindi wasto ang pagpapatuloy ng system VPN',
      'system_vpn_resume_session_invalid':
          'Hindi wastong session ng pagpapatuloy ng VPN',
      'system_vpn_resume_identity_changed':
          'Nagbago ang pagkakakilanlan ng VPN',
      'system_vpn_resume_identity_invalid':
          'Hindi wastong pagkakakilanlan para sa pagpapatuloy ng VPN',
      'system_vpn_resume_storage_failed':
          'Hindi magagamit ang imbakan para sa pagpapatuloy ng VPN',
      'system_vpn_resume_network_timeout':
          'Walang network ang pagpapatuloy ng VPN',
      'system_vpn_resume_blocked': 'Na-block ang pagpapatuloy ng VPN',
      'system_vpn_resume_failed': 'Nabigo ang pagpapatuloy ng VPN',
      'system_vpn_resume_error_invalid':
          'Hindi wastong error sa pagpapatuloy ng VPN',
      'wireguard_identity_store_failed':
          'Hindi na-save ang pagkakakilanlan ng WireGuard',
      'wireguard_identity_unavailable':
          'Hindi magagamit ang pagkakakilanlan ng WireGuard',
      'vpn_host_destroyed': 'Nahinto ang Android VPN host',
      'vpn_host_unavailable': 'Hindi magagamit ang Android VPN host',
      'vpn_permission_required': 'Kailangan ng pahintulot sa VPN',
      'vpn_permission_denied': 'Tinanggihan ang pahintulot sa VPN',
      'vpn_permission_request_failed': 'Hindi makahiling ng pahintulot',
      'wireguard_foreground_service_unavailable':
          'Hindi magagamit ang serbisyo ng WireGuard',
      'wireguard_identity_invalid': 'Hindi wastong lokal na key ng WireGuard',
      'wireguard_identity_in_use':
          'Ginagamit na ang pagkakakilanlan ng WireGuard',
      'wireguard_configuration_invalid':
          'Hindi wastong configuration ng WireGuard',
      'wireguard_operation_pending': 'Aktibo pa rin ang operasyon ng WireGuard',
      'wireguard_start_failed': 'Tinanggihan ang pagsisimula ng WireGuard',
      'wireguard_stop_timeout': 'Hindi nakumpirma ang paghinto ng WireGuard',
      'wireguard_handshake_timeout': 'Hindi tumugon ang WireGuard',
      'openvpn_connection_timeout': 'Hindi tumugon ang OpenVPN',
      'openvpn_core_unavailable': 'Hindi magagamit ang OpenVPN engine',
      'openvpn_operation_pending': 'Aktibo pa rin ang session ng OpenVPN',
      'openvpn_stop_timeout': 'Hindi nakumpirma ang paghinto ng OpenVPN',
      'openvpn_profile_unavailable': 'Nawawala ang lokal na profile ng OpenVPN',
      'openvpn_native_failed': 'Naantala ang native na tawag sa OpenVPN',
      'openvpn_key_generation_failed': 'Hindi makagawa ng OpenVPN P-256 key',
      'openvpn_csr_generation_failed': 'Hindi makagawa ng OpenVPN CSR',
      'openvpn_identity_store_failed':
          'Hindi na-save ang pagkakakilanlan ng OpenVPN',
      'openvpn_identity_clear_failed': 'Hindi kumpletong pag-alis ng OpenVPN',
      'openvpn_identity_in_use':
          'Ginagamit pa rin ang pagkakakilanlan ng OpenVPN',
      'openvpn_tls_verification_required':
          'Nawawala ang TLS verification ng OpenVPN',
      'openvpn_cipher_invalid': 'Hindi wastong cipher ng OpenVPN',
      'openvpn_profile_rejected': 'Tinanggihan ang profile ng OpenVPN',
      'openvpn_identity_inconsistent':
          'Hindi magkakatugma ang pagkakakilanlan ng OpenVPN',
      'tls_handshake_failed': 'Tinanggihan ang negosasyon ng OpenVPN',
      'tls_alert_unknown_ca':
          'Hindi nakilala ang certificate ng kliyente ng OpenVPN',
      'tls_alert_bad_certificate':
          'Tinanggihan ang certificate ng kliyente ng OpenVPN',
      'tls_alert_unsupported_certificate':
          'Hindi suportadong certificate ng OpenVPN',
      'tls_client_certificate_required':
          'Kailangan ng certificate ng kliyente ng OpenVPN',
      'tls_alert_misc': 'TLS alert ng OpenVPN',
      'tls_signature_algorithm_rejected':
          'Hindi suportadong signature ng OpenVPN',
      'tls_handshake_rejected': 'Tinanggihan ang TLS negotiation ng OpenVPN',
      'tls_version_rejected': 'Hindi compatible na bersyon ng OpenVPN TLS',
      'tls_certificate_expired': 'Nag-expire ang TLS certificate',
      'tls_certificate_revoked': 'Binawi ang TLS certificate',
      'transport_failed': 'Hindi maabot ang OpenVPN server',
      'tun_configuration_rejected': 'Hindi makagawa ng interface ng OpenVPN',
      'tun_setup_failed': 'Nabigo ang pag-set up ng OpenVPN TUN',
      'tun_interface_create_failed':
          'Nabigo ang paggawa ng interface ng OpenVPN',
      'tun_interface_disabled': 'Na-disable ang interface ng OpenVPN',
      'tun_halted': 'Naantala ang interface ng OpenVPN',
      'tun_already_established': 'Bukas na ang interface ng OpenVPN',
      'tun_addresses_missing': 'Nawawala ang address ng OpenVPN',
      'tun_routes_missing': 'Nawawala ang mga ruta ng OpenVPN',
      'tun_dns_missing': 'Nawawala ang DNS ng OpenVPN',
      'tun_permission_revoked': 'Binawi ang pahintulot sa VPN',
      'tun_establish_returned_null':
          'Tinanggihan ng Android ang interface ng VPN',
      'openvpn_service_start_failed': 'Hindi magagamit ang serbisyo ng OpenVPN',
      'openvpn_operation_timeout': 'Nag-timeout ang tawag sa OpenVPN',
      'openvpn_start_failed': 'Tinanggihan ang pagsisimula ng OpenVPN',
      'openvpn_connection_failed': 'Naantala ang koneksyon ng OpenVPN',
      'openvpn_core_status_error': 'Nagtapos ang OpenVPN Core na may error',
      'openvpn_stopped_before_connected': 'Nahinto ang OpenVPN bago kumonekta',
      'openvpn_auth_failed': 'Tinanggihan ang authentication ng OpenVPN',
      'openvpn_client_setup_failed':
          'Nabigo ang pag-set up ng kliyente ng OpenVPN',
      'openvpn_client_halted': 'Naantala ang kliyente ng OpenVPN',
      'openvpn_client_restart': 'Hiniling ang pag-restart ng OpenVPN',
      'openvpn_inactive_timeout':
          'Masyadong matagal na hindi aktibo ang OpenVPN',
      'openvpn_session_expired': 'Nag-expire ang session ng OpenVPN',
      'openvpn_credentials_required':
          'Hindi suportadong authentication ng OpenVPN',
      'openvpn_proxy_failed': 'Nabigo ang intermediary transport ng OpenVPN',
      'openvpn_compression_failed': 'Tinanggihan ang compression ng OpenVPN',
      'openvpn_ntlm_crypto_unavailable':
          'Hindi magagamit ang NTLM encryption ng OpenVPN',
      'openvpn_feature_unsupported': 'Hindi suportadong feature ng OpenVPN',
      'network_unavailable': 'Hindi magagamit ang koneksyon sa internet',
      'network_lost': 'Hindi magagamit ang network',
      'certificate_validation_failed': 'Tinanggihan ang certificate ng server',
      'openvpn_certificate_expired': 'Nag-expire ang certificate ng OpenVPN',
      'tunnel_active_for_another_account':
          'Aktibo pa ang tunnel ng ibang account',
      'tunnel_already_active': 'Aktibo na ang native tunnel',
      'tunnel_stop_timeout': 'Hindi nakumpirma ang paghinto ng $protocol',
      'tunnel_disconnected': 'Naantala ang $protocol',
      'native_bridge_unavailable': 'Hindi magagamit ang Android bridge',
      'native_operation_failed': 'Naantala ang operasyon ng Android',
      'invalid_arguments': 'Hindi kumpletong parameter ng VPN',
      'invalid_account_id': 'Hindi wastong VPN account',
      'invalid_device_id': 'Hindi wastong identifier ng device',
      'storage_key_not_allowed': 'Tinanggihan ang storage key',
      'secure_storage_read_failed': 'Nabigo ang ligtas na pagbasa',
      'secure_storage_write_failed': 'Nabigo ang ligtas na pagsulat',
      'key_generation_failed': 'Hindi makagawa ng WireGuard key',
      'csr_generation_failed': 'Hindi makagawa ng OpenVPN CSR',
      'other': 'Hindi nauri na native VPN error',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Hindi makahanap ang Android ng session ng VPN na maaaring ipagpatuloy. Magsimula ng bagong koneksyon sa app.',
      'system_vpn_resume_corrupt':
          'Hindi wasto ang naka-save na datos para ipagpatuloy ang VPN at hindi ito gagamitin. Magsimula ng bagong koneksyon.',
      'system_vpn_resume_session_invalid':
          'Hindi na maipagpapatuloy ng naka-save na session ang VPN. Mag-sign in muli sa app.',
      'system_vpn_resume_identity_changed':
          'Nagbago ang lokal na pagkakakilanlan ng VPN. Itinigil ang pagpapatuloy; magsimula ng bagong koneksyon.',
      'system_vpn_resume_identity_invalid':
          'Hindi wasto ang pagkakakilanlan para sa pagpapatuloy. Magsimula ng bagong koneksyon.',
      'system_vpn_resume_storage_failed':
          'Hindi mabasa o ma-update ng Android ang naka-encrypt na datos para sa pagpapatuloy. Magsimula ng bagong koneksyon.',
      'system_vpn_resume_network_timeout':
          'Hindi nakahanap ang Android ng network sa tamang oras upang ipagpatuloy ang VPN. Subukan muli kapag may available na network.',
      'system_vpn_resume_blocked':
          'Na-block ang pagpapatuloy ng VPN. Suriin ang mga setting ng Android, pagkatapos ay magsimula ng bagong koneksyon.',
      'system_vpn_resume_failed':
          'Nabigo ang pagpapatuloy ng Android VPN. Magsimula ng bagong koneksyon sa app.',
      'system_vpn_resume_error_invalid':
          'Nagbalik ang Android ng hindi magagamit na error sa pagpapatuloy. Magsimula ng bagong koneksyon.',
      'wireguard_identity_store_failed':
          'Hindi na-save ng Android ang naka-encrypt na pagkakakilanlan ng WireGuard ng account na ito.',
      'wireguard_identity_unavailable':
          'Walang magagamit na pagkakakilanlan ng WireGuard para sa koneksyong ito.',
      'vpn_host_destroyed':
          'Nahinto ang Android component na nagho-host ng VPN. Magsimula ng bagong koneksyon.',
      'vpn_host_unavailable':
          'Hindi magawa ng Android ang component na nagho-host ng VPN. Subukan muli pagkatapos suriin ang mga setting ng VPN.',
      'openvpn_renewal_required':
          'Nangangailangan ang certificate ng aksyon sa app bago kumonekta.',
      'openvpn_recovery_failed':
          'Nabigo ang awtomatikong pag-recover. Magsimula ng bagong koneksyon sa app.',
      'openvpn_recovery_exhausted':
          'Nagamit na ang awtomatikong pag-recover. Magsimula ng bagong koneksyon sa app.',
      'vpn_permission_required':
          'Kailangan ng Android ng bagong awtorisasyon sa VPN bago simulan ang tunnel.',
      'vpn_permission_denied':
          'Payagan ang FuzeVPN sa kahilingan ng Android upang magpatuloy.',
      'vpn_permission_request_failed':
          'Hindi mabuksan ng Android ang screen ng pahintulot sa VPN.',
      'wireguard_foreground_service_unavailable':
          'Hindi mapanatili ng Android sa foreground ang serbisyo ng WireGuard.',
      'wireguard_identity_invalid':
          'Hindi mabasa o hindi wasto ang naka-encrypt na WireGuard key ng account na ito.',
      'wireguard_identity_in_use':
          'Ginagamit pa rin ng ibang operasyon ang WireGuard key ng account na ito.',
      'wireguard_configuration_invalid':
          'Hindi wasto ang natanggap na address, DNS, server key o mga ruta ng WireGuard.',
      'wireguard_operation_pending':
          'Hindi pa nailalabas ng nakaraang operasyon ng WireGuard ang native service nito.',
      'wireguard_start_failed':
          'Tinanggihan ng WireGuard engine ang pag-activate ng configuration.',
      'wireguard_stop_timeout':
          'Hindi nakumpirma ng serbisyo ng WireGuard ang pag-release ng interface ng VPN sa itinakdang oras.',
      'wireguard_handshake_timeout':
          'Hindi nakumpirma ng tunnel ang handshake sa server sa tamang oras.',
      'openvpn_connection_timeout':
          'Hindi nakumpirma ng OpenVPN ang koneksyon sa server sa tamang oras.',
      'openvpn_core_unavailable':
          'Walang magagamit na OpenVPN engine sa bersyong ito ng app.',
      'openvpn_operation_pending':
          'Hawak pa ng native engine ang dating session ng OpenVPN at tumatangging gumawa ng pangalawa.',
      'openvpn_stop_timeout':
          'Hindi nakumpirma ng OpenVPN Core na nahinto at nawasak ang native session nito sa itinakdang oras.',
      'openvpn_profile_unavailable':
          'Walang validated na profile ng OpenVPN na mababasa para sa koneksyong ito.',
      'openvpn_native_failed':
          'Naantala ng error sa app ang OpenVPN. Subukang kumonekta muli. Kung magpatuloy ang problema, magpatakbo ng diagnostic.',
      'openvpn_key_generation_failed':
          'Hindi makagawa o makabasa ang Android Keystore ng hindi mae-export na P-256 private key.',
      'openvpn_csr_generation_failed':
          'Hindi ma-sign ng Android Keystore key ang kahilingan para sa certificate ng OpenVPN.',
      'openvpn_identity_store_failed':
          'Hindi ma-save ang certificate o profile ng OpenVPN sa naka-encrypt na imbakan.',
      'openvpn_identity_clear_failed':
          'Hindi maalis ng Android ang buong lokal na pagkakakilanlan ng OpenVPN para sa account na ito.',
      'openvpn_identity_in_use':
          'Ginagamit pa rin ng native OpenVPN session ang key o certificate ng device na ito.',
      'openvpn_tls_verification_required':
          'Hindi tahasang hinihingi ng profile ang pag-verify ng certificate ng server.',
      'openvpn_cipher_invalid':
          'Nagbigay ang server ng encryption algorithm na wala sa pinapayagang listahan.',
      'openvpn_profile_rejected':
          'Hindi compatible ang profile na natanggap mula sa server. Gawin muli ang device na ito at subukan muli.',
      'openvpn_identity_inconsistent':
          'Hindi tumutugma ang certificate sa secure identity ng teleponong ito. Walang lokal na profile na pinalitan.',
      'tls_handshake_failed':
          'Tinanggihan ng server ang TLS negotiation. Gawin muli ang profile kung magpatuloy ang problema.',
      'tls_alert_unknown_ca':
          'Hindi kinikilala ng server ang awtoridad ng certificate ng device na ito. Kailangang suriin ang OpenVPN server.',
      'tls_alert_bad_certificate':
          'Tinanggihan ng server ang certificate ng device na ito. Gawin muli ang device bago subukan ulit.',
      'tls_alert_unsupported_certificate':
          'Hindi sinusuportahan ng server ang secure certificate type na ginagamit ng Android.',
      'tls_client_certificate_required':
          'Kailangan ng server ng certificate ng kliyente, ngunit hindi makapagbigay nito ang OpenVPN Core.',
      'tls_alert_misc':
          'Nagbalik ang server ng TLS alert na wala sa mga kategorya ng certificate at bersyon.',
      'tls_signature_algorithm_rejected':
          'Tinanggihan ng server ang ECDSA P-256 algorithm ng Android Keystore key.',
      'tls_handshake_rejected':
          'Naantala ng server ang TLS negotiation bago ang koneksyon.',
      'tls_version_rejected':
          'Walang nakitang magkaparehong bersyon ng TLS ang kliyente at server.',
      'tls_certificate_expired':
          'Nag-expire ang certificate na ipinakita habang kumokonekta.',
      'tls_certificate_revoked':
          'Binawi ang certificate na ipinakita habang kumokonekta.',
      'transport_failed':
          'Hindi tumutugon ang OpenVPN server sa kasalukuyang network. Subukan muli pagkalipas ng ilang sandali.',
      'tun_configuration_rejected':
          'Tinanggihan ng Android ang configuration ng network na hiningi ng OpenVPN.',
      'tun_setup_failed':
          'Tinanggihan ng OpenVPN Core ang network plan bago gawin ang Android interface.',
      'tun_interface_create_failed':
          'Hindi makuha ng OpenVPN Core ang TUN interface mula sa Android VpnService.',
      'tun_interface_disabled':
          'Na-disable ng Android o OpenVPN Core ang TUN interface habang kumokonekta.',
      'tun_halted':
          'Nakatanggap ang OpenVPN Core ng kahilingang ihinto ang TUN interface.',
      'tun_already_established':
          'Humiling ang OpenVPN ng ikalawang interface sa parehong koneksyon. Ihihinto ang tunnel para sa kaligtasan.',
      'tun_addresses_missing':
          'Hindi nagbigay ang server ng magagamit na tunnel address.',
      'tun_routes_missing':
          'Hindi nagbigay ang server ng magagamit na tunnel routes.',
      'tun_dns_missing':
          'Hindi nagbigay ang server ng magagamit na DNS server.',
      'tun_permission_revoked':
          'Binawi ng Android ang pahintulot sa VPN habang kumokonekta.',
      'tun_establish_returned_null':
          'Hindi ginawa ng Android ang interface, karaniwang dahil aktibo pa ang ibang VPN.',
      'openvpn_service_start_failed':
          'Hindi masimulan ng Android ang foreground service ng OpenVPN.',
      'openvpn_operation_timeout':
          'Lumampas sa maximum na tagal ang JNI call sa OpenVPN Core.',
      'openvpn_start_failed':
          'Handa na ang serbisyo ng Android, ngunit hindi tinanggap ng OpenVPN Core ang pagsisimula ng profile.',
      'openvpn_connection_failed':
          'Nahinto ang OpenVPN Core bago ilabas ang CONNECTED event.',
      'openvpn_core_status_error':
          'Nagtapos ang native OpenVPN loop nang may error at walang mas tiyak na terminal event.',
      'openvpn_stopped_before_connected':
          'Nahinto ang native OpenVPN loop bago ang CONNECTED, nang walang tahasang Core error.',
      'openvpn_auth_failed':
          'Tinanggihan ng OpenVPN server ang authentication ng profile.',
      'openvpn_client_setup_failed':
          'Hindi ma-initialize ng OpenVPN Core ang kliyente bago ang koneksyon sa network.',
      'openvpn_client_halted':
          'Nakatanggap ang OpenVPN Core ng terminal stop para sa kliyente.',
      'openvpn_client_restart':
          'Humiling ang OpenVPN Core ng pag-restart ng transport session nito.',
      'openvpn_inactive_timeout':
          'Isinara ng OpenVPN Core ang session matapos ang timeout ng kawalan ng aktibidad.',
      'openvpn_session_expired':
          'Iniulat ng server na nag-expire ang session ng OpenVPN.',
      'openvpn_credentials_required':
          'Humihiling ang server o proxy ng interactive credentials na wala sa certificate profile na ito.',
      'openvpn_proxy_failed':
          'Iniulat ng OpenVPN Core ang pagkabigo ng naka-configure na proxy o relay.',
      'openvpn_compression_failed':
          'Tinanggihan ng OpenVPN Core ang compression mode na inanunsyo ng profile o server.',
      'openvpn_ntlm_crypto_unavailable':
          'Humihiling ang profile ng NTLM encryption na hindi magagamit sa bersyong ito.',
      'openvpn_feature_unsupported':
          'Nangangailangan ang profile o server ng feature na wala sa Android client na ito.',
      'network_unavailable': 'Walang magagamit na pisikal na network.',
      'network_lost': 'Nahinto ang tunnel matapos mawala ang network.',
      'certificate_validation_failed':
          'Hindi ma-verify ang pagkakakilanlan ng OpenVPN server.',
      'openvpn_certificate_expired':
          'I-renew ang profile ng OpenVPN bago muling kumonekta.',
      'tunnel_active_for_another_account':
          'Dapat munang mahinto ang tunnel ng ibang account bago ang koneksyong ito.',
      'tunnel_already_active':
          'Iniulat ng Android na ginagamit pa rin ng dating session ng VPN ang interface.',
      'tunnel_stop_timeout':
          'Hindi nakumpirma ng $protocol engine ang pag-release ng interface ng VPN sa itinakdang oras.',
      'tunnel_disconnected':
          'Iniulat ng native engine na hindi inaasahang natapos ang tunnel matapos simulan.',
      'native_bridge_unavailable':
          'Hindi ma-access ng app ang serbisyo ng Android VPN. Isara at buksan muli ang app, pagkatapos ay subukan muli.',
      'native_operation_failed':
          'Naantala ng error sa app ang operasyon ng VPN. Subukan muli. Kung magpatuloy ang problema, magpatakbo ng diagnostic.',
      'invalid_arguments':
          'Hindi kumpleto ang impormasyong kailangan para sa operasyong ito ng VPN. Subukan muli. Kung magpatuloy ang problema, magpatakbo ng diagnostic.',
      'invalid_account_id':
          'Ang native operation ay hindi nauugnay sa wastong account identifier.',
      'invalid_device_id':
          'Nawawala o hindi wasto ang device identifier na ipinadala sa native engine.',
      'storage_key_not_allowed':
          'Hinarang ng Android bridge ang key na wala sa pinapayagang listahan ng storage.',
      'secure_storage_read_failed':
          'Hindi ma-decrypt ng Android Keystore ang lokal na data ng account na ito.',
      'secure_storage_write_failed':
          'Hindi ma-encrypt o ma-save ng Android Keystore ang lokal na data.',
      'key_generation_failed':
          'Hindi makagawa o makabasa ang Android ng WireGuard key sa ligtas na imbakan.',
      'csr_generation_failed':
          'Hindi makagawa o maka-sign ang Android Keystore ng OpenVPN P-256 CSR.',
      'other':
          'Nabigo ang isang hindi dokumentadong native branch. Ipadala sa suporta ang diagnostic code na ipinapakita sa ibaba.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Nakabukas na ang kahilingan sa pahintulot';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Ipinapakita na ang kahilingan sa pahintulot ng Android VPN. Kumpletuhin ito bago muling subukan.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Naantala ang kahilingan sa pahintulot ng VPN';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Nagsara ang screen ng pahintulot ng VPN bago makatanggap ng tugon ang app.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Hindi nakumpirma ang koneksyon ng OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'Hindi makumpirma ang koneksyon ng OpenVPN. Ihihinto ito para sa kaligtasan. Subukan muli.';

  @override
  String get openvpnCleanup_title => 'Binawi ang profile ng OpenVPN';

  @override
  String get openvpnCleanup_working =>
      'Ihihinto at aalisin ang binawing profile ng OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Hindi nakumpirma ang pagsasara ng OpenVPN. Subukang muli bago gumawa ng bagong profile.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Hindi lubusang maalis ang binawing profile ng OpenVPN. Subukang muli ang paglilinis.';

  @override
  String get openvpnCleanup_complete =>
      'Naalis na ang binawing profile ng OpenVPN. I-tap ang Kumonekta upang gumawa ng bago.';

  @override
  String get network_title => 'Configuration ng network';

  @override
  String get network_ipv4Fallback =>
      'Pansamantalang hindi magagamit ang IPv6. Magpapatuloy ang paghahanda gamit ang IPv4.';

  @override
  String get network_rejectedTitle =>
      'Tinanggihan ang configuration ng network';

  @override
  String get network_rejectedMessage =>
      'Hindi kumpleto ang configuration ng tunnel o hindi ito tumutugma sa mga awtorisadong address. Subukan muli mula sa app.';

  @override
  String get network_unreadableTitle =>
      'Hindi mabasa ang lokal na configuration';

  @override
  String get network_unreadableMessage =>
      'Hindi magagamit ang naka-save na configuration ng OpenVPN network. Kumonekta muli mula sa app upang i-update ito.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Proteksyon ng network';

  @override
  String get protection_subtitle =>
      'I-block ang direktang access sa internet kapag nadiskonekta ang VPN.';

  @override
  String get protection_active => 'Aktibo ang proteksyon ng system';

  @override
  String get protection_alwaysOnOnly =>
      'Naka-enable ang always-on VPN; i-on ang pag-block sa labas ng VPN';

  @override
  String get protection_inactive => 'Hindi aktibo ang proteksyon ng system';

  @override
  String get protection_unknown => 'Suriin ang proteksyon ng system';

  @override
  String get protection_openSettings => 'Buksan ang mga setting ng Android';

  @override
  String get protection_dialogTitle => 'I-set up ang proteksyon ng network';

  @override
  String get protection_dialogMessage =>
      'Pinamamahalaan ng Android ang always-on VPN at pag-block ng mga koneksyon sa labas ng VPN. Tiyaking napili ang FuzeVPN at i-enable ang pag-block sa mga setting ng system.';

  @override
  String get protection_dialogOpen => 'Buksan ang mga setting';

  @override
  String get session_systemProtectionNote =>
      'Kung bina-block pa rin ng Android ang trapiko sa labas ng VPN, buksan ang mga setting ng system upang suriin o baguhin ang proteksyong ito.';

  @override
  String get diagnostics_title => 'Diagnostics';

  @override
  String get diagnostics_settingsTitle => 'Diagnostics ng app';

  @override
  String get diagnostics_automaticTitle => 'Magpadala ng mahahalagang error';

  @override
  String get diagnostics_automaticDescription =>
      'Magbahagi ng maikling teknikal na ulat kapag may naganap na mahalagang error.';

  @override
  String get diagnostics_privacy =>
      'Naka-link ang mga ipinadalang ulat sa naka-sign-in na account at itinatago nang 30 araw. Wala itong browsing history, password o VPN key.';

  @override
  String get diagnostics_manualOpen => 'Magpatakbo ng diagnostics';

  @override
  String get diagnostics_localDescription =>
      'Gumawa ng ulat tungkol sa app at status ng VPN. Hindi magbabago ang iyong koneksyon.';

  @override
  String get diagnostics_sendReport => 'Ipadala ang ulat';

  @override
  String get diagnostics_sendHint =>
      'Iwanang hindi naka-check ang kahong ito upang manatili ang ulat sa device na ito.';

  @override
  String get diagnostics_signedOut =>
      'Mag-sign in sa iyong account upang magpadala ng ulat.';

  @override
  String get diagnostics_localLifetime =>
      'I-save ang ulat na ito sa iyong telepono upang manatili ito kahit isara ang app.';

  @override
  String get diagnostics_run => 'Magpatakbo ng diagnostics';

  @override
  String get diagnostics_rerun => 'Magpatakbo muli ng diagnostics';

  @override
  String get diagnostics_running => 'Sinusuri…';

  @override
  String get diagnostics_sending => 'Ipinapadala ang ulat…';

  @override
  String get diagnostics_prepared => 'Handa na ang ulat sa device na ito';

  @override
  String get diagnostics_queued => 'Naghihintay na maipadala ang ulat';

  @override
  String get diagnostics_sent => 'Natanggap ang ulat';

  @override
  String get diagnostics_failed =>
      'Nabigo ang pagpapadala. Magagamit pa rin ang iyong lokal na ulat.';

  @override
  String get diagnostics_preparationFailed =>
      'Hindi maihanda ang diagnostic report. Subukan muli.';

  @override
  String get diagnostics_authenticationRequired =>
      'Mag-sign in muli upang maipadala ang ulat.';

  @override
  String get diagnostics_retry => 'Subukang muli ang pagpapadala';

  @override
  String get diagnostics_export => 'I-save ang ulat';

  @override
  String get diagnostics_exportFailed =>
      'Nabigo ang pag-export. Subukan muli mula sa lokal na ulat.';

  @override
  String get diagnostics_preferenceFailed =>
      'Hindi ma-save ang setting na ito. Subukan muli.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Sanggunian: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Natanggap noong $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Itinatago hanggang $date';
  }

  @override
  String get diagnostics_duplicate => 'Natanggap na ang ulat na ito.';

  @override
  String get diagnostics_preview => 'Preview ng ulat';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count naka-attach na teknikal na event',
      one: '1 naka-attach na teknikal na event',
      zero: 'Walang naka-attach na teknikal na event',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Mga teknikal na detalye';

  @override
  String get diagnostics_empty => 'Wala pang naihandang diagnostic report.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Estado ng tunnel',
      'handshake': 'Kumpirmasyon ng koneksyon',
      'certificate': 'VPN certificate',
      'kill_switch': 'Proteksyon ng Android',
      'connectivity': 'Available na network',
      'api_reachability': 'Access sa serbisyo',
      'secure_storage': 'Ligtas na imbakan',
      'other': 'Lokal na pagsusuri',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Nasuri',
      'failed': 'Kailangan ng atensyon',
      'skipped': 'Hindi nasuri — walang aktibong probe',
      'unknown': 'Hindi magagamit ang impormasyon',
      'other': 'Hindi magagamit ang impormasyon',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Maligayang pagdating sa FuzeVPN';

  @override
  String get connection_changeLocation => 'Magpalit ng lokasyon';

  @override
  String get connection_details => 'Mga detalye ng koneksyon';

  @override
  String get locations_searchLabel => 'Maghanap ng lungsod o bansa';

  @override
  String get locations_clearSearch => 'I-clear ang paghahanap';

  @override
  String get locations_filterAll => 'Lahat';

  @override
  String get locations_filterFavorites => 'Mga paborito';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lokasyon',
      one: '$count lokasyon',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Walang nakitang lokasyon';

  @override
  String get locations_noResultsHint => 'Subukan ang ibang lungsod o bansa.';

  @override
  String get locations_noFavorites => 'Nasa kamay ang iyong mga paborito';

  @override
  String get locations_noFavoritesHint =>
      'I-tap ang bituin sa tabi ng lokasyon upang i-save ito rito.';

  @override
  String get locations_showAll => 'Tingnan ang lahat ng lokasyon';

  @override
  String locations_addFavorite(String name) {
    return 'Idagdag ang $name sa mga paborito';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Alisin ang $name sa mga paborito';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Hindi ma-save ang paborito. Subukan muli.';

  @override
  String get locations_emptyTitle => 'Walang magagamit na lokasyon';

  @override
  String get locations_emptyHint =>
      'I-refresh ang listahan upang subukan muli.';

  @override
  String get devices_manage => 'Pamahalaan ang aking mga device';

  @override
  String get settings_personalization => 'Iangkop ito sa iyo';

  @override
  String get settings_safety => 'Proteksyon';

  @override
  String get settings_help => 'Kailangan mo ng tulong?';

  @override
  String get settings_about => 'Tungkol sa FuzeVPN';

  @override
  String get diagnostics_heading => 'Unawain ang problema sa koneksyon';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Magagamit',
      'pending': 'Inihahanda',
      'revoked': 'Inalis',
      'expired': 'Nag-expire',
      'other': 'Hindi magagamit ang status',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Hindi na-save ang kagustuhan';

  @override
  String get notice_preferenceSave_message =>
      'Ginagamit muna ang iyong pinili, ngunit hindi ito na-save. Subukan muli upang manatili ito pagkatapos isara ang app.';

  @override
  String get connection_androidDisconnectHint =>
      'Kung pinananatiling aktibo ng Android ang VPN, i-off ang Always-on VPN sa mga setting na bubukas.';

  @override
  String get protection_learnMore =>
      'Alamin ang tungkol sa proteksyon ng Android';

  @override
  String get protection_guideWhy =>
      'Pinipigilan ng proteksyong ito ang mga app na direktang gumamit ng internet kapag nadiskonekta ang VPN. Kino-configure ito sa Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'Always-on VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Pinananatiling tumatakbo ng Android ang serbisyo ng VPN at maaari itong i-restart pagkatapos mag-reboot ang telepono.';

  @override
  String get protection_guideBlockTitle =>
      'I-block ang mga koneksyong walang VPN';

  @override
  String get protection_guideBlock =>
      'Pinipigilan ng setting na ito ang pag-bypass ng trapiko sa VPN, pati habang naaantala ang koneksyon.';

  @override
  String get protection_guideWarning =>
      'Kapag naka-enable ang pag-block na ito, mananatiling naka-off ang access sa internet hanggang nakakonekta ang VPN.';

  @override
  String get protection_guideStepsTitle => 'I-on ang proteksyon';

  @override
  String get protection_guideStep1 =>
      'Buksan ang mga setting ng Android VPN gamit ang button sa ibaba.';

  @override
  String get protection_guideStep2 =>
      'Buksan ang mga opsyon gamit ang icon na gear sa tabi ng FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'I-enable ang Always-on VPN, pagkatapos ay ang I-block ang mga koneksyong walang VPN, kung magagamit ang mga opsyong ito.';

  @override
  String get protection_guideManufacturers =>
      'Nag-iiba ang mga pangalan depende sa telepono. Kung kailangan, hanapin ang VPN sa Settings, kadalasan sa ilalim ng Network at internet.';

  @override
  String get protection_guideDisableTitle => 'I-off ang proteksyong ito';

  @override
  String get protection_guideDisable =>
      'Sa parehong mga setting, i-off ang pag-block kapag walang VPN upang payagan ang internet nang walang VPN. I-off din ang Always-on VPN kung ayaw mo nang i-restart ito ng Android.';

  @override
  String get protection_guideManual =>
      'Ikaw ang pumipili ng mga setting na ito sa Android. Hindi binabago ng FuzeVPN ang mga ito para sa iyo.';

  @override
  String get locations_changeTitle => 'Magpalit ng lokasyon?';

  @override
  String locations_changeActive(String name) {
    return 'Madidiskonekta ang VPN, pagkatapos ay susubukang kumonekta sa $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'Susubukang kumonekta ng VPN sa $name.';
  }

  @override
  String get locations_confirmChange => 'Magpalit at kumonekta';

  @override
  String get locations_changeBusy =>
      'May isinasagawang pagbabago. Maghintay bago pumili ng ibang lokasyon.';

  @override
  String get locations_automaticSelection => 'Awtomatikong pagpili';

  @override
  String get locations_cities => 'Mga lungsod';

  @override
  String get locations_servers => 'Mga server';

  @override
  String locations_viewCities(String name) {
    return 'Tingnan ang mga lungsod sa $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Tingnan ang mga server sa $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bansa',
      one: '$count bansa',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lungsod',
      one: '$count lungsod',
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
  String get locations_allCountries => 'Lahat ng bansa';

  @override
  String get locations_backToCountries => 'Bumalik sa mga bansa';

  @override
  String locations_backToCities(String name) {
    return 'Bumalik sa mga lungsod sa $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Piliin ang $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Piliin ang $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Walang available na compatible na server.';

  @override
  String get externalLink_failed =>
      'Hindi mabuksan ang link na ito. Maaari mo itong kopyahin at buksan sa iyong browser.';

  @override
  String get externalLink_copy => 'Kopyahin ang link';

  @override
  String get externalLink_copied => 'Nakopya ang link';

  @override
  String get externalLink_copyFailed =>
      'Hindi makopya ang link. Piliin ang address sa ibaba.';

  @override
  String get settings_deleteAccount => 'Burahin ang aking account';

  @override
  String get settings_deleteAccountDetail =>
      'Tingnan kung paano humiling ng pagbura ng account';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Piliin ang iyong VPN subscription.';

  @override
  String get billing_subscribe => 'Mag-subscribe';

  @override
  String get billing_choosePlan => 'Pumili ng plan para magpatuloy.';

  @override
  String get billing_monthly => 'Buwanan';

  @override
  String get billing_yearly => 'Taunan';

  @override
  String get billing_continue => 'Magpatuloy sa Google Play';

  @override
  String get billing_restore => 'Ibalik ang mga pagbili';

  @override
  String get billing_manage => 'Pamahalaan ang subscription';

  @override
  String get billing_deleteAccountWarning =>
      'Kung mayroon kang subscription sa Google Play, hindi makakansela ang pag-renew nito kapag binura mo ang iyong FuzeVPN account. Pamahalaan o kanselahin ang pag-renew nang hiwalay sa Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Magpatuloy sa kahilingan sa pagbura ng account';

  @override
  String get billing_refresh => 'I-refresh ang access';

  @override
  String get billing_loadingPlans => 'Naglo-load ng mga plan…';

  @override
  String get billing_unavailable =>
      'Walang available na plan ngayon. Subukan ulit mamaya.';

  @override
  String get billing_comingSoon =>
      'Malapit nang maging available ang mga subscription.';

  @override
  String get billing_priceDisclosure =>
      'Presyong ibinigay ng Google Play. Kinukumpirma ang huling halaga at naaangkop na buwis bago ka magkumpirma.';

  @override
  String get billing_renewalMonthly =>
      'Awtomatikong nagre-renew bawat buwan maliban kung kakanselahin. Maaari mong kanselahin anumang oras sa mga subscription ng Google Play.';

  @override
  String get billing_renewalYearly =>
      'Awtomatikong nagre-renew bawat taon maliban kung kakanselahin. Maaari mong kanselahin anumang oras sa mga subscription ng Google Play.';

  @override
  String get billing_active => 'Aktibo ang iyong Premium access';

  @override
  String billing_accessUntil(String date) {
    return 'May access hanggang $date.';
  }

  @override
  String get billing_webManaged =>
      'Pinamamahalaan ang iyong subscription sa website ng FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Pinamamahalaan ang iyong subscription sa Google Play.';

  @override
  String get billing_inactive => 'Walang aktibong subscription.';

  @override
  String get billing_checkingAccess => 'Sinusuri ang iyong access…';

  @override
  String get billing_restoring => 'Ibinabalik ang mga pagbili…';

  @override
  String get billing_pending =>
      'Nakabinbin ang bayad. Maa-activate ang access pagkatapos makumpirma.';

  @override
  String get billing_cancelled =>
      'Kinansela ang pagbili. Walang bagong subscription na na-activate.';

  @override
  String get billing_verifying => 'Bineberipika ang pagbili…';

  @override
  String get billing_success =>
      'Na-activate ang subscription. Handa na ang iyong Premium access.';

  @override
  String get billing_restored => 'Naibalik na ang iyong mga pagbili.';

  @override
  String get billing_restoreEmpty =>
      'Walang pagbiling maibabalik para sa Google Play account na ito.';

  @override
  String get billing_catalogError =>
      'Hindi ma-load ang mga plan. Subukan ulit.';

  @override
  String get billing_purchaseError =>
      'Hindi masimulan ang pagbili. Subukan ulit.';

  @override
  String get billing_verificationError =>
      'Pansamantalang hindi available ang beripikasyon ng pagbili. Ibalik ang mga pagbili para subukan ulit.';

  @override
  String get billing_restoreError =>
      'Hindi maibalik ang mga pagbili. Subukan ulit.';

  @override
  String get billing_managementError =>
      'Hindi mabuksan ang pamamahala ng subscription. Subukan ulit.';

  @override
  String get billing_storeUnavailable =>
      'Hindi available ang Google Play sa device na ito.';

  @override
  String get welcome_title => 'Ang VPN mo, mas pinadali.';

  @override
  String get welcome_description =>
      'Protektahan ang iyong koneksyon. Panatilihin ang kontrol sa iyong privacy.';

  @override
  String get welcome_start => 'Magsimula';

  @override
  String get welcome_alreadyPurchased => 'Nakabili ka na?';

  @override
  String get welcome_noAccountRequired =>
      'Hindi kailangan ng account para magsimula.';

  @override
  String get guest_accountTitle => 'Hindi pa naka-link ang account';

  @override
  String get guest_accountDescription =>
      'I-restore ang iyong mga pagbili gamit ang parehong Google Play account para magamit ang subscription sa ibang device.';

  @override
  String get guest_existingSubscriberSignIn =>
      'May subscription ka na? Mag-sign in';

  @override
  String get guest_claimTitle => 'Gamitin ang FuzeVPN saanman';

  @override
  String get guest_claimDescription =>
      'Gumawa ng account para ma-access ang iyong subscription sa iba mong device. Opsyonal ang hakbang na ito.';

  @override
  String get guest_skip => 'Mamaya na';

  @override
  String get guest_activationTitle => 'Aktibo ang Fuze Premium';

  @override
  String get guest_activationDescription =>
      'Handa na ang iyong subscription. Gamitin ang VPN at gumawa ng account kung kailan mo gusto.';

  @override
  String get guest_useVpn => 'Gamitin ang aking VPN';

  @override
  String get guest_loginRequired =>
      'Naka-link na ang pagbiling ito sa isang FuzeVPN account. Mag-sign in sa account na iyon para ma-access ang iyong subscription.';

  @override
  String get guest_signOutWarning =>
      'Maaari mong maibalik ang subscription sa pamamagitan ng pag-restore ng mga pagbili gamit ang parehong Google Play account.';

  @override
  String get guest_profileUnavailable =>
      'Naka-link na ang iyong account. Mag-sign in para tingnan at pamahalaan ang iyong impormasyon.';

  @override
  String get billing_acceptance =>
      'Sa pagpapatuloy, tinatanggap mo ang Mga Tuntunin ng Paggamit at Patakaran sa Privacy.';

  @override
  String get guest_verifyEmailReminder =>
      'Kumpirmahin ang iyong email address para protektahan ang account. Maaari mong patuloy na gamitin ang VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Pansamantalang hindi available ang serbisyo. Subukan muli pagkalipas ng ilang sandali.';

  @override
  String get guest_restoreError =>
      'Hindi na-restore ang iyong mga pagbili. Subukan muli gamit ang Google Play account na ginamit sa pagbili.';

  @override
  String get guest_claimSuccess =>
      'Nagawa na ang iyong account. Napanatili ang iyong subscription at access sa VPN.';

  @override
  String get guest_emailExists =>
      'Ginagamit na ang email na ito. Pumili ng ibang address o mag-sign in sa iyong kasalukuyang account. Mananatiling available ang iyong pagbili sa pamamagitan ng Google Play.';

  @override
  String get guest_claimError =>
      'Hindi nagawa ang iyong account. Maaari mong patuloy na gamitin ang VPN at subukan muli sa ibang pagkakataon.';

  @override
  String get guest_secureStorageError =>
      'Hindi na-save nang ligtas ang iyong session sa device na ito. Subukan muli.';

  @override
  String get guest_premiumRequired =>
      'Pumili ng subscription para i-activate ang iyong VPN.';

  @override
  String get welcome_viewPlans => 'Tingnan ang mga plan';

  @override
  String get google_continue => 'Magpatuloy gamit ang Google';

  @override
  String get google_or => 'o';

  @override
  String get google_title => 'Ang iyong FuzeVPN account';

  @override
  String get google_settingUp => 'Kumpletuhin ang iyong account';

  @override
  String get google_country => 'Bansang tinitirhan';

  @override
  String get google_profileDescription =>
      'Piliin ang iyong bansa at basahin ang dalawang dokumento para gumawa ng FuzeVPN account.';

  @override
  String get google_claimDescription =>
      'Iugnay ang guest account sa Google. Mananatiling kaugnay ng account na ito ang subscription at device.';

  @override
  String get google_linkTitle => 'Iugnay ang Google sa FuzeVPN';

  @override
  String get google_linkDescription =>
      'Kumpirmahin ang access sa kasalukuyang FuzeVPN account. Hindi hinihingi ang Google password.';

  @override
  String get google_password => 'FuzeVPN password';

  @override
  String get google_linkAccount => 'Kumpirmahin ang pag-uugnay';

  @override
  String get google_requestEmail => 'Magpadala ng email sa pagkumpirma';

  @override
  String get google_emailInstructions =>
      'Buksan ang FuzeVPN email at ilagay ang code sa pagkumpirma.';

  @override
  String get google_emailCode => 'Code sa pagkumpirma sa email';

  @override
  String get google_confirmEmail => 'Kumpirmahin ang code';

  @override
  String get google_restart => 'Pumili ng ibang Google account';

  @override
  String get google_resume => 'Suriin ang pagsubok na ito';

  @override
  String get google_unavailable =>
      'Hindi available ang Google sign-in. Maaari mong gamitin ang email at password.';

  @override
  String get google_expired =>
      'Nag-expire ang pagsubok na ito. Kanselahin at magsimula muli.';

  @override
  String get google_conflict =>
      'Nakaugnay na ang Google account na ito sa ibang account. Nananatili ang kasalukuyang account at subscription.';

  @override
  String get google_error =>
      'Nabigo ang Google sign-in. Subukang muli; nananatili ang kasalukuyang access.';

  @override
  String get google_uncertain =>
      'Hindi makumpirma ang resulta. Suriin ang pagsubok o kanselahin bago magsimula muli.';

  @override
  String get google_cancelFailed =>
      'Hindi makumpirma ang pagkansela. Subukang kanselahin muli bago umalis sa screen na ito.';

  @override
  String get google_cancelled => 'Nakansela ang Google sign-in.';

  @override
  String get google_selecting => 'Piliin ang iyong Google account…';

  @override
  String get google_verifying => 'Sinusuri ang iyong account…';

  @override
  String get google_emailUnavailable =>
      'Hindi maipadala ang email sa pagkumpirma. Subukan sa ibang pagkakataon.';

  @override
  String get google_emailSent =>
      'Naipadala ang email sa pagkumpirma. Tingnan ang iyong inbox.';

  @override
  String get google_rateLimited => 'Maghintay bago subukang muli.';

  @override
  String get google_invalidPassword =>
      'Mali ang FuzeVPN password. Nananatili ang kasalukuyang account.';

  @override
  String get google_invalidCode =>
      'Hindi wasto o expired na ang code sa pagkumpirma.';

  @override
  String get google_accountChanged =>
      'Nagbago ang session. Kanselahin ang pagsubok na ito bago magsimula muli.';

  @override
  String get google_invalidResponse =>
      'Hindi ma-validate ang tugon. Nananatili ang kasalukuyang access.';

  @override
  String get google_invalidRegistration =>
      'Suriin ang bansa at parehong pahintulot.';

  @override
  String get google_consentRequired =>
      'Piliin ang bansa at tanggapin ang dalawang dokumento para magpatuloy.';

  @override
  String get google_challengeRequired =>
      'Kailangan ng karagdagang pagsusuri sa seguridad. Nananatili ang kasalukuyang access.';

  @override
  String get google_challengeUnavailable =>
      'Hindi available ang pagsusuri sa seguridad. Subukan sa ibang pagkakataon.';

  @override
  String get billing_trialTitle => 'Subukan ang Fuze Premium nang libre';

  @override
  String get billing_trialSubtitle =>
      'Protektahan ang koneksyon mo simula ngayon.';

  @override
  String get billing_trialWeeks => '2 linggong libreng pagsubok';

  @override
  String billing_trialDays(String days) {
    return '$days araw na libreng pagsubok';
  }

  @override
  String get billing_trialStart => 'Simulan ang libreng pagsubok ko';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Kung magsisimula ka ngayon, inaasahan ang unang singil sa $date.';
  }

  @override
  String get billing_trialTerms =>
      'Awtomatikong nire-renew sa nakasaad na presyo. Para maiwasan ang singil, magkansela sa Google Play bago matapos ang pagsubok.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Pagkatapos, $price bawat buwan';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Pagkatapos, $price bawat taon';
  }

  @override
  String get billing_choosePeriod => 'Piliin ang iyong plano';

  @override
  String get billing_selectionHint => 'Pumili ng plano para magpatuloy.';

  @override
  String get billing_benefitConnection => 'Naka-encrypt na koneksyon';

  @override
  String get billing_benefitPrivacy => 'Privacy online';

  @override
  String get billing_benefitNoAccount => 'Hindi kailangang magparehistro';

  @override
  String get billing_cancellation => 'Pagkansela sa Google Play';

  @override
  String get billing_premiumTitle => 'Mas protektado ang koneksyon mo.';

  @override
  String get billing_premiumSubtitle =>
      'Protektahan ang koneksyon sa paraang akma sa iyo.';

  @override
  String get billing_priceMonthly => 'bawat buwan';

  @override
  String get billing_priceYearly => 'bawat taon';

  @override
  String get billing_trialToday => 'Walang babayaran ngayong araw';

  @override
  String get billing_trialConfirmation =>
      'Kinukumpirma ng Google Play ang mga petsa, huling halaga at naaangkop na buwis bago ka magkumpirma.';

  @override
  String get billing_offerChanged =>
      'Nagbago ang mga kondisyon ng alok na ito. I-refresh ang mga plano at pumili muli.';

  @override
  String get status_waitingNetwork => 'Naghihintay ng network';

  @override
  String get status_waitingNetworkDetail =>
      'Walang available na network. Susuriin ng VPN ang koneksyon kapag bumalik ang network.';

  @override
  String get locations_favoriteLoadFailed =>
      'Hindi ma-load ang mga paborito. Subukan muli.';

  @override
  String get locations_favoritesLoading => 'Nilo-load ang mga paborito…';
}
