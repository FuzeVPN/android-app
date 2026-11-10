// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get vpnDisclosure_title => 'დაიცავით თქვენი კავშირი';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN იყენებს Android-ის VPN სერვისს (VpnService) ამ მოწყობილობასა და FuzeVPN სერვერებს შორის დაშიფრული გვირაბის შესაქმნელად.';

  @override
  String get vpnDisclosure_dataBody =>
      'როცა VPN აქტიურია, თქვენი აპების ინტერნეტ-ტრაფიკი, დანიშნულების მისამართები და DNS მოთხოვნები ამ გვირაბში გადის თქვენი კავშირის მარშრუტიზაციისთვის, მაშინაც კი, როცა FuzeVPN ფონურ რეჟიმში მუშაობს.';

  @override
  String get vpnDisclosure_statusBody =>
      'აპი იყენებს კავშირის სტატუსს, მის ხანგრძლივობასა და გადაცემული მონაცემების მოცულობას, რათა აჩვენოს თქვენი VPN კავშირი. მისი გათიშვა ნებისმიერ დროს შეგიძლიათ.';

  @override
  String get vpnDisclosure_privacy => 'კონფიდენციალურობა';

  @override
  String get vpnDisclosure_accept => 'მიღება და გაგრძელება';

  @override
  String get vpnDisclosure_decline => 'ახლა არა';

  @override
  String get accountRestoration_title => 'ანგარიში დროებით მიუწვდომელია';

  @override
  String get accountRestoration_message =>
      'თქვენი სესია შენარჩუნებულია. ანგარიშის აღსადგენად სცადეთ ხელახლა. VPN კავშირის მართვა აქაც შეგიძლიათ.';

  @override
  String get action_retry => 'ხელახლა ცდა';

  @override
  String get session_endingTitle => 'სესიის დასრულება';

  @override
  String get session_ending =>
      'სესია სრულდება: VPN ითიშება და მიმდინარეობს გასუფთავება…';

  @override
  String get session_stopFailed =>
      'VPN-ის გათიშვა არ დადასტურდა. ხელახლა შესვლამდე სცადეთ ისევ.';

  @override
  String get session_cleanupFailed =>
      'VPN გათიშულია, მაგრამ სესიის წაშლა არ დადასტურდა. სცადეთ გასუფთავება ხელახლა.';

  @override
  String get session_retryStop => 'გათიშვის ხელახლა ცდა';

  @override
  String get session_retryCleanup => 'გასუფთავების ხელახლა ცდა';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN უსაფრთხოდ მზადდება…';

  @override
  String get nav_connection => 'კავშირი';

  @override
  String get nav_locations => 'მდებარეობები';

  @override
  String get nav_account => 'ანგარიში';

  @override
  String get nav_devices => 'მოწყობილობები';

  @override
  String get nav_settings => 'პარამეტრები';

  @override
  String get action_refresh => 'განახლება';

  @override
  String get auth_tab_login => 'შესვლა';

  @override
  String get auth_tab_register => 'რეგისტრაცია';

  @override
  String get auth_stepAccount => 'ანგარიში';

  @override
  String get auth_stepIdentity => 'პირადი მონაცემები';

  @override
  String get auth_stepAddress => 'მისამართი და შეთანხმებები';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'ნაბიჯი $current $total-დან';
  }

  @override
  String get auth_tagline => 'თქვენი VPN, მარტივად.';

  @override
  String get auth_keysLocal =>
      'თქვენი პირადი VPN გასაღებები ამ მოწყობილობაზე რჩება.';

  @override
  String get form_email => 'ელფოსტის მისამართი';

  @override
  String get form_password => 'პაროლი';

  @override
  String get form_showPassword => 'პაროლის ჩვენება';

  @override
  String get form_hidePassword => 'პაროლის დამალვა';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 ბაიტი. ზოგიერთი სიმბოლო ერთზე მეტ ბაიტს იკავებს.';

  @override
  String get form_firstName => 'სახელი';

  @override
  String get form_lastName => 'გვარი';

  @override
  String get form_phone => 'ტელეფონი (+33612345678)';

  @override
  String get form_address => 'მისამართი';

  @override
  String get form_address2 => 'მისამართის მე-2 სტრიქონი (არასავალდებულო)';

  @override
  String get form_postalCode => 'საფოსტო ინდექსი';

  @override
  String get form_city => 'ქალაქი';

  @override
  String get form_country => 'ქვეყნის კოდი (მაგ. FR)';

  @override
  String get action_login => 'შესვლა';

  @override
  String get action_createAccount => 'ანგარიშის შექმნა';

  @override
  String get action_createMyAccount => 'ჩემი ანგარიშის შექმნა';

  @override
  String get action_next => 'გაგრძელება';

  @override
  String get action_previous => 'უკან';

  @override
  String get action_forgotPassword => 'დაგავიწყდათ პაროლი?';

  @override
  String get auth_noAccount => 'ჯერ არ გაქვთ ანგარიში?';

  @override
  String get auth_requiredInformation => 'შექმენით ანგარიში სამ ნაბიჯში.';

  @override
  String get auth_termsPrefix => 'ვეთანხმები ';

  @override
  String get auth_termsLink => 'გამოყენების პირობებს';

  @override
  String get auth_privacyPrefix => 'ვეთანხმები ';

  @override
  String get auth_privacyLink => 'კონფიდენციალურობის პოლიტიკას';

  @override
  String get auth_consentRequired =>
      'ანგარიშის შესაქმნელად თქვენი თანხმობაა საჭირო.';

  @override
  String get validation_required => 'ეს ველი სავალდებულოა.';

  @override
  String get validation_email => 'შეიყვანეთ სწორი ელფოსტის მისამართი.';

  @override
  String get validation_password =>
      'პაროლი ძალიან მოკლეა: მინიმუმ 8 UTF-8 ბაიტი.';

  @override
  String get validation_passwordTooLong =>
      'პაროლი ძალიან გრძელია: მაქსიმუმ 72 UTF-8 ბაიტი.';

  @override
  String get validation_phone =>
      'გამოიყენეთ საერთაშორისო ფორმატი, მაგალითად +33612345678.';

  @override
  String get validation_country =>
      'გამოიყენეთ ორასოიანი ქვეყნის კოდი, მაგალითად FR.';

  @override
  String get passwordReset_title => 'პაროლის აღდგენა';

  @override
  String get passwordReset_description =>
      'შეიყვანეთ თქვენი ანგარიშის ელფოსტის მისამართი პაროლის აღდგენის ბმულის მოსათხოვნად.';

  @override
  String get passwordReset_send => 'ბმულის გაგზავნა';

  @override
  String get connection_title => 'თქვენი კავშირი';

  @override
  String get connection_subtitle => 'აირჩიეთ მდებარეობა და შემდეგ ჩართეთ VPN.';

  @override
  String get connection_prepare => 'მზად ხართ დასაკავშირებლად?';

  @override
  String get connection_advancedOptions => 'დამატებითი პარამეტრები';

  @override
  String get connection_location => 'მდებარეობა';

  @override
  String get connection_chooseLocation => 'აირჩიეთ მდებარეობა';

  @override
  String get connection_protocol => 'პროტოკოლი';

  @override
  String get connection_connect => 'დაკავშირება';

  @override
  String get connection_connecting => 'მიმდინარეობს დაკავშირება…';

  @override
  String get connection_disconnect => 'გათიშვა';

  @override
  String get connection_disconnecting => 'მიმდინარეობს გათიშვა';

  @override
  String get connection_locationChange => 'მიმდინარეობს მდებარეობის შეცვლა…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol მიუწვდომელია';
  }

  @override
  String get connection_activeLocation => 'აქტიური მდებარეობა';

  @override
  String get connection_duration => 'ხანგრძლივობა';

  @override
  String get connection_received => 'მიღებული';

  @override
  String get connection_sent => 'გაგზავნილი';

  @override
  String get connection_lastHandshake => 'ბოლო უსაფრთხო გაცვლა';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration წინ';
  }

  @override
  String get verification_title => 'დაადასტურეთ თქვენი ელფოსტის მისამართი';

  @override
  String get verification_message =>
      'დაადასტურეთ თქვენი ელფოსტის მისამართი, რათა ამ ტელეფონზე VPN გამოიყენოთ.';

  @override
  String get verification_resend => 'ელფოსტის ხელახლა გაგზავნა';

  @override
  String get migration_title => 'მდებარეობის შეცვლა';

  @override
  String get migration_draining => 'მდებარეობის შეცვლის მომზადება…';

  @override
  String get migration_activating => 'ახალი სერვერის გააქტიურება…';

  @override
  String get migration_ready => 'მდებარეობა განახლდა.';

  @override
  String get migration_blocked =>
      'მდებარეობის შეცვლა სერვერის ჩარევას მოითხოვს. სცადეთ მოგვიანებით ან დაუკავშირდით მხარდაჭერას.';

  @override
  String get migration_progress => 'მდებარეობის შეცვლის პროგრესი';

  @override
  String migration_retryDelay(Object seconds) {
    return 'შემოწმებებს შორის დაყოვნება: $seconds წმ.';
  }

  @override
  String get migration_resume => 'მდებარეობის შეცვლის გაგრძელება';

  @override
  String get status_authorizing => 'საჭიროა ნებართვა';

  @override
  String get status_authorizingDetail =>
      'VPN-ის დასაშვებად დაეთანხმეთ Android-ის მოთხოვნას.';

  @override
  String get status_preparing => 'მომზადება';

  @override
  String get status_preparingDetail => 'თქვენი უსაფრთხო კავშირი მზადდება.';

  @override
  String get status_reconnecting => 'ხელახლა დაკავშირება…';

  @override
  String get status_reconnectingDetail =>
      'კავშირი შეწყდა. VPN ხელახლა დაკავშირებას ცდილობს.';

  @override
  String get status_connecting => 'მიმდინარეობს დაკავშირება';

  @override
  String get status_connectingDetail =>
      'მიმდინარეობს დაკავშირება VPN სერვერთან…';

  @override
  String get status_connected => 'დაკავშირებულია';

  @override
  String get status_connectedDetail => 'თქვენი VPN კავშირი აქტიურია.';

  @override
  String get status_disconnecting => 'მიმდინარეობს გათიშვა';

  @override
  String get status_disconnectingDetail => 'თქვენი VPN კავშირი ითიშება.';

  @override
  String get status_error => 'კავშირი მიუწვდომელია';

  @override
  String get status_errorDetail =>
      'VPN კავშირი დადასტურებული არ არის. სცადეთ ხელახლა.';

  @override
  String get status_idle => 'გათიშულია';

  @override
  String get status_idleDetail => 'ჩართეთ VPN, რომ დაიცვათ თქვენი კავშირი.';

  @override
  String get trust_note =>
      'აპის დახურვა VPN-ს არ გათიშავს. მის გასათიშად გამოიყენეთ „გათიშვა“.';

  @override
  String get locations_none => 'ამჟამად მდებარეობები ხელმისაწვდომი არ არის.';

  @override
  String get locations_available => 'აირჩიეთ შემდეგი მდებარეობა.';

  @override
  String get locations_selected => 'არჩეული მდებარეობა';

  @override
  String get locations_select => 'ამ მდებარეობის არჩევა';

  @override
  String get locations_lockedTunnel => 'მდებარეობის შესაცვლელად გათიშეთ VPN.';

  @override
  String get locations_lockedMigration =>
      'დაელოდეთ მდებარეობის შეცვლის დასრულებას.';

  @override
  String get devices_title => 'თქვენი მოწყობილობები';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit მოწყობილობა';
  }

  @override
  String get devices_refresh => 'მოწყობილობების განახლება';

  @override
  String get devices_empty => 'VPN მოწყობილობა ჯერ არ არის რეგისტრირებული.';

  @override
  String get devices_firstConnection =>
      'თქვენი ტელეფონი პირველი კავშირისას დაემატება.';

  @override
  String get devices_thisDevice => 'ეს მოწყობილობა';

  @override
  String devices_added(Object date) {
    return 'დამატებულია: $date';
  }

  @override
  String get devices_unnamed => 'უსახელო მოწყობილობა';

  @override
  String get action_remove => 'წაშლა';

  @override
  String get settings_title => 'პარამეტრები';

  @override
  String get settings_subtitle => 'თქვენი პარამეტრები და ანგარიში ერთ ადგილას.';

  @override
  String get settings_appearance => 'გარეგნობა';

  @override
  String get settings_language => 'ენა';

  @override
  String get settings_languageDescription =>
      'არჩეული ენა VPN შეტყობინებებზეც გავრცელდება.';

  @override
  String get settings_account => 'ანგარიში';

  @override
  String get settings_signOut => 'გასვლა';

  @override
  String get settings_privacy => 'კონფიდენციალურობის პოლიტიკა';

  @override
  String get settings_terms => 'გამოყენების პირობები';

  @override
  String get settings_security => 'უსაფრთხოება და გამჭვირვალობა';

  @override
  String get settings_licenses => 'კომპონენტების ლიცენზიები';

  @override
  String get settings_licensesDetail =>
      'აპში გამოყენებული პროგრამული უზრუნველყოფა';

  @override
  String settings_licensesLegalese(String url) {
    return 'აპისა და მისი MPL-2.0 კომპონენტების საწყისი კოდი: $url';
  }

  @override
  String get settings_background =>
      'VPN ჩართული რჩება, როცა აპიდან გახვალთ. მის გასათიშად გამოიყენეთ „გათიშვა“ ჩანართში „კავშირი“.';

  @override
  String get theme_system => 'სისტემური';

  @override
  String get theme_light => 'ნათელი';

  @override
  String get theme_dark => 'მუქი';

  @override
  String get language_system => 'ტელეფონის ენა';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'წაიშალოს ეს მოწყობილობა?';

  @override
  String get dialog_removeCurrent =>
      'ეს ტელეფონი VPN-იდან გაითიშება და წვდომას დაკარგავს. მისი VPN კავშირის მონაცემები სერვერის დადასტურების შემდეგ წაიშლება.';

  @override
  String dialog_removeOther(Object name) {
    return '„$name“ მოწყობილობას VPN წვდომა ჩამოერთმევა. ამ მოქმედების გაუქმება შეუძლებელია.';
  }

  @override
  String get dialog_signOut => 'ანგარიშიდან გასვლა?';

  @override
  String get dialog_signOutMessage =>
      'VPN გაითიშება და ხელახლა შესვლა მოგიწევთ. თქვენი დაშიფრული VPN გასაღებები ამ ტელეფონზე შენარჩუნდება შემდეგი კავშირისთვის.';

  @override
  String get action_cancel => 'გაუქმება';

  @override
  String get action_close => 'დახურვა';

  @override
  String get action_copy => 'კოპირება';

  @override
  String get action_signOut => 'გასვლა';

  @override
  String get notice_close => 'შეტყობინების დახურვა';

  @override
  String get notice_sessionExpired_title => 'სესიის ვადა ამოიწურა';

  @override
  String get notice_sessionExpired_message =>
      'თქვენი სესიის ვადა ამოიწურა. ხელახლა შედით ანგარიშში.';

  @override
  String get notice_connectionFailed_title => 'კავშირი ვერ დამყარდა';

  @override
  String get notice_invalidCredentials_message =>
      'ელფოსტის მისამართი ან პაროლი არასწორია.';

  @override
  String get notice_emailVerification_title => 'საჭიროა ელფოსტის დადასტურება';

  @override
  String get notice_emailVerification_message =>
      'VPN მოწყობილობის დამატებამდე დაადასტურეთ თქვენი ელფოსტის მისამართი.';

  @override
  String get notice_rateLimited_title => 'ძალიან ბევრი მცდელობა';

  @override
  String get notice_deviceLimit_title => 'მოწყობილობების ლიმიტი ამოიწურა';

  @override
  String get notice_deviceLimit_message =>
      'სხვა მოწყობილობის დამატებამდე წაშალეთ არსებული მოწყობილობა.';

  @override
  String get notice_identityRenewal_title => 'VPN-ის იდენტობა უნდა განახლდეს';

  @override
  String get notice_identityRenewal_message =>
      'ეს იდენტობა წაიშალა. შექმენით ახალი ლოკალური იდენტობა.';

  @override
  String get notice_migrationPending_title => 'მდებარეობის შეცვლა მიმდინარეობს';

  @override
  String get notice_migrationPending_message =>
      'მდებარეობის შეცვლა უკვე მიმდინარეობს.';

  @override
  String get notice_migrationBlocked_title => 'მდებარეობის შეცვლა დაბლოკილია';

  @override
  String get notice_migrationBlocked_message =>
      'მდებარეობის შეცვლა სერვერის ჩარევას მოითხოვს. სცადეთ მოგვიანებით ან დაუკავშირდით მხარდაჭერას.';

  @override
  String get notice_targetUnavailable_title => 'სერვერი დროებით მიუწვდომელია';

  @override
  String get notice_targetUnavailable_message =>
      'ეს სერვერი დროებით მიუწვდომელია.';

  @override
  String get notice_networkUnavailable_title => 'ინტერნეტ-კავშირი მიუწვდომელია';

  @override
  String get notice_networkUnavailable_message =>
      'შეამოწმეთ კავშირი და სცადეთ ხელახლა.';

  @override
  String get notice_permissionDenied_title => 'VPN-ის ნებართვა უარყოფილია';

  @override
  String get notice_permissionDenied_message =>
      'ხელახლა დაიწყეთ კავშირი და დაადასტურეთ Android-ის ნებართვის მოთხოვნა.';

  @override
  String get notice_wireguardTimeout_title => 'სერვერი არ პასუხობს';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard კავშირის დამყარებას ზედმეტად დიდი დრო დასჭირდა. სცადეთ ხელახლა ან აირჩიეთ სხვა მდებარეობა.';

  @override
  String get notice_tlsFailed_title => 'უსაფრთხო კავშირი უარყოფილია';

  @override
  String get notice_tlsFailed_message =>
      'სერვერმა არ მიიღო OpenVPN კავშირი. სცადეთ ხელახლა. თუ პრობლემა გრძელდება, გაუშვით დიაგნოსტიკა.';

  @override
  String get notice_tunRejected_title => 'Android-მა VPN ინტერფეისი უარყო';

  @override
  String get notice_tunRejected_message =>
      'Android-მა უარყო OpenVPN-ის მიერ მოთხოვნილი ქსელის კონფიგურაცია.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN-ის გაშვება ვერ მოხერხდა';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN-ის ძრავის გაშვება ბოლომდე ვერ დასრულდა. სცადეთ ხელახლა. თუ პრობლემა გრძელდება, დაუკავშირდით მხარდაჭერას.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'დიაგნოსტიკის კოდი: $code';
  }

  @override
  String get notice_generic_title => 'VPN კავშირი ვერ დამყარდა';

  @override
  String get notice_generic_message => 'მოხდა შეცდომა. სცადეთ მოგვიანებით.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'ანგარიში შეიქმნა',
      'password_reset_sent': 'პაროლის აღდგენის მოთხოვნა მიღებულია',
      'verification_email_sent': 'დადასტურების ელფოსტა გაიგზავნა',
      'location_migration_pending': 'მდებარეობის შეცვლა მიმდინარეობს',
      'vpn_sign_in_required': 'საჭიროა შესვლა',
      'protocol_unavailable_at_location': 'პროტოკოლი მიუწვდომელია',
      'vpn_permission_denied': 'VPN-ის ნებართვა უარყოფილია',
      'revoked_identity_device_limit': 'მოწყობილობების ლიმიტი ამოიწურა',
      'tunnel_start_unexpected': 'VPN-ის გაშვება ვერ მოხერხდა',
      'flutter_disconnect_timeout': 'გათიშვა არ არის დადასტურებული',
      'flutter_disconnect_unexpected': 'გათიშვა ვერ მოხერხდა',
      'device_revoked': 'მოწყობილობა წაიშალა',
      'revoke_unexpected': 'მოწყობილობის წაშლა ვერ მოხერხდა',
      'identity_renewal_unexpected': 'იდენტობის განახლება ვერ მოხერხდა',
      'openvpn_renewal_unexpected': 'OpenVPN-ის განახლება ვერ მოხერხდა',
      'location_migration_blocked': 'მდებარეობის შეცვლა დაბლოკილია',
      'location_migration_slow': 'მდებარეობის შეცვლა კვლავ მიმდინარეობს',
      'location_migration_conflict': 'მდებარეობის შეცვლას განახლება სჭირდება',
      'location_migration_verification_failed':
          'მდებარეობის შეცვლა დადასტურებული არ არის',
      'location_migration_device_changed':
          'მოწყობილობა შეიცვალა მდებარეობის შეცვლისას',
      'tunnel_stop_failed': 'მდებარეობის შეცვლა მიუწვდომელია',
      'device_clock_ahead': 'მოწყობილობის საათი წინ უსწრებს',
      'other': 'ოპერაცია ვერ შესრულდა',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'ანგარიში შეიქმნა, მაგრამ დადასტურების ელფოსტის გაგზავნა ვერ მოხერხდა. აპში გამოიყენეთ ხელახლა გაგზავნის ფუნქცია.',
      'password_reset_sent':
          'თქვენი მოთხოვნა მიღებულია. თუ ამ მისამართით ანგარიში არსებობს, შესაძლოა ელფოსტა მიიღოთ. გთხოვთ, ასევე შეამოწმოთ სპამის საქაღალდე.',
      'verification_email_sent':
          'ახალი დადასტურების ელფოსტა ახლახან გაიგზავნა.',
      'location_migration_pending':
          'მდებარეობაზე „$target“ გადასვლა ჯერ კიდევ მზადდება. შეგიძლიათ გააგრძელოთ ის მოწყობილობის ხელახლა შექმნის გარეშე.',
      'vpn_sign_in_required': 'VPN-ის დაწყებამდე შედით თქვენს ანგარიშში.',
      'protocol_unavailable_at_location':
          'ამ მდებარეობაზე არჩეული პროტოკოლი ხელმისაწვდომი არ არის. განაახლეთ მდებარეობები ან აირჩიეთ სხვა პროტოკოლი.',
      'vpn_permission_denied':
          'Android-მა VPN-ის ნებართვა უარყო. ხელახლა დაიწყეთ კავშირი და დაადასტურეთ სისტემური მოთხოვნა.',
      'revoked_identity_device_limit':
          'ამ მოწყობილობის VPN წვდომა წაიშალა და მოწყობილობების ლიმიტი ამოიწურა. წაშალეთ მოწყობილობა აქ: ანგარიში → ჩემი მოწყობილობების მართვა.',
      'tunnel_start_unexpected':
          'გვირაბის მომზადება მოულოდნელი შეცდომის გამო შეწყდა. შეამოწმეთ დიაგნოსტიკის კოდი და სცადეთ ხელახლა.',
      'flutter_disconnect_timeout':
          'Android-მა დროულად ვერ დაადასტურა VPN-ის გათიშვა. სცადეთ გათიშვა ხელახლა.',
      'flutter_disconnect_unexpected':
          'მოულოდნელი შეცდომის გამო გვირაბის გათიშვა ვერ დადასტურდა.',
      'device_revoked':
          'მოწყობილობის VPN წვდომა გაუქმდა და მისი ლოკალური საიდუმლო მონაცემები წაიშალა.',
      'revoke_unexpected':
          'მოწყობილობის წაშლა ვერ მოხერხდა. განაახლეთ სია და სცადეთ ხელახლა.',
      'identity_renewal_unexpected':
          'ახალი VPN იდენტობის შექმნა ვერ მოხერხდა. განაახლეთ მოწყობილობები და სცადეთ ხელახლა.',
      'openvpn_renewal_unexpected':
          'OpenVPN-ის პროფილის განახლება ვერ მოხერხდა. სცადეთ ხელახლა ან შეამოწმეთ დიაგნოსტიკის კოდი.',
      'location_migration_blocked':
          'სერვერს ამ ცვლილების დასრულება ამჟამად არ შეუძლია. მოწყობილობა და მისი ლოკალური იდენტობა შენარჩუნდა.',
      'location_migration_slow':
          'სერვერი ჯერ კიდევ ამზადებს გადასვლას მდებარეობაზე „$target“. ცოტა ხანში გამოიყენეთ „გაგრძელება“.',
      'location_migration_conflict':
          'მოწყობილობის მდგომარეობა სერვერზე შეიცვალა. განაახლეთ მოწყობილობები და შემდეგ გააგრძელეთ ცვლილება.',
      'location_migration_verification_failed':
          'სერვერმა ახალი მდებარეობა ვერ დაადასტურა. წინა ლოკალური იდენტობა შენარჩუნდა.',
      'location_migration_device_changed':
          'სერვერის მიერ დაბრუნებული მოწყობილობა აღარ შეესაბამება შესაცვლელ მოწყობილობას. განაახლეთ მოწყობილობები და სცადეთ ხელახლა.',
      'tunnel_stop_failed':
          'ახალ კავშირამდე წინა გვირაბი სრულად უნდა გაითიშოს.',
      'device_clock_ahead':
          'ამ მოწყობილობის საათი, როგორც ჩანს, წინ უსწრებს. ანგარიშში შესული რომ დარჩეთ, ჩართეთ ავტომატური თარიღი და დრო.',
      'other':
          'ოპერაციის დასრულება ვერ მოხერხდა. სცადეთ ხელახლა ან გაუგზავნეთ დიაგნოსტიკის კოდი მხარდაჭერას.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'სესიის ვადა ამოიწურა',
      'invalid_credentials': 'შესვლა ვერ მოხერხდა',
      'email_verification_required': 'საჭიროა ელფოსტის დადასტურება',
      'verification_email_cooldown': 'ელფოსტა უკვე გაიგზავნა',
      'rate_limited': 'ძალიან ბევრი მცდელობა',
      'invalid_registration': 'საჭიროა ინფორმაციის შესწორება',
      'email_exists': 'ანგარიში უკვე არსებობს',
      'invalid_profile': 'არასწორი პროფილი',
      'invalid_device': 'არასწორი მოწყობილობა',
      'invalid_location': 'მდებარეობა მიუწვდომელია',
      'device_limit': 'მოწყობილობების ლიმიტი ამოიწურა',
      'device_exists': 'VPN-ის იდენტობა უკვე გამოიყენება',
      'device_identity_revoked': 'VPN-ის იდენტობა უნდა განახლდეს',
      'device_location_locked': 'მდებარეობის შეცვლას განახლება სჭირდება',
      'location_migration_pending': 'მდებარეობის შეცვლა მიმდინარეობს',
      'location_migration_blocked': 'მდებარეობის შეცვლა დაბლოკილია',
      'target_ca_mismatch': 'OpenVPN სერვერი შეუთავსებელია',
      'location_migration_conflict': 'მდებარეობის შეცვლას განახლება სჭირდება',
      'server_full': 'სერვერი სავსეა',
      'capacity_unavailable': 'მდებარეობა დროებით მიუწვდომელია',
      'target_unavailable': 'სერვერი დროებით მიუწვდომელია',
      'not_found': 'ელემენტი ვერ მოიძებნა',
      'invalid_openvpn_csr': 'არასწორი OpenVPN იდენტობა',
      'openvpn_profile_exists': 'OpenVPN პროფილი უკვე არსებობს',
      'openvpn_profile_revoked': 'OpenVPN პროფილი გაუქმებულია',
      'openvpn_operation_pending': 'OpenVPN ოპერაცია მიმდინარეობს',
      'openvpn_operation_terminal': 'OpenVPN ოპერაცია შეწყდა',
      'openvpn_address_unavailable': 'OpenVPN მისამართი მიუწვდომელია',
      'openvpn_profile_conflict': 'OpenVPN კონფლიქტი',
      'openvpn_signer_unavailable': 'OpenVPN მიუწვდომელია',
      'email_delivery_unavailable': 'ელფოსტა მიუწვდომელია',
      'invalid_token': 'არასწორი ბმული',
      'network_unavailable': 'ინტერნეტ-კავშირი მიუწვდომელია',
      'invalid_json': 'არასწორი მოთხოვნა',
      'invalid_api_response': 'სერვერის არასწორი პასუხი',
      'ipv6_unavailable': 'IPv6 მიუწვდომელია',
      'invalid_ip_families': 'ქსელის კონფიგურაცია უარყოფილია',
      'other': 'სერვისი მიუწვდომელია',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'თქვენი სესიის ვადა ამოიწურა. ხელახლა შედით ანგარიშში.',
      'invalid_credentials': 'ელფოსტის მისამართი ან პაროლი არასწორია.',
      'email_verification_required':
          'VPN მოწყობილობის დამატებამდე დაადასტურეთ თქვენი ელფოსტის მისამართი.',
      'invalid_registration': 'შეამოწმეთ მოთხოვნილი ინფორმაცია და თანხმობები.',
      'email_exists': 'ამ ელფოსტის მისამართით ანგარიში უკვე არსებობს.',
      'invalid_profile': 'შეამოწმეთ თქვენი პროფილის ინფორმაცია.',
      'invalid_device':
          'ამ მოწყობილობის სახელი ან ლოკალური იდენტობა არასწორია.',
      'invalid_location': 'განაახლეთ მდებარეობების სია და ხელახლა სცადეთ.',
      'device_limit':
          'ახალი მოწყობილობის დამატებამდე წაშალეთ არსებული მოწყობილობა.',
      'device_exists': 'ეს VPN იდენტობა უკვე მიბმულია სხვა ანგარიშზე.',
      'device_identity_revoked':
          'ეს იდენტობა წაიშალა. საჭიროა ახალი ლოკალური იდენტობის შექმნა.',
      'device_location_locked':
          'ამ მოწყობილობის მდებარეობა ახლახან შეიცვალა. აპი გააგრძელებს მიმდინარე ცვლილებას.',
      'location_migration_pending': 'მდებარეობის შეცვლა უკვე მიმდინარეობს.',
      'location_migration_blocked':
          'მდებარეობის შეცვლას სერვერის ჩარევა სჭირდება. სცადეთ მოგვიანებით ან დაუკავშირდით მხარდაჭერას.',
      'target_ca_mismatch':
          'ეს სერვერი ჯერ არ არის თავსებადი მიმდინარე OpenVPN პროფილთან.',
      'location_migration_conflict':
          'განაახლეთ მოწყობილობები და ხელახლა სცადეთ მდებარეობის შეცვლა.',
      'server_full':
          'ამ მდებარეობამ კავშირების ლიმიტს მიაღწია. აირჩიეთ სხვა მდებარეობა ან სცადეთ მოგვიანებით.',
      'capacity_unavailable':
          'ვერ ვადასტურებთ, არის თუ არა ეს მდებარეობა ახლა ხელმისაწვდომი. აირჩიეთ სხვა მდებარეობა ან სცადეთ მოგვიანებით.',
      'target_unavailable': 'ეს სერვერი დროებით მიუწვდომელია.',
      'not_found': 'ეს ელემენტი თქვენს ანგარიშზე აღარ არის ხელმისაწვდომი.',
      'invalid_openvpn_csr':
          'შექმენით ახალი OpenVPN იდენტობა და ხელახლა სცადეთ.',
      'openvpn_profile_exists':
          'ამ მოწყობილობისთვის OpenVPN პროფილი უკვე არსებობს.',
      'openvpn_profile_revoked': 'გასაგრძელებლად განაახლეთ OpenVPN პროფილი.',
      'openvpn_operation_pending':
          'ცვლილება ჯერ კიდევ ვრცელდება. სცადეთ მოგვიანებით.',
      'openvpn_operation_terminal':
          'შექმენით ახალი OpenVPN იდენტობა და ხელახლა სცადეთ.',
      'openvpn_address_unavailable':
          'ამჟამად OpenVPN მისამართი ხელმისაწვდომი არ არის.',
      'openvpn_profile_conflict':
          'პროფილი შეიცვალა. განაახლეთ მოწყობილობები და ხელახლა სცადეთ.',
      'openvpn_signer_unavailable': 'OpenVPN სერვისი დროებით მიუწვდომელია.',
      'email_delivery_unavailable':
          'ელფოსტა ვერ გაიგზავნა. სცადეთ მოგვიანებით.',
      'invalid_token':
          'ეს ბმული არასწორია ან მისი ვადა ამოიწურა. მოითხოვეთ ახალი.',
      'network_unavailable': 'შეამოწმეთ ინტერნეტ-კავშირი და სცადეთ ხელახლა.',
      'invalid_json': 'შეამოწმეთ შეყვანილი ინფორმაცია და ხელახლა სცადეთ.',
      'invalid_api_response':
          'სერვერმა მოულოდნელი პასუხი დააბრუნა. სცადეთ მოგვიანებით.',
      'ipv6_unavailable':
          'სერვერს ამჟამად IPv6-ის გააქტიურება არ შეუძლია. სცადეთ მოგვიანებით.',
      'invalid_ip_families':
          'გვირაბის კონფიგურაცია არასრულია ან არ შეესაბამება ნებადართულ მისამართებს. სცადეთ აპიდან ხელახლა.',
      'other': 'მოხდა სერვერის შეცდომა. სცადეთ მოგვიანებით.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'ცოტა ხანში ხელახლა სცადეთ.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds წამში ხელახლა სცადეთ.',
      one: '$seconds წამში ხელახლა სცადეთ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes წუთში ხელახლა სცადეთ.',
      one: '$minutes წუთში ხელახლა სცადეთ.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours საათში ხელახლა სცადეთ.',
      one: '$hours საათში ხელახლა სცადეთ.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'სისტემური VPN-ის გაგრძელება მიუწვდომელია',
      'system_vpn_resume_corrupt': 'სისტემური VPN-ის გაგრძელება არასწორია',
      'system_vpn_resume_session_invalid': 'VPN-ის გაგრძელების სესია არასწორია',
      'system_vpn_resume_identity_changed': 'VPN-ის იდენტობა შეიცვალა',
      'system_vpn_resume_identity_invalid':
          'VPN-ის გაგრძელების იდენტობა არასწორია',
      'system_vpn_resume_storage_failed':
          'VPN-ის გაგრძელების საცავი მიუწვდომელია',
      'system_vpn_resume_network_timeout':
          'VPN-ის გასაგრძელებლად ქსელი არ არის',
      'system_vpn_resume_blocked': 'VPN-ის გაგრძელება დაბლოკილია',
      'system_vpn_resume_failed': 'VPN-ის გაგრძელება ვერ მოხერხდა',
      'system_vpn_resume_error_invalid': 'VPN-ის გაგრძელების შეცდომა არასწორია',
      'wireguard_identity_store_failed': 'WireGuard-ის იდენტობა ვერ შეინახა',
      'wireguard_identity_unavailable': 'WireGuard-ის იდენტობა მიუწვდომელია',
      'vpn_host_destroyed': 'Android-ის VPN მასპინძელი გაჩერდა',
      'vpn_host_unavailable': 'Android-ის VPN მასპინძელი მიუწვდომელია',
      'vpn_permission_required': 'VPN-ის ნებართვა საჭიროა',
      'vpn_permission_denied': 'VPN-ის ნებართვა უარყოფილია',
      'vpn_permission_request_failed': 'ნებართვის მოთხოვნა ვერ მოხერხდა',
      'wireguard_foreground_service_unavailable':
          'WireGuard-ის სერვისი მიუწვდომელია',
      'wireguard_identity_invalid': 'ლოკალური WireGuard გასაღები არასწორია',
      'wireguard_identity_in_use': 'WireGuard-ის იდენტობა უკვე გამოიყენება',
      'wireguard_configuration_invalid': 'WireGuard-ის კონფიგურაცია არასწორია',
      'wireguard_operation_pending': 'WireGuard-ის ოპერაცია ჯერ კიდევ აქტიურია',
      'wireguard_start_failed': 'WireGuard-ის გაშვება უარყოფილია',
      'wireguard_stop_timeout': 'WireGuard-ის გათიშვა არ დადასტურდა',
      'wireguard_handshake_timeout': 'WireGuard არ უპასუხა',
      'openvpn_connection_timeout': 'OpenVPN არ უპასუხა',
      'openvpn_core_unavailable': 'OpenVPN-ის ძრავა მიუწვდომელია',
      'openvpn_operation_pending': 'OpenVPN-ის სესია ჯერ კიდევ აქტიურია',
      'openvpn_stop_timeout': 'OpenVPN-ის გათიშვა არ დადასტურდა',
      'openvpn_profile_unavailable': 'ლოკალური OpenVPN პროფილი ვერ მოიძებნა',
      'openvpn_native_failed': 'OpenVPN-ის ნატიური გამოძახება შეწყდა',
      'openvpn_key_generation_failed':
          'OpenVPN-ის P-256 გასაღების შექმნა ვერ მოხერხდა',
      'openvpn_csr_generation_failed': 'OpenVPN-ის CSR-ის შექმნა ვერ მოხერხდა',
      'openvpn_identity_store_failed': 'OpenVPN-ის იდენტობა ვერ შეინახა',
      'openvpn_identity_clear_failed': 'OpenVPN-ის იდენტობის წაშლა არასრულია',
      'openvpn_identity_in_use': 'OpenVPN-ის იდენტობა ჯერ კიდევ გამოიყენება',
      'openvpn_tls_verification_required':
          'OpenVPN-ის TLS გადამოწმება არ არის მითითებული',
      'openvpn_cipher_invalid': 'OpenVPN-ის შიფრი არასწორია',
      'openvpn_profile_rejected': 'OpenVPN-ის პროფილი უარყოფილია',
      'openvpn_identity_inconsistent': 'OpenVPN-ის იდენტობა არათანმიმდევრულია',
      'tls_handshake_failed': 'OpenVPN-ის მოლაპარაკება უარყოფილია',
      'tls_alert_unknown_ca': 'OpenVPN-ის კლიენტის სერტიფიკატი ამოუცნობია',
      'tls_alert_bad_certificate': 'OpenVPN-ის კლიენტის სერტიფიკატი უარყოფილია',
      'tls_alert_unsupported_certificate':
          'OpenVPN-ის სერტიფიკატი მხარდაუჭერელია',
      'tls_client_certificate_required':
          'OpenVPN-ის კლიენტის სერტიფიკატი საჭიროა',
      'tls_alert_misc': 'OpenVPN-ის TLS-ის გაფრთხილება',
      'tls_signature_algorithm_rejected': 'OpenVPN-ის ხელმოწერა მხარდაუჭერელია',
      'tls_handshake_rejected': 'OpenVPN-ის TLS-ის მოლაპარაკება უარყოფილია',
      'tls_version_rejected': 'OpenVPN-ის TLS-ის ვერსია შეუთავსებელია',
      'tls_certificate_expired': 'TLS სერტიფიკატის ვადა ამოიწურა',
      'tls_certificate_revoked': 'TLS სერტიფიკატი გაუქმებულია',
      'transport_failed': 'OpenVPN-ის სერვერი მიუწვდომელია',
      'tun_configuration_rejected':
          'OpenVPN-ის ინტერფეისის შექმნა ვერ მოხერხდა',
      'tun_setup_failed': 'OpenVPN-ის TUN-ის დაყენება ვერ მოხერხდა',
      'tun_interface_create_failed':
          'OpenVPN-ის ინტერფეისის შექმნა ვერ მოხერხდა',
      'tun_interface_disabled': 'OpenVPN-ის ინტერფეისი გამორთულია',
      'tun_halted': 'OpenVPN-ის ინტერფეისი შეწყდა',
      'tun_already_established': 'OpenVPN-ის ინტერფეისი უკვე გახსნილია',
      'tun_addresses_missing': 'OpenVPN-ის მისამართი აკლია',
      'tun_routes_missing': 'OpenVPN-ის მარშრუტები აკლია',
      'tun_dns_missing': 'OpenVPN-ის DNS აკლია',
      'tun_permission_revoked': 'VPN-ის ნებართვა გაუქმდა',
      'tun_establish_returned_null': 'Android-მა VPN-ის ინტერფეისი უარყო',
      'openvpn_service_start_failed': 'OpenVPN-ის სერვისი მიუწვდომელია',
      'openvpn_operation_timeout': 'OpenVPN-ის გამოძახების დრო ამოიწურა',
      'openvpn_start_failed': 'OpenVPN-ის გაშვება უარყოფილია',
      'openvpn_connection_failed': 'OpenVPN-ის კავშირი შეწყდა',
      'openvpn_core_status_error': 'OpenVPN Core შეცდომით დასრულდა',
      'openvpn_stopped_before_connected': 'OpenVPN შეჩერდა დაკავშირებამდე',
      'openvpn_auth_failed': 'OpenVPN-ის ავთენტიფიკაცია უარყოფილია',
      'openvpn_client_setup_failed':
          'OpenVPN-ის კლიენტის დაყენება ვერ მოხერხდა',
      'openvpn_client_halted': 'OpenVPN-ის კლიენტი შეწყდა',
      'openvpn_client_restart': 'OpenVPN-ის გადატვირთვა მოთხოვნილია',
      'openvpn_inactive_timeout': 'OpenVPN ძალიან დიდხანს უმოქმედო იყო',
      'openvpn_session_expired': 'OpenVPN-ის სესიის ვადა ამოიწურა',
      'openvpn_credentials_required':
          'OpenVPN-ის ავთენტიფიკაცია მხარდაუჭერელია',
      'openvpn_proxy_failed': 'OpenVPN-ის შუალედური ტრანსპორტი ვერ მუშაობს',
      'openvpn_compression_failed': 'OpenVPN-ის შეკუმშვა უარყოფილია',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN-ის NTLM-ის დაშიფვრა მიუწვდომელია',
      'openvpn_feature_unsupported': 'OpenVPN-ის ფუნქცია მხარდაუჭერელია',
      'network_unavailable': 'ინტერნეტ-კავშირი მიუწვდომელია',
      'network_lost': 'ქსელი მიუწვდომელია',
      'certificate_validation_failed': 'სერვერის სერტიფიკატი უარყოფილია',
      'openvpn_certificate_expired': 'OpenVPN-ის სერტიფიკატის ვადა ამოიწურა',
      'tunnel_active_for_another_account':
          'სხვა ანგარიშის გვირაბი ჯერ კიდევ აქტიურია',
      'tunnel_already_active': 'ნატიური გვირაბი უკვე აქტიურია',
      'tunnel_stop_timeout': '$protocol-ის გათიშვა არ დადასტურდა',
      'tunnel_disconnected': '$protocol შეწყდა',
      'native_bridge_unavailable': 'Android-ის ხიდი მიუწვდომელია',
      'native_operation_failed': 'Android-ის ოპერაცია შეწყდა',
      'invalid_arguments': 'VPN-ის პარამეტრები არასრულია',
      'invalid_account_id': 'არასწორი VPN ანგარიში',
      'invalid_device_id': 'მოწყობილობის იდენტიფიკატორი არასწორია',
      'storage_key_not_allowed': 'შენახვის გასაღები უარყოფილია',
      'secure_storage_read_failed': 'უსაფრთხო წაკითხვა ვერ მოხერხდა',
      'secure_storage_write_failed': 'უსაფრთხო ჩაწერა ვერ მოხერხდა',
      'key_generation_failed': 'WireGuard-ის გასაღების შექმნა ვერ მოხერხდა',
      'csr_generation_failed': 'OpenVPN-ის CSR-ის შექმნა ვერ მოხერხდა',
      'openvpn_recovery_exhausted': 'OpenVPN-ის აღდგენა უკვე გამოყენებულია',
      'openvpn_recovery_failed': 'OpenVPN-ის აღდგენა ვერ მოხერხდა',
      'openvpn_renewal_required': 'OpenVPN-ის სერტიფიკატის განახლება საჭიროა',
      'other': 'არაკლასიფიცირებული ნატიური VPN შეცდომა',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android-მა ვერ იპოვა გასაგრძელებელი VPN სესია. აპში დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_corrupt':
          'შენახული VPN-ის გაგრძელების მონაცემები არასწორია და გამოყენებული არ იქნება. დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_session_invalid':
          'შენახული სესიით VPN-ის გაგრძელება აღარ არის შესაძლებელი. აპში ხელახლა შედით ანგარიშში.',
      'system_vpn_resume_identity_changed':
          'ლოკალური VPN-ის იდენტობა შეიცვალა. გაგრძელება შეჩერდა; დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_identity_invalid':
          'VPN-ის გაგრძელების იდენტობა არასწორია. დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_storage_failed':
          'Android-მა ვერ წაიკითხა ან ვერ განაახლა გაგრძელების დაშიფრული მონაცემები. დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_network_timeout':
          'Android-მა დროულად ვერ იპოვა ქსელი VPN-ის გასაგრძელებლად. სცადეთ ხელახლა, როცა ქსელი ხელმისაწვდომი იქნება.',
      'system_vpn_resume_blocked':
          'VPN-ის გაგრძელება დაბლოკილია. შეამოწმეთ Android-ის პარამეტრები, შემდეგ დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_failed':
          'Android-ის მიერ VPN-ის გაგრძელება ვერ მოხერხდა. აპში დაამყარეთ ახალი კავშირი.',
      'system_vpn_resume_error_invalid':
          'Android-მა გაგრძელების გამოუსადეგი შეცდომა დააბრუნა. დაამყარეთ ახალი კავშირი.',
      'wireguard_identity_store_failed':
          'Android-მა ვერ შეინახა ამ ანგარიშის დაშიფრული WireGuard იდენტობა.',
      'wireguard_identity_unavailable':
          'ამ კავშირისთვის გამოსადეგი WireGuard იდენტობა არ არის.',
      'vpn_host_destroyed':
          'Android-ის კომპონენტი, რომელიც VPN-ს მასპინძლობს, გაჩერდა. დაამყარეთ ახალი კავშირი.',
      'vpn_host_unavailable':
          'Android ვერ ქმნის კომპონენტს, რომელიც VPN-ს მასპინძლობს. შეამოწმეთ VPN-ის პარამეტრები და სცადეთ ხელახლა.',
      'openvpn_renewal_required':
          'სერტიფიკატის გამო დაკავშირებამდე აპში მოქმედებაა საჭირო.',
      'openvpn_recovery_failed':
          'ავტომატური აღდგენა ვერ მოხერხდა. აპში დაამყარეთ ახალი კავშირი.',
      'openvpn_recovery_exhausted':
          'ავტომატური აღდგენა უკვე გამოყენებულია. აპში დაამყარეთ ახალი კავშირი.',
      'vpn_permission_required':
          'Android-ს გვირაბის დაწყებამდე VPN-ის ახალი ნებართვა სჭირდება.',
      'vpn_permission_denied':
          'გასაგრძელებლად Android-ის მოთხოვნაში დართეთ ნებართვა FuzeVPN-ს.',
      'vpn_permission_request_failed':
          'Android-მა ვერ გახსნა VPN-ის ნებართვის ეკრანი.',
      'wireguard_foreground_service_unavailable':
          'Android-მა ვერ შეინარჩუნა WireGuard-ის სერვისი წინა პლანზე.',
      'wireguard_identity_invalid':
          'ამ ანგარიშის დაშიფრული WireGuard გასაღები ვერ იკითხება ან არასწორია.',
      'wireguard_identity_in_use':
          'სხვა ოპერაცია ჯერ კიდევ იყენებს ამ ანგარიშის WireGuard გასაღებს.',
      'wireguard_configuration_invalid':
          'მიღებული WireGuard მისამართი, DNS, სერვერის გასაღები ან მარშრუტები არასწორია.',
      'wireguard_operation_pending':
          'წინა WireGuard ოპერაციას თავისი ნატიური სერვისი ჯერ არ გაუთავისუფლებია.',
      'wireguard_start_failed':
          'WireGuard-ის ძრავამ კონფიგურაციის გააქტიურებაზე უარი თქვა.',
      'wireguard_stop_timeout':
          'WireGuard-ის სერვისმა დადგენილ დროში ვერ დაადასტურა VPN ინტერფეისის გათავისუფლება.',
      'wireguard_handshake_timeout':
          'გვირაბმა დროულად ვერ დაადასტურა კავშირი სერვერთან.',
      'openvpn_connection_timeout':
          'OpenVPN-მა დროულად ვერ დაადასტურა კავშირი სერვერთან.',
      'openvpn_core_unavailable':
          'ამ აპის ვერსიაში გამოსადეგი OpenVPN ძრავა არ არის.',
      'openvpn_operation_pending':
          'ნატიური ძრავა ჯერ კიდევ იყენებს OpenVPN-ის წინა სესიას და მეორე სესიის შექმნაზე უარს ამბობს.',
      'openvpn_stop_timeout':
          'OpenVPN Core-მა დადგენილ დროში ვერ დაადასტურა, რომ მისი ნატიური სესია შეჩერდა და გაუქმდა.',
      'openvpn_profile_unavailable':
          'ამ კავშირისთვის გადამოწმებული OpenVPN პროფილი ვერ იკითხება.',
      'openvpn_native_failed':
          'აპის შეცდომის გამო OpenVPN-ის მუშაობა შეწყდა. სცადეთ ხელახლა დაკავშირება. თუ პრობლემა გრძელდება, გაუშვით დიაგნოსტიკა.',
      'openvpn_key_generation_failed':
          'Android Keystore-მა ვერ შექმნა ან ვერ წაიკითხა არაექსპორტირებადი P-256 პირადი გასაღები.',
      'openvpn_csr_generation_failed':
          'Android Keystore-ის გასაღებით ვერ მოხერხდა OpenVPN-ის სერტიფიკატის მოთხოვნის (CSR) ხელმოწერა.',
      'openvpn_identity_store_failed':
          'OpenVPN-ის სერტიფიკატი ან პროფილი ვერ შეინახა დაშიფრულ საცავში.',
      'openvpn_identity_clear_failed':
          'Android-მა ამ ანგარიშის ლოკალური OpenVPN იდენტობა სრულად ვერ წაშალა.',
      'openvpn_identity_in_use':
          'ნატიური OpenVPN-ის სესია ჯერ კიდევ იყენებს ამ მოწყობილობის გასაღებს ან სერტიფიკატს.',
      'openvpn_tls_verification_required':
          'პროფილი მკაფიოდ არ ითხოვს სერვერის სერტიფიკატის გადამოწმებას.',
      'openvpn_cipher_invalid':
          'სერვერმა მიაწოდა დაშიფვრის ალგორითმი, რომელიც დაშვებული ალგორითმების სიაში არ შედის.',
      'openvpn_profile_rejected':
          'სერვერიდან მიღებული პროფილი შეუთავსებელია. ხელახლა შექმენით ეს მოწყობილობა და სცადეთ ხელახლა.',
      'openvpn_identity_inconsistent':
          'სერტიფიკატი არ შეესაბამება ამ ტელეფონის უსაფრთხო იდენტობას. ლოკალური პროფილი არ შეცვლილა.',
      'tls_handshake_failed':
          'სერვერმა უარყო TLS მოლაპარაკება. თუ პრობლემა გრძელდება, ხელახლა შექმენით პროფილი.',
      'tls_alert_unknown_ca':
          'სერვერი ამ მოწყობილობის სერტიფიკატის გამცემს არ ცნობს. უნდა შემოწმდეს OpenVPN-ის სერვერი.',
      'tls_alert_bad_certificate':
          'სერვერმა უარყო ამ მოწყობილობის სერტიფიკატი. ხელახლა შექმენით მოწყობილობა და შემდეგ სცადეთ ხელახლა.',
      'tls_alert_unsupported_certificate':
          'სერვერი არ უჭერს მხარს Android-ის მიერ გამოყენებულ უსაფრთხო სერტიფიკატის ტიპს.',
      'tls_client_certificate_required':
          'სერვერს კლიენტის სერტიფიკატი სჭირდება, მაგრამ OpenVPN Core ვერ წარადგენს მას.',
      'tls_alert_misc':
          'სერვერმა დააბრუნა TLS-ის გაფრთხილება, რომელიც სერტიფიკატისა და ვერსიის კატეგორიებს არ მიეკუთვნება.',
      'tls_signature_algorithm_rejected':
          'სერვერმა უარყო Android Keystore-ის გასაღების ECDSA P-256 ალგორითმი.',
      'tls_handshake_rejected':
          'სერვერმა TLS მოლაპარაკება კავშირის დამყარებამდე შეწყვიტა.',
      'tls_version_rejected':
          'კლიენტმა და სერვერმა საერთო TLS ვერსია ვერ იპოვეს.',
      'tls_certificate_expired':
          'კავშირის დროს წარდგენილი სერტიფიკატის ვადა ამოიწურა.',
      'tls_certificate_revoked':
          'კავშირის დროს წარდგენილი სერტიფიკატი გაუქმებულია.',
      'transport_failed':
          'OpenVPN-ის სერვერი მიმდინარე ქსელში არ პასუხობს. ცოტა ხანში სცადეთ ხელახლა.',
      'tun_configuration_rejected':
          'Android-მა უარყო OpenVPN-ის მიერ მოთხოვნილი ქსელის კონფიგურაცია.',
      'tun_setup_failed':
          'OpenVPN Core-მა უარყო ქსელის გეგმა Android-ის ინტერფეისის შექმნამდე.',
      'tun_interface_create_failed':
          'OpenVPN Core-მა ვერ მიიღო TUN-ის ინტერფეისი Android VpnService-ისგან.',
      'tun_interface_disabled':
          'Android-მა ან OpenVPN Core-მა კავშირის დროს გამორთო TUN-ის ინტერფეისი.',
      'tun_halted':
          'OpenVPN Core-მა მიიღო მოთხოვნა TUN-ის ინტერფეისის შეჩერებაზე.',
      'tun_already_established':
          'OpenVPN-მა მოითხოვა მეორე ინტერფეისი იმავე კავშირში. უსაფრთხოებისთვის გვირაბი შეჩერდა.',
      'tun_addresses_missing':
          'სერვერმა არ მიაწოდა გამოსადეგი გვირაბის მისამართი.',
      'tun_routes_missing':
          'სერვერმა არ მიაწოდა გამოსადეგი გვირაბის მარშრუტები.',
      'tun_dns_missing': 'სერვერმა არ მიაწოდა გამოსადეგი DNS სერვერი.',
      'tun_permission_revoked':
          'Android-მა კავშირის დროს გააუქმა VPN-ის ნებართვა.',
      'tun_establish_returned_null':
          'Android-მა ინტერფეისი არ შექმნა, ჩვეულებრივ იმიტომ, რომ სხვა VPN ჯერ კიდევ აქტიურია.',
      'openvpn_service_start_failed':
          'Android-მა ვერ დაიწყო OpenVPN-ის წინა პლანის სერვისი.',
      'openvpn_operation_timeout':
          'OpenVPN Core-ის JNI გამოძახებამ დასაშვები დრო გადააჭარბა.',
      'openvpn_start_failed':
          'Android-ის სერვისი მზადაა, მაგრამ OpenVPN Core-მა პროფილის გაშვებაზე უარი თქვა.',
      'openvpn_connection_failed':
          'OpenVPN Core შეჩერდა CONNECTED მოვლენის გაგზავნამდე.',
      'openvpn_core_status_error':
          'ნატიური OpenVPN-ის ციკლი შეცდომით დასრულდა და უფრო კონკრეტული საბოლოო მოვლენა არ ყოფილა.',
      'openvpn_stopped_before_connected':
          'ნატიური OpenVPN-ის ციკლი CONNECTED-მდე შეჩერდა, OpenVPN Core-ის მკაფიო შეცდომის გარეშე.',
      'openvpn_auth_failed':
          'OpenVPN-ის სერვერმა უარყო პროფილის ავთენტიფიკაცია.',
      'openvpn_client_setup_failed':
          'OpenVPN Core-მა ვერ მოამზადა კლიენტი ქსელურ კავშირამდე.',
      'openvpn_client_halted':
          'OpenVPN Core-მა მიიღო კლიენტის საბოლოო გაჩერების მოთხოვნა.',
      'openvpn_client_restart':
          'OpenVPN Core-მა მოითხოვა სატრანსპორტო სესიის გადატვირთვა.',
      'openvpn_inactive_timeout':
          'OpenVPN Core-მა სესია დახურა უმოქმედობის ლიმიტის გადაჭარბების შემდეგ.',
      'openvpn_session_expired':
          'სერვერმა აცნობა, რომ OpenVPN-ის სესიის ვადა ამოიწურა.',
      'openvpn_credentials_required':
          'სერვერი ან პროქსი ითხოვს ინტერაქტიულად შესატან ავტორიზაციის მონაცემებს, რომლებიც ამ სერტიფიკატის პროფილის ნაწილი არ არის.',
      'openvpn_proxy_failed':
          'OpenVPN Core-მა აცნობა კონფიგურირებული პროქსის ან რელეს შეცდომა.',
      'openvpn_compression_failed':
          'OpenVPN Core-მა უარყო პროფილის ან სერვერის მიერ გამოცხადებული შეკუმშვის რეჟიმი.',
      'openvpn_ntlm_crypto_unavailable':
          'პროფილი ითხოვს NTLM-ის დაშიფვრას, რომელიც ამ ვერსიაში მიუწვდომელია.',
      'openvpn_feature_unsupported':
          'პროფილს ან სერვერს სჭირდება ფუნქცია, რომელიც ამ Android კლიენტში არ არის.',
      'network_unavailable': 'გამოსადეგი ფიზიკური ქსელი ხელმისაწვდომი არ არის.',
      'network_lost': 'გვირაბი შეჩერდა ქსელის დაკარგვის შემდეგ.',
      'certificate_validation_failed':
          'OpenVPN-ის სერვერის იდენტობა ვერ გადამოწმდა.',
      'openvpn_certificate_expired':
          'ხელახლა დაკავშირებამდე განაახლეთ OpenVPN-ის პროფილი.',
      'tunnel_active_for_another_account':
          'ამ კავშირამდე უნდა გაითიშოს სხვა ანგარიშის გვირაბი.',
      'tunnel_already_active':
          'Android აცნობებს, რომ წინა VPN სესია ჯერ კიდევ იყენებს ინტერფეისს.',
      'tunnel_stop_timeout':
          '$protocol-ის ძრავამ დადგენილ დროში ვერ დაადასტურა VPN ინტერფეისის გათავისუფლება.',
      'tunnel_disconnected':
          'ნატიურმა ძრავამ აცნობა, რომ გვირაბი დაწყების შემდეგ მოულოდნელად დასრულდა.',
      'native_bridge_unavailable':
          'აპს Android-ის VPN სერვისზე წვდომა არ აქვს. დახურეთ და ხელახლა გახსენით აპი, შემდეგ სცადეთ ხელახლა.',
      'native_operation_failed':
          'აპის შეცდომის გამო VPN-ის ოპერაცია შეწყდა. სცადეთ ხელახლა. თუ პრობლემა გრძელდება, გაუშვით დიაგნოსტიკა.',
      'invalid_arguments':
          'ამ VPN-ის ოპერაციისთვის საჭირო ინფორმაცია არასრულია. სცადეთ ხელახლა. თუ პრობლემა გრძელდება, გაუშვით დიაგნოსტიკა.',
      'invalid_account_id':
          'ნატიური ოპერაცია ანგარიშის სწორ იდენტიფიკატორთან არ არის დაკავშირებული.',
      'invalid_device_id':
          'ნატიური ძრავისთვის გაგზავნილი მოწყობილობის იდენტიფიკატორი არ არის მითითებული ან არასწორია.',
      'storage_key_not_allowed':
          'Android-ის ხიდმა დაბლოკა გასაღები, რომელიც დაშვებული შენახვის სიაში არ შედის.',
      'secure_storage_read_failed':
          'Android Keystore-მა ვერ გაშიფრა ამ ანგარიშის ლოკალური მონაცემები.',
      'secure_storage_write_failed':
          'Android Keystore-მა ვერ დაშიფრა ან ვერ შეინახა ლოკალური მონაცემები.',
      'key_generation_failed':
          'Android-მა ვერ შექმნა ან ვერ წაიკითხა WireGuard-ის გასაღები დაცულ საცავში.',
      'csr_generation_failed':
          'Android Keystore-მა ვერ შექმნა ან ხელი ვერ მოაწერა OpenVPN P-256 CSR-ს.',
      'other':
          'მოხდა გაუთვალისწინებელი ნატიური შეცდომა. გაუგზავნეთ მხარდაჭერას ქვემოთ ნაჩვენები დიაგნოსტიკის კოდი.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'ნებართვის მოთხოვნა უკვე ღიაა';

  @override
  String get notice_permissionRequestInProgress_message =>
      'VPN-ის ნებართვის მოთხოვნა Android-ზე უკვე ნაჩვენებია. დაასრულეთ ის და შემდეგ სცადეთ ხელახლა.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-ის ნებართვის მოთხოვნა შეწყდა';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN-ის ნებართვის ეკრანი დაიხურა, სანამ აპი პასუხს მიიღებდა.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN კავშირი არ დადასტურდა';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN კავშირის დადასტურება ვერ მოხერხდა. უსაფრთხოების მიზნით ის გაითიშა. სცადეთ ხელახლა.';

  @override
  String get openvpnCleanup_title => 'OpenVPN პროფილი გაუქმებულია';

  @override
  String get openvpnCleanup_working =>
      'გაუქმებული OpenVPN პროფილი ითიშება და იშლება…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-ის გათიშვა არ დადასტურდა. ახალი პროფილის შექმნამდე სცადეთ ხელახლა.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'გაუქმებული OpenVPN პროფილი სრულად ვერ წაიშალა. სცადეთ გასუფთავება ხელახლა.';

  @override
  String get openvpnCleanup_complete =>
      'გაუქმებული OpenVPN პროფილი წაიშალა. ახლის შესაქმნელად შეეხეთ ღილაკს „დაკავშირება“.';

  @override
  String get network_title => 'ქსელის კონფიგურაცია';

  @override
  String get network_ipv4Fallback =>
      'IPv6 დროებით მიუწვდომელია. მომზადება გრძელდება IPv4-ით.';

  @override
  String get network_rejectedTitle => 'ქსელის კონფიგურაცია უარყოფილია';

  @override
  String get network_rejectedMessage =>
      'გვირაბის კონფიგურაცია არასრულია ან არ შეესაბამება ნებადართულ მისამართებს. სცადეთ აპიდან ხელახლა.';

  @override
  String get network_unreadableTitle => 'ლოკალური კონფიგურაცია ვერ იკითხება';

  @override
  String get network_unreadableMessage =>
      'შენახული OpenVPN ქსელის კონფიგურაცია ვერ გამოიყენება. მის გასაახლებლად აპიდან ხელახლა დაუკავშირდით VPN-ს.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ქსელის დაცვა';

  @override
  String get protection_subtitle =>
      'დაბლოკეთ პირდაპირი წვდომა ინტერნეტზე, თუ VPN გაითიშება.';

  @override
  String get protection_active => 'სისტემური დაცვა ჩართულია';

  @override
  String get protection_alwaysOnOnly =>
      '„ყოველთვის ჩართული VPN“ ჩართულია; ჩართეთ „VPN-ის გარეშე კავშირების დაბლოკვა“';

  @override
  String get protection_inactive => 'სისტემური დაცვა გამორთულია';

  @override
  String get protection_unknown => 'შეამოწმეთ სისტემური დაცვა';

  @override
  String get protection_openSettings => 'Android-ის პარამეტრების გახსნა';

  @override
  String get protection_dialogTitle => 'ქსელის დაცვის დაყენება';

  @override
  String get protection_dialogMessage =>
      'Android მართავს „ყოველთვის ჩართულ VPN-ს“ და VPN-ის გარეშე კავშირების დაბლოკვას. შეამოწმეთ, რომ არჩეულია FuzeVPN, და სისტემის პარამეტრებში ჩართეთ დაბლოკვა.';

  @override
  String get protection_dialogOpen => 'პარამეტრების გახსნა';

  @override
  String get session_systemProtectionNote =>
      'თუ Android კვლავ ბლოკავს ტრაფიკს VPN-ის გარეშე, ამ დაცვის შესამოწმებლად ან შესაცვლელად გახსენით სისტემის პარამეტრები.';

  @override
  String get diagnostics_title => 'დიაგნოსტიკა';

  @override
  String get diagnostics_settingsTitle => 'აპის დიაგნოსტიკა';

  @override
  String get diagnostics_automaticTitle => 'მნიშვნელოვანი შეცდომების გაგზავნა';

  @override
  String get diagnostics_automaticDescription =>
      'მნიშვნელოვანი შეცდომის დროს გააზიარეთ მოკლე ტექნიკური მოხსენება.';

  @override
  String get diagnostics_privacy =>
      'გაგზავნილი მოხსენებები უკავშირდება ანგარიშს, რომელშიც ხართ შესული, და ინახება 30 დღე. ისინი არ შეიცავს დათვალიერების ისტორიას, პაროლებს ან VPN გასაღებებს.';

  @override
  String get diagnostics_manualOpen => 'დიაგნოსტიკის გაშვება';

  @override
  String get diagnostics_localDescription =>
      'შექმენით მოხსენება აპისა და VPN-ის მდგომარეობის შესახებ. თქვენი კავშირი უცვლელი რჩება.';

  @override
  String get diagnostics_sendReport => 'მოხსენების გაგზავნა';

  @override
  String get diagnostics_sendHint =>
      'ამ მოწყობილობაზე მოხსენების შესანახად დატოვეთ ეს ველი მოუნიშნავი.';

  @override
  String get diagnostics_signedOut => 'მოხსენების გასაგზავნად შედით ანგარიშში.';

  @override
  String get diagnostics_localLifetime =>
      'მოხსენება აპის დახურვის შემდეგაც რომ დარჩეს, შეინახეთ ის ტელეფონზე.';

  @override
  String get diagnostics_run => 'დიაგნოსტიკის გაშვება';

  @override
  String get diagnostics_rerun => 'დიაგნოსტიკის ხელახლა გაშვება';

  @override
  String get diagnostics_running => 'მიმდინარეობს შემოწმება…';

  @override
  String get diagnostics_sending => 'მოხსენება იგზავნება…';

  @override
  String get diagnostics_prepared => 'მოხსენება მზადაა ამ მოწყობილობაზე';

  @override
  String get diagnostics_queued => 'მოხსენება გასაგზავნად ელოდება';

  @override
  String get diagnostics_sent => 'მოხსენება მიღებულია';

  @override
  String get diagnostics_failed =>
      'გაგზავნა ვერ მოხერხდა. თქვენი ლოკალური მოხსენება კვლავ ხელმისაწვდომია.';

  @override
  String get diagnostics_preparationFailed =>
      'დიაგნოსტიკის მოხსენების მომზადება ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get diagnostics_authenticationRequired =>
      'მოხსენების გასაგზავნად ხელახლა შედით ანგარიშში.';

  @override
  String get diagnostics_retry => 'გაგზავნის ხელახლა ცდა';

  @override
  String get diagnostics_export => 'მოხსენების შენახვა';

  @override
  String get diagnostics_exportFailed =>
      'შენახვა ვერ მოხერხდა. სცადეთ ხელახლა ლოკალური მოხსენებიდან.';

  @override
  String get diagnostics_preferenceFailed =>
      'ეს პარამეტრი ვერ შეინახა. სცადეთ ხელახლა.';

  @override
  String diagnostics_receipt(Object id) {
    return 'საცნობარო კოდი: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'მიღების თარიღი: $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'ინახება ამ თარიღამდე: $date';
  }

  @override
  String get diagnostics_duplicate => 'ეს მოხსენება უკვე მიღებული იყო.';

  @override
  String get diagnostics_preview => 'მოხსენების გადახედვა';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'თან ერთვის $count ტექნიკური მოვლენა',
      one: 'თან ერთვის 1 ტექნიკური მოვლენა',
      zero: 'ტექნიკური მოვლენები თან არ ერთვის',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'ტექნიკური დეტალები';

  @override
  String get diagnostics_empty => 'დიაგნოსტიკის მოხსენება ჯერ არ მომზადებულა.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'გვირაბის მდგომარეობა',
      'handshake': 'კავშირის დადასტურება',
      'certificate': 'VPN სერტიფიკატი',
      'kill_switch': 'Android-ის დაცვა',
      'connectivity': 'ხელმისაწვდომი ქსელი',
      'api_reachability': 'სერვისზე წვდომა',
      'secure_storage': 'უსაფრთხო საცავი',
      'other': 'ლოკალური შემოწმება',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'შემოწმებულია',
      'failed': 'საჭიროებს ყურადღებას',
      'skipped': 'არ შემოწმებულა — აქტიური შემოწმების გარეშე',
      'unknown': 'ინფორმაცია მიუწვდომელია',
      'other': 'ინფორმაცია მიუწვდომელია',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'მოგესალმებით FuzeVPN-ში';

  @override
  String get connection_changeLocation => 'მდებარეობის შეცვლა';

  @override
  String get connection_details => 'კავშირის დეტალები';

  @override
  String get locations_searchLabel => 'ქალაქის ან ქვეყნის ძიება';

  @override
  String get locations_clearSearch => 'ძიების გასუფთავება';

  @override
  String get locations_filterAll => 'ყველა';

  @override
  String get locations_filterFavorites => 'რჩეულები';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count მდებარეობა',
      one: '$count მდებარეობა',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'მდებარეობები ვერ მოიძებნა';

  @override
  String get locations_noResultsHint => 'სცადეთ სხვა ქალაქი ან ქვეყანა.';

  @override
  String get locations_noFavorites => 'თქვენი რჩეულები ყოველთვის ახლოს';

  @override
  String get locations_noFavoritesHint =>
      'შეეხეთ ვარსკვლავს მდებარეობის გვერდით, რომ აქ შეინახოთ.';

  @override
  String get locations_showAll => 'ყველა მდებარეობის ნახვა';

  @override
  String locations_addFavorite(String name) {
    return 'დაამატეთ $name რჩეულებში';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'წაშალეთ $name რჩეულებიდან';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'რჩეული ვერ შეინახა. სცადეთ ხელახლა.';

  @override
  String get locations_emptyTitle => 'მდებარეობები ხელმისაწვდომი არ არის';

  @override
  String get locations_emptyHint => 'სცადეთ ხელახლა სიის განახლებით.';

  @override
  String get devices_manage => 'ჩემი მოწყობილობების მართვა';

  @override
  String get settings_personalization => 'მოარგეთ თქვენს გემოვნებას';

  @override
  String get settings_safety => 'დაცვა';

  @override
  String get settings_help => 'გჭირდებათ დახმარება?';

  @override
  String get settings_about => 'FuzeVPN-ის შესახებ';

  @override
  String get diagnostics_heading => 'კავშირის პრობლემის გარკვევა';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'ხელმისაწვდომია',
      'pending': 'მზადდება',
      'revoked': 'წაშლილია',
      'expired': 'ვადაგასულია',
      'other': 'სტატუსი მიუწვდომელია',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'პარამეტრი არ შენახულა';

  @override
  String get notice_preferenceSave_message =>
      'თქვენი არჩევანი ამჟამად გამოიყენება, მაგრამ შენახვა ვერ მოხერხდა. სცადეთ ხელახლა, რომ აპის დახურვის შემდეგაც შენარჩუნდეს.';

  @override
  String get connection_androidDisconnectHint =>
      'თუ Android VPN-ს აქტიურს ტოვებს, გახსნილ პარამეტრებში გამორთეთ „ყოველთვის ჩართული VPN“.';

  @override
  String get protection_learnMore => 'გაიგეთ მეტი Android-ის დაცვის შესახებ';

  @override
  String get protection_guideWhy =>
      'ეს დაცვა ხელს უშლის აპებს, VPN-ის გათიშვისას ინტერნეტით პირდაპირ ისარგებლონ. ის Android-ში ყენდება.';

  @override
  String get protection_guideAlwaysOnTitle => 'ყოველთვის ჩართული VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android-ს შეუძლია VPN სერვისი ჩართული შეინარჩუნოს და ტელეფონის გადატვირთვის შემდეგ ხელახლა გაუშვას.';

  @override
  String get protection_guideBlockTitle => 'VPN-ის გარეშე კავშირების დაბლოკვა';

  @override
  String get protection_guideBlock =>
      'ეს პარამეტრი ხელს უშლის ტრაფიკს, VPN-ის გვერდის ავლით გავიდეს, მათ შორის კავშირის შეწყვეტისას.';

  @override
  String get protection_guideWarning =>
      'ამ დაბლოკვის ჩართვისას ინტერნეტზე წვდომა გამორთული დარჩება, სანამ VPN არ დაკავშირდება.';

  @override
  String get protection_guideStepsTitle => 'დაცვის ჩართვა';

  @override
  String get protection_guideStep1 =>
      'ქვემოთ მოცემული ღილაკით გახსენით Android-ის VPN პარამეტრები.';

  @override
  String get protection_guideStep2 =>
      'პარამეტრების გასახსნელად შეეხეთ კბილანას ხატულას FuzeVPN-ის გვერდით.';

  @override
  String get protection_guideStep3 =>
      'თუ ეს პარამეტრები ხელმისაწვდომია, ჩართეთ „ყოველთვის ჩართული VPN“, შემდეგ კი „VPN-ის გარეშე კავშირების დაბლოკვა“.';

  @override
  String get protection_guideManufacturers =>
      'სახელწოდებები ტელეფონის მიხედვით განსხვავდება. საჭიროების შემთხვევაში პარამეტრებში მოძებნეთ „VPN“ — ის ხშირად განყოფილებაშია „ქსელი და ინტერნეტი“.';

  @override
  String get protection_guideDisableTitle => 'ამ დაცვის გამორთვა';

  @override
  String get protection_guideDisable =>
      'იმავე პარამეტრებში გამორთეთ „VPN-ის გარეშე კავშირების დაბლოკვა“, რათა VPN-ის გარეშე ინტერნეტით ისარგებლოთ. ასევე გამორთეთ „ყოველთვის ჩართული VPN“, თუ აღარ გსურთ, რომ Android-მა VPN ხელახლა გაუშვას.';

  @override
  String get protection_guideManual =>
      'ამ პარამეტრებს Android-ში თავად ირჩევთ. FuzeVPN მათ თქვენ მაგივრად არ ცვლის.';

  @override
  String get locations_changeTitle => 'შეიცვალოს მდებარეობა?';

  @override
  String locations_changeActive(String name) {
    return 'VPN გაითიშება, შემდეგ კი შეეცდება დაკავშირებას მდებარეობასთან: $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN შეეცდება დაკავშირებას მდებარეობასთან: $name.';
  }

  @override
  String get locations_confirmChange => 'შეცვლა და დაკავშირება';

  @override
  String get locations_changeBusy =>
      'მიმდინარეობს ცვლილება. სხვა მდებარეობის არჩევამდე დაელოდეთ.';

  @override
  String get locations_automaticSelection => 'ავტომატური არჩევა';

  @override
  String get locations_cities => 'ქალაქები';

  @override
  String get locations_servers => 'სერვერები';

  @override
  String locations_viewCities(String name) {
    return 'ქალაქების ნახვა: $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'სერვერების ნახვა: $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ქვეყანა',
      one: '$count ქვეყანა',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ქალაქი',
      one: '$count ქალაქი',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count სერვერი',
      one: '$count სერვერი',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'ყველა ქვეყანა';

  @override
  String get locations_backToCountries => 'ქვეყნებზე დაბრუნება';

  @override
  String locations_backToCities(String name) {
    return 'ქალაქებზე დაბრუნება: $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'აირჩიეთ $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'აირჩიეთ $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'თავსებადი სერვერი ხელმისაწვდომი არ არის.';

  @override
  String get externalLink_failed =>
      'ამ ბმულის გახსნა ვერ მოხერხდა. შეგიძლიათ დააკოპიროთ და ბრაუზერში გახსნათ.';

  @override
  String get externalLink_copy => 'ბმულის კოპირება';

  @override
  String get externalLink_copied => 'ბმული კოპირებულია';

  @override
  String get externalLink_copyFailed =>
      'ბმულის კოპირება ვერ მოხერხდა. ქვემოთ მოცემული მისამართი მონიშნეთ.';

  @override
  String get settings_deleteAccount => 'ჩემი ანგარიშის წაშლა';

  @override
  String get settings_deleteAccountDetail =>
      'ანგარიშის წაშლის მოთხოვნის პროცედურის ნახვა';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'აირჩიეთ თქვენი VPN გამოწერა.';

  @override
  String get billing_subscribe => 'გამოწერა';

  @override
  String get billing_choosePlan => 'გასაგრძელებლად აირჩიეთ გეგმა.';

  @override
  String get billing_monthly => 'ყოველთვიური';

  @override
  String get billing_yearly => 'ყოველწლიური';

  @override
  String get billing_continue => 'გაგრძელება Google Play-ით';

  @override
  String get billing_restore => 'შესყიდვების აღდგენა';

  @override
  String get billing_manage => 'გამოწერის მართვა';

  @override
  String get billing_deleteAccountWarning =>
      'თუ გაქვთ Google Play-ის გამოწერა, FuzeVPN-ის ანგარიშის წაშლა მის განახლებას არ აუქმებს. განახლება ცალკე მართეთ ან გააუქმეთ Google Play-ში.';

  @override
  String get billing_deleteAccountContinue =>
      'ანგარიშის წაშლის მოთხოვნაზე გადასვლა';

  @override
  String get billing_refresh => 'წვდომის განახლება';

  @override
  String get billing_loadingPlans => 'გეგმები იტვირთება…';

  @override
  String get billing_unavailable =>
      'ამჟამად გეგმები ხელმისაწვდომი არ არის. სცადეთ მოგვიანებით.';

  @override
  String get billing_comingSoon => 'გამოწერები მალე ხელმისაწვდომი იქნება.';

  @override
  String get billing_priceDisclosure =>
      'ფასს Google Play ადგენს. საბოლოო თანხა და გადასახადები თქვენს დადასტურებამდე დაზუსტდება.';

  @override
  String get billing_renewalMonthly =>
      'ავტომატურად ახლდება ყოველთვიურად, თუ არ გააუქმებთ. ნებისმიერ დროს შეგიძლიათ გააუქმოთ Google Play-ის გამოწერებში.';

  @override
  String get billing_renewalYearly =>
      'ავტომატურად ახლდება ყოველწლიურად, თუ არ გააუქმებთ. ნებისმიერ დროს შეგიძლიათ გააუქმოთ Google Play-ის გამოწერებში.';

  @override
  String get billing_active => 'თქვენი Premium წვდომა აქტიურია';

  @override
  String billing_accessUntil(String date) {
    return 'წვდომა მოქმედებს შემდეგ თარიღამდე: $date.';
  }

  @override
  String get billing_webManaged =>
      'თქვენს გამოწერას FuzeVPN-ის ვებსაიტზე მართავთ.';

  @override
  String get billing_playManaged => 'თქვენს გამოწერას Google Play მართავს.';

  @override
  String get billing_playOnHold =>
      'თქვენი Google Play-ის გამოწერა შეჩერებულია ან გადახდას ელოდება. მის გასასწორებლად Google Play-ში გახსენით „გამოწერის მართვა“.';

  @override
  String get billing_playReceiptUnlinked =>
      'ამ Google Play-ის ანგარიშს უკვე აქვს Fuze Premium-ის გამოწერა, რომელიც ამ FuzeVPN-ის ანგარიშისთვის აქტიური არ არის. მის გადასამოწმებლად Google Play-ში გახსენით „გამოწერის მართვა“.';

  @override
  String get billing_inactive => 'აქტიური გამოწერა არ არის.';

  @override
  String get billing_checkingAccess => 'თქვენი წვდომის შემოწმება…';

  @override
  String get billing_restoring => 'შესყიდვების აღდგენა…';

  @override
  String get billing_pending =>
      'გადახდა მოლოდინშია. წვდომა დადასტურების შემდეგ გააქტიურდება.';

  @override
  String get billing_cancelled =>
      'შესყიდვა გაუქმდა. ახალი გამოწერა არ გააქტიურებულა.';

  @override
  String get billing_verifying => 'შესყიდვის შემოწმება…';

  @override
  String get billing_success =>
      'გამოწერა გააქტიურებულია. თქვენი Premium წვდომა მზადაა.';

  @override
  String get billing_restored => 'თქვენი შესყიდვები აღდგენილია.';

  @override
  String get billing_restoreEmpty =>
      'ამ Google Play-ის ანგარიშზე აღსადგენი შესყიდვები არ არის.';

  @override
  String get billing_catalogError =>
      'გეგმების ჩატვირთვა ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get billing_purchaseError =>
      'შესყიდვის დაწყება ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get billing_verificationError =>
      'შესყიდვის შემოწმება დროებით ხელმისაწვდომი არ არის. სცადეთ ხელახლა შესყიდვების აღდგენით.';

  @override
  String get billing_restoreError =>
      'შესყიდვების აღდგენა ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get billing_managementError =>
      'გამოწერის მართვის გახსნა ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get billing_storeUnavailable =>
      'Google Play ამ მოწყობილობაზე ხელმისაწვდომი არ არის.';

  @override
  String get welcome_title => 'თქვენი VPN, მარტივად.';

  @override
  String get welcome_description =>
      'დაიცავით თქვენი კავშირი და თავად მართეთ თქვენი კონფიდენციალურობა.';

  @override
  String get welcome_start => 'დაწყება';

  @override
  String get welcome_alreadyPurchased => 'უკვე იყიდეთ?';

  @override
  String get welcome_noAccountRequired => 'დასაწყებად ანგარიში საჭირო არ არის.';

  @override
  String get guest_accountTitle => 'ანგარიში მიბმული არ არის';

  @override
  String get guest_accountDescription =>
      'აღადგინეთ თქვენი შესყიდვები იმავე Google Play-ის ანგარიშით, რათა სხვა მოწყობილობაზეც გამოიყენოთ თქვენი გამოწერა.';

  @override
  String get guest_existingSubscriberSignIn => 'უკვე გაქვთ გამოწერა? შედით';

  @override
  String get guest_claimTitle => 'FuzeVPN ყველგან თქვენთან ერთად';

  @override
  String get guest_claimDescription =>
      'შექმენით ანგარიში, რომ თქვენი გამოწერით სხვა მოწყობილობებზეც ისარგებლოთ. ეს ნაბიჯი არასავალდებულოა.';

  @override
  String get guest_skip => 'მოგვიანებით';

  @override
  String get guest_activationTitle => 'Fuze Premium გააქტიურებულია';

  @override
  String get guest_activationDescription =>
      'თქვენი გამოწერა მზადაა. გამოიყენეთ თქვენი VPN და ანგარიში შექმენით, როდესაც მოისურვებთ.';

  @override
  String get guest_useVpn => 'VPN-ის გამოყენება';

  @override
  String get guest_loginRequired =>
      'ეს შესყიდვა უკვე მიბმულია FuzeVPN-ის ანგარიშზე. თქვენს გამოწერაზე წვდომისთვის შედით ამ ანგარიშში.';

  @override
  String get guest_signOutWarning =>
      'თქვენი გამოწერის აღდგენა შეგიძლიათ იმავე Google Play-ის ანგარიშით, შესყიდვების აღდგენის გზით.';

  @override
  String get guest_profileUnavailable =>
      'თქვენი ანგარიში უკვე მიბმულია. შედით თქვენი მონაცემების სანახავად და სამართავად.';

  @override
  String get billing_acceptance =>
      'გაგრძელებით თქვენ ეთანხმებით გამოყენების პირობებსა და კონფიდენციალურობის პოლიტიკას.';

  @override
  String get guest_verifyEmailReminder =>
      'დაადასტურეთ თქვენი ელფოსტის მისამართი, რათა ანგარიში დაიცვათ. VPN-ის გამოყენებას შეგიძლიათ განაგრძოთ.';

  @override
  String get guest_serviceUnavailable =>
      'სერვისი დროებით ხელმისაწვდომი არ არის. ცოტა ხანში სცადეთ ხელახლა.';

  @override
  String get guest_restoreError =>
      'თქვენი შესყიდვების აღდგენა ვერ მოხერხდა. სცადეთ ხელახლა იმ Google Play-ის ანგარიშით, რომლითაც შეიძინეთ.';

  @override
  String get guest_claimSuccess =>
      'თქვენი ანგარიში შეიქმნა. თქვენი გამოწერა და VPN-ზე წვდომა შენარჩუნებულია.';

  @override
  String get guest_emailExists =>
      'ეს ელფოსტა უკვე გამოიყენება. აირჩიეთ სხვა მისამართი ან შედით არსებულ ანგარიშში. თქვენი შესყიდვა Google Play-ით ხელმისაწვდომი დარჩება.';

  @override
  String get guest_claimError =>
      'თქვენი ანგარიშის შექმნა ვერ მოხერხდა. VPN-ის გამოყენებას შეგიძლიათ განაგრძოთ და მოგვიანებით სცადეთ ხელახლა.';

  @override
  String get guest_secureStorageError =>
      'სესიის დაცვა ამ მოწყობილობაზე ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get guest_premiumRequired =>
      'თქვენი VPN-ის გასააქტიურებლად აირჩიეთ გამოწერა.';

  @override
  String get welcome_viewPlans => 'გეგმების ნახვა';

  @override
  String get google_continue => 'გაგრძელება Google-ით';

  @override
  String get google_or => 'ან';

  @override
  String get google_title => 'თქვენი FuzeVPN-ის ანგარიში';

  @override
  String get google_settingUp => 'დაასრულეთ ანგარიშის შექმნა';

  @override
  String get google_country => 'საცხოვრებელი ქვეყანა';

  @override
  String get google_profileDescription =>
      'აირჩიეთ თქვენი ქვეყანა და გადახედეთ ორ დოკუმენტს FuzeVPN-ის ანგარიშის შესაქმნელად.';

  @override
  String get google_claimDescription =>
      'მიაბით თქვენი სტუმრის ანგარიში Google-ს. თქვენი გამოწერა და მოწყობილობა ამ ანგარიშზე დარჩება მიბმული.';

  @override
  String get google_linkTitle => 'Google-ის მიბმა FuzeVPN-ზე';

  @override
  String get google_linkDescription =>
      'დაადასტურეთ წვდომა არსებულ FuzeVPN-ის ანგარიშზე. ეს ნაბიჯი თქვენს Google პაროლს არ მოითხოვს.';

  @override
  String get google_password => 'FuzeVPN-ის პაროლი';

  @override
  String get google_linkAccount => 'მიბმის დადასტურება';

  @override
  String get google_requestEmail => 'დადასტურების ელფოსტის გამოგზავნა';

  @override
  String get google_emailInstructions =>
      'გახსენით FuzeVPN-ის ელფოსტა და შეიყვანეთ დადასტურების კოდი.';

  @override
  String get google_emailCode => 'ელფოსტით დადასტურების კოდი';

  @override
  String get google_confirmEmail => 'კოდის დადასტურება';

  @override
  String get google_restart => 'სხვა Google ანგარიშის არჩევა';

  @override
  String get google_resume => 'ამ მცდელობის შემოწმება';

  @override
  String get google_unavailable =>
      'Google-ით შესვლა ხელმისაწვდომი არ არის. შეგიძლიათ გამოიყენოთ ელფოსტა და პაროლი.';

  @override
  String get google_expired =>
      'ეს მცდელობა ვადაგასულია. გააუქმეთ იგი და ხელახლა დაიწყეთ.';

  @override
  String get google_conflict =>
      'ეს Google ანგარიში უკვე სხვაგან არის მიბმული. თქვენი მიმდინარე ანგარიში და გამოწერა შენარჩუნებულია.';

  @override
  String get google_error =>
      'Google-ით შესვლა ვერ მოხერხდა. სცადეთ ხელახლა; თქვენი მიმდინარე წვდომა შენარჩუნებულია.';

  @override
  String get google_uncertain =>
      'შედეგის დადასტურება ვერ მოხერხდა. ხელახლა დაწყებამდე შეამოწმეთ ეს მცდელობა ან გააუქმეთ.';

  @override
  String get google_cancelFailed =>
      'გაუქმება ვერ დადასტურდა. ეკრანიდან გასვლამდე სცადეთ ხელახლა გაუქმება.';

  @override
  String get google_cancelled => 'Google-ით შესვლა გაუქმდა.';

  @override
  String get google_selecting => 'აირჩიეთ თქვენი Google ანგარიში…';

  @override
  String get google_verifying => 'თქვენი ანგარიშის შემოწმება…';

  @override
  String get google_emailUnavailable =>
      'დადასტურების ელფოსტის გაგზავნა ვერ მოხერხდა. სცადეთ მოგვიანებით.';

  @override
  String get google_emailSent =>
      'დადასტურების ელფოსტა გაიგზავნა. შეამოწმეთ შემომავალი წერილები.';

  @override
  String get google_rateLimited =>
      'გთხოვთ, ცოტა ხანს დაელოდეთ და ხელახლა სცადეთ.';

  @override
  String get google_busy =>
      'Google ხელმისაწვდომი არ არის, სანამ სხვა ოპერაცია მიმდინარეობს (VPN-ის კავშირი, ანგარიში ან სტუმარი). სცადეთ ხელახლა, როცა ის დასრულდება; თქვენი მიმდინარე წვდომა შენარჩუნებულია.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN-ის პაროლი არასწორია. თქვენი მიმდინარე ანგარიში შენარჩუნებულია.';

  @override
  String get google_invalidCode =>
      'დადასტურების კოდი არასწორია ან ვადაგასულია.';

  @override
  String get google_accountChanged =>
      'თქვენი სესია შეიცვალა. ხელახლა დაწყებამდე გააუქმეთ ეს მცდელობა.';

  @override
  String get google_invalidResponse =>
      'პასუხის დადასტურება ვერ მოხერხდა. თქვენი მიმდინარე წვდომა შენარჩუნებულია.';

  @override
  String get google_invalidRegistration =>
      'შეამოწმეთ თქვენი ქვეყანა და ორივე თანხმობა.';

  @override
  String get google_consentRequired =>
      'გასაგრძელებლად აირჩიეთ თქვენი ქვეყანა და დაეთანხმეთ ორივე დოკუმენტს.';

  @override
  String get google_challengeRequired =>
      'საჭიროა დამატებითი უსაფრთხოების შემოწმება. თქვენი მიმდინარე წვდომა შენარჩუნებულია.';

  @override
  String get google_challengeUnavailable =>
      'უსაფრთხოების შემოწმება ხელმისაწვდომი არ არის. სცადეთ მოგვიანებით.';

  @override
  String get google_intentMismatch =>
      'Google-ით შესვლის წინა მცდელობა ჯერ კიდევ მოლოდინშია. ამ ოპერაციის დაწყებამდე გააუქმეთ იგი.';

  @override
  String get google_challengeBlocked =>
      'საჭირო უსაფრთხოების შემოწმება ამ აპში ხელმისაწვდომი არ არის. ამ ოპერაციის დასრულება ახლა შეუძლებელია.';

  @override
  String get google_solveChallenge => 'უსაფრთხოების შემოწმების დასრულება';

  @override
  String get google_challengeTitle => 'უსაფრთხოების შემოწმება';

  @override
  String get google_challengeReady =>
      'შემოწმება დასრულდა. ახლა შეგიძლიათ დაადასტუროთ ანგარიშის შექმნა.';

  @override
  String get google_challengeExpired =>
      'შემოწმების ვადა ამოიწურა. დადასტურებამდე ხელახლა დაასრულეთ ის.';

  @override
  String get google_challengeCancelled =>
      'შემოწმება გაუქმდა. შეგიძლიათ ხელახლა სცადოთ.';

  @override
  String get google_challengeFailed =>
      'უსაფრთხოების შემოწმება წარუმატებლად დასრულდა. სცადეთ ხელახლა.';

  @override
  String get billing_trialTitle => 'სცადეთ Fuze Premium უფასოდ';

  @override
  String get billing_trialSubtitle => 'დაიცავით თქვენი კავშირი დღესვე.';

  @override
  String get billing_trialWeeks => '2-კვირიანი უფასო საცდელი პერიოდი';

  @override
  String billing_trialDays(String days) {
    return '$days-დღიანი უფასო საცდელი პერიოდი';
  }

  @override
  String get billing_trialStart => 'უფასო საცდელი პერიოდის დაწყება';

  @override
  String billing_trialFirstCharge(String date) {
    return 'თუ დღეს დაიწყებთ, პირველი ჩამოწერის მოსალოდნელი თარიღია $date.';
  }

  @override
  String get billing_trialTerms =>
      'ავტომატურად განახლდება მითითებული ფასით. ჩამოწერის თავიდან ასაცილებლად გააუქმეთ Google Play-ში საცდელი პერიოდის დასრულებამდე.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'შემდეგ $price თვეში';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'შემდეგ $price წელიწადში';
  }

  @override
  String get billing_choosePeriod => 'აირჩიეთ თქვენი გეგმა';

  @override
  String get billing_selectionHint => 'გასაგრძელებლად აირჩიეთ გეგმა.';

  @override
  String get billing_benefitConnection => 'დაშიფრული კავშირი';

  @override
  String get billing_benefitPrivacy => 'ონლაინ კონფიდენციალურობა';

  @override
  String get billing_benefitNoAccount => 'რეგისტრაცია არ არის საჭირო';

  @override
  String get billing_cancellation => 'გაუქმება Google Play-ში';

  @override
  String get billing_premiumTitle => 'უფრო დაცული კავშირი.';

  @override
  String get billing_premiumSubtitle =>
      'დაიცავით კავშირი ისე, როგორც თქვენთვის მოსახერხებელია.';

  @override
  String get billing_priceMonthly => 'თვეში';

  @override
  String get billing_priceYearly => 'წელიწადში';

  @override
  String get billing_trialToday => 'დღეს გადასახდელი არაფერია';

  @override
  String get billing_trialConfirmation =>
      'Google Play დაადასტურებს თარიღებს, საბოლოო თანხასა და გადასახადებს, სანამ თქვენ დაადასტურებთ.';

  @override
  String get billing_offerChanged =>
      'ამ შეთავაზების პირობები შეიცვალა. განაახლეთ გეგმები და ხელახლა აირჩიეთ.';

  @override
  String get status_waitingNetwork => 'ქსელის მოლოდინში';

  @override
  String get status_waitingNetworkDetail =>
      'ქსელი ხელმისაწვდომი არ არის. ქსელის დაბრუნებისას VPN კავშირს შეამოწმებს.';

  @override
  String get locations_favoriteLoadFailed =>
      'რჩეულების ჩატვირთვა ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get locations_favoritesLoading => 'რჩეულები იტვირთება…';
}
