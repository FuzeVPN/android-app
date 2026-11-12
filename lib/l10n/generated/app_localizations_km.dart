// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get vpnDisclosure_title => 'ការពារការតភ្ជាប់របស់អ្នក';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN ប្រើសេវាកម្ម VPN របស់ Android (VpnService) ដើម្បីបង្កើតផ្លូវតុនែលដែលបានអ៊ិនគ្រីបរវាងឧបករណ៍នេះ និងម៉ាស៊ីនមេ FuzeVPN។';

  @override
  String get vpnDisclosure_dataBody =>
      'នៅពេល VPN សកម្ម ចរាចរណ៍អ៊ីនធឺណិតរបស់កម្មវិធីរបស់អ្នក អាសយដ្ឋានគោលដៅ និងសំណើ DNS នឹងឆ្លងកាត់ផ្លូវតុនែលនេះ ដើម្បីបញ្ជូនការតភ្ជាប់របស់អ្នក ទោះបីជា FuzeVPN ដំណើរការនៅផ្ទៃខាងក្រោយក៏ដោយ។';

  @override
  String get vpnDisclosure_statusBody =>
      'កម្មវិធីនេះប្រើស្ថានភាពការតភ្ជាប់ រយៈពេល និងបរិមាណទិន្នន័យដែលបានផ្ទេរ ដើម្បីបង្ហាញការតភ្ជាប់ VPN របស់អ្នក។ អ្នកអាចបញ្ឈប់វាបានគ្រប់ពេល។';

  @override
  String get vpnDisclosure_privacy => 'ឯកជនភាព';

  @override
  String get vpnDisclosure_accept => 'ទទួលយក និងបន្ត';

  @override
  String get vpnDisclosure_decline => 'មិនមែនឥឡូវនេះទេ';

  @override
  String get accountRestoration_title => 'គណនីមិនអាចប្រើបានជាបណ្តោះអាសន្ន';

  @override
  String get accountRestoration_message =>
      'វគ្គរបស់អ្នកត្រូវបានរក្សាទុក។ សូមព្យាយាមម្តងទៀត ដើម្បីស្តារគណនីរបស់អ្នក ហើយអ្នកនៅតែអាចគ្រប់គ្រងការតភ្ជាប់ VPN នៅទីនេះបាន។';

  @override
  String get action_retry => 'ព្យាយាមម្តងទៀត';

  @override
  String get session_endingTitle => 'កំពុងបញ្ចប់វគ្គ';

  @override
  String get session_ending => 'កំពុងបញ្ចប់វគ្គ៖ កំពុងបញ្ឈប់ VPN និងសម្អាត…';

  @override
  String get session_stopFailed =>
      'មិនទាន់បានបញ្ជាក់ការបញ្ឈប់ VPN ទេ។ សូមព្យាយាមម្តងទៀត មុនពេលចូលគណនីឡើងវិញ។';

  @override
  String get session_cleanupFailed =>
      'VPN ត្រូវបានបញ្ឈប់ហើយ ប៉ុន្តែមិនទាន់បានបញ្ជាក់ការលុបវគ្គទេ។ សូមព្យាយាមសម្អាតម្តងទៀត។';

  @override
  String get session_retryStop => 'ព្យាយាមបញ្ឈប់ម្តងទៀត';

  @override
  String get session_retryCleanup => 'ព្យាយាមសម្អាតម្តងទៀត';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'កំពុងរៀបចំ FuzeVPN ដោយសុវត្ថិភាព…';

  @override
  String get nav_connection => 'ការតភ្ជាប់';

  @override
  String get nav_locations => 'ទីតាំង';

  @override
  String get nav_account => 'គណនី';

  @override
  String get nav_devices => 'ឧបករណ៍';

  @override
  String get nav_settings => 'ការកំណត់';

  @override
  String get action_refresh => 'ធ្វើបច្ចុប្បន្នភាព';

  @override
  String get auth_tab_login => 'ចូលគណនី';

  @override
  String get auth_tab_register => 'ចុះឈ្មោះ';

  @override
  String get auth_stepAccount => 'គណនី';

  @override
  String get auth_stepIdentity => 'អត្តសញ្ញាណ';

  @override
  String get auth_stepAddress => 'អាសយដ្ឋាន និងកិច្ចព្រមព្រៀង';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'ជំហានទី $current នៃ $total';
  }

  @override
  String get auth_tagline => 'VPN របស់អ្នក ធ្វើឱ្យសាមញ្ញ។';

  @override
  String get auth_keysLocal => 'កូនសោ VPN ឯកជនរបស់អ្នកនៅតែស្ថិតនៅលើឧបករណ៍នេះ។';

  @override
  String get form_email => 'អាសយដ្ឋានអ៊ីមែល';

  @override
  String get form_password => 'ពាក្យសម្ងាត់';

  @override
  String get form_showPassword => 'បង្ហាញពាក្យសម្ងាត់';

  @override
  String get form_hidePassword => 'លាក់ពាក្យសម្ងាត់';

  @override
  String get form_passwordMin =>
      '8–72 បៃ UTF-8។ តួអក្សរមួយចំនួនប្រើច្រើនជាងមួយបៃ។';

  @override
  String get form_firstName => 'នាមខ្លួន';

  @override
  String get form_lastName => 'នាមត្រកូល';

  @override
  String get form_phone => 'ទូរស័ព្ទ (+33612345678)';

  @override
  String get form_address => 'អាសយដ្ឋាន';

  @override
  String get form_address2 => 'បន្ទាត់អាសយដ្ឋានទី 2 (ស្រេចចិត្ត)';

  @override
  String get form_postalCode => 'លេខកូដប្រៃសណីយ៍';

  @override
  String get form_city => 'ទីក្រុង';

  @override
  String get form_country => 'លេខកូដប្រទេស (ឧទាហរណ៍ FR)';

  @override
  String get action_login => 'ចូលគណនី';

  @override
  String get action_createAccount => 'បង្កើតគណនី';

  @override
  String get action_createMyAccount => 'បង្កើតគណនីរបស់ខ្ញុំ';

  @override
  String get action_next => 'បន្ត';

  @override
  String get action_previous => 'ថយក្រោយ';

  @override
  String get action_forgotPassword => 'ភ្លេចពាក្យសម្ងាត់?';

  @override
  String get auth_noAccount => 'មិនទាន់មានគណនីទេ?';

  @override
  String get auth_requiredInformation => 'បង្កើតគណនីរបស់អ្នកក្នុងបីជំហាន។';

  @override
  String get auth_termsPrefix => 'ខ្ញុំទទួលយក ';

  @override
  String get auth_termsLink => 'លក្ខខណ្ឌប្រើប្រាស់';

  @override
  String get auth_privacyPrefix => 'ខ្ញុំទទួលយក ';

  @override
  String get auth_privacyLink => 'គោលការណ៍ឯកជនភាព';

  @override
  String get auth_consentRequired =>
      'ត្រូវការការយល់ព្រមរបស់អ្នក ដើម្បីបង្កើតគណនី។';

  @override
  String get validation_required => 'ត្រូវតែបំពេញវាលនេះ។';

  @override
  String get validation_email => 'សូមបញ្ចូលអាសយដ្ឋានអ៊ីមែលឱ្យត្រឹមត្រូវ។';

  @override
  String get validation_password => 'ពាក្យសម្ងាត់ខ្លីពេក៖ យ៉ាងតិច 8 បៃ UTF-8។';

  @override
  String get validation_passwordTooLong =>
      'ពាក្យសម្ងាត់វែងពេក៖ យ៉ាងច្រើនបំផុត 72 បៃ UTF-8។';

  @override
  String get validation_phone => 'សូមប្រើទម្រង់អន្តរជាតិ ឧទាហរណ៍ +33612345678។';

  @override
  String get validation_country => 'សូមប្រើលេខកូដប្រទេសពីរតួអក្សរ ឧទាហរណ៍ FR។';

  @override
  String get passwordReset_title => 'កំណត់ពាក្យសម្ងាត់ឡើងវិញ';

  @override
  String get passwordReset_description =>
      'សូមបញ្ចូលអាសយដ្ឋានអ៊ីមែលគណនីរបស់អ្នក ដើម្បីស្នើសុំតំណកំណត់ពាក្យសម្ងាត់ឡើងវិញ។';

  @override
  String get passwordReset_send => 'ផ្ញើតំណ';

  @override
  String get connection_title => 'ការតភ្ជាប់របស់អ្នក';

  @override
  String get connection_subtitle => 'សូមជ្រើសរើសទីតាំងមួយ ហើយបើក VPN របស់អ្នក។';

  @override
  String get connection_prepare => 'ត្រៀមខ្លួនភ្ជាប់ហើយឬនៅ?';

  @override
  String get connection_advancedOptions => 'ជម្រើសកម្រិតខ្ពស់';

  @override
  String get connection_location => 'ទីតាំង';

  @override
  String get connection_chooseLocation => 'ជ្រើសរើសទីតាំង';

  @override
  String get connection_protocol => 'ប្រូតូកូល';

  @override
  String get connection_connect => 'ភ្ជាប់';

  @override
  String get connection_connecting => 'កំពុងភ្ជាប់…';

  @override
  String get connection_disconnect => 'ផ្តាច់';

  @override
  String get connection_disconnecting => 'កំពុងផ្តាច់';

  @override
  String get connection_locationChange => 'កំពុងប្តូរទីតាំង…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol មិនអាចប្រើបានទេ';
  }

  @override
  String get connection_activeLocation => 'ទីតាំងដែលកំពុងប្រើ';

  @override
  String get connection_duration => 'រយៈពេល';

  @override
  String get connection_received => 'បានទទួល';

  @override
  String get connection_sent => 'បានផ្ញើ';

  @override
  String get connection_lastHandshake => 'ការដោះដូរសុវត្ថិភាពចុងក្រោយ';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration មុន';
  }

  @override
  String get verification_title => 'បញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នក';

  @override
  String get verification_message =>
      'សូមបញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នក ដើម្បីប្រើ VPN នៅលើទូរស័ព្ទនេះ។';

  @override
  String get verification_resend => 'ផ្ញើអ៊ីមែលឡើងវិញ';

  @override
  String get migration_title => 'ការប្តូរទីតាំង';

  @override
  String get migration_draining => 'កំពុងរៀបចំការប្តូរទីតាំង…';

  @override
  String get migration_activating => 'កំពុងបើកដំណើរការម៉ាស៊ីនមេថ្មី…';

  @override
  String get migration_ready => 'បានធ្វើបច្ចុប្បន្នភាពទីតាំងហើយ។';

  @override
  String get migration_blocked =>
      'ការប្តូរទីតាំងត្រូវការអន្តរាគមន៍ពីផ្នែកម៉ាស៊ីនមេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ ឬទាក់ទងផ្នែកជំនួយ។';

  @override
  String get migration_progress => 'វឌ្ឍនភាពនៃការប្តូរទីតាំង';

  @override
  String migration_retryDelay(Object seconds) {
    return 'ចន្លោះពេលរវាងការត្រួតពិនិត្យ៖ $seconds វិនាទី។';
  }

  @override
  String get migration_resume => 'បន្តការប្តូរទីតាំង';

  @override
  String get status_authorizing => 'ត្រូវការការអនុញ្ញាត';

  @override
  String get status_authorizingDetail =>
      'សូមទទួលយកសំណើរបស់ Android ដើម្បីអនុញ្ញាតឱ្យប្រើ VPN។';

  @override
  String get status_preparing => 'កំពុងរៀបចំ';

  @override
  String get status_preparingDetail =>
      'កំពុងរៀបចំការតភ្ជាប់សុវត្ថិភាពរបស់អ្នក។';

  @override
  String get status_reconnecting => 'កំពុងភ្ជាប់ឡើងវិញ…';

  @override
  String get status_reconnectingDetail =>
      'ការតភ្ជាប់ត្រូវបានរំខាន។ VPN កំពុងព្យាយាមភ្ជាប់ឡើងវិញ។';

  @override
  String get status_connecting => 'កំពុងភ្ជាប់';

  @override
  String get status_connectingDetail => 'កំពុងភ្ជាប់ទៅម៉ាស៊ីនមេ VPN…';

  @override
  String get status_connected => 'បានភ្ជាប់';

  @override
  String get status_connectedDetail => 'ការតភ្ជាប់ VPN របស់អ្នកកំពុងដំណើរការ។';

  @override
  String get status_disconnecting => 'កំពុងផ្តាច់';

  @override
  String get status_disconnectingDetail =>
      'ការតភ្ជាប់ VPN របស់អ្នកកំពុងត្រូវបានបញ្ឈប់។';

  @override
  String get status_error => 'ការតភ្ជាប់មិនអាចប្រើបានទេ';

  @override
  String get status_errorDetail =>
      'មិនទាន់បានបញ្ជាក់ការតភ្ជាប់ VPN ទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get status_idle => 'បានផ្តាច់';

  @override
  String get status_idleDetail =>
      'សូមភ្ជាប់ VPN ដើម្បីការពារការតភ្ជាប់របស់អ្នក។';

  @override
  String get trust_note =>
      'ការបិទកម្មវិធីមិនបញ្ឈប់ VPN ទេ។ ដើម្បីបញ្ឈប់ សូមចុច ផ្តាច់។';

  @override
  String get locations_none => 'បច្ចុប្បន្នមិនមានទីតាំងណាអាចប្រើបានទេ។';

  @override
  String get locations_available => 'ជ្រើសរើសទីតាំងបន្ទាប់របស់អ្នក។';

  @override
  String get locations_selected => 'ទីតាំងដែលបានជ្រើសរើស';

  @override
  String get locations_select => 'ជ្រើសរើសទីតាំងនេះ';

  @override
  String get locations_lockedTunnel => 'សូមផ្តាច់ VPN ដើម្បីប្តូរទីតាំង។';

  @override
  String get locations_lockedMigration => 'សូមរង់ចាំឱ្យការប្តូរទីតាំងបញ្ចប់។';

  @override
  String get devices_title => 'ឧបករណ៍របស់អ្នក';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit ឧបករណ៍';
  }

  @override
  String get devices_refresh => 'ធ្វើបច្ចុប្បន្នភាពឧបករណ៍';

  @override
  String get devices_empty => 'មិនទាន់មានឧបករណ៍ VPN ដែលបានចុះឈ្មោះនៅឡើយទេ។';

  @override
  String get devices_firstConnection =>
      'ទូរស័ព្ទរបស់អ្នកនឹងត្រូវបានបន្ថែមនៅពេលភ្ជាប់លើកដំបូង។';

  @override
  String get devices_thisDevice => 'ឧបករណ៍នេះ';

  @override
  String devices_added(Object date) {
    return 'បានបន្ថែមកាលពី $date';
  }

  @override
  String get devices_unnamed => 'ឧបករណ៍គ្មានឈ្មោះ';

  @override
  String get action_remove => 'ដកចេញ';

  @override
  String get settings_title => 'ការកំណត់';

  @override
  String get settings_subtitle =>
      'ការកំណត់ចំណូលចិត្ត និងគណនីរបស់អ្នក នៅកន្លែងតែមួយ។';

  @override
  String get settings_appearance => 'រូបរាង';

  @override
  String get settings_language => 'ភាសា';

  @override
  String get settings_languageDescription =>
      'ភាសាដែលអ្នកបានជ្រើសរើសក៏ត្រូវបានប្រើសម្រាប់ការជូនដំណឹង VPN ផងដែរ។';

  @override
  String get settings_account => 'គណនី';

  @override
  String get settings_signOut => 'ចេញពីគណនី';

  @override
  String get settings_privacy => 'គោលការណ៍ឯកជនភាព';

  @override
  String get settings_terms => 'លក្ខខណ្ឌប្រើប្រាស់';

  @override
  String get settings_security => 'សុវត្ថិភាព និងតម្លាភាព';

  @override
  String get settings_licenses => 'អាជ្ញាបណ្ណនៃសមាសធាតុ';

  @override
  String get settings_licensesDetail => 'ផ្នែកទន់ដែលប្រើក្នុងកម្មវិធីនេះ';

  @override
  String settings_licensesLegalese(String url) {
    return 'កូដប្រភពនៃកម្មវិធី និងសមាសធាតុ MPL-2.0 របស់វា៖ $url';
  }

  @override
  String get settings_background =>
      'VPN នៅតែដំណើរការនៅពេលអ្នកចាកចេញពីកម្មវិធី។ ដើម្បីបញ្ឈប់ សូមចុច ផ្តាច់ នៅក្នុងផ្ទាំងការតភ្ជាប់។';

  @override
  String get theme_system => 'តាមប្រព័ន្ធ';

  @override
  String get theme_light => 'ភ្លឺ';

  @override
  String get theme_dark => 'ងងឹត';

  @override
  String get language_system => 'ភាសាទូរស័ព្ទ';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'ដកឧបករណ៍នេះចេញមែនទេ?';

  @override
  String get dialog_removeCurrent =>
      'ទូរស័ព្ទនេះនឹងផ្តាច់ពី VPN ហើយបាត់បង់ការចូលប្រើ។ ទិន្នន័យការតភ្ជាប់ VPN របស់វានឹងត្រូវបានលុប បន្ទាប់ពីម៉ាស៊ីនមេបានបញ្ជាក់។';

  @override
  String dialog_removeOther(Object name) {
    return 'សិទ្ធិចូលប្រើ VPN របស់ “$name” នឹងត្រូវបានដកហូត។ សកម្មភាពនេះមិនអាចត្រឡប់វិញបានទេ។';
  }

  @override
  String get dialog_signOut => 'ចេញពីគណនីមែនទេ?';

  @override
  String get dialog_signOutMessage =>
      'VPN នឹងឈប់ដំណើរការ ហើយអ្នកនឹងត្រូវចូលគណនីម្តងទៀត។ កូនសោ VPN ដែលបានអ៊ិនគ្រីបរបស់អ្នកនឹងនៅតែស្ថិតនៅលើទូរស័ព្ទនេះ សម្រាប់ការតភ្ជាប់បន្ទាប់។';

  @override
  String get action_cancel => 'បោះបង់';

  @override
  String get action_close => 'បិទ';

  @override
  String get action_copy => 'ចម្លង';

  @override
  String get action_renew => 'បន្តសុពលភាព';

  @override
  String get action_signOut => 'ចេញពីគណនី';

  @override
  String get notice_close => 'បិទសារ';

  @override
  String get notice_sessionExpired_title => 'វគ្គបានផុតកំណត់';

  @override
  String get notice_sessionExpired_message =>
      'វគ្គរបស់អ្នកបានផុតកំណត់។ សូមចូលគណនីម្តងទៀត។';

  @override
  String get notice_connectionFailed_title => 'ការតភ្ជាប់បរាជ័យ';

  @override
  String get notice_invalidCredentials_message =>
      'អាសយដ្ឋានអ៊ីមែល ឬពាក្យសម្ងាត់មិនត្រឹមត្រូវ។';

  @override
  String get notice_emailVerification_title => 'ត្រូវបញ្ជាក់អាសយដ្ឋានអ៊ីមែល';

  @override
  String get notice_emailVerification_message =>
      'សូមបញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នក មុនពេលបន្ថែមឧបករណ៍ VPN។';

  @override
  String get notice_rateLimited_title => 'ការព្យាយាមច្រើនដងពេក';

  @override
  String get notice_deviceLimit_title => 'ឈានដល់ដែនកំណត់ឧបករណ៍ហើយ';

  @override
  String get notice_deviceLimit_message =>
      'សូមដកឧបករណ៍ដែលមានស្រាប់ចេញ មុនពេលបន្ថែមឧបករណ៍មួយទៀត។';

  @override
  String get notice_identityRenewal_title => 'ត្រូវបង្កើតអត្តសញ្ញាណ VPN ថ្មី';

  @override
  String get notice_identityRenewal_message =>
      'អត្តសញ្ញាណនេះត្រូវបានដកចេញ។ សូមបង្កើតអត្តសញ្ញាណថ្មីនៅលើឧបករណ៍។';

  @override
  String get notice_migrationPending_title => 'កំពុងប្តូរទីតាំង';

  @override
  String get notice_migrationPending_message =>
      'ការប្តូរទីតាំងកំពុងដំណើរការរួចហើយ។';

  @override
  String get notice_migrationBlocked_title => 'ការប្តូរទីតាំងត្រូវបានទប់ស្កាត់';

  @override
  String get notice_migrationBlocked_message =>
      'ការប្តូរទីតាំងត្រូវការអន្តរាគមន៍ពីផ្នែកម៉ាស៊ីនមេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ ឬទាក់ទងផ្នែកជំនួយ។';

  @override
  String get notice_targetUnavailable_title =>
      'ម៉ាស៊ីនមេមិនអាចប្រើបានជាបណ្តោះអាសន្ន';

  @override
  String get notice_targetUnavailable_message =>
      'ម៉ាស៊ីនមេនេះមិនអាចប្រើបានជាបណ្តោះអាសន្នទេ។';

  @override
  String get notice_networkUnavailable_title => 'គ្មានការតភ្ជាប់អ៊ីនធឺណិត';

  @override
  String get notice_networkUnavailable_message =>
      'សូមពិនិត្យការតភ្ជាប់របស់អ្នក ហើយព្យាយាមម្តងទៀត។';

  @override
  String get notice_permissionDenied_title => 'ការអនុញ្ញាត VPN ត្រូវបានបដិសេធ';

  @override
  String get notice_permissionDenied_message =>
      'សូមចាប់ផ្តើមការតភ្ជាប់ឡើងវិញ ហើយទទួលយកសំណើអនុញ្ញាត Android។';

  @override
  String get notice_wireguardTimeout_title => 'ម៉ាស៊ីនមេមិនឆ្លើយតប';

  @override
  String get notice_wireguardTimeout_message =>
      'ការតភ្ជាប់ WireGuard ចំណាយពេលយូរពេក។ សូមព្យាយាមម្តងទៀត ឬជ្រើសរើសទីតាំងផ្សេង។';

  @override
  String get notice_tlsFailed_title => 'ការតភ្ជាប់សុវត្ថិភាពត្រូវបានបដិសេធ';

  @override
  String get notice_tlsFailed_message =>
      'ម៉ាស៊ីនមេមិនបានទទួលយកការតភ្ជាប់ OpenVPN ទេ។ សូមព្យាយាមម្តងទៀត។ បើបញ្ហានៅតែបន្ត សូមធ្វើរោគវិនិច្ឆ័យ។';

  @override
  String get notice_tunRejected_title => 'Android បានបដិសេធចំណុចប្រទាក់ VPN';

  @override
  String get notice_tunRejected_message =>
      'Android បានបដិសេធការកំណត់បណ្តាញដែល OpenVPN បានស្នើសុំ។';

  @override
  String get notice_openvpnStart_title => 'OpenVPN មិនអាចចាប់ផ្តើមបានទេ';

  @override
  String get notice_openvpnStart_message =>
      'ម៉ាស៊ីន OpenVPN មិនអាចចាប់ផ្តើមបានពេញលេញទេ។ សូមព្យាយាមម្តងទៀត។ បើបញ្ហានៅតែកើតមាន សូមទាក់ទងផ្នែកជំនួយ។';

  @override
  String notice_diagnosticCode(Object code) {
    return 'លេខកូដរោគវិនិច្ឆ័យ៖ $code';
  }

  @override
  String get notice_generic_title => 'ការតភ្ជាប់ VPN បរាជ័យ';

  @override
  String get notice_generic_message =>
      'មានកំហុសមួយកើតឡើង។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'បានបង្កើតគណនី',
      'password_reset_sent': 'បានទទួលសំណើកំណត់ពាក្យសម្ងាត់ឡើងវិញ',
      'verification_email_sent': 'បានផ្ញើអ៊ីមែលផ្ទៀងផ្ទាត់',
      'location_migration_pending': 'កំពុងប្តូរទីតាំង',
      'vpn_sign_in_required': 'ត្រូវចូលគណនី',
      'protocol_unavailable_at_location': 'ប្រូតូកូលមិនអាចប្រើបាន',
      'vpn_permission_denied': 'ការអនុញ្ញាត VPN ត្រូវបានបដិសេធ',
      'revoked_identity_device_limit': 'ឈានដល់ដែនកំណត់ឧបករណ៍ហើយ',
      'tunnel_start_unexpected': 'VPN មិនអាចចាប់ផ្តើមបានទេ',
      'flutter_disconnect_timeout': 'មិនទាន់បានបញ្ជាក់ការផ្តាច់ទេ',
      'flutter_disconnect_unexpected': 'មិនអាចផ្តាច់បានទេ',
      'device_revoked': 'ឧបករណ៍ត្រូវបានដកចេញ',
      'revoke_unexpected': 'មិនអាចដកឧបករណ៍ចេញបានទេ',
      'identity_renewal_unexpected': 'មិនអាចបង្កើតអត្តសញ្ញាណថ្មីបានទេ',
      'openvpn_renewal_unexpected': 'មិនអាចបន្តសុពលភាព OpenVPN បានទេ',
      'location_migration_blocked': 'ការប្តូរទីតាំងត្រូវបានទប់ស្កាត់',
      'location_migration_slow': 'ការប្តូរទីតាំងនៅតែកំពុងដំណើរការ',
      'location_migration_conflict': 'ការប្តូរទីតាំងត្រូវធ្វើបច្ចុប្បន្នភាព',
      'location_migration_verification_failed':
          'មិនទាន់បានបញ្ជាក់ការប្តូរទីតាំងទេ',
      'location_migration_device_changed':
          'ឧបករណ៍បានផ្លាស់ប្តូរអំឡុងពេលប្តូរទីតាំង',
      'tunnel_stop_failed': 'មិនអាចប្តូរទីតាំងបានទេ',
      'device_clock_ahead': 'នាឡិកាឧបករណ៍លឿនពេក',
      'other': 'ប្រតិបត្តិការបរាជ័យ',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'បានបង្កើតគណនីហើយ ប៉ុន្តែមិនអាចផ្ញើអ៊ីមែលផ្ទៀងផ្ទាត់បានទេ។ សូមប្រើ ផ្ញើឡើងវិញ នៅក្នុងកម្មវិធី។',
      'password_reset_sent':
          'សំណើរបស់អ្នកត្រូវបានទទួលហើយ។ ប្រសិនបើមានគណនីដែលត្រូវនឹងអាសយដ្ឋាននេះ អ្នកអាចនឹងទទួលបានអ៊ីមែល។ សូមពិនិត្យថតសារឥតបានការផងដែរ។',
      'verification_email_sent': 'អ៊ីមែលផ្ទៀងផ្ទាត់ថ្មីទើបតែត្រូវបានផ្ញើ។',
      'location_migration_pending':
          'ការប្តូរទៅ $target កំពុងត្រូវបានរៀបចំនៅឡើយ។ អ្នកអាចបន្តវាបានដោយមិនចាំបាច់បង្កើតឧបករណ៍ឡើងវិញ។',
      'vpn_sign_in_required': 'សូមចូលគណនីរបស់អ្នកមុនពេលចាប់ផ្តើម VPN។',
      'protocol_unavailable_at_location':
          'ប្រូតូកូលដែលបានជ្រើសរើសមិនមានសម្រាប់ទីតាំងនេះទេ។ សូមធ្វើបច្ចុប្បន្នភាពទីតាំង ឬជ្រើសរើសប្រូតូកូលផ្សេង។',
      'vpn_permission_denied':
          'Android បានបដិសេធការអនុញ្ញាត VPN។ សូមចាប់ផ្តើមការតភ្ជាប់ឡើងវិញ ហើយទទួលយកសំណើប្រព័ន្ធ។',
      'revoked_identity_device_limit':
          'ការចូលប្រើ VPN របស់ឧបករណ៍នេះត្រូវបានដកចេញ ហើយចំនួនឧបករណ៍បានដល់ដែនកំណត់។ សូមដកឧបករណ៍មួយចេញនៅក្នុង គណនី → គ្រប់គ្រងឧបករណ៍របស់ខ្ញុំ។',
      'tunnel_start_unexpected':
          'កំហុសដែលមិនបានរំពឹងទុកបានរំខានការរៀបចំផ្លូវតុនែល។ សូមពិនិត្យលេខកូដរោគវិនិច្ឆ័យ ហើយព្យាយាមម្តងទៀត។',
      'flutter_disconnect_timeout':
          'Android មិនបានបញ្ជាក់ទាន់ពេលថា VPN បានបញ្ឈប់ទេ។ សូមព្យាយាមបញ្ឈប់ម្តងទៀត។',
      'flutter_disconnect_unexpected':
          'កំហុសដែលមិនបានរំពឹងទុកបានរារាំងការបញ្ជាក់ថាផ្លូវតុនែលត្រូវបានបញ្ឈប់។',
      'device_revoked':
          'ការចូលប្រើ VPN របស់ឧបករណ៍ត្រូវបានដកហូត ហើយព័ត៌មានសម្ងាត់ក្នុងឧបករណ៍ត្រូវបានលុបចេញ។',
      'revoke_unexpected':
          'មិនអាចដកឧបករណ៍ចេញបានទេ។ សូមធ្វើបច្ចុប្បន្នភាពបញ្ជី ហើយព្យាយាមម្តងទៀត។',
      'identity_renewal_unexpected':
          'មិនអាចបង្កើតអត្តសញ្ញាណ VPN ថ្មីបានទេ។ សូមធ្វើបច្ចុប្បន្នភាពឧបករណ៍ ហើយព្យាយាមម្តងទៀត។',
      'openvpn_renewal_unexpected':
          'មិនអាចបន្តសុពលភាពប្រវត្តិរូប OpenVPN បានទេ។ សូមព្យាយាមម្តងទៀត ឬពិនិត្យលេខកូដរោគវិនិច្ឆ័យ។',
      'location_migration_blocked':
          'ម៉ាស៊ីនមេមិនអាចបញ្ចប់ការប្តូរនេះបាននៅពេលនេះទេ។ ឧបករណ៍ និងអត្តសញ្ញាណក្នុងឧបករណ៍របស់វាត្រូវបានរក្សាទុក។',
      'location_migration_slow':
          'ម៉ាស៊ីនមេនៅតែកំពុងរៀបចំការប្តូរទៅ $target។ សូមប្រើ បន្តការប្តូរទីតាំង ក្នុងពេលបន្តិចទៀត។',
      'location_migration_conflict':
          'ស្ថានភាពឧបករណ៍បានផ្លាស់ប្តូរនៅលើម៉ាស៊ីនមេ។ សូមធ្វើបច្ចុប្បន្នភាពឧបករណ៍ បន្ទាប់មកបន្តការប្តូរ។',
      'location_migration_verification_failed':
          'ម៉ាស៊ីនមេមិនបានបញ្ជាក់ទីតាំងថ្មីទេ។ អត្តសញ្ញាណក្នុងឧបករណ៍ពីមុនត្រូវបានរក្សាទុក។',
      'location_migration_device_changed':
          'ឧបករណ៍ដែលម៉ាស៊ីនមេបានផ្តល់មកមិនត្រូវនឹងឧបករណ៍ដែលកំពុងត្រូវបានប្តូរទៀតទេ។ សូមធ្វើបច្ចុប្បន្នភាពឧបករណ៍មុនពេលព្យាយាមម្តងទៀត។',
      'tunnel_stop_failed':
          'ផ្លូវតុនែលមុនត្រូវតែបញ្ឈប់ឱ្យបានពេញលេញ មុនពេលភ្ជាប់ថ្មី។',
      'device_clock_ahead':
          'នាឡិកាឧបករណ៍នេះហាក់ដូចជាលឿនជាងការពិត។ សូមបើកកាលបរិច្ឆេទ និងពេលវេលាស្វ័យប្រវត្តិ ដើម្បីនៅតែចូលគណនី។',
      'other':
          'មិនអាចបញ្ចប់ប្រតិបត្តិការបានទេ។ សូមព្យាយាមម្តងទៀត ឬផ្ញើលេខកូដរោគវិនិច្ឆ័យទៅផ្នែកជំនួយ។',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'វគ្គបានផុតកំណត់',
      'invalid_credentials': 'ការចូលគណនីបានបរាជ័យ',
      'email_verification_required': 'ត្រូវបញ្ជាក់អាសយដ្ឋានអ៊ីមែល',
      'verification_email_cooldown': 'បានផ្ញើអ៊ីមែលរួចហើយ',
      'rate_limited': 'ការព្យាយាមច្រើនដងពេក',
      'invalid_registration': 'ត្រូវកែតម្រូវព័ត៌មាន',
      'email_exists': 'គណនីមានរួចហើយ',
      'invalid_profile': 'ប្រវត្តិរូបមិនត្រឹមត្រូវ',
      'invalid_device': 'ឧបករណ៍មិនត្រឹមត្រូវ',
      'invalid_location': 'ទីតាំងមិនអាចប្រើបាន',
      'device_limit': 'ឈានដល់ដែនកំណត់ឧបករណ៍ហើយ',
      'device_exists': 'អត្តសញ្ញាណ VPN កំពុងប្រើរួចហើយ',
      'device_identity_revoked': 'ត្រូវបង្កើតអត្តសញ្ញាណ VPN ថ្មី',
      'device_location_locked': 'ត្រូវធ្វើបច្ចុប្បន្នភាពការប្តូរទីតាំង',
      'location_migration_pending': 'កំពុងប្តូរទីតាំង',
      'location_migration_blocked': 'ការប្តូរទីតាំងត្រូវបានទប់ស្កាត់',
      'target_ca_mismatch': 'ម៉ាស៊ីនមេ OpenVPN មិនត្រូវគ្នា',
      'location_migration_conflict': 'ត្រូវធ្វើបច្ចុប្បន្នភាពការប្តូរទីតាំង',
      'server_full': 'ម៉ាស៊ីនមេពេញហើយ',
      'capacity_unavailable': 'ទីតាំងមិនអាចប្រើបានជាបណ្តោះអាសន្ន',
      'target_unavailable': 'ម៉ាស៊ីនមេមិនអាចប្រើបានជាបណ្តោះអាសន្ន',
      'not_found': 'រកមិនឃើញធាតុ',
      'invalid_openvpn_csr': 'អត្តសញ្ញាណ OpenVPN មិនត្រឹមត្រូវ',
      'openvpn_profile_exists': 'មានប្រវត្តិរូប OpenVPN រួចហើយ',
      'openvpn_profile_revoked': 'ប្រវត្តិរូប OpenVPN ត្រូវបានលុបចោល',
      'openvpn_operation_pending': 'ប្រតិបត្តិការ OpenVPN កំពុងដំណើរការ',
      'openvpn_operation_terminal': 'ប្រតិបត្តិការ OpenVPN ត្រូវបានរំខាន',
      'openvpn_address_unavailable': 'អាសយដ្ឋាន OpenVPN មិនអាចប្រើបាន',
      'openvpn_profile_conflict': 'ជម្លោះ OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN មិនអាចប្រើបាន',
      'email_delivery_unavailable': 'សេវាអ៊ីមែលមិនអាចប្រើបាន',
      'invalid_token': 'តំណមិនត្រឹមត្រូវ',
      'network_unavailable': 'គ្មានការតភ្ជាប់អ៊ីនធឺណិត',
      'invalid_json': 'សំណើមិនត្រឹមត្រូវ',
      'invalid_api_response': 'ការឆ្លើយតបពីម៉ាស៊ីនមេមិនត្រឹមត្រូវ',
      'ipv6_unavailable': 'IPv6 មិនអាចប្រើបាន',
      'invalid_ip_families': 'ការកំណត់បណ្តាញត្រូវបានបដិសេធ',
      'other': 'សេវាមិនអាចប្រើបាន',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'វគ្គរបស់អ្នកបានផុតកំណត់។ សូមចូលគណនីម្តងទៀត។',
      'invalid_credentials': 'អាសយដ្ឋានអ៊ីមែល ឬពាក្យសម្ងាត់មិនត្រឹមត្រូវ។',
      'email_verification_required':
          'សូមបញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នក មុនពេលបន្ថែមឧបករណ៍ VPN។',
      'invalid_registration': 'សូមពិនិត្យព័ត៌មាន និងការយល់ព្រមដែលបានស្នើ។',
      'email_exists': 'មានគណនីមួយកំពុងប្រើអាសយដ្ឋានអ៊ីមែលនេះរួចហើយ។',
      'invalid_profile': 'សូមពិនិត្យព័ត៌មានប្រវត្តិរូបរបស់អ្នក។',
      'invalid_device': 'ឈ្មោះ ឬអត្តសញ្ញាណក្នុងឧបករណ៍នេះមិនត្រឹមត្រូវ។',
      'invalid_location': 'សូមធ្វើបច្ចុប្បន្នភាពបញ្ជីទីតាំង ហើយព្យាយាមម្តងទៀត។',
      'device_limit': 'សូមដកឧបករណ៍ដែលមានស្រាប់ចេញ មុនពេលបន្ថែមឧបករណ៍មួយទៀត។',
      'device_exists': 'អត្តសញ្ញាណ VPN នេះត្រូវបានភ្ជាប់ទៅគណនីផ្សេងរួចហើយ។',
      'device_identity_revoked':
          'អត្តសញ្ញាណនេះត្រូវបានដកចេញ។ ត្រូវបង្កើតអត្តសញ្ញាណក្នុងឧបករណ៍ថ្មី។',
      'device_location_locked':
          'ទីតាំងរបស់ឧបករណ៍នេះទើបតែបានផ្លាស់ប្តូរ។ កម្មវិធីនឹងបន្តការប្តូរដែលកំពុងដំណើរការ។',
      'location_migration_pending': 'ការប្តូរទីតាំងកំពុងដំណើរការរួចហើយ។',
      'location_migration_blocked':
          'ការប្តូរទីតាំងត្រូវការអន្តរាគមន៍ពីផ្នែកម៉ាស៊ីនមេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ ឬទាក់ទងផ្នែកជំនួយ។',
      'target_ca_mismatch':
          'ម៉ាស៊ីនមេនេះមិនទាន់ត្រូវគ្នានឹងប្រវត្តិរូប OpenVPN បច្ចុប្បន្នទេ។',
      'location_migration_conflict':
          'សូមធ្វើបច្ចុប្បន្នភាពឧបករណ៍ រួចព្យាយាមប្តូរទីតាំងម្តងទៀត។',
      'server_full':
          'ទីតាំងនេះបានដល់ដែនកំណត់នៃការតភ្ជាប់ហើយ។ សូមជ្រើសរើសទីតាំងផ្សេង ឬព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
      'capacity_unavailable':
          'យើងមិនអាចបញ្ជាក់បានថាទីតាំងនេះអាចប្រើបានឬទេនៅពេលនេះ។ សូមជ្រើសរើសទីតាំងផ្សេង ឬព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
      'target_unavailable': 'ម៉ាស៊ីនមេនេះមិនអាចប្រើបានជាបណ្តោះអាសន្នទេ។',
      'not_found': 'ធាតុនេះមិនអាចប្រើបានក្នុងគណនីរបស់អ្នកទៀតទេ។',
      'invalid_openvpn_csr':
          'សូមបង្កើតអត្តសញ្ញាណ OpenVPN ថ្មី ហើយព្យាយាមម្តងទៀត។',
      'openvpn_profile_exists':
          'មានប្រវត្តិរូប OpenVPN សម្រាប់ឧបករណ៍នេះរួចហើយ។',
      'openvpn_profile_revoked':
          'សូមបង្កើតប្រវត្តិរូប OpenVPN ឡើងវិញ ដើម្បីបន្ត។',
      'openvpn_operation_pending':
          'ការផ្លាស់ប្តូរកំពុងត្រូវបានអនុវត្តនៅឡើយ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
      'openvpn_operation_terminal':
          'សូមបង្កើតអត្តសញ្ញាណ OpenVPN ថ្មី ហើយព្យាយាមម្តងទៀត។',
      'openvpn_address_unavailable':
          'មិនមានអាសយដ្ឋាន OpenVPN ដែលអាចប្រើបានក្នុងពេលនេះទេ។',
      'openvpn_profile_conflict':
          'ប្រវត្តិរូបបានផ្លាស់ប្តូរ។ សូមធ្វើបច្ចុប្បន្នភាពឧបករណ៍ ហើយព្យាយាមម្តងទៀត។',
      'openvpn_signer_unavailable':
          'សេវា OpenVPN មិនអាចប្រើបានជាបណ្តោះអាសន្នទេ។',
      'email_delivery_unavailable':
          'មិនអាចផ្ញើអ៊ីមែលបានទេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
      'invalid_token': 'តំណនេះមិនត្រឹមត្រូវ ឬបានផុតកំណត់។ សូមស្នើសុំតំណថ្មី។',
      'network_unavailable':
          'សូមពិនិត្យការតភ្ជាប់អ៊ីនធឺណិតរបស់អ្នក ហើយព្យាយាមម្តងទៀត។',
      'invalid_json': 'សូមពិនិត្យព័ត៌មានដែលបានបញ្ចូល ហើយព្យាយាមម្តងទៀត។',
      'invalid_api_response':
          'ម៉ាស៊ីនមេបានបញ្ជូនការឆ្លើយតបដែលមិនបានរំពឹងទុក។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
      'ipv6_unavailable':
          'ម៉ាស៊ីនមេមិនអាចបើក IPv6 បានក្នុងពេលនេះទេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
      'invalid_ip_families':
          'ការកំណត់ផ្លូវតុនែលមិនពេញលេញ ឬមិនត្រូវនឹងអាសយដ្ឋានដែលបានអនុញ្ញាតទេ។ សូមព្យាយាមម្តងទៀតពីកម្មវិធី។',
      'other': 'មានកំហុសម៉ាស៊ីនមេកើតឡើង។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'សូមព្យាយាមម្តងទៀតក្នុងពេលបន្តិចទៀត។';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'សូមព្យាយាមម្តងទៀតបន្ទាប់ពី $seconds វិនាទី។',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'សូមព្យាយាមម្តងទៀតបន្ទាប់ពី $minutes នាទី។',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'សូមព្យាយាមម្តងទៀតបន្ទាប់ពី $hours ម៉ោង។',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'ការបន្ត VPN របស់ប្រព័ន្ធមិនអាចប្រើបាន',
      'system_vpn_resume_corrupt': 'ការបន្ត VPN របស់ប្រព័ន្ធមិនត្រឹមត្រូវ',
      'system_vpn_resume_session_invalid': 'វគ្គបន្ត VPN មិនត្រឹមត្រូវ',
      'system_vpn_resume_identity_changed': 'អត្តសញ្ញាណ VPN បានផ្លាស់ប្តូរ',
      'system_vpn_resume_identity_invalid':
          'អត្តសញ្ញាណសម្រាប់បន្ត VPN មិនត្រឹមត្រូវ',
      'system_vpn_resume_storage_failed': 'ទីផ្ទុកការបន្ត VPN មិនអាចប្រើបាន',
      'system_vpn_resume_network_timeout': 'ការបន្ត VPN គ្មានបណ្តាញ',
      'system_vpn_resume_blocked': 'ការបន្ត VPN ត្រូវបានទប់ស្កាត់',
      'system_vpn_resume_failed': 'ការបន្ត VPN បានបរាជ័យ',
      'system_vpn_resume_error_invalid': 'កំហុសការបន្ត VPN មិនត្រឹមត្រូវ',
      'wireguard_identity_store_failed': 'មិនបានរក្សាទុកអត្តសញ្ញាណ WireGuard',
      'wireguard_identity_unavailable': 'អត្តសញ្ញាណ WireGuard មិនអាចប្រើបាន',
      'vpn_host_destroyed': 'សមាសធាតុ VPN របស់ Android បានឈប់',
      'vpn_host_unavailable': 'សមាសធាតុ VPN របស់ Android មិនអាចប្រើបាន',
      'vpn_permission_required': 'តម្រូវឱ្យមានការអនុញ្ញាត VPN',
      'vpn_permission_denied': 'ការអនុញ្ញាត VPN ត្រូវបានបដិសេធ',
      'vpn_permission_request_failed': 'មិនអាចស្នើសុំការអនុញ្ញាតបានទេ',
      'wireguard_foreground_service_unavailable':
          'សេវា WireGuard មិនអាចប្រើបាន',
      'wireguard_identity_invalid': 'កូនសោ WireGuard ក្នុងឧបករណ៍មិនត្រឹមត្រូវ',
      'wireguard_identity_in_use': 'អត្តសញ្ញាណ WireGuard កំពុងប្រើរួចហើយ',
      'wireguard_configuration_invalid': 'ការកំណត់ WireGuard មិនត្រឹមត្រូវ',
      'wireguard_operation_pending': 'ប្រតិបត្តិការ WireGuard នៅតែដំណើរការ',
      'wireguard_start_failed': 'ការចាប់ផ្តើម WireGuard ត្រូវបានបដិសេធ',
      'wireguard_stop_timeout': 'មិនបានបញ្ជាក់ការបញ្ឈប់ WireGuard',
      'wireguard_handshake_timeout': 'WireGuard មិនឆ្លើយតប',
      'openvpn_connection_timeout': 'OpenVPN មិនឆ្លើយតប',
      'openvpn_core_unavailable': 'ម៉ាស៊ីន OpenVPN មិនអាចប្រើបាន',
      'openvpn_operation_pending': 'វគ្គ OpenVPN នៅតែដំណើរការ',
      'openvpn_stop_timeout': 'មិនបានបញ្ជាក់ការបញ្ឈប់ OpenVPN',
      'openvpn_profile_unavailable': 'ប្រវត្តិរូប OpenVPN ក្នុងឧបករណ៍បាត់',
      'openvpn_native_failed': 'ការហៅ OpenVPN ត្រូវបានរំខាន',
      'openvpn_key_generation_failed': 'មិនអាចបង្កើតកូនសោ OpenVPN P-256 បាន',
      'openvpn_csr_generation_failed': 'មិនអាចបង្កើត CSR របស់ OpenVPN បាន',
      'openvpn_identity_store_failed': 'មិនបានរក្សាទុកអត្តសញ្ញាណ OpenVPN',
      'openvpn_identity_clear_failed': 'ការដកអត្តសញ្ញាណ OpenVPN មិនពេញលេញ',
      'openvpn_identity_in_use': 'អត្តសញ្ញាណ OpenVPN កំពុងប្រើនៅឡើយ',
      'openvpn_tls_verification_required':
          'ខ្វះការផ្ទៀងផ្ទាត់ TLS របស់ OpenVPN',
      'openvpn_cipher_invalid': 'ក្បួនអ៊ិនគ្រីប OpenVPN មិនត្រឹមត្រូវ',
      'openvpn_profile_rejected': 'ប្រវត្តិរូប OpenVPN ត្រូវបានបដិសេធ',
      'openvpn_identity_inconsistent': 'អត្តសញ្ញាណ OpenVPN មិនស៊ីគ្នា',
      'tls_handshake_failed': 'ការចរចា OpenVPN ត្រូវបានបដិសេធ',
      'tls_alert_unknown_ca':
          'វិញ្ញាបនបត្រអតិថិជន OpenVPN មិនត្រូវបានទទួលស្គាល់',
      'tls_alert_bad_certificate': 'វិញ្ញាបនបត្រអតិថិជន OpenVPN ត្រូវបានបដិសេធ',
      'tls_alert_unsupported_certificate':
          'វិញ្ញាបនបត្រ OpenVPN មិនត្រូវបានគាំទ្រ',
      'tls_client_certificate_required':
          'តម្រូវឱ្យមានវិញ្ញាបនបត្រអតិថិជន OpenVPN',
      'tls_alert_misc': 'ការជូនដំណឹង TLS របស់ OpenVPN',
      'tls_signature_algorithm_rejected': 'ហត្ថលេខា OpenVPN មិនត្រូវបានគាំទ្រ',
      'tls_handshake_rejected': 'ការចរចា TLS របស់ OpenVPN ត្រូវបានបដិសេធ',
      'tls_version_rejected': 'កំណែ TLS របស់ OpenVPN មិនឆបគ្នា',
      'tls_certificate_expired': 'វិញ្ញាបនបត្រ TLS បានផុតកំណត់',
      'tls_certificate_revoked': 'វិញ្ញាបនបត្រ TLS ត្រូវបានដកហូត',
      'transport_failed': 'ម៉ាស៊ីនមេ OpenVPN មិនអាចទាក់ទងបាន',
      'tun_configuration_rejected': 'មិនអាចបង្កើតចំណុចប្រទាក់ OpenVPN បាន',
      'tun_setup_failed': 'ការរៀបចំ TUN របស់ OpenVPN បានបរាជ័យ',
      'tun_interface_create_failed': 'ការបង្កើតចំណុចប្រទាក់ OpenVPN បានបរាជ័យ',
      'tun_interface_disabled': 'ចំណុចប្រទាក់ OpenVPN ត្រូវបានបិទ',
      'tun_halted': 'ចំណុចប្រទាក់ OpenVPN ត្រូវបានរំខាន',
      'tun_already_established': 'ចំណុចប្រទាក់ OpenVPN បានបើករួចហើយ',
      'tun_addresses_missing': 'អាសយដ្ឋាន OpenVPN បាត់',
      'tun_routes_missing': 'ផ្លូវ OpenVPN បាត់',
      'tun_dns_missing': 'DNS របស់ OpenVPN បាត់',
      'tun_permission_revoked': 'ការអនុញ្ញាត VPN ត្រូវបានដកហូត',
      'tun_establish_returned_null': 'Android បានបដិសេធចំណុចប្រទាក់ VPN',
      'openvpn_service_start_failed': 'សេវា OpenVPN មិនអាចប្រើបាន',
      'openvpn_operation_timeout': 'ការហៅ OpenVPN អស់ពេល',
      'openvpn_start_failed': 'ការចាប់ផ្តើម OpenVPN ត្រូវបានបដិសេធ',
      'openvpn_connection_failed': 'ការតភ្ជាប់ OpenVPN ត្រូវបានរំខាន',
      'openvpn_core_status_error': 'ស្នូល OpenVPN បានបញ្ចប់ដោយកំហុស',
      'openvpn_stopped_before_connected': 'OpenVPN បានឈប់មុនពេលភ្ជាប់',
      'openvpn_auth_failed': 'ការផ្ទៀងផ្ទាត់ OpenVPN ត្រូវបានបដិសេធ',
      'openvpn_client_setup_failed': 'ការរៀបចំអតិថិជន OpenVPN បានបរាជ័យ',
      'openvpn_client_halted': 'អតិថិជន OpenVPN ត្រូវបានរំខាន',
      'openvpn_client_restart': 'បានស្នើសុំចាប់ផ្តើម OpenVPN ឡើងវិញ',
      'openvpn_inactive_timeout': 'OpenVPN អសកម្មយូរពេក',
      'openvpn_session_expired': 'វគ្គ OpenVPN បានផុតកំណត់',
      'openvpn_credentials_required':
          'ការផ្ទៀងផ្ទាត់ OpenVPN មិនត្រូវបានគាំទ្រ',
      'openvpn_proxy_failed': 'ការបញ្ជូនតាមកណ្តាល OpenVPN បានបរាជ័យ',
      'openvpn_compression_failed': 'ការបង្ហាប់ OpenVPN ត្រូវបានបដិសេធ',
      'openvpn_ntlm_crypto_unavailable':
          'ការអ៊ិនគ្រីប NTLM របស់ OpenVPN មិនអាចប្រើបាន',
      'openvpn_feature_unsupported': 'មុខងារ OpenVPN មិនត្រូវបានគាំទ្រ',
      'network_unavailable': 'គ្មានការតភ្ជាប់អ៊ីនធឺណិត',
      'network_lost': 'បណ្តាញមិនអាចប្រើបាន',
      'certificate_validation_failed': 'វិញ្ញាបនបត្រម៉ាស៊ីនមេត្រូវបានបដិសេធ',
      'openvpn_certificate_expired': 'វិញ្ញាបនបត្រ OpenVPN បានផុតកំណត់',
      'tunnel_active_for_another_account': 'ផ្លូវតុនែលរបស់គណនីផ្សេងនៅតែសកម្ម',
      'tunnel_already_active': 'ផ្លូវតុនែលដើមកំពុងសកម្មរួចហើយ',
      'tunnel_stop_timeout': 'ការបញ្ឈប់ $protocol មិនបានបញ្ជាក់',
      'tunnel_disconnected': '$protocol ត្រូវបានរំខាន',
      'native_bridge_unavailable': 'ស្ពាន Android មិនអាចប្រើបាន',
      'native_operation_failed': 'ប្រតិបត្តិការ Android ត្រូវបានរំខាន',
      'invalid_arguments': 'ប៉ារ៉ាម៉ែត្រ VPN មិនពេញលេញ',
      'invalid_account_id': 'គណនី VPN មិនត្រឹមត្រូវ',
      'invalid_device_id': 'លេខសម្គាល់ឧបករណ៍មិនត្រឹមត្រូវ',
      'storage_key_not_allowed': 'កូនសោផ្ទុកត្រូវបានបដិសេធ',
      'secure_storage_read_failed': 'ការអានទិន្នន័យសុវត្ថិភាពបានបរាជ័យ',
      'secure_storage_write_failed': 'ការសរសេរទិន្នន័យសុវត្ថិភាពបានបរាជ័យ',
      'key_generation_failed': 'មិនអាចបង្កើតកូនសោ WireGuard បាន',
      'csr_generation_failed': 'មិនអាចបង្កើត CSR របស់ OpenVPN បាន',
      'openvpn_recovery_exhausted': 'ការស្តារ OpenVPN ត្រូវបានប្រើរួចហើយ',
      'openvpn_recovery_failed': 'ការស្តារ OpenVPN បានបរាជ័យ',
      'openvpn_renewal_required': 'តម្រូវឱ្យបន្តសុពលភាពវិញ្ញាបនបត្រ OpenVPN',
      'other': 'កំហុស VPN ដើមដែលមិនបានចាត់ថ្នាក់',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android រកមិនឃើញវគ្គ VPN ដែលអាចបន្តបានទេ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មីនៅក្នុងកម្មវិធី។',
      'system_vpn_resume_corrupt':
          'ទិន្នន័យបន្ត VPN ដែលបានរក្សាទុកមិនត្រឹមត្រូវ ហើយនឹងមិនត្រូវបានប្រើទេ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'system_vpn_resume_session_invalid':
          'វគ្គដែលបានរក្សាទុកមិនអាចបន្ត VPN បានទៀតទេ។ សូមចូលគណនីម្តងទៀតនៅក្នុងកម្មវិធី។',
      'system_vpn_resume_identity_changed':
          'អត្តសញ្ញាណ VPN ក្នុងឧបករណ៍បានផ្លាស់ប្តូរ។ ការបន្តត្រូវបានបញ្ឈប់។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'system_vpn_resume_identity_invalid':
          'អត្តសញ្ញាណសម្រាប់បន្តមិនត្រឹមត្រូវ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'system_vpn_resume_storage_failed':
          'Android មិនអាចអាន ឬធ្វើបច្ចុប្បន្នភាពទិន្នន័យបន្តដែលបានអ៊ិនគ្រីបបានទេ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'system_vpn_resume_network_timeout':
          'Android មិនបានរកឃើញបណ្តាញទាន់ពេលដើម្បីបន្ត VPN ឡើយ។ សូមព្យាយាមម្តងទៀតនៅពេលមានបណ្តាញ។',
      'system_vpn_resume_blocked':
          'ការបន្ត VPN ត្រូវបានទប់ស្កាត់។ សូមពិនិត្យការកំណត់ Android រួចចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'system_vpn_resume_failed':
          'ការបន្ត VPN របស់ Android បានបរាជ័យ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មីនៅក្នុងកម្មវិធី។',
      'system_vpn_resume_error_invalid':
          'Android បានផ្ញើកំហុសការបន្តដែលមិនអាចប្រើបាន។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'wireguard_identity_store_failed':
          'Android មិនអាចរក្សាទុកអត្តសញ្ញាណ WireGuard ដែលបានអ៊ិនគ្រីបរបស់គណនីនេះបានទេ។',
      'wireguard_identity_unavailable':
          'គ្មានអត្តសញ្ញាណ WireGuard ដែលអាចប្រើបានសម្រាប់ការតភ្ជាប់នេះទេ។',
      'vpn_host_destroyed':
          'សមាសធាតុ Android ដែលដំណើរការ VPN ត្រូវបានបញ្ឈប់។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មី។',
      'vpn_host_unavailable':
          'Android មិនអាចបង្កើតសមាសធាតុដែលដំណើរការ VPN បានទេ។ សូមព្យាយាមម្តងទៀតបន្ទាប់ពីពិនិត្យការកំណត់ VPN។',
      'openvpn_renewal_required':
          'មិនអាចបន្តសុពលភាពវិញ្ញាបនបត្រ OpenVPN ដោយស្វ័យប្រវត្តិបានទេ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មីនៅក្នុងកម្មវិធី។',
      'openvpn_recovery_failed':
          'ការស្តារស្វ័យប្រវត្តិបានបរាជ័យ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មីនៅក្នុងកម្មវិធី។',
      'openvpn_recovery_exhausted':
          'ការស្តារស្វ័យប្រវត្តិត្រូវបានប្រើរួចហើយ។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មីនៅក្នុងកម្មវិធី។',
      'vpn_permission_required':
          'Android តម្រូវឱ្យមានការអនុញ្ញាត VPN ថ្មីមុនពេលចាប់ផ្តើមផ្លូវតុនែល។',
      'vpn_permission_denied':
          'សូមអនុញ្ញាត FuzeVPN នៅក្នុងសំណើរបស់ Android ដើម្បីបន្ត។',
      'vpn_permission_request_failed':
          'Android មិនអាចបើកអេក្រង់ការអនុញ្ញាត VPN បានទេ។',
      'wireguard_foreground_service_unavailable':
          'Android មិនអាចរក្សាសេវា WireGuard ឱ្យដំណើរការនៅផ្ទៃមុខបានទេ។',
      'wireguard_identity_invalid':
          'កូនសោ WireGuard ដែលបានអ៊ិនគ្រីបរបស់គណនីនេះមិនអាចអានបាន ឬមិនត្រឹមត្រូវ។',
      'wireguard_identity_in_use':
          'មានប្រតិបត្តិការមួយទៀតកំពុងប្រើកូនសោ WireGuard របស់គណនីនេះ។',
      'wireguard_configuration_invalid':
          'អាសយដ្ឋាន WireGuard, DNS, កូនសោម៉ាស៊ីនមេ ឬផ្លូវបណ្តាញដែលបានទទួលមិនត្រឹមត្រូវ។',
      'wireguard_operation_pending':
          'ប្រតិបត្តិការ WireGuard មុនមិនទាន់បានដោះលែងសេវាដើមរបស់វានៅឡើយទេ។',
      'wireguard_start_failed':
          'ម៉ាស៊ីន WireGuard បានបដិសេធការបើកដំណើរការការកំណត់នេះ។',
      'wireguard_stop_timeout':
          'សេវា WireGuard មិនបានបញ្ជាក់ការដោះលែងចំណុចប្រទាក់ VPN ក្នុងរយៈពេលកំណត់ឡើយ។',
      'wireguard_handshake_timeout':
          'ផ្លូវតុនែលមិនបានបញ្ជាក់ការចរចាតភ្ជាប់ជាមួយម៉ាស៊ីនមេទាន់ពេលឡើយ។',
      'openvpn_connection_timeout':
          'OpenVPN មិនបានបញ្ជាក់ការតភ្ជាប់ទៅម៉ាស៊ីនមេទាន់ពេលឡើយ។',
      'openvpn_core_unavailable':
          'កំណែកម្មវិធីនេះមិនមានម៉ាស៊ីន OpenVPN ដែលអាចប្រើបានទេ។',
      'openvpn_operation_pending':
          'ម៉ាស៊ីនដើមនៅតែកាន់វគ្គ OpenVPN មុន ហើយបដិសេធមិនបង្កើតវគ្គទីពីរទេ។',
      'openvpn_stop_timeout':
          'ស្នូល OpenVPN មិនបានបញ្ជាក់ថាវគ្គដើមរបស់វាបានឈប់ និងត្រូវបានបិទទាំងស្រុងក្នុងរយៈពេលកំណត់ឡើយ។',
      'openvpn_profile_unavailable':
          'មិនអាចអានប្រវត្តិរូប OpenVPN ដែលបានផ្ទៀងផ្ទាត់សម្រាប់ការតភ្ជាប់នេះបានទេ។',
      'openvpn_native_failed':
          'កំហុសមួយក្នុងកម្មវិធីបានរំខាន OpenVPN។ សូមព្យាយាមភ្ជាប់ម្តងទៀត។ បើបញ្ហានៅតែមាន សូមធ្វើរោគវិនិច្ឆ័យ។',
      'openvpn_key_generation_failed':
          'Android Keystore មិនអាចបង្កើត ឬអានកូនសោឯកជន P-256 ដែលមិនអាចនាំចេញបានទេ។',
      'openvpn_csr_generation_failed':
          'កូនសោ Android Keystore មិនអាចចុះហត្ថលេខាលើសំណើវិញ្ញាបនបត្រ OpenVPN បានទេ។',
      'openvpn_identity_store_failed':
          'វិញ្ញាបនបត្រ ឬប្រវត្តិរូប OpenVPN មិនអាចរក្សាទុកក្នុងទីផ្ទុកដែលបានអ៊ិនគ្រីបបានទេ។',
      'openvpn_identity_clear_failed':
          'Android មិនអាចដកអត្តសញ្ញាណ OpenVPN ក្នុងឧបករណ៍សម្រាប់គណនីនេះចេញទាំងស្រុងបានទេ។',
      'openvpn_identity_in_use':
          'វគ្គ OpenVPN ដើមនៅតែប្រើកូនសោ ឬវិញ្ញាបនបត្ររបស់ឧបករណ៍នេះ។',
      'openvpn_tls_verification_required':
          'ប្រវត្តិរូបមិនបានទាមទារយ៉ាងច្បាស់ឱ្យមានការផ្ទៀងផ្ទាត់វិញ្ញាបនបត្រម៉ាស៊ីនមេទេ។',
      'openvpn_cipher_invalid':
          'ម៉ាស៊ីនមេបានផ្តល់ក្បួនអ៊ិនគ្រីបដែលមិននៅក្នុងបញ្ជីដែលបានអនុញ្ញាតទេ។',
      'openvpn_profile_rejected':
          'ប្រវត្តិរូបដែលទទួលពីម៉ាស៊ីនមេមិនឆបគ្នា។ សូមបង្កើតឧបករណ៍នេះឡើងវិញ ហើយព្យាយាមម្តងទៀត។',
      'openvpn_identity_inconsistent':
          'វិញ្ញាបនបត្រមិនត្រូវនឹងអត្តសញ្ញាណសុវត្ថិភាពរបស់ទូរស័ព្ទនេះទេ។ គ្មានប្រវត្តិរូបក្នុងឧបករណ៍ណាត្រូវបានជំនួសឡើយ។',
      'tls_handshake_failed':
          'ម៉ាស៊ីនមេបានបដិសេធការចរចា TLS។ បើបញ្ហានៅតែមាន សូមបង្កើតប្រវត្តិរូបឡើងវិញ។',
      'tls_alert_unknown_ca':
          'ម៉ាស៊ីនមេមិនទទួលស្គាល់អាជ្ញាធរនៃវិញ្ញាបនបត្ររបស់ឧបករណ៍នេះទេ។ ត្រូវពិនិត្យម៉ាស៊ីនមេ OpenVPN។',
      'tls_alert_bad_certificate':
          'ម៉ាស៊ីនមេបានបដិសេធវិញ្ញាបនបត្ររបស់ឧបករណ៍នេះ។ សូមបង្កើតឧបករណ៍ឡើងវិញមុនពេលព្យាយាមម្តងទៀត។',
      'tls_alert_unsupported_certificate':
          'ម៉ាស៊ីនមេមិនគាំទ្រប្រភេទវិញ្ញាបនបត្រសុវត្ថិភាពដែល Android ប្រើទេ។',
      'tls_client_certificate_required':
          'ម៉ាស៊ីនមេតម្រូវឱ្យមានវិញ្ញាបនបត្រអតិថិជន ប៉ុន្តែ ស្នូល OpenVPN មិនអាចផ្តល់វាបានទេ។',
      'tls_alert_misc':
          'ម៉ាស៊ីនមេបានផ្ញើការជូនដំណឹង TLS ដែលមិនស្ថិតក្នុងប្រភេទវិញ្ញាបនបត្រ ឬកំណែ។',
      'tls_signature_algorithm_rejected':
          'ម៉ាស៊ីនមេបានបដិសេធក្បួនដោះស្រាយហត្ថលេខា ECDSA P-256 របស់កូនសោ Android Keystore។',
      'tls_handshake_rejected': 'ម៉ាស៊ីនមេបានរំខានការចរចា TLS មុនពេលភ្ជាប់។',
      'tls_version_rejected':
          'អតិថិជន និងម៉ាស៊ីនមេមិនបានរកឃើញកំណែ TLS ដូចគ្នាទេ។',
      'tls_certificate_expired':
          'វិញ្ញាបនបត្រដែលបានបង្ហាញក្នុងអំឡុងពេលភ្ជាប់បានផុតកំណត់។',
      'tls_certificate_revoked':
          'វិញ្ញាបនបត្រដែលបានបង្ហាញក្នុងអំឡុងពេលភ្ជាប់ត្រូវបានដកហូតហើយ។',
      'transport_failed':
          'ម៉ាស៊ីនមេ OpenVPN មិនឆ្លើយតបនៅលើបណ្តាញបច្ចុប្បន្នទេ។ សូមព្យាយាមម្តងទៀតក្នុងពេលឆាប់ៗ។',
      'tun_configuration_rejected':
          'Android បានបដិសេធការកំណត់បណ្តាញដែល OpenVPN បានស្នើសុំ។',
      'tun_setup_failed':
          'ស្នូល OpenVPN បានបដិសេធផែនការបណ្តាញមុនពេលបង្កើតចំណុចប្រទាក់ Android។',
      'tun_interface_create_failed':
          'ស្នូល OpenVPN មិនអាចទទួលបានចំណុចប្រទាក់ TUN ពី VpnService របស់ Android បានទេ។',
      'tun_interface_disabled':
          'Android ឬស្នូល OpenVPN បានបិទចំណុចប្រទាក់ TUN ក្នុងអំឡុងពេលភ្ជាប់។',
      'tun_halted': 'ស្នូល OpenVPN បានទទួលសំណើឱ្យបញ្ឈប់ចំណុចប្រទាក់ TUN។',
      'tun_already_established':
          'OpenVPN បានស្នើសុំចំណុចប្រទាក់ទីពីរក្នុងការតភ្ជាប់ដដែល។ ផ្លូវតុនែលត្រូវបានបញ្ឈប់ដើម្បីសុវត្ថិភាព។',
      'tun_addresses_missing':
          'ម៉ាស៊ីនមេមិនបានផ្តល់អាសយដ្ឋានផ្លូវតុនែលដែលអាចប្រើបានទេ។',
      'tun_routes_missing':
          'ម៉ាស៊ីនមេមិនបានផ្តល់ផ្លូវបណ្តាញដែលអាចប្រើបានសម្រាប់ផ្លូវតុនែលទេ។',
      'tun_dns_missing': 'ម៉ាស៊ីនមេមិនបានផ្តល់ម៉ាស៊ីនមេ DNS ដែលអាចប្រើបានទេ។',
      'tun_permission_revoked':
          'Android បានដកហូតការអនុញ្ញាត VPN ក្នុងអំឡុងពេលភ្ជាប់។',
      'tun_establish_returned_null':
          'Android មិនបានបង្កើតចំណុចប្រទាក់ទេ ដែលជាធម្មតាដោយសារ VPN មួយទៀតនៅតែសកម្ម។',
      'openvpn_service_start_failed':
          'Android មិនអាចចាប់ផ្តើមសេវាផ្ទៃមុខ OpenVPN បានទេ។',
      'openvpn_operation_timeout':
          'ការហៅ JNI ទៅស្នូល OpenVPN បានលើសរយៈពេលអតិបរមារបស់វា។',
      'openvpn_start_failed':
          'សេវា Android ត្រៀមរួចរាល់ ប៉ុន្តែ ស្នូល OpenVPN មិនបានទទួលយកការចាប់ផ្តើមប្រវត្តិរូបទេ។',
      'openvpn_connection_failed':
          'ស្នូល OpenVPN បានឈប់មុនពេលបញ្ចេញព្រឹត្តិការណ៍ CONNECTED។',
      'openvpn_core_status_error':
          'រង្វិលជុំ OpenVPN ដើមបានបញ្ចប់ដោយកំហុស ដោយគ្មានព្រឹត្តិការណ៍បញ្ចប់ណាដែលជាក់លាក់ជាងនេះ។',
      'openvpn_stopped_before_connected':
          'រង្វិលជុំ OpenVPN ដើមបានឈប់មុនពេលមាន CONNECTED ដោយគ្មានកំហុសស្នូលជាក់លាក់។',
      'openvpn_auth_failed':
          'ម៉ាស៊ីនមេ OpenVPN បានបដិសេធការផ្ទៀងផ្ទាត់ប្រវត្តិរូប។',
      'openvpn_client_setup_failed':
          'ស្នូល OpenVPN មិនអាចចាប់ផ្តើមអតិថិជនមុនពេលតភ្ជាប់បណ្តាញបានទេ។',
      'openvpn_client_halted': 'ស្នូល OpenVPN បានទទួលការបញ្ឈប់អតិថិជនចុងក្រោយ។',
      'openvpn_client_restart':
          'ស្នូល OpenVPN បានស្នើសុំចាប់ផ្តើមវគ្គបញ្ជូនរបស់វាឡើងវិញ។',
      'openvpn_inactive_timeout':
          'ស្នូល OpenVPN បានបិទវគ្គបន្ទាប់ពីអស់ពេលអសកម្ម។',
      'openvpn_session_expired':
          'ម៉ាស៊ីនមេបានរាយការណ៍ថាវគ្គ OpenVPN បានផុតកំណត់។',
      'openvpn_credentials_required':
          'ម៉ាស៊ីនមេ ឬប្រូកស៊ីស្នើសុំព័ត៌មានសម្គាល់អន្តរកម្ម ដែលមិនមាននៅក្នុងប្រវត្តិរូបវិញ្ញាបនបត្រនេះទេ។',
      'openvpn_proxy_failed':
          'ស្នូល OpenVPN បានរាយការណ៍ពីការបរាជ័យនៃប្រូកស៊ី ឬម៉ាស៊ីនបញ្ជូនបន្តដែលបានកំណត់។',
      'openvpn_compression_failed':
          'ស្នូល OpenVPN បានបដិសេធរបៀបបង្ហាប់ដែលប្រវត្តិរូប ឬម៉ាស៊ីនមេបានប្រកាស។',
      'openvpn_ntlm_crypto_unavailable':
          'ប្រវត្តិរូបស្នើសុំការអ៊ិនគ្រីប NTLM ដែលមិនមាននៅក្នុងកំណែនេះទេ។',
      'openvpn_feature_unsupported':
          'ប្រវត្តិរូប ឬម៉ាស៊ីនមេត្រូវការមុខងារមួយដែលខ្វះនៅក្នុងកម្មវិធី Android នេះ។',
      'network_unavailable': 'គ្មានបណ្តាញរូបវន្តដែលអាចប្រើបានទេ។',
      'network_lost': 'ផ្លូវតុនែលត្រូវបានបញ្ឈប់ បន្ទាប់ពីបណ្តាញបាត់។',
      'certificate_validation_failed':
          'អត្តសញ្ញាណម៉ាស៊ីនមេ OpenVPN មិនអាចផ្ទៀងផ្ទាត់បានទេ។',
      'openvpn_certificate_expired':
          'វិញ្ញាបនបត្រ OpenVPN បានផុតកំណត់។ សូមចាប់ផ្តើមការតភ្ជាប់ថ្មីនៅក្នុងកម្មវិធី ដើម្បីបន្តសុពលភាព។',
      'tunnel_active_for_another_account':
          'ផ្លូវតុនែលដែលជារបស់គណនីមួយទៀតត្រូវតែបញ្ឈប់មុនពេលការតភ្ជាប់នេះ។',
      'tunnel_already_active':
          'Android រាយការណ៍ថាវគ្គ VPN មុននៅតែកំពុងប្រើចំណុចប្រទាក់។',
      'tunnel_stop_timeout':
          'ម៉ាស៊ីន $protocol មិនបានបញ្ជាក់ការដោះលែងចំណុចប្រទាក់ VPN ក្នុងរយៈពេលកំណត់ឡើយ។',
      'tunnel_disconnected':
          'ម៉ាស៊ីនដើមបានរាយការណ៍ថាផ្លូវតុនែលបានបញ្ចប់ដោយមិនរំពឹងទុក បន្ទាប់ពីចាប់ផ្តើម។',
      'native_bridge_unavailable':
          'កម្មវិធីមិនអាចចូលប្រើសេវា VPN របស់ Android បានទេ។ សូមបិទ ហើយបើកកម្មវិធីឡើងវិញ រួចព្យាយាមម្តងទៀត។',
      'native_operation_failed':
          'កំហុសមួយក្នុងកម្មវិធីបានរំខានប្រតិបត្តិការ VPN។ សូមព្យាយាមម្តងទៀត។ បើបញ្ហានៅតែមាន សូមធ្វើរោគវិនិច្ឆ័យ។',
      'invalid_arguments':
          'ព័ត៌មានដែលត្រូវការសម្រាប់ប្រតិបត្តិការ VPN នេះមិនពេញលេញ។ សូមព្យាយាមម្តងទៀត។ បើបញ្ហានៅតែមាន សូមធ្វើរោគវិនិច្ឆ័យ។',
      'invalid_account_id':
          'ប្រតិបត្តិការដើមមិនទាក់ទងនឹងលេខសម្គាល់គណនីដែលត្រឹមត្រូវទេ។',
      'invalid_device_id':
          'លេខសម្គាល់ឧបករណ៍ដែលបានផ្ញើទៅម៉ាស៊ីនដើមបាត់ ឬមិនត្រឹមត្រូវ។',
      'storage_key_not_allowed':
          'ស្ពាន Android បានទប់ស្កាត់កូនសោមួយដែលនៅក្រៅបញ្ជីផ្ទុកដែលបានអនុញ្ញាត។',
      'secure_storage_read_failed':
          'Android Keystore មិនអាចឌិគ្រីបទិន្នន័យក្នុងឧបករណ៍របស់គណនីនេះបានទេ។',
      'secure_storage_write_failed':
          'Android Keystore មិនអាចអ៊ិនគ្រីប ឬរក្សាទុកទិន្នន័យក្នុងឧបករណ៍បានទេ។',
      'key_generation_failed':
          'Android មិនអាចបង្កើត ឬអានកូនសោ WireGuard ក្នុងទីផ្ទុកសុវត្ថិភាពបានទេ។',
      'csr_generation_failed':
          'Android Keystore មិនអាចបង្កើត ឬចុះហត្ថលេខាលើ CSR P-256 របស់ OpenVPN បានទេ។',
      'other':
          'ផ្នែកដើមមួយដែលមិនមានឯកសារបានបរាជ័យ។ សូមផ្ញើលេខកូដរោគវិនិច្ឆ័យដែលបង្ហាញខាងក្រោម ទៅផ្នែកជំនួយ។',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'សំណើការអនុញ្ញាតកំពុងបើករួចហើយ';

  @override
  String get notice_permissionRequestInProgress_message =>
      'សំណើការអនុញ្ញាត VPN របស់ Android កំពុងបង្ហាញរួចហើយ។ សូមបញ្ចប់វាមុនពេលព្យាយាមម្តងទៀត។';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'សំណើការអនុញ្ញាត VPN ត្រូវបានរំខាន';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'អេក្រង់ការអនុញ្ញាត VPN បានបិទ មុនពេលកម្មវិធីទទួលបានការឆ្លើយតប។';

  @override
  String get notice_openvpnProofMissing_title =>
      'មិនបានបញ្ជាក់ការតភ្ជាប់ OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'មិនអាចបញ្ជាក់ការតភ្ជាប់ OpenVPN បានទេ។ ការតភ្ជាប់ត្រូវបានបញ្ឈប់ដើម្បីសុវត្ថិភាព។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get openvpnCleanup_title => 'ប្រវត្តិរូប OpenVPN ត្រូវបានលុបចោល';

  @override
  String get openvpnCleanup_working =>
      'កំពុងបញ្ឈប់ និងដកប្រវត្តិរូប OpenVPN ដែលត្រូវបានលុបចោលចេញ…';

  @override
  String get openvpnCleanup_stopFailed =>
      'មិនទាន់បានបញ្ជាក់ការបញ្ឈប់ OpenVPN ទេ។ សូមព្យាយាមម្តងទៀត មុនពេលបង្កើតប្រវត្តិរូបថ្មី។';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'មិនអាចដកប្រវត្តិរូប OpenVPN ដែលត្រូវបានលុបចោលចេញបានទាំងស្រុងទេ។ សូមព្យាយាមសម្អាតម្តងទៀត។';

  @override
  String get openvpnCleanup_complete =>
      'ប្រវត្តិរូប OpenVPN ដែលត្រូវបានលុបចោលត្រូវបានដកចេញរួចហើយ។ សូមចុច ភ្ជាប់ ដើម្បីបង្កើតប្រវត្តិរូបថ្មី។';

  @override
  String get network_title => 'ការកំណត់បណ្តាញ';

  @override
  String get network_ipv4Fallback =>
      'IPv6 មិនអាចប្រើបានជាបណ្តោះអាសន្នទេ។ ការរៀបចំនៅតែបន្តជាមួយ IPv4។';

  @override
  String get network_rejectedTitle => 'ការកំណត់បណ្តាញត្រូវបានបដិសេធ';

  @override
  String get network_rejectedMessage =>
      'ការកំណត់ផ្លូវតុនែលមិនពេញលេញ ឬមិនត្រូវនឹងអាសយដ្ឋានដែលបានអនុញ្ញាតទេ។ សូមព្យាយាមម្តងទៀតពីកម្មវិធី។';

  @override
  String get network_unreadableTitle => 'មិនអាចអានការកំណត់ក្នុងឧបករណ៍បាន';

  @override
  String get network_unreadableMessage =>
      'ការកំណត់បណ្តាញ OpenVPN ដែលបានរក្សាទុកមិនអាចប្រើបានទេ។ សូមភ្ជាប់ឡើងវិញពីកម្មវិធី ដើម្បីធ្វើបច្ចុប្បន្នភាព។';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ការការពារបណ្តាញ';

  @override
  String get protection_subtitle =>
      'ទប់ស្កាត់ការចូលប្រើអ៊ីនធឺណិតដោយផ្ទាល់ ប្រសិនបើ VPN ដាច់។';

  @override
  String get protection_active => 'ការការពារប្រព័ន្ធកំពុងដំណើរការ';

  @override
  String get protection_alwaysOnOnly =>
      'បានបើក VPN បើកជានិច្ចហើយ សូមបើកការទប់ស្កាត់នៅក្រៅ VPN';

  @override
  String get protection_inactive => 'ការការពារប្រព័ន្ធមិនដំណើរការ';

  @override
  String get protection_unknown => 'សូមពិនិត្យការការពារប្រព័ន្ធ';

  @override
  String get protection_openSettings => 'បើកការកំណត់ Android';

  @override
  String get protection_dialogTitle => 'រៀបចំការការពារបណ្តាញ';

  @override
  String get protection_dialogMessage =>
      'Android គ្រប់គ្រង VPN បើកជានិច្ច និងការទប់ស្កាត់ការតភ្ជាប់នៅក្រៅ VPN។ សូមពិនិត្យមើលថា FuzeVPN ត្រូវបានជ្រើសរើស ហើយបើកការទប់ស្កាត់ក្នុងការកំណត់ប្រព័ន្ធ។';

  @override
  String get protection_dialogOpen => 'បើកការកំណត់';

  @override
  String get session_systemProtectionNote =>
      'ប្រសិនបើ Android នៅតែទប់ស្កាត់ចរាចរណ៍ក្រៅ VPN សូមបើកការកំណត់ប្រព័ន្ធ ដើម្បីពិនិត្យ ឬផ្លាស់ប្តូរការការពារនេះ។';

  @override
  String get diagnostics_title => 'ការធ្វើរោគវិនិច្ឆ័យ';

  @override
  String get diagnostics_settingsTitle => 'រោគវិនិច្ឆ័យកម្មវិធី';

  @override
  String get diagnostics_automaticTitle => 'ផ្ញើកំហុសសំខាន់ៗ';

  @override
  String get diagnostics_automaticDescription =>
      'ចែករំលែករបាយការណ៍បច្ចេកទេសខ្នាតតូច នៅពេលមានកំហុសសំខាន់កើតឡើង។';

  @override
  String get diagnostics_privacy =>
      'របាយការណ៍ដែលបានផ្ញើត្រូវបានភ្ជាប់ទៅនឹងគណនីដែលបានចូល ហើយរក្សាទុករយៈពេល 30 ថ្ងៃ។ របាយការណ៍មិនមានប្រវត្តិរុករកតាមអ៊ីនធឺណិត ពាក្យសម្ងាត់ ឬកូនសោ VPN ឡើយ។';

  @override
  String get diagnostics_manualOpen => 'ធ្វើរោគវិនិច្ឆ័យ';

  @override
  String get diagnostics_localDescription =>
      'បង្កើតរបាយការណ៍ស្ថានភាពកម្មវិធី និង VPN។ ការតភ្ជាប់របស់អ្នកនឹងនៅដដែល។';

  @override
  String get diagnostics_sendReport => 'ផ្ញើរបាយការណ៍';

  @override
  String get diagnostics_sendHint =>
      'សូមទុកប្រអប់នេះមិនធីក ដើម្បីរក្សាទុករបាយការណ៍នៅលើឧបករណ៍នេះ។';

  @override
  String get diagnostics_signedOut => 'សូមចូលគណនីរបស់អ្នក ដើម្បីផ្ញើរបាយការណ៍។';

  @override
  String get diagnostics_localLifetime =>
      'ដើម្បីរក្សាទុករបាយការណ៍នេះបន្ទាប់ពីបិទកម្មវិធី សូមរក្សាទុកវានៅលើទូរស័ព្ទរបស់អ្នក។';

  @override
  String get diagnostics_run => 'ធ្វើរោគវិនិច្ឆ័យ';

  @override
  String get diagnostics_rerun => 'ធ្វើរោគវិនិច្ឆ័យម្តងទៀត';

  @override
  String get diagnostics_running => 'កំពុងពិនិត្យ…';

  @override
  String get diagnostics_sending => 'កំពុងផ្ញើរបាយការណ៍…';

  @override
  String get diagnostics_prepared => 'របាយការណ៍ត្រៀមរួចរាល់នៅលើឧបករណ៍នេះ';

  @override
  String get diagnostics_queued => 'របាយការណ៍កំពុងរង់ចាំការផ្ញើ';

  @override
  String get diagnostics_sent => 'បានទទួលរបាយការណ៍';

  @override
  String get diagnostics_failed =>
      'ការផ្ញើបានបរាជ័យ។ របាយការណ៍ក្នុងឧបករណ៍របស់អ្នកនៅតែអាចប្រើបាន។';

  @override
  String get diagnostics_preparationFailed =>
      'មិនអាចរៀបចំរបាយការណ៍រោគវិនិច្ឆ័យបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get diagnostics_authenticationRequired =>
      'សូមចូលគណនីម្តងទៀត ដើម្បីផ្ញើរបាយការណ៍។';

  @override
  String get diagnostics_retry => 'ព្យាយាមផ្ញើម្តងទៀត';

  @override
  String get diagnostics_export => 'រក្សាទុករបាយការណ៍';

  @override
  String get diagnostics_exportFailed =>
      'ការនាំចេញបានបរាជ័យ។ សូមព្យាយាមម្តងទៀតពីរបាយការណ៍ក្នុងឧបករណ៍។';

  @override
  String get diagnostics_preferenceFailed =>
      'មិនអាចរក្សាទុកការកំណត់នេះបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String diagnostics_receipt(Object id) {
    return 'លេខយោង៖ $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'បានទទួលកាលពី $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'រក្សាទុករហូតដល់ $date';
  }

  @override
  String get diagnostics_duplicate => 'របាយការណ៍នេះត្រូវបានទទួលរួចហើយ។';

  @override
  String get diagnostics_preview => 'ការមើលរបាយការណ៍ជាមុន';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ព្រឹត្តិការណ៍បច្ចេកទេសចំនួន $count ត្រូវបានភ្ជាប់',
      one: 'ព្រឹត្តិការណ៍បច្ចេកទេសចំនួន 1 ត្រូវបានភ្ជាប់',
      zero: 'គ្មានព្រឹត្តិការណ៍បច្ចេកទេសភ្ជាប់មកទេ',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'ព័ត៌មានបច្ចេកទេស';

  @override
  String get diagnostics_empty =>
      'មិនទាន់បានរៀបចំរបាយការណ៍រោគវិនិច្ឆ័យនៅឡើយទេ។';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'ស្ថានភាពផ្លូវតុនែល',
      'handshake': 'ការបញ្ជាក់ការតភ្ជាប់',
      'certificate': 'វិញ្ញាបនបត្រ VPN',
      'kill_switch': 'ការការពារ Android',
      'connectivity': 'បណ្តាញដែលអាចប្រើបាន',
      'api_reachability': 'ការចូលប្រើសេវា',
      'secure_storage': 'ទីផ្ទុកសុវត្ថិភាព',
      'other': 'ការពិនិត្យក្នុងឧបករណ៍',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'បានពិនិត្យ',
      'failed': 'ត្រូវការយកចិត្តទុកដាក់',
      'skipped': 'មិនបានសាកល្បង — គ្មានការត្រួតពិនិត្យសកម្ម',
      'unknown': 'មិនមានព័ត៌មាន',
      'other': 'មិនមានព័ត៌មាន',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'សូមស្វាគមន៍មកកាន់ FuzeVPN';

  @override
  String get connection_changeLocation => 'ប្តូរទីតាំង';

  @override
  String get connection_details => 'ព័ត៌មានលម្អិតអំពីការតភ្ជាប់';

  @override
  String get locations_searchLabel => 'ស្វែងរកទីក្រុង ឬប្រទេស';

  @override
  String get locations_clearSearch => 'សម្អាតការស្វែងរក';

  @override
  String get locations_filterAll => 'ទាំងអស់';

  @override
  String get locations_filterFavorites => 'ចំណូលចិត្ត';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ទីតាំង',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'រកមិនឃើញទីតាំងទេ';

  @override
  String get locations_noResultsHint => 'សូមសាកល្បងទីក្រុង ឬប្រទេសផ្សេង។';

  @override
  String get locations_noFavorites => 'ចំណូលចិត្តរបស់អ្នក នៅក្បែរដៃ';

  @override
  String get locations_noFavoritesHint =>
      'ចុចផ្កាយនៅក្បែរទីតាំង ដើម្បីរក្សាទុកវានៅទីនេះ។';

  @override
  String get locations_showAll => 'មើលទីតាំងទាំងអស់';

  @override
  String locations_addFavorite(String name) {
    return 'បន្ថែម $name ទៅចំណូលចិត្ត';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'ដក $name ចេញពីចំណូលចិត្ត';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'មិនអាចរក្សាទុកចំណូលចិត្តបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get locations_emptyTitle => 'គ្មានទីតាំងដែលអាចប្រើបានទេ';

  @override
  String get locations_emptyHint =>
      'សូមធ្វើបច្ចុប្បន្នភាពបញ្ជី ដើម្បីព្យាយាមម្តងទៀត។';

  @override
  String get devices_manage => 'គ្រប់គ្រងឧបករណ៍របស់ខ្ញុំ';

  @override
  String get settings_personalization => 'កំណត់តាមបំណងចិត្តរបស់អ្នក';

  @override
  String get settings_safety => 'ការការពារ';

  @override
  String get settings_help => 'ត្រូវការជំនួយទេ?';

  @override
  String get settings_about => 'អំពី FuzeVPN';

  @override
  String get diagnostics_heading => 'ស្វែងយល់អំពីបញ្ហាការតភ្ជាប់';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'អាចប្រើបាន',
      'pending': 'កំពុងរៀបចំ',
      'revoked': 'ត្រូវបានដកចេញ',
      'expired': 'បានផុតកំណត់',
      'other': 'មិនមានស្ថានភាព',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ការកំណត់មិនបានរក្សាទុក';

  @override
  String get notice_preferenceSave_message =>
      'ជម្រើសរបស់អ្នកត្រូវបានអនុវត្តសម្រាប់ពេលនេះ ប៉ុន្តែមិនអាចរក្សាទុកបានទេ។ សូមព្យាយាមម្តងទៀត ដើម្បីរក្សាវាទុកបន្ទាប់ពីបិទកម្មវិធី។';

  @override
  String get connection_androidDisconnectHint =>
      'ប្រសិនបើ Android នៅតែរក្សា VPN ឱ្យដំណើរការ សូមបិទ VPN បើកជានិច្ច នៅក្នុងការកំណត់ដែលនឹងបើកឡើង។';

  @override
  String get connection_certificate => 'វិញ្ញាបនបត្រ OpenVPN';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'មានសុពលភាពរហូតដល់ $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'បានផុតកំណត់កាលពី $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'នឹងបន្តសុពលភាពដោយស្វ័យប្រវត្តិនៅពេលភ្ជាប់លើកក្រោយ។';

  @override
  String get protection_learnMore => 'ស្វែងយល់ពីការការពារ Android';

  @override
  String get protection_guideWhy =>
      'ការការពារនេះទប់ស្កាត់មិនឱ្យកម្មវិធីប្រើអ៊ីនធឺណិតដោយផ្ទាល់ ប្រសិនបើ VPN ដាច់។ ការកំណត់នេះធ្វើឡើងនៅក្នុង Android។';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN បើកជានិច្ច';

  @override
  String get protection_guideAlwaysOn =>
      'Android រក្សាសេវា VPN ឱ្យដំណើរការជានិច្ច ហើយអាចចាប់ផ្តើមវាម្តងទៀតបន្ទាប់ពីទូរស័ព្ទចាប់ផ្តើមឡើងវិញ។';

  @override
  String get protection_guideBlockTitle => 'ទប់ស្កាត់ការតភ្ជាប់ដោយគ្មាន VPN';

  @override
  String get protection_guideBlock =>
      'ការកំណត់នេះទប់ស្កាត់ចរាចរណ៍មិនឱ្យចេញក្រៅ VPN សូម្បីតែពេលការតភ្ជាប់ត្រូវបានរំខាន។';

  @override
  String get protection_guideWarning =>
      'នៅពេលបើកការទប់ស្កាត់នេះ ការចូលប្រើអ៊ីនធឺណិតនឹងនៅតែបិទ រហូតដល់ VPN ត្រូវបានភ្ជាប់។';

  @override
  String get protection_guideStepsTitle => 'បើកការការពារ';

  @override
  String get protection_guideStep1 =>
      'សូមបើកការកំណត់ VPN របស់ Android ដោយប្រើប៊ូតុងខាងក្រោម។';

  @override
  String get protection_guideStep2 =>
      'សូមបើកជម្រើសដោយចុចរូបតំណាងកង់ធ្មេញនៅក្បែរ FuzeVPN។';

  @override
  String get protection_guideStep3 =>
      'សូមបើក “VPN បើកជានិច្ច” បន្ទាប់មកបើក “ទប់ស្កាត់ការតភ្ជាប់ដោយគ្មាន VPN” ប្រសិនបើជម្រើសទាំងនេះមាន។';

  @override
  String get protection_guideManufacturers =>
      'ឈ្មោះអាចខុសគ្នាតាមទូរស័ព្ទ។ ប្រសិនបើចាំបាច់ សូមស្វែងរក VPN នៅក្នុងការកំណត់ ជារឿយៗនៅក្នុង “បណ្តាញ និងអ៊ីនធឺណិត”។';

  @override
  String get protection_guideDisableTitle => 'បិទការការពារនេះ';

  @override
  String get protection_guideDisable =>
      'នៅក្នុងការកំណត់ដដែល សូមបិទ “ទប់ស្កាត់ការតភ្ជាប់ដោយគ្មាន VPN” ដើម្បីអនុញ្ញាតឱ្យចូលប្រើអ៊ីនធឺណិតដោយគ្មាន VPN។ សូមបិទ “VPN បើកជានិច្ច” ផងដែរ ប្រសិនបើអ្នកលែងចង់ឱ្យ Android ចាប់ផ្តើមវាឡើងវិញ។';

  @override
  String get protection_guideManual =>
      'អ្នកជ្រើសរើសការកំណត់ទាំងនេះដោយខ្លួនឯងនៅក្នុង Android។ FuzeVPN មិនផ្លាស់ប្តូរវាជំនួសអ្នកទេ។';

  @override
  String get locations_changeTitle => 'ប្តូរទីតាំង?';

  @override
  String locations_changeActive(String name) {
    return 'VPN នឹងផ្តាច់ការតភ្ជាប់ បន្ទាប់មកព្យាយាមភ្ជាប់ទៅ $name។';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN នឹងព្យាយាមភ្ជាប់ទៅ $name។';
  }

  @override
  String get locations_confirmChange => 'ប្តូរ និងភ្ជាប់';

  @override
  String get locations_changeBusy =>
      'ការប្តូរកំពុងដំណើរការ។ សូមរង់ចាំមុនពេលជ្រើសរើសទីតាំងផ្សេង។';

  @override
  String get locations_automaticSelection => 'ការជ្រើសរើសដោយស្វ័យប្រវត្តិ';

  @override
  String get locations_cities => 'ទីក្រុង';

  @override
  String get locations_servers => 'ម៉ាស៊ីនមេ';

  @override
  String locations_viewCities(String name) {
    return 'មើលទីក្រុងនៅក្នុង $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'មើលម៉ាស៊ីនមេនៅក្នុង $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ប្រទេស',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ទីក្រុង',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ម៉ាស៊ីនមេ',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ប្រទេសទាំងអស់';

  @override
  String get locations_backToCountries => 'ត្រឡប់ទៅប្រទេសវិញ';

  @override
  String locations_backToCities(String name) {
    return 'ត្រឡប់ទៅទីក្រុងនៅ $name វិញ';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'ជ្រើសរើស $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'ជ្រើសរើស $name';
  }

  @override
  String get locations_noCompatibleServer => 'គ្មានម៉ាស៊ីនមេដែលត្រូវគ្នាទេ។';

  @override
  String get externalLink_failed =>
      'មិនអាចបើកតំណនេះបានទេ។ អ្នកអាចចម្លងវា ហើយបើកក្នុងកម្មវិធីរុករកតាមអ៊ីនធឺណិតរបស់អ្នក។';

  @override
  String get externalLink_copy => 'ចម្លងតំណ';

  @override
  String get externalLink_copied => 'បានចម្លងតំណ';

  @override
  String get externalLink_copyFailed =>
      'មិនអាចចម្លងតំណបានទេ។ សូមជ្រើសរើសអាសយដ្ឋានខាងក្រោម។';

  @override
  String get settings_deleteAccount => 'លុបគណនីរបស់ខ្ញុំ';

  @override
  String get settings_deleteAccountDetail => 'មើលនីតិវិធីស្នើសុំលុបគណនី';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'សូមជ្រើសរើសការជាវ VPN របស់អ្នក។';

  @override
  String get billing_subscribe => 'ជាវ';

  @override
  String get billing_choosePlan => 'សូមជ្រើសរើសគម្រោង ដើម្បីបន្ត។';

  @override
  String get billing_monthly => 'ប្រចាំខែ';

  @override
  String get billing_yearly => 'ប្រចាំឆ្នាំ';

  @override
  String get billing_continue => 'បន្តជាមួយ Google Play';

  @override
  String get billing_restore => 'ស្តារការទិញ';

  @override
  String get billing_manage => 'គ្រប់គ្រងការជាវ';

  @override
  String get billing_deleteAccountWarning =>
      'ប្រសិនបើអ្នកមានការជាវ Google Play ការលុបគណនី FuzeVPN របស់អ្នកមិនបោះបង់ការបន្តដោយស្វ័យប្រវត្តិរបស់វាទេ។ សូមគ្រប់គ្រង ឬបោះបង់ការបន្តនេះដោយឡែកនៅក្នុង Google Play។';

  @override
  String get billing_deleteAccountContinue => 'បន្តទៅកាន់សំណើលុបគណនី';

  @override
  String get billing_refresh => 'ធ្វើបច្ចុប្បន្នភាពការចូលប្រើ';

  @override
  String get billing_loadingPlans => 'កំពុងផ្ទុកគម្រោង…';

  @override
  String get billing_unavailable =>
      'បច្ចុប្បន្នមិនមានគម្រោងទេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។';

  @override
  String get billing_comingSoon => 'ការជាវនឹងមានឆាប់ៗ។';

  @override
  String get billing_priceDisclosure =>
      'តម្លៃត្រូវបានផ្តល់ដោយ Google Play។ ចំនួនទឹកប្រាក់ចុងក្រោយ និងពន្ធដែលអនុវត្តនឹងត្រូវបានបញ្ជាក់មុនពេលអ្នកបញ្ជាក់។';

  @override
  String get billing_renewalMonthly =>
      'ការជាវនឹងបន្តដោយស្វ័យប្រវត្តិរាល់ខែ លុះត្រាតែបោះបង់។ អ្នកអាចបោះបង់បានគ្រប់ពេលនៅក្នុងការជាវ Google Play។';

  @override
  String get billing_renewalYearly =>
      'ការជាវនឹងបន្តដោយស្វ័យប្រវត្តិរាល់ឆ្នាំ លុះត្រាតែបោះបង់។ អ្នកអាចបោះបង់បានគ្រប់ពេលនៅក្នុងការជាវ Google Play។';

  @override
  String get billing_active => 'ការចូលប្រើ Premium របស់អ្នកកំពុងដំណើរការ';

  @override
  String billing_accessUntil(String date) {
    return 'ការចូលប្រើរហូតដល់ $date។';
  }

  @override
  String get billing_webManaged =>
      'ការជាវរបស់អ្នកត្រូវបានគ្រប់គ្រងនៅលើគេហទំព័រ FuzeVPN។';

  @override
  String get billing_playManaged =>
      'ការជាវរបស់អ្នកត្រូវបានគ្រប់គ្រងដោយ Google Play។';

  @override
  String get billing_playOnHold =>
      'ការជាវ Google Play របស់អ្នកត្រូវបានផ្អាក ឬកំពុងរង់ចាំការទូទាត់។ សូមបើក “គ្រប់គ្រងការជាវ” ដើម្បីដោះស្រាយនៅក្នុង Google Play។';

  @override
  String get billing_playReceiptUnlinked =>
      'គណនី Google Play នេះមានការជាវ Fuze Premium រួចហើយ ប៉ុន្តែមិនសកម្មសម្រាប់គណនី FuzeVPN នេះទេ។ សូមបើក “គ្រប់គ្រងការជាវ” ដើម្បីពិនិត្យនៅក្នុង Google Play។';

  @override
  String get billing_inactive => 'មិនមានការជាវសកម្មទេ។';

  @override
  String get billing_checkingAccess => 'កំពុងពិនិត្យការចូលប្រើរបស់អ្នក…';

  @override
  String get billing_restoring => 'កំពុងស្តារការទិញ…';

  @override
  String get billing_pending =>
      'ការទូទាត់កំពុងរង់ចាំ។ ការចូលប្រើរបស់អ្នកនឹងត្រូវបានធ្វើឱ្យសកម្មបន្ទាប់ពីការបញ្ជាក់។';

  @override
  String get billing_cancelled =>
      'ការទិញត្រូវបានបោះបង់។ មិនមានការជាវថ្មីត្រូវបានធ្វើឱ្យសកម្មទេ។';

  @override
  String get billing_verifying => 'កំពុងផ្ទៀងផ្ទាត់ការទិញ…';

  @override
  String get billing_success =>
      'ការជាវត្រូវបានធ្វើឱ្យសកម្ម។ ការចូលប្រើ Premium របស់អ្នករួចរាល់ហើយ។';

  @override
  String get billing_restored => 'ការទិញរបស់អ្នកត្រូវបានស្តាររួចហើយ។';

  @override
  String get billing_restoreEmpty =>
      'មិនមានការទិញដែលត្រូវស្តារសម្រាប់គណនី Google Play នេះទេ។';

  @override
  String get billing_catalogError =>
      'មិនអាចផ្ទុកគម្រោងបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get billing_purchaseError =>
      'មិនអាចចាប់ផ្តើមការទិញបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get billing_verificationError =>
      'ការផ្ទៀងផ្ទាត់ការទិញមិនអាចប្រើបានជាបណ្តោះអាសន្នទេ។ សូមស្តារការទិញ ដើម្បីព្យាយាមម្តងទៀត។';

  @override
  String get billing_restoreError =>
      'មិនអាចស្តារការទិញបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get billing_managementError =>
      'មិនអាចបើកការគ្រប់គ្រងការជាវបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get billing_storeUnavailable =>
      'Google Play មិនអាចប្រើបានលើឧបករណ៍នេះទេ។';

  @override
  String get welcome_title => 'VPN របស់អ្នក ធ្វើឱ្យសាមញ្ញ។';

  @override
  String get welcome_description =>
      'ការពារការតភ្ជាប់របស់អ្នក។ រក្សាការគ្រប់គ្រងលើឯកជនភាពរបស់អ្នក។';

  @override
  String get welcome_start => 'ចាប់ផ្តើម';

  @override
  String get welcome_alreadyPurchased => 'បានទិញរួចហើយ?';

  @override
  String get welcome_noAccountRequired => 'មិនចាំបាច់មានគណនីដើម្បីចាប់ផ្តើមទេ។';

  @override
  String get guest_accountTitle => 'គណនីមិនបានភ្ជាប់';

  @override
  String get guest_accountDescription =>
      'ស្តារការទិញរបស់អ្នកដោយប្រើគណនី Google Play ដូចគ្នា ដើម្បីប្រើការជាវរបស់អ្នកនៅលើឧបករណ៍ផ្សេង។';

  @override
  String get guest_existingSubscriberSignIn => 'បានជាវរួចហើយ? ចូលគណនី';

  @override
  String get guest_claimTitle => 'យក FuzeVPN ទៅជាមួយអ្នក';

  @override
  String get guest_claimDescription =>
      'បង្កើតគណនី ដើម្បីចូលប្រើការជាវរបស់អ្នកនៅលើឧបករណ៍ផ្សេងទៀតរបស់អ្នក។ ជំហាននេះគឺស្រេចចិត្ត។';

  @override
  String get guest_skip => 'ពេលក្រោយ';

  @override
  String get guest_activationTitle => 'Fuze Premium សកម្មហើយ';

  @override
  String get guest_activationDescription =>
      'ការជាវរបស់អ្នករួចរាល់ហើយ។ អ្នកអាចប្រើ VPN និងបង្កើតគណនីនៅពេលណាដែលអ្នកចង់។';

  @override
  String get guest_useVpn => 'ប្រើ VPN របស់ខ្ញុំ';

  @override
  String get guest_loginRequired =>
      'ការទិញនេះត្រូវបានភ្ជាប់ទៅគណនី FuzeVPN រួចហើយ។ សូមចូលគណនីនោះ ដើម្បីចូលប្រើការជាវរបស់អ្នក។';

  @override
  String get guest_signOutWarning =>
      'អ្នកអាចទទួលបានការជាវរបស់អ្នកមកវិញ ដោយស្តារការទិញជាមួយគណនី Google Play ដូចគ្នា។';

  @override
  String get guest_profileUnavailable =>
      'គណនីរបស់អ្នកត្រូវបានភ្ជាប់រួចហើយ។ សូមចូលគណនី ដើម្បីមើល និងគ្រប់គ្រងព័ត៌មានលម្អិតរបស់អ្នក។';

  @override
  String get billing_acceptance =>
      'ដោយបន្ត អ្នកទទួលយកលក្ខខណ្ឌប្រើប្រាស់ និងគោលការណ៍ឯកជនភាព។';

  @override
  String get guest_verifyEmailReminder =>
      'សូមបញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នក ដើម្បីការពារគណនី។ អ្នកអាចបន្តប្រើ VPN បាន។';

  @override
  String get guest_serviceUnavailable =>
      'សេវាកម្មមិនអាចប្រើបានជាបណ្តោះអាសន្នទេ។ សូមព្យាយាមម្តងទៀតក្នុងពេលឆាប់ៗ។';

  @override
  String get guest_restoreError =>
      'មិនអាចស្តារការទិញរបស់អ្នកបានទេ។ សូមព្យាយាមម្តងទៀតដោយប្រើគណនី Google Play ដែលបានប្រើសម្រាប់ការទិញ។';

  @override
  String get guest_claimSuccess =>
      'គណនីរបស់អ្នកត្រូវបានបង្កើតហើយ។ ការជាវ និងការចូលប្រើ VPN របស់អ្នកត្រូវបានរក្សាទុក។';

  @override
  String get guest_emailExists =>
      'អ៊ីមែលនេះត្រូវបានប្រើរួចហើយ។ សូមជ្រើសរើសអាសយដ្ឋានផ្សេង ឬចូលគណនីដែលមានស្រាប់របស់អ្នក។ ការទិញរបស់អ្នកនៅតែអាចប្រើបានតាមរយៈ Google Play។';

  @override
  String get guest_claimError =>
      'មិនអាចបង្កើតគណនីរបស់អ្នកបានទេ។ អ្នកអាចបន្តប្រើ VPN របស់អ្នក ហើយព្យាយាមម្តងទៀតនៅពេលក្រោយ។';

  @override
  String get guest_secureStorageError =>
      'មិនអាចការពារវគ្គរបស់អ្នកនៅលើឧបករណ៍នេះបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get guest_premiumRequired =>
      'សូមជ្រើសរើសការជាវ ដើម្បីធ្វើឱ្យ VPN របស់អ្នកសកម្ម។';

  @override
  String get welcome_viewPlans => 'មើលគម្រោង';

  @override
  String get google_continue => 'បន្តជាមួយ Google';

  @override
  String get google_or => 'ឬ';

  @override
  String get google_title => 'គណនី FuzeVPN របស់អ្នក';

  @override
  String get google_settingUp => 'បញ្ចប់ការបង្កើតគណនីរបស់អ្នក';

  @override
  String get google_country => 'ប្រទេសដែលអ្នករស់នៅ';

  @override
  String get google_profileDescription =>
      'សូមជ្រើសរើសប្រទេសរបស់អ្នក ហើយពិនិត្យឯកសារទាំងពីរ ដើម្បីបង្កើតគណនី FuzeVPN របស់អ្នក។';

  @override
  String get google_claimDescription =>
      'ភ្ជាប់គណនីភ្ញៀវរបស់អ្នកទៅ Google។ ការជាវ និងឧបករណ៍របស់អ្នកនៅតែភ្ជាប់ជាមួយគណនីនេះ។';

  @override
  String get google_linkTitle => 'ភ្ជាប់ Google ទៅ FuzeVPN';

  @override
  String get google_linkDescription =>
      'បញ្ជាក់ការចូលប្រើគណនី FuzeVPN ដែលមានស្រាប់របស់អ្នក។ ជំហាននេះមិនសួរពាក្យសម្ងាត់ Google របស់អ្នកទេ។';

  @override
  String get google_password => 'ពាក្យសម្ងាត់ FuzeVPN';

  @override
  String get google_linkAccount => 'បញ្ជាក់ការភ្ជាប់';

  @override
  String get google_requestEmail => 'ផ្ញើអ៊ីមែលបញ្ជាក់មកខ្ញុំ';

  @override
  String get google_emailInstructions =>
      'សូមបើកអ៊ីមែល FuzeVPN ហើយបញ្ចូលលេខកូដបញ្ជាក់។';

  @override
  String get google_emailCode => 'លេខកូដបញ្ជាក់តាមអ៊ីមែល';

  @override
  String get google_confirmEmail => 'បញ្ជាក់លេខកូដ';

  @override
  String get google_restart => 'ជ្រើសរើសគណនី Google ផ្សេង';

  @override
  String get google_resume => 'ពិនិត្យការព្យាយាមនេះ';

  @override
  String get google_unavailable =>
      'ការចូលគណនី Google មិនអាចប្រើបានទេ។ អ្នកអាចប្រើអ៊ីមែល និងពាក្យសម្ងាត់។';

  @override
  String get google_expired =>
      'ការព្យាយាមនេះផុតកំណត់ហើយ។ សូមបោះបង់ ហើយចាប់ផ្តើមម្តងទៀត។';

  @override
  String get google_conflict =>
      'គណនី Google នេះត្រូវបានភ្ជាប់នៅកន្លែងផ្សេងរួចហើយ។ គណនី និងការជាវបច្ចុប្បន្នរបស់អ្នកត្រូវបានរក្សាទុកដដែល។';

  @override
  String get google_error =>
      'ការចូលគណនី Google បានបរាជ័យ។ សូមព្យាយាមម្តងទៀត។ ការចូលប្រើបច្ចុប្បន្នរបស់អ្នកត្រូវបានរក្សាទុកដដែល។';

  @override
  String get google_uncertain =>
      'មិនអាចបញ្ជាក់លទ្ធផលបានទេ។ សូមពិនិត្យការព្យាយាមនេះ ឬបោះបង់វាមុនពេលចាប់ផ្តើមម្តងទៀត។';

  @override
  String get google_cancelFailed =>
      'មិនអាចបញ្ជាក់ការបោះបង់បានទេ។ សូមព្យាយាមបោះបង់ម្តងទៀត មុនពេលចាកចេញពីអេក្រង់នេះ។';

  @override
  String get google_cancelled => 'បានបោះបង់ការចូលគណនី Google។';

  @override
  String get google_selecting => 'សូមជ្រើសរើសគណនី Google របស់អ្នក…';

  @override
  String get google_verifying => 'កំពុងពិនិត្យគណនីរបស់អ្នក…';

  @override
  String get google_emailUnavailable =>
      'មិនអាចផ្ញើអ៊ីមែលបញ្ជាក់បានទេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។';

  @override
  String get google_emailSent =>
      'បានផ្ញើអ៊ីមែលបញ្ជាក់ហើយ។ សូមពិនិត្យប្រអប់សំបុត្ររបស់អ្នក។';

  @override
  String get google_rateLimited => 'សូមរង់ចាំមុនពេលព្យាយាមម្តងទៀត។';

  @override
  String get google_busy =>
      'Google មិនអាចប្រើបានខណៈមានប្រតិបត្តិការផ្សេងកំពុងដំណើរការ (ការតភ្ជាប់ VPN, គណនី ឬភ្ញៀវ)។ សូមព្យាយាមម្តងទៀតនៅពេលវាបញ្ចប់។ ការចូលប្រើបច្ចុប្បន្នរបស់អ្នកត្រូវបានរក្សាទុកដដែល។';

  @override
  String get google_invalidPassword =>
      'ពាក្យសម្ងាត់ FuzeVPN មិនត្រឹមត្រូវទេ។ គណនីបច្ចុប្បន្នរបស់អ្នកត្រូវបានរក្សាទុកដដែល។';

  @override
  String get google_invalidCode => 'លេខកូដបញ្ជាក់មិនត្រឹមត្រូវ ឬផុតកំណត់ហើយ។';

  @override
  String get google_accountChanged =>
      'វគ្គរបស់អ្នកបានផ្លាស់ប្តូរ។ សូមបោះបង់ការព្យាយាមនេះ មុនពេលចាប់ផ្តើមម្តងទៀត។';

  @override
  String get google_invalidResponse =>
      'មិនអាចផ្ទៀងផ្ទាត់ការឆ្លើយតបបានទេ។ ការចូលប្រើបច្ចុប្បន្នរបស់អ្នកត្រូវបានរក្សាទុកដដែល។';

  @override
  String get google_invalidRegistration =>
      'សូមពិនិត្យប្រទេស និងការយល់ព្រមទាំងពីររបស់អ្នក។';

  @override
  String get google_consentRequired =>
      'សូមជ្រើសរើសប្រទេសរបស់អ្នក ហើយទទួលយកឯកសារទាំងពីរ ដើម្បីបន្ត។';

  @override
  String get google_challengeRequired =>
      'តម្រូវឱ្យមានការពិនិត្យសុវត្ថិភាពបន្ថែម។ ការចូលប្រើបច្ចុប្បន្នរបស់អ្នកត្រូវបានរក្សាទុកដដែល។';

  @override
  String get google_challengeUnavailable =>
      'ការពិនិត្យសុវត្ថិភាពមិនអាចប្រើបានទេ។ សូមព្យាយាមម្តងទៀតនៅពេលក្រោយ។';

  @override
  String get google_intentMismatch =>
      'ការព្យាយាមចូលគណនី Google ពីមុននៅតែកំពុងរង់ចាំ។ សូមបោះបង់វាមុនពេលចាប់ផ្តើមប្រតិបត្តិការនេះ។';

  @override
  String get google_challengeBlocked =>
      'ការពិនិត្យសុវត្ថិភាពដែលត្រូវការមិនអាចប្រើបានក្នុងកម្មវិធីនេះទេ។ ប្រតិបត្តិការនេះមិនអាចបញ្ចប់បានឥឡូវនេះទេ។';

  @override
  String get google_solveChallenge => 'បញ្ចប់ការពិនិត្យសុវត្ថិភាព';

  @override
  String get google_challengeTitle => 'ការពិនិត្យសុវត្ថិភាព';

  @override
  String get google_challengeReady =>
      'ការផ្ទៀងផ្ទាត់បានបញ្ចប់។ ឥឡូវអ្នកអាចបញ្ជាក់ការបង្កើតគណនីរបស់អ្នក។';

  @override
  String get google_challengeExpired =>
      'ការផ្ទៀងផ្ទាត់បានផុតកំណត់ហើយ។ សូមបញ្ចប់វាម្តងទៀតមុនពេលបញ្ជាក់។';

  @override
  String get google_challengeCancelled =>
      'បានបោះបង់ការផ្ទៀងផ្ទាត់។ អ្នកអាចព្យាយាមម្តងទៀតបាន។';

  @override
  String get google_challengeFailed =>
      'ការពិនិត្យសុវត្ថិភាពបានបរាជ័យ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get billing_trialTitle => 'សាកល្បង Fuze Premium ដោយឥតគិតថ្លៃ';

  @override
  String get billing_trialSubtitle =>
      'ការពារការតភ្ជាប់របស់អ្នកចាប់ពីថ្ងៃនេះតទៅ។';

  @override
  String get billing_trialWeeks => 'សាកល្បងឥតគិតថ្លៃ 2 សប្តាហ៍';

  @override
  String billing_trialDays(String days) {
    return 'សាកល្បងឥតគិតថ្លៃ $days ថ្ងៃ';
  }

  @override
  String get billing_trialStart => 'ចាប់ផ្តើមការសាកល្បងឥតគិតថ្លៃរបស់ខ្ញុំ';

  @override
  String billing_trialFirstCharge(String date) {
    return 'ប្រសិនបើអ្នកចាប់ផ្តើមថ្ងៃនេះ ការគិតប្រាក់លើកដំបូងរបស់អ្នកគ្រោងនឹងកើតឡើងនៅ $date។';
  }

  @override
  String get billing_trialTerms =>
      'បន្តដោយស្វ័យប្រវត្តិក្នុងតម្លៃដែលបានបញ្ជាក់។ ដើម្បីជៀសវាងការគិតប្រាក់ សូមបោះបង់នៅក្នុង Google Play មុនពេលការសាកល្បងបញ្ចប់។';

  @override
  String billing_trialThenMonthly(String price) {
    return 'បន្ទាប់មក $price ក្នុងមួយខែ';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'បន្ទាប់មក $price ក្នុងមួយឆ្នាំ';
  }

  @override
  String get billing_choosePeriod => 'ជ្រើសរើសគម្រោងរបស់អ្នក';

  @override
  String get billing_selectionHint => 'សូមជ្រើសរើសគម្រោង ដើម្បីបន្ត។';

  @override
  String get billing_benefitConnection => 'ការតភ្ជាប់ដែលបានអ៊ិនគ្រីប';

  @override
  String get billing_benefitPrivacy => 'ឯកជនភាពលើអ៊ីនធឺណិត';

  @override
  String get billing_benefitNoAccount => 'មិនចាំបាច់ចុះឈ្មោះ';

  @override
  String get billing_cancellation => 'បោះបង់នៅក្នុង Google Play';

  @override
  String get billing_premiumTitle => 'ការតភ្ជាប់ដែលបានការពារកាន់តែប្រសើរ។';

  @override
  String get billing_premiumSubtitle =>
      'ការពារការតភ្ជាប់របស់អ្នក តាមរបៀបដែលអ្នកចង់បាន។';

  @override
  String get billing_priceMonthly => 'ក្នុងមួយខែ';

  @override
  String get billing_priceYearly => 'ក្នុងមួយឆ្នាំ';

  @override
  String get billing_trialToday => 'មិនមានអ្វីត្រូវបង់ថ្ងៃនេះទេ';

  @override
  String get billing_trialConfirmation =>
      'Google Play បញ្ជាក់កាលបរិច្ឆេទ ចំនួនទឹកប្រាក់ចុងក្រោយ និងពន្ធដែលអនុវត្ត មុនពេលអ្នកបញ្ជាក់។';

  @override
  String get billing_offerChanged =>
      'លក្ខខណ្ឌនៃការផ្តល់ជូននេះបានផ្លាស់ប្តូរ។ សូមធ្វើបច្ចុប្បន្នភាពគម្រោង ហើយជ្រើសរើសម្តងទៀត។';

  @override
  String get status_waitingNetwork => 'កំពុងរង់ចាំបណ្តាញ';

  @override
  String get status_waitingNetworkDetail =>
      'គ្មានបណ្តាញទេ។ VPN នឹងផ្ទៀងផ្ទាត់ការតភ្ជាប់នៅពេលបណ្តាញត្រឡប់មកវិញ។';

  @override
  String get locations_favoriteLoadFailed =>
      'មិនអាចផ្ទុកចំណូលចិត្តបានទេ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get locations_favoritesLoading => 'កំពុងផ្ទុកចំណូលចិត្ត…';
}
