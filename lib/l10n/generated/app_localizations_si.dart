// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class AppLocalizationsSi extends AppLocalizations {
  AppLocalizationsSi([String locale = 'si']) : super(locale);

  @override
  String get vpnDisclosure_title => 'ඔබේ සම්බන්ධතාව ආරක්ෂා කරන්න';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN මෙම උපාංගය සහ FuzeVPN සේවාදායකයන් අතර ගුප්තකේතනය කළ ටනලයක් සෑදීමට Android හි VPN සේවාව (VpnService) භාවිත කරයි.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN සක්‍රිය අතරතුර, ඔබේ යෙදුම්වල අන්තර්ජාල ට්‍රැෆික්, ගමනාන්ත ලිපින සහ DNS ඉල්ලීම්, FuzeVPN පසුබිමේ ක්‍රියාත්මක වන විටදී පවා, ඔබේ සම්බන්ධතාව යොමු කිරීමට මෙම ටනලය හරහා ගමන් කරයි.';

  @override
  String get vpnDisclosure_statusBody =>
      'ඔබේ VPN සම්බන්ධතාව පෙන්වීමට යෙදුම සම්බන්ධතා තත්ත්වය, එහි කාලසීමාව සහ මාරු කළ දත්ත ප්‍රමාණය භාවිත කරයි. ඔබට ඕනෑම වේලාවක එය නවත්වා දැමිය හැකිය.';

  @override
  String get vpnDisclosure_privacy => 'රහස්‍යතාව';

  @override
  String get vpnDisclosure_accept => 'පිළිගෙන ඉදිරියට යන්න';

  @override
  String get vpnDisclosure_decline => 'දැන් නොවේ';

  @override
  String get accountRestoration_title => 'ගිණුම තාවකාලිකව ලබා ගත නොහැකිය';

  @override
  String get accountRestoration_message =>
      'ඔබේ සැසිය රඳවා ගෙන ඇත. ඔබේ ගිණුම ප්‍රතිසාධනය කිරීමට නැවත උත්සාහ කරන්න. ඔබට තවමත් මෙහි VPN සම්බන්ධතාව කළමනාකරණය කළ හැකිය.';

  @override
  String get action_retry => 'නැවත උත්සාහ කරන්න';

  @override
  String get session_endingTitle => 'සැසිය අවසන් කරමින්';

  @override
  String get session_ending =>
      'සැසිය අවසන් කරමින්: VPN නවත්වා පිරිසිදු කරමින්…';

  @override
  String get session_stopFailed =>
      'VPN නවත්වීම තහවුරු වී නැත. නැවත පිවිසීමට පෙර නැවත උත්සාහ කරන්න.';

  @override
  String get session_cleanupFailed =>
      'VPN නවත්වා ඇත, නමුත් සැසිය ඉවත් කිරීම තහවුරු වී නැත. පිරිසිදු කිරීම නැවත උත්සාහ කරන්න.';

  @override
  String get session_retryStop => 'නවත්වීම නැවත උත්සාහ කරන්න';

  @override
  String get session_retryCleanup => 'පිරිසිදු කිරීම නැවත උත්සාහ කරන්න';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN ආරක්ෂිතව සූදානම් කරමින්…';

  @override
  String get nav_connection => 'සම්බන්ධතාව';

  @override
  String get nav_locations => 'ස්ථාන';

  @override
  String get nav_account => 'ගිණුම';

  @override
  String get nav_devices => 'උපාංග';

  @override
  String get nav_settings => 'සැකසුම්';

  @override
  String get action_refresh => 'නැවුම් කරන්න';

  @override
  String get auth_tab_login => 'ගිණුමට පිවිසෙන්න';

  @override
  String get auth_tab_register => 'ලියාපදිංචි වන්න';

  @override
  String get auth_stepAccount => 'ගිණුම';

  @override
  String get auth_stepIdentity => 'අනන්‍යතාව';

  @override
  String get auth_stepAddress => 'ලිපිනය සහ එකඟතා';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'පියවර $current/$total';
  }

  @override
  String get auth_tagline => 'ඔබේ VPN, සරලව.';

  @override
  String get auth_keysLocal => 'ඔබේ පෞද්ගලික VPN යතුරු මෙම උපාංගයේම රැඳී පවතී.';

  @override
  String get form_email => 'ඊමේල් ලිපිනය';

  @override
  String get form_password => 'මුරපදය';

  @override
  String get form_showPassword => 'මුරපදය පෙන්වන්න';

  @override
  String get form_hidePassword => 'මුරපදය සඟවන්න';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 බයිට්. සමහර අක්ෂර එකකට වඩා බයිට් භාවිත කරයි.';

  @override
  String get form_firstName => 'මුල් නම';

  @override
  String get form_lastName => 'අවසාන නම';

  @override
  String get form_phone => 'දුරකථන අංකය (+33612345678)';

  @override
  String get form_address => 'ලිපිනය';

  @override
  String get form_address2 => 'ලිපින පේළිය 2 (විකල්පයි)';

  @override
  String get form_postalCode => 'තැපැල් කේතය';

  @override
  String get form_city => 'නගරය';

  @override
  String get form_country => 'රට කේතය (උදා: FR)';

  @override
  String get action_login => 'ගිණුමට පිවිසෙන්න';

  @override
  String get action_createAccount => 'ගිණුමක් සාදන්න';

  @override
  String get action_createMyAccount => 'මගේ ගිණුම සාදන්න';

  @override
  String get action_next => 'ඉදිරියට';

  @override
  String get action_previous => 'ආපසු';

  @override
  String get action_forgotPassword => 'මුරපදය අමතක වුණාද?';

  @override
  String get auth_noAccount => 'තවමත් ගිණුමක් නැද්ද?';

  @override
  String get auth_requiredInformation => 'පියවර තුනකින් ඔබේ ගිණුම සාදන්න.';

  @override
  String get auth_termsPrefix => 'මම පිළිගනිමි: ';

  @override
  String get auth_termsLink => 'භාවිත නියමයන්';

  @override
  String get auth_privacyPrefix => 'මම පිළිගනිමි: ';

  @override
  String get auth_privacyLink => 'රහස්‍යතා ප්‍රතිපත්තිය';

  @override
  String get auth_consentRequired => 'ගිණුමක් සෑදීමට ඔබේ එකඟතාව අවශ්‍යයි.';

  @override
  String get validation_required => 'මෙම ක්ෂේත්‍රය අවශ්‍යයි.';

  @override
  String get validation_email => 'වලංගු ඊමේල් ලිපිනයක් ඇතුළු කරන්න.';

  @override
  String get validation_password =>
      'මුරපදය ඉතා කෙටියි: අවම වශයෙන් UTF-8 බයිට් 8ක් තිබිය යුතුයි.';

  @override
  String get validation_passwordTooLong =>
      'මුරපදය ඉතා දිගයි: උපරිම UTF-8 බයිට් 72ක් තිබිය යුතුයි.';

  @override
  String get validation_phone =>
      'ජාත්‍යන්තර ආකෘතිය භාවිත කරන්න, උදාහරණයක් ලෙස +33612345678.';

  @override
  String get validation_country =>
      'අක්ෂර දෙකේ රට කේතයක් භාවිත කරන්න, උදාහරණයක් ලෙස FR.';

  @override
  String get passwordReset_title => 'මුරපදය යළි සකසන්න';

  @override
  String get passwordReset_description =>
      'මුරපද යළි සැකසීමේ සබැඳිය ඉල්ලා සිටීමට ඔබේ ගිණුමේ ඊමේල් ලිපිනය ඇතුළු කරන්න.';

  @override
  String get passwordReset_send => 'සබැඳිය යවන්න';

  @override
  String get connection_title => 'ඔබේ සම්බන්ධතාව';

  @override
  String get connection_subtitle =>
      'ස්ථානයක් තෝරන්න, ඉන්පසු ඔබේ VPN ක්‍රියාත්මක කරන්න.';

  @override
  String get connection_prepare => 'සම්බන්ධ වීමට සූදානම්ද?';

  @override
  String get connection_advancedOptions => 'උසස් විකල්ප';

  @override
  String get connection_location => 'ස්ථානය';

  @override
  String get connection_chooseLocation => 'ස්ථානයක් තෝරන්න';

  @override
  String get connection_protocol => 'ප්‍රොටොකෝලය';

  @override
  String get connection_connect => 'සම්බන්ධ වන්න';

  @override
  String get connection_connecting => 'සම්බන්ධ වෙමින්…';

  @override
  String get connection_disconnect => 'විසන්ධි කරන්න';

  @override
  String get connection_disconnecting => 'විසන්ධි වෙමින්';

  @override
  String get connection_locationChange => 'ස්ථානය වෙනස් කරමින්…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ලබා ගත නොහැකිය';
  }

  @override
  String get connection_activeLocation => 'සක්‍රිය ස්ථානය';

  @override
  String get connection_duration => 'කාලසීමාව';

  @override
  String get connection_received => 'ලැබුණු';

  @override
  String get connection_sent => 'යැවූ';

  @override
  String get connection_lastHandshake => 'අවසන් ආරක්ෂිත හුවමාරුව';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration කට පෙර';
  }

  @override
  String get verification_title => 'ඔබේ ඊමේල් ලිපිනය තහවුරු කරන්න';

  @override
  String get verification_message =>
      'මෙම දුරකථනයේ VPN භාවිත කිරීමට ඔබේ ඊමේල් ලිපිනය තහවුරු කරන්න.';

  @override
  String get verification_resend => 'ඊමේල් නැවත යවන්න';

  @override
  String get migration_title => 'ස්ථානය වෙනස් කිරීම';

  @override
  String get migration_draining => 'ස්ථානය වෙනස් කිරීම සූදානම් කරමින්…';

  @override
  String get migration_activating => 'නව සේවාදායකය ක්‍රියාත්මක කරමින්…';

  @override
  String get migration_ready => 'ස්ථානය යාවත්කාලීන කරන ලදී.';

  @override
  String get migration_blocked =>
      'ස්ථානය වෙනස් කිරීමට සේවාදායක මැදිහත්වීමක් අවශ්‍යයි. පසුව නැවත උත්සාහ කරන්න හෝ සහාය අංශය අමතන්න.';

  @override
  String get migration_progress => 'ස්ථානය වෙනස් කිරීමේ ප්‍රගතිය';

  @override
  String migration_retryDelay(Object seconds) {
    return 'පරීක්ෂා අතර ප්‍රමාදය: $seconds තත්පර.';
  }

  @override
  String get migration_resume => 'වෙනස් කිරීම නැවත ආරම්භ කරන්න';

  @override
  String get status_authorizing => 'අවසර අවශ්‍යයි';

  @override
  String get status_authorizingDetail =>
      'VPN සඳහා ඉඩ දීමට Android හි ඉල්ලීම පිළිගන්න.';

  @override
  String get status_preparing => 'සූදානම් වෙමින්';

  @override
  String get status_preparingDetail =>
      'ඔබේ ආරක්ෂිත සම්බන්ධතාව සූදානම් වෙමින් පවතී.';

  @override
  String get status_reconnecting => 'නැවත සම්බන්ධ වෙමින්…';

  @override
  String get status_reconnectingDetail =>
      'සම්බන්ධතාව බිඳ වැටුණි. VPN නැවත සම්බන්ධ වීමට උත්සාහ කරමින් සිටී.';

  @override
  String get status_connecting => 'සම්බන්ධ වෙමින්';

  @override
  String get status_connectingDetail => 'VPN සේවාදායකයට සම්බන්ධ වෙමින්…';

  @override
  String get status_connected => 'සම්බන්ධ වී ඇත';

  @override
  String get status_connectedDetail => 'ඔබේ VPN සම්බන්ධතාව සක්‍රිය වී ඇත.';

  @override
  String get status_disconnecting => 'විසන්ධි වෙමින්';

  @override
  String get status_disconnectingDetail => 'ඔබේ VPN සම්බන්ධතාව නවත්වමින් පවතී.';

  @override
  String get status_error => 'සම්බන්ධතාව ලබා ගත නොහැකිය';

  @override
  String get status_errorDetail =>
      'VPN සම්බන්ධතාව තහවුරු වී නැත. නැවත උත්සාහ කරන්න.';

  @override
  String get status_idle => 'විසන්ධි වී ඇත';

  @override
  String get status_idleDetail =>
      'ඔබේ සම්බන්ධතාව ආරක්ෂා කිරීමට VPN සම්බන්ධ කරන්න.';

  @override
  String get trust_note =>
      'යෙදුම වසා දැමීම VPN නවත්වන්නේ නැත. එය නවත්වීමට විසන්ධි කරන්න බොත්තම ඔබන්න.';

  @override
  String get locations_none => 'දැනට ස්ථාන කිසිවක් ලබා ගත නොහැකිය.';

  @override
  String get locations_available => 'ඔබේ ඊළඟ ස්ථානය තෝරන්න.';

  @override
  String get locations_selected => 'තෝරාගත් ස්ථානය';

  @override
  String get locations_select => 'මෙම ස්ථානය තෝරන්න';

  @override
  String get locations_lockedTunnel => 'ස්ථානය වෙනස් කිරීමට VPN විසන්ධි කරන්න.';

  @override
  String get locations_lockedMigration =>
      'ස්ථානය වෙනස් කිරීම අවසන් වන තෙක් රැඳී සිටින්න.';

  @override
  String get devices_title => 'ඔබේ උපාංග';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit උපාංග';
  }

  @override
  String get devices_refresh => 'උපාංග නැවුම් කරන්න';

  @override
  String get devices_empty => 'තවමත් VPN උපාංගයක් ලියාපදිංචි කර නැත.';

  @override
  String get devices_firstConnection =>
      'ඔබේ දුරකථනය පළමු සම්බන්ධතාවේදී එකතු වනු ඇත.';

  @override
  String get devices_thisDevice => 'මෙම උපාංගය';

  @override
  String devices_added(Object date) {
    return '$date දින එකතු කරන ලදී';
  }

  @override
  String get devices_unnamed => 'නම් නොකළ උපාංගය';

  @override
  String get action_remove => 'ඉවත් කරන්න';

  @override
  String get settings_title => 'සැකසුම්';

  @override
  String get settings_subtitle => 'ඔබේ මනාප සහ ගිණුම, එක තැනකින්.';

  @override
  String get settings_appearance => 'පෙනුම';

  @override
  String get settings_language => 'භාෂාව';

  @override
  String get settings_languageDescription =>
      'ඔබ තෝරාගත් භාෂාව VPN දැනුම්දීම්වලටද අදාළ වේ.';

  @override
  String get settings_account => 'ගිණුම';

  @override
  String get settings_signOut => 'ගිණුමෙන් ඉවත් වන්න';

  @override
  String get settings_privacy => 'රහස්‍යතා ප්‍රතිපත්තිය';

  @override
  String get settings_terms => 'භාවිත නියමයන්';

  @override
  String get settings_security => 'ආරක්ෂාව සහ විනිවිදභාවය';

  @override
  String get settings_licenses => 'සංරචක බලපත්‍ර';

  @override
  String get settings_licensesDetail => 'යෙදුමේ භාවිත කරන මෘදුකාංග';

  @override
  String settings_licensesLegalese(String url) {
    return 'යෙදුමේ සහ එහි MPL-2.0 සංරචකවල මූලාශ්‍ර කේතය: $url';
  }

  @override
  String get settings_background =>
      'ඔබ යෙදුමෙන් ඉවත් වුවත් VPN ක්‍රියාත්මකව පවතී. එය නවත්වීමට, සම්බන්ධතාව ටැබයේ විසන්ධි කරන්න බොත්තම ඔබන්න.';

  @override
  String get theme_system => 'පද්ධතිය';

  @override
  String get theme_light => 'ආලෝක';

  @override
  String get theme_dark => 'අඳුරු';

  @override
  String get language_system => 'දුරකථන භාෂාව';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'මෙම උපාංගය ඉවත් කරන්නද?';

  @override
  String get dialog_removeCurrent =>
      'මෙම දුරකථනය VPN වෙතින් විසන්ධි වී ප්‍රවේශය අහිමි වනු ඇත. සේවාදායකය තහවුරු කළ පසු එහි VPN සම්බන්ධතා දත්ත ඉවත් කෙරේ.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” සඳහා VPN ප්‍රවේශය අහෝසි කෙරේ. මෙය ආපසු හැරවිය නොහැකිය.';
  }

  @override
  String get dialog_signOut => 'ගිණුමෙන් ඉවත් වන්නද?';

  @override
  String get dialog_signOutMessage =>
      'VPN නවතිනු ඇත. ඔබට නැවත ගිණුමට පිවිසීමට සිදුවේ. ඔබේ ගුප්තකේතනය කළ VPN යතුරු ඊළඟ සම්බන්ධතාව සඳහා මෙම දුරකථනයේ රැඳී පවතී.';

  @override
  String get action_cancel => 'අවලංගු කරන්න';

  @override
  String get action_close => 'වසන්න';

  @override
  String get action_copy => 'පිටපත් කරන්න';

  @override
  String get action_renew => 'නවීකරණය කරන්න';

  @override
  String get action_signOut => 'ගිණුමෙන් ඉවත් වන්න';

  @override
  String get notice_close => 'පණිවිඩය වසන්න';

  @override
  String get notice_sessionExpired_title => 'සැසිය කල් ඉකුත් විය';

  @override
  String get notice_sessionExpired_message =>
      'ඔබේ සැසිය කල් ඉකුත් විය. නැවත ගිණුමට පිවිසෙන්න.';

  @override
  String get notice_connectionFailed_title => 'සම්බන්ධ වීම අසාර්ථකයි';

  @override
  String get notice_invalidCredentials_message =>
      'ඊමේල් ලිපිනය හෝ මුරපදය වැරදියි.';

  @override
  String get notice_emailVerification_title => 'ඊමේල් තහවුරු කිරීම අවශ්‍යයි';

  @override
  String get notice_emailVerification_message =>
      'VPN උපාංගයක් එකතු කිරීමට පෙර ඔබේ ඊමේල් ලිපිනය තහවුරු කරන්න.';

  @override
  String get notice_rateLimited_title => 'උත්සාහ ගණන ඉතා වැඩියි';

  @override
  String get notice_deviceLimit_title => 'උපාංග සීමාවට ළඟා විය';

  @override
  String get notice_deviceLimit_message =>
      'තවත් එකක් එකතු කිරීමට පෙර දැනට ඇති උපාංගයක් ඉවත් කරන්න.';

  @override
  String get notice_identityRenewal_title => 'VPN අනන්‍යතාව නවීකරණය කළ යුතුයි';

  @override
  String get notice_identityRenewal_message =>
      'මෙම අනන්‍යතාව ඉවත් කර ඇත. උපාංගයේ නව අනන්‍යතාවක් සාදන්න.';

  @override
  String get notice_migrationPending_title =>
      'ස්ථානය වෙනස් කිරීම සිදු වෙමින් පවතී';

  @override
  String get notice_migrationPending_message =>
      'ස්ථානය වෙනස් කිරීමක් දැනටමත් සිදු වෙමින් පවතී.';

  @override
  String get notice_migrationBlocked_title => 'ස්ථානය වෙනස් කිරීම අවහිර කර ඇත';

  @override
  String get notice_migrationBlocked_message =>
      'ස්ථානය වෙනස් කිරීමට සේවාදායක මැදිහත්වීමක් අවශ්‍යයි. පසුව නැවත උත්සාහ කරන්න හෝ සහාය අංශය අමතන්න.';

  @override
  String get notice_targetUnavailable_title =>
      'සේවාදායකය තාවකාලිකව ලබා ගත නොහැකිය';

  @override
  String get notice_targetUnavailable_message =>
      'මෙම සේවාදායකය තාවකාලිකව ලබා ගත නොහැකිය.';

  @override
  String get notice_networkUnavailable_title =>
      'අන්තර්ජාල සම්බන්ධතාව ලබා ගත නොහැකිය';

  @override
  String get notice_networkUnavailable_message =>
      'ඔබේ සම්බන්ධතාව පරීක්ෂා කර නැවත උත්සාහ කරන්න.';

  @override
  String get notice_permissionDenied_title => 'VPN අවසරය ප්‍රතික්ෂේප විය';

  @override
  String get notice_permissionDenied_message =>
      'සම්බන්ධතාව නැවත ආරම්භ කර Android අවසර ඉල්ලීම පිළිගන්න.';

  @override
  String get notice_wireguardTimeout_title => 'සේවාදායකය ප්‍රතිචාර නොදක්වයි';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard සම්බන්ධතාව බොහෝ වේලාවක් ගත විය. නැවත උත්සාහ කරන්න හෝ වෙනත් ස්ථානයක් තෝරන්න.';

  @override
  String get notice_tlsFailed_title => 'ආරක්ෂිත සම්බන්ධතාව ප්‍රතික්ෂේප විය';

  @override
  String get notice_tlsFailed_message =>
      'සේවාදායකය OpenVPN සම්බන්ධතාව පිළිගත්තේ නැත. නැවත උත්සාහ කරන්න. ගැටලුව දිගටම පැවතියහොත්, රෝග විනිශ්චයක් ක්‍රියාත්මක කරන්න.';

  @override
  String get notice_tunRejected_title =>
      'Android විසින් VPN අතුරුමුහුණත ප්‍රතික්ෂේප කළේය';

  @override
  String get notice_tunRejected_message =>
      'OpenVPN විසින් ඉල්ලූ ජාල වින්‍යාසය Android විසින් ප්‍රතික්ෂේප කළේය.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN ආරම්භ කළ නොහැකි විය';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN එන්ජිම ආරම්භ කිරීම සම්පූර්ණ කළ නොහැකි විය. නැවත උත්සාහ කරන්න. ගැටලුව දිගටම පැවතියහොත්, සහාය අංශය අමතන්න.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'රෝග විනිශ්චය කේතය: $code';
  }

  @override
  String get notice_generic_title => 'VPN සම්බන්ධතාව අසාර්ථකයි';

  @override
  String get notice_generic_message =>
      'දෝෂයක් ඇති විය. පසුව නැවත උත්සාහ කරන්න.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'ගිණුම සාදන ලදී',
      'password_reset_sent': 'මුරපද යළි සැකසීමේ ඉල්ලීම ලැබුණි',
      'verification_email_sent': 'තහවුරු කිරීමේ ඊමේල් යවන ලදී',
      'location_migration_pending': 'ස්ථානය වෙනස් කිරීම සිදු වෙමින් පවතී',
      'vpn_sign_in_required': 'ගිණුමට පිවිසීම අවශ්‍යයි',
      'protocol_unavailable_at_location': 'ප්‍රොටොකෝලය ලබා ගත නොහැකිය',
      'vpn_permission_denied': 'VPN අවසරය ප්‍රතික්ෂේප විය',
      'revoked_identity_device_limit': 'උපාංග සීමාවට ළඟා විය',
      'tunnel_start_unexpected': 'VPN ආරම්භ කළ නොහැකි විය',
      'flutter_disconnect_timeout': 'විසන්ධි වීම තහවුරු වී නැත',
      'flutter_disconnect_unexpected': 'විසන්ධි කළ නොහැකි විය',
      'device_revoked': 'උපාංගය ඉවත් කරන ලදී',
      'revoke_unexpected': 'උපාංගය ඉවත් කළ නොහැකි විය',
      'identity_renewal_unexpected': 'අනන්‍යතාව නවීකරණය කළ නොහැකි විය',
      'openvpn_renewal_unexpected': 'OpenVPN නවීකරණය කළ නොහැකි විය',
      'location_migration_blocked': 'ස්ථානය වෙනස් කිරීම අවහිර කර ඇත',
      'location_migration_slow': 'ස්ථානය වෙනස් කිරීම තවමත් සිදු වෙමින් පවතී',
      'location_migration_conflict': 'ස්ථානය වෙනස් කිරීම නැවුම් කළ යුතුයි',
      'location_migration_verification_failed':
          'ස්ථානය වෙනස් කිරීම තහවුරු වී නැත',
      'location_migration_device_changed':
          'ස්ථානය වෙනස් කිරීමේදී උපාංගය වෙනස් විය',
      'tunnel_stop_failed': 'ස්ථානය වෙනස් කිරීම ලබා ගත නොහැකිය',
      'device_clock_ahead': 'උපාංගයේ ඔරලෝසුව ඉදිරියෙන් ඇත',
      'other': 'මෙහෙයුම අසාර්ථකයි',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'ගිණුම සාදන ලද නමුත් තහවුරු කිරීමේ ඊමේල් යැවිය නොහැකි විය. යෙදුමෙන් නැවත යැවීම භාවිත කරන්න.',
      'password_reset_sent':
          'ඔබේ ඉල්ලීම ලැබුණි. මෙම ලිපිනයට ගැළපෙන ගිණුමක් තිබේ නම්, ඊමේල් පණිවිඩයක් ලැබිය හැකිය. කරුණාකර ස්පෑම් ෆෝල්ඩරය ද පරීක්ෂා කරන්න.',
      'verification_email_sent':
          'නව තහවුරු කිරීමේ ඊමේල් පණිවිඩයක් දැන් යවා ඇත.',
      'location_migration_pending':
          '$target වෙත මාරු වීම තවමත් සූදානම් කරමින් පවතී. උපාංගය නැවත සෑදීමකින් තොරව එය නැවත ආරම්භ කළ හැකිය.',
      'vpn_sign_in_required': 'VPN ආරම්භ කිරීමට පෙර ඔබේ ගිණුමට පිවිසෙන්න.',
      'protocol_unavailable_at_location':
          'මෙම ස්ථානයේ තෝරාගත් ප්‍රොටොකෝලය ලබා ගත නොහැක. ස්ථාන නැවුම් කරන්න හෝ වෙනත් ප්‍රොටොකෝලයක් තෝරන්න.',
      'vpn_permission_denied':
          'Android මගින් VPN අවසරය ප්‍රතික්ෂේප කළේය. සම්බන්ධතාව නැවත ආරම්භ කර පද්ධති ඉල්ලීම පිළිගන්න.',
      'revoked_identity_device_limit':
          'මෙම උපාංගයේ VPN ප්‍රවේශය ඉවත් කර ඇති අතර උපාංග සීමාවට ළඟා වී ඇත. ගිණුම → “මගේ උපාංග කළමනාකරණය කරන්න” වෙත ගොස් උපාංගයක් ඉවත් කරන්න.',
      'tunnel_start_unexpected':
          'VPN සූදානම් කිරීමේදී අනපේක්ෂිත දෝෂයක් ඇති විය. රෝග විනිශ්චය කේතය පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'flutter_disconnect_timeout':
          'Android නියමිත වේලාවට VPN නවත්වා ඇති බව තහවුරු කළේ නැත. නැවත නවත්වා බලන්න.',
      'flutter_disconnect_unexpected':
          'අනපේක්ෂිත දෝෂයක් නිසා ටනලය නැවතී ඇති බව තහවුරු කළ නොහැකි විය.',
      'device_revoked':
          'උපාංගයේ VPN ප්‍රවේශය අහෝසි කර ඇති අතර එහි ගබඩා කළ රහස් ඉවත් කර ඇත.',
      'revoke_unexpected':
          'උපාංගය ඉවත් කළ නොහැකි විය. ලැයිස්තුව නැවුම් කර නැවත උත්සාහ කරන්න.',
      'identity_renewal_unexpected':
          'නව VPN අනන්‍යතාව සෑදිය නොහැකි විය. උපාංග නැවුම් කර නැවත උත්සාහ කරන්න.',
      'openvpn_renewal_unexpected':
          'OpenVPN පැතිකඩ නවීකරණය කළ නොහැකි විය. නැවත උත්සාහ කරන්න හෝ රෝග විනිශ්චය කේතය පරීක්ෂා කරන්න.',
      'location_migration_blocked':
          'සේවාදායකයට මෙම වෙනස දැන් සම්පූර්ණ කළ නොහැක. උපාංගය සහ එහි අනන්‍යතාව රඳවා ගෙන ඇත.',
      'location_migration_slow':
          'සේවාදායකය තවමත් $target වෙත මාරු වීම සූදානම් කරමින් පවතී. මොහොතකින් නැවත ආරම්භ කරන්න බොත්තම භාවිත කරන්න.',
      'location_migration_conflict':
          'උපාංග තත්ත්වය සේවාදායකය මත වෙනස් වී ඇත. උපාංග නැවුම් කර, ඉන්පසු ස්ථානය වෙනස් කිරීම නැවත ආරම්භ කරන්න.',
      'location_migration_verification_failed':
          'නව ස්ථානය සේවාදායකය තහවුරු කළේ නැත. පෙර අනන්‍යතාව රඳවා ගෙන ඇත.',
      'location_migration_device_changed':
          'සේවාදායකයෙන් ලැබුණු උපාංගය වෙනස් කරන ලද උපාංගයට තවදුරටත් ගැළපෙන්නේ නැත. නැවත උත්සාහ කිරීමට පෙර උපාංග නැවුම් කරන්න.',
      'tunnel_stop_failed':
          'නව සම්බන්ධතාවට පෙර පැරණි ටනලය සම්පූර්ණයෙන් නැවතිය යුතුයි.',
      'device_clock_ahead':
          'මෙම උපාංගයේ ඔරලෝසුව ඉදිරියට ගොස් ඇති සේ පෙනේ. ගිණුමට පිවිසී සිටීමට ස්වයංක්‍රීය දිනය සහ වේලාව ක්‍රියාත්මක කරන්න.',
      'other':
          'මෙහෙයුම සම්පූර්ණ කළ නොහැකි විය. නැවත උත්සාහ කරන්න හෝ රෝග විනිශ්චය කේතය සහාය අංශයට යවන්න.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'සැසිය කල් ඉකුත් විය',
      'invalid_credentials': 'පිවිසීම අසාර්ථකයි',
      'email_verification_required': 'ඊමේල් තහවුරු කිරීම අවශ්‍යයි',
      'verification_email_cooldown': 'ඊමේල් දැනටමත් යවා ඇත',
      'rate_limited': 'උත්සාහ ගණන ඉතා වැඩියි',
      'invalid_registration': 'තොරතුරු නිවැරදි කළ යුතුයි',
      'email_exists': 'ගිණුම දැනටමත් පවතී',
      'invalid_profile': 'වලංගු නොවන පැතිකඩක්',
      'invalid_device': 'වලංගු නොවන උපාංගයක්',
      'invalid_location': 'ස්ථානය ලබා ගත නොහැක',
      'device_limit': 'උපාංග සීමාවට ළඟා විය',
      'device_exists': 'VPN අනන්‍යතාව දැනටමත් භාවිත වේ',
      'device_identity_revoked': 'VPN අනන්‍යතාව නවීකරණය කළ යුතුයි',
      'device_location_locked': 'ස්ථානය වෙනස් කිරීම නැවුම් කළ යුතුයි',
      'location_migration_pending': 'ස්ථානය වෙනස් කිරීම සිදු වෙමින් පවතී',
      'location_migration_blocked': 'ස්ථානය වෙනස් කිරීම අවහිර කර ඇත',
      'target_ca_mismatch': 'අනුකූල නොවන OpenVPN සේවාදායකය',
      'location_migration_conflict': 'ස්ථානය වෙනස් කිරීම නැවුම් කළ යුතුයි',
      'server_full': 'සේවාදායකය පිරී ඇත',
      'capacity_unavailable': 'ස්ථානය තාවකාලිකව ලබා ගත නොහැක',
      'target_unavailable': 'සේවාදායකය තාවකාලිකව ලබා ගත නොහැක',
      'not_found': 'අයිතමය හමු නොවීය',
      'invalid_openvpn_csr': 'වලංගු නොවන OpenVPN අනන්‍යතාව',
      'openvpn_profile_exists': 'OpenVPN පැතිකඩ දැනටමත් පවතී',
      'openvpn_profile_revoked': 'OpenVPN පැතිකඩ අහෝසි කර ඇත',
      'openvpn_operation_pending': 'OpenVPN මෙහෙයුම සිදු වෙමින් පවතී',
      'openvpn_operation_terminal': 'OpenVPN මෙහෙයුම බාධාවට පත් විය',
      'openvpn_address_unavailable': 'OpenVPN ලිපිනය ලබා ගත නොහැක',
      'openvpn_profile_conflict': 'OpenVPN ගැටුමක්',
      'openvpn_signer_unavailable': 'OpenVPN ලබා ගත නොහැක',
      'email_delivery_unavailable': 'ඊමේල් ලබා ගත නොහැක',
      'invalid_token': 'වලංගු නොවන සබැඳියක්',
      'network_unavailable': 'අන්තර්ජාල සම්බන්ධතාව ලබා ගත නොහැක',
      'invalid_json': 'වලංගු නොවන ඉල්ලීමක්',
      'invalid_api_response': 'වලංගු නොවන සේවාදායක ප්‍රතිචාරයක්',
      'ipv6_unavailable': 'IPv6 ලබා ගත නොහැක',
      'invalid_ip_families': 'ජාල වින්‍යාසය ප්‍රතික්ෂේප විය',
      'other': 'සේවාව ලබා ගත නොහැක',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ඔබේ සැසිය කල් ඉකුත් වී ඇත. නැවත ගිණුමට පිවිසෙන්න.',
      'invalid_credentials': 'ඊමේල් ලිපිනය හෝ මුරපදය වැරදියි.',
      'email_verification_required':
          'VPN උපාංගයක් එකතු කිරීමට පෙර ඔබේ ඊමේල් ලිපිනය තහවුරු කරන්න.',
      'invalid_registration': 'ඉල්ලන ලද තොරතුරු සහ එකඟතා පරීක්ෂා කරන්න.',
      'email_exists': 'මෙම ඊමේල් ලිපිනය දැනටමත් ගිණුමක් සඳහා භාවිත වේ.',
      'invalid_profile': 'ඔබේ පැතිකඩ තොරතුරු පරීක්ෂා කරන්න.',
      'invalid_device': 'මෙම උපාංගයේ නම හෝ අනන්‍යතාව වලංගු නොවේ.',
      'invalid_location': 'ස්ථාන ලැයිස්තුව නැවුම් කර නැවත උත්සාහ කරන්න.',
      'device_limit': 'තවත් එකක් එකතු කිරීමට පෙර පවතින උපාංගයක් ඉවත් කරන්න.',
      'device_exists': 'මෙම VPN අනන්‍යතාව දැනටමත් වෙනත් ගිණුමකට සම්බන්ධ කර ඇත.',
      'device_identity_revoked':
          'මෙම අනන්‍යතාව ඉවත් කර ඇත. උපාංගයේ නව අනන්‍යතාවක් සෑදිය යුතුයි.',
      'device_location_locked':
          'මෙම උපාංගයේ ස්ථානය වෙනස් වී ඇත. සිදු වෙමින් පවතින වෙනස යෙදුම නැවත ආරම්භ කරයි.',
      'location_migration_pending':
          'ස්ථානය වෙනස් කිරීමක් දැනටමත් සිදු වෙමින් පවතී.',
      'location_migration_blocked':
          'ස්ථානය වෙනස් කිරීමට සේවාදායක මැදිහත්වීමක් අවශ්‍යයි. පසුව නැවත උත්සාහ කරන්න හෝ සහාය අංශය අමතන්න.',
      'target_ca_mismatch':
          'මෙම සේවාදායකය දැනට ඇති OpenVPN පැතිකඩ සමඟ තවමත් අනුකූල නොවේ.',
      'location_migration_conflict':
          'උපාංග නැවුම් කර, ඉන්පසු ස්ථානය වෙනස් කිරීම නැවත උත්සාහ කරන්න.',
      'server_full':
          'මෙම ස්ථානය එහි සම්බන්ධතා සීමාවට ළඟා වී ඇත. වෙනත් ස්ථානයක් තෝරන්න හෝ පසුව නැවත උත්සාහ කරන්න.',
      'capacity_unavailable':
          'මෙම ස්ථානය දැන් ලබා ගත හැකිදැයි තහවුරු කළ නොහැක. වෙනත් ස්ථානයක් තෝරන්න හෝ පසුව නැවත උත්සාහ කරන්න.',
      'target_unavailable': 'මෙම සේවාදායකය තාවකාලිකව ලබා ගත නොහැක.',
      'not_found': 'මෙම අයිතමය තවදුරටත් ඔබේ ගිණුමේ ලබා ගත නොහැක.',
      'invalid_openvpn_csr': 'නව OpenVPN අනන්‍යතාවක් සාදා නැවත උත්සාහ කරන්න.',
      'openvpn_profile_exists':
          'මෙම උපාංගය සඳහා OpenVPN පැතිකඩක් දැනටමත් පවතී.',
      'openvpn_profile_revoked':
          'දිගටම කරගෙන යාමට OpenVPN පැතිකඩ නවීකරණය කරන්න.',
      'openvpn_operation_pending':
          'වෙනස තවමත් ව්‍යාප්ත වෙමින් පවතී. පසුව නැවත උත්සාහ කරන්න.',
      'openvpn_operation_terminal':
          'නව OpenVPN අනන්‍යතාවක් සාදා නැවත උත්සාහ කරන්න.',
      'openvpn_address_unavailable': 'දැනට OpenVPN ලිපිනයක් ලබා ගත නොහැක.',
      'openvpn_profile_conflict':
          'පැතිකඩ වෙනස් වී ඇත. උපාංග නැවුම් කර නැවත උත්සාහ කරන්න.',
      'openvpn_signer_unavailable': 'OpenVPN සේවාව තාවකාලිකව ලබා ගත නොහැක.',
      'email_delivery_unavailable':
          'ඊමේල් යැවිය නොහැකි විය. පසුව නැවත උත්සාහ කරන්න.',
      'invalid_token':
          'මෙම සබැඳිය වලංගු නොවේ හෝ කල් ඉකුත් වී ඇත. නව එකක් ඉල්ලන්න.',
      'network_unavailable':
          'ඔබේ අන්තර්ජාල සම්බන්ධතාව පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'invalid_json': 'ඇතුළු කළ තොරතුරු පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'invalid_api_response':
          'සේවාදායකය අනපේක්ෂිත ප්‍රතිචාරයක් ලබා දුන්නේය. පසුව නැවත උත්සාහ කරන්න.',
      'ipv6_unavailable':
          'සේවාදායකයට මේ මොහොතේ IPv6 සක්‍රිය කළ නොහැක. පසුව නැවත උත්සාහ කරන්න.',
      'invalid_ip_families':
          'ටනලයේ වින්‍යාසය අසම්පූර්ණයි හෝ අනුමත ලිපින සමඟ නොගැළපේ. යෙදුමෙන් නැවත උත්සාහ කරන්න.',
      'other': 'සේවාදායක දෝෂයක් ඇති විය. පසුව නැවත උත්සාහ කරන්න.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'මොහොතකින් නැවත උත්සාහ කරන්න.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'තත්පර $secondsකින් නැවත උත්සාහ කරන්න.',
      one: '$seconds තත්පරයකින් නැවත උත්සාහ කරන්න.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'මිනිත්තු $minutesකින් නැවත උත්සාහ කරන්න.',
      one: '$minutes මිනිත්තුවකින් නැවත උත්සාහ කරන්න.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'පැය $hoursකින් නැවත උත්සාහ කරන්න.',
      one: '$hours පැයකින් නැවත උත්සාහ කරන්න.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'පද්ධති VPN නැවත ආරම්භ කිරීම ලබා ගත නොහැක',
      'system_vpn_resume_corrupt': 'පද්ධති VPN නැවත ආරම්භ කිරීම වලංගු නොවේ',
      'system_vpn_resume_session_invalid':
          'VPN නැවත ආරම්භ කිරීමේ සැසිය වලංගු නොවේ',
      'system_vpn_resume_identity_changed': 'VPN අනන්‍යතාව වෙනස් විය',
      'system_vpn_resume_identity_invalid':
          'VPN නැවත ආරම්භ කිරීමේ අනන්‍යතාව වලංගු නොවේ',
      'system_vpn_resume_storage_failed':
          'VPN නැවත ආරම්භ කිරීමේ ගබඩාව ලබා ගත නොහැක',
      'system_vpn_resume_network_timeout': 'VPN නැවත ආරම්භ කිරීමට ජාලයක් නොමැත',
      'system_vpn_resume_blocked': 'VPN නැවත ආරම්භ කිරීම අවහිර විය',
      'system_vpn_resume_failed': 'VPN නැවත ආරම්භ කිරීම අසාර්ථක විය',
      'system_vpn_resume_error_invalid':
          'VPN නැවත ආරම්භ කිරීමේ දෝෂය වලංගු නොවේ',
      'wireguard_identity_store_failed': 'WireGuard අනන්‍යතාව සුරැකී නැත',
      'wireguard_identity_unavailable': 'WireGuard අනන්‍යතාව ලබා ගත නොහැක',
      'vpn_host_destroyed': 'Android VPN සත්කාරකය නවත්වන ලදී',
      'vpn_host_unavailable': 'Android VPN සත්කාරකය ලබා ගත නොහැක',
      'vpn_permission_required': 'VPN අවසරය අවශ්‍යයි',
      'vpn_permission_denied': 'VPN අවසරය ප්‍රතික්ෂේප විය',
      'vpn_permission_request_failed': 'අවසරය ඉල්ලීමට නොහැකි විය',
      'wireguard_foreground_service_unavailable':
          'WireGuard සේවාව ලබා ගත නොහැක',
      'wireguard_identity_invalid': 'උපාංගයේ WireGuard යතුර වලංගු නොවේ',
      'wireguard_identity_in_use': 'WireGuard අනන්‍යතාව දැනටමත් භාවිතයේ ඇත',
      'wireguard_configuration_invalid': 'WireGuard වින්‍යාසය වලංගු නොවේ',
      'wireguard_operation_pending': 'WireGuard මෙහෙයුම තවමත් ක්‍රියාකාරී වේ',
      'wireguard_start_failed': 'WireGuard ආරම්භය ප්‍රතික්ෂේප විය',
      'wireguard_stop_timeout': 'WireGuard නැවතීම තහවුරු නොවීය',
      'wireguard_handshake_timeout': 'WireGuard ප්‍රතිචාර දැක්වුවේ නැත',
      'openvpn_connection_timeout': 'OpenVPN ප්‍රතිචාර දැක්වුවේ නැත',
      'openvpn_core_unavailable': 'OpenVPN එන්ජිම ලබා ගත නොහැක',
      'openvpn_operation_pending': 'OpenVPN සැසිය තවමත් ක්‍රියාකාරී වේ',
      'openvpn_stop_timeout': 'OpenVPN නැවතීම තහවුරු නොවීය',
      'openvpn_profile_unavailable': 'උපාංගයේ OpenVPN පැතිකඩ නැත',
      'openvpn_native_failed': 'නේටිව් OpenVPN ඉල්ලීම බාධාවට පත් විය',
      'openvpn_key_generation_failed': 'OpenVPN P-256 යතුර සෑදීමට නොහැකි විය',
      'openvpn_csr_generation_failed': 'OpenVPN CSR සෑදීමට නොහැකි විය',
      'openvpn_identity_store_failed': 'OpenVPN අනන්‍යතාව සුරැකී නැත',
      'openvpn_identity_clear_failed': 'OpenVPN ඉවත් කිරීම අසම්පූර්ණයි',
      'openvpn_identity_in_use': 'OpenVPN අනන්‍යතාව තවමත් භාවිතයේ ඇත',
      'openvpn_tls_verification_required': 'OpenVPN TLS සත්‍යාපනය නැත',
      'openvpn_cipher_invalid': 'OpenVPN ගුප්තකේතය වලංගු නොවේ',
      'openvpn_profile_rejected': 'OpenVPN පැතිකඩ ප්‍රතික්ෂේප විය',
      'openvpn_identity_inconsistent': 'OpenVPN අනන්‍යතාව නොගැලපේ',
      'tls_handshake_failed': 'OpenVPN සාකච්ඡාව ප්‍රතික්ෂේප විය',
      'tls_alert_unknown_ca': 'OpenVPN ක්ලයන්ට් සහතිකය හඳුනා නොගන්නා ලදී',
      'tls_alert_bad_certificate': 'OpenVPN ක්ලයන්ට් සහතිකය ප්‍රතික්ෂේප විය',
      'tls_alert_unsupported_certificate': 'OpenVPN සහතිකය සහාය නොදක්වයි',
      'tls_client_certificate_required': 'OpenVPN ක්ලයන්ට් සහතිකය අවශ්‍යයි',
      'tls_alert_misc': 'OpenVPN TLS අනතුරු ඇඟවීම',
      'tls_signature_algorithm_rejected': 'OpenVPN අත්සන සහාය නොදක්වයි',
      'tls_handshake_rejected': 'OpenVPN TLS සාකච්ඡාව ප්‍රතික්ෂේප විය',
      'tls_version_rejected': 'OpenVPN TLS අනුවාදය නොගැළපේ',
      'tls_certificate_expired': 'TLS සහතිකය කල් ඉකුත් විය',
      'tls_certificate_revoked': 'TLS සහතිකය අහෝසි කරන ලදී',
      'transport_failed': 'OpenVPN සේවාදායකය ළඟා විය නොහැක',
      'tun_configuration_rejected': 'OpenVPN අතුරුමුහුණත සෑදීමට නොහැකි විය',
      'tun_setup_failed': 'OpenVPN TUN සකස් කිරීම අසාර්ථක විය',
      'tun_interface_create_failed': 'OpenVPN අතුරුමුහුණත සෑදීම අසාර්ථක විය',
      'tun_interface_disabled': 'OpenVPN අතුරුමුහුණත අක්‍රිය කරන ලදී',
      'tun_halted': 'OpenVPN අතුරුමුහුණත බාධාවට පත් විය',
      'tun_already_established': 'OpenVPN අතුරුමුහුණත දැනටමත් විවෘත වී ඇත',
      'tun_addresses_missing': 'OpenVPN ලිපිනය නැත',
      'tun_routes_missing': 'OpenVPN මාර්ග නැත',
      'tun_dns_missing': 'OpenVPN DNS නැත',
      'tun_permission_revoked': 'VPN අවසරය ඉවත් කරන ලදී',
      'tun_establish_returned_null': 'Android VPN අතුරුමුහුණත ප්‍රතික්ෂේප කළේය',
      'openvpn_service_start_failed': 'OpenVPN සේවාව ලබා ගත නොහැක',
      'openvpn_operation_timeout': 'OpenVPN ඉල්ලීම කාලය ඉක්මවා ගියේය',
      'openvpn_start_failed': 'OpenVPN ආරම්භය ප්‍රතික්ෂේප විය',
      'openvpn_connection_failed': 'OpenVPN සම්බන්ධතාව බාධාවට පත් විය',
      'openvpn_core_status_error': 'OpenVPN හරය දෝෂයකින් අවසන් විය',
      'openvpn_stopped_before_connected': 'OpenVPN සම්බන්ධ වීමට පෙර නවත්වන ලදී',
      'openvpn_auth_failed': 'OpenVPN සත්‍යාපනය ප්‍රතික්ෂේප විය',
      'openvpn_client_setup_failed': 'OpenVPN ක්ලයන්ට් සැකසීම අසාර්ථක විය',
      'openvpn_client_halted': 'OpenVPN ක්ලයන්ට් බාධාවට පත් විය',
      'openvpn_client_restart': 'OpenVPN නැවත ආරම්භ කිරීම ඉල්ලා ඇත',
      'openvpn_inactive_timeout': 'OpenVPN දීර්ඝ කාලයක් අක්‍රියයි',
      'openvpn_session_expired': 'OpenVPN සැසිය කල් ඉකුත් විය',
      'openvpn_credentials_required': 'OpenVPN සත්‍යාපනය සහාය නොදක්වයි',
      'openvpn_proxy_failed': 'OpenVPN මැදිහත්කාර ප්‍රවාහනය අසාර්ථක විය',
      'openvpn_compression_failed': 'OpenVPN සම්පීඩනය ප්‍රතික්ෂේප විය',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM ගුප්තකේතනය ලබා ගත නොහැක',
      'openvpn_feature_unsupported': 'OpenVPN විශේෂාංගය සහාය නොදක්වයි',
      'network_unavailable': 'අන්තර්ජාල සම්බන්ධතාව ලබා ගත නොහැක',
      'network_lost': 'ජාලය ලබා ගත නොහැක',
      'certificate_validation_failed': 'සේවාදායක සහතිකය ප්‍රතික්ෂේප විය',
      'openvpn_certificate_expired': 'OpenVPN සහතිකය කල් ඉකුත් විය',
      'tunnel_active_for_another_account':
          'වෙනත් ගිණුමක ටනලය තවමත් ක්‍රියාකාරී වේ',
      'tunnel_already_active': 'නේටිව් ටනලය දැනටමත් ක්‍රියාකාරී වේ',
      'tunnel_stop_timeout': '$protocol නැවතීම තහවුරු නොවීය',
      'tunnel_disconnected': '$protocol බාධාවට පත් විය',
      'native_bridge_unavailable': 'Android පාලම ලබා ගත නොහැක',
      'native_operation_failed': 'Android මෙහෙයුම බාධාවට පත් විය',
      'invalid_arguments': 'VPN පරාමිතීන් අසම්පූර්ණයි',
      'invalid_account_id': 'VPN ගිණුම වලංගු නොවේ',
      'invalid_device_id': 'උපාංග හඳුනාගැනීම වලංගු නොවේ',
      'storage_key_not_allowed': 'ගබඩා යතුර ප්‍රතික්ෂේප විය',
      'secure_storage_read_failed': 'ආරක්ෂිත කියවීම අසාර්ථක විය',
      'secure_storage_write_failed': 'ආරක්ෂිත ලිවීම අසාර්ථක විය',
      'key_generation_failed': 'WireGuard යතුර ජනනය කිරීමට නොහැකි විය',
      'csr_generation_failed': 'OpenVPN CSR ජනනය කිරීමට නොහැකි විය',
      'openvpn_recovery_exhausted':
          'OpenVPN ප්‍රකෘතිමත් කිරීම දැනටමත් භාවිත විය',
      'openvpn_recovery_failed': 'OpenVPN ප්‍රකෘතිමත් කිරීම අසාර්ථක විය',
      'openvpn_renewal_required': 'OpenVPN සහතික නවීකරණය අවශ්‍යයි',
      'other': 'වර්ගීකරණය නොකළ නේටිව් VPN දෝෂය',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android හට නැවත ආරම්භ කළ හැකි VPN සැසියක් සොයා ගත නොහැක. යෙදුමේ නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_corrupt':
          'සුරැකූ VPN නැවත ආරම්භ කිරීමේ දත්ත වලංගු නොවන බැවින් ඒවා භාවිත නොකෙරේ. නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_session_invalid':
          'සුරැකූ සැසියට තවදුරටත් VPN නැවත ආරම්භ කළ නොහැක. යෙදුමට නැවත පිවිසෙන්න.',
      'system_vpn_resume_identity_changed':
          'උපාංගයේ VPN අනන්‍යතාව වෙනස් විය. නැවත ආරම්භ කිරීම නවත්වන ලදී. නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_identity_invalid':
          'නැවත ආරම්භ කිරීම සඳහා වන අනන්‍යතාව වලංගු නොවේ. නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_storage_failed':
          'ගුප්තකේතනය කළ නැවත ආරම්භ කිරීමේ දත්ත කියවීමට හෝ යාවත්කාලීන කිරීමට Android හට නොහැකි විය. නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_network_timeout':
          'VPN නැවත ආරම්භ කිරීමට නියමිත වේලාවට ජාලයක් සොයා ගැනීමට Android හට නොහැකි විය. ජාලයක් ලබා ගත හැකි වූ විට නැවත උත්සාහ කරන්න.',
      'system_vpn_resume_blocked':
          'VPN නැවත ආරම්භ කිරීම අවහිර කර ඇත. Android සැකසුම් පරීක්ෂා කර, ඉන්පසු නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_failed':
          'Android VPN නැවත ආරම්භ කිරීම අසාර්ථක විය. යෙදුමේ නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'system_vpn_resume_error_invalid':
          'Android විසින් භාවිත කළ නොහැකි නැවත ආරම්භ කිරීමේ දෝෂයක් ලබා දුන්නේය. නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'wireguard_identity_store_failed':
          'මෙම ගිණුමේ ගුප්තකේතනය කළ WireGuard අනන්‍යතාව සුරැකීමට Android හට නොහැකි විය.',
      'wireguard_identity_unavailable':
          'මෙම සම්බන්ධතාව සඳහා භාවිත කළ හැකි WireGuard අනන්‍යතාවක් නොමැත.',
      'vpn_host_destroyed':
          'VPN සත්කාරක Android සංරචකය නවත්වන ලදී. නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'vpn_host_unavailable':
          'VPN සත්කාරක සංරචකය සෑදීමට Android හට නොහැක. VPN සැකසුම් පරීක්ෂා කර නැවත උත්සාහ කරන්න.',
      'openvpn_renewal_required':
          'OpenVPN සහතිකය ස්වයංක්‍රීයව නවීකරණය කළ නොහැකි විය. යෙදුමේ නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'openvpn_recovery_failed':
          'ස්වයංක්‍රීය ප්‍රකෘතිමත් කිරීම අසාර්ථක විය. යෙදුමේ නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'openvpn_recovery_exhausted':
          'ස්වයංක්‍රීය ප්‍රකෘතිමත් කිරීම දැනටමත් භාවිත කර ඇත. යෙදුමේ නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'vpn_permission_required':
          'ටනලය ආරම්භ කිරීමට පෙර Android හට නව VPN අවසරයක් අවශ්‍ය වේ.',
      'vpn_permission_denied':
          'ඉදිරියට යාමට Android ඉල්ලීමේදී FuzeVPN සඳහා ඉඩ දෙන්න.',
      'vpn_permission_request_failed':
          'VPN අවසර තිරය විවෘත කිරීමට Android හට නොහැකි විය.',
      'wireguard_foreground_service_unavailable':
          'WireGuard සේවාව පෙරබිමේ තබා ගැනීමට Android හට නොහැකි විය.',
      'wireguard_identity_invalid':
          'මෙම ගිණුමේ ගුප්තකේතනය කළ WireGuard යතුර කියවිය නොහැක හෝ වලංගු නොවේ.',
      'wireguard_identity_in_use':
          'වෙනත් මෙහෙයුමක් මෙම ගිණුමේ WireGuard යතුර තවමත් භාවිත කරයි.',
      'wireguard_configuration_invalid':
          'ලැබුණු WireGuard ලිපිනය, DNS, සේවාදායක යතුර හෝ මාර්ග වලංගු නොවේ.',
      'wireguard_operation_pending':
          'පෙර WireGuard මෙහෙයුම තවමත් එහි නේටිව් සේවාව නිදහස් කර නැත.',
      'wireguard_start_failed':
          'WireGuard එන්ජිම වින්‍යාසය සක්‍රිය කිරීම ප්‍රතික්ෂේප කළේය.',
      'wireguard_stop_timeout':
          'නියමිත කාලය තුළ VPN අතුරුමුහුණත නිදහස් කිරීම WireGuard සේවාව තහවුරු කළේ නැත.',
      'wireguard_handshake_timeout':
          'නියමිත වේලාවට ටනලය සේවාදායකය සමඟ ආරක්ෂිත හුවමාරුව (හැන්ඩ්ෂේක්) තහවුරු කළේ නැත.',
      'openvpn_connection_timeout':
          'නියමිත වේලාවට සේවාදායකය සමඟ සම්බන්ධතාව OpenVPN තහවුරු කළේ නැත.',
      'openvpn_core_unavailable':
          'මෙම යෙදුම් අනුවාදයේ භාවිත කළ හැකි OpenVPN එන්ජිමක් නොමැත.',
      'openvpn_operation_pending':
          'නේටිව් එන්ජිම තවමත් පෙර OpenVPN සැසිය රඳවා ගෙන ඇති අතර දෙවැන්නක් සෑදීම ප්‍රතික්ෂේප කරයි.',
      'openvpn_stop_timeout':
          'නියමිත කාලය තුළ එහි නේටිව් සැසිය නැවතී විනාශ වූ බව OpenVPN හරය තහවුරු කළේ නැත.',
      'openvpn_profile_unavailable':
          'මෙම සම්බන්ධතාව සඳහා තහවුරු කළ OpenVPN පැතිකඩක් කියවිය නොහැක.',
      'openvpn_native_failed':
          'යෙදුම් දෝෂයක් නිසා OpenVPN බාධාවට පත් විය. නැවත සම්බන්ධ වීමට උත්සාහ කරන්න. ගැටලුව දිගටම පවතී නම්, රෝග විනිශ්චයක් ක්‍රියාත්මක කරන්න.',
      'openvpn_key_generation_failed':
          'නිර්යාත කළ නොහැකි P-256 පෞද්ගලික යතුර සෑදීමට හෝ කියවීමට Android Keystore හට නොහැකි විය.',
      'openvpn_csr_generation_failed':
          'OpenVPN සහතික ඉල්ලීම අත්සන් කිරීමට Android Keystore යතුරට නොහැකි විය.',
      'openvpn_identity_store_failed':
          'OpenVPN සහතිකය හෝ පැතිකඩ ගුප්තකේතනය කළ ගබඩාවේ සුරැකීමට නොහැකි විය.',
      'openvpn_identity_clear_failed':
          'මෙම ගිණුම සඳහා උපාංගයේ OpenVPN අනන්‍යතාව සම්පූර්ණයෙන් ඉවත් කිරීමට Android හට නොහැකි විය.',
      'openvpn_identity_in_use':
          'නේටිව් OpenVPN සැසියක් තවමත් මෙම උපාංගයේ යතුර හෝ සහතිකය භාවිත කරයි.',
      'openvpn_tls_verification_required':
          'පැතිකඩ සේවාදායක සහතික සත්‍යාපනය පැහැදිලිව ඉල්ලා නොසිටී.',
      'openvpn_cipher_invalid':
          'සේවාදායකය අවසර ලත් ලැයිස්තුවේ නොමැති ගුප්තකේතන ඇල්ගොරිතමයක් සපයා ඇත.',
      'openvpn_profile_rejected':
          'සේවාදායකයෙන් ලැබුණු පැතිකඩ නොගැළපේ. මෙම උපාංගය නැවත සාදා නැවත උත්සාහ කරන්න.',
      'openvpn_identity_inconsistent':
          'සහතිකය මෙම දුරකථනයේ ආරක්ෂිත අනන්‍යතාවට නොගැළපේ. උපාංගයේ පැතිකඩ කිසිවක් ප්‍රතිස්ථාපනය නොකෙරුණි.',
      'tls_handshake_failed':
          'සේවාදායකය TLS සාකච්ඡාව ප්‍රතික්ෂේප කළේය. ගැටලුව දිගටම පවතී නම් පැතිකඩ නැවත සාදන්න.',
      'tls_alert_unknown_ca':
          'මෙම උපාංග සහතිකයේ අධිකාරිය සේවාදායකය හඳුනා නොගනී. OpenVPN සේවාදායකය පරීක්ෂා කළ යුතුයි.',
      'tls_alert_bad_certificate':
          'සේවාදායකය මෙම උපාංග සහතිකය ප්‍රතික්ෂේප කළේය. නැවත උත්සාහ කිරීමට පෙර උපාංගය නැවත සාදන්න.',
      'tls_alert_unsupported_certificate':
          'Android විසින් භාවිත කරන ආරක්ෂිත සහතික වර්ගය සේවාදායකය සහාය නොදක්වයි.',
      'tls_client_certificate_required':
          'සේවාදායකයට ක්ලයන්ට් සහතිකයක් අවශ්‍ය වුවද OpenVPN හරයට එය ඉදිරිපත් කළ නොහැකි විය.',
      'tls_alert_misc':
          'සේවාදායකය සහතික සහ අනුවාද ප්‍රවර්ගවලින් පිටත TLS අනතුරු ඇඟවීමක් ලබා දුන්නේය.',
      'tls_signature_algorithm_rejected':
          'Android Keystore යතුරේ ECDSA P-256 ඇල්ගොරිතමය සේවාදායකය ප්‍රතික්ෂේප කළේය.',
      'tls_handshake_rejected':
          'සම්බන්ධ වීමට පෙර සේවාදායකය TLS සාකච්ඡාවට බාධා කළේය.',
      'tls_version_rejected':
          'ක්ලයන්ට් සහ සේවාදායකය පොදු TLS අනුවාදයක් සොයා ගත්තේ නැත.',
      'tls_certificate_expired':
          'සම්බන්ධ වීමේදී ඉදිරිපත් කළ සහතිකය කල් ඉකුත් වී ඇත.',
      'tls_certificate_revoked':
          'සම්බන්ධ වීමේදී ඉදිරිපත් කළ සහතිකය අහෝසි කර ඇත.',
      'transport_failed':
          'වත්මන් ජාලය මත OpenVPN සේවාදායකය ප්‍රතිචාර නොදක්වයි. ටික වේලාවකින් නැවත උත්සාහ කරන්න.',
      'tun_configuration_rejected':
          'OpenVPN විසින් ඉල්ලූ ජාල වින්‍යාසය Android ප්‍රතික්ෂේප කළේය.',
      'tun_setup_failed':
          'Android අතුරුමුහුණත සෑදීමට පෙර ජාල සැලසුම OpenVPN හරය ප්‍රතික්ෂේප කළේය.',
      'tun_interface_create_failed':
          'Android VpnService වෙතින් TUN අතුරුමුහුණත ලබා ගැනීමට OpenVPN හරයට නොහැකි විය.',
      'tun_interface_disabled':
          'සම්බන්ධ වීමේදී Android හෝ OpenVPN හරය විසින් TUN අතුරුමුහුණත අක්‍රිය කරන ලදී.',
      'tun_halted': 'OpenVPN හරයට TUN අතුරුමුහුණත නැවැත්වීමේ ඉල්ලීමක් ලැබුණි.',
      'tun_already_established':
          'එම සම්බන්ධතාවේම දෙවන අතුරුමුහුණතක් OpenVPN ඉල්ලා සිටියේය. ආරක්ෂාව සඳහා ටනලය නවත්වන ලදී.',
      'tun_addresses_missing':
          'සේවාදායකය භාවිත කළ හැකි ටනල ලිපිනයක් සපයා නොමැත.',
      'tun_routes_missing': 'සේවාදායකය භාවිත කළ හැකි ටනල මාර්ග සපයා නොමැත.',
      'tun_dns_missing': 'සේවාදායකය භාවිත කළ හැකි DNS සේවාදායකයක් සපයා නොමැත.',
      'tun_permission_revoked': 'සම්බන්ධ වීමේදී Android VPN අවසරය ඉවත් කළේය.',
      'tun_establish_returned_null':
          'Android අතුරුමුහුණත සාදා නොමැත. සාමාන්‍යයෙන් හේතුව වෙනත් VPN සම්බන්ධතාවක් තවමත් ක්‍රියාකාරී වීමයි.',
      'openvpn_service_start_failed':
          'OpenVPN පෙරබිම් සේවාව ආරම්භ කිරීමට Android හට නොහැකි විය.',
      'openvpn_operation_timeout':
          'OpenVPN හරය වෙත JNI ඉල්ලීමක් එහි උපරිම කාලසීමාව ඉක්මවා ගියේය.',
      'openvpn_start_failed':
          'Android සේවාව සූදානම් වුවද, පැතිකඩ ආරම්භ කිරීම OpenVPN හරය පිළිගත්තේ නැත.',
      'openvpn_connection_failed':
          'CONNECTED සිදුවීම නිකුත් කිරීමට පෙර OpenVPN හරය නැවතුණි.',
      'openvpn_core_status_error':
          'වඩාත් නිශ්චිත අවසාන සිදුවීමක් නොමැතිව, නේටිව් OpenVPN ලූපය දෝෂයකින් අවසන් විය.',
      'openvpn_stopped_before_connected':
          'OpenVPN හරයෙන් පැහැදිලි දෝෂයක් නොමැතිව, CONNECTED වීමට පෙර නේටිව් OpenVPN ලූපය නැවතුණි.',
      'openvpn_auth_failed':
          'OpenVPN සේවාදායකය පැතිකඩ සත්‍යාපනය ප්‍රතික්ෂේප කළේය.',
      'openvpn_client_setup_failed':
          'ජාල සම්බන්ධතාවට පෙර ක්ලයන්ට් ආරම්භ කිරීමට OpenVPN හරයට නොහැකි විය.',
      'openvpn_client_halted':
          'OpenVPN හරයට ක්ලයන්ට් නවත්වන ලෙස අවසාන ඉල්ලීමක් ලැබුණි.',
      'openvpn_client_restart':
          'එහි ප්‍රවාහන සැසිය නැවත ආරම්භ කරන ලෙස OpenVPN හරය ඉල්ලා සිටියේය.',
      'openvpn_inactive_timeout':
          'අක්‍රියතා කාලසීමාව ඉක්මවීමෙන් පසු OpenVPN හරය සැසිය වසා දැමීය.',
      'openvpn_session_expired':
          'OpenVPN සැසිය කල් ඉකුත් වූ බව සේවාදායකය වාර්තා කළේය.',
      'openvpn_credentials_required':
          'සේවාදායකය හෝ ප්‍රොක්සියක් මෙම සහතික පැතිකඩේ කොටසක් නොවන අන්තර්ක්‍රියාකාරී අක්තපත්‍ර ඉල්ලයි.',
      'openvpn_proxy_failed':
          'වින්‍යාසගත ප්‍රොක්සිය හෝ රිලේ අසාර්ථක වූ බව OpenVPN හරය වාර්තා කළේය.',
      'openvpn_compression_failed':
          'පැතිකඩ හෝ සේවාදායකය විසින් නිවේදනය කළ සම්පීඩන ක්‍රමය OpenVPN හරය ප්‍රතික්ෂේප කළේය.',
      'openvpn_ntlm_crypto_unavailable':
          'මෙම අනුවාදයේ ලබා ගත නොහැකි NTLM ගුප්තකේතනයක් පැතිකඩ ඉල්ලයි.',
      'openvpn_feature_unsupported':
          'මෙම Android ක්ලයන්ට් හි නැති විශේෂාංගයක් පැතිකඩ හෝ සේවාදායකය ඉල්ලයි.',
      'network_unavailable': 'භාවිත කළ හැකි භෞතික ජාලයක් ලබා ගත නොහැක.',
      'network_lost': 'ජාලය නැති වීමෙන් පසු ටනලය නවත්වන ලදී.',
      'certificate_validation_failed':
          'OpenVPN සේවාදායක අනන්‍යතාව තහවුරු කළ නොහැකි විය.',
      'openvpn_certificate_expired':
          'OpenVPN සහතිකය කල් ඉකුත් වී ඇත. එය නවීකරණය කිරීමට යෙදුමේ නව සම්බන්ධතාවක් ආරම්භ කරන්න.',
      'tunnel_active_for_another_account':
          'මෙම සම්බන්ධතාවට පෙර වෙනත් ගිණුමකට අයත් ටනලයක් නැවතිය යුතුයි.',
      'tunnel_already_active':
          'පෙර VPN සැසියක් තවමත් අතුරුමුහුණත භාවිත කරන බව Android වාර්තා කරයි.',
      'tunnel_stop_timeout':
          'නියමිත කාලය තුළ VPN අතුරුමුහුණත නිදහස් කිරීම $protocol එන්ජිම තහවුරු කළේ නැත.',
      'tunnel_disconnected':
          'ආරම්භ වීමෙන් පසු ටනලය අනපේක්ෂිතව අවසන් වූ බව නේටිව් එන්ජිම වාර්තා කළේය.',
      'native_bridge_unavailable':
          'යෙදුමට Android VPN සේවාවට ප්‍රවේශ විය නොහැක. යෙදුම වසා නැවත විවෘත කර, ඉන්පසු නැවත උත්සාහ කරන්න.',
      'native_operation_failed':
          'යෙදුම් දෝෂයක් නිසා VPN මෙහෙයුම බාධාවට පත් විය. නැවත උත්සාහ කරන්න. ගැටලුව දිගටම පවතී නම්, රෝග විනිශ්චයක් ක්‍රියාත්මක කරන්න.',
      'invalid_arguments':
          'මෙම VPN මෙහෙයුම සඳහා අවශ්‍ය තොරතුරු අසම්පූර්ණයි. නැවත උත්සාහ කරන්න. ගැටලුව දිගටම පවතී නම්, රෝග විනිශ්චයක් ක්‍රියාත්මක කරන්න.',
      'invalid_account_id':
          'නේටිව් මෙහෙයුම වලංගු ගිණුම් හඳුනාගැනීමකට සම්බන්ධ කර නැත.',
      'invalid_device_id':
          'නේටිව් එන්ජිමට යවන ලද උපාංග හඳුනාගැනීම නැති හෝ වලංගු නොවේ.',
      'storage_key_not_allowed':
          'අවසර ලත් ගබඩා ලැයිස්තුවෙන් පිටත යතුරක් Android පාලමෙන් අවහිර කරන ලදී.',
      'secure_storage_read_failed':
          'මෙම ගිණුමේ උපාංගයේ දත්ත විකේතනය කිරීමට Android Keystore හට නොහැකි විය.',
      'secure_storage_write_failed':
          'උපාංගයේ දත්ත ගුප්තකේතනය කිරීමට හෝ සුරැකීමට Android Keystore හට නොහැකි විය.',
      'key_generation_failed':
          'ආරක්ෂිත ගබඩාවේ WireGuard යතුර සෑදීමට හෝ කියවීමට Android හට නොහැකි විය.',
      'csr_generation_failed':
          'OpenVPN P-256 CSR සෑදීමට හෝ අත්සන් කිරීමට Android Keystore හට නොහැකි විය.',
      'other':
          'ලේඛනගත නොකළ නේටිව් ශාඛාවක් අසාර්ථක විය. පහත පෙන්වා ඇති රෝග විනිශ්චය කේතය සහාය අංශයට යවන්න.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'අවසර ඉල්ලීම දැනටමත් විවෘතයි';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN අවසර ඉල්ලීම දැනටමත් පෙන්වා ඇත. නැවත උත්සාහ කිරීමට පෙර එය සම්පූර්ණ කරන්න.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN අවසර ඉල්ලීම බාධාවට පත් විය';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'යෙදුමට පිළිතුරක් ලැබීමට පෙර VPN අවසර තිරය වසා දමන ලදී.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN සම්බන්ධතාව තහවුරු වී නැත';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN සම්බන්ධතාව තහවුරු කළ නොහැකි විය. ආරක්ෂාව සඳහා එය නවතා ඇත. නැවත උත්සාහ කරන්න.';

  @override
  String get openvpnCleanup_title => 'OpenVPN පැතිකඩ අහෝසි කර ඇත';

  @override
  String get openvpnCleanup_working =>
      'අහෝසි කළ OpenVPN පැතිකඩ නවත්වා ඉවත් කරමින්…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN නැවතීම තහවුරු වී නැත. නව පැතිකඩ සෑදීමට පෙර නැවත උත්සාහ කරන්න.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'අහෝසි කළ OpenVPN පැතිකඩ සම්පූර්ණයෙන් ඉවත් කළ නොහැකි විය. පිරිසිදු කිරීම නැවත උත්සාහ කරන්න.';

  @override
  String get openvpnCleanup_complete =>
      'අහෝසි කළ OpenVPN පැතිකඩ ඉවත් කර ඇත. නව එකක් සෑදීමට සම්බන්ධ වන්න තට්ටු කරන්න.';

  @override
  String get network_title => 'ජාල වින්‍යාසය';

  @override
  String get network_ipv4Fallback =>
      'IPv6 තාවකාලිකව ලබා ගත නොහැක. සූදානම් කිරීම IPv4 සමඟ දිගටම සිදු වේ.';

  @override
  String get network_rejectedTitle => 'ජාල වින්‍යාසය ප්‍රතික්ෂේප විය';

  @override
  String get network_rejectedMessage =>
      'ටනලයේ වින්‍යාසය අසම්පූර්ණයි හෝ අනුමත ලිපින සමඟ නොගැළපේ. යෙදුමෙන් නැවත උත්සාහ කරන්න.';

  @override
  String get network_unreadableTitle => 'උපාංගයේ වින්‍යාසය කියවිය නොහැක';

  @override
  String get network_unreadableMessage =>
      'සුරැකූ OpenVPN ජාල වින්‍යාසය භාවිත කළ නොහැක. එය යාවත්කාලීන කිරීමට යෙදුමෙන් නැවත සම්බන්ධ වන්න.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ජාල ආරක්ෂණය';

  @override
  String get protection_subtitle =>
      'VPN විසන්ධි වුවහොත් සෘජු අන්තර්ජාල ප්‍රවේශය අවහිර කරන්න.';

  @override
  String get protection_active => 'පද්ධති ආරක්ෂණය සක්‍රියයි';

  @override
  String get protection_alwaysOnOnly =>
      'සැමවිටම ක්‍රියාකාරී VPN සක්‍රියයි, VPN නොමැතිව සම්බන්ධතා අවහිර කිරීම සක්‍රිය කරන්න';

  @override
  String get protection_inactive => 'පද්ධති ආරක්ෂණය අක්‍රියයි';

  @override
  String get protection_unknown => 'පද්ධති ආරක්ෂණය පරීක්ෂා කරන්න';

  @override
  String get protection_openSettings => 'Android සැකසුම් විවෘත කරන්න';

  @override
  String get protection_dialogTitle => 'ජාල ආරක්ෂණය සකසන්න';

  @override
  String get protection_dialogMessage =>
      'Android මගින් සැමවිටම ක්‍රියාකාරී VPN සහ VPN නොමැතිව සම්බන්ධතා අවහිර කිරීම කළමනාකරණය කරයි. FuzeVPN තෝරාගෙන ඇත්දැයි පරීක්ෂා කර, පද්ධති සැකසුම්වල අවහිර කිරීම සක්‍රිය කරන්න.';

  @override
  String get protection_dialogOpen => 'සැකසුම් විවෘත කරන්න';

  @override
  String get session_systemProtectionNote =>
      'Android තවමත් VPN නොමැතිව ට්‍රැෆික් අවහිර කරන්නේ නම්, මෙම ආරක්ෂණය පරීක්ෂා කිරීමට හෝ වෙනස් කිරීමට පද්ධති සැකසුම් විවෘත කරන්න.';

  @override
  String get diagnostics_title => 'රෝග විනිශ්චය';

  @override
  String get diagnostics_settingsTitle => 'යෙදුමේ රෝග විනිශ්චය';

  @override
  String get diagnostics_automaticTitle => 'වැදගත් දෝෂ යවන්න';

  @override
  String get diagnostics_automaticDescription =>
      'වැදගත් දෝෂයක් ඇති වූ විට කුඩා තාක්ෂණික වාර්තාවක් බෙදාගන්න.';

  @override
  String get diagnostics_privacy =>
      'යවන ලද වාර්තා ඔබ පිවිසී සිටින ගිණුම සමඟ සම්බන්ධ කර දින 30ක් තබා ගනු ලැබේ. ඒවායේ බ්‍රවුස් කිරීමේ ඉතිහාසය, මුරපද හෝ VPN යතුරු අඩංගු නොවේ.';

  @override
  String get diagnostics_manualOpen => 'රෝග විනිශ්චය ක්‍රියාත්මක කරන්න';

  @override
  String get diagnostics_localDescription =>
      'යෙදුම සහ VPN තත්ත්වය පිළිබඳ වාර්තාවක් සාදන්න. ඔබේ සම්බන්ධතාව වෙනස් නොවේ.';

  @override
  String get diagnostics_sendReport => 'වාර්තාව යවන්න';

  @override
  String get diagnostics_sendHint =>
      'වාර්තාව මෙම උපාංගයේ තබා ගැනීමට මෙම කොටුව සලකුණු නොකර තබන්න.';

  @override
  String get diagnostics_signedOut => 'වාර්තාවක් යැවීමට ඔබේ ගිණුමට පිවිසෙන්න.';

  @override
  String get diagnostics_localLifetime =>
      'යෙදුම වසා දැමූ පසුත් එය තබා ගැනීමට මෙම වාර්තාව ඔබේ දුරකථනයේ සුරකින්න.';

  @override
  String get diagnostics_run => 'රෝග විනිශ්චය ක්‍රියාත්මක කරන්න';

  @override
  String get diagnostics_rerun => 'රෝග විනිශ්චය නැවත ක්‍රියාත්මක කරන්න';

  @override
  String get diagnostics_running => 'පරීක්ෂා කරමින්…';

  @override
  String get diagnostics_sending => 'වාර්තාව යවමින්…';

  @override
  String get diagnostics_prepared => 'වාර්තාව මෙම උපාංගයේ සූදානම්';

  @override
  String get diagnostics_queued => 'වාර්තාව යැවීමට රැඳී සිටී';

  @override
  String get diagnostics_sent => 'වාර්තාව ලැබුණි';

  @override
  String get diagnostics_failed =>
      'යැවීම අසාර්ථක විය. ඔබේ උපාංගයේ වාර්තාව තවමත් ලබා ගත හැක.';

  @override
  String get diagnostics_preparationFailed =>
      'රෝග විනිශ්චය වාර්තාව සූදානම් කළ නොහැකි විය. නැවත උත්සාහ කරන්න.';

  @override
  String get diagnostics_authenticationRequired =>
      'වාර්තාව යැවීමට නැවත පිවිසෙන්න.';

  @override
  String get diagnostics_retry => 'යැවීම නැවත උත්සාහ කරන්න';

  @override
  String get diagnostics_export => 'වාර්තාව සුරකින්න';

  @override
  String get diagnostics_exportFailed =>
      'සුරැකීම අසාර්ථක විය. උපාංගයේ වාර්තාවෙන් නැවත උත්සාහ කරන්න.';

  @override
  String get diagnostics_preferenceFailed =>
      'මෙම සැකසුම සුරැකිය නොහැකි විය. නැවත උත්සාහ කරන්න.';

  @override
  String diagnostics_receipt(Object id) {
    return 'යොමුව: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date දින ලැබුණි';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date දක්වා තබා ගනු ලැබේ';
  }

  @override
  String get diagnostics_duplicate => 'මෙම වාර්තාව දැනටමත් ලැබී තිබුණි.';

  @override
  String get diagnostics_preview => 'වාර්තාවේ පෙරදසුන';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'තාක්ෂණික සිදුවීම් $countක් අමුණා ඇත',
      one: 'තාක්ෂණික සිදුවීමක් අමුණා ඇත',
      zero: 'තාක්ෂණික සිදුවීම් අමුණා නැත',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'තාක්ෂණික විස්තර';

  @override
  String get diagnostics_empty =>
      'රෝග විනිශ්චය වාර්තාවක් තවමත් සූදානම් කර නැත.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ටනලයේ තත්ත්වය',
      'handshake': 'සම්බන්ධතාව තහවුරු කිරීම',
      'certificate': 'VPN සහතිකය',
      'kill_switch': 'Android ආරක්ෂණය',
      'connectivity': 'ලබා ගත හැකි ජාලය',
      'api_reachability': 'සේවා ප්‍රවේශය',
      'secure_storage': 'ආරක්ෂිත ගබඩාව',
      'other': 'උපාංග පරීක්ෂාව',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'පරීක්ෂා කර ඇත',
      'failed': 'අවධානය අවශ්‍යයි',
      'skipped': 'පරීක්ෂා කර නැත — සක්‍රිය පරීක්ෂාවක් නැත',
      'unknown': 'තොරතුරු ලබා ගත නොහැක',
      'other': 'තොරතුරු ලබා ගත නොහැක',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN වෙත සාදරයෙන් පිළිගනිමු';

  @override
  String get connection_changeLocation => 'ස්ථානය වෙනස් කරන්න';

  @override
  String get connection_details => 'සම්බන්ධතා විස්තර';

  @override
  String get locations_searchLabel => 'නගරයක් හෝ රටක් සොයන්න';

  @override
  String get locations_clearSearch => 'සෙවීම මකන්න';

  @override
  String get locations_filterAll => 'සියල්ල';

  @override
  String get locations_filterFavorites => 'ප්‍රියතම';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ස්ථාන',
      one: '$count ස්ථානය',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'ස්ථාන හමු නොවීය';

  @override
  String get locations_noResultsHint => 'වෙනත් නගරයක් හෝ රටක් උත්සාහ කරන්න.';

  @override
  String get locations_noFavorites => 'ඔබේ ප්‍රියතම ස්ථාන, අත ළඟම';

  @override
  String get locations_noFavoritesHint =>
      'ස්ථානයක් මෙහි සුරැකීමට, එය අසල ඇති තරුව තට්ටු කරන්න.';

  @override
  String get locations_showAll => 'සියලු ස්ථාන බලන්න';

  @override
  String locations_addFavorite(String name) {
    return '$name ප්‍රියතමවලට එකතු කරන්න';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$name ප්‍රියතමවලින් ඉවත් කරන්න';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'ප්‍රියතම සුරැකිය නොහැකි විය. නැවත උත්සාහ කරන්න.';

  @override
  String get locations_emptyTitle => 'ලබා ගත හැකි ස්ථාන නැත';

  @override
  String get locations_emptyHint =>
      'නැවත උත්සාහ කිරීමට ලැයිස්තුව නැවුම් කරන්න.';

  @override
  String get devices_manage => 'මගේ උපාංග කළමනාකරණය කරන්න';

  @override
  String get settings_personalization => 'ඔබ කැමති ආකාරයට සකසන්න';

  @override
  String get settings_safety => 'ආරක්ෂණය';

  @override
  String get settings_help => 'උපකාරය අවශ්‍යද?';

  @override
  String get settings_about => 'FuzeVPN ගැන';

  @override
  String get diagnostics_heading => 'සම්බන්ධතා ගැටලුවක් තේරුම් ගන්න';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ලබා ගත හැකියි',
      'pending': 'සූදානම් වෙමින්',
      'revoked': 'ඉවත් කර ඇත',
      'expired': 'කල් ඉකුත් වී ඇත',
      'other': 'තත්ත්වය ලබා ගත නොහැක',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'මනාපය සුරැකුණේ නැත';

  @override
  String get notice_preferenceSave_message =>
      'ඔබේ තේරීම දැනට යොදා ඇත, නමුත් එය සුරැකිය නොහැකි විය. යෙදුම වසා දැමූ පසුත් එය තබා ගැනීමට නැවත උත්සාහ කරන්න.';

  @override
  String get connection_androidDisconnectHint =>
      'Android මගින් VPN සක්‍රියව තබා ගන්නේ නම්, විවෘත වන සැකසුම්වල සැමවිටම ක්‍රියාකාරී VPN අක්‍රිය කරන්න.';

  @override
  String get connection_certificate => 'OpenVPN සහතිකය';

  @override
  String connection_certificateValidUntil(Object date) {
    return '$date දක්වා වලංගුයි';
  }

  @override
  String connection_certificateExpired(Object date) {
    return '$date දින කල් ඉකුත් විය';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'ඊළඟ වර සම්බන්ධ වීමේදී ස්වයංක්‍රීයව නවීකරණය වේ.';

  @override
  String get protection_learnMore => 'Android ආරක්ෂණය ගැන දැනගන්න';

  @override
  String get protection_guideWhy =>
      'මෙම ආරක්ෂණය VPN විසන්ධි වුවහොත් යෙදුම් සෘජුවම අන්තර්ජාලය භාවිත කිරීම වළක්වයි. එය Android හි සකස් කෙරේ.';

  @override
  String get protection_guideAlwaysOnTitle => 'සැමවිටම ක්‍රියාකාරී VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android මගින් VPN සේවාව ක්‍රියාත්මකව තබා ගන්නා අතර දුරකථනය යළි ආරම්භ වූ පසු එය නැවත ක්‍රියාත්මක කළ හැක.';

  @override
  String get protection_guideBlockTitle => 'VPN නොමැතිව සම්බන්ධතා අවහිර කරන්න';

  @override
  String get protection_guideBlock =>
      'සම්බන්ධතාවට බාධා වන අවස්ථාවල ඇතුළුව, ට්‍රැෆික් VPN මඟ හැර යාම මෙම සැකසුම වළක්වයි.';

  @override
  String get protection_guideWarning =>
      'මෙම අවහිර කිරීම සක්‍රිය කර ඇති විට, VPN සම්බන්ධ වන තුරු අන්තර්ජාල ප්‍රවේශය අවහිර වී පවතී.';

  @override
  String get protection_guideStepsTitle => 'ආරක්ෂණය සක්‍රිය කරන්න';

  @override
  String get protection_guideStep1 =>
      'පහත බොත්තම භාවිතයෙන් Android VPN සැකසුම් විවෘත කරන්න.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN අසල ඇති ගියර් නිරූපකය ඔස්සේ විකල්ප විවෘත කරන්න.';

  @override
  String get protection_guideStep3 =>
      'මෙම විකල්ප තිබේ නම්, සැමවිටම ක්‍රියාකාරී VPN සක්‍රිය කර, ඉන්පසු VPN නොමැතිව සම්බන්ධතා අවහිර කරන්න සක්‍රිය කරන්න.';

  @override
  String get protection_guideManufacturers =>
      'මෙම විකල්පවල නම් දුරකථනය අනුව වෙනස් වේ. අවශ්‍ය නම්, සැකසුම් තුළ VPN සොයන්න. බොහෝ විට එය ජාලය සහ අන්තර්ජාලය යටතේ පිහිටයි.';

  @override
  String get protection_guideDisableTitle => 'මෙම ආරක්ෂණය අක්‍රිය කරන්න';

  @override
  String get protection_guideDisable =>
      'එම සැකසුම් තුළම, VPN නොමැතිව අන්තර්ජාල ප්‍රවේශයට ඉඩ දීමට VPN නොමැතිව සම්බන්ධතා අවහිර කිරීම අක්‍රිය කරන්න. Android එය නැවත ආරම්භ කිරීම ඔබට අවශ්‍ය නොවේ නම්, සැමවිටම ක්‍රියාකාරී VPN ද අක්‍රිය කරන්න.';

  @override
  String get protection_guideManual =>
      'මෙම සැකසුම් ඔබ විසින් Android හිදී තෝරා ගනු ලැබේ. FuzeVPN ඒවා ඔබ වෙනුවෙන් වෙනස් නොකරයි.';

  @override
  String get locations_changeTitle => 'ස්ථානය වෙනස් කරන්නද?';

  @override
  String locations_changeActive(String name) {
    return 'VPN විසන්ධි වී, ඉන්පසු $name වෙත සම්බන්ධ වීමට උත්සාහ කරයි.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name වෙත සම්බන්ධ වීමට උත්සාහ කරයි.';
  }

  @override
  String get locations_confirmChange => 'වෙනස් කර සම්බන්ධ වන්න';

  @override
  String get locations_changeBusy =>
      'වෙනසක් සිදු වෙමින් පවතී. වෙනත් ස්ථානයක් තේරීමට පෙර රැඳී සිටින්න.';

  @override
  String get locations_automaticSelection => 'ස්වයංක්‍රීය තේරීම';

  @override
  String get locations_cities => 'නගර';

  @override
  String get locations_servers => 'සේවාදායකයන්';

  @override
  String locations_viewCities(String name) {
    return '$name හි නගර බලන්න';
  }

  @override
  String locations_viewServers(String name) {
    return '$name හි සේවාදායකයන් බලන්න';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count රටවල්',
      one: '$count රට',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count නගර',
      one: '$count නගරය',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count සේවාදායකයන්',
      one: '$count සේවාදායකය',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'සියලුම රටවල්';

  @override
  String get locations_backToCountries => 'රටවල් වෙත ආපසු යන්න';

  @override
  String locations_backToCities(String name) {
    return '$name හි නගර වෙත ආපසු යන්න';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name තෝරන්න';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name තෝරන්න';
  }

  @override
  String get locations_noCompatibleServer => 'අනුකූල සේවාදායකයක් ලබා ගත නොහැක.';

  @override
  String get externalLink_failed =>
      'මෙම සබැඳිය විවෘත කළ නොහැක. ඔබට එය පිටපත් කර ඔබේ බ්‍රවුසරයෙන් විවෘත කළ හැක.';

  @override
  String get externalLink_copy => 'සබැඳිය පිටපත් කරන්න';

  @override
  String get externalLink_copied => 'සබැඳිය පිටපත් කරන ලදී';

  @override
  String get externalLink_copyFailed =>
      'සබැඳිය පිටපත් කළ නොහැක. පහත ලිපිනය තෝරන්න.';

  @override
  String get settings_deleteAccount => 'මගේ ගිණුම මකන්න';

  @override
  String get settings_deleteAccountDetail =>
      'ගිණුම මැකීමේ ඉල්ලීම් ක්‍රියාපටිපාටිය බලන්න';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'ඔබේ VPN දායකත්වය තෝරන්න.';

  @override
  String get billing_subscribe => 'දායක වන්න';

  @override
  String get billing_choosePlan => 'ඉදිරියට යාමට සැලසුමක් තෝරන්න.';

  @override
  String get billing_monthly => 'මාසික';

  @override
  String get billing_yearly => 'වාර්ෂික';

  @override
  String get billing_continue => 'Google Play සමඟ ඉදිරියට යන්න';

  @override
  String get billing_restore => 'මිලදී ගැනීම් ප්‍රතිසාධනය කරන්න';

  @override
  String get billing_manage => 'දායකත්වය කළමනාකරණය කරන්න';

  @override
  String get billing_deleteAccountWarning =>
      'ඔබට Google Play දායකත්වයක් ඇත්නම්, ඔබේ FuzeVPN ගිණුම මැකීමෙන් එහි නවීකරණය අවලංගු නොවේ. Google Play හි නවීකරණය වෙන වෙනම කළමනාකරණය කරන්න හෝ අවලංගු කරන්න.';

  @override
  String get billing_deleteAccountContinue =>
      'ගිණුම මැකීමේ ඉල්ලීම වෙත ඉදිරියට යන්න';

  @override
  String get billing_refresh => 'ප්‍රවේශය නැවුම් කරන්න';

  @override
  String get billing_loadingPlans => 'සැලසුම් පූරණය වෙමින්…';

  @override
  String get billing_unavailable =>
      'දැනට සැලසුම් ලබා ගත නොහැක. පසුව නැවත උත්සාහ කරන්න.';

  @override
  String get billing_comingSoon => 'දායකත්වයන් ඉක්මනින් පැමිණේ.';

  @override
  String get billing_priceDisclosure =>
      'මිල Google Play විසින් ලබා දෙයි. ඔබ තහවුරු කිරීමට පෙර අවසන් මුදල සහ අදාළ බදු තහවුරු කෙරේ.';

  @override
  String get billing_renewalMonthly =>
      'අවලංගු නොකළහොත් සෑම මාසයකම ස්වයංක්‍රීයව නවීකරණය වේ. Google Play දායකත්වයන් තුළ ඕනෑම වේලාවක අවලංගු කළ හැක.';

  @override
  String get billing_renewalYearly =>
      'අවලංගු නොකළහොත් සෑම වසරකම ස්වයංක්‍රීයව නවීකරණය වේ. Google Play දායකත්වයන් තුළ ඕනෑම වේලාවක අවලංගු කළ හැක.';

  @override
  String get billing_active => 'ඔබේ Premium ප්‍රවේශය සක්‍රියයි';

  @override
  String billing_accessUntil(String date) {
    return '$date දක්වා ප්‍රවේශය.';
  }

  @override
  String get billing_webManaged =>
      'ඔබේ දායකත්වය FuzeVPN වෙබ් අඩවියේ කළමනාකරණය වේ.';

  @override
  String get billing_playManaged =>
      'ඔබේ දායකත්වය Google Play විසින් කළමනාකරණය කෙරේ.';

  @override
  String get billing_playOnHold =>
      'ඔබේ Google Play දායකත්වය අත්හිටුවා ඇත හෝ ගෙවීම බලා සිටී. Google Play හි එය නිවැරදි කිරීමට “දායකත්වය කළමනාකරණය කරන්න” විවෘත කරන්න.';

  @override
  String get billing_playReceiptUnlinked =>
      'මෙම Google Play ගිණුමට දැනටමත් මෙම FuzeVPN ගිණුම සඳහා සක්‍රිය නොවන Fuze Premium දායකත්වයක් ඇත. Google Play හි එය පරීක්ෂා කිරීමට “දායකත්වය කළමනාකරණය කරන්න” විවෘත කරන්න.';

  @override
  String get billing_inactive => 'සක්‍රිය දායකත්වයක් නැත.';

  @override
  String get billing_checkingAccess => 'ඔබේ ප්‍රවේශය පරීක්ෂා කරමින්…';

  @override
  String get billing_restoring => 'මිලදී ගැනීම් ප්‍රතිසාධනය කරමින්…';

  @override
  String get billing_pending =>
      'ගෙවීම තවමත් අවසන් වී නැත. තහවුරු කිරීමෙන් පසු ඔබේ ප්‍රවේශය සක්‍රිය වේ.';

  @override
  String get billing_cancelled =>
      'මිලදී ගැනීම අවලංගු කරන ලදී. නව දායකත්වයක් සක්‍රිය කෙරුණේ නැත.';

  @override
  String get billing_verifying => 'මිලදී ගැනීම සත්‍යාපනය කරමින්…';

  @override
  String get billing_success =>
      'දායකත්වය සක්‍රිය කරන ලදී. ඔබේ Premium ප්‍රවේශය සූදානම්.';

  @override
  String get billing_restored => 'ඔබේ මිලදී ගැනීම් ප්‍රතිසාධනය කරන ලදී.';

  @override
  String get billing_restoreEmpty =>
      'මෙම Google Play ගිණුම සඳහා ප්‍රතිසාධනය කළ යුතු මිලදී ගැනීම් නැත.';

  @override
  String get billing_catalogError =>
      'සැලසුම් පූරණය කළ නොහැක. නැවත උත්සාහ කරන්න.';

  @override
  String get billing_purchaseError =>
      'මිලදී ගැනීම ආරම්භ කළ නොහැක. නැවත උත්සාහ කරන්න.';

  @override
  String get billing_verificationError =>
      'මිලදී ගැනීම් සත්‍යාපනය තාවකාලිකව ලබා ගත නොහැක. නැවත උත්සාහ කිරීමට මිලදී ගැනීම් ප්‍රතිසාධනය කරන්න.';

  @override
  String get billing_restoreError =>
      'මිලදී ගැනීම් ප්‍රතිසාධනය කළ නොහැක. නැවත උත්සාහ කරන්න.';

  @override
  String get billing_managementError =>
      'දායකත්ව කළමනාකරණය විවෘත කළ නොහැක. නැවත උත්සාහ කරන්න.';

  @override
  String get billing_storeUnavailable =>
      'මෙම උපාංගයේ Google Play ලබා ගත නොහැක.';

  @override
  String get welcome_title => 'ඔබේ VPN, සරලව.';

  @override
  String get welcome_description =>
      'ඔබේ සම්බන්ධතාව ආරක්ෂා කරන්න. ඔබේ රහස්‍යතාව ඔබේ පාලනය යටතේ තබා ගන්න.';

  @override
  String get welcome_start => 'ආරම්භ කරන්න';

  @override
  String get welcome_alreadyPurchased => 'දැනටමත් මිලදී ගෙන තිබේද?';

  @override
  String get welcome_noAccountRequired => 'ආරම්භ කිරීමට ගිණුමක් අවශ්‍ය නොවේ.';

  @override
  String get guest_accountTitle => 'ගිණුම සම්බන්ධ කර නැත';

  @override
  String get guest_accountDescription =>
      'වෙනත් උපාංගයක ඔබේ දායකත්වය භාවිත කිරීමට, එකම Google Play ගිණුම සමඟ ඔබේ මිලදී ගැනීම් ප්‍රතිසාධනය කරන්න.';

  @override
  String get guest_existingSubscriberSignIn =>
      'දැනටමත් දායක වී ඇද්ද? ගිණුමට පිවිසෙන්න';

  @override
  String get guest_claimTitle => 'FuzeVPN ඔබ සමඟ රැගෙන යන්න';

  @override
  String get guest_claimDescription =>
      'ඔබේ අනෙකුත් උපාංගවල ඔබේ දායකත්වය වෙත ප්‍රවේශ වීමට ගිණුමක් සාදන්න. මෙම පියවර විකල්පයි.';

  @override
  String get guest_skip => 'පසුව';

  @override
  String get guest_activationTitle => 'Fuze Premium සක්‍රිය වී ඇත';

  @override
  String get guest_activationDescription =>
      'ඔබේ දායකත්වය සූදානම්. ඔබේ VPN භාවිත කරන්න, ඔබට ඕනෑම වේලාවක ගිණුමක් සාදා ගත හැක.';

  @override
  String get guest_useVpn => 'මගේ VPN භාවිත කරන්න';

  @override
  String get guest_loginRequired =>
      'මෙම මිලදී ගැනීම දැනටමත් FuzeVPN ගිණුමකට සම්බන්ධ කර ඇත. ඔබේ දායකත්වය වෙත ප්‍රවේශ වීමට එම ගිණුමට පිවිසෙන්න.';

  @override
  String get guest_signOutWarning =>
      'එකම Google Play ගිණුම සමඟ මිලදී ගැනීම් ප්‍රතිසාධනය කිරීමෙන් ඔබේ දායකත්වය යළි ලබා ගත හැක.';

  @override
  String get guest_profileUnavailable =>
      'ඔබේ ගිණුම දැනටමත් සම්බන්ධ කර ඇත. ඔබේ තොරතුරු බැලීමට සහ කළමනාකරණය කිරීමට පිවිසෙන්න.';

  @override
  String get billing_acceptance =>
      'ඉදිරියට යාමෙන්, ඔබ භාවිත නියමයන් සහ රහස්‍යතා ප්‍රතිපත්තිය පිළිගනී.';

  @override
  String get guest_verifyEmailReminder =>
      'ඔබේ ගිණුම ආරක්ෂා කිරීමට ඔබේ ඊමේල් ලිපිනය තහවුරු කරන්න. ඔබට ඔබේ VPN භාවිත කිරීම දිගටම කරගෙන යා හැක.';

  @override
  String get guest_serviceUnavailable =>
      'සේවාව තාවකාලිකව ලබා ගත නොහැක. ඉක්මනින් නැවත උත්සාහ කරන්න.';

  @override
  String get guest_restoreError =>
      'ඔබේ මිලදී ගැනීම් ප්‍රතිසාධනය කළ නොහැකි විය. මිලදී ගැනීමට භාවිත කළ Google Play ගිණුම සමඟ නැවත උත්සාහ කරන්න.';

  @override
  String get guest_claimSuccess =>
      'ඔබේ ගිණුම සාදා ඇත. ඔබේ දායකත්වය සහ VPN ප්‍රවේශය ආරක්ෂිතව පවතී.';

  @override
  String get guest_emailExists =>
      'මෙම ඊමේල් ලිපිනය දැනටමත් භාවිතයේ ඇත. වෙනත් ලිපිනයක් තෝරන්න හෝ ඔබේ දැනට පවතින ගිණුමට පිවිසෙන්න. ඔබේ මිලදී ගැනීම Google Play හරහා තවමත් ලබා ගත හැක.';

  @override
  String get guest_claimError =>
      'ඔබේ ගිණුම සාදා ගත නොහැකි විය. ඔබට ඔබේ VPN භාවිත කිරීම දිගටම කරගෙන යා හැකි අතර පසුව නැවත උත්සාහ කළ හැක.';

  @override
  String get guest_secureStorageError =>
      'මෙම උපාංගයේ ඔබේ සැසිය ආරක්ෂිත කළ නොහැකි විය. නැවත උත්සාහ කරන්න.';

  @override
  String get guest_premiumRequired =>
      'ඔබේ VPN සක්‍රිය කිරීමට දායකත්වයක් තෝරන්න.';

  @override
  String get welcome_viewPlans => 'සැලසුම් බලන්න';

  @override
  String get google_continue => 'Google සමඟ ඉදිරියට යන්න';

  @override
  String get google_or => 'හෝ';

  @override
  String get google_title => 'ඔබේ FuzeVPN ගිණුම';

  @override
  String get google_settingUp => 'ඔබේ ගිණුම සෑදීම සම්පූර්ණ කරන්න';

  @override
  String get google_country => 'පදිංචි රට';

  @override
  String get google_profileDescription =>
      'ඔබේ FuzeVPN ගිණුම සෑදීමට ඔබේ රට තෝරා ලේඛන දෙක පරීක්ෂා කර බලන්න.';

  @override
  String get google_claimDescription =>
      'ඔබේ අමුත්තා ගිණුම Google සමඟ සම්බන්ධ කරන්න. ඔබේ දායකත්වය සහ උපාංගය මෙම ගිණුමට සම්බන්ධව පවතී.';

  @override
  String get google_linkTitle => 'Google, FuzeVPN වෙත සම්බන්ධ කරන්න';

  @override
  String get google_linkDescription =>
      'ඔබේ දැනට පවතින FuzeVPN ගිණුම වෙත ප්‍රවේශය තහවුරු කරන්න. මෙම පියවරට ඔබේ Google මුරපදය අවශ්‍ය නොවේ.';

  @override
  String get google_password => 'FuzeVPN මුරපදය';

  @override
  String get google_linkAccount => 'සම්බන්ධතාව තහවුරු කරන්න';

  @override
  String get google_requestEmail => 'තහවුරු කිරීමේ ඊමේල් පණිවිඩයක් එවන්න';

  @override
  String get google_emailInstructions =>
      'FuzeVPN ඊමේල් පණිවිඩය විවෘත කර තහවුරු කිරීමේ කේතය ඇතුළු කරන්න.';

  @override
  String get google_emailCode => 'ඊමේල් තහවුරු කිරීමේ කේතය';

  @override
  String get google_confirmEmail => 'කේතය තහවුරු කරන්න';

  @override
  String get google_restart => 'වෙනත් Google ගිණුමක් තෝරන්න';

  @override
  String get google_resume => 'මෙම උත්සාහය පරීක්ෂා කරන්න';

  @override
  String get google_unavailable =>
      'Google මගින් පිවිසීම ලබා ගත නොහැක. ඔබට ඊමේල් සහ මුරපදය භාවිත කළ හැක.';

  @override
  String get google_expired =>
      'මෙම උත්සාහය කල් ඉකුත් වී ඇත. එය අවලංගු කර නැවත ආරම්භ කරන්න.';

  @override
  String get google_conflict =>
      'මෙම Google ගිණුම දැනටමත් වෙනත් තැනක සම්බන්ධ කර ඇත. ඔබේ වත්මන් ගිණුම සහ දායකත්වය රැඳී ඇත.';

  @override
  String get google_error =>
      'Google මගින් පිවිසීම අසාර්ථක විය. නැවත උත්සාහ කරන්න. ඔබේ වත්මන් ප්‍රවේශය රැඳී ඇත.';

  @override
  String get google_uncertain =>
      'ප්‍රතිඵලය තහවුරු කළ නොහැකි විය. නැවත ආරම්භ කිරීමට පෙර මෙම උත්සාහය පරීක්ෂා කරන්න හෝ අවලංගු කරන්න.';

  @override
  String get google_cancelFailed =>
      'අවලංගු කිරීම තහවුරු කළ නොහැකි විය. මෙම තිරයෙන් පිටව යාමට පෙර නැවත අවලංගු කිරීමට උත්සාහ කරන්න.';

  @override
  String get google_cancelled => 'Google මගින් පිවිසීම අවලංගු කරන ලදී.';

  @override
  String get google_selecting => 'ඔබේ Google ගිණුම තෝරමින්…';

  @override
  String get google_verifying => 'ඔබේ ගිණුම පරීක්ෂා කරමින්…';

  @override
  String get google_emailUnavailable =>
      'තහවුරු කිරීමේ ඊමේල් යැවිය නොහැකි විය. පසුව නැවත උත්සාහ කරන්න.';

  @override
  String get google_emailSent =>
      'තහවුරු කිරීමේ ඊමේල් යවන ලදී. ඔබේ ලැබුණු පණිවිඩ පරීක්ෂා කරන්න.';

  @override
  String get google_rateLimited =>
      'නැවත උත්සාහ කිරීමට පෙර කරුණාකර රැඳී සිටින්න.';

  @override
  String get google_busy =>
      'වෙනත් මෙහෙයුමක් (VPN සම්බන්ධතාව, ගිණුම හෝ අමුත්තා) සිදු වෙමින් පවතින අතර Google ලබා ගත නොහැක. එය අවසන් වූ පසු නැවත උත්සාහ කරන්න. ඔබේ වත්මන් ප්‍රවේශය රැඳී ඇත.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN මුරපදය වැරදියි. ඔබේ වත්මන් ගිණුම රැඳී ඇත.';

  @override
  String get google_invalidCode =>
      'තහවුරු කිරීමේ කේතය වලංගු නොවේ හෝ කල් ඉකුත් වී ඇත.';

  @override
  String get google_accountChanged =>
      'ඔබේ සැසිය වෙනස් වී ඇත. නැවත ආරම්භ කිරීමට පෙර මෙම උත්සාහය අවලංගු කරන්න.';

  @override
  String get google_invalidResponse =>
      'ප්‍රතිචාරය සත්‍යාපනය කළ නොහැකි විය. ඔබේ වත්මන් ප්‍රවේශය රැඳී ඇත.';

  @override
  String get google_invalidRegistration =>
      'ඔබේ රට සහ එකඟතා දෙකම පරීක්ෂා කරන්න.';

  @override
  String get google_consentRequired =>
      'ඉදිරියට යාමට ඔබේ රට තෝරා ලේඛන දෙකම පිළිගන්න.';

  @override
  String get google_challengeRequired =>
      'අතිරේක ආරක්ෂණ පරීක්ෂාවක් අවශ්‍යයි. ඔබේ වත්මන් ප්‍රවේශය රැඳී ඇත.';

  @override
  String get google_challengeUnavailable =>
      'ආරක්ෂණ පරීක්ෂාව ලබා ගත නොහැක. පසුව නැවත උත්සාහ කරන්න.';

  @override
  String get google_intentMismatch =>
      'පෙර Google පිවිසීමේ උත්සාහයක් තවමත් අවසන් වී නැත. මෙම මෙහෙයුම ආරම්භ කිරීමට පෙර එය අවලංගු කරන්න.';

  @override
  String get google_challengeBlocked =>
      'අවශ්‍ය ආරක්ෂණ පරීක්ෂාව මෙම යෙදුමෙහි ලබා ගත නොහැක. මෙම මෙහෙයුම දැන් සම්පූර්ණ කළ නොහැක.';

  @override
  String get google_solveChallenge => 'ආරක්ෂණ පරීක්ෂාව සම්පූර්ණ කරන්න';

  @override
  String get google_challengeTitle => 'ආරක්ෂණ පරීක්ෂාව';

  @override
  String get google_challengeReady =>
      'සත්‍යාපනය සම්පූර්ණ විය. දැන් ඔබට ඔබේ ගිණුම සෑදීම තහවුරු කළ හැක.';

  @override
  String get google_challengeExpired =>
      'සත්‍යාපනය කල් ඉකුත් වී ඇත. තහවුරු කිරීමට පෙර එය නැවත සම්පූර්ණ කරන්න.';

  @override
  String get google_challengeCancelled =>
      'සත්‍යාපනය අවලංගු කරන ලදී. ඔබට එය නැවත උත්සාහ කළ හැක.';

  @override
  String get google_challengeFailed =>
      'ආරක්ෂණ පරීක්ෂාව අසාර්ථක විය. නැවත උත්සාහ කරන්න.';

  @override
  String get billing_trialTitle => 'Fuze Premium නොමිලේ උත්සාහ කරන්න';

  @override
  String get billing_trialSubtitle => 'අද සිට ඔබේ සම්බන්ධතාව ආරක්ෂා කරන්න.';

  @override
  String get billing_trialWeeks => 'සති 2ක නොමිලේ අත්හදා බැලීම';

  @override
  String billing_trialDays(String days) {
    return 'දින $daysක නොමිලේ අත්හදා බැලීම';
  }

  @override
  String get billing_trialStart => 'නොමිලේ අත්හදා බැලීම ආරම්භ කරන්න';

  @override
  String billing_trialFirstCharge(String date) {
    return 'ඔබ අද ආරම්භ කළහොත්, ඔබේ පළමු අය කිරීම $date දින සිදු වීමට නියමිතයි.';
  }

  @override
  String get billing_trialTerms =>
      'සඳහන් කළ මිලට ස්වයංක්‍රීයව නවීකරණය වේ. අය කිරීමෙන් වැළකීමට, අත්හදා බැලීම අවසන් වීමට පෙර Google Play හි අවලංගු කරන්න.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'ඉන්පසු මාසයකට $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'ඉන්පසු වසරකට $price';
  }

  @override
  String get billing_choosePeriod => 'ඔබේ සැලසුම තෝරන්න';

  @override
  String get billing_selectionHint => 'ඉදිරියට යාමට සැලසුමක් තෝරන්න.';

  @override
  String get billing_benefitConnection => 'ගුප්තකේතනය කළ සම්බන්ධතාව';

  @override
  String get billing_benefitPrivacy => 'අන්තර්ජාල රහස්‍යතාව';

  @override
  String get billing_benefitNoAccount => 'ලියාපදිංචිය අවශ්‍ය නොවේ';

  @override
  String get billing_cancellation => 'Google Play හි අවලංගු කරන්න';

  @override
  String get billing_premiumTitle => 'වඩා හොඳින් ආරක්ෂා වූ සම්බන්ධතාවක්.';

  @override
  String get billing_premiumSubtitle =>
      'ඔබේම වේගයෙන් ඔබේ සම්බන්ධතාව ආරක්ෂා කරන්න.';

  @override
  String get billing_priceMonthly => 'මාසයකට';

  @override
  String get billing_priceYearly => 'වසරකට';

  @override
  String get billing_trialToday => 'අද ගෙවීමට කිසිවක් නැත';

  @override
  String get billing_trialConfirmation =>
      'ඔබ තහවුරු කිරීමට පෙර Google Play දින, අවසන් මුදල සහ අදාළ බදු තහවුරු කරයි.';

  @override
  String get billing_offerChanged =>
      'මෙම පිරිනැමීමේ නියමයන් වෙනස් වී ඇත. සැලසුම් නැවුම් කර නැවත තෝරන්න.';

  @override
  String get status_waitingNetwork => 'ජාලය සඳහා බලා සිටිමින්';

  @override
  String get status_waitingNetworkDetail =>
      'ජාලයක් ලබා ගත නොහැක. ජාලය නැවත ලැබුණු විට VPN මගින් සම්බන්ධතාව පරීක්ෂා කරයි.';

  @override
  String get locations_favoriteLoadFailed =>
      'ප්‍රියතම පූරණය කළ නොහැකි විය. නැවත උත්සාහ කරන්න.';

  @override
  String get locations_favoritesLoading => 'ප්‍රියතම පූරණය වෙමින්…';
}
