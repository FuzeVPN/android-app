// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Ku kare haɗinku';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN yana amfani da sabis ɗin VPN na Android (VpnService) don ƙirƙirar ɓoyayyen rami tsakanin wannan na’ura da sabobin FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Yayin da VPN ke aiki, zirga-zirgar intanet ɗin manhajojinku, adiresoshin inda za a je da buƙatun DNS suna wucewa ta wannan rami don tura haɗinku, ko da FuzeVPN yana gudana a bayan fage.';

  @override
  String get vpnDisclosure_statusBody =>
      'Manhajar tana amfani da matsayin haɗin, tsawon lokacinsa da yawan bayanan da aka tura don nuna haɗin VPN ɗinku. Kuna iya dakatar da shi a kowane lokaci.';

  @override
  String get vpnDisclosure_privacy => 'Keɓantawa';

  @override
  String get vpnDisclosure_accept => 'Karɓa kuma ci gaba';

  @override
  String get vpnDisclosure_decline => 'Ba yanzu ba';

  @override
  String get accountRestoration_title => 'Asusu ba ya samuwa na ɗan lokaci';

  @override
  String get accountRestoration_message =>
      'An ajiye zaman shiganku. Ku sake gwadawa don dawo da asusunku; har yanzu kuna iya sarrafa haɗin VPN a nan.';

  @override
  String get action_retry => 'Sake gwadawa';

  @override
  String get session_endingTitle => 'Ana rufe zaman shiga';

  @override
  String get session_ending =>
      'Ana rufe zaman shiga: ana dakatar da VPN kuma ana tsaftacewa…';

  @override
  String get session_stopFailed =>
      'Ba a tabbatar da rufe VPN ba. Ku sake gwadawa kafin ku sake shiga asusu.';

  @override
  String get session_cleanupFailed =>
      'An dakatar da VPN, amma ba a tabbatar da share zaman shiga ba. Ku sake gwada tsaftacewa.';

  @override
  String get session_retryStop => 'Sake gwada rufewa';

  @override
  String get session_retryCleanup => 'Sake gwada tsaftacewa';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Ana shirya FuzeVPN cikin tsaro…';

  @override
  String get nav_connection => 'Haɗi';

  @override
  String get nav_locations => 'Wurare';

  @override
  String get nav_account => 'Asusu';

  @override
  String get nav_devices => 'Na’urori';

  @override
  String get nav_settings => 'Saituna';

  @override
  String get action_refresh => 'Sabunta';

  @override
  String get auth_tab_login => 'Shiga asusu';

  @override
  String get auth_tab_register => 'Yi rajista';

  @override
  String get auth_stepAccount => 'Asusu';

  @override
  String get auth_stepIdentity => 'Bayanan kai';

  @override
  String get auth_stepAddress => 'Adireshi da yarjejeniyoyi';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Mataki na $current cikin $total';
  }

  @override
  String get auth_tagline => 'VPN ɗinku, cikin sauƙi.';

  @override
  String get auth_keysLocal =>
      'Maɓallan VPN ɗinku na sirri suna nan a wannan na’ura.';

  @override
  String get form_email => 'Adireshin imel';

  @override
  String get form_password => 'Kalmar sirri';

  @override
  String get form_showPassword => 'Nuna kalmar sirri';

  @override
  String get form_hidePassword => 'Ɓoye kalmar sirri';

  @override
  String get form_passwordMin =>
      'Byte 8–72 na UTF-8. Wasu haruffa suna amfani da fiye da byte ɗaya.';

  @override
  String get form_firstName => 'Sunan farko';

  @override
  String get form_lastName => 'Sunan ƙarshe';

  @override
  String get form_phone => 'Lambar waya (+33612345678)';

  @override
  String get form_address => 'Adireshi';

  @override
  String get form_address2 => 'Layin adireshi na 2 (na zaɓi)';

  @override
  String get form_postalCode => 'Lambar gidan waya';

  @override
  String get form_city => 'Birni';

  @override
  String get form_country => 'Lambar ƙasa (misali FR)';

  @override
  String get action_login => 'Shiga asusu';

  @override
  String get action_createAccount => 'Ƙirƙiri asusu';

  @override
  String get action_createMyAccount => 'Ƙirƙiri asusuna';

  @override
  String get action_next => 'Ci gaba';

  @override
  String get action_previous => 'Koma baya';

  @override
  String get action_forgotPassword => 'Kun manta kalmar sirri?';

  @override
  String get auth_noAccount => 'Ba ku da asusu tukuna?';

  @override
  String get auth_requiredInformation =>
      'Ku ƙirƙiri asusunku cikin matakai uku.';

  @override
  String get auth_termsPrefix => 'Na amince da ';

  @override
  String get auth_termsLink => 'sharuɗɗan amfani';

  @override
  String get auth_privacyPrefix => 'Na amince da ';

  @override
  String get auth_privacyLink => 'manufar keɓantawa';

  @override
  String get auth_consentRequired =>
      'Ana buƙatar amincewarku don ƙirƙirar asusu.';

  @override
  String get validation_required => 'Ana buƙatar cika wannan filin.';

  @override
  String get validation_email => 'Shigar da ingantaccen adireshin imel.';

  @override
  String get validation_password =>
      'Kalmar sirri ta yi gajarta: aƙalla byte 8 na UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Kalmar sirri ta yi tsawo: iyakar byte 72 na UTF-8.';

  @override
  String get validation_phone =>
      'Yi amfani da tsarin ƙasa da ƙasa, misali +33612345678.';

  @override
  String get validation_country =>
      'Yi amfani da lambar ƙasa mai haruffa biyu, misali FR.';

  @override
  String get passwordReset_title => 'Sake saita kalmar sirri';

  @override
  String get passwordReset_description =>
      'Shigar da adireshin imel na asusunku don neman hanyar haɗin sake saita kalmar sirri.';

  @override
  String get passwordReset_send => 'Aika hanyar haɗi';

  @override
  String get connection_title => 'Haɗinku';

  @override
  String get connection_subtitle => 'Ku zaɓi wuri, sannan ku kunna VPN ɗinku.';

  @override
  String get connection_prepare => 'Kuna shirye ku haɗa?';

  @override
  String get connection_advancedOptions => 'Zaɓuɓɓukan ci gaba';

  @override
  String get connection_location => 'Wuri';

  @override
  String get connection_chooseLocation => 'Zaɓi wuri';

  @override
  String get connection_protocol => 'Ƙa’ida';

  @override
  String get connection_connect => 'Haɗa';

  @override
  String get connection_connecting => 'Ana haɗawa…';

  @override
  String get connection_disconnect => 'Katse haɗi';

  @override
  String get connection_disconnecting => 'Ana katse haɗi';

  @override
  String get connection_locationChange => 'Ana canza wuri…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ba ya samuwa';
  }

  @override
  String get connection_activeLocation => 'Wuri mai aiki';

  @override
  String get connection_duration => 'Tsawon lokaci';

  @override
  String get connection_received => 'An karɓa';

  @override
  String get connection_sent => 'An aika';

  @override
  String get connection_lastHandshake => 'Musayar tsaro ta ƙarshe';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration da suka wuce';
  }

  @override
  String get verification_title => 'Ku tabbatar da adireshin imel ɗinku';

  @override
  String get verification_message =>
      'Ku tabbatar da adireshin imel ɗinku don amfani da VPN a wannan waya.';

  @override
  String get verification_resend => 'Sake aika imel';

  @override
  String get migration_title => 'Canjin wuri';

  @override
  String get migration_draining => 'Ana shirya canjin wuri…';

  @override
  String get migration_activating => 'Ana kunna sabuwar sabar…';

  @override
  String get migration_ready => 'An sabunta wuri.';

  @override
  String get migration_blocked =>
      'Canjin wuri yana buƙatar shiga tsakani daga sabar. Ku sake gwadawa daga baya ko ku tuntuɓi tallafi.';

  @override
  String get migration_progress => 'Ci gaban canjin wuri';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Tazara tsakanin dubawa: daƙiƙa $seconds.';
  }

  @override
  String get migration_resume => 'Ci gaba da canjin wuri';

  @override
  String get status_authorizing => 'Ana buƙatar izini';

  @override
  String get status_authorizingDetail =>
      'Ku karɓi buƙatar Android don ba VPN izini.';

  @override
  String get status_preparing => 'Ana shiryawa';

  @override
  String get status_preparingDetail => 'Ana shirya haɗinku mai tsaro.';

  @override
  String get status_reconnecting => 'Ana sake haɗawa…';

  @override
  String get status_reconnectingDetail =>
      'An katse haɗin. VPN yana ƙoƙarin sake haɗawa.';

  @override
  String get status_connecting => 'Ana haɗawa';

  @override
  String get status_connectingDetail => 'Ana haɗawa da sabar VPN…';

  @override
  String get status_connected => 'An haɗa';

  @override
  String get status_connectedDetail => 'Haɗin VPN ɗinku yana aiki.';

  @override
  String get status_disconnecting => 'Ana katse haɗi';

  @override
  String get status_disconnectingDetail => 'Haɗin VPN ɗinku yana tsayawa.';

  @override
  String get status_error => 'Haɗi ba ya samuwa';

  @override
  String get status_errorDetail =>
      'Ba a tabbatar da haɗin VPN ba. Ku sake gwadawa.';

  @override
  String get status_idle => 'An katse haɗi';

  @override
  String get status_idleDetail => 'Ku haɗa VPN don kare haɗinku.';

  @override
  String get trust_note =>
      'Rufe manhajar ba ya katse VPN. Don katse shi, ku yi amfani da Katse haɗi.';

  @override
  String get locations_none => 'Babu wurare da ake samu a yanzu.';

  @override
  String get locations_available => 'Ku zaɓi wuri na gaba.';

  @override
  String get locations_selected => 'Wurin da aka zaɓa';

  @override
  String get locations_select => 'Zaɓi wannan wuri';

  @override
  String get locations_lockedTunnel => 'Ku katse VPN don canza wuri.';

  @override
  String get locations_lockedMigration => 'Ku jira canjin wuri ya kammala.';

  @override
  String get devices_title => 'Na’urorinku';

  @override
  String devices_used(Object count, Object limit) {
    return 'Na’urori $count / $limit';
  }

  @override
  String get devices_refresh => 'Sabunta na’urori';

  @override
  String get devices_empty => 'Babu na’urar VPN da aka yi wa rajista tukuna.';

  @override
  String get devices_firstConnection => 'Za a ƙara wayarku a haɗin farko.';

  @override
  String get devices_thisDevice => 'Wannan na’ura';

  @override
  String devices_added(Object date) {
    return 'An ƙara a ranar $date';
  }

  @override
  String get devices_unnamed => 'Na’ura marar suna';

  @override
  String get action_remove => 'Cire';

  @override
  String get settings_title => 'Saituna';

  @override
  String get settings_subtitle => 'Zaɓuɓɓukanku da asusunku, duka a wuri ɗaya.';

  @override
  String get settings_appearance => 'Kamanni';

  @override
  String get settings_language => 'Harshe';

  @override
  String get settings_languageDescription =>
      'Harshen da kuka zaɓa ya shafi sanarwar VPN ma.';

  @override
  String get settings_account => 'Asusu';

  @override
  String get settings_signOut => 'Fita daga asusu';

  @override
  String get settings_privacy => 'Manufar keɓantawa';

  @override
  String get settings_terms => 'Sharuɗɗan amfani';

  @override
  String get settings_security => 'Tsaro da bayyana gaskiya';

  @override
  String get settings_licenses => 'Lasisin sassan manhaja';

  @override
  String get settings_licensesDetail =>
      'Kayayyakin manhaja da ake amfani da su a cikin manhajar';

  @override
  String settings_licensesLegalese(String url) {
    return 'Lambar tushe ta manhajar da sassanta na MPL-2.0: $url';
  }

  @override
  String get settings_background =>
      'VPN yana ci gaba da aiki idan kun bar manhajar. Don katse shi, ku yi amfani da Katse haɗi a shafin Haɗi.';

  @override
  String get theme_system => 'Tsarin na’ura';

  @override
  String get theme_light => 'Haske';

  @override
  String get theme_dark => 'Duhu';

  @override
  String get language_system => 'Harshen waya';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Cire wannan na’ura?';

  @override
  String get dialog_removeCurrent =>
      'Wannan waya za ta katse haɗi da VPN kuma ta rasa damar shiga. Za a share bayanan haɗin VPN ɗinta bayan sabar ta tabbatar.';

  @override
  String dialog_removeOther(Object name) {
    return 'Za a soke damar shiga VPN ga “$name”. Ba za a iya warware wannan ba.';
  }

  @override
  String get dialog_signOut => 'Fita daga asusu?';

  @override
  String get dialog_signOutMessage =>
      'VPN zai tsaya, kuma sai kun sake shiga asusu. Maɓallan VPN ɗinku da aka ɓoye za su kasance a wannan waya don haɗinku na gaba.';

  @override
  String get action_cancel => 'Soke';

  @override
  String get action_close => 'Rufe';

  @override
  String get action_copy => 'Kwafa';

  @override
  String get action_renew => 'Sabunta';

  @override
  String get action_signOut => 'Fita daga asusu';

  @override
  String get notice_close => 'Rufe saƙon';

  @override
  String get notice_sessionExpired_title => 'Zaman shiga ya ƙare';

  @override
  String get notice_sessionExpired_message =>
      'Zaman shiganku ya ƙare. Ku sake shiga asusu.';

  @override
  String get notice_connectionFailed_title => 'Haɗi ya gaza';

  @override
  String get notice_invalidCredentials_message =>
      'Adireshin imel ko kalmar sirri ba daidai ba ne.';

  @override
  String get notice_emailVerification_title => 'Ana buƙatar tabbatar da imel';

  @override
  String get notice_emailVerification_message =>
      'Ku tabbatar da adireshin imel ɗinku kafin ku ƙara na’urar VPN.';

  @override
  String get notice_rateLimited_title => 'An yi yunƙurori da yawa';

  @override
  String get notice_deviceLimit_title => 'An kai iyakar na’urori';

  @override
  String get notice_deviceLimit_message =>
      'Ku cire wata na’ura da ke akwai kafin ku ƙara wata.';

  @override
  String get notice_identityRenewal_title => 'Dole ne a sabunta shaidar VPN';

  @override
  String get notice_identityRenewal_message =>
      'An cire wannan shaida. Ku ƙirƙiri sabuwar shaida ta gida.';

  @override
  String get notice_migrationPending_title => 'Canjin wuri yana gudana';

  @override
  String get notice_migrationPending_message =>
      'Canjin wuri yana gudana a yanzu.';

  @override
  String get notice_migrationBlocked_title => 'An toshe canjin wuri';

  @override
  String get notice_migrationBlocked_message =>
      'Canjin wuri yana buƙatar shiga tsakani daga sabar. Ku sake gwadawa daga baya ko ku tuntuɓi tallafi.';

  @override
  String get notice_targetUnavailable_title =>
      'Sabar ba ta samuwa na ɗan lokaci';

  @override
  String get notice_targetUnavailable_message =>
      'Wannan sabar ba ta samuwa na ɗan lokaci.';

  @override
  String get notice_networkUnavailable_title => 'Haɗin intanet ba ya samuwa';

  @override
  String get notice_networkUnavailable_message =>
      'Ku duba haɗinku, sannan ku sake gwadawa.';

  @override
  String get notice_permissionDenied_title => 'An ƙi izinin VPN';

  @override
  String get notice_permissionDenied_message =>
      'Ku sake fara haɗi, kuma ku karɓi buƙatar izinin Android.';

  @override
  String get notice_wireguardTimeout_title => 'Sabar ba ta amsawa';

  @override
  String get notice_wireguardTimeout_message =>
      'Haɗin WireGuard ya ɗauki lokaci mai tsawo. Ku sake gwadawa ko ku zaɓi wani wuri.';

  @override
  String get notice_tlsFailed_title => 'An ƙi haɗin tsaro';

  @override
  String get notice_tlsFailed_message =>
      'Sabar ba ta karɓi haɗin OpenVPN ba. Ku sake gwadawa. Idan matsalar ta ci gaba, ku fara bincike.';

  @override
  String get notice_tunRejected_title => 'Android ta ƙi mahaɗar VPN';

  @override
  String get notice_tunRejected_message =>
      'Android ta ƙi saitin hanyar sadarwa da OpenVPN ya nema.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN bai iya farawa ba';

  @override
  String get notice_openvpnStart_message =>
      'Injin OpenVPN bai iya kammala farawa ba. Ku sake gwadawa. Idan matsalar ta ci gaba, ku tuntuɓi tallafi.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Lambar rahoton bincike: $code';
  }

  @override
  String get notice_generic_title => 'Haɗin VPN ya gaza';

  @override
  String get notice_generic_message =>
      'An samu matsala. Ku sake gwadawa daga baya.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'An ƙirƙiri asusu',
      'password_reset_sent': 'An karɓi buƙatar sake saita kalmar sirri',
      'verification_email_sent': 'An aika imel na tabbatarwa',
      'location_migration_pending': 'Canjin wuri yana gudana',
      'vpn_sign_in_required': 'Ana buƙatar shiga asusu',
      'protocol_unavailable_at_location': 'Ƙa’ida ba ta samuwa',
      'vpn_permission_denied': 'An ƙi izinin VPN',
      'revoked_identity_device_limit': 'An kai iyakar na’urori',
      'tunnel_start_unexpected': 'VPN bai iya farawa ba',
      'flutter_disconnect_timeout': 'Ba a tabbatar da katse haɗi ba',
      'flutter_disconnect_unexpected': 'Ba a iya katse haɗi ba',
      'device_revoked': 'An cire na’ura',
      'revoke_unexpected': 'Ba a iya cire na’ura ba',
      'identity_renewal_unexpected': 'Ba a iya sabunta shaida ba',
      'openvpn_renewal_unexpected': 'Ba a iya sabunta OpenVPN ba',
      'location_migration_blocked': 'An toshe canjin wuri',
      'location_migration_slow': 'Canjin wuri yana ci gaba har yanzu',
      'location_migration_conflict': 'Canjin wuri yana buƙatar sabuntawa',
      'location_migration_verification_failed':
          'Ba a tabbatar da canjin wuri ba',
      'location_migration_device_changed': 'Na’ura ta canza yayin canjin wuri',
      'tunnel_stop_failed': 'Canjin wuri ba ya samuwa',
      'device_clock_ahead': 'Agogon na’ura ya yi gaba',
      'other': 'Aiki bai yi nasara ba',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'An ƙirƙiri asusun, amma ba a iya aika imel ɗin tabbatarwa ba. Ku yi amfani da zaɓin sake aikawa a cikin manhajar.',
      'password_reset_sent':
          'An karɓi buƙatarku. Idan akwai asusu mai wannan adireshin, ƙila ku karɓi imel. Ku kuma duba babban fayil ɗin spam.',
      'verification_email_sent': 'An aika sabon imel na tabbatarwa.',
      'location_migration_pending':
          'Ana ci gaba da shirya canji zuwa $target. Kuna iya ci gaba da shi ba tare da sake ƙirƙirar na’ura ba.',
      'vpn_sign_in_required': 'Ku shiga asusunku kafin ku fara VPN.',
      'protocol_unavailable_at_location':
          'Wannan wuri ba ya bayar da ƙa’idar da kuka zaɓa. Ku sabunta wurare ko ku zaɓi wata ƙa’ida.',
      'vpn_permission_denied':
          'Android ta ƙi izinin VPN. Ku sake fara haɗi, kuma ku karɓi buƙatar tsarin.',
      'revoked_identity_device_limit':
          'An cire damar VPN ta wannan na’ura kuma an kai iyakar na’urori. Ku cire na’ura a ƙarƙashin Asusu → Sarrafa na’urorina.',
      'tunnel_start_unexpected':
          'Wata matsala da ba a yi tsammani ba ta katse shirya ramin. Ku duba lambar rahoton bincike, sannan ku sake gwadawa.',
      'flutter_disconnect_timeout':
          'Android ba ta tabbatar da cewa VPN ya tsaya a kan lokaci ba. Ku sake gwada dakatar da shi.',
      'flutter_disconnect_unexpected':
          'Wata matsala da ba a yi tsammani ba ta hana tabbatar da cewa ramin ya tsaya.',
      'device_revoked':
          'An soke damar VPN ta na’urar, kuma an cire bayanan sirrinta na gida.',
      'revoke_unexpected':
          'Ba a iya cire na’urar ba. Ku sabunta jerin, sannan ku sake gwadawa.',
      'identity_renewal_unexpected':
          'Ba a iya ƙirƙirar sabuwar shaidar VPN ba. Ku sabunta na’urori, sannan ku sake gwadawa.',
      'openvpn_renewal_unexpected':
          'Ba a iya sabunta bayanin martabar OpenVPN ba. Ku sake gwadawa ko ku duba lambar rahoton bincike.',
      'location_migration_blocked':
          'Sabar ba za ta iya kammala wannan canjin yanzu ba. An ajiye na’urar da shaidarta ta gida.',
      'location_migration_slow':
          'Sabar har yanzu tana shirya canji zuwa $target. Ku ci gaba da canjin bayan ɗan lokaci.',
      'location_migration_conflict':
          'Yanayin na’urar ya canza a sabar. Ku sabunta na’urori, sannan ku ci gaba da canjin.',
      'location_migration_verification_failed':
          'Sabar ba ta tabbatar da sabon wurin ba. An ajiye tsohuwar shaidar gida.',
      'location_migration_device_changed':
          'Na’urar da sabar ta dawo da ita ba ta dace da wadda ake canzawa ba. Ku sabunta na’urori kafin ku sake gwadawa.',
      'tunnel_stop_failed':
          'Dole ne a dakatar da ramin da ya gabata gaba ɗaya kafin sabon haɗi.',
      'device_clock_ahead':
          'Agogon wannan na’ura ya yi gaba. Ku kunna kwanan wata da lokaci na atomatik don ku ci gaba da shiga.',
      'other':
          'Ba a iya kammala aikin ba. Ku sake gwadawa ko ku aika lambar rahoton bincike ga tallafi.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Zaman shiga ya ƙare',
      'invalid_credentials': 'Shiga bai yi nasara ba',
      'email_verification_required': 'Ana buƙatar tabbatar da imel',
      'verification_email_cooldown': 'An riga an aika imel',
      'rate_limited': 'An yi yunƙurori da yawa',
      'invalid_registration': 'Dole a gyara bayanai',
      'email_exists': 'Asusu ya riga ya wanzu',
      'invalid_profile': 'Bayanin asusu ba daidai ba ne',
      'invalid_device': 'Na’ura ba daidai ba ce',
      'invalid_location': 'Wuri ba ya samuwa',
      'device_limit': 'An kai iyakar na’urori',
      'device_exists': 'Shaidar VPN tana cikin amfani',
      'device_identity_revoked': 'Dole ne a sabunta shaidar VPN',
      'device_location_locked': 'Canjin wuri yana buƙatar sabuntawa',
      'location_migration_pending': 'Canjin wuri yana gudana',
      'location_migration_blocked': 'An toshe canjin wuri',
      'target_ca_mismatch': 'Sabar OpenVPN ba ta dace ba',
      'location_migration_conflict': 'Canjin wuri yana buƙatar sabuntawa',
      'server_full': 'Sabar ta cika',
      'capacity_unavailable': 'Wuri ba ya samuwa na ɗan lokaci',
      'target_unavailable': 'Sabar ba ta samuwa na ɗan lokaci',
      'not_found': 'Ba a sami abin ba',
      'invalid_openvpn_csr': 'Shaidar OpenVPN ba daidai ba ce',
      'openvpn_profile_exists': 'Bayanin martabar OpenVPN ya riga ya wanzu',
      'openvpn_profile_revoked': 'An soke bayanin martabar OpenVPN',
      'openvpn_operation_pending': 'Aikin OpenVPN yana gudana',
      'openvpn_operation_terminal': 'An katse aikin OpenVPN',
      'openvpn_address_unavailable': 'Adireshin OpenVPN ba ya samuwa',
      'openvpn_profile_conflict': 'Saɓani a OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN ba ya samuwa',
      'email_delivery_unavailable': 'Imel ba ya samuwa',
      'invalid_token': 'Hanyar haɗi ba ta da inganci',
      'network_unavailable': 'Haɗin intanet ba ya samuwa',
      'invalid_json': 'Buƙata ba daidai ba ce',
      'invalid_api_response': 'Amsar sabar ba daidai ba ce',
      'ipv6_unavailable': 'IPv6 ba ya samuwa',
      'invalid_ip_families': 'An ƙi saitin hanyar sadarwa',
      'other': 'Sabis ba ya samuwa',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Zaman shiganku ya ƙare. Ku sake shiga asusunku.',
      'invalid_credentials': 'Adireshin imel ko kalmar sirri ba daidai ba ne.',
      'email_verification_required':
          'Ku tabbatar da adireshin imel ɗinku kafin ku ƙara na’urar VPN.',
      'invalid_registration':
          'Ku duba bayanan da aka nema da kuma amincewarku.',
      'email_exists': 'Wani asusu yana amfani da wannan adireshin imel.',
      'invalid_profile': 'Ku duba bayanan asusunku.',
      'invalid_device':
          'Sunan wannan na’ura ko shaidarta ta gida ba daidai ba ne.',
      'invalid_location': 'Ku sabunta jerin wurare, sannan ku sake gwadawa.',
      'device_limit': 'Ku cire wata na’ura da ke akwai kafin ku ƙara wata.',
      'device_exists': 'An riga an haɗa wannan shaidar VPN da wani asusu.',
      'device_identity_revoked':
          'An cire wannan shaida. Dole ne a ƙirƙiri sabuwar shaida ta gida.',
      'device_location_locked':
          'Wurin wannan na’ura ya canza yanzu haka. Manhajar za ta ci gaba da canjin da ke gudana.',
      'location_migration_pending': 'Canjin wuri yana gudana a yanzu.',
      'location_migration_blocked':
          'Canjin wuri yana buƙatar shiga tsakani daga sabar. Ku sake gwadawa daga baya ko ku tuntuɓi tallafi.',
      'target_ca_mismatch':
          'Wannan sabar ba ta dace da bayanin martabar OpenVPN na yanzu ba tukuna.',
      'location_migration_conflict':
          'Ku sabunta na’urori, sannan ku sake gwada canjin wuri.',
      'server_full':
          'Wannan wuri ya kai iyakar haɗinsa. Ku zaɓi wani wuri ko ku sake gwadawa daga baya.',
      'capacity_unavailable':
          'Ba za mu iya tabbatar da cewa wannan wuri yana samuwa a yanzu ba. Ku zaɓi wani wuri ko ku sake gwadawa daga baya.',
      'target_unavailable': 'Wannan sabar ba ta samuwa na ɗan lokaci.',
      'not_found': 'Wannan abu ba ya ƙara samuwa a asusunku.',
      'invalid_openvpn_csr':
          'Ku ƙirƙiri sabuwar shaidar OpenVPN, sannan ku sake gwadawa.',
      'openvpn_profile_exists':
          'Akwai bayanin martabar OpenVPN na wannan na’ura.',
      'openvpn_profile_revoked':
          'Ku sabunta bayanin martabar OpenVPN don ci gaba.',
      'openvpn_operation_pending':
          'Canjin yana ci gaba da yaɗuwa. Ku sake gwadawa daga baya.',
      'openvpn_operation_terminal':
          'Ku ƙirƙiri sabuwar shaidar OpenVPN, sannan ku sake gwadawa.',
      'openvpn_address_unavailable':
          'Babu adireshin OpenVPN da ke samuwa a yanzu.',
      'openvpn_profile_conflict':
          'Bayanin martaba ya canza. Ku sabunta na’urori, sannan ku sake gwadawa.',
      'openvpn_signer_unavailable':
          'Sabis ɗin OpenVPN ba ya samuwa na ɗan lokaci.',
      'email_delivery_unavailable':
          'Ba a iya aika imel ba. Ku sake gwadawa daga baya.',
      'invalid_token':
          'Wannan hanyar haɗi ba ta da inganci ko kuma ta ƙare. Ku nemi sabuwa.',
      'network_unavailable':
          'Ku duba haɗin intanet ɗinku, sannan ku sake gwadawa.',
      'invalid_json': 'Ku duba bayanan da kuka shigar, sannan ku sake gwadawa.',
      'invalid_api_response':
          'Sabar ta mayar da amsa da ba a yi tsammani ba. Ku sake gwadawa daga baya.',
      'ipv6_unavailable':
          'Sabar ba za ta iya kunna IPv6 a yanzu ba. Ku sake gwadawa daga baya.',
      'invalid_ip_families':
          'Saitin ramin bai cika ba ko kuma bai dace da adiresoshin da aka ba da izini ba. Ku sake gwadawa daga manhajar.',
      'other': 'An samu matsalar sabar. Ku sake gwadawa daga baya.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Ku sake gwadawa bayan ɗan lokaci.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Ku sake gwadawa bayan daƙiƙoƙi $seconds.',
      one: 'Ku sake gwadawa bayan daƙiƙa $seconds.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ku sake gwadawa bayan mintuna $minutes.',
      one: 'Ku sake gwadawa bayan minti $minutes.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Ku sake gwadawa bayan awanni $hours.',
      one: 'Ku sake gwadawa bayan awa $hours.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Ba za a iya ci gaba da VPN na tsarin ba',
      'system_vpn_resume_corrupt': 'Ci gaban VPN na tsarin ba shi da inganci',
      'system_vpn_resume_session_invalid':
          'Zaman ci gaban VPN ba shi da inganci',
      'system_vpn_resume_identity_changed': 'Shaidar VPN ta canza',
      'system_vpn_resume_identity_invalid':
          'Shaidar ci gaban VPN ba ta da inganci',
      'system_vpn_resume_storage_failed': 'Ma’ajiyar ci gaban VPN ba ta samuwa',
      'system_vpn_resume_network_timeout':
          'Ba a sami hanyar sadarwa don ci gaban VPN ba',
      'system_vpn_resume_blocked': 'An toshe ci gaban VPN',
      'system_vpn_resume_failed': 'Ci gaban VPN ya gaza',
      'system_vpn_resume_error_invalid':
          'Kuskuren ci gaban VPN ba shi da inganci',
      'wireguard_identity_store_failed': 'Ba a adana shaidar WireGuard ba',
      'wireguard_identity_unavailable': 'Shaidar WireGuard ba ta samuwa',
      'vpn_host_destroyed': 'Ɓangaren VPN na Android ya tsaya',
      'vpn_host_unavailable': 'Ɓangaren VPN na Android ba ya samuwa',
      'vpn_permission_required': 'Ana buƙatar izinin VPN',
      'vpn_permission_denied': 'An ƙi izinin VPN',
      'vpn_permission_request_failed': 'Ba a iya neman izini ba',
      'wireguard_foreground_service_unavailable':
          'Sabis ɗin WireGuard ba ya samuwa',
      'wireguard_identity_invalid':
          'Maɓallin WireGuard na gida ba shi da inganci',
      'wireguard_identity_in_use': 'Shaidar WireGuard tana cikin amfani',
      'wireguard_configuration_invalid': 'Saitin WireGuard ba shi da inganci',
      'wireguard_operation_pending': 'Aikin WireGuard har yanzu yana gudana',
      'wireguard_start_failed': 'An ƙi fara WireGuard',
      'wireguard_stop_timeout': 'Ba a tabbatar da dakatar da WireGuard ba',
      'wireguard_handshake_timeout': 'WireGuard bai amsa ba',
      'openvpn_connection_timeout': 'OpenVPN bai amsa ba',
      'openvpn_core_unavailable': 'Injin OpenVPN ba ya samuwa',
      'openvpn_operation_pending': 'Zaman OpenVPN har yanzu yana aiki',
      'openvpn_stop_timeout': 'Ba a tabbatar da dakatar da OpenVPN ba',
      'openvpn_profile_unavailable': 'Bayanin martabar OpenVPN na gida ya ɓace',
      'openvpn_native_failed': 'Kiran OpenVPN na asali ya katse',
      'openvpn_key_generation_failed':
          'Ba a iya ƙirƙirar maɓallin OpenVPN na P-256 ba',
      'openvpn_csr_generation_failed':
          'Ba a iya ƙirƙirar buƙatar CSR ta OpenVPN ba',
      'openvpn_identity_store_failed': 'Ba a adana shaidar OpenVPN ba',
      'openvpn_identity_clear_failed': 'Cire OpenVPN bai cika ba',
      'openvpn_identity_in_use': 'Shaidar OpenVPN har yanzu tana cikin amfani',
      'openvpn_tls_verification_required': 'Tabbatar da TLS na OpenVPN ya ɓace',
      'openvpn_cipher_invalid': 'Hanyar ɓoye ta OpenVPN ba ta da inganci',
      'openvpn_profile_rejected': 'An ƙi bayanin martabar OpenVPN',
      'openvpn_identity_inconsistent': 'Shaidar OpenVPN ba ta dace ba',
      'tls_handshake_failed': 'An ƙi tattaunawar OpenVPN',
      'tls_alert_unknown_ca':
          'Ba a gane takardar shaidar abokin ciniki ta OpenVPN ba',
      'tls_alert_bad_certificate':
          'An ƙi takardar shaidar abokin ciniki ta OpenVPN',
      'tls_alert_unsupported_certificate':
          'Ba a goyi bayan takardar shaidar OpenVPN ba',
      'tls_client_certificate_required':
          'Ana buƙatar takardar shaidar abokin ciniki ta OpenVPN',
      'tls_alert_misc': 'Gargaɗin TLS na OpenVPN',
      'tls_signature_algorithm_rejected':
          'Ba a goyi bayan sa hannun OpenVPN ba',
      'tls_handshake_rejected': 'An ƙi tattaunawar TLS ta OpenVPN',
      'tls_version_rejected': 'Sigar TLS ta OpenVPN ba ta dace ba',
      'tls_certificate_expired': 'Takardar shaidar TLS ta ƙare',
      'tls_certificate_revoked': 'An soke takardar shaidar TLS',
      'transport_failed': 'Ba a iya isa sabar OpenVPN ba',
      'tun_configuration_rejected': 'Ba a iya ƙirƙirar mahaɗar OpenVPN ba',
      'tun_setup_failed': 'Saitin TUN na OpenVPN ya gaza',
      'tun_interface_create_failed': 'Ƙirƙirar mahaɗar OpenVPN ta gaza',
      'tun_interface_disabled': 'An kashe mahaɗar OpenVPN',
      'tun_halted': 'Mahaɗar OpenVPN ta katse',
      'tun_already_established': 'Mahaɗar OpenVPN ta riga ta buɗe',
      'tun_addresses_missing': 'Adireshin OpenVPN ya ɓace',
      'tun_routes_missing': 'Hanyoyin OpenVPN sun ɓace',
      'tun_dns_missing': 'DNS na OpenVPN ya ɓace',
      'tun_permission_revoked': 'An soke izinin VPN',
      'tun_establish_returned_null': 'Android ta ƙi mahaɗar VPN',
      'openvpn_service_start_failed': 'Sabis ɗin OpenVPN ba ya samuwa',
      'openvpn_operation_timeout': 'Kiran OpenVPN ya wuce lokaci',
      'openvpn_start_failed': 'An ƙi fara OpenVPN',
      'openvpn_connection_failed': 'Haɗin OpenVPN ya katse',
      'openvpn_core_status_error': 'OpenVPN Core ya ƙare da kuskure',
      'openvpn_stopped_before_connected': 'OpenVPN ya tsaya kafin haɗi',
      'openvpn_auth_failed': 'An ƙi tantancewar OpenVPN',
      'openvpn_client_setup_failed': 'Saitin abokin ciniki na OpenVPN ya gaza',
      'openvpn_client_halted': 'Abokin ciniki na OpenVPN ya katse',
      'openvpn_client_restart': 'An nemi sake farawar OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN bai yi aiki ba na dogon lokaci',
      'openvpn_session_expired': 'Zaman OpenVPN ya ƙare',
      'openvpn_credentials_required': 'Ba a goyi bayan tantancewar OpenVPN ba',
      'openvpn_proxy_failed': 'Sufurin tsaka-tsaki na OpenVPN ya gaza',
      'openvpn_compression_failed': 'An ƙi matsawar OpenVPN',
      'openvpn_ntlm_crypto_unavailable': 'Ɓoyewar NTLM ta OpenVPN ba ta samuwa',
      'openvpn_feature_unsupported': 'Ba a goyi bayan fasalin OpenVPN ba',
      'network_unavailable': 'Haɗin intanet ba ya samuwa',
      'network_lost': 'Hanyar sadarwa ba ta samuwa',
      'certificate_validation_failed': 'An ƙi takardar shaidar sabar',
      'openvpn_certificate_expired': 'Takardar shaidar OpenVPN ta ƙare',
      'tunnel_active_for_another_account':
          'Rami na wani asusu har yanzu yana aiki',
      'tunnel_already_active': 'Rami na asali yana aiki tuni',
      'tunnel_stop_timeout': 'Ba a tabbatar da dakatar da $protocol ba',
      'tunnel_disconnected': '$protocol ya katse',
      'native_bridge_unavailable': 'Gadar Android ba ta samuwa',
      'native_operation_failed': 'Aikin Android ya katse',
      'invalid_arguments': 'Sigogin VPN ba su cika ba',
      'invalid_account_id': 'Asusun VPN ba shi da inganci',
      'invalid_device_id': 'Mai gano na’ura ba shi da inganci',
      'storage_key_not_allowed': 'An ƙi maɓallin ma’ajiya',
      'secure_storage_read_failed': 'Karatu daga ma’ajiya mai tsaro ya gaza',
      'secure_storage_write_failed': 'Rubutu a ma’ajiya mai tsaro ya gaza',
      'key_generation_failed': 'Ba a iya ƙirƙirar maɓallin WireGuard ba',
      'csr_generation_failed': 'Ba a iya ƙirƙirar buƙatar CSR ta OpenVPN ba',
      'openvpn_recovery_exhausted': 'An riga an yi amfani da dawo da OpenVPN',
      'openvpn_recovery_failed': 'Dawo da OpenVPN ya gaza',
      'openvpn_renewal_required':
          'Ana buƙatar sabunta takardar shaidar OpenVPN',
      'other': 'Kuskuren VPN na asali wanda ba a rarraba ba',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ba ta iya samun zaman VPN da za a iya ci gaba da shi ba. Ku fara sabon haɗi a cikin manhajar.',
      'system_vpn_resume_corrupt':
          'Bayanan ci gaban VPN da aka adana ba su da inganci, don haka ba za a yi amfani da su ba. Ku fara sabon haɗi.',
      'system_vpn_resume_session_invalid':
          'Zaman da aka adana ba zai ƙara iya ci gaba da VPN ba. Ku sake shiga asusu a cikin manhajar.',
      'system_vpn_resume_identity_changed':
          'Shaidar VPN ta gida ta canza. An dakatar da ci gaba; ku fara sabon haɗi.',
      'system_vpn_resume_identity_invalid':
          'Shaidar da za a yi amfani da ita don ci gaba ba ta da inganci. Ku fara sabon haɗi.',
      'system_vpn_resume_storage_failed':
          'Android ba ta iya karantawa ko sabunta bayanan ci gaba da aka ɓoye ba. Ku fara sabon haɗi.',
      'system_vpn_resume_network_timeout':
          'Android ba ta sami hanyar sadarwa cikin lokaci don ci gaba da VPN ba. Ku sake gwadawa idan an samu hanyar sadarwa.',
      'system_vpn_resume_blocked':
          'An toshe ci gaba da VPN. Ku duba saitunan Android, sannan ku fara sabon haɗi.',
      'system_vpn_resume_failed':
          'Ci gaba da VPN a Android ya gaza. Ku fara sabon haɗi a cikin manhajar.',
      'system_vpn_resume_error_invalid':
          'Android ta dawo da kuskuren ci gaba wanda ba za a iya amfani da shi ba. Ku fara sabon haɗi.',
      'wireguard_identity_store_failed':
          'Android ba ta iya adana shaidar WireGuard da aka ɓoye ta wannan asusu ba.',
      'wireguard_identity_unavailable':
          'Babu shaidar WireGuard da za a iya amfani da ita don wannan haɗin.',
      'vpn_host_destroyed':
          'An dakatar da ɓangaren Android da ke gudanar da VPN. Ku fara sabon haɗi.',
      'vpn_host_unavailable':
          'Android ba ta iya ƙirƙirar ɓangaren da ke gudanar da VPN ba. Ku sake gwadawa bayan kun duba saitunan VPN.',
      'openvpn_renewal_required':
          'Ba a iya sabunta takardar shaidar OpenVPN ta atomatik ba. Ku fara sabon haɗi a cikin manhajar.',
      'openvpn_recovery_failed':
          'Dawo da haɗi ta atomatik ya gaza. Ku fara sabon haɗi a cikin manhajar.',
      'openvpn_recovery_exhausted':
          'An riga an yi amfani da dawo da haɗi ta atomatik. Ku fara sabon haɗi a cikin manhajar.',
      'vpn_permission_required':
          'Android tana buƙatar sabon izinin VPN kafin fara ramin.',
      'vpn_permission_denied':
          'Ku ba da izini ga FuzeVPN a cikin buƙatar Android don ci gaba.',
      'vpn_permission_request_failed':
          'Android ba ta iya buɗe allon izinin VPN ba.',
      'wireguard_foreground_service_unavailable':
          'Android ba ta iya ci gaba da sabis ɗin WireGuard a sahun gaba ba.',
      'wireguard_identity_invalid':
          'Maɓallin WireGuard da aka ɓoye na wannan asusu ba za a iya karanta shi ba ko kuma ba shi da inganci.',
      'wireguard_identity_in_use':
          'Wani aiki har yanzu yana amfani da maɓallin WireGuard na wannan asusu.',
      'wireguard_configuration_invalid':
          'Adireshi, DNS, maɓallin sabar, ko hanyoyin WireGuard da aka karɓa ba su da inganci.',
      'wireguard_operation_pending':
          'Aikin WireGuard da ya gabata bai saki sabis ɗinsa na asali ba tukuna.',
      'wireguard_start_failed': 'Injin WireGuard ya ƙi kunna saitin.',
      'wireguard_stop_timeout':
          'Sabis ɗin WireGuard bai tabbatar da sakin mahaɗar VPN cikin lokacin da aka ƙayyade ba.',
      'wireguard_handshake_timeout':
          'Ramin bai tabbatar da musafaha da sabar cikin lokaci ba.',
      'openvpn_connection_timeout':
          'OpenVPN bai tabbatar da haɗi da sabar cikin lokaci ba.',
      'openvpn_core_unavailable':
          'Wannan sigar manhajar ba ta ƙunshe da injin OpenVPN da za a iya amfani da shi ba.',
      'openvpn_operation_pending':
          'Injin na asali har yanzu yana riƙe da zaman OpenVPN na baya kuma ya ƙi ƙirƙirar na biyu.',
      'openvpn_stop_timeout':
          'OpenVPN Core bai tabbatar da cewa zamansa na asali ya tsaya kuma an share shi cikin lokacin da aka ƙayyade ba.',
      'openvpn_profile_unavailable':
          'Ba a iya karanta ingantaccen bayanin martabar OpenVPN don wannan haɗin ba.',
      'openvpn_native_failed':
          'Kuskuren manhaja ya katse OpenVPN. Ku sake gwada haɗi. Idan matsalar ta ci gaba, ku fara bincike.',
      'openvpn_key_generation_failed':
          'Android Keystore ba ta iya ƙirƙira ko karanta maɓallin sirri na P-256 wanda ba za a iya fitar da shi ba.',
      'openvpn_csr_generation_failed':
          'Maɓallin Android Keystore bai iya sanya hannu kan buƙatar takardar shaidar OpenVPN ba.',
      'openvpn_identity_store_failed':
          'Ba a iya adana takardar shaida ko bayanin martabar OpenVPN a cikin ma’ajiyar da aka ɓoye ba.',
      'openvpn_identity_clear_failed':
          'Android ba ta iya cire dukkan shaidar OpenVPN ta gida ta wannan asusu ba.',
      'openvpn_identity_in_use':
          'Wani zaman OpenVPN na asali har yanzu yana amfani da maɓalli ko takardar shaidar wannan na’ura.',
      'openvpn_tls_verification_required':
          'Bayanin martaba bai bayyana sarai cewa yana buƙatar tabbatar da takardar shaidar sabar ba.',
      'openvpn_cipher_invalid':
          'Sabar ta aika hanyar ɓoye da ba ta cikin jerin da aka yarda da su.',
      'openvpn_profile_rejected':
          'Bayanin martaba da aka karɓa daga sabar bai dace ba. Ku sake ƙirƙirar wannan na’ura, sannan ku sake gwadawa.',
      'openvpn_identity_inconsistent':
          'Takardar shaidar ba ta dace da shaidar tsaro ta wannan waya ba. Ba a maye gurbin wani bayanin martaba na gida ba.',
      'tls_handshake_failed':
          'Sabar ta ƙi tattaunawar TLS. Ku sake ƙirƙirar bayanin martaba idan matsalar ta ci gaba.',
      'tls_alert_unknown_ca':
          'Sabar ba ta gane hukumar da ta bayar da takardar shaidar wannan na’ura ba. Dole ne a duba sabar OpenVPN.',
      'tls_alert_bad_certificate':
          'Sabar ta ƙi takardar shaidar wannan na’ura. Ku sake ƙirƙirar na’urar kafin ku sake gwadawa.',
      'tls_alert_unsupported_certificate':
          'Sabar ba ta goyi bayan nau’in takardar shaida mai tsaro da Android ke amfani da shi ba.',
      'tls_client_certificate_required':
          'Sabar tana buƙatar takardar shaidar abokin ciniki, amma OpenVPN Core ya kasa gabatar da ɗaya.',
      'tls_alert_misc':
          'Sabar ta aika gargaɗin TLS wanda ba ya cikin rukunin takardar shaida ko sigar.',
      'tls_signature_algorithm_rejected':
          'Sabar ta ƙi tsarin ECDSA P-256 na maɓallin Android Keystore.',
      'tls_handshake_rejected': 'Sabar ta katse tattaunawar TLS kafin haɗi.',
      'tls_version_rejected':
          'Abokin ciniki da sabar ba su da sigar TLS iri ɗaya.',
      'tls_certificate_expired':
          'Takardar shaidar da aka gabatar yayin haɗi ta ƙare.',
      'tls_certificate_revoked':
          'An soke takardar shaidar da aka gabatar yayin haɗi.',
      'transport_failed':
          'Sabar OpenVPN ba ta amsa a kan hanyar sadarwa ta yanzu ba. Ku sake gwadawa bayan ɗan lokaci kaɗan.',
      'tun_configuration_rejected':
          'Android ta ƙi saitin hanyar sadarwa da OpenVPN ya nema.',
      'tun_setup_failed':
          'OpenVPN Core ya ƙi tsarin hanyar sadarwa kafin ƙirƙirar mahaɗar Android.',
      'tun_interface_create_failed':
          'OpenVPN Core ya kasa samun mahaɗar TUN daga VpnService na Android.',
      'tun_interface_disabled':
          'Android ko OpenVPN Core sun kashe mahaɗar TUN yayin haɗi.',
      'tun_halted': 'OpenVPN Core ya karɓi buƙatar dakatar da mahaɗar TUN.',
      'tun_already_established':
          'OpenVPN ya nemi mahaɗa ta biyu a cikin haɗi ɗaya. An dakatar da ramin don tsaro.',
      'tun_addresses_missing':
          'Sabar ba ta bayar da adireshin rami da za a iya amfani da shi ba.',
      'tun_routes_missing':
          'Sabar ba ta bayar da hanyoyin rami da za a iya amfani da su ba.',
      'tun_dns_missing':
          'Sabar ba ta bayar da sabar DNS da za a iya amfani da ita ba.',
      'tun_permission_revoked': 'Android ta soke izinin VPN yayin haɗi.',
      'tun_establish_returned_null':
          'Android ba ta ƙirƙiri mahaɗar ba, galibi saboda wani VPN har yanzu yana aiki.',
      'openvpn_service_start_failed':
          'Android ba ta iya fara sabis ɗin OpenVPN a sahun gaba ba.',
      'openvpn_operation_timeout':
          'Kiran JNI zuwa OpenVPN Core ya wuce matsakaicin lokacinsa.',
      'openvpn_start_failed':
          'Sabis ɗin Android a shirye yake, amma OpenVPN Core bai karɓi fara bayanin martaba ba.',
      'openvpn_connection_failed':
          'OpenVPN Core ya tsaya kafin ya aika lamarin CONNECTED.',
      'openvpn_core_status_error':
          'Madauki na OpenVPN na asali ya ƙare da kuskure ba tare da wani takamaiman lamari na ƙarshe ba.',
      'openvpn_stopped_before_connected':
          'Madauki na OpenVPN na asali ya tsaya kafin CONNECTED, ba tare da bayyanannen kuskure daga Core ba.',
      'openvpn_auth_failed': 'Sabar OpenVPN ta ƙi tantance bayanin martaba.',
      'openvpn_client_setup_failed':
          'OpenVPN Core ya kasa shirya abokin ciniki kafin haɗin hanyar sadarwa.',
      'openvpn_client_halted':
          'OpenVPN Core ya karɓi umarnin dakatar da abokin ciniki na ƙarshe.',
      'openvpn_client_restart':
          'OpenVPN Core ya nemi sake farawar zaman sufurinsa.',
      'openvpn_inactive_timeout':
          'OpenVPN Core ya rufe zaman bayan lokacin rashin aiki ya ƙare.',
      'openvpn_session_expired': 'Sabar ta bayyana cewa zaman OpenVPN ya ƙare.',
      'openvpn_credentials_required':
          'Sabar ko wakili suna neman bayanan shiga na mu’amala waɗanda ba sa cikin wannan bayanin martabar takardar shaida.',
      'openvpn_proxy_failed':
          'OpenVPN Core ya bayyana gazawar wakili ko mai isar da bayanai da aka saita.',
      'openvpn_compression_failed':
          'OpenVPN Core ya ƙi yanayin matsawa da bayanin martaba ko sabar suka sanar.',
      'openvpn_ntlm_crypto_unavailable':
          'Bayanin martaba yana neman ɓoyewar NTLM wadda ba ta samuwa a wannan sigar.',
      'openvpn_feature_unsupported':
          'Bayanin martaba ko sabar yana buƙatar fasalin da ya ɓace daga wannan abokin ciniki na Android.',
      'network_unavailable':
          'Babu hanyar sadarwa ta zahiri da za a iya amfani da ita.',
      'network_lost': 'An dakatar da ramin bayan hanyar sadarwa ta ɓace.',
      'certificate_validation_failed':
          'Ba a iya tabbatar da shaidar sabar OpenVPN ba.',
      'openvpn_certificate_expired':
          'Takardar shaidar OpenVPN ta ƙare. Ku fara sabon haɗi a cikin manhajar don sabunta ta.',
      'tunnel_active_for_another_account':
          'Dole ne ramin wani asusu ya tsaya kafin wannan haɗin.',
      'tunnel_already_active':
          'Android ta bayyana cewa zaman VPN na baya har yanzu yana amfani da mahaɗar.',
      'tunnel_stop_timeout':
          'Injin $protocol bai tabbatar da sakin mahaɗar VPN cikin lokacin da aka ƙayyade ba.',
      'tunnel_disconnected':
          'Injin na asali ya bayyana cewa ramin ya ƙare ba zato ba tsammani bayan an fara shi.',
      'native_bridge_unavailable':
          'Manhajar ba za ta iya shiga sabis ɗin VPN na Android ba. Ku rufe manhajar, ku sake buɗe ta, sannan ku sake gwadawa.',
      'native_operation_failed':
          'Kuskuren manhaja ya katse aikin VPN. Ku sake gwadawa. Idan matsalar ta ci gaba, ku fara bincike.',
      'invalid_arguments':
          'Bayanan da ake buƙata don wannan aikin VPN ba su cika ba. Ku sake gwadawa. Idan matsalar ta ci gaba, ku fara bincike.',
      'invalid_account_id':
          'Aikin na asali ba shi da alaƙa da ingantaccen mai gano asusu.',
      'invalid_device_id':
          'Mai gano na’urar da aka aika wa injin na asali ya ɓace ko kuma ba shi da inganci.',
      'storage_key_not_allowed':
          'Gadar Android ta toshe maɓalli wanda ba ya cikin jerin ma’ajiyar da aka yarda da su.',
      'secure_storage_read_failed':
          'Android Keystore ba ta iya warware ɓoyayyun bayanan gida na wannan asusu ba.',
      'secure_storage_write_failed':
          'Android Keystore ba ta iya ɓoye ko adana bayanan gida ba.',
      'key_generation_failed':
          'Android ba ta iya ƙirƙira ko karanta maɓallin WireGuard a cikin ma’ajiya mai tsaro ba.',
      'csr_generation_failed':
          'Android Keystore ba ta iya ƙirƙira ko sanya hannu kan CSR na OpenVPN P-256 ba.',
      'other':
          'Wani reshe na asali wanda ba a rubuta ba ya gaza. Ku aika lambar rahoton bincike da ke ƙasa ga tallafi.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Buƙatar izini ta riga ta buɗe';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Buƙatar izinin VPN na Android tana nan a buɗe. Ku kammala ta kafin ku sake gwadawa.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'An katse buƙatar izinin VPN';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Allon izinin VPN ya rufe kafin manhajar ta karɓi amsa.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Ba a tabbatar da haɗin OpenVPN ba';

  @override
  String get notice_openvpnProofMissing_message =>
      'Ba a iya tabbatar da haɗin OpenVPN ba. An dakatar da shi don tsaro. Ku sake gwadawa.';

  @override
  String get openvpnCleanup_title => 'An soke bayanin martabar OpenVPN';

  @override
  String get openvpnCleanup_working =>
      'Ana dakatar da bayanin martabar OpenVPN da aka soke, sannan ana cire shi…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Ba a tabbatar da rufe OpenVPN ba. Ku sake gwadawa kafin ku ƙirƙiri sabon bayanin martaba.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Ba a iya cire bayanin martabar OpenVPN da aka soke gaba ɗaya ba. Ku sake gwada cirewar.';

  @override
  String get openvpnCleanup_complete =>
      'An cire bayanin martabar OpenVPN da aka soke. Ku taɓa Haɗa don ƙirƙirar sabo.';

  @override
  String get network_title => 'Saitin hanyar sadarwa';

  @override
  String get network_ipv4Fallback =>
      'IPv6 ba ya samuwa na ɗan lokaci. Ana ci gaba da shiri da IPv4.';

  @override
  String get network_rejectedTitle => 'An ƙi saitin hanyar sadarwa';

  @override
  String get network_rejectedMessage =>
      'Saitin ramin bai cika ba ko kuma bai dace da adiresoshin da aka ba da izini ba. Ku sake gwadawa daga manhajar.';

  @override
  String get network_unreadableTitle => 'Ba a iya karanta saitin gida ba';

  @override
  String get network_unreadableMessage =>
      'Ba za a iya amfani da saitin hanyar sadarwar OpenVPN da aka adana ba. Ku sake haɗawa daga manhajar don sabunta shi.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Kariyar hanyar sadarwa';

  @override
  String get protection_subtitle =>
      'Toshe samun intanet kai tsaye idan VPN ya katse.';

  @override
  String get protection_active => 'Kariyar tsarin tana aiki';

  @override
  String get protection_alwaysOnOnly =>
      'An kunna VPN mai aiki koyaushe; ana buƙatar kunna toshe haɗi ba tare da VPN ba';

  @override
  String get protection_inactive => 'Kariyar tsarin ba ta aiki';

  @override
  String get protection_unknown => 'Ku duba kariyar tsarin';

  @override
  String get protection_openSettings => 'Buɗe saitunan Android';

  @override
  String get protection_dialogTitle => 'Saita kariyar hanyar sadarwa';

  @override
  String get protection_dialogMessage =>
      'Android tana sarrafa VPN mai aiki koyaushe da toshe haɗin da ke wajen VPN. Ku tabbata an zaɓi FuzeVPN, sannan ku kunna toshewa a saitunan tsarin.';

  @override
  String get protection_dialogOpen => 'Buɗe saituna';

  @override
  String get session_systemProtectionNote =>
      'Idan Android har yanzu tana toshe zirga-zirga a wajen VPN, ku buɗe saitunan tsarin don dubawa ko canza wannan kariyar.';

  @override
  String get diagnostics_title => 'Rahoton bincike';

  @override
  String get diagnostics_settingsTitle => 'Rahoton bincike na manhaja';

  @override
  String get diagnostics_automaticTitle => 'Aika muhimman kurakurai';

  @override
  String get diagnostics_automaticDescription =>
      'Ku raba ƙaramin rahoton fasaha lokacin da wani muhimmin kuskure ya faru.';

  @override
  String get diagnostics_privacy =>
      'Rahotannin da aka aika suna da alaƙa da asusun da aka shiga, kuma ana ajiye su na tsawon kwanaki 30. Ba su ƙunshi tarihin lilo, kalmomin sirri ko maɓallan VPN ba.';

  @override
  String get diagnostics_manualOpen => 'Fara bincike';

  @override
  String get diagnostics_localDescription =>
      'Ku ƙirƙiri rahoton yanayin manhaja da VPN. Haɗinku zai kasance yadda yake.';

  @override
  String get diagnostics_sendReport => 'Aika rahoton';

  @override
  String get diagnostics_sendHint =>
      'Kada ku yi alama a wannan akwati don ajiye rahoton a kan wannan na’ura.';

  @override
  String get diagnostics_signedOut => 'Ku shiga asusunku don aika rahoto.';

  @override
  String get diagnostics_localLifetime =>
      'Ku ajiye wannan rahoto a wayarku don ci gaba da samunsa bayan kun rufe manhajar.';

  @override
  String get diagnostics_run => 'Fara bincike';

  @override
  String get diagnostics_rerun => 'Sake fara bincike';

  @override
  String get diagnostics_running => 'Ana dubawa…';

  @override
  String get diagnostics_sending => 'Ana aika rahoto…';

  @override
  String get diagnostics_prepared => 'Rahoto a shirye yake a wannan na’ura';

  @override
  String get diagnostics_queued => 'Rahoto yana jiran a aika shi';

  @override
  String get diagnostics_sent => 'An karɓi rahoton';

  @override
  String get diagnostics_failed =>
      'Aika bai yi nasara ba. Rahotonku na gida yana nan.';

  @override
  String get diagnostics_preparationFailed =>
      'Ba a iya shirya rahoton bincike ba. Ku sake gwadawa.';

  @override
  String get diagnostics_authenticationRequired =>
      'Ku sake shiga asusu don aika rahoton.';

  @override
  String get diagnostics_retry => 'Sake gwada aikawa';

  @override
  String get diagnostics_export => 'Ajiye rahoto';

  @override
  String get diagnostics_exportFailed =>
      'Fitar da rahoto bai yi nasara ba. Ku sake gwadawa daga rahoton na gida.';

  @override
  String get diagnostics_preferenceFailed =>
      'Ba a iya ajiye wannan saitin ba. Ku sake gwadawa.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Lambar bin diddigi: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'An karɓa a ranar $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Za a ajiye shi har zuwa $date';
  }

  @override
  String get diagnostics_duplicate => 'An riga an karɓi wannan rahoton.';

  @override
  String get diagnostics_preview => 'Duba rahoton';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'An haɗa lamuran fasaha $count',
      one: 'An haɗa lamarin fasaha 1',
      zero: 'Ba a haɗa wani lamarin fasaha ba',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Cikakkun bayanan fasaha';

  @override
  String get diagnostics_empty => 'Ba a shirya wani rahoton bincike ba tukuna.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Yanayin rami',
      'handshake': 'Tabbatar da haɗi',
      'certificate': 'Takardar shaidar VPN',
      'kill_switch': 'Kariyar Android',
      'connectivity': 'Hanyar sadarwa da ke akwai',
      'api_reachability': 'Samun damar sabis',
      'secure_storage': 'Ma’ajiya mai tsaro',
      'other': 'Binciken gida',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'An duba',
      'failed': 'Yana buƙatar kulawa',
      'skipped': 'Ba a gwada ba — babu gwaji mai aiki',
      'unknown': 'Bayani ba ya samuwa',
      'other': 'Bayani ba ya samuwa',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Barka da zuwa FuzeVPN';

  @override
  String get connection_changeLocation => 'Canza wuri';

  @override
  String get connection_details => 'Cikakkun bayanan haɗi';

  @override
  String get locations_searchLabel => 'Bincika birni ko ƙasa';

  @override
  String get locations_clearSearch => 'Share bincike';

  @override
  String get locations_filterAll => 'Duka';

  @override
  String get locations_filterFavorites => 'Waɗanda aka fi so';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'wurare $count',
      one: 'wuri $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Ba a sami wuri ba';

  @override
  String get locations_noResultsHint => 'Ku gwada wani birni ko ƙasa.';

  @override
  String get locations_noFavorites => 'Waɗanda kuka fi so, a kusa da ku';

  @override
  String get locations_noFavoritesHint =>
      'Ku taɓa tauraron da ke gefen wuri don ajiye shi a nan.';

  @override
  String get locations_showAll => 'Duba dukkan wurare';

  @override
  String locations_addFavorite(String name) {
    return 'Ƙara $name cikin waɗanda aka fi so';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Cire $name daga waɗanda aka fi so';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Ba a iya ajiye wanda aka fi so ba. Ku sake gwadawa.';

  @override
  String get locations_emptyTitle => 'Babu wuri da ke samuwa';

  @override
  String get locations_emptyHint => 'Ku sabunta jerin don sake gwadawa.';

  @override
  String get devices_manage => 'Sarrafa na’urorina';

  @override
  String get settings_personalization => 'Keɓance shi yadda kuke so';

  @override
  String get settings_safety => 'Kariya';

  @override
  String get settings_help => 'Kuna buƙatar taimako?';

  @override
  String get settings_about => 'Game da FuzeVPN';

  @override
  String get diagnostics_heading => 'Fahimtar matsalar haɗi';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Akwai',
      'pending': 'Ana shiryawa',
      'revoked': 'An cire',
      'expired': 'Ya ƙare',
      'other': 'Matsayi ba ya samuwa',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Ba a ajiye zaɓi ba';

  @override
  String get notice_preferenceSave_message =>
      'Zaɓinku yana aiki yanzu, amma ba a iya ajiye shi ba. Ku sake gwadawa don ci gaba da shi bayan kun rufe manhajar.';

  @override
  String get connection_androidDisconnectHint =>
      'Idan Android ta ci gaba da kunna VPN, ku kashe VPN mai aiki koyaushe a saitunan da za su buɗe.';

  @override
  String get connection_certificate => 'Takardar shaidar OpenVPN';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Tana aiki har zuwa $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Ta ƙare a ranar $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Za a sabunta takardar shaidar ta atomatik a haɗi na gaba.';

  @override
  String get protection_learnMore => 'Koyi game da kariyar Android';

  @override
  String get protection_guideWhy =>
      'Wannan kariyar tana hana manhajoji amfani da intanet kai tsaye idan VPN ya katse. Ana saita ta a Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN mai aiki koyaushe';

  @override
  String get protection_guideAlwaysOn =>
      'Android tana ci gaba da gudanar da sabis ɗin VPN kuma tana iya sake kunna shi bayan wayar ta sake farawa.';

  @override
  String get protection_guideBlockTitle => 'Toshe haɗi ba tare da VPN ba';

  @override
  String get protection_guideBlock =>
      'Wannan saitin yana hana zirga-zirga ketare VPN, har da lokacin da haɗin ya katse.';

  @override
  String get protection_guideWarning =>
      'Idan an kunna wannan toshewar, intanet zai kasance a kashe har sai an haɗa VPN.';

  @override
  String get protection_guideStepsTitle => 'Kunna kariya';

  @override
  String get protection_guideStep1 =>
      'Ku buɗe saitunan VPN na Android ta maɓallin da ke ƙasa.';

  @override
  String get protection_guideStep2 =>
      'Ku buɗe zaɓuɓɓuka ta gunkin saituna da ke kusa da FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Ku kunna VPN mai aiki koyaushe, sannan ku kunna Toshe haɗi ba tare da VPN ba, idan waɗannan zaɓuɓɓukan suna nan.';

  @override
  String get protection_guideManufacturers =>
      'Sunaye sun bambanta daga waya zuwa waya. Idan ya zama dole, ku nemi VPN a Saituna, sau da yawa a ƙarƙashin Hanyar sadarwa da intanet.';

  @override
  String get protection_guideDisableTitle => 'Kashe wannan kariyar';

  @override
  String get protection_guideDisable =>
      'A cikin waɗannan saitunan, ku kashe toshe haɗi ba tare da VPN ba don ba da damar shiga intanet ba tare da VPN ba. Ku kuma kashe VPN mai aiki koyaushe idan ba ku son Android ta sake kunna shi.';

  @override
  String get protection_guideManual =>
      'Ku ne kuke zaɓar waɗannan saitunan a Android. FuzeVPN ba ya canza muku su.';

  @override
  String get locations_changeTitle => 'Canza wuri?';

  @override
  String locations_changeActive(String name) {
    return 'VPN zai katse haɗi, sannan ya yi ƙoƙarin haɗawa da $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN zai yi ƙoƙarin haɗawa da $name.';
  }

  @override
  String get locations_confirmChange => 'Canza kuma haɗa';

  @override
  String get locations_changeBusy =>
      'Ana yin canji a yanzu. Ku jira kafin ku zaɓi wani wuri.';

  @override
  String get locations_automaticSelection => 'Zaɓi na atomatik';

  @override
  String get locations_cities => 'Birane';

  @override
  String get locations_servers => 'Sabobi';

  @override
  String locations_viewCities(String name) {
    return 'Duba birane a $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Duba sabobi a $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ƙasashe $count',
      one: 'ƙasa $count',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'birane $count',
      one: 'birni $count',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sabobi $count',
      one: 'sabar $count',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Duk ƙasashe';

  @override
  String get locations_backToCountries => 'Koma zuwa ƙasashe';

  @override
  String locations_backToCities(String name) {
    return 'Koma zuwa birane a $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Zaɓi $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Zaɓi $name';
  }

  @override
  String get locations_noCompatibleServer => 'Babu sabar da ta dace.';

  @override
  String get externalLink_failed =>
      'Ba a iya buɗe wannan hanyar haɗi ba. Kuna iya kwafa ta ku buɗe ta a burauzarku.';

  @override
  String get externalLink_copy => 'Kwafi hanyar haɗi';

  @override
  String get externalLink_copied => 'An kwafi hanyar haɗi';

  @override
  String get externalLink_copyFailed =>
      'Ba a iya kwafa hanyar haɗin ba. Ku zaɓi adireshin da ke ƙasa.';

  @override
  String get settings_deleteAccount => 'Goge asusuna';

  @override
  String get settings_deleteAccountDetail => 'Duba matakan buƙatar goge asusu';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Ku zaɓi biyan kuɗin VPN ɗinku.';

  @override
  String get billing_subscribe => 'Yi rajista';

  @override
  String get billing_choosePlan => 'Ku zaɓi tsari don ci gaba.';

  @override
  String get billing_monthly => 'Kowane wata';

  @override
  String get billing_yearly => 'Kowace shekara';

  @override
  String get billing_continue => 'Ci gaba da Google Play';

  @override
  String get billing_restore => 'Dawo da sayayya';

  @override
  String get billing_manage => 'Sarrafa biyan kuɗi';

  @override
  String get billing_deleteAccountWarning =>
      'Idan kuna da biyan kuɗin Google Play, goge asusun FuzeVPN ɗinku ba zai soke sabuntawarsa ba. Ku sarrafa ko ku soke sabuntawar daban a Google Play.';

  @override
  String get billing_deleteAccountContinue => 'Ci gaba zuwa buƙatar goge asusu';

  @override
  String get billing_refresh => 'Sabunta damar shiga';

  @override
  String get billing_loadingPlans => 'Ana ɗora tsare-tsare…';

  @override
  String get billing_unavailable =>
      'Babu tsare-tsare da ake samu yanzu. Ku sake gwadawa daga baya.';

  @override
  String get billing_comingSoon =>
      'Biyan kuɗi zai kasance nan ba da jimawa ba.';

  @override
  String get billing_priceDisclosure =>
      'Google Play ne ke bayar da farashin. Ana tabbatar da jimillar kuɗi da harajin da ya dace kafin ku tabbatar.';

  @override
  String get billing_renewalMonthly =>
      'Ana sabunta shi ta atomatik kowane wata sai dai idan an soke shi. Kuna iya soke a kowane lokaci a cikin biyan kuɗin Google Play.';

  @override
  String get billing_renewalYearly =>
      'Ana sabunta shi ta atomatik kowace shekara sai dai idan an soke shi. Kuna iya soke a kowane lokaci a cikin biyan kuɗin Google Play.';

  @override
  String get billing_active => 'Damar shiga Premium ɗinku tana aiki';

  @override
  String billing_accessUntil(String date) {
    return 'Damar shiga har zuwa $date.';
  }

  @override
  String get billing_webManaged =>
      'Ana sarrafa biyan kuɗinku a gidan yanar gizon FuzeVPN.';

  @override
  String get billing_playManaged => 'Google Play ne ke sarrafa biyan kuɗinku.';

  @override
  String get billing_playOnHold =>
      'Biyan kuɗin Google Play ɗinku yana kan dakatarwa ko yana jiran biyan kuɗi. Ku buɗe “Sarrafa biyan kuɗi” don gyara shi a Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Wannan asusun Google Play ya riga ya mallaki biyan kuɗin Fuze Premium wanda ba ya aiki a wannan asusun FuzeVPN. Ku buɗe “Sarrafa biyan kuɗi” don duba shi a Google Play.';

  @override
  String get billing_inactive => 'Babu biyan kuɗi mai aiki.';

  @override
  String get billing_checkingAccess => 'Ana duba damar shiganku…';

  @override
  String get billing_restoring => 'Ana dawo da sayayya…';

  @override
  String get billing_pending =>
      'Ana jiran biyan kuɗi. Damar shiganku za ta fara aiki bayan an tabbatar da shi.';

  @override
  String get billing_cancelled =>
      'An soke sayayyar. Ba a kunna sabon biyan kuɗi ba.';

  @override
  String get billing_verifying => 'Ana tabbatar da sayayya…';

  @override
  String get billing_success =>
      'An kunna biyan kuɗi. Damar shiganku ta Premium a shirye take.';

  @override
  String get billing_restored => 'An dawo da sayayyarku.';

  @override
  String get billing_restoreEmpty =>
      'Babu sayayya da za a dawo da ita don wannan asusun Google Play.';

  @override
  String get billing_catalogError =>
      'Ba a iya ɗora tsare-tsare ba. Ku sake gwadawa.';

  @override
  String get billing_purchaseError =>
      'Ba a iya fara sayayya ba. Ku sake gwadawa.';

  @override
  String get billing_verificationError =>
      'Tabbatar da sayayya ba ya samuwa na ɗan lokaci. Ku dawo da sayayya don sake gwadawa.';

  @override
  String get billing_restoreError =>
      'Ba a iya dawo da sayayya ba. Ku sake gwadawa.';

  @override
  String get billing_managementError =>
      'Ba a iya buɗe shafin sarrafa biyan kuɗi ba. Ku sake gwadawa.';

  @override
  String get billing_storeUnavailable =>
      'Google Play ba ya samuwa a wannan na’ura.';

  @override
  String get welcome_title => 'VPN ɗinku, cikin sauƙi.';

  @override
  String get welcome_description =>
      'Ku kare haɗinku. Ku ci gaba da sarrafa keɓantawarku.';

  @override
  String get welcome_start => 'Fara';

  @override
  String get welcome_alreadyPurchased => 'Kun riga kun saya?';

  @override
  String get welcome_noAccountRequired => 'Ba a buƙatar asusu don fara amfani.';

  @override
  String get guest_accountTitle => 'Ba a danganta asusu ba';

  @override
  String get guest_accountDescription =>
      'Ku dawo da sayayyarku ta amfani da asusun Google Play iri ɗaya don amfani da biyan kuɗinku a wata na’ura.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Kuna da biyan kuɗi tuni? Shiga asusu';

  @override
  String get guest_claimTitle => 'Ku ɗauki FuzeVPN tare da ku';

  @override
  String get guest_claimDescription =>
      'Ku ƙirƙiri asusu don samun damar biyan kuɗinku a sauran na’urorinku. Wannan mataki na zaɓi ne.';

  @override
  String get guest_skip => 'Wataƙila daga baya';

  @override
  String get guest_activationTitle => 'Fuze Premium yana aiki';

  @override
  String get guest_activationDescription =>
      'Biyan kuɗinku a shirye yake. Ku yi amfani da VPN ɗinku kuma ku ƙirƙiri asusu duk lokacin da kuke so.';

  @override
  String get guest_useVpn => 'Yi amfani da VPN ɗina';

  @override
  String get guest_loginRequired =>
      'An riga an danganta wannan sayayya da asusun FuzeVPN. Ku shiga wannan asusun don samun damar biyan kuɗinku.';

  @override
  String get guest_signOutWarning =>
      'Kuna iya sake samun biyan kuɗinku ta hanyar dawo da sayayya da asusun Google Play iri ɗaya.';

  @override
  String get guest_profileUnavailable =>
      'An riga an danganta asusunku. Ku shiga don duba da sarrafa bayananku.';

  @override
  String get billing_acceptance =>
      'Ta hanyar ci gaba, kun amince da sharuɗɗan amfani da kuma manufar keɓantawa.';

  @override
  String get guest_verifyEmailReminder =>
      'Ku tabbatar da adireshin imel ɗinku don kare asusunku. Kuna iya ci gaba da amfani da VPN ɗinku.';

  @override
  String get guest_serviceUnavailable =>
      'Sabis ɗin ba ya samuwa na ɗan lokaci. Ku sake gwadawa bayan ɗan lokaci kaɗan.';

  @override
  String get guest_restoreError =>
      'Ba a iya dawo da sayayyarku ba. Ku sake gwadawa da asusun Google Play da aka yi amfani da shi wajen sayayyar.';

  @override
  String get guest_claimSuccess =>
      'An ƙirƙiri asusunku. An kiyaye biyan kuɗinku da damar shiga VPN ɗinku.';

  @override
  String get guest_emailExists =>
      'An riga an yi amfani da wannan adireshin imel. Ku zaɓi wani adireshi ko ku shiga asusunku da ke akwai. Sayayyarku za ta ci gaba da samuwa ta Google Play.';

  @override
  String get guest_claimError =>
      'Ba a iya ƙirƙirar asusunku ba. Kuna iya ci gaba da amfani da VPN ɗinku kuma ku sake gwadawa daga baya.';

  @override
  String get guest_secureStorageError =>
      'Ba a iya kare zaman shiganku a wannan na’ura ba. Ku sake gwadawa.';

  @override
  String get guest_premiumRequired => 'Ku zaɓi biyan kuɗi don kunna VPN ɗinku.';

  @override
  String get welcome_viewPlans => 'Duba tsare-tsare';

  @override
  String get google_continue => 'Ci gaba da Google';

  @override
  String get google_or => 'ko';

  @override
  String get google_title => 'Asusun FuzeVPN ɗinku';

  @override
  String get google_settingUp => 'Ku kammala ƙirƙirar asusunku';

  @override
  String get google_country => 'Ƙasar zama';

  @override
  String get google_profileDescription =>
      'Ku zaɓi ƙasarku, sannan ku duba takardu biyu don ƙirƙirar asusun FuzeVPN ɗinku.';

  @override
  String get google_claimDescription =>
      'Ku danganta asusun baƙonku da Google. Biyan kuɗinku da na’urarku za su ci gaba da kasancewa a wannan asusun.';

  @override
  String get google_linkTitle => 'Danganta Google da FuzeVPN';

  @override
  String get google_linkDescription =>
      'Ku tabbatar da damar shiga asusun FuzeVPN ɗinku da ke akwai. Wannan mataki ba ya neman kalmar sirrin Google ɗinku.';

  @override
  String get google_password => 'Kalmar sirrin FuzeVPN';

  @override
  String get google_linkAccount => 'Tabbatar da danganta';

  @override
  String get google_requestEmail => 'Aika mini imel ɗin tabbatarwa';

  @override
  String get google_emailInstructions =>
      'Ku buɗe imel ɗin FuzeVPN, sannan ku shigar da lambar tabbatarwa.';

  @override
  String get google_emailCode => 'Lambar tabbatarwa ta imel';

  @override
  String get google_confirmEmail => 'Tabbatar da lambar';

  @override
  String get google_restart => 'Zaɓi wani asusun Google';

  @override
  String get google_resume => 'Duba wannan yunƙurin';

  @override
  String get google_unavailable =>
      'Shiga da Google ba ya samuwa. Kuna iya amfani da imel da kalmar sirri.';

  @override
  String get google_expired =>
      'Wannan yunƙurin ya ƙare. Ku soke shi, sannan ku sake farawa.';

  @override
  String get google_conflict =>
      'An riga an danganta wannan asusun Google a wani wuri. An kiyaye asusunku da biyan kuɗinku na yanzu.';

  @override
  String get google_error =>
      'Shiga da Google ya gaza. Ku sake gwadawa; an kiyaye damar shiganku ta yanzu.';

  @override
  String get google_uncertain =>
      'Ba a iya tabbatar da sakamakon ba. Ku duba wannan yunƙurin ko ku soke shi kafin ku sake farawa.';

  @override
  String get google_cancelFailed =>
      'Ba a iya tabbatar da soke shi ba. Ku sake gwada soke shi kafin ku bar wannan allon.';

  @override
  String get google_cancelled => 'An soke shiga da Google.';

  @override
  String get google_selecting => 'Ku zaɓi asusun Google ɗinku…';

  @override
  String get google_verifying => 'Ana duba asusunku…';

  @override
  String get google_emailUnavailable =>
      'Ba a iya aika imel ɗin tabbatarwa ba. Ku sake gwadawa daga baya.';

  @override
  String get google_emailSent =>
      'An aika imel ɗin tabbatarwa. Ku duba akwatin saƙonku.';

  @override
  String get google_rateLimited => 'Don Allah ku jira kafin ku sake gwadawa.';

  @override
  String get google_busy =>
      'Shiga da Google ba ya samuwa yayin da wani aiki ke gudana (haɗin VPN, asusu ko baƙo). Ku sake gwadawa idan ya ƙare; an kiyaye damar shiganku ta yanzu.';

  @override
  String get google_invalidPassword =>
      'Kalmar sirrin FuzeVPN ba daidai ba ce. An kiyaye asusunku na yanzu.';

  @override
  String get google_invalidCode =>
      'Lambar tabbatarwa ba ta da inganci ko ta ƙare.';

  @override
  String get google_accountChanged =>
      'Zaman shiganku ya canza. Ku soke wannan yunƙurin kafin ku sake farawa.';

  @override
  String get google_invalidResponse =>
      'Ba a iya tabbatar da amsar ba. An kiyaye damar shiganku ta yanzu.';

  @override
  String get google_invalidRegistration => 'Ku duba ƙasarku da amincewa biyun.';

  @override
  String get google_consentRequired =>
      'Ku zaɓi ƙasarku, sannan ku karɓi takardu biyun don ci gaba.';

  @override
  String get google_challengeRequired =>
      'Ana buƙatar ƙarin binciken tsaro. An kiyaye damar shiganku ta yanzu.';

  @override
  String get google_challengeUnavailable =>
      'Binciken tsaro ba ya samuwa. Ku sake gwadawa daga baya.';

  @override
  String get google_intentMismatch =>
      'Yunƙurin shiga da Google na baya har yanzu yana jira. Ku soke shi kafin ku fara wannan aikin.';

  @override
  String get google_challengeBlocked =>
      'Binciken tsaron da ake buƙata ba ya samuwa a cikin wannan manhaja. Ba za a iya kammala wannan aikin yanzu ba.';

  @override
  String get google_solveChallenge => 'Kammala binciken tsaro';

  @override
  String get google_challengeTitle => 'Binciken tsaro';

  @override
  String get google_challengeReady =>
      'An kammala tabbatarwa. Yanzu za ku iya tabbatar da ƙirƙirar asusunku.';

  @override
  String get google_challengeExpired =>
      'Tabbatarwar ta ƙare. Ku sake kammala ta kafin ku tabbatar.';

  @override
  String get google_challengeCancelled =>
      'An soke tabbatarwa. Kuna iya sake gwadawa.';

  @override
  String get google_challengeFailed =>
      'Binciken tsaro ya gaza. Ku sake gwadawa.';

  @override
  String get billing_trialTitle => 'Gwada Fuze Premium kyauta';

  @override
  String get billing_trialSubtitle => 'Ku fara kare haɗinku daga yau.';

  @override
  String get billing_trialWeeks => 'Gwajin kyauta na makonni 2';

  @override
  String billing_trialDays(String days) {
    return 'Gwajin kyauta na kwanaki $days';
  }

  @override
  String get billing_trialStart => 'Fara gwajina na kyauta';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Idan kuka fara yau, ana sa ran caji na farko a ranar $date.';
  }

  @override
  String get billing_trialTerms =>
      'Ana sabunta shi ta atomatik a farashin da aka bayyana. Don kauce wa caji, ku soke a Google Play kafin gwajin ya ƙare.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Sannan $price kowane wata';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Sannan $price kowace shekara';
  }

  @override
  String get billing_choosePeriod => 'Ku zaɓi tsarinku';

  @override
  String get billing_selectionHint => 'Ku zaɓi tsari don ci gaba.';

  @override
  String get billing_benefitConnection => 'Ɓoyayyen haɗi';

  @override
  String get billing_benefitPrivacy => 'Keɓantawa a intanet';

  @override
  String get billing_benefitNoAccount => 'Ba a buƙatar rajista';

  @override
  String get billing_cancellation => 'Soke a Google Play';

  @override
  String get billing_premiumTitle => 'Haɗi mai ƙarin kariya.';

  @override
  String get billing_premiumSubtitle => 'Ku kare haɗinku yadda kuka ga dama.';

  @override
  String get billing_priceMonthly => 'kowane wata';

  @override
  String get billing_priceYearly => 'kowace shekara';

  @override
  String get billing_trialToday => 'Babu abin da za ku biya a yau';

  @override
  String get billing_trialConfirmation =>
      'Google Play zai tabbatar da kwanakin, jimillar kuɗi da harajin da ya dace kafin ku tabbatar.';

  @override
  String get billing_offerChanged =>
      'Sharuɗɗan wannan tayin sun canza. Ku sabunta tsare-tsaren, sannan ku sake zaɓa.';

  @override
  String get status_waitingNetwork => 'Ana jiran hanyar sadarwa';

  @override
  String get status_waitingNetworkDetail =>
      'Babu hanyar sadarwa da ake samu. VPN zai tabbatar da haɗin lokacin da hanyar sadarwa ta dawo.';

  @override
  String get locations_favoriteLoadFailed =>
      'Ba a iya ɗora waɗanda aka fi so ba. Ku sake gwadawa.';

  @override
  String get locations_favoritesLoading => 'Ana ɗora waɗanda aka fi so…';
}
