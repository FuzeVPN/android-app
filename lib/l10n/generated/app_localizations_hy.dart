// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Պաշտպանեք ձեր կապը';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN-ն օգտագործում է Android-ի VPN ծառայությունը (VpnService)՝ այս սարքի և FuzeVPN սերվերների միջև գաղտնագրված թունել ստեղծելու համար։';

  @override
  String get vpnDisclosure_dataBody =>
      'Երբ VPN-ն ակտիվ է, ձեր հավելվածների ինտերնետ տրաֆիկը, նպատակակետի հասցեները և DNS հարցումներն անցնում են այս թունելով՝ ձեր կապն ուղղորդելու համար, նույնիսկ երբ FuzeVPN-ը ֆոնային ռեժիմում է։';

  @override
  String get vpnDisclosure_statusBody =>
      'Հավելվածն օգտագործում է կապի կարգավիճակը, դրա տևողությունը և փոխանցված տվյալների քանակը՝ ձեր VPN կապը ցուցադրելու համար։ Կարող եք այն դադարեցնել ցանկացած պահի։';

  @override
  String get vpnDisclosure_privacy => 'Գաղտնիություն';

  @override
  String get vpnDisclosure_accept => 'Ընդունել և շարունակել';

  @override
  String get vpnDisclosure_decline => 'Ոչ հիմա';

  @override
  String get accountRestoration_title => 'Հաշիվը ժամանակավորապես անհասանելի է';

  @override
  String get accountRestoration_message =>
      'Ձեր սեսիան պահպանվել է։ Նորից փորձեք՝ հաշիվը վերականգնելու համար։ Այստեղ դեռ կարող եք կառավարել VPN կապը։';

  @override
  String get action_retry => 'Նորից փորձել';

  @override
  String get session_endingTitle => 'Սեսիայի ավարտում';

  @override
  String get session_ending =>
      'Սեսիան ավարտվում է։ VPN-ը դադարեցվում է, տվյալները մաքրվում են…';

  @override
  String get session_stopFailed =>
      'VPN-ի անջատումը չի հաստատվել։ Նորից փորձեք, նախքան կրկին մուտք գործելը։';

  @override
  String get session_cleanupFailed =>
      'VPN-ը դադարեցված է, բայց սեսիայի հեռացումը չի հաստատվել։ Նորից փորձեք մաքրումը։';

  @override
  String get session_retryStop => 'Նորից փորձել անջատումը';

  @override
  String get session_retryCleanup => 'Նորից փորձել մաքրումը';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN-ն անվտանգ նախապատրաստվում է…';

  @override
  String get nav_connection => 'Կապ';

  @override
  String get nav_locations => 'Վայրեր';

  @override
  String get nav_account => 'Հաշիվ';

  @override
  String get nav_devices => 'Սարքեր';

  @override
  String get nav_settings => 'Կարգավորումներ';

  @override
  String get action_refresh => 'Թարմացնել';

  @override
  String get auth_tab_login => 'Մուտք գործել';

  @override
  String get auth_tab_register => 'Գրանցվել';

  @override
  String get auth_stepAccount => 'Հաշիվ';

  @override
  String get auth_stepIdentity => 'Ինքնություն';

  @override
  String get auth_stepAddress => 'Հասցե և համաձայնություններ';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Քայլ $current / $total';
  }

  @override
  String get auth_tagline => 'Ձեր VPN-ը՝ պարզ և հարմար։';

  @override
  String get auth_keysLocal =>
      'Ձեր գաղտնի VPN բանալիները մնում են այս սարքում։';

  @override
  String get form_email => 'Էլփոստի հասցե';

  @override
  String get form_password => 'Գաղտնաբառ';

  @override
  String get form_showPassword => 'Ցույց տալ գաղտնաբառը';

  @override
  String get form_hidePassword => 'Թաքցնել գաղտնաբառը';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 բայթ։ Որոշ նիշեր զբաղեցնում են մեկից ավելի բայթ։';

  @override
  String get form_firstName => 'Անուն';

  @override
  String get form_lastName => 'Ազգանուն';

  @override
  String get form_phone => 'Հեռախոս (+33612345678)';

  @override
  String get form_address => 'Հասցե';

  @override
  String get form_address2 => 'Հասցեի լրացուցիչ տող (ոչ պարտադիր)';

  @override
  String get form_postalCode => 'Փոստային ինդեքս';

  @override
  String get form_city => 'Քաղաք';

  @override
  String get form_country => 'Երկրի կոդ (օրինակ՝ FR)';

  @override
  String get action_login => 'Մուտք գործել';

  @override
  String get action_createAccount => 'Ստեղծել հաշիվ';

  @override
  String get action_createMyAccount => 'Ստեղծել իմ հաշիվը';

  @override
  String get action_next => 'Շարունակել';

  @override
  String get action_previous => 'Հետ';

  @override
  String get action_forgotPassword => 'Մոռացե՞լ եք գաղտնաբառը';

  @override
  String get auth_noAccount => 'Դեռ հաշիվ չունե՞ք';

  @override
  String get auth_requiredInformation => 'Ստեղծեք ձեր հաշիվը երեք քայլով։';

  @override
  String get auth_termsPrefix => 'Ես ընդունում եմ ';

  @override
  String get auth_termsLink => 'օգտագործման պայմանները';

  @override
  String get auth_privacyPrefix => 'Ես ընդունում եմ ';

  @override
  String get auth_privacyLink => 'գաղտնիության քաղաքականությունը';

  @override
  String get auth_consentRequired =>
      'Հաշիվ ստեղծելու համար անհրաժեշտ է ձեր համաձայնությունը։';

  @override
  String get validation_required => 'Այս դաշտը պարտադիր է։';

  @override
  String get validation_email => 'Մուտքագրեք վավեր էլփոստի հասցե։';

  @override
  String get validation_password =>
      'Գաղտնաբառը շատ կարճ է։ Անհրաժեշտ է առնվազն 8 UTF-8 բայթ։';

  @override
  String get validation_passwordTooLong =>
      'Գաղտնաբառը շատ երկար է։ Թույլատրվում է առավելագույնը 72 UTF-8 բայթ։';

  @override
  String get validation_phone =>
      'Օգտագործեք միջազգային ձևաչափ, օրինակ՝ +33612345678։';

  @override
  String get validation_country =>
      'Օգտագործեք երկու տառից բաղկացած երկրի կոդ, օրինակ՝ FR։';

  @override
  String get passwordReset_title => 'Գաղտնաբառի վերականգնում';

  @override
  String get passwordReset_description =>
      'Մուտքագրեք ձեր հաշվի էլփոստի հասցեն՝ գաղտնաբառի վերականգնման հղում ստանալու համար։';

  @override
  String get passwordReset_send => 'Ուղարկել հղումը';

  @override
  String get connection_title => 'Ձեր կապը';

  @override
  String get connection_subtitle => 'Ընտրեք վայր, ապա միացրեք ձեր VPN-ը։';

  @override
  String get connection_prepare => 'Պատրա՞ստ եք միանալ';

  @override
  String get connection_advancedOptions => 'Լրացուցիչ կարգավորումներ';

  @override
  String get connection_location => 'Վայր';

  @override
  String get connection_chooseLocation => 'Ընտրեք վայր';

  @override
  String get connection_protocol => 'Պրոտոկոլ';

  @override
  String get connection_connect => 'Միանալ';

  @override
  String get connection_connecting => 'Միանում է…';

  @override
  String get connection_disconnect => 'Անջատել';

  @override
  String get connection_disconnecting => 'Անջատվում է';

  @override
  String get connection_locationChange => 'Վայրը փոխվում է…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol անհասանելի է';
  }

  @override
  String get connection_activeLocation => 'Ակտիվ վայր';

  @override
  String get connection_duration => 'Տևողություն';

  @override
  String get connection_received => 'Ստացված';

  @override
  String get connection_sent => 'Ուղարկված';

  @override
  String get connection_lastHandshake => 'Վերջին անվտանգ փոխանակում';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration առաջ';
  }

  @override
  String get verification_title => 'Հաստատեք ձեր էլփոստի հասցեն';

  @override
  String get verification_message =>
      'Հաստատեք ձեր էլփոստի հասցեն՝ այս հեռախոսում VPN-ն օգտագործելու համար։';

  @override
  String get verification_resend => 'Նորից ուղարկել նամակը';

  @override
  String get migration_title => 'Վայրի փոփոխություն';

  @override
  String get migration_draining => 'Վայրի փոփոխությունը նախապատրաստվում է…';

  @override
  String get migration_activating => 'Նոր սերվերն ակտիվացվում է…';

  @override
  String get migration_ready => 'Վայրը թարմացվել է։';

  @override
  String get migration_blocked =>
      'Վայրի փոփոխությունը պահանջում է սերվերի միջամտություն։ Նորից փորձեք ավելի ուշ կամ դիմեք աջակցության ծառայությանը։';

  @override
  String get migration_progress => 'Վայրի փոփոխության առաջընթաց';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Ստուգումների միջև ընդմիջում՝ $seconds վրկ։';
  }

  @override
  String get migration_resume => 'Շարունակել վայրի փոփոխությունը';

  @override
  String get status_authorizing => 'Պահանջվում է թույլատրում';

  @override
  String get status_authorizingDetail =>
      'Ընդունեք Android-ի հարցումը՝ VPN-ին թույլտվություն տալու համար։';

  @override
  String get status_preparing => 'Պատրաստվում է';

  @override
  String get status_preparingDetail => 'Ձեր անվտանգ կապը նախապատրաստվում է։';

  @override
  String get status_reconnecting => 'Նորից միանում է…';

  @override
  String get status_reconnectingDetail =>
      'Կապն ընդհատվել է։ VPN-ը փորձում է նորից միանալ։';

  @override
  String get status_connecting => 'Միանում է';

  @override
  String get status_connectingDetail => 'Միանում է VPN սերվերին…';

  @override
  String get status_connected => 'Միացված է';

  @override
  String get status_connectedDetail => 'Ձեր VPN կապն ակտիվ է։';

  @override
  String get status_disconnecting => 'Անջատվում է';

  @override
  String get status_disconnectingDetail => 'Ձեր VPN կապը դադարեցվում է։';

  @override
  String get status_error => 'Կապն անհասանելի է';

  @override
  String get status_errorDetail => 'VPN կապը չի հաստատվել։ Նորից փորձեք։';

  @override
  String get status_idle => 'Անջատված է';

  @override
  String get status_idleDetail => 'Միացրեք VPN-ը՝ ձեր կապը պաշտպանելու համար։';

  @override
  String get trust_note =>
      'Հավելվածը փակելը VPN-ը չի անջատում։ Այն անջատելու համար օգտագործեք «Անջատել» կոճակը։';

  @override
  String get locations_none => 'Այս պահին հասանելի վայրեր չկան։';

  @override
  String get locations_available => 'Ընտրեք հաջորդ վայրը։';

  @override
  String get locations_selected => 'Ընտրված վայր';

  @override
  String get locations_select => 'Ընտրել այս վայրը';

  @override
  String get locations_lockedTunnel => 'Վայրը փոխելու համար անջատեք VPN-ը։';

  @override
  String get locations_lockedMigration =>
      'Սպասեք, մինչև վայրի փոփոխությունն ավարտվի։';

  @override
  String get devices_title => 'Ձեր սարքերը';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit սարք';
  }

  @override
  String get devices_refresh => 'Թարմացնել սարքերը';

  @override
  String get devices_empty => 'Դեռ ոչ մի VPN սարք գրանցված չէ։';

  @override
  String get devices_firstConnection =>
      'Ձեր հեռախոսը կավելացվի առաջին միացման ժամանակ։';

  @override
  String get devices_thisDevice => 'Այս սարքը';

  @override
  String devices_added(Object date) {
    return 'Ավելացվել է՝ $date';
  }

  @override
  String get devices_unnamed => 'Անանուն սարք';

  @override
  String get action_remove => 'Հեռացնել';

  @override
  String get settings_title => 'Կարգավորումներ';

  @override
  String get settings_subtitle => 'Ձեր նախընտրանքներն ու հաշիվը՝ մեկ տեղում։';

  @override
  String get settings_appearance => 'Արտաքին տեսք';

  @override
  String get settings_language => 'Լեզու';

  @override
  String get settings_languageDescription =>
      'Ընտրված լեզուն կիրառվում է նաև VPN ծանուցումների համար։';

  @override
  String get settings_account => 'Հաշիվ';

  @override
  String get settings_signOut => 'Դուրս գալ';

  @override
  String get settings_privacy => 'Գաղտնիության քաղաքականություն';

  @override
  String get settings_terms => 'Օգտագործման պայմաններ';

  @override
  String get settings_security => 'Անվտանգություն և թափանցիկություն';

  @override
  String get settings_licenses => 'Բաղադրիչների լիցենզիաներ';

  @override
  String get settings_licensesDetail => 'Հավելվածում օգտագործվող ծրագրեր';

  @override
  String settings_licensesLegalese(String url) {
    return 'Հավելվածի և դրա MPL-2.0 բաղադրիչների սկզբնական կոդը՝ $url';
  }

  @override
  String get settings_background =>
      'Հավելվածից դուրս գալիս VPN-ը մնում է միացված։ Այն անջատելու համար օգտագործեք «Կապ» ներդիրի «Անջատել» կոճակը։';

  @override
  String get theme_system => 'Համակարգային';

  @override
  String get theme_light => 'Բաց';

  @override
  String get theme_dark => 'Մուգ';

  @override
  String get language_system => 'Հեռախոսի լեզուն';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Հեռացնե՞լ այս սարքը';

  @override
  String get dialog_removeCurrent =>
      'Այս հեռախոսը VPN-ից կանջատվի և կկորցնի հասանելիությունը։ Դրա VPN կապի տվյալները կհեռացվեն սերվերի հաստատումից հետո։';

  @override
  String dialog_removeOther(Object name) {
    return '«$name» սարքի VPN հասանելիությունը կչեղարկվի։ Այս գործողությունը հնարավոր չէ հետարկել։';
  }

  @override
  String get dialog_signOut => 'Դուրս գա՞լ';

  @override
  String get dialog_signOutMessage =>
      'VPN-ը կդադարեցվի, և դուք պետք է նորից մուտք գործեք։ Ձեր գաղտնագրված VPN բանալիները կմնան այս հեռախոսում՝ հաջորդ միացման համար։';

  @override
  String get action_cancel => 'Չեղարկել';

  @override
  String get action_close => 'Փակել';

  @override
  String get action_copy => 'Պատճենել';

  @override
  String get action_renew => 'Թարմացնել';

  @override
  String get action_signOut => 'Դուրս գալ';

  @override
  String get notice_close => 'Փակել հաղորդագրությունը';

  @override
  String get notice_sessionExpired_title => 'Սեսիայի ժամկետը լրացել է';

  @override
  String get notice_sessionExpired_message =>
      'Ձեր սեսիայի ժամկետը լրացել է։ Նորից մուտք գործեք։';

  @override
  String get notice_connectionFailed_title => 'Չհաջողվեց միանալ';

  @override
  String get notice_invalidCredentials_message =>
      'Էլփոստի հասցեն կամ գաղտնաբառը սխալ է։';

  @override
  String get notice_emailVerification_title => 'Պահանջվում է էլփոստի հաստատում';

  @override
  String get notice_emailVerification_message =>
      'Նախքան VPN սարք ավելացնելը հաստատեք ձեր էլփոստի հասցեն։';

  @override
  String get notice_rateLimited_title => 'Չափազանց շատ փորձեր';

  @override
  String get notice_deviceLimit_title => 'Սարքերի սահմանաչափը սպառվել է';

  @override
  String get notice_deviceLimit_message =>
      'Նոր սարք ավելացնելուց առաջ հեռացրեք առկա սարքերից մեկը։';

  @override
  String get notice_identityRenewal_title => 'VPN ինքնությունը պետք է թարմացվի';

  @override
  String get notice_identityRenewal_message =>
      'Այս ինքնությունը հեռացվել է։ Ստեղծեք նոր տեղական ինքնություն։';

  @override
  String get notice_migrationPending_title =>
      'Վայրի փոփոխությունն ընթացքի մեջ է';

  @override
  String get notice_migrationPending_message =>
      'Վայրի փոփոխությունն արդեն ընթացքի մեջ է։';

  @override
  String get notice_migrationBlocked_title =>
      'Վայրի փոփոխությունն արգելափակված է';

  @override
  String get notice_migrationBlocked_message =>
      'Վայրի փոփոխությունը պահանջում է սերվերի միջամտություն։ Նորից փորձեք ավելի ուշ կամ դիմեք աջակցության ծառայությանը։';

  @override
  String get notice_targetUnavailable_title =>
      'Սերվերը ժամանակավորապես անհասանելի է';

  @override
  String get notice_targetUnavailable_message =>
      'Այս սերվերը ժամանակավորապես անհասանելի է։';

  @override
  String get notice_networkUnavailable_title => 'Ինտերնետ կապը հասանելի չէ';

  @override
  String get notice_networkUnavailable_message =>
      'Ստուգեք ձեր կապը և նորից փորձեք։';

  @override
  String get notice_permissionDenied_title => 'VPN-ի թույլտվությունը մերժվել է';

  @override
  String get notice_permissionDenied_message =>
      'Նորից սկսեք միացումը և ընդունեք Android-ի թույլտվության հարցումը։';

  @override
  String get notice_wireguardTimeout_title => 'Սերվերը չի պատասխանում';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard կապը չափազանց երկար տևեց։ Նորից փորձեք կամ ընտրեք այլ վայր։';

  @override
  String get notice_tlsFailed_title => 'Անվտանգ կապը մերժվել է';

  @override
  String get notice_tlsFailed_message =>
      'Սերվերը չընդունեց OpenVPN կապը։ Նորից փորձեք։ Եթե խնդիրը շարունակվի, գործարկեք ախտորոշում։';

  @override
  String get notice_tunRejected_title => 'Android-ը մերժել է VPN միջերեսը';

  @override
  String get notice_tunRejected_message =>
      'Android-ը մերժել է OpenVPN-ի պահանջած ցանցի կազմաձևումը։';

  @override
  String get notice_openvpnStart_title => 'OpenVPN-ը չհաջողվեց գործարկել';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN շարժիչը չկարողացավ ամբողջությամբ գործարկվել։ Նորից փորձեք։ Եթե խնդիրը շարունակվի, դիմեք աջակցության ծառայությանը։';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Ախտորոշման կոդ՝ $code';
  }

  @override
  String get notice_generic_title => 'Չհաջողվեց միանալ VPN-ին';

  @override
  String get notice_generic_message =>
      'Սխալ է տեղի ունեցել։ Նորից փորձեք ավելի ուշ։';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Հաշիվը ստեղծվել է',
      'password_reset_sent': 'Գաղտնաբառի վերականգնման հարցումը ստացվել է',
      'verification_email_sent': 'Հաստատման նամակն ուղարկվել է',
      'location_migration_pending': 'Վայրի փոփոխությունն ընթացքի մեջ է',
      'vpn_sign_in_required': 'Պահանջվում է մուտք գործել',
      'protocol_unavailable_at_location': 'Պրոտոկոլն անհասանելի է',
      'vpn_permission_denied': 'VPN-ի թույլտվությունը մերժվել է',
      'revoked_identity_device_limit': 'Սարքերի սահմանաչափը սպառվել է',
      'tunnel_start_unexpected': 'VPN-ը չհաջողվեց գործարկել',
      'flutter_disconnect_timeout': 'Անջատումը չի հաստատվել',
      'flutter_disconnect_unexpected': 'Չհաջողվեց անջատել',
      'device_revoked': 'Սարքը հեռացվել է',
      'revoke_unexpected': 'Սարքը չհաջողվեց հեռացնել',
      'identity_renewal_unexpected': 'Ինքնությունը չհաջողվեց թարմացնել',
      'openvpn_renewal_unexpected': 'OpenVPN պրոֆիլը չհաջողվեց թարմացնել',
      'location_migration_blocked': 'Վայրի փոփոխությունն արգելափակված է',
      'location_migration_slow': 'Վայրի փոփոխությունը դեռ ընթացքի մեջ է',
      'location_migration_conflict': 'Վայրի փոփոխությունը պետք է թարմացվի',
      'location_migration_verification_failed':
          'Վայրի փոփոխությունը չի հաստատվել',
      'location_migration_device_changed':
          'Սարքը փոխվել է վայրի փոփոխության ընթացքում',
      'tunnel_stop_failed': 'Վայրի փոփոխությունը հասանելի չէ',
      'device_clock_ahead': 'Սարքի ժամացույցն առաջ է',
      'other': 'Գործողությունը չհաջողվեց',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Հաշիվը ստեղծվել է, բայց հաստատման նամակը չհաջողվեց ուղարկել։ Օգտագործեք հավելվածի «Նորից ուղարկել» գործողությունը։',
      'password_reset_sent':
          'Ձեր հարցումը ստացվել է։ Եթե այս հասցեին համապատասխանող հաշիվ կա, կարող եք նամակ ստանալ։ Ստուգեք նաև սպամի թղթապանակը։',
      'verification_email_sent': 'Նոր հաստատման նամակն արդեն ուղարկվել է։',
      'location_migration_pending':
          'Դեպի $target տեղափոխումը դեռ նախապատրաստվում է։ Կարող եք այն շարունակել՝ առանց սարքը նորից ստեղծելու։',
      'vpn_sign_in_required': 'Նախքան VPN-ը գործարկելը մուտք գործեք ձեր հաշիվ։',
      'protocol_unavailable_at_location':
          'Ընտրված պրոտոկոլն այս վայրում չի առաջարկվում։ Թարմացրեք վայրերը կամ ընտրեք այլ պրոտոկոլ։',
      'vpn_permission_denied':
          'Android-ը մերժել է VPN-ի թույլտվությունը։ Նորից սկսեք միացումը և ընդունեք համակարգի հարցումը։',
      'revoked_identity_device_limit':
          'Այս սարքի VPN հասանելիությունը հեռացվել է, և սարքերի սահմանաչափը սպառվել է։ Հեռացրեք սարք «Հաշիվ → Կառավարել իմ սարքերը» բաժնում։',
      'tunnel_start_unexpected':
          'Անսպասելի սխալն ընդհատեց թունելի նախապատրաստումը։ Ստուգեք ախտորոշման կոդը և նորից փորձեք։',
      'flutter_disconnect_timeout':
          'Android-ը ժամանակին չհաստատեց, որ VPN-ը դադարել է։ Նորից փորձեք այն դադարեցնել։',
      'flutter_disconnect_unexpected':
          'Անսպասելի սխալի պատճառով չհաջողվեց հաստատել թունելի դադարեցումը։',
      'device_revoked':
          'Սարքի VPN հասանելիությունը չեղարկվել է, և դրա տեղական գաղտնի տվյալները հեռացվել են։',
      'revoke_unexpected':
          'Սարքը չհաջողվեց հեռացնել։ Թարմացրեք ցանկը և նորից փորձեք։',
      'identity_renewal_unexpected':
          'Նոր VPN ինքնությունը չհաջողվեց ստեղծել։ Թարմացրեք սարքերը և նորից փորձեք։',
      'openvpn_renewal_unexpected':
          'OpenVPN պրոֆիլը չհաջողվեց թարմացնել։ Նորից փորձեք կամ ստուգեք ախտորոշման կոդը։',
      'location_migration_blocked':
          'Սերվերը հիմա չի կարող ավարտել այս փոփոխությունը։ Սարքը և դրա տեղական ինքնությունը պահպանվել են։',
      'location_migration_slow':
          'Սերվերը դեռ նախապատրաստում է տեղափոխումը դեպի $target։ Մի փոքր անց օգտագործեք «Շարունակել» կոճակը։',
      'location_migration_conflict':
          'Սարքի վիճակը փոխվել է սերվերում։ Թարմացրեք սարքերը, ապա շարունակեք վայրի փոփոխությունը։',
      'location_migration_verification_failed':
          'Սերվերը չհաստատեց նոր վայրը։ Նախորդ տեղական ինքնությունը պահպանվել է։',
      'location_migration_device_changed':
          'Սերվերի վերադարձրած սարքն այլևս չի համապատասխանում փոփոխվող սարքին։ Նորից փորձելուց առաջ թարմացրեք սարքերը։',
      'tunnel_stop_failed':
          'Նոր կապը միացնելուց առաջ նախորդ թունելը պետք է լրիվ դադարեցվի։',
      'device_clock_ahead':
          'Այս սարքի ժամացույցը, կարծես, առաջ է ընկել։ Միացրեք ավտոմատ ամսաթիվն ու ժամը, որպեսզի մնաք մուտք գործած։',
      'other':
          'Գործողությունը չհաջողվեց ավարտել։ Նորից փորձեք կամ ուղարկեք ախտորոշման կոդն աջակցության ծառայությանը։',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Սեսիայի ժամկետը լրացել է',
      'invalid_credentials': 'Չհաջողվեց մուտք գործել',
      'email_verification_required': 'Պահանջվում է էլփոստի հաստատում',
      'verification_email_cooldown': 'Նամակն արդեն ուղարկվել է',
      'rate_limited': 'Չափազանց շատ փորձեր',
      'invalid_registration': 'Տվյալները պետք է ուղղվեն',
      'email_exists': 'Հաշիվն արդեն գոյություն ունի',
      'invalid_profile': 'Անվավեր պրոֆիլ',
      'invalid_device': 'Անվավեր սարք',
      'invalid_location': 'Վայրը հասանելի չէ',
      'device_limit': 'Սարքերի սահմանաչափը սպառվել է',
      'device_exists': 'VPN ինքնությունն արդեն օգտագործվում է',
      'device_identity_revoked': 'VPN ինքնությունը պետք է թարմացվի',
      'device_location_locked': 'Վայրի փոփոխությունը պետք է թարմացվի',
      'location_migration_pending': 'Վայրի փոփոխությունն ընթացքի մեջ է',
      'location_migration_blocked': 'Վայրի փոփոխությունն արգելափակված է',
      'target_ca_mismatch': 'Անհամատեղելի OpenVPN սերվեր',
      'location_migration_conflict': 'Վայրի փոփոխությունը պետք է թարմացվի',
      'server_full': 'Սերվերը լցված է',
      'capacity_unavailable': 'Վայրը ժամանակավորապես անհասանելի է',
      'target_unavailable': 'Սերվերը ժամանակավորապես անհասանելի է',
      'not_found': 'Տարրը չի գտնվել',
      'invalid_openvpn_csr': 'Անվավեր OpenVPN ինքնություն',
      'openvpn_profile_exists': 'OpenVPN պրոֆիլն արդեն գոյություն ունի',
      'openvpn_profile_revoked': 'OpenVPN պրոֆիլը չեղարկված է',
      'openvpn_operation_pending': 'OpenVPN գործողությունն ընթացքի մեջ է',
      'openvpn_operation_terminal': 'OpenVPN գործողությունն ընդհատվել է',
      'openvpn_address_unavailable': 'OpenVPN հասցեն հասանելի չէ',
      'openvpn_profile_conflict': 'OpenVPN-ի հակասություն',
      'openvpn_signer_unavailable': 'OpenVPN-ը հասանելի չէ',
      'email_delivery_unavailable': 'Նամակների ուղարկումը հասանելի չէ',
      'invalid_token': 'Անվավեր հղում',
      'network_unavailable': 'Ինտերնետ կապը հասանելի չէ',
      'invalid_json': 'Անվավեր հարցում',
      'invalid_api_response': 'Անվավեր սերվերի պատասխան',
      'ipv6_unavailable': 'IPv6-ը հասանելի չէ',
      'invalid_ip_families': 'Ցանցի կազմաձևումը մերժվել է',
      'other': 'Ծառայությունը հասանելի չէ',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Ձեր սեսիայի ժամկետը լրացել է։ Նորից մուտք գործեք։',
      'invalid_credentials': 'Էլփոստի հասցեն կամ գաղտնաբառը սխալ է։',
      'email_verification_required':
          'Նախքան VPN սարք ավելացնելը հաստատեք ձեր էլփոստի հասցեն։',
      'invalid_registration':
          'Ստուգեք պահանջված տվյալները և համաձայնությունները։',
      'email_exists': 'Այս էլփոստի հասցեով արդեն կա հաշիվ։',
      'invalid_profile': 'Ստուգեք ձեր պրոֆիլի տվյալները։',
      'invalid_device': 'Այս սարքի անունը կամ տեղական ինքնությունն անվավեր է։',
      'invalid_location': 'Թարմացրեք վայրերի ցանկը և նորից փորձեք։',
      'device_limit': 'Նոր սարք ավելացնելուց առաջ հեռացրեք առկա սարքերից մեկը։',
      'device_exists': 'Այս VPN ինքնությունն արդեն կապված է այլ հաշվի հետ։',
      'device_identity_revoked':
          'Այս ինքնությունը հեռացվել է։ Պետք է ստեղծվի նոր տեղական ինքնություն։',
      'device_location_locked':
          'Այս սարքի վայրը հենց նոր փոխվել է։ Հավելվածը կշարունակի ընթացիկ փոփոխությունը։',
      'location_migration_pending': 'Վայրի փոփոխությունն արդեն ընթացքի մեջ է։',
      'location_migration_blocked':
          'Վայրի փոփոխությունը պահանջում է սերվերի միջամտություն։ Նորից փորձեք ավելի ուշ կամ դիմեք աջակցության ծառայությանը։',
      'target_ca_mismatch':
          'Այս սերվերը դեռ համատեղելի չէ ընթացիկ OpenVPN պրոֆիլի հետ։',
      'location_migration_conflict':
          'Թարմացրեք սարքերը և նորից փորձեք վայրի փոփոխությունը։',
      'server_full':
          'Այս վայրը հասել է միացումների սահմանին։ Ընտրեք այլ վայր կամ նորից փորձեք ավելի ուշ։',
      'capacity_unavailable':
          'Չենք կարող հաստատել, արդյոք այս վայրն այս պահին հասանելի է։ Ընտրեք այլ վայր կամ նորից փորձեք ավելի ուշ։',
      'target_unavailable': 'Այս սերվերը ժամանակավորապես անհասանելի է։',
      'not_found': 'Այս տարրն այլևս հասանելի չէ ձեր հաշվում։',
      'invalid_openvpn_csr': 'Ստեղծեք նոր OpenVPN ինքնություն և նորից փորձեք։',
      'openvpn_profile_exists': 'Այս սարքի համար արդեն կա OpenVPN պրոֆիլ։',
      'openvpn_profile_revoked':
          'Շարունակելու համար թարմացրեք OpenVPN պրոֆիլը։',
      'openvpn_operation_pending':
          'Փոփոխությունը դեռ տարածվում է։ Նորից փորձեք ավելի ուշ։',
      'openvpn_operation_terminal':
          'Ստեղծեք նոր OpenVPN ինքնություն և նորից փորձեք։',
      'openvpn_address_unavailable': 'OpenVPN հասցե այս պահին հասանելի չէ։',
      'openvpn_profile_conflict':
          'Պրոֆիլը փոխվել է։ Թարմացրեք սարքերը և նորից փորձեք։',
      'openvpn_signer_unavailable':
          'OpenVPN ծառայությունը ժամանակավորապես անհասանելի է։',
      'email_delivery_unavailable':
          'Նամակը չհաջողվեց ուղարկել։ Նորից փորձեք ավելի ուշ։',
      'invalid_token':
          'Այս հղումն անվավեր է կամ ժամկետն անցել է։ Պահանջեք նորը։',
      'network_unavailable': 'Ստուգեք ձեր ինտերնետ կապը և նորից փորձեք։',
      'invalid_json': 'Ստուգեք մուտքագրված տվյալները և նորից փորձեք։',
      'invalid_api_response':
          'Սերվերն անսպասելի պատասխան վերադարձրեց։ Նորից փորձեք ավելի ուշ։',
      'ipv6_unavailable':
          'Սերվերն այս պահին չի կարող միացնել IPv6-ը։ Նորից փորձեք ավելի ուշ։',
      'invalid_ip_families':
          'Թունելի կազմաձևումը թերի է կամ չի համապատասխանում թույլատրված հասցեներին։ Նորից փորձեք հավելվածից։',
      'other': 'Սերվերում սխալ է տեղի ունեցել։ Նորից փորձեք ավելի ուշ։',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Նորից փորձեք մի փոքր անց։';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Նորից փորձեք $seconds վայրկյան անց։',
      one: 'Նորից փորձեք $seconds վայրկյան անց։',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Նորից փորձեք $minutes րոպե անց։',
      one: 'Նորից փորձեք $minutes րոպե անց։',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Նորից փորձեք $hours ժամ անց։',
      one: 'Նորից փորձեք $hours ժամ անց։',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Համակարգային VPN-ի վերսկսումը հասանելի չէ',
      'system_vpn_resume_corrupt': 'Անվավեր համակարգային VPN-ի վերսկսում',
      'system_vpn_resume_session_invalid': 'Անվավեր VPN-ի վերսկսման սեսիա',
      'system_vpn_resume_identity_changed': 'VPN-ի ինքնությունը փոխվել է',
      'system_vpn_resume_identity_invalid':
          'Անվավեր VPN-ի վերսկսման ինքնություն',
      'system_vpn_resume_storage_failed': 'VPN-ի վերսկսման պահոցը հասանելի չէ',
      'system_vpn_resume_network_timeout': 'VPN-ի վերսկսման համար ցանց չկա',
      'system_vpn_resume_blocked': 'VPN-ի վերսկսումն արգելափակված է',
      'system_vpn_resume_failed': 'VPN-ի վերսկսումը չհաջողվեց',
      'system_vpn_resume_error_invalid': 'VPN-ի վերսկսման անվավեր սխալ',
      'wireguard_identity_store_failed':
          'WireGuard-ի ինքնությունը չի պահպանվել',
      'wireguard_identity_unavailable': 'WireGuard-ի ինքնությունը հասանելի չէ',
      'vpn_host_destroyed': 'Android-ի VPN բաղադրիչը դադարեցվել է',
      'vpn_host_unavailable': 'Android-ի VPN բաղադրիչը հասանելի չէ',
      'vpn_permission_required': 'Պահանջվում է VPN-ի թույլտվություն',
      'vpn_permission_denied': 'VPN-ի թույլտվությունը մերժվել է',
      'vpn_permission_request_failed': 'Չհաջողվեց թույլտվություն խնդրել',
      'wireguard_foreground_service_unavailable':
          'WireGuard ծառայությունը հասանելի չէ',
      'wireguard_identity_invalid': 'Անվավեր տեղական WireGuard բանալի',
      'wireguard_identity_in_use':
          'WireGuard-ի ինքնությունն արդեն օգտագործվում է',
      'wireguard_configuration_invalid': 'Անվավեր WireGuard կազմաձևում',
      'wireguard_operation_pending': 'WireGuard-ի գործողությունը դեռ ակտիվ է',
      'wireguard_start_failed': 'WireGuard-ի մեկնարկը մերժվել է',
      'wireguard_stop_timeout': 'WireGuard-ի դադարեցումը չի հաստատվել',
      'wireguard_handshake_timeout': 'WireGuard-ը չի պատասխանում',
      'openvpn_connection_timeout': 'OpenVPN-ը չի պատասխանում',
      'openvpn_core_unavailable': 'OpenVPN շարժիչը հասանելի չէ',
      'openvpn_operation_pending': 'OpenVPN սեսիան դեռ ակտիվ է',
      'openvpn_stop_timeout': 'OpenVPN-ի դադարեցումը չի հաստատվել',
      'openvpn_profile_unavailable': 'Տեղական OpenVPN պրոֆիլը բացակայում է',
      'openvpn_native_failed': 'OpenVPN-ի համակարգային կանչն ընդհատվել է',
      'openvpn_key_generation_failed':
          'Չհաջողվեց ստեղծել OpenVPN-ի P-256 բանալին',
      'openvpn_csr_generation_failed': 'Չհաջողվեց ստեղծել OpenVPN-ի CSR-ը',
      'openvpn_identity_store_failed': 'OpenVPN-ի ինքնությունը չի պահպանվել',
      'openvpn_identity_clear_failed': 'OpenVPN-ի հեռացումը թերի է',
      'openvpn_identity_in_use': 'OpenVPN-ի ինքնությունը դեռ օգտագործվում է',
      'openvpn_tls_verification_required':
          'OpenVPN-ի TLS ստուգումը բացակայում է',
      'openvpn_cipher_invalid': 'Անվավեր OpenVPN գաղտնագրում',
      'openvpn_profile_rejected': 'OpenVPN-ի պրոֆիլը մերժվել է',
      'openvpn_identity_inconsistent': 'Անհամապատասխան OpenVPN ինքնություն',
      'tls_handshake_failed': 'OpenVPN-ի բանակցությունը մերժվել է',
      'tls_alert_unknown_ca': 'OpenVPN-ի հաճախորդի վկայագիրը չի ճանաչվել',
      'tls_alert_bad_certificate': 'OpenVPN-ի հաճախորդի վկայագիրը մերժվել է',
      'tls_alert_unsupported_certificate': 'Չաջակցվող OpenVPN վկայագիր',
      'tls_client_certificate_required':
          'Պահանջվում է OpenVPN-ի հաճախորդի վկայագիր',
      'tls_alert_misc': 'OpenVPN-ի TLS ահազանգ',
      'tls_signature_algorithm_rejected': 'Չաջակցվող OpenVPN ստորագրություն',
      'tls_handshake_rejected': 'OpenVPN-ի TLS բանակցությունը մերժվել է',
      'tls_version_rejected': 'Անհամատեղելի OpenVPN TLS տարբերակ',
      'tls_certificate_expired': 'TLS վկայագիրը ժամկետանց է',
      'tls_certificate_revoked': 'TLS վկայագիրը չեղարկվել է',
      'transport_failed': 'OpenVPN սերվերն անհասանելի է',
      'tun_configuration_rejected': 'Չհաջողվեց ստեղծել OpenVPN-ի միջերեսը',
      'tun_setup_failed': 'OpenVPN TUN-ի կարգավորումը չհաջողվեց',
      'tun_interface_create_failed': 'OpenVPN-ի միջերեսի ստեղծումը չհաջողվեց',
      'tun_interface_disabled': 'OpenVPN-ի միջերեսն անջատված է',
      'tun_halted': 'OpenVPN-ի միջերեսն ընդհատվել է',
      'tun_already_established': 'OpenVPN-ի միջերեսն արդեն բաց է',
      'tun_addresses_missing': 'OpenVPN-ի հասցեն բացակայում է',
      'tun_routes_missing': 'OpenVPN-ի երթուղիները բացակայում են',
      'tun_dns_missing': 'OpenVPN-ի DNS-ը բացակայում է',
      'tun_permission_revoked': 'VPN-ի թույլտվությունը չեղարկվել է',
      'tun_establish_returned_null': 'Android-ը մերժել է VPN միջերեսը',
      'openvpn_service_start_failed': 'OpenVPN ծառայությունը հասանելի չէ',
      'openvpn_operation_timeout': 'OpenVPN-ի կանչի ժամանակը սպառվել է',
      'openvpn_start_failed': 'OpenVPN-ի մեկնարկը մերժվել է',
      'openvpn_connection_failed': 'OpenVPN-ի միացումն ընդհատվել է',
      'openvpn_core_status_error': 'OpenVPN-ի միջուկն ավարտվեց սխալով',
      'openvpn_stopped_before_connected': 'OpenVPN-ը կանգ առավ միանալուց առաջ',
      'openvpn_auth_failed': 'OpenVPN-ի նույնականացումը մերժվել է',
      'openvpn_client_setup_failed':
          'OpenVPN-ի հաճախորդի կարգավորումը չհաջողվեց',
      'openvpn_client_halted': 'OpenVPN-ի հաճախորդն ընդհատվել է',
      'openvpn_client_restart': 'Պահանջվել է OpenVPN-ի վերամեկնարկ',
      'openvpn_inactive_timeout': 'OpenVPN-ը չափազանց երկար անգործուն է',
      'openvpn_session_expired': 'OpenVPN սեսիայի ժամկետն անցել է',
      'openvpn_credentials_required': 'Չաջակցվող OpenVPN նույնականացում',
      'openvpn_proxy_failed': 'OpenVPN-ի միջանկյալ փոխանցումը չհաջողվեց',
      'openvpn_compression_failed': 'OpenVPN-ի սեղմումը մերժվել է',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN-ի NTLM գաղտնագրումը հասանելի չէ',
      'openvpn_feature_unsupported': 'Չաջակցվող OpenVPN գործառույթ',
      'network_unavailable': 'Ինտերնետ կապը հասանելի չէ',
      'network_lost': 'Ցանցը հասանելի չէ',
      'certificate_validation_failed': 'Սերվերի վկայագիրը մերժվել է',
      'openvpn_certificate_expired': 'OpenVPN-ի վկայագիրը ժամկետանց է',
      'tunnel_active_for_another_account': 'Մեկ այլ հաշվի թունելը դեռ ակտիվ է',
      'tunnel_already_active': 'Թունելն արդեն ակտիվ է',
      'tunnel_stop_timeout': '$protocol-ի դադարեցումը չի հաստատվել',
      'tunnel_disconnected': '$protocol ընդհատվել է',
      'native_bridge_unavailable': 'Android-ի կամուրջը հասանելի չէ',
      'native_operation_failed': 'Android-ի գործողությունն ընդհատվել է',
      'invalid_arguments': 'VPN-ի պարամետրերը թերի են',
      'invalid_account_id': 'Անվավեր VPN հաշիվ',
      'invalid_device_id': 'Անվավեր սարքի նույնացուցիչ',
      'storage_key_not_allowed': 'Պահոցի բանալին մերժվել է',
      'secure_storage_read_failed': 'Անվտանգ ընթերցումը չհաջողվեց',
      'secure_storage_write_failed': 'Անվտանգ գրառումը չհաջողվեց',
      'key_generation_failed': 'Չհաջողվեց ստեղծել WireGuard բանալին',
      'csr_generation_failed': 'Չհաջողվեց ստեղծել OpenVPN-ի CSR-ը',
      'openvpn_recovery_exhausted':
          'OpenVPN-ի վերականգնումն արդեն օգտագործվել է',
      'openvpn_recovery_failed': 'OpenVPN-ի վերականգնումը չհաջողվեց',
      'openvpn_renewal_required': 'Պահանջվում է OpenVPN-ի վկայագրի թարմացում',
      'other': 'Չդասակարգված VPN սխալ',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android-ը չի գտնում վերսկսելի VPN սեսիա։ Հավելվածում սկսեք նոր միացում։',
      'system_vpn_resume_corrupt':
          'Պահպանված VPN-ի վերսկսման տվյալներն անվավեր են և չեն օգտագործվի։ Սկսեք նոր միացում։',
      'system_vpn_resume_session_invalid':
          'Պահպանված սեսիան այլևս չի կարող վերսկսել VPN-ը։ Հավելվածում նորից մուտք գործեք։',
      'system_vpn_resume_identity_changed':
          'VPN-ի տեղական ինքնությունը փոխվել է։ Վերսկսումը դադարեցվել է։ Սկսեք նոր միացում։',
      'system_vpn_resume_identity_invalid':
          'Վերսկսման ինքնությունն անվավեր է։ Սկսեք նոր միացում։',
      'system_vpn_resume_storage_failed':
          'Android-ը չկարողացավ կարդալ կամ թարմացնել գաղտնագրված վերսկսման տվյալները։ Սկսեք նոր միացում։',
      'system_vpn_resume_network_timeout':
          'Android-ը ժամանակին ցանց չգտավ VPN-ը վերսկսելու համար։ Նորից փորձեք, երբ ցանցը հասանելի լինի։',
      'system_vpn_resume_blocked':
          'VPN-ի վերսկսումն արգելափակված է։ Ստուգեք Android-ի կարգավորումները, ապա սկսեք նոր միացում։',
      'system_vpn_resume_failed':
          'Android-ում VPN-ի վերսկսումը չհաջողվեց։ Հավելվածում սկսեք նոր միացում։',
      'system_vpn_resume_error_invalid':
          'Android-ը վերադարձրեց անօգտագործելի վերսկսման սխալ։ Սկսեք նոր միացում։',
      'wireguard_identity_store_failed':
          'Android-ը չկարողացավ պահպանել այս հաշվի գաղտնագրված WireGuard ինքնությունը։',
      'wireguard_identity_unavailable':
          'Այս միացման համար օգտագործելի WireGuard ինքնություն չկա։',
      'vpn_host_destroyed':
          'VPN-ն աշխատեցնող Android բաղադրիչը դադարեցվել է։ Սկսեք նոր միացում։',
      'vpn_host_unavailable':
          'Android-ը չի կարող ստեղծել VPN-ն աշխատեցնող բաղադրիչը։ Ստուգեք VPN-ի կարգավորումները և նորից փորձեք։',
      'openvpn_renewal_required':
          'OpenVPN-ի վկայագրի ավտոմատ թարմացումը չհաջողվեց։ Հավելվածում սկսեք նոր միացում։',
      'openvpn_recovery_failed':
          'Ավտոմատ վերականգնումը չհաջողվեց։ Հավելվածում սկսեք նոր միացում։',
      'openvpn_recovery_exhausted':
          'Ավտոմատ վերականգնումն արդեն օգտագործվել է։ Հավելվածում սկսեք նոր միացում։',
      'vpn_permission_required':
          'Android-ը թունելը մեկնարկելուց առաջ պահանջում է VPN-ի նոր թույլտվություն։',
      'vpn_permission_denied':
          'Շարունակելու համար Android-ի հարցումում թույլատրեք FuzeVPN-ին։',
      'vpn_permission_request_failed':
          'Android-ը չկարողացավ բացել VPN-ի թույլտվության էկրանը։',
      'wireguard_foreground_service_unavailable':
          'Android-ը չկարողացավ WireGuard ծառայությունը պահել առաջին պլանում։',
      'wireguard_identity_invalid':
          'Այս հաշվի գաղտնագրված WireGuard բանալին անընթեռնելի է կամ անվավեր։',
      'wireguard_identity_in_use':
          'Մեկ այլ գործողություն դեռ օգտագործում է այս հաշվի WireGuard բանալին։',
      'wireguard_configuration_invalid':
          'Ստացված WireGuard հասցեն, DNS-ը, սերվերի բանալին կամ երթուղիներն անվավեր են։',
      'wireguard_operation_pending':
          'Նախորդ WireGuard գործողությունը դեռ չի ազատել իր համակարգային ծառայությունը։',
      'wireguard_start_failed':
          'WireGuard շարժիչը մերժել է կազմաձևման ակտիվացումը։',
      'wireguard_stop_timeout':
          'WireGuard ծառայությունը սահմանված ժամանակում չհաստատեց VPN միջերեսի ազատումը։',
      'wireguard_handshake_timeout':
          'Թունելը ժամանակին չհաստատեց սերվերի հետ կապի հաստատումը։',
      'openvpn_connection_timeout':
          'OpenVPN-ը ժամանակին չհաստատեց միացումը սերվերի հետ։',
      'openvpn_core_unavailable':
          'Հավելվածի այս տարբերակը չի պարունակում օգտագործելի OpenVPN շարժիչ։',
      'openvpn_operation_pending':
          'Համակարգային շարժիչը դեռ պահում է OpenVPN-ի նախորդ սեսիան և մերժում է երկրորդի ստեղծումը։',
      'openvpn_stop_timeout':
          'OpenVPN-ի միջուկը սահմանված ժամանակում չհաստատեց, որ իր համակարգային սեսիան դադարել և ոչնչացվել է։',
      'openvpn_profile_unavailable':
          'Այս միացման համար վավերացված OpenVPN պրոֆիլ չի կարող կարդացվել։',
      'openvpn_native_failed':
          'Հավելվածի սխալն ընդհատեց OpenVPN-ը։ Նորից փորձեք միանալ։ Եթե խնդիրը շարունակվում է, գործարկեք ախտորոշում։',
      'openvpn_key_generation_failed':
          'Android Keystore-ը չկարողացավ ստեղծել կամ կարդալ չարտահանվող P-256 գաղտնի բանալին։',
      'openvpn_csr_generation_failed':
          'Android Keystore-ի բանալին չկարողացավ ստորագրել OpenVPN-ի վկայագրի հարցումը։',
      'openvpn_identity_store_failed':
          'OpenVPN-ի վկայագիրը կամ պրոֆիլը չկարողացան պահպանվել գաղտնագրված պահոցում։',
      'openvpn_identity_clear_failed':
          'Android-ը չկարողացավ ամբողջությամբ հեռացնել այս հաշվի OpenVPN-ի տեղական ինքնությունը։',
      'openvpn_identity_in_use':
          'OpenVPN-ի համակարգային սեսիան դեռ օգտագործում է այս սարքի բանալին կամ վկայագիրը։',
      'openvpn_tls_verification_required':
          'Պրոֆիլը բացահայտ չի պահանջում սերվերի վկայագրի ստուգում։',
      'openvpn_cipher_invalid':
          'Սերվերը տրամադրել է թույլատրելի ցանկում չընդգրկված գաղտնագրման ալգորիթմ։',
      'openvpn_profile_rejected':
          'Սերվերից ստացված պրոֆիլն անհամատեղելի է։ Վերստեղծեք այս սարքը և նորից փորձեք։',
      'openvpn_identity_inconsistent':
          'Վկայագիրը չի համապատասխանում այս հեռախոսի անվտանգ ինքնությանը։ Տեղական պրոֆիլը չի փոխարինվել։',
      'tls_handshake_failed':
          'Սերվերը մերժեց TLS բանակցությունը։ Եթե խնդիրը շարունակվում է, վերստեղծեք պրոֆիլը։',
      'tls_alert_unknown_ca':
          'Սերվերը չի ճանաչում այս սարքի վկայագիրը տրամադրած մարմինը։ Ստուգեք OpenVPN սերվերը։',
      'tls_alert_bad_certificate':
          'Սերվերը մերժեց այս սարքի վկայագիրը։ Նորից փորձելուց առաջ վերստեղծեք սարքը։',
      'tls_alert_unsupported_certificate':
          'Սերվերը չի աջակցում Android-ի օգտագործած անվտանգ վկայագրի տեսակը։',
      'tls_client_certificate_required':
          'Սերվերը պահանջում է հաճախորդի վկայագիր, բայց OpenVPN-ի միջուկը չկարողացավ այն ներկայացնել։',
      'tls_alert_misc':
          'Սերվերը վերադարձրել է TLS ահազանգ, որը չի վերաբերում վկայագրի և տարբերակի կատեգորիաներին։',
      'tls_signature_algorithm_rejected':
          'Սերվերը մերժեց Android Keystore բանալու ECDSA P-256 ալգորիթմը։',
      'tls_handshake_rejected':
          'Սերվերը միանալուց առաջ ընդհատեց TLS բանակցությունը։',
      'tls_version_rejected':
          'Հաճախորդը և սերվերն ընդհանուր TLS տարբերակ չգտան։',
      'tls_certificate_expired':
          'Միացման ընթացքում ներկայացված վկայագրի ժամկետն անցել է։',
      'tls_certificate_revoked':
          'Միացման ընթացքում ներկայացված վկայագիրը չեղարկվել է։',
      'transport_failed':
          'OpenVPN սերվերն ընթացիկ ցանցում չի պատասխանում։ Քիչ անց նորից փորձեք։',
      'tun_configuration_rejected':
          'Android-ը մերժել է OpenVPN-ի պահանջած ցանցի կազմաձևումը։',
      'tun_setup_failed':
          'OpenVPN-ի միջուկը մերժեց ցանցի սխեման՝ նախքան Android միջերեսը ստեղծելը։',
      'tun_interface_create_failed':
          'OpenVPN-ի միջուկը չկարողացավ ստանալ TUN միջերեսը Android VpnService-ից։',
      'tun_interface_disabled':
          'Android-ը կամ OpenVPN-ի միջուկը միացման ընթացքում անջատեց TUN միջերեսը։',
      'tun_halted':
          'OpenVPN-ի միջուկը ստացավ TUN միջերեսը դադարեցնելու հարցում։',
      'tun_already_established':
          'OpenVPN-ը նույն միացման մեջ երկրորդ միջերես պահանջեց։ Թունելն անվտանգության համար դադարեցվեց։',
      'tun_addresses_missing': 'Սերվերն օգտագործելի թունելի հասցե չտրամադրեց։',
      'tun_routes_missing':
          'Սերվերն օգտագործելի թունելի երթուղիներ չտրամադրեց։',
      'tun_dns_missing': 'Սերվերն օգտագործելի DNS սերվեր չտրամադրեց։',
      'tun_permission_revoked':
          'Android-ը միացման ընթացքում չեղարկեց VPN-ի թույլտվությունը։',
      'tun_establish_returned_null':
          'Android-ը միջերեսը չստեղծեց, սովորաբար այն պատճառով, որ մեկ այլ VPN դեռ ակտիվ է։',
      'openvpn_service_start_failed':
          'Android-ը չկարողացավ մեկնարկել OpenVPN առաջին պլանի ծառայությունը։',
      'openvpn_operation_timeout':
          'OpenVPN-ի միջուկին ուղղված JNI կանչը գերազանցել է առավելագույն թույլատրելի տևողությունը։',
      'openvpn_start_failed':
          'Android ծառայությունը պատրաստ է, բայց OpenVPN-ի միջուկը չընդունեց պրոֆիլի մեկնարկը։',
      'openvpn_connection_failed':
          'OpenVPN-ի միջուկը կանգ առավ՝ նախքան CONNECTED իրադարձության թողարկումը։',
      'openvpn_core_status_error':
          'OpenVPN-ի համակարգային ցիկլը սխալով ավարտվեց՝ առանց ավելի կոնկրետ վերջնական իրադարձության։',
      'openvpn_stopped_before_connected':
          'OpenVPN-ի համակարգային ցիկլը կանգ առավ CONNECTED-ից առաջ՝ առանց միջուկի հստակ սխալի։',
      'openvpn_auth_failed': 'OpenVPN սերվերը մերժեց պրոֆիլի նույնականացումը։',
      'openvpn_client_setup_failed':
          'OpenVPN-ի միջուկը չկարողացավ նախապատրաստել հաճախորդը ցանցային միացումից առաջ։',
      'openvpn_client_halted':
          'OpenVPN-ի միջուկը ստացավ հաճախորդի վերջնական դադարեցման հրաման։',
      'openvpn_client_restart':
          'OpenVPN-ի միջուկը պահանջեց իր փոխանցման սեսիայի վերամեկնարկը։',
      'openvpn_inactive_timeout':
          'OpenVPN-ի միջուկը փակեց սեսիան անգործության ժամկետը լրանալուց հետո։',
      'openvpn_session_expired':
          'Սերվերը հայտնեց, որ OpenVPN սեսիայի ժամկետն անցել է։',
      'openvpn_credentials_required':
          'Սերվերը կամ միջնորդը պահանջում է ինտերակտիվ մուտքի տվյալներ, որոնք այս պրոֆիլում նախատեսված չեն։',
      'openvpn_proxy_failed':
          'OpenVPN-ի միջուկը հայտնեց կազմաձևված միջնորդի կամ փոխանցող սերվերի խափանման մասին։',
      'openvpn_compression_failed':
          'OpenVPN-ի միջուկը մերժեց պրոֆիլի կամ սերվերի հայտարարած սեղմման ռեժիմը։',
      'openvpn_ntlm_crypto_unavailable':
          'Պրոֆիլը պահանջում է NTLM գաղտնագրում, որն այս տարբերակում հասանելի չէ։',
      'openvpn_feature_unsupported':
          'Պրոֆիլը կամ սերվերը պահանջում է գործառույթ, որը բացակայում է այս Android հաճախորդից։',
      'network_unavailable': 'Օգտագործելի ֆիզիկական ցանց հասանելի չէ։',
      'network_lost': 'Թունելը դադարեցվեց ցանցի կապը կորցնելուց հետո։',
      'certificate_validation_failed':
          'OpenVPN սերվերի ինքնությունը չհաջողվեց ստուգել։',
      'openvpn_certificate_expired':
          'OpenVPN-ի վկայագրի ժամկետն անցել է։ Այն թարմացնելու համար հավելվածում սկսեք նոր միացում։',
      'tunnel_active_for_another_account':
          'Այս միացումից առաջ պետք է դադարեցվի մեկ այլ հաշվին պատկանող թունելը։',
      'tunnel_already_active':
          'Android-ը հայտնում է, որ VPN-ի նախորդ սեսիան դեռ օգտագործում է միջերեսը։',
      'tunnel_stop_timeout':
          '$protocol շարժիչը սահմանված ժամանակում չհաստատեց VPN միջերեսի ազատումը։',
      'tunnel_disconnected':
          'Համակարգային շարժիչը հայտնեց, որ թունելը մեկնարկից հետո անսպասելիորեն ավարտվեց։',
      'native_bridge_unavailable':
          'Հավելվածը չի կարող կապ հաստատել Android-ի VPN ծառայության հետ։ Փակեք և նորից բացեք հավելվածը, ապա նորից փորձեք։',
      'native_operation_failed':
          'Հավելվածի սխալն ընդհատեց VPN-ի գործողությունը։ Նորից փորձեք։ Եթե խնդիրը շարունակվում է, գործարկեք ախտորոշում։',
      'invalid_arguments':
          'Այս VPN գործողության համար անհրաժեշտ տեղեկությունները թերի են։ Նորից փորձեք։ Եթե խնդիրը շարունակվում է, գործարկեք ախտորոշում։',
      'invalid_account_id':
          'Համակարգային գործողությունը կապված չէ վավեր հաշվի նույնացուցչի հետ։',
      'invalid_device_id':
          'Համակարգային շարժիչին ուղարկված սարքի նույնացուցիչը բացակայում է կամ անվավեր է։',
      'storage_key_not_allowed':
          'Android-ի կամուրջն արգելափակեց թույլատրված պահոցի ցանկից դուրս գտնվող բանալին։',
      'secure_storage_read_failed':
          'Android Keystore-ը չկարողացավ վերծանել այս հաշվի տեղական տվյալները։',
      'secure_storage_write_failed':
          'Android Keystore-ը չկարողացավ գաղտնագրել կամ պահպանել տեղական տվյալները։',
      'key_generation_failed':
          'Android-ը չկարողացավ ստեղծել կամ կարդալ WireGuard բանալին անվտանգ պահոցում։',
      'csr_generation_failed':
          'Android Keystore-ը չկարողացավ ստեղծել կամ ստորագրել OpenVPN P-256 CSR-ը։',
      'other':
          'Չփաստաթղթավորված համակարգային ճյուղում սխալ է տեղի ունեցել։ Ստորև ցուցադրված ախտորոշման կոդն ուղարկեք աջակցության ծառայությանը։',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Թույլտվության հարցումն արդեն բաց է';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN-ի թույլտվության հարցումն արդեն ցուցադրված է։ Նախ ավարտեք այն, ապա նորից փորձեք։';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN-ի թույլտվության հարցումն ընդհատվել է';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'VPN-ի թույլտվության էկրանը փակվել է, մինչ հավելվածը պատասխան ստանար։';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN-ի միացումը չի հաստատվել';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN-ի միացումը չհաջողվեց հաստատել։ Անվտանգության համար այն դադարեցվել է։ Նորից փորձեք։';

  @override
  String get openvpnCleanup_title => 'OpenVPN պրոֆիլը չեղարկվել է';

  @override
  String get openvpnCleanup_working =>
      'Չեղարկված OpenVPN պրոֆիլը դադարեցվում և հեռացվում է…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN-ի դադարեցումը չի հաստատվել։ Նորից փորձեք, նախքան նոր պրոֆիլ ստեղծելը։';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Չեղարկված OpenVPN պրոֆիլը չհաջողվեց ամբողջությամբ հեռացնել։ Նորից փորձեք մաքրումը։';

  @override
  String get openvpnCleanup_complete =>
      'Չեղարկված OpenVPN պրոֆիլը հեռացվել է։ Նորը ստեղծելու համար հպեք «Միանալ»։';

  @override
  String get network_title => 'Ցանցի կազմաձևում';

  @override
  String get network_ipv4Fallback =>
      'IPv6-ը ժամանակավորապես հասանելի չէ։ Նախապատրաստումը շարունակվում է IPv4-ով։';

  @override
  String get network_rejectedTitle => 'Ցանցի կազմաձևումը մերժվել է';

  @override
  String get network_rejectedMessage =>
      'Թունելի կազմաձևումը թերի է կամ չի համապատասխանում թույլատրված հասցեներին։ Նորից փորձեք հավելվածից։';

  @override
  String get network_unreadableTitle => 'Տեղական կազմաձևումն անընթեռնելի է';

  @override
  String get network_unreadableMessage =>
      'Պահպանված OpenVPN ցանցի կազմաձևումը հնարավոր չէ օգտագործել։ Նորից միացեք հավելվածից՝ այն թարմացնելու համար։';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ցանցի պաշտպանություն';

  @override
  String get protection_subtitle =>
      'Արգելափակեք անմիջական ինտերնետ մուտքը, եթե VPN-ը խզվի։';

  @override
  String get protection_active => 'Համակարգի պաշտպանությունը միացված է';

  @override
  String get protection_alwaysOnOnly =>
      'Միշտ միացված VPN-ն ակտիվ է։ Միացրեք VPN-ից դուրս արգելափակումը։';

  @override
  String get protection_inactive => 'Համակարգի պաշտպանությունն անջատված է';

  @override
  String get protection_unknown => 'Ստուգեք համակարգի պաշտպանությունը';

  @override
  String get protection_openSettings => 'Բացել Android-ի կարգավորումները';

  @override
  String get protection_dialogTitle => 'Կարգավորեք ցանցի պաշտպանությունը';

  @override
  String get protection_dialogMessage =>
      'Android-ը կառավարում է միշտ միացված VPN-ը և VPN-ից դուրս կապերի արգելափակումը։ Ստուգեք, որ FuzeVPN-ն ընտրված է, և համակարգի կարգավորումներում միացրեք արգելափակումը։';

  @override
  String get protection_dialogOpen => 'Բացել կարգավորումները';

  @override
  String get session_systemProtectionNote =>
      'Եթե Android-ը դեռ արգելափակում է VPN-ից դուրս տրաֆիկը, բացեք համակարգի կարգավորումները՝ այս պաշտպանությունը ստուգելու կամ փոխելու համար։';

  @override
  String get diagnostics_title => 'Ախտորոշում';

  @override
  String get diagnostics_settingsTitle => 'Հավելվածի ախտորոշում';

  @override
  String get diagnostics_automaticTitle => 'Ուղարկել կարևոր սխալները';

  @override
  String get diagnostics_automaticDescription =>
      'Կարևոր սխալի դեպքում կիսվեք փոքր տեխնիկական հաշվետվությամբ։';

  @override
  String get diagnostics_privacy =>
      'Ուղարկված հաշվետվությունները կապված են մուտք գործած հաշվի հետ և պահվում են 30 օր։ Դրանք չեն պարունակում դիտարկման պատմություն, գաղտնաբառեր կամ VPN բանալիներ։';

  @override
  String get diagnostics_manualOpen => 'Գործարկել ախտորոշումը';

  @override
  String get diagnostics_localDescription =>
      'Ստեղծեք հավելվածի և VPN-ի վիճակի հաշվետվություն։ Ձեր միացումը չի փոխվի։';

  @override
  String get diagnostics_sendReport => 'Ուղարկել հաշվետվությունը';

  @override
  String get diagnostics_sendHint =>
      'Թողեք այս վանդակը չնշված, որպեսզի հաշվետվությունը մնա այս սարքում։';

  @override
  String get diagnostics_signedOut =>
      'Մուտք գործեք ձեր հաշիվ՝ հաշվետվությունն ուղարկելու համար։';

  @override
  String get diagnostics_localLifetime =>
      'Պահեք այս հաշվետվությունը ձեր հեռախոսում, որպեսզի հավելվածը փակելուց հետո այն մնա։';

  @override
  String get diagnostics_run => 'Գործարկել ախտորոշումը';

  @override
  String get diagnostics_rerun => 'Կրկին գործարկել ախտորոշումը';

  @override
  String get diagnostics_running => 'Ստուգվում է…';

  @override
  String get diagnostics_sending => 'Հաշվետվությունն ուղարկվում է…';

  @override
  String get diagnostics_prepared => 'Հաշվետվությունը պատրաստ է այս սարքում';

  @override
  String get diagnostics_queued => 'Հաշվետվությունը սպասում է ուղարկման';

  @override
  String get diagnostics_sent => 'Հաշվետվությունը ստացվել է';

  @override
  String get diagnostics_failed =>
      'Ուղարկումը չհաջողվեց։ Ձեր տեղական հաշվետվությունը դեռ հասանելի է։';

  @override
  String get diagnostics_preparationFailed =>
      'Ախտորոշման հաշվետվությունը չհաջողվեց պատրաստել։ Նորից փորձեք։';

  @override
  String get diagnostics_authenticationRequired =>
      'Հաշվետվությունն ուղարկելու համար նորից մուտք գործեք։';

  @override
  String get diagnostics_retry => 'Նորից ուղարկել';

  @override
  String get diagnostics_export => 'Պահել հաշվետվությունը';

  @override
  String get diagnostics_exportFailed =>
      'Արտահանումը չհաջողվեց։ Նորից փորձեք տեղական հաշվետվությունից։';

  @override
  String get diagnostics_preferenceFailed =>
      'Այս կարգավորումը չհաջողվեց պահպանել։ Նորից փորձեք։';

  @override
  String diagnostics_receipt(Object id) {
    return 'Հղման կոդ՝ $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Ստացվել է՝ $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Պահվում է մինչև $date';
  }

  @override
  String get diagnostics_duplicate => 'Այս հաշվետվությունն արդեն ստացվել էր։';

  @override
  String get diagnostics_preview => 'Հաշվետվության նախադիտում';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Կցված է $count տեխնիկական իրադարձություն',
      one: 'Կցված է 1 տեխնիկական իրադարձություն',
      zero: 'Տեխնիկական իրադարձություններ կցված չեն',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Տեխնիկական մանրամասներ';

  @override
  String get diagnostics_empty =>
      'Դեռ ոչ մի ախտորոշման հաշվետվություն չի պատրաստվել։';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Թունելի վիճակ',
      'handshake': 'Կապի հաստատում',
      'certificate': 'VPN վկայագիր',
      'kill_switch': 'Android-ի պաշտպանություն',
      'connectivity': 'Հասանելի ցանց',
      'api_reachability': 'Ծառայության հասանելիություն',
      'secure_storage': 'Անվտանգ պահոց',
      'other': 'Տեղական ստուգում',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Ստուգված է',
      'failed': 'Պահանջում է ուշադրություն',
      'skipped': 'Չի ստուգվել — ակտիվ ստուգում չկա',
      'unknown': 'Տեղեկությունը հասանելի չէ',
      'other': 'Տեղեկությունը հասանելի չէ',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Բարի գալուստ FuzeVPN';

  @override
  String get connection_changeLocation => 'Փոխել վայրը';

  @override
  String get connection_details => 'Կապի մանրամասներ';

  @override
  String get locations_searchLabel => 'Որոնել քաղաք կամ երկիր';

  @override
  String get locations_clearSearch => 'Մաքրել որոնումը';

  @override
  String get locations_filterAll => 'Բոլորը';

  @override
  String get locations_filterFavorites => 'Ընտրյալներ';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count վայր',
      one: '$count վայր',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Վայրեր չեն գտնվել';

  @override
  String get locations_noResultsHint => 'Փորձեք մեկ այլ քաղաք կամ երկիր։';

  @override
  String get locations_noFavorites => 'Ձեր ընտրյալները միշտ ձեռքի տակ';

  @override
  String get locations_noFavoritesHint =>
      'Հպեք վայրի կողքի աստղիկին՝ այն այստեղ պահելու համար։';

  @override
  String get locations_showAll => 'Տեսնել բոլոր վայրերը';

  @override
  String locations_addFavorite(String name) {
    return 'Ավելացնել ընտրյալներին՝ $name';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Հեռացնել ընտրյալներից՝ $name';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Ընտրյալը չհաջողվեց պահպանել։ Նորից փորձեք։';

  @override
  String get locations_emptyTitle => 'Վայրեր հասանելի չեն';

  @override
  String get locations_emptyHint => 'Թարմացրեք ցանկը՝ նորից փորձելու համար։';

  @override
  String get devices_manage => 'Կառավարել իմ սարքերը';

  @override
  String get settings_personalization => 'Ըստ ձեր ճաշակի';

  @override
  String get settings_safety => 'Պաշտպանություն';

  @override
  String get settings_help => 'Օգնության կարիք ունե՞ք';

  @override
  String get settings_about => 'FuzeVPN-ի մասին';

  @override
  String get diagnostics_heading => 'Հասկանալ միացման խնդիրը';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Հասանելի',
      'pending': 'Նախապատրաստվում է',
      'revoked': 'Հեռացված',
      'expired': 'Ժամկետն անցել է',
      'other': 'Կարգավիճակը հասանելի չէ',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Կարգավորումը չի պահպանվել';

  @override
  String get notice_preferenceSave_message =>
      'Ձեր ընտրությունն առայժմ կիրառվում է, բայց չի պահպանվել։ Նորից փորձեք, որպեսզի այն պահպանվի նաև հավելվածը փակելուց հետո։';

  @override
  String get connection_androidDisconnectHint =>
      'Եթե Android-ը շարունակում է VPN-ն ակտիվ պահել, բացվող կարգավորումներում անջատեք «Միշտ միացված VPN»-ը։';

  @override
  String get connection_certificate => 'OpenVPN-ի վկայագիր';

  @override
  String connection_certificateValidUntil(Object date) {
    return 'Վավեր է մինչև $date';
  }

  @override
  String connection_certificateExpired(Object date) {
    return 'Ժամկետն անցել է՝ $date';
  }

  @override
  String get connection_certificateAutoRenewal =>
      'Ավտոմատ կթարմացվի հաջորդ միացման ժամանակ։';

  @override
  String get protection_learnMore => 'Իմանալ Android-ի պաշտպանության մասին';

  @override
  String get protection_guideWhy =>
      'Այս պաշտպանությունը թույլ չի տալիս հավելվածներին ուղղակիորեն օգտվել ինտերնետից, եթե VPN-ն անջատվի։ Այն կարգավորվում է Android-ում։';

  @override
  String get protection_guideAlwaysOnTitle => 'Միշտ միացված VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android-ը VPN ծառայությունը մշտապես աշխատեցնում է և կարող է այն նորից գործարկել հեռախոսի վերագործարկումից հետո։';

  @override
  String get protection_guideBlockTitle => 'Արգելափակել առանց VPN-ի կապերը';

  @override
  String get protection_guideBlock =>
      'Այս կարգավորումը թույլ չի տալիս տրաֆիկին շրջանցել VPN-ը, ներառյալ կապի ընդհատման ժամանակ։';

  @override
  String get protection_guideWarning =>
      'Երբ այս արգելափակումը միացված է, ինտերնետը մնում է անջատված, մինչև VPN-ը միանա։';

  @override
  String get protection_guideStepsTitle => 'Միացնել պաշտպանությունը';

  @override
  String get protection_guideStep1 =>
      'Ներքևի կոճակով բացեք Android-ի VPN կարգավորումները։';

  @override
  String get protection_guideStep2 =>
      'Բացեք ընտրանքները FuzeVPN-ի կողքի ատամնանիվի պատկերակով։';

  @override
  String get protection_guideStep3 =>
      'Եթե այս ընտրանքները հասանելի են, միացրեք «Միշտ միացված VPN»-ը, ապա՝ «Արգելափակել առանց VPN-ի կապերը»։';

  @override
  String get protection_guideManufacturers =>
      'Անունները տարբերվում են՝ կախված հեռախոսից։ Անհրաժեշտության դեպքում կարգավորումներում որոնեք «VPN», հաճախ՝ «Ցանց և ինտերնետ» բաժնում։';

  @override
  String get protection_guideDisableTitle => 'Անջատել այս պաշտպանությունը';

  @override
  String get protection_guideDisable =>
      'Նույն կարգավորումներում անջատեք «Արգելափակել առանց VPN-ի կապերը»՝ VPN-ից դուրս ինտերնետ մուտք թույլ տալու համար։ Եթե այլևս չեք ցանկանում, որ Android-ը նորից գործարկի VPN-ը, անջատեք նաև «Միշտ միացված VPN»-ը։';

  @override
  String get protection_guideManual =>
      'Այս կարգավորումները դուք եք ընտրում Android-ում։ FuzeVPN-ը դրանք ձեր փոխարեն չի փոխում։';

  @override
  String get locations_changeTitle => 'Փոխե՞լ վայրը';

  @override
  String locations_changeActive(String name) {
    return 'VPN-ը կանջատվի, ապա կփորձի միանալ հետևյալ վայրին՝ $name։';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN-ը կփորձի միանալ հետևյալ վայրին՝ $name։';
  }

  @override
  String get locations_confirmChange => 'Փոխել և միանալ';

  @override
  String get locations_changeBusy =>
      'Փոփոխությունն ընթացքի մեջ է։ Մեկ այլ վայր ընտրելուց առաջ սպասեք։';

  @override
  String get locations_automaticSelection => 'Ավտոմատ ընտրություն';

  @override
  String get locations_cities => 'Քաղաքներ';

  @override
  String get locations_servers => 'Սերվերներ';

  @override
  String locations_viewCities(String name) {
    return 'Տեսնել քաղաքները՝ $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Տեսնել սերվերները՝ $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count երկիր',
      one: '$count երկիր',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count քաղաք',
      one: '$count քաղաք',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count սերվեր',
      one: '$count սերվեր',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Բոլոր երկրները';

  @override
  String get locations_backToCountries => 'Վերադառնալ երկրներին';

  @override
  String locations_backToCities(String name) {
    return 'Վերադառնալ քաղաքներին՝ $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Ընտրել $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Ընտրել $name';
  }

  @override
  String get locations_noCompatibleServer => 'Համատեղելի սերվեր հասանելի չէ։';

  @override
  String get externalLink_failed =>
      'Այս հղումը չհաջողվեց բացել։ Կարող եք պատճենել այն և բացել բրաուզերում։';

  @override
  String get externalLink_copy => 'Պատճենել հղումը';

  @override
  String get externalLink_copied => 'Հղումը պատճենվեց';

  @override
  String get externalLink_copyFailed =>
      'Հղումը չհաջողվեց պատճենել։ Ընտրեք ստորև եղած հասցեն։';

  @override
  String get settings_deleteAccount => 'Ջնջել իմ հաշիվը';

  @override
  String get settings_deleteAccountDetail =>
      'Դիտել հաշիվը ջնջելու հայտի ընթացակարգը';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Ընտրեք ձեր VPN բաժանորդագրությունը։';

  @override
  String get billing_subscribe => 'Բաժանորդագրվել';

  @override
  String get billing_choosePlan => 'Շարունակելու համար ընտրեք սակագին։';

  @override
  String get billing_monthly => 'Ամսական';

  @override
  String get billing_yearly => 'Տարեկան';

  @override
  String get billing_continue => 'Շարունակել Google Play-ով';

  @override
  String get billing_restore => 'Վերականգնել գնումները';

  @override
  String get billing_manage => 'Կառավարել բաժանորդագրությունը';

  @override
  String get billing_deleteAccountWarning =>
      'Եթե ունեք Google Play-ի բաժանորդագրություն, FuzeVPN հաշիվը ջնջելը չի չեղարկում դրա ավտոմատ երկարացումը։ Երկարացումը կառավարեք կամ չեղարկեք առանձին՝ Google Play-ում։';

  @override
  String get billing_deleteAccountContinue => 'Անցնել հաշվի ջնջման հայտին';

  @override
  String get billing_refresh => 'Թարմացնել հասանելիությունը';

  @override
  String get billing_loadingPlans => 'Սակագները բեռնվում են…';

  @override
  String get billing_unavailable =>
      'Այս պահին սակագներ հասանելի չեն։ Նորից փորձեք ավելի ուշ։';

  @override
  String get billing_comingSoon =>
      'Բաժանորդագրությունները շուտով հասանելի կլինեն։';

  @override
  String get billing_priceDisclosure =>
      'Գինը տրամադրում է Google Play-ը։ Վերջնական գումարը և կիրառվող հարկերը հաստատվում են նախքան ձեր հաստատումը։';

  @override
  String get billing_renewalMonthly =>
      'Ավտոմատ երկարացվում է ամեն ամիս, քանի դեռ չեք չեղարկել։ Կարող եք ցանկացած պահի չեղարկել Google Play-ի բաժանորդագրություններում։';

  @override
  String get billing_renewalYearly =>
      'Ավտոմատ երկարացվում է ամեն տարի, քանի դեռ չեք չեղարկել։ Կարող եք ցանկացած պահի չեղարկել Google Play-ի բաժանորդագրություններում։';

  @override
  String get billing_active => 'Ձեր Premium հասանելիությունն ակտիվ է';

  @override
  String billing_accessUntil(String date) {
    return 'Հասանելիություն մինչև $date։';
  }

  @override
  String get billing_webManaged =>
      'Ձեր բաժանորդագրությունը կառավարվում է FuzeVPN կայքում։';

  @override
  String get billing_playManaged =>
      'Ձեր բաժանորդագրությունը կառավարվում է Google Play-ի կողմից։';

  @override
  String get billing_playOnHold =>
      'Ձեր Google Play բաժանորդագրությունը կասեցված է կամ սպասում է վճարման։ Google Play-ում այն շտկելու համար բացեք «Կառավարել բաժանորդագրությունը»։';

  @override
  String get billing_playReceiptUnlinked =>
      'Այս Google Play հաշիվն արդեն ունի Fuze Premium բաժանորդագրություն, որն այս FuzeVPN հաշվի համար ակտիվ չէ։ Google Play-ում այն դիտելու համար բացեք «Կառավարել բաժանորդագրությունը»։';

  @override
  String get billing_inactive => 'Ակտիվ բաժանորդագրություն չկա։';

  @override
  String get billing_checkingAccess => 'Ձեր հասանելիությունը ստուգվում է…';

  @override
  String get billing_restoring => 'Գնումները վերականգնվում են…';

  @override
  String get billing_pending =>
      'Վճարումը սպասման մեջ է։ Ձեր հասանելիությունը կակտիվանա հաստատումից հետո։';

  @override
  String get billing_cancelled =>
      'Գնումը չեղարկվել է։ Նոր բաժանորդագրություն չի ակտիվացվել։';

  @override
  String get billing_verifying => 'Գնումը ստուգվում է…';

  @override
  String get billing_success =>
      'Բաժանորդագրությունն ակտիվացվել է։ Ձեր Premium հասանելիությունը պատրաստ է։';

  @override
  String get billing_restored => 'Ձեր գնումները վերականգնվել են։';

  @override
  String get billing_restoreEmpty =>
      'Այս Google Play հաշվի համար վերականգնելու գնումներ չկան։';

  @override
  String get billing_catalogError =>
      'Սակագները չհաջողվեց բեռնել։ Նորից փորձեք։';

  @override
  String get billing_purchaseError => 'Գնումը չհաջողվեց սկսել։ Նորից փորձեք։';

  @override
  String get billing_verificationError =>
      'Գնման ստուգումը ժամանակավորապես հասանելի չէ։ Նորից փորձելու համար վերականգնեք գնումները։';

  @override
  String get billing_restoreError =>
      'Գնումները չհաջողվեց վերականգնել։ Նորից փորձեք։';

  @override
  String get billing_managementError =>
      'Բաժանորդագրության կառավարումը չհաջողվեց բացել։ Նորից փորձեք։';

  @override
  String get billing_storeUnavailable =>
      'Google Play-ն այս սարքում հասանելի չէ։';

  @override
  String get welcome_title => 'Ձեր VPN-ը՝ պարզ և հարմար։';

  @override
  String get welcome_description =>
      'Պաշտպանեք ձեր կապը։ Վերահսկեք ձեր գաղտնիությունը։';

  @override
  String get welcome_start => 'Սկսել';

  @override
  String get welcome_alreadyPurchased => 'Արդեն գնե՞լ եք';

  @override
  String get welcome_noAccountRequired => 'Սկսելու համար հաշիվ պետք չէ։';

  @override
  String get guest_accountTitle => 'Հաշիվը կապված չէ';

  @override
  String get guest_accountDescription =>
      'Վերականգնեք ձեր գնումները նույն Google Play հաշվով՝ բաժանորդագրությունն այլ սարքում օգտագործելու համար։';

  @override
  String get guest_existingSubscriberSignIn =>
      'Արդեն բաժանորդագրվա՞ծ եք։ Մուտք գործեք';

  @override
  String get guest_claimTitle => 'Վերցրեք FuzeVPN-ը ձեզ հետ';

  @override
  String get guest_claimDescription =>
      'Ստեղծեք հաշիվ՝ բաժանորդագրությունը ձեր մյուս սարքերում օգտագործելու համար։ Այս քայլը պարտադիր չէ։';

  @override
  String get guest_skip => 'Ավելի ուշ';

  @override
  String get guest_activationTitle => 'Fuze Premium-ն ակտիվ է';

  @override
  String get guest_activationDescription =>
      'Ձեր բաժանորդագրությունը պատրաստ է։ Օգտագործեք ձեր VPN-ը և ստեղծեք հաշիվ, երբ ցանկանաք։';

  @override
  String get guest_useVpn => 'Օգտագործել իմ VPN-ը';

  @override
  String get guest_loginRequired =>
      'Այս գնումն արդեն կապված է FuzeVPN հաշվի հետ։ Մուտք գործեք այդ հաշիվ՝ ձեր բաժանորդագրությունն օգտագործելու համար։';

  @override
  String get guest_signOutWarning =>
      'Ձեր բաժանորդագրությունը կարող եք վերականգնել՝ նույն Google Play հաշվով գնումները վերականգնելով։';

  @override
  String get guest_profileUnavailable =>
      'Ձեր հաշիվն արդեն կապված է։ Մուտք գործեք՝ ձեր տվյալները դիտելու և կառավարելու համար։';

  @override
  String get billing_acceptance =>
      'Շարունակելով՝ դուք ընդունում եք օգտագործման պայմանները և գաղտնիության քաղաքականությունը։';

  @override
  String get guest_verifyEmailReminder =>
      'Հաստատեք ձեր էլփոստի հասցեն՝ հաշվի անվտանգությունն ապահովելու համար։ Կարող եք շարունակել օգտագործել ձեր VPN-ը։';

  @override
  String get guest_serviceUnavailable =>
      'Ծառայությունը ժամանակավորապես հասանելի չէ։ Նորից փորձեք քիչ հետո։';

  @override
  String get guest_restoreError =>
      'Ձեր գնումները չհաջողվեց վերականգնել։ Նորից փորձեք այն Google Play հաշվով, որով կատարվել էր գնումը։';

  @override
  String get guest_claimSuccess =>
      'Ձեր հաշիվը ստեղծվել է։ Ձեր բաժանորդագրությունը և VPN-ի հասանելիությունը պահպանված են։';

  @override
  String get guest_emailExists =>
      'Այս էլփոստն արդեն օգտագործվում է։ Ընտրեք այլ հասցե կամ մուտք գործեք ձեր գոյություն ունեցող հաշիվ։ Ձեր գնումը մնում է հասանելի Google Play-ի միջոցով։';

  @override
  String get guest_claimError =>
      'Ձեր հաշիվը չհաջողվեց ստեղծել։ Կարող եք շարունակել օգտվել ձեր VPN-ից և ավելի ուշ նորից փորձել։';

  @override
  String get guest_secureStorageError =>
      'Ձեր սեսիան չհաջողվեց անվտանգ պահպանել այս սարքում։ Նորից փորձեք։';

  @override
  String get guest_premiumRequired =>
      'Ընտրեք բաժանորդագրություն՝ ձեր VPN-ն ակտիվացնելու համար։';

  @override
  String get welcome_viewPlans => 'Դիտել սակագները';

  @override
  String get google_continue => 'Շարունակել Google-ով';

  @override
  String get google_or => 'կամ';

  @override
  String get google_title => 'Ձեր FuzeVPN հաշիվը';

  @override
  String get google_settingUp => 'Ավարտեք հաշվի ստեղծումը';

  @override
  String get google_country => 'Բնակության երկիր';

  @override
  String get google_profileDescription =>
      'Ընտրեք ձեր երկիրը և կարդացեք երկու փաստաթղթերը՝ FuzeVPN հաշիվը ստեղծելու համար։';

  @override
  String get google_claimDescription =>
      'Կապեք ձեր հյուրի հաշիվը Google-ին։ Ձեր բաժանորդագրությունը և սարքը մնում են այս հաշվին կապված։';

  @override
  String get google_linkTitle => 'Կապել Google-ը FuzeVPN-ի հետ';

  @override
  String get google_linkDescription =>
      'Հաստատեք ձեր առկա FuzeVPN հաշվի հասանելիությունը։ Այս քայլը չի պահանջում ձեր Google գաղտնաբառը։';

  @override
  String get google_password => 'FuzeVPN գաղտնաբառ';

  @override
  String get google_linkAccount => 'Հաստատել կապը';

  @override
  String get google_requestEmail => 'Ուղարկել ինձ հաստատման նամակ';

  @override
  String get google_emailInstructions =>
      'Բացեք FuzeVPN-ի նամակը և մուտքագրեք հաստատման կոդը։';

  @override
  String get google_emailCode => 'Էլփոստի հաստատման կոդ';

  @override
  String get google_confirmEmail => 'Հաստատել կոդը';

  @override
  String get google_restart => 'Ընտրել այլ Google հաշիվ';

  @override
  String get google_resume => 'Ստուգել այս փորձը';

  @override
  String get google_unavailable =>
      'Google-ով մուտքը հասանելի չէ։ Կարող եք օգտագործել էլփոստն ու գաղտնաբառը։';

  @override
  String get google_expired =>
      'Այս փորձի ժամկետը լրացել է։ Չեղարկեք այն և նորից սկսեք։';

  @override
  String get google_conflict =>
      'Այս Google հաշիվն արդեն կապված է մեկ այլ հաշվի հետ։ Ձեր ներկա հաշիվը և բաժանորդագրությունը պահպանվում են։';

  @override
  String get google_error =>
      'Google-ով մուտքը չհաջողվեց։ Նորից փորձեք։ Ձեր ներկա հասանելիությունը պահպանվում է։';

  @override
  String get google_uncertain =>
      'Արդյունքը հաստատել չհաջողվեց։ Ստուգեք այս փորձը կամ չեղարկեք այն նորից սկսելուց առաջ։';

  @override
  String get google_cancelFailed =>
      'Չեղարկումը հաստատել չհաջողվեց։ Այս էկրանից դուրս գալուց առաջ նորից փորձեք չեղարկել։';

  @override
  String get google_cancelled => 'Google-ով մուտքը չեղարկվեց։';

  @override
  String get google_selecting => 'Ընտրեք ձեր Google հաշիվը…';

  @override
  String get google_verifying => 'Ձեր հաշիվը ստուգվում է…';

  @override
  String get google_emailUnavailable =>
      'Հաստատման նամակը չհաջողվեց ուղարկել։ Նորից փորձեք ավելի ուշ։';

  @override
  String get google_emailSent =>
      'Հաստատման նամակն ուղարկվել է։ Ստուգեք ձեր մուտքի արկղը։';

  @override
  String get google_rateLimited => 'Խնդրում ենք սպասել, նախքան նորից փորձելը։';

  @override
  String get google_busy =>
      'Google-ը հասանելի չէ, մինչ ընթանում է մեկ այլ գործողություն (VPN միացում, հաշիվ կամ հյուր)։ Նորից փորձեք, երբ այն ավարտվի։ Ձեր ներկա հասանելիությունը պահպանվում է։';

  @override
  String get google_invalidPassword =>
      'FuzeVPN գաղտնաբառը սխալ է։ Ձեր ներկա հաշիվը պահպանվում է։';

  @override
  String get google_invalidCode => 'Հաստատման կոդը սխալ է կամ ժամկետն անցել է։';

  @override
  String get google_accountChanged =>
      'Ձեր սեսիան փոխվել է։ Նորից սկսելուց առաջ չեղարկեք այս փորձը։';

  @override
  String get google_invalidResponse =>
      'Պատասխանը հաստատել չհաջողվեց։ Ձեր ներկա հասանելիությունը պահպանվում է։';

  @override
  String get google_invalidRegistration =>
      'Ստուգեք ձեր երկիրը և երկու համաձայնությունները։';

  @override
  String get google_consentRequired =>
      'Շարունակելու համար ընտրեք ձեր երկիրը և ընդունեք երկու փաստաթղթերը։';

  @override
  String get google_challengeRequired =>
      'Պահանջվում է լրացուցիչ անվտանգության ստուգում։ Ձեր ներկա հասանելիությունը պահպանվում է։';

  @override
  String get google_challengeUnavailable =>
      'Անվտանգության ստուգումը հասանելի չէ։ Նորից փորձեք ավելի ուշ։';

  @override
  String get google_intentMismatch =>
      'Google-ով մուտքի նախորդ փորձը դեռ սպասման մեջ է։ Այս գործողությունը սկսելուց առաջ չեղարկեք այն։';

  @override
  String get google_challengeBlocked =>
      'Պահանջվող անվտանգության ստուգումն այս հավելվածում հասանելի չէ։ Այս գործողությունը ներկայումս հնարավոր չէ ավարտել։';

  @override
  String get google_solveChallenge => 'Անցնել անվտանգության ստուգումը';

  @override
  String get google_challengeTitle => 'Անվտանգության ստուգում';

  @override
  String get google_challengeReady =>
      'Ստուգումն ավարտված է։ Այժմ կարող եք հաստատել ձեր հաշվի ստեղծումը։';

  @override
  String get google_challengeExpired =>
      'Ստուգման ժամկետն անցել է։ Հաստատելուց առաջ անցեք այն նորից։';

  @override
  String get google_challengeCancelled =>
      'Ստուգումը չեղարկվեց։ Կարող եք նորից փորձել։';

  @override
  String get google_challengeFailed =>
      'Անվտանգության ստուգումը չհաջողվեց։ Նորից փորձեք։';

  @override
  String get billing_trialTitle => 'Փորձեք Fuze Premium-ն անվճար';

  @override
  String get billing_trialSubtitle => 'Սկսեք պաշտպանել ձեր կապն այսօրվանից։';

  @override
  String get billing_trialWeeks => '2-շաբաթյա անվճար փորձաշրջան';

  @override
  String billing_trialDays(String days) {
    return '$days-օրյա անվճար փորձաշրջան';
  }

  @override
  String get billing_trialStart => 'Սկսել իմ անվճար փորձաշրջանը';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Եթե սկսեք այսօր, առաջին վճարումը նախատեսված է հետևյալ ամսաթվին՝ $date։';
  }

  @override
  String get billing_trialTerms =>
      'Ավտոմատ երկարացվում է նշված գնով։ Վճարումից խուսափելու համար չեղարկեք Google Play-ում մինչև փորձաշրջանի ավարտը։';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Ապա՝ $price ամսական';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Ապա՝ $price տարեկան';
  }

  @override
  String get billing_choosePeriod => 'Ընտրեք ձեր սակագինը';

  @override
  String get billing_selectionHint => 'Շարունակելու համար ընտրեք սակագին։';

  @override
  String get billing_benefitConnection => 'Գաղտնագրված կապ';

  @override
  String get billing_benefitPrivacy => 'Առցանց գաղտնիություն';

  @override
  String get billing_benefitNoAccount => 'Գրանցում չի պահանջվում';

  @override
  String get billing_cancellation => 'Չեղարկել Google Play-ում';

  @override
  String get billing_premiumTitle => 'Ավելի լավ պաշտպանված կապ։';

  @override
  String get billing_premiumSubtitle =>
      'Պաշտպանեք ձեր կապը՝ ձեր սեփական տեմպով։';

  @override
  String get billing_priceMonthly => 'ամսական';

  @override
  String get billing_priceYearly => 'տարեկան';

  @override
  String get billing_trialToday => 'Այսօր վճարելու ոչինչ չկա';

  @override
  String get billing_trialConfirmation =>
      'Google Play-ը հաստատում է ամսաթվերը, վերջնական գումարը և կիրառվող հարկերը՝ նախքան ձեր հաստատումը։';

  @override
  String get billing_offerChanged =>
      'Այս առաջարկի պայմանները փոխվել են։ Թարմացրեք սակագները և նորից ընտրեք։';

  @override
  String get status_waitingNetwork => 'Սպասում է ցանցին';

  @override
  String get status_waitingNetworkDetail =>
      'Ցանց հասանելի չէ։ VPN-ը կստուգի կապը, երբ ցանցը վերադառնա։';

  @override
  String get locations_favoriteLoadFailed =>
      'Ընտրյալները չհաջողվեց բեռնել։ Նորից փորձեք։';

  @override
  String get locations_favoritesLoading => 'Ընտրյալները բեռնվում են…';
}
