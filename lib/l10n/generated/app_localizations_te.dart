// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get vpnDisclosure_title => 'మీ కనెక్షన్‌ను రక్షించండి';

  @override
  String get vpnDisclosure_body =>
      'ఈ పరికరం మరియు FuzeVPN సర్వర్‌ల మధ్య ఎన్‌క్రిప్ట్ చేసిన టన్నెల్‌ను సృష్టించడానికి FuzeVPN, Android VPN సేవను (VpnService) ఉపయోగిస్తుంది.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN యాక్టివ్‌గా ఉన్నప్పుడు, FuzeVPN నేపథ్యంలో ఉన్నప్పటికీ, మీ యాప్‌ల ఇంటర్నెట్ ట్రాఫిక్, గమ్యస్థాన చిరునామాలు మరియు DNS అభ్యర్థనలు మీ కనెక్షన్‌ను రూట్ చేయడానికి ఈ టన్నెల్ ద్వారా వెళ్తాయి.';

  @override
  String get vpnDisclosure_statusBody =>
      'మీ VPN కనెక్షన్‌ను చూపించడానికి యాప్ కనెక్షన్ స్థితి, దాని వ్యవధి మరియు బదిలీ అయిన డేటా పరిమాణాన్ని ఉపయోగిస్తుంది. మీరు దీన్ని ఎప్పుడైనా ఆపవచ్చు.';

  @override
  String get vpnDisclosure_privacy => 'గోప్యత';

  @override
  String get vpnDisclosure_accept => 'అంగీకరించి కొనసాగించండి';

  @override
  String get vpnDisclosure_decline => 'ఇప్పుడు వద్దు';

  @override
  String get accountRestoration_title => 'ఖాతా తాత్కాలికంగా అందుబాటులో లేదు';

  @override
  String get accountRestoration_message =>
      'మీ సెషన్ భద్రపరచబడింది. మీ ఖాతాను పునరుద్ధరించడానికి మళ్లీ ప్రయత్నించండి; మీరు ఇప్పటికీ ఇక్కడే VPN కనెక్షన్‌ను నిర్వహించవచ్చు.';

  @override
  String get action_retry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get session_endingTitle => 'సెషన్‌ను ముగిస్తోంది';

  @override
  String get session_ending =>
      'సెషన్‌ను ముగిస్తోంది: VPNను ఆపి, శుభ్రం చేస్తోంది…';

  @override
  String get session_stopFailed =>
      'VPN ఆగినట్లు నిర్ధారణ కాలేదు. మళ్లీ సైన్ ఇన్ చేసే ముందు ఆపడాన్ని మరోసారి ప్రయత్నించండి.';

  @override
  String get session_cleanupFailed =>
      'VPN ఆగిపోయింది, కానీ సెషన్ తొలగింపు నిర్ధారణ కాలేదు. శుభ్రం చేయడాన్ని మళ్లీ ప్రయత్నించండి.';

  @override
  String get session_retryStop => 'మళ్లీ ఆపివేయండి';

  @override
  String get session_retryCleanup => 'మళ్లీ శుభ్రం చేయండి';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPNను సురక్షితంగా సిద్ధం చేస్తోంది…';

  @override
  String get nav_connection => 'కనెక్షన్';

  @override
  String get nav_locations => 'స్థానాలు';

  @override
  String get nav_account => 'ఖాతా';

  @override
  String get nav_devices => 'పరికరాలు';

  @override
  String get nav_settings => 'సెట్టింగ్‌లు';

  @override
  String get action_refresh => 'రిఫ్రెష్ చేయండి';

  @override
  String get auth_tab_login => 'సైన్ ఇన్';

  @override
  String get auth_tab_register => 'సైన్ అప్';

  @override
  String get auth_stepAccount => 'ఖాతా';

  @override
  String get auth_stepIdentity => 'గుర్తింపు';

  @override
  String get auth_stepAddress => 'చిరునామా మరియు ఒప్పందాలు';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'దశ $current / $total';
  }

  @override
  String get auth_tagline => 'మీ VPN, సరళంగా.';

  @override
  String get auth_keysLocal => 'మీ ప్రైవేట్ VPN కీలు ఈ పరికరంలోనే ఉంటాయి.';

  @override
  String get form_email => 'ఇమెయిల్ చిరునామా';

  @override
  String get form_password => 'పాస్‌వర్డ్';

  @override
  String get form_showPassword => 'పాస్‌వర్డ్‌ను చూపించండి';

  @override
  String get form_hidePassword => 'పాస్‌వర్డ్‌ను దాచండి';

  @override
  String get form_passwordMin =>
      '8–72 UTF-8 బైట్‌లు. కొన్ని అక్షరాలు ఒకటి కంటే ఎక్కువ బైట్‌లను ఉపయోగిస్తాయి.';

  @override
  String get form_firstName => 'మొదటి పేరు';

  @override
  String get form_lastName => 'ఇంటిపేరు';

  @override
  String get form_phone => 'ఫోన్ (+33612345678)';

  @override
  String get form_address => 'చిరునామా';

  @override
  String get form_address2 => 'చిరునామా లైన్ 2 (ఐచ్ఛికం)';

  @override
  String get form_postalCode => 'పోస్టల్ కోడ్';

  @override
  String get form_city => 'నగరం';

  @override
  String get form_country => 'దేశ కోడ్ (ఉదా. FR)';

  @override
  String get action_login => 'సైన్ ఇన్ చేయండి';

  @override
  String get action_createAccount => 'ఖాతాను సృష్టించండి';

  @override
  String get action_createMyAccount => 'నా ఖాతాను సృష్టించండి';

  @override
  String get action_next => 'కొనసాగించండి';

  @override
  String get action_previous => 'వెనుకకు';

  @override
  String get action_forgotPassword => 'పాస్‌వర్డ్ మర్చిపోయారా?';

  @override
  String get auth_noAccount => 'ఇంకా ఖాతా లేదా?';

  @override
  String get auth_requiredInformation => 'మూడు దశల్లో మీ ఖాతాను సృష్టించండి.';

  @override
  String get auth_termsPrefix => 'నేను అంగీకరిస్తున్నాను: ';

  @override
  String get auth_termsLink => 'ఉపయోగ నిబంధనలు';

  @override
  String get auth_privacyPrefix => 'నేను అంగీకరిస్తున్నాను: ';

  @override
  String get auth_privacyLink => 'గోప్యతా విధానం';

  @override
  String get auth_consentRequired => 'ఖాతాను సృష్టించడానికి మీ అంగీకారం అవసరం.';

  @override
  String get validation_required => 'ఈ ఫీల్డ్ తప్పనిసరి.';

  @override
  String get validation_email => 'సరైన ఇమెయిల్ చిరునామాను నమోదు చేయండి.';

  @override
  String get validation_password =>
      'పాస్‌వర్డ్ చాలా చిన్నది: కనీసం 8 UTF-8 బైట్‌లు ఉండాలి.';

  @override
  String get validation_passwordTooLong =>
      'పాస్‌వర్డ్ చాలా పొడవుగా ఉంది: గరిష్ఠంగా 72 UTF-8 బైట్‌లు మాత్రమే ఉండాలి.';

  @override
  String get validation_phone =>
      'అంతర్జాతీయ ఫార్మాట్‌ను ఉపయోగించండి, ఉదాహరణకు +33612345678.';

  @override
  String get validation_country =>
      'రెండు అక్షరాల దేశ కోడ్‌ను ఉపయోగించండి, ఉదాహరణకు FR.';

  @override
  String get passwordReset_title => 'పాస్‌వర్డ్‌ను రీసెట్ చేయండి';

  @override
  String get passwordReset_description =>
      'పాస్‌వర్డ్ రీసెట్ లింక్‌ను పొందడానికి మీ ఖాతా ఇమెయిల్ చిరునామాను నమోదు చేయండి.';

  @override
  String get passwordReset_send => 'లింక్‌ను పంపండి';

  @override
  String get connection_title => 'మీ కనెక్షన్';

  @override
  String get connection_subtitle =>
      'స్థానాన్ని ఎంచుకోండి, ఆపై మీ VPNను ఆన్ చేయండి.';

  @override
  String get connection_prepare => 'కనెక్ట్ చేయడానికి సిద్ధంగా ఉన్నారా?';

  @override
  String get connection_advancedOptions => 'అధునాతన ఎంపికలు';

  @override
  String get connection_location => 'స్థానం';

  @override
  String get connection_chooseLocation => 'స్థానాన్ని ఎంచుకోండి';

  @override
  String get connection_protocol => 'ప్రోటోకాల్';

  @override
  String get connection_connect => 'కనెక్ట్ చేయండి';

  @override
  String get connection_connecting => 'కనెక్ట్ అవుతోంది…';

  @override
  String get connection_disconnect => 'డిస్‌కనెక్ట్ చేయండి';

  @override
  String get connection_disconnecting => 'డిస్‌కనెక్ట్ అవుతోంది';

  @override
  String get connection_locationChange => 'స్థానాన్ని మారుస్తోంది…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol అందుబాటులో లేదు';
  }

  @override
  String get connection_activeLocation => 'ప్రస్తుత స్థానం';

  @override
  String get connection_duration => 'వ్యవధి';

  @override
  String get connection_received => 'అందుకున్నది';

  @override
  String get connection_sent => 'పంపినది';

  @override
  String get connection_lastHandshake => 'చివరి సురక్షిత మార్పిడి';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration క్రితం';
  }

  @override
  String get verification_title => 'మీ ఇమెయిల్ చిరునామాను నిర్ధారించండి';

  @override
  String get verification_message =>
      'ఈ ఫోన్‌లో VPNను ఉపయోగించడానికి మీ ఇమెయిల్ చిరునామాను నిర్ధారించండి.';

  @override
  String get verification_resend => 'ఇమెయిల్‌ను మళ్లీ పంపండి';

  @override
  String get migration_title => 'స్థాన మార్పు';

  @override
  String get migration_draining => 'స్థాన మార్పును సిద్ధం చేస్తోంది…';

  @override
  String get migration_activating => 'కొత్త సర్వర్‌ను యాక్టివేట్ చేస్తోంది…';

  @override
  String get migration_ready => 'స్థానం అప్‌డేట్ అయింది.';

  @override
  String get migration_blocked =>
      'స్థాన మార్పుకు సర్వర్ జోక్యం అవసరం. తర్వాత మళ్లీ ప్రయత్నించండి లేదా సపోర్ట్ బృందాన్ని సంప్రదించండి.';

  @override
  String get migration_progress => 'స్థాన మార్పు పురోగతి';

  @override
  String migration_retryDelay(Object seconds) {
    return 'తనిఖీల మధ్య విరామం: $seconds సె.';
  }

  @override
  String get migration_resume => 'స్థాన మార్పును కొనసాగించండి';

  @override
  String get status_authorizing => 'అనుమతి అవసరం';

  @override
  String get status_authorizingDetail =>
      'VPNను అనుమతించడానికి Android అభ్యర్థనను అంగీకరించండి.';

  @override
  String get status_preparing => 'సిద్ధమవుతోంది';

  @override
  String get status_preparingDetail => 'మీ సురక్షిత కనెక్షన్ సిద్ధమవుతోంది.';

  @override
  String get status_reconnecting => 'మళ్లీ కనెక్ట్ అవుతోంది…';

  @override
  String get status_reconnectingDetail =>
      'కనెక్షన్‌కు అంతరాయం కలిగింది. VPN మళ్లీ కనెక్ట్ కావడానికి ప్రయత్నిస్తోంది.';

  @override
  String get status_connecting => 'కనెక్ట్ అవుతోంది';

  @override
  String get status_connectingDetail => 'VPN సర్వర్‌కు కనెక్ట్ అవుతోంది…';

  @override
  String get status_connected => 'కనెక్ట్ అయింది';

  @override
  String get status_connectedDetail => 'మీ VPN కనెక్షన్ యాక్టివ్‌గా ఉంది.';

  @override
  String get status_disconnecting => 'డిస్‌కనెక్ట్ అవుతోంది';

  @override
  String get status_disconnectingDetail => 'మీ VPN కనెక్షన్ ఆగిపోతోంది.';

  @override
  String get status_error => 'కనెక్షన్ అందుబాటులో లేదు';

  @override
  String get status_errorDetail =>
      'VPN కనెక్షన్ నిర్ధారణ కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get status_idle => 'డిస్‌కనెక్ట్ అయింది';

  @override
  String get status_idleDetail =>
      'మీ కనెక్షన్‌ను రక్షించడానికి VPNను కనెక్ట్ చేయండి.';

  @override
  String get trust_note =>
      'యాప్‌ను మూసివేయడం VPNను ఆపదు. దాన్ని ఆపడానికి ‘డిస్‌కనెక్ట్ చేయండి’ నొక్కండి.';

  @override
  String get locations_none => 'ప్రస్తుతం స్థానాలు ఏవీ అందుబాటులో లేవు.';

  @override
  String get locations_available => 'మీ తదుపరి స్థానాన్ని ఎంచుకోండి.';

  @override
  String get locations_selected => 'ఎంచుకున్న స్థానం';

  @override
  String get locations_select => 'ఈ స్థానాన్ని ఎంచుకోండి';

  @override
  String get locations_lockedTunnel =>
      'స్థానాన్ని మార్చడానికి VPNను డిస్‌కనెక్ట్ చేయండి.';

  @override
  String get locations_lockedMigration =>
      'స్థాన మార్పు పూర్తయ్యే వరకు వేచి ఉండండి.';

  @override
  String get devices_title => 'మీ పరికరాలు';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit పరికరాలు';
  }

  @override
  String get devices_refresh => 'పరికరాలను రిఫ్రెష్ చేయండి';

  @override
  String get devices_empty => 'ఇంకా VPN పరికరం ఏదీ నమోదు కాలేదు.';

  @override
  String get devices_firstConnection =>
      'మొదటి కనెక్షన్‌లో మీ ఫోన్ జోడించబడుతుంది.';

  @override
  String get devices_thisDevice => 'ఈ పరికరం';

  @override
  String devices_added(Object date) {
    return '$dateన జోడించబడింది';
  }

  @override
  String get devices_unnamed => 'పేరు లేని పరికరం';

  @override
  String get action_remove => 'తీసివేయండి';

  @override
  String get settings_title => 'సెట్టింగ్‌లు';

  @override
  String get settings_subtitle => 'మీ ప్రాధాన్యతలు మరియు ఖాతా, అన్నీ ఒకే చోట.';

  @override
  String get settings_appearance => 'రూపం';

  @override
  String get settings_language => 'భాష';

  @override
  String get settings_languageDescription =>
      'మీరు ఎంచుకున్న భాష VPN నోటిఫికేషన్‌లకు కూడా వర్తిస్తుంది.';

  @override
  String get settings_account => 'ఖాతా';

  @override
  String get settings_signOut => 'సైన్ అవుట్ చేయండి';

  @override
  String get settings_privacy => 'గోప్యతా విధానం';

  @override
  String get settings_terms => 'ఉపయోగ నిబంధనలు';

  @override
  String get settings_security => 'భద్రత మరియు పారదర్శకత';

  @override
  String get settings_licenses => 'భాగాల లైసెన్స్‌లు';

  @override
  String get settings_licensesDetail => 'యాప్‌లో ఉపయోగించిన సాఫ్ట్‌వేర్';

  @override
  String settings_licensesLegalese(String url) {
    return 'యాప్ మరియు దాని MPL-2.0 భాగాల సోర్స్ కోడ్: $url';
  }

  @override
  String get settings_background =>
      'మీరు యాప్ నుండి నిష్క్రమించినప్పుడు VPN ఆన్‌లోనే ఉంటుంది. దాన్ని ఆపడానికి, కనెక్షన్ ట్యాబ్‌లో ‘డిస్‌కనెక్ట్ చేయండి’ నొక్కండి.';

  @override
  String get theme_system => 'సిస్టమ్';

  @override
  String get theme_light => 'లైట్';

  @override
  String get theme_dark => 'డార్క్';

  @override
  String get language_system => 'ఫోన్ భాష';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'ఈ పరికరాన్ని తీసివేయాలా?';

  @override
  String get dialog_removeCurrent =>
      'ఈ ఫోన్ VPN నుండి డిస్‌కనెక్ట్ అవుతుంది మరియు దాని యాక్సెస్ కోల్పోతుంది. సర్వర్ నిర్ధారించిన తర్వాత దాని VPN కనెక్షన్ డేటా తొలగించబడుతుంది.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name” కోసం VPN యాక్సెస్ రద్దు చేయబడుతుంది. దీన్ని వెనక్కి తీసుకోలేరు.';
  }

  @override
  String get dialog_signOut => 'సైన్ అవుట్ చేయాలా?';

  @override
  String get dialog_signOutMessage =>
      'VPN ఆగిపోతుంది, మీరు మళ్లీ సైన్ ఇన్ చేయాలి. మీ ఎన్‌క్రిప్ట్ చేసిన VPN కీలు మీ తదుపరి కనెక్షన్ కోసం ఈ ఫోన్‌లోనే ఉంటాయి.';

  @override
  String get action_cancel => 'రద్దు చేయండి';

  @override
  String get action_close => 'మూసివేయండి';

  @override
  String get action_copy => 'కాపీ చేయి';

  @override
  String get action_signOut => 'సైన్ అవుట్ చేయండి';

  @override
  String get notice_close => 'సందేశాన్ని మూసివేయండి';

  @override
  String get notice_sessionExpired_title => 'సెషన్ గడువు ముగిసింది';

  @override
  String get notice_sessionExpired_message =>
      'మీ సెషన్ గడువు ముగిసింది. మళ్లీ సైన్ ఇన్ చేయండి.';

  @override
  String get notice_connectionFailed_title => 'కనెక్షన్ విఫలమైంది';

  @override
  String get notice_invalidCredentials_message =>
      'ఇమెయిల్ చిరునామా లేదా పాస్‌వర్డ్ తప్పు.';

  @override
  String get notice_emailVerification_title => 'ఇమెయిల్ నిర్ధారణ అవసరం';

  @override
  String get notice_emailVerification_message =>
      'VPN పరికరాన్ని జోడించే ముందు మీ ఇమెయిల్ చిరునామాను నిర్ధారించండి.';

  @override
  String get notice_rateLimited_title => 'చాలాసార్లు ప్రయత్నించారు';

  @override
  String get notice_deviceLimit_title => 'పరికరాల పరిమితి చేరుకుంది';

  @override
  String get notice_deviceLimit_message =>
      'మరొకదాన్ని జోడించే ముందు ఇప్పటికే ఉన్న పరికరాన్ని తీసివేయండి.';

  @override
  String get notice_identityRenewal_title => 'VPN గుర్తింపును పునరుద్ధరించాలి';

  @override
  String get notice_identityRenewal_message =>
      'ఈ గుర్తింపు తీసివేయబడింది. కొత్త స్థానిక గుర్తింపును సృష్టించండి.';

  @override
  String get notice_migrationPending_title => 'స్థాన మార్పు జరుగుతోంది';

  @override
  String get notice_migrationPending_message =>
      'స్థాన మార్పు ఇప్పటికే జరుగుతోంది.';

  @override
  String get notice_migrationBlocked_title => 'స్థాన మార్పు నిరోధించబడింది';

  @override
  String get notice_migrationBlocked_message =>
      'స్థాన మార్పుకు సర్వర్ జోక్యం అవసరం. తర్వాత మళ్లీ ప్రయత్నించండి లేదా సపోర్ట్ బృందాన్ని సంప్రదించండి.';

  @override
  String get notice_targetUnavailable_title =>
      'సర్వర్ తాత్కాలికంగా అందుబాటులో లేదు';

  @override
  String get notice_targetUnavailable_message =>
      'ఈ సర్వర్ తాత్కాలికంగా అందుబాటులో లేదు.';

  @override
  String get notice_networkUnavailable_title =>
      'ఇంటర్నెట్ కనెక్షన్ అందుబాటులో లేదు';

  @override
  String get notice_networkUnavailable_message =>
      'మీ కనెక్షన్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get notice_permissionDenied_title => 'VPN అనుమతి తిరస్కరించబడింది';

  @override
  String get notice_permissionDenied_message =>
      'కనెక్షన్‌ను మళ్లీ ప్రారంభించి, Android అనుమతి అభ్యర్థనను అంగీకరించండి.';

  @override
  String get notice_wireguardTimeout_title => 'సర్వర్ స్పందించడం లేదు';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard కనెక్షన్‌కు చాలా సమయం పట్టింది. మళ్లీ ప్రయత్నించండి లేదా మరో స్థానాన్ని ఎంచుకోండి.';

  @override
  String get notice_tlsFailed_title => 'సురక్షిత కనెక్షన్ తిరస్కరించబడింది';

  @override
  String get notice_tlsFailed_message =>
      'సర్వర్ OpenVPN కనెక్షన్‌ను అంగీకరించలేదు. మళ్లీ ప్రయత్నించండి. సమస్య కొనసాగితే, డయాగ్నస్టిక్స్‌ను ప్రారంభించండి.';

  @override
  String get notice_tunRejected_title =>
      'VPN ఇంటర్‌ఫేస్‌ను Android తిరస్కరించింది';

  @override
  String get notice_tunRejected_message =>
      'OpenVPN అభ్యర్థించిన నెట్‌వర్క్ కాన్ఫిగరేషన్‌ను Android తిరస్కరించింది.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN ప్రారంభం కాలేదు';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN ఇంజిన్ ప్రారంభాన్ని పూర్తి చేయలేకపోయింది. మళ్లీ ప్రయత్నించండి. సమస్య కొనసాగితే, సపోర్ట్ బృందాన్ని సంప్రదించండి.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'డయాగ్నస్టిక్ కోడ్: $code';
  }

  @override
  String get notice_generic_title => 'VPN కనెక్షన్ విఫలమైంది';

  @override
  String get notice_generic_message =>
      'ఒక లోపం ఏర్పడింది. తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'ఖాతా సృష్టించబడింది',
      'password_reset_sent': 'పాస్‌వర్డ్ రీసెట్ అభ్యర్థన అందింది',
      'verification_email_sent': 'ధ్రువీకరణ ఇమెయిల్ పంపబడింది',
      'location_migration_pending': 'స్థాన మార్పు జరుగుతోంది',
      'vpn_sign_in_required': 'సైన్ ఇన్ అవసరం',
      'protocol_unavailable_at_location': 'ప్రోటోకాల్ అందుబాటులో లేదు',
      'vpn_permission_denied': 'VPN అనుమతి తిరస్కరించబడింది',
      'revoked_identity_device_limit': 'పరికరాల పరిమితి చేరుకుంది',
      'tunnel_start_unexpected': 'VPN ప్రారంభం కాలేదు',
      'flutter_disconnect_timeout': 'డిస్‌కనెక్షన్ నిర్ధారణ కాలేదు',
      'flutter_disconnect_unexpected': 'డిస్‌కనెక్ట్ చేయడం సాధ్యం కాలేదు',
      'device_revoked': 'పరికరం తీసివేయబడింది',
      'revoke_unexpected': 'పరికరాన్ని తీసివేయడం సాధ్యం కాలేదు',
      'identity_renewal_unexpected': 'గుర్తింపును పునరుద్ధరించడం సాధ్యం కాలేదు',
      'openvpn_renewal_unexpected': 'OpenVPNను పునరుద్ధరించడం సాధ్యం కాలేదు',
      'location_migration_blocked': 'స్థాన మార్పు నిరోధించబడింది',
      'location_migration_slow': 'స్థాన మార్పు ఇంకా జరుగుతోంది',
      'location_migration_conflict': 'స్థాన మార్పును రిఫ్రెష్ చేయాలి',
      'location_migration_verification_failed': 'స్థాన మార్పు నిర్ధారణ కాలేదు',
      'location_migration_device_changed': 'స్థాన మార్పు సమయంలో పరికరం మారింది',
      'tunnel_stop_failed': 'స్థాన మార్పు అందుబాటులో లేదు',
      'device_clock_ahead': 'పరికర సమయం ముందుగా ఉంది',
      'other': 'ఆపరేషన్ విఫలమైంది',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'ఖాతా సృష్టించబడింది, కానీ ధ్రువీకరణ ఇమెయిల్ పంపడం సాధ్యం కాలేదు. యాప్‌లోని మళ్లీ పంపండి ఎంపికను ఉపయోగించండి.',
      'password_reset_sent':
          'మీ అభ్యర్థన అందింది. ఈ చిరునామాతో ఖాతా ఉంటే, మీకు ఇమెయిల్ రావచ్చు. దయచేసి స్పామ్ ఫోల్డర్‌ను కూడా తనిఖీ చేయండి.',
      'verification_email_sent': 'కొత్త ధ్రువీకరణ ఇమెయిల్ ఇప్పుడే పంపబడింది.',
      'location_migration_pending':
          '$targetకు మార్పు ఇంకా సిద్ధం చేయబడుతోంది. పరికరాన్ని మళ్లీ సృష్టించకుండానే దీన్ని కొనసాగించవచ్చు.',
      'vpn_sign_in_required':
          'VPNను ప్రారంభించే ముందు మీ ఖాతాకు సైన్ ఇన్ చేయండి.',
      'protocol_unavailable_at_location':
          'ఎంచుకున్న ప్రోటోకాల్ ఈ స్థానంలో అందుబాటులో లేదు. స్థానాలను రిఫ్రెష్ చేయండి లేదా మరొక ప్రోటోకాల్‌ను ఎంచుకోండి.',
      'vpn_permission_denied':
          'VPN అనుమతిని Android తిరస్కరించింది. కనెక్షన్‌ను మళ్లీ ప్రారంభించి, సిస్టమ్ అభ్యర్థనను అంగీకరించండి.',
      'revoked_identity_device_limit':
          'ఈ పరికరం యొక్క VPN యాక్సెస్ తీసివేయబడింది, మరియు పరికరాల పరిమితి చేరుకుంది. ఖాతా → నా పరికరాలను నిర్వహించండి కింద ఒక పరికరాన్ని తీసివేయండి.',
      'tunnel_start_unexpected':
          'ఊహించని లోపం వల్ల టన్నెల్ సిద్ధం కావడానికి అంతరాయం కలిగింది. డయాగ్నస్టిక్ కోడ్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.',
      'flutter_disconnect_timeout':
          'VPN నిర్ణీత సమయంలో ఆగిపోయినట్లు Android నిర్ధారించలేదు. దాన్ని మళ్లీ ఆపడానికి ప్రయత్నించండి.',
      'flutter_disconnect_unexpected':
          'ఊహించని లోపం వల్ల టన్నెల్ ఆగిపోయిందని నిర్ధారించడం సాధ్యం కాలేదు.',
      'device_revoked':
          'పరికరం యొక్క VPN యాక్సెస్ రద్దు చేయబడింది, దాని స్థానిక రహస్య సమాచారం తొలగించబడింది.',
      'revoke_unexpected':
          'పరికరాన్ని తీసివేయడం సాధ్యం కాలేదు. జాబితాను రిఫ్రెష్ చేసి మళ్లీ ప్రయత్నించండి.',
      'identity_renewal_unexpected':
          'కొత్త VPN గుర్తింపును సృష్టించడం సాధ్యం కాలేదు. పరికరాలను రిఫ్రెష్ చేసి మళ్లీ ప్రయత్నించండి.',
      'openvpn_renewal_unexpected':
          'OpenVPN ప్రొఫైల్‌ను పునరుద్ధరించడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి లేదా డయాగ్నస్టిక్ కోడ్‌ను తనిఖీ చేయండి.',
      'location_migration_blocked':
          'ఈ మార్పును సర్వర్ ప్రస్తుతం పూర్తి చేయలేదు. పరికరం మరియు దాని స్థానిక గుర్తింపు భద్రపరచబడ్డాయి.',
      'location_migration_slow':
          '$targetకు మార్పును సర్వర్ ఇంకా సిద్ధం చేస్తోంది. కొద్ది క్షణాల తర్వాత స్థాన మార్పును కొనసాగించండి.',
      'location_migration_conflict':
          'సర్వర్‌లో పరికర స్థితి మారింది. పరికరాలను రిఫ్రెష్ చేసి, ఆ తర్వాత మార్పును కొనసాగించండి.',
      'location_migration_verification_failed':
          'కొత్త స్థానాన్ని సర్వర్ నిర్ధారించలేదు. మునుపటి స్థానిక గుర్తింపు భద్రపరచబడింది.',
      'location_migration_device_changed':
          'సర్వర్ తిరిగి ఇచ్చిన పరికరం, మారుతున్న పరికరంతో ఇకపై సరిపోలడం లేదు. మళ్లీ ప్రయత్నించే ముందు పరికరాలను రిఫ్రెష్ చేయండి.',
      'tunnel_stop_failed':
          'కొత్త కనెక్షన్‌కు ముందు మునుపటి టన్నెల్ పూర్తిగా ఆగిపోవాలి.',
      'device_clock_ahead':
          'ఈ పరికరం సమయం ముందుగా ఉన్నట్లు కనిపిస్తోంది. సైన్ ఇన్ అయి ఉండటానికి ఆటోమేటిక్ తేదీ మరియు సమయాన్ని ఆన్ చేయండి.',
      'other':
          'ఆపరేషన్ పూర్తి చేయడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి లేదా డయాగ్నస్టిక్ కోడ్‌ను సపోర్ట్ బృందానికి పంపండి.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'సెషన్ గడువు ముగిసింది',
      'invalid_credentials': 'సైన్ ఇన్ విఫలమైంది',
      'email_verification_required': 'ఇమెయిల్ నిర్ధారణ అవసరం',
      'verification_email_cooldown': 'ఇమెయిల్ ఇప్పటికే పంపబడింది',
      'rate_limited': 'చాలాసార్లు ప్రయత్నించారు',
      'invalid_registration': 'సమాచారాన్ని సరిచేయాలి',
      'email_exists': 'ఖాతా ఇప్పటికే ఉంది',
      'invalid_profile': 'చెల్లని ప్రొఫైల్',
      'invalid_device': 'చెల్లని పరికరం',
      'invalid_location': 'స్థానం అందుబాటులో లేదు',
      'device_limit': 'పరికరాల పరిమితి చేరుకుంది',
      'device_exists': 'ఈ VPN గుర్తింపు ఇప్పటికే ఉపయోగంలో ఉంది',
      'device_identity_revoked': 'VPN గుర్తింపును పునరుద్ధరించాలి',
      'device_location_locked': 'స్థాన మార్పును రిఫ్రెష్ చేయాలి',
      'location_migration_pending': 'స్థాన మార్పు జరుగుతోంది',
      'location_migration_blocked': 'స్థాన మార్పు నిరోధించబడింది',
      'target_ca_mismatch': 'అనుకూలంగా లేని OpenVPN సర్వర్',
      'location_migration_conflict': 'స్థాన మార్పును రిఫ్రెష్ చేయాలి',
      'server_full': 'సర్వర్ నిండిపోయింది',
      'capacity_unavailable': 'స్థానం తాత్కాలికంగా అందుబాటులో లేదు',
      'target_unavailable': 'సర్వర్ తాత్కాలికంగా అందుబాటులో లేదు',
      'not_found': 'అంశం కనుగొనబడలేదు',
      'invalid_openvpn_csr': 'చెల్లని OpenVPN గుర్తింపు',
      'openvpn_profile_exists': 'OpenVPN ప్రొఫైల్ ఇప్పటికే ఉంది',
      'openvpn_profile_revoked': 'OpenVPN ప్రొఫైల్ రద్దు చేయబడింది',
      'openvpn_operation_pending': 'OpenVPN ఆపరేషన్ జరుగుతోంది',
      'openvpn_operation_terminal': 'OpenVPN ఆపరేషన్‌కు అంతరాయం కలిగింది',
      'openvpn_address_unavailable': 'OpenVPN చిరునామా అందుబాటులో లేదు',
      'openvpn_profile_conflict': 'OpenVPN వైరుధ్యం',
      'openvpn_signer_unavailable': 'OpenVPN అందుబాటులో లేదు',
      'email_delivery_unavailable': 'ఇమెయిల్ అందుబాటులో లేదు',
      'invalid_token': 'చెల్లని లింక్',
      'network_unavailable': 'ఇంటర్నెట్ కనెక్షన్ అందుబాటులో లేదు',
      'invalid_json': 'చెల్లని అభ్యర్థన',
      'invalid_api_response': 'చెల్లని సర్వర్ ప్రతిస్పందన',
      'ipv6_unavailable': 'IPv6 అందుబాటులో లేదు',
      'invalid_ip_families': 'నెట్‌వర్క్ కాన్ఫిగరేషన్ తిరస్కరించబడింది',
      'other': 'సేవ అందుబాటులో లేదు',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'మీ సెషన్ గడువు ముగిసింది. మళ్లీ సైన్ ఇన్ చేయండి.',
      'invalid_credentials': 'ఇమెయిల్ చిరునామా లేదా పాస్‌వర్డ్ సరిగ్గా లేదు.',
      'email_verification_required':
          'VPN పరికరాన్ని జోడించే ముందు మీ ఇమెయిల్ చిరునామాను నిర్ధారించండి.',
      'invalid_registration':
          'అభ్యర్థించిన సమాచారాన్ని, అంగీకారాలను తనిఖీ చేయండి.',
      'email_exists': 'ఈ ఇమెయిల్ చిరునామాతో ఇప్పటికే ఒక ఖాతా ఉంది.',
      'invalid_profile': 'మీ ప్రొఫైల్ సమాచారాన్ని తనిఖీ చేయండి.',
      'invalid_device': 'ఈ పరికరం పేరు లేదా స్థానిక గుర్తింపు చెల్లదు.',
      'invalid_location':
          'స్థానాల జాబితాను రిఫ్రెష్ చేసి, మళ్లీ ప్రయత్నించండి.',
      'device_limit':
          'మరొకదాన్ని జోడించే ముందు ఇప్పటికే ఉన్న పరికరాన్ని తీసివేయండి.',
      'device_exists': 'ఈ VPN గుర్తింపు ఇప్పటికే మరో ఖాతాకు లింక్ చేయబడి ఉంది.',
      'device_identity_revoked':
          'ఈ గుర్తింపు తీసివేయబడింది. కొత్త స్థానిక గుర్తింపును సృష్టించాలి.',
      'device_location_locked':
          'ఈ పరికరం స్థానం ఇప్పుడే మారింది. యాప్ జరుగుతున్న మార్పును కొనసాగిస్తుంది.',
      'location_migration_pending': 'స్థాన మార్పు ఇప్పటికే జరుగుతోంది.',
      'location_migration_blocked':
          'స్థాన మార్పుకు సర్వర్ జోక్యం అవసరం. తర్వాత మళ్లీ ప్రయత్నించండి లేదా సపోర్ట్ బృందాన్ని సంప్రదించండి.',
      'target_ca_mismatch':
          'ఈ సర్వర్ ప్రస్తుత OpenVPN ప్రొఫైల్‌తో ఇంకా అనుకూలంగా లేదు.',
      'location_migration_conflict':
          'పరికరాలను రిఫ్రెష్ చేసి, స్థాన మార్పును మళ్లీ ప్రయత్నించండి.',
      'server_full':
          'ఈ స్థానం కనెక్షన్ పరిమితికి చేరుకుంది. మరో స్థానాన్ని ఎంచుకోండి లేదా కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'capacity_unavailable':
          'ఈ స్థానం ప్రస్తుతం అందుబాటులో ఉందో లేదో నిర్ధారించలేకపోతున్నాము. మరో స్థానాన్ని ఎంచుకోండి లేదా కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'target_unavailable': 'ఈ సర్వర్ తాత్కాలికంగా అందుబాటులో లేదు.',
      'not_found': 'ఈ అంశం ఇకపై మీ ఖాతాలో అందుబాటులో లేదు.',
      'invalid_openvpn_csr':
          'కొత్త OpenVPN గుర్తింపును సృష్టించి, మళ్లీ ప్రయత్నించండి.',
      'openvpn_profile_exists':
          'ఈ పరికరానికి ఇప్పటికే ఒక OpenVPN ప్రొఫైల్ ఉంది.',
      'openvpn_profile_revoked':
          'కొనసాగించడానికి OpenVPN ప్రొఫైల్‌ను పునరుద్ధరించండి.',
      'openvpn_operation_pending':
          'మార్పు ఇంకా అమలులోకి వస్తోంది. కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'openvpn_operation_terminal':
          'కొత్త OpenVPN గుర్తింపును సృష్టించి, మళ్లీ ప్రయత్నించండి.',
      'openvpn_address_unavailable':
          'ప్రస్తుతం OpenVPN చిరునామా అందుబాటులో లేదు.',
      'openvpn_profile_conflict':
          'ప్రొఫైల్ మారింది. పరికరాలను రిఫ్రెష్ చేసి, మళ్లీ ప్రయత్నించండి.',
      'openvpn_signer_unavailable': 'OpenVPN సేవ తాత్కాలికంగా అందుబాటులో లేదు.',
      'email_delivery_unavailable':
          'ఇమెయిల్ పంపలేకపోయాము. కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'invalid_token':
          'ఈ లింక్ చెల్లదు లేదా గడువు ముగిసింది. కొత్త లింక్‌ను అభ్యర్థించండి.',
      'network_unavailable':
          'మీ ఇంటర్నెట్ కనెక్షన్‌ను తనిఖీ చేసి, మళ్లీ ప్రయత్నించండి.',
      'invalid_json':
          'నమోదు చేసిన సమాచారాన్ని తనిఖీ చేసి, మళ్లీ ప్రయత్నించండి.',
      'invalid_api_response':
          'సర్వర్ ఊహించని ప్రతిస్పందనను పంపింది. కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'ipv6_unavailable':
          'ప్రస్తుతం సర్వర్ IPv6ను యాక్టివేట్ చేయలేకపోతోంది. కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'invalid_ip_families':
          'టన్నెల్ కాన్ఫిగరేషన్ అసంపూర్ణంగా ఉంది లేదా అనుమతించబడిన చిరునామాలతో సరిపోలడం లేదు. యాప్ నుండి మళ్లీ ప్రయత్నించండి.',
      'other': 'సర్వర్ లోపం ఏర్పడింది. కొంత సేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'కొద్ది క్షణాల తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds సెకన్లలో మళ్లీ ప్రయత్నించండి.',
      one: '$seconds సెకనులో మళ్లీ ప్రయత్నించండి.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes నిమిషాల్లో మళ్లీ ప్రయత్నించండి.',
      one: '$minutes నిమిషంలో మళ్లీ ప్రయత్నించండి.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours గంటల్లో మళ్లీ ప్రయత్నించండి.',
      one: '$hours గంటలో మళ్లీ ప్రయత్నించండి.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'సిస్టమ్ VPN కొనసాగింపు అందుబాటులో లేదు',
      'system_vpn_resume_corrupt': 'చెల్లని సిస్టమ్ VPN కొనసాగింపు',
      'system_vpn_resume_session_invalid': 'చెల్లని VPN కొనసాగింపు సెషన్',
      'system_vpn_resume_identity_changed': 'VPN గుర్తింపు మారింది',
      'system_vpn_resume_identity_invalid': 'చెల్లని VPN కొనసాగింపు గుర్తింపు',
      'system_vpn_resume_storage_failed':
          'VPN కొనసాగింపు నిల్వ అందుబాటులో లేదు',
      'system_vpn_resume_network_timeout': 'VPN కొనసాగింపుకు నెట్‌వర్క్ లేదు',
      'system_vpn_resume_blocked': 'VPN కొనసాగింపు నిరోధించబడింది',
      'system_vpn_resume_failed': 'VPN కొనసాగింపు విఫలమైంది',
      'system_vpn_resume_error_invalid': 'చెల్లని VPN కొనసాగింపు లోపం',
      'wireguard_identity_store_failed': 'WireGuard గుర్తింపు సేవ్ కాలేదు',
      'wireguard_identity_unavailable': 'WireGuard గుర్తింపు అందుబాటులో లేదు',
      'vpn_host_destroyed': 'Android VPN హోస్ట్ ఆగిపోయింది',
      'vpn_host_unavailable': 'Android VPN హోస్ట్ అందుబాటులో లేదు',
      'vpn_permission_required': 'VPN అనుమతి అవసరం',
      'vpn_permission_denied': 'VPN అనుమతి తిరస్కరించబడింది',
      'vpn_permission_request_failed': 'అనుమతిని అభ్యర్థించడం సాధ్యం కాలేదు',
      'wireguard_foreground_service_unavailable':
          'WireGuard సేవ అందుబాటులో లేదు',
      'wireguard_identity_invalid': 'చెల్లని స్థానిక WireGuard కీ',
      'wireguard_identity_in_use': 'WireGuard గుర్తింపు ఇప్పటికే ఉపయోగంలో ఉంది',
      'wireguard_configuration_invalid': 'చెల్లని WireGuard కాన్ఫిగరేషన్',
      'wireguard_operation_pending': 'WireGuard ఆపరేషన్ ఇంకా యాక్టివ్‌గా ఉంది',
      'wireguard_start_failed': 'WireGuard ప్రారంభం తిరస్కరించబడింది',
      'wireguard_stop_timeout': 'WireGuard ఆపివేత నిర్ధారణ కాలేదు',
      'wireguard_handshake_timeout': 'WireGuard స్పందించలేదు',
      'openvpn_connection_timeout': 'OpenVPN స్పందించలేదు',
      'openvpn_core_unavailable': 'OpenVPN ఇంజిన్ అందుబాటులో లేదు',
      'openvpn_operation_pending': 'OpenVPN సెషన్ ఇంకా యాక్టివ్‌గా ఉంది',
      'openvpn_stop_timeout': 'OpenVPN ఆపివేత నిర్ధారణ కాలేదు',
      'openvpn_profile_unavailable': 'స్థానిక OpenVPN ప్రొఫైల్ లేదు',
      'openvpn_native_failed': 'నేటివ్ OpenVPN కాల్‌కు అంతరాయం కలిగింది',
      'openvpn_key_generation_failed':
          'OpenVPN P-256 కీని సృష్టించడం సాధ్యం కాలేదు',
      'openvpn_csr_generation_failed': 'OpenVPN CSRను సృష్టించడం సాధ్యం కాలేదు',
      'openvpn_identity_store_failed': 'OpenVPN గుర్తింపు సేవ్ కాలేదు',
      'openvpn_identity_clear_failed': 'OpenVPN తొలగింపు అసంపూర్ణంగా ఉంది',
      'openvpn_identity_in_use': 'OpenVPN గుర్తింపు ఇంకా ఉపయోగంలో ఉంది',
      'openvpn_tls_verification_required': 'OpenVPN TLS ధ్రువీకరణ లేదు',
      'openvpn_cipher_invalid': 'చెల్లని OpenVPN సైఫర్',
      'openvpn_profile_rejected': 'OpenVPN ప్రొఫైల్ తిరస్కరించబడింది',
      'openvpn_identity_inconsistent': 'సరిపోలని OpenVPN గుర్తింపు',
      'tls_handshake_failed': 'OpenVPN నెగోషియేషన్ తిరస్కరించబడింది',
      'tls_alert_unknown_ca': 'OpenVPN క్లయింట్ సర్టిఫికెట్ గుర్తించబడలేదు',
      'tls_alert_bad_certificate':
          'OpenVPN క్లయింట్ సర్టిఫికెట్ తిరస్కరించబడింది',
      'tls_alert_unsupported_certificate': 'మద్దతు లేని OpenVPN సర్టిఫికెట్',
      'tls_client_certificate_required': 'OpenVPN క్లయింట్ సర్టిఫికెట్ అవసరం',
      'tls_alert_misc': 'OpenVPN TLS హెచ్చరిక',
      'tls_signature_algorithm_rejected': 'మద్దతు లేని OpenVPN సంతకం',
      'tls_handshake_rejected': 'OpenVPN TLS నెగోషియేషన్ తిరస్కరించబడింది',
      'tls_version_rejected': 'అనుకూలంగా లేని OpenVPN TLS వెర్షన్',
      'tls_certificate_expired': 'TLS సర్టిఫికెట్ గడువు ముగిసింది',
      'tls_certificate_revoked': 'TLS సర్టిఫికెట్ ఉపసంహరించబడింది',
      'transport_failed': 'OpenVPN సర్వర్‌ను చేరుకోలేము',
      'tun_configuration_rejected':
          'OpenVPN ఇంటర్‌ఫేస్‌ను సృష్టించడం సాధ్యం కాలేదు',
      'tun_setup_failed': 'OpenVPN TUN సెటప్ విఫలమైంది',
      'tun_interface_create_failed': 'OpenVPN ఇంటర్‌ఫేస్ సృష్టి విఫలమైంది',
      'tun_interface_disabled': 'OpenVPN ఇంటర్‌ఫేస్ నిలిపివేయబడింది',
      'tun_halted': 'OpenVPN ఇంటర్‌ఫేస్‌కు అంతరాయం కలిగింది',
      'tun_already_established': 'OpenVPN ఇంటర్‌ఫేస్ ఇప్పటికే తెరిచి ఉంది',
      'tun_addresses_missing': 'OpenVPN చిరునామా లేదు',
      'tun_routes_missing': 'OpenVPN రూట్‌లు లేవు',
      'tun_dns_missing': 'OpenVPN DNS లేదు',
      'tun_permission_revoked': 'VPN అనుమతి ఉపసంహరించబడింది',
      'tun_establish_returned_null': 'Android VPN ఇంటర్‌ఫేస్‌ను తిరస్కరించింది',
      'openvpn_service_start_failed': 'OpenVPN సేవ అందుబాటులో లేదు',
      'openvpn_operation_timeout': 'OpenVPN కాల్ సమయం ముగిసింది',
      'openvpn_start_failed': 'OpenVPN ప్రారంభం తిరస్కరించబడింది',
      'openvpn_connection_failed': 'OpenVPN కనెక్షన్‌కు అంతరాయం కలిగింది',
      'openvpn_core_status_error': 'OpenVPN కోర్ లోపంతో ముగిసింది',
      'openvpn_stopped_before_connected':
          'కనెక్ట్ కావడానికి ముందే OpenVPN ఆగిపోయింది',
      'openvpn_auth_failed': 'OpenVPN ప్రామాణీకరణ తిరస్కరించబడింది',
      'openvpn_client_setup_failed': 'OpenVPN క్లయింట్ సెటప్ విఫలమైంది',
      'openvpn_client_halted': 'OpenVPN క్లయింట్‌కు అంతరాయం కలిగింది',
      'openvpn_client_restart': 'OpenVPN పునఃప్రారంభం అభ్యర్థించబడింది',
      'openvpn_inactive_timeout': 'OpenVPN చాలా సేపు యాక్టివ్‌గా లేదు',
      'openvpn_session_expired': 'OpenVPN సెషన్ గడువు ముగిసింది',
      'openvpn_credentials_required': 'మద్దతు లేని OpenVPN ప్రామాణీకరణ',
      'openvpn_proxy_failed': 'OpenVPN మధ్యవర్తి ట్రాన్స్‌పోర్ట్ విఫలమైంది',
      'openvpn_compression_failed': 'OpenVPN కంప్రెషన్ తిరస్కరించబడింది',
      'openvpn_ntlm_crypto_unavailable':
          'OpenVPN NTLM ఎన్‌క్రిప్షన్ అందుబాటులో లేదు',
      'openvpn_feature_unsupported': 'మద్దతు లేని OpenVPN ఫీచర్',
      'network_unavailable': 'ఇంటర్నెట్ కనెక్షన్ అందుబాటులో లేదు',
      'network_lost': 'నెట్‌వర్క్ అందుబాటులో లేదు',
      'certificate_validation_failed': 'సర్వర్ సర్టిఫికెట్ తిరస్కరించబడింది',
      'openvpn_certificate_expired': 'OpenVPN సర్టిఫికెట్ గడువు ముగిసింది',
      'tunnel_active_for_another_account':
          'మరో ఖాతా టన్నెల్ ఇంకా యాక్టివ్‌గా ఉంది',
      'tunnel_already_active': 'నేటివ్ టన్నెల్ ఇప్పటికే యాక్టివ్‌గా ఉంది',
      'tunnel_stop_timeout': '$protocol ఆపివేత నిర్ధారణ కాలేదు',
      'tunnel_disconnected': '$protocolకు అంతరాయం కలిగింది',
      'native_bridge_unavailable': 'Android బ్రిడ్జ్ అందుబాటులో లేదు',
      'native_operation_failed': 'Android ఆపరేషన్‌కు అంతరాయం కలిగింది',
      'invalid_arguments': 'అసంపూర్ణ VPN పారామితులు',
      'invalid_account_id': 'చెల్లని VPN ఖాతా',
      'invalid_device_id': 'చెల్లని పరికర ఐడెంటిఫైయర్',
      'storage_key_not_allowed': 'నిల్వ కీ తిరస్కరించబడింది',
      'secure_storage_read_failed': 'సురక్షిత నిల్వ నుండి చదవడం విఫలమైంది',
      'secure_storage_write_failed': 'సురక్షిత నిల్వలో రాయడం విఫలమైంది',
      'key_generation_failed': 'WireGuard కీని సృష్టించడం సాధ్యం కాలేదు',
      'csr_generation_failed': 'OpenVPN CSRను సృష్టించడం సాధ్యం కాలేదు',
      'openvpn_recovery_exhausted': 'OpenVPN రికవరీ ఇప్పటికే ఉపయోగించబడింది',
      'openvpn_recovery_failed': 'OpenVPN రికవరీ విఫలమైంది',
      'openvpn_renewal_required': 'OpenVPN సర్టిఫికెట్ పునరుద్ధరణ అవసరం',
      'other': 'వర్గీకరించని నేటివ్ VPN లోపం',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'కొనసాగించడానికి వీలైన VPN సెషన్‌ను Android కనుగొనలేకపోయింది. యాప్‌లో కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_corrupt':
          'సేవ్ చేసిన VPN కొనసాగింపు డేటా చెల్లనిది, కాబట్టి దీనిని ఉపయోగించరు. కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_session_invalid':
          'సేవ్ చేసిన సెషన్ ఇకపై VPNను కొనసాగించలేదు. యాప్‌లో మళ్లీ సైన్ ఇన్ చేయండి.',
      'system_vpn_resume_identity_changed':
          'స్థానిక VPN గుర్తింపు మారింది. కొనసాగింపు ఆపివేయబడింది; కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_identity_invalid':
          'కొనసాగింపు కోసం గుర్తింపు చెల్లనిది. కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_storage_failed':
          'ఎన్‌క్రిప్ట్ చేసిన కొనసాగింపు డేటాను Android చదవలేకపోయింది లేదా అప్‌డేట్ చేయలేకపోయింది. కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_network_timeout':
          'VPNను కొనసాగించడానికి నిర్ణీత సమయంలో నెట్‌వర్క్‌ను Android కనుగొనలేదు. నెట్‌వర్క్ అందుబాటులోకి వచ్చినప్పుడు మళ్లీ ప్రయత్నించండి.',
      'system_vpn_resume_blocked':
          'VPN కొనసాగింపు నిరోధించబడింది. Android సెట్టింగ్‌లను తనిఖీ చేసి, ఆపై కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_failed':
          'Android VPN కొనసాగింపు విఫలమైంది. యాప్‌లో కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'system_vpn_resume_error_invalid':
          'Android ఉపయోగించలేని కొనసాగింపు లోపాన్ని తిరిగి ఇచ్చింది. కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'wireguard_identity_store_failed':
          'ఈ ఖాతా యొక్క ఎన్‌క్రిప్ట్ చేసిన WireGuard గుర్తింపును Android సేవ్ చేయలేకపోయింది.',
      'wireguard_identity_unavailable':
          'ఈ కనెక్షన్ కోసం ఉపయోగించదగిన WireGuard గుర్తింపు అందుబాటులో లేదు.',
      'vpn_host_destroyed':
          'VPNను నడిపే Android కాంపోనెంట్ ఆగిపోయింది. కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'vpn_host_unavailable':
          'VPNను నడిపే కాంపోనెంట్‌ను Android సృష్టించలేకపోయింది. VPN సెట్టింగ్‌లను తనిఖీ చేసిన తర్వాత మళ్లీ ప్రయత్నించండి.',
      'openvpn_renewal_required':
          'కనెక్ట్ చేయడానికి ముందు ఈ సర్టిఫికెట్‌కు యాప్‌లో ఒక చర్య అవసరం.',
      'openvpn_recovery_failed':
          'స్వయంచాలక రికవరీ విఫలమైంది. యాప్‌లో కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'openvpn_recovery_exhausted':
          'స్వయంచాలక రికవరీ ఇప్పటికే ఉపయోగించబడింది. యాప్‌లో కొత్త కనెక్షన్‌ను ప్రారంభించండి.',
      'vpn_permission_required':
          'టన్నెల్‌ను ప్రారంభించడానికి ముందు Android కొత్త VPN అనుమతిని కోరుతుంది.',
      'vpn_permission_denied':
          'కొనసాగించడానికి Android అభ్యర్థనలో FuzeVPNను అనుమతించండి.',
      'vpn_permission_request_failed':
          'VPN అనుమతి స్క్రీన్‌ను Android తెరవలేకపోయింది.',
      'wireguard_foreground_service_unavailable':
          'WireGuard సేవను ఫోర్‌గ్రౌండ్‌లో Android ఉంచలేకపోయింది.',
      'wireguard_identity_invalid':
          'ఈ ఖాతా యొక్క ఎన్‌క్రిప్ట్ చేసిన WireGuard కీ చదవలేనిది లేదా చెల్లనిది.',
      'wireguard_identity_in_use':
          'ఈ ఖాతా WireGuard కీని మరొక ఆపరేషన్ ఇంకా ఉపయోగిస్తోంది.',
      'wireguard_configuration_invalid':
          'అందుకున్న WireGuard చిరునామా, DNS, సర్వర్ కీ లేదా రూట్‌లు చెల్లనివి.',
      'wireguard_operation_pending':
          'మునుపటి WireGuard ఆపరేషన్ ఇంకా దాని నేటివ్ సేవను విడుదల చేయలేదు.',
      'wireguard_start_failed':
          'కాన్ఫిగరేషన్‌ను యాక్టివేట్ చేయడాన్ని WireGuard ఇంజిన్ తిరస్కరించింది.',
      'wireguard_stop_timeout':
          'నిర్ణీత సమయంలోగా VPN ఇంటర్‌ఫేస్ విడుదలను WireGuard సేవ నిర్ధారించలేదు.',
      'wireguard_handshake_timeout':
          'నిర్ణీత సమయంలోగా సర్వర్‌తో హ్యాండ్‌షేక్‌ను టన్నెల్ నిర్ధారించలేదు.',
      'openvpn_connection_timeout':
          'నిర్ణీత సమయంలోగా సర్వర్‌కు కనెక్షన్‌ను OpenVPN నిర్ధారించలేదు.',
      'openvpn_core_unavailable':
          'ఈ యాప్ వెర్షన్‌లో ఉపయోగించదగిన OpenVPN ఇంజిన్ లేదు.',
      'openvpn_operation_pending':
          'నేటివ్ ఇంజిన్ ఇంకా మునుపటి OpenVPN సెషన్‌ను కలిగి ఉంది; రెండవ సెషన్‌ను సృష్టించడానికి అది నిరాకరిస్తోంది.',
      'openvpn_stop_timeout':
          'నిర్ణీత సమయంలోగా దాని నేటివ్ సెషన్ ఆగి, తొలగించబడిందని OpenVPN కోర్ నిర్ధారించలేదు.',
      'openvpn_profile_unavailable':
          'ఈ కనెక్షన్ కోసం ధ్రువీకరించిన OpenVPN ప్రొఫైల్‌ను చదవడం సాధ్యం కాదు.',
      'openvpn_native_failed':
          'యాప్ లోపం వల్ల OpenVPNకు అంతరాయం కలిగింది. మళ్లీ కనెక్ట్ చేయడానికి ప్రయత్నించండి. సమస్య కొనసాగితే, డయాగ్నస్టిక్స్‌ను ప్రారంభించండి.',
      'openvpn_key_generation_failed':
          'ఎగుమతి చేయలేని P-256 ప్రైవేట్ కీని Android Keystore సృష్టించలేకపోయింది లేదా చదవలేకపోయింది.',
      'openvpn_csr_generation_failed':
          'Android Keystore కీ OpenVPN సర్టిఫికెట్ అభ్యర్థనపై సంతకం చేయలేకపోయింది.',
      'openvpn_identity_store_failed':
          'OpenVPN సర్టిఫికెట్ లేదా ప్రొఫైల్‌ను ఎన్‌క్రిప్ట్ చేసిన నిల్వలో సేవ్ చేయడం సాధ్యం కాలేదు.',
      'openvpn_identity_clear_failed':
          'Android ఈ ఖాతా కోసం స్థానిక OpenVPN గుర్తింపును పూర్తిగా తొలగించలేకపోయింది.',
      'openvpn_identity_in_use':
          'ఈ పరికరం కీ లేదా సర్టిఫికెట్‌ను ఇంకా ఒక నేటివ్ OpenVPN సెషన్ ఉపయోగిస్తోంది.',
      'openvpn_tls_verification_required':
          'సర్వర్ సర్టిఫికెట్ ధ్రువీకరణను ప్రొఫైల్ స్పష్టంగా కోరడం లేదు.',
      'openvpn_cipher_invalid':
          'అనుమతించిన జాబితాలో లేని ఎన్‌క్రిప్షన్ అల్గారిథమ్‌ను సర్వర్ అందించింది.',
      'openvpn_profile_rejected':
          'సర్వర్ నుండి అందుకున్న ప్రొఫైల్ అనుకూలంగా లేదు. ఈ పరికరాన్ని మళ్లీ సృష్టించి, ఆపై ప్రయత్నించండి.',
      'openvpn_identity_inconsistent':
          'ఈ ఫోన్ యొక్క సురక్షిత గుర్తింపుతో సర్టిఫికెట్ సరిపోలడం లేదు. స్థానిక ప్రొఫైల్ ఏదీ భర్తీ చేయబడలేదు.',
      'tls_handshake_failed':
          'TLS నెగోషియేషన్‌ను సర్వర్ తిరస్కరించింది. సమస్య కొనసాగితే ప్రొఫైల్‌ను మళ్లీ సృష్టించండి.',
      'tls_alert_unknown_ca':
          'ఈ పరికర సర్టిఫికెట్ యొక్క అథారిటీని సర్వర్ గుర్తించలేదు. OpenVPN సర్వర్‌ను తనిఖీ చేయాలి.',
      'tls_alert_bad_certificate':
          'ఈ పరికర సర్టిఫికెట్‌ను సర్వర్ తిరస్కరించింది. ప్రయత్నించే ముందు పరికరాన్ని మళ్లీ సృష్టించండి.',
      'tls_alert_unsupported_certificate':
          'Android ఉపయోగించే సురక్షిత సర్టిఫికెట్ రకానికి సర్వర్ మద్దతు ఇవ్వదు.',
      'tls_client_certificate_required':
          'సర్వర్‌కు క్లయింట్ సర్టిఫికెట్ అవసరం, కానీ OpenVPN కోర్ ఒకదాన్ని సమర్పించలేకపోయింది.',
      'tls_alert_misc':
          'సర్టిఫికెట్, వెర్షన్ వర్గాల వెలుపల ఉన్న TLS హెచ్చరికను సర్వర్ తిరిగి పంపింది.',
      'tls_signature_algorithm_rejected':
          'Android Keystore కీ యొక్క ECDSA P-256 అల్గారిథమ్‌ను సర్వర్ తిరస్కరించింది.',
      'tls_handshake_rejected':
          'కనెక్షన్‌కు ముందే TLS నెగోషియేషన్‌కు సర్వర్ అంతరాయం కలిగించింది.',
      'tls_version_rejected':
          'క్లయింట్, సర్వర్ రెండింటికీ ఉమ్మడి TLS వెర్షన్ కనుగొనబడలేదు.',
      'tls_certificate_expired':
          'కనెక్షన్ సమయంలో సమర్పించిన సర్టిఫికెట్ గడువు ముగిసింది.',
      'tls_certificate_revoked':
          'కనెక్షన్ సమయంలో సమర్పించిన సర్టిఫికెట్ ఉపసంహరించబడింది.',
      'transport_failed':
          'ప్రస్తుత నెట్‌వర్క్‌లో OpenVPN సర్వర్ స్పందించడం లేదు. కొద్దిసేపటి తర్వాత మళ్లీ ప్రయత్నించండి.',
      'tun_configuration_rejected':
          'OpenVPN అభ్యర్థించిన నెట్‌వర్క్ కాన్ఫిగరేషన్‌ను Android తిరస్కరించింది.',
      'tun_setup_failed':
          'Android ఇంటర్‌ఫేస్‌ను సృష్టించడానికి ముందే నెట్‌వర్క్ ప్లాన్‌ను OpenVPN కోర్ తిరస్కరించింది.',
      'tun_interface_create_failed':
          'Android VpnService నుండి TUN ఇంటర్‌ఫేస్‌ను OpenVPN కోర్ పొందలేకపోయింది.',
      'tun_interface_disabled':
          'కనెక్షన్ సమయంలో TUN ఇంటర్‌ఫేస్‌ను Android లేదా OpenVPN కోర్ నిలిపివేశాయి.',
      'tun_halted': 'TUN ఇంటర్‌ఫేస్‌ను ఆపమని OpenVPN కోర్ అభ్యర్థన అందుకుంది.',
      'tun_already_established':
          'ఒకే కనెక్షన్‌లో రెండవ ఇంటర్‌ఫేస్ కావాలని OpenVPN అభ్యర్థించింది. భద్రత కోసం టన్నెల్ ఆపివేయబడింది.',
      'tun_addresses_missing':
          'సర్వర్ ఉపయోగించదగిన టన్నెల్ చిరునామాను అందించలేదు.',
      'tun_routes_missing': 'సర్వర్ ఉపయోగించదగిన టన్నెల్ రూట్‌లను అందించలేదు.',
      'tun_dns_missing':
          'సర్వర్ ఉపయోగించదగిన DNS సర్వర్ చిరునామాను అందించలేదు.',
      'tun_permission_revoked':
          'కనెక్షన్ సమయంలో VPN అనుమతిని Android ఉపసంహరించింది.',
      'tun_establish_returned_null':
          'సాధారణంగా మరో VPN ఇంకా యాక్టివ్‌గా ఉండటం వల్ల Android ఇంటర్‌ఫేస్‌ను సృష్టించలేదు.',
      'openvpn_service_start_failed':
          'OpenVPN ఫోర్‌గ్రౌండ్ సేవను Android ప్రారంభించలేకపోయింది.',
      'openvpn_operation_timeout':
          'OpenVPN కోర్‌కు చేసిన JNI కాల్ గరిష్ట వ్యవధిని మించిపోయింది.',
      'openvpn_start_failed':
          'Android సేవ సిద్ధంగా ఉంది, కానీ ప్రొఫైల్‌ను ప్రారంభించడాన్ని OpenVPN కోర్ అంగీకరించలేదు.',
      'openvpn_connection_failed':
          'CONNECTED ఈవెంట్‌ను పంపే ముందే OpenVPN కోర్ ఆగిపోయింది.',
      'openvpn_core_status_error':
          'నేటివ్ OpenVPN లూప్ లోపంతో ముగిసింది; మరింత నిర్దిష్టమైన ముగింపు ఈవెంట్ లేదు.',
      'openvpn_stopped_before_connected':
          'స్పష్టమైన కోర్ లోపం లేకుండా, CONNECTED కంటే ముందే నేటివ్ OpenVPN లూప్ ఆగిపోయింది.',
      'openvpn_auth_failed':
          'ప్రొఫైల్ ప్రామాణీకరణను OpenVPN సర్వర్ తిరస్కరించింది.',
      'openvpn_client_setup_failed':
          'OpenVPN కోర్ నెట్‌వర్క్ కనెక్షన్‌కు ముందు క్లయింట్‌ను ప్రారంభించలేకపోయింది.',
      'openvpn_client_halted':
          'క్లయింట్ ఆపివేత అభ్యర్థనను OpenVPN కోర్ అందుకుంది.',
      'openvpn_client_restart':
          'దాని ట్రాన్స్‌పోర్ట్ సెషన్‌ను పునఃప్రారంభించమని OpenVPN కోర్ అభ్యర్థించింది.',
      'openvpn_inactive_timeout':
          'నిష్క్రియ సమయ పరిమితి తర్వాత OpenVPN కోర్ సెషన్‌ను మూసివేసింది.',
      'openvpn_session_expired':
          'OpenVPN సెషన్ గడువు ముగిసిందని సర్వర్ తెలియజేసింది.',
      'openvpn_credentials_required':
          'ఈ సర్టిఫికెట్ ప్రొఫైల్‌లో భాగం కాని ఇంటరాక్టివ్ ఆధారాలను సర్వర్ లేదా ప్రాక్సీ అడుగుతోంది.',
      'openvpn_proxy_failed':
          'కాన్ఫిగర్ చేసిన ప్రాక్సీ లేదా రిలే విఫలమైందని OpenVPN కోర్ తెలియజేసింది.',
      'openvpn_compression_failed':
          'ప్రొఫైల్ లేదా సర్వర్ ప్రకటించిన కంప్రెషన్ మోడ్‌ను OpenVPN కోర్ తిరస్కరించింది.',
      'openvpn_ntlm_crypto_unavailable':
          'ఈ వెర్షన్‌లో అందుబాటులో లేని NTLM ఎన్‌క్రిప్షన్‌ను ప్రొఫైల్ అభ్యర్థిస్తోంది.',
      'openvpn_feature_unsupported':
          'ఈ Android క్లయింట్‌లో లేని ఫీచర్‌ను ప్రొఫైల్ లేదా సర్వర్ కోరుతోంది.',
      'network_unavailable': 'ఉపయోగించదగిన భౌతిక నెట్‌వర్క్ అందుబాటులో లేదు.',
      'network_lost': 'నెట్‌వర్క్ కోల్పోయిన తర్వాత టన్నెల్ ఆపివేయబడింది.',
      'certificate_validation_failed':
          'OpenVPN సర్వర్ గుర్తింపును ధ్రువీకరించడం సాధ్యం కాలేదు.',
      'openvpn_certificate_expired':
          'మళ్లీ కనెక్ట్ చేయడానికి ముందు OpenVPN ప్రొఫైల్‌ను పునరుద్ధరించండి.',
      'tunnel_active_for_another_account':
          'ఈ కనెక్షన్‌కు ముందు మరో ఖాతాకు చెందిన టన్నెల్ ఆగాలి.',
      'tunnel_already_active':
          'మునుపటి VPN సెషన్ ఇంకా ఇంటర్‌ఫేస్‌ను ఉపయోగిస్తోందని Android తెలియజేస్తోంది.',
      'tunnel_stop_timeout':
          'నిర్ణీత సమయంలోగా VPN ఇంటర్‌ఫేస్ విడుదలను $protocol ఇంజిన్ నిర్ధారించలేదు.',
      'tunnel_disconnected':
          'ప్రారంభమైన తర్వాత టన్నెల్ అనుకోకుండా ముగిసిందని నేటివ్ ఇంజిన్ తెలియజేసింది.',
      'native_bridge_unavailable':
          'యాప్ Android VPN సేవను యాక్సెస్ చేయలేదు. యాప్‌ను మూసి, మళ్లీ తెరిచి, ఆపై ప్రయత్నించండి.',
      'native_operation_failed':
          'యాప్ లోపం వల్ల VPN ఆపరేషన్‌కు అంతరాయం కలిగింది. మళ్లీ ప్రయత్నించండి. సమస్య కొనసాగితే, డయాగ్నస్టిక్స్‌ను ప్రారంభించండి.',
      'invalid_arguments':
          'ఈ VPN ఆపరేషన్‌కు అవసరమైన సమాచారం అసంపూర్ణంగా ఉంది. మళ్లీ ప్రయత్నించండి. సమస్య కొనసాగితే, డయాగ్నస్టిక్స్‌ను ప్రారంభించండి.',
      'invalid_account_id':
          'నేటివ్ ఆపరేషన్ చెల్లుబాటు అయ్యే ఖాతా ఐడెంటిఫైయర్‌తో అనుబంధించబడలేదు.',
      'invalid_device_id':
          'నేటివ్ ఇంజిన్‌కు పంపిన పరికర ఐడెంటిఫైయర్ లేదు లేదా చెల్లనిది.',
      'storage_key_not_allowed':
          'అనుమతించిన నిల్వ జాబితాకు వెలుపల ఉన్న కీని Android బ్రిడ్జ్ నిరోధించింది.',
      'secure_storage_read_failed':
          'ఈ ఖాతా స్థానిక డేటాను Android Keystore డీక్రిప్ట్ చేయలేకపోయింది.',
      'secure_storage_write_failed':
          'స్థానిక డేటాను Android Keystore ఎన్‌క్రిప్ట్ చేయలేకపోయింది లేదా సేవ్ చేయలేకపోయింది.',
      'key_generation_failed':
          'Android సురక్షిత నిల్వలో WireGuard కీని సృష్టించలేకపోయింది లేదా చదవలేకపోయింది.',
      'csr_generation_failed':
          'Android Keystore OpenVPN P-256 CSRను సృష్టించలేకపోయింది లేదా దానిపై సంతకం చేయలేకపోయింది.',
      'other':
          'డాక్యుమెంట్ చేయని నేటివ్ బ్రాంచ్ విఫలమైంది. దిగువ చూపిన డయాగ్నస్టిక్ కోడ్‌ను సపోర్ట్ బృందానికి పంపండి.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'అనుమతి అభ్యర్థన ఇప్పటికే తెరిచి ఉంది';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN అనుమతి అభ్యర్థన ఇప్పటికే కనిపిస్తోంది. మళ్లీ ప్రయత్నించే ముందు దాన్ని పూర్తి చేయండి.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'VPN అనుమతి అభ్యర్థనకు అంతరాయం కలిగింది';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'యాప్‌కు స్పందన అందకముందే VPN అనుమతి స్క్రీన్ మూసుకుపోయింది.';

  @override
  String get notice_openvpnProofMissing_title =>
      'OpenVPN కనెక్షన్ నిర్ధారణ కాలేదు';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN కనెక్షన్‌ను నిర్ధారించలేకపోయాము. భద్రత కోసం దాన్ని ఆపివేశాము. మళ్లీ ప్రయత్నించండి.';

  @override
  String get openvpnCleanup_title => 'OpenVPN ప్రొఫైల్ రద్దు చేయబడింది';

  @override
  String get openvpnCleanup_working =>
      'రద్దు చేయబడిన OpenVPN ప్రొఫైల్‌ను ఆపి, తీసివేస్తోంది…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN ఆగిపోయినట్లు నిర్ధారించలేకపోయాము. కొత్త ప్రొఫైల్ సృష్టించే ముందు మళ్లీ ప్రయత్నించండి.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'రద్దు చేయబడిన OpenVPN ప్రొఫైల్‌ను పూర్తిగా తీసివేయలేకపోయాము. శుభ్రం చేయడాన్ని మళ్లీ ప్రయత్నించండి.';

  @override
  String get openvpnCleanup_complete =>
      'రద్దు చేయబడిన OpenVPN ప్రొఫైల్ తీసివేయబడింది. కొత్తది సృష్టించడానికి ‘కనెక్ట్ చేయండి’ నొక్కండి.';

  @override
  String get network_title => 'నెట్‌వర్క్ కాన్ఫిగరేషన్';

  @override
  String get network_ipv4Fallback =>
      'IPv6 తాత్కాలికంగా అందుబాటులో లేదు. IPv4తో సిద్ధం చేయడం కొనసాగుతోంది.';

  @override
  String get network_rejectedTitle =>
      'నెట్‌వర్క్ కాన్ఫిగరేషన్ తిరస్కరించబడింది';

  @override
  String get network_rejectedMessage =>
      'టన్నెల్ కాన్ఫిగరేషన్ అసంపూర్ణంగా ఉంది లేదా అనుమతించబడిన చిరునామాలతో సరిపోలడం లేదు. యాప్ నుండి మళ్లీ ప్రయత్నించండి.';

  @override
  String get network_unreadableTitle =>
      'స్థానిక కాన్ఫిగరేషన్ చదవడం సాధ్యం కాదు';

  @override
  String get network_unreadableMessage =>
      'సేవ్ చేసిన OpenVPN నెట్‌వర్క్ కాన్ఫిగరేషన్‌ను ఉపయోగించలేము. దాన్ని అప్‌డేట్ చేయడానికి యాప్ నుండి మళ్లీ కనెక్ట్ చేయండి.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'నెట్‌వర్క్ రక్షణ';

  @override
  String get protection_subtitle =>
      'VPN డిస్‌కనెక్ట్ అయితే నేరుగా ఇంటర్నెట్ యాక్సెస్‌ను బ్లాక్ చేయండి.';

  @override
  String get protection_active => 'సిస్టమ్ రక్షణ యాక్టివ్‌గా ఉంది';

  @override
  String get protection_alwaysOnOnly =>
      'ఎల్లప్పుడూ ఆన్‌లో ఉండే VPN ప్రారంభించబడింది; VPN వెలుపల బ్లాక్ చేయడాన్ని ఆన్ చేయండి';

  @override
  String get protection_inactive => 'సిస్టమ్ రక్షణ యాక్టివ్‌గా లేదు';

  @override
  String get protection_unknown => 'సిస్టమ్ రక్షణను తనిఖీ చేయండి';

  @override
  String get protection_openSettings => 'Android సెట్టింగ్‌లను తెరవండి';

  @override
  String get protection_dialogTitle => 'నెట్‌వర్క్ రక్షణను సెటప్ చేయండి';

  @override
  String get protection_dialogMessage =>
      'ఎల్లప్పుడూ ఆన్‌లో ఉండే VPN, VPN వెలుపల కనెక్షన్‌ల బ్లాకింగ్‌ను Android నిర్వహిస్తుంది. FuzeVPN ఎంచుకోబడిందో లేదో తనిఖీ చేసి, సిస్టమ్ సెట్టింగ్‌లలో బ్లాకింగ్‌ను ఆన్ చేయండి.';

  @override
  String get protection_dialogOpen => 'సెట్టింగ్‌లను తెరవండి';

  @override
  String get session_systemProtectionNote =>
      'VPN వెలుపల ట్రాఫిక్‌ను Android ఇంకా బ్లాక్ చేస్తుంటే, ఈ రక్షణను తనిఖీ చేయడానికి లేదా మార్చడానికి సిస్టమ్ సెట్టింగ్‌లను తెరవండి.';

  @override
  String get diagnostics_title => 'డయాగ్నస్టిక్స్';

  @override
  String get diagnostics_settingsTitle => 'యాప్ డయాగ్నస్టిక్స్';

  @override
  String get diagnostics_automaticTitle => 'ముఖ్యమైన లోపాలను పంపండి';

  @override
  String get diagnostics_automaticDescription =>
      'ముఖ్యమైన లోపం ఏర్పడినప్పుడు ఒక చిన్న సాంకేతిక నివేదికను పంచుకోండి.';

  @override
  String get diagnostics_privacy =>
      'పంపిన నివేదికలు సైన్ ఇన్ చేసిన ఖాతాకు లింక్ చేయబడతాయి మరియు 30 రోజుల పాటు ఉంచబడతాయి. వాటిలో బ్రౌజింగ్ చరిత్ర, పాస్‌వర్డ్‌లు లేదా VPN కీలు ఉండవు.';

  @override
  String get diagnostics_manualOpen => 'డయాగ్నస్టిక్స్‌ను ప్రారంభించండి';

  @override
  String get diagnostics_localDescription =>
      'యాప్ మరియు VPN స్థితి నివేదికను సృష్టించండి. మీ కనెక్షన్ మారదు.';

  @override
  String get diagnostics_sendReport => 'నివేదికను పంపండి';

  @override
  String get diagnostics_sendHint =>
      'నివేదికను ఈ పరికరంలోనే ఉంచాలంటే ఈ బాక్స్‌ను టిక్ చేయకుండా ఉంచండి.';

  @override
  String get diagnostics_signedOut =>
      'నివేదికను పంపడానికి మీ ఖాతాలో సైన్ ఇన్ చేయండి.';

  @override
  String get diagnostics_localLifetime =>
      'యాప్‌ను మూసిన తర్వాత కూడా ఈ నివేదికను ఉంచడానికి దాన్ని మీ ఫోన్‌లో సేవ్ చేయండి.';

  @override
  String get diagnostics_run => 'డయాగ్నస్టిక్స్‌ను ప్రారంభించండి';

  @override
  String get diagnostics_rerun => 'డయాగ్నస్టిక్స్‌ను మళ్లీ ప్రారంభించండి';

  @override
  String get diagnostics_running => 'తనిఖీ చేస్తోంది…';

  @override
  String get diagnostics_sending => 'నివేదికను పంపుతోంది…';

  @override
  String get diagnostics_prepared => 'ఈ పరికరంలో నివేదిక సిద్ధంగా ఉంది';

  @override
  String get diagnostics_queued => 'నివేదిక పంపడానికి వేచి ఉంది';

  @override
  String get diagnostics_sent => 'నివేదిక అందింది';

  @override
  String get diagnostics_failed =>
      'పంపడం విఫలమైంది. మీ స్థానిక నివేదిక ఇంకా అందుబాటులో ఉంది.';

  @override
  String get diagnostics_preparationFailed =>
      'డయాగ్నస్టిక్ నివేదికను సిద్ధం చేయలేకపోయాము. మళ్లీ ప్రయత్నించండి.';

  @override
  String get diagnostics_authenticationRequired =>
      'నివేదికను పంపడానికి మళ్లీ సైన్ ఇన్ చేయండి.';

  @override
  String get diagnostics_retry => 'పంపడాన్ని మళ్లీ ప్రయత్నించండి';

  @override
  String get diagnostics_export => 'నివేదికను సేవ్ చేయండి';

  @override
  String get diagnostics_exportFailed =>
      'ఎగుమతి విఫలమైంది. స్థానిక నివేదిక నుండి మళ్లీ ప్రయత్నించండి.';

  @override
  String get diagnostics_preferenceFailed =>
      'ఈ సెట్టింగ్‌ను సేవ్ చేయలేకపోయాము. మళ్లీ ప్రయత్నించండి.';

  @override
  String diagnostics_receipt(Object id) {
    return 'సూచన: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$dateన అందింది';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date వరకు ఉంచబడుతుంది';
  }

  @override
  String get diagnostics_duplicate => 'ఈ నివేదిక ఇప్పటికే అందింది.';

  @override
  String get diagnostics_preview => 'నివేదిక ప్రివ్యూ';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count సాంకేతిక ఈవెంట్‌లు జత చేయబడ్డాయి',
      one: '1 సాంకేతిక ఈవెంట్ జత చేయబడింది',
      zero: 'సాంకేతిక ఈవెంట్‌లు ఏవీ జత చేయబడలేదు',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'సాంకేతిక వివరాలు';

  @override
  String get diagnostics_empty =>
      'ఇంకా డయాగ్నస్టిక్ నివేదిక ఏదీ సిద్ధం కాలేదు.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'టన్నెల్ స్థితి',
      'handshake': 'కనెక్షన్ నిర్ధారణ',
      'certificate': 'VPN సర్టిఫికెట్',
      'kill_switch': 'Android రక్షణ',
      'connectivity': 'అందుబాటులో ఉన్న నెట్‌వర్క్',
      'api_reachability': 'సేవ యాక్సెస్',
      'secure_storage': 'సురక్షిత నిల్వ',
      'other': 'స్థానిక తనిఖీ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'తనిఖీ చేయబడింది',
      'failed': 'శ్రద్ధ అవసరం',
      'skipped': 'పరీక్షించలేదు — యాక్టివ్ ప్రోబ్ లేదు',
      'unknown': 'సమాచారం అందుబాటులో లేదు',
      'other': 'సమాచారం అందుబాటులో లేదు',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPNకు స్వాగతం';

  @override
  String get connection_changeLocation => 'స్థానాన్ని మార్చండి';

  @override
  String get connection_details => 'కనెక్షన్ వివరాలు';

  @override
  String get locations_searchLabel => 'నగరం లేదా దేశం కోసం శోధించండి';

  @override
  String get locations_clearSearch => 'శోధనను క్లియర్ చేయండి';

  @override
  String get locations_filterAll => 'అన్నీ';

  @override
  String get locations_filterFavorites => 'ఇష్టమైనవి';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count స్థానాలు',
      one: '$count స్థానం',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'స్థానాలు ఏవీ కనుగొనబడలేదు';

  @override
  String get locations_noResultsHint => 'మరో నగరం లేదా దేశాన్ని ప్రయత్నించండి.';

  @override
  String get locations_noFavorites => 'మీ ఇష్టమైనవి, చేతికి అందేలా';

  @override
  String get locations_noFavoritesHint =>
      'ఇక్కడ సేవ్ చేయడానికి స్థానం పక్కన ఉన్న నక్షత్రాన్ని నొక్కండి.';

  @override
  String get locations_showAll => 'అన్ని స్థానాలను చూడండి';

  @override
  String locations_addFavorite(String name) {
    return '$nameను ఇష్టమైన వాటికి జోడించండి';
  }

  @override
  String locations_removeFavorite(String name) {
    return '$nameను ఇష్టమైన వాటి నుండి తీసివేయండి';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'ఇష్టమైనదాన్ని సేవ్ చేయలేకపోయాము. మళ్లీ ప్రయత్నించండి.';

  @override
  String get locations_emptyTitle => 'స్థానాలు ఏవీ అందుబాటులో లేవు';

  @override
  String get locations_emptyHint =>
      'మళ్లీ ప్రయత్నించడానికి జాబితాను రిఫ్రెష్ చేయండి.';

  @override
  String get devices_manage => 'నా పరికరాలను నిర్వహించండి';

  @override
  String get settings_personalization => 'మీ ఇష్టానుసారం మార్చుకోండి';

  @override
  String get settings_safety => 'రక్షణ';

  @override
  String get settings_help => 'సహాయం కావాలా?';

  @override
  String get settings_about => 'FuzeVPN గురించి';

  @override
  String get diagnostics_heading => 'కనెక్షన్ సమస్యను అర్థం చేసుకోండి';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'అందుబాటులో ఉంది',
      'pending': 'సిద్ధమవుతోంది',
      'revoked': 'తీసివేయబడింది',
      'expired': 'గడువు ముగిసింది',
      'other': 'స్థితి అందుబాటులో లేదు',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'ప్రాధాన్యత సేవ్ కాలేదు';

  @override
  String get notice_preferenceSave_message =>
      'మీ ఎంపిక ప్రస్తుతానికి వర్తింపజేయబడింది, కానీ సేవ్ కాలేదు. యాప్‌ను మూసిన తర్వాత కూడా ఉంచడానికి మళ్లీ ప్రయత్నించండి.';

  @override
  String get connection_androidDisconnectHint =>
      'Android VPNను యాక్టివ్‌గా ఉంచితే, తెరుచుకునే సెట్టింగ్‌లలో ఎల్లప్పుడూ ఆన్‌లో ఉండే VPNను ఆఫ్ చేయండి.';

  @override
  String get protection_learnMore => 'Android రక్షణ గురించి తెలుసుకోండి';

  @override
  String get protection_guideWhy =>
      'VPN డిస్‌కనెక్ట్ అయితే, యాప్‌లు నేరుగా ఇంటర్నెట్‌ను ఉపయోగించకుండా ఈ రక్షణ నిరోధిస్తుంది. దీన్ని Androidలో కాన్ఫిగర్ చేస్తారు.';

  @override
  String get protection_guideAlwaysOnTitle => 'ఎల్లప్పుడూ ఆన్‌లో ఉండే VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android VPN సేవను నడుస్తూ ఉంచుతుంది, ఫోన్ రీస్టార్ట్ అయిన తర్వాత దాన్ని మళ్లీ ప్రారంభించగలదు.';

  @override
  String get protection_guideBlockTitle =>
      'VPN లేకుండా కనెక్షన్‌లను బ్లాక్ చేయండి';

  @override
  String get protection_guideBlock =>
      'కనెక్షన్‌కు అంతరాయం కలిగినప్పుడు కూడా, ట్రాఫిక్ VPNను దాటవేసి వెళ్లకుండా ఈ సెట్టింగ్ నిరోధిస్తుంది.';

  @override
  String get protection_guideWarning =>
      'ఈ బ్లాకింగ్ ఆన్‌లో ఉన్నప్పుడు, VPN కనెక్ట్ అయ్యే వరకు ఇంటర్నెట్ యాక్సెస్ ఆఫ్‌లోనే ఉంటుంది.';

  @override
  String get protection_guideStepsTitle => 'రక్షణను ఆన్ చేయండి';

  @override
  String get protection_guideStep1 =>
      'దిగువన ఉన్న బటన్‌తో Android VPN సెట్టింగ్‌లను తెరవండి.';

  @override
  String get protection_guideStep2 =>
      'FuzeVPN పక్కన ఉన్న గేర్ ఐకాన్‌తో ఎంపికలను తెరవండి.';

  @override
  String get protection_guideStep3 =>
      'అందుబాటులో ఉంటే, “ఎల్లప్పుడూ ఆన్‌లో ఉండే VPN”ను, ఆ తర్వాత “VPN లేకుండా కనెక్షన్‌లను బ్లాక్ చేయండి”ని ఆన్ చేయండి.';

  @override
  String get protection_guideManufacturers =>
      'పేర్లు ఫోన్‌ను బట్టి మారుతాయి. అవసరమైతే, సెట్టింగ్‌లలో VPN కోసం శోధించండి; ఇది తరచుగా నెట్‌వర్క్ & ఇంటర్నెట్ కింద ఉంటుంది.';

  @override
  String get protection_guideDisableTitle => 'ఈ రక్షణను ఆఫ్ చేయండి';

  @override
  String get protection_guideDisable =>
      'అదే సెట్టింగ్‌లలో, VPN లేకుండా ఇంటర్నెట్ యాక్సెస్ కోసం “VPN లేకుండా కనెక్షన్‌లను బ్లాక్ చేయండి”ని ఆఫ్ చేయండి. ఇకపై Android దాన్ని మళ్లీ ప్రారంభించకూడదనుకుంటే, “ఎల్లప్పుడూ ఆన్‌లో ఉండే VPN”ను కూడా ఆఫ్ చేయండి.';

  @override
  String get protection_guideManual =>
      'ఈ సెట్టింగ్‌లను Androidలో మీరే ఎంచుకుంటారు. FuzeVPN వాటిని మీ కోసం మార్చదు.';

  @override
  String get locations_changeTitle => 'స్థానాన్ని మార్చాలా?';

  @override
  String locations_changeActive(String name) {
    return 'VPN డిస్‌కనెక్ట్ అవుతుంది, ఆ తర్వాత $nameకు కనెక్ట్ కావడానికి ప్రయత్నిస్తుంది.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN $nameకు కనెక్ట్ కావడానికి ప్రయత్నిస్తుంది.';
  }

  @override
  String get locations_confirmChange => 'మార్చి కనెక్ట్ చేయండి';

  @override
  String get locations_changeBusy =>
      'మార్పు జరుగుతోంది. మరో స్థానాన్ని ఎంచుకునే ముందు వేచి ఉండండి.';

  @override
  String get locations_automaticSelection => 'స్వయంచాలక ఎంపిక';

  @override
  String get locations_cities => 'నగరాలు';

  @override
  String get locations_servers => 'సర్వర్‌లు';

  @override
  String locations_viewCities(String name) {
    return '$nameలోని నగరాలను చూడండి';
  }

  @override
  String locations_viewServers(String name) {
    return '$nameలోని సర్వర్‌లను చూడండి';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count దేశాలు',
      one: '$count దేశం',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count నగరాలు',
      one: '$count నగరం',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count సర్వర్‌లు',
      one: '$count సర్వర్',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'అన్ని దేశాలు';

  @override
  String get locations_backToCountries => 'దేశాలకు తిరిగి వెళ్లండి';

  @override
  String locations_backToCities(String name) {
    return '$nameలోని నగరాలకు తిరిగి వెళ్లండి';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$nameను ఎంచుకోండి';
  }

  @override
  String locations_chooseCity(String name) {
    return '$nameను ఎంచుకోండి';
  }

  @override
  String get locations_noCompatibleServer =>
      'అనుకూలమైన సర్వర్ అందుబాటులో లేదు.';

  @override
  String get externalLink_failed =>
      'ఈ లింక్‌ను తెరవడం సాధ్యం కాలేదు. మీరు దీన్ని కాపీ చేసి మీ బ్రౌజర్‌లో తెరవవచ్చు.';

  @override
  String get externalLink_copy => 'లింక్‌ను కాపీ చేయండి';

  @override
  String get externalLink_copied => 'లింక్ కాపీ అయింది';

  @override
  String get externalLink_copyFailed =>
      'లింక్‌ను కాపీ చేయడం సాధ్యం కాలేదు. దిగువన ఉన్న చిరునామాను ఎంచుకోండి.';

  @override
  String get settings_deleteAccount => 'నా ఖాతాను తొలగించండి';

  @override
  String get settings_deleteAccountDetail =>
      'ఖాతా తొలగింపు అభ్యర్థన ప్రక్రియను చూడండి';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'మీ VPN సబ్‌స్క్రిప్షన్‌ను ఎంచుకోండి.';

  @override
  String get billing_subscribe => 'సబ్‌స్క్రైబ్ చేయండి';

  @override
  String get billing_choosePlan => 'కొనసాగించడానికి ఒక ప్లాన్‌ను ఎంచుకోండి.';

  @override
  String get billing_monthly => 'నెలవారీ';

  @override
  String get billing_yearly => 'వార్షికం';

  @override
  String get billing_continue => 'Google Playతో కొనసాగించండి';

  @override
  String get billing_restore => 'కొనుగోళ్లను పునరుద్ధరించండి';

  @override
  String get billing_manage => 'సబ్‌స్క్రిప్షన్‌ను నిర్వహించండి';

  @override
  String get billing_deleteAccountWarning =>
      'మీకు Google Play సబ్‌స్క్రిప్షన్ ఉంటే, మీ FuzeVPN ఖాతాను తొలగించడం వల్ల దాని పునరుద్ధరణ రద్దు కాదు. Google Playలో ఆ పునరుద్ధరణను విడిగా నిర్వహించండి లేదా రద్దు చేయండి.';

  @override
  String get billing_deleteAccountContinue =>
      'ఖాతా తొలగింపు అభ్యర్థనకు వెళ్లండి';

  @override
  String get billing_refresh => 'యాక్సెస్‌ను రిఫ్రెష్ చేయండి';

  @override
  String get billing_loadingPlans => 'ప్లాన్‌లు లోడ్ అవుతున్నాయి…';

  @override
  String get billing_unavailable =>
      'ప్రస్తుతం ఏ ప్లాన్‌లూ అందుబాటులో లేవు. తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get billing_comingSoon => 'సబ్‌స్క్రిప్షన్‌లు త్వరలో వస్తాయి.';

  @override
  String get billing_priceDisclosure =>
      'ధరను Google Play అందిస్తుంది. మీరు నిర్ధారించే ముందు తుది మొత్తం, వర్తించే పన్నులు నిర్ధారించబడతాయి.';

  @override
  String get billing_renewalMonthly =>
      'రద్దు చేయకపోతే ప్రతి నెలా స్వయంచాలకంగా పునరుద్ధరించబడుతుంది. Google Play సబ్‌స్క్రిప్షన్‌ల్లో ఎప్పుడైనా రద్దు చేయవచ్చు.';

  @override
  String get billing_renewalYearly =>
      'రద్దు చేయకపోతే ప్రతి సంవత్సరం స్వయంచాలకంగా పునరుద్ధరించబడుతుంది. Google Play సబ్‌స్క్రిప్షన్‌ల్లో ఎప్పుడైనా రద్దు చేయవచ్చు.';

  @override
  String get billing_active => 'మీ ప్రీమియం యాక్సెస్ యాక్టివ్‌గా ఉంది';

  @override
  String billing_accessUntil(String date) {
    return '$date వరకు యాక్సెస్.';
  }

  @override
  String get billing_webManaged =>
      'మీ సబ్‌స్క్రిప్షన్‌ను FuzeVPN వెబ్‌సైట్‌లో నిర్వహిస్తున్నారు.';

  @override
  String get billing_playManaged =>
      'మీ సబ్‌స్క్రిప్షన్‌ను Google Play నిర్వహిస్తోంది.';

  @override
  String get billing_playOnHold =>
      'మీ Google Play సబ్‌స్క్రిప్షన్ నిలిపివేయబడింది లేదా చెల్లింపు కోసం వేచి ఉంది. దాన్ని Google Playలో సరిచేయడానికి “సబ్‌స్క్రిప్షన్‌ను నిర్వహించండి”ని తెరవండి.';

  @override
  String get billing_playReceiptUnlinked =>
      'ఈ Google Play ఖాతాకు ఇప్పటికే Fuze Premium సబ్‌స్క్రిప్షన్ ఉంది, కానీ అది ఈ FuzeVPN ఖాతాకు యాక్టివ్‌గా లేదు. Google Playలో దాన్ని పరిశీలించడానికి “సబ్‌స్క్రిప్షన్‌ను నిర్వహించండి”ని తెరవండి.';

  @override
  String get billing_inactive => 'యాక్టివ్ సబ్‌స్క్రిప్షన్ లేదు.';

  @override
  String get billing_checkingAccess => 'మీ యాక్సెస్‌ను తనిఖీ చేస్తోంది…';

  @override
  String get billing_restoring => 'కొనుగోళ్లను పునరుద్ధరిస్తోంది…';

  @override
  String get billing_pending =>
      'చెల్లింపు పెండింగ్‌లో ఉంది. నిర్ధారణ తర్వాత మీ యాక్సెస్ యాక్టివేట్ అవుతుంది.';

  @override
  String get billing_cancelled =>
      'కొనుగోలు రద్దు చేయబడింది. కొత్త సబ్‌స్క్రిప్షన్ ఏదీ యాక్టివేట్ కాలేదు.';

  @override
  String get billing_verifying => 'కొనుగోలును ధ్రువీకరిస్తోంది…';

  @override
  String get billing_success =>
      'సబ్‌స్క్రిప్షన్ యాక్టివేట్ అయింది. మీ ప్రీమియం యాక్సెస్ సిద్ధంగా ఉంది.';

  @override
  String get billing_restored => 'మీ కొనుగోళ్లు పునరుద్ధరించబడ్డాయి.';

  @override
  String get billing_restoreEmpty =>
      'ఈ Google Play ఖాతాకు పునరుద్ధరించడానికి కొనుగోళ్లు ఏవీ లేవు.';

  @override
  String get billing_catalogError =>
      'ప్లాన్‌లను లోడ్ చేయడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get billing_purchaseError =>
      'కొనుగోలును ప్రారంభించడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get billing_verificationError =>
      'కొనుగోలు ధ్రువీకరణ తాత్కాలికంగా అందుబాటులో లేదు. మళ్లీ ప్రయత్నించడానికి కొనుగోళ్లను పునరుద్ధరించండి.';

  @override
  String get billing_restoreError =>
      'కొనుగోళ్లను పునరుద్ధరించడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get billing_managementError =>
      'సబ్‌స్క్రిప్షన్ నిర్వహణను తెరవడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get billing_storeUnavailable =>
      'ఈ పరికరంలో Google Play అందుబాటులో లేదు.';

  @override
  String get welcome_title => 'మీ VPN, సరళంగా.';

  @override
  String get welcome_description =>
      'మీ కనెక్షన్‌ను రక్షించుకోండి. మీ గోప్యతపై నియంత్రణలో ఉండండి.';

  @override
  String get welcome_start => 'ప్రారంభించండి';

  @override
  String get welcome_alreadyPurchased => 'ఇప్పటికే కొనుగోలు చేశారా?';

  @override
  String get welcome_noAccountRequired => 'ప్రారంభించడానికి ఖాతా అవసరం లేదు.';

  @override
  String get guest_accountTitle => 'ఖాతా లింక్ చేయబడలేదు';

  @override
  String get guest_accountDescription =>
      'మరో పరికరంలో మీ సబ్‌స్క్రిప్షన్‌ను ఉపయోగించడానికి అదే Google Play ఖాతాతో మీ కొనుగోళ్లను పునరుద్ధరించండి.';

  @override
  String get guest_existingSubscriberSignIn =>
      'ఇప్పటికే సబ్‌స్క్రైబ్ చేశారా? సైన్ ఇన్ చేయండి';

  @override
  String get guest_claimTitle => 'FuzeVPNను మీతో పాటు తీసుకెళ్లండి';

  @override
  String get guest_claimDescription =>
      'మీ ఇతర పరికరాల్లో మీ సబ్‌స్క్రిప్షన్‌ను యాక్సెస్ చేయడానికి ఖాతాను సృష్టించండి. ఈ దశ ఐచ్ఛికం.';

  @override
  String get guest_skip => 'తర్వాత';

  @override
  String get guest_activationTitle => 'Fuze Premium యాక్టివ్‌గా ఉంది';

  @override
  String get guest_activationDescription =>
      'మీ సబ్‌స్క్రిప్షన్ సిద్ధంగా ఉంది. మీ VPNను ఉపయోగించండి; మీకు ఇష్టమైనప్పుడు ఖాతాను సృష్టించుకోవచ్చు.';

  @override
  String get guest_useVpn => 'నా VPNను ఉపయోగించండి';

  @override
  String get guest_loginRequired =>
      'ఈ కొనుగోలు ఇప్పటికే ఒక FuzeVPN ఖాతాకు లింక్ చేయబడింది. మీ సబ్‌స్క్రిప్షన్‌ను యాక్సెస్ చేయడానికి ఆ ఖాతాలో సైన్ ఇన్ చేయండి.';

  @override
  String get guest_signOutWarning =>
      'అదే Google Play ఖాతాతో కొనుగోళ్లను పునరుద్ధరించడం ద్వారా మీ సబ్‌స్క్రిప్షన్‌ను తిరిగి పొందవచ్చు.';

  @override
  String get guest_profileUnavailable =>
      'మీ ఖాతా ఇప్పటికే లింక్ చేయబడింది. మీ వివరాలను చూడటానికి మరియు నిర్వహించడానికి సైన్ ఇన్ చేయండి.';

  @override
  String get billing_acceptance =>
      'కొనసాగించడం ద్వారా, మీరు ఉపయోగ నిబంధనలను మరియు గోప్యతా విధానాన్ని అంగీకరిస్తున్నారు.';

  @override
  String get guest_verifyEmailReminder =>
      'మీ ఖాతాను సురక్షితంగా ఉంచడానికి మీ ఇమెయిల్ చిరునామాను నిర్ధారించండి. మీరు మీ VPNను ఉపయోగించడం కొనసాగించవచ్చు.';

  @override
  String get guest_serviceUnavailable =>
      'సేవ తాత్కాలికంగా అందుబాటులో లేదు. కొద్దిసేపటి తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get guest_restoreError =>
      'మీ కొనుగోళ్లను పునరుద్ధరించడం సాధ్యం కాలేదు. కొనుగోలుకు ఉపయోగించిన Google Play ఖాతాతో మళ్లీ ప్రయత్నించండి.';

  @override
  String get guest_claimSuccess =>
      'మీ ఖాతా సృష్టించబడింది. మీ సబ్‌స్క్రిప్షన్ మరియు VPN యాక్సెస్ భద్రపరచబడ్డాయి.';

  @override
  String get guest_emailExists =>
      'ఈ ఇమెయిల్ ఇప్పటికే ఉపయోగంలో ఉంది. మరో చిరునామాను ఎంచుకోండి లేదా మీ ఇప్పటికే ఉన్న ఖాతాలో సైన్ ఇన్ చేయండి. మీ కొనుగోలు Google Play ద్వారా అందుబాటులో ఉంటుంది.';

  @override
  String get guest_claimError =>
      'మీ ఖాతాను సృష్టించడం సాధ్యం కాలేదు. మీరు మీ VPNను ఉపయోగిస్తూనే ఉండవచ్చు, తర్వాత మళ్లీ ప్రయత్నించవచ్చు.';

  @override
  String get guest_secureStorageError =>
      'ఈ పరికరంలో మీ సెషన్‌ను భద్రపరచడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get guest_premiumRequired =>
      'మీ VPNను యాక్టివేట్ చేయడానికి ఒక సబ్‌స్క్రిప్షన్‌ను ఎంచుకోండి.';

  @override
  String get welcome_viewPlans => 'ప్లాన్‌లను చూడండి';

  @override
  String get google_continue => 'Googleతో కొనసాగించండి';

  @override
  String get google_or => 'లేదా';

  @override
  String get google_title => 'మీ FuzeVPN ఖాతా';

  @override
  String get google_settingUp => 'మీ ఖాతా సృష్టిని పూర్తి చేయండి';

  @override
  String get google_country => 'నివాస దేశం';

  @override
  String get google_profileDescription =>
      'మీ FuzeVPN ఖాతాను సృష్టించడానికి మీ దేశాన్ని ఎంచుకుని, రెండు పత్రాలను సమీక్షించండి.';

  @override
  String get google_claimDescription =>
      'మీ అతిథి ఖాతాను Googleకు లింక్ చేయండి. మీ సబ్‌స్క్రిప్షన్ మరియు పరికరం ఈ ఖాతాకే జతచేయబడి ఉంటాయి.';

  @override
  String get google_linkTitle => 'Googleను FuzeVPNకు లింక్ చేయండి';

  @override
  String get google_linkDescription =>
      'మీ ఇప్పటికే ఉన్న FuzeVPN ఖాతాకు యాక్సెస్‌ను నిర్ధారించండి. ఈ దశ మీ Google పాస్‌వర్డ్‌ను అడగదు.';

  @override
  String get google_password => 'FuzeVPN పాస్‌వర్డ్';

  @override
  String get google_linkAccount => 'లింక్‌ను నిర్ధారించండి';

  @override
  String get google_requestEmail => 'నాకు నిర్ధారణ ఇమెయిల్ పంపండి';

  @override
  String get google_emailInstructions =>
      'FuzeVPN ఇమెయిల్‌ను తెరిచి, నిర్ధారణ కోడ్‌ను నమోదు చేయండి.';

  @override
  String get google_emailCode => 'ఇమెయిల్ నిర్ధారణ కోడ్';

  @override
  String get google_confirmEmail => 'కోడ్‌ను నిర్ధారించండి';

  @override
  String get google_restart => 'మరో Google ఖాతాను ఎంచుకోండి';

  @override
  String get google_resume => 'ఈ ప్రయత్నాన్ని తనిఖీ చేయండి';

  @override
  String get google_unavailable =>
      'Google సైన్ ఇన్ అందుబాటులో లేదు. మీరు ఇమెయిల్ మరియు పాస్‌వర్డ్‌ను ఉపయోగించవచ్చు.';

  @override
  String get google_expired =>
      'ఈ ప్రయత్నానికి గడువు ముగిసింది. దాన్ని రద్దు చేసి మళ్లీ ప్రారంభించండి.';

  @override
  String get google_conflict =>
      'ఈ Google ఖాతా ఇప్పటికే మరొక చోట లింక్ చేయబడింది. మీ ప్రస్తుత ఖాతా మరియు సబ్‌స్క్రిప్షన్ భద్రంగా ఉంటాయి.';

  @override
  String get google_error =>
      'Google సైన్ ఇన్ విఫలమైంది. మళ్లీ ప్రయత్నించండి; మీ ప్రస్తుత యాక్సెస్ భద్రంగా ఉంటుంది.';

  @override
  String get google_uncertain =>
      'ఫలితాన్ని నిర్ధారించడం సాధ్యం కాలేదు. మళ్లీ ప్రారంభించే ముందు ఈ ప్రయత్నాన్ని తనిఖీ చేయండి లేదా రద్దు చేయండి.';

  @override
  String get google_cancelFailed =>
      'రద్దు చేయడం నిర్ధారణ కాలేదు. ఈ స్క్రీన్‌ను వదిలే ముందు మళ్లీ రద్దు చేయడానికి ప్రయత్నించండి.';

  @override
  String get google_cancelled => 'Google సైన్ ఇన్ రద్దు చేయబడింది.';

  @override
  String get google_selecting => 'మీ Google ఖాతాను ఎంచుకోండి…';

  @override
  String get google_verifying => 'మీ ఖాతాను తనిఖీ చేస్తోంది…';

  @override
  String get google_emailUnavailable =>
      'నిర్ధారణ ఇమెయిల్ పంపడం సాధ్యం కాలేదు. తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get google_emailSent =>
      'నిర్ధారణ ఇమెయిల్ పంపబడింది. మీ ఇన్‌బాక్స్‌ను తనిఖీ చేయండి.';

  @override
  String get google_rateLimited =>
      'దయచేసి మళ్లీ ప్రయత్నించే ముందు వేచి ఉండండి.';

  @override
  String get google_busy =>
      'మరొక చర్య జరుగుతున్నప్పుడు (VPN కనెక్షన్, ఖాతా లేదా అతిథి) Google అందుబాటులో ఉండదు. అది పూర్తయ్యాక మళ్లీ ప్రయత్నించండి; మీ ప్రస్తుత యాక్సెస్ భద్రంగా ఉంటుంది.';

  @override
  String get google_invalidPassword =>
      'FuzeVPN పాస్‌వర్డ్ తప్పు. మీ ప్రస్తుత ఖాతా భద్రంగా ఉంటుంది.';

  @override
  String get google_invalidCode =>
      'నిర్ధారణ కోడ్ చెల్లనిది లేదా గడువు ముగిసింది.';

  @override
  String get google_accountChanged =>
      'మీ సెషన్ మారింది. మళ్లీ ప్రారంభించే ముందు ఈ ప్రయత్నాన్ని రద్దు చేయండి.';

  @override
  String get google_invalidResponse =>
      'ప్రతిస్పందనను ధ్రువీకరించడం సాధ్యం కాలేదు. మీ ప్రస్తుత యాక్సెస్ భద్రంగా ఉంటుంది.';

  @override
  String get google_invalidRegistration =>
      'మీ దేశాన్ని మరియు రెండు అంగీకారాలను తనిఖీ చేయండి.';

  @override
  String get google_consentRequired =>
      'కొనసాగడానికి మీ దేశాన్ని ఎంచుకుని, రెండు పత్రాలను అంగీకరించండి.';

  @override
  String get google_challengeRequired =>
      'అదనపు భద్రతా తనిఖీ అవసరం. మీ ప్రస్తుత యాక్సెస్ భద్రంగా ఉంటుంది.';

  @override
  String get google_challengeUnavailable =>
      'భద్రతా తనిఖీ అందుబాటులో లేదు. తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get google_intentMismatch =>
      'మునుపటి Google సైన్ ఇన్ ప్రయత్నం ఇంకా పెండింగ్‌లో ఉంది. ఈ చర్యను ప్రారంభించే ముందు దాన్ని రద్దు చేయండి.';

  @override
  String get google_challengeBlocked =>
      'అవసరమైన భద్రతా తనిఖీ ఈ యాప్‌లో అందుబాటులో లేదు. ఈ చర్యను ప్రస్తుతానికి పూర్తి చేయలేరు.';

  @override
  String get google_solveChallenge => 'భద్రతా తనిఖీని పూర్తి చేయండి';

  @override
  String get google_challengeTitle => 'భద్రతా తనిఖీ';

  @override
  String get google_challengeReady =>
      'ధ్రువీకరణ పూర్తయింది. ఇప్పుడు మీరు మీ ఖాతా సృష్టిని నిర్ధారించవచ్చు.';

  @override
  String get google_challengeExpired =>
      'ధ్రువీకరణ గడువు ముగిసింది. నిర్ధారించే ముందు దాన్ని మళ్లీ పూర్తి చేయండి.';

  @override
  String get google_challengeCancelled =>
      'ధ్రువీకరణ రద్దు చేయబడింది. మీరు మళ్లీ ప్రయత్నించవచ్చు.';

  @override
  String get google_challengeFailed =>
      'భద్రతా తనిఖీ విఫలమైంది. మళ్లీ ప్రయత్నించండి.';

  @override
  String get billing_trialTitle => 'Fuze Premiumను ఉచితంగా ప్రయత్నించండి';

  @override
  String get billing_trialSubtitle =>
      'ఈ రోజు నుండే మీ కనెక్షన్‌ను రక్షించుకోండి.';

  @override
  String get billing_trialWeeks => '2 వారాల ఉచిత ట్రయల్';

  @override
  String billing_trialDays(String days) {
    return '$days రోజుల ఉచిత ట్రయల్';
  }

  @override
  String get billing_trialStart => 'నా ఉచిత ట్రయల్‌ను ప్రారంభించండి';

  @override
  String billing_trialFirstCharge(String date) {
    return 'మీరు ఈ రోజు ప్రారంభిస్తే, మొదటి ఛార్జ్ $dateన ఉంటుందని అంచనా.';
  }

  @override
  String get billing_trialTerms =>
      'పేర్కొన్న ధరకు స్వయంచాలకంగా పునరుద్ధరించబడుతుంది. ఛార్జ్ కాకుండా ఉండటానికి, ట్రయల్ ముగిసేలోపు Google Playలో రద్దు చేయండి.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'ఆ తర్వాత నెలకు $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'ఆ తర్వాత ఏడాదికి $price';
  }

  @override
  String get billing_choosePeriod => 'మీ ప్లాన్‌ను ఎంచుకోండి';

  @override
  String get billing_selectionHint => 'కొనసాగించడానికి ఒక ప్లాన్‌ను ఎంచుకోండి.';

  @override
  String get billing_benefitConnection => 'ఎన్‌క్రిప్ట్ చేసిన కనెక్షన్';

  @override
  String get billing_benefitPrivacy => 'ఆన్‌లైన్ గోప్యత';

  @override
  String get billing_benefitNoAccount => 'రిజిస్ట్రేషన్ అవసరం లేదు';

  @override
  String get billing_cancellation => 'Google Playలో రద్దు చేయండి';

  @override
  String get billing_premiumTitle => 'మరింత రక్షితమైన కనెక్షన్.';

  @override
  String get billing_premiumSubtitle =>
      'మీ స్వంత వేగంతో మీ కనెక్షన్‌ను రక్షించుకోండి.';

  @override
  String get billing_priceMonthly => 'నెలకు';

  @override
  String get billing_priceYearly => 'ఏడాదికి';

  @override
  String get billing_trialToday => 'ఈ రోజు చెల్లించాల్సింది ఏదీ లేదు';

  @override
  String get billing_trialConfirmation =>
      'మీరు నిర్ధారించే ముందు తేదీలు, తుది మొత్తం మరియు వర్తించే పన్నులను Google Play నిర్ధారిస్తుంది.';

  @override
  String get billing_offerChanged =>
      'ఈ ఆఫర్ నిబంధనలు మారాయి. ప్లాన్‌లను రిఫ్రెష్ చేసి మళ్లీ ఎంచుకోండి.';

  @override
  String get status_waitingNetwork => 'నెట్‌వర్క్ కోసం వేచి ఉంది';

  @override
  String get status_waitingNetworkDetail =>
      'నెట్‌వర్క్ అందుబాటులో లేదు. నెట్‌వర్క్ తిరిగి వచ్చినప్పుడు VPN కనెక్షన్‌ను ధ్రువీకరిస్తుంది.';

  @override
  String get locations_favoriteLoadFailed =>
      'ఇష్టమైనవి లోడ్ చేయడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get locations_favoritesLoading => 'ఇష్టమైనవి లోడ్ అవుతున్నాయి…';
}
