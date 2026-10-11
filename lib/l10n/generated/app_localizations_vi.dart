// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Bảo vệ kết nối của bạn';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN sử dụng dịch vụ VPN của Android (VpnService) để tạo đường hầm mã hóa giữa thiết bị này và máy chủ FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Khi VPN hoạt động, lưu lượng Internet của các ứng dụng, địa chỉ đích và yêu cầu DNS đi qua đường hầm này để định tuyến kết nối của bạn, ngay cả khi FuzeVPN chạy trong nền.';

  @override
  String get vpnDisclosure_statusBody =>
      'Ứng dụng sử dụng trạng thái kết nối, thời lượng và lượng dữ liệu đã truyền để hiển thị kết nối VPN của bạn. Bạn có thể dừng kết nối bất cứ lúc nào.';

  @override
  String get vpnDisclosure_privacy => 'Quyền riêng tư';

  @override
  String get vpnDisclosure_accept => 'Đồng ý và tiếp tục';

  @override
  String get vpnDisclosure_decline => 'Để sau';

  @override
  String get accountRestoration_title => 'Tài khoản tạm thời không khả dụng';

  @override
  String get accountRestoration_message =>
      'Phiên của bạn vẫn được giữ lại. Hãy thử lại để khôi phục tài khoản; bạn vẫn có thể quản lý kết nối VPN tại đây.';

  @override
  String get action_retry => 'Thử lại';

  @override
  String get session_endingTitle => 'Đang kết thúc phiên';

  @override
  String get session_ending =>
      'Phiên của bạn đã bị vô hiệu hóa. Đang dừng VPN và xóa phiên…';

  @override
  String get session_stopFailed =>
      'Chưa xác nhận việc tắt VPN. Hãy thử lại trước khi đăng nhập lần nữa.';

  @override
  String get session_cleanupFailed =>
      'VPN đã dừng nhưng chưa xác nhận việc xóa phiên. Hãy thử dọn dẹp lại.';

  @override
  String get session_retryStop => 'Thử tắt lại';

  @override
  String get session_retryCleanup => 'Thử dọn dẹp lại';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Đang chuẩn bị FuzeVPN an toàn…';

  @override
  String get nav_connection => 'Kết nối';

  @override
  String get nav_locations => 'Vị trí';

  @override
  String get nav_account => 'Tài khoản';

  @override
  String get nav_devices => 'Thiết bị';

  @override
  String get nav_settings => 'Cài đặt';

  @override
  String get action_refresh => 'Làm mới';

  @override
  String get auth_tab_login => 'Đăng nhập';

  @override
  String get auth_tab_register => 'Đăng ký';

  @override
  String get auth_stepAccount => 'Tài khoản';

  @override
  String get auth_stepIdentity => 'Danh tính';

  @override
  String get auth_stepAddress => 'Địa chỉ và thỏa thuận';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Bước $current trên $total';
  }

  @override
  String get auth_tagline => 'VPN của bạn, đơn giản hơn.';

  @override
  String get auth_keysLocal =>
      'Các khóa VPN riêng tư của bạn được lưu trên thiết bị này.';

  @override
  String get form_email => 'Địa chỉ email';

  @override
  String get form_password => 'Mật khẩu';

  @override
  String get form_showPassword => 'Hiện mật khẩu';

  @override
  String get form_hidePassword => 'Ẩn mật khẩu';

  @override
  String get form_passwordMin =>
      '8–72 byte UTF-8. Một số ký tự sử dụng nhiều hơn một byte.';

  @override
  String get form_firstName => 'Tên';

  @override
  String get form_lastName => 'Họ';

  @override
  String get form_phone => 'Số điện thoại (+33612345678)';

  @override
  String get form_address => 'Địa chỉ';

  @override
  String get form_address2 => 'Dòng địa chỉ 2 (không bắt buộc)';

  @override
  String get form_postalCode => 'Mã bưu chính';

  @override
  String get form_city => 'Thành phố';

  @override
  String get form_country => 'Mã quốc gia (ví dụ: FR)';

  @override
  String get action_login => 'Đăng nhập';

  @override
  String get action_createAccount => 'Tạo tài khoản';

  @override
  String get action_createMyAccount => 'Tạo tài khoản của tôi';

  @override
  String get action_next => 'Tiếp tục';

  @override
  String get action_previous => 'Quay lại';

  @override
  String get action_forgotPassword => 'Quên mật khẩu?';

  @override
  String get auth_noAccount => 'Bạn chưa có tài khoản?';

  @override
  String get auth_requiredInformation => 'Tạo tài khoản của bạn qua ba bước.';

  @override
  String get auth_termsPrefix => 'Tôi chấp nhận ';

  @override
  String get auth_termsLink => 'điều khoản sử dụng';

  @override
  String get auth_privacyPrefix => 'Tôi chấp nhận ';

  @override
  String get auth_privacyLink => 'chính sách quyền riêng tư';

  @override
  String get auth_consentRequired => 'Bạn phải đồng ý để tạo tài khoản.';

  @override
  String get validation_required => 'Bạn phải điền trường này.';

  @override
  String get validation_email => 'Hãy nhập một địa chỉ email hợp lệ.';

  @override
  String get validation_password =>
      'Mật khẩu quá ngắn: tối thiểu 8 byte UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Mật khẩu quá dài: tối đa 72 byte UTF-8.';

  @override
  String get validation_phone =>
      'Hãy sử dụng định dạng quốc tế, ví dụ: +33612345678.';

  @override
  String get validation_country =>
      'Hãy sử dụng mã quốc gia gồm hai chữ cái, ví dụ: FR.';

  @override
  String get passwordReset_title => 'Đặt lại mật khẩu';

  @override
  String get passwordReset_description =>
      'Nhập địa chỉ email tài khoản của bạn để yêu cầu liên kết đặt lại mật khẩu.';

  @override
  String get passwordReset_send => 'Gửi liên kết';

  @override
  String get connection_title => 'Kết nối của bạn';

  @override
  String get connection_subtitle => 'Chọn một vị trí, sau đó bật VPN.';

  @override
  String get connection_prepare => 'Sẵn sàng kết nối?';

  @override
  String get connection_advancedOptions => 'Tùy chọn nâng cao';

  @override
  String get connection_location => 'Vị trí';

  @override
  String get connection_chooseLocation => 'Chọn một vị trí';

  @override
  String get connection_protocol => 'Giao thức';

  @override
  String get connection_connect => 'Kết nối';

  @override
  String get connection_connecting => 'Đang kết nối…';

  @override
  String get connection_disconnect => 'Ngắt kết nối';

  @override
  String get connection_disconnecting => 'Đang ngắt kết nối';

  @override
  String get connection_locationChange => 'Đang thay đổi vị trí…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol không khả dụng';
  }

  @override
  String get connection_activeLocation => 'Vị trí đang hoạt động';

  @override
  String get connection_duration => 'Thời lượng';

  @override
  String get connection_received => 'Đã nhận';

  @override
  String get connection_sent => 'Đã gửi';

  @override
  String get connection_lastHandshake => 'Lần trao đổi bảo mật gần nhất';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration trước';
  }

  @override
  String get verification_title => 'Xác nhận địa chỉ email của bạn';

  @override
  String get verification_message =>
      'Xác nhận địa chỉ email của bạn để sử dụng VPN trên điện thoại này.';

  @override
  String get verification_resend => 'Gửi lại email';

  @override
  String get migration_title => 'Thay đổi vị trí';

  @override
  String get migration_draining => 'Đang chuẩn bị thay đổi vị trí…';

  @override
  String get migration_activating => 'Đang kích hoạt máy chủ mới…';

  @override
  String get migration_ready => 'Đã cập nhật vị trí.';

  @override
  String get migration_blocked =>
      'Việc thay đổi vị trí cần máy chủ can thiệp. Hãy thử lại sau hoặc liên hệ bộ phận hỗ trợ.';

  @override
  String get migration_progress => 'Tiến trình thay đổi vị trí';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Khoảng thời gian giữa các lần kiểm tra: $seconds giây.';
  }

  @override
  String get migration_resume => 'Tiếp tục thay đổi vị trí';

  @override
  String get status_authorizing => 'Cần cấp quyền';

  @override
  String get status_authorizingDetail =>
      'Chấp nhận yêu cầu của Android để cho phép VPN.';

  @override
  String get status_preparing => 'Đang chuẩn bị';

  @override
  String get status_preparingDetail => 'Đang chuẩn bị kết nối bảo mật của bạn.';

  @override
  String get status_reconnecting => 'Đang kết nối lại…';

  @override
  String get status_reconnectingDetail =>
      'Kết nối bị gián đoạn. VPN đang cố gắng kết nối lại.';

  @override
  String get status_connecting => 'Đang kết nối';

  @override
  String get status_connectingDetail => 'Đang kết nối với máy chủ VPN…';

  @override
  String get status_connected => 'Đã kết nối';

  @override
  String get status_connectedDetail => 'Kết nối VPN của bạn đang hoạt động.';

  @override
  String get status_disconnecting => 'Đang ngắt kết nối';

  @override
  String get status_disconnectingDetail => 'Kết nối VPN của bạn đang dừng.';

  @override
  String get status_error => 'Kết nối không khả dụng';

  @override
  String get status_errorDetail => 'Chưa xác nhận kết nối VPN. Hãy thử lại.';

  @override
  String get status_idle => 'Đã ngắt kết nối';

  @override
  String get status_idleDetail => 'Kết nối VPN để bảo vệ kết nối của bạn.';

  @override
  String get trust_note =>
      'Đóng ứng dụng không dừng VPN. Để dừng VPN, hãy chọn Ngắt kết nối.';

  @override
  String get locations_none => 'Hiện không có vị trí nào khả dụng.';

  @override
  String get locations_available => 'Chọn vị trí tiếp theo của bạn.';

  @override
  String get locations_selected => 'Vị trí đã chọn';

  @override
  String get locations_select => 'Chọn vị trí này';

  @override
  String get locations_lockedTunnel => 'Ngắt kết nối VPN để thay đổi vị trí.';

  @override
  String get locations_lockedMigration =>
      'Chờ quá trình thay đổi vị trí hoàn tất.';

  @override
  String get devices_title => 'Các thiết bị của bạn';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit thiết bị';
  }

  @override
  String get devices_refresh => 'Làm mới thiết bị';

  @override
  String get devices_empty => 'Chưa có thiết bị VPN nào được đăng ký.';

  @override
  String get devices_firstConnection =>
      'Điện thoại của bạn sẽ được thêm vào lần kết nối đầu tiên.';

  @override
  String get devices_thisDevice => 'Thiết bị này';

  @override
  String devices_added(Object date) {
    return 'Đã thêm vào $date';
  }

  @override
  String get action_remove => 'Xóa';

  @override
  String get settings_title => 'Cài đặt';

  @override
  String get settings_subtitle =>
      'Tất cả tùy chọn và tài khoản của bạn ở cùng một nơi.';

  @override
  String get settings_appearance => 'Giao diện';

  @override
  String get settings_language => 'Ngôn ngữ';

  @override
  String get settings_languageDescription =>
      'Ngôn ngữ bạn chọn cũng được áp dụng cho các thông báo VPN.';

  @override
  String get settings_account => 'Tài khoản';

  @override
  String get settings_signOut => 'Đăng xuất';

  @override
  String get settings_privacy => 'Chính sách quyền riêng tư';

  @override
  String get settings_terms => 'Điều khoản sử dụng';

  @override
  String get settings_security => 'Bảo mật và minh bạch';

  @override
  String get settings_licenses => 'Giấy phép thành phần';

  @override
  String get settings_licensesDetail => 'Phần mềm được sử dụng trong ứng dụng';

  @override
  String get settings_background =>
      'VPN vẫn hoạt động khi bạn rời ứng dụng. Để dừng VPN, hãy chọn Ngắt kết nối trong tab Kết nối.';

  @override
  String get theme_system => 'Theo hệ thống';

  @override
  String get theme_light => 'Sáng';

  @override
  String get theme_dark => 'Tối';

  @override
  String get language_system => 'Ngôn ngữ điện thoại';

  @override
  String get language_fr => 'Tiếng Pháp';

  @override
  String get language_en => 'Tiếng Anh';

  @override
  String get language_es => 'Tiếng Tây Ban Nha';

  @override
  String get language_de => 'Tiếng Đức';

  @override
  String get dialog_removeDevice => 'Xóa thiết bị này?';

  @override
  String get dialog_removeCurrent =>
      'Điện thoại này sẽ ngắt kết nối khỏi VPN và mất quyền truy cập. Dữ liệu kết nối VPN của điện thoại sẽ được xóa sau khi máy chủ xác nhận.';

  @override
  String dialog_removeOther(Object name) {
    return 'Quyền truy cập VPN của “$name” sẽ bị thu hồi. Bạn không thể hoàn tác thao tác này.';
  }

  @override
  String get dialog_signOut => 'Đăng xuất?';

  @override
  String get dialog_signOutMessage =>
      'VPN sẽ dừng và bạn sẽ phải đăng nhập lại. Các khóa VPN đã mã hóa của bạn vẫn được giữ trên điện thoại này để sử dụng cho lần kết nối tiếp theo.';

  @override
  String get action_cancel => 'Hủy';

  @override
  String get action_signOut => 'Đăng xuất';

  @override
  String get notice_close => 'Bỏ qua thông báo';

  @override
  String get notice_sessionExpired_title => 'Phiên đã hết hạn';

  @override
  String get notice_sessionExpired_message =>
      'Phiên của bạn đã hết hạn. Hãy đăng nhập lại.';

  @override
  String get notice_connectionFailed_title => 'Kết nối thất bại';

  @override
  String get notice_invalidCredentials_message =>
      'Địa chỉ email hoặc mật khẩu không chính xác.';

  @override
  String get notice_emailVerification_title => 'Cần xác nhận email';

  @override
  String get notice_emailVerification_message =>
      'Hãy xác nhận địa chỉ email trước khi thêm thiết bị VPN.';

  @override
  String get notice_rateLimited_title => 'Quá nhiều lần thử';

  @override
  String get notice_deviceLimit_title => 'Đã đạt giới hạn 2 thiết bị';

  @override
  String get notice_deviceLimit_message =>
      'Hãy xóa một thiết bị hiện có trước khi thêm thiết bị khác.';

  @override
  String get notice_identityRenewal_title => 'Cần gia hạn danh tính VPN';

  @override
  String get notice_identityRenewal_message =>
      'Danh tính này đã bị xóa. Hãy tạo một danh tính cục bộ mới.';

  @override
  String get notice_migrationPending_title => 'Đang thay đổi vị trí';

  @override
  String get notice_migrationPending_message =>
      'Một quá trình thay đổi vị trí đang diễn ra.';

  @override
  String get notice_migrationBlocked_title => 'Thay đổi vị trí bị chặn';

  @override
  String get notice_migrationBlocked_message =>
      'Việc thay đổi vị trí cần máy chủ can thiệp. Hãy thử lại sau hoặc liên hệ bộ phận hỗ trợ.';

  @override
  String get notice_targetUnavailable_title =>
      'Máy chủ tạm thời không khả dụng';

  @override
  String get notice_targetUnavailable_message =>
      'Máy chủ này tạm thời không khả dụng.';

  @override
  String get notice_networkUnavailable_title =>
      'Kết nối Internet không khả dụng';

  @override
  String get notice_networkUnavailable_message =>
      'Hãy kiểm tra kết nối của bạn rồi thử lại.';

  @override
  String get notice_permissionDenied_title => 'Quyền VPN bị từ chối';

  @override
  String get notice_permissionDenied_message =>
      'Hãy bắt đầu lại kết nối và chấp nhận yêu cầu cấp quyền của Android.';

  @override
  String get notice_wireguardTimeout_title => 'Máy chủ không phản hồi';

  @override
  String get notice_wireguardTimeout_message =>
      'Kết nối WireGuard mất quá nhiều thời gian. Hãy thử lại hoặc chọn vị trí khác.';

  @override
  String get notice_tlsFailed_title => 'Kết nối bảo mật bị từ chối';

  @override
  String get notice_tlsFailed_message =>
      'Máy chủ không chấp nhận kết nối OpenVPN. Hãy thử lại. Nếu vấn đề vẫn tiếp diễn, hãy chạy chẩn đoán.';

  @override
  String get notice_tunRejected_title => 'Android từ chối giao diện VPN';

  @override
  String get notice_tunRejected_message =>
      'Android từ chối cấu hình mạng mà OpenVPN yêu cầu.';

  @override
  String get notice_openvpnStart_title => 'Không thể khởi động OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'Công cụ OpenVPN không thể hoàn tất quá trình khởi động. Hãy thử lại. Nếu vấn đề vẫn tiếp diễn, hãy liên hệ bộ phận hỗ trợ.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Mã chẩn đoán: $code';
  }

  @override
  String get notice_generic_title => 'Kết nối VPN thất bại';

  @override
  String get notice_generic_message => 'Đã xảy ra lỗi. Hãy thử lại sau.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Đã tạo tài khoản',
      'password_reset_sent': 'Đã nhận yêu cầu đặt lại mật khẩu',
      'verification_email_sent': 'Đã gửi email xác minh',
      'location_migration_pending': 'Đang thay đổi vị trí',
      'vpn_sign_in_required': 'Cần đăng nhập',
      'protocol_unavailable_at_location': 'Giao thức không khả dụng',
      'vpn_permission_denied': 'Quyền VPN bị từ chối',
      'revoked_identity_device_limit': 'Đã đạt giới hạn 2 thiết bị',
      'tunnel_start_unexpected': 'Không thể khởi động VPN',
      'flutter_disconnect_timeout': 'Chưa xác nhận ngắt kết nối',
      'flutter_disconnect_unexpected': 'Không thể ngắt kết nối',
      'device_revoked': 'Đã xóa thiết bị',
      'revoke_unexpected': 'Không thể xóa thiết bị',
      'identity_renewal_unexpected': 'Không thể gia hạn danh tính',
      'openvpn_renewal_unexpected': 'Không thể gia hạn OpenVPN',
      'location_migration_blocked': 'Thay đổi vị trí bị chặn',
      'location_migration_slow': 'Quá trình thay đổi vị trí vẫn đang diễn ra',
      'location_migration_conflict': 'Cần làm mới để thay đổi vị trí',
      'location_migration_verification_failed': 'Chưa xác nhận thay đổi vị trí',
      'location_migration_device_changed':
          'Thiết bị đã thay đổi trong quá trình thay đổi vị trí',
      'tunnel_stop_failed': 'Thay đổi vị trí không khả dụng',
      'other': 'Thao tác thất bại',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Đã tạo tài khoản nhưng không thể gửi email xác minh. Hãy dùng chức năng gửi lại trong ứng dụng.',
      'password_reset_sent':
          'Đã nhận yêu cầu của bạn. Nếu có tài khoản khớp với địa chỉ này, bạn có thể nhận được email. Vui lòng kiểm tra cả thư mục spam.',
      'verification_email_sent': 'Một email xác minh mới vừa được gửi.',
      'location_migration_pending':
          'Quá trình chuyển đến $target vẫn đang được chuẩn bị. Bạn có thể tiếp tục mà không cần tạo lại thiết bị.',
      'vpn_sign_in_required':
          'Hãy đăng nhập vào tài khoản trước khi khởi động VPN.',
      'protocol_unavailable_at_location':
          'Vị trí này không cung cấp giao thức đã chọn. Hãy làm mới danh sách vị trí hoặc chọn giao thức khác.',
      'vpn_permission_denied':
          'Android đã từ chối quyền VPN. Hãy bắt đầu lại kết nối và chấp nhận yêu cầu của hệ thống.',
      'revoked_identity_device_limit':
          'Quyền truy cập VPN của thiết bị này đã bị xóa và đã đạt giới hạn thiết bị. Hãy xóa một thiết bị trong Tài khoản → Quản lý thiết bị của tôi.',
      'tunnel_start_unexpected':
          'Một lỗi không mong muốn đã làm gián đoạn quá trình chuẩn bị đường hầm. Hãy kiểm tra mã chẩn đoán và thử lại.',
      'flutter_disconnect_timeout':
          'Android không xác nhận kịp thời rằng VPN đã dừng. Hãy thử dừng lại.',
      'flutter_disconnect_unexpected':
          'Một lỗi không mong muốn khiến không thể xác nhận đường hầm đã dừng.',
      'device_revoked':
          'Quyền truy cập VPN của thiết bị đã bị thu hồi và các thông tin bí mật cục bộ đã bị xóa.',
      'revoke_unexpected':
          'Không thể xóa thiết bị. Hãy làm mới danh sách rồi thử lại.',
      'identity_renewal_unexpected':
          'Không thể tạo danh tính VPN mới. Hãy làm mới danh sách thiết bị rồi thử lại.',
      'openvpn_renewal_unexpected':
          'Không thể gia hạn hồ sơ OpenVPN. Hãy thử lại hoặc kiểm tra mã chẩn đoán.',
      'location_migration_blocked':
          'Máy chủ hiện không thể hoàn tất thay đổi này. Thiết bị và danh tính cục bộ của thiết bị vẫn được giữ lại.',
      'location_migration_slow':
          'Máy chủ vẫn đang chuẩn bị chuyển đến $target. Hãy dùng chức năng Tiếp tục sau ít phút.',
      'location_migration_conflict':
          'Trạng thái thiết bị đã thay đổi trên máy chủ. Hãy làm mới danh sách thiết bị rồi tiếp tục thay đổi.',
      'location_migration_verification_failed':
          'Máy chủ không xác nhận vị trí mới. Danh tính cục bộ trước đó vẫn được giữ lại.',
      'location_migration_device_changed':
          'Thiết bị do máy chủ trả về không còn khớp với thiết bị đang được thay đổi. Hãy làm mới danh sách thiết bị trước khi thử lại.',
      'tunnel_stop_failed':
          'Phải dừng hoàn toàn đường hầm trước đó trước khi tạo kết nối mới.',
      'other':
          'Không thể hoàn tất thao tác. Hãy thử lại hoặc gửi mã chẩn đoán cho bộ phận hỗ trợ.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Phiên đã hết hạn',
      'invalid_credentials': 'Đăng nhập thất bại',
      'email_verification_required': 'Cần xác nhận email',
      'verification_email_cooldown': 'Email đã được gửi',
      'rate_limited': 'Quá nhiều lần thử',
      'invalid_registration': 'Cần sửa thông tin',
      'email_exists': 'Tài khoản đã tồn tại',
      'invalid_profile': 'Hồ sơ không hợp lệ',
      'invalid_device': 'Thiết bị không hợp lệ',
      'invalid_location': 'Vị trí không khả dụng',
      'device_limit': 'Đã đạt giới hạn thiết bị',
      'device_exists': 'Danh tính VPN đã được sử dụng',
      'device_identity_revoked': 'Cần gia hạn danh tính VPN',
      'device_location_locked': 'Cần làm mới để thay đổi vị trí',
      'location_migration_pending': 'Đang thay đổi vị trí',
      'location_migration_blocked': 'Thay đổi vị trí bị chặn',
      'target_ca_mismatch': 'Máy chủ OpenVPN không tương thích',
      'location_migration_conflict': 'Cần làm mới để thay đổi vị trí',
      'server_full': 'Máy chủ đã đầy',
      'capacity_unavailable': 'Vị trí tạm thời không khả dụng',
      'target_unavailable': 'Máy chủ tạm thời không khả dụng',
      'not_found': 'Không tìm thấy mục',
      'invalid_openvpn_csr': 'Danh tính OpenVPN không hợp lệ',
      'openvpn_profile_exists': 'Hồ sơ OpenVPN đã tồn tại',
      'openvpn_profile_revoked': 'Hồ sơ OpenVPN đã bị thu hồi',
      'openvpn_operation_pending': 'Đang thực hiện thao tác OpenVPN',
      'openvpn_operation_terminal': 'Thao tác OpenVPN bị gián đoạn',
      'openvpn_address_unavailable': 'Địa chỉ OpenVPN không khả dụng',
      'openvpn_profile_conflict': 'Xung đột OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN không khả dụng',
      'email_delivery_unavailable': 'Email không khả dụng',
      'invalid_token': 'Liên kết không hợp lệ',
      'network_unavailable': 'Kết nối Internet không khả dụng',
      'invalid_json': 'Yêu cầu không hợp lệ',
      'invalid_api_response': 'Phản hồi máy chủ không hợp lệ',
      'ipv6_unavailable': 'IPv6 không khả dụng',
      'invalid_ip_families': 'Cấu hình mạng bị từ chối',
      'other': 'Dịch vụ không khả dụng',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Phiên của bạn đã hết hạn. Hãy đăng nhập lại.',
      'invalid_credentials': 'Địa chỉ email hoặc mật khẩu không chính xác.',
      'email_verification_required':
          'Hãy xác nhận địa chỉ email trước khi thêm thiết bị VPN.',
      'invalid_registration':
          'Hãy kiểm tra thông tin và các chấp thuận được yêu cầu.',
      'email_exists': 'Đã có tài khoản sử dụng địa chỉ email này.',
      'invalid_profile': 'Hãy kiểm tra thông tin hồ sơ của bạn.',
      'invalid_device':
          'Tên hoặc danh tính cục bộ của thiết bị này không hợp lệ.',
      'invalid_location': 'Hãy làm mới danh sách vị trí rồi thử lại.',
      'device_limit':
          'Hãy xóa một thiết bị hiện có trước khi thêm thiết bị khác.',
      'device_exists': 'Danh tính VPN này đã được liên kết với tài khoản khác.',
      'device_identity_revoked':
          'Danh tính này đã bị xóa. Phải tạo một danh tính cục bộ mới.',
      'device_location_locked':
          'Vị trí của thiết bị này vừa thay đổi. Ứng dụng sẽ tiếp tục quá trình đang diễn ra.',
      'location_migration_pending':
          'Một quá trình thay đổi vị trí đang diễn ra.',
      'location_migration_blocked':
          'Việc thay đổi vị trí cần máy chủ can thiệp. Hãy thử lại sau hoặc liên hệ bộ phận hỗ trợ.',
      'target_ca_mismatch':
          'Máy chủ này chưa tương thích với hồ sơ OpenVPN hiện tại.',
      'location_migration_conflict':
          'Hãy làm mới danh sách thiết bị rồi thử thay đổi vị trí lại.',
      'server_full':
          'Vị trí này đã đạt giới hạn kết nối. Hãy chọn vị trí khác hoặc thử lại sau.',
      'capacity_unavailable':
          'Hiện không thể xác nhận vị trí này có khả dụng hay không. Hãy chọn vị trí khác hoặc thử lại sau.',
      'target_unavailable': 'Máy chủ này tạm thời không khả dụng.',
      'not_found': 'Mục này không còn khả dụng trên tài khoản của bạn.',
      'invalid_openvpn_csr': 'Hãy tạo danh tính OpenVPN mới rồi thử lại.',
      'openvpn_profile_exists': 'Thiết bị này đã có hồ sơ OpenVPN.',
      'openvpn_profile_revoked': 'Hãy gia hạn hồ sơ OpenVPN để tiếp tục.',
      'openvpn_operation_pending':
          'Thay đổi vẫn đang được cập nhật. Hãy thử lại sau.',
      'openvpn_operation_terminal':
          'Hãy tạo danh tính OpenVPN mới rồi thử lại.',
      'openvpn_address_unavailable': 'Hiện không có địa chỉ OpenVPN khả dụng.',
      'openvpn_profile_conflict':
          'Hồ sơ đã thay đổi. Hãy làm mới danh sách thiết bị rồi thử lại.',
      'openvpn_signer_unavailable': 'Dịch vụ OpenVPN tạm thời không khả dụng.',
      'email_delivery_unavailable': 'Không thể gửi email. Hãy thử lại sau.',
      'invalid_token':
          'Liên kết này không hợp lệ hoặc đã hết hạn. Hãy yêu cầu liên kết mới.',
      'network_unavailable': 'Hãy kiểm tra kết nối Internet rồi thử lại.',
      'invalid_json': 'Hãy kiểm tra thông tin đã nhập rồi thử lại.',
      'invalid_api_response':
          'Máy chủ trả về phản hồi không mong đợi. Hãy thử lại sau.',
      'ipv6_unavailable':
          'Hiện máy chủ không thể kích hoạt IPv6. Hãy thử lại sau.',
      'invalid_ip_families':
          'Cấu hình đường hầm chưa hoàn chỉnh hoặc không khớp với các địa chỉ được cấp quyền. Hãy thử lại từ ứng dụng.',
      'other': 'Đã xảy ra lỗi máy chủ. Hãy thử lại sau.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Hãy thử lại sau ít phút.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Hãy thử lại sau $seconds giây.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Không thể tiếp tục VPN hệ thống',
      'system_vpn_resume_corrupt': 'Dữ liệu tiếp tục VPN hệ thống không hợp lệ',
      'system_vpn_resume_session_invalid': 'Phiên tiếp tục VPN không hợp lệ',
      'system_vpn_resume_identity_changed': 'Danh tính VPN đã thay đổi',
      'system_vpn_resume_identity_invalid':
          'Danh tính tiếp tục VPN không hợp lệ',
      'system_vpn_resume_storage_failed': 'Không có bộ nhớ tiếp tục VPN',
      'system_vpn_resume_network_timeout': 'VPN không có mạng để tiếp tục',
      'system_vpn_resume_blocked': 'Tiếp tục VPN bị chặn',
      'system_vpn_resume_failed': 'Tiếp tục VPN thất bại',
      'system_vpn_resume_error_invalid': 'Lỗi tiếp tục VPN không hợp lệ',
      'wireguard_identity_store_failed': 'Chưa lưu danh tính WireGuard',
      'wireguard_identity_unavailable': 'Danh tính WireGuard không khả dụng',
      'vpn_host_destroyed': 'Máy chủ VPN Android đã dừng',
      'vpn_host_unavailable': 'Máy chủ VPN Android không khả dụng',
      'vpn_permission_required': 'Cần cấp quyền VPN',
      'vpn_permission_denied': 'Quyền VPN bị từ chối',
      'vpn_permission_request_failed': 'Không thể yêu cầu quyền',
      'wireguard_foreground_service_unavailable':
          'Dịch vụ WireGuard không khả dụng',
      'wireguard_identity_invalid': 'Khóa WireGuard cục bộ không hợp lệ',
      'wireguard_identity_in_use': 'Danh tính WireGuard đang được sử dụng',
      'wireguard_configuration_invalid': 'Cấu hình WireGuard không hợp lệ',
      'wireguard_operation_pending': 'Thao tác WireGuard vẫn đang hoạt động',
      'wireguard_start_failed': 'WireGuard từ chối khởi động',
      'wireguard_stop_timeout': 'Chưa xác nhận WireGuard đã dừng',
      'wireguard_handshake_timeout': 'WireGuard không phản hồi',
      'openvpn_connection_timeout': 'OpenVPN không phản hồi',
      'openvpn_core_unavailable': 'Công cụ OpenVPN không khả dụng',
      'openvpn_operation_pending': 'Phiên OpenVPN vẫn đang hoạt động',
      'openvpn_stop_timeout': 'Chưa xác nhận OpenVPN đã dừng',
      'openvpn_profile_unavailable': 'Thiếu hồ sơ OpenVPN cục bộ',
      'openvpn_native_failed': 'Cuộc gọi OpenVPN gốc bị gián đoạn',
      'openvpn_key_generation_failed': 'Không thể tạo khóa OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Không thể tạo CSR OpenVPN',
      'openvpn_identity_store_failed': 'Chưa lưu danh tính OpenVPN',
      'openvpn_identity_clear_failed': 'Xóa danh tính OpenVPN chưa hoàn tất',
      'openvpn_identity_in_use': 'Danh tính OpenVPN vẫn đang được sử dụng',
      'openvpn_tls_verification_required': 'Thiếu xác minh TLS OpenVPN',
      'openvpn_cipher_invalid': 'Mật mã OpenVPN không hợp lệ',
      'openvpn_profile_rejected': 'Hồ sơ OpenVPN bị từ chối',
      'openvpn_identity_inconsistent': 'Danh tính OpenVPN không nhất quán',
      'tls_handshake_failed': 'Đàm phán OpenVPN bị từ chối',
      'tls_alert_unknown_ca':
          'Chứng chỉ máy khách OpenVPN không được nhận diện',
      'tls_alert_bad_certificate': 'Chứng chỉ máy khách OpenVPN bị từ chối',
      'tls_alert_unsupported_certificate':
          'Chứng chỉ OpenVPN không được hỗ trợ',
      'tls_client_certificate_required': 'Cần chứng chỉ máy khách OpenVPN',
      'tls_alert_misc': 'Cảnh báo TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Chữ ký OpenVPN không được hỗ trợ',
      'tls_handshake_rejected': 'Đàm phán TLS OpenVPN bị từ chối',
      'tls_version_rejected': 'Phiên bản TLS OpenVPN không tương thích',
      'tls_certificate_expired': 'Chứng chỉ TLS đã hết hạn',
      'tls_certificate_revoked': 'Chứng chỉ TLS đã bị thu hồi',
      'transport_failed': 'Không thể truy cập máy chủ OpenVPN',
      'tun_configuration_rejected': 'Không thể tạo giao diện OpenVPN',
      'tun_setup_failed': 'Thiết lập TUN OpenVPN thất bại',
      'tun_interface_create_failed': 'Tạo giao diện OpenVPN thất bại',
      'tun_interface_disabled': 'Giao diện OpenVPN bị vô hiệu hóa',
      'tun_halted': 'Giao diện OpenVPN bị gián đoạn',
      'tun_already_established': 'Giao diện OpenVPN đã mở',
      'tun_addresses_missing': 'Thiếu địa chỉ OpenVPN',
      'tun_routes_missing': 'Thiếu tuyến OpenVPN',
      'tun_dns_missing': 'Thiếu DNS OpenVPN',
      'tun_permission_revoked': 'Quyền VPN đã bị thu hồi',
      'tun_establish_returned_null': 'Android từ chối giao diện VPN',
      'openvpn_service_start_failed': 'Dịch vụ OpenVPN không khả dụng',
      'openvpn_operation_timeout': 'Cuộc gọi OpenVPN hết thời gian',
      'openvpn_start_failed': 'OpenVPN từ chối khởi động',
      'openvpn_connection_failed': 'Kết nối OpenVPN bị gián đoạn',
      'openvpn_core_status_error': 'OpenVPN Core kết thúc với lỗi',
      'openvpn_stopped_before_connected': 'OpenVPN dừng trước khi kết nối',
      'openvpn_auth_failed': 'Xác thực OpenVPN bị từ chối',
      'openvpn_client_setup_failed': 'Thiết lập máy khách OpenVPN thất bại',
      'openvpn_client_halted': 'Máy khách OpenVPN bị gián đoạn',
      'openvpn_client_restart': 'Đã yêu cầu khởi động lại OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN không hoạt động quá lâu',
      'openvpn_session_expired': 'Phiên OpenVPN đã hết hạn',
      'openvpn_credentials_required': 'Xác thực OpenVPN không được hỗ trợ',
      'openvpn_proxy_failed': 'Truyền qua trung gian OpenVPN thất bại',
      'openvpn_compression_failed': 'Nén OpenVPN bị từ chối',
      'openvpn_ntlm_crypto_unavailable': 'Mã hóa NTLM OpenVPN không khả dụng',
      'openvpn_feature_unsupported': 'Tính năng OpenVPN không được hỗ trợ',
      'network_unavailable': 'Kết nối Internet không khả dụng',
      'network_lost': 'Mạng không khả dụng',
      'certificate_validation_failed': 'Chứng chỉ máy chủ bị từ chối',
      'openvpn_certificate_expired': 'Chứng chỉ OpenVPN đã hết hạn',
      'tunnel_active_for_another_account':
          'Đường hầm của tài khoản khác vẫn đang hoạt động',
      'tunnel_already_active': 'Đường hầm gốc đã hoạt động',
      'tunnel_stop_timeout': 'Chưa xác nhận $protocol đã dừng',
      'tunnel_disconnected': '$protocol bị gián đoạn',
      'native_bridge_unavailable': 'Cầu nối Android không khả dụng',
      'native_operation_failed': 'Thao tác Android bị gián đoạn',
      'invalid_arguments': 'Tham số VPN chưa đầy đủ',
      'invalid_account_id': 'Tài khoản VPN không hợp lệ',
      'invalid_device_id': 'Mã nhận diện thiết bị không hợp lệ',
      'storage_key_not_allowed': 'Khóa bộ nhớ bị từ chối',
      'secure_storage_read_failed': 'Đọc bộ nhớ bảo mật thất bại',
      'secure_storage_write_failed': 'Ghi bộ nhớ bảo mật thất bại',
      'key_generation_failed': 'Không thể tạo khóa WireGuard',
      'csr_generation_failed': 'Không thể tạo CSR OpenVPN',
      'other': 'Lỗi VPN gốc chưa được phân loại',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android không tìm thấy phiên VPN có thể tiếp tục. Hãy bắt đầu kết nối mới trong ứng dụng.',
      'system_vpn_resume_corrupt':
          'Dữ liệu tiếp tục VPN đã lưu không hợp lệ và sẽ không được sử dụng. Hãy bắt đầu kết nối mới.',
      'system_vpn_resume_session_invalid':
          'Phiên đã lưu không thể tiếp tục VPN nữa. Hãy đăng nhập lại trong ứng dụng.',
      'system_vpn_resume_identity_changed':
          'Danh tính VPN cục bộ đã thay đổi. Đã dừng việc tiếp tục; hãy bắt đầu kết nối mới.',
      'system_vpn_resume_identity_invalid':
          'Danh tính dùng để tiếp tục không hợp lệ. Hãy bắt đầu kết nối mới.',
      'system_vpn_resume_storage_failed':
          'Android không thể đọc hoặc cập nhật dữ liệu tiếp tục đã mã hóa. Hãy bắt đầu kết nối mới.',
      'system_vpn_resume_network_timeout':
          'Android không tìm thấy mạng kịp thời để tiếp tục VPN. Hãy thử lại khi có mạng.',
      'system_vpn_resume_blocked':
          'Tiếp tục VPN bị chặn. Hãy kiểm tra cài đặt Android rồi bắt đầu kết nối mới.',
      'system_vpn_resume_failed':
          'Tiếp tục VPN Android thất bại. Hãy bắt đầu kết nối mới trong ứng dụng.',
      'system_vpn_resume_error_invalid':
          'Android trả về lỗi tiếp tục không thể sử dụng. Hãy bắt đầu kết nối mới.',
      'wireguard_identity_store_failed':
          'Android không thể lưu danh tính WireGuard đã mã hóa của tài khoản này.',
      'wireguard_identity_unavailable':
          'Không có danh tính WireGuard khả dụng cho kết nối này.',
      'vpn_host_destroyed':
          'Thành phần Android lưu trữ VPN đã dừng. Hãy bắt đầu kết nối mới.',
      'vpn_host_unavailable':
          'Android không thể tạo thành phần lưu trữ VPN. Hãy kiểm tra cài đặt VPN rồi thử lại.',
      'openvpn_renewal_required':
          'Chứng chỉ cần được xử lý trong ứng dụng trước khi kết nối.',
      'openvpn_recovery_failed':
          'Khôi phục tự động thất bại. Hãy bắt đầu kết nối mới trong ứng dụng.',
      'openvpn_recovery_exhausted':
          'Khôi phục tự động đã được sử dụng. Hãy bắt đầu kết nối mới trong ứng dụng.',
      'vpn_permission_required':
          'Android yêu cầu cấp quyền VPN mới trước khi bắt đầu đường hầm.',
      'vpn_permission_denied':
          'Hãy cho phép FuzeVPN trong yêu cầu của Android để tiếp tục.',
      'vpn_permission_request_failed':
          'Android không thể mở màn hình cấp quyền VPN.',
      'wireguard_foreground_service_unavailable':
          'Android không thể duy trì dịch vụ WireGuard ở chế độ nền trước.',
      'wireguard_identity_invalid':
          'Khóa WireGuard đã mã hóa của tài khoản này không thể đọc hoặc không hợp lệ.',
      'wireguard_identity_in_use':
          'Thao tác khác vẫn đang sử dụng khóa WireGuard của tài khoản này.',
      'wireguard_configuration_invalid':
          'Địa chỉ WireGuard, DNS, khóa máy chủ hoặc tuyến nhận được không hợp lệ.',
      'wireguard_operation_pending':
          'Thao tác WireGuard trước đó chưa giải phóng dịch vụ gốc.',
      'wireguard_start_failed': 'Công cụ WireGuard từ chối kích hoạt cấu hình.',
      'wireguard_stop_timeout':
          'Dịch vụ WireGuard không xác nhận giải phóng giao diện VPN trong thời hạn.',
      'wireguard_handshake_timeout':
          'Đường hầm không xác nhận bắt tay với máy chủ kịp thời.',
      'openvpn_connection_timeout':
          'OpenVPN không xác nhận kết nối với máy chủ kịp thời.',
      'openvpn_core_unavailable':
          'Phiên bản ứng dụng này không có công cụ OpenVPN khả dụng.',
      'openvpn_operation_pending':
          'Công cụ gốc vẫn giữ phiên OpenVPN trước đó và từ chối tạo phiên thứ hai.',
      'openvpn_stop_timeout':
          'OpenVPN Core không xác nhận phiên gốc đã dừng và bị hủy trong thời hạn.',
      'openvpn_profile_unavailable':
          'Không thể đọc hồ sơ OpenVPN đã xác thực cho kết nối này.',
      'openvpn_native_failed':
          'Lỗi ứng dụng đã làm gián đoạn OpenVPN. Hãy thử kết nối lại. Nếu sự cố tiếp diễn, hãy chạy chẩn đoán.',
      'openvpn_key_generation_failed':
          'Android Keystore không thể tạo hoặc đọc khóa riêng P-256 không thể xuất.',
      'openvpn_csr_generation_failed':
          'Khóa Android Keystore không thể ký yêu cầu chứng chỉ OpenVPN.',
      'openvpn_identity_store_failed':
          'Không thể lưu chứng chỉ hoặc hồ sơ OpenVPN trong bộ nhớ đã mã hóa.',
      'openvpn_identity_clear_failed':
          'Android không thể xóa toàn bộ danh tính OpenVPN cục bộ của tài khoản này.',
      'openvpn_identity_in_use':
          'Một phiên OpenVPN gốc vẫn đang sử dụng khóa hoặc chứng chỉ của thiết bị này.',
      'openvpn_tls_verification_required':
          'Hồ sơ không yêu cầu rõ ràng việc xác minh chứng chỉ máy chủ.',
      'openvpn_cipher_invalid':
          'Máy chủ cung cấp thuật toán mã hóa không nằm trong danh sách cho phép.',
      'openvpn_profile_rejected':
          'Hồ sơ nhận từ máy chủ không tương thích. Hãy tạo lại thiết bị rồi thử lại.',
      'openvpn_identity_inconsistent':
          'Chứng chỉ không khớp với danh tính bảo mật của điện thoại này. Không thay thế hồ sơ cục bộ.',
      'tls_handshake_failed':
          'Máy chủ từ chối đàm phán TLS. Hãy tạo lại hồ sơ nếu sự cố vẫn tiếp diễn.',
      'tls_alert_unknown_ca':
          'Máy chủ không nhận diện cơ quan cấp chứng chỉ thiết bị này. Cần kiểm tra máy chủ OpenVPN.',
      'tls_alert_bad_certificate':
          'Máy chủ từ chối chứng chỉ thiết bị này. Hãy tạo lại thiết bị trước khi thử lại.',
      'tls_alert_unsupported_certificate':
          'Máy chủ không hỗ trợ loại chứng chỉ bảo mật Android đang sử dụng.',
      'tls_client_certificate_required':
          'Máy chủ yêu cầu chứng chỉ máy khách nhưng OpenVPN Core không thể cung cấp.',
      'tls_alert_misc':
          'Máy chủ trả về cảnh báo TLS ngoài các nhóm chứng chỉ và phiên bản.',
      'tls_signature_algorithm_rejected':
          'Máy chủ từ chối thuật toán ECDSA P-256 của khóa Android Keystore.',
      'tls_handshake_rejected':
          'Máy chủ đã gián đoạn đàm phán TLS trước khi kết nối.',
      'tls_version_rejected':
          'Máy khách và máy chủ không tìm thấy phiên bản TLS chung.',
      'tls_certificate_expired':
          'Chứng chỉ được cung cấp khi kết nối đã hết hạn.',
      'tls_certificate_revoked':
          'Chứng chỉ được cung cấp khi kết nối đã bị thu hồi.',
      'transport_failed':
          'Máy chủ OpenVPN không phản hồi trên mạng hiện tại. Hãy thử lại sau ít phút.',
      'tun_configuration_rejected':
          'Android từ chối cấu hình mạng mà OpenVPN yêu cầu.',
      'tun_setup_failed':
          'OpenVPN Core từ chối kế hoạch mạng trước khi tạo giao diện Android.',
      'tun_interface_create_failed':
          'OpenVPN Core không thể lấy giao diện TUN từ Android VpnService.',
      'tun_interface_disabled':
          'Android hoặc OpenVPN Core đã vô hiệu hóa giao diện TUN trong khi kết nối.',
      'tun_halted': 'OpenVPN Core nhận được yêu cầu dừng giao diện TUN.',
      'tun_already_established':
          'OpenVPN yêu cầu giao diện thứ hai trong cùng kết nối. Đường hầm đã dừng để đảm bảo an toàn.',
      'tun_addresses_missing':
          'Máy chủ không cung cấp địa chỉ đường hầm có thể sử dụng.',
      'tun_routes_missing':
          'Máy chủ không cung cấp tuyến đường hầm có thể sử dụng.',
      'tun_dns_missing': 'Máy chủ không cung cấp máy chủ DNS có thể sử dụng.',
      'tun_permission_revoked':
          'Android đã thu hồi quyền VPN trong khi kết nối.',
      'tun_establish_returned_null':
          'Android không tạo giao diện, thường do một VPN khác vẫn đang hoạt động.',
      'openvpn_service_start_failed':
          'Android không thể khởi động dịch vụ OpenVPN ở chế độ nền trước.',
      'openvpn_operation_timeout':
          'Cuộc gọi JNI đến OpenVPN Core vượt quá thời lượng tối đa.',
      'openvpn_start_failed':
          'Dịch vụ Android đã sẵn sàng nhưng OpenVPN Core không chấp nhận khởi động hồ sơ.',
      'openvpn_connection_failed':
          'OpenVPN Core dừng trước khi phát sự kiện CONNECTED.',
      'openvpn_core_status_error':
          'Vòng lặp OpenVPN gốc kết thúc với lỗi và không có sự kiện kết thúc cụ thể hơn.',
      'openvpn_stopped_before_connected':
          'Vòng lặp OpenVPN gốc dừng trước CONNECTED mà không có lỗi Core rõ ràng.',
      'openvpn_auth_failed': 'Máy chủ OpenVPN từ chối xác thực hồ sơ.',
      'openvpn_client_setup_failed':
          'OpenVPN Core không thể khởi tạo máy khách trước khi kết nối mạng.',
      'openvpn_client_halted':
          'OpenVPN Core nhận được yêu cầu dừng máy khách cuối cùng.',
      'openvpn_client_restart':
          'OpenVPN Core yêu cầu khởi động lại phiên truyền tải.',
      'openvpn_inactive_timeout':
          'OpenVPN Core đóng phiên sau thời gian không hoạt động.',
      'openvpn_session_expired': 'Máy chủ báo phiên OpenVPN đã hết hạn.',
      'openvpn_credentials_required':
          'Máy chủ hoặc proxy yêu cầu thông tin xác thực tương tác không có trong hồ sơ chứng chỉ này.',
      'openvpn_proxy_failed':
          'OpenVPN Core báo lỗi proxy hoặc bộ chuyển tiếp đã cấu hình.',
      'openvpn_compression_failed':
          'OpenVPN Core từ chối chế độ nén do hồ sơ hoặc máy chủ công bố.',
      'openvpn_ntlm_crypto_unavailable':
          'Hồ sơ yêu cầu mã hóa NTLM không khả dụng trong phiên bản này.',
      'openvpn_feature_unsupported':
          'Hồ sơ hoặc máy chủ yêu cầu tính năng không có trong máy khách Android này.',
      'network_unavailable': 'Không có mạng vật lý khả dụng.',
      'network_lost': 'Đường hầm đã dừng sau khi mất mạng.',
      'certificate_validation_failed':
          'Không thể xác minh danh tính máy chủ OpenVPN.',
      'openvpn_certificate_expired':
          'Hãy gia hạn hồ sơ OpenVPN trước khi kết nối lại.',
      'tunnel_active_for_another_account':
          'Đường hầm của tài khoản khác phải dừng trước kết nối này.',
      'tunnel_already_active':
          'Android báo một phiên VPN trước đó vẫn đang sử dụng giao diện.',
      'tunnel_stop_timeout':
          'Công cụ $protocol không xác nhận giải phóng giao diện VPN trong thời hạn.',
      'tunnel_disconnected':
          'Công cụ gốc báo đường hầm kết thúc bất ngờ sau khi khởi động.',
      'native_bridge_unavailable':
          'Ứng dụng không thể truy cập dịch vụ VPN Android. Hãy đóng và mở lại ứng dụng rồi thử lại.',
      'native_operation_failed':
          'Lỗi ứng dụng đã làm gián đoạn thao tác VPN. Hãy thử lại. Nếu sự cố tiếp diễn, hãy chạy chẩn đoán.',
      'invalid_arguments':
          'Thông tin cần cho thao tác VPN này chưa đầy đủ. Hãy thử lại. Nếu sự cố tiếp diễn, hãy chạy chẩn đoán.',
      'invalid_account_id': 'Thao tác gốc không gắn với mã tài khoản hợp lệ.',
      'invalid_device_id':
          'Mã nhận diện thiết bị gửi đến công cụ gốc bị thiếu hoặc không hợp lệ.',
      'storage_key_not_allowed':
          'Cầu nối Android đã chặn khóa nằm ngoài danh sách bộ nhớ cho phép.',
      'secure_storage_read_failed':
          'Android Keystore không thể giải mã dữ liệu cục bộ của tài khoản này.',
      'secure_storage_write_failed':
          'Android Keystore không thể mã hóa hoặc lưu dữ liệu cục bộ.',
      'key_generation_failed':
          'Android không thể tạo hoặc đọc khóa WireGuard trong bộ nhớ bảo mật.',
      'csr_generation_failed':
          'Android Keystore không thể tạo hoặc ký CSR OpenVPN P-256.',
      'other':
          'Một nhánh gốc chưa được ghi nhận đã thất bại. Hãy gửi mã chẩn đoán bên dưới cho bộ phận hỗ trợ.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Yêu cầu cấp quyền đã được mở';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Yêu cầu cấp quyền VPN của Android đang hiển thị. Hãy hoàn tất yêu cầu trước khi thử lại.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Yêu cầu cấp quyền VPN bị gián đoạn';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Màn hình cấp quyền VPN đã đóng trước khi ứng dụng nhận được phản hồi.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Chưa xác nhận kết nối OpenVPN';

  @override
  String get notice_openvpnProofMissing_message =>
      'Không thể xác nhận kết nối OpenVPN. Kết nối đã được dừng để đảm bảo an toàn. Hãy thử lại.';

  @override
  String get openvpnCleanup_title => 'Hồ sơ OpenVPN đã bị thu hồi';

  @override
  String get openvpnCleanup_working =>
      'Đang dừng và xóa hồ sơ OpenVPN đã bị thu hồi…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Chưa xác nhận việc tắt OpenVPN. Hãy thử lại trước khi tạo hồ sơ mới.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Không thể xóa hoàn toàn hồ sơ OpenVPN đã bị thu hồi. Hãy thử dọn dẹp lại.';

  @override
  String get openvpnCleanup_complete =>
      'Đã xóa hồ sơ OpenVPN bị thu hồi. Nhấn Kết nối để tạo hồ sơ mới.';

  @override
  String get network_title => 'Cấu hình mạng';

  @override
  String get network_ipv4Fallback =>
      'IPv6 tạm thời không khả dụng. Tiếp tục chuẩn bị bằng IPv4.';

  @override
  String get network_rejectedTitle => 'Cấu hình mạng bị từ chối';

  @override
  String get network_rejectedMessage =>
      'Cấu hình đường hầm chưa hoàn chỉnh hoặc không khớp với các địa chỉ được cấp quyền. Hãy thử lại từ ứng dụng.';

  @override
  String get network_unreadableTitle => 'Không thể đọc cấu hình cục bộ';

  @override
  String get network_unreadableMessage =>
      'Không thể sử dụng cấu hình mạng OpenVPN đã lưu. Hãy kết nối lại từ ứng dụng để cập nhật cấu hình.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Bảo vệ mạng';

  @override
  String get protection_subtitle =>
      'Chặn truy cập Internet trực tiếp nếu VPN bị ngắt kết nối.';

  @override
  String get protection_active => 'Bảo vệ hệ thống đang hoạt động';

  @override
  String get protection_alwaysOnOnly =>
      'VPN luôn bật đã được bật; bật chặn kết nối bên ngoài VPN';

  @override
  String get protection_inactive => 'Bảo vệ hệ thống không hoạt động';

  @override
  String get protection_unknown => 'Kiểm tra bảo vệ hệ thống';

  @override
  String get protection_openSettings => 'Mở cài đặt Android';

  @override
  String get protection_dialogTitle => 'Thiết lập bảo vệ mạng';

  @override
  String get protection_dialogMessage =>
      'Android quản lý VPN luôn bật và việc chặn các kết nối bên ngoài VPN. Hãy kiểm tra FuzeVPN đã được chọn và bật tính năng chặn trong cài đặt hệ thống.';

  @override
  String get protection_dialogOpen => 'Mở cài đặt';

  @override
  String get session_systemProtectionNote =>
      'Nếu Android vẫn đang chặn lưu lượng bên ngoài VPN, hãy mở cài đặt hệ thống để kiểm tra hoặc thay đổi chế độ bảo vệ này.';

  @override
  String get diagnostics_title => 'Chẩn đoán';

  @override
  String get diagnostics_settingsTitle => 'Chẩn đoán ứng dụng';

  @override
  String get diagnostics_automaticTitle => 'Gửi lỗi quan trọng';

  @override
  String get diagnostics_automaticDescription =>
      'Chia sẻ một báo cáo kỹ thuật ngắn khi xảy ra lỗi quan trọng.';

  @override
  String get diagnostics_privacy =>
      'Các báo cáo đã gửi được liên kết với tài khoản đang đăng nhập và được lưu trong 30 ngày. Báo cáo không chứa lịch sử duyệt web, mật khẩu hoặc khóa VPN.';

  @override
  String get diagnostics_manualOpen => 'Chạy chẩn đoán';

  @override
  String get diagnostics_localDescription =>
      'Tạo báo cáo về trạng thái ứng dụng và VPN. Kết nối của bạn không thay đổi.';

  @override
  String get diagnostics_sendReport => 'Gửi báo cáo';

  @override
  String get diagnostics_sendHint =>
      'Bỏ chọn ô này để giữ báo cáo trên thiết bị.';

  @override
  String get diagnostics_signedOut => 'Đăng nhập vào tài khoản để gửi báo cáo.';

  @override
  String get diagnostics_localLifetime =>
      'Lưu báo cáo này trên điện thoại để giữ lại sau khi đóng ứng dụng.';

  @override
  String get diagnostics_run => 'Chạy chẩn đoán';

  @override
  String get diagnostics_rerun => 'Chạy lại chẩn đoán';

  @override
  String get diagnostics_running => 'Đang kiểm tra…';

  @override
  String get diagnostics_sending => 'Đang gửi báo cáo…';

  @override
  String get diagnostics_prepared => 'Báo cáo đã sẵn sàng trên thiết bị này';

  @override
  String get diagnostics_queued => 'Báo cáo đang chờ được gửi';

  @override
  String get diagnostics_sent => 'Đã nhận báo cáo';

  @override
  String get diagnostics_failed =>
      'Gửi thất bại. Báo cáo cục bộ của bạn vẫn khả dụng.';

  @override
  String get diagnostics_preparationFailed =>
      'Không thể chuẩn bị báo cáo chẩn đoán. Hãy thử lại.';

  @override
  String get diagnostics_authenticationRequired =>
      'Đăng nhập lại để gửi báo cáo.';

  @override
  String get diagnostics_retry => 'Thử gửi lại';

  @override
  String get diagnostics_export => 'Lưu báo cáo';

  @override
  String get diagnostics_exportFailed =>
      'Xuất thất bại. Hãy thử lại từ báo cáo cục bộ.';

  @override
  String get diagnostics_preferenceFailed =>
      'Không thể lưu cài đặt này. Hãy thử lại.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Mã tham chiếu: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Đã nhận vào $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Được giữ đến $date';
  }

  @override
  String get diagnostics_duplicate => 'Báo cáo này đã được nhận trước đó.';

  @override
  String get diagnostics_preview => 'Xem trước báo cáo';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã đính kèm $count sự kiện kỹ thuật',
      one: 'Đã đính kèm 1 sự kiện kỹ thuật',
      zero: 'Không có sự kiện kỹ thuật nào được đính kèm',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Chi tiết kỹ thuật';

  @override
  String get diagnostics_empty =>
      'Chưa có báo cáo chẩn đoán nào được chuẩn bị.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Trạng thái đường hầm',
      'handshake': 'Xác nhận kết nối',
      'certificate': 'Chứng chỉ VPN',
      'kill_switch': 'Bảo vệ Android',
      'connectivity': 'Mạng khả dụng',
      'api_reachability': 'Truy cập dịch vụ',
      'secure_storage': 'Bộ nhớ bảo mật',
      'other': 'Kiểm tra cục bộ',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Đã kiểm tra',
      'failed': 'Cần chú ý',
      'skipped': 'Chưa kiểm tra — không có phép thăm dò đang hoạt động',
      'unknown': 'Không có thông tin',
      'other': 'Không có thông tin',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Chào mừng đến với FuzeVPN';

  @override
  String get connection_changeLocation => 'Thay đổi vị trí';

  @override
  String get connection_details => 'Chi tiết kết nối';

  @override
  String get locations_searchLabel => 'Tìm kiếm thành phố hoặc quốc gia';

  @override
  String get locations_clearSearch => 'Xóa tìm kiếm';

  @override
  String get locations_filterAll => 'Tất cả';

  @override
  String get locations_filterFavorites => 'Yêu thích';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vị trí',
      one: '$count vị trí',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Không tìm thấy vị trí nào';

  @override
  String get locations_noResultsHint => 'Hãy thử thành phố hoặc quốc gia khác.';

  @override
  String get locations_noFavorites =>
      'Mục yêu thích của bạn, luôn trong tầm tay';

  @override
  String get locations_noFavoritesHint =>
      'Nhấn vào ngôi sao bên cạnh một vị trí để lưu vị trí đó tại đây.';

  @override
  String get locations_showAll => 'Xem tất cả vị trí';

  @override
  String locations_addFavorite(String name) {
    return 'Thêm $name vào mục yêu thích';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Xóa $name khỏi mục yêu thích';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Không thể lưu mục yêu thích. Hãy thử lại.';

  @override
  String get locations_emptyTitle => 'Không có vị trí nào khả dụng';

  @override
  String get locations_emptyHint => 'Làm mới danh sách để thử lại.';

  @override
  String get devices_manage => 'Quản lý thiết bị của tôi';

  @override
  String get settings_personalization => 'Tùy chỉnh theo ý bạn';

  @override
  String get settings_safety => 'Bảo vệ';

  @override
  String get settings_help => 'Cần trợ giúp?';

  @override
  String get settings_about => 'Giới thiệu về FuzeVPN';

  @override
  String get diagnostics_heading => 'Tìm hiểu sự cố kết nối';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Khả dụng',
      'pending': 'Đang chuẩn bị',
      'revoked': 'Đã xóa',
      'expired': 'Đã hết hạn',
      'other': 'Không có trạng thái',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Chưa lưu tùy chọn';

  @override
  String get notice_preferenceSave_message =>
      'Lựa chọn của bạn hiện đã được áp dụng nhưng không thể lưu. Hãy thử lại để giữ lựa chọn sau khi đóng ứng dụng.';

  @override
  String get connection_androidDisconnectHint =>
      'Nếu Android vẫn giữ VPN hoạt động, hãy tắt VPN luôn bật trong phần cài đặt được mở.';

  @override
  String get protection_learnMore => 'Tìm hiểu về bảo vệ Android';

  @override
  String get protection_guideWhy =>
      'Chế độ bảo vệ này ngăn các ứng dụng sử dụng Internet trực tiếp nếu VPN bị ngắt kết nối. Chế độ này được cấu hình trong Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN luôn bật';

  @override
  String get protection_guideAlwaysOn =>
      'Android giữ dịch vụ VPN hoạt động và có thể khởi động lại dịch vụ sau khi điện thoại khởi động lại.';

  @override
  String get protection_guideBlockTitle => 'Chặn kết nối không qua VPN';

  @override
  String get protection_guideBlock =>
      'Cài đặt này ngăn lưu lượng bỏ qua VPN, kể cả khi kết nối bị gián đoạn.';

  @override
  String get protection_guideWarning =>
      'Khi bật chế độ chặn này, truy cập Internet sẽ bị tắt cho đến khi VPN được kết nối.';

  @override
  String get protection_guideStepsTitle => 'Bật bảo vệ';

  @override
  String get protection_guideStep1 =>
      'Mở cài đặt VPN của Android bằng nút bên dưới.';

  @override
  String get protection_guideStep2 =>
      'Mở các tùy chọn bằng biểu tượng bánh răng bên cạnh FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Bật VPN luôn bật, sau đó bật Chặn kết nối không qua VPN nếu các tùy chọn này khả dụng.';

  @override
  String get protection_guideManufacturers =>
      'Tên gọi khác nhau tùy điện thoại. Nếu cần, hãy tìm VPN trong Cài đặt, thường nằm dưới mục Mạng và Internet.';

  @override
  String get protection_guideDisableTitle => 'Tắt chế độ bảo vệ này';

  @override
  String get protection_guideDisable =>
      'Trong cùng phần cài đặt, hãy tắt chế độ chặn kết nối không qua VPN để cho phép truy cập Internet khi không có VPN. Đồng thời tắt VPN luôn bật nếu bạn không muốn Android khởi động lại VPN.';

  @override
  String get protection_guideManual =>
      'Bạn tự chọn các cài đặt này trong Android. FuzeVPN không thay đổi chúng thay bạn.';

  @override
  String get locations_changeTitle => 'Thay đổi vị trí?';

  @override
  String locations_changeActive(String name) {
    return 'VPN sẽ ngắt kết nối, sau đó cố gắng kết nối với $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN sẽ cố gắng kết nối với $name.';
  }

  @override
  String get locations_confirmChange => 'Thay đổi và kết nối';

  @override
  String get locations_changeBusy =>
      'Một quá trình thay đổi đang diễn ra. Hãy chờ trước khi chọn vị trí khác.';

  @override
  String get locations_automaticSelection => 'Tự động chọn';

  @override
  String get locations_cities => 'Thành phố';

  @override
  String get locations_servers => 'Máy chủ';

  @override
  String locations_viewCities(String name) {
    return 'Xem các thành phố tại $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Xem các máy chủ tại $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quốc gia',
      one: '$count quốc gia',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count thành phố',
      one: '$count thành phố',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count máy chủ',
      one: '$count máy chủ',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Tất cả quốc gia';

  @override
  String get locations_backToCountries => 'Quay lại danh sách quốc gia';

  @override
  String locations_backToCities(String name) {
    return 'Quay lại các thành phố tại $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Chọn $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Chọn $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Không có máy chủ tương thích nào khả dụng.';

  @override
  String get externalLink_failed =>
      'Không thể mở liên kết này. Bạn có thể sao chép và mở liên kết trong trình duyệt.';

  @override
  String get externalLink_copy => 'Sao chép liên kết';

  @override
  String get externalLink_copied => 'Đã sao chép liên kết';

  @override
  String get externalLink_copyFailed =>
      'Không thể sao chép liên kết. Hãy chọn địa chỉ bên dưới.';

  @override
  String get settings_deleteAccount => 'Xóa tài khoản của tôi';

  @override
  String get settings_deleteAccountDetail => 'Xem cách yêu cầu xóa tài khoản';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Chọn gói đăng ký VPN của bạn.';

  @override
  String get billing_subscribe => 'Đăng ký';

  @override
  String get billing_choosePlan => 'Chọn một gói để tiếp tục.';

  @override
  String get billing_monthly => 'Hằng tháng';

  @override
  String get billing_yearly => 'Hằng năm';

  @override
  String get billing_continue => 'Tiếp tục với Google Play';

  @override
  String get billing_restore => 'Khôi phục giao dịch mua';

  @override
  String get billing_manage => 'Quản lý gói đăng ký';

  @override
  String get billing_deleteAccountWarning =>
      'Nếu bạn có gói đăng ký qua Google Play, việc xóa tài khoản FuzeVPN sẽ không hủy việc gia hạn gói đăng ký đó. Hãy quản lý hoặc hủy gia hạn riêng trong Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Tiếp tục đến yêu cầu xóa tài khoản';

  @override
  String get billing_refresh => 'Làm mới quyền truy cập';

  @override
  String get billing_loadingPlans => 'Đang tải các gói…';

  @override
  String get billing_unavailable =>
      'Hiện chưa có gói nào. Vui lòng thử lại sau.';

  @override
  String get billing_comingSoon => 'Các gói đăng ký sẽ sớm có mặt.';

  @override
  String get billing_priceDisclosure =>
      'Giá do Google Play cung cấp. Tổng tiền cuối cùng và thuế áp dụng được xác nhận trước khi bạn xác nhận.';

  @override
  String get billing_renewalMonthly =>
      'Tự động gia hạn mỗi tháng nếu không hủy. Bạn có thể hủy bất kỳ lúc nào trong mục gói đăng ký Google Play.';

  @override
  String get billing_renewalYearly =>
      'Tự động gia hạn mỗi năm nếu không hủy. Bạn có thể hủy bất kỳ lúc nào trong mục gói đăng ký Google Play.';

  @override
  String get billing_active => 'Quyền truy cập Premium đang hoạt động';

  @override
  String billing_accessUntil(String date) {
    return 'Truy cập đến $date.';
  }

  @override
  String get billing_webManaged =>
      'Gói đăng ký của bạn được quản lý trên trang web FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Gói đăng ký của bạn được quản lý qua Google Play.';

  @override
  String get billing_inactive => 'Không có gói đăng ký đang hoạt động.';

  @override
  String get billing_checkingAccess => 'Đang kiểm tra quyền truy cập…';

  @override
  String get billing_restoring => 'Đang khôi phục giao dịch mua…';

  @override
  String get billing_pending =>
      'Thanh toán đang chờ xử lý. Quyền truy cập sẽ được kích hoạt sau khi xác nhận.';

  @override
  String get billing_cancelled =>
      'Đã hủy giao dịch mua. Không có gói đăng ký mới nào được kích hoạt.';

  @override
  String get billing_verifying => 'Đang xác minh giao dịch mua…';

  @override
  String get billing_success =>
      'Đã kích hoạt gói đăng ký. Bạn có thể sử dụng Premium.';

  @override
  String get billing_restored => 'Các giao dịch mua đã được khôi phục.';

  @override
  String get billing_restoreEmpty =>
      'Không có giao dịch mua cần khôi phục cho tài khoản Google Play này.';

  @override
  String get billing_catalogError => 'Không thể tải các gói. Vui lòng thử lại.';

  @override
  String get billing_purchaseError =>
      'Không thể bắt đầu giao dịch mua. Vui lòng thử lại.';

  @override
  String get billing_verificationError =>
      'Tạm thời không thể xác minh giao dịch mua. Khôi phục giao dịch mua để thử lại.';

  @override
  String get billing_restoreError =>
      'Không thể khôi phục giao dịch mua. Vui lòng thử lại.';

  @override
  String get billing_managementError =>
      'Không thể mở phần quản lý gói đăng ký. Vui lòng thử lại.';

  @override
  String get billing_storeUnavailable =>
      'Google Play không khả dụng trên thiết bị này.';

  @override
  String get welcome_title => 'VPN của bạn, thật đơn giản.';

  @override
  String get welcome_description =>
      'Bảo vệ kết nối. Chủ động kiểm soát quyền riêng tư.';

  @override
  String get welcome_start => 'Bắt đầu';

  @override
  String get welcome_alreadyPurchased => 'Đã mua rồi?';

  @override
  String get welcome_noAccountRequired => 'Không cần tạo tài khoản để bắt đầu.';

  @override
  String get guest_accountTitle => 'Tài khoản chưa liên kết';

  @override
  String get guest_accountDescription =>
      'Khôi phục giao dịch mua bằng cùng tài khoản Google Play để dùng gói đăng ký trên thiết bị khác.';

  @override
  String get guest_existingSubscriberSignIn => 'Đã đăng ký gói? Đăng nhập';

  @override
  String get guest_claimTitle => 'Mang FuzeVPN theo bạn';

  @override
  String get guest_claimDescription =>
      'Tạo tài khoản để truy cập gói đăng ký trên các thiết bị khác. Bước này không bắt buộc.';

  @override
  String get guest_skip => 'Để sau';

  @override
  String get guest_activationTitle => 'Fuze Premium đã được kích hoạt';

  @override
  String get guest_activationDescription =>
      'Gói đăng ký của bạn đã sẵn sàng. Hãy dùng VPN và tạo tài khoản bất cứ lúc nào.';

  @override
  String get guest_useVpn => 'Dùng VPN của tôi';

  @override
  String get guest_loginRequired =>
      'Giao dịch mua này đã liên kết với một tài khoản FuzeVPN. Đăng nhập vào tài khoản đó để truy cập gói đăng ký.';

  @override
  String get guest_signOutWarning =>
      'Bạn có thể khôi phục gói đăng ký bằng cách khôi phục giao dịch mua bằng cùng tài khoản Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Tài khoản của bạn đã được liên kết. Đăng nhập để xem và quản lý thông tin.';

  @override
  String get billing_acceptance =>
      'Bằng việc tiếp tục, bạn chấp nhận Điều khoản sử dụng và Chính sách quyền riêng tư.';

  @override
  String get guest_verifyEmailReminder =>
      'Xác nhận địa chỉ email để bảo vệ tài khoản. Bạn vẫn có thể tiếp tục dùng VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Dịch vụ tạm thời không khả dụng. Vui lòng thử lại sau ít phút.';

  @override
  String get guest_restoreError =>
      'Không thể khôi phục giao dịch mua. Hãy thử lại với tài khoản Google Play đã dùng để mua.';

  @override
  String get guest_claimSuccess =>
      'Tài khoản đã được tạo. Gói đăng ký và quyền truy cập VPN của bạn được giữ nguyên.';

  @override
  String get guest_emailExists =>
      'Email này đã được sử dụng. Chọn địa chỉ khác hoặc đăng nhập vào tài khoản hiện có. Giao dịch mua vẫn khả dụng qua Google Play.';

  @override
  String get guest_claimError =>
      'Không thể tạo tài khoản. Bạn có thể tiếp tục dùng VPN và thử lại sau.';

  @override
  String get guest_secureStorageError =>
      'Không thể lưu phiên một cách an toàn trên thiết bị này. Vui lòng thử lại.';

  @override
  String get guest_premiumRequired => 'Chọn một gói đăng ký để kích hoạt VPN.';

  @override
  String get welcome_viewPlans => 'Xem các gói';

  @override
  String get google_continue => 'Tiếp tục với Google';

  @override
  String get google_or => 'hoặc';

  @override
  String get google_title => 'Tài khoản FuzeVPN của bạn';

  @override
  String get google_settingUp => 'Hoàn tất tài khoản';

  @override
  String get google_country => 'Quốc gia cư trú';

  @override
  String get google_profileDescription =>
      'Chọn quốc gia và đọc cả hai tài liệu để tạo tài khoản FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Liên kết tài khoản khách với Google. Gói đăng ký và thiết bị vẫn thuộc tài khoản này.';

  @override
  String get google_linkTitle => 'Liên kết Google với FuzeVPN';

  @override
  String get google_linkDescription =>
      'Xác nhận quyền truy cập tài khoản FuzeVPN hiện có. Không yêu cầu mật khẩu Google.';

  @override
  String get google_password => 'Mật khẩu FuzeVPN';

  @override
  String get google_linkAccount => 'Xác nhận liên kết';

  @override
  String get google_requestEmail => 'Nhận email xác nhận';

  @override
  String get google_emailInstructions =>
      'Mở email FuzeVPN và nhập mã xác nhận.';

  @override
  String get google_emailCode => 'Mã xác nhận qua email';

  @override
  String get google_confirmEmail => 'Xác nhận mã';

  @override
  String get google_restart => 'Chọn tài khoản Google khác';

  @override
  String get google_resume => 'Kiểm tra lần thử này';

  @override
  String get google_unavailable =>
      'Đăng nhập Google không khả dụng. Bạn có thể dùng email và mật khẩu.';

  @override
  String get google_expired => 'Lần thử này đã hết hạn. Hủy rồi bắt đầu lại.';

  @override
  String get google_conflict =>
      'Tài khoản Google này đã liên kết với tài khoản khác. Tài khoản và gói đăng ký hiện tại được giữ nguyên.';

  @override
  String get google_error =>
      'Đăng nhập Google thất bại. Thử lại; quyền truy cập hiện tại được giữ nguyên.';

  @override
  String get google_uncertain =>
      'Chưa thể xác nhận kết quả. Kiểm tra lần thử này hoặc hủy trước khi bắt đầu lại.';

  @override
  String get google_cancelFailed =>
      'Chưa thể xác nhận việc hủy. Thử hủy lại trước khi rời màn hình này.';

  @override
  String get google_cancelled => 'Đã hủy đăng nhập Google.';

  @override
  String get google_selecting => 'Chọn tài khoản Google…';

  @override
  String get google_verifying => 'Đang kiểm tra tài khoản…';

  @override
  String get google_emailUnavailable =>
      'Không thể gửi email xác nhận. Thử lại sau.';

  @override
  String get google_emailSent => 'Đã gửi email xác nhận. Kiểm tra hộp thư đến.';

  @override
  String get google_rateLimited => 'Vui lòng đợi trước khi thử lại.';

  @override
  String get google_invalidPassword =>
      'Mật khẩu FuzeVPN không đúng. Tài khoản hiện tại được giữ nguyên.';

  @override
  String get google_invalidCode => 'Mã xác nhận không hợp lệ hoặc đã hết hạn.';

  @override
  String get google_accountChanged =>
      'Phiên đã thay đổi. Hủy lần thử này trước khi bắt đầu lại.';

  @override
  String get google_invalidResponse =>
      'Không thể xác thực phản hồi. Quyền truy cập hiện tại được giữ nguyên.';

  @override
  String get google_invalidRegistration =>
      'Kiểm tra quốc gia và cả hai sự đồng ý.';

  @override
  String get google_consentRequired =>
      'Chọn quốc gia và chấp nhận cả hai tài liệu để tiếp tục.';

  @override
  String get google_challengeRequired =>
      'Cần kiểm tra bảo mật bổ sung. Quyền truy cập hiện tại được giữ nguyên.';

  @override
  String get google_challengeUnavailable =>
      'Kiểm tra bảo mật không khả dụng. Thử lại sau.';

  @override
  String get billing_trialTitle => 'Dùng thử Fuze Premium miễn phí';

  @override
  String get billing_trialSubtitle => 'Bảo vệ kết nối của bạn ngay hôm nay.';

  @override
  String get billing_trialWeeks => 'Dùng thử miễn phí 2 tuần';

  @override
  String billing_trialDays(String days) {
    return 'Dùng thử miễn phí $days ngày';
  }

  @override
  String get billing_trialStart => 'Bắt đầu dùng thử miễn phí';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Nếu bắt đầu hôm nay, khoản thanh toán đầu tiên dự kiến vào $date.';
  }

  @override
  String get billing_trialTerms =>
      'Tự động gia hạn theo giá đã hiển thị. Để tránh bị tính phí, hãy hủy trên Google Play trước khi hết thời gian dùng thử.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Sau đó $price mỗi tháng';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Sau đó $price mỗi năm';
  }

  @override
  String get billing_choosePeriod => 'Chọn gói của bạn';

  @override
  String get billing_selectionHint => 'Chọn một gói để tiếp tục.';

  @override
  String get billing_benefitConnection => 'Kết nối được mã hóa';

  @override
  String get billing_benefitPrivacy => 'Quyền riêng tư trực tuyến';

  @override
  String get billing_benefitNoAccount => 'Không bắt buộc đăng ký tài khoản';

  @override
  String get billing_cancellation => 'Hủy trên Google Play';

  @override
  String get billing_premiumTitle => 'Kết nối của bạn được bảo vệ tốt hơn.';

  @override
  String get billing_premiumSubtitle => 'Bảo vệ kết nối theo nhu cầu của bạn.';

  @override
  String get billing_priceMonthly => 'mỗi tháng';

  @override
  String get billing_priceYearly => 'mỗi năm';

  @override
  String get billing_trialToday => 'Hôm nay không phải thanh toán';

  @override
  String get billing_trialConfirmation =>
      'Google Play xác nhận ngày, tổng tiền cuối cùng và thuế áp dụng trước khi bạn xác nhận.';

  @override
  String get billing_offerChanged =>
      'Điều kiện của ưu đãi này đã thay đổi. Tải lại các gói và chọn lại.';
}
