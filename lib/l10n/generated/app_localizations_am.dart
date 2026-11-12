// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get vpnDisclosure_title => 'ግንኙነትዎን ይጠብቁ';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN በዚህ መሣሪያ እና በFuzeVPN አገልጋዮች መካከል የተመሰጠረ ቱነል ለመፍጠር የAndroid VPN አገልግሎትን (VpnService) ይጠቀማል።';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN ንቁ በሆነ ጊዜ የመተግበሪያዎችዎ የኢንተርኔት ትራፊክ፣ የመድረሻ አድራሻዎች እና የDNS ጥያቄዎች ግንኙነትዎን ለማዘዋወር በዚህ ቱነል ያልፋሉ፤ FuzeVPN ከበስተጀርባ እየሰራ ቢሆንም እንኳ።';

  @override
  String get vpnDisclosure_statusBody =>
      'መተግበሪያው የVPN ግንኙነትዎን ለማሳየት የግንኙነቱን ሁኔታ፣ የቆይታ ጊዜውን እና የተላለፈውን የውሂብ መጠን ይጠቀማል። በማንኛውም ጊዜ ማቆም ይችላሉ።';

  @override
  String get vpnDisclosure_privacy => 'ግላዊነት';

  @override
  String get vpnDisclosure_accept => 'ተቀብለው ይቀጥሉ';

  @override
  String get vpnDisclosure_decline => 'አሁን አይደለም';

  @override
  String get accountRestoration_title => 'መለያ ለጊዜው አይገኝም';

  @override
  String get accountRestoration_message =>
      'ክፍለ ጊዜዎ ተጠብቋል። መለያዎን ለመመለስ እንደገና ይሞክሩ፤ አሁንም የVPN ግንኙነቱን እዚህ ማስተዳደር ይችላሉ።';

  @override
  String get action_retry => 'እንደገና ይሞክሩ';

  @override
  String get session_endingTitle => 'ክፍለ ጊዜውን በመጨረስ ላይ';

  @override
  String get session_ending => 'ክፍለ ጊዜውን በመጨረስ ላይ፦ VPNን በማቆም እና በማጽዳት ላይ…';

  @override
  String get session_stopFailed =>
      'የVPN መዘጋት አልተረጋገጠም። ዳግም ከመግባትዎ በፊት እንደገና ይሞክሩ።';

  @override
  String get session_cleanupFailed =>
      'VPN ቆሟል፣ ነገር ግን የክፍለ ጊዜው መወገድ አልተረጋገጠም። ማጽዳቱን እንደገና ይሞክሩ።';

  @override
  String get session_retryStop => 'መዘጋቱን እንደገና ይሞክሩ';

  @override
  String get session_retryCleanup => 'ማጽዳቱን እንደገና ይሞክሩ';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPNን በአስተማማኝ ሁኔታ በማዘጋጀት ላይ…';

  @override
  String get nav_connection => 'ግንኙነት';

  @override
  String get nav_locations => 'አካባቢዎች';

  @override
  String get nav_account => 'መለያ';

  @override
  String get nav_devices => 'መሣሪያዎች';

  @override
  String get nav_settings => 'ቅንብሮች';

  @override
  String get action_refresh => 'ያድሱ';

  @override
  String get auth_tab_login => 'ይግቡ';

  @override
  String get auth_tab_register => 'ይመዝገቡ';

  @override
  String get auth_stepAccount => 'መለያ';

  @override
  String get auth_stepIdentity => 'ማንነት';

  @override
  String get auth_stepAddress => 'አድራሻ እና ስምምነቶች';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'ደረጃ $current ከ$total';
  }

  @override
  String get auth_tagline => 'የእርስዎ VPN፣ ቀላል ተደርጓል።';

  @override
  String get auth_keysLocal => 'የግል VPN ቁልፎችዎ በዚህ መሣሪያ ላይ ይቆያሉ።';

  @override
  String get form_email => 'የኢሜይል አድራሻ';

  @override
  String get form_password => 'የይለፍ ቃል';

  @override
  String get form_showPassword => 'የይለፍ ቃሉን ያሳዩ';

  @override
  String get form_hidePassword => 'የይለፍ ቃሉን ይደብቁ';

  @override
  String get form_passwordMin =>
      'ከ8 እስከ 72 UTF-8 ባይት። አንዳንድ ቁምፊዎች ከአንድ በላይ ባይት ይጠቀማሉ።';

  @override
  String get form_firstName => 'የመጀመሪያ ስም';

  @override
  String get form_lastName => 'የአያት ስም';

  @override
  String get form_phone => 'ስልክ ቁጥር (+33612345678)';

  @override
  String get form_address => 'አድራሻ';

  @override
  String get form_address2 => 'ተጨማሪ የአድራሻ መስመር (አማራጭ)';

  @override
  String get form_postalCode => 'የፖስታ ኮድ';

  @override
  String get form_city => 'ከተማ';

  @override
  String get form_country => 'የአገር ኮድ (ለምሳሌ FR)';

  @override
  String get action_login => 'ይግቡ';

  @override
  String get action_createAccount => 'መለያ ይፍጠሩ';

  @override
  String get action_createMyAccount => 'መለያዬን ይፍጠሩ';

  @override
  String get action_next => 'ይቀጥሉ';

  @override
  String get action_previous => 'ይመለሱ';

  @override
  String get action_forgotPassword => 'የይለፍ ቃልዎን ረሱ?';

  @override
  String get auth_noAccount => 'ገና መለያ የለዎትም?';

  @override
  String get auth_requiredInformation => 'መለያዎን በሶስት ደረጃዎች ይፍጠሩ።';

  @override
  String get auth_termsPrefix => 'እቀበላለሁ፦ ';

  @override
  String get auth_termsLink => 'የአጠቃቀም ውሎች';

  @override
  String get auth_privacyPrefix => 'እቀበላለሁ፦ ';

  @override
  String get auth_privacyLink => 'የግላዊነት ፖሊሲ';

  @override
  String get auth_consentRequired => 'መለያ ለመፍጠር ፈቃድዎ ያስፈልጋል።';

  @override
  String get validation_required => 'ይህ መስክ ያስፈልጋል።';

  @override
  String get validation_email => 'ትክክለኛ የኢሜይል አድራሻ ያስገቡ።';

  @override
  String get validation_password =>
      'የይለፍ ቃሉ በጣም አጭር ነው፦ ቢያንስ 8 UTF-8 ባይት መሆን አለበት።';

  @override
  String get validation_passwordTooLong =>
      'የይለፍ ቃሉ በጣም ረጅም ነው፦ ከ72 UTF-8 ባይት መብለጥ የለበትም።';

  @override
  String get validation_phone => 'ዓለም አቀፍ ቅርጸት ይጠቀሙ፣ ለምሳሌ +33612345678።';

  @override
  String get validation_country => 'ባለ ሁለት ፊደል የአገር ኮድ ይጠቀሙ፣ ለምሳሌ FR።';

  @override
  String get passwordReset_title => 'የይለፍ ቃል ዳግም ማስጀመር';

  @override
  String get passwordReset_description =>
      'የይለፍ ቃልዎን ዳግም ለማስጀመር አገናኝ ለመጠየቅ የመለያዎን የኢሜይል አድራሻ ያስገቡ።';

  @override
  String get passwordReset_send => 'አገናኙን ይላኩ';

  @override
  String get connection_title => 'ግንኙነትዎ';

  @override
  String get connection_subtitle => 'አካባቢ ይምረጡ፣ ከዚያም VPNዎን ያብሩ።';

  @override
  String get connection_prepare => 'ለመገናኘት ዝግጁ ነዎት?';

  @override
  String get connection_advancedOptions => 'የላቁ አማራጮች';

  @override
  String get connection_location => 'አካባቢ';

  @override
  String get connection_chooseLocation => 'አካባቢ ይምረጡ';

  @override
  String get connection_protocol => 'ፕሮቶኮል';

  @override
  String get connection_connect => 'ይገናኙ';

  @override
  String get connection_connecting => 'በመገናኘት ላይ…';

  @override
  String get connection_disconnect => 'ግንኙነት ያቋርጡ';

  @override
  String get connection_disconnecting => 'ግንኙነት በማቋረጥ ላይ';

  @override
  String get connection_locationChange => 'አካባቢ በመቀየር ላይ…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol አይገኝም';
  }

  @override
  String get connection_activeLocation => 'ንቁ አካባቢ';

  @override
  String get connection_duration => 'ቆይታ';

  @override
  String get connection_received => 'የተቀበለ';

  @override
  String get connection_sent => 'የተላከ';

  @override
  String get connection_lastHandshake => 'የመጨረሻ ደህንነቱ የተጠበቀ ልውውጥ';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'ከ$duration በፊት';
  }

  @override
  String get verification_title => 'የኢሜይል አድራሻዎን ያረጋግጡ';

  @override
  String get verification_message => 'በዚህ ስልክ VPNን ለመጠቀም የኢሜይል አድራሻዎን ያረጋግጡ።';

  @override
  String get verification_resend => 'ኢሜይሉን እንደገና ይላኩ';

  @override
  String get migration_title => 'የአካባቢ ለውጥ';

  @override
  String get migration_draining => 'የአካባቢ ለውጡን በማዘጋጀት ላይ…';

  @override
  String get migration_activating => 'አዲሱን አገልጋይ በማንቃት ላይ…';

  @override
  String get migration_ready => 'አካባቢው ተዘምኗል።';

  @override
  String get migration_blocked =>
      'የአካባቢ ለውጡ የአገልጋይ ጣልቃ ገብነት ይፈልጋል። ቆይተው እንደገና ይሞክሩ ወይም የድጋፍ ቡድኑን ያነጋግሩ።';

  @override
  String get migration_progress => 'የአካባቢ ለውጥ ሂደት';

  @override
  String migration_retryDelay(Object seconds) {
    return 'በፍተሻዎች መካከል ያለው መዘግየት፦ $seconds ሰከንድ።';
  }

  @override
  String get migration_resume => 'የአካባቢ ለውጡን ይቀጥሉ';

  @override
  String get status_authorizing => 'ፈቃድ ያስፈልጋል';

  @override
  String get status_authorizingDetail => 'VPNን ለመፍቀድ የAndroid ጥያቄውን ይቀበሉ።';

  @override
  String get status_preparing => 'በመዘጋጀት ላይ';

  @override
  String get status_preparingDetail => 'ደህንነቱ የተጠበቀ ግንኙነትዎን በማዘጋጀት ላይ።';

  @override
  String get status_reconnecting => 'እንደገና በመገናኘት ላይ…';

  @override
  String get status_reconnectingDetail =>
      'ግንኙነቱ ተስተጓጉሏል። VPN እንደገና ለመገናኘት እየሞከረ ነው።';

  @override
  String get status_connecting => 'በመገናኘት ላይ';

  @override
  String get status_connectingDetail => 'ከVPN አገልጋይ ጋር በመገናኘት ላይ…';

  @override
  String get status_connected => 'ተገናኝቷል';

  @override
  String get status_connectedDetail => 'የVPN ግንኙነትዎ ንቁ ነው።';

  @override
  String get status_disconnecting => 'ግንኙነት በማቋረጥ ላይ';

  @override
  String get status_disconnectingDetail => 'የVPN ግንኙነትዎ በመቆም ላይ ነው።';

  @override
  String get status_error => 'ግንኙነት አይገኝም';

  @override
  String get status_errorDetail => 'የVPN ግንኙነቱ አልተረጋገጠም። እንደገና ይሞክሩ።';

  @override
  String get status_idle => 'ተቋርጧል';

  @override
  String get status_idleDetail => 'ግንኙነትዎን ለመጠበቅ VPNን ያገናኙ።';

  @override
  String get trust_note =>
      'መተግበሪያውን መዝጋት VPNን አያቆምም። ለማቆም “ግንኙነት ያቋርጡ” የሚለውን ይጠቀሙ።';

  @override
  String get locations_none => 'በአሁኑ ጊዜ ምንም አካባቢ አይገኝም።';

  @override
  String get locations_available => 'ቀጣይ አካባቢዎን ይምረጡ።';

  @override
  String get locations_selected => 'የተመረጠ አካባቢ';

  @override
  String get locations_select => 'ይህን አካባቢ ይምረጡ';

  @override
  String get locations_lockedTunnel => 'አካባቢ ለመቀየር የVPN ግንኙነቱን ያቋርጡ።';

  @override
  String get locations_lockedMigration => 'የአካባቢ ለውጡ እስኪጠናቀቅ ይጠብቁ።';

  @override
  String get devices_title => 'መሣሪያዎችዎ';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit መሣሪያዎች';
  }

  @override
  String get devices_refresh => 'መሣሪያዎችን ያድሱ';

  @override
  String get devices_empty => 'እስካሁን የተመዘገበ VPN መሣሪያ የለም።';

  @override
  String get devices_firstConnection => 'ስልክዎ በመጀመሪያው ግንኙነት ላይ ይታከላል።';

  @override
  String get devices_thisDevice => 'ይህ መሣሪያ';

  @override
  String devices_added(Object date) {
    return 'በ$date ታክሏል';
  }

  @override
  String get devices_unnamed => 'ስም የሌለው መሣሪያ';

  @override
  String get action_remove => 'ያስወግዱ';

  @override
  String get settings_title => 'ቅንብሮች';

  @override
  String get settings_subtitle => 'ምርጫዎችዎ እና መለያዎ፣ ሁሉም በአንድ ቦታ።';

  @override
  String get settings_appearance => 'መልክ';

  @override
  String get settings_language => 'ቋንቋ';

  @override
  String get settings_languageDescription => 'የመረጡት ቋንቋ ለVPN ማሳወቂያዎችም ይተገበራል።';

  @override
  String get settings_account => 'መለያ';

  @override
  String get settings_signOut => 'ይውጡ';

  @override
  String get settings_privacy => 'የግላዊነት ፖሊሲ';

  @override
  String get settings_terms => 'የአጠቃቀም ውሎች';

  @override
  String get settings_security => 'ደህንነት እና ግልጽነት';

  @override
  String get settings_licenses => 'የአካላት ፈቃዶች';

  @override
  String get settings_licensesDetail => 'በመተግበሪያው ውስጥ ጥቅም ላይ የዋለ ሶፍትዌር';

  @override
  String settings_licensesLegalese(String url) {
    return 'የመተግበሪያው እና በMPL-2.0 ፈቃድ ያሉ አካላቱ ምንጭ ኮድ፦ $url';
  }

  @override
  String get settings_background =>
      'መተግበሪያውን ሲለቁ VPN በርቶ ይቆያል። ለማቆም በ“ግንኙነት” ትር ላይ “ግንኙነት ያቋርጡ” የሚለውን ይጠቀሙ።';

  @override
  String get theme_system => 'ስርዓት';

  @override
  String get theme_light => 'ብርሃን';

  @override
  String get theme_dark => 'ጨለማ';

  @override
  String get language_system => 'የስልክ ቋንቋ';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'ይህን መሣሪያ ማስወገድ ይፈልጋሉ?';

  @override
  String get dialog_removeCurrent =>
      'ይህ ስልክ ከVPN ይቋረጣል እና መዳረሻ ያጣል። የVPN ግንኙነት ውሂቡ አገልጋዩ ካረጋገጠ በኋላ ይወገዳል።';

  @override
  String dialog_removeOther(Object name) {
    return 'የ“$name” የVPN መዳረሻ ይሰረዛል። ይህ ድርጊት ሊቀለበስ አይችልም።';
  }

  @override
  String get dialog_signOut => 'ከመለያዎ ይውጡ?';

  @override
  String get dialog_signOutMessage =>
      'VPN ይቆማል እና እንደገና መግባት ይኖርብዎታል። የተመሰጠሩ የVPN ቁልፎችዎ ለሚቀጥለው ግንኙነት በዚህ ስልክ ላይ ይቆያሉ።';

  @override
  String get action_cancel => 'ይቅር';

  @override
  String get action_close => 'ዝጋ';

  @override
  String get action_copy => 'ቅዳ';

  @override
  String get action_renew => 'ያድሱ';

  @override
  String get action_signOut => 'ይውጡ';

  @override
  String get notice_close => 'መልዕክቱን ይዝጉ';

  @override
  String get notice_sessionExpired_title => 'ክፍለ ጊዜው አብቅቷል';

  @override
  String get notice_sessionExpired_message => 'ክፍለ ጊዜዎ አብቅቷል። እንደገና ይግቡ።';

  @override
  String get notice_connectionFailed_title => 'ግንኙነት አልተሳካም';

  @override
  String get notice_invalidCredentials_message =>
      'የኢሜይል አድራሻው ወይም የይለፍ ቃሉ ትክክል አይደለም።';

  @override
  String get notice_emailVerification_title => 'የኢሜይል ማረጋገጫ ያስፈልጋል';

  @override
  String get notice_emailVerification_message =>
      'VPN መሣሪያ ከማከልዎ በፊት የኢሜይል አድራሻዎን ያረጋግጡ።';

  @override
  String get notice_rateLimited_title => 'በጣም ብዙ ሙከራዎች';

  @override
  String get notice_deviceLimit_title => 'የመሣሪያ ገደብ ላይ ደርሷል';

  @override
  String get notice_deviceLimit_message => 'ሌላ ከማከልዎ በፊት ያለን መሣሪያ ያስወግዱ።';

  @override
  String get notice_identityRenewal_title => 'የVPN ማንነት መታደስ አለበት';

  @override
  String get notice_identityRenewal_message =>
      'ይህ ማንነት ተወግዷል። በዚህ መሣሪያ ላይ አዲስ ማንነት ይፍጠሩ።';

  @override
  String get notice_migrationPending_title => 'የአካባቢ ለውጥ በሂደት ላይ ነው';

  @override
  String get notice_migrationPending_message => 'የአካባቢ ለውጥ ቀድሞውኑ በሂደት ላይ ነው።';

  @override
  String get notice_migrationBlocked_title => 'የአካባቢ ለውጥ ታግዷል';

  @override
  String get notice_migrationBlocked_message =>
      'የአካባቢ ለውጡ የአገልጋይ ጣልቃ ገብነት ይፈልጋል። ቆይተው እንደገና ይሞክሩ ወይም የድጋፍ ቡድኑን ያነጋግሩ።';

  @override
  String get notice_targetUnavailable_title => 'አገልጋዩ ለጊዜው አይገኝም';

  @override
  String get notice_targetUnavailable_message => 'ይህ አገልጋይ ለጊዜው አይገኝም።';

  @override
  String get notice_networkUnavailable_title => 'የኢንተርኔት ግንኙነት አይገኝም';

  @override
  String get notice_networkUnavailable_message =>
      'ግንኙነትዎን ያረጋግጡ እና እንደገና ይሞክሩ።';

  @override
  String get notice_permissionDenied_title => 'የVPN ፈቃድ ተከልክሏል';

  @override
  String get notice_permissionDenied_message =>
      'ግንኙነቱን እንደገና ይጀምሩ እና የAndroid ፈቃድ ጥያቄውን ይቀበሉ።';

  @override
  String get notice_wireguardTimeout_title => 'አገልጋዩ ምላሽ እየሰጠ አይደለም';

  @override
  String get notice_wireguardTimeout_message =>
      'የWireGuard ግንኙነቱ ከመጠን በላይ ጊዜ ወሰደ። እንደገና ይሞክሩ ወይም ሌላ አካባቢ ይምረጡ።';

  @override
  String get notice_tlsFailed_title => 'ደህንነቱ የተጠበቀ ግንኙነት ውድቅ ተደርጓል';

  @override
  String get notice_tlsFailed_message =>
      'አገልጋዩ የOpenVPN ግንኙነቱን አልተቀበለም። እንደገና ይሞክሩ። ችግሩ ከቀጠለ ምርመራ ያሂዱ።';

  @override
  String get notice_tunRejected_title => 'Android የVPN በይነገጹን ውድቅ አድርጓል';

  @override
  String get notice_tunRejected_message =>
      'Android በOpenVPN የተጠየቀውን የአውታረ መረብ ውቅር ውድቅ አድርጓል።';

  @override
  String get notice_openvpnStart_title => 'OpenVPN መጀመር አልቻለም';

  @override
  String get notice_openvpnStart_message =>
      'የOpenVPN ሞተር መጀመርን ማጠናቀቅ አልቻለም። እንደገና ይሞክሩ። ችግሩ ከቀጠለ የድጋፍ ቡድኑን ያነጋግሩ።';

  @override
  String notice_diagnosticCode(Object code) {
    return 'የምርመራ ኮድ፦ $code';
  }

  @override
  String get notice_generic_title => 'የVPN ግንኙነት አልተሳካም';

  @override
  String get notice_generic_message => 'ስህተት ተፈጥሯል። ቆይተው እንደገና ይሞክሩ።';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'መለያ ተፈጥሯል',
      'password_reset_sent': 'የይለፍ ቃል ዳግም ማስጀመሪያ ጥያቄ ደርሷል',
      'verification_email_sent': 'የማረጋገጫ ኢሜይል ተልኳል',
      'location_migration_pending': 'የአካባቢ ለውጥ በሂደት ላይ ነው',
      'vpn_sign_in_required': 'መግባት ያስፈልጋል',
      'protocol_unavailable_at_location': 'ፕሮቶኮል አይገኝም',
      'vpn_permission_denied': 'የVPN ፈቃድ ተከልክሏል',
      'revoked_identity_device_limit': 'የመሣሪያ ገደብ ላይ ደርሷል',
      'tunnel_start_unexpected': 'VPN መጀመር አልቻለም',
      'flutter_disconnect_timeout': 'ግንኙነቱ መቋረጡ አልተረጋገጠም',
      'flutter_disconnect_unexpected': 'ግንኙነቱን ማቋረጥ አልተቻለም',
      'device_revoked': 'መሣሪያ ተወግዷል',
      'revoke_unexpected': 'መሣሪያውን ማስወገድ አልተቻለም',
      'identity_renewal_unexpected': 'ማንነትን ማደስ አልተቻለም',
      'openvpn_renewal_unexpected': 'OpenVPNን ማደስ አልተቻለም',
      'location_migration_blocked': 'የአካባቢ ለውጥ ታግዷል',
      'location_migration_slow': 'የአካባቢ ለውጡ አሁንም በሂደት ላይ ነው',
      'location_migration_conflict': 'የአካባቢ ለውጡን ማደስ ያስፈልጋል',
      'location_migration_verification_failed': 'የአካባቢ ለውጡ አልተረጋገጠም',
      'location_migration_device_changed': 'በአካባቢ ለውጡ ወቅት መሣሪያው ተቀይሯል',
      'tunnel_stop_failed': 'የአካባቢ ለውጡ አይገኝም',
      'device_clock_ahead': 'የመሣሪያው ሰዓት ቀድሟል',
      'other': 'ስራው አልተሳካም',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'መለያው ተፈጥሯል፣ ነገር ግን የማረጋገጫ ኢሜይሉ ሊላክ አልቻለም። በመተግበሪያው ውስጥ ኢሜይሉን እንደገና ይላኩ።',
      'password_reset_sent':
          'ጥያቄዎ ደርሷል። ይህን አድራሻ የሚጠቀም መለያ ካለ ኢሜይል ሊደርስዎ ይችላል። እባክዎ የአይፈለጌ መልዕክት ማህደርዎንም ይመልከቱ።',
      'verification_email_sent': 'አዲስ የማረጋገጫ ኢሜይል አሁን ተልኳል።',
      'location_migration_pending':
          'ወደ $target የሚደረገው ለውጥ አሁንም በመዘጋጀት ላይ ነው። መሣሪያውን እንደገና ሳይፈጥሩ መቀጠል ይችላሉ።',
      'vpn_sign_in_required': 'VPNን ከመጀመርዎ በፊት ወደ መለያዎ ይግቡ።',
      'protocol_unavailable_at_location':
          'የተመረጠው ፕሮቶኮል በዚህ አካባቢ አይቀርብም። አካባቢዎችን ያድሱ ወይም ሌላ ፕሮቶኮል ይምረጡ።',
      'vpn_permission_denied':
          'Android የVPN ፈቃዱን ከልክሏል። ግንኙነቱን እንደገና ይጀምሩ እና የስርዓቱን ጥያቄ ይቀበሉ።',
      'revoked_identity_device_limit':
          'የዚህ መሣሪያ የVPN መዳረሻ ተወግዷል እና የመሣሪያ ገደቡ ላይ ደርሷል። በመለያ → መሣሪያዎቼን ያስተዳድሩ ስር አንድ መሣሪያ ያስወግዱ።',
      'tunnel_start_unexpected':
          'ያልተጠበቀ ስህተት የቱነል ዝግጅቱን አቋርጧል። የምርመራ ኮዱን ይመልከቱ እና እንደገና ይሞክሩ።',
      'flutter_disconnect_timeout':
          'Android VPN በጊዜ መቆሙን አላረጋገጠም። እንደገና ለማቆም ይሞክሩ።',
      'flutter_disconnect_unexpected': 'ያልተጠበቀ ስህተት ቱነሉ መቆሙ እንዳይረጋገጥ አድርጓል።',
      'device_revoked':
          'የመሣሪያው የVPN መዳረሻ ተሰርዟል እና በመሣሪያው ላይ የነበረው ሚስጥራዊ ውሂብ ተወግዷል።',
      'revoke_unexpected': 'መሣሪያው ሊወገድ አልቻለም። ዝርዝሩን ያድሱ እና እንደገና ይሞክሩ።',
      'identity_renewal_unexpected':
          'አዲሱ የVPN ማንነት ሊፈጠር አልቻለም። መሣሪያዎችን ያድሱ እና እንደገና ይሞክሩ።',
      'openvpn_renewal_unexpected':
          'የOpenVPN መገለጫው ሊታደስ አልቻለም። እንደገና ይሞክሩ ወይም የምርመራ ኮዱን ይመልከቱ።',
      'location_migration_blocked':
          'አገልጋዩ ይህን ለውጥ አሁን ማጠናቀቅ አይችልም። መሣሪያው እና በመሣሪያው ላይ ያለው ማንነት ተጠብቀዋል።',
      'location_migration_slow':
          'አገልጋዩ ወደ $target የሚደረገውን ለውጥ አሁንም እያዘጋጀ ነው። ከጥቂት ጊዜ በኋላ “የአካባቢ ለውጡን ይቀጥሉ” የሚለውን ይጠቀሙ።',
      'location_migration_conflict':
          'የመሣሪያው ሁኔታ በአገልጋዩ ላይ ተቀይሯል። መሣሪያዎችን ያድሱ፣ ከዚያ ለውጡን ይቀጥሉ።',
      'location_migration_verification_failed':
          'አገልጋዩ አዲሱን አካባቢ አላረጋገጠም። ቀደም ሲል የነበረው ማንነት ተጠብቋል።',
      'location_migration_device_changed':
          'አገልጋዩ የመለሰው መሣሪያ አሁን ከሚለወጠው መሣሪያ ጋር አይዛመድም። እንደገና ከመሞከርዎ በፊት መሣሪያዎችን ያድሱ።',
      'tunnel_stop_failed': 'ከአዲሱ ግንኙነት በፊት ቀደም ያለው ቱነል ሙሉ በሙሉ መቆም አለበት።',
      'device_clock_ahead':
          'የዚህ መሣሪያ ሰዓት ከትክክለኛው ሰዓት የቀደመ ይመስላል። ገብተው ለመቆየት ራስ-ሰር ቀን እና ሰዓት ያብሩ።',
      'other': 'ስራው ሊጠናቀቅ አልቻለም። እንደገና ይሞክሩ ወይም የምርመራ ኮዱን ለድጋፍ ቡድኑ ይላኩ።',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ክፍለ ጊዜው አብቅቷል',
      'invalid_credentials': 'መግባት አልተሳካም',
      'email_verification_required': 'የኢሜይል ማረጋገጫ ያስፈልጋል',
      'verification_email_cooldown': 'ኢሜይሉ አስቀድሞ ተልኳል',
      'rate_limited': 'በጣም ብዙ ሙከራዎች',
      'invalid_registration': 'መረጃው መስተካከል አለበት',
      'email_exists': 'መለያ አስቀድሞ አለ',
      'invalid_profile': 'ልክ ያልሆነ መገለጫ',
      'invalid_device': 'ልክ ያልሆነ መሣሪያ',
      'invalid_location': 'አካባቢ አይገኝም',
      'device_limit': 'የመሣሪያ ገደብ ላይ ደርሷል',
      'device_exists': 'የVPN ማንነት አስቀድሞ ጥቅም ላይ ውሏል',
      'device_identity_revoked': 'የVPN ማንነት መታደስ አለበት',
      'device_location_locked': 'የአካባቢ ለውጡን ማደስ ያስፈልጋል',
      'location_migration_pending': 'የአካባቢ ለውጥ በሂደት ላይ ነው',
      'location_migration_blocked': 'የአካባቢ ለውጥ ታግዷል',
      'target_ca_mismatch': 'ተኳሃኝ ያልሆነ የOpenVPN አገልጋይ',
      'location_migration_conflict': 'የአካባቢ ለውጡን ማደስ ያስፈልጋል',
      'server_full': 'አገልጋዩ ሞልቷል',
      'capacity_unavailable': 'አካባቢው ለጊዜው አይገኝም',
      'target_unavailable': 'አገልጋዩ ለጊዜው አይገኝም',
      'not_found': 'ንጥሉ አልተገኘም',
      'invalid_openvpn_csr': 'ልክ ያልሆነ የOpenVPN ማንነት',
      'openvpn_profile_exists': 'የOpenVPN መገለጫ አስቀድሞ አለ',
      'openvpn_profile_revoked': 'የOpenVPN መገለጫ ተሰርዟል',
      'openvpn_operation_pending': 'የOpenVPN ስራ በሂደት ላይ ነው',
      'openvpn_operation_terminal': 'የOpenVPN ስራ ተቋርጧል',
      'openvpn_address_unavailable': 'የOpenVPN አድራሻ አይገኝም',
      'openvpn_profile_conflict': 'የOpenVPN ግጭት',
      'openvpn_signer_unavailable': 'OpenVPN አይገኝም',
      'email_delivery_unavailable': 'ኢሜይል አይገኝም',
      'invalid_token': 'ልክ ያልሆነ አገናኝ',
      'network_unavailable': 'የኢንተርኔት ግንኙነት አይገኝም',
      'invalid_json': 'ልክ ያልሆነ ጥያቄ',
      'invalid_api_response': 'ልክ ያልሆነ የአገልጋይ ምላሽ',
      'ipv6_unavailable': 'IPv6 አይገኝም',
      'invalid_ip_families': 'የአውታረ መረብ ውቅር ውድቅ ተደርጓል',
      'other': 'አገልግሎቱ አይገኝም',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'ክፍለ ጊዜዎ አብቅቷል። እንደገና ይግቡ።',
      'invalid_credentials': 'የኢሜይል አድራሻው ወይም የይለፍ ቃሉ ትክክል አይደለም።',
      'email_verification_required': 'VPN መሣሪያ ከማከልዎ በፊት የኢሜይል አድራሻዎን ያረጋግጡ።',
      'invalid_registration': 'የተጠየቀውን መረጃ እና ስምምነቶች ያረጋግጡ።',
      'email_exists': 'ይህን የኢሜይል አድራሻ የሚጠቀም መለያ አስቀድሞ አለ።',
      'invalid_profile': 'የመገለጫ መረጃዎን ያረጋግጡ።',
      'invalid_device': 'የዚህ መሣሪያ ስም ወይም በመሣሪያው ላይ ያለው ማንነት ልክ አይደለም።',
      'invalid_location': 'የአካባቢዎችን ዝርዝር ያድሱ እና እንደገና ይሞክሩ።',
      'device_limit': 'ሌላ መሣሪያ ከማከልዎ በፊት ያለውን መሣሪያ ያስወግዱ።',
      'device_exists': 'ይህ የVPN ማንነት አስቀድሞ ከሌላ መለያ ጋር ተገናኝቷል።',
      'device_identity_revoked': 'ይህ ማንነት ተወግዷል። አዲስ የመሣሪያ ማንነት መፍጠር ያስፈልጋል።',
      'device_location_locked':
          'የዚህ መሣሪያ አካባቢ አሁን ተቀይሯል። መተግበሪያው በሂደት ላይ ያለውን ለውጥ ይቀጥላል።',
      'location_migration_pending': 'የአካባቢ ለውጥ አስቀድሞ በሂደት ላይ ነው።',
      'location_migration_blocked':
          'የአካባቢ ለውጡ የአገልጋይ ጣልቃ ገብነት ይፈልጋል። ቆይተው እንደገና ይሞክሩ ወይም የድጋፍ ቡድኑን ያነጋግሩ።',
      'target_ca_mismatch': 'ይህ አገልጋይ ከአሁኑ የOpenVPN መገለጫ ጋር ገና ተኳሃኝ አይደለም።',
      'location_migration_conflict': 'መሣሪያዎችን ያድሱ፣ ከዚያ የአካባቢ ለውጡን እንደገና ይሞክሩ።',
      'server_full':
          'ይህ አካባቢ የግንኙነት ገደቡ ላይ ደርሷል። ሌላ አካባቢ ይምረጡ ወይም ቆይተው እንደገና ይሞክሩ።',
      'capacity_unavailable':
          'ይህ አካባቢ አሁን መገኘቱን ማረጋገጥ አልተቻለም። ሌላ አካባቢ ይምረጡ ወይም ቆይተው እንደገና ይሞክሩ።',
      'target_unavailable': 'ይህ አገልጋይ ለጊዜው አይገኝም።',
      'not_found': 'ይህ ንጥል ከአሁን በኋላ በመለያዎ ላይ አይገኝም።',
      'invalid_openvpn_csr': 'አዲስ የOpenVPN ማንነት ይፍጠሩ እና እንደገና ይሞክሩ።',
      'openvpn_profile_exists': 'ለዚህ መሣሪያ የOpenVPN መገለጫ አስቀድሞ አለ።',
      'openvpn_profile_revoked': 'ለመቀጠል የOpenVPN መገለጫውን ያድሱ።',
      'openvpn_operation_pending': 'ለውጡ እየተሰራጨ ነው። ቆይተው እንደገና ይሞክሩ።',
      'openvpn_operation_terminal': 'አዲስ የOpenVPN ማንነት ይፍጠሩ እና እንደገና ይሞክሩ።',
      'openvpn_address_unavailable': 'በአሁኑ ጊዜ ምንም የOpenVPN አድራሻ አይገኝም።',
      'openvpn_profile_conflict': 'መገለጫው ተቀይሯል። መሣሪያዎችን ያድሱ እና እንደገና ይሞክሩ።',
      'openvpn_signer_unavailable': 'የOpenVPN አገልግሎት ለጊዜው አይገኝም።',
      'email_delivery_unavailable': 'ኢሜይሉ ሊላክ አልቻለም። ቆይተው እንደገና ይሞክሩ።',
      'invalid_token': 'ይህ አገናኝ ልክ ያልሆነ ወይም ጊዜው ያለፈበት ነው። አዲስ ይጠይቁ።',
      'network_unavailable': 'የኢንተርኔት ግንኙነትዎን ያረጋግጡ እና እንደገና ይሞክሩ።',
      'invalid_json': 'ያስገቡትን መረጃ ያረጋግጡ እና እንደገና ይሞክሩ።',
      'invalid_api_response': 'አገልጋዩ ያልተጠበቀ ምላሽ ሰጥቷል። ቆይተው እንደገና ይሞክሩ።',
      'ipv6_unavailable': 'አገልጋዩ አሁን IPv6ን ማንቃት አይችልም። ቆይተው እንደገና ይሞክሩ።',
      'invalid_ip_families':
          'የቱነል ውቅሩ ያልተሟላ ነው ወይም ከተፈቀዱት አድራሻዎች ጋር አይዛመድም። ከመተግበሪያው እንደገና ይሞክሩ።',
      'other': 'የአገልጋይ ስህተት ተከስቷል። ቆይተው እንደገና ይሞክሩ።',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'ከጥቂት ጊዜ በኋላ እንደገና ይሞክሩ።';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'ከ$seconds ሰከንድ በኋላ እንደገና ይሞክሩ።',
      one: 'ከ$seconds ሰከንድ በኋላ እንደገና ይሞክሩ።',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'ከ$minutes ደቂቃ በኋላ እንደገና ይሞክሩ።',
      one: 'ከ$minutes ደቂቃ በኋላ እንደገና ይሞክሩ።',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ከ$hours ሰዓት በኋላ እንደገና ይሞክሩ።',
      one: 'ከ$hours ሰዓት በኋላ እንደገና ይሞክሩ።',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'የስርዓት VPN ዳግም መቀጠል አይገኝም',
      'system_vpn_resume_corrupt': 'የስርዓት VPN ዳግም መቀጠል ልክ አይደለም',
      'system_vpn_resume_session_invalid': 'የVPN ዳግም መቀጠያ ክፍለ ጊዜ ልክ አይደለም',
      'system_vpn_resume_identity_changed': 'የVPN ማንነት ተቀይሯል',
      'system_vpn_resume_identity_invalid': 'የVPN ዳግም መቀጠያ ማንነት ልክ አይደለም',
      'system_vpn_resume_storage_failed': 'የVPN ዳግም መቀጠያ ማከማቻ አይገኝም',
      'system_vpn_resume_network_timeout': 'ለVPN ዳግም መቀጠል አውታረ መረብ አልተገኘም',
      'system_vpn_resume_blocked': 'የVPN ዳግም መቀጠል ታግዷል',
      'system_vpn_resume_failed': 'የVPN ዳግም መቀጠል አልተሳካም',
      'system_vpn_resume_error_invalid': 'የVPN ዳግም መቀጠያ ስህተት ልክ አይደለም',
      'wireguard_identity_store_failed': 'የWireGuard ማንነት አልተቀመጠም',
      'wireguard_identity_unavailable': 'የWireGuard ማንነት አይገኝም',
      'vpn_host_destroyed': 'የAndroid VPN አስተናጋጅ ቆሟል',
      'vpn_host_unavailable': 'የAndroid VPN አስተናጋጅ አይገኝም',
      'vpn_permission_required': 'የVPN ፈቃድ ያስፈልጋል',
      'vpn_permission_denied': 'የVPN ፈቃድ ተከልክሏል',
      'vpn_permission_request_failed': 'ፈቃድ መጠየቅ አልተቻለም',
      'wireguard_foreground_service_unavailable': 'የWireGuard አገልግሎት አይገኝም',
      'wireguard_identity_invalid': 'በመሣሪያው ላይ ያለው የWireGuard ቁልፍ ልክ አይደለም',
      'wireguard_identity_in_use': 'የWireGuard ማንነት አስቀድሞ በጥቅም ላይ ነው',
      'wireguard_configuration_invalid': 'የWireGuard ውቅር ልክ አይደለም',
      'wireguard_operation_pending': 'የWireGuard ስራ አሁንም በሂደት ላይ ነው',
      'wireguard_start_failed': 'የWireGuard መጀመር ውድቅ ተደርጓል',
      'wireguard_stop_timeout': 'የWireGuard ማቆም አልተረጋገጠም',
      'wireguard_handshake_timeout': 'WireGuard ምላሽ አልሰጠም',
      'openvpn_connection_timeout': 'OpenVPN ምላሽ አልሰጠም',
      'openvpn_core_unavailable': 'የOpenVPN ሞተር አይገኝም',
      'openvpn_operation_pending': 'የOpenVPN ክፍለ ጊዜ አሁንም ንቁ ነው',
      'openvpn_stop_timeout': 'የOpenVPN ማቆም አልተረጋገጠም',
      'openvpn_profile_unavailable': 'በመሣሪያው ላይ ያለው የOpenVPN መገለጫ የለም',
      'openvpn_native_failed': 'የOpenVPN ቤተኛ ጥሪ ተቋርጧል',
      'openvpn_key_generation_failed': 'የOpenVPN P-256 ቁልፍ መፍጠር አልተቻለም',
      'openvpn_csr_generation_failed': 'የOpenVPN CSR መፍጠር አልተቻለም',
      'openvpn_identity_store_failed': 'የOpenVPN ማንነት አልተቀመጠም',
      'openvpn_identity_clear_failed': 'የOpenVPN ማስወገድ ያልተሟላ ነው',
      'openvpn_identity_in_use': 'የOpenVPN ማንነት አሁንም በጥቅም ላይ ነው',
      'openvpn_tls_verification_required': 'የOpenVPN TLS ማረጋገጫ ይጎድላል',
      'openvpn_cipher_invalid': 'የOpenVPN ምስጠራ ልክ አይደለም',
      'openvpn_profile_rejected': 'የOpenVPN መገለጫ ውድቅ ተደርጓል',
      'openvpn_identity_inconsistent': 'የOpenVPN ማንነት አይጣጣምም',
      'tls_handshake_failed': 'የOpenVPN ድርድር ውድቅ ተደርጓል',
      'tls_alert_unknown_ca': 'የOpenVPN የደንበኛ ሰርተፍኬት አልታወቀም',
      'tls_alert_bad_certificate': 'የOpenVPN የደንበኛ ሰርተፍኬት ውድቅ ተደርጓል',
      'tls_alert_unsupported_certificate': 'የማይደገፍ የOpenVPN ሰርተፍኬት',
      'tls_client_certificate_required': 'የOpenVPN የደንበኛ ሰርተፍኬት ያስፈልጋል',
      'tls_alert_misc': 'የOpenVPN TLS ማስጠንቀቂያ',
      'tls_signature_algorithm_rejected': 'የማይደገፍ የOpenVPN ፊርማ',
      'tls_handshake_rejected': 'የOpenVPN TLS ድርድር ውድቅ ተደርጓል',
      'tls_version_rejected': 'የማይጣጣም የOpenVPN TLS ስሪት',
      'tls_certificate_expired': 'የTLS ሰርተፍኬት ጊዜው አልፎበታል',
      'tls_certificate_revoked': 'የTLS ሰርተፍኬት ተሽሯል',
      'transport_failed': 'የOpenVPN አገልጋይ ሊደረስበት አይችልም',
      'tun_configuration_rejected': 'የOpenVPN በይነገጽ መፍጠር አልተቻለም',
      'tun_setup_failed': 'የOpenVPN TUN ማዋቀር አልተሳካም',
      'tun_interface_create_failed': 'የOpenVPN በይነገጽ መፍጠር አልተሳካም',
      'tun_interface_disabled': 'የOpenVPN በይነገጽ ተሰናክሏል',
      'tun_halted': 'የOpenVPN በይነገጽ ተቋርጧል',
      'tun_already_established': 'የOpenVPN በይነገጽ አስቀድሞ ተከፍቷል',
      'tun_addresses_missing': 'የOpenVPN አድራሻ ይጎድላል',
      'tun_routes_missing': 'የOpenVPN መስመሮች ይጎድላሉ',
      'tun_dns_missing': 'የOpenVPN DNS ይጎድላል',
      'tun_permission_revoked': 'የVPN ፈቃድ ተሰርዟል',
      'tun_establish_returned_null': 'Android የVPN በይነገጹን ውድቅ አድርጓል',
      'openvpn_service_start_failed': 'የOpenVPN አገልግሎት አይገኝም',
      'openvpn_operation_timeout': 'የOpenVPN ጥሪ ጊዜው አልቋል',
      'openvpn_start_failed': 'የOpenVPN መጀመር ውድቅ ተደርጓል',
      'openvpn_connection_failed': 'የOpenVPN ግንኙነት ተቋርጧል',
      'openvpn_core_status_error': 'የOpenVPN ሞተር በስህተት ተጠናቅቋል',
      'openvpn_stopped_before_connected': 'OpenVPN ከመገናኘቱ በፊት ቆሟል',
      'openvpn_auth_failed': 'የOpenVPN ማረጋገጫ ውድቅ ተደርጓል',
      'openvpn_client_setup_failed': 'የOpenVPN ደንበኛ ማዘጋጀት አልተሳካም',
      'openvpn_client_halted': 'የOpenVPN ደንበኛ ተቋርጧል',
      'openvpn_client_restart': 'የOpenVPN ዳግም መጀመር ተጠይቋል',
      'openvpn_inactive_timeout': 'OpenVPN ለረጅም ጊዜ ስራ ፈት ነው',
      'openvpn_session_expired': 'የOpenVPN ክፍለ ጊዜ ጊዜው አልፎበታል',
      'openvpn_credentials_required': 'የማይደገፍ የOpenVPN ማረጋገጫ',
      'openvpn_proxy_failed': 'የOpenVPN መካከለኛ ማጓጓዣ አልተሳካም',
      'openvpn_compression_failed': 'የOpenVPN መጭመቅ ውድቅ ተደርጓል',
      'openvpn_ntlm_crypto_unavailable': 'የOpenVPN NTLM ምስጠራ አይገኝም',
      'openvpn_feature_unsupported': 'የማይደገፍ የOpenVPN ባህሪ',
      'network_unavailable': 'የኢንተርኔት ግንኙነት አይገኝም',
      'network_lost': 'አውታረ መረብ አይገኝም',
      'certificate_validation_failed': 'የአገልጋይ ሰርተፍኬት ውድቅ ተደርጓል',
      'openvpn_certificate_expired': 'የOpenVPN ሰርተፍኬት ጊዜው አልፎበታል',
      'tunnel_active_for_another_account': 'የሌላ መለያ ቱነል አሁንም ንቁ ነው',
      'tunnel_already_active': 'ቤተኛ ቱነል አስቀድሞ ንቁ ነው',
      'tunnel_stop_timeout': 'የ$protocol ማቆም አልተረጋገጠም',
      'tunnel_disconnected': 'የ$protocol ግንኙነት ተቋርጧል',
      'native_bridge_unavailable': 'የAndroid ድልድይ አይገኝም',
      'native_operation_failed': 'የAndroid ስራ ተቋርጧል',
      'invalid_arguments': 'የVPN መለኪያዎች ያልተሟሉ ናቸው',
      'invalid_account_id': 'የVPN መለያ ልክ አይደለም',
      'invalid_device_id': 'የመሣሪያ መለያ ቁጥር ልክ አይደለም',
      'storage_key_not_allowed': 'የማከማቻ ቁልፍ ውድቅ ተደርጓል',
      'secure_storage_read_failed': 'ደህንነቱ የተጠበቀ ውሂብ ማንበብ አልተሳካም',
      'secure_storage_write_failed': 'ደህንነቱ የተጠበቀ ውሂብ መጻፍ አልተሳካም',
      'key_generation_failed': 'የWireGuard ቁልፍ ማመንጨት አልተቻለም',
      'csr_generation_failed': 'የOpenVPN CSR ማመንጨት አልተቻለም',
      'openvpn_recovery_exhausted': 'የOpenVPN ራስ-ሰር መልሶ ማግኘት አስቀድሞ ጥቅም ላይ ውሏል',
      'openvpn_recovery_failed': 'የOpenVPN ራስ-ሰር መልሶ ማግኘት አልተሳካም',
      'openvpn_renewal_required': 'የOpenVPN ሰርተፍኬት ማደስ ያስፈልጋል',
      'other': 'ያልተመደበ ቤተኛ የVPN ስህተት',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ዳግም ሊቀጥል የሚችል የVPN ክፍለ ጊዜ ማግኘት አይችልም። በመተግበሪያው ውስጥ አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_corrupt':
          'የተቀመጠው የVPN ዳግም መቀጠያ ውሂብ ልክ ያልሆነ ስለሆነ ጥቅም ላይ አይውልም። አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_session_invalid':
          'የተቀመጠው ክፍለ ጊዜ ከአሁን በኋላ VPNን ዳግም መቀጠል አይችልም። በመተግበሪያው ውስጥ እንደገና ይግቡ።',
      'system_vpn_resume_identity_changed':
          'በመሣሪያው ላይ ያለው የVPN ማንነት ተቀይሯል። ዳግም መቀጠል ቆሟል፤ አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_identity_invalid':
          'ለዳግም መቀጠል የሚያገለግለው ማንነት ልክ አይደለም። አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_storage_failed':
          'Android የተመሰጠረውን የዳግም መቀጠያ ውሂብ ማንበብ ወይም ማዘመን አልቻለም። አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_network_timeout':
          'Android VPNን ዳግም ለመቀጠል በጊዜው አውታረ መረብ ማግኘት አልቻለም። አውታረ መረብ ሲገኝ እንደገና ይሞክሩ።',
      'system_vpn_resume_blocked':
          'የVPN ዳግም መቀጠል ታግዷል። የAndroid ቅንብሮችን ያረጋግጡ፤ ከዚያም አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_failed':
          'የAndroid VPN ዳግም መቀጠል አልተሳካም። በመተግበሪያው ውስጥ አዲስ ግንኙነት ይጀምሩ።',
      'system_vpn_resume_error_invalid':
          'Android ጥቅም ላይ የማይውል የዳግም መቀጠል ስህተት መለሰ። አዲስ ግንኙነት ይጀምሩ።',
      'wireguard_identity_store_failed':
          'Android የዚህን መለያ የተመሰጠረ የWireGuard ማንነት ማስቀመጥ አልቻለም።',
      'wireguard_identity_unavailable':
          'ለዚህ ግንኙነት ጥቅም ላይ የሚውል የWireGuard ማንነት አይገኝም።',
      'vpn_host_destroyed': 'VPNን የሚያስተናግደው የAndroid አካል ቆሟል። አዲስ ግንኙነት ይጀምሩ።',
      'vpn_host_unavailable':
          'Android VPNን የሚያስተናግድ አካል መፍጠር አይችልም። የVPN ቅንብሮችን ካረጋገጡ በኋላ እንደገና ይሞክሩ።',
      'openvpn_renewal_required':
          'የOpenVPN ሰርተፍኬቱን በራስ-ሰር ማደስ አልተቻለም። በመተግበሪያው ውስጥ አዲስ ግንኙነት ይጀምሩ።',
      'openvpn_recovery_failed':
          'ራስ-ሰር መልሶ ማግኘት አልተሳካም። በመተግበሪያው ውስጥ አዲስ ግንኙነት ይጀምሩ።',
      'openvpn_recovery_exhausted':
          'ራስ-ሰር መልሶ ማግኘት አስቀድሞ ጥቅም ላይ ውሏል። በመተግበሪያው ውስጥ አዲስ ግንኙነት ይጀምሩ።',
      'vpn_permission_required':
          'ቱነሉን ከመጀመርዎ በፊት Android አዲስ የVPN ፈቃድ ያስፈልገዋል።',
      'vpn_permission_denied': 'ለመቀጠል በAndroid ጥያቄው ውስጥ FuzeVPNን ይፍቀዱ።',
      'vpn_permission_request_failed': 'Android የVPN ፈቃድ ማያ ገጽን መክፈት አልቻለም።',
      'wireguard_foreground_service_unavailable':
          'Android የWireGuard አገልግሎቱን በፊት ለፊት ማቆየት አልቻለም።',
      'wireguard_identity_invalid':
          'የዚህ መለያ የተመሰጠረ የWireGuard ቁልፍ ሊነበብ የማይችል ወይም ልክ ያልሆነ ነው።',
      'wireguard_identity_in_use':
          'ሌላ ስራ አሁንም የዚህን መለያ የWireGuard ቁልፍ እየተጠቀመ ነው።',
      'wireguard_configuration_invalid':
          'የተቀበሉት የWireGuard አድራሻ፣ DNS፣ የአገልጋይ ቁልፍ ወይም መስመሮች ልክ አይደሉም።',
      'wireguard_operation_pending':
          'ቀዳሚው የWireGuard ስራ ቤተኛ አገልግሎቱን ገና አልለቀቀም።',
      'wireguard_start_failed': 'የWireGuard ሞተር የውቅሩን ማንቃት ውድቅ አድርጓል።',
      'wireguard_stop_timeout':
          'የWireGuard አገልግሎት በተቀመጠው ጊዜ ውስጥ የVPN በይነገጹን መልቀቅ አላረጋገጠም።',
      'wireguard_handshake_timeout': 'ቱነሉ ከአገልጋዩ ጋር ሃንድሼክ መደረጉን በጊዜው አላረጋገጠም።',
      'openvpn_connection_timeout': 'OpenVPN በጊዜው ከአገልጋዩ ጋር ግንኙነቱን አላረጋገጠም።',
      'openvpn_core_unavailable':
          'ይህ የመተግበሪያ ስሪት ጥቅም ላይ የሚውል የOpenVPN ሞተር የለውም።',
      'openvpn_operation_pending':
          'ቤተኛው ሞተር አሁንም ቀዳሚውን የOpenVPN ክፍለ ጊዜ እየያዘ ስለሆነ ሁለተኛ ክፍለ ጊዜ መፍጠር አይችልም።',
      'openvpn_stop_timeout':
          'የOpenVPN ሞተር በተቀመጠው ጊዜ ውስጥ ቤተኛው ክፍለ ጊዜ መቆሙን እና መጥፋቱን አላረጋገጠም።',
      'openvpn_profile_unavailable':
          'ለዚህ ግንኙነት የተረጋገጠ የOpenVPN መገለጫ ማንበብ አይቻልም።',
      'openvpn_native_failed':
          'በመተግበሪያ ስህተት ምክንያት OpenVPN ተቋርጧል። እንደገና ለመገናኘት ይሞክሩ። ችግሩ ከቀጠለ ምርመራ ያሂዱ።',
      'openvpn_key_generation_failed':
          'Android Keystore ወደ ውጭ መላክ የማይቻለውን የP-256 የግል ቁልፍ መፍጠር ወይም ማንበብ አልቻለም።',
      'openvpn_csr_generation_failed':
          'የAndroid Keystore ቁልፍ የOpenVPN ሰርተፍኬት ጥያቄን መፈረም አልቻለም።',
      'openvpn_identity_store_failed':
          'የOpenVPN ሰርተፍኬቱ ወይም መገለጫው በተመሰጠረ ማከማቻ ውስጥ ሊቀመጥ አልቻለም።',
      'openvpn_identity_clear_failed':
          'Android ለዚህ መለያ በመሣሪያው ላይ ያለውን የOpenVPN ማንነት በሙሉ ማስወገድ አልቻለም።',
      'openvpn_identity_in_use':
          'አንድ ቤተኛ የOpenVPN ክፍለ ጊዜ አሁንም የዚህን መሣሪያ ቁልፍ ወይም ሰርተፍኬት እየተጠቀመ ነው።',
      'openvpn_tls_verification_required':
          'መገለጫው የአገልጋይ ሰርተፍኬት ማረጋገጫ በግልጽ አይጠይቅም።',
      'openvpn_cipher_invalid':
          'አገልጋዩ በተፈቀደው ዝርዝር ውስጥ የሌለ የምስጠራ ስልተ ቀመር አቅርቧል።',
      'openvpn_profile_rejected':
          'ከአገልጋዩ የተላከው መገለጫ ተኳሃኝ አይደለም። ይህን መሣሪያ እንደገና ይፍጠሩ እና ይሞክሩ።',
      'openvpn_identity_inconsistent':
          'ሰርተፍኬቱ ከዚህ ስልክ ደህንነቱ የተጠበቀ ማንነት ጋር አይዛመድም። በስልኩ ላይ ያለ ምንም መገለጫ አልተተካም።',
      'tls_handshake_failed':
          'አገልጋዩ የTLS ድርድሩን ውድቅ አድርጓል። ችግሩ ከቀጠለ መገለጫውን እንደገና ይፍጠሩ።',
      'tls_alert_unknown_ca':
          'አገልጋዩ የዚህን መሣሪያ ሰርተፍኬት ሰጪ ባለስልጣን አያውቀውም። የOpenVPN አገልጋዩ መፈተሽ አለበት።',
      'tls_alert_bad_certificate':
          'አገልጋዩ ይህን የመሣሪያ ሰርተፍኬት ውድቅ አድርጓል። ዳግም ከመሞከርዎ በፊት መሣሪያውን እንደገና ይፍጠሩ።',
      'tls_alert_unsupported_certificate':
          'አገልጋዩ Android የሚጠቀምበትን ደህንነቱ የተጠበቀ የሰርተፍኬት ዓይነት አይደግፍም።',
      'tls_client_certificate_required':
          'አገልጋዩ የደንበኛ ሰርተፍኬት ይፈልጋል፣ ነገር ግን የOpenVPN ሞተር ሊያቀርብ አልቻለም።',
      'tls_alert_misc': 'አገልጋዩ ከሰርተፍኬት እና ከስሪት ምድቦች ውጭ የTLS ማስጠንቀቂያ መለሰ።',
      'tls_signature_algorithm_rejected':
          'አገልጋዩ የAndroid Keystore ቁልፍን የECDSA P-256 ስልተ ቀመር ውድቅ አድርጓል።',
      'tls_handshake_rejected': 'አገልጋዩ ከመገናኘቱ በፊት የTLS ድርድሩን አቋርጧል።',
      'tls_version_rejected': 'ደንበኛው እና አገልጋዩ የጋራ የTLS ስሪት ማግኘት አልቻሉም።',
      'tls_certificate_expired': 'በግንኙነቱ ወቅት የቀረበው ሰርተፍኬት ጊዜው አልፎበታል።',
      'tls_certificate_revoked': 'በግንኙነቱ ወቅት የቀረበው ሰርተፍኬት ተሽሯል።',
      'transport_failed':
          'የOpenVPN አገልጋዩ በአሁኑ አውታረ መረብ ላይ ምላሽ እየሰጠ አይደለም። ከጥቂት ጊዜ በኋላ እንደገና ይሞክሩ።',
      'tun_configuration_rejected':
          'Android OpenVPN የጠየቀውን የአውታረ መረብ ውቅር ውድቅ አድርጓል።',
      'tun_setup_failed':
          'የOpenVPN ሞተር የAndroid በይነገጹን ከመፍጠሩ በፊት የአውታረ መረብ ዕቅዱን ውድቅ አድርጓል።',
      'tun_interface_create_failed':
          'የOpenVPN ሞተር ከAndroid VpnService የTUN በይነገጽ ማግኘት አልቻለም።',
      'tun_interface_disabled':
          'በግንኙነቱ ወቅት Android ወይም የOpenVPN ሞተር የTUN በይነገጹን አሰናክለዋል።',
      'tun_halted': 'የOpenVPN ሞተር የTUN በይነገጹን እንዲያቆም ጥያቄ ደርሶታል።',
      'tun_already_established':
          'OpenVPN በተመሳሳይ ግንኙነት ሁለተኛ በይነገጽ ጠይቋል። ለደህንነት ሲባል ቱነሉ ቆሟል።',
      'tun_addresses_missing': 'አገልጋዩ ጥቅም ላይ የሚውል የቱነል አድራሻ አላቀረበም።',
      'tun_routes_missing': 'አገልጋዩ ጥቅም ላይ የሚውሉ የቱነል መስመሮችን አላቀረበም።',
      'tun_dns_missing': 'አገልጋዩ ጥቅም ላይ የሚውል የDNS አገልጋይ አላቀረበም።',
      'tun_permission_revoked': 'በግንኙነቱ ወቅት Android የVPN ፈቃዱን ሰርዟል።',
      'tun_establish_returned_null':
          'Android በይነገጹን አልፈጠረም፤ ብዙውን ጊዜ ሌላ VPN አሁንም ንቁ ስለሆነ ነው።',
      'openvpn_service_start_failed':
          'Android የOpenVPN የፊት ለፊት አገልግሎቱን ማስጀመር አልቻለም።',
      'openvpn_operation_timeout':
          'ወደ OpenVPN ሞተር የተደረገ የJNI ጥሪ ከፍተኛውን ጊዜ አልፏል።',
      'openvpn_start_failed':
          'የAndroid አገልግሎቱ ዝግጁ ነው፣ ነገር ግን የOpenVPN ሞተር መገለጫውን ለማስጀመር አልተቀበለም።',
      'openvpn_connection_failed':
          'የOpenVPN ሞተር የCONNECTED ክስተቱን ከማሳየቱ በፊት ቆሟል።',
      'openvpn_core_status_error':
          'ቤተኛው የOpenVPN ዑደት በስህተት ተጠናቅቋል፤ የበለጠ ግልጽ የመጨረሻ ክስተት አልነበረም።',
      'openvpn_stopped_before_connected':
          'ቤተኛው የOpenVPN ዑደት ግልጽ የሞተር ስህተት ሳይኖር ከCONNECTED በፊት ቆሟል።',
      'openvpn_auth_failed': 'የOpenVPN አገልጋዩ የመገለጫውን ማረጋገጫ ውድቅ አድርጓል።',
      'openvpn_client_setup_failed':
          'የOpenVPN ሞተር ከአውታረ መረብ ግንኙነቱ በፊት ደንበኛውን ማዘጋጀት አልቻለም።',
      'openvpn_client_halted': 'የOpenVPN ሞተር የደንበኛው የመጨረሻ ማቆሚያ ትዕዛዝ ደርሶታል።',
      'openvpn_client_restart':
          'የOpenVPN ሞተር የማጓጓዣ ክፍለ ጊዜውን እንደገና እንዲጀመር ጠይቋል።',
      'openvpn_inactive_timeout':
          'የOpenVPN ሞተር የእንቅስቃሴ-አልባነት የጊዜ ገደቡ ካለፈ በኋላ ክፍለ ጊዜውን ዘግቷል።',
      'openvpn_session_expired': 'አገልጋዩ የOpenVPN ክፍለ ጊዜ ጊዜው እንዳለፈበት ገልጿል።',
      'openvpn_credentials_required':
          'አገልጋዩ ወይም ፕሮክሲው በዚህ የሰርተፍኬት መገለጫ ውስጥ ያልተካተቱ በእጅ የሚገቡ የመግቢያ መረጃዎችን ይጠይቃል።',
      'openvpn_proxy_failed':
          'የOpenVPN ሞተር በተዋቀረው ፕሮክሲ ወይም ማስተላለፊያ ላይ ብልሽት እንዳለ ገልጿል።',
      'openvpn_compression_failed':
          'የOpenVPN ሞተር በመገለጫው ወይም በአገልጋዩ የተገለጸውን የመጭመቂያ ሁነታ ውድቅ አድርጓል።',
      'openvpn_ntlm_crypto_unavailable':
          'መገለጫው በዚህ ስሪት ውስጥ የማይገኝ የNTLM ምስጠራ ይጠይቃል።',
      'openvpn_feature_unsupported':
          'መገለጫው ወይም አገልጋዩ በዚህ የAndroid ደንበኛ ውስጥ የሌለ ባህሪ ይጠይቃል።',
      'network_unavailable': 'ጥቅም ላይ የሚውል አካላዊ አውታረ መረብ አይገኝም።',
      'network_lost': 'አውታረ መረቡ ከጠፋ በኋላ ቱነሉ ቆሟል።',
      'certificate_validation_failed': 'የOpenVPN አገልጋዩ ማንነት ሊረጋገጥ አልቻለም።',
      'openvpn_certificate_expired':
          'የOpenVPN ሰርተፍኬቱ ጊዜው አልፎበታል። ለማደስ በመተግበሪያው ውስጥ አዲስ ግንኙነት ይጀምሩ።',
      'tunnel_active_for_another_account':
          'ከዚህ ግንኙነት በፊት የሌላ መለያ ቱነል መቆም አለበት።',
      'tunnel_already_active':
          'Android ቀዳሚው የVPN ክፍለ ጊዜ አሁንም በይነገጹን እየተጠቀመ መሆኑን ይገልጻል።',
      'tunnel_stop_timeout':
          'የ$protocol ሞተር በተቀመጠው ጊዜ ውስጥ የVPN በይነገጹን መልቀቅ አላረጋገጠም።',
      'tunnel_disconnected': 'ቤተኛው ሞተር ቱነሉ ከጀመረ በኋላ ባልተጠበቀ ሁኔታ መቋረጡን ገልጿል።',
      'native_bridge_unavailable':
          'መተግበሪያው የAndroid VPN አገልግሎትን ማግኘት አይችልም። መተግበሪያውን ዘግተው እንደገና ይክፈቱ፤ ከዚያም እንደገና ይሞክሩ።',
      'native_operation_failed':
          'በመተግበሪያ ስህተት ምክንያት የVPN ስራው ተቋርጧል። እንደገና ይሞክሩ። ችግሩ ከቀጠለ ምርመራ ያሂዱ።',
      'invalid_arguments':
          'ለዚህ የVPN ስራ የሚያስፈልገው መረጃ ያልተሟላ ነው። እንደገና ይሞክሩ። ችግሩ ከቀጠለ ምርመራ ያሂዱ።',
      'invalid_account_id': 'ቤተኛው ስራ ከትክክለኛ የመለያ ቁጥር ጋር የተያያዘ አይደለም።',
      'invalid_device_id': 'ወደ ቤተኛው ሞተር የተላከው የመሣሪያ መለያ ቁጥር ጠፍቷል ወይም ልክ አይደለም።',
      'storage_key_not_allowed': 'የAndroid ድልድይ ከተፈቀደው የማከማቻ ዝርዝር ውጭ ቁልፍ አግዷል።',
      'secure_storage_read_failed':
          'Android Keystore የዚህን መለያ በመሣሪያው ላይ ያለ ውሂብ ምስጠራ መፍታት አልቻለም።',
      'secure_storage_write_failed':
          'Android Keystore በመሣሪያው ላይ ያለውን ውሂብ ማመስጠር ወይም ማስቀመጥ አልቻለም።',
      'key_generation_failed':
          'Android በደህንነቱ የተጠበቀ ማከማቻ ውስጥ የWireGuard ቁልፍን መፍጠር ወይም ማንበብ አልቻለም።',
      'csr_generation_failed':
          'Android Keystore የOpenVPN P-256 CSR መፍጠር ወይም መፈረም አልቻለም።',
      'other': 'ያልተመዘገበ ቤተኛ ሂደት አልተሳካም። ከታች የሚታየውን የምርመራ ኮድ ለድጋፍ ቡድኑ ይላኩ።',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'የፈቃድ ጥያቄ አስቀድሞ ክፍት ነው';

  @override
  String get notice_permissionRequestInProgress_message =>
      'የAndroid VPN ፈቃድ ጥያቄ አስቀድሞ እየታየ ነው። እንደገና ከመሞከርዎ በፊት ያጠናቅቁት።';

  @override
  String get notice_permissionRequestInterrupted_title => 'የVPN ፈቃድ ጥያቄ ተቋርጧል';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'መተግበሪያው ምላሽ ከመቀበሉ በፊት የVPN ፈቃድ ማያ ገጹ ተዘግቷል።';

  @override
  String get notice_openvpnProofMissing_title => 'የOpenVPN ግንኙነት አልተረጋገጠም';

  @override
  String get notice_openvpnProofMissing_message =>
      'የOpenVPN ግንኙነቱ ሊረጋገጥ አልቻለም። ለደህንነት ሲባል ተቋርጧል። እንደገና ይሞክሩ።';

  @override
  String get openvpnCleanup_title => 'የOpenVPN መገለጫ ተሰርዟል';

  @override
  String get openvpnCleanup_working =>
      'የተሰረዘውን የOpenVPN መገለጫ በማቆም እና በማስወገድ ላይ…';

  @override
  String get openvpnCleanup_stopFailed =>
      'የOpenVPN መዘጋት አልተረጋገጠም። አዲስ መገለጫ ከመፍጠርዎ በፊት እንደገና ይሞክሩ።';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'የተሰረዘው የOpenVPN መገለጫ ሙሉ በሙሉ ሊወገድ አልቻለም። ማጽዳቱን እንደገና ይሞክሩ።';

  @override
  String get openvpnCleanup_complete =>
      'የተሰረዘው የOpenVPN መገለጫ ተወግዷል። አዲስ ለመፍጠር “ይገናኙ”ን ይንኩ።';

  @override
  String get network_title => 'የአውታረ መረብ ውቅር';

  @override
  String get network_ipv4Fallback => 'IPv6 ለጊዜው አይገኝም። ዝግጅቱ በIPv4 ቀጥሏል።';

  @override
  String get network_rejectedTitle => 'የአውታረ መረብ ውቅር ውድቅ ተደርጓል';

  @override
  String get network_rejectedMessage =>
      'የቱነል ውቅሩ ያልተሟላ ነው ወይም ከተፈቀዱት አድራሻዎች ጋር አይዛመድም። ከመተግበሪያው እንደገና ይሞክሩ።';

  @override
  String get network_unreadableTitle => 'በመሣሪያው ላይ ያለ ውቅር ሊነበብ አይችልም';

  @override
  String get network_unreadableMessage =>
      'የተቀመጠው የOpenVPN የአውታረ መረብ ውቅር ጥቅም ላይ ሊውል አይችልም። ለማዘመን ከመተግበሪያው እንደገና ይገናኙ።';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'የአውታረ መረብ ጥበቃ';

  @override
  String get protection_subtitle => 'VPN ከተቋረጠ ቀጥተኛ የኢንተርኔት መዳረሻን ያግዱ።';

  @override
  String get protection_active => 'የስርዓት ጥበቃ ነቅቷል';

  @override
  String get protection_alwaysOnOnly => 'ሁልጊዜ የበራ VPN ነቅቷል፤ ከVPN ውጭ ማገድን ያብሩ';

  @override
  String get protection_inactive => 'የስርዓት ጥበቃ ጠፍቷል';

  @override
  String get protection_unknown => 'የስርዓት ጥበቃን ያረጋግጡ';

  @override
  String get protection_openSettings => 'የAndroid ቅንብሮችን ይክፈቱ';

  @override
  String get protection_dialogTitle => 'የአውታረ መረብ ጥበቃን ያዋቅሩ';

  @override
  String get protection_dialogMessage =>
      'Android ሁልጊዜ የበራ VPN እና ከVPN ውጭ ያሉ ግንኙነቶችን ማገድን ያስተዳድራል። FuzeVPN መመረጡን ያረጋግጡ እና በስርዓት ቅንብሮች ውስጥ ማገድን ያንቁ።';

  @override
  String get protection_dialogOpen => 'ቅንብሮችን ይክፈቱ';

  @override
  String get session_systemProtectionNote =>
      'Android አሁንም ከVPN ውጭ ያለውን ትራፊክ እየከለከለ ከሆነ ይህን ጥበቃ ለመፈተሽ ወይም ለመቀየር የስርዓት ቅንብሮችን ይክፈቱ።';

  @override
  String get diagnostics_title => 'ምርመራ';

  @override
  String get diagnostics_settingsTitle => 'የመተግበሪያ ምርመራ';

  @override
  String get diagnostics_automaticTitle => 'ወሳኝ ስህተቶችን ይላኩ';

  @override
  String get diagnostics_automaticDescription =>
      'ወሳኝ ስህተት በሚከሰትበት ጊዜ አጭር የቴክኒክ ሪፖርት ያጋሩ።';

  @override
  String get diagnostics_privacy =>
      'የተላኩ ሪፖርቶች ከገቡበት መለያ ጋር ተያይዘው ለ30 ቀናት ይቀመጣሉ። የአሰሳ ታሪክ፣ የይለፍ ቃል ወይም የVPN ቁልፎች አያካትቱም።';

  @override
  String get diagnostics_manualOpen => 'ምርመራ ያሂዱ';

  @override
  String get diagnostics_localDescription =>
      'የመተግበሪያውን እና የVPN ሁኔታ ሪፖርት ይፍጠሩ። ግንኙነትዎ ሳይለወጥ ይቆያል።';

  @override
  String get diagnostics_sendReport => 'ሪፖርቱን ይላኩ';

  @override
  String get diagnostics_sendHint =>
      'ሪፖርቱን በዚህ መሣሪያ ላይ ለማቆየት ይህንን ሳጥን ምልክት ሳያደርጉ ይተዉት።';

  @override
  String get diagnostics_signedOut => 'ሪፖርት ለመላክ ወደ መለያዎ ይግቡ።';

  @override
  String get diagnostics_localLifetime =>
      'መተግበሪያውን ከዘጉ በኋላ ይህንን ሪፖርት ለማቆየት በስልክዎ ላይ ያስቀምጡት።';

  @override
  String get diagnostics_run => 'ምርመራ ያሂዱ';

  @override
  String get diagnostics_rerun => 'ምርመራውን እንደገና ያሂዱ';

  @override
  String get diagnostics_running => 'በመፈተሽ ላይ…';

  @override
  String get diagnostics_sending => 'ሪፖርቱን በመላክ ላይ…';

  @override
  String get diagnostics_prepared => 'ሪፖርቱ በዚህ መሣሪያ ላይ ዝግጁ ነው';

  @override
  String get diagnostics_queued => 'ሪፖርቱ ለመላክ በመጠበቅ ላይ ነው';

  @override
  String get diagnostics_sent => 'ሪፖርቱ ደርሷል';

  @override
  String get diagnostics_failed => 'መላክ አልተሳካም። በመሣሪያዎ ላይ ያለው ሪፖርት አሁንም ይገኛል።';

  @override
  String get diagnostics_preparationFailed =>
      'የምርመራ ሪፖርቱ ዝግጁ ሊሆን አልቻለም። እንደገና ይሞክሩ።';

  @override
  String get diagnostics_authenticationRequired => 'ሪፖርቱን ለመላክ እንደገና ይግቡ።';

  @override
  String get diagnostics_retry => 'መላክን እንደገና ይሞክሩ';

  @override
  String get diagnostics_export => 'ሪፖርቱን ያስቀምጡ';

  @override
  String get diagnostics_exportFailed =>
      'ማስቀመጥ አልተሳካም። በመሣሪያዎ ላይ ካለው ሪፖርት እንደገና ይሞክሩ።';

  @override
  String get diagnostics_preferenceFailed => 'ይህ ቅንብር ሊቀመጥ አልቻለም። እንደገና ይሞክሩ።';

  @override
  String diagnostics_receipt(Object id) {
    return 'ማጣቀሻ፦ $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'በ$date ደርሷል';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'እስከ $date ድረስ ይቀመጣል';
  }

  @override
  String get diagnostics_duplicate => 'ይህ ሪፖርት ከዚህ በፊት ደርሶ ነበር።';

  @override
  String get diagnostics_preview => 'የሪፖርቱ ቅድመ እይታ';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count የቴክኒክ ክስተቶች ተያይዘዋል',
      one: '1 የቴክኒክ ክስተት ተያይዟል',
      zero: 'ምንም የቴክኒክ ክስተት አልተያያዘም',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'የቴክኒክ ዝርዝሮች';

  @override
  String get diagnostics_empty => 'ገና ምንም የምርመራ ሪፖርት አልተዘጋጀም።';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'የቱነል ሁኔታ',
      'handshake': 'የግንኙነት ማረጋገጫ',
      'certificate': 'የVPN ሰርተፍኬት',
      'kill_switch': 'የAndroid ጥበቃ',
      'connectivity': 'የሚገኝ አውታረ መረብ',
      'api_reachability': 'የአገልግሎት መዳረሻ',
      'secure_storage': 'ደህንነቱ የተጠበቀ ማከማቻ',
      'other': 'የመሣሪያ ላይ ፍተሻ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'ተረጋግጧል',
      'failed': 'ትኩረት ያስፈልገዋል',
      'skipped': 'አልተፈተነም — ንቁ ፍተሻ የለም',
      'unknown': 'መረጃ አይገኝም',
      'other': 'መረጃ አይገኝም',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'እንኳን ወደ FuzeVPN በደህና መጡ';

  @override
  String get connection_changeLocation => 'አካባቢ ይቀይሩ';

  @override
  String get connection_details => 'የግንኙነት ዝርዝሮች';

  @override
  String get locations_searchLabel => 'ከተማ ወይም አገር ይፈልጉ';

  @override
  String get locations_clearSearch => 'ፍለጋውን ያጽዱ';

  @override
  String get locations_filterAll => 'ሁሉም';

  @override
  String get locations_filterFavorites => 'ተወዳጆች';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count አካባቢዎች',
      one: '$count አካባቢ',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'ምንም አካባቢ አልተገኘም';

  @override
  String get locations_noResultsHint => 'ሌላ ከተማ ወይም አገር ይሞክሩ።';

  @override
  String get locations_noFavorites => 'ተወዳጆችዎ፣ በእጅዎ ላይ';

  @override
  String get locations_noFavoritesHint => 'እዚህ ለማስቀመጥ ከአካባቢ ቀጥሎ ያለውን ኮከብ ይንኩ።';

  @override
  String get locations_showAll => 'ሁሉንም አካባቢዎች ይመልከቱ';

  @override
  String locations_addFavorite(String name) {
    return '$nameን ወደ ተወዳጆች ያክሉ';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$nameን ከተወዳጆች ያስወግዱ';
  }

  @override
  String get locations_favoriteSaveFailed => 'ተወዳጁ ሊቀመጥ አልቻለም። እንደገና ይሞክሩ።';

  @override
  String get locations_emptyTitle => 'ምንም አካባቢ አይገኝም';

  @override
  String get locations_emptyHint => 'እንደገና ለመሞከር ዝርዝሩን ያድሱ።';

  @override
  String get devices_manage => 'መሣሪያዎቼን ያስተዳድሩ';

  @override
  String get settings_personalization => 'እንደ ፍላጎትዎ ያብጁ';

  @override
  String get settings_safety => 'ጥበቃ';

  @override
  String get settings_help => 'እርዳታ ያስፈልግዎታል?';

  @override
  String get settings_about => 'ስለ FuzeVPN';

  @override
  String get diagnostics_heading => 'የግንኙነት ችግርን መረዳት';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ይገኛል',
      'pending': 'በዝግጅት ላይ',
      'revoked': 'ተወግዷል',
      'expired': 'ጊዜው አልፎበታል',
      'other': 'ሁኔታው አይገኝም',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ምርጫው አልተቀመጠም';

  @override
  String get notice_preferenceSave_message =>
      'ምርጫዎ ለአሁኑ ተግባራዊ ሆኗል፤ ነገር ግን ሊቀመጥ አልቻለም። መተግበሪያውን ከዘጉ በኋላም እንዲቆይ እንደገና ይሞክሩ።';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPNን ንቁ አድርጎ ካቆየው፣ በሚከፈቱት ቅንብሮች ውስጥ ሁልጊዜ የበራ VPNን ያጥፉ።';

  @override
  String get connection_certificate => 'የOpenVPN ሰርተፍኬት';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'እስከ $date ድረስ ያገለግላል';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'በ$date ጊዜው አልፎበታል';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'በሚቀጥለው ግንኙነት ጊዜ በራስ-ሰር ይታደሳል።';

  @override
  String get protection_learnMore => 'ስለ Android ጥበቃ ይወቁ';

  @override
  String get protection_guideWhy =>
      'ይህ ጥበቃ VPN ግንኙነቱ ከተቋረጠ መተግበሪያዎች በቀጥታ ኢንተርኔትን እንዳይጠቀሙ ይከለክላል። ይህ ቅንብር በAndroid ውስጥ ይዋቀራል።';

  @override
  String get protection_guideAlwaysOnTitle => 'ሁልጊዜ የበራ VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android የVPN አገልግሎቱን ንቁ አድርጎ ያቆያል፤ ስልኩ ዳግም ከጀመረ በኋላም መልሶ ሊያስጀምረው ይችላል።';

  @override
  String get protection_guideBlockTitle => 'VPN ከሌለ ግንኙነቶችን ያግዱ';

  @override
  String get protection_guideBlock =>
      'ይህ ቅንብር ግንኙነቱ በሚቋረጥበት ጊዜም ቢሆን ትራፊክ ከVPN ውጭ እንዳያልፍ ይከለክላል።';

  @override
  String get protection_guideWarning =>
      'ይህ ማገድ ሲነቃ፣ VPN እስኪገናኝ ድረስ የኢንተርኔት መዳረሻ ጠፍቶ ይቆያል።';

  @override
  String get protection_guideStepsTitle => 'ጥበቃን ያብሩ';

  @override
  String get protection_guideStep1 =>
      'ከታች ያለውን አዝራር በመጠቀም የAndroid VPN ቅንብሮችን ይክፈቱ።';

  @override
  String get protection_guideStep2 =>
      'ከFuzeVPN ቀጥሎ ያለውን የማርሽ አዶ በመጠቀም አማራጮቹን ይክፈቱ።';

  @override
  String get protection_guideStep3 =>
      'እነዚህ አማራጮች ካሉ፣ መጀመሪያ “ሁልጊዜ የበራ VPN”ን፣ ከዚያም “VPN ከሌለ ግንኙነቶችን ያግዱ”ን ያንቁ።';

  @override
  String get protection_guideManufacturers =>
      'ስሞቹ እንደ ስልኩ ይለያያሉ። አስፈላጊ ከሆነ በ“ቅንብሮች” ውስጥ VPN ብለው ይፈልጉ፤ ብዙውን ጊዜ በ“አውታረ መረብ እና ኢንተርኔት” ስር ይገኛል።';

  @override
  String get protection_guideDisableTitle => 'ይህን ጥበቃ ያጥፉ';

  @override
  String get protection_guideDisable =>
      'በተመሳሳዩ ቅንብሮች ውስጥ፣ ያለ VPN ኢንተርኔትን ለመጠቀም “VPN ከሌለ ግንኙነቶችን ያግዱ”ን ያጥፉ። Android እንደገና እንዲያስጀምረው ካልፈለጉ “ሁልጊዜ የበራ VPN”ንም ያጥፉ።';

  @override
  String get protection_guideManual =>
      'እነዚህን ቅንብሮች የሚመርጡት በAndroid ውስጥ ነው። FuzeVPN በእርስዎ ምትክ አይቀይራቸውም።';

  @override
  String get locations_changeTitle => 'አካባቢ ይቀይሩ?';

  @override
  String locations_changeActive(String name) {
    return 'VPN ግንኙነቱን ያቋርጣል፤ ከዚያም ከ$name ጋር ለመገናኘት ይሞክራል።';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN ከ$name ጋር ለመገናኘት ይሞክራል።';
  }

  @override
  String get locations_confirmChange => 'ይቀይሩ እና ይገናኙ';

  @override
  String get locations_changeBusy => 'ለውጥ በሂደት ላይ ነው። ሌላ አካባቢ ከመምረጥዎ በፊት ይጠብቁ።';

  @override
  String get locations_automaticSelection => 'ራስ-ሰር ምርጫ';

  @override
  String get locations_cities => 'ከተሞች';

  @override
  String get locations_servers => 'አገልጋዮች';

  @override
  String locations_viewCities(String name) {
    return 'በ$name ውስጥ ያሉ ከተሞችን ይመልከቱ';
  }

  @override
  String locations_viewServers(String name) {
    return 'በ$name ውስጥ ያሉ አገልጋዮችን ይመልከቱ';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count አገሮች',
      one: '$count አገር',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ከተሞች',
      one: '$count ከተማ',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count አገልጋዮች',
      one: '$count አገልጋይ',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ሁሉም አገሮች';

  @override
  String get locations_backToCountries => 'ወደ አገሮች ይመለሱ';

  @override
  String locations_backToCities(String name) {
    return 'ወደ $name ከተሞች ይመለሱ';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$nameን ይምረጡ';
  }

  @override
  String locations_chooseCity(String name) {
    return '$nameን ይምረጡ';
  }

  @override
  String get locations_noCompatibleServer => 'ተኳሃኝ የሆነ አገልጋይ የለም።';

  @override
  String get externalLink_failed =>
      'ይህን አገናኝ መክፈት አልተቻለም። ቀድተው በአሳሽዎ ውስጥ መክፈት ይችላሉ።';

  @override
  String get externalLink_copy => 'አገናኙን ይቅዱ';

  @override
  String get externalLink_copied => 'አገናኙ ተቀድቷል';

  @override
  String get externalLink_copyFailed =>
      'አገናኙን መቅዳት አልተቻለም። ከታች ያለውን አድራሻ ይምረጡ።';

  @override
  String get settings_deleteAccount => 'መለያዬን ይሰርዙ';

  @override
  String get settings_deleteAccountDetail => 'የመለያ መሰረዝ ጥያቄ አሰራርን ይመልከቱ';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'የVPN የደንበኝነት ምዝገባዎን ይምረጡ።';

  @override
  String get billing_subscribe => 'በደንበኝነት ይመዝገቡ';

  @override
  String get billing_choosePlan => 'ለመቀጠል ዕቅድ ይምረጡ።';

  @override
  String get billing_monthly => 'ወርሃዊ';

  @override
  String get billing_yearly => 'ዓመታዊ';

  @override
  String get billing_continue => 'በGoogle Play ይቀጥሉ';

  @override
  String get billing_restore => 'ግዢዎችን ወደነበረበት ይመልሱ';

  @override
  String get billing_manage => 'የደንበኝነት ምዝገባን ያስተዳድሩ';

  @override
  String get billing_deleteAccountWarning =>
      'የGoogle Play የደንበኝነት ምዝገባ ካለዎት የFuzeVPN መለያዎን መሰረዝ የምዝገባውን እድሳት አያቋርጥም። እድሳቱን በGoogle Play ውስጥ ለብቻ ያስተዳድሩ ወይም ይሰርዙ።';

  @override
  String get billing_deleteAccountContinue => 'ወደ መለያ መሰረዝ ጥያቄ ይቀጥሉ';

  @override
  String get billing_refresh => 'መዳረሻን ያድሱ';

  @override
  String get billing_loadingPlans => 'ዕቅዶች በመጫን ላይ…';

  @override
  String get billing_unavailable => 'በአሁኑ ጊዜ ምንም ዕቅድ የለም። ቆይተው እንደገና ይሞክሩ።';

  @override
  String get billing_comingSoon => 'የደንበኝነት ምዝገባዎች በቅርቡ ይገኛሉ።';

  @override
  String get billing_priceDisclosure =>
      'ዋጋው በGoogle Play የቀረበ ነው። የመጨረሻው መጠን እና ተፈጻሚ የሚሆኑ ግብሮች ከማረጋገጥዎ በፊት ይረጋገጣሉ።';

  @override
  String get billing_renewalMonthly =>
      'ካልተሰረዘ በስተቀር በየወሩ በራስ-ሰር ይታደሳል። በማንኛውም ጊዜ በGoogle Play የደንበኝነት ምዝገባዎች ውስጥ መሰረዝ ይችላሉ።';

  @override
  String get billing_renewalYearly =>
      'ካልተሰረዘ በስተቀር በየዓመቱ በራስ-ሰር ይታደሳል። በማንኛውም ጊዜ በGoogle Play የደንበኝነት ምዝገባዎች ውስጥ መሰረዝ ይችላሉ።';

  @override
  String get billing_active => 'የእርስዎ Premium መዳረሻ ንቁ ነው';

  @override
  String billing_accessUntil(String date) {
    return 'መዳረሻ እስከ $date ድረስ ይቆያል።';
  }

  @override
  String get billing_webManaged =>
      'የእርስዎ የደንበኝነት ምዝገባ በFuzeVPN ድረ-ገጽ ላይ ይተዳደራል።';

  @override
  String get billing_playManaged =>
      'የእርስዎ የደንበኝነት ምዝገባ የሚተዳደረው በGoogle Play ነው።';

  @override
  String get billing_playOnHold =>
      'የእርስዎ የGoogle Play የደንበኝነት ምዝገባ ታግዷል ወይም ክፍያ በመጠባበቅ ላይ ነው። ለማስተካከል በGoogle Play “የደንበኝነት ምዝገባን ያስተዳድሩ”ን ይክፈቱ።';

  @override
  String get billing_playReceiptUnlinked =>
      'ይህ የGoogle Play መለያ ለዚህ FuzeVPN መለያ ንቁ ያልሆነ የFuze Premium የደንበኝነት ምዝገባ ቀድሞውኑ አለው። ለመገምገም በGoogle Play “የደንበኝነት ምዝገባን ያስተዳድሩ”ን ይክፈቱ።';

  @override
  String get billing_inactive => 'ንቁ የደንበኝነት ምዝገባ የለም።';

  @override
  String get billing_checkingAccess => 'የእርስዎን መዳረሻ በመፈተሽ ላይ…';

  @override
  String get billing_restoring => 'ግዢዎችን ወደነበረበት በመመለስ ላይ…';

  @override
  String get billing_pending =>
      'ክፍያው በመጠባበቅ ላይ ነው። ከተረጋገጠ በኋላ የእርስዎ መዳረሻ ይነቃል።';

  @override
  String get billing_cancelled => 'ግዢው ተሰርዟል። አዲስ የደንበኝነት ምዝገባ አልነቃም።';

  @override
  String get billing_verifying => 'ግዢውን በማረጋገጥ ላይ…';

  @override
  String get billing_success => 'የደንበኝነት ምዝገባ ነቅቷል። የእርስዎ Premium መዳረሻ ዝግጁ ነው።';

  @override
  String get billing_restored => 'የእርስዎ ግዢዎች ወደነበሩበት ተመልሰዋል።';

  @override
  String get billing_restoreEmpty =>
      'ለዚህ Google Play መለያ ወደነበረበት የሚመለስ ግዢ የለም።';

  @override
  String get billing_catalogError => 'ዕቅዶችን መጫን አልተቻለም። እንደገና ይሞክሩ።';

  @override
  String get billing_purchaseError => 'ግዢውን መጀመር አልተቻለም። እንደገና ይሞክሩ።';

  @override
  String get billing_verificationError =>
      'የግዢ ማረጋገጫ ለጊዜው አይገኝም። እንደገና ለመሞከር ግዢዎችን ወደነበረበት ይመልሱ።';

  @override
  String get billing_restoreError => 'ግዢዎችን ወደነበረበት መመለስ አልተቻለም። እንደገና ይሞክሩ።';

  @override
  String get billing_managementError =>
      'የደንበኝነት ምዝገባ አስተዳደርን መክፈት አልተቻለም። እንደገና ይሞክሩ።';

  @override
  String get billing_storeUnavailable => 'Google Play በዚህ መሣሪያ ላይ አይገኝም።';

  @override
  String get welcome_title => 'የእርስዎ VPN፣ ቀላል ተደርጓል።';

  @override
  String get welcome_description => 'ግንኙነትዎን ይጠብቁ። የግላዊነትዎን ቁጥጥር በእጅዎ ይያዙ።';

  @override
  String get welcome_start => 'ይጀምሩ';

  @override
  String get welcome_alreadyPurchased => 'ቀድሞ ገዝተዋል?';

  @override
  String get welcome_noAccountRequired => 'ለመጀመር መለያ አያስፈልግም።';

  @override
  String get guest_accountTitle => 'መለያ አልተያያዘም';

  @override
  String get guest_accountDescription =>
      'የደንበኝነት ምዝገባዎን በሌላ መሣሪያ ላይ ለመጠቀም ግዢዎችዎን በተመሳሳዩ የGoogle Play መለያ ወደነበሩበት ይመልሱ።';

  @override
  String get guest_existingSubscriberSignIn => 'ቀድሞ በደንበኝነት ተመዝግበዋል? ይግቡ';

  @override
  String get guest_claimTitle => 'FuzeVPNን ይዘው ይሂዱ';

  @override
  String get guest_claimDescription =>
      'የደንበኝነት ምዝገባዎን በሌሎች መሣሪያዎችዎ ላይ ለማግኘት መለያ ይፍጠሩ። ይህ ደረጃ አማራጭ ነው።';

  @override
  String get guest_skip => 'ምናልባት በኋላ';

  @override
  String get guest_activationTitle => 'Fuze Premium ንቁ ነው';

  @override
  String get guest_activationDescription =>
      'የደንበኝነት ምዝገባዎ ዝግጁ ነው። VPNዎን ይጠቀሙ፤ በፈለጉበት ጊዜ መለያ መፍጠር ይችላሉ።';

  @override
  String get guest_useVpn => 'VPNን ይጠቀሙ';

  @override
  String get guest_loginRequired =>
      'ይህ ግዢ ቀድሞውኑ ከFuzeVPN መለያ ጋር ተያይዟል። የደንበኝነት ምዝገባዎን ለማግኘት ወደዚያ መለያ ይግቡ።';

  @override
  String get guest_signOutWarning =>
      'ግዢዎችን በተመሳሳዩ የGoogle Play መለያ ወደነበሩበት በመመለስ የደንበኝነት ምዝገባዎን ማግኘት ይችላሉ።';

  @override
  String get guest_profileUnavailable =>
      'የእርስዎ መለያ ቀድሞውኑ ተያይዟል። ዝርዝሮችዎን ለማየት እና ለማስተዳደር ይግቡ።';

  @override
  String get billing_acceptance => 'በመቀጠል የአጠቃቀም ውሎችን እና የግላዊነት ፖሊሲን ይቀበላሉ።';

  @override
  String get guest_verifyEmailReminder =>
      'መለያዎን ለመጠበቅ የኢሜይል አድራሻዎን ያረጋግጡ። VPNዎን መጠቀም መቀጠል ይችላሉ።';

  @override
  String get guest_serviceUnavailable =>
      'አገልግሎቱ ለጊዜው አይገኝም። ከጥቂት ጊዜ በኋላ እንደገና ይሞክሩ።';

  @override
  String get guest_restoreError =>
      'ግዢዎችዎን ወደነበሩበት መመለስ አልተቻለም። ግዢው በተፈጸመበት የGoogle Play መለያ እንደገና ይሞክሩ።';

  @override
  String get guest_claimSuccess =>
      'መለያዎ ተፈጥሯል። የደንበኝነት ምዝገባዎ እና የVPN መዳረሻዎ ተጠብቀው ይቆያሉ።';

  @override
  String get guest_emailExists =>
      'ይህ ኢሜይል ቀድሞውኑ ጥቅም ላይ ውሏል። ሌላ አድራሻ ይምረጡ ወይም ወደ ነባር መለያዎ ይግቡ። ግዢዎ በGoogle Play በኩል ይገኛል።';

  @override
  String get guest_claimError =>
      'መለያዎ መፈጠር አልቻለም። VPNዎን መጠቀም መቀጠል እና ቆይተው እንደገና መሞከር ይችላሉ።';

  @override
  String get guest_secureStorageError =>
      'ክፍለ ጊዜዎ በዚህ መሣሪያ ላይ ሊጠበቅ አልቻለም። እንደገና ይሞክሩ።';

  @override
  String get guest_premiumRequired => 'VPNዎን ለማንቃት የደንበኝነት ምዝገባ ይምረጡ።';

  @override
  String get welcome_viewPlans => 'ዕቅዶችን ይመልከቱ';

  @override
  String get google_continue => 'በGoogle ይቀጥሉ';

  @override
  String get google_or => 'ወይም';

  @override
  String get google_title => 'የእርስዎ FuzeVPN መለያ';

  @override
  String get google_settingUp => 'መለያዎን መፍጠር ያጠናቅቁ';

  @override
  String get google_country => 'የመኖሪያ አገር';

  @override
  String get google_profileDescription =>
      'የFuzeVPN መለያዎን ለመፍጠር አገርዎን ይምረጡ እና ሁለቱንም ሰነዶች ይገምግሙ።';

  @override
  String get google_claimDescription =>
      'የእንግዳ መለያዎን ከGoogle ጋር ያገናኙ። የደንበኝነት ምዝገባዎ እና መሣሪያዎ ከዚህ መለያ ጋር ተያይዘው ይቆያሉ።';

  @override
  String get google_linkTitle => 'Googleን ከFuzeVPN ጋር ያገናኙ';

  @override
  String get google_linkDescription =>
      'ወደ ነባሩ FuzeVPN መለያዎ መዳረሻን ያረጋግጡ። ይህ ደረጃ የGoogle የይለፍ ቃልዎን አይጠይቅም።';

  @override
  String get google_password => 'የFuzeVPN የይለፍ ቃል';

  @override
  String get google_linkAccount => 'ማገናኘቱን ያረጋግጡ';

  @override
  String get google_requestEmail => 'የማረጋገጫ ኢሜይል ይላኩልኝ';

  @override
  String get google_emailInstructions =>
      'የFuzeVPN ኢሜይሉን ይክፈቱ እና የማረጋገጫ ኮዱን ያስገቡ።';

  @override
  String get google_emailCode => 'የኢሜይል ማረጋገጫ ኮድ';

  @override
  String get google_confirmEmail => 'ኮዱን ያረጋግጡ';

  @override
  String get google_restart => 'ሌላ የGoogle መለያ ይምረጡ';

  @override
  String get google_resume => 'ይህን ሙከራ ያረጋግጡ';

  @override
  String get google_unavailable =>
      'የGoogle መግቢያ አይገኝም። ኢሜይል እና የይለፍ ቃል መጠቀም ይችላሉ።';

  @override
  String get google_expired => 'ይህ ሙከራ ጊዜው አልፎበታል። ይሰርዙት እና እንደገና ይጀምሩ።';

  @override
  String get google_conflict =>
      'ይህ የGoogle መለያ ቀድሞውኑ በሌላ ቦታ ተያይዟል። አሁን ያለዎት መለያ እና የደንበኝነት ምዝገባ ይቀመጣሉ።';

  @override
  String get google_error =>
      'የGoogle መግቢያ አልተሳካም። እንደገና ይሞክሩ፤ አሁን ያለዎት መዳረሻ ይቀመጣል።';

  @override
  String get google_uncertain =>
      'ውጤቱ ሊረጋገጥ አልቻለም። እንደገና ከመጀመርዎ በፊት ይህን ሙከራ ያረጋግጡ ወይም ይሰርዙት።';

  @override
  String get google_cancelFailed =>
      'ሙከራውን መሰረዝ ሊረጋገጥ አልቻለም። ይህን ማያ ገጽ ከመልቀቅዎ በፊት እንደገና ለመሰረዝ ይሞክሩ።';

  @override
  String get google_cancelled => 'የGoogle መግቢያ ተሰርዟል።';

  @override
  String get google_selecting => 'የእርስዎን የGoogle መለያ ይምረጡ…';

  @override
  String get google_verifying => 'መለያዎን በመፈተሽ ላይ…';

  @override
  String get google_emailUnavailable =>
      'የማረጋገጫ ኢሜይሉ ሊላክ አልቻለም። ቆይተው እንደገና ይሞክሩ።';

  @override
  String get google_emailSent => 'የማረጋገጫ ኢሜይል ተልኳል። የገቢ መልዕክት ሳጥንዎን ይመልከቱ።';

  @override
  String get google_rateLimited => 'እባክዎ እንደገና ከመሞከርዎ በፊት ይጠብቁ።';

  @override
  String get google_busy =>
      'ሌላ ስራ በሂደት ላይ ባለበት ጊዜ (የVPN ግንኙነት፣ መለያ ወይም እንግዳ) Google አይገኝም። ስራው እንደተጠናቀቀ እንደገና ይሞክሩ፤ አሁን ያለዎት መዳረሻ ይቀመጣል።';

  @override
  String get google_invalidPassword =>
      'የFuzeVPN የይለፍ ቃል ትክክል አይደለም። አሁን ያለዎት መለያ ይቀመጣል።';

  @override
  String get google_invalidCode => 'የማረጋገጫ ኮዱ ልክ ያልሆነ ወይም ጊዜው ያለፈበት ነው።';

  @override
  String get google_accountChanged =>
      'ክፍለ ጊዜዎ ተቀይሯል። እንደገና ከመጀመርዎ በፊት ይህን ሙከራ ይሰርዙ።';

  @override
  String get google_invalidResponse =>
      'ምላሹን ማረጋገጥ አልተቻለም። አሁን ያለዎት መዳረሻ ይቀመጣል።';

  @override
  String get google_invalidRegistration => 'አገርዎን እና ሁለቱንም ስምምነቶች ያረጋግጡ።';

  @override
  String get google_consentRequired => 'ለመቀጠል አገርዎን ይምረጡ እና ሁለቱንም ሰነዶች ይቀበሉ።';

  @override
  String get google_challengeRequired =>
      'ተጨማሪ የደህንነት ማረጋገጫ ያስፈልጋል። አሁን ያለዎት መዳረሻ ይቀመጣል።';

  @override
  String get google_challengeUnavailable =>
      'የደህንነት ማረጋገጫው አይገኝም። ቆይተው እንደገና ይሞክሩ።';

  @override
  String get google_intentMismatch =>
      'ቀደም ሲል የተጀመረ የGoogle መግቢያ ሙከራ አሁንም በመጠባበቅ ላይ ነው። ይህን ስራ ከመጀመርዎ በፊት ይሰርዙት።';

  @override
  String get google_challengeBlocked =>
      'አስፈላጊው የደህንነት ማረጋገጫ በዚህ መተግበሪያ ውስጥ አይገኝም። ይህ ስራ አሁን ሊጠናቀቅ አይችልም።';

  @override
  String get google_solveChallenge => 'የደህንነት ማረጋገጫውን ያጠናቅቁ';

  @override
  String get google_challengeTitle => 'የደህንነት ማረጋገጫ';

  @override
  String get google_challengeReady =>
      'ማረጋገጫው ተጠናቋል። አሁን መለያዎን መፍጠር ማረጋገጥ ይችላሉ።';

  @override
  String get google_challengeExpired =>
      'ማረጋገጫው ጊዜው አልፎበታል። ከማረጋገጥዎ በፊት እንደገና ያጠናቅቁት።';

  @override
  String get google_challengeCancelled => 'ማረጋገጫው ተሰርዟል። እንደገና መሞከር ይችላሉ።';

  @override
  String get google_challengeFailed => 'የደህንነት ማረጋገጫው አልተሳካም። እንደገና ይሞክሩ።';

  @override
  String get billing_trialTitle => 'Fuze Premiumን በነጻ ይሞክሩ';

  @override
  String get billing_trialSubtitle => 'ከዛሬ ጀምሮ ግንኙነትዎን ይጠብቁ።';

  @override
  String get billing_trialWeeks => 'የ2 ሳምንት ነጻ ሙከራ';

  @override
  String billing_trialDays(String days) {
    return 'የ$days ቀን ነጻ ሙከራ';
  }

  @override
  String get billing_trialStart => 'ነጻ ሙከራዬን ይጀምሩ';

  @override
  String billing_trialFirstCharge(String date) {
    return 'ዛሬ ከጀመሩ የመጀመሪያ ክፍያዎ $date ላይ እንደሚፈጸም ይጠበቃል።';
  }

  @override
  String get billing_trialTerms =>
      'በተገለጸው ዋጋ በራስ-ሰር ይታደሳል። ክፍያ እንዳይፈጸም ሙከራው ከማለቁ በፊት በGoogle Play ይሰርዙ።';

  @override
  String billing_trialThenMonthly(String price) {
    return 'ከዚያ በኋላ በወር $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'ከዚያ በኋላ በዓመት $price';
  }

  @override
  String get billing_choosePeriod => 'ዕቅድዎን ይምረጡ';

  @override
  String get billing_selectionHint => 'ለመቀጠል ዕቅድ ይምረጡ።';

  @override
  String get billing_benefitConnection => 'የተመሰጠረ ግንኙነት';

  @override
  String get billing_benefitPrivacy => 'የመስመር ላይ ግላዊነት';

  @override
  String get billing_benefitNoAccount => 'መመዝገብ አያስፈልግም';

  @override
  String get billing_cancellation => 'በGoogle Play ይሰርዙ';

  @override
  String get billing_premiumTitle => 'የተሻለ ጥበቃ ያለው ግንኙነት።';

  @override
  String get billing_premiumSubtitle => 'ግንኙነትዎን በራስዎ ፍጥነት ይጠብቁ።';

  @override
  String get billing_priceMonthly => 'በወር';

  @override
  String get billing_priceYearly => 'በዓመት';

  @override
  String get billing_trialToday => 'ዛሬ ምንም መክፈል አያስፈልግም';

  @override
  String get billing_trialConfirmation =>
      'Google Play ከማረጋገጥዎ በፊት ቀኖቹን፣ የመጨረሻውን መጠን እና ተፈጻሚ የሚሆኑ ግብሮችን ያረጋግጣል።';

  @override
  String get billing_offerChanged =>
      'የዚህ ቅናሽ ውሎች ተቀይረዋል። ዕቅዶቹን ያድሱ እና እንደገና ይምረጡ።';

  @override
  String get status_waitingNetwork => 'አውታረ መረብን በመጠበቅ ላይ';

  @override
  String get status_waitingNetworkDetail =>
      'ምንም አውታረ መረብ የለም። አውታረ መረቡ ሲመለስ VPN ግንኙነቱን ያረጋግጣል።';

  @override
  String get locations_favoriteLoadFailed => 'ተወዳጆችን መጫን አልተቻለም። እንደገና ይሞክሩ።';

  @override
  String get locations_favoritesLoading => 'ተወዳጆችን በመጫን ላይ…';
}
