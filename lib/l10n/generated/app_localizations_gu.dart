// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get vpnDisclosure_title => 'તમારા કનેક્શનને સુરક્ષિત કરો';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN આ ડિવાઇસ અને FuzeVPN સર્વર વચ્ચે એન્ક્રિપ્ટેડ ટનલ બનાવવા માટે Androidની VPN સેવા (VpnService)નો ઉપયોગ કરે છે.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN સક્રિય હોય ત્યારે, તમારી ઍપનો ઇન્ટરનેટ ટ્રાફિક, ગંતવ્ય સરનામાં અને DNS વિનંતીઓ તમારું કનેક્શન રૂટ કરવા માટે આ ટનલ મારફતે પસાર થાય છે, FuzeVPN બૅકગ્રાઉન્ડમાં હોય ત્યારે પણ.';

  @override
  String get vpnDisclosure_statusBody =>
      'તમારું VPN કનેક્શન બતાવવા માટે ઍપ કનેક્શનની સ્થિતિ, તેની અવધિ અને ટ્રાન્સફર થયેલા ડેટાનો જથ્થો વાપરે છે. તમે તેને કોઈ પણ સમયે બંધ કરી શકો છો.';

  @override
  String get vpnDisclosure_privacy => 'ગોપનીયતા';

  @override
  String get vpnDisclosure_accept => 'સ્વીકારો અને ચાલુ રાખો';

  @override
  String get vpnDisclosure_decline => 'અત્યારે નહીં';

  @override
  String get accountRestoration_title => 'એકાઉન્ટ અસ્થાયી રૂપે ઉપલબ્ધ નથી';

  @override
  String get accountRestoration_message =>
      'તમારું સેશન સાચવી રાખવામાં આવ્યું છે. તમારું એકાઉન્ટ પુનઃસ્થાપિત કરવા માટે ફરી પ્રયાસ કરો. તમે અહીં હજી પણ VPN કનેક્શન મેનેજ કરી શકો છો.';

  @override
  String get action_retry => 'ફરી પ્રયાસ કરો';

  @override
  String get session_endingTitle => 'સેશન સમાપ્ત થઈ રહ્યું છે';

  @override
  String get session_ending =>
      'સેશન સમાપ્ત થઈ રહ્યું છે: VPN બંધ થઈ રહ્યું છે અને સાફસફાઈ ચાલી રહી છે…';

  @override
  String get session_stopFailed =>
      'VPN બંધ થવાની પુષ્ટિ થઈ નથી. ફરીથી સાઇન ઇન કરતાં પહેલાં ફરી પ્રયાસ કરો.';

  @override
  String get session_cleanupFailed =>
      'VPN બંધ થઈ ગયું છે, પરંતુ સેશન દૂર કરવાની પુષ્ટિ થઈ નથી. સાફસફાઈ માટે ફરી પ્રયાસ કરો.';

  @override
  String get session_retryStop => 'બંધ કરવાનો ફરી પ્રયાસ કરો';

  @override
  String get session_retryCleanup => 'સાફસફાઈનો ફરી પ્રયાસ કરો';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN સુરક્ષિત રીતે તૈયાર થઈ રહ્યું છે…';

  @override
  String get nav_connection => 'કનેક્શન';

  @override
  String get nav_locations => 'સ્થાનો';

  @override
  String get nav_account => 'એકાઉન્ટ';

  @override
  String get nav_devices => 'ડિવાઇસો';

  @override
  String get nav_settings => 'સેટિંગ્સ';

  @override
  String get action_refresh => 'રિફ્રેશ કરો';

  @override
  String get auth_tab_login => 'સાઇન ઇન કરો';

  @override
  String get auth_tab_register => 'સાઇન અપ કરો';

  @override
  String get auth_stepAccount => 'એકાઉન્ટ';

  @override
  String get auth_stepIdentity => 'ઓળખ';

  @override
  String get auth_stepAddress => 'સરનામું અને સંમતિ';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$total માંથી પગલું $current';
  }

  @override
  String get auth_tagline => 'તમારું VPN, હવે સરળ.';

  @override
  String get auth_keysLocal => 'તમારી ખાનગી VPN કી આ ડિવાઇસ પર જ રહે છે.';

  @override
  String get form_email => 'ઇ-મેઇલ સરનામું';

  @override
  String get form_password => 'પાસવર્ડ';

  @override
  String get form_showPassword => 'પાસવર્ડ બતાવો';

  @override
  String get form_hidePassword => 'પાસવર્ડ છુપાવો';

  @override
  String get form_passwordMin =>
      '8 થી 72 UTF-8 બાઇટ. કેટલાક અક્ષરો એક કરતાં વધુ બાઇટ વાપરે છે.';

  @override
  String get form_firstName => 'પ્રથમ નામ';

  @override
  String get form_lastName => 'અટક';

  @override
  String get form_phone => 'ફોન (+33612345678)';

  @override
  String get form_address => 'સરનામું';

  @override
  String get form_address2 => 'સરનામાની બીજી લાઇન (વૈકલ્પિક)';

  @override
  String get form_postalCode => 'પોસ્ટલ કોડ';

  @override
  String get form_city => 'શહેર';

  @override
  String get form_country => 'દેશનો કોડ (દા.ત. FR)';

  @override
  String get action_login => 'સાઇન ઇન કરો';

  @override
  String get action_createAccount => 'એકાઉન્ટ બનાવો';

  @override
  String get action_createMyAccount => 'મારું એકાઉન્ટ બનાવો';

  @override
  String get action_next => 'ચાલુ રાખો';

  @override
  String get action_previous => 'પાછળ';

  @override
  String get action_forgotPassword => 'પાસવર્ડ ભૂલી ગયા?';

  @override
  String get auth_noAccount => 'હજી સુધી એકાઉન્ટ નથી?';

  @override
  String get auth_requiredInformation => 'ત્રણ પગલાંમાં તમારું એકાઉન્ટ બનાવો.';

  @override
  String get auth_termsPrefix => 'હું સ્વીકારું છું: ';

  @override
  String get auth_termsLink => 'ઉપયોગની શરતો';

  @override
  String get auth_privacyPrefix => 'હું સ્વીકારું છું: ';

  @override
  String get auth_privacyLink => 'ગોપનીયતા નીતિ';

  @override
  String get auth_consentRequired =>
      'એકાઉન્ટ બનાવવા માટે તમારી સંમતિ જરૂરી છે.';

  @override
  String get validation_required => 'આ ફીલ્ડ જરૂરી છે.';

  @override
  String get validation_email => 'માન્ય ઇ-મેઇલ સરનામું દાખલ કરો.';

  @override
  String get validation_password =>
      'પાસવર્ડ ખૂબ ટૂંકો છે: ઓછામાં ઓછા 8 UTF-8 બાઇટ હોવા જોઈએ.';

  @override
  String get validation_passwordTooLong =>
      'પાસવર્ડ ખૂબ લાંબો છે: વધુમાં વધુ 72 UTF-8 બાઇટ હોવા જોઈએ.';

  @override
  String get validation_phone =>
      'આંતરરાષ્ટ્રીય ફોર્મેટનો ઉપયોગ કરો, દા.ત. +33612345678.';

  @override
  String get validation_country => 'બે અક્ષરનો દેશ કોડ વાપરો, દા.ત. FR.';

  @override
  String get passwordReset_title => 'પાસવર્ડ રીસેટ કરો';

  @override
  String get passwordReset_description =>
      'પાસવર્ડ રીસેટ લિંકની વિનંતી કરવા માટે તમારા એકાઉન્ટનું ઇ-મેઇલ સરનામું દાખલ કરો.';

  @override
  String get passwordReset_send => 'લિંક મોકલો';

  @override
  String get connection_title => 'તમારું કનેક્શન';

  @override
  String get connection_subtitle => 'સ્થાન પસંદ કરો, પછી તમારું VPN ચાલુ કરો.';

  @override
  String get connection_prepare => 'કનેક્ટ કરવા તૈયાર છો?';

  @override
  String get connection_advancedOptions => 'ઍડવાન્સ્ડ વિકલ્પો';

  @override
  String get connection_location => 'સ્થાન';

  @override
  String get connection_chooseLocation => 'સ્થાન પસંદ કરો';

  @override
  String get connection_protocol => 'પ્રોટોકોલ';

  @override
  String get connection_connect => 'કનેક્ટ કરો';

  @override
  String get connection_connecting => 'કનેક્ટ થઈ રહ્યું છે…';

  @override
  String get connection_disconnect => 'ડિસ્કનેક્ટ કરો';

  @override
  String get connection_disconnecting => 'ડિસ્કનેક્ટ થઈ રહ્યું છે';

  @override
  String get connection_locationChange => 'સ્થાન બદલાઈ રહ્યું છે…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol ઉપલબ્ધ નથી';
  }

  @override
  String get connection_activeLocation => 'સક્રિય સ્થાન';

  @override
  String get connection_duration => 'અવધિ';

  @override
  String get connection_received => 'પ્રાપ્ત થયેલ';

  @override
  String get connection_sent => 'મોકલેલ';

  @override
  String get connection_lastHandshake => 'છેલ્લી સુરક્ષિત આપ-લે';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration પહેલાં';
  }

  @override
  String get verification_title => 'તમારા ઇ-મેઇલ સરનામાની પુષ્ટિ કરો';

  @override
  String get verification_message =>
      'આ ફોન પર VPN વાપરવા માટે તમારા ઇ-મેઇલ સરનામાની પુષ્ટિ કરો.';

  @override
  String get verification_resend => 'ઇ-મેઇલ ફરીથી મોકલો';

  @override
  String get migration_title => 'સ્થાન બદલાવ';

  @override
  String get migration_draining => 'સ્થાન બદલવાની તૈયારી થઈ રહી છે…';

  @override
  String get migration_activating => 'નવું સર્વર સક્રિય કરવામાં આવી રહ્યું છે…';

  @override
  String get migration_ready => 'સ્થાન અપડેટ થયું.';

  @override
  String get migration_blocked =>
      'સ્થાન બદલવા માટે સર્વર તરફથી કાર્યવાહી જરૂરી છે. પછીથી ફરી પ્રયાસ કરો અથવા સપોર્ટનો સંપર્ક કરો.';

  @override
  String get migration_progress => 'સ્થાન બદલવાની પ્રગતિ';

  @override
  String migration_retryDelay(Object seconds) {
    return 'તપાસ વચ્ચેનો વિલંબ: $seconds સેકન્ડ.';
  }

  @override
  String get migration_resume => 'સ્થાન બદલવાનું ફરી શરૂ કરો';

  @override
  String get status_authorizing => 'પરવાનગી જરૂરી છે';

  @override
  String get status_authorizingDetail =>
      'VPNને મંજૂરી આપવા માટે Android વિનંતી સ્વીકારો.';

  @override
  String get status_preparing => 'તૈયારી થઈ રહી છે';

  @override
  String get status_preparingDetail =>
      'તમારું સુરક્ષિત કનેક્શન તૈયાર થઈ રહ્યું છે.';

  @override
  String get status_reconnecting => 'ફરીથી કનેક્ટ થઈ રહ્યું છે…';

  @override
  String get status_reconnectingDetail =>
      'કનેક્શન ખોરવાયું. VPN ફરીથી કનેક્ટ કરવાનો પ્રયાસ કરી રહ્યું છે.';

  @override
  String get status_connecting => 'કનેક્ટ થઈ રહ્યું છે';

  @override
  String get status_connectingDetail => 'VPN સર્વર સાથે કનેક્ટ થઈ રહ્યું છે…';

  @override
  String get status_connected => 'કનેક્ટેડ';

  @override
  String get status_connectedDetail => 'તમારું VPN કનેક્શન સક્રિય છે.';

  @override
  String get status_disconnecting => 'ડિસ્કનેક્ટ થઈ રહ્યું છે';

  @override
  String get status_disconnectingDetail =>
      'તમારું VPN કનેક્શન બંધ થઈ રહ્યું છે.';

  @override
  String get status_error => 'કનેક્શન ઉપલબ્ધ નથી';

  @override
  String get status_errorDetail =>
      'VPN કનેક્શનની પુષ્ટિ થઈ નથી. ફરી પ્રયાસ કરો.';

  @override
  String get status_idle => 'ડિસ્કનેક્ટેડ';

  @override
  String get status_idleDetail =>
      'તમારા કનેક્શનને સુરક્ષિત કરવા VPN કનેક્ટ કરો.';

  @override
  String get trust_note =>
      'ઍપ બંધ કરવાથી VPN બંધ થતું નથી. તેને બંધ કરવા માટે “ડિસ્કનેક્ટ કરો” વાપરો.';

  @override
  String get locations_none => 'હાલમાં કોઈ સ્થાન ઉપલબ્ધ નથી.';

  @override
  String get locations_available => 'તમારું આગલું સ્થાન પસંદ કરો.';

  @override
  String get locations_selected => 'પસંદ કરેલું સ્થાન';

  @override
  String get locations_select => 'આ સ્થાન પસંદ કરો';

  @override
  String get locations_lockedTunnel => 'સ્થાન બદલવા માટે VPN ડિસ્કનેક્ટ કરો.';

  @override
  String get locations_lockedMigration =>
      'સ્થાન બદલાવ પૂર્ણ થાય ત્યાં સુધી રાહ જુઓ.';

  @override
  String get devices_title => 'તમારા ડિવાઇસો';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ડિવાઇસો';
  }

  @override
  String get devices_refresh => 'ડિવાઇસો રિફ્રેશ કરો';

  @override
  String get devices_empty => 'હજી સુધી કોઈ VPN ડિવાઇસ નોંધાયેલું નથી.';

  @override
  String get devices_firstConnection =>
      'તમારો ફોન પ્રથમ કનેક્શન વખતે ઉમેરવામાં આવશે.';

  @override
  String get devices_thisDevice => 'આ ડિવાઇસ';

  @override
  String devices_added(Object date) {
    return '$dateના રોજ ઉમેર્યું';
  }

  @override
  String get devices_unnamed => 'નામ વગરનું ડિવાઇસ';

  @override
  String get action_remove => 'દૂર કરો';

  @override
  String get settings_title => 'સેટિંગ્સ';

  @override
  String get settings_subtitle =>
      'તમારી પસંદગીઓ અને એકાઉન્ટ, બધું એક જ જગ્યાએ.';

  @override
  String get settings_appearance => 'દેખાવ';

  @override
  String get settings_language => 'ભાષા';

  @override
  String get settings_languageDescription =>
      'તમે પસંદ કરેલી ભાષા VPN સૂચનાઓ પર પણ લાગુ થાય છે.';

  @override
  String get settings_account => 'એકાઉન્ટ';

  @override
  String get settings_signOut => 'સાઇન આઉટ કરો';

  @override
  String get settings_privacy => 'ગોપનીયતા નીતિ';

  @override
  String get settings_terms => 'ઉપયોગની શરતો';

  @override
  String get settings_security => 'સુરક્ષા અને પારદર્શિતા';

  @override
  String get settings_licenses => 'ઘટકોના લાઇસન્સ';

  @override
  String get settings_licensesDetail => 'ઍપમાં વપરાયેલું સોફ્ટવેર';

  @override
  String settings_licensesLegalese(String url) {
    return 'ઍપ અને તેના MPL-2.0 ઘટકોનો સોર્સ કોડ: $url';
  }

  @override
  String get settings_background =>
      'ઍપ છોડો ત્યારે પણ VPN ચાલુ રહે છે. તેને બંધ કરવા માટે કનેક્શન ટૅબમાં “ડિસ્કનેક્ટ કરો” વાપરો.';

  @override
  String get theme_system => 'સિસ્ટમ';

  @override
  String get theme_light => 'લાઇટ';

  @override
  String get theme_dark => 'ડાર્ક';

  @override
  String get language_system => 'ફોનની ભાષા';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'આ ડિવાઇસ દૂર કરીએ?';

  @override
  String get dialog_removeCurrent =>
      'આ ફોન VPNમાંથી ડિસ્કનેક્ટ થઈ જશે અને VPN ઍક્સેસ ગુમાવશે. સર્વર પુષ્ટિ કરે પછી તેનો VPN કનેક્શન ડેટા દૂર કરવામાં આવશે.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” માટે VPN ઍક્સેસ રદ કરવામાં આવશે. આ ક્રિયા પૂર્વવત્ કરી શકાતી નથી.';
  }

  @override
  String get dialog_signOut => 'સાઇન આઉટ કરીએ?';

  @override
  String get dialog_signOutMessage =>
      'VPN બંધ થઈ જશે અને તમારે ફરીથી સાઇન ઇન કરવું પડશે. તમારી એન્ક્રિપ્ટેડ VPN કી આગલા કનેક્શન માટે આ ફોન પર જ રહેશે.';

  @override
  String get action_cancel => 'રદ કરો';

  @override
  String get action_close => 'બંધ કરો';

  @override
  String get action_copy => 'કૉપિ કરો';

  @override
  String get action_signOut => 'સાઇન આઉટ કરો';

  @override
  String get notice_close => 'સંદેશ બંધ કરો';

  @override
  String get notice_sessionExpired_title => 'સેશનની મુદત પૂરી થઈ';

  @override
  String get notice_sessionExpired_message =>
      'તમારા સેશનની મુદત પૂરી થઈ ગઈ છે. ફરીથી સાઇન ઇન કરો.';

  @override
  String get notice_connectionFailed_title => 'કનેક્શન નિષ્ફળ';

  @override
  String get notice_invalidCredentials_message =>
      'ઇ-મેઇલ સરનામું અથવા પાસવર્ડ ખોટો છે.';

  @override
  String get notice_emailVerification_title => 'ઇ-મેઇલની પુષ્ટિ જરૂરી છે';

  @override
  String get notice_emailVerification_message =>
      'VPN ડિવાઇસ ઉમેરતાં પહેલાં તમારા ઇ-મેઇલ સરનામાની પુષ્ટિ કરો.';

  @override
  String get notice_rateLimited_title => 'વધુ પડતા પ્રયાસો';

  @override
  String get notice_deviceLimit_title => 'ડિવાઇસ મર્યાદા પૂરી થઈ';

  @override
  String get notice_deviceLimit_message =>
      'બીજું ડિવાઇસ ઉમેરતાં પહેલાં હાલનું ડિવાઇસ દૂર કરો.';

  @override
  String get notice_identityRenewal_title => 'VPN ઓળખ નવી કરવી જરૂરી છે';

  @override
  String get notice_identityRenewal_message =>
      'આ ઓળખ દૂર કરવામાં આવી હતી. નવી સ્થાનિક ઓળખ બનાવો.';

  @override
  String get notice_migrationPending_title => 'સ્થાન બદલાવ ચાલુ છે';

  @override
  String get notice_migrationPending_message => 'સ્થાન બદલાવ પહેલેથી ચાલુ છે.';

  @override
  String get notice_migrationBlocked_title => 'સ્થાન બદલાવ બ્લૉક થયો';

  @override
  String get notice_migrationBlocked_message =>
      'સ્થાન બદલવા માટે સર્વર તરફથી કાર્યવાહી જરૂરી છે. પછીથી ફરી પ્રયાસ કરો અથવા સપોર્ટનો સંપર્ક કરો.';

  @override
  String get notice_targetUnavailable_title => 'સર્વર અસ્થાયી રૂપે ઉપલબ્ધ નથી';

  @override
  String get notice_targetUnavailable_message =>
      'આ સર્વર અસ્થાયી રૂપે ઉપલબ્ધ નથી.';

  @override
  String get notice_networkUnavailable_title => 'ઇન્ટરનેટ કનેક્શન ઉપલબ્ધ નથી';

  @override
  String get notice_networkUnavailable_message =>
      'તમારું કનેક્શન તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get notice_permissionDenied_title => 'VPN પરવાનગી નકારી';

  @override
  String get notice_permissionDenied_message =>
      'કનેક્શન ફરી શરૂ કરો અને Android પરવાનગી વિનંતી સ્વીકારો.';

  @override
  String get notice_wireguardTimeout_title => 'સર્વર પ્રતિસાદ આપી રહ્યું નથી';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard કનેક્શનમાં ઘણો સમય લાગ્યો. ફરી પ્રયાસ કરો અથવા બીજું સ્થાન પસંદ કરો.';

  @override
  String get notice_tlsFailed_title => 'સુરક્ષિત કનેક્શન નકારવામાં આવ્યું';

  @override
  String get notice_tlsFailed_message =>
      'સર્વરે OpenVPN કનેક્શન સ્વીકાર્યું નહીં. ફરી પ્રયાસ કરો. સમસ્યા ચાલુ રહે તો ડાયગ્નોસ્ટિક્સ ચલાવો.';

  @override
  String get notice_tunRejected_title => 'Androidએ VPN ઇન્ટરફેસ નકાર્યું';

  @override
  String get notice_tunRejected_message =>
      'OpenVPNએ વિનંતી કરેલી નેટવર્ક ગોઠવણી Androidએ નકારી.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN શરૂ થઈ શક્યું નહીં';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN એન્જિન શરૂ થવાનું પૂર્ણ થઈ શક્યું નહીં. ફરી પ્રયાસ કરો. સમસ્યા ચાલુ રહે તો સપોર્ટનો સંપર્ક કરો.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'ડાયગ્નોસ્ટિક કોડ: $code';
  }

  @override
  String get notice_generic_title => 'VPN કનેક્શન નિષ્ફળ';

  @override
  String get notice_generic_message => 'ભૂલ આવી છે. પછીથી ફરી પ્રયાસ કરો.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'એકાઉન્ટ બનાવાયું',
      'password_reset_sent': 'પાસવર્ડ રીસેટની વિનંતી મળી',
      'verification_email_sent': 'ચકાસણી ઇ-મેઇલ મોકલાયો',
      'location_migration_pending': 'સ્થાન બદલાવ ચાલુ છે',
      'vpn_sign_in_required': 'સાઇન ઇન જરૂરી છે',
      'protocol_unavailable_at_location': 'પ્રોટોકોલ ઉપલબ્ધ નથી',
      'vpn_permission_denied': 'VPN પરવાનગી નકારી',
      'revoked_identity_device_limit': 'ડિવાઇસ મર્યાદા પૂરી થઈ',
      'tunnel_start_unexpected': 'VPN શરૂ થઈ શક્યું નહીં',
      'flutter_disconnect_timeout': 'ડિસ્કનેક્શનની પુષ્ટિ થઈ નથી',
      'flutter_disconnect_unexpected': 'ડિસ્કનેક્ટ થઈ શક્યું નહીં',
      'device_revoked': 'ડિવાઇસ દૂર કરાયું',
      'revoke_unexpected': 'ડિવાઇસ દૂર કરી શકાયું નહીં',
      'identity_renewal_unexpected': 'ઓળખ નવી કરી શકાઈ નહીં',
      'openvpn_renewal_unexpected': 'OpenVPN પ્રોફાઇલ નવી કરી શકાઈ નહીં',
      'location_migration_blocked': 'સ્થાન બદલાવ બ્લૉક થયો',
      'location_migration_slow': 'સ્થાન બદલાવ હજી ચાલુ છે',
      'location_migration_conflict': 'સ્થાન બદલાવ રિફ્રેશ કરવો જરૂરી છે',
      'location_migration_verification_failed': 'સ્થાન બદલાવની પુષ્ટિ થઈ નથી',
      'location_migration_device_changed': 'સ્થાન બદલાવ દરમિયાન ડિવાઇસ બદલાયું',
      'tunnel_stop_failed': 'સ્થાન બદલાવ ઉપલબ્ધ નથી',
      'device_clock_ahead': 'ડિવાઇસની ઘડિયાળ આગળ છે',
      'other': 'કામગીરી નિષ્ફળ',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'એકાઉન્ટ બનાવાયું છે, પરંતુ ચકાસણી ઇ-મેઇલ મોકલી શકાયો નથી. ઍપમાં ફરીથી મોકલવાનો વિકલ્પ વાપરો.',
      'password_reset_sent':
          'તમારી વિનંતી મળી છે. જો આ સરનામા સાથે કોઈ એકાઉન્ટ સંકળાયેલું હશે, તો તમને ઇ-મેઇલ મળી શકે છે. કૃપા કરીને તમારું સ્પામ ફોલ્ડર પણ તપાસો.',
      'verification_email_sent':
          'નવો ચકાસણી ઇ-મેઇલ હમણાં જ મોકલવામાં આવ્યો છે.',
      'location_migration_pending':
          '$target પર સ્વિચ કરવાની તૈયારી હજી ચાલી રહી છે. ડિવાઇસ ફરીથી બનાવ્યા વિના તમે તેને ફરી શરૂ કરી શકો છો.',
      'vpn_sign_in_required':
          'VPN શરૂ કરતાં પહેલાં તમારા એકાઉન્ટમાં સાઇન ઇન કરો.',
      'protocol_unavailable_at_location':
          'આ સ્થાન પર પસંદ કરેલો પ્રોટોકોલ ઉપલબ્ધ નથી. સ્થાનો રિફ્રેશ કરો અથવા બીજો પ્રોટોકોલ પસંદ કરો.',
      'vpn_permission_denied':
          'Androidએ VPN પરવાનગી નકારી છે. કનેક્શન ફરી શરૂ કરો અને સિસ્ટમ વિનંતી સ્વીકારો.',
      'revoked_identity_device_limit':
          'આ ડિવાઇસની VPN ઍક્સેસ દૂર કરવામાં આવી છે અને ડિવાઇસ મર્યાદા પૂરી થઈ ગઈ છે. એકાઉન્ટ → મારા ડિવાઇસો મેનેજ કરો હેઠળ એક ડિવાઇસ દૂર કરો.',
      'tunnel_start_unexpected':
          'અણધારી ભૂલને કારણે ટનલની તૈયારી અટકી ગઈ. ડાયગ્નોસ્ટિક કોડ તપાસો અને ફરી પ્રયાસ કરો.',
      'flutter_disconnect_timeout':
          'Androidએ સમયસર VPN બંધ થયાની પુષ્ટિ કરી નથી. ફરીથી બંધ કરવાનો પ્રયાસ કરો.',
      'flutter_disconnect_unexpected':
          'અણધારી ભૂલને કારણે ટનલ બંધ થયાની પુષ્ટિ થઈ શકી નહીં.',
      'device_revoked':
          'ડિવાઇસની VPN ઍક્સેસ રદ કરવામાં આવી છે અને તેની સ્થાનિક ગુપ્ત માહિતી દૂર કરવામાં આવી છે.',
      'revoke_unexpected':
          'ડિવાઇસ દૂર કરી શકાયું નથી. યાદી રિફ્રેશ કરો અને ફરી પ્રયાસ કરો.',
      'identity_renewal_unexpected':
          'નવી VPN ઓળખ બનાવી શકાઈ નથી. ડિવાઇસો રિફ્રેશ કરો અને ફરી પ્રયાસ કરો.',
      'openvpn_renewal_unexpected':
          'OpenVPN પ્રોફાઇલ નવી કરી શકાઈ નથી. ફરી પ્રયાસ કરો અથવા ડાયગ્નોસ્ટિક કોડ તપાસો.',
      'location_migration_blocked':
          'સર્વર અત્યારે આ બદલાવ પૂર્ણ કરી શકતું નથી. ડિવાઇસ અને તેની સ્થાનિક ઓળખ સાચવી રાખવામાં આવી છે.',
      'location_migration_slow':
          'સર્વર હજી $target પર સ્વિચ કરવાની તૈયારી કરી રહ્યું છે. થોડી ક્ષણો પછી ફરી શરૂ કરો વિકલ્પ વાપરો.',
      'location_migration_conflict':
          'સર્વર પર ડિવાઇસની સ્થિતિ બદલાઈ ગઈ છે. ડિવાઇસો રિફ્રેશ કરો, પછી બદલાવ ફરી શરૂ કરો.',
      'location_migration_verification_failed':
          'સર્વરે નવા સ્થાનની પુષ્ટિ કરી નથી. અગાઉની સ્થાનિક ઓળખ સાચવી રાખવામાં આવી છે.',
      'location_migration_device_changed':
          'સર્વર પરથી મળેલું ડિવાઇસ બદલાઈ રહેલા ડિવાઇસ સાથે હવે મેળ ખાતું નથી. ફરી પ્રયાસ કરતાં પહેલાં ડિવાઇસો રિફ્રેશ કરો.',
      'tunnel_stop_failed':
          'નવું કનેક્શન શરૂ કરતાં પહેલાં અગાઉની ટનલ સંપૂર્ણપણે બંધ થવી જોઈએ.',
      'device_clock_ahead':
          'આ ડિવાઇસની ઘડિયાળ આગળ હોય એવું લાગે છે. સાઇન ઇન રહેવા માટે સ્વચાલિત તારીખ અને સમય ચાલુ કરો.',
      'other':
          'કામગીરી પૂર્ણ થઈ શકી નથી. ફરી પ્રયાસ કરો અથવા ડાયગ્નોસ્ટિક કોડ સપોર્ટને મોકલો.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'સેશનની મુદત પૂરી થઈ',
      'invalid_credentials': 'સાઇન ઇન નિષ્ફળ',
      'email_verification_required': 'ઇ-મેઇલની પુષ્ટિ જરૂરી છે',
      'verification_email_cooldown': 'ઇ-મેઇલ પહેલેથી મોકલાઈ ગયો છે',
      'rate_limited': 'વધુ પડતા પ્રયાસો',
      'invalid_registration': 'માહિતી સુધારવી જરૂરી છે',
      'email_exists': 'એકાઉન્ટ પહેલેથી અસ્તિત્વમાં છે',
      'invalid_profile': 'અમાન્ય પ્રોફાઇલ',
      'invalid_device': 'અમાન્ય ડિવાઇસ',
      'invalid_location': 'સ્થાન ઉપલબ્ધ નથી',
      'device_limit': 'ડિવાઇસ મર્યાદા પૂરી થઈ',
      'device_exists': 'VPN ઓળખ પહેલેથી વપરાઈ રહી છે',
      'device_identity_revoked': 'VPN ઓળખ નવી કરવી જરૂરી છે',
      'device_location_locked': 'સ્થાન બદલાવ રિફ્રેશ કરવો જરૂરી છે',
      'location_migration_pending': 'સ્થાન બદલાવ ચાલુ છે',
      'location_migration_blocked': 'સ્થાન બદલાવ બ્લૉક થયો',
      'target_ca_mismatch': 'અસંગત OpenVPN સર્વર',
      'location_migration_conflict': 'સ્થાન બદલાવ રિફ્રેશ કરવો જરૂરી છે',
      'server_full': 'સર્વર ભરાઈ ગયું છે',
      'capacity_unavailable': 'સ્થાન અસ્થાયી રૂપે ઉપલબ્ધ નથી',
      'target_unavailable': 'સર્વર અસ્થાયી રૂપે ઉપલબ્ધ નથી',
      'not_found': 'આઇટમ મળી નથી',
      'invalid_openvpn_csr': 'અમાન્ય OpenVPN ઓળખ',
      'openvpn_profile_exists': 'OpenVPN પ્રોફાઇલ પહેલેથી છે',
      'openvpn_profile_revoked': 'OpenVPN પ્રોફાઇલ રદ કરાઈ છે',
      'openvpn_operation_pending': 'OpenVPN કામગીરી ચાલુ છે',
      'openvpn_operation_terminal': 'OpenVPN કામગીરી ખોરવાઈ',
      'openvpn_address_unavailable': 'OpenVPN સરનામું ઉપલબ્ધ નથી',
      'openvpn_profile_conflict': 'OpenVPN સાથે વિરોધાભાસ',
      'openvpn_signer_unavailable': 'OpenVPN ઉપલબ્ધ નથી',
      'email_delivery_unavailable': 'ઇ-મેઇલ ઉપલબ્ધ નથી',
      'invalid_token': 'અમાન્ય લિંક',
      'network_unavailable': 'ઇન્ટરનેટ કનેક્શન ઉપલબ્ધ નથી',
      'invalid_json': 'અમાન્ય વિનંતી',
      'invalid_api_response': 'અમાન્ય સર્વર પ્રતિસાદ',
      'ipv6_unavailable': 'IPv6 ઉપલબ્ધ નથી',
      'invalid_ip_families': 'નેટવર્ક ગોઠવણી નકારાઈ',
      'other': 'સેવા ઉપલબ્ધ નથી',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'તમારા સેશનની મુદત પૂરી થઈ ગઈ છે. ફરીથી સાઇન ઇન કરો.',
      'invalid_credentials': 'ઇ-મેઇલ સરનામું અથવા પાસવર્ડ ખોટો છે.',
      'email_verification_required':
          'VPN ડિવાઇસ ઉમેરતાં પહેલાં તમારા ઇ-મેઇલ સરનામાની પુષ્ટિ કરો.',
      'invalid_registration': 'વિનંતી કરેલી માહિતી અને સંમતિઓ તપાસો.',
      'email_exists': 'આ ઇ-મેઇલ સરનામું પહેલેથી એક એકાઉન્ટમાં વપરાયેલું છે.',
      'invalid_profile': 'તમારી પ્રોફાઇલની માહિતી તપાસો.',
      'invalid_device': 'આ ડિવાઇસનું નામ અથવા સ્થાનિક ઓળખ અમાન્ય છે.',
      'invalid_location': 'સ્થાનોની યાદી રિફ્રેશ કરીને ફરી પ્રયાસ કરો.',
      'device_limit': 'બીજું ડિવાઇસ ઉમેરતાં પહેલાં હાલનું ડિવાઇસ દૂર કરો.',
      'device_exists': 'આ VPN ઓળખ પહેલેથી બીજા એકાઉન્ટ સાથે જોડાયેલી છે.',
      'device_identity_revoked':
          'આ ઓળખ દૂર કરવામાં આવી છે. નવી સ્થાનિક ઓળખ બનાવવી જરૂરી છે.',
      'device_location_locked':
          'આ ડિવાઇસનું સ્થાન હમણાં જ બદલાયું છે. ઍપ ચાલુ બદલાવ ફરી શરૂ કરશે.',
      'location_migration_pending': 'સ્થાન બદલાવ પહેલેથી ચાલુ છે.',
      'location_migration_blocked':
          'સ્થાન બદલવા માટે સર્વર તરફથી કાર્યવાહી જરૂરી છે. પછીથી ફરી પ્રયાસ કરો અથવા સપોર્ટનો સંપર્ક કરો.',
      'target_ca_mismatch':
          'આ સર્વર હજી વર્તમાન OpenVPN પ્રોફાઇલ સાથે સુસંગત નથી.',
      'location_migration_conflict':
          'ડિવાઇસની યાદી રિફ્રેશ કરો, પછી ફરી સ્થાન બદલવાનો પ્રયાસ કરો.',
      'server_full':
          'આ સ્થાન પર કનેક્શન મર્યાદા પૂરી થઈ ગઈ છે. બીજું સ્થાન પસંદ કરો અથવા પછીથી ફરી પ્રયાસ કરો.',
      'capacity_unavailable':
          'આ સ્થાન હમણાં ઉપલબ્ધ છે કે નહીં તેની અમે પુષ્ટિ કરી શકતા નથી. બીજું સ્થાન પસંદ કરો અથવા પછીથી ફરી પ્રયાસ કરો.',
      'target_unavailable': 'આ સર્વર અસ્થાયી રૂપે ઉપલબ્ધ નથી.',
      'not_found': 'આ આઇટમ હવે તમારા એકાઉન્ટ પર ઉપલબ્ધ નથી.',
      'invalid_openvpn_csr': 'નવી OpenVPN ઓળખ બનાવીને ફરી પ્રયાસ કરો.',
      'openvpn_profile_exists': 'આ ડિવાઇસ માટે OpenVPN પ્રોફાઇલ પહેલેથી છે.',
      'openvpn_profile_revoked': 'ચાલુ રાખવા માટે OpenVPN પ્રોફાઇલ નવી કરો.',
      'openvpn_operation_pending':
          'ફેરફાર હજી લાગુ થઈ રહ્યો છે. પછીથી ફરી પ્રયાસ કરો.',
      'openvpn_operation_terminal': 'નવી OpenVPN ઓળખ બનાવીને ફરી પ્રયાસ કરો.',
      'openvpn_address_unavailable': 'હાલ કોઈ OpenVPN સરનામું ઉપલબ્ધ નથી.',
      'openvpn_profile_conflict':
          'પ્રોફાઇલ બદલાઈ ગઈ છે. ડિવાઇસની યાદી રિફ્રેશ કરીને ફરી પ્રયાસ કરો.',
      'openvpn_signer_unavailable': 'OpenVPN સેવા અસ્થાયી રૂપે ઉપલબ્ધ નથી.',
      'email_delivery_unavailable':
          'ઇ-મેઇલ મોકલી શકાયો નથી. પછીથી ફરી પ્રયાસ કરો.',
      'invalid_token':
          'આ લિંક અમાન્ય છે અથવા તેની મુદત પૂરી થઈ ગઈ છે. નવી લિંક માટે વિનંતી કરો.',
      'network_unavailable': 'તમારું ઇન્ટરનેટ કનેક્શન તપાસીને ફરી પ્રયાસ કરો.',
      'invalid_json': 'દાખલ કરેલી માહિતી તપાસીને ફરી પ્રયાસ કરો.',
      'invalid_api_response':
          'સર્વરે અણધાર્યો પ્રતિસાદ આપ્યો. પછીથી ફરી પ્રયાસ કરો.',
      'ipv6_unavailable':
          'સર્વર હાલ IPv6 સક્રિય કરી શકતું નથી. પછીથી ફરી પ્રયાસ કરો.',
      'invalid_ip_families':
          'ટનલ ગોઠવણી અધૂરી છે અથવા અધિકૃત સરનામાં સાથે મેળ ખાતી નથી. ઍપમાંથી ફરી પ્રયાસ કરો.',
      'other': 'સર્વરમાં ભૂલ આવી. પછીથી ફરી પ્રયાસ કરો.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'થોડી ક્ષણો પછી ફરી પ્રયાસ કરો.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds સેકન્ડમાં ફરી પ્રયાસ કરો.',
      one: '$seconds સેકન્ડમાં ફરી પ્રયાસ કરો.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes મિનિટમાં ફરી પ્રયાસ કરો.',
      one: '$minutes મિનિટમાં ફરી પ્રયાસ કરો.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours કલાકમાં ફરી પ્રયાસ કરો.',
      one: '$hours કલાકમાં ફરી પ્રયાસ કરો.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'સિસ્ટમ VPN ફરી શરૂ કરવું ઉપલબ્ધ નથી',
      'system_vpn_resume_corrupt': 'અમાન્ય સિસ્ટમ VPN ફરી શરૂ કરવાની માહિતી',
      'system_vpn_resume_session_invalid': 'અમાન્ય VPN ફરી શરૂ કરવાનું સેશન',
      'system_vpn_resume_identity_changed': 'VPN ઓળખ બદલાઈ ગઈ',
      'system_vpn_resume_identity_invalid': 'અમાન્ય VPN ફરી શરૂ કરવાની ઓળખ',
      'system_vpn_resume_storage_failed':
          'VPN ફરી શરૂ કરવાનો સ્ટોરેજ ઉપલબ્ધ નથી',
      'system_vpn_resume_network_timeout': 'VPN ફરી શરૂ કરવા માટે નેટવર્ક નથી',
      'system_vpn_resume_blocked': 'VPN ફરી શરૂ કરવું બ્લૉક થયું છે',
      'system_vpn_resume_failed': 'VPN ફરી શરૂ કરવું નિષ્ફળ ગયું',
      'system_vpn_resume_error_invalid': 'અમાન્ય VPN ફરી શરૂ કરવાની ભૂલ',
      'wireguard_identity_store_failed': 'WireGuard ઓળખ સાચવી શકાઈ નથી',
      'wireguard_identity_unavailable': 'WireGuard ઓળખ ઉપલબ્ધ નથી',
      'vpn_host_destroyed': 'Android VPN હોસ્ટ બંધ થયો',
      'vpn_host_unavailable': 'Android VPN હોસ્ટ ઉપલબ્ધ નથી',
      'vpn_permission_required': 'VPN પરવાનગી જરૂરી છે',
      'vpn_permission_denied': 'VPN પરવાનગી નકારી',
      'vpn_permission_request_failed': 'પરવાનગીની વિનંતી કરી શકાઈ નથી',
      'wireguard_foreground_service_unavailable': 'WireGuard સેવા ઉપલબ્ધ નથી',
      'wireguard_identity_invalid': 'સ્થાનિક WireGuard કી અમાન્ય છે',
      'wireguard_identity_in_use': 'WireGuard ઓળખ પહેલેથી ઉપયોગમાં છે',
      'wireguard_configuration_invalid': 'અમાન્ય WireGuard ગોઠવણી',
      'wireguard_operation_pending': 'WireGuard કામગીરી હજી ચાલુ છે',
      'wireguard_start_failed': 'WireGuard શરૂ કરવાનું નકારાયું',
      'wireguard_stop_timeout': 'WireGuard બંધ થવાની પુષ્ટિ થઈ નથી',
      'wireguard_handshake_timeout': 'WireGuard જવાબ આપતું નથી',
      'openvpn_connection_timeout': 'OpenVPN જવાબ આપતું નથી',
      'openvpn_core_unavailable': 'OpenVPN એન્જિન ઉપલબ્ધ નથી',
      'openvpn_operation_pending': 'OpenVPN સેશન હજી ચાલુ છે',
      'openvpn_stop_timeout': 'OpenVPN બંધ થવાની પુષ્ટિ થઈ નથી',
      'openvpn_profile_unavailable': 'સ્થાનિક OpenVPN પ્રોફાઇલ ગુમ છે',
      'openvpn_native_failed': 'નેટિવ OpenVPN કૉલ ખોરવાયો',
      'openvpn_key_generation_failed': 'OpenVPN P-256 કી બનાવી શકાઈ નથી',
      'openvpn_csr_generation_failed': 'OpenVPN CSR બનાવી શકાયું નથી',
      'openvpn_identity_store_failed': 'OpenVPN ઓળખ સાચવી શકાઈ નથી',
      'openvpn_identity_clear_failed':
          'OpenVPN ઓળખ દૂર કરવાની પ્રક્રિયા અધૂરી છે',
      'openvpn_identity_in_use': 'OpenVPN ઓળખ હજી ઉપયોગમાં છે',
      'openvpn_tls_verification_required': 'OpenVPN TLS ચકાસણી ગુમ છે',
      'openvpn_cipher_invalid': 'અમાન્ય OpenVPN સાઇફર',
      'openvpn_profile_rejected': 'OpenVPN પ્રોફાઇલ નકારવામાં આવી',
      'openvpn_identity_inconsistent': 'OpenVPN ઓળખમાં વિસંગતતા છે',
      'tls_handshake_failed': 'OpenVPN વાટાઘાટ નકારવામાં આવી',
      'tls_alert_unknown_ca': 'OpenVPN ક્લાયન્ટ સર્ટિફિકેટ ઓળખાતું નથી',
      'tls_alert_bad_certificate':
          'OpenVPN ક્લાયન્ટ સર્ટિફિકેટ નકારવામાં આવ્યું',
      'tls_alert_unsupported_certificate': 'અસમર્થિત OpenVPN સર્ટિફિકેટ',
      'tls_client_certificate_required': 'OpenVPN ક્લાયન્ટ સર્ટિફિકેટ જરૂરી છે',
      'tls_alert_misc': 'OpenVPN TLS ચેતવણી',
      'tls_signature_algorithm_rejected': 'અસમર્થિત OpenVPN સહી',
      'tls_handshake_rejected': 'OpenVPN TLS વાટાઘાટ નકારવામાં આવી',
      'tls_version_rejected': 'અસંગત OpenVPN TLS વર્ઝન',
      'tls_certificate_expired': 'TLS સર્ટિફિકેટની મુદત પૂરી થઈ ગઈ',
      'tls_certificate_revoked': 'TLS સર્ટિફિકેટ રદ કરવામાં આવ્યું',
      'transport_failed': 'OpenVPN સર્વર સુધી પહોંચી શકાતું નથી',
      'tun_configuration_rejected': 'OpenVPN ઇન્ટરફેસ બનાવી શકાયું નથી',
      'tun_setup_failed': 'OpenVPN TUN સેટઅપ નિષ્ફળ ગયું',
      'tun_interface_create_failed': 'OpenVPN ઇન્ટરફેસ બનાવવું નિષ્ફળ ગયું',
      'tun_interface_disabled': 'OpenVPN ઇન્ટરફેસ અક્ષમ છે',
      'tun_halted': 'OpenVPN ઇન્ટરફેસ ખોરવાયું',
      'tun_already_established': 'OpenVPN ઇન્ટરફેસ પહેલેથી ખુલ્લું છે',
      'tun_addresses_missing': 'OpenVPN સરનામું ગુમ છે',
      'tun_routes_missing': 'OpenVPN રૂટ ગુમ છે',
      'tun_dns_missing': 'OpenVPN DNS ગુમ છે',
      'tun_permission_revoked': 'VPN પરવાનગી રદ કરવામાં આવી',
      'tun_establish_returned_null': 'Androidએ VPN ઇન્ટરફેસ નકાર્યું',
      'openvpn_service_start_failed': 'OpenVPN સેવા શરૂ થઈ શકી નથી',
      'openvpn_operation_timeout': 'OpenVPN કૉલનો સમય વીતી ગયો',
      'openvpn_start_failed': 'OpenVPN શરૂ કરવાનું નકારાયું',
      'openvpn_connection_failed': 'OpenVPN કનેક્શન ખોરવાયું',
      'openvpn_core_status_error': 'OpenVPN કોર ભૂલ સાથે બંધ થયું',
      'openvpn_stopped_before_connected': 'કનેક્ટ થતાં પહેલાં OpenVPN બંધ થયું',
      'openvpn_auth_failed': 'OpenVPN પ્રમાણીકરણ નકારવામાં આવ્યું',
      'openvpn_client_setup_failed': 'OpenVPN ક્લાયન્ટ સેટઅપ નિષ્ફળ ગયું',
      'openvpn_client_halted': 'OpenVPN ક્લાયન્ટ ખોરવાયું',
      'openvpn_client_restart': 'OpenVPN ફરી શરૂ કરવાની વિનંતી છે',
      'openvpn_inactive_timeout': 'OpenVPN લાંબા સમયથી નિષ્ક્રિય છે',
      'openvpn_session_expired': 'OpenVPN સેશનની મુદત પૂરી થઈ ગઈ',
      'openvpn_credentials_required': 'અસમર્થિત OpenVPN પ્રમાણીકરણ',
      'openvpn_proxy_failed': 'OpenVPN મધ્યસ્થી ટ્રાન્સપોર્ટ નિષ્ફળ ગયું',
      'openvpn_compression_failed': 'OpenVPN કમ્પ્રેશન નકારવામાં આવ્યું',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM એન્ક્રિપ્શન ઉપલબ્ધ નથી',
      'openvpn_feature_unsupported': 'અસમર્થિત OpenVPN સુવિધા',
      'network_unavailable': 'ઇન્ટરનેટ કનેક્શન ઉપલબ્ધ નથી',
      'network_lost': 'નેટવર્ક ઉપલબ્ધ નથી',
      'certificate_validation_failed': 'સર્વર સર્ટિફિકેટ નકારવામાં આવ્યું',
      'openvpn_certificate_expired': 'OpenVPN સર્ટિફિકેટની મુદત પૂરી થઈ ગઈ',
      'tunnel_active_for_another_account': 'બીજા એકાઉન્ટની ટનલ હજી સક્રિય છે',
      'tunnel_already_active': 'નેટિવ ટનલ પહેલેથી સક્રિય છે',
      'tunnel_stop_timeout': '$protocol બંધ થવાની પુષ્ટિ થઈ નથી',
      'tunnel_disconnected': '$protocol ખોરવાયું',
      'native_bridge_unavailable': 'Android બ્રિજ ઉપલબ્ધ નથી',
      'native_operation_failed': 'Android કામગીરી ખોરવાઈ',
      'invalid_arguments': 'VPN પેરામીટર અધૂરાં છે',
      'invalid_account_id': 'અમાન્ય VPN એકાઉન્ટ',
      'invalid_device_id': 'અમાન્ય ડિવાઇસ આઇડી',
      'storage_key_not_allowed': 'સ્ટોરેજ કી નકારવામાં આવી',
      'secure_storage_read_failed': 'સુરક્ષિત વાંચન નિષ્ફળ ગયું',
      'secure_storage_write_failed': 'સુરક્ષિત રીતે સાચવવું નિષ્ફળ ગયું',
      'key_generation_failed': 'WireGuard કી બનાવી શકાઈ નથી',
      'csr_generation_failed': 'OpenVPN CSR બનાવી શકાયું નથી',
      'openvpn_recovery_exhausted':
          'OpenVPN પુનઃપ્રાપ્તિ પહેલેથી વપરાઈ ચૂકી છે',
      'openvpn_recovery_failed': 'OpenVPN પુનઃપ્રાપ્તિ નિષ્ફળ ગઈ',
      'openvpn_renewal_required': 'OpenVPN સર્ટિફિકેટનું નવીકરણ જરૂરી છે',
      'other': 'વર્ગીકૃત ન થયેલી નેટિવ VPN ભૂલ',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Androidને ફરી શરૂ કરી શકાય તેવું VPN સેશન મળ્યું નથી. ઍપમાં નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_corrupt':
          'સાચવેલી VPN ફરી શરૂ કરવાની માહિતી અમાન્ય છે અને તેનો ઉપયોગ કરવામાં આવશે નહીં. નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_session_invalid':
          'સાચવેલું સેશન હવે VPN ફરી શરૂ કરી શકતું નથી. ઍપમાં ફરી સાઇન ઇન કરો.',
      'system_vpn_resume_identity_changed':
          'સ્થાનિક VPN ઓળખ બદલાઈ ગઈ છે. ફરી શરૂ કરવાનું બંધ કરવામાં આવ્યું; નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_identity_invalid':
          'ફરી શરૂ કરવા માટેની ઓળખ અમાન્ય છે. નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_storage_failed':
          'Android એન્ક્રિપ્ટેડ ફરી શરૂ કરવાની માહિતી વાંચી કે અપડેટ કરી શક્યું નથી. નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_network_timeout':
          'VPN ફરી શરૂ કરવા માટે Android સમયસર નેટવર્ક શોધી શક્યું નથી. નેટવર્ક ઉપલબ્ધ હોય ત્યારે ફરી પ્રયાસ કરો.',
      'system_vpn_resume_blocked':
          'VPN ફરી શરૂ કરવું બ્લૉક થયું છે. Android સેટિંગ્સ તપાસો, પછી નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_failed':
          'Android VPN ફરી શરૂ કરવું નિષ્ફળ ગયું. ઍપમાં નવું કનેક્શન શરૂ કરો.',
      'system_vpn_resume_error_invalid':
          'Androidએ ઉપયોગ ન કરી શકાય તેવી ફરી શરૂ કરવાની ભૂલ પરત કરી. નવું કનેક્શન શરૂ કરો.',
      'wireguard_identity_store_failed':
          'Android આ એકાઉન્ટની એન્ક્રિપ્ટેડ WireGuard ઓળખ સાચવી શક્યું નથી.',
      'wireguard_identity_unavailable':
          'આ કનેક્શન માટે ઉપયોગ કરી શકાય તેવી WireGuard ઓળખ ઉપલબ્ધ નથી.',
      'vpn_host_destroyed':
          'VPN ચલાવતો Android ઘટક બંધ થઈ ગયો. નવું કનેક્શન શરૂ કરો.',
      'vpn_host_unavailable':
          'Android VPN ચલાવતો ઘટક બનાવી શકતું નથી. VPN સેટિંગ્સ તપાસ્યા પછી ફરી પ્રયાસ કરો.',
      'openvpn_renewal_required':
          'કનેક્ટ કરતાં પહેલાં ઍપમાં સર્ટિફિકેટ માટે કાર્યવાહી કરવી જરૂરી છે.',
      'openvpn_recovery_failed':
          'આપમેળે પુનઃપ્રાપ્તિ નિષ્ફળ ગઈ. ઍપમાં નવું કનેક્શન શરૂ કરો.',
      'openvpn_recovery_exhausted':
          'આપમેળે પુનઃપ્રાપ્તિ પહેલેથી વાપરવામાં આવી ચૂકી છે. ઍપમાં નવું કનેક્શન શરૂ કરો.',
      'vpn_permission_required':
          'ટનલ શરૂ કરતાં પહેલાં Androidને નવી VPN પરવાનગી જરૂરી છે.',
      'vpn_permission_denied':
          'ચાલુ રાખવા માટે Androidની વિનંતીમાં FuzeVPNને મંજૂરી આપો.',
      'vpn_permission_request_failed':
          'Android VPN પરવાનગીની સ્ક્રીન ખોલી શક્યું નથી.',
      'wireguard_foreground_service_unavailable':
          'Android WireGuard સેવાને ફોરગ્રાઉન્ડમાં રાખી શક્યું નથી.',
      'wireguard_identity_invalid':
          'આ એકાઉન્ટની એન્ક્રિપ્ટેડ WireGuard કી વાંચી શકાતી નથી અથવા અમાન્ય છે.',
      'wireguard_identity_in_use':
          'બીજી કામગીરી હજી આ એકાઉન્ટની WireGuard કી વાપરી રહી છે.',
      'wireguard_configuration_invalid':
          'પ્રાપ્ત થયેલું WireGuard સરનામું, DNS, સર્વર કી અથવા રૂટ અમાન્ય છે.',
      'wireguard_operation_pending':
          'અગાઉની WireGuard કામગીરીએ હજી તેની નેટિવ સેવા છોડી નથી.',
      'wireguard_start_failed':
          'WireGuard એન્જિને ગોઠવણી સક્રિય કરવાનું નકાર્યું.',
      'wireguard_stop_timeout':
          'નિર્ધારિત સમયમર્યાદામાં WireGuard સેવાએ VPN ઇન્ટરફેસ છોડ્યાની પુષ્ટિ કરી નથી.',
      'wireguard_handshake_timeout':
          'ટનલે સમયસર સર્વર સાથે હેન્ડશેકની પુષ્ટિ કરી નથી.',
      'openvpn_connection_timeout':
          'OpenVPNએ સમયસર સર્વર સાથેના કનેક્શનની પુષ્ટિ કરી નથી.',
      'openvpn_core_unavailable':
          'આ ઍપ વર્ઝનમાં ઉપયોગ કરી શકાય તેવું OpenVPN એન્જિન નથી.',
      'openvpn_operation_pending':
          'નેટિવ એન્જિન હજી અગાઉનું OpenVPN સેશન રાખે છે અને બીજું સેશન બનાવવાનો ઇનકાર કરે છે.',
      'openvpn_stop_timeout':
          'નિર્ધારિત સમયમર્યાદામાં OpenVPN કોરે પુષ્ટિ કરી નથી કે તેનું નેટિવ સેશન બંધ થયું અને દૂર કરવામાં આવ્યું.',
      'openvpn_profile_unavailable':
          'આ કનેક્શન માટે માન્ય OpenVPN પ્રોફાઇલ વાંચી શકાતી નથી.',
      'openvpn_native_failed':
          'ઍપની ભૂલને કારણે OpenVPN ખોરવાયું. ફરી કનેક્ટ કરવાનો પ્રયાસ કરો. સમસ્યા ચાલુ રહે તો ડાયગ્નોસ્ટિક્સ ચલાવો.',
      'openvpn_key_generation_failed':
          'Android Keystore નિકાસ ન કરી શકાય તેવી P-256 ખાનગી કી બનાવી કે વાંચી શક્યું નથી.',
      'openvpn_csr_generation_failed':
          'Android Keystore કી OpenVPN સર્ટિફિકેટ વિનંતી પર સહી કરી શકી નથી.',
      'openvpn_identity_store_failed':
          'OpenVPN સર્ટિફિકેટ કે પ્રોફાઇલ એન્ક્રિપ્ટેડ સ્ટોરેજમાં સાચવી શકાયાં નથી.',
      'openvpn_identity_clear_failed':
          'Android આ એકાઉન્ટની સંપૂર્ણ સ્થાનિક OpenVPN ઓળખ દૂર કરી શક્યું નથી.',
      'openvpn_identity_in_use':
          'નેટિવ OpenVPN સેશન હજી આ ડિવાઇસની કી અથવા સર્ટિફિકેટ વાપરી રહ્યું છે.',
      'openvpn_tls_verification_required':
          'પ્રોફાઇલમાં સર્વર સર્ટિફિકેટ ચકાસણી સ્પષ્ટપણે જરૂરી કરવામાં આવી નથી.',
      'openvpn_cipher_invalid':
          'સર્વરે મંજૂર યાદીમાં ન હોય તેવું એન્ક્રિપ્શન અલ્ગોરિધમ મોકલ્યું છે.',
      'openvpn_profile_rejected':
          'સર્વર તરફથી મળેલી પ્રોફાઇલ અસંગત છે. આ ડિવાઇસ ફરીથી બનાવો અને ફરી પ્રયાસ કરો.',
      'openvpn_identity_inconsistent':
          'સર્ટિફિકેટ આ ફોનની સુરક્ષિત ઓળખ સાથે મેળ ખાતું નથી. કોઈ સ્થાનિક પ્રોફાઇલ બદલવામાં આવી નથી.',
      'tls_handshake_failed':
          'સર્વરે TLS વાટાઘાટ નકારી. સમસ્યા ચાલુ રહે તો પ્રોફાઇલ ફરીથી બનાવો.',
      'tls_alert_unknown_ca':
          'સર્વર આ ડિવાઇસ સર્ટિફિકેટની ઑથોરિટીને ઓળખતું નથી. OpenVPN સર્વર તપાસવું જરૂરી છે.',
      'tls_alert_bad_certificate':
          'સર્વરે આ ડિવાઇસ સર્ટિફિકેટ નકાર્યું છે. ફરી પ્રયાસ કરતાં પહેલાં ડિવાઇસ ફરીથી બનાવો.',
      'tls_alert_unsupported_certificate':
          'સર્વર Android દ્વારા વપરાતા સુરક્ષિત સર્ટિફિકેટ પ્રકારને સપોર્ટ કરતું નથી.',
      'tls_client_certificate_required':
          'સર્વરને ક્લાયન્ટ સર્ટિફિકેટ જોઈએ છે, પરંતુ OpenVPN કોર તે રજૂ કરી શક્યું નથી.',
      'tls_alert_misc':
          'સર્વરે સર્ટિફિકેટ અને વર્ઝન શ્રેણીઓ સિવાયની TLS ચેતવણી પરત કરી.',
      'tls_signature_algorithm_rejected':
          'સર્વરે Android Keystore કીના ECDSA P-256 અલ્ગોરિધમને નકાર્યું છે.',
      'tls_handshake_rejected':
          'કનેક્શન થતાં પહેલાં સર્વરે TLS વાટાઘાટ અટકાવી દીધી.',
      'tls_version_rejected':
          'ક્લાયન્ટ અને સર્વરને કોઈ સમાન TLS વર્ઝન મળ્યું નથી.',
      'tls_certificate_expired':
          'કનેક્શન દરમિયાન રજૂ કરાયેલા સર્ટિફિકેટની મુદત પૂરી થઈ ગઈ છે.',
      'tls_certificate_revoked':
          'કનેક્શન દરમિયાન રજૂ કરાયેલું સર્ટિફિકેટ રદ કરવામાં આવ્યું છે.',
      'transport_failed':
          'વર્તમાન નેટવર્ક પર OpenVPN સર્વર જવાબ આપી રહ્યું નથી. થોડી વારમાં ફરી પ્રયાસ કરો.',
      'tun_configuration_rejected':
          'OpenVPN દ્વારા વિનંતી કરાયેલી નેટવર્ક ગોઠવણી Androidએ નકારી.',
      'tun_setup_failed':
          'Android ઇન્ટરફેસ બનાવતાં પહેલાં OpenVPN કોરે નેટવર્ક યોજના નકારી.',
      'tun_interface_create_failed':
          'OpenVPN કોર Android VpnService પાસેથી TUN ઇન્ટરફેસ મેળવી શક્યું નથી.',
      'tun_interface_disabled':
          'કનેક્શન દરમિયાન Android અથવા OpenVPN કોરે TUN ઇન્ટરફેસ અક્ષમ કર્યું.',
      'tun_halted': 'OpenVPN કોરને TUN ઇન્ટરફેસ બંધ કરવાની વિનંતી મળી.',
      'tun_already_established':
          'એક જ કનેક્શનમાં OpenVPNએ બીજા ઇન્ટરફેસની વિનંતી કરી. સુરક્ષા માટે ટનલ બંધ કરવામાં આવી.',
      'tun_addresses_missing':
          'સર્વરે ઉપયોગ કરી શકાય તેવું ટનલ સરનામું આપ્યું નથી.',
      'tun_routes_missing': 'સર્વરે ઉપયોગ કરી શકાય તેવા ટનલ રૂટ આપ્યા નથી.',
      'tun_dns_missing': 'સર્વરે ઉપયોગ કરી શકાય તેવું DNS સર્વર આપ્યું નથી.',
      'tun_permission_revoked': 'કનેક્શન દરમિયાન Androidએ VPN પરવાનગી રદ કરી.',
      'tun_establish_returned_null':
          'Androidએ ઇન્ટરફેસ બનાવ્યું નથી, સામાન્ય રીતે કારણ કે બીજું VPN હજી સક્રિય છે.',
      'openvpn_service_start_failed':
          'Android OpenVPN ફોરગ્રાઉન્ડ સેવા શરૂ કરી શક્યું નથી.',
      'openvpn_operation_timeout':
          'OpenVPN કોર માટેનો JNI કૉલ તેની મહત્તમ અવધિ વટાવી ગયો.',
      'openvpn_start_failed':
          'Android સેવા તૈયાર છે, પરંતુ OpenVPN કોરે પ્રોફાઇલ શરૂ કરવાનું સ્વીકાર્યું નથી.',
      'openvpn_connection_failed':
          'CONNECTED ઇવેન્ટ મોકલે તે પહેલાં OpenVPN કોર બંધ થઈ ગયું.',
      'openvpn_core_status_error':
          'નેટિવ OpenVPN લૂપ ભૂલ સાથે સમાપ્ત થયો, અને તેની વધુ ચોક્કસ અંતિમ ઇવેન્ટ નથી.',
      'openvpn_stopped_before_connected':
          'સ્પષ્ટ કોર ભૂલ વિના, નેટિવ OpenVPN લૂપ CONNECTED પહેલાં બંધ થયો.',
      'openvpn_auth_failed': 'OpenVPN સર્વરે પ્રોફાઇલનું પ્રમાણીકરણ નકાર્યું.',
      'openvpn_client_setup_failed':
          'નેટવર્ક કનેક્શન પહેલાં OpenVPN કોર ક્લાયન્ટને શરૂ કરી શક્યું નથી.',
      'openvpn_client_halted':
          'OpenVPN કોરને ક્લાયન્ટ બંધ કરવાની અંતિમ વિનંતી મળી.',
      'openvpn_client_restart':
          'OpenVPN કોરે તેના ટ્રાન્સપોર્ટ સેશનને ફરી શરૂ કરવાની વિનંતી કરી.',
      'openvpn_inactive_timeout':
          'નિષ્ક્રિયતાની સમયમર્યાદા પછી OpenVPN કોરે સેશન બંધ કર્યું.',
      'openvpn_session_expired':
          'સર્વરે જણાવ્યું કે OpenVPN સેશનની મુદત પૂરી થઈ ગઈ છે.',
      'openvpn_credentials_required':
          'સર્વર અથવા પ્રોક્સી એવા ઇન્ટરેક્ટિવ ક્રેડેન્શિયલ માંગે છે જે આ સર્ટિફિકેટ પ્રોફાઇલનો ભાગ નથી.',
      'openvpn_proxy_failed':
          'OpenVPN કોરે ગોઠવેલી પ્રોક્સી અથવા રિલેમાં નિષ્ફળતાની જાણ કરી.',
      'openvpn_compression_failed':
          'OpenVPN કોરે પ્રોફાઇલ અથવા સર્વર દ્વારા જાહેર કરાયેલો કમ્પ્રેશન મોડ નકાર્યો.',
      'openvpn_ntlm_crypto_unavailable':
          'પ્રોફાઇલ એવું NTLM એન્ક્રિપ્શન માંગે છે જે આ વર્ઝનમાં ઉપલબ્ધ નથી.',
      'openvpn_feature_unsupported':
          'પ્રોફાઇલ અથવા સર્વરને આ Android ક્લાયન્ટમાં ન હોય તેવી સુવિધા જોઈએ છે.',
      'network_unavailable': 'ઉપયોગ કરી શકાય તેવું ભૌતિક નેટવર્ક ઉપલબ્ધ નથી.',
      'network_lost': 'નેટવર્ક ખોવાયા પછી ટનલ બંધ કરવામાં આવી.',
      'certificate_validation_failed': 'OpenVPN સર્વરની ઓળખ ચકાસી શકાઈ નથી.',
      'openvpn_certificate_expired':
          'ફરી કનેક્ટ કરતાં પહેલાં OpenVPN પ્રોફાઇલનું નવીકરણ કરો.',
      'tunnel_active_for_another_account':
          'આ કનેક્શન પહેલાં બીજા એકાઉન્ટની ટનલ બંધ થવી જરૂરી છે.',
      'tunnel_already_active':
          'Android જણાવે છે કે અગાઉનું VPN સેશન હજી ઇન્ટરફેસ વાપરી રહ્યું છે.',
      'tunnel_stop_timeout':
          'નિર્ધારિત સમયમર્યાદામાં $protocol એન્જિને VPN ઇન્ટરફેસ છોડ્યાની પુષ્ટિ કરી નથી.',
      'tunnel_disconnected':
          'શરૂ થયા પછી ટનલ અણધારી રીતે બંધ થઈ હોવાની જાણ નેટિવ એન્જિને કરી.',
      'native_bridge_unavailable':
          'ઍપ Android VPN સેવાને ઍક્સેસ કરી શકતી નથી. ઍપ બંધ કરીને ફરી ખોલો, પછી ફરી પ્રયાસ કરો.',
      'native_operation_failed':
          'ઍપની ભૂલને કારણે VPN કામગીરી ખોરવાઈ. ફરી પ્રયાસ કરો. સમસ્યા ચાલુ રહે તો ડાયગ્નોસ્ટિક્સ ચલાવો.',
      'invalid_arguments':
          'આ VPN કામગીરી માટે જરૂરી માહિતી અધૂરી છે. ફરી પ્રયાસ કરો. સમસ્યા ચાલુ રહે તો ડાયગ્નોસ્ટિક્સ ચલાવો.',
      'invalid_account_id':
          'નેટિવ કામગીરી માન્ય એકાઉન્ટ આઇડી સાથે જોડાયેલી નથી.',
      'invalid_device_id':
          'નેટિવ એન્જિનને મોકલાયેલું ડિવાઇસ આઇડી ગુમ છે અથવા અમાન્ય છે.',
      'storage_key_not_allowed':
          'Android બ્રિજે મંજૂર સ્ટોરેજ યાદીની બહારની કી બ્લૉક કરી.',
      'secure_storage_read_failed':
          'Android Keystore આ એકાઉન્ટનો સ્થાનિક ડેટા ડિક્રિપ્ટ કરી શક્યું નથી.',
      'secure_storage_write_failed':
          'Android Keystore સ્થાનિક ડેટા એન્ક્રિપ્ટ કે સાચવી શક્યું નથી.',
      'key_generation_failed':
          'Android સુરક્ષિત સ્ટોરેજમાં WireGuard કી બનાવી કે વાંચી શક્યું નથી.',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSR બનાવી કે તેના પર સહી કરી શક્યું નથી.',
      'other':
          'દસ્તાવેજીકૃત ન હોય તેવી નેટિવ શાખા નિષ્ફળ ગઈ. નીચે બતાવેલો ડાયગ્નોસ્ટિક કોડ સપોર્ટને મોકલો.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'પરવાનગીની વિનંતી પહેલેથી ખુલ્લી છે';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN પરવાનગીની વિનંતી પહેલેથી બતાવવામાં આવી રહી છે. ફરી પ્રયાસ કરતાં પહેલાં તેને પૂર્ણ કરો.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN પરવાનગીની વિનંતી ખોરવાઈ';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'ઍપને જવાબ મળે તે પહેલાં VPN પરવાનગીની સ્ક્રીન બંધ થઈ ગઈ.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN કનેક્શનની પુષ્ટિ થઈ નથી';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN કનેક્શનની પુષ્ટિ થઈ શકી નહીં. સુરક્ષા માટે તેને બંધ કરવામાં આવ્યું છે. ફરી પ્રયાસ કરો.';

  @override
  String get openvpnCleanup_title => 'OpenVPN પ્રોફાઇલ રદ કરાઈ';

  @override
  String get openvpnCleanup_working =>
      'રદ કરાયેલી OpenVPN પ્રોફાઇલ બંધ અને દૂર કરવામાં આવી રહી છે…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN બંધ થવાની પુષ્ટિ થઈ નથી. નવી પ્રોફાઇલ બનાવતાં પહેલાં ફરી પ્રયાસ કરો.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'રદ કરાયેલી OpenVPN પ્રોફાઇલ સંપૂર્ણપણે દૂર કરી શકાઈ નથી. સાફસફાઈ માટે ફરી પ્રયાસ કરો.';

  @override
  String get openvpnCleanup_complete =>
      'રદ કરાયેલી OpenVPN પ્રોફાઇલ દૂર કરવામાં આવી છે. નવી બનાવવા માટે “કનેક્ટ કરો” પર ટૅપ કરો.';

  @override
  String get network_title => 'નેટવર્ક ગોઠવણી';

  @override
  String get network_ipv4Fallback =>
      'IPv6 અસ્થાયી રૂપે ઉપલબ્ધ નથી. તૈયારી IPv4 સાથે ચાલુ રહે છે.';

  @override
  String get network_rejectedTitle => 'નેટવર્ક ગોઠવણી નકારાઈ';

  @override
  String get network_rejectedMessage =>
      'ટનલ ગોઠવણી અધૂરી છે અથવા અધિકૃત સરનામાં સાથે મેળ ખાતી નથી. ઍપમાંથી ફરી પ્રયાસ કરો.';

  @override
  String get network_unreadableTitle => 'સ્થાનિક ગોઠવણી વાંચી શકાતી નથી';

  @override
  String get network_unreadableMessage =>
      'સાચવેલી OpenVPN નેટવર્ક ગોઠવણીનો ઉપયોગ થઈ શકતો નથી. તેને અપડેટ કરવા ઍપમાંથી ફરી કનેક્ટ કરો.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'નેટવર્ક સુરક્ષા';

  @override
  String get protection_subtitle =>
      'VPN ડિસ્કનેક્ટ થાય તો ઇન્ટરનેટની સીધી ઍક્સેસ બ્લૉક કરો.';

  @override
  String get protection_active => 'સિસ્ટમ સુરક્ષા સક્રિય';

  @override
  String get protection_alwaysOnOnly =>
      'હંમેશાં-ચાલુ VPN સક્રિય છે; VPN બહારના કનેક્શન બ્લૉક કરવાનું ચાલુ કરો';

  @override
  String get protection_inactive => 'સિસ્ટમ સુરક્ષા નિષ્ક્રિય';

  @override
  String get protection_unknown => 'સિસ્ટમ સુરક્ષા તપાસો';

  @override
  String get protection_openSettings => 'Android સેટિંગ્સ ખોલો';

  @override
  String get protection_dialogTitle => 'નેટવર્ક સુરક્ષા સેટ કરો';

  @override
  String get protection_dialogMessage =>
      'Android હંમેશાં-ચાલુ VPN અને VPN બહારના કનેક્શન બ્લૉક કરવાનું મેનેજ કરે છે. FuzeVPN પસંદ થયેલું છે કે નહીં તે તપાસો અને સિસ્ટમ સેટિંગ્સમાં બ્લૉકિંગ ચાલુ કરો.';

  @override
  String get protection_dialogOpen => 'સેટિંગ્સ ખોલો';

  @override
  String get session_systemProtectionNote =>
      'જો Android હજી પણ VPN બહારનો ટ્રાફિક બ્લૉક કરતું હોય, તો આ સુરક્ષા તપાસવા અથવા બદલવા માટે સિસ્ટમ સેટિંગ્સ ખોલો.';

  @override
  String get diagnostics_title => 'ડાયગ્નોસ્ટિક્સ';

  @override
  String get diagnostics_settingsTitle => 'ઍપ ડાયગ્નોસ્ટિક્સ';

  @override
  String get diagnostics_automaticTitle => 'મહત્ત્વપૂર્ણ ભૂલો મોકલો';

  @override
  String get diagnostics_automaticDescription =>
      'જ્યારે મહત્ત્વપૂર્ણ ભૂલ આવે ત્યારે એક નાનો તકનીકી રિપોર્ટ શેર કરો.';

  @override
  String get diagnostics_privacy =>
      'મોકલેલા રિપોર્ટ સાઇન ઇન કરેલા એકાઉન્ટ સાથે જોડાયેલા હોય છે અને 30 દિવસ સુધી રાખવામાં આવે છે. તેમાં બ્રાઉઝિંગ ઇતિહાસ, પાસવર્ડ અથવા VPN કી હોતાં નથી.';

  @override
  String get diagnostics_manualOpen => 'ડાયગ્નોસ્ટિક્સ ચલાવો';

  @override
  String get diagnostics_localDescription =>
      'ઍપ અને VPNની સ્થિતિનો રિપોર્ટ બનાવો. તમારું કનેક્શન બદલાશે નહીં.';

  @override
  String get diagnostics_sendReport => 'રિપોર્ટ મોકલો';

  @override
  String get diagnostics_sendHint =>
      'રિપોર્ટ આ ડિવાઇસ પર રાખવા માટે આ બૉક્સ અનચેક રાખો.';

  @override
  String get diagnostics_signedOut =>
      'રિપોર્ટ મોકલવા માટે તમારા એકાઉન્ટમાં સાઇન ઇન કરો.';

  @override
  String get diagnostics_localLifetime =>
      'ઍપ બંધ કર્યા પછી પણ આ રિપોર્ટ રાખવા માટે તેને તમારા ફોન પર સાચવો.';

  @override
  String get diagnostics_run => 'ડાયગ્નોસ્ટિક્સ ચલાવો';

  @override
  String get diagnostics_rerun => 'ફરી ડાયગ્નોસ્ટિક્સ ચલાવો';

  @override
  String get diagnostics_running => 'તપાસ ચાલી રહી છે…';

  @override
  String get diagnostics_sending => 'રિપોર્ટ મોકલાઈ રહ્યો છે…';

  @override
  String get diagnostics_prepared => 'આ ડિવાઇસ પર રિપોર્ટ તૈયાર છે';

  @override
  String get diagnostics_queued => 'રિપોર્ટ મોકલવાની રાહ જોઈ રહ્યો છે';

  @override
  String get diagnostics_sent => 'રિપોર્ટ પ્રાપ્ત થયો';

  @override
  String get diagnostics_failed =>
      'મોકલી શકાયો નથી. તમારો સ્થાનિક રિપોર્ટ હજી ઉપલબ્ધ છે.';

  @override
  String get diagnostics_preparationFailed =>
      'ડાયગ્નોસ્ટિક રિપોર્ટ તૈયાર કરી શકાયો નથી. ફરી પ્રયાસ કરો.';

  @override
  String get diagnostics_authenticationRequired =>
      'રિપોર્ટ મોકલવા માટે ફરી સાઇન ઇન કરો.';

  @override
  String get diagnostics_retry => 'મોકલવાનો ફરી પ્રયાસ કરો';

  @override
  String get diagnostics_export => 'રિપોર્ટ સાચવો';

  @override
  String get diagnostics_exportFailed =>
      'સાચવી શકાયો નથી. સ્થાનિક રિપોર્ટ પરથી ફરી પ્રયાસ કરો.';

  @override
  String get diagnostics_preferenceFailed =>
      'આ સેટિંગ સાચવી શકાઈ નથી. ફરી પ્રયાસ કરો.';

  @override
  String diagnostics_receipt(Object id) {
    return 'સંદર્ભ: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$dateના રોજ પ્રાપ્ત થયો';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date સુધી રાખવામાં આવશે';
  }

  @override
  String get diagnostics_duplicate =>
      'આ રિપોર્ટ પહેલેથી પ્રાપ્ત થઈ ચૂક્યો હતો.';

  @override
  String get diagnostics_preview => 'રિપોર્ટનું પૂર્વાવલોકન';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count તકનીકી ઇવેન્ટ જોડાઈ છે',
      one: '1 તકનીકી ઇવેન્ટ જોડાઈ છે',
      zero: 'કોઈ તકનીકી ઇવેન્ટ જોડાઈ નથી',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'તકનીકી વિગતો';

  @override
  String get diagnostics_empty =>
      'હજી સુધી કોઈ ડાયગ્નોસ્ટિક રિપોર્ટ તૈયાર થયો નથી.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ટનલની સ્થિતિ',
      'handshake': 'કનેક્શનની પુષ્ટિ',
      'certificate': 'VPN સર્ટિફિકેટ',
      'kill_switch': 'Android સુરક્ષા',
      'connectivity': 'ઉપલબ્ધ નેટવર્ક',
      'api_reachability': 'સેવાની ઍક્સેસ',
      'secure_storage': 'સુરક્ષિત સ્ટોરેજ',
      'other': 'સ્થાનિક તપાસ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'તપાસી લેવાયું',
      'failed': 'ધ્યાન આપવાની જરૂર છે',
      'skipped': 'તપાસ થઈ નથી — કોઈ સક્રિય તપાસ નથી',
      'unknown': 'માહિતી ઉપલબ્ધ નથી',
      'other': 'માહિતી ઉપલબ્ધ નથી',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPNમાં તમારું સ્વાગત છે';

  @override
  String get connection_changeLocation => 'સ્થાન બદલો';

  @override
  String get connection_details => 'કનેક્શનની વિગતો';

  @override
  String get locations_searchLabel => 'શહેર અથવા દેશ શોધો';

  @override
  String get locations_clearSearch => 'શોધ સાફ કરો';

  @override
  String get locations_filterAll => 'બધા';

  @override
  String get locations_filterFavorites => 'મનપસંદ';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count સ્થાનો',
      one: '$count સ્થાન',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'કોઈ સ્થાન મળ્યું નથી';

  @override
  String get locations_noResultsHint => 'બીજું શહેર અથવા દેશ અજમાવો.';

  @override
  String get locations_noFavorites => 'તમારાં મનપસંદ, હાથવગાં';

  @override
  String get locations_noFavoritesHint =>
      'અહીં સાચવવા માટે સ્થાનની બાજુમાં આવેલા સ્ટારને ટૅપ કરો.';

  @override
  String get locations_showAll => 'બધાં સ્થાનો જુઓ';

  @override
  String locations_addFavorite(String name) {
    return '$nameને મનપસંદમાં ઉમેરો';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$nameને મનપસંદમાંથી દૂર કરો';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'મનપસંદ સાચવી શકાયું નથી. ફરી પ્રયાસ કરો.';

  @override
  String get locations_emptyTitle => 'કોઈ સ્થાન ઉપલબ્ધ નથી';

  @override
  String get locations_emptyHint => 'ફરી પ્રયાસ કરવા માટે યાદી રિફ્રેશ કરો.';

  @override
  String get devices_manage => 'મારા ડિવાઇસો મેનેજ કરો';

  @override
  String get settings_personalization => 'તમારી પસંદગી મુજબ';

  @override
  String get settings_safety => 'સુરક્ષા';

  @override
  String get settings_help => 'મદદ જોઈએ છે?';

  @override
  String get settings_about => 'FuzeVPN વિશે';

  @override
  String get diagnostics_heading => 'કનેક્શનની સમસ્યા સમજો';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ઉપલબ્ધ',
      'pending': 'તૈયાર થઈ રહ્યું છે',
      'revoked': 'દૂર કરાયું',
      'expired': 'મુદત પૂરી થઈ',
      'other': 'સ્થિતિ ઉપલબ્ધ નથી',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'પસંદગી સાચવી શકાઈ નથી';

  @override
  String get notice_preferenceSave_message =>
      'તમારી પસંદગી હાલ લાગુ છે, પરંતુ તે સાચવી શકાઈ નથી. ઍપ બંધ કર્યા પછી પણ તે રાખવા માટે ફરી પ્રયાસ કરો.';

  @override
  String get connection_androidDisconnectHint =>
      'જો Android VPN ચાલુ રાખે, તો ખૂલતી સેટિંગ્સમાં “હંમેશાં-ચાલુ VPN” બંધ કરો.';

  @override
  String get protection_learnMore => 'Android સુરક્ષા વિશે જાણો';

  @override
  String get protection_guideWhy =>
      'VPN ડિસ્કનેક્ટ થાય તો આ સુરક્ષા ઍપને સીધા ઇન્ટરનેટનો ઉપયોગ કરતાં અટકાવે છે. તે Androidમાં ગોઠવાય છે.';

  @override
  String get protection_guideAlwaysOnTitle => 'હંમેશાં-ચાલુ VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN સેવાને ચાલુ રાખે છે અને ફોન ફરી શરૂ થયા પછી તેને ફરીથી ચાલુ કરી શકે છે.';

  @override
  String get protection_guideBlockTitle => 'VPN વિના કનેક્શન બ્લૉક કરો';

  @override
  String get protection_guideBlock =>
      'આ સેટિંગ ટ્રાફિકને VPN બાયપાસ કરતાં અટકાવે છે, કનેક્શન ખોરવાય ત્યારે પણ.';

  @override
  String get protection_guideWarning =>
      'આ બ્લૉકિંગ ચાલુ હોય ત્યારે, VPN કનેક્ટ ન થાય ત્યાં સુધી ઇન્ટરનેટ ઍક્સેસ બંધ રહે છે.';

  @override
  String get protection_guideStepsTitle => 'સુરક્ષા ચાલુ કરો';

  @override
  String get protection_guideStep1 => 'નીચેના બટનથી Android VPN સેટિંગ્સ ખોલો.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPNની બાજુમાં આવેલા ગિયર આઇકનથી વિકલ્પો ખોલો.';

  @override
  String get protection_guideStep3 =>
      'જો આ વિકલ્પો ઉપલબ્ધ હોય, તો પહેલાં “હંમેશાં-ચાલુ VPN” ચાલુ કરો, પછી “VPN વિના કનેક્શન બ્લૉક કરો” ચાલુ કરો.';

  @override
  String get protection_guideManufacturers =>
      'ફોન પ્રમાણે નામ અલગ હોઈ શકે છે. જરૂર હોય તો સેટિંગ્સમાં VPN શોધો, જે ઘણી વાર “નેટવર્ક અને ઇન્ટરનેટ” હેઠળ હોય છે.';

  @override
  String get protection_guideDisableTitle => 'આ સુરક્ષા બંધ કરો';

  @override
  String get protection_guideDisable =>
      'એ જ સેટિંગ્સમાં, VPN વિના ઇન્ટરનેટ ઍક્સેસ આપવા માટે “VPN વિના કનેક્શન બ્લૉક કરો” બંધ કરો. જો તમે ઇચ્છતા ન હો કે Android તેને ફરીથી ચાલુ કરે, તો “હંમેશાં-ચાલુ VPN” પણ બંધ કરો.';

  @override
  String get protection_guideManual =>
      'આ સેટિંગ્સ તમે Androidમાં પસંદ કરો છો. FuzeVPN તેમને તમારા વતી બદલતું નથી.';

  @override
  String get locations_changeTitle => 'સ્થાન બદલીએ?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ડિસ્કનેક્ટ થશે, પછી $name સાથે કનેક્ટ કરવાનો પ્રયાસ કરશે.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $name સાથે કનેક્ટ કરવાનો પ્રયાસ કરશે.';
  }

  @override
  String get locations_confirmChange => 'બદલો અને કનેક્ટ કરો';

  @override
  String get locations_changeBusy =>
      'ફેરફાર ચાલી રહ્યો છે. બીજું સ્થાન પસંદ કરતાં પહેલાં રાહ જુઓ.';

  @override
  String get locations_automaticSelection => 'સ્વચાલિત પસંદગી';

  @override
  String get locations_cities => 'શહેરો';

  @override
  String get locations_servers => 'સર્વરો';

  @override
  String locations_viewCities(String name) {
    return '$nameમાં શહેરો જુઓ';
  }

  @override
  String locations_viewServers(String name) {
    return '$nameમાં સર્વરો જુઓ';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count દેશો',
      one: '$count દેશ',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count શહેરો',
      one: '$count શહેર',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count સર્વરો',
      one: '$count સર્વર',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'બધા દેશો';

  @override
  String get locations_backToCountries => 'દેશો પર પાછા જાઓ';

  @override
  String locations_backToCities(String name) {
    return '$nameના શહેરો પર પાછા જાઓ';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name પસંદ કરો';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name પસંદ કરો';
  }

  @override
  String get locations_noCompatibleServer => 'કોઈ સુસંગત સર્વર ઉપલબ્ધ નથી.';

  @override
  String get externalLink_failed =>
      'આ લિંક ખોલી શકાઈ નથી. તમે તેને કૉપિ કરીને તમારા બ્રાઉઝરમાં ખોલી શકો છો.';

  @override
  String get externalLink_copy => 'લિંક કૉપિ કરો';

  @override
  String get externalLink_copied => 'લિંક કૉપિ થઈ ગઈ';

  @override
  String get externalLink_copyFailed =>
      'લિંક કૉપિ કરી શકાઈ નથી. નીચેનું સરનામું પસંદ કરો.';

  @override
  String get settings_deleteAccount => 'મારું એકાઉન્ટ કાઢી નાખો';

  @override
  String get settings_deleteAccountDetail =>
      'એકાઉન્ટ કાઢી નાખવાની વિનંતીની પ્રક્રિયા જુઓ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'તમારું VPN સબ્સ્ક્રિપ્શન પસંદ કરો.';

  @override
  String get billing_subscribe => 'સબ્સ્ક્રાઇબ કરો';

  @override
  String get billing_choosePlan => 'ચાલુ રાખવા માટે પ્લાન પસંદ કરો.';

  @override
  String get billing_monthly => 'માસિક';

  @override
  String get billing_yearly => 'વાર્ષિક';

  @override
  String get billing_continue => 'Google Play સાથે ચાલુ રાખો';

  @override
  String get billing_restore => 'ખરીદીઓ પુનઃસ્થાપિત કરો';

  @override
  String get billing_manage => 'સબ્સ્ક્રિપ્શન મેનેજ કરો';

  @override
  String get billing_deleteAccountWarning =>
      'જો તમારી પાસે Google Play સબ્સ્ક્રિપ્શન હોય, તો તમારું FuzeVPN એકાઉન્ટ કાઢી નાખવાથી તેનું નવીકરણ રદ થતું નથી. Google Playમાં નવીકરણ અલગથી મેનેજ કરો અથવા રદ કરો.';

  @override
  String get billing_deleteAccountContinue =>
      'એકાઉન્ટ કાઢી નાખવાની વિનંતી પર આગળ વધો';

  @override
  String get billing_refresh => 'ઍક્સેસ રિફ્રેશ કરો';

  @override
  String get billing_loadingPlans => 'પ્લાન લોડ થઈ રહ્યા છે…';

  @override
  String get billing_unavailable =>
      'અત્યારે કોઈ પ્લાન ઉપલબ્ધ નથી. પછીથી ફરી પ્રયાસ કરો.';

  @override
  String get billing_comingSoon => 'સબ્સ્ક્રિપ્શન ટૂંક સમયમાં ઉપલબ્ધ થશે.';

  @override
  String get billing_priceDisclosure =>
      'કિંમત Google Play દ્વારા આપવામાં આવે છે. તમે પુષ્ટિ કરો તે પહેલાં અંતિમ રકમ અને લાગુ કરવેરાની પુષ્ટિ કરવામાં આવે છે.';

  @override
  String get billing_renewalMonthly =>
      'રદ ન કરવામાં આવે ત્યાં સુધી દર મહિને આપમેળે નવીકરણ થાય છે. તમે Google Play સબ્સ્ક્રિપ્શનમાં ગમે ત્યારે રદ કરી શકો છો.';

  @override
  String get billing_renewalYearly =>
      'રદ ન કરવામાં આવે ત્યાં સુધી દર વર્ષે આપમેળે નવીકરણ થાય છે. તમે Google Play સબ્સ્ક્રિપ્શનમાં ગમે ત્યારે રદ કરી શકો છો.';

  @override
  String get billing_active => 'તમારી Premium ઍક્સેસ સક્રિય છે';

  @override
  String billing_accessUntil(String date) {
    return '$date સુધી ઍક્સેસ.';
  }

  @override
  String get billing_webManaged =>
      'તમારું સબ્સ્ક્રિપ્શન FuzeVPN વેબસાઇટ પર મેનેજ થાય છે.';

  @override
  String get billing_playManaged =>
      'તમારું સબ્સ્ક્રિપ્શન Google Play દ્વારા મેનેજ થાય છે.';

  @override
  String get billing_playOnHold =>
      'તમારું Google Play સબ્સ્ક્રિપ્શન હોલ્ડ પર છે અથવા ચુકવણીની રાહ જોઈ રહ્યું છે. Google Playમાં તેને ઠીક કરવા “સબ્સ્ક્રિપ્શન મેનેજ કરો” ખોલો.';

  @override
  String get billing_playReceiptUnlinked =>
      'આ Google Play એકાઉન્ટમાં પહેલેથી Fuze Premium સબ્સ્ક્રિપ્શન છે, જે આ FuzeVPN એકાઉન્ટ માટે સક્રિય નથી. Google Playમાં તે જોવા “સબ્સ્ક્રિપ્શન મેનેજ કરો” ખોલો.';

  @override
  String get billing_inactive => 'કોઈ સક્રિય સબ્સ્ક્રિપ્શન નથી.';

  @override
  String get billing_checkingAccess => 'તમારી ઍક્સેસ ચકાસવામાં આવી રહી છે…';

  @override
  String get billing_restoring => 'ખરીદીઓ પુનઃસ્થાપિત થઈ રહી છે…';

  @override
  String get billing_pending =>
      'ચુકવણી બાકી છે. પુષ્ટિ થયા પછી તમારી ઍક્સેસ સક્રિય થશે.';

  @override
  String get billing_cancelled =>
      'ખરીદી રદ થઈ. કોઈ નવું સબ્સ્ક્રિપ્શન સક્રિય થયું નથી.';

  @override
  String get billing_verifying => 'ખરીદી ચકાસવામાં આવી રહી છે…';

  @override
  String get billing_success =>
      'સબ્સ્ક્રિપ્શન સક્રિય થયું. તમારી Premium ઍક્સેસ તૈયાર છે.';

  @override
  String get billing_restored => 'તમારી ખરીદીઓ પુનઃસ્થાપિત થઈ ગઈ છે.';

  @override
  String get billing_restoreEmpty =>
      'આ Google Play એકાઉન્ટ માટે પુનઃસ્થાપિત કરવા જેવી કોઈ ખરીદી નથી.';

  @override
  String get billing_catalogError => 'પ્લાન લોડ કરી શકાયા નથી. ફરી પ્રયાસ કરો.';

  @override
  String get billing_purchaseError => 'ખરીદી શરૂ કરી શકાઈ નથી. ફરી પ્રયાસ કરો.';

  @override
  String get billing_verificationError =>
      'ખરીદીની ચકાસણી અસ્થાયી રૂપે ઉપલબ્ધ નથી. ફરી પ્રયાસ કરવા માટે ખરીદીઓ પુનઃસ્થાપિત કરો.';

  @override
  String get billing_restoreError =>
      'ખરીદીઓ પુનઃસ્થાપિત કરી શકાઈ નથી. ફરી પ્રયાસ કરો.';

  @override
  String get billing_managementError =>
      'સબ્સ્ક્રિપ્શન મેનેજમેન્ટ ખોલી શકાયું નથી. ફરી પ્રયાસ કરો.';

  @override
  String get billing_storeUnavailable => 'આ ડિવાઇસ પર Google Play ઉપલબ્ધ નથી.';

  @override
  String get welcome_title => 'તમારું VPN, હવે સરળ.';

  @override
  String get welcome_description =>
      'તમારા કનેક્શનને સુરક્ષિત રાખો. તમારી ગોપનીયતા પર નિયંત્રણ રાખો.';

  @override
  String get welcome_start => 'શરૂ કરો';

  @override
  String get welcome_alreadyPurchased => 'પહેલેથી ખરીદી કરી છે?';

  @override
  String get welcome_noAccountRequired => 'શરૂ કરવા માટે એકાઉન્ટની જરૂર નથી.';

  @override
  String get guest_accountTitle => 'એકાઉન્ટ લિંક થયેલું નથી';

  @override
  String get guest_accountDescription =>
      'બીજા ડિવાઇસ પર તમારું સબ્સ્ક્રિપ્શન વાપરવા માટે, એ જ Google Play એકાઉન્ટ વડે તમારી ખરીદીઓ પુનઃસ્થાપિત કરો.';

  @override
  String get guest_existingSubscriberSignIn =>
      'પહેલેથી સબ્સ્ક્રાઇબ કર્યું છે? સાઇન ઇન કરો';

  @override
  String get guest_claimTitle => 'FuzeVPNને તમારી સાથે રાખો';

  @override
  String get guest_claimDescription =>
      'તમારા અન્ય ડિવાઇસો પર તમારા સબ્સ્ક્રિપ્શનનો ઉપયોગ કરવા માટે એકાઉન્ટ બનાવો. આ પગલું વૈકલ્પિક છે.';

  @override
  String get guest_skip => 'કદાચ પછીથી';

  @override
  String get guest_activationTitle => 'Fuze Premium સક્રિય છે';

  @override
  String get guest_activationDescription =>
      'તમારું સબ્સ્ક્રિપ્શન તૈયાર છે. તમારું VPN વાપરો અને જ્યારે ઇચ્છો ત્યારે એકાઉન્ટ બનાવો.';

  @override
  String get guest_useVpn => 'મારું VPN વાપરો';

  @override
  String get guest_loginRequired =>
      'આ ખરીદી પહેલેથી FuzeVPN એકાઉન્ટ સાથે લિંક થયેલી છે. તમારા સબ્સ્ક્રિપ્શનની ઍક્સેસ માટે એ એકાઉન્ટમાં સાઇન ઇન કરો.';

  @override
  String get guest_signOutWarning =>
      'એ જ Google Play એકાઉન્ટ વડે ખરીદીઓ પુનઃસ્થાપિત કરીને તમે તમારું સબ્સ્ક્રિપ્શન પાછું મેળવી શકો છો.';

  @override
  String get guest_profileUnavailable =>
      'તમારું એકાઉન્ટ પહેલેથી લિંક થયેલું છે. તમારી વિગતો જોવા અને મેનેજ કરવા માટે સાઇન ઇન કરો.';

  @override
  String get billing_acceptance =>
      'ચાલુ રાખીને, તમે ઉપયોગની શરતો અને ગોપનીયતા નીતિ સ્વીકારો છો.';

  @override
  String get guest_verifyEmailReminder =>
      'તમારું એકાઉન્ટ સુરક્ષિત કરવા માટે તમારા ઇ-મેઇલ સરનામાની પુષ્ટિ કરો. તમે તમારું VPN વાપરવાનું ચાલુ રાખી શકો છો.';

  @override
  String get guest_serviceUnavailable =>
      'સેવા અસ્થાયી રૂપે ઉપલબ્ધ નથી. થોડી વારમાં ફરી પ્રયાસ કરો.';

  @override
  String get guest_restoreError =>
      'તમારી ખરીદીઓ પુનઃસ્થાપિત થઈ શકી નથી. ખરીદી માટે વપરાયેલા Google Play એકાઉન્ટ વડે ફરી પ્રયાસ કરો.';

  @override
  String get guest_claimSuccess =>
      'તમારું એકાઉન્ટ બનાવવામાં આવ્યું છે. તમારું સબ્સ્ક્રિપ્શન અને VPN ઍક્સેસ સચવાયેલાં છે.';

  @override
  String get guest_emailExists =>
      'આ ઇ-મેઇલ પહેલેથી વપરાશમાં છે. બીજું સરનામું પસંદ કરો અથવા તમારા હાલના એકાઉન્ટમાં સાઇન ઇન કરો. તમારી ખરીદી Google Play દ્વારા ઉપલબ્ધ રહે છે.';

  @override
  String get guest_claimError =>
      'તમારું એકાઉન્ટ બનાવી શકાયું નથી. તમે તમારું VPN વાપરવાનું ચાલુ રાખી શકો છો અને પછીથી ફરી પ્રયાસ કરી શકો છો.';

  @override
  String get guest_secureStorageError =>
      'આ ડિવાઇસ પર તમારું સેશન સુરક્ષિત કરી શકાયું નથી. ફરી પ્રયાસ કરો.';

  @override
  String get guest_premiumRequired =>
      'તમારું VPN સક્રિય કરવા માટે સબ્સ્ક્રિપ્શન પસંદ કરો.';

  @override
  String get welcome_viewPlans => 'પ્લાન જુઓ';

  @override
  String get google_continue => 'Google સાથે ચાલુ રાખો';

  @override
  String get google_or => 'અથવા';

  @override
  String get google_title => 'તમારું FuzeVPN એકાઉન્ટ';

  @override
  String get google_settingUp => 'તમારું એકાઉન્ટ બનાવવાનું પૂરું કરો';

  @override
  String get google_country => 'રહેઠાણનો દેશ';

  @override
  String get google_profileDescription =>
      'તમારું FuzeVPN એકાઉન્ટ બનાવવા માટે તમારો દેશ પસંદ કરો અને બે દસ્તાવેજોની સમીક્ષા કરો.';

  @override
  String get google_claimDescription =>
      'તમારા અતિથિ એકાઉન્ટને Google સાથે લિંક કરો. તમારું સબ્સ્ક્રિપ્શન અને ડિવાઇસ આ એકાઉન્ટ સાથે જોડાયેલાં રહે છે.';

  @override
  String get google_linkTitle => 'Googleને FuzeVPN સાથે લિંક કરો';

  @override
  String get google_linkDescription =>
      'તમારા હાલના FuzeVPN એકાઉન્ટની ઍક્સેસની પુષ્ટિ કરો. આ પગલું તમારો Google પાસવર્ડ માંગતું નથી.';

  @override
  String get google_password => 'FuzeVPN પાસવર્ડ';

  @override
  String get google_linkAccount => 'લિંકની પુષ્ટિ કરો';

  @override
  String get google_requestEmail => 'મને પુષ્ટિકરણ ઇ-મેઇલ મોકલો';

  @override
  String get google_emailInstructions =>
      'FuzeVPN ઇ-મેઇલ ખોલો અને પુષ્ટિકરણ કોડ દાખલ કરો.';

  @override
  String get google_emailCode => 'ઇ-મેઇલ પુષ્ટિકરણ કોડ';

  @override
  String get google_confirmEmail => 'કોડની પુષ્ટિ કરો';

  @override
  String get google_restart => 'બીજું Google એકાઉન્ટ પસંદ કરો';

  @override
  String get google_resume => 'આ પ્રયાસ તપાસો';

  @override
  String get google_unavailable =>
      'Google સાઇન ઇન ઉપલબ્ધ નથી. તમે ઇ-મેઇલ અને પાસવર્ડ વાપરી શકો છો.';

  @override
  String get google_expired =>
      'આ પ્રયાસની મુદત પૂરી થઈ ગઈ છે. તેને રદ કરો અને ફરીથી શરૂ કરો.';

  @override
  String get google_conflict =>
      'આ Google એકાઉન્ટ બીજે ક્યાંક પહેલેથી લિંક થયેલું છે. તમારું હાલનું એકાઉન્ટ અને સબ્સ્ક્રિપ્શન યથાવત રહે છે.';

  @override
  String get google_error =>
      'Google સાઇન ઇન નિષ્ફળ થયું. ફરી પ્રયાસ કરો; તમારી હાલની ઍક્સેસ યથાવત રહે છે.';

  @override
  String get google_uncertain =>
      'પરિણામની પુષ્ટિ થઈ શકી નથી. ફરીથી શરૂ કરતાં પહેલાં આ પ્રયાસ તપાસો અથવા તેને રદ કરો.';

  @override
  String get google_cancelFailed =>
      'રદ કરવાની પુષ્ટિ થઈ શકી નથી. આ સ્ક્રીન છોડતાં પહેલાં ફરીથી રદ કરવાનો પ્રયાસ કરો.';

  @override
  String get google_cancelled => 'Google સાઇન ઇન રદ થયું.';

  @override
  String get google_selecting => 'તમારું Google એકાઉન્ટ પસંદ કરો…';

  @override
  String get google_verifying => 'તમારું એકાઉન્ટ ચકાસવામાં આવી રહ્યું છે…';

  @override
  String get google_emailUnavailable =>
      'પુષ્ટિકરણ ઇ-મેઇલ મોકલી શકાયો નથી. પછીથી ફરી પ્રયાસ કરો.';

  @override
  String get google_emailSent =>
      'પુષ્ટિકરણ ઇ-મેઇલ મોકલવામાં આવ્યો. તમારું ઇનબૉક્સ તપાસો.';

  @override
  String get google_rateLimited =>
      'કૃપા કરીને ફરી પ્રયાસ કરતાં પહેલાં રાહ જુઓ.';

  @override
  String get google_busy =>
      'અન્ય કામગીરી ચાલી રહી હોય ત્યારે (VPN કનેક્શન, એકાઉન્ટ અથવા અતિથિ) Google ઉપલબ્ધ નથી. તે પૂરી થયા પછી ફરી પ્રયાસ કરો; તમારી હાલની ઍક્સેસ યથાવત રહે છે.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN પાસવર્ડ ખોટો છે. તમારું હાલનું એકાઉન્ટ યથાવત રહે છે.';

  @override
  String get google_invalidCode =>
      'પુષ્ટિકરણ કોડ અમાન્ય છે અથવા તેની મુદત પૂરી થઈ ગઈ છે.';

  @override
  String get google_accountChanged =>
      'તમારું સેશન બદલાઈ ગયું છે. ફરીથી શરૂ કરતાં પહેલાં આ પ્રયાસ રદ કરો.';

  @override
  String get google_invalidResponse =>
      'જવાબ ચકાસી શકાયો નથી. તમારી હાલની ઍક્સેસ યથાવત રહે છે.';

  @override
  String get google_invalidRegistration => 'તમારો દેશ અને બંને સંમતિઓ તપાસો.';

  @override
  String get google_consentRequired =>
      'ચાલુ રાખવા માટે તમારો દેશ પસંદ કરો અને બંને દસ્તાવેજો સ્વીકારો.';

  @override
  String get google_challengeRequired =>
      'વધારાની સુરક્ષા ચકાસણી જરૂરી છે. તમારી હાલની ઍક્સેસ યથાવત રહે છે.';

  @override
  String get google_challengeUnavailable =>
      'સુરક્ષા ચકાસણી ઉપલબ્ધ નથી. પછીથી ફરી પ્રયાસ કરો.';

  @override
  String get google_intentMismatch =>
      'Google સાઇન ઇનનો અગાઉનો પ્રયાસ હજી બાકી છે. આ કામગીરી શરૂ કરતાં પહેલાં તેને રદ કરો.';

  @override
  String get google_challengeBlocked =>
      'જરૂરી સુરક્ષા ચકાસણી આ ઍપમાં ઉપલબ્ધ નથી. આ કામગીરી અત્યારે પૂરી થઈ શકતી નથી.';

  @override
  String get google_solveChallenge => 'સુરક્ષા ચકાસણી પૂરી કરો';

  @override
  String get google_challengeTitle => 'સુરક્ષા ચકાસણી';

  @override
  String get google_challengeReady =>
      'ચકાસણી પૂર્ણ થઈ. હવે તમે તમારું એકાઉન્ટ બનાવવાની પુષ્ટિ કરી શકો છો.';

  @override
  String get google_challengeExpired =>
      'ચકાસણીની મુદત પૂરી થઈ ગઈ છે. પુષ્ટિ કરતાં પહેલાં તેને ફરીથી પૂરી કરો.';

  @override
  String get google_challengeCancelled =>
      'ચકાસણી રદ થઈ. તમે ફરી પ્રયાસ કરી શકો છો.';

  @override
  String get google_challengeFailed =>
      'સુરક્ષા ચકાસણી નિષ્ફળ ગઈ. ફરી પ્રયાસ કરો.';

  @override
  String get billing_trialTitle => 'Fuze Premium મફત અજમાવો';

  @override
  String get billing_trialSubtitle => 'આજથી જ તમારા કનેક્શનને સુરક્ષિત રાખો.';

  @override
  String get billing_trialWeeks => '2 અઠવાડિયાની મફત ટ્રાયલ';

  @override
  String billing_trialDays(String days) {
    return '$days દિવસની મફત ટ્રાયલ';
  }

  @override
  String get billing_trialStart => 'મારી મફત ટ્રાયલ શરૂ કરો';

  @override
  String billing_trialFirstCharge(String date) {
    return 'જો તમે આજે શરૂ કરો, તો તમારો પહેલો ચાર્જ $dateના રોજ થવાની અપેક્ષા છે.';
  }

  @override
  String get billing_trialTerms =>
      'દર્શાવેલી કિંમતે આપમેળે નવીકરણ થાય છે. ચાર્જ ટાળવા માટે, ટ્રાયલ પૂરી થાય તે પહેલાં Google Playમાં રદ કરો.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'પછી દર મહિને $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'પછી દર વર્ષે $price';
  }

  @override
  String get billing_choosePeriod => 'તમારો પ્લાન પસંદ કરો';

  @override
  String get billing_selectionHint => 'ચાલુ રાખવા માટે પ્લાન પસંદ કરો.';

  @override
  String get billing_benefitConnection => 'એન્ક્રિપ્ટેડ કનેક્શન';

  @override
  String get billing_benefitPrivacy => 'ઑનલાઇન ગોપનીયતા';

  @override
  String get billing_benefitNoAccount => 'નોંધણીની જરૂર નથી';

  @override
  String get billing_cancellation => 'Google Playમાં રદ કરો';

  @override
  String get billing_premiumTitle => 'તમારું કનેક્શન, વધુ સારી રીતે સુરક્ષિત.';

  @override
  String get billing_premiumSubtitle =>
      'તમારી પોતાની ગતિએ તમારા કનેક્શનને સુરક્ષિત રાખો.';

  @override
  String get billing_priceMonthly => 'દર મહિને';

  @override
  String get billing_priceYearly => 'દર વર્ષે';

  @override
  String get billing_trialToday => 'આજે કંઈ ચૂકવવાનું નથી';

  @override
  String get billing_trialConfirmation =>
      'તમે પુષ્ટિ કરો તે પહેલાં Google Play તારીખો, અંતિમ રકમ અને લાગુ કરવેરાની પુષ્ટિ કરે છે.';

  @override
  String get billing_offerChanged =>
      'આ ઑફરની શરતો બદલાઈ ગઈ છે. પ્લાન રિફ્રેશ કરો અને ફરી પસંદ કરો.';

  @override
  String get status_waitingNetwork => 'નેટવર્કની રાહ જોવાઈ રહી છે';

  @override
  String get status_waitingNetworkDetail =>
      'કોઈ નેટવર્ક ઉપલબ્ધ નથી. નેટવર્ક પાછું આવશે ત્યારે VPN કનેક્શન ચકાસશે.';

  @override
  String get locations_favoriteLoadFailed =>
      'મનપસંદ લોડ કરી શકાયાં નથી. ફરી પ્રયાસ કરો.';

  @override
  String get locations_favoritesLoading => 'મનપસંદ લોડ થઈ રહ્યાં છે…';
}
