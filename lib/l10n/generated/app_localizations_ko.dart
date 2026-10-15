// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get vpnDisclosure_title => '연결 보호하기';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN은 Android의 VPN 서비스(VpnService)를 사용하여 이 기기와 FuzeVPN 서버 사이에 암호화된 터널을 만듭니다.';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN이 활성화된 동안 앱의 인터넷 트래픽, 목적지 주소 및 DNS 요청은 연결을 라우팅하기 위해 이 터널을 통과합니다. FuzeVPN이 백그라운드에서 실행 중일 때도 마찬가지입니다.';

  @override
  String get vpnDisclosure_statusBody =>
      '앱은 연결 상태, 연결 시간 및 전송된 데이터양을 사용하여 VPN 연결을 표시합니다. 언제든지 연결을 중지할 수 있습니다.';

  @override
  String get vpnDisclosure_privacy => '개인정보 보호';

  @override
  String get vpnDisclosure_accept => '동의하고 계속';

  @override
  String get vpnDisclosure_decline => '나중에';

  @override
  String get accountRestoration_title => '계정을 일시적으로 사용할 수 없습니다';

  @override
  String get accountRestoration_message =>
      '세션은 유지되었습니다. 다시 시도하여 계정을 복구하세요. 여기에서 VPN 연결을 계속 관리할 수 있습니다.';

  @override
  String get action_retry => '다시 시도';

  @override
  String get session_endingTitle => '세션 종료 중';

  @override
  String get session_ending => '세션이 무효화되었습니다. VPN을 중지하고 세션을 삭제하는 중입니다…';

  @override
  String get session_stopFailed => 'VPN 종료가 확인되지 않았습니다. 다시 로그인하기 전에 다시 시도하세요.';

  @override
  String get session_cleanupFailed =>
      'VPN은 중지되었지만 세션 삭제가 확인되지 않았습니다. 정리를 다시 시도하세요.';

  @override
  String get session_retryStop => '종료 다시 시도';

  @override
  String get session_retryCleanup => '정리 다시 시도';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPN을 안전하게 준비하는 중…';

  @override
  String get nav_connection => '연결';

  @override
  String get nav_locations => '위치';

  @override
  String get nav_account => '계정';

  @override
  String get nav_devices => '기기';

  @override
  String get nav_settings => '설정';

  @override
  String get action_refresh => '새로 고침';

  @override
  String get auth_tab_login => '로그인';

  @override
  String get auth_tab_register => '가입';

  @override
  String get auth_stepAccount => '계정';

  @override
  String get auth_stepIdentity => '신원';

  @override
  String get auth_stepAddress => '주소 및 약관';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$current단계 / $total단계';
  }

  @override
  String get auth_tagline => '간편한 나만의 VPN.';

  @override
  String get auth_keysLocal => '개인 VPN 키는 이 기기에 보관됩니다.';

  @override
  String get form_email => '이메일 주소';

  @override
  String get form_password => '비밀번호';

  @override
  String get form_showPassword => '비밀번호 표시';

  @override
  String get form_hidePassword => '비밀번호 숨기기';

  @override
  String get form_passwordMin => 'UTF-8 기준 8~72바이트입니다. 일부 문자는 두 바이트 이상을 사용합니다.';

  @override
  String get form_firstName => '이름';

  @override
  String get form_lastName => '성';

  @override
  String get form_phone => '전화번호 (+33612345678)';

  @override
  String get form_address => '주소';

  @override
  String get form_address2 => '주소 입력란 2(선택 사항)';

  @override
  String get form_postalCode => '우편번호';

  @override
  String get form_city => '도시';

  @override
  String get form_country => '국가 코드(예: FR)';

  @override
  String get action_login => '로그인';

  @override
  String get action_createAccount => '계정 만들기';

  @override
  String get action_createMyAccount => '내 계정 만들기';

  @override
  String get action_next => '계속';

  @override
  String get action_previous => '뒤로';

  @override
  String get action_forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get auth_noAccount => '아직 계정이 없으신가요?';

  @override
  String get auth_requiredInformation => '세 단계로 계정을 만드세요.';

  @override
  String get auth_termsPrefix => '다음에 동의합니다: ';

  @override
  String get auth_termsLink => '이용 약관';

  @override
  String get auth_privacyPrefix => '다음에 동의합니다: ';

  @override
  String get auth_privacyLink => '개인정보 처리방침';

  @override
  String get auth_consentRequired => '계정을 만들려면 동의가 필요합니다.';

  @override
  String get validation_required => '이 입력란은 필수입니다.';

  @override
  String get validation_email => '유효한 이메일 주소를 입력하세요.';

  @override
  String get validation_password => '비밀번호가 너무 짧습니다. UTF-8 기준 8바이트 이상이어야 합니다.';

  @override
  String get validation_passwordTooLong =>
      '비밀번호가 너무 깁니다. UTF-8 기준 72바이트 이하여야 합니다.';

  @override
  String get validation_phone => '국제 형식을 사용하세요. 예: +33612345678';

  @override
  String get validation_country => '두 글자 국가 코드를 사용하세요. 예: FR';

  @override
  String get passwordReset_title => '비밀번호 재설정';

  @override
  String get passwordReset_description =>
      '비밀번호 재설정 링크를 요청하려면 계정 이메일 주소를 입력하세요.';

  @override
  String get passwordReset_send => '링크 보내기';

  @override
  String get connection_title => '내 연결';

  @override
  String get connection_subtitle => '위치를 선택한 다음 VPN을 켜세요.';

  @override
  String get connection_prepare => '연결할 준비가 되었나요?';

  @override
  String get connection_advancedOptions => '고급 옵션';

  @override
  String get connection_location => '위치';

  @override
  String get connection_chooseLocation => '위치 선택';

  @override
  String get connection_protocol => '프로토콜';

  @override
  String get connection_connect => '연결';

  @override
  String get connection_connecting => '연결 중…';

  @override
  String get connection_disconnect => '연결 해제';

  @override
  String get connection_disconnecting => '연결 해제 중';

  @override
  String get connection_locationChange => '위치 변경 중…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol을(를) 사용할 수 없습니다';
  }

  @override
  String get connection_activeLocation => '현재 위치';

  @override
  String get connection_duration => '기간';

  @override
  String get connection_received => '수신';

  @override
  String get connection_sent => '송신';

  @override
  String get connection_lastHandshake => '마지막 보안 교환';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration 전';
  }

  @override
  String get verification_title => '이메일 주소 확인';

  @override
  String get verification_message => '이 휴대전화에서 VPN을 사용하려면 이메일 주소를 확인하세요.';

  @override
  String get verification_resend => '이메일 다시 보내기';

  @override
  String get migration_title => '위치 변경';

  @override
  String get migration_draining => '위치 변경을 준비하는 중…';

  @override
  String get migration_activating => '새 서버를 활성화하는 중…';

  @override
  String get migration_ready => '위치가 업데이트되었습니다.';

  @override
  String get migration_blocked =>
      '위치를 변경하려면 서버 개입이 필요합니다. 나중에 다시 시도하거나 지원팀에 문의하세요.';

  @override
  String get migration_progress => '위치 변경 진행률';

  @override
  String migration_retryDelay(Object seconds) {
    return '확인 간격: $seconds초';
  }

  @override
  String get migration_resume => '위치 변경 재개';

  @override
  String get status_authorizing => '권한 필요';

  @override
  String get status_authorizingDetail => 'VPN을 허용하려면 Android 요청을 승인하세요.';

  @override
  String get status_preparing => '준비 중';

  @override
  String get status_preparingDetail => '보안 연결을 준비하는 중입니다.';

  @override
  String get status_reconnecting => '다시 연결 중…';

  @override
  String get status_reconnectingDetail => '연결이 중단되었습니다. VPN이 다시 연결을 시도하고 있습니다.';

  @override
  String get status_connecting => '연결 중';

  @override
  String get status_connectingDetail => 'VPN 서버에 연결하는 중…';

  @override
  String get status_connected => '연결됨';

  @override
  String get status_connectedDetail => 'VPN 연결이 활성화되어 있습니다.';

  @override
  String get status_disconnecting => '연결 해제 중';

  @override
  String get status_disconnectingDetail => 'VPN 연결을 중지하는 중입니다.';

  @override
  String get status_error => '연결을 사용할 수 없음';

  @override
  String get status_errorDetail => 'VPN 연결이 확인되지 않았습니다. 다시 시도하세요.';

  @override
  String get status_idle => '연결 해제됨';

  @override
  String get status_idleDetail => '연결을 보호하려면 VPN에 연결하세요.';

  @override
  String get trust_note => '앱을 닫아도 VPN은 중지되지 않습니다. 중지하려면 연결 탭에서 연결 해제를 사용하세요.';

  @override
  String get locations_none => '현재 사용할 수 있는 위치가 없습니다.';

  @override
  String get locations_available => '다음 위치를 선택하세요.';

  @override
  String get locations_selected => '선택한 위치';

  @override
  String get locations_select => '이 위치 선택';

  @override
  String get locations_lockedTunnel => '위치를 변경하려면 VPN 연결을 해제하세요.';

  @override
  String get locations_lockedMigration => '위치 변경이 완료될 때까지 기다리세요.';

  @override
  String get devices_title => '내 기기';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit개 기기';
  }

  @override
  String get devices_refresh => '기기 새로 고침';

  @override
  String get devices_empty => '아직 등록된 VPN 기기가 없습니다.';

  @override
  String get devices_firstConnection => '처음 연결할 때 휴대전화가 추가됩니다.';

  @override
  String get devices_thisDevice => '이 기기';

  @override
  String devices_added(Object date) {
    return '$date에 추가됨';
  }

  @override
  String get action_remove => '삭제';

  @override
  String get settings_title => '설정';

  @override
  String get settings_subtitle => '환경설정과 계정을 한곳에서 관리하세요.';

  @override
  String get settings_appearance => '화면 표시';

  @override
  String get settings_language => '언어';

  @override
  String get settings_languageDescription => '선택한 언어는 VPN 알림에도 적용됩니다.';

  @override
  String get settings_account => '계정';

  @override
  String get settings_signOut => '로그아웃';

  @override
  String get settings_privacy => '개인정보 처리방침';

  @override
  String get settings_terms => '이용 약관';

  @override
  String get settings_security => '보안 및 투명성';

  @override
  String get settings_licenses => '구성 요소 라이선스';

  @override
  String get settings_licensesDetail => '앱에서 사용하는 소프트웨어';

  @override
  String get settings_background =>
      '앱을 나가도 VPN은 켜져 있습니다. 중지하려면 연결 탭에서 연결 해제를 사용하세요.';

  @override
  String get theme_system => '시스템 설정';

  @override
  String get theme_light => '밝게';

  @override
  String get theme_dark => '어둡게';

  @override
  String get language_system => '휴대전화 언어';

  @override
  String get language_fr => '프랑스어';

  @override
  String get language_en => '영어';

  @override
  String get language_es => '스페인어';

  @override
  String get language_de => '독일어';

  @override
  String get dialog_removeDevice => '이 기기를 삭제하시겠습니까?';

  @override
  String get dialog_removeCurrent =>
      '이 휴대전화의 VPN 연결이 해제되고 접근 권한이 사라집니다. 서버에서 확인한 후 이 기기의 VPN 연결 데이터가 삭제됩니다.';

  @override
  String dialog_removeOther(Object name) {
    return '“$name”의 VPN 접근 권한이 취소됩니다. 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get dialog_signOut => '로그아웃하시겠습니까?';

  @override
  String get dialog_signOutMessage =>
      'VPN이 중지되며 다시 로그인해야 합니다. 다음 연결을 위해 암호화된 VPN 키는 이 휴대전화에 보관됩니다.';

  @override
  String get action_cancel => '취소';

  @override
  String get action_signOut => '로그아웃';

  @override
  String get notice_close => '메시지 닫기';

  @override
  String get notice_sessionExpired_title => '세션 만료';

  @override
  String get notice_sessionExpired_message => '세션이 만료되었습니다. 다시 로그인하세요.';

  @override
  String get notice_connectionFailed_title => '연결 실패';

  @override
  String get notice_invalidCredentials_message => '이메일 주소 또는 비밀번호가 올바르지 않습니다.';

  @override
  String get notice_emailVerification_title => '이메일 확인 필요';

  @override
  String get notice_emailVerification_message =>
      'VPN 기기를 추가하기 전에 이메일 주소를 확인하세요.';

  @override
  String get notice_rateLimited_title => '시도 횟수 초과';

  @override
  String get notice_deviceLimit_title => '기기 2대 한도에 도달함';

  @override
  String get notice_deviceLimit_message => '다른 기기를 추가하기 전에 기존 기기를 삭제하세요.';

  @override
  String get notice_identityRenewal_title => 'VPN 신원을 갱신해야 함';

  @override
  String get notice_identityRenewal_message =>
      '이 신원은 삭제되었습니다. 새로운 로컬 신원을 만드세요.';

  @override
  String get notice_migrationPending_title => '위치 변경 진행 중';

  @override
  String get notice_migrationPending_message => '이미 위치 변경이 진행 중입니다.';

  @override
  String get notice_migrationBlocked_title => '위치 변경 차단됨';

  @override
  String get notice_migrationBlocked_message =>
      '위치를 변경하려면 서버 개입이 필요합니다. 나중에 다시 시도하거나 지원팀에 문의하세요.';

  @override
  String get notice_targetUnavailable_title => '서버를 일시적으로 사용할 수 없음';

  @override
  String get notice_targetUnavailable_message => '이 서버는 일시적으로 사용할 수 없습니다.';

  @override
  String get notice_networkUnavailable_title => '인터넷 연결을 사용할 수 없음';

  @override
  String get notice_networkUnavailable_message => '연결을 확인한 후 다시 시도하세요.';

  @override
  String get notice_permissionDenied_title => 'VPN 권한 거부됨';

  @override
  String get notice_permissionDenied_message =>
      '연결을 다시 시작하고 Android 권한 요청을 승인하세요.';

  @override
  String get notice_wireguardTimeout_title => '서버가 응답하지 않음';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard 연결에 시간이 너무 오래 걸렸습니다. 다시 시도하거나 다른 위치를 선택하세요.';

  @override
  String get notice_tlsFailed_title => '보안 연결 거부됨';

  @override
  String get notice_tlsFailed_message =>
      '서버가 OpenVPN 연결을 수락하지 않았습니다. 다시 시도하세요. 문제가 계속되면 진단을 실행하세요.';

  @override
  String get notice_tunRejected_title => 'Android에서 VPN 인터페이스를 거부함';

  @override
  String get notice_tunRejected_message =>
      'Android에서 OpenVPN이 요청한 네트워크 구성을 거부했습니다.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN을 시작할 수 없음';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN 엔진을 시작하지 못했습니다. 다시 시도하세요. 문제가 계속되면 지원팀에 문의하세요.';

  @override
  String notice_diagnosticCode(Object code) {
    return '진단 코드: $code';
  }

  @override
  String get notice_generic_title => 'VPN 연결 실패';

  @override
  String get notice_generic_message => '오류가 발생했습니다. 나중에 다시 시도하세요.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '계정 생성됨',
      'password_reset_sent': '비밀번호 재설정 요청 수신됨',
      'verification_email_sent': '확인 이메일 전송됨',
      'location_migration_pending': '위치 변경 진행 중',
      'vpn_sign_in_required': '로그인 필요',
      'protocol_unavailable_at_location': '프로토콜을 사용할 수 없음',
      'vpn_permission_denied': 'VPN 권한 거부됨',
      'revoked_identity_device_limit': '기기 2대 한도에 도달함',
      'tunnel_start_unexpected': 'VPN을 시작할 수 없음',
      'flutter_disconnect_timeout': '연결 해제가 확인되지 않음',
      'flutter_disconnect_unexpected': '연결을 해제할 수 없음',
      'device_revoked': '기기 삭제됨',
      'revoke_unexpected': '기기를 삭제할 수 없음',
      'identity_renewal_unexpected': '신원을 갱신할 수 없음',
      'openvpn_renewal_unexpected': 'OpenVPN을 갱신할 수 없음',
      'location_migration_blocked': '위치 변경 차단됨',
      'location_migration_slow': '위치 변경이 아직 진행 중',
      'location_migration_conflict': '위치 변경을 새로 고쳐야 함',
      'location_migration_verification_failed': '위치 변경이 확인되지 않음',
      'location_migration_device_changed': '위치 변경 중 기기가 변경됨',
      'tunnel_stop_failed': '위치를 변경할 수 없음',
      'other': '작업 실패',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          '계정은 생성되었지만 확인 이메일을 보내지 못했습니다. 앱에서 다시 보내기를 사용하세요.',
      'password_reset_sent':
          '요청을 받았습니다. 이 주소와 일치하는 계정이 있으면 이메일을 받을 수 있습니다. 스팸 폴더도 확인하세요.',
      'verification_email_sent': '새 확인 이메일을 방금 보냈습니다.',
      'location_migration_pending':
          '$target(으)로 이동을 아직 준비 중입니다. 기기를 다시 만들지 않고 재개할 수 있습니다.',
      'vpn_sign_in_required': 'VPN을 시작하기 전에 계정에 로그인하세요.',
      'protocol_unavailable_at_location':
          '선택한 위치에서 해당 프로토콜을 제공하지 않습니다. 위치를 새로 고치거나 다른 프로토콜을 선택하세요.',
      'vpn_permission_denied':
          'Android에서 VPN 권한을 거부했습니다. 연결을 다시 시작하고 시스템 요청을 승인하세요.',
      'revoked_identity_device_limit':
          '이 기기의 VPN 접근 권한이 삭제되었고 기기 한도에 도달했습니다. 계정 → 내 기기 관리에서 기기를 삭제하세요.',
      'tunnel_start_unexpected':
          '예기치 않은 오류로 터널 준비가 중단되었습니다. 진단 코드를 확인하고 다시 시도하세요.',
      'flutter_disconnect_timeout':
          'Android에서 제때 VPN 중지를 확인하지 못했습니다. 다시 중지해 보세요.',
      'flutter_disconnect_unexpected': '예기치 않은 오류로 터널 중지 확인에 실패했습니다.',
      'device_revoked': '기기의 VPN 접근 권한이 취소되고 로컬 보안 정보가 삭제되었습니다.',
      'revoke_unexpected': '기기를 삭제하지 못했습니다. 목록을 새로 고치고 다시 시도하세요.',
      'identity_renewal_unexpected':
          '새 VPN 신원을 만들지 못했습니다. 기기를 새로 고치고 다시 시도하세요.',
      'openvpn_renewal_unexpected':
          'OpenVPN 프로필을 갱신하지 못했습니다. 다시 시도하거나 진단 코드를 확인하세요.',
      'location_migration_blocked':
          '현재 서버에서 이 변경을 완료할 수 없습니다. 기기와 로컬 신원은 유지되었습니다.',
      'location_migration_slow':
          '서버에서 아직 $target(으)로 이동을 준비 중입니다. 잠시 후 재개를 사용하세요.',
      'location_migration_conflict':
          '서버에서 기기 상태가 변경되었습니다. 기기를 새로 고친 후 변경을 재개하세요.',
      'location_migration_verification_failed':
          '서버에서 새 위치를 확인하지 않았습니다. 이전 로컬 신원은 유지되었습니다.',
      'location_migration_device_changed':
          '서버가 반환한 기기가 변경 중인 기기와 더 이상 일치하지 않습니다. 다시 시도하기 전에 기기를 새로 고치세요.',
      'tunnel_stop_failed': '새 연결을 시작하기 전에 이전 터널을 완전히 중지해야 합니다.',
      'other': '작업을 완료하지 못했습니다. 다시 시도하거나 진단 코드를 지원팀에 보내세요.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '세션 만료',
      'invalid_credentials': '로그인 실패',
      'email_verification_required': '이메일 확인 필요',
      'verification_email_cooldown': '이메일이 이미 전송됨',
      'rate_limited': '시도 횟수 초과',
      'invalid_registration': '정보 수정 필요',
      'email_exists': '계정이 이미 존재함',
      'invalid_profile': '잘못된 프로필',
      'invalid_device': '잘못된 기기',
      'invalid_location': '위치를 사용할 수 없음',
      'device_limit': '기기 한도에 도달함',
      'device_exists': 'VPN 신원이 이미 사용 중',
      'device_identity_revoked': 'VPN 신원을 갱신해야 함',
      'device_location_locked': '위치 변경을 새로 고쳐야 함',
      'location_migration_pending': '위치 변경 진행 중',
      'location_migration_blocked': '위치 변경 차단됨',
      'target_ca_mismatch': '호환되지 않는 OpenVPN 서버',
      'location_migration_conflict': '위치 변경을 새로 고쳐야 함',
      'server_full': '서버가 가득 참',
      'capacity_unavailable': '위치를 일시적으로 사용할 수 없음',
      'target_unavailable': '서버를 일시적으로 사용할 수 없음',
      'not_found': '항목을 찾을 수 없음',
      'invalid_openvpn_csr': '잘못된 OpenVPN 신원',
      'openvpn_profile_exists': 'OpenVPN 프로필이 이미 존재함',
      'openvpn_profile_revoked': 'OpenVPN 프로필 취소됨',
      'openvpn_operation_pending': 'OpenVPN 작업 진행 중',
      'openvpn_operation_terminal': 'OpenVPN 작업 중단됨',
      'openvpn_address_unavailable': 'OpenVPN 주소를 사용할 수 없음',
      'openvpn_profile_conflict': 'OpenVPN 충돌',
      'openvpn_signer_unavailable': 'OpenVPN을 사용할 수 없음',
      'email_delivery_unavailable': '이메일을 사용할 수 없음',
      'invalid_token': '잘못된 링크',
      'network_unavailable': '인터넷 연결을 사용할 수 없음',
      'invalid_json': '잘못된 요청',
      'invalid_api_response': '잘못된 서버 응답',
      'ipv6_unavailable': 'IPv6을 사용할 수 없음',
      'invalid_ip_families': '네트워크 구성 거부됨',
      'other': '서비스를 사용할 수 없음',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '세션이 만료되었습니다. 다시 로그인하세요.',
      'invalid_credentials': '이메일 주소 또는 비밀번호가 올바르지 않습니다.',
      'email_verification_required': 'VPN 기기를 추가하기 전에 이메일 주소를 확인하세요.',
      'invalid_registration': '요청한 정보와 동의를 확인하세요.',
      'email_exists': '이 이메일 주소를 사용하는 계정이 이미 있습니다.',
      'invalid_profile': '프로필 정보를 확인하세요.',
      'invalid_device': '이 기기의 이름 또는 로컬 신원이 올바르지 않습니다.',
      'invalid_location': '위치 목록을 새로 고치고 다시 시도하세요.',
      'device_limit': '다른 기기를 추가하기 전에 기존 기기를 삭제하세요.',
      'device_exists': '이 VPN 신원은 이미 다른 계정에 연결되어 있습니다.',
      'device_identity_revoked': '이 신원은 삭제되었습니다. 새로운 로컬 신원을 만들어야 합니다.',
      'device_location_locked': '이 기기의 위치가 방금 변경되었습니다. 앱에서 진행 중인 변경을 재개합니다.',
      'location_migration_pending': '이미 위치 변경이 진행 중입니다.',
      'location_migration_blocked':
          '위치를 변경하려면 서버 개입이 필요합니다. 나중에 다시 시도하거나 지원팀에 문의하세요.',
      'target_ca_mismatch': '이 서버는 현재 OpenVPN 프로필과 아직 호환되지 않습니다.',
      'location_migration_conflict': '기기를 새로 고친 후 위치 변경을 다시 시도하세요.',
      'server_full': '이 위치의 연결 한도에 도달했습니다. 다른 위치를 선택하거나 나중에 다시 시도하세요.',
      'capacity_unavailable':
          '현재 이 위치를 사용할 수 있는지 확인할 수 없습니다. 다른 위치를 선택하거나 나중에 다시 시도하세요.',
      'target_unavailable': '이 서버는 일시적으로 사용할 수 없습니다.',
      'not_found': '이 항목은 더 이상 계정에서 사용할 수 없습니다.',
      'invalid_openvpn_csr': '새 OpenVPN 신원을 만들고 다시 시도하세요.',
      'openvpn_profile_exists': '이 기기에 OpenVPN 프로필이 이미 있습니다.',
      'openvpn_profile_revoked': '계속하려면 OpenVPN 프로필을 갱신하세요.',
      'openvpn_operation_pending': '변경 사항이 아직 전파 중입니다. 나중에 다시 시도하세요.',
      'openvpn_operation_terminal': '새 OpenVPN 신원을 만들고 다시 시도하세요.',
      'openvpn_address_unavailable': '현재 사용할 수 있는 OpenVPN 주소가 없습니다.',
      'openvpn_profile_conflict': '프로필이 변경되었습니다. 기기를 새로 고치고 다시 시도하세요.',
      'openvpn_signer_unavailable': 'OpenVPN 서비스를 일시적으로 사용할 수 없습니다.',
      'email_delivery_unavailable': '이메일을 보내지 못했습니다. 나중에 다시 시도하세요.',
      'invalid_token': '이 링크가 올바르지 않거나 만료되었습니다. 새 링크를 요청하세요.',
      'network_unavailable': '인터넷 연결을 확인하고 다시 시도하세요.',
      'invalid_json': '입력한 정보를 확인하고 다시 시도하세요.',
      'invalid_api_response': '서버에서 예상치 못한 응답을 반환했습니다. 나중에 다시 시도하세요.',
      'ipv6_unavailable': '현재 서버에서 IPv6을 활성화할 수 없습니다. 나중에 다시 시도하세요.',
      'invalid_ip_families': '터널 구성이 완전하지 않거나 승인된 주소와 일치하지 않습니다. 앱에서 다시 시도하세요.',
      'other': '서버 오류가 발생했습니다. 나중에 다시 시도하세요.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => '잠시 후 다시 시도하세요.';

  @override
  String notice_retryAfter(Object seconds) {
    return '$seconds초 후 다시 시도하세요.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': '시스템 VPN 재개를 사용할 수 없음',
      'system_vpn_resume_corrupt': '잘못된 시스템 VPN 재개',
      'system_vpn_resume_session_invalid': '잘못된 VPN 재개 세션',
      'system_vpn_resume_identity_changed': 'VPN 신원 변경됨',
      'system_vpn_resume_identity_invalid': '잘못된 VPN 재개 신원',
      'system_vpn_resume_storage_failed': 'VPN 재개 저장소를 사용할 수 없음',
      'system_vpn_resume_network_timeout': 'VPN 재개에 네트워크 없음',
      'system_vpn_resume_blocked': 'VPN 재개 차단됨',
      'system_vpn_resume_failed': 'VPN 재개 실패',
      'system_vpn_resume_error_invalid': '잘못된 VPN 재개 오류',
      'wireguard_identity_store_failed': 'WireGuard 신원이 저장되지 않음',
      'wireguard_identity_unavailable': 'WireGuard 신원을 사용할 수 없음',
      'vpn_host_destroyed': 'Android VPN 호스트 중지됨',
      'vpn_host_unavailable': 'Android VPN 호스트를 사용할 수 없음',
      'vpn_permission_required': 'VPN 권한 필요',
      'vpn_permission_denied': 'VPN 권한 거부됨',
      'vpn_permission_request_failed': '권한을 요청할 수 없음',
      'wireguard_foreground_service_unavailable': 'WireGuard 서비스를 사용할 수 없음',
      'wireguard_identity_invalid': '잘못된 로컬 WireGuard 키',
      'wireguard_identity_in_use': 'WireGuard 신원이 이미 사용 중',
      'wireguard_configuration_invalid': '잘못된 WireGuard 구성',
      'wireguard_operation_pending': 'WireGuard 작업이 아직 활성 상태',
      'wireguard_start_failed': 'WireGuard 시작 거부됨',
      'wireguard_stop_timeout': 'WireGuard 중지가 확인되지 않음',
      'wireguard_handshake_timeout': 'WireGuard가 응답하지 않음',
      'openvpn_connection_timeout': 'OpenVPN이 응답하지 않음',
      'openvpn_core_unavailable': 'OpenVPN 엔진을 사용할 수 없음',
      'openvpn_operation_pending': 'OpenVPN 세션이 아직 활성 상태',
      'openvpn_stop_timeout': 'OpenVPN 중지가 확인되지 않음',
      'openvpn_profile_unavailable': '로컬 OpenVPN 프로필 없음',
      'openvpn_native_failed': '네이티브 OpenVPN 호출 중단됨',
      'openvpn_key_generation_failed': 'OpenVPN P-256 키를 만들 수 없음',
      'openvpn_csr_generation_failed': 'OpenVPN CSR을 만들 수 없음',
      'openvpn_identity_store_failed': 'OpenVPN 신원이 저장되지 않음',
      'openvpn_identity_clear_failed': 'OpenVPN 삭제가 불완전함',
      'openvpn_identity_in_use': 'OpenVPN 신원이 아직 사용 중',
      'openvpn_tls_verification_required': 'OpenVPN TLS 확인 누락',
      'openvpn_cipher_invalid': '잘못된 OpenVPN 암호화 방식',
      'openvpn_profile_rejected': 'OpenVPN 프로필 거부됨',
      'openvpn_identity_inconsistent': '일관되지 않은 OpenVPN 신원',
      'tls_handshake_failed': 'OpenVPN 협상 거부됨',
      'tls_alert_unknown_ca': 'OpenVPN 클라이언트 인증서를 인식하지 못함',
      'tls_alert_bad_certificate': 'OpenVPN 클라이언트 인증서 거부됨',
      'tls_alert_unsupported_certificate': '지원되지 않는 OpenVPN 인증서',
      'tls_client_certificate_required': 'OpenVPN 클라이언트 인증서 필요',
      'tls_alert_misc': 'OpenVPN TLS 경고',
      'tls_signature_algorithm_rejected': '지원되지 않는 OpenVPN 서명',
      'tls_handshake_rejected': 'OpenVPN TLS 협상 거부됨',
      'tls_version_rejected': '호환되지 않는 OpenVPN TLS 버전',
      'tls_certificate_expired': 'TLS 인증서 만료됨',
      'tls_certificate_revoked': 'TLS 인증서 취소됨',
      'transport_failed': 'OpenVPN 서버에 연결할 수 없음',
      'tun_configuration_rejected': 'OpenVPN 인터페이스를 만들 수 없음',
      'tun_setup_failed': 'OpenVPN TUN 설정 실패',
      'tun_interface_create_failed': 'OpenVPN 인터페이스 생성 실패',
      'tun_interface_disabled': 'OpenVPN 인터페이스 비활성화됨',
      'tun_halted': 'OpenVPN 인터페이스 중단됨',
      'tun_already_established': 'OpenVPN 인터페이스가 이미 열려 있음',
      'tun_addresses_missing': 'OpenVPN 주소 누락',
      'tun_routes_missing': 'OpenVPN 라우팅 누락',
      'tun_dns_missing': 'OpenVPN DNS 누락',
      'tun_permission_revoked': 'VPN 권한 취소됨',
      'tun_establish_returned_null': 'Android에서 VPN 인터페이스를 거부함',
      'openvpn_service_start_failed': 'OpenVPN 서비스를 사용할 수 없음',
      'openvpn_operation_timeout': 'OpenVPN 호출 시간 초과',
      'openvpn_start_failed': 'OpenVPN 시작 거부됨',
      'openvpn_connection_failed': 'OpenVPN 연결 중단됨',
      'openvpn_core_status_error': 'OpenVPN Core가 오류로 종료됨',
      'openvpn_stopped_before_connected': '연결 전에 OpenVPN이 중지됨',
      'openvpn_auth_failed': 'OpenVPN 인증 거부됨',
      'openvpn_client_setup_failed': 'OpenVPN 클라이언트 설정 실패',
      'openvpn_client_halted': 'OpenVPN 클라이언트 중단됨',
      'openvpn_client_restart': 'OpenVPN 다시 시작 요청됨',
      'openvpn_inactive_timeout': 'OpenVPN이 너무 오래 비활성 상태',
      'openvpn_session_expired': 'OpenVPN 세션 만료됨',
      'openvpn_credentials_required': '지원되지 않는 OpenVPN 인증',
      'openvpn_proxy_failed': 'OpenVPN 중간 전송 실패',
      'openvpn_compression_failed': 'OpenVPN 압축 거부됨',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM 암호화를 사용할 수 없음',
      'openvpn_feature_unsupported': '지원되지 않는 OpenVPN 기능',
      'network_unavailable': '인터넷 연결을 사용할 수 없음',
      'network_lost': '네트워크를 사용할 수 없음',
      'certificate_validation_failed': '서버 인증서 거부됨',
      'openvpn_certificate_expired': 'OpenVPN 인증서 만료됨',
      'tunnel_active_for_another_account': '다른 계정의 터널이 아직 활성 상태',
      'tunnel_already_active': '네이티브 터널이 이미 활성 상태',
      'tunnel_stop_timeout': '$protocol 중지가 확인되지 않음',
      'tunnel_disconnected': '$protocol 중단됨',
      'native_bridge_unavailable': 'Android 브리지를 사용할 수 없음',
      'native_operation_failed': 'Android 작업 중단됨',
      'invalid_arguments': 'VPN 매개변수가 불완전함',
      'invalid_account_id': '잘못된 VPN 계정',
      'invalid_device_id': '잘못된 기기 식별자',
      'storage_key_not_allowed': '저장소 키 거부됨',
      'secure_storage_read_failed': '보안 읽기 실패',
      'secure_storage_write_failed': '보안 쓰기 실패',
      'key_generation_failed': 'WireGuard 키를 생성할 수 없음',
      'csr_generation_failed': 'OpenVPN CSR을 생성할 수 없음',
      'other': '분류되지 않은 네이티브 VPN 오류',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android에서 재개할 수 있는 VPN 세션을 찾지 못했습니다. 앱에서 새 연결을 시작하세요.',
      'system_vpn_resume_corrupt':
          '저장된 VPN 재개 데이터가 올바르지 않아 사용하지 않습니다. 새 연결을 시작하세요.',
      'system_vpn_resume_session_invalid':
          '저장된 세션으로 더 이상 VPN을 재개할 수 없습니다. 앱에서 다시 로그인하세요.',
      'system_vpn_resume_identity_changed':
          '로컬 VPN 신원이 변경되었습니다. 재개를 중지했습니다. 새 연결을 시작하세요.',
      'system_vpn_resume_identity_invalid':
          '재개에 사용할 신원이 올바르지 않습니다. 새 연결을 시작하세요.',
      'system_vpn_resume_storage_failed':
          'Android에서 암호화된 재개 데이터를 읽거나 업데이트하지 못했습니다. 새 연결을 시작하세요.',
      'system_vpn_resume_network_timeout':
          'Android에서 VPN을 재개할 네트워크를 제때 찾지 못했습니다. 네트워크를 사용할 수 있을 때 다시 시도하세요.',
      'system_vpn_resume_blocked':
          'VPN 재개가 차단되었습니다. Android 설정을 확인한 후 새 연결을 시작하세요.',
      'system_vpn_resume_failed': 'Android VPN 재개에 실패했습니다. 앱에서 새 연결을 시작하세요.',
      'system_vpn_resume_error_invalid':
          'Android에서 사용할 수 없는 재개 오류를 반환했습니다. 새 연결을 시작하세요.',
      'wireguard_identity_store_failed':
          'Android에서 이 계정의 암호화된 WireGuard 신원을 저장하지 못했습니다.',
      'wireguard_identity_unavailable': '이 연결에 사용할 수 있는 WireGuard 신원이 없습니다.',
      'vpn_host_destroyed': 'VPN을 호스팅하던 Android 구성 요소가 중지되었습니다. 새 연결을 시작하세요.',
      'vpn_host_unavailable':
          'Android에서 VPN을 호스팅할 구성 요소를 만들 수 없습니다. VPN 설정을 확인한 후 다시 시도하세요.',
      'openvpn_renewal_required': '연결하기 전에 인증서에 대해 앱에서 조치가 필요합니다.',
      'openvpn_recovery_failed': '자동 복구에 실패했습니다. 앱에서 새 연결을 시작하세요.',
      'openvpn_recovery_exhausted': '자동 복구가 이미 사용되었습니다. 앱에서 새 연결을 시작하세요.',
      'vpn_permission_required': '터널을 시작하기 전에 Android에 새 VPN 승인이 필요합니다.',
      'vpn_permission_denied': '계속하려면 Android 요청에서 FuzeVPN을 허용하세요.',
      'vpn_permission_request_failed': 'Android에서 VPN 권한 화면을 열지 못했습니다.',
      'wireguard_foreground_service_unavailable':
          'Android에서 WireGuard 서비스를 포그라운드에 유지하지 못했습니다.',
      'wireguard_identity_invalid':
          '이 계정의 암호화된 WireGuard 키를 읽을 수 없거나 올바르지 않습니다.',
      'wireguard_identity_in_use': '다른 작업에서 이 계정의 WireGuard 키를 아직 사용 중입니다.',
      'wireguard_configuration_invalid':
          '받은 WireGuard 주소, DNS, 서버 키 또는 라우팅이 올바르지 않습니다.',
      'wireguard_operation_pending':
          '이전 WireGuard 작업에서 아직 네이티브 서비스를 해제하지 않았습니다.',
      'wireguard_start_failed': 'WireGuard 엔진이 구성 활성화를 거부했습니다.',
      'wireguard_stop_timeout':
          'WireGuard 서비스가 제한 시간 내에 VPN 인터페이스 해제를 확인하지 않았습니다.',
      'wireguard_handshake_timeout': '터널이 제때 서버와의 핸드셰이크를 확인하지 못했습니다.',
      'openvpn_connection_timeout': 'OpenVPN에서 제때 서버 연결을 확인하지 못했습니다.',
      'openvpn_core_unavailable': '이 앱 버전에는 사용할 수 있는 OpenVPN 엔진이 없습니다.',
      'openvpn_operation_pending':
          '네이티브 엔진이 이전 OpenVPN 세션을 아직 유지하고 있어 두 번째 세션을 만들 수 없습니다.',
      'openvpn_stop_timeout':
          'OpenVPN Core가 제한 시간 내에 네이티브 세션의 중지 및 삭제를 확인하지 않았습니다.',
      'openvpn_profile_unavailable': '이 연결에 대해 검증된 OpenVPN 프로필을 읽을 수 없습니다.',
      'openvpn_native_failed':
          '앱 오류로 OpenVPN이 중단되었습니다. 다시 연결해 보세요. 문제가 계속되면 진단을 실행하세요.',
      'openvpn_key_generation_failed':
          'Android Keystore에서 내보낼 수 없는 P-256 개인 키를 만들거나 읽지 못했습니다.',
      'openvpn_csr_generation_failed':
          'Android Keystore 키로 OpenVPN 인증서 요청에 서명하지 못했습니다.',
      'openvpn_identity_store_failed':
          '암호화된 저장소에 OpenVPN 인증서 또는 프로필을 저장하지 못했습니다.',
      'openvpn_identity_clear_failed':
          'Android에서 이 계정의 로컬 OpenVPN 신원을 완전히 삭제하지 못했습니다.',
      'openvpn_identity_in_use':
          '네이티브 OpenVPN 세션에서 이 기기의 키 또는 인증서를 아직 사용 중입니다.',
      'openvpn_tls_verification_required': '프로필에서 서버 인증서 확인을 명시적으로 요구하지 않습니다.',
      'openvpn_cipher_invalid': '서버가 허용 목록에 없는 암호화 알고리즘을 제공했습니다.',
      'openvpn_profile_rejected': '서버에서 받은 프로필이 호환되지 않습니다. 이 기기를 다시 만들고 시도하세요.',
      'openvpn_identity_inconsistent':
          '인증서가 이 휴대전화의 보안 신원과 일치하지 않습니다. 로컬 프로필을 교체하지 않았습니다.',
      'tls_handshake_failed': '서버가 TLS 협상을 거부했습니다. 문제가 계속되면 프로필을 다시 만드세요.',
      'tls_alert_unknown_ca':
          '서버가 이 기기 인증서의 인증 기관을 인식하지 못합니다. OpenVPN 서버를 확인해야 합니다.',
      'tls_alert_bad_certificate':
          '서버가 이 기기 인증서를 거부했습니다. 다시 시도하기 전에 기기를 다시 만드세요.',
      'tls_alert_unsupported_certificate':
          '서버가 Android에서 사용하는 보안 인증서 유형을 지원하지 않습니다.',
      'tls_client_certificate_required':
          '서버에 클라이언트 인증서가 필요하지만 OpenVPN Core에서 제시하지 못했습니다.',
      'tls_alert_misc': '서버가 인증서 및 버전 범주에 속하지 않는 TLS 경고를 반환했습니다.',
      'tls_signature_algorithm_rejected':
          '서버가 Android Keystore 키의 ECDSA P-256 알고리즘을 거부했습니다.',
      'tls_handshake_rejected': '서버가 연결 전에 TLS 협상을 중단했습니다.',
      'tls_version_rejected': '클라이언트와 서버에서 공통 TLS 버전을 찾지 못했습니다.',
      'tls_certificate_expired': '연결 중 제시된 인증서가 만료되었습니다.',
      'tls_certificate_revoked': '연결 중 제시된 인증서가 취소되었습니다.',
      'transport_failed': '현재 네트워크에서 OpenVPN 서버가 응답하지 않습니다. 잠시 후 다시 시도하세요.',
      'tun_configuration_rejected': 'Android에서 OpenVPN이 요청한 네트워크 구성을 거부했습니다.',
      'tun_setup_failed':
          'OpenVPN Core에서 Android 인터페이스를 만들기 전에 네트워크 계획을 거부했습니다.',
      'tun_interface_create_failed':
          'OpenVPN Core에서 Android VpnService로부터 TUN 인터페이스를 가져오지 못했습니다.',
      'tun_interface_disabled':
          '연결 중 Android 또는 OpenVPN Core에서 TUN 인터페이스를 비활성화했습니다.',
      'tun_halted': 'OpenVPN Core에서 TUN 인터페이스를 중지하라는 요청을 받았습니다.',
      'tun_already_established':
          'OpenVPN에서 같은 연결에 두 번째 인터페이스를 요청했습니다. 안전을 위해 터널을 중지했습니다.',
      'tun_addresses_missing': '서버에서 사용할 수 있는 터널 주소를 제공하지 않았습니다.',
      'tun_routes_missing': '서버에서 사용할 수 있는 터널 라우팅을 제공하지 않았습니다.',
      'tun_dns_missing': '서버에서 사용할 수 있는 DNS 서버를 제공하지 않았습니다.',
      'tun_permission_revoked': '연결 중 Android에서 VPN 권한을 취소했습니다.',
      'tun_establish_returned_null':
          'Android에서 인터페이스를 만들지 않았습니다. 일반적으로 다른 VPN이 아직 활성 상태이기 때문입니다.',
      'openvpn_service_start_failed':
          'Android에서 OpenVPN 포그라운드 서비스를 시작하지 못했습니다.',
      'openvpn_operation_timeout': 'OpenVPN Core에 대한 JNI 호출이 최대 시간을 초과했습니다.',
      'openvpn_start_failed':
          'Android 서비스는 준비되었지만 OpenVPN Core에서 프로필 시작을 수락하지 않았습니다.',
      'openvpn_connection_failed':
          'CONNECTED 이벤트를 내보내기 전에 OpenVPN Core가 중지되었습니다.',
      'openvpn_core_status_error':
          '네이티브 OpenVPN 루프가 더 구체적인 종료 이벤트 없이 오류로 끝났습니다.',
      'openvpn_stopped_before_connected':
          '네이티브 OpenVPN 루프가 명시적인 Core 오류 없이 CONNECTED 전에 중지되었습니다.',
      'openvpn_auth_failed': 'OpenVPN 서버가 프로필 인증을 거부했습니다.',
      'openvpn_client_setup_failed':
          '네트워크에 연결하기 전에 OpenVPN Core에서 클라이언트를 초기화하지 못했습니다.',
      'openvpn_client_halted': 'OpenVPN Core에서 클라이언트의 최종 중지 요청을 받았습니다.',
      'openvpn_client_restart': 'OpenVPN Core에서 전송 세션을 다시 시작하도록 요청했습니다.',
      'openvpn_inactive_timeout': 'OpenVPN Core에서 비활성 시간 초과 후 세션을 닫았습니다.',
      'openvpn_session_expired': '서버에서 OpenVPN 세션이 만료되었다고 알렸습니다.',
      'openvpn_credentials_required':
          '서버 또는 프록시가 이 인증서 프로필에 포함되지 않은 대화형 자격 증명을 요청합니다.',
      'openvpn_proxy_failed': 'OpenVPN Core에서 구성된 프록시 또는 릴레이 오류를 보고했습니다.',
      'openvpn_compression_failed':
          'OpenVPN Core에서 프로필 또는 서버가 알린 압축 모드를 거부했습니다.',
      'openvpn_ntlm_crypto_unavailable':
          '프로필에서 이 버전에서 사용할 수 없는 NTLM 암호화를 요청합니다.',
      'openvpn_feature_unsupported':
          '프로필 또는 서버에 이 Android 클라이언트에 없는 기능이 필요합니다.',
      'network_unavailable': '사용 가능한 물리적 네트워크가 없습니다.',
      'network_lost': '네트워크가 끊긴 후 터널이 중지되었습니다.',
      'certificate_validation_failed': 'OpenVPN 서버 신원을 확인하지 못했습니다.',
      'openvpn_certificate_expired': '다시 연결하기 전에 OpenVPN 프로필을 갱신하세요.',
      'tunnel_active_for_another_account':
          '이 연결을 시작하려면 다른 계정에 속한 터널을 중지해야 합니다.',
      'tunnel_already_active': 'Android에서 이전 VPN 세션이 아직 인터페이스를 사용 중이라고 보고했습니다.',
      'tunnel_stop_timeout': '$protocol 엔진이 제한 시간 내에 VPN 인터페이스 해제를 확인하지 않았습니다.',
      'tunnel_disconnected': '네이티브 엔진에서 시작 후 터널이 예기치 않게 종료되었다고 보고했습니다.',
      'native_bridge_unavailable':
          '앱이 Android VPN 서비스에 접근할 수 없습니다. 앱을 닫았다가 다시 열고 시도하세요.',
      'native_operation_failed':
          '앱 오류로 VPN 작업이 중단되었습니다. 다시 시도하세요. 문제가 계속되면 진단을 실행하세요.',
      'invalid_arguments':
          '이 VPN 작업에 필요한 정보가 불완전합니다. 다시 시도하세요. 문제가 계속되면 진단을 실행하세요.',
      'invalid_account_id': '네이티브 작업이 유효한 계정 식별자와 연결되지 않았습니다.',
      'invalid_device_id': '네이티브 엔진으로 전송된 기기 식별자가 없거나 올바르지 않습니다.',
      'storage_key_not_allowed': 'Android 브리지가 허용된 저장소 목록 밖의 키를 차단했습니다.',
      'secure_storage_read_failed':
          'Android Keystore에서 이 계정의 로컬 데이터를 복호화하지 못했습니다.',
      'secure_storage_write_failed':
          'Android Keystore에서 로컬 데이터를 암호화하거나 저장하지 못했습니다.',
      'key_generation_failed': 'Android에서 보안 저장소의 WireGuard 키를 만들거나 읽지 못했습니다.',
      'csr_generation_failed':
          'Android Keystore에서 OpenVPN P-256 CSR을 만들거나 서명하지 못했습니다.',
      'other': '문서화되지 않은 네이티브 분기에서 오류가 발생했습니다. 아래에 표시된 진단 코드를 지원팀에 보내세요.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title => '권한 요청이 이미 열려 있음';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN 권한 요청이 이미 표시되어 있습니다. 다시 시도하기 전에 요청을 완료하세요.';

  @override
  String get notice_permissionRequestInterrupted_title => 'VPN 권한 요청 중단됨';

  @override
  String get notice_permissionRequestInterrupted_message =>
      '앱이 응답을 받기 전에 VPN 권한 화면이 닫혔습니다.';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN 연결이 확인되지 않음';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN 연결을 확인할 수 없어 안전을 위해 중지했습니다. 다시 시도하세요.';

  @override
  String get openvpnCleanup_title => 'OpenVPN 프로필 취소됨';

  @override
  String get openvpnCleanup_working => '취소된 OpenVPN 프로필을 중지하고 삭제하는 중…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPN 종료가 확인되지 않았습니다. 새 프로필을 만들기 전에 다시 시도하세요.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      '취소된 OpenVPN 프로필을 완전히 삭제하지 못했습니다. 정리를 다시 시도하세요.';

  @override
  String get openvpnCleanup_complete =>
      '취소된 OpenVPN 프로필이 삭제되었습니다. 새 프로필을 만들려면 연결을 누르세요.';

  @override
  String get network_title => '네트워크 구성';

  @override
  String get network_ipv4Fallback => 'IPv6을 일시적으로 사용할 수 없습니다. IPv4로 준비를 계속합니다.';

  @override
  String get network_rejectedTitle => '네트워크 구성 거부됨';

  @override
  String get network_rejectedMessage =>
      '터널 구성이 완전하지 않거나 승인된 주소와 일치하지 않습니다. 앱에서 다시 시도하세요.';

  @override
  String get network_unreadableTitle => '로컬 구성을 읽을 수 없음';

  @override
  String get network_unreadableMessage =>
      '저장된 OpenVPN 네트워크 구성을 사용할 수 없습니다. 앱에서 다시 연결하여 업데이트하세요.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => '네트워크 보호';

  @override
  String get protection_subtitle => 'VPN 연결이 해제되면 인터넷에 직접 접속하지 못하도록 차단합니다.';

  @override
  String get protection_active => '시스템 보호 활성화됨';

  @override
  String get protection_alwaysOnOnly => '항상 사용 VPN이 활성화됨. VPN 외부 차단을 켜세요';

  @override
  String get protection_inactive => '시스템 보호 비활성화됨';

  @override
  String get protection_unknown => '시스템 보호 확인';

  @override
  String get protection_openSettings => 'Android 설정 열기';

  @override
  String get protection_dialogTitle => '네트워크 보호 설정';

  @override
  String get protection_dialogMessage =>
      'Android는 항상 사용 VPN과 VPN 외부의 연결 차단을 관리합니다. FuzeVPN이 선택되어 있는지 확인하고 시스템 설정에서 차단을 활성화하세요.';

  @override
  String get protection_dialogOpen => '설정 열기';

  @override
  String get session_systemProtectionNote =>
      'Android가 VPN 외부 트래픽을 계속 차단하는 경우 시스템 설정을 열어 이 보호 기능을 확인하거나 변경하세요.';

  @override
  String get diagnostics_title => '진단';

  @override
  String get diagnostics_settingsTitle => '앱 진단';

  @override
  String get diagnostics_automaticTitle => '중요 오류 보내기';

  @override
  String get diagnostics_automaticDescription =>
      '중요한 오류가 발생하면 간단한 기술 보고서를 공유합니다.';

  @override
  String get diagnostics_privacy =>
      '전송된 보고서는 로그인한 계정에 연결되며 30일 동안 보관됩니다. 탐색 기록, 비밀번호 또는 VPN 키는 포함되지 않습니다.';

  @override
  String get diagnostics_manualOpen => '진단 실행';

  @override
  String get diagnostics_localDescription =>
      '앱과 VPN 상태에 관한 보고서를 만듭니다. 연결은 변경되지 않습니다.';

  @override
  String get diagnostics_sendReport => '보고서 보내기';

  @override
  String get diagnostics_sendHint => '보고서를 이 기기에만 보관하려면 이 상자의 선택을 해제하세요.';

  @override
  String get diagnostics_signedOut => '보고서를 보내려면 계정에 로그인하세요.';

  @override
  String get diagnostics_localLifetime => '앱을 닫은 후에도 보관하려면 이 보고서를 휴대전화에 저장하세요.';

  @override
  String get diagnostics_run => '진단 실행';

  @override
  String get diagnostics_rerun => '진단 다시 실행';

  @override
  String get diagnostics_running => '확인 중…';

  @override
  String get diagnostics_sending => '보고서 보내는 중…';

  @override
  String get diagnostics_prepared => '이 기기에서 보고서 준비됨';

  @override
  String get diagnostics_queued => '보고서 전송 대기 중';

  @override
  String get diagnostics_sent => '보고서 수신됨';

  @override
  String get diagnostics_failed => '전송 실패. 로컬 보고서는 계속 사용할 수 있습니다.';

  @override
  String get diagnostics_preparationFailed => '진단 보고서를 준비하지 못했습니다. 다시 시도하세요.';

  @override
  String get diagnostics_authenticationRequired => '보고서를 보내려면 다시 로그인하세요.';

  @override
  String get diagnostics_retry => '전송 다시 시도';

  @override
  String get diagnostics_export => '보고서 저장';

  @override
  String get diagnostics_exportFailed => '내보내기 실패. 로컬 보고서에서 다시 시도하세요.';

  @override
  String get diagnostics_preferenceFailed => '이 설정을 저장하지 못했습니다. 다시 시도하세요.';

  @override
  String diagnostics_receipt(Object id) {
    return '참조: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$date에 수신됨';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$date까지 보관됨';
  }

  @override
  String get diagnostics_duplicate => '이 보고서는 이미 수신되었습니다.';

  @override
  String get diagnostics_preview => '보고서 미리 보기';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '기술 이벤트 $count개 첨부됨',
      one: '기술 이벤트 1개 첨부됨',
      zero: '첨부된 기술 이벤트 없음',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => '기술 세부정보';

  @override
  String get diagnostics_empty => '아직 진단 보고서가 준비되지 않았습니다.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': '터널 상태',
      'handshake': '연결 확인',
      'certificate': 'VPN 인증서',
      'kill_switch': 'Android 보호',
      'connectivity': '사용 가능한 네트워크',
      'api_reachability': '서비스 접근',
      'secure_storage': '보안 저장소',
      'other': '로컬 확인',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': '확인됨',
      'failed': '확인 필요',
      'skipped': '테스트하지 않음 — 활성 프로브 없음',
      'unknown': '정보를 사용할 수 없음',
      'other': '정보를 사용할 수 없음',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPN에 오신 것을 환영합니다';

  @override
  String get connection_changeLocation => '위치 변경';

  @override
  String get connection_details => '연결 세부정보';

  @override
  String get locations_searchLabel => '도시 또는 국가 검색';

  @override
  String get locations_clearSearch => '검색 지우기';

  @override
  String get locations_filterAll => '모두';

  @override
  String get locations_filterFavorites => '즐겨찾기';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '위치 $count개',
      one: '위치 $count개',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => '위치를 찾을 수 없음';

  @override
  String get locations_noResultsHint => '다른 도시 또는 국가를 시도하세요.';

  @override
  String get locations_noFavorites => '가까이에서 확인하는 즐겨찾기';

  @override
  String get locations_noFavoritesHint => '위치 옆의 별표를 눌러 여기에 저장하세요.';

  @override
  String get locations_showAll => '모든 위치 보기';

  @override
  String locations_addFavorite(String name) {
    return '$name을(를) 즐겨찾기에 추가';
  }

  @override
  String locations_removeFavorite(String name) {
    return '즐겨찾기에서 $name 삭제';
  }

  @override
  String get locations_favoriteSaveFailed => '즐겨찾기를 저장하지 못했습니다. 다시 시도하세요.';

  @override
  String get locations_emptyTitle => '사용 가능한 위치 없음';

  @override
  String get locations_emptyHint => '목록을 새로 고쳐 다시 시도하세요.';

  @override
  String get devices_manage => '내 기기 관리';

  @override
  String get settings_personalization => '나에게 맞게 설정';

  @override
  String get settings_safety => '보호';

  @override
  String get settings_help => '도움이 필요하신가요?';

  @override
  String get settings_about => 'FuzeVPN 정보';

  @override
  String get diagnostics_heading => '연결 문제 이해하기';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': '사용 가능',
      'pending': '준비 중',
      'revoked': '삭제됨',
      'expired': '만료됨',
      'other': '상태를 사용할 수 없음',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => '환경설정이 저장되지 않음';

  @override
  String get notice_preferenceSave_message =>
      '선택 사항은 현재 적용되었지만 저장하지 못했습니다. 앱을 닫은 후에도 유지하려면 다시 시도하세요.';

  @override
  String get connection_androidDisconnectHint =>
      'Android에서 VPN을 계속 활성 상태로 유지하는 경우 열리는 설정에서 항상 사용 VPN을 끄세요.';

  @override
  String get protection_learnMore => 'Android 보호에 대해 알아보기';

  @override
  String get protection_guideWhy =>
      '이 보호 기능은 VPN 연결이 끊어졌을 때 앱이 인터넷을 직접 사용하지 못하게 합니다. Android에서 구성됩니다.';

  @override
  String get protection_guideAlwaysOnTitle => '항상 사용 VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android는 VPN 서비스를 계속 실행하고 휴대전화가 재부팅된 후 다시 시작할 수 있습니다.';

  @override
  String get protection_guideBlockTitle => 'VPN 없이 연결 차단';

  @override
  String get protection_guideBlock =>
      '이 설정은 연결이 중단된 동안을 포함하여 트래픽이 VPN을 우회하지 못하게 합니다.';

  @override
  String get protection_guideWarning =>
      '이 차단을 활성화하면 VPN이 연결될 때까지 인터넷 접근이 차단됩니다.';

  @override
  String get protection_guideStepsTitle => '보호 켜기';

  @override
  String get protection_guideStep1 => '아래 버튼으로 Android VPN 설정을 여세요.';

  @override
  String get protection_guideStep2 => 'FuzeVPN 옆의 톱니바퀴 아이콘으로 옵션을 여세요.';

  @override
  String get protection_guideStep3 =>
      '항상 사용 VPN을 활성화한 다음, 해당 옵션이 있으면 VPN 없이 연결 차단을 활성화하세요.';

  @override
  String get protection_guideManufacturers =>
      '휴대전화에 따라 이름이 다릅니다. 필요한 경우 설정에서 VPN을 검색하세요. 네트워크 및 인터넷 아래에 있는 경우가 많습니다.';

  @override
  String get protection_guideDisableTitle => '이 보호 기능 끄기';

  @override
  String get protection_guideDisable =>
      '같은 설정에서 VPN 없이 차단을 끄면 VPN 없이 인터넷에 접근할 수 있습니다. Android가 VPN을 다시 시작하지 않도록 하려면 항상 사용 VPN도 끄세요.';

  @override
  String get protection_guideManual =>
      '이 설정은 Android에서 직접 선택합니다. FuzeVPN이 대신 변경하지 않습니다.';

  @override
  String get locations_changeTitle => '위치를 변경하시겠습니까?';

  @override
  String locations_changeActive(String name) {
    return 'VPN 연결이 해제된 다음 $name에 연결을 시도합니다.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN이 $name에 연결을 시도합니다.';
  }

  @override
  String get locations_confirmChange => '변경 후 연결';

  @override
  String get locations_changeBusy => '변경이 진행 중입니다. 다른 위치를 선택하기 전에 기다리세요.';

  @override
  String get locations_automaticSelection => '자동 선택';

  @override
  String get locations_cities => '도시';

  @override
  String get locations_servers => '서버';

  @override
  String locations_viewCities(String name) {
    return '$name의 도시 보기';
  }

  @override
  String locations_viewServers(String name) {
    return '$name의 서버 보기';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '국가 $count개',
      one: '국가 $count개',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '도시 $count개',
      one: '도시 $count개',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '서버 $count개',
      one: '서버 $count개',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => '모든 국가';

  @override
  String get locations_backToCountries => '국가로 돌아가기';

  @override
  String locations_backToCities(String name) {
    return '$name의 도시로 돌아가기';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$name 선택';
  }

  @override
  String locations_chooseCity(String name) {
    return '$name 선택';
  }

  @override
  String get locations_noCompatibleServer => '호환되는 서버를 사용할 수 없습니다.';

  @override
  String get externalLink_failed => '이 링크를 열 수 없습니다. 링크를 복사하여 브라우저에서 열 수 있습니다.';

  @override
  String get externalLink_copy => '링크 복사';

  @override
  String get externalLink_copied => '링크가 복사되었습니다';

  @override
  String get externalLink_copyFailed => '링크를 복사할 수 없습니다. 아래 주소를 선택하세요.';

  @override
  String get settings_deleteAccount => '내 계정 삭제';

  @override
  String get settings_deleteAccountDetail => '계정 삭제 요청 방법 보기';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'VPN 구독을 선택하세요.';

  @override
  String get billing_subscribe => '구독하기';

  @override
  String get billing_choosePlan => '계속하려면 요금제를 선택하세요.';

  @override
  String get billing_monthly => '월간';

  @override
  String get billing_yearly => '연간';

  @override
  String get billing_continue => 'Google Play로 계속';

  @override
  String get billing_restore => '구매 복원';

  @override
  String get billing_manage => '구독 관리';

  @override
  String get billing_deleteAccountWarning =>
      'Google Play 구독이 있는 경우 FuzeVPN 계정을 삭제해도 자동 갱신은 취소되지 않습니다. Google Play에서 자동 갱신을 별도로 관리하거나 취소하세요.';

  @override
  String get billing_deleteAccountContinue => '계정 삭제 요청으로 계속';

  @override
  String get billing_refresh => '이용 권한 새로고침';

  @override
  String get billing_loadingPlans => '요금제 불러오는 중…';

  @override
  String get billing_unavailable => '현재 이용 가능한 요금제가 없습니다. 나중에 다시 시도하세요.';

  @override
  String get billing_comingSoon => '구독 서비스가 곧 제공됩니다.';

  @override
  String get billing_priceDisclosure =>
      '가격은 Google Play에서 제공합니다. 확정하기 전에 최종 금액 및 적용 세금을 확인할 수 있습니다.';

  @override
  String get billing_renewalMonthly =>
      '취소하지 않으면 매월 자동 갱신됩니다. Google Play 구독에서 언제든지 취소할 수 있습니다.';

  @override
  String get billing_renewalYearly =>
      '취소하지 않으면 매년 자동 갱신됩니다. Google Play 구독에서 언제든지 취소할 수 있습니다.';

  @override
  String get billing_active => 'Premium 이용 권한이 활성화되어 있습니다';

  @override
  String billing_accessUntil(String date) {
    return '$date까지 이용할 수 있습니다.';
  }

  @override
  String get billing_webManaged => '구독은 FuzeVPN 웹사이트에서 관리됩니다.';

  @override
  String get billing_playManaged => '구독은 Google Play에서 관리됩니다.';

  @override
  String get billing_inactive => '활성 구독이 없습니다.';

  @override
  String get billing_checkingAccess => '이용 권한 확인 중…';

  @override
  String get billing_restoring => '구매 복원 중…';

  @override
  String get billing_pending => '결제가 대기 중입니다. 확인 후 이용 권한이 활성화됩니다.';

  @override
  String get billing_cancelled => '구매가 취소되었습니다. 새 구독이 활성화되지 않았습니다.';

  @override
  String get billing_verifying => '구매 확인 중…';

  @override
  String get billing_success => '구독이 활성화되었습니다. Premium을 이용할 수 있습니다.';

  @override
  String get billing_restored => '구매가 복원되었습니다.';

  @override
  String get billing_restoreEmpty => '이 Google Play 계정에는 복원할 구매가 없습니다.';

  @override
  String get billing_catalogError => '요금제를 불러올 수 없습니다. 다시 시도하세요.';

  @override
  String get billing_purchaseError => '구매를 시작할 수 없습니다. 다시 시도하세요.';

  @override
  String get billing_verificationError =>
      '구매 확인을 일시적으로 사용할 수 없습니다. 구매를 복원하여 다시 시도하세요.';

  @override
  String get billing_restoreError => '구매를 복원할 수 없습니다. 다시 시도하세요.';

  @override
  String get billing_managementError => '구독 관리를 열 수 없습니다. 다시 시도하세요.';

  @override
  String get billing_storeUnavailable => '이 기기에서는 Google Play를 사용할 수 없습니다.';

  @override
  String get welcome_title => 'VPN을 더 간편하게.';

  @override
  String get welcome_description => '연결을 보호하세요. 개인정보를 직접 관리하세요.';

  @override
  String get welcome_start => '시작하기';

  @override
  String get welcome_alreadyPurchased => '이미 구매하셨나요?';

  @override
  String get welcome_noAccountRequired => '계정을 만들지 않고 시작할 수 있습니다.';

  @override
  String get guest_accountTitle => '계정이 연결되지 않음';

  @override
  String get guest_accountDescription =>
      '같은 Google Play 계정으로 구매를 복원하면 다른 기기에서도 구독을 사용할 수 있습니다.';

  @override
  String get guest_existingSubscriberSignIn => '이미 구독 중이신가요? 로그인';

  @override
  String get guest_claimTitle => '어디서나 FuzeVPN과 함께';

  @override
  String get guest_claimDescription =>
      '다른 기기에서도 구독을 사용하려면 계정을 만드세요. 이 단계는 선택 사항입니다.';

  @override
  String get guest_skip => '나중에';

  @override
  String get guest_activationTitle => 'Fuze Premium이 활성화되었습니다';

  @override
  String get guest_activationDescription =>
      '구독이 준비되었습니다. VPN을 사용하고 원할 때 계정을 만드세요.';

  @override
  String get guest_useVpn => 'VPN 사용하기';

  @override
  String get guest_loginRequired =>
      '이 구매는 이미 FuzeVPN 계정에 연결되어 있습니다. 해당 계정에 로그인하여 구독을 이용하세요.';

  @override
  String get guest_signOutWarning =>
      '같은 Google Play 계정으로 구매를 복원하면 구독을 복구할 수 있습니다.';

  @override
  String get guest_profileUnavailable =>
      '계정이 이미 연결되어 있습니다. 로그인하여 정보를 확인하고 관리하세요.';

  @override
  String get billing_acceptance => '계속하면 이용약관 및 개인정보 처리방침에 동의하는 것으로 간주됩니다.';

  @override
  String get guest_verifyEmailReminder =>
      '계정을 보호하려면 이메일 주소를 확인하세요. VPN은 계속 사용할 수 있습니다.';

  @override
  String get guest_serviceUnavailable =>
      '서비스를 일시적으로 사용할 수 없습니다. 잠시 후 다시 시도하세요.';

  @override
  String get guest_restoreError =>
      '구매를 복원할 수 없습니다. 구매에 사용한 Google Play 계정으로 다시 시도하세요.';

  @override
  String get guest_claimSuccess => '계정이 생성되었습니다. 구독과 VPN 이용 권한은 유지됩니다.';

  @override
  String get guest_emailExists =>
      '이미 사용 중인 이메일입니다. 다른 주소를 선택하거나 기존 계정에 로그인하세요. 구매는 Google Play를 통해 계속 이용할 수 있습니다.';

  @override
  String get guest_claimError =>
      '계정을 생성할 수 없습니다. VPN은 계속 사용할 수 있으며 나중에 다시 시도할 수 있습니다.';

  @override
  String get guest_secureStorageError =>
      '이 기기에서 세션을 안전하게 저장할 수 없습니다. 다시 시도하세요.';

  @override
  String get guest_premiumRequired => 'VPN을 활성화하려면 구독을 선택하세요.';

  @override
  String get welcome_viewPlans => '요금제 보기';

  @override
  String get google_continue => 'Google로 계속하기';

  @override
  String get google_or => '또는';

  @override
  String get google_title => 'FuzeVPN 계정';

  @override
  String get google_settingUp => '계정 생성 완료';

  @override
  String get google_country => '거주 국가';

  @override
  String get google_profileDescription =>
      '국가를 선택하고 두 문서를 검토하여 FuzeVPN 계정을 만드세요.';

  @override
  String get google_claimDescription =>
      '게스트 계정을 Google에 연결하세요. 구독과 기기는 이 계정에 그대로 연결됩니다.';

  @override
  String get google_linkTitle => 'Google을 FuzeVPN에 연결';

  @override
  String get google_linkDescription =>
      '기존 FuzeVPN 계정의 접근 권한을 확인하세요. Google 비밀번호는 요청하지 않습니다.';

  @override
  String get google_password => 'FuzeVPN 비밀번호';

  @override
  String get google_linkAccount => '연결 확인';

  @override
  String get google_requestEmail => '확인 이메일 받기';

  @override
  String get google_emailInstructions => 'FuzeVPN 이메일을 열고 확인 코드를 입력하세요.';

  @override
  String get google_emailCode => '이메일 확인 코드';

  @override
  String get google_confirmEmail => '코드 확인';

  @override
  String get google_restart => '다른 Google 계정 선택';

  @override
  String get google_resume => '이번 시도 확인';

  @override
  String get google_unavailable =>
      'Google 로그인을 사용할 수 없습니다. 이메일과 비밀번호를 사용할 수 있습니다.';

  @override
  String get google_expired => '이번 시도가 만료되었습니다. 취소한 후 다시 시작하세요.';

  @override
  String get google_conflict =>
      '이 Google 계정은 다른 계정에 연결되어 있습니다. 현재 계정과 구독은 유지됩니다.';

  @override
  String get google_error => 'Google 로그인에 실패했습니다. 다시 시도하세요. 현재 접근 권한은 유지됩니다.';

  @override
  String get google_uncertain => '결과를 확인할 수 없습니다. 이번 시도를 확인하거나 취소한 후 다시 시작하세요.';

  @override
  String get google_cancelFailed =>
      '취소를 확인할 수 없습니다. 이 화면을 나가기 전에 취소를 다시 시도하세요.';

  @override
  String get google_cancelled => 'Google 로그인이 취소되었습니다.';

  @override
  String get google_selecting => 'Google 계정을 선택하세요…';

  @override
  String get google_verifying => '계정 확인 중…';

  @override
  String get google_emailUnavailable => '확인 이메일을 보내지 못했습니다. 나중에 다시 시도하세요.';

  @override
  String get google_emailSent => '확인 이메일을 보냈습니다. 받은편지함을 확인하세요.';

  @override
  String get google_rateLimited => '잠시 기다린 후 다시 시도하세요.';

  @override
  String get google_invalidPassword => 'FuzeVPN 비밀번호가 올바르지 않습니다. 현재 계정은 유지됩니다.';

  @override
  String get google_invalidCode => '확인 코드가 올바르지 않거나 만료되었습니다.';

  @override
  String get google_accountChanged => '세션이 변경되었습니다. 이번 시도를 취소한 후 다시 시작하세요.';

  @override
  String get google_invalidResponse => '응답을 검증할 수 없습니다. 현재 접근 권한은 유지됩니다.';

  @override
  String get google_invalidRegistration => '국가와 두 동의 항목을 확인하세요.';

  @override
  String get google_consentRequired => '계속하려면 국가를 선택하고 두 문서에 동의하세요.';

  @override
  String get google_challengeRequired => '추가 보안 확인이 필요합니다. 현재 접근 권한은 유지됩니다.';

  @override
  String get google_challengeUnavailable => '보안 확인을 사용할 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get billing_trialTitle => 'Fuze Premium을 무료로 체험하세요';

  @override
  String get billing_trialSubtitle => '오늘부터 연결을 보호하세요.';

  @override
  String get billing_trialWeeks => '2주 무료 체험';

  @override
  String billing_trialDays(String days) {
    return '$days일 무료 체험';
  }

  @override
  String get billing_trialStart => '무료 체험 시작';

  @override
  String billing_trialFirstCharge(String date) {
    return '오늘 시작하면 첫 결제 예정일은 $date입니다.';
  }

  @override
  String get billing_trialTerms =>
      '표시된 가격으로 자동 갱신됩니다. 결제를 피하려면 체험이 끝나기 전에 Google Play에서 취소하세요.';

  @override
  String billing_trialThenMonthly(String price) {
    return '이후 월 $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return '이후 연 $price';
  }

  @override
  String get billing_choosePeriod => '요금제 선택';

  @override
  String get billing_selectionHint => '계속하려면 요금제를 선택하세요.';

  @override
  String get billing_benefitConnection => '암호화된 연결';

  @override
  String get billing_benefitPrivacy => '온라인 개인정보 보호';

  @override
  String get billing_benefitNoAccount => '가입은 선택 사항';

  @override
  String get billing_cancellation => 'Google Play에서 취소';

  @override
  String get billing_premiumTitle => '더 안전하게 보호되는 연결.';

  @override
  String get billing_premiumSubtitle => '나에게 맞는 요금제로 연결을 보호하세요.';

  @override
  String get billing_priceMonthly => '월';

  @override
  String get billing_priceYearly => '연';

  @override
  String get billing_trialToday => '오늘은 결제할 금액이 없습니다';

  @override
  String get billing_trialConfirmation =>
      '확정하기 전에 Google Play에서 날짜, 최종 금액 및 적용 세금을 확인할 수 있습니다.';

  @override
  String get billing_offerChanged => '이 혜택의 조건이 변경되었습니다. 요금제를 새로고침하고 다시 선택하세요.';

  @override
  String get status_waitingNetwork => '네트워크 대기 중';

  @override
  String get status_waitingNetworkDetail =>
      '사용 가능한 네트워크가 없습니다. 네트워크가 복구되면 VPN 연결을 확인합니다.';

  @override
  String get locations_favoriteLoadFailed => '즐겨찾기를 불러오지 못했습니다. 다시 시도하세요.';

  @override
  String get locations_favoritesLoading => '즐겨찾기 불러오는 중…';
}
