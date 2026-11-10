// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Somali (`so`).
class AppLocalizationsSo extends AppLocalizations {
  AppLocalizationsSo([String locale = 'so']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Ilaali xidhiidhkaaga';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN wuxuu isticmaalaa adeegga VPN ee Android (VpnService) si uu u abuuro tunnel la sireeyay oo isku xidha aaladdan iyo serverrada FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Marka VPN-ku firfircoon yahay, socodka internetka ee barnaamijyadaada, cinwaannada meesha loo socdo iyo codsiyada DNS waxay maraan tunnel-kan si xidhiidhkaaga loo jiheeyo, xitaa marka FuzeVPN gadaal ka shaqeynayo.';

  @override
  String get vpnDisclosure_statusBody =>
      'Barnaamijku wuxuu isticmaalaa xaaladda xidhiidhka, muddadiisa iyo xaddiga xogta la wareejiyay si uu u muujiyo xidhiidhkaaga VPN. Waad joojin kartaa goor kasta.';

  @override
  String get vpnDisclosure_privacy => 'Asturnaanta';

  @override
  String get vpnDisclosure_accept => 'Aqbal oo sii wad';

  @override
  String get vpnDisclosure_decline => 'Hadda maya';

  @override
  String get accountRestoration_title =>
      'Akoonka si ku meel gaar ah looma heli karo';

  @override
  String get accountRestoration_message =>
      'Fadhigaaga waa la kaydiyay. Isku day mar kale si akoonkaaga loo soo celiyo; halkan waad ka maamuli kartaa xidhiidhka VPN.';

  @override
  String get action_retry => 'Isku day mar kale';

  @override
  String get session_endingTitle => 'Fadhiga waa la dhammeynayaa';

  @override
  String get session_ending =>
      'Fadhiga waa la dhammeynayaa: VPN-ka waa la joojinayaa, waana la nadiifinayaa…';

  @override
  String get session_stopFailed =>
      'Joojinta VPN-ka lama xaqiijin. Isku day mar kale ka hor intaadan mar kale soo gelin.';

  @override
  String get session_cleanupFailed =>
      'VPN-ka waa la joojiyay, laakiin ka saarista fadhiga lama xaqiijin. Isku day nadiifinta mar kale.';

  @override
  String get session_retryStop => 'Isku day joojinta mar kale';

  @override
  String get session_retryCleanup => 'Isku day nadiifinta mar kale';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN si ammaan ah ayaa loo diyaarinayaa…';

  @override
  String get nav_connection => 'Xidhiidh';

  @override
  String get nav_locations => 'Goobaha';

  @override
  String get nav_account => 'Akoon';

  @override
  String get nav_devices => 'Aaladaha';

  @override
  String get nav_settings => 'Dejinta';

  @override
  String get action_refresh => 'Cusboonaysii';

  @override
  String get auth_tab_login => 'Soo gal';

  @override
  String get auth_tab_register => 'Samee akoon';

  @override
  String get auth_stepAccount => 'Akoon';

  @override
  String get auth_stepIdentity => 'Aqoonsi';

  @override
  String get auth_stepAddress => 'Cinwaan iyo heshiisyo';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Tallaabada $current ka mid ah $total';
  }

  @override
  String get auth_tagline => 'VPN-kaaga, si fudud.';

  @override
  String get auth_keysLocal =>
      'Furayaasha gaarka ah ee VPN-kaaga waxay ku sii jiraan aaladdan.';

  @override
  String get form_email => 'Cinwaanka iimaylka';

  @override
  String get form_password => 'Erayga sirta';

  @override
  String get form_showPassword => 'Muuji erayga sirta';

  @override
  String get form_hidePassword => 'Qari erayga sirta';

  @override
  String get form_passwordMin =>
      '8–72 bayt oo UTF-8 ah. Xarfaha qaarkood waxay isticmaalaan in ka badan hal bayt.';

  @override
  String get form_firstName => 'Magaca koowaad';

  @override
  String get form_lastName => 'Magaca dambe';

  @override
  String get form_phone => 'Taleefan (+33612345678)';

  @override
  String get form_address => 'Cinwaan';

  @override
  String get form_address2 => 'Cinwaanka khadka 2 (ikhtiyaari)';

  @override
  String get form_postalCode => 'Koodhka boostada';

  @override
  String get form_city => 'Magaalada';

  @override
  String get form_country => 'Koodhka dalka (tusaale ahaan FR)';

  @override
  String get action_login => 'Soo gal';

  @override
  String get action_createAccount => 'Samee akoon';

  @override
  String get action_createMyAccount => 'Samee akoonkayga';

  @override
  String get action_next => 'Sii wad';

  @override
  String get action_previous => 'Dib u noqo';

  @override
  String get action_forgotPassword => 'Ma illowday erayga sirta?';

  @override
  String get auth_noAccount => 'Weli akoon ma lihid?';

  @override
  String get auth_requiredInformation => 'Akoonkaaga ku samee saddex tallaabo.';

  @override
  String get auth_termsPrefix => 'Waan aqbalay ';

  @override
  String get auth_termsLink => 'shuruudaha isticmaalka';

  @override
  String get auth_privacyPrefix => 'Waan aqbalay ';

  @override
  String get auth_privacyLink => 'siyaasadda asturnaanta';

  @override
  String get auth_consentRequired =>
      'Oggolaanshahaaga ayaa loo baahan yahay si akoon loo abuuro.';

  @override
  String get validation_required => 'Qaybtan waa in la buuxiyo.';

  @override
  String get validation_email => 'Geli cinwaan iimayl oo sax ah.';

  @override
  String get validation_password =>
      'Erayga sirta wuu gaaban yahay: ugu yaraan 8 bayt oo UTF-8 ah.';

  @override
  String get validation_passwordTooLong =>
      'Erayga sirta wuu dheer yahay: ugu badnaan 72 bayt oo UTF-8 ah.';

  @override
  String get validation_phone =>
      'Isticmaal qaabka caalamiga ah, tusaale ahaan +33612345678.';

  @override
  String get validation_country =>
      'Isticmaal koodh dal oo laba xaraf ah, tusaale ahaan FR.';

  @override
  String get passwordReset_title => 'Dib u deji erayga sirta';

  @override
  String get passwordReset_description =>
      'Geli cinwaanka iimaylka ee akoonkaaga si aad u codsato xiriir lagu dib u dejiyo erayga sirta.';

  @override
  String get passwordReset_send => 'Dir xiriirka';

  @override
  String get connection_title => 'Xidhiidhkaaga';

  @override
  String get connection_subtitle => 'Dooro goob, kadibna shid VPN-kaaga.';

  @override
  String get connection_prepare => 'Diyaar ma u tahay inaad ku xidhanto?';

  @override
  String get connection_advancedOptions => 'Doorashooyin horumarsan';

  @override
  String get connection_location => 'Goob';

  @override
  String get connection_chooseLocation => 'Dooro goob';

  @override
  String get connection_protocol => 'Protokol';

  @override
  String get connection_connect => 'Ku xidh';

  @override
  String get connection_connecting => 'Ku xidhmaya…';

  @override
  String get connection_disconnect => 'Jooji';

  @override
  String get connection_disconnecting => 'Joojinaya';

  @override
  String get connection_locationChange => 'Goobta waa la beddelayaa…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol lama heli karo';
  }

  @override
  String get connection_activeLocation => 'Goobta firfircoon';

  @override
  String get connection_duration => 'Muddada';

  @override
  String get connection_received => 'La helay';

  @override
  String get connection_sent => 'La diray';

  @override
  String get connection_lastHandshake =>
      'Isweydaarsiga ammaanka ah ee ugu dambeeyay';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration ka hor';
  }

  @override
  String get verification_title => 'Xaqiiji cinwaanka iimaylkaaga';

  @override
  String get verification_message =>
      'Xaqiiji cinwaanka iimaylkaaga si aad VPN-ka ugu isticmaasho taleefankan.';

  @override
  String get verification_resend => 'Dib u dir iimaylka';

  @override
  String get migration_title => 'Beddelka goobta';

  @override
  String get migration_draining => 'Beddelka goobta waa la diyaarinayaa…';

  @override
  String get migration_activating => 'Server-ka cusub waa la hawlgelinayaa…';

  @override
  String get migration_ready => 'Goobta waa la cusboonaysiiyay.';

  @override
  String get migration_blocked =>
      'Beddelka goobta wuxuu u baahan yahay faragelin dhinaca server-ka ah. Mar dambe isku day ama la xiriir taageerada.';

  @override
  String get migration_progress => 'Horumarka beddelka goobta';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Waqtiga u dhexeeya hubinnada: $seconds ilbiriqsi.';
  }

  @override
  String get migration_resume => 'Dib u sii wad beddelka goobta';

  @override
  String get status_authorizing => 'Oggolaansho ayaa loo baahan yahay';

  @override
  String get status_authorizingDetail =>
      'Aqbal codsiga Android si VPN-ka loo oggolaado.';

  @override
  String get status_preparing => 'Diyaarinaya';

  @override
  String get status_preparingDetail =>
      'Xidhiidhkaaga ammaanka ah waa la diyaarinayaa.';

  @override
  String get status_reconnecting => 'Dib ku xidhmaya…';

  @override
  String get status_reconnectingDetail =>
      'Xidhiidhku wuu go’ay. VPN-ku wuxuu isku dayayaa inuu dib ku xidhmo.';

  @override
  String get status_connecting => 'Ku xidhmaya';

  @override
  String get status_connectingDetail => 'Ku xidhmaya server-ka VPN…';

  @override
  String get status_connected => 'Ku xidhan';

  @override
  String get status_connectedDetail =>
      'Xidhiidhka VPN-kaaga wuu firfircoon yahay.';

  @override
  String get status_disconnecting => 'Joojinaya';

  @override
  String get status_disconnectingDetail =>
      'Xidhiidhka VPN-kaaga waa la joojinayaa.';

  @override
  String get status_error => 'Xidhiidhka lama heli karo';

  @override
  String get status_errorDetail =>
      'Xidhiidhka VPN lama xaqiijin. Isku day mar kale.';

  @override
  String get status_idle => 'Ma ku xidhna';

  @override
  String get status_idleDetail =>
      'Ku xidh VPN-ka si aad xidhiidhkaaga u ilaaliso.';

  @override
  String get trust_note =>
      'Marka barnaamijka la xidho, VPN-ku ma joogsado. Si aad u joojiso, isticmaal “Jooji”.';

  @override
  String get locations_none => 'Hadda ma jiraan goobo la heli karo.';

  @override
  String get locations_available => 'Dooro goobtaada xigta.';

  @override
  String get locations_selected => 'Goobta la doortay';

  @override
  String get locations_select => 'Dooro goobtan';

  @override
  String get locations_lockedTunnel => 'Jooji VPN-ka si aad goobta u beddesho.';

  @override
  String get locations_lockedMigration => 'Sug ilaa beddelka goobta dhammaado.';

  @override
  String get devices_title => 'Aaladahaaga';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit aalad';
  }

  @override
  String get devices_refresh => 'Cusboonaysii aaladaha';

  @override
  String get devices_empty => 'Weli ma jirto aalad VPN ah oo diiwaangashan.';

  @override
  String get devices_firstConnection =>
      'Taleefankaaga waa la dari doonaa marka ugu horreysa ee aad ku xidhanto.';

  @override
  String get devices_thisDevice => 'Aaladdan';

  @override
  String devices_added(Object date) {
    return 'La daray $date';
  }

  @override
  String get devices_unnamed => 'Aalad aan magac lahayn';

  @override
  String get action_remove => 'Ka saar';

  @override
  String get settings_title => 'Dejinta';

  @override
  String get settings_subtitle =>
      'Doorashooyinkaaga iyo akoonkaaga, oo dhan hal meel.';

  @override
  String get settings_appearance => 'Muuqaalka';

  @override
  String get settings_language => 'Luqadda';

  @override
  String get settings_languageDescription =>
      'Luqadda aad dooratay waxaa sidoo kale loo isticmaalaa ogeysiisyada VPN-ka.';

  @override
  String get settings_account => 'Akoon';

  @override
  String get settings_signOut => 'Ka bax';

  @override
  String get settings_privacy => 'Siyaasadda asturnaanta';

  @override
  String get settings_terms => 'Shuruudaha isticmaalka';

  @override
  String get settings_security => 'Amniga iyo hufnaanta';

  @override
  String get settings_licenses => 'Liisannada qaybaha';

  @override
  String get settings_licensesDetail => 'Softiweerka barnaamijka ku jira';

  @override
  String settings_licensesLegalese(String url) {
    return 'Koodhka isha ee barnaamijka iyo qaybihiisa MPL-2.0 ah: $url';
  }

  @override
  String get settings_background =>
      'VPN-ku wuu sii shaqeynayaa marka aad barnaamijka ka baxdo. Si aad u joojiso, qaybta Xidhiidh ka isticmaal “Jooji”.';

  @override
  String get theme_system => 'Nidaamka';

  @override
  String get theme_light => 'Iftiin';

  @override
  String get theme_dark => 'Mugdi';

  @override
  String get language_system => 'Luqadda taleefanka';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Ka saar aaladdan?';

  @override
  String get dialog_removeCurrent =>
      'Taleefankan wuu ka go’i doonaa VPN-ka wuuna waayi doonaa gelitaanka. Xogta xidhiidhkiisa VPN waa la tirtiri doonaa marka server-ku xaqiijiyo.';

  @override
  String dialog_removeOther(Object name) {
    return 'Gelitaanka VPN ee “$name” waa la ka qaadi doonaa. Tan dib looma noqon karo.';
  }

  @override
  String get dialog_signOut => 'Ma ka baxaysaa?';

  @override
  String get dialog_signOutMessage =>
      'VPN-ku wuu joogsan doonaa, waxaadna u baahan doontaa inaad mar kale soo gasho. Furayaasha VPN-ka ee la sireeyay waxay ku sii jiri doonaan taleefankan xidhiidhkaaga xiga.';

  @override
  String get action_cancel => 'Iska daa';

  @override
  String get action_close => 'Xir';

  @override
  String get action_copy => 'Koobiyee';

  @override
  String get action_signOut => 'Ka bax';

  @override
  String get notice_close => 'Xir farriinta';

  @override
  String get notice_sessionExpired_title => 'Fadhigu wuu dhacay';

  @override
  String get notice_sessionExpired_message =>
      'Fadhigaagu wuu dhacay. Mar kale soo gal.';

  @override
  String get notice_connectionFailed_title => 'Xidhiidhku wuu fashilmay';

  @override
  String get notice_invalidCredentials_message =>
      'Cinwaanka iimaylka ama erayga sirta ma sax aha.';

  @override
  String get notice_emailVerification_title =>
      'Xaqiijinta iimaylka ayaa loo baahan yahay';

  @override
  String get notice_emailVerification_message =>
      'Xaqiiji cinwaanka iimaylkaaga ka hor intaadan aalad VPN ah ku darin.';

  @override
  String get notice_rateLimited_title => 'Isku dayo aad u badan';

  @override
  String get notice_deviceLimit_title => 'Xadka aaladaha waa la gaaray';

  @override
  String get notice_deviceLimit_message =>
      'Ka saar aalad hadda jirta ka hor intaadan mid kale ku darin.';

  @override
  String get notice_identityRenewal_title =>
      'Aqoonsiga VPN waa in la cusboonaysiiyaa';

  @override
  String get notice_identityRenewal_message =>
      'Aqoonsigan waa la tirtiray. Samee aqoonsi cusub oo maxalli ah.';

  @override
  String get notice_migrationPending_title => 'Beddelka goobta ayaa socda';

  @override
  String get notice_migrationPending_message =>
      'Beddel goob ayaa hore u socda.';

  @override
  String get notice_migrationBlocked_title => 'Beddelka goobta waa la xannibay';

  @override
  String get notice_migrationBlocked_message =>
      'Beddelka goobta wuxuu u baahan yahay faragelin dhinaca server-ka ah. Mar dambe isku day ama la xiriir taageerada.';

  @override
  String get notice_targetUnavailable_title =>
      'Server-ka si ku meel gaar ah looma heli karo';

  @override
  String get notice_targetUnavailable_message =>
      'Server-kan si ku meel gaar ah looma heli karo.';

  @override
  String get notice_networkUnavailable_title =>
      'Xidhiidhka internetka lama heli karo';

  @override
  String get notice_networkUnavailable_message =>
      'Hubi xidhiidhkaaga, kadibna isku day mar kale.';

  @override
  String get notice_permissionDenied_title => 'Oggolaanshaha VPN waa la diiday';

  @override
  String get notice_permissionDenied_message =>
      'Mar kale bilow xidhiidhka, kadibna aqbal codsiga oggolaanshaha Android.';

  @override
  String get notice_wireguardTimeout_title => 'Server-ku ma jawaabayo';

  @override
  String get notice_wireguardTimeout_message =>
      'Xidhiidhka WireGuard waqti badan ayuu qaatay. Isku day mar kale ama dooro goob kale.';

  @override
  String get notice_tlsFailed_title => 'Xidhiidhka ammaanka ah waa la diiday';

  @override
  String get notice_tlsFailed_message =>
      'Server-ku ma aqbalin xidhiidhka OpenVPN. Isku day mar kale. Haddii dhibaatadu sii socoto, samee baaritaan.';

  @override
  String get notice_tunRejected_title => 'Android wuu diiday interface-ka VPN';

  @override
  String get notice_tunRejected_message =>
      'Android wuxuu diiday habaynta shabakadda ee OpenVPN uu codsaday.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN lama bilaabi karin';

  @override
  String get notice_openvpnStart_message =>
      'Mishiinka OpenVPN ma dhammaystiri karin bilaabidda. Isku day mar kale. Haddii dhibaatadu sii socoto, la xiriir taageerada.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Koodhka baaritaanka: $code';
  }

  @override
  String get notice_generic_title => 'Xidhiidhka VPN wuu fashilmay';

  @override
  String get notice_generic_message =>
      'Khalad ayaa dhacay. Mar dambe isku day.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Akoonka waa la sameeyay',
      'password_reset_sent': 'Codsiga dib u dejinta erayga sirta waa la helay',
      'verification_email_sent': 'Iimaylka xaqiijinta waa la diray',
      'location_migration_pending': 'Beddelka goobta ayaa socda',
      'vpn_sign_in_required': 'Soo galitaan ayaa loo baahan yahay',
      'protocol_unavailable_at_location': 'Protokolka lama heli karo',
      'vpn_permission_denied': 'Oggolaanshaha VPN waa la diiday',
      'revoked_identity_device_limit': 'Xadka aaladaha waa la gaaray',
      'tunnel_start_unexpected': 'VPN lama bilaabi karin',
      'flutter_disconnect_timeout': 'Joojinta xidhiidhka lama xaqiijin',
      'flutter_disconnect_unexpected': 'Xidhiidhka lama joojin karin',
      'device_revoked': 'Aaladda waa la saaray',
      'revoke_unexpected': 'Aaladda lama saari karin',
      'identity_renewal_unexpected': 'Aqoonsiga lama cusboonaysiin karin',
      'openvpn_renewal_unexpected': 'OpenVPN lama cusboonaysiin karin',
      'location_migration_blocked': 'Beddelka goobta waa la xannibay',
      'location_migration_slow': 'Beddelka goobta weli waa socdaa',
      'location_migration_conflict':
          'Beddelka goobta waa in la cusboonaysiiyaa',
      'location_migration_verification_failed': 'Beddelka goobta lama xaqiijin',
      'location_migration_device_changed':
          'Aaladda way is beddeshay inta beddelka goobta socday',
      'tunnel_stop_failed': 'Beddelka goobta lama heli karo',
      'device_clock_ahead': 'Saacadda aaladda way hore u socotaa',
      'other': 'Hawshu way guuldareysatay',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Akoonka waa la sameeyay, laakiin iimaylka xaqiijinta lama diri karin. Barnaamijka ka isticmaal “Dib u dir iimaylka”.',
      'password_reset_sent':
          'Codsigaaga waa la helay. Haddii akoon u dhigma cinwaankan jiro, iimayl ayaad heli kartaa. Fadlan sidoo kale hubi faylka spam-ka.',
      'verification_email_sent': 'Iimayl xaqiijin cusub ayaa hadda la diray.',
      'location_migration_pending':
          'Wareejinta ku wajahan $target weli waa la diyaarinayaa. Waad dib u sii wadi kartaa adigoon aaladda dib u abuurin.',
      'vpn_sign_in_required':
          'Ka hor intaadan VPN-ka bilaabin, soo gal akoonkaaga.',
      'protocol_unavailable_at_location':
          'Goobtan ma bixiso protokolka la doortay. Cusboonaysii goobaha ama dooro protokol kale.',
      'vpn_permission_denied':
          'Android ayaa diiday oggolaanshaha VPN. Mar kale bilow xidhiidhka, kadibna aqbal codsiga nidaamka.',
      'revoked_identity_device_limit':
          'Gelitaanka VPN ee aaladdan waa la ka qaaday, xadka aaladahana waa la gaaray. Aalad ka saar qaybta Akoon → Maamul aaladahayga.',
      'tunnel_start_unexpected':
          'Khalad aan la filayn ayaa carqaladeeyay diyaarinta tunnel-ka. Hubi koodhka baaritaanka, kadibna isku day mar kale.',
      'flutter_disconnect_timeout':
          'Android ma xaqiijin in VPN-ka la joojiyay waqtigii loogu talagalay. Isku day inaad mar kale joojiso.',
      'flutter_disconnect_unexpected':
          'Khalad aan la filayn ayaa ka hortagay xaqiijinta in tunnel-ka la joojiyay.',
      'device_revoked':
          'Gelitaanka VPN ee aaladda waa la baabi’iyay, sirihii maxalliga ahaa waa la tirtiray.',
      'revoke_unexpected':
          'Aaladda lama saari karin. Cusboonaysii liiska, kadibna isku day mar kale.',
      'identity_renewal_unexpected':
          'Aqoonsiga VPN ee cusub lama abuuri karin. Cusboonaysii aaladaha, kadibna isku day mar kale.',
      'openvpn_renewal_unexpected':
          'Profiilka OpenVPN lama cusboonaysiin karin. Isku day mar kale ama hubi koodhka baaritaanka.',
      'location_migration_blocked':
          'Server-ku hadda ma dhammaystiri karo beddelkan. Aaladda iyo aqoonsigeeda maxalliga ah waa la ilaaliyay.',
      'location_migration_slow':
          'Server-ku weli wuu diyaarinayaa wareejinta ku wajahan $target. Wax yar ka dib isticmaal “Dib u sii wad”.',
      'location_migration_conflict':
          'Xaaladda aaladda ayaa server-ka ku isbeddeshay. Cusboonaysii aaladaha, kadibna dib u sii wad beddelka.',
      'location_migration_verification_failed':
          'Server-ku ma xaqiijin goobta cusub. Aqoonsigii hore ee maxalliga ahaa waa la ilaaliyay.',
      'location_migration_device_changed':
          'Aaladda server-ku soo celiyay mar dambe ma waafaqsana tan la beddelayo. Cusboonaysii aaladaha ka hor intaadan mar kale isku dayin.',
      'tunnel_stop_failed':
          'Tunnel-kii hore waa in si buuxda loo joojiyaa ka hor xidhiidhka cusub.',
      'device_clock_ahead':
          'Saacadda aaladdan waxay u muuqataa inay hore u socoto. Shid taariikhda iyo waqtiga toos ah si aanad akoonkaaga ka bixin.',
      'other':
          'Hawsha lama dhammaystiri karin. Isku day mar kale ama u dir koodhka baaritaanka kooxda taageerada.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Fadhigu wuu dhacay',
      'invalid_credentials': 'Soo galitaanku wuu fashilmay',
      'email_verification_required':
          'Xaqiijinta iimaylka ayaa loo baahan yahay',
      'verification_email_cooldown': 'Iimaylka hore ayaa la diray',
      'rate_limited': 'Isku dayo aad u badan',
      'invalid_registration': 'Macluumaadka waa in la saxaa',
      'email_exists': 'Akoon hore ayaa jira',
      'invalid_profile': 'Profiilka ma sax aha',
      'invalid_device': 'Aaladda ma sax aha',
      'invalid_location': 'Goobta lama heli karo',
      'device_limit': 'Xadka aaladaha waa la gaaray',
      'device_exists': 'Aqoonsiga VPN horeba waa la isticmaalayaa',
      'device_identity_revoked': 'Aqoonsiga VPN waa in la cusboonaysiiyaa',
      'device_location_locked': 'Beddelka goobta waa in la cusboonaysiiyaa',
      'location_migration_pending': 'Beddelka goobta ayaa socda',
      'location_migration_blocked': 'Beddelka goobta waa la xannibay',
      'target_ca_mismatch': 'Server-ka OpenVPN ma waafaqsana',
      'location_migration_conflict':
          'Beddelka goobta waa in la cusboonaysiiyaa',
      'server_full': 'Server-ku waa buuxaa',
      'capacity_unavailable': 'Goobta si ku meel gaar ah looma heli karo',
      'target_unavailable': 'Server-ka si ku meel gaar ah looma heli karo',
      'not_found': 'Shayga lama helin',
      'invalid_openvpn_csr': 'Aqoonsiga OpenVPN ma sax aha',
      'openvpn_profile_exists': 'Profiilka OpenVPN hore ayaa jira',
      'openvpn_profile_revoked': 'Profiilka OpenVPN waa la baabi’iyay',
      'openvpn_operation_pending': 'Hawsha OpenVPN waa socotaa',
      'openvpn_operation_terminal': 'Hawsha OpenVPN waa go’day',
      'openvpn_address_unavailable': 'Cinwaanka OpenVPN lama heli karo',
      'openvpn_profile_conflict': 'Isku dhac OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN lama heli karo',
      'email_delivery_unavailable': 'Iimaylka lama heli karo',
      'invalid_token': 'Xiriirka ma sax aha',
      'network_unavailable': 'Xidhiidhka internetka lama heli karo',
      'invalid_json': 'Codsiga ma sax aha',
      'invalid_api_response': 'Jawaabta server-ka ma sax aha',
      'ipv6_unavailable': 'IPv6 lama heli karo',
      'invalid_ip_families': 'Habaynta shabakadda waa la diiday',
      'other': 'Adeegga lama heli karo',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Fadhigaagu wuu dhacay. Mar kale soo gal.',
      'invalid_credentials': 'Cinwaanka iimaylka ama erayga sirta ma sax aha.',
      'email_verification_required':
          'Xaqiiji cinwaanka iimaylkaaga ka hor intaadan aalad VPN ah ku darin.',
      'invalid_registration':
          'Hubi macluumaadka iyo oggolaanshaha la codsaday.',
      'email_exists': 'Akoon ayaa hore u isticmaalay cinwaankan iimaylka.',
      'invalid_profile': 'Hubi macluumaadka profiilkaaga.',
      'invalid_device':
          'Magaca ama aqoonsiga maxalliga ah ee aaladdan ma sax aha.',
      'invalid_location':
          'Cusboonaysii liiska goobaha, kadibna isku day mar kale.',
      'device_limit':
          'Ka saar aalad hadda jirta ka hor intaadan mid kale ku darin.',
      'device_exists':
          'Aqoonsigan VPN horeba waxaa lagu xiriiriyay akoon kale.',
      'device_identity_revoked':
          'Aqoonsigan waa la tirtiray. Waa in la abuuraa aqoonsi maxalli ah oo cusub.',
      'device_location_locked':
          'Goobta aaladdan hadda ayaa la beddelay. Barnaamijku wuu dib u sii wadi doonaa beddelka socda.',
      'location_migration_pending': 'Beddel goob ayaa hore u socda.',
      'location_migration_blocked':
          'Beddelka goobta wuxuu u baahan yahay faragelin dhinaca server-ka ah. Mar dambe isku day ama la xiriir taageerada.',
      'target_ca_mismatch':
          'Server-kan weli ma waafaqsana profiilka OpenVPN ee hadda jira.',
      'location_migration_conflict':
          'Cusboonaysii aaladaha, kadibna mar kale isku day beddelka goobta.',
      'server_full':
          'Goobtan waxay gaartay xadka xidhiidhada. Dooro goob kale ama mar dambe isku day.',
      'capacity_unavailable':
          'Hadda ma xaqiijin karno in goobtan la heli karo. Dooro goob kale ama mar dambe isku day.',
      'target_unavailable': 'Server-kan si ku meel gaar ah looma heli karo.',
      'not_found': 'Shaygan mar dambe kuma jiro akoonkaaga.',
      'invalid_openvpn_csr':
          'Samee aqoonsi OpenVPN oo cusub, kadibna isku day mar kale.',
      'openvpn_profile_exists':
          'Profiil OpenVPN ah ayaa hore ugu jiray aaladdan.',
      'openvpn_profile_revoked':
          'Cusboonaysii profiilka OpenVPN si aad u sii waddo.',
      'openvpn_operation_pending':
          'Isbeddelku weli wuu faafayaa. Mar dambe isku day.',
      'openvpn_operation_terminal':
          'Samee aqoonsi OpenVPN oo cusub, kadibna isku day mar kale.',
      'openvpn_address_unavailable':
          'Hadda ma jiro cinwaan OpenVPN ah oo la heli karo.',
      'openvpn_profile_conflict':
          'Profiilka waa isbeddelay. Cusboonaysii aaladaha, kadibna isku day mar kale.',
      'openvpn_signer_unavailable':
          'Adeegga OpenVPN si ku meel gaar ah looma heli karo.',
      'email_delivery_unavailable':
          'Iimaylka lama diri karin. Mar dambe isku day.',
      'invalid_token': 'Xiriirkan ma sax aha ama wuu dhacay. Codso mid cusub.',
      'network_unavailable':
          'Hubi xidhiidhkaaga internetka, kadibna isku day mar kale.',
      'invalid_json':
          'Hubi macluumaadka aad gelisay, kadibna isku day mar kale.',
      'invalid_api_response':
          'Server-ku wuxuu soo celiyay jawaab aan la filayn. Mar dambe isku day.',
      'ipv6_unavailable':
          'Server-ku hadda ma shidi karo IPv6. Mar dambe isku day.',
      'invalid_ip_families':
          'Habaynta tunnel-ka ma dhammaystirna ama ma waafaqsana cinwaannada la oggolaaday. Barnaamijka ka isku day mar kale.',
      'other': 'Khalad dhinaca server-ka ah ayaa dhacay. Mar dambe isku day.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Wax yar ka dib mar kale isku day.';

  @override
  String notice_retryAfter(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Mar kale isku day $seconds ilbiriqsi ka dib.',
      one: 'Mar kale isku day $seconds ilbiriqsi ka dib.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Mar kale isku day $minutes daqiiqo ka dib.',
      one: 'Mar kale isku day $minutes daqiiqo ka dib.',
    );
    return '$_temp0';
  }

  @override
  String notice_retryAfterHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Mar kale isku day $hours saac ka dib.',
      one: 'Mar kale isku day $hours saac ka dib.',
    );
    return '$_temp0';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Dib u bilaabista VPN-ka nidaamka lama heli karo',
      'system_vpn_resume_corrupt':
          'Dib u bilaabista VPN-ka nidaamka ma sax aha',
      'system_vpn_resume_session_invalid':
          'Fadhiga dib u bilaabista VPN ma sax aha',
      'system_vpn_resume_identity_changed': 'Aqoonsiga VPN waa isbeddelay',
      'system_vpn_resume_identity_invalid':
          'Aqoonsiga dib u bilaabista VPN ma sax aha',
      'system_vpn_resume_storage_failed':
          'Kaydka dib u bilaabista VPN lama heli karo',
      'system_vpn_resume_network_timeout':
          'Dib u bilaabista VPN shabakad ma jirto',
      'system_vpn_resume_blocked': 'Dib u bilaabista VPN waa la xannibay',
      'system_vpn_resume_failed': 'Dib u bilaabista VPN way guuldareysatay',
      'system_vpn_resume_error_invalid':
          'Khaladka dib u bilaabista VPN ma sax aha',
      'wireguard_identity_store_failed': 'Aqoonsiga WireGuard lama kaydin',
      'wireguard_identity_unavailable': 'Aqoonsiga WireGuard lama heli karo',
      'vpn_host_destroyed': 'Qaybta VPN ee Android waa la joojiyay',
      'vpn_host_unavailable': 'Qaybta VPN ee Android lama heli karo',
      'vpn_permission_required': 'Oggolaansho VPN ayaa loo baahan yahay',
      'vpn_permission_denied': 'Oggolaanshaha VPN waa la diiday',
      'vpn_permission_request_failed': 'Oggolaansho lama codsan karin',
      'wireguard_foreground_service_unavailable':
          'Adeegga WireGuard lama heli karo',
      'wireguard_identity_invalid':
          'Furaha WireGuard ee maxalliga ah ma sax aha',
      'wireguard_identity_in_use':
          'Aqoonsiga WireGuard horeba waa la isticmaalayaa',
      'wireguard_configuration_invalid': 'Habaynta WireGuard ma sax aha',
      'wireguard_operation_pending': 'Hawsha WireGuard weli waa socotaa',
      'wireguard_start_failed': 'Bilaabista WireGuard waa la diiday',
      'wireguard_stop_timeout': 'Joojinta WireGuard lama xaqiijin',
      'wireguard_handshake_timeout': 'WireGuard ma jawaabin',
      'openvpn_connection_timeout': 'OpenVPN ma jawaabin',
      'openvpn_core_unavailable': 'Mishiinka OpenVPN lama heli karo',
      'openvpn_operation_pending': 'Fadhiga OpenVPN weli waa firfircoon yahay',
      'openvpn_stop_timeout': 'Joojinta OpenVPN lama xaqiijin',
      'openvpn_profile_unavailable':
          'Profiilka OpenVPN ee maxalliga ah ma jiro',
      'openvpn_native_failed': 'Wicitaanka asalka ah ee OpenVPN wuu go’ay',
      'openvpn_key_generation_failed': 'Furaha OpenVPN P-256 lama abuuri karin',
      'openvpn_csr_generation_failed': 'CSR-ka OpenVPN lama abuuri karin',
      'openvpn_identity_store_failed': 'Aqoonsiga OpenVPN lama kaydin',
      'openvpn_identity_clear_failed': 'Ka saarista OpenVPN ma dhammaystirna',
      'openvpn_identity_in_use': 'Aqoonsiga OpenVPN weli waa la isticmaalayaa',
      'openvpn_tls_verification_required':
          'Xaqiijinta TLS ee OpenVPN way maqan tahay',
      'openvpn_cipher_invalid': 'Habka sirinta OpenVPN ma sax aha',
      'openvpn_profile_rejected': 'Profiilka OpenVPN waa la diiday',
      'openvpn_identity_inconsistent': 'Aqoonsiga OpenVPN isma waafaqsana',
      'tls_handshake_failed': 'Wada-xaajoodka OpenVPN waa la diiday',
      'tls_alert_unknown_ca': 'Shahaadada macmiilka OpenVPN lama aqoonsan',
      'tls_alert_bad_certificate': 'Shahaadada macmiilka OpenVPN waa la diiday',
      'tls_alert_unsupported_certificate': 'Shahaadada OpenVPN lama taageero',
      'tls_client_certificate_required':
          'Shahaado macmiil OpenVPN ayaa loo baahan yahay',
      'tls_alert_misc': 'Digniinta TLS ee OpenVPN',
      'tls_signature_algorithm_rejected': 'Saxiixa OpenVPN lama taageero',
      'tls_handshake_rejected': 'Wada-xaajoodka TLS ee OpenVPN waa la diiday',
      'tls_version_rejected': 'Nooca TLS ee OpenVPN ma waafaqsana',
      'tls_certificate_expired': 'Shahaadada TLS way dhacday',
      'tls_certificate_revoked': 'Shahaadada TLS waa la baabi’iyay',
      'transport_failed': 'Server-ka OpenVPN lama gaari karo',
      'tun_configuration_rejected': 'Interface-ka OpenVPN lama abuuri karin',
      'tun_setup_failed': 'Diyaarinta TUN ee OpenVPN way guuldareysatay',
      'tun_interface_create_failed':
          'Abuurista interface-ka OpenVPN way guuldareysatay',
      'tun_interface_disabled': 'Interface-ka OpenVPN waa la damiyay',
      'tun_halted': 'Interface-ka OpenVPN wuu go’ay',
      'tun_already_established': 'Interface-ka OpenVPN horeba wuu furan yahay',
      'tun_addresses_missing': 'Cinwaanka OpenVPN wuu maqan yahay',
      'tun_routes_missing': 'Jidadka OpenVPN way maqan yihiin',
      'tun_dns_missing': 'DNS-ka OpenVPN wuu maqan yahay',
      'tun_permission_revoked': 'Oggolaanshaha VPN waa la baabi’iyay',
      'tun_establish_returned_null': 'Android wuu diiday interface-ka VPN',
      'openvpn_service_start_failed': 'Adeegga OpenVPN lama heli karo',
      'openvpn_operation_timeout':
          'Wicitaanka OpenVPN wuu dhaafay waqtigii loogu talagalay',
      'openvpn_start_failed': 'Bilaabista OpenVPN waa la diiday',
      'openvpn_connection_failed': 'Xidhiidhka OpenVPN wuu go’ay',
      'openvpn_core_status_error': 'OpenVPN Core wuxuu ku dhammaaday khalad',
      'openvpn_stopped_before_connected':
          'OpenVPN wuu joogsaday ka hor inta aan la ku xidhin',
      'openvpn_auth_failed': 'Xaqiijinta aqoonsiga OpenVPN waa la diiday',
      'openvpn_client_setup_failed':
          'Diyaarinta macmiilka OpenVPN way guuldareysatay',
      'openvpn_client_halted': 'Macmiilka OpenVPN wuu go’ay',
      'openvpn_client_restart': 'Dib u bilaabista OpenVPN waa la codsaday',
      'openvpn_inactive_timeout': 'OpenVPN waqti dheer ma firfircoonayn',
      'openvpn_session_expired': 'Fadhiga OpenVPN wuu dhacay',
      'openvpn_credentials_required': 'Xaqiijinta OpenVPN lama taageero',
      'openvpn_proxy_failed': 'Gudbinta dhexe ee OpenVPN way guuldareysatay',
      'openvpn_compression_failed': 'Cadaadinta OpenVPN waa la diiday',
      'openvpn_ntlm_crypto_unavailable':
          'Sirinta NTLM ee OpenVPN lama heli karo',
      'openvpn_feature_unsupported': 'Sifada OpenVPN lama taageero',
      'network_unavailable': 'Xidhiidhka internetka lama heli karo',
      'network_lost': 'Shabakadda lama heli karo',
      'certificate_validation_failed': 'Shahaadada server-ka waa la diiday',
      'openvpn_certificate_expired': 'Shahaadada OpenVPN way dhacday',
      'tunnel_active_for_another_account':
          'Tunnel-ka akoon kale weli wuu firfircoon yahay',
      'tunnel_already_active':
          'Tunnel-ka asalka ah horeba wuu firfircoon yahay',
      'tunnel_stop_timeout': 'Joojinta $protocol lama xaqiijin',
      'tunnel_disconnected': '$protocol wuu go’ay',
      'native_bridge_unavailable': 'Buundada Android lama heli karo',
      'native_operation_failed': 'Hawsha Android waa go’day',
      'invalid_arguments': 'Halbeegyada VPN ma dhammaystirna',
      'invalid_account_id': 'Akoonka VPN ma sax aha',
      'invalid_device_id': 'Aqoonsiga aaladda ma sax aha',
      'storage_key_not_allowed': 'Furaha kaydka waa la diiday',
      'secure_storage_read_failed': 'Akhrinta ammaanka ah way guuldareysatay',
      'secure_storage_write_failed': 'Qorista ammaanka ah way guuldareysatay',
      'key_generation_failed': 'Furaha WireGuard lama abuuri karin',
      'csr_generation_failed': 'CSR-ka OpenVPN lama abuuri karin',
      'openvpn_recovery_exhausted':
          'Soo kabashada OpenVPN horeba waa la isticmaalay',
      'openvpn_recovery_failed': 'Soo kabashada OpenVPN way guuldareysatay',
      'openvpn_renewal_required':
          'Cusboonaysiinta shahaadada OpenVPN ayaa loo baahan yahay',
      'other': 'Khalad VPN oo aan la kala saarin',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ma helin fadhi VPN oo dib loo sii wadi karo. Barnaamijka ka bilow xidhiidh cusub.',
      'system_vpn_resume_corrupt':
          'Xogta la kaydiyay ee dib u bilaabista VPN ma sax aha, lamana isticmaali doono. Bilow xidhiidh cusub.',
      'system_vpn_resume_session_invalid':
          'Fadhiga la kaydiyay mar dambe ma dib u bilaabi karo VPN-ka. Barnaamijka ka soo gal mar kale.',
      'system_vpn_resume_identity_changed':
          'Aqoonsiga VPN ee maxalliga ah waa isbeddelay. Dib u bilaabistii waa la joojiyay; bilow xidhiidh cusub.',
      'system_vpn_resume_identity_invalid':
          'Aqoonsiga dib u bilaabista ma sax aha. Bilow xidhiidh cusub.',
      'system_vpn_resume_storage_failed':
          'Android ma akhriyi karin ama ma cusboonaysiin karin xogta dib u bilaabista ee la sireeyay. Bilow xidhiidh cusub.',
      'system_vpn_resume_network_timeout':
          'Android shabakad kuma helin waqtigii loogu talagalay si VPN-ka dib loogu bilaabo. Isku day mar kale marka shabakad la heli karo.',
      'system_vpn_resume_blocked':
          'Dib u bilaabista VPN waa la xannibay. Hubi dejinta Android, kadibna bilow xidhiidh cusub.',
      'system_vpn_resume_failed':
          'Dib u bilaabista VPN ee Android way guuldareysatay. Barnaamijka ka bilow xidhiidh cusub.',
      'system_vpn_resume_error_invalid':
          'Android wuxuu soo celiyay khalad dib u bilaabis oo aan la isticmaali karin. Bilow xidhiidh cusub.',
      'wireguard_identity_store_failed':
          'Android ma kaydin karin aqoonsiga WireGuard ee la sireeyay ee akoonkan.',
      'wireguard_identity_unavailable':
          'Xidhiidhkan ma laha aqoonsi WireGuard oo la isticmaali karo.',
      'vpn_host_destroyed':
          'Qaybta Android ee martigelisay VPN-ka waa la joojiyay. Bilow xidhiidh cusub.',
      'vpn_host_unavailable':
          'Android ma abuuri karo qaybta martigelinaysa VPN-ka. Hubi dejinta VPN, kadibna isku day mar kale.',
      'openvpn_renewal_required':
          'Shahaadadu waxay u baahan tahay tallaabo laga qaado barnaamijka ka hor inta aan la ku xidhin.',
      'openvpn_recovery_failed':
          'Soo kabashada toos ah way guuldareysatay. Barnaamijka ka bilow xidhiidh cusub.',
      'openvpn_recovery_exhausted':
          'Soo kabashada toos ah horeba waa la isticmaalay. Barnaamijka ka bilow xidhiidh cusub.',
      'vpn_permission_required':
          'Android wuxuu u baahan yahay oggolaansho VPN oo cusub ka hor inta aan tunnel-ka la bilaabin.',
      'vpn_permission_denied':
          'Codsiga Android ku oggolow FuzeVPN si aad u sii waddo.',
      'vpn_permission_request_failed':
          'Android ma furi karin shaashadda oggolaanshaha VPN.',
      'wireguard_foreground_service_unavailable':
          'Android ma ku sii hayn karin adeegga WireGuard oo hore u socda.',
      'wireguard_identity_invalid':
          'Furaha WireGuard ee la sireeyay ee akoonkan lama akhriyi karo ama ma sax aha.',
      'wireguard_identity_in_use':
          'Hawl kale ayaa weli isticmaalaysa furaha WireGuard ee akoonkan.',
      'wireguard_configuration_invalid':
          'Cinwaanka WireGuard, DNS-ka, furaha server-ka ama jidadka la helay ma sax aha.',
      'wireguard_operation_pending':
          'Hawshii hore ee WireGuard weli ma sii deyn adeeggeeda asalka ah.',
      'wireguard_start_failed':
          'Mishiinka WireGuard wuu diiday hawlgelinta habaynta.',
      'wireguard_stop_timeout':
          'Adeegga WireGuard ma xaqiijin inuu sii daayay interface-ka VPN muddada loo cayimay gudaheeda.',
      'wireguard_handshake_timeout':
          'Tunnel-ku ma xaqiijin isweydaarsiga ammaanka ah ee server-ka waqtigii loogu talagalay.',
      'openvpn_connection_timeout':
          'OpenVPN ma xaqiijin xidhiidhka server-ka waqtigii loogu talagalay.',
      'openvpn_core_unavailable':
          'Nooca barnaamijkan kuma jiro mishiin OpenVPN oo la isticmaali karo.',
      'openvpn_operation_pending':
          'Mishiinka asalka ah weli wuxuu haystaa fadhigii hore ee OpenVPN, wuuna diiday inuu abuuro mid labaad.',
      'openvpn_stop_timeout':
          'OpenVPN Core ma xaqiijin in fadhigiisa asalka ah la joojiyay oo la baabi’iyay muddada loo cayimay gudaheeda.',
      'openvpn_profile_unavailable':
          'Xidhiidhkan lama akhriyi karo profiil OpenVPN oo la xaqiijiyay.',
      'openvpn_native_failed':
          'Khalad barnaamij ayaa hakiyay OpenVPN. Isku day inaad mar kale ku xidhanto. Haddii dhibaatadu sii socoto, samee baaritaan.',
      'openvpn_key_generation_failed':
          'Android Keystore ma abuuri karin ama ma akhriyi karin furaha gaarka ah ee P-256 ee aan la dhoofin karin.',
      'openvpn_csr_generation_failed':
          'Furaha Android Keystore ma saxiixi karin codsiga shahaadada OpenVPN.',
      'openvpn_identity_store_failed':
          'Shahaadada ama profiilka OpenVPN lama kaydin karin kaydka la sireeyay.',
      'openvpn_identity_clear_failed':
          'Android ma saari karin aqoonsiga OpenVPN ee maxalliga ah ee akoonkan oo dhan.',
      'openvpn_identity_in_use':
          'Fadhi OpenVPN oo asal ah ayaa weli isticmaalaya furaha ama shahaadada aaladdan.',
      'openvpn_tls_verification_required':
          'Profiilku si cad ugama baahna xaqiijinta shahaadada server-ka.',
      'openvpn_cipher_invalid':
          'Server-ku wuxuu bixiyay algorithm sirin ah oo aan ku jirin liiska la oggolaaday.',
      'openvpn_profile_rejected':
          'Profiilka laga helay server-ka ma waafaqsana. Dib u abuur aaladdan, kadibna isku day mar kale.',
      'openvpn_identity_inconsistent':
          'Shahaadadu ma waafaqsana aqoonsiga ammaanka ah ee taleefankan. Profiil maxalli ah lama beddelin.',
      'tls_handshake_failed':
          'Server-ku wuu diiday wada-xaajoodka TLS. Haddii dhibaatadu sii socoto, dib u abuur profiilka.',
      'tls_alert_unknown_ca':
          'Server-ku ma aqoonsado hay’adda soo saartay shahaadada aaladdan. Server-ka OpenVPN waa in la hubiyaa.',
      'tls_alert_bad_certificate':
          'Server-ku wuu diiday shahaadada aaladdan. Dib u abuur aaladda ka hor intaadan mar kale isku dayin.',
      'tls_alert_unsupported_certificate':
          'Server-ku ma taageero nooca shahaadada ammaanka ah ee Android isticmaalo.',
      'tls_client_certificate_required':
          'Server-ku wuxuu u baahan yahay shahaado macmiil, laakiin OpenVPN Core ma soo bandhigi karin mid.',
      'tls_alert_misc':
          'Server-ku wuxuu soo celiyay digniin TLS ah oo ka baxsan qaybaha shahaadada iyo nooca.',
      'tls_signature_algorithm_rejected':
          'Server-ku wuu diiday algorithm-ka ECDSA P-256 ee furaha Android Keystore.',
      'tls_handshake_rejected':
          'Server-ku wuu hakiyay wada-xaajoodka TLS ka hor xidhiidhka.',
      'tls_version_rejected':
          'Macmiilka iyo server-ku ma helin nooc TLS oo wadaag ah.',
      'tls_certificate_expired':
          'Shahaadada la soo bandhigay inta xidhiidhku socday way dhacday.',
      'tls_certificate_revoked':
          'Shahaadada la soo bandhigay inta xidhiidhku socday waa la baabi’iyay.',
      'transport_failed':
          'Server-ka OpenVPN ma jawaabayo shabakadda hadda jirta. Wax yar ka dib isku day mar kale.',
      'tun_configuration_rejected':
          'Android wuxuu diiday habaynta shabakadda ee OpenVPN uu codsaday.',
      'tun_setup_failed':
          'OpenVPN Core wuu diiday qorshaha shabakadda ka hor inta uusan abuurin interface-ka Android.',
      'tun_interface_create_failed':
          'OpenVPN Core ma heli karin interface-ka TUN ee VpnService ee Android.',
      'tun_interface_disabled':
          'Android ama OpenVPN Core ayaa damiyay interface-ka TUN inta xidhiidhku socday.',
      'tun_halted':
          'OpenVPN Core wuxuu helay codsi uu ku joojinayo interface-ka TUN.',
      'tun_already_established':
          'OpenVPN wuxuu codsaday interface labaad isla xidhiidhkaas. Tunnel-ka amni darteed waa la joojiyay.',
      'tun_addresses_missing':
          'Server-ku ma bixin cinwaan tunnel oo la isticmaali karo.',
      'tun_routes_missing':
          'Server-ku ma bixin jidad tunnel oo la isticmaali karo.',
      'tun_dns_missing':
          'Server-ku ma bixin server DNS ah oo la isticmaali karo.',
      'tun_permission_revoked':
          'Android wuu baabi’iyay oggolaanshaha VPN inta xidhiidhku socday.',
      'tun_establish_returned_null':
          'Android ma abuurin interface-ka, badanaaba sababta oo ah VPN kale ayaa weli firfircoon.',
      'openvpn_service_start_failed':
          'Android ma bilaabi karin adeegga OpenVPN oo hore u socda.',
      'openvpn_operation_timeout':
          'Wicitaan JNI ah oo loo diray OpenVPN Core ayaa dhaafay muddadiisa ugu badan.',
      'openvpn_start_failed':
          'Adeegga Android waa diyaar, laakiin OpenVPN Core ma aqbalin bilaabista profiilka.',
      'openvpn_connection_failed':
          'OpenVPN Core wuu joogsaday ka hor inta uusan soo saarin dhacdada CONNECTED.',
      'openvpn_core_status_error':
          'Wareegga OpenVPN ee asalka ah wuxuu ku dhammaaday khalad, dhacdo dhammaad oo gaar ah oo kale ma jirin.',
      'openvpn_stopped_before_connected':
          'Wareegga OpenVPN ee asalka ah wuu joogsaday ka hor CONNECTED, iyadoo aan khalad Core oo cad jirin.',
      'openvpn_auth_failed':
          'Server-ka OpenVPN wuu diiday xaqiijinta aqoonsiga profiilka.',
      'openvpn_client_setup_failed':
          'OpenVPN Core ma diyaarin karin macmiilka ka hor xidhiidhka shabakadda.',
      'openvpn_client_halted':
          'OpenVPN Core wuxuu helay joojin macmiil oo kama dambays ah.',
      'openvpn_client_restart':
          'OpenVPN Core wuxuu codsaday in fadhiga gudbintiisa dib loo bilaabo.',
      'openvpn_inactive_timeout':
          'OpenVPN Core wuu xidhay fadhiga ka dib marka muddada aan la shaqayn dhammaatay.',
      'openvpn_session_expired':
          'Server-ku wuxuu sheegay in fadhiga OpenVPN uu dhacay.',
      'openvpn_credentials_required':
          'Server-ka ama proxy-ga ayaa codsanaya aqoonsiyo lagu geliyo gacanta oo aan ka mid ahayn profiilka shahaadada.',
      'openvpn_proxy_failed':
          'OpenVPN Core wuxuu sheegay guuldarro ku timid proxy-ga ama relay-ga la habeeyay.',
      'openvpn_compression_failed':
          'OpenVPN Core wuu diiday habka cadaadinta ee profiilka ama server-ku ku dhawaaqay.',
      'openvpn_ntlm_crypto_unavailable':
          'Profiilku wuxuu codsanayaa sirinta NTLM, taas oo aan ku jirin nooca hadda jira.',
      'openvpn_feature_unsupported':
          'Profiilka ama server-ku wuxuu u baahan yahay sifo ka maqan macmiilkan Android.',
      'network_unavailable': 'Ma jirto shabakad jireed oo la isticmaali karo.',
      'network_lost':
          'Tunnel-ka waa la joojiyay ka dib marka shabakadda la waayay.',
      'certificate_validation_failed':
          'Aqoonsiga server-ka OpenVPN lama xaqiijin karin.',
      'openvpn_certificate_expired':
          'Cusboonaysii profiilka OpenVPN ka hor inta aadan dib ugu xidhmin.',
      'tunnel_active_for_another_account':
          'Tunnel ka tirsan akoon kale waa in la joojiyaa ka hor xidhiidhkan.',
      'tunnel_already_active':
          'Android wuxuu sheegayaa in fadhi VPN oo hore uu weli isticmaalayo interface-ka.',
      'tunnel_stop_timeout':
          'Mishiinka $protocol ma xaqiijin inuu sii daayay interface-ka VPN muddada loo cayimay gudaheeda.',
      'tunnel_disconnected':
          'Mishiinka asalka ah wuxuu sheegay in tunnel-ku si lama filaan ah u dhammaaday kadib bilaabistiisa.',
      'native_bridge_unavailable':
          'Barnaamijku ma gali karo adeegga VPN ee Android. Xidh barnaamijka, kadibna mar kale fur oo isku day.',
      'native_operation_failed':
          'Khalad barnaamij ayaa hakiyay hawsha VPN. Isku day mar kale. Haddii dhibaatadu sii socoto, samee baaritaan.',
      'invalid_arguments':
          'Macluumaadka loo baahan yahay hawshan VPN ma dhammaystirna. Isku day mar kale. Haddii dhibaatadu sii socoto, samee baaritaan.',
      'invalid_account_id':
          'Hawsha asalka ah lama xiriirin aqoonsi akoon oo sax ah.',
      'invalid_device_id':
          'Aqoonsiga aaladda ee loo diray mishiinka asalka ah wuu maqan yahay ama ma sax aha.',
      'storage_key_not_allowed':
          'Buundada Android waxay xannibtay fure ka baxsan liiska kaydka la oggolaaday.',
      'secure_storage_read_failed':
          'Android Keystore ma furi karin sirinta xogta maxalliga ah ee akoonkan.',
      'secure_storage_write_failed':
          'Android Keystore ma sirin karin ama ma kaydin karin xogta maxalliga ah.',
      'key_generation_failed':
          'Android ma abuuri karin ama ma akhriyi karin furaha WireGuard ee kaydka ammaanka ah.',
      'csr_generation_failed':
          'Android Keystore ma abuuri karin ama ma saxiixi karin CSR-ka OpenVPN P-256.',
      'other':
          'Qayb asal ah oo aan la dukumeentiyin ayaa guuldareysatay. U dir koodhka baaritaanka ee hoos ku muuqda kooxda taageerada.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Codsiga oggolaanshaha horeba waa furan yahay';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Codsiga oggolaanshaha VPN ee Android hadda waa soo muuqdaa. Dhammaystir ka hor intaadan mar kale isku dayin.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Codsiga oggolaanshaha VPN wuu go’ay';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Shaashadda oggolaanshaha VPN waa la xidhay ka hor intaanu barnaamijku jawaab helin.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Xidhiidhka OpenVPN lama xaqiijin';

  @override
  String get notice_openvpnProofMissing_message =>
      'Xidhiidhka OpenVPN lama xaqiijin karin. Amni darteed waa la joojiyay. Isku day mar kale.';

  @override
  String get openvpnCleanup_title => 'Profiilka OpenVPN waa la baabi’iyay';

  @override
  String get openvpnCleanup_working =>
      'Profiilka OpenVPN ee la baabi’iyay waa la joojinayaa oo la tirtirayaa…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Joojinta OpenVPN lama xaqiijin. Isku day mar kale ka hor intaadan abuurin profiil cusub.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Profiilka OpenVPN ee la baabi’iyay gebi ahaanba lama tirtiri karin. Isku day nadiifinta mar kale.';

  @override
  String get openvpnCleanup_complete =>
      'Profiilka OpenVPN ee la baabi’iyay waa la tirtiray. Taabo “Ku xidh” si aad mid cusub u abuurto.';

  @override
  String get network_title => 'Habaynta shabakadda';

  @override
  String get network_ipv4Fallback =>
      'IPv6 si ku meel gaar ah looma heli karo. Diyaarintu waxay ku sii socotaa IPv4.';

  @override
  String get network_rejectedTitle => 'Habaynta shabakadda waa la diiday';

  @override
  String get network_rejectedMessage =>
      'Habaynta tunnel-ka ma dhammaystirna ama ma waafaqsana cinwaannada la oggolaaday. Barnaamijka ka isku day mar kale.';

  @override
  String get network_unreadableTitle =>
      'Habaynta maxalliga ah lama akhriyi karo';

  @override
  String get network_unreadableMessage =>
      'Habaynta shabakadda OpenVPN ee la kaydiyay lama isticmaali karo. Barnaamijka ka dib ku xidh si aad u cusboonaysiiso.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Ilaalinta shabakadda';

  @override
  String get protection_subtitle =>
      'Xannib gelitaanka toos ah ee internetka haddii VPN-ku go’o.';

  @override
  String get protection_active => 'Ilaalinta nidaamka way firfircoon tahay';

  @override
  String get protection_alwaysOnOnly =>
      '“VPN had iyo jeer” waa la shiday; shid xannibaadda xidhiidhada aan VPN lahayn';

  @override
  String get protection_inactive => 'Ilaalinta nidaamka ma firfircoona';

  @override
  String get protection_unknown => 'Hubi ilaalinta nidaamka';

  @override
  String get protection_openSettings => 'Fur dejinta Android';

  @override
  String get protection_dialogTitle => 'Deji ilaalinta shabakadda';

  @override
  String get protection_dialogMessage =>
      'Android ayaa maamula “VPN had iyo jeer” iyo xannibidda xidhiidhada ka baxsan VPN-ka. Hubi in FuzeVPN la doortay, kadibna dejinta nidaamka ka shid xannibaadda.';

  @override
  String get protection_dialogOpen => 'Fur dejinta';

  @override
  String get session_systemProtectionNote =>
      'Haddii Android weli xannibayo socodka ka baxsan VPN-ka, fur dejinta nidaamka si aad u hubiso ama u beddesho ilaalintan.';

  @override
  String get diagnostics_title => 'Baaritaan';

  @override
  String get diagnostics_settingsTitle => 'Baaritaanka barnaamijka';

  @override
  String get diagnostics_automaticTitle => 'Dir khaladaadka muhiimka ah';

  @override
  String get diagnostics_automaticDescription =>
      'La wadaag warbixin farsamo oo yar marka khalad muhiim ah dhaco.';

  @override
  String get diagnostics_privacy =>
      'Warbixinnada la diro waxay ku xiran yihiin akoonka aad soo gashay, waxaana la hayaa 30 maalmood. Kuma jiraan taariikhda bogagga aad booqatay, erayada sirta ah ama furayaasha VPN.';

  @override
  String get diagnostics_manualOpen => 'Samee baaritaan';

  @override
  String get diagnostics_localDescription =>
      'Samee warbixin ku saabsan xaaladda barnaamijka iyo VPN-ka. Xidhiidhkaaga lama beddelayo.';

  @override
  String get diagnostics_sendReport => 'Dir warbixinta';

  @override
  String get diagnostics_sendHint =>
      'Sanduuqan ha calaamadin si warbixinta aaladdan loogu hayo.';

  @override
  String get diagnostics_signedOut =>
      'Si aad warbixin u dirto, soo gal akoonkaaga.';

  @override
  String get diagnostics_localLifetime =>
      'Ku kaydi warbixintan taleefankaaga si aad ugu hayso ka dib marka aad barnaamijka xidho.';

  @override
  String get diagnostics_run => 'Samee baaritaan';

  @override
  String get diagnostics_rerun => 'Mar kale samee baaritaan';

  @override
  String get diagnostics_running => 'Waa la hubinayaa…';

  @override
  String get diagnostics_sending => 'Warbixinta waa la dirayaa…';

  @override
  String get diagnostics_prepared =>
      'Warbixinta waxay diyaar ku tahay aaladdan';

  @override
  String get diagnostics_queued => 'Warbixinta waxay sugaysaa in la diro';

  @override
  String get diagnostics_sent => 'Warbixinta waa la helay';

  @override
  String get diagnostics_failed =>
      'Dirista way guuldareysatay. Warbixintaada maxalliga ah weli way diyaar tahay.';

  @override
  String get diagnostics_preparationFailed =>
      'Warbixinta baaritaanka lama diyaarin karin. Isku day mar kale.';

  @override
  String get diagnostics_authenticationRequired =>
      'Mar kale soo gal si aad warbixinta u dirto.';

  @override
  String get diagnostics_retry => 'Isku day dirista mar kale';

  @override
  String get diagnostics_export => 'Kaydi warbixinta';

  @override
  String get diagnostics_exportFailed =>
      'Kaydintu way guuldareysatay. Mar kale isku day warbixinta maxalliga ah.';

  @override
  String get diagnostics_preferenceFailed =>
      'Dejintan lama kaydin karin. Isku day mar kale.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Tixraac: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'La helay $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'La hayaa ilaa $date';
  }

  @override
  String get diagnostics_duplicate => 'Warbixintan horeba waa la helay.';

  @override
  String get diagnostics_preview => 'Hordhaca warbixinta';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dhacdo farsamo ah ayaa la lifaaqay',
      one: '1 dhacdo farsamo ah ayaa la lifaaqay',
      zero: 'Ma jiraan dhacdooyin farsamo oo la lifaaqay',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Faahfaahinta farsamada';

  @override
  String get diagnostics_empty => 'Weli lama diyaarin warbixin baaritaan.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Xaaladda tunnel-ka',
      'handshake': 'Xaqiijinta xidhiidhka',
      'certificate': 'Shahaadada VPN',
      'kill_switch': 'Ilaalinta Android',
      'connectivity': 'Shabakadda la heli karo',
      'api_reachability': 'Gelitaanka adeegga',
      'secure_storage': 'Kaydinta ammaanka ah',
      'other': 'Hubinta maxalliga ah',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'La hubiyay',
      'failed': 'Fiiro gaar ah ayaa loo baahan yahay',
      'skipped': 'Lama tijaabin — baadhis firfircoon ma jiro',
      'unknown': 'Macluumaadka lama heli karo',
      'other': 'Macluumaadka lama heli karo',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Ku soo dhawoow FuzeVPN';

  @override
  String get connection_changeLocation => 'Beddel goobta';

  @override
  String get connection_details => 'Faahfaahinta xidhiidhka';

  @override
  String get locations_searchLabel => 'Raadi magaalo ama dal';

  @override
  String get locations_clearSearch => 'Tirtir raadinta';

  @override
  String get locations_filterAll => 'Dhammaan';

  @override
  String get locations_filterFavorites => 'Kuwa la jecel yahay';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count goob',
      one: '$count goob',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Goob lama helin';

  @override
  String get locations_noResultsHint => 'Isku day magaalo ama dal kale.';

  @override
  String get locations_noFavorites => 'Kuwa aad jeceshahay, gacantaada ku dhow';

  @override
  String get locations_noFavoritesHint =>
      'Taabo xiddigta ku xigta goob si aad halkan ugu kaydiso.';

  @override
  String get locations_showAll => 'Eeg dhammaan goobaha';

  @override
  String locations_addFavorite(String name) {
    return 'Ku dar $name kuwa la jecel yahay';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Ka saar $name kuwa la jecel yahay';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Goobta la jecel yahay lama kaydin karin. Isku day mar kale.';

  @override
  String get locations_emptyTitle => 'Ma jiraan goobo la heli karo';

  @override
  String get locations_emptyHint =>
      'Cusboonaysii liiska si aad mar kale isku daydo.';

  @override
  String get devices_manage => 'Maamul aaladahayga';

  @override
  String get settings_personalization => 'Ka dhig mid adiga kuu gaar ah';

  @override
  String get settings_safety => 'Ilaalinta';

  @override
  String get settings_help => 'Ma u baahan tahay caawimaad?';

  @override
  String get settings_about => 'Ku saabsan FuzeVPN';

  @override
  String get diagnostics_heading => 'Garo dhibaatada xidhiidhka';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'La heli karo',
      'pending': 'Diyaarinaya',
      'revoked': 'La saaray',
      'expired': 'Dhacay',
      'other': 'Xaaladda lama heli karo',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Doorashada lama kaydin';

  @override
  String get notice_preferenceSave_message =>
      'Doorashadaada hadda waa la dabaqay, laakiin lama kaydin karin. Isku day mar kale si ay u sii jirto marka barnaamijka la xidho.';

  @override
  String get connection_androidDisconnectHint =>
      'Haddii Android uu VPN-ka firfircoon hayo, ka demi “VPN had iyo jeer” dejinta furmaysa.';

  @override
  String get protection_learnMore => 'Wax ka baro ilaalinta Android';

  @override
  String get protection_guideWhy =>
      'Ilaalintan waxay ka hortagtaa barnaamijyada inay si toos ah u isticmaalaan internetka haddii VPN-ku go’o. Waxaa lagu habeeyaa gudaha Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN had iyo jeer';

  @override
  String get protection_guideAlwaysOn =>
      'Android wuxuu ka dhigaa adeegga VPN mid shaqeynaya, wuuna dib u bilaabi karaa marka taleefanka dib loo bilaabo.';

  @override
  String get protection_guideBlockTitle => 'Xannib xidhiidhada aan VPN lahayn';

  @override
  String get protection_guideBlock =>
      'Dejintan waxay ka hortagtaa in socodka xogta VPN-ka ka baxsado, xitaa marka xidhiidhku go’o.';

  @override
  String get protection_guideWarning =>
      'Marka xannibaaddan la shido, internetka lama isticmaali karo ilaa VPN-ka lagu xidho.';

  @override
  String get protection_guideStepsTitle => 'Shid ilaalinta';

  @override
  String get protection_guideStep1 =>
      'Badhanka hoose ku fur dejinta VPN ee Android.';

  @override
  String get protection_guideStep2 =>
      'Astaanta giirka ee ku xigta FuzeVPN ku fur doorashooyinka.';

  @override
  String get protection_guideStep3 =>
      'Shid “VPN had iyo jeer”, kadibna “Xannib xidhiidhada aan VPN lahayn”, haddii doorashooyinkaasi jiraan.';

  @override
  String get protection_guideManufacturers =>
      'Magacyadu way kala duwan yihiin taleefan ilaa taleefan. Haddii loo baahdo, gudaha Dejinta ka raadi VPN, badanaaba hoosta Shabakadda & internetka.';

  @override
  String get protection_guideDisableTitle => 'Demi ilaalintan';

  @override
  String get protection_guideDisable =>
      'Isla dejintaas, demi “Xannib xidhiidhada aan VPN lahayn” si aad internetka ugu isticmaasho adigoo aan VPN isticmaalin. Sidoo kale demi “VPN had iyo jeer” haddii aadan mar dambe rabin in Android uu dib u bilaabo.';

  @override
  String get protection_guideManual =>
      'Dejintan waxaad ku doortaa gudaha Android. FuzeVPN kuuma beddelo.';

  @override
  String get locations_changeTitle => 'Ma beddelaysaa goobta?';

  @override
  String locations_changeActive(String name) {
    return 'VPN-ku wuu joogsan doonaa, kadibna wuxuu isku dayi doonaa inuu ku xidhmo $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN-ku wuxuu isku dayi doonaa inuu ku xidhmo $name.';
  }

  @override
  String get locations_confirmChange => 'Beddel oo ku xidh';

  @override
  String get locations_changeBusy =>
      'Beddel ayaa socda. Sug ka hor intaadan dooran goob kale.';

  @override
  String get locations_automaticSelection => 'Doorasho toos ah';

  @override
  String get locations_cities => 'Magaalooyin';

  @override
  String get locations_servers => 'Serverro';

  @override
  String locations_viewCities(String name) {
    return 'Eeg magaalooyinka $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Eeg serverrada $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dal',
      one: '$count dal',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count magaalo',
      one: '$count magaalo',
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
  String get locations_allCountries => 'Dhammaan dalalka';

  @override
  String get locations_backToCountries => 'Dib ugu noqo dalalka';

  @override
  String locations_backToCities(String name) {
    return 'Dib ugu noqo magaalooyinka $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Dooro $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Dooro $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Server la waafaqsan lama heli karo.';

  @override
  String get externalLink_failed =>
      'Xiriirkan lama furi karo. Waad koobiyeyn kartaa oo browser-kaaga ku furi kartaa.';

  @override
  String get externalLink_copy => 'Koobiyee xiriirka';

  @override
  String get externalLink_copied => 'Xiriirka waa la koobiyeeyay';

  @override
  String get externalLink_copyFailed =>
      'Xiriirka lama koobiyeyn karo. Dooro cinwaanka hoose.';

  @override
  String get settings_deleteAccount => 'Tirtir akoonkayga';

  @override
  String get settings_deleteAccountDetail =>
      'Eeg habka codsiga tirtirista akoonka';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Dooro isdiiwaangelintaada VPN.';

  @override
  String get billing_subscribe => 'Isdiiwaangeli';

  @override
  String get billing_choosePlan => 'Dooro qorshe si aad u sii waddo.';

  @override
  String get billing_monthly => 'Bille';

  @override
  String get billing_yearly => 'Sannadle';

  @override
  String get billing_continue => 'Ku sii wad Google Play';

  @override
  String get billing_restore => 'Soo celi iibsiyada';

  @override
  String get billing_manage => 'Maamul isdiiwaangelinta';

  @override
  String get billing_deleteAccountWarning =>
      'Haddii aad leedahay isdiiwaangelin Google Play ah, tirtirista akoonkaaga FuzeVPN ma joojinayso cusboonaysiinteeda. Cusboonaysiinta si gooni ah ugu maamul ama ku jooji Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Sii wad codsiga tirtirista akoonka';

  @override
  String get billing_refresh => 'Cusboonaysii gelitaanka';

  @override
  String get billing_loadingPlans => 'Qorshayaasha waa la soo rarayaa…';

  @override
  String get billing_unavailable =>
      'Hadda ma jiraan qorshayaal la heli karo. Mar dambe isku day.';

  @override
  String get billing_comingSoon =>
      'Isdiiwaangelinnada dhawaan ayaa la heli doonaa.';

  @override
  String get billing_priceDisclosure =>
      'Qiimaha waxaa bixiya Google Play. Wadarta ugu dambeysa iyo canshuuraha khuseeya waa la xaqiijiyaa ka hor intaadan xaqiijin.';

  @override
  String get billing_renewalMonthly =>
      'Waxaa si toos ah loo cusboonaysiiyaa bil kasta ilaa la joojiyo. Goor kasta waxaad ka joojin kartaa isdiiwaangelinnada Google Play.';

  @override
  String get billing_renewalYearly =>
      'Waxaa si toos ah loo cusboonaysiiyaa sannad kasta ilaa la joojiyo. Goor kasta waxaad ka joojin kartaa isdiiwaangelinnada Google Play.';

  @override
  String get billing_active => 'Gelitaankaaga Premium wuu firfircoon yahay';

  @override
  String billing_accessUntil(String date) {
    return 'Gelitaanku wuxuu socdaa ilaa $date.';
  }

  @override
  String get billing_webManaged =>
      'Isdiiwaangelintaada waxaa lagu maamulaa mareegta FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Isdiiwaangelintaada waxaa maamula Google Play.';

  @override
  String get billing_playOnHold =>
      'Isdiiwaangelintaada Google Play waa la hakiyay ama waxay sugaysaa lacag bixin. Fur “Maamul isdiiwaangelinta” si aad ugu hagaajiso Google Play.';

  @override
  String get billing_playReceiptUnlinked =>
      'Akoonkan Google Play horeba wuxuu leeyahay isdiiwaangelin Fuze Premium ah oo aan u firfircoonayn akoonkan FuzeVPN. Fur “Maamul isdiiwaangelinta” si aad ugu eegto Google Play.';

  @override
  String get billing_inactive => 'Isdiiwaangelin firfircoon ma jirto.';

  @override
  String get billing_checkingAccess => 'Gelitaankaaga waa la hubinayaa…';

  @override
  String get billing_restoring => 'Iibsiyada waa la soo celinayaa…';

  @override
  String get billing_pending =>
      'Lacag bixinta waa la sugayaa. Gelitaankaaga waa la hawlgelin doonaa marka la xaqiijiyo.';

  @override
  String get billing_cancelled =>
      'Iibsiga waa la joojiyay. Isdiiwaangelin cusub lama hawlgelin.';

  @override
  String get billing_verifying => 'Iibsiga waa la xaqiijinayaa…';

  @override
  String get billing_success =>
      'Isdiiwaangelinta waa la hawlgeliyay. Gelitaankaaga Premium waa diyaar.';

  @override
  String get billing_restored => 'Iibsiyadaada waa la soo celiyay.';

  @override
  String get billing_restoreEmpty =>
      'Akoonkan Google Play ma laha iibsi la soo celin karo.';

  @override
  String get billing_catalogError =>
      'Qorshayaasha lama soo rari karo. Isku day mar kale.';

  @override
  String get billing_purchaseError =>
      'Iibsiga lama bilaabi karo. Isku day mar kale.';

  @override
  String get billing_verificationError =>
      'Xaqiijinta iibsiga si ku meel gaar ah looma heli karo. Soo celi iibsiyada si aad mar kale isku daydo.';

  @override
  String get billing_restoreError =>
      'Iibsiyada lama soo celin karo. Isku day mar kale.';

  @override
  String get billing_managementError =>
      'Maamulka isdiiwaangelinta lama furi karo. Isku day mar kale.';

  @override
  String get billing_storeUnavailable =>
      'Google Play looma heli karo aaladdan.';

  @override
  String get welcome_title => 'VPN-kaaga, si fudud.';

  @override
  String get welcome_description =>
      'Ilaali xidhiidhkaaga. Asturnaantaada gacanta ku hay.';

  @override
  String get welcome_start => 'Bilow';

  @override
  String get welcome_alreadyPurchased => 'Horeba ma iibsatay?';

  @override
  String get welcome_noAccountRequired =>
      'Akoon looma baahna si aad u bilowdo.';

  @override
  String get guest_accountTitle => 'Akoonka lama xiriirin';

  @override
  String get guest_accountDescription =>
      'Soo celi iibsiyadaada adigoo isticmaalaya isla akoonka Google Play si aad isdiiwaangelintaada ugu isticmaasho aalad kale.';

  @override
  String get guest_existingSubscriberSignIn =>
      'Horeba ma isdiiwaangashay? Soo gal';

  @override
  String get guest_claimTitle => 'Ku qaado FuzeVPN meel kasta';

  @override
  String get guest_claimDescription =>
      'Samee akoon si aad isdiiwaangelintaada ugu gasho aaladahaaga kale. Tallaabadan waa ikhtiyaari.';

  @override
  String get guest_skip => 'Mar dambe';

  @override
  String get guest_activationTitle => 'Fuze Premium wuu firfircoon yahay';

  @override
  String get guest_activationDescription =>
      'Isdiiwaangelintaada waa diyaar. Isticmaal VPN-kaaga oo samee akoon goor kasta oo aad rabto.';

  @override
  String get guest_useVpn => 'Isticmaal VPN-kayga';

  @override
  String get guest_loginRequired =>
      'Iibsigan horeba waxaa lagu xiriiriyay akoon FuzeVPN ah. Soo gal akoonkaas si aad u gasho isdiiwaangelintaada.';

  @override
  String get guest_signOutWarning =>
      'Isdiiwaangelintaada waad dib u heli kartaa adigoo iibsiyada soo celinaya isla akoonka Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Akoonkaaga horeba waa la xiriiriyay. Soo gal si aad u aragto oo aad u maamusho macluumaadkaaga.';

  @override
  String get billing_acceptance =>
      'Marka aad sii wadato, waxaad aqbashaa Shuruudaha Isticmaalka iyo Siyaasadda Asturnaanta.';

  @override
  String get guest_verifyEmailReminder =>
      'Xaqiiji cinwaanka iimaylkaaga si aad akoonkaaga u ilaaliso. Waad sii isticmaali kartaa VPN-kaaga.';

  @override
  String get guest_serviceUnavailable =>
      'Adeegga si ku meel gaar ah looma heli karo. Wax yar ka dib isku day mar kale.';

  @override
  String get guest_restoreError =>
      'Iibsiyadaada lama soo celin karin. Mar kale isku day adigoo isticmaalaya akoonka Google Play ee lagu iibsaday.';

  @override
  String get guest_claimSuccess =>
      'Akoonkaaga waa la sameeyay. Isdiiwaangelintaada iyo gelitaankaaga VPN waa la ilaaliyay.';

  @override
  String get guest_emailExists =>
      'Iimaylkan horeba waa la isticmaalayaa. Dooro cinwaan kale ama soo gal akoonkaaga jira. Iibsigaaga weli waa laga heli karaa Google Play.';

  @override
  String get guest_claimError =>
      'Akoonkaaga lama abuuri karin. Waad sii isticmaali kartaa VPN-kaaga, mar dambena isku day.';

  @override
  String get guest_secureStorageError =>
      'Fadhigaaga aaladdan lama ammaanin karin. Isku day mar kale.';

  @override
  String get guest_premiumRequired =>
      'Dooro isdiiwaangelin si aad VPN-kaaga u shido.';

  @override
  String get welcome_viewPlans => 'Eeg qorshayaasha';

  @override
  String get google_continue => 'Ku sii wad Google';

  @override
  String get google_or => 'ama';

  @override
  String get google_title => 'Akoonkaaga FuzeVPN';

  @override
  String get google_settingUp => 'Dhammaystir abuurista akoonkaaga';

  @override
  String get google_country => 'Dalka aad degan tahay';

  @override
  String get google_profileDescription =>
      'Dooro dalkaaga oo eeg labada dukumeenti si aad akoonkaaga FuzeVPN u abuurto.';

  @override
  String get google_claimDescription =>
      'Ku xiriiri akoonkaaga martida ah Google. Isdiiwaangelintaada iyo aaladdaada waxay ku sii xiran yihiin akoonkan.';

  @override
  String get google_linkTitle => 'Ku xiriiri Google FuzeVPN';

  @override
  String get google_linkDescription =>
      'Xaqiiji gelitaanka akoonkaaga FuzeVPN ee jira. Tallaabadan ma weydiisanayso erayga sirta ah ee Google-kaaga.';

  @override
  String get google_password => 'Erayga sirta FuzeVPN';

  @override
  String get google_linkAccount => 'Xaqiiji xiriirka';

  @override
  String get google_requestEmail => 'Iimayl xaqiijin ii soo dir';

  @override
  String get google_emailInstructions =>
      'Fur iimaylka FuzeVPN oo geli koodhka xaqiijinta.';

  @override
  String get google_emailCode => 'Koodhka xaqiijinta iimaylka';

  @override
  String get google_confirmEmail => 'Xaqiiji koodhka';

  @override
  String get google_restart => 'Dooro akoon Google kale';

  @override
  String get google_resume => 'Hubi isku daygan';

  @override
  String get google_unavailable =>
      'Soo galitaanka Google lama heli karo. Waxaad isticmaali kartaa iimaylka iyo erayga sirta.';

  @override
  String get google_expired =>
      'Isku daygan wuu dhacay. Iska daa oo mar kale bilow.';

  @override
  String get google_conflict =>
      'Akoonkan Google horeba waxaa loogu xiriiriyay meel kale. Akoonkaaga hadda jira iyo isdiiwaangelintaada waa la ilaaliyay.';

  @override
  String get google_error =>
      'Soo galitaanka Google wuu fashilmay. Isku day mar kale; gelitaankaaga hadda jira waa la ilaaliyay.';

  @override
  String get google_uncertain =>
      'Natiijada lama xaqiijin karin. Hubi isku daygan ama iska daa ka hor intaadan mar kale bilaabin.';

  @override
  String get google_cancelFailed =>
      'Joojinta lama xaqiijin karin. Mar kale isku day inaad iska daayso ka hor intaadan shaashaddan ka bixin.';

  @override
  String get google_cancelled => 'Soo galitaanka Google waa la joojiyay.';

  @override
  String get google_selecting => 'Dooro akoonkaaga Google…';

  @override
  String get google_verifying => 'Akoonkaaga waa la hubinayaa…';

  @override
  String get google_emailUnavailable =>
      'Iimaylka xaqiijinta lama diri karin. Mar dambe isku day.';

  @override
  String get google_emailSent =>
      'Iimaylka xaqiijinta waa la diray. Hubi sanduuqa iimaylkaaga.';

  @override
  String get google_rateLimited =>
      'Fadlan sug ka hor intaadan mar kale isku dayin.';

  @override
  String get google_busy =>
      'Google lama heli karo inta hawl kale socoto (xidhiidhka VPN, akoonka ama marti). Isku day marka ay dhammaato; gelitaankaaga hadda jira waa la ilaaliyay.';

  @override
  String get google_invalidPassword =>
      'Erayga sirta FuzeVPN ma sax aha. Akoonkaaga hadda jira waa la ilaaliyay.';

  @override
  String get google_invalidCode =>
      'Koodhka xaqiijinta ma sax aha ama wuu dhacay.';

  @override
  String get google_accountChanged =>
      'Fadhigaaga waa isbeddelay. Iska daa isku daygan ka hor intaadan mar kale bilaabin.';

  @override
  String get google_invalidResponse =>
      'Jawaabta lama xaqiijin karin. Gelitaankaaga hadda jira waa la ilaaliyay.';

  @override
  String get google_invalidRegistration =>
      'Hubi dalkaaga iyo labada oggolaansho.';

  @override
  String get google_consentRequired =>
      'Dooro dalkaaga oo aqbal labada dukumeenti si aad u sii waddo.';

  @override
  String get google_challengeRequired =>
      'Hubin amni oo dheeraad ah ayaa loo baahan yahay. Gelitaankaaga hadda jira waa la ilaaliyay.';

  @override
  String get google_challengeUnavailable =>
      'Hubinta amniga lama heli karo. Mar dambe isku day.';

  @override
  String get google_intentMismatch =>
      'Isku day hore oo soo galitaanka Google ah weli waa sugaysaa. Iska daa ka hor intaadan bilaabin hawshan.';

  @override
  String get google_challengeBlocked =>
      'Hubinta amniga ee loo baahan yahay kuma jirto barnaamijkan. Hawshan hadda lama dhammaystiri karo.';

  @override
  String get google_solveChallenge => 'Dhammaystir hubinta amniga';

  @override
  String get google_challengeTitle => 'Hubinta amniga';

  @override
  String get google_challengeReady =>
      'Xaqiijinta waa dhammaatay. Hadda waad xaqiijin kartaa abuurista akoonkaaga.';

  @override
  String get google_challengeExpired =>
      'Xaqiijinta way dhacday. Mar kale dhammaystir ka hor intaadan xaqiijin.';

  @override
  String get google_challengeCancelled =>
      'Xaqiijinta waa la joojiyay. Mar kale waad isku dayi kartaa.';

  @override
  String get google_challengeFailed =>
      'Hubinta amniga way guuldareysatay. Isku day mar kale.';

  @override
  String get billing_trialTitle => 'Bilaash ku tijaabi Fuze Premium';

  @override
  String get billing_trialSubtitle =>
      'Ilaali xidhiidhkaaga laga bilaabo maanta.';

  @override
  String get billing_trialWeeks => 'Tijaabo bilaash ah oo 2 toddobaad ah';

  @override
  String billing_trialDays(String days) {
    return 'Tijaabo bilaash ah oo $days maalin ah';
  }

  @override
  String get billing_trialStart => 'Bilow tijaabadayda bilaashka ah';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Haddii aad maanta bilowdo, lacagta ugu horreysa waxaa la filayaa in laga qaado $date.';
  }

  @override
  String get billing_trialTerms =>
      'Waxaa si toos ah loo cusboonaysiiyaa qiimaha la sheegay. Si aan lacag laguu qaadin, Google Play ku jooji ka hor inta tijaabadu dhammaanayso.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Kadibna $price bil kasta';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Kadibna $price sannad kasta';
  }

  @override
  String get billing_choosePeriod => 'Dooro qorshahaaga';

  @override
  String get billing_selectionHint => 'Dooro qorshe si aad u sii waddo.';

  @override
  String get billing_benefitConnection => 'Xidhiidh la sireeyay';

  @override
  String get billing_benefitPrivacy => 'Asturnaanta internetka';

  @override
  String get billing_benefitNoAccount => 'Diiwaangelin looma baahna';

  @override
  String get billing_cancellation => 'Ku jooji Google Play';

  @override
  String get billing_premiumTitle => 'Xidhiidh si fiican loo ilaaliyay.';

  @override
  String get billing_premiumSubtitle =>
      'Ilaali xidhiidhkaaga, sida kuu habboon.';

  @override
  String get billing_priceMonthly => 'bil kasta';

  @override
  String get billing_priceYearly => 'sannad kasta';

  @override
  String get billing_trialToday => 'Maanta wax lacag ah ma bixinayso';

  @override
  String get billing_trialConfirmation =>
      'Google Play wuxuu xaqiijiyaa taariikhaha, wadarta ugu dambeysa iyo canshuuraha khuseeya ka hor intaadan xaqiijin.';

  @override
  String get billing_offerChanged =>
      'Shuruudaha dalabkan way is beddeleen. Cusboonaysii qorshayaasha oo mar kale dooro.';

  @override
  String get status_waitingNetwork => 'Shabakad ayaa la sugayaa';

  @override
  String get status_waitingNetworkDetail =>
      'Shabakad ma jirto. VPN-ku wuu hubin doonaa xidhiidhka marka shabakaddu dib u soo noqoto.';

  @override
  String get locations_favoriteLoadFailed =>
      'Kuwa la jecel yahay lama soo rari karin. Isku day mar kale.';

  @override
  String get locations_favoritesLoading =>
      'Kuwa la jecel yahay waa la soo rarayaa…';
}
