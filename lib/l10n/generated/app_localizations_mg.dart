// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malagasy (`mg`).
class AppLocalizationsMg extends AppLocalizations {
  AppLocalizationsMg([String locale = 'mg']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Arovy ny fifandraisanareo';

  @override
  String get vpnDisclosure_body =>
      'Ny FuzeVPN dia mampiasa ny serivisy VPN ao amin’ny Android (VpnService) mba hamorona tunnel voafina eo anelanelan’ity fitaovana ity sy ny mpizara FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Rehefa mavitrika ny VPN, mandeha amin’ity tunnel ity ny trafikan’ny Internet avy amin’ny fampiharanareo, ny adiresy tanjona ary ny fangatahana DNS mba hitarihana ny fifandraisanareo, na dia ao ambadika aza ny FuzeVPN.';

  @override
  String get vpnDisclosure_statusBody =>
      'Ny fampiharana dia mampiasa ny toetry ny fifandraisana, ny faharetany ary ny habetsahan’ny angona nafindra mba hampisehoana ny fifandraisana VPN. Afaka mampiato azy ianareo amin’ny fotoana rehetra.';

  @override
  String get vpnDisclosure_privacy => 'Tsiambaratelo';

  @override
  String get vpnDisclosure_accept => 'Hanaiky ary hanohy';

  @override
  String get vpnDisclosure_decline => 'Tsy ankehitriny';

  @override
  String get accountRestoration_title =>
      'Tsy azo ampiasaina vonjimaika ny kaonty';

  @override
  String get accountRestoration_message =>
      'Voatahiry ny fidirana. Andramo indray mba hamerina ny kaonty; mbola afaka mitantana ny fifandraisana VPN eto ianareo.';

  @override
  String get action_retry => 'Andramo indray';

  @override
  String get session_endingTitle => 'Mamarana ny fidirana';

  @override
  String get session_ending =>
      'Mamarana ny fidirana: mampiato ny VPN sy manadio…';

  @override
  String get session_stopFailed =>
      'Tsy voamarina ny fampiatoana ny VPN. Andramo indray alohan’ny hiditra indray.';

  @override
  String get session_cleanupFailed =>
      'Niato ny VPN, nefa tsy voamarina ny fanesorana ny fidirana. Andramo indray ny fanadiovana.';

  @override
  String get session_retryStop => 'Andramo indray ny fampiatoana';

  @override
  String get session_retryCleanup => 'Andramo indray ny fanadiovana';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Manomana ny FuzeVPN amin’ny fomba azo antoka…';

  @override
  String get nav_connection => 'Fifandraisana';

  @override
  String get nav_locations => 'Toerana';

  @override
  String get nav_account => 'Kaonty';

  @override
  String get nav_devices => 'Fitaovana';

  @override
  String get nav_settings => 'Fikirana';

  @override
  String get action_refresh => 'Havaozy';

  @override
  String get auth_tab_login => 'Hiditra';

  @override
  String get auth_tab_register => 'Hisoratra anarana';

  @override
  String get auth_stepAccount => 'Kaonty';

  @override
  String get auth_stepIdentity => 'Mombamomba anareo';

  @override
  String get auth_stepAddress => 'Adiresy sy fifanarahana';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Dingana $current amin’ny $total';
  }

  @override
  String get auth_tagline => 'Ny VPN-nareo, natao ho tsotra.';

  @override
  String get auth_keysLocal =>
      'Ny fanalahidy VPN manokana dia mijanona amin’ity fitaovana ity ihany.';

  @override
  String get form_email => 'Adiresy e-mail';

  @override
  String get form_password => 'Teny miafina';

  @override
  String get form_showPassword => 'Asehoy ny teny miafina';

  @override
  String get form_hidePassword => 'Afeno ny teny miafina';

  @override
  String get form_passwordMin =>
      '8–72 oktety UTF-8. Misy litera mampiasa oktety mihoatra ny iray.';

  @override
  String get form_firstName => 'Anarana manokana';

  @override
  String get form_lastName => 'Anarana fianakaviana';

  @override
  String get form_phone => 'Telefaona (+33612345678)';

  @override
  String get form_address => 'Adiresy';

  @override
  String get form_address2 => 'Adiresy, andalana faharoa (tsy voatery)';

  @override
  String get form_postalCode => 'Kaody posta';

  @override
  String get form_city => 'Tanàna';

  @override
  String get form_country => 'Kaody firenena (ohatra: FR)';

  @override
  String get action_login => 'Hiditra';

  @override
  String get action_createAccount => 'Mamorona kaonty';

  @override
  String get action_createMyAccount => 'Mamorona ny kaontiko';

  @override
  String get action_next => 'Hanohy';

  @override
  String get action_previous => 'Hiverina';

  @override
  String get action_forgotPassword => 'Very ny teny miafina?';

  @override
  String get auth_noAccount => 'Tsy mbola manana kaonty ve ianareo?';

  @override
  String get auth_requiredInformation =>
      'Mamorona ny kaontinareo amin’ny dingana telo.';

  @override
  String get auth_termsPrefix => 'Manaiky ny ';

  @override
  String get auth_termsLink => 'fepetra fampiasana';

  @override
  String get auth_privacyPrefix => 'Manaiky ny ';

  @override
  String get auth_privacyLink => 'politikan’ny tsiambaratelo';

  @override
  String get auth_consentRequired => 'Ilaina ny fanekena mba hamorona kaonty.';

  @override
  String get validation_required => 'Ilaina ity saha ity.';

  @override
  String get validation_email => 'Ampidiro adiresy e-mail mety.';

  @override
  String get validation_password =>
      'Fohy loatra ny teny miafina: 8 oktety UTF-8 farafahakeliny.';

  @override
  String get validation_passwordTooLong =>
      'Lava loatra ny teny miafina: 72 oktety UTF-8 farafahabetsany.';

  @override
  String get validation_phone =>
      'Ampiasao ny endrika iraisam-pirenena, ohatra: +33612345678.';

  @override
  String get validation_country =>
      'Ampiasao kaody firenena misy litera roa, ohatra: FR.';

  @override
  String get passwordReset_title => 'Hamerina ny teny miafina';

  @override
  String get passwordReset_description =>
      'Ampidiro ny adiresy e-mail amin’ny kaonty mba hangatahana rohy hamerenana ny teny miafina.';

  @override
  String get passwordReset_send => 'Alefaso ny rohy';

  @override
  String get connection_title => 'Ny fifandraisanareo';

  @override
  String get connection_subtitle =>
      'Misafidiana toerana, avy eo alefaso ny VPN.';

  @override
  String get connection_prepare => 'Vonona hifandray ve?';

  @override
  String get connection_advancedOptions => 'Safidy mandroso';

  @override
  String get connection_location => 'Toerana';

  @override
  String get connection_chooseLocation => 'Misafidiana toerana';

  @override
  String get connection_protocol => 'Protokole';

  @override
  String get connection_connect => 'Hifandray';

  @override
  String get connection_connecting => 'Mifandray…';

  @override
  String get connection_disconnect => 'Hiala';

  @override
  String get connection_disconnecting => 'Miala';

  @override
  String get connection_locationChange => 'Miova toerana…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol tsy azo ampiasaina';
  }

  @override
  String get connection_activeLocation => 'Toerana mavitrika';

  @override
  String get connection_duration => 'Faharetana';

  @override
  String get connection_received => 'Voaray';

  @override
  String get connection_sent => 'Nalefa';

  @override
  String get connection_lastHandshake => 'Fifanakalozana azo antoka farany';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration lasa izay';
  }

  @override
  String get verification_title => 'Hamarino ny adiresy e-mail';

  @override
  String get verification_message =>
      'Hamarino ny adiresy e-mail mba hampiasana ny VPN amin’ity telefaona ity.';

  @override
  String get verification_resend => 'Alefaso indray ny e-mail';

  @override
  String get migration_title => 'Fiovana toerana';

  @override
  String get migration_draining => 'Manomana ny fiovana toerana…';

  @override
  String get migration_activating => 'Mampandeha ny mpizara vaovao…';

  @override
  String get migration_ready => 'Voavaovao ny toerana.';

  @override
  String get migration_blocked =>
      'Mitaky fitsabahan’ny mpizara ny fiovana toerana. Andramo indray any aoriana na mifandraisa amin’ny fanohanana.';

  @override
  String get migration_progress => 'Fandrosoan’ny fiovana toerana';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Fanemorana eo anelanelan’ny fanamarinana: $seconds s.';
  }

  @override
  String get migration_resume => 'Hanohy ny fiovana toerana';

  @override
  String get status_authorizing => 'Ilaina ny alalana';

  @override
  String get status_authorizingDetail =>
      'Ekeno ny fangatahana Android mba hamela ny VPN.';

  @override
  String get status_preparing => 'Manomana';

  @override
  String get status_preparingDetail => 'Manomana ny fifandraisana azo antoka.';

  @override
  String get status_reconnecting => 'Mifandray indray…';

  @override
  String get status_reconnectingDetail =>
      'Voatapaka ny fifandraisana. Manandrana mifandray indray ny VPN.';

  @override
  String get status_connecting => 'Mifandray';

  @override
  String get status_connectingDetail => 'Mifandray amin’ny mpizara VPN…';

  @override
  String get status_connected => 'Nifandray';

  @override
  String get status_connectedDetail => 'Mavitrika ny fifandraisana VPN.';

  @override
  String get status_disconnecting => 'Miala';

  @override
  String get status_disconnectingDetail => 'Miato ny fifandraisana VPN.';

  @override
  String get status_error => 'Tsy azo ampiasaina ny fifandraisana';

  @override
  String get status_errorDetail =>
      'Tsy voamarina ny fifandraisana VPN. Andramo indray.';

  @override
  String get status_idle => 'Tsy mifandray';

  @override
  String get status_idleDetail =>
      'Mifandraisa amin’ny VPN mba hiarovana ny fifandraisanareo.';

  @override
  String get trust_note =>
      'Tsy mampiato ny VPN ny fanakatonana ny fampiharana. Mba hampiatoana azy, tsindrio ny Hiala.';

  @override
  String get locations_none =>
      'Tsy misy toerana azo ampiasaina amin’izao fotoana izao.';

  @override
  String get locations_available => 'Misafidiana ny toerana manaraka.';

  @override
  String get locations_selected => 'Toerana voafidy';

  @override
  String get locations_select => 'Safidio ity toerana ity';

  @override
  String get locations_lockedTunnel => 'Ampiato ny VPN mba hiova toerana.';

  @override
  String get locations_lockedMigration =>
      'Miandrasa ho vita ny fiovana toerana.';

  @override
  String get devices_title => 'Ny fitaovanareo';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit fitaovana';
  }

  @override
  String get devices_refresh => 'Havaozy ny fitaovana';

  @override
  String get devices_empty => 'Tsy mbola misy fitaovana VPN voasoratra.';

  @override
  String get devices_firstConnection =>
      'Ho ampidirina amin’ny fifandraisana voalohany ny telefaonanareo.';

  @override
  String get devices_thisDevice => 'Ity fitaovana ity';

  @override
  String devices_added(Object date) {
    return 'Nampidirina tamin’ny $date';
  }

  @override
  String get devices_unnamed => 'Fitaovana tsy misy anarana';

  @override
  String get action_remove => 'Esory';

  @override
  String get settings_title => 'Fikirana';

  @override
  String get settings_subtitle =>
      'Ny safidinareo sy ny kaontinareo, eo amin’ny toerana iray.';

  @override
  String get settings_appearance => 'Endrika';

  @override
  String get settings_language => 'Fiteny';

  @override
  String get settings_languageDescription =>
      'Ny fiteny nofidinareo dia ampiharina koa amin’ny fampandrenesana VPN.';

  @override
  String get settings_account => 'Kaonty';

  @override
  String get settings_signOut => 'Hivoaka';

  @override
  String get settings_privacy => 'Politikan’ny tsiambaratelo';

  @override
  String get settings_terms => 'Fepetra fampiasana';

  @override
  String get settings_security => 'Fiarovana sy fangaraharana';

  @override
  String get settings_licenses => 'Fahazoan-dalana ho an’ny singa';

  @override
  String get settings_licensesDetail =>
      'Rindrambaiko ampiasaina ao amin’ny fampiharana';

  @override
  String settings_licensesLegalese(String url) {
    return 'Kaody loharano ho an’ny fampiharana sy ireo singa MPL-2.0 ao aminy: $url';
  }

  @override
  String get settings_background =>
      'Mijanona mavitrika ny VPN rehefa mivoaka ny fampiharana. Mba hampiatoana azy, tsindrio ny Hiala ao amin’ny fizarana Fifandraisana.';

  @override
  String get theme_system => 'Rafitra';

  @override
  String get theme_light => 'Mazava';

  @override
  String get theme_dark => 'Maizina';

  @override
  String get language_system => 'Fitenin’ny telefaona';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Hesorina ve ity fitaovana ity?';

  @override
  String get dialog_removeCurrent =>
      'Hiala amin’ny VPN ity telefaona ity ary tsy hahazo miditra intsony. Ho esorina ny angon-drakitra momba ny fifandraisana VPN aminy rehefa voamarin’ny mpizara.';

  @override
  String dialog_removeOther(Object name) {
    return 'Hofoanana ny fidirana VPN ho an’ny “$name”. Tsy azo averina izany.';
  }

  @override
  String get dialog_signOut => 'Hivoaka ve?';

  @override
  String get dialog_signOutMessage =>
      'Hiato ny VPN ary mila miditra indray ianareo. Hijanona amin’ity telefaona ity ny fanalahidy VPN voafina ho an’ny fifandraisana manaraka.';

  @override
  String get action_cancel => 'Hanafoana';

  @override
  String get action_close => 'Akatony';

  @override
  String get action_copy => 'Adikao';

  @override
  String get action_signOut => 'Hivoaka';

  @override
  String get notice_close => 'Akatony ny hafatra';

  @override
  String get notice_sessionExpired_title => 'Lany fotoana ny fidirana';

  @override
  String get notice_sessionExpired_message =>
      'Lany fotoana ny fidirana. Midira indray.';

  @override
  String get notice_connectionFailed_title => 'Tsy nahomby ny fifandraisana';

  @override
  String get notice_invalidCredentials_message =>
      'Diso ny adiresy e-mail na ny teny miafina.';

  @override
  String get notice_emailVerification_title =>
      'Ilaina ny fanamarinana ny adiresy e-mail';

  @override
  String get notice_emailVerification_message =>
      'Hamarino ny adiresy e-mail alohan’ny hampidirana fitaovana VPN.';

  @override
  String get notice_rateLimited_title => 'Fanandramana betsaka loatra';

  @override
  String get notice_deviceLimit_title => 'Efa feno ny isan’ny fitaovana';

  @override
  String get notice_deviceLimit_message =>
      'Esory fitaovana iray alohan’ny hampidirana iray hafa.';

  @override
  String get notice_identityRenewal_title =>
      'Tsy maintsy havaozina ny fanamarinan-tena VPN';

  @override
  String get notice_identityRenewal_message =>
      'Nesorina ity fanamarinan-tena ity. Mamorona fanamarinan-tena vaovao eo an-toerana.';

  @override
  String get notice_migrationPending_title => 'Mandeha ny fiovana toerana';

  @override
  String get notice_migrationPending_message =>
      'Efa misy fiovana toerana mandeha.';

  @override
  String get notice_migrationBlocked_title => 'Voasakana ny fiovana toerana';

  @override
  String get notice_migrationBlocked_message =>
      'Mitaky fitsabahan’ny mpizara ny fiovana toerana. Andramo indray any aoriana na mifandraisa amin’ny fanohanana.';

  @override
  String get notice_targetUnavailable_title =>
      'Tsy azo ampiasaina vonjimaika ny mpizara';

  @override
  String get notice_targetUnavailable_message =>
      'Tsy azo ampiasaina vonjimaika ity mpizara ity.';

  @override
  String get notice_networkUnavailable_title =>
      'Tsy azo ampiasaina ny fifandraisana Internet';

  @override
  String get notice_networkUnavailable_message =>
      'Jereo ny fifandraisana ary andramo indray.';

  @override
  String get notice_permissionDenied_title => 'Nolavina ny alalana VPN';

  @override
  String get notice_permissionDenied_message =>
      'Atombohy indray ny fifandraisana ary ekeno ny fangatahana alalana Android.';

  @override
  String get notice_wireguardTimeout_title => 'Tsy mamaly ny mpizara';

  @override
  String get notice_wireguardTimeout_message =>
      'Naharitra loatra ny fifandraisana WireGuard. Andramo indray na misafidiana toerana hafa.';

  @override
  String get notice_tlsFailed_title => 'Nolavina ny fifandraisana azo antoka';

  @override
  String get notice_tlsFailed_message =>
      'Tsy nanaiky ny fifandraisana OpenVPN ny mpizara. Andramo indray. Raha mitohy ny olana, atombohy ny diagnostika.';

  @override
  String get notice_tunRejected_title => 'Nolavin’ny Android ny interface VPN';

  @override
  String get notice_tunRejected_message =>
      'Nolavin’ny Android ny fanamboarana tambajotra nangatahin’ny OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Tsy afaka nanomboka ny OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'Tsy vita ny fanombohana ny motera OpenVPN. Andramo indray. Raha mitohy ny olana, mifandraisa amin’ny fanohanana.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Kaody diagnostika: $code';
  }

  @override
  String get notice_generic_title => 'Tsy nahomby ny fifandraisana VPN';

  @override
  String get notice_generic_message =>
      'Nisy hadisoana. Andramo indray any aoriana.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Voaforona ny kaonty',
      'password_reset_sent': 'Voaray ny fangatahana hamerina ny teny miafina',
      'verification_email_sent': 'Nalefa ny e-mail fanamarinana',
      'location_migration_pending': 'Mandeha ny fiovana toerana',
      'vpn_sign_in_required': 'Ilaina ny fidirana',
      'protocol_unavailable_at_location': 'Tsy azo ampiasaina ny protokole',
      'vpn_permission_denied': 'Nolavina ny alalana VPN',
      'revoked_identity_device_limit': 'Efa feno ny isan’ny fitaovana',
      'tunnel_start_unexpected': 'Tsy afaka nanomboka ny VPN',
      'flutter_disconnect_timeout': 'Tsy voamarina ny fialana',
      'flutter_disconnect_unexpected': 'Tsy afaka niala',
      'device_revoked': 'Nesorina ny fitaovana',
      'revoke_unexpected': 'Tsy azo esorina ny fitaovana',
      'identity_renewal_unexpected': 'Tsy azo havaozina ny fanamarinan-tena',
      'openvpn_renewal_unexpected': 'Tsy azo havaozina ny OpenVPN',
      'location_migration_blocked': 'Voasakana ny fiovana toerana',
      'location_migration_slow': 'Mbola mandeha ny fiovana toerana',
      'location_migration_conflict': 'Mila havaozina ny fiovana toerana',
      'location_migration_verification_failed':
          'Tsy voamarina ny fiovana toerana',
      'location_migration_device_changed':
          'Niova ny fitaovana nandritra ny fiovana toerana',
      'tunnel_stop_failed': 'Tsy azo atao ny fiovana toerana',
      'device_clock_ahead': 'Mialoha ny famantaranandro ny fitaovana',
      'other': 'Tsy nahomby ny asa',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Voaforona ny kaonty, saingy tsy voalefa ny e-mail fanamarinana. Ampiasao ny fandefasana indray ao amin’ny fampiharana.',
      'password_reset_sent':
          'Voaray ny fangatahanareo. Raha misy kaonty mifandray amin’io adiresy io, mety hahazo e-mail ianareo. Jereo koa ny lahatahiry spam, azafady.',
      'verification_email_sent': 'Vao nalefa ny e-mail fanamarinana vaovao.',
      'location_migration_pending':
          'Mbola omanina ny fifindrana ho any $target. Afaka manohy azy ianareo nefa tsy hamorona indray ny fitaovana.',
      'vpn_sign_in_required':
          'Midira amin’ny kaontinareo alohan’ny hanombohana ny VPN.',
      'protocol_unavailable_at_location':
          'Tsy omen’ity toerana ity ny protokole voafidy. Havaozy ny toerana na misafidiana protokole hafa.',
      'vpn_permission_denied':
          'Nolavin’ny Android ny alalana VPN. Atombohy indray ny fifandraisana ary ekeno ny fangatahana avy amin’ny rafitra.',
      'revoked_identity_device_limit':
          'Nesorina ny fidirana VPN an’ity fitaovana ity ary efa feno ny isan’ny fitaovana. Esory fitaovana iray ao amin’ny Kaonty → Hitantana ny fitaovako.',
      'tunnel_start_unexpected':
          'Nisy hadisoana tsy nampoizina nanapaka ny fanomanana ny tunnel. Jereo ny kaody diagnostika ary andramo indray.',
      'flutter_disconnect_timeout':
          'Tsy nanamarina ny Android fa niato tao anatin’ny fotoana ny VPN. Andramo indray ny fampiatoana azy.',
      'flutter_disconnect_unexpected':
          'Nisy hadisoana tsy nampoizina nanakana ny fanamarinana fa niato ny tunnel.',
      'device_revoked':
          'Nofoanana ny fidirana VPN an’ny fitaovana ary nesorina ny zavatra miafina eo an-toerana.',
      'revoke_unexpected':
          'Tsy azo esorina ny fitaovana. Havaozy ny lisitra ary andramo indray.',
      'identity_renewal_unexpected':
          'Tsy afaka namorona ny fanamarinan-tena VPN vaovao. Havaozy ny fitaovana ary andramo indray.',
      'openvpn_renewal_unexpected':
          'Tsy azo havaozina ny profil OpenVPN. Andramo indray na jereo ny kaody diagnostika.',
      'location_migration_blocked':
          'Tsy afaka mamita ity fiovana ity ny mpizara amin’izao fotoana izao. Voatahiry ny fitaovana sy ny fanamarinan-tena eo an-toerana.',
      'location_migration_slow':
          'Mbola manomana ny fifindrana ho any $target ny mpizara. Tsindrio ny Hanohy afaka fotoana fohy.',
      'location_migration_conflict':
          'Niova ny toetry ny fitaovana tao amin’ny mpizara. Havaozy ny fitaovana, avy eo tohizo ny fiovana.',
      'location_migration_verification_failed':
          'Tsy nanamarina ny toerana vaovao ny mpizara. Voatahiry ny fanamarinan-tena eo an-toerana teo aloha.',
      'location_migration_device_changed':
          'Tsy mifanaraka intsony amin’ilay fitaovana ovaina ny fitaovana naverin’ny mpizara. Havaozy ny fitaovana alohan’ny hanandramana indray.',
      'tunnel_stop_failed':
          'Tsy maintsy ampiatoina tanteraka ny tunnel teo aloha alohan’ny fifandraisana vaovao.',
      'device_clock_ahead':
          'Toa mialoha ny famantaranandro ao amin’ity fitaovana ity. Alefaso ny daty sy ny ora ho azy mba hijanona miditra amin’ny kaonty ianareo.',
      'other':
          'Tsy vita ny asa. Andramo indray na alefaso any amin’ny fanohanana ny kaody diagnostika.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Lany fotoana ny fidirana',
      'invalid_credentials': 'Tsy nahomby ny fidirana',
      'email_verification_required': 'Ilaina ny fanamarinana ny adiresy e-mail',
      'verification_email_cooldown': 'Efa nalefa ny e-mail',
      'rate_limited': 'Fanandramana betsaka loatra',
      'invalid_registration': 'Ilaina ny fanitsiana ny fampahalalana',
      'email_exists': 'Efa misy ny kaonty',
      'invalid_profile': 'Tsy mety ny profil',
      'invalid_device': 'Tsy mety ny fitaovana',
      'invalid_location': 'Tsy azo ampiasaina ny toerana',
      'device_limit': 'Efa feno ny isan’ny fitaovana',
      'device_exists': 'Efa ampiasaina ny fanamarinan-tena VPN',
      'device_identity_revoked':
          'Tsy maintsy havaozina ny fanamarinan-tena VPN',
      'device_location_locked': 'Mila havaozina ny fiovana toerana',
      'location_migration_pending': 'Mandeha ny fiovana toerana',
      'location_migration_blocked': 'Voasakana ny fiovana toerana',
      'target_ca_mismatch': 'Tsy mifanaraka ny mpizara OpenVPN',
      'location_migration_conflict': 'Mila havaozina ny fiovana toerana',
      'server_full': 'Feno ny mpizara',
      'capacity_unavailable': 'Tsy azo ampiasaina vonjimaika ny toerana',
      'target_unavailable': 'Tsy azo ampiasaina vonjimaika ny mpizara',
      'not_found': 'Tsy hita ny singa',
      'invalid_openvpn_csr': 'Tsy mety ny fanamarinan-tena OpenVPN',
      'openvpn_profile_exists': 'Efa misy ny profil OpenVPN',
      'openvpn_profile_revoked': 'Nofoanana ny profil OpenVPN',
      'openvpn_operation_pending': 'Mandeha ny asa OpenVPN',
      'openvpn_operation_terminal': 'Voatapaka ny asa OpenVPN',
      'openvpn_address_unavailable': 'Tsy azo ampiasaina ny adiresy OpenVPN',
      'openvpn_profile_conflict': 'Fifanoherana OpenVPN',
      'openvpn_signer_unavailable': 'Tsy azo ampiasaina ny OpenVPN',
      'email_delivery_unavailable': 'Tsy azo ampiasaina ny e-mail',
      'invalid_token': 'Tsy mety ny rohy',
      'network_unavailable': 'Tsy azo ampiasaina ny fifandraisana Internet',
      'invalid_json': 'Tsy mety ny fangatahana',
      'invalid_api_response': 'Tsy mety ny valin’ny mpizara',
      'ipv6_unavailable': 'Tsy azo ampiasaina ny IPv6',
      'invalid_ip_families': 'Nolavina ny fanamboarana tambajotra',
      'other': 'Tsy azo ampiasaina ny serivisy',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Lany fotoana ny fidirana. Midira indray.',
      'invalid_credentials': 'Diso ny adiresy e-mail na ny teny miafina.',
      'email_verification_required':
          'Hamarino ny adiresy e-mail alohan’ny hampidirana fitaovana VPN.',
      'invalid_registration':
          'Jereo ny fampahalalana angatahina sy ny fanekena.',
      'email_exists': 'Misy kaonty efa mampiasa ity adiresy e-mail ity.',
      'invalid_profile': 'Jereo ny fampahalalana ao amin’ny profil.',
      'invalid_device':
          'Tsy mety ny anaran’ity fitaovana ity na ny fanamarinan-tena eo an-toerana.',
      'invalid_location':
          'Havaozy ny lisitry ny toerana, avy eo andramo indray.',
      'device_limit': 'Esory fitaovana iray alohan’ny hampidirana iray hafa.',
      'device_exists':
          'Efa mifandray amin’ny kaonty hafa ity fanamarinan-tena VPN ity.',
      'device_identity_revoked':
          'Nesorina ity fanamarinan-tena ity. Tsy maintsy mamorona fanamarinan-tena vaovao eo an-toerana.',
      'device_location_locked':
          'Vao niova ny toerana ao amin’ity fitaovana ity. Hanohy ny fiovana efa natomboka ny fampiharana.',
      'location_migration_pending': 'Efa misy fiovana toerana mandeha.',
      'location_migration_blocked':
          'Mitaky fitsabahan’ny mpizara ny fiovana toerana. Andramo indray any aoriana na mifandraisa amin’ny fanohanana.',
      'target_ca_mismatch':
          'Tsy mbola mifanaraka amin’ny profil OpenVPN ankehitriny ity mpizara ity.',
      'location_migration_conflict':
          'Havaozy ny fitaovana, avy eo andramo indray ny fiovana toerana.',
      'server_full':
          'Efa tonga ny fetran’ny fifandraisana ao amin’ity toerana ity. Misafidiana toerana hafa, na andramo indray any aoriana.',
      'capacity_unavailable':
          'Tsy azo hamarinina raha azo ampiasaina amin’izao fotoana izao ity toerana ity. Misafidiana toerana hafa, na andramo indray any aoriana.',
      'target_unavailable': 'Tsy azo ampiasaina vonjimaika ity mpizara ity.',
      'not_found': 'Tsy misy intsony ao amin’ny kaonty io singa io.',
      'invalid_openvpn_csr':
          'Mamorona fanamarinan-tena OpenVPN vaovao, avy eo andramo indray.',
      'openvpn_profile_exists':
          'Efa misy profil OpenVPN ho an’ity fitaovana ity.',
      'openvpn_profile_revoked': 'Havaozy ny profil OpenVPN mba hanohizana.',
      'openvpn_operation_pending':
          'Mbola miely ny fanovana. Andramo indray any aoriana.',
      'openvpn_operation_terminal':
          'Mamorona fanamarinan-tena OpenVPN vaovao, avy eo andramo indray.',
      'openvpn_address_unavailable':
          'Tsy misy adiresy OpenVPN azo ampiasaina amin’izao fotoana izao.',
      'openvpn_profile_conflict':
          'Niova ny profil. Havaozy ny fitaovana, avy eo andramo indray.',
      'openvpn_signer_unavailable':
          'Tsy azo ampiasaina vonjimaika ny serivisy OpenVPN.',
      'email_delivery_unavailable':
          'Tsy voalefa ny e-mail. Andramo indray any aoriana.',
      'invalid_token': 'Tsy mety na lany daty ity rohy ity. Mangataha vaovao.',
      'network_unavailable':
          'Jereo ny fifandraisana Internet, avy eo andramo indray.',
      'invalid_json':
          'Jereo ny fampahalalana nampidirina, avy eo andramo indray.',
      'invalid_api_response':
          'Namaly tsy nampoizina ny mpizara. Andramo indray any aoriana.',
      'ipv6_unavailable':
          'Tsy afaka mampandeha ny IPv6 ny mpizara amin’izao fotoana izao. Andramo indray any aoriana.',
      'invalid_ip_families':
          'Tsy feno na tsy mifanaraka amin’ny adiresy nahazoan-dalana ny fanamboarana ny tunnel. Andramo indray avy ao amin’ny fampiharana.',
      'other': 'Nisy hadisoana tamin’ny mpizara. Andramo indray any aoriana.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Andramo indray afaka fotoana fohy.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Andramo indray afaka $seconds segondra.',
      one: 'Andramo indray afaka $seconds segondra.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Andramo indray afaka $minutes minitra.',
      one: 'Andramo indray afaka $minutes minitra.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Andramo indray afaka $hours ora.',
      one: 'Andramo indray afaka $hours ora.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Tsy azo ampiasaina ny fitohizana VPN avy amin’ny rafitra',
      'system_vpn_resume_corrupt':
          'Tsy mety ny fitohizana VPN avy amin’ny rafitra',
      'system_vpn_resume_session_invalid':
          'Tsy mety ny fidirana ho an’ny fitohizana VPN',
      'system_vpn_resume_identity_changed': 'Niova ny fanamarinan-tena VPN',
      'system_vpn_resume_identity_invalid':
          'Tsy mety ny fanamarinan-tena ho an’ny fitohizana VPN',
      'system_vpn_resume_storage_failed':
          'Tsy azo ampiasaina ny fitehirizana ny fitohizana VPN',
      'system_vpn_resume_network_timeout':
          'Tsy misy tambajotra ho an’ny fitohizana VPN',
      'system_vpn_resume_blocked': 'Voasakana ny fitohizana VPN',
      'system_vpn_resume_failed': 'Tsy nahomby ny fitohizana VPN',
      'system_vpn_resume_error_invalid': 'Tsy mety ny hadisoana fitohizana VPN',
      'wireguard_identity_store_failed':
          'Tsy voatahiry ny fanamarinan-tena WireGuard',
      'wireguard_identity_unavailable':
          'Tsy azo ampiasaina ny fanamarinan-tena WireGuard',
      'vpn_host_destroyed': 'Niato ny mpampiantrano VPN Android',
      'vpn_host_unavailable': 'Tsy azo ampiasaina ny mpampiantrano VPN Android',
      'vpn_permission_required': 'Ilaina ny alalana VPN',
      'vpn_permission_denied': 'Nolavina ny alalana VPN',
      'vpn_permission_request_failed': 'Tsy afaka nangataka alalana',
      'wireguard_foreground_service_unavailable':
          'Tsy azo ampiasaina ny serivisy WireGuard',
      'wireguard_identity_invalid':
          'Tsy mety ny fanalahidy WireGuard eo an-toerana',
      'wireguard_identity_in_use':
          'Efa ampiasaina ny fanamarinan-tena WireGuard',
      'wireguard_configuration_invalid': 'Tsy mety ny fanamboarana WireGuard',
      'wireguard_operation_pending': 'Mbola mandeha ny asa WireGuard',
      'wireguard_start_failed': 'Nolavina ny fanombohana WireGuard',
      'wireguard_stop_timeout': 'Tsy voamarina ny fampiatoana ny WireGuard',
      'wireguard_handshake_timeout': 'Tsy namaly ny WireGuard',
      'openvpn_connection_timeout': 'Tsy namaly ny OpenVPN',
      'openvpn_core_unavailable': 'Tsy azo ampiasaina ny motera OpenVPN',
      'openvpn_operation_pending': 'Mbola mandeha ny fidirana OpenVPN',
      'openvpn_stop_timeout': 'Tsy voamarina ny fampiatoana ny OpenVPN',
      'openvpn_profile_unavailable': 'Tsy hita ny profil OpenVPN eo an-toerana',
      'openvpn_native_failed': 'Voatapaka ny antso anatiny OpenVPN',
      'openvpn_key_generation_failed':
          'Tsy afaka namorona ny fanalahidy OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Tsy afaka namorona ny CSR OpenVPN',
      'openvpn_identity_store_failed':
          'Tsy voatahiry ny fanamarinan-tena OpenVPN',
      'openvpn_identity_clear_failed': 'Tsy feno ny fanesorana ny OpenVPN',
      'openvpn_identity_in_use': 'Mbola ampiasaina ny fanamarinan-tena OpenVPN',
      'openvpn_tls_verification_required':
          'Tsy misy ny fanamarinana TLS OpenVPN',
      'openvpn_cipher_invalid': 'Tsy mety ny sifra OpenVPN',
      'openvpn_profile_rejected': 'Nolavina ny profil OpenVPN',
      'openvpn_identity_inconsistent':
          'Tsy mifanaraka ny fanamarinan-tena OpenVPN',
      'tls_handshake_failed': 'Nolavina ny fifampiraharahana OpenVPN',
      'tls_alert_unknown_ca': 'Tsy fantatra ny sertifikan’ny mpanjifa OpenVPN',
      'tls_alert_bad_certificate': 'Nolavina ny sertifikan’ny mpanjifa OpenVPN',
      'tls_alert_unsupported_certificate': 'Tsy tohanana ny sertifika OpenVPN',
      'tls_client_certificate_required':
          'Ilaina ny sertifikan’ny mpanjifa OpenVPN',
      'tls_alert_misc': 'Fampitandremana TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Tsy tohanana ny sonia OpenVPN',
      'tls_handshake_rejected': 'Nolavina ny fifampiraharahana TLS OpenVPN',
      'tls_version_rejected': 'Tsy mifanaraka ny version TLS OpenVPN',
      'tls_certificate_expired': 'Lany daty ny sertifika TLS',
      'tls_certificate_revoked': 'Nofoanana ny sertifika TLS',
      'transport_failed': 'Tsy azo tratrarina ny mpizara OpenVPN',
      'tun_configuration_rejected': 'Tsy afaka namorona ny interface OpenVPN',
      'tun_setup_failed': 'Tsy nahomby ny fametrahana TUN OpenVPN',
      'tun_interface_create_failed':
          'Tsy nahomby ny famoronana ny interface OpenVPN',
      'tun_interface_disabled': 'Navonoina ny interface OpenVPN',
      'tun_halted': 'Voatapaka ny interface OpenVPN',
      'tun_already_established': 'Efa misokatra ny interface OpenVPN',
      'tun_addresses_missing': 'Tsy hita ny adiresy OpenVPN',
      'tun_routes_missing': 'Tsy hita ny lalana OpenVPN',
      'tun_dns_missing': 'Tsy hita ny DNS OpenVPN',
      'tun_permission_revoked': 'Nofoanana ny alalana VPN',
      'tun_establish_returned_null': 'Nolavin’ny Android ny interface VPN',
      'openvpn_service_start_failed': 'Tsy azo ampiasaina ny serivisy OpenVPN',
      'openvpn_operation_timeout': 'Lany fotoana ny antso OpenVPN',
      'openvpn_start_failed': 'Nolavina ny fanombohana OpenVPN',
      'openvpn_connection_failed': 'Voatapaka ny fifandraisana OpenVPN',
      'openvpn_core_status_error': 'Niafara tamin’ny hadisoana ny OpenVPN Core',
      'openvpn_stopped_before_connected':
          'Niato talohan’ny fifandraisana ny OpenVPN',
      'openvpn_auth_failed': 'Nolavina ny fanamarinana OpenVPN',
      'openvpn_client_setup_failed':
          'Tsy nahomby ny fametrahana ny mpanjifa OpenVPN',
      'openvpn_client_halted': 'Voatapaka ny mpanjifa OpenVPN',
      'openvpn_client_restart': 'Nangatahana ny fanombohana indray OpenVPN',
      'openvpn_inactive_timeout': 'Tsy nisy hetsika ela loatra ny OpenVPN',
      'openvpn_session_expired': 'Lany daty ny fidirana OpenVPN',
      'openvpn_credentials_required': 'Tsy tohanana ny fanamarinana OpenVPN',
      'openvpn_proxy_failed': 'Tsy nahomby ny fitaterana mpanelanelana OpenVPN',
      'openvpn_compression_failed': 'Nolavina ny fanafohezana OpenVPN',
      'openvpn_ntlm_crypto_unavailable':
          'Tsy azo ampiasaina ny fanafenana NTLM OpenVPN',
      'openvpn_feature_unsupported': 'Tsy tohanana ny endri-javatra OpenVPN',
      'network_unavailable': 'Tsy azo ampiasaina ny fifandraisana Internet',
      'network_lost': 'Tsy azo ampiasaina ny tambajotra',
      'certificate_validation_failed': 'Nolavina ny sertifikan’ny mpizara',
      'openvpn_certificate_expired': 'Lany daty ny sertifika OpenVPN',
      'tunnel_active_for_another_account':
          'Mbola mandeha ny tunnel an’ny kaonty hafa',
      'tunnel_already_active': 'Efa mandeha ny tunnel anatiny',
      'tunnel_stop_timeout': 'Tsy voamarina ny fampiatoana ny $protocol',
      'tunnel_disconnected': 'Voatapaka ny $protocol',
      'native_bridge_unavailable': 'Tsy azo ampiasaina ny tetezana Android',
      'native_operation_failed': 'Voatapaka ny asa Android',
      'invalid_arguments': 'Tsy feno ny parametatra VPN',
      'invalid_account_id': 'Tsy mety ny kaonty VPN',
      'invalid_device_id': 'Tsy mety ny famantarana ny fitaovana',
      'storage_key_not_allowed': 'Nolavina ny fanalahidy fitehirizana',
      'secure_storage_read_failed': 'Tsy nahomby ny famakiana azo antoka',
      'secure_storage_write_failed': 'Tsy nahomby ny fanoratana azo antoka',
      'key_generation_failed': 'Tsy afaka namorona fanalahidy WireGuard',
      'csr_generation_failed': 'Tsy afaka namorona CSR OpenVPN',
      'openvpn_recovery_exhausted': 'Efa nampiasaina ny fanarenana OpenVPN',
      'openvpn_recovery_failed': 'Tsy nahomby ny fanarenana OpenVPN',
      'openvpn_renewal_required': 'Ilaina ny fanavaozana ny sertifika OpenVPN',
      'other': 'Hadisoana VPN anatiny tsy voasokajy',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Tsy mahita fidirana VPN azo tohizina ny Android. Atombohy ny fifandraisana vaovao ao amin’ny fampiharana.',
      'system_vpn_resume_corrupt':
          'Tsy mety ny angon-drakitra fitohizana VPN voatahiry ary tsy hampiasaina izany. Atombohy ny fifandraisana vaovao.',
      'system_vpn_resume_session_invalid':
          'Tsy afaka mitohy intsony ny VPN amin’ny alalan’ny fidirana voatahiry. Midira indray ao amin’ny fampiharana.',
      'system_vpn_resume_identity_changed':
          'Niova ny fanamarinan-tena VPN eo an-toerana. Nampiatoina ny fitohizana; atombohy ny fifandraisana vaovao.',
      'system_vpn_resume_identity_invalid':
          'Tsy mety ny fanamarinan-tena hitohizana. Atombohy ny fifandraisana vaovao.',
      'system_vpn_resume_storage_failed':
          'Tsy afaka namaky na nanavao ny angon-drakitra fitohizana voafina ny Android. Atombohy ny fifandraisana vaovao.',
      'system_vpn_resume_network_timeout':
          'Tsy nahita tambajotra tao anatin’ny fotoana ny Android mba hanohizana ny VPN. Andramo indray rehefa misy tambajotra azo ampiasaina.',
      'system_vpn_resume_blocked':
          'Voasakana ny fitohizana VPN. Jereo ny fikirana Android, avy eo atombohy ny fifandraisana vaovao.',
      'system_vpn_resume_failed':
          'Tsy nahomby ny fitohizana VPN nataon’ny Android. Atombohy ny fifandraisana vaovao ao amin’ny fampiharana.',
      'system_vpn_resume_error_invalid':
          'Nandefa hadisoana fitohizana tsy azo ampiasaina ny Android. Atombohy ny fifandraisana vaovao.',
      'wireguard_identity_store_failed':
          'Tsy afaka nitahiry ny fanamarinan-tena WireGuard voafina an’ity kaonty ity ny Android.',
      'wireguard_identity_unavailable':
          'Tsy misy fanamarinan-tena WireGuard azo ampiasaina ho an’ity fifandraisana ity.',
      'vpn_host_destroyed':
          'Niato ny singa Android mampiantrano ny VPN. Atombohy ny fifandraisana vaovao.',
      'vpn_host_unavailable':
          'Tsy afaka namorona ny singa mampiantrano ny VPN ny Android. Andramo indray aorian’ny fijerena ny fikirana VPN.',
      'openvpn_renewal_required':
          'Mila hetsika ao amin’ny fampiharana ny sertifika alohan’ny hifandraisana.',
      'openvpn_recovery_failed':
          'Tsy nahomby ny fanarenana ho azy. Atombohy ny fifandraisana vaovao ao amin’ny fampiharana.',
      'openvpn_recovery_exhausted':
          'Efa nampiasaina ny fanarenana ho azy. Atombohy ny fifandraisana vaovao ao amin’ny fampiharana.',
      'vpn_permission_required':
          'Mila alalana VPN vaovao ny Android alohan’ny hanombohana ny tunnel.',
      'vpn_permission_denied':
          'Avelao ny FuzeVPN ao amin’ny fangatahana Android mba hanohizana.',
      'vpn_permission_request_failed':
          'Tsy afaka nanokatra ny efijery alalana VPN ny Android.',
      'wireguard_foreground_service_unavailable':
          'Tsy afaka nitazona ny serivisy WireGuard ho eo anoloana ny Android.',
      'wireguard_identity_invalid':
          'Tsy azo vakiana na tsy mety ny fanalahidy WireGuard voafina an’ity kaonty ity.',
      'wireguard_identity_in_use':
          'Mbola mampiasa ny fanalahidy WireGuard an’ity kaonty ity ny asa hafa.',
      'wireguard_configuration_invalid':
          'Tsy mety ny adiresy, DNS, fanalahidin’ny mpizara na lalana WireGuard voaray.',
      'wireguard_operation_pending':
          'Tsy mbola nanafaka ny serivisy anatiny ny asa WireGuard teo aloha.',
      'wireguard_start_failed':
          'Nolavin’ny motera WireGuard ny fampandehanana ny fanamboarana.',
      'wireguard_stop_timeout':
          'Tsy nanamarina ny fanafahana ny interface VPN tao anatin’ny fe-potoana voafetra ny serivisy WireGuard.',
      'wireguard_handshake_timeout':
          'Tsy nanamarina fifanakalozana azo antoka tamin’ny mpizara tao anatin’ny fotoana ny tunnel.',
      'openvpn_connection_timeout':
          'Tsy nanamarina ny fifandraisana tamin’ny mpizara tao anatin’ny fotoana ny OpenVPN.',
      'openvpn_core_unavailable':
          'Tsy misy motera OpenVPN azo ampiasaina ao amin’ity version fampiharana ity.',
      'openvpn_operation_pending':
          'Mbola mitana ny fidirana OpenVPN teo aloha ny motera anatiny ary tsy manaiky hamorona faharoa.',
      'openvpn_stop_timeout':
          'Tsy nanamarina ny OpenVPN Core fa niato sy nesorina ny fidirana anatiny tao anatin’ny fe-potoana voafetra.',
      'openvpn_profile_unavailable':
          'Tsy misy profil OpenVPN voamarina azo vakiana ho an’ity fifandraisana ity.',
      'openvpn_native_failed':
          'Nisy hadisoana tao amin’ny fampiharana nanapaka ny OpenVPN. Andramo mifandray indray. Raha mbola misy ny olana, atombohy ny diagnostika.',
      'openvpn_key_generation_failed':
          'Tsy afaka namorona na namaky ny fanalahidy manokana P-256 tsy azo ondrana ny Android Keystore.',
      'openvpn_csr_generation_failed':
          'Tsy afaka nanao sonia ny fangatahana sertifika OpenVPN ny fanalahidin’ny Android Keystore.',
      'openvpn_identity_store_failed':
          'Tsy afaka nitahiry tao amin’ny fitehirizana voafina ny sertifika na ny profil OpenVPN.',
      'openvpn_identity_clear_failed':
          'Tsy afaka nanala tanteraka ny fanamarinan-tena OpenVPN eo an-toerana ho an’ity kaonty ity ny Android.',
      'openvpn_identity_in_use':
          'Mbola mampiasa ny fanalahidy na ny sertifikan’ity fitaovana ity ny fidirana OpenVPN anatiny.',
      'openvpn_tls_verification_required':
          'Tsy mitaky mazava ny fanamarinana ny sertifikan’ny mpizara ny profil.',
      'openvpn_cipher_invalid':
          'Nanome algoritma fanafenana tsy ao amin’ny lisitra nekena ny mpizara.',
      'openvpn_profile_rejected':
          'Tsy mifanaraka ny profil voaray avy amin’ny mpizara. Forony indray ity fitaovana ity, avy eo andramo indray.',
      'openvpn_identity_inconsistent':
          'Tsy mifanaraka amin’ny fanamarinan-tena voaaro an’ity telefaona ity ny sertifika. Tsy nisy profil eo an-toerana nosoloina.',
      'tls_handshake_failed':
          'Nolavin’ny mpizara ny fifampiraharahana TLS. Forony indray ny profil raha mbola misy ny olana.',
      'tls_alert_unknown_ca':
          'Tsy fantatry ny mpizara ny manam-pahefana nanome ny sertifikan’ity fitaovana ity. Tokony hojerena ny mpizara OpenVPN.',
      'tls_alert_bad_certificate':
          'Nolavin’ny mpizara ny sertifikan’ity fitaovana ity. Forony indray ny fitaovana alohan’ny hanandramana indray.',
      'tls_alert_unsupported_certificate':
          'Tsy manohana ny karazana sertifika voaaro ampiasain’ny Android ny mpizara.',
      'tls_client_certificate_required':
          'Mitaky sertifikan’ny mpanjifa ny mpizara, nefa tsy afaka nanolotra iray ny OpenVPN Core.',
      'tls_alert_misc':
          'Nandefa fampitandremana TLS ivelan’ny sokajy sertifika sy version ny mpizara.',
      'tls_signature_algorithm_rejected':
          'Nolavin’ny mpizara ny algoritma ECDSA P-256 an’ny fanalahidin’ny Android Keystore.',
      'tls_handshake_rejected':
          'Nampiato ny fifampiraharahana TLS talohan’ny fifandraisana ny mpizara.',
      'tls_version_rejected':
          'Tsy nahita version TLS iraisana ny mpanjifa sy ny mpizara.',
      'tls_certificate_expired':
          'Efa lany daty ny sertifika nasehoina nandritra ny fifandraisana.',
      'tls_certificate_revoked':
          'Nofoanana ny sertifika nasehoina nandritra ny fifandraisana.',
      'transport_failed':
          'Tsy mamaly amin’ity tambajotra ankehitriny ity ny mpizara OpenVPN. Andramo indray afaka fotoana fohy.',
      'tun_configuration_rejected':
          'Nolavin’ny Android ny fanamboarana tambajotra nangatahin’ny OpenVPN.',
      'tun_setup_failed':
          'Nolavin’ny OpenVPN Core ny drafitra tambajotra talohan’ny famoronana ny interface Android.',
      'tun_interface_create_failed':
          'Tsy afaka nahazo ny interface TUN avy amin’ny VpnService Android ny OpenVPN Core.',
      'tun_interface_disabled':
          'Navonoin’ny Android na ny OpenVPN Core ny interface TUN nandritra ny fifandraisana.',
      'tun_halted':
          'Nahazo fangatahana hampiato ny interface TUN ny OpenVPN Core.',
      'tun_already_established':
          'Nangataka interface faharoa tao amin’ny fifandraisana iray ihany ny OpenVPN. Nampiatoina ny tunnel mba hiarovana.',
      'tun_addresses_missing':
          'Tsy nanome adiresy tunnel azo ampiasaina ny mpizara.',
      'tun_routes_missing':
          'Tsy nanome lalana tunnel azo ampiasaina ny mpizara.',
      'tun_dns_missing': 'Tsy nanome mpizara DNS azo ampiasaina ny mpizara.',
      'tun_permission_revoked':
          'Nofoanan’ny Android ny alalana VPN nandritra ny fifandraisana.',
      'tun_establish_returned_null':
          'Tsy namorona ny interface ny Android, matetika satria mbola mandeha ny VPN hafa.',
      'openvpn_service_start_failed':
          'Tsy afaka nanomboka ny serivisy OpenVPN eo anoloana ny Android.',
      'openvpn_operation_timeout':
          'Nihoatra ny faharetany ambony indrindra ny antso JNI mankany amin’ny OpenVPN Core.',
      'openvpn_start_failed':
          'Vonona ny serivisy Android, fa tsy nanaiky ny hanomboka ny profil ny OpenVPN Core.',
      'openvpn_connection_failed':
          'Niato ny OpenVPN Core talohan’ny nandefasany ny hetsika CONNECTED.',
      'openvpn_core_status_error':
          'Niafara tamin’ny hadisoana ny faribolan’ny OpenVPN anatiny, tsy nisy hetsika farany mazava kokoa.',
      'openvpn_stopped_before_connected':
          'Niato ny faribolan’ny OpenVPN anatiny talohan’ny CONNECTED, tsy nisy hadisoana Core mazava.',
      'openvpn_auth_failed':
          'Nolavin’ny mpizara OpenVPN ny fanamarinana ny profil.',
      'openvpn_client_setup_failed':
          'Tsy afaka nanomboka ny mpanjifa ny OpenVPN Core talohan’ny fifandraisana tambajotra.',
      'openvpn_client_halted':
          'Nahazo fampiatoana farany ny mpanjifa ny OpenVPN Core.',
      'openvpn_client_restart':
          'Nangataka fanombohana indray ny fidirana fitaterana ny OpenVPN Core.',
      'openvpn_inactive_timeout':
          'Nakatonan’ny OpenVPN Core ny fidirana taorian’ny fe-potoana tsy nisy hetsika.',
      'openvpn_session_expired':
          'Nilaza ny mpizara fa lany daty ny fidirana OpenVPN.',
      'openvpn_credentials_required':
          'Mangataka famantarana fidirana mifanerasera ny mpizara na ny proxy, izay tsy ao amin’ity profil sertifika ity.',
      'openvpn_proxy_failed':
          'Nilaza ny OpenVPN Core fa tsy nahomby ny proxy na mpampita voalamina.',
      'openvpn_compression_failed':
          'Nolavin’ny OpenVPN Core ny fomba fanafohezana nambara avy amin’ny profil na ny mpizara.',
      'openvpn_ntlm_crypto_unavailable':
          'Mangataka fanafenana NTLM ny profil, izay tsy misy ao amin’ity version ity.',
      'openvpn_feature_unsupported':
          'Mila endri-javatra tsy misy ao amin’ity mpanjifa Android ity ny profil na ny mpizara.',
      'network_unavailable': 'Tsy misy tambajotra ara-batana azo ampiasaina.',
      'network_lost':
          'Nampiatoina ny tunnel taorian’ny fahaverezan’ny tambajotra.',
      'certificate_validation_failed':
          'Tsy voamarina ny fanamarinan-tena an’ny mpizara OpenVPN.',
      'openvpn_certificate_expired':
          'Havaozy ny profil OpenVPN alohan’ny hifandrayana indray.',
      'tunnel_active_for_another_account':
          'Tsy maintsy ampiatoina ny tunnel an’ny kaonty hafa alohan’ity fifandraisana ity.',
      'tunnel_already_active':
          'Milaza ny Android fa mbola mampiasa ny interface ny fidirana VPN teo aloha.',
      'tunnel_stop_timeout':
          'Tsy nanamarina ny fanafahana ny interface VPN tao anatin’ny fe-potoana voafetra ny motera $protocol.',
      'tunnel_disconnected':
          'Nilaza ny motera anatiny fa niafara tampoka ny tunnel taorian’ny fanombohana.',
      'native_bridge_unavailable':
          'Tsy afaka miditra amin’ny serivisy VPN Android ny fampiharana. Akatony ary sokafy indray ny fampiharana, avy eo andramo indray.',
      'native_operation_failed':
          'Nisy hadisoana tao amin’ny fampiharana nanapaka ny asa VPN. Andramo indray. Raha mbola misy ny olana, atombohy ny diagnostika.',
      'invalid_arguments':
          'Tsy feno ny fampahalalana ilaina amin’ity asa VPN ity. Andramo indray. Raha mbola misy ny olana, atombohy ny diagnostika.',
      'invalid_account_id':
          'Tsy mifandray amin’ny famantarana kaonty mety ny asa anatiny.',
      'invalid_device_id':
          'Tsy misy na tsy mety ny famantarana fitaovana nalefa tamin’ny motera anatiny.',
      'storage_key_not_allowed':
          'Nisakana fanalahidy ivelan’ny lisitra fitehirizana nekena ny tetezana Android.',
      'secure_storage_read_failed':
          'Tsy afaka nanala ny fanafenana ny angon-drakitra eo an-toerana an’ity kaonty ity ny Android Keystore.',
      'secure_storage_write_failed':
          'Tsy afaka nanafina na nitahiry ny angon-drakitra eo an-toerana ny Android Keystore.',
      'key_generation_failed':
          'Tsy afaka namorona na namaky ny fanalahidy WireGuard tao amin’ny fitehirizana voaaro ny Android.',
      'csr_generation_failed':
          'Tsy afaka namorona na nanao sonia ny CSR P-256 OpenVPN ny Android Keystore.',
      'other':
          'Tsy nahomby ny sampana anatiny tsy voarakitra. Alefaso any amin’ny fanohanana ny kaody diagnostika aseho eto ambany.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Efa misokatra ny fangatahana alalana';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Efa aseho ny fangatahana alalana VPN Android. Vitao aloha izany alohan’ny handramana indray.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Voatapaka ny fangatahana alalana VPN';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Nakatona ny efijery alalana VPN talohan’ny nahazoan’ny fampiharana valiny.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Tsy voamarina ny fifandraisana OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'Tsy voamarina ny fifandraisana OpenVPN. Nampiatoina izy mba hiarovana. Andramo indray.';

  @override
  String get openvpnCleanup_title => 'Nofoanana ny profil OpenVPN';

  @override
  String get openvpnCleanup_working =>
      'Mampiato sy manala ny profil OpenVPN nofoanana…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Tsy voamarina ny fampiatoana ny OpenVPN. Andramo indray alohan’ny hamoronana profil vaovao.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Tsy azo esorina tanteraka ny profil OpenVPN nofoanana. Andramo indray ny fanadiovana.';

  @override
  String get openvpnCleanup_complete =>
      'Nesorina ny profil OpenVPN nofoanana. Tsindrio ny Hifandray mba hamorona vaovao.';

  @override
  String get network_title => 'Fanamboarana tambajotra';

  @override
  String get network_ipv4Fallback =>
      'Tsy azo ampiasaina vonjimaika ny IPv6. Mitohy amin’ny IPv4 ny fanomanana.';

  @override
  String get network_rejectedTitle => 'Nolavina ny fanamboarana tambajotra';

  @override
  String get network_rejectedMessage =>
      'Tsy feno na tsy mifanaraka amin’ny adiresy nahazoan-dalana ny fanamboarana ny tunnel. Andramo indray avy ao amin’ny fampiharana.';

  @override
  String get network_unreadableTitle =>
      'Tsy azo vakiana ny fanamboarana eo an-toerana';

  @override
  String get network_unreadableMessage =>
      'Tsy azo ampiasaina ny fanamboarana tambajotra OpenVPN voatahiry. Mifandraisa indray avy ao amin’ny fampiharana mba hanavaozana azy.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Fiarovana ny tambajotra';

  @override
  String get protection_subtitle =>
      'Sakano ny fidirana mivantana amin’ny Internet raha tapaka ny fifandraisana VPN.';

  @override
  String get protection_active => 'Mavitrika ny fiarovana ny rafitra';

  @override
  String get protection_alwaysOnOnly =>
      'Nampandehana ny VPN mavitrika mandrakariva; alefaso ny fanakanana ivelan’ny VPN';

  @override
  String get protection_inactive => 'Tsy mavitrika ny fiarovana ny rafitra';

  @override
  String get protection_unknown => 'Jereo ny fiarovana ny rafitra';

  @override
  String get protection_openSettings => 'Sokafy ny fikirana Android';

  @override
  String get protection_dialogTitle => 'Amboary ny fiarovana ny tambajotra';

  @override
  String get protection_dialogMessage =>
      'Ny Android no mitantana ny VPN mavitrika mandrakariva sy ny fanakanana ny fifandraisana ivelan’ny VPN. Jereo raha voafidy ny FuzeVPN ary alefaso ny fanakanana ao amin’ny fikirana rafitra.';

  @override
  String get protection_dialogOpen => 'Sokafy ny fikirana';

  @override
  String get session_systemProtectionNote =>
      'Raha mbola manakana ny trafika ivelan’ny VPN ny Android, sokafy ny fikirana rafitra mba hijerena na hanovana ity fiarovana ity.';

  @override
  String get diagnostics_title => 'Diagnostika';

  @override
  String get diagnostics_settingsTitle => 'Diagnostikan’ny fampiharana';

  @override
  String get diagnostics_automaticTitle => 'Alefaso ny hadisoana lehibe';

  @override
  String get diagnostics_automaticDescription =>
      'Zarao tatitra ara-teknika kely rehefa misy hadisoana lehibe.';

  @override
  String get diagnostics_privacy =>
      'Mifandray amin’ny kaonty miditra ny tatitra alefa ary tazonina mandritra ny 30 andro. Tsy misy tantaran’ny fitetezana, teny miafina na fanalahidy VPN ao aminy.';

  @override
  String get diagnostics_manualOpen => 'Hanao diagnostika';

  @override
  String get diagnostics_localDescription =>
      'Mamorona tatitra momba ny toetry ny fampiharana sy ny VPN. Tsy hiova ny fifandraisanareo.';

  @override
  String get diagnostics_sendReport => 'Alefaso ny tatitra';

  @override
  String get diagnostics_sendHint =>
      'Avelao tsy misy marika ity boaty ity mba hijanonan’ny tatitra eto amin’ity fitaovana ity.';

  @override
  String get diagnostics_signedOut =>
      'Midira amin’ny kaontinareo mba handefasana tatitra.';

  @override
  String get diagnostics_localLifetime =>
      'Tahirizo ity tatitra ity amin’ny telefaona mba hitazonana azy aorian’ny fanakatonana ny fampiharana.';

  @override
  String get diagnostics_run => 'Hanao diagnostika';

  @override
  String get diagnostics_rerun => 'Hanao diagnostika indray';

  @override
  String get diagnostics_running => 'Manamarina…';

  @override
  String get diagnostics_sending => 'Mandefa ny tatitra…';

  @override
  String get diagnostics_prepared =>
      'Vonona ny tatitra eto amin’ity fitaovana ity';

  @override
  String get diagnostics_queued => 'Miandry handefasana ny tatitra';

  @override
  String get diagnostics_sent => 'Voaray ny tatitra';

  @override
  String get diagnostics_failed =>
      'Tsy nahomby ny fandefasana. Mbola misy ny tatitra eo an-toerana.';

  @override
  String get diagnostics_preparationFailed =>
      'Tsy azo omanina ny tatitra diagnostika. Andramo indray.';

  @override
  String get diagnostics_authenticationRequired =>
      'Midira indray mba handefasana ny tatitra.';

  @override
  String get diagnostics_retry => 'Andramo indray ny fandefasana';

  @override
  String get diagnostics_export => 'Tahirizo ny tatitra';

  @override
  String get diagnostics_exportFailed =>
      'Tsy nahomby ny fanondranana. Andramo indray avy amin’ny tatitra eo an-toerana.';

  @override
  String get diagnostics_preferenceFailed =>
      'Tsy voatahiry ity fikirana ity. Andramo indray.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Laharana: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Voaray tamin’ny $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Voatahiry hatramin’ny $date';
  }

  @override
  String get diagnostics_duplicate => 'Efa voaray io tatitra io.';

  @override
  String get diagnostics_preview => 'Topimaso ny tatitra';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zava-nitranga ara-teknika ampiarahina',
      one: '1 zava-nitranga ara-teknika ampiarahina',
      zero: 'Tsy misy zava-nitranga ara-teknika ampiarahina',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Antsipiriany ara-teknika';

  @override
  String get diagnostics_empty =>
      'Tsy mbola misy tatitra diagnostika nomanina.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Toetry ny tunnel',
      'handshake': 'Fanamarinana ny fifandraisana',
      'certificate': 'Sertifikan’ny VPN',
      'kill_switch': 'Fiarovan’ny Android',
      'connectivity': 'Tambajotra azo ampiasaina',
      'api_reachability': 'Fidirana amin’ny serivisy',
      'secure_storage': 'Fitehirizana azo antoka',
      'other': 'Fanamarinana eo an-toerana',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Voamarina',
      'failed': 'Mila jerena',
      'skipped': 'Tsy notsapaina — tsy misy fitsapana mavitrika',
      'unknown': 'Tsy misy ny fampahalalana',
      'other': 'Tsy misy ny fampahalalana',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Tongasoa amin’ny FuzeVPN';

  @override
  String get connection_changeLocation => 'Hiova toerana';

  @override
  String get connection_details => 'Antsipirian’ny fifandraisana';

  @override
  String get locations_searchLabel => 'Hitady tanàna na firenena';

  @override
  String get locations_clearSearch => 'Fafao ny fikarohana';

  @override
  String get locations_filterAll => 'Rehetra';

  @override
  String get locations_filterFavorites => 'Ankafiziana';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count toerana',
      one: '$count toerana',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Tsy misy toerana hita';

  @override
  String get locations_noResultsHint => 'Andramo tanàna na firenena hafa.';

  @override
  String get locations_noFavorites => 'Ny ankafizinareo, eo akaikinareo';

  @override
  String get locations_noFavoritesHint =>
      'Tsindrio ny kintana eo akaikin’ny toerana iray mba hotahirizina eto.';

  @override
  String get locations_showAll => 'Jereo ny toerana rehetra';

  @override
  String locations_addFavorite(String name) {
    return 'Ampio ny $name amin’ny ankafiziana';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Esory ny $name amin’ny ankafiziana';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Tsy voatahiry ny ankafiziana. Andramo indray.';

  @override
  String get locations_emptyTitle => 'Tsy misy toerana azo ampiasaina';

  @override
  String get locations_emptyHint => 'Havaozy ny lisitra mba handramana indray.';

  @override
  String get devices_manage => 'Hitantana ny fitaovako';

  @override
  String get settings_personalization => 'Ataovy ho anareo';

  @override
  String get settings_safety => 'Fiarovana';

  @override
  String get settings_help => 'Mila fanampiana?';

  @override
  String get settings_about => 'Momba ny FuzeVPN';

  @override
  String get diagnostics_heading => 'Fahatakarana olana amin’ny fifandraisana';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Azo ampiasaina',
      'pending': 'Omanina',
      'revoked': 'Nesorina',
      'expired': 'Lany daty',
      'other': 'Tsy hita ny toetra',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Tsy voatahiry ny safidy';

  @override
  String get notice_preferenceSave_message =>
      'Ampiharina amin’izao fotoana izao ny safidinareo, saingy tsy voatahiry. Andramo indray mba hitazonana azy aorian’ny fanakatonana ny fampiharana.';

  @override
  String get connection_androidDisconnectHint =>
      'Raha mbola mitazona ny VPN mavitrika ny Android, vonoy ny “VPN mavitrika mandrakariva” ao amin’ny fikirana izay misokatra.';

  @override
  String get protection_learnMore => 'Fantaro ny momba ny fiarovana Android';

  @override
  String get protection_guideWhy =>
      'Ity fiarovana ity dia manakana ny fampiharana tsy hampiasa ny Internet mivantana raha tapaka ny VPN. Ao amin’ny Android no amboarina izany.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN mavitrika mandrakariva';

  @override
  String get protection_guideAlwaysOn =>
      'Mitazona ny serivisy VPN ho mandeha ny Android ary afaka manomboka azy indray rehefa alefa indray ny telefaona.';

  @override
  String get protection_guideBlockTitle =>
      'Sakano ny fifandraisana tsy misy VPN';

  @override
  String get protection_guideBlock =>
      'Ity fikirana ity dia manakana ny trafika tsy handalo ivelan’ny VPN, ao anatin’izany rehefa voatapaka ny fifandraisana.';

  @override
  String get protection_guideWarning =>
      'Rehefa mavitrika ity fanakanana ity, tsy hisy fidirana amin’ny Internet mandra-pifandray ny VPN.';

  @override
  String get protection_guideStepsTitle => 'Alefaso ny fiarovana';

  @override
  String get protection_guideStep1 =>
      'Sokafy ny fikirana VPN Android amin’ny bokotra eto ambany.';

  @override
  String get protection_guideStep2 =>
      'Sokafy ny safidy amin’ny sary kodiarana eo akaikin’ny FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Alefaso ny “VPN mavitrika mandrakariva”, avy eo ny “Sakano ny fifandraisana tsy misy VPN”, raha misy ireo safidy ireo.';

  @override
  String get protection_guideManufacturers =>
      'Samy hafa ny anarana arakaraka ny telefaona. Raha ilaina, tadiavo ny “VPN” ao amin’ny Fikirana, matetika ao ambanin’ny Tambajotra sy Internet.';

  @override
  String get protection_guideDisableTitle => 'Vonoy ity fiarovana ity';

  @override
  String get protection_guideDisable =>
      'Ao amin’ireo fikirana ireo ihany, vonoy ny fanakanana ny fifandraisana tsy misy VPN mba hamela ny fidirana amin’ny Internet tsy misy VPN. Vonoy koa ny VPN mavitrika mandrakariva raha tsy irinareo intsony ny hanombohan’ny Android azy indray.';

  @override
  String get protection_guideManual =>
      'Ianareo no misafidy ireo fikirana ireo ao amin’ny Android. Tsy manova azy ho anareo ny FuzeVPN.';

  @override
  String get locations_changeTitle => 'Hiova toerana ve?';

  @override
  String locations_changeActive(String name) {
    return 'Hiala ny VPN, avy eo hanandrana hifandray amin’ny $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'Hanandrana hifandray amin’ny $name ny VPN.';
  }

  @override
  String get locations_confirmChange => 'Hiova ary hifandray';

  @override
  String get locations_changeBusy =>
      'Mbola mandeha ny fiovana. Miandrasa alohan’ny hisafidianana toerana hafa.';

  @override
  String get locations_automaticSelection => 'Fisafidianana ho azy';

  @override
  String get locations_cities => 'Tanàna';

  @override
  String get locations_servers => 'Mpizara';

  @override
  String locations_viewCities(String name) {
    return 'Jereo ny tanàna ao amin’ny $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Jereo ny mpizara ao amin’ny $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count firenena',
      one: '$count firenena',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tanàna',
      one: '$count tanàna',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mpizara',
      one: '$count mpizara',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Firenena rehetra';

  @override
  String get locations_backToCountries => 'Hiverina any amin’ny firenena';

  @override
  String locations_backToCities(String name) {
    return 'Hiverina any amin’ny tanàna ao amin’ny $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Safidio $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Safidio $name';
  }

  @override
  String get locations_noCompatibleServer => 'Tsy misy mpizara mifanaraka.';

  @override
  String get externalLink_failed =>
      'Tsy afaka misokatra ity rohy ity. Afaka kopiana ary sokafana amin’ny mpitety tranonkala ianareo.';

  @override
  String get externalLink_copy => 'Kopio ny rohy';

  @override
  String get externalLink_copied => 'Voakopia ny rohy';

  @override
  String get externalLink_copyFailed =>
      'Tsy afaka mikopia ny rohy. Safidio ny adiresy eto ambany.';

  @override
  String get settings_deleteAccount => 'Hamafa ny kaontiko';

  @override
  String get settings_deleteAccountDetail =>
      'Jereo ny fomba fangatahana famafana ny kaonty';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Safidio ny famandrihana VPN.';

  @override
  String get billing_subscribe => 'Hamandrika';

  @override
  String get billing_choosePlan => 'Safidio drafitra iray mba hanohizana.';

  @override
  String get billing_monthly => 'Isam-bolana';

  @override
  String get billing_yearly => 'Isan-taona';

  @override
  String get billing_continue => 'Hanohy amin’ny Google Play';

  @override
  String get billing_restore => 'Hamerina ny fividianana';

  @override
  String get billing_manage => 'Hitantana ny famandrihana';

  @override
  String get billing_deleteAccountWarning =>
      'Raha manana famandrihana Google Play ianareo, tsy manafoana ny fanavaozana azy ny famafana ny kaonty FuzeVPN. Tantano na foano misaraka ao amin’ny Google Play ny fanavaozana.';

  @override
  String get billing_deleteAccountContinue =>
      'Hanohy amin’ny fangatahana famafana kaonty';

  @override
  String get billing_refresh => 'Havaozy ny fidirana';

  @override
  String get billing_loadingPlans => 'Mampidina ny drafitra…';

  @override
  String get billing_unavailable =>
      'Tsy misy drafitra azo ampiasaina amin’izao fotoana izao. Andramo indray any aoriana.';

  @override
  String get billing_comingSoon => 'Ho avy tsy ho ela ny famandrihana.';

  @override
  String get billing_priceDisclosure =>
      'Vidiny omen’ny Google Play ity. Hamarinina alohan’ny hanamarinanareo ny vola farany sy ny hetra mihatra.';

  @override
  String get billing_renewalMonthly =>
      'Havaozina ho azy isam-bolana raha tsy nofoanana. Afaka manafoana amin’ny fotoana rehetra ianareo ao amin’ny famandrihana Google Play.';

  @override
  String get billing_renewalYearly =>
      'Havaozina ho azy isan-taona raha tsy nofoanana. Afaka manafoana amin’ny fotoana rehetra ianareo ao amin’ny famandrihana Google Play.';

  @override
  String get billing_active => 'Mavitrika ny fidirana Premium';

  @override
  String billing_accessUntil(String date) {
    return 'Fidirana hatramin’ny $date.';
  }

  @override
  String get billing_webManaged =>
      'Ao amin’ny tranonkalan’ny FuzeVPN no itantanana ny famandrihana.';

  @override
  String get billing_playManaged =>
      'Ny Google Play no mitantana ny famandrihana.';

  @override
  String get billing_playOnHold =>
      'Mijanona vonjimaika na miandry fandoavana ny famandrihana Google Play. Sokafy ny “Hitantana ny famandrihana” mba hanamboarana azy ao amin’ny Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Efa misy famandrihana Fuze Premium ao amin’ity kaonty Google Play ity, nefa tsy mavitrika ho an’ity kaonty FuzeVPN ity. Sokafy ny “Hitantana ny famandrihana” mba hijerena azy ao amin’ny Google Play.';

  @override
  String get billing_inactive => 'Tsy misy famandrihana mavitrika.';

  @override
  String get billing_checkingAccess => 'Manamarina ny fidirana…';

  @override
  String get billing_restoring => 'Mamerina ny fividianana…';

  @override
  String get billing_pending =>
      'Miandry ny fandoavana. Ho mavitrika ny fidirana rehefa voamarina.';

  @override
  String get billing_cancelled =>
      'Nofoanana ny fividianana. Tsy nisy famandrihana vaovao natao mavitrika.';

  @override
  String get billing_verifying => 'Manamarina ny fividianana…';

  @override
  String get billing_success =>
      'Mavitrika ny famandrihana. Vonona ny fidirana Premium.';

  @override
  String get billing_restored => 'Voaverina ny fividianana.';

  @override
  String get billing_restoreEmpty =>
      'Tsy misy fividianana azo averina ho an’ity kaonty Google Play ity.';

  @override
  String get billing_catalogError =>
      'Tsy afaka nampidina ny drafitra. Andramo indray.';

  @override
  String get billing_purchaseError =>
      'Tsy afaka nanomboka ny fividianana. Andramo indray.';

  @override
  String get billing_verificationError =>
      'Tsy azo ampiasaina vonjimaika ny fanamarinana ny fividianana. Tsindrio ny “Hamerina ny fividianana” mba hanandrana indray.';

  @override
  String get billing_restoreError =>
      'Tsy afaka namerina ny fividianana. Andramo indray.';

  @override
  String get billing_managementError =>
      'Tsy afaka nanokatra ny fitantanana famandrihana. Andramo indray.';

  @override
  String get billing_storeUnavailable =>
      'Tsy azo ampiasaina amin’ity fitaovana ity ny Google Play.';

  @override
  String get welcome_title => 'Ny VPN-nareo, natao ho tsotra.';

  @override
  String get welcome_description =>
      'Arovy ny fifandraisanareo. Fehezo ny tsiambaratelonareo.';

  @override
  String get welcome_start => 'Hanomboka';

  @override
  String get welcome_alreadyPurchased => 'Efa nividy ve ianareo?';

  @override
  String get welcome_noAccountRequired =>
      'Tsy ilaina ny kaonty mba hanombohana.';

  @override
  String get guest_accountTitle => 'Kaonty tsy mifandray';

  @override
  String get guest_accountDescription =>
      'Avereno ny fividianana amin’ny kaonty Google Play mitovy mba hampiasana ny famandrihana amin’ny fitaovana hafa.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Efa manana famandrihana ve ianareo? Hiditra';

  @override
  String get guest_claimTitle => 'Entano miaraka aminareo ny FuzeVPN';

  @override
  String get guest_claimDescription =>
      'Mamorona kaonty mba hahafahanareo mampiasa ny famandrihana amin’ny fitaovana hafa. Tsy voatery ity dingana ity.';

  @override
  String get guest_skip => 'Angamba any aoriana';

  @override
  String get guest_activationTitle => 'Mavitrika ny Fuze Premium';

  @override
  String get guest_activationDescription =>
      'Vonona ny famandrihana. Ampiasao ny VPN ary mamorona kaonty rehefa tianareo.';

  @override
  String get guest_useVpn => 'Hampiasa ny VPN-ko';

  @override
  String get guest_loginRequired =>
      'Efa mifandray amin’ny kaonty FuzeVPN iray ity fividianana ity. Midira amin’io kaonty io mba hahazoana miditra amin’ny famandrihana.';

  @override
  String get guest_signOutWarning =>
      'Afaka mahazo indray ny famandrihana ianareo amin’ny alalan’ny famerenana ny fividianana amin’ny kaonty Google Play mitovy.';

  @override
  String get guest_profileUnavailable =>
      'Efa mifandray ny kaonty. Midira mba hijerena sy hitantana ny fampahalalanareo.';

  @override
  String get billing_acceptance =>
      'Raha manohy ianareo, dia manaiky ny Fepetra fampiasana sy ny Politikan’ny tsiambaratelo.';

  @override
  String get guest_verifyEmailReminder =>
      'Hamarino ny adiresy e-mail mba hiarovana ny kaonty. Afaka mitohy mampiasa ny VPN ianareo.';

  @override
  String get guest_serviceUnavailable =>
      'Tsy azo ampiasaina vonjimaika ny serivisy. Andramo indray afaka fotoana fohy.';

  @override
  String get guest_restoreError =>
      'Tsy voaverina ny fividianana. Andramo indray amin’ny kaonty Google Play nampiasaina tamin’ny fividianana.';

  @override
  String get guest_claimSuccess =>
      'Voaforona ny kaonty. Voatahiry ny famandrihana sy ny fidirana VPN.';

  @override
  String get guest_emailExists =>
      'Efa ampiasaina ity adiresy e-mail ity. Misafidiana adiresy hafa na midira amin’ny kaonty efa misy. Mbola azo amin’ny alalan’ny Google Play ny fividianana.';

  @override
  String get guest_claimError =>
      'Tsy voaforona ny kaonty. Afaka mitohy mampiasa ny VPN ianareo ary manandrana indray any aoriana.';

  @override
  String get guest_secureStorageError =>
      'Tsy azo arovana ny fidirana ao amin’ity fitaovana ity. Andramo indray.';

  @override
  String get guest_premiumRequired =>
      'Safidio famandrihana iray mba hampandehanana ny VPN.';

  @override
  String get welcome_viewPlans => 'Jereo ny drafitra';

  @override
  String get google_continue => 'Hanohy amin’ny Google';

  @override
  String get google_or => 'na';

  @override
  String get google_title => 'Ny kaontinareo FuzeVPN';

  @override
  String get google_settingUp => 'Vitao ny famoronana kaonty';

  @override
  String get google_country => 'Firenena onenana';

  @override
  String get google_profileDescription =>
      'Safidio ny firenenareo ary jereo ireo antontan-taratasy roa mba hamoronana ny kaonty FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Ampifandraiso amin’ny Google ny kaonty vahiny. Hijanona mifandray amin’ity kaonty ity ny famandrihana sy ny fitaovana.';

  @override
  String get google_linkTitle => 'Ampifandraiso ny Google amin’ny FuzeVPN';

  @override
  String get google_linkDescription =>
      'Hamarino ny fidirana amin’ny kaonty FuzeVPN efa misy. Tsy mangataka ny teny miafina Google ity dingana ity.';

  @override
  String get google_password => 'Teny miafina FuzeVPN';

  @override
  String get google_linkAccount => 'Hamarino ny fampifandraisana';

  @override
  String get google_requestEmail => 'Alefaso ho ahy ny e-mail fanamarinana';

  @override
  String get google_emailInstructions =>
      'Sokafy ny e-mail avy amin’ny FuzeVPN ary ampidiro ny kaody fanamarinana.';

  @override
  String get google_emailCode => 'Kaody fanamarinana ao amin’ny e-mail';

  @override
  String get google_confirmEmail => 'Hamarino ny kaody';

  @override
  String get google_restart => 'Misafidiana kaonty Google hafa';

  @override
  String get google_resume => 'Jereo ity fanandramana ity';

  @override
  String get google_unavailable =>
      'Tsy azo ampiasaina ny fidirana amin’ny Google. Afaka mampiasa e-mail sy teny miafina ianareo.';

  @override
  String get google_expired =>
      'Efa lany fotoana ity fanandramana ity. Foano izany, avy eo atombohy indray.';

  @override
  String get google_conflict =>
      'Efa mifandray any an-kafa ity kaonty Google ity. Voatahiry ny kaonty sy ny famandrihana ankehitriny.';

  @override
  String get google_error =>
      'Tsy nahomby ny fidirana amin’ny Google. Andramo indray; voatahiry ny fidirana ankehitriny.';

  @override
  String get google_uncertain =>
      'Tsy voamarina ny vokatra. Jereo ity fanandramana ity na foano alohan’ny hanombohana indray.';

  @override
  String get google_cancelFailed =>
      'Tsy voamarina ny fanafoana. Foano indray alohan’ny hialana amin’ity efijery ity.';

  @override
  String get google_cancelled => 'Nofoanana ny fidirana amin’ny Google.';

  @override
  String get google_selecting => 'Safidio ny kaonty Google…';

  @override
  String get google_verifying => 'Manamarina ny kaonty…';

  @override
  String get google_emailUnavailable =>
      'Tsy voalefa ny e-mail fanamarinana. Andramo indray any aoriana.';

  @override
  String get google_emailSent =>
      'Voalefa ny e-mail fanamarinana. Jereo ny boaty fandraisana.';

  @override
  String get google_rateLimited =>
      'Miandrasa kely alohan’ny hanandrana indray, azafady.';

  @override
  String get google_busy =>
      'Tsy azo ampiasaina ny Google raha mbola mandeha ny asa hafa (fifandraisana VPN, kaonty na vahiny). Andramo indray rehefa vita izany; voatahiry ny fidirana ankehitriny.';

  @override
  String get google_invalidPassword =>
      'Diso ny teny miafina FuzeVPN. Voatahiry ny kaonty ankehitriny.';

  @override
  String get google_invalidCode =>
      'Tsy mety na lany daty ny kaody fanamarinana.';

  @override
  String get google_accountChanged =>
      'Niova ny fidirana. Foano ity fanandramana ity alohan’ny hanombohana indray.';

  @override
  String get google_invalidResponse =>
      'Tsy azo hamarinina ny valiny. Voatahiry ny fidirana ankehitriny.';

  @override
  String get google_invalidRegistration =>
      'Jereo ny firenena sy ireo fanekena roa.';

  @override
  String get google_consentRequired =>
      'Safidio ny firenena ary ekeno ireo antontan-taratasy roa mba hanohizana.';

  @override
  String get google_challengeRequired =>
      'Ilaina ny fanamarinana fiarovana fanampiny. Voatahiry ny fidirana ankehitriny.';

  @override
  String get google_challengeUnavailable =>
      'Tsy azo ampiasaina ny fanamarinana fiarovana. Andramo indray any aoriana.';

  @override
  String get google_intentMismatch =>
      'Mbola miandry ny fanandramana fidirana Google teo aloha. Foano alohan’ny hanombohana ity asa ity.';

  @override
  String get google_challengeBlocked =>
      'Tsy misy ao amin’ity fampiharana ity ny fanamarinana fiarovana ilaina. Tsy azo vitaina amin’izao fotoana izao ity asa ity.';

  @override
  String get google_solveChallenge => 'Vitao ny fanamarinana fiarovana';

  @override
  String get google_challengeTitle => 'Fanamarinana fiarovana';

  @override
  String get google_challengeReady =>
      'Vita ny fanamarinana. Afaka manamarina ny famoronana ny kaonty ianareo izao.';

  @override
  String get google_challengeExpired =>
      'Lany daty ny fanamarinana. Vitao indray alohan’ny hanamarinana.';

  @override
  String get google_challengeCancelled =>
      'Nofoanana ny fanamarinana. Afaka manandrana indray ianareo.';

  @override
  String get google_challengeFailed =>
      'Tsy nahomby ny fanamarinana fiarovana. Andramo indray.';

  @override
  String get billing_trialTitle => 'Andramo maimaim-poana ny Fuze Premium';

  @override
  String get billing_trialSubtitle =>
      'Arovy ny fifandraisanareo manomboka androany.';

  @override
  String get billing_trialWeeks => 'Fanandramana maimaim-poana 2 herinandro';

  @override
  String billing_trialDays(String days) {
    return 'Fanandramana maimaim-poana $days andro';
  }

  @override
  String get billing_trialStart => 'Hanomboka ny fanandramana maimaim-poana';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Raha manomboka androany ianareo, andrasana amin’ny $date ny fandoavana voalohany.';
  }

  @override
  String get billing_trialTerms =>
      'Havaozina ho azy amin’ny vidiny voalaza. Mba tsy hisy fandoavana, foano ao amin’ny Google Play alohan’ny fiafaran’ny fanandramana.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Avy eo $price isam-bolana';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Avy eo $price isan-taona';
  }

  @override
  String get billing_choosePeriod => 'Safidio ny drafitra';

  @override
  String get billing_selectionHint =>
      'Misafidiana drafitra iray mba hanohizana.';

  @override
  String get billing_benefitConnection => 'Fifandraisana voafina';

  @override
  String get billing_benefitPrivacy => 'Tsiambaratelo amin’ny Internet';

  @override
  String get billing_benefitNoAccount => 'Tsy ilaina ny fisoratana anarana';

  @override
  String get billing_cancellation => 'Foano ao amin’ny Google Play';

  @override
  String get billing_premiumTitle => 'Fifandraisana voaaro tsara kokoa.';

  @override
  String get billing_premiumSubtitle =>
      'Arovy ny fifandraisana, araka ny hafainganam-pandehanareo.';

  @override
  String get billing_priceMonthly => 'isam-bolana';

  @override
  String get billing_priceYearly => 'isan-taona';

  @override
  String get billing_trialToday => 'Tsy misy aloa androany';

  @override
  String get billing_trialConfirmation =>
      'Hamarinin’ny Google Play ny daty, ny vola farany ary ny hetra mihatra alohan’ny hanamarinanareo.';

  @override
  String get billing_offerChanged =>
      'Niova ny fepetra amin’ity tolotra ity. Havaozy ny drafitra ary misafidiana indray.';

  @override
  String get status_waitingNetwork => 'Miandry tambajotra';

  @override
  String get status_waitingNetworkDetail =>
      'Tsy misy tambajotra azo ampiasaina. Hamarinin’ny VPN ny fifandraisana rehefa miverina ny tambajotra.';

  @override
  String get locations_favoriteLoadFailed =>
      'Tsy afaka nampidina ny ankafiziana. Andramo indray.';

  @override
  String get locations_favoritesLoading => 'Mampidina ny ankafiziana…';
}
